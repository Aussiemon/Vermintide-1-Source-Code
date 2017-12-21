function flow_callback_activate_ai_spawner(params)
	local spawner_unit = params.spawner_unit

	Managers.state.event:trigger("activate_ai_spawner", spawner_unit)

	return 
end

function flow_callback_deactivate_ai_spawner(params)
	local spawner_unit = params.spawner_unit

	Managers.state.event:trigger("deactivate_ai_spawner", spawner_unit)

	return 
end

function flow_callback_hibernate_spawner(params)
	local spawner_unit = params.spawner_unit
	local hibernate = params.hibernate
	local spawner_system = Managers.state.entity:system("spawner_system")

	spawner_system.hibernate_spawner(spawner_system, spawner_unit, hibernate)

	return 
end

function flow_callback_ai_move_group_command(params)
	Managers.state.event:trigger("ai_move_group", params.player_name, params.group_name, params.target_unit, params.on_arrived_event_name)

	return 
end

function flow_callback_ai_move_single_command(params)
	Managers.state.event:trigger("ai_move_single", params.move_unit, params.target_unit)

	return 
end

function flow_callback_ai_despawn(params)
	local spawner_unit = params.spawner_unit
	local spawner = ScriptUnit.extension(spawner_unit, "spawner_system")

	spawner.despawn(spawner)

	return 
end

function flow_callback_ai_kill(params)
	local hit_actor = params.hit_actor
	local hit_unit = params.hit_unit
	local hit_normal = params.hit_normal
	local attack_template_name = params.attack_template
	local breed = Unit.get_data(hit_unit, "breed")

	if not breed then
		return 
	end

	local node = Actor.node(hit_actor)
	local hit_zone = breed.hit_zones_lookup[node]
	local hit_zone_name = hit_zone.name
	local network_manager = Managers.state.network
	local hit_unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
	local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
	local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
	local attack_direction = -hit_normal
	local player = Managers.player:players()[1]
	local player_unit = player.player_unit
	local attacker_unit_id = network_manager.unit_game_object_id(network_manager, player_unit)
	local attack_damage_value_id = NetworkLookup.attack_damage_values["n/a"]
	local damage_source = "flow"
	local hit_ragdoll_actor = NetworkLookup.hit_ragdoll_actors["n/a"]
	local backstab_multiplier = 1
	local hawkeye_multiplier = 0

	if Managers.player.is_server or LEVEL_EDITOR_TEST then
		Managers.state.entity:system("weapon_system"):rpc_attack_hit(nil, NetworkLookup.damage_sources[damage_source], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_damage_value_id, hit_ragdoll_actor, backstab_multiplier, hawkeye_multiplier)
	else
		network_manager.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources[damage_source], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_damage_value_id, hit_ragdoll_actor, backstab_multiplier, hawkeye_multiplier)
	end

	return 
end

function trigger_ai_equipment_flow_event(params)
	local ai_unit = params.unit
	local inv_ext = ScriptUnit.has_extension(ai_unit, "ai_inventory_system")

	if inv_ext then
		local inventory_item_units = inv_ext.inventory_item_units
		local unit_flow = Unit.flow_event

		for i = 1, inv_ext.inventory_items_n, 1 do
			unit_flow(inventory_item_units[i], params.event)
		end
	end

	return 
end

function flow_callback_ai_follow_path(params)
	local ai_entity = params.ai_entity
	local spline_name = params.spline_name
	local finish_event = params.finish_event

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner.spawned_units(spawner)) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")
			ai_base.blackboard(ai_base).move_orders[spline_name] = {
				name = "follow",
				finish_event = finish_event
			}
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")
		ai_base.blackboard(ai_base).move_orders[spline_name] = {
			name = "follow",
			finish_event = finish_event
		}
	end

	return 
end

function flow_callback_ai_patrol_path(params)
	local ai_entity = params.ai_entity
	local spline_name = params.spline_name

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner.spawned_units(spawner)) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")
			ai_base.blackboard(ai_base).move_orders[spline_name] = {
				name = "patrol"
			}
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")
		ai_base.blackboard(ai_base).move_orders[spline_name] = {
			name = "patrol"
		}
	end

	return 
end

function flow_callback_ai_move_to_command(params)
	local ai_entity = params.ai_entity
	local waypoint_unit = params.waypoint_unit
	local finish_event = params.finish_event

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner.spawned_units(spawner)) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")
			ai_base.blackboard(ai_base).move_orders[waypoint_unit] = {
				name = "move",
				finish_event = finish_event
			}
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")
		ai_base.blackboard(ai_base).move_orders[waypoint_unit] = {
			name = "move",
			finish_event = finish_event
		}
	end

	return 
end

function flow_callback_ai_detect_player(params)
	local ai_entity = params.ai_entity
	local player_unit = Managers.player:player_from_peer_id(Network.peer_id()).player_unit

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner.spawned_units(spawner)) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")
			ai_base.blackboard(ai_base).players[player_unit] = true
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")
		ai_base.blackboard(ai_base).players[player_unit] = true
	end

	return 
end

function flow_callback_ai_hold_position(params)
	local ai_entity = params.ai_entity

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner.spawned_units(spawner)) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base.steering(ai_base):reset()

			local brain = ai_base.brain(ai_base)

			brain.change_behaviour(brain, "avoidance", "nil_tree")
			brain.change_behaviour(brain, "pathing", "nil_tree")
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base.steering(ai_base):reset()

		local brain = ai_base.brain(ai_base)

		brain.change_behaviour(brain, "avoidance", "nil_tree")
		brain.change_behaviour(brain, "pathing", "nil_tree")
	end

	return 
end

function flow_callback_set_ai_properties(params)
	local ai_entity = params.ai_entity
	params.ai_entity = nil

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner.spawned_units(spawner)) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base.set_properties(ai_base, params)
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base.set_properties(ai_base, params)
	end

	return 
end

function flow_callback_set_ai_perception(params)
	local ai_entity = params.ai_entity

	if ScriptUnit.has_extension(ai_entity, "spawner_system") then
		local spawner = ScriptUnit.extension(ai_entity, "spawner_system")

		for ai_unit, _ in pairs(spawner.spawned_units(spawner)) do
			local ai_base = ScriptUnit.extension(ai_unit, "ai_system")

			ai_base.perception(ai_base):set_config(params)
		end
	else
		local ai_base = ScriptUnit.extension(ai_entity, "ai_system")

		ai_base.perception(ai_base):set_config(params)
	end

	return 
end

function flow_callback_ai_set_waypoint(params)
	local waypoint_name = params.waypoint_name
	local waypoint_unit = params.waypoint_unit
	local world = Managers.world:world("level_world")
	local level = LevelHelper:current_level(world)

	Level.set_flow_variable(level, waypoint_name, waypoint_unit)

	return 
end

function flow_callback_ai_set_areas(params)
	flow_callback_set_ai_properties(params)

	return 
end

function flow_callback_set_ai_spawner_mode(params)
	Managers.state.entity:system("spawner_system"):set_deterministic(params.deterministic)

	return 
end

function flow_callback_force_terror_event(params)
	if Managers.player.is_server or LEVEL_EDITOR_TEST then
		Managers.state.conflict:start_terror_event(params.event_type)
	end

	return 
end

function flow_callback_override_player_respawning(params)
	if Managers.player.is_server or LEVEL_EDITOR_TEST then
		Managers.state.spawn.respawn_handler:set_override_respawn_group(params.respawn_group_name, params.active)
	end

	return 
end

function flow_callback_pick_crossroad_path(params)
	if Managers.player.is_server or LEVEL_EDITOR_TEST then
		Managers.state.conflict.level_analysis:pick_crossroad_path(params.crossroad_id, params.path_id)
	end

	return 
end

function flow_callback_change_spawner_id(params)
	Managers.state.entity:system("spawner_system"):change_spawner_id(params.unit, params.spawner_id, params.new_spawner_id)

	return 
end

function flow_callback_stop_terror_event(params)
	if Managers.player.is_server or LEVEL_EDITOR_TEST then
		local event_name = params.event_type

		TerrorEventMixer.stop_event(event_name)
	end

	return 
end

function flow_callback_force_random_terror_event(params)
	if Managers.player.is_server or LEVEL_EDITOR_TEST then
		TerrorEventMixer.start_random_event(params.event_chunk)
	end

	return 
end

function flow_callback_bot_nav_transition_entered(params)
	local bot_unit = params.bot_unit
	local transition_unit = params.transition_unit
	local actor = params.bot_actor
	local nav_ext = ScriptUnit.has_extension(bot_unit, "ai_navigation_system") and ScriptUnit.extension(bot_unit, "ai_navigation_system")

	if nav_ext then
		nav_ext.flow_cb_entered_nav_transition(nav_ext, transition_unit, actor)
	else
		Application.warning(string.format("[flow_callback_bot_nav_transition_left] Unit: %s missing extension \"ai_navigation_system\"", tostring(bot_unit)))
	end

	return 
end

function flow_callback_bot_nav_transition_left(params)
	local bot_unit = params.bot_unit
	local transition_unit = params.transition_unit
	local actor = params.bot_actor
	local nav_ext = ScriptUnit.has_extension(bot_unit, "ai_navigation_system") and ScriptUnit.extension(bot_unit, "ai_navigation_system")

	if nav_ext then
		nav_ext.flow_cb_left_nav_transition(nav_ext, transition_unit, actor)
	else
		Application.warning(string.format("[flow_callback_bot_nav_transition_left] Unit: %s missing extension \"ai_navigation_system\"", tostring(bot_unit)))
	end

	return 
end

return 
