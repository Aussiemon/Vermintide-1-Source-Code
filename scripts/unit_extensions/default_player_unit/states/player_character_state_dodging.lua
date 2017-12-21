PlayerCharacterStateDodging = class(PlayerCharacterStateDodging, PlayerCharacterState)
PlayerCharacterStateDodging.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "dodging")

	local context = character_state_init_context
	self.movement_speed = 0
	self.last_input_direction = Vector3Box(0, 0, 0)
	self.dodge_direction = Vector3Box(0, 0, 0)
	self.starting_position = Vector3Box(0, 0, 0)

	return 
end
PlayerCharacterStateDodging.on_enter_animation = function (self, unit)
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local dodge_direction = self.dodge_direction:unbox()
	local x_value = Vector3.x(dodge_direction)
	local y_value = Vector3.y(dodge_direction)
	local variable_name = "dodge_time"
	local variable_value = self.estimated_dodge_time
	local first_person_extension = self.first_person_extension

	if math.abs(x_value) < math.abs(y_value) then
		CharacterStateHelper.play_animation_event_with_variable_float(unit, "dodge_bwd", variable_name, variable_value)
		CharacterStateHelper.play_animation_event_first_person(first_person_extension, "dodge_bwd")
	elseif 0 < x_value then
		CharacterStateHelper.play_animation_event_with_variable_float(unit, "dodge_left", variable_name, variable_value)
		CharacterStateHelper.play_animation_event_first_person(first_person_extension, "dodge_left")
	else
		CharacterStateHelper.play_animation_event_with_variable_float(unit, "dodge_right", variable_name, variable_value)
		CharacterStateHelper.play_animation_event_first_person(first_person_extension, "dodge_right")
	end

	return 
end
PlayerCharacterStateDodging.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	local unit = self.unit
	local input_extension = self.input_extension
	local first_person_extension = self.first_person_extension
	local status_extension = self.status_extension

	self.dodge_direction:store(params.dodge_direction)

	params.dodge_direction = nil

	self.start_dodge(self, unit, t)

	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)

	self.status_extension:set_dodge_jump_override_t(t, movement_settings_table.dodging.dodge_jump_override_timer)

	local inventory_extension = self.inventory_extension

	self.last_input_direction:store(Vector3(0, 0, 0))
	CharacterStateHelper.look(input_extension, self.player.viewport_name, first_person_extension, status_extension)
	CharacterStateHelper.update_weapon_actions(t, unit, input_extension, inventory_extension, self.damage_extension)
	self.on_enter_animation(self, unit)
	self.locomotion_extension:enable_rotation_towards_velocity(false)

	local forward_direction = Quaternion.forward(self.first_person_extension:current_rotation())

	Vector3.set_z(forward_direction, 0)

	forward_direction = Vector3.normalize(forward_direction)
	local flat_rotation = Quaternion.look(forward_direction, Vector3(0, 0, 1))

	Unit.set_local_rotation(unit, 0, flat_rotation)

	return 
end
PlayerCharacterStateDodging.on_exit = function (self, unit, input, dt, context, t, next_state)
	self.status_extension:set_is_dodging(false)

	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local cd = math.max(movement_settings_table.dodging.dodge_cd, movement_settings_table.dodging.dodge_jump_override_timer - self.time_in_dodge)

	self.status_extension:set_dodge_cd(t, cd)

	self.dodge_timer = nil
	self.dodge_stand_still_timer = nil
	self.dodge_return_timer = nil

	self.locomotion_extension:enable_rotation_towards_velocity(true)
	self.status_extension:start_dodge_cooldown(t)

	if Managers.state.network:game() then
		CharacterStateHelper.play_animation_event(unit, "dodge_end")
	end

	return 
end
PlayerCharacterStateDodging.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local input_extension = self.input_extension
	local status_extension = self.status_extension
	local first_person_extension = self.first_person_extension
	self.time_in_dodge = self.time_in_dodge + dt

	ScriptUnit.extension(unit, "whereabouts_system"):set_is_onground()

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return 
	end

	if CharacterStateHelper.is_using_transport(status_extension) then
		csm.change_state(csm, "using_transport")

		return 
	end

	if CharacterStateHelper.is_pushed(status_extension) then
		status_extension.set_pushed(status_extension, false)
		csm.change_state(csm, "stunned", movement_settings_table.stun_settings.pushed)

		return 
	end

	if CharacterStateHelper.is_block_broken(status_extension) then
		status_extension.set_block_broken(status_extension, false)
		csm.change_state(csm, "stunned", movement_settings_table.stun_settings.parry_broken)

		return 
	end

	if self.locomotion_extension:is_animation_driven() then
		return 
	end

	if self.distance_left < 0 then
		local params = self.temp_params

		csm.change_state(csm, "walking", params)
	end

	if input_extension.get(input_extension, "jump") and status_extension.can_override_dodge_with_jump(status_extension, t) then
		local params = self.temp_params
		params.post_dodge_jump = true

		csm.change_state(csm, "jumping", params)

		return 
	end

	CharacterStateHelper.update_dodge_lock(unit, self.input_extension, status_extension)

	if not self.csm.state_next and not self.locomotion_extension:is_colliding_down() then
		csm.change_state(csm, "falling", self.temp_params)

		return 
	end

	local move_input = input_extension.get(input_extension, "move")
	local movement = Vector3(0, 0, 0)

	if move_input then
		movement = movement + move_input
	end

	local move_input_controller = input_extension.get(input_extension, "move_controller")

	if move_input_controller then
		movement = movement + move_input_controller
	end

	local move_input_dpad = input_extension.get(input_extension, "move_dpad")

	if move_input_dpad then
		movement = movement + move_input_dpad
	end

	if not self.update_dodge(self, unit, movement, dt, t) then
		local params = self.temp_params

		csm.change_state(csm, "walking", params)
	end

	CharacterStateHelper.look(input_extension, self.player.viewport_name, first_person_extension, status_extension)
	CharacterStateHelper.update_weapon_actions(t, unit, input_extension, self.inventory_extension, self.damage_extension)
	CharacterStateHelper.reload(input_extension, self.inventory_extension, status_extension)

	local move_anim = CharacterStateHelper.get_move_animation(self.locomotion_extension, input_extension, status_extension)

	if move_anim ~= self.move_anim then
		CharacterStateHelper.play_animation_event(unit, move_anim)

		self.move_anim = move_anim
	end

	return 
end
local params = {}
PlayerCharacterStateDodging.update_dodge = function (self, unit, movement, dt, t)
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local last_distance_left = self.distance_left
	local diminishing_return_factor = self.status_extension:get_dodge_cooldown()
	local speed_modifier = movement_settings_table.dodging.speed_modifier
	local distance_modifier = movement_settings_table.dodging.distance_modifier
	self.distance_left = movement_settings_table.dodging.distance*distance_modifier*diminishing_return_factor - Vector3.distance(Unit.world_position(unit, 0), self.starting_position:unbox())
	local test = self.distance_supposed_to_move - last_distance_left - self.distance_left

	if movement_settings_table.dodging.stop_threshold < test then
		return false
	end

	if last_distance_left <= self.distance_left then
		return false
	end

	if self.distance_left <= 0 then
		return false
	end

	local time_in_dodge = self.time_in_dodge
	local speed_at_times = movement_settings_table.dodging.speed_at_times
	local breaked = false
	local start_point = self.current_speed_setting_index + 1
	self.current_speed_setting_index = #speed_at_times

	for index = start_point, #speed_at_times, 1 do
		if time_in_dodge <= speed_at_times[index].time_in_dodge then
			self.current_speed_setting_index = index - 1

			break
		end
	end

	local current_speed_setting_index = self.current_speed_setting_index
	local next_speed_setting_index = current_speed_setting_index + 1

	if next_speed_setting_index <= #speed_at_times then
		local time_between_settings = speed_at_times[next_speed_setting_index].time_in_dodge - speed_at_times[current_speed_setting_index].time_in_dodge
		local time_in_setting = time_in_dodge - speed_at_times[current_speed_setting_index].time_in_dodge
		local percentage_in_between = time_in_setting/time_between_settings
		self.speed = math.lerp(speed_at_times[current_speed_setting_index].speed, speed_at_times[next_speed_setting_index].speed, percentage_in_between)*speed_modifier*diminishing_return_factor
	else
		self.speed = speed_at_times[current_speed_setting_index].speed*speed_modifier*diminishing_return_factor
	end

	local unit_rotation = self.first_person_extension:current_rotation()
	local flat_unit_rotation = Quaternion.look(Vector3.flat(Quaternion.forward(unit_rotation)), Vector3.up())
	local move_direction = Quaternion.rotate(flat_unit_rotation, self.dodge_direction:unbox())

	self.locomotion_extension:set_wanted_velocity(move_direction*self.speed)

	self.distance_supposed_to_move = self.speed*dt

	return true
end
PlayerCharacterStateDodging.get_is_dodging = function (self)
	return self.dodge_timer or self.dodge_stand_still_timer or self.dodge_return_timer
end
PlayerCharacterStateDodging.start_dodge = function (self, unit, t)
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)

	self.status_extension:set_is_dodging(true)
	assert(1 < #movement_settings_table.dodging.speed_at_times, "not enough speed at times in movementsettings")

	self.current_speed_setting_index = 1
	self.speed = movement_settings_table.dodging.speed_at_times[self.current_speed_setting_index].speed
	self.distance_supposed_to_move = 0
	self.time_in_dodge = 0
	self.distance_left = movement_settings_table.dodging.distance*movement_settings_table.dodging.distance_modifier + 0.1

	self.starting_position:store(Unit.world_position(unit, 0))
	self.calculate_dodge_total_time(self, unit)

	return 
end
PlayerCharacterStateDodging.calculate_dodge_total_time = function (self, unit)
	local time_step = 0.016666666666666666
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local not_hit_end = true
	local time_in_dodge = 0
	local current_speed_setting_index = 1
	local distance_travelled = 0
	local dodge_fatigue = self.dodge_fatigue
	local diminishing_return_factor = self.status_extension:get_dodge_cooldown()
	local speed_modifier = movement_settings_table.dodging.speed_modifier
	local distance_modifier = movement_settings_table.dodging.distance_modifier*diminishing_return_factor
	local speed = movement_settings_table.dodging.speed_at_times[1].speed*speed_modifier*diminishing_return_factor

	while not_hit_end do
		time_in_dodge = time_in_dodge + time_step
		local speed_at_times = movement_settings_table.dodging.speed_at_times
		local breaked = false
		local start_point = current_speed_setting_index + 1
		current_speed_setting_index = #speed_at_times

		for index = start_point, #speed_at_times, 1 do
			if time_in_dodge <= speed_at_times[index].time_in_dodge then
				current_speed_setting_index = index - 1

				break
			end
		end

		local next_speed_setting_index = current_speed_setting_index + 1

		if next_speed_setting_index <= #speed_at_times then
			local time_between_settings = speed_at_times[next_speed_setting_index].time_in_dodge - speed_at_times[current_speed_setting_index].time_in_dodge
			local time_in_setting = time_in_dodge - speed_at_times[current_speed_setting_index].time_in_dodge
			local percentage_in_between = time_in_setting/time_between_settings
			speed = math.lerp(speed_at_times[current_speed_setting_index].speed, speed_at_times[next_speed_setting_index].speed, percentage_in_between)*speed_modifier*diminishing_return_factor
		else
			speed = speed_at_times[current_speed_setting_index].speed*speed_modifier
		end

		distance_travelled = distance_travelled + speed*time_step

		if movement_settings_table.dodging.distance*distance_modifier*diminishing_return_factor < distance_travelled then
			not_hit_end = false
		end
	end

	self.estimated_dodge_time = time_in_dodge

	return 
end

return 