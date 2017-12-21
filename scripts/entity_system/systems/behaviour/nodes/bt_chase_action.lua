require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTChaseAction = class(BTChaseAction, BTNode)
BTChaseAction.init = function (self, ...)
	BTChaseAction.super.init(self, ...)

	return 
end
BTChaseAction.name = "BTChaseAction"
BTChaseAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action

	Managers.state.network:anim_event(unit, "to_combat")

	if blackboard.move_state ~= "moving" then
		self.start_moving(self, unit, blackboard, t)
	end

	blackboard.attack_cooldown = blackboard.attack_cooldown or t - 1
	blackboard.attacks_done = 0

	if blackboard.sneaky then
		blackboard.time_to_next_friend_alert = t + 99999
	else
		blackboard.time_to_next_friend_alert = t + 0.3
	end

	blackboard.attack_range = action.range
	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	Managers.state.network.network_transmit:send_rpc_all("rpc_enemy_has_target", unit_id, true)

	return 
end
BTChaseAction.leave = function (self, unit, blackboard, t)
	blackboard.running_attack_action = nil
	blackboard.attacks_done = 0
	blackboard.attack_cooldown = 0
	blackboard.move_state = nil

	if blackboard.start_anim_locked_time then
		LocomotionUtils.set_animation_driven_movement(unit, false)

		blackboard.start_anim_locked_time = nil
	end

	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_max_speed(navigation_extension, default_move_speed)

	return 
end
BTChaseAction.attack = function (self, unit, t, dt, blackboard, locomotion, action)
	if blackboard.move_state ~= "attacking" then
		blackboard.move_state = "attacking"

		Managers.state.network:anim_event(unit, action.attack_anim)

		blackboard.attack_cooldown = t + action.cooldown
		blackboard.anim_locked = t + action.attack_time
	end

	local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)

	locomotion.set_wanted_rotation(locomotion, rot)

	return 
end
BTChaseAction.run = function (self, unit, blackboard, t, dt)
	Profiler.start("BTChaseAction")

	if not Unit.alive(blackboard.target_unit) then
		Profiler.stop()

		return "done"
	end

	local action = blackboard.action
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	if blackboard.start_anim_locked_time then
		if t <= blackboard.start_anim_locked_time then
		else
			LocomotionUtils.set_animation_driven_movement(unit, false)

			blackboard.start_anim_locked_time = nil
		end
	end

	if t < blackboard.anim_locked then
		local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)

		locomotion.set_wanted_rotation(locomotion, rot)
	elseif blackboard.target_dist <= action.range and blackboard.slot_layer == 1 then
		self.attack(self, unit, t, dt, blackboard, locomotion, action)
	else
		self.follow(self, unit, t, dt, blackboard, locomotion, action)
	end

	Profiler.stop()

	return "running"
end
BTChaseAction.start_moving = function (self, unit, blackboard, t)
	local navigation_extension = blackboard.navigation_extension
	local destination = navigation_extension.destination(navigation_extension)
	local distance = Vector3.distance(POSITION_LOOKUP[unit], destination)

	if 0.5 < distance then
		local action = blackboard.action
		local start_anim, anim_locked = LocomotionUtils.get_start_anim(unit, blackboard, action.start_anims)

		if anim_locked then
			blackboard.start_anim_locked_time = 0.2

			LocomotionUtils.set_animation_driven_movement(unit, true)
		end

		Managers.state.network:anim_event(unit, start_anim or action.move_anim)
	end

	blackboard.anim_locked = blackboard.anim_locked or t

	return 
end
BTChaseAction.follow = function (self, unit, t, dt, blackboard, locomotion, action)
	LocomotionUtils.follow_slotted_target(unit, blackboard, t)

	local current_position = POSITION_LOOKUP[unit]
	local breed = blackboard.breed
	local navigation_extension = blackboard.navigation_extension
	local destination = navigation_extension.destination(navigation_extension)
	local distance = Vector3.distance(current_position, destination)
	local rot = nil

	if distance < 1 then
		navigation_extension.set_max_speed(navigation_extension, breed.walk_speed)
	elseif 2 < distance then
		navigation_extension.set_max_speed(navigation_extension, breed.run_speed)
	end

	if blackboard.move_state ~= "moving" and 0.5 < distance then
		blackboard.move_state = "moving"
		local start_anim, anim_driven = LocomotionUtils.get_start_anim(unit, blackboard, blackboard.action.start_anims)

		Managers.state.network:anim_event(unit, start_anim or action.move_anim)
	elseif blackboard.move_state == "moving" and distance < 0.2 then
		blackboard.move_state = "idle"
		local animation = "idle"

		if blackboard.slot_layer ~= nil and 1 < blackboard.slot_layer then
			animation = "shout"
		end

		Managers.state.network:anim_event(unit, animation)
	elseif blackboard.move_state == "idle" and distance < 0.2 then
		rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)
	end

	locomotion.set_wanted_rotation(locomotion, rot)

	if blackboard.time_to_next_friend_alert < t then
		blackboard.time_to_next_friend_alert = t + 0.5

		AiUtils.alert_nearby_friends_of_enemy(unit, blackboard.group_blackboard.broadphase, blackboard.target_unit, 2)
	end

	blackboard.attack_cooldown = t - 1

	return 
end

return 
