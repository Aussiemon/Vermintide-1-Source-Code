require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTFollowAction = class(BTFollowAction, BTNode)
BTFollowAction.init = function (self, ...)
	BTFollowAction.super.init(self, ...)

	return 
end
BTFollowAction.name = "BTFollowAction"
BTFollowAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data

	Managers.state.network:anim_event(unit, "to_combat")

	local start_anim, anim_locked = LocomotionUtils.get_start_anim(unit, blackboard, action.start_anims)

	if anim_locked then
		blackboard.start_anim_locked_time = 0.2

		LocomotionUtils.set_animation_driven_movement(unit, true)
	else
		LocomotionUtils.set_animation_driven_movement(unit, false)
	end

	Managers.state.network:anim_event(unit, start_anim or action.move_anim)

	blackboard.anim_locked = blackboard.anim_locked or t

	blackboard.locomotion_extension:set_rotation_speed(10)

	blackboard.remembered_threat_pos = nil
	blackboard.chasing_timer = blackboard.unreachable_timer or 0

	if blackboard.fling_skaven_timer < t then
		blackboard.fling_skaven_timer = t + 0.5
	end

	local template_id = NetworkLookup.tutorials.elite_enemies
	local message_id = NetworkLookup.tutorials[blackboard.breed.name]

	Managers.state.network.network_transmit:send_rpc_all("rpc_tutorial_message", template_id, message_id)

	return 
end
BTFollowAction.leave = function (self, unit, blackboard, t)
	LocomotionUtils.set_animation_driven_movement(unit, false)

	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_max_speed(navigation_extension, default_move_speed)

	return 
end
BTFollowAction.run = function (self, unit, blackboard, t, dt)
	local locomotion = blackboard.locomotion_extension

	self.follow(self, unit, t, dt, blackboard, locomotion)

	blackboard.chasing_timer = blackboard.chasing_timer + dt

	return "running", "evaluate"
end
BTFollowAction._go_idle = function (self, unit, blackboard, locomotion)
	blackboard.move_state = "idle"

	Managers.state.network:anim_event(unit, "idle")

	local rot = LocomotionUtils.rotation_towards_unit(unit, blackboard.target_unit)

	locomotion.set_wanted_rotation(locomotion, rot)

	return 
end
local hit_units = {}
BTFollowAction.follow = function (self, unit, t, dt, blackboard, locomotion)
	local navigation_extension = blackboard.navigation_extension

	if 1 < navigation_extension.number_failed_move_attempts(navigation_extension) then
		blackboard.remembered_threat_pos = false

		if blackboard.move_state ~= "idle" then
			self._go_idle(self, unit, blackboard, locomotion)
		end
	end

	LocomotionUtils.follow_target_ogre(unit, blackboard, t, dt)

	local destination = navigation_extension.destination(navigation_extension)

	if blackboard.fling_skaven_timer < t then
		blackboard.fling_skaven_timer = t + 0.5

		self.check_fling_skaven(self, unit, blackboard, t)
	end

	local to_vec = destination - POSITION_LOOKUP[unit]

	Vector3.set_z(to_vec, 0)

	local distance = Vector3.length(to_vec)

	if distance < 1 then
		navigation_extension.set_max_speed(navigation_extension, blackboard.breed.walk_speed)
	elseif 2 < distance then
		navigation_extension.set_max_speed(navigation_extension, blackboard.breed.run_speed)
	end

	if navigation_extension.is_following_path(navigation_extension) and not blackboard.no_path_found and blackboard.move_state ~= "moving" and 0.5 < distance then
		blackboard.move_state = "moving"
		local action = self._tree_node.action_data
		local start_anim, anim_driven = LocomotionUtils.get_start_anim(unit, blackboard, action.start_anims)

		Managers.state.network:anim_event(unit, start_anim or action.move_anim)
	elseif blackboard.move_state ~= "idle" and distance < 0.2 then
		self._go_idle(self, unit, blackboard, locomotion)
	end

	if blackboard.target_outside_navmesh then
		local rot = LocomotionUtils.rotation_towards_unit(unit, blackboard.target_unit)

		locomotion.set_wanted_rotation(locomotion, rot)
	else
		locomotion.set_wanted_rotation(locomotion, nil)
	end

	return 
end
local broad_phase_fling_units = {}
BTFollowAction.check_fling_skaven = function (self, unit, blackboard, t)
	local forward = Quaternion.forward(Unit.local_rotation(unit, 0))
	local check_pos = POSITION_LOOKUP[unit] + forward*2.6
	local ai_system = Managers.state.entity:system("ai_system")
	local num_units = Broadphase.query(ai_system.broadphase, check_pos, 1, broad_phase_fling_units)

	if 0 < num_units then
		blackboard.fling_skaven = true
		blackboard.fling_skaven_timer = t + 5
	end

	return 
end
BTFollowAction.check_fling_skaven_expensive = function (self, unit, blackboard, t)
	local forward = Quaternion.forward(Unit.local_rotation(unit, 0))
	local check_pos = POSITION_LOOKUP[unit] + forward*2.6
	local radius = 1
	local pw = World.get_data(blackboard.world, "physics_world")

	PhysicsWorld.prepare_actors_for_overlap(pw, check_pos, radius)

	local hit_actors, num_hit_actors = PhysicsWorld.immediate_overlap(pw, "position", check_pos, "size", radius, "shape", "sphere", "types", "dynamics", "collision_filter", "filter_player_and_enemy_hit_box_check", "use_global_table")

	if 0 < num_hit_actors then
		local hit_units = hit_units

		table.clear(hit_units)

		hit_units[unit] = true

		for i = 1, num_hit_actors, 1 do
			local hit_actor = hit_actors[i]
			local hit_unit = Actor.unit(hit_actor)

			if hit_units[hit_unit] == nil then
				hit_units[hit_unit] = true
				local hit_unit_blackboard = Unit.get_data(hit_unit, "blackboard")
				local breed = hit_unit_blackboard and hit_unit_blackboard.breed

				if breed then
					blackboard.fling_skaven = true
				end
			end
		end
	end

	return 
end

return 
