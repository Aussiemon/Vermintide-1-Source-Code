require("scripts/flow/flow_callbacks_ai")
require("core/wwise/lua/wwise_flow_callbacks")
require("scripts/helpers/nav_tag_volume_utils")
require("scripts/settings/difficulty_settings")

local flow_return_table = Boot.flow_return_table

function flow_callback_define_spawn(params)
	return
end

function flow_callback_show_gdc_intro(params)
	local player = Managers.player:local_player(1)
	local player_unit = player.player_unit

	if player_unit and Unit.alive(player_unit) then
		local hud_extension = ScriptUnit.extension(player_unit, "hud_system")

		hud_extension:gdc_intro_active(true)
	end
end

function flow_callback_animation_callback(params)
	Managers.state.event:trigger("animation_callback", params.unit, params.callback, params.param1)
end

function flow_callback_enable_actor_draw(params)
	Managers.state.debug:enable_actor_draw(params.actor, params.color)
end

function flow_callback_disable_actor_draw(params)
	Managers.state.debug:disable_actor_draw(params.actor)
end

function flow_callback_set_start_area(params)
	Managers.state.entity:system("round_started_system"):set_start_area(params.volume_name)
end

function flow_callback_add_coop_spawn_point(params)
	Managers.state.spawn:flow_callback_add_spawn_point(params.unit)
end

function flow_callback_set_checkpoint(params)
	Managers.state.spawn:flow_callback_set_checkpoint(params.no_spawn_volume, params.safe_zone_volume, params.unit1, params.unit2, params.unit3, params.unit4)
end

function flow_callback_activate_spawning(params)
	return
end

function flow_callback_grimoire_destroyed(params)
	return
end

function flow_callback_tome_destroyed(params)
	return
end

function debug_print_random_values()
	local world = Application.main_world()
	local debug_table = World.get_data(world, "debug_level_seed")

	for _, debug in ipairs(debug_table) do
		print(debug)
	end
end

local function server_seeded_random(min, max, debug_name)
	local world = Application.flow_callback_context_world()
	local seed = World.get_data(world, "level_seed")

	fassert(seed, "Trying to use server seeded random without level seed being set. Is this attempted after level_loaded flow has been finished?")

	local new_seed, rnd = Math.next_random(seed, min, max)

	World.set_data(world, "level_seed", new_seed)

	if script_data.debug_server_seeded_random then
		local debug_table = World.get_data(world, "debug_level_seed")
		local index = #debug_table + 1
		debug_table[index] = string.format("%4.d:%s rnd: %f old seed: %d new seed: %d", index, tostring(debug_name), rnd, seed, new_seed)
	end

	return rnd
end

function flow_callback_query_server_seeded_random_int(params)
	local rnd = server_seeded_random(params.min or 0, params.max or 1, params.debug_name)
	flow_return_table.value = rnd

	return flow_return_table
end

function flow_callback_query_server_seeded_random_float(params)
	local min = params.min or 0
	local max = params.max or 1
	local rnd = server_seeded_random(nil, nil, params.debug_name)
	flow_return_table.value = min + rnd * (max - min)

	return flow_return_table
end

function flow_callback_server_seeded_randomize(params)
	local max = params.max or 8
	local rnd = server_seeded_random(1, max, params.debug_name)
	local ret = {
		[tostring(rnd)] = true
	}

	return ret
end

function flow_callback_randomize_sequential_numbers(params)
	local max = params.max
	local numbers = {}

	for j = 1, max, 1 do
		numbers[j] = j
	end

	for i = 1, 10, 1 do
		local random1 = server_seeded_random(1, max, params.debug_name)
		local random2 = server_seeded_random(1, max, params.debug_name)
		numbers[random2] = numbers[random1]
		numbers[random1] = numbers[random2]
	end

	local ret = {}

	for k = 1, max, 1 do
		ret[tostring(k)] = numbers[k]
	end

	return ret
end

function flow_callback_select_output_by_number(params)
	local num = params.num
	local output = params[tostring(num)]
	local ret = {
		["out_" .. tostring(output)] = true
	}

	return ret
end

local player_units = PLAYER_UNITS

function flow_query_number_of_active_players(params)
	local output_value = 0
	local num_player_units = #player_units

	for i = 1, num_player_units, 1 do
		local unit = player_units[i]
		local status_extension = ScriptUnit.extension(unit, "status_system")

		if not status_extension:is_disabled() then
			output_value = output_value + 1
		end
	end

	print("flow_query_number_of_active_players:", output_value)

	flow_return_table.value = output_value

	return flow_return_table
end

function flow_callback_play_music(params)
	Managers.music:trigger_event(params.event)
end

function flow_callback_idle_camera_dummy_spawned(params)
	local entity_manager = Managers.state.entity
	local camera_system = entity_manager:system("camera_system")

	camera_system:idle_camera_dummy_spawned(params.unit)
end

function flow_callback_pickup_gizmo_spawned(params)
	local entity_manager = Managers.state.entity
	local pickup_system = entity_manager:system("pickup_system")

	pickup_system:pickup_gizmo_spawned(params.unit)
end

function flow_callback_boss_gizmo_spawned(params)
	local conflict_director = Managers.state.conflict

	if conflict_director then
		conflict_director.level_analysis:boss_gizmo_spawned(params.unit)
	end
end

function flow_callback_respawn_unit_spawned(params)
	Managers.state.spawn.respawn_handler:respawn_unit_spawned(params.unit)
end

function flow_callback_activate_triggered_pickup_spawners(params)
	local entity_manager = Managers.state.entity
	local pickup_system = entity_manager:system("pickup_system")
	local spawned_unit = nil

	if Managers.player.is_server or LEVEL_EDITOR_TEST then
		spawned_unit = pickup_system:activate_triggered_pickup_spawners(params.triggered_spawn_id)
	end

	flow_return_table.spawned_pickup_unit = spawned_unit

	return flow_return_table
end

function flow_callback_hide_pickup(params)
	local units = Managers.state.entity:get_entities("ObjectivePickupTutorialExtension")

	for pickup_unit, pickup_extension in pairs(units) do
		local pickup_extension = ScriptUnit.extension(pickup_unit, "pickup_system")

		if pickup_extension.pickup_name == params.pickup_name and Unit.alive(pickup_unit) then
			Unit.set_unit_visibility(pickup_unit, false)
			Unit.flow_event(pickup_unit, "lua_hidden")
			Unit.set_data(pickup_unit, "interaction_data", "used", true)
			Unit.set_data(pickup_unit, "hide_marker", true)

			flow_return_table.hidden = true
		end
	end

	flow_return_table.hidden = false

	return flow_return_table
end

function flow_callback_hide_pickup_marker(params)
	local units = Managers.state.entity:get_entities("ObjectivePickupTutorialExtension")

	for pickup_unit, pickup_extension in pairs(units) do
		local pickup_extension = ScriptUnit.extension(pickup_unit, "pickup_system")

		if pickup_extension.pickup_name == params.pickup_name and Unit.alive(pickup_unit) then
			Unit.set_data(pickup_unit, "hide_marker", true)
		end
	end
end

function flow_query_wielded_weapon(params)
	local player_unit = params.player_unit
	local equipment = nil

	if ScriptUnit.has_extension(player_unit, "inventory_system") then
		local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
		equipment = inventory_extension:equipment()
	else
		equipment = Unit.get_data(player_unit, "equipment")
	end

	local right_hand_wielded_unit_3p = equipment.right_hand_wielded_unit_3p
	local right_hand_ammo_unit_3p = equipment.right_hand_ammo_unit_3p
	local right_hand_wielded_unit = equipment.right_hand_wielded_unit
	local right_hand_ammo_unit_1p = equipment.right_hand_ammo_unit_1p
	local left_hand_wielded_unit_3p = equipment.left_hand_wielded_unit_3p
	local left_hand_ammo_unit_3p = equipment.left_hand_ammo_unit_3p
	local left_hand_wielded_unit = equipment.left_hand_wielded_unit
	local left_hand_ammo_unit_1p = equipment.left_hand_ammo_unit_1p
	flow_return_table.righthandweapon3p = right_hand_wielded_unit_3p
	flow_return_table.righthandammo3p = right_hand_ammo_unit_3p
	flow_return_table.righthandweapon = right_hand_wielded_unit
	flow_return_table.righthandammo1p = right_hand_ammo_unit_1p
	flow_return_table.lefthandweapon3p = left_hand_wielded_unit_3p
	flow_return_table.lefthandammo3p = left_hand_ammo_unit_3p
	flow_return_table.lefthandweapon = left_hand_wielded_unit
	flow_return_table.lefthandammo1p = left_hand_ammo_unit_1p

	return flow_return_table
end

function flow_camera_shake(params)
	DamageUtils.camera_shake_by_distance(params.shake_name, Managers.time:time("game"), params.player_unit, params.shake_unit, params.near_distance, params.far_distance, params.near_shake_scale, params.far_shake_scale)
end

function flow_register_unit_extensions(params)
	local unit = params.unit
	local unit_template = Unit.get_data(unit, "unit_template")

	assert(unit_template)

	local world = Application.main_world()
	local extension_init_data = {
		navgraph_system = {
			nav_world = GLOBAL_AI_NAVWORLD
		}
	}

	Managers.state.unit_spawner:create_unit_extensions(world, unit, unit_template, extension_init_data)
end

function flow_callback_debug_print_unit_actor(params)
	print("FLOW DEBUG: Unit: ", tostring(params.unit), "Actor: ", tostring(params.actor))
end

function flow_callback_trigger_event(params)
	Unit.flow_event(params.unit, params.event)
end

function flow_callback_play_network_synched_particle_effect(params)
	local effect_name = params.effect
	local unit = params.unit
	local object_name = params.object
	local offset = params.offset or Vector3(0, 0, 0)
	local rotation_offset = params.rotation_offset or Quaternion.identity()
	local linked = params.linked or false
	local network_manager = Managers.state.network
	local game = network_manager:game()
	local game_object_id = unit and linked and network_manager:unit_game_object_id(unit)

	assert(game, "[flow_callback_play_network_synched_particle_effect] Trying to spawn effect with no network game running.")
	assert(not unit or not linked or game_object_id, "[flow_callback_play_network_synched_particle_effect] Trying to spawn effect linked to unit not network_synched.")
	assert(unit or not object_name, "[flow_callback_play_network_synched_particle_effect] Trying to spawn effect at object in unit without defining unit.")

	local object = (unit and object_name and Unit.node(unit, object_name)) or 0

	Managers.state.event:trigger("event_play_particle_effect", effect_name, unit, object, offset, rotation_offset, linked)

	if unit and not game_object_id then
		local global_transform = Unit.world_pose(unit, object)
		local local_transform = Matrix4x4.from_quaternion_position(rotation_offset, offset)
		local transform = Matrix4x4.multiply(local_transform, global_transform)
		offset = Matrix4x4.translation(transform)
		rotation_offset = Matrix4x4.rotation(transform)
	end

	if Managers.player.is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_play_particle_effect", NetworkLookup.effects[effect_name], game_object_id or 0, object, offset, rotation_offset, linked)
	else
		network_manager.network_transmit:send_rpc_server("rpc_play_particle_effect", NetworkLookup.effects[effect_name], game_object_id or 0, object, offset, rotation_offset, linked)
	end
end

function flow_callback_output_debug_screen_text(params)
	local text_size = params.text_size
	local time = params.time
	local color = params.color or Vector3(255, 255, 255)

	if not params.text_id then
		print("Missing text id at:", Script.callstack())

		return
	end

	Managers.state.debug_text:output_screen_text(Localize(params.text_id), text_size, time, color)
end

function flow_callback_debug_crash_game(params)
	if Application.crash then
		local crash_type = params.type or "access_violation"

		Application.crash(crash_type)
	end
end

function flow_callback_reload_level(params)
	if Managers.player.is_server then
		Managers.state.game_mode:retry_level()
	end
end

function flow_callback_complete_level(params)
	if Managers.player.is_server then
		Managers.state.game_mode:complete_level()
	end
end

function flow_callback_fail_level(params)
	if Managers.player.is_server then
		Managers.state.game_mode:fail_level()
	end
end

function flow_callback_menu_camera_dummy_spawned(params)
	Managers.state.event:trigger("menu_camera_dummy_spawned", params.camera_name, params.unit)
end

function flow_callback_menu_alignment_dummy_spawned(params)
	Managers.state.event:trigger("menu_alignment_dummy_spawned", params.alignment_name, params.unit)
end

function flow_callback_block_profile_menu_accept_button(params)
	local unit = params.unit
	local player = Managers.player:players()[Network.peer_id()]
	local player_unit = player.player_unit

	if Unit.alive(player_unit) and player_unit == unit then
		global_profile_view:block_accept_button(true)
	end
end

function flow_callback_unblock_profile_menu_accept_button(params)
	local unit = params.unit
	local player = Managers.player:players()[Network.peer_id()]
	local player_unit = player.player_unit

	if Unit.alive(player_unit) and player_unit == unit then
		global_profile_view:block_accept_button(false)
	end
end

function flow_callback_event_enable_level_select(params)
	Managers.state.event:trigger("event_enable_level_select")
end

function flow_callback_set_actor_enabled(params)
	local unit = params.unit

	assert(unit, "Set Actor Enabled flow node is missing unit")

	local actor = params.actor or Unit.actor(unit, params.actor_name)

	fassert(actor, "Set Actor Enabled flow node referring to unit %s is missing actor %s", tostring(unit), tostring(params.actor or params.actor_name))
	Actor.set_collision_enabled(actor, params.enabled)
	Actor.set_scene_query_enabled(actor, params.enabled)
end

function flow_callback_set_actor_kinematic(params)
	local unit = params.unit

	assert(unit, "Set Actor Kinematic flow node is missing unit")

	local actor = params.actor or Unit.actor(unit, params.actor_name)

	fassert(actor, "Set Actor Kinematic flow node referring to unit %s is missing actor %s", tostring(unit), tostring(params.actor or params.actor_name))
	Actor.set_kinematic(actor, params.enabled)
end

function flow_callback_spawn_actor(params)
	local unit = params.unit

	assert(unit, "Spawn Actor flow node is missing unit")

	local actor = params.actor_name

	Unit.create_actor(unit, actor)
end

function flow_callback_destroy_actor(params)
	local unit = params.unit

	assert(unit, "Destroy Actor flow node is missing unit")

	local actor = params.actor_name

	Unit.destroy_actor(unit, actor)
end

function flow_callback_set_actor_initial_velocity(params)
	local unit = params.unit

	assert(unit, "Set actor initial velocity has no unit")
	Unit.apply_initial_actor_velocities(unit, true)
end

function flow_callback_set_unit_material_variation(params)
	local unit = params.unit
	local material_variation = params.material_variation

	Unit.set_material_variation(unit, material_variation)
end

function flow_callback_setup_profiling_level_step_1()
	local mouse_fun = Mouse.pressed

	Mouse.pressed = function (button_index)
		if button_index == 0 then
			Mouse.pressed = mouse_fun

			return true
		else
			return false
		end
	end
end

function flow_callback_setup_profiling_level_step_2()
	local keyboard_fun = Keyboard.pressed

	Keyboard.pressed = function (button_index)
		if button_index == 120 then
			Keyboard.pressed = keyboard_fun

			return true
		else
			return false
		end
	end
end

function flow_callback_setup_profiling_level_step_3()
	local cameras = Managers.state.entity:system("cutscene_system")._cameras
	local profiling_camera = nil

	for camera_name, camera in pairs(cameras) do
		if camera_name == "profiling_camera" then
			profiling_camera = camera
		end
	end

	local unit = profiling_camera._unit
	local unit_pose = Unit.world_pose(unit, 0)
	local world = Application.main_world()
	local world_name = ScriptWorld.name(world)
	local viewport = ScriptWorld.global_free_flight_viewport(world, world_name)
	local free_flight_camera = ScriptViewport.camera(viewport)

	ScriptCamera.set_local_pose(free_flight_camera, unit_pose)
	Managers.state.event:trigger("force_close_ingame_menu")
end

function flow_callback_play_footstep_surface_material_effects(params)
	EffectHelper.flow_cb_play_footstep_surface_material_effects(params.effect_name, params.unit, params.object, params.foot_direction)
end

function flow_callback_play_surface_material_effect(params)
	local hit_unit = params.hit_unit
	local world = Unit.world(hit_unit)
	local sound_character, player_unit = nil
	local normal = params.normal
	local rotation = Quaternion.look(params.normal, Vector3.up())

	EffectHelper.play_surface_material_effects(params.effect_name, world, hit_unit, params.position, rotation, normal, sound_character, player_unit, params.husk)
end

function flow_callback_play_voice(params)
	local playing_unit = params.playing_unit
	local event_name = params.event_name
	local lol = math.random()
	local dialogue_input = ScriptUnit.has_extension_input(playing_unit, "dialogue_system")

	if dialogue_input then
		dialogue_input:play_voice(event_name)
	end
end

function flow_callback_foot_step(params)
	local unit = params.unit
end

function flow_callback_is_local_player(params)
	local unit = params.unit
	local player = Managers.player:players()[1]
	local player_unit = player.player_unit

	if Unit.alive(player_unit) then
		if unit == player_unit then
			flow_return_table.is_player = true
			flow_return_table.is_not_player = false
		else
			flow_return_table.is_player = false
			flow_return_table.is_not_player = true
		end
	else
		flow_return_table.is_player = false
		flow_return_table.is_not_player = true
	end

	return flow_return_table
end

function flow_callback_get_unit_type(params)
	local unit = params.unit
	local breed = Unit.get_data(unit, "breed")
	local bot = Unit.get_data(unit, "bot")

	if breed or bot then
		flow_return_table.is_local_player = false
		flow_return_table.is_remote_player = false
		flow_return_table.is_ai = true
		flow_return_table.is_environment = false
	else
		local player_unit = Managers.player:owner(unit)

		if player_unit ~= nil then
			if player_unit.remote then
				flow_return_table.is_local_player = true
				flow_return_table.is_remote_player = false
				flow_return_table.is_ai = false
				flow_return_table.is_environment = false
			else
				flow_return_table.is_local_player = false
				flow_return_table.is_remote_player = true
				flow_return_table.is_ai = false
				flow_return_table.is_environment = false
			end
		else
			flow_return_table.is_local_player = false
			flow_return_table.is_remote_player = false
			flow_return_table.is_ai = false
			flow_return_table.is_environment = true
		end
	end

	return flow_return_table
end

function flow_callback_trigger_sound(params)
	local wwise_world = nil

	if params.world_name then
		local world = Managers.world:world(params.world_name)
		wwise_world = Managers.world:wwise_world(world)
	else
		local world = Application.main_world()
		wwise_world = Managers.world:wwise_world(world)
	end

	if params.unit then
		if params.actor then
			WwiseWorld.trigger_event(wwise_world, params.event, param.use_occlusion, params.unit, Unit.actor(params.unit, params.actor))
		else
			WwiseWorld.trigger_event(wwise_world, params.event, param.use_occlusion, params.unit)
		end
	elseif params.position then
		WwiseWorld.trigger_event(wwise_world, params.event, param.use_occlusion, params.position)
	else
		WwiseWorld.trigger_event(wwise_world, params.event)
	end
end

function flow_callback_print_variable(params)
	print(params.string, params.variable)
end

function flow_callback_set_environment(params)
	local environment_name = params.environment_name
	local time = params.time

	Managers.state.event:trigger("set_environment", environment_name, time)
end

function flow_callback_start_bus_transition(params)
	Managers.music:start_bus_transition(params.bus_name, params.target_value, params.duration, params.transition_type, params.from_value)
end

function flow_callback_game_mode_event(params)
	local announcement = params.announcement
	local side = params.side
	local param_1 = params.param_1 or ""
	local param_2 = params.param_2 or ""

	Managers.state.game_mode:trigger_event("flow", announcement, side, param_1, param_2)
end

function flow_callback_thrown_projectile_bounce(params)
	local unit = params.unit

	if Unit.alive(unit) and ScriptUnit.has_extension(unit, "projectile_system") then
		local ext = ScriptUnit.extension(unit, "projectile_system")

		ext:flow_cb_bounce(params.hit_unit, params.hit_actor, params.position, params.normal)
	end
end

function flow_callback_mark_sack_for_linking(params)
	local unit = params.unit

	Unit.set_data(unit, "link_to_unit", true)
end

function flow_callback_remove_link_mark_for_sack(params)
	local unit = params.unit

	Unit.set_data(unit, "link_to_unit", nil)
end

function flow_callback_start_network_timer(params)
	if Managers.player.is_server then
		local time = params.time

		Managers.state.event:trigger("event_start_network_timer", time)
	end
end

function flow_callback_set_flow_object_set_enabled(params)
	assert(params.set, "[Flow Callback : Set Flow Object Set Enabled] No set set.")
	assert(params.enabled ~= nil, "[Flow Callback : Set Flow Object Set Enabled] No enabled set.")
	Managers.state.game_mode:flow_cb_set_flow_object_set_enabled(params.set, params.enabled)
end

flow_cb_set_flow_object_set_enabled = flow_callback_set_flow_object_set_enabled

function flow_callback_create_networked_flow_state(params)
	local created, out_value = Managers.state.networked_flow_state:flow_cb_create_state(params.unit, params.state_name, params.in_value, params.client_state_changed_event, params.client_hot_join_event)

	if created then
		flow_return_table.created = created
		flow_return_table.out_value = out_value

		return flow_return_table
	end
end

function flow_callback_change_networked_flow_state(params)
	local changed, out_value = Managers.state.networked_flow_state:flow_cb_change_state(params.unit, params.state_name, params.in_value)

	if changed then
		flow_return_table.changed = changed
		flow_return_table.out_value = out_value

		return flow_return_table
	end
end

function flow_callback_get_networked_flow_state(params)
	local out_value = Managers.state.networked_flow_state:flow_cb_get_state(params.unit, params.state_name)
	flow_return_table.out_value = out_value

	return flow_return_table
end

function flow_callback_client_networked_flow_state_changed(params)
	local out_value = Managers.state.networked_flow_state:flow_cb_get_state(params.unit, params.state_name)
	flow_return_table.changed = true
	flow_return_table.out_value = out_value

	return flow_return_table
end

function flow_callback_client_networked_flow_state_set(params)
	local out_value = Managers.state.networked_flow_state:flow_cb_get_state(params.unit, params.state_name)
	flow_return_table.set = true
	flow_return_table.out_value = out_value

	return flow_return_table
end

function flow_callback_create_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_create_story(params)
end

function flow_callback_networked_story_client_call(params)
	return Managers.state.networked_flow_state:flow_cb_networked_story_client_call(params)
end

function flow_callback_has_stopped_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_has_stopped_networked_story(params)
end

function flow_callback_has_played_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_has_played_networked_story(params)
end

function flow_callback_play_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_play_networked_story(params)
end

function flow_callback_stop_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_stop_networked_story(params)
end

function flow_callback_invert_bool(params)
	flow_return_table.out = true
	flow_return_table.out_value = not params.in_value

	return flow_return_table
end

function flow_callback_projectile_bounce(params)
	local unit = params.unit
	local touching_unit = params.touching_unit
	local position = params.position
	local normal = params.normal
	local separation_distance = params.separation_distance
	local impulse_force = params.impulse_force
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension:bounce(touching_unit, position, normal, separation_distance, impulse_force)
end

local temp = {}

function flow_callback_get_random_player(params)
	local players = Managers.player:human_and_bot_players()
	local unit_list = temp
	local unit_list_n = 0

	for index, player in pairs(players) do
		local unit = player.player_unit

		if Unit.alive(unit) and ScriptUnit.extension(unit, "health_system"):is_alive() then
			unit_list_n = unit_list_n + 1
			unit_list[unit_list_n] = unit
		end
	end

	if unit_list_n > 0 then
		local unit = unit_list[math.random(1, unit_list_n)]
		flow_return_table.playerunit = unit

		return flow_return_table
	end

	return nil
end

function flow_callback_trigger_dialogue_event(params)
	local unit = params.source

	if ScriptUnit.has_extension(unit, "dialogue_system") then
		local dialogue_input = ScriptUnit.extension_input(unit, "dialogue_system")
		local event_table = FrameTable.alloc_table()

		if params.argument1_name then
			event_table[params.argument1_name] = tonumber(params.argument1) or params.argument1
		end

		if params.argument2_name then
			event_table[params.argument2_name] = tonumber(params.argument2) or params.argument2
		end

		if params.argument3_name then
			event_table[params.argument3_name] = tonumber(params.argument3) or params.argument3
		end

		dialogue_input:trigger_dialogue_event(params.concept, event_table, params.identifier)
	else
		print(string.format("[flow_callback_trigger_dialogue_event] No extension found belonging to system \"dialogue_system\" for unit %s", tostring(unit)))
	end
end

function flow_callback_change_outline_params(params)
	local unit = params.unit

	assert(ScriptUnit.has_extension(unit, "outline_system"), "Trying to change outline params through flow without an outline extension on the unit")

	local outline_extension = ScriptUnit.extension(unit, "outline_system")
	local method = params.method
	local color = params.color

	if method then
		outline_extension.set_method(method)
	end

	if color then
		outline_extension.set_outline_color(color)
	end
end

function flow_callback_register_transport_navmesh_units(params)
	local unit = params.unit
	local start_unit = params.start_unit
	local end_unit = params.end_unit
	local transportation_extension = ScriptUnit.extension(unit, "transportation_system")

	transportation_extension:register_navmesh_units(start_unit, end_unit)
end

function flow_callback_start_transport(params)
	local interactable_unit = params.transport_unit
	local local_player = Managers.player:local_player()
	local interactor_unit = local_player.player_unit
	local transportation_extension = ScriptUnit.extension(interactable_unit, "transportation_system")

	transportation_extension:interacted_with(interactor_unit)
end

function flow_callback_enemies_on_transport(params)
	local unit = params.transport_unit
	local bounding_box_mesh_name = Unit.get_data(unit, "transportation_data", "bounding_box_mesh")
	local oobb_mesh_max_extent, oobb_pose, oobb_size = nil

	if bounding_box_mesh_name ~= "" then
		local mesh = Unit.mesh(unit, bounding_box_mesh_name)
		local _, size = Mesh.box(mesh)
		local max_extent = math.max(size.x, size.y, size.z)
		oobb_mesh_max_extent = max_extent
		oobb_pose, oobb_size = Mesh.box(mesh)
	end

	local ai_system = Managers.state.entity:system("ai_system")
	local ai_broadphase = ai_system.broadphase
	local position = Unit.world_position(unit, 0)
	local nearby_ai_units = FrameTable.alloc_table()
	local num_nearby_ai_units = Broadphase.query(ai_broadphase, position, oobb_mesh_max_extent + 1, nearby_ai_units)
	flow_return_table.no_enemies_on_transport = true

	for i = 1, num_nearby_ai_units, 1 do
		local u = nearby_ai_units[i]

		if AiUtils.unit_alive(u) then
			local u_pos = Unit.world_position(u, 0)
			local is_inside = math.point_is_inside_oobb(u_pos, oobb_pose, oobb_size)

			if is_inside then
				flow_return_table.no_enemies_on_transport = false
				flow_return_table.enemies_on_transport = true

				break
			end
		end
	end

	return flow_return_table
end

function flow_callback_all_humans_on_transport(params)
	local unit = params.transport_unit
	local bounding_box_mesh_name = Unit.get_data(unit, "transportation_data", "bounding_box_mesh")
	local oobb_mesh_max_extent, oobb_pose, oobb_size = nil

	if bounding_box_mesh_name ~= "" then
		local mesh = Unit.mesh(unit, bounding_box_mesh_name)
		local _, size = Mesh.box(mesh)
		local max_extent = math.max(size.x, size.y, size.z)
		oobb_mesh_max_extent = max_extent
		oobb_pose, oobb_size = Mesh.box(mesh)
	end

	local players = Managers.player:human_players()
	local unit_list = FrameTable.alloc_table()
	local unit_list_n = 0

	for index, player in pairs(players) do
		local player_unit = player.player_unit

		if Unit.alive(player_unit) and ScriptUnit.extension(player_unit, "health_system"):is_alive() and not ScriptUnit.extension(player_unit, "status_system"):is_disabled() then
			unit_list_n = unit_list_n + 1
			unit_list[unit_list_n] = player_unit
		end
	end

	flow_return_table.all_humans_on_transport = true

	for i = 1, unit_list_n, 1 do
		local u = unit_list[i]
		local u_pos = Unit.world_position(u, 0)
		local is_inside = math.point_is_inside_oobb(u_pos, oobb_pose, oobb_size)

		if not is_inside then
			flow_return_table.all_humans_on_transport = false
			flow_return_table.not_all_humans_on_transport = true

			break
		end
	end

	return flow_return_table
end

function flow_callback_set_door_state_and_duration(params)
	local unit = params.unit
	local new_door_state = params.new_door_state
	local frames = params.frames
	local speed = params.speed
	local door_extension = ScriptUnit.extension(unit, "door_system")

	door_extension:set_door_state_and_duration(new_door_state, frames, speed)
end

function flow_callback_door_animation_played(params)
	local unit = params.unit
	local frames = params.frames
	local speed = params.speed
	local door_extension = ScriptUnit.extension(unit, "door_system")

	door_extension:animation_played(frames, speed)
end

function flow_callback_set_valid_ai_target(params)
	local unit = params.unit
	local valid_target = params.valid_target
	local ai_slot_extension = ScriptUnit.extension(unit, "ai_slot_system")
	ai_slot_extension.valid_target = valid_target
end

function flow_callback_set_ai_aggro_modifier(params)
	local unit = params.unit
	local aggro_modifier = params.aggro_modifier
	local aggro_extension = ScriptUnit.extension(unit, "aggro_system")
	aggro_extension.aggro_modifier = aggro_modifier * -1
end

function flow_callback_objective_entered_socket_zone(params)
	print("[flow_callback_objective_entered_socket_zone]", params.socket_unit, params.objective_unit)

	if Managers.state.entity:system("mission_system"):has_mission("dwarf_interior_destroy_tunnels") then
		local fuse_time_left = Unit.get_data(params.objective_unit, "fuse_time_left")
		local statistics_db = Managers.player:statistics_db()
		local stats_id = Managers.player:local_player():stats_id()
		local current_fuse_time_left_when_socketed = statistics_db:get_stat(stats_id, "fuse_time_when_socketed")

		if fuse_time_left < current_fuse_time_left_when_socketed then
			statistics_db:set_stat(stats_id, "fuse_time_when_socketed", fuse_time_left)
		end
	end

	if Managers.player.is_server then
		local socket_unit = params.socket_unit
		local objective_unit = params.objective_unit
		local objective_socket_extension = ScriptUnit.extension(socket_unit, "objective_socket_system")

		objective_socket_extension:objective_entered_zone_server(objective_unit)
	end
end

function flow_callback_occupied_sockets_query(params)
	local socket_unit = params.socket_unit
	local objective_socket_extension = ScriptUnit.extension(socket_unit, "objective_socket_system")
	local num_closed_sockets = objective_socket_extension.num_closed_sockets
	flow_return_table.sockets = num_closed_sockets

	return flow_return_table
end

function flow_callback_register_environment_volume(params)
	local particle_light_intensity = params.particle_light_intensity or 1

	if params.shading_environment then
		Managers.state.event:trigger("register_environment_volume", params.volume_name, params.shading_environment, params.priority, params.blend_time, params.override_sun_snap, particle_light_intensity)
	end
end

function flow_callback_enable_environment_volume(params)
	fassert(params.volume_name, "[flow_callbacks] No volume name provided [required]")
	Managers.state.event:trigger("enable_environment_volume", params.volume_name, params.enable)
end

function flow_callback_volume_system_register_damage_volume(params)
	local volume_system = Managers.state.entity:system("volume_system")

	volume_system:register_volume(params.volume_name, "damage_volume", params)
end

function flow_callback_volume_system_register_movement_volume(params)
	local volume_system = Managers.state.entity:system("volume_system")

	volume_system:register_volume(params.volume_name, "movement_volume", params)
end

function flow_callback_volume_system_register_location_volume(params)
	local volume_system = Managers.state.entity:system("volume_system")
	local location_id = NetworkLookup.locations[params.location]

	volume_system:register_volume(params.volume_name, "location_volume", params)
end

function flow_callback_volume_system_register_trigger_volume(params)
	local volume_system = Managers.state.entity:system("volume_system")

	volume_system:register_volume(params.volume_name, "trigger_volume", params)
end

function flow_callback_volume_system_register_despawn_volume(params)
	local volume_system = Managers.state.entity:system("volume_system")

	volume_system:register_volume(params.volume_name, "despawn_volume", params)
end

function flow_callback_volume_system_unregister_volume(params)
	local volume_system = Managers.state.entity:system("volume_system")

	volume_system:unregister_volume(params.volume_name)
end

function flow_callback_intro_cutscene_show_location(params)
	assert(params.location, "No location set")

	local local_player = Managers.player:local_player()
	local player_unit = local_player.player_unit

	assert(Unit.alive(player_unit), "Tried showing location with no player unit spawned")

	local hud_extension = ScriptUnit.extension(player_unit, "hud_system")

	hud_extension:set_current_location(params.location)
end

function flow_callback_local_player_profile_switch(params)
	local player = Managers.player:local_player()
	local profile_index = player.profile_index
	local profile = SPProfiles[profile_index]
	local profile_name = profile.display_name
	local returns = {
		witch_hunter = profile_name == "witch_hunter",
		bright_wizard = profile_name == "bright_wizard",
		dwarf_ranger = profile_name == "dwarf_ranger",
		wood_elf = profile_name == "wood_elf",
		empire_soldier = profile_name == "empire_soldier"
	}

	return returns
end

function flow_callback_set_allowed_nav_tag_volume_layer(params)
	local layer_name = params.layer
	local allowed = params.allowed
	local ai_system = Managers.state.entity:system("ai_system")

	ai_system:set_allowed_layer(layer_name, allowed)
end

function flow_callback_register_sound_environment(params)
	local volume_name = params.volume_name
	local prio = params.prio
	local ambient_sound_event = params.ambient_sound_event
	local fade_time = params.fade_time
	local aux_bus_name = params.aux_bus_name
	local environment_state = params.environment_state
	local sound_environment_system = Managers.state.entity:system("sound_environment_system")

	sound_environment_system:register_sound_environment(volume_name, prio, ambient_sound_event, fade_time, aux_bus_name, environment_state)
end

function flow_callback_wwise_trigger_event_with_environment(params)
	local position = params.position
	local unit = params.unit
	local node_name = params.unit_node
	local event = params.name
	local existing_source_id = params.existing_source_id
	local use_occlusion = params.use_occlusion or false
	local sound_environment_system = Managers.state.entity:system("sound_environment_system")
	local wwise_world = sound_environment_system.wwise_world
	local source = nil

	if unit and node_name and node_name ~= "" then
		local node = Unit.node(unit, node_name)

		fassert(node, "Node %s doesn't exist in unit %s", unit, node_name)

		source = existing_source_id or WwiseWorld.make_auto_source(wwise_world, unit, node)
		position = Unit.world_position(unit, node)
	elseif unit then
		source = existing_source_id or WwiseWorld.make_auto_source(wwise_world, unit)
		position = Unit.world_position(unit, 0)
	elseif position then
		source = existing_source_id or Wwise.make_auto_source(wwise_world, unit)
	else
		fassert(false, "Missing unit or position in wwise trigger even with environment flow node in unit %s", unit)
	end

	sound_environment_system:set_source_environment(source, position)

	local id = WwiseWorld.trigger_event(wwise_world, event, use_occlusion, source)
	flow_return_table.playing_id = id
	flow_return_table.source_id = source

	return flow_return_table
end

function flow_callback_wwise_create_environment_sampled_source(params)
	local sound_environment_system = Managers.state.entity:system("sound_environment_system")
	local wwise_world = sound_environment_system.wwise_world
	local pos = params.position
	local unit = params.unit
	local node_name = params.unit_node
	local source = nil

	if unit and node_name and node_name ~= "" then
		node = Unit.node(unit, node_name)

		fassert(node, "Node %s doesn't exist in unit %s", unit, node_name)

		source = WwiseWorld.make_manual_source(wwise_world, unit, node)
		pos = Unit.world_position(unit, node)
	elseif unit then
		source = WwiseWorld.make_manual_source(wwise_world, unit)
		pos = Unit.world_position(unit, 0)
	elseif pos then
		source = WwiseWorld.make_manual_source(wwise_world, pos)
	else
		fassert(false, "Missing unit or position in wwise environment sampled source creation flow node in unit %s", unit)
	end

	sound_environment_system:set_source_environment(source, pos)

	flow_return_table.source_id = source

	return flow_return_table
end

function flow_callback_wwise_register_source_environment_update(params)
	assert(params.source_id, "Missing SourceId in \"Register source for environment sample update\"")
	assert(params.unit, "Missing Unit in \"Register source for environment sample update\"")

	local sound_environment_system = Managers.state.entity:system("sound_environment_system")

	sound_environment_system:register_source_environment_update(params.source_id, params.unit)
end

function flow_callback_wwise_unregister_source_environment_update(params)
	assert(params.source_id, "Missing SourceId in \"Unregister source for environment sample update\"")

	local sound_environment_system = Managers.state.entity:system("sound_environment_system")

	sound_environment_system:unregister_source_environment_update(params.source_id)
end

function flow_callback_clear_linked_projectiles(params)
	local unit = params.unit
	local projectile_linker_system = Managers.state.entity:system("projectile_linker_system")

	projectile_linker_system:clear_linked_projectiles(unit)
end

function flow_callback_activate_cutscene_camera(params)
	local transition = params.transition
	local transition_length = params.transition_length

	fassert(transition == "NONE" or transition_length ~= nil, "Transition Length must be set in flow node for cutscene camera with transition %q ", transition)

	local camera_unit = params.camera
	local transition_data = {
		transition = transition,
		transition_start_time = params.transition_start_time,
		transition_length = transition_length
	}
	local ingame_hud_enabled = not not params.ingame_hud_enabled
	local letterbox_enabled = not params.letterbox_disabled
	local cutscene_system = Managers.state.entity:system("cutscene_system")

	cutscene_system:flow_cb_activate_cutscene_camera(camera_unit, transition_data, ingame_hud_enabled, letterbox_enabled)
end

function flow_callback_deactivate_cutscene_cameras(params)
	local cutscene_system = Managers.state.entity:system("cutscene_system")

	cutscene_system:flow_cb_deactivate_cutscene_cameras()
end

function flow_callback_activate_cutscene_logic(params)
	local player_input_enabled = not not params.player_input_enabled
	local event_on_activate = params.event_on_activate
	local event_on_skip = params.event_on_skip
	local cutscene_system = Managers.state.entity:system("cutscene_system")

	cutscene_system:flow_cb_activate_cutscene_logic(player_input_enabled, event_on_activate, event_on_skip)
end

function flow_callback_deactivate_cutscene_logic(params)
	local event_on_deactivate = params.event_on_deactivate
	local cutscene_system = Managers.state.entity:system("cutscene_system")

	cutscene_system:flow_cb_deactivate_cutscene_logic(event_on_deactivate)
end

function flow_callback_cutscene_fx_fade(params)
	local cutscene_system = Managers.state.entity:system("cutscene_system")

	cutscene_system:flow_cb_cutscene_effect("fx_fade", params)
end

function flow_callback_cutscene_fx_text_popup(params)
	local cutscene_system = Managers.state.entity:system("cutscene_system")

	cutscene_system:flow_cb_cutscene_effect("fx_text_popup", params)
end

function flow_callback_start_mission(params)
	fassert(params.mission_name, "[flow_callback_start_mission] No mission name passed")

	local mission_system = Managers.state.entity:system("mission_system")

	mission_system:flow_callback_start_mission(params.mission_name, params.unit)
end

function flow_callback_update_mission(params)
	fassert(params.mission_name, "[flow_callback_update_mission] No mission name passed")

	local mission_system = Managers.state.entity:system("mission_system")

	mission_system:flow_callback_update_mission(params.mission_name)
end

function flow_callback_end_mission(params)
	fassert(params.mission_name, "[flow_callback_end_mission] No mission name passed")

	local mission_system = Managers.state.entity:system("mission_system")

	mission_system:flow_callback_end_mission(params.mission_name)
end

function flow_callback_show_health_bar(params)
	fassert(params.unit, "[flow_callback_show_health_bar] No unit passed")

	local tutorial_system = Managers.state.entity:system("tutorial_system")

	tutorial_system:flow_callback_show_health_bar(params.unit, params.show)
end

function flow_callback_spawn_tutorial_bot(params)
	local profile_index = params.profile_index

	Managers.state.entity:system("play_go_tutorial_system"):spawn_bot(profile_index)
end

function flow_callback_set_bot_ready_for_assisted_respawn(params)
	local unit = params.unit
	local respawn_unit = params.respawn_unit

	Managers.state.entity:system("play_go_tutorial_system"):set_bot_ready_for_assisted_respawn(unit, respawn_unit)
end

function flow_callback_enable_tutorial_player_ammo_refill(params)
	Managers.state.entity:system("play_go_tutorial_system"):enable_player_ammo_refill()
end

function flow_callback_remove_player_ammo(params)
	Managers.state.entity:system("play_go_tutorial_system"):remove_player_ammo()
end

function flow_callback_give_player_potion_from_bot(params)
	local player_unit = params.player_unit
	local bot_unit = params.bot_unit

	Managers.state.entity:system("play_go_tutorial_system"):give_player_potion_from_bot(player_unit, bot_unit)
end

function flow_callback_teleport_unit(params)
	local unit = params.unit
	local position = params.position
	local rotation = params.rotation

	Managers.state.entity:system("play_go_tutorial_system"):teleport_unit(unit, position, rotation)
end

function flow_callback_unspawn_all_ais(params)
	Managers.state.conflict:destroy_all_units()
end

function flow_query_slots_status(params)
	local player_unit = params.player_unit
	local equipment = nil

	if ScriptUnit.has_extension(player_unit, "inventory_system") then
		local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
		equipment = inventory_extension:equipment()
	end

	local slot_healthkit = equipment.slots.slot_healthkit
	local slot_grenade = equipment.slots.slot_grenade
	local slot_potion = equipment.slots.slot_potion
	flow_return_table.healthkit = slot_healthkit ~= nil
	flow_return_table.grenade = slot_grenade ~= nil
	flow_return_table.potion = slot_potion ~= nil

	return flow_return_table
end

function flow_callback_damage_player_bot_ai(params)
	if not Managers.player.is_server then
		return
	end

	local unit = params.unit
	local damage = params.damage

	if Unit.alive(unit) then
		fassert(ScriptUnit.has_extension(unit, "health_system"), "Tried to kill unit %s from flow but the unit has no health extension", unit)

		local health_extension = ScriptUnit.extension(unit, "health_system")

		health_extension:add_damage(damage)
	end
end

function flow_callback_get_health_player_bot_ai(params)
	if not Managers.player.is_server then
		return
	end

	local unit = params.unit
	local current_health = nil

	if Unit.alive(unit) then
		fassert(ScriptUnit.has_extension(unit, "health_system"), "Tried to get unit %s health from flow but the unit has no health extension", unit)

		local health_extension = ScriptUnit.extension(unit, "health_system")
		local status_extension = ScriptUnit.extension(unit, "status_system")

		if status_extension:is_knocked_down() or status_extension:is_ready_for_assisted_respawn() then
			current_health = 0
		else
			current_health = health_extension:current_health()
		end
	end

	flow_return_table.currenthealth = current_health

	return flow_return_table
end

function flow_callback_clear_slot(params)
	local player_unit = params.player_unit
	local slot_name = params.slot_name

	if ScriptUnit.has_extension(player_unit, "inventory_system") then
		local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")

		inventory_extension:destroy_slot(slot_name)
	end
end

function flow_callback_set_wwise_elevation_alignment(params)
	local elevation_offset = params.position.z
	local elevation_scale = params.scale
	local elevation_min = params.min
	local elevation_max = params.max

	Managers.state.camera:set_elevation_offset(elevation_offset, elevation_scale, elevation_min, elevation_max)
end

function flow_callback_kill_player_bot_ai(params)
	if not Managers.player.is_server then
		return
	end

	local unit = params.unit

	if Unit.alive(unit) then
		fassert(ScriptUnit.has_extension(unit, "health_system"), "Tried to kill unit %s from flow but the unit has no health extension", unit)

		local health_extension = ScriptUnit.extension(unit, "health_system")

		health_extension:die()
	end
end

function heal_overcharge_unit(unit, damage)
	local damage_extension = ScriptUnit.extension(unit, "damage_system")

	damage_extension:heal(unit, heal_amount, "wounded_degen")
end

function damage_overcharge_unit(unit, damage)
	local damage_extension = ScriptUnit.extension(unit, "damage_system")
	local hit_zone_name = "full"
	local attack_direction = Vector3(0, 0, 0)

	damage_extension:add_damage(unit, damage, hit_zone_name, "destructible_level_object_hit", attack_direction, "wounded_degen")
end

function flow_callback_overcharge_heal_unit(params)
	if not Managers.player.is_server then
		return
	end

	local unit = params.unit
	local health_added = params.health

	if Unit.alive(unit) then
		fassert(ScriptUnit.has_extension(unit, "health_system"), "Tried to heal overcharge unit %s from flow but the unit has no health extension", unit)

		local health_extension = ScriptUnit.extension(unit, "health_system")

		health_extension:add_heal(health_added)

		local unit_health = health_extension:current_health()
		local unit_damage = health_extension:current_damage()
		local level_index, is_level_unit = Managers.state.network:game_object_or_level_id(unit)

		Managers.state.network.network_transmit:send_rpc_clients("rpc_level_object_heal", level_index, health_added)

		flow_return_table.current_health = unit_health
		flow_return_table.current_damage = unit_damage

		return flow_return_table
	end
end

function flow_callback_overcharge_init_unit(params)
	local unit = params.unit
	local init_damage = params.init_damage

	if Unit.alive(unit) then
		fassert(ScriptUnit.has_extension(unit, "health_system"), "Tried to damage overcharge unit %s from flow but the unit has no health extension", unit)

		local health_extension = ScriptUnit.extension(unit, "health_system")

		health_extension:add_damage(init_damage)

		if not health_extension:is_alive() then
			print("flow_callback_overcharge_init_unit hack ", init_damage)
			damage_overcharge_unit(unit, init_damage)
		end
	end
end

function flow_callback_overcharge_sync_damage(params)
	local unit = params.unit
	local damage = params.damage
	local hit_zone_name = "full"
	local damage_extension = ScriptUnit.extension(unit, "damage_system")
	local attack_direction = Vector3(0, 0, 0)

	damage_extension:add_damage(unit, damage, hit_zone_name, "destructible_level_object_hit", attack_direction, NetworkLookup.damage_sources.wounded_degen)
end

function flow_callback_overcharge_damage_unit(params)
	if not Managers.player.is_server then
		return
	end

	local unit = params.unit
	local damage = params.damage

	if Unit.alive(unit) then
		fassert(ScriptUnit.has_extension(unit, "health_system"), "Tried to damage overcharge unit %s from flow but the unit has no health extension", unit)

		local health_extension = ScriptUnit.extension(unit, "health_system")

		health_extension:add_damage(damage)

		if not health_extension:is_alive() then
			print("flow_callback_overcharge_damage_unit hack", damage)
			damage_overcharge_unit(unit, damage)
		end

		local level_index, is_level_unit = Managers.state.network:game_object_or_level_id(unit)
		local hit_normal = Vector3(0, 0, 0)
		local damage_source_id = NetworkLookup.damage_sources.wounded_degen

		Managers.state.network.network_transmit:send_rpc_clients("rpc_level_object_damage", level_index, damage, hit_normal, damage_source_id)
	end
end

function flow_callback_overcharge_reset_unit(params)
	local unit = params.unit
	local max_health = params.maxhealth

	if Unit.alive(unit) then
		fassert(ScriptUnit.has_extension(unit, "health_system"), "Tried to reset health and damage on overcharge unit %s from flow but the unit has no health extension", unit)

		local health_extension = ScriptUnit.extension(unit, "health_system")

		health_extension:set_max_health(max_health)
		health_extension:set_current_damage(0)
	end
end

function flow_callback_trigger_explosion(params)
	if not Managers.player.is_server then
		return
	end

	local unit = params.unit
	local explosion_template_name = params.explosion_template_name

	assert(explosion_template_name, "Trigger Explosion unit flow node is missing explosion_template_name")

	local explosion_template = ExplosionTemplates[explosion_template_name]

	assert(explosion_template.explosion.level_unit_damage, "The explosion_template must have level_unit_damage set to true when using this flow node")

	local position = Unit.world_position(unit, 0)
	local rotation = Unit.world_rotation(unit, 0)
	local scale = 1
	local item_name = "grenade_frag_01"

	Managers.state.entity:system("damage_system"):create_explosion(unit, position, rotation, explosion_template_name, scale, item_name)
end

function flow_callback_enable_climb_unit(params)
	local unit = params.unit

	if Unit.alive(unit) then
		local nav_graph_system = Managers.state.entity:system("nav_graph_system")

		nav_graph_system:init_nav_graph_from_flow(unit)
	end
end

function flow_callback_limited_item_spawner_group_register(params)
	if not Managers.player.is_server then
		return
	end

	local group_name = params.name
	local pool_size = params.pool_size
	local start_active = params.start_active

	Managers.state.entity:system("limited_item_track_system"):register_group(group_name, pool_size)
end

function flow_callback_limited_item_spawner_group_decrease_pool_size(params)
	if not Managers.player.is_server then
		return
	end

	local group_name = params.name
	local pool_size = params.pool_size

	Managers.state.entity:system("limited_item_track_system"):decrease_group_pool_size(group_name, pool_size)
end

function flow_callback_limited_item_spawner_group_activate(params)
	if not Managers.player.is_server then
		return
	end

	local group_name = params.name
	local pool_size = params.pool_size

	Managers.state.entity:system("limited_item_track_system"):activate_group(group_name, pool_size)
end

function flow_callback_limited_item_spawner_group_deactivate(params)
	if not Managers.player.is_server then
		return
	end

	local group_name = params.name

	Managers.state.entity:system("limited_item_track_system"):deactivate_group(group_name)
end

function flow_callback_blood_collision(params)
	local touched_unit = params.unit
	local actor = params.actor
	local my_unit = Actor.unit(actor)
	local position = params.position
	local normal = params.normal
	local velocity = Actor.velocity(actor)
	local MAX_VELOCITY = 1000

	if MAX_VELOCITY < velocity.x or velocity.x < -MAX_VELOCITY or MAX_VELOCITY < velocity.y or velocity.y < -MAX_VELOCITY or MAX_VELOCITY < velocity.z or velocity.z < -MAX_VELOCITY then
		velocity = Vector3(0, 0, -1)
	end

	Managers.state.blood:add_blood_decal(touched_unit, actor, my_unit, position, normal, velocity)
end

function flow_callback_enable_poison_wind(params)
	local unit = params.unit
	local enable = params.enable
	local area_damage_system = Managers.state.entity:system("area_damage_system")

	area_damage_system:enable_area_damage(unit, enable)
end

function flow_callback_objective_unit_set_active(params)
	if not Managers.player.is_server then
		return
	end

	local unit = params.unit
	local extension = ScriptUnit.extension(unit, "tutorial_system")

	extension:set_active(params.active)
end

function flow_callback_umbra_set_gate_closed(params)
	local unit = params.unit
	local closed = params.closed
	local world = Unit.world(unit)

	World.umbra_set_gate_closed(world, unit, closed)
end

function flow_callback_check_progression_unlocked(params)
	local name = params.name
	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local can_use = ProgressionUnlocks.is_unlocked(name, level, prestige)

	if can_use then
		flow_return_table.is_unlocked = true
		flow_return_table.is_locked = false
	else
		flow_return_table.is_unlocked = false
		flow_return_table.is_locked = true
	end

	return flow_return_table
end

function flow_callback_trigger_dialogue_story(params)
	local unit = params.unit

	DialogueSystem:TriggerStoryDialogue(unit)
end

function flow_callback_trigger_cutscene_subtitles(params)
	local event_name = params.subtitle_event
	local speaker = params.speaker
	local hangtime = params.end_delay

	DialogueSystem:TriggerCutsceneSubtitles(event_name, speaker, hangtime)
end

function flow_callback_add_memory_time(params)
	local memory = params.memory
	local name = params.name
	local unit = params.unit
	local addition = params.addition

	DialogueSystem:AddMemoryTime(memory, name, unit, addition)
end

function flow_callback_reset_memory_time(params)
	local memory = params.memory
	local name = params.name
	local unit = params.unit

	DialogueSystem:ResetMemoryTime(memory, name, unit)
end

function flow_callback_damage_unit(params)
	if not Managers.player.is_server then
		return
	end

	local unit = params.unit
	local damage = params.damage

	if Unit.alive(unit) then
		fassert(ScriptUnit.has_extension(unit, "health_system"), "Tried to damage unit %s from flow but the unit has no health extension", unit)

		local health_extension = ScriptUnit.extension(unit, "health_system")

		health_extension:add_damage(damage)

		local unit_health = health_extension:current_health()
		local level_index, is_level_unit = Managers.state.network:game_object_or_level_id(unit)
		local hit_normal = Vector3(0, 0, 0)
		local damage_source_id = NetworkLookup.damage_sources.wounded_degen

		Managers.state.network.network_transmit:send_rpc_clients("rpc_level_object_damage", level_index, damage, hit_normal, damage_source_id)
	end
end

function flow_callback_get_current_inn_level_progression(params)
	local player_manager = Managers.player
	local statistics_db = player_manager:statistics_db()
	local server_player = Managers.player:server_player()

	if server_player then
		local stats_id = server_player:stats_id()
		local result = LevelUnlockUtils.current_act_progression_index(statistics_db, stats_id)
		flow_return_table.progression_step = result
	else
		flow_return_table.progression_step = 0
	end

	return flow_return_table
end

function flow_callback_get_completed_drachenfels_difficulty(params)
	local player_manager = Managers.player
	local statistics_db = player_manager:statistics_db()
	local server_player = Managers.player:server_player()

	if server_player then
		local levels = {
			"dlc_portals",
			"dlc_castle",
			"dlc_castle_dungeon"
		}
		local result = nil
		local stats_id = server_player:stats_id()

		for _, level_key in ipairs(levels) do
			local difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_key)

			if not result or difficulty_index < result then
				result = difficulty_index
			end
		end

		return {
			completed_difficulty = result
		}
	end

	return {
		completed_difficulty = 0
	}
end

function flow_callback_get_completed_dwarf_levels_difficulty(params)
	local player_manager = Managers.player
	local statistics_db = player_manager:statistics_db()
	local server_player = Managers.player:server_player()

	if server_player then
		local levels = {
			"dlc_dwarf_exterior",
			"dlc_dwarf_interior",
			"dlc_dwarf_beacons"
		}
		local result = nil
		local stats_id = server_player:stats_id()

		for _, level_key in ipairs(levels) do
			local difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_key)

			if not result or difficulty_index < result then
				result = difficulty_index
			end
		end

		return {
			completed_difficulty = result
		}
	end

	return {
		completed_difficulty = 0
	}
end

function flow_callback_get_completed_dlc_levels_difficulty(params)
	local dlc = params.dlc
	local player_manager = Managers.player
	local statistics_db = player_manager:statistics_db()
	local server_player = Managers.player:server_player()

	if server_player then
		local levels = DLCProgressionOrder[dlc]

		if levels then
			local result = nil
			local stats_id = server_player:stats_id()

			for _, level_key in ipairs(levels) do
				local difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_key)

				if not result or difficulty_index < result then
					result = difficulty_index
				end
			end

			return {
				completed_difficulty = result
			}
		end
	end

	return {
		completed_difficulty = 0
	}
end

function flow_callback_get_completed_game_difficulty(params)
	local player_manager = Managers.player
	local statistics_db = player_manager:statistics_db()
	local server_player = Managers.player:server_player()

	if server_player then
		local stats_id = server_player:stats_id()
		local result = LevelUnlockUtils.completed_adventure_difficulty(statistics_db, stats_id)

		return {
			completed_difficulty = result
		}
	end

	return {
		completed_difficulty = 0
	}
end

function flow_callback_get_completed_survival_waves(params)
	local player_manager = Managers.player
	local server_player = player_manager:server_player()
	local returns = {
		dlc_survival_ruins = 0,
		dlc_survival_magnus = 0
	}

	if server_player then
		local statistics_db = player_manager:statistics_db()
		local start_waves = SurvivalStartWaveByDifficulty
		local stats_id = server_player:stats_id()

		for level_key, _ in pairs(returns) do
			local hard = StatisticsUtil.get_survival_stat(statistics_db, level_key, "survival_hard", "waves", stats_id)

			if hard > 0 then
				hard = hard + start_waves.survival_hard
			end

			local harder = StatisticsUtil.get_survival_stat(statistics_db, level_key, "survival_harder", "waves", stats_id)

			if harder > 0 then
				harder = harder + start_waves.survival_harder
			end

			local hardest = StatisticsUtil.get_survival_stat(statistics_db, level_key, "survival_hardest", "waves", stats_id)

			if hardest > 0 then
				hardest = hardest + start_waves.survival_hardest
			end

			returns[level_key] = math.max(hard, harder, hardest)
		end
	end

	return returns
end

function flow_callback_override_level_progression_for_experience(params)
	local progression = params.progression

	fassert(progression >= 0 and progression <= 1, "Level progression needs to be a number between 0 and 1, not %d", progression)

	local mission_system = Managers.state.entity:system("mission_system")

	mission_system:override_percentage_completed(progression)
end

function flow_callback_start_fade(params)
	assert(params.unit, "[flow_callback_start_fade] You need to specify the Unit")
	assert(params.duration, "[flow_callback_start_fade] You need to specify duration")
	assert(params.fade_switch, "[flow_callback_start_fade] You need to specify whether to fade in or out (0 or 1)")

	local start_time = World.time(Application.main_world())
	local end_time = start_time + params.duration
	local fade_switch = math.floor(params.fade_switch + 0.5)
	local fade_switch_name = params.fade_switch_name or "fade_switch"
	local start_end_time_name = params.start_end_time_name or "start_end_time"
	local unit = params.unit
	local mesh = nil
	local mesh_name = params.mesh_name

	if mesh_name then
		assert(Unit.has_mesh(unit, mesh_name), string.format("[flow_callback_start_fade] The mesh %s doesn't exist in unit %s", mesh_name, tostring(unit)))

		mesh = Unit.mesh(unit, mesh_name)
	end

	local material = nil
	local material_name = params.material

	if mesh and material_name then
		assert(Mesh.has_material(mesh, material_name), string.format("[flow_callback_start_fade] The material %s doesn't exist for mesh %s", mesh_name, material_name))

		material = Mesh.material(mesh, material)
	end

	if mesh and material then
		Material.set_scalar(material, fade_switch_name, fade_switch)
		Material.set_vector2(material, start_end_time_name, Vector2(start_time, end_time))
	elseif mesh then
		local num_materials = Mesh.num_materials(mesh)

		for i = 0, num_materials - 1, 1 do
			local material = Mesh.material(mesh, i)

			Material.set_scalar(material, fade_switch_name, fade_switch)
			Material.set_vector2(material, start_end_time_name, Vector2(start_time, end_time))
		end
	elseif material then
		local num_meshes = Unit.num_meshes(unit)

		for i = 0, num_meshes - 1, 1 do
			local mesh = Unit.mesh(unit, i)

			if Mesh.has_material(mesh, material_name) then
				local material = Mesh.material(mesh, material_name)

				Material.set_scalar(material, fade_switch_name, fade_switch)
				Material.set_vector2(material, start_end_time_name, Vector2(start_time, end_time))
			end
		end
	else
		local num_meshes = Unit.num_meshes(unit)

		for i = 0, num_meshes - 1, 1 do
			local mesh = Unit.mesh(unit, i)
			local num_materials = Mesh.num_materials(mesh)

			for j = 0, num_materials - 1, 1 do
				local material = Mesh.material(mesh, j)

				Material.set_scalar(material, fade_switch_name, fade_switch)
				Material.set_vector2(material, start_end_time_name, Vector2(start_time, end_time))
			end
		end
	end
end

function flow_callback_mark_unit_for_deletion(params)
	if Managers.state.network.is_server and ScriptUnit.has_extension(params.unit, "death_system") then
		ScriptUnit.extension(params.unit, "death_system"):force_end()
	end
end

function flow_callback_breakable_object_destroyed(params)
	local unit = params.unit

	if Unit.alive(unit) then
		local is_destroyed = Unit.get_data(unit, "destroyed_dynamic")

		if is_destroyed then
			return
		end

		local statistics_db = Managers.player:statistics_db()
		local player = Managers.player:local_player()

		if not player then
			return
		end

		local stats_id = player:stats_id()

		statistics_db:increment_stat(stats_id, "dynamic_objects_destroyed")
		Unit.set_data(unit, "destroyed_dynamic", true)
	end
end

function flow_callback_add_subtitle(params)
	local speaker = params.speaker
	local subtitle = params.subtitle
	local hud_system = Managers.state.entity:system("hud_system")

	hud_system:add_subtitle(speaker, subtitle)
end

function flow_callback_remove_subtitle(params)
	local speaker = params.speaker
	local hud_system = Managers.state.entity:system("hud_system")

	hud_system:remove_subtitle(speaker)
end

function flow_callback_fade_in_game_logo(params)
	local fade_time = params.time
	local cutscene_system = Managers.state.entity:system("cutscene_system")

	if cutscene_system then
		cutscene_system:fade_game_logo(true, fade_time)
	end
end

function flow_callback_fade_out_game_logo(params)
	local fade_time = params.time
	local cutscene_system = Managers.state.entity:system("cutscene_system")

	if cutscene_system then
		cutscene_system:fade_game_logo(false, fade_time)
	end
end

function flow_callback_register_main_path_obstacle(params)
	local unit = params.unit
	local node = params.unit_node
	local position = Unit.world_position(unit, Unit.node(unit, node))
	local _, box_extents = Unit.box(unit)
	local radius_sq = Vector3.distance_squared(Vector3(0, 0, 0), box_extents)

	Managers.state.conflict:register_main_path_obstacle(Vector3Box(position), radius_sq)
end

function flow_callback_enter_post_game(params)
	local network_manager = Managers.state.network
	local network_server = network_manager.network_server

	if network_server then
		network_server:enter_post_game()
		print("flow_callback_enter_post_game")
	end
end

function flow_callback_level_unit_play_networked_animation_event(params)
	local unit = params.unit
	local event = params.event
	local animation_extension = ScriptUnit.extension(unit, "animation_system")

	animation_extension:play_animation_event(event)
end

function flow_callback_pub_brawl_enter_inn(params)
	local game_mode_manager = Managers.state.game_mode

	if game_mode_manager:pvp_enabled() then
		local world = Application.flow_callback_context_world()

		LevelHelper:flow_event(world, "pub_brawl_fetch_new_beer")
	end
end

function flow_callback_set_fall_height(params)
	local unit = params.unit

	if ScriptUnit.has_extension(unit, "status_system") then
		local status_extension = ScriptUnit.extension(unit, "status_system")

		status_extension:set_falling_height(true)
	end
end

function flow_query_settings_data(params)
	local setting = params.setting

	if not GameSettingsDevelopment then
		print("No GameSettingsDevelopment, running in editor")

		return
	end

	local output_value = GameSettingsDevelopment[setting]
	flow_return_table.value = output_value

	return flow_return_table
end

function flow_callback_survival_handler(params)
	assert(params.name, "[flow_callback_survival_handler] You need to specify the name of the waves preset found in survival settings")
	assert(SurvivalSettings[params.name], "Could not find the waves preset you specified, you sure it's the same as in survival settings?")

	local DEBUG = false
	local current_wave = SurvivalSettings.wave + 1
	local memory_table = SurvivalSettings.memory
	local templates = SurvivalSettings.templates
	local wave = SurvivalSettings[params.name].waves[current_wave]
	local event_chunk = nil
	local event_found = true
	local is_last_wave = false

	if wave ~= nil then
		for _, name in ipairs(wave) do
			local n = math.random(1, #templates[name])

			if memory_table[templates[name][n]] ~= true then
				memory_table[templates[name][n]] = true
				event_chunk = templates[name][n]
			else
				event_found = false

				for i = 1, #templates[name], 1 do
					if i ~= n then
						event_found = true
						memory_table[templates[name][i]] = true
						event_chunk = templates[name][i]

						break
					end
				end
			end
		end

		if wave.reset ~= nil then
			for _, name in ipairs(wave.reset) do
				if DEBUG then
					print("Reset: " .. name)
				end

				for i = 1, #templates[name], 1 do
					memory_table[templates[name][i]] = nil
				end
			end
		end

		if DEBUG then
			print("Current Wave: " .. current_wave)
			print("Running: " .. event_chunk)

			if event_found == false then
				print_warning("Could not find any available event, you don't have a high enough amount of events, or you don't reset the memory enough")
			end

			print("Current Memory start:")
			print(table.dump(memory_table))
			print("End")
		end

		if event_found and (Managers.player.is_server or LEVEL_EDITOR_TEST) then
			TerrorEventMixer.start_random_event(event_chunk)
		end
	end

	local return_wave = current_wave
	local total_waves = #SurvivalSettings[params.name].waves

	if current_wave >= #SurvivalSettings[params.name].waves then
		SurvivalSettings.memory = {}
		current_wave = SurvivalSettings.re_loop_wave
	end

	SurvivalSettings.wave = current_wave
	local returns = {
		current_wave = return_wave,
		total_num_waves = total_waves,
		last_wave = is_last_wave
	}

	return returns
end

function flow_callback_survival_handler_reset(params)
	local memory = {}
	local difficulty = params.difficulty
	local wave = SurvivalStartWaveByDifficulty[difficulty]
	SurvivalSettings.initial_wave = wave
	SurvivalSettings.wave = wave
	SurvivalSettings.memory = memory
	local returns = {
		initial_wave = wave + 1
	}

	return returns
end

function flow_callback_set_difficulty(params)
	Managers.state.difficulty:set_difficulty(params.difficulty)
end

function flow_callback_show_difficulty(params)
	assert(params.difficulty, "No difficulty set")

	local local_player = Managers.player:local_player()
	local player_unit = local_player.player_unit

	if Unit.alive(player_unit) then
		local hud_extension = ScriptUnit.extension(player_unit, "hud_system")

		hud_extension:set_current_location(Localize("dlc1_2_survival_difficulty_increase") .. " " .. Localize("difficulty_" .. params.difficulty))
	end
end

function flow_callback_get_difficulty(params)
	local difficulty_easy, difficulty_normal, difficulty_hard, difficulty_survival_hard, difficulty_harder, difficulty_hardest, difficulty_survival_harder, difficulty_survival_hardest = nil
	local getdifficulty = Managers.state.difficulty:get_difficulty()

	if getdifficulty == "easy" then
		difficulty_easy = true
	end

	if getdifficulty == "normal" then
		difficulty_normal = true
	end

	if getdifficulty == "hard" then
		difficulty_hard = true
	end

	if getdifficulty == "survival_hard" then
		difficulty_hard = true
	end

	if getdifficulty == "harder" then
		difficulty_harder = true
	end

	if getdifficulty == "survival_harder" then
		difficulty_survival_harder = true
	end

	if getdifficulty == "hardest" then
		difficulty_hardest = true
	end

	if getdifficulty == "survival_hardest" then
		difficulty_survival_hardest = true
	end

	flow_return_table.easy = difficulty_easy
	flow_return_table.normal = difficulty_normal
	flow_return_table.hard = difficulty_hard
	flow_return_table.survival_hard = difficulty_survival_hard
	flow_return_table.harder = difficulty_harder
	flow_return_table.survival_harder = difficulty_survival_harder
	flow_return_table.hardest = difficulty_hardest
	flow_return_table.survival_hardest = difficulty_survival_hardest
	flow_return_table.difficulty = getdifficulty

	return flow_return_table
end

function flow_callback_enable_end_level_area(params)
	local game_mode_manager = Managers.state.game_mode

	if game_mode_manager.is_server then
		local unit = params.unit
		local object = params.object
		local from = -params.left_back_down_extents
		local to = params.right_forward_up_extents

		game_mode_manager:activate_end_level_area(unit, object, from, to)
	end
end

function flow_callback_debug_end_level_area(params)
	local game_mode_manager = Managers.state.game_mode

	if game_mode_manager.is_server then
		local unit = params.unit
		local object = params.object
		local from = -params.left_back_down_extents
		local to = params.right_forward_up_extents

		game_mode_manager:debug_end_level_area(unit, object, from, to)
	end
end

function flow_callback_disable_end_level_area(params)
	local game_mode_manager = Managers.state.game_mode

	if game_mode_manager.is_server then
		game_mode_manager:disable_end_level_area(params.unit)
	end
end

function flow_callback_disable_lose_condition()
	Managers.state.game_mode:disable_lose_condition()
end

local RESULT_TABLE = {}

function flow_callback_broadphase_deal_damage(params)
	assert(Managers.state.network.is_server, "Only deal damage on server.")

	local hit_zone_name = "torso"
	local hit_ragdoll_actor = nil
	local pos = params.position
	local radius = params.radius
	local attacker_unit = params.attacker_unit
	local hazard_type = params.hazard_type
	local direction = nil

	if Unit.alive(attacker_unit) then
		local rot = Unit.world_rotation(attacker_unit, 0)
		local params_dir = params.direction
		direction = Quaternion.right(rot) * params_dir.x + Quaternion.forward(rot) * params_dir.y + Quaternion.up(rot) * params_dir.z
	else
		direction = params.direction
	end

	local hazard_settings = EnvironmentalHazards[hazard_type]

	if params.hits_enemies then
		local t = Managers.time:time("game")
		local attack_template = AttackTemplates[hazard_settings.enemy.attack_template_name]
		local num_hits = AiUtils.broadphase_query(pos, radius, RESULT_TABLE)

		for i = 1, num_hits, 1 do
			local unit = RESULT_TABLE[i]

			DamageUtils.server_apply_hit(t, attack_template, attacker_unit, unit, hit_zone_name, direction, hit_ragdoll_actor, hazard_type)
		end
	end

	local hits_human_players = params.hits_human_players
	local hits_bot_players = params.hits_bot_players

	if hits_human_players or hits_bot_players then
		local settings = hazard_settings.player
		local action_data = settings.action_data
		local damage = settings.difficulty_damage[Managers.state.difficulty:get_difficulty()]

		for _, player in pairs(Managers.player:players()) do
			local player_controlled = player:is_player_controlled()
			local unit = player.player_unit

			if (hits_bot_players and not player_controlled) or (hits_human_players and player_controlled and Unit.alive(unit) and Vector3.distance(pos, POSITION_LOOKUP[unit]) < radius) then
				local unit_position = POSITION_LOOKUP[unit]

				AiUtils.damage_target(unit, attacker_unit, action_data, damage, hazard_type)
			end
		end
	end
end

function flow_callback_broadphase_deal_damage_debug(params)
	local color = nil
	local hits_enemies = params.hits_enemies
	local hits_humans = params.hits_human_players
	local hits_bots = params.hits_bot_players

	if hits_enemies then
		QuickDrawerStay:sphere(params.position, params.radius, Color(255, 0, 0))
	end

	if hits_humans then
		QuickDrawerStay:sphere(params.position, params.radius + 0.01, Color(0, 255, 0))
	end

	if hits_bots then
		QuickDrawerStay:sphere(params.position, params.radius + 0.02, Color(0, 0, 255))
	end
end

function flow_callback_set_particles_light_intensity_exponent(params)
	local exp = params.exponent
	local id = pararms.id
	local world = Application.flow_callback_context_world()

	World.set_particles_light_intensity_exponent(world, id, exp)
end

function flow_callback_set_camera_far_range(params)
	local world_name = params.world_name
	local viewport_name = params.viewport_name
	local far_range = params.far_range
	local world = Managers.world:world(world_name)

	fassert(world, "[flow_callback_set_camera_far_range] There is currently no world called %s", world_name)

	local viewport = World.get_data(world, "viewports")[viewport_name]

	fassert(world, "[flow_callback_set_camera_far_range] There is currently no viewport called %s in world %s", viewport_name, world_name)
	fassert(far_range, "[flow_callback_set_camera_far_range] No far range provided", far_range)

	local camera = ScriptViewport.camera(viewport)

	Camera.set_data(camera, "far_range", far_range)
end

function flow_callback_barrel_explode(params)
	local unit = params.unit
	local health_extension = ScriptUnit.extension(unit, "health_system")
	local damage_extension = ScriptUnit.extension(unit, "damage_system")

	health_extension:set_max_health(1)
	damage_extension:add_damage(unit, 1, "full", "grenade", Vector3(1, 0, 0))
end

function flow_callback_set_game_mode_variable(params)
	local variable = params.variable
	local value = params.value
	local game_mode = Managers.state.game_mode:game_mode()
	game_mode[variable] = value
end

function flow_callback_print_callstack(params)
	return
end

function flow_callback_increment_goal_mission_data_counter(params)
	if not Managers.state.network.is_server then
		return
	end

	local mission_name = params.mission_name
	local value = params.value

	Managers.state.entity:system("mission_system"):flow_callback_increment_goal_mission_data_counter(mission_name, value)
end

function flow_callback_get_grey_seer_unit(params)
	local spawned_grey_seers = Managers.state.conflict:spawned_units_by_breed("skaven_grey_seer")
	local num_spawned_grey_seers = table.size(spawned_grey_seers)

	assert(num_spawned_grey_seers <= 1)

	local grey_seer_unit = next(spawned_grey_seers)
	flow_return_table.grey_seer_unit = grey_seer_unit

	return flow_return_table
end

function flow_callback_disable_facial_anim(params)
	local unit = params.unit

	if Unit.has_data(unit, "enemy_dialogue_face_anim") then
		Unit.set_data(unit, "enemy_dialogue_face_anim", nil)
	end
end

function flow_callback_teleporter(params)
	local teleporter_unit = params.unit
	local unit = params.touching_unit
	local entrance_node = params.entrance_node
	local exit_node = params.exit_node
	local exit_node_index = Unit.node(teleporter_unit, exit_node)
	local entrance_node_index = Unit.node(teleporter_unit, entrance_node)
	local exit_position = Unit.world_position(teleporter_unit, exit_node_index)
	local entrance_node_rotation = Unit.world_rotation(teleporter_unit, entrance_node_index)
	local exit_node_rotation = Unit.world_rotation(teleporter_unit, exit_node_index)
	local network_manager = Managers.state.network

	if Unit.alive(unit) then
		local local_player = Managers.player:local_player()
		local player_unit = local_player.player_unit

		if unit == player_unit then
			if ScriptUnit.has_extension(unit, "locomotion_system") then
				local locomotion = ScriptUnit.extension(unit, "locomotion_system")
				local status_extension = ScriptUnit.extension(unit, "status_system")
				local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
				local unit_rotation = first_person_extension:current_rotation()
				local entrance_forward = Quaternion.forward(entrance_node_rotation)
				local entrance_right = Quaternion.right(entrance_node_rotation)
				local unit_forward = Quaternion.forward(unit_rotation)
				entrance_forward = Vector3.flat(entrance_forward)
				entrance_right = Vector3.flat(entrance_right)
				unit_forward = Vector3.flat(unit_forward)
				entrance_forward = Vector3.normalize(entrance_forward)
				entrance_right = Vector3.normalize(entrance_right)
				unit_forward = Vector3.normalize(unit_forward)
				local forward_dot = Vector3.dot(unit_forward, entrance_forward)
				local angle = math.acos(forward_dot)
				local right_dot = Vector3.dot(unit_forward, entrance_right)

				if right_dot > 0 then
					angle = -angle
				end

				local new_rotation = Quaternion(Vector3.up(), angle)
				local new_exit_rotation = Quaternion.multiply(exit_node_rotation, new_rotation)
				local new_exit_rotation_flip = Quaternion.multiply(new_exit_rotation, Quaternion.axis_angle(Vector3.up(), math.pi))

				locomotion:teleport_to(exit_position, new_exit_rotation_flip)
				status_extension:reset_falling_height()
			end

			flow_return_table.player_ported = true
		end

		if ScriptUnit.has_extension(unit, "projectile_system") then
		end

		local bot = Unit.get_data(unit, "bot")

		if bot then
			local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

			navigation_extension:teleport(exit_position)
		end

		if DamageUtils.is_enemy(unit) and ScriptUnit.has_extension(unit, "ai_navigation_system") and ScriptUnit.has_extension(unit, "locomotion_system") then
			local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")
			local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

			navigation_extension:set_navbot_position(exit_position)
			locomotion_extension:teleport_to(exit_position)
		end

		if not ScriptUnit.has_extension(unit, "projectile_system") and not ScriptUnit.has_extension(unit, "locomotion_system") and not DamageUtils.is_enemy(unit) then
			local num_actors = Unit.num_actors(unit)

			print(num_actors)

			for i = 2, num_actors, 1 do
				print(Unit.actor(unit, i))

				local actor = Unit.actor(unit, i)

				if actor ~= nil then
					Actor.teleport_position(actor, Vector3(exit_position.x, exit_position.y, unit_entry_position.z))
				end
			end
		end

		return flow_return_table
	end
end

function flow_callback_register_level_effects_volume(params)
	local volume_name = params.volume_name
	local prio = params.prio
	local particles_action = params.particles_action
	local screen_particles_action = params.screen_particles_action
	local camera_manager = Managers.state.camera

	camera_manager:register_level_effects_volume(volume_name, prio, particles_action, screen_particles_action)
end

function flow_callback_unregister_level_effects_volume(params)
	local volume_name = params.volume_name
	local camera_manager = Managers.state.camera

	camera_manager:unregister_level_effects_volume(volume_name)
end

function flow_callback_enforce_player_positions(params)
	if not Managers.player.is_server then
		print("flow_callback_enforce_player_positions() run on client, doing nothing")

		return
	end

	local volume_name = params.volume_name
	local force = params.force
	local inside = nil

	if force == "inside" then
		inside = true
	elseif force == "outside" then
		inside = false
	else
		fassert(false, "Trying to enforce players position with unknown state %s", tostring(force))
	end

	local world = Application.flow_callback_context_world()
	local level = LevelHelper:current_level(world)
	local player_manager = Managers.player
	local damage_system = Managers.state.entity:system("damage_system")
	local valid_position = nil

	for i, unit in pairs(PLAYER_UNITS) do
		local pos = PLAYER_POSITIONS[i]
		local pos_ok = Level.is_point_inside_volume(level, volume_name, pos) == inside

		if pos_ok then
			valid_position = pos
		else
			local status_ext = ScriptUnit.extension(unit, "status_system")

			if status_ext:is_disabled() and not status_ext:is_ready_for_assisted_respawn() and not status_ext:is_dead() then
				damage_system:suicide(unit)
			end
		end
	end

	for i, unit in pairs(PLAYER_AND_BOT_UNITS) do
		local owner = player_manager:owner(unit)

		if owner and not owner:is_player_controlled() then
			local pos = PLAYER_AND_BOT_POSITIONS[i]
			local pos_ok = Level.is_point_inside_volume(level, volume_name, pos) == inside

			if not pos_ok then
				local status_ext = ScriptUnit.extension(unit, "status_system")
				local disabled = status_ext:is_disabled()
				local in_respawn = status_ext:is_ready_for_assisted_respawn()
				local dead = status_ext:is_dead()

				if disabled and not in_respawn and not dead then
					damage_system:suicide(unit)
				elseif not in_respawn and not dead and valid_position then
					local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
					local current_rotation = locomotion_extension:current_rotation()

					locomotion_extension:teleport_to(valid_position, current_rotation)
				end
			end
		end
	end

	if valid_position then
		Managers.state.spawn:teleport_despawned_players(valid_position)
	end
end

function flow_callback_start_level(params)
	if Managers.player.is_server then
		local level_name = params.level_name

		fassert(level_name, "[flow_callback_start_level] No level provided")
		Managers.state.game_mode:start_specific_level(level_name)
	end
end

function flow_callback_set_savedata_boolean(params)
	local variable_name = params.variable_name
	local variable_value = params.variable_value
	local instant_save = params.instant_save
	local flow_level_data = PlayerData.flow_level_data or {}
	flow_level_data[variable_name] = variable_value
	PlayerData.flow_level_data = flow_level_data

	if instant_save then
		Managers.save:auto_save(SaveFileName, SaveData, nil)
	end
end

function flow_callback_get_savedata_boolean(params)
	local flow_level_data = PlayerData.flow_level_data or {}
	local variable_name = params.variable_name
	local variable_value = flow_level_data[variable_name] or false

	if variable_value then
		flow_return_table.is_true = true
		flow_return_table.is_false = false
	else
		flow_return_table.is_true = false
		flow_return_table.is_false = true
	end

	return flow_return_table
end

return
