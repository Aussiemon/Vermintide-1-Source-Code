require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBotHealOtherAction = class(BTBotHealOtherAction, BTNode)

BTBotHealOtherAction.init = function (self, ...)
	BTBotHealOtherAction.super.init(self, ...)
end

BTBotHealOtherAction.name = "BTBotHealOtherAction"

BTBotHealOtherAction.enter = function (self, unit, blackboard, t)
	local input_ext = blackboard.input_extension
	local soft_aiming = true
	local use_rotation = false

	input_ext:set_aiming(true, soft_aiming, use_rotation)

	local interaction_unit = blackboard.target_ally_unit
	blackboard.current_interaction_unit = interaction_unit
	local interaction_ext = blackboard.interaction_extension

	interaction_ext:set_exclusive_interaction_unit(interaction_unit)

	blackboard.is_healing_other = true
	self._initializing = true
end

BTBotHealOtherAction.leave = function (self, unit, blackboard, t)
	local input_ext = blackboard.input_extension

	input_ext:set_aiming(false)

	blackboard.current_interaction_unit = nil
	blackboard.is_healing_other = false
	local interaction_ext = blackboard.interaction_extension

	interaction_ext:set_exclusive_interaction_unit(nil)
end

BTBotHealOtherAction.run = function (self, unit, blackboard, t, dt)
	local interaction_unit = blackboard.current_interaction_unit

	if not Unit.alive(interaction_unit) then
		return "failed"
	end

	local action_data = self._tree_node.action_data
	local aim_position = nil

	if action_data and Unit.has_node(interaction_unit, action_data.aim_node) then
		aim_position = Unit.world_position(interaction_unit, Unit.node(interaction_unit, action_data.aim_node))
	else
		aim_position = Unit.world_position(interaction_unit, 0)
	end

	local input_ext = blackboard.input_extension

	input_ext:set_aim_position(aim_position)

	if self._initializing then
		self._initializing = false
	else
		local input = action_data.input or "charge_shot"

		input_ext[input](input_ext)
	end

	return "running"
end

return
