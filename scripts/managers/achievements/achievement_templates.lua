ACHIEVEMENT_VERSION_NUMBER = 1

local function check_level_list(statistics_db, stats_id, levels_to_complete)
	if Development.parameter("beta_level_progression") then
		return false
	end

	for i = 1, #levels_to_complete, 1 do
		local level_id = levels_to_complete[i]
		local completed = 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", level_id)

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
		local completed = difficulty <= statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels_difficulty", level_difficulty_name)

		if not completed then
			return false
		end
	end

	return true
end

local function check_unlock(unlock_name)
	local backend_manager = Managers.backend

	if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
		local experience = ScriptBackendProfileAttribute.get("experience")
		local level = ExperienceSettings.get_level(experience)
		local prestige = 0

		return ProgressionUnlocks.is_unlocked(unlock_name, level, prestige)
	end

	return false
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

			if Application.platform() == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for i = 1, #level_list, 1 do
				local level_id = level_list[i]

				if 3 <= LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_id) then
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

			if Application.platform() == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for i = 1, #level_list, 1 do
				local level_id = level_list[i]

				if 4 <= LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_id) then
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

			if Application.platform() == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for i = 1, #level_list, 1 do
				local level_id = level_list[i]

				if 5 <= LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_id) then
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
			return 500 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "dynamic_objects_destroyed")
		end
	},
	carry_a_grimoire_to_the_end_of_a_level = {
		ID_XB1 = "Dissident",
		ID_PS4 = "013",
		evaluate = function (statistics_db, stats_id)
			local level_list = nil

			if Application.platform() == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for _, level_id in pairs(level_list) do
				if 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_grimoires", level_id) then
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
			return 0 < statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_rat_ogre")
		end
	},
	be_part_of_killing_a_rat_ogre = {
		ID_XB1 = "Rakogridrengi",
		ID_PS4 = "015",
		evaluate = function (statistics_db, stats_id)
			local has_damaged_ogre = 0 < statistics_db.get_stat(statistics_db, stats_id, "damage_dealt_per_breed", "skaven_rat_ogre")

			if has_damaged_ogre then
				local players = Managers.player:human_and_bot_players()

				for _, player in pairs(players) do
					local stats_id = player.stats_id(player)

					if 0 < statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_rat_ogre") then
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
			return 0 < statistics_db.get_stat(statistics_db, stats_id, "killed_patrols")
		end
	},
	use_ten_medical_supplies_on_your_allies = {
		ID_XB1 = "Shallya",
		ID_PS4 = "017",
		evaluate = function (statistics_db, stats_id)
			return 10 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "times_friend_healed")
		end
	},
	kill_five_skavens_with_one_grenade = {
		ID_XB1 = "FiveRatsOneStone",
		ID_PS4 = "018",
		evaluate = function (statistics_db, stats_id)
			return 4 < statistics_db.get_stat(statistics_db, stats_id, "best_projectile_multikill")
		end
	},
	acquire_an_item_with_exotic_quality = {
		ID_XB1 = "ForceOfNature",
		ID_PS4 = "019",
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
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

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
				local experience = ScriptBackendProfileAttribute.get("experience")
				local level = ExperienceSettings.get_level(experience)

				return 100 <= level
			end

			return 
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
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "salvaged_items")
		end
	},
	upgrade_one_item = {
		ID_XB1 = "DwarvenHands",
		ID_PS4 = "023",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_stat(statistics_db, stats_id, "upgraded_items")
		end
	},
	fuse_an_item_in_the_forge = {
		ID_XB1 = "TilDeathDoUsPart",
		ID_PS4 = "024",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "fused_items")
		end
	},
	salvage_one_hundred_items = {
		ID_XB1 = "ImperialSalvager",
		ID_PS4 = "025",
		evaluate = function (statistics_db, stats_id)
			return 100 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "salvaged_items")
		end
	},
	fuse_twenty_five_items_in_the_forge = {
		ID_XB1 = "Grungni",
		ID_PS4 = "026",
		evaluate = function (statistics_db, stats_id)
			return 25 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "fused_items")
		end
	},
	equip_a_trinket_for_the_first_time = {
		ID_XB1 = "ReiklandAccessories",
		ID_PS4 = "027",
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
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

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
				local slots = InventorySettings.slots

				for idx, profile in pairs(SPProfiles) do
					local non_exotic = false

					for _, slot in pairs(slots) do
						local slot_name = slot.name
						local item_data = BackendUtils.get_loadout_item(profile.display_name, slot_name)
						non_exotic = non_exotic or (item_data and item_data.rarity ~= "exotic")

						if non_exotic then
							break
						end
					end

					if not non_exotic then
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

			if Application.platform() == "win32" then
				level_list = LevelSettingsCampaign.level_list
			else
				level_list = LevelSettingsCampaign.console_level_list
			end

			for _, level_id in pairs(LevelSettingsCampaign.level_list) do
				if 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", level_id) then
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

			if Application.platform() == "win32" then
				levels_with_tomes = LevelSettingsCampaign.levels_with_tomes
			else
				levels_with_tomes = LevelSettingsCampaign.console_levels_with_tomes
			end

			for _, level_id in pairs(levels_with_tomes) do
				local max_amount = LevelSettingsCampaign.tome_amount_exceptions[level_id] or 3
				local amount = statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", level_id)

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

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
				for idx, profile in pairs(SPProfiles) do
					if 0 >= statistics_db.get_persistent_stat(statistics_db, stats_id, "complete_level_" .. profile.display_name) then
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

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
				return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "complete_level_bright_wizard")
			end

			return false
		end
	},
	complete_a_mission_as_the_way_watcher = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
				return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "complete_level_wood_elf")
			end

			return false
		end
	},
	complete_a_mission_as_the_empire_soldier = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
				return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "complete_level_empire_soldier")
			end

			return false
		end
	},
	complete_a_mission_as_the_witch_hunter = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
				return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "complete_level_witch_hunter")
			end

			return false
		end
	},
	complete_a_mission_as_the_dwarf_ranger = {
		evaluate = function (statistics_db, stats_id)
			local backend_manager = Managers.backend

			if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
				return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "complete_level_dwarf_ranger")
			end

			return false
		end
	},
	roll_seven_successes = {
		evaluate = function (statistics_db, stats_id)
			return 8 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "dice_roll_successes")
		end
	},
	collect_both_grimoires_on_magnus = {
		evaluate = function (statistics_db, stats_id)
			return 2 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_grimoires", "magnus")
		end
	},
	collect_both_grimoires_on_merchant = {
		evaluate = function (statistics_db, stats_id)
			return 2 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_grimoires", "merchant")
		end
	},
	collect_both_grimoires_on_wizard = {
		evaluate = function (statistics_db, stats_id)
			return 2 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_grimoires", "wizard")
		end
	},
	collect_both_grimoires_on_forest_ambush = {
		evaluate = function (statistics_db, stats_id)
			return 2 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_grimoires", "forest_ambush")
		end
	},
	collect_both_grimoires_on_cemetery = {
		evaluate = function (statistics_db, stats_id)
			return 2 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_grimoires", "cemetery")
		end
	},
	collect_both_grimoires_on_tunnels = {
		evaluate = function (statistics_db, stats_id)
			return 2 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_grimoires", "tunnels")
		end
	},
	collect_all_tomes_on_magnus = {
		ID_XB1 = "ThePious",
		evaluate = function (statistics_db, stats_id)
			return 3 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", "magnus")
		end
	},
	collect_all_tomes_on_merchant = {
		ID_XB1 = "Marktplatz",
		evaluate = function (statistics_db, stats_id)
			return 3 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", "merchant")
		end
	},
	collect_all_tomes_on_wizard = {
		ID_XB1 = "WindsOfUlgu",
		evaluate = function (statistics_db, stats_id)
			return 3 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", "wizard")
		end
	},
	collect_all_tomes_on_forest_ambush = {
		ID_XB1 = "Reikwald",
		evaluate = function (statistics_db, stats_id)
			return 3 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", "forest_ambush")
		end
	},
	collect_all_tomes_on_cemetery = {
		ID_XB1 = "BlackGuard",
		evaluate = function (statistics_db, stats_id)
			return 3 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", "cemetery")
		end
	},
	collect_all_tomes_on_tunnels = {
		ID_XB1 = "Mandred",
		evaluate = function (statistics_db, stats_id)
			return 3 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", "tunnels")
		end
	},
	win_item_as_wood_elf = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db.get_stat(statistics_db, stats_id, "win_item_as_wood_elf") == 1
		end
	},
	win_item_as_witch_hunter = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db.get_stat(statistics_db, stats_id, "win_item_as_witch_hunter") == 1
		end
	},
	win_item_as_bright_wizard = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db.get_stat(statistics_db, stats_id, "win_item_as_bright_wizard") == 1
		end
	},
	win_item_as_dwarf_ranger = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db.get_stat(statistics_db, stats_id, "win_item_as_dwarf_ranger") == 1
		end
	},
	win_item_as_empire_soldier = {
		evaluate = function (statistics_db, stats_id)
			return statistics_db.get_stat(statistics_db, stats_id, "win_item_as_empire_soldier") == 1
		end
	},
	last_stand_town_meeting_bronze = {
		ID_XB1 = "Defient",
		ID_PS4 = "033",
		evaluate = function (statistics_db, stats_id)
			return SurvivalSettings.achievement_data.bronze <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_hard_waves")
		end
	},
	last_stand_town_meeting_silver = {
		ID_XB1 = "Stalwart",
		ID_PS4 = "034",
		evaluate = function (statistics_db, stats_id)
			local complete = SurvivalSettings.achievement_data.silver <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_hard_waves")
			complete = complete or SurvivalSettings.achievement_data.bronze <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_harder_waves")

			return complete
		end
	},
	last_stand_town_meeting_gold = {
		ID_XB1 = "Unbreakable",
		ID_PS4 = "035",
		evaluate = function (statistics_db, stats_id)
			local complete = SurvivalSettings.achievement_data.gold <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_hard_waves")
			complete = complete or SurvivalSettings.achievement_data.silver <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_harder_waves")
			complete = complete or SurvivalSettings.achievement_data.bronze <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_hardest_waves")

			return complete
		end
	},
	last_stand_the_fall_bronze = {
		evaluate = function (statistics_db, stats_id)
			return SurvivalSettings.achievement_data.bronze <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_hard_waves")
		end
	},
	last_stand_the_fall_silver = {
		evaluate = function (statistics_db, stats_id)
			local complete = SurvivalSettings.achievement_data.silver <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_hard_waves")
			complete = complete or SurvivalSettings.achievement_data.bronze <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_harder_waves")

			return complete
		end
	},
	last_stand_the_fall_gold = {
		evaluate = function (statistics_db, stats_id)
			local complete = SurvivalSettings.achievement_data.gold <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_hard_waves")
			complete = complete or SurvivalSettings.achievement_data.silver <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_harder_waves")
			complete = complete or SurvivalSettings.achievement_data.bronze <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_hardest_waves")

			return complete
		end
	},
	last_stand_wave_complete = {
		ID_XB1 = "OneDownEndlessToGo",
		ID_PS4 = "036",
		evaluate = function (statistics_db, stats_id)
			local complete = 1 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_hard_waves")
			complete = complete or 1 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_harder_waves")
			complete = complete or 1 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_ruins_survival_hardest_waves")
			complete = complete or 1 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_hard_waves")
			complete = complete or 1 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_harder_waves")
			complete = complete or 1 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "survival_dlc_survival_magnus_survival_hardest_waves")

			return complete
		end
	},
	last_stand_single_endurance_badge = {
		ID_XB1 = "FindersKeepers",
		ID_PS4 = "037",
		evaluate = function (statistics_db, stats_id)
			return 1 <= statistics_db.get_stat(statistics_db, stats_id, "endurance_badges")
		end
	},
	last_stand_multiple_endurance_badges = {
		ID_XB1 = "Tenacious",
		ID_PS4 = "038",
		evaluate = function (statistics_db, stats_id)
			return 200 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "endurance_badges")
		end
	},
	complete_drachenfels_portals = {
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_portals")
		end
	},
	complete_drachenfels_castle = {
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_castle")
		end
	},
	complete_drachenfels_castle_dungeon = {
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_castle_dungeon")
		end
	}
}

if Application.platform() == "win32" then
	AchievementTemplates.complete_dwarf_exterior = {
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_dwarf_exterior")
		end
	}
	AchievementTemplates.complete_dwarf_interior = {
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_dwarf_interior")
		end
	}
	AchievementTemplates.complete_dwarf_beacons = {
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_dwarf_beacons")
		end
	}

	local function add_level_complete_achievement(AchievementTemplates, level_name)
		AchievementTemplates["complete_" .. level_name] = {
			evaluate = function (statistics_db, stats_id)
				return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", level_name)
			end
		}

		return 
	end

	add_level_complete_achievement(AchievementTemplates, "dlc_stromdorf_hills")
	add_level_complete_achievement(AchievementTemplates, "dlc_stromdorf_town")

	AchievementTemplates.dodged_krench = {
		evaluate = function (statistics_db, stats_id)
			return 3 <= statistics_db.get_stat(statistics_db, stats_id, "dodged_storm_vermin_champion")
		end
	}
	AchievementTemplates.equipped_executioners_sword = {
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_stat(statistics_db, stats_id, "equipped_executioners_sword")
		end
	}
	AchievementTemplates.executor_headshots = {
		evaluate = function (statistics_db, stats_id)
			return 1 <= statistics_db.get_persistent_stat(statistics_db, stats_id, "executor_headshot")
		end
	}
end

if Application.platform() ~= "win32" then
	AchievementTemplates.rescue_bardin_goreksson_from_the_skaven = {
		ID_XB1 = "Wutelgi",
		ID_PS4 = "039",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_stat(statistics_db, stats_id, "tutorial_revive_ally")
		end
	}
	AchievementTemplates.complete_dwarf_exterior = {
		ID_XB1 = "ByValaya",
		ID_PS4 = "043",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_dwarf_exterior")
		end
	}
	AchievementTemplates.complete_dwarf_interior = {
		ID_XB1 = "SmashAndGrab",
		ID_PS4 = "044",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_dwarf_interior")
		end
	}
	AchievementTemplates.complete_dwarf_beacons = {
		ID_XB1 = "BeaconOfHope",
		ID_PS4 = "045",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", "dlc_dwarf_beacons")
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
			local active_missions, completed_missions = mission_system.get_missions(mission_system)

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
			local active_missions, completed_missions = mission_system.get_missions(mission_system)

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
			local active_missions, completed_missions = mission_system.get_missions(mission_system)

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
			return statistics_db.get_stat(statistics_db, stats_id, "fuse_time_when_socketed") < 2
		end
	}
	AchievementTemplates.kill_a_stormvermin_in_one_blow_using_bardins_pick = {
		ID_XB1 = "PickHisBrain",
		ID_PS4 = "050",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_stat(statistics_db, stats_id, "stormvermin_pick_instakills")
		end
	}
	AchievementTemplates.complete_your_first_contract = {
		ID_XB1 = "Mercenary",
		ID_PS4 = "040",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_stat(statistics_db, stats_id, "contracts_completed")
		end
	}
	AchievementTemplates.complete_your_first_quest = {
		ID_XB1 = "BountyHunter",
		ID_PS4 = "041",
		evaluate = function (statistics_db, stats_id)
			return 0 < statistics_db.get_stat(statistics_db, stats_id, "quests_completed")
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

			local local_player = player_manager.local_player(player_manager)

			if not local_player then
				return false
			end

			local boon_handler = local_player.boon_handler

			if not boon_handler then
				return false
			end

			return boon_handler.has_any_boon(boon_handler)
		end
	}
end

local function completed_levels(statistics_db, stats_id)
	local levels_completed = 0

	for _, level_id in ipairs(MainGameLevels) do
		levels_completed = levels_completed + statistics_db.get_stat(statistics_db, stats_id, "completed_levels", level_id)
	end

	for _, level_id in ipairs(NoneActLevels) do
		levels_completed = levels_completed + statistics_db.get_stat(statistics_db, stats_id, "completed_levels", level_id)
	end

	return levels_completed
end

local function collected_tomes(statistics_db, stats_id)
	local mission_system = Managers.state.entity:system("mission_system")
	local tome_mission_data = mission_system.get_level_end_mission_data(mission_system, "tome_bonus_mission")

	if not tome_mission_data then
		return 0
	end

	return tome_mission_data.current_amount
end

local function collected_grimoires(statistics_db, stats_id)
	local mission_system = Managers.state.entity:system("mission_system")
	local grimoire_mission_data = mission_system.get_level_end_mission_data(mission_system, "grimoire_hidden_mission")

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
			return statistics_db.get_stat(statistics_db, stats_id, "kills_total")
		end
	},
	rat_ogres_killed = {
		persistent = false,
		stat_name = "HeroOgresKilled",
		evaluate = function (statistics_db, stats_id)
			return statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_rat_ogre")
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
end

AchievementTemplates = templates

return 
