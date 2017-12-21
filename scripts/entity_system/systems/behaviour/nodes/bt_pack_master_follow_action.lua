require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTPackMasterFollowAction = class(BTPackMasterFollowAction, BTNode)
BTPackMasterFollowAction.init = function (self, ...)
	BTPackMasterFollowAction.super.init(self, ...)

	self.navigation_group_manager = Managers.state.conflict.navigation_group_manager

	return 
end
BTPackMasterFollowAction.name = "BTPackMasterFollowAction"
BTPackMasterFollowAction.enter = function (self, unit, blackboard, t)
	blackboard.action = self._tree_node.action_data
	blackboard.time_to_next_evaluate = t + 0.1
	local template_id = NetworkLookup.tutorials.elite_enemies
	local message_id = NetworkLookup.tutorials[blackboard.breed.name]

	Managers.state.network.network_transmit:send_rpc_all("rpc_tutorial_message", template_id, message_id)

	blackboard.start_anim_done = true
	blackboard.physics_world = blackboard.physics_world or World.get_data(blackboard.world, "physics_world")

	if blackboard.move_state ~= "moving" then
		blackboard.navigation_extension:set_enabled(false)
	end

	return 
end
BTPackMasterFollowAction.leave = function (self, unit, blackboard, t, reason)
	blackboard.action = nil
	blackboard.start_anim_locked = nil
	blackboard.anim_cb_rotation_start = nil
	blackboard.anim_cb_move = nil
	blackboard.start_anim_done = nil

	blackboard.navigation_extension:set_enabled(true)

	if reason == "aborted" then
		blackboard.move_state = nil
	elseif reason == "failed" then
		blackboard.target_unit = nil
	end

	return 
end
BTPackMasterFollowAction.run = function (self, unit, blackboard, t, dt)
	local target_unit = blackboard.target_unit

	if not AiUtils.is_of_interest_to_packmaster(unit, target_unit) then
		return "failed"
	end

	local current_position = POSITION_LOOKUP[unit]
	local target_position = POSITION_LOOKUP[target_unit]
	local hook_time = 0.4
	local target_locomotion_extension = ScriptUnit.extension(target_unit, "locomotion_system")
	local extrapolated_target_position = target_position + target_locomotion_extension.average_velocity(target_locomotion_extension)*hook_time
	local distance_sq = Vector3.distance_squared(current_position, extrapolated_target_position)
	local attack_distance = blackboard.action.distance_to_attack

	if distance_sq < attack_distance*attack_distance then
		local has_line_of_sight = PerceptionUtils.pack_master_has_line_of_sight_for_attack(blackboard.physics_world, unit, target_unit)

		if has_line_of_sight then
			return "done"
		end
	end

	local navigation_extension = blackboard.navigation_extension

	if blackboard.start_anim_done then
		local whereabouts_extension = ScriptUnit.extension(target_unit, "whereabouts_system")
		local pos_list, player_position_on_mesh = whereabouts_extension.closest_positions_when_outside_navmesh(whereabouts_extension)

		if player_position_on_mesh then
			local position = POSITION_LOOKUP[target_unit]

			navigation_extension.move_to(navigation_extension, position)
		elseif 0 < #pos_list then
			local position = pos_list[1]

			navigation_extension.move_to(navigation_extension, position.unbox(position))
		else
			return "failed"
		end
	end

	if navigation_extension.has_reached_destination(navigation_extension) then
		return "failed"
	end

	local should_evaluate = nil

	if blackboard.time_to_next_evaluate < t then
		should_evaluate = "evaluate"
		blackboard.time_to_next_evaluate = t + 0.1
	end

	local is_computing_path = navigation_extension.is_computing_path(navigation_extension)

	if blackboard.move_state ~= "moving" and not is_computing_path then
		local network_manager = Managers.state.network
		blackboard.move_state = "moving"

		network_manager.anim_event(network_manager, unit, "move_fwd")
		navigation_extension.set_enabled(navigation_extension, true)
	end

	return "running", should_evaluate
end

return 
