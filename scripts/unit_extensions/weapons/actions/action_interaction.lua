ActionInteraction = class(ActionInteraction)
ActionInteraction.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.item_name = item_name
	self.interactor_extension = ScriptUnit.extension(owner_unit, "interactor_system")
	self.status_extension = ScriptUnit.extension(owner_unit, "status_system")
	self.buff_extension = ScriptUnit.extension(owner_unit, "buff_system")

	return 
end
ActionInteraction.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	local interactor_extension = self.interactor_extension
	local interaction_type = new_action.interaction_type

	if self.buff_extension:has_buff_type("no_interruption_bandage") then
		self.status_extension:set_blocking(true)
	end

	self.interactor_extension:start_interaction(new_action.hold_input, nil, interaction_type)

	return 
end
ActionInteraction.client_owner_post_update = function (self, dt, t, world, can_damage)
	return 
end
ActionInteraction.finish = function (self, reason)
	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local player = player_manager.unit_owner(player_manager, self.owner_unit)
		local player_id = player.telemetry_id(player)
		local hero = player.profile_display_name(player)
		local position = POSITION_LOOKUP[self.owner_unit]

		Managers.telemetry:add_item_use_telemetry(player_id, hero, self.item_name, position)
	end

	self.status_extension:set_blocking(false)

	return 
end

return 
