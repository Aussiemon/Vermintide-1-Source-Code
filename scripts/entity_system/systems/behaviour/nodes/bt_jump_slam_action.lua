require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local position_lookup = POSITION_LOOKUP
BTJumpSlamAction = class(BTJumpSlamAction, BTNode)
BTJumpSlamAction.init = function (self, ...)
	BTJumpSlamAction.super.init(self, ...)

	return 
end
BTJumpSlamAction.name = "BTJumpSlamAction"
BTJumpSlamAction.enter = function (self, unit, blackboard, t)
	local data = blackboard.jump_slam_data
	data.anim_jump_rot_var = Unit.animation_find_variable(unit, "jump_rotation")
	data.start_jump_time = t
	data.landing_time = t + data.time_of_flight
	blackboard.keep_target = true
	local animation_system = Managers.state.entity:system("animation_system")

	animation_system.start_anim_variable_update_by_time(animation_system, unit, data.anim_jump_rot_var, data.time_of_flight, 2)
	BTJumpSlamAction.progress_to_in_flight(blackboard, unit, data.initial_velociy_boxed:unbox())
	Managers.state.conflict:freeze_intensity_decay(15)

	return 
end
BTJumpSlamAction.leave = function (self, unit, blackboard, t, reason)
	local animation_system = Managers.state.entity:system("animation_system")

	animation_system.set_update_anim_variable_done(animation_system, unit)

	blackboard.jump_slam_data.updating_jump_rot = false

	blackboard.navigation_extension:set_enabled(true)

	if reason == "aborted" then
		LocomotionUtils.set_animation_driven_movement(unit, false, true)

		blackboard.attack_jump_data = nil
		blackboard.keep_target = nil
	end

	local data = blackboard.jump_slam_data

	if data.constrained then
		LocomotionUtils.constrain_on_clients(unit, false, Vector3.zero(), Vector3.zero())
	end

	return 
end
BTJumpSlamAction.run = function (self, unit, blackboard, t, dt)
	local data = blackboard.jump_slam_data
	local velocity = blackboard.locomotion_extension:current_velocity()
	local z_speed = velocity.z

	if z_speed < 0 and not data.constrained then
		data.constrained = true
		local constrain_max = POSITION_LOOKUP[unit] + Vector3.up()*2
		local constrain_min = data.target_pos:unbox()

		LocomotionUtils.constrain_on_clients(unit, true, constrain_min, constrain_max)
	end

	if data.landing_time <= t + dt then
		BTJumpSlamAction.progress_to_landing(blackboard, unit, data)

		return "done"
	end

	return "running"
end
BTJumpSlamAction.progress_to_landing = function (blackboard, unit, data)
	LocomotionUtils.set_animation_driven_movement(unit, true, true)
	Managers.state.network:anim_event(unit, "attack_jump_land")

	local locomotion = blackboard.locomotion_extension

	locomotion.set_movement_type(locomotion, "snap_to_navmesh")
	locomotion.set_gravity(locomotion, nil)

	return 
end
BTJumpSlamAction.progress_to_in_flight = function (blackboard, unit, velocity)
	LocomotionUtils.set_animation_driven_movement(unit, false, true)

	local locomotion = blackboard.locomotion_extension

	locomotion.set_movement_type(locomotion, "script_driven")
	locomotion.set_affected_by_gravity(locomotion, true)
	locomotion.set_gravity(locomotion, blackboard.breed.jump_slam_gravity)
	locomotion.set_wanted_velocity(locomotion, velocity)

	return 
end

return 
