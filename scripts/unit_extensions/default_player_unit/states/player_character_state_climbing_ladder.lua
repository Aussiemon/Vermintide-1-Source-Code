PlayerCharacterStateClimbingLadder = class(PlayerCharacterStateClimbingLadder, PlayerCharacterState)
PlayerCharacterStateClimbingLadder.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "climbing_ladder")

	local context = character_state_init_context
	self.lerp_target_position = Vector3Box()
	self.lerp_start_position = Vector3Box()

	return 
end
PlayerCharacterStateClimbingLadder.on_enter_animation_event = function (self)
	local unit = self.unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local unit_pos = POSITION_LOOKUP[unit]
	local unit_position_height = Vector3.z(unit_pos)
	local height_dif = math.abs(self.jump_off_height - unit_position_height)

	if height_dif < movement_settings_table.ladder.animation_distance_threshold_from_top_node then
		self.entered_top = true

		CharacterStateHelper.play_animation_event(unit, "climb_top_enter_ladder")
	else
		self.entered_top = false

		CharacterStateHelper.play_animation_event(unit, "climb_enter_ladder")
	end

	local first_person_extension = self.first_person_extension

	first_person_extension.play_animation_event(first_person_extension, "climb_enter_ladder")

	return 
end
PlayerCharacterStateClimbingLadder.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	local unit = self.unit
	local input_extension = self.input_extension
	local first_person_extension = self.first_person_extension
	local ladder_unit = params.ladder_unit

	table.clear(self.temp_params)

	self.accumilated_distance = 0
	self.ladder_unit = ladder_unit
	self.movement_speed = 1
	self.animation_state = "no_animation"
	local jump_node = Unit.node(ladder_unit, "c_platform")
	self.jump_off_height = Vector3.z(Unit.world_position(ladder_unit, jump_node))

	self.locomotion_extension:enable_script_driven_ladder_movement()
	self.locomotion_extension:enable_rotation_towards_velocity(false, Unit.local_rotation(ladder_unit, 0), 0.5)

	local ladder_pos = Unit.world_position(self.ladder_unit, 0)
	local ladder_position_height = Vector3.z(ladder_pos)
	self.ladder_position_height = ladder_position_height

	if previous_state ~= "enter_ladder_top" then
		CharacterStateHelper.stop_weapon_actions(self.inventory_extension, "ladder")

		local network_manager = Managers.state.network
		local unit_id = network_manager.unit_game_object_id(network_manager, unit)
		local include_local_player = false

		CharacterStateHelper.show_inventory_3p(unit, false, include_local_player, self.is_server, self.inventory_extension)
		self.first_person_extension:hide_weapons("climbing")
		self.on_enter_animation_event(self)
		CharacterStateHelper.set_is_on_ladder(ladder_unit, unit, true, self.is_server, self.status_extension)
	end

	local mover = Unit.mover(unit)

	Mover.set_collision_filter(mover, "filter_player_ladder_mover")

	return 
end
PlayerCharacterStateClimbingLadder.on_exit = function (self, unit, input, dt, context, t, next_state)
	if next_state and next_state ~= "leaving_ladder_top" then
		local status_extension = self.status_extension

		status_extension.set_falling_height(status_extension, true)
		status_extension.set_left_ladder(status_extension, t)

		local network_manager = Managers.state.network
		local unit_id = network_manager.unit_game_object_id(network_manager, unit)
		local include_local_player = false

		CharacterStateHelper.show_inventory_3p(unit, true, include_local_player, self.is_server, self.inventory_extension)
		self.locomotion_extension:enable_script_driven_movement()
		self.locomotion_extension:enable_rotation_towards_velocity(true)
		self.first_person_extension:unhide_weapons("climbing")

		if Managers.state.network:game() then
			CharacterStateHelper.play_animation_event(unit, "climb_end_ladder")
		end

		local first_person_extension = self.first_person_extension

		first_person_extension.play_animation_event(first_person_extension, "idle")

		if Managers.state.network:game() then
			CharacterStateHelper.set_is_on_ladder(self.ladder_unit, unit, false, self.is_server, self.status_extension)
		end
	end

	local mover = Unit.mover(unit)

	Mover.set_collision_filter(mover, "filter_player_mover")

	return 
end
PlayerCharacterStateClimbingLadder.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local input_extension = self.input_extension
	local status_extension = self.status_extension
	local locomotion_extension = self.locomotion_extension
	local player = self.player

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return 
	end

	local current_velocity = locomotion_extension.current_velocity(locomotion_extension)
	local current_velocity_z = current_velocity.z

	if CharacterStateHelper.is_colliding_down(unit) and current_velocity_z < 0 then
		csm.change_state(csm, "walking")

		return 
	end

	local ladder_shaking = ScriptUnit.extension(self.ladder_unit, "ladder_system"):is_shaking()

	if not csm.state_next and (input_extension.get(input_extension, "jump") or ladder_shaking) then
		local params = self.temp_params
		params.ladder_unit = self.ladder_unit
		params.ladder_shaking = true

		csm.change_state(csm, "jumping", params)

		return 
	end

	local colliding_with_ladder, ladder_unit = CharacterStateHelper.is_colliding_with_gameplay_collision_box(self.world, unit, "filter_ladder_collision")
	local current_velocity = self.locomotion_extension:current_velocity()
	local current_velocity_z = current_velocity.z
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local above_climb_off_height = self.jump_off_height - movement_settings_table.ladder.leaving_ladder_height_below_get_of_node <= Vector3.z(Unit.world_position(unit, 0))

	if not self.position_lerp_timer then
		if above_climb_off_height and 0 < current_velocity_z then
			local params = self.temp_params
			params.ladder_unit = self.ladder_unit

			csm.change_state(csm, "leaving_ladder_top", params)

			return 
		elseif not colliding_with_ladder then
			if above_climb_off_height and 0 < current_velocity_z then
				local params = self.temp_params
				params.ladder_unit = self.ladder_unit

				csm.change_state(csm, "leaving_ladder_top", params)
			else
				csm.change_state(csm, "falling")
			end

			return 
		end
	end

	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local is_moving = CharacterStateHelper.is_moving(input_extension)

	if is_moving then
		self.movement_speed = math.min(1, self.movement_speed + movement_settings_table.ladder.climb_move_acceleration_up*dt)
	else
		self.movement_speed = math.max(0, self.movement_speed - movement_settings_table.ladder.climb_acceleration_down*dt)
	end

	local move_speed = movement_settings_table.ladder.climb_speed
	local move_speed_multiplier = status_extension.current_move_speed_multiplier(status_extension)
	move_speed = move_speed*move_speed_multiplier
	move_speed = move_speed*movement_settings_table.ladder.player_ladder_speed_scale
	move_speed = move_speed*self.movement_speed
	local ladder_rotation = Unit.local_rotation(self.ladder_unit, 0)
	local ladder_pos = Unit.world_position(self.ladder_unit, 0)
	local ladder_offset = Vector3.dot(-Quaternion.forward(ladder_rotation), POSITION_LOOKUP[unit] - ladder_pos) + movement_settings_table.ladder.climb_attach_to_ladder_position_in_ladder_space_y

	CharacterStateHelper.move_on_ladder(self.first_person_extension, ladder_rotation, input_extension, self.locomotion_extension, unit, move_speed, ladder_offset)

	local time_in_move_animation = CharacterStateHelper.time_in_ladder_move_animation(unit, ladder_pos.z)
	local variable_index = Unit.animation_find_variable(unit, "climb_time")

	Unit.animation_set_variable(unit, variable_index, time_in_move_animation)

	local max_radians = math.degrees_to_radians(movement_settings_table.ladder.look_horizontal_max_degrees)

	CharacterStateHelper.look_limited_rotation_freedom(input_extension, player.viewport_name, self.first_person_extension, self.ladder_unit, unit, max_radians, max_radians, status_extension)
	self.on_ladder_animation(self)

	self.accumilated_distance = self.accumilated_distance + math.abs(current_velocity_z)*dt

	if not player.bot_player and 1 < self.accumilated_distance then
		self.accumilated_distance = 0
		local position = Unit.world_position(unit, 0)
		local wwise_source_id, wwise_world = WwiseUtils.make_position_auto_source(self.world, position)

		WwiseWorld.trigger_event(wwise_world, "player_footstep_ladder", wwise_source_id)
	end

	return 
end
PlayerCharacterStateClimbingLadder.on_ladder_animation = function (self)
	local unit = self.unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local current_velocity = self.locomotion_extension:current_velocity()
	local current_velocity_z = current_velocity.z

	if current_velocity_z == 0 then
		if self.animation_state ~= "animation_idle" then
			self.animation_state = "animation_idle"
			local time_in_move_animation = CharacterStateHelper.time_in_ladder_move_animation(unit, self.ladder_position_height)

			if time_in_move_animation <= movement_settings_table.ladder.threshold_for_idle_right then
				CharacterStateHelper.play_animation_event(unit, "climb_idle_right_ladder")
			elseif time_in_move_animation <= movement_settings_table.ladder.threshold_for_idle_middle then
				CharacterStateHelper.play_animation_event(unit, "climb_idle_mid_ladder")
			elseif time_in_move_animation <= movement_settings_table.ladder.threshold_for_idle_left then
				CharacterStateHelper.play_animation_event(unit, "climb_idle_left_ladder")
			else
				CharacterStateHelper.play_animation_event(unit, "climb_idle_right_ladder")
			end
		end
	elseif self.animation_state ~= "animation_climbing" then
		self.animation_state = "animation_climbing"

		CharacterStateHelper.play_animation_event(unit, "climb_move_ladder")

		self.currently_playing_move_animation = true
	end

	return 
end

return 