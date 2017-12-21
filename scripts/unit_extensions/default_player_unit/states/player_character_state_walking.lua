PlayerCharacterStateWalking = class(PlayerCharacterStateWalking, PlayerCharacterState)
PlayerCharacterStateWalking.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "walking")

	local context = character_state_init_context
	self.movement_speed = 0
	self.latest_valid_navmesh_position = Vector3Box(math.huge, math.huge, math.huge)
	self.last_input_direction = Vector3Box(0, 0, 0)

	return 
end
PlayerCharacterStateWalking.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	local unit = self.unit
	local input_extension = self.input_extension
	local first_person_extension = self.first_person_extension
	local status_extension = self.status_extension

	if previous_state ~= "standing" then
		self.movement_speed = 1
	end

	local move_anim_3p, move_anim_1p = CharacterStateHelper.get_move_animation(self.locomotion_extension, input_extension, status_extension)

	CharacterStateHelper.play_animation_event(unit, move_anim_3p)
	CharacterStateHelper.play_animation_event_first_person(first_person_extension, move_anim_1p)

	self.move_anim_3p = move_anim_3p
	self.move_anim_1p = move_anim_1p
	local inventory_extension = self.inventory_extension
	local damage_extension = self.damage_extension

	self.last_input_direction:store(Vector3(0, 0, 0))
	CharacterStateHelper.look(input_extension, self.player.viewport_name, first_person_extension, status_extension, self.inventory_extension)
	CharacterStateHelper.update_weapon_actions(t, unit, input_extension, inventory_extension, damage_extension)

	self.walking = false

	return 
end
PlayerCharacterStateWalking.on_exit = function (self, unit, input, dt, context, t, next_state)
	return 
end
PlayerCharacterStateWalking.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local world = self.world
	local unit = self.unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local input_extension = self.input_extension
	local status_extension = self.status_extension
	local first_person_extension = self.first_person_extension

	ScriptUnit.extension(unit, "whereabouts_system"):set_is_onground()

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return 
	end

	if CharacterStateHelper.is_ledge_hanging(world, unit, self.temp_params) then
		csm.change_state(csm, "ledge_hanging", self.temp_params)

		return 
	end

	if CharacterStateHelper.is_overcharge_exploding(status_extension) then
		csm.change_state(csm, "overcharge_exploding")

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

	CharacterStateHelper.update_dodge_lock(unit, self.input_extension, self.status_extension)

	local start_dodge, dodge_direction = CharacterStateHelper.check_to_start_dodge(unit, input_extension, status_extension, t)

	if start_dodge then
		local params = self.temp_params
		params.dodge_direction = dodge_direction

		csm.change_state(csm, "dodging", params)

		return 
	end

	local gamepad_active = Managers.input:is_device_active("gamepad")

	if not csm.state_next and input_extension.get(input_extension, "jump") and not status_extension.is_crouching(status_extension) and self.locomotion_extension:jump_allowed() then
		local movement_input = CharacterStateHelper.get_movement_input(input_extension)

		if (not input_extension.dodge_on_jump_key and not gamepad_active) or status_extension.can_override_dodge_with_jump(status_extension, t) or 0 <= Vector3.y(movement_input) or Vector3.length(movement_input) <= input_extension.minimum_dodge_input then
			if Vector3.y(CharacterStateHelper.get_movement_input(input_extension)) < 0 then
				self.temp_params.backward_jump = true
			else
				self.temp_params.backward_jump = false
			end

			csm.change_state(csm, "jumping", self.temp_params)

			return 
		end
	end

	local is_moving = CharacterStateHelper.is_moving(input_extension)

	if not self.csm.state_next and not is_moving and self.movement_speed == 0 then
		local params = self.temp_params

		csm.change_state(csm, "standing", params)

		return 
	end

	if not self.csm.state_next and not self.locomotion_extension:is_colliding_down() then
		csm.change_state(csm, "falling", self.temp_params)

		return 
	end

	local colliding_with_ladder, ladder_unit = CharacterStateHelper.is_colliding_with_gameplay_collision_box(self.world, unit, "filter_ladder_collision")
	local looking_up = CharacterStateHelper.looking_up(first_person_extension, movement_settings_table.ladder.looking_up_threshold)
	local recently_left_ladder = CharacterStateHelper.recently_left_ladder(status_extension, t)
	local above_align_cube = false

	if colliding_with_ladder then
		local ladder_rot = Unit.local_rotation(ladder_unit, 0)
		local ladder_plane_inv_normal = Quaternion.forward(ladder_rot)
		local ladder_offset = Unit.local_position(ladder_unit, 0) - POSITION_LOOKUP[unit]
		local distance = Vector3.dot(ladder_plane_inv_normal, ladder_offset)
		local facing_correctly = false
		local close_enough = false
		local ladder_forward = Quaternion.forward(Unit.local_rotation(ladder_unit, 0))
		local facing = Quaternion.forward(first_person_extension.current_rotation(first_person_extension))
		local facing_ladder = Vector3.dot(facing, ladder_forward) < 0
		local movement_in_ladder_direction = Vector3.dot(self.locomotion_extension.velocity_current:unbox(), ladder_forward)
		local top_node = Unit.node(ladder_unit, "c_platform")

		if Vector3.z(Unit.world_position(ladder_unit, top_node)) < POSITION_LOOKUP[unit].z then
			local player = Managers.player:owner(unit)
			local is_bot = player and player.bot_player
			local threshold = (is_bot and movement_settings_table.ladder.bot_looking_down_threshold) or movement_settings_table.ladder.looking_down_threshold
			local looking_down = not looking_up

			if looking_down and facing_ladder and movement_in_ladder_direction < 0 then
				close_enough = 0.5 < distance
				facing_correctly = true
			elseif looking_down and 0 < distance and not facing_ladder and 0.5 < movement_in_ladder_direction then
				close_enough = 0.25 < distance
				facing_correctly = true
			end

			above_align_cube = true
		else
			local epsilon = 0.02
			close_enough = distance < epsilon + 0.7 and 0 < distance
			facing_correctly = looking_up and not facing_ladder and 0 < movement_in_ladder_direction
		end

		if facing_correctly and not recently_left_ladder and close_enough then
			local params = self.temp_params
			params.ladder_unit = ladder_unit

			if above_align_cube then
				csm.change_state(csm, "enter_ladder_top", params)

				return 
			else
				csm.change_state(csm, "climbing_ladder", params)

				return 
			end
		end
	end

	local inventory_extension = self.inventory_extension
	local toggle_crouch = input_extension.toggle_crouch

	CharacterStateHelper.crouch(unit, input_extension, status_extension, toggle_crouch, first_person_extension, t)

	local player = Managers.player:owner(unit)
	local move_input = CharacterStateHelper.get_movement_input(input_extension)

	if is_moving then
		self.movement_speed = math.min(Vector3.length(move_input), self.movement_speed + movement_settings_table.move_acceleration_up*dt)
	elseif player and player.bot_player then
		self.movement_speed = 0
	else
		self.movement_speed = math.max(0, self.movement_speed - movement_settings_table.move_acceleration_down*dt)
	end

	local walking = input_extension.get(input_extension, "walk")
	local max_move_speed = (status_extension.is_crouching(status_extension) and movement_settings_table.crouch_move_speed) or (walking and movement_settings_table.walk_move_speed) or movement_settings_table.move_speed
	local move_speed_multiplier = status_extension.current_move_speed_multiplier(status_extension)

	if walking ~= self.walking then
		status_extension.set_slowed(status_extension, walking)
	end

	local move_speed = max_move_speed*move_speed_multiplier*movement_settings_table.player_speed_scale*self.movement_speed
	local move_input_direction = Vector3.normalize(move_input)

	if Vector3.length(move_input_direction) == 0 then
		move_input_direction = self.last_input_direction:unbox()
	else
		self.last_input_direction:store(move_input_direction)
	end

	local interactor_extension = self.interactor_extension

	if CharacterStateHelper.is_starting_interaction(input_extension, interactor_extension) then
		local config = interactor_extension.interaction_config(interactor_extension)

		interactor_extension.start_interaction(interactor_extension, "interacting")

		if not config.allow_movement then
			local params = self.temp_params
			params.swap_to_3p = config.swap_to_3p
			params.show_weapons = config.show_weapons

			csm.change_state(csm, "interacting", params)
		end

		return 
	end

	CharacterStateHelper.move_on_ground(first_person_extension, input_extension, self.locomotion_extension, move_input_direction, move_speed, unit)
	CharacterStateHelper.look(input_extension, self.player.viewport_name, first_person_extension, status_extension, self.inventory_extension)
	CharacterStateHelper.update_weapon_actions(t, unit, input_extension, inventory_extension, self.damage_extension)
	CharacterStateHelper.reload(input_extension, inventory_extension, status_extension)

	if CharacterStateHelper.is_interacting(interactor_extension) then
		local config = interactor_extension.interaction_config(interactor_extension)

		if not config.allow_movement then
			local params = self.temp_params
			params.swap_to_3p = config.swap_to_3p
			params.show_weapons = config.show_weapons

			csm.change_state(csm, "interacting", params)
		end

		return 
	end

	local move_anim_3p, move_anim_1p = CharacterStateHelper.get_move_animation(self.locomotion_extension, input_extension, status_extension)

	if move_anim_3p ~= self.move_anim_3p or move_anim_1p ~= self.move_anim_1p then
		CharacterStateHelper.play_animation_event(unit, move_anim_3p)
		CharacterStateHelper.play_animation_event_first_person(first_person_extension, move_anim_1p)

		self.move_anim_3p = move_anim_3p
		self.move_anim_1p = move_anim_1p
	end

	self.walking = walking

	return 
end

return 
