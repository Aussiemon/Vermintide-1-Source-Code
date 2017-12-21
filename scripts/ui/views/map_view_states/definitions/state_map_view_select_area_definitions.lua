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
			11
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
			10
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
			10
		}
	},
	frame_center = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			238,
			1080
		},
		position = {
			0,
			0,
			9
		}
	}
}
local element_size = {
	463,
	802
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
			description_text = "input_description_close"
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
			description_text = "input_description_close"
		}
	},
	locked = {
		{
			input_action = "back",
			priority = 3,
			description_text = "input_description_close"
		}
	}
}

local function create_element(scenegraph_id, color, game_mode_name, textures, locked, dlc_name, description_text)
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
					style_id = "text",
					pass_type = "text",
					text_id = "text"
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
					style_id = "progress_text",
					pass_type = "text",
					text_id = "progress_text",
					content_check_function = function (content)
						return not content.locked
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
			locked_texture = "large_lock_icon_chain",
			glow_right_texture = "game_mode_selection_glow_01",
			levels_count_text = "",
			glow_left_texture = "game_mode_selection_glow_02",
			dlc_texture = "large_lock_icon_dlc",
			progress_text = "",
			dlc_name = dlc_name,
			locked = locked,
			background_texture = textures.selected,
			background_texture_selected = textures.selected,
			text = game_mode_name or "n/a",
			text_color = text_color,
			text_color_selected = text_color_selected,
			description_text = description_text
		},
		style = {
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
			dlc_texture = {
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
					108,
					5
				}
			},
			glow_left_texture = {
				size = {
					60,
					758
				},
				offset = {
					-element_size[1]/2 + 20,
					-element_size[2]/2,
					5
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
					element_size[1]/2 - 80,
					-element_size[2]/2,
					5
				},
				color = {
					0,
					255,
					255,
					255
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
					400
				},
				offset = {
					-element_size[1]/2,
					-540,
					4
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
					-element_size[1]/2,
					-element_size[2]/2,
					3
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
					-element_size[1]/2,
					-element_size[2]/2,
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
					-element_size[1]/2,
					-element_size[2]/2,
					3
				}
			},
			text = {
				vertical_alignment = "top",
				font_type = "hell_shark_header",
				font_size = 52,
				horizontal_alignment = "center",
				text_color = text_color,
				offset = {
					0,
					440,
					13
				}
			},
			levels_count_text = {
				vertical_alignment = "top",
				font_type = "hell_shark",
				font_size = 24,
				horizontal_alignment = "center",
				text_color = text_color,
				offset = {
					0,
					360,
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
					390,
					13
				}
			},
			description_text = {
				vertical_alignment = "top",
				font_size = 24,
				horizontal_alignment = "center",
				word_wrap = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("red", 0),
				size = {
					element_size[1],
					200
				},
				offset = {
					-element_size[1]/2,
					-element_size[2]/2 + 50,
					10
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
	title_text = UIWidgets.create_simple_text("console_map_screen_topic_area", "title_text", 24, Colors.get_table("cheeseburger")),
	background = UIWidgets.create_simple_texture("large_frame_01", "frame"),
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
	frame_center = UIWidgets.create_simple_texture("game_mode_divider", "frame_center")
}
local textures_by_area = {
	ubersreik = {
		selected = "area_image_ubersreik_01",
		normal = "area_image_ubersreik_02"
	},
	drachenfels = {
		selected = "area_image_drachenfels_01",
		normal = "area_image_drachenfels_02"
	}
}

return {
	widgets = widgets,
	element_size = element_size,
	create_element = create_element,
	textures_by_area = textures_by_area,
	scenegraph_definition = scenegraph_definition,
	generic_input_actions = generic_input_actions
}
