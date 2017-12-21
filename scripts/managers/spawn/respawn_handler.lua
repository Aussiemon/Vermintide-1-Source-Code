RespawnHandler = class(RespawnHandler, ExtensionSystemBase)
local RESPAWN_DISTANCE = 70
local END_OF_LEVEL_BUFFER = 35
local RESPAWN_TIME = 30
RespawnHandler.init = function (self)
	self._respawnable_players = {}
	self._respawn_units = {}

	return 
end
RespawnHandler.set_respawn_unit_available = function (self, unit)
	local respawn_units = self._respawn_units
	local num_respawn_units = #respawn_units

	for i = 1, num_respawn_units, 1 do
		local respawn_data = respawn_units[i]

		if unit == respawn_data.unit then
			respawn_data.available = true

			break
		end
	end

	return 
end

local function comparator(a, b)
	local distance_a = a.distance_through_level
	local distance_b = b.distance_through_level

	fassert(distance_a, "ctrl-shift-l needs running on loaded level for respawn points")
	fassert(distance_b, "ctrl-shift-l needs running on loaded level for respawn points")

	return distance_a < distance_b
end

RespawnHandler.respawn_unit_spawned = function (self, unit)
	local distance_through_level = Unit.get_data(unit, "distance_through_level")
	self._respawn_units[#self._respawn_units + 1] = {
		available = true,
		unit = unit,
		distance_through_level = distance_through_level
	}

	table.sort(self._respawn_units, comparator)

	return 
end
RespawnHandler.remove_respawn_units_due_to_crossroads = function (self, removed_path_distances, total_main_path_length)
	local to_remove = {}
	local num_removed_dist_pairs = #removed_path_distances
	local respawners = self._respawn_units

	for i = 1, #respawners, 1 do
		local respawner = respawners[i]
		local travel_dist = respawner.distance_through_level

		for j = 1, num_removed_dist_pairs, 1 do
			local dist_pair = removed_path_distances[j]

			if dist_pair[1] < travel_dist and travel_dist < dist_pair[2] then
				to_remove[#to_remove + 1] = i

				break
			end
		end
	end

	for i = #to_remove, 1, -1 do
		table.remove(respawners, to_remove[i])

		to_remove[i] = nil
	end

	return 
end
local ready_players = {}
RespawnHandler.update = function (self, dt, t, player_statuses)
	for _, status in ipairs(player_statuses) do
		if status.health_state == "dead" and not status.ready_for_respawn and not status.respawn_timer then
			local peer_id = status.peer_id
			local local_player_id = status.local_player_id
			local respawn_time = RESPAWN_TIME

			if peer_id or local_player_id then
				local player = Managers.player:player(peer_id, local_player_id)
				local player_unit = player.player_unit

				if Unit.alive(player_unit) then
					local buff_extension = ScriptUnit.extension(player_unit, "buff_system")
					respawn_time = buff_extension.apply_buffs_to_value(buff_extension, respawn_time, StatBuffIndex.FASTER_RESPAWN)
				end
			end

			status.respawn_timer = t + respawn_time
		elseif status.health_state == "dead" and not status.ready_for_respawn and status.respawn_timer < t then
			status.respawn_timer = nil
			status.ready_for_respawn = true
		end
	end

	return 
end
RespawnHandler.get_respawn_unit = function (self)
	local conflict = Managers.state.conflict
	local level_analysis = conflict.level_analysis
	local main_paths = level_analysis.get_main_paths(level_analysis)
	local ahead_position = POSITION_LOOKUP[conflict.main_path_info.ahead_unit]

	if not ahead_position then
		return 
	end

	local path_pos, travel_dist = MainPathUtils.closest_pos_at_main_path(main_paths, ahead_position)
	local total_path_dist = MainPathUtils.total_path_dist()
	local ahead_pos = MainPathUtils.point_on_mainpath(main_paths, travel_dist + RESPAWN_DISTANCE)

	if not ahead_pos then
		ahead_pos = MainPathUtils.point_on_mainpath(main_paths, total_path_dist - END_OF_LEVEL_BUFFER)

		fassert(ahead_pos, "Cannot find point on mainpath to respawn cage")
	end

	path_pos, travel_dist = MainPathUtils.closest_pos_at_main_path(main_paths, ahead_pos)
	local respawn_units = self._respawn_units
	local num_spawners = #respawn_units
	local greatest_distance = 0
	local selected_unit_index = nil

	for i = 1, num_spawners, 1 do
		local respawn_data = respawn_units[i]

		if respawn_data.available then
			local distance_through_level = respawn_data.distance_through_level

			if travel_dist <= distance_through_level then
				selected_unit_index = i

				break
			elseif greatest_distance < distance_through_level then
				selected_unit_index = i
				greatest_distance = distance_through_level
			end
		end
	end

	if not selected_unit_index then
		return nil
	end

	local respawn_data = respawn_units[selected_unit_index]
	local selected_unit = respawn_data.unit
	respawn_data.available = false

	return selected_unit
end
RespawnHandler.destroy = function (self)
	return 
end

return 
