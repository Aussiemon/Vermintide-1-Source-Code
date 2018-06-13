AttachmentUtils = {}

AttachmentUtils.create_attachment = function (world, owner_unit, attachments, slot_name, item_data, show)
	assert(attachments.slots[slot_name] == nil, "Slot is not empty, remove attachment before creating a new one.")

	local item_template = BackendUtils.get_item_template(item_data)
	local item_units = BackendUtils.get_item_units(item_data)
	local unit_spawner = Managers.state.unit_spawner
	local unit = unit_spawner:spawn_local_unit(item_units.unit)

	Unit.set_unit_visibility(unit, show)

	if not show then
		Unit.flow_event(unit, "lua_attachment_hidden")
	end

	AttachmentUtils.link(world, owner_unit, unit, item_template.attachment_node_linking[slot_name])

	local slot_data = {
		unit = unit,
		name = item_data.name,
		item_data = item_data
	}

	return slot_data
end

AttachmentUtils.create_weapon_visual_attachment = function (world, owner_unit, unit_to_spawn, attachment_node_linking)
	local unit_spawner = Managers.state.unit_spawner
	local unit = unit_spawner:spawn_local_unit(unit_to_spawn)

	AttachmentUtils.link(world, owner_unit, unit, attachment_node_linking)

	return unit
end

AttachmentUtils.destroy_attachment = function (world, owner_unit, slot_data)
	local unit = slot_data.unit
	local unit_spawner = Managers.state.unit_spawner

	unit_spawner:mark_for_deletion(unit)
end

AttachmentUtils.link = function (world, source, target, node_linking)
	for _, link_data in ipairs(node_linking) do
		local source_node = link_data.source
		local target_node = link_data.target
		local source_node_index = (type(source_node) == "string" and Unit.node(source, source_node)) or source_node
		local target_node_index = (type(target_node) == "string" and Unit.node(target, target_node)) or target_node

		World.link_unit(world, target, target_node_index, source, source_node_index)
	end
end

AttachmentUtils.hot_join_sync = function (sender, unit, slots)
	local unit_go_id = Managers.state.unit_storage:go_id(unit)

	for slot_name, slot_data in pairs(slots) do
		repeat
			local slot = InventorySettings.slots_by_name[slot_name]

			if slot.category ~= "attachment" then
				break
			end

			local slot_id = NetworkLookup.equipment_slots[slot_name]
			local attachment_id = NetworkLookup.item_names[slot_data.name]

			RPC.rpc_create_attachment(sender, unit_go_id, slot_id, attachment_id)
		until true
	end
end

AttachmentUtils.apply_attachment_buffs = function (buffs_table, buff_extension, slot_name, item_data)
	local traits = item_data.traits

	if not traits then
		return
	end

	local num_buffs = #traits

	for i = 1, num_buffs, 1 do
		local buff_name = traits[i]

		fassert(BuffTemplates[buff_name], "trait / buff name %s does not exist, typo?", buff_name)

		if not buffs_table[slot_name] then
			buffs_table[slot_name] = {}
		end

		buffs_table[slot_name][i] = buff_extension:add_buff(buff_name)
	end
end

AttachmentUtils.remove_attachment_buffs = function (buffs_table, buff_extension, slot_name)
	local buff_ids = buffs_table[slot_name]

	if buff_ids then
		local num_buffs = #buff_ids

		for i = 1, num_buffs, 1 do
			local id = buff_ids[i]

			buff_extension:remove_buff(id)
		end
	end
end

return
