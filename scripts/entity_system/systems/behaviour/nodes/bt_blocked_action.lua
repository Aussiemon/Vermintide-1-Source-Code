require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBlockedAction = class(BTBlockedAction, BTNode)
BTBlockedAction.name = "BTBlockedAction"
BTBlockedAction.init = function (self, ...)
	BTBlockedAction.super.init(self, ...)

	return 
end
BTBlockedAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, false)

	blackboard.blocked = {
		id = blackboard.blocked
	}
	local anim_table = action.blocked_anims
	local block_anim = anim_table[Math.random(1, #anim_table)]

	Managers.state.network:anim_event(unit, "to_combat")
	Managers.state.network:anim_event(unit, block_anim)
	LocomotionUtils.set_animation_driven_movement(unit, true, true)

	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.set_rotation_speed(locomotion, 100)
	locomotion.set_wanted_velocity(locomotion, Vector3(0, 0, 0))
	locomotion.set_affected_by_gravity(locomotion, true)
	locomotion.set_movement_type(locomotion, "constrained_by_mover")

	blackboard.spawn_to_running = nil

	return 
end
BTBlockedAction.leave = function (self, unit, blackboard, t, dt, new_action)
	blackboard.blocked = nil

	LocomotionUtils.set_animation_driven_movement(unit, false)

	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion.set_rotation_speed(locomotion, 10)
	locomotion.set_wanted_rotation(locomotion, nil)
	locomotion.set_affected_by_gravity(locomotion, false)
	locomotion.set_movement_type(locomotion, "snap_to_navmesh")

	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, true)

	return 
end
BTBlockedAction.run = function (self, unit, blackboard, t, dt)
	return "running"
end

return 
