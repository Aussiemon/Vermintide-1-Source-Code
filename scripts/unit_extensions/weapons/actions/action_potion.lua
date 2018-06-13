ActionPotion = class(ActionPotion)

ActionPotion.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.world = world
	self.item_name = item_name

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end
end

ActionPotion.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
end

ActionPotion.client_owner_post_update = function (self, dt, t, world, can_damage)
	return
end

ActionPotion.finish = function (self, reason)
	if reason ~= "action_complete" then
		return
	end

	local current_action = self.current_action
	local owner_unit = self.owner_unit
	local buff_template = current_action.buff_template
	local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
	local potion_spread_tier = buff_extension:has_buff_type("potion_spread_area_tier3") and "tier3"
	potion_spread_tier = potion_spread_tier or (buff_extension:has_buff_type("potion_spread_area_tier2") and "tier2")
	potion_spread_tier = potion_spread_tier or (buff_extension:has_buff_type("potion_spread_area_tier1") and "tier1")
	local targets = {}

	if potion_spread_tier then
		local player_and_bot_units = PLAYER_AND_BOT_UNITS
		local num_player_units = #player_and_bot_units

		for i = 1, num_player_units, 1 do
			local player_unit = player_and_bot_units[i]
			local other_player_position = POSITION_LOOKUP[player_unit]
			local local_player_position = POSITION_LOOKUP[owner_unit]

			if Vector3.distance(local_player_position, other_player_position) < TrinketSpreadDistance then
				targets[#targets + 1] = player_unit
			end
		end

		buff_template = PotionSpreadTrinketTemplates[buff_template][potion_spread_tier]
	else
		targets[#targets + 1] = owner_unit
	end

	local num_targets = #targets
	local network_manager = Managers.state.network
	local buff_template_name_id = NetworkLookup.buff_templates[buff_template]
	local owner_unit_id = network_manager:unit_game_object_id(owner_unit)

	for i = 1, num_targets, 1 do
		local unit = targets[i]
		local unit_object_id = network_manager:unit_game_object_id(unit)
		local buff_extension = ScriptUnit.extension(unit, "buff_system")

		buff_extension:add_buff(buff_template)

		if self.is_server then
			network_manager.network_transmit:send_rpc_clients("rpc_add_buff", unit_object_id, buff_template_name_id, owner_unit_id)
		else
			network_manager.network_transmit:send_rpc_server("rpc_add_buff", unit_object_id, buff_template_name_id, owner_unit_id)
		end
	end

	if self.ammo_extension then
		local ammo_usage = current_action.ammo_usage
		local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.NOT_CONSUME_POTION)

		if not procced then
			self.ammo_extension:use_ammo(ammo_usage)
		else
			local inventory_extension = ScriptUnit.extension(owner_unit, "inventory_system")

			inventory_extension:wield_previous_weapon()
		end
	end

	local player = Managers.player:unit_owner(owner_unit)
	local position = POSITION_LOOKUP[owner_unit]

	Managers.telemetry.events:player_use_item(player, self.item_name, position)
end

return
