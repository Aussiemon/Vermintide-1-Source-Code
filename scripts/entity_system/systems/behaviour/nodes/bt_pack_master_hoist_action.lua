require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTPackMasterHoistAction = class(BTPackMasterHoistAction, BTNode)
BTPackMasterHoistAction.name = "BTPackMasterHoistAction"
local position_lookup = POSITION_LOOKUP
BTPackMasterHoistAction.init = function (self, ...)
	BTPackMasterHoistAction.super.init(self, ...)

	return 
end
BTPackMasterHoistAction.enter = function (self, unit, blackboard, t)
	local nav_world = blackboard.nav_world
	local action = self._tree_node.action_data
	blackboard.hosting_end_time = t + action.hoist_anim_length

	StatusUtils.set_grabbed_by_pack_master_network("pack_master_hoisting", blackboard.drag_target_unit, true, unit)
	LocomotionUtils.set_animation_driven_movement(unit, true, false)
	blackboard.locomotion_extension:set_affected_by_gravity(false)
	AiUtils.show_polearm(unit, false)

	return 
end
BTPackMasterHoistAction.leave = function (self, unit, blackboard, t, reason)
	if reason == "done" then
		blackboard.needs_hook = true

		AiUtils.show_polearm(unit, false)
	else
		if Unit.alive(blackboard.drag_target_unit) then
			StatusUtils.set_grabbed_by_pack_master_network("pack_master_hoisting", blackboard.drag_target_unit, false, unit)
		end

		AiUtils.show_polearm(unit, true)

		blackboard.target_unit = nil
	end

	blackboard.drag_target_unit = nil
	blackboard.attack_cooldown = t + blackboard.action.cooldown

	LocomotionUtils.set_animation_driven_movement(unit, false, false)
	blackboard.locomotion_extension:set_movement_type("snap_to_navmesh")
	blackboard.locomotion_extension:set_affected_by_gravity(true)

	return 
end
BTPackMasterHoistAction.run = function (self, unit, blackboard, t, dt)
	if not AiUtils.is_of_interest_to_packmaster(unit, blackboard.drag_target_unit) then
		local status_extension = ScriptUnit.extension(blackboard.drag_target_unit, "status_system")

		if not status_extension.is_knocked_down(status_extension) then
			return "failed"
		end
	end

	if blackboard.hosting_end_time < t then
		StatusUtils.set_grabbed_by_pack_master_network("pack_master_hanging", blackboard.drag_target_unit, true, unit)

		return "done"
	end

	return "running"
end

return 
