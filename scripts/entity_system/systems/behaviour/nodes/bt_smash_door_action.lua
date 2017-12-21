require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTSmashDoorAction = class(BTSmashDoorAction, BTNode)
BTSmashDoorAction.StateInit = class(BTSmashDoorAction.StateInit)
BTSmashDoorAction.StateMovingToSmartObjectEntrance = class(BTSmashDoorAction.StateMovingToSmartObjectEntrance)
BTSmashDoorAction.StateAttacking = class(BTSmashDoorAction.StateAttacking)
BTSmashDoorAction.StateOpening = class(BTSmashDoorAction.StateOpening)
BTSmashDoorAction.StateMovingToSmartObjectExit = class(BTSmashDoorAction.StateMovingToSmartObjectExit)
BTSmashDoorAction.StateExitingSmartObject = class(BTSmashDoorAction.StateExitingSmartObject)
BTSmashDoorAction.init = function (self, ...)
	BTSmashDoorAction.super.init(self, ...)

	return 
end
BTSmashDoorAction.name = "BTSmashDoorAction"
BTSmashDoorAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	local smart_object = blackboard.next_smart_object_data
	local target_unit = smart_object.smart_object_data.unit
	blackboard.action = action
	blackboard.is_smashing_door = nil
	blackboard.is_opening_door = nil
	blackboard.active_node = BTSmashDoorAction
	blackboard.attacks_done = 0
	blackboard.attack_finished = false
	blackboard.attack_aborted = false
	blackboard.smash_door = blackboard.smash_door or {}
	blackboard.smash_door.done = false
	blackboard.smash_door.frames_to_done = nil
	blackboard.smash_door.failed = false
	blackboard.smash_door.target_unit = target_unit
	local params = {
		unit = unit,
		blackboard = blackboard,
		action = action,
		entrance_pos = smart_object.entrance_pos,
		exit_pos = smart_object.exit_pos,
		exit_lookat_direction = Vector3Box(Vector3.normalize(Vector3.flat(smart_object.exit_pos:unbox() - smart_object.entrance_pos:unbox())))
	}
	blackboard.smash_door.state_machine = StateMachine:new(self, BTSmashDoorAction.StateInit, params)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_affected_by_gravity(locomotion_extension, false)
	locomotion_extension.set_movement_type(locomotion_extension, "snap_to_navmesh")
	locomotion_extension.set_rotation_speed(locomotion_extension, 10)

	return 
end
BTSmashDoorAction.leave = function (self, unit, blackboard, t)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_affected_by_gravity(locomotion_extension, true)
	locomotion_extension.set_movement_type(locomotion_extension, "snap_to_navmesh")

	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	navigation_extension.set_enabled(navigation_extension, true)

	if navigation_extension.is_using_smart_object(navigation_extension) then
		local success = navigation_extension.use_smart_object(navigation_extension, false)

		if not success then
			local target_unit = blackboard.smash_door.target_unit
			local door_extension = ScriptUnit.extension(target_unit, "door_system")

			door_extension.register_breed_failed_leaving_smart_object(door_extension, unit)
		end
	end

	blackboard.action = nil
	blackboard.is_smart_objecting = nil
	blackboard.is_smashing_door = nil
	blackboard.is_opening_door = nil
	blackboard.smash_door.target_unit = nil

	return 
end
BTSmashDoorAction.run = function (self, unit, blackboard, t, dt)
	if not Unit.alive(blackboard.smash_door.target_unit) then
		return "failed"
	end

	if blackboard.attack_aborted then
		return "failed"
	end

	if blackboard.stunned then
		return "failed"
	end

	if blackboard.smash_door.failed then
		return "failed"
	end

	if blackboard.smash_door.done then
		local frames_to_done = blackboard.smash_door.frames_to_done or 2

		if frames_to_done == 0 then
			return "done"
		end

		blackboard.smash_door.frames_to_done = frames_to_done - 1
	end

	blackboard.smash_door.state_machine:update(dt, t)

	return "running"
end
BTSmashDoorAction.StateInit.on_enter = function (self, params)
	self.blackboard = params.blackboard
	self.unit = params.unit
	self.entrance_pos = params.entrance_pos

	return 
end
BTSmashDoorAction.StateInit.update = function (self, dt, t)
	local unit = self.unit
	local blackboard = self.blackboard
	local unit_position = POSITION_LOOKUP[unit]
	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	if Vector3.distance(self.entrance_pos:unbox(), unit_position) < 1 then
		locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3(0, 0, 0))
		navigation_extension.set_enabled(navigation_extension, false)

		if navigation_extension.use_smart_object(navigation_extension, true) then
			blackboard.is_smart_objecting = true
			blackboard.is_smashing_door = true

			return BTSmashDoorAction.StateMovingToSmartObjectEntrance
		else
			print("BTSmashDoorAction - failing to use smart object")

			blackboard.smash_door.failed = true
		end
	end

	return 
end
BTSmashDoorAction.StateMovingToSmartObjectEntrance.on_enter = function (self, params)
	self.blackboard = params.blackboard
	self.unit = params.unit
	self.target_unit = params.blackboard.smash_door.target_unit
	self.entrance_pos = params.entrance_pos
	self.exit_lookat_direction = params.exit_lookat_direction

	Managers.state.network:anim_event(params.unit, params.action.move_anim)

	return 
end
BTSmashDoorAction.StateMovingToSmartObjectEntrance.update = function (self, dt, t)
	local unit = self.unit
	local blackboard = self.blackboard
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local unit_position = POSITION_LOOKUP[unit]
	local entrance_pos = self.entrance_pos:unbox()
	local vector_to_target = entrance_pos - unit_position
	local distance_to_target = Vector3.length(vector_to_target)

	if (blackboard.action.door_attack_distance or 0.1) < distance_to_target then
		local look_direction_wanted = self.exit_lookat_direction:unbox()
		local direction_to_target = Vector3.normalize(vector_to_target)

		locomotion_extension.set_wanted_velocity(locomotion_extension, direction_to_target*blackboard.breed.walk_speed)
		locomotion_extension.set_wanted_rotation(locomotion_extension, Quaternion.look(look_direction_wanted))
	else
		local preferred_door_action = blackboard.preferred_door_action

		if preferred_door_action and preferred_door_action == "open" then
			local target_unit = self.target_unit
			local door_extension = ScriptUnit.extension(target_unit, "door_system")

			if door_extension.num_attackers == 0 then
				return BTSmashDoorAction.StateOpening
			end
		end

		return BTSmashDoorAction.StateAttacking
	end

	return 
end
BTSmashDoorAction.StateOpening.on_enter = function (self, params)
	local blackboard = params.blackboard
	local unit = params.unit
	local action = params.action
	local target_unit = blackboard.smash_door.target_unit
	self.blackboard = blackboard
	self.unit = unit
	self.action = action
	self.target_unit = target_unit
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3.zero())

	local rotation = LocomotionUtils.rotation_towards_unit(unit, target_unit)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_wanted_rotation(locomotion_extension, rotation)

	local door_extension = ScriptUnit.extension(target_unit, "door_system")

	door_extension.interacted_with(door_extension, unit)

	blackboard.is_opening_door = true

	return 
end
BTSmashDoorAction.StateOpening.update = function (self, dt, t)
	local blackboard = self.blackboard
	local target_unit = self.target_unit
	local health_extension = ScriptUnit.extension(target_unit, "health_system")

	if not health_extension.is_alive(health_extension) then
		return BTSmashDoorAction.StateMovingToSmartObjectExit
	end

	local door_extension = ScriptUnit.extension(target_unit, "door_system")

	if not door_extension.is_opening(door_extension) then
		return BTSmashDoorAction.StateMovingToSmartObjectExit
	end

	return 
end
BTSmashDoorAction.StateAttacking.on_enter = function (self, params)
	local target_unit = params.blackboard.smash_door.target_unit
	self.blackboard = params.blackboard
	self.unit = params.unit
	self.action = params.action
	self.target_unit = target_unit
	local locomotion_extension = ScriptUnit.extension(params.unit, "locomotion_system")

	locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3.zero())

	local door_extension = ScriptUnit.extension(target_unit, "door_system")
	door_extension.num_attackers = door_extension.num_attackers + 1

	Managers.state.network:anim_event(params.unit, "to_combat")
	self.attack(self)

	return 
end
BTSmashDoorAction.StateAttacking.update = function (self, dt, t)
	local blackboard = self.blackboard
	local target_unit = self.target_unit
	local health_extension = ScriptUnit.extension(target_unit, "health_system")

	if not health_extension.is_alive(health_extension) then
		return BTSmashDoorAction.StateMovingToSmartObjectExit
	end

	if blackboard.attack_finished then
		self.attack(self)
	end

	return 
end
BTSmashDoorAction.StateAttacking.on_exit = function (self)
	local target_unit = self.target_unit
	local door_extension = ScriptUnit.extension(target_unit, "door_system")
	door_extension.num_attackers = door_extension.num_attackers - 1

	return 
end
BTSmashDoorAction.StateAttacking.attack = function (self)
	local target_unit = self.target_unit
	local unit = self.unit
	local blackboard = self.blackboard
	local action = self.action
	local rotation = LocomotionUtils.rotation_towards_unit(unit, target_unit)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_wanted_rotation(locomotion_extension, rotation)
	Managers.state.network:anim_event(unit, action.attack_anim)

	blackboard.attack_finished = false

	return 
end
BTSmashDoorAction.StateMovingToSmartObjectExit.on_enter = function (self, params)
	self.blackboard = params.blackboard
	self.unit = params.unit
	self.exit_pos = params.exit_pos
	self.exit_lookat_direction = params.exit_lookat_direction

	Managers.state.network:anim_event(params.unit, params.action.move_anim)

	return 
end
BTSmashDoorAction.StateMovingToSmartObjectExit.update = function (self, dt, t)
	local unit = self.unit
	local blackboard = self.blackboard
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local unit_position = POSITION_LOOKUP[unit]
	local exit_pos = self.exit_pos:unbox()
	local vector_to_target = exit_pos - unit_position

	Vector3.set_z(vector_to_target, 0)

	local distance_to_target = Vector3.length(vector_to_target)

	if 0.1 < distance_to_target then
		local look_direction_wanted = self.exit_lookat_direction:unbox()
		local direction_to_target = Vector3.normalize(vector_to_target)

		locomotion_extension.set_wanted_velocity(locomotion_extension, direction_to_target*blackboard.breed.walk_speed)
		locomotion_extension.set_wanted_rotation(locomotion_extension, Quaternion.look(look_direction_wanted))
	else
		blackboard.smash_door.done = true
	end

	return 
end
BTSmashDoorAction.anim_cb_ratogre_slam = function (self, unit, blackboard)
	local action = blackboard.action

	AiUtils.damage_target(blackboard.smash_door.target_unit, unit, action, action.damage)

	return 
end
BTSmashDoorAction.anim_cb_damage = function (self, unit, blackboard)
	if blackboard.smash_door.target_unit then
		local action = blackboard.action

		AiUtils.damage_target(blackboard.smash_door.target_unit, unit, action, action.damage)
	end

	return 
end

return 