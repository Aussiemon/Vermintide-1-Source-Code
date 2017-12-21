if Application.platform() == "win32" then
	require("scripts/helpers/debug_helper")
end

require("scripts/settings/backend_settings")

CONSOLE_DISABLED_INTERACTIONS = CONSOLE_DISABLED_INTERACTIONS or {}

if Application.platform() ~= "win32" then
	CONSOLE_DISABLED_INTERACTIONS = {
		altar_access = true,
		quest_access = true
	}
end

if Application.platform() == "xb1" then
	Application.warning("Unlocking all levels for Lite Optional Cert")

	script_data.unlock_all_levels = true
end

GameSettingsDevelopment = GameSettingsDevelopment or {}
local argv = {
	Application.argv()
}
IS_DEMO = false
GameSettingsDevelopment.use_leaderboards = false
GameSettingsDevelopment.lorebook_enabled = true
GameSettingsDevelopment.trunk_path = GameSettingsDevelopment.trunk_path or false
GameSettingsDevelopment.quicklaunch_params = GameSettingsDevelopment.quicklaunch_params or {}
GameSettingsDevelopment.quicklaunch_params.level_key = (LEVEL_EDITOR_TEST and "editor_level") or "castle_01"
GameSettingsDevelopment.start_state = (LEVEL_EDITOR_TEST and "game") or "menu"

if Application.platform() == "win32" then
	GameSettingsDevelopment.skip_start_screen = true
end

GameSettingsDevelopment.disable_shadow_lights_system = true
GameSettingsDevelopment.use_baked_enemy_meshes = false
GameSettingsDevelopment.help_screen_enabled = false
GameSettingsDevelopment.lobby_browser_enabled = true
local network_timeout = 60

if Development.parameter("network_timeout_really_long") then
	network_timeout = 10000
end

if Development.parameter("network_timeout") and not Development.parameter("network_timeout") then
end

GameSettingsDevelopment.network_timeout = network_timeout
GameSettingsDevelopment.show_version_info = true
GameSettingsDevelopment.default_environment = "environment/blank"
GameSettingsDevelopment.debug_outlines = false
GameSettingsDevelopment.lowest_resolution = 600
GameSettingsDevelopment.allow_ranged_attacks_to_damage_props = false
GameSettingsDevelopment.release_levels_only = true
GameSettingsDevelopment.use_engine_optimized_ai_locomotion = true
local script_data = script_data
script_data.debug_behaviour_trees = (script_data.debug_behaviour_trees ~= nil and script_data.debug_behaviour_trees) or false

if Application.platform() == "win32" then
	GameSettingsDevelopment.use_backend = not Development.parameter("use_local_backend")
else
	GameSettingsDevelopment.use_backend = false
end

GameSettingsDevelopment.backend_settings = BackendSettings.beta2
GameSettingsDevelopment.disable_intro_trailer = false
GameSettingsDevelopment.use_new_pickup_spawning = true
GameSettingsDevelopment.fade_environments = true
GameSettingsDevelopment.app_ids = {
	beta = 252650,
	beta2 = 393760,
	main = 235540
}
script_data.debug_enabled = true

if Development.parameter("gdc") then
	GameSettingsDevelopment.use_backend = false

	if not Development.parameter("force_debug_enabled") or Development.parameter("force_debug_disabled") then
		script_data.debug_enabled = false
	end
end

if Application.platform() == "xb1" and Application.build() == "public_dev" then
	script_data.debug_enabled = false
end

if Development.parameter("force_debug_disabled") then
	script_data.debug_enabled = false
end

local settings = script_data.settings

if settings.steam or Development.parameter("force_steam") then
	GameSettingsDevelopment.network_mode = "steam"

	if rawget(_G, "Steam") then
		local app_id = Steam.app_id()

		if not Steam.owns_app(app_id) then
			Application.quit_with_message("Warhammer: End Times - Vermintide. You need to own game to play it.")
		end

		if app_id == GameSettingsDevelopment.app_ids.main or app_id == GameSettingsDevelopment.app_ids.beta or app_id == GameSettingsDevelopment.app_ids.beta2 then
			if app_id == GameSettingsDevelopment.app_ids.main then
				GameSettingsDevelopment.beta = true
				GameSettingsDevelopment.backend_settings = BackendSettings.main
			elseif app_id == GameSettingsDevelopment.app_ids.beta then
				GameSettingsDevelopment.beta = true
				GameSettingsDevelopment.backend_settings = BackendSettings.beta
			elseif app_id == GameSettingsDevelopment.app_ids.beta2 then
				GameSettingsDevelopment.beta = true
				GameSettingsDevelopment.backend_settings = BackendSettings.beta2
			end

			GameSettingsDevelopment.show_version_info = true
			GameSettingsDevelopment.show_fps = Development.parameter("show_fps") or false
		end
	else
		Application.quit_with_message("Warhammer: End Times - Vermintide. You need to have the Steam Client running to play the game.")
	end
elseif Application.platform() == "ps4" then
	if Application.build() == "dev" or Application.build() == "debug" or Application.build() == "public_dev" then
		GameSettingsDevelopment.backend_settings = BackendSettings.ps4
		GameSettingsDevelopment.network_mode = (LEVEL_EDITOR_TEST and "lan") or "lan"
	end

	GameSettingsDevelopment.show_fps = true
elseif Application.platform() == "xb1" then
	if Application.build() == "dev" or Application.build() == "debug" or Application.build() == "public_dev" then
		GameSettingsDevelopment.backend_settings = BackendSettings.xb1
		GameSettingsDevelopment.network_mode = (LEVEL_EDITOR_TEST and "lan") or "lan"
	end

	if Application.build() == "public_dev" then
		GameSettingsDevelopment.show_version_info = false
		GameSettingsDevelopment.show_fps = false
	else
		GameSettingsDevelopment.show_fps = true
	end
elseif Application.build() == "dev" or Application.build() == "debug" then
	GameSettingsDevelopment.network_mode = (LEVEL_EDITOR_TEST and "lan") or (Development.parameter("force_steam") and "steam") or "lan"
	GameSettingsDevelopment.show_fps = Development.parameter("show_fps") == nil or Development.parameter("show_fps")
	script_data.unlock_all_levels = Development.parameter("unlock-all-levels")
	script_data.dont_give_all_lan_backend_items = Development.parameter("dont-give-all-lan-backend-items")
else
	print("Running release game without content revision, quitting.")
	Application.quit()
end

GameSettingsDevelopment.disable_crafting = Development.parameter("disable-crafting")
GameSettingsDevelopment.disable_free_flight = Development.parameter("disable-free-flight") or Application.build() == "release"

if Development.parameter("quests_enabled") ~= nil then
	GameSettingsDevelopment.backend_settings.quests_enabled = Development.parameter("quests_enabled")
end

GameSettingsDevelopment.local_telemetry_test = false and Development.parameter("local-telemetry-test")
GameSettingsDevelopment.use_telemetry = rawget(_G, "Curl") and Development.parameter("use-telemetry") and ((rawget(_G, "Steam") and GameSettingsDevelopment.network_mode == "steam") or GameSettingsDevelopment.local_telemetry_test)
GameSettingsDevelopment.use_session_survey = GameSettingsDevelopment.use_telemetry and Development.parameter("use-session-survey")
GameSettingsDevelopment.use_tech_telemetry = GameSettingsDevelopment.use_telemetry and Development.parameter("use-tech-telemetry")
GameSettingsDevelopment.telemetry_log_interval = GameSettingsDevelopment.use_telemetry and Development.parameter("telemetry-log-interval")
GameSettingsDevelopment.telemetry_sessions_mod = GameSettingsDevelopment.use_telemetry and Development.parameter("telemetry-sessions-mod")
GameSettingsDevelopment.telemetry_whitelist = GameSettingsDevelopment.use_telemetry and Development.parameter("telemetry-whitelist")
GameSettingsDevelopment.telemetry_base_url = "ftp.fatshark.se/pub/bulldozer/telemetry/"
GameSettingsDevelopment.telemetry_compress_data = true
GameSettingsDevelopment.telemetry_auth_type = "none"

if Application.platform() == "xb1" then
	GameSettingsDevelopment.network_port = 0
else
	GameSettingsDevelopment.network_port = 10003
end

GameSettingsDevelopment.editor_lobby_port = 10004
GameSettingsDevelopment.lobby_max_members = 4
GameSettingsDevelopment.network_revision_check_enabled = false
GameSettingsDevelopment.use_high_quality_fur = Application.user_setting("use_high_quality_fur")

if GameSettingsDevelopment.use_high_quality_fur == nil then
	GameSettingsDevelopment.use_high_quality_fur = true
end

GameSettingsDevelopment.use_physic_debris = Application.user_setting("use_physic_debris")

if GameSettingsDevelopment.use_physic_debris == nil then
	GameSettingsDevelopment.use_physic_debris = true
end

GameSettingsDevelopment.bone_lod_husks = GameSettingsDevelopment.bone_lod_husks or {}
GameSettingsDevelopment.bone_lod_husks.lod_out_range_sq = 64
GameSettingsDevelopment.bone_lod_husks.lod_in_range_sq = 49
GameSettingsDevelopment.bone_lod_husks.lod_multiplier = Application.user_setting("animation_lod_distance_multiplier")

if GameSettingsDevelopment.bone_lod_husks.lod_multiplier == nil then
	GameSettingsDevelopment.bone_lod_husks.lod_multiplier = 1
end

if Application.build() == "release" then
	GameSettingsDevelopment.remove_debug_stuff = false
else
	GameSettingsDevelopment.remove_debug_stuff = false
end

script_data.extrapolation_debug = true
GameSettingsDevelopment.simple_first_person = true
GameSettingsDevelopment.debug_unit_colors = {
	{
		255,
		0,
		0
	},
	{
		0,
		255,
		0
	},
	{
		0,
		255,
		255
	},
	{
		255,
		255,
		0
	},
	{
		255,
		0,
		255
	},
	{
		100,
		0,
		0
	},
	{
		0,
		100,
		255
	},
	{
		100,
		0,
		255
	},
	{
		50,
		150,
		255
	},
	{
		25,
		75,
		100
	},
	{
		0,
		255,
		110
	},
	{
		10,
		85,
		10
	},
	{
		75,
		75,
		255
	},
	{
		65,
		85,
		100
	}
}
GameSettingsDevelopment.ignored_rpc_logs = {
	"rpc_network_clock_sync_request",
	"rpc_network_time_sync_response",
	"rpc_network_current_server_time_response",
	"rpc_network_current_server_time_request",
	"rpc_add_damage",
	"rpc_heal",
	"rpc_ai_drop_single_item",
	"rpc_ai_inventory_wield",
	"rpc_ai_show_single_item",
	"rpc_ai_weapon_shoot_start",
	"rpc_ai_weapon_shoot_end",
	"rpc_interest_point_chatter_update",
	"rpc_set_animation_rotation_scale",
	"rpc_set_animation_translation_scale",
	"rpc_set_script_driven",
	"rpc_set_affected_by_gravity",
	"rpc_set_animation_driven",
	"rpc_constrain_ai",
	"rpc_sync_anim_state_1",
	"rpc_sync_anim_state_3",
	"rpc_sync_anim_state_4",
	"rpc_sync_anim_state_5",
	"rpc_sync_anim_state_7",
	"rpc_sync_anim_state_9",
	"rpc_sync_anim_state_11",
	"rpc_create_bot_nav_transition",
	"rpc_pacing_changed",
	"rpc_play_dialogue_event",
	"rpc_trigger_dialogue_event",
	"rpc_interrupt_dialogue_event",
	"rpc_anim_event",
	"rpc_anim_event_variable_float",
	"rpc_update_anim_variable_done",
	"rpc_attack_hit",
	"rpc_enemy_has_target",
	"rpc_enemy_is_alerted",
	"rpc_set_blocking",
	"rpc_status_change_bool",
	"rpc_skinned_surface_mtr_fx",
	"rpc_surface_mtr_fx",
	"rpc_surface_mtr_fx_lvl_unit",
	"rpc_play_melee_hit_effects",
	"rpc_weapon_blood",
	"rpc_link_unit",
	"rpc_play_first_person_sound",
	"rpc_server_audio_event",
	"rpc_server_audio_event_at_pos",
	"rpc_server_audio_unit_event",
	"rpc_server_audio_unit_param_string_event",
	"rpc_server_audio_unit_param_int_event",
	"rpc_server_audio_unit_param_float_event",
	"rpc_client_audio_set_global_parameter_with_lerp",
	"rpc_sync_door_state",
	"rpc_add_external_velocity",
	"rpc_tutorial_message",
	"rpc_player_blocked_attack",
	"rpc_set_wounded",
	"rpc_alert_enemy",
	"rpc_start_mission_with_unit",
	"rpc_update_mission",
	"rpc_end_mission",
	"rpc_objective_entered_socket_zone",
	"rpc_create_explosion",
	"rpc_area_damage",
	"rpc_player_projectile_impact_dynamic",
	"rpc_client_spawn_light_weight_projectile",
	"rpc_client_despawn_light_weight_projectile",
	"rpc_player_projectile_impact_level",
	"rpc_level_object_damage",
	"rpc_projectile_stopped",
	"rpc_generic_impact_projectile_impact",
	"rpc_show_inventory",
	"rpc_server_set_inventory_packages",
	"rpc_server_mark_profile_used",
	"rpc_add_equipment",
	"rpc_create_attachment",
	"rpc_client_select_inventory",
	"rpc_wield_equipment",
	"rpc_destroy_slot",
	"rpc_set_current_location",
	"rpc_sync_damage_taken",
	"rpc_flow_state_story_played",
	"rpc_flow_state_story_stopped",
	"rpc_flow_state_number_changed",
	"rpc_add_buff",
	"rpc_server_audio_unit_event",
	"rpc_ping",
	"rpc_pong"
}

if not script_data.debug_interactions then
	GameSettingsDevelopment.ignored_rpc_logs[#GameSettingsDevelopment.ignored_rpc_logs + 1] = "rpc_interaction_approved"
	GameSettingsDevelopment.ignored_rpc_logs[#GameSettingsDevelopment.ignored_rpc_logs + 1] = "rpc_interaction_abort"
	GameSettingsDevelopment.ignored_rpc_logs[#GameSettingsDevelopment.ignored_rpc_logs + 1] = "rpc_interaction_completed"
end

if not script_data.debug_voip then
	GameSettingsDevelopment.ignored_rpc_logs[#GameSettingsDevelopment.ignored_rpc_logs + 1] = "rpc_voip_room_request"
	GameSettingsDevelopment.ignored_rpc_logs[#GameSettingsDevelopment.ignored_rpc_logs + 1] = "rpc_voip_room_to_join"
end

local rpcs_logged = false
GameSettingsDevelopment.set_ignored_rpc_logs = function ()
	local ignored_rpc_logs = GameSettingsDevelopment.ignored_rpc_logs

	for i = 1, #ignored_rpc_logs, 1 do
		local rpc_name = ignored_rpc_logs[i]

		Network.ignore_rpc_log(rpc_name)

		if script_data.network_log_messages and not rpcs_logged then
			printf("[Network] Setting log ignore for RPC %s", rpc_name)
		end
	end

	rpcs_logged = true

	return 
end
DefaultDisplayModes = {
	{
		640,
		480,
		0
	},
	{
		800,
		600,
		0
	},
	{
		1024,
		768,
		0
	},
	{
		1280,
		720,
		0
	},
	{
		1280,
		1024,
		0
	},
	{
		1344,
		756,
		0
	},
	{
		1366,
		768,
		0
	},
	{
		1440,
		900,
		0
	},
	{
		1600,
		900,
		0
	},
	{
		1600,
		1024,
		0
	},
	{
		1600,
		1200,
		0
	},
	{
		1680,
		1050,
		0
	},
	{
		1920,
		1080,
		0
	}
}

return 
