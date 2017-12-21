local unit_get_data = Unit.get_data
local script_data = script_data
AiBreedSnippets = AiBreedSnippets or {}
AiBreedSnippets.on_rat_ogre_spawn = function (unit, blackboard)
	blackboard.cycle_rage_anim_index = 1
	blackboard.slams = 0
	blackboard.shove_opportunity = blackboard.breed.num_forced_slams_at_target_switch <= blackboard.slams
	blackboard.aggro_list = {}
	blackboard.fling_skaven_timer = 0
	blackboard.next_move_check = 0
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
	conflict_director.add_unit_to_bosses(conflict_director, unit)

	return 
end
AiBreedSnippets.on_rat_ogre_death = function (unit, blackboard)
	local conflict_director = Managers.state.conflict

	conflict_director.freeze_intensity_decay(conflict_director, 1)
	conflict_director.remove_unit_from_bosses(conflict_director, unit)
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

		if not blackboard.confirmed_player_sighting then
			blackboard.confirmed_player_sighting = true
			blackboard.target_unit = enemy_unit
			blackboard.is_alerted = true
			blackboard.is_fleeing = true
			blackboard.is_passive = false
		end

		local ai_simple = ScriptUnit.extension(unit, "ai_system")

		ai_simple.set_perception(ai_simple, breed.perception, breed.target_selection_alerted)

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
AiBreedSnippets.on_grey_seer_spawn = function (unit, blackboard)
	local level_key = Managers.state.game_mode:level_key()
	local level_settings = LevelSettings[level_key]
	local level_name = level_settings.level_name
	local teleport_portals = {}
	local unit_indices = LevelResource.unit_indices(level_name, "units/hub_elements/ai_teleport_portal")

	for _, id in ipairs(unit_indices) do
		local position = LevelResource.unit_position(level_name, id)
		local rotation = LevelResource.unit_rotation(level_name, id)
		local boxed_position = Vector3Box(position)
		local boxed_rotation = QuaternionBox(rotation)
		local unit_data = LevelResource.unit_data(level_name, id)
		local portal_id = tonumber(DynamicData.get(unit_data, "id"))

		assert(portal_id, "portal id not integer?")

		teleport_portals[portal_id] = {
			position = boxed_position,
			rotation = boxed_rotation
		}
	end

	blackboard.teleports_done = {
		false,
		false,
		false
	}
	blackboard.teleport_portals = teleport_portals
	local action_data = BreedActions.skaven_grey_seer.teleport_1

	if action_data then
		blackboard.next_auto_teleport_at = Managers.time:time("main") + action_data.time_until_auto_teleport
	end

	return 
end

return 
