local player_name_max_length = 22
local player_list_navigation_helper = {
	input_function = function (widget, input_service)
		local content = widget.content

		if content.kick_enabled and input_service.get(input_service, "special_1", true) then
			return "kick"
		elseif input_service.get(input_service, "confirm", true) then
			return "gamercard"
		end

		return 
	end,
	input_description = {
		name = "stepper",
		gamepad_support = true,
		actions = {
			{
				input_action = "special_1",
				priority = 3,
				description_text = "map_setting_kick_player"
			}
		}
	}
}
local scenegraph_definition = {
	root = {
		is_root = true,
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.default
		}
	},
	dead_space_filler = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			0
		}
	},
	frame = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			1
		}
	},
	overlay = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			10
		}
	},
	title_holder = {
		vertical_alignment = "top",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			532,
			156
		},
		position = {
			0,
			-30,
			1
		}
	},
	title_holder_glow = {
		vertical_alignment = "top",
		parent = "title_holder",
		horizontal_alignment = "center",
		size = {
			290,
			150
		},
		position = {
			0,
			112,
			1
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "title_holder",
		horizontal_alignment = "center",
		size = {
			1920,
			50
		},
		position = {
			0,
			-82,
			1
		}
	},
	level_text = {
		vertical_alignment = "top",
		parent = "title_holder",
		horizontal_alignment = "center",
		size = {
			1920,
			50
		},
		position = {
			0,
			-40,
			1
		}
	},
	private_text = {
		vertical_alignment = "top",
		parent = "title_holder",
		horizontal_alignment = "center",
		size = {
			1920,
			50
		},
		position = {
			0,
			5,
			2
		}
	},
	frame_left = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			960,
			1080
		},
		position = {
			0,
			0,
			1
		}
	},
	frame_right = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "right",
		size = {
			960,
			1080
		},
		position = {
			0,
			0,
			1
		}
	},
	banner_pivot = {
		vertical_alignment = "top",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			0,
			0
		},
		position = {
			-250,
			-450,
			2
		}
	},
	menu_rect = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			430,
			1080
		},
		position = {
			0,
			0,
			1
		}
	},
	menu_pivot = {
		vertical_alignment = "center",
		parent = "menu_rect",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			-100,
			2
		}
	},
	menu_entry_1 = {
		vertical_alignment = "center",
		parent = "menu_pivot",
		horizontal_alignment = "center",
		size = {
			1000,
			60
		},
		position = {
			0,
			0,
			1
		}
	},
	menu_entry_2 = {
		vertical_alignment = "center",
		parent = "menu_pivot",
		horizontal_alignment = "center",
		size = {
			1000,
			60
		},
		position = {
			0,
			-60,
			1
		}
	},
	menu_entry_3 = {
		vertical_alignment = "center",
		parent = "menu_pivot",
		horizontal_alignment = "center",
		size = {
			1000,
			60
		},
		position = {
			0,
			-120,
			1
		}
	},
	menu_entry_5 = {
		vertical_alignment = "center",
		parent = "menu_pivot",
		horizontal_alignment = "center",
		size = {
			1000,
			60
		},
		position = {
			0,
			-210,
			1
		}
	},
	start_game_detail = {
		vertical_alignment = "center",
		parent = "menu_entry_5",
		horizontal_alignment = "center",
		size = {
			260,
			60
		},
		position = {
			-5,
			-70,
			2
		}
	},
	start_game_detail_glow = {
		vertical_alignment = "bottom",
		parent = "start_game_detail",
		horizontal_alignment = "center",
		size = {
			290,
			212
		},
		position = {
			0,
			42,
			-1
		}
	},
	level_image = {
		vertical_alignment = "top",
		parent = "menu_rect",
		horizontal_alignment = "center",
		size = {
			388,
			215
		},
		position = {
			0,
			-50,
			5
		}
	},
	level_image_frame = {
		vertical_alignment = "center",
		parent = "level_image",
		horizontal_alignment = "center",
		size = {
			408,
			245
		},
		position = {
			0,
			0,
			1
		}
	},
	game_info_bg = {
		vertical_alignment = "bottom",
		parent = "level_image_frame",
		horizontal_alignment = "center",
		size = {
			387,
			144
		},
		position = {
			0,
			-130,
			-1
		}
	},
	score_info_bg = {
		vertical_alignment = "bottom",
		parent = "game_info_bg",
		horizontal_alignment = "center",
		size = {
			387,
			98
		},
		position = {
			0,
			-88,
			-1
		}
	},
	game_info_title = {
		vertical_alignment = "top",
		parent = "game_info_bg",
		horizontal_alignment = "center",
		size = {
			370,
			20
		},
		position = {
			0,
			-38,
			1
		}
	},
	game_mode_prefix = {
		vertical_alignment = "top",
		parent = "game_info_bg",
		horizontal_alignment = "left",
		size = {
			370,
			20
		},
		position = {
			12,
			-56,
			1
		}
	},
	mission_prefix = {
		vertical_alignment = "bottom",
		parent = "game_mode_prefix",
		horizontal_alignment = "left",
		size = {
			370,
			20
		},
		position = {
			0,
			-20,
			1
		}
	},
	difficulty_prefix = {
		vertical_alignment = "bottom",
		parent = "mission_prefix",
		horizontal_alignment = "left",
		size = {
			370,
			20
		},
		position = {
			0,
			-20,
			1
		}
	},
	game_type_prefix = {
		vertical_alignment = "bottom",
		parent = "difficulty_prefix",
		horizontal_alignment = "left",
		size = {
			370,
			20
		},
		position = {
			0,
			-20,
			1
		}
	},
	score_prefix = {
		vertical_alignment = "top",
		parent = "score_info_bg",
		horizontal_alignment = "left",
		size = {
			370,
			20
		},
		position = {
			12,
			-31,
			1
		}
	},
	wave_prefix = {
		vertical_alignment = "bottom",
		parent = "score_prefix",
		horizontal_alignment = "left",
		size = {
			370,
			20
		},
		position = {
			0,
			-18,
			1
		}
	},
	time_prefix = {
		vertical_alignment = "bottom",
		parent = "wave_prefix",
		horizontal_alignment = "left",
		size = {
			370,
			20
		},
		position = {
			0,
			-20,
			1
		}
	},
	game_mode_value = {
		vertical_alignment = "center",
		parent = "game_mode_prefix",
		horizontal_alignment = "center",
		size = {
			358,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	mission_value = {
		vertical_alignment = "center",
		parent = "mission_prefix",
		horizontal_alignment = "center",
		size = {
			358,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	difficulty_value = {
		vertical_alignment = "center",
		parent = "difficulty_prefix",
		horizontal_alignment = "center",
		size = {
			358,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	game_type_value = {
		vertical_alignment = "center",
		parent = "game_type_prefix",
		horizontal_alignment = "center",
		size = {
			358,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	wave_value = {
		vertical_alignment = "center",
		parent = "wave_prefix",
		horizontal_alignment = "center",
		size = {
			358,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	time_value = {
		vertical_alignment = "center",
		parent = "time_prefix",
		horizontal_alignment = "center",
		size = {
			358,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	player_list_conuter_text = {
		vertical_alignment = "bottom",
		parent = "player_list_bg",
		horizontal_alignment = "center",
		size = {
			70,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	player_list_bg = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			461,
			215
		},
		position = {
			-80,
			110,
			10
		}
	},
	player_list_rect = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			400,
			200
		},
		position = {
			-50,
			50,
			2
		}
	},
	player_list_slot_1 = {
		vertical_alignment = "top",
		parent = "player_list_bg",
		horizontal_alignment = "left",
		size = {
			480,
			40
		},
		position = {
			12,
			-13,
			1
		}
	},
	player_list_slot_2 = {
		vertical_alignment = "top",
		parent = "player_list_slot_1",
		horizontal_alignment = "left",
		size = {
			480,
			40
		},
		position = {
			0,
			-40,
			1
		}
	},
	player_list_slot_3 = {
		vertical_alignment = "top",
		parent = "player_list_slot_2",
		horizontal_alignment = "left",
		size = {
			480,
			40
		},
		position = {
			0,
			-40,
			1
		}
	},
	player_list_slot_4 = {
		vertical_alignment = "top",
		parent = "player_list_slot_3",
		horizontal_alignment = "left",
		size = {
			480,
			40
		},
		position = {
			0,
			-40,
			1
		}
	},
	gamepad_node_player_list_slot_1 = {
		vertical_alignment = "center",
		parent = "player_list_slot_1",
		horizontal_alignment = "center",
		size = {
			400,
			60
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_player_list_slot_2 = {
		vertical_alignment = "center",
		parent = "player_list_slot_2",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_player_list_slot_3 = {
		vertical_alignment = "center",
		parent = "player_list_slot_3",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_player_list_slot_4 = {
		vertical_alignment = "center",
		parent = "player_list_slot_4",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	selection_anchor = {
		vertical_alignment = "center",
		parent = "menu_pivot",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			10
		},
		size = {
			0,
			60
		}
	},
	selection_glow_left = {
		vertical_alignment = "center",
		parent = "selection_anchor",
		horizontal_alignment = "left",
		position = {
			-98,
			0,
			10
		},
		size = {
			98,
			60
		}
	},
	selection_glow_right = {
		vertical_alignment = "center",
		parent = "selection_anchor",
		horizontal_alignment = "right",
		position = {
			98,
			0,
			10
		},
		size = {
			98,
			60
		}
	}
}
local menu_button_font_size = 36
local selection_font_increase = 10
local menu_button_definitions = {
	UIWidgets.create_text_button("menu_entry_1", "game_mode", menu_button_font_size),
	UIWidgets.create_text_button("menu_entry_2", "dlc1_2_map_game_mode_mission", menu_button_font_size),
	UIWidgets.create_text_button("menu_entry_3", "map_difficulty_setting", menu_button_font_size),
	UIWidgets.create_text_button("menu_entry_5", "start_game_menu_button_name", 48)
}
local game_info_text_score_title_style = {
	vertical_alignment = "top",
	font_type = "hell_shark",
	font_size = 18,
	horizontal_alignment = "center",
	text_color = Colors.get_table("cheeseburger"),
	offset = {
		0,
		0,
		2
	}
}
local game_info_text_prefix_style = {
	vertical_alignment = "top",
	font_type = "hell_shark",
	font_size = 18,
	horizontal_alignment = "left",
	text_color = Colors.get_table("cheeseburger"),
	offset = {
		0,
		0,
		2
	}
}
local game_info_text_value_style = {
	vertical_alignment = "top",
	font_type = "hell_shark",
	font_size = 18,
	horizontal_alignment = "right",
	text_color = {
		255,
		255,
		255,
		255
	},
	offset = {
		0,
		0,
		2
	}
}

local function create_difficulty_banner(scenegraph_id, gui)
	local banner_texture = "gamepad_difficulty_banner_" .. 1
	local gui_material = Gui.material(gui, banner_texture)

	Material.set_scalar(gui_material, "distortion_offset_top", 0)

	return {
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "banner_texture",
					texture_id = "banner_texture"
				}
			}
		},
		content = {
			locked = false,
			internal_progress = 0,
			banner_texture = banner_texture
		},
		style = {
			banner_texture = {
				size = {
					340,
					850
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-170,
					-425,
					1
				}
			}
		},
		offset = {
			0,
			0,
			0
		},
		scenegraph_id = scenegraph_id
	}
end

local num_players_tooltip = (Application.platform() == "xb1" and "map_number_of_players_tooltip_xb1") or "map_number_of_players_tooltip"
local widgets = {
	frame_left = UIWidgets.create_simple_texture("game_mode_fade", "frame_left"),
	frame_right = UIWidgets.create_simple_uv_texture("game_mode_fade", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "frame_right"),
	overlay = UIWidgets.create_simple_rect("overlay", {
		75,
		0,
		0,
		0
	}),
	menu_rect = UIWidgets.create_simple_rect("menu_rect", {
		170,
		0,
		0,
		0
	}),
	player_list_bg = UIWidgets.create_simple_texture("party_bg", "player_list_bg"),
	player_list_rect = UIWidgets.create_simple_rect("player_list_rect", {
		130,
		0,
		0,
		0
	}),
	dead_space_filler = UIWidgets.create_simple_rect("dead_space_filler", {
		255,
		0,
		0,
		0
	}),
	title_text = UIWidgets.create_simple_text("n/a", "title_text", 24),
	level_text = UIWidgets.create_simple_text("n/a", "level_text", 42, Colors.get_table("cheeseburger")),
	private_text = UIWidgets.create_simple_text("n/a", "private_text", 28),
	game_info_title = UIWidgets.create_simple_text(Localize("input_description_information"), "game_info_title", 18, nil, game_info_text_score_title_style),
	game_mode_prefix = UIWidgets.create_simple_text(Localize("game_mode") .. ":", "game_mode_prefix", 18, nil, game_info_text_prefix_style),
	mission_prefix = UIWidgets.create_simple_text(Localize("dlc1_2_map_game_mode_mission") .. ":", "mission_prefix", 18, nil, game_info_text_prefix_style),
	difficulty_prefix = UIWidgets.create_simple_text(Localize("map_difficulty_setting") .. ":", "difficulty_prefix", 18, nil, game_info_text_prefix_style),
	game_type_prefix = UIWidgets.create_simple_text(Localize("map_privacy_setting") .. ":", "game_type_prefix", 18, nil, game_info_text_prefix_style),
	score_prefix = UIWidgets.create_simple_text(Localize("dlc1_2_map_best_performance"), "score_prefix", 18, nil, game_info_text_score_title_style),
	wave_prefix = UIWidgets.create_simple_text(Localize("dlc1_2_end_screen_waves") .. ":", "wave_prefix", 18, nil, game_info_text_prefix_style),
	time_prefix = UIWidgets.create_simple_text(Localize("dlc1_2_end_screen_time") .. ":", "time_prefix", 18, nil, game_info_text_prefix_style),
	game_mode_value = UIWidgets.create_simple_text("n/a", "game_mode_value", 18, nil, game_info_text_value_style),
	mission_value = UIWidgets.create_simple_text("n/a", "mission_value", 18, nil, game_info_text_value_style),
	difficulty_value = UIWidgets.create_simple_text("n/a", "difficulty_value", 18, nil, game_info_text_value_style),
	game_type_value = UIWidgets.create_simple_text("n/a", "game_type_value", 18, nil, game_info_text_value_style),
	wave_value = UIWidgets.create_simple_text("n/a", "wave_value", 18, nil, game_info_text_value_style),
	time_value = UIWidgets.create_simple_text("n/a", "time_value", 18, nil, game_info_text_value_style),
	background = UIWidgets.create_simple_texture("overview_bg", "frame"),
	level_image = UIWidgets.create_simple_texture("map_ubersreik", "level_image"),
	level_image_frame = UIWidgets.create_simple_texture("console_level_frame_02", "level_image_frame"),
	game_info_bg = UIWidgets.create_simple_texture("level_frame_addon_02", "game_info_bg"),
	score_info_bg = UIWidgets.create_simple_texture("level_frame_addon_01", "score_info_bg"),
	title_holder = UIWidgets.create_simple_texture("title_holder", "title_holder"),
	title_holder_glow = UIWidgets.create_simple_texture("start_game_detail_glow", "title_holder_glow"),
	start_game_detail = UIWidgets.create_simple_texture("start_game_detail", "start_game_detail"),
	start_game_detail_glow = UIWidgets.create_simple_texture("start_game_detail_glow", "start_game_detail_glow"),
	start_screen_selection_left = UIWidgets.create_simple_texture("start_screen_selection_left", "selection_glow_left"),
	start_screen_selection_right = UIWidgets.create_simple_texture("start_screen_selection_right", "selection_glow_right"),
	player_list_slot_1 = UIWidgets.create_map_player_entry("player_list_slot_1", "gamepad_node_player_list_slot_1"),
	player_list_slot_2 = UIWidgets.create_map_player_entry("player_list_slot_2", "gamepad_node_player_list_slot_2"),
	player_list_slot_3 = UIWidgets.create_map_player_entry("player_list_slot_3", "gamepad_node_player_list_slot_3"),
	player_list_slot_4 = UIWidgets.create_map_player_entry("player_list_slot_4", "gamepad_node_player_list_slot_4"),
	player_list_conuter_text = UIWidgets.create_simple_text_tooltip("", num_players_tooltip, "player_list_conuter_text", nil, nil, {
		vertical_alignment = "center",
		word_wrap = true,
		font_type = "hell_shark",
		font_size = 24,
		horizontal_alignment = "center",
		text_color = Colors.get_color_table_with_alpha("white", 255),
		offset = {
			0,
			0,
			2
		}
	})
}
local platform = Application.platform()
local generic_input_actions = {
	default = {
		{
			input_action = "left_stick_press",
			priority = 1,
			description_text = "input_description_change_privacy"
		},
		{
			input_action = "refresh",
			priority = 2,
			description_text = "input_description_friends"
		},
		{
			input_action = "confirm",
			priority = 4,
			description_text = "input_description_select"
		},
		{
			input_action = "back",
			priority = 5,
			description_text = "input_description_close"
		}
	},
	player_list = {
		{
			input_action = "left_stick_press",
			priority = 1,
			description_text = "input_description_change_privacy"
		},
		{
			input_action = "refresh",
			priority = 2,
			description_text = "input_description_friends"
		},
		{
			input_action = "confirm",
			priority = 4,
			description_text = (platform == "win32" and "input_description_show_profile") or (platform == "xb1" and "input_description_show_profile_xb1") or (platform == "ps4" and "input_description_show_profile")
		},
		{
			input_action = "back",
			priority = 5,
			description_text = "input_description_close"
		}
	}
}
local text_colors = {
	text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
	text_color_selected = Colors.get_color_table_with_alpha("white", 255)
}

return {
	player_list_navigation_helper = player_list_navigation_helper,
	create_difficulty_banner = create_difficulty_banner,
	menu_button_definitions = menu_button_definitions,
	selection_font_increase = selection_font_increase,
	player_name_max_length = player_name_max_length,
	menu_button_font_size = menu_button_font_size,
	generic_input_actions = generic_input_actions,
	scenegraph_definition = scenegraph_definition,
	text_colors = text_colors,
	widgets = widgets
}
