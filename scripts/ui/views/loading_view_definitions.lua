local_require("scripts/ui/ui_widgets")

local MAXIMUM_TIP_WIDTH = 1400
local ICON_SIZE = {
	26,
	26
}
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			1
		},
		size = {
			1920,
			1080
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
		position = {
			0,
			0,
			0
		},
		size = {
			1920,
			1080
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
	background_image = {
		vertical_alignment = "center",
		parent = "menu_root",
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
	subtitle_root = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			600,
			256
		},
		position = {
			0,
			300,
			2
		}
	},
	tip_title = {
		vertical_alignment = "bottom",
		parent = "background_image",
		horizontal_alignment = "center",
		size = {
			260,
			35
		},
		position = {
			0,
			120,
			2
		}
	},
	tip_text_prefix = {
		vertical_alignment = "bottom",
		parent = "background_image",
		horizontal_alignment = "center",
		size = {
			MAXIMUM_TIP_WIDTH,
			85
		},
		position = {
			0,
			35,
			2
		}
	},
	gamepad_input_icon = {
		vertical_alignment = "bottom",
		parent = "background_image",
		horizontal_alignment = "center",
		size = ICON_SIZE,
		position = {
			0,
			65,
			3
		}
	},
	tip_text_suffix = {
		vertical_alignment = "bottom",
		parent = "background_image",
		horizontal_alignment = "center",
		size = {
			MAXIMUM_TIP_WIDTH,
			85
		},
		position = {
			0,
			35,
			2
		}
	},
	second_row_tip_text_prefix = {
		vertical_alignment = "bottom",
		parent = "background_image",
		horizontal_alignment = "center",
		size = {
			MAXIMUM_TIP_WIDTH,
			85
		},
		position = {
			0,
			6,
			2
		}
	},
	second_row_gamepad_input_icon = {
		vertical_alignment = "bottom",
		parent = "background_image",
		horizontal_alignment = "center",
		size = ICON_SIZE,
		position = {
			0,
			36,
			3
		}
	},
	second_row_tip_text_suffix = {
		vertical_alignment = "bottom",
		parent = "background_image",
		horizontal_alignment = "center",
		size = {
			MAXIMUM_TIP_WIDTH,
			85
		},
		position = {
			0,
			6,
			2
		}
	},
	news_ticker_text = {
		vertical_alignment = "top",
		parent = "background_image",
		horizontal_alignment = "center",
		size = {
			1254,
			20
		},
		position = {
			1300,
			-33,
			2
		}
	},
	news_ticker_mask = {
		vertical_alignment = "top",
		parent = "background_image",
		horizontal_alignment = "center",
		size = {
			1254,
			40
		},
		position = {
			6,
			-23,
			3
		}
	},
	act_name = {
		vertical_alignment = "top",
		parent = "background_image",
		horizontal_alignment = "left",
		size = {
			320,
			60
		},
		position = {
			280,
			-71,
			4
		}
	},
	act_name_bg = {
		vertical_alignment = "center",
		parent = "act_name",
		horizontal_alignment = "center",
		size = {
			520,
			60
		},
		position = {
			0,
			0,
			-1
		}
	},
	level_name = {
		vertical_alignment = "top",
		parent = "background_image",
		horizontal_alignment = "center",
		size = {
			520,
			60
		},
		position = {
			0,
			-71,
			4
		}
	},
	level_name_bg = {
		vertical_alignment = "center",
		parent = "level_name",
		horizontal_alignment = "center",
		size = {
			320,
			60
		},
		position = {
			0,
			0,
			-1
		}
	},
	game_difficulty = {
		vertical_alignment = "top",
		parent = "background_image",
		horizontal_alignment = "right",
		size = {
			320,
			60
		},
		position = {
			-280,
			-71,
			4
		}
	},
	game_difficulty_bg = {
		vertical_alignment = "center",
		parent = "game_difficulty",
		horizontal_alignment = "center",
		size = {
			320,
			60
		},
		position = {
			0,
			0,
			-1
		}
	}
}
local NUM_SUBTITLE_ROWS = 5

for i = 1, NUM_SUBTITLE_ROWS, 1 do
	local scenegraph_id = "subtitle_row_" .. tostring(i)
	scenegraph_definition[scenegraph_id] = {
		vertical_alignment = "bottom",
		parent = "subtitle_root",
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
	}
end

local dead_space_filler = {
	scenegraph_id = "dead_space_filler",
	element = {
		passes = {
			{
				pass_type = "rect"
			}
		}
	},
	content = {},
	style = {
		color = {
			255,
			0,
			0,
			0
		}
	}
}
local background_image = {
	scenegraph_id = "background_image",
	element = {
		passes = {
			{
				pass_type = "rect",
				style_id = "bg_rect"
			},
			{
				pass_type = "texture",
				style_id = "bg_texture",
				texture_id = "bg_texture"
			}
		}
	},
	content = {
		bg_texture = "to_be_set"
	},
	style = {
		bg_rect = {
			scenegraph_id = "root",
			color = {
				255,
				0,
				0,
				0
			},
			offset = {
				0,
				0,
				-1
			}
		}
	}
}
local subtitle = {
	scenegraph_id = "subtitle",
	element = {
		passes = {
			{
				style_id = "text",
				pass_type = "text",
				text_id = "text"
			}
		}
	},
	content = {
		text = ""
	},
	style = {
		text = {
			vertical_alignment = "center",
			font_type = "hell_shark",
			word_wrap = true,
			font_size = 24,
			horizontal_alignment = "center",
			text_color = table.clone(Colors.color_definitions.white)
		}
	}
}
local subtitle_row_widgets = {}

for i = 1, NUM_SUBTITLE_ROWS, 1 do
	local scenegraph_id = "subtitle_row_" .. tostring(i)
	local start_offset_y = -(i - 1) * 50
	local subtitle_row_widget = {
		element = {
			passes = {
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				}
			}
		},
		content = {
			text = ""
		},
		style = {
			text = {
				vertical_alignment = "center",
				font_type = "hell_shark",
				word_wrap = false,
				font_size = 36,
				horizontal_alignment = "center",
				text_color = table.clone(Colors.color_definitions.white),
				start_offset_y = start_offset_y,
				offset = {
					0,
					start_offset_y,
					0
				}
			}
		},
		scenegraph_id = scenegraph_id
	}
	subtitle_row_widgets[i] = subtitle_row_widget
end

local definitions = {
	scenegraph_definition = scenegraph_definition,
	dead_space_filler = dead_space_filler,
	background_image = background_image,
	logo_image = logo_image,
	subtitle = subtitle,
	subtitle_row_widgets = subtitle_row_widgets,
	NUM_SUBTITLE_ROWS = NUM_SUBTITLE_ROWS,
	act_name_widget = UIWidgets.create_simple_text("", "act_name", nil, nil, {
		vertical_alignment = "center",
		font_type = "hell_shark_header",
		font_size = 36,
		horizontal_alignment = "center",
		text_color = Colors.get_color_table_with_alpha("loading_screen_stone", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	act_name_bg_widget = UIWidgets.create_simple_text("", "act_name_bg", nil, nil, {
		vertical_alignment = "center",
		font_type = "hell_shark_header",
		font_size = 36,
		horizontal_alignment = "center",
		text_color = Colors.get_color_table_with_alpha("silver", 127),
		offset = {
			1,
			-1,
			-1
		}
	}),
	level_name_widget = UIWidgets.create_simple_text("", "level_name", nil, nil, {
		vertical_alignment = "center",
		font_type = "hell_shark_header",
		font_size = 44,
		horizontal_alignment = "center",
		text_color = Colors.get_color_table_with_alpha("loading_screen_stone", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	level_name_bg_widget = UIWidgets.create_simple_text("", "level_name_bg", nil, nil, {
		vertical_alignment = "center",
		font_type = "hell_shark_header",
		font_size = 44,
		horizontal_alignment = "center",
		text_color = Colors.get_color_table_with_alpha("silver", 127),
		offset = {
			1,
			-1,
			-1
		}
	}),
	game_difficulty_widget = UIWidgets.create_simple_text("", "game_difficulty", nil, nil, {
		vertical_alignment = "center",
		font_type = "hell_shark_header",
		font_size = 36,
		horizontal_alignment = "center",
		text_color = Colors.get_color_table_with_alpha("loading_screen_stone", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	game_difficulty_bg_widget = UIWidgets.create_simple_text("", "game_difficulty_bg", nil, nil, {
		vertical_alignment = "center",
		font_type = "hell_shark_header",
		font_size = 36,
		horizontal_alignment = "center",
		text_color = Colors.get_color_table_with_alpha("silver", 127),
		offset = {
			1,
			-1,
			-1
		}
	}),
	tip_title_widget = UIWidgets.create_simple_text("loading_screen_tip_title", "tip_title", 32, Colors.get_color_table_with_alpha("cheeseburger", 255)),
	tip_text_prefix_widget = UIWidgets.create_simple_text("", "tip_text_prefix", nil, nil, {
		vertical_alignment = "center",
		word_wrap = false,
		horizontal_alignment = "right",
		font_size = 22,
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	gamepad_input_icon = {
		scenegraph_id = "gamepad_input_icon",
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
		content = {},
		style = {
			texture_id = {
				offset = {
					0,
					0,
					1
				}
			}
		}
	},
	tip_text_suffix_widget = UIWidgets.create_simple_text("", "tip_text_suffix", nil, nil, {
		vertical_alignment = "center",
		word_wrap = false,
		horizontal_alignment = "left",
		font_size = 22,
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	second_row_tip_text_prefix_widget = UIWidgets.create_simple_text("", "second_row_tip_text_prefix", nil, nil, {
		vertical_alignment = "center",
		word_wrap = false,
		horizontal_alignment = "right",
		font_size = 22,
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	second_row_gamepad_input_icon = {
		scenegraph_id = "second_row_gamepad_input_icon",
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
		content = {},
		style = {
			texture_id = {
				offset = {
					0,
					0,
					1
				}
			}
		}
	},
	second_row_tip_text_suffix_widget = UIWidgets.create_simple_text("", "second_row_tip_text_suffix", nil, nil, {
		vertical_alignment = "center",
		word_wrap = false,
		horizontal_alignment = "left",
		font_size = 22,
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	news_ticker_text_widget = UIWidgets.create_simple_text("", "news_ticker_text", nil, nil, {
		vertical_alignment = "center",
		font_type = "hell_shark_masked",
		font_size = 24,
		horizontal_alignment = "left",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	news_ticker_mask_widget = UIWidgets.create_simple_texture("mask_rect", "news_ticker_mask"),
	MAXIMUM_TIP_WIDTH = MAXIMUM_TIP_WIDTH,
	ICON_SIZE = ICON_SIZE
}

return definitions
