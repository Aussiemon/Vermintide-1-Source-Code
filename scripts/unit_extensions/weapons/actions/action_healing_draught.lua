ActionHealingDraught = class(ActionHealingDraught)

ActionHealingDraught.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.item_name = item_name

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end
end

ActionHealingDraught.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
end

ActionHealingDraught.client_owner_post_update = function (self, dt, t, world, can_damage)
	return
end

ActionHealingDraught.finish = function (self, reason)
	local current_action = self.current_action
	local owner_unit = self.owner_unit
	local network_manager = Managers.state.network
	local network_transmit = network_manager.network_transmit

	if reason ~= "action_complete" then
		return
	end

	if current_action.dialogue_event then
		local dialogue_input = ScriptUnit.extension_input(owner_unit, "dialogue_system")
		local event_data = FrameTable.alloc_table()

		dialogue_input:trigger_networked_dialogue_event(current_action.dialogue_event, event_data)

		if ScriptUnit.extension(owner_unit, "health_system"):current_health() > 50 then
			local target_name = ScriptUnit.extension(owner_unit, "dialogue_system").context.player_profile

			SurroundingAwareSystem.add_event(owner_unit, "early_healing_draught", DialogueSettings.default_view_distance, "target_name", target_name)
		end
	end

	if self.is_server or LEVEL_EDITOR_TEST then
		DamageUtils.heal_network(owner_unit, owner_unit, 75, "healing_draught")
	else
		local owner_unit_id = network_manager:unit_game_object_id(owner_unit)
		local heal_type_id = NetworkLookup.heal_types.healing_draught

		network_transmit:send_rpc_server("rpc_request_heal", owner_unit_id, 75, heal_type_id)
	end

	local ammo_extension = self.ammo_extension

	if ammo_extension then
		local ammo_usage = current_action.ammo_usage
		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
		local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.NOT_CONSUME_MEDPACK)

		if not procced then
			ammo_extension:use_ammo(ammo_usage)
		end
	end

	local player = Managers.player:unit_owner(owner_unit)
	local position = POSITION_LOOKUP[owner_unit]

	Managers.telemetry.events:player_use_item(player, self.item_name, position)
end

return
