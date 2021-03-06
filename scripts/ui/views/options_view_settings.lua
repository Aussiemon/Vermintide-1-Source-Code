local function assigned(a, b)
	if a == nil then
		return b
	else
		return a
	end
end

local function set_function(self, user_setting_name, content, value_set_function)
	local options_values = content.options_values
	local current_selection = content.current_selection
	local new_value = options_values[current_selection]
	self.changed_user_settings[user_setting_name] = new_value

	value_set_function(new_value)
end

local function setup_function(self, user_setting_name, options)
	local default_value = DefaultUserSettings.get("user_settings", user_setting_name)
	local current_value = Application.user_setting(user_setting_name)
	local selection, default_option = nil

	for index, option in ipairs(options) do
		local value = option.value

		if value == current_value then
			selection = index
		end

		if value == default_value then
			default_option = index
		end
	end

	fassert(default_option, "Default value %q for %q does not exist in passed options table", tostring(default_value), user_setting_name)

	selection = selection or default_option

	return selection, options, "menu_settings_" .. user_setting_name, default_option
end

local function saved_value_function(self, user_setting_name, widget)
	local saved_value = assigned(self.changed_user_settings[user_setting_name], Application.user_setting(user_setting_name))
	local default_value = DefaultUserSettings.get("user_settings", user_setting_name)

	if saved_value == nil then
		saved_value = default_value
	end

	local saved_index, default_index = nil
	local content = widget.content

	for index, value in pairs(content.options_values) do
		if value == saved_value then
			saved_index = index
		end

		if value == default_value then
			default_index = index
		end
	end

	content.current_selection = saved_index or default_index
end

local video_settings_definition = {
	{
		setup = "cb_graphics_quality_setup",
		name = "graphics_quality_settings",
		saved_value = "cb_graphics_quality_saved_value",
		callback = "cb_graphics_quality",
		tooltip_text = "tooltip_graphics_quality",
		widget_type = "stepper"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_char_texture_quality_setup",
		saved_value = "cb_char_texture_quality_saved_value",
		callback = "cb_char_texture_quality",
		tooltip_text = "tooltip_char_texture_quality",
		widget_type = "stepper"
	},
	{
		setup = "cb_env_texture_quality_setup",
		saved_value = "cb_env_texture_quality_saved_value",
		callback = "cb_env_texture_quality",
		tooltip_text = "tooltip_env_texture_quality",
		widget_type = "stepper"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_particles_resolution_setup",
		saved_value = "cb_particles_resolution_saved_value",
		callback = "cb_particles_resolution",
		tooltip_text = "tooltip_low_resolution_transparency",
		widget_type = "stepper"
	},
	{
		setup = "cb_particles_quality_setup",
		saved_value = "cb_particles_quality_saved_value",
		callback = "cb_particles_quality",
		tooltip_text = "tooltip_particle_quality",
		widget_type = "stepper"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_sun_shadows_setup",
		saved_value = "cb_sun_shadows_saved_value",
		callback = "cb_sun_shadows",
		tooltip_text = "tooltip_sun_shadows",
		widget_type = "stepper"
	},
	{
		setup = "cb_local_light_shadow_quality_setup",
		saved_value = "cb_local_light_shadow_quality_saved_value",
		callback = "cb_local_light_shadow_quality",
		tooltip_text = "tooltip_local_light_shadows",
		widget_type = "stepper"
	},
	{
		setup = "cb_maximum_shadow_casting_lights_setup",
		saved_value = "cb_maximum_shadow_casting_lights_saved_value",
		callback = "cb_maximum_shadow_casting_lights",
		tooltip_text = "tooltip_max_local_light_shadows",
		widget_type = "slider"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_animation_lod_distance_setup",
		saved_value = "cb_animation_lod_distance_saved_value",
		callback = "cb_animation_lod_distance",
		tooltip_text = "tooltip_animation_lod_distance",
		widget_type = "slider"
	},
	{
		setup = "cb_physic_debris_setup",
		saved_value = "cb_physic_debris_saved_value",
		callback = "cb_physic_debris",
		tooltip_text = "tooltip_physics_debris",
		widget_type = "stepper"
	},
	{
		setup = "cb_scatter_density_setup",
		saved_value = "cb_scatter_density_saved_value",
		callback = "cb_scatter_density",
		tooltip_text = "tooltip_scatter_density",
		widget_type = "stepper"
	},
	{
		setup = "cb_blood_decals_setup",
		saved_value = "cb_blood_decals_saved_value",
		callback = "cb_blood_decals",
		tooltip_text = "tooltip_blood_decals",
		widget_type = "slider"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_anti_aliasing_setup",
		saved_value = "cb_anti_aliasing_saved_value",
		callback = "cb_anti_aliasing",
		tooltip_text = "tooltip_anti_aliasing",
		widget_type = "drop_down"
	},
	{
		setup = "cb_motion_blur_setup",
		saved_value = "cb_motion_blur_saved_value",
		callback = "cb_motion_blur",
		tooltip_text = "tooltip_motion_blur",
		widget_type = "stepper"
	},
	{
		setup = "cb_ssao_setup",
		saved_value = "cb_ssao_saved_value",
		callback = "cb_ssao",
		tooltip_text = "tooltip_ssao",
		widget_type = "stepper"
	},
	{
		setup = "cb_ssr_setup",
		saved_value = "cb_ssr_saved_value",
		callback = "cb_ssr",
		tooltip_text = "tooltip_ssr",
		widget_type = "stepper"
	},
	{
		setup = "cb_dof_setup",
		saved_value = "cb_dof_saved_value",
		callback = "cb_dof",
		tooltip_text = "tooltip_dof",
		widget_type = "stepper"
	},
	{
		setup = "cb_bloom_setup",
		saved_value = "cb_bloom_saved_value",
		callback = "cb_bloom",
		tooltip_text = "tooltip_bloom",
		widget_type = "stepper"
	},
	{
		setup = "cb_light_shafts_setup",
		saved_value = "cb_light_shafts_saved_value",
		callback = "cb_light_shafts",
		tooltip_text = "tooltip_light_shafts",
		widget_type = "stepper"
	},
	{
		setup = "cb_skin_shading_setup",
		saved_value = "cb_skin_shading_saved_value",
		callback = "cb_skin_shading",
		tooltip_text = "tooltip_skin_shading",
		widget_type = "stepper"
	},
	{
		setup = "cb_high_quality_fur_setup",
		saved_value = "cb_high_quality_fur_saved_value",
		callback = "cb_high_quality_fur",
		tooltip_text = "tooltip_high_quality_fur",
		widget_type = "stepper"
	}
}
local audio_settings_definition = {
	{
		setup = "cb_master_volume_setup",
		saved_value = "cb_master_volume_saved_value",
		callback = "cb_master_volume",
		tooltip_text = "tooltip_master_volume",
		widget_type = "slider"
	},
	{
		setup = "cb_music_bus_volume_setup",
		saved_value = "cb_music_bus_volume_saved_value",
		callback = "cb_music_bus_volume",
		tooltip_text = "tooltip_music_volume",
		widget_type = "slider"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_voip_enabled_setup",
		saved_value = "cb_voip_enabled_saved_value",
		callback = "cb_voip_enabled",
		tooltip_text = "tooltip_voip_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_voip_push_to_talk_setup",
		saved_value = "cb_voip_push_to_talk_saved_value",
		callback = "cb_voip_push_to_talk",
		tooltip_text = "tooltip_voip_push_to_talk",
		widget_type = "stepper"
	},
	{
		setup = "cb_voip_bus_volume_setup",
		saved_value = "cb_voip_bus_volume_saved_value",
		callback = "cb_voip_bus_volume",
		tooltip_text = "tooltip_voip_volume",
		widget_type = "slider"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_subtitles_setup",
		saved_value = "cb_subtitles_saved_value",
		callback = "cb_subtitles",
		tooltip_text = "tooltip_subtitles",
		widget_type = "stepper"
	},
	{
		setup = "cb_sound_quality_setup",
		saved_value = "cb_sound_quality_saved_value",
		callback = "cb_sound_quality",
		tooltip_text = "tooltip_sound_quality",
		widget_type = "stepper"
	},
	{
		setup = "cb_dynamic_range_sound_setup",
		saved_value = "cb_dynamic_range_sound_saved_value",
		callback = "cb_dynamic_range_sound",
		tooltip_text = "tooltip_dynamic_range_sound",
		widget_type = "stepper"
	},
	{
		setup = "cb_sound_panning_rule_setup",
		saved_value = "cb_sound_panning_rule_saved_value",
		callback = "cb_sound_panning_rule",
		tooltip_text = "tooltip_panning_rule",
		widget_type = "stepper"
	}
}
local gameplay_settings_definition = {
	{
		setup = "cb_mouse_look_invert_y_setup",
		saved_value = "cb_mouse_look_invert_y_saved_value",
		callback = "cb_mouse_look_invert_y",
		tooltip_text = "tooltip_mouselook_invert_y",
		widget_type = "stepper"
	},
	{
		setup = "cb_mouse_look_sensitivity_setup",
		saved_value = "cb_mouse_look_sensitivity_saved_value",
		callback = "cb_mouse_look_sensitivity",
		tooltip_text = "tooltip_mouselook_sensitivity",
		widget_type = "slider"
	},
	{
		setup = "cb_weapon_scroll_type_setup",
		saved_value = "cb_weapon_scroll_type_saved_value",
		callback = "cb_weapon_scroll_type",
		tooltip_text = "tooltip_weapon_scroll_type",
		widget_type = "stepper"
	},
	{
		setting_name = "disable_give_on_defend",
		widget_type = "stepper",
		options = {
			{
				value = true,
				text = Localize("menu_settings_on")
			},
			{
				value = false,
				text = Localize("menu_settings_off")
			}
		}
	},
	{
		setup = "cb_dodge_on_jump_key_setup",
		saved_value = "cb_dodge_on_jump_key_saved_value",
		callback = "cb_dodge_on_jump_key",
		tooltip_text = "tooltip_dodge_on_jump_key",
		widget_type = "stepper"
	},
	{
		setup = "cb_dodge_on_forward_diagonal_setup",
		saved_value = "cb_dodge_on_forward_diagonal_saved_value",
		callback = "cb_dodge_on_forward_diagonal",
		tooltip_text = "tooltip_dodge_on_forward_diagonal",
		widget_type = "stepper"
	},
	{
		setup = "cb_double_tap_dodge_setup",
		saved_value = "cb_double_tap_dodge_saved_value",
		callback = "cb_double_tap_dodge",
		tooltip_text = "tooltip_double_tap_dodge",
		widget_type = "stepper"
	},
	{
		setting_name = "disable_intro_cinematic",
		widget_type = "stepper",
		options = {
			{
				value = true,
				text = Localize("menu_settings_on")
			},
			{
				value = false,
				text = Localize("menu_settings_off")
			}
		}
	},
	{
		setting_name = "disable_head_bob",
		widget_type = "stepper",
		options = {
			{
				value = true,
				text = Localize("menu_settings_on")
			},
			{
				value = false,
				text = Localize("menu_settings_off")
			}
		}
	},
	{
		setting_name = "disable_camera_shake",
		widget_type = "stepper",
		options = {
			{
				value = true,
				text = Localize("menu_settings_on")
			},
			{
				value = false,
				text = Localize("menu_settings_off")
			}
		}
	},
	{
		setup = "cb_max_upload_speed_setup",
		saved_value = "cb_max_upload_speed_saved_value",
		callback = "cb_max_upload_speed",
		tooltip_text = "tooltip_max_upload_speed",
		widget_type = "drop_down"
	},
	{
		setup = "cb_tutorials_enabled_setup",
		saved_value = "cb_tutorials_enabled_saved_value",
		callback = "cb_tutorials_enabled",
		tooltip_text = "tooltip_tutorials_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_player_outlines_setup",
		saved_value = "cb_player_outlines_saved_value",
		callback = "cb_player_outlines",
		tooltip_text = "tooltip_outlines",
		widget_type = "stepper"
	},
	{
		setup = "cb_fov_setup",
		saved_value = "cb_fov_saved_value",
		callback = "cb_fov",
		tooltip_text = "tooltip_fov",
		widget_type = "slider"
	},
	{
		setup = "cb_blood_enabled_setup",
		saved_value = "cb_blood_enabled_saved_value",
		callback = "cb_blood_enabled",
		tooltip_text = "tooltip_blood_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_chat_enabled_setup",
		saved_value = "cb_chat_enabled_saved_value",
		callback = "cb_chat_enabled",
		tooltip_text = "tooltip_chat_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_chat_font_size_setup",
		saved_value = "cb_chat_font_size_saved_value",
		callback = "cb_chat_font_size",
		tooltip_text = "tooltip_chat_font_size",
		widget_type = "drop_down"
	},
	{
		setup = "cb_toggle_crouch_setup",
		saved_value = "cb_toggle_crouch_saved_value",
		callback = "cb_toggle_crouch",
		tooltip_text = "tooltip_toggle_crouch",
		widget_type = "stepper"
	},
	{
		setup = "cb_overcharge_opacity_setup",
		saved_value = "cb_overcharge_opacity_saved_value",
		callback = "cb_overcharge_opacity",
		tooltip_text = "tooltip_overcharge_opacity",
		widget_type = "slider"
	}
}

function generate_settings(settings_definition)
	for _, definition in pairs(settings_definition) do
		local setting_name = definition.setting_name

		if setting_name then
			local prefix = "cb_" .. setting_name
			local callback_name = prefix
			definition.callback = prefix

			OptionsView[callback_name] = function (self, content)
				return set_function(self, setting_name, content, definition.value_set_function or function ()
					return
				end)
			end

			local setup_function_name = prefix .. "_setup"
			definition.setup = setup_function_name

			OptionsView[setup_function_name] = function (self)
				return setup_function(self, setting_name, definition.options)
			end

			local saved_value_function_name = prefix .. "_saved_value"
			definition.saved_value = saved_value_function_name

			OptionsView[saved_value_function_name] = function (self, widget)
				return saved_value_function(self, setting_name, widget)
			end

			definition.tooltip_text = "tooltip_" .. setting_name
		end
	end
end

generate_settings(gameplay_settings_definition)
generate_settings(video_settings_definition)

if rawget(_G, "Steam") then
	gameplay_settings_definition[#gameplay_settings_definition + 1] = {
		setup = "cb_clan_tag_setup",
		saved_value = "cb_clan_tag_saved_value",
		callback = "cb_clan_tag",
		tooltip_text = "tooltip_clan_tag",
		widget_type = "stepper"
	}
end

if rawget(_G, "LightFX") then
	gameplay_settings_definition[#gameplay_settings_definition + 1] = {
		setup = "cb_alien_fx_setup",
		saved_value = "cb_alien_fx_saved_value",
		callback = "cb_alien_fx",
		tooltip_text = "tooltip_alien_fx",
		widget_type = "stepper"
	}
end

local display_settings_definition = {
	{
		setup = "cb_resolutions_setup",
		name = "resolutions",
		saved_value = "cb_resolutions_saved_value",
		callback = "cb_resolutions",
		tooltip_text = "tooltip_resolutions",
		widget_type = "drop_down"
	},
	{
		setup = "cb_fullscreen_setup",
		saved_value = "cb_fullscreen_saved_value",
		callback = "cb_fullscreen",
		tooltip_text = "tooltip_screen_mode",
		widget_type = "drop_down"
	},
	{
		setup = "cb_hud_screen_fit_setup",
		saved_value = "cb_hud_screen_fit_saved_value",
		callback = "cb_hud_screen_fit",
		tooltip_text = "tooltip_hud_screen_fit",
		widget_type = "stepper"
	},
	{
		setup = "cb_vsync_setup",
		saved_value = "cb_vsync_saved_value",
		callback = "cb_vsync",
		tooltip_text = "tooltip_vsync",
		widget_type = "stepper"
	},
	{
		setup = "cb_lock_framerate_setup",
		saved_value = "cb_lock_framerate_saved_value",
		callback = "cb_lock_framerate",
		tooltip_text = "tooltip_lock_framerate",
		widget_type = "stepper"
	},
	{
		setup = "cb_max_stacking_frames_setup",
		saved_value = "cb_max_stacking_frames_saved_value",
		callback = "cb_max_stacking_frames",
		tooltip_text = "tooltip_max_stacking_frames",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamma_setup",
		saved_value = "cb_gamma_saved_value",
		callback = "cb_gamma",
		tooltip_text = "tooltip_gamma",
		widget_type = "slider",
		slider_image = {
			slider_image = "settings_debug_gamma_correction",
			size = {
				879,
				512
			}
		}
	}
}
local keybind_settings_definition = {
	{
		widget_type = "keybind",
		actions = {
			"move_forward",
			"move_forward_pressed"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"move_left",
			"move_left_pressed"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"move_back",
			"move_back_pressed"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"move_right",
			"move_right_pressed"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"action_one",
			"action_one_hold",
			"action_one_release",
			"action_one_mouse"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"action_two",
			"action_two_hold",
			"action_two_release"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"action_three",
			"action_three_hold",
			"action_three_release"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"weapon_reload",
			"weapon_reload_hold"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"jump_1",
			"dodge_hold"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"dodge"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"crouch",
			"crouching"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"walk"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"interact",
			"interacting"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"wield_1"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"wield_2"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"wield_3"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"wield_4"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"wield_5"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"wield_switch_1"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"wield_next"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"wield_prev"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"character_inspecting"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"action_inspect",
			"action_inspect_hold",
			"action_inspect_release"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"ping"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"ingame_vote_yes"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"ingame_vote_no"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"hotkey_map"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"hotkey_inventory"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"hotkey_journal"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"hotkey_forge"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"hotkey_lobby_browser"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"hotkey_altar"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"hotkey_quests"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"matchmaking_ready"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"matchmaking_start"
		}
	},
	{
		keymappings_key = "IngameMenuKeymaps",
		widget_type = "keybind",
		actions = {
			"cancel_matchmaking"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		widget_type = "keybind",
		actions = {
			"toggle_input_helper"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		keymappings_key = "IngamePlayerListKeymaps",
		widget_type = "keybind",
		actions = {
			"ingame_player_list_pressed",
			"ingame_player_list_held",
			"ingame_player_list_exit_1"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		keymappings_key = "ChatControllerSettings",
		widget_type = "keybind",
		actions = {
			"activate_chat_input"
		}
	},
	{
		widget_type = "keybind",
		actions = {
			"voip_push_to_talk"
		}
	}
}

for i, keybind_setting in ipairs(keybind_settings_definition) do
	if not keybind_setting.keymappings_key then
		keybind_setting.keymappings_key = "PlayerControllerKeymaps"
	end

	if not keybind_setting.keymappings_table_key then
		keybind_setting.keymappings_table_key = "win32"
	end
end

local ignore_keybind = {
	gamepad_right_axis = true,
	analog_input = true,
	look_raw = true,
	gamepad_left_axis = true,
	wield_scroll = true,
	move_controller = true,
	look_raw_controller = true,
	scroll_axis = true,
	cursor = true
}
local gamepad_settings_definition = {
	{
		bg_image2 = "controller_image_ps4",
		bg_image = "controller_image_xb1",
		widget_type = "gamepad_layout",
		bg_image_size = {
			1260,
			400
		},
		bg_image_size2 = {
			1260,
			440
		}
	},
	{
		setup = "cb_gamepad_left_handed_enabled_setup",
		saved_value = "cb_gamepad_left_handed_enabled_saved_value",
		callback = "cb_gamepad_left_handed_enabled",
		tooltip_text = "tooltip_gamepad_left_handed_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamepad_layout_setup",
		name = "gamepad_layout",
		saved_value = "cb_gamepad_layout_saved_value",
		callback = "cb_gamepad_layout",
		tooltip_text = "tooltip_gamepad_layout",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamepad_look_invert_y_setup",
		saved_value = "cb_gamepad_look_invert_y_saved_value",
		callback = "cb_gamepad_look_invert_y",
		tooltip_text = "tooltip_gamepad_invert_y",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamepad_legacy_controller_input_setup",
		saved_value = "cb_gamepad_legacy_controller_input_saved_value",
		callback = "cb_gamepad_legacy_controller_input",
		tooltip_text = "tooltip_gamepad_legacy_controller_input",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamepad_look_sensitivity_setup",
		saved_value = "cb_gamepad_look_sensitivity_saved_value",
		callback = "cb_gamepad_look_sensitivity",
		tooltip_text = "tooltip_gamepad_look_sensitivity",
		widget_type = "slider"
	},
	{
		setup = "cb_gamepad_zoom_sensitivity_setup",
		saved_value = "cb_gamepad_zoom_sensitivity_saved_value",
		callback = "cb_gamepad_zoom_sensitivity",
		tooltip_text = "tooltip_gamepad_zoom_sensitivity",
		widget_type = "slider"
	},
	{
		setup = "cb_gamepad_auto_aim_enabled_setup",
		saved_value = "cb_gamepad_auto_aim_enabled_saved_value",
		callback = "cb_gamepad_auto_aim_enabled",
		tooltip_text = "tooltip_gamepad_auto_aim_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamepad_use_ps4_style_input_icons_setup",
		saved_value = "cb_gamepad_use_ps4_style_input_icons_saved_value",
		callback = "cb_gamepad_use_ps4_style_input_icons",
		tooltip_text = "tooltip_gamepad_use_ps4_style_input_icons",
		widget_type = "stepper"
	}
}
local tobii_settings_definition = nil

if rawget(_G, "Tobii") then
	tobii_settings_definition = {}

	local function add_stepper(name, tooltip_text)
		tobii_settings_definition[#tobii_settings_definition + 1] = {
			widget_type = "stepper",
			callback = "cb_" .. name,
			setup = "cb_" .. name .. "_setup",
			saved_value = "cb_" .. name .. "_saved_value",
			tooltip_text = tooltip_text
		}
	end

	local function add_slider(name, tooltip_text)
		tobii_settings_definition[#tobii_settings_definition + 1] = {
			widget_type = "slider",
			callback = "cb_" .. name,
			setup = "cb_" .. name .. "_setup",
			saved_value = "cb_" .. name .. "_saved_value",
			tooltip_text = tooltip_text
		}
	end

	add_stepper("tobii_eyetracking", "tooltip_tobii_eyetracking")
	add_stepper("tobii_tag_at_gaze", "tooltip_tobii_tag_at_gaze")
	add_stepper("tobii_interact_at_gaze", "tooltip_tobii_interact_at_gaze")
	add_stepper("tobii_clean_ui", "tooltip_tobii_clean_ui")
	add_slider("tobii_clean_ui_alpha", "tooltip_tobii_clean_ui_alpha")
	add_stepper("tobii_fire_at_gaze_blunderbuss", "tooltip_tobii_fire_at_gaze_blunderbuss")
	add_stepper("tobii_fire_at_gaze_grudgeraker", "tooltip_tobii_fire_at_gaze_grudgeraker")
	add_stepper("tobii_fire_at_gaze_fireball", "tooltip_tobii_fire_at_gaze_fireball")
	add_stepper("tobii_fire_at_gaze_geiser", "tooltip_tobii_fire_at_gaze_geiser")
	add_stepper("tobii_fire_at_gaze_sparks", "tooltip_tobii_fire_at_gaze_sparks")
	add_stepper("tobii_aim_at_gaze_hagbane", "tooltip_tobii_aim_at_gaze_hagbane")
	add_stepper("tobii_aim_at_gaze_shortbow", "tooltip_tobii_aim_at_gaze_shortbow")
	add_stepper("tobii_aim_at_gaze_longbow", "tooltip_tobii_aim_at_gaze_longbow")
	add_stepper("tobii_aim_at_gaze_crossbow", "tooltip_tobii_aim_at_gaze_crossbow")
	add_stepper("tobii_aim_at_gaze_handgun", "tooltip_tobii_aim_at_gaze_handgun")
	add_stepper("tobii_fire_at_gaze_drake_pistols", "tooltip_tobii_fire_at_gaze_drake_pistols")
	add_stepper("tobii_fire_at_gaze_brace_of_pistols", "tooltip_tobii_fire_at_gaze_brace_of_pistols")
	add_stepper("tobii_fire_at_gaze_repeating_pistol", "tooltip_tobii_fire_at_gaze_repeating_pistol")
	add_stepper("tobii_fire_at_gaze_repeating_handgun", "tooltip_tobii_fire_at_gaze_repeating_handgun")
	add_stepper("tobii_extended_view", "tooltip_tobii_extended_view")
	add_slider("tobii_extended_view_speed", "tooltip_tobii_extended_view_speed")
	add_slider("tobii_extended_view_max_yaw", "tooltip_tobii_extended_view_max_yaw")
	add_slider("tobii_extended_view_max_pitch_up", "tooltip_tobii_extended_view_max_pitch_up")
	add_slider("tobii_extended_view_max_pitch_down", "tooltip_tobii_extended_view_max_pitch_down")
	add_slider("tobii_extended_view_deadzone", "tooltip_tobii_extended_view_deadzone")
	add_slider("tobii_extended_view_curve_slope", "tooltip_tobii_extended_view_curve_slope")
	add_slider("tobii_extended_view_curve_shoulder", "tooltip_tobii_extended_view_curve_shoulder")
end

local needs_reload_settings = {
	"screen_resolution",
	"fullscreen",
	"borderless_fullscreen",
	"vsync",
	"gamma",
	"bloom_enabled",
	"light_shaft_enabled",
	"skin_material_enabled",
	"char_texture_quality",
	"env_texture_quality",
	"particles_quality",
	"sun_shadows",
	"sun_shadow_quality",
	"fxaa_enabled",
	"taa_enabled",
	"graphics_quality",
	"adapter_index",
	"use_physic_debris",
	"max_shadow_casting_lights",
	"local_light_shadow_quality",
	"lod_object_multiplier",
	"lod_scatter_density",
	"dof_enabled",
	"bloom_enabled",
	"ssr_enabled",
	"ssr_high_quality",
	"low_res_transparency"
}
local needs_restart_settings = {
	"char_texture_quality",
	"env_texture_quality",
	"use_physic_debris",
	"use_baked_enemy_meshes"
}
SettingsMenuNavigation = {
	"gameplay_settings",
	"display_settings",
	"video_settings",
	"audio_settings",
	"keybind_settings",
	"gamepad_settings"
}
local title_button_definitions = {
	UIWidgets.create_menu_button("settings_view_gameplay", "settings_button_1"),
	UIWidgets.create_menu_button("settings_view_display", "settings_button_2"),
	UIWidgets.create_menu_button("settings_view_video", "settings_button_3"),
	UIWidgets.create_menu_button("settings_view_sound", "settings_button_4"),
	UIWidgets.create_menu_button("settings_view_keybind", "settings_button_5"),
	UIWidgets.create_menu_button("settings_view_gamepad", "settings_button_6")
}

if rawget(_G, "Tobii") then
	title_button_definitions[#title_button_definitions + 1] = UIWidgets.create_menu_button("settings_view_eyex", "settings_button_" .. #title_button_definitions + 1)
	SettingsMenuNavigation[#SettingsMenuNavigation + 1] = "tobii_eyetracking_settings"
end

return {
	video_settings_definition = video_settings_definition,
	audio_settings_definition = audio_settings_definition,
	gameplay_settings_definition = gameplay_settings_definition,
	display_settings_definition = display_settings_definition,
	keybind_settings_definition = keybind_settings_definition,
	gamepad_settings_definition = gamepad_settings_definition,
	tobii_settings_definition = tobii_settings_definition,
	needs_restart_settings = needs_restart_settings,
	needs_reload_settings = needs_reload_settings,
	ignore_keybind = ignore_keybind,
	title_button_definitions = title_button_definitions
}
