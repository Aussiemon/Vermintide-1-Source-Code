require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBotHealOtherAction = class(BTBotHealOtherAction, BTNode)
BTBotHealOtherAction.init = function (self, ...)
	BTBotHealOtherAction.super.init(self, ...)

	return 
end
BTBotHealOtherAction.name = "BTBotHealOtherAction"
BTBotHealOtherAction.enter = function (self, unit, blackboard, t)
	local input_ext = ScriptUnit.extension(unit, "input_system")
	local soft_aiming = true
	local use_rotation = false

	input_ext.set_aiming(input_ext, true, soft_aiming, use_rotation)

	local interaction_unit = blackboard.target_ally_unit
	blackboard.current_interaction_unit = interaction_unit
	local interaction_ext = ScriptUnit.extension(unit, "interactor_system")

	interaction_ext.set_exclusive_interaction_unit(interaction_ext, interaction_unit)

	blackboard.is_healing_other = true
	self._initializing = true

	return 
end
BTBotHealOtherAction.leave = function (self, unit, blackboard, t)
	local input_ext = ScriptUnit.extension(unit, "input_system")

	input_ext.set_aiming(input_ext, false)

	blackboard.current_interaction_unit = nil
	blackboard.is_healing_other = false
	local interaction_ext = ScriptUnit.extension(unit, "interactor_system")

	interaction_ext.set_exclusive_interaction_unit(interaction_ext, nil)

	return 
end
BTBotHealOtherAction.run = function (self, unit, blackboard, t, dt)
	local interaction_unit = blackboard.current_interaction_unit

	if not Unit.alive(interaction_unit) then
		return "failed"
	end

	local input_ext = ScriptUnit.extension(unit, "input_system")
	local action_data = self._tree_node.action_data
	local aim_position = nil

	if action_data then
		aim_position = Unit.world_position(interaction_unit, Unit.node(interaction_unit, action_data.aim_node))
	else
		aim_position = Unit.world_position(interaction_unit, 0)
	end

	input_ext.set_aim_position(input_ext, aim_position)

	if self._initializing then
		self._initializing = false

		return "running"
	end

	blackboard.input_extension:charge_shot()

	return "running"
end

return 
