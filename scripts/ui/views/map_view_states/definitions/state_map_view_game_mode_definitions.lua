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
	frame_left = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			960,
			1080
		},
		position = {
			0,
			0,
			12
		}
	},
	frame_right = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			960,
			1080
		},
		position = {
			0,
			0,
			12
		}
	},
	fade_center_top = {
		vertical_alignment = "top",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			480,
			556
		},
		position = {
			0,
			0,
			17
		}
	},
	fade_center_bottom = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			480,
			556
		},
		position = {
			0,
			0,
			17
		}
	},
	edge_left = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			238,
			1080
		},
		position = {
			-119,
			0,
			13
		}
	},
	edge_right = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			238,
			1080
		},
		position = {
			119,
			0,
			13
		}
	}
}
local element_size = {
	960,
	800
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
}

local function create_element(index, scenegraph_id, color, game_mode_name, textures, locked, description_text)
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
					pass_type = "texture",
					style_id = "edge",
					texture_id = "edge"
				},
				{
					pass_type = "texture",
					style_id = "edge2",
					texture_id = "edge"
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
					pass_type = "texture",
					style_id = "locked_texture",
					texture_id = "locked_texture",
					content_check_function = function (content)
						return content.locked
					end
				},
				{
					style_id = "description_text",
					pass_type = "text",
					text_id = "description_text",
					content_check_function = function (content)
						return content.description_text
					end
				},
				{
					style_id = "progress_text",
					pass_type = "text",
					text_id = "progress_text",
					content_check_function = function (content)
						return not content.locked
					end
				}
			}
		},
		content = {
			glow_right_texture = "game_mode_selection_glow_01",
			locked_texture = "large_lock_icon_chain",
			edge = "game_mode_divider",
			glow_left_texture = "game_mode_selection_glow_02",
			levels_count_text = "",
			progress_text = "",
			locked = locked,
			background_texture = textures.selected,
			background_texture_selected = textures.selected,
			text = game_mode_name or "n/a",
			text_color = text_color,
			text_color_selected = text_color_selected,
			description_text = description_text
		},
		style = {
			edge = {
				size = {
					238,
					1080
				},
				offset = {
					(index == 1 and element_size[1] / 2 - 119) or -(element_size[1] / 2) - 119,
					-540,
					15
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			edge2 = {
				size = {
					238,
					1080
				},
				offset = {
					(index == 1 and -(element_size[1] / 2 + 119)) or element_size[1] / 2 - 119,
					-540,
					12
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			overlay = {
				saturated = true,
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
					-element_size[1] / 2,
					-element_size[2] / 2,
					3
				}
			},
			glow_left_texture = {
				size = {
					60,
					758
				},
				offset = {
					-element_size[1] / 2 + 20,
					-element_size[2] / 2,
					(index == 1 and 11) or 9
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			glow_right_texture = {
				size = {
					60,
					758
				},
				offset = {
					element_size[1] / 2 - 80,
					-element_size[2] / 2,
					(index == 1 and 9) or 11
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			locked_texture = {
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
					170,
					6
				}
			},
			description_rect = {
				color = {
					0,
					0,
					0,
					0
				},
				size = {
					element_size[1],
					200
				},
				offset = {
					-element_size[1] / 2,
					-element_size[2] / 2,
					4
				}
			},
			background_texture = {
				saturated = true,
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
					-element_size[1] / 2,
					-element_size[2] / 2,
					1
				}
			},
			background_texture_selected = {
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
					-element_size[1] / 2,
					-element_size[2] / 2,
					2
				}
			},
			text = {
				vertical_alignment = "top",
				font_type = "hell_shark_header",
				font_size = 82,
				horizontal_alignment = "center",
				text_color = text_color,
				offset = {
					0,
					480,
					13
				}
			},
			levels_count_text = {
				vertical_alignment = "bottom",
				font_type = "hell_shark",
				font_size = 24,
				horizontal_alignment = "center",
				text_color = {
					180,
					text_color[2],
					text_color[3],
					text_color[4]
				},
				offset = {
					0,
					-390,
					13
				}
			},
			progress_text = {
				vertical_alignment = "top",
				font_type = "hell_shark",
				font_size = 24,
				horizontal_alignment = "center",
				text_color = text_color,
				offset = {
					0,
					400,
					13
				}
			},
			description_text = {
				vertical_alignment = "top",
				word_wrap = true,
				horizontal_alignment = "center",
				font_size = 24,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 0),
				size = {
					700,
					200
				},
				offset = {
					-350,
					-element_size[2] / 2 - 35,
					15
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

local widgets = {
	overlay = UIWidgets.create_simple_rect("overlay", {
		200,
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
	title_text = UIWidgets.create_simple_text("console_map_screen_topic_gamemode", "title_text", 24, Colors.get_table("cheeseburger")),
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
	fade_center_top = UIWidgets.create_simple_texture("center_fade", "fade_center_top"),
	fade_center_bottom = UIWidgets.create_simple_uv_texture("center_fade", {
		{
			0,
			1
		},
		{
			1,
			0
		}
	}, "fade_center_bottom"),
	edge_left = UIWidgets.create_simple_texture("game_mode_divider", "edge_left"),
	edge_right = UIWidgets.create_simple_texture("game_mode_divider", "edge_right")
}
local game_mode_list = {
	"adventure",
	"survival"
}
local game_mode_display_names = {
	adventure = Localize("dlc1_2_map_game_mode_adventure"),
	survival = Localize("dlc1_2_map_game_mode_survival")
}
local textures_by_game_mode = {
	adventure = {
		selected = "game_mode_image_adventure_01",
		normal = "game_mode_image_adventure_02"
	},
	survival = {
		selected = "game_mode_image_last_stand_01",
		normal = "game_mode_image_last_stand_02"
	}
}
local condition_function_by_game_mode = {
	survival = function (params)
		if script_data.unlock_all_levels then
			return false
		end

		local map_view_helper = params.map_view_helper
		local unlocked = map_view_helper:is_survival_unlocked()

		if not unlocked then
			local required_level_display_name = LevelSettings.magnus.display_name
			local description_text = string.format(Localize("console_difficulty_dynamic_tooltip"), Localize(required_level_display_name))

			return true, description_text
		end
	end
}
local game_mode_index_by_name = {}

for i = 1, #game_mode_list, 1 do
	game_mode_index_by_name[game_mode_list[i]] = i
end

return {
	widgets = widgets,
	element_size = element_size,
	create_element = create_element,
	game_mode_list = game_mode_list,
	generic_input_actions = generic_input_actions,
	textures_by_game_mode = textures_by_game_mode,
	scenegraph_definition = scenegraph_definition,
	game_mode_index_by_name = game_mode_index_by_name,
	game_mode_display_names = game_mode_display_names,
	condition_function_by_game_mode = condition_function_by_game_mode
}
