require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTStormVerminPushAction = class(BTStormVerminPushAction, BTNode)
BTStormVerminPushAction.name = "BTStormVerminPushAction"
BTStormVerminPushAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.active_node = BTStormVerminPushAction
	blackboard.attack_finished = false
	blackboard.attack_aborted = false
	local target_unit = blackboard.target_unit
	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	network_manager.network_transmit:send_rpc_all("rpc_enemy_has_target", unit_id, true)

	local navigation_extension = blackboard.navigation_extension

	blackboard.navigation_extension:set_enabled(false)
	blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())

	blackboard.attacking_target = target_unit
	blackboard.move_state = "attacking"

	network_manager.anim_event(network_manager, unit, "to_combat")
	network_manager.anim_event(network_manager, unit, action.attack_anim)

	return 
end
BTStormVerminPushAction.leave = function (self, unit, blackboard, t)
	blackboard.move_state = nil

	blackboard.navigation_extension:set_enabled(true)

	blackboard.active_node = nil
	blackboard.attack_aborted = nil
	blackboard.attacking_target = nil
	blackboard.attack_anim = nil

	return 
end
BTStormVerminPushAction.run = function (self, unit, blackboard, t, dt)
	if blackboard.attack_aborted then
		local network_manager = Managers.state.network

		network_manager.anim_event(network_manager, unit, "idle")

		return "done"
	elseif blackboard.attack_finished then
		return "done"
	else
		self.attack(self, unit, t, dt, blackboard)

		return "running"
	end

	return 
end
BTStormVerminPushAction.attack = function (self, unit, t, dt, blackboard)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local rotation = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)

	locomotion.set_wanted_rotation(locomotion, rotation)

	return 
end
BTStormVerminPushAction.anim_cb_stormvermin_push = function (self, unit, blackboard, target_unit)
	if not DamageUtils.check_distance(blackboard.action, blackboard, unit, target_unit) or not DamageUtils.check_infront(unit, target_unit) then
		return 
	end

	local action = blackboard.action
	local status_extension = ScriptUnit.extension(target_unit, "status_system")

	if not status_extension.is_disabled(status_extension) then
		StatusUtils.set_pushed_network(target_unit, true)

		local velocity = Quaternion.forward(Unit.local_rotation(unit, 0))*action.impact_push_speed
		local locomotion_extension = ScriptUnit.extension(target_unit, "locomotion_system")

		locomotion_extension.add_external_velocity(locomotion_extension, velocity, action.max_impact_push_speed)
	end

	return 
end

return 
