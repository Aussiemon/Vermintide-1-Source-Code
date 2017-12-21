ActionAim = class(ActionAim)
ActionAim.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.first_person_unit = first_person_unit
	self.is_server = is_server
	self.world = world
	self.item_name = item_name

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	if ScriptUnit.has_extension(weapon_unit, "spread_system") then
		self.spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")
	end

	return 
end
ActionAim.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	self.zoom_condition_function = new_action.zoom_condition_function
	self.played_aim_sound = false
	self.aim_sound_time = t + (new_action.aim_sound_delay or 0)
	self.aim_zoom_time = t + (new_action.aim_zoom_delay or 0)
	local spread_template_override = new_action.spread_template_override

	if spread_template_override then
		self.spread_extension:override_spread_template(spread_template_override)
	end

	local owner = Managers.player:owner(self.owner_unit)

	if Managers.input:is_device_active("gamepad") and owner.is_player_controlled(owner) and Application.user_setting("gamepad_auto_aim_enabled") then
		local range = 60
		local distance_bias = 0.6
		local angle_bias = distance_bias - 1

		assert(distance_bias + angle_bias == 1, "[ActionAim] distance_bias + angle_bias always have to equal 1.0")

		local first_person_ext = ScriptUnit.extension(self.owner_unit, "first_person_system")
		local current_position = first_person_ext.current_position(first_person_ext)
		local current_direction = first_person_ext.current_rotation(first_person_ext)
		local fwd_dir = Quaternion.forward(current_direction)
		local physics_world = World.physics_world(self.world)
		local unit = PhysicsWorld.find_best_unit_in_cone(physics_world, first_person_ext.current_position(first_person_ext), fwd_dir, range*range, math.degrees_to_radians(10), distance_bias, angle_bias)

		if AiUtils.unit_alive(unit) then
			local node_index = (Unit.has_node(unit, "j_hips") and Unit.node(unit, "j_hips")) or 0
			local dir = Unit.world_position(unit, node_index) - current_position
			local distance = Vector3.length(dir)

			if distance < 4 then
				return 
			end

			local hit = PhysicsWorld.immediate_raycast(physics_world, current_position, Vector3.normalize(dir), distance, "closest", "collision_filter", "filter_ai_line_of_sight_check")

			if not hit then
				ScriptUnit.extension(self.owner_unit, "first_person_system"):set_aim_assist_unit(unit, "j_hips", 5)
			end
		end
	end

	return 
end
ActionAim.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action
	local owner_unit = self.owner_unit

	if not self.zoom_condition_function or self.zoom_condition_function() then
		local status_extension = ScriptUnit.extension(owner_unit, "status_system")
		local input_extension = ScriptUnit.extension(owner_unit, "input_system")
		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")

		if not status_extension.is_zooming(status_extension) and self.aim_zoom_time <= t then
			status_extension.set_zooming(status_extension, true, current_action.default_zoom)
		end

		if buff_extension.has_buff_type(buff_extension, "increased_zoom") and status_extension.is_zooming(status_extension) and input_extension.get(input_extension, "action_three") then
			status_extension.switch_variable_zoom(status_extension, current_action.buffed_zoom_thresholds)
		elseif current_action.zoom_thresholds and status_extension.is_zooming(status_extension) and input_extension.get(input_extension, "action_three") then
			status_extension.switch_variable_zoom(status_extension, current_action.zoom_thresholds)
		end
	end

	if not self.played_aim_sound and self.aim_sound_time <= t then
		local sound_event = current_action.aim_sound_event

		if sound_event then
			local wwise_world = Managers.world:wwise_world(self.world)

			WwiseWorld.trigger_event(wwise_world, sound_event)
		end

		self.played_aim_sound = true
	end

	return 
end
ActionAim.finish = function (self, reason)
	local current_action = self.current_action
	local ammo_extension = self.ammo_extension
	local owner_unit = self.owner_unit
	local unzoom_condition_function = current_action.unzoom_condition_function

	if not unzoom_condition_function or unzoom_condition_function(reason) then
		local status_extension = ScriptUnit.extension(owner_unit, "status_system")

		status_extension.set_zooming(status_extension, false)
	end

	if ammo_extension and ammo_extension.can_reload(ammo_extension) and ammo_extension.ammo_count(ammo_extension) == 0 and current_action.reload_when_out_of_ammo then
		local play_reload_animation = true

		ammo_extension.start_reload(ammo_extension, play_reload_animation)
	end

	if self.spread_extension then
		self.spread_extension:reset_spread_template()
	end

	local sound_event = current_action.unaim_sound_event

	if sound_event then
		local wwise_world = Managers.world:wwise_world(self.world)

		WwiseWorld.trigger_event(wwise_world, sound_event)
	end

	local owner = Managers.player:owner(self.owner_unit)

	if owner.is_player_controlled(owner) then
		ScriptUnit.extension(self.owner_unit, "first_person_system"):set_aim_assist_unit(nil)
	end

	return 
end

return 
