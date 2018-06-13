ScriptBackendItemTutorial = ScriptBackendItemTutorial or {}
local forge_printf = (script_data.forge_debug and printf) or function ()
	return
end
local forge_table_dump = (script_data.forge_debug and table.dump) or function ()
	return
end

local function get_item(item_id)
	local items = DefaultTutorialBackendData.items
	local item = items[item_id]

	return item
end

ScriptBackendItemTutorial.num_current_item_server_requests = function ()
	return 0
end

ScriptBackendItemTutorial.type = function ()
	return "tutorial"
end

ScriptBackendItemTutorial.set_traits = function (backend_id, traits)
	ferror("Shouldn't use traits with tutorial backend")
end

ScriptBackendItemTutorial.set_data_server_queue = function (queue)
	return
end

ScriptBackendItemTutorial.add_trait = function (item_id, trait_name)
	ferror("Shouldn't use traits with tutorial backend")
end

ScriptBackendItemTutorial.get_traits = function (backend_id)
	return {}
end

ScriptBackendItemTutorial.__dirtify = function ()
	return
end

ScriptBackendItemTutorial.make_dirty = function ()
	return
end

ScriptBackendItemTutorial.get_key = function (item_id)
	local item = get_item(item_id)

	if item then
		return item.key
	end
end

ScriptBackendItemTutorial.get_item_from_id = function (backend_id)
	ferror("Only used in forge?")
end

ScriptBackendItemTutorial.get_item_id = function (key)
	ferror("Is this even used?")
end

ScriptBackendItemTutorial.get_loadout_item_id = function (profile, slot)
	local backend_data_slots = DefaultTutorialBackendData.loadout
	local profile_slots = backend_data_slots[profile]

	for slot_name, item_id in pairs(profile_slots) do
		if slot == slot_name then
			return item_id
		end
	end

	return nil
end

ScriptBackendItemTutorial.set_loadout_item = function (item_id, profile, slot)
	return
end

ScriptBackendItemTutorial.get_all_backend_items = function ()
	return DefaultTutorialBackendData.items
end

ScriptBackendItemTutorial.get_items = function (profile, slot, rarity)
	local item_list = {}
	local item_master_list = ItemMasterList
	local backend_data_items = DefaultTutorialBackendData.items

	for id, _ in pairs(backend_data_items) do
		repeat
			local key = ScriptBackendItemTutorial.get_key(id)
			local item_data = item_master_list[key]
			local wrong_slot = slot and slot ~= item_data.slot_type

			if wrong_slot then
				break
			end

			local wrong_rarity = rarity and rarity ~= item_data.rarity

			if wrong_rarity then
				break
			end

			if profile ~= "all" then
				local can_wield = ScriptBackendCommon.can_wield(profile, item_data)

				if not can_wield then
					break
				end
			end

			item_list[#item_list + 1] = id
		until true
	end

	return item_list
end

ScriptBackendItemTutorial.get_filtered_items = function (filter)
	local all_items = ScriptBackendItemTutorial.get_all_backend_items()
	local items = ScriptBackendCommon.filter_items(all_items, filter)

	return items
end

ScriptBackendItemTutorial.remove_item = function (item_id)
	return
end

ScriptBackendItemTutorial.award_item = function (item_key)
	return
end

local difficulties = {
	"easy",
	"normal",
	"hard",
	"harder",
	"hardest"
}
local param_dice = param_dice or "wood,7;"
local param_difficulty = param_difficulty or "normal"
local param_level_start = 0
local param_level_end = 0
local param_hero_name = "witch_hunter"

ScriptBackendItemTutorial.generate_item_server_loot = function (dice, difficulty, level_start, level_end, hero_name)
	ferror("Loot not needed in tutorial")
end

ScriptBackendItemTutorial.upgrades_failed_game = function (level_start, level_end)
	return
end

ScriptBackendItemTutorial.poll_upgrades_failed_game = function ()
	return {}
end

ScriptBackendItemTutorial.update = function ()
	return
end

ScriptBackendItemTutorial.is_equipped = function (backend_id)
	return false
end

ScriptBackendItemTutorial.is_salvageable = function (backend_id)
	return true
end

ScriptBackendItemTutorial.equipped_by = function (backend_id)
	local loadout = DefaultTutorialBackendData.loadout

	for hero, slots in pairs(loadout) do
		for slot, id in pairs(slots) do
			if backend_id == id then
				return hero
			end
		end
	end
end

local rerolling_trait_state = false

ScriptBackendItemTutorial.set_rerolling_trait_state = function (state)
	ferror("Traits not needed in tutorial")
end

ScriptBackendItemTutorial.get_rerolling_trait_state = function ()
	return false
end

fuse_script_data = fuse_script_data or {}

ScriptBackendItemTutorial.forge = function (items, num_tokens, token_type)
	ferror("No need for forge in tutorial?")
end

ScriptBackendItemTutorial.check_for_loot = function ()
	ferror("No need for loot in tutorial?")
end

local rarity_table_by_index = {
	"plentiful",
	"common",
	"rare",
	"exotic",
	"unique"
}
local get_next_rarity, get_random_item, split_string_to_table = nil
local forged_item_data = {}

ScriptBackendItemTutorial.forge = function (items)
	ferror("No need for forge in tutorial?")
end

ScriptBackendItemTutorial.poll_forge = function ()
	ferror("No need for forge in tutorial?")
end

local boons = {}

ScriptBackendItemTutorial.poll_boons = function ()
	return boons, false
end

return
