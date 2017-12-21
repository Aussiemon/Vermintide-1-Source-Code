require("scripts/managers/backend/backend_manager")

BackendUtils = {}
local placeholder_icon_textures = {
	melee = "icons_placeholder_melee_01",
	ranged = "icons_placeholder_ranged_01",
	hat = "icons_placeholder_hat_01",
	trinket = "icons_placeholder_trinket_01"
}
BackendUtils.get_inventory_items = function (profile, slot, rarity)
	local item_id_list = ScriptBackendItem.get_items(profile, slot, rarity)
	local items = {}

	for key, backend_id in pairs(item_id_list) do
		local item = BackendUtils.get_item_from_masterlist(backend_id)
		items[#items + 1] = item
	end

	return items
end

local function get_trait_description_value(value, formatting, trait_info, buff_template, rarity)
	if value == nil then
		return nil
	elseif type(value) == "number" then
		local formatting = formatting or "%.1f"

		return string.format(formatting, value)
	elseif type(value) == "string" then
		if not trait_info then
			local values = buff_template[value]
			local formatting = "%.1f"

			if rarity == "unique" then
				return string.format(formatting, values[2]*100)
			end

			return string.format(formatting, values[1]*100) .. " - " .. string.format(formatting, values[2]*100)
		end

		local data = trait_info[value]

		if data then
			local formatting = formatting or "%.1f"

			return string.format(formatting, data*100)
		else
			local values = buff_template[value]
			local formatting = "%.1f"

			if rarity == "unique" then
				return string.format(formatting, values[2]*100)
			end

			return string.format(formatting, values[1]*100) .. " - " .. string.format(formatting, values[2]*100)
		end
	end

	error("")

	return 
end

BackendUtils.get_trait_description = function (trait_key, rarity)
	local trait_template = BuffTemplates[trait_key]
	local description_text = (trait_template.description and Localize(trait_template.description)) or "Unknown"
	local buff_template = trait_template.buffs[1]
	local description_values = trait_template.description_values
	local description_formatting = trait_template.description_formatting

	if description_values then
		local value_1 = get_trait_description_value(description_values[1], description_formatting and description_formatting[1], nil, buff_template, rarity)
		local value_2 = get_trait_description_value(description_values[2], description_formatting and description_formatting[2], nil, buff_template, rarity)
		local value_3 = get_trait_description_value(description_values[3], description_formatting and description_formatting[3], nil, buff_template, rarity)
		local description_text2 = string.gsub(description_text, "%%.1f", "%%s")
		local description_text3 = string.gsub(description_text2, "%%d", "%%s")
		description_text = string.format(description_text3, value_1, value_2, value_3)
	end

	return description_text
end
BackendUtils.get_item_trait_description = function (backend_id, id)
	local all_items = ScriptBackendItem.get_all_backend_items()
	local backend_item = all_items[backend_id]

	if not backend_item then
		return "broken trait description"
	end

	local item_config = ItemMasterList[backend_item.key]
	local trait_key = item_config.traits[id]
	local trait_template = BuffTemplates[trait_key]
	local description_text = (trait_template.description and Localize(trait_template.description)) or "Unknown"
	local buff_template = trait_template.buffs[1]
	local description_values = trait_template.description_values
	local description_formatting = trait_template.description_formatting
	local rarity = item_config.rarity

	if description_values then
		local trait_info = nil
		local unlocked_traits = ScriptBackendItem.get_traits(backend_id)

		for _, trait_data in pairs(unlocked_traits) do
			if trait_key == trait_data.trait_name then
				trait_info = trait_data
			end
		end

		local value_1 = get_trait_description_value(description_values[1], description_formatting and description_formatting[1], trait_info, buff_template, rarity)
		local value_2 = get_trait_description_value(description_values[2], description_formatting and description_formatting[2], trait_info, buff_template, rarity)
		local value_3 = get_trait_description_value(description_values[3], description_formatting and description_formatting[3], trait_info, buff_template, rarity)
		local description_text2 = string.gsub(description_text, "%%.1f", "%%s")
		local description_text3 = string.gsub(description_text2, "%%d", "%%s")
		description_text = string.format(description_text3, value_1, value_2, value_3)
	end

	return description_text
end
BackendUtils.get_inventory_items_except_loadout = function (profile, slot, rarity)
	if profile == "all" then
		return {}
	end

	local item_id_list = ScriptBackendItem.get_items(profile, slot, rarity)
	local items = {}
	local slot_names = InventorySettings.slot_names_by_type[slot]

	for key, backend_id in pairs(item_id_list) do
		local should_add = true

		if slot_names then
			for _, slot_name in ipairs(slot_names) do
				local loadout_slot_item = BackendUtils.get_loadout_item(profile, slot_name)

				if loadout_slot_item and loadout_slot_item.backend_id == backend_id then
					should_add = false

					break
				end
			end
		end

		if should_add then
			local item = BackendUtils.get_item_from_masterlist(backend_id)
			items[#items + 1] = item
		end
	end

	return items
end
BackendUtils.get_loadout_item = function (profile, slot)
	if profile == "all" then
		return 
	end

	local backend_id = ScriptBackendItem.get_loadout_item_id(profile, slot)
	local item_data = (backend_id and BackendUtils.get_item_from_masterlist(backend_id)) or nil

	return item_data
end
BackendUtils.get_item_from_masterlist = function (backend_id)
	local item_master_list = ItemMasterList
	local key = ScriptBackendItem.get_key(backend_id)
	local item_master_list_data = item_master_list[key]
	local item_data = table.clone(item_master_list_data)
	item_data.backend_id = backend_id

	return item_data
end
BackendUtils.set_loadout_item = function (item, profile, slot)
	local backend_id = item and item.backend_id

	ScriptBackendItem.set_loadout_item(backend_id, profile, slot)

	return 
end
BackendUtils.get_item_template = function (item_data)
	local template = item_data.temporary_template or item_data.template
	local item_template = Weapons[template]

	if item_template then
		return item_template
	end

	item_template = Attachments[template]

	if item_template then
		return item_template
	end

	fassert(false, "no item_template for item: " .. item_data.key .. ", template name = " .. template)

	return 
end
BackendUtils.get_item_units = function (item_data)
	local left_hand_unit = item_data.left_hand_unit
	local right_hand_unit = item_data.right_hand_unit
	local unit = item_data.unit

	if left_hand_unit or right_hand_unit or unit then
		local units = {
			left_hand_unit = left_hand_unit,
			right_hand_unit = right_hand_unit,
			unit = unit
		}

		return units
	end

	fassert(false, "no left hand or right hand unit defined for : " .. item.key)

	return 
end
BackendUtils.debug_add_all_items_to_backend_local = function ()
	DefaultLocalBackendData.items = {}

	return 
end
BackendUtils.get_traits = function (backend_id)
	local traits = ScriptBackendItem.get_traits(backend_id)

	return traits
end
BackendUtils.item_has_trait = function (backend_id, trait_name)
	local traits = ScriptBackendItem.get_traits(backend_id)

	for _, trait_data in ipairs(traits) do
		if trait_data.trait_name == trait_name then
			return true
		end
	end

	return 
end
BackendUtils.add_trait = function (item_id, trait_name, variable, chance)
	if BackendUtils.item_has_trait(item_id, trait_name) then
		print(string.format("item_id: %d has the trait: %s with proc chance: %d", item_id, trait_name, chance))

		return 
	end

	ScriptBackendItem.add_trait(item_id, trait_name, variable, chance)

	return 
end
BackendUtils.remove_item = function (item_id)
	return ScriptBackendItem.remove_item(item_id)
end
BackendUtils.add_item = function (item_key)
	return ScriptBackendItem.award_item(item_key)
end
BackendUtils.get_tokens = function (token_type)
	return Vault.withdraw_single(token_type, ScriptBackendProfileAttribute.get(token_type) or 0)
end
BackendUtils.add_tokens = function (amount, token_type)
	local num_tokens = Vault.single_add(token_type, amount, ScriptBackendProfileAttribute.get(token_type) or 0)

	ScriptBackendProfileAttribute.set(token_type, num_tokens)

	return 
end
BackendUtils.remove_tokens = function (amount, token_type)
	local num_tokens = Vault.single_add(token_type, -amount, ScriptBackendProfileAttribute.get(token_type) or 0)

	fassert(0 <= num_tokens, "trying to remove %d, tokens for %s (%d)which would result in a negative amount of tokens", amount, token_type, num_tokens)
	ScriptBackendProfileAttribute.set(token_type, num_tokens)

	return 
end

return 
