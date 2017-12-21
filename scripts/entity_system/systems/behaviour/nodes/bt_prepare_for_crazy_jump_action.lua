require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTPrepareForCrazyJumpAction = class(BTPrepareForCrazyJumpAction, BTNode)
BTPrepareForCrazyJumpAction.name = "BTPrepareForCrazyJumpAction"
local position_lookup = POSITION_LOOKUP
local AiUtils = AiUtils
local unit_alive = Unit.alive
BTPrepareForCrazyJumpAction.init = function (self, ...)
	BTPrepareForCrazyJumpAction.super.init(self, ...)

	return 
end

local function debug3d(unit, text, color_name)
	if script_data.debug_ai_movement then
		Debug.world_sticky_text(position_lookup[unit], text, color_name)
	end

	return 
end

BTPrepareForCrazyJumpAction.enter = function (self, unit, blackboard, t)
	aiprint("ENTER BTPrepareForCrazyJumpAction")
	LocomotionUtils.set_animation_driven_movement(unit, false)

	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_combat")
	network_manager.anim_event(network_manager, unit, "move_fwd")

	blackboard.jump_data = {
		crouching = false,
		ready_crouch_time = false,
		segment_list = {}
	}
	blackboard.remembered_threat_pos = nil
	local template_id = NetworkLookup.tutorials.elite_enemies
	local message_id = NetworkLookup.tutorials[blackboard.breed.name]

	Managers.state.network.network_transmit:send_rpc_all("rpc_tutorial_message", template_id, message_id)

	return 
end
BTPrepareForCrazyJumpAction.leave = function (self, unit, blackboard, t, reason)
	aiprint("LEAVE BTPrepareForCrazyJumpAction")

	blackboard.jump_data.jump_at_target_outside_mesh = nil
	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_max_speed(navigation_extension, default_move_speed)

	if reason == "aborted" then
		blackboard.jump_data = nil
	end

	if reason ~= "done" then
		Managers.state.network:anim_event(unit, "to_upright")
	end

	return 
end
BTPrepareForCrazyJumpAction.run = function (self, unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local breed = blackboard.breed

	if breed.jump_range < blackboard.target_dist then
		return "failed"
	end

	local target_unit = blackboard.target_unit

	if unit_alive(target_unit) then
		local status_extension = ScriptUnit.extension(target_unit, "status_system")
		local is_pounced_by_other = status_extension.is_pounced_down(status_extension)

		if is_pounced_by_other then
			return "failed"
		end
	else
		return "failed"
	end

	if blackboard.move_closer_to_target then
		LocomotionUtils.follow_target(unit, blackboard, t, dt)
		locomotion.set_wanted_rotation(locomotion, nil)

		if blackboard.move_closer_to_target_timer < t then
			local data = blackboard.jump_data
			local in_los, velocity, time_of_flight = BTPrepareForCrazyJumpAction.ready_to_jump(unit, blackboard, data, false)

			if in_los then
				BTPrepareForCrazyJumpAction.start_crawling(unit, blackboard, t, data)

				blackboard.move_closer_to_target = false
			else
				if blackboard.target_dist < 2 and GwNavQueries.raycango(blackboard.nav_world, POSITION_LOOKUP[unit], POSITION_LOOKUP[target_unit]) then
					BTPrepareForCrazyJumpAction.start_crawling(unit, blackboard, t, data)

					blackboard.move_closer_to_target = false
				else
					return "failed"
				end

				blackboard.move_closer_to_target_timer = t + 1
			end
		end
	else
		local target_position = POSITION_LOOKUP[target_unit]
		local rot = LocomotionUtils.look_at_position_flat(unit, target_position)

		locomotion.set_wanted_rotation(locomotion, rot)

		local data = blackboard.jump_data

		if data.crouching then
			LocomotionUtils.follow_target(unit, blackboard, t, dt)

			if blackboard.target_outside_navmesh then
				if not data.jump_at_target_outside_mesh then
					local network_manager = Managers.state.network

					network_manager.anim_event(network_manager, unit, "idle")

					local navigation = ScriptUnit.extension(unit, "ai_navigation_system")

					navigation.move_to(navigation, position_lookup[unit])

					data.jump_at_target_outside_mesh = true
				end
			else
				locomotion.set_wanted_rotation(locomotion, nil)
			end

			if data.ready_crouch_time < t then
				local in_los, velocity, time_of_flight = BTPrepareForCrazyJumpAction.ready_to_jump(unit, blackboard, data, true)

				if in_los then
					return "done"
				end

				data.crouching = false
				blackboard.move_closer_to_target = true

				Managers.state.network:anim_event(unit, "to_upright")
				blackboard.navigation_extension:set_max_speed(blackboard.breed.run_speed)

				blackboard.move_closer_to_target_timer = t + 1
				blackboard.remembered_threat_pos = nil

				return "running"
			end
		else
			BTPrepareForCrazyJumpAction.start_crawling(unit, blackboard, t, data)
		end
	end

	return "running"
end
BTPrepareForCrazyJumpAction.start_crawling = function (unit, blackboard, t, data)
	blackboard.navigation_extension:set_max_speed(blackboard.breed.walk_speed)

	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_crouch")

	data.crouching = true
	data.ready_crouch_time = t + 0.5

	return 
end
BTPrepareForCrazyJumpAction.ready_to_jump = function (unit, blackboard, data, set_data)
	local enemy_spine_node = Unit.node(blackboard.target_unit, "j_neck")
	local p1 = position_lookup[unit]
	local p2 = Unit.world_position(blackboard.target_unit, enemy_spine_node) - Vector3(0, 0, 1)
	local move_forward = Vector3.normalize(p2 - p1)*0.3
	p1 = p1 + move_forward
	local total_distance = Vector3.distance(p1, p2)
	local in_los, velocity, time_of_flight = nil

	if total_distance < 2.5 then
		if LocomotionUtils.target_in_los(unit, blackboard) then
			local jump_speed = blackboard.breed.jump_speed
			velocity = BTPrepareForCrazyJumpAction.test_simple_jump(p2 - p1, jump_speed)

			if velocity then
				in_los = true
			end
		end
	else
		local wedge = Vector3(0, 0, 0.05)
		in_los, velocity, time_of_flight = BTPrepareForCrazyJumpAction.test_trajectory(blackboard, p1 + wedge, p2 + wedge, data.segment_list, true)
	end

	if in_los and set_data then
		data.enemy_spine_node = enemy_spine_node
		data.jump_target_pos = Vector3Box(p2)
		data.jump_velocity_boxed = Vector3Box(velocity)
		data.total_distance = total_distance
	end

	return in_los, velocity, time_of_flight
end
BTPrepareForCrazyJumpAction.test_trajectory = function (blackboard, p1, p2, segment_list, multiple_raycasts)
	local physics_world = World.get_data(blackboard.world, "physics_world")
	local gravity = blackboard.breed.jump_gravity
	local jump_angle = nil
	local jump_speed = blackboard.breed.jump_speed
	local wedge = Vector3(0, 0, 0.05)
	local acceptable_accuracy = 1
	local player_locomotion = ScriptUnit.extension(blackboard.target_unit, "locomotion_system")
	local target_velocity = player_locomotion.velocity_current:unbox()
	local to_target_dir = Vector3.normalize(p2 - p1)
	local dot = Vector3.dot(to_target_dir, Vector3(0, 0, 1))
	local high_arc = nil
	local height = p1.z - p2.z

	if dot < -0.5 and 2 < height and height < 6 then
		high_arc = true
		jump_speed = 5
	end

	if high_arc then
		jump_angle = WeaponHelper.angle_to_hit_moving_target(p1, p2, jump_speed, target_velocity, gravity, acceptable_accuracy, high_arc)
	else
		jump_angle = WeaponHelper.angle_to_hit_moving_target(p1, p2, jump_speed, target_velocity, gravity, acceptable_accuracy)
	end

	if not jump_angle and not jump_speed then
		return 
	end

	local in_los, velocity, time_of_flight = WeaponHelper.test_angled_trajectory(physics_world, p1 + wedge, p2 + wedge, -gravity, jump_speed, jump_angle, segment_list)

	if multiple_raycasts then
		if not in_los then
			return 
		end

		in_los = WeaponHelper.ray_segmented_test(physics_world, segment_list, Vector3(0, 0, 1.6))

		if not in_los then
			return 
		end

		local right = Vector3.cross(Vector3.normalize(p2 - p1), Vector3.up())*0.4
		in_los = WeaponHelper.ray_segmented_test(physics_world, segment_list, Vector3(0, 0, 0.7) + right)

		if not in_los then
			return 
		end

		in_los = WeaponHelper.ray_segmented_test(physics_world, segment_list, Vector3(0, 0, 0.7) - right)

		if not in_los then
			return 
		end
	end

	return in_los, velocity, time_of_flight
end
BTPrepareForCrazyJumpAction.test_simple_jump = function (to_target, jump_speed)
	local angle = WeaponHelper:wanted_projectile_angle(to_target, 9.82, jump_speed)

	if angle then
		Vector3.set_z(to_target, 0)

		local to_vec_flat = Vector3.normalize(to_target)
		local velocity = Quaternion.rotate(Quaternion.axis_angle(Vector3.cross(to_vec_flat, Vector3.up()), angle), to_vec_flat)*jump_speed

		return velocity
	end

	return 
end

return 