require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTFollowPlayerAction = class(BTFollowPlayerAction, BTNode)
BTFollowPlayerAction.init = function (self, ...)
	BTFollowPlayerAction.super.init(self, ...)

	return 
end
BTFollowPlayerAction.name = "BTFollowPlayerAction"
BTFollowPlayerAction.enter = function (self, unit, blackboard, t)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.enter_state_combat(locomotion, blackboard, t)

	return 
end
BTFollowPlayerAction.leave = function (self, unit, blackboard, t)
	return 
end
BTFollowPlayerAction.run = function (self, unit, blackboard, t)
	if not Unit.alive(blackboard.target_unit) then
		return 
	end

	return self
end
BTFollowPlayerAction.exit_running = function (self, unit, blackboard, t)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.enter_state_onground(locomotion, blackboard, t)

	return 
end

return 