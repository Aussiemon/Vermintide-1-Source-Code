StatisticsUtil = {
	register_kill = function (victim_unit, damage_data, statistics_db, is_server)
		local attacker_unit = damage_data[DamageDataIndex.ATTACKER]
		local damaging_unit = damage_data[DamageDataIndex.DAMAGING_UNIT]
		attacker_unit = AiUtils.get_actual_attacker_unit(attacker_unit)
		local player_manager = Managers.player
		local player = player_manager.owner(player_manager, attacker_unit)

		if damaging_unit and damaging_unit ~= "n/a" and ScriptUnit.has_extension(damaging_unit, "projectile_system") then
			local projectile_ext = ScriptUnit.extension(damaging_unit, "projectile_system")

			if projectile_ext.add_kill then
				projectile_ext.add_kill(projectile_ext)
			end
		end

		if player then
			local stats_id = player.stats_id(player)

			statistics_db.increment_stat(statistics_db, stats_id, "kills_total")

			local breed = Unit.get_data(victim_unit, "breed")

			if breed ~= nil then
				local breed_name = breed.name
				local print_message = breed.awards_positive_reinforcement_message

				if print_message then
					local predicate = "killed_special"
					local local_human = not player.remote and not player.bot_player

					Managers.state.event:trigger("add_coop_feedback_kill", player.stats_id(player) .. breed_name, local_human, predicate, player.name(player), breed_name)
				end

				statistics_db.increment_stat(statistics_db, stats_id, "kills_per_breed", breed_name)

				local hit_zone = damage_data[DamageDataIndex.HIT_ZONE]

				if hit_zone == "head" then
					statistics_db.increment_stat(statistics_db, stats_id, "headshots")
				end

				local inventory_extension = ScriptUnit.extension(attacker_unit, "inventory_system")
				local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)

				if slot_name == "slot_melee" then
					statistics_db.increment_stat(statistics_db, stats_id, "kills_melee")
				elseif slot_name == "slot_ranged" then
					statistics_db.increment_stat(statistics_db, stats_id, "kills_ranged")
				end
			end
		elseif statistics_db.is_registered(statistics_db, attacker_unit) then
			statistics_db.increment_stat(statistics_db, attacker_unit, "kills_total")
		end

		return 
	end,
	check_save = function (savior_unit, enemy_unit)
		local blackboard = Unit.get_data(enemy_unit, "blackboard")
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

			if enemy_unit == grabber_unit then
				predicate = "save"
			elseif is_behind or is_disabled then
				predicate = "aid"

				if not savior_player.remote then
					BuffUtils.trigger_assist_buffs(savior_player, saved_player)
				end
			end

			if predicate then
				local local_human = not savior_player.remote and not savior_player.bot_player

				Managers.state.event:trigger("add_coop_feedback", savior_player.stats_id(savior_player) .. saved_player.stats_id(saved_player), local_human, predicate, savior_player, saved_player)
				Managers.state.network.network_transmit:send_rpc_clients("rpc_coop_feedback", savior_player.network_id(savior_player), savior_player.local_player_id(savior_player), NetworkLookup.coop_feedback[predicate], saved_player.network_id(saved_player), saved_player.local_player_id(saved_player))
			end
		end

		return 
	end,
	register_pull_up = function (puller_up_unit, pulled_up_unit, statistics_db)
		local player_manager = Managers.player
		local player1 = player_manager.owner(player_manager, puller_up_unit)
		local player2 = player_manager.owner(player_manager, pulled_up_unit)

		if player1 and player2 then
			local predicate = "assisted_respawn"
			local local_human = not player1.remote and not player1.bot_player

			Managers.state.event:trigger("add_coop_feedback", player1.stats_id(player1) .. player2.stats_id(player2), local_human, predicate, player1, player2)
		end

		return 
	end,
	register_assisted_respawn = function (reviver_unit, revivee_unit, statistics_db)
		local player_manager = Managers.player
		local player1 = player_manager.owner(player_manager, reviver_unit)
		local player2 = player_manager.owner(player_manager, revivee_unit)

		if player1 and player2 then
			local predicate = "assisted_respawn"
			local local_human = not player1.remote and not player1.bot_player

			Managers.state.event:trigger("add_coop_feedback", player1.stats_id(player1) .. player2.stats_id(player2), local_human, predicate, player1, player2)
		end

		return 
	end,
	register_revive = function (reviver_unit, revivee_unit, statistics_db)
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
	end,
	register_heal = function (healer_unit, healed_unit, statistics_db)
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
	end,
	register_damage = function (victim_unit, damage_data, statistics_db)
		local damage_amout = damage_data[DamageDataIndex.DAMAGE_AMOUNT]
		local player_manager = Managers.player
		local player = player_manager.owner(player_manager, victim_unit)

		if player then
			local stats_id = player.stats_id(player)

			statistics_db.modify_stat_by_amount(statistics_db, stats_id, "damage_taken", damage_amout)
		end

		local attacker_unit = damage_data[DamageDataIndex.ATTACKER]
		attacker_unit = AiUtils.get_actual_attacker_unit(attacker_unit)
		player = player_manager.owner(player_manager, attacker_unit)

		if player then
			local stats_id = player.stats_id(player)

			statistics_db.modify_stat_by_amount(statistics_db, stats_id, "damage_dealt", damage_amout)
		end

		return 
	end,
	won_games = function (statistics_db)
		local local_player = Managers.player:local_player()
		local stats_id = local_player.stats_id(local_player)
		local completed = 0

		for _, level_name in ipairs(UnlockableLevels) do
			completed = completed + statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", level_name)
		end

		return completed
	end,
	register_collected_grimoires = function (collected_grimoires, statistics_db)
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
	end,
	register_collected_tomes = function (collected_tomes, statistics_db)
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
}
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
StatisticsUtil.unlock_lorebook_page = function (page_id, statistics_db)
	local player = Managers.player:local_player()

	if player then
		local stats_id = player.stats_id(player)

		print("unlock_lorebook_page", page_id)
		statistics_db.set_array_stat(statistics_db, stats_id, "lorebook_unlocks", page_id, true)

		local category_name = LorebookCategoryNames[page_id]

		LoreBookHelper.mark_page_id_as_new(category_name)
	end

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
		else
			for i = #level_difficulties, 1, -1 do
				local difficulty = level_difficulties[i]
				local difficulty_end_wave = SurvivalEndWaveByDifficulty[difficulty]

				if difficulty_end_wave <= wave_completed then
					completed_difficulty = difficulty

					break
				end
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

return 
