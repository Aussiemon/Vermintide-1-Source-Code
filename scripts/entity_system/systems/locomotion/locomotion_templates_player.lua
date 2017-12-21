LocomotionTemplates = LocomotionTemplates or {}
local LocomotionTemplates = LocomotionTemplates
local LEVEL_EDITOR_TEST = LEVEL_EDITOR_TEST
local detailed_profiler_start, detailed_profiler_stop = nil
local DETAILED_PROFILING = true

if DETAILED_PROFILING then
	detailed_profiler_start = Profiler.start
	detailed_profiler_start = Profiler.stop
else
	function detailed_profiler_start()
		return 
	end

	function detailed_profiler_stop()
		return 
	end
end

local UPDATE_STATISTICS = false
LocomotionTemplates.PlayerUnitLocomotionExtension = {}
local T = LocomotionTemplates.PlayerUnitLocomotionExtension
T.init = function (data, nav_world)
	data.nav_world = nav_world
	data.all_update_units = {}
	data.all_disabled_units = {}

	if UPDATE_STATISTICS then
		self.drawer = Managers.state.debug:drawer({
			mode = "immediate",
			name = "PlayerUnitLocomotionExtension"
		})

		GraphHelper.create("PlayerUnitLocomotionExtension", {
			"move_speed"
		}, {
			"move_velocity"
		})
		GraphHelper.set_range("PlayerUnitLocomotionExtension", -10, 10)
		GraphHelper.hide("PlayerUnitLocomotionExtension")
	end

	return 
end
T.update = function (data, t, dt)
	Profiler.start("player_locomotion_update")
	T.update_movement(data, t, dt)
	T.update_rotation(data, t, dt)
	T.update_network(data, dt)
	T.update_average_velocity(data, t, dt)
	T.update_disabled_units(data, dt)

	if GameSettingsDevelopment.use_telemetry then
		T.update_player_position_telemetry(data, t)
	end

	if UPDATE_STATISTICS then
		T.update_statistics(data, t, dt)
	end

	if script_data.debug_first_person_player_animations ~= nil or script_data.debug_player_animations ~= nil then
		T.update_debug_anims(data)
	end

	Profiler.stop("player_locomotion_update")

	return 
end
T.update_average_velocity = function (data, t, dt)
	Profiler.start("update_average_velocity")

	local all_update_units = data.all_update_units
	local SAMPLE_UPDATE_RATE = 0.125
	local unit, extension = next(all_update_units, data.last_average_velocity_unit)

	if not unit then
		unit, extension = next(all_update_units)
	end

	if unit then
		local last_sample = extension._sample_velocity_time
		local index = extension._sample_velocity_index
		local velocities = extension._sample_velocities
		local num_velocities = #velocities
		local changed = nil

		while SAMPLE_UPDATE_RATE < t - last_sample do
			last_sample = last_sample + SAMPLE_UPDATE_RATE
			index = index%num_velocities + 1

			velocities[index]:store(extension.velocity_current:unbox())

			changed = true
		end

		if changed then
			extension._sample_velocity_index = index
			extension._sample_velocity_time = last_sample
			local total_velocity = Vector3(0, 0, 0)

			for k, velocity in ipairs(velocities) do
				total_velocity = total_velocity + velocity.unbox(velocity)
			end

			extension._average_velocity:store(total_velocity/num_velocities)
		end

		Profiler.stop("update_average_velocity")
	end

	data.last_average_velocity_unit = unit

	if script_data.debug_player_velocity then
		for unit, extension in pairs(all_update_units) do
			Debug.text("Player average speed: %s", Vector3.length(extension._average_velocity:unbox()))
			Debug.text("Player current speed: %s", Vector3.length(extension.velocity_current:unbox()))
		end
	end

	if script_data.debug_player_position then
		for unit, extension in pairs(all_update_units) do
			Debug.text("Player position: %s", tostring(Unit.local_position(unit, 0)))
		end
	end

	return 
end
local MAX_TIME_SINCE_LAST_DOWN_COLLIDE = 0.2
T.update_movement = function (data, t, dt)
	Profiler.start("update movement")

	for unit, extension in pairs(data.all_update_units) do
		extension.IS_NEW_FRAME = false

		if CharacterStateHelper.is_colliding_down(unit) then
			extension.time_since_last_down_collide = 0
			extension.collides_down = true
		else
			extension.time_since_last_down_collide = extension.time_since_last_down_collide + dt
			extension.collides_down = extension.time_since_last_down_collide < MAX_TIME_SINCE_LAST_DOWN_COLLIDE and extension.collides_down
		end

		local state = extension.state

		if state ~= "script_driven" then
			extension.external_velocity = nil
		end

		if state == "script_driven" then
			local calculate_fall_velocity = true

			extension.update_script_driven_movement(extension, unit, dt, t, calculate_fall_velocity)
		elseif state == "animation_driven" then
			extension.update_animation_driven_movement(extension, unit, dt, t)
		elseif state == "animation_driven_with_rotation_no_mover" then
			extension.update_animation_driven_movement_with_rotation_no_mover(extension, unit, dt, t)
		elseif state == "linked_movement" then
			extension.update_linked_movement(extension, unit, dt, t)
		elseif state == "script_driven_ladder" then
			local calculate_fall_velocity = false

			extension.update_script_driven_movement(extension, unit, dt, t, calculate_fall_velocity)
		elseif state == "script_driven_ladder_transition_movement" then
			extension.update_script_driven_ladder_transition_movement(extension, unit, dt, t)
		elseif state == "script_driven_no_mover" then
			extension.update_script_driven_no_mover_movement(extension, unit, dt, t)
		end
	end

	Profiler.stop("update movement")

	return 
end
T.update_network = function (data, dt)
	Profiler.start("network")

	local game = Managers.state.network:game()

	if not game or LEVEL_EDITOR_TEST then
		return 
	end

	local MAX_MOVE_SPEED = 99.9999
	local position_constant = NetworkConstants.position
	local min = position_constant.min
	local max = position_constant.max
	local min_vel = NetworkConstants.velocity.min
	local max_vel = NetworkConstants.velocity.max
	local Unit_local_rotation = Unit.local_rotation
	local GameSession_set_game_object_field = GameSession.set_game_object_field
	local Unit_local_position = Unit.local_position

	for unit, extension in pairs(data.all_update_units) do
		local go_id = Managers.state.unit_storage:go_id(unit)
		local current_rotation = Unit_local_rotation(unit, 0)
		local yaw = Quaternion.yaw(current_rotation)
		local pitch = Quaternion.pitch(current_rotation)

		GameSession_set_game_object_field(game, go_id, "yaw", yaw)
		GameSession_set_game_object_field(game, go_id, "pitch", pitch)

		local position = Unit_local_position(unit, 0)
		local velocity = extension.velocity_network:unbox()

		if extension._platform_unit then
			local platform_pos = Unit.local_position(extension._platform_unit, 0)
			position = position - platform_pos
			velocity = velocity + extension._platform_extension:movement_delta()/dt
		end

		GameSession_set_game_object_field(game, go_id, "position", Vector3.clamp(position, min, max))
		Unit.animation_set_variable(unit, extension.move_speed_anim_var, math.min(Vector3.length(extension.velocity_current:unbox()), MAX_MOVE_SPEED))
		GameSession_set_game_object_field(game, go_id, "velocity", Vector3.clamp(velocity, min_vel, max_vel))
		GameSession_set_game_object_field(game, go_id, "average_velocity", Vector3.clamp(extension._average_velocity:unbox(), min_vel, max_vel))
	end

	Profiler.stop("network")

	return 
end
T.update_statistics = function (data, t, dt)
	Profiler.start("statistics")

	for unit, extension in pairs(data.all_update_units) do
		GraphHelper.record_statistics("move_velocity", extension.velocity_current:unbox())
		GraphHelper.record_statistics("move_speed", Vector3.length(extension.velocity_current:unbox()))
	end

	Profiler.stop("statistics")

	return 
end
T.update_rotation = function (data, t, dt)
	Profiler.start("rotation")

	local is_server = Managers.player.is_server
	local Unit_set_local_rotation = Unit.set_local_rotation
	local Quaternion_lerp = Quaternion.lerp
	local Quaternion_look = Quaternion.look
	local Quaternion_forward = Quaternion.forward
	local math_smoothstep = math.smoothstep
	local Vector3_normalize = Vector3.normalize
	local Vector3_flat = Vector3.flat
	local Vector3_dot = Vector3.dot

	for unit, extension in pairs(data.all_update_units) do
		if not extension.disable_rotation_update then
			if extension.rotate_along_direction then
				local first_person_extension = extension.first_person_extension
				local current_rotation = first_person_extension.current_rotation(first_person_extension)
				local current_rotation_flat = Vector3_flat(Quaternion_forward(current_rotation))
				local velocity_current = extension.velocity_current:unbox()
				velocity_current.z = 0
				local velocity_dot = Vector3_dot(velocity_current, current_rotation_flat)

				if velocity_dot == 0 then
					local current_rotation_normalised = Vector3_normalize(current_rotation_flat)
					local target_rotation = extension.target_rotation:unbox()
					local target_rotation_flat = Vector3_flat(Quaternion_forward(target_rotation))
					local target_rotation_normalised = Vector3_normalize(target_rotation_flat)
					local dot = Vector3_dot(current_rotation_normalised, target_rotation_normalised)

					if dot < 0 then
						extension.target_rotation:store(current_rotation)
					end

					velocity_current = target_rotation_flat
				else
					extension.target_rotation:store(current_rotation)
				end

				if velocity_dot < -0.1 then
					velocity_current = -velocity_current
				end

				local final_rotation = Quaternion_look(velocity_current)

				Unit.set_local_rotation(unit, 0, Quaternion_lerp(Unit.local_rotation(unit, 0), final_rotation, dt*5))
			elseif extension.target_rotation_data then
				local target_rotation_data = extension.target_rotation_data
				local start_rotation = target_rotation_data.start_rotation:unbox()
				local target_rotation = target_rotation_data.target_rotation:unbox()
				local start_time = target_rotation_data.start_time
				local end_time = target_rotation_data.end_time
				local lerp_t = math_smoothstep(t, start_time, end_time)

				Unit_set_local_rotation(unit, 0, Quaternion_lerp(start_rotation, target_rotation, lerp_t))
			end
		end

		if is_server then
			local current_position = Unit.world_position(unit, 0)
			local found_nav_mesh, z = GwNavQueries.triangle_from_position(extension._nav_world, current_position, 0.1, 0.3, extension._nav_traverse_logic)

			if found_nav_mesh then
				extension._latest_position_on_navmesh:store(Vector3(current_position.x, current_position.y, current_position.z))
			end
		end

		extension.disable_rotation_update = false
	end

	Profiler.stop("rotation")

	return 
end
T.update_disabled_units = function (data, dt)
	Profiler.start("disabled")

	for unit, extension in pairs(data.all_disabled_units) do
		extension.run_func(unit, dt, extension)

		local game = Managers.state.network:game()
		local go_id = Managers.state.unit_storage:go_id(unit)

		if game and go_id then
			extension.sync_network_rotation(extension, game, go_id)
			extension.sync_network_position(extension, game, go_id)
			extension.sync_network_velocity(extension, game, go_id, dt)
		end

		return 
	end

	Profiler.stop("disabled")

	return 
end
T.update_debug_anims = function (data)
	Profiler.start("debug anims")

	for unit, extension in pairs(data.all_update_units) do
		local unit_1p = extension.first_person_extension:get_first_person_unit()

		if script_data.debug_first_person_player_animations and not extension.debugging_1p_animations then
			extension.debugging_1p_animations = true

			Unit.set_animation_logging(unit_1p, true)
		elseif extension.debugging_1p_animations and not script_data.debug_first_person_player_animations then
			extension.debugging_1p_animations = false

			Unit.set_animation_logging(unit_1p, false)
		end

		if script_data.debug_player_animations and not extension.debugging_animations then
			extension.debugging_animations = true

			Unit.set_animation_logging(unit, true)
		elseif extension.debugging_animations and not script_data.debug_player_animations then
			extension.debugging_animations = false

			Unit.set_animation_logging(unit, false)
		end
	end

	Profiler.stop("debug anims")

	return 
end
local telemetry_data = {}
T.update_player_position_telemetry = function (data, t)
	local POSITION_LOOKUP = POSITION_LOOKUP
	local player_manager = Managers.player
	local telemetry_manager = Managers.telemetry

	for unit, extension in pairs(data.all_update_units) do
		if extension.telemetry_timer <= t then
			local position = POSITION_LOOKUP[unit]
			local player = player_manager.unit_owner(player_manager, unit)
			local telemetry_id = player.telemetry_id(player)
			local hero = player.profile_display_name(player)
			telemetry_data.position = position
			telemetry_data.player_id = telemetry_id
			telemetry_data.hero = hero

			telemetry_manager.register_event(telemetry_manager, "player_position", telemetry_data)

			extension.telemetry_timer = t + extension.telemetry_log_interval
		end
	end

	return 
end

return 