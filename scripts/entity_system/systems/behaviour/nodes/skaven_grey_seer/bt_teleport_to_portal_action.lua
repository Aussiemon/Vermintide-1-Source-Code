require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTTeleportToPortalAction = class(BTTeleportToPortalAction, BTNode)

BTTeleportToPortalAction.init = function (self, ...)
	BTTeleportToPortalAction.super.init(self, ...)
end

BTTeleportToPortalAction.name = "BTTeleportToPortalAction"

BTTeleportToPortalAction.enter = function (self, unit, blackboard, t)
	local unit_position = POSITION_LOOKUP[unit]
	local action_data = self._tree_node.action_data
	local entrance_pos, exit_pos = nil
	local id = action_data.level_portal_id
	local portal_data = blackboard.teleport_portals[id]
	blackboard.teleport_position = portal_data.position
end

BTTeleportToPortalAction.leave = function (self, unit, blackboard, t)
	local action_data = self._tree_node.action_data
	local id = action_data.level_portal_id
	blackboard.teleports_done[id] = true
	blackboard.teleport_position = nil
	local next_teleport_id = id + 1
	local next_teleport = "teleport_" .. next_teleport_id
	local next_teleport_action = BreedActions.skaven_grey_seer[next_teleport]

	if next_teleport_action then
		blackboard.next_auto_teleport_at = Managers.time:time("main") + next_teleport_action.time_until_auto_teleport
	end

	local reset_damage = action_data.reset_damage

	if reset_damage then
		local health_extension = ScriptUnit.extension(unit, "health_system")

		health_extension:reset()
	end

	local level_flow_event = action_data.level_flow_event

	if level_flow_event then
		Managers.state.conflict:level_flow_event(level_flow_event)
	end

	if blackboard.teleport_triggered_by == "time" then
		Unit.flow_event(unit, "lua_teleport_trigger_by_time")
	elseif blackboard.teleport_triggered_by == "damage" then
		Unit.flow_event(unit, "lua_teleport_trigger_by_damage")
	elseif blackboard.teleport_triggered_by == "distance" then
		Unit.flow_event(unit, "lua_teleport_trigger_by_distance")
	end

	blackboard.teleport_triggered_by = nil
end

BTTeleportToPortalAction.run = function (self, unit, blackboard, t, dt)
	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local teleport_position = blackboard.teleport_position:unbox()

	navigation_extension:set_navbot_position(teleport_position)
	locomotion_extension:teleport_to(teleport_position)
	locomotion_extension:set_wanted_velocity(Vector3.zero())

	return "done"
end

return
