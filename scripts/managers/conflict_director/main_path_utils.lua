MainPathUtils = {}
local distance_squared = Vector3.distance_squared
local Geometry = Geometry
local Vector3_distance = Vector3.distance
MainPathUtils.total_path_dist = function ()
	return EngineOptimized.main_path_total_length()
end
MainPathUtils.closest_pos_at_main_path = function (main_paths, p)
	return EngineOptimized.closest_pos_at_main_path(p)
end
MainPathUtils.closest_pos_at_main_path_lua = function (main_paths, p)
	Profiler.start("closest_pos_at_main_path")

	local best_dist = math.huge
	local best_main_path, best_sub_index = nil
	local best_point = Vector3(0, 0, 0)
	local best_point_found = false
	local best_travel_dist = 0
	local total_path_dist = 0
	p = p or main_paths[1].nodes[1]:unbox()
	local Vector3_set_xyz = Vector3.set_xyz
	local Vector3_to_elements = Vector3.to_elements
	local Geometry_closest_point_on_line = Geometry.closest_point_on_line
	local Script_set_temp_count = Script.set_temp_count
	local Script_temp_count = Script.temp_count
	local Vector3_distance = Vector3.distance

	for i = 1, #main_paths, 1 do
		local sub_path = main_paths[i]
		local nodes = sub_path.nodes
		total_path_dist = total_path_dist + sub_path.path_length

		for j = 1, #nodes - 1, 1 do
			local num_v, num_q, num_m = Script_temp_count()
			local p1 = nodes[j]:unbox()
			local p2 = nodes[j + 1]:unbox()
			local closest_point = Geometry_closest_point_on_line(p, p1, p2)
			local d = distance_squared(p, closest_point)

			if d < best_dist then
				best_dist = d
				best_main_path = i
				best_sub_index = j
				best_point_found = true

				Vector3_set_xyz(best_point, Vector3_to_elements(closest_point))
			end

			Script_set_temp_count(num_v, num_q, num_m)
		end
	end

	local move_percent, closest_node = nil

	if best_point_found then
		local path = main_paths[best_main_path]
		closest_node = path.nodes[best_sub_index]:unbox()
		best_travel_dist = (path.travel_dist and path.travel_dist[best_sub_index] + Vector3.distance(best_point, closest_node)) or 0
		move_percent = best_travel_dist/total_path_dist
	else
		best_point = nil
	end

	Profiler.stop()

	return best_point, best_travel_dist, total_path_dist, move_percent, best_main_path, best_sub_index
end
MainPathUtils.collapse_main_paths = function (main_paths)
	local unified_path = {}
	local unified_travel_dists = {}
	local breaks = {}
	local breaks_order = {}
	local segments = {}
	local k = 1

	for i = 1, #main_paths, 1 do
		local sub_path = main_paths[i]
		local nodes = sub_path.nodes
		local travel_dist = sub_path.travel_dist
		local break_index = (k + #nodes) - 1

		if i < #main_paths then
			breaks[break_index] = 0
		end

		breaks_order[i] = break_index

		for j = 1, #nodes, 1 do
			unified_path[k] = nodes[j]
			unified_travel_dists[k] = travel_dist[j]
			segments[k] = i
			k = k + 1
		end
	end

	for break_index, data in pairs(breaks) do
		breaks[break_index] = (unified_travel_dists[break_index] + unified_travel_dists[break_index + 1])/2
	end

	EngineOptimized.register_main_path(unified_path, unified_travel_dists, segments, #main_paths)

	return unified_path, unified_travel_dists, segments, breaks, breaks_order
end
MainPathUtils.point_on_mainpath = function (main_paths, wanted_distance)
	return EngineOptimized.point_on_mainpath(wanted_distance)
end
MainPathUtils.point_on_mainpath_lua = function (main_paths, wanted_distance)
	local segment_distance = 0

	for i = 1, #main_paths, 1 do
		local sub_path = main_paths[i]
		segment_distance = segment_distance + sub_path.path_length

		if wanted_distance <= segment_distance then
			local remainder_dist = wanted_distance - segment_distance - sub_path.path_length
			local sub_move_percent = remainder_dist/sub_path.path_length
			local pos, sub_index = LevelAnalysis.get_path_point(sub_path.nodes, sub_path.path_length, sub_move_percent)

			return pos, i, sub_index
		end
	end

	return 
end
MainPathUtils.zone_segment_on_mainpath = function (main_paths, p)
	local best_point, best_travel_dist, move_percent = MainPathUtils.closest_pos_at_main_path(main_paths, p)
	local index = math.floor((best_travel_dist + 5)/10)

	return index
end
local index_list = {
	0,
	1,
	-1,
	5,
	-5,
	20,
	-20
}
local index_list_size = #index_list
MainPathUtils.closest_pos_at_collapsed_main_path = function (collapsed_path, collapsed_dists, breaks_lookup, p, last_index)
	last_index = last_index or 1
	local num_nodes = #collapsed_path
	local last_node = num_nodes - 1
	local math_clamp = math.clamp
	local best_dist = math.huge
	local best_point = Vector3(0, 0, 0)
	local best_index = false
	local total_path_dist = collapsed_dists[num_nodes]
	p = p or collapsed_path[1]:unbox()
	local Vector3_set_xyz = Vector3.set_xyz
	local Vector3_to_elements = Vector3.to_elements
	local Geometry_closest_point_on_line = Geometry.closest_point_on_line

	for j = 1, index_list_size, 1 do
		local i = last_index + index_list[j]
		i = math_clamp(i, 1, last_node)
		local p1 = collapsed_path[i]:unbox()
		local p2 = collapsed_path[i + 1]:unbox()
		local closest_point = Geometry_closest_point_on_line(p, p1, p2)
		local d = distance_squared(p, closest_point)

		if d < best_dist then
			best_dist = d
			best_index = i

			Vector3_set_xyz(best_point, Vector3_to_elements(closest_point))
		end
	end

	local move_percent, closest_node = nil
	local best_travel_dist = 0

	if best_index then
		closest_node = collapsed_path[best_index]:unbox()
		local node_dist = collapsed_dists[best_index]
		best_travel_dist = node_dist + Vector3_distance(best_point, closest_node)
		local at_break = breaks_lookup[best_index]

		if at_break and node_dist < best_travel_dist then
			if at_break < best_travel_dist then
				best_travel_dist = collapsed_dists[best_index + 1]
				best_point = collapsed_path[best_index + 1]:unbox()
			else
				best_travel_dist = node_dist
				best_point = closest_node
			end
		end

		move_percent = best_travel_dist/total_path_dist
	else
		best_point = nil
	end

	return best_point, best_travel_dist, move_percent, best_index
end
MainPathUtils.node_list_from_main_paths = function (nav_world, main_paths, max_node_distance, obstacles)
	local forward_list = {}
	local reversed_list = {}
	local forward_break_list = {}
	local reversed_break_list = {}

	for i = 1, #main_paths, 1 do
		local path_nodes = main_paths[i].nodes

		for j = 1, #path_nodes, 1 do
			local node = path_nodes[j]
			forward_list[#forward_list + 1] = node

			if i ~= 1 and j == 1 then
				reversed_break_list[node] = true
			elseif i ~= #main_paths and j == #path_nodes then
				forward_break_list[node] = true
			end

			if max_node_distance then
				local next_node = path_nodes[j + 1]

				if next_node then
					local segment = next_node.unbox(next_node) - node.unbox(node)
					local segment_length = Vector3.length(segment)

					if max_node_distance < segment_length then
						local segment_direction = Vector3.normalize(segment)
						local num_insert_nodes = math.floor(segment_length/max_node_distance)

						for k = 1, num_insert_nodes, 1 do
							local wanted_node_position = node.unbox(node) + segment_direction*k*max_node_distance
							local success, z = GwNavQueries.triangle_from_position(nav_world, wanted_node_position, 1.5, 1.5)

							if success then
								wanted_node_position.z = z
								local new_node = Vector3Box(wanted_node_position)
								forward_list[#forward_list + 1] = new_node
							end
						end
					end
				end
			end
		end
	end

	if obstacles then
		for i = 1, #obstacles, 1 do
			local obstacle = obstacles[i]
			local obstacle_position = obstacle.position:unbox()
			local path_position, _, _, _, _, best_sub_index = MainPathUtils.closest_pos_at_main_path_lua({
				{
					path_length = 1,
					nodes = forward_list
				}
			}, obstacle_position)

			if path_position then
				local distance_sq = distance_squared(path_position, obstacle_position)

				if distance_sq <= obstacle.radius_sq then
					local add_break_node = forward_list[best_sub_index]
					forward_break_list[forward_list[best_sub_index]] = true
					reversed_break_list[forward_list[best_sub_index + 1]] = true
				end
			end
		end
	end

	for i = #forward_list, 1, -1 do
		reversed_list[#reversed_list + 1] = forward_list[i]
	end

	return forward_list, reversed_list, forward_break_list, reversed_break_list
end
MainPathUtils.closest_node_in_node_list = function (node_list, p)
	local best_dist = math.huge
	local best_index = nil

	for i = 1, #node_list, 1 do
		local node_position = node_list[i]:unbox()
		local d = distance_squared(p, node_position)

		if d < best_dist then
			best_dist = d
			best_index = i
		end
	end

	return best_index
end
MainPathUtils.ray_along_node_list = function (nav_world, node_list, start_node_index, node_list_direction, wanted_distance)
	local end_node_index = (node_list_direction == -1 and 1) or #node_list
	local distance = 0

	for i = start_node_index, end_node_index, node_list_direction do
		local to_node = node_list[i + node_list_direction]

		if not to_node then
			return distance
		end

		local from_node = node_list[i]
		local from_position = from_node.unbox(from_node)
		local to_position = to_node.unbox(to_node)
		local success, hit_position = GwNavQueries.raycast(nav_world, from_position, to_position)

		if success then
			distance = distance + Vector3.length(to_position - from_position)

			if wanted_distance <= distance then
				return wanted_distance
			end
		else
			distance = distance + Vector3.length(hit_position - from_position)

			if wanted_distance <= distance then
				return wanted_distance
			else
				return distance
			end
		end
	end

	return 
end
MainPathUtils.find_equidistant_points_in_node_list = function (node_list, start_node_index, node_list_direction, point_distance, num_wanted_points)
	local node_index = start_node_index
	local points = {}
	local point_index = 1
	local segment_offset = 0

	while true do
		local to_node_index = node_index + node_list_direction
		local to_node = node_list[to_node_index]

		if not to_node then
			return points
		end

		local segment_start = node_list[node_index]:unbox()
		local segment_end = to_node.unbox(to_node)
		local segment = segment_end - segment_start
		local segment_length = Vector3.length(segment)
		local segment_direction = Vector3.normalize(segment)
		local num_points_in_segment = math.ceil((segment_length - segment_offset)/point_distance)

		for i = 0, num_points_in_segment - 1, 1 do
			points[point_index] = {
				segment_start + segment_direction*(segment_offset + i*point_distance),
				segment_direction*node_list_direction,
				node_index
			}
			point_index = point_index + 1

			if num_wanted_points and num_wanted_points < point_index then
				return points
			end
		end

		local segment_remainder = segment_length - (num_points_in_segment - 1)*point_distance
		segment_offset = (segment_offset + point_distance) - segment_remainder
		node_index = node_index + node_list_direction
	end

	return 
end

return 
