local_require("scripts/ui/ui_widgets")

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
	page_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			0,
			0,
			1
		}
	},
	frame = {
		vertical_alignment = "center",
		parent = "page_root",
		horizontal_alignment = "center",
		size = {
			592,
			902
		},
		position = {
			0,
			0,
			3
		}
	},
	frame_background = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			564,
			834
		},
		position = {
			0,
			12,
			-1
		}
	},
	background_eye_glow_left = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			48,
			20
		},
		position = {
			-207,
			159,
			1
		}
	},
	background_eye_glow_right = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			48,
			20
		},
		position = {
			211,
			163,
			1
		}
	},
	text_frame = {
		vertical_alignment = "top",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			480,
			275
		},
		position = {
			0,
			-530,
			1
		}
	},
	text_frame_title = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			480,
			50
		},
		position = {
			0,
			-5,
			1
		}
	},
	text_frame_item_name = {
		vertical_alignment = "top",
		parent = "text_frame_title",
		horizontal_alignment = "center",
		size = {
			480,
			50
		},
		position = {
			0,
			-40,
			1
		}
	},
	text_frame_reward_divider = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			386,
			22
		},
		position = {
			0,
			-95,
			1
		}
	},
	text_frame_reward_title = {
		vertical_alignment = "center",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			480,
			50
		},
		position = {
			0,
			0,
			1
		}
	},
	text_frame_reward_icon = {
		vertical_alignment = "bottom",
		parent = "text_frame_reward_title",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			-65,
			1
		}
	},
	text_frame_reward_text = {
		vertical_alignment = "bottom",
		parent = "text_frame_reward_icon",
		horizontal_alignment = "right",
		size = {
			40,
			40
		},
		position = {
			-65,
			10,
			1
		}
	},
	melt_button = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			155,
			160
		},
		position = {
			-0.5,
			115,
			2
		}
	},
	progress_bar_bg = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			303,
			59
		},
		position = {
			0,
			-27,
			2
		}
	},
	progress_bar_abort_text = {
		vertical_alignment = "center",
		parent = "progress_bar_bg",
		horizontal_alignment = "center",
		size = {
			321,
			42
		},
		position = {
			0,
			0,
			1
		}
	},
	progress_bar = {
		vertical_alignment = "center",
		parent = "progress_bar_bg",
		horizontal_alignment = "left",
		size = {
			0,
			42
		},
		position = {
			36,
			0,
			1
		}
	},
	progress_bar_fg = {
		vertical_alignment = "center",
		parent = "progress_bar_bg",
		horizontal_alignment = "center",
		size = {
			303,
			59
		},
		position = {
			0,
			0,
			2
		}
	},
	progress_bar_glow = {
		vertical_alignment = "center",
		parent = "progress_bar_bg",
		horizontal_alignment = "center",
		size = {
			303,
			59
		},
		position = {
			0,
			0,
			3
		}
	},
	description_text_1 = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			501,
			40
		},
		position = {
			0,
			322,
			1
		}
	},
	title_text = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			501,
			40
		},
		position = {
			0,
			380,
			1
		}
	}
}
local widgets_definitions = {
	gamepad_input = UIWidgets.create_gamepad_bar_input_extension("progress_bar"),
	progress_bar_bg = UIWidgets.create_simple_texture("forge_progress_bar_bg", "progress_bar_bg"),
	progress_bar_fg = UIWidgets.create_simple_texture("forge_progress_bar_fg", "progress_bar_fg"),
	progress_bar = UIWidgets.create_simple_texture("forge_progress_bar_fill", "progress_bar"),
	progress_bar_glow = UIWidgets.create_simple_texture("forge_progress_bar_glow", "progress_bar_glow"),
	progress_bar_abort_text = UIWidgets.create_simple_text("forge_screen_melt_abort", "progress_bar_abort_text", 24, Colors.get_color_table_with_alpha("red", 0)),
	frame_widget = UIWidgets.create_simple_texture("character_selection_bg", "frame"),
	frame_background_widget = UIWidgets.create_simple_texture("forge_salvage_bg", "frame_background"),
	eye_glow_left_widget = UIWidgets.create_simple_texture("forge_salvage_glow_effect", "background_eye_glow_left"),
	eye_glow_right_widget = UIWidgets.create_simple_uv_texture("forge_salvage_glow_effect", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "background_eye_glow_right"),
	text_frame_reward_divider = UIWidgets.create_simple_texture("summary_screen_line_breaker", "text_frame_reward_divider"),
	melt_button_widget = UIWidgets.create_forge_toggle_button("forge_button_01_normal", "forge_button_01_hover", "forge_button_01_selected", "forge_button_01_selected_hover", "melt_button", "melt_button"),
	text_frame_title = UIWidgets.create_simple_text("salvage_result_title_text", "text_frame_title", 24, Colors.get_color_table_with_alpha("white", 0)),
	text_frame_item_name = UIWidgets.create_simple_text("salvage_item_name", "text_frame_item_name", 28, Colors.get_color_table_with_alpha("yellow", 0), nil, "hell_shark_header"),
	text_frame_reward_title = UIWidgets.create_simple_text("salvage_reward_title_text", "text_frame_reward_title", 24, Colors.get_color_table_with_alpha("white", 0)),
	text_frame_reward_icon = UIWidgets.create_texture_with_text("forge_icon_iron", "", "text_frame_reward_icon", "text_frame_reward_text", {
		vertical_alignment = "center",
		scenegraph_id = "text_frame_reward_text",
		horizontal_alignment = "right",
		word_wrap = true,
		font_size = 20,
		font_type = "hell_shark",
		text_color = Colors.get_table("white")
	}),
	description_text_1 = UIWidgets.create_simple_text("melt_description_1", "description_text_1", 24, Colors.get_color_table_with_alpha("white", 255)),
	title_text = UIWidgets.create_simple_text("forge_title_salvage", "title_text", 32, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header")
}
local settings = {
	num_item_buttons = 5
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets_definitions = widgets_definitions,
	settings = settings
}
