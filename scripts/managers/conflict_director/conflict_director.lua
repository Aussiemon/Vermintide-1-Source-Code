require("scripts/settings/breeds")
require("scripts/managers/conflict_director/terror_event_mixer")
require("scripts/settings/conflict_settings")
require("scripts/managers/conflict_director/conflict_utils")
require("scripts/managers/conflict_director/main_path_utils")
require("scripts/managers/conflict_director/pack_spawner_utils")
require("scripts/managers/conflict_director/breed_packs")
require("scripts/managers/conflict_director/pacing")
require("scripts/managers/conflict_director/enemy_recycler")
require("scripts/managers/conflict_director/level_analysis")
require("scripts/managers/conflict_director/horde_spawner")
require("scripts/managers/conflict_director/a_star")
require("scripts/managers/conflict_director/specials_pacing")
require("scripts/managers/conflict_director/perlin_path")
require("scripts/managers/conflict_director/spawn_zone_baker")
require("scripts/managers/conflict_director/nav_tag_volume_handler")
require("scripts/managers/conflict_director/conflict_director_tests")
require("scripts/settings/level_settings")
require("scripts/utils/perlin_noise")
require("scripts/utils/navigation_group_manager")
require("scripts/settings/syntax_watchdog")

local unit_alive = Unit.alive
local position_lookup = POSITION_LOOKUP
local player_units = PLAYER_UNITS
local player_positions = PLAYER_POSITIONS
local player_and_bot_units = PLAYER_AND_BOT_UNITS
local player_and_bot_positions = PLAYER_AND_BOT_POSITIONS
local BLACKBOARDS = BLACKBOARDS
local distance_squared = Vector3.distance_squared
local GameSettingsDevelopment = GameSettingsDevelopment
local RecycleSettings = RecycleSettings
local FORM_GROUPS_IN_ONE_FRAME = true
local script_data = script_data
script_data.debug_terror = script_data.debug_terror or Development.parameter("debug_terror")
script_data.ai_roaming_spawning_disabled = script_data.ai_roaming_spawning_disabled or Development.parameter("ai_roaming_spawning_disabled")
script_data.ai_specials_spawning_disabled = script_data.ai_specials_spawning_disabled or Development.parameter("ai_specials_spawning_disabled")
script_data.ai_horde_spawning_disabled = script_data.ai_horde_spawning_disabled or Development.parameter("ai_horde_spawning_disabled")
script_data.ai_horde_spawning_debugging_disabled = script_data.ai_horde_spawning_debugging_disabled or Development.parameter("ai_horde_spawning_debugging_disabled")
script_data.ai_pacing_disabled = script_data.ai_pacing_disabled or Development.parameter("ai_pacing_disabled")
script_data.ai_far_off_despawn_disabled = script_data.ai_far_off_despawn_disabled or Development.parameter("ai_far_off_despawn_disabled")
script_data.debug_player_positioning = script_data.debug_player_positioning or Development.parameter("debug_player_positioning")
ConflictDirector = class(ConflictDirector)

ConflictDirector.init = function (self, world, level_key, network_event_delegate)
	self._world = world
	self._time = 0
	self._spawned = {}
	self._spawned_lookup = {}
	self._num_spawned_by_breed = {}
	self._num_spawned_by_breed_during_event = {}
	self._spawned_units_by_breed = {}
	self._current_debug_list_index = 1
	self._debug_list = {
		"none"
	}
	local conflict_settings = LevelSettings[level_key].conflict_settings or "default"
	local conflict_director = ConflictDirectors[conflict_settings]

	if conflict_director.disabled then
		self.current_conflict_settings = conflict_settings
	else
		self.current_conflict_settings = script_data.current_conflict_settings or conflict_settings
	end

	CurrentConflictSettings = ConflictDirectors[self.current_conflict_settings]

	self:set_updated_settings()

	self.pacing = Pacing:new(world, CurrentConflictSettings.pacing)
	self.enemy_recycler = nil
	self.specials_pacing = nil
	self.navigation_group_manager = NavigationGroupManager:new()
	self._alive_specials = {}
	self._alive_bosses = {}
	self._next_pacing_update = math.random()
	self._living_horde = 0
	self._num_spawned_during_event = 0
	self._hordes = {}
	self._horde_id = 0
	self._next_horde_time = math.huge
	self._crumbs = {}
	self._player_directions = {}
	self._drop_crumb_time = 0
	self.world_gui = World.create_world_gui(world, Matrix4x4.identity(), 1, 1, "immediate", "material", "materials/fonts/gw_fonts")
	self._spawn_debug_table = {}
	self._ai_horde_debugging_disabled_prev = script_data.ai_horde_spawning_debugging_disabled
	self._perlin_noise = PerlinNoise:new(world)
	self._player_areas = {}

	self:reset_spawned_by_breed()
	self:reset_spawned_by_breed_during_event()
	TerrorEventMixer.reset()

	self._rushing_checks = {}
	self._next_rush_check_unit = nil
	self._next_rush_check = math.huge
	self.spawn_queue = {}
	self.first_spawn_index = 1
	self.spawn_queue_size = 0
	self.spawn_queue_id = 0
	self.main_path_player_info = {}
	self.main_path_info = {
		current_path_index = 1,
		behind_percent = 1,
		ahead_percent = 0,
		ahead_travel_dist = 0,
		main_path_player_info_index = 0,
		ahead_unit = player_units[1],
		behind_unit = player_units[1],
		player_info_by_travel_distance = {}
	}
	self._main_path_obstacles = {}
	self._next_progression_percent = 0.1
	self._next_outside_navmesh_intervention_time = 6.15
	self.outside_navmesh_intervention_data = {}
	self._next_rushing_intervention_time = 5.1
	self._rushing_intervention_travel_dist = 50
	self.rushing_intervention_data = {
		ahead_dist = 0,
		loneliness_value = 0
	}
	self.in_safe_zone = true
	self.disabled = false
	self._mini_patrol_state = "waiting"
	self._next_mini_patrol_timer = 15
	self.level_analysis = LevelAnalysis:new()
	self._network_event_delegate = network_event_delegate

	network_event_delegate:register(self, "rpc_terror_event_trigger_flow")

	self.frozen_intensity_decay_until = 0
end

ConflictDirector.rpc_terror_event_trigger_flow = function (self, sender, event_id)
	local flow_event = NetworkLookup.terror_flow_events[event_id]

	self:level_flow_event(flow_event)
end

local function remove_element_from_array(array, value_to_remove)
	local size = #array

	for i = 1, size, 1 do
		local value = array[i]

		if value == value_to_remove then
			array[i] = array[size]
			array[size] = nil

			return
		end
	end
end

ConflictDirector.alive_specials = function (self)
	return self._alive_specials
end

ConflictDirector.alive_bosses = function (self)
	return self._alive_bosses
end

ConflictDirector.reset_spawned_by_breed = function (self)
	for name, breed in pairs(Breeds) do
		self._num_spawned_by_breed[name] = 0
		self._spawned_units_by_breed[name] = {}
	end
end

ConflictDirector.reset_spawned_by_breed_during_event = function (self)
	for name, breed in pairs(Breeds) do
		self._num_spawned_by_breed_during_event[name] = 0
	end

	self._num_spawned_during_event = 0
end

ConflictDirector.destroy = function (self)
	self.navigation_group_manager:destroy(self._world)

	if self.nav_tag_volume_handler then
		self.nav_tag_volume_handler:destroy()

		self.nav_tag_volume_handler = nil
	end

	self.level_analysis:destroy()
	self._network_event_delegate:unregister(self)

	self._main_path_obstacles = nil

	if self.spawn_zone_baker then
		self.spawn_zone_baker:reset()
	end
end

ConflictDirector.make_seed = function (self)
	self.master_seed = Math.random(1, 1294000000)
end

local max_crumbs = 25

ConflictDirector.update_player_crumbs = function (self, t, dt)
	if self._drop_crumb_time < t then
		self._num_crumbs = (self._num_crumbs or 0) + 1

		for player_id = 1, #player_positions, 1 do
			local pos = player_positions[player_id]

			if not self._crumbs[player_id] then
				self._crumbs[player_id] = {
					Vector3Box(pos),
					current_index = 1
				}
			end

			local player_crumbs = self._crumbs[player_id]
			local last_pos = player_crumbs[player_crumbs.current_index]:unbox()

			if distance_squared(last_pos, pos) > 1 then
				player_crumbs.current_index = player_crumbs.current_index + 1

				if max_crumbs < player_crumbs.current_index then
					player_crumbs.current_index = 1
				end

				player_crumbs[player_crumbs.current_index] = Vector3Box(pos)
				local oldest_index = (player_crumbs.current_index - 2) % #player_crumbs + 1
				local oldest_pos = player_crumbs[oldest_index]

				if oldest_pos then
					self._player_directions[player_id] = Vector3Box(pos - oldest_pos:unbox())
				end
			end
		end

		self._drop_crumb_time = t + 0.5
	end
end

ConflictDirector.get_player_unit_segment = function (self, player_unit)
	local player_info = self.main_path_player_info[player_unit]

	return (player_info and player_info.path_index) or nil
end

ConflictDirector.get_player_unit_travel_distance = function (self, player_unit)
	local player_info = self.main_path_player_info[player_unit]

	return (player_info and player_info.travel_dist) or nil
end

ConflictDirector.stop_rush_check = function (self, t)
	self._next_rush_check = math.huge

	table.clear(self._rushing_checks)
end

ConflictDirector.init_rush_check = function (self, t)
	self.players_speeding_dist = 0
	self._next_rush_check = 0
end

ConflictDirector.are_players_rushing = function (self, t)
	if self._next_rush_check < t then
		local main_path_player_info = self.main_path_player_info
		self._next_rush_check_unit = next(player_units, self._next_rush_check_unit)
		local unit = player_units[self._next_rush_check_unit]

		if unit then
			local path_data = main_path_player_info[unit]

			if not path_data then
				return
			end

			local rushing_checks = self._rushing_checks
			local start_data = rushing_checks[unit]

			if not start_data then
				start_data = {
					start_pos = Vector3Box(path_data.path_pos:unbox()),
					start_dist = path_data.travel_dist
				}
				rushing_checks[unit] = start_data

				return
			end

			local path_data = main_path_player_info[unit]
			local distance_moved = path_data.travel_dist - start_data.start_dist

			if self.players_speeding_dist < distance_moved then
				self.players_speeding_dist = distance_moved
			end

			if CurrentPacing.relax_rushing_distance < distance_moved then
				return true
			end
		else
			self._next_rush_check = t + 1
		end
	end
end

ConflictDirector.main_path_completion = function (self)
	local min_completion = 0

	for unit, data in pairs(self.main_path_player_info) do
		local move_percent = data.move_percent

		if move_percent and min_completion < move_percent then
			min_completion = move_percent
		end
	end

	return min_completion
end

ConflictDirector.sort_player_info_by_travel_distance = function (self, main_path_info, main_path_player_info)
	local player_info_by_travel_distance = main_path_info.player_info_by_travel_distance

	table.clear(player_info_by_travel_distance)

	local i = 0

	for unit, data in pairs(main_path_player_info) do
		i = i + 1
		player_info_by_travel_distance[i] = data
	end

	if i > 0 then
		table.sort(player_info_by_travel_distance, function (info_a, info_b)
			return info_a.travel_dist < info_b.travel_dist
		end)

		local ahead_info = player_info_by_travel_distance[1]
		main_path_info.ahead_unit = ahead_info.unit
		main_path_info.ahead_percent = ahead_info.move_percent
		main_path_info.ahead_travel_dist = ahead_info.travel_dist
		local behind_info = player_info_by_travel_distance[i]
		main_path_info.behind_unit = behind_info.unit
		main_path_info.behind_percent = ahead_info.move_percent
	else
		main_path_info.ahead_unit = nil
		main_path_info.ahead_percent = 0
		main_path_info.ahead_travel_dist = 0
		main_path_info.behind_unit = nil
		main_path_info.behind_percent = 1
	end
end

ConflictDirector.main_path_player_far_away_check = function (self, data, travel_dist, path_pos, pos, t)
	local far_away = math.abs(travel_dist - data.travel_dist) > 100

	if far_away then
		local astar = data.astar

		if astar then
			local done = GwNavAStar.processing_finished(astar)

			if done then
				local path_found = GwNavAStar.path_found(astar)

				if path_found then
					far_away = false
				end

				GwNavAStar.destroy(astar)

				data.astar = nil
				data.astar_timer = 0
				data.astar_timer = t + 3
			end
		elseif data.astar_timer < t then
			print("main_path_player_far_away_check started")

			local astar = GwNavAStar.create(self.nav_world)
			local traverse_logic = Managers.state.bot_nav_transition:traverse_logic()

			GwNavAStar.start_with_propagation_box(astar, self.nav_world, pos, path_pos, 30, traverse_logic)

			data.astar = astar
			data.astar_timer = t + 3
		end
	end

	return far_away
end

ConflictDirector.update_main_path_player_info = function (self, t)
	local main_path_info = self.main_path_info

	if not main_path_info.main_paths then
		return
	end

	Profiler.start("update_main_path_player_info")

	local main_path_player_info = self.main_path_player_info
	local index = main_path_info.main_path_player_info_index
	index = index + 1
	local num_units = #player_and_bot_units

	if index > num_units then
		index = 1
	end

	main_path_info.main_path_player_info_index = index
	local unit = player_and_bot_units[index]

	if unit then
		local pos = player_and_bot_positions[index]
		local data = main_path_player_info[unit]
		local main_paths = main_path_info.main_paths
		local path_pos, travel_dist, move_percent, sub_index, path_index = MainPathUtils.closest_pos_at_main_path(nil, pos)

		if not data then
			data = {
				astar_timer = 0,
				path_pos = Vector3Box(),
				unit = unit,
				total_path_dist = MainPathUtils.total_path_dist(),
				travel_dist = travel_dist
			}
			main_path_player_info[unit] = data
		end

		local far_away = self:main_path_player_far_away_check(data, travel_dist, path_pos, pos, t)

		if not far_away then
			data.path_index = path_index
			data.sub_index = sub_index
			data.move_percent = move_percent
			data.travel_dist = travel_dist

			data.path_pos:store(path_pos)

			if path_index then
				main_path_info.current_path_index = math.max(path_index, main_path_info.current_path_index)
			end

			if self._next_progression_percent <= move_percent then
				Managers.telemetry.events:level_progression(self._next_progression_percent)

				self._next_progression_percent = self._next_progression_percent + 0.1
			end

			if main_path_info.ahead_percent <= move_percent or main_path_info.ahead_unit == unit then
				main_path_info.ahead_percent = move_percent
				main_path_info.ahead_unit = unit
				main_path_info.ahead_travel_dist = data.travel_dist
			end

			if move_percent <= main_path_info.behind_percent or main_path_info.behind_unit == unit then
				main_path_info.behind_percent = move_percent
				main_path_info.behind_unit = unit
			end
		end
	end

	local recalc = false

	for unit, data in pairs(main_path_player_info) do
		if not unit_alive(unit) then
			main_path_player_info[unit] = nil
			recalc = true
		end
	end

	if recalc then
		self:sort_player_info_by_travel_distance(main_path_info, main_path_player_info)
	end

	Profiler.stop("update_main_path_player_info")

	if script_data.debug_ai_pacing then
		Profiler.start("debug_ai_pacing")

		local ahead_unit = main_path_info.ahead_unit

		if ahead_unit then
			local data = main_path_player_info[ahead_unit]

			self.spawn_zone_baker:draw_player_in_density_graph(data.travel_dist)
		end

		Profiler.stop("debug_ai_pacing")
	end
end

ConflictDirector.get_main_path_player_data = function (self, unit)
	return self.main_path_player_info[unit]
end

ConflictDirector.get_index = function (self, number, mod)
	local index = math.floor(number) % mod

	if index == 0 then
		index = mod
	end

	return index
end

ConflictDirector.get_cluster_and_loneliness = function (self, min_dist)
	if self._cluster_and_loneliness[min_dist] then
		local stored = self._cluster_and_loneliness[min_dist]

		return stored[1], stored[2], stored[3], stored[4]
	end

	local positions = player_and_bot_positions
	local units = player_and_bot_units
	local cluster_utility, loneliness_index, loneliness_value = ConflictUtils.cluster_weight_and_loneliness(positions, min_dist or 10)
	local loneliest_player_unit = units[loneliness_index]
	local fill = FrameTable.alloc_table()
	fill[1] = cluster_utility
	fill[2] = positions[loneliness_index]
	fill[3] = loneliness_value
	fill[4] = loneliest_player_unit
	self._cluster_and_loneliness[min_dist] = fill

	return cluster_utility, positions[loneliness_index], loneliness_value, loneliest_player_unit
end

ConflictDirector.update_player_areas = function (self)
	Profiler.start("update_player_areas")

	local player_areas = self._player_areas

	table.clear_array(player_areas, #player_areas)

	if self.navigation_group_manager.operational then
		for i = 1, #player_units, 1 do
			local unit = player_units[i]
			local last_pos_on_mesh = ScriptUnit.extension(unit, "whereabouts_system").last_pos_on_nav_mesh:unbox()
			local area = self.navigation_group_manager:get_group_from_position(last_pos_on_mesh)

			if area then
				player_areas[i] = area
			else
				player_areas[i] = false
			end
		end
	end

	Profiler.stop("update_player_areas")
end

local function terror_print(...)
	if script_data.debug_terror then
		Debug.text(...)
	end
end

ConflictDirector.add_horde = function (self, amount, event_breed_name)
	self._living_horde = self._living_horde + amount

	if event_breed_name then
		local event_breed = self._spawned_units_by_breed_during_event[event_breed_name]
		event_breed[breed_name] = event_breed[breed_name] + 1
	end
end

ConflictDirector.set_master_event_running = function (self, event_name)
	if self.running_master_event ~= event_name then
		self:reset_spawned_by_breed_during_event()
	end

	self.running_master_event = event_name
end

ConflictDirector.spawned_during_event = function (self)
	return self._num_spawned_during_event
end

ConflictDirector.horde_size = function (self)
	return self._living_horde
end

ConflictDirector.horde_size_total = function (self)
	local spawner_system = Managers.state.entity:system("spawner_system")
	local num = self._living_horde + spawner_system:waiting_to_spawn()

	return num
end

ConflictDirector.has_horde = function (self, t)
	if script_data.use_old_horde_system then
		if #self._hordes > 0 then
			return "vector"
		end
	else
		return self.horde_spawner and self.horde_spawner:running_horde(t)
	end
end

ConflictDirector.mini_patrol = function (self, t, terror_event_id, composition_type, group_template)
	local strictly_not_close_to_players = true
	local limit_spawners = 1
	local silent = true

	self.horde_spawner:execute_event_horde(t, terror_event_id, composition_type, limit_spawners, silent, group_template, strictly_not_close_to_players)
end

ConflictDirector.mini_patrol_killed = function (self, id)
	print("Mini patrol killed!", id)
end

ConflictDirector.event_horde = function (self, t, terror_event_id, composition_type, limit_spawners, silent, group_template)
	if not script_data.ai_horde_spawning_disabled then
		local horde = self.horde_spawner:execute_event_horde(t, terror_event_id, composition_type, limit_spawners, silent, group_template)

		return horde
	end
end

ConflictDirector.insert_horde = function (self, t, amount, delay, terror_event_id)
	self._horde_id = self._horde_id + 1
	local horde_data = {
		retry_cap = 0,
		number_of_hidden_points = 0,
		spawned_units = 0,
		total_units = 0,
		start_time = t,
		settings = CurrentHordeSettings,
		id = self._horde_id,
		hidden_points = {},
		refined_points = {},
		delay_horde_until = t + delay,
		amount = amount
	}
	local hordes = self._hordes
	hordes[#hordes + 1] = horde_data
end

ConflictDirector.prepare_horde = function (self, t, id)
	local horde_delay = ConflictUtils.random_interval(CurrentPacing.horde_delay)
	local horde_data = {
		retry_cap = 0,
		number_of_hidden_points = 0,
		spawned_units = 0,
		total_units = 0,
		start_time = t,
		settings = CurrentHordeSettings,
		id = id,
		hidden_points = {},
		refined_points = {},
		delay_horde_until = t + horde_delay,
		amount = CurrentHordeSettings.amount
	}

	return horde_data
end

ConflictDirector.start_horde = function (self, t, horde_data)
	print("Start horde!")

	local spawner_system = Managers.state.entity:system("spawner_system")
	local spawners = spawner_system:enabled_spawners()
	local clusters, clusters_sizes = ConflictUtils.cluster_positions(player_and_bot_positions, 7)

	if #clusters <= 0 then
		assert(false, "Something fishy, no clusters of players found, when trying to spawn a horde")

		horde_data.needs_update = false

		return
	end

	local data = horde_data.settings
	local min_range = data.range_spawner_units[1]
	local max_range = data.range_spawner_units[2]
	local horde_spawners = ConflictUtils.filter_horde_spawners(clusters, spawners, min_range, max_range)
	local total_amount = Math.random(horde_data.amount[1], horde_data.amount[2])
	local available_to_spawn = RecycleSettings.max_grunts - #self._spawned
	available_to_spawn = math.clamp(available_to_spawn, 0, available_to_spawn)

	if available_to_spawn < total_amount then
		print("Adjusted horde-size to " .. available_to_spawn .. " since too many units otherwise ( RecycleSettings.max_grunts=" .. RecycleSettings.max_grunts .. " )")

		total_amount = available_to_spawn
	end

	if total_amount <= 0 then
		print("Cannot spawn horde too many units alive")

		horde_data.needs_update = false

		self.pacing:annotate_graph("Failed horde", "red")

		return
	else
		self.pacing:annotate_graph("Horde:" .. total_amount, "lime")
	end

	local num_spawners = Math.random(data.num_spawnpoints[1], data.num_spawnpoints[2])
	num_spawners = math.clamp(num_spawners, 1, total_amount)
	local amount_per_spawner = math.floor(total_amount / num_spawners)
	local breeds = data.breeds
	local skip_chance = data.skip_chance
	horde_data.breeds = data.breeds[1]
	horde_data.amount_per_spawner = amount_per_spawner

	if not horde_spawners then
		print("no spawners found")

		skip_chance = 10
	end

	print("Spawning " .. total_amount .. " horde enemies.")

	for i = 1, num_spawners, 1 do
		local should_skip = math.random(1, 10)

		if should_skip <= skip_chance then
			print("SKIPPING: spawner: (" .. i)

			horde_data.in_backup = false
			horde_data.needs_update = true
			horde_data.number_of_hidden_points = horde_data.number_of_hidden_points + 1
			horde_data.retry_cap = horde_data.retry_cap + data.retry_cap
			local biggest_cluster = ConflictUtils.get_biggest_cluster(clusters_sizes)
			local center_pos = clusters[biggest_cluster]

			assert(center_pos, "Missing center-pos for player-cluster. Should not happen player_positions[1]: %s", tostring(player_positions[1]))

			horde_data.center_pos = Vector3Box(center_pos)

			self:setup_hidden_point(horde_data)
		else
			print("SPAWNING: spawner: (" .. i)

			local k = math.random(1, #horde_spawners)
			local spawner = horde_spawners[k]

			spawner_system:spawn_horde(spawner, amount_per_spawner, breeds)

			if script_data.ai_horde_spawning_debugging_disabled == false then
				local spawn_point = {
					Vector3Box(Unit.local_position(spawner, 0)),
					amount_per_spawner,
					"spawner"
				}

				table.insert(self._spawn_debug_table, spawn_point)
			end
		end
	end

	horde_data.total_units = horde_data.number_of_hidden_points * amount_per_spawner
end

ConflictDirector.backup_spawn = function (self, horde_data, center_pos)
	print("spawning", horde_data.number_of_hidden_points * horde_data.amount_per_spawner)
	print("trying to use an existing hidden point")

	local _, point = next(horde_data.refined_points)

	if point then
		point = point.pos_box:unbox()
	else
		print("trying to find point in plain sight")

		local dist = 15
		local spread = 5
		local tries = 30
		point = ConflictUtils.get_spawn_pos_on_circle_horde(self.nav_world, center_pos, dist, spread, tries)
	end

	if point then
		print("point found")
	end

	horde_data.hidden_points[#horde_data.hidden_points + 1] = (point and {
		is_hidden = false,
		pos_box = Vector3Box(point)
	}) or false
end

ConflictDirector.refine_hidden_points = function (self, t, horde_data)
	local entity_manager = Managers.state.entity
	local ai_system = entity_manager:system("ai_system")
	local data = horde_data.settings
	local center_pos = horde_data.center_pos:unbox()

	for i = #horde_data.hidden_points, 1, -1 do
		local spawn_pos = horde_data.hidden_points[i]
		local point_is_worthy = nil

		if not spawn_pos then
			table.remove(horde_data.hidden_points, i)

			if horde_data.retry_cap > 0 then
				self:setup_hidden_point(horde_data)

				horde_data.retry_cap = horde_data.retry_cap - 1
			elseif #horde_data.hidden_points == 0 then
				if not horde_data.in_backup then
					horde_data.in_backup = true

					self:backup_spawn(horde_data, center_pos)
				else
					return false
				end
			end
		else
			local pos = spawn_pos.pos_box:unbox()
			local end_poly = ai_system:get_tri_on_navmesh(pos)

			if not end_poly then
				print("wtf not on navmesh lol gg")
			end

			spawn_pos.spawn_cooldown = t
			spawn_pos.spawn_count = ((horde_data.in_backup == true and horde_data.number_of_hidden_points) or 1) * horde_data.amount_per_spawner
			horde_data.number_of_hidden_points = horde_data.number_of_hidden_points - 1
			point_is_worthy = true

			if point_is_worthy == nil then
			elseif point_is_worthy then
				if script_data.ai_horde_spawning_debugging_disabled == false then
					local point_type = (horde_data.in_backup and "backup") or "hidden"
					local spawn_point = {
						Vector3Box(pos),
						spawn_pos.spawn_count,
						point_type
					}

					table.insert(self._spawn_debug_table, spawn_point)
				end

				horde_data.refined_points[#horde_data.refined_points + 1] = horde_data.hidden_points[i]

				table.remove(horde_data.hidden_points, i)
			else
				horde_data.hidden_points[i] = false
			end
		end
	end

	return true
end

ConflictDirector.update_horde = function (self, t, dt, horde_data)
	if horde_data.delay_horde_until then
		if t < horde_data.delay_horde_until then
		else
			horde_data.delay_horde_until = nil

			self:start_horde(t, horde_data)
		end

		return false
	end

	if not horde_data.needs_update then
		return true
	end

	local spawn_cooldown = CurrentHordeSettings.spawn_cooldown
	local spawn_category = "old_horde"
	local breed = horde_data.breeds
	local data = horde_data.settings

	if not self:refine_hidden_points(t, horde_data) then
		return true
	end

	local center_pos = horde_data.center_pos:unbox()

	for i, spawn_pos in pairs(horde_data.refined_points) do
		local should_remove = true

		if spawn_pos.spawn_count > 0 then
			if spawn_pos.spawn_cooldown <= t then
				local pos = spawn_pos.pos_box:unbox()
				local dir = center_pos - pos
				local spawn_rot = Quaternion.look(Vector3(dir.x, dir.y, 1))
				local spawn_type = "horde_hidden"
				local ai_unit = self:spawn_unit(breed, pos, spawn_rot, spawn_category, nil, spawn_type)
				spawn_pos.spawn_cooldown = spawn_pos.spawn_cooldown + spawn_cooldown
				spawn_pos.spawn_count = spawn_pos.spawn_count - 1

				self:add_horde(1)

				horde_data.spawned_units = horde_data.spawned_units + 1
			end

			should_remove = false
		end

		if should_remove then
			horde_data.refined_points[i] = nil
		end
	end

	return horde_data.total_units == horde_data.spawned_units
end

ConflictDirector.setup_hidden_point = function (self, horde_data)
	local data = horde_data.settings
	local min_range = data.range_hidden_spawn[1]
	local max_range = data.range_hidden_spawn[2]
	local spread = (max_range - min_range) * 0.5
	local dist = min_range + spread
	local center_pos = horde_data.center_pos:unbox()
	local tries = 10
	local point, hit = ConflictUtils.pick_horde_pos(self._world, self.nav_world, self.navigation_group_manager, center_pos, dist, spread, tries)
	horde_data.hidden_points[#horde_data.hidden_points + 1] = (hit and {
		pos_box = Vector3Box(point),
		is_hidden = hit
	}) or false
end

ConflictDirector.check_updated_settings = function (self)
	local script_data = script_data

	if script_data.current_conflict_settings and self.current_conflict_settings ~= script_data.current_conflict_settings then
		local level_settings = LevelHelper:current_level_settings()
		self.level_settings = level_settings
		local level_conflict_settings = level_settings.conflict_settings

		if level_conflict_settings and ConflictDirectors[level_conflict_settings].disabled then
			return
		end

		local conflict_settings = script_data.current_conflict_settings
		conflict_settings = conflict_settings or level_conflict_settings or "default"
		CurrentConflictSettings = ConflictDirectors[conflict_settings]
		self.current_conflict_settings = conflict_settings

		self:set_updated_settings()
	end
end

ConflictDirector.patch_settings_with_difficulty = function (self, source_settings)
	local difficulty = Managers.state.difficulty.difficulty
	local overrides = source_settings.difficulty_overrides

	if overrides and overrides[difficulty] then
		local override_settings = overrides[difficulty]
		local patched_settings = {}

		for key, value in pairs(source_settings) do
			if key ~= "difficulty_overrides" then
				patched_settings[key] = override_settings[key] or source_settings[key]
			end
		end

		return patched_settings
	else
		return source_settings
	end
end

ConflictDirector.set_updated_settings = function (self)
	CurrentIntensitySettings = self:patch_settings_with_difficulty(CurrentConflictSettings.intensity)
	CurrentPacing = self:patch_settings_with_difficulty(CurrentConflictSettings.pacing)
	CurrentBossSettings = self:patch_settings_with_difficulty(CurrentConflictSettings.boss)
	CurrentSpecialsSettings = self:patch_settings_with_difficulty(CurrentConflictSettings.specials)
	CurrentHordeSettings = CurrentPacing.horde
	CurrentRoamingSettings = CurrentConflictSettings.roaming
end

ConflictDirector.get_horde_data = function (self)
	return self._next_horde_time, self._hordes
end

ConflictDirector.update_horde_pacing = function (self, t, dt)
	local pacing = self.pacing

	if pacing:threat_population() < 1 or pacing.pacing_state == "pacing_frozen" then
		self._next_horde_time = nil

		return
	end

	if not self._next_horde_time then
		local pacing_setting = pacing.settings
		self._next_horde_time = t + ConflictUtils.random_interval(pacing_setting.horde_frequency)
	end

	if self._next_horde_time < t then
		local horde_failed = true
		local composition_lookup = nil
		local num_spawned = #self._spawned

		if RecycleSettings.use_horde_composition_lists then
			local list = RecycleSettings.composition_list

			for i = 1, #list, 1 do
				local spawned_threshold = list[i].spawned_threshold

				if num_spawned <= spawned_threshold then
					horde_failed = false
					composition_lookup = list[i]

					break
				end
			end
		else
			horde_failed = RecycleSettings.push_horde_if_num_alive_grunts_above < num_spawned
		end

		if horde_failed then
			local pacing_setting = pacing.settings

			if RecycleSettings.push_horde_in_time then
				print("Pushing horde in time; too many units out")

				self._next_horde_time = t + 5

				pacing:annotate_graph("Pushed horde", "red")
			else
				print("Skipped horde; too many units out")

				self._next_horde_time = t + ConflictUtils.random_interval(pacing_setting.horde_frequency)

				pacing:annotate_graph("Failed horde", "red")
			end

			return
		end

		print("Time for new HOOORDE!")

		if script_data.use_old_horde_system then
			local hordes = self._hordes
			self._horde_id = self._horde_id + 1
			hordes[#hordes + 1] = self:prepare_horde(t, self._horde_id)
		else
			self.horde_spawner:horde(nil, composition_lookup)
		end

		if script_data.ai_pacing_disabled then
			self._next_horde_time = math.huge
		else
			local pacing_setting = pacing.settings
			self._next_horde_time = t + ConflictUtils.random_interval(pacing_setting.horde_frequency)
		end
	end
end

ConflictDirector.update_hordes = function (self, t, dt)
	local hordes = self._hordes

	for i = #hordes, 1, -1 do
		local horde_data = hordes[i]
		local spawning_done = self:update_horde(t, dt, horde_data)

		if spawning_done then
			print("Horde " .. i .. " done, remove it!")
			table.remove(hordes, i)
		end
	end
end

ConflictDirector.start_terror_event = function (self, event_name)
	TerrorEventMixer.add_to_start_event_list(event_name)
end

ConflictDirector.handle_alone_player = function (self, t)
	local data = self.rushing_intervention_data

	if #player_and_bot_units == 1 then
		data.disabled = "No rush intervention, since only one player alive"

		return
	else
		data.disabled = nil
	end

	local main_path_info = self.main_path_info
	local ahead_unit = main_path_info.ahead_unit

	if ahead_unit then
		local rush_intervention = CurrentSpecialsSettings.rush_intervention
		local _, _, loneliness_value, loneliest_player_unit = self:get_cluster_and_loneliness(10)
		data.loneliness_value = loneliness_value

		if ahead_unit == loneliest_player_unit or #player_and_bot_units == 2 then
			local player_info = self.main_path_player_info[ahead_unit]
			local dist = player_info.travel_dist - self._rushing_intervention_travel_dist
			data.player_travel_dist = player_info.travel_dist
			data.ahead_dist = dist
			data.ahead_unit = ahead_unit

			if dist <= 0 then
				return
			end

			if rush_intervention.loneliness_value_for_special < loneliness_value then
				print("going to make a rush intervention, since loneliness_value=", loneliness_value, " and dist=", dist)

				local success, message = self.specials_pacing:request_rushing_intervention(t, ahead_unit, main_path_info, self.main_path_player_info)

				if success then
					self.pacing:annotate_graph("Rush intervention - special", "red")

					data.message = "spawning: " .. message
				else
					data.message = message
				end

				local add_time = rush_intervention.delay_between_interventions

				if rush_intervention.loneliness_value_for_ambush_horde < loneliness_value and math.random() < rush_intervention.chance_of_ambush_horde then
					print("rush intervention - ambush horde!")
					self.pacing:annotate_graph("Rush intervention - horde", "red")
					self.horde_spawner:execute_ambush_horde(false, position_lookup[ahead_unit])

					add_time = add_time + 10
					success = true
				end

				if success then
					self._next_rushing_intervention_time = t + add_time
					self._rushing_intervention_travel_dist = player_info.travel_dist + rush_intervention.distance_until_next_intervention
				end
			end
		end
	end
end

local function enough_aggro_for_outside_navmesh_intervention(boss_spawned)
	local outside_navmesh_intervention = CurrentSpecialsSettings.outside_navmesh_intervention
	local needed_ordinary_enemy_aggro = outside_navmesh_intervention.needed_ordinary_enemy_aggro
	local needed_special_enemy_aggro = outside_navmesh_intervention.needed_special_enemy_aggro
	local entity_manager = Managers.state.entity
	local ai_system = entity_manager:system("ai_system")
	local num_ordinary_enemies_aggro = ai_system.number_ordinary_aggroed_enemies
	local num_special_enemies_aggro = ai_system.number_special_aggored_enemies
	local enough_aggro = boss_spawned or needed_ordinary_enemy_aggro <= num_ordinary_enemies_aggro or needed_special_enemy_aggro <= num_special_enemies_aggro

	return enough_aggro
end

ConflictDirector.handle_players_outside_navmesh = function (self, t)
	local boss_spawned = self:boss_event_running()
	local players_eligible_for_punishment = enough_aggro_for_outside_navmesh_intervention(boss_spawned)

	if players_eligible_for_punishment then
		local entity_manager = Managers.state.entity
		local ai_slot_system = entity_manager:system("ai_slot_system")
		local outside_navmesh_intervention = CurrentSpecialsSettings.outside_navmesh_intervention
		local data = self.outside_navmesh_intervention_data
		local num_players = #player_and_bot_units

		for i = 1, num_players, 1 do
			local player_unit = player_and_bot_units[i]

			if ai_slot_system:has_target_been_outside_navmesh_too_long(player_unit, t) then
				data.outside_unit = player_unit
				local success, message = self.specials_pacing:request_outside_navmesh_intervention(player_unit)
				data.message = message

				if success then
					self.pacing:annotate_graph("Outside navmesh intervention - special", "red")

					local add_time = outside_navmesh_intervention.delay_between_interventions
					self._next_outside_navmesh_intervention_time = t + add_time
				end

				break
			end
		end
	end
end

ConflictDirector.respawn_level = function (self)
	self:destroy_all_units()

	self._spawn_pos_list, self._pack_sizes, self._pack_rotations = self:generate_spawns()

	self.enemy_recycler:setup(self._spawn_pos_list, self._pack_sizes, self._pack_rotations)
	self.level_analysis:generate_boss_paths()
	self.level_analysis:reset_debug()

	self.main_path_info.main_paths = self.level_analysis:get_main_paths()

	self.spawn_zone_baker:draw_pack_density_graph()
end

ConflictDirector.create_debug_list = function (self)
	self._debug_list = {
		"none",
		self.pacing,
		self.spawn_zone_baker
	}
end

ConflictDirector.update_mini_patrol = function (self, t, dt)
	local pacing = self.pacing
	local settings = pacing.settings.mini_patrol
	local timer = self._next_mini_patrol_timer

	if self._mini_patrol_state == "spawning" then
		if timer < t then
			self._mini_patrol_state = "running"
			self._next_mini_patrol_timer = t + settings.override_timer
		end
	elseif self._mini_patrol_state == "running" then
		local num_spawned_by_breed = self._num_spawned_by_breed

		if (num_spawned_by_breed.skaven_clan_rat < 3 and num_spawned_by_breed.skaven_storm_vermin <= 1) or timer < t then
			self._mini_patrol_state = "waiting"
			self._next_mini_patrol_timer = t + ConflictUtils.random_interval(settings.frequency)
		end
	elseif timer < t then
		local mini_patrol_ok = pacing.total_intensity <= settings.only_spawn_below_intensity and RecycleSettings.max_grunts - #self._spawned >= 0

		if mini_patrol_ok then
			self._next_mini_patrol_timer = t + 5
			local mini_patrol_settings = self.level_settings.mini_patrol
			local composition = (mini_patrol_settings and mini_patrol_settings.composition) or settings.composition

			print("spawning mini patrol")

			local group_template = {
				size = 0,
				template = "mini_patrol",
				id = Managers.state.entity:system("ai_group_system"):generate_group_id()
			}

			self:mini_patrol(t, nil, composition, group_template)

			self._mini_patrol_state = "spawning"
		else
			self._next_mini_patrol_timer = t + 2
		end
	end

	if script_data.debug_mini_patrols then
		Debug.text("Mini patrol: active=%s, timer=%.1f", tostring(self._mini_patrol_state), self._next_mini_patrol_timer - t)
	end
end

ConflictDirector.reset_data = function (self)
	self._cluster_and_loneliness = FrameTable.alloc_table()
end

ConflictDirector.update = function (self, dt, t)
	self._time = t

	if script_data.debug_enabled and World.get_data(self._world, "paused") then
		self:update_server_debug(t, dt)

		return
	end

	if #player_positions == 0 then
		return
	end

	if self.level_analysis then
		self.level_analysis:update(t, dt)
		self:update_main_path_player_info(t)
	end

	if self.disabled then
		return
	end

	self:check_updated_settings()

	local conflict_settings = CurrentConflictSettings

	if conflict_settings.disabled then
		return
	end

	local pacing = self.pacing

	if not script_data.ai_pacing_disabled and not conflict_settings.pacing.disabled then
		if self._next_pacing_update < t then
			Profiler.start("pacing")
			pacing:update(t, dt, player_and_bot_units)

			self._next_pacing_update = t + 1
			local pacing_state = pacing:get_pacing_data()

			if pacing_state == "pacing_relax" then
				local rushing = self:are_players_rushing(t)

				if rushing then
					if CurrentPacing.leave_relax_if_rushing then
						print("players are progressing too fast, leave relax")
						pacing:advance_pacing(t, "players are rushing")
					end

					if CurrentPacing.horde_in_relax_if_rushing then
						print("players are progressing too fast, punish with a horde")

						self._next_horde_time = t
					end
				end
			end

			Profiler.stop("pacing")
		end

		Profiler.start("player rush")

		if not script_data.ai_rush_intervention_disabled and self._next_rushing_intervention_time < t then
			self._next_rushing_intervention_time = t + 1

			self:handle_alone_player(t)
		end

		Profiler.stop("player rush")
	end

	local threat_population = pacing:threat_population()

	if self.in_safe_zone then
		local game_mode_manager = Managers.state.game_mode
		local round_started = game_mode_manager:is_round_started()

		if round_started then
			print("Players are leaving the safe zone")

			self.in_safe_zone = false

			if self.specials_pacing then
				self.specials_pacing:start(t)

				if not script_data.ai_pacing_disabled then
					local pacing_setting = pacing.settings
					self._next_horde_time = t + ConflictUtils.random_interval(pacing_setting.horde_startup_time)
				end
			end
		end
	else
		if not conflict_settings.specials.disabled then
			if not conflict_settings.specials.outside_navmesh_intervention.disabled and not script_data.ai_outside_navmesh_intervention_disabled and self._next_outside_navmesh_intervention_time < t then
				Profiler.start("players outside navmesh")

				self._next_outside_navmesh_intervention_time = t + 1

				self:handle_players_outside_navmesh(t)
				Profiler.stop("players outside navmesh")
			end

			if self.specials_pacing and not script_data.ai_specials_spawning_disabled then
				Profiler.start("specials pacing")
				self.specials_pacing:update(t, self._alive_specials, threat_population, player_and_bot_positions)
				Profiler.stop("specials pacing")
			end
		end

		if not script_data.ai_horde_spawning_disabled and not conflict_settings.pacing.horde.disabled then
			Profiler.start("horde pacing")
			self:update_horde_pacing(t, dt)
			Profiler.stop("horde pacing")
		else
			local pacing_setting = pacing.settings
			self._next_horde_time = t + ConflictUtils.random_interval(pacing_setting.horde_frequency)
		end

		if not script_data.ai_mini_patrol_disabled and self.level_settings.mini_patrol then
			local pacing_state = pacing.pacing_state

			if pacing_state == "pacing_build_up" then
				Profiler.start("mini_patrol")
				self:update_mini_patrol(t, dt)
				Profiler.stop("mini_patrol")
			end
		end

		Profiler.start("hordes")
		self:update_hordes(t, dt)

		if self.horde_spawner then
			self.horde_spawner:update(t, dt)
		end

		Profiler.stop("hordes")
	end

	if self.director_is_ai_ready then
		Profiler.start("TerrorEventMixer")

		local ai_system = Managers.state.entity:system("ai_system")

		TerrorEventMixer.update(t, dt, ai_system.ai_debugger and ai_system.ai_debugger.screen_gui)
		Profiler.stop("TerrorEventMixer")
	elseif not FORM_GROUPS_IN_ONE_FRAME and self.navigation_group_manager.form_groups_running then
		Profiler.start("form_groups_update")

		local done = self.navigation_group_manager:form_groups_update()

		if done then
			self:ai_nav_groups_ready()
		end

		Profiler.stop("form_groups_update")
	end

	if self.enemy_recycler and not script_data.ai_roaming_spawning_disabled and not conflict_settings.roaming.disabled then
		local available_to_spawn = RecycleSettings.max_grunts - #self._spawned

		if available_to_spawn <= 0 then
			threat_population = 0
		end

		self:update_player_areas()
		self.enemy_recycler:update(t, dt, player_positions, threat_population, self._player_areas)
	end

	self:update_spawn_queue(t)

	if self.enemy_recycler and not script_data.ai_far_off_despawn_disabled then
		self.enemy_recycler:far_off_despawn(t, dt, player_positions, self._spawned)
	end

	if script_data.debug_enabled then
		self:update_server_debug(t, dt)
	end
end

ConflictDirector.get_free_flight_pos = function (self)
	local position = nil
	local freeflight_manager = Managers.free_flight
	local data = freeflight_manager.data.global

	if data.viewport_world_name then
		local world = Managers.world:world(data.viewport_world_name)
		local viewport = ScriptWorld.global_free_flight_viewport(world)
		local camera = data.frustum_freeze_camera or ScriptViewport.camera(viewport)
		position = ScriptCamera.position(camera)
	end

	return position
end

ConflictDirector.spawn_queued_unit = function (self, breed, boxed_spawn_pos, boxed_spawn_rot, spawn_category, spawn_animation, spawn_type, inventory_template, group_data, unit_data, archetype_index)
	local spawn_queue = self.spawn_queue
	local spawn_index = self.first_spawn_index + self.spawn_queue_size
	self.spawn_queue_size = self.spawn_queue_size + 1
	self.spawn_queue_id = self.spawn_queue_id + 1
	local data = spawn_queue[spawn_index]

	fassert(breed, "no supplied breed")

	if data then
		data[1] = breed
		data[2] = boxed_spawn_pos
		data[3] = boxed_spawn_rot
		data[4] = spawn_category
		data[5] = spawn_animation
		data[6] = spawn_type
		data[7] = inventory_template
		data[8] = group_data
		data[9] = unit_data
		data[10] = self.spawn_queue_id
		data[11] = archetype_index
	else
		data = {
			breed,
			boxed_spawn_pos,
			boxed_spawn_rot,
			spawn_category,
			spawn_animation,
			spawn_type,
			inventory_template,
			group_data,
			unit_data,
			self.spawn_queue_id,
			archetype_index
		}
		spawn_queue[spawn_index] = data
	end

	return self.spawn_queue_id
end

ConflictDirector.remove_queued_unit = function (self, queue_id)
	local spawn_queue = self.spawn_queue
	local first_spawn_index = self.first_spawn_index
	local spawn_queue_size = self.spawn_queue_size
	local first = self.first_spawn_index
	local last = (first + spawn_queue_size) - 1

	for i = first, last, 1 do
		local d = spawn_queue[i]

		assert(d, "Missing spawn_queue item")

		if d[10] == queue_id then
			local temp = spawn_queue[i]
			spawn_queue[i] = spawn_queue[last]
			spawn_queue[last] = temp
			self.spawn_queue_size = self.spawn_queue_size - 1

			if self.spawn_queue_size == 0 then
				self.first_spawn_index = 1
			end

			return d
		end
	end

	assert(f, "Spawn_queue id not found")
end

ConflictDirector.update_spawn_queue = function (self, t)
	local script_data = script_data

	if script_data.debug_ai_recycler then
		local s = ""

		for i = self.first_spawn_index, (self.first_spawn_index + self.spawn_queue_size) - 1, 1 do
			s = s .. self.spawn_queue[i][10] .. ","
		end

		if self.spawn_queue_size > 0 then
			Debug.text("SPAWN QUEUE: s=" .. self.spawn_queue_size .. " ,i=" .. self.first_spawn_index .. " > " .. s)
		else
			Debug.text("SPAWN QUEUE: s=" .. self.spawn_queue_size .. " ,i=" .. self.first_spawn_index .. " EMPTY")
		end

		local deletion_queue = Managers.state.unit_spawner.deletion_queue

		if deletion_queue.last < deletion_queue.first then
			Debug.text("DELETION QUEUE: [ EMPTY ]")
		else
			Debug.text("DELETION QUEUE: [ " .. deletion_queue.first .. "->" .. deletion_queue.last .. " ]")
		end
	end

	if self.spawn_queue_size > 0 then
		local first_spawn_index = self.first_spawn_index
		local spawn_queue = self.spawn_queue
		local d = spawn_queue[first_spawn_index]
		local unit = self:spawn_unit(d[1], d[2]:unbox(), d[3]:unbox(), d[4], d[5], d[6], d[7], d[8], d[11])
		first_spawn_index = first_spawn_index + 1
		self.spawn_queue_size = self.spawn_queue_size - 1
		local unit_data = d[9]

		if unit_data then
			unit_data[1] = unit
		end

		self.first_spawn_index = first_spawn_index

		if self.spawn_queue_size == 0 then
			self.first_spawn_index = 1
		end
	end
end

local dialogue_system_init_data = {
	faction = "enemy"
}

ConflictDirector.spawn_unit = function (self, breed, spawn_pos, spawn_rot, spawn_category, spawn_animation, spawn_type, inventory_template, group_data, archetype_index)
	Profiler.start("conflict spawn unit")

	local breed_unit_field = (script_data.use_optimized_breed_units and breed.opt_base_unit) or breed.base_unit
	local base_unit_name = (type(breed_unit_field) == "string" and breed_unit_field) or breed_unit_field[math.random(#breed_unit_field)]
	local unit_template = breed.unit_template
	local entity_manager = Managers.state.entity
	local nav_world = entity_manager:system("ai_system"):nav_world()
	local inventory_init_data = nil

	if breed.has_inventory then
		inventory_init_data = {
			inventory_template = inventory_template or breed.default_inventory_template
		}
	end

	local aim_init_data = nil

	if breed.aim_template ~= nil then
		aim_init_data = {
			husk = false,
			template = breed.aim_template
		}
	end

	dialogue_system_init_data.breed_name = breed.name
	local difficulty_rank = Managers.state.difficulty:get_difficulty_rank()

	Profiler.start("create ai extensions")

	local max_health = breed.max_health[difficulty_rank]

	if archetype_index then
		max_health = max_health * breed.heroic_archetypes[archetype_index].health_multiplier
	end

	local extension_init_data = {
		health_system = {
			health = max_health
		},
		ai_system = {
			breed = breed,
			nav_world = nav_world,
			spawn_type = spawn_type,
			spawn_category = spawn_category
		},
		ai_heroic_enemy_system = {
			breed = breed,
			archetype_index = archetype_index
		},
		locomotion_system = {
			nav_world = nav_world
		},
		ai_navigation_system = {
			nav_world = nav_world
		},
		death_system = {
			is_husk = false,
			death_reaction_template = breed.death_reaction,
			disable_second_hit_ragdoll = breed.disable_second_hit_ragdoll
		},
		hit_reaction_system = {
			is_husk = false,
			hit_reaction_template = breed.hit_reaction,
			hit_effect_template = breed.hit_effect_template
		},
		ai_inventory_system = inventory_init_data,
		ai_group_system = group_data,
		dialogue_system = dialogue_system_init_data,
		aim_system = aim_init_data
	}

	if archetype_index then
		extension_init_data.ai_system.override_behaviour = breed.heroic_archetypes[archetype_index].behaviour
	end

	Profiler.stop("create ai extensions")
	Profiler.start("spawn ai_unit")

	local ai_unit, go_id = Managers.state.unit_spawner:spawn_network_unit(base_unit_name, unit_template, extension_init_data, spawn_pos, spawn_rot)

	Profiler.stop("spawn ai_unit")

	local breed_name = breed.name
	local level_settings = self.level_settings

	if level_settings.climate_type then
		Unit.set_flow_variable(ai_unit, "climate_type", level_settings.climate_type)
		Unit.flow_event(ai_unit, "climate_type_set")
	end

	Managers.telemetry.events:ai_spawn(breed.name, spawn_pos)

	local blackboard = Unit.get_data(ai_unit, "blackboard")
	blackboard.spawn_animation = spawn_animation
	blackboard.spawn = true
	BLACKBOARDS[ai_unit] = blackboard
	self._spawned[#self._spawned + 1] = ai_unit
	self._spawned_lookup[ai_unit] = #self._spawned
	self._num_spawned_by_breed[breed_name] = self._num_spawned_by_breed[breed_name] + 1
	self._spawned_units_by_breed[breed_name][ai_unit] = ai_unit

	if self.running_master_event and spawn_category ~= "enemy_recycler" then
		blackboard.event_spawned = true
		self._num_spawned_by_breed_during_event[breed_name] = self._num_spawned_by_breed_during_event[breed_name] + 1
		self._num_spawned_during_event = self._num_spawned_during_event + 1

		Managers.state.event:trigger("ai_unit_spawned", breed_name, blackboard.confirmed_player_sighting, true)
	else
		Managers.state.event:trigger("ai_unit_spawned", breed_name, blackboard.confirmed_player_sighting, false)
	end

	if breed.spawn_stinger then
		local wwise_world = Managers.world:wwise_world(self._world)
		local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, breed.spawn_stinger)

		Managers.state.network.network_transmit:send_rpc_clients("rpc_server_audio_event", NetworkLookup.sound_events[breed.spawn_stinger])
	end

	local locomotion_extension = blackboard.locomotion_extension

	locomotion_extension:ready(go_id, blackboard)
	Profiler.stop("conflict spawn unit")

	return ai_unit
end

ConflictDirector.set_disabled = function (self, state)
	self.disabled = state
end

ConflictDirector.last_spawned_unit = function (self)
	return self._spawned[#self._spawned]
end

ConflictDirector.spawned_units = function (self)
	return self._spawned
end

ConflictDirector.count_units_by_breed = function (self, breed_name)
	return self._num_spawned_by_breed[breed_name]
end

ConflictDirector.spawned_units_by_breed = function (self, breed_name)
	return self._spawned_units_by_breed[breed_name]
end

ConflictDirector.count_units_by_breed_during_event = function (self, breed_name)
	return self._num_spawned_by_breed_during_event[breed_name]
end

ConflictDirector.add_unit_to_bosses = function (self, unit)
	self._alive_bosses[#self._alive_bosses + 1] = unit
end

ConflictDirector.remove_unit_from_bosses = function (self, unit)
	remove_element_from_array(self._alive_bosses, unit)
end

ConflictDirector._remove_unit_from_spawned = function (self, unit, blackboard)
	local spawned_lookup = self._spawned_lookup
	local index = spawned_lookup[unit]
	BLACKBOARDS[unit] = nil

	if not index then
		printf("ERROR: REMOVE UNIT FROM SPAWNED:(traceback) %q", tostring(unit))
		print(Unit.get_data(unit, "traceback"))
		print(Script.callstack())

		return
	end

	local breed = blackboard.breed

	if blackboard.spawn_type == "horde" or blackboard.spawn_type == "horde_hidden" then
		self:add_horde(-1)
	end

	local spawned = self._spawned
	local index_last = #spawned
	spawned_lookup[unit] = nil

	if index == index_last then
		spawned[index_last] = nil
	else
		local swap_unit = spawned[index_last]
		spawned[index] = swap_unit
		spawned[index_last] = nil
		spawned_lookup[swap_unit] = index
	end

	local breed_name = breed.name
	self._num_spawned_by_breed[breed_name] = self._num_spawned_by_breed[breed_name] - 1
	self._spawned_units_by_breed[breed_name][unit] = nil

	if blackboard.event_spawned then
		self._num_spawned_by_breed_during_event[breed_name] = self._num_spawned_by_breed_during_event[breed_name] - 1
		self._num_spawned_during_event = self._num_spawned_during_event - 1
	end

	if breed.special then
		remove_element_from_array(self._alive_specials, unit)
	end

	Managers.state.event:trigger("ai_unit_despawned", breed_name, blackboard.confirmed_player_sighting, blackboard.event_spawned)
end

ConflictDirector.register_unit_killed = function (self, unit, blackboard, killer_unit, killing_blow)
	self:_remove_unit_from_spawned(unit, blackboard)
	self.pacing:enemy_killed(unit, player_and_bot_units)

	local breed_name = blackboard.breed.name
	local death_pos = POSITION_LOOKUP[unit]

	Managers.telemetry.events:ai_death(breed_name, death_pos)
end

ConflictDirector.destroy_unit = function (self, unit, blackboard, reason)
	if Unit.alive(unit) then
		local breed_name = blackboard.breed.name
		local despawn_pos = POSITION_LOOKUP[unit]

		Managers.telemetry.events:ai_despawn(breed_name, despawn_pos, reason)
		self:_remove_unit_from_spawned(unit, blackboard)
		Managers.state.unit_spawner:mark_for_deletion(unit)
	end
end

ConflictDirector.destroy_all_units = function (self)
	print("ConflictDirector - destroy all units")

	local network_manager = Managers.state.network

	if not network_manager:game() then
		return
	end

	for k, unit in ipairs(self._spawned) do
		if Unit.alive(unit) then
			local reason = "destroy_all_units"
			local breed = Unit.get_data(unit, "breed")
			local breed_name = breed.name
			local despawn_pos = POSITION_LOOKUP[unit]

			Managers.telemetry.events:ai_despawn(breed_name, despawn_pos, reason)
			Managers.state.unit_spawner:mark_for_deletion(unit)
		end
	end

	Managers.state.event:trigger("ai_units_all_destroyed")
	table.clear(self._spawned)
	table.clear(self._spawned_lookup)
	table.clear(self._alive_specials)
	table.clear(self._alive_bosses)

	self._living_horde = 0

	self:reset_spawned_by_breed()
	self:reset_spawned_by_breed_during_event()
end

ConflictDirector.destroy_close_units = function (self, except_unit, dist_squared)
	local network_manager = Managers.state.network

	if not network_manager:game() then
		return
	end

	print("debug destroy close units")

	local player_manager = Managers.player
	local player = player_manager:player_from_peer_id(Network.peer_id())
	local player_unit = player.player_unit
	local player_pos = Unit.local_position(player_unit, 0)
	local spawned = self._spawned
	local list_size = #spawned
	local i = 1

	while list_size >= i do
		local unit = spawned[i]
		local remove_unit = nil

		if unit_alive(unit) and unit ~= except_unit then
			local unit_pos = Unit.local_position(unit, 0)
			remove_unit = distance_squared(player_pos, unit_pos) < dist_squared
		else
			remove_unit = false
		end

		if remove_unit then
			local blackboard = Unit.get_data(unit, "blackboard")
			local reason = "destroy_close_units"
			local breed_name = blackboard.breed.name
			local despawn_pos = POSITION_LOOKUP[unit]

			Managers.telemetry.events:ai_despawn(breed_name, despawn_pos, reason)
			self:_remove_unit_from_spawned(unit, blackboard)

			list_size = list_size - 1

			Managers.state.unit_spawner:mark_for_deletion(unit)
		else
			i = i + 1
		end
	end
end

ConflictDirector.destroy_specials = function (self)
	print("debug destroy specials")

	local alive_specials = self._alive_specials
	local num_alive_specials = #alive_specials

	for k = num_alive_specials, 1, -1 do
		local unit = alive_specials[k]

		if Unit.alive(unit) then
			local reason = "destroy_specials"
			local breed = Unit.get_data(unit, "breed")
			local breed_name = breed.name
			local despawn_pos = POSITION_LOOKUP[unit]

			Managers.telemetry.events:ai_despawn(breed_name, despawn_pos, reason)

			local blackboard = Unit.get_data(unit, "blackboard")

			self:_remove_unit_from_spawned(unit, blackboard)
			Managers.state.unit_spawner:mark_for_deletion(unit)
		end
	end

	assert(#self._alive_specials == 0, "Something bad happend when debug despawned all specials")

	for _, player_unit in ipairs(player_and_bot_units) do
		local status_extension = ScriptUnit.extension(player_unit, "status_system")

		if status_extension.pack_master_status and status_extension.pack_master_status == "pack_master_hanging" then
			StatusUtils.set_grabbed_by_pack_master_network("pack_master_dropping", player_unit, true, nil)
		end
	end
end

ConflictDirector.debug_spawn_switch_breed = function (self, t)
	self._show_switch_breed = t + 1
	self._debug_breed = next(Breeds, self._debug_breed)

	while not self._debug_breed do
		self._debug_breed = next(Breeds, self._debug_breed)
	end

	print("Current breed: " .. self._debug_breed)
end

ConflictDirector.debug_spawn_breed = function (self, t, delayed, override_pos)
	if not self._debug_breed then
		self._debug_breed = next(Breeds, self._debug_breed)
	end

	self._show_switch_breed = t + 1

	print("Debug spawning: " .. self._debug_breed)

	local pos = self:aim_spawning(Breeds[self._debug_breed], false, delayed, override_pos)

	return pos
end

ConflictDirector.debug_spawn_breed_at_hidden_spawner = function (self, t)
	if not self._debug_breed then
		self._debug_breed = next(Breeds, self._debug_breed)
	end

	self._show_switch_breed = t + 1

	print("Debug spawning from hidden spawner: " .. self._debug_breed)

	local center_pos = player_positions[1]

	if center_pos then
		local spawner = ConflictUtils.get_random_hidden_spawner(center_pos, 40)

		if not spawner then
			print("No hidden spawner units found")

			return
		end

		local spawn_pos = Unit.local_position(spawner, 0)
		local spawn_category = "debug_spawn"
		local rot = Quaternion(Vector3.up(), math.degrees_to_radians(Math.random(1, 360)))
		slot7 = self:spawn_unit(Breeds[self._debug_breed], spawn_pos, rot, spawn_category, nil)
	end
end

ConflictDirector.debug_spawn_group = function (self, t)
	if not self._debug_breed then
		self._debug_breed = next(Breeds, self._debug_breed)
	end

	self._show_switch_breed = t + 1

	print("Spawning group: " .. self._debug_breed)
	self:aim_spawning_group(Breeds[self._debug_breed], true)
end

ConflictDirector.debug_spawn_group_at_main_path = function (self, main_path_index, sub_node_index)
	local breed = Breeds.skaven_storm_vermin
	breed.far_off_despawn_immunity = true
	local patrol_template = "storm_vermin_formation_patrol"
	RecycleSettings.destroy_los_distance_squared = math.huge
	local main_paths = self.main_path_info.main_paths
	local main_path = (main_path_index and main_paths[main_path_index]) or main_paths[Math.random(1, #main_paths)]
	local sub_node = (sub_node_index and main_path.nodes[sub_node_index]) or main_path.nodes[Math.random(1, #main_path.nodes)]
	Debug.storm_vermin_patrols_done = nil

	self:spawn_group(breed, true, patrol_template, sub_node:unbox())
end

ConflictDirector.debug_spawn_horde = function (self)
	if self.in_safe_zone then
		print("Can't spawn horde in safe zone")

		return
	end

	if script_data.use_old_horde_system then
		if not script_data.ai_horde_spawning_disabled then
			self._next_horde_time = 0

			Debug.sticky_text("Spawning Horde")
		else
			Debug.sticky_text("You need to set 'ai_horde_spawning_disabled' to false")
		end
	else
		self.horde_spawner:horde()
	end
end

ConflictDirector.debug_outside_navmesh_intervention = function (self, t)
	local entity_manager = Managers.state.entity
	local ai_system = entity_manager:system("ai_system")
	local ai_slot_system = entity_manager:system("ai_slot_system")
	local outside_navmesh = false
	local num_players = #player_and_bot_units

	for i = 1, num_players, 1 do
		local player_unit = player_and_bot_units[i]

		if ai_slot_system:has_target_been_outside_navmesh_too_long(player_unit, t) then
			outside_navmesh = true

			break
		end
	end

	local outside_navmesh_intervention = CurrentSpecialsSettings.outside_navmesh_intervention
	local needed_ordinary_enemy_aggro = outside_navmesh_intervention.needed_ordinary_enemy_aggro
	local needed_special_enemy_aggro = outside_navmesh_intervention.needed_special_enemy_aggro
	local boss_spawned = self:boss_event_running()
	local num_ordinary_enemies_aggro = ai_system.number_ordinary_aggroed_enemies
	local num_special_enemies_aggro = ai_system.number_special_aggored_enemies
	local player_eligible_for_punish = boss_spawned or needed_ordinary_enemy_aggro <= num_ordinary_enemies_aggro or needed_special_enemy_aggro <= num_special_enemies_aggro
	local data = self.outside_navmesh_intervention_data
	local outside_unit = data.outside_unit

	if unit_alive(outside_unit) then
		local player_manager = Managers.player
		local player = player_manager:unit_owner(outside_unit)
		data.outside_unit_name = player:profile_display_name()
	else
		data.outside_unit_name = "?"
	end

	local countdown = math.clamp(self._next_outside_navmesh_intervention_time - t, 0, 999999)

	if data.disabled then
		Debug.text("Outside Navmesh: %s ", data.disabled)
	else
		Debug.text("Outside Navmesh Intervention: Enough aggro = %s, Outside navmesh = %s, Number aggroed (%d ordinary, %d special, boss = %s) - %s (%s) time: %.1f ", tostring(player_eligible_for_punish), tostring(outside_navmesh), num_ordinary_enemies_aggro, num_special_enemies_aggro, tostring(boss_spawned), data.outside_unit_name, tostring(data.message), countdown)
	end
end

ConflictDirector.player_aim_raycast = function (self, world, only_breed, filter)
	local player_manager = Managers.player
	local player = player_manager:local_player(1)
	local player_unit = player.player_unit
	local result = nil
	local in_free_flight = Managers.free_flight:active("global")

	if in_free_flight then
		local input_service = Managers.free_flight.input_manager:get_service("FreeFlight")
		local data = Managers.free_flight.data.global
		local world = Managers.world:world(data.viewport_world_name)
		local physics_world = World.get_data(world, "physics_world")
		local viewport = ScriptWorld.global_free_flight_viewport(world)
		local camera = data.frustum_freeze_camera or ScriptViewport.camera(viewport)
		local mouse = input_service:get("cursor")
		local position = Camera.screen_to_world(camera, Vector3(mouse.x, mouse.y, 0), 0)
		local direction = Camera.screen_to_world(camera, Vector3(mouse.x, mouse.y, 0), 1) - position
		local raycast_dir = Vector3.normalize(direction)
		result = PhysicsWorld.immediate_raycast(physics_world, position, raycast_dir, 100, "all", "collision_filter", filter)
	else
		local camera_position = Managers.state.camera:camera_position(player.viewport_name)
		local camera_rotation = Managers.state.camera:camera_rotation(player.viewport_name)
		local camera_direction = Quaternion.forward(camera_rotation)
		local filter = filter or "filter_ray_projectile"
		local physics_world = World.get_data(world, "physics_world")
		result = PhysicsWorld.immediate_raycast(physics_world, camera_position, camera_direction, 100, "all", "collision_filter", filter)
	end

	if result then
		local num_hits = #result

		for i = 1, num_hits, 1 do
			local hit = result[i]
			local hit_actor = hit[4]
			local hit_unit = Actor.unit(hit_actor)
			local attack_hit_self = hit_unit == player_unit

			if not attack_hit_self then
				local breed = Unit.get_data(hit_unit, "breed")

				if only_breed then
					if breed then
						return breed, hit[1], hit[2], hit[3], hit[4]
					end
				else
					return hit[1], hit[2], hit[3], hit[4]
				end
			end
		end
	end

	return nil
end

ConflictDirector.aim_spawning = function (self, breed, on_navmesh, optional_delayed, optional_override_pos)
	local position, distance, normal, actor = self:player_aim_raycast(self._world, false, "filter_ray_horde_spawn")

	if optional_delayed then
		return position
	elseif optional_override_pos then
		position = optional_override_pos
	end

	if not position then
		return
	end

	local spawn_pos = nil

	if on_navmesh then
		spawn_pos = LocomotionUtils.pos_on_mesh(self.nav_world, pos)
	else
		spawn_pos = position
	end

	local spawn_category = "debug_spawn"
	local rot = Quaternion(Vector3.up(), math.degrees_to_radians(Math.random(1, 360)))
	local archetype_index = nil
	local debug_archetype = 1

	if debug_archetype then
		print(breed)

		if breed.heroic_archetypes then
			if breed.heroic_archetypes[debug_archetype] then
				archetype_index = debug_archetype
			else
				archetype_index = Math.random(1, #breed.heroic_archetypes)
			end
		end
	end

	local unit = self:spawn_unit(breed, spawn_pos, rot, spawn_category, nil, nil, nil, nil, archetype_index)

	if breed.special then
		self._alive_specials[#self._alive_specials + 1] = unit
	end

	local entity_manager = Managers.state.entity
	local ai_system = entity_manager:system("ai_system")

	if ai_system.ai_debugger and not AiUtils.unit_alive(ai_system.ai_debugger.active_unit) and not script_data.ai_disable_auto_ai_debugger_target then
		ai_system.ai_debugger.active_unit = unit
		script_data.debug_unit = unit
	end
end

ConflictDirector.aim_spawning_group = function (self, breed, on_navmesh)
	local position, distance, normal, actor = self:player_aim_raycast(self._world, false, "filter_ray_horde_spawn")

	if not position then
		return
	end

	if breed == Breeds.skaven_clan_rat or breed == Breeds.skaven_slave then
		self:spawn_group(breed, on_navmesh, nil, position, 50, true)
	else
		self:spawn_group(Breeds.skaven_storm_vermin, on_navmesh, "storm_vermin_formation_patrol", position)
	end
end

local spawn_group_positions = {}

ConflictDirector.spawn_group = function (self, breed, on_navmesh, patrol_template, optional_pos, optional_wanted_size, spawn_in_grid)
	local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
	local wanted_size = optional_wanted_size or difficulty_settings.amount_storm_vermin_patrol
	local num_attempts = 8
	local group_size = 0
	local grid_size = math.ceil(math.sqrt(wanted_size))

	for i = 1, wanted_size, 1 do
		local spawn_pos = nil

		for j = 1, num_attempts, 1 do
			local offset = Vector3(4 * math.random() - 2, 4 * math.random() - 2, 0)

			if spawn_in_grid and j == 1 then
				offset = Vector3(-grid_size / 2 + i % grid_size, -grid_size / 2 + math.floor(i / grid_size), 0)
			end

			if on_navmesh then
				spawn_pos = LocomotionUtils.pos_on_mesh(self.nav_world, optional_pos + offset)
			else
				spawn_pos = optional_pos + offset
			end

			if spawn_pos then
				group_size = group_size + 1
				spawn_group_positions[group_size] = spawn_pos

				break
			end
		end
	end

	if group_size > 0 then
		local group_data = nil

		if patrol_template then
			group_data = {
				id = Managers.state.entity:system("ai_group_system"):generate_group_id(),
				template = patrol_template,
				size = group_size
			}
		end

		local spawn_category = "patrol"
		local rot = Quaternion(Vector3.up(), math.degrees_to_radians(Math.random(1, 360)))

		for i = 1, group_size, 1 do
			local spawn_pos = spawn_group_positions[i]

			self:spawn_queued_unit(breed, Vector3Box(spawn_pos), QuaternionBox(rot), spawn_category, nil, nil, nil, group_data)
		end
	end
end

ConflictDirector.spawn_one = function (self, breed, optional_pos, archetype_index)
	local spawn_category = "spawn_one"
	local center_pos = player_positions[1]
	local spawn_pos = optional_pos or ConflictUtils.get_spawn_pos_on_circle(self.nav_world, center_pos, 20, 8, 30)

	if spawn_pos then
		local rot = Quaternion(Vector3.up(), math.degrees_to_radians(Math.random(1, 360)))
		local unit = self:spawn_queued_unit(breed, Vector3Box(spawn_pos), QuaternionBox(rot), spawn_category, nil, nil, nil, nil, nil, archetype_index)

		return unit
	end
end

ConflictDirector.spawn_at_raw_spawner = function (self, breed, archetype_index, spawner_id)
	local spawner_system = Managers.state.entity:system("spawner_system")
	local spawner_unit = spawner_system:get_raw_spawner_unit(spawner_id)

	if spawner_unit then
		local pos = Unit.local_position(spawner_unit, 0)
		local rot = Unit.local_rotation(spawner_unit, 0)
		local ai_unit = self:spawn_unit(breed, pos, rot, "raw_spawner", nil, nil, nil, nil, archetype_index)

		if PLATFORM ~= "win32" then
			Managers.state.entity:system("play_go_tutorial_system"):register_unit(spawner_unit, ai_unit)
		end
	end
end

ConflictDirector.generate_spawns = function (self)
	local pos_list, pack_sizes, pack_rotations = nil
	local _, finish_point = self.level_analysis:get_start_and_finish()

	assert(finish_point, "Missing path marker at the end of the level")

	local triangle = GwNavTraversal.get_seed_triangle(self.nav_world, finish_point:unbox())

	assert(triangle, "The path marker at the end of the level is outside the navmesh")
	self.navigation_group_manager:setup(self._world, self.nav_world)

	if FORM_GROUPS_IN_ONE_FRAME then
		print("Forming navigation groups in one frame")
		self.navigation_group_manager:form_groups(nil, finish_point)
	else
		self.navigation_group_manager:form_groups_start(nil, finish_point)
	end

	if CurrentConflictSettings.roaming.disabled then
		print("roaming spawning is disabled")

		return {}
	end

	if self.spawn_zone_baker.spawn_zones_available then
		local goal_density = 0.5
		local spawn_cycle_length = PackSpawningSettings.spawn_cycle_length
		local area_density_coefficient = PackSpawningSettings.area_density_coefficient * 0.01
		local length_density_coefficient = PackSpawningSettings.length_density_coefficient
		pos_list, pack_sizes, pack_rotations = self.spawn_zone_baker:generate_spawns(spawn_cycle_length, goal_density, area_density_coefficient, length_density_coefficient)

		return pos_list, pack_sizes, pack_rotations
	else
		print("This level is missing spawn_zones. No roaming enemies will spawn at all.")
	end

	pos_list = {}

	return pos_list
end

ConflictDirector.register_main_path_obstacle = function (self, position, radius_sq)
	local obstacles = self._main_path_obstacles
	obstacles[#obstacles + 1] = {
		position = position,
		radius_sq = radius_sq
	}
end

ConflictDirector.ai_ready = function (self)
	local t = Managers.time:time("game")

	if CurrentConflictSettings.disabled then
		Managers.state.event:trigger("conflict_director_setup_done")

		return
	end

	print("[ConflictDirector] conflict_director is ai_ready")

	self.level_settings = LevelHelper:current_level_settings()
	local entity_manager = Managers.state.entity
	self.nav_world = entity_manager:system("ai_system"):nav_world()
	self.nav_tag_volume_handler = NavTagVolumeHandler:new(self._world, self.nav_world)
	self.level_analysis.nav_world = self.nav_world
	self.level_analysis.level_settings = self.level_settings
	self.spawn_zone_baker = SpawnZoneBaker:new(self._world, self.nav_world, self.level_analysis)

	if self.spawn_zone_baker:loaded_spawn_zones_available() then
	else
		local result = self.level_analysis:generate_main_path()

		self.level_analysis:remove_crossroads_extra_path_branches()

		if result ~= "success" then
			Debug.sticky_text("Level fail: %s", result, "delay", 20)

			return
		end
	end

	self.main_path_info.main_paths = self.level_analysis:get_main_paths()
	local granularity = 3
	local forward_nodes, reversed_nodes, forward_break_nodes, reversed_break_nodes = MainPathUtils.node_list_from_main_paths(self.nav_world, self.main_path_info.main_paths, granularity, self._main_path_obstacles)
	self.main_path_info.merged_main_paths = {
		forward_list = forward_nodes,
		reversed_list = reversed_nodes,
		forward_break_list = forward_break_nodes,
		reversed_break_list = reversed_break_nodes
	}
	self.specials_pacing = SpecialsPacing:new(self.nav_world)
	local start = {
		self.level_analysis:get_start_and_finish()
	}

	assert(start, "The path marker at the start of level is outside nav mesh")

	self._spawn_pos_list, self._pack_sizes, self._pack_rotations = self:generate_spawns()

	if FORM_GROUPS_IN_ONE_FRAME then
		self:ai_nav_groups_ready()
	end
end

ConflictDirector.ai_nav_groups_ready = function (self)
	self.enemy_recycler = EnemyRecycler:new(self._world, self.nav_world, self._spawn_pos_list, self._pack_sizes, self._pack_rotations)

	self.level_analysis:set_enemy_recycler(self.enemy_recycler)

	self.horde_spawner = HordeSpawner:new(self._world, self.level_analysis.cover_points_broadphase)
	local insert_bosses = self.spawn_zone_baker:loaded_spawn_zones_available()

	if insert_bosses then
		self.level_analysis:generate_boss_paths()
	end

	self.in_safe_zone = true
	self.director_is_ai_ready = true

	Managers.state.event:trigger("conflict_director_setup_done")
	self:create_debug_list()
end

ConflictDirector.reset_spawn_debug_values = function (self, ai_horde_debugging_disabled)
	self._spawn_debug_table = {}
	self._ai_horde_debugging_disabled_prev = ai_horde_debugging_disabled
end

ConflictDirector.a_star_area_pos_search = function (self, p1, p2)
	local tri1 = GwNavTraversal.get_seed_triangle(self.nav_world, p1)
	local tri2 = GwNavTraversal.get_seed_triangle(self.nav_world, p2)

	if not tri1 or not tri2 then
		return false
	end

	local group1 = self.navigation_group_manager:get_polygon_group(tri1)
	local group2 = self.navigation_group_manager:get_polygon_group(tri2)

	if group1 and group2 then
		local path, dist = self.navigation_group_manager:a_star_cached(group1, group2)

		return path, dist
	end
end

ConflictDirector.freeze_intensity_decay = function (self, freeze_time)
	self.frozen_intensity_decay_until = self._time + freeze_time
end

ConflictDirector.intensity_decay_frozen = function (self, freeze_time)
	return self._time < self.frozen_intensity_decay_until
end

ConflictDirector.boss_event_running = function (self)
	return self._num_spawned_by_breed.skaven_rat_ogre > 0
end

ConflictDirector.level_flow_event = function (self, event_name)
	LevelHelper:flow_event(self._world, event_name)
end

ConflictDirector.update_server_debug = function (self, t, dt)
	Profiler.start("Conflict Server Debug")
	ConflictDirectorTests.update(self, t, dt)

	if DebugKeyHandler.key_pressed("y", "test cover points", "ai", "left shift") then
		if false then
			local bp = self.level_analysis.cover_points_broadphase
			local green = Color(255, 0, 240, 0)
			local red = Color(255, 240, 0, 0)
			local found_units = {}

			Broadphase.query(bp, player_positions[1], 20, found_units)

			local player_pos = player_positions[1]

			for i = 1, #found_units, 1 do
				local unit = found_units[i]
				local pos = Unit.local_position(unit, 0)
				local rot = Unit.local_rotation(unit, 0)
				local to_cover_point = Vector3.normalize(player_pos - pos)
				local valid = Vector3.dot(Quaternion.forward(rot), to_cover_point) > 0.9

				if valid then
					QuickDrawerStay:sphere(pos, 1, green)
					QuickDrawerStay:line(pos + Vector3(0, 0, 1), pos + Quaternion.forward(rot) * 2 + Vector3(0, 0, 1), green)
				else
					QuickDrawerStay:sphere(pos, 1, red)
					QuickDrawerStay:line(pos + Vector3(0, 0, 1), pos + Quaternion.forward(rot) * 2 + Vector3(0, 0, 1), red)
				end
			end
		end

		self.specials_pacing:get_special_spawn_pos()
	end

	if DebugKeyHandler.key_pressed("t", "test terror", "ai", "left shift") then
		self.specials_pacing:get_spawn_pos_from_zone(30)

		return

		local debug_breed = Breeds[self._debug_breed]

		if debug_breed == Breeds.skaven_clan_rat or debug_breed == Breeds.skaven_slave or debug_breed == Breeds.skaven_storm_vermin then
			TerrorEventMixer.start_event("steady_70_horde")
		else
			Debug.sticky_text("Can't spawn horde of breed type %s", self._debug_breed)
		end
	end

	if DebugKeyHandler.key_pressed("f", "toggle debug graphs", "ai", "left shift") then
		local size = #self._debug_list

		for i = 2, size, 1 do
			local a = self._debug_list[i]

			a:show_debug(false)
		end

		for i = 1, size, 1 do
			local index = self._current_debug_list_index % size + 1

			if index == 1 then
				self._current_debug_list_index = index

				break
			else
				local a = self._debug_list[index]

				if a:show_debug(true) then
					self._current_debug_list_index = index

					break
				end
			end
		end
	end

	if DebugKeyHandler.key_pressed("g", "execute debug graphs", "ai", "left shift") then
		local f = self._debug_list[self._current_debug_list_index]

		if f and f.execute_debug then
			f:execute_debug()
		end
	end

	ConflictUtils.debug_update()

	if script_data.show_alive_ai then
		Profiler.start("show_alive_ai")
		ConflictUtils.display_number_of_breeds("TOTAL: ", #self._spawned, self._num_spawned_by_breed)

		if self.running_master_event then
			local num_spawned = 0

			for breed_name, amount in pairs(self._num_spawned_by_breed_during_event) do
				num_spawned = num_spawned + amount
			end

			ConflictUtils.display_number_of_breeds("EVENT: ", num_spawned, self._num_spawned_by_breed_during_event)
		end

		Profiler.stop("show_alive_ai")
	end

	if script_data.show_where_ai_is then
		ConflictUtils.show_where_ai_is(self._spawned)
	end

	local ai_horde_debugging_disabled = script_data.ai_horde_spawning_debugging_disabled

	if ai_horde_debugging_disabled ~= self._ai_horde_debugging_disabled_prev then
		self:reset_spawn_debug_values(ai_horde_debugging_disabled)
		ConflictUtils.reset_spawn_debug_values()
	end

	if self.director_is_ai_ready then
		self.navigation_group_manager:print_groups(self._world, self.nav_world)
	end

	local world_gui = self.world_gui
	local m = Matrix4x4.identity()
	local font_size = 0.1
	local font = "gw_arial_32"
	local font_material = "materials/fonts/" .. font

	for i, spawn_point in ipairs(self._spawn_debug_table) do
		local pos = spawn_point[1]:unbox()
		local total_units = spawn_point[2]
		local point_type = spawn_point[3]
		local offset = (point_type == "backup" and 2.4) or 2
		pos = Vector3(pos.x, pos.z + offset, pos.y)

		Gui.text_3d(world_gui, point_type, font_material, font_size, font, m, pos, 1, Color(255, 0, 220, 0))
		Gui.text_3d(world_gui, total_units .. " units", font_material, font_size, font, m, pos - Vector3(0, 0.1, 0), 1, Color(255, 0, 220, 0))
	end

	if self._debug_breed == nil then
		self._debug_breed = next(Breeds)
	end

	if DebugKeyHandler.key_pressed("o", "switch spawn breed", "ai") then
		self:debug_spawn_switch_breed(t)
	end

	if self._show_switch_breed and t < self._show_switch_breed and not script_data.disable_debug_draw then
		Debug.text("Breeds: " .. self._debug_breed)

		for breed_name, breed in pairs(Breeds) do
			if breed_name == self._debug_breed then
				Debug.text(" > " .. breed_name:upper())
			else
				Debug.text("     " .. breed_name)
			end
		end

		local entity_manager = Managers.state.entity
		local ai_system = entity_manager:system("ai_system")
		local res_x = RESOLUTION_LOOKUP.res_w
		local res_y = RESOLUTION_LOOKUP.res_h
		local opacity = math.min(1, (1 - math.cos((self._show_switch_breed - t) * math.pi)) * 5)

		Gui.rect(ai_system.ai_debugger.screen_gui, Vector3(5, res_y - 550, 0), Vector3(350, 500, 0), Color(230 * opacity, 10, 10, 10))
	end

	if DebugKeyHandler.key_pressed("p", "spawn " .. self._debug_breed, "ai", "left ctrl") then
		self:debug_spawn_group(t)
	elseif DebugKeyHandler.key_pressed("p", "spawn " .. self._debug_breed, "ai", "left alt") then
		self:debug_spawn_group_at_main_path(nil, nil)
	elseif DebugKeyHandler.key_pressed("p", "spawn " .. self._debug_breed, "ai") then
		self:debug_spawn_breed(t)
	elseif DebugKeyHandler.key_pressed("p", "spawn " .. self._debug_breed, "ai", "left shift") then
		local pos = self:debug_spawn_breed(t, true)

		if pos then
			self._debug_spawn_breed_pos = Vector3Box(pos)
			self._debug_spawn_breed_delayed = t + 3
		end
	elseif DebugKeyHandler.key_pressed("o", "spawn hidden " .. self._debug_breed, "ai", "left ctrl") then
		self:debug_spawn_breed_at_hidden_spawner(t)
	end

	if self._debug_spawn_breed_delayed and self._debug_spawn_breed_delayed < t then
		self._debug_spawn_breed_delayed = nil

		self:debug_spawn_breed(t, false, self._debug_spawn_breed_pos:unbox())
	end

	if DebugKeyHandler.key_pressed("i", "unspawn all AIs", "ai") then
		self:destroy_all_units()
	end

	if DebugKeyHandler.key_pressed("u", "unspawn close AIs", "ai") then
		self:destroy_close_units(nil, 144)
	end

	if DebugKeyHandler.key_pressed("m", "unspawn all AI specials", "ai") then
		self:destroy_specials()
	end

	if DebugKeyHandler.key_pressed("o", "draw spawn zones", "ai", "left shift") then
		local d = self.draw_all_zones
		d = (d == nil and "all") or (d == "all" and "last") or (d == "last" and "last_naive") or (d == "last_naive" and nil)

		if d == "all" then
			self.spawn_zone_baker:draw_zones(self.nav_world)
		elseif d == "last_naive" then
		elseif d == "last" then
		else
			self.spawn_zone_baker:draw_zones(self.nav_world)
		end

		self.draw_all_zones = d
	end

	local draw_all_zones = self.draw_all_zones

	if draw_all_zones ~= "nil" then
		if draw_all_zones == "all" then
			Debug.text("Draw Zone-segment (all)")
		elseif draw_all_zones == "last" then
			local main_paths = self.level_analysis:get_main_paths()
			local dist = self.main_path_info.ahead_travel_dist or 0
			local index = self.spawn_zone_baker:find_zone_index(dist)

			if index then
				Debug.text("Draw Zone-segment: %d (last) travel_dist: %.1f", index, dist)
				self.spawn_zone_baker:draw_zones(self.nav_world, index)
			else
				Debug.text("Draw Zone-segment not precalculated (last)")
			end
		elseif draw_all_zones == "last_naive" then
			local main_paths = self.level_analysis:get_main_paths()
			local index = MainPathUtils.zone_segment_on_mainpath(main_paths, PLAYER_POSITIONS[1])

			self.spawn_zone_baker:draw_zones(self.nav_world, index)
			Debug.text("Draw Zone-segment: %d (last_naive)", index)
		end
	end

	if script_data.debug_ai_pacing then
		if DebugKeyHandler.key_pressed("numpad_plus", "Increase intensity +25", "Pacing & Intensity") then
			pacing:debug_add_intensity(player_and_bot_units, 25)
		end

		if DebugKeyHandler.key_pressed("numpad_minus", "Decrease intensity -25", "Pacing & Intensity") then
			pacing:debug_add_intensity(player_and_bot_units, -25)
		end

		Debug.text("Total enemies alive: " .. tostring(#self._spawned))
	end

	if script_data.debug_rush_intervention then
		local data = self.rushing_intervention_data

		if unit_alive(data.ahead_unit) then
			data.ahead_unit_name = Managers.player:unit_owner(data.ahead_unit):profile_display_name()
		else
			data.ahead_unit_name = "?"
		end

		local countdown = math.clamp(self._next_rushing_intervention_time - t, 0, 999999)
		local rush_intervention = CurrentSpecialsSettings.rush_intervention

		if data.disabled then
			Debug.text("Rusher: %s ", data.disabled)
		else
			Debug.text("Rusher: %s loneliness: %.1f / ( special: %.1f, horde: %.1f ) (%s) ahead-dist: %.1f, time: %.1f ", data.ahead_unit_name, data.loneliness_value, rush_intervention.loneliness_value_for_special, rush_intervention.loneliness_value_for_ambush_horde, tostring(data.message), data.ahead_dist, countdown)
		end
	end

	if not self.in_safe_zone and script_data.debug_outside_navmesh_intervention then
		self:debug_outside_navmesh_intervention(t)
	end

	local test = false

	if test then
		if DebugKeyHandler.key_pressed("r", "test", "ai") then
			print("ASTAR")

			local start, goal = self.level_analysis:get_start_and_finish()
			local tri1 = GwNavTraversal.get_seed_triangle(self.nav_world, player_positions[1])
			local tri2 = GwNavTraversal.get_seed_triangle(self.nav_world, goal:unbox())

			if not tri1 or not tri2 then
				return false
			end

			local group1 = self.navigation_group_manager:get_polygon_group(tri1)
			local group2 = self.navigation_group_manager:get_polygon_group(tri2)
			local nav_groups = self.navigation_group_manager._navigation_groups
			local path, length = LuaAStar.a_star_plain(nav_groups, group1, group2)
			self.path = path

			print("Generated path:", #path, length)
		end

		if self.path then
			local path = self.path
			local old_pos = nil

			for i = 1, #path, 1 do
				local pos = path[i]:get_group_center():unbox()

				QuickDrawer:sphere(pos, 2)

				if old_pos then
					QuickDrawer:line(pos + Vector3(0, 0, 1), old_pos + Vector3(0, 0, 1), Color(255, 244, 143, 7))
				end

				old_pos = pos
			end
		end
	end

	if DebugKeyHandler.key_pressed("h", "spawn_horde", "ai") then
		self:debug_spawn_horde()
	end

	if script_data.debug_ai_pacing then
		for unit, data in pairs(self._rushing_checks) do
			ConflictUtils.draw_stack_of_balls(data.start_pos:unbox(), 255, 255, 30, 0)

			local path_data = self.main_path_player_info[unit]

			if path_data.path_pos then
				ConflictUtils.draw_stack_of_balls(path_data.path_pos:unbox(), 255, 30, 255, 0)
			end
		end
	end

	if script_data.debug_near_cover_points then
		ConflictUtils.hidden_cover_points(player_positions[1], PLAYER_POSITIONS, 1, 35, nil)
	end

	if script_data.debug_player_positioning then
		local cluster_utility, lonliness_pos, loneliness_value, lonliest_player_unit = self:get_cluster_and_loneliness(10)

		if lonliest_player_unit then
			QuickDrawer:sphere(position_lookup[lonliest_player_unit], 0.88)
		end

		local cluster_radius = 7
		local clusters, sizes = ConflictUtils.cluster_positions(player_and_bot_positions, cluster_radius)

		for i = 1, #clusters, 1 do
			QuickDrawer:sphere(clusters[i], cluster_radius)

			for j = 1, sizes[i], 1 do
				QuickDrawer:sphere(clusters[i] + Vector3(0, 0, 2 + j), 0.6)
			end
		end

		local main_path_info = self.main_path_info
		local ahead_unit = main_path_info.ahead_unit
		local dist_to_intervention = 0

		for slot24, slot25 in pairs(self.main_path_player_info) do
		end

		if ahead_unit then
			local player_info = self.main_path_player_info[ahead_unit]
			dist_to_intervention = self._rushing_intervention_travel_dist - player_info.travel_dist
			local path_pos = player_info.path_pos:unbox()
			local color = Color(0, 200, 30)
			local player_pos = POSITION_LOOKUP[ahead_unit]
			local a2 = path_pos + Vector3(0, 0, 0.5)
			local a3 = path_pos + Vector3(0, 0, 1)
			local a4 = path_pos + Vector3(0, 0, 1.5)

			QuickDrawer:cone(path_pos, a2, 0.3, color, 8, 8)
			QuickDrawer:cone(a2, a3, 0.3, color, 8, 8)
			QuickDrawer:cone(a3, a4, 0.3, color, 8, 8)
			QuickDrawer:cone(player_pos, player_pos + Vector3(0, 0, 2), 0.3, color, 8, 8)
			QuickDrawer:line(player_pos + Vector3(0, 0, 1), path_pos + Vector3(0, 0, 1), color)
			Debug.text("Ahead unit travel dist: %.1f,", player_info.travel_dist)
		end

		local behind_unit = main_path_info.behind_unit

		if behind_unit then
			local player_info = self.main_path_player_info[behind_unit]
			local path_pos = player_info.path_pos:unbox()
			local color = Color(200, 200, 0)
			local player_pos = POSITION_LOOKUP[behind_unit]
			local b2 = path_pos + Vector3(0, 0, 0.5)
			local b3 = path_pos + Vector3(0, 0, 1)
			local b4 = path_pos + Vector3(0, 0, 1.5)

			QuickDrawer:cone(path_pos, b2, 0.3, color, 8, 7)
			QuickDrawer:cone(b2, b3, 0.3, color, 8, 7)
			QuickDrawer:cone(b3, b4, 0.3, color, 8, 7)
			QuickDrawer:cone(player_pos, player_pos + Vector3(0, 0, 2), 0.3, color, 8, 8)
			QuickDrawer:line(player_pos + Vector3(0, 0, 1), path_pos + Vector3(0, 0, 1), color)
		end

		local tt_intervention = self._next_rushing_intervention_time - t

		Debug.text("cluster-utility: %s, lone-value: %.1f, intervention dist: %.1f, intervention timer: %.1f", tostring(cluster_utility), loneliness_value, dist_to_intervention, tt_intervention)
	end

	Profiler.stop("Conflict Server Debug")
end

local colors = {
	{
		30,
		30,
		30
	},
	{
		45,
		45,
		45
	},
	{
		60,
		60,
		60
	},
	{
		85,
		85,
		85
	},
	{
		100,
		100,
		100
	},
	{
		115,
		115,
		115
	},
	{
		130,
		130,
		130
	},
	{
		145,
		145,
		145
	},
	{
		160,
		160,
		160
	},
	{
		175,
		175,
		175
	},
	{
		190,
		190,
		190
	},
	{
		205,
		205,
		205
	},
	{
		220,
		220,
		220
	},
	{
		235,
		235,
		235
	},
	{
		255,
		255,
		255
	}
}

ConflictDirector.debug_draw_horde = function (self, hordes)
	for i = 1, #hordes, 1 do
		local color = Color(unpack(colors[i]))
		local horde_data = hordes[i]
		local drawer = QuickDrawer
		local horde_spawners = horde_data.horde_spawners

		if horde_spawners then
			local num_spawners = #horde_spawners

			for j = 1, num_spawners, 1 do
				local spawner_unit = horde_spawners[j]
				local pos = Unit.local_position(spawner_unit, 0)

				drawer:sphere(pos, 2.5, color)
				drawer:line(pos, pos, color)
			end
		end
	end
end

return
