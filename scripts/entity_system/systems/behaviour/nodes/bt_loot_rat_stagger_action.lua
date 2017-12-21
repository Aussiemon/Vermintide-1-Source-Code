require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTLootRatStaggerAction = class(BTLootRatStaggerAction, BTNode)
BTLootRatStaggerAction.init = function (self, ...)
	BTLootRatStaggerAction.super.init(self, ...)

	return 
end
BTLootRatStaggerAction.name = "BTLootRatStaggerAction"
local position_lookup = POSITION_LOOKUP
local script_data = script_data
BTLootRatStaggerAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	local dodge_vector = blackboard.dodge_vector:unbox()
	local threat_vector = blackboard.threat_vector:unbox()
	local dodge_position, pass_check_position = self.dodge(self, unit, blackboard, dodge_vector, threat_vector)

	if dodge_position then
		blackboard.is_dodging = true
		blackboard.pass_check_position = Vector3Box(pass_check_position)
		blackboard.dodge_end_time = t + action.dodge_time

		LocomotionUtils.set_animation_driven_movement(unit, false)

		local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

		navigation_extension.set_max_speed(navigation_extension, blackboard.breed.run_speed)
		navigation_extension.move_to(navigation_extension, dodge_position)

		local locomotion = blackboard.locomotion_extension

		locomotion.set_rotation_speed(locomotion, 20)
		locomotion.set_movement_type(locomotion, "snap_to_navmesh")

		local network_manager = Managers.state.network

		network_manager.anim_event(network_manager, unit, action.dodge_anim)

		if script_data.debug_ai_movement then
			local unit_position = position_lookup[unit]

			QuickDrawerStay:sphere(dodge_position, 0.2, Color(255, 255, 0))
			QuickDrawerStay:sphere(pass_check_position, 0.2, Color(255, 0, 0))
			QuickDrawerStay:line(unit_position, dodge_position, Color(255, 255, 0))
		end
	end

	return 
end
BTLootRatStaggerAction.run = function (self, unit, blackboard, t, dt)
	if not blackboard.is_dodging then
		return "done"
	end

	if blackboard.anim_cb_dodge_finished then
		return "done"
	end

	if blackboard.dodge_end_time < t then
		return "done"
	end

	local pass_check_position = blackboard.pass_check_position:unbox()
	local unit_position = position_lookup[unit]
	local to_pass_check_position = pass_check_position - unit_position
	local unit_rotation = Unit.local_rotation(unit, 0)
	local unit_forward = Quaternion.forward(unit_rotation)
	local dot = Vector3.dot(Vector3.normalize(to_pass_check_position), unit_forward)

	if not blackboard.do_pass_check and 0.5 < dot then
		blackboard.do_pass_check = true
	end

	if blackboard.do_pass_check and dot < 0 then
		return "done"
	end

	return "running"
end
BTLootRatStaggerAction.leave = function (self, unit, blackboard, t)
	blackboard.action = nil
	blackboard.is_dodging = nil
	blackboard.pass_check_position = nil
	blackboard.dodge_end_time = nil
	blackboard.do_pass_check = nil
	blackboard.dodge_vector = nil
	blackboard.threat_vector = nil
	blackboard.anim_cb_dodge_finished = nil
	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_max_speed(navigation_extension, default_move_speed)

	if script_data.debug_ai_movement then
		local unit_position = position_lookup[unit]

		QuickDrawerStay:sphere(unit_position, 0.25, Color(0, 255, 0))
	end

	return 
end
BTLootRatStaggerAction.dodge = function (self, unit, blackboard, dodge_vector, threat_vector)
	local unit_position = position_lookup[unit]
	local velocity = blackboard.locomotion_extension:get_velocity()
	local normalized_velocity = Vector3.normalize(velocity)
	local normalized_dodge_vector = Vector3.normalize(dodge_vector)
	local left_right = Vector3.cross(-threat_vector, Vector3.up())

	if 0 < Vector3.cross(normalized_dodge_vector, threat_vector).z then
		left_right = -left_right
	end

	local dodge_direction = left_right*2 + normalized_velocity
	local dodge_distance = blackboard.action.dodge_distance
	local pass_check_distance = dodge_distance - 0.3
	local try_position = unit_position + dodge_direction*dodge_distance
	local dodge_position = self.try_dodge_position(self, unit, blackboard, unit_position, try_position)

	if dodge_position then
		local pass_check_position = unit_position + dodge_direction*pass_check_distance

		return dodge_position, pass_check_position
	end

	try_position = unit_position - dodge_direction*dodge_distance
	dodge_position = self.try_dodge_position(self, unit, blackboard, unit_position, try_position)

	if dodge_position then
		local pass_check_position = unit_position - dodge_direction*pass_check_distance

		return dodge_position, pass_check_position
	end

	return 
end
BTLootRatStaggerAction.try_dodge_position = function (self, unit, blackboard, unit_position, dodge_position)
	local success, altitude = GwNavQueries.triangle_from_position(blackboard.nav_world, dodge_position, 3, 3)

	if success then
		Vector3.set_z(dodge_position, altitude)

		local success = GwNavQueries.raycast(blackboard.nav_world, unit_position, dodge_position)

		if success then
			return dodge_position
		end
	end

	return 
end

return 