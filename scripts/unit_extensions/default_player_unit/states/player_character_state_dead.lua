PlayerCharacterStateDead = class(PlayerCharacterStateDead, PlayerCharacterState)

PlayerCharacterStateDead.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "dead")
end

PlayerCharacterStateDead.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	self.despawn_time_start = t
	self.despawned = false
	self.switched_to_observer_camera = false

	CharacterStateHelper.play_animation_event(self.unit, "death")
	self.locomotion_extension:set_wanted_velocity(Vector3.zero())

	local inventory_extension = self.inventory_extension
	local is_inventory_hidden = not inventory_extension:is_showing_first_person_inventory() and not inventory_extension:is_showing_third_person_inventory()
	local first_person_extension = self.first_person_extension

	first_person_extension:set_wanted_player_height("knocked_down", t)
	first_person_extension:set_first_person_mode(false)

	if is_inventory_hidden then
		local include_local_player = true

		CharacterStateHelper.show_inventory_3p(unit, false, include_local_player, self.is_server, inventory_extension)
	end

	CharacterStateHelper.change_camera_state(self.player, "follow_third_person")
	inventory_extension:check_and_drop_pickups("death")
end

PlayerCharacterStateDead.on_exit = function (self, unit, input, dt, context, t, next_state)
	return
end

PlayerCharacterStateDead.update = function (self, unit, input, dt, context, t)
	local time_since_death = t - self.despawn_time_start

	if not self.switched_to_observer_camera and PlayerUnitDamageSettings.dead_player_destroy_time < time_since_death + 1 then
		self.switched_to_observer_camera = true

		CharacterStateHelper.change_camera_state(self.player, "observer")
	end

	if not self.despawned and PlayerUnitDamageSettings.dead_player_destroy_time < time_since_death then
		local player = Managers.player:unit_owner(unit)

		player:despawn()

		self.despawned = true
		MOOD_BLACKBOARD.knocked_down = false
		MOOD_BLACKBOARD.wounded = false
		MOOD_BLACKBOARD.bleeding_out = false
	end
end

return
