require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTTargetRageAction = class(BTTargetRageAction, BTNode)
BTTargetRageAction.init = function (self, ...)
	BTTargetRageAction.super.init(self, ...)

	return 
end
BTTargetRageAction.name = "BTTargetRageAction"
local POSITION_LOOKUP = POSITION_LOOKUP
BTTargetRageAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.active_node = self

	Managers.state.network:anim_event(unit, "to_combat")

	blackboard.anim_locked = t + action.rage_time
	blackboard.move_state = "attacking"
	local locomotion_extension = blackboard.locomotion_extension
	local rage_anim = AiAnimUtils.get_start_move_animation(unit, blackboard, action)
	local anim_driven = rage_anim ~= action.start_anims_name.fwd
	blackboard.attack_anim_driven = anim_driven

	locomotion_extension.use_lerp_rotation(locomotion_extension, not anim_driven)
	LocomotionUtils.set_animation_driven_movement(unit, anim_driven, false, false)

	if anim_driven then
		blackboard.move_animation_name = rage_anim
	else
		locomotion_extension.use_lerp_rotation(locomotion_extension, true)
		blackboard.navigation_extension:move_to(POSITION_LOOKUP[unit])

		if blackboard.target_dist < action.change_target_fwd_close_dist then
			rage_anim = AiAnimUtils.cycle_anims(blackboard, action.change_target_fwd_close_anims, "cycle_rage_anim_index")
		end
	end

	Managers.state.network:anim_event(unit, rage_anim)

	if script_data.debug_ai_movement then
		Debug.world_sticky_text(POSITION_LOOKUP[unit] + Vector3(0, 0, 1), rage_anim .. " " .. ((anim_driven and "(ANIM DRIVEN)") or ""), Color(140, 0, 220))
		QuickDrawerStay:vector(POSITION_LOOKUP[unit] + Vector3(0, 0, 1), Quaternion.forward(Unit.local_rotation(unit, 0))*3, Color(140, 0, 220))
	end

	if 7 < blackboard.target_dist then
		blackboard.chasing_timer = 25
	end

	return 
end
BTTargetRageAction.leave = function (self, unit, blackboard, t, reason)
	blackboard.action = nil
	blackboard.target_changed = nil

	blackboard.locomotion_extension:use_lerp_rotation(true)
	LocomotionUtils.set_animation_driven_movement(unit, false)

	return 
end
BTTargetRageAction.run = function (self, unit, blackboard, t, dt)
	if t < blackboard.anim_locked then
		if blackboard.attack_anim_driven then
			if blackboard.anim_cb_rotation_start then
				local rot_scale = AiAnimUtils.get_animation_rotation_scale(unit, blackboard, blackboard.action)

				LocomotionUtils.set_animation_rotation_scale(unit, rot_scale)

				blackboard.anim_cb_rotation_start = nil
			end
		else
			local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)

			blackboard.locomotion_extension:set_wanted_rotation(rot)
		end

		return "running"
	end

	return "done"
end
BTTargetRageAction.anim_cb_change_target_finished = function (self, unit, blackboard, action)
	blackboard.target_changed = nil

	return 
end

return 
