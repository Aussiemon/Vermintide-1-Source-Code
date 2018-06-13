require("backend/local_backend/dice_data")

local probability_trinket = 0.1
local probability_hat = 0.05
local probability_played_hero = 0.5
local chest_settings_by_difficulty = {
	easy = {
		{
			item = 1,
			range_top = 1
		},
		{
			item = 1,
			range_top = 2
		},
		{
			item = 1,
			range_top = 3
		},
		{
			item = 1,
			range_top = 4
		},
		{
			item = 1,
			range_top = 5
		},
		{
			item = 4,
			range_top = 6
		},
		{
			item = 6,
			range_top = 7
		},
		{
			item = 7,
			range_top = 8
		}
	},
	normal = {
		{
			item = 1,
			range_top = 1
		},
		{
			item = 1,
			range_top = 2
		},
		{
			item = 1,
			range_top = 3
		},
		{
			item = 2,
			range_top = 4
		},
		{
			item = 4,
			range_top = 5
		},
		{
			item = 5,
			range_top = 6
		},
		{
			item = 7,
			range_top = 7
		},
		{
			item = 7,
			range_top = 8
		}
	},
	hard = {
		{
			item = 1,
			range_top = 1
		},
		{
			item = 1,
			range_top = 2
		},
		{
			item = 3,
			range_top = 3
		},
		{
			item = 4,
			range_top = 4
		},
		{
			item = 6,
			range_top = 5
		},
		{
			item = 7,
			range_top = 6
		},
		{
			item = 8,
			range_top = 7
		},
		{
			item = 10,
			range_top = 8
		}
	},
	survival_hard = {
		{
			item = 1,
			range_top = 1
		},
		{
			item = 1,
			range_top = 2
		},
		{
			item = 3,
			range_top = 3
		},
		{
			item = 4,
			range_top = 4
		},
		{
			item = 6,
			range_top = 5
		},
		{
			item = 7,
			range_top = 6
		},
		{
			item = 8,
			range_top = 7
		},
		{
			item = 10,
			range_top = 8
		}
	},
	harder = {
		{
			item = 1,
			range_top = 1
		},
		{
			item = 2,
			range_top = 2
		},
		{
			item = 4,
			range_top = 3
		},
		{
			item = 5,
			range_top = 4
		},
		{
			item = 7,
			range_top = 5
		},
		{
			item = 8,
			range_top = 6
		},
		{
			item = 10,
			range_top = 7
		},
		{
			item = 11,
			range_top = 8
		}
	},
	survival_harder = {
		{
			item = 1,
			range_top = 1
		},
		{
			item = 2,
			range_top = 2
		},
		{
			item = 4,
			range_top = 3
		},
		{
			item = 5,
			range_top = 4
		},
		{
			item = 7,
			range_top = 5
		},
		{
			item = 8,
			range_top = 6
		},
		{
			item = 10,
			range_top = 7
		},
		{
			item = 11,
			range_top = 8
		}
	},
	hardest = {
		{
			item = 4,
			range_top = 1
		},
		{
			item = 4,
			range_top = 2
		},
		{
			item = 6,
			range_top = 3
		},
		{
			item = 7,
			range_top = 4
		},
		{
			item = 9,
			range_top = 5
		},
		{
			item = 10,
			range_top = 6
		},
		{
			item = 10,
			range_top = 7
		},
		{
			item = 12,
			range_top = 8
		}
	},
	survival_hardest = {
		{
			item = 4,
			range_top = 1
		},
		{
			item = 4,
			range_top = 2
		},
		{
			item = 6,
			range_top = 3
		},
		{
			item = 7,
			range_top = 4
		},
		{
			item = 9,
			range_top = 5
		},
		{
			item = 10,
			range_top = 6
		},
		{
			item = 10,
			range_top = 7
		},
		{
			item = 12,
			range_top = 8
		}
	}
}
local PreviousRarity = {
	common = "plentiful",
	exotic = "rare",
	rare = "common",
	unique = "exotic"
}
local dice_types = {
	"wood",
	"metal",
	"gold",
	"warpstone"
}
local dice_probabilities = {
	gold = 0.6666666666666666,
	metal = 0.5,
	warpstone = 1,
	wood = 0.3333333333333333
}
local heroes = {
	"empire_soldier",
	"wood_elf",
	"bright_wizard",
	"dwarf_ranger",
	"witch_hunter"
}

local function extract_dice(input)
	local dice = {}

	for type, amount in string.gmatch(input, "([%w_]+),(%w+);") do
		dice[#dice + 1] = {
			successes = 0,
			type = type,
			amount = amount,
			p = dice_probabilities[type]
		}
	end

	return dice
end

local owned_entities = nil

function get_profile_entities()
	if not owned_entities then
		owned_entities = {}

		for id, name in string.gmatch(profile_entities, "([^,]+),([^,]+),") do
			owned_entities[id] = name
		end
	end

	return owned_entities
end

local function get_successes(param_dice)
	local dice = extract_dice(param_dice)
	local successes = 1

	for i = 1, #dice, 1 do
		local die = dice[i]

		for j = 1, die.amount, 1 do
			if math.random() < die.p then
				die.successes = die.successes + 1
				successes = successes + 1
			end
		end
	end

	local serialized = ""

	for _, die in ipairs(dice) do
		serialized = serialized .. die.type .. "," .. die.successes .. ";"
	end

	return successes, serialized
end

local function roll_dice(num_successes, new_num_successes, dice)
	local serialized = ""

	for _, die in ipairs(dice) do
		serialized = serialized .. die.type .. "," .. die.successes .. ";"
	end

	return serialized
end

local function get_weighted_item(container, value)
	local num_items = #container

	for ii = 1, num_items, 1 do
		local slot = container[ii]

		if value <= slot.range_top or not container[ii + 1] then
			return slot.item
		end
	end

	return 0
end

local function get_chest(successes, difficulty)
	local chest_settings = chest_settings_by_difficulty[difficulty]
	local chest_id = get_weighted_item(chest_settings, successes)

	return Chests[chest_id]
end

local function get_random_item(container)
	local random = math.random(#container)

	return container[random]
end

local function get_random_hero_weighted_item(container, hero_name)
	if hero_name and math.random() <= probability_played_hero then
		return container[hero_name]
	end

	local remaining_heroes = {}

	for _, name in ipairs(heroes) do
		if name ~= hero_name then
			remaining_heroes[#remaining_heroes + 1] = name
		end
	end

	local random = math.random(#remaining_heroes)
	local random_hero_name = remaining_heroes[random]

	return container[random_hero_name]
end

local function player_has(item_name)
	local entities = get_profile_entities()

	for id, name in pairs(entities) do
		if name == item_name then
			return true
		end
	end

	return false
end

local function get_random_hero_item(rarity, hero_name)
	local hero_list = HeroLoot[rarity]

	if not hero_list then
		echo("no such rarity" .. rarity)
	end

	local item_type_list = get_random_hero_weighted_item(hero_list, hero_name)

	if not item_type_list then
		return
	end

	local item_list = get_random_item(item_type_list)
	local item_name = get_random_item(item_list)

	if rarity == "unique" and player_has(item_name) then
		return
	end

	return item_name
end

local function get_random_trinket(rarity)
	local trinket_list = Trinkets[rarity]

	if trinket_list then
		local item_name = get_random_item(trinket_list)

		return item_name
	else
		echo("found no trinket of rarity " .. rarity)
	end
end

local function get_random_hat(rarity, hero_name)
	local hero_list = Hats[rarity]

	if hero_list then
		local hat_list = get_random_hero_weighted_item(hero_list, hero_name)
		local item_name = get_random_item(hat_list)

		if rarity == "unique" and player_has(item_name) then
			return
		end

		return item_name
	else
		echo("found no hat of rarity " .. rarity)
	end
end

local function user_has_all_of_rarity(rarity)
	local items = {}

	if HeroLoot[rarity] then
		for hero, item_type_list in pairs(HeroLoot[rarity]) do
			for _, item_list in ipairs(item_type_list) do
				for __, key in ipairs(item_list) do
					items[key] = true
				end
			end
		end
	end

	if Trinkets[rarity] then
		for _, key in pairs(Trinkets[rarity]) do
			for __, key in ipairs(item_list) do
				items[key] = true
			end
		end
	end

	if Hats[rarity] then
		for _, item_list in pairs(Hats[rarity]) do
			for __, key in ipairs(item_list) do
				items[key] = true
			end
		end
	end

	local entities = get_profile_entities()

	for _, key in pairs(entities) do
		items[key] = nil
	end

	return not next(items)
end

local function get_win_list(num_successes, difficulty, hero_name)
	local win_list = {}
	local serialized = ""

	for ii = 1, 8, 1 do
		local chest = get_chest(ii, difficulty)
		local rarity = get_weighted_item(chest, math.random())
		local item_name = nil

		while not item_name do
			if math.random() <= probability_hat then
				item_name = get_random_hat(rarity, hero_name)
			end

			if not item_name and math.random() <= probability_trinket then
				item_name = get_random_trinket(rarity)
			end

			item_name = item_name or get_random_hero_item(rarity, hero_name)

			if not item_name and rarity == "unique" and user_has_all_of_rarity(rarity) then
				echo("User has all " .. rarity .. "!")

				rarity = PreviousRarity[rarity]
			end
		end

		win_list[ii] = item_name
		serialized = serialized .. item_name .. ","
	end

	return win_list, serialized
end

local function table_count(tab)
	local count = 0
	local max_index = -math.huge

	for id, __ in pairs(tab) do
		count = count + 1

		if max_index < id then
			max_index = id
		end
	end

	return count, max_index
end

LevelRewards = {
	reward_settings_by_level = function (self, level)
		local rarity, item_type = nil

		if level <= self._max_index then
			rarity = "plentiful"
			item_type = LevellingRewardsItemType[level]
		else
			rarity = "common"
			local index = (level - self._num_rewards) % #LevellingRewardsItemTypeAbove
			item_type = LevellingRewardsItemTypeAbove[index]
		end

		return rarity, item_type
	end,
	reward_by_level = function (self, level)
		local rarity, item_type = self:reward_settings_by_level(level)

		if item_type then
			local reward_table = LevellingRewards[rarity][item_type]
			local reward_name = reward_table[math.random(#reward_table)]

			return reward_name
		end
	end,
	level_up_rewards = function (self, start_level, end_level)
		local num_rewards, max_index = table_count(LevellingRewardsItemType)
		self._num_rewards = num_rewards
		self._max_index = max_index
		local rewards = {}

		if start_level == end_level then
			return rewards
		end

		for ii = start_level + 1, end_level, 1 do
			local reward = self:reward_by_level(ii)

			if reward then
				rewards[#rewards + 1] = reward
			end
		end

		return rewards
	end
}

function dice_script_local(param_dice, param_difficulty, param_start_level, param_end_level, param_hero_name)
	local level_up_rewards = LevelRewards:level_up_rewards(tonumber(param_start_level), tonumber(param_end_level))
	local num_successes, successes_serialized = get_successes(param_dice)
	local win_list, win_list_serialized = get_win_list(num_successes, param_difficulty, param_hero_name)
	local item_name = win_list[num_successes]
	local entities = {
		item_name
	}

	for _, name in pairs(level_up_rewards) do
		table.insert(entities, name)
	end

	local parameters = {
		successes = successes_serialized,
		win_list = win_list_serialized
	}

	return entities, parameters, nil
end

return
