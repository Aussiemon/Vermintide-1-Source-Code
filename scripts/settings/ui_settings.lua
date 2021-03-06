local function get_ui_scale()
	local default_value = 100

	if PLATFORM == "xb1" then
		local console_type = XboxOne.console_type()

		if console_type == XboxOne.CONSOLE_TYPE_XBOX_ONE_X_DEVKIT or console_type == XboxOne.CONSOLE_TYPE_XBOX_ONE_X then
			default_value = 150
		end
	end

	return Application.user_setting("ui_scale") or default_value
end

UISettings = {
	start_drag_threshold = 0.15,
	use_subtitles = true,
	double_click_threshold = 0.1,
	dice_type_success_sides = {
		gold = 4,
		metal = 3,
		warpstone = 6,
		wood = 2
	},
	root_scale = {
		Application.user_setting("root_scale_x") or 1,
		Application.user_setting("root_scale_y") or 1
	},
	ui_scale = get_ui_scale(),
	use_hud_screen_fit = Application.user_setting("use_hud_screen_fit") or false,
	interaction = {
		bar = {
			fade_in = 0.1,
			fade_out = 0.1
		}
	},
	inventory_hud = {
		select_animation_duration = 0.2,
		slot_default_alpha = 170,
		slot_select_size = 62,
		slot_select_alpha = 255,
		slot_default_size = 46,
		slot_spacing = 2,
		equip_animation_duration = 0.2,
		bar_lit_fade_out_duration = 0.12,
		bar_lit_pulse_duration = 3
	},
	inventory = {
		item_preview_fade_in_time = 0.2,
		item_list = {
			intro = {
				total_tween_time = 0.2,
				background_fade_in_end_fraction = 0.8,
				background_fade_in_start_fraction = 0.4,
				item_fade_in_end_fraction = 0.4,
				item_fade_in_start_fraction = 0,
				text_fade_in_start_fraction = 0.8,
				non_room_item_alpha_value = 120,
				text_fade_in_end_fraction = 1
			},
			border = {
				alpha_select = 255,
				select_fade_in_time = 0.2,
				alpha_hover = 178.5,
				hover_fade_out_time = 0.1,
				alpha_normal = 0,
				hover_fade_in_time = 0.1,
				select_fade_out_time = 0.2
			}
		},
		button_bars = {
			selected_fade_in = 0.2,
			selected_fade_out = 0.04,
			background = {
				fade_out_time = 0.1,
				alpha_normal = 178.5,
				alpha_hover = 255,
				fade_in_time = 0.1
			},
			icon = {
				fade_out_time = 0.1,
				alpha_normal = 178.5,
				alpha_hover = 255,
				fade_in_time = 0.1
			}
		}
	},
	map = {
		camera_time_exit = 0.5,
		camera_time_enter = 0.5,
		show_debug_levels = true
	},
	end_screen = {
		victory_fade_out = 0.8,
		defeat_fade_out = 0.5,
		victory_fade_in = 0.5,
		gdc_fade_in = 0.2,
		gdc_fade_out = 0.5,
		text_fade_in = 0.5,
		display_time = 5,
		defeat_fade_in = 1.5,
		continue_fade_out = 0.5,
		continue_fade_in = 0.5,
		background_fade_out = 0.8,
		text_fade_out = 0.3,
		background_fade_in = 0.5
	},
	summary_screen = {
		reward_screen_fade_in_time = 0.2,
		summary_entry_start_delay = 0.4,
		tween_in_time = 1,
		tween_out_time = 0.8,
		summary_entry_experience_count_time = 0.5,
		reward_screen_display_time = 1.5,
		reward_screen_fade_out_time = 0.4,
		summary_entry_fade_in_time = 0.2,
		summary_dice_fade_in_time = 0.2,
		element_presentation_time = 0.7,
		element_presentation_experience_count_start_time = 0.2,
		bar_progress_min_time = 1,
		start_delay_time = 2,
		bar_progress_max_time = 4,
		bar_progress_experience_time_multiplier = 0.006,
		speed_up_experience_time_multiplier = 2.5
	},
	scoreboard = {
		topic_select_duration = 0.15,
		arrow_select_duration = 0.12,
		arrow_dehover_duration = 0.12,
		topic_hover_alpha = 255,
		auto_pilot_select_wait_time = 6,
		topic_data_fade_in_duration = 0.2,
		arrow_deselect_duration = 0.12,
		arrow_hover_duration = 0.12,
		player_list_pluse_duration = 0.5,
		topic_hover_duration = 0.15,
		open_duration = 0.4,
		topic_dehover_duration = 0.15,
		topic_deselect_duration = 0.15,
		auto_pilot_wait_time = 15,
		topic_normal_alpha = 180,
		close_duration = 0.4,
		topic_scroll_duration = 0.4
	},
	area_indicator = {
		wait_time = 1,
		fade_time = 1
	},
	mission_objective = {
		wait_time = 3,
		fade_time = 1
	},
	crosshair = {
		hit_marker_fade = 0.4
	},
	unit_frames = {
		health_bar_lerp_time = 1,
		low_health_threshold = 0.42,
		low_health_animation_alpha_from = 255,
		low_health_animation_alpha_to = 200,
		low_health_animation_time = 5,
		health_step_value = 10
	},
	cutscene_ui = {
		letterbox = {
			bar_height = 70
		},
		fx_fade = {
			hold_time = 0,
			fade_out_time = 2,
			fade_in_time = 2
		},
		fx_text_popup = {
			hold_time = 3,
			fade_out_time = 1,
			fade_in_time = 1
		}
	},
	tutorial = {
		tooltip = {
			center_clamp_distance = 400
		},
		mission_tooltip = {
			time_lerp_multiplier = 0.24,
			fade_in_time = 0.15,
			alpha_fade_out_value = 100,
			start_scale_distance = 10,
			fade_out_time = 0.15,
			minimum_icon_scale = 0.5,
			pixel_snap_threshold = 1.4,
			end_scale_distance = 100,
			start_lerp_speed = 0.05,
			distance_from_center = {
				width = 400,
				height = 200
			}
		},
		objective_tooltip = {
			time_lerp_multiplier = 0.24,
			fade_in_time = 0.15,
			alpha_fade_out_value = 100,
			start_scale_distance = 10,
			fade_out_time = 0.15,
			minimum_icon_scale = 0.5,
			pixel_snap_threshold = 1.4,
			end_scale_distance = 100,
			start_lerp_speed = 0.05,
			distance_from_center = {
				width = 400,
				height = 200
			}
		}
	},
	chat = {
		output_background_alpha = 255,
		window_frame_bottom_alpha = 255,
		output_text_alpha = 255,
		scrollbar_background_alpha = 80,
		scrollbar_stroke_alpha = 80,
		scrollbar_background_stroke_alpha = 80,
		tab_notification_alpha_2 = 255,
		tab_notification_alpha_1 = 120,
		window_background_alpha = 255,
		chat_close_delay = 6,
		scrollbar_alpha = 160,
		chat_close_fade_length = 2,
		input_caret_alpha = 255,
		input_background_alpha = 120,
		window_frame_top_alpha = 255,
		input_text_alpha = 255
	},
	positive_reinforcement = {
		fade_duration = 0.5,
		show_duration = 4,
		increment_duration = 0.33
	},
	use_ps4_input_icons = Application.user_setting("gamepad_use_ps4_style_input_icons"),
	hero_icons = {
		small = {
			witch_hunter = "tabs_class_icon_witch_hunter_normal",
			empire_soldier = "tabs_class_icon_empire_soldier_normal",
			dwarf_ranger = "tabs_class_icon_dwarf_ranger_normal",
			wood_elf = "tabs_class_icon_way_watcher_normal",
			bright_wizard = "tabs_class_icon_bright_wizard_normal"
		},
		medium = {
			witch_hunter = "hero_icon_medium_witch_hunter_yellow",
			empire_soldier = "hero_icon_medium_empire_soldier_yellow",
			dwarf_ranger = "hero_icon_medium_dwarf_ranger_yellow",
			wood_elf = "hero_icon_medium_way_watcher_yellow",
			bright_wizard = "hero_icon_medium_bright_wizard_yellow"
		}
	},
	hero_tooltips = {
		witch_hunter = "inventory_screen_witch_hunter_tooltip",
		empire_soldier = "inventory_screen_empire_soldier_tooltip",
		dwarf_ranger = "inventory_screen_dwarf_tooltip",
		wood_elf = "inventory_screen_way_watcher_tooltip",
		bright_wizard = "inventory_screen_bright_wizard_tooltip"
	}
}
local button_mapping = {
	win32 = {
		{
			texture = "pc_button_icon_left",
			size = {
				20,
				36
			}
		},
		{
			texture = "pc_button_icon_middle",
			tileable = true,
			size = {
				8,
				36
			}
		},
		{
			texture = "pc_button_icon_right",
			size = {
				20,
				36
			}
		}
	},
	xb1 = {
		a = {
			texture = "xbone_button_icon_a",
			size = {
				34,
				34
			}
		},
		b = {
			texture = "xbone_button_icon_b",
			size = {
				34,
				34
			}
		},
		x = {
			texture = "xbone_button_icon_x",
			size = {
				34,
				34
			}
		},
		y = {
			texture = "xbone_button_icon_y",
			size = {
				34,
				34
			}
		},
		d_up = {
			texture = "xbone_button_icon_d_pad_up",
			size = {
				33,
				33
			}
		},
		d_down = {
			texture = "xbone_button_icon_d_pad_down",
			size = {
				33,
				33
			}
		},
		d_left = {
			texture = "xbone_button_icon_d_pad_left",
			size = {
				33,
				33
			}
		},
		d_right = {
			texture = "xbone_button_icon_d_pad_right",
			size = {
				33,
				33
			}
		},
		d_horizontal = {
			texture = "xbone_button_icon_d_pad_horizontal",
			size = {
				33,
				33
			}
		},
		d_vertical = {
			texture = "xbone_button_icon_d_pad_vertical",
			size = {
				33,
				33
			}
		},
		d_pad = {
			texture = "xbone_button_icon_d_pad",
			size = {
				33,
				33
			}
		},
		left_shoulder = {
			texture = "xbone_button_icon_lb",
			size = {
				36,
				26
			}
		},
		left_trigger = {
			texture = "xbone_button_icon_lt",
			size = {
				38,
				33
			}
		},
		left_thumb = {
			texture = "xbone_button_icon_l3",
			size = {
				30,
				33
			}
		},
		right_shoulder = {
			texture = "xbone_button_icon_rb",
			size = {
				36,
				26
			}
		},
		right_trigger = {
			texture = "xbone_button_icon_rt",
			size = {
				38,
				33
			}
		},
		right_thumb = {
			texture = "xbone_button_icon_r3",
			size = {
				30,
				33
			}
		},
		l1_r1 = {
			texture = "xbone_button_icon_lb_rb",
			size = {
				69,
				26
			}
		},
		l2_r2 = {
			texture = "xbone_button_icon_lt_rt",
			size = {
				77,
				33
			}
		},
		left_stick = {
			texture = "xbone_button_icon_left_stick",
			size = {
				32,
				33
			}
		},
		right_stick = {
			texture = "xbone_button_icon_right_stick",
			size = {
				32,
				33
			}
		},
		start = {
			texture = "xbone_button_icon_menu",
			size = {
				26,
				26
			}
		},
		back = {
			texture = "xbone_button_icon_show",
			size = {
				26,
				26
			}
		}
	},
	ps4 = {
		cross = {
			texture = "ps4_button_icon_cross",
			size = {
				34,
				34
			}
		},
		circle = {
			texture = "ps4_button_icon_circle",
			size = {
				34,
				34
			}
		},
		square = {
			texture = "ps4_button_icon_square",
			size = {
				34,
				34
			}
		},
		triangle = {
			texture = "ps4_button_icon_triangle",
			size = {
				34,
				34
			}
		},
		up = {
			texture = "ps4_button_icon_d_pad_up",
			size = {
				33,
				33
			}
		},
		down = {
			texture = "ps4_button_icon_d_pad_down",
			size = {
				33,
				33
			}
		},
		left = {
			texture = "ps4_button_icon_d_pad_left",
			size = {
				33,
				33
			}
		},
		right = {
			texture = "ps4_button_icon_d_pad_right",
			size = {
				33,
				33
			}
		},
		d_horizontal = {
			texture = "ps4_button_icon_d_pad_horizontal",
			size = {
				33,
				33
			}
		},
		d_vertical = {
			texture = "ps4_button_icon_d_pad_vertical",
			size = {
				33,
				33
			}
		},
		d_pad = {
			texture = "ps4_button_icon_d_pad",
			size = {
				33,
				33
			}
		},
		l1 = {
			texture = "ps4_button_icon_l1",
			size = {
				36,
				26
			}
		},
		l2 = {
			texture = "ps4_button_icon_l2",
			size = {
				38,
				33
			}
		},
		l3 = {
			texture = "ps4_button_icon_l3",
			size = {
				30,
				33
			}
		},
		r1 = {
			texture = "ps4_button_icon_r1",
			size = {
				36,
				26
			}
		},
		r2 = {
			texture = "ps4_button_icon_r2",
			size = {
				38,
				33
			}
		},
		r3 = {
			texture = "ps4_button_icon_r3",
			size = {
				30,
				33
			}
		},
		l1_r1 = {
			texture = "ps4_button_icon_l1_r1",
			size = {
				69,
				26
			}
		},
		l2_r2 = {
			texture = "ps4_button_icon_l2_r2",
			size = {
				73,
				33
			}
		},
		left_stick = {
			texture = "ps4_button_icon_left_stick",
			size = {
				32,
				33
			}
		},
		right_stick = {
			texture = "ps4_button_icon_right_stick",
			size = {
				32,
				33
			}
		},
		options = {
			texture = "ps4_button_icon_options",
			size = {
				44,
				33
			}
		},
		share = {
			texture = "ps4_button_icon_share",
			size = {
				44,
				33
			}
		},
		touch = {
			texture = "ps4_button_icon_touchpad",
			size = {
				42,
				28
			}
		}
	},
	win32_ps4 = {
		a = {
			texture = "ps4_button_icon_cross",
			size = {
				34,
				34
			}
		},
		b = {
			texture = "ps4_button_icon_circle",
			size = {
				34,
				34
			}
		},
		x = {
			texture = "ps4_button_icon_square",
			size = {
				34,
				34
			}
		},
		y = {
			texture = "ps4_button_icon_triangle",
			size = {
				34,
				34
			}
		},
		d_up = {
			texture = "ps4_button_icon_d_pad_up",
			size = {
				33,
				33
			}
		},
		d_down = {
			texture = "ps4_button_icon_d_pad_down",
			size = {
				33,
				33
			}
		},
		d_left = {
			texture = "ps4_button_icon_d_pad_left",
			size = {
				33,
				33
			}
		},
		d_right = {
			texture = "ps4_button_icon_d_pad_right",
			size = {
				33,
				33
			}
		},
		d_horizontal = {
			texture = "ps4_button_icon_d_pad_horizontal",
			size = {
				33,
				33
			}
		},
		d_vertical = {
			texture = "ps4_button_icon_d_pad_vertical",
			size = {
				33,
				33
			}
		},
		d_pad = {
			texture = "ps4_button_icon_d_pad",
			size = {
				33,
				33
			}
		},
		left_shoulder = {
			texture = "ps4_button_icon_l1",
			size = {
				36,
				26
			}
		},
		left_trigger = {
			texture = "ps4_button_icon_l2",
			size = {
				38,
				33
			}
		},
		left_thumb = {
			texture = "ps4_button_icon_l3",
			size = {
				30,
				33
			}
		},
		right_shoulder = {
			texture = "ps4_button_icon_r1",
			size = {
				36,
				26
			}
		},
		right_trigger = {
			texture = "ps4_button_icon_r2",
			size = {
				38,
				33
			}
		},
		right_thumb = {
			texture = "ps4_button_icon_r3",
			size = {
				30,
				33
			}
		},
		l1_r1 = {
			texture = "ps4_button_icon_l1_r1",
			size = {
				69,
				26
			}
		},
		l2_r2 = {
			texture = "ps4_button_icon_l2_r2",
			size = {
				73,
				33
			}
		},
		left_stick = {
			texture = "ps4_button_icon_left_stick",
			size = {
				32,
				33
			}
		},
		right_stick = {
			texture = "ps4_button_icon_right_stick",
			size = {
				32,
				33
			}
		},
		start = {
			texture = "ps4_button_icon_options",
			size = {
				44,
				33
			}
		},
		back = {
			texture = "ps4_button_icon_share",
			size = {
				44,
				33
			}
		}
	}
}

function ButtonTextureByName(button_name, platform)
	local use_ps4_input_icons = UISettings.use_ps4_input_icons

	if platform == "xb1" and use_ps4_input_icons then
		return button_mapping.win32_ps4[button_name]
	else
		return (platform == "win32" and button_mapping[platform]) or button_mapping[platform][button_name]
	end
end

UISettings.get_gamepad_input_texture_data = function (input_service, input_action, gamepad_active)
	local platform = PLATFORM

	if platform == "win32" and gamepad_active then
		platform = "xb1"
	end

	local button_texture_data = nil
	local button_name = ""
	local keymap_binding = input_service:get_keymapping(input_action, platform)
	keymap_binding = keymap_binding or input_service:get_filter_keymapping(input_action, platform)

	if #keymap_binding < 3 then
		return button_texture_data, button_name
	end

	local device_type = keymap_binding[1]
	local key_index = keymap_binding[2]
	local key_action_type = keymap_binding[3]

	if device_type == "keyboard" then
		button_name = Keyboard.button_locale_name(key_index)
	elseif device_type == "mouse" then
		button_name = Mouse.button_name(key_index)
	elseif device_type == "gamepad" then
		button_name = Pad1.button_name(key_index)
	end

	button_texture_data = ButtonTextureByName(button_name, platform)

	return button_texture_data, button_name, keymap_binding
end

return
