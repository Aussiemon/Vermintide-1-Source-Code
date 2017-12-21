PlayerCharacterStateInteracting = class(PlayerCharacterStateInteracting, PlayerCharacterState)
PlayerCharacterStateInteracting.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "interacting")

	local context = character_state_init_context

	return 
end
PlayerCharacterStateInteracting.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	self.has_started_interacting = false

	self.locomotion_extension:set_wanted_velocity(Vector3.zero())

	self.swap_to_3p = params.swap_to_3p
	local status_extension = self.status_extension

	if not self.locomotion_extension:is_colliding_down() then
		status_extension.set_falling_height(status_extension)
	end

	if self.swap_to_3p then
		CharacterStateHelper.change_camera_state(self.player, "follow_third_person")
		self.first_person_extension:set_first_person_mode(false)

		local include_local_player = true

		CharacterStateHelper.show_inventory_3p(unit, false, include_local_player, self.is_server, self.inventory_extension)
	else
		local include_local_player = false

		CharacterStateHelper.show_inventory_3p(unit, false, include_local_player, self.is_server, self.inventory_extension)
	end

	return 
end
PlayerCharacterStateInteracting.on_exit = function (self, unit, input, dt, context, t, next_state)
	if self.swap_to_3p then
		CharacterStateHelper.change_camera_state(self.player, "follow")

		local include_local_player = true

		CharacterStateHelper.show_inventory_3p(unit, true, include_local_player, self.is_server, self.inventory_extension)
		self.first_person_extension:toggle_visibility(CameraTransitionSettings.perspective_transition_time)
	else
		local include_local_player = false

		CharacterStateHelper.show_inventory_3p(unit, true, include_local_player, self.is_server, self.inventory_extension)
	end

	return 
end
PlayerCharacterStateInteracting.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local input_extension = self.input_extension
	local interactor_extension = self.interactor_extension
	local camera_manager = Managers.state.camera
	local status_extension = self.status_extension
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return 
	end

	if CharacterStateHelper.is_using_transport(status_extension) then
		csm.change_state(csm, "using_transport")

		return 
	end

	if not self.has_started_interacting then
		if not CharacterStateHelper.is_interacting(interactor_extension) then
			csm.change_state(csm, "standing")

			return 
		elseif not CharacterStateHelper.is_waiting_for_interaction_approval(interactor_extension) then
			self.has_started_interacting = true
		end
	elseif not CharacterStateHelper.is_interacting(interactor_extension) then
		csm.change_state(csm, "standing")

		return 
	end

	if not CharacterStateHelper.is_waiting_for_interaction_approval(interactor_extension) and not CharacterStateHelper.interact(input_extension, interactor_extension) then
		csm.change_state(csm, "standing")

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

	self.locomotion_extension:set_disable_rotation_update()
	CharacterStateHelper.look(input_extension, self.player.viewport_name, self.first_person_extension, status_extension)
	Debug.text("PlayerCharacterStateInteracting: [camera node=%s]", tostring(camera_manager.current_camera_node(camera_manager, "player_1")))

	return 
end

return 
