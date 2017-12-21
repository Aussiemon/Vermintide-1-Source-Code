-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
require("foundation/scripts/util/math")
require("scripts/utils/navigation_group")

NavigationGroupManager = class(NavigationGroupManager)
local MIN_AREA = 20

local function dprint(...)
	if script_data.debug_navigation_group_manager then
		printf(...)
	end

	return 
end

NavigationGroupManager.init = function (self)
	self._navigation_groups = {}
	self._registered_polygons = {}
	self._world = nil
	self._level = nil
	self.nav_world = nil
	self._groups_max_radius = 20
	self._finish_point = nil
	self._num_groups = 0
	self._printing_groups = false
	self._numb = 0

	return 
end
NavigationGroupManager.setup = function (self, world, nav_world)
	self._world = world
	self.nav_world = nav_world
	self.operational = true

	return 
end
NavigationGroupManager.form_groups = function (self, radius, finish_point)
	dprint("Forming navigation groups")
	assert(finish_point ~= nil, "Got nil for finish_point")
	Profiler.start("form_groups")

	self._groups_max_radius = radius or self._groups_max_radius
	self._finish_point = finish_point
	local nav_world = self.nav_world
	local level_key = Managers.state.game_mode:level_key()
	local level_name = LevelSettings[level_key].level_name
	local unit_indices = LevelResource.unit_indices(level_name, "core/gwnav/units/seedpoint/seedpoint")
	self._num_groups = 0
	local first_poly = GwNavTraversal.get_seed_triangle(nav_world, finish_point.unbox(finish_point))
	local in_group_queue = {}
	local rejected_queue = {}
	self._in_group_queue_pos = 0
	self._rejected_queue_pos = 0
	in_group_queue[#in_group_queue + 1] = first_poly

	self.assign_group(self, nil, in_group_queue, rejected_queue)

	for i, unit_index in ipairs(unit_indices) do
		local pos = LevelResource.unit_position(level_name, unit_index)
		first_poly = GwNavTraversal.get_seed_triangle(nav_world, pos)
		local in_group_queue2 = {}
		local rejected_queue2 = {}
		self._in_group_queue_pos = 0
		self._rejected_queue_pos = 0
		in_group_queue2[#in_group_queue2 + 1] = first_poly

		self.assign_group(self, nil, in_group_queue2, rejected_queue2)
	end

	dprint("Seed groups2:", Managers.time:time("game"))
	dprint("number of nav groups: ", self._num_groups)
	self.refine_groups(self)
	dprint("number of refined nav groups : ", self._num_groups)
	self.calc_distances_from_finish_for_all(self, in_group_queue)
	Profiler.stop()

	return 
end
NavigationGroupManager.assign_group = function (self, group, in_group_queue, rejected_queue)
	local a, b, c = Script.temp_count()
	local poly, poly_hash, create_new_group = self.next_poly_in_queue(self, in_group_queue, rejected_queue)
	create_new_group = create_new_group or not group

	if not poly then
		return 
	end

	if create_new_group then
		group = self.create_group(self, self._world, poly_hash, poly)
		in_group_queue = self.add_neighbours_to_queue(self, poly, group, in_group_queue)
	elseif self.in_range(self, poly, group) then
		if poly_hash ~= group.get_group_center_poly(group) then
			self.join_group(self, poly, poly_hash, group)
		else
			self._registered_polygons[poly_hash] = group
		end

		in_group_queue = self.add_neighbours_to_queue(self, poly, group, in_group_queue)
	else
		rejected_queue[#rejected_queue + 1] = poly
	end

	Script.set_temp_count(a, b, c)

	return self.assign_group(self, group, in_group_queue, rejected_queue)
end
NavigationGroupManager.next_poly_in_queue = function (self, in_group_queue, rejected_queue)
	self._in_group_queue_pos = self._in_group_queue_pos + 1
	local poly = in_group_queue[self._in_group_queue_pos]
	local poly_is_valid, poly_hash = self.poly_is_valid(self, poly)
	local create_new_group = false

	if not poly_is_valid then
		self._in_group_queue_pos = self._in_group_queue_pos - 1
		create_new_group = true

		repeat
			self._rejected_queue_pos = self._rejected_queue_pos + 1
			poly = rejected_queue[self._rejected_queue_pos]
			poly_is_valid, poly_hash = self.poly_is_valid(self, poly)

			if poly_is_valid == nil then
				self._rejected_queue_pos = self._rejected_queue_pos - 1

				return false, false
			end
		until poly_is_valid
	end

	if create_new_group then
		self.unmark_polys(self, rejected_queue)
	end

	return poly, poly_hash, create_new_group
end
NavigationGroupManager.poly_is_valid = function (self, poly)
	local poly_hash = false
	local poly_is_valid = false

	if poly then
		poly_hash = self.get_poly_hash(self, poly)

		if self._registered_polygons[poly_hash] == nil or self._registered_polygons[poly_hash] == true then
			poly_is_valid = true
		end
	else
		return nil, nil
	end

	return poly_is_valid, poly_hash
end
NavigationGroupManager.unmark_polys = function (self, rejected_queue)
	for i = self._rejected_queue_pos, #rejected_queue, 1 do
		local poly = rejected_queue[i]
		local poly_hash = self.get_poly_hash(self, poly)

		if self._registered_polygons[poly_hash] == true then
			self._registered_polygons[poly_hash] = nil
		end
	end

	return 
end
NavigationGroupManager.add_neighbours_to_queue = function (self, poly, group, in_group_queue)
	local neighbours = self.get_neighbours(self, poly)
	local poly_hash_atm = self.get_poly_hash(self, poly)

	for _, neighbour in ipairs(neighbours) do
		local poly_hash = self.get_poly_hash(self, neighbour)
		local poly_group = self._registered_polygons[poly_hash]

		if poly_group == nil then
			in_group_queue[#in_group_queue + 1] = neighbour
			self._registered_polygons[poly_hash] = true
		elseif poly_group ~= true and group ~= poly_group then
			group.add_neighbour_group(group, poly_group)
			poly_group.add_neighbour_group(poly_group, group)
		end
	end

	return in_group_queue
end
NavigationGroupManager.refine_groups = function (self)
	for group, _ in pairs(self._navigation_groups) do
		local group_area = group.get_group_area(group)

		if group_area < MIN_AREA then
			local group_polygons = group.get_group_polygons(group)
			local new_group = self.find_smallest_neighbour_group(self, group)
			local a, b, c = Script.temp_count()

			for _, poly in pairs(group_polygons) do
				local poly_hash = self.get_poly_hash(self, poly)

				self.join_group(self, poly, poly_hash, new_group)
			end

			Script.set_temp_count(a, b, c)

			local group_neighbours = group.get_group_neighbours(group)

			for neighbour_group, _ in pairs(group_neighbours) do
				neighbour_group.remove_neighbour_group(neighbour_group, group)

				if neighbour_group ~= new_group then
					neighbour_group.add_neighbour_group(neighbour_group, new_group)
					new_group.add_neighbour_group(new_group, neighbour_group)
				end
			end

			self._navigation_groups[group] = nil
			self._num_groups = self._num_groups - 1

			group.destroy(group)

			group = nil
		end
	end

	return 
end
NavigationGroupManager.find_smallest_neighbour_group = function (self, group)
	local group_neighbours = group.get_group_neighbours(group)
	local smallest_neighbour_group = next(group_neighbours, nil) or group

	for neighbour_group, _ in pairs(group_neighbours) do
		local group_area = smallest_neighbour_group.get_group_area(smallest_neighbour_group)

		if neighbour_group.get_group_area(neighbour_group) < group_area then
			smallest_neighbour_group = neighbour_group
		end
	end

	return smallest_neighbour_group
end
NavigationGroupManager.calc_distances_from_finish_for_all = function (self, in_group_queue)
	local a, b, c = Script.temp_count()
	local first_poly = GwNavTraversal.get_seed_triangle(self.nav_world, self._finish_point:unbox())
	local first_poly_hash = self.get_poly_hash(self, first_poly)

	for i, poly in ipairs(in_group_queue) do
		Script.set_temp_count(a, b, c)

		local poly_hash = self.get_poly_hash(self, poly)
		local group = self._registered_polygons[poly_hash]
		local is_first_group = false

		if group.get_distance_from_finish(group) ~= math.huge then
		else
			if group == self._registered_polygons[first_poly_hash] then
				is_first_group = true
			end

			local distance_from_finish = self.calc_distance_from_finish(self, group, is_first_group)

			group.set_distance_from_finish(group, distance_from_finish)
		end
	end

	return 
end
NavigationGroupManager.get_neighbours = function (self, poly)
	local neighbours = {
		GwNavTraversal.get_neighboring_triangles(poly)
	}

	return neighbours
end
NavigationGroupManager.create_group = function (self, world, poly_hash, poly)
	local poly_center = self.calc_polygon_center(self, poly)
	local poly_area = self.calc_polygon_area(self, poly)
	self._num_groups = self._num_groups + 1
	local group = NavigationGroup:new(self.nav_world, world, poly_hash, poly, poly_center, poly_area, self._num_groups)
	self._navigation_groups[group] = true
	self._registered_polygons[poly_hash] = group

	return group
end
NavigationGroupManager.join_group = function (self, poly, poly_hash, group)
	local poly_area = self.calc_polygon_area(self, poly)
	local poly_center = self.calc_polygon_center(self, poly)

	group.add_polygon(group, poly, poly_center, poly_area)

	self._registered_polygons[poly_hash] = group

	return 
end
NavigationGroupManager.in_range = function (self, poly, group)
	local poly_center = self.calc_polygon_center(self, poly)
	local group_center = group.get_group_center(group):unbox()
	local distance = Vector3.distance(poly_center, group_center)
	local radius = self._groups_max_radius

	return distance <= radius
end
NavigationGroupManager.calc_distance_from_finish = function (self, group, first_group)
	local distance_from_finish = math.huge
	local group_center = group.get_group_center(group)

	if first_group then
		distance_from_finish = Vector3.distance(group_center.unbox(group_center), self._finish_point:unbox())
	else
		local group_neighbours = group.get_group_neighbours(group)
		local neighbour = next(group_neighbours, nil)

		if not neighbour then
			return distance_from_finish
		end

		for neighbour_group, _ in pairs(group_neighbours) do
			local neighbour_distance = neighbour_group.get_distance_from_finish(neighbour_group)

			if neighbour_distance < distance_from_finish then
				distance_from_finish = neighbour_distance
				neighbour = neighbour_group
			end
		end

		local distance_to_neighbour = Vector3.distance(group_center.unbox(group_center), neighbour.get_group_center(neighbour):unbox())
		distance_from_finish = distance_from_finish + distance_to_neighbour
	end

	return distance_from_finish
end
NavigationGroupManager.calc_neighour_distances = function (self)
	for group, _ in nil do
		group.recalc_neighbour_distances(group)
	end

	return 
end
NavigationGroupManager.calc_polygon_center = function (self, poly)
	local p1, p2, p3 = GwNavTraversal.get_triangle_vertices(self.nav_world, poly)
	local center = (p1 + p2 + p3)/3

	return center
end
NavigationGroupManager.calc_polygon_area = function (self, poly)
	local p1, p2, p3 = self.get_polygon_sides(self, poly)
	local perimeter = p1 + p2 + p3
	perimeter = perimeter/2
	local area = math.sqrt(perimeter*(perimeter - p1)*(perimeter - p2)*(perimeter - p3))

	return area
end
NavigationGroupManager.get_polygon_sides = function (self, poly)
	local p1, p2, p3 = GwNavTraversal.get_triangle_vertices(self.nav_world, poly)
	local side_p1, side_p2, side_p3 = nil
	side_p1 = Vector3.distance(p1, p2)
	side_p2 = Vector3.distance(p1, p3)
	side_p3 = Vector3.distance(p2, p3)

	return side_p1, side_p2, side_p3
end
NavigationGroupManager.destroy = function (self)
	for group, _ in pairs(self._navigation_groups) do
		group.destroy_gui(group)
		group.destroy(group)

		group = nil
	end

	self.operational = nil
	self._navigation_groups = {}
	self._registered_polygons = {}

	return 
end
NavigationGroupManager.get_group_from_position = function (self, position)
	local triangle = GwNavTraversal.get_seed_triangle(self.nav_world, position)

	if not triangle then
		return 
	end

	local group = self.get_polygon_group(self, triangle)

	return group
end
local triangle_lookup = {}
local fallback_loop = 0
NavigationGroupManager.get_polygon_group = function (self, triangle, dont_clear)
	local triangle_hash = self.get_poly_hash(self, triangle)
	local group = self._registered_polygons[triangle_hash]

	if group then
		return group
	end

	if not dont_clear then
		table.clear(triangle_lookup)

		fallback_loop = 0
	end

	triangle_lookup[triangle_hash] = true
	fallback_loop = fallback_loop + 1

	if 20 < fallback_loop then
		dprint("failed to locate a neighbour with an area tries:", fallback_loop)

		return 
	end

	local neighbours = {
		GwNavTraversal.get_neighboring_triangles(triangle)
	}

	for i = 1, #neighbours, 1 do
		local a, b, c = Script.temp_count()
		local neighbour = neighbours[i]

		if not triangle_lookup[neighbour] then
			local neighbour_group = self.get_polygon_group(self, neighbour, true)

			if neighbour_group then
				self.join_group(self, triangle, triangle_hash, neighbour_group)

				return neighbour_group
			end
		end

		Script.set_temp_count(a, b, c)
	end

	return 
end
NavigationGroupManager.get_group_polygons = function (self, poly)
	local poly_group = self.get_polygon_group(self, poly)

	return poly_group.get_group_polygons(poly_group)
end
NavigationGroupManager.get_group_center = function (self, poly)
	local group = self.get_polygon_group(self, poly)

	return group.get_group_center(group)
end
NavigationGroupManager.get_poly_hash = function (self, poly)
	local poly_center = self.calc_polygon_center(self, poly)
	local poly_hash = poly_center.x*0.0001 + poly_center.y + poly_center.z*10000

	return poly_hash
end
NavigationGroupManager.get_group_centers = function (self, list)
	local a, b, c = Script.temp_count()

	for group, _ in pairs(self._navigation_groups) do
		local center = group.get_group_center(group)

		table.insert(list, center)
	end

	Script.set_temp_count(a, b, c)

	return list
end
NavigationGroupManager.get_group_polygons_centers = function (self, list)
	for group, _ in pairs(self._navigation_groups) do
		local a, b, c = Script.temp_count()
		list = group.get_group_polygons_centers(group, list)

		Script.set_temp_count(a, b, c)
	end

	return list
end
NavigationGroupManager.print_groups = function (self)
	local a, b, c = Script.temp_count()
	local do_print_groups = not not script_data.debug_navigation_group_manager

	if do_print_groups == self._printing_groups then
		return 
	end

	if do_print_groups then
		local a, b, c = Script.temp_count()

		for group, _ in pairs(self._navigation_groups) do
			group.print_group(group)
		end

		Script.set_temp_count(a, b, c)
	else
		for group, _ in pairs(self._navigation_groups) do
			group.destroy_gui(group)
		end
	end

	self._printing_groups = do_print_groups

	Script.set_temp_count(a, b, c)

	return 
end
NavigationGroupManager.a_star_cached = function (self, group1, group2)
	return LuaAStar.a_star_cached(self._navigation_groups, group1, group2)
end

return 
