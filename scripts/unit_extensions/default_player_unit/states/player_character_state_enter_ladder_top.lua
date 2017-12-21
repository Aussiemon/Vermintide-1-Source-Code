PlayerCharacterStateEnterLadderTop = class(PlayerCharacterStateEnterLadderTop, PlayerCharacterState)
PlayerCharacterStateEnterLadderTop.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "enter_ladder_top")

	local context = character_state_init_context
	self.is_server = Managers.player.is_server
	self.wanted_forward_bonus_velocity = Vector3Box()

	return 
end
PlayerCharacterStateEnterLadderTop.on_enter_animation_event = function (self, speed)
	local unit = self.unit

	CharacterStateHelper.play_animation_event_with_variable_float(unit, "climb_top_enter_ladder", "climb_enter_exit_speed", speed)

	local first_person_extension = self.first_person_extension

	first_person_extension.play_animation_event(first_person_extension, "climb_enter_ladder")

	return 
end
PlayerCharacterStateEnterLadderTop.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	local unit = self.unit

	CharacterStateHelper.stop_weapon_actions(self.inventory_extension, "ladder")

	local input_extension = self.input_extension
	local first_person_extension = self.first_person_extension
	local ladder_unit = params.ladder_unit
	self.ladder_unit = ladder_unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local duration = movement_settings_table.ladder.enter_ladder_top_animation_time
	self.finish_time = t + duration

	self.on_enter_animation_event(self, duration/2)
	self.wanted_forward_bonus_velocity:store(Quaternion.forward(Unit.local_rotation(ladder_unit, 0)))
	self.locomotion_extension:enable_script_driven_ladder_transition_movement()
	self.locomotion_extension:enable_rotation_towards_velocity(false, Unit.local_rotation(ladder_unit, 0), 0.25)

	local include_local_player = false

	CharacterStateHelper.show_inventory_3p(unit, false, include_local_player, self.is_server, self.inventory_extension)
	self.first_person_extension:hide_weapons("climbing")
	CharacterStateHelper.set_is_on_ladder(ladder_unit, unit, true, self.is_server, self.status_extension)

	local mover = Unit.mover(unit)

	Mover.set_collision_filter(mover, "filter_player_ladder_mover")

	return 
end
PlayerCharacterStateEnterLadderTop.on_exit = function (self, unit, input, dt, context, t, next_state)
	if next_state and next_state ~= "climbing_ladder" then
		self.locomotion_extension:enable_rotation_towards_velocity(true)

		local first_person_extension = self.first_person_extension

		first_person_extension.play_animation_event(first_person_extension, "idle")
		self.first_person_extension:unhide_weapons("climbing")

		local include_local_player = false

		CharacterStateHelper.show_inventory_3p(unit, true, include_local_player, self.is_server, self.inventory_extension)
		self.locomotion_extension:enable_script_driven_movement()
		self.locomotion_extension:enable_rotation_towards_velocity(true)

		if Managers.state.network:game() then
			CharacterStateHelper.play_animation_event(unit, "climb_end_ladder")
			CharacterStateHelper.set_is_on_ladder(self.ladder_unit, unit, false, self.is_server, self.status_extension)
		end
	end

	self.ladder_unit = nil
	local mover = Unit.mover(unit)

	Mover.set_collision_filter(mover, "filter_player_mover")

	return 
end
PlayerCharacterStateEnterLadderTop.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local input_extension = self.input_extension
	local status_extension = self.status_extension
	local locomotion_extension = self.locomotion_extension
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local wanted_forward_velocity = self.wanted_forward_bonus_velocity:unbox()*-movement_settings_table.ladder.enter_ladder_top_back_push_factor - Vector3(0, 0, movement_settings_table.ladder.enter_ladder_top_push_down_constant)

	locomotion_extension.set_forced_velocity(locomotion_extension, wanted_forward_velocity)

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

	local is_catapulted, direction = CharacterStateHelper.is_catapulted(status_extension)

	if is_catapulted then
		csm.change_state(csm, "catapulted", direction)

		return 
	end

	if self.finish_time < t then
		local params = self.temp_params
		params.ladder_unit = self.ladder_unit

		csm.change_state(csm, "climbing_ladder", params)
	end

	local max_radians = math.degrees_to_radians(movement_settings_table.ladder.look_horizontal_max_degrees)

	CharacterStateHelper.look_limited_rotation_freedom(input_extension, self.player.viewport_name, self.first_person_extension, self.ladder_unit, unit, max_radians, nil, status_extension)

	return 
end

return 
