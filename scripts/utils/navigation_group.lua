NavigationGroup = class(NavigationGroup)
NavigationGroup.init = function (self, nav_world, poly_hash, poly, poly_center, poly_area, group_number)
	self._center_poly = poly_hash
	self._area = 0
	self._group_center = Vector3Box(poly_center)
	self._distance_from_finish = math.huge
	self._group_number = group_number
	self._group_polygons = {}
	self._group_size = 0
	self._group_neighbours = {}

	self.add_polygon(self, poly, poly_center, poly_area, nav_world)

	return 
end
NavigationGroup.make_string_of_group = function (self, write_string)
	write_string = write_string .. "{neighbours={"

	for group_neighbour, dummy_bool in pairs(self._group_neighbours) do
		local group_id = group_neighbour._group_number
		write_string = write_string .. group_id .. ","
	end

	write_string = write_string .. "}, group_polygons={"

	for poly_hash, poly in pairs(self._group_polygons) do
		write_string = write_string .. "[\"" .. poly_hash .. "\"]=" .. tostring(poly) .. ",\n"
	end

	write_string = write_string .. "}, dist_from_finish=" .. self._distance_from_finish .. ", "

	return write_string
end
NavigationGroup.add_polygon = function (self, poly, poly_center, poly_area, nav_world)
	local poly_hash = self.get_poly_hash(self, poly, nav_world)
	self._group_polygons[poly_hash] = poly
	self._group_size = self._group_size + 1
	self._area = self._area + poly_area

	if poly_center ~= nil then
		self.calculate_group_center(self, poly_center, nav_world)
	end

	return 
end
NavigationGroup.add_neighbour_group = function (self, group)
	self._group_neighbours[group] = true

	return 
end
NavigationGroup.remove_neighbour_group = function (self, group)
	self._group_neighbours[group] = nil

	return 
end
NavigationGroup.set_distance_from_finish = function (self, distance_from_finish)
	self._distance_from_finish = distance_from_finish

	return 
end
NavigationGroup.get_group_neighbours = function (self)
	return self._group_neighbours
end
NavigationGroup.recalc_neighbour_distances = function (self)
	for neighbour, data in pairs(self._group_neighbours) do
		data = Vector3.distance(self._group_center:unbox(), neighbour.get_group_center(neighbour):unbox())
	end

	return 
end
NavigationGroup.calculate_group_center = function (self, poly_center, nav_world)
	local group_size = self._group_size
	local cur_center = self._group_center:unbox()
	local new_center = ((group_size - 1)*cur_center + poly_center)/group_size
	local center_poly = GwNavTraversal.get_seed_triangle(nav_world, new_center)

	self._group_center:store(new_center)

	self._center_poly = (center_poly and self.get_poly_hash(self, center_poly, nav_world)) or self._center_poly

	return 
end
NavigationGroup.get_group_polygons_centers = function (self, list, nav_world)
	error("not used?")

	local poly_center = nil

	for _, poly in pairs(self._group_polygons) do
		local a, b, c = Script.temp_count()
		poly_center = self.calc_polygon_center(self, poly, nav_world)

		table.insert(list, Vector3Box(poly_center))
		Script.set_temp_count(a, b, c)
	end

	return list
end
NavigationGroup.get_poly_center_from_hash = function (self, poly_hash)
	return self._group_polygons[poly_hash]
end
NavigationGroup.get_group_center_poly = function (self)
	return self._center_poly
end
NavigationGroup.get_group_center = function (self)
	return self._group_center
end
NavigationGroup.get_group_area = function (self)
	return self._area
end
NavigationGroup.get_group_polygons = function (self)
	return self._group_polygons
end
NavigationGroup.get_group_size = function (self)
	return self._group_size
end
NavigationGroup.get_distance_from_finish = function (self)
	return self._distance_from_finish
end
NavigationGroup.destroy = function (self)
	self._group_neighbours = {}
	self._group_polygons = {}
	self._group_size = 0

	return 
end
NavigationGroup.calc_polygon_center = function (self, poly, nav_world)
	local p1, p2, p3 = GwNavTraversal.get_triangle_vertices(nav_world, poly)
	local center = (p1 + p2 + p3)/3

	return center
end
NavigationGroup.get_poly_hash = function (self, poly, nav_world)
	local a, b, c = Script.temp_count()
	local poly_center = self.calc_polygon_center(self, poly, nav_world)
	local poly_hash = poly_center.x*0.0001 + poly_center.y + poly_center.z*10000

	Script.set_temp_count(a, b, c)

	return poly_hash
end
NavigationGroup.print_group = function (self, world, nav_world, line_object, line_drawer, debug_world_gui)
	local color_node_a = math.random(0, 255)
	local color_node_b = math.random(0, 255)
	local color_node_c = math.random(0, 255)
	local color = Color(color_node_a, color_node_b, color_node_c)

	for _, poly in pairs(self._group_polygons) do
		self.draw_poly_lines(self, poly, color, nav_world, line_object, debug_world_gui)
	end

	local cent = self._group_center:unbox()
	local store_var = cent.y
	cent.y = cent.z
	cent.z = store_var
	local m = Matrix4x4.identity()
	local font_size = 1.2
	local font_material = "materials/fonts/arial"
	local font = "arial"

	line_drawer.sphere(line_drawer, self._group_center:unbox(), 0.07, Color(255, 255, 255))
	Gui.text_3d(debug_world_gui, "C", font_material, font_size, "arial", m, cent, 3, Color(255, 255, 255))
	Gui.text_3d(debug_world_gui, "C", font_material, font_size + 0.1, "arial", m, cent - Vector3(0.05, 0, 0), 2, Color(0, 0, 0))
	Gui.text_3d(debug_world_gui, "id=" .. self._group_number, font_material, font_size - 0.8, "arial", m, cent + Vector3(0, 1.4, 0), 3, Color(255, 255, 255))
	Gui.text_3d(debug_world_gui, "dist=" .. self._distance_from_finish, font_material, font_size - 0.8, "arial", m, cent + Vector3(0, 0.9, 0), 3, Color(255, 255, 255))

	return 
end
NavigationGroup.draw_poly_lines = function (self, poly, color, nav_world, line_object, debug_world_gui)
	local a, b, c = Script.temp_count()
	local n = {
		false,
		false,
		false
	}
	local store_var = nil
	local p1, p2, p3 = GwNavTraversal.get_triangle_vertices(nav_world, poly)
	p1 = p1 + Vector3(0, 0, 0.1)
	p2 = p2 + Vector3(0, 0, 0.1)
	p3 = p3 + Vector3(0, 0, 0.1)

	LineObject.add_line(line_object, color, p1, p2)
	LineObject.add_line(line_object, color, p1, p3)
	LineObject.add_line(line_object, color, p2, p3)
	Script.set_temp_count(a, b, c)

	return 
end

return 
