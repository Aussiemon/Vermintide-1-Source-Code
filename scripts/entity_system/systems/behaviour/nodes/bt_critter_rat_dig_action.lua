require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTCritterRatDigAction = class(BTCritterRatDigAction, BTNode)
BTCritterRatDigAction.init = function (self, ...)
	BTCritterRatDigAction.super.init(self, ...)

	return 
end
BTCritterRatDigAction.name = "BTCritterRatDigAction"
BTCritterRatDigAction.enter = function (self, unit, blackboard, t)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_enabled(navigation_extension, false)
	Managers.state.network:anim_event(unit, "dig_ground")

	return 
end
BTCritterRatDigAction.leave = function (self, unit, blackboard, t, reason)
	if reason ~= "aborted" then
		local conflict = Managers.state.conflict

		conflict.destroy_unit(conflict, unit, blackboard, "dig_ground")
	else
		blackboard.navigation_extension:set_enabled(true)
	end

	return 
end
BTCritterRatDigAction.run = function (self, unit, blackboard, t)
	if blackboard.anim_cb_dig_finished then
		return "done"
	else
		return "running"
	end

	return 
end

return 
