require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBotTransportedIdleAction = class(BTBotTransportedIdleAction, BTNode)
BTBotTransportedIdleAction.name = "BTBotTransportedIdleAction"

BTBotTransportedIdleAction.init = function (self, ...)
	BTBotTransportedIdleAction.super.init(self, ...)
end

BTBotTransportedIdleAction.enter = function (self, unit, blackboard, t)
	local network_manager = Managers.state.network
	local animation = blackboard.idle_animation or "idle"

	network_manager:anim_event(unit, animation)
end

BTBotTransportedIdleAction.leave = function (self, unit, blackboard, t)
	return
end

BTBotTransportedIdleAction.run = function (self, unit, blackboard, t, dt)
	return "running"
end

return
