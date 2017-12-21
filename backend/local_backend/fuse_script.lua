local success = 1
local fail = 0
local successfull_run = success_code

require("backend/local_backend/fuse_data")

function get_profile_entities()
	local entities = {}

	for id, name in string.gmatch(profile_entities, "([^,]+),([^,]+),") do
		entities[id] = name
	end

	return entities
end

function verify_owns_items(items)
	local entities = get_profile_entities()

	for _, item_data in pairs(items) do
		local name = entities[item_data[2]]

		if not name or name ~= item_data[1] then
			echo("User does not own all items")

			successfull_run = fail_code

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
	local base_item_data = ForgeItemMasterList[items[1][1]]
	local base_rarity = base_item_data.rarity

	for _, item in ipairs(items) do
		local item_data = ForgeItemMasterList[item[1]]

		if base_rarity ~= item_data.rarity then
			echo("Not the same rarity of all items submitted to forge")

			successfull_run = fail_code

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

local function get_upgrade_rarity_list(rarity)
	local rarity_id = RarityPrio[rarity] + 1
	local new_rarity = RarityPrio[rarity_id]
	local rarity_upgrades = ForgeUpgrade[new_rarity]

	if not RarityPrio[new_rarity] and not rarity_upgrades then
		echo("No upgrades of rarity " .. rarity .. " found.")

		successfull_run = fail_code

		return 
	end

	return rarity_upgrades
end

local function check_cost(num_items, num_tokens, params_token_type, rarity)
	if num_items == 5 then
		return true
	end

	local merge_cost = {
		plentiful = {
			token_type = "iron_tokens",
			token_texture = "token_icon_01",
			cost = {
				20,
				60,
				120,
				200
			}
		},
		common = {
			token_type = "bronze_tokens",
			token_texture = "token_icon_02",
			cost = {
				25,
				75,
				150,
				250
			}
		},
		rare = {
			token_type = "silver_tokens",
			token_texture = "token_icon_03",
			cost = {
				30,
				90,
				180,
				300
			}
		}
	}
	local config = merge_cost[rarity]

	if config.token_type ~= params_token_type then
		echo(string.format("Not the correct type of tokens, expected: %q, got: %q", config.token_type, params_token_type))

		successfull_run = fail_code

		return 
	end

	local cost = config.cost[num_items - 5]

	if cost ~= num_tokens then
		echo(string.format("Not the correct number of tokens, expected: %d, got: %d", cost, num_tokens))

		successfull_run = fail_code

		return 
	end

	return true
end

local function get_upgrade_of_item(item, item_type_list)
	local item_data = ForgeItemMasterList[item[1]]
	local item_type = item_data.item_type
	local item_list = item_type_list[item_type]

	if not item_list then
		echo("No upgrade found for item " .. item[1])

		successfull_run = fail_code

		return false
	end

	local upgrade_name = item_list[math.random(#item_list)]

	return upgrade_name
end

function fuse_script_local(param_items_to_merge, params_num_tokens, params_token_type)
	local items = extract_items(param_items_to_merge)

	if not verify_same_rarity(items) then
		return 
	end

	if not verify_owns_items(items) then
		return 
	end

	local item_data = ForgeItemMasterList[items[1][1]]
	local current_rarity = item_data.rarity
	local item_type_list = get_upgrade_rarity_list(current_rarity)

	if not item_type_list then
		return 
	end

	if not check_cost(#items, tonumber(params_num_tokens), params_token_type, current_rarity) then
		return 
	end

	local item = items[math.random(#items)]
	local upgrade_name = get_upgrade_of_item(item, item_type_list)

	if not upgrade_name then
		return 
	end

	local delete_items = ""

	for ii, item in pairs(items) do
		delete_items = delete_items .. item[2]

		if items[ii + 1] then
			delete_items = delete_items .. ","
		end
	end

	return {
		upgrade_name
	}
end

return successfull_run
