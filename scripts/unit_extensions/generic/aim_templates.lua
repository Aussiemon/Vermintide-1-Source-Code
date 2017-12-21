AimTemplates = {}
local AIM_DIRECTION_MAX = 1.9999999
local HUSK_MIN_PITCH = -0.95
local HUSK_MAX_PITCH = 0.6
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

				GameSession.set_game_object_field(game, go_id, "aim_direction", aim_direction)
				GameSession.set_game_object_field(game, go_id, "aim_position", aim_position)
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
			data.interpolation_origin_position = Vector3Box()
			data.last_position = Vector3Box()
			data.interpolation_time = -math.huge

			return 
		end,
		update = function (unit, t, dt, data)
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

			local interpolation_duration = 0.5

			if best_player and not old_target then
				Unit.animation_event(unit, "lookat_on")
			elseif not best_player and old_target then
				Unit.animation_event(unit, "lookat_off")

				data.interpolation_time = -math.huge
			elseif best_player ~= old_target then
				data.interpolation_time = t + interpolation_duration

				data.interpolation_origin_position:store(data.last_position:unbox())
			end

			local interpolation_time = data.interpolation_time

			if best_player then
				local aim_target = nil

				if ScriptUnit.has_extension(best_player, "first_person_system") then
					aim_target = ScriptUnit.extension(best_player, "first_person_system"):current_position()
				else
					local head_index = Unit.node(best_player, "j_head")
					aim_target = Unit.world_position(best_player, head_index)

					QuickDrawer:sphere(aim_target, 0.32, Color(255, 0, 0))
				end

				if t < interpolation_time then
					local lerp_t = math.sin(((interpolation_time - t)/interpolation_duration - 1)*math.pi*0.5)
					local from = data.interpolation_origin_position:unbox()
					aim_target = Vector3.lerp(from, aim_target, lerp_t)
				end

				data.last_position:store(aim_target)
				Unit.animation_set_constraint_target(unit, data.constraint_target, aim_target)
			end

			data.current_target = best_player

			return 
		end
	}
}

return 
