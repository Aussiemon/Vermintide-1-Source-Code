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
	left_frame = {
		vertical_alignment = "bottom",
		parent = "background",
		horizontal_alignment = "left",
		position = {
			266,
			110,
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
			915,
			0,
			2
		},
		size = {
			900,
			902
		}
	},
	left_frame_glow = {
		vertical_alignment = "center",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			-1
		},
		size = {
			402,
			941
		}
	},
	right_frame_glow = {
		vertical_alignment = "center",
		parent = "right_frame",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			-1
		},
		size = {
			939,
			942
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
			-30,
			2
		},
		size = {
			840,
			762
		}
	},
	scrollbar_root = {
		vertical_alignment = "center",
		parent = "list_mask",
		horizontal_alignment = "right",
		position = {
			24,
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
		parent = "right_frame",
		horizontal_alignment = "right",
		position = {
			-25,
			15,
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
	gameplay_settings_button = {
		vertical_alignment = "top",
		parent = "left_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-22,
			1
		},
		size = {
			318,
			84
		}
	},
	display_settings_button = {
		vertical_alignment = "top",
		parent = "gameplay_settings_button",
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
	video_settings_button = {
		vertical_alignment = "top",
		parent = "display_settings_button",
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
	sound_settings_button = {
		vertical_alignment = "top",
		parent = "video_settings_button",
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
	keybind_settings_button = {
		vertical_alignment = "top",
		parent = "sound_settings_button",
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
	gamepad_settings_button = {
		vertical_alignment = "top",
		parent = "keybind_settings_button",
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
	calibrate_ui_button = {
		vertical_alignment = "top",
		parent = "keybind_settings_button",
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
	left_frame_glow = UIWidgets.create_simple_texture("selected_window_glow_settings_01", "left_frame_glow"),
	right_frame_glow = UIWidgets.create_simple_texture("selected_window_glow_settings_02", "right_frame_glow"),
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
	left_frame = {
		scenegraph_id = "left_frame",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "settings_window_01"
		},
		style = {}
	},
	right_frame = {
		scenegraph_id = "right_frame",
		element = {
			passes = {
				{
					pass_type = "texture",
					texture_id = "texture_id"
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
			texture_id = "settings_window_02",
			internal_scroll_value = 0
		},
		style = {}
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
local title_button_definitions = {
	UIWidgets.create_menu_button("settings_view_gameplay", "gameplay_settings_button"),
	UIWidgets.create_menu_button("settings_view_display", "display_settings_button"),
	UIWidgets.create_menu_button("settings_view_video", "video_settings_button"),
	UIWidgets.create_menu_button("settings_view_sound", "sound_settings_button"),
	UIWidgets.create_menu_button("settings_view_keybind", "keybind_settings_button"),
	UIWidgets.create_menu_button("settings_view_gamepad", "gamepad_settings_button")
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

local SLIDER_WIDGET_SIZE = {
	795,
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
				font_size = 24,
				max_width = 600,
				localize = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
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
					base_offset[1] + 523,
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
					base_offset[1] + 523,
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
					base_offset[1] + 523 + 5,
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
					base_offset[1] + 523 + 255,
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
					base_offset[1] + 523 + 5,
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
					base_offset[1] + 523,
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
	795,
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
					base_offset[1] + 521 + 4,
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
				font_size = 24,
				max_width = 600,
				localize = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
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
					base_offset[1] + 521,
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
					base_offset[1] + 521 + 231,
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
					base_offset[1] + 521 + 8,
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
					base_offset[1] + 521 + 4,
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
					base_offset[1] + 521,
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
	795,
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
				font_size = 24,
				max_width = 600,
				localize = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
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
					base_offset[1] + 520,
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
					base_offset[1] + 520,
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
					base_offset[1] + 520,
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
					base_offset[1] + 750,
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
					base_offset[1] + 750,
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
					(base_offset[1] + 750) - 101,
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
					base_offset[1] + 650,
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
	795,
	50
}

local function create_keybind_widget(selected_key, keys, key_info, scenegraph_id, base_offset)
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
			text = keys[1],
			keys = keys,
			key_info = key_info,
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
					base_offset[1] + 650,
					base_offset[2] + 7,
					base_offset[3]
				},
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				hover_color = Colors.get_color_table_with_alpha("white", 255),
				default_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			selected_rect = {
				offset = {
					base_offset[1] + 635,
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

SettingsMenuNavigation = {
	"gameplay_settings",
	"display_settings",
	"video_settings",
	"audio_settings",
	"keybind_settings",
	"gamepad_settings"
}
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
					input_action = "d_vertical",
					priority = 1,
					description_text = "input_description_navigate",
					ignore_keybinding = true
				},
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
			local internal_value = content.internal_value
			local num_decimals = content.num_decimals
			local min = content.min
			local max = content.max
			local diff = max - min
			local total_step = diff*10^num_decimals
			local step = total_step/1

			if input_service.get(input_service, "move_left_hold") then
				content.changed = true
				content.internal_value = math.clamp(internal_value - step, 0, 1)

				return true
			elseif input_service.get(input_service, "move_right_hold") then
				content.changed = true
				content.internal_value = math.clamp(internal_value + step, 0, 1)

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
	}
}

local function assigned(a, b)
	if a == nil then
		return b
	else
		return a
	end

	return 
end

local function set_function(self, user_setting_name, content, value_set_function)
	local options_values = content.options_values
	local current_selection = content.current_selection
	local new_value = options_values[current_selection]
	self.changed_user_settings[user_setting_name] = new_value

	value_set_function(new_value)

	return 
end

local function setup_function(self, user_setting_name, options)
	local default_value = DefaultUserSettings.get("user_settings", user_setting_name)
	local current_value = Application.user_setting(user_setting_name)
	local selection, default_option = nil

	for index, option in ipairs(options) do
		local value = option.value

		if value == current_value then
			selection = index
		end

		if value == default_value then
			default_option = index
		end
	end

	fassert(default_option, "Default value %q for %q does not exist in passed options table", tostring(default_value), user_setting_name)

	selection = selection or default_option

	return selection, options, "menu_settings_" .. user_setting_name, default_option
end

local function saved_value_function(self, user_setting_name, widget)
	local saved_value = assigned(self.changed_user_settings[user_setting_name], Application.user_setting(user_setting_name))
	local default_value = DefaultUserSettings.get("user_settings", user_setting_name)

	if saved_value == nil then
		saved_value = default_value
	end

	local saved_index, default_index = nil
	local content = widget.content

	for index, value in pairs(content.options_values) do
		if value == saved_value then
			saved_index = index
		end

		if value == default_value then
			default_index = index
		end
	end

	content.current_selection = saved_index or default_index

	return 
end

local video_settings_definition = {
	{
		setup = "cb_graphics_quality_setup",
		name = "graphics_quality_settings",
		saved_value = "cb_graphics_quality_saved_value",
		callback = "cb_graphics_quality",
		tooltip_text = "tooltip_graphics_quality",
		widget_type = "stepper"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_char_texture_quality_setup",
		saved_value = "cb_char_texture_quality_saved_value",
		callback = "cb_char_texture_quality",
		tooltip_text = "tooltip_char_texture_quality",
		widget_type = "stepper"
	},
	{
		setup = "cb_env_texture_quality_setup",
		saved_value = "cb_env_texture_quality_saved_value",
		callback = "cb_env_texture_quality",
		tooltip_text = "tooltip_env_texture_quality",
		widget_type = "stepper"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_particles_resolution_setup",
		saved_value = "cb_particles_resolution_saved_value",
		callback = "cb_particles_resolution",
		tooltip_text = "tooltip_low_resolution_transparency",
		widget_type = "stepper"
	},
	{
		setup = "cb_particles_quality_setup",
		saved_value = "cb_particles_quality_saved_value",
		callback = "cb_particles_quality",
		tooltip_text = "tooltip_particle_quality",
		widget_type = "stepper"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_sun_shadows_setup",
		saved_value = "cb_sun_shadows_saved_value",
		callback = "cb_sun_shadows",
		tooltip_text = "tooltip_sun_shadows",
		widget_type = "stepper"
	},
	{
		setup = "cb_local_light_shadow_quality_setup",
		saved_value = "cb_local_light_shadow_quality_saved_value",
		callback = "cb_local_light_shadow_quality",
		tooltip_text = "tooltip_local_light_shadows",
		widget_type = "stepper"
	},
	{
		setup = "cb_maximum_shadow_casting_lights_setup",
		saved_value = "cb_maximum_shadow_casting_lights_saved_value",
		callback = "cb_maximum_shadow_casting_lights",
		tooltip_text = "tooltip_max_local_light_shadows",
		widget_type = "slider"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_animation_lod_distance_setup",
		saved_value = "cb_animation_lod_distance_saved_value",
		callback = "cb_animation_lod_distance",
		tooltip_text = "tooltip_animation_lod_distance",
		widget_type = "slider"
	},
	{
		setup = "cb_physic_debris_setup",
		saved_value = "cb_physic_debris_saved_value",
		callback = "cb_physic_debris",
		tooltip_text = "tooltip_physics_debris",
		widget_type = "stepper"
	},
	{
		setup = "cb_scatter_density_setup",
		saved_value = "cb_scatter_density_saved_value",
		callback = "cb_scatter_density",
		tooltip_text = "tooltip_scatter_density",
		widget_type = "stepper"
	},
	{
		setup = "cb_blood_decals_setup",
		saved_value = "cb_blood_decals_saved_value",
		callback = "cb_blood_decals",
		tooltip_text = "tooltip_blood_decals",
		widget_type = "slider"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_anti_aliasing_setup",
		saved_value = "cb_anti_aliasing_saved_value",
		callback = "cb_anti_aliasing",
		tooltip_text = "tooltip_anti_aliasing",
		widget_type = "drop_down"
	},
	{
		setup = "cb_motion_blur_setup",
		saved_value = "cb_motion_blur_saved_value",
		callback = "cb_motion_blur",
		tooltip_text = "tooltip_motion_blur",
		widget_type = "stepper"
	},
	{
		setup = "cb_ssao_setup",
		saved_value = "cb_ssao_saved_value",
		callback = "cb_ssao",
		tooltip_text = "tooltip_ssao",
		widget_type = "stepper"
	},
	{
		setup = "cb_ssr_setup",
		saved_value = "cb_ssr_saved_value",
		callback = "cb_ssr",
		tooltip_text = "tooltip_ssr",
		widget_type = "stepper"
	},
	{
		setup = "cb_dof_setup",
		saved_value = "cb_dof_saved_value",
		callback = "cb_dof",
		tooltip_text = "tooltip_dof",
		widget_type = "stepper"
	},
	{
		setup = "cb_bloom_setup",
		saved_value = "cb_bloom_saved_value",
		callback = "cb_bloom",
		tooltip_text = "tooltip_bloom",
		widget_type = "stepper"
	},
	{
		setup = "cb_light_shafts_setup",
		saved_value = "cb_light_shafts_saved_value",
		callback = "cb_light_shafts",
		tooltip_text = "tooltip_light_shafts",
		widget_type = "stepper"
	},
	{
		setup = "cb_skin_shading_setup",
		saved_value = "cb_skin_shading_saved_value",
		callback = "cb_skin_shading",
		tooltip_text = "tooltip_skin_shading",
		widget_type = "stepper"
	},
	{
		setup = "cb_high_quality_fur_setup",
		saved_value = "cb_high_quality_fur_saved_value",
		callback = "cb_high_quality_fur",
		tooltip_text = "tooltip_high_quality_fur",
		widget_type = "stepper"
	}
}
local audio_settings_definition = {
	{
		setup = "cb_master_volume_setup",
		saved_value = "cb_master_volume_saved_value",
		callback = "cb_master_volume",
		tooltip_text = "tooltip_master_volume",
		widget_type = "slider"
	},
	{
		setup = "cb_music_bus_volume_setup",
		saved_value = "cb_music_bus_volume_saved_value",
		callback = "cb_music_bus_volume",
		tooltip_text = "tooltip_music_volume",
		widget_type = "slider"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_voip_enabled_setup",
		saved_value = "cb_voip_enabled_saved_value",
		callback = "cb_voip_enabled",
		tooltip_text = "tooltip_voip_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_voip_push_to_talk_setup",
		saved_value = "cb_voip_push_to_talk_saved_value",
		callback = "cb_voip_push_to_talk",
		tooltip_text = "tooltip_voip_push_to_talk",
		widget_type = "stepper"
	},
	{
		setup = "cb_voip_bus_volume_setup",
		saved_value = "cb_voip_bus_volume_saved_value",
		callback = "cb_voip_bus_volume",
		tooltip_text = "tooltip_voip_volume",
		widget_type = "slider"
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_subtitles_setup",
		saved_value = "cb_subtitles_saved_value",
		callback = "cb_subtitles",
		tooltip_text = "tooltip_subtitles",
		widget_type = "stepper"
	},
	{
		setup = "cb_sound_quality_setup",
		saved_value = "cb_sound_quality_saved_value",
		callback = "cb_sound_quality",
		tooltip_text = "tooltip_sound_quality",
		widget_type = "stepper"
	},
	{
		setup = "cb_dynamic_range_sound_setup",
		saved_value = "cb_dynamic_range_sound_saved_value",
		callback = "cb_dynamic_range_sound",
		tooltip_text = "tooltip_dynamic_range_sound",
		widget_type = "stepper"
	},
	{
		setup = "cb_sound_panning_rule_setup",
		saved_value = "cb_sound_panning_rule_saved_value",
		callback = "cb_sound_panning_rule",
		tooltip_text = "tooltip_panning_rule",
		widget_type = "stepper"
	}
}
local gameplay_settings_definition = {
	{
		setup = "cb_mouse_look_invert_y_setup",
		saved_value = "cb_mouse_look_invert_y_saved_value",
		callback = "cb_mouse_look_invert_y",
		tooltip_text = "tooltip_mouselook_invert_y",
		widget_type = "stepper"
	},
	{
		setup = "cb_mouse_look_sensitivity_setup",
		saved_value = "cb_mouse_look_sensitivity_saved_value",
		callback = "cb_mouse_look_sensitivity",
		tooltip_text = "tooltip_mouselook_sensitivity",
		widget_type = "slider"
	},
	{
		setup = "cb_weapon_scroll_type_setup",
		saved_value = "cb_weapon_scroll_type_saved_value",
		callback = "cb_weapon_scroll_type",
		tooltip_text = "tooltip_weapon_scroll_type",
		widget_type = "stepper"
	},
	{
		setup = "cb_dodge_on_jump_key_setup",
		saved_value = "cb_dodge_on_jump_key_saved_value",
		callback = "cb_dodge_on_jump_key",
		tooltip_text = "tooltip_dodge_on_jump_key",
		widget_type = "stepper"
	},
	{
		setup = "cb_dodge_on_forward_diagonal_setup",
		saved_value = "cb_dodge_on_forward_diagonal_saved_value",
		callback = "cb_dodge_on_forward_diagonal",
		tooltip_text = "tooltip_dodge_on_forward_diagonal",
		widget_type = "stepper"
	},
	{
		setup = "cb_double_tap_dodge_setup",
		saved_value = "cb_double_tap_dodge_saved_value",
		callback = "cb_double_tap_dodge",
		tooltip_text = "tooltip_double_tap_dodge",
		widget_type = "stepper"
	},
	{
		setting_name = "disable_intro_cinematic",
		widget_type = "stepper",
		options = {
			{
				value = true,
				text = Localize("menu_settings_on")
			},
			{
				value = false,
				text = Localize("menu_settings_off")
			}
		}
	},
	{
		setting_name = "disable_head_bob",
		widget_type = "stepper",
		options = {
			{
				value = true,
				text = Localize("menu_settings_on")
			},
			{
				value = false,
				text = Localize("menu_settings_off")
			}
		}
	},
	{
		setting_name = "disable_camera_shake",
		widget_type = "stepper",
		options = {
			{
				value = true,
				text = Localize("menu_settings_on")
			},
			{
				value = false,
				text = Localize("menu_settings_off")
			}
		}
	},
	{
		setup = "cb_max_upload_speed_setup",
		saved_value = "cb_max_upload_speed_saved_value",
		callback = "cb_max_upload_speed",
		tooltip_text = "tooltip_max_upload_speed",
		widget_type = "drop_down"
	},
	{
		setup = "cb_tutorials_enabled_setup",
		saved_value = "cb_tutorials_enabled_saved_value",
		callback = "cb_tutorials_enabled",
		tooltip_text = "tooltip_tutorials_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_player_outlines_setup",
		saved_value = "cb_player_outlines_saved_value",
		callback = "cb_player_outlines",
		tooltip_text = "tooltip_outlines",
		widget_type = "stepper"
	},
	{
		setup = "cb_fov_setup",
		saved_value = "cb_fov_saved_value",
		callback = "cb_fov",
		tooltip_text = "tooltip_fov",
		widget_type = "slider"
	},
	{
		setup = "cb_blood_enabled_setup",
		saved_value = "cb_blood_enabled_saved_value",
		callback = "cb_blood_enabled",
		tooltip_text = "tooltip_blood_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_chat_enabled_setup",
		saved_value = "cb_chat_enabled_saved_value",
		callback = "cb_chat_enabled",
		tooltip_text = "tooltip_chat_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_chat_font_size_setup",
		saved_value = "cb_chat_font_size_saved_value",
		callback = "cb_chat_font_size",
		tooltip_text = "tooltip_chat_font_size",
		widget_type = "drop_down"
	},
	{
		setup = "cb_toggle_crouch_setup",
		saved_value = "cb_toggle_crouch_saved_value",
		callback = "cb_toggle_crouch",
		tooltip_text = "tooltip_toggle_crouch",
		widget_type = "stepper"
	},
	{
		setup = "cb_overcharge_opacity_setup",
		saved_value = "cb_overcharge_opacity_saved_value",
		callback = "cb_overcharge_opacity",
		tooltip_text = "tooltip_overcharge_opacity",
		widget_type = "slider"
	}
}

for _, definition in pairs(gameplay_settings_definition) do
	local setting_name = definition.setting_name

	if setting_name then
		local prefix = "cb_" .. setting_name
		local callback_name = prefix
		definition.callback = prefix
		OptionsView[callback_name] = function (self, content)
			return set_function(self, setting_name, content, definition.value_set_function or function ()
				return 
			end)
		end
		local setup_function_name = prefix .. "_setup"
		definition.setup = setup_function_name
		OptionsView[setup_function_name] = function (self)
			return setup_function(self, setting_name, definition.options)
		end
		local saved_value_function_name = prefix .. "_saved_value"
		definition.saved_value = saved_value_function_name
		OptionsView[saved_value_function_name] = function (self, widget)
			return saved_value_function(self, setting_name, widget)
		end
		definition.tooltip_text = "tooltip_" .. setting_name
	end
end

if rawget(_G, "Steam") then
	gameplay_settings_definition[#gameplay_settings_definition + 1] = {
		setup = "cb_clan_tag_setup",
		saved_value = "cb_clan_tag_saved_value",
		callback = "cb_clan_tag",
		tooltip_text = "tooltip_clan_tag",
		widget_type = "stepper"
	}
end

if rawget(_G, "LightFX") then
	gameplay_settings_definition[#gameplay_settings_definition + 1] = {
		setup = "cb_alien_fx_setup",
		saved_value = "cb_alien_fx_saved_value",
		callback = "cb_alien_fx",
		tooltip_text = "tooltip_alien_fx",
		widget_type = "stepper"
	}
end

local display_settings_definition = {
	{
		setup = "cb_resolutions_setup",
		name = "resolutions",
		saved_value = "cb_resolutions_saved_value",
		callback = "cb_resolutions",
		tooltip_text = "tooltip_resolutions",
		widget_type = "drop_down"
	},
	{
		setup = "cb_fullscreen_setup",
		saved_value = "cb_fullscreen_saved_value",
		callback = "cb_fullscreen",
		tooltip_text = "tooltip_screen_mode",
		widget_type = "drop_down"
	},
	{
		setup = "cb_hud_screen_fit_setup",
		saved_value = "cb_hud_screen_fit_saved_value",
		callback = "cb_hud_screen_fit",
		tooltip_text = "tooltip_hud_screen_fit",
		widget_type = "stepper"
	},
	{
		setup = "cb_vsync_setup",
		saved_value = "cb_vsync_saved_value",
		callback = "cb_vsync",
		tooltip_text = "tooltip_vsync",
		widget_type = "stepper"
	},
	{
		setup = "cb_lock_framerate_setup",
		saved_value = "cb_lock_framerate_saved_value",
		callback = "cb_lock_framerate",
		tooltip_text = "tooltip_lock_framerate",
		widget_type = "stepper"
	},
	{
		setup = "cb_max_stacking_frames_setup",
		saved_value = "cb_max_stacking_frames_saved_value",
		callback = "cb_max_stacking_frames",
		tooltip_text = "tooltip_max_stacking_frames",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamma_setup",
		saved_value = "cb_gamma_saved_value",
		callback = "cb_gamma",
		tooltip_text = "tooltip_gamma",
		widget_type = "slider",
		slider_image = {
			slider_image = "settings_debug_gamma_correction",
			size = {
				879,
				512
			}
		}
	}
}
local keybind_settings_definition = {
	{
		widget_type = "keybind",
		keys = {
			"move_forward",
			"move_forward_pressed"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"move_left",
			"move_left_pressed"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"move_back",
			"move_back_pressed"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"move_right",
			"move_right_pressed"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"action_one",
			"action_one_hold",
			"action_one_release",
			"action_one_mouse"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"action_two",
			"action_two_hold",
			"action_two_release"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"action_three",
			"action_three_hold",
			"action_three_release"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"weapon_reload",
			"weapon_reload_hold"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"jump",
			"dodge_left",
			"dodge_right",
			"dodge_back",
			"dodge_hold"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"dodge"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"crouch",
			"crouching"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"walk"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"interact",
			"interacting"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"wield_1"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"wield_2"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"wield_3"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"wield_4"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"wield_5"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"wield_switch"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"wield_next"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"wield_prev"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"character_inspecting"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"action_inspect",
			"action_inspect_hold",
			"action_inspect_release"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"ping"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"ingame_vote_yes"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"ingame_vote_no"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"action_instant_heal_self",
			"action_instant_heal_self_hold"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"action_instant_grenade_throw",
			"action_instant_grenade_throw_hold",
			"action_instant_grenade_throw_released"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		input_service_name = "ingame_menu",
		widget_type = "keybind",
		keys = {
			"hotkey_map"
		}
	},
	{
		input_service_name = "ingame_menu",
		widget_type = "keybind",
		keys = {
			"hotkey_inventory"
		}
	},
	{
		input_service_name = "ingame_menu",
		widget_type = "keybind",
		keys = {
			"hotkey_forge"
		}
	},
	{
		input_service_name = "ingame_menu",
		widget_type = "keybind",
		keys = {
			"hotkey_lobby_browser"
		}
	},
	{
		input_service_name = "ingame_menu",
		widget_type = "keybind",
		keys = {
			"hotkey_altar"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		input_service_name = "ingame_menu",
		widget_type = "keybind",
		keys = {
			"matchmaking_ready"
		}
	},
	{
		input_service_name = "ingame_menu",
		widget_type = "keybind",
		keys = {
			"matchmaking_start"
		}
	},
	{
		input_service_name = "ingame_menu",
		widget_type = "keybind",
		keys = {
			"cancel_matchmaking"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		widget_type = "keybind",
		keys = {
			"toggle_input_helper"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		input_service_name = "player_list_input",
		widget_type = "keybind",
		keys = {
			"ingame_player_list_pressed",
			"ingame_player_list_held",
			"ingame_player_list_exit"
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		input_service_name = "chat_input",
		widget_type = "keybind",
		keys = {
			"activate_chat_input"
		}
	},
	{
		input_service_name = "chat_input",
		widget_type = "keybind",
		keys = {
			"execute_chat_input"
		}
	},
	{
		widget_type = "keybind",
		keys = {
			"voip_push_to_talk"
		}
	}
}

for i, keybind_setting in ipairs(keybind_settings_definition) do
	if not keybind_setting.input_service_name then
		keybind_setting.input_service_name = "Player"
	end
end

local ignore_keybind = {
	scroll_axis = true,
	wield_scroll = true,
	look_raw = true,
	cursor = true
}
local gamepad_settings_definition = {
	{
		image = "temp_controller",
		widget_type = "image",
		image_size = {
			808,
			544
		}
	},
	{
		size_y = 50,
		widget_type = "empty"
	},
	{
		setup = "cb_gamepad_look_invert_y_setup",
		saved_value = "cb_gamepad_look_invert_y_saved_value",
		callback = "cb_gamepad_look_invert_y",
		tooltip_text = "tooltip_gamepad_invert_y",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamepad_look_sensitivity_setup",
		saved_value = "cb_gamepad_look_sensitivity_saved_value",
		callback = "cb_gamepad_look_sensitivity",
		tooltip_text = "tooltip_gamepad_look_sensitivity",
		widget_type = "slider"
	},
	{
		setup = "cb_gamepad_zoom_sensitivity_setup",
		saved_value = "cb_gamepad_zoom_sensitivity_saved_value",
		callback = "cb_gamepad_zoom_sensitivity",
		tooltip_text = "tooltip_gamepad_zoom_sensitivity",
		widget_type = "slider"
	},
	{
		setup = "cb_gamepad_auto_aim_enabled_setup",
		saved_value = "cb_gamepad_auto_aim_enabled_saved_value",
		callback = "cb_gamepad_auto_aim_enabled",
		tooltip_text = "tooltip_gamepad_auto_aim_enabled",
		widget_type = "stepper"
	},
	{
		setup = "cb_gamepad_use_ps4_style_input_icons_setup",
		saved_value = "cb_gamepad_use_ps4_style_input_icons_saved_value",
		callback = "cb_gamepad_use_ps4_style_input_icons",
		tooltip_text = "tooltip_gamepad_use_ps4_style_input_icons",
		widget_type = "stepper"
	}
}
local needs_reload_settings = {
	"screen_resolution",
	"fullscreen",
	"borderless_fullscreen",
	"vsync",
	"gamma",
	"bloom_enabled",
	"light_shaft_enabled",
	"skin_material_enabled",
	"char_texture_quality",
	"env_texture_quality",
	"particles_quality",
	"sun_shadows",
	"sun_shadow_quality",
	"fxaa_enabled",
	"taa_enabled",
	"graphics_quality",
	"adapter_index",
	"use_physic_debris",
	"max_shadow_casting_lights",
	"local_light_shadow_quality",
	"lod_object_multiplier",
	"lod_scatter_density",
	"dof_enabled",
	"bloom_enabled",
	"ssr_enabled",
	"ssr_high_quality",
	"low_res_transparency"
}
local needs_restart_settings = {
	"char_texture_quality",
	"env_texture_quality",
	"use_physic_debris"
}

return {
	scenegraph_definition = scenegraph_definition,
	background_widget_definitions = background_widget_definitions,
	gamepad_frame_widget_definitions = gamepad_frame_widget_definitions,
	widget_definitions = widget_definitions,
	title_button_definitions = title_button_definitions,
	button_definitions = button_definitions,
	scrollbar_definition = scrollbar_definition,
	video_settings_definition = video_settings_definition,
	audio_settings_definition = audio_settings_definition,
	gameplay_settings_definition = gameplay_settings_definition,
	display_settings_definition = display_settings_definition,
	keybind_settings_definition = keybind_settings_definition,
	gamepad_settings_definition = gamepad_settings_definition,
	needs_restart_settings = needs_restart_settings,
	needs_reload_settings = needs_reload_settings,
	ignore_keybind = ignore_keybind,
	create_checkbox_widget = create_checkbox_widget,
	create_slider_widget = create_slider_widget,
	create_drop_down_widget = create_drop_down_widget,
	create_stepper_widget = create_stepper_widget,
	create_keybind_widget = create_keybind_widget,
	create_simple_texture_widget = create_simple_texture_widget
}
