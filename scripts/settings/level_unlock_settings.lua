GameActs = {
	prologue = {
		"magnus"
	},
	act_1 = {
		"merchant",
		"sewers_short",
		"wizard",
		"bridge"
	},
	act_2 = {
		"forest_ambush",
		"city_wall",
		"cemetery",
		"farm"
	},
	act_3 = {
		"tunnels",
		"courtyard_level",
		"docks_short_level"
	},
	act_4 = {
		"end_boss"
	}
}
GameActsOrder = {
	"prologue",
	"act_1",
	"act_2",
	"act_3",
	"act_4"
}
UnlockableLevels = {
	"magnus",
	"merchant",
	"wizard",
	"forest_ambush",
	"cemetery",
	"tunnels",
	"end_boss",
	"sewers_short",
	"bridge",
	"city_wall",
	"farm",
	"courtyard_level",
	"docks_short_level",
	"dlc_survival_ruins",
	"dlc_survival_magnus",
	"dlc_portals",
	"dlc_castle",
	"dlc_castle_dungeon"
}
DLCProgressionOrder = {
	drachenfels = {
		"dlc_castle",
		"dlc_castle_dungeon",
		"dlc_portals"
	}
}
UnlockableLevelsByGameMode = {
	adventure = {
		"magnus",
		"merchant",
		"wizard",
		"forest_ambush",
		"cemetery",
		"tunnels",
		"end_boss",
		"sewers_short",
		"bridge",
		"city_wall",
		"farm",
		"courtyard_level",
		"docks_short_level",
		"dlc_portals",
		"dlc_castle",
		"dlc_castle_dungeon"
	},
	survival = {
		"dlc_survival_ruins",
		"dlc_survival_magnus"
	}
}
UnlockableLevelsByDLC = {
	dwarfs = {
		adventure = {
			"dlc_dwarf_interior",
			"dlc_dwarf_exterior",
			"dlc_dwarf_beacons"
		},
		survival = {}
	}
}
MainGameLevels = {
	"magnus",
	"merchant",
	"wizard",
	"forest_ambush",
	"cemetery",
	"tunnels",
	"end_boss",
	"sewers_short",
	"bridge",
	"city_wall",
	"farm",
	"courtyard_level",
	"docks_short_level"
}
NoneActLevels = {
	"dlc_portals",
	"dlc_castle",
	"dlc_castle_dungeon"
}
SurvivalLevels = {
	"dlc_survival_ruins",
	"dlc_survival_magnus"
}
LevelUnlockOrder = {
	GameActs.prologue,
	GameActs.act_1,
	GameActs.act_2,
	GameActs.act_3,
	GameActs.act_4
}

if Development.parameter("beta_level_progression") then
	dofile("scripts/settings/level_unlock_settings_beta")
end

LevelGameModeTypes = {
	survival = true,
	adventure = true,
	tutorial = true
}
GameActsDisplayNames = {
	act_1 = "act_1_display_name",
	prologue = "prologue_display_name",
	act_4 = "act_4_display_name",
	act_3 = "act_3_display_name",
	act_2 = "act_2_display_name"
}
LengthTypeByLevel = {
	docks_short_level = "short",
	bridge = "short",
	dlc_survival_ruins = "short",
	end_boss = "long",
	magnus = "long",
	dlc_castle = "long",
	tunnels = "long",
	cemetery = "long",
	farm = "short",
	courtyard_level = "short",
	dlc_dwarf_exterior = "long",
	dlc_portals = "short",
	dlc_castle_dungeon = "short",
	wizard = "long",
	city_wall = "short",
	forest_ambush = "long",
	dlc_dwarf_interior = "long",
	sewers_short = "short",
	dlc_survival_magnus = "short",
	merchant = "long"
}

dofile("scripts/settings/level_unlock_settings_dlc_dwarf")

for _, dlc in pairs(DLCSettings) do
	local unlock_settings = dlc.level_unlock_settings

	if unlock_settings then
		dofile(unlock_settings)
	end
end

LevelUnlockOrderCombined = {}

for i, level_names in ipairs(LevelUnlockOrder) do
	LevelUnlockOrderCombined[i] = table.clone(LevelUnlockOrder[i])

	if LevelUnlockOrderCombined[i - 1] then
		local table_to_append = table.clone(LevelUnlockOrderCombined[i - 1])

		table.append(LevelUnlockOrderCombined[i], table_to_append)
	end
end

LevelUnlockUtils = {
	progression_required_for_level = function (level_key)
		local settings = LevelSettings[level_key]
		local level_game_mode = settings.game_mode

		if settings.dlc_name then
			return 0
		end

		if level_game_mode == "adventure" then
			for act_index, key in ipairs(GameActsOrder) do
				local act_levels = GameActs[key]

				for _, act_level_key in ipairs(act_levels) do
					if act_level_key == level_key then
						return math.max(act_index - 1, 0)
					end
				end
			end
		elseif level_game_mode == "survival" then
			local required_act_unlocked = SurvivalSettings.required_act_unlocked
			local prologue_act_order_index = math.max(table.find(GameActsOrder, required_act_unlocked) - 1, 0)

			return prologue_act_order_index
		end

		fassert(Application.build() ~= "release", "Trying to get required progression for level %q which is not included in progress", level_key)

		return 0
	end,
	current_act_progression_index = function (statistics_db, player_stats_id)
		for act_index, key in ipairs(GameActsOrder) do
			local act_levels = GameActs[key]

			for _, level_key in ipairs(act_levels) do
				local level_stat = statistics_db.get_persistent_stat(statistics_db, player_stats_id, "completed_levels", level_key)
				local level_completed = level_stat and level_stat ~= 0

				if not level_completed then
					return math.max(act_index - 1, 0)
				end
			end
		end

		return math.max(#GameActsOrder - 1, 0)
	end,
	current_act_progression_raw = function ()
		local stats = Managers.backend:get_stats()

		for act_index, key in ipairs(GameActsOrder) do
			local act_levels = GameActs[key]

			for _, level_key in ipairs(act_levels) do
				local level_stat = tonumber(stats[level_key])
				local level_completed = level_stat and 1 <= level_stat

				if not level_completed then
					return math.max(act_index - 1, 0)
				end
			end
		end

		return math.max(#GameActsOrder - 1, 0)
	end
}
LevelUnlockUtils.unlocked_level_difficulty_index = function (statistics_db, player_stats_id, level_key)
	local level_settings = LevelSettings[level_key]
	local game_mode = level_settings.game_mode

	if game_mode == "adventure" and Application.platform() ~= "win32" then
		local difficulties, starting_difficulty = Managers.state.difficulty:get_level_difficulties(level_key)
		local automatic_difficulty_unlock_index = table.find(difficulties, starting_difficulty)
		local highest_available_difficulty_index = #difficulties
		local highest_completed_difficulty_index = highest_available_difficulty_index

		for _, level in ipairs(MainGameLevels) do
			local completed_difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, player_stats_id, level)

			if completed_difficulty_index < highest_completed_difficulty_index then
				highest_completed_difficulty_index = completed_difficulty_index
			end
		end

		return math.max(math.min(highest_completed_difficulty_index + 1, highest_available_difficulty_index), automatic_difficulty_unlock_index)
	else
		local difficulties, starting_difficulty = Managers.state.difficulty:get_level_difficulties(level_key)
		local automatic_difficulty_unlock_index = table.find(difficulties, starting_difficulty)
		local highest_available_difficulty_index = #difficulties
		local completed_difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, player_stats_id, level_key)

		return math.max(math.min(completed_difficulty_index + 1, highest_available_difficulty_index), automatic_difficulty_unlock_index)
	end

	return 
end
LevelUnlockUtils.completed_level_difficulty_index = function (statistics_db, player_stats_id, level_key)
	local level_difficulty_name = LevelDifficultyDBNames[level_key]

	if level_difficulty_name then
		local difficulty_index = statistics_db.get_persistent_stat(statistics_db, player_stats_id, "completed_levels_difficulty", level_difficulty_name)

		return difficulty_index
	else
		return 0
	end

	return 
end
LevelUnlockUtils.completed_adventure_difficulty = function (statistics_db, player_stats_id)
	local lowest_completed = math.huge

	for _, act_key in ipairs(GameActsOrder) do
		for _, level_key in ipairs(GameActs[act_key]) do
			local level_difficulty_name = LevelDifficultyDBNames[level_key]

			if level_difficulty_name then
				local difficulty_index = statistics_db.get_persistent_stat(statistics_db, player_stats_id, "completed_levels_difficulty", level_difficulty_name)

				if difficulty_index < lowest_completed then
					lowest_completed = difficulty_index
				end
			end
		end
	end

	return lowest_completed
end

local function sort_levels_by_order(a, b)
	local level_settings = LevelSettings
	local a_settings = level_settings[a].map_settings
	local b_settings = level_settings[b].map_settings
	local a_order = a_settings.sorting or 99
	local b_order = b_settings.sorting or 99

	return a_order < b_order
end

LevelUnlockUtils.get_next_level_in_order = function (statistics_db, player_stats_id, current_level_key)
	local level_settings = LevelSettings[current_level_key]
	local dlc_name = level_settings.dlc_name
	local next_level_key = nil
	local unlock_levels = {}
	local num_unlock_levels = nil

	if dlc_name then
		unlock_levels = DLCProgressionOrder[dlc_name]
		num_unlock_levels = #unlock_levels

		table.sort(unlock_levels, sort_levels_by_order)
	else
		for i = 1, #LevelUnlockOrder, 1 do
			local group_levels = LevelUnlockOrder[i]

			for k = 1, #group_levels, 1 do
				unlock_levels[#unlock_levels + 1] = group_levels[k]
			end
		end

		table.sort(unlock_levels, sort_levels_by_order)

		num_unlock_levels = #unlock_levels

		for i = 1, num_unlock_levels, 1 do
			local level_key = unlock_levels[i]
			local level_stat = statistics_db.get_persistent_stat(statistics_db, player_stats_id, "completed_levels", level_key)
			local level_completed = script_data.unlock_all_levels or (level_stat and level_stat ~= 0)

			if not level_completed then
				next_level_key = level_key

				break
			end
		end
	end

	if not next_level_key then
		if unlock_levels[num_unlock_levels] == current_level_key then
			next_level_key = unlock_levels[1]
		else
			for i = 1, num_unlock_levels, 1 do
				local level_key = unlock_levels[i]

				if level_key == current_level_key then
					next_level_key = unlock_levels[i + 1]

					break
				end
			end
		end
	end

	return next_level_key
end
LevelUnlockUtils.level_unlocked = function (statistics_db, player_stats_id, level_key)
	if script_data.unlock_all_levels then
		return true
	end

	local act_key = LevelUnlockUtils.get_act_key_by_level(level_key)

	if not act_key then
		local settings = LevelSettings[level_key]
		local level_game_mode = settings.game_mode
		local dlc_name = settings.dlc_name

		if level_game_mode == "survival" then
			local required_act_unlocked = SurvivalSettings.required_act_unlocked

			if LevelUnlockUtils.act_unlocked(statistics_db, player_stats_id, required_act_unlocked) then
				if dlc_name then
					return Managers.unlock:is_dlc_unlocked(dlc_name)
				else
					return true
				end
			end
		end

		local required_act_completed = settings.required_act_completed

		if required_act_completed then
			if LevelUnlockUtils.act_completed(statistics_db, player_stats_id, required_act_completed) then
				if dlc_name then
					return Managers.unlock:is_dlc_unlocked(dlc_name)
				else
					return true
				end
			else
				return false
			end
		elseif dlc_name then
			return Managers.unlock:is_dlc_unlocked(dlc_name)
		else
			return true
		end

		return false
	end

	local act_unlocked = LevelUnlockUtils.act_unlocked(statistics_db, player_stats_id, act_key)

	return act_unlocked
end
LevelUnlockUtils.get_act_key_by_level = function (level_key)
	for key, levels in pairs(GameActs) do
		for _, act_level_key in ipairs(levels) do
			if level_key == act_level_key then
				return key
			end
		end
	end

	return 
end
LevelUnlockUtils.act_unlocked = function (statistics_db, player_stats_id, act_key)
	assert(GameActs[act_key] ~= nil, "Act %s does not exist.", act_key)

	for _, key in ipairs(GameActsOrder) do
		if key == act_key then
			return true
		end

		local act_levels = GameActs[key]

		for _, level_key in ipairs(act_levels) do
			local level_stat = statistics_db.get_persistent_stat(statistics_db, player_stats_id, "completed_levels", level_key)
			local level_completed = level_stat and level_stat ~= 0

			if not level_completed then
				return false
			end
		end
	end

	return false
end
LevelUnlockUtils.act_completed = function (statistics_db, player_stats_id, act_key)
	assert(GameActs[act_key] ~= nil, "Act %s does not exist.", act_key)

	local act_levels = GameActs[act_key]

	for _, level_key in ipairs(act_levels) do
		local level_stat = statistics_db.get_persistent_stat(statistics_db, player_stats_id, "completed_levels", level_key)
		local level_completed = level_stat and level_stat ~= 0

		if not level_completed then
			return false
		end
	end

	return true
end
LevelUnlockUtils.all_acts_completed = function (statistics_db, player_stats_id)
	if Development.parameter("unlock_all_levels") then
		return true
	end

	for _, key in ipairs(GameActsOrder) do
		if not LevelUnlockUtils.act_completed(statistics_db, player_stats_id, key) then
			return false
		end
	end

	return true
end
LevelUnlockUtils.debug_set_completed_game_difficulty = function (difficulty)
	local statistics_db = Managers.player:statistics_db()
	local player = Managers.player:local_player()
	local stats_id = player.stats_id(player)

	for level_key, level_difficulty_key in pairs(LevelDifficultyDBNames) do
		statistics_db.set_stat(statistics_db, stats_id, "completed_levels_difficulty", level_difficulty_key, difficulty)
		statistics_db.increment_stat(statistics_db, stats_id, "completed_levels", level_key)
	end

	local backend_stats = {}

	statistics_db.generate_backend_stats(statistics_db, stats_id, backend_stats)
	Managers.backend:set_stats(backend_stats)
	Managers.backend:commit()

	return 
end
LevelUnlockUtils.debug_unlock_act = function (act_index)
	local player_manager = Managers.player
	local statistics_db = player_manager.statistics_db(player_manager)
	local player = player_manager.local_player(player_manager)
	local stats_id = player.stats_id(player)
	local actual_act_index = math.min(act_index + 1, #GameActsOrder)
	local act_key = GameActsOrder[actual_act_index]

	assert(act_key, "Could not find act for index %d.", actual_act_index)

	local debug_act_passed = false

	for index, key in ipairs(GameActsOrder) do
		if key == act_key then
			debug_act_passed = true
		end

		local act_levels = GameActs[key]

		for _, level_key in ipairs(act_levels) do
			if not debug_act_passed then
				statistics_db.increment_stat(statistics_db, stats_id, "completed_levels", level_key)
			else
				local completed_times = statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", level_key)

				while 0 < completed_times do
					statistics_db.decrement_stat(statistics_db, stats_id, "completed_levels", level_key)

					completed_times = statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", level_key)
				end
			end
		end
	end

	local backend_stats = {}

	statistics_db.generate_backend_stats(statistics_db, stats_id, backend_stats)
	Managers.backend:set_stats(backend_stats)
	Managers.backend:commit()

	return 
end

return 
