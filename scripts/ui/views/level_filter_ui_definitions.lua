local element_size = {
	112,
	62
}
local element_spacing = {
	5,
	0
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
	background = {
		vertical_alignment = "top",
		parent = "root",
		horizontal_alignment = "left",
		size = {
			500,
			1080
		},
		position = {
			-500,
			0,
			34
		}
	},
	background_texture = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			463,
			802
		},
		position = {
			15,
			0,
			-1
		}
	},
	background_texture2 = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			463,
			802
		},
		position = {
			15,
			0,
			0
		}
	},
	element_pivot = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			7,
			0,
			7
		}
	},
	bg_rect = {
		vertical_alignment = "top",
		parent = "element_pivot",
		horizontal_alignment = "left",
		size = {
			500,
			0
		},
		position = {
			-7,
			35,
			-6
		}
	},
	rect_frame_top = {
		vertical_alignment = "top",
		parent = "bg_rect",
		horizontal_alignment = "center",
		size = {
			500,
			107
		},
		position = {
			0,
			102,
			1
		}
	},
	rect_frame_bottom = {
		vertical_alignment = "bottom",
		parent = "bg_rect",
		horizontal_alignment = "center",
		size = {
			500,
			71
		},
		position = {
			0,
			-65,
			1
		}
	},
	info_box = {
		vertical_alignment = "top",
		parent = "rect_frame_bottom",
		horizontal_alignment = "center",
		size = {
			387,
			144
		},
		position = {
			0,
			-4,
			1
		}
	},
	info_box_text = {
		vertical_alignment = "bottom",
		parent = "info_box",
		horizontal_alignment = "center",
		size = {
			365,
			95
		},
		position = {
			2,
			9,
			1
		}
	},
	edge = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "right",
		size = {
			238,
			1080
		},
		position = {
			119,
			0,
			8
		}
	},
	title_text = {
		vertical_alignment = "bottom",
		parent = "rect_frame_top",
		horizontal_alignment = "center",
		size = {
			400,
			50
		},
		position = {
			0,
			12,
			4
		}
	},
	edge_button_bg = {
		vertical_alignment = "center",
		parent = "edge",
		horizontal_alignment = "right",
		size = {
			65,
			57
		},
		position = {
			-44,
			0,
			4
		}
	},
	edge_button_mg = {
		vertical_alignment = "center",
		parent = "edge_button_bg",
		horizontal_alignment = "center",
		size = {
			65,
			57
		},
		position = {
			0,
			0,
			1
		}
	},
	edge_button_fg = {
		vertical_alignment = "center",
		parent = "edge_button_bg",
		horizontal_alignment = "center",
		size = {
			65,
			57
		},
		position = {
			0,
			0,
			2
		}
	},
	edge_button_glow = {
		vertical_alignment = "center",
		parent = "edge_button_fg",
		horizontal_alignment = "center",
		size = {
			79,
			79
		},
		position = {
			7,
			5,
			1
		}
	}
}

local function create_element(scenegraph_id)
	return {
		element = {
			passes = {
				{
					style_id = "title",
					pass_type = "text",
					text_id = "title"
				},
				{
					pass_type = "texture",
					style_id = "slot_1",
					texture_id = "slot_1",
					content_check_function = function (content)
						return content.slot_1
					end
				},
				{
					pass_type = "texture",
					style_id = "slot_2",
					texture_id = "slot_2",
					content_check_function = function (content)
						return content.slot_2
					end
				},
				{
					pass_type = "texture",
					style_id = "slot_3",
					texture_id = "slot_3",
					content_check_function = function (content)
						return content.slot_3
					end
				},
				{
					pass_type = "texture",
					style_id = "slot_4",
					texture_id = "slot_4",
					content_check_function = function (content)
						return content.slot_4
					end
				},
				{
					style_id = "slot_fade_1",
					pass_type = "rect",
					content_check_function = function (content)
						return content.slot_1 and content.slot_selected ~= content.slot_1
					end
				},
				{
					style_id = "slot_fade_2",
					pass_type = "rect",
					content_check_function = function (content)
						return content.slot_2 and content.slot_selected ~= content.slot_2
					end
				},
				{
					style_id = "slot_fade_3",
					pass_type = "rect",
					content_check_function = function (content)
						return content.slot_3 and content.slot_selected ~= content.slot_3
					end
				},
				{
					style_id = "slot_fade_4",
					pass_type = "rect",
					content_check_function = function (content)
						return content.slot_4 and content.slot_selected ~= content.slot_4
					end
				},
				{
					pass_type = "texture",
					style_id = "border_1",
					texture_id = "border_texture",
					content_check_function = function (content)
						return content.slot_1
					end
				},
				{
					pass_type = "texture",
					style_id = "border_2",
					texture_id = "border_texture",
					content_check_function = function (content)
						return content.slot_2
					end
				},
				{
					pass_type = "texture",
					style_id = "border_3",
					texture_id = "border_texture",
					content_check_function = function (content)
						return content.slot_3
					end
				},
				{
					pass_type = "texture",
					style_id = "border_4",
					texture_id = "border_texture",
					content_check_function = function (content)
						return content.slot_4
					end
				},
				{
					pass_type = "texture",
					style_id = "selection_1",
					texture_id = "selection_texture",
					content_check_function = function (content)
						return content.slot_1 and content.slot_1 == content.slot_selected
					end
				},
				{
					pass_type = "texture",
					style_id = "selection_2",
					texture_id = "selection_texture",
					content_check_function = function (content)
						return content.slot_2 and content.slot_2 == content.slot_selected
					end
				},
				{
					pass_type = "texture",
					style_id = "selection_3",
					texture_id = "selection_texture",
					content_check_function = function (content)
						return content.slot_3 and content.slot_3 == content.slot_selected
					end
				},
				{
					pass_type = "texture",
					style_id = "selection_4",
					texture_id = "selection_texture",
					content_check_function = function (content)
						return content.slot_4 and content.slot_4 == content.slot_selected
					end
				},
				{
					pass_type = "texture",
					style_id = "marker_1",
					texture_id = "marker",
					content_check_function = function (content)
						return content.slot_1 and content.markers[1]
					end
				},
				{
					pass_type = "texture",
					style_id = "marker_2",
					texture_id = "marker",
					content_check_function = function (content)
						return content.slot_2 and content.markers[2]
					end
				},
				{
					pass_type = "texture",
					style_id = "marker_3",
					texture_id = "marker",
					content_check_function = function (content)
						return content.slot_3 and content.markers[3]
					end
				},
				{
					pass_type = "texture",
					style_id = "marker_4",
					texture_id = "marker",
					content_check_function = function (content)
						return content.slot_4 and content.markers[4]
					end
				},
				{
					pass_type = "texture",
					style_id = "lock_1",
					texture_id = "lock_texture",
					content_check_function = function (content)
						return content.slot_1 and content.locked[1]
					end
				},
				{
					pass_type = "texture",
					style_id = "lock_2",
					texture_id = "lock_texture",
					content_check_function = function (content)
						return content.slot_2 and content.locked[2]
					end
				},
				{
					pass_type = "texture",
					style_id = "lock_3",
					texture_id = "lock_texture",
					content_check_function = function (content)
						return content.slot_3 and content.locked[3]
					end
				},
				{
					pass_type = "texture",
					style_id = "lock_4",
					texture_id = "lock_texture",
					content_check_function = function (content)
						return content.slot_4 and content.locked[4]
					end
				},
				{
					pass_type = "texture",
					style_id = "divider",
					texture_id = "divider_texture",
					content_check_function = function (content)
						return content.use_divider
					end
				}
			}
		},
		content = {
			marker = "red_cross_marker",
			border_texture = "level_list_small_frame",
			lock_texture = "locked_icon_01",
			title = "Test Title",
			use_divider = false,
			selection_texture = "level_list_selection_frame",
			divider_texture = "summary_screen_line_breaker",
			markers = {
				false,
				false,
				false,
				false
			},
			locked = {
				false,
				false,
				false,
				false
			},
			borders = {
				false,
				false,
				false,
				false
			}
		},
		style = {
			title = {
				vertical_alignment = "top",
				horizontal_alignment = "left",
				font_size = 26,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					35,
					1
				}
			},
			divider = {
				size = {
					386,
					22
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					35,
					40,
					1
				}
			},
			slot_1 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					-element_size[2],
					2
				}
			},
			slot_2 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*1 + element_spacing[1]*1,
					-element_size[2],
					2
				}
			},
			slot_3 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*2 + element_spacing[1]*2,
					-element_size[2],
					2
				}
			},
			slot_4 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*3 + element_spacing[1]*3,
					-element_size[2],
					2
				}
			},
			slot_fade_1 = {
				size = table.clone(element_size),
				color = {
					100,
					0,
					0,
					0
				},
				offset = {
					0,
					-element_size[2],
					3
				}
			},
			slot_fade_2 = {
				size = table.clone(element_size),
				color = {
					100,
					0,
					0,
					0
				},
				offset = {
					element_size[1]*1 + element_spacing[1]*1,
					-element_size[2],
					3
				}
			},
			slot_fade_3 = {
				size = table.clone(element_size),
				color = {
					100,
					0,
					0,
					0
				},
				offset = {
					element_size[1]*2 + element_spacing[1]*2,
					-element_size[2],
					3
				}
			},
			slot_fade_4 = {
				size = table.clone(element_size),
				color = {
					100,
					0,
					0,
					0
				},
				offset = {
					element_size[1]*3 + element_spacing[1]*3,
					-element_size[2],
					3
				}
			},
			marker_1 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					-element_size[2],
					4
				}
			},
			marker_2 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*1 + element_spacing[1]*1,
					-element_size[2],
					4
				}
			},
			marker_3 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*2 + element_spacing[1]*2,
					-element_size[2],
					4
				}
			},
			marker_4 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*3 + element_spacing[1]*3,
					-element_size[2],
					4
				}
			},
			lock_1 = {
				size = {
					30,
					38
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					41,
					-element_size[2] + 12,
					4
				}
			},
			lock_2 = {
				size = {
					30,
					38
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*1 + element_spacing[1]*1 + 41,
					-element_size[2] + 12,
					4
				}
			},
			lock_3 = {
				size = {
					30,
					38
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*2 + element_spacing[1]*2 + 41,
					-element_size[2] + 12,
					4
				}
			},
			lock_4 = {
				size = {
					30,
					38
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*3 + element_spacing[1]*3 + 41,
					-element_size[2] + 12,
					4
				}
			},
			border_1 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					-element_size[2],
					5
				}
			},
			border_2 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*1 + element_spacing[1]*1,
					-element_size[2],
					5
				}
			},
			border_3 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*2 + element_spacing[1]*2,
					-element_size[2],
					5
				}
			},
			border_4 = {
				size = table.clone(element_size),
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					element_size[1]*3 + element_spacing[1]*3,
					-element_size[2],
					5
				}
			},
			selection_1 = {
				size = {
					210,
					150
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					-46,
					-(element_size[2]*0.5 + 75),
					1
				}
			},
			selection_2 = {
				size = {
					210,
					150
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					(element_size[1]*1 + element_spacing[1]*1) - 46,
					-(element_size[2]*0.5 + 75),
					1
				}
			},
			selection_3 = {
				size = {
					210,
					150
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					(element_size[1]*2 + element_spacing[1]*2) - 46,
					-(element_size[2]*0.5 + 75),
					1
				}
			},
			selection_4 = {
				size = {
					210,
					150
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					(element_size[1]*3 + element_spacing[1]*3) - 46,
					-(element_size[2]*0.5 + 75),
					1
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
	bg_rect = UIWidgets.create_simple_rect("bg_rect", {
		200,
		0,
		0,
		0
	}),
	edge = UIWidgets.create_simple_texture("game_mode_divider", "edge"),
	edge_button_bg = UIWidgets.create_simple_texture("level_list_button_bg", "edge_button_bg"),
	edge_button_mg = UIWidgets.create_simple_texture("level_list_button_middle", "edge_button_mg"),
	edge_button_fg = UIWidgets.create_simple_texture("level_list_button_fg", "edge_button_fg"),
	edge_button_glow = UIWidgets.create_simple_texture("level_list_button_glow", "edge_button_glow"),
	rect_frame_top = UIWidgets.create_simple_texture("console_level_filter_frame_01", "rect_frame_top"),
	rect_frame_bottom = UIWidgets.create_simple_texture("console_level_filter_frame_02", "rect_frame_bottom"),
	background = UIWidgets.create_simple_uv_texture("area_image_karak_azgaraz_01", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "background_texture"),
	background_2 = UIWidgets.create_simple_uv_texture("area_image_ubersreik_01", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "background_texture2"),
	title_text = UIWidgets.create_simple_text("title_mission_list", "title_text", 36, Colors.get_table("cheeseburger")),
	info_box = UIWidgets.create_simple_texture("level_frame_addon_02", "info_box"),
	info_box_text = UIWidgets.create_simple_text("mission filter info text here", "info_box_text", 18, Colors.get_table("white"))
}
local generic_input_actions = {
	default = {
		{
			input_action = "refresh",
			priority = 2,
			description_text = "input_description_select_favorites"
		}
	}
}

return {
	widgets = widgets,
	element_size = element_size,
	create_element = create_element,
	generic_input_actions = generic_input_actions,
	scenegraph_definition = scenegraph_definition
}
