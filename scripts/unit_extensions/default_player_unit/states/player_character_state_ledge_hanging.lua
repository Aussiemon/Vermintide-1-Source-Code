PlayerCharacterStateLedgeHanging = class(PlayerCharacterStateLedgeHanging, PlayerCharacterState)
PlayerCharacterStateLedgeHanging.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "ledge_hanging")

	local context = character_state_init_context
	self.lerp_target_position = Vector3Box()
	self.lerp_start_position = Vector3Box()

	return 
end
PlayerCharacterStateLedgeHanging.on_enter_animation = function (self)
	local unit = self.unit

	CharacterStateHelper.play_animation_event_first_person(self.first_person_extension, "idle")
	CharacterStateHelper.play_animation_event(unit, "hanging")

	return 
end
PlayerCharacterStateLedgeHanging.change_to_third_person_camera = function (self)
	CharacterStateHelper.change_camera_state(self.player, "follow_third_person_ledge")

	local first_person_extension = self.first_person_extension

	first_person_extension.set_first_person_mode(first_person_extension, false)

	local include_local_player = true

	CharacterStateHelper.show_inventory_3p(self.unit, false, include_local_player, self.is_server, self.inventory_extension)

	return 
end
PlayerCharacterStateLedgeHanging.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	local unit = self.unit
	local ledge_unit = params.ledge_unit
	self.ledge_unit = ledge_unit

	CharacterStateHelper.stop_weapon_actions(self.inventory_extension, "ledge_hanging")
	self.locomotion_extension:enable_script_driven_ladder_movement()
	self.locomotion_extension:set_forced_velocity(Vector3:zero())

	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	self.fall_down_time = t + movement_settings_table.ledge_hanging.time_until_fall_down

	self.calculate_and_start_rotation_to_ledge(self)
	self.calculate_start_position(self)
	self.on_enter_animation(self)
	self.change_to_third_person_camera(self)
	CharacterStateHelper.set_is_on_ledge(self.ledge_unit, unit, true, self.is_server, self.status_extension)

	return 
end
PlayerCharacterStateLedgeHanging.on_exit = function (self, unit, input, dt, context, t, next_state)
	self.rotate_timer_yaw = nil
	self.position_lerp_timer = nil

	if next_state ~= "leave_ledge_hanging_pull_up" then
		if next_state ~= "leave_ledge_hanging_falling" then
			CharacterStateHelper.change_camera_state(self.player, "follow")
			self.first_person_extension:toggle_visibility(CameraTransitionSettings.perspective_transition_time)
		end

		local status_extension = self.status_extension

		self.locomotion_extension:enable_script_driven_movement()

		local include_local_player = false

		CharacterStateHelper.show_inventory_3p(unit, true, include_local_player, self.is_server, self.inventory_extension)

		if Managers.state.network:game() then
			CharacterStateHelper.set_is_on_ledge(self.ledge_unit, unit, false, self.is_server, self.status_extension)
		end
	elseif next_state == "leave_ledge_hanging_pull_up" or next_state == "leave_ledge_hanging_falling" then
		CharacterStateHelper.change_camera_state(self.player, "follow_third_person")
	end

	return 
end
PlayerCharacterStateLedgeHanging.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local locomotion_extension = self.locomotion_extension
	local input_extension = self.input_extension
	local status_extension = self.status_extension
	local first_person_extension = self.first_person_extension

	if status_extension.is_pulled_up(status_extension) or DebugKeyHandler.key_pressed("c", "pull up from ledge hanging", "player") then
		local params = self.temp_params
		params.ledge_unit = self.ledge_unit

		csm.change_state(csm, "leave_ledge_hanging_pull_up", params)

		return 
	end

	if self.fall_down_time < t or CharacterStateHelper.is_knocked_down(status_extension) then
		local params = self.temp_params
		params.ledge_unit = self.ledge_unit

		csm.change_state(csm, "leave_ledge_hanging_falling", params)

		return 
	end

	if self.position_lerp_timer then
		self.position_lerp_timer = self.position_lerp_timer + dt
		local percentage_in_lerp = math.clamp(self.position_lerp_timer / self.time_for_position_lerp, 0, 1)
		local start_position = self.lerp_start_position:unbox()
		local target_position = self.lerp_target_position:unbox()
		local new_position = start_position + (target_position - start_position) * percentage_in_lerp

		locomotion_extension.teleport_to(locomotion_extension, new_position)

		if percentage_in_lerp == 1 then
			self.time_for_position_lerp = nil
			self.position_lerp_timer = nil
		end
	end

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return 
	end

	self.locomotion_extension:set_disable_rotation_update()
	CharacterStateHelper.look(input_extension, self.player.viewport_name, self.first_person_extension, status_extension, self.inventory_extension)
	self.locomotion_extension:set_forced_velocity(Vector3:zero())

	return 
end
PlayerCharacterStateLedgeHanging.calculate_start_position = function (self)
	local unit = self.unit
	local ledge_unit = self.ledge_unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local node = Unit.node(ledge_unit, "g_gameplay_ledge_trigger_box")
	local ledge_position = Unit.world_position(ledge_unit, node)
	local ledge_rotation = Unit.world_rotation(ledge_unit, node)
	local current_position = Unit.local_position(unit, 0)
	local ledge_right_vector = Quaternion.right(ledge_rotation)
	local direction = current_position - ledge_position
	local position_offset_amount = Vector3.dot(ledge_right_vector, direction)
	local node = Unit.node(ledge_unit, "g_gameplay_ledge_finger_box")
	local finger_box_position = Unit.world_position(ledge_unit, node)
	local finger_box_rotation = Unit.world_rotation(ledge_unit, node)
	local finger_box_right_vector = Quaternion.right(finger_box_rotation)
	local new_position = finger_box_position + finger_box_right_vector * position_offset_amount
	local distance = Vector3.distance(current_position, new_position)

	self.lerp_start_position:store(current_position)
	self.lerp_target_position:store(new_position)

	self.time_for_position_lerp = distance * movement_settings_table.ledge_hanging.attach_position_lerp_time_per_meter
	self.position_lerp_timer = 0

	return 
end
PlayerCharacterStateLedgeHanging.calculate_and_start_rotation_to_ledge = function (self)
	local unit = self.unit
	local ledge_unit = self.ledge_unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local node = Unit.node(ledge_unit, "g_gameplay_ledge_finger_box")
	local finger_box_rotation = Unit.world_rotation(ledge_unit, node)
	local finger_box_yaw = Quaternion.yaw(finger_box_rotation)
	local rotation = Quaternion(Vector3.up(), finger_box_yaw + math.pi)

	Unit.set_local_rotation(unit, 0, rotation)

	return 
end

return 
