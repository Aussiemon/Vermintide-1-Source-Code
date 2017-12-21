require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local PLAYER_AND_BOT_UNITS = PLAYER_AND_BOT_UNITS

local function debug_graph()
	local graph = Managers.state.debug.graph_drawer:graph("BTClimbAction")

	if graph == nil then
		graph = Managers.state.debug.graph_drawer:create_graph("BTClimbAction", {
			"time",
			"unit altitude"
		})
	end

	return graph
end

BTClimbAction = class(BTClimbAction, BTNode)
BTClimbAction.init = function (self, ...)
	BTClimbAction.super.init(self, ...)

	return 
end
BTClimbAction.name = "BTClimbAction"

local function randomize(event)
	if type(event) == "table" then
		return event[Math.random(1, #event)]
	else
		return event
	end

	return 
end

BTClimbAction.enter = function (self, unit, blackboard, t)
	local unit_position = POSITION_LOOKUP[unit]
	local next_smart_object_data = blackboard.next_smart_object_data
	local entrance_pos = next_smart_object_data.entrance_pos:unbox()
	local exit_pos = next_smart_object_data.exit_pos:unbox()
	local smart_object_data = next_smart_object_data.smart_object_data
	local ledge_position = Vector3Aux.unbox(smart_object_data.ledge_position)
	blackboard.smart_object_data = smart_object_data
	blackboard.ledge_position = Vector3Box(ledge_position)
	blackboard.climb_upwards = true
	blackboard.climb_entrance_pos = Vector3Box(entrance_pos)
	blackboard.climb_exit_pos = Vector3Box(exit_pos)
	local action_data = self._tree_node.action_data

	if action_data and action_data.catapult_players then
		blackboard.units_catapulted = {}
	end

	if not smart_object_data.is_on_edge then
		if smart_object_data.ledge_position1 then
			local ledge_position1 = Vector3Aux.unbox(smart_object_data.ledge_position1)
			local ledge_position2 = Vector3Aux.unbox(smart_object_data.ledge_position2)
			local closest_ledge_position = (Vector3.distance_squared(ledge_position1, entrance_pos) < Vector3.distance_squared(ledge_position2, entrance_pos) and ledge_position1) or ledge_position2
			blackboard.climb_jump_height = closest_ledge_position.z - entrance_pos.z

			blackboard.ledge_position:store(closest_ledge_position)
		else
			blackboard.climb_jump_height = ledge_position.z - entrance_pos.z

			if blackboard.climb_jump_height < 0 then
				smart_object_data.is_on_edge = true
			end
		end
	end

	if smart_object_data.is_on_edge then
		if exit_pos.z < entrance_pos.z then
			blackboard.climb_jump_height = entrance_pos.z - exit_pos.z
			blackboard.climb_upwards = false
		else
			blackboard.climb_jump_height = exit_pos.z - entrance_pos.z
		end
	end

	assert(0 <= blackboard.climb_jump_height, "Ledge with non-positive climb height=%.2f at %s -> %s", blackboard.climb_jump_height, tostring(entrance_pos), tostring(exit_pos))

	blackboard.climb_ledge_lookat_direction = Vector3Box(Vector3.normalize(Vector3.flat(exit_pos - entrance_pos)))
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_affected_by_gravity(locomotion_extension, false)
	locomotion_extension.set_movement_type(locomotion_extension, "snap_to_navmesh")
	locomotion_extension.set_rotation_speed(locomotion_extension, 10)

	blackboard.climb_state = "moving_to_within_smartobject_range"

	if script_data.ai_debug_smartobject then
		Unit.set_animation_logging(unit, true)
		debug_graph():reset()
		debug_graph():set_active(true)
	else
		debug_graph():set_active(false)
	end

	return 
end
BTClimbAction.leave = function (self, unit, blackboard, t)
	blackboard.climb_spline_ground = nil
	blackboard.climb_spline_ledge = nil
	blackboard.climb_entrance_pos = nil
	blackboard.climb_state = nil
	blackboard.climb_upwards = nil
	blackboard.is_climbing = nil
	blackboard.climb_jump_height = nil
	blackboard.climb_ledge_lookat_direction = nil
	blackboard.climb_entrance_pos = nil
	blackboard.climb_exit_pos = nil
	blackboard.is_smart_objecting = nil
	blackboard.jump_climb_finished = nil
	blackboard.climb_align_end_time = nil
	blackboard.smart_object_data = nil
	blackboard.ledge_position = nil
	blackboard.climb_moving_to_enter_entrance_timeout = nil
	blackboard.units_catapulted = nil

	LocomotionUtils.set_animation_translation_scale(unit, Vector3(1, 1, 1))
	LocomotionUtils.constrain_on_clients(unit, false, Vector3.zero(), Vector3.zero())
	LocomotionUtils.set_animation_driven_movement(unit, false)

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_movement_type(locomotion_extension, "snap_to_navmesh")
	locomotion_extension.set_affected_by_gravity(locomotion_extension, true)

	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, true)

	local hit_reaction_extension = ScriptUnit.extension(unit, "hit_reaction_system")
	hit_reaction_extension.force_ragdoll_on_death = nil
	slot7 = navigation_extension.is_using_smart_object(navigation_extension) and navigation_extension.use_smart_object(navigation_extension, false)

	return 
end
BTClimbAction.run = function (self, unit, blackboard, t, dt)
	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local unit_position = POSITION_LOOKUP[unit]
	local climb_state_current = blackboard.climb_state
	local is_on_edge = blackboard.smart_object_data.is_on_edge

	if script_data.ai_debug_smartobject then
		Debug.text("BTClimbAction state=%s", blackboard.climb_state)
		Debug.text("BTClimbAction entrance_pos=%s", tostring(blackboard.climb_entrance_pos:unbox()))
		Debug.text("BTClimbAction exit_pos=        %s", tostring(blackboard.climb_exit_pos:unbox()))
		Debug.text("BTClimbAction pos=            %s", tostring(POSITION_LOOKUP[unit]))
		QuickDrawer:sphere(blackboard.climb_entrance_pos:unbox(), 0.3, Colors.get("red"))
		QuickDrawer:sphere(blackboard.climb_exit_pos:unbox(), 0.3, Colors.get("red"))
		QuickDrawer:sphere(unit_position, math.sin(t*5)*0.01 + 0.3, Colors.get("purple"))

		if 0 < Vector3.length(locomotion_extension.get_velocity(locomotion_extension)) then
			debug_graph():add_point(t, unit_position.z)
		end
	end

	if blackboard.smart_object_data ~= blackboard.next_smart_object_data.smart_object_data then
		return "failed"
	end

	if blackboard.climb_state == "moving_to_within_smartobject_range" then
		local dist = Vector3.distance_squared(blackboard.climb_entrance_pos:unbox(), unit_position)
		local target_dir = Vector3.normalize(navigation_extension.desired_velocity(navigation_extension))

		if Vector3.length(Vector3.flat(target_dir)) < 0.05 and 0.99 < Vector3.dot(target_dir, Vector3.normalize(blackboard.climb_exit_pos:unbox() - unit_position)) then
			blackboard.climb_moving_to_enter_entrance_timeout = blackboard.climb_moving_to_enter_entrance_timeout or t + 0.3
		else
			blackboard.climb_moving_to_enter_entrance_timeout = nil
		end

		if dist < 1 or (blackboard.climb_moving_to_enter_entrance_timeout and blackboard.climb_moving_to_enter_entrance_timeout < t) then
			locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3(0, 0, 0))
			locomotion_extension.set_movement_type(locomotion_extension, "script_driven")
			navigation_extension.set_enabled(navigation_extension, false)

			if navigation_extension.use_smart_object(navigation_extension, true) then
				blackboard.is_smart_objecting = true
				blackboard.is_climbing = true
				blackboard.climb_state = "moving_to_to_entrance"
			else
				print("BTClimbAction - failing to use smart object")

				return "failed"
			end
		elseif script_data.ai_debug_smartobject then
			QuickDrawer:circle(blackboard.climb_entrance_pos:unbox(), 1, Vector3.up())
		end
	end

	if blackboard.climb_state == "moving_to_to_entrance" then
		local entrance_pos = blackboard.climb_entrance_pos:unbox()
		local vector_to_target = entrance_pos - unit_position
		local distance_to_target = Vector3.length(vector_to_target)

		if 0.1 < distance_to_target then
			local speed = blackboard.breed.run_speed

			if distance_to_target < speed*dt then
				speed = distance_to_target/dt
			end

			local direction_to_target = Vector3.normalize(vector_to_target)

			locomotion_extension.set_wanted_velocity(locomotion_extension, direction_to_target*speed)

			local look_direction_wanted = blackboard.climb_ledge_lookat_direction:unbox()

			locomotion_extension.set_wanted_rotation(locomotion_extension, Quaternion.look(look_direction_wanted))

			if script_data.ai_debug_smartobject then
				QuickDrawer:vector(unit_position + Vector3.up()*0.3, vector_to_target)
				QuickDrawer:sphere(entrance_pos, 0.3, Colors.get("red"))
			end
		else
			local look_direction_wanted = blackboard.climb_ledge_lookat_direction:unbox()

			locomotion_extension.teleport_to(locomotion_extension, entrance_pos, Quaternion.look(look_direction_wanted))

			unit_position = entrance_pos

			locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3.zero())

			local exit_pos = blackboard.climb_exit_pos:unbox()
			local ledge_position = blackboard.ledge_position:unbox() + Vector3.up()

			LocomotionUtils.constrain_on_clients(unit, true, Vector3.min(entrance_pos, exit_pos), Vector3.max(ledge_position, Vector3.max(entrance_pos, exit_pos)))
			LocomotionUtils.set_animation_driven_movement(unit, true)

			local hit_reaction_extension = ScriptUnit.extension(unit, "hit_reaction_system")
			hit_reaction_extension.force_ragdoll_on_death = true

			if blackboard.climb_upwards or not is_on_edge then
				local ai_extension = ScriptUnit.extension(unit, "ai_system")
				local animation_length = 1
				local animation_translation_scale = ai_extension.size_variation(ai_extension)/1
				local jump_anim_thresholds = SmartObjectSettings.templates[blackboard.breed.smart_object_template].jump_up_anim_thresholds
				local climb_jump_height = blackboard.climb_jump_height

				for i = 1, #jump_anim_thresholds, 1 do
					local jump_anim_threshold = jump_anim_thresholds[i]

					if climb_jump_height < jump_anim_threshold.height_threshold then
						local jump_anim_name = (is_on_edge and jump_anim_threshold.animation_edge) or jump_anim_threshold.animation_fence

						Managers.state.network:anim_event(unit, randomize(jump_anim_name))

						local anim_distance = jump_anim_threshold.vertical_length
						animation_translation_scale = (animation_translation_scale*climb_jump_height)/anim_distance

						break
					end
				end

				LocomotionUtils.set_animation_translation_scale(unit, Vector3(1, 1, animation_translation_scale))
				locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3(0, 0, 0))

				blackboard.climb_state = "waiting_for_finished_climb_anim"
			else
				local jump_anim_thresholds = SmartObjectSettings.templates[blackboard.breed.smart_object_template].jump_down_anim_thresholds
				local climb_jump_height = math.abs(blackboard.climb_jump_height)

				for i = 1, #jump_anim_thresholds, 1 do
					local jump_anim_threshold = jump_anim_thresholds[i]

					if climb_jump_height < jump_anim_threshold.height_threshold then
						local jump_anim_name = (is_on_edge and jump_anim_threshold.animation_edge) or jump_anim_threshold.animation_fence

						Managers.state.network:anim_event(unit, randomize(jump_anim_name))

						break
					end
				end

				blackboard.climb_state = "waiting_to_reach_ground"
			end
		end
	end

	if blackboard.climb_state == "waiting_for_finished_climb_anim" then
		local action_data = self._tree_node.action_data
		local catapult_players = action_data and action_data.catapult_players

		if catapult_players then
			self._catapult_players(self, unit, blackboard, catapult_players)
		end

		if blackboard.jump_climb_finished then
			blackboard.jump_climb_finished = nil
			local exit_pos = blackboard.climb_exit_pos:unbox()
			local move_target = (is_on_edge and exit_pos) or blackboard.ledge_position:unbox()

			debug_graph():add_annotation({
				color = "green",
				x = t,
				y = unit_position.z,
				text = "finished climb unit @ " .. tostring(unit_position) .. " to move_target @" .. tostring(move_target)
			})

			if is_on_edge then
				Managers.state.network:anim_event(unit, "move_fwd")

				blackboard.spawn_to_running = true

				locomotion_extension.teleport_to(locomotion_extension, move_target)
				navigation_extension.set_navbot_position(navigation_extension, move_target)
				locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3(0, 0, 0))
				LocomotionUtils.set_animation_driven_movement(unit, false)

				blackboard.climb_state = "done"
			else
				local jump_anim_thresholds = SmartObjectSettings.templates[blackboard.breed.smart_object_template].jump_down_anim_thresholds
				local climb_jump_height = move_target.z - blackboard.climb_exit_pos:unbox().z

				for i = 1, #jump_anim_thresholds, 1 do
					local jump_anim_threshold = jump_anim_thresholds[i]

					if climb_jump_height < jump_anim_threshold.height_threshold then
						local ai_extension = ScriptUnit.extension(unit, "ai_system")
						local ai_size_variation = ai_extension.size_variation(ai_extension)
						local animation_length = jump_anim_threshold.fence_horizontal_length
						local flat_distance_to_jump = Vector3.length(Vector3.flat(unit_position - exit_pos))
						flat_distance_to_jump = flat_distance_to_jump - jump_anim_threshold.fence_land_length
						local animation_translation_scale = flat_distance_to_jump/(animation_length*ai_size_variation)

						LocomotionUtils.set_animation_translation_scale(unit, Vector3(animation_translation_scale, animation_translation_scale, 1))

						local jump_anim_name = (is_on_edge and jump_anim_threshold.animation_edge) or jump_anim_threshold.animation_fence

						Managers.state.network:anim_event(unit, randomize(jump_anim_name))

						break
					end
				end

				blackboard.climb_state = "waiting_to_reach_ground"
			end
		end
	end

	if blackboard.climb_state == "waiting_to_reach_ground" then
		local action_data = self._tree_node.action_data
		local catapult_players = action_data and action_data.catapult_players

		if catapult_players then
			self._catapult_players(self, unit, blackboard, catapult_players)
		end

		local move_target = blackboard.climb_exit_pos:unbox()
		local velocity = locomotion_extension.get_velocity(locomotion_extension)

		if unit_position.z + velocity.z*dt*2 <= move_target.z then
			blackboard.climb_state = "waiting_for_finished_land_anim"

			LocomotionUtils.set_animation_driven_movement(unit, true)
			LocomotionUtils.set_animation_translation_scale(unit, Vector3(1, 1, 1))
			Managers.state.network:anim_event(unit, "jump_down_land")

			local hit_reaction_extension = ScriptUnit.extension(unit, "hit_reaction_system")
			hit_reaction_extension.force_ragdoll_on_death = nil

			if script_data.ai_debug_smartobject then
				debug_graph():add_annotation({
					color = "orange",
					x = t,
					y = unit_position.z,
					text = "realized reached_ground " .. tostring(unit_position) .. " to exit pos @" .. tostring(move_target)
				})
				debug_graph():add_annotation({
					text = "would/will reach ground here next frame ",
					color = "red",
					x = t + dt*2,
					y = unit_position.z + velocity.z*dt*2
				})
				debug_graph():add_annotation({
					color = "orange",
					x = t,
					y = unit_position.z,
					text = "teleported unit @ " .. tostring(unit_position) .. " to exit pos @" .. tostring(move_target)
				})
			end
		end
	elseif blackboard.climb_state == "waiting_for_finished_land_anim" then
		local move_target = blackboard.climb_exit_pos:unbox()
		local ground_target = Vector3(unit_position.x, unit_position.y, move_target.z)

		locomotion_extension.teleport_to(locomotion_extension, ground_target)

		if blackboard.jump_climb_finished then
			local move_target = blackboard.climb_exit_pos:unbox()

			LocomotionUtils.set_animation_driven_movement(unit, false)
			Managers.state.network:anim_event(unit, "move_fwd")

			blackboard.spawn_to_running = true

			if script_data.ai_debug_smartobject then
				debug_graph():add_annotation({
					color = "orange",
					x = t,
					y = unit_position.z,
					text = "teleported unit @ " .. tostring(unit_position) .. " to exit pos @" .. tostring(move_target)
				})
			end

			local distance = Vector3.distance(unit_position, move_target)

			if distance < 0.01 then
				local position_on_navmesh, altitude = GwNavQueries.triangle_from_position(blackboard.nav_world, move_target, 0.4, 0.4)

				if altitude then
					move_target.z = altitude
				end

				navigation_extension.set_navbot_position(navigation_extension, move_target)
				locomotion_extension.teleport_to(locomotion_extension, move_target)
				locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3.zero())

				blackboard.climb_state = "done"
			else
				local speed = blackboard.breed.run_speed
				local time_to_travel = distance/speed
				blackboard.climb_align_end_time = t + time_to_travel
				blackboard.climb_state = "aligning_to_navmesh"
			end
		end
	end

	if blackboard.climb_state == "aligning_to_navmesh" then
		local move_target = blackboard.climb_exit_pos:unbox()

		if blackboard.climb_align_end_time < t then
			if script_data.ai_debug_smartobject then
				debug_graph():add_annotation({
					color = "orange",
					x = t,
					y = unit_position.z,
					text = "aligned unit @ " .. tostring(unit_position) .. " to exit pos @" .. tostring(move_target)
				})
			end

			local position_on_navmesh, altitude = GwNavQueries.triangle_from_position(blackboard.nav_world, move_target, 0.4, 0.4)

			if not position_on_navmesh then
				position_on_navmesh, altitude = GwNavQueries.triangle_from_position(blackboard.nav_world, move_target, 1.5, 1.5)

				if position_on_navmesh then
					printf("WTF navmesh pos @ move_target %s, actual altitude=%f", tostring(move_target), altitude)
					QuickDrawerStay:sphere(move_target, 0.1, Color(255, 255, 255))
					QuickDrawerStay:sphere(move_target + Vector3.up(), 0.9, Color(255, 0, 0))
					QuickDrawerStay:sphere(move_target - Vector3.up(), 0.9, Color(255, 0, 0))
				end
			end

			navigation_extension.set_navbot_position(navigation_extension, move_target)
			locomotion_extension.teleport_to(locomotion_extension, move_target)
			locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3.zero())

			blackboard.climb_state = "done"
		else
			local speed = blackboard.breed.run_speed
			local direction_to_target = Vector3.normalize(move_target - unit_position)
			local wanted_velocity = direction_to_target*speed

			locomotion_extension.set_wanted_velocity(locomotion_extension, wanted_velocity)
		end
	end

	if blackboard.climb_state == "done" then
		blackboard.climb_state = "done_for_reals"
	elseif blackboard.climb_state == "done_for_reals" then
		blackboard.climb_state = "done_for_reals2"
	elseif blackboard.climb_state == "done_for_reals2" then
		return "done"
	end

	return "running"
end
BTClimbAction._catapult_players = function (self, unit, blackboard, data)
	local shape = data.shape
	local radius = data.radius
	local pos = Unit.world_position(unit, 0)

	for i = 1, #PLAYER_AND_BOT_POSITIONS, 1 do
		local player_pos = PLAYER_AND_BOT_POSITIONS[i]
		local player_unit = PLAYER_AND_BOT_UNITS[i]
		local offset = player_pos - pos
		local dist = Vector3.length(offset)

		if not blackboard.units_catapulted[player_unit] and dist < radius then
			local speed = data.speed
			local angle = data.angle
			local flat_offset_dir = Vector3.normalize(Vector3.flat(offset))
			local length = speed*math.cos(angle)
			local height = speed*math.sin(angle)
			local push_velocity = flat_offset_dir*length
			push_velocity.z = height
			local target_status_extension = ScriptUnit.extension(player_unit, "status_system")

			target_status_extension.set_catapulted(target_status_extension, true, push_velocity)

			blackboard.units_catapulted[player_unit] = player_unit
		end
	end

	return 
end

return 