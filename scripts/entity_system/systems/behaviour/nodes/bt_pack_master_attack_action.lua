require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTPackMasterAttackAction = class(BTPackMasterAttackAction, BTNode)
BTPackMasterAttackAction.init = function (self, ...)
	BTPackMasterAttackAction.super.init(self, ...)

	return 
end
BTPackMasterAttackAction.name = "BTPackMasterAttackAction"
BTPackMasterAttackAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.active_node = BTPackMasterAttackAction
	blackboard.attacks_done = 0
	blackboard.attack_aborted = nil
	blackboard.attack_success = nil
	blackboard.drag_target_unit = blackboard.target_unit
	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_combat")

	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	network_manager.network_transmit:send_rpc_all("rpc_enemy_has_target", unit_id, true)

	blackboard.target_unit_status_extension = ScriptUnit.has_extension(blackboard.target_unit, "status_system") or nil

	blackboard.navigation_extension:set_enabled(false)
	blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())

	return 
end
BTPackMasterAttackAction.leave = function (self, unit, blackboard, t, reason)
	blackboard.move_state = nil

	blackboard.navigation_extension:set_enabled(true)

	if reason ~= "done" then
		blackboard.packmaster_target_group = nil
		blackboard.target_unit = nil
		blackboard.drag_target_unit = nil

		if blackboard.attack_success and Unit.alive(blackboard.drag_target_unit) then
			StatusUtils.set_grabbed_by_pack_master_network("pack_master_pulling", blackboard.target_unit, false, unit)
			print("Packmaster weird case")
		end

		LocomotionUtils.set_animation_driven_movement(unit, false)
	end

	blackboard.target_unit_status_extension = nil
	blackboard.active_node = nil
	blackboard.attack_aborted = nil
	blackboard.attack_finished = nil
	blackboard.attack_success = nil
	blackboard.attack_time_ends = nil
	blackboard.attack_cooldown = t + blackboard.action.cooldown
	blackboard.action = nil

	return 
end
BTPackMasterAttackAction.run = function (self, unit, blackboard, t, dt)
	if not AiUtils.is_of_interest_to_packmaster(unit, blackboard.target_unit) then
		return "failed"
	end

	if blackboard.attack_aborted then
		local network_manager = Managers.state.network

		network_manager.anim_event(network_manager, unit, "idle")

		return "failed"
	end

	if blackboard.attack_success then
		return "done"
	end

	self.attack(self, unit, t, dt, blackboard)

	return "running"
end
BTPackMasterAttackAction.attack = function (self, unit, t, dt, blackboard)
	local action = blackboard.action
	local locomotion_extension = blackboard.locomotion_extension

	if blackboard.move_state ~= "attacking" then
		blackboard.move_state = "attacking"

		locomotion_extension.use_lerp_rotation(locomotion_extension, true)
		LocomotionUtils.set_animation_driven_movement(unit, true, false, true)
		Managers.state.network:anim_event(unit, action.attack_anim)

		blackboard.attack_time_ends = t + blackboard.action.attack_anim_duration
	end

	local rotation = LocomotionUtils.rotation_towards_unit(unit, blackboard.target_unit)

	locomotion_extension.set_wanted_rotation(locomotion_extension, rotation)

	if blackboard.attack_time_ends < t then
		blackboard.attack_aborted = true
	end

	return 
end
BTPackMasterAttackAction.attack_success = function (self, unit, blackboard)
	if blackboard.active_node and blackboard.active_node == BTPackMasterAttackAction then
		local target_unit = blackboard.target_unit

		if blackboard.target_unit_status_extension and blackboard.target_unit_status_extension:get_is_dodging() then
			local pos = POSITION_LOOKUP[unit]
			local dodge_pos = POSITION_LOOKUP[target_unit]
			local dir = Vector3.normalize(Vector3.flat(dodge_pos - pos))
			local forward = Quaternion.forward(Unit.local_rotation(unit, 0))
			local dot_value = Vector3.dot(dir, forward)
			local angle = math.acos(dot_value)
			local distance_squared = Vector3.distance_squared(pos, dodge_pos)

			if math.radians_to_degrees(angle) <= blackboard.action.dodge_angle and distance_squared < blackboard.action.dodge_distance*blackboard.action.dodge_distance then
				blackboard.attack_success = PerceptionUtils.pack_master_has_line_of_sight_for_attack(blackboard.physics_world, unit, target_unit)
			else
				blackboard.attack_success = false
			end
		else
			blackboard.attack_success = PerceptionUtils.pack_master_has_line_of_sight_for_attack(blackboard.physics_world, unit, target_unit)
		end

		local first_person_extension = ScriptUnit.has_extension(blackboard.target_unit, "first_person_system")

		if blackboard.attack_success and first_person_extension then
			first_person_extension.animation_event(first_person_extension, "shake_get_hit")
		end
	end

	return 
end

return 
