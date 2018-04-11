local CHAT_WIDTH = 600
local CHAT_HEIGHT = 226
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.chat
		},
		size = {
			1920,
			1080
		}
	},
	chat_window_root = {
		parent = "root",
		position = {
			0,
			200,
			0
		},
		size = {
			1,
			1
		}
	},
	chat_window_background = {
		parent = "chat_window_root",
		position = {
			0,
			0,
			1
		},
		size = {
			CHAT_WIDTH,
			CHAT_HEIGHT
		}
	},
	chat_window_frame_top = {
		parent = "chat_window_root",
		position = {
			0,
			CHAT_HEIGHT - 4,
			2
		},
		size = {
			CHAT_WIDTH,
			4
		}
	},
	chat_window_frame_bottom = {
		parent = "chat_window_root",
		position = {
			0,
			0,
			2
		},
		size = {
			CHAT_WIDTH,
			4
		}
	},
	chat_tab_root = {
		parent = "chat_window_background",
		horizontal_alignment = "right",
		position = {
			-176,
			-2,
			1
		},
		size = {
			1,
			1
		}
	},
	chat_tab_background = {
		parent = "chat_tab_root",
		position = {
			0,
			0,
			1
		},
		size = {
			176,
			228
		}
	},
	chat_tab_arrow = {
		parent = "chat_tab_root",
		position = {
			129,
			CHAT_HEIGHT / 2 - 10 + 1,
			2
		},
		size = {
			16,
			20
		}
	},
	chat_tab_notification = {
		parent = "chat_tab_root",
		position = {
			141,
			CHAT_HEIGHT / 2 - 10 + 1,
			2
		},
		size = {
			32,
			20
		}
	},
	chat_scrollbar_root = {
		parent = "chat_window_root",
		position = {
			CHAT_WIDTH - 54,
			6,
			2
		},
		size = {
			1,
			1
		}
	},
	chat_scrollbar_background = {
		parent = "chat_scrollbar_root",
		position = {
			1,
			1,
			2
		},
		size = {
			2,
			CHAT_HEIGHT - 14
		}
	},
	chat_scrollbar_background_hotspot = {
		parent = "chat_scrollbar_root",
		position = {
			-10,
			0,
			2
		},
		size = {
			24,
			CHAT_HEIGHT - 14
		}
	},
	chat_background_stroke_top = {
		parent = "chat_scrollbar_root",
		position = {
			0,
			CHAT_HEIGHT - 13,
			2
		},
		size = {
			4,
			1
		}
	},
	chat_background_stroke_bottom = {
		parent = "chat_scrollbar_root",
		position = {
			0,
			0,
			2
		},
		size = {
			4,
			1
		}
	},
	chat_background_stroke_left = {
		parent = "chat_scrollbar_root",
		position = {
			0,
			1,
			2
		},
		size = {
			1,
			CHAT_HEIGHT - 14
		}
	},
	chat_background_stroke_right = {
		parent = "chat_scrollbar_root",
		position = {
			3,
			1,
			2
		},
		size = {
			1,
			CHAT_HEIGHT - 14
		}
	},
	chat_scrollbar = {
		parent = "chat_scrollbar_root",
		position = {
			1,
			1,
			3
		},
		size = {
			2,
			65
		}
	},
	chat_scrollbar_stroke_top = {
		parent = "chat_scrollbar",
		position = {
			0,
			65,
			3
		},
		size = {
			2,
			2
		}
	},
	chat_scrollbar_stroke_bottom = {
		parent = "chat_scrollbar",
		position = {
			0,
			-2,
			3
		},
		size = {
			2,
			2
		}
	},
	chat_output_root = {
		parent = "chat_window_root",
		position = {
			8,
			42,
			1
		},
		size = {
			1,
			1
		}
	},
	chat_output_text = {
		parent = "chat_output_root",
		position = {
			0,
			0,
			2
		},
		size = {
			CHAT_WIDTH - 74,
			CHAT_HEIGHT - 26 - 24
		}
	},
	chat_input_root = {
		parent = "chat_window_root",
		position = {
			2,
			4,
			1
		},
		size = {
			CHAT_WIDTH - 61,
			24
		}
	},
	chat_input_text = {
		parent = "chat_input_root",
		position = {
			0,
			0,
			2
		},
		size = {
			CHAT_WIDTH - 74,
			CHAT_HEIGHT - 26 - 176
		}
	},
	chat_mask = {
		parent = "root",
		position = {
			0,
			165,
			0
		},
		size = {
			CHAT_WIDTH,
			CHAT_HEIGHT
		}
	}
}
local chat_window_widget = {
	scenegraph_id = "chat_window_root",
	element = {
		passes = {
			{
				style_id = "frame_top",
				pass_type = "texture_uv",
				content_id = "frame_top"
			},
			{
				style_id = "frame_bottom",
				pass_type = "texture_uv",
				content_id = "frame_bottom"
			},
			{
				style_id = "background",
				pass_type = "texture_uv",
				content_id = "background"
			}
		}
	},
	content = {
		background = {
			texture_id = "infoslate_bg",
			uvs = {
				{
					0,
					0
				},
				{
					1,
					1
				}
			}
		},
		frame_top = {
			texture_id = "infoslate_frame_02_horizontal",
			uvs = {
				{
					0,
					0
				},
				{
					1,
					1
				}
			}
		},
		frame_bottom = {
			texture_id = "infoslate_frame_02_horizontal",
			uvs = {
				{
					0,
					0
				},
				{
					1,
					1
				}
			}
		}
	},
	style = {
		frame_top = {
			scenegraph_id = "chat_window_frame_top",
			masked = false,
			color = Colors.get_table("white")
		},
		frame_bottom = {
			scenegraph_id = "chat_window_frame_bottom",
			masked = false,
			color = Colors.get_table("white")
		},
		background = {
			scenegraph_id = "chat_window_background",
			masked = false,
			color = Colors.get_table("white")
		}
	}
}
local chat_input_widget = {
	scenegraph_id = "chat_input_root",
	element = {
		passes = {
			{
				pass_type = "rect",
				style_id = "background"
			},
			{
				style_id = "text",
				pass_type = "text",
				text_id = "text_field"
			}
		}
	},
	content = {
		text_index = 1,
		caret_index = 1,
		text_field = ""
	},
	style = {
		background = {
			color = Colors.get_table("black"),
			size = {
				CHAT_WIDTH - 61,
				CHAT_HEIGHT - 26 - 176
			}
		},
		text = {
			font_size = 22,
			scenegraph_id = "chat_input_text",
			horizontal_scroll = true,
			pixel_perfect = false,
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark_arial",
			text_color = Colors.get_table("white"),
			offset = {
				8,
				6,
				3
			},
			caret_size = {
				2,
				26
			},
			caret_offset = {
				-11,
				-4,
				4
			},
			caret_color = Colors.get_table("white")
		}
	}
}
local chat_output_widget = {
	scenegraph_id = "chat_output_root",
	element = UIElements.TextAreaChat,
	content = {
		text_start_offset = 0,
		message_tables = {}
	},
	style = {
		background = {
			corner_radius = 0,
			color = Colors.get_table("black")
		},
		text = {
			word_wrap = true,
			scenegraph_id = "chat_output_text",
			font_size = 20,
			pixel_perfect = false,
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark_arial",
			text_color = Colors.get_table("white"),
			name_color = Colors.get_table("sky_blue"),
			name_color_dev = Colors.get_table("cheeseburger"),
			name_color_system = Colors.get_table("white"),
			offset = {
				0,
				0,
				3
			}
		}
	}
}
local chat_scrollbar_widget = {
	scenegraph_id = "chat_scrollbar_root",
	element = {
		passes = {
			{
				pass_type = "rect",
				style_id = "background",
				texture_id = "background_rect"
			},
			{
				pass_type = "rect",
				style_id = "background_stroke_top",
				texture_id = "background_stroke_top_rect"
			},
			{
				pass_type = "rect",
				style_id = "background_stroke_bottom",
				texture_id = "background_stroke_bottom_rect"
			},
			{
				pass_type = "rect",
				style_id = "background_stroke_left",
				texture_id = "background_stroke_left_rect"
			},
			{
				pass_type = "rect",
				style_id = "background_stroke_right",
				texture_id = "background_stroke_right_rect"
			},
			{
				style_id = "scrollbar",
				pass_type = "local_offset",
				offset_function = function (ui_scenegraph, ui_style, ui_content)
					local local_position = UISceneGraph.get_local_position(ui_scenegraph, ui_style.scenegraph_id)
					local bar_height = ui_content.scroll_bar_height
					local half_bar_height = bar_height / 2
					local min = ui_content.scroll_offset_min
					local max = ui_content.scroll_offset_max
					local y_pos = math.min(min + (max - min) * ui_content.internal_scroll_value, max - bar_height)
					local_position[2] = y_pos
					ui_content.scroll_value = (y_pos - min) / (max - bar_height - min)

					return 
				end
			},
			{
				pass_type = "rect",
				style_id = "scrollbar",
				texture_id = "scrollbar_rect"
			},
			{
				pass_type = "rect",
				style_id = "scrollbar_stroke_top",
				texture_id = "scrollbar_stroke_top_rect"
			},
			{
				pass_type = "rect",
				style_id = "scrollbar_stroke_bottom",
				texture_id = "scrollbar_stroke_bottom_rect"
			},
			{
				pass_type = "hover",
				style_id = "background_hotspot"
			},
			{
				style_id = "background_hotspot",
				pass_type = "held",
				held_function = function (ui_scenegraph, ui_style, ui_content, input_service)
					local cursor = UIInverseScaleVectorToResolution(input_service.get(input_service, "cursor"))
					local scenegraph_id = ui_style.scenegraph_id
					local world_position = UISceneGraph.get_world_position(ui_scenegraph, scenegraph_id)
					local bar_height = ui_content.scroll_bar_height
					local half_bar_size = bar_height / 2
					local start_delta_cursor = half_bar_size
					local y_pos = cursor[2] - start_delta_cursor
					local size = UISceneGraph.get_size(ui_scenegraph, scenegraph_id)
					local current_offset_from_bottom = y_pos - world_position[2]
					local current_offset_center_bar = current_offset_from_bottom
					local min_world_pos = world_position[2] + half_bar_size
					local scroll_offset_max = ui_content.scroll_offset_max
					local max_world_pos = (world_position[2] + scroll_offset_max) - half_bar_size - ui_content.scroll_offset_min
					local current_position = math.clamp(current_offset_center_bar, 0, size[2])
					local delta_value = math.min(current_position / size[2], 1)
					ui_content.internal_scroll_value = delta_value

					return 
				end
			}
		}
	},
	content = {
		scroll_bar_height = 65,
		scroll_offset_min = 2,
		internal_scroll_value = 0,
		scroll_value = 0,
		scroll_offset_max = CHAT_HEIGHT - 14
	},
	style = {
		background_hotspot = {
			scenegraph_id = "chat_scrollbar_background_hotspot",
			color = {
				0,
				0,
				0,
				0
			}
		},
		background = {
			scenegraph_id = "chat_scrollbar_background",
			color = Colors.get_table("gray")
		},
		scrollbar = {
			scenegraph_id = "chat_scrollbar",
			color = Colors.get_table("light_gray")
		},
		background_stroke_top = {
			scenegraph_id = "chat_background_stroke_top",
			color = Colors.get_table("black")
		},
		background_stroke_bottom = {
			scenegraph_id = "chat_background_stroke_bottom",
			color = Colors.get_table("black")
		},
		background_stroke_left = {
			scenegraph_id = "chat_background_stroke_left",
			color = Colors.get_table("black")
		},
		background_stroke_right = {
			scenegraph_id = "chat_background_stroke_right",
			color = Colors.get_table("black")
		},
		scrollbar_stroke_top = {
			scenegraph_id = "chat_scrollbar_stroke_top",
			color = Colors.get_table("black")
		},
		scrollbar_stroke_bottom = {
			scenegraph_id = "chat_scrollbar_stroke_bottom",
			color = Colors.get_table("black")
		}
	}
}
local chat_tab_widget = {
	scenegraph_id = "chat_tab_root",
	element = {
		passes = {
			{
				style_id = "hotspot_style",
				pass_type = "hotspot",
				content_id = "button_hotspot"
			},
			{
				pass_type = "texture",
				style_id = "button_notification",
				texture_id = "button_notification"
			},
			{
				pass_type = "rotated_texture",
				style_id = "button_arrow",
				texture_id = "button_arrow"
			},
			{
				pass_type = "texture",
				style_id = "background",
				texture_id = "background"
			}
		}
	},
	content = {
		background = "chat_tab",
		button_notification = "chat_talkbubble",
		button_arrow = "chat_arrow",
		button_hotspot = {}
	},
	style = {
		hotspot_style = {
			scenegraph_id = "chat_tab_notification"
		},
		button_notification = {
			scenegraph_id = "chat_tab_notification",
			color = Colors.get_table("white")
		},
		button_arrow = {
			scenegraph_id = "chat_tab_arrow",
			color = {
				255,
				255,
				255,
				255
			},
			angle = math.pi,
			pivot = {
				8,
				10
			}
		},
		background = {
			scenegraph_id = "chat_tab_background",
			color = {
				255,
				255,
				255,
				255
			}
		}
	}
}

return {
	CHAT_WIDTH = CHAT_WIDTH,
	CHAT_HEIGHT = CHAT_HEIGHT,
	scenegraph_definition = scenegraph_definition,
	chat_window_widget = chat_window_widget,
	chat_output_widget = chat_output_widget,
	chat_input_widget = chat_input_widget,
	chat_scrollbar_widget = chat_scrollbar_widget,
	chat_tab_widget = chat_tab_widget
}
