require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTCirclePreyAction = class(BTCirclePreyAction, BTNode)
BTCirclePreyAction.name = "BTCirclePreyAction"
BTCirclePreyAction.init = function (self, ...)
	BTCirclePreyAction.super.init(self, ...)

	return 
end
BTCirclePreyAction.enter = function (self, unit, blackboard, t)
	LocomotionUtils.set_animation_driven_movement(unit, false)

	local navigation_extension = blackboard.navigation_extension
	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_combat")

	if not blackboard.skulk_pos then
		self.get_new_goal(self, unit, blackboard)
	end

	local is_position_on_navmesh = GwNavQueries.triangle_from_position(blackboard.nav_world, POSITION_LOOKUP[unit], 0.5, 0.5)

	if is_position_on_navmesh then
		network_manager.anim_event(network_manager, unit, "move_fwd")

		blackboard.move_state = "moving"

		navigation_extension.set_max_speed(navigation_extension, blackboard.breed.run_speed)
	else
		network_manager.anim_event(network_manager, unit, "idle")

		blackboard.move_state = "idle"
		blackboard.ninja_vanish = true

		navigation_extension.stop(navigation_extension)
	end

	return 
end
BTCirclePreyAction.leave = function (self, unit, blackboard, t, reason)
	if reason == "aborted" then
		blackboard.skulk_pos = nil
	end

	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_max_speed(navigation_extension, default_move_speed)

	return 
end
BTCirclePreyAction.run = function (self, unit, blackboard, t, dt)
	local locomotion = blackboard.locomotion_extension
	local ai_navigation = blackboard.navigation_extension

	if not blackboard.skulk_pos then
		local pos = self.get_new_goal(self, unit, blackboard)

		if pos then
			ai_navigation.move_to(ai_navigation, pos)
		end

		return "running"
	end

	local goal_pos = blackboard.skulk_pos:unbox()

	ai_navigation.move_to(ai_navigation, goal_pos)
	locomotion.set_wanted_rotation(locomotion, nil)

	if Vector3.distance(goal_pos, POSITION_LOOKUP[unit]) < 3 then
		self.get_new_goal(self, unit, blackboard)
	end

	return "running"
end
BTCirclePreyAction.get_new_goal = function (self, unit, blackboard)
	local target_unit = blackboard.secondary_target or blackboard.target_unit

	if Unit.alive(target_unit) then
		local center_pos = POSITION_LOOKUP[target_unit]
		local pos = LocomotionUtils.new_random_goal(blackboard.nav_world, blackboard, center_pos, 5, 10, 10)

		if pos then
			blackboard.skulk_pos = Vector3Box(pos)

			return pos
		end
	end

	return 
end

return 
