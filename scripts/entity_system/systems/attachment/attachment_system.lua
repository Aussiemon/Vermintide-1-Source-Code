require("scripts/unit_extensions/default_player_unit/attachment/player_unit_attachment_extension")
require("scripts/unit_extensions/default_player_unit/attachment/player_husk_attachment_extension")

AttachmentSystem = class(AttachmentSystem, ExtensionSystemBase)
local RPCS = {
	"rpc_create_attachment",
	"rpc_remove_attachment"
}
local extension_list = {
	"PlayerUnitAttachmentExtension",
	"PlayerHuskAttachmentExtension"
}

AttachmentSystem.init = function (self, entity_system_creation_context, system_name)
	AttachmentSystem.super.init(self, entity_system_creation_context, system_name, extension_list)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate:register(self, unpack(RPCS))
end

AttachmentSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)

	self.network_event_delegate = nil
end

AttachmentSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	extension_init_data.is_server = self.is_server

	return AttachmentSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data)
end

AttachmentSystem.rpc_create_attachment = function (self, sender, unit_go_id, slot_id, item_name_id)
	if self.is_server then
		self.network_transmit:send_rpc_clients_except("rpc_create_attachment", sender, unit_go_id, slot_id, item_name_id)
	end

	local unit_storage = self.unit_storage
	local unit = unit_storage:unit(unit_go_id)
	local attachment_extension = ScriptUnit.extension(unit, "attachment_system")
	local slot_name = NetworkLookup.equipment_slots[slot_id]
	local item_name = NetworkLookup.item_names[item_name_id]
	local item_data = ItemMasterList[item_name]

	attachment_extension:create_attachment(slot_name, item_data)
end

AttachmentSystem.rpc_remove_attachment = function (self, sender, unit_go_id, slot_id)
	if self.is_server then
		self.network_transmit:send_rpc_clients_except("rpc_remove_attachment", sender, unit_go_id, slot_id)
	end

	local unit_storage = self.unit_storage
	local unit = unit_storage:unit(unit_go_id)
	local attachment_extension = ScriptUnit.extension(unit, "attachment_system")
	local slot_name = NetworkLookup.equipment_slots[slot_id]

	attachment_extension:remove_attachment(slot_name)
end

return
