require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTGrabAction = class(BTGrabAction, BTNode)

BTGrabAction.init = function (self, ...)
	BTGrabAction.super.init(self, ...)
end

BTGrabAction.name = "BTGrabAction"

BTGrabAction.enter = function (self, unit, blackboard, t)
	return
end

BTGrabAction.leave = function (self, unit, blackboard, t)
	blackboard.shove_data = nil
end

BTGrabAction.run = function (self, unit, blackboard, t, dt)
	return
end

return
