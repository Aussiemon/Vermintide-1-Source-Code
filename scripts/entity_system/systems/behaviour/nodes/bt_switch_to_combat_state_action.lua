require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTSwitchToCombatStateAction = class(BTSwitchToCombatStateAction, BTNode)
BTSwitchToCombatStateAction.name = "BTSwitchToCombatStateAction"
BTSwitchToCombatStateAction.init = function (self, ...)
	BTSwitchToCombatStateAction.super.init(self, ...)

	return 
end
BTSwitchToCombatStateAction.enter = function (self, unit, blackboard, t)
	blackboard.in_combat_state = true

	return 
end
BTSwitchToCombatStateAction.leave = function (self, unit, blackboard, t, reason)
	return 
end
BTSwitchToCombatStateAction.run = function (self, unit, blackboard, t, dt)
	return "done"
end

return 
