require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBotInteractAction = class(BTBotInteractAction, BTNode)

BTBotInteractAction.init = function (self, ...)
	BTBotInteractAction.super.init(self, ...)
end

BTBotInteractAction.name = "BTBotInteractAction"
local unit_alive = Unit.alive

BTBotInteractAction.enter = function (self, unit, blackboard, t)
	blackboard.interact = {
		tried = false
	}
	local input_ext = blackboard.input_extension
	local soft_aiming = true

	input_ext:set_aiming(true, soft_aiming)

	local interaction_unit = blackboard.interaction_unit
	blackboard.current_interaction_unit = interaction_unit
	local interaction_ext = blackboard.interaction_extension

	interaction_ext:set_exclusive_interaction_unit(interaction_unit)
end

BTBotInteractAction.leave = function (self, unit, blackboard, t)
	blackboard.interact = false
	local interaction_ext = blackboard.interaction_extension

	interaction_ext:set_exclusive_interaction_unit(nil)

	local input_ext = blackboard.input_extension

	input_ext:set_aiming(false)

	local interaction_unit = blackboard.current_interaction_unit

	if blackboard.step_back then
		if unit_alive(interaction_unit) then
			local rotation = Unit.local_rotation(interaction_unit, 0)
			local forward_vector_flat = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
			local wanted_position = POSITION_LOOKUP[unit] - forward_vector_flat * 1
			local nav_world = blackboard.nav_world
			local pos_on_nav_mesh, z = GwNavQueries.triangle_from_position(nav_world, wanted_position, 1, 1)

			if pos_on_nav_mesh then
				Vector3.set_z(wanted_position, z)

				local navigation_ext = blackboard.navigation_extension

				navigation_ext:move_to(wanted_position)
			end
		end

		blackboard.step_back = nil
	end

	blackboard.current_interaction_unit = nil
end

BTBotInteractAction.run = function (self, unit, blackboard, t, dt)
	local interaction_unit = blackboard.current_interaction_unit

	if not unit_alive(interaction_unit) or (interaction_unit ~= blackboard.interaction_unit and blackboard.interaction_unit) then
		return "failed"
	end

	local action_data = self._tree_node.action_data
	local status_ext = blackboard.status_extension
	local interaction_ext = blackboard.interaction_extension
	local input_ext = blackboard.input_extension
	local state = interaction_ext.state
	local bb = blackboard.interact
	local do_interaction = true

	if action_data and action_data.use_block_interaction then
		input_ext:defend()

		do_interaction = status_ext:is_blocking()
	end

	if do_interaction then
		if state == "waiting_to_interact" and not bb.tried then
			input_ext:interact()

			bb.tried = true
		elseif state == "waiting_to_interact" then
			bb.tried = false
		else
			input_ext:interact()
		end
	end

	local aim_position = nil

	if action_data and Unit.has_node(interaction_unit, action_data.aim_node) then
		aim_position = Unit.world_position(interaction_unit, Unit.node(interaction_unit, action_data.aim_node))
	else
		aim_position = Unit.world_position(interaction_unit, 0)
	end

	input_ext:set_aim_position(aim_position)

	return "running"
end

return
