BTSpawnAllies = class(BTSpawnAllies, BTNode)

BTSpawnAllies.init = function (self, ...)
	BTSpawnAllies.super.init(self, ...)
end

BTSpawnAllies.name = "BTSpawnAllies"

local function randomize(event)
	if type(event) == "table" then
		return event[Math.random(1, #event)]
	else
		return event
	end
end

BTSpawnAllies.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	local data = {
		end_time = math.huge
	}
	blackboard.spawning_allies = data
	local call_position = self:_find_spawn_point(unit, blackboard, action, data)
	local nav_ext = blackboard.navigation_extension

	nav_ext:set_max_speed(action.run_to_spawn_speed)
	nav_ext:move_to(call_position)

	blackboard.run_speed_overridden = true

	if blackboard.move_state ~= "moving" then
		local start_anim, anim_locked = LocomotionUtils.get_start_anim(unit, blackboard, action.start_anims)

		if anim_locked then
			LocomotionUtils.set_animation_driven_movement(unit, true, false, false)
			blackboard.locomotion_extension:use_lerp_rotation(false)

			blackboard.follow_animation_locked = anim_locked
			blackboard.anim_cb_rotation_start = nil
			blackboard.move_animation_name = start_anim
			local rot_scale = AiAnimUtils.get_animation_rotation_scale(unit, blackboard, blackboard.action)

			LocomotionUtils.set_animation_rotation_scale(unit, rot_scale)

			blackboard.move_animation_name = nil
		end

		Managers.state.network:anim_event(unit, start_anim or action.move_anim)

		blackboard.move_state = "moving"
	end

	self:_activate_ward(unit, blackboard)
end

BTSpawnAllies._activate_ward = function (self, unit, blackboard)
	if not blackboard.ward_active then
		blackboard.ward_active = true

		AiUtils.stormvermin_champion_set_ward_state(unit, true, true)
	end
end

local function draw(shape, ...)
	if script_data.ai_champion_spawn_debug then
		QuickDrawerStay[shape](QuickDrawerStay, ...)
	end
end

local function dprint(...)
	if script_data.ai_champion_spawn_debug then
		print(...)
	end
end

local SPAWN_POS_TEMP = {}

BTSpawnAllies._find_spawn_point = function (self, unit, blackboard, action, data)
	local spawn_group = action.spawn_group
	local spawner_system = Managers.state.entity:system("spawner_system")
	local spawners = table.clone(spawner_system._id_lookup[spawn_group])
	local average_player_position = Vector3(0, 0, 0)
	local num_players = 0

	for i, pos in ipairs(PLAYER_AND_BOT_POSITIONS) do
		local player_unit = PLAYER_AND_BOT_UNITS[i]

		if not ScriptUnit.extension(player_unit, "status_system"):is_disabled() then
			num_players = num_players + 1
			average_player_position = average_player_position + pos
		end
	end

	local Vector3_distance_squared = Vector3.distance_squared
	local call_position = POSITION_LOOKUP[unit]

	if num_players > 0 then
		local flat_average_player_position = Vector3.flat(average_player_position / num_players)
		local best_dist_sq = -math.huge
		local best_index = nil
		local num_spawners = #spawners

		for i = 1, num_spawners, 1 do
			local spawner = spawners[i]
			local pos = ScriptUnit.extension(spawner, "spawner_system"):spawn_position()
			SPAWN_POS_TEMP[i] = pos
			local dist_sq = Vector3_distance_squared(Vector3.flat(pos), flat_average_player_position)

			if best_dist_sq < dist_sq then
				best_dist_sq = dist_sq
				best_index = i
			end
		end

		for i, pos in pairs(SPAWN_POS_TEMP) do
			draw("sphere", pos, 0.05, Color(255, 255, 255))
		end

		local best_pos = SPAWN_POS_TEMP[best_index]
		local best_other_index = nil
		local best_other_dist_sq = math.huge

		for i = 1, num_spawners, 1 do
			if i ~= best_index then
				local pos = SPAWN_POS_TEMP[i]
				local dist_sq = Vector3_distance_squared(Vector3.flat(pos), Vector3.flat(best_pos))

				if dist_sq < best_other_dist_sq then
					best_other_index = i
					best_other_dist_sq = dist_sq
				end
			end
		end

		local spawner_1 = spawners[best_index]
		local spawner_2 = spawners[best_other_index]
		local fwd = Vector3.normalize(Vector3.flat(Quaternion.forward(ScriptUnit.extension(spawner_1, "spawner_system"):spawn_rotation()) + Quaternion.forward(ScriptUnit.extension(spawner_2, "spawner_system"):spawn_rotation())))
		local pos1 = SPAWN_POS_TEMP[best_index]
		local pos2 = SPAWN_POS_TEMP[best_other_index]

		draw("sphere", pos1, 0.34, Color(0, 255, 255))
		draw("sphere", pos2, 0.34, Color(0, 255, 255))

		local average_pos = (SPAWN_POS_TEMP[best_index] + SPAWN_POS_TEMP[best_other_index]) * 0.5
		average_pos.z = math.max(SPAWN_POS_TEMP[best_index].z, SPAWN_POS_TEMP[best_other_index].z)

		draw("sphere", average_pos, 0.34, Color(0, 255, 255))
		draw("line", pos1, pos2, Color(0, 255, 255))

		local step = 0.25
		local nav_world = blackboard.nav_world
		local check_pos = average_pos + fwd * 1.5
		local above = 0.25
		local below = 10
		local success, z = nil

		draw("line", average_pos, check_pos, Color(0, 255, 255))

		for i = 1, 10, 1 do
			local old_check = check_pos
			check_pos = check_pos + step * fwd
			success, z = GwNavQueries.triangle_from_position(nav_world, check_pos, above, below)

			if success then
				call_position = Vector3(check_pos.x, check_pos.y, z)

				dprint("success")
				draw("line", old_check, call_position, Color(0, 255, 0))
				draw("sphere", call_position, 0.34, Color(0, 255, 255))

				break
			else
				dprint("fail")
				draw("line", old_check, check_pos, Color(255, 0, 0))
				draw("sphere", check_pos, 0.34, Color(255, 0, 0))
			end
		end

		data.spawn_forward = Vector3Box(fwd)
		data.spawners = {
			spawners[best_index],
			spawners[best_other_index]
		}

		table.clear(SPAWN_POS_TEMP)
	else
		data.spawn_forward = Vector3Box(Quaternion.forward(Unit.local_rotation(unit, 0)))
		data.spawners = {
			spawners[1],
			spawners[2]
		}
	end

	data.call_position = Vector3Box(call_position)

	return call_position
end

BTSpawnAllies._spawn = function (self, unit, data, blackboard, t)
	local action = blackboard.action

	Managers.state.network:anim_event(unit, randomize(action.animation))
	blackboard.navigation_extension:set_enabled(false)

	local loc_ext = blackboard.locomotion_extension

	loc_ext:set_wanted_velocity(Vector3.zero())
	loc_ext:use_lerp_rotation(true)
	loc_ext:set_wanted_rotation(Quaternion.look(data.spawn_forward:unbox(), Vector3.up()))

	local spawn_list = action.difficulty_spawn_list[Managers.state.difficulty:get_difficulty()] or action.spawn_list
	local spawners = data.spawners

	Managers.state.entity:system("surrounding_aware_system"):add_system_event(unit, "enemy_attack", DialogueSettings.enemy_spawn_allies, "attack_tag", "spawn_allies")

	local spawner_system = Managers.state.entity:system("spawner_system")

	for i = 1, #spawn_list, 1 do
		local unit = spawners[(i - 1) % #spawners + 1]

		spawner_system:spawn_horde(unit, 1, {
			Breeds[spawn_list[i]]
		})
		draw("sphere", ScriptUnit.extension(unit, "spawner_system"):spawn_position(), 0.5 + i * 0.05, Color(0, 255, 0))
	end

	local strictly_not_close_to_players = true
	local silent = true
	local composition_type = action.difficulty_spawn[Managers.state.difficulty:get_difficulty()] or action.spawn
	local limit_spawners, terror_event_id = nil
	local conflict_director = Managers.state.conflict

	conflict_director.horde_spawner:execute_event_horde(t, terror_event_id, composition_type, limit_spawners, silent, nil, strictly_not_close_to_players)
end

BTSpawnAllies.run = function (self, unit, blackboard, t, dt)
	local data = blackboard.spawning_allies

	if data.end_time < t then
		return "done"
	else
		local action = blackboard.action

		if not data.spawned and (Vector3.distance_squared(POSITION_LOOKUP[unit], data.call_position:unbox()) < 0.5 or blackboard.navigation_extension:number_failed_move_attempts() > 1) then
			data.spawned = true
			data.end_time = t + action.duration

			if blackboard.follow_animation_locked then
				self:_release_animation_lock(unit, blackboard)
			end

			self:_spawn(unit, data, blackboard, t)
		elseif data.spawned then
			blackboard.locomotion_extension:set_wanted_rotation(Quaternion.look(data.spawn_forward:unbox(), Vector3.up()))
		elseif blackboard.follow_animation_locked and blackboard.anim_cb_rotation_start then
			self:_release_animation_lock(unit, blackboard)
		end

		return "running"
	end
end

BTSpawnAllies._release_animation_lock = function (self, unit, blackboard)
	blackboard.follow_animation_locked = nil

	LocomotionUtils.set_animation_driven_movement(unit, false)
	blackboard.locomotion_extension:use_lerp_rotation(true)
end

BTSpawnAllies.leave = function (self, unit, blackboard, t, reason)
	local nav_ext = blackboard.navigation_extension

	nav_ext:set_enabled(true)
	nav_ext:set_max_speed(blackboard.run_speed)

	blackboard.run_speed_overridden = nil
	blackboard.defensive_mode_duration = 20
	blackboard.action = nil
	blackboard.spawning_allies = nil
	blackboard.spawned_allies_wave = blackboard.spawned_allies_wave + 1

	if blackboard.follow_animation_locked then
		self:_release_animation_lock(unit, blackboard)
	end
end

return
