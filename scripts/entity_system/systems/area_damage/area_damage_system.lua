AreaDamageSystem = class(AreaDamageSystem, ExtensionSystemBase)
local RPCS = {
	"rpc_enable_area_damage"
}
local extensions = {
	"AreaDamageExtension"
}

AreaDamageSystem.init = function (self, entity_system_creation_context, system_name)
	AreaDamageSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate:register(self, unpack(RPCS))
end

AreaDamageSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)
end

AreaDamageSystem.enable_area_damage = function (self, unit, enable)
	fassert(self.is_server, "You better call this on the server, or it's gonna craaash")

	local area_damage_extension = ScriptUnit.extension(unit, "area_damage_system")

	area_damage_extension:enable(enable)

	local level_index = Managers.state.network:level_object_id(unit)

	self.network_transmit:send_rpc_clients("rpc_enable_area_damage", level_index, enable)
end

AreaDamageSystem.rpc_enable_area_damage = function (self, sender, level_index, enable)
	local unit = Managers.state.network:game_object_or_level_unit(level_index, true)
	local area_damage_extension = ScriptUnit.extension(unit, "area_damage_system")

	area_damage_extension:enable(enable)
end

return
