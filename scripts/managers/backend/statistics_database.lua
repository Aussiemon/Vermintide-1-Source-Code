require("scripts/managers/backend/statistics_util")
require("scripts/settings/breeds")

StatisticsDefinitions = {
	session = {
		chests_opened = {
			value = 0,
			hot_join_sync_rpc = "rpc_set_unsigned_number_session_stat"
		},
		level_progress = {
			value = 0,
			hot_join_sync_rpc = "rpc_set_unsigned_number_session_stat"
		},
		level_progress_distance = {
			value = 0,
			hot_join_sync_rpc = "rpc_set_unsigned_number_session_stat"
		},
		deaths = {
			value = 0,
			hot_join_sync_rpc = "rpc_set_unsigned_number_session_stat"
		},
		damage_taken_per_breed = {}
	},
	player = {
		kills_total = {
			value = 0,
			sync_on_hot_join = true
		},
		kills_melee = {
			value = 0,
			sync_on_hot_join = true
		},
		kills_ranged = {
			value = 0,
			sync_on_hot_join = true
		},
		kills_grenade = {
			value = 0,
			sync_on_hot_join = true
		},
		kill_assists_grenade = {
			value = 0,
			sync_on_hot_join = true
		},
		kills_per_breed = {},
		kill_assists_per_breed = {},
		headshots = {
			value = 0,
			sync_on_hot_join = true
		},
		revives = {
			value = 0,
			sync_on_hot_join = true
		},
		aidings = {
			value = 0,
			sync_on_hot_join = true
		},
		saves = {
			value = 0,
			sync_on_hot_join = true
		},
		times_revived = {
			value = 0,
			sync_on_hot_join = true
		},
		times_friend_healed = {
			value = 0,
			database_name = "times_friend_healed",
			sync_on_hot_join = true
		},
		damage_taken = {
			value = 0,
			sync_on_hot_join = true
		},
		damage_taken_per_breed = {},
		damage_dealt = {
			value = 0,
			sync_on_hot_join = true
		},
		best_projectile_multikill = {
			value = 0
		},
		damage_dealt_per_breed = {},
		dynamic_objects_destroyed = {
			value = 0,
			database_name = "dynamic_objects_destroyed"
		},
		salvaged_items = {
			value = 0,
			database_name = "salvaged_items"
		},
		fused_items = {
			value = 0,
			database_name = "fused_items"
		},
		upgraded_items = {
			value = 0
		},
		complete_level_bright_wizard = {
			value = 0,
			database_name = "complete_level_bright_wizard"
		},
		complete_level_wood_elf = {
			value = 0,
			database_name = "complete_level_wood_elf"
		},
		complete_level_empire_soldier = {
			value = 0,
			database_name = "complete_level_empire_soldier"
		},
		complete_level_witch_hunter = {
			value = 0,
			database_name = "complete_level_witch_hunter"
		},
		complete_level_dwarf_ranger = {
			value = 0,
			database_name = "complete_level_dwarf_ranger"
		},
		collected_grimoires = {},
		collected_tomes = {},
		completed_levels = {},
		dice_roll_successes = {
			value = 0,
			database_name = "dice_roll_successes"
		},
		killed_patrols = {
			value = 0
		},
		checkpoint_damage_taken = {
			value = 0
		},
		checkpoint_progress = {},
		completed_checkpoints = {
			value = 0
		},
		completed_levels_difficulty = {},
		lorebook_unlocks = {
			database_name = "lorebook_unlocks",
			database_type = "hexarray",
			value = {}
		},
		profiles = {
			witch_hunter = {
				kills_total = {
					value = 0
				}
			}
		},
		win_item_as_bright_wizard = {
			value = 0
		},
		win_item_as_dwarf_ranger = {
			value = 0
		},
		win_item_as_empire_soldier = {
			value = 0
		},
		win_item_as_wood_elf = {
			value = 0
		},
		win_item_as_witch_hunter = {
			value = 0
		},
		endurance_badges = {
			value = 0,
			database_name = "endurance_badges"
		},
		survival_dlc_survival_ruins_survival_hard_waves = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_hard_waves",
			sync_on_hot_join = true
		},
		survival_dlc_survival_ruins_survival_hard_time = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_hard_time",
			sync_on_hot_join = true
		},
		survival_dlc_survival_ruins_survival_hard_kills = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_hard_kills"
		},
		survival_dlc_survival_ruins_survival_harder_waves = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_survival_harder_waves",
			sync_on_hot_join = true
		},
		survival_dlc_survival_ruins_survival_harder_time = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_survival_harder_time",
			sync_on_hot_join = true
		},
		survival_dlc_survival_ruins_survival_harder_kills = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_survival_harder_kills"
		},
		survival_dlc_survival_ruins_survival_hardest_waves = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_survival_hardest_waves",
			sync_on_hot_join = true
		},
		survival_dlc_survival_ruins_survival_hardest_time = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_survival_hardest_time",
			sync_on_hot_join = true
		},
		survival_dlc_survival_ruins_survival_hardest_kills = {
			value = 0,
			database_name = "survival_dlc_survival_ruins_survival_hardest_kills"
		},
		survival_dlc_survival_magnus_survival_hard_waves = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_hard_waves",
			sync_on_hot_join = true
		},
		survival_dlc_survival_magnus_survival_hard_time = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_hard_time",
			sync_on_hot_join = true
		},
		survival_dlc_survival_magnus_survival_hard_kills = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_hard_kills"
		},
		survival_dlc_survival_magnus_survival_harder_waves = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_survival_harder_waves",
			sync_on_hot_join = true
		},
		survival_dlc_survival_magnus_survival_harder_time = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_survival_harder_time",
			sync_on_hot_join = true
		},
		survival_dlc_survival_magnus_survival_harder_kills = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_survival_harder_kills"
		},
		survival_dlc_survival_magnus_survival_hardest_waves = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_survival_hardest_waves",
			sync_on_hot_join = true
		},
		survival_dlc_survival_magnus_survival_hardest_time = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_survival_hardest_time",
			sync_on_hot_join = true
		},
		survival_dlc_survival_magnus_survival_hardest_kills = {
			value = 0,
			database_name = "survival_dlc_survival_magnus_survival_hardest_kills"
		},
		last_stand_waves_completed = {},
		tutorial_revive_ally = {
			value = 0
		},
		contracts_completed = {
			value = 0,
			database_name = "contracts_completed"
		},
		quests_completed = {
			value = 0,
			database_name = "quests_completed"
		},
		fuse_time_when_socketed = {
			value = math.huge
		},
		stormvermin_pick_instakills = {
			value = 0
		},
		dodged_storm_vermin_champion = {
			value = 0
		},
		equipped_executioners_sword = {
			value = 0
		},
		executor_headshot = {
			value = 0,
			database_name = "executor_headshot"
		},
		equipped_ceremonial_daggers = {
			value = 0
		},
		ceremonial_dagger_burn = {
			value = 0,
			database_name = "ceremonial_dagger_burn"
		},
		event_items_found = {
			value = 0
		},
		hard_mode_complete = {
			value = false,
			database_name = "hard_mode_complete",
			database_type = "lua"
		}
	}
}
local wave_stat = StatisticsDefinitions.player.last_stand_waves_completed

for _, difficulty_name in ipairs(SurvivalDifficulties) do
	wave_stat[difficulty_name] = {
		value = 0
	}
end

local platform = PLATFORM

if platform == "ps4" then
	StatisticsDefinitions.player.matchmaking_unix_timestamp = {
		value = 0,
		database_name = "matchmaking_unix_timestamp"
	}
	StatisticsDefinitions.player.matchmaking_country_code = {
		value = "N/A",
		database_name = "matchmaking_country_code",
		database_type = "string"
	}
	StatisticsDefinitions.player.matchmaking_primary_region = {
		value = "N/A",
		database_name = "matchmaking_primary_region",
		database_type = "string"
	}
	StatisticsDefinitions.player.matchmaking_secondary_region = {
		value = "N/A",
		database_name = "matchmaking_secondary_region",
		database_type = "string"
	}
	StatisticsDefinitions.player.matchmaking_region_fetch_status = {
		value = "N/A",
		database_name = "matchmaking_region_fetch_status",
		database_type = "string"
	}
	StatisticsDefinitions.player.matchmaking_num_searches = {
		value = 0,
		database_name = "matchmaking_num_searches"
	}
	StatisticsDefinitions.player.matchmaking_aborted_sub_15s = {
		value = 0,
		database_name = "matchmaking_aborted_sub_15s"
	}
	StatisticsDefinitions.player.matchmaking_aborted_above_15s = {
		value = 0,
		database_name = "matchmaking_aborted_above_15s"
	}
	StatisticsDefinitions.player.matchmaking_aborted_above_15s_total_time = {
		value = 0,
		database_name = "matchmaking_aborted_above_15s_total_time"
	}
	StatisticsDefinitions.player.matchmaking_game_joined = {
		value = 0,
		database_name = "matchmaking_game_joined"
	}
	StatisticsDefinitions.player.matchmaking_game_joined_primary_region = {
		value = 0,
		database_name = "matchmaking_game_joined_primary_region"
	}
	StatisticsDefinitions.player.matchmaking_game_joined_secondary_region = {
		value = 0,
		database_name = "matchmaking_game_joined_secondary_region"
	}
	StatisticsDefinitions.player.matchmaking_game_joined_total_search_time = {
		value = 0,
		database_name = "matchmaking_game_joined_total_search_time"
	}
	StatisticsDefinitions.player.matchmaking_game_started = {
		value = 0,
		database_name = "matchmaking_game_started"
	}
	StatisticsDefinitions.player.matchmaking_game_started_total_time = {
		value = 0,
		database_name = "matchmaking_game_started_total_time"
	}
	StatisticsDefinitions.player.matchmaking_game_started_player_amount = {
		value = 0,
		database_name = "matchmaking_game_started_player_amount"
	}
	StatisticsDefinitions.player.matchmaking_game_started_full_team = {
		value = 0,
		database_name = "matchmaking_game_started_full_team"
	}
	StatisticsDefinitions.player.matchmaking_first_client_joined = {
		value = 0,
		database_name = "matchmaking_first_client_joined"
	}
	StatisticsDefinitions.player.matchmaking_first_client_joined_total_time = {
		value = 0,
		database_name = "matchmaking_first_client_joined_total_time"
	}
end

if platform ~= "win32" then
	StatisticsDefinitions.player.total_kills_consoles = {
		value = 0,
		database_name = "total_kills_consoles"
	}
end

StatisticsDefinitions.weapon = {
	kills_total = {
		value = 0,
		database_name = "kills_total"
	}
}
StatisticsDefinitions.unit_test = {
	kills_total = {
		value = 0,
		database_name = "kills_total"
	},
	lorebook_unlocks = {
		database_name = "lorebook_unlocks",
		database_type = "hexarray",
		value = {}
	},
	profiles = {
		witch_hunter = {
			kills_total = {
				value = 0
			}
		}
	}
}

for breed_name, breed in pairs(Breeds) do
	StatisticsDefinitions.player.kills_per_breed[breed_name] = {
		value = 0,
		sync_on_hot_join = true,
		name = breed_name
	}
	StatisticsDefinitions.player.kill_assists_per_breed[breed_name] = {
		value = 0,
		sync_on_hot_join = true,
		name = breed_name
	}
	StatisticsDefinitions.player.damage_taken_per_breed[breed_name] = {
		value = 0,
		sync_on_hot_join = true,
		name = breed_name
	}
	StatisticsDefinitions.player.damage_dealt_per_breed[breed_name] = {
		value = 0,
		sync_on_hot_join = true,
		name = breed_name
	}
	StatisticsDefinitions.session.damage_taken_per_breed[breed_name] = {
		value = 0,
		hot_join_sync_rpc = "rpc_set_unsigned_number_session_stat"
	}
end

LevelDifficultyDBNames = {}

for level_key, level in pairs(LevelSettings) do
	if table.contains(UnlockableLevels, level_key) then
		StatisticsDefinitions.player.completed_levels[level_key] = {
			value = 0,
			sync_on_hot_join = true,
			database_name = level_key
		}
		local level_difficulty_name = level_key .. "_difficulty_completed"
		LevelDifficultyDBNames[level_key] = level_difficulty_name
		StatisticsDefinitions.player.completed_levels_difficulty[level_difficulty_name] = {
			value = 0,
			sync_on_hot_join = true,
			database_name = level_difficulty_name
		}
		local grimoire_name = "collected_grimoire_" .. level_key
		StatisticsDefinitions.player.collected_grimoires[level_key] = {
			value = 0,
			sync_on_hot_join = true,
			database_name = grimoire_name
		}
		local tome_name = "collected_tome_" .. level_key
		StatisticsDefinitions.player.collected_tomes[level_key] = {
			value = 0,
			sync_on_hot_join = true,
			database_name = tome_name
		}

		if level.game_mode == "survival" then
			local stat_name = level_key .. "_bright_wizard"
			StatisticsDefinitions.player[stat_name] = {
				value = 0,
				database_name = stat_name
			}
			stat_name = level_key .. "_witch_hunter"
			StatisticsDefinitions.player[stat_name] = {
				value = 0,
				database_name = stat_name
			}
			stat_name = level_key .. "_dwarf_ranger"
			StatisticsDefinitions.player[stat_name] = {
				value = 0,
				database_name = stat_name
			}
			stat_name = level_key .. "_empire_soldier"
			StatisticsDefinitions.player[stat_name] = {
				value = 0,
				database_name = stat_name
			}
			stat_name = level_key .. "_wood_elf"
			StatisticsDefinitions.player[stat_name] = {
				value = 0,
				database_name = stat_name
			}
		end
	end
end

for i = 1, 508, 1 do
	StatisticsDefinitions.player.lorebook_unlocks.value[i] = false
	StatisticsDefinitions.unit_test.lorebook_unlocks.value[i] = false
end

local function add_names(stats)
	for stat_name, stat_definition in pairs(stats) do
		if stat_definition.value == nil then
			add_names(stat_definition)
		else
			stat_definition.name = stat_name
		end
	end
end

add_names(StatisticsDefinitions.player)
add_names(StatisticsDefinitions.unit_test)

local function convert_from_backend(raw_value, database_type)
	if database_type == nil then
		return tonumber(raw_value)
	elseif database_type == "string" then
		return raw_value
	elseif database_type == "lua" then
		return cjson.decode(raw_value)
	elseif database_type == "hexarray" then
		local value = {}
		local value_n = 0
		local floor = math.floor

		for hex_char in raw_value:gmatch(".") do
			local hex_value = tonumber(hex_char, 16)

			for i = 4, 1, -1 do
				local hex_temp = hex_value / 2
				hex_value = floor(hex_temp)
				local new_value_n = value_n + i
				value[new_value_n] = (hex_value ~= hex_temp and true) or false
			end

			value_n = value_n + 4
		end

		return value
	end

	assert(false, "Unknown database_type %s for value %s", tostring(database_type), tostring(raw_value))
end

local function convert_to_backend(value, database_type)
	if database_type == nil then
		return tostring(value)
	elseif database_type == "string" then
		return value
	elseif database_type == "lua" then
		local json_data = cjson.encode(value)
		local length = string.len(json_data)

		if length > 255 then
			ScriptApplication.send_to_crashify("Backend", "Too much data (%d characters) in backend lua json encode", length)
			print(json_data)
		end

		fassert(length < 256, "Too much data in backend lua json, see above")

		return json_data
	elseif database_type == "hexarray" then
		local raw_value = ""
		local value_n = #value

		assert(value_n % 4 == 0, "Incorrectly stored statistic")

		for i = 1, value_n, 4 do
			local dec_value = 0

			for j = 0, 3, 1 do
				dec_value = dec_value * 2 + ((value[i + j] == true and 1) or 0)
			end

			local hex_value = string.format("%X", dec_value)
			raw_value = raw_value .. hex_value
		end

		return raw_value
	end

	assert(false, "Unknown database_type %s for value %s", tostring(database_type), tostring(value))
end

local function dbprintf(...)
	if script_data.statistics_debug then
		printf(...)
	end
end

StatisticsDatabase = class(StatisticsDatabase)

StatisticsDatabase.init = function (self)
	self.statistics = {}
	self.categories = {}

	for breed_name, breed in pairs(Breeds) do
		StatisticsDefinitions.player.kills_per_breed[breed_name] = {
			value = 0,
			sync_on_hot_join = true,
			name = breed_name
		}
		StatisticsDefinitions.player.damage_dealt_per_breed[breed_name] = {
			value = 0,
			sync_on_hot_join = true,
			name = breed_name
		}
	end
end

StatisticsDatabase.destroy = function (self)
	local stat_id = next(self.statistics)

	assert(stat_id == nil, "Destroying stats manager without properly cleaning up first. Stat id %q not unregistered.", tostring(stat_id))
end

local RPCS = {
	"rpc_hot_join_sync_statistics_number",
	"rpc_increment_stat",
	"rpc_set_local_player_stat"
}

StatisticsDatabase.register_network_event_delegate = function (self, network_event_delegate)
	self.network_event_delegate = network_event_delegate

	network_event_delegate:register(self, unpack(RPCS))
end

StatisticsDatabase.unregister_network_event_delegate = function (self)
	self.network_event_delegate:unregister(self)

	self.network_event_delegate = nil
end

local function init_stat(stat, backend_stats)
	local name = stat.name
	local database_name = stat.database_name

	if name then
		if database_name then
			local backend_raw_value = backend_stats[database_name]

			if backend_raw_value then
				stat.persistent_value = convert_from_backend(backend_raw_value, stat.database_type)
			else
				if Managers.backend:profiles_loaded() and not script_data.use_local_backend then
					Application.error("Statistic %-25s should have existed in the backend with name %-25s but didn't.", name, database_name)
				end

				if stat.database_type == nil then
					stat.persistent_value = 0
				elseif stat.database_type == "string" then
					stat.persistent_value = ""
				elseif stat.database_type == "lua" then
					stat.persistent_value = nil
				elseif stat.database_type == "hexarray" then
					stat.persistent_value = table.clone(stat.value)
				end
			end
		end
	else
		for stat_name, stat_definition in pairs(stat) do
			init_stat(stat_definition, backend_stats)
		end
	end
end

StatisticsDatabase.register = function (self, id, category, backend_stats)
	dbprintf("StatisticsDatabase: Registering id=%s as %s", tostring(id), category)
	assert(self.statistics[id] == nil, "There were statistics for %s already.", tostring(id))

	local definitions = StatisticsDefinitions[category]
	local stats = table.clone(definitions)

	if backend_stats then
		init_stat(stats, backend_stats)
	end

	self.statistics[id] = stats
	self.categories[id] = category
end

StatisticsDatabase.unregister = function (self, id)
	dbprintf("StatisticsDatabase: Unregistering id=%s", tostring(id))

	self.statistics[id] = nil
	self.categories[id] = nil
end

StatisticsDatabase.is_registered = function (self, id)
	return self.statistics[id]
end

local function unnetworkified_path(networkified_path)
	local path = {}

	for i, id in ipairs(networkified_path) do
		path[i] = NetworkLookup.statistics_path_names[id]
	end

	return path
end

local function networkified_path(path)
	local networkified_path = {}

	for id, name in ipairs(path) do
		networkified_path[id] = NetworkLookup.statistics_path_names[name]
	end

	return networkified_path
end

local function sync_stat(peer_id, stat_peer_id, stat_local_player_id, path, path_step, stat)
	if stat.value ~= nil then
		if stat.sync_on_hot_join then
			fassert(type(stat.value) == "number", "Not supporting hot join syncing of value %q", type(stat.value))
			fassert(path_step <= NetworkConstants.statistics_path_max_size, "statistics path is longer than max size, increase in global.networks_config")

			local networkified_path = networkified_path(path)

			RPC.rpc_hot_join_sync_statistics_number(peer_id, stat_peer_id, stat_local_player_id, networkified_path, stat.value, stat.persistent_value or 0)
		end
	else
		for stat_name, stat_definition in pairs(stat) do
			path[path_step] = stat_name

			sync_stat(peer_id, stat_peer_id, stat_local_player_id, path, path_step + 1, stat_definition)
		end
	end

	path[path_step] = nil
end

StatisticsDatabase.hot_join_sync = function (self, peer_id)
	for stat_id, category in pairs(self.categories) do
		if category == "player" then
			local player = Managers.player:player_from_stats_id(stat_id)
			local stats = self.statistics[stat_id]

			sync_stat(peer_id, player:network_id(), player:local_player_id(), {}, 1, stats)
		end
	end
end

local function reset_stat(stat)
	if stat.value ~= nil then
		if stat.database_type == nil then
			stat.value = 0
		elseif stat.database_type == "string" then
			stat.value = ""
		elseif stat.database_type == "lua" then
			stat.value = nil
		elseif stat.database_type == "hexarray" then
			for i = 1, #stat.value, 1 do
				stat.value[i] = false
			end
		end
	else
		for stat_name, stat_definition in pairs(stat) do
			reset_stat(stat_definition)
		end
	end
end

StatisticsDatabase.reset_session_stats = function (self)
	dbprintf("StatisticsDatabase: Resetting all session stats")

	for id, category in pairs(self.categories) do
		local stats = self.statistics[id]

		reset_stat(stats)
	end
end

local function generate_backend_stats(stat, backend_stats)
	if stat.value ~= nil then
		local database_name = stat.database_name

		if database_name then
			backend_stats[database_name] = convert_to_backend(stat.persistent_value, stat.database_type)
		end
	else
		for stat_name, stat_definition in pairs(stat) do
			generate_backend_stats(stat_definition, backend_stats)
		end
	end
end

StatisticsDatabase.generate_backend_stats = function (self, id, backend_stats)
	local stats = self.statistics[id]
	local category = self.categories[id]

	print("generate_backend_stats", id)
	assert(next(backend_stats) == nil, "Got non-empty table")
	generate_backend_stats(stats, backend_stats)

	return backend_stats
end

StatisticsDatabase.increment_stat = function (self, id, ...)
	local stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n, 1 do
		local arg_value = select(i, ...)
		stat = stat[arg_value]
	end

	stat.value = stat.value + 1

	if stat.persistent_value then
		stat.persistent_value = stat.persistent_value + 1
	end

	dbprintf("StatisticsDatabase: Incremented stat %s for id=%s to %f", stat.name, tostring(id), stat.value)
end

StatisticsDatabase.decrement_stat = function (self, id, ...)
	local stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n, 1 do
		local arg_value = select(i, ...)
		stat = stat[arg_value]
	end

	stat.value = stat.value - 1

	if stat.persistent_value then
		stat.persistent_value = stat.persistent_value - 1
	end

	dbprintf("StatisticsDatabase: Decremented stat %s for id=%s to %f", stat.name, tostring(id), stat.value)
end

StatisticsDatabase.modify_stat_by_amount = function (self, id, ...)
	local stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n - 1, 1 do
		local arg_value = select(i, ...)
		stat = stat[arg_value]
	end

	local increment_value = select(arg_n, ...)
	local old_value = stat.value
	stat.value = old_value + increment_value

	if stat.persistent_value then
		stat.persistent_value = stat.persistent_value + increment_value
	end

	dbprintf("StatisticsDatabase: Modified stat %s for id=%s from %f to %f", stat.name, tostring(id), old_value, old_value + increment_value)
end

StatisticsDatabase.get_array_stat = function (self, id, ...)
	local array_stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n - 1, 1 do
		local arg_value = select(i, ...)
		array_stat = array_stat[arg_value]
	end

	local array_index = select(arg_n, ...)

	return array_stat.value[array_index]
end

StatisticsDatabase.get_persistent_array_stat = function (self, id, ...)
	local array_stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n - 1, 1 do
		local arg_value = select(i, ...)
		array_stat = array_stat[arg_value]
	end

	local array_index = select(arg_n, ...)

	if array_stat.persistent_value then
		return array_stat.persistent_value[array_index]
	end

	return false
end

StatisticsDatabase.get_persistent_lorebook_stat = function (self, stats_id, category, id)
	local array_stat = self.statistics[stats_id]
	local category_stats = array_stat[category]

	if category_stats and category_stats.persistent_value then
		return category_stats.persistent_value[id]
	end

	return false
end

StatisticsDatabase.set_array_stat = function (self, id, ...)
	local array_stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n - 2, 1 do
		local arg_value = select(i, ...)
		array_stat = array_stat[arg_value]
	end

	local array_index = select(arg_n - 1, ...)
	local new_stat_value = select(arg_n, ...)
	array_stat.value[array_index] = new_stat_value

	if array_stat.persistent_value then
		array_stat.persistent_value[array_index] = new_stat_value
	end

	dbprintf("StatisticsDatabase: Set array stat %s[%s] for id=%s to %s", array_stat.name, tostring(array_index), tostring(id), tostring(new_stat_value))
end

StatisticsDatabase.set_stat = function (self, id, ...)
	local stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n - 1, 1 do
		local arg_value = select(i, ...)
		stat = stat[arg_value]
	end

	local new_value = select(arg_n, ...)
	stat.value = new_value
	stat.persistent_value = new_value
end

StatisticsDatabase.get_stat = function (self, id, ...)
	local stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n, 1 do
		local arg_value = select(i, ...)
		stat = stat[arg_value]
	end

	return stat.value
end

StatisticsDatabase.get_persistent_stat = function (self, id, ...)
	local stat = self.statistics[id]
	local arg_n = select("#", ...)

	for i = 1, arg_n, 1 do
		local arg_value = select(i, ...)
		stat = stat[arg_value]
	end

	if stat then
		return stat.persistent_value
	end

	return 0
end

local function debug_draw_stat(name, stat, indent_level)
	local stat_type = type(stat)

	if stat_type == "number" then
		if math.ceil(stat) == stat then
			Debug.text("%s%s = %d", string.rep(" ", indent_level * 2), name, stat)
		else
			Debug.text("%s%s = %.2f", string.rep(" ", indent_level * 2), name, stat)
		end
	elseif stat_type == "table" then
		Debug.text("%s%s", string.rep(" ", indent_level * 2), name, stat)

		for k, v in pairs(stat) do
			debug_draw_stat(k, v, indent_level + 1)
		end
	end
end

StatisticsDatabase.debug_draw = function (self)
	if not script_data.statistics_debug then
		return
	end

	for stats_id, stats in pairs(self.statistics) do
		Debug.text("Stats for %s", tostring(stats_id))

		for k, v in pairs(stats) do
			debug_draw_stat(k, v, 1)
		end
	end
end

StatisticsDatabase.rpc_increment_stat = function (self, sender, stat_id)
	local stat = NetworkLookup.statistics[stat_id]
	local player = Managers.player:local_player()

	if not player then
		return
	end

	local stats_id = player:stats_id()

	self:increment_stat(stats_id, stat)
end

StatisticsDatabase.rpc_set_local_player_stat = function (self, sender, stat_id, amount)
	local stat = NetworkLookup.statistics[stat_id]
	local player = Managers.player:local_player()

	if not player then
		return
	end

	local stats_id = player:stats_id()
	local old_amount = self:get_stat(stats_id, stat)

	if old_amount < amount then
		self:set_stat(stats_id, stat, amount)
	end
end

StatisticsDatabase.rpc_hot_join_sync_statistics_number = function (self, sender, peer_id, local_player_id, statistics_path_names, value, persistent_value)
	local player = Managers.player:player(peer_id, local_player_id)
	local stats_id = player:stats_id()
	local path = unnetworkified_path(statistics_path_names)
	local stat = self.statistics[stats_id]

	for i = 1, #path, 1 do
		stat = stat[path[i]]
	end

	stat.value = value

	if stat.database_name then
		stat.persistent_value = persistent_value

		dbprintf("StatisticsDatabase: Synced peer %q stat %30q to %d, persistent_value to %d", peer_id, stat.name, value, persistent_value)
	else
		fassert(persistent_value == 0, "Got non-zero persistent_value for stat %q that didn't have database_name", stat.name)
		dbprintf("StatisticsDatabase: Synced peer %q stat %30q to %d, persistent_value not present", peer_id, stat.name, value)
	end
end

local DB_UNIT_TEST = false

if DB_UNIT_TEST then
	local old_debug = script_data.statistics_debug
	script_data.statistics_debug = true

	dbprintf("Running statistics unit test")

	local backend_stats = {
		kills_total = 10,
		lorebook_unlocks = "6F"
	}
	local sdb = StatisticsDatabase:new()

	sdb:register("player1", "unit_test", backend_stats)
	assert(sdb:get_stat("player1", "kills_total") == 0)
	assert(sdb:get_stat("player1", "profiles", "witch_hunter", "kills_total") == 0)
	sdb:increment_stat("player1", "kills_total")
	sdb:increment_stat("player1", "profiles", "witch_hunter", "kills_total")
	assert(sdb:get_stat("player1", "kills_total") == 1)
	assert(sdb:get_stat("player1", "profiles", "witch_hunter", "kills_total") == 1)
	sdb:decrement_stat("player1", "kills_total")
	sdb:decrement_stat("player1", "profiles", "witch_hunter", "kills_total")
	assert(sdb:get_stat("player1", "kills_total") == 0)
	assert(sdb:get_stat("player1", "profiles", "witch_hunter", "kills_total") == 0)
	sdb:modify_stat_by_amount("player1", "kills_total", 5)
	sdb:modify_stat_by_amount("player1", "profiles", "witch_hunter", "kills_total", 5)
	assert(sdb:get_stat("player1", "kills_total") == 5)
	assert(sdb:get_stat("player1", "profiles", "witch_hunter", "kills_total") == 5)
	assert(sdb:get_array_stat("player1", "lorebook_unlocks", 1) == false)
	sdb:set_array_stat("player1", "lorebook_unlocks", 1, true)
	assert(sdb:get_array_stat("player1", "lorebook_unlocks", 1) == true)
	sdb:reset_session_stats()
	assert(sdb:get_stat("player1", "kills_total") == 0)
	assert(sdb:get_stat("player1", "profiles", "witch_hunter", "kills_total") == 0)
	assert(sdb:get_array_stat("player1", "lorebook_unlocks", 1) == false)

	local backend_stats_temp = {}

	sdb:generate_backend_stats("player1", backend_stats_temp)
	assert(backend_stats_temp.kills_total == tostring(15))
	assert(backend_stats_temp.lorebook_unlocks == "EF")
	sdb:unregister("player1")
	sdb:destroy()

	script_data.statistics_debug = old_debug
end

return
