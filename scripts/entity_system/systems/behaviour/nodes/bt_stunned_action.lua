require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTStunnedAction = class(BTStunnedAction, BTNode)
BTStunnedAction.name = "BTStunnedAction"
BTStunnedAction.init = function (self, ...)
	BTStunnedAction.super.init(self, ...)

	return 
end
BTStunnedAction.enter = function (self, unit, blackboard, t)
	local stun_anim = "idle"

	Managers.state.network:anim_event(unit, stun_anim)

	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.set_wanted_velocity(locomotion, Vector3(0, 0, 0))

	local navigation = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation.set_enabled(navigation, false)

	blackboard.attack_aborted = true
	blackboard.spawn_to_running = nil

	return 
end
BTStunnedAction.leave = function (self, unit, blackboard, t, dt, new_action)
	if blackboard.stunned_time <= t then
		blackboard.stunned = nil
	end

	ScriptUnit.extension(unit, "ai_navigation_system"):set_enabled(true)

	return 
end
BTStunnedAction.run = function (self, unit, blackboard, t, dt)
	if blackboard.stunned_time <= t then
		blackboard.stunned = nil

		return "done"
	end

	return "running"
end

return 
