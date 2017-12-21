DoorExtension = class(DoorExtension)
local SIMPLE_ANIMATION_FPS = 30
local NAVMESH_UPDATE_DELAY = 3
local unit_alive = Unit.alive
DoorExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.world = extension_init_context.world
	self.is_server = Managers.player.is_server
	local door_state = Unit.get_data(unit, "door_state")
	self.current_state = (door_state == 0 and "open_forward") or (door_state == 1 and "closed") or (door_state == 2 and "open_backward")
	self.animation_flow_events = {
		closed = {
			open_backward = "lua_open_backward",
			open_forward = "lua_open_forward"
		},
		open_forward = {
			closed = "lua_close_forward",
			open_backward = "lua_swing_forward"
		},
		open_backward = {
			closed = "lua_close_backward",
			open_forward = "lua_swing_backward"
		}
	}
	self.state_to_nav_obstacle_map = {}
	self.animation_stop_time = 0
	self.dead = false
	self.breeds_failed_leaving_smart_object = {}
	self.frames_since_obstacle_update = nil
	self.num_attackers = 0

	return 
end
DoorExtension.extensions_ready = function (self)
	self.health_extension = ScriptUnit.extension(self.unit, "health_system")

	assert(self.health_extension)

	return 
end
DoorExtension.animation_played = function (self, frames, speed)
	local animation_length = frames/SIMPLE_ANIMATION_FPS/speed
	local t = Managers.time:time("game")
	self.animation_stop_time = t + animation_length

	return 
end
DoorExtension.update_nav_obstacles = function (self)
	local current_state = self.current_state
	local obstacles = self.state_to_nav_obstacle_map

	if not obstacles[current_state] then
		local unit = self.unit
		local nav_world = GLOBAL_AI_NAVWORLD
		local obstacle, transform = NavigationUtils.create_exclusive_box_obstacle_from_unit_data(nav_world, unit)

		GwNavBoxObstacle.add_to_world(obstacle)
		GwNavBoxObstacle.set_transform(obstacle, transform)

		obstacles[current_state] = obstacle
	end

	for obstacle_state, obstacle in pairs(obstacles) do
		local does_trigger = obstacle_state == current_state

		GwNavBoxObstacle.set_does_trigger_tagvolume(obstacle, does_trigger)
	end

	self.frames_since_obstacle_update = 0

	return 
end
DoorExtension.interacted_with = function (self, interacting_unit)
	local unit = self.unit
	local current_state = self.current_state
	local new_state = nil

	if current_state == "open_backward" or current_state == "open_forward" then
		new_state = "closed"
	elseif current_state == "closed" then
		local door_position = Unit.world_position(unit, 0)
		local door_rotation = Unit.world_rotation(unit, 0)
		local interactor_position = POSITION_LOOKUP[interacting_unit]
		local difference = door_position - interactor_position
		local direction = Vector3.normalize(Vector3.flat(difference))
		local door_forward = Quaternion.forward(door_rotation)
		local door_direction = Vector3.normalize(Vector3.flat(door_forward))
		local dot = Vector3.dot(direction, door_direction)
		local infront = 0 <= dot

		if infront then
			new_state = "open_backward"
		else
			new_state = "open_forward"
		end
	end

	self.set_door_state(self, new_state)

	return 
end
DoorExtension.set_door_state = function (self, new_state)
	local current_state = self.current_state

	if current_state == new_state then
		return 
	end

	local unit = self.unit
	local animation_flow_event = self._get_animation_flow_event(self, current_state, new_state)

	Unit.flow_event(unit, animation_flow_event)

	local closed = new_state == "closed"

	if not closed then
		World.umbra_set_gate_closed(self.world, unit, closed)
	end

	self.current_state = new_state

	return 
end
DoorExtension.get_current_state = function (self)
	return self.current_state
end
DoorExtension._get_animation_flow_event = function (self, current_state, new_state)
	local event = self.animation_flow_events[current_state][new_state]

	assert(event, "Door animation event from %s to %s unavailable", current_state, new_state)

	return event
end
DoorExtension.update = function (self, unit, input, dt, context, t)
	local frames_since_obstacle_update = self.frames_since_obstacle_update

	if frames_since_obstacle_update then
		frames_since_obstacle_update = frames_since_obstacle_update + 1

		if frames_since_obstacle_update == NAVMESH_UPDATE_DELAY then
			self.handle_breeds_failed_leaving_smart_object(self)

			self.frames_since_obstacle_update = nil
		else
			self.frames_since_obstacle_update = frames_since_obstacle_update
		end
	end

	if not self.is_server or self.dead then
		return 
	end

	local animation_stop_time = self.animation_stop_time

	if animation_stop_time and animation_stop_time <= t then
		self.update_nav_obstacles(self)

		self.animation_stop_time = nil
		local closed = self.current_state == "closed"

		if closed then
			World.umbra_set_gate_closed(self.world, unit, closed)
		end
	end

	if not self.health_extension:is_alive() then
		self.dead = true

		self.destroy_box_obstacles(self)
	end

	return 
end
DoorExtension.register_breed_failed_leaving_smart_object = function (self, unit)
	if self.breeds_failed_leaving_smart_object == nil then
		return 
	end

	self.breeds_failed_leaving_smart_object[unit] = true

	return 
end
DoorExtension.handle_breeds_failed_leaving_smart_object = function (self)
	if self.breeds_failed_leaving_smart_object == nil then
		return 
	end

	for unit, _ in pairs(self.breeds_failed_leaving_smart_object) do
		if unit_alive(unit) then
			local navigation_extension = ScriptUnit.has_extension(unit, "ai_navigation_system")

			if navigation_extension then
				navigation_extension.reset_destination(navigation_extension)
			end
		end
	end

	self.breeds_failed_leaving_smart_object = {}

	return 
end
DoorExtension.hot_join_sync = function (self, sender)
	local level = LevelHelper:current_level(self.world)
	local level_index = Level.unit_index(level, self.unit)
	local door_state = self.current_state
	local door_state_id = NetworkLookup.door_states[door_state]

	RPC.rpc_sync_door_state(sender, level_index, door_state_id)

	return 
end
DoorExtension.destroy = function (self)
	self.destroy_box_obstacles(self)

	self.unit = nil
	self.world = nil
	self.health_extension = nil
	self.breeds_failed_leaving_smart_object = nil

	return 
end
DoorExtension.destroy_box_obstacles = function (self)
	if self.state_to_nav_obstacle_map then
		for _, obstacle in pairs(self.state_to_nav_obstacle_map) do
			GwNavBoxObstacle.destroy(obstacle)
		end

		self.state_to_nav_obstacle_map = nil
	end

	self.frames_since_obstacle_update = 0

	return 
end
DoorExtension.is_open = function (self)
	return self.current_state ~= "closed"
end
DoorExtension.is_opening = function (self)
	return self.current_state ~= "closed" and (self.animation_stop_time or self.frames_since_obstacle_update)
end

return 