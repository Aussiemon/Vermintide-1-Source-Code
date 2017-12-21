ActionUtils = ActionUtils or {}
ActionUtils.select_attack_template = function (attack_target_settings, is_critical_strike)
	local attack_template_damage_type_name = (is_critical_strike and attack_target_settings.critical_attack_template_damage_type) or attack_target_settings.attack_template_damage_type
	local attack_template_name = (is_critical_strike and attack_target_settings.critical_attack_template) or attack_target_settings.attack_template

	return attack_template_name, attack_template_damage_type_name
end
ActionUtils.spawn_flame_wave_projectile = function (owner_unit, scale, item_template_name, action_name, sub_action_name, position, flat_angle, lateral_speed, initial_forward_speed)
	scale = scale or 100
	local projectile_system = Managers.state.entity:system("projectile_system")

	projectile_system.spawn_flame_wave_projectile(projectile_system, owner_unit, scale, item_name, item_template_name, action_name, sub_action_name, position, flat_angle, lateral_speed, initial_forward_speed)

	return 
end
ActionUtils.spawn_player_projectile = function (owner_unit, position, rotation, scale, angle, target_vector, speed, item_name, item_template_name, action_name, sub_action_name)
	scale = scale or 100
	local projectile_system = Managers.state.entity:system("projectile_system")
	local ping = 0

	projectile_system.spawn_player_projectile(projectile_system, owner_unit, position, rotation, scale, angle, target_vector, speed, item_name, item_template_name, action_name, sub_action_name, ping)

	return 
end
ActionUtils.spawn_pickup_projectile = function (world, weapon_unit, projectile_unit_name, projectile_unit_template_name, current_action, owner_unit, position, rotation, velocity, angular_velocity, item_name, spawn_type)
	local lookup_data = current_action.lookup_data
	local projectile_info = current_action.projectile_info
	local projectile_template_name = projectile_info.projectile_template_name
	local pickup_name = projectile_info.pickup_name
	local projectile_unit_name_id = NetworkLookup.husks[projectile_unit_name]
	local projectile_unit_template_name_id = NetworkLookup.go_types[projectile_unit_template_name]
	local owner_unit_id = Managers.state.network:unit_game_object_id(owner_unit)
	local network_position = AiAnimUtils.position_network_scale(position, true)
	local network_rotation = AiAnimUtils.rotation_network_scale(rotation, true)
	local network_velocity = AiAnimUtils.velocity_network_scale(velocity, true)
	local network_angular_velocity = AiAnimUtils.velocity_network_scale(angular_velocity, true)
	local pickup_name_id = NetworkLookup.pickup_names[pickup_name]
	local spawn_type_id = NetworkLookup.pickup_spawn_types[spawn_type]
	local has_death_extension = ScriptUnit.has_extension(weapon_unit, "death_system")

	if has_death_extension then
		local health_extension = ScriptUnit.extension(weapon_unit, "health_system")
		local damage = health_extension.damage
		local death_extension = ScriptUnit.extension(weapon_unit, "death_system")
		death_extension.thrown = true
		local has_death_started = death_extension.has_death_started(death_extension)
		local death_reaction_data = death_extension.death_reaction_data
		local explode_time = 0

		if has_death_started then
			explode_time = death_reaction_data.explode_time
		end

		local fuse_time = (death_reaction_data and death_reaction_data.fuse_time) or 6
		local item_name_id = NetworkLookup.item_names[item_name]

		if ScriptUnit.has_extension(weapon_unit, "limited_item_track_system") then
			local limited_item_extension = ScriptUnit.extension(weapon_unit, "limited_item_track_system")
			limited_item_extension.thrown = true
			local limited_item_id = limited_item_extension.id
			local spawner_unit = limited_item_extension.spawner_unit
			local level = LevelHelper:current_level(world)
			local spawner_unit_id = Level.unit_index(level, spawner_unit)
			projectile_unit_template_name_id = NetworkLookup.go_types.explosive_pickup_projectile_unit_limited

			Managers.state.network.network_transmit:send_rpc_server("rpc_spawn_explosive_pickup_projectile_limited", projectile_unit_name_id, projectile_unit_template_name_id, network_position, network_rotation, network_velocity, network_angular_velocity, pickup_name_id, spawner_unit_id, limited_item_id, damage, explode_time, fuse_time, item_name_id, spawn_type_id)
		else
			Managers.state.network.network_transmit:send_rpc_server("rpc_spawn_explosive_pickup_projectile", projectile_unit_name_id, projectile_unit_template_name_id, network_position, network_rotation, network_velocity, network_angular_velocity, pickup_name_id, damage, explode_time, fuse_time, item_name_id, spawn_type_id)
		end
	elseif ScriptUnit.has_extension(weapon_unit, "limited_item_track_system") then
		local limited_item_extension = ScriptUnit.extension(weapon_unit, "limited_item_track_system")
		limited_item_extension.thrown = true
		local limited_item_id = limited_item_extension.id
		local spawner_unit = limited_item_extension.spawner_unit
		local level = LevelHelper:current_level(world)
		local spawner_unit_id = Level.unit_index(level, spawner_unit)
		projectile_unit_template_name_id = NetworkLookup.go_types.pickup_projectile_unit_limited

		Managers.state.network.network_transmit:send_rpc_server("rpc_spawn_pickup_projectile_limited", projectile_unit_name_id, projectile_unit_template_name_id, network_position, network_rotation, network_velocity, network_angular_velocity, pickup_name_id, spawner_unit_id, limited_item_id, spawn_type_id)
	else
		Managers.state.network.network_transmit:send_rpc_server("rpc_spawn_pickup_projectile", projectile_unit_name_id, projectile_unit_template_name_id, network_position, network_rotation, network_velocity, network_angular_velocity, pickup_name_id, spawn_type_id)
	end

	return 
end
ActionUtils.spawn_true_flight_projectile = function (owner_unit, target_unit, true_flight_template_id, position, rotation, angle, target_vector, speed, item_name, item_template_name, action_name, sub_action_name, scale)
	local projectile_system = Managers.state.entity:system("projectile_system")
	local true_flight_template_name = TrueFlightTemplatesLookup[true_flight_template_id]
	scale = scale or 100

	projectile_system.spawn_true_flight_projectile(projectile_system, owner_unit, target_unit, true_flight_template_name, position, rotation, angle, target_vector, speed, item_name, item_template_name, action_name, sub_action_name, scale)

	return 
end
ActionUtils.apply_attack_speed_buff = function (attack_speed_value, unit)
	local new_value = attack_speed_value

	if unit and Unit.alive(unit) and ScriptUnit.has_extension(unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(unit, "buff_system")
		new_value = buff_extension.apply_buffs_to_value(buff_extension, attack_speed_value, StatBuffIndex.ATTACK_SPEED)
		new_value = buff_extension.apply_buffs_to_value(buff_extension, new_value, StatBuffIndex.ATTACK_SPEED_FROM_PROC)
	end

	return new_value
end
ActionUtils.init_action_buff_data = function (action_buff_data, buff_data, t)
	local start_times = action_buff_data.buff_start_times
	local end_times = action_buff_data.buff_end_times
	local action_buffs_in_progress = action_buff_data.action_buffs_in_progress
	local buff_identifiers = action_buff_data.buff_identifiers

	for index, buff in ipairs(buff_data) do
		local start_time = t + (buff.start_time or 0)
		local end_time = buff.end_time or math.huge
		local buff_index = #start_times + 1
		start_times[buff_index] = start_time
		end_times[buff_index] = start_time + end_time
		action_buffs_in_progress[buff_index] = false
		buff_identifiers[buff_index] = ""
	end

	return 
end
local params = {}
ActionUtils.update_action_buff_data = function (action_buff_data, buff_data, owner_unit, t)
	local start_times = action_buff_data.buff_start_times
	local end_times = action_buff_data.buff_end_times
	local buff_identifiers = action_buff_data.buff_identifiers
	local action_buffs_in_progress = action_buff_data.action_buffs_in_progress

	for index, start_time in ipairs(start_times) do
		if start_time <= t then
			local buff = buff_data[index]
			local buff_template_name = buff.buff_name
			params.external_optional_bonus = buff.external_value
			params.external_optional_multiplier = buff.external_multiplier
			start_times[index] = math.huge
			local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
			buff_identifiers[index] = buff_extension.add_buff(buff_extension, buff_template_name, params)
			action_buffs_in_progress[index] = true
		end
	end

	for index, end_time in ipairs(end_times) do
		if end_time <= t then
			end_times[index] = math.huge
			action_buffs_in_progress[index] = false
			local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
			local id = buff_identifiers[index]

			buff_extension.remove_buff(buff_extension, id)
		end
	end

	return 
end
ActionUtils.remove_action_buff_data = function (action_buff_data, buff_data, owner_unit)
	local action_buffs_in_progress = action_buff_data.action_buffs_in_progress
	local buff_identifiers = action_buff_data.buff_identifiers

	for index, buff_in_progress in ipairs(action_buffs_in_progress) do
		if buff_in_progress then
			local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
			local id = buff_identifiers[index]

			buff_extension.remove_buff(buff_extension, id)
		end
	end

	return 
end
ActionUtils.start_charge_sound = function (wwise_world, weapon_unit, action_settings)
	local wwise_source_id = WwiseWorld.make_auto_source(wwise_world, weapon_unit)
	local overcharge_extension = nil

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	local charge_sound_switch = action_settings.charge_sound_switch

	if overcharge_extension and charge_sound_switch then
		if overcharge_extension.above_overcharge_threshold(overcharge_extension) then
			WwiseWorld.set_switch(wwise_world, charge_sound_switch, "above_overcharge_threshold", wwise_source_id)
		else
			WwiseWorld.set_switch(wwise_world, charge_sound_switch, "below_overcharge_threshold", wwise_source_id)
		end
	end

	local charge_sound_name = action_settings.charge_sound_name
	local wwise_playing_id = WwiseWorld.trigger_event(wwise_world, charge_sound_name, wwise_source_id)
	local charge_sound_parameter_name = action_settings.charge_sound_parameter_name

	if charge_sound_parameter_name then
		WwiseWorld.set_source_parameter(wwise_world, wwise_source_id, charge_sound_parameter_name, 1)
	end

	return wwise_playing_id, wwise_source_id
end
ActionUtils.stop_charge_sound = function (wwise_world, wwise_playing_id, wwise_source_id, action_settings)
	local charge_sound_stop_event = action_settings.charge_sound_stop_event

	if charge_sound_stop_event then
		WwiseWorld.trigger_event(wwise_world, charge_sound_stop_event, wwise_source_id)
	end

	return 
end
ActionUtils.play_husk_sound_event = function (sound_event, player_unit)
	local network_manager = Managers.state.network
	local network_transmit = network_manager.network_transmit
	local go_id = network_manager.unit_game_object_id(network_manager, player_unit)
	local event_id = NetworkLookup.sound_events[sound_event]

	if Managers.player.is_server then
		network_transmit.send_rpc_clients(network_transmit, "rpc_play_husk_sound_event", go_id, event_id)
	else
		network_transmit.send_rpc_server(network_transmit, "rpc_play_husk_sound_event", go_id, event_id)
	end

	return 
end

return 
