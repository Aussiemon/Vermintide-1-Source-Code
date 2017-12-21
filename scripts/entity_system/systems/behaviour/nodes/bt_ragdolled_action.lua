require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTRagdolledAction = class(BTRagdolledAction, BTNode)
BTRagdolledAction.init = function (self, ...)
	BTRagdolledAction.super.init(self, ...)

	return 
end
BTRagdolledAction.name = "BTRagdolledAction"
BTRagdolledAction.enter = function (self, unit, blackboard, t)
	return 
end
BTRagdolledAction.leave = function (self, unit, blackboard, t)
	return 
end
BTRagdolledAction.run = function (self, unit, blackboard, t, dt)
	return "running"
end

return 
