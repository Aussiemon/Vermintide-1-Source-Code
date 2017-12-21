require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTMoveToGoalAction = class(BTMoveToGoalAction, BTNode)
BTMoveToGoalAction.init = function (self, ...)
	BTMoveToGoalAction.super.init(self, ...)

	return 
end
BTMoveToGoalAction.name = "BTMoveToGoalAction"
BTMoveToGoalAction.enter = function (self, unit, blackboard, t)
	blackboard.action = self._tree_node.action_data
	blackboard.time_to_next_evaluate = t + 0.5
	blackboard.time_to_next_friend_alert = t + 0.3

	blackboard.navigation_extension:move_to(blackboard.goal_destination:unbox())
	blackboard.navigation_extension:set_enabled(true)

	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_passive")

	if ScriptUnit.has_extension(unit, "ai_inventory_system") then
		local unit_id = network_manager.unit_game_object_id(network_manager, unit)

		network_manager.network_transmit:send_rpc_all("rpc_ai_inventory_wield", unit_id)
	end

	return 
end
BTMoveToGoalAction.leave = function (self, unit, blackboard, t)
	blackboard.move_state = nil

	self.toggle_start_move_animation_lock(self, unit, false, blackboard)

	blackboard.start_anim_locked = nil
	blackboard.anim_cb_rotation_start = nil
	blackboard.anim_cb_move = nil
	blackboard.start_anim_done = nil

	AiAnimUtils.reset_animation_merge(unit)

	return 
end
BTMoveToGoalAction.run = function (self, unit, blackboard, t, dt)
	if blackboard.spawn_to_running then
		blackboard.spawn_to_running = nil
		blackboard.start_anim_done = true
		blackboard.move_state = "moving"
		blackboard.start_anim_locked = nil

		self.toggle_start_move_animation_lock(self, unit, false, blackboard)
	end

	if not blackboard.start_anim_done then
		if not blackboard.start_anim_locked then
			self.start_move_animation(self, unit, blackboard)
		end

		if blackboard.anim_cb_rotation_start then
			self.start_move_rotation(self, unit, blackboard, t, dt)
		end

		if blackboard.anim_cb_move then
			blackboard.anim_cb_move = false
			blackboard.move_state = "moving"

			self.toggle_start_move_animation_lock(self, unit, false, blackboard)

			blackboard.start_anim_locked = nil
			blackboard.start_anim_done = true

			AiAnimUtils.set_move_animation_merge(unit, blackboard)
		end
	else
		local unit_position = POSITION_LOOKUP[unit]
		local goal_destination = blackboard.goal_destination:unbox()
		local distance_to_goal_sq = Vector3.distance_squared(unit_position, goal_destination)

		if distance_to_goal_sq < 0.0625 then
			blackboard.goal_destination = nil

			blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())
			blackboard.navigation_extension:set_enabled(false)
		end
	end

	local should_evaluate = nil
	local navigation_extension = blackboard.navigation_extension

	if blackboard.time_to_next_evaluate < t or navigation_extension.has_reached_destination(navigation_extension) then
		should_evaluate = "evaluate"
		blackboard.time_to_next_evaluate = t + 0.5
	end

	return "running", should_evaluate
end
BTMoveToGoalAction.start_move_animation = function (self, unit, blackboard)
	self.toggle_start_move_animation_lock(self, unit, true, blackboard)

	local animation_name = "move_start_fwd"

	Managers.state.network:anim_event(unit, animation_name)

	blackboard.move_animation_name = animation_name
	blackboard.start_anim_locked = true

	return 
end
BTMoveToGoalAction.start_move_rotation = function (self, unit, blackboard, t, dt)
	if blackboard.move_animation_name == "move_start_fwd" then
		self.toggle_start_move_animation_lock(self, unit, false, blackboard)
	else
		blackboard.anim_cb_rotation_start = false
		local rot_scale = AiAnimUtils.get_animation_rotation_scale(unit, blackboard, blackboard.action)

		LocomotionUtils.set_animation_rotation_scale(unit, rot_scale)
	end

	return 
end
BTMoveToGoalAction.toggle_start_move_animation_lock = function (self, unit, should_lock_ani, blackboard)
	local locomotion_extension = blackboard.locomotion_extension

	if should_lock_ani then
		locomotion_extension.use_lerp_rotation(locomotion_extension, false)
		LocomotionUtils.set_animation_driven_movement(unit, true, false, false)
	else
		locomotion_extension.use_lerp_rotation(locomotion_extension, true)
		LocomotionUtils.set_animation_driven_movement(unit, false)
		LocomotionUtils.set_animation_rotation_scale(unit, 1)
	end

	return 
end

return 
