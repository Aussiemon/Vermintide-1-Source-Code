require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTHesitateAction = class(BTHesitateAction, BTNode)
BTHesitateAction.init = function (self, ...)
	BTHesitateAction.super.init(self, ...)

	return 
end
BTHesitateAction.name = "BTHesitateAction"
local HESITATION_TIMER = 5

if script_data.ai_hesitation_debug then
	HESITATION_TIMER = 26
end

local HESITATION_PROXIMITY_SCALING = 4
local HESITATION_SCALING_MINIMUM_RANGE_SQ = 4
local BROADPHASE_QUERY_RADIUS = 10
local HESITATION_EXIT_LOWER_BOUND = 0.3
local HESITATION_EXIT_UPPER_BOUND = 1.4
local RE_RAYCAST_DOT = math.sin(math.pi/3)
local DO_DOT_CHECK_FOR_RE_RAYCAST = false
local WALL_ROTATION_FACTOR = 1
BTHesitateAction.enter = function (self, unit, blackboard, t)
	blackboard.navigation_extension:set_enabled(false)

	local ai_slot_system = Managers.state.entity:system("ai_slot_system")

	ai_slot_system.do_slot_search(ai_slot_system, unit, true)

	blackboard.hesitation = 0

	blackboard.locomotion_extension:use_lerp_rotation(true)
	LocomotionUtils.set_animation_driven_movement(unit, true, true, true)
	LocomotionUtils.set_animation_rotation_scale(unit, 1)
	Managers.state.network:anim_event(unit, "to_combat")
	self._select_new_hesitate_anim(self, unit, blackboard)

	blackboard.hesitate_wall = false
	blackboard.outnumber_multiplier = 1
	blackboard.outnumber_timer = t + 0.2 + Math.random()*0.2
	blackboard.hesitating = true
	blackboard.hesitate_timer = nil
	blackboard.do_wall_check = true

	if 0.5 < Math.random() then
		blackboard.oh_shit_proximity_panic_override = true
	else
		blackboard.oh_shit_proximity_panic_override = false
	end

	blackboard.active_node = self
	blackboard.move_state = "idle"
	blackboard.spawn_to_running = nil

	return 
end
BTHesitateAction.leave = function (self, unit, blackboard, t, reason)
	blackboard.locomotion_extension:use_lerp_rotation(true)
	LocomotionUtils.set_animation_driven_movement(unit, false)
	LocomotionUtils.set_animation_rotation_scale(unit, 1)
	blackboard.navigation_extension:set_enabled(true)

	blackboard.confirmed_player_sighting = true
	blackboard.do_wall_check = nil
	blackboard.hesitate_wall = nil
	blackboard.hesitate_wall_rotation = nil
	blackboard.hesitate_wall_position = nil
	blackboard.last_hesitate_anim = nil
	blackboard.active_node = nil
	blackboard.outnumber_multiplier = nil
	blackboard.outnumber_timer = nil
	blackboard.oh_shit_proximity_panic_override = false
	blackboard.hesitating = false
	blackboard.hesitate_finished = nil

	return 
end
local BROADPHASE_QUERY_RESULT = {}
BTHesitateAction.anim_cb_hesitate_finished = function (self, unit, blackboard)
	blackboard.hesitate_finished = true

	return 
end
BTHesitateAction.run = function (self, unit, blackboard, t, dt)
	local debug = script_data.ai_hesitation_debug
	local locomotion_extension = blackboard.locomotion_extension
	local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)
	local hesitate_wall_rotation = blackboard.hesitate_wall_rotation and blackboard.hesitate_wall_rotation:unbox()

	if hesitate_wall_rotation then
		rot = Quaternion.lerp(rot, hesitate_wall_rotation, WALL_ROTATION_FACTOR)
	end

	locomotion_extension.set_wanted_rotation(locomotion_extension, rot)

	local current_pos = POSITION_LOOKUP[unit]
	local pos = blackboard.hesitate_wall_position and blackboard.hesitate_wall_position:unbox()

	if pos and hesitate_wall_rotation then
		local diff = Vector3.flat(pos - current_pos)

		if 0.05 <= Vector3.dot(diff, Quaternion.forward(hesitate_wall_rotation)) then
			locomotion_extension.set_wanted_velocity_flat(locomotion_extension, diff*2)

			if debug then
				Debug.text("hesitate lerp wanted velocity: " .. tostring(diff*2))
			end
		else
			if debug then
				QuickDrawerStay:vector(pos, Quaternion.forward(hesitate_wall_rotation), Color(0, 255, 0))
				QuickDrawerStay:sphere(current_pos, 0.15, Color(0, 255, 0))
			end

			blackboard.hesitate_wall_position = nil

			LocomotionUtils.set_animation_driven_movement(unit, true, true, true)
		end
	end

	if blackboard.confirmed_player_sighting or blackboard.no_hesitation then
		if blackboard.hesitate_timer and blackboard.hesitate_timer < t then
			if debug then
				print("GO!")
			end

			return "done"
		elseif not blackboard.hesitate_timer then
			blackboard.hesitate_timer = t + math.lerp(HESITATION_EXIT_LOWER_BOUND, HESITATION_EXIT_UPPER_BOUND, Math.random())

			if debug then
				print("Timer: ", blackboard.hesitate_timer - t)
			end

			return "running"
		end
	end

	assert(Unit.alive(blackboard.target_unit), "Hesitating without target unit.")

	local target_pos = POSITION_LOOKUP[blackboard.target_unit]
	local target_dist_sq = Vector3.distance_squared(target_pos, current_pos)
	local hesitation_delta = HESITATION_PROXIMITY_SCALING/math.max(target_dist_sq - HESITATION_SCALING_MINIMUM_RANGE_SQ, 1)*dt + dt
	local outnumber_multiplier = nil

	if t < blackboard.outnumber_timer then
		blackboard.outnumber_timer = t + 0.2 + Math.random()*0.2
		local broadphase = blackboard.group_blackboard.broadphase

		table.clear(BROADPHASE_QUERY_RESULT)
		Broadphase.query(broadphase, current_pos, BROADPHASE_QUERY_RADIUS, BROADPHASE_QUERY_RESULT)

		local allies_nearby = 0

		for i = 1, #BROADPHASE_QUERY_RESULT, 1 do
			local bf_unit = BROADPHASE_QUERY_RESULT[i]
			local bb = ScriptUnit.extension(bf_unit, "ai_system"):blackboard()

			if bb.confirmed_player_sighting or bb.hesitating then
				allies_nearby = allies_nearby + 1
			end
		end

		local enemies_nearby = 0

		for i = 1, #PLAYER_AND_BOT_POSITIONS, 1 do
			local proximity = Vector3.distance(target_pos, current_pos)

			if proximity < 4 then
				blackboard.oh_shit_proximity_panic_override = true
			end

			local distance = Vector3.distance(target_pos, PLAYER_AND_BOT_POSITIONS[i])

			if distance < 10 then
				enemies_nearby = enemies_nearby + 1
			elseif distance < 15 then
				enemies_nearby = enemies_nearby + math.auto_lerp(10, 15, 1, 0, distance)^2
			end
		end

		if debug and enemies_nearby == 0 then
			print("NO ENEMIES NEARBY??", target_pos, blackboard.target_unit, POSITION_LOOKUP[blackboard.target_unit], blackboard.target_unit)
		end

		outnumber_multiplier = allies_nearby/math.max(enemies_nearby, 1)*1.25
		blackboard.outnumber_multiplier = outnumber_multiplier

		if enemies_nearby < allies_nearby then
			blackboard.oh_shit_proximity_panic_override = true
		end
	else
		outnumber_multiplier = blackboard.outnumber_multiplier
	end

	local hesitation = blackboard.hesitation + hesitation_delta*outnumber_multiplier

	if debug then
		Debug.text("outnumber " .. tostring(outnumber_multiplier) .. " " .. hesitation)
	end

	if HESITATION_TIMER < hesitation or blackboard.oh_shit_proximity_panic_override then
		local broadphase = blackboard.group_blackboard.broadphase

		AiUtils.alert_nearby_friends_of_enemy(unit, broadphase, blackboard.target_unit)

		return "done"
	else
		blackboard.hesitation = hesitation
		local nav_world = blackboard.nav_world
		local direction = -Quaternion.forward(rot)

		if blackboard.do_wall_check and not GwNavQueries.raycango(nav_world, current_pos, current_pos + direction*0.5) then
			local physics_world = World.get_data(blackboard.world, "physics_world")
			local raycast_pos = current_pos + Vector3(0, 0, 1)
			local distance = 1.5
			local result, hit_pos, hit_distance, normal = PhysicsWorld.immediate_raycast(physics_world, raycast_pos, direction, distance, "closest", "types", "statics", "collision_filter", "filter_ai_line_of_sight_check")
			blackboard.do_wall_check = false

			if debug then
				QuickDrawerStay:vector(raycast_pos, direction*distance, Color(255, 255, 0))
			end

			if result and (not DO_DOT_CHECK_FOR_RE_RAYCAST or Vector3.dot(normal, -direction) < RE_RAYCAST_DOT) then
				local result2, hit_pos2, hit_distance2, normal2 = PhysicsWorld.immediate_raycast(physics_world, raycast_pos, -normal, distance, "closest", "types", "statics", "collision_filter", "filter_ai_line_of_sight_check")

				if result2 then
					result = result2
					hit_pos = hit_pos2
					hit_distance = hit_distance2
					normal = normal2
				end

				if debug then
					QuickDrawerStay:vector(raycast_pos, -normal, Color(255, 0, 255))
				end
			end

			if result then
				if debug then
					QuickDrawerStay:sphere(hit_pos, 0.15, Color(255, 0, 0))
				end

				local network_manager = Managers.state.network

				network_manager.anim_event(network_manager, unit, "hesitate_wall")

				blackboard.hesitate_wall = true
				blackboard.hesitate_wall_rotation = QuaternionBox(Quaternion.look(Vector3.flat(normal), Vector3.up()))
				local OPTIMAL_DISTANCE = 1.2

				if hit_distance < OPTIMAL_DISTANCE then
					blackboard.hesitate_wall_position = Vector3Box(hit_pos + normal*OPTIMAL_DISTANCE)

					LocomotionUtils.set_animation_driven_movement(unit, false)

					if debug then
						QuickDrawerStay:sphere(blackboard.hesitate_wall_position:unbox(), 0.15, Color(255, 255, 255))
					end
				end
			elseif blackboard.last_hesitate_anim == "hesitate_bwd" then
				if debug then
					print("forcing no bwd hesitations")
				end

				self._select_new_hesitate_anim(self, unit, blackboard)
			end
		end

		if blackboard.hesitate_finished and not blackboard.hesitate_wall then
			self._select_new_hesitate_anim(self, unit, blackboard)

			blackboard.hesitate_finished = nil

			if debug then
				print("hesitation finished")
			end
		end

		return "running"
	end

	return 
end
BTHesitationVariations = {
	hesitate = {
		"hesitate"
	},
	hesitate_bwd = {
		"hesitate_bwd_2",
		"hesitate_bwd_3",
		"hesitate_bwd_4",
		"hesitate_bwd_5",
		"hesitate_bwd_6",
		"hesitate_bwd"
	}
}
BTHesitateAction._select_new_hesitate_anim = function (self, unit, blackboard)
	local anim = nil

	if not blackboard.do_wall_check then
		anim = "hesitate"
	elseif blackboard.last_hesitate_anim == "hesitate_bwd" then
		if 0.3333333333333333 < Math.random() then
			anim = "hesitate"
		else
			anim = "hesitate_bwd"
		end
	elseif 0.3333333333333333 < Math.random() then
		anim = "hesitate_bwd"
	else
		anim = "hesitate"
	end

	local variation_table = BTHesitationVariations[anim]

	Managers.state.network:anim_event(unit, variation_table[Math.random(1, #variation_table)])

	blackboard.last_hesitate_anim = anim

	return 
end

return 
