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
	act_frame = {
		vertical_alignment = "top",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			564,
			58
		},
		position = {
			0,
			-150,
			11
		}
	},
	act_title_text = {
		vertical_alignment = "center",
		parent = "act_frame",
		horizontal_alignment = "center",
		size = {
			800,
			58
		},
		position = {
			0,
			2,
			1
		}
	},
	selection_bg = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			477,
			52
		},
		position = {
			0,
			740,
			3
		}
	},
	selection_text = {
		vertical_alignment = "bottom",
		parent = "selection_bg",
		horizontal_alignment = "center",
		size = {
			1920,
			50
		},
		position = {
			0,
			-42,
			2
		}
	},
	selection_fade = {
		vertical_alignment = "top",
		parent = "selection_bg",
		horizontal_alignment = "center",
		size = {
			481,
			358
		},
		position = {
			0,
			-52,
			-1
		}
	},
	difficulty_bg = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			522,
			56
		},
		position = {
			0,
			330,
			2
		}
	},
	difficulty_slots = {
		vertical_alignment = "bottom",
		parent = "difficulty_bg",
		horizontal_alignment = "center",
		size = {
			300,
			50
		},
		position = {
			0,
			-12,
			1
		}
	},
	difficulty_icons = {
		vertical_alignment = "center",
		parent = "difficulty_slots",
		horizontal_alignment = "center",
		size = {
			300,
			50
		},
		position = {
			0,
			0,
			1
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
			34
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
			34
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
			35
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
			35
		}
	},
	element_pivot = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			5
		}
	},
	subtitle_text = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			1200,
			160
		},
		position = {
			0,
			100,
			11
		}
	},
	level_count_text = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			1200,
			40
		},
		position = {
			-110,
			180,
			11
		}
	},
	performance_frame = {
		vertical_alignment = "top",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			408,
			292
		},
		position = {
			-50,
			-25,
			35
		}
	},
	performance_title_text = {
		vertical_alignment = "top",
		parent = "performance_frame",
		horizontal_alignment = "center",
		size = {
			1920,
			50
		},
		position = {
			0,
			-7,
			1
		}
	},
	performance_divider_1 = {
		vertical_alignment = "bottom",
		parent = "performance_title_text",
		horizontal_alignment = "center",
		size = {
			192,
			8
		},
		position = {
			0,
			-18,
			1
		}
	},
	difficulty_prefix_1 = {
		vertical_alignment = "bottom",
		parent = "performance_title_text",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			-18,
			1
		}
	},
	wave_prefix_1 = {
		vertical_alignment = "bottom",
		parent = "difficulty_prefix_1",
		horizontal_alignment = "left",
		size = {
			360,
			20
		},
		position = {
			0,
			-18,
			1
		}
	},
	time_prefix_1 = {
		vertical_alignment = "bottom",
		parent = "wave_prefix_1",
		horizontal_alignment = "left",
		size = {
			360,
			20
		},
		position = {
			0,
			-20,
			1
		}
	},
	difficulty_value_1 = {
		vertical_alignment = "center",
		parent = "difficulty_prefix_1",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	wave_value_1 = {
		vertical_alignment = "center",
		parent = "wave_prefix_1",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	time_value_1 = {
		vertical_alignment = "center",
		parent = "time_prefix_1",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	performance_divider_2 = {
		vertical_alignment = "bottom",
		parent = "time_value_1",
		horizontal_alignment = "center",
		size = {
			192,
			8
		},
		position = {
			0,
			-18,
			1
		}
	},
	difficulty_prefix_2 = {
		vertical_alignment = "bottom",
		parent = "performance_divider_2",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			-24,
			1
		}
	},
	wave_prefix_2 = {
		vertical_alignment = "bottom",
		parent = "difficulty_prefix_2",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			-18,
			1
		}
	},
	time_prefix_2 = {
		vertical_alignment = "bottom",
		parent = "wave_prefix_2",
		horizontal_alignment = "left",
		size = {
			360,
			20
		},
		position = {
			0,
			-20,
			1
		}
	},
	difficulty_value_2 = {
		vertical_alignment = "center",
		parent = "difficulty_prefix_2",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	wave_value_2 = {
		vertical_alignment = "center",
		parent = "wave_prefix_2",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	time_value_2 = {
		vertical_alignment = "center",
		parent = "time_prefix_2",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	performance_divider_3 = {
		vertical_alignment = "bottom",
		parent = "time_value_2",
		horizontal_alignment = "center",
		size = {
			192,
			8
		},
		position = {
			0,
			-18,
			1
		}
	},
	difficulty_prefix_3 = {
		vertical_alignment = "bottom",
		parent = "performance_divider_3",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			-24,
			1
		}
	},
	wave_prefix_3 = {
		vertical_alignment = "bottom",
		parent = "difficulty_prefix_3",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			-18,
			1
		}
	},
	time_prefix_3 = {
		vertical_alignment = "bottom",
		parent = "wave_prefix_3",
		horizontal_alignment = "left",
		size = {
			360,
			20
		},
		position = {
			0,
			-20,
			1
		}
	},
	difficulty_value_3 = {
		vertical_alignment = "center",
		parent = "difficulty_prefix_3",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	wave_value_3 = {
		vertical_alignment = "center",
		parent = "wave_prefix_3",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	},
	time_value_3 = {
		vertical_alignment = "center",
		parent = "time_prefix_3",
		horizontal_alignment = "center",
		size = {
			360,
			20
		},
		position = {
			0,
			0,
			1
		}
	}
}
local element_size = {
	400,
	400
}
local MASKED = true
local generic_input_actions = {
	default = {
		default = {
			{
				input_action = "confirm",
				priority = 2,
				description_text = "input_description_select"
			},
			{
				input_action = "back",
				priority = 3,
				description_text = "input_description_back"
			}
		},
		dlc = {
			{
				input_action = "confirm",
				priority = 2,
				description_text = (PLATFORM == "xb1" and "dlc1_4_input_description_storepage_xb1") or "dlc1_4_input_description_storepage"
			},
			{
				input_action = "back",
				priority = 3,
				description_text = "input_description_back"
			}
		},
		locked = {
			{
				input_action = "back",
				priority = 3,
				description_text = "input_description_back"
			}
		}
	},
	filter = {
		default = {
			default = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "refresh",
					priority = 2,
					description_text = "input_description_select_mission_list"
				},
				{
					input_action = "confirm",
					priority = 3,
					description_text = "input_description_select"
				},
				{
					input_action = "back",
					priority = 4,
					description_text = "input_description_back"
				}
			},
			dlc = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "refresh",
					priority = 2,
					description_text = "input_description_select_mission_list"
				},
				{
					input_action = "confirm",
					priority = 3,
					description_text = (PLATFORM == "xb1" and "dlc1_4_input_description_storepage_xb1") or "dlc1_4_input_description_storepage"
				},
				{
					input_action = "back",
					priority = 4,
					description_text = "input_description_back"
				}
			},
			locked = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "refresh",
					priority = 2,
					description_text = "input_description_select_mission_list"
				},
				{
					input_action = "back",
					priority = 3,
					description_text = "input_description_back"
				}
			}
		},
		filter_unplayable = {
			default = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "confirm",
					priority = 3,
					description_text = "input_description_select"
				},
				{
					input_action = "back",
					priority = 4,
					description_text = "input_description_back"
				}
			},
			dlc = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "confirm",
					priority = 3,
					description_text = (PLATFORM == "xb1" and "dlc1_4_input_description_storepage_xb1") or "dlc1_4_input_description_storepage"
				},
				{
					input_action = "back",
					priority = 4,
					description_text = "input_description_back"
				}
			},
			locked = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "back",
					priority = 3,
					description_text = "input_description_back"
				}
			}
		},
		filter_active = {
			default = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "special_1",
					priority = 2,
					description_text = "input_description_mission_list_mark"
				},
				{
					input_action = "back",
					priority = 3,
					description_text = "input_description_back"
				}
			},
			dlc = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "confirm",
					priority = 2,
					description_text = (PLATFORM == "xb1" and "dlc1_4_input_description_storepage_xb1") or "dlc1_4_input_description_storepage"
				},
				{
					input_action = "back",
					priority = 3,
					description_text = "input_description_back"
				}
			},
			locked = {
				{
					input_action = "cycle_previous",
					priority = 1,
					description_text = "input_description_toggle_mission_list"
				},
				{
					input_action = "back",
					priority = 3,
					description_text = "input_description_back"
				}
			}
		}
	}
}
local description_text_colors = {
	default = Colors.get_table("white"),
	locked = Colors.get_table("red")
}
local difficulty_progression_textures = {
	completed = "console_difficulty_icon_02",
	locked = "console_difficulty_icon_03",
	unlocked = "console_difficulty_icon_01"
}
local dialogue_speakers = {
	nik = "inn_keeper",
	nfl = "ferry_lady"
}

local function create_element(scenegraph_id)
	return {
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "frame",
					texture_id = "frame",
					content_check_function = function (content)
						return content.level_image
					end
				},
				{
					pass_type = "texture",
					style_id = "level_image",
					texture_id = "level_image",
					content_check_function = function (content)
						return content.level_image
					end
				},
				{
					pass_type = "texture",
					style_id = "locked_texture",
					texture_id = "locked_texture",
					content_check_function = function (content)
						return content.locked or content.dlc_name
					end
				},
				{
					pass_type = "texture",
					style_id = "dlc_texture",
					texture_id = "dlc_texture",
					content_check_function = function (content)
						return content.dlc_name
					end
				},
				{
					pass_type = "texture",
					style_id = "new_texture",
					texture_id = "new_texture",
					content_check_function = function (content)
						return not content.locked and content.new
					end
				},
				{
					pass_type = "texture",
					style_id = "marker",
					texture_id = "marker",
					content_check_function = function (content)
						return content.use_marker and content.filter_active
					end
				},
				{
					pass_type = "rect",
					style_id = "bg_rect"
				}
			}
		},
		content = {
			marker = "red_cross_marker",
			locked_texture = "large_lock_icon_chain",
			frame = "console_level_frame_01",
			level_image = "level_image_any",
			new_texture = "level_unlocked_icon",
			filter_active = false,
			dlc_texture = "large_lock_icon_dlc"
		},
		style = {
			frame = {
				masked = MASKED,
				size = {
					573,
					326
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-286.5,
					-163,
					6
				}
			},
			new_texture = {
				masked = MASKED,
				size = {
					360,
					32
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-180,
					-16,
					5
				}
			},
			bg_rect = {
				masked = MASKED,
				size = {
					300,
					170
				},
				offset = {
					-150,
					-85,
					1
				},
				color = {
					255,
					0,
					0,
					0
				}
			},
			level_image = {
				masked = MASKED,
				size = {
					560,
					310
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-280,
					-155,
					2
				}
			},
			marker = {
				masked = MASKED,
				size = {
					560,
					310
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-280,
					-155,
					8
				}
			},
			locked_texture = {
				masked = MASKED,
				color = {
					255,
					255,
					255,
					255
				},
				size = {
					233,
					232
				},
				offset = {
					-116.5,
					-7.5,
					7
				}
			},
			dlc_texture = {
				masked = MASKED,
				color = {
					255,
					255,
					255,
					255
				},
				size = {
					95,
					77
				},
				offset = {
					-47.5,
					-63,
					6
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

local score_text_prefix_style = {
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
local score_text_value_style = {
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
	subtitle_text = UIWidgets.create_simple_text("", "subtitle_text", 24, Colors.get_table("white")),
	level_count_text = UIWidgets.create_simple_text("", "level_count_text", 24, Colors.get_table("cheeseburger")),
	selection_text = UIWidgets.create_simple_text("n/a", "selection_text", 32, Colors.get_table("white")),
	difficulty_slots = UIWidgets.create_simple_centered_texture_amount("console_difficulty_icon_bg", {
		40,
		60
	}, "difficulty_slots", 5),
	difficulty_icons = UIWidgets.create_simple_centered_texture_amount("difficulty_icon_large_02", {
		40,
		60
	}, "difficulty_icons", 5),
	background = UIWidgets.create_simple_texture("difficulty_bg", "frame"),
	difficulty_bg = UIWidgets.create_simple_texture("hud_difficulty_unlocked_bg_bottom", "difficulty_bg"),
	selection_bg = UIWidgets.create_simple_texture("hud_difficulty_unlocked_bg_top", "selection_bg"),
	selection_fade = UIWidgets.create_simple_texture("hud_difficulty_unlocked_bg_fade", "selection_fade"),
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
	act_frame = UIWidgets.create_simple_texture("difficulty_frame", "act_frame"),
	act_title_text = UIWidgets.create_simple_text("", "act_title_text", 28, Colors.get_table("cheeseburger")),
	performance_frame = UIWidgets.create_simple_texture("performance_frame", "performance_frame"),
	performance_title_text = UIWidgets.create_simple_text("dlc1_2_map_best_performance", "performance_title_text", 24, Colors.get_table("white")),
	performance_divider_1 = UIWidgets.create_simple_texture("small_divider", "performance_divider_1"),
	difficulty_prefix_1 = UIWidgets.create_simple_text(Localize("map_difficulty_setting") .. ":", "difficulty_prefix_1", 18, nil, score_text_prefix_style),
	wave_prefix_1 = UIWidgets.create_simple_text(Localize("dlc1_2_end_screen_waves") .. ":", "wave_prefix_1", 18, nil, score_text_prefix_style),
	time_prefix_1 = UIWidgets.create_simple_text(Localize("dlc1_2_end_screen_time") .. ":", "time_prefix_1", 18, nil, score_text_prefix_style),
	difficulty_value_1 = UIWidgets.create_simple_text(Localize("dlc1_2_difficulty_survival_hard"), "difficulty_value_1", 18, nil, score_text_value_style),
	wave_value_1 = UIWidgets.create_simple_text("n/a", "wave_value_1", 18, nil, score_text_value_style),
	time_value_1 = UIWidgets.create_simple_text("n/a", "time_value_1", 18, nil, score_text_value_style),
	performance_divider_2 = UIWidgets.create_simple_texture("small_divider", "performance_divider_2"),
	difficulty_prefix_2 = UIWidgets.create_simple_text(Localize("map_difficulty_setting") .. ":", "difficulty_prefix_2", 18, nil, score_text_prefix_style),
	wave_prefix_2 = UIWidgets.create_simple_text(Localize("dlc1_2_end_screen_waves") .. ":", "wave_prefix_2", 18, nil, score_text_prefix_style),
	time_prefix_2 = UIWidgets.create_simple_text(Localize("dlc1_2_end_screen_time") .. ":", "time_prefix_2", 18, nil, score_text_prefix_style),
	difficulty_value_2 = UIWidgets.create_simple_text(Localize("dlc1_2_difficulty_survival_harder"), "difficulty_value_2", 18, nil, score_text_value_style),
	wave_value_2 = UIWidgets.create_simple_text("n/a", "wave_value_2", 18, nil, score_text_value_style),
	time_value_2 = UIWidgets.create_simple_text("n/a", "time_value_2", 18, nil, score_text_value_style),
	performance_divider_3 = UIWidgets.create_simple_texture("small_divider", "performance_divider_3"),
	difficulty_prefix_3 = UIWidgets.create_simple_text(Localize("map_difficulty_setting") .. ":", "difficulty_prefix_3", 18, nil, score_text_prefix_style),
	wave_prefix_3 = UIWidgets.create_simple_text(Localize("dlc1_2_end_screen_waves") .. ":", "wave_prefix_3", 18, nil, score_text_prefix_style),
	time_prefix_3 = UIWidgets.create_simple_text(Localize("dlc1_2_end_screen_time") .. ":", "time_prefix_3", 18, nil, score_text_prefix_style),
	difficulty_value_3 = UIWidgets.create_simple_text(Localize("dlc1_2_difficulty_survival_hardest"), "difficulty_value_3", 18, nil, score_text_value_style),
	wave_value_3 = UIWidgets.create_simple_text("n/a", "wave_value_3", 18, nil, score_text_value_style),
	time_value_3 = UIWidgets.create_simple_text("n/a", "time_value_3", 18, nil, score_text_value_style)
}

return {
	widgets = widgets,
	element_size = element_size,
	create_element = create_element,
	dialogue_speakers = dialogue_speakers,
	scenegraph_definition = scenegraph_definition,
	generic_input_actions = generic_input_actions,
	description_text_colors = description_text_colors,
	difficulty_progression_textures = difficulty_progression_textures
}
