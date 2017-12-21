PlayerBotNavigation = class(PlayerBotNavigation)
PlayerBotNavigation.init = function (self, extension_init_context, unit, extension_init_data)
	self._unit = unit
	self._nav_world = extension_init_data.nav_world
	self._final_goal_reached = false
	self._player = Managers.player:owner(unit)
	self._destination = Vector3Box(0, 0, 0)
	self._traverse_data = Managers.state.bot_nav_transition:traverse_logic()
	self._has_queued_target = false
	self._queued_target_position = Vector3Box(0, 0, 0)
	self._active_nav_transitions = {}
	self._is_inside_transition = false
	self._astar = GwNavAStar.create()
	self._running_astar = false
	self._path = nil
	self._last_successful_path = 0
	self._successive_failed_paths = 0
	self._close_to_goal_time = nil
	self._teleported = false

	return 
end
PlayerBotNavigation.destroy = function (self)
	if not GwNavAStar.processing_finished(self._astar) then
		GwNavAStar.cancel(self._astar)
	end

	GwNavAStar.destroy(self._astar)

	return 
end
PlayerBotNavigation.reset = function (self)
	return 
end
PlayerBotNavigation.update = function (self, unit, input, dt, context, t)
	if self._teleported then
		self._teleported = false
	end

	self._update_nav_transitions(self, dt, t)

	if self._running_astar then
		self._update_astar(self, t)
	end

	self._update_path(self, t)

	return 
end
local SAME_DIRECTION_THRESHOLD = math.cos(math.pi/8)
PlayerBotNavigation.move_to = function (self, target_position, callback)
	fassert(not callback or type(callback) == "function", "Tried to pass invalid callback value to PlayerBotNavigation:move_to()")

	if self._teleported then
		print("Can't path, just teleported, need to wait for command queue to be flushed")

		return false
	end

	if self._is_inside_transition and not self._final_goal_reached and (self._path or self._running_astar) then
		return false
	end

	if self._running_astar then
		self._has_queued_target = true

		self._queued_target_position:store(target_position)

		self._queued_path_callback = callback

		return false
	end

	local position = POSITION_LOOKUP[self._unit]
	local above = 0.75
	local below = 0.5
	local success, z = GwNavQueries.triangle_from_position(self._nav_world, position, above, below)

	if success then
		position = Vector3(position.x, position.y, z)
	end

	GwNavAStar.start_with_propagation_box(self._astar, self._nav_world, position, target_position, 30, self._traverse_data)

	self._running_astar = true

	if not self._final_goal_reached and SAME_DIRECTION_THRESHOLD < Vector3.dot(Vector3.normalize(target_position - position), Vector3.normalize(self._destination:unbox() - position)) then
		self._last_path = self._path
		self._last_path_index = self._path_index
	end

	self._path = nil
	self._path_index = 0
	self._close_to_goal_time = nil
	self._final_goal_reached = false

	self._destination:store(target_position)

	self._path_callback = callback

	return true
end
PlayerBotNavigation.teleport = function (self, destination)
	if self._running_astar and not GwNavAStar.processing_finished(self._astar) then
		GwNavAStar.cancel(self._astar)

		self._running_astar = false
		self._teleported = true
	end

	self._has_queued_target = false
	self._queued_path_callback = nil
	self._final_goal_reached = true
	self._path = nil
	self._path_index = 0
	self._path_callback = nil

	self._destination:store(destination)

	self._successive_failed_paths = 0
	self._close_to_goal_time = nil

	return 
end
PlayerBotNavigation._update_path = function (self, t)
	local path = self._path

	if not path or self._final_goal_reached then
		return 
	end

	local position = POSITION_LOOKUP[self._unit]
	local current_goal = path[self._path_index]:unbox()
	local previous_goal = path[self._path_index - 1]:unbox()
	local goal_reached = self._goal_reached(self, position, current_goal, previous_goal, t)

	if goal_reached then
		self._path_index = self._path_index + 1
		self._final_goal_reached = #path < self._path_index
	end

	if script_data.ai_bots_debug then
		local color = self._player.color:unbox()
		local drawer = Managers.state.debug:drawer({
			mode = "immediate",
			name = "PlayerBotNavigation"
		})

		drawer.vector(drawer, previous_goal, position - previous_goal, color)
		drawer.vector(drawer, position, current_goal - position, color)

		for i = 1, #self._path - 1, 1 do
			drawer.vector(drawer, self._path[i]:unbox(), self._path[i + 1]:unbox() - self._path[i]:unbox(), color)
		end
	end

	return 
end
local FLAT_THRESHOLD_DEFAULT = 0.05
local TIME_UNTIL_RAMP_THRESHOLD = 0.25
local MAX_FLAT_THRESHOLD = 0.2
local RAMP_TIME = 0.25
local RAMP_SPEED = (MAX_FLAT_THRESHOLD - FLAT_THRESHOLD_DEFAULT)/RAMP_TIME
PlayerBotNavigation._goal_reached = function (self, position, goal, previous_goal, t)
	local unit_to_goal_direction = goal - position
	local previous_to_goal_direction = goal - previous_goal
	local dot = Vector3.dot(unit_to_goal_direction, previous_to_goal_direction)
	local passed_goal = dot < 0
	local remaining = goal - position
	local distance_z = remaining.z
	local flat_distance = Vector3.length(Vector3.flat(remaining))
	local flat_threshold = FLAT_THRESHOLD_DEFAULT

	if self._close_to_goal_time then
		flat_threshold = math.clamp(flat_threshold + (t - self._close_to_goal_time - TIME_UNTIL_RAMP_THRESHOLD)*RAMP_SPEED, FLAT_THRESHOLD_DEFAULT, MAX_FLAT_THRESHOLD)
	end

	local at_goal = flat_distance < flat_threshold and -0.35 < distance_z and distance_z < 0.5
	local goal_reached = passed_goal or at_goal

	if goal_reached then
		self._close_to_goal_time = nil
	elseif flat_distance < MAX_FLAT_THRESHOLD and not self._close_to_goal_time then
		self._close_to_goal_time = t
	end

	return goal_reached
end
PlayerBotNavigation.current_goal = function (self)
	if self._final_goal_reached then
		return nil
	elseif self._path then
		return self._path[self._path_index]:unbox()
	elseif self._last_path then
		return self._last_path[self._last_path_index]:unbox()
	else
		return nil
	end

	return 
end
PlayerBotNavigation.is_following_last_goal = function (self)
	if self._final_goal_reached then
		return false
	elseif self._path then
		return self._path_index == #self._path
	elseif self._last_path then
		return self._last_path_index == #self._last_path
	else
		return false
	end

	return 
end
PlayerBotNavigation.destination_reached = function (self)
	return self._final_goal_reached
end
PlayerBotNavigation._update_astar = function (self, t)
	local astar = self._astar
	local result = GwNavAStar.processing_finished(astar)

	if result then
		if GwNavAStar.path_found(astar) then
			local num_nodes = GwNavAStar.node_count(astar)

			fassert(0 < num_nodes, "Number of nodes in returned path is not greater than 0.")

			local path_last_node_pos = GwNavAStar.node_at_index(astar, num_nodes)
			local found_nav_mesh, z = GwNavQueries.triangle_from_position(self._nav_world, path_last_node_pos, 0.3, 0.3, self._traverse_data)
			local last_node_pos = nil

			if found_nav_mesh then
				last_node_pos = Vector3Box(path_last_node_pos.x, path_last_node_pos.y, z)
			else
				last_node_pos = nil
			end

			if not found_nav_mesh and num_nodes <= 2 then
				self._path_failed(self, t)
			else
				self._path = Script.new_array(num_nodes)

				self._path_successful(self, t)

				for i = 1, num_nodes - 1, 1 do
					local pos = GwNavAStar.node_at_index(astar, i)
					self._path[i] = Vector3Box(pos)
				end

				self._path[num_nodes] = last_node_pos
				self._path_index = 2
				self._close_to_goal_time = nil
			end
		else
			self._path_failed(self, t)
		end

		self._running_astar = false
		self._last_path = nil
		self._last_path_index = nil

		if self._has_queued_target then
			self._has_queued_target = false

			self.move_to(self, self._queued_target_position:unbox(), self._queued_path_callback)

			self._queued_path_callback = nil
		end
	end

	return 
end
PlayerBotNavigation._path_failed = function (self, t)
	if script_data.debug_ai_movement then
		print("AI bot failed to find path")
	end

	self._successive_failed_paths = self._successive_failed_paths + 1
	local cb = self._path_callback

	if cb then
		cb(false, self._destination:unbox())
	end

	return 
end
PlayerBotNavigation._path_successful = function (self, t)
	if script_data.ai_bots_debug then
		self._debug_draw_path(self)
	end

	self._last_successful_path = t
	self._successive_failed_paths = 0
	local cb = self._path_callback

	if cb then
		cb(true, self._destination:unbox())
	end

	return 
end
PlayerBotNavigation.successive_failed_paths = function (self)
	return self._successive_failed_paths, self._last_successful_path
end
PlayerBotNavigation.destination = function (self)
	if self._has_queued_target then
		return self._queued_target_position:unbox()
	else
		return self._destination:unbox()
	end

	return 
end
PlayerBotNavigation._debug_draw_path = function (self)
	if self._path then
		local drawer_name = "bot_astar" .. self._player.player_name
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = drawer_name
		})

		drawer.reset(drawer)

		for index, position in ipairs(self._path) do
			local size = math.lerp(0.15, 0.3, (index - 1)/(#self._path - 1))

			drawer.sphere(drawer, position.unbox(position), size, self._player.color:unbox())
		end
	end

	return 
end
PlayerBotNavigation._update_nav_transitions = function (self, dt, t)
	local transitions = self._active_nav_transitions
	local was_inside = self._is_inside_transition
	local best_t = -math.huge

	for unit, data in pairs(transitions) do
		local enter_time = data.t

		if not Unit.alive(unit) then
			transitions[unit] = nil
		elseif best_t < enter_time then
			best_t = enter_time
		end
	end

	if t < best_t + 10 then
		self._is_inside_transition = true
	else
		self._is_inside_transition = false
	end

	return 
end
PlayerBotNavigation.is_in_transition = function (self)
	return self._is_inside_transition
end
PlayerBotNavigation.transition_requires_jump = function (self, position, direction)
	local current_goal = self.current_goal(self)

	if not self._is_inside_transition or not current_goal then
		return false
	end

	for unit, data in pairs(self._active_nav_transitions) do
		local from = data.position:unbox()

		if data.type == "bot_leap_of_faith" and Vector3.dot(from - position, direction) < 0 and 0.981 < Vector3.dot(Vector3.normalize(data.to:unbox() - from), Vector3.normalize(current_goal - position)) then
			return true
		end
	end

	return false
end
PlayerBotNavigation.flow_cb_entered_nav_transition = function (self, transition_unit, actor)
	local transitions = self._active_nav_transitions
	local index = Unit.get_data(transition_unit, "bot_nav_transition_manager_index")
	local type, from, to = Managers.state.bot_nav_transition:transition_data(transition_unit)
	transitions[transition_unit] = {
		t = Managers.time:time("game"),
		type = type,
		position = Vector3Box(from),
		to = Vector3Box(to)
	}

	return 
end
PlayerBotNavigation.flow_cb_left_nav_transition = function (self, transition_unit, actor)
	local transitions = self._active_nav_transitions
	local index = Unit.get_data(transition_unit, "bot_nav_transition_manager_index")
	transitions[transition_unit] = nil

	return 
end

return 
