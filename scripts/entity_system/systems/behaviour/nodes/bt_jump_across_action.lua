require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local function debug_graph()
	local graph = Managers.state.debug.graph_drawer:graph("BTJumpAcrossAction")

	if graph == nil then
		graph = Managers.state.debug.graph_drawer:create_graph("BTJumpAcrossAction", {
			"time",
			"unit altitude"
		})
	end

	return graph
end

BTJumpAcrossAction = class(BTJumpAcrossAction, BTNode)
BTJumpAcrossAction.init = function (self, ...)
	BTJumpAcrossAction.super.init(self, ...)

	return 
end
BTJumpAcrossAction.name = "BTJumpAcrossAction"
BTJumpAcrossAction.enter = function (self, unit, blackboard, t)
	local drawer = Managers.state.debug:drawer({
		mode = "retained",
		name = "BTJumpAcrossAction"
	})

	drawer.reset(drawer)

	local next_smart_object_data = blackboard.next_smart_object_data
	local entrance_pos = next_smart_object_data.entrance_pos:unbox()
	local exit_pos = next_smart_object_data.exit_pos:unbox()
	blackboard.jump_entrance_pos = Vector3Box(entrance_pos)
	blackboard.jump_exit_pos = Vector3Box(exit_pos)
	blackboard.jump_jump_height = exit_pos.z - entrance_pos.z
	blackboard.jump_upwards = 0 < blackboard.jump_jump_height
	blackboard.jump_ledge_lookat_direction = Vector3Box(Vector3.normalize(Vector3.flat(exit_pos - entrance_pos)))
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_affected_by_gravity(locomotion_extension, false)
	locomotion_extension.set_movement_type(locomotion_extension, "snap_to_navmesh")
	locomotion_extension.set_rotation_speed(locomotion_extension, 10)

	blackboard.jump_state = "moving_to_ledge"

	if script_data.ai_debug_smartobject then
		Unit.set_animation_logging(unit, true)

		local unit_position = POSITION_LOOKUP[unit]

		debug_graph():reset()
		debug_graph():set_active(true)
		debug_graph():add_annotation({
			color = "green",
			x = t,
			y = unit_position.z,
			text = "starting BTJumpAcrossAction" .. tostring(unit_position)
		})
	else
		debug_graph():set_active(false)
	end

	return 
end
BTJumpAcrossAction.leave = function (self, unit, blackboard, t)
	blackboard.jump_spline_ground = nil
	blackboard.jump_spline_ledge = nil
	blackboard.jump_entrance_pos = nil
	blackboard.jump_state = nil
	blackboard.jump_upwards = nil
	blackboard.is_jumping = nil
	blackboard.jump_jump_height = nil
	blackboard.jump_ledge_lookat_direction = nil
	blackboard.jump_entrance_pos = nil
	blackboard.jump_exit_pos = nil
	blackboard.is_smart_objecting = nil
	blackboard.jump_start_finished = nil

	LocomotionUtils.set_animation_translation_scale(unit, Vector3(1, 1, 1))

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_movement_type(locomotion_extension, "snap_to_navmesh")
	locomotion_extension.set_affected_by_gravity(locomotion_extension, true)
	locomotion_extension.set_animation_driven(locomotion_extension, false)

	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, true)

	local hit_reaction_extension = ScriptUnit.extension(unit, "hit_reaction_system")
	hit_reaction_extension.force_ragdoll_on_death = nil
	slot7 = navigation_extension.is_using_smart_object(navigation_extension) and navigation_extension.use_smart_object(navigation_extension, false)

	return 
end
local default_jump_data = {
	scale = 1
}
BTJumpAcrossAction.run = function (self, unit, blackboard, t, dt)
	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local unit_position = POSITION_LOOKUP[unit]
	local jump_state_current = blackboard.jump_state
	local drawer = Managers.state.debug:drawer({
		mode = "immediate",
		name = "BTJumpAcrossAction2"
	})

	if script_data.ai_debug_smartobject then
		Debug.text("BTJumpAcrossAction state=%s", blackboard.jump_state)
		Debug.text("BTJumpAcrossAction entrance_pos=%s", tostring(blackboard.jump_entrance_pos:unbox()))
		Debug.text("BTJumpAcrossAction exit_pos=        %s", tostring(blackboard.jump_exit_pos:unbox()))
		Debug.text("BTJumpAcrossAction pos=            %s", tostring(POSITION_LOOKUP[unit]))
		drawer.sphere(drawer, blackboard.jump_entrance_pos:unbox(), 0.3, Colors.get("red"))
		drawer.sphere(drawer, blackboard.jump_exit_pos:unbox(), 0.3, Colors.get("red"))
		drawer.sphere(drawer, unit_position, math.sin(t*5)*0.01 + 0.3, Colors.get("purple"))
		debug_graph():add_point(t, unit_position.z)
	end

	if blackboard.jump_state == "moving_to_ledge" and Vector3.distance(blackboard.jump_entrance_pos:unbox(), unit_position) < 1 then
		locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3(0, 0, 0))
		locomotion_extension.set_movement_type(locomotion_extension, "script_driven")
		navigation_extension.set_enabled(navigation_extension, false)

		if navigation_extension.use_smart_object(navigation_extension, true) then
			blackboard.is_smart_objecting = true
			blackboard.is_jumping = true
			blackboard.jump_state = "moving_towards_smartobject_entrance"
		else
			print("BTJumpAcrossAction - failing to use smart object")

			return "failed"
		end
	end

	if blackboard.jump_state == "moving_towards_smartobject_entrance" then
		local entrance_pos = blackboard.jump_entrance_pos:unbox()
		local move_target = entrance_pos
		local look_direction_wanted = blackboard.jump_ledge_lookat_direction:unbox()
		local wanted_rotation = Quaternion.look(look_direction_wanted)
		local vector_to_target = move_target - unit_position
		local distance_to_target = Vector3.length(vector_to_target)

		if 0.1 < distance_to_target then
			local speed = blackboard.breed.run_speed

			if distance_to_target < speed*dt then
				speed = distance_to_target/dt
			end

			local direction_to_target = Vector3.normalize(vector_to_target)

			locomotion_extension.set_wanted_velocity(locomotion_extension, direction_to_target*speed)
			locomotion_extension.set_wanted_rotation(locomotion_extension, wanted_rotation)

			if script_data.ai_debug_smartobject then
				drawer.vector(drawer, unit_position + Vector3.up()*0.3, vector_to_target)
				drawer.sphere(drawer, move_target, 0.3, Colors.get("blue"))
			end
		else
			local animation_distance = 4

			locomotion_extension.set_animation_driven(locomotion_extension, true)
			locomotion_extension.teleport_to(locomotion_extension, move_target, wanted_rotation)
			Managers.state.network:anim_event(unit, "jump_over_gap_4m")

			local entrance_pos = blackboard.jump_entrance_pos:unbox()
			local exit_pos = blackboard.jump_exit_pos:unbox()
			local jump_vector = exit_pos - entrance_pos
			local height_factor = jump_vector.z
			local forward_factor = Vector3.length(Vector3.flat(jump_vector))/animation_distance

			LocomotionUtils.set_animation_translation_scale(unit, Vector3(forward_factor, forward_factor, height_factor))

			local hit_reaction_extension = ScriptUnit.extension(unit, "hit_reaction_system")
			hit_reaction_extension.force_ragdoll_on_death = true
			blackboard.jump_state = "waiting_to_reach_end"
		end
	end

	if blackboard.jump_state == "waiting_to_reach_end" and blackboard.jump_start_finished then
		local exit_pos = blackboard.jump_exit_pos:unbox()

		navigation_extension.set_navbot_position(navigation_extension, exit_pos)
		locomotion_extension.teleport_to(locomotion_extension, exit_pos)
		Managers.state.network:anim_event(unit, "move_fwd")

		blackboard.spawn_to_running = true
		blackboard.jump_state = "done"
	end

	if blackboard.jump_state == "done" then
		blackboard.jump_state = "done_for_reals"
	elseif blackboard.jump_state == "done_for_reals" then
		blackboard.jump_state = "done_for_reals2"
	elseif blackboard.jump_state == "done_for_reals2" then
		return "done"
	end

	if not script_data.ai_debug_smartobject then
		drawer.reset(drawer)
	end

	return "running"
end

return 