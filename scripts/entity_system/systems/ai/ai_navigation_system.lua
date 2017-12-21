local WAIT_TIMER_MAX = 5
local WAIT_TIMER_INCREMENT = 1
local extensions = {
	"AINavigationExtension",
	"PlayerBotNavigation"
}
AINavigationSystem = class(AINavigationSystem, ExtensionSystemBase)
AINavigationSystem.init = function (self, entity_system_creation_context, system_name)
	AINavigationSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	self.unit_extension_data = {}
	self.enabled_units = {}

	return 
end
AINavigationSystem.destroy = function (self)
	AINavigationSystem.super.destroy(self)

	return 
end
AINavigationSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local extension = AINavigationSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data)

	if extension_name == "AINavigationExtension" then
		self.unit_extension_data[unit] = extension
	end

	return extension
end
AINavigationSystem.on_remove_extension = function (self, unit, extension_name)
	self.on_freeze_extension(self, unit, extension_name)
	AINavigationSystem.super.on_remove_extension(self, unit, extension_name)

	return 
end
AINavigationSystem.on_freeze_extension = function (self, unit, extension_name)
	self.unit_extension_data[unit] = nil
	self.enabled_units[unit] = nil

	return 
end
AINavigationSystem.update = function (self, context, t)
	local dt = context.dt

	Profiler.start("PlayerBotNavigation")
	self.update_extension(self, "PlayerBotNavigation", dt, context, t)
	Profiler.stop()

	if self.LOLUPDATE then
		Debug.text("LOLUPDATE")
		Profiler.start("AINavigationExtension")
		self.update_extension(self, "AINavigationExtension", dt, context, t)
		Profiler.stop()
	else
		Profiler.start("AINavigationExtension")
		self.update_enabled(self)
		self.update_destination(self, t)
		self.update_desired_velocity(self, t, dt)
		self.update_next_smart_object(self, t, dt)

		if not script_data.disable_crowd_dispersion then
			self.update_dispersion(self)
		end

		if script_data.debug_ai_movement then
			self.update_debug_draw(self, t, dt)
		end

		Profiler.stop("AINavigationExtension")
	end

	return 
end
AINavigationSystem.post_update = function (self, context, t)
	local dt = context.dt

	Profiler.start("AINavigationSystem")
	self.update_position(self)
	Profiler.stop("AINavigationSystem")

	return 
end
AINavigationSystem.update_enabled = function (self)
	Profiler.start("update_enabled")

	for unit, extension in pairs(self.unit_extension_data) do
		local enabled = extension._nav_bot ~= nil and extension._enabled
		self.enabled_units[unit] = (enabled and extension) or nil
	end

	Profiler.stop()

	return 
end
AINavigationSystem.update_destination = function (self, t)
	Profiler.start("update_destination")

	local POSITION_LOOKUP = POSITION_LOOKUP
	local coloryellow = Colors.get("yellow")
	local colorred = Colors.get("red")
	local colorwhite = Colors.get("white")
	local Vec3_dist_sq = Vector3.distance_squared

	for unit, extension in pairs(self.unit_extension_data) do
		local nav_bot = extension._nav_bot
		local is_computing_path = false
		local is_navbot_following_path = false

		if nav_bot then
			is_navbot_following_path = GwNavBot.is_following_path(nav_bot)
			is_computing_path = GwNavBot.is_computing_new_path(nav_bot)
		end

		extension._is_computing_path = is_computing_path
		extension._is_navbot_following_path = is_navbot_following_path

		if nav_bot and not is_computing_path and extension._wait_timer < t then
			local position_unit = POSITION_LOOKUP[unit]
			local position_current_destination = extension._destination:unbox()
			local position_wanted_destination = extension._wanted_destination:unbox()
			local blackboard = extension._blackboard
			local did_pathfind_just_finish = extension._has_started_pathfind

			if did_pathfind_just_finish then
				extension._has_started_pathfind = nil
				local already_at_current_destination = Vec3_dist_sq(position_unit, position_current_destination) < 0.010000000000000002
				local pathfind_was_successful = is_navbot_following_path or already_at_current_destination

				if pathfind_was_successful then
					blackboard.no_path_found = nil
					extension._failed_move_attempts = 0
				else
					blackboard.no_path_found = true
					extension._failed_move_attempts = extension._failed_move_attempts + 1
					extension._wait_timer = t + math.min(WAIT_TIMER_MAX, WAIT_TIMER_INCREMENT*extension._failed_move_attempts)

					if script_data.ai_debug_failed_pathing then
						local debug_pos = extension._debug_position_when_starting_search:unbox()

						QuickDrawerStay:capsule(debug_pos, debug_pos + Vector3.up()*10, math.random()*0.1 + 0.1, colorred)
						QuickDrawerStay:line(debug_pos + Vector3.up()*10, position_current_destination, colorred)
						QuickDrawerStay:sphere(position_current_destination, 0.1, colorred)
					end
				end
			end

			destination_change_large = 0.010000000000000002 < Vec3_dist_sq(position_current_destination, position_wanted_destination)
			local already_at_wanted_destination = Vec3_dist_sq(position_unit, position_wanted_destination) < 0.010000000000000002
			local is_path_recomputation_needed = GwNavBot.is_path_recomputation_needed(nav_bot)
			local should_start_new_pathfind = is_path_recomputation_needed or (not already_at_wanted_destination and (not is_navbot_following_path or destination_change_large))

			if should_start_new_pathfind then
				GwNavBot.compute_new_path(nav_bot, position_wanted_destination)
				extension._destination:store(position_wanted_destination)
				extension._debug_position_when_starting_search:store(position_unit)

				extension._is_computing_path = true
				extension._has_started_pathfind = true
				extension._wait_timer = 0
				blackboard.next_smart_object_data.next_smart_object_id = nil
			end
		end
	end

	if script_data.debug_ai_movement then
		for unit, extension in pairs(self.unit_extension_data) do
			if extension._wait_timer ~= 0 and t < extension._wait_timer then
				local position_unit = POSITION_LOOKUP[unit]
				local debug_height = extension._wait_timer - t

				QuickDrawer:cylinder(position_unit, position_unit + Vector3.up()*debug_height, math.random()*0.2 + 1, colorred)
			end
		end
	end

	Profiler.stop()

	return 
end
AINavigationSystem.update_desired_velocity = function (self, t, dt)
	Profiler.start("update_desired_velocity")

	local colorred = Colors.get("red")
	local colorgreen = Colors.get("lime")
	local raycasts_done = 0
	local nav_world = Managers.state.entity:system("ai_system"):nav_world()

	for unit, extension in pairs(self.enabled_units) do
		local locomotion_extension = extension._blackboard.locomotion_extension
		local desired_velocity = GwNavBot.output_velocity(extension._nav_bot)
		local pos = POSITION_LOOKUP[unit]
		local wanted_destination = extension._wanted_destination:unbox()
		local distance_sq_to_destination = Vector3.distance_squared(pos, wanted_destination)
		local at_destination = distance_sq_to_destination < 0.010000000000000002
		local desired_speed_sq = Vector3.length_squared(desired_velocity)
		local locomotion_speed_sq = Vector3.length_squared(locomotion_extension.current_velocity(locomotion_extension))

		if locomotion_speed_sq == 0 then
			extension._interpolating = false
		end

		local need_to_interpolate = desired_speed_sq == 0 and not at_destination and extension._is_computing_path

		if need_to_interpolate or extension._interpolating then
			extension._interpolating = extension._is_computing_path
			desired_velocity = Vector3.normalize(wanted_destination - pos)
			local wanted_rotation = Quaternion.look(Vector3.flat(desired_velocity), Vector3.up())
			local speed = extension._max_speed

			if raycasts_done < 1 and extension._raycast_timer < t then
				extension._raycast_timer = t + 1
				raycasts_done = raycasts_done + 1
				local target_position = pos + Quaternion.forward(wanted_rotation)*2
				local result = GwNavQueries.raycango(nav_world, pos, target_position, extension._traverse_logic)

				if not result then
					extension._blackboard.no_path_found = true
					extension._interpolating = nil
					speed = 0
				end
			end

			local current_rotation = Unit.world_rotation(unit, 0)
			local rotation_speed = locomotion_extension.get_rotation_speed(locomotion_extension)*locomotion_extension.get_rotation_speed_modifier(locomotion_extension)*dt

			if distance_sq_to_destination < 9 then
				rotation_speed = math.min(1, rotation_speed*2)
				speed = speed*0.5
			end

			local new_rotation = Quaternion.lerp(current_rotation, wanted_rotation, rotation_speed)

			locomotion_extension.set_wanted_rotation(locomotion_extension, new_rotation)

			desired_velocity = Quaternion.forward(new_rotation)*speed

			if script_data.ai_debug_failed_pathing then
				QuickDrawer:capsule(pos + Vector3.up()*2, pos + Vector3.up()*3, math.random()*0.2 + 0.1, Colors.get("lime"))
			end
		end

		desired_velocity.z = 0
		local desired_speed = Vector3.length(desired_velocity)
		extension._current_speed = math.min(desired_speed, extension._max_speed, extension._current_speed + dt*3*extension._max_speed)
		desired_velocity = Vector3.normalize(desired_velocity)*extension._current_speed

		locomotion_extension.set_wanted_velocity_flat(locomotion_extension, desired_velocity)

		extension._is_following_path = 0 < desired_speed
	end

	Profiler.stop()

	return 
end
AINavigationSystem.update_next_smart_object = function (self, t, dt)
	Profiler.start("update_next_smart_object")

	for unit, extension in pairs(self.enabled_units) do
		local data = extension._blackboard.next_smart_object_data
		local GNSMOI = GwNavSmartObjectInterval
		local next_smartobject_interval = extension._next_smartobject_interval
		local next_smartobject_max_distance = 2

		if GwNavBot.current_or_next_smartobject_interval(extension._nav_bot, next_smartobject_interval, next_smartobject_max_distance) then
			local entrance_pos, entrance_is_at_bot_progress_on_path = GNSMOI.entrance_position(next_smartobject_interval)
			local exit_pos, exit_is_at_the_end_of_path = GNSMOI.exit_position(next_smartobject_interval)
			local next_smart_object_id = GNSMOI.smartobject_id(next_smartobject_interval)
			local nav_graph_system = Managers.state.entity:system("nav_graph_system")

			if next_smart_object_id ~= -1 and nav_graph_system.get_smart_object_type(nav_graph_system, next_smart_object_id) then
				data.next_smart_object_id = next_smart_object_id

				data.entrance_pos:store(entrance_pos)
				data.exit_pos:store(exit_pos)

				data.entrance_is_at_bot_progress_on_path = entrance_is_at_bot_progress_on_path
				data.exit_is_at_the_end_of_path = exit_is_at_the_end_of_path

				assert(data.next_smart_object_id)

				local nav_graph_system = Managers.state.entity:system("nav_graph_system")
				data.smart_object_type = nav_graph_system.get_smart_object_type(nav_graph_system, data.next_smart_object_id)
				data.smart_object_data = nav_graph_system.get_smart_object_data(nav_graph_system, data.next_smart_object_id)

				fassert(LAYER_ID_MAPPING[data.smart_object_type] ~= nil, "Invalid smart object type %s", data.smart_object_type)
			end
		else
			data.next_smart_object_id = nil
		end

		if data.next_smart_object_id then
			local dist_sq = Vector3.distance_squared(data.entrance_pos:unbox(), Unit.local_position(extension._unit, 0))
			extension._blackboard.is_in_smartobject_range = dist_sq < 4
		end
	end

	Profiler.stop()

	return 
end
AINavigationSystem.update_dispersion = function (self, t, dt)
	Profiler.start("update_dispersion")

	for unit, extension in pairs(self.enabled_units) do
		local action = GwNavBot.update_logic_for_crowd_dispersion(extension._nav_bot)

		if action == 1 then
		elseif action == 2 then
		end
	end

	Profiler.stop()

	return 
end
AINavigationSystem.update_debug_draw = function (self, t)
	Profiler.start("update_debug_draw")

	local drawer = Managers.state.debug:drawer({
		mode = "immediate",
		name = "AINavigationExtension"
	})
	local enabled_color = Colors.get("pink")
	local disabled_color = Colors.get("purple")
	local offset = Vector3(0, 0, 0.01)

	for unit, extension in pairs(self.unit_extension_data) do
		local pos = Unit.local_position(unit, 0)
		local enabled = self.enabled_units[unit]
		local color = (enabled and enabled_color) or disabled_color
		local wanted_destination = extension._wanted_destination:unbox()
		local destination = extension._destination:unbox()

		drawer.sphere(drawer, Unit.local_position(unit, 0), 0.1, color)
		drawer.sphere(drawer, wanted_destination, 0.2, color)
		drawer.vector(drawer, pos, wanted_destination - pos, color)

		if 0.1 < Vector3.distance_squared(wanted_destination, destination) then
			drawer.vector(drawer, pos + offset, destination - pos, Colors.get("green"))
		end

		if enabled then
			local velocity = GwNavBot.velocity(extension._nav_bot)

			if 0 < Vector3.length(velocity) then
				drawer.vector(drawer, pos + Vector3.up(), Vector3.normalize(velocity), color)
			end
		end

		local data = extension._blackboard.next_smart_object_data

		if data.next_smart_object_id then
			local entrance_pos = data.entrance_pos:unbox()
			local exit_pos = data.exit_pos:unbox()

			drawer.sphere(drawer, entrance_pos, 0.3, (data.entrance_is_at_bot_progress_on_path and Colors.get("pink")) or Colors.get("red"))
			drawer.sphere(drawer, exit_pos, 0.3, (data.exit_is_at_the_end_of_path and Colors.get("pink")) or Colors.get("red"))
			drawer.vector(drawer, entrance_pos, exit_pos - entrance_pos, (data.next_smart_object_id and Colors.get("pink")) or Colors.get("red"))
		end
	end

	local unit = script_data.debug_unit
	local navigation_extension = self.unit_extension_data[unit]

	if Unit.alive(unit) and navigation_extension then
		Debug.text("AI NAVIGATION DEBUG")
		Debug.text("  enabled = %s", tostring(self.enabled_units[unit] ~= nil))
		Debug.text("  has_reached = %s", tostring(navigation_extension.has_reached_destination(navigation_extension)))
		Debug.text("  current_speed = %.2f", navigation_extension._current_speed)
		Debug.text("  desired_velocity = %s", (navigation_extension._nav_bot and tostring(GwNavBot.output_velocity(navigation_extension._nav_bot))) or "?")
		Debug.text("  failed_move_attempts = %d", navigation_extension._failed_move_attempts)
		Debug.text("  is_path_found = %s", tostring(navigation_extension._is_path_found))
		Debug.text("  no_path_found = %s", tostring(navigation_extension._blackboard.no_path_found))
		Debug.text("  is_computing_path = %s", tostring(navigation_extension._is_computing_path))
		Debug.text("  is_following_path = %s", (navigation_extension._nav_bot and tostring(GwNavBot.is_following_path(navigation_extension._nav_bot))) or "?")
		Debug.text("  interpolating = %s", tostring(navigation_extension._interpolating))
		Debug.text("  btnode = %s", tostring(navigation_extension._blackboard.btnode_name))
		Debug.text("  wait_timer = %.1f", math.max(-1, navigation_extension._wait_timer - t))
	end

	Profiler.stop()

	return 
end
AINavigationSystem.update_position = function (self, t, dt)
	Profiler.start("update_position")

	for unit, extension in pairs(self.enabled_units) do
		if extension._nav_bot then
			local position = Unit.local_position(extension._unit, 0)

			GwNavBot.update_position(extension._nav_bot, position)
		end
	end

	Profiler.stop()

	return 
end
NAVIGATION_RUNNING_IN_THREAD = false
AINavigationSystem.override_nav_funcs = function (self)
	local patch_list = {
		"GwNavWorld",
		"GwNavBot",
		"GwNavQueries",
		"GwNavSmartObjectInterval",
		"GwNavTagLayerCostTable",
		"GwNavTraverseLogic",
		"GwNavBoxObstacle",
		"GwNavAStar",
		"GwNavCylinderObstacle",
		"GwNavTagVolume"
	}

	for i = 1, #patch_list, 1 do
		local engine_plugin_name = patch_list[i]
		local engine_plugin = _G[engine_plugin_name]

		for func_name, func in pairs(engine_plugin) do
			if func_name ~= "join_async_update" and func_name ~= "kick_async_update" then
				engine_plugin[func_name] = function (...)
					fassert(not NAVIGATION_RUNNING_IN_THREAD, "%s.%s() function was run during navigation running on other thread", engine_plugin_name, func_name)

					return func(...)
				end
			end
		end
	end

	return 
end

return 
