local unit_get_data = Unit.get_data
local script_data = script_data
AiBreedSnippets = AiBreedSnippets or {}
AiBreedSnippets.on_rat_ogre_spawn = function (unit, blackboard)
	blackboard.cycle_rage_anim_index = 1
	blackboard.slams = 0
	blackboard.shove_opportunity = blackboard.breed.num_forced_slams_at_target_switch <= blackboard.slams
	blackboard.aggro_list = {}
	blackboard.fling_skaven_timer = 0
	local conflict_director = Managers.state.conflict
	local breed = blackboard.breed

	if math.random() <= breed.chance_of_starting_angry then
		local ai_simple = ScriptUnit.extension(unit, "ai_system")

		ai_simple.set_perception(ai_simple, breed.perception, breed.target_selection_angry)
	else
		local main_paths = conflict_director.main_path_info.main_paths
		local _, travel_dist = MainPathUtils.closest_pos_at_main_path(main_paths, POSITION_LOOKUP[unit])
		blackboard.waiting = {
			next_player_unit_index = 1,
			next_update_time = 0,
			travel_dist = travel_dist
		}
	end

	conflict_director.freeze_intensity_decay(conflict_director, 10)

	return 
end
AiBreedSnippets.on_rat_ogre_death = function (unit, blackboard)
	Managers.state.conflict:freeze_intensity_decay(1)
	print("rat ogre died!")

	return 
end
AiBreedSnippets.on_loot_rat_update = function (unit, blackboard, t)
	local t = Managers.time:time("game")
	local cooldown_time = blackboard.dodge_cooldown_time

	if not cooldown_time or cooldown_time < t then
		local breed = blackboard.breed
		local dodge_vector, threat_vector = LocomotionUtils.in_crosshairs_dodge(unit, blackboard, t, breed.dodge_crosshair_radius, breed.dodge_crosshair_delay, breed.dodge_crosshair_min_distance, breed.dodge_crosshair_max_distance)

		if dodge_vector then
			blackboard.dodge_vector = Vector3Box(dodge_vector)
			blackboard.threat_vector = Vector3Box(threat_vector)
			blackboard.dodge_cooldown_time = t + blackboard.breed.dodge_cooldown
		end
	end

	return 
end
AiBreedSnippets.on_loot_rat_alerted = function (unit, blackboard, alerting_unit, enemy_unit)
	local t = Managers.time:time("game")
	local cooldown_time = blackboard.dodge_cooldown_time

	if not cooldown_time or cooldown_time < t then
		local breed = blackboard.breed
		local dodge_vector, threat_vector = nil

		if unit == alerting_unit and 0 < blackboard.dodge_damage_points then
			dodge_vector, threat_vector = LocomotionUtils.on_alerted_dodge(unit, blackboard, alerting_unit, enemy_unit)

			if dodge_vector then
				dodge_vector = Vector3Box(dodge_vector)
				threat_vector = Vector3Box(threat_vector)
			end
		end

		blackboard.dodge_vector = dodge_vector
		blackboard.threat_vector = threat_vector
		blackboard.dodge_cooldown_time = t + blackboard.breed.dodge_cooldown
	end

	return 
end
AiBreedSnippets.on_loot_rat_stagger_action_done = function (unit)
	if Unit.alive(unit) then
		local damage_extension = ScriptUnit.extension(unit, "damage_system")

		damage_extension.regen_dodge_damage_points(damage_extension)
	end

	return 
end

return 
