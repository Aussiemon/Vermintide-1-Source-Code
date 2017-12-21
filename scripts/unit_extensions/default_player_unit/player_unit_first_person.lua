PlayerUnitFirstPerson = class(PlayerUnitFirstPerson)
PlayerUnitFirstPerson.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.unit = unit
	local profile = extension_init_data.profile
	self.profile = profile
	local unit_name = profile.base_units.first_person
	local attachment_unit_name = profile.first_person_attachment.unit
	local attachment_node_linking = profile.first_person_attachment.attachment_node_linking
	local unit_spawner = Managers.state.unit_spawner
	local fp_unit = unit_spawner.spawn_local_unit(unit_spawner, unit_name)
	self.first_person_unit = fp_unit

	Unit.set_flow_variable(fp_unit, "character_vo", profile.character_vo)
	Unit.set_flow_variable(fp_unit, "sound_character", profile.sound_character)
	Unit.flow_event(fp_unit, "character_vo_set")

	self.first_person_attachment_unit = unit_spawner.spawn_local_unit(unit_spawner, attachment_unit_name)

	AttachmentUtils.link(extension_init_context.world, self.first_person_unit, self.first_person_attachment_unit, attachment_node_linking)
	Unit.set_unit_visibility(self.unit, false)

	self.first_person_mode = true
	self.look_position = Vector3Box(Unit.local_position(unit, 0))
	self.look_rotation = QuaternionBox(Unit.local_rotation(unit, 0))
	self.forced_look_rotation = nil
	self.forced_lerp_time = nil

	Unit.set_local_position(self.first_person_unit, 0, Unit.local_position(unit, 0))
	Unit.set_local_rotation(self.first_person_unit, 0, Unit.local_rotation(unit, 0))

	self.look_delta = nil
	self.player_height_wanted = self._player_height_from_name(self, "stand")
	self.player_height_current = self.player_height_wanted
	self.player_height_previous = self.player_height_wanted
	self.player_height_time_to_change = 0.001
	self.player_height_change_start_time = 0
	self.hide_weapon_reasons = {}
	self.hide_weapon_lights_reasons = {}
	local small_delta = math.pi/15
	self.MAX_MIN_PITCH = math.pi/2 - small_delta
	self.drawer = Managers.state.debug:drawer({
		mode = "immediate",
		name = "PlayerUnitFirstPerson"
	})
	self._disable_head_bob = false

	return 
end
PlayerUnitFirstPerson.reset = function (self)
	return 
end
PlayerUnitFirstPerson.extensions_ready = function (self)
	self.locomotion_extension = ScriptUnit.extension(self.unit, "locomotion_system")
	self.inventory_extension = ScriptUnit.extension(self.unit, "inventory_system")
	self.attachment_extension = ScriptUnit.extension(self.unit, "attachment_system")

	if script_data.debug_third_person then
		self.set_first_person_mode(self, false)
	end

	return 
end
PlayerUnitFirstPerson.destroy = function (self)
	local unit_spawner = Managers.state.unit_spawner

	unit_spawner.mark_for_deletion(unit_spawner, self.first_person_unit)
	unit_spawner.mark_for_deletion(unit_spawner, self.first_person_attachment_unit)

	return 
end
PlayerUnitFirstPerson.update = function (self, unit, input, dt, context, t)
	self.update_player_height(self, t)
	self.update_rotation(self, t, dt)
	self.update_position(self)

	local player = Managers.player:owner(unit)
	local disable_head_bob = Application.user_setting("disable_head_bob")

	if self._disable_head_bob and not disable_head_bob then
		Unit.animation_event(self.first_person_unit, "enable_headbob")

		self._disable_head_bob = false
	elseif not self._disable_head_bob and disable_head_bob then
		Unit.animation_event(self.first_person_unit, "disable_headbob")

		self._disable_head_bob = true
	end

	if player and Managers.state.debug.free_flight_manager:active(player.local_player_id(player)) and self.first_person_mode then
		self.set_first_person_mode(self, false)

		self.free_flight_changed_fp_mode = true
	elseif player and not Managers.state.debug.free_flight_manager:active(player.local_player_id(player)) and self.free_flight_changed_fp_mode then
		self.set_first_person_mode(self, true)

		self.free_flight_changed_fp_mode = false
	end

	if self.toggle_visibility_timer and self.toggle_visibility_timer <= t then
		self.toggle_visibility_timer = nil

		self.set_first_person_mode(self, not self.first_person_mode)
	end

	return 
end

local function ease_out_quad(t, b, c, d)
	t = t/d
	local res = -c*t*(t - 2) + b

	return res
end

PlayerUnitFirstPerson.update_player_height = function (self, t)
	local time_changing_height = t - self.player_height_change_start_time

	if time_changing_height < self.player_height_time_to_change then
		self.player_height_current = ease_out_quad(time_changing_height, self.player_height_previous, self.player_height_wanted - self.player_height_previous, self.player_height_time_to_change)
	else
		self.player_height_current = self.player_height_wanted
	end

	if script_data.camera_debug then
		Debug.text("self.player_height_wanted = " .. tostring(self.player_height_wanted))
		Debug.text("self.player_height_current = " .. tostring(self.player_height_current))
		Debug.text("self.player_height_previous = " .. tostring(self.player_height_previous))
		Debug.text("self.player_height_time_to_change = " .. tostring(self.player_height_time_to_change))
		Debug.text("self.player_height_change_start_time = " .. tostring(self.player_height_change_start_time))
		Debug.text("time_changing_height = " .. tostring(time_changing_height))
	end

	return 
end
PlayerUnitFirstPerson.set_rotation = function (self, new_rotation)
	Unit.set_local_rotation(self.first_person_unit, 0, new_rotation)
	Unit.set_local_rotation(self.unit, 0, new_rotation)
	self.look_rotation:store(new_rotation)

	return 
end
PlayerUnitFirstPerson.force_look_rotation = function (self, rot, total_lerp_time)
	self.forced_look_rotation = QuaternionBox(rot)
	self.forced_lerp_timer = 0

	return 
end
PlayerUnitFirstPerson.set_aim_assist_unit = function (self, unit, node, total_lerp_time)
	if AiUtils.unit_alive(unit) then
		self._aim_assist_unit = unit
		self._aim_assist_node_index = (Unit.has_node(unit, node) and Unit.node(unit, node)) or 0
		self._aim_assist_lerp_timer = self._aim_assist_lerp_timer or 0
		self._aim_assist_lerp_time = total_lerp_time or 0.3
	else
		self._aim_assist_unit = nil
		self._aim_assist_lerp_timer = nil
		self._aim_assist_node_index = nil
		self._aim_assist_lerp_time = nil
		self.look_delta = nil
	end

	return 
end
PlayerUnitFirstPerson.update_rotation = function (self, t, dt)
	local first_person_unit = self.first_person_unit

	if self._aim_assist_unit then
		local input_manager = Managers.input
		local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
		local input_service = input_manager.get_service(input_manager, "Player")
		local look = input_service.get(input_service, "look_raw_controller")

		if not AiUtils.unit_alive(self._aim_assist_unit) or not gamepad_active or 0.5625 < Vector3.length_squared(look) then
			self._aim_assist_unit = nil
			self._aim_assist_lerp_timer = nil
			self._aim_assist_node_index = nil
			self._aim_assist_lerp_time = nil
		end
	end

	if Bulldozer.rift then
		local new_rotation = Oculus.get_orientation(Bulldozer.rift_info.hmd_device)

		Unit.set_local_rotation(first_person_unit, 0, new_rotation)
	elseif self._aim_assist_unit ~= nil then
		local total_lerp_time = self._aim_assist_lerp_time
		self._aim_assist_lerp_timer = self._aim_assist_lerp_timer + dt
		local p = math.clamp(self._aim_assist_lerp_timer/total_lerp_time, 0, 1) - 1
		p = p - 1
		local aim_assist_unit_pos = Unit.world_position(self._aim_assist_unit, self._aim_assist_node_index)
		local current_position = self.current_position(self)
		local aim_assist_rotation = Quaternion.look(aim_assist_unit_pos - current_position, Vector3.up())
		local look_rotation = Quaternion.lerp(self.look_rotation:unbox(), aim_assist_rotation, p)
		local yaw = Quaternion.yaw(look_rotation)
		local pitch = math.clamp(Quaternion.pitch(look_rotation), -self.MAX_MIN_PITCH, self.MAX_MIN_PITCH)
		local roll = Quaternion.roll(look_rotation)
		local yaw_rotation = Quaternion(Vector3.up(), yaw)
		local pitch_rotation = Quaternion(Vector3.right(), pitch)
		local roll_rotation = Quaternion(Vector3.forward(), roll)
		local yaw_pitch_rotation = Quaternion.multiply(yaw_rotation, pitch_rotation)
		look_rotation = Quaternion.multiply(yaw_pitch_rotation, roll_rotation)

		self.look_rotation:store(look_rotation)
		Unit.set_local_rotation(first_person_unit, 0, look_rotation)
	elseif self.forced_look_rotation ~= nil then
		local total_lerp_time = self.forced_total_lerp_time or 0.3
		self.forced_lerp_timer = self.forced_lerp_timer + dt
		local p = self.forced_lerp_timer/total_lerp_time - 1
		p = p*p - 1
		local look_rotation = Quaternion.lerp(self.look_rotation:unbox(), self.forced_look_rotation:unbox(), p)
		local yaw = Quaternion.yaw(look_rotation)
		local pitch = math.clamp(Quaternion.pitch(look_rotation), -self.MAX_MIN_PITCH, self.MAX_MIN_PITCH)
		local roll = Quaternion.roll(look_rotation)
		local yaw_rotation = Quaternion(Vector3.up(), yaw)
		local pitch_rotation = Quaternion(Vector3.right(), pitch)
		local roll_rotation = Quaternion(Vector3.forward(), roll)
		local yaw_pitch_rotation = Quaternion.multiply(yaw_rotation, pitch_rotation)
		look_rotation = Quaternion.multiply(yaw_pitch_rotation, roll_rotation)

		self.look_rotation:store(look_rotation)

		local first_person_unit = self.first_person_unit

		Unit.set_local_rotation(first_person_unit, 0, look_rotation)

		if total_lerp_time <= self.forced_lerp_timer then
			self.look_delta = nil
			self.forced_look_rotation = nil
			self.forced_lerp_time = nil
		end
	elseif self.look_delta ~= nil then
		local rotation = self.look_rotation:unbox()
		local look_delta = self.look_delta
		self.look_delta = nil
		local yaw = Quaternion.yaw(rotation) - look_delta.x
		local pitch = math.clamp(Quaternion.pitch(rotation) + look_delta.y, -self.MAX_MIN_PITCH, self.MAX_MIN_PITCH)
		local yaw_rotation = Quaternion(Vector3.up(), yaw)
		local pitch_rotation = Quaternion(Vector3.right(), pitch)
		local look_rotation = Quaternion.multiply(yaw_rotation, pitch_rotation)

		self.look_rotation:store(look_rotation)

		local first_person_unit = self.first_person_unit

		Unit.set_local_rotation(first_person_unit, 0, look_rotation)
	end

	return 
end
PlayerUnitFirstPerson.update_position = function (self)
	local position_root = Unit.local_position(self.unit, 0)
	local offset_height = Vector3(0, 0, self.player_height_current)
	local position = position_root + offset_height

	Unit.set_local_position(self.first_person_unit, 0, position)

	return 
end
PlayerUnitFirstPerson.is_in_view = function (self, position)
	local player = Managers.player:owner(self.unit)
	local viewport_name = player.viewport_name

	Managers.state.camera:is_in_view(viewport_name, position)

	return 
end
PlayerUnitFirstPerson.is_within_default_view = function (self, position)
	local player = Managers.player:owner(self.unit)
	local viewport_name = player.viewport_name
	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local camera_position = ScriptCamera.position(camera)
	local camera_rotation = ScriptCamera.rotation(camera)
	local camera_forward = Quaternion.forward(camera_rotation)
	local to_pos_dir = Vector3.normalize(position - camera_position)
	local dot = Vector3.dot(to_pos_dir, camera_forward)
	local is_infront = 0 < dot

	if is_infront then
		local base_vertical_fov_rad = (CameraSettings.first_person._node.vertical_fov*math.pi)/180
		local base_horizontal_fov_rad = base_vertical_fov_rad*1.7777777777777777
		local camera_right = Quaternion.right(camera_rotation)
		local camera_up = Quaternion.up(camera_rotation)
		local c_x = Vector3.dot(to_pos_dir, camera_right)
		local c_y = dot
		local c_z = Vector3.dot(to_pos_dir, camera_up)
		local dot_xy = c_y
		local c_to_pos_dir_length_xy = math.sqrt(c_x*c_x + c_y*c_y)

		if c_to_pos_dir_length_xy == 0 then
			return false
		end

		local cos_xy = dot_xy/c_to_pos_dir_length_xy
		local yaw = math.acos(cos_xy)

		if yaw <= base_horizontal_fov_rad/2 then
			local dot_uz = c_to_pos_dir_length_xy
			local to_pos_dir_length_uz = math.sqrt(c_to_pos_dir_length_xy*c_to_pos_dir_length_xy + c_z*c_z)
			local cos_uz = dot_uz/to_pos_dir_length_uz
			local pitch = math.acos(cos_uz)

			if pitch <= base_vertical_fov_rad/2 then
				return true
			end

			return false
		end
	end

	return false
end
PlayerUnitFirstPerson.apply_recoil = function (self)
	local player = Managers.player:owner(self.unit)
	local viewport_name = player.viewport_name
	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local camera_rotation = ScriptCamera.rotation(camera)

	Unit.set_local_rotation(self.first_person_unit, 0, camera_rotation)
	self.look_rotation:store(camera_rotation)

	return 
end
PlayerUnitFirstPerson.get_first_person_unit = function (self)
	return self.first_person_unit
end
PlayerUnitFirstPerson.get_first_person_mesh_unit = function (self)
	return self.first_person_attachment_unit
end
PlayerUnitFirstPerson.set_look_delta = function (self, look_delta)
	self.look_delta = look_delta

	return 
end
PlayerUnitFirstPerson.play_animation_event = function (self, anim_event)
	Unit.animation_event(self.first_person_unit, anim_event)

	return 
end
PlayerUnitFirstPerson.current_rotation = function (self)
	return Unit.local_rotation(self.first_person_unit, 0)
end
PlayerUnitFirstPerson.current_position = function (self)
	return Unit.local_position(self.first_person_unit, 0)
end
PlayerUnitFirstPerson.set_wanted_player_height = function (self, state, t, time_to_change)
	local player_height_wanted = self._player_height_from_name(self, state)
	local player_height_movement_speed = 3
	self.player_height_wanted = player_height_wanted
	self.player_height_previous = self.player_height_current

	if time_to_change == nil then
		time_to_change = math.abs(player_height_wanted - self.player_height_previous)/player_height_movement_speed
		time_to_change = math.clamp(time_to_change, 0.001, 1000)
	end

	self.player_height_time_to_change = time_to_change
	self.player_height_change_start_time = t

	return 
end
PlayerUnitFirstPerson._player_height_from_name = function (self, name)
	local profile = self.profile

	return profile.first_person_heights[name]
end
PlayerUnitFirstPerson.toggle_visibility = function (self, delay)
	local t = Managers.time:time("game")

	if self.toggle_visibility_timer then
		self.set_first_person_mode(self, not self.first_person_mode)
	end

	if delay then
		self.toggle_visibility_timer = t + delay
	else
		self.set_first_person_mode(self, not self.first_person_mode)
	end

	return 
end
PlayerUnitFirstPerson.set_first_person_mode = function (self, active)
	if not self.debug_first_person_mode then
		Unit.set_unit_visibility(self.unit, not active)
		Unit.set_unit_visibility(self.first_person_attachment_unit, active)

		if self.toggle_visibility_timer then
			self.toggle_visibility_timer = nil
		end

		if active then
			self.unhide_weapons(self, "third_person_mode")
		else
			self.hide_weapons(self, "third_person_mode", true)
		end

		self.inventory_extension:show_third_person_inventory(not active)
		self.attachment_extension:show_attachments(not active)
	end

	self.first_person_mode = active

	return 
end
PlayerUnitFirstPerson.debug_set_first_person_mode = function (self, active, override)
	local first_person_mode = self.first_person_mode

	if active then
		self.debug_first_person_mode = false

		self.set_first_person_mode(self, override)

		self.first_person_mode = first_person_mode
		self.debug_first_person_mode = true
	else
		self.debug_first_person_mode = false

		self.set_first_person_mode(self, first_person_mode)
	end

	return 
end
PlayerUnitFirstPerson.hide_weapons = function (self, reason, hide_lights)
	self.hide_weapon_reasons[reason] = true

	if not table.is_empty(self.hide_weapon_reasons) then
		self.inventory_extension:show_first_person_inventory(false)
	end

	if hide_lights then
		self.hide_weapon_lights_reasons[reason] = true

		if not table.is_empty(self.hide_weapon_lights_reasons) then
			self.inventory_extension:show_first_person_inventory_lights(false)
		end
	end

	return 
end
PlayerUnitFirstPerson.unhide_weapons = function (self, reason)
	self.hide_weapon_reasons[reason] = nil
	self.hide_weapon_lights_reasons[reason] = nil

	if table.is_empty(self.hide_weapon_reasons) then
		self.inventory_extension:show_first_person_inventory(true)
	end

	if table.is_empty(self.hide_weapon_lights_reasons) then
		self.inventory_extension:show_first_person_inventory_lights(true)
	end

	return 
end
PlayerUnitFirstPerson.animation_set_variable = function (self, variable_name, value)
	local variable = Unit.animation_find_variable(self.first_person_unit, variable_name)

	Unit.animation_set_variable(self.first_person_unit, variable, value)

	return 
end
PlayerUnitFirstPerson.animation_event = function (self, event)
	Unit.animation_event(self.first_person_unit, event)

	return 
end
PlayerUnitFirstPerson.create_screen_particles = function (self, name, pos, ...)
	return World.create_particles(self.world, name, pos or Vector3.zero(), ...)
end
PlayerUnitFirstPerson.destroy_screen_particles = function (self, id)
	World.destroy_particles(world, id)

	return 
end
PlayerUnitFirstPerson.play_hud_sound_event = function (self, event, wwise_source_id, play_on_husk)
	local wwise_world = Managers.world:wwise_world(self.world)

	if play_on_husk and not LEVEL_EDITOR_TEST then
		local network_manager = Managers.state.network
		local network_transmit = network_manager.network_transmit
		local is_server = Managers.player.is_server
		local unit_id = network_manager.unit_game_object_id(network_manager, self.unit)
		local event_id = NetworkLookup.sound_events[event]

		if is_server then
			network_transmit.send_rpc_clients(network_transmit, "rpc_play_husk_sound_event", unit_id, event_id)
		else
			network_transmit.send_rpc_server(network_transmit, "rpc_play_husk_sound_event", unit_id, event_id)
		end
	end

	if wwise_source_id then
		local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, event, wwise_source_id)

		return wwise_playing_id, wwise_source_id
	else
		local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, event)

		return wwise_playing_id, wwise_source_id
	end

	return 
end
PlayerUnitFirstPerson.play_sound_event = function (self, event, position)
	local sound_position = position or self.current_position(self)
	local wwise_source_id, wwise_world = WwiseUtils.make_position_auto_source(self.world, sound_position)

	WwiseWorld.set_switch(wwise_world, "husk", "false", wwise_source_id)
	WwiseWorld.trigger_event(wwise_world, event, wwise_source_id)

	return 
end
PlayerUnitFirstPerson.play_camera_effect_sequence = function (self, event, t)
	Managers.state.camera:camera_effect_sequence_event(event, t)

	return 
end

return 