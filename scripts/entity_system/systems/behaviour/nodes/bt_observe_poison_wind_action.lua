require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTObservePoisonWind = class(BTObservePoisonWind, BTNode)
BTObservePoisonWind.name = "BTObservePoisonWind"
BTObservePoisonWind.init = function (self, ...)
	BTObservePoisonWind.super.init(self, ...)

	return 
end
BTObservePoisonWind.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action

	blackboard.navigation_extension:set_enabled(false)
	blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())

	blackboard.explosion_impact = nil
	blackboard.observe_poison_wind = {}

	Managers.state.network:anim_event(unit, "attack_throw_look")

	return 
end
BTObservePoisonWind.leave = function (self, unit, blackboard, t)
	blackboard.observe_poison_wind = nil
	blackboard.action = nil

	blackboard.navigation_extension:set_enabled(true)

	return 
end
BTObservePoisonWind.run = function (self, unit, blackboard, t, dt)
	local throw_globe_data = blackboard.throw_globe_data

	if not throw_globe_data then
		return "done"
	end

	if blackboard.target_dist < 15 then
		return "done"
	end

	local last_throw_at = throw_globe_data.last_throw_at or -math.huge

	if last_throw_at + 5 < t then
		return "done"
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local throw_position = blackboard.throw_globe_data.throw_pos:unbox()
	local rotation = LocomotionUtils.look_at_position_flat(unit, throw_position)

	locomotion_extension.set_wanted_rotation(locomotion_extension, rotation)

	local poison_globe_impact = blackboard.explosion_impact

	if poison_globe_impact then
		Managers.state.network:anim_event(unit, "attack_throw_score")

		blackboard.observe_poison_wind.score_anim = true
		blackboard.explosion_impact = nil
	end

	if blackboard.observe_poison_wind.score_anim then
		local score_done = blackboard.anim_cb_attack_throw_score_finished

		if score_done then
			blackboard.anim_cb_attack_throw_score_finished = nil

			return "done"
		end
	end

	return "running"
end

return 
