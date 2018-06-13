EnemyRecycler = class(EnemyRecycler)
local InterestPointUnits = InterestPointUnits
local position_lookup = POSITION_LOOKUP
local unit_alive = Unit.alive
local U_UNIT = 1
local U_BREED_NAME = 2
local U_POSITION = 3
local U_ROTATION = 4
local U_INV_TEMPLATE = 5
local AREA_PACK_SIZE_OR_EVENT_NAME = 5
local AREA_ROTATION = 8
local MP_TRAVEL_DIST = 1
local MP_BOXED_POS = 2
local MP_TERROR_EVENT_NAME = 3

local function fast_array_remove(array, index)
	local value = array[index]
	local size = #array
	array[index] = array[size]
	array[size] = nil

	return value
end

EnemyRecycler.init = function (self, world, nav_world, pos_list, pack_sizes, pack_rotations)
	self.world = world
	self.nav_world = nav_world
	self.conflict_director = Managers.state.conflict
	self.group_manager = self.conflict_director.navigation_group_manager
	self.areas = {}
	self.shutdown_areas = {}
	self.inside_areas = {}
	self.main_path_events = {}
	self.current_main_path_event_id = 1
	self.current_main_path_event_activation_dist = 999999
	self.main_path_info = self.conflict_director.main_path_info
	self._roaming_ai = 0
	self.group_id = 0
	self.visible = 0
	self.level = LevelHelper:current_level(world)

	self:setup(pos_list, pack_sizes, pack_rotations)
end

EnemyRecycler.setup_forbidden_zones = function (self, pos)
	self.forbidden_zones = {}
	local forbidden_zones = self.forbidden_zones

	for i = 1, 9, 1 do
		local zone_name = "forbidden_zone" .. i

		if Level.has_volume(self.level, zone_name) then
			forbidden_zones[#forbidden_zones + 1] = zone_name
		end
	end

	local checkpoint_data = Managers.state.spawn:checkpoint_data()

	if checkpoint_data then
		forbidden_zones[#forbidden_zones + 1] = checkpoint_data.no_spawn_volume
	end

	for layer_id = 20, 29, 1 do
		local layer_name = LAYER_ID_MAPPING[layer_id]

		if layer_name then
			local cost = NAV_TAG_VOLUME_LAYER_COST_AI[layer_name]

			if cost == 0 then
				print("Layer named:", layer_name, ", id:", layer_id, " has cost 0 --> removed all roaming spawns found inside")

				forbidden_zones[#forbidden_zones + 1] = layer_name
			end
		end
	end

	self.has_forbidden_zones = #forbidden_zones > 0
end

local function is_allowed_spawn(level, volume_list, volume_list_size, pos)
	for i = 1, volume_list_size, 1 do
		if Level.is_point_inside_volume(level, volume_list[i], pos) then
			return false
		end
	end

	return true
end

EnemyRecycler.add_critters = function (self)
	local level_key = Managers.state.game_mode:level_key()
	local level_name = LevelSettings[level_key].level_name
	local unit_ind = LevelResource.unit_indices(level_name, "units/hub_elements/critter_spawner")

	for _, id in ipairs(unit_ind) do
		local pos = LevelResource.unit_position(level_name, id)
		local unit_data = LevelResource.unit_data(level_name, id)
		local breed_name = DynamicData.get(unit_data, "breed")

		assert(Breeds[breed_name], "Level '%s' has placed a 'critter_spawner' unit, with a bad breed-name: '%s'", level_name, breed_name)

		local boxed_rot = QuaternionBox(Quaternion(Vector3.up(), math.degrees_to_radians(Math.random(1, 360))))
		local boxed_pos = Vector3Box(pos)

		self:add_breed(breed_name, boxed_pos, boxed_rot)
	end
end

EnemyRecycler.setup = function (self, pos_list, pack_sizes, pack_rotations)
	self.unique_area_id = 0

	self:reset_areas()
	self:setup_forbidden_zones()

	local areas = self.areas
	local level_settings = LevelHelper:current_level_settings()
	local k = 1
	local volume_list = self.forbidden_zones
	local volume_list_size = #self.forbidden_zones
	local level = self.level
	local nav_world = self.nav_world
	local nav_tag_volume_handler = self.conflict_director.nav_tag_volume_handler

	if not CurrentConflictSettings.roaming.disabled then
		for i = 1, #pos_list, 1 do
			local area_position = pos_list[i]
			local pack_size = pack_sizes[i]
			local area_rot = pack_rotations[i]
			local pos = area_position:unbox()
			local spawn = true
			local zone = self.group_manager:get_group_from_position(pos)

			if not is_allowed_spawn(level, volume_list, volume_list_size, pos) then
				spawn = false
			elseif NavTagVolumeUtils.inside_level_volume_layer(level, nav_tag_volume_handler, pos, "NO_SPAWN") then
				spawn = false
			end

			assert(pack_size, "Fatal error, missing interest point unit")

			if spawn then
				areas[k] = {
					area_position,
					false,
					0,
					0,
					pack_size,
					zone,
					"pack",
					area_rot
				}
				k = k + 1
			end
		end

		self.unique_area_id = k
	end

	if not CurrentConflictSettings.roaming.disabled and not script_data.ai_critter_spawning_disabled then
		self:add_critters()
	end
end

EnemyRecycler.reset_areas = function (self)
	local areas = self.areas

	for i = 1, #areas, 1 do
		areas[i] = nil
	end

	local shutdown_areas = self.shutdown_areas

	for i = 1, #shutdown_areas, 1 do
		shutdown_areas[i] = nil
	end

	local inside_areas = self.inside_areas

	for i = 1, #inside_areas, 1 do
		inside_areas[i] = nil
	end
end

EnemyRecycler.update = function (self, t, dt, player_positions, threat_population, player_areas)
	self:_update_roaming_spawning(t, player_positions, player_areas, threat_population)
	self:_update_main_path_events(t)

	if script_data.debug_ai_recycler then
		self:draw_debug(player_positions)
	end
end

EnemyRecycler._update_main_path_events = function (self, t, dt)
	if not self.current_main_path_event_id or script_data.ai_boss_spawning_disabled then
		return
	end

	if self.current_main_path_event_activation_dist <= self.main_path_info.ahead_travel_dist then
		local id = self.current_main_path_event_id
		local events = self.main_path_events
		local event = events[id]

		TerrorEventMixer.start_event(event[MP_TERROR_EVENT_NAME], event[MP_BOXED_POS])

		id = id + 1
		event = events[id]

		if event then
			self.current_main_path_event_id = id
			self.current_main_path_event_activation_dist = event[MP_TRAVEL_DIST]
		else
			self.current_main_path_event_id = nil
		end
	end
end

EnemyRecycler.spawn_interest_point = function (self, unit_name, position, do_spawn, angle)
	local extension_init_data = {
		ai_interest_point_system = {
			recycler = true,
			do_spawn = do_spawn
		}
	}
	local rot = Quaternion(Vector3.up(), angle)
	local unit = Managers.state.unit_spawner:spawn_network_unit(unit_name, "interest_point", extension_init_data, position:unbox(), rot)

	assert(unit, "Bad interest point, not found")

	return unit
end

EnemyRecycler.add_breed = function (self, breed_name, boxed_pos, boxed_rot)
	self.unique_area_id = self.unique_area_id + 1
	local unit_data = {
		[2] = breed_name,
		[3] = boxed_pos,
		[4] = boxed_rot
	}
	local unit_list = {
		unit_data
	}
	local zone = self.group_manager:get_group_from_position(boxed_pos:unbox())
	self.areas[#self.areas + 1] = {
		boxed_pos,
		unit_list,
		0,
		0,
		false,
		zone,
		"breed",
		self.unique_area_id
	}
end

EnemyRecycler.activate_area = function (self, area, threat_population)
	local INDEX_UNITLIST = 2
	local INDEX_TYPE = 7
	local units_in_area = area[2]
	local area_type = area[INDEX_TYPE]

	if not units_in_area then
		if area_type == "pack" then
			if threat_population == 0 then
				return true
			else
				local unit_name = area[AREA_PACK_SIZE_OR_EVENT_NAME]
				local position = area[1]
				local do_spawn_yes = true
				local interest_point_unit = self:spawn_interest_point(unit_name, position, do_spawn_yes, area[AREA_ROTATION])
				local units_in_area = {
					{
						interest_point_unit,
						unit_name,
						position
					}
				}
				area[INDEX_UNITLIST] = units_in_area
			end
		elseif area_type == "event" then
			local boxed_pos = area[1]
			local event_name = area[AREA_PACK_SIZE_OR_EVENT_NAME]

			TerrorEventMixer.start_event(event_name, boxed_pos)

			return true
		end
	elseif area_type == "pack" then
		local interest_point_unit = units_in_area[1][1]
		local interest_point_unit_name = units_in_area[1][2]
		local interest_point_position = units_in_area[1][3]

		assert(interest_point_unit == nil, "lolwut")

		local do_spawn_no = false
		interest_point_unit = self:spawn_interest_point(interest_point_unit_name, interest_point_position, do_spawn_no, area[AREA_ROTATION])
		units_in_area[1][1] = interest_point_unit

		for i = 2, #units_in_area, 1 do
			local unit_data = units_in_area[i]
			local breed_name = unit_data[U_BREED_NAME]
			local spawn_pos = unit_data[U_POSITION]
			local spawn_rot = unit_data[U_ROTATION]
			local inv_template = unit_data[U_INV_TEMPLATE]
			local breed = Breeds[breed_name]
			local spawn_category = "enemy_recycler"
			local spawn_type = "roam"
			local id = self.conflict_director:spawn_queued_unit(breed, spawn_pos, spawn_rot, spawn_category, nil, spawn_type, inv_template, nil, unit_data)
			unit_data[U_UNIT] = id
			self._roaming_ai = self._roaming_ai + 1
		end
	elseif area_type == "breed" then
		local unit_data = units_in_area[1]
		local breed_name = unit_data[U_BREED_NAME]
		local spawn_pos = unit_data[U_POSITION]
		local spawn_rot = unit_data[U_ROTATION]
		local inv_template = unit_data[U_INV_TEMPLATE]
		local breed = Breeds[breed_name]
		local spawn_category = "enemy_recycler"
		local spawn_type = "roam"
		local id = self.conflict_director:spawn_queued_unit(breed, spawn_pos, spawn_rot, spawn_category, nil, spawn_type, inv_template, nil, unit_data)
		unit_data[U_UNIT] = id
		self._roaming_ai = self._roaming_ai + 1
	end

	return false
end

local REFREEZE_DISTANCE_SQUARED = 25

EnemyRecycler.deactivate_area = function (self, area)
	local INDEX_TYPE = 7
	local units_in_area = area[2]
	local area_type = area[INDEX_TYPE]

	if area_type == "pack" then
		if units_in_area then
			local interest_point_unit = units_in_area[1][1]
			local extension = ScriptUnit.extension(interest_point_unit, "ai_interest_point_system")
			local points = extension.points
			local points_n = extension.points_n
			local units_in_area_n = 1
			local sleepy = nil

			for i = 2, #units_in_area, 1 do
				local unit_data = units_in_area[i]
				local queue_id = unit_data[1]

				if type(queue_id) == "number" then
					local d = self.conflict_director:remove_queued_unit(queue_id)
					self._roaming_ai = self._roaming_ai - 1
					units_in_area_n = units_in_area_n + 1
					units_in_area[units_in_area_n] = {
						[2] = d[1].name,
						[3] = d[2],
						[4] = d[3],
						[5] = d[7]
					}
					sleepy = true
				elseif Unit.alive(queue_id) then
					local unit = queue_id
					local blackboard = Unit.get_data(unit, "blackboard")

					if not blackboard.target_unit_found_time then
						local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")
						local inventory_configuration_name = inventory_extension.inventory_configuration_name
						local inventory_template = inventory_configuration_name
						local position = position_lookup[unit]

						if blackboard.next_smart_object_data.next_smart_object_id ~= nil then
							position = blackboard.next_smart_object_data.entrance_pos:unbox()
						end

						units_in_area_n = units_in_area_n + 1
						units_in_area[units_in_area_n] = {
							[2] = Unit.get_data(unit, "breed").name,
							[3] = Vector3Box(position),
							[4] = QuaternionBox(Unit.local_rotation(unit, 0)),
							[5] = inventory_template
						}

						self.conflict_director:destroy_unit(unit, blackboard, "deactivate_area")

						self._roaming_ai = self._roaming_ai - 1
					end

					sleepy = true
				end
			end

			if not sleepy then
				for i = 1, points_n, 1 do
					local point = points[i]

					if type(point[1]) == "number" then
						local d = self.conflict_director:remove_queued_unit(point[1])
						self._roaming_ai = self._roaming_ai - 1
						units_in_area_n = units_in_area_n + 1
						units_in_area[units_in_area_n] = {
							[2] = d[1].name,
							[3] = d[2],
							[4] = d[3],
							[5] = d[7]
						}
					end

					claim_unit = point.claim_unit or (type(point[1]) ~= "number" and point[1])

					if claim_unit and unit_alive(claim_unit) then
						local blackboard = Unit.get_data(claim_unit, "blackboard")

						if not blackboard.target_unit_found_time then
							local inventory_extension = ScriptUnit.extension(claim_unit, "ai_inventory_system")
							local inventory_configuration_name = inventory_extension.inventory_configuration_name
							local inventory_template = inventory_configuration_name
							local position = position_lookup[claim_unit]

							if blackboard.next_smart_object_data.next_smart_object_id ~= nil then
								position = blackboard.next_smart_object_data.entrance_pos:unbox()
							end

							units_in_area_n = units_in_area_n + 1
							units_in_area[units_in_area_n] = {
								[2] = Unit.get_data(claim_unit, "breed").name,
								[3] = Vector3Box(position),
								[4] = QuaternionBox(Unit.local_rotation(claim_unit, 0)),
								[5] = inventory_template
							}

							self.conflict_director:destroy_unit(claim_unit, blackboard, "deactivate_area")

							self._roaming_ai = self._roaming_ai - 1
						end
					end
				end
			end

			for i = units_in_area_n + 1, #units_in_area, 1 do
				assert(i ~= 1)

				units_in_area[i] = nil
			end

			Managers.state.unit_spawner:mark_for_deletion(interest_point_unit)

			units_in_area[1][1] = nil

			if units_in_area_n == 1 then
				return false
			end
		end
	elseif area_type == "breed" then
		local unit_data = units_in_area[1]
		local unit = unit_data[U_UNIT]

		if type(unit) == "number" then
			self.conflict_director:remove_queued_unit(unit)

			self._roaming_ai = self._roaming_ai - 1

			return true
		end

		local alive = unit_alive(unit) and ScriptUnit.extension(unit, "health_system"):is_alive()
		local sleep_unit = false
		local blackboard = nil

		if alive then
			blackboard = Unit.get_data(unit, "blackboard")

			if not blackboard.target_unit_found_time then
				local position = position_lookup[unit]

				if blackboard.next_smart_object_data.next_smart_object_id ~= nil then
					position = blackboard.next_smart_object_data.entrance_pos:unbox()
				end

				unit_data[U_POSITION] = Vector3Box(position)
				unit_data[U_ROTATION] = QuaternionBox(Unit.local_rotation(unit, 0))
				unit_data[U_BREED_NAME] = blackboard.breed.name
				sleep_unit = true
			end
		end

		if sleep_unit then
			self.conflict_director:destroy_unit(unit, blackboard, "deactivate_area")

			self._roaming_ai = self._roaming_ai - 1
		else
			return false
		end
	end

	return true
end

local area_checks_per_frame = 20
local remove_zones = {}

EnemyRecycler._update_roaming_spawning = function (self, t, player_positions, player_zones, threat_population)
	Profiler.start("recycler - pack spawning")

	local INDEX_SEEN = 3
	local INDEX_SEEN_LAST_FRAME = 4
	local INDEX_ZONE = 6
	local roaming = CurrentRoamingSettings
	local astar_checks = 0
	local astar_cached_checks = 0
	local wakeup_distance = roaming.despawn_distance
	local wakeup_distance_z = roaming.despawn_distance_z or 30
	local sleep_distance = wakeup_distance + 5
	local math_abs = math.abs
	local areas = self.areas
	local shutdown_areas = self.shutdown_areas
	local players = #player_positions
	local path_distance_threshold = CurrentRoamingSettings.despawn_path_distance
	local index = self.remembered_area_index or 1
	local size = #areas
	local checks = area_checks_per_frame

	if size < checks then
		checks = size
		index = 1
	end

	local num_to_remove = 0
	local add_visible = 0
	local start_index = index
	local i = 1

	while checks >= i do
		if size < index then
			index = 1
		end

		local area = areas[index]
		area[INDEX_SEEN_LAST_FRAME] = area[INDEX_SEEN]
		area[INDEX_SEEN] = 0
		local pos = area[1]:unbox()

		for j = 1, players, 1 do
			local to_dir = pos - player_positions[j]
			local h = to_dir.z

			Vector3.set_z(to_dir, 0)

			local dist = Vector3.length(to_dir)

			if dist < wakeup_distance and math_abs(h) < wakeup_distance_z then
				local zone = player_zones[j]

				if self.group_manager.operational and zone and area[INDEX_ZONE] then
					local _, path_dist, cached = self.group_manager:a_star_cached(zone, area[INDEX_ZONE])
					astar_checks = astar_checks + ((cached and 0) or 1)
					astar_cached_checks = astar_cached_checks + ((cached and 1) or 0)

					if not path_dist or path_dist < path_distance_threshold then
						area[INDEX_SEEN] = area[INDEX_SEEN] + 1
					end
				else
					area[INDEX_SEEN] = area[INDEX_SEEN] + 1
				end
			end
		end

		local s1 = area[INDEX_SEEN]
		local s2 = area[INDEX_SEEN_LAST_FRAME]

		if s1 ~= s2 then
			if s1 > 0 then
				if s2 == 0 then
					local shutdown_area = self:activate_area(area, threat_population)

					if shutdown_area then
						num_to_remove = num_to_remove + 1
						remove_zones[num_to_remove] = index
					else
						add_visible = add_visible + 1
						self.inside_areas[area] = true
					end
				end
			elseif s2 > 0 then
				if not self:deactivate_area(area) then
					num_to_remove = num_to_remove + 1
					remove_zones[num_to_remove] = index
				end

				add_visible = add_visible - 1
			end
		end

		index = index + 1
		i = i + 1
	end

	if num_to_remove > 0 then
		local function sort_func(a, b)
			return b < a
		end

		table.sort(remove_zones, sort_func)

		for i = 1, num_to_remove, 1 do
			shutdown_areas[#shutdown_areas + 1] = fast_array_remove(areas, remove_zones[i])
			remove_zones[i] = nil
		end
	end

	self.remembered_area_index = math.clamp(index - num_to_remove, 1, #areas)
	self.visible = self.visible + add_visible

	if script_data.debug_ai_recycler then
		Debug.text("Recycler a-star checks/frame cached:" .. tostring(astar_cached_checks) .. " real:" .. tostring(astar_checks))
	end

	Profiler.stop("recycler - pack spawning")
end

EnemyRecycler.add_terror_event_in_area = function (self, boxed_pos, terror_event_name)
	local zone = self.group_manager:get_group_from_position(boxed_pos:unbox())
	self.areas[#self.areas + 1] = {
		boxed_pos,
		nil,
		0,
		0,
		terror_event_name,
		zone,
		"event",
		false
	}
end

EnemyRecycler.add_main_path_terror_event = function (self, boxed_pos, terror_event_name, activation_dist)
	local main_path_events = self.main_path_events
	local path_pos, travel_dist, move_percent, path_index, sub_index = MainPathUtils.closest_pos_at_main_path(nil, boxed_pos:unbox())
	travel_dist = math.max(0, travel_dist - (activation_dist or 45))

	if script_data.debug_ai_recycler then
		local trigger_pos = MainPathUtils.point_on_mainpath(nil, travel_dist)

		QuickDrawerStay:sphere(trigger_pos + Vector3(0, 0, 2), 1, Color(255, 0, 0))
	end

	local num_events = #main_path_events
	main_path_events[num_events + 1] = {
		travel_dist,
		boxed_pos,
		terror_event_name
	}

	if #main_path_events == 1 then
		self.current_main_path_event_id = 1
		self.current_main_path_event_activation_dist = travel_dist
	end

	table.sort(main_path_events, function (a, b)
		return a[1] < b[1]
	end)
end

EnemyRecycler.draw_debug = function (self, player_positions)
	Profiler.start("recycler - debug")

	local shutdown = self.shutdown_areas
	local drawer = Managers.state.debug:drawer({
		mode = "immediate",
		name = "ai_recycler"
	})
	local inside_color = Color(255, 140, 255, 200)
	local outside_color = Color(255, 255, 40, 100)
	local shutdown_color = Color(128, 30, 40, 230)
	local cone_height = Vector3(0, 0, 12)
	local roaming = CurrentRoamingSettings
	local pos = player_positions[1]

	if not pos then
		return
	end

	local z_dist = roaming.despawn_distance_z
	local r = roaming.despawn_distance

	drawer:cylinder(pos + Vector3(0, 0, -z_dist), pos + Vector3(0, 0, z_dist), r, inside_color, 8)
	drawer:cylinder(pos + Vector3(0, 0, -z_dist), pos + Vector3(0, 0, z_dist), r, inside_color, 8)
	drawer:line(pos + Vector3(r, 0, -z_dist), pos + Vector3(-r, 0, -z_dist), inside_color, 8)
	drawer:line(pos + Vector3(0, r, -z_dist), pos + Vector3(0, -r, -z_dist), inside_color, 8)
	drawer:line(pos + Vector3(r, 0, z_dist), pos + Vector3(-r, 0, z_dist), inside_color, 8)
	drawer:line(pos + Vector3(0, r, z_dist), pos + Vector3(0, -r, z_dist), inside_color, 8)

	local areas = self.areas
	local visible = self.visible
	local not_visible = #areas - visible

	Debug.text("Areas: " .. #areas .. ", visible: " .. visible .. ", not visible: " .. not_visible)

	local s = ""
	local t = ""

	for i = 1, #areas, 1 do
		local area = areas[i]
		local pos = area[1]:unbox()
		local seen = area[3]

		if seen > 0 then
			t = t .. " I " .. i .. "= " .. seen

			drawer:line(pos, pos + cone_height, inside_color)
		else
			s = s .. " I " .. i .. "= " .. seen

			drawer:line(pos, pos + cone_height, outside_color)
		end
	end

	for i = 1, #shutdown, 1 do
		local pos = shutdown[i][1]:unbox()

		drawer:line(pos, pos + cone_height, shutdown_color)
	end

	local local_player_unit = Managers.player:local_player().player_unit

	if Unit.alive(local_player_unit) then
		local main_path_player_info = self.conflict_director.main_path_player_info
		local info = main_path_player_info[local_player_unit]

		if info then
			Debug.text("travel-dist: %.1fm, move_percent: %.1f%%, path-index: %d, sub-index: %d", info.travel_dist, info.move_percent * 100, info.path_index, info.sub_index)
		end
	end

	Profiler.stop("recycler - debug")
end

local NUM_FAR_OFF_CHECKS = 6

EnemyRecycler.far_off_despawn = function (self, t, dt, player_positions, spawned)
	Profiler.start("recycler  far off despawn")

	local index = self.far_off_index or 1
	local size = #spawned
	local num = NUM_FAR_OFF_CHECKS

	if size < num then
		num = size
		index = 1
	end

	local destroy_los_distance_squared = LevelHelper:current_level_settings().destroy_los_distance_squared or RecycleSettings.destroy_los_distance_squared
	local nav_world = self.nav_world
	local num_players = #player_positions

	if num_players == 0 then
		return
	end

	local i = 1

	while num >= i do
		if size < index then
			index = 1
		end

		local destroy_distance_squared = destroy_los_distance_squared
		local ai_stuck = false
		local unit = spawned[index]
		local pos = position_lookup[unit]
		local ai_navigation = ScriptUnit.extension(unit, "ai_navigation_system")
		local blackboard = ai_navigation._blackboard

		if blackboard.stuck_check_time < t then
			local breed = Unit.get_data(unit, "breed")

			if ai_navigation._enabled and not breed.far_off_despawn_immunity then
				local distance_squared = Vector3.distance_squared(ai_navigation:destination(), pos)

				if distance_squared > 5 then
					local velocity = ScriptUnit.extension(unit, "locomotion_system"):current_velocity()

					if Vector3.distance_squared(velocity, Vector3.zero()) == 0 then
						ai_stuck = true
						destroy_distance_squared = RecycleSettings.destroy_stuck_distance_squared
					end
				end
			end

			blackboard.stuck_check_time = t + 3 + i * dt
		end

		local num_players_far_away = 0

		for j = 1, num_players, 1 do
			local player_pos = player_positions[j]
			local dist_squared = Vector3.distance_squared(pos, player_pos)

			if destroy_distance_squared < dist_squared then
				num_players_far_away = num_players_far_away + 1
			end
		end

		if num_players_far_away == num_players then
			if ai_stuck then
				print("Destroying unit - ai got stuck", Unit.get_data(unit, "breed").name)
				self.conflict_director:destroy_unit(unit, blackboard, "stuck")
			else
				local breed = Unit.get_data(unit, "breed")

				if not breed.far_off_despawn_immunity then
					print("Destroying unit - ai too far away from all players. ", breed.name)
					self.conflict_director:destroy_unit(unit, blackboard, "far_away")
				end
			end

			size = size - 1

			if size == 0 then
				break
			end
		end

		index = index + 1
		i = i + 1
	end

	self.far_off_index = index

	Profiler.stop("recycler  far off despawn")
end

return
