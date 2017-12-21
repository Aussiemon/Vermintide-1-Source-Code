function get_profile_entities()
	local entities = {}

	for id, name in string.gmatch(profile_entities, "([^,]+),([^,]+),") do
		entities[id] = name
	end

	return entities
end

function verify_owns_items(items)
	for backend_id, item_data in pairs(items) do
		local item = ScriptBackendItemLocal.get_item_from_id(backend_id)

		print("Verify:", item.key, item_data[1])
		print("###########")

		if not item.key or item.key ~= item_data[1] then
			return false
		end
	end

	return true
end

RarityPrio = {
	"plentiful",
	"common",
	"rare",
	"exotic"
}

for key, value in ipairs(RarityPrio) do
	RarityPrio[value] = key
end

local function verify_same_rarity(items)
	local rarity = nil
	local base_item_data = ForgeItemMasterList[items[1][1]]
	local base_rarity = base_item_data.rarity

	for _, item in ipairs(items) do
		local item_data = ForgeItemMasterList[item[1]]
		rarity = rarity or item_data.rarity

		if rarity ~= item_data.rarity then
			return false
		end
	end

	return true
end

local function extract_items(data)
	local items = {}

	for item, id in string.gmatch(data, "([%w_]+),(%w+);") do
		items[#items + 1] = {
			item,
			id
		}
	end

	return items
end

local function get_upgrade_rarity_list(item)
	local item_data = ForgeItemMasterList[item[1]]
	local current_rarity = item_data.rarity
	local rarity_id = RarityPrio[current_rarity] + 1
	local new_rarity = RarityPrio[rarity_id]
	local rarity_upgrades = ForgeUpgrade[new_rarity]

	if not RarityPrio[new_rarity] and not rarity_upgrades then
		print("No upgrades of rarity " .. rarity .. " found.")

		return 
	end

	return rarity_upgrades
end

local function get_upgrade_of_item(item, item_type_list)
	local item_data = ForgeItemMasterList[item[1]]
	local item_type = item_data.item_type
	local item_list = item_type_list[item_type]

	if not item_list then
		print("No upgrade found for item " .. item[1])

		return false
	end

	local upgrade_name = item_list[math.random(#item_list)]

	return upgrade_name
end

function grant_item(param_items_to_merge)
	local items = extract_items(param_items_to_merge)

	if not verify_same_rarity(items) then
		print("Not the same rarity of all items submitted to forge")

		return 0
	end

	if not verify_owns_items(items) then
		print("User does not own all items")
	end

	local item_type_list = get_upgrade_rarity_list(items[1])

	if not item_type_list then
		return 0
	end

	local item = items[math.random(#items)]
	local upgrade_name = get_upgrade_of_item(item, item_type_list)

	if not upgrade_name then
		return 0
	end

	return upgrade_name
end

return 
