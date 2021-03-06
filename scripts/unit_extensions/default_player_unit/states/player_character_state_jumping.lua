PlayerCharacterStateJumping = class(PlayerCharacterStateJumping, PlayerCharacterState)

PlayerCharacterStateJumping.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "jumping")

	local context = character_state_init_context
end

local position_lookup = POSITION_LOOKUP

PlayerCharacterStateJumping.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	table.clear(self.temp_params)

	local player = self.player
	local input_extension = self.input_extension
	local status_extension = self.status_extension
	local locomotion_extension = self.locomotion_extension
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local jump_speed = movement_settings_table.jump.stationary_jump.initial_vertical_velocity

	if script_data.use_super_jumps then
		jump_speed = jump_speed * 2
	end

	locomotion_extension:set_maximum_upwards_velocity(jump_speed)

	local velocity_current = locomotion_extension:current_velocity()
	local velocity_jump = nil

	if params.post_dodge_jump then
		velocity_current = velocity_current * 0.2
		jump_speed = jump_speed * 1
	end

	if params.backward_jump then
		velocity_current = velocity_current * 0.35
	end

	local speed_current = Vector3.length(velocity_current)

	if PlayerUnitMovementSettings.move_speed < speed_current then
		velocity_current = velocity_current * PlayerUnitMovementSettings.move_speed / speed_current
	end

	if previous_state == "climbing_ladder" then
		local ladder_unit = params.ladder_unit
		local ladder_rotation = Unit.world_rotation(ladder_unit, 0)
		local direction = Quaternion.forward(ladder_rotation)
		velocity_jump = direction * movement_settings_table.ladder.jump_backwards_force
		self.temp_params.ladder_shaking = params.ladder_shaking
	else
		velocity_jump = Vector3(velocity_current.x, velocity_current.y, jump_speed)
	end

	locomotion_extension:set_forced_velocity(velocity_jump)
	locomotion_extension:set_wanted_velocity(velocity_jump)

	if CharacterStateHelper.is_moving(input_extension) then
		local move_anim = "jump_fwd"

		CharacterStateHelper.play_animation_event(unit, move_anim)
	else
		local move_anim = "jump_idle"

		CharacterStateHelper.play_animation_event(unit, move_anim)
	end

	local inventory_extension = self.inventory_extension
	local first_person_extension = self.first_person_extension

	CharacterStateHelper.look(input_extension, player.viewport_name, first_person_extension, status_extension, self.inventory_extension)
	CharacterStateHelper.update_weapon_actions(t, unit, input_extension, inventory_extension, self.damage_extension)

	local position = POSITION_LOOKUP[unit]

	Managers.telemetry.events:player_jump(player, position)
	ScriptUnit.extension(unit, "whereabouts_system"):set_jumped()

	local start_jump_height = position_lookup[unit].z
	local status_extension = self.status_extension

	status_extension:set_falling_height(start_jump_height)
end

PlayerCharacterStateJumping.on_exit = function (self, unit, input, dt, context, t, next_state)
	local input_extension = self.input_extension

	self.locomotion_extension:reset_maximum_upwards_velocity()

	if next_state == "walking" or next_state == "standing" then
		ScriptUnit.extension(unit, "whereabouts_system"):set_landed()
	elseif next_state and next_state ~= "falling" then
		ScriptUnit.extension(unit, "whereabouts_system"):set_no_landing()
	end

	if next_state and next_state ~= "falling" and Managers.state.network:game() then
		CharacterStateHelper.play_animation_event(unit, "land_still")
		CharacterStateHelper.play_animation_event(unit, "to_onground")
	end
end

PlayerCharacterStateJumping.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local input_extension = self.input_extension
	local status_extension = self.status_extension

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return
	end

	if CharacterStateHelper.is_overcharge_exploding(status_extension) then
		csm:change_state("overcharge_exploding")

		return
	end

	if CharacterStateHelper.is_pushed(status_extension) then
		status_extension:set_pushed(false)
		csm:change_state("stunned", movement_settings_table.stun_settings.pushed)

		return
	end

	if CharacterStateHelper.is_block_broken(status_extension) then
		status_extension:set_block_broken(false)
		csm:change_state("stunned", movement_settings_table.stun_settings.parry_broken)

		return
	end

	if CharacterStateHelper.is_colliding_down(unit) and Mover.flying_frames(Unit.mover(unit)) == 0 then
		csm:change_state("walking")

		return
	end

	if not csm.state_next and not self.locomotion_extension:is_colliding_down() then
		csm:change_state("falling", self.temp_params)

		return
	end

	local inventory_extension = self.inventory_extension
	local move_speed = math.clamp(movement_settings_table.move_speed, 0, PlayerUnitMovementSettings.move_speed)
	local move_speed_multiplier = status_extension:current_move_speed_multiplier()
	move_speed = move_speed * move_speed_multiplier
	move_speed = move_speed * movement_settings_table.player_speed_scale
	move_speed = move_speed * movement_settings_table.player_air_speed_scale

	CharacterStateHelper.move_in_air(self.first_person_extension, input_extension, self.locomotion_extension, move_speed, unit)
	CharacterStateHelper.look(input_extension, self.player.viewport_name, self.first_person_extension, status_extension, self.inventory_extension)
	CharacterStateHelper.update_weapon_actions(t, unit, input_extension, inventory_extension, self.damage_extension)
	CharacterStateHelper.reload(input_extension, inventory_extension, status_extension)

	local interactor_extension = self.interactor_extension

	if CharacterStateHelper.is_starting_interaction(input_extension, interactor_extension) then
		local config = interactor_extension:interaction_config()

		interactor_extension:start_interaction("interacting")

		if not config.allow_movement then
			local params = self.temp_params
			params.swap_to_3p = config.swap_to_3p

			csm:change_state("interacting", params)
		end

		return
	end

	if CharacterStateHelper.is_interacting(interactor_extension) then
		local config = interactor_extension:interaction_config()

		if not config.allow_movement then
			local params = self.temp_params
			params.swap_to_3p = config.swap_to_3p

			csm:change_state("interacting", params)
		end

		return
	end
end

return
