require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTRatlingGunnerReloadAction = class(BTRatlingGunnerReloadAction, BTNode)
BTRatlingGunnerReloadAction.name = "BTRatlingGunnerReloadAction"
BTRatlingGunnerReloadAction.init = function (self, ...)
	BTRatlingGunnerReloadAction.super.init(self, ...)

	return 
end
BTRatlingGunnerReloadAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	local attack_pattern_data = blackboard.attack_pattern_data or {}
	attack_pattern_data.reload_timer = AiUtils.random(action.reload_time[1], action.reload_time[2])
	attack_pattern_data.constraint_target = attack_pattern_data.constraint_target or Unit.animation_find_constraint_target(unit, "aim_target")
	blackboard.attack_pattern_data = attack_pattern_data
	blackboard.action = action

	blackboard.navigation_extension:set_enabled(false)
	blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())
	AiUtils.anim_event(unit, attack_pattern_data, "reload_start")

	if script_data.ai_ratling_gunner_debug then
		AiUtils.temp_anim_event(unit, "reload_start")
	end

	return 
end
BTRatlingGunnerReloadAction.leave = function (self, unit, blackboard, t)
	local attack_pattern_data = blackboard.attack_pattern_data

	AiUtils.clear_anim_event(attack_pattern_data)
	AiUtils.clear_temp_anim_event(unit)

	blackboard.anim_cb_reload_start_finished = nil

	blackboard.navigation_extension:set_enabled(true)

	return 
end
BTRatlingGunnerReloadAction.run = function (self, unit, blackboard, t, dt)
	local attack_pattern_data = blackboard.attack_pattern_data

	if not attack_pattern_data.target_unit then
		return "done"
	end

	AiUtils.set_default_anim_constraint(unit, attack_pattern_data.constraint_target)

	attack_pattern_data.reload_timer = attack_pattern_data.reload_timer - dt
	local reload_start_finished = blackboard.anim_cb_reload_start_finished

	if not reload_start_finished then
		return "running"
	end

	AiUtils.anim_event(unit, attack_pattern_data, "reload_loop")

	if script_data.ai_ratling_gunner_debug then
		AiUtils.temp_anim_event(unit, "reload_loop", attack_pattern_data.reload_timer)
	end

	if attack_pattern_data.reload_timer < 0 then
		return "done"
	end

	return "running"
end

return 
