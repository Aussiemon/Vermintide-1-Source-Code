-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
LevelAnalysis = class(LevelAnalysis)

require("scripts/utils/util")

local editor_event_checkbox_names = {
	event_boss = "boss_event_rat_ogre",
	event_patrol = "boss_event_storm_vermin_patrol"
}
LevelAnalysis.init = function (self, nav_world, using_editor)
	self.nav_world = nav_world
	self.using_editor = using_editor
	self.cover_points_broadphase = Broadphase(40, 512)
	self.chosen_crossroads = {}
	local terror_spawners = {}

	for check_box_name, event_name in pairs(editor_event_checkbox_names) do
		terror_spawners[check_box_name] = {
			spawners = {},
			level_sections = {}
		}
	end

	self.terror_spawners = terror_spawners

	if using_editor then
		self.set_random_seed(self)
	end

	return 
end
LevelAnalysis.set_random_seed = function (self, checkpoint_data)
	local seed = nil

	if checkpoint_data then
		seed = checkpoint_data.seed
	else
		seed = math.random_seed()
	end

	self.starting_seed = seed
	self.seed = seed

	print("[LevelAnalysis] set_random_seed( " .. self.starting_seed .. ")")

	return 
end
LevelAnalysis.create_checkpoint_data = function (self)
	return {
		seed = self.starting_seed
	}
end
LevelAnalysis._random = function (self, ...)
	local seed, value = Math.next_random(self.seed, ...)
	self.seed = seed

	return value
end
LevelAnalysis._random_float_interval = function (self, a, b)
	local seed, value = Math.next_random(self.seed)
	local value = a + (b - a)*value
	self.seed = seed

	return value
end
LevelAnalysis.destroy = function (self)
	if self.traverse_logic ~= nil then
		GwNavTagLayerCostTable.destroy(self.navtag_layer_cost_table)
		GwNavTraverseLogic.destroy(self.traverse_logic)
	end

	if self.astar_list then
		for i = 1, #self.astar_list, 1 do
			local a_star = astar_list[i][1]

			if not GwNavAStar.processing_finished(self.astar_list[i]) then
				GwNavAStar.cancel(self.astar_list[i])
			end

			GwNavAStar.destroy(self.astar_list[i])
		end
	end

	EngineOptimized.unregister_main_path()

	return 
end
LevelAnalysis.set_enemy_recycler = function (self, enemy_recycler)
	self.enemy_recycler = enemy_recycler

	return 
end
LevelAnalysis.get_start_and_finish = function (self)
	return self.start, self.finish
end
LevelAnalysis.get_path_markers = function (self)
	return self.path_markers
end
LevelAnalysis.generate_main_path = function (self, level_name, path_markers)
	local result = "success"

	if not path_markers then
		path_markers = {}

		if not level_name then
			local level_key = Managers.state.game_mode:level_key()
			level_name = LevelSettings[level_key].level_name
		end

		print("[LevelAnalysis] Generating main-path for level:", level_name)

		local unit_ind = LevelResource.unit_indices(level_name, "units/gamemode/path_marker")

		for _, id in ipairs(unit_ind) do
			local pos = LevelResource.unit_position(level_name, id)
			local unit_data = LevelResource.unit_data(level_name, id)
			local order = DynamicData.get(unit_data, "order")
			local marker_type = DynamicData.get(unit_data, "marker_type")
			local crossroads_string = DynamicData.get(unit_data, "crossroads")
			local order = tonumber(order)
			local index = #path_markers + 1
			local kind = "good"
			local on_mesh = GwNavTraversal.get_seed_triangle(self.nav_world, pos)

			if not on_mesh then
				kind = "outside"
				result = string.format("Path marker with order %s is outside of navigation mesh.", tostring(order))
			end

			for i = 1, #path_markers, 1 do
				if order < path_markers[i].order then
					index = i
					kind = kind or "good"

					break
				elseif order == path_markers[i] then
					index = i
					kind = kind or "duplicate"
					result = string.format("Two path markers in the level has the same order: %s", tostring(order))

					break
				end
			end

			table.insert(path_markers, index, {
				main_path_index = 1,
				pos = Vector3Box(pos),
				marker_type = marker_type,
				order = order,
				kind = kind,
				crossroads = crossroads_string
			})
		end
	else
		print("[LevelAnalysis] path markers aready generated")
	end

	if #path_markers < 2 then
		return "Missing path markers in level. Need at least 2."
	end

	local done = false

	while not done do
		done = true

		for i = 1, #path_markers - 1, 1 do
			if path_markers[i + 1].order < path_markers[i].order then
				local temp = path_markers[i]
				path_markers[i] = path_markers[i + 1]
				path_markers[i + 1] = temp
				done = false
			end
		end
	end

	print("[LevelAnalysis] Path-markers:")

	local main_path_index = 1
	local num_crossroads = 0
	local crossroads = {}
	local count = 0

	for i = 1, #path_markers, 1 do
		local path_marker = path_markers[i]

		print("read path_marker crossroad: ", path_marker.crossroads)

		if path_marker.crossroads and path_marker.crossroads ~= "" then
			local parts = string.split(path_marker.crossroads, ":")
			local crossroads_id = parts[1]
			local road_id = tonumber(parts[2])

			assert(road_id, "bad road_id")

			path_marker.crossroads_id = crossroads_id
			path_marker.road_id = road_id
			local crossroad = crossroads[crossroads_id]

			if not crossroad then
				crossroad = {
					num_roads = 0,
					main_path_index = main_path_index,
					roads = {}
				}
				crossroads[crossroads_id] = crossroad
				num_crossroads = num_crossroads + 1
			end

			crossroad.roads[road_id] = (crossroad.roads[road_id] or 0) + 1
			crossroad.num_roads = crossroad.num_roads + 1
		end

		path_marker.main_path_index = main_path_index

		if path_marker.marker_type == "break" then
			main_path_index = main_path_index + 1
			count = count + 1

			if count < 2 then
				return "If using breaks in main-path, then each sub-path needs at least 2 path markers. "
			end

			count = 0
		else
			count = count + 1
		end

		print("[LevelAnalysis] \tmarker: " .. i .. ", order:" .. path_marker.order .. ", main path index: " .. path_marker.main_path_index, ", crossroads:", path_marker.crossroads_id, path_marker.road_id)
	end

	if count < 2 then
		return "If using breaks in main-path, then each sub-path needs at least 2 path markers. Last path marker is loonely!"
	end

	self.crossroads = crossroads
	self.num_crossroads = num_crossroads
	self.path_markers = path_markers
	self.start = path_markers[1].pos
	self.finish = path_markers[#path_markers].pos

	self.start_main_path_generation(self, main_path_index)

	return result
end
LevelAnalysis.start_main_path_generation = function (self, num_main_paths)
	print("[LevelAnalysis] start_main_path_generation")

	self.stitching_path = true
	local path_markers = self.path_markers
	self.astar_list = {}
	self.main_paths = {}
	local layer_costs = {
		bot_ladders = 20,
		ledges_with_fence = 20,
		jumps = 20,
		ledges = 20,
		bot_jumps = 20,
		bot_drops = 20
	}
	self.traverse_logic = GwNavTraverseLogic.create(self.nav_world)
	self.navtag_layer_cost_table = GwNavTagLayerCostTable.create()

	self.initialize_cost_table(self, self.navtag_layer_cost_table, layer_costs)
	GwNavTraverseLogic.set_navtag_layer_cost_table(self.traverse_logic, self.navtag_layer_cost_table)

	local j = 1
	local sub_index = 1

	for i = 1, #path_markers - 1, 1 do
		local pos1 = path_markers[i].pos:unbox()
		local pos2 = path_markers[i + 1].pos:unbox()

		if path_markers[i].marker_type == "break" then
			sub_index = 1
		else
			self.astar_list[j] = {
				GwNavAStar.create(),
				sub_index,
				path_markers[i].main_path_index,
				i
			}

			GwNavAStar.start(self.astar_list[j][1], self.nav_world, pos1, pos2, self.traverse_logic)

			j = j + 1
			sub_index = sub_index + 1
		end
	end

	for i = 1, num_main_paths, 1 do
		self.main_paths[i] = {
			path_length = 0,
			nodes = {},
			astar_paths = {}
		}
	end

	print("[LevelAnalysis] main path generation - found " .. tostring(num_main_paths) .. " main paths, total of " .. tostring(#self.astar_list) .. " sub-paths.")

	return 
end
LevelAnalysis.initialize_cost_table = function (self, navtag_layer_cost_table, layer_costs)
	for layer_id, layer_name in ipairs(LAYER_ID_MAPPING) do
		local layer_cost = layer_costs[layer_name]

		if layer_cost then
			if layer_cost == 0 then
				GwNavTagLayerCostTable.forbid_layer(navtag_layer_cost_table, layer_id)
			else
				GwNavTagLayerCostTable.allow_layer(navtag_layer_cost_table, layer_id)
				GwNavTagLayerCostTable.set_layer_cost_multiplier(navtag_layer_cost_table, layer_id, layer_cost)
			end
		end
	end

	return 
end
LevelAnalysis.boxify_pos_array = function (array)
	for i = 1, #array, 1 do
		array[i] = Vector3Box(array[i])
	end

	return 
end
LevelAnalysis.inject_travel_dists = function (main_paths, overrride)
	print("[LevelAnalysis] Injecting travel distances")

	local first_path = main_paths[1]
	local travel_dist = first_path.travel_dist

	if not travel_dist or overrride then
		local total_travel_dist = 0
		local p1 = first_path.nodes[1]:unbox()

		for i = 1, #main_paths, 1 do
			local path = main_paths[i]
			local nodes = path.nodes
			local p2 = nodes[1]:unbox()
			total_travel_dist = total_travel_dist + Vector3.distance(p1, p2)
			local travel_dist = {
				total_travel_dist
			}

			for j = 2, #nodes, 1 do
				p1 = nodes[j - 1]:unbox()
				p2 = nodes[j]:unbox()
				total_travel_dist = total_travel_dist + Vector3.distance(p1, p2)
				travel_dist[j] = total_travel_dist
			end

			p1 = p2
			path.travel_dist = travel_dist
		end
	end

	return 
end
LevelAnalysis.update_main_path_generation = function (self)
	Profiler.start("update_main_path_generation")

	local astar_list = self.astar_list
	local size = #astar_list
	local main_paths = self.main_paths
	local i = 1

	while i <= size do

		-- decompilation error in this vicinity
		local a_star = astar_list[i][1]
		local result = GwNavAStar.processing_finished(a_star)
	end

	Profiler.stop("update_main_path_generation")

	return 
end
LevelAnalysis.calc_dists_to_start = function (self)
	local main_paths = self.main_paths
	local dist_from_start = 0

	for i = 1, #main_paths, 1 do
		local main_path = main_paths[i]
		main_path.dist_from_start = dist_from_start
		dist_from_start = dist_from_start + main_path.path_length
	end

	local total_path_dist = dist_from_start

	return total_path_dist
end
LevelAnalysis.boss_gizmo_spawned = function (self, unit)
	local travel_dist = Unit.get_data(unit, "travel_dist")
	local map_section_index = tonumber(Unit.get_data(unit, "map_section"))
	local terror_spawners = self.terror_spawners

	for checkbox_name, data in pairs(terror_spawners) do
		local can_spawn = Unit.get_data(unit, checkbox_name)

		if can_spawn then
			local spawners = data.spawners
			spawners[#spawners + 1] = {
				unit,
				travel_dist,
				map_section_index
			}
		end
	end

	if script_data.debug_ai_recycler then
		QuickDrawerStay:sphere(Unit.local_position(unit, 0), 2, Color(map_section_index*64, map_section_index%4*64, map_section_index%8*32))
		QuickDrawerStay:sphere(Unit.local_position(unit, 0), 0.25, Color(200, 200, 200))
	end

	return 
end
LevelAnalysis.group_spawners = function (self, spawners, level_sections)
	table.sort(spawners, function (a, b)
		return a[2] < b[2]
	end)

	local last_map_section_index = 0

	for i = 1, #spawners, 1 do
		local spawner_data = spawners[i]
		local unit = spawner_data[1]
		local travel_dist = spawner_data[2]
		local map_section_index = spawner_data[3]

		if map_section_index ~= last_map_section_index then
			if last_map_section_index < map_section_index then
				level_sections[map_section_index] = i
			elseif map_section_index < last_map_section_index then
			end
		end

		last_map_section_index = map_section_index
	end

	level_sections[last_map_section_index + 1] = #spawners + 1
	local num_sections = last_map_section_index

	return num_sections
end
LevelAnalysis.give_events = function (self, main_paths, terror_spawners, num_sections, generated_event_list, terror_event_list, event_settings, level_overrides)
	local start_index, end_index = nil
	local spawn_distance = 0
	local legend = (level_overrides and level_overrides.editor_event_legend) or event_settings.editor_event_legend
	local padding = (level_overrides and level_overrides.hand_placed_padding_dist) or event_settings.hand_placed_padding_dist

	for i = 1, num_sections, 1 do
		local boxed_pos = nil
		local terror_event_name = generated_event_list[i]
		local check_box_name = legend[terror_event_name]

		if check_box_name then
			local data = terror_spawners[check_box_name]
			local level_sections = data.level_sections
			local spawners = data.spawners
			start_index = level_sections[i]
			end_index = level_sections[i + 1] - 1

			fassert(start_index ~= end_index, "Level Error: Too few boss-gizmo spawners of type '%d' in section %d: start-index: %d, end-index: %d,", check_box_name, i, start_index, end_index)

			local start_travel_dist = spawners[start_index][2]
			local end_travel_dist = spawners[end_index][2]
			local forbidden_dist = padding - start_travel_dist - spawn_distance

			print(string.format("[LevelAnalysis] section: %d, start-index: %d, end-index: %d, forbidden-dist: %.1f", i, start_index, end_index, forbidden_dist))

			if 0 < forbidden_dist then
				local forbidden_travel_dist = start_travel_dist + forbidden_dist
				local new_start_index = nil

				for j = start_index, end_index, 1 do
					local travel_dist = spawners[j][2]

					if forbidden_travel_dist <= travel_dist then
						new_start_index = j

						break
					else
						print("[LevelAnalysis] \t\t--> since forbidden dist, skipping spawner ", j, " at distance,", travel_dist)
					end
				end

				if new_start_index then
					print("[LevelAnalysis] \t\t--> found new spawner ", new_start_index, " at distance,", spawners[new_start_index][2], " passing forbidden dist:", forbidden_travel_dist)

					start_index = new_start_index
				else
					print(string.format("[LevelAnalysis] failed to find spawner - too few spawners in section %d, forbidden-dist %.1f", i, forbidden_dist))

					local random_dist = self._random_float_interval(self, forbidden_travel_dist, end_travel_dist)
					local pos = MainPathUtils.point_on_mainpath(main_paths, random_dist)

					print("[LevelAnalysis] \t\t--> fallback -> using main-path spawning for section", i)

					spawn_distance = random_dist
					boxed_pos = Vector3Box(pos)
				end
			end

			if not boxed_pos then
				local spawner_index = self._random(self, start_index, end_index)
				local spawner = spawners[spawner_index]
				boxed_pos = Vector3Box(Unit.local_position(spawner[1], 0))
				spawn_distance = spawner[2]
			end
		else
			local dummy_name = event_settings.events[1]
			local check_box_name = legend[dummy_name]
			local data = terror_spawners[check_box_name]
			local level_sections = data.level_sections
			start_index = level_sections[i]
			end_index = level_sections[i + 1] - 1
			local index = math.floor((start_index + end_index)/2)
			local spawners = data.spawners
			local spawner = spawners[index]
			boxed_pos = Vector3Box(Unit.local_position(spawner[1], 0))
			spawn_distance = spawner[2]
		end

		local terror_event_name = generated_event_list[i]

		if terror_event_name ~= "nothing" then
			if event_settings.terror_events_using_packs then
				self.enemy_recycler:add_terror_event_in_area(boxed_pos, terror_event_name)
			else
				self.enemy_recycler:add_main_path_terror_event(boxed_pos, terror_event_name, 45)
			end
		end

		terror_event_list[#terror_event_list + 1] = {
			boxed_pos,
			terror_event_name,
			spawn_distance,
			event_settings
		}

		if script_data.debug_ai_recycler then
			local pos = boxed_pos.unbox(boxed_pos)

			Debug.world_sticky_text(pos + Vector3(0, 0, 13), terror_event_name .. "-" .. i, "yellow")
			QuickDrawerStay:cylinder(pos, pos + Vector3(0, 0, 6), 2)
		end
	end

	return 
end
LevelAnalysis.generate_event_name_list = function (self, event_settings, num_sections, level_overrides)
	print("[LevelAnalysis] Terror events added:")

	local terror_events_kinds = (level_overrides and level_overrides.events) or event_settings.events
	local num_event_kinds = #terror_events_kinds
	local max_events_of_this_kind = (level_overrides and level_overrides.max_events_of_this_kind) or event_settings.max_events_of_this_kind
	local event_list = {}
	local count_events = {}
	local last_chosen_event_index = -1

	for i = 1, num_sections, 1 do
		local index = self._random(self, 1, num_event_kinds)

		while index == last_chosen_event_index and 2 <= num_event_kinds do
			index = self._random(self, 1, num_event_kinds)
		end

		local terror_event_name = terror_events_kinds[index]
		local count = count_events[terror_event_name]

		if count then
			count = count + 1
		else
			count = 1
		end

		count_events[terror_event_name] = count

		if max_events_of_this_kind then
			local max_count = max_events_of_this_kind[terror_event_name]

			if max_count and max_count < count then
				terror_event_name = "nothing"
			end
		end

		event_list[i] = terror_event_name

		print("[LevelAnalysis]", i, "\t-->Added boss/special event:", terror_events_kinds[index])

		last_chosen_event_index = index
	end

	return event_list
end
LevelAnalysis.hand_placed_terror_creation = function (self, main_paths, event_settings, terror_event_list, level_overrides)
	local terror_events_kinds = (level_overrides and level_overrides.events) or event_settings.events
	local num_sections = nil
	local num_event_kinds = #terror_events_kinds

	if num_event_kinds <= 0 then
		return 
	end

	if script_data.debug_ai_recycler then
		self.saved_terror_spawners = table.clone(self.terror_spawners)
	end

	local terror_spawners = self.terror_spawners
	local last_num_sections, last_checkbox_name = nil

	for checkbox_name, data in pairs(terror_spawners) do
		print("[LevelAnalysis] grouping spawners for ", checkbox_name)

		num_sections = self.group_spawners(self, data.spawners, data.level_sections)

		if last_num_sections and num_sections ~= last_num_sections then
			error("Not all sectors has boss event gizmos in level for  " .. ((num_sections < last_num_sections and checkbox_name) or last_checkbox_name))
		end

		last_num_sections = num_sections
		last_checkbox_name = checkbox_name

		print("[LevelAnalysis] ")
	end

	local generated_event_list = self.generate_event_name_list(self, event_settings, num_sections, level_overrides)

	self.give_events(self, main_paths, self.terror_spawners, num_sections, generated_event_list, terror_event_list, event_settings, level_overrides)

	return 
end
LevelAnalysis.automatic_terror_creation = function (self, main_paths, total_main_path_dist, terror_event_list, event_settings, level_overrides)
	local terror_events = (level_overrides and level_overrides.events) or event_settings.events
	local num_event_kinds = #terror_events

	if num_event_kinds <= 0 then
		return 
	end

	local event_every_x_meter = (level_overrides and level_overrides.recurring_distance) or event_settings.recurring_distance
	local safe_distance = (level_overrides and level_overrides.safe_dist) or event_settings.safe_dist
	terror_event_list[#terror_event_list + 1] = {
		Vector3Box(0, 0, 0),
		"safe-dist",
		safe_distance,
		event_settings
	}
	local level_path_dist = total_main_path_dist
	local adjusted_path_distance = level_path_dist - safe_distance
	local num_event_places_f = adjusted_path_distance/event_every_x_meter
	local num_event_places = math.floor(num_event_places_f)
	local trailing_event_fraction = num_event_places_f%1
	local trailing_event = (self._random(self) <= trailing_event_fraction and 1) or 0
	local num_events = num_event_places + trailing_event
	local padding = (level_overrides and level_overrides.padding_dist) or event_settings.padding_dist

	print("[LevelAnalysis] Level path distance:", level_path_dist)
	print("[LevelAnalysis] num_event_places_f:", num_event_places_f, ", num_event_places:", num_event_places, ", trailing_event_fraction:", trailing_event_fraction, ", num_events:", num_events)

	if num_events <= 0 then
		return 
	end

	local event_list = self.generate_event_name_list(self, event_settings, num_events, level_overrides)
	local spawn_distance = 0
	local path_dist1 = nil
	local path_dist2 = safe_distance

	for i = 1, num_events, 1 do
		path_dist1 = path_dist2
		path_dist2 = path_dist1 + event_every_x_meter
		path_dist2 = math.clamp(path_dist2, 0, level_path_dist)
		local forbidden_dist = padding - path_dist2 - spawn_distance

		print("[LevelAnalysis] path_dist1:", path_dist1, ", path_dist2:", path_dist2, " forbidden_dist:", forbidden_dist)

		if 0 < forbidden_dist then
			path_dist1 = path_dist1 + forbidden_dist
		end

		if path_dist2 < path_dist1 then
			print("[LevelAnalysis] skipping event - not enough space left in this segment")

			break
		end

		path_dist2 = math.clamp(path_dist2, 0, level_path_dist)
		local wanted_distance = self._random_float_interval(self, path_dist1, path_dist2)

		print("[LevelAnalysis] wanted_distance:", wanted_distance)

		local pos = MainPathUtils.point_on_mainpath(main_paths, wanted_distance)

		if not pos then
			print("Hoho!", math.random())
		end

		local boxed_pos = Vector3Box(pos)
		local terror_event_name = event_list[i]

		if terror_event_name ~= "nothing" then
			if event_settings.terror_events_using_packs then
				self.enemy_recycler:add_terror_event_in_area(boxed_pos, terror_event_name)
			else
				self.enemy_recycler:add_main_path_terror_event(boxed_pos, terror_event_name, 45)
			end
		end

		terror_event_list[#terror_event_list + 1] = {
			boxed_pos,
			terror_event_name,
			wanted_distance,
			event_settings
		}

		if script_data.debug_ai_recycler then
			Debug.world_sticky_text(pos + Vector3(0, 0, 13), terror_event_name .. "-" .. i, "yellow")
		end

		spawn_distance = wanted_distance
	end

	return 
end
LevelAnalysis.debug_spawn_boss_from_closest_spawner_to_player = function (self, draw_only)
	local player_pos = PLAYER_POSITIONS[1]
	local best_dist = math.huge
	local best_pos = nil
	local spawners = self.saved_terror_spawners

	if not spawners then
		print("debug_spawn_boss_from_closest_spawner_to_player - no spawners found")

		return 
	end

	print("debug_spawn_boss_from_closest_spawner_to_player")

	local boss_spawners = spawners.event_boss.spawners

	for i = 1, #boss_spawners, 1 do
		local data = boss_spawners[i]
		local spawner_pos = Unit.local_position(data[1], 0)
		local dist = Vector3.distance(player_pos, spawner_pos)

		if dist < best_dist then
			best_dist = dist
			best_pos = spawner_pos
		end

		QuickDrawer:sphere(spawner_pos, 1.5, Color(100, 200, 10))
	end

	if best_pos then
		print("debug_spawn_boss_from_closest_spawner_to_player - found spawner!")
		QuickDrawerStay:sphere(best_pos, 1.6, Color(50, 200, 10))

		if not draw_only then
			print("\t spawning ogre")
			Managers.state.conflict:spawn_unit(Breeds.skaven_rat_ogre, best_pos, Quaternion(Vector3.up(), 0), "debug_spawn")
		end
	end

	return 
end
LevelAnalysis.generate_boss_paths = function (self)
	self.boss_event_list = {}
	local last_boss, last_rare = nil
	local total_length = 0

	if CurrentBossSettings and not CurrentBossSettings.disabled then
		self.total_main_path_dist = self.calc_dists_to_start(self)
		local level_settings = self.level_settings
		local boss_spawning_method = level_settings.boss_spawning_method

		print("[LevelAnalysis] Generating boss paths for level:", level_settings.level_id)
		print("[LevelAnalysis] This level has a total main-path length of ", self.total_main_path_dist, " meters.")

		local boss_events = CurrentBossSettings.boss_events
		local boss_level_overrides = level_settings[boss_events.name]

		if boss_spawning_method == "hand_placed" then
			self.hand_placed_terror_creation(self, self.main_paths, boss_events, self.boss_event_list, boss_level_overrides)
		else
			self.automatic_terror_creation(self, self.main_paths, self.total_main_path_dist, self.boss_event_list, boss_events, boss_level_overrides)
		end

		local rare_events = CurrentBossSettings.rare_events
		local rare_level_overrides = level_settings[rare_events.name]

		self.automatic_terror_creation(self, self.main_paths, self.total_main_path_dist, self.boss_event_list, rare_events, rare_level_overrides)
	else
		local level_settings = self.level_settings

		print("[LevelAnalysis] Boss-spawning disabled for level", level_settings.level_id)
	end

	return 
end
LevelAnalysis.get_main_paths = function (self)
	return self.main_paths
end
LevelAnalysis.get_crossroads = function (self)
	return self.crossroads
end
LevelAnalysis.store_main_paths = function (self, main_paths)
	self.main_paths = main_paths
	local collapsed_path, collapsed_travel_dists, segments, breaks_lookup, breaks_order = MainPathUtils.collapse_main_paths(main_paths)
	local total_dist = collapsed_travel_dists[#collapsed_travel_dists]
	self.main_path_data = {
		collapsed_path = collapsed_path,
		collapsed_travel_dists = collapsed_travel_dists,
		breaks_lookup = breaks_lookup,
		breaks_order = breaks_order,
		total_dist = total_dist
	}

	return 
end
LevelAnalysis.pick_crossroad_path = function (self, cross_road_id, path_id)
	self.chosen_crossroads[cross_road_id] = path_id

	return 
end
LevelAnalysis.remove_crossroads_extra_path_branches = function (self, main_paths, crossroads, total_main_path_length_unmodified, zones, num_main_zones)
	main_paths = main_paths or self.main_paths
	crossroads = crossroads or self.crossroads

	if not crossroads or not next(crossroads) then
		print("This levels contains no crossroads")

		return 
	end

	local to_remove = {}

	for crossroads_id, crossroad in pairs(crossroads) do
		local chosen_road_id = self.chosen_crossroads[crossroads_id]

		if not chosen_road_id then
			chosen_road_id = Math.random(1, #crossroad.roads)

			print("Crossroads: No flow call Pick Crossroad Path for crossroad '" .. crossroads_id .. "' received. Code is chosing for you:" .. crossroads_id .. "->" .. chosen_road_id)
		end

		print("Keeping path '" .. chosen_road_id .. "'' at crossroad '" .. crossroads_id .. "'. (1/" .. #crossroad.roads .. ") paths.")

		for k = 1, #main_paths, 1 do
			local main_path = main_paths[k]

			if main_path.crossroads_id == crossroads_id and main_path.road_id ~= chosen_road_id then
				print("\t\t->removing road: " .. main_path.road_id .. " from crossroads: " .. main_path.crossroads_id)

				to_remove[#to_remove + 1] = k
			end
		end
	end

	local removed_path_distances = {}

	for k = #to_remove, 1, -1 do
		local index = to_remove[k]
		local travel_dist = main_paths[index].travel_dist
		removed_path_distances[#removed_path_distances + 1] = {
			travel_dist[1],
			travel_dist[#travel_dist]
		}

		table.remove(main_paths, index)
	end

	self.remove_terror_spawners_due_to_crossroads(self, removed_path_distances)

	local pickup_system = Managers.state.entity:system("pickup_system")

	pickup_system.remove_pickups_due_to_crossroads(pickup_system, removed_path_distances, total_main_path_length_unmodified)

	num_main_zones = self.remove_zones_due_to_crossroads(self, zones, num_main_zones, removed_path_distances)

	Managers.state.spawn.respawn_handler:remove_respawn_units_due_to_crossroads(removed_path_distances, total_main_path_length_unmodified)

	return true, num_main_zones
end
LevelAnalysis.remove_terror_spawners_due_to_crossroads = function (self, removed_path_distances)
	local to_remove = {}
	local terror_spawners = self.terror_spawners
	local num_removed_dist_pairs = #removed_path_distances

	for checkbox_name, data in pairs(terror_spawners) do
		table.clear(to_remove)

		local spawners = data.spawners

		for i = 1, #spawners, 1 do
			local spawner_data = spawners[i]
			local travel_dist = spawner_data[2]

			for j = 1, num_removed_dist_pairs, 1 do
				local dist_pair = removed_path_distances[j]

				if dist_pair[1] < travel_dist and travel_dist < dist_pair[2] then
					to_remove[#to_remove + 1] = i

					break
				end
			end
		end

		for i = #to_remove, 1, -1 do
			table.remove(spawners, to_remove[i])
		end
	end

	return 
end
LevelAnalysis.remove_zones_due_to_crossroads = function (self, zones, num_main_zones, removed_path_distances)
	local to_remove = {}
	local num_removed_dist_pairs = #removed_path_distances

	for i = 1, num_main_zones, 1 do
		local zone = zones[i]
		local travel_dist = zone.travel_dist

		assert(zone.type ~= "island", "Zones badly stored")

		for j = 1, num_removed_dist_pairs, 1 do
			local dist_pair = removed_path_distances[j]

			if dist_pair[1] < travel_dist and travel_dist < dist_pair[2] then
				to_remove[#to_remove + 1] = i

				break
			end
		end
	end

	for i = #to_remove, 1, -1 do
		table.remove(zones, to_remove[i])
	end

	num_main_zones = num_main_zones - #to_remove

	return num_main_zones
end
LevelAnalysis.store_path_markers = function (self, path_markers)
	self.path_markers = path_markers
	self.start = path_markers[1].pos
	self.finish = path_markers[#path_markers].pos

	return 
end
LevelAnalysis.main_path = function (self, index)
	local main_path = self.main_paths[index]

	return main_path.nodes, main_path.path_length
end
LevelAnalysis.get_path_point = function (path_list, path_length, move_percent)
	local travel_dist = 0
	local goal_dist = move_percent*path_length

	for i = 1, #path_list - 1, 1 do
		local p1 = path_list[i]:unbox()
		local p2 = path_list[i + 1]:unbox()
		local vec = p2 - p1
		local p1p2_dist = Vector3.length(vec)
		travel_dist = travel_dist + p1p2_dist

		if goal_dist < travel_dist then
			local missing = travel_dist - goal_dist
			local left_over = p1p2_dist - missing
			local part = left_over/p1p2_dist
			local part_vec = vec*part
			local move_vec = p1 + part_vec

			return move_vec, i
		end
	end

	return path_list[#path_list]:unbox(), #path_list
end
LevelAnalysis.reset_debug = function (self)
	local debug_text = Managers.state.debug_text

	debug_text.clear_world_text(debug_text, "boss_spawning")

	return 
end
local cols = {}

for i = 1, 16, 1 do
	cols[i] = {
		math.floor((i/16 - 1)*255),
		0,
		math.floor(i/16*255)
	}
end

LevelAnalysis.debug = function (self, t)

	-- decompilation error in this vicinity
	Profiler.start("LevelAnalysis:debug")

	local debug_text = Managers.state.debug_text

	debug_text.clear_world_text(debug_text, "boss")

	if self.path_markers then
		for i = 1, #self.path_markers, 1 do
			local pos = self.path_markers[i].pos:unbox()

			if self.path_markers[i].marker_type == "break" then
				QuickDrawer:cylinder(pos, pos + Vector3(0, 0, 8), 0.6, Color(255, 194, 13, 17), 16)
				QuickDrawer:sphere(pos + Vector3(0, 0, 8), 0.4, Color(255, 194, 13, 17))
			else
				QuickDrawer:cylinder(pos, pos + Vector3(0, 0, 8), 0.8, Color(255, 244, 183, 7), 16)
			end
		end
	end

	for k = 1, #self.main_paths, 1 do
		local main_path = self.main_paths[k]
		local nodes = main_path.nodes
		local path_length = main_path.path_length

		if nodes and 0 < #nodes then
			local last_pos = nodes[1]:unbox()

			for i = 1, #nodes, 1 do
				local pos = nodes[i]:unbox()

				QuickDrawer:sphere(pos + Vector3(0, 0, 1.5), 0.4, Color(255, 44, 143, 7))
				QuickDrawer:line(pos + Vector3(0, 0, 1.5), last_pos + Vector3(0, 0, 1.5), Color(255, 44, 143, 7))

				last_pos = pos
			end

			local pos, text = nil

			if self.boss_event_list then
				for i = 1, #self.boss_event_list, 1 do
					local data = self.boss_event_list[i]
					pos = data[1]:unbox()
					text = data[2]
					local pos_up = pos + Vector3(0, 0, 10)
					local color_name = data[4].debug_color
					local color = Colors.get(color_name)

					QuickDrawer:cylinder(pos, pos_up, 0.5, color, 10)
					QuickDrawer:sphere(pos_up, 2, color)

					local c = Colors.color_definitions[color_name]

					debug_text.output_world_text(debug_text, text, 0.5, pos_up, nil, "boss", Vector3(c[2], c[3], c[4]), "player_1")
				end
			end

			local p = t%5/5
			local point = LevelAnalysis.get_path_point(nodes, path_length, p)

			QuickDrawer:sphere(point + Vector3(0, 0, 1.5), 1.366, Color(255, 244, 183, 7))
		end
	end

	Profiler.stop("LevelAnalysis:debug")

	return 
end
LevelAnalysis.update = function (self, t)
	Profiler.start("level_analysis")

	if script_data.debug_ai_recycler and self.main_paths then
		self.debug(self, t)
	end

	if self.stitching_path then
		self.update_main_path_generation(self)
	end

	Profiler.stop("level_analysis")

	return 
end
LevelAnalysis.setup_unreachable_processing = function (nav_world, main_paths, point_list, optional)
	local setup = {
		investigated_points = 0,
		num_points_started = 0,
		running_astar_list = {},
		free_astar_list = {},
		remove_list = {},
		main_paths = main_paths,
		nav_world = nav_world,
		point_list = point_list,
		max_running_astars = (optional and optional.max_concurrent_astars) or 25,
		delete_failed_points = optional and optional.delete_failed_points,
		get_pos_func = optional and optional.get_pos_func,
		path_found_func = optional and optional.path_found_func,
		path_not_found_func = optional and optional.path_not_found_func,
		traverse_logic = (optional and optional.traverse_logic) or GwNavTraverseLogic.create(nav_world),
		line_object = optional and optional.line_object,
		fail_color = optional and optional.fail_color,
		ok_color = optional and optional.ok_color,
		translate_vec = optional and optional.translate_vec
	}

	return setup
end
LevelAnalysis.process_unreachable = function (work_data)
	local point_list = work_data.point_list
	local delete_failed_points = work_data.delete_failed_points
	local path_found_func = work_data.path_found_func or function ()
		return 
	end
	local path_not_found_func = work_data.path_not_found_func or function ()
		return 
	end
	local get_pos_func = work_data.get_pos_func or function (point_list, index)
		return point_list[index]:unbox()
	end
	local max_running_astars = work_data.max_running_astars
	local running_astars = work_data.running_astar_list
	local free_astars = work_data.free_astar_list
	local remove_list = work_data.remove_list
	local total_astars = #running_astars + #free_astars
	local j = work_data.num_points_started
	local total_points = #point_list
	local line_object = work_data.line_object
	local fail_color = (work_data.fail_color and Color(unpack(work_data.fail_color))) or Color(255, 0, 0)
	local ok_color = (work_data.ok_color and Color(unpack(work_data.ok_color))) or Color(255, 255, 255)
	local translate_vec = (work_data.translate_vec and Vector3(unpack(work_data.translate_vec))) or Vector3(0, 0, 0)

	Debug.text("Processing points: %d, %d/%d, astars: free %d running %d", work_data.num_points_started, work_data.investigated_points, total_points, #free_astars, #running_astars)
	print(string.format("[LevelAnalysis] Processing points: %d, %d/%d, astars: free %d running %d", work_data.num_points_started, work_data.investigated_points, total_points, #free_astars, #running_astars))

	if total_points <= work_data.investigated_points then
		print("[LevelAnalysis] -->processing done!")

		if delete_failed_points then
			if 0 < #remove_list then
				print("[LevelAnalysis] -->removing bad points:")
				table.sort(remove_list)

				for i = #remove_list, 1, -1 do
					local index = remove_list[i]
					point_list[index] = nil

					print("[LevelAnalysis] \tpoint", index, "removed")
				end
			else
				print("[LevelAnalysis] -->no bad points were found!")
			end
		end

		print("[LevelAnalysis] -->clearing up free_astars:", #free_astars)

		for i = 1, #free_astars, 1 do
			GwNavAStar.destroy(free_astars[i].astar)
		end

		print("[LevelAnalysis] -->clearing up running_astars:", #running_astars)

		for i = 1, #running_astars, 1 do
			GwNavAStar.destroy(running_astars[i].astar)
		end

		print("[LevelAnalysis] -->bye!")

		return true
	end

	local traverse_logic = work_data.traverse_logic
	local i = 0
	local astar = nil

	if #running_astars - #free_astars < max_running_astars then
		while j < total_points and i < max_running_astars do
			if 0 < #free_astars then
				local data = free_astars[#free_astars]
				free_astars[#free_astars] = nil
				astar = data.astar
				data.point_index = j + 1
				running_astars[#running_astars + 1] = data
			elseif total_astars < max_running_astars then
				i = i + 1
				astar = GwNavAStar.create()
				total_astars = total_astars + 1
				running_astars[i] = {
					astar = astar,
					point_index = j + 1
				}
			else
				break
			end

			local pos1 = get_pos_func(point_list, j + 1)
			local pos2 = MainPathUtils.closest_pos_at_main_path_lua(work_data.main_paths, pos1)
			j = j + 1

			assert(pos2, "no main-path pos found")
			GwNavAStar.start(astar, work_data.nav_world, pos1, pos2, traverse_logic)
		end
	end

	work_data.num_points_started = j
	i = 1
	local size = #running_astars

	while i <= size do
		local data = running_astars[i]
		local astar = data.astar
		local result = GwNavAStar.processing_finished(astar)

		if result then
			work_data.investigated_points = work_data.investigated_points + 1

			if GwNavAStar.path_found(astar) then
				if line_object then
					local a, b, c = Script.temp_count()
					local p1 = GwNavAStar.node_at_index(astar, 1)
					local h = Vector3(0, 0, 0.2) + translate_vec

					for k = 2, GwNavAStar.node_count(astar), 1 do
						local p2 = GwNavAStar.node_at_index(astar, k)

						line_object.line(line_object, p1 + h, p2 + h, ok_color)

						p1 = p2
					end

					Script.set_temp_count(a, b, c)
				end

				print(string.format("[LevelAnalysis] \tpoint: %d ok! (%d/%d)", data.point_index, work_data.investigated_points, total_points))
				path_found_func(point_list, data.point_index)
			else
				if line_object then
					local h = Vector3(0, 0, 0.2) + translate_vec
					local p1 = get_pos_func(point_list, data.point_index)
					local p2 = MainPathUtils.closest_pos_at_main_path_lua(work_data.main_paths, p1)

					line_object.line(line_object, p1 + h, p2 + h, fail_color)
					line_object.sphere(line_object, p1 + h, 0.2, fail_color)
					line_object.sphere(line_object, p2 + h, 0.2, fail_color)
				end

				print(string.format("[LevelAnalysis] \tpoint: %d failed! (%d/%d)", data.point_index, work_data.investigated_points, total_points))
				path_not_found_func(point_list, data.point_index)

				if delete_failed_points then
					remove_list[#remove_list + 1] = data.point_index
				end
			end

			free_astars[#free_astars + 1] = data
			running_astars[i] = running_astars[size]
			running_astars[size] = nil
			size = size - 1
		else
			i = i + 1
		end
	end

	return 
end

return 
