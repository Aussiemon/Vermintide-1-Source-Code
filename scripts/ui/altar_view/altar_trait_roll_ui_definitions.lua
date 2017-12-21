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
			30
		}
	},
	framebackground_rect = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			582,
			895
		},
		position = {
			0,
			0,
			-2
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
	background_candle_top_left = {
		vertical_alignment = "top",
		parent = "frame_background",
		horizontal_alignment = "left",
		size = {
			5,
			11
		},
		position = {
			115,
			-136,
			2
		}
	},
	background_candle_left = {
		vertical_alignment = "top",
		parent = "frame_background",
		horizontal_alignment = "left",
		size = {
			5,
			11
		},
		position = {
			64,
			-213,
			2
		}
	},
	background_candle_right = {
		vertical_alignment = "top",
		parent = "frame_background",
		horizontal_alignment = "right",
		size = {
			5,
			11
		},
		position = {
			-95,
			-170,
			2
		}
	},
	candle_glow_top_left = {
		vertical_alignment = "center",
		parent = "background_candle_top_left",
		horizontal_alignment = "center",
		size = {
			74,
			75
		},
		position = {
			0,
			0,
			-1
		}
	},
	candle_glow_left = {
		vertical_alignment = "center",
		parent = "background_candle_left",
		horizontal_alignment = "center",
		size = {
			74,
			75
		},
		position = {
			0,
			0,
			-1
		}
	},
	candle_glow_right = {
		vertical_alignment = "center",
		parent = "background_candle_right",
		horizontal_alignment = "center",
		size = {
			74,
			75
		},
		position = {
			0,
			0,
			-1
		}
	},
	text_frame = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			450,
			190
		},
		position = {
			0,
			200,
			1
		}
	},
	text_frame_title = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			430,
			50
		},
		position = {
			0,
			-20,
			1
		}
	},
	text_frame_description = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			430,
			110
		},
		position = {
			0,
			-70,
			1
		}
	},
	reroll_button = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			318,
			84
		},
		position = {
			0,
			86,
			3
		}
	},
	reroll_button_text = {
		vertical_alignment = "center",
		parent = "reroll_button",
		horizontal_alignment = "left",
		size = {
			60,
			20
		},
		position = {
			20,
			-4,
			1
		}
	},
	reroll_button_token = {
		vertical_alignment = "center",
		parent = "reroll_button",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			110,
			-4,
			1
		}
	},
	reroll_button_fill = {
		vertical_alignment = "center",
		parent = "reroll_button",
		horizontal_alignment = "left",
		size = {
			307,
			69
		},
		position = {
			16,
			-10,
			-1
		}
	},
	rotating_root = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			103,
			4
		}
	},
	rotating_disk_bg = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			343,
			336
		},
		position = {
			0,
			-1,
			-1
		}
	},
	rotating_disk = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			312,
			312
		},
		position = {
			0,
			0,
			2
		}
	},
	rotating_disk_glow = {
		vertical_alignment = "center",
		parent = "rotating_disk",
		horizontal_alignment = "center",
		size = {
			460,
			460
		},
		position = {
			-9,
			-7,
			1
		}
	},
	item_button_bg = {
		vertical_alignment = "center",
		parent = "rotating_disk",
		horizontal_alignment = "center",
		size = {
			114,
			114
		},
		position = {
			0,
			0,
			1
		}
	},
	item_button_bg_glow = {
		vertical_alignment = "center",
		parent = "item_button_bg",
		horizontal_alignment = "center",
		size = {
			180,
			180
		},
		position = {
			-2,
			0,
			10
		}
	},
	item_button = {
		vertical_alignment = "center",
		parent = "item_button_bg",
		horizontal_alignment = "center",
		size = {
			78,
			79
		},
		position = {
			0,
			-1,
			1
		}
	},
	item_button_icon = {
		vertical_alignment = "center",
		parent = "item_button",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			1,
			1
		}
	},
	trait_button_1 = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			5
		}
	},
	trait_button_2 = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			5
		}
	},
	trait_button_3 = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			5
		}
	},
	trait_button_4 = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			5
		}
	},
	trait_button_5 = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			5
		}
	},
	trait_button_6 = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			5
		}
	},
	trait_button_7 = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			5
		}
	},
	trait_button_8 = {
		vertical_alignment = "center",
		parent = "rotating_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			5
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
	},
	expand_frame = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			585,
			898
		},
		position = {
			2,
			0,
			-3
		}
	},
	expand_frame_background = {
		vertical_alignment = "center",
		parent = "expand_frame",
		horizontal_alignment = "right",
		size = {
			1232,
			885
		},
		position = {
			-4,
			0,
			-1
		}
	},
	preview_window_1 = {
		vertical_alignment = "center",
		parent = "preview_window_2",
		horizontal_alignment = "left",
		size = {
			550,
			780
		},
		position = {
			-610,
			0,
			0
		}
	},
	preview_window_2 = {
		vertical_alignment = "center",
		parent = "expand_frame_background",
		horizontal_alignment = "right",
		size = {
			550,
			780
		},
		position = {
			-37,
			-20,
			1
		}
	},
	preview_window_1_title = {
		vertical_alignment = "top",
		parent = "preview_window_1",
		horizontal_alignment = "center",
		size = {
			550,
			40
		},
		position = {
			0,
			50,
			1
		}
	},
	preview_window_2_title = {
		vertical_alignment = "top",
		parent = "preview_window_2",
		horizontal_alignment = "center",
		size = {
			550,
			40
		},
		position = {
			0,
			50,
			1
		}
	},
	pw_1_corner_root = {
		vertical_alignment = "center",
		parent = "preview_window_1",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	pw_2_corner_root = {
		vertical_alignment = "center",
		parent = "preview_window_2",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	pw_1_corner_top_left = {
		vertical_alignment = "top",
		parent = "pw_1_corner_root",
		horizontal_alignment = "left",
		size = {
			160,
			241
		},
		position = {
			-297.5,
			412.5,
			1
		}
	},
	pw_1_corner_top_right = {
		vertical_alignment = "top",
		parent = "pw_1_corner_root",
		horizontal_alignment = "right",
		size = {
			159,
			241
		},
		position = {
			297.5,
			412.5,
			1
		}
	},
	pw_1_corner_bottom_left = {
		vertical_alignment = "bottom",
		parent = "pw_1_corner_root",
		horizontal_alignment = "left",
		size = {
			160,
			241
		},
		position = {
			-297.5,
			-412.5,
			1
		}
	},
	pw_1_corner_bottom_right = {
		vertical_alignment = "bottom",
		parent = "pw_1_corner_root",
		horizontal_alignment = "right",
		size = {
			159,
			241
		},
		position = {
			297.5,
			-412.5,
			1
		}
	},
	pw_2_corner_top_left = {
		vertical_alignment = "top",
		parent = "pw_2_corner_root",
		horizontal_alignment = "left",
		size = {
			160,
			241
		},
		position = {
			-297.5,
			412.5,
			1
		}
	},
	pw_2_corner_top_right = {
		vertical_alignment = "top",
		parent = "pw_2_corner_root",
		horizontal_alignment = "right",
		size = {
			159,
			241
		},
		position = {
			297.5,
			412.5,
			1
		}
	},
	pw_2_corner_bottom_left = {
		vertical_alignment = "bottom",
		parent = "pw_2_corner_root",
		horizontal_alignment = "left",
		size = {
			160,
			241
		},
		position = {
			-297.5,
			-412.5,
			1
		}
	},
	pw_2_corner_bottom_right = {
		vertical_alignment = "bottom",
		parent = "pw_2_corner_root",
		horizontal_alignment = "right",
		size = {
			159,
			241
		},
		position = {
			297.5,
			-412.5,
			1
		}
	},
	preview_trait_root_1 = {
		vertical_alignment = "top",
		parent = "preview_window_1",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			40,
			-40,
			1
		}
	},
	preview_trait_root_2 = {
		vertical_alignment = "top",
		parent = "preview_window_2",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			40,
			-40,
			1
		}
	},
	trait_preview_1 = {
		vertical_alignment = "top",
		parent = "preview_trait_root_1",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_preview_2 = {
		vertical_alignment = "top",
		parent = "preview_trait_root_1",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_preview_3 = {
		vertical_alignment = "top",
		parent = "preview_trait_root_1",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_preview_4 = {
		vertical_alignment = "top",
		parent = "preview_trait_root_1",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_preview_5 = {
		vertical_alignment = "top",
		parent = "preview_trait_root_2",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_preview_6 = {
		vertical_alignment = "top",
		parent = "preview_trait_root_2",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_preview_7 = {
		vertical_alignment = "top",
		parent = "preview_trait_root_2",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_preview_8 = {
		vertical_alignment = "top",
		parent = "preview_trait_root_2",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_description_1 = {
		vertical_alignment = "top",
		parent = "trait_preview_1",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			3
		}
	},
	trait_description_2 = {
		vertical_alignment = "top",
		parent = "trait_preview_2",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			3
		}
	},
	trait_description_3 = {
		vertical_alignment = "top",
		parent = "trait_preview_3",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			3
		}
	},
	trait_description_4 = {
		vertical_alignment = "top",
		parent = "trait_preview_4",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			3
		}
	},
	trait_description_5 = {
		vertical_alignment = "top",
		parent = "trait_preview_5",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			3
		}
	},
	trait_description_6 = {
		vertical_alignment = "top",
		parent = "trait_preview_6",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			3
		}
	},
	trait_description_7 = {
		vertical_alignment = "top",
		parent = "trait_preview_7",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			3
		}
	},
	trait_description_8 = {
		vertical_alignment = "top",
		parent = "trait_preview_8",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			3
		}
	},
	preview_window_1_button = {
		vertical_alignment = "bottom",
		parent = "preview_window_1",
		horizontal_alignment = "center",
		size = {
			318,
			84
		},
		position = {
			0,
			40,
			1
		}
	},
	preview_window_2_button = {
		vertical_alignment = "bottom",
		parent = "preview_window_2",
		horizontal_alignment = "center",
		size = {
			318,
			84
		},
		position = {
			0,
			40,
			1
		}
	}
}
local widgets_definitions = {
	rotating_disk_widget = UIWidgets.create_simple_rotated_texture("reroll_trait_fg", 0, {
		156,
		156
	}, "rotating_disk"),
	rotating_disk_bg_widget = UIWidgets.create_simple_texture("reroll_trait_fg_02", "rotating_disk_bg"),
	rotating_disk_glow_widget = UIWidgets.create_simple_texture("reroll_glow_large", "rotating_disk_glow"),
	item_button_bg_widget = UIWidgets.create_simple_texture("reroll_trait_slot_02", "item_button_bg"),
	item_button_bg_glow_widget = UIWidgets.create_simple_texture("reroll_glow_medium", "item_button_bg_glow"),
	frame_widget = UIWidgets.create_simple_texture("character_selection_bg", "frame"),
	frame_background_rect = UIWidgets.create_simple_rect("framebackground_rect", {
		255,
		0,
		0,
		0
	}),
	frame_background_widget = UIWidgets.create_simple_texture("reroll_trait_bg", "frame_background"),
	background_candle_left_top_widget = UIWidgets.create_simple_texture("candle_glow_02", "background_candle_top_left"),
	background_candle_left_widget = UIWidgets.create_simple_texture("candle_glow_02", "background_candle_left"),
	background_candle_right_widget = UIWidgets.create_simple_texture("candle_glow_02", "background_candle_right"),
	candle_glow_left_top_widget = UIWidgets.create_simple_texture("candle_glow_01", "candle_glow_top_left"),
	candle_glow_left_widget = UIWidgets.create_simple_texture("candle_glow_01", "candle_glow_left"),
	candle_glow_right_widget = UIWidgets.create_simple_texture("candle_glow_01", "candle_glow_right"),
	reroll_button_widget = UIWidgets.create_altar_button("altar_trait_roll_button_text", "reroll_button", "reroll_button_text", "reroll_button_token", "reroll_button_fill"),
	item_button_widget = UIWidgets.create_attach_icon_button(nil, "item_button", "item_button_icon", scenegraph_definition.item_button_icon.size),
	text_frame_title = UIWidgets.create_simple_text("", "text_frame_title", 28, Colors.get_color_table_with_alpha("cheeseburger", 255), {
		font_size = 28,
		localize = true,
		word_wrap = true,
		pixel_perfect = true,
		horizontal_alignment = "left",
		vertical_alignment = "top",
		dynamic_font = true,
		font_type = "hell_shark_header",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	text_frame_description = UIWidgets.create_simple_text("", "text_frame_description", 18, Colors.get_color_table_with_alpha("white", 255), {
		font_size = 18,
		localize = false,
		word_wrap = true,
		pixel_perfect = true,
		horizontal_alignment = "left",
		vertical_alignment = "top",
		dynamic_font = true,
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("white", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	trait_button_1 = UIWidgets.create_small_reroll_trait_button("trait_button_1", "trait_button_1"),
	trait_button_2 = UIWidgets.create_small_reroll_trait_button("trait_button_2", "trait_button_2"),
	trait_button_3 = UIWidgets.create_small_reroll_trait_button("trait_button_3", "trait_button_3"),
	trait_button_4 = UIWidgets.create_small_reroll_trait_button("trait_button_4", "trait_button_4"),
	trait_button_5 = UIWidgets.create_small_reroll_trait_button("trait_button_5", "trait_button_5"),
	trait_button_6 = UIWidgets.create_small_reroll_trait_button("trait_button_6", "trait_button_6"),
	trait_button_7 = UIWidgets.create_small_reroll_trait_button("trait_button_7", "trait_button_7"),
	trait_button_8 = UIWidgets.create_small_reroll_trait_button("trait_button_8", "trait_button_8"),
	description_text_1 = UIWidgets.create_simple_text("altar_trait_roll_description_1", "description_text_1", 24, Colors.get_color_table_with_alpha("white", 255)),
	title_text = UIWidgets.create_simple_text("altar_title_reroll", "title_text", 32, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header"),
	preview_window_1_button = UIWidgets.create_altar_button("altar_trait_roll_option_button_text", "preview_window_1_button"),
	preview_window_2_button = UIWidgets.create_altar_button("altar_trait_roll_option_button_text", "preview_window_2_button"),
	expand_frame_widget = UIWidgets.create_simple_frame("gold_frame_01_complete", {
		198,
		199
	}, {
		66,
		66
	}, {
		12,
		66
	}, {
		66,
		12
	}, "expand_frame"),
	expand_frame_background = UIWidgets.create_simple_uv_texture("trait_reroll_window_bg", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "expand_frame_background"),
	preview_window_1 = UIWidgets.create_simple_hotspot("preview_window_1"),
	preview_window_2 = UIWidgets.create_simple_hotspot("preview_window_2"),
	preview_window_1_corner = UIWidgets.create_corner_frame_animation_widget("pw_1_corner_root", "pw_1_corner_top_left", "pw_1_corner_top_right", "pw_1_corner_bottom_left", "pw_1_corner_bottom_right"),
	preview_window_2_corner = UIWidgets.create_corner_frame_animation_widget("pw_2_corner_root", "pw_2_corner_top_left", "pw_2_corner_top_right", "pw_2_corner_bottom_left", "pw_2_corner_bottom_right"),
	preview_window_1_title = UIWidgets.create_simple_text("altar_trait_roll_option_text_1", "preview_window_1_title", 32, Colors.get_color_table_with_alpha("cheeseburger", 0), nil, "hell_shark_header"),
	preview_window_2_title = UIWidgets.create_simple_text("altar_trait_roll_option_text_2", "preview_window_2_title", 32, Colors.get_color_table_with_alpha("cheeseburger", 0), nil, "hell_shark_header")
}
local traits_preview_definitions = {
	trait_preview_1 = UIWidgets.create_compare_menu_trait_widget("trait_preview_1", "trait_description_1"),
	trait_preview_2 = UIWidgets.create_compare_menu_trait_widget("trait_preview_2", "trait_description_2"),
	trait_preview_3 = UIWidgets.create_compare_menu_trait_widget("trait_preview_3", "trait_description_3"),
	trait_preview_4 = UIWidgets.create_compare_menu_trait_widget("trait_preview_4", "trait_description_4"),
	trait_preview_5 = UIWidgets.create_compare_menu_trait_widget("trait_preview_5", "trait_description_5"),
	trait_preview_6 = UIWidgets.create_compare_menu_trait_widget("trait_preview_6", "trait_description_6"),
	trait_preview_7 = UIWidgets.create_compare_menu_trait_widget("trait_preview_7", "trait_description_7"),
	trait_preview_8 = UIWidgets.create_compare_menu_trait_widget("trait_preview_8", "trait_description_8")
}
local animations = {
	preview_window_open = {
		{
			name = "open_window",
			start_progress = 0,
			end_progress = 0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local expand_frame_default_size = scenegraph_definition.expand_frame.size
				local expand_frame_background_default_size = scenegraph_definition.expand_frame_background.size
				ui_scenegraph.expand_frame.size[1] = expand_frame_default_size[1]
				ui_scenegraph.expand_frame_background.size[1] = expand_frame_background_default_size[1]

				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_window_move")

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local expand_frame_default_size = scenegraph_definition.expand_frame.size
				local expand_frame_background_default_size = scenegraph_definition.expand_frame_background.size
				local progress = math.easeOutCubic(local_progress)
				local width_increase = progress*1236
				ui_scenegraph.expand_frame.size[1] = expand_frame_default_size[1] + width_increase
				ui_scenegraph.expand_frame_background.size[1] = progress*expand_frame_background_default_size[1]
				local background_uvs = widgets.expand_frame_background.content.texture_id.uvs
				background_uvs[1][1] = progress - 1

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_1_corners",
			start_progress = 0.5,
			end_progress = 0.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local alpha = 0
				widget_style_global.texture_color[1] = alpha

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local alpha = math.easeCubic(local_progress)*255
				widget_style_global.texture_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_2_corners",
			start_progress = 0.5,
			end_progress = 0.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local alpha = 0
				widget_style_global.texture_color[1] = alpha

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local alpha = math.easeCubic(local_progress)*255
				widget_style_global.texture_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_1_traits",
			start_progress = 0.5,
			end_progress = 0.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local alpha = 0

				for i = 1, 4, 1 do
					local widget = widgets["trait_preview_" .. i]
					local style = widget.style
					style.texture_id.color[1] = alpha
					style.texture_lock_id.color[1] = alpha
					style.texture_bg_id.color[1] = alpha
					style.description_text.text_color[1] = alpha
					style.title_text.text_color[1] = alpha
					style.text_divider_texture.color[1] = alpha

					if style.description_text.last_line_color then
						style.description_text.last_line_color[1] = alpha
					end

					widget.content.visible = false
				end

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = math.easeInCubic(local_progress)*255

				for i = 1, 4, 1 do
					local widget = widgets["trait_preview_" .. i]
					local style = widget.style
					style.texture_id.color[1] = alpha
					style.texture_lock_id.color[1] = alpha
					style.texture_bg_id.color[1] = alpha
					style.description_text.text_color[1] = alpha
					style.title_text.text_color[1] = alpha
					style.text_divider_texture.color[1] = alpha

					if style.description_text.last_line_color then
						style.description_text.last_line_color[1] = alpha
					end

					if not widget.content.visible then
						widget.content.visible = true
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_2_traits",
			start_progress = 0.5,
			end_progress = 0.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local alpha = 0

				for i = 5, 8, 1 do
					local widget = widgets["trait_preview_" .. i]
					local style = widget.style
					style.texture_id.color[1] = alpha
					style.texture_lock_id.color[1] = alpha
					style.texture_bg_id.color[1] = alpha
					style.description_text.text_color[1] = alpha
					style.title_text.text_color[1] = alpha
					style.text_divider_texture.color[1] = alpha

					if style.description_text.last_line_color then
						style.description_text.last_line_color[1] = alpha
					end

					widget.content.visible = false
				end

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = math.easeInCubic(local_progress)*255

				for i = 5, 8, 1 do
					local widget = widgets["trait_preview_" .. i]
					local style = widget.style
					style.texture_id.color[1] = alpha
					style.texture_lock_id.color[1] = alpha
					style.texture_bg_id.color[1] = alpha
					style.description_text.text_color[1] = alpha
					style.title_text.text_color[1] = alpha
					style.text_divider_texture.color[1] = alpha

					if style.description_text.last_line_color then
						style.description_text.last_line_color[1] = alpha
					end

					if not widget.content.visible then
						widget.content.visible = true
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_1_title",
			start_progress = 0.5,
			end_progress = 0.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local alpha = 0
				local widget = widgets.preview_window_1_title
				widget.style.text.text_color[1] = alpha

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = math.easeInCubic(local_progress)*255
				local widget = widgets.preview_window_1_title
				widget.style.text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_2_title",
			start_progress = 0.5,
			end_progress = 0.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local alpha = 0
				local widget = widgets.preview_window_2_title
				widget.style.text.text_color[1] = alpha

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = math.easeInCubic(local_progress)*255
				local widget = widgets.preview_window_2_title
				widget.style.text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_in_preview_window_2_traits = {
		{
			name = "delay",
			start_progress = 0,
			end_progress = 0.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_window_2_traits",
			start_progress = 0.7,
			end_progress = 1.35,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local progress = math.easeOutCubic(local_progress)
				local alpha = progress*255

				for i = 5, 8, 1 do
					local widget = widgets["trait_preview_" .. i]
					local style = widget.style

					if style.description_text.text_color[1] < alpha then
						style.texture_id.color[1] = alpha
						style.texture_lock_id.color[1] = alpha
						style.texture_bg_id.color[1] = alpha
						style.description_text.text_color[1] = alpha
						style.title_text.text_color[1] = alpha
						style.text_divider_texture.color[1] = alpha

						if style.description_text.last_line_color then
							style.description_text.last_line_color[1] = alpha
						end
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_out_preview_window_2_traits = {
		{
			name = "fade_out_window_2_traits",
			start_progress = 0,
			end_progress = 0.35,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local progress = math.easeOutCubic(local_progress)
				local alpha = (progress - 1)*255

				for i = 5, 8, 1 do
					local widget = widgets["trait_preview_" .. i]
					local style = widget.style

					if alpha < style.description_text.text_color[1] then
						style.texture_id.color[1] = alpha
						style.texture_lock_id.color[1] = alpha
						style.texture_bg_id.color[1] = alpha
						style.description_text.text_color[1] = alpha
						style.title_text.text_color[1] = alpha
						style.text_divider_texture.color[1] = alpha

						if style.description_text.last_line_color then
							style.description_text.last_line_color[1] = alpha
						end
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_in_window_1_corner_glow = {
		{
			name = "fade_in_window_1_corner_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_hover")

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local alpha = local_progress*255

				if widget_style_global.glow_corner_color[1] < alpha then
					widget_style_global.glow_corner_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_1_button_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_button
				local widget_style = widget.style
				local alpha = local_progress*255

				if widget_style.button_frame_glow_texture.color[1] < alpha then
					widget_style.button_frame_glow_texture.color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_disk_traits",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = local_progress*255

				for i = 1, 4, 1 do
					local widget_name = "trait_button_" .. i
					local widget = widgets[widget_name]
					local widget_style = widget.style
					local color = widget_style.texture_glow_id.color

					if color[1] < alpha then
						color[1] = alpha
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_1_corners_skull_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local alpha = 0
				widget_style_global.glow_skull_color[1] = alpha

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local alpha = local_progress*255

				if widget_style_global.glow_skull_color[1] < alpha then
					widget_style_global.glow_skull_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_out_window_1_corner_glow = {
		{
			name = "fade_out_window_1_corner_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local alpha = local_progress*255 - 255

				if alpha < widget_style_global.glow_corner_color[1] then
					widget_style_global.glow_corner_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_window_1_button_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_button
				local widget_style = widget.style
				local alpha = (local_progress - 1)*255

				if alpha < widget_style.button_frame_glow_texture.color[1] then
					widget_style.button_frame_glow_texture.color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_disk_traits",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = (local_progress - 1)*255

				for i = 1, 4, 1 do
					local widget_name = "trait_button_" .. i
					local widget = widgets[widget_name]
					local widget_style = widget.style
					local color = widget_style.texture_glow_id.color

					if alpha < color[1] then
						color[1] = alpha
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_window_1_corners_skull_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local alpha = (local_progress - 1)*255

				if alpha < widget_style_global.glow_skull_color[1] then
					widget_style_global.glow_skull_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_in_window_2_corner_glow = {
		{
			name = "fade_in_window_2_corner_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_hover")

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local alpha = local_progress*255

				if widget_style_global.glow_corner_color[1] < alpha then
					widget_style_global.glow_corner_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_2_button_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_button
				local widget_style = widget.style
				local alpha = local_progress*255

				if widget_style.button_frame_glow_texture.color[1] < alpha then
					widget_style.button_frame_glow_texture.color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_disk_traits",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = local_progress*255

				for i = 5, 8, 1 do
					local widget_name = "trait_button_" .. i
					local widget = widgets[widget_name]
					local widget_style = widget.style
					local color = widget_style.texture_glow_id.color

					if color[1] < alpha then
						color[1] = alpha
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_window_2_corners_skull_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local alpha = 0
				widget_style_global.glow_skull_color[1] = alpha

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local alpha = local_progress*255

				if widget_style_global.glow_skull_color[1] < alpha then
					widget_style_global.glow_skull_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_out_window_2_corner_glow = {
		{
			name = "fade_out_window_2_corner_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local alpha = local_progress*255 - 255

				if alpha < widget_style_global.glow_corner_color[1] then
					widget_style_global.glow_corner_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_window_2_button_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_button
				local widget_style = widget.style
				local alpha = (local_progress - 1)*255

				if alpha < widget_style.button_frame_glow_texture.color[1] then
					widget_style.button_frame_glow_texture.color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_disk_traits",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = (local_progress - 1)*255

				for i = 5, 8, 1 do
					local widget_name = "trait_button_" .. i
					local widget = widgets[widget_name]
					local widget_style = widget.style
					local color = widget_style.texture_glow_id.color

					if alpha < color[1] then
						color[1] = alpha
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_window_2_corners_skull_glow",
			start_progress = 0,
			end_progress = 0.15,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local alpha = (local_progress - 1)*255

				if alpha < widget_style_global.glow_skull_color[1] then
					widget_style_global.glow_skull_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	preview_window_close = {
		{
			name = "fade_out_window_1_glow",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local glow_skull_color = widget_style_global.glow_skull_color
				local glow_corner_color = widget_style_global.glow_corner_color
				local progress = math.easeOutCubic(local_progress)
				local alpha = (progress - 1)*255

				if alpha < glow_skull_color[1] then
					glow_skull_color[1] = alpha
				end

				if alpha < glow_corner_color[1] then
					glow_corner_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_window_2_glow",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local glow_skull_color = widget_style_global.glow_skull_color
				local glow_corner_color = widget_style_global.glow_corner_color
				local progress = math.easeOutCubic(local_progress)
				local alpha = (progress - 1)*255

				if alpha < glow_skull_color[1] then
					glow_skull_color[1] = alpha
				end

				if alpha < glow_corner_color[1] then
					glow_corner_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_window_traits",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local progress = math.easeOutCubic(local_progress)
				local alpha = (progress - 1)*255

				for i = 1, 8, 1 do
					local widget = widgets["trait_preview_" .. i]
					local style = widget.style

					if alpha < style.description_text.text_color[1] then
						style.texture_id.color[1] = alpha
						style.texture_lock_id.color[1] = alpha
						style.texture_bg_id.color[1] = alpha
						style.description_text.text_color[1] = alpha
						style.title_text.text_color[1] = alpha
						style.text_divider_texture.color[1] = alpha

						if style.description_text.last_line_color then
							style.description_text.last_line_color[1] = alpha
						end
					end

					if not widget.content.visible then
						widget.content.visible = true
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				for i = 1, 8, 1 do
					local widget = widgets["trait_preview_" .. i]
					widget.content.visible = false
				end

				return 
			end
		},
		{
			name = "fade_out_window_1_corners",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_1_corner
				local widget_style_global = widget.style_global
				local texture_color = widget_style_global.texture_color
				local progress = math.easeOutCubic(local_progress)
				local alpha = (progress - 1)*255

				if alpha < texture_color[1] then
					texture_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local default_top_left = scenegraph_definition.pw_1_corner_top_left
				local default_top_right = scenegraph_definition.pw_1_corner_top_right
				local default_bottom_left = scenegraph_definition.pw_1_corner_bottom_left
				local default_bottom_right = scenegraph_definition.pw_1_corner_bottom_right
				local top_left = ui_scenegraph.pw_1_corner_top_left
				local top_right = ui_scenegraph.pw_1_corner_top_right
				local bottom_left = ui_scenegraph.pw_1_corner_bottom_left
				local bottom_right = ui_scenegraph.pw_1_corner_bottom_right
				top_left.local_position[1] = default_top_left.position[1]
				top_left.local_position[2] = default_top_left.position[2]
				top_right.local_position[1] = default_top_right.position[1]
				top_right.local_position[2] = default_top_right.position[2]
				bottom_left.local_position[1] = default_bottom_left.position[1]
				bottom_left.local_position[2] = default_bottom_left.position[2]
				bottom_right.local_position[1] = default_bottom_right.position[1]
				bottom_right.local_position[2] = default_bottom_right.position[2]

				return 
			end
		},
		{
			name = "fade_out_window_2_corners",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.preview_window_2_corner
				local widget_style_global = widget.style_global
				local texture_color = widget_style_global.texture_color
				local progress = math.easeOutCubic(local_progress)
				local alpha = (progress - 1)*255

				if alpha < texture_color[1] then
					texture_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local default_top_left = scenegraph_definition.pw_2_corner_top_left
				local default_top_right = scenegraph_definition.pw_2_corner_top_right
				local default_bottom_left = scenegraph_definition.pw_2_corner_bottom_left
				local default_bottom_right = scenegraph_definition.pw_2_corner_bottom_right
				local top_left = ui_scenegraph.pw_2_corner_top_left
				local top_right = ui_scenegraph.pw_2_corner_top_right
				local bottom_left = ui_scenegraph.pw_2_corner_bottom_left
				local bottom_right = ui_scenegraph.pw_2_corner_bottom_right
				top_left.local_position[1] = default_top_left.position[1]
				top_left.local_position[2] = default_top_left.position[2]
				top_right.local_position[1] = default_top_right.position[1]
				top_right.local_position[2] = default_top_right.position[2]
				bottom_left.local_position[1] = default_bottom_left.position[1]
				bottom_left.local_position[2] = default_bottom_left.position[2]
				bottom_right.local_position[1] = default_bottom_right.position[1]
				bottom_right.local_position[2] = default_bottom_right.position[2]

				return 
			end
		},
		{
			name = "fade_out_window_1_title",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local progress = math.easeOutCubic(local_progress)
				local alpha = (progress - 1)*255
				local widget = widgets.preview_window_1_title
				widget.style.text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_window_2_title",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local progress = math.easeOutCubic(local_progress)
				local alpha = (progress - 1)*255
				local widget = widgets.preview_window_2_title
				widget.style.text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "close_window",
			start_progress = 0.4,
			end_progress = 0.9,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				if not params.close_sound_played then
					WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_window_move")

					params.close_sound_played = true
				end

				local expand_frame_default_size = scenegraph_definition.expand_frame.size
				local expand_frame_background_default_size = scenegraph_definition.expand_frame_background.size
				local progress = math.easeOutCubic(local_progress)
				local width_increase = (progress - 1)*1236
				local current_size = ui_scenegraph.expand_frame.size
				local new_width = expand_frame_default_size[1] + width_increase

				if new_width < current_size[1] then
					current_size[1] = new_width
					ui_scenegraph.expand_frame_background.size[1] = (progress - 1)*expand_frame_background_default_size[1]
					local background_uvs = widgets.expand_frame_background.content.texture_id.uvs
					background_uvs[1][1] = progress
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets_definitions = widgets_definitions,
	traits_preview_definitions = traits_preview_definitions,
	animations = animations
}
