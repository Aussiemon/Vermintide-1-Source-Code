local Unit_alive = Unit.alive
local Unit_get_data = Unit.get_data
StatisticsUtil = {}
local StatisticsUtil = StatisticsUtil
StatisticsUtil.register_player_death = function (victim_unit, statistics_db)
	statistics_db.increment_stat(statistics_db, "session", "deaths")

	return 
end
StatisticsUtil.register_kill = function (victim_unit, damage_data, statistics_db, is_server)
	local attacker_unit = AiUtils.get_actual_attacker_unit(damage_data[DamageDataIndex.ATTACKER])
	local damaging_unit = damage_data[DamageDataIndex.DAMAGING_UNIT]
	local player_manager = Managers.player
	local attacker_player = player_manager.owner(player_manager, attacker_unit)

	if damaging_unit and damaging_unit ~= "n/a" and ScriptUnit.has_extension(damaging_unit, "projectile_system") then
		local projectile_ext = ScriptUnit.extension(damaging_unit, "projectile_system")

		if projectile_ext.add_kill then
			projectile_ext.add_kill(projectile_ext)
		end
	end

	local grenade_kill = false

	if attacker_player then
		local stats_id = attacker_player.stats_id(attacker_player)

		statistics_db.increment_stat(statistics_db, stats_id, "kills_total")

		local breed = Unit_get_data(victim_unit, "breed")

		if breed ~= nil then
			local breed_name = breed.name
			local print_message = breed.awards_positive_reinforcement_message

			if print_message then
				local predicate = "killed_special"
				local local_human = not attacker_player.remote and not attacker_player.bot_player

				Managers.state.event:trigger("add_coop_feedback_kill", attacker_player.stats_id(attacker_player) .. breed_name, local_human, predicate, attacker_player.name(attacker_player), breed_name)
			end

			statistics_db.increment_stat(statistics_db, stats_id, "kills_per_breed", breed_name)

			local damage_source = damage_data[DamageDataIndex.DAMAGE_SOURCE_NAME]
			local hit_zone = damage_data[DamageDataIndex.HIT_ZONE]

			if hit_zone == "head" or hit_zone == "neck" then
				statistics_db.increment_stat(statistics_db, stats_id, "headshots")

				local item = rawget(ItemMasterList, damage_source)

				if item then
					local weapon_template = Weapons[item.template]
					local stat = weapon_template and weapon_template.increment_stat_on_headshot_kill

					if stat then
						statistics_db.increment_stat(statistics_db, stats_id, stat)
					end
				end
			end

			local master_list_item = rawget(ItemMasterList, damage_source)

			if master_list_item then
				local slot_type = master_list_item.slot_type

				if slot_type == "melee" then
					statistics_db.increment_stat(statistics_db, stats_id, "kills_melee")
				elseif slot_type == "ranged" then
					statistics_db.increment_stat(statistics_db, stats_id, "kills_ranged")
				elseif slot_type == "grenade" then
					statistics_db.increment_stat(statistics_db, stats_id, "kills_grenade")

					grenade_kill = true
				end
			end
		end
	elseif statistics_db.is_registered(statistics_db, attacker_unit) then
		statistics_db.increment_stat(statistics_db, attacker_unit, "kills_total")
	end

	local human_and_bot_players = player_manager.human_and_bot_players(player_manager)

	for _, player in pairs(human_and_bot_players) do
		if player ~= attacker_player then
			local stats_id = player.stats_id(player)
			local breed = Unit_get_data(victim_unit, "breed")

			if breed ~= nil then
				local breed_name = breed.name

				statistics_db.increment_stat(statistics_db, stats_id, "kill_assists_per_breed", breed_name)

				if grenade_kill then
					statistics_db.increment_stat(statistics_db, stats_id, "kill_assists_grenade")
				end
			end
		end
	end

	return 
end
StatisticsUtil.check_save = function (savior_unit, enemy_unit)
	local blackboard = Unit_get_data(enemy_unit, "blackboard")
	local saved_unit = blackboard.target_unit
	local savior_player = savior_unit and Managers.player:owner(savior_unit)
	local saved_player = saved_unit and Managers.player:owner(saved_unit)

	if savior_player and saved_player and savior_player ~= saved_player then
		local saved_unit_dir = nil
		local network_manager = Managers.state.network
		local game = network_manager.game(network_manager)
		local game_object_id = game and network_manager.unit_game_object_id(network_manager, saved_unit)

		if game_object_id then
			saved_unit_dir = Vector3.normalize(Vector3.flat(GameSession.game_object_field(game, game_object_id, "aim_direction")))
		else
			saved_unit_dir = Quaternion.forward(Unit.local_rotation(saved_unit, 0))
		end

		local enemy_unit_dir = Quaternion.forward(Unit.local_rotation(enemy_unit, 0))
		local saved_unit_pos = POSITION_LOOKUP[saved_unit]
		local enemy_unit_pos = POSITION_LOOKUP[enemy_unit]
		local attack_dir = saved_unit_pos - enemy_unit_pos
		local is_behind = Vector3.distance(saved_unit_pos, enemy_unit_pos) < 3 and 0 < Vector3.dot(attack_dir, saved_unit_dir) and 0 < Vector3.dot(attack_dir, enemy_unit_dir)
		local status_ext = ScriptUnit.extension(saved_unit, "status_system")
		local grabber_unit = status_ext.get_pouncer_unit(status_ext) or status_ext.get_pack_master_grabber(status_ext)
		local is_disabled = status_ext.is_disabled(status_ext)
		local predicate = nil
		local statistics_db = Managers.player:statistics_db()
		local savior_player_stats_id = savior_player.stats_id(savior_player)

		if enemy_unit == grabber_unit then
			predicate = "save"

			statistics_db.increment_stat(statistics_db, savior_player_stats_id, "saves")
		elseif is_behind or is_disabled then
			predicate = "aid"

			statistics_db.increment_stat(statistics_db, savior_player_stats_id, "aidings")

			if not savior_player.remote then
				BuffUtils.trigger_assist_buffs(savior_player, saved_player)
			end
		end

		if predicate then
			local local_human = not savior_player.remote and not savior_player.bot_player

			Managers.state.event:trigger("add_coop_feedback", savior_player_stats_id .. saved_player.stats_id(saved_player), local_human, predicate, savior_player, saved_player)
			Managers.state.network.network_transmit:send_rpc_clients("rpc_coop_feedback", savior_player.network_id(savior_player), savior_player.local_player_id(savior_player), NetworkLookup.coop_feedback[predicate], saved_player.network_id(saved_player), saved_player.local_player_id(saved_player))
		end
	end

	return 
end
StatisticsUtil.register_pull_up = function (puller_up_unit, pulled_up_unit, statistics_db)
	local player_manager = Managers.player
	local player1 = player_manager.owner(player_manager, puller_up_unit)
	local player2 = player_manager.owner(player_manager, pulled_up_unit)

	if player1 and player2 then
		local predicate = "assisted_respawn"
		local local_human = not player1.remote and not player1.bot_player

		Managers.state.event:trigger("add_coop_feedback", player1.stats_id(player1) .. player2.stats_id(player2), local_human, predicate, player1, player2)
	end

	return 
end
StatisticsUtil.register_assisted_respawn = function (reviver_unit, revivee_unit, statistics_db)
	local player_manager = Managers.player
	local player1 = player_manager.owner(player_manager, reviver_unit)
	local player2 = player_manager.owner(player_manager, revivee_unit)

	if player1 and player2 then
		local predicate = "assisted_respawn"
		local local_human = not player1.remote and not player1.bot_player

		Managers.state.event:trigger("add_coop_feedback", player1.stats_id(player1) .. player2.stats_id(player2), local_human, predicate, player1, player2)
	end

	return 
end
StatisticsUtil.register_revive = function (reviver_unit, revivee_unit, statistics_db)
	local player_manager = Managers.player
	local player1 = player_manager.owner(player_manager, reviver_unit)

	if player1 then
		local stats_id = player1.stats_id(player1)

		statistics_db.increment_stat(statistics_db, stats_id, "revives")
	end

	local player2 = player_manager.owner(player_manager, revivee_unit)

	if player2 then
		local stats_id = player2.stats_id(player2)

		statistics_db.increment_stat(statistics_db, stats_id, "times_revived")
	end

	if player1 and player2 then
		local predicate = "revive"
		local local_human = not player1.remote and not player1.bot_player

		Managers.state.event:trigger("add_coop_feedback", player1.stats_id(player1) .. player2.stats_id(player2), local_human, predicate, player1, player2)
	end

	return 
end
StatisticsUtil.register_heal = function (healer_unit, healed_unit, statistics_db)
	local player_manager = Managers.player
	local player1 = player_manager.owner(player_manager, healer_unit)
	local player2 = player_manager.owner(player_manager, healed_unit)

	if player1 and player2 and player1 ~= player2 then
		local predicate = "heal"
		local local_human = not player1.remote and not player1.bot_player

		Managers.state.event:trigger("add_coop_feedback", player1.stats_id(player1) .. player2.stats_id(player2), local_human, predicate, player1, player2)

		local stats_id = player1.stats_id(player1)

		statistics_db.increment_stat(statistics_db, stats_id, "times_friend_healed")
	end

	return 
end
StatisticsUtil.register_damage = function (victim_unit, damage_data, statistics_db)
	local damage_amount = damage_data[DamageDataIndex.DAMAGE_AMOUNT]
	local player_manager = Managers.player
	local player = player_manager.owner(player_manager, victim_unit)

	if player then
		local stats_id = player.stats_id(player)

		statistics_db.modify_stat_by_amount(statistics_db, stats_id, "damage_taken", damage_amount)

		local damage_source = damage_data[DamageDataIndex.DAMAGE_SOURCE_NAME]

		if Breeds[damage_source] then
			statistics_db.modify_stat_by_amount(statistics_db, stats_id, "damage_taken_per_breed", damage_source, damage_amount)
			statistics_db.modify_stat_by_amount(statistics_db, "session", "damage_taken_per_breed", damage_source, damage_amount)
		end
	end

	local attacker_unit = damage_data[DamageDataIndex.ATTACKER]
	attacker_unit = AiUtils.get_actual_attacker_unit(attacker_unit)
	player = player_manager.owner(player_manager, attacker_unit)

	if player then
		local breed = Unit_alive(victim_unit) and Unit_get_data(victim_unit, "breed")

		if breed then
			local breed_name = breed.name
			local health_extension = ScriptUnit.extension(victim_unit, "health_system")
			local current_health = health_extension.current_health(health_extension)

			if 0 < current_health then
				local stats_id = player.stats_id(player)
				damage_amount = math.clamp(damage_amount, 0, current_health)

				statistics_db.modify_stat_by_amount(statistics_db, stats_id, "damage_dealt", damage_amount)
				statistics_db.modify_stat_by_amount(statistics_db, stats_id, "damage_dealt_per_breed", breed_name, damage_amount)
			end
		end
	end

	return 
end
StatisticsUtil.register_instakill = function (victim_unit, damage_datas, index)
	local breed = Unit.get_data(victim_unit, "breed")

	if breed and breed.name == "skaven_storm_vermin" then
		local attacker_unit_index = (index - 1)*DamageDataIndex.STRIDE + DamageDataIndex.ATTACKER
		local attacker_unit = damage_datas[attacker_unit_index]

		if Unit.alive(attacker_unit) then
			local player_manager = Managers.player
			local owner = player_manager.owner(player_manager, attacker_unit)
			local local_player = player_manager.local_player(player_manager)

			if owner == local_player then
				local damage_source_name_index = (index - 1)*DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_SOURCE_NAME
				local damage_source_name = damage_datas[damage_source_name_index]
				local item = rawget(ItemMasterList, damage_source_name)

				if item then
					local item_type = item.item_type

					if item_type == "dr_2h_picks" then
						local statistics_db = player_manager.statistics_db(player_manager)
						local stats_id = local_player.stats_id(local_player)

						statistics_db.increment_stat(statistics_db, stats_id, "stormvermin_pick_instakills")
					end
				end
			end
		end
	end

	return 
end
StatisticsUtil.won_games = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)
	local completed = 0

	for _, level_name in ipairs(UnlockableLevels) do
		completed = completed + statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", level_name)
	end

	return completed
end
StatisticsUtil.register_collected_grimoires = function (collected_grimoires, statistics_db)
	local level_settings = LevelHelper:current_level_settings()
	local level_id = level_settings.level_id

	if not table.find(UnlockableLevels, level_id) then
		return 
	end

	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)
	local current_collected_grimoires = statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_grimoires", level_id)

	if current_collected_grimoires < collected_grimoires then
		statistics_db.set_stat(statistics_db, stats_id, "collected_grimoires", level_id, collected_grimoires)
	end

	return 
end
StatisticsUtil.register_collected_tomes = function (collected_tomes, statistics_db)
	local level_settings = LevelHelper:current_level_settings()
	local level_id = level_settings.level_id

	if not table.find(UnlockableLevels, level_id) then
		return 
	end

	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)
	local current_collected_tomes = statistics_db.get_persistent_stat(statistics_db, stats_id, "collected_tomes", level_id)

	if current_collected_tomes < collected_tomes then
		statistics_db.set_stat(statistics_db, stats_id, "collected_tomes", level_id, collected_tomes)
	end

	return 
end
StatisticsUtil.register_complete_level = function (statistics_db)
	local level_settings = LevelHelper:current_level_settings()
	local level_id = level_settings.level_id

	if not table.find(UnlockableLevels, level_id) then
		return 
	end

	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)
	local profile_index = local_player.profile_index
	local profile = SPProfiles[profile_index]

	statistics_db.increment_stat(statistics_db, stats_id, "complete_level_" .. profile.display_name)

	local mission_system = Managers.state.entity:system("mission_system")
	local grimoire_mission_data = mission_system.get_level_end_mission_data(mission_system, "grimoire_hidden_mission")
	local tome_mission_data = mission_system.get_level_end_mission_data(mission_system, "tome_bonus_mission")

	if grimoire_mission_data then
		StatisticsUtil.register_collected_grimoires(grimoire_mission_data.current_amount, statistics_db)
	end

	if tome_mission_data then
		StatisticsUtil.register_collected_tomes(tome_mission_data.current_amount, statistics_db)
	end

	statistics_db.increment_stat(statistics_db, stats_id, "completed_levels", level_id)

	local difficulty_manager = Managers.state.difficulty
	local difficulty_name = difficulty_manager.get_difficulty(difficulty_manager)

	StatisticsUtil._register_completed_level_difficulty(statistics_db, level_id, difficulty_name)

	return 
end
StatisticsUtil.get_game_progress = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)
	local max_value = #MainGameLevels*5
	local current_value = 0
	local level_difficulty_name, level_completed_difficulty = nil

	for _, level_id in pairs(MainGameLevels) do
		level_difficulty_name = LevelDifficultyDBNames[level_id]
		level_completed_difficulty = statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels_difficulty", level_difficulty_name)

		print("Completed Level Difficulty", level_difficulty_name, level_completed_difficulty, level_id)

		current_value = current_value + level_completed_difficulty
	end

	local game_progress = current_value/max_value*100

	return game_progress
end
StatisticsUtil._register_completed_level_difficulty = function (statistics_db, level_id, difficulty_name)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)
	local level_difficulty_name = LevelDifficultyDBNames[level_id]
	local current_completed_difficulty = statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels_difficulty", level_difficulty_name)
	local difficulty_manager = Managers.state.difficulty
	local difficulties = difficulty_manager.get_level_difficulties(difficulty_manager, level_id)
	local difficulty = table.find(difficulties, difficulty_name)

	if current_completed_difficulty < difficulty then
		statistics_db.set_stat(statistics_db, stats_id, "completed_levels_difficulty", level_difficulty_name, difficulty)
	end

	return 
end
StatisticsUtil.register_unlocked_lorebook_pages = function (statistics_db)
	local mission_system = Managers.state.entity:system("mission_system")
	local active_missions, completed_missions = mission_system.get_missions(mission_system)
	local mission_data = active_missions.lorebook_page_hidden_mission

	if not mission_data then
		return 
	end

	local player = Managers.player:local_player()

	if not player then
		return 
	end

	local stats_id = player.stats_id(player)
	local unique_ids = mission_data.get_unique_ids(mission_data)

	for page_id, _ in pairs(unique_ids) do
		statistics_db.set_array_stat(statistics_db, stats_id, "lorebook_unlocks", page_id, true)

		local category_name = LorebookCategoryNames[tonumber(page_id)]

		LoreBookHelper.mark_page_id_as_new(category_name)
	end

	LoreBookHelper.save_new_pages()

	return 
end

local function survival_stat_name(level_id, difficulty, stat_suffix)
	assert(stat_suffix == "waves" or stat_suffix == "time" or stat_suffix == "kills")

	local stat_name = string.format("survival_%s_%s_%s", level_id, difficulty, stat_suffix)

	return stat_name
end

StatisticsUtil.get_survival_stat = function (statistics_db, level_id, difficulty, stat_name, stats_id)
	local stat = survival_stat_name(level_id, difficulty, stat_name)
	local player_manager = Managers.player
	local local_player = player_manager.local_player(player_manager)
	stats_id = stats_id or local_player.stats_id(local_player)
	local value = statistics_db.get_persistent_stat(statistics_db, stats_id, stat)

	return value
end
StatisticsUtil._set_survival_stat = function (statistics_db, level_id, difficulty, stat_name, value)
	local stat = survival_stat_name(level_id, difficulty, stat_name)
	local player_manager = Managers.player
	local local_player = player_manager.local_player(player_manager)
	local stats_id = local_player.stats_id(local_player)

	statistics_db.set_stat(statistics_db, stats_id, stat, value)

	return 
end
StatisticsUtil._modify_survival_stat = function (statistics_db, level_id, difficulty, stat_name, value)
	local stat = survival_stat_name(level_id, difficulty, stat_name)
	local player_manager = Managers.player
	local local_player = player_manager.local_player(player_manager)
	local stats_id = local_player.stats_id(local_player)

	statistics_db.modify_stat_by_amount(statistics_db, stats_id, stat, value)

	return 
end
StatisticsUtil.register_online_leaderboards_data = function (statistics_db, score)
	local mission_system = Managers.state.entity:system("mission_system")
	local active_missions, completed_missions = mission_system.get_missions(mission_system)
	local mission_data = active_missions.survival_wave

	if not mission_data then
		return 
	end

	local player_manager = Managers.player
	local local_player = player_manager.local_player(player_manager)
	local profile_index = local_player.profile_index
	local stats_id = local_player.stats_id(local_player)
	local level_key = Managers.state.game_mode:level_key()
	local waves = mission_data.wave_completed
	local wave_times = mission_data.wave_times
	local wave_completed_time = mission_data.wave_completed_time - mission_data.start_time
	local leaderboard_name = level_key .. "_" .. SPProfiles[profile_index].display_name
	local overall_leaderboard_name = level_key .. "_overall"
	local skaven_slave = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_slave")
	local skaven_clan_rat = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_clan_rat")
	local skaven_storm_vermin = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_storm_vermin")
	local skaven_storm_vermin_commander = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_storm_vermin_commander")
	local skaven_gutter_runner = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_gutter_runner")
	local skaven_pack_master = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_pack_master")
	local skaven_poison_wind_globadier = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_poison_wind_globadier")
	local skaven_ratling_gunner = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_ratling_gunner")
	local skaven_rat_ogre = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_rat_ogre")
	local skaven_storm_vermins = skaven_storm_vermin + skaven_storm_vermin_commander
	local skaven_specials = skaven_pack_master + skaven_poison_wind_globadier + skaven_gutter_runner + skaven_ratling_gunner
	local total_score = score

	if Managers.state.network.is_server then
		print("###################################")
		print("##### REGISTERING LEADERBOARD #####")
		print("###################################")

		local BASE_SCORE = 1000
		local MAX_TIME_IN_SEC = 1000
		total_score = 0
		local total_time = mission_data.start_time

		print("Start time: " .. mission_data.start_time)

		for wave = 1, waves, 1 do
			local time_in_sec = wave_times[wave] - total_time
			total_time = total_time + time_in_sec
			local time_score = math.max(BASE_SCORE*math.max(MAX_TIME_IN_SEC - time_in_sec, 0)/MAX_TIME_IN_SEC, 1)
			local wave_score = math.floor(wave*BASE_SCORE + time_score)
			total_score = total_score + wave_score

			print("Wave: " .. wave .. " time: " .. time_in_sec .. " Score: " .. wave_score)
		end

		print("-----------------------------------")
		print("Total score: " .. total_score .. " Waves: " .. waves)
		print("Calculated Total time: " .. total_time)
		print("Mission Total time: " .. wave_completed_time)
		print("")
		print("###################################")
		Managers.state.network.network_transmit:send_rpc_clients("rpc_register_online_leaderboards", total_score)
	end

	local score_data = {
		waves,
		skaven_slave,
		skaven_clan_rat,
		skaven_storm_vermins,
		skaven_specials,
		skaven_rat_ogre,
		math.floor(wave_completed_time + 0.5)
	}
	local platform = Application.platform()

	if platform == "win32" then
		Managers.leaderboards:register_score(leaderboard_name, total_score, score_data)
	elseif platform == "xb1" then
		local xdp_leaderboard_stat_name = LeaderboardSettings.xdp_leaderboard_stats[leaderboard_name]

		if xdp_leaderboard_stat_name then
			Managers.account:set_leaderboard(xdp_leaderboard_stat_name, total_score, score_data)
		else
			Application.error(string.format("[StatisticsUtil] No leaderboard specified for %s", leaderboard_name))
		end
	elseif platform == "ps4" then
	end

	local old_score = statistics_db.get_stat(statistics_db, stats_id, leaderboard_name)

	if old_score < total_score then
		statistics_db.set_stat(statistics_db, stats_id, leaderboard_name, total_score)
	end

	return 
end
StatisticsUtil.register_complete_survival_level = function (statistics_db)
	local mission_system = Managers.state.entity:system("mission_system")
	local active_missions, completed_missions = mission_system.get_missions(mission_system)
	local mission_data = active_missions.survival_wave

	if not mission_data then
		return 
	end

	local player_manager = Managers.player
	local local_player = player_manager.local_player(player_manager)
	local stats_id = local_player.stats_id(local_player)
	local level_settings = LevelHelper:current_level_settings()
	local level_id = level_settings.level_id
	local start_wave = mission_data.starting_wave
	local start_difficulty = SurvivalDifficultyByStartWave[start_wave]
	local kills = statistics_db.get_stat(statistics_db, stats_id, "kills_total")

	StatisticsUtil._modify_survival_stat(statistics_db, level_id, start_difficulty, "kills", kills)
	StatisticsUtil._register_endurance_badges(statistics_db)

	local wave_completed = mission_data.wave_completed

	if wave_completed ~= 0 then
		local completed_waves = wave_completed - start_wave
		local current_completed_waves = StatisticsUtil.get_survival_stat(statistics_db, level_id, start_difficulty, "waves")

		if current_completed_waves < completed_waves then
			StatisticsUtil._set_survival_stat(statistics_db, level_id, start_difficulty, "waves", completed_waves)
		end

		local completed_time = mission_data.wave_completed_time - mission_data.start_time
		local current_completed_time = StatisticsUtil.get_survival_stat(statistics_db, level_id, start_difficulty, "time")

		if current_completed_waves < completed_waves or (completed_waves == current_completed_waves and completed_time < current_completed_time) then
			StatisticsUtil._set_survival_stat(statistics_db, level_id, start_difficulty, "time", completed_time)
		end

		local completed_difficulty = nil
		local difficulty_manager = Managers.state.difficulty
		local level_difficulties = difficulty_manager.get_level_difficulties(difficulty_manager, level_id)
		local start_difficulty_index = table.find(level_difficulties, start_difficulty)
		local level_difficulty_name = LevelDifficultyDBNames[level_id]
		local current_completed_difficulty_index = statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels_difficulty", level_difficulty_name)
		local started_on_unlocked_difficulty = start_difficulty_index - 1 <= current_completed_difficulty_index

		if started_on_unlocked_difficulty then
			local difficulty = difficulty_manager.get_difficulty(difficulty_manager)
			local difficulty_index = table.find(level_difficulties, difficulty)
			local completed_difficulty_index = (difficulty_index == #level_difficulties and (difficulty_index - start_difficulty_index + 1)*13 <= completed_waves and difficulty_index) or difficulty_index - 1

			if 0 < completed_difficulty_index then
				completed_difficulty = level_difficulties[completed_difficulty_index]
			end

			if completed_difficulty_index and completed_difficulty_index < 3 and 13 <= completed_waves then
				ScriptApplication.send_to_crashify("StatisticsUtil", "Error in survival mode data. completed_difficulty_index = %s, completed_waves = %s, started_on_unlocked_difficulty = true", completed_difficulty_index, completed_waves)
			end
		else
			local completed_difficulty_index = nil

			for i = #level_difficulties, 1, -1 do
				local difficulty = level_difficulties[i]
				local difficulty_end_wave = SurvivalEndWaveByDifficulty[difficulty]

				if difficulty_end_wave <= wave_completed then
					completed_difficulty_index = i
					completed_difficulty = difficulty

					break
				end
			end

			if completed_difficulty_index and completed_difficulty_index < 3 and 13 <= completed_waves then
				ScriptApplication.send_to_crashify("StatisticsUtil", "Error in survival mode data. completed_difficulty_index = %s, completed_waves = %s, started_on_unlocked_difficulty = false", completed_difficulty_index, completed_waves)
			end
		end

		if completed_difficulty then
			StatisticsUtil._register_completed_level_difficulty(statistics_db, level_id, completed_difficulty)
		end
	end

	return 
end
StatisticsUtil._register_endurance_badges = function (statistics_db)
	local mission_templates = {
		"endurance_badge_01_mission",
		"endurance_badge_02_mission",
		"endurance_badge_03_mission",
		"endurance_badge_04_mission",
		"endurance_badge_05_mission"
	}
	local mission_system = Managers.state.entity:system("mission_system")
	local num_collected_badges = 0

	for _, template in ipairs(mission_templates) do
		local mission_data = mission_system.get_level_end_mission_data(mission_system, template)

		if mission_data then
			num_collected_badges = num_collected_badges + mission_data.get_current_amount(mission_data)
		end
	end

	if 0 < num_collected_badges then
		local local_player = Managers.player:local_player()
		local stats_id = local_player.stats_id(local_player)

		statistics_db.modify_stat_by_amount(statistics_db, stats_id, "endurance_badges", num_collected_badges)
	end

	return 
end
StatisticsUtil.register_matchmaking_country_code = function (statistics_db)
	local account_manager = Managers.account
	local country_code = account_manager.region(account_manager) or "N/A"
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.set_stat(statistics_db, stats_id, "matchmaking_country_code", country_code)

	return 
end
StatisticsUtil.register_matchmaking_unix_timestamp = function (statistics_db)
	local timestamp = os.time()
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.set_stat(statistics_db, stats_id, "matchmaking_unix_timestamp", timestamp)

	return 
end
StatisticsUtil.register_matchmaking_region_fetch_status = function (statistics_db)
	local account_manager = Managers.account
	local region_fetch_status = account_manager.region_fetch_status(account_manager)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.set_stat(statistics_db, stats_id, "matchmaking_region_fetch_status", region_fetch_status)

	return 
end
StatisticsUtil.register_matchmaking_primary_region = function (statistics_db)
	local account_manager = Managers.account
	local user_region = account_manager.region(account_manager) or "N/A"
	local search_region_level = "primary"
	local search_region = MatchmakingRegionLookup[search_region_level][user_region] or "N/A"
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.set_stat(statistics_db, stats_id, "matchmaking_primary_region", search_region)

	return 
end
StatisticsUtil.register_matchmaking_secondary_region = function (statistics_db)
	local account_manager = Managers.account
	local user_region = account_manager.region(account_manager) or "N/A"
	local search_region_level = "secondary"
	local search_region = MatchmakingRegionLookup[search_region_level][user_region] or "N/A"
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.set_stat(statistics_db, stats_id, "matchmaking_secondary_region", search_region)

	return 
end
StatisticsUtil.register_matchmaking_search = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_num_searches")

	return 
end
StatisticsUtil.register_matchmaking_aborted_sub_15s = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_aborted_sub_15s")

	return 
end
StatisticsUtil.register_matchmaking_aborted_above_15s = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_aborted_above_15s")

	return 
end
StatisticsUtil.register_matchmaking_aborted_above_15s_total_time = function (statistics_db, time_taken)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.modify_stat_by_amount(statistics_db, stats_id, "matchmaking_aborted_above_15s_total_time", time_taken)

	return 
end
StatisticsUtil.register_matchmaking_game_joined = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_game_joined")

	return 
end
StatisticsUtil.register_matchmaking_game_joined_primary_region = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_game_joined_primary_region")

	return 
end
StatisticsUtil.register_matchmaking_game_joined_secondary_region = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_game_joined_secondary_region")

	return 
end
StatisticsUtil.register_matchmaking_game_joined_total_search_time = function (statistics_db, time_taken)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.modify_stat_by_amount(statistics_db, stats_id, "matchmaking_game_joined_total_search_time", time_taken)

	return 
end
StatisticsUtil.register_matchmaking_game_started = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_game_started")

	return 
end
StatisticsUtil.register_matchmaking_game_started_total_time = function (statistics_db, time_taken)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.modify_stat_by_amount(statistics_db, stats_id, "matchmaking_game_started_total_time", time_taken)

	return 
end
StatisticsUtil.register_matchmaking_game_started_player_amount = function (statistics_db, nr_players)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.modify_stat_by_amount(statistics_db, stats_id, "matchmaking_game_started_player_amount", nr_players)

	return 
end
StatisticsUtil.register_matchmaking_game_started_full_team = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_game_started_full_team")

	return 
end
StatisticsUtil.register_matchmaking_first_client_joined = function (statistics_db)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.increment_stat(statistics_db, stats_id, "matchmaking_first_client_joined")

	return 
end
StatisticsUtil.register_matchmaking_first_client_joined_total_time = function (statistics_db, time_taken)
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)

	statistics_db.modify_stat_by_amount(statistics_db, stats_id, "matchmaking_first_client_joined_total_time", time_taken)

	return 
end

return 
