require("scripts/settings/player_movement_settings")

PlayerCharacterStateCatapulted = class(PlayerCharacterStateCatapulted, PlayerCharacterState)
local position_lookup = POSITION_LOOKUP
local DIRECTIONS = PlayerUnitMovementSettings.catapulted.directions
PlayerCharacterStateCatapulted.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "catapulted")

	return 
end
PlayerCharacterStateCatapulted.on_enter = function (self, unit, input, dt, context, t, previous_state, direction)
	CharacterStateHelper.stop_weapon_actions(self.inventory_extension, "stunned")

	self._direction = direction
	local anim = DIRECTIONS[direction].start_animation

	CharacterStateHelper.play_animation_event(unit, anim)
	CharacterStateHelper.play_animation_event_first_person(self.first_person_extension, anim)
	self.first_person_extension:hide_weapons("catapulted")

	return 
end
PlayerCharacterStateCatapulted.on_exit = function (self, unit, input, dt, context, t, next_state)
	local direction = self._direction
	self._direction = nil
	self.status_extension.catapulted = false

	self.first_person_extension:unhide_weapons("catapulted")
	self.locomotion_extension:reset_maximum_upwards_velocity()

	if Managers.state.network:game() then
		CharacterStateHelper.play_animation_event(unit, "airtime_end")
	end

	return 
end
PlayerCharacterStateCatapulted.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local unit = self.unit
	local world = self.world
	local input_extension = self.input_extension
	local status_extension = self.status_extension

	if position_lookup[unit].z < -240 then
		print("Player has fallen outside the world -- kill meeeee ", position_lookup[unit].z)

		local go_id = self.unit_storage:go_id(unit)

		self.network_transmit:send_rpc_server("rpc_suicide", go_id)
	end

	if CharacterStateHelper.is_ledge_hanging(world, unit, self.temp_params) then
		csm.change_state(csm, "ledge_hanging", self.temp_params)

		return 
	end

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

	if CharacterStateHelper.is_colliding_down(unit) and self.locomotion_extension:current_velocity().z < 0 then
		local anim = DIRECTIONS[self._direction].land_animation

		CharacterStateHelper.play_animation_event(unit, anim)

		if CharacterStateHelper.is_moving(input_extension) then
			csm.change_state(csm, "walking")
		else
			csm.change_state(csm, "standing")
		end

		return 
	end

	if CharacterStateHelper.is_colliding_sides(unit) then
		local anim = DIRECTIONS[self._direction].wall_collide_animation

		CharacterStateHelper.play_animation_event(unit, anim)
		csm.change_state(csm, "standing")

		return 
	end

	local first_person_extension = self.first_person_extension

	CharacterStateHelper.look(input_extension, self.player.viewport_name, first_person_extension, status_extension, self.inventory_extension)

	return 
end

return 
