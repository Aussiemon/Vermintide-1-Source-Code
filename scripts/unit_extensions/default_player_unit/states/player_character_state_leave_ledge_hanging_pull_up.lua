PlayerCharacterStateLeaveLedgeHangingPullUp = class(PlayerCharacterStateLeaveLedgeHangingPullUp, PlayerCharacterState)

PlayerCharacterStateLeaveLedgeHangingPullUp.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "leave_ledge_hanging_pull_up")

	local context = character_state_init_context
	self.is_server = Managers.player.is_server
	self.end_position = Vector3Box()
end

PlayerCharacterStateLeaveLedgeHangingPullUp.on_enter_animation_event = function (self)
	local unit = self.unit

	CharacterStateHelper.play_animation_event(unit, "hanging_exit")
end

PlayerCharacterStateLeaveLedgeHangingPullUp.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	local unit = self.unit
	local input_extension = self.input_extension
	local first_person_extension = self.first_person_extension
	local ledge_unit = params.ledge_unit
	self.ledge_unit = ledge_unit

	self:calculate_end_position()
	self.locomotion_extension:enable_animation_driven_movement_with_rotation_no_mover()
	self:on_enter_animation_event()

	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	self.finish_time = t + movement_settings_table.ledge_hanging.leaving_animation_time
end

PlayerCharacterStateLeaveLedgeHangingPullUp.on_exit = function (self, unit, input, dt, context, t, next_state)
	local status_extension = self.status_extension

	if next_state then
		self.locomotion_extension:enable_script_driven_movement()
		self.locomotion_extension:set_forced_velocity(nil)
		self.locomotion_extension:set_wanted_velocity(Vector3:zero())
		self.locomotion_extension:teleport_to(self.end_position:unbox())
	end

	if Managers.state.network:game() then
		StatusUtils.set_pulled_up_network(unit, false)
		CharacterStateHelper.set_is_on_ledge(self.ledge_unit, unit, false, self.is_server, self.status_extension)
	end

	CharacterStateHelper.change_camera_state(self.player, "follow")
	self.first_person_extension:toggle_visibility(CameraTransitionSettings.perspective_transition_time)

	local include_local_player = false

	CharacterStateHelper.show_inventory_3p(unit, true, include_local_player, self.is_server, self.inventory_extension)
end

PlayerCharacterStateLeaveLedgeHangingPullUp.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local input_extension = self.input_extension
	local status_extension = self.status_extension
	local locomotion_extension = self.locomotion_extension

	if CharacterStateHelper.is_dead(status_extension) then
		csm:change_state("dead")

		return
	end

	if CharacterStateHelper.is_knocked_down(status_extension) then
		csm:change_state("knocked_down")

		return
	end

	if CharacterStateHelper.is_pounced_down(status_extension) then
		csm:change_state("pounced_down")

		return
	end

	local is_catapulted, direction = CharacterStateHelper.is_catapulted(status_extension)

	if is_catapulted then
		local params = {
			sound_event = "Play_hit_by_ratogre",
			direction = direction
		}

		csm:change_state("catapulted", params)

		return
	end

	if self.finish_time < t then
		csm:change_state("walking")

		return
	end

	self.locomotion_extension:set_disable_rotation_update()
	CharacterStateHelper.look(input_extension, self.player.viewport_name, self.first_person_extension, status_extension, self.inventory_extension)
end

PlayerCharacterStateLeaveLedgeHangingPullUp.calculate_end_position = function (self)
	local unit = self.unit
	local ledge_unit = self.ledge_unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local node = Unit.node(ledge_unit, "g_gameplay_ledge_finger_box")
	local ledge_position = Unit.world_position(ledge_unit, node)
	local ledge_rotation = Unit.world_rotation(ledge_unit, node)
	local current_position = Unit.local_position(unit, 0)
	local ledge_right_vector = Quaternion.right(ledge_rotation)
	local direction = current_position - ledge_position
	local position_offset_amount = Vector3.dot(ledge_right_vector, direction)
	local node = Unit.node(ledge_unit, "g_gameplay_ledge_respawn_box")
	local respawn_box_position = Unit.world_position(ledge_unit, node)
	local respawn_box_rotation = Unit.world_rotation(ledge_unit, node)
	local respawn_box_right_vector = Quaternion.right(respawn_box_rotation)
	local new_position = respawn_box_position + respawn_box_right_vector * position_offset_amount

	self.end_position:store(new_position)
end

return
