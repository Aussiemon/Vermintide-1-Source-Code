require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTTargetUnreachableAction = class(BTTargetUnreachableAction, BTNode)
BTTargetUnreachableAction.init = function (self, ...)
	BTTargetUnreachableAction.super.init(self, ...)

	return 
end
BTTargetUnreachableAction.name = "BTTargetUnreachableAction"
BTTargetUnreachableAction.enter = function (self, unit, blackboard, t)
	blackboard.unreachable_check_timer = t
	blackboard.unreachable_timer = blackboard.chasing_timer or 0

	return 
end
BTTargetUnreachableAction.leave = function (self, unit, blackboard, t)
	blackboard.unreachable_check_timer = nil
	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_max_speed(navigation_extension, default_move_speed)

	return 
end
BTTargetUnreachableAction.run = function (self, unit, blackboard, t, dt)
	local whereabouts_extension = ScriptUnit.extension(blackboard.target_unit, "whereabouts_system")
	local pos = POSITION_LOOKUP[unit]
	local enemy_pos = POSITION_LOOKUP[blackboard.target_unit]
	local pos_list, player_on_mesh = whereabouts_extension.closest_positions_when_outside_navmesh(whereabouts_extension)
	blackboard.target_outside_navmesh = not player_on_mesh
	blackboard.unreachable_check_timer = t + 0.2
	local closest_pos = nil
	local best_score = math.huge
	local reach_distance_squared = blackboard.breed.reach_distance * blackboard.breed.reach_distance

	for i = 1, #pos_list, 1 do
		local test_pos = pos_list[i]:unbox()
		local score = 0
		local dist_enemy_and_player = Vector3.distance_squared(enemy_pos, test_pos)

		if dist_enemy_and_player < reach_distance_squared * 4 then
			score = dist_enemy_and_player
		else
			local dist_point = Vector3.distance_squared(test_pos, pos)
			local dist_player = Vector3.distance_squared(enemy_pos, pos)
			score = score + dist_point + dist_player
		end

		if score < best_score then
			closest_pos = test_pos
			best_score = score
		end
	end

	if closest_pos then
		blackboard.navigation_extension:move_to(closest_pos)
	end

	local locomotion = blackboard.locomotion_extension

	self.move_closer(self, unit, t, dt, blackboard, locomotion)

	blackboard.unreachable_timer = blackboard.unreachable_timer + dt

	return "running", "evaluate"
end
BTTargetUnreachableAction.move_closer = function (self, unit, t, dt, blackboard, locomotion)
	local navigation_extension = blackboard.navigation_extension
	local destination = navigation_extension.destination(navigation_extension)
	local to_vec = destination - POSITION_LOOKUP[unit]
	local distance = Vector3.length(to_vec)

	Vector3.set_z(to_vec, 0)

	local flat_distance = Vector3.length(to_vec)

	Debug.text("unreach dist to target:" .. tostring(distance) .. " flat:" .. tostring(flat_distance))

	if distance < 1 then
		navigation_extension.set_max_speed(navigation_extension, blackboard.breed.walk_speed)
	elseif 2 < distance then
		navigation_extension.set_max_speed(navigation_extension, blackboard.breed.run_speed)
	end

	if blackboard.move_state ~= "moving" and 0.5 < distance then
		print("GO TO UNREACHABLE MOVING", distance)

		blackboard.move_state = "moving"
		local action = self._tree_node.action_data
		local start_anim, anim_driven = LocomotionUtils.get_start_anim(unit, blackboard, action.start_anims)

		Managers.state.network:anim_event(unit, start_anim or action.move_anim)
	elseif blackboard.move_state ~= "idle" and distance < 0.2 then
		print("GO TO UNREACHABLE IDLE", distance, unit)

		blackboard.move_state = "idle"

		Managers.state.network:anim_event(unit, "idle")
	end

	if blackboard.move_state == "moving" then
		locomotion.set_wanted_rotation(locomotion, nil)
	else
		local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)

		locomotion.set_wanted_rotation(locomotion, rot)
	end

	return 
end

return 
