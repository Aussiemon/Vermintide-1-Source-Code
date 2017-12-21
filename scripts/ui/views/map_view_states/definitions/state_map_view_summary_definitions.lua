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
			25
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			1920,
			50
		},
		position = {
			0,
			-10,
			35
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
	edge_left = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			238,
			1080
		},
		position = {
			-119,
			0,
			2
		}
	},
	edge_right = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "right",
		size = {
			238,
			1080
		},
		position = {
			119,
			0,
			2
		}
	},
	level_image = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			560,
			310
		},
		position = {
			0,
			45,
			2
		}
	},
	score_frame = {
		vertical_alignment = "bottom",
		parent = "level_image",
		horizontal_alignment = "center",
		size = {
			564,
			58
		},
		position = {
			0,
			-7,
			1
		}
	},
	level_image_frame = {
		vertical_alignment = "center",
		parent = "level_image",
		horizontal_alignment = "center",
		size = {
			573,
			326
		},
		position = {
			0,
			0,
			2
		}
	},
	title_holder = {
		vertical_alignment = "bottom",
		parent = "level_image_frame",
		horizontal_alignment = "center",
		size = {
			532,
			156
		},
		position = {
			0,
			-165,
			1
		}
	},
	level_name = {
		vertical_alignment = "top",
		parent = "level_image_frame",
		horizontal_alignment = "center",
		size = {
			800,
			40
		},
		position = {
			0,
			50,
			1
		}
	},
	game_mode_title = {
		vertical_alignment = "bottom",
		parent = "level_image_frame",
		horizontal_alignment = "center",
		size = {
			800,
			40
		},
		position = {
			0,
			-40,
			1
		}
	},
	game_mode_name = {
		vertical_alignment = "center",
		parent = "game_mode_title",
		horizontal_alignment = "center",
		size = {
			800,
			40
		},
		position = {
			0,
			-30,
			1
		}
	},
	divider = {
		vertical_alignment = "bottom",
		parent = "game_mode_name",
		horizontal_alignment = "center",
		size = {
			192,
			8
		},
		position = {
			0,
			-17,
			1
		}
	},
	difficulty_title = {
		vertical_alignment = "center",
		parent = "divider",
		horizontal_alignment = "center",
		size = {
			800,
			40
		},
		position = {
			0,
			-25,
			1
		}
	},
	difficulty_name = {
		vertical_alignment = "center",
		parent = "difficulty_title",
		horizontal_alignment = "center",
		size = {
			800,
			40
		},
		position = {
			0,
			-30,
			1
		}
	},
	difficulty_banner = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			340,
			850
		},
		position = {
			0,
			25,
			1
		}
	},
	setting_text_bg = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			564,
			58
		},
		position = {
			0,
			-360,
			10
		}
	},
	setting_text = {
		vertical_alignment = "center",
		parent = "setting_text_bg",
		horizontal_alignment = "center",
		size = {
			500,
			50
		},
		position = {
			2,
			3,
			8
		}
	},
	setting_arrow_up = {
		vertical_alignment = "center",
		parent = "setting_text",
		horizontal_alignment = "center",
		size = {
			28,
			34
		},
		position = {
			-2,
			40,
			2
		}
	},
	setting_arrow_down = {
		vertical_alignment = "center",
		parent = "setting_text",
		horizontal_alignment = "center",
		size = {
			28,
			34
		},
		position = {
			-1,
			-44,
			2
		}
	},
	setting_glow = {
		vertical_alignment = "bottom",
		parent = "setting_glow_mask",
		horizontal_alignment = "center",
		size = {
			500,
			600
		},
		position = {
			0,
			0,
			1
		}
	},
	setting_glow_mask = {
		vertical_alignment = "center",
		parent = "setting_text_bg",
		horizontal_alignment = "center",
		size = {
			600,
			48
		},
		position = {
			0,
			2,
			-2
		}
	}
}
local generic_input_actions = {
	default = {
		{
			input_action = "confirm",
			priority = 2,
			description_text = "start_game_menu_button_name"
		},
		{
			input_action = "back",
			priority = 3,
			description_text = "input_description_back"
		}
	}
}
local widgets = {
	overlay = UIWidgets.create_simple_rect("overlay", {
		170,
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
	title_text = UIWidgets.create_simple_text("console_map_screen_topic_level", "title_text", 24, Colors.get_table("cheeseburger")),
	background = UIWidgets.create_simple_texture("difficulty_bg", "frame"),
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
	edge_left = UIWidgets.create_simple_texture("game_mode_divider", "edge_left"),
	edge_right = UIWidgets.create_simple_texture("game_mode_divider", "edge_right"),
	difficulty_banner = UIWidgets.create_simple_texture("gamepad_difficulty_banner_1", "difficulty_banner"),
	difficulty_banner_masked = UIWidgets.create_simple_texture("gamepad_difficulty_banner_1", "difficulty_banner"),
	level_image = UIWidgets.create_simple_texture("level_image_any", "level_image"),
	level_image_masked = UIWidgets.create_simple_texture("level_image_any", "level_image", true),
	level_image_frame = UIWidgets.create_simple_texture("console_level_frame_01", "level_image_frame"),
	level_image_frame_masked = UIWidgets.create_simple_texture("console_level_frame_01", "level_image_frame", true),
	level_name = UIWidgets.create_simple_text("n/a", "level_name", 36, Colors.get_table("white")),
	score_frame = UIWidgets.create_simple_texture("difficulty_frame", "score_frame"),
	score_frame_masked = UIWidgets.create_simple_texture("difficulty_frame", "score_frame", true),
	game_mode_title = UIWidgets.create_simple_text("game_mode", "game_mode_title", 20, Colors.get_table("cheeseburger")),
	game_mode_name = UIWidgets.create_simple_text("n/a", "game_mode_name", 28, Colors.get_table("white")),
	difficulty_title = UIWidgets.create_simple_text("map_difficulty_setting", "difficulty_title", 20, Colors.get_table("cheeseburger")),
	difficulty_name = UIWidgets.create_simple_text("n/a", "difficulty_name", 28, Colors.get_table("white")),
	title_holder = UIWidgets.create_simple_texture("title_holder", "title_holder"),
	divider = UIWidgets.create_simple_texture("small_divider", "divider"),
	setting_text_bg = UIWidgets.create_simple_texture("difficulty_frame", "setting_text_bg"),
	setting_text = UIWidgets.create_simple_text("console_map_screen_topic_matchmaking_mode", "setting_text", 24, Colors.get_table("white")),
	setting_arrow_up = UIWidgets.create_simple_rotated_texture("settings_arrow_clicked", math.degrees_to_radians(90), {
		14,
		17
	}, "setting_arrow_up"),
	setting_arrow_down = UIWidgets.create_simple_rotated_texture("settings_arrow_clicked", math.degrees_to_radians(-90), {
		14,
		17
	}, "setting_arrow_down"),
	setting_glow = UIWidgets.create_simple_texture("start_game_detail_glow_masked", "setting_glow"),
	setting_glow_mask = UIWidgets.create_simple_texture("mask_rect", "setting_glow_mask")
}

return {
	widgets = widgets,
	scenegraph_definition = scenegraph_definition,
	generic_input_actions = generic_input_actions
}
