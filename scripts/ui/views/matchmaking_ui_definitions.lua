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
			UILayer.matchmaking
		}
	},
	large_window = {
		vertical_alignment = "top",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			191
		},
		position = {
			0,
			0,
			10
		}
	},
	window_frame_left = {
		vertical_alignment = "top",
		parent = "large_window",
		horizontal_alignment = "left",
		size = {
			960,
			191
		},
		position = {
			0,
			0,
			0
		}
	},
	window_frame_right = {
		vertical_alignment = "top",
		parent = "large_window",
		horizontal_alignment = "right",
		size = {
			960,
			191
		},
		position = {
			0,
			0,
			0
		}
	},
	window_level_image = {
		vertical_alignment = "top",
		parent = "large_window",
		horizontal_alignment = "right",
		size = {
			180,
			102
		},
		position = {
			-340,
			-10,
			1
		}
	},
	window_level_image_frame = {
		vertical_alignment = "center",
		parent = "window_level_image",
		horizontal_alignment = "center",
		size = {
			187,
			113
		},
		position = {
			0,
			0,
			1
		}
	},
	window_game_info = {
		vertical_alignment = "center",
		parent = "window_level_image",
		horizontal_alignment = "right",
		size = {
			280,
			102
		},
		position = {
			285,
			0,
			1
		}
	},
	window_game_info_level_prefix = {
		vertical_alignment = "top",
		parent = "window_game_info",
		horizontal_alignment = "left",
		size = {
			280,
			24
		},
		position = {
			10,
			0,
			1
		}
	},
	window_game_info_level = {
		vertical_alignment = "top",
		parent = "window_game_info_level_prefix",
		horizontal_alignment = "left",
		size = {
			280,
			24
		},
		position = {
			0,
			-26,
			0
		}
	},
	window_game_info_difficulty_prefix = {
		vertical_alignment = "top",
		parent = "window_game_info_level",
		horizontal_alignment = "left",
		size = {
			280,
			24
		},
		position = {
			0,
			-30,
			0
		}
	},
	window_game_info_difficulty = {
		vertical_alignment = "top",
		parent = "window_game_info_difficulty_prefix",
		horizontal_alignment = "left",
		size = {
			280,
			24
		},
		position = {
			0,
			-26,
			0
		}
	},
	window_title_area = {
		vertical_alignment = "top",
		parent = "large_window",
		horizontal_alignment = "center",
		size = {
			391,
			39
		},
		position = {
			-228,
			0,
			1
		}
	},
	window_search_zone_area = {
		vertical_alignment = "top",
		parent = "large_window",
		horizontal_alignment = "center",
		size = {
			391,
			39
		},
		position = {
			228,
			0,
			1
		}
	},
	search_zone_icon = {
		vertical_alignment = "center",
		parent = "window_search_zone_area",
		horizontal_alignment = "center",
		size = {
			28,
			28
		},
		position = {
			0,
			0,
			1
		}
	},
	window_title = {
		vertical_alignment = "center",
		parent = "window_title_area",
		horizontal_alignment = "center",
		size = {
			391,
			39
		},
		position = {
			0,
			0,
			1
		}
	},
	window_search_zone_host_title = {
		vertical_alignment = "center",
		parent = "window_search_zone_area",
		horizontal_alignment = "center",
		size = {
			391,
			39
		},
		position = {
			0,
			0,
			1
		}
	},
	window_search_zone_title = {
		vertical_alignment = "center",
		parent = "window_search_zone_area",
		horizontal_alignment = "left",
		size = {
			391,
			39
		},
		position = {
			0,
			0,
			1
		}
	},
	window_timer = {
		vertical_alignment = "top",
		parent = "large_window",
		horizontal_alignment = "center",
		size = {
			200,
			50
		},
		position = {
			0,
			-5,
			1
		}
	},
	window_loader_icon = {
		vertical_alignment = "top",
		parent = "large_window",
		horizontal_alignment = "center",
		size = {
			50,
			50
		},
		position = {
			-10,
			-15,
			1
		}
	},
	window_status_text = {
		vertical_alignment = "bottom",
		parent = "window_timer",
		horizontal_alignment = "center",
		size = {
			850,
			50
		},
		position = {
			0,
			-40,
			1
		}
	},
	window_action_area_mask = {
		vertical_alignment = "bottom",
		parent = "large_window",
		horizontal_alignment = "center",
		size = {
			770,
			62
		},
		position = {
			-3,
			10,
			-3
		}
	},
	window_action_area = {
		vertical_alignment = "bottom",
		parent = "large_window",
		horizontal_alignment = "center",
		size = {
			770,
			62
		},
		position = {
			-3,
			15,
			-3
		}
	},
	window_action_area_fg = {
		vertical_alignment = "center",
		parent = "window_action_area",
		horizontal_alignment = "center",
		size = {
			770,
			62
		},
		position = {
			0,
			0,
			1
		}
	},
	window_ready_area = {
		vertical_alignment = "bottom",
		parent = "large_window",
		horizontal_alignment = "left",
		size = {
			631,
			58
		},
		position = {
			-9,
			24,
			3
		}
	},
	window_ready_bg = {
		vertical_alignment = "center",
		parent = "window_ready_area",
		horizontal_alignment = "left",
		size = {
			631,
			58
		},
		position = {
			0,
			0,
			0
		}
	},
	window_ready_glow = {
		vertical_alignment = "center",
		parent = "window_ready_area",
		horizontal_alignment = "center",
		size = {
			631,
			58
		},
		position = {
			0,
			0,
			1
		}
	},
	window_ready_input_text = {
		vertical_alignment = "center",
		parent = "window_ready_area",
		horizontal_alignment = "center",
		size = {
			631,
			50
		},
		position = {
			0,
			-7,
			1
		}
	},
	window_ready_error_text = {
		vertical_alignment = "center",
		parent = "window_ready_area",
		horizontal_alignment = "center",
		size = {
			631,
			50
		},
		position = {
			0,
			-7,
			1
		}
	},
	window_ready_suffix = {
		vertical_alignment = "center",
		parent = "window_ready_input_text",
		horizontal_alignment = "center",
		size = {
			631,
			50
		},
		position = {
			0,
			0,
			1
		}
	},
	window_ready_prefix = {
		vertical_alignment = "center",
		parent = "window_ready_input_text",
		horizontal_alignment = "center",
		size = {
			631,
			50
		},
		position = {
			0,
			0,
			1
		}
	},
	window_ready_input_icon = {
		vertical_alignment = "center",
		parent = "window_ready_input_text",
		horizontal_alignment = "center",
		size = {
			36,
			26
		},
		position = {
			0,
			1,
			2
		}
	},
	window_ready_input_icon_bar = {
		vertical_alignment = "center",
		parent = "window_ready_input_icon",
		horizontal_alignment = "center",
		size = {
			36,
			26
		},
		position = {
			0,
			0,
			1
		}
	},
	window_action_input_text = {
		vertical_alignment = "center",
		parent = "window_action_area",
		horizontal_alignment = "center",
		size = {
			40,
			50
		},
		position = {
			0,
			-5,
			0
		}
	},
	window_action_suffix = {
		vertical_alignment = "center",
		parent = "window_action_input_text",
		horizontal_alignment = "center",
		size = {
			770,
			50
		},
		position = {
			0,
			0,
			0
		}
	},
	window_action_prefix = {
		vertical_alignment = "center",
		parent = "window_action_input_text",
		horizontal_alignment = "center",
		size = {
			770,
			50
		},
		position = {
			0,
			0,
			0
		}
	},
	window_action_input_icon = {
		vertical_alignment = "center",
		parent = "window_action_input_text",
		horizontal_alignment = "center",
		size = {
			36,
			26
		},
		position = {
			0,
			1,
			2
		}
	},
	window_action_input_icon_bar = {
		vertical_alignment = "center",
		parent = "window_action_input_icon",
		horizontal_alignment = "center",
		size = {
			36,
			26
		},
		position = {
			0,
			0,
			1
		}
	},
	window_cancel_area = {
		vertical_alignment = "bottom",
		parent = "large_window",
		horizontal_alignment = "right",
		size = {
			631,
			58
		},
		position = {
			-9,
			24,
			3
		}
	},
	window_cancel_bg = {
		vertical_alignment = "center",
		parent = "window_cancel_area",
		horizontal_alignment = "right",
		size = {
			631,
			58
		},
		position = {
			0,
			0,
			0
		}
	},
	window_cancel_input_text = {
		vertical_alignment = "center",
		parent = "window_cancel_area",
		horizontal_alignment = "center",
		size = {
			60,
			50
		},
		position = {
			0,
			-7,
			0
		}
	},
	window_cancel_suffix = {
		vertical_alignment = "center",
		parent = "window_cancel_input_text",
		horizontal_alignment = "center",
		size = {
			300,
			50
		},
		position = {
			0,
			0,
			0
		}
	},
	window_cancel_prefix = {
		vertical_alignment = "center",
		parent = "window_cancel_input_text",
		horizontal_alignment = "center",
		size = {
			300,
			50
		},
		position = {
			0,
			0,
			0
		}
	},
	window_cancel_input_icon = {
		vertical_alignment = "center",
		parent = "window_cancel_input_text",
		horizontal_alignment = "center",
		size = {
			36,
			26
		},
		position = {
			0,
			1,
			2
		}
	},
	window_cancel_input_icon_bar = {
		vertical_alignment = "center",
		parent = "window_cancel_input_icon",
		horizontal_alignment = "center",
		size = {
			36,
			26
		},
		position = {
			0,
			0,
			1
		}
	},
	player_portrait_1 = {
		vertical_alignment = "top",
		parent = "large_window",
		horizontal_alignment = "left",
		size = {
			66,
			101
		},
		position = {
			122,
			-9,
			1
		}
	},
	player_portrait_2 = {
		vertical_alignment = "center",
		parent = "player_portrait_1",
		horizontal_alignment = "left",
		size = {
			66,
			101
		},
		position = {
			111,
			0,
			1
		}
	},
	player_portrait_3 = {
		vertical_alignment = "center",
		parent = "player_portrait_2",
		horizontal_alignment = "left",
		size = {
			66,
			101
		},
		position = {
			111,
			0,
			1
		}
	},
	player_portrait_4 = {
		vertical_alignment = "center",
		parent = "player_portrait_3",
		horizontal_alignment = "left",
		size = {
			66,
			101
		},
		position = {
			111,
			0,
			1
		}
	},
	status_box = {
		vertical_alignment = "top",
		parent = "root",
		horizontal_alignment = "right",
		size = {
			320,
			64
		},
		position = {
			-150,
			0,
			1
		}
	},
	status_box_title = {
		vertical_alignment = "center",
		parent = "status_box",
		position = {
			65,
			3,
			2
		},
		size = {
			160,
			40
		}
	},
	player_slot_1 = {
		vertical_alignment = "center",
		parent = "player_slot_2",
		size = {
			40,
			60
		},
		position = {
			-21,
			0,
			1
		}
	},
	player_slot_2 = {
		vertical_alignment = "center",
		parent = "player_slot_3",
		size = {
			40,
			60
		},
		position = {
			-21,
			0,
			1
		}
	},
	player_slot_3 = {
		vertical_alignment = "center",
		parent = "player_slot_4",
		size = {
			40,
			60
		},
		position = {
			-21,
			0,
			1
		}
	},
	player_slot_4 = {
		vertical_alignment = "center",
		parent = "status_box",
		horizontal_alignment = "right",
		size = {
			40,
			60
		},
		position = {
			-10,
			0,
			1
		}
	},
	debug_box = {
		vertical_alignment = "bottom",
		parent = "status_box",
		horizontal_alignment = "center",
		size = {
			320,
			320
		},
		position = {
			0,
			-340,
			1
		}
	},
	debug_box_text = {
		vertical_alignment = "center",
		parent = "debug_box",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			2
		},
		size = {
			300,
			300
		}
	},
	debug_lobbies_box = {
		vertical_alignment = "top",
		parent = "root",
		horizontal_alignment = "left",
		size = {
			1440,
			1040
		},
		position = {
			20,
			-20,
			1
		}
	},
	debug_lobbies_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			2
		},
		size = {
			900,
			1040
		}
	},
	debug_server_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			0,
			0,
			2
		},
		size = {
			150,
			1000
		}
	},
	debug_match_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			150,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_broken_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			190,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_valid_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			250,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_level_key_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			300,
			0,
			2
		},
		size = {
			100,
			1000
		}
	},
	debug_selected_level_key_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			400,
			0,
			2
		},
		size = {
			100,
			1000
		}
	},
	debug_matchmaking_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			500,
			0,
			2
		},
		size = {
			75,
			1000
		}
	},
	debug_difficulty_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			575,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_num_players_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			640,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_wh_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			690,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_we_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			740,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_dr_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			790,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_bw_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			840,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_es_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			890,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_rp_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			940,
			0,
			2
		},
		size = {
			50,
			1000
		}
	},
	debug_host_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			990,
			0,
			2
		},
		size = {
			150,
			1000
		}
	},
	debug_lobby_id_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			1140,
			0,
			2
		},
		size = {
			150,
			1000
		}
	},
	debug_hash_text = {
		vertical_alignment = "center",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			1290,
			0,
			2
		},
		size = {
			150,
			1000
		}
	},
	debug_divider_0 = {
		vertical_alignment = "top",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			0,
			-40,
			2
		},
		size = {
			1290,
			2
		}
	},
	debug_divider_1 = {
		vertical_alignment = "top",
		parent = "debug_lobbies_box",
		horizontal_alignment = "left",
		position = {
			179,
			0,
			2
		},
		size = {
			2,
			1040
		}
	}
}
local widgets = {
	large_window = {
		window_frame_left = UIWidgets.create_simple_texture("matchmaking_frame", "window_frame_left"),
		window_frame_right = UIWidgets.create_simple_uv_texture("matchmaking_frame", {
			{
				1,
				0
			},
			{
				0,
				1
			}
		}, "window_frame_right"),
		ready_button_bg = UIWidgets.create_uv_texture_with_style("matchmaking_button_bg", {
			{
				1,
				0
			},
			{
				0,
				1
			}
		}, "window_ready_bg", {
			offset = {
				0,
				0,
				-1
			},
			color = {
				255,
				0,
				255,
				0
			}
		}),
		ready_button_fg = UIWidgets.create_uv_texture_with_style("matchmaking_button_fg", {
			{
				1,
				0
			},
			{
				0,
				1
			}
		}, "window_ready_area", {
			offset = {
				0,
				0,
				10
			},
			color = {
				255,
				255,
				255,
				255
			}
		}),
		ready_button_glow = UIWidgets.create_uv_texture_with_style("matchmaking_button_glow", {
			{
				1,
				0
			},
			{
				0,
				1
			}
		}, "window_ready_glow", {
			offset = {
				0,
				0,
				-2
			},
			color = {
				50,
				0,
				255,
				0
			}
		}),
		cancel_button_bg = UIWidgets.create_uv_texture_with_style("matchmaking_button_bg", {
			{
				0,
				0
			},
			{
				1,
				1
			}
		}, "window_cancel_bg", {
			offset = {
				0,
				0,
				-1
			},
			color = {
				255,
				255,
				0,
				0
			}
		}),
		cancel_button_fg = UIWidgets.create_uv_texture_with_style("matchmaking_button_fg", {
			{
				1,
				0
			},
			{
				0,
				1
			}
		}, "window_cancel_area", {
			offset = {
				0,
				0,
				10
			},
			color = {
				255,
				255,
				255,
				255
			}
		}),
		action_button_bg = UIWidgets.create_uv_texture_with_style("matchmaking_button_02_bg", {
			{
				1,
				0
			},
			{
				0,
				1
			}
		}, "window_action_area", {
			offset = {
				0,
				0,
				-1
			},
			color = {
				255,
				200,
				200,
				255
			}
		}),
		action_button_fg = UIWidgets.create_uv_texture_with_style("matchmaking_button_02_fg", {
			{
				1,
				0
			},
			{
				0,
				1
			}
		}, "window_action_area_fg", {
			offset = {
				0,
				0,
				0
			},
			color = {
				255,
				255,
				255,
				255
			}
		}),
		player_portrait_1 = UIWidgets.create_matchmaking_portrait("player_portrait_1"),
		player_portrait_2 = UIWidgets.create_matchmaking_portrait("player_portrait_2"),
		player_portrait_3 = UIWidgets.create_matchmaking_portrait("player_portrait_3"),
		player_portrait_4 = UIWidgets.create_matchmaking_portrait("player_portrait_4"),
		window_level_image = UIWidgets.create_simple_texture("level_image_cemetery", "window_level_image"),
		window_level_image_frame = UIWidgets.create_simple_texture("matchmaking_level_image_frame", "window_level_image_frame"),
		search_zone_icon = UIWidgets.create_simple_texture("matchmaking_globe_icon", "search_zone_icon"),
		window_action_area_mask = UIWidgets.create_simple_texture("mask_rect", "window_action_area_mask"),
		ready_text_suffix = UIWidgets.create_simple_text("", "window_ready_suffix", nil, nil, {
			vertical_alignment = "center",
			font_size = 22,
			localize = true,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		ready_text_prefix = UIWidgets.create_simple_text("", "window_ready_prefix", nil, nil, {
			vertical_alignment = "center",
			font_size = 22,
			localize = false,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		ready_error_text = UIWidgets.create_simple_text("", "window_ready_error_text", nil, nil, {
			vertical_alignment = "center",
			font_size = 22,
			localize = false,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		ready_text = UIWidgets.create_simple_text("", "window_ready_input_text", nil, nil, {
			vertical_alignment = "center",
			font_size = 22,
			localize = false,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		ready_input_icon = {
			scenegraph_id = "window_ready_input_icon",
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content)
							return content.texture_id
						end
					}
				}
			},
			content = {
				texture_id = "xbone_button_icon_a"
			},
			style = {
				texture_id = {
					scenegraph_id = "window_ready_input_icon",
					offset = {
						0,
						0,
						4
					}
				}
			}
		},
		ready_input_icon_bar = {
			scenegraph_id = "window_ready_input_icon_bar",
			element = {
				passes = {
					{
						pass_type = "gradient_mask_texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content, style)
							return content.texture_id and 0 < style.gradient_threshold
						end
					}
				}
			},
			content = {
				texture_id = "controller_hold_bar"
			},
			style = {
				texture_id = {
					scenegraph_id = "window_ready_input_icon_bar",
					gradient_threshold = 0,
					offset = {
						0,
						0,
						3
					}
				}
			}
		},
		action_text_suffix = UIWidgets.create_simple_text("", "window_action_suffix", nil, nil, {
			vertical_alignment = "center",
			font_size = 26,
			localize = true,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark_masked",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		action_text_prefix = UIWidgets.create_simple_text("", "window_action_prefix", nil, nil, {
			vertical_alignment = "center",
			font_size = 26,
			localize = false,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark_masked",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		action_text = UIWidgets.create_simple_text("", "window_action_input_text", nil, nil, {
			vertical_alignment = "center",
			font_size = 26,
			localize = false,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark_masked",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		action_input_icon = {
			scenegraph_id = "window_action_input_icon",
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content)
							return content.texture_id
						end
					}
				}
			},
			content = {
				texture_id = "xbone_button_icon_a"
			},
			style = {
				texture_id = {
					scenegraph_id = "window_action_input_icon",
					masked = true,
					offset = {
						0,
						0,
						4
					}
				}
			}
		},
		action_input_icon_bar = {
			scenegraph_id = "window_action_input_icon_bar",
			element = {
				passes = {
					{
						pass_type = "gradient_mask_texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content, style)
							return content.texture_id and 0 < style.gradient_threshold
						end
					}
				}
			},
			content = {
				texture_id = "controller_hold_bar"
			},
			style = {
				texture_id = {
					masked = true,
					scenegraph_id = "window_action_input_icon_bar",
					gradient_threshold = 0,
					offset = {
						0,
						0,
						3
					}
				}
			}
		},
		cancel_text_suffix = UIWidgets.create_simple_text("matchmaking_surfix_cancel", "window_cancel_suffix", nil, nil, {
			vertical_alignment = "center",
			font_size = 22,
			localize = true,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		cancel_text_prefix = UIWidgets.create_simple_text("", "window_cancel_prefix", nil, nil, {
			vertical_alignment = "center",
			font_size = 22,
			localize = false,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		cancel_text = UIWidgets.create_simple_text("", "window_cancel_input_text", nil, nil, {
			vertical_alignment = "center",
			font_size = 22,
			localize = false,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		cancel_input_icon = {
			scenegraph_id = "window_cancel_input_icon",
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content)
							return content.texture_id
						end
					}
				}
			},
			content = {
				texture_id = "xbone_button_icon_a"
			},
			style = {
				texture_id = {
					scenegraph_id = "window_cancel_input_icon",
					offset = {
						0,
						0,
						4
					}
				}
			}
		},
		cancel_input_icon_bar = {
			scenegraph_id = "window_cancel_input_icon_bar",
			element = {
				passes = {
					{
						pass_type = "gradient_mask_texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content, style)
							return content.texture_id and 0 < style.gradient_threshold
						end
					}
				}
			},
			content = {
				texture_id = "controller_hold_bar"
			},
			style = {
				texture_id = {
					scenegraph_id = "window_cancel_input_icon_bar",
					gradient_threshold = 0,
					offset = {
						0,
						0,
						3
					}
				}
			}
		},
		title = UIWidgets.create_simple_text("status_matchmaking", "window_title", 24, Colors.get_color_table_with_alpha("white", 255)),
		search_zone_host_title = UIWidgets.create_simple_text("matchmaking_status_hosting", "window_search_zone_host_title", 28, Colors.get_color_table_with_alpha("white", 255)),
		timer = UIWidgets.create_simple_text("00:00", "window_timer", nil, nil, {
			vertical_alignment = "center",
			word_wrap = true,
			horizontal_alignment = "center",
			font_size = 56,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		status_text = UIWidgets.create_simple_text(" ", "window_status_text", 32, {
			255,
			255,
			255,
			255
		}),
		search_zone_title = UIWidgets.create_simple_text("zone", "window_search_zone_title", nil, nil, {
			vertical_alignment = "center",
			font_size = 24,
			localize = true,
			horizontal_alignment = "center",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		level_description_prefix = UIWidgets.create_simple_text("map_level_setting", "window_game_info_level_prefix", nil, nil, {
			vertical_alignment = "center",
			font_size = 20,
			localize = true,
			horizontal_alignment = "left",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		level_description = UIWidgets.create_simple_text("dlc1_2_difficulty_unavailable", "window_game_info_level", nil, nil, {
			vertical_alignment = "center",
			font_size = 24,
			localize = true,
			horizontal_alignment = "left",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		difficulty_description_prefix = UIWidgets.create_simple_text("prefix_difficulty", "window_game_info_difficulty_prefix", nil, nil, {
			vertical_alignment = "center",
			font_size = 20,
			localize = true,
			horizontal_alignment = "left",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		difficulty_description = UIWidgets.create_simple_text("dlc1_2_difficulty_unavailable", "window_game_info_difficulty", nil, nil, {
			vertical_alignment = "center",
			font_size = 24,
			localize = true,
			horizontal_alignment = "left",
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		}),
		loader_icon = UIWidgets.create_loader_icon("window_loader_icon")
	},
	status_box = {
		scenegraph_id = "status_box",
		element = {
			passes = {
				{
					style_id = "status_text",
					pass_type = "text",
					text_id = "status_text"
				},
				{
					pass_type = "texture",
					style_id = "background",
					texture_id = "background"
				},
				{
					pass_type = "texture",
					style_id = "loader_icon",
					texture_id = "loader_icon"
				},
				{
					pass_type = "rotated_texture",
					style_id = "loader_part_1",
					texture_id = "loader_part_1"
				},
				{
					pass_type = "rotated_texture",
					style_id = "loader_part_2",
					texture_id = "loader_part_2"
				},
				{
					pass_type = "texture",
					style_id = "player_slot_1",
					texture_id = "player_slot"
				},
				{
					pass_type = "texture",
					style_id = "player_slot_2",
					texture_id = "player_slot"
				},
				{
					pass_type = "texture",
					style_id = "player_slot_3",
					texture_id = "player_slot"
				},
				{
					pass_type = "texture",
					style_id = "player_slot_4",
					texture_id = "player_slot"
				},
				{
					pass_type = "texture",
					style_id = "player_slot_1_lit",
					texture_id = "player_slot_lit"
				},
				{
					pass_type = "texture",
					style_id = "player_slot_2_lit",
					texture_id = "player_slot_lit"
				},
				{
					pass_type = "texture",
					style_id = "player_slot_3_lit",
					texture_id = "player_slot_lit"
				},
				{
					pass_type = "texture",
					style_id = "player_slot_4_lit",
					texture_id = "player_slot_lit"
				}
			}
		},
		content = {
			loader_part_1 = "matchmaking_loading_icon_part_01",
			loader_part_2 = "matchmaking_loading_icon_part_02",
			background = "matchmaking_bg",
			status_text = "status_matchmaking",
			player_slot = "matchmaking_player_icon_normal",
			player_slot_lit = "matchmaking_player_icon_lit",
			loader_icon = "matchmaking_loading_icon_part_03"
		},
		style = {
			status_text = {
				font_size = 20,
				scenegraph_id = "status_box_title",
				localize = true,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			background = {
				color = {
					255,
					255,
					255,
					255
				}
			},
			loader_icon = {
				offset = {
					10,
					10,
					3
				},
				size = {
					52,
					52
				}
			},
			loader_part_1 = {
				angle = 0,
				offset = {
					10,
					10,
					1
				},
				size = {
					52,
					52
				},
				pivot = {
					26,
					26
				}
			},
			loader_part_2 = {
				angle = 0,
				offset = {
					10,
					10,
					2
				},
				size = {
					52,
					52
				},
				pivot = {
					26,
					26
				}
			},
			player_slot_1 = {
				scenegraph_id = "player_slot_1",
				color = {
					150,
					255,
					255,
					255
				}
			},
			player_slot_2 = {
				scenegraph_id = "player_slot_2",
				color = {
					150,
					255,
					255,
					255
				}
			},
			player_slot_3 = {
				scenegraph_id = "player_slot_3",
				color = {
					150,
					255,
					255,
					255
				}
			},
			player_slot_4 = {
				scenegraph_id = "player_slot_4",
				color = {
					150,
					255,
					255,
					255
				}
			},
			player_slot_1_lit = {
				scenegraph_id = "player_slot_1",
				color = {
					0,
					255,
					255,
					255
				}
			},
			player_slot_2_lit = {
				scenegraph_id = "player_slot_2",
				color = {
					0,
					255,
					255,
					255
				}
			},
			player_slot_3_lit = {
				scenegraph_id = "player_slot_3",
				color = {
					0,
					255,
					255,
					255
				}
			},
			player_slot_4_lit = {
				scenegraph_id = "player_slot_4",
				color = {
					0,
					255,
					255,
					255
				}
			}
		}
	},
	debug_box = {
		scenegraph_id = "debug_box",
		element = {
			passes = {
				{
					pass_type = "rect",
					style_id = "background_rect"
				},
				{
					style_id = "debug_text",
					pass_type = "text",
					text_id = "debug_text"
				}
			}
		},
		content = {
			debug_text = ""
		},
		style = {
			debug_text = {
				scenegraph_id = "debug_box_text",
				font_size = 28,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			background_rect = {
				color = {
					180,
					0,
					0,
					0
				}
			}
		}
	},
	debug_lobbies = {
		scenegraph_id = "debug_lobbies_box",
		element = {
			passes = {
				{
					pass_type = "rect",
					style_id = "background_rect"
				},
				{
					pass_type = "rect",
					style_id = "debug_divider_0"
				},
				{
					pass_type = "rect",
					style_id = "debug_divider_1"
				},
				{
					style_id = "debug_text",
					pass_type = "text",
					text_id = "debug_text"
				},
				{
					style_id = "debug_match_text",
					pass_type = "text",
					text_id = "debug_match_text"
				},
				{
					style_id = "debug_broken_text",
					pass_type = "text",
					text_id = "debug_broken_text"
				},
				{
					style_id = "debug_valid_text",
					pass_type = "text",
					text_id = "debug_valid_text"
				},
				{
					style_id = "debug_server_text",
					pass_type = "text",
					text_id = "debug_server_text"
				},
				{
					style_id = "debug_level_key_text",
					pass_type = "text",
					text_id = "debug_level_key_text"
				},
				{
					style_id = "debug_selected_level_key_text",
					pass_type = "text",
					text_id = "debug_selected_level_key_text"
				},
				{
					style_id = "debug_matchmaking_text",
					pass_type = "text",
					text_id = "debug_matchmaking_text"
				},
				{
					style_id = "debug_difficulty_text",
					pass_type = "text",
					text_id = "debug_difficulty_text"
				},
				{
					style_id = "debug_num_players_text",
					pass_type = "text",
					text_id = "debug_num_players_text"
				},
				{
					style_id = "debug_wh_text",
					pass_type = "text",
					text_id = "debug_wh_text"
				},
				{
					style_id = "debug_we_text",
					pass_type = "text",
					text_id = "debug_we_text"
				},
				{
					style_id = "debug_dr_text",
					pass_type = "text",
					text_id = "debug_dr_text"
				},
				{
					style_id = "debug_bw_text",
					pass_type = "text",
					text_id = "debug_bw_text"
				},
				{
					style_id = "debug_es_text",
					pass_type = "text",
					text_id = "debug_es_text"
				},
				{
					style_id = "debug_rp_text",
					pass_type = "text",
					text_id = "debug_rp_text"
				},
				{
					style_id = "debug_host_text",
					pass_type = "text",
					text_id = "debug_host_text"
				},
				{
					style_id = "debug_lobby_id_text",
					pass_type = "text",
					text_id = "debug_lobby_id_text"
				},
				{
					style_id = "debug_hash_text",
					pass_type = "text",
					text_id = "debug_hash_text"
				}
			}
		},
		content = {
			debug_es_text = "",
			debug_num_players_text = "",
			debug_bw_text = "",
			debug_match_text = "",
			debug_wh_text = "",
			debug_lobby_id_text = "",
			debug_server_text = "",
			debug_host_text = "",
			debug_valid_text = "",
			debug_level_key_text = "",
			debug_we_text = "",
			debug_selected_level_key_text = "",
			debug_rp_text = "",
			debug_text = "Lobbies",
			debug_broken_text = "",
			debug_difficulty_text = "",
			debug_matchmaking_text = "",
			debug_hash_text = "",
			debug_dr_text = ""
		},
		style = {
			debug_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_lobbies_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_server_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_server_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_match_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_match_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_broken_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_broken_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_valid_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_valid_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_level_key_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_level_key_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_selected_level_key_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_selected_level_key_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_matchmaking_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_matchmaking_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_difficulty_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_difficulty_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_num_players_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_num_players_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_wh_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_wh_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_we_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_we_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_dr_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_dr_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_bw_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_bw_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_es_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_es_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_rp_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_rp_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_host_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_host_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_lobby_id_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_lobby_id_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			debug_hash_text = {
				vertical_alignment = "top",
				scenegraph_id = "debug_hash_text",
				horizontal_alignment = "left",
				word_wrap = true,
				font_size = 14,
				font_type = "hell_shark",
				text_color = Colors.get_table("white", 255)
			},
			background_rect = {
				color = {
					180,
					0,
					0,
					0
				}
			},
			debug_divider_0 = {
				scenegraph_id = "debug_divider_0",
				color = {
					150,
					255,
					255,
					255
				}
			},
			debug_divider_1 = {
				scenegraph_id = "debug_divider_1",
				color = {
					150,
					255,
					255,
					255
				}
			}
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets = widgets
}
