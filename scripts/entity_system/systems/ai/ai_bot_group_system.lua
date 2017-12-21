-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
AIBotGroupSystem = class(AIBotGroupSystem, ExtensionSystemBase)
local extensions = {
	"AIBotGroupExtension",
	"BotBreakableExtension"
}
AIBotGroupExtension = class(AIBotGroupExtension)
AIBotGroupExtension.init = function (self)
	return 
end
AIBotGroupExtension.destroy = function (self)
	return 
end
local STICKYNESS_DISTANCE_MODIFIER = -0.2
local PLAYER_UNITS = PLAYER_UNITS
AIBotGroupSystem.init = function (self, context, system_name)
	local entity_manager = context.entity_manager

	entity_manager.register_system(entity_manager, self, system_name, extensions)

	self._is_server = context.is_server
	self._world = context.world
	self._bot_ai_data = {}
	self._num_bots = 0
	self._last_move_target_rotations = {}
	self._last_move_target_unit = nil
	self._urgent_targets = {}
	self._ally_needs_aid_priority = {}
	self._bot_breakables_broadphase = Broadphase(2, 60)
	self._disallowed_tag_layers = {
		bot_poison_wind = true,
		barrel_explosion = true
	}
	self._t = 0
	self._in_carry_event = false
	local up = Vector3.up()
	self._left_vectors_outside_volume = {
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*1)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*2)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*3)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*4)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*5)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*6)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*7)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*0)/8)))
	}
	self._right_vectors_outside_volume = {
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*1)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*2)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*3)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*4)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*5)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*6)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*7)/8)))
	}
	self._left_vectors = {
		Vector3Box(Quaternion.forward(Quaternion(up, math.pi*0.5))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*5)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*3)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*6)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*2)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*7)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (math.pi*1)/8)))
	}
	self._right_vectors = {
		Vector3Box(Quaternion.forward(Quaternion(up, -math.pi*0.5))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*5)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*3)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*6)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*2)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*7)/8))),
		Vector3Box(Quaternion.forward(Quaternion(up, (-math.pi*1)/8)))
	}
	self._available_health_pickups = {}
	self._available_ammo_pickups = {}
	self._last_key_in_available_pickups = nil
	self._update_pickups_at = -math.huge
	self._used_covers = {}

	return 
end
AIBotGroupSystem.destroy = function (self)
	return 
end
AIBotGroupSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	if extension_name == "BotBreakableExtension" then
		Broadphase.add(self._bot_breakables_broadphase, unit, Unit.world_position(unit, 0), 1)
		ScriptUnit.add_extension(nil, unit, "AIBotGroupExtension", self.NAME)

		return {}
	else
		local data = {
			priority_target_distance = math.huge,
			priority_targets = {},
			nav_point_utility = {},
			blackboard = Unit.get_data(unit, "blackboard")
		}
		self._bot_ai_data[unit] = data

		ScriptUnit.add_extension(nil, unit, "AIBotGroupExtension", self.NAME)

		self._num_bots = self._num_bots + 1
		local ext = ScriptUnit.extension(unit, self.NAME)
		ext.data = data

		return ext
	end

	return 
end
AIBotGroupSystem.on_remove_extension = function (self, unit, extension_name)
	if extension_name == "AIBotGroupExtension" then
		self._bot_ai_data[unit] = nil
		self._num_bots = self._num_bots - 1
	end

	ScriptUnit.remove_extension(unit, self.NAME)

	return 
end
AIBotGroupSystem.hot_join_sync = function (self, sender, player)
	return 
end
AIBotGroupSystem.set_in_carry_event = function (self, enable)
	self._in_carry_event = enable

	return 
end
AIBotGroupSystem.update = function (self, context, t)
	if not self._is_server or self._num_bots == 0 then
		return 
	end

	self._last_move_target_rotations = self._last_move_target_rotations or {}
	self._t = t
	local dt = context.dt

	Profiler.start("_update_urgent_targets")
	self._update_urgent_targets(self, dt, t)
	Profiler.stop()
	Profiler.start("_update_move_targets")
	self._update_move_targets(self, dt, t)
	Profiler.stop()
	Profiler.start("_update_priority_targets")
	self._update_priority_targets(self, dt, t)
	Profiler.stop()
	Profiler.start("_update_pickups")
	self._update_pickups(self, dt, t)
	Profiler.stop()
	Profiler.start("_update_first_person_debug")
	self._update_first_person_debug(self)
	Profiler.stop()
	Profiler.start("_update_ally_needs_aid_priority")
	self._update_ally_needs_aid_priority(self)
	Profiler.stop()

	return 
end
local PRIORITY_TARGETS_TEMP = {}
local NEW_TARGETS = {}
local OLD_TARGETS = {}
local TEMP_PLAYER_UNITS = {}
local TEMP_DISABLED_PLAYER_UNITS = {}
local TEMP_PLAYER_POSITIONS = {}
local TEMP_MAN_MAN_POINTS = {}
AIBotGroupSystem._update_move_targets = function (self, dt, t)
	local human_players = Managers.player:human_players()

	for i = 1, #PLAYER_UNITS, 1 do
		local player_unit = PLAYER_UNITS[i]
		local status_ext = player_unit and ScriptUnit.extension(player_unit, "status_system")
		local not_disabled = status_ext and not status_ext.is_disabled(status_ext)

		if not_disabled then
			TEMP_PLAYER_UNITS[#TEMP_PLAYER_UNITS + 1] = player_unit
		elseif status_ext then
			TEMP_DISABLED_PLAYER_UNITS[#TEMP_DISABLED_PLAYER_UNITS + 1] = player_unit
		end
	end

	local num_units = #TEMP_PLAYER_UNITS
	local num_disabled_units = #TEMP_DISABLED_PLAYER_UNITS

	if num_units == 0 and 0 < num_disabled_units then
		num_units = num_disabled_units
		local tmp = TEMP_PLAYER_UNITS
		TEMP_PLAYER_UNITS = TEMP_DISABLED_PLAYER_UNITS
		TEMP_DISABLED_PLAYER_UNITS = tmp
		num_units = num_disabled_units
	end

	local num_bots = self._num_bots
	local selected_unit = nil

	if num_units == 0 then
		selected_unit = nil
	elseif 3 <= num_units then
		if self._in_carry_event then
			local bot_unit, data = next(self._bot_ai_data)
			selected_unit = self._find_most_lonely_move_target(self, TEMP_PLAYER_UNITS, bot_unit)
		else
			selected_unit = self._find_least_lonely_move_target(self, TEMP_PLAYER_UNITS, self._last_move_target_unit)
		end
	elseif num_units == 2 and num_bots == 2 and self._in_carry_event then
		local points = TEMP_MAN_MAN_POINTS

		for i, unit in ipairs(TEMP_PLAYER_UNITS) do
			local nav_world = Managers.state.entity:system("ai_system"):nav_world()
			local unit_pos = POSITION_LOOKUP[unit]
			local disallowed_at_pos, current_mapping = self._selected_unit_is_in_disallowed_nav_tag_volume(self, nav_world, unit_pos)
			local destination_points = nil

			if disallowed_at_pos then
				local origin_point = self._find_origin(self, nav_world, unit)
				destination_points = self._find_destination_points_outside_volume(self, nav_world, unit_pos, current_mapping, origin_point, 1)
			else
				local cluster_position, rotation = self._find_cluster_position(self, nav_world, unit)
				destination_points = self._find_destination_points(self, nav_world, cluster_position, rotation, 1)
			end

			table.append(points, destination_points)
		end

		self._assign_destination_points(self, self._bot_ai_data, points, nil, TEMP_PLAYER_UNITS)
		table.clear(TEMP_PLAYER_UNITS)
		table.clear(points)

		return 
	else
		local average_bot_pos = Vector3(0, 0, 0)

		for unit, _ in pairs(self._bot_ai_data) do
			average_bot_pos = average_bot_pos + POSITION_LOOKUP[unit]
		end

		average_bot_pos = average_bot_pos/num_bots
		selected_unit = self._find_closest_move_target(self, TEMP_PLAYER_UNITS, self._last_move_target_unit, average_bot_pos)
	end

	if selected_unit and not script_data.bots_dont_follow then
		self._last_move_target_unit = selected_unit
		local nav_world = Managers.state.entity:system("ai_system"):nav_world()
		local unit_pos = POSITION_LOOKUP[selected_unit]
		local disallowed_at_pos, current_mapping = self._selected_unit_is_in_disallowed_nav_tag_volume(self, nav_world, unit_pos)
		local destination_points = nil

		if disallowed_at_pos then
			local origin_point = self._find_origin(self, nav_world, selected_unit)
			destination_points = self._find_destination_points_outside_volume(self, nav_world, unit_pos, current_mapping, origin_point, num_bots)
		else
			local cluster_position, rotation = self._find_cluster_position(self, nav_world, selected_unit)
			destination_points = self._find_destination_points(self, nav_world, cluster_position, rotation, num_bots)
		end

		self._assign_destination_points(self, self._bot_ai_data, destination_points, selected_unit)
	else
		for unit, data in pairs(self._bot_ai_data) do
			data.follow_position = nil
			data.follow_unit = nil
		end
	end

	table.clear(TEMP_PLAYER_UNITS)
	table.clear(TEMP_DISABLED_PLAYER_UNITS)

	return 
end
AIBotGroupSystem._selected_unit_is_in_disallowed_nav_tag_volume = function (self, nav_world, selected_unit_pos)
	local tag_volumes_query = GwNavQueries.tag_volumes_from_position(nav_world, selected_unit_pos, 2, 2)

	if tag_volumes_query then
		local volume_count = GwNavQueries.nav_tag_volume_count(tag_volumes_query)

		for i = 1, volume_count, 1 do
			local nav_tag_volume = GwNavQueries.nav_tag_volume(tag_volumes_query, i)
			local is_exclusive, color, layer_id, smart_object_id, user_data_id = GwNavTagVolume.navtag(nav_tag_volume)
			local layer_name = LAYER_ID_MAPPING[layer_id]
			local volume_system = Managers.state.entity:system("volume_system")
			local current_mapping = volume_system.get_volume_mapping_from_lookup_id(volume_system, user_data_id)

			if current_mapping and self._disallowed_tag_layers[layer_name] then
				return true, current_mapping
			end
		end

		return false
	else
		return false
	end

	return 
end
AIBotGroupSystem._find_closest_move_target = function (self, targets, last_target, pos)
	local closest_index = nil
	local closest_value = math.huge

	for i, unit in ipairs(targets) do
		local dist_sq = Vector3.distance_squared(pos, POSITION_LOOKUP[unit])

		if unit == last_target then
			dist_sq = dist_sq - 9
		end

		if dist_sq < closest_value then
			closest_value = dist_sq
			closest_index = i
		end
	end

	return targets[closest_index]
end
AIBotGroupSystem._find_least_lonely_move_target = function (self, targets, last_target)
	for i, unit in ipairs(targets) do
		TEMP_PLAYER_POSITIONS[i] = POSITION_LOOKUP[unit]
	end

	local least_lonely_index = nil
	local least_lonely_value = math.huge

	for i, pos in ipairs(TEMP_PLAYER_POSITIONS) do
		local loneliness = nil

		if targets[i] == last_target then
			loneliness = -25
		else
			loneliness = 0
		end

		for i2, pos2 in ipairs(TEMP_PLAYER_POSITIONS) do
			loneliness = loneliness + Vector3.distance_squared(pos, pos2)
		end

		if loneliness < least_lonely_value then
			least_lonely_index = i
			least_lonely_value = loneliness
		end
	end

	table.clear(TEMP_PLAYER_POSITIONS)

	return targets[least_lonely_index]
end
AIBotGroupSystem._find_most_lonely_move_target = function (self, targets, origin_unit)
	local origin = POSITION_LOOKUP[origin_unit]

	for i, unit in ipairs(targets) do
		TEMP_PLAYER_POSITIONS[i] = POSITION_LOOKUP[unit]
	end

	local most_lonely_index = nil
	local most_lonely_value = -math.huge

	for i, pos in ipairs(TEMP_PLAYER_POSITIONS) do
		local loneliness = nil
		local sq_dist = Vector3.distance_squared(pos, origin)

		if 900 < sq_dist then
			loneliness = -sq_dist*3
		else
			loneliness = 0
		end

		for i2, pos2 in ipairs(TEMP_PLAYER_POSITIONS) do
			loneliness = loneliness + Vector3.distance_squared(pos, pos2)
		end

		if most_lonely_value < loneliness then
			most_lonely_index = i
			most_lonely_value = loneliness
		end
	end

	table.clear(TEMP_PLAYER_POSITIONS)

	return targets[most_lonely_index]
end
AIBotGroupSystem._find_origin = function (self, nav_world, selected_unit)
	local unit_pos = POSITION_LOOKUP[selected_unit]
	local unit_is_on_navmesh, z = GwNavQueries.triangle_from_position(nav_world, unit_pos, 5, 5)
	local origin_pos = nil

	if unit_is_on_navmesh then
		origin_pos = Vector3(unit_pos.x, unit_pos.y, z)
	else
		origin_pos = GwNavQueries.inside_position_from_outside_position(nav_world, unit_pos, 5, 5, 5, 0.5)
	end

	return origin_pos
end
AIBotGroupSystem._find_cluster_position = function (self, nav_world, selected_unit)
	local unit_pos = POSITION_LOOKUP[selected_unit]
	local locomotion_ext = ScriptUnit.extension(selected_unit, "locomotion_system")
	local current_velocity = locomotion_ext.current_velocity(locomotion_ext)
	local velocity = nil

	if Vector3.length_squared(current_velocity) < 0.01 then
		velocity = Vector3(0, 0, 0)
	else
		velocity = locomotion_ext.average_velocity(locomotion_ext)
	end

	local unit_is_on_navmesh, z = GwNavQueries.triangle_from_position(nav_world, unit_pos, 5, 5)
	local ray_start_pos = nil

	if unit_is_on_navmesh then
		ray_start_pos = Vector3(unit_pos.x, unit_pos.y, z)
	else
		ray_start_pos = GwNavQueries.inside_position_from_outside_position(nav_world, unit_pos, 5, 5, 5, 0.5)
	end

	local cluster_position = nil

	if ray_start_pos then
		local distance, ray_pos = self._raycast(self, nav_world, ray_start_pos, velocity, 5)
		cluster_position = Vector3.lerp(unit_pos, ray_pos, 0.6)
		local success, z = GwNavQueries.triangle_from_position(nav_world, cluster_position, 5, 5)

		if success then
			cluster_position.z = z
		else
			cluster_position = ray_pos
		end
	else
		cluster_position = unit_pos
	end

	local rotation = nil

	if 0.1 < Vector3.length(velocity) then
		rotation = Quaternion.look(velocity, Vector3.up())
		self._last_move_target_rotations[selected_unit] = nil
	elseif self._last_move_target_rotations[selected_unit] then
		rotation = self._last_move_target_rotations[selected_unit]:unbox()
	else
		local network_manager = Managers.state.network
		local game = network_manager.game(network_manager)

		if game and not LEVEL_EDITOR_TEST then
			local game_object_id = network_manager.unit_game_object_id(network_manager, selected_unit)
			local aim_direction = GameSession.game_object_field(game, game_object_id, "aim_direction")
			rotation = Quaternion.look(Vector3.flat(aim_direction), Vector3.up())
		else
			rotation = Unit.local_rotation(selected_unit, 0)
		end

		self._last_move_target_rotations[selected_unit] = QuaternionBox(rotation)
	end

	return cluster_position, rotation
end
local TEMP_UNITS = {}
local TEMP_TESTED_POINTS = {}
local TEMP_CURRENT_SOLUTION = {}
local TEMP_BEST_SOLUTION = {}
AIBotGroupSystem._assign_destination_points = function (self, bot_ai_data, points, follow_unit, follow_unit_table)
	local units = TEMP_UNITS

	for unit, data in pairs(bot_ai_data) do
		local utility = data.nav_point_utility

		table.clear(utility)

		local pos = POSITION_LOOKUP[unit]

		for i, point in ipairs(points) do
			utility[i] = math.sqrt(math.max(0, 1, Vector3.distance(pos, point)))/1
		end

		units[#units + 1] = unit
	end

	local function find_permutation(current_index, units, tested_points, current_solution, utility, data, best_utility, best_solution)
		local num_units = #units

		if num_units < current_index then
			if best_utility < utility then
				for i = 1, num_units, 1 do
					best_solution[i] = current_solution[i]
				end

				return utility
			else
				return best_utility
			end
		else
			local unit = units[current_index]

			for i = 1, num_units, 1 do
				if not tested_points[i] then
					current_solution[current_index] = i
					tested_points[i] = true
					local point_utility = data[unit].nav_point_utility[i]
					local new_utility = utility + point_utility
					best_utility = find_permutation(current_index + 1, units, tested_points, current_solution, new_utility, data, best_utility, best_solution)
					tested_points[i] = false
				end
			end

			return best_utility
		end

		return 
	end

	local solution = TEMP_BEST_SOLUTION
	local best_utility = find_permutation(1, units, TEMP_TESTED_POINTS, TEMP_CURRENT_SOLUTION, 0, bot_ai_data, -math.huge, solution)

	for i = 1, #units, 1 do
		local unit = units[i]
		local data = bot_ai_data[unit]
		local point_index = solution[i]
		data.follow_position = points[point_index]

		if follow_unit_table then
			data.follow_unit = follow_unit_table[point_index]
		elseif follow_unit then
			data.follow_unit = follow_unit
		else
			data.follow_unit = nil
		end
	end

	table.clear(TEMP_UNITS)
	table.clear(TEMP_TESTED_POINTS)
	table.clear(TEMP_CURRENT_SOLUTION)
	table.clear(TEMP_BEST_SOLUTION)

	return 
end
AIBotGroupSystem._calculate_center_of_volume = function (self, volume_mapping)
	local center_pos = Vector3(0, 0, 0)

	for _, point in pairs(volume_mapping.bottom_points) do
		center_pos = center_pos + Vector3(point[1], point[2], point[3])
	end

	center_pos = center_pos/#volume_mapping.bottom_points
	local longest_distance_sq = 0

	for _, point in pairs(volume_mapping.bottom_points) do
		longest_distance_sq = math.max(Vector3.distance_squared(center_pos, Vector3(point[1], point[2], point[3])), longest_distance_sq)
	end

	return center_pos, longest_distance_sq
end
AIBotGroupSystem._find_destination_points_outside_volume = function (self, nav_world, selected_unit_pos, volume_mapping, origin_point, needed_points)
	local center_point, area_radius_sq = self._calculate_center_of_volume(self, volume_mapping)
	local range = math.sqrt(area_radius_sq) + 1
	local dir = Vector3.flat(Vector3.normalize(selected_unit_pos - center_point))
	local rotation = Quaternion.look(dir, Vector3.up())
	local space_per_player = range - 1
	local points = self._find_points(self, nav_world, Vector3(center_point[1], center_point[2], selected_unit_pos[3]), rotation, self._left_vectors_outside_volume, self._right_vectors_outside_volume, space_per_player, range, needed_points)

	if script_data.ai_bots_debug then
		for k, v in ipairs(points) do
			QuickDrawer:sphere(v, 0.3, Color(255, 0, 255))
		end
	end

	local num_points = #points
	local current_index = 1
	local last_point = points[current_index]

	if num_points < needed_points then
		for i = num_points + 1, needed_points, 1 do
			points[i] = points[current_index] or last_point or origin_point

			if not points[current_index] then
			end

			current_index = current_index + 1
		end
	end

	return points
end
AIBotGroupSystem._find_destination_points = function (self, nav_world, origin_point, rotation, needed_points)
	local range = 3
	local space_per_player = 1
	local points = self._find_points(self, nav_world, origin_point, rotation, self._left_vectors, self._right_vectors, space_per_player, range, needed_points)

	if script_data.ai_bots_debug then
		for k, v in ipairs(points) do
			QuickDrawer:sphere(v, 0.3, Color(255, 0, 255))
		end
	end

	if #points < needed_points then
		for i = #points + 1, needed_points, 1 do
			points[i] = origin_point
		end
	end

	return points
end
AIBotGroupSystem._find_points = function (self, nav_world, origin_point, rotation, left_vectors, right_vectors, space_per_player, range, needed_points)
	local found_points_left = 0
	local found_points_right = 0
	local left_index = 0
	local right_index = 0
	local points = self._pathing_points or {}
	self._pathing_points = points

	table.clear(points)

	local function add_points(points, from_pos, to_pos, amount)
		if amount == 0 then
			return 
		end

		for i = 1, amount, 1 do
			local pos = Vector3.lerp(from_pos, to_pos, i/amount)
			points[#points + 1] = pos
		end

		return 
	end

	while (left_index < #left_vectors or right_index < #right_vectors) and found_points_left + found_points_right < needed_points do

		-- decompilation error in this vicinity
		right_index = right_index + 1
		local distance, hit_pos = self._raycast(self, nav_world, origin_point, Quaternion.rotate(rotation, right_vectors[right_index]:unbox()), range)
		local num_points = math.floor(distance/space_per_player)

		add_points(points, origin_point, hit_pos, num_points)

		found_points_right = found_points_right + num_points
	end

	local num_points = #points

	return points
end
local LARGE_VALUE = 10000
local SPACE_NEEDED = 0.25
AIBotGroupSystem._raycast = function (self, nav_world, point, vector, range)
	local ray_range = range + SPACE_NEEDED
	local to = point + vector*ray_range
	local success, pos = GwNavQueries.raycast(nav_world, point, to)

	if script_data.ai_bots_debug then
		QuickDrawer:line(point, point + vector*ray_range + Vector3(0, 0, 0.1), Color(255, 0, 0))
	end

	if success then
		return range, pos - vector*SPACE_NEEDED, true
	elseif math.min(pos.x, pos.y, pos.z) < -LARGE_VALUE or LARGE_VALUE < math.max(pos.x, pos.y, pos.z) then
		Application.warning("GwNavQueries.raycast() returned an extreme value %s, falling back to point of origin", pos)

		return 0, point, false
	else
		local distance = Vector3.length(Vector3.flat(pos - point))

		if distance < SPACE_NEEDED then
			return 0, point, false
		else
			return distance - SPACE_NEEDED, pos - vector*SPACE_NEEDED, success
		end
	end

	return 
end
AIBotGroupSystem._update_priority_targets = function (self, dt, t)
	for _, player in pairs(Managers.player:players()) do
		local player_unit = player.player_unit

		if Unit.alive(player_unit) then
			local status_ext = ScriptUnit.extension(player_unit, "status_system")
			local target = nil

			if status_ext.is_pounced_down(status_ext) then
				target = status_ext.get_pouncer_unit(status_ext)
			elseif status_ext.is_grabbed_by_pack_master(status_ext) then
				target = status_ext.get_pack_master_grabber(status_ext)
			end

			if AiUtils.unit_alive(target) then
				PRIORITY_TARGETS_TEMP[player_unit] = target
				NEW_TARGETS[target] = (OLD_TARGETS[target] or 0) + dt
			end
		end
	end

	for unit, data in pairs(self._bot_ai_data) do
		if not Unit.alive(data.current_priority_target) then
			data.current_priority_target = nil
		end

		local status_ext = ScriptUnit.extension(unit, "status_system")

		table.clear(data.priority_targets)

		if PRIORITY_TARGETS_TEMP[unit] or status_ext.is_disabled(status_ext) then
			data.current_priority_target_disabled_ally = nil
			data.current_priority_target = nil
			data.priority_target_distance = math.huge
		else
			local self_pos = POSITION_LOOKUP[unit]
			local targets = data.targets
			local best_target, best_ally = nil
			local best_utility = -math.huge
			local best_distance = math.huge

			for ally, target in pairs(PRIORITY_TARGETS_TEMP) do
				local utility, distance = self._calculate_priority_target_utility(self, self_pos, target, NEW_TARGETS[target], data.current_priority_target)
				data.priority_targets[target] = utility

				if best_utility < utility then
					best_utility = utility
					best_target = target
					best_distance = distance
					best_ally = ally
				end
			end

			data.current_priority_target_disabled_ally = best_ally
			data.current_priority_target = best_target
			data.priority_target_distance = best_distance
		end

		local ai_extension = ScriptUnit.extension(unit, "ai_system")
		local bb = ai_extension.blackboard(ai_extension)
		bb.priority_target_disabled_ally = data.current_priority_target_disabled_ally
		bb.priority_target_enemy = data.current_priority_target
		bb.priority_target_distance = data.priority_target_distance
	end

	table.clear(PRIORITY_TARGETS_TEMP)

	local old_foes = NEW_TARGETS
	NEW_TARGETS = OLD_TARGETS

	table.clear(NEW_TARGETS)

	OLD_TARGETS = old_foes

	return 
end
local FALLBACK_OPPORTUNITY_DISTANCE = 15
local RAT_OGRE_ENGAGE_DISTANCE = 15
AIBotGroupSystem._update_urgent_targets = function (self, dt, t)
	local conflict_director = Managers.state.conflict
	local alive_specials = conflict_director.alive_specials(conflict_director)
	local spawned_rat_ogres = conflict_director.spawned_units_by_breed(conflict_director, "skaven_rat_ogre")

	for bot_unit, data in pairs(self._bot_ai_data) do
		local best_utility = -math.huge
		local best_target = nil
		local best_distance = math.huge
		local blackboard = Unit.get_data(bot_unit, "blackboard")
		local self_pos = POSITION_LOOKUP[bot_unit]
		local old_target = blackboard.urgent_target_enemy
		local revive_during_urgent = false

		for target_unit, is_target_until in pairs(self._urgent_targets) do
			local time_left = is_target_until - t

			if 0 < time_left then
				if AiUtils.unit_alive(target_unit) then
					local utility, distance = self._calculate_opportunity_utility(self, bot_unit, self_pos, old_target, target_unit, t, true)

					if best_utility < utility then
						best_utility = utility
						best_target = target_unit
						best_distance = distance
					end
				end
			else
				self._urgent_targets[target_unit] = nil
			end
		end

		if not best_target then
			for _, target_unit in pairs(spawned_rat_ogres) do
				local pos = POSITION_LOOKUP[target_unit]

				if AiUtils.unit_alive(target_unit) and Vector3.distance(pos, self_pos) < RAT_OGRE_ENGAGE_DISTANCE then
					local utility, distance = self._calculate_opportunity_utility(self, bot_unit, self_pos, old_target, target_unit, t, false)

					if best_utility < utility then
						best_utility = utility
						best_target = target_unit
						best_distance = distance
						revive_during_urgent = true
					end
				end
			end
		end

		blackboard.revive_with_urgent_target = revive_during_urgent
		blackboard.urgent_target_enemy = best_target
		blackboard.urgent_target_distance = best_distance
		best_utility = -math.huge
		best_target = nil
		best_distance = math.huge
		old_target = blackboard.opportunity_target_enemy

		for _, target_unit in ipairs(alive_specials) do
			local pos = POSITION_LOOKUP[target_unit]

			if AiUtils.unit_alive(target_unit) and Vector3.distance(pos, self_pos) < FALLBACK_OPPORTUNITY_DISTANCE then
				local utility, distance = self._calculate_opportunity_utility(self, bot_unit, self_pos, old_target, target_unit, t, false)

				if best_utility < utility then
					best_utility = utility
					best_target = target_unit
					best_distance = distance
				end
			end
		end

		blackboard.opportunity_target_enemy = best_target
		blackboard.opportunity_target_distance = best_distance
	end

	return 
end
AIBotGroupSystem._calculate_opportunity_utility = function (self, bot_unit, self_position, current_target, potential_target, t, force_seen)
	local prox_ext = ScriptUnit.has_extension(potential_target, "proximity_system")
	local distance = math.max(Vector3.length(self_position - POSITION_LOOKUP[potential_target]), 1)

	if prox_ext and not prox_ext.has_been_seen and not force_seen then
		return -math.huge, math.huge
	elseif prox_ext then
		local react_at = prox_ext.bot_reaction_times[bot_unit]

		if not react_at then
			prox_ext.bot_reaction_times[bot_unit] = t + Math.random(0.2, 0.65)

			return -math.huge, math.huge
		elseif t < react_at then
			return -math.huge, math.huge
		end
	end

	stickyness_modifier = (potential_target == current_target and STICKYNESS_DISTANCE_MODIFIER) or 0
	local proximity = (distance + stickyness_modifier)/1

	return proximity, distance
end
AIBotGroupSystem._update_pickups = function (self, dt, t)
	local players = Managers.player:players()

	Profiler.start("update pickups")
	Profiler.start("do overlaps")

	if self._update_pickups_at < t then
		self._update_pickups_at = t + 0.15 + Math.random()*0.1
		local last_key = self._last_key_in_available_pickups

		if last_key ~= nil and not players[last_key] then
			last_key = nil
		end

		local key, player = next(players, last_key)

		if not key then
			key, player = next(players)
		end

		self._last_key_in_available_pickups = key
		local player_unit = player.player_unit

		if AiUtils.unit_alive(player_unit) and not ScriptUnit.extension(player_unit, "status_system"):is_ready_for_assisted_respawn() then
			self._update_pickups_near_player(self, player_unit, t)
		end
	end

	Profiler.stop("do overlaps")
	Profiler.start("update who takes what health")
	self._update_health_pickups(self, dt, t)
	Profiler.stop("update who takes what health")
	Profiler.stop("update pickups")

	return 
end
local PICKUP_CHECK_RANGE = 15
local PICKUP_FETCH_RESULTS = {}
AIBotGroupSystem._update_pickups_near_player = function (self, unit, t)
	local self_pos = POSITION_LOOKUP[unit]
	local hp_pickups = self._available_health_pickups
	local bot_ai_data = self._bot_ai_data
	local num_pickups = Managers.state.entity:system("pickup_system"):get_pickups(self_pos, PICKUP_CHECK_RANGE, PICKUP_FETCH_RESULTS)
	local valid_until = t + 5

	for unit, data in pairs(bot_ai_data) do
		local blackboard = data.blackboard
		local ammo_pickup = blackboard.ammo_pickup

		if Unit.alive(ammo_pickup) then
			data.ammo_dist = Vector3.distance(POSITION_LOOKUP[unit], POSITION_LOOKUP[ammo_pickup])
		else
			blackboard.ammo_pickup = nil
			data.ammo_dist = nil
		end
	end

	local ammo_stickiness = 2.5
	local allowed_distance_to_self = 5
	local allowed_distance_to_follow_pos = 15

	for i = 1, num_pickups, 1 do
		local pickup_unit = PICKUP_FETCH_RESULTS[i]
		local pickup_extension = ScriptUnit.has_extension(pickup_unit, "pickup_system")
		local aware_extension = ScriptUnit.has_extension(pickup_unit, "surrounding_aware_system")

		if pickup_extension and (not aware_extension or aware_extension.has_been_seen or ScriptUnit.extension(pickup_unit, "ping_system"):pinged()) then
			local pickup_name = pickup_extension.pickup_name

			if pickup_name == "healing_draught" or pickup_name == "first_aid_kit" or pickup_name == "tome" then
				local template = BackendUtils.get_item_template(ItemMasterList[AllPickups[pickup_name].item_name])

				if not hp_pickups[pickup_unit] then
					hp_pickups[pickup_unit] = {
						template = template,
						valid_until = valid_until
					}
				else
					hp_pickups[pickup_unit].valid_until = valid_until
					hp_pickups[pickup_unit].template = template
				end
			elseif pickup_name == "all_ammo" then
				for unit, data in pairs(bot_ai_data) do
					local bb = data.blackboard
					local current_pickup = bb.ammo_pickup
					local pickup_pos = POSITION_LOOKUP[pickup_unit]
					local dist = Vector3.distance(POSITION_LOOKUP[unit], pickup_pos)
					local follow_pos = data.follow_position

					if (dist < allowed_distance_to_self or (follow_pos and Vector3.distance(follow_pos, pickup_pos) < allowed_distance_to_follow_pos)) and (not current_pickup or dist - ((current_pickup == pickup_unit and ammo_stickiness) or 0) < data.ammo_dist) then
						bb.ammo_pickup = pickup_unit
						bb.ammo_pickup_valid_until = valid_until
						bb.ammo_dist = dist
						data.ammo_dist = dist
					end
				end
			end
		end
	end

	table.clear(PICKUP_FETCH_RESULTS)

	return 
end
local HEALTH_ITEMS_TEMP = {}
local HEALTH_ITEMS_TEMP_TEMP = {}
local AUXILIARY_HEALTH_SLOT_ITEMS_TEMP = {}
local BOT_BBS = {}
local BOT_POSES = {}
local BOT_UNITS = {}
local BOT_HEALTH = {}
local SOLUTION_TEMP = {}
local BEST_SOLUTION_TEMP = {}
local BOT_INDICES = {}
local MAX_PICKUP_RANGE = 15
AIBotGroupSystem._update_health_pickups = function (self, dt, t)
	local available_pickups = self._available_health_pickups
	local num_health_items = 0
	local num_aux_items = 0

	for unit, info in pairs(available_pickups) do
		if not Unit.alive(unit) or info.valid_until < t then
			available_pickups[unit] = nil
		elseif info.template.can_heal_self then
			num_health_items = num_health_items + 1
			HEALTH_ITEMS_TEMP[unit] = POSITION_LOOKUP[unit]
		else
			num_aux_items = num_aux_items + 1
			AUXILIARY_HEALTH_SLOT_ITEMS_TEMP[unit] = POSITION_LOOKUP[unit]
		end
	end

	local lowest_human_hp_percent = math.huge

	for _, player in pairs(Managers.player:human_players()) do
		local player_unit = player.player_unit

		if AiUtils.unit_alive(player_unit) then
			local inventory_ext = ScriptUnit.extension(player_unit, "inventory_system")
			local status_ext = ScriptUnit.extension(player_unit, "status_system")
			local med_item = inventory_ext.get_slot_data(inventory_ext, "slot_healthkit")
			local health_extension = ScriptUnit.extension(player_unit, "health_system")

			if not med_item and not status_ext.is_ready_for_assisted_respawn(status_ext) then
				local closest_dist = math.huge
				local closest_item = nil
				local pos = POSITION_LOOKUP[player_unit]

				if 0 < num_health_items then
					for unit, item_pos in pairs(HEALTH_ITEMS_TEMP) do
						local dist = Vector3.distance_squared(pos, item_pos)

						if dist < closest_dist then
							closest_dist = dist
							closest_item = unit
						end
					end

					num_health_items = num_health_items - 1
					HEALTH_ITEMS_TEMP[closest_item] = nil
				elseif 0 < num_aux_items then
					for unit, item_pos in pairs(AUXILIARY_HEALTH_SLOT_ITEMS_TEMP) do
						local dist = Vector3.distance_squared(pos, item_pos)

						if dist < closest_dist then
							closest_dist = dist
							closest_item = unit
						end
					end

					num_aux_items = num_aux_items - 1
					AUXILIARY_HEALTH_SLOT_ITEMS_TEMP[closest_item] = nil
				end
			end

			if status_ext.is_knocked_down(status_ext) or status_ext.is_wounded(status_ext) then
				lowest_human_hp_percent = math.min(0, lowest_human_hp_percent)
			else
				local health_percent = health_extension.current_health_percent(health_extension)
				lowest_human_hp_percent = math.min(health_percent, lowest_human_hp_percent)
			end
		end
	end

	local num_valid_bots = 0
	local lowest_bot_health_procent = math.huge
	local lowest_hp_bot_has_item = false
	local lowest_hp_bot_blackboard = nil

	for unit, _ in pairs(self._bot_ai_data) do
		local blackboard = Unit.get_data(unit, "blackboard")
		blackboard.allowed_to_take_health_pickup = false
		blackboard.force_use_health_pickup = false
		local inventory_ext = ScriptUnit.extension(unit, "inventory_system")
		local status_ext = ScriptUnit.extension(unit, "status_system")
		local health_slot_data = inventory_ext.get_slot_data(inventory_ext, "slot_healthkit")
		local has_heal_item = health_slot_data and inventory_ext.get_item_template(inventory_ext, health_slot_data).can_heal_self

		if not has_heal_item and AiUtils.unit_alive(unit) and not status_ext.is_ready_for_assisted_respawn(status_ext) then
			num_valid_bots = num_valid_bots + 1
			BOT_UNITS[num_valid_bots] = unit
			BOT_BBS[num_valid_bots] = blackboard
			BOT_POSES[num_valid_bots] = POSITION_LOOKUP[unit]
			local health_extension = ScriptUnit.extension(unit, "health_system")
			local hp_percent = health_extension.current_health_percent(health_extension)

			if status_ext.is_wounded(status_ext) then
				hp_percent = hp_percent/3
			end

			BOT_HEALTH[num_valid_bots] = hp_percent

			if hp_percent < lowest_bot_health_procent then
				lowest_bot_health_procent = hp_percent
				lowest_hp_bot_has_item = false
				lowest_hp_bot_blackboard = nil
			end

			BOT_INDICES[unit] = num_valid_bots
		elseif has_heal_item and AiUtils.unit_alive(unit) and not status_ext.is_ready_for_assisted_respawn(status_ext) then
			local health_extension = ScriptUnit.extension(unit, "health_system")
			local hp_percent = health_extension.current_health_percent(health_extension)

			if hp_percent < lowest_bot_health_procent then
				lowest_bot_health_procent = hp_percent
				lowest_hp_bot_has_item = true
				lowest_hp_bot_blackboard = blackboard
			end
		end
	end

	table.merge(HEALTH_ITEMS_TEMP_TEMP, HEALTH_ITEMS_TEMP)

	local stickiness = 225
	local hp_distance_modifier = 225
	local more_items_than_players = num_valid_bots < num_health_items

	local function find_permutation(current_bot_index, current_utility, solution, best_utility, best_solution, empties_left, health_item_lookup, health_item_list, num_valid_bots)
		if num_valid_bots < current_bot_index then
			if current_utility < best_utility then
				for i = 1, num_valid_bots, 1 do
					best_solution[i] = solution[i]
				end

				return current_utility
			else
				return best_utility
			end
		else
			local bb = BOT_BBS[current_bot_index]
			local bot_pos = BOT_POSES[current_bot_index]
			local current_pickup = bb.health_pickup
			local bot_hp = BOT_HEALTH[current_bot_index] or 0

			for unit, pos in pairs(health_item_list) do
				if health_item_lookup[unit] then
					local stickiness_modifier = (current_pickup == unit and stickiness) or 0
					local utility = (current_utility + Vector3.distance_squared(bot_pos, pos)) - stickiness_modifier - bot_hp*hp_distance_modifier
					health_item_lookup[unit] = nil
					solution[current_bot_index] = unit
					best_utility = find_permutation(current_bot_index + 1, utility, solution, best_utility, best_solution, empties_left, health_item_lookup, health_item_list, num_valid_bots)
					solution[current_bot_index] = nil
					health_item_lookup[unit] = pos
				end
			end

			if 0 < empties_left then
				best_utility = find_permutation(current_bot_index + 1, current_utility, solution, best_utility, best_solution, empties_left - 1, health_item_lookup, health_item_list, num_valid_bots)
			end

			return best_utility
		end

		return 
	end

	local allowed_empties = math.max(0, num_valid_bots - num_health_items)

	find_permutation(1, 0, SOLUTION_TEMP, math.huge, BEST_SOLUTION_TEMP, allowed_empties, HEALTH_ITEMS_TEMP_TEMP, HEALTH_ITEMS_TEMP, num_valid_bots)
	table.clear(BOT_HEALTH)

	for unit, data in pairs(self._bot_ai_data) do
		local index = BOT_INDICES[unit]

		if index then
			local bb = BOT_BBS[index]
			local pickup = BEST_SOLUTION_TEMP[index]

			if pickup then
				bb.health_pickup = pickup
				local pickup_pos = POSITION_LOOKUP[pickup]
				local health_dist = Vector3.distance(BOT_POSES[index], pickup_pos)
				bb.health_dist = health_dist
				bb.health_pickup_valid_until = math.huge
				local follow_pos = data.follow_position
				local in_range = (not follow_pos and health_dist < MAX_PICKUP_RANGE) or (follow_pos and Vector3.distance(follow_pos, pickup_pos) < MAX_PICKUP_RANGE)

				if in_range then
					bb.allowed_to_take_health_pickup = true
				else
					bb.allowed_to_take_health_pickup = false
				end
			else
				bb.allowed_to_take_health_pickup = false
				bb.health_dist = nil
				bb.health_pickup_valid_until = nil
			end
		else
			local bb = Unit.get_data(unit, "blackboard")
			bb.health_pickup = nil
			bb.allowed_to_take_health_pickup = false
			bb.health_dist = nil
			bb.health_pickup_valid_until = nil
		end
	end

	local current_index = 1

	for i = 1, num_valid_bots, 1 do
		local unit_i = BOT_UNITS[i]
		local inventory_ext = ScriptUnit.extension(unit_i, "inventory_system")
		local has_aux_item = inventory_ext.get_slot_data(inventory_ext, "slot_healthkit")
		local in_solution = BEST_SOLUTION_TEMP[i]

		if not in_solution and not has_aux_item then
			local unit = BOT_UNITS[i]
			BOT_UNITS[current_index] = unit
			BOT_BBS[current_index] = BOT_BBS[i]
			BOT_POSES[current_index] = BOT_POSES[i]
			BOT_INDICES[unit] = current_index
			current_index = current_index + 1
		else
			local unit = BOT_UNITS[i]
			BOT_INDICES[unit] = nil
		end
	end

	for i = current_index, num_valid_bots, 1 do
		BOT_UNITS[i] = nil
		BOT_BBS[i] = nil
		BOT_POSES[i] = nil
	end

	table.clear(HEALTH_ITEMS_TEMP_TEMP)
	table.clear(SOLUTION_TEMP)
	table.clear(BEST_SOLUTION_TEMP)

	num_valid_bots = current_index - 1

	if 0 < num_valid_bots then
		table.merge(HEALTH_ITEMS_TEMP_TEMP, AUXILIARY_HEALTH_SLOT_ITEMS_TEMP)

		local allowed_empties = math.max(0, num_valid_bots - num_aux_items)

		find_permutation(1, 0, SOLUTION_TEMP, math.huge, BEST_SOLUTION_TEMP, allowed_empties, HEALTH_ITEMS_TEMP_TEMP, AUXILIARY_HEALTH_SLOT_ITEMS_TEMP, num_valid_bots)

		for unit, data in pairs(self._bot_ai_data) do
			local index = BOT_INDICES[unit]

			if index then
				local bb = BOT_BBS[index]
				local pickup = BEST_SOLUTION_TEMP[index]

				if pickup then
					bb.health_pickup = pickup
					local pickup_pos = POSITION_LOOKUP[pickup]
					local health_dist = Vector3.distance(BOT_POSES[index], pickup_pos)
					bb.health_dist = health_dist
					bb.health_pickup_valid_until = math.huge
					local follow_pos = data.follow_position
					local in_range = (not follow_pos and health_dist < MAX_PICKUP_RANGE) or (follow_pos and Vector3.distance(follow_pos, pickup_pos) < MAX_PICKUP_RANGE)

					if in_range then
						bb.allowed_to_take_health_pickup = true
					else
						bb.allowed_to_take_health_pickup = false
					end
				else
					bb.allowed_to_take_health_pickup = false
					bb.health_dist = nil
					bb.health_pickup_valid_until = nil
				end
			end
		end

		table.clear(HEALTH_ITEMS_TEMP_TEMP)
		table.clear(SOLUTION_TEMP)
		table.clear(BEST_SOLUTION_TEMP)
	end

	table.clear(BOT_BBS)
	table.clear(BOT_UNITS)
	table.clear(BOT_POSES)
	table.clear(BOT_INDICES)
	table.clear(HEALTH_ITEMS_TEMP)
	table.clear(AUXILIARY_HEALTH_SLOT_ITEMS_TEMP)

	if not self._in_carry_event and more_items_than_players and lowest_hp_bot_has_item and math.min(lowest_bot_health_procent*1.2, 1) < lowest_human_hp_percent then
		lowest_hp_bot_blackboard.force_use_health_pickup = true
	end

	return 
end
AIBotGroupSystem._calculate_priority_target_utility = function (self, self_position, target, time, current_target)
	local stickyness_modifier = (target == current_target and STICKYNESS_DISTANCE_MODIFIER) or 0
	local distance = math.max(Vector3.length(self_position - POSITION_LOOKUP[target]), 1)
	local proximity = (distance + stickyness_modifier)/1
	local duration = time

	return proximity + duration, distance
end
AIBotGroupSystem._update_first_person_debug = function (self)
	if not script_data.ai_bots_debug then
		return 
	end

	if Keyboard.pressed(Keyboard.button_index("numpad 1")) then
		self.first_person_debug(self, 1)
	elseif Keyboard.pressed(Keyboard.button_index("numpad 2")) then
		self.first_person_debug(self, 2)
	elseif Keyboard.pressed(Keyboard.button_index("numpad 3")) then
		self.first_person_debug(self, 3)
	elseif Keyboard.pressed(Keyboard.button_index("numpad enter")) then
		self.first_person_debug(self, nil)
	end

	return 
end
AIBotGroupSystem._update_ally_needs_aid_priority = function (self)
	local unit_alive = Unit.alive

	for target_unit, bot_unit in pairs(self._ally_needs_aid_priority) do
		if not unit_alive(bot_unit) or Unit.get_data(bot_unit, "blackboard").target_ally_unit ~= target_unit or not ScriptUnit.extension(bot_unit, "health_system"):is_alive() then
			self._ally_needs_aid_priority[target_unit] = nil
		end
	end

	return 
end
AIBotGroupSystem.first_person_debug = function (self, bot_number)
	if bot_number == self._debugging_bot then
		return 
	end

	local local_player = nil
	local human_players = Managers.player:human_players()

	for _, player in pairs(human_players) do
		if not player.remote then
			local_player = player

			break
		end
	end

	local new_player = nil

	if bot_number then
		new_player = Managers.player:local_player(bot_number + 1)
	else
		new_player = local_player
	end

	if not new_player then
		return 
	end

	local new_unit = new_player.player_unit

	if not Unit.alive(new_unit) then
		return 
	end

	local old_player = nil

	if self._debugging_bot then
		old_player = Managers.player:local_player(self._debugging_bot + 1)
	else
		old_player = local_player
	end

	local old_unit = old_player.player_unit

	if not Unit.alive(old_unit) then
		return 
	end

	if not Managers.state.camera:has_viewport(new_player.viewport_name) then
		Managers.state.entity:system("camera_system"):local_player_created(new_player)
	end

	local world = self._world

	ScriptWorld.activate_viewport(world, ScriptWorld.viewport(world, new_player.viewport_name))
	ScriptWorld.deactivate_viewport(world, ScriptWorld.viewport(world, old_player.viewport_name))
	ScriptUnit.extension(new_unit, "first_person_system"):debug_set_first_person_mode(new_player ~= local_player, true)
	ScriptUnit.extension(old_unit, "first_person_system"):debug_set_first_person_mode(old_player == local_player, false)

	self._debugging_bot = bot_number

	return 
end
AIBotGroupSystem.ranged_attack_started = function (self, attacker_unit, victim_unit, attack_type)
	if DamageUtils.is_player_unit(victim_unit) then
		for unit, data in pairs(self._bot_ai_data) do
			local ai_ext = ScriptUnit.extension(unit, "ai_system")

			ai_ext.ranged_attack_started(ai_ext, attacker_unit, victim_unit, attack_type)
		end

		fassert(self._urgent_targets[attacker_unit] ~= math.huge, "Attacker unit %s is already attacking another victim! max one victim at a time allowed, otherwise we need to add ref counting", attacker_unit)

		self._urgent_targets[attacker_unit] = math.huge
	end

	return 
end
local OPPORTUNITY_TARGET_COOLDOWN = 30
AIBotGroupSystem.ranged_attack_ended = function (self, attacker_unit, victim_unit, attack_type)
	for unit, data in pairs(self._bot_ai_data) do
		local ai_ext = ScriptUnit.extension(unit, "ai_system")

		ai_ext.ranged_attack_ended(ai_ext, attacker_unit, victim_unit, attack_type)
	end

	self._urgent_targets[attacker_unit] = self._t + OPPORTUNITY_TARGET_COOLDOWN

	return 
end
AIBotGroupSystem.register_ally_needs_aid_priority = function (self, bot_unit, target_unit)
	local ally = self._ally_needs_aid_priority[target_unit]

	if not ally then
		self._ally_needs_aid_priority[target_unit] = bot_unit
	end

	return 
end
AIBotGroupSystem.is_prioritized_ally = function (self, bot_unit, target_unit)
	return self._ally_needs_aid_priority[target_unit] == bot_unit
end
local BROADPHASE_RESULTS = {}
AIBotGroupSystem.bot_breakable = function (self, bot_unit)
	local bot_pos = POSITION_LOOKUP[bot_unit]

	Broadphase.query(self._bot_breakables_broadphase, bot_pos, 2, BROADPHASE_RESULTS)

	local hit_unit = BROADPHASE_RESULTS[1]

	if 1 < #BROADPHASE_RESULTS then
		local min_distance = math.huge

		for _, unit in pairs(BROADPHASE_RESULTS) do
			local distance_squared = Vector3.distance_squared(bot_pos, Unit.local_position(unit, 0))

			if distance_squared < min_distance then
				hit_unit = unit
			end
		end
	end

	table.clear(BROADPHASE_RESULTS)

	return hit_unit
end
AIBotGroupSystem.set_in_cover = function (self, bot_unit, cover_unit)
	self._used_covers[bot_unit] = cover_unit

	return 
end
AIBotGroupSystem.in_cover = function (self, cover_unit)
	for bot_unit, cover in pairs(self._used_covers) do
		if cover == cover_unit then
			return bot_unit
		end
	end

	return nil
end

return 