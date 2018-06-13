BuffUtils = BuffUtils or {}
script_data.debug_legendary_traits = script_data.debug_legendary_traits or Development.parameter("debug_legendary_traits")

BuffUtils.trigger_assist_buffs = function (savior_player, saved_player)
	local savior_unit = savior_player.player_unit
	local saved_unit = saved_player.player_unit

	if not Unit.alive(savior_unit) or not Unit.alive(saved_unit) then
		return
	end

	local status_ext = ScriptUnit.extension(saved_unit, "status_system")
	local is_knocked_down = status_ext:is_knocked_down()

	if is_knocked_down then
		local buff_ext = ScriptUnit.extension(savior_unit, "buff_system")
		local heal_amount, procced = buff_ext:apply_buffs_to_value(0, StatBuffIndex.HEALING_KNOCKED_DOWN_PLAYER_BY_ASSIST)
		local heal_type = "proc"

		if script_data.debug_legendary_traits then
			heal_amount = 10
			procced = true
		end

		if procced then
			if Managers.player.is_server or LEVEL_EDITOR_TEST then
				DamageUtils.heal_network(saved_unit, savior_unit, heal_amount, heal_type)
			else
				local network_manager = Managers.state.network
				local network_transmit = network_manager.network_transmit
				local owner_unit_id = network_manager:unit_game_object_id(saved_unit)
				local heal_type_id = NetworkLookup.heal_types[heal_type]

				network_transmit:send_rpc_server("rpc_request_heal", owner_unit_id, heal_amount, heal_type_id)
			end
		end
	end

	local buff_ext = ScriptUnit.extension(savior_unit, "buff_system")
	local saved_unit_damage_ext = ScriptUnit.extension(saved_unit, "damage_system")
	local shield_amount, procced = buff_ext:apply_buffs_to_value(0, StatBuffIndex.SHIELDING_PLAYER_BY_ASSIST)

	if script_data.debug_legendary_traits then
		shield_amount = 30
		procced = true
	end

	if procced and not saved_unit_damage_ext:has_assist_shield() then
		if Managers.player.is_server then
			DamageUtils.assist_shield_network(saved_unit, savior_unit, shield_amount)
		else
			local network_manager = Managers.state.network
			local network_transmit = network_manager.network_transmit
			local owner_unit_id = network_manager:unit_game_object_id(saved_unit)

			network_transmit:send_rpc_server("rpc_request_heal", owner_unit_id, shield_amount, NetworkLookup.heal_types.shield_by_assist)
		end
	end
end

return
