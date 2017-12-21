require("scripts/unit_extensions/weapons/projectiles/true_flight_templates")

ActionTrueFlightBowAim = class(ActionTrueFlightBowAim)
ActionTrueFlightBowAim.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.world = world
	self.wwise_world = Managers.world:wwise_world(world)

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	self.first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

	return 
end
ActionTrueFlightBowAim.client_owner_start_action = function (self, new_action, t, chain_action_data)
	self.current_action = new_action
	self.aim_timer = 0.35
	self.target = nil
	self.aimed_target = nil
	self.overcharge_timer = 0
	self.zoom_condition_function = new_action.zoom_condition_function
	self.played_aim_sound = false
	self.aim_sound_time = t + (new_action.aim_sound_delay or 0)
	self.aim_zoom_time = t + (new_action.aim_zoom_delay or 0)
	self.charge_ready_sound_event = self.current_action.charge_ready_sound_event

	if chain_action_data then
		self.charge_value = chain_action_data.charge_level or 0
	else
		self.charge_value = 0
	end

	local owner_unit = self.owner_unit
	local owner_player = Managers.player:owner(owner_unit)
	local is_bot = owner_player and owner_player.bot_player

	if not is_bot then
		local charge_sound_name = new_action.charge_sound_name

		if charge_sound_name then
			local wwise_playing_id, wwise_source_id = ActionUtils.start_charge_sound(self.wwise_world, self.weapon_unit, new_action)
			self.charging_sound_id = wwise_playing_id
			self.wwise_source_id = wwise_source_id
		end
	end

	return 
end
ActionTrueFlightBowAim.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action
	local owner_unit = self.owner_unit
	local overcharge_extension = self.overcharge_extension

	if current_action.overcharge_interval then
		self.overcharge_timer = self.overcharge_timer + dt

		if current_action.overcharge_interval <= self.overcharge_timer then
			if self.overcharge_extension then
				self.overcharge_extension:add_charge(current_action.overcharge_type)
			end

			self.overcharge_timer = 0
		end
	end

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
			local wwise_world = self.wwise_world

			WwiseWorld.trigger_event(wwise_world, sound_event)
		end

		self.played_aim_sound = true
	end

	if 0.3 <= self.aim_timer then
		local physics_world = World.get_data(world, "physics_world")
		local owner_unit = self.owner_unit
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local player_rotation = first_person_extension.current_rotation(first_person_extension)
		local player_position = first_person_extension.current_position(first_person_extension)
		local direction = Vector3.normalize(Quaternion.forward(player_rotation))

		PhysicsWorld.prepare_actors_for_raycast(physics_world, player_position, Quaternion.forward(player_rotation), 0.01, 9)

		local results = PhysicsWorld.immediate_raycast(physics_world, player_position, direction, "all", "collision_filter", "filter_ray_true_flight")
		local hit_unit = nil

		if results then
			local num_results = #results

			for i = 1, num_results, 1 do
				local result = results[i]
				local hit_actor = result[4]

				if hit_actor then
					local aim_at_unit = Actor.unit(hit_actor)

					if hit_actor ~= Unit.actor(aim_at_unit, "c_afro") then
						local unit = Actor.unit(hit_actor)

						if ScriptUnit.has_extension(unit, "health_system") then
							local health_extension = ScriptUnit.extension(unit, "health_system")

							if health_extension.is_alive(health_extension) then
								hit_unit = unit

								break
							end
						end
					end
				end
			end
		end

		local current_target = self.target

		if self.aimed_target ~= hit_unit then
			self.aimed_target = hit_unit
			self.aim_timer = 0.2
		elseif Unit.alive(self.aimed_target) and current_target ~= hit_unit then
			if ScriptUnit.has_extension(hit_unit, "outline_system") then
				local outline_extension = ScriptUnit.extension(hit_unit, "outline_system")

				outline_extension.set_method("always")
			end

			if Unit.alive(current_target) and ScriptUnit.has_extension(current_target, "outline_system") then
				local outline_extension = ScriptUnit.extension(current_target, "outline_system")

				outline_extension.set_method("never")
			end

			self.target = hit_unit
		end
	end

	local owner_unit = self.owner_unit
	local owner_player = Managers.player:owner(owner_unit)
	local is_bot = owner_player and owner_player.bot_player

	if not is_bot then
		local charge_sound_parameter_name = current_action.charge_sound_parameter_name

		if charge_sound_parameter_name then
			local wwise_world = self.wwise_world
			local wwise_source_id = self.wwise_source_id

			WwiseWorld.set_source_parameter(wwise_world, wwise_source_id, charge_sound_parameter_name, charge_level)
		end

		if self.charge_ready_sound_event and self.aimed_target then
			print("MADDERFAKKING READY!!!!!")
			self.first_person_extension:play_hud_sound_event(self.charge_ready_sound_event)

			self.charge_ready_sound_event = nil
		end
	end

	self.aim_timer = self.aim_timer + dt

	return 
end
ActionTrueFlightBowAim.finish = function (self, reason, data)
	local current_action = self.current_action
	local owner_unit = self.owner_unit
	local unzoom_condition_function = current_action.unzoom_condition_function

	if not unzoom_condition_function or unzoom_condition_function(reason) then
		local status_extension = ScriptUnit.extension(owner_unit, "status_system")

		status_extension.set_zooming(status_extension, false)
	end

	local sound_event = current_action.unaim_sound_event

	if sound_event then
		local wwise_world = self.wwise_world

		WwiseWorld.trigger_event(wwise_world, sound_event)
	end

	local chain_action_data = {
		target = self.target,
		charge_value = 1
	}
	local charging_sound_id = self.charging_sound_id

	if charging_sound_id then
		ActionUtils.stop_charge_sound(self.wwise_world, charging_sound_id, self.wwise_source_id, self.current_action)

		self.wwise_source_id = nil
		self.charging_sound_id = nil
	end

	if (not data or data.new_sub_action ~= "shoot_charged") and ScriptUnit.has_extension(self.target, "outline_system") then
		local outline_extension = ScriptUnit.extension(self.target, "outline_system")

		outline_extension.set_method("never")
	end

	return chain_action_data
end

return 