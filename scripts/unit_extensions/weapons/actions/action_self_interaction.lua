ActionSelfInteraction = class(ActionSelfInteraction)
ActionSelfInteraction.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.item_name = item_name
	self.interactor_extension = ScriptUnit.extension(owner_unit, "interactor_system")

	return 
end
ActionSelfInteraction.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	local interactor_extension = self.interactor_extension
	local interaction_type = new_action.interaction_type

	self.interactor_extension:start_interaction(new_action.hold_input, self.owner_unit, interaction_type)

	return 
end
ActionSelfInteraction.client_owner_post_update = function (self, dt, t, world, can_damage)
	return 
end
ActionSelfInteraction.finish = function (self, reason)
	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local player = player_manager.unit_owner(player_manager, self.owner_unit)
		local player_id = player.telemetry_id(player)
		local hero = player.profile_display_name(player)
		local position = POSITION_LOOKUP[self.owner_unit]

		Managers.telemetry:add_item_use_telemetry(player_id, hero, self.item_name, position)
	end

	return 
end

return 
