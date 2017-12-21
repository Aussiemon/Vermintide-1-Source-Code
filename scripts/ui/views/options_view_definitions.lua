local CHECKBOX_SIZE = {
	14,
	14
}
local SLIDER_SIZE = {
	200,
	10
}
local SLIDER_BORDER_THICKNESS = 2
local DROP_DOWN_SIZE = {
	200,
	30
}
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.default + 10
		},
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
	background = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		}
	},
	frame_divider = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		position = {
			420,
			-90,
			2
		},
		size = {
			36,
			746
		}
	},
	left_frame = {
		vertical_alignment = "bottom",
		parent = "background",
		horizontal_alignment = "left",
		position = {
			40,
			88,
			2
		},
		size = {
			364,
			902
		}
	},
	right_frame = {
		vertical_alignment = "bottom",
		parent = "left_frame",
		horizontal_alignment = "right",
		position = {
			1455,
			37,
			2
		},
		size = {
			1420,
			902
		}
	},
	left_frame_glow = {
		vertical_alignment = "center",
		parent = "frame_divider",
		horizontal_alignment = "center",
		position = {
			-72,
			0,
			-1
		},
		size = {
			144,
			758
		}
	},
	right_frame_glow = {
		vertical_alignment = "center",
		parent = "frame_divider",
		horizontal_alignment = "center",
		position = {
			72,
			0,
			-1
		},
		size = {
			144,
			758
		}
	},
	gamepad_tooltip_text = {
		vertical_alignment = "top",
		parent = "right_frame",
		horizontal_alignment = "left",
		position = {
			18,
			-30,
			3
		},
		size = {
			820,
			762
		}
	},
	gamepad_reset_text = {
		vertical_alignment = "bottom",
		parent = "right_frame",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			600,
			60
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			-10,
			2
		},
		size = {
			480,
			28
		}
	},
	list_mask = {
		vertical_alignment = "top",
		parent = "right_frame",
		horizontal_alignment = "left",
		position = {
			18,
			-45,
			2
		},
		size = {
			1340,
			732
		}
	},
	list_edge_fade_bottom = {
		vertical_alignment = "bottom",
		parent = "list_mask",
		horizontal_alignment = "center",
		position = {
			0,
			-15,
			2
		},
		size = {
			1340,
			15
		}
	},
	list_edge_fade_top = {
		vertical_alignment = "top",
		parent = "list_mask",
		horizontal_alignment = "center",
		position = {
			0,
			15,
			2
		},
		size = {
			1340,
			15
		}
	},
	scrollbar_root = {
		vertical_alignment = "center",
		parent = "list_mask",
		horizontal_alignment = "right",
		position = {
			74,
			0,
			10
		},
		size = {
			26,
			760
		}
	},
	exit_button = {
		vertical_alignment = "bottom",
		parent = "background",
		horizontal_alignment = "right",
		position = {
			-50,
			40,
			1
		},
		size = {
			220,
			62
		}
	},
	apply_button = {
		vertical_alignment = "bottom",
		parent = "background",
		horizontal_alignment = "right",
		position = {
			-50,
			110,
			1
		},
		size = {
			220,
			62
		}
	},
	reset_to_default = {
		vertical_alignment = "bottom",
		parent = "apply_button",
		horizontal_alignment = "right",
		position = {
			-230,
			0,
			0
		},
		size = {
			220,
			62
		}
	},
	settings_button_1 = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			318,
			84
		}
	},
	settings_button_2 = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-100,
			1
		},
		size = {
			318,
			84
		}
	},
	settings_button_3 = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-200,
			1
		},
		size = {
			318,
			84
		}
	},
	settings_button_4 = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-300,
			1
		},
		size = {
			318,
			84
		}
	},
	settings_button_5 = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-400,
			1
		},
		size = {
			318,
			84
		}
	},
	settings_button_6 = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-500,
			1
		},
		size = {
			318,
			84
		}
	},
	settings_button_7 = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-600,
			1
		},
		size = {
			318,
			84
		}
	},
	settings_button_8 = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-700,
			1
		},
		size = {
			318,
			84
		}
	},
	settings_button_gamepad_selection = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			21,
			4
		},
		size = {
			369,
			127
		}
	},
	calibrate_ui_dummy = {
		position = {
			0,
			0,
			1
		},
		size = {
			1,
			1
		}
	}
}
local gamepad_tooltip_style = {
	word_wrap = true,
	font_size = 28,
	localize = true,
	horizontal_alignment = "left",
	vertical_alignment = "top",
	font_type = "hell_shark",
	text_color = Colors.get_color_table_with_alpha("white", 255),
	line_colors = {
		Colors.get_color_table_with_alpha("cheeseburger", 255)
	},
	offset = {
		32,
		-11,
		10
	}
}
local gamepad_frame_widget_definitions = {
	gamepad_button_selection = UIWidgets.create_gamepad_selection("settings_button_gamepad_selection", nil, nil, {
		70,
		70
	}),
	left_frame_glow = UIWidgets.create_simple_texture("options_menu_divider_glow_01", "left_frame_glow"),
	right_frame_glow = UIWidgets.create_simple_texture("options_menu_divider_glow_02", "right_frame_glow"),
	gamepad_tooltip_text = UIWidgets.create_simple_text("", "gamepad_tooltip_text", nil, nil, gamepad_tooltip_style),
	gamepad_reset_text = UIWidgets.create_simple_text("options_menu_gamepad_reset_text", "gamepad_reset_text", 28, Colors.get_color_table_with_alpha("cheeseburger", 0))
}
local background_widget_definitions = {
	background = {
		scenegraph_id = "background",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "large_frame_01"
		},
		style = {}
	},
	frame_divider = {
		scenegraph_id = "frame_divider",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "options_menu_divider"
		},
		style = {}
	},
	right_frame = {
		scenegraph_id = "right_frame",
		element = {
			passes = {
				{
					style_id = "edge_fade_top_id",
					pass_type = "texture_uv",
					content_id = "edge_fade_top_id"
				},
				{
					style_id = "edge_fade_bottom_id",
					pass_type = "texture_uv",
					content_id = "edge_fade_bottom_id"
				},
				{
					pass_type = "scroll",
					scroll_function = function (ui_scenegraph, ui_style, ui_content, input_service, scroll_axis)
						local scroll_step = ui_content.scroll_step or 0.1
						local current_scroll_value = ui_content.internal_scroll_value
						current_scroll_value = current_scroll_value + scroll_step*-scroll_axis.y
						ui_content.internal_scroll_value = math.clamp(current_scroll_value, 0, 1)

						return 
					end
				}
			}
		},
		content = {
			internal_scroll_value = 0,
			edge_fade_top_id = {
				texture_id = "mask_rect_edge_fade",
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
			edge_fade_bottom_id = {
				texture_id = "mask_rect_edge_fade",
				uvs = {
					{
						0,
						1
					},
					{
						1,
						0
					}
				}
			}
		},
		style = {
			edge_fade_bottom_id = {
				scenegraph_id = "list_edge_fade_bottom",
				color = {
					255,
					255,
					255,
					255
				}
			},
			edge_fade_top_id = {
				scenegraph_id = "list_edge_fade_top",
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	list_mask = {
		scenegraph_id = "list_mask",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "mask_rect"
		},
		style = {
			color = {
				255,
				255,
				255,
				255
			}
		}
	},
	title_text = UIWidgets.create_title_text("settings_view_title", "title_text"),
	dead_space_filler = {
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
}
local widget_definitions = {}
local button_element_template = {
	passes = {
		{
			pass_type = "hotspot",
			content_id = "hotspot"
		},
		{
			pass_type = "texture",
			texture_id = "texture_id",
			content_check_function = function (content)
				return not content.hotspot.is_hover and 0 < content.hotspot.is_clicked
			end
		},
		{
			pass_type = "texture",
			texture_id = "texture_hover_id",
			content_check_function = function (content)
				return content.hotspot.is_hover and 0 < content.hotspot.is_clicked
			end
		},
		{
			pass_type = "texture",
			texture_id = "texture_click_id",
			content_check_function = function (content)
				return content.hotspot.is_clicked == 0 or content.hotspot.is_selected
			end
		},
		{
			style_id = "text",
			pass_type = "text",
			text_id = "text_field",
			content_check_function = function (content, style)
				if content.hotspot.is_hover then
					style.text_color = style.hover_color
				else
					style.text_color = style.default_color
				end

				return true
			end
		}
	}
}
local button_definitions = {
	exit_button = UIWidgets.create_menu_button_medium("menu_settings_exit", "exit_button"),
	apply_button = UIWidgets.create_menu_button_medium("menu_settings_apply", "apply_button"),
	reset_to_default = UIWidgets.create_menu_button_medium("menu_settings_reset_to_default", "reset_to_default")
}
local scrollbar_size_y = scenegraph_definition.scrollbar_root.size[2]
local scrollbar_definition = UIWidgets.create_scrollbar(scrollbar_size_y, "scrollbar_root")
local DEBUG_WIDGETS = false
local CHECKBOX_WIDGET_SIZE = {
	795,
	50
}

local function create_checkbox_widget(text, scenegraph_id, base_offset)
	base_offset[2] = base_offset[2] - CHECKBOX_WIDGET_SIZE[2]
	local definition = {
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "highlight_hotspot"
				},
				{
					style_id = "checkbox",
					pass_type = "hotspot",
					content_id = "hotspot"
				},
				{
					pass_type = "texture",
					style_id = "highlight_texture",
					texture_id = "highlight_texture",
					content_check_function = function (content)
						return content.is_highlighted
					end
				},
				{
					pass_type = "local_offset",
					offset_function = function (ui_scenegraph, ui_style, ui_content, ui_renderer)
						if ui_content.hotspot.on_release then
							ui_content.flag = not ui_content.flag
						end

						local flag = ui_content.flag

						if flag then
							ui_content.checkbox = "checkbox_checked"
						else
							ui_content.checkbox = "checkbox_unchecked"
						end

						return 
					end
				},
				{
					pass_type = "texture",
					style_id = "checkbox",
					texture_id = "checkbox"
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				},
				{
					pass_type = "border",
					content_check_function = function (content, style)
						if DEBUG_WIDGETS then
							style.thickness = 1
						end

						return DEBUG_WIDGETS
					end
				},
				{
					style_id = "debug_middle_line",
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				}
			}
		},
		content = {
			flag = false,
			checkbox = "checkbox_unchecked",
			highlight_texture = "playerlist_hover",
			hotspot = {},
			highlight_hotspot = {},
			text = text,
			hotspot_content_ids = {
				"hotspot"
			}
		},
		style = {
			highlight_texture = {
				masked = true,
				offset = {
					base_offset[1],
					base_offset[2],
					base_offset[3]
				},
				color = Colors.get_table("white"),
				size = {
					CHECKBOX_WIDGET_SIZE[1],
					CHECKBOX_WIDGET_SIZE[2]
				}
			},
			checkbox = {
				masked = true,
				offset = {
					base_offset[1] + 642,
					base_offset[2] + 17,
					base_offset[3]
				},
				size = {
					16,
					16
				}
			},
			text = {
				font_type = "hell_shark_masked",
				dynamic_font = true,
				localize = true,
				font_size = 28,
				offset = {
					base_offset[1] + 2,
					base_offset[2] + 5,
					base_offset[3]
				},
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			offset = {
				base_offset[1],
				base_offset[2],
				base_offset[3]
			},
			size = table.clone(CHECKBOX_WIDGET_SIZE),
			color = {
				50,
				255,
				255,
				255
			},
			debug_middle_line = {
				offset = {
					base_offset[1],
					(base_offset[2] + CHECKBOX_WIDGET_SIZE[2]/2) - 1,
					base_offset[3] + 10
				},
				size = {
					CHECKBOX_WIDGET_SIZE[1],
					2
				},
				color = {
					200,
					0,
					255,
					0
				}
			}
		},
		scenegraph_id = scenegraph_id
	}

	return UIWidget.init(definition)
end

local function create_simple_texture_widget(texture, texture_size, scenegraph_id, base_offset)
	base_offset[2] = base_offset[2] - texture_size[2]
	local definition = {
		element = {
			passes = {
				{
					texture_id = "texture_id",
					style_id = "texture_id",
					pass_type = "texture"
				}
			}
		},
		content = {
			texture_id = texture
		},
		style = {
			size = {
				texture_size[1],
				texture_size[2]
			},
			offset = {
				base_offset[1],
				base_offset[2],
				base_offset[3]
			},
			texture_id = {
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					base_offset[1],
					base_offset[2],
					base_offset[3] + 15
				},
				size = {
					texture_size[1],
					texture_size[2]
				}
			}
		},
		scenegraph_id = scenegraph_id
	}

	return UIWidget.init(definition)
end

local function create_gamepad_layout_widget(texture, texture_size, texture2, texture_size2, scenegraph_id, base_offset)
	base_offset[2] = base_offset[2] - texture_size[2]
	local platform = PLATFORM
	local definition = nil

	if platform == "win32" then
		definition = UIWidgets.create_gamepad_layout_win32(texture, texture_size, texture2, texture_size2, base_offset, scenegraph_id)
	elseif platform == "xb1" then
		definition = UIWidgets.create_gamepad_layout_xb1(texture, texture_size, base_offset, scenegraph_id)
	elseif platform == "ps4" then
		definition = UIWidgets.create_gamepad_layout_ps4(texture, texture_size, base_offset, scenegraph_id)
	end

	return UIWidget.init(definition)
end

local SLIDER_WIDGET_SIZE = {
	1315,
	50
}

local function create_slider_widget(text, tooltip_text, scenegraph_id, base_offset, slider_image)
	base_offset[2] = base_offset[2] - SLIDER_WIDGET_SIZE[2]
	local definition = {
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "frame",
					texture_id = "frame"
				},
				{
					pass_type = "texture",
					style_id = "frame_bg",
					texture_id = "frame_bg"
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					pass_type = "hotspot",
					content_id = "highlight_hotspot"
				},
				{
					pass_type = "texture",
					style_id = "highlight_texture",
					texture_id = "highlight_texture",
					content_check_function = function (content)
						return content.is_highlighted
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "tooltip_text",
					content_check_function = function (ui_content)
						return ui_content.tooltip_text and ui_content.highlight_hotspot.is_hover
					end
				},
				{
					style_id = "slider_box",
					pass_type = "hotspot",
					content_id = "hotspot"
				},
				{
					style_id = "slider_box",
					content_check_hover = "hotspot",
					pass_type = "held",
					held_function = function (ui_scenegraph, ui_style, ui_content, input_service)
						local cursor = UIInverseScaleVectorToResolution(input_service.get(input_service, "cursor"))
						local scenegraph_id = ui_content.scenegraph_id
						local world_position = UISceneGraph.get_world_position(ui_scenegraph, scenegraph_id)
						local size_x = ui_style.size[1]
						local cursor_x = cursor[1]
						local pos_start = world_position[1] + ui_style.offset[1]
						local old_value = ui_content.internal_value
						local cursor_x_norm = cursor_x - pos_start
						local value = math.clamp(cursor_x_norm/size_x, 0, 1)
						ui_content.internal_value = value

						if old_value ~= value then
							ui_content.changed = true
						end

						return 
					end
				},
				{
					pass_type = "local_offset",
					offset_function = function (ui_scenegraph, ui_style, ui_content)
						local internal_value = ui_content.internal_value
						local min = ui_content.min
						local max = ui_content.max
						local real_value = math.round_with_precision(min + (max - min)*internal_value, ui_content.num_decimals or 0)
						ui_content.value = real_value
						ui_content.value_text = real_value
						local slider_box_style = ui_style.slider_box
						local slider_style = ui_style.slider
						local size_x = slider_box_style.size[1]*internal_value
						slider_style.size[1] = size_x
						local slider_content = ui_content.slider
						slider_content.uvs[2][1] = internal_value
						local base_offset_x = slider_style.offset[1]
						local slider_icon_style = ui_style.slider_icon
						slider_icon_style.offset[1] = (base_offset_x + size_x) - slider_icon_style.size[1]/2

						if ui_content.hotspot.is_hover or ui_content.altering_value then
							ui_style.value_text.text_color = ui_style.value_text.hover_color
						else
							ui_style.value_text.text_color = ui_style.value_text.default_color
						end

						return 
					end
				},
				{
					style_id = "value_text",
					pass_type = "text",
					text_id = "value_text"
				},
				{
					pass_type = "texture_uv",
					style_id = "slider",
					texture_id = "texture",
					content_id = "slider"
				},
				{
					pass_type = "texture",
					style_id = "slider_icon",
					texture_id = "slider_icon"
				},
				{
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				},
				{
					style_id = "slider_box",
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				},
				{
					pass_type = "border",
					content_check_function = function (content, style)
						if DEBUG_WIDGETS then
							style.thickness = 1
						end

						return DEBUG_WIDGETS
					end
				},
				{
					style_id = "debug_middle_line",
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				},
				{
					pass_type = "texture",
					style_id = "slider_image",
					texture_id = "slider_image",
					content_check_function = function (content)
						return content.slider_image ~= ""
					end
				}
			}
		},
		content = {
			internal_value = 0.5,
			frame = "slider_frame",
			frame_bg = "slider_frame_bg",
			value = 0.5,
			highlight_texture = "playerlist_hover",
			slider_icon = "slider_skull_icon",
			scenegraph_id = scenegraph_id,
			text = text,
			slider_image = (slider_image and slider_image.slider_image) or "",
			tooltip_text = tooltip_text,
			hotspot = {},
			highlight_hotspot = {},
			slider = {
				texture = "slider_frame_fill",
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
			hotspot_content_ids = {
				"hotspot"
			}
		},
		style = {
			offset = {
				base_offset[1],
				base_offset[2] - ((slider_image and slider_image.size[2]) or 0),
				base_offset[3]
			},
			size = {
				SLIDER_WIDGET_SIZE[1],
				SLIDER_WIDGET_SIZE[2] + ((slider_image and slider_image.size[2]) or 0)
			},
			color = {
				50,
				255,
				255,
				255
			},
			highlight_texture = {
				masked = true,
				offset = {
					base_offset[1],
					base_offset[2],
					base_offset[3]
				},
				color = Colors.get_table("white"),
				size = {
					SLIDER_WIDGET_SIZE[1],
					SLIDER_WIDGET_SIZE[2]
				}
			},
			tooltip_text = {
				font_type = "hell_shark",
				localize = true,
				font_size = 24,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				cursor_side = "left",
				max_width = 600,
				cursor_offset = {
					-10,
					-27
				},
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {
					Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				offset = {
					0,
					0,
					base_offset[3] + 20
				}
			},
			frame = {
				masked = true,
				offset = {
					base_offset[1] + 523 + 520,
					base_offset[2] + 5 + 10,
					base_offset[3] + 11
				},
				size = {
					210,
					20
				}
			},
			frame_bg = {
				masked = true,
				offset = {
					base_offset[1] + 523 + 520,
					base_offset[2] + 5 + 10,
					base_offset[3] + 1
				},
				size = {
					210,
					20
				}
			},
			text = {
				font_type = "hell_shark_masked",
				dynamic_font = true,
				localize = true,
				font_size = 28,
				offset = {
					base_offset[1] + 2,
					base_offset[2] + 5,
					base_offset[3]
				},
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			slider_box = {
				offset = {
					base_offset[1] + 523 + 5 + 520,
					base_offset[2] + 5 + 5,
					base_offset[3] + 10
				},
				size = {
					200,
					30
				},
				color = {
					50,
					255,
					255,
					255
				}
			},
			value_text = {
				horizontal_alignment = "right",
				localize = false,
				font_size = 24,
				dynamic_font = true,
				font_type = "hell_shark_masked",
				offset = {
					base_offset[1] + 523 + 255 + 520,
					base_offset[2] + 6,
					base_offset[3]
				},
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				default_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				hover_color = Colors.get_color_table_with_alpha("white", 255)
			},
			slider = {
				masked = true,
				offset = {
					base_offset[1] + 523 + 5 + 520,
					base_offset[2] + 5 + 16,
					base_offset[3] + 10
				},
				size = {
					200,
					8
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			slider_icon = {
				masked = true,
				offset = {
					base_offset[1] + 523 + 520,
					base_offset[2] + 5 + 5,
					base_offset[3] + 15
				},
				size = {
					30,
					30
				}
			},
			debug_middle_line = {
				offset = {
					base_offset[1],
					(base_offset[2] + SLIDER_WIDGET_SIZE[2]/2) - 1,
					base_offset[3] + 10
				},
				size = {
					SLIDER_WIDGET_SIZE[1],
					2
				},
				color = {
					200,
					0,
					255,
					0
				}
			},
			slider_image = {
				masked = true,
				size = (slider_image and slider_image.size) or {
					0,
					0
				},
				offset = {
					(base_offset[1] + SLIDER_WIDGET_SIZE[1]) - ((slider_image and slider_image.size[1]) or 0),
					base_offset[2] - ((slider_image and slider_image.size[2]) or 0),
					base_offset[3] + 15
				}
			}
		},
		scenegraph_id = scenegraph_id
	}
	base_offset[2] = base_offset[2] - SLIDER_WIDGET_SIZE[2] - ((slider_image and slider_image.size[2]) or 0)

	return UIWidget.init(definition)
end

local DROP_DOWN_WIDGET_SIZE = {
	1315,
	50
}

local function create_drop_down_widget(text, options, selected_option, tooltip_text, scenegraph_id, base_offset)
	local options_texts = {}
	local options_values = {}
	local options_n = #options

	for i = 1, options_n, 1 do
		options_texts[i] = options[i].text
		options_values[i] = options[i].value
	end

	base_offset[2] = base_offset[2] - DROP_DOWN_WIDGET_SIZE[2]
	local item_size = {
		248,
		24
	}
	local item_styles = {}
	local item_contents = {}

	for i = 1, options_n, 1 do
		local content = {
			selected = false,
			hotspot = {},
			text = options_texts[i]
		}
		local style = {
			text = {
				dynamic_font = true,
				font_size = 20,
				font_type = "hell_shark_masked",
				offset = {
					5,
					0,
					25
				},
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				default_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				hover_color = Colors.get_color_table_with_alpha("white", 255)
			},
			size = item_size,
			color = {
				50,
				255,
				255,
				255
			}
		}
		item_styles[i] = style
		item_contents[i] = content
	end

	local selected_bg_y = item_size[2]*options_n
	local pi = math.pi
	local definition = {
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "frame",
					texture_id = "frame"
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					pass_type = "texture",
					style_id = "disabled_texture",
					texture_id = "disabled_texture",
					content_check_function = function (content)
						return content.disabled
					end
				},
				{
					pass_type = "hotspot",
					content_id = "highlight_hotspot"
				},
				{
					pass_type = "texture",
					style_id = "highlight_texture",
					texture_id = "highlight_texture",
					content_check_function = function (content)
						return content.is_highlighted
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "tooltip_text",
					content_check_function = function (ui_content)
						return ui_content.tooltip_text and ui_content.highlight_hotspot.is_hover
					end
				},
				{
					style_id = "frame",
					pass_type = "hotspot",
					content_id = "hotspot"
				},
				{
					pass_type = "rotated_texture",
					style_id = "arrow",
					texture_id = "arrow",
					content_check_function = function (content, style)
						if content.active then
							style.angle = pi
						else
							style.angle = 0
						end

						return true
					end
				},
				{
					style_id = "selected_option",
					pass_type = "text",
					text_id = "selected_option",
					content_check_function = function (content, style)
						if content.hotspot.is_hover or content.active then
							style.text_color = style.hover_color
						else
							style.text_color = style.default_color
						end

						local current_option = content.options_texts[content.current_selection]

						if content.selected_option ~= current_option then
							content.selected_option = current_option
						end

						if content.selected_option == nil then
							content.selected_option = ""
						end

						return true
					end
				},
				{
					style_id = "list_style",
					pass_type = "list_pass",
					content_id = "list_content",
					content_check_function = function (content, style)
						return style.active
					end,
					passes = {
						{
							pass_type = "hotspot",
							content_id = "hotspot"
						},
						{
							pass_type = "local_offset",
							offset_function = function (ui_scenegraph, ui_style, ui_content, ui_renderer)
								local hotspot = ui_content.hotspot
								local text_style = ui_style.text

								if hotspot.on_hover_enter then
									hotspot.is_selected = true
								elseif hotspot.on_hover_exit then
									hotspot.is_selected = false
								end

								if hotspot.is_selected then
									text_style.text_color = text_style.hover_color
								else
									text_style.text_color = text_style.default_color
								end

								return 
							end
						},
						{
							style_id = "text",
							pass_type = "text",
							text_id = "text"
						}
					}
				},
				{
					pass_type = "texture",
					style_id = "selected_bg",
					texture_id = "selected_bg",
					content_check_function = function (content, style)
						return content.active
					end
				},
				{
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				},
				{
					pass_type = "border",
					content_check_function = function (content, style)
						if DEBUG_WIDGETS then
							style.thickness = 1
						end

						return DEBUG_WIDGETS
					end
				},
				{
					style_id = "debug_middle_line",
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				}
			}
		},
		content = {
			selected_bg = "drop_down_menu_selected_bg",
			frame = "drop_down_menu_frame",
			arrow = "drop_down_menu_arrow",
			disabled_texture = "rect_masked",
			highlight_texture = "playerlist_hover",
			disabled = false,
			active = false,
			hotspot = {},
			highlight_hotspot = {},
			list_content = item_contents,
			text = text,
			selected_option = options_texts[selected_option],
			current_selection = selected_option,
			options_texts = options_texts,
			options_values = options_values,
			tooltip_text = tooltip_text,
			hotspot_content_ids = {
				"hotspot"
			}
		},
		style = {
			offset = {
				base_offset[1],
				base_offset[2],
				base_offset[3]
			},
			list_style = {
				active = false,
				start_index = 1,
				offset = {
					base_offset[1] + 521 + 4 + 520,
					(base_offset[2] + 9) - 26,
					base_offset[3]
				},
				num_draws = options_n,
				list_member_offset = {
					0,
					-item_size[2],
					0
				},
				item_styles = item_styles
			},
			highlight_texture = {
				masked = true,
				offset = {
					base_offset[1],
					base_offset[2],
					base_offset[3]
				},
				color = Colors.get_table("white"),
				size = {
					DROP_DOWN_WIDGET_SIZE[1],
					DROP_DOWN_WIDGET_SIZE[2]
				}
			},
			tooltip_text = {
				font_type = "hell_shark",
				localize = true,
				font_size = 24,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				cursor_side = "left",
				max_width = 600,
				cursor_offset = {
					-10,
					-27
				},
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {
					Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				offset = {
					0,
					0,
					base_offset[3] + 20
				}
			},
			frame = {
				masked = true,
				offset = {
					base_offset[1] + 521 + 520,
					base_offset[2] + 9,
					base_offset[3]
				},
				size = {
					256,
					32
				}
			},
			text = {
				font_type = "hell_shark_masked",
				dynamic_font = true,
				localize = true,
				font_size = 28,
				offset = {
					base_offset[1] + 2,
					base_offset[2] + 5,
					base_offset[3] + 10
				},
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			arrow = {
				masked = true,
				offset = {
					base_offset[1] + 521 + 231 + 520,
					base_offset[2] + 9 + 8,
					base_offset[3]
				},
				size = {
					22,
					16
				},
				color = {
					255,
					255,
					255,
					255
				},
				angle = pi,
				pivot = {
					11,
					8
				}
			},
			selected_option = {
				dynamic_font = true,
				font_size = 20,
				font_type = "hell_shark_masked",
				offset = {
					base_offset[1] + 521 + 8 + 520,
					base_offset[2] + 9,
					base_offset[3] + 10
				},
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				default_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				hover_color = Colors.get_color_table_with_alpha("white", 255)
			},
			selected_bg = {
				masked = true,
				offset = {
					base_offset[1] + 521 + 4 + 520,
					(base_offset[2] + 9) - selected_bg_y,
					base_offset[3] + 20
				},
				size = {
					248,
					selected_bg_y + 7
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			disabled_texture = {
				masked = true,
				color = Colors.get_color_table_with_alpha("black", 180),
				offset = {
					base_offset[1] + 521 + 520,
					base_offset[2] + 9 + 2,
					base_offset[3] + 11
				},
				size = {
					256,
					28
				}
			},
			debug_middle_line = {
				offset = {
					base_offset[1],
					(base_offset[2] + DROP_DOWN_WIDGET_SIZE[2]/2) - 1,
					base_offset[3] + 10
				},
				size = {
					DROP_DOWN_WIDGET_SIZE[1],
					2
				},
				color = {
					200,
					0,
					255,
					0
				}
			},
			size = table.clone(DROP_DOWN_WIDGET_SIZE),
			color = {
				50,
				255,
				255,
				255
			}
		},
		scenegraph_id = scenegraph_id
	}

	return UIWidget.init(definition)
end

local STEPPER_WIDGET_SIZE = {
	1315,
	50
}

local function create_stepper_widget(text, options, selected_option, tooltip_text, scenegraph_id, base_offset)
	local options_texts = {}
	local options_values = {}
	local num_options = #options

	for i = 1, num_options, 1 do
		options_texts[i] = options[i].text
		options_values[i] = options[i].value
	end

	base_offset[2] = base_offset[2] - STEPPER_WIDGET_SIZE[2]
	local definition = {
		element = {
			passes = {
				{
					pass_type = "local_offset",
					offset_function = function (ui_scenegraph, ui_style, ui_content, ui_renderer)
						local selection_text = ui_content.options_texts[ui_content.current_selection]

						if selection_text ~= ui_content.selection_text then
							ui_content.selection_text = selection_text
						end

						return 
					end
				},
				{
					style_id = "left_arrow_hotspot",
					pass_type = "hotspot",
					content_id = "left_hotspot"
				},
				{
					style_id = "right_arrow_hotspot",
					pass_type = "hotspot",
					content_id = "right_hotspot"
				},
				{
					pass_type = "hotspot",
					content_id = "highlight_hotspot"
				},
				{
					pass_type = "texture",
					style_id = "highlight_texture",
					texture_id = "highlight_texture",
					content_check_function = function (content)
						return content.is_highlighted
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "tooltip_text",
					content_check_function = function (ui_content)
						return ui_content.tooltip_text and ui_content.highlight_hotspot.is_hover
					end
				},
				{
					pass_type = "local_offset",
					offset_function = function (ui_scenegraph, ui_style, ui_content, ui_renderer)
						local left_hotspot = ui_content.left_hotspot
						local right_hotspot = ui_content.right_hotspot

						if left_hotspot.on_hover_enter then
							ui_content.on_hover_enter_callback("left_arrow_hover")
						end

						if left_hotspot.on_hover_exit then
							ui_content.on_hover_exit_callback("left_arrow_hover")
						end

						if left_hotspot.on_release then
							ui_content.on_pressed_callback("left_arrow")
							ui_content.on_pressed_callback("left_arrow_hover")
						end

						if right_hotspot.on_hover_enter then
							ui_content.on_hover_enter_callback("right_arrow_hover")
						end

						if right_hotspot.on_hover_exit then
							ui_content.on_hover_exit_callback("right_arrow_hover")
						end

						if right_hotspot.on_release then
							ui_content.on_pressed_callback("right_arrow")
							ui_content.on_pressed_callback("right_arrow_hover")
						end

						if left_hotspot.is_hover or right_hotspot.is_hover then
							ui_style.selection_text.text_color = ui_style.selection_text.highlight_color
						else
							ui_style.selection_text.text_color = ui_style.selection_text.default_color
						end

						return 
					end
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					pass_type = "texture",
					style_id = "left_arrow",
					texture_id = "left_arrow"
				},
				{
					pass_type = "rotated_texture",
					style_id = "right_arrow",
					texture_id = "right_arrow"
				},
				{
					pass_type = "texture",
					style_id = "left_arrow_hover",
					texture_id = "left_arrow_hover"
				},
				{
					pass_type = "rotated_texture",
					style_id = "right_arrow_hover",
					texture_id = "right_arrow_hover"
				},
				{
					style_id = "selection_text",
					pass_type = "text",
					text_id = "selection_text",
					content_check_function = function (content)
						local selection_text = content.selection_text

						return selection_text and selection_text ~= ""
					end
				},
				{
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				},
				{
					pass_type = "border",
					content_check_function = function (content, style)
						if DEBUG_WIDGETS then
							style.thickness = 1
						end

						return DEBUG_WIDGETS
					end
				},
				{
					style_id = "debug_middle_line",
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				}
			}
		},
		content = {
			left_arrow = "settings_arrow_normal",
			right_arrow_hover = "settings_arrow_clicked",
			selection_text = "",
			left_arrow_hover = "settings_arrow_clicked",
			highlight_texture = "playerlist_hover",
			right_arrow = "settings_arrow_normal",
			left_hotspot = {},
			right_hotspot = {},
			highlight_hotspot = {},
			text = text,
			tooltip_text = tooltip_text,
			current_selection = selected_option,
			options_texts = options_texts,
			options_values = options_values,
			num_options = num_options,
			hotspot_content_ids = {
				"left_hotspot",
				"right_hotspot"
			}
		},
		style = {
			offset = table.clone(base_offset),
			size = table.clone(STEPPER_WIDGET_SIZE),
			highlight_texture = {
				masked = true,
				offset = {
					base_offset[1],
					base_offset[2],
					base_offset[3]
				},
				color = Colors.get_table("white"),
				size = {
					STEPPER_WIDGET_SIZE[1],
					STEPPER_WIDGET_SIZE[2]
				}
			},
			tooltip_text = {
				font_type = "hell_shark",
				localize = true,
				font_size = 24,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				cursor_side = "left",
				max_width = 600,
				cursor_offset = {
					-10,
					-27
				},
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {
					Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				offset = {
					0,
					0,
					base_offset[3] + 20
				}
			},
			left_arrow = {
				masked = true,
				offset = {
					base_offset[1] + 520 + 520,
					base_offset[2] + 5 + 2,
					base_offset[3]
				},
				size = {
					28,
					34
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			left_arrow_hover = {
				masked = true,
				offset = {
					base_offset[1] + 520 + 520,
					base_offset[2] + 5 + 2,
					base_offset[3]
				},
				size = {
					28,
					34
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			left_arrow_hotspot = {
				offset = {
					base_offset[1] + 520 + 520,
					base_offset[2] + 5 + 2,
					base_offset[3]
				},
				size = {
					129,
					34
				}
			},
			right_arrow = {
				masked = true,
				offset = {
					base_offset[1] + 750 + 520,
					base_offset[2] + 5 + 2,
					base_offset[3]
				},
				size = {
					28,
					34
				},
				color = {
					255,
					255,
					255,
					255
				},
				angle = math.pi,
				pivot = {
					14,
					17
				}
			},
			right_arrow_hover = {
				masked = true,
				offset = {
					base_offset[1] + 750 + 520,
					base_offset[2] + 5 + 2,
					base_offset[3]
				},
				size = {
					28,
					34
				},
				color = {
					0,
					255,
					255,
					255
				},
				angle = math.pi,
				pivot = {
					14,
					17
				}
			},
			right_arrow_hotspot = {
				offset = {
					(base_offset[1] + 750) - 101 + 520,
					base_offset[2] + 5 + 2,
					base_offset[3]
				},
				size = {
					129,
					34
				}
			},
			text = {
				font_type = "hell_shark_masked",
				dynamic_font = true,
				localize = true,
				font_size = 28,
				offset = {
					base_offset[1] + 2,
					base_offset[2] + 5,
					base_offset[3]
				},
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			selection_text = {
				dynamic_font = true,
				font_size = 24,
				font_type = "hell_shark_masked",
				horizontal_alignment = "center",
				offset = {
					base_offset[1] + 650 + 520,
					base_offset[2] + 6,
					base_offset[3]
				},
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				highlight_color = Colors.get_color_table_with_alpha("white", 255),
				default_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			debug_middle_line = {
				offset = {
					base_offset[1],
					(base_offset[2] + STEPPER_WIDGET_SIZE[2]/2) - 1,
					base_offset[3] + 10
				},
				size = {
					STEPPER_WIDGET_SIZE[1],
					2
				},
				color = {
					200,
					0,
					255,
					0
				}
			},
			color = {
				50,
				255,
				255,
				255
			}
		},
		scenegraph_id = scenegraph_id
	}

	return UIWidget.init(definition)
end

local KEYBIND_WIDGET_SIZE = {
	1315,
	50
}

local function create_keybind_widget(selected_key, actions, actions_info, scenegraph_id, base_offset)
	base_offset[2] = base_offset[2] - KEYBIND_WIDGET_SIZE[2]
	local definition = {
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "hotspot"
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					pass_type = "hotspot",
					content_id = "highlight_hotspot"
				},
				{
					pass_type = "texture",
					style_id = "highlight_texture",
					texture_id = "highlight_texture",
					content_check_function = function (content)
						return content.is_highlighted
					end
				},
				{
					pass_type = "local_offset",
					offset_function = function (ui_scenegraph, ui_style, ui_content, ui_renderer)
						local selected_key_style = ui_style.selected_key

						if ui_content.active or ui_content.highlight_hotspot.is_hover then
							selected_key_style.text_color = selected_key_style.hover_color
						else
							selected_key_style.text_color = selected_key_style.default_color
						end

						if ui_content.active then
							ui_content.active_t = ui_content.active_t + ui_renderer.dt*2.5
							local i = math.sirp(0, 1, ui_content.active_t)
							ui_style.selected_rect.color[1] = i*255
						else
							ui_style.selected_rect.color[1] = 255
						end

						return 
					end
				},
				{
					style_id = "selected_key",
					pass_type = "text",
					text_id = "selected_key",
					content_check_function = function (content)
						return not content.active
					end
				},
				{
					style_id = "selected_rect",
					pass_type = "rect",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				},
				{
					pass_type = "border",
					content_check_function = function (content, style)
						if DEBUG_WIDGETS then
							style.thickness = 1
						end

						return DEBUG_WIDGETS
					end
				},
				{
					style_id = "debug_middle_line",
					pass_type = "rect",
					content_check_function = function (content)
						return DEBUG_WIDGETS
					end
				}
			}
		},
		content = {
			highlight_texture = "playerlist_hover",
			active_t = 0,
			hotspot = {},
			highlight_hotspot = {},
			text = actions[1],
			actions = actions,
			actions_info = actions_info,
			selected_key = selected_key,
			hotspot_content_ids = {
				"hotspot"
			}
		},
		style = {
			offset = table.clone(base_offset),
			highlight_texture = {
				masked = true,
				offset = {
					base_offset[1],
					base_offset[2],
					base_offset[3]
				},
				color = Colors.get_table("white"),
				size = {
					KEYBIND_WIDGET_SIZE[1],
					KEYBIND_WIDGET_SIZE[2]
				}
			},
			text = {
				font_type = "hell_shark_masked",
				dynamic_font = true,
				localize = true,
				font_size = 28,
				offset = {
					base_offset[1] + 2,
					base_offset[2] + 5,
					base_offset[3]
				},
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			selected_key = {
				dynamic_font = true,
				font_size = 24,
				font_type = "hell_shark_masked",
				horizontal_alignment = "center",
				offset = {
					base_offset[1] + 650 + 520,
					base_offset[2] + 7,
					base_offset[3]
				},
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				hover_color = Colors.get_color_table_with_alpha("white", 255),
				default_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			selected_rect = {
				offset = {
					base_offset[1] + 635 + 520,
					base_offset[2] + 7,
					base_offset[3]
				},
				size = {
					30,
					4
				},
				color = Colors.get_color_table_with_alpha("white", 255)
			},
			debug_middle_line = {
				offset = {
					base_offset[1],
					(base_offset[2] + KEYBIND_WIDGET_SIZE[2]/2) - 1,
					base_offset[3] + 10
				},
				size = {
					KEYBIND_WIDGET_SIZE[1],
					2
				},
				color = {
					200,
					0,
					255,
					0
				}
			},
			size = table.clone(KEYBIND_WIDGET_SIZE),
			color = {
				50,
				255,
				255,
				255
			}
		},
		scenegraph_id = scenegraph_id
	}

	return UIWidget.init(definition)
end

SettingsWidgetTypeTemplate = {
	drop_down = {
		input_function = function (widget, input_service)
			local content = widget.content
			local style = widget.style
			local list_content = content.list_content
			local list_style = style.list_style

			if content.active then
				if input_service.get(input_service, "move_up") then
					local num_draws = list_style.num_draws
					local selected_index = nil

					for i = 1, num_draws, 1 do
						local entry_hotspot = list_content[i].hotspot

						if entry_hotspot.is_selected then
							selected_index = i

							break
						end
					end

					if selected_index then
						if 1 < selected_index then
							list_content[selected_index].hotspot.is_selected = false
							list_content[selected_index - 1].hotspot.is_selected = true
						end
					else
						list_content[1].hotspot.is_selected = true
					end

					return true
				elseif input_service.get(input_service, "move_down") then
					local num_draws = list_style.num_draws
					local selected_index = nil

					for i = 1, num_draws, 1 do
						local entry_hotspot = list_content[i].hotspot

						if entry_hotspot.is_selected then
							selected_index = i

							break
						end
					end

					if selected_index then
						if selected_index < num_draws then
							list_content[selected_index].hotspot.is_selected = false
							list_content[selected_index + 1].hotspot.is_selected = true
						end
					else
						list_content[1].hotspot.is_selected = true
					end

					return true
				end
			end

			if input_service.get(input_service, "confirm") then
				if not content.active then
					content.active = true
					list_style.active = true
				else
					content.active = false
					list_style.active = false
					local num_draws = list_style.num_draws
					local selected_index = nil

					for i = 1, num_draws, 1 do
						local entry_hotspot = list_content[i].hotspot

						if entry_hotspot.is_selected then
							entry_hotspot.is_selected = false
							selected_index = i

							break
						end
					end

					if selected_index then
						content.current_selection = selected_index

						content.callback(content)
					end
				end

				return true, content.active
			end

			if content.active and input_service.get(input_service, "back") then
				content.active = false
				list_style.active = false
				local num_draws = list_style.num_draws

				for i = 1, num_draws, 1 do
					local entry_hotspot = list_content[i].hotspot

					if entry_hotspot.is_selected then
						entry_hotspot.is_selected = false

						break
					end
				end

				return true, content.active
			end

			return content.active
		end,
		input_description = {
			name = "drop_down",
			gamepad_support = true,
			actions = {
				{
					input_action = "confirm",
					priority = 3,
					description_text = "input_description_open"
				}
			}
		},
		active_input_description = {
			ignore_generic_actions = true,
			name = "drop_down",
			gamepad_support = true,
			actions = {
				{
					input_action = "back",
					priority = 3,
					description_text = "input_description_back"
				},
				{
					input_action = "confirm",
					priority = 2,
					description_text = "input_description_confirm"
				}
			}
		}
	},
	checkbox = {
		input_function = function (widget, input_service)
			local content = widget.content

			if input_service.get(input_service, "confirm") then
				content.hotspot.on_release = true

				return true
			end

			return 
		end,
		input_description = {
			name = "checkbox",
			gamepad_support = true,
			actions = {
				{
					input_action = "confirm",
					priority = 3,
					description_text = "input_description_toggle"
				}
			}
		}
	},
	keybind = {
		input_function = function (widget, input_service)
			local content = widget.content
			local style = widget.style

			if content.active and input_service.get(input_service, "back", true) then
				content.controller_input_pressed = true

				return true
			end

			if content.active and (input_service.get(input_service, "move_up") or input_service.get(input_service, "move_down") or input_service.get(input_service, "move_up_hold") or input_service.get(input_service, "move_down_hold")) then
				return true
			end

			return 
		end,
		input_description = {
			name = "keybind",
			gamepad_support = true,
			actions = {}
		}
	},
	stepper = {
		input_function = function (widget, input_service)
			local content = widget.content

			if input_service.get(input_service, "move_left") then
				content.controller_on_release_left = true

				return true
			elseif input_service.get(input_service, "move_right") then
				content.controller_on_release_right = true

				return true
			end

			return 
		end,
		input_description = {
			name = "stepper",
			gamepad_support = true,
			actions = {
				{
					input_action = "d_horizontal",
					priority = 2,
					description_text = "input_description_change",
					ignore_keybinding = true
				}
			}
		}
	},
	slider = {
		input_function = function (widget, input_service, dt)
			local content = widget.content
			local input_cooldown = content.input_cooldown
			local input_cooldown_multiplier = content.input_cooldown_multiplier
			local on_cooldown_last_frame = false

			if input_cooldown then
				on_cooldown_last_frame = true
				local new_cooldown = math.max(input_cooldown - dt, 0)
				input_cooldown = (0 < new_cooldown and new_cooldown) or nil
				content.input_cooldown = input_cooldown
			end

			local internal_value = content.internal_value
			local num_decimals = content.num_decimals
			local min = content.min
			local max = content.max
			local diff = max - min
			local total_step = diff*10^num_decimals
			local step = total_step/1
			local input_been_made = false

			if input_service.get(input_service, "move_left_hold") then
				if not input_cooldown then
					content.internal_value = math.clamp(internal_value - step, 0, 1)
					input_been_made = true
				end
			elseif input_service.get(input_service, "move_right_hold") and not input_cooldown then
				content.internal_value = math.clamp(internal_value + step, 0, 1)
				input_been_made = true
			end

			if input_been_made then
				content.changed = true

				if on_cooldown_last_frame then
					input_cooldown_multiplier = math.max(input_cooldown_multiplier - 0.1, 0.1)
					content.input_cooldown = math.ease_in_exp(input_cooldown_multiplier)*0.2
					content.input_cooldown_multiplier = input_cooldown_multiplier
				else
					input_cooldown_multiplier = 1
					content.input_cooldown = math.ease_in_exp(input_cooldown_multiplier)*0.2
					content.input_cooldown_multiplier = input_cooldown_multiplier
				end

				return true
			end

			return 
		end,
		input_description = {
			name = "slider",
			gamepad_support = true,
			actions = {
				{
					input_action = "d_horizontal",
					priority = 2,
					description_text = "input_description_change",
					ignore_keybinding = true
				}
			}
		}
	},
	image = {
		input_function = function ()
			return 
		end,
		input_description = {
			name = "image",
			gamepad_support = true,
			actions = {}
		}
	},
	gamepad_layout = {
		input_function = function ()
			return 
		end,
		input_description = {
			name = "gamepad_layout",
			gamepad_support = true,
			actions = {}
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	background_widget_definitions = background_widget_definitions,
	gamepad_frame_widget_definitions = gamepad_frame_widget_definitions,
	widget_definitions = widget_definitions,
	button_definitions = button_definitions,
	scrollbar_definition = scrollbar_definition,
	create_checkbox_widget = create_checkbox_widget,
	create_slider_widget = create_slider_widget,
	create_drop_down_widget = create_drop_down_widget,
	create_stepper_widget = create_stepper_widget,
	create_keybind_widget = create_keybind_widget,
	create_simple_texture_widget = create_simple_texture_widget,
	create_gamepad_layout_widget = create_gamepad_layout_widget
}
