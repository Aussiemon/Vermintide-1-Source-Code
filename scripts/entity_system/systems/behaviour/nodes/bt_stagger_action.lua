require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTStaggerAction = class(BTStaggerAction, BTNode)
BTStaggerAction.name = "BTStaggerAction"
BTStaggerAction.init = function (self, ...)
	BTStaggerAction.super.init(self, ...)

	return 
end
BTStaggerAction.enter = function (self, unit, blackboard, t)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_enabled(navigation_extension, false)

	blackboard.stagger_anim_done = false
	blackboard.stagger_hit_wall = nil
	blackboard.staggering_id = blackboard.stagger
	local action_data = self._tree_node.action_data
	local stagger_anims = action_data.stagger_anims[blackboard.stagger_type]

	fassert(stagger_anims, "Stagger type %q", blackboard.stagger_type)

	local impact_dir = blackboard.stagger_direction:unbox()
	local push_anim, impact_rot = self._select_animation(self, unit, blackboard, impact_dir, stagger_anims)
	blackboard.attack_aborted = true

	Unit.set_local_rotation(unit, 0, impact_rot)

	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_combat")

	local anim_scale = 1

	if action_data.scale_animation_speeds then
		anim_scale = action_data.stagger_animation_scale or blackboard.stagger_animation_scale or 1

		network_manager.anim_event_with_variable_float(network_manager, unit, push_anim, "stagger_scale", anim_scale)
	else
		network_manager.anim_event(network_manager, unit, push_anim)
	end

	network_manager.anim_event(network_manager, unit, "idle")

	local scale = blackboard.stagger_length

	LocomotionUtils.set_animation_translation_scale(unit, Vector3(scale, scale, scale))
	LocomotionUtils.set_animation_driven_movement(unit, true, true)

	local locomotion_extension = blackboard.locomotion_extension

	locomotion_extension.set_rotation_speed(locomotion_extension, 100)
	locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3(0, 0, 0))
	locomotion_extension.set_affected_by_gravity(locomotion_extension, true)
	locomotion_extension.use_lerp_rotation(locomotion_extension, false)

	local nav_world = blackboard.nav_world
	local velocity = locomotion_extension.current_velocity(locomotion_extension)
	local unit_position = POSITION_LOOKUP[unit]
	local is_moving = 0 < Vector3.length_squared(velocity)
	local direction = impact_dir
	local target_position = unit_position + direction*0.5
	local is_position_on_navmesh, altitude = GwNavQueries.triangle_from_position(nav_world, unit_position, 0.1, 0.1)
	local raycango = is_position_on_navmesh and GwNavQueries.raycango(nav_world, unit_position, target_position)

	if not script_data.ai_force_stagger_mover and raycango then
	else
		local action_data = self._tree_node.action_data

		locomotion_extension.set_movement_type(locomotion_extension, "constrained_by_mover", action_data.override_mover_move_distance)
	end

	return 
end
BTStaggerAction._select_animation = function (self, unit, blackboard, impact_vec, stagger_anims)
	local impact_dir = Vector3.normalize(impact_vec)
	local my_fwd = Quaternion.forward(Unit.local_rotation(unit, 0))
	local dot = Vector3.dot(my_fwd, impact_dir)
	dot = math.clamp(dot, -1, 1)
	local angle = math.acos(dot)
	local impact_rot, anim_table = nil

	if impact_vec.z == -1 and stagger_anims.dwn then
		impact_dir.z = 0
		impact_rot = Quaternion.look(-impact_dir)
		anim_table = stagger_anims.dwn
	else
		impact_dir.z = 0

		if math.pi*0.75 < angle then
			impact_rot = Quaternion.look(-impact_dir)
			anim_table = stagger_anims.bwd
		elseif angle < math.pi*0.25 then
			impact_rot = Quaternion.look(impact_dir)
			anim_table = stagger_anims.fwd
		elseif 0 < Vector3.cross(my_fwd, impact_dir).z then
			local dir = Vector3.cross(Vector3(0, 0, -1), impact_dir)
			impact_rot = Quaternion.look(dir)
			anim_table = stagger_anims.left
		else
			local dir = Vector3.cross(Vector3(0, 0, 1), impact_dir)
			impact_rot = Quaternion.look(dir)
			anim_table = stagger_anims.right
		end
	end

	local num_anims = #anim_table
	local index = Math.random(1, num_anims)
	local anim = anim_table[index]

	if anim == blackboard.last_stagger_anim then
		anim = anim_table[index%num_anims + 1]
	end

	blackboard.last_stagger_anim = anim

	return anim, impact_rot
end
BTStaggerAction.leave = function (self, unit, blackboard, t, dt, new_action)
	blackboard.stagger_type = nil
	blackboard.stagger = nil
	blackboard.pushing_unit = nil
	blackboard.staggering = nil
	blackboard.stagger_direction = nil
	blackboard.stagger_length = nil
	blackboard.stagger_time = nil
	blackboard.stagger_anim_done = nil
	blackboard.stagger_hit_wall = nil

	LocomotionUtils.set_animation_driven_movement(unit, false)

	local locomotion_extension = blackboard.locomotion_extension

	locomotion_extension.set_rotation_speed(locomotion_extension, 10)
	locomotion_extension.set_wanted_rotation(locomotion_extension, nil)
	locomotion_extension.set_movement_type(locomotion_extension, "snap_to_navmesh")
	locomotion_extension.use_lerp_rotation(locomotion_extension, true)
	LocomotionUtils.set_animation_translation_scale(unit, Vector3(1, 1, 1))

	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "stagger_finished")

	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_enabled(navigation_extension, true)

	local run_on_stagger_action_done = blackboard.breed.run_on_stagger_action_done

	if run_on_stagger_action_done then
		run_on_stagger_action_done(unit, blackboard, t)
	end

	return 
end
BTStaggerAction.run = function (self, unit, blackboard, t, dt)
	if blackboard.stagger ~= blackboard.staggering_id then
		self.enter(self, unit, blackboard, t)
	end

	local locomotion_extension = blackboard.locomotion_extension

	if blackboard.stagger_anim_done then
		LocomotionUtils.set_animation_driven_movement(unit, false)
		locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3(0, 0, 0))

		if Unit.alive(blackboard.pushing_unit) then
			local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.pushing_unit)

			locomotion_extension.set_wanted_rotation(locomotion_extension, rot)
			locomotion_extension.set_rotation_speed(locomotion_extension, 3)
		end
	elseif locomotion_extension.movement_type ~= "constrained_by_mover" and not blackboard.stagger_hit_wall then
		Profiler.start("checking navmesh")

		local EPSILON = 0.0001
		local nav_world = blackboard.nav_world
		local velocity = locomotion_extension.current_velocity(locomotion_extension)
		local unit_position = POSITION_LOOKUP[unit]
		local is_moving = EPSILON < Vector3.length_squared(velocity)
		local direction = (is_moving and Vector3.normalize(velocity)) or Vector3.zero()
		local target_position = unit_position + direction*0.3
		local is_position_on_navmesh, altitude = GwNavQueries.triangle_from_position(nav_world, unit_position, 0.1, 0.1)
		local raycango = is_position_on_navmesh and GwNavQueries.raycango(nav_world, unit_position, target_position)

		if raycango and is_position_on_navmesh then
		elseif is_moving then
			local world = blackboard.world
			local physics_world = World.physics_world(world)
			local ray_source = unit_position + Vector3.up()*0.4
			local ray_length = 1.3
			local result, hit_position, hit_distance = PhysicsWorld.immediate_raycast(physics_world, ray_source, direction, ray_length, "closest", "collision_filter", "filter_ai_mover")

			if result then
				blackboard.stagger_hit_wall = true
			else
				local action_data = self._tree_node.action_data

				locomotion_extension.set_movement_type(locomotion_extension, "constrained_by_mover", action_data.override_mover_move_distance)
			end
		end

		Profiler.stop()
	end

	if blackboard.stagger_time < t and blackboard.stagger_anim_done then
		return "done"
	else
		return "running"
	end

	return 
end

return 
