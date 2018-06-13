require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTFollowAction = class(BTFollowAction, BTNode)

BTFollowAction.init = function (self, ...)
	BTFollowAction.super.init(self, ...)
end

BTFollowAction.name = "BTFollowAction"

BTFollowAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	local breed = blackboard.breed
	local network_manager = Managers.state.network

	network_manager:anim_event(unit, "to_combat")

	local start_anim, anim_locked = LocomotionUtils.get_start_anim(unit, blackboard, action.start_anims)

	if anim_locked then
		LocomotionUtils.set_animation_driven_movement(unit, true, false, false)
		blackboard.locomotion_extension:use_lerp_rotation(false)

		blackboard.follow_animation_locked = anim_locked
		blackboard.anim_cb_rotation_start = nil
		blackboard.move_animation_name = start_anim
		local rot_scale = AiAnimUtils.get_animation_rotation_scale(unit, blackboard, blackboard.action)

		LocomotionUtils.set_animation_rotation_scale(unit, rot_scale)

		blackboard.move_animation_name = nil
	else
		LocomotionUtils.set_animation_driven_movement(unit, false)
	end

	network_manager:anim_event(unit, start_anim or action.move_anim)
	blackboard.locomotion_extension:set_rotation_speed(10)

	blackboard.move_state = "moving"
	blackboard.remembered_threat_pos = nil
	blackboard.chasing_timer = blackboard.unreachable_timer or 0

	if blackboard.fling_skaven_timer and blackboard.fling_skaven_timer < t then
		blackboard.fling_skaven_timer = t + 0.5
	end

	local template_id = NetworkLookup.tutorials.elite_enemies
	local message_id = NetworkLookup.tutorials[breed.name]

	network_manager.network_transmit:send_rpc_all("rpc_tutorial_message", template_id, message_id)
	AiUtils.stormvermin_champion_hack_check_ward(unit, blackboard)
end

BTFollowAction.leave = function (self, unit, blackboard, t)
	LocomotionUtils.set_animation_driven_movement(unit, false)

	if blackboard.follow_animation_locked then
		blackboard.follow_animation_locked = nil

		blackboard.locomotion_extension:use_lerp_rotation(true)
	end

	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension:set_max_speed(default_move_speed)
end

BTFollowAction.run = function (self, unit, blackboard, t, dt)
	local locomotion_extension = blackboard.locomotion_extension

	self:follow(unit, t, dt, blackboard, locomotion_extension)

	blackboard.chasing_timer = blackboard.chasing_timer + dt

	return "running", "evaluate"
end

BTFollowAction._go_idle = function (self, unit, blackboard, locomotion)
	blackboard.move_state = "idle"

	Managers.state.network:anim_event(unit, "idle")

	local rot = LocomotionUtils.rotation_towards_unit(unit, blackboard.target_unit)

	locomotion:set_wanted_rotation(rot)

	if blackboard.follow_animation_locked then
		blackboard.follow_animation_locked = nil

		LocomotionUtils.set_animation_driven_movement(unit, false)
	end
end

BTFollowAction.follow = function (self, unit, t, dt, blackboard, locomotion)
	local navigation_extension = blackboard.navigation_extension

	if navigation_extension:number_failed_move_attempts() > 1 then
		blackboard.remembered_threat_pos = false

		if blackboard.move_state ~= "idle" then
			self:_go_idle(unit, blackboard, locomotion)
		end
	end

	LocomotionUtils.follow_target_ogre(unit, blackboard, t, dt)

	local destination = navigation_extension:destination()

	if blackboard.fling_skaven_timer and blackboard.fling_skaven_timer < t then
		blackboard.fling_skaven_timer = t + 0.5

		self:check_fling_skaven(unit, blackboard, t)
	end

	local to_vec = destination - POSITION_LOOKUP[unit]

	Vector3.set_z(to_vec, 0)

	local distance = Vector3.length(to_vec)

	if distance < 1 then
		navigation_extension:set_max_speed(blackboard.breed.walk_speed)
	elseif distance > 2 then
		navigation_extension:set_max_speed(blackboard.breed.run_speed)
	end

	if blackboard.follow_animation_locked and blackboard.anim_cb_rotation_start then
		blackboard.follow_animation_locked = nil

		LocomotionUtils.set_animation_driven_movement(unit, false)
		blackboard.locomotion_extension:use_lerp_rotation(true)
	elseif navigation_extension:is_following_path() and not blackboard.no_path_found and blackboard.move_state ~= "moving" and distance > 0.5 then
		blackboard.move_state = "moving"
		local action = blackboard.action
		local start_anim, anim_driven = LocomotionUtils.get_start_anim(unit, blackboard, action.start_anims)

		Managers.state.network:anim_event(unit, start_anim or action.move_anim)
	elseif blackboard.move_state ~= "idle" and distance < 0.2 then
		self:_go_idle(unit, blackboard, locomotion)
	end

	if blackboard.target_outside_navmesh then
		local rot = LocomotionUtils.rotation_towards_unit(unit, blackboard.target_unit)

		locomotion:set_wanted_rotation(rot)
	else
		locomotion:set_wanted_rotation(nil)
	end
end

local broad_phase_fling_units = {}

BTFollowAction.check_fling_skaven = function (self, unit, blackboard, t)
	local forward = Quaternion.forward(Unit.local_rotation(unit, 0))
	local check_pos = POSITION_LOOKUP[unit] + forward * 2.6
	local ai_system = Managers.state.entity:system("ai_system")
	local num_units = Broadphase.query(ai_system.broadphase, check_pos, 1, broad_phase_fling_units)

	if num_units > 0 then
		for i = 1, num_units, 1 do
			local hit_unit = broad_phase_fling_units[i]
			local hit_unit_bb = Unit.get_data(hit_unit, "blackboard")
			local hit_unit_breed = hit_unit_bb and hit_unit_bb.breed

			if hit_unit_breed and hit_unit_breed.flingable and AiUtils.unit_alive(hit_unit) then
				blackboard.fling_skaven = true
				blackboard.fling_skaven_timer = t + 5

				break
			end
		end
	end
end

local hit_units = {}

BTFollowAction.check_fling_skaven_expensive = function (self, unit, blackboard, t)
	local forward = Quaternion.forward(Unit.local_rotation(unit, 0))
	local check_pos = POSITION_LOOKUP[unit] + forward * 2.6
	local radius = 1
	local pw = World.get_data(blackboard.world, "physics_world")

	PhysicsWorld.prepare_actors_for_overlap(pw, check_pos, radius)

	local hit_actors, num_hit_actors = PhysicsWorld.immediate_overlap(pw, "position", check_pos, "size", radius, "shape", "sphere", "types", "dynamics", "collision_filter", "filter_player_and_enemy_hit_box_check", "use_global_table")

	if num_hit_actors > 0 then
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
end

return
