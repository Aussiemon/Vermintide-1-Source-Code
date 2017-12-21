local function get_fall_animation(unit)
	local velocity = ScriptUnit.extension(unit, "locomotion_system"):get_velocity()
	velocity.z = 0

	if Vector3.length(velocity) < 0.0001 then
		return "falling_fwd"
	end

	velocity = Vector3.normalize(velocity)
	local unit_rotation = Unit.local_rotation(unit, 0)
	local unit_direction = Quaternion.forward(unit_rotation)
	unit_direction.z = 0
	unit_direction = Vector3.normalize(unit_direction)
	local dot = Vector3.dot(velocity, unit_direction)

	if 0 <= dot then
		return "falling_fwd"
	end

	return "falling_bwd"
end

BTFallAction = class(BTFallAction, BTNode)
BTFallAction.name = "BTFallAction"
BTFallAction.init = function (self, ...)
	BTFallAction.super.init(self, ...)

	return 
end
local fall_anims = {
	fwd = "falling_fwd",
	bwd = "falling_bwd"
}
BTFallAction.enter = function (self, unit, blackboard, t)
	local fall_animation = get_fall_animation(unit)

	Managers.state.network:anim_event(unit, fall_animation)
	LocomotionUtils.set_animation_driven_movement(unit, true, true)

	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.set_affected_by_gravity(locomotion, true)
	locomotion.set_movement_type(locomotion, "constrained_by_mover")

	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, false)

	blackboard.fall_state = "waiting_to_stop_freefall"
	blackboard.fall_failsafe_timer = t + 0
	local dialogue_input = ScriptUnit.extension_input(unit, "dialogue_system")
	local event_data = FrameTable.alloc_table()

	dialogue_input.trigger_networked_dialogue_event(dialogue_input, "falling", event_data)

	return 
end
BTFallAction.leave = function (self, unit, blackboard, t, dt, new_action)
	LocomotionUtils.set_animation_driven_movement(unit, false)

	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.set_affected_by_gravity(locomotion, false)
	locomotion.set_movement_type(locomotion, "snap_to_navmesh")

	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, true)

	blackboard.jump_climb_finished = nil
	blackboard.fall_state = nil

	return 
end
BTFallAction.run = function (self, unit, blackboard, t, dt)
	if blackboard.fall_state == "waiting_to_stop_freefall" then
		local is_in_freefall = blackboard.locomotion_extension:is_falling()
		local has_waited_a_little = blackboard.fall_failsafe_timer <= t

		if not is_in_freefall and has_waited_a_little then
			blackboard.fall_state = "waiting_to_collide_down"
		end
	elseif blackboard.fall_state == "waiting_to_collide_down" then
		local mover = Unit.mover(unit)
		local mover_collides_down = Mover.collides_down(mover)

		if mover_collides_down then
			local nav_world = blackboard.nav_world
			local pos = POSITION_LOOKUP[unit]
			local success, altitude = GwNavQueries.triangle_from_position(nav_world, pos, 1, 1)

			if success then
				pos = Vector3(pos.x, pos.y, altitude)

				Unit.set_local_position(unit, 0, pos)
				LocomotionUtils.set_animation_driven_movement(unit, true, true)
				Managers.state.network:anim_event(unit, "jump_down_land")

				blackboard.fall_state = "waiting_to_land"
				local dialogue_input = ScriptUnit.extension_input(unit, "dialogue_system")
				local event_data = FrameTable.alloc_table()

				dialogue_input.trigger_networked_dialogue_event(dialogue_input, "landing", event_data)
			else
				local vertical_range = 0.5
				local horizontal_tolerance = 0.5
				local distance_from_obstacle = 0.5
				local nav_pos = GwNavQueries.inside_position_from_outside_position(nav_world, pos, vertical_range, vertical_range, horizontal_tolerance, distance_from_obstacle)

				if nav_pos then
					Unit.set_local_position(unit, 0, nav_pos)
					LocomotionUtils.set_animation_driven_movement(unit, true, true)
					Managers.state.network:anim_event(unit, "jump_down_land")

					blackboard.fall_state = "waiting_to_land"
				else
					local damage_type = "forced"
					local damage_direction = Vector3(0, 0, -1)

					AiUtils.kill_unit(unit, nil, nil, damage_type, damage_direction)

					return "failed"
				end
			end
		end
	elseif blackboard.fall_state == "waiting_to_land" and blackboard.jump_climb_finished then
		return "done"
	end

	return "running"
end

return 
