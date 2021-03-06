require("scripts/entity_system/systems/behaviour/utility/utility")

local unit_get_data = Unit.get_data
local script_data = script_data
local unit_alive = Unit.alive

function aiprint(...)
	if script_data.debug_ai_movement then
		print(...)
	end
end

AiUtils = AiUtils or {}

AiUtils.special_dead_cleanup = function (unit, blackboard)
	if not blackboard.target_unit then
		return
	end

	local special_targets = blackboard.group_blackboard.special_targets
	special_targets[blackboard.target_unit] = nil
	local disabled_by_special = blackboard.group_blackboard.disabled_by_special
	disabled_by_special[blackboard.target_unit] = nil
end

local broadphase_query_result = {}

AiUtils.aggro_unit_of_enemy = function (unit, enemy_unit)
	enemy_unit = AiUtils.get_actual_attacker_unit(enemy_unit)

	if not unit_alive(enemy_unit) then
		return
	end

	local ai_simple_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_simple_extension then
		ai_simple_extension:enemy_aggro(unit, enemy_unit)
	end
end

AiUtils.activate_unit = function (blackboard)
	if not blackboard.confirmed_player_sighting then
		Managers.state.event:trigger("ai_unit_activated", blackboard.breed.name, blackboard.event_spawned)

		blackboard.confirmed_player_sighting = true
	end
end

AiUtils.stormvermin_champion_hack_check_ward = function (unit, blackboard)
	if blackboard.ward_active and not blackboard.defensive_mode_duration then
		blackboard.ward_active = false

		AiUtils.stormvermin_champion_set_ward_state(unit, false, true)
	end
end

AiUtils.stormvermin_champion_set_ward_state = function (unit, state, is_server)
	local actor = Unit.actor(unit, "c_trophy_rack_ward")

	Actor.set_scene_query_enabled(actor, state)

	if state then
		Unit.flow_event(unit, "skulls_glow_on")
	else
		Unit.flow_event(unit, "skulls_glow_off")
	end

	if is_server then
		local network_manager = Managers.state.network
		local unit_id = network_manager:unit_game_object_id(unit)

		network_manager.network_transmit:send_rpc_clients("rpc_set_ward_state", unit_id, state)
	end
end

AiUtils.alert_unit_of_enemy = function (unit, enemy_unit)
	enemy_unit = AiUtils.get_actual_attacker_unit(enemy_unit)

	if not unit_alive(enemy_unit) then
		return
	end

	local ai_simple_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_simple_extension then
		ai_simple_extension:enemy_alert(unit, enemy_unit)
	end
end

AiUtils.alert_nearby_friends_of_enemy = function (unit, broadphase, enemy_unit, range)
	range = range or 5
	enemy_unit = AiUtils.get_actual_attacker_unit(enemy_unit)

	if not unit_alive(enemy_unit) then
		return
	end

	Profiler.start("alert_nearby_friends_of_enemy")

	local num_results = Broadphase.query(broadphase, Unit.local_position(unit, 0), range, broadphase_query_result)

	for i = 1, num_results, 1 do
		local other_unit = broadphase_query_result[i]

		if other_unit ~= unit then
			local ai_simple_extension = ScriptUnit.has_extension(unit, "ai_system")

			if ai_simple_extension then
				ai_simple_extension:enemy_alert(unit, enemy_unit)
			end
		end

		broadphase_query_result[i] = nil
	end

	Profiler.stop("alert_nearby_friends_of_enemy")
end

AiUtils.print = function (debug_parameter, ...)
	if Development.parameter(debug_parameter) then
		print(...)
	end
end

AiUtils.printf = function (debug_parameter, ...)
	if Development.parameter(debug_parameter) then
		printf(...)
	end
end

AiUtils.breed_name = function (unit)
	return Unit.get_data(unit, "breed").name
end

AiUtils.stagger_target = function (unit, hit_unit, distance, impact, direction, t)
	local stagger_type, stagger_duration = DamageUtils.calculate_stagger(impact, nil, hit_unit, unit)

	if stagger_type > 0 then
		local hit_unit_blackboard = Unit.get_data(hit_unit, "blackboard")

		AiUtils.stagger(hit_unit, hit_unit_blackboard, unit, direction, distance, stagger_type, stagger_duration, nil, t)
	end
end

AiUtils.damage_target = function (target_unit, attacker_unit, action, damage_triplett, damage_source)
	local damage = DamageUtils.calculate_damage(damage_triplett, target_unit, attacker_unit)
	local attacker_pos = POSITION_LOOKUP[attacker_unit] or Unit.world_position(attacker_unit, 0)
	local target_pos = POSITION_LOOKUP[target_unit] or Unit.local_position(target_unit, 0)
	local damage_direction = Vector3.normalize(target_pos - attacker_pos)
	local index, is_level_unit = Managers.state.network:game_object_or_level_id(target_unit)
	damage_source = damage_source or AiUtils.breed_name(attacker_unit)

	if is_level_unit then
		local damage_extension = ScriptUnit.extension(target_unit, "damage_system")

		damage_extension:add_damage(attacker_unit, damage, "torso", action.damage_type, damage_direction, damage_source)

		if not LEVEL_EDITOR_TEST then
			local damage_source_id = NetworkLookup.damage_sources[damage_source or "n/a"]

			Managers.state.network.network_transmit:send_rpc_clients("rpc_level_object_damage", index, damage, damage_direction, damage_source_id)
		end
	else
		local dimishing_damage_data = action.dimishing_damage
		local has_ai_slot_extension = ScriptUnit.has_extension(target_unit, "ai_slot_system")

		if dimishing_damage_data and has_ai_slot_extension then
			local ai_slot_extension = ScriptUnit.extension(target_unit, "ai_slot_system")
			local slots_n = ai_slot_extension.slots_count

			if slots_n > 0 then
				local dimishing_damage = dimishing_damage_data[math.min(slots_n, 9)]
				local damage_modifier = dimishing_damage.damage
				damage = damage * damage_modifier
			end
		end

		DamageUtils.add_damage_network(target_unit, attacker_unit, damage, "torso", action.damage_type, damage_direction, damage_source)

		local is_player_unit = DamageUtils.is_player_unit(target_unit)
		local push_speed = action.player_push_speed

		if is_player_unit and push_speed then
			local target_status_extension = ScriptUnit.extension(target_unit, "status_system")

			if not target_status_extension:is_disabled() then
				local player_locomotion = ScriptUnit.extension(target_unit, "locomotion_system")

				player_locomotion:add_external_velocity(push_speed * damage_direction, action.max_player_push_speed)
			end
		end
	end
end

AiUtils.poison_explode_unit = function (unit, action, blackboard)
	local position = Unit.local_position(unit, 0)
	local difficulty_rank = Managers.state.difficulty:get_difficulty_rank()
	local aoe_dot_damage_table = action.aoe_dot_damage[difficulty_rank]
	local aoe_dot_damage = DamageUtils.calculate_damage(aoe_dot_damage_table)
	local aoe_init_damage_table = action.aoe_init_damage[difficulty_rank]
	local aoe_init_damage = DamageUtils.calculate_damage(aoe_init_damage_table)
	local aoe_dot_damage_interval = action.aoe_dot_damage_interval
	local radius = action.radius
	local initial_radius = action.initial_radius
	local duration = action.duration
	local create_nav_tag_volume = action.create_nav_tag_volume
	local nav_tag_volume_layer = action.nav_tag_volume_layer
	local extension_init_data = {
		area_damage_system = {
			dot_effect_name = "fx/wpnfx_poison_wind_globe_impact",
			invisible_unit = true,
			player_screen_effect_name = "fx/screenspace_poison_globe_impact",
			area_ai_random_death_template = "area_poison_ai_random_death",
			area_damage_template = "area_dot_damage",
			extra_dot_effect_name = "fx/chr_gutter_death",
			damage_players = true,
			aoe_dot_damage = aoe_dot_damage,
			aoe_init_damage = aoe_init_damage,
			aoe_dot_damage_interval = aoe_dot_damage_interval,
			radius = radius,
			initial_radius = initial_radius,
			life_time = duration,
			damage_source = blackboard.breed.name,
			create_nav_tag_volume = create_nav_tag_volume,
			nav_tag_volume_layer = nav_tag_volume_layer
		}
	}
	local aoe_unit_name = "units/weapons/projectile/poison_wind_globe/poison_wind_globe"
	local aoe_unit = Managers.state.unit_spawner:spawn_network_unit(aoe_unit_name, "aoe_unit", extension_init_data, position)
	local unit_id = Managers.state.unit_storage:go_id(aoe_unit)

	Unit.set_unit_visibility(aoe_unit, false)

	local world = blackboard.world

	assert(world)
	Managers.state.network.network_transmit:send_rpc_all("rpc_area_damage", unit_id, position)
	Managers.state.unit_spawner:mark_for_deletion(unit)
end

AiUtils.broadphase_query = function (position, radius, result_table)
	fassert(result_table, "No result_table given to AiUtils,broadphase_query")

	local ai_system = Managers.state.entity:system("ai_system")
	local broadphase = ai_system.group_blackboard.broadphase

	Profiler.start("Ai broadphase query")

	local num_hits = Broadphase.query(broadphase, position, radius, result_table)

	Profiler.stop("Ai broadphase query")

	return num_hits
end

AiUtils.get_angle_between_vectors = function (vector_1, vector_2)
	vector_1 = Vector3.normalize(Vector3.flat(vector_1))
	vector_2 = Vector3.normalize(Vector3.flat(vector_2))
	local radians = math.atan2(vector_1.y, vector_1.x) - math.atan2(vector_2.y, vector_2.x)
	local degrees = math.radians_to_degrees(radians)
	local angle = math.abs(degrees)

	return angle, degrees, radians
end

AiUtils.rotate_vector = function (vector, radians)
	local length = Vector3.length(vector)
	local l_radians = math.atan2(vector.y, vector.x)
	l_radians = l_radians + radians
	local x = math.cos(l_radians)
	local y = math.sin(l_radians)
	local return_vector = Vector3(x, y, 0)
	return_vector = return_vector * length

	return return_vector
end

AiUtils.constrain_radians = function (radians)
	if math.pi < radians then
		radians = -math.pi + radians - math.pi
	elseif radians < -math.pi then
		radians = math.pi + radians + math.pi
	end

	return radians
end

AiUtils.get_actual_attacker_unit = function (attacker_unit)
	if ScriptUnit.has_extension(attacker_unit, "projectile_system") and not ScriptUnit.has_extension(attacker_unit, "limited_item_track_system") then
		local projectile_extension = ScriptUnit.extension(attacker_unit, "projectile_system")
		attacker_unit = projectile_extension.owner_unit
	end

	return attacker_unit
end

AiUtils.unit_alive = function (unit)
	if not unit_alive(unit) then
		return false
	end

	local health_extension = ScriptUnit.has_extension(unit, "health_system")
	local is_alive = health_extension and health_extension:is_alive()

	return is_alive
end

AiUtils.unit_knocked_down = function (unit)
	if not unit_alive(unit) then
		return false
	end

	if not ScriptUnit.has_extension(unit, "status_system") then
		return false
	end

	local status_system = ScriptUnit.extension(unit, "status_system")
	local is_knocked_down = status_system:is_knocked_down()

	return is_knocked_down
end

AiUtils.position_is_on_large_navmesh = function (position, min_group_size, min_group_neighbour_count)
	local group = self.navigation_group_manager:get_group_from_position(target_pos)
	local group_area = (group and group:get_group_area()) or 0
	local group_neighbours_count = (group and #group:get_group_neighbours()) or 0
	local navmesh_is_large_enough = group_area > 30 and group_neighbours_count > 0
end

AiUtils.is_of_interest_to_packmaster = function (packmaster_unit, enemy_unit)
	if unit_alive(enemy_unit) then
		local status_extension = ScriptUnit.extension(enemy_unit, "status_system")
		local is_alive = ScriptUnit.extension(enemy_unit, "health_system"):is_alive()
		local is_knocked_down = status_extension:is_knocked_down()
		local is_pounced_down = status_extension:is_pounced_down()
		local grabbed = status_extension:is_grabbed_by_pack_master()
		local is_grabbed_by_other_pack_master = grabbed and status_extension:get_pack_master_grabber() ~= packmaster_unit
		local is_hanging = status_extension.pack_master_status == "pack_master_hanging"
		local is_using_transport = status_extension.using_transport
		local spawn_grace = status_extension.spawn_grace
		local ledge_hanging = status_extension.is_ledge_hanging
		local forbidden_target = status_extension.forbidden_target

		if is_alive and not is_knocked_down and not is_pounced_down and not is_grabbed_by_other_pack_master and not is_hanging and not is_using_transport and not spawn_grace and not ledge_hanging and not forbidden_target then
			return true
		end
	end

	return false
end

AiUtils.show_polearm = function (packmaster_unit, show)
	local item_inventory_index = 1
	local go_id = Managers.state.unit_storage:go_id(packmaster_unit)
	local network_manager = Managers.state.network

	if network_manager:game() then
		network_manager.network_transmit:send_rpc_all("rpc_ai_show_single_item", go_id, item_inventory_index, show)
	end
end

AiUtils.is_of_interest_to_gutter_runner = function (gutter_runner_unit, enemy_unit, blackboard, ignore_knocked_down)
	if not unit_alive(enemy_unit) then
		return
	end

	if blackboard.last_completed_pounce_target == enemy_unit and blackboard.last_completed_pounce_time + 10 < Managers.state.time:time("game") then
		return
	end

	local disabled_by_unit = blackboard.group_blackboard.disabled_by_special[enemy_unit]

	if disabled_by_unit and disabled_by_unit ~= gutter_runner_unit then
		return
	end

	local status_extension = ScriptUnit.extension(enemy_unit, "status_system")

	if status_extension.dead then
		return
	end

	if status_extension:is_knocked_down() and not ignore_knocked_down then
		return
	end

	if status_extension:is_grabbed_by_pack_master() then
		return
	end

	if status_extension:get_is_ledge_hanging() then
		return
	end

	if status_extension:is_pounced_down() and status_extension:get_pouncer_unit() ~= gutter_runner_unit then
		return
	end

	if status_extension.using_transport then
		return
	end

	if status_extension.spawn_grace or status_extension.ready_for_assisted_respawn then
		return
	end

	return true
end

AiUtils.stagger = function (unit, blackboard, attacker_unit, stagger_direction, stagger_length, stagger_type, stagger_duration, stagger_animation_scale, t)
	assert(stagger_type > 0, "Tried to use invalid stagger type %q", stagger_type)

	local difficulty_modifier = Managers.state.difficulty:get_difficulty_settings().stagger_modifier
	blackboard.pushing_unit = attacker_unit
	blackboard.stagger_direction = Vector3Box(stagger_direction)
	blackboard.stagger_length = stagger_length
	blackboard.stagger_time = stagger_duration * difficulty_modifier + t
	blackboard.stagger = (blackboard.stagger and blackboard.stagger + 1) or 1
	blackboard.stagger_type = stagger_type
	blackboard.stagger_animation_scale = stagger_animation_scale

	if unit ~= attacker_unit and ScriptUnit.has_extension(unit, "ai_system") then
		local ai_extension = ScriptUnit.extension(unit, "ai_system")

		if ai_extension.attacked then
			ai_extension:attacked(attacker_unit, t)
		end
	end
end

AiUtils.random = function (value1, value2)
	return value1 + Math.random() * (value2 - value1)
end

local MAX_TRIES = 10
local MIN_ANGLE_STEP = 4
local MAX_ANGLE_STEP = 8
local MIN_ANGLE = 0

AiUtils.advance_towards_target = function (unit, blackboard, min_distance, max_distance, min_angle_step, max_angle_step, min_angle, max_tries, direction, above, below)
	local target_unit = blackboard.target_unit

	if not AiUtils.unit_alive(target_unit) then
		return
	end

	local max_tries = MAX_TRIES
	local min_angle_step = min_angle_step or MIN_ANGLE_STEP
	local max_angle_step = max_angle_step or MAX_ANGLE_STEP
	local min_angle = min_angle or MIN_ANGLE
	local advance_towards_players = blackboard.advance_towards_players
	direction = direction or 1 - math.random(0, 1) * 2

	for j = 1, 2, 1 do
		for i = 1, max_tries, 1 do
			local angle = min_angle + math.random(min_angle_step * i, max_angle_step * i) * direction
			local position, wanted_distance = LocomotionUtils.outside_goal(blackboard.nav_world, unit, blackboard, min_distance, max_distance, angle, 3, above, below)

			if position then
				return position, wanted_distance, direction
			end
		end

		direction = -direction
	end

	return false
end

AiUtils.temp_anim_event = function (unit, anim, time)
	local category_name = "temp_anim_event"
	local head_node = Unit.node(unit, "c_head")
	local viewport_name = "player_1"
	local color_vector = Vector3(255, 0, 0)
	local offset_vector = Vector3(0, 0, 1)
	local text_size = 0.5
	local text = anim

	if time then
		text = anim .. ": " .. math.round_with_precision(time, 1)
	end

	Managers.state.debug_text:clear_unit_text(unit, category_name)
	Managers.state.debug_text:output_unit_text(text, text_size, unit, head_node, offset_vector, nil, category_name, color_vector, viewport_name)
end

AiUtils.clear_temp_anim_event = function (unit)
	local category_name = "temp_anim_event"

	Managers.state.debug_text:clear_unit_text(unit, category_name)
end

AiUtils.anim_event = function (unit, data, anim_event)
	if data.anim_event and data.anim_event == anim_event then
		return
	end

	Managers.state.network:anim_event(unit, anim_event)

	data.anim_event = anim_event
end

AiUtils.get_default_breed_move_speed = function (unit, blackboard)
	local move_speed = nil
	local breed = blackboard.breed

	if blackboard.is_passive then
		move_speed = breed.passive_walk_speed or breed.walk_speed
	else
		move_speed = breed.run_speed
	end

	return move_speed
end

AiUtils.clear_anim_event = function (data)
	data.anim_event = nil
end

AiUtils.set_default_anim_constraint = function (unit, constraint_target)
	local position = POSITION_LOOKUP[unit]
	local rotation = Unit.world_rotation(unit, 0)
	local rotation_forward = Quaternion.forward(rotation)
	local aim_target = position + rotation_forward * 5 + Vector3.up() * 1.25

	Unit.animation_set_constraint_target(unit, constraint_target, aim_target)
end

AiUtils.ninja_vanish_when_taking_damage = function (unit, blackboard)
	local damage_extension = ScriptUnit.extension(unit, "damage_system")
	local recent_damages, nr_damages = damage_extension:recent_damages()

	if nr_damages > 0 then
		if script_data.debug_ai_movement then
			local pos = position_lookup[unit]

			QuickDrawerStay:cylinder(pos, pos + Vector3(0, 0, 4), 0.3, Color(200, 0, 51), 20)
		end

		blackboard.ninja_vanish = true
	end
end

AiUtils.initialize_cost_table = function (navtag_layer_cost_table, allowed_layers)
	for layer_id, layer_name in ipairs(LAYER_ID_MAPPING) do
		local layer_cost = allowed_layers[layer_name]

		if layer_cost == 0 or layer_cost == nil then
			GwNavTagLayerCostTable.forbid_layer(navtag_layer_cost_table, layer_id)
		else
			GwNavTagLayerCostTable.allow_layer(navtag_layer_cost_table, layer_id)
			GwNavTagLayerCostTable.set_layer_cost_multiplier(navtag_layer_cost_table, layer_id, layer_cost)
		end
	end
end

AiUtils.kill_unit = function (victim_unit, attacker_unit, hit_zone_name, damage_type, damage_direction)
	local damage_amount = NetworkConstants.damage.max
	local attacker_unit = attacker_unit or victim_unit
	local hit_zone_name = hit_zone_name or "full"
	local damage_type = damage_type or "kinetic"
	local damage_direction = damage_direction or Vector3(0, 0, 1)
	local health = ScriptUnit.extension(victim_unit, "health_system"):current_health()

	for i = 1, math.ceil(health / damage_amount), 1 do
		DamageUtils.add_damage_network(victim_unit, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, "suicide")
	end
end

local DEFAULT_AGGRO_MULTIPLIERS = {
	ranged = 1,
	melee = 1,
	grenade = 1
}

AiUtils.update_aggro = function (unit, blackboard, breed, t, dt)
	local aggro_list = blackboard.aggro_list
	local damage_extension = ScriptUnit.extension(unit, "damage_system")
	local strided_array, array_length = damage_extension:recent_damages()
	local aggro_decay = dt * breed.perception_weights.aggro_decay_per_sec

	for enemy_unit, aggro in pairs(aggro_list) do
		aggro_list[enemy_unit] = math.clamp(aggro - aggro_decay, 0, 100)
	end

	local aggro_multipliers = breed.perception_weights.aggro_multipliers or DEFAULT_AGGRO_MULTIPLIERS

	if array_length > 0 then
		local stride = DamageDataIndex.STRIDE
		local index = 0

		for i = 1, array_length / stride, 1 do
			local attacker_unit = strided_array[index + DamageDataIndex.ATTACKER]
			local damage_amount = strided_array[index + DamageDataIndex.DAMAGE_AMOUNT]
			local damage_source = strided_array[index + DamageDataIndex.DAMAGE_SOURCE_NAME]
			local master_list_item = rawget(ItemMasterList, damage_source)

			if master_list_item then
				local slot_type = master_list_item.slot_type
				local multiplier = aggro_multipliers[slot_type] or 1
				damage_amount = damage_amount * multiplier
			end

			local aggro = aggro_list[attacker_unit]

			if aggro then
				aggro = aggro + damage_amount
				aggro_list[attacker_unit] = aggro
			else
				aggro_list[attacker_unit] = damage_amount
			end

			index = index + stride
		end
	end
end

AiUtils.debug_bot_transitions = function (gui, t, x1, y1)
	local tiny_font_size = 16
	local tiny_font = "gw_arial_16"
	local tiny_font_mtrl = "materials/fonts/" .. tiny_font
	local resx = RESOLUTION_LOOKUP.res_w
	local resy = RESOLUTION_LOOKUP.res_h
	local borderx = 20
	local bordery = 20
	local debug_win_width = 330
	local layer = 20
	x1 = x1 + borderx + 20
	y1 = y1 + bordery + 20
	local y2 = y1
	local completed_color = Colors.get_color_with_alpha("gray", 255)
	local running_color = Colors.get_color_with_alpha("lavender", 255)
	local unrun_color = Colors.get_color_with_alpha("sky_blue", 255)
	local header_color = Colors.get_color_with_alpha("orange", 255)

	ScriptGUI.ictext(gui, resx, resy, "BOT TRANSITIONS: ", tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 10, y2, layer, header_color)

	y2 = y2 + 20
	local players = Managers.player:human_and_bot_players()

	for k, player in pairs(players) do
		if player.bot_player then
			local unit = player.player_unit

			if unit_alive(unit) then
				local profile = SPProfiles[player.profile_index]
				local unit_name = profile and profile.unit_name
				local text = nil
				local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")
				local transitions = navigation_extension._active_nav_transitions
				local bot_text = "[" .. unit_name .. "]"

				ScriptGUI.ictext(gui, resx, resy, bot_text, tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 10, y2, layer, running_color)

				y2 = y2 + 20
				k = 1

				for t_unit, boxed_pos in pairs(transitions) do
					local s = string.format("    %d) %s", k, tostring(Unit.debug_name(t_unit)))

					ScriptGUI.ictext(gui, resx, resy, s, tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 10, y2, layer, unrun_color)

					y2 = y2 + 20
					k = k + 1
				end
			end
		end
	end

	y2 = y2 + 20

	ScriptGUI.icrect(gui, resx, resy, borderx, bordery, x1 + debug_win_width, y2, layer - 1, Color(200, 20, 20, 20))
end

AiUtils.allow_smart_object_layers = function (navigation_extension, status)
	navigation_extension:allow_layer("ledges", status)
	navigation_extension:allow_layer("ledges_with_fence", status)
	navigation_extension:allow_layer("doors", status)
	navigation_extension:allow_layer("planks", status)
	navigation_extension:allow_layer("jumps", status)
	navigation_extension:allow_layer("teleporters", status)
end

return
