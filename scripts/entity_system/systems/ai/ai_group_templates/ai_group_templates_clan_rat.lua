AIGroupTemplates = AIGroupTemplates or {}
AIGroupTemplates.clan_rat_patrol_to_end_of_level = {
	init = function (world, nav_world, group, t)
		local path_markers = {}
		local random_group_member_pos = POSITION_LOOKUP[next(group.members)]
		local player_center_pos = ConflictUtils.average_player_position() or random_group_member_pos + Vector3(1, 0, 0)
		local group_to_player = Vector3.normalize(player_center_pos - random_group_member_pos)
		local best_dot = -1
		local best_pos = nil
		local level_key = Managers.state.game_mode:level_key()
		local level_name = LevelSettings[level_key].level_name
		local unit_indices = LevelResource.unit_indices(level_name, "units/gamemode/path_marker")

		if unit_indices == nil or #unit_indices == 0 then
			best_pos = player_center_pos

			print("WARNING: Spawned patrol with no path markers in level")
			Debug.sticky_text("WARNING: Spawned patrol with no path markers in level")
		else
			for i = 1, #unit_indices, 1 do
				local unit_level_id = unit_indices[i]
				local marker_pos = LevelResource.unit_position(level_name, unit_level_id)
				local group_to_marker = Vector3.normalize(marker_pos - random_group_member_pos)
				local dot = Vector3.dot(group_to_marker, group_to_player)

				if best_dot < dot then
					best_dot = dot
					best_pos = marker_pos
				end
			end
		end

		local goal_destination = best_pos
		local success, altitude = GwNavQueries.triangle_from_position(nav_world, goal_destination, 3, 3)

		if not success then
			print("WARNING: Spawned patrol with invalid path marker in level")
			Debug.sticky_text("WARNING: Spawned patrol with invalid path marker in level")

			if script_data.ai_group_debug then
				local drawer = Managers.state.debug:drawer({
					mode = "retained",
					name = "AIGroupTemplates_retained"
				})

				drawer.sphere(drawer, goal_destination, 3, Colors.get("red"))
				drawer.vector(drawer, random_group_member_pos, goal_destination - random_group_member_pos, Colors.get("red"))
			end

			return 
		end

		goal_destination.z = altitude
		group.destination = Vector3Box(goal_destination)
		local members = group.members
		local members_n = group.members_n
		local columns = math.ceil(math.sqrt(members_n))
		local i = 0

		for unit, _ in pairs(members) do
			local i_start = i

			while i < i_start + 10 do
				local pos_offset = Vector3((i%columns + 1) - math.ceil(columns/2), math.floor(i/columns) - math.floor(columns/2), 0)
				i = i + 1
				pos_offset = pos_offset*2
				local member_goal_destination = goal_destination + pos_offset
				local success, altitude = GwNavQueries.triangle_from_position(nav_world, member_goal_destination, 3, 3)

				if success then
					member_goal_destination.z = altitude
					local blackboard = Unit.get_data(unit, "blackboard")
					blackboard.goal_destination = Vector3Box(member_goal_destination)
					local breed = blackboard.breed
					local navigation_extension = blackboard.navigation_extension

					navigation_extension.set_max_speed(navigation_extension, breed.walk_speed)

					if script_data.ai_group_debug then
						local drawer = Managers.state.debug:drawer({
							mode = "retained",
							name = "AIGroupTemplates_retained"
						})

						drawer.sphere(drawer, goal_destination, 0.4, Colors.get("green"))
					end

					break
				end
			end

			if i == i_start + 10 then
				local blackboard = Unit.get_data(unit, "blackboard")
				blackboard.goal_destination = Vector3Box(POSITION_LOOKUP[unit])

				print("WARNING: Spawned patrol unit didn't find valid goal in level")
				Debug.sticky_text("WARNING: Spawned patrol unit didn't find valid goal in level")

				if script_data.ai_group_debug then
					local drawer = Managers.state.debug:drawer({
						mode = "retained",
						name = "AIGroupTemplates_retained"
					})

					drawer.sphere(drawer, POSITION_LOOKUP[unit], 0.4, Colors.get("red"))
				end
			end
		end

		group.state = "moving_to_goal"

		if script_data.ai_group_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "AIGroupTemplates_retained"
			})

			drawer.sphere(drawer, goal_destination, 3, Colors.get("green"))
			drawer.vector(drawer, random_group_member_pos, goal_destination - random_group_member_pos, Colors.get("green"))
		end

		return 
	end,
	destroy = function (world, nav_world, group)
		return 
	end,
	update = function (world, nav_world, group, t)
		if group.state == "moving_to_goal" then
			local all_done = true
			local members = group.members

			for unit, group_extension in pairs(members) do
				local blackboard = Unit.get_data(unit, "blackboard")
				local is_patrol_done = group_extension.is_patrol_done

				if not is_patrol_done then
					local has_target = AiUtils.unit_alive(blackboard.target_unit)
					local has_reached_goal = blackboard.goal_destination == nil

					if has_target or has_reached_goal then
						group_extension.is_patrol_done = true
						local breed = blackboard.breed
						local navigation_extension = blackboard.navigation_extension

						navigation_extension.set_max_speed(navigation_extension, breed.run_speed)
					else
						all_done = false
					end
				end
			end

			if all_done then
				group.state = nil

				if script_data.ai_group_debug then
					local drawer = Managers.state.debug:drawer({
						mode = "retained",
						name = "AIGroupTemplates_retained"
					})

					drawer.reset(drawer)
					drawer.sphere(drawer, group.destination:unbox(), 3, Colors.get("green"))
				end
			end
		end

		return 
	end
}
AIGroupTemplates.clan_rat_patrol_random = {
	init = function (world, nav_world, group, t)
		group.destination = Vector3Box(0, 0, 0)
		group.state = "chilling"
		group.choose_target_time = t + 1

		return 
	end,
	destroy = function (world, nav_world, group)
		return 
	end,
	update = function (world, nav_world, group, t)
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "AIGroupTemplates_retained"
		})

		Debug.text("Group: %s", group.state)

		if group.state == "moving_to_goal" then
			local all_done = true
			local members = group.members

			for unit, _ in pairs(members) do
				local blackboard = Unit.get_data(unit, "blackboard")

				if blackboard.goal_destination ~= nil then
					all_done = false

					break
				end
			end

			if all_done then
				group.destination = Vector3Box(10, 0, 0)
				group.state = "chilling"
				group.choose_target_time = t + 2
			end
		elseif group.state == "chilling" and group.choose_target_time <= t then
			local player_count = 0
			local player_center_pos = Vector3.zero()
			local players = Managers.player:human_players()

			for k, player in pairs(players) do
				local unit = player.player_unit

				if Unit.alive(unit) then
					local pos = POSITION_LOOKUP[unit]
					player_center_pos = player_center_pos + pos
					player_count = player_count + 1
				end
			end

			if player_count == 0 then
				group.choose_target_time = t + 5

				return 
			end

			player_center_pos = player_center_pos*player_count/1
			local random_group_member_pos = POSITION_LOOKUP[next(group.members)]
			local ai_to_player_vector = player_center_pos - random_group_member_pos
			local ai_to_player_direction = Vector3.normalize(player_center_pos - random_group_member_pos)
			local search_origin = random_group_member_pos + ai_to_player_direction*20

			drawer.reset(drawer)
			drawer.sphere(drawer, search_origin, 2)
			drawer.vector(drawer, random_group_member_pos, ai_to_player_vector)
			drawer.circle(drawer, search_origin, 30, Vector3.up())

			local rand_angle_offset = math.random(1, 100)

			for i = 1, 100, 1 do
				local angle_index = (i + rand_angle_offset)%100
				local angle = math.degrees_to_radians((angle_index*360)/100)
				local offset = Vector3(math.cos(angle), math.sin(angle), 0)*30
				local goal_destination = search_origin + offset
				local success, altitude = GwNavQueries.triangle_from_position(nav_world, goal_destination, 20, 20)

				if success and 100 < Vector3.distance_squared(goal_destination, random_group_member_pos) then
					goal_destination.z = altitude

					drawer.sphere(drawer, goal_destination, 2)
					drawer.vector(drawer, random_group_member_pos, goal_destination - random_group_member_pos)
					group.destination:store(goal_destination)

					local members = group.members
					local members_n = group.members_n
					local columns = math.ceil(math.sqrt(members_n))
					local i = 0

					for unit, _ in pairs(members) do
						local pos_offset = Vector3((i%columns + 1) - math.ceil(columns/2), math.floor(i/columns) - math.floor(columns/2), 0)

						print(i, pos_offset)

						i = i + 1
						pos_offset = pos_offset*2
						local blackboard = Unit.get_data(unit, "blackboard")
						blackboard.goal_destination = Vector3Box(goal_destination + pos_offset)
					end

					group.state = "moving_to_goal"

					return 
				end
			end
		end

		return 
	end
}

return 
