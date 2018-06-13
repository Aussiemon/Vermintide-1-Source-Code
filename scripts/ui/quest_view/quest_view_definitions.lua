local_require("scripts/ui/ui_widgets")

local item_inspect_size = {
	400,
	851
}
local contract_size = {
	368,
	85
}
local event_contract_size = {
	488,
	115
}
local quest_size = {
	483,
	85
}
local log_contract_size = {
	489,
	147
}
local contract_list_start_position = {
	49,
	-62,
	1
}
local contract_log_start_position = {
	-46,
	-62,
	1
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
	root_filler = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
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
	menu_root = {
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
			0
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			420,
			28
		},
		position = {
			0,
			-10,
			1
		}
	},
	exit_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "right",
		size = {
			220,
			62
		},
		position = {
			-50,
			40,
			12
		}
	},
	reload_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			220,
			62
		},
		position = {
			0,
			0,
			12
		}
	},
	progress_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "right",
		size = {
			220,
			62
		},
		position = {
			-270,
			40,
			12
		}
	},
	accept_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			454,
			83
		},
		position = {
			0,
			60,
			10
		}
	},
	contract_list_root = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			quest_size[1],
			0
		},
		position = {
			contract_list_start_position[1],
			contract_list_start_position[2],
			contract_list_start_position[3]
		}
	},
	contract_list_title = {
		vertical_alignment = "top",
		parent = "contract_list_root",
		horizontal_alignment = "center",
		size = {
			contract_size[1],
			50
		},
		position = {
			0,
			66,
			1
		}
	},
	contract_list_1 = {
		vertical_alignment = "top",
		parent = "contract_list_root",
		horizontal_alignment = "left",
		size = {
			quest_size[1],
			quest_size[2]
		},
		position = {
			0,
			0,
			1
		}
	},
	contract_list_1_title = {
		vertical_alignment = "top",
		parent = "contract_list_root",
		horizontal_alignment = "center",
		size = {
			contract_size[1],
			30
		},
		position = {
			0,
			30,
			1
		}
	},
	contract_list_2 = {
		vertical_alignment = "top",
		parent = "contract_list_1",
		horizontal_alignment = "center",
		size = {
			contract_size[1],
			contract_size[2]
		},
		position = {
			0,
			0,
			0
		}
	},
	contract_list_2_title = {
		vertical_alignment = "top",
		parent = "contract_list_2",
		horizontal_alignment = "center",
		size = {
			contract_size[1],
			30
		},
		position = {
			0,
			-305,
			1
		}
	},
	contract_list_3 = {
		vertical_alignment = "top",
		parent = "contract_list_2",
		horizontal_alignment = "center",
		size = {
			contract_size[1],
			contract_size[2]
		},
		position = {
			0,
			0,
			0
		}
	},
	contract_list_3_title = {
		vertical_alignment = "top",
		parent = "contract_list_3",
		horizontal_alignment = "center",
		size = {
			contract_size[1],
			30
		},
		position = {
			0,
			-640,
			1
		}
	},
	contract_list_event = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			event_contract_size[1],
			event_contract_size[2]
		},
		position = {
			1,
			900,
			contract_list_start_position[3]
		}
	},
	contract_log_root = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "right",
		size = {
			log_contract_size[1],
			0
		},
		position = {
			contract_log_start_position[1],
			contract_log_start_position[2] + 64,
			contract_log_start_position[3]
		}
	},
	contract_log = {
		vertical_alignment = "top",
		parent = "contract_log_root",
		horizontal_alignment = "left",
		size = {
			log_contract_size[1],
			log_contract_size[2]
		},
		position = {
			0,
			0,
			1
		}
	},
	contract_log_title = {
		vertical_alignment = "top",
		parent = "contract_log_root",
		horizontal_alignment = "center",
		size = {
			contract_size[1],
			50
		},
		position = {
			0,
			3,
			1
		}
	},
	contract_log_quest_symbol_1 = {
		vertical_alignment = "top",
		parent = "contract_log_root",
		horizontal_alignment = "center",
		size = {
			150,
			143
		},
		position = {
			-170,
			-25,
			1
		}
	},
	contract_log_quest_symbol_2 = {
		vertical_alignment = "top",
		parent = "contract_log_root",
		horizontal_alignment = "center",
		size = {
			150,
			143
		},
		position = {
			170,
			-25,
			1
		}
	},
	contract_log_holder_1 = {
		vertical_alignment = "top",
		parent = "contract_log",
		horizontal_alignment = "center",
		size = {
			502,
			52
		},
		position = {
			0,
			-386,
			1
		}
	},
	contract_log_holder_2 = {
		vertical_alignment = "top",
		parent = "contract_log",
		horizontal_alignment = "center",
		size = {
			502,
			52
		},
		position = {
			0,
			-595,
			1
		}
	},
	contract_log_holder_3 = {
		vertical_alignment = "top",
		parent = "contract_log",
		horizontal_alignment = "center",
		size = {
			502,
			52
		},
		position = {
			0,
			-806,
			1
		}
	},
	quest_progress_root = {
		vertical_alignment = "center",
		parent = "contract_log_root",
		horizontal_alignment = "center",
		size = {
			396,
			29
		},
		position = {
			0,
			-185,
			2
		}
	},
	quest_progress_slots = {
		vertical_alignment = "center",
		parent = "quest_progress_root",
		horizontal_alignment = "left",
		size = {
			396,
			33
		},
		position = {
			0,
			3,
			1
		}
	},
	quest_progress_slots_dots = {
		vertical_alignment = "center",
		parent = "quest_progress_slots",
		horizontal_alignment = "left",
		size = {
			396,
			33
		},
		position = {
			0,
			0,
			2
		}
	},
	quest_progress_bar = {
		vertical_alignment = "center",
		parent = "quest_progress_root",
		horizontal_alignment = "left",
		size = {
			396,
			29
		},
		position = {
			0,
			3,
			2
		}
	},
	presentation_bg = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			648,
			823
		},
		position = {
			0,
			-25,
			1
		}
	},
	presentation_title = {
		vertical_alignment = "top",
		parent = "presentation_bg",
		horizontal_alignment = "center",
		size = {
			600,
			50
		},
		position = {
			0,
			0,
			1
		}
	},
	presentation_sub_title = {
		vertical_alignment = "center",
		parent = "presentation_title",
		horizontal_alignment = "center",
		size = {
			600,
			50
		},
		position = {
			0,
			-30,
			1
		}
	},
	presentation_difficulty = {
		vertical_alignment = "center",
		parent = "presentation_sub_title",
		horizontal_alignment = "center",
		size = {
			600,
			50
		},
		position = {
			0,
			-25,
			1
		}
	},
	presentation_title_divider = {
		vertical_alignment = "center",
		parent = "presentation_difficulty",
		horizontal_alignment = "center",
		size = {
			430,
			20
		},
		position = {
			0,
			-30,
			1
		}
	},
	presentation_text = {
		vertical_alignment = "top",
		parent = "presentation_title_divider",
		horizontal_alignment = "center",
		size = {
			600,
			200
		},
		position = {
			0,
			-40,
			1
		}
	},
	presentation_reward_title = {
		vertical_alignment = "center",
		parent = "presentation_objective_title",
		horizontal_alignment = "left",
		size = {
			600,
			40
		},
		position = {
			0,
			-120,
			1
		}
	},
	presentation_reward_boon = {
		vertical_alignment = "center",
		parent = "presentation_reward_item",
		horizontal_alignment = "center",
		size = {
			38,
			38
		},
		position = {
			0,
			0,
			1
		}
	},
	presentation_reward_token = {
		vertical_alignment = "center",
		parent = "presentation_reward_item",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			1
		}
	},
	presentation_objective_title = {
		vertical_alignment = "bottom",
		parent = "presentation_bg",
		horizontal_alignment = "center",
		size = {
			600,
			40
		},
		position = {
			0,
			270,
			1
		}
	},
	presentation_objective_icon = {
		vertical_alignment = "center",
		parent = "presentation_objective_title",
		horizontal_alignment = "left",
		size = {
			80,
			80
		},
		position = {
			0,
			-60,
			1
		}
	},
	presentation_objective_counter = {
		vertical_alignment = "center",
		parent = "presentation_objective_icon",
		horizontal_alignment = "right",
		size = {
			500,
			20
		},
		position = {
			510,
			0,
			1
		}
	},
	presentation_completed = {
		vertical_alignment = "center",
		parent = "presentation_bg",
		horizontal_alignment = "right",
		size = {
			408,
			179
		},
		position = {
			-35,
			-50,
			10
		}
	},
	presentation_item_border = {
		vertical_alignment = "top",
		parent = "presentation_reward_title",
		horizontal_alignment = "left",
		size = {
			560,
			118
		},
		position = {
			0,
			-40,
			1
		}
	},
	presentation_item_border_icon = {
		vertical_alignment = "top",
		parent = "presentation_item_border",
		horizontal_alignment = "right",
		size = {
			54,
			54
		},
		position = {
			15,
			15,
			1
		}
	},
	presentation_reward_item = {
		vertical_alignment = "center",
		parent = "presentation_item_border",
		horizontal_alignment = "left",
		size = {
			64,
			64
		},
		position = {
			25,
			0,
			1
		}
	},
	presentation_reward_item_frame = {
		vertical_alignment = "center",
		parent = "presentation_reward_item",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			0,
			1
		}
	},
	presentation_item_name = {
		vertical_alignment = "top",
		parent = "presentation_reward_item",
		horizontal_alignment = "left",
		size = {
			440,
			50
		},
		position = {
			70,
			-5,
			3
		}
	},
	presentation_item_type_name = {
		vertical_alignment = "top",
		parent = "presentation_item_name",
		horizontal_alignment = "left",
		size = {
			440,
			50
		},
		position = {
			0,
			-25,
			3
		}
	},
	presentation_item_hero_icon = {
		vertical_alignment = "top",
		parent = "presentation_item_border",
		horizontal_alignment = "right",
		size = {
			58,
			58
		},
		position = {
			-30,
			-5,
			3
		}
	},
	presentation_trait_button_1 = {
		vertical_alignment = "bottom",
		parent = "presentation_item_border",
		horizontal_alignment = "right",
		size = {
			40,
			40
		},
		position = {
			-15,
			15,
			6
		}
	},
	presentation_trait_button_2 = {
		vertical_alignment = "bottom",
		parent = "presentation_trait_button_1",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-50,
			0,
			6
		}
	},
	presentation_trait_button_3 = {
		vertical_alignment = "bottom",
		parent = "presentation_trait_button_2",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-50,
			0,
			6
		}
	},
	presentation_trait_button_4 = {
		vertical_alignment = "bottom",
		parent = "presentation_trait_button_3",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-50,
			0,
			6
		}
	},
	presentation_trait_tooltip_1 = {
		vertical_alignment = "center",
		parent = "presentation_trait_button_1",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			16
		}
	},
	presentation_trait_tooltip_2 = {
		vertical_alignment = "center",
		parent = "presentation_trait_button_2",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			16
		}
	},
	presentation_trait_tooltip_3 = {
		vertical_alignment = "center",
		parent = "presentation_trait_button_3",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			16
		}
	},
	presentation_trait_tooltip_4 = {
		vertical_alignment = "center",
		parent = "presentation_trait_button_4",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			16
		}
	},
	loading_overlay = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			35
		},
		size = {
			1920,
			1080
		}
	},
	loading_icon = {
		vertical_alignment = "center",
		parent = "loading_overlay",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			50,
			50
		}
	},
	loading_text = {
		vertical_alignment = "center",
		parent = "loading_icon",
		horizontal_alignment = "center",
		position = {
			0,
			-90,
			1
		},
		size = {
			800,
			50
		}
	}
}
local presentation_text_color = {
	240,
	15,
	10,
	10
}
local presentation_text_style = {
	vertical_alignment = "top",
	font_size = 18,
	localize = false,
	horizontal_alignment = "left",
	word_wrap = true,
	font_type = "hell_shark_no_outline",
	text_color = presentation_text_color,
	offset = {
		0,
		0,
		2
	}
}
local task_presentation_text_style = {
	vertical_alignment = "center",
	font_size = 18,
	localize = false,
	horizontal_alignment = "left",
	word_wrap = true,
	font_type = "hell_shark_no_outline",
	text_color = presentation_text_color,
	offset = {
		0,
		0,
		2
	}
}
local presentation_title_text_style = {
	vertical_alignment = "center",
	font_size = 24,
	localize = true,
	horizontal_alignment = "left",
	word_wrap = true,
	font_type = "hell_shark_no_outline",
	text_color = presentation_text_color,
	offset = {
		0,
		0,
		2
	}
}
local default_tooltip_style = {
	font_size = 24,
	max_width = 500,
	localize = false,
	horizontal_alignment = "left",
	vertical_alignment = "top",
	font_type = "hell_shark",
	text_color = Colors.get_color_table_with_alpha("white", 255),
	line_colors = {},
	offset = {
		0,
		0,
		3
	}
}
local item_name_style = table.clone(presentation_text_style)
item_name_style.font_size = 24
local trait_tooltip_style = table.clone(default_tooltip_style)
trait_tooltip_style.cursor_side = "left"
trait_tooltip_style.cursor_offset = {
	-10,
	-27
}
trait_tooltip_style.line_colors = {
	Colors.get_color_table_with_alpha("cheeseburger", 255),
	Colors.get_color_table_with_alpha("white", 255)
}
trait_tooltip_style.last_line_color = Colors.get_color_table_with_alpha("red", 255)
local widgets_definitions = {
	title_text = UIWidgets.create_title_text("dlc1_3_1_quest_board_title", "title_text"),
	background = UIWidgets.create_simple_texture("quest_screen_bg", "menu_root"),
	background_hotspot = UIWidgets.create_simple_hotspot("menu_root"),
	exit_button = UIWidgets.create_menu_button_medium("close", "exit_button"),
	accept_button = UIWidgets.create_popup_button_long("dlc1_3_1_quest_title", "accept_button"),
	reload_button = UIWidgets.create_menu_button_medium("reload_all", "reload_button"),
	progress_button = UIWidgets.create_menu_button_medium("fill_progress", "progress_button"),
	quest_progress_bar = UIWidgets.create_simple_uv_texture("quest_progress_bar_fill_01", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "quest_progress_bar"),
	quest_progress_bar_dots = UIWidgets.create_simple_centered_uv_texture_amount("quest_progress_bar_fill_02", {
		33,
		33
	}, 10, 1, "quest_progress_slots"),
	quest_progress_bar_dot_slots = UIWidgets.create_simple_centered_uv_texture_amount("quest_progress_bar_bg", {
		33,
		33
	}, 10, 1, "quest_progress_root"),
	quest_progress_bar_slots_dots = UIWidgets.create_simple_centered_uv_texture_amount("quest_progress_bar_bg_prick", {
		33,
		33
	}, 10, 1, "quest_progress_slots_dots"),
	contract_log_title = UIWidgets.create_title_text("dlc1_3_1_log_title", "contract_log_title"),
	contract_list_title = UIWidgets.create_title_text("dlc1_3_1_available_board", "contract_list_title"),
	contract_log_quest_symbol_1 = UIWidgets.create_simple_texture("quest_ubersreik_icon", "contract_log_quest_symbol_1"),
	contract_log_quest_symbol_glow_1 = UIWidgets.create_simple_texture("quest_ubersreik_icon_glow", "contract_log_quest_symbol_1"),
	contract_log_quest_symbol_2 = UIWidgets.create_simple_texture("quest_ubersreik_icon", "contract_log_quest_symbol_2"),
	contract_log_quest_symbol_glow_2 = UIWidgets.create_simple_texture("quest_ubersreik_icon_glow", "contract_log_quest_symbol_2"),
	contract_log_holder_1 = UIWidgets.create_simple_texture("contract_holder", "contract_log_holder_1"),
	contract_log_holder_2 = UIWidgets.create_simple_texture("contract_holder", "contract_log_holder_2"),
	contract_log_holder_3 = UIWidgets.create_simple_texture("contract_holder", "contract_log_holder_3"),
	presentation_bg = UIWidgets.create_simple_texture("quest_paper_bg", "presentation_bg"),
	presentation_completed = UIWidgets.create_simple_texture("quest_completed", "presentation_completed"),
	presentation_title_divider = UIWidgets.create_simple_texture("quest_content_divider", "presentation_title_divider"),
	presentation_title = UIWidgets.create_simple_text("n/a", "presentation_title", 32, presentation_text_color, nil, "hell_shark_no_outline"),
	presentation_sub_title = UIWidgets.create_simple_text("n/a", "presentation_sub_title", 20, presentation_text_color, nil, "hell_shark_no_outline"),
	presentation_difficulty = UIWidgets.create_simple_text("n/a", "presentation_difficulty", 18, presentation_text_color, nil, "hell_shark_no_outline"),
	presentation_text = UIWidgets.create_simple_text("n/a", "presentation_text", nil, nil, presentation_text_style),
	presentation_objective_icon = UIWidgets.create_simple_texture("quest_icon_rat_ogre", "presentation_objective_icon"),
	presentation_objective_counter = UIWidgets.create_simple_text("n/a", "presentation_objective_counter", nil, nil, task_presentation_text_style),
	presentation_objective_title = UIWidgets.create_simple_text("dlc1_2_summary_screen_entry_title", "presentation_objective_title", nil, nil, presentation_title_text_style),
	presentation_reward_title = UIWidgets.create_simple_text("dlc1_2_summary_screen_entry_reward_title", "presentation_reward_title", nil, nil, presentation_title_text_style),
	presentation_reward_item = UIWidgets.create_simple_texture("icon_dw_shield_01_axe_01", "presentation_reward_item"),
	presentation_reward_item_frame = UIWidgets.create_simple_texture("frame_01", "presentation_reward_item_frame"),
	presentation_reward_boon = UIWidgets.create_simple_texture("frame_01", "presentation_reward_boon"),
	presentation_reward_token = UIWidgets.create_simple_texture("frame_01", "presentation_reward_token"),
	presentation_item_hero_icon = UIWidgets.create_simple_texture("quest_class_icon_empire_soldier", "presentation_item_hero_icon"),
	presentation_item_hero_tooltip = UIWidgets.create_simple_tooltip("", "presentation_item_hero_icon", nil, default_tooltip_style),
	presentation_item_border = UIWidgets.create_simple_texture("contract_reward_frame", "presentation_item_border"),
	presentation_item_border_icon = UIWidgets.create_simple_texture("contract_key_icon", "presentation_item_border_icon"),
	presentation_item_border_icon_2 = UIWidgets.create_simple_texture("contract_key_icon", "presentation_item_border_icon"),
	presentation_item_name = UIWidgets.create_simple_text("dlc1_2_summary_screen_entry_title", "presentation_item_name", nil, nil, item_name_style),
	presentation_item_type_name = UIWidgets.create_simple_text("dlc1_2_summary_screen_entry_title", "presentation_item_type_name", nil, nil, presentation_text_style),
	presentation_trait_button_1 = UIWidgets.create_small_trait_button("presentation_trait_button_1", "presentation_trait_button_1"),
	presentation_trait_button_2 = UIWidgets.create_small_trait_button("presentation_trait_button_2", "presentation_trait_button_2"),
	presentation_trait_button_3 = UIWidgets.create_small_trait_button("presentation_trait_button_3", "presentation_trait_button_3"),
	presentation_trait_button_4 = UIWidgets.create_small_trait_button("presentation_trait_button_4", "presentation_trait_button_4"),
	presentation_trait_tooltip_1 = UIWidgets.create_simple_tooltip("", "presentation_trait_tooltip_1", nil, trait_tooltip_style),
	presentation_trait_tooltip_2 = UIWidgets.create_simple_tooltip("", "presentation_trait_tooltip_2", nil, trait_tooltip_style),
	presentation_trait_tooltip_3 = UIWidgets.create_simple_tooltip("", "presentation_trait_tooltip_3", nil, trait_tooltip_style),
	presentation_trait_tooltip_4 = UIWidgets.create_simple_tooltip("", "presentation_trait_tooltip_4", nil, trait_tooltip_style),
	loading_overlay = UIWidgets.create_simple_rect("loading_overlay", {
		180,
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
	loading_icon = UIWidgets.create_simple_rotated_texture("matchmaking_connecting_icon", 0, {
		25,
		25
	}, "loading_icon"),
	loading_text = UIWidgets.create_simple_text("dlc_1_3_1_reshresh_description", "loading_text", 28, Colors.get_color_table_with_alpha("cheeseburger", 0))
}
local animations = {}
local use_fixed_position = false

local function create_board_contract_widget(parent_scenegraph_id)
	local content = {
		active = false
	}
	local style = {}
	local passes = {}
	local element = {
		passes = passes
	}
	local widget_definition = {
		element = element,
		content = content,
		style = style,
		scenegraph_id = parent_scenegraph_id,
		offset = {
			0,
			0,
			0
		}
	}
	local is_event_contract = parent_scenegraph_id == "contract_list_event"
	local contract_size = (is_event_contract and event_contract_size) or contract_size
	local hotspot_pass = {
		style_id = "button_hotspot",
		pass_type = "hotspot",
		content_id = "button_hotspot"
	}
	passes[#passes + 1] = hotspot_pass
	content[hotspot_pass.content_id] = {}
	local reward_hotspot_pass = {
		style_id = "boon_reward_texture",
		pass_type = "hotspot",
		content_id = "reward_button_hotspot"
	}
	passes[#passes + 1] = reward_hotspot_pass
	content[reward_hotspot_pass.content_id] = {}
	local reward_tooltip_pass = {
		style_id = "tooltip_text",
		pass_type = "tooltip_text",
		text_id = "tooltip_text",
		content_check_function = function (content, style)
			return content.reward_button_hotspot.is_hover or (content.gamepad_preview and style.use_fixed_position)
		end
	}
	passes[#passes + 1] = reward_tooltip_pass
	content[reward_tooltip_pass.text_id] = "test"
	style[reward_tooltip_pass.style_id] = {
		font_type = "hell_shark",
		localize = false,
		font_size = 18,
		horizontal_alignment = "left",
		vertical_alignment = "top",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		fixed_position = {
			20,
			40
		},
		use_fixed_position = use_fixed_position or false,
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local background_texture_pass = {
		pass_type = "texture",
		style_id = "background_texture",
		texture_id = "background_texture"
	}
	passes[#passes + 1] = background_texture_pass
	content[background_texture_pass.texture_id] = (is_event_contract and "board_contract_bg_event") or "board_contract_bg_default"
	style[background_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			0,
			0,
			0
		}
	}

	if is_event_contract then
		local holder_texture_pass = {
			pass_type = "texture",
			style_id = "holder_texture",
			texture_id = "holder_texture"
		}
		passes[#passes + 1] = holder_texture_pass
		content[holder_texture_pass.texture_id] = "board_contract_holder_event"
		style[holder_texture_pass.style_id] = {
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				(contract_size[1] - 551 - 4) * 0.5,
				(contract_size[2] - 124 + 5) * 0.5,
				1
			},
			size = {
				551,
				124
			}
		}
		local left_holder_glow_texture_pass = {
			pass_type = "texture",
			style_id = "right_holder_glow_texture",
			texture_id = "holder_glow_texture"
		}
		passes[#passes + 1] = left_holder_glow_texture_pass
		content[left_holder_glow_texture_pass.texture_id] = "quest_event_contract_holder_glow"
		style[left_holder_glow_texture_pass.style_id] = {
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				-27,
				(contract_size[2] - 40 + 22) * 0.5,
				2
			},
			size = {
				40,
				50
			}
		}
		local right_holder_glow_texture_pass = {
			pass_type = "texture",
			style_id = "left_holder_glow_texture",
			texture_id = "holder_glow_texture"
		}
		passes[#passes + 1] = right_holder_glow_texture_pass
		content[right_holder_glow_texture_pass.texture_id] = "quest_event_contract_holder_glow"
		style[right_holder_glow_texture_pass.style_id] = {
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				contract_size[1] - 18,
				(contract_size[2] - 40 + 22) * 0.5,
				2
			},
			size = {
				40,
				50
			}
		}
		local countdown_text_pass = {
			style_id = "countdown",
			pass_type = "text",
			text_id = "countdown"
		}
		passes[#passes + 1] = countdown_text_pass
		content[countdown_text_pass.text_id] = ""
		style[countdown_text_pass.style_id] = {
			font_size = 24,
			localize = false,
			word_wrap = true,
			horizontal_alignment = "center",
			vertical_alignment = "top",
			font_type = "hell_shark_no_outline",
			text_color = {
				255,
				255,
				255,
				255
			},
			size = {
				contract_size[1],
				contract_size[2]
			},
			offset = {
				0,
				0,
				5
			}
		}
	end

	local hover_edge_glow_pass = {
		pass_type = "texture",
		style_id = "edge_glow_hover",
		texture_id = "edge_glow",
		content_check_function = function (content)
			return not content.button_hotspot.is_selected and content.button_hotspot.is_hover
		end
	}
	local size_x = (is_event_contract and 504) or 401
	local size_y = (is_event_contract and 135) or 119
	passes[#passes + 1] = hover_edge_glow_pass
	content[hover_edge_glow_pass.texture_id] = (is_event_contract and "contract_glow_event") or "contract_glow_02"
	style[hover_edge_glow_pass.style_id] = {
		color = {
			150,
			255,
			255,
			255
		},
		offset = {
			(contract_size[1] - size_x - 4) * 0.5,
			(contract_size[2] - size_y + 5) * 0.5
		},
		size = {
			size_x,
			size_y
		}
	}
	local selected_edge_glow_pass = {
		pass_type = "texture",
		style_id = "edge_glow_selected",
		texture_id = "edge_glow",
		content_check_function = function (content)
			return content.button_hotspot.is_selected
		end
	}
	passes[#passes + 1] = selected_edge_glow_pass
	content[selected_edge_glow_pass.texture_id] = (is_event_contract and "contract_glow_event") or "contract_glow_02"
	style[selected_edge_glow_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = table.clone(style[hover_edge_glow_pass.style_id].offset),
		size = table.clone(style[hover_edge_glow_pass.style_id].size)
	}
	local reward_offset = (is_event_contract and 40) or 0
	local boon_reward_texture_pass = {
		texture_id = "boon_reward_texture",
		style_id = "boon_reward_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.has_boon
		end
	}
	passes[#passes + 1] = boon_reward_texture_pass
	content[boon_reward_texture_pass.texture_id] = "boon_icon_03_extra_starting_gear"
	style[boon_reward_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			reward_offset + 26,
			contract_size[2] / 2 - 19,
			1
		},
		size = {
			38,
			38
		}
	}
	local token_reward_texture_pass = {
		texture_id = "token_reward_texture",
		style_id = "token_reward_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.has_tokens
		end
	}
	passes[#passes + 1] = token_reward_texture_pass
	content[token_reward_texture_pass.texture_id] = "boon_icon_03_extra_starting_gear"
	style[token_reward_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			reward_offset + 6,
			contract_size[2] / 2 - 40,
			1
		},
		size = {
			80,
			80
		}
	}
	local token_text_pass = {
		style_id = "token_text",
		pass_type = "text",
		text_id = "token_text",
		content_check_function = function (content)
			return content.has_tokens
		end
	}
	passes[#passes + 1] = token_text_pass
	content[token_text_pass.text_id] = ""
	style[token_text_pass.style_id] = {
		font_size = 20,
		localize = false,
		word_wrap = false,
		horizontal_alignment = "center",
		vertical_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("black", 255),
		size = {
			80,
			80
		},
		offset = {
			reward_offset + 6,
			contract_size[2] / 2 - 40,
			2
		}
	}
	local key_reward_texture_pass = {
		texture_id = "key_reward_texture",
		style_id = "key_reward_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.has_key
		end
	}
	local key_reward_texture_pass2 = table.clone(key_reward_texture_pass)

	key_reward_texture_pass2.content_check_function = function (content)
		return content.has_key_2
	end

	key_reward_texture_pass2.style_id = "key_reward_texture_2"
	passes[#passes + 1] = key_reward_texture_pass
	passes[#passes + 1] = key_reward_texture_pass2
	content[key_reward_texture_pass.texture_id] = "contract_key_icon"
	style[key_reward_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			reward_offset + 90,
			contract_size[2] / 2 - 27,
			1
		},
		size = {
			54,
			54
		}
	}
	style[key_reward_texture_pass2.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			reward_offset + 100,
			contract_size[2] / 2 - 27,
			1
		},
		size = {
			54,
			54
		}
	}
	local key_reward_hotspot_pass = {
		style_id = "key_reward_texture",
		pass_type = "hotspot",
		content_id = "key_reward_button_hotspot"
	}
	passes[#passes + 1] = key_reward_hotspot_pass
	content[key_reward_hotspot_pass.content_id] = {}
	local key_reward_tooltip_pass = {
		style_id = "key_tooltip_text",
		pass_type = "tooltip_text",
		text_id = "key_tooltip_text",
		content_check_function = function (content)
			return content.key_reward_button_hotspot.is_hover and content.has_key
		end
	}
	passes[#passes + 1] = key_reward_tooltip_pass
	content[key_reward_tooltip_pass.text_id] = "n/a"
	style[key_reward_tooltip_pass.style_id] = {
		font_size = 18,
		localize = false,
		font_type = "hell_shark",
		horizontal_alignment = "left",
		vertical_alignment = "top",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local task_text_pass = {
		style_id = "key_text",
		pass_type = "text",
		text_id = "key_text",
		content_check_function = function (content)
			return content.has_key
		end
	}
	passes[#passes + 1] = task_text_pass
	content[task_text_pass.text_id] = "+"
	style[task_text_pass.style_id] = {
		font_size = 18,
		localize = false,
		word_wrap = true,
		horizontal_alignment = "left",
		vertical_alignment = "center",
		font_type = "hell_shark_no_outline",
		text_color = presentation_text_color,
		size = {
			contract_size[1],
			contract_size[2]
		},
		offset = {
			reward_offset + 72,
			2,
			1
		}
	}
	local task_texture_pass = {
		texture_id = "task_texture",
		style_id = "task_texture",
		pass_type = "texture"
	}
	passes[#passes + 1] = task_texture_pass
	content[task_texture_pass.texture_id] = "quest_icon_rat_ogre"
	style[task_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			contract_size[1] - ((is_event_contract and 79) or 74),
			contract_size[2] / 2 - 30,
			1
		},
		size = {
			60,
			60
		}
	}
	local task_hotspot_pass = {
		style_id = "task_texture",
		pass_type = "hotspot",
		content_id = "task_button_hotspot"
	}
	passes[#passes + 1] = task_hotspot_pass
	content[task_hotspot_pass.content_id] = {}
	local task_tooltip_pass = {
		style_id = "task_tooltip_text",
		pass_type = "tooltip_text",
		text_id = "task_tooltip_text",
		content_check_function = function (content)
			return content.task_button_hotspot.is_hover
		end
	}
	passes[#passes + 1] = task_tooltip_pass
	content[task_tooltip_pass.text_id] = "n/a"
	style[task_tooltip_pass.style_id] = {
		font_size = 18,
		localize = false,
		font_type = "hell_shark",
		horizontal_alignment = "left",
		vertical_alignment = "top",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local level_texture_pass = {
		texture_id = "level_texture",
		style_id = "level_texture",
		pass_type = "texture"
	}
	passes[#passes + 1] = level_texture_pass
	content[level_texture_pass.texture_id] = "level_location_long_icon_01"
	style[level_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			contract_size[1] - ((is_event_contract and 137) or 133),
			contract_size[2] / 2 - 22.5,
			1
		},
		size = {
			42,
			45
		}
	}
	local level_hotspot_pass = {
		style_id = "level_texture",
		pass_type = "hotspot",
		content_id = "level_button_hotspot"
	}
	passes[#passes + 1] = level_hotspot_pass
	content[level_hotspot_pass.content_id] = {}
	local level_tooltip_pass = {
		style_id = "level_tooltip_text",
		pass_type = "tooltip_text",
		text_id = "level_tooltip_text",
		content_check_function = function (content)
			return content.level_button_hotspot.is_hover
		end
	}
	passes[#passes + 1] = level_tooltip_pass
	content[level_tooltip_pass.text_id] = "n/a"
	style[level_tooltip_pass.style_id] = {
		font_size = 18,
		localize = false,
		font_type = "hell_shark",
		horizontal_alignment = "left",
		vertical_alignment = "top",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local locked_rect_pass = {
		style_id = "locked_rect",
		pass_type = "rect",
		content_check_function = function (content)
			return content.locked
		end
	}
	passes[#passes + 1] = locked_rect_pass
	style[locked_rect_pass.style_id] = {
		color = {
			120,
			20,
			20,
			20
		},
		offset = {
			0,
			5,
			10
		},
		size = {
			contract_size[1] - 6,
			contract_size[2] - 5
		}
	}
	content.locked = false
	local locked_texture_pass = {
		texture_id = "locked_texture",
		style_id = "locked_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.locked
		end
	}
	passes[#passes + 1] = locked_texture_pass
	content[locked_texture_pass.texture_id] = "locked_icon_01"
	style[locked_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			contract_size[1] / 2 - 15,
			contract_size[2] / 2 - 19 + 5,
			11
		},
		size = {
			30,
			38
		}
	}
	local difficulty_texture_pass = {
		texture_id = "difficulty_texture",
		style_id = "difficulty_texture",
		pass_type = "multi_texture"
	}
	passes[#passes + 1] = difficulty_texture_pass
	content[difficulty_texture_pass.texture_id] = {
		"contract_difficulty_icon",
		"contract_difficulty_icon",
		"contract_difficulty_icon",
		"contract_difficulty_icon",
		"contract_difficulty_icon"
	}
	style[difficulty_texture_pass.style_id] = {
		direction = 1,
		axis = 2,
		draw_count = 5,
		size = {
			contract_size[1],
			contract_size[2]
		},
		spacing = {
			0,
			0
		},
		texture_sizes = {
			{
				7,
				7
			},
			{
				7,
				7
			},
			{
				7,
				7
			},
			{
				7,
				7
			},
			{
				7,
				7
			}
		},
		texture_offsets = (is_event_contract and {
			{
				1,
				4,
				0
			},
			{
				-9,
				11,
				0
			},
			{
				-14,
				20,
				0
			},
			{
				-9,
				29,
				0
			},
			{
				1,
				35,
				0
			}
		}) or {
			{
				0,
				5,
				0
			},
			{
				-9,
				11,
				0
			},
			{
				-14,
				19,
				0
			},
			{
				-9,
				27,
				0
			},
			{
				0,
				33,
				0
			}
		},
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			contract_size[1] - ((is_event_contract and 150) or 145),
			(is_event_contract and 22) or 7,
			11
		}
	}

	return widget_definition
end

local function create_log_contract_widget(parent_scenegraph_id)
	local content = {
		active = false
	}
	local style = {}
	local passes = {}
	local element = {
		passes = passes
	}
	local widget_definition = {
		element = element,
		content = content,
		style = style,
		scenegraph_id = parent_scenegraph_id,
		offset = {
			0,
			0,
			0
		}
	}
	local hotspot_pass = {
		style_id = "button_hotspot",
		pass_type = "hotspot",
		content_id = "button_hotspot",
		content_check_function = function (content)
			return not content.parent.is_quest
		end
	}
	passes[#passes + 1] = hotspot_pass
	content[hotspot_pass.content_id] = {}
	local reward_hotspot_pass = {
		style_id = "boon_reward_texture",
		pass_type = "hotspot",
		content_id = "reward_button_hotspot"
	}
	passes[#passes + 1] = reward_hotspot_pass
	content[reward_hotspot_pass.content_id] = {}
	local reward_tooltip_pass = {
		style_id = "tooltip_text",
		pass_type = "tooltip_text",
		text_id = "tooltip_text",
		content_check_function = function (content, style)
			return content.reward_button_hotspot.is_hover or (content.gamepad_preview and style.use_fixed_position)
		end
	}
	passes[#passes + 1] = reward_tooltip_pass
	content[reward_tooltip_pass.text_id] = "test"
	style[reward_tooltip_pass.style_id] = {
		horizontal_alignment = "left",
		font_type = "hell_shark",
		localize = false,
		font_size = 18,
		vertical_alignment = "top",
		cursor_side = "left",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		cursor_offset = {
			-10,
			-27
		},
		fixed_position = {
			20,
			0
		},
		use_fixed_position = use_fixed_position or false,
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local background_texture_pass = {
		pass_type = "texture",
		style_id = "background_texture",
		texture_id = "background_texture"
	}
	passes[#passes + 1] = background_texture_pass
	content[background_texture_pass.texture_id] = "log_contract_bg_default"
	style[background_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			0,
			0,
			0
		}
	}
	local hover_edge_glow_pass = {
		pass_type = "texture",
		style_id = "edge_glow_hover",
		texture_id = "edge_glow",
		content_check_function = function (content)
			return not content.button_hotspot.is_selected and content.button_hotspot.is_hover
		end
	}
	passes[#passes + 1] = hover_edge_glow_pass
	content[hover_edge_glow_pass.texture_id] = "contract_glow_03"
	style[hover_edge_glow_pass.style_id] = {
		color = {
			150,
			255,
			255,
			255
		},
		offset = {
			log_contract_size[1] / 2 - 254 - 2,
			log_contract_size[2] / 2 - 84 + 2,
			5
		},
		size = {
			508,
			168
		}
	}
	local selected_edge_glow_pass = {
		pass_type = "texture",
		style_id = "edge_glow_selected",
		texture_id = "edge_glow",
		content_check_function = function (content)
			return content.button_hotspot.is_selected
		end
	}
	passes[#passes + 1] = selected_edge_glow_pass
	content[selected_edge_glow_pass.texture_id] = "contract_glow_03"
	style[selected_edge_glow_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			log_contract_size[1] / 2 - 254 - 2,
			log_contract_size[2] / 2 - 84 + 2,
			5
		},
		size = {
			508,
			168
		}
	}
	local boon_reward_texture_pass = {
		texture_id = "boon_reward_texture",
		style_id = "boon_reward_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.has_boon
		end
	}
	passes[#passes + 1] = boon_reward_texture_pass
	content[boon_reward_texture_pass.texture_id] = "boon_icon_03_extra_starting_gear"
	style[boon_reward_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			26,
			log_contract_size[2] / 2 - 19 - 10,
			1
		},
		size = {
			38,
			38
		}
	}
	local token_reward_texture_pass = {
		texture_id = "token_reward_texture",
		style_id = "token_reward_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.has_tokens
		end
	}
	passes[#passes + 1] = token_reward_texture_pass
	content[token_reward_texture_pass.texture_id] = "boon_icon_03_extra_starting_gear"
	style[token_reward_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			6,
			log_contract_size[2] / 2 - 40 - 10,
			1
		},
		size = {
			80,
			80
		}
	}
	local token_text_pass = {
		style_id = "token_text",
		pass_type = "text",
		text_id = "token_text",
		content_check_function = function (content)
			return content.has_tokens
		end
	}
	passes[#passes + 1] = token_text_pass
	content[token_text_pass.text_id] = ""
	style[token_text_pass.style_id] = {
		font_size = 20,
		localize = false,
		word_wrap = false,
		horizontal_alignment = "center",
		vertical_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("black", 255),
		size = {
			80,
			80
		},
		offset = {
			6,
			log_contract_size[2] / 2 - 40 - 10,
			2
		}
	}
	local key_reward_texture_pass = {
		texture_id = "key_reward_texture",
		style_id = "key_reward_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.has_key
		end
	}
	local key_reward_texture_pass2 = table.clone(key_reward_texture_pass)

	key_reward_texture_pass2.content_check_function = function (content)
		return content.has_key_2
	end

	key_reward_texture_pass2.style_id = "key_reward_texture_2"
	passes[#passes + 1] = key_reward_texture_pass
	passes[#passes + 1] = key_reward_texture_pass2
	content[key_reward_texture_pass.texture_id] = "contract_key_icon"
	local key_style_definition = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			92,
			log_contract_size[2] / 2 - 27 - 10,
			1
		},
		size = {
			54,
			54
		}
	}
	style[key_reward_texture_pass.style_id] = key_style_definition
	local key2_style_definition = table.clone(key_style_definition)
	key2_style_definition.offset[1] = key2_style_definition.offset[1] + 10
	style[key_reward_texture_pass2.style_id] = key2_style_definition
	local key_reward_hotspot_pass = {
		style_id = "key_reward_texture",
		pass_type = "hotspot",
		content_id = "key_reward_button_hotspot"
	}
	passes[#passes + 1] = key_reward_hotspot_pass
	content[key_reward_hotspot_pass.content_id] = {}
	local key_reward_tooltip_pass = {
		style_id = "key_tooltip_text",
		pass_type = "tooltip_text",
		text_id = "key_tooltip_text",
		content_check_function = function (content)
			return content.key_reward_button_hotspot.is_hover and content.has_key
		end
	}
	passes[#passes + 1] = key_reward_tooltip_pass
	content[key_reward_tooltip_pass.text_id] = "n/a"
	style[key_reward_tooltip_pass.style_id] = {
		horizontal_alignment = "left",
		font_type = "hell_shark",
		localize = false,
		font_size = 18,
		vertical_alignment = "top",
		cursor_side = "left",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		cursor_offset = {
			-10,
			-27
		},
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local task_text_pass = {
		style_id = "key_text",
		pass_type = "text",
		text_id = "key_text",
		content_check_function = function (content)
			return content.has_key
		end
	}
	passes[#passes + 1] = task_text_pass
	content[task_text_pass.text_id] = "+"
	style[task_text_pass.style_id] = {
		font_size = 18,
		localize = false,
		word_wrap = true,
		horizontal_alignment = "left",
		vertical_alignment = "center",
		font_type = "hell_shark_no_outline",
		text_color = presentation_text_color,
		size = {
			log_contract_size[1],
			log_contract_size[2]
		},
		offset = {
			72,
			-8,
			1
		}
	}
	local level_texture_pass = {
		texture_id = "level_texture",
		style_id = "level_texture",
		pass_type = "texture"
	}
	passes[#passes + 1] = level_texture_pass
	content[level_texture_pass.texture_id] = "level_location_long_icon_01"
	style[level_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			log_contract_size[1] - 139,
			38,
			1
		},
		size = {
			42,
			45
		}
	}
	local level_hotspot_pass = {
		style_id = "level_texture",
		pass_type = "hotspot",
		content_id = "level_button_hotspot"
	}
	passes[#passes + 1] = level_hotspot_pass
	content[level_hotspot_pass.content_id] = {}
	local level_tooltip_pass = {
		style_id = "level_tooltip_text",
		pass_type = "tooltip_text",
		text_id = "level_tooltip_text",
		content_check_function = function (content)
			return content.level_button_hotspot.is_hover
		end
	}
	passes[#passes + 1] = level_tooltip_pass
	content[level_tooltip_pass.text_id] = "n/a"
	style[level_tooltip_pass.style_id] = {
		horizontal_alignment = "left",
		font_type = "hell_shark",
		localize = false,
		font_size = 18,
		vertical_alignment = "top",
		cursor_side = "left",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		cursor_offset = {
			-10,
			-27
		},
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local task_hotspot_pass = {
		style_id = "task_texture",
		pass_type = "hotspot",
		content_id = "task_button_hotspot"
	}
	passes[#passes + 1] = task_hotspot_pass
	content[task_hotspot_pass.content_id] = {}
	local task_tooltip_pass = {
		style_id = "task_tooltip_text",
		pass_type = "tooltip_text",
		text_id = "task_tooltip_text",
		content_check_function = function (content)
			return content.task_button_hotspot.is_hover
		end
	}
	passes[#passes + 1] = task_tooltip_pass
	content[task_tooltip_pass.text_id] = "n/a"
	style[task_tooltip_pass.style_id] = {
		horizontal_alignment = "left",
		font_type = "hell_shark",
		localize = false,
		font_size = 18,
		vertical_alignment = "top",
		cursor_side = "left",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		cursor_offset = {
			-10,
			-27
		},
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local task_texture_pass = {
		texture_id = "task_texture",
		style_id = "task_texture",
		pass_type = "texture"
	}
	passes[#passes + 1] = task_texture_pass
	content[task_texture_pass.texture_id] = "quest_icon_rat_ogre"
	style[task_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			log_contract_size[1] - 80,
			30,
			1
		},
		size = {
			60,
			60
		}
	}
	local task_text_pass = {
		style_id = "task_text",
		pass_type = "text",
		text_id = "task_text"
	}
	passes[#passes + 1] = task_text_pass
	content[task_text_pass.text_id] = "n/a"
	style[task_text_pass.style_id] = {
		font_size = 24,
		localize = false,
		word_wrap = true,
		horizontal_alignment = "right",
		vertical_alignment = "top",
		font_type = "hell_shark_no_outline",
		text_color = presentation_text_color,
		size = {
			log_contract_size[1],
			log_contract_size[2]
		},
		offset = {
			-30,
			-1,
			1
		}
	}
	local title_text_pass = {
		style_id = "title_text",
		pass_type = "text",
		text_id = "title_text"
	}
	passes[#passes + 1] = title_text_pass
	content[title_text_pass.text_id] = "Title text here"
	style[title_text_pass.style_id] = {
		font_size = 24,
		localize = false,
		word_wrap = true,
		horizontal_alignment = "left",
		vertical_alignment = "top",
		font_type = "hell_shark_no_outline",
		text_color = presentation_text_color,
		size = {
			350,
			log_contract_size[2]
		},
		offset = {
			22,
			-1,
			1
		}
	}
	local completed_texture_pass = {
		texture_id = "completed_texture",
		style_id = "completed_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.completed
		end
	}
	passes[#passes + 1] = completed_texture_pass
	content[completed_texture_pass.texture_id] = "completed_icon"
	style[completed_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			log_contract_size[1] / 2 - 83.60000000000001 - 10,
			log_contract_size[2] / 2 - 26.8 - 20,
			1
		},
		size = {
			167.20000000000002,
			53.6
		}
	}
	local difficulty_texture_pass = {
		texture_id = "difficulty_texture",
		style_id = "difficulty_texture",
		pass_type = "multi_texture"
	}
	passes[#passes + 1] = difficulty_texture_pass
	content[difficulty_texture_pass.texture_id] = {
		"contract_difficulty_icon",
		"contract_difficulty_icon",
		"contract_difficulty_icon",
		"contract_difficulty_icon",
		"contract_difficulty_icon"
	}
	style[difficulty_texture_pass.style_id] = {
		direction = 1,
		axis = 2,
		draw_count = 5,
		size = {
			log_contract_size[1],
			log_contract_size[2]
		},
		spacing = {
			0,
			0
		},
		texture_sizes = {
			{
				7,
				7
			},
			{
				7,
				7
			},
			{
				7,
				7
			},
			{
				7,
				7
			},
			{
				7,
				7
			}
		},
		texture_offsets = {
			{
				0,
				5,
				0
			},
			{
				-9,
				11,
				0
			},
			{
				-14,
				19,
				0
			},
			{
				-9,
				27,
				0
			},
			{
				0,
				33,
				0
			}
		},
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			log_contract_size[1] - 149,
			24,
			11
		}
	}

	return widget_definition
end

local function create_quest_widget(parent_scenegraph_id)
	local content = {
		active = false
	}
	local style = {}
	local passes = {}
	local element = {
		passes = passes
	}
	local widget_definition = {
		element = element,
		content = content,
		style = style,
		scenegraph_id = parent_scenegraph_id,
		offset = {
			0,
			0,
			0
		}
	}
	local hotspot_pass = {
		style_id = "background_texture",
		pass_type = "hotspot",
		content_id = "button_hotspot"
	}
	passes[#passes + 1] = hotspot_pass
	content[hotspot_pass.content_id] = {}
	local reward_hotspot_pass = {
		style_id = "item_reward_frame_texture",
		pass_type = "hotspot",
		content_id = "reward_button_hotspot"
	}
	passes[#passes + 1] = reward_hotspot_pass
	content[reward_hotspot_pass.content_id] = {}
	local reward_tooltip_pass = {
		style_id = "tooltip_text",
		pass_type = "tooltip_text",
		text_id = "tooltip_text",
		content_check_function = function (content, style)
			return content.reward_button_hotspot.is_hover or (content.gamepad_preview and style.use_fixed_position)
		end
	}
	passes[#passes + 1] = reward_tooltip_pass
	content[reward_tooltip_pass.text_id] = "n/a"
	style[reward_tooltip_pass.style_id] = {
		font_type = "hell_shark",
		localize = false,
		font_size = 18,
		horizontal_alignment = "left",
		vertical_alignment = "top",
		max_width = 500,
		offset = {
			0,
			0,
			0
		},
		fixed_position = {
			80,
			40
		},
		use_fixed_position = use_fixed_position or false,
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {
			Colors.get_color_table_with_alpha("cheeseburger", 255),
			Colors.get_color_table_with_alpha("white", 255)
		}
	}
	local background_texture_pass = {
		pass_type = "texture",
		style_id = "background_texture",
		texture_id = "background_texture"
	}
	passes[#passes + 1] = background_texture_pass
	content[background_texture_pass.texture_id] = "board_contract_bg_quest"
	style[background_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			quest_size[1] / 2 - quest_size[1] / 2 + 1,
			-4,
			0
		},
		size = {
			quest_size[1],
			quest_size[2]
		}
	}
	local hover_edge_glow_pass = {
		pass_type = "texture",
		style_id = "edge_glow_hover",
		texture_id = "edge_glow",
		content_check_function = function (content)
			return not content.button_hotspot.is_selected and content.button_hotspot.is_hover
		end
	}
	passes[#passes + 1] = hover_edge_glow_pass
	content[hover_edge_glow_pass.texture_id] = "contract_glow_01"
	style[hover_edge_glow_pass.style_id] = {
		color = {
			150,
			255,
			255,
			255
		},
		offset = {
			quest_size[1] / 2 - 259.5 - 1,
			quest_size[2] / 2 - 59.5 - 1,
			5
		},
		size = {
			519,
			119
		}
	}
	local selected_edge_glow_pass = {
		pass_type = "texture",
		style_id = "edge_glow_selected",
		texture_id = "edge_glow",
		content_check_function = function (content)
			return content.button_hotspot.is_selected
		end
	}
	passes[#passes + 1] = selected_edge_glow_pass
	content[selected_edge_glow_pass.texture_id] = "contract_glow_01"
	style[selected_edge_glow_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			quest_size[1] / 2 - 259.5 - 1,
			quest_size[2] / 2 - 59.5 - 1,
			5
		},
		size = {
			519,
			119
		}
	}
	local item_reward_texture_pass = {
		texture_id = "item_reward_texture",
		style_id = "item_reward_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.has_item
		end
	}
	passes[#passes + 1] = item_reward_texture_pass
	content[item_reward_texture_pass.texture_id] = "icon_headpeice_dw_helmet_08"
	style[item_reward_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			70,
			quest_size[2] / 2 - 32,
			1
		},
		size = {
			64,
			64
		}
	}
	local item_reward_frame_texture_pass = {
		texture_id = "item_reward_frame_texture",
		style_id = "item_reward_frame_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.has_item
		end
	}
	passes[#passes + 1] = item_reward_frame_texture_pass
	content[item_reward_frame_texture_pass.texture_id] = "frame_01"
	style[item_reward_frame_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			70,
			quest_size[2] / 2 - 32,
			2
		},
		size = {
			64,
			64
		}
	}
	local quest_texture_pass = {
		texture_id = "quest_texture",
		style_id = "quest_texture",
		pass_type = "texture"
	}
	passes[#passes + 1] = quest_texture_pass
	content[quest_texture_pass.texture_id] = "quest_icon_01"
	style[quest_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			310,
			quest_size[2] / 2 - 37,
			2
		},
		size = {
			74,
			74
		}
	}
	local completed_texture_pass = {
		texture_id = "completed_texture",
		style_id = "completed_texture",
		pass_type = "texture",
		content_check_function = function (content)
			return content.completed
		end
	}
	passes[#passes + 1] = completed_texture_pass
	content[completed_texture_pass.texture_id] = "completed_icon"
	style[completed_texture_pass.style_id] = {
		color = {
			255,
			255,
			255,
			255
		},
		offset = {
			quest_size[1] / 2 - 83.60000000000001 - 15,
			quest_size[2] / 2 - 26.8,
			1
		},
		size = {
			167.20000000000002,
			53.6
		}
	}

	return widget_definition
end

local contract_lists_scenegraph_ids = {
	"contract_list_1",
	"contract_list_2",
	"contract_list_3",
	"contract_list_event"
}

return {
	contract_lists_scenegraph_ids = contract_lists_scenegraph_ids,
	create_board_contract_widget = create_board_contract_widget,
	create_log_contract_widget = create_log_contract_widget,
	create_quest_widget = create_quest_widget,
	scenegraph_definition = scenegraph_definition,
	widgets_definitions = widgets_definitions,
	animations = animations
}
