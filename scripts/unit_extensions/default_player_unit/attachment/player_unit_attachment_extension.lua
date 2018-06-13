require("scripts/helpers/attachment_utils")
require("scripts/managers/backend/backend_utils")

PlayerUnitAttachmentExtension = class(PlayerUnitAttachmentExtension)
script_data.attachment_debug = script_data.attachment_debug or Development.parameter("attachment_debug")

PlayerUnitAttachmentExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._world = extension_init_context.world
	self._unit = unit
	self._profile = extension_init_data.profile
	self._is_server = extension_init_data.is_server
	self._player = extension_init_data.player
	self._profile_index = FindProfileIndex(self._profile.display_name)
	self.current_item_buffs = {}
	self._attachments = {
		slots = {}
	}
end

PlayerUnitAttachmentExtension.extensions_ready = function (self, world, unit)
	self.buff_extension = ScriptUnit.extension(unit, "buff_system")
	local attachments = self._attachments
	local profile = self._profile
	local attachment_slots = InventorySettings.attachment_slots
	local slots_n = #attachment_slots

	for i = 1, slots_n, 1 do
		repeat
			local slot = attachment_slots[i]
			local slot_name = slot.name
			local item_data = ItemHelper.get_loadout_item(slot_name, profile)

			if not item_data then
				break
			end

			self:create_attachment(slot_name, item_data)
		until true
	end

	self:show_attachments(false)
end

PlayerUnitAttachmentExtension.game_object_initialized = function (self, unit, unit_go_id)
	local attachments = self._attachments
	local slots = attachments.slots
	local network_manager = Managers.state.network
	local is_server = self._is_server

	for slot_name, slot_data in pairs(slots) do
		local slot_id = NetworkLookup.equipment_slots[slot_name]
		local item_id = NetworkLookup.item_names[slot_data.item_data.name]

		if is_server then
			network_manager.network_transmit:send_rpc_clients("rpc_create_attachment", unit_go_id, slot_id, item_id)
		else
			network_manager.network_transmit:send_rpc_server("rpc_create_attachment", unit_go_id, slot_id, item_id)
		end
	end
end

PlayerUnitAttachmentExtension.destroy = function (self)
	local slots = self._attachments.slots

	for slot_name, slot_data in pairs(slots) do
		AttachmentUtils.destroy_attachment(self._world, self._unit, slot_data)
	end
end

PlayerUnitAttachmentExtension.update = function (self, unit, input, dt, context, t)
	self:update_resync_loadout()
end

PlayerUnitAttachmentExtension.hot_join_sync = function (self, sender)
	AttachmentUtils.hot_join_sync(sender, self._unit, self._attachments.slots)
end

PlayerUnitAttachmentExtension.create_attachment = function (self, slot_name, item_data)
	local attachments = self._attachments
	local unit = self._unit
	local slot_data = AttachmentUtils.create_attachment(self._world, unit, attachments, slot_name, item_data, false)
	attachments.slots[slot_name] = slot_data
	local item_data = slot_data.item_data

	if not ScriptUnit.extension(unit, "first_person_system").first_person_mode then
		local item_template = BackendUtils.get_item_template(item_data)
		local show_attachments_event = item_template.show_attachments_event

		if show_attachments_event then
			Unit.flow_event(unit, show_attachments_event)
		end
	end

	AttachmentUtils.apply_attachment_buffs(self.current_item_buffs, self.buff_extension, slot_name, item_data)
end

PlayerUnitAttachmentExtension.remove_attachment = function (self, slot_name)
	local slot_data = self._attachments.slots[slot_name]

	if slot_data == nil then
		return
	end

	AttachmentUtils.destroy_attachment(self._world, self._unit, slot_data)
	AttachmentUtils.remove_attachment_buffs(self.current_item_buffs, self.buff_extension, slot_name)

	local item_data = slot_data.item_data
	self._attachments.slots[slot_name] = nil
	local network_manager = Managers.state.network
	local unit_go_id = network_manager:unit_game_object_id(self._unit)
	local slot_id = NetworkLookup.equipment_slots[slot_name]

	if self._is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_remove_attachment", unit_go_id, slot_id)
	else
		network_manager.network_transmit:send_rpc_server("rpc_remove_attachment", unit_go_id, slot_id)
	end
end

PlayerUnitAttachmentExtension.attachments = function (self)
	return self._attachments
end

PlayerUnitAttachmentExtension.show_attachments = function (self, show)
	local slots = self._attachments.slots

	for slot_name, slot_data in pairs(slots) do
		local unit = slot_data.unit

		Unit.set_unit_visibility(unit, show)

		if show then
			Unit.flow_event(unit, "lua_attachment_unhidden")

			local item_data = slot_data.item_data
			local item_template = BackendUtils.get_item_template(item_data)
			local show_attachments_event = item_template.show_attachments_event

			if show_attachments_event then
				Unit.flow_event(self._unit, show_attachments_event)
			end
		else
			Unit.flow_event(unit, "lua_attachment_hidden")
		end
	end
end

PlayerUnitAttachmentExtension.create_attachment_in_slot = function (self, slot_name, backend_id)
	local item_data = BackendUtils.get_item_from_masterlist(backend_id)
	local slot_data = self._attachments.slots[slot_name]
	local attachment_already_equiped = slot_data and slot_data.item_data == item_data
	local item_name = item_data.name

	if attachment_already_equiped then
		return
	end

	self:remove_attachment(slot_name)

	self._item_to_spawn = {
		slot_id = slot_name,
		item_data = item_data
	}
	self.resync_loadout_needed = true
end

PlayerUnitAttachmentExtension.update_resync_loadout = function (self)
	local equipment_to_spawn = self._item_to_spawn

	if not equipment_to_spawn then
		return
	end

	if self.resync_loadout_needed then
		self.resync_id = self:resync_loadout(equipment_to_spawn)
		self.resync_loadout_needed = false
	end

	local resync_id = self.resync_id

	if resync_id and self:all_clients_loaded_resource(resync_id) then
		self:spawn_resynced_loadout(equipment_to_spawn)

		self._item_to_spawn = nil
		self.resync_id = nil
	end
end

PlayerUnitAttachmentExtension.resync_loadout = function (self, equipment_to_spawn)
	if not equipment_to_spawn then
		return
	end

	local network_manager = Managers.state.network
	local resync_id = network_manager.profile_synchronizer:resync_loadout(self._profile_index, self._player)

	return resync_id
end

PlayerUnitAttachmentExtension.all_clients_loaded_resource = function (self, resync_id)
	local profile_synchronizer = Managers.state.network.profile_synchronizer
	local all_clients_have_loaded_resources = profile_synchronizer:all_clients_have_loaded_sync_id(resync_id)

	return all_clients_have_loaded_resources
end

PlayerUnitAttachmentExtension.spawn_resynced_loadout = function (self, item_to_spawn)
	local slot_name = item_to_spawn.slot_id
	local item_data = item_to_spawn.item_data
	local network_manager = Managers.state.network
	local unit_object_id = Managers.state.unit_storage:go_id(self._unit)
	local slot_id = NetworkLookup.equipment_slots[slot_name]
	local item_id = NetworkLookup.item_names[item_data.name]
	local is_server = self._is_server

	if is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_create_attachment", unit_object_id, slot_id, item_id)
	else
		network_manager.network_transmit:send_rpc_server("rpc_create_attachment", unit_object_id, slot_id, item_id)
	end

	self:create_attachment(slot_name, item_data)
end

return
