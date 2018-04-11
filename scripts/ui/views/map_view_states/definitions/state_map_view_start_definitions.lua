local element_size = {
	565,
	318
}
local spacing = 50
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
			1
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
			-(573 + spacing) * 0.5 * 2,
			325,
			4
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
	difficulty_lock_icons = {
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
	difficulty_text_bg = {
		vertical_alignment = "center",
		parent = "element_pivot",
		horizontal_alignment = "center",
		size = {
			564,
			58
		},
		position = {
			-(spacing * 0.5 + element_size[1] * 0.5 * 2) - 20,
			-300,
			10
		}
	},
	difficulty_text = {
		vertical_alignment = "center",
		parent = "difficulty_text_bg",
		horizontal_alignment = "center",
		size = {
			500,
			50
		},
		position = {
			20,
			3,
			1
		}
	},
	difficulty_arrow_up = {
		vertical_alignment = "center",
		parent = "difficulty_text",
		horizontal_alignment = "center",
		size = {
			28,
			34
		},
		position = {
			0,
			40,
			2
		}
	},
	difficulty_arrow_down = {
		vertical_alignment = "center",
		parent = "difficulty_text",
		horizontal_alignment = "center",
		size = {
			28,
			34
		},
		position = {
			1,
			-44,
			2
		}
	}
}
local generic_input_actions = {
	default = {
		{
			input_action = "confirm",
			priority = 2,
			description_text = "input_description_select"
		},
		{
			input_action = "back",
			priority = 4,
			description_text = "input_description_close"
		}
	},
	quick_play = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "map_screen_increase_decrease_difficulty",
			ignore_keybinding = true
		},
		{
			input_action = "confirm",
			priority = 2,
			description_text = "input_description_select"
		},
		{
			input_action = "back",
			priority = 4,
			description_text = "input_description_close"
		}
	}
}

if PLATFORM == "ps4" and GameSettingsDevelopment.lobby_browser_enabled then
	generic_input_actions.default[#generic_input_actions.default + 1] = {
		input_action = "refresh",
		priority = 3,
		description_text = "lobby_browser_button_name"
	}
	generic_input_actions.quick_play[#generic_input_actions.quick_play + 1] = {
		input_action = "refresh",
		priority = 3,
		description_text = "lobby_browser_button_name"
	}
end

local MASKED = true

local function create_element(scenegraph_id, title, textures, description_text)
	local text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	local text_color_selected = Colors.get_color_table_with_alpha("white", 255)

	return {
		element = {
			passes = {
				{
					pass_type = "rect",
					style_id = "overlay",
					texture_id = "overlay"
				},
				{
					pass_type = "texture",
					style_id = "frame_texture",
					texture_id = "frame_texture"
				},
				{
					pass_type = "texture",
					style_id = "background_texture",
					texture_id = "background_texture"
				},
				{
					pass_type = "texture",
					style_id = "background_texture_selected",
					texture_id = "background_texture_selected"
				},
				{
					pass_type = "texture",
					style_id = "glow_left_texture",
					texture_id = "glow_left_texture"
				},
				{
					pass_type = "texture",
					style_id = "glow_right_texture",
					texture_id = "glow_right_texture"
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					style_id = "description_rect",
					pass_type = "rect",
					content_check_function = function (content)
						return content.description_text and content.description_text ~= ""
					end
				},
				{
					style_id = "description_rect",
					pass_type = "rect",
					content_check_function = function (content)
						return content.description_text and content.description_text ~= ""
					end
				},
				{
					style_id = "description_text",
					pass_type = "text",
					text_id = "description_text",
					content_check_function = function (content)
						return content.description_text
					end
				}
			}
		},
		content = {
			glow_right_texture = "game_mode_selection_glow_02_masked",
			glow_left_texture = "game_mode_selection_glow_01_masked",
			frame_texture = "console_level_frame_01",
			background_texture = textures.selected,
			background_texture_selected = textures.selected,
			text = title or "n/a",
			text_color = text_color,
			text_color_selected = text_color_selected,
			description_text = description_text
		},
		style = {
			frame_texture = {
				masked = MASKED,
				size = {
					element_size[1] + 16,
					element_size[2] + 16
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-element_size[1] * 0.5 - 8,
					-element_size[2] * 0.5 - 8,
					5
				}
			},
			overlay = {
				saturated = true,
				masked = MASKED,
				size = {
					element_size[1],
					element_size[2]
				},
				color = {
					255,
					0,
					0,
					0
				},
				offset = {
					-element_size[1] * 0.5,
					-element_size[2] * 0.5,
					3
				}
			},
			glow_left_texture = {
				masked = MASKED,
				size = {
					60,
					element_size[2]
				},
				offset = {
					-element_size[1] * 0.5 - 60,
					-element_size[2] * 0.5,
					3
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			glow_right_texture = {
				masked = MASKED,
				size = {
					60,
					element_size[2]
				},
				offset = {
					element_size[1] * 0.5,
					-element_size[2] * 0.5,
					3
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			description_rect = {
				masked = MASKED,
				color = Colors.get_table("black"),
				size = {
					element_size[1],
					element_size[2] * 0.33
				},
				offset = {
					-element_size[1] * 0.5,
					-element_size[2] * 0.5,
					4
				}
			},
			background_texture = {
				saturated = true,
				masked = MASKED,
				size = {
					element_size[1],
					element_size[2]
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-element_size[1] * 0.5,
					-element_size[2] * 0.5,
					1
				}
			},
			background_texture_selected = {
				masked = MASKED,
				size = {
					element_size[1],
					element_size[2]
				},
				color = {
					0,
					255,
					255,
					255
				},
				offset = {
					-element_size[1] * 0.5,
					-element_size[2] * 0.5,
					2
				}
			},
			text = {
				vertical_alignment = "center",
				word_wrap = true,
				font_size = 82,
				horizontal_alignment = "center",
				font_type = (MASKED and "hell_shark_header_masked") or "hell_shark_header",
				text_color = text_color,
				size = {
					element_size[1] - 10,
					element_size[2] - 10
				},
				offset = {
					0,
					0,
					13
				},
				offset = {
					-element_size[1] * 0.5 + 5,
					-element_size[2] * 0.5 + 5,
					5
				}
			},
			description_text = {
				vertical_alignment = "bottom",
				word_wrap = true,
				font_size = 24,
				horizontal_alignment = "center",
				font_type = (MASKED and "hell_shark_masked") or "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 0),
				size = {
					element_size[1] - 30,
					-element_size[2]
				},
				offset = {
					-(element_size[1] * 0.5 - 15),
					-element_size[2] * 0.5 + 12,
					5
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

local difficulty_textures = {
	"console_difficulty_icon_01",
	"console_difficulty_icon_01",
	"console_difficulty_icon_01",
	"console_difficulty_icon_01",
	"console_difficulty_icon_01"
}
local difficulty_lock_textures = {
	"console_difficulty_icon_03",
	"console_difficulty_icon_03",
	"console_difficulty_icon_03",
	"console_difficulty_icon_03",
	"console_difficulty_icon_03"
}
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
	dead_space_filler = UIWidgets.create_simple_rect("dead_space_filler", {
		255,
		0,
		0,
		0
	}),
	title_text = UIWidgets.create_simple_text("console_map_screen_topic_matchmaking_mode", "title_text", 24, Colors.get_table("cheeseburger")),
	background = UIWidgets.create_simple_texture("difficulty_bg", "frame"),
	difficulty_text_bg = UIWidgets.create_simple_texture("difficulty_frame", "difficulty_text_bg", MASKED),
	difficulty_text = UIWidgets.create_simple_text("console_map_screen_topic_matchmaking_mode", "difficulty_text", 24, Colors.get_table("white"), nil, (MASKED and "hell_shark_masked") or "hell_shark"),
	difficulty_slots = UIWidgets.create_simple_centered_texture_amount("console_difficulty_icon_bg", {
		40,
		60
	}, "difficulty_slots", DifficultySettings[DefaultStartingDifficulty].rank, MASKED),
	difficulty_bg = UIWidgets.create_simple_texture("hud_difficulty_unlocked_bg_bottom", "difficulty_bg", MASKED),
	difficulty_arrow_up = UIWidgets.create_simple_rotated_texture("settings_arrow_clicked", math.degrees_to_radians(90), {
		14,
		17
	}, "difficulty_arrow_up", MASKED),
	difficulty_arrow_down = UIWidgets.create_simple_rotated_texture("settings_arrow_clicked", math.degrees_to_radians(-90), {
		14,
		17
	}, "difficulty_arrow_down", MASKED),
	difficulty_icons = {
		scenegraph_id = "difficulty_icons",
		element = {
			passes = {
				{
					texture_id = "texture_id",
					style_id = "texture_id",
					pass_type = "multi_texture"
				}
			}
		},
		content = {
			texture_id = difficulty_textures
		},
		style = {
			texture_id = {
				direction = 1,
				axis = 1,
				draw_count = 1,
				masked = MASKED,
				spacing = {
					35,
					0
				},
				texture_size = {
					40,
					60
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					55,
					0,
					0
				}
			}
		}
	},
	difficulty_lock_icons = {
		scenegraph_id = "difficulty_lock_icons",
		element = {
			passes = {
				{
					texture_id = "texture_id",
					style_id = "texture_id",
					pass_type = "multi_texture"
				}
			}
		},
		content = {
			texture_id = difficulty_lock_textures
		},
		style = {
			texture_id = {
				direction = 2,
				axis = 1,
				draw_count = 1,
				masked = MASKED,
				spacing = {
					35,
					0
				},
				texture_size = {
					40,
					60
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					245,
					0,
					0
				}
			}
		}
	}
}
local options = {
	{
		name = "quick_play",
		display_name = Localize("map_screen_quickplay_button"),
		description_text = Localize("map_screen_quickmatch_description"),
		textures = {
			selected = "quickplay_image_01",
			normal = "quickplay_image_01"
		}
	},
	{
		name = "custom",
		display_name = Localize("map_screen_custom"),
		description_text = Localize("map_screen_custom_description"),
		textures = {
			selected = "quickplay_image_02",
			normal = "quickplay_image_02"
		}
	},
	{
		description_text = "",
		name = "additional_content",
		display_name = Localize("console_dlc_view_title"),
		textures = {
			selected = "additionalcontent_image_02",
			normal = "additionalcontent_image_02"
		}
	}
}

return {
	widgets = widgets,
	options = options,
	element_size = element_size,
	create_element = create_element,
	generic_input_actions = generic_input_actions,
	scenegraph_definition = scenegraph_definition
}
