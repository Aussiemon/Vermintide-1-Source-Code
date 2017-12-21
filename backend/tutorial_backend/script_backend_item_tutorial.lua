ScriptBackendItemTutorial = ScriptBackendItemTutorial or {}
local forge_printf = (script_data.forge_debug and printf) or function ()
	return 
end
local forge_table_dump = (script_data.forge_debug and table.dump) or function ()
	return 
end

local function get_item(item_id)
	local items = Managers.backend._backend_data.items
	local item = items[item_id]

	return item
end

ScriptBackendItemTutorial.num_current_item_server_requests = function ()
	return 0
end
ScriptBackendItemTutorial.set_traits = function (backend_id, traits)
	ferror("Shouldn't use traits with tutorial backend")

	return 
end
ScriptBackendItemTutorial.add_trait = function (item_id, trait_name)
	ferror("Shouldn't use traits with tutorial backend")

	return 
end
ScriptBackendItemTutorial.get_traits = function (backend_id)
	return {}
end
ScriptBackendItemTutorial.make_dirty = function ()
	return 
end
ScriptBackendItemTutorial.get_key = function (item_id)
	local item = get_item(item_id)

	if item then
		return item.key
	end

	return 
end
ScriptBackendItemTutorial.get_item_from_id = function (backend_id)
	ferror("Only used in forge?")

	return 
end
ScriptBackendItemTutorial.get_item_id = function (key)
	ferror("Is this even used?")

	return 
end
ScriptBackendItemTutorial.get_loadout_item_id = function (profile, slot)
	return Managers.backend:_get_loadout_item_id(profile, slot)
end
ScriptBackendItemTutorial.set_loadout_item = function (item_id, profile, slot)
	Managers.backend:_set_loadout_item(item_id, profile, slot)

	return 
end
ScriptBackendItemTutorial.get_all_backend_items = function ()
	return Managers.backend:_get_all_backend_items()
end
ScriptBackendItemTutorial.get_items = function (profile, slot, rarity)
	return Managers.backend:_get_items(profile, slot, rarity)
end
ScriptBackendItemTutorial.get_filtered_items = function (filter)
	local all_items = Managers.backend:_get_all_backend_items()
	local items = ScriptBackendCommon.filter_items(all_items, filter)

	return items
end
ScriptBackendItemTutorial.remove_item = function (item_id)
	return Managers.backend:_remove_item(item_id)
end
ScriptBackendItemTutorial.award_item = function (item_key)
	return Managers.backend:_add_item(item_key)
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

	return 
end
ScriptBackendItemTutorial.upgrades_failed_game = function (level_start, level_end)
	return 
end
ScriptBackendItemTutorial.poll_upgrades_failed_game = function ()
	return {}
end
ScriptBackendItemTutorial.is_equipped = function (backend_id)
	return false
end
ScriptBackendItemTutorial.is_salvageable = function (backend_id)
	return true
end
ScriptBackendItemTutorial.equipped_by = function (backend_id)
	local loadout = Managers.backend:_get_loadout()

	for hero, slots in pairs(loadout) do
		for slot, id in pairs(slots) do
			if backend_id == id then
				return hero
			end
		end
	end

	return 
end
local rerolling_trait_state = false
ScriptBackendItemTutorial.set_rerolling_trait_state = function (state)
	ferror("Traits not needed in tutorial")

	return 
end
ScriptBackendItemTutorial.get_rerolling_trait_state = function ()
	return false
end
fuse_script_data = fuse_script_data or {}
ScriptBackendItemTutorial.forge = function (items, num_tokens, token_type)
	ferror("No need for forge in tutorial?")

	return 
end
ScriptBackendItemTutorial.check_for_loot = function ()
	ferror("No need for loot in tutorial?")

	return 
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

	return 
end
ScriptBackendItemTutorial.poll_forge = function ()
	ferror("No need for forge in tutorial?")

	return 
end

return 
