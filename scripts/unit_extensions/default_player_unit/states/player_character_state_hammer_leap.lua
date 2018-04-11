PlayerCharacterStateHammerLeap = class(PlayerCharacterStateHammerLeap, PlayerCharacterState)
PlayerCharacterStateHammerLeap.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "hammer_leap")

	local context = character_state_init_context

	return 
end
PlayerCharacterStateHammerLeap.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	local equipment = self.inventory_extension:equipment()
	local right_hand_wielded_unit = equipment.right_hand_wielded_unit
	local left_hand_wielded_unit = equipment.left_hand_wielded_unit
	local weapon_extension = nil

	if right_hand_wielded_unit then
		weapon_extension = ScriptUnit.extension(right_hand_wielded_unit, "weapon_system")
	elseif left_hand_wielded_unit then
		weapon_extension = ScriptUnit.extension(left_hand_wielded_unit, "weapon_system")
	end

	self.weapon_action = weapon_extension.get_current_action(weapon_extension)

	return 
end
PlayerCharacterStateHammerLeap.on_exit = function (self, unit, input, dt, context, t, next_state)
	local status_extension = self.status_extension

	status_extension.set_hammer_leaping(status_extension, false)

	return 
end
PlayerCharacterStateHammerLeap.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local input_extension = self.input_extension
	local status_extension = self.status_extension

	if CharacterStateHelper.is_dead(status_extension) then
		csm.change_state(csm, "dead")

		return 
	end

	if CharacterStateHelper.is_knocked_down(status_extension) then
		csm.change_state(csm, "knocked_down")

		return 
	end

	if CharacterStateHelper.is_pounced_down(status_extension) then
		csm.change_state(csm, "pounced_down")

		return 
	end

	if CharacterStateHelper.is_colliding_down(unit) then
		self.weapon_action:player_landed()

		self.direction = nil
		self.pause_in_air_timer = nil

		self.first_person_extension:play_camera_effect_sequence("landed_hard", t)

		if CharacterStateHelper.is_moving(input_extension) then
			csm.change_state(csm, "walking")
		else
			csm.change_state(csm, "standing")
		end

		return 
	end

	local weapon_action = self.weapon_action
	local target_position = weapon_action.target_position:unbox()
	local unit_position = POSITION_LOOKUP[unit]
	local distance = Vector3.distance(target_position + weapon_action.leap_z_offset:unbox(), unit_position)
	local direction = Vector3.normalize(target_position - unit_position)
	local look_rotation = Quaternion.look((self.direction and self.direction:unbox()) or Vector3.flat(direction))
	local first_person_extension = self.first_person_extension

	first_person_extension.force_look_rotation(first_person_extension, look_rotation)

	if distance <= weapon_action.distance_before_leap then
		local locomotion_extension = self.locomotion_extension
		local velocity = direction * weapon_action.leap_speed
		self.direction = Vector3Box(direction)

		if not self.pause_in_air_timer then
			self.pause_in_air_timer = t + weapon_action.pause_in_air_time
		end

		if t < self.pause_in_air_timer then
			locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3.zero())
			locomotion_extension.set_forced_velocity(locomotion_extension, Vector3.zero())
		else
			locomotion_extension.set_wanted_velocity(locomotion_extension, velocity)
			locomotion_extension.set_forced_velocity(locomotion_extension, velocity)
		end
	end

	return 
end

return 
