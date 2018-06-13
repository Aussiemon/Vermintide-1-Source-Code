PlayerHuskAttachmentExtension = class(PlayerHuskAttachmentExtension)

PlayerHuskAttachmentExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._world = extension_init_context.world
	self._unit = unit
	local profile = extension_init_data.profile
	local slots = extension_init_data.slots
	self._profile = profile
	self._slots = slots
	self._attachments = {
		slots = {}
	}
	self.current_item_buffs = {}
end

PlayerHuskAttachmentExtension.extensions_ready = function (self, world, unit)
	self.buff_extension = ScriptUnit.extension(unit, "buff_system")
end

PlayerHuskAttachmentExtension.destroy = function (self)
	local slots = self._attachments.slots

	for slot_name, slot_data in pairs(slots) do
		AttachmentUtils.destroy_attachment(self._world, self._unit, slot_data)
	end
end

PlayerHuskAttachmentExtension.update = function (self, unit, input, dt, context, t)
	return
end

PlayerHuskAttachmentExtension.hot_join_sync = function (self, sender)
	AttachmentUtils.hot_join_sync(sender, self._unit, self._attachments.slots)
end

PlayerHuskAttachmentExtension.create_attachment = function (self, slot_name, item_data)
	if not self._profile then
		return
	end

	local attachments = self._attachments
	local old_slot_data = attachments.slots[slot_name]

	if old_slot_data then
		self:remove_attachment(slot_name)
	end

	local slot_data = AttachmentUtils.create_attachment(self._world, self._unit, attachments, slot_name, item_data, true)
	local item_template = BackendUtils.get_item_template(item_data)
	local show_attachments_event = item_template.show_attachments_event

	if show_attachments_event then
		Unit.flow_event(self._unit, show_attachments_event)
	end

	AttachmentUtils.apply_attachment_buffs(self.current_item_buffs, self.buff_extension, slot_name, item_data)

	attachments.slots[slot_name] = slot_data
	local outline_extension = ScriptUnit.extension(self._unit, "outline_system")

	outline_extension:reapply_outline()
end

PlayerHuskAttachmentExtension.remove_attachment = function (self, slot_name)
	local slot_data = self._attachments.slots[slot_name]

	AttachmentUtils.destroy_attachment(self._world, self._unit, slot_data)
	AttachmentUtils.remove_attachment_buffs(self.current_item_buffs, self.buff_extension, slot_name)

	self._attachments.slots[slot_name] = nil
end

PlayerHuskAttachmentExtension.attachments = function (self)
	return self._attachments
end

return
