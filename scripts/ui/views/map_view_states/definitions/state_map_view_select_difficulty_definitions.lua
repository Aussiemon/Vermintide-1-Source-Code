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
			1
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
	selection_text = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			1920,
			50
		},
		position = {
			0,
			160,
			30
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
			10
		}
	},
	start_game_detail = {
		vertical_alignment = "center",
		parent = "selection_text",
		horizontal_alignment = "center",
		size = {
			260,
			60
		},
		position = {
			0,
			-55,
			-3
		}
	},
	start_game_detail_glow = {
		vertical_alignment = "bottom",
		parent = "start_game_detail",
		horizontal_alignment = "center",
		size = {
			290,
			212
		},
		position = {
			0,
			42,
			-1
		}
	},
	smoke_bottom_left = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			650,
			450
		},
		position = {
			0,
			0,
			7
		}
	},
	smoke_bottom_right = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			650,
			450
		},
		position = {
			0,
			0,
			7
		}
	},
	smoke_center_left = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			310,
			450
		},
		position = {
			650,
			0,
			7
		}
	},
	smoke_center_right = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			310,
			450
		},
		position = {
			-650,
			0,
			7
		}
	},
	smoke_center = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			600,
			1080
		},
		position = {
			0,
			0,
			8
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
	mask_layer = {
		vertical_alignment = "top",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			1920,
			700
		},
		position = {
			0,
			0,
			20
		}
	},
	mask_layer_edge = {
		vertical_alignment = "bottom",
		parent = "mask_layer",
		horizontal_alignment = "center",
		size = {
			1920,
			300
		},
		position = {
			0,
			-300,
			1
		}
	}
}
local element_size = {
	365,
	400
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

local function create_element(scenegraph_id, color, index, difficulty_data, gui)
	local unlocked = difficulty_data.unlocked
	local completed = difficulty_data.completed
	local key = difficulty_data.key
	local locked_text = difficulty_data.console_tooltip or ""
	local difficulty_settings = DifficultySettings[key]
	local map_screen_textures = difficulty_settings.map_screen_textures
	local banner_texture = map_screen_textures.banner
	local gui_material = Gui.material(gui, banner_texture)

	Material.set_scalar(gui_material, "distortion_offset_top", 0)
	Material.set_scalar(gui_material, "desaturation", 0)

	return {
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "banner_texture",
					texture_id = "banner_texture"
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
					style_id = "locked_text",
					pass_type = "rect_text",
					text_id = "locked_text",
					content_check_function = function (content, style)
						return content.locked and style.text_color[1] > 0
					end
				}
			}
		},
		content = {
			draw_locked_text = false,
			internal_progress = 0,
			locked_texture = "large_lock_icon_chain",
			locked_text = locked_text,
			locked = not unlocked,
			rank = difficulty_data.rank,
			banner_texture = banner_texture .. "_masked"
		},
		style = {
			rect = {
				size = {
					400,
					400
				},
				color = color or {
					0,
					255,
					255,
					255
				},
				offset = {
					-200,
					-200,
					0
				}
			},
			banner_texture = {
				masked = true,
				size = {
					340,
					850
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-170,
					-425,
					1
				}
			},
			locked_texture = {
				masked = true,
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
					-50,
					5
				}
			},
			locked_text = {
				font_size = 20,
				localize = false,
				font_type = "hell_shark_masked",
				horizontal_alignment = "center",
				vertical_alignment = "center",
				masked = true,
				max_width = 300,
				text_color = Colors.get_color_table_with_alpha("red", 0),
				rect_color = Colors.get_color_table_with_alpha("black", 0),
				line_colors = {},
				offset = {
					0,
					0,
					7
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
		200,
		200,
		0
	}),
	dead_space_filler = UIWidgets.create_simple_rect("dead_space_filler", {
		255,
		0,
		0,
		0
	}),
	title_text = UIWidgets.create_simple_text("console_map_screen_topic_difficulty", "title_text", 24, Colors.get_table("cheeseburger")),
	selection_text = UIWidgets.create_simple_text("n/a", "selection_text", 36, Colors.get_table("white")),
	background = UIWidgets.create_simple_texture("difficulty_bg", "frame"),
	start_game_detail = UIWidgets.create_simple_texture("start_game_detail", "start_game_detail"),
	start_game_detail_glow = UIWidgets.create_simple_texture("start_game_detail_glow", "start_game_detail_glow"),
	smoke_bottom_left = UIWidgets.create_simple_texture("smoke_effect_left", "smoke_bottom_left"),
	smoke_bottom_right = UIWidgets.create_simple_uv_texture("smoke_effect_right", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "smoke_bottom_right"),
	smoke_center_left = UIWidgets.create_simple_texture("smoke_effect_center_left", "smoke_center_left"),
	smoke_center_right = UIWidgets.create_simple_uv_texture("smoke_effect_center_right", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "smoke_center_right"),
	smoke_center = UIWidgets.create_simple_texture("smoke_effect_03", "smoke_center"),
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
	mask_layer = UIWidgets.create_simple_texture("mask_rect", "mask_layer"),
	mask_layer_edge = UIWidgets.create_simple_uv_texture("mask_rect_edge_fade", {
		{
			0,
			1
		},
		{
			1,
			0
		}
	}, "mask_layer_edge")
}

return {
	widgets = widgets,
	element_size = element_size,
	create_element = create_element,
	scenegraph_definition = scenegraph_definition,
	generic_input_actions = generic_input_actions
}
