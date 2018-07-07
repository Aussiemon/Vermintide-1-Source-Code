require("scripts/settings/equipment/item_master_list")

ItemHelper = ItemHelper or {}
local item_type_templates = {
	melee = Weapons,
	ranged = Weapons,
	trinket = Attachments,
	hat = Attachments
}

ItemHelper.get_template_by_item_name = function (name)
	local item_data = ItemMasterList[name]

	assert(item_data, "Requested template for item %s which does not exist.", name)

	local slot_type = item_data.slot_type
	local template_name = item_data.template
	local temporary_template = item_data.temporary_template
	template_name = temporary_template or template_name
	local template = item_type_templates[slot_type][template_name]

	assert(template, "No template by name %s found for item_data %s.", template_name, name)

	return template
end

ItemHelper.get_loadout_item = function (slot, profile)
	local item_data = nil
	local profile_name = profile.display_name
	item_data = BackendUtils.get_loadout_item(profile_name, slot)

	return item_data
end

ItemHelper.get_slot_type = function (slot)
	local slots_n = #InventorySettings.slots

	for i = 1, slots_n, 1 do
		local slot_settings = InventorySettings[i]

		if slot_settings.name == slot then
			return slot_settings.type
		end
	end

	fassert(false, "no slot in InventorySettings.slots with name: ", slot)
end

ItemHelper.mark_backend_id_as_new = function (backend_id)
	local new_item_ids = PlayerData.new_item_ids or {}
	new_item_ids[backend_id] = true
	PlayerData.new_item_ids = new_item_ids

	Managers.save:auto_save(SaveFileName, SaveData, nil)
end

ItemHelper.unmark_backend_id_as_new = function (backend_id)
	local new_item_ids = PlayerData.new_item_ids

	assert(new_item_ids, "Requested to unmark item backend id %d without any save data.", backend_id)

	new_item_ids[backend_id] = nil

	Managers.save:auto_save(SaveFileName, SaveData, nil)
end

ItemHelper.get_new_backend_ids = function ()
	return PlayerData.new_item_ids
end

return
