PlayerCharacterStateStunned = class(PlayerCharacterStateStunned, PlayerCharacterState)
PlayerCharacterStateStunned.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "stunned")

	local context = character_state_init_context

	return 
end
PlayerCharacterStateStunned.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	CharacterStateHelper.stop_weapon_actions(self.inventory_extension, "stunned")
	CharacterStateHelper.play_animation_event_first_person(self.first_person_extension, params.first_person_anim_name)
	CharacterStateHelper.play_animation_event(unit, params.third_person_anim_name)

	local animation_driven = params.animation_driven
	self.animation_driven = animation_driven

	if animation_driven then
		self.locomotion_extension:enable_animation_driven_movement()
	end

	self.end_time = t + params.duration

	return 
end
PlayerCharacterStateStunned.on_exit = function (self, unit, input, dt, context, t, next_state)
	if self.animation_driven then
		self.locomotion_extension:enable_script_driven_movement()
	end

	local input_extension = self.input_extension

	if input_extension.get(input_extension, "action_one_hold") then
		input_extension.add_stun_buffer(input_extension, "action_one_hold")
	end

	return 
end
PlayerCharacterStateStunned.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local input_extension = self.input_extension
	local status_extension = self.status_extension

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return 
	end

	if input_extension.get(input_extension, "action_one") then
		input_extension.add_stun_buffer(input_extension, "action_one")
	end

	if self.end_time < t then
		csm.change_state(csm, "standing")

		return 
	end

	CharacterStateHelper.look(input_extension, self.player.viewport_name, self.first_person_extension, status_extension)

	return 
end

return 