require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTSkavenSlaveAttackAction = class(BTSkavenSlaveAttackAction, BTNode)
BTSkavenSlaveAttackAction.init = function (self, ...)
	BTSkavenSlaveAttackAction.super.init(self, ...)

	return 
end
BTSkavenSlaveAttackAction.setup = function (self, unit, blackboard, profile)
	return 
end
BTSkavenSlaveAttackAction.run = function (self, unit, blackboard, t, dt, bt_name)
	if blackboard.slash_attacking then
		Debug.text("slash action - running")

		return "running"
	end

	if blackboard.slash_attacking_done then
		blackboard.slash_attacking_done = nil

		Debug.text("slash action - done")

		return "success"
	end

	print("slave attack time + 2")

	blackboard.action_done_time = t + 2
	blackboard.in_combat = true
	blackboard.slash_attacking = true
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.start_slash_attack(locomotion, blackboard, t)

	return "running"
end
BTSkavenSlaveAttackAction.exit_running = function (self, unit, blackboard)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.reset_attack(locomotion, blackboard)

	return 
end

return 
