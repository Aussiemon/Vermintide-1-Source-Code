local fix = {
	"Double",
	"Triple",
	"Quad",
	"Penta",
	"Hexa",
	"Hepta",
	"Octa",
	"Nona",
	"Deca",
	"Hendeca",
	"Dodeca",
	"Trideca",
	"Tetradeca",
	"Pentadeca",
	"Hexadeca",
	"Heptadeca",
	"Octadeca",
	"Enneadeca",
	"Icosa"
}
script_data.ledge_hanging_turned_off = script_data.ledge_hanging_turned_off or Development.parameter("ledge_hanging_turned_off")
TimesJumpedInAir = 0
PlayerCharacterStateFalling = class(PlayerCharacterStateFalling, PlayerCharacterState)
local position_lookup = POSITION_LOOKUP

PlayerCharacterStateFalling.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "falling")

	self.last_valid_nav_position = Vector3Box()
	self.ladder_shaking = false
end

PlayerCharacterStateFalling.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	local input_extension = self.input_extension
	local status_extension = self.status_extension

	status_extension:set_falling_height()

	self.falling_reason = previous_state

	self.locomotion_extension:set_maximum_upwards_velocity(math.huge)

	if previous_state ~= "jumping" then
		if CharacterStateHelper.is_moving(input_extension) then
			local move_anim = "jump_fwd"

			CharacterStateHelper.play_animation_event(unit, move_anim)
		else
			local move_anim = "jump_idle"

			CharacterStateHelper.play_animation_event(unit, move_anim)
		end
	end

	self.jumped = params.jumped
	local inventory_extension = self.inventory_extension

	CharacterStateHelper.look(input_extension, self.player.viewport_name, self.first_person_extension, status_extension, self.inventory_extension)
	CharacterStateHelper.update_weapon_actions(t, unit, input_extension, inventory_extension, self.damage_extension)

	self.is_active = true
	self.times_jumped_in_air = 0
	self.ladder_shaking = params.ladder_shaking or false

	if previous_state ~= "jumping" then
		ScriptUnit.extension(unit, "whereabouts_system"):set_fell()
	end
end

PlayerCharacterStateFalling.on_exit = function (self, unit, input, dt, context, t, next_state)
	if not Managers.state.network:game() or not next_state then
		return
	end

	self.locomotion_extension:reset_maximum_upwards_velocity()
	CharacterStateHelper.play_animation_event(unit, "land_still")
	CharacterStateHelper.play_animation_event(unit, "to_onground")

	self.is_active = false
	self.jumped = nil

	if next_state == "walking" or next_state == "standing" then
		ScriptUnit.extension(unit, "whereabouts_system"):set_landed()
	else
		ScriptUnit.extension(unit, "whereabouts_system"):set_no_landing()
	end
end

PlayerCharacterStateFalling.update = function (self, unit, input, dt, context, t)
	local velocity = self.locomotion_extension:current_velocity()
	local self_pos = POSITION_LOOKUP[unit]
	local world = self.world

	if velocity.z > 0 then
		self.start_fall_height = position_lookup[unit].z
	end

	CharacterStateHelper.update_dodge_lock(unit, self.input_extension, self.status_extension)

	if position_lookup[unit].z < -240 then
		print("Player has fallen outside the world -- kill meeeee", position_lookup[unit].z)

		local go_id = self.unit_storage:go_id(unit)

		self.network_transmit:send_rpc_server("rpc_suicide", go_id)
	end

	local csm = self.csm
	local unit = self.unit
	local input_extension = self.input_extension
	local status_extension = self.status_extension

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return
	end

	if CharacterStateHelper.is_overcharge_exploding(status_extension) then
		csm:change_state("overcharge_exploding")

		return
	end

	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)

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

	if not csm.state_next and CharacterStateHelper.is_colliding_down(unit) then
		if CharacterStateHelper.is_moving(input_extension) then
			csm:change_state("walking")
		else
			csm:change_state("standing")
		end

		return
	end

	local colliding_with_ladder, ladder_unit = CharacterStateHelper.is_colliding_with_gameplay_collision_box(world, unit, "filter_ladder_collision")
	local recently_left_ladder = CharacterStateHelper.recently_left_ladder(status_extension, t)

	if colliding_with_ladder and not recently_left_ladder and not self.ladder_shaking then
		local top_node = Unit.node(ladder_unit, "c_platform")
		local ladder_rot = Unit.local_rotation(ladder_unit, 0)
		local ladder_plane_inv_normal = Quaternion.forward(ladder_rot)
		local ladder_offset = Unit.local_position(ladder_unit, 0) - self_pos
		local distance = Vector3.dot(ladder_plane_inv_normal, ladder_offset)
		local epsilon = 0.02

		if self_pos.z < Vector3.z(Unit.world_position(ladder_unit, top_node)) and distance > 0 and distance < 0.7 + epsilon then
			local params = self.temp_params
			params.ladder_unit = ladder_unit

			csm:change_state("climbing_ladder", params)

			return
		end
	end

	if CharacterStateHelper.is_ledge_hanging(world, unit, self.temp_params) then
		csm:change_state("ledge_hanging", self.temp_params)

		return
	end

	if script_data.use_super_jumps and input_extension:get("jump") then
		self.times_jumped_in_air = math.min(#fix, self.times_jumped_in_air + 1)
		local text = string.format("%sjump!", fix[self.times_jumped_in_air])

		Debug.sticky_text(text)

		local jump_speed = movement_settings_table.jump.stationary_jump.initial_vertical_velocity
		local velocity_current = self.locomotion_extension:current_velocity()
		local velocity_jump = Vector3(velocity_current.x, velocity_current.y, (velocity_current.z < -3 and jump_speed * 0.5) or jump_speed * 1.5)

		self.locomotion_extension:set_forced_velocity(velocity_jump)
		self.locomotion_extension:set_wanted_velocity(velocity_jump)
	end

	local inventory_extension = self.inventory_extension
	local move_speed = movement_settings_table.move_speed
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
