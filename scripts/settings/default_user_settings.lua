require("scripts/settings/render_settings_templates")
require("scripts/settings/camera_transition_templates")
require("scripts/settings/camera_settings")
require("scripts/managers/blood/blood_settings")
require("scripts/settings/sound_quality_settings")

local default_user_settings = {
	max_upload_speed = 512,
	use_hud_screen_fit = true,
	gamepad_look_invert_y = false,
	tutorials_enabled = true,
	mouse_look_invert_y = false,
	tobii_fire_at_gaze_repeating_pistol = true,
	vsync = true,
	gamepad_look_sensitivity_y = 0,
	mouse_look_sensitivity = 0,
	tobii_tag_at_gaze = true,
	enabled_crosshairs = "all",
	gamepad_left_handed = false,
	gamepad_use_ps4_style_input_icons = false,
	sfx_bus_volume = 100,
	root_scale_y = 1,
	disable_camera_shake = false,
	dodge_on_jump_key = true,
	voip_push_to_talk = true,
	master_bus_volume = 100,
	overcharge_opacity = 100,
	ui_scale = 100,
	tobii_aim_at_gaze_longbow = true,
	tobii_aim_at_gaze_crossbow = true,
	player_outlines = "on",
	gamepad_auto_aim_enabled = true,
	use_high_quality_fur = true,
	adapter_index = 0,
	borderless_fullscreen = false,
	tobii_eyetracking = true,
	dodge_on_forward_diagonal = false,
	toggle_alternate_attack = false,
	tobii_interact_at_gaze = true,
	tobii_fire_at_gaze_blunderbuss = true,
	max_fps = 0,
	gamepad_rumble_enabled = true,
	tobii_fire_at_gaze_grudgeraker = true,
	sound_quality = "high",
	tobii_fire_at_gaze_geiser = true,
	toggle_stationary_dodge = false,
	double_tap_dodge = false,
	tobii_fire_at_gaze_blast_beam = false,
	fullscreen = true,
	disable_head_bob = false,
	tobii_fire_at_gaze_shortbow = false,
	voice_bus_volume = 100,
	disable_intro_cinematic = false,
	tobii_fire_at_gaze_longbow = false,
	tobii_fire_at_gaze_sparks = true,
	tobii_fire_at_gaze_repeating_handgun = true,
	use_baked_enemy_meshes = false,
	sound_panning_rule = "speakers",
	tobii_clean_ui = true,
	tobii_aim_at_gaze_shortbow = true,
	root_scale_x = 1,
	tobii_fire_at_gaze_drake_pistols = true,
	gamepad_layout = "default",
	tobii_aim_at_gaze_hagbane = true,
	tobii_extended_view_speed = 2,
	tobii_fire_at_gaze_brace_of_pistols = true,
	tobii_fire_at_gaze_fireball = true,
	use_alien_fx = false,
	tobii_extended_view_curve_shoulder = 0.7,
	tobii_extended_view_max_pitch_up = 10,
	weapon_scroll_type = "scroll_wrap",
	voip_is_enabled = true,
	tobii_extended_view_curve_slope = 2.2,
	tobii_extended_view_max_yaw = 15,
	tobii_extended_view_deadzone = 0,
	toggle_crouch = false,
	double_tap_dodge_threshold = 0.25,
	tobii_fire_at_gaze_hagbane = false,
	tobii_extended_view = true,
	language_id = "en",
	disable_give_on_defend = false,
	max_stacking_frames = -1,
	gamepad_legacy_controller = false,
	chat_enabled = true,
	music_bus_volume = 100,
	use_subtitles = true,
	voip_bus_volume = 100,
	blood_enabled = true,
	gamepad_look_sensitivity = 0,
	tobii_aim_at_gaze_handgun = true,
	tobii_extended_view_max_pitch_down = 5,
	gamepad_zoom_sensitivity = 0,
	dynamic_range_sound = "low",
	tobii_clean_ui_alpha = 0.2,
	chat_font_size = 20,
	char_texture_quality = TextureQuality.default_characters,
	env_texture_quality = TextureQuality.default_environment,
	local_light_shadow_quality = script_data.settings.default_local_light_shadow_quality or "high",
	particles_quality = script_data.settings.default_particles_quality or "high",
	sun_shadow_quality = script_data.settings.default_sun_shadow_quality or "high",
	use_physic_debris = script_data.settings.default_use_physic_debris or true,
	num_blood_decals = BloodSettings.blood_decals.num_decals or 100
}
local default_render_settings = {
	fxaa_enabled = false,
	light_shaft_enabled = true,
	skin_material_enabled = true,
	ao_enabled = true,
	sun_shadows = true,
	dof_enabled = true,
	ssr_enabled = false,
	bloom_enabled = true,
	taa_enabled = false,
	ssr_high_quality = false,
	gamma = 2.2,
	ao_half_res = false,
	lod_object_multiplier = 1,
	lod_decoration_density = 1,
	lod_scatter_density = 1,
	max_shadow_casting_lights = (PLATFORM == "win32" and 1) or 2,
	fov = script_data.settings.default_fov or CameraSettings.first_person._node.vertical_fov
}
local default_texture_settings = {}
local char_texture_settings = TextureQuality.characters[default_user_settings.char_texture_quality]
local env_texture_settings = TextureQuality.environment[default_user_settings.env_texture_quality]

for i = 1, #char_texture_settings, 1 do
	local setting = char_texture_settings[i]
	default_texture_settings[setting.texture_setting] = setting.mip_level
end

for i = 1, #env_texture_settings, 1 do
	local setting = env_texture_settings[i]
	default_texture_settings[setting.texture_setting] = setting.mip_level
end

local sun_shadow_quality_settings = SunShadowQuality[default_user_settings.sun_shadow_quality]

for setting, value in pairs(sun_shadow_quality_settings) do
	default_render_settings[setting] = value
end

local particles_quality_settings = ParticlesQuality[default_user_settings.particles_quality]

for setting, value in pairs(particles_quality_settings) do
	default_render_settings[setting] = value
end

local local_light_shadow_quality_settings = LocalLightShadowQuality[default_user_settings.local_light_shadow_quality]

for setting, value in pairs(local_light_shadow_quality_settings) do
	default_render_settings[setting] = value
end

DefaultUserSettings = {
	set_default_user_settings = function ()
		if LEVEL_EDITOR_TEST then
			return
		end

		local set_default = false

		for key, value in pairs(default_user_settings) do
			if Application.user_setting(key) == nil then
				Application.set_user_setting(key, value)

				set_default = true
			end
		end

		local reload = false

		for key, value in pairs(default_render_settings) do
			if Application.user_setting("render_settings", key) == nil then
				Application.set_user_setting("render_settings", key, value)

				set_default = true
				reload = true
			end
		end

		for key, value in pairs(default_texture_settings) do
			if Application.user_setting("texture_settings", key) == nil then
				Application.set_user_setting("texture_settings", key, value)

				set_default = true
				reload = true
			end
		end

		if reload then
			Application.apply_user_settings()
		end

		if set_default then
			Application.save_user_settings()
		end
	end,
	get = function (setting_type, setting_name)
		local setting = nil

		if setting_type == "user_settings" then
			setting = default_user_settings[setting_name]
		elseif setting_type == "render_settings" then
			setting = default_render_settings[setting_name]
		elseif setting_type == "texture_settings" then
			setting = default_texture_settings[setting_name]
		end

		fassert(setting ~= nil, "No default setting set for setting %s", setting_name)

		return setting
	end,
	setup_resolution = function ()
		Profiler.start("setup_resolution()")

		local get_user_setting = Application.user_setting
		local set_user_setting = Application.set_user_setting
		local save_user_settings = Application.save_user_settings
		local apply_user_settings = Application.apply_user_settings
		local application_settings = Application:settings() or {}

		table.dump(application_settings, "Application Settings", 4)

		local user_settings = get_user_setting("user_settings")

		print("HAS USER_SETTINGS: " .. tostring(user_settings))

		local safe_mode = false
		local argv = {
			Application.argv()
		}

		for _, arg in pairs(argv) do
			if arg == "-safe-mode" then
				safe_mode = true
			end
		end

		print("SAFE MODE:", safe_mode)

		if (application_settings.auto_detect_video and not user_settings) or safe_mode then
			print("################### AUTO DETECT VIDEO ###################")

			local resolution = get_user_setting("screen_resolution")

			table.dump(resolution, "resolution", 2)

			local fullscreen_output = 0
			local display_modes = Application.enum_display_modes() or {}

			if #display_modes == 0 then
				display_modes = DefaultDisplayModes

				print("Could not fetch display modes ... using default")
			end

			table.dump(display_modes, "display_modes", 2)

			local available = false
			local highest_available = display_modes[1]

			print("lowest available", highest_available)

			for _, mode in ipairs(display_modes) do
				if (highest_available[1] <= mode[1] or highest_available[2] <= mode[2]) and mode[3] == fullscreen_output then
					highest_available = mode
				end
			end

			print("highest available", highest_available)

			if safe_mode then
				print("いいいいいいいいいいいいいいい� SETTING LOWEST RESOLUTION いいいいいいいいいいいいいいいいいいいいいいいいいいいいいい")

				local lowest_resolution = display_modes[1]
				resolution[1] = lowest_resolution[1]
				resolution[2] = lowest_resolution[2]
				resolution[3] = lowest_resolution[3]

				table.dump(resolution, "res", 1)
				set_user_setting("borderless_fullscreen", false)
			else
				print("いいいいいいいいいいいいいいい� SETTING MAX RESOLUTION いいいいいいいいいいいいいいいいいいいいいいいいいいいいいい")

				resolution[1] = highest_available[1]
				resolution[2] = highest_available[2]
				resolution[3] = highest_available[3]

				table.dump(resolution, "res", 1)
				set_user_setting("borderless_fullscreen", true)
			end

			local resolution = {
				resolution[1],
				resolution[2],
				resolution[3]
			}

			set_user_setting("screen_resolution", resolution)
			set_user_setting("fullscreen", false)
			set_user_setting("fullscreen_output", resolution[3])
			set_user_setting("adapter_index", 0)
			set_user_setting("aspect_ratio", -1)
			set_user_setting("user_settings", true)
			save_user_settings()
			apply_user_settings()
			print("################### AUTO DETECT VIDEO END ###################")

			return true
		end

		Profiler.stop("setup_resolution()")
	end
}

return
