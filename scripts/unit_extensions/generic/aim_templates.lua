AimTemplates = {}
local AIM_DIRECTION_MAX = 1.9999999
local HUSK_MIN_PITCH = -0.95
local HUSK_MAX_PITCH = 0.6

local function look_at_target_unit(unit, data, dt, unit_position, target_unit, target_distance, head_constraint_target)
	local previously_used_head_constraint = data.is_using_head_constraint

	if not previously_used_head_constraint then
		data.is_using_head_constraint = true

		Unit.animation_event(unit, "look_at_on")
	end

	if not target_unit or not Unit.alive(target_unit) then
		AiUtils.set_default_anim_constraint(unit, head_constraint_target)

		return 
	end

	local look_target = nil
	local first_person_extension = ScriptUnit.has_extension(target_unit, "first_person_system")

	if first_person_extension ~= nil then
		look_target = first_person_extension.current_position(first_person_extension)
	else
		local head_index = Unit.node(target_unit, "j_head")
		look_target = Unit.world_position(target_unit, head_index)
	end

	local rotation = Unit.world_rotation(unit, 0)
	local rotation_forward = Vector3.flat(Quaternion.forward(rotation))
	local rotation_forward_normalized = Vector3.normalize(rotation_forward)
	local to_target = Vector3.flat(look_target - unit_position)
	local to_target_normalized = Vector3.normalize(to_target)
	local dot = Vector3.dot(to_target_normalized, rotation_forward_normalized)

	if dot < math.inverse_sqrt_2 then
		local old_z = look_target.z
		local rotation_right = Vector3.flat(Quaternion.right(rotation))

		if 0 < Vector3.cross(rotation_forward_normalized, to_target_normalized).z then
			look_target = unit_position + (rotation_forward - rotation_right)*target_distance
		else
			look_target = unit_position + (rotation_forward + rotation_right)*target_distance
		end

		look_target.z = old_z
	end

	if previously_used_head_constraint then
		local previous_look_target = data.previous_look_target:unbox()
		local lerp_t = math.min(dt*5, 1)
		look_target = Vector3.lerp(previous_look_target, look_target, lerp_t)
	end

	data.previous_look_target:store(look_target)
	Unit.animation_set_constraint_target(unit, head_constraint_target, look_target)

	return 
end

AimTemplates.player = {
	owner = {
		init = function (unit, data)
			data.packmaster_claw_aim_constraint = Unit.animation_find_constraint_target(unit, "packmaster_claw_target")
			data.aim_constraint_anim_var = Unit.animation_find_constraint_target(unit, "aim_constraint_target")
			data.look_direction_anim_var = Unit.animation_find_variable(unit, "aim_direction")
			data.aim_direction_pitch_var = Unit.animation_find_variable(unit, "aim_direction_pitch")
			data.locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
			data.status_extension = ScriptUnit.extension(unit, "status_system")

			return 
		end,
		update = function (unit, t, dt, data)
			local aim_direction = nil
			local unit_fwd = Quaternion.forward(Unit.local_rotation(unit, 0))

			if data.status_extension:is_grabbed_by_pack_master() then
				local packmaster_unit = data.status_extension:get_pack_master_grabber()
				local node = Unit.node(packmaster_unit, "j_claw_align")
				local node_position = Unit.world_position(packmaster_unit, node)

				Unit.animation_set_constraint_target(unit, data.packmaster_claw_aim_constraint, node_position)

				aim_direction = unit_fwd
			elseif data.status_extension:is_inspecting() then
				aim_direction = unit_fwd
			else
				local rotation = data.locomotion_extension:current_rotation()
				aim_direction = Quaternion.forward(rotation)
			end

			local block_anim_variable = PlayerUnitMovementSettings.block.aim_direction_pitch_function(aim_direction.z)

			Unit.animation_set_variable(unit, data.aim_direction_pitch_var, block_anim_variable)

			local aim_direction_scaled = aim_direction*3
			local aim_from_pos = Unit.world_position(unit, Unit.node(unit, "camera_attach"))
			local aim_target = aim_from_pos + aim_direction_scaled

			Unit.animation_set_constraint_target(unit, data.aim_constraint_anim_var, aim_target)

			local aim_dir_flat = Vector3.normalize(Vector3.flat(aim_direction))
			local fwd_flat = Vector3.normalize(Vector3.flat(unit_fwd))
			local aim_angle = math.atan2(aim_dir_flat.y, aim_dir_flat.x) - math.atan2(fwd_flat.y, fwd_flat.x)
			local aim_direction_scaled = -((aim_angle/math.pi + 1)%2 - 1)*2

			Unit.animation_set_variable(unit, data.look_direction_anim_var, math.clamp(aim_direction_scaled, -AIM_DIRECTION_MAX, AIM_DIRECTION_MAX))

			local game = Managers.state.network:game()
			local go_id = Managers.state.unit_storage:go_id(unit)

			if game and go_id then
				local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
				local aim_position = first_person_extension.current_position(first_person_extension)
				local network_aim_position = NetworkUtils.network_clamp_position(aim_position)

				GameSession.set_game_object_field(game, go_id, "aim_direction", aim_direction)
				GameSession.set_game_object_field(game, go_id, "aim_position", network_aim_position)
			end

			return 
		end
	},
	husk = {
		init = function (unit, data)
			data.aim_constraint_anim_var = Unit.animation_find_constraint_target(unit, "aim_constraint_target")
			data.look_direction_anim_var = Unit.animation_find_variable(unit, "aim_direction")
			data.aim_direction_pitch_var = Unit.animation_find_variable(unit, "aim_direction_pitch")
			data.packmaster_claw_aim_constraint = Unit.animation_find_constraint_target(unit, "packmaster_claw_target")
			data.camera_attach_node = Unit.node(unit, "camera_attach")
			data.status_extension = ScriptUnit.extension(unit, "status_system")

			return 
		end,
		update = function (unit, t, dt, data)
			local game = Managers.state.network:game()
			local go_id = Managers.state.unit_storage:go_id(unit)

			if not game or not go_id then
				return 
			end

			local aim_direction = GameSession.game_object_field(game, go_id, "aim_direction")
			local rotation = Quaternion.look(aim_direction)
			local yaw = Quaternion.yaw(rotation)
			local pitch = math.clamp(Quaternion.pitch(rotation), HUSK_MIN_PITCH, HUSK_MAX_PITCH)
			local yaw_rotation = Quaternion(Vector3.up(), yaw)
			local pitch_rotation = Quaternion(Vector3.right(), pitch)
			local look_rotation = Quaternion.multiply(yaw_rotation, pitch_rotation)
			aim_direction = Vector3.normalize(Quaternion.forward(look_rotation))
			local aim_direction_scaled = aim_direction*3
			local from_pos = Unit.world_position(unit, data.camera_attach_node)

			if script_data.lerp_debug or script_data.extrapolation_debug then
				local old_target = Matrix4x4.translation(Unit.animation_get_constraint_target(unit, data.aim_constraint_anim_var))
				local new_target = from_pos + aim_direction_scaled

				Unit.animation_set_constraint_target(unit, data.aim_constraint_anim_var, new_target)

				local anim_variable = PlayerUnitMovementSettings.block.aim_direction_pitch_function(Vector3.normalize(aim_direction_scaled).z)

				Unit.animation_set_variable(unit, Unit.animation_find_variable(unit, "aim_direction_pitch"), anim_variable)
			else
				Unit.animation_set_constraint_target(unit, data.aim_constraint_anim_var, from_pos + aim_direction_scaled)
			end

			local new_yaw = GameSession.game_object_field(game, go_id, "yaw")
			local new_pitch = GameSession.game_object_field(game, go_id, "pitch")
			local yaw_rotation = Quaternion(Vector3.up(), new_yaw)
			local pitch_rotation = Quaternion(Vector3.right(), new_pitch)
			local new_rot = Quaternion.multiply(yaw_rotation, pitch_rotation)
			local fwd_dir = Quaternion.forward(new_rot)

			Vector3.set_z(fwd_dir, 0)
			Vector3.set_z(aim_direction_scaled, 0)

			local fwd_flat = Vector3.normalize(fwd_dir)
			local aim_dir_flat = Vector3.normalize(aim_direction_scaled)
			local aim_angle = math.atan2(aim_dir_flat.y, aim_dir_flat.x) - math.atan2(fwd_flat.y, fwd_flat.x)
			local aim_direction_scaled = -((aim_angle/math.pi + 1)%2 - 1)*2

			Unit.animation_set_variable(unit, data.look_direction_anim_var, math.clamp(aim_direction_scaled, -AIM_DIRECTION_MAX, AIM_DIRECTION_MAX))

			if data.status_extension:is_grabbed_by_pack_master() then
				local packmaster_unit = data.status_extension:get_pack_master_grabber()
				local node = Unit.node(packmaster_unit, "j_righthand")
				local node_position = Unit.world_position(packmaster_unit, node)

				Unit.animation_set_constraint_target(unit, data.packmaster_claw_aim_constraint, node_position)
			end

			return 
		end
	}
}
AimTemplates.packmaster_claw = {
	owner = {
		init = function (unit, data)
			data.aim_constraint_anim_var = Unit.animation_find_constraint_target(unit, "aim_constraint_target")

			return 
		end,
		update = function (unit, t, dt, data)
			return 
		end
	}
}
AimTemplates.ratling_gunner = {
	owner = {
		init = function (unit, data)
			local blackboard = Unit.get_data(unit, "blackboard")
			data.blackboard = blackboard
			data.constraint_target = Unit.animation_find_constraint_target(unit, "aim_target")

			return 
		end,
		update = function (unit, t, dt, data)
			local unit_position = POSITION_LOOKUP[unit]
			local aim_target = nil
			local attack_pattern_data = data.blackboard.attack_pattern_data

			if attack_pattern_data and attack_pattern_data.shoot_direction_box then
				local shoot_direction = attack_pattern_data.shoot_direction_box:unbox()
				aim_target = unit_position + Vector3.normalize(shoot_direction)*5
			else
				local look_direction = Quaternion.forward(Unit.local_rotation(unit, 0))
				aim_target = unit_position + look_direction*5
			end

			Unit.animation_set_constraint_target(unit, data.constraint_target, aim_target)

			local game = Managers.state.network:game()
			local go_id = Managers.state.unit_storage:go_id(unit)

			if game and go_id then
				GameSession.set_game_object_field(game, go_id, "aim_target", aim_target)
			end

			return 
		end
	},
	husk = {
		init = function (unit, data)
			data.constraint_target = Unit.animation_find_constraint_target(unit, "aim_target")

			return 
		end,
		update = function (unit, t, dt, data)
			local game = Managers.state.network:game()
			local go_id = Managers.state.unit_storage:go_id(unit)

			if game and go_id then
				local aim_target = GameSession.game_object_field(game, go_id, "aim_target")

				Unit.animation_set_constraint_target(unit, data.constraint_target, aim_target)
			else
				local look_direction = Quaternion.forward(Unit.local_rotation(unit, 0))
				local aim_target = POSITION_LOOKUP[unit] + look_direction*5

				Unit.animation_set_constraint_target(unit, data.constraint_target, aim_target)
			end

			return 
		end
	}
}
AimTemplates.innkeeper = {
	owner = {
		init = function (unit, data)
			data.constraint_target = Unit.animation_find_constraint_target(unit, "lookat")
			data.current_target = nil
			data.previous_look_target = Vector3Box()

			return 
		end,
		update = function (unit, t, dt, data)
			local ignore_aim_constraint = Unit.get_data(unit, "ignore_aim_constraint")

			if ignore_aim_constraint then
				if data.is_using_head_constraint then
					Unit.animation_event(unit, "lookat_off")

					data.is_using_head_constraint = false
					data.current_target = nil
				end
			else
				local inn_keeper_position = Unit.local_position(unit, 0)
				local best_player = nil
				local best_dist_sq = 9
				local PLAYER_UNITS = PLAYER_UNITS
				local old_target = data.current_target
				local stickiness_multiplier = 0.9025

				for i = 1, #PLAYER_UNITS, 1 do
					local player_unit = PLAYER_UNITS[i]
					local dist_sq = Vector3.distance_squared(POSITION_LOOKUP[player_unit], inn_keeper_position)

					if player_unit == old_target then
						dist_sq = dist_sq*stickiness_multiplier
					end

					if dist_sq < best_dist_sq then
						best_dist_sq = dist_sq
						best_player = player_unit
					end
				end

				if best_player and not old_target then
					Unit.animation_event(unit, "lookat_on")

					data.is_using_head_constraint = true
				elseif not best_player and old_target then
					Unit.animation_event(unit, "lookat_off")

					data.is_using_head_constraint = false
				end

				if best_player then
					local target_distance = math.sqrt(best_dist_sq)

					look_at_target_unit(unit, data, dt, inn_keeper_position, best_player, target_distance, data.constraint_target)
				end

				data.current_target = best_player
			end

			return 
		end
	}
}

return 
