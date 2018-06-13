ACHIEVEMENT_VERSION_NUMBER = 1

local function check_level_list(statistics_db, stats_id, levels_to_complete)
	if Development.parameter("beta_level_progression") then
		return false
	end

	for i = 1, #levels_to_complete, 1 do
		local level_id = levels_to_complete[i]
		local completed = statistics_db:get_persistent_stat(stats_id, "completed_levels", level_id) > 0

		if not completed then
			return false
		end
	end

	return true
end

local function check_level_list_difficulty(statistics_db, stats_id, levels_to_complete, difficulty)
	if Development.parameter("beta_level_progression") then
		return false
	end

	for i = 1, #levels_to_complete, 1 do
		local level_id = levels_to_complete[i]
		local level_difficulty_name = LevelDifficultyDBNames[level_id]
		local completed = difficulty <= statistics_db:get_persistent_stat(stats_id, "completed_levels_difficulty", level_difficulty_name)

		if not completed then
			return false
		end
	end

	return true
end

local function check_unlock(unlock_name)
	local backend_manager = Managers.backend

	if backend_manager:available() and backend_manager:profiles_loaded() then
		local experience = ScriptBackendProfileAttribute.get("experience")
		local level = ExperienceSettings.get_level(experience)
		local prestige = 0

		return ProgressionUnlocks.is_unlocked(unlock_name, level, prestige)
	end

	return false
end

local function get_hard_mode_completed_mission_data(mission_name, difficulty)
	if not Managers.state.entity then
		return
	end

	if not Managers.state.game_mode:game_won() then
		return
	end

	local difficulty_rank = DifficultySettings[difficulty].rank

	if Managers.state.difficulty:get_difficulty_rank() < difficulty_rank then
		return
	end

	local mission_system = Managers.state.entity:system("mission_system")
	local active_missions, completed_missions = mission_system:get_missions()

	if not completed_missions then
		return
	end

	return completed_missions[mission_name]
end

local function add_level_complete_achievement(AchievementTemplates, level_name, xb1_id, ps4_id)
	AchievementTemplates["complete_" .. level_name] = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", level_name) > 0
		end,
		ID_XB1 = xb1_id,
		ID_PS4 = ps4_id
	}
end

AchievementTemplates = {
	complete_the_horn_of_magnus = {
		ID_XB1 = "Prologue",
		ID_PS4 = "001",
		evaluate = function (statistics_db, stats_id)
			return check_level_list(statistics_db, stats_id, LevelSettingsCampaign.prologue)
		end
	},
	complete_act_one = {
		ID_XB1 = "Act1",
		ID_PS4 = "002",
		evaluate = function (statistics_db, stats_id)
			return check_level_list(statistics_db, stats_id, LevelSettingsCampaign.act_1)
		end
	},
	complete_act_2 = {
		ID_XB1 = "Act2",
		ID_PS4 = "003",
		evaluate = function (statistics_db, stats_id)
			return check_level_list(statistics_db, stats_id, LevelSettingsCampaign.act_2)
		end
	},
	complete_act_3 = {
		ID_XB1 = "Act3",
		ID_PS4 = "004",
		evaluate = function (statistics_db, stats_id)
			return check_level_list(statistics_db, stats_id, LevelSettingsCampaign.act_3)
		end
	},
	complete_all_missions = {
		ID_XB1 = "DefendersOfUbersreik",
		ID_PS4 = "005",
		evaluate = function (statistics_db, stats_id)
			return check_level_list(statistics_db, stats_id, LevelSettingsCampaign.level_list)
		end
	},
	complete_all_missions_on_hard = {
		ID_XB1 = "SavioursOfReikland",
		ID_PS4 = "006",
		evaluate = function (statistics_db, stats_id)
			return check_level_list_difficulty(statistics_db, stats_id, LevelSettingsCampaign.level_list, 3)
		end
	},
	complete_all_missions_on_nightmare = {
		ID_XB1 = "ChampionsOfTheEmpire",
		ID_PS4 = "007",
		evaluate = function (statistics_db, stats_id)
			return check_level_list_difficulty(statistics_db, stats_id, LevelSettingsCampaign.level_list, 4)
		end
	},
	complete_all_missions_on_cataclysm = {
		ID_XB1 = "HeroesOfTheEndTimes",
		ID_PS4 = "008",
		evaluate = function (statistics_db, stats_id)
			return check_level_list_difficulty(statistics_db, stats_id, LevelSettingsCampaign.level_list, 5)
		end
	},
	complete_one_mission_on_hard = {
		ID_XB1 = "Gauntlet",
		ID_PS4 = "009",
		evaluate = function (statistics_db, stats_id)
			local level_list = nil

			if PLATFORM == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for i = 1, #level_list, 1 do
				local level_id = level_list[i]

				if LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_id) >= 3 then
					return true
				end
			end

			return false
		end
	},
	complete_one_mission_on_nightmare = {
		ID_XB1 = "TrialByFire",
		ID_PS4 = "010",
		evaluate = function (statistics_db, stats_id)
			local level_list = nil

			if PLATFORM == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for i = 1, #level_list, 1 do
				local level_id = level_list[i]

				if LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_id) >= 4 then
					return true
				end
			end

			return false
		end
	},
	complete_one_mission_on_cataclysm = {
		ID_XB1 = "EndTimesExcursion",
		ID_PS4 = "011",
		evaluate = function (statistics_db, stats_id)
			local level_list = nil

			if PLATFORM == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for i = 1, #level_list, 1 do
				local level_id = level_list[i]

				if LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_id) >= 5 then
					return true
				end
			end

			return false
		end
	},
	destroy_five_hundred_dynamic_objects = {
		ID_XB1 = "DomesticDisturbance",
		ID_PS4 = "012",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "dynamic_objects_destroyed") >= 500
		end
	},
	carry_a_grimoire_to_the_end_of_a_level = {
		ID_XB1 = "Dissident",
		ID_PS4 = "013",
		evaluate = function (statistics_db, stats_id)
			local level_list = nil

			if PLATFORM == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for _, level_id in pairs(level_list) do
				if statistics_db:get_persistent_stat(stats_id, "collected_grimoires", level_id) > 0 then
					return true
				end
			end

			return false
		end
	},
	get_the_killing_blow_on_a_rat_ogre = {
		ID_XB1 = "Moulderbane",
		ID_PS4 = "014",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "kills_per_breed", "skaven_rat_ogre") > 0
		end
	},
	be_part_of_killing_a_rat_ogre = {
		ID_XB1 = "Rakogridrengi",
		ID_PS4 = "015",
		evaluate = function (statistics_db, stats_id)
			local has_damaged_ogre = statistics_db:get_stat(stats_id, "damage_dealt_per_breed", "skaven_rat_ogre") > 0

			if has_damaged_ogre then
				local players = Managers.player:human_and_bot_players()

				for _, player in pairs(players) do
					local stats_id = player:stats_id()

					if statistics_db:get_stat(stats_id, "kills_per_breed", "skaven_rat_ogre") > 0 then
						return true
					end
				end
			end

			return false
		end
	},
	be_part_of_killing_a_rat_stormvermin_patrol = {
		ID_XB1 = "PestControl",
		ID_PS4 = "016",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "killed_patrols") > 0
		end
	},
	use_ten_medical_supplies_on_your_allies = {
		ID_XB1 = "Shallya",
		ID_PS4 = "017",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "times_friend_healed") >= 10
		end
	},
	kill_five_skavens_with_one_grenade = {
		ID_XB1 = "FiveRatsOneStone",
		ID_PS4 = "018",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "best_projectile_multikill") > 4
		end
	},
	acquire_an_item_with_exotic_quality = {
		ID_XB1 = "ForceOfNature",
		ID_PS4 = "019",
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				local items = ScriptBackendItem.get_all_backend_items()

				for _, backend_item_data in pairs(items) do
					local item_data = ItemMasterList[backend_item_data.key]

					if item_data.rarity == "exotic" then
						return true
					end
				end
			end

			return false
		end
	},
	reach_rank_one_hundred = {
		ID_XB1 = "KarlFranz",
		ID_PS4 = "020",
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				local experience = ScriptBackendProfileAttribute.get("experience")
				local level = ExperienceSettings.get_level(experience)

				return level >= 100
			end
		end
	},
	unlock_the_forge = {
		ID_XB1 = "HammerAndAnvil",
		ID_PS4 = "021",
		evaluate = function (statistics_db, stats_id)
			return check_unlock("forge")
		end
	},
	salvage_one_item = {
		ID_XB1 = "FlotsamAndJetsam",
		ID_PS4 = "022",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "salvaged_items") > 0
		end
	},
	upgrade_one_item = {
		ID_XB1 = "DwarvenHands",
		ID_PS4 = "023",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "upgraded_items") > 0
		end
	},
	fuse_an_item_in_the_forge = {
		ID_XB1 = "TilDeathDoUsPart",
		ID_PS4 = "024",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "fused_items") > 0
		end
	},
	salvage_one_hundred_items = {
		ID_XB1 = "ImperialSalvager",
		ID_PS4 = "025",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "salvaged_items") >= 100
		end
	},
	fuse_twenty_five_items_in_the_forge = {
		ID_XB1 = "Grungni",
		ID_PS4 = "026",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "fused_items") >= 25
		end
	},
	equip_a_trinket_for_the_first_time = {
		ID_XB1 = "ReiklandAccessories",
		ID_PS4 = "027",
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				for idx, profile in pairs(SPProfiles) do
					local slot_trinket_1 = BackendUtils.get_loadout_item(profile.display_name, "slot_trinket_1")
					local slot_trinket_2 = BackendUtils.get_loadout_item(profile.display_name, "slot_trinket_2")
					local slot_trinket_3 = BackendUtils.get_loadout_item(profile.display_name, "slot_trinket_3")

					if slot_trinket_1 or slot_trinket_2 or slot_trinket_3 then
						return true
					end
				end
			end

			return false
		end
	},
	unlock_the_third_trinket_slot = {
		ID_XB1 = "Trinkaholic",
		ID_PS4 = "028",
		evaluate = function (statistics_db, stats_id)
			return check_unlock("slot_trinket_3")
		end
	},
	equip_and_exotic_item_in_every_slot_on_a_single_hero = {
		ID_XB1 = "Connoisseur",
		ID_PS4 = "029",
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				local slots = InventorySettings.slots

				for _, profile in pairs(SPProfiles) do
					local display_name = profile.display_name
					local all_exotic = true

					for _, slot in pairs(slots) do
						if slot.loadout_slot then
							local slot_name = slot.name
							local item_data = BackendUtils.get_loadout_item(display_name, slot_name)

							if not item_data or item_data.rarity ~= "exotic" then
								all_exotic = false

								break
							end
						end
					end

					if all_exotic then
						return true
					end
				end
			end

			return false
		end
	},
	collect_one_tome = {
		ID_XB1 = "Scholar",
		ID_PS4 = "030",
		evaluate = function (statistics_db, stats_id)
			local level_list = nil

			if PLATFORM == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for _, level_id in pairs(LevelSettingsCampaign.level_list) do
				if statistics_db:get_persistent_stat(stats_id, "collected_tomes", level_id) > 0 then
					return true
				end
			end

			return false
		end
	},
	collect_all_tomes = {
		ID_XB1 = "BalthasarGelt",
		ID_PS4 = "031",
		evaluate = function (statistics_db, stats_id)
			local levels_with_tomes = nil

			if PLATFORM == "win32" then
				levels_with_tomes = LevelSettingsCampaign.levels_with_tomes
			else
				levels_with_tomes = LevelSettingsCampaign.console_levels_with_tomes
			end

			for _, level_id in pairs(levels_with_tomes) do
				local max_amount = LevelSettingsCampaign.tome_amount_exceptions[level_id] or 3
				local amount = statistics_db:get_persistent_stat(stats_id, "collected_tomes", level_id)

				if amount < max_amount then
					return false
				end
			end

			return true
		end
	},
	complete_a_mission_as_every_hero = {
		ID_XB1 = "FuriousFive",
		ID_PS4 = "032",
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				for idx, profile in pairs(SPProfiles) do
					if statistics_db:get_persistent_stat(stats_id, "complete_level_" .. profile.display_name) <= 0 then
						return false
					end
				end

				return true
			end

			return false
		end
	},
	complete_a_mission_as_the_bright_wizard = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				return statistics_db:get_persistent_stat(stats_id, "complete_level_bright_wizard") > 0
			end

			return false
		end
	},
	complete_a_mission_as_the_way_watcher = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				return statistics_db:get_persistent_stat(stats_id, "complete_level_wood_elf") > 0
			end

			return false
		end
	},
	complete_a_mission_as_the_empire_soldier = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				return statistics_db:get_persistent_stat(stats_id, "complete_level_empire_soldier") > 0
			end

			return false
		end
	},
	complete_a_mission_as_the_witch_hunter = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				return statistics_db:get_persistent_stat(stats_id, "complete_level_witch_hunter") > 0
			end

			return false
		end
	},
	complete_a_mission_as_the_dwarf_ranger = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				return statistics_db:get_persistent_stat(stats_id, "complete_level_dwarf_ranger") > 0
			end

			return false
		end
	},
	roll_seven_successes = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "dice_roll_successes") >= 8
		end
	},
	collect_both_grimoires_on_magnus = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_grimoires", "magnus") >= 2
		end
	},
	collect_both_grimoires_on_merchant = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_grimoires", "merchant") >= 2
		end
	},
	collect_both_grimoires_on_wizard = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_grimoires", "wizard") >= 2
		end
	},
	collect_both_grimoires_on_forest_ambush = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_grimoires", "forest_ambush") >= 2
		end
	},
	collect_both_grimoires_on_cemetery = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_grimoires", "cemetery") >= 2
		end
	},
	collect_both_grimoires_on_tunnels = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_grimoires", "tunnels") >= 2
		end
	},
	collect_all_tomes_on_magnus = {
		ID_XB1 = "ThePious",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_tomes", "magnus") >= 3
		end
	},
	collect_all_tomes_on_merchant = {
		ID_XB1 = "Marktplatz",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_tomes", "merchant") >= 3
		end
	},
	collect_all_tomes_on_wizard = {
		ID_XB1 = "WindsOfUlgu",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_tomes", "wizard") >= 3
		end
	},
	collect_all_tomes_on_forest_ambush = {
		ID_XB1 = "Reikwald",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_tomes", "forest_ambush") >= 3
		end
	},
	collect_all_tomes_on_cemetery = {
		ID_XB1 = "BlackGuard",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_tomes", "cemetery") >= 3
		end
	},
	collect_all_tomes_on_tunnels = {
		ID_XB1 = "Mandred",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "collected_tomes", "tunnels") >= 3
		end
	},
	win_item_as_wood_elf = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "win_item_as_wood_elf") == 1
		end
	},
	win_item_as_witch_hunter = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "win_item_as_witch_hunter") == 1
		end
	},
	win_item_as_bright_wizard = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "win_item_as_bright_wizard") == 1
		end
	},
	win_item_as_dwarf_ranger = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "win_item_as_dwarf_ranger") == 1
		end
	},
	win_item_as_empire_soldier = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "win_item_as_empire_soldier") == 1
		end
	},
	last_stand_town_meeting_bronze = {
		ID_XB1 = "Defient",
		ID_PS4 = "033",
		evaluate = function (statistics_db, stats_id)
			return SurvivalSettings.achievement_data.bronze <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_hard_waves")
		end
	},
	last_stand_town_meeting_silver = {
		ID_XB1 = "Stalwart",
		ID_PS4 = "034",
		evaluate = function (statistics_db, stats_id)
			local complete = SurvivalSettings.achievement_data.silver <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_hard_waves")
			complete = complete or SurvivalSettings.achievement_data.bronze <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_harder_waves")

			return complete
		end
	},
	last_stand_town_meeting_gold = {
		ID_XB1 = "Unbreakable",
		ID_PS4 = "035",
		evaluate = function (statistics_db, stats_id)
			local complete = SurvivalSettings.achievement_data.gold <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_hard_waves")
			complete = complete or SurvivalSettings.achievement_data.silver <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_harder_waves")
			complete = complete or SurvivalSettings.achievement_data.bronze <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_hardest_waves")

			return complete
		end
	},
	last_stand_the_fall_bronze = {
		evaluate = function (statistics_db, stats_id)
			return SurvivalSettings.achievement_data.bronze <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_hard_waves")
		end
	},
	last_stand_the_fall_silver = {
		evaluate = function (statistics_db, stats_id)
			local complete = SurvivalSettings.achievement_data.silver <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_hard_waves")
			complete = complete or SurvivalSettings.achievement_data.bronze <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_harder_waves")

			return complete
		end
	},
	last_stand_the_fall_gold = {
		evaluate = function (statistics_db, stats_id)
			local complete = SurvivalSettings.achievement_data.gold <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_hard_waves")
			complete = complete or SurvivalSettings.achievement_data.silver <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_harder_waves")
			complete = complete or SurvivalSettings.achievement_data.bronze <= statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_hardest_waves")

			return complete
		end
	},
	last_stand_wave_complete = {
		ID_XB1 = "OneDownEndlessToGo",
		ID_PS4 = "036",
		evaluate = function (statistics_db, stats_id)
			local complete = statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_hard_waves") >= 1
			complete = complete or statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_harder_waves") >= 1
			complete = complete or statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_ruins_survival_hardest_waves") >= 1
			complete = complete or statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_hard_waves") >= 1
			complete = complete or statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_harder_waves") >= 1
			complete = complete or statistics_db:get_persistent_stat(stats_id, "survival_dlc_survival_magnus_survival_hardest_waves") >= 1

			return complete
		end
	},
	last_stand_single_endurance_badge = {
		ID_XB1 = "FindersKeepers",
		ID_PS4 = "037",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "endurance_badges") >= 1
		end
	},
	last_stand_multiple_endurance_badges = {
		ID_XB1 = "Tenacious",
		ID_PS4 = "038",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "endurance_badges") >= 200
		end
	},
	complete_drachenfels_portals = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_portals") > 0
		end
	},
	complete_drachenfels_castle = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_castle") > 0
		end
	},
	complete_drachenfels_castle_dungeon = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_castle_dungeon") > 0
		end
	},
	complete_challenge_wizard_hard = {
		evaluate = function (statistics_db, stats_id)
			return LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, "dlc_challenge_wizard") >= 3
		end
	},
	complete_challenge_wizard_nightmare = {
		evaluate = function (statistics_db, stats_id)
			return LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, "dlc_challenge_wizard") >= 4
		end
	},
	complete_challenge_wizard_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			return LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, "dlc_challenge_wizard") >= 5
		end
	},
	complete_drachenfels_castle_dungeon = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_castle_dungeon") > 0
		end
	},
	magnus_hard_mode_nightmare = {
		ID_XB1 = "Hornblower",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("magnus_speed_run", "harder")

			if PLATFORM == "win32" then
				return mission_data and mission_data.end_time <= 180
			else
				return mission_data and mission_data.end_time <= 240
			end
		end
	},
	supply_and_demand_hard_mode_nightmare = {
		ID_XB1 = "LowSupplyHighDemand",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("merchant_no_healing", "harder")

			return mission_data and mission_data.generic_counter == 0
		end
	},
	city_wall_hard_mode_nightmare = {
		ID_XB1 = "Unchained",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("city_wall_timed", "harder")

			return mission_data and mission_data.end_time <= 5
		end
	},
	engines_of_war_hard_mode_nightmare = {
		ID_XB1 = "ControlledDemolition",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("engines_of_war_timed", "harder")

			return mission_data and mission_data.end_time <= 5
		end
	},
	white_rat_hard_mode_nightmare = {
		ID_XB1 = "CollateralBenefit",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("white_rat_kill_stormvermin", "harder")

			if PLATFORM == "win32" then
				return mission_data and mission_data.generic_counter >= 13
			else
				return mission_data and mission_data.generic_counter >= 5
			end
		end
	},
	well_watch_hard_mode_nightmare = {
		ID_XB1 = "NotOnYourWatch",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("well_watch_keep_wells_alive", "harder")

			return mission_data and mission_data.generic_counter == 0
		end
	},
	waterfront_hard_mode_nightmare = {
		ID_XB1 = "CoordinatedAssault",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("waterfront_speed_run", "harder")

			if PLATFORM == "win32" then
				return mission_data and mission_data.end_time <= 45
			else
				return mission_data and mission_data.end_time <= 60
			end
		end
	},
	garden_of_morr_hard_mode_nightmare = {
		ID_XB1 = "AWorthySacrifice",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("cemetery_tome_and_grim_bury", "harder")

			return mission_data and mission_data.generic_counter == 5
		end
	},
	enemy_below_hard_mode_nightmare = {
		ID_XB1 = "TheBellTolls",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("enemy_below_kill_gutter_runners", "harder")

			if PLATFORM == "win32" then
				return mission_data and mission_data.generic_counter >= 20
			else
				return mission_data and mission_data.generic_counter >= 13
			end
		end
	},
	black_powder_hard_mode_nightmare = {
		ID_XB1 = "HighAsAKite",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("black_powder_dont_kill_rat_ogre", "harder")

			return mission_data and mission_data.generic_counter == 0
		end
	},
	wheat_and_chaff_hard_mode_nightmare = {
		ID_XB1 = "SpecialDelivery",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("farm_dont_drop_sacks", "harder")

			return mission_data and mission_data.generic_counter <= 6
		end
	},
	smugglers_run_hard_mode_nightmare = {
		ID_XB1 = "ThirstForPowder",
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("smugglers_bring_barrels", "harder")

			if PLATFORM == "win32" then
				return mission_data and mission_data.generic_counter == 4
			else
				return mission_data and mission_data.generic_counter == 3
			end
		end
	},
	wizards_tower_hard_mode_nightmare = {
		ID_XB1 = "PierceTheVeil",
		evaluate = function (statistics_db, stats_id)
			if not Managers.state.entity then
				return
			end

			local difficulty = "harder"
			local difficulty_rank = DifficultySettings[difficulty].rank

			if Managers.state.difficulty:get_difficulty_rank() < difficulty_rank then
				return
			end

			local mission_system = Managers.state.entity:system("mission_system")
			local active_missions, completed_missions = mission_system:get_missions()

			if PLATFORM ~= "win32" then
				if not completed_missions then
					return
				end

				local mission = completed_missions.wizards_tower_protect_wards

				return mission and mission.generic_counter == 0
			else
				if not active_missions then
					return
				end

				local mission = active_missions.wizards_tower_protect_wards

				return mission and mission.generic_counter > 0
			end
		end
	},
	magnus_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("magnus_speed_run", "hardest")

			return mission_data and mission_data.end_time <= 180
		end
	},
	supply_and_demand_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("merchant_no_healing", "hardest")

			return mission_data and mission_data.generic_counter == 0
		end
	},
	city_wall_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("city_wall_timed", "hardest")

			return mission_data and mission_data.end_time <= 5
		end
	},
	engines_of_war_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("engines_of_war_timed", "hardest")

			return mission_data and mission_data.end_time <= 5
		end
	},
	white_rat_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("white_rat_kill_stormvermin", "hardest")

			return mission_data and mission_data.generic_counter >= 13
		end
	},
	well_watch_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("well_watch_keep_wells_alive", "hardest")

			return mission_data and mission_data.generic_counter == 0
		end
	},
	waterfront_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("waterfront_speed_run", "hardest")

			return mission_data and mission_data.end_time <= 45
		end
	},
	garden_of_morr_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("cemetery_tome_and_grim_bury", "hardest")

			return mission_data and mission_data.generic_counter == 5
		end
	},
	enemy_below_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("enemy_below_kill_gutter_runners", "hardest")

			return mission_data and mission_data.generic_counter >= 20
		end
	},
	black_powder_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("black_powder_dont_kill_rat_ogre", "hardest")

			return mission_data and mission_data.generic_counter == 0
		end
	},
	wheat_and_chaff_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("farm_dont_drop_sacks", "hardest")

			return mission_data and mission_data.generic_counter <= 6
		end
	},
	smugglers_run_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			local mission_data = get_hard_mode_completed_mission_data("smugglers_bring_barrels", "hardest")

			return mission_data and mission_data.generic_counter == 4
		end
	},
	wizards_tower_hard_mode_cataclysm = {
		evaluate = function (statistics_db, stats_id)
			if not Managers.state.entity then
				return
			end

			local difficulty = "hardest"
			local difficulty_rank = DifficultySettings[difficulty].rank

			if Managers.state.difficulty:get_difficulty_rank() < difficulty_rank then
				return
			end

			local mission_system = Managers.state.entity:system("mission_system")
			local active_missions, completed_missions = mission_system:get_missions()

			if not active_missions then
				return
			end

			local mission = active_missions.wizards_tower_protect_wards

			return mission and mission.generic_counter > 0
		end
	}
}

if PLATFORM == "win32" then
	AchievementTemplates.complete_dwarf_exterior = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_dwarf_exterior") > 0
		end
	}
	AchievementTemplates.complete_dwarf_interior = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_dwarf_interior") > 0
		end
	}
	AchievementTemplates.complete_dwarf_beacons = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_dwarf_beacons") > 0
		end
	}
end

add_level_complete_achievement(AchievementTemplates, "dlc_stromdorf_hills", "TheParley", "051")
add_level_complete_achievement(AchievementTemplates, "dlc_stromdorf_town", "ThunderwaterAle", "052")

AchievementTemplates.dodged_krench = {
	ID_XB1 = "Krench",
	ID_PS4 = "053",
	evaluate = function (statistics_db, stats_id)
		return statistics_db:get_stat(stats_id, "dodged_storm_vermin_champion") >= 3
	end
}
AchievementTemplates.equipped_executioners_sword = {
	ID_XB1 = "HeadsWillRoll",
	ID_PS4 = "054",
	evaluate = function (statistics_db, stats_id)
		return statistics_db:get_stat(stats_id, "equipped_executioners_sword") > 0
	end
}
AchievementTemplates.executor_headshots = {
	ID_XB1 = "HeadingForDecapitation",
	ID_PS4 = "055",
	evaluate = function (statistics_db, stats_id)
		return statistics_db:get_persistent_stat(stats_id, "executor_headshot") >= 1
	end
}

add_level_complete_achievement(AchievementTemplates, "dlc_reikwald_forest", "ReikwaldRomp", "56")
add_level_complete_achievement(AchievementTemplates, "dlc_reikwald_river", "BargeAtLarge", "57")

AchievementTemplates.equipped_ceremonial_daggers = {
	ID_XB1 = "BladesOfAqshy",
	ID_PS4 = "058",
	evaluate = function (statistics_db, stats_id)
		return statistics_db:get_stat(stats_id, "equipped_ceremonial_daggers") > 0
	end
}
AchievementTemplates.ceremonial_dagger_burn = {
	ID_XB1 = "Cauterizer",
	ID_PS4 = "059",
	evaluate = function (statistics_db, stats_id)
		return statistics_db:get_persistent_stat(stats_id, "ceremonial_dagger_burn") >= 100
	end
}

if PLATFORM ~= "win32" then
	AchievementTemplates.rescue_bardin_goreksson_from_the_skaven = {
		ID_XB1 = "Wutelgi",
		ID_PS4 = "039",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "tutorial_revive_ally") > 0
		end
	}
	AchievementTemplates.complete_dwarf_exterior = {
		ID_XB1 = "ByValaya",
		ID_PS4 = "043",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_dwarf_interior") > 0
		end
	}
	AchievementTemplates.complete_dwarf_interior = {
		ID_XB1 = "SmashAndGrab",
		ID_PS4 = "044",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_dwarf_exterior") > 0
		end
	}
	AchievementTemplates.complete_dwarf_beacons = {
		ID_XB1 = "BeaconOfHope",
		ID_PS4 = "045",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_persistent_stat(stats_id, "completed_levels", "dlc_dwarf_beacons") > 0
		end
	}
	AchievementTemplates.khazid_kro_complete_the_brewery_event_in_less_than_x_seconds = {
		ID_XB1 = "GatheringSteam",
		ID_PS4 = "046",
		evaluate = function (statistics_db, stats_id)
			if not Managers.state.entity then
				return
			end

			local mission_system = Managers.state.entity:system("mission_system")
			local active_missions, completed_missions = mission_system:get_missions()

			if not completed_missions then
				return
			end

			local completed_dwarf_interior_stabilize_pressure = completed_missions.dwarf_interior_stabilize_pressure

			if not completed_dwarf_interior_stabilize_pressure then
				return
			end

			return completed_dwarf_interior_stabilize_pressure.end_time < 240
		end
	}
	AchievementTemplates.chain_offire_complete_the_final_event_without_stopping_the_ignition_sequence = {
		ID_XB1 = "StepUpToThePlate",
		ID_PS4 = "047",
		evaluate = function (statistics_db, stats_id)
			if not Managers.state.entity then
				return
			end

			local mission_system = Managers.state.entity:system("mission_system")
			local active_missions, completed_missions = mission_system:get_missions()

			if not completed_missions then
				return
			end

			local dwarf_beacons_activate_beacon = completed_missions.dwarf_beacons_activate_beacon

			if not dwarf_beacons_activate_beacon then
				return
			end

			return dwarf_beacons_activate_beacon.generic_counter == 0
		end
	}
	AchievementTemplates.the_cursed_rune_take_no_team_damage_during_the_quarry_event = {
		ID_XB1 = "Ironbreaker",
		ID_PS4 = "048",
		evaluate = function (statistics_db, stats_id)
			if not Managers.state.entity then
				return
			end

			local mission_system = Managers.state.entity:system("mission_system")
			local active_missions, completed_missions = mission_system:get_missions()

			if not completed_missions then
				return
			end

			local dwarf_exterior_survive = completed_missions.dwarf_exterior_survive

			if not dwarf_exterior_survive then
				return
			end

			return dwarf_exterior_survive.generic_counter == 0
		end
	}
	AchievementTemplates.khazid_kro_get_timed_explosives_in_place_with_less_than_one_second_left = {
		ID_XB1 = "PerfectTiming",
		ID_PS4 = "049",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "fuse_time_when_socketed") < 2
		end
	}
	AchievementTemplates.kill_a_stormvermin_in_one_blow_using_bardins_pick = {
		ID_XB1 = "PickHisBrain",
		ID_PS4 = "050",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "stormvermin_pick_instakills") > 0
		end
	}
	AchievementTemplates.complete_your_first_contract = {
		ID_XB1 = "Mercenary",
		ID_PS4 = "040",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "contracts_completed") > 0
		end
	}
	AchievementTemplates.complete_your_first_quest = {
		ID_XB1 = "BountyHunter",
		ID_PS4 = "041",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "quests_completed") > 0
		end
	}
	AchievementTemplates.get_your_first_boon = {
		ID_XB1 = "Blessed",
		ID_PS4 = "042",
		evaluate = function (statistics_db, stats_id)
			local player_manager = Managers.player

			if not player_manager then
				return false
			end

			local local_player = player_manager:local_player()

			if not local_player then
				return false
			end

			local boon_handler = local_player.boon_handler

			if not boon_handler then
				return false
			end

			return boon_handler:has_any_boon()
		end
	}
end

local function completed_levels(statistics_db, stats_id)
	local levels_completed = 0

	for _, level_id in ipairs(MainGameLevels) do
		levels_completed = levels_completed + statistics_db:get_stat(stats_id, "completed_levels", level_id)
	end

	for _, level_id in ipairs(NoneActLevels) do
		levels_completed = levels_completed + statistics_db:get_stat(stats_id, "completed_levels", level_id)
	end

	return levels_completed
end

local function collected_tomes(statistics_db, stats_id)
	local mission_system = Managers.state.entity:system("mission_system")
	local tome_mission_data = mission_system:get_level_end_mission_data("tome_bonus_mission")

	if not tome_mission_data then
		return 0
	end

	return tome_mission_data.current_amount
end

local function collected_grimoires(statistics_db, stats_id)
	local mission_system = Managers.state.entity:system("mission_system")
	local grimoire_mission_data = mission_system:get_level_end_mission_data("grimoire_hidden_mission")

	if not grimoire_mission_data then
		return 0
	end

	return grimoire_mission_data.current_amount
end

HeroStats = {
	mission_completed = {
		persistent = true,
		stat_name = "HeroMissionCompleted",
		evaluate = function (statistics_db, stats_id)
			return completed_levels(statistics_db, stats_id)
		end
	},
	skaven_killed = {
		persistent = false,
		stat_name = "HeroSkavenKilled",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "kills_total")
		end
	},
	rat_ogres_killed = {
		persistent = false,
		stat_name = "HeroOgresKilled",
		evaluate = function (statistics_db, stats_id)
			return statistics_db:get_stat(stats_id, "kills_per_breed", "skaven_rat_ogre")
		end
	},
	tomes_collected = {
		persistent = false,
		stat_name = "HeroTomesCollected",
		evaluate = function (statistics_db, stats_id)
			return collected_tomes(statistics_db, stats_id)
		end
	},
	grimoires_collected = {
		persistent = false,
		stat_name = "HeroGrimoiresCollected",
		evaluate = function (statistics_db, stats_id)
			return collected_grimoires(statistics_db, stats_id)
		end
	}
}
AchievementTemplates_n = 0
local templates = {}

for name, template in pairs(AchievementTemplates) do
	template.name = name
	AchievementTemplates_n = AchievementTemplates_n + 1
	templates[AchievementTemplates_n] = template
	templates[name] = template
end

AchievementTemplates = templates

return
