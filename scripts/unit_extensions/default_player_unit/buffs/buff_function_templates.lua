BuffFunctionTemplates = BuffFunctionTemplates or {}

local function get_variable(path_to_movement_setting_to_modify, unit)
	assert(0 < #path_to_movement_setting_to_modify, "movement_setting_exists needs at least a movement_setting_to_modify")

	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local movement_value = movement_settings_table

	for _, movement_setting in ipairs(path_to_movement_setting_to_modify) do
		movement_value = movement_value[movement_setting]

		if not movement_value then
			break
		end
	end

	if movement_value then
		return movement_value
	else
		assert(orginal_variable_exists, "variable does not exist in PlayerUnitMovementSettings")
	end

	return 
end

local function set_variable(path_to_movement_setting_to_modify, unit, value)
	local nr_of_settings = #path_to_movement_setting_to_modify

	assert(0 < nr_of_settings, "movement_setting_exists needs at least a movement_setting_to_modify")

	local unit_movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local movement_value = unit_movement_settings_table
	local index = 1

	while index <= nr_of_settings do
		if nr_of_settings < index + 1 then
			movement_value[path_to_movement_setting_to_modify[index]] = value
		else
			movement_value = movement_value[path_to_movement_setting_to_modify[index]]
		end

		index = index + 1
	end

	return 
end

local params = {}
BuffFunctionTemplates.functions = {
	apply_action_lerp_movement_buff = function (unit, buff, params)
		local bonus = params.bonus
		local multiplier = params.multiplier

		if bonus then
			buff.current_lerped_value = 0
		end

		if multiplier then
			buff.current_lerped_multiplier = 1
		end

		return 
	end,
	update_action_lerp_movement_buff = function (unit, buff, params)
		local bonus = params.bonus
		local multiplier = params.multiplier
		local time_into_buff = params.time_into_buff
		local old_value_to_update_movement_setting, value_to_update_movement_setting, old_multiplier_to_update_movement_setting, multiplier_to_update_movement_setting = nil
		local percentage_in_lerp = math.min(1, time_into_buff/buff.template.lerp_time)

		if bonus then
			local new_value = math.lerp(0, bonus, percentage_in_lerp)
			old_value_to_update_movement_setting = buff.current_lerped_value
			buff.current_lerped_value = new_value
			value_to_update_movement_setting = new_value
		end

		if multiplier then
			local player = Managers.player:owner(unit)

			if player and player.boon_handler then
				local boon_handler = player.boon_handler
				local num_increased_combat_movement_boons = boon_handler.get_num_boons(boon_handler, "increased_combat_movement")
				local boon_template = BoonTemplates.increased_combat_movement

				if 0 < num_increased_combat_movement_boons then
					multiplier = multiplier + (multiplier - 1)*num_increased_combat_movement_boons*boon_template.multiplier
				end
			end

			local new_multiplier = math.lerp(1, multiplier, percentage_in_lerp)
			old_multiplier_to_update_movement_setting = buff.current_lerped_multiplier
			buff.current_lerped_multiplier = new_multiplier
			multiplier_to_update_movement_setting = new_multiplier
		end

		if value_to_update_movement_setting or multiplier_to_update_movement_setting then
			if buff.has_added_movement_previous_turn then
				buff_extension_function_params.value = old_value_to_update_movement_setting
				buff_extension_function_params.multiplier = old_multiplier_to_update_movement_setting

				BuffFunctionTemplates.functions.remove_movement_buff(unit, buff, buff_extension_function_params)
			end

			buff.has_added_movement_previous_turn = true
			buff_extension_function_params.value = value_to_update_movement_setting
			buff_extension_function_params.multiplier = multiplier_to_update_movement_setting

			BuffFunctionTemplates.functions.apply_movement_buff(unit, buff, buff_extension_function_params)
		end

		return 
	end,
	remove_action_lerp_movement_buff = function (unit, buff, params)
		local buff_extension = ScriptUnit.extension(unit, "buff_system")
		params.external_optional_duration = nil
		params.external_optional_bonus = buff.current_lerped_value
		params.external_optional_multiplier = buff.current_lerped_multiplier

		buff_extension.add_buff(buff_extension, buff.template.remove_buff_name, params)

		return 
	end,
	apply_action_lerp_remove_movement_buff = function (unit, buff, params)
		local bonus = params.bonus
		local multiplier = params.multiplier

		if bonus then
			buff.current_lerped_value = bonus
		end

		if multiplier then
			buff.current_lerped_multiplier = multiplier
		end

		buff.last_frame_percentage = 1

		return 
	end,
	update_action_lerp_remove_movement_buff = function (unit, buff, params)
		local bonus = params.bonus
		local multiplier = params.multiplier
		local time_into_buff = params.time_into_buff
		local value_to_update_movement_setting, old_value_to_update_movement_setting, old_multiplier_to_update_movement_setting, multiplier_to_update_movement_setting = nil

		if buff.last_frame_percentage == 0 then
			return 
		end

		local percentage_in_lerp = math.min(1, time_into_buff/buff.template.lerp_time)
		percentage_in_lerp = percentage_in_lerp - 1
		buff.last_frame_percentage = percentage_in_lerp

		if bonus then
			local new_value = math.lerp(0, bonus, percentage_in_lerp)
			old_value_to_update_movement_setting = buff.current_lerped_value
			buff.current_lerped_value = new_value
			value_to_update_movement_setting = new_value
		end

		if multiplier then
			local new_multiplier = math.lerp(1, multiplier, percentage_in_lerp)
			old_multiplier_to_update_movement_setting = buff.current_lerped_multiplier
			buff.current_lerped_multiplier = new_multiplier
			multiplier_to_update_movement_setting = new_multiplier
		end

		if value_to_update_movement_setting or multiplier_to_update_movement_setting then
			buff_extension_function_params.value = old_value_to_update_movement_setting
			buff_extension_function_params.multiplier = old_multiplier_to_update_movement_setting

			BuffFunctionTemplates.functions.remove_movement_buff(unit, buff, buff_extension_function_params)

			if 0 < percentage_in_lerp then
				buff_extension_function_params.value = value_to_update_movement_setting
				buff_extension_function_params.multiplier = multiplier_to_update_movement_setting

				BuffFunctionTemplates.functions.apply_movement_buff(unit, buff, buff_extension_function_params)
			end
		end

		return 
	end,
	apply_max_health_debuff = function (unit, buff, params)
		local health_extension = ScriptUnit.extension(unit, "health_system")
		local unmodified_max_health = health_extension.unmodified_max_health
		local buff_extension = ScriptUnit.extension(unit, "buff_system")
		local multiplier = params.multiplier
		local new_multiplier = buff_extension.apply_buffs_to_value(buff_extension, multiplier, StatBuffIndex.CURSE_PROTECTION)
		local current_max_health = health_extension.health

		if current_max_health == math.huge then
			return 
		end

		local max_health = current_max_health - new_multiplier*unmodified_max_health

		health_extension.set_max_health(health_extension, max_health, false)

		local damage = health_extension.damage
		local new_damage = damage - new_multiplier*damage

		if max_health <= new_damage then
			new_damage = max_health - 1
		end

		health_extension.set_current_damage(health_extension, new_damage)

		return 
	end,
	update_max_health_debuff = function (unit, buff, params)
		local health_extension = ScriptUnit.extension(unit, "health_system")
		local unmodified_max_health_changed = health_extension.unmodified_max_health_changed

		if unmodified_max_health_changed then
			local unmodified_max_health = health_extension.unmodified_max_health
			local buff_extension = ScriptUnit.extension(unit, "buff_system")
			local multiplier = params.multiplier
			local new_multiplier = buff_extension.apply_buffs_to_value(buff_extension, multiplier, StatBuffIndex.CURSE_PROTECTION)
			local current_max_health = health_extension.health

			if current_max_health == math.huge then
				return 
			end

			local max_health = current_max_health - new_multiplier*unmodified_max_health

			health_extension.set_max_health(health_extension, max_health, false)

			local damage = health_extension.damage
			local new_damage = damage - new_multiplier*damage

			if max_health <= new_damage then
				new_damage = max_health - 1
			end

			health_extension.set_current_damage(health_extension, new_damage)
		end

		return 
	end,
	remove_max_health_debuff = function (unit, buff, params)
		local health_extension = ScriptUnit.extension(unit, "health_system")
		local current_max_health = health_extension.health

		if current_max_health == math.huge then
			return 
		end

		local unmodified_max_health = health_extension.unmodified_max_health

		health_extension.set_max_health(health_extension, unmodified_max_health, true)

		local buff_extension = ScriptUnit.extension(unit, "buff_system")
		local multiplier = params.multiplier
		local new_multiplier = buff_extension.apply_buffs_to_value(buff_extension, multiplier, StatBuffIndex.CURSE_PROTECTION)
		local damage = health_extension.damage
		local new_damage = damage/(new_multiplier - 1)

		if unmodified_max_health <= new_damage then
			new_damage = unmodified_max_health - 1
		end

		health_extension.set_current_damage(health_extension, new_damage)

		return 
	end,
	apply_curse_protection = function (unit, buff, params)
		local health_extension = ScriptUnit.extension(unit, "health_system")
		local max_health = health_extension.unmodified_max_health

		health_extension.set_max_health(health_extension, max_health, true)

		return 
	end,
	remove_curse_protection = function (unit, buff, params)
		local health_extension = ScriptUnit.extension(unit, "health_system")
		local max_health = health_extension.unmodified_max_health

		health_extension.set_max_health(health_extension, max_health, true)

		return 
	end,
	apply_movement_buff = function (unit, buff, params)
		local bonus = params.bonus
		local multiplier = params.multiplier
		local path_to_movement_setting_to_modify = buff.template.path_to_movement_setting_to_modify
		local movement_setting_value = get_variable(path_to_movement_setting_to_modify, unit)

		if bonus then
			movement_setting_value = movement_setting_value + bonus
		end

		if multiplier then
			movement_setting_value = movement_setting_value*multiplier
		end

		set_variable(path_to_movement_setting_to_modify, unit, movement_setting_value)

		return 
	end,
	remove_movement_buff = function (unit, buff, params)
		local bonus = params.bonus
		local multiplier = params.multiplier
		local path_to_movement_setting_to_modify = buff.template.path_to_movement_setting_to_modify
		local movement_setting_value = get_variable(path_to_movement_setting_to_modify, unit)

		if multiplier then
			movement_setting_value = movement_setting_value/multiplier
		end

		if bonus then
			movement_setting_value = movement_setting_value - bonus
		end

		set_variable(path_to_movement_setting_to_modify, unit, movement_setting_value)

		return 
	end,
	apply_brawl_defeated_buff = function (unit, buff, params)
		return 
	end,
	remove_brawl_defeated_buff = function (unit, buff, params)
		local network_manager = Managers.state.network
		local go_id = network_manager.unit_game_object_id(network_manager, unit)

		if go_id then
			CharacterStateHelper.play_animation_event(unit, "revive_complete")
			StatusUtils.set_knocked_down_network(unit, false)

			local difficulty_manager = Managers.state.difficulty
			local difficulty_settings = difficulty_manager.get_difficulty_settings(difficulty_manager)
			local player_health = difficulty_settings.max_hp
			local health_extension = ScriptUnit.extension(unit, "health_system")

			health_extension.reset(health_extension)
			health_extension.set_max_health(health_extension, player_health, true)

			local state_id = NetworkLookup.health_statuses[health_extension.state]
			local is_level_unit = false

			network_manager.network_transmit:send_rpc_clients("rpc_sync_damage_taken", go_id, is_level_unit, 0, state_id)
			StatusUtils.set_wounded_network(unit, false, "healed", params.t)
		end

		return 
	end,
	apply_brawl_drunk_buff = function (unit, buff, params)
		local player_manager = Managers.player
		local player = player_manager.unit_owner(player_manager, unit)

		if player and player.local_player then
			local game = Managers.state.network:game()
			local player_unit_go_id = Managers.state.unit_storage:go_id(unit)

			GameSession.set_game_object_field(game, player_unit_go_id, "friendly_fire_melee", true)

			local fx_name = "fx/screenspace_drunken_lens_01"
			local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
			local particle_id = first_person_extension.create_screen_particles(first_person_extension, fx_name)
			buff.particle_id = particle_id
		end

		return 
	end,
	remove_brawl_drunk_buff = function (unit, buff, params, world)
		local player_manager = Managers.player
		local player = player_manager.unit_owner(player_manager, unit)

		if player and player.local_player then
			local network_manager = Managers.state.network
			local game = network_manager.game(network_manager)
			local player_unit_go_id = Managers.state.unit_storage:go_id(unit)

			GameSession.set_game_object_field(game, player_unit_go_id, "friendly_fire_melee", false)

			local particle_id = buff.particle_id

			World.destroy_particles(world, particle_id)

			buff.particle_id = nil
			local status_extension = ScriptUnit.extension(unit, "status_system")

			if not status_extension.is_knocked_down(status_extension) then
				local difficulty_manager = Managers.state.difficulty
				local difficulty_settings = difficulty_manager.get_difficulty_settings(difficulty_manager)
				local player_health = difficulty_settings.max_hp
				local heal_type = "buff"

				if player_manager.is_server then
					DamageUtils.heal_network(unit, unit, player_health, heal_type)
				else
					local network_transmit = network_manager.network_transmit
					local heal_type_id = NetworkLookup.heal_types[heal_type]

					network_transmit.send_rpc_server(network_transmit, "rpc_request_heal", player_unit_go_id, player_health, heal_type_id)
				end
			end
		end

		return 
	end,
	knock_down_bleed_start = function (unit, buff, params)
		buff.next_damage_time = params.t + buff.template.time_between_damage

		return 
	end,
	knock_down_bleed_update = function (unit, buff, params)
		if buff.next_damage_time < params.t then
			local status_extension = ScriptUnit.extension(unit, "status_system")

			if status_extension.is_knocked_down(status_extension) then
				local buff_template = buff.template
				buff.next_damage_time = buff.next_damage_time + buff_template.time_between_damage
				local damage = DamageUtils.calculate_damage(AttackDamageValues[buff_template.attack_damage_template], unit, unit, "full", 1)

				DamageUtils.add_damage_network(unit, unit, damage, "full", buff_template.damage_type, Vector3(1, 0, 0), "knockdown_bleed")
			end
		end

		return 
	end,
	start_dot_damage = function (unit, buff, params)
		local random_mod_next_dot_time = buff.template.time_between_dot_damages*0.75 + math.random()*0.5*buff.template.time_between_dot_damages
		buff.next_poison_damage_time = params.t + random_mod_next_dot_time

		if buff.template.start_flow_event then
			Unit.flow_event(unit, buff.template.start_flow_event)
		end

		return 
	end,
	apply_dot_damage = function (unit, buff, params)
		if buff.next_poison_damage_time < params.t then
			local health_extension = ScriptUnit.extension(unit, "health_system")

			if health_extension.is_alive(health_extension) then
				local buff_template = buff.template
				local random_mod_next_dot_time = buff.template.time_between_dot_damages*0.75 + math.random()*0.5*buff.template.time_between_dot_damages
				buff.next_poison_damage_time = buff.next_poison_damage_time + random_mod_next_dot_time

				if Unit.alive(params.attacker_unit) then
					local damage = DamageUtils.calculate_damage(AttackDamageValues[buff_template.attack_damage_template], unit, params.attacker_unit, "full", 1)

					DamageUtils.add_damage_network(unit, params.attacker_unit, damage, "full", buff_template.damage_type, Vector3(1, 0, 0), buff.damage_source or "dot_debuff")
				end
			end
		end

		return 
	end,
	remove_dot_damage = function (unit, buff, params)
		if buff.template.end_flow_event then
			Unit.flow_event(unit, buff.template.end_flow_event)
		end

		return 
	end,
	start_increase_incoming_damage = function (unit, buff, params, world)
		local breed = Unit.get_data(unit, "breed")
		local increase_incoming_damage_fx = breed.increase_incoming_damage_fx or "fx/chr_enemy_clanrat_damage_buff"
		local increase_incoming_damage_fx_node = Unit.node(unit, breed.increase_incoming_damage_fx_node or "c_head")
		local attacker_unit = buff.attacker_unit
		local attacker_unit_owner = Managers.player:owner(attacker_unit)

		if attacker_unit_owner and attacker_unit_owner.local_player then
			increase_incoming_damage_fx = increase_incoming_damage_fx .. "_applyer"
		end

		local pose = Matrix4x4.from_translation(Vector3(0.2, 0, 0))
		local particle_id = ScriptWorld.create_particles_linked(world, increase_incoming_damage_fx, unit, increase_incoming_damage_fx_node, "destroy", pose)
		buff.particle_id = particle_id
		local indication_sound = "hud_player_buff_extra_damage"

		WwiseUtils.trigger_unit_event(world, indication_sound, unit, increase_incoming_damage_fx_node)

		return 
	end,
	reapply_increase_incoming_damage = function (unit, buff, params, world)
		World.stop_spawning_particles(world, buff.particle_id)

		buff.particle_id = nil
		local breed = Unit.get_data(unit, "breed")
		local increase_incoming_damage_fx = breed.increase_incoming_damage_fx or "fx/chr_enemy_clanrat_damage_buff"
		local increase_incoming_damage_fx_node = Unit.node(unit, breed.increase_incoming_damage_fx_node or "c_head")
		local attacker_unit = buff.attacker_unit
		local attacker_unit_owner = Managers.player:owner(attacker_unit)

		if attacker_unit_owner and attacker_unit_owner.local_player then
			increase_incoming_damage_fx = increase_incoming_damage_fx .. "_applyer"
		end

		local pose = Matrix4x4.from_translation(Vector3(0.2, 0, 0))
		local particle_id = ScriptWorld.create_particles_linked(world, increase_incoming_damage_fx, unit, increase_incoming_damage_fx_node, "destroy", pose)
		buff.particle_id = particle_id
		local indication_sound = "hud_player_buff_extra_damage"

		WwiseUtils.trigger_unit_event(world, indication_sound, unit, increase_incoming_damage_fx_node)

		return 
	end,
	remove_increase_incoming_damage = function (unit, buff, params, world)
		World.stop_spawning_particles(world, buff.particle_id)

		buff.particle_id = nil

		return 
	end,
	start_dot_damage_globadier_gas = function (unit, buff, params, world)
		buff.next_poison_damage_time = params.t + buff.template.time_between_dot_damages
		local status_extension = ScriptUnit.extension(unit, "status_system")

		status_extension.modify_poison(status_extension, true, params.attacker_unit)

		return 
	end,
	remove_dot_damage_globadier_gas = function (unit, buff, params, world)
		local status_extension = ScriptUnit.extension(unit, "status_system")

		status_extension.modify_poison(status_extension, false)

		return 
	end,
	apply_dot_damage_globadier_gas = function (unit, buff, params, world)
		return 
	end,
	apply_volume_dot_damage = function (unit, buff, params)
		buff.next_damage_time = params.t + params.bonus.time_between_damage

		return 
	end,
	update_volume_dot_damage = function (unit, buff, params)
		if buff.next_damage_time < params.t then
			local health_extension = ScriptUnit.extension(unit, "health_system")

			if health_extension.is_alive(health_extension) then
				buff.next_damage_time = buff.next_damage_time + params.bonus.time_between_damage
				local damage = DamageUtils.calculate_damage(params.bonus.damage, unit, params.attacker_unit, "full", 1)

				DamageUtils.add_damage_network(unit, params.attacker_unit, damage, "full", buff.template.damage_type, Vector3(1, 0, 0))
			end
		end

		return 
	end,
	apply_volume_movement_buff = function (unit, buff, params)
		local movement_settings = PlayerUnitMovementSettings.get_movement_settings_table(unit)
		movement_settings.move_speed = movement_settings.move_speed*params.multiplier

		return 
	end,
	remove_volume_movement_buff = function (unit, buff, params)
		local movement_settings = PlayerUnitMovementSettings.get_movement_settings_table(unit)
		movement_settings.move_speed = movement_settings.move_speed/params.multiplier

		return 
	end
}
BuffFunctionTemplates.functions.update_charging_action_lerp_movement_buff = function (unit, buff, params)
	local multiplier = params.multiplier
	local time_into_buff = params.time_into_buff
	local old_value_to_update_movement_setting, old_multiplier_to_update_movement_setting, multiplier_to_update_movement_setting = nil
	local buff_extension = ScriptUnit.extension(unit, "buff_system")
	multiplier = multiplier and buff_extension.apply_buffs_to_value(buff_extension, multiplier - 1, StatBuffIndex.INCREASED_MOVE_SPEED_WHILE_AIMING) - 1
	local percentage_in_lerp = math.min(1, time_into_buff/buff.template.lerp_time)

	if multiplier then
		local player = Managers.player:owner(unit)

		if player and player.boon_handler then
			local boon_handler = player.boon_handler
			local num_increased_combat_movement_boons = boon_handler.get_num_boons(boon_handler, "increased_combat_movement")
			local boon_template = BoonTemplates.increased_combat_movement

			if 0 < num_increased_combat_movement_boons then
				multiplier = multiplier + (multiplier - 1)*num_increased_combat_movement_boons*boon_template.multiplier
			end
		end

		local new_multiplier = math.lerp(1, multiplier, percentage_in_lerp)
		local difference = new_multiplier - buff.current_lerped_multiplier

		if 0.001 < math.abs(difference) then
			old_multiplier_to_update_movement_setting = buff.current_lerped_multiplier
			buff.current_lerped_multiplier = new_multiplier
			multiplier_to_update_movement_setting = new_multiplier
		end
	end

	if multiplier_to_update_movement_setting then
		if buff.has_added_movement_previous_turn then
			buff_extension_function_params.value = old_value_to_update_movement_setting
			buff_extension_function_params.multiplier = old_multiplier_to_update_movement_setting

			BuffFunctionTemplates.functions.remove_movement_buff(unit, buff, buff_extension_function_params)
		end

		buff.has_added_movement_previous_turn = true
		buff_extension_function_params.multiplier = multiplier_to_update_movement_setting

		BuffFunctionTemplates.functions.apply_movement_buff(unit, buff, buff_extension_function_params)
	end

	return 
end

return 
