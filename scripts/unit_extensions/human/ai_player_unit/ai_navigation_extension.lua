local NAVIGATION_NAVMESH_RADIUS = 0.38
script_data.debug_ai_movement = script_data.debug_ai_movement or Development.parameter("debug_ai_movement")
AINavigationExtension = class(AINavigationExtension)

AINavigationExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._nav_world = extension_init_data.nav_world
	self._unit = unit
	self._enabled = true
	self._max_speed = 0
	self._current_speed = 0
	self._wanted_destination = Vector3Box(Unit.local_position(unit, 0))
	self._destination = Vector3Box()
	self._debug_position_when_starting_search = Vector3Box()
	self._using_smartobject = false
	self._next_smartobject_interval = GwNavSmartObjectInterval.create(self._nav_world)
	self._has_unprocessed_path_request = false
	self._backup_destination = Vector3Box()
	self._original_backup_destination = Vector3Box()
	self._failed_move_attempts = 0
	self._wait_timer = 0
	self._raycast_timer = 0
end

AINavigationExtension.extensions_ready = function (self)
	local blackboard = Unit.get_data(self._unit, "blackboard")
	self._blackboard = blackboard
	blackboard.next_smart_object_data = {
		entrance_pos = Vector3Box(),
		exit_pos = Vector3Box()
	}
	self._far_pathing_allowed = blackboard.breed.cannot_far_path ~= true
end

AINavigationExtension.destroy = function (self)
	self:release_bot()
	GwNavSmartObjectInterval.destroy(self._next_smartobject_interval)
end

AINavigationExtension.release_bot = function (self)
	if self._nav_bot then
		GwNavBot.destroy(self._nav_bot)

		self._nav_bot = nil
	end

	if self._navtag_layer_cost_table then
		GwNavTagLayerCostTable.destroy(self._navtag_layer_cost_table)
		GwNavTraverseLogic.destroy(self._traverse_logic)

		self._navtag_layer_cost_table = nil
		self._traverse_logic = nil
	end
end

AINavigationExtension.init_position = function (self)
	local unit = self._unit
	local nav_world = self._nav_world
	local breed = Unit.get_data(unit, "breed")
	local height = 1.6
	local speed = breed.run_speed
	local pos = Unit.local_position(unit, 0)
	local enable_crowd_dispersion = not script_data.disable_crowd_dispersion and not breed.disable_crowd_dispersion
	self._nav_bot = GwNavBot.create(nav_world, height, NAVIGATION_NAVMESH_RADIUS, speed, pos, enable_crowd_dispersion)
	self._max_speed = speed

	self._destination:store(pos)
	self._wanted_destination:store(pos)

	self._is_avoiding = breed.use_avoidance == true

	GwNavBot.set_use_avoidance(self._nav_bot, self._is_avoiding)

	if not breed.ignore_nav_propagation_box then
		GwNavBot.set_propagation_box(self._nav_bot, 30)
	end

	self._navtag_layer_cost_table = GwNavTagLayerCostTable.create()
	self._traverse_logic = GwNavTraverseLogic.create(nav_world)

	GwNavTraverseLogic.set_navtag_layer_cost_table(self._traverse_logic, self._navtag_layer_cost_table)

	local allowed_layers = {}

	if breed.allowed_layers then
		table.merge(allowed_layers, breed.allowed_layers)
	end

	table.merge(allowed_layers, NAV_TAG_VOLUME_LAYER_COST_AI)
	AiUtils.initialize_cost_table(self._navtag_layer_cost_table, allowed_layers)
	GwNavBot.set_navtag_layer_cost_table(self._nav_bot, self._navtag_layer_cost_table)

	local locomotion_extension = self._blackboard.locomotion_extension
	local engine_extension_id = locomotion_extension._engine_extension_id

	if engine_extension_id then
		EngineOptimizedExtensions.ai_locomotion_set_traverse_logic(engine_extension_id, self._traverse_logic)
	end
end

AINavigationExtension.traverse_logic = function (self)
	return self._traverse_logic
end

AINavigationExtension.nav_world = function (self)
	return self._nav_world
end

AINavigationExtension.desired_velocity = function (self)
	return GwNavBot.output_velocity(self._nav_bot)
end

AINavigationExtension.set_enabled = function (self, enabled)
	self._enabled = enabled

	if not enabled then
		self._is_following_path = false
	end
end

AINavigationExtension.set_avoidance_enabled = function (self, enabled)
	if self._nav_bot == nil then
		return
	end

	self._is_avoiding = enabled

	GwNavBot.set_use_avoidance(self._nav_bot, enabled)
end

AINavigationExtension.set_max_speed = function (self, speed)
	if self._nav_bot == nil then
		return
	end

	if self._max_speed == speed then
		return
	end

	self._max_speed = speed

	GwNavBot.set_max_desired_linear_speed(self._nav_bot, speed)
end

AINavigationExtension.get_max_speed = function (self)
	return self._max_speed
end

AINavigationExtension.set_navbot_position = function (self, position)
	if self._nav_bot == nil then
		return
	end

	GwNavBot.update_position(self._nav_bot, position)
end

AINavigationExtension.move_to = function (self, pos)
	if self._nav_bot == nil then
		return
	end

	if self._blackboard.far_path then
		self._backup_destination:store(pos)

		return
	end

	self._wanted_destination:store(pos)

	self._failed_move_attempts = 0
	self._has_unprocessed_path_request = true
end

AINavigationExtension.is_pathing = function (self)
	return self._has_unprocessed_path_request or self:is_computing_path()
end

AINavigationExtension.stop = function (self)
	local unit = self._unit
	local position = POSITION_LOOKUP[unit]

	self._wanted_destination:store(position)
	self._destination:store(position)

	self._failed_move_attempts = 0
	self._has_started_pathfind = nil
	self._has_unprocessed_path_request = false
	local blackboard = self._blackboard
	blackboard.far_path = nil
	blackboard.current_far_path_index = nil
	blackboard.num_far_path_nodes = nil
	local nav_bot = self._nav_bot

	if self._is_computing_path then
		GwNavBot.cancel_async_path_computation(nav_bot)
	end

	GwNavBot.clear_followed_path(nav_bot)
end

AINavigationExtension.number_failed_move_attempts = function (self)
	return self._failed_move_attempts
end

AINavigationExtension.is_following_path = function (self)
	return self._is_following_path
end

AINavigationExtension.is_computing_path = function (self)
	return self._is_computing_path
end

AINavigationExtension.reset_destination = function (self)
	if self._nav_bot == nil then
		return
	end

	local unit = self._unit
	local position = POSITION_LOOKUP[unit]

	self._wanted_destination:store(position)
	self._destination:store(position)

	self._failed_move_attempts = 0
	local blackboard = self._blackboard
	blackboard.far_path = nil
	blackboard.current_far_path_index = nil
	blackboard.num_far_path_nodes = nil

	GwNavBot.compute_new_path(self._nav_bot, position)
end

AINavigationExtension.destination = function (self)
	local blackboard = self._blackboard

	if blackboard.far_path then
		return self._backup_destination:unbox()
	else
		return self._wanted_destination:unbox()
	end
end

AINavigationExtension.distance_to_destination = function (self, position)
	position = position or Unit.local_position(self._unit, 0)
	local destination = self:destination()

	return Vector3.distance(position, destination)
end

AINavigationExtension.distance_to_destination_sq = function (self, position)
	position = position or Unit.local_position(self._unit, 0)
	local destination = self:destination()

	return Vector3.distance_squared(position, destination)
end

local navigation_stop_distance_before_destination = 0.3

AINavigationExtension.has_reached_destination = function (self, reach_distance)
	local reach_distance_sq = (reach_distance or navigation_stop_distance_before_destination)^2
	local distance_sq = self:distance_to_destination_sq()

	return distance_sq < reach_distance_sq
end

AINavigationExtension.next_smart_object_data = function (self)
	return self._next_smart_object_data
end

AINavigationExtension.use_smart_object = function (self, do_use)
	if self._nav_bot == nil then
		return
	end

	local success = nil

	if do_use then
		assert(self._blackboard.next_smart_object_data.next_smart_object_id ~= nil, "Tried to use smart object with a nil smart object id")

		success = GwNavBot.enter_manual_control(self._nav_bot, self._next_smartobject_interval)

		if not success then
			print("FAIL CANNOT GET SMART OBJECT CONTROL")
		end
	else
		success = GwNavBot.exit_manual_control(self._nav_bot)

		if not success then
			print("FAIL CANNOT RELEASE SMART OBJECT CONTROL. CLEARING FOLLOWED PATH...")
			GwNavBot.clear_followed_path(self._nav_bot)
		end
	end

	local using_smart_object = do_use and success
	self._using_smartobject = using_smart_object

	return success
end

AINavigationExtension.is_using_smart_object = function (self)
	return self._using_smartobject
end

AINavigationExtension.allow_layer = function (self, layer_name, layer_allowed)
	if self._nav_bot == nil then
		return
	end

	local layer_id = LAYER_ID_MAPPING[layer_name]

	if layer_allowed then
		GwNavTagLayerCostTable.allow_layer(self._navtag_layer_cost_table, layer_id)
	else
		GwNavTagLayerCostTable.forbid_layer(self._navtag_layer_cost_table, layer_id)
	end
end

AINavigationExtension.set_layer_cost = function (self, layer_name, layer_cost)
	if self._nav_bot == nil then
		return
	end

	local layer_id = LAYER_ID_MAPPING[layer_name]

	GwNavTagLayerCostTable.set_layer_cost_multiplier(self._navtag_layer_cost_table, layer_id, layer_cost)
end

AINavigationExtension.get_path_node_count = function (self)
	local nav_bot = self._nav_bot

	if nav_bot == nil then
		return 0
	end

	local following_path = self._is_following_path

	if not following_path then
		return 0
	end

	local node_count = GwNavBot.get_path_nodes_count(nav_bot)

	return node_count
end

AINavigationExtension.get_remaining_distance_from_progress_to_end_of_path = function (self)
	local nav_bot = self._nav_bot

	if nav_bot == nil then
		return
	end

	local following_path = self._is_following_path

	if not following_path then
		return
	end

	local distance = GwNavBot.get_remaining_distance_from_progress_to_end_of_path(nav_bot)

	return distance
end

return
