require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local GUTTER_RUNNER_OVERLAP_RADIUS = 1.3
BTCrazyJumpAction = class(BTCrazyJumpAction, BTNode)
BTCrazyJumpAction.name = "BTCrazyJumpAction"
local position_lookup = POSITION_LOOKUP
local PLAYER_AND_BOT_UNITS = PLAYER_AND_BOT_UNITS
BTCrazyJumpAction.init = function (self, ...)
	BTCrazyJumpAction.super.init(self, ...)

	return 
end

local function debug3d(unit, text, color_name)
	if script_data.debug_ai_movement then
		Debug.world_sticky_text(position_lookup[unit], text, color_name)
	end

	return 
end

BTCrazyJumpAction.enter = function (self, unit, blackboard, t)
	aiprint("ENTER CRAZY JUMP ACTION")

	local data = blackboard.jump_data
	local network_manager = Managers.state.network
	local ai_extension = ScriptUnit.extension(unit, "ai_system")

	if data.delay_jump_start then
		data.state = "align_for_push_off"
		data.start_jump = t + 0.3
		data.delay_jump_start = nil
	else
		network_manager.anim_event(network_manager, unit, "jump_start")

		data.state = "push_off"
		data.start_jump = t + 0.3
		data.start_check_obstacles = t + 0.8
	end

	data.target_unit = blackboard.target_unit
	data.overlap_context = ai_extension.get_overlap_context(ai_extension)
	data.anim_jump_rot_var = Unit.animation_find_variable(unit, "jump_rotation")
	local locomotion = blackboard.locomotion_extension

	LocomotionUtils.set_animation_driven_movement(unit, false)
	locomotion.set_gravity(locomotion, blackboard.breed.jump_gravity)
	locomotion.set_check_falling(locomotion, false)

	return 
end
BTCrazyJumpAction.leave = function (self, unit, blackboard, t, reason)
	blackboard.skulk_pos = nil
	blackboard.comitted_to_target = false
	local locomotion = blackboard.locomotion_extension

	locomotion.set_mover_displacement(locomotion)

	if reason == "aborted" then
		aiprint(" ----> WAS ABORTED BY OTHER ACTION ")

		if blackboard.jump_data.updating_jump_rot then
			self.update_anim_variable_done(self, unit, blackboard.jump_data)
		end

		blackboard.jump_data = nil

		if blackboard.smash_door then
			Managers.state.network:anim_event(unit, "to_upright")
		end

		blackboard.high_ground_opportunity = nil

		locomotion.set_movement_type(locomotion, "snap_to_navmesh")
	end

	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, true)
	locomotion.set_check_falling(locomotion, true)

	return 
end
local enter_snap_state_distance = 2.7
BTCrazyJumpAction.run = function (self, unit, blackboard, t, dt)
	local locomotion = blackboard.locomotion_extension
	local data = blackboard.jump_data
	local target_unit = data.target_unit

	if script_data.debug_ai_movement then
		self.debug(self, unit, blackboard, data, t)
	end

	if not AiUtils.is_of_interest_to_gutter_runner(unit, target_unit, blackboard) then
		blackboard.skulk_pos = nil
		data.snap_failed = true

		if data.state == "align_for_push_off" then
			return "failed"
		elseif data.state == "in_air" or data.state == "snapping" then
			data.state = "in_air_no_target"
		end
	end

	if data.state == "align_for_push_off" then
		local rot = LocomotionUtils.rotation_towards_unit(unit, target_unit)

		locomotion.set_wanted_rotation(locomotion, rot)
	else
		locomotion.set_wanted_rotation(locomotion, nil)
	end

	if data.start_jump < t then
		if data.state == "align_for_push_off" then
			local network_manager = Managers.state.network

			network_manager.anim_event(network_manager, unit, "jump_start")

			data.state = "push_off"
			data.start_jump = t + 0.3
			data.start_check_obstacles = t + 0.8
		elseif data.state == "push_off" then
			if data.jump_velocity_boxed then
				data.state = "in_air"
				local callback_context = data.overlap_context
				callback_context.has_gotten_callback = false
				callback_context.num_hits = 0
				blackboard.last_jump = t

				BTCrazyJumpAction:setup_jump(unit, blackboard, data)
				locomotion.set_mover_displacement(locomotion, Vector3(0, 0, 0.5), 0.5)
				debug3d(unit, "JumpAction push_off ok", "green")
			else
				debug3d(unit, "JumpAction push_off no angle", "red")

				return "failed"
			end
		elseif data.state == "in_air" then
			blackboard.comitted_to_target = true
			local callback_context = data.overlap_context
			local pos = Unit.world_position(unit, callback_context.spine_node)
			local target_pos = position_lookup[target_unit]
			local to_target = target_pos - pos
			local to_target_flat = Vector3.flat(to_target)
			local distance = Vector3.length(to_target_flat)

			if script_data.debug_ai_movement then
				QuickDrawerStay:sphere(pos, 0.04)
			end

			if not data.snap_failed and distance < enter_snap_state_distance then
				local status_extension = ScriptUnit.extension(target_unit, "status_system")

				if status_extension.pounced_down then
					data.state = "pounce_down_fail"

					self.update_anim_variable_done(self, unit, data)

					data.fail_time = t + 1
					local network_manager = Managers.state.network

					network_manager.anim_event(network_manager, unit, "jump_fail")
					LocomotionUtils.set_animation_driven_movement(unit, true)
					aiprint("fail already snapped!")
					debug3d(unit, "JumpAction ai_air->pounce_down_fail pounced_down already", "red")

					return "running"
				end

				data.state = "snapping"

				self.update_anim_variable_done(self, unit, data)

				return "running"
			end

			local hit_player = self.check_colliding_players(self, unit, blackboard, pos)

			if hit_player then
				debug3d(unit, "JumpAction in_air accidental!", "green")

				return "done"
			end

			local mover = Unit.mover(unit)

			if data.start_check_obstacles < t then
				if Mover.collides_sides(mover) then
					data.state = "hit_obstacle"

					self.update_anim_variable_done(self, unit, data)
					debug3d(unit, "JumpAction in_air->hit_obstacle collides_sides", "red")
				elseif Mover.collides_down(mover) and 0.1 < t - blackboard.last_jump then
					debug3d(unit, "JumpAction in_air failed collides_down", "red")

					blackboard.skulk_pos = nil
					data.state = "landing"

					return "running"
				end
			end
		elseif data.state == "in_air_no_target" then
			local callback_context = data.overlap_context
			local pos = Unit.world_position(unit, callback_context.spine_node)
			local hit_player = self.check_colliding_players(self, unit, blackboard, pos)

			if hit_player then
				debug3d(unit, "JumpAction in_air_no_target accidental!", "green")

				return "done"
			end

			local mover = Unit.mover(unit)

			if Mover.collides_sides(mover) then
				data.state = "hit_obstacle"

				self.update_anim_variable_done(self, unit, data)
				debug3d(unit, "JumpAction in_air_no_target->hit_obstacle collides_sides", "red")
			elseif Mover.collides_down(mover) and 0.1 < t - blackboard.last_jump then
				debug3d(unit, "JumpAction in_air_no_target failed collides_down", "red")

				blackboard.skulk_pos = nil
				data.state = "landing"

				return "running"
			end
		elseif data.state == "snapping" then
			local snap_distance = 2
			local callback_context = data.overlap_context
			local pos = Unit.world_position(unit, callback_context.spine_node)
			local target_pos = Unit.world_position(target_unit, callback_context.enemy_spine_node)
			local to_target = target_pos - pos
			local distance = Vector3.length(to_target)

			if script_data.debug_ai_movement then
				QuickDrawerStay:sphere(pos, 0.04, Color(200, 90, 0))
			end

			local velocity = blackboard.locomotion_extension:get_velocity()
			local normalized_velocity = Vector3.normalize(velocity)
			local dot = Vector3.dot(normalized_velocity, Vector3.normalize(to_target))

			if dot < 0 then
				aiprint("GR missed crazy jump, player side-stepped")

				data.state = "in_air"
				data.snap_failed = true

				debug3d(unit, "JumpAction snapping->in_air player side-stepped", "yellow")

				return "running"
			end

			if script_data.debug_ai_movement then
				QuickDrawer:sphere(pos, snap_distance)
			end

			local hit_player = self.check_colliding_players(self, unit, blackboard, pos)

			if hit_player then
				debug3d(unit, "JumpAction snapping accidental!", "green")

				return "done"
			end

			if distance < snap_distance then
				local side_snap_distance = 1
				local closest_point_on_velocity = Geometry.closest_point_on_line(pos, pos, pos + normalized_velocity*3)
				local to_side_vec = Vector3.flat(closest_point_on_velocity - target_pos)
				local side_distance = Vector3.length(to_side_vec)

				if side_distance < side_snap_distance then
					debug3d(unit, "JumpAction snapping success SNAPPED!", "green")

					return "done"
				end
			end

			local to_impact_pos = Vector3.flat(data.jump_target_pos:unbox() - pos)
			dot = Vector3.dot(normalized_velocity, Vector3.normalize(to_impact_pos))

			if dot < 0 then
				if script_data.debug_ai_movement then
					QuickDrawerStay:sphere(pos, 0.045, Color(200, 190, 0))
				end

				local mover = Unit.mover(unit)

				if Mover.collides_down(mover) and 0.1 < t - blackboard.last_jump then
					debug3d(unit, "JumpAction snapping failed collides_down", "red")

					blackboard.skulk_pos = nil
					data.state = "landing"

					return "running"
				end
			end

			return "running"
		elseif data.state == "landing" then
			self.update_anim_variable_done(self, unit, data)

			if data.land_time then
				if data.land_time < t then
					locomotion.set_wanted_velocity(locomotion, Vector3.zero())

					data.land_time = nil

					return "failed"
				end
			else
				LocomotionUtils.set_animation_driven_movement(unit, true, true)

				local network_manager = Managers.state.network

				network_manager.anim_event(network_manager, unit, "jump_land")

				data.land_time = t + 0.5
			end

			return "running"
		elseif data.state == "hit_obstacle" then
			locomotion.set_wanted_velocity(locomotion, Vector3.zero())

			blackboard.is_falling = true

			return "failed"

			local mover = Unit.mover(unit)
			local standing_frames = Mover.standing_frames(mover)
			local network_manager = Managers.state.network

			network_manager.anim_event(network_manager, unit, "to_upright")
			network_manager.anim_event(network_manager, unit, "jump_down")

			local wanted_velocity = locomotion.get_velocity(locomotion)

			locomotion.set_wanted_velocity(locomotion, wanted_velocity)

			if 0 < standing_frames then
				Debug.sticky_text("Gutter runner - in air hit obstacle, but have landed again")

				return "failed"
			else
				network_manager.anim_event(network_manager, unit, "jump_down_land")

				return "running"
			end
		elseif data.state == "pounce_down_fail" then
			if t < data.fail_time then
				debug3d(unit, "Pounce down fail", "purple")

				return "running"
			end

			aiprint("pounce_down_fail done!!!!")

			blackboard.target_unit = nil
			blackboard.jump_data.target_unit = nil

			LocomotionUtils.set_animation_driven_movement(unit, false)
			debug3d(unit, "JumpAction pounce_down_fail failed", "red")

			return "failed"
		end
	end

	return "running"
end
local use_overlap = true
BTCrazyJumpAction.check_colliding_players = function (self, unit, blackboard, pos)
	if use_overlap then
		local radius = 1
		local hit_actors, actor_count = PhysicsWorld.immediate_overlap(self.physics_world, "shape", "sphere", "position", pos, "size", radius, "types", "both", "collision_filter", "filter_player_and_husk_trigger", "use_global_table")

		if 0 < actor_count then
			for i = 1, actor_count, 1 do
				local hit_actor = hit_actors[i]
				local hit_unit = Actor.unit(hit_actor)

				if AiUtils.is_of_interest_to_gutter_runner(unit, hit_unit, blackboard) then
					blackboard.jump_data.target_unit = hit_unit
					blackboard.target_unit = hit_unit

					return hit_unit
				end
			end
		end
	else
		local shortest_dist_squared = 4
		local hit_unit = nil

		for i = 1, #PLAYER_AND_BOT_UNITS, 1 do
			local player_unit = PLAYER_AND_BOT_UNITS[i]
			local player_pos = position_lookup[player_unit]
			local dist_squared = Vector3.distance_squared(pos, player_pos)

			if dist_squared < shortest_dist_squared then
				hit_unit = player_unit
				shortest_dist_squared = dist_squared
			end
		end

		return hit_unit
	end

	return 
end
BTCrazyJumpAction.setup_jump = function (self, unit, blackboard, data)
	local jump_target_pos = data.jump_target_pos:unbox()
	local jump_velocity = data.jump_velocity_boxed:unbox()
	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, false)
	LocomotionUtils.set_animation_driven_movement(unit, false)

	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.set_affected_by_gravity(locomotion, true)
	locomotion.set_movement_type(locomotion, "constrained_by_mover")
	locomotion.set_wanted_velocity(locomotion, jump_velocity)

	data.overlap_context.spine_node = Unit.node(unit, "j_neck")
	data.overlap_context.enemy_spine_node = data.enemy_spine_node
	local world = blackboard.world
	self.physics_world = World.get_data(world, "physics_world")
	local animation_system = Managers.state.entity:system("animation_system")

	animation_system.start_anim_variable_update_by_distance(animation_system, unit, data.anim_jump_rot_var, jump_target_pos, 2, true)

	data.updating_jump_rot = true

	return 
end
BTCrazyJumpAction.update_anim_variable_done = function (self, unit, data)
	local animation_system = Managers.state.entity:system("animation_system")

	animation_system.set_update_anim_variable_done(animation_system, unit)

	data.updating_jump_rot = false

	return 
end
local INDEX_POSITION = 1
local INDEX_DISTANCE = 2
local INDEX_NORMAL = 3
local INDEX_ACTOR = 4
local hit_units = {}
BTCrazyJumpAction.ray_cast = function (from, to, blackboard, ignore_unit)
	local direction = to - from
	local normalized_direction = Vector3.normalize(direction)
	local dist = Vector3.length(direction)
	local physics_world = World.get_data(blackboard.world, "physics_world")
	local result = PhysicsWorld.immediate_raycast(physics_world, from, normalized_direction, dist, "all", "collision_filter", "filter_ray_projectile")

	if result then
		local hit_units = hit_units

		table.clear(hit_units)

		local num_hits = #result

		for i = 1, num_hits, 1 do
			local hit = result[i]
			local hit_position = hit[INDEX_POSITION]
			local hit_distance = hit[INDEX_DISTANCE]
			local hit_normal = hit[INDEX_NORMAL]
			local hit_actor = hit[INDEX_ACTOR]
			local hit_unit = Actor.unit(hit_actor)
			local attack_hit_self = hit_unit == ignore_unit

			if not attack_hit_self and hit_unit ~= ignore_unit then
				return hit_unit
			end
		end
	end

	return nil
end
BTCrazyJumpAction.debug = function (self, unit, blackboard, data, t)
	if data.state == "in_air" or data.state == "snapping" then
		local callback_context = data.overlap_context
		local pos = Unit.world_position(unit, callback_context.spine_node)
		local target_pos = position_lookup[blackboard.jump_data.target_unit]

		if target_pos then
			local velocity = blackboard.locomotion_extension:get_velocity()
			local normalized_velocity = Vector3.normalize(velocity)
			local closest_point_on_velocity = Geometry.closest_point_on_line(target_pos, pos, pos + normalized_velocity*20)
			local to_side_vec = Vector3.flat(closest_point_on_velocity - target_pos)
			local side_distance = Vector3.length(to_side_vec)

			QuickDrawer:line(closest_point_on_velocity, Vector3(target_pos.x, target_pos.y, closest_point_on_velocity.z))
			QuickDrawer:line(pos, pos + normalized_velocity*20, Color(255, 0, 0))
			QuickDrawer:sphere(closest_point_on_velocity, 0.05, Color(255, 0, 200, 100))
		end
	end

	return 
end

return 