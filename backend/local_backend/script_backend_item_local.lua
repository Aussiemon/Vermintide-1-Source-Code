ScriptBackendItemLocal = ScriptBackendItemLocal or {}
ScriptBackendItemLocal.NAME = "ScriptBackendItemLocal"
local forge_printf = (script_data.forge_debug and printf) or function ()
	return 
end
local forge_table_dump = (script_data.forge_debug and table.dump) or function ()
	return 
end

local function get_item(item_id)
	local items = Managers.backend._save_data.items
	local item = items[item_id]

	return item
end

local SalvageableSlotTypes = {
	ranged = true,
	melee = true,
	hat = true,
	trinket = true
}
local SalvageableRarities = {
	common = true,
	plentiful = true,
	exotic = true,
	rare = true,
	unique = true
}
local CLEARABLE_SLOTS = {
	slot_trinket_2 = true,
	slot_trinket_3 = true,
	slot_trinket_1 = true
}
local MUST_HAVE_SLOTS = {
	slot_hat = true,
	slot_melee = true,
	slot_ranged = true
}
ScriptBackendItemLocal.type = function ()
	return "local"
end
ScriptBackendItemLocal.num_current_item_server_requests = function ()
	return 0
end
ScriptBackendItemLocal.set_traits = function (item_id, traits)
	local serialized_traits = ScriptBackendCommon.serialize_traits(traits)
	local item = get_item(item_id)
	item.traits = serialized_traits

	return 
end
ScriptBackendItemLocal.add_trait = function (backend_id, trait_name, variable, value)
	fassert(trait_name ~= "", "setting empty trait")

	local item = get_item(backend_id)
	local serialized_traits = item.traits

	if variable then
		serialized_traits = string.format("%s%s,%s,%.3f;", serialized_traits, trait_name, variable, value)
	else
		serialized_traits = string.format("%s%s;", serialized_traits, trait_name)
	end

	item.traits = item.traits .. serialized_traits

	return 
end
ScriptBackendItemLocal.get_traits = function (item_id)
	local item = get_item(item_id)
	local serialized_traits = item.traits
	local traits = {}

	for trait_name, variable, value in string.gmatch(serialized_traits, "([%w_]+),*([%w_]*),*([%w_%.]*);") do
		local trait_data = {
			trait_name = trait_name
		}

		if variable then
			trait_data[variable] = tonumber(value)
		end

		traits[#traits + 1] = trait_data
	end

	return traits
end
ScriptBackendItemLocal.make_dirty = function ()
	return 
end
ScriptBackendItemLocal.get_key = function (item_id)
	local item = get_item(item_id)

	if item then
		return item.key
	end

	return 
end
ScriptBackendItemLocal.get_item_from_id = function (backend_id)
	local items = Managers.backend._save_data.items

	return items[backend_id]
end
ScriptBackendItemLocal.get_item_id = function (key)
	local items = Managers.backend._save_data.items

	for backend_id, item in pairs(items) do
		if key == item.key then
			return backend_id
		end
	end

	error("no item with key " .. tostring(key) .. " in backend_local database")

	return 
end
ScriptBackendItemLocal.get_loadout_item_id = function (profile, slot)
	return Managers.backend:_get_loadout_item_id(profile, slot)
end
ScriptBackendItemLocal.set_loadout_item = function (item_id, profile, slot)
	Managers.backend:_set_loadout_item(item_id, profile, slot)

	return 
end
ScriptBackendItemLocal.get_all_backend_items = function ()
	return Managers.backend:_get_all_backend_items()
end
ScriptBackendItemLocal.get_items = function (profile, slot, rarity)
	return Managers.backend:_get_items(profile, slot, rarity)
end
ScriptBackendItemLocal.get_filtered_items = function (filter)
	local all_items = Managers.backend:_get_all_backend_items()
	local items = ScriptBackendCommon.filter_items(all_items, filter)

	return items
end
ScriptBackendItemLocal.remove_item = function (item_id)
	return Managers.backend:_remove_item(item_id)
end
ScriptBackendItemLocal.award_item = function (item_key)
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
ScriptBackendItemLocal.generate_item_server_loot = function (dice, difficulty, level_start, level_end, hero_name)
	local dice_string = ""

	for type, amount in pairs(dice) do
		dice_string = dice_string .. type .. "," .. tostring(amount) .. ";"
	end

	param_dice = dice_string
	param_difficulty = difficulty

	print("DIFFICULTY:", difficulty)

	param_level_start = level_start
	param_level_end = level_end
	param_hero_name = hero_name

	return 
end
ScriptBackendItemLocal.upgrades_failed_game = function (level_start, level_end)
	return 
end
ScriptBackendItemLocal.poll_upgrades_failed_game = function ()
	return {}
end
ScriptBackendItemLocal.is_equipped = function (backend_id, profile_name)
	if Application.platform() == "xb1" or Application.platform() == "ps4" then
		local loadout = SaveData.local_backend_save.loadout

		for hero, slots in pairs(loadout) do
			if not profile_name or hero == profile_name then
				for slot, id in pairs(slots) do
					if (MUST_HAVE_SLOTS[slot] or CLEARABLE_SLOTS[slot]) and backend_id == id then
						return true
					end
				end
			end
		end
	end

	return false
end
ScriptBackendItemLocal.is_salvageable = function (backend_id)
	if Application.platform() == "xb1" or Application.platform() == "ps4" then
		local unequipped = not ScriptBackendItem.is_equipped(backend_id)
		local items = SaveData.local_backend_save.items
		local item = items[backend_id]
		local item_config = ItemMasterList[item.key]
		local salvageable_slot_type = SalvageableSlotTypes[item_config.slot_type]
		local salvageable_rarity = SalvageableRarities[item_config.rarity]

		return unequipped and salvageable_slot_type and salvageable_rarity
	else
		return true
	end

	return 
end
ScriptBackendItemLocal.equipped_by = function (backend_id)
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
ScriptBackendItemLocal.set_rerolling_trait_state = function (state)
	rerolling_trait_state = state

	return 
end
ScriptBackendItemLocal.get_rerolling_trait_state = function ()
	return rerolling_trait_state
end
fuse_script_data = fuse_script_data or {}
ScriptBackendItemLocal.check_for_loot = function ()
	local level_up_rewards = LevelRewards:level_up_rewards(param_level_start, param_level_end)
	local num_successes, successes_serialized, dice = get_successes(param_dice)
	local win_list, win_list_serialized = get_win_list(num_successes, param_difficulty, param_hero_name)
	local item_key = win_list[num_successes]
	local dice_list = {}
	local backend_id = ScriptBackendItemLocal.award_item(item_key)

	for i = 1, #dice, 1 do
		local data = dice[i]
		dice_list[data.type] = data.successes
	end

	return dice_list, win_list, backend_id, level_up_rewards
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
ForgeItemsLocal = class(ForgeItemsLocal)
ForgeItemsLocal.init = function (self, item_key)
	self._items = {
		[0] = item_key
	}

	return 
end
ForgeItemsLocal.is_done = function (self)
	return true
end
ForgeItemsLocal.items = function (self)
	return self._items
end
ScriptBackendItemLocal.forge = function (items)
	print("##############")
	table.dump(items, "Items to Merge", 2)
	print("##############")

	local items_to_merge = ""

	for backend_id, item_key in pairs(items) do
		items_to_merge = string.format("%s%s,%s;", items_to_merge, item_key, backend_id)
	end

	print(items_to_merge)
	print("##############")

	local upgrade_name = grant_item(items_to_merge)

	for backend_id, item_key in pairs(items) do
		print("Removing:", item_key, backend_id)
		ScriptBackendItemLocal.remove_item(backend_id)
	end

	print("##############")
	print("Awarding item:", upgrade_name)
	print("##############")
	ScriptBackendItemLocal.award_item(upgrade_name)

	forged_item_data.item_key = upgrade_name

	return ForgeItemsLocal:new(upgrade_name)
end
ScriptBackendItemLocal.poll_forge = function ()
	if Application.platform() == "xb1" or Application.platform() == "ps4" then
		local item_key = forged_item_data.item_key
		forged_item_data.item_key = nil
		local backend_id = 0

		return item_key, backend_id
	else
		create_profile_entities()

		local items, parameters, error_message = fuse_script_local(fuse_script_data.items_serialized, fuse_script_data.num_tokens, fuse_script_data.token_type)
		local item_key, backend_id = nil

		if error_message then
			backend_items:set_error(error_message)
			backend_items:remove_item_server_request()
		elseif items then
			for _, key in pairs(items) do
				local id = Managers.backend:_add_item(key)
				item_key = key
				backend_id = id

				break
			end

			for item_id, _ in pairs(fuse_script_data.items) do
				Managers.backend:_remove_item(item_id)
			end
		end

		return item_key, backend_id
	end

	return 
end

function debug_give_all_item_type(item_type)
	local items = ItemMasterList
	local unowned_items = ScriptBackendCommon.filter_items(items, "item_type == " .. item_type .. " and not player_owns_item_key")

	if not table.is_empty(unowned_items) then
		for _, config in pairs(unowned_items) do
			print("awarding:", config.key)
			ScriptBackendItem.award_item(config.key)
		end

		Managers.backend:commit()
	else
		print("player already owns all items of type " .. item_type)
	end

	return 
end

return 
