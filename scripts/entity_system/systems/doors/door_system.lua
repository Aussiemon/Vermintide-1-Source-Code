require("scripts/unit_extensions/level/door_extension")
require("scripts/unit_extensions/level/simple_door_extension")

DoorSystem = class(DoorSystem, ExtensionSystemBase)
local RPCS = {
	"rpc_sync_door_state"
}
local extensions = {
	"DoorExtension",
	"SimpleDoorExtension"
}

DoorSystem.init = function (self, entity_system_creation_context, system_name)
	DoorSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate:register(self, unpack(RPCS))

	self.unit_extension_data = {}
	self._broadphase = Broadphase(127, 1.5)
end

DoorSystem.on_add_extension = function (self, world, unit, extension_name, ...)
	local door_extension = DoorSystem.super.on_add_extension(self, world, unit, extension_name)
	self.unit_extension_data[unit] = door_extension
	local position = Unit.world_position(unit, 0)
	door_extension.__broadphase_id = Broadphase.add(self._broadphase, unit, position, 0.5)

	return door_extension
end

DoorSystem.get_doors = function (self, position, radius, result)
	return Broadphase.query(self._broadphase, position, radius, result)
end

DoorSystem.on_remove_extension = function (self, unit, extension_name)
	DoorSystem.super.on_remove_extension(self, unit, extension_name)

	local extension = self.unit_extension_data[unit]

	Broadphase.remove(self._broadphase, extension.__broadphase_id)

	self.unit_extension_data[unit] = nil
end

DoorSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)

	self.network_event_delegate = nil
	self.unit_extension_data = nil
	self._broadphase = nil
end

DoorSystem.rpc_sync_door_state = function (self, sender, level_object_id, door_state_id)
	local level = LevelHelper:current_level(self.world)
	local door_unit = Level.unit_by_index(level, level_object_id)
	local door_extension = ScriptUnit.extension(door_unit, "door_system")
	local new_state = NetworkLookup.door_states[door_state_id]

	door_extension:set_door_state(new_state)
end

return
