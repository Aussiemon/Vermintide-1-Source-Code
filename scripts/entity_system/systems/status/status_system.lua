require("scripts/unit_extensions/generic/generic_status_extension")

StatusSystem = class(StatusSystem, ExtensionSystemBase)
local RPCS = {
	"rpc_status_change_bool",
	"rpc_set_catapulted",
	"rpc_set_blocking",
	"rpc_player_blocked_attack",
	"rpc_set_wounded",
	"rpc_hooked_sync",
	"rpc_hot_join_sync_health_status",
	"rpc_replenish_fatigue_other_players"
}
local extensions = {
	"GenericStatusExtension"
}
StatusSystem.init = function (self, entity_system_creation_context, system_name)
	StatusSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))

	return 
end
StatusSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)

	return 
end
StatusSystem.rpc_hooked_sync = function (self, sender, status_id, game_object_id, time_left)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	local status_ext = ScriptUnit.extension(unit, "status_system")
	local t = Managers.time:time("game")
	local status = NetworkLookup.statuses[status_id]

	if status == "pack_master_dropping" then
		status_ext.release_falling_time = t + time_left
	elseif status == "pack_master_unhooked" then
		status_ext.release_unhook_time_left = t + time_left
	end

	return 
end
StatusSystem.rpc_status_change_bool = function (self, sender, status_id, status_bool, game_object_id, other_object_id)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	local other_unit = self.unit_storage:unit(other_object_id)
	local status_ext = ScriptUnit.extension(unit, "status_system")
	local status = NetworkLookup.statuses[status_id]
	local level = LevelHelper:current_level(self.world)

	if status == "pushed" then
		status_ext.set_pushed(status_ext, status_bool)
	elseif status == "pounced_down" then
		status_ext.set_pounced_down(status_ext, status_bool, other_unit)
	elseif status == "dead" then
		status_ext.set_dead(status_ext, status_bool)
	elseif status == "knocked_down" then
		status_ext.set_knocked_down(status_ext, status_bool)
	elseif status == "revived" then
		status_ext.set_revived(status_ext, status_bool, other_unit)
	elseif status == "catapulted" then
		status_ext.set_catapulted(status_ext, status_bool)
	elseif status == "pack_master_pulling" then
		status_ext.set_pack_master(status_ext, "pack_master_pulling", status_bool, other_unit)
	elseif status == "pack_master_dragging" then
		status_ext.set_pack_master(status_ext, "pack_master_dragging", status_bool, other_unit)
	elseif status == "pack_master_hoisting" then
		status_ext.set_pack_master(status_ext, "pack_master_hoisting", status_bool, other_unit)
	elseif status == "pack_master_hanging" then
		status_ext.set_pack_master(status_ext, "pack_master_hanging", status_bool, other_unit)
	elseif status == "pack_master_dropping" then
		status_ext.set_pack_master(status_ext, "pack_master_dropping", status_bool, other_unit)
	elseif status == "pack_master_released" then
		status_ext.set_pack_master(status_ext, "pack_master_released", status_bool, other_unit)
	elseif status == "pack_master_unhooked" then
		status_ext.set_pack_master(status_ext, "pack_master_unhooked", status_bool, other_unit)
	elseif status == "crouching" then
		status_ext.set_crouching(status_ext, status_bool)
	elseif status == "pulled_up" then
		status_ext.set_pulled_up(status_ext, status_bool, other_unit)
	elseif status == "ladder_climbing" then
		local ladder_unit = Level.unit_by_index(level, other_object_id)

		status_ext.set_is_on_ladder(status_ext, status_bool, ladder_unit)
	elseif status == "ledge_hanging" then
		local ledge_unit = Level.unit_by_index(level, other_object_id)

		status_ext.set_is_ledge_hanging(status_ext, status_bool, ledge_unit)
	elseif status == "ready_for_assisted_respawn" then
		local flavour_unit = Level.unit_by_index(level, other_object_id)

		status_ext.set_ready_for_assisted_respawn(status_ext, status_bool, flavour_unit)
	elseif status == "assisted_respawning" then
		status_ext.set_assisted_respawning(status_ext, status_bool, other_unit)
	elseif status == "respawned" then
		status_ext.set_respawned(status_ext, status_bool)
	elseif status == "overchage_exploding" then
		status_ext.set_overcharge_exploding(status_ext, status_bool)
	else
		assert("Unhandled status %s", tostring(status))
	end

	if Managers.player.is_server then
		Managers.state.network.network_transmit:send_rpc_clients_except("rpc_status_change_bool", sender, status_id, status_bool, game_object_id, other_object_id)
	end

	return 
end
StatusSystem.rpc_set_wounded = function (self, sender, game_object_id, wounded, reason_id)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	local status_extension = ScriptUnit.extension(unit, "status_system")
	local reason = NetworkLookup.set_wounded_reasons[reason_id]

	status_extension.set_wounded(status_extension, wounded, reason)

	return 
end
StatusSystem.rpc_set_catapulted = function (self, sender, unit_id, velocity)
	local unit = self.unit_storage:unit(unit_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	local status_extension = ScriptUnit.extension(unit, "status_system")

	status_extension.set_catapulted(status_extension, true, velocity)

	return 
end
StatusSystem.rpc_set_blocking = function (self, sender, game_object_id, blocking)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	local status_extension = ScriptUnit.extension(unit, "status_system")

	status_extension.set_blocking(status_extension, blocking)

	if self.is_server then
		self.network_transmit:send_rpc_clients_except("rpc_set_blocking", sender, game_object_id, blocking)
	end

	return 
end
StatusSystem.rpc_player_blocked_attack = function (self, sender, game_object_id, fatigue_type_id, attacking_unit_id)
	local unit = self.unit_storage:unit(game_object_id)
	local attacking_unit = self.unit_storage:unit(attacking_unit_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	local fatigue_type = NetworkLookup.fatigue_types[fatigue_type_id]
	local status_extension = ScriptUnit.extension(unit, "status_system")

	status_extension.blocked_attack(status_extension, fatigue_type, attacking_unit)

	return 
end
StatusSystem.rpc_hot_join_sync_health_status = function (self, sender, game_object_id, wounded, wounds, ready_for_assisted_respawn, respawn_unit_game_object_id)
	local unit = self.unit_storage:unit(game_object_id)
	local status_extension = ScriptUnit.extension(unit, "status_system")
	status_extension.wounded = wounded
	status_extension.wounds = wounds

	if ready_for_assisted_respawn then
		status_extension.set_ready_for_assisted_respawn(status_extension, ready_for_assisted_respawn, self.unit_storage:unit(respawn_unit_game_object_id))
	end

	return 
end
StatusSystem.rpc_replenish_fatigue_other_players = function (self, sender, fatigue_type_id)
	if self.is_server then
		self.network_transmit:send_rpc_clients_except("rpc_replenish_fatigue_other_players", sender, fatigue_type_id)
	end

	local fatigue_type = NetworkLookup.fatigue_types[fatigue_type_id]

	StatusUtils.replenish_stamina_local_players(nil, fatigue_type)

	return 
end

return 
