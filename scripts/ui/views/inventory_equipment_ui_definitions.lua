local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.default
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
		}
	},
	page_root = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			1,
			1
		}
	},
	window_background = {
		vertical_alignment = "center",
		parent = "page_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			592,
			902
		}
	},
	window_background_glow = {
		vertical_alignment = "center",
		parent = "window_background",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			-1
		},
		size = {
			622,
			936
		}
	},
	preview_foreground = {
		parent = "window_background",
		horizontal_alignment = "left",
		position = {
			22,
			22,
			3
		},
		size = {
			436,
			814
		}
	},
	preview_foreground_divider_1 = {
		vertical_alignment = "bottom",
		parent = "preview_foreground",
		horizontal_alignment = "center",
		position = {
			0,
			40,
			4
		},
		size = {
			436,
			16
		}
	},
	preview_viewport = {
		vertical_alignment = "top",
		parent = "preview_foreground",
		horizontal_alignment = "center",
		size = {
			417,
			750
		},
		position = {
			0,
			-10,
			-1
		}
	},
	preview_viewport_overlay = {
		vertical_alignment = "center",
		parent = "preview_viewport",
		horizontal_alignment = "center",
		size = {
			421,
			756
		},
		position = {
			1,
			0,
			1
		}
	},
	preview_viewport_loading = {
		vertical_alignment = "center",
		parent = "preview_viewport_overlay",
		horizontal_alignment = "center",
		size = {
			50,
			50
		},
		position = {
			0,
			0,
			1
		}
	},
	character_selection_bar = {
		vertical_alignment = "top",
		parent = "window_background",
		horizontal_alignment = "center",
		size = {
			580,
			40
		},
		position = {
			3,
			-9.5,
			1
		}
	},
	character_display_text = {
		vertical_alignment = "bottom",
		parent = "preview_foreground_divider_1",
		horizontal_alignment = "center",
		size = {
			400,
			40
		},
		position = {
			0,
			-30,
			1
		}
	},
	character_equipment_bar = {
		vertical_alignment = "center",
		parent = "preview_foreground",
		horizontal_alignment = "right",
		position = {
			126,
			70,
			1
		},
		size = {
			102,
			900
		}
	},
	gamepad_slot_selection = {
		vertical_alignment = "bottom",
		parent = "character_equipment_bar",
		horizontal_alignment = "left",
		position = {
			0,
			0,
			1
		},
		size = {
			110,
			110
		}
	}
}
local widget_definitions = {
	gamepad_slot_selection = UIWidgets.create_gamepad_selection("gamepad_slot_selection", nil, nil, {
		70,
		70
	}),
	preview_viewport_overlay = UIWidgets.create_simple_rect("preview_viewport_overlay", Colors.get_color_table_with_alpha("black", 0)),
	preview_viewport_loading = UIWidgets.create_simple_rotated_texture("matchmaking_connecting_icon", 0, {
		25,
		25
	}, "preview_viewport_loading"),
	rotate_left_button = {
		scenegraph_id = "character_selection_rotate_left_button",
		element = UIElements.DoubleTextureHoldButton,
		style = {
			background_texture = {},
			foreground_texture = {
				offset = {
					0,
					0,
					1
				}
			}
		},
		content = {
			button_hotspot = {},
			background_texture = {
				{
					"is_hover",
					"menu_inventory_screen_zoom_bg_selected"
				},
				{
					"menu_inventory_screen_zoom_bg_normal"
				}
			},
			foreground_texture = {
				{
					"is_held",
					"menu_inventory_screen_rotate_selected"
				},
				{
					"is_hover",
					"menu_inventory_screen_rotate_hover"
				},
				{
					"menu_inventory_screen_rotate_normal"
				}
			}
		}
	},
	rotate_right_button = {
		scenegraph_id = "character_selection_rotate_right_button",
		element = UIElements.DoubleTextureHoldButton,
		style = {
			background_texture = {},
			foreground_texture = {
				draw_function = "draw_texture_flip_horizontal",
				offset = {
					0,
					0,
					1
				}
			}
		},
		content = {
			background_texture = {
				{
					"is_hover",
					"menu_inventory_screen_zoom_bg_selected"
				},
				{
					"menu_inventory_screen_zoom_bg_normal"
				}
			},
			foreground_texture = {
				{
					"is_held",
					"menu_inventory_screen_rotate_selected"
				},
				{
					"is_hover",
					"menu_inventory_screen_rotate_hover"
				},
				{
					"menu_inventory_screen_rotate_normal"
				}
			},
			button_hotspot = {}
		}
	},
	zoom_in_button = {
		scenegraph_id = "character_selection_zoom_in",
		element = UIElements.DoubleTextureHoldButton,
		style = {
			background_texture = {},
			foreground_texture = {
				offset = {
					0,
					0,
					1
				}
			}
		},
		content = {
			button_hotspot = {},
			background_texture = {
				{
					"is_hover",
					"menu_inventory_screen_zoom_bg_selected"
				},
				{
					"menu_inventory_screen_zoom_bg_normal"
				}
			},
			foreground_texture = {
				{
					"is_held",
					"menu_inventory_screen_zoom_in_selected"
				},
				{
					"is_hover",
					"menu_inventory_screen_zoom_in_hover"
				},
				{
					"menu_inventory_screen_zoom_in_normal"
				}
			}
		}
	},
	zoom_out_button = {
		scenegraph_id = "character_selection_zoom_out",
		element = UIElements.DoubleTextureHoldButton,
		style = {
			background_texture = {},
			foreground_texture = {
				offset = {
					0,
					0,
					1
				}
			}
		},
		content = {
			button_hotspot = {},
			background_texture = {
				{
					"is_hover",
					"menu_inventory_screen_zoom_bg_selected"
				},
				{
					"menu_inventory_screen_zoom_bg_normal"
				}
			},
			foreground_texture = {
				{
					"is_held",
					"menu_inventory_screen_zoom_out_selected"
				},
				{
					"is_hover",
					"menu_inventory_screen_zoom_out_hover"
				},
				{
					"menu_inventory_screen_zoom_out_normal"
				}
			}
		}
	},
	preview_viewport = {
		scenegraph_id = "preview_viewport",
		element = UIElements.Viewport,
		style = {
			viewport = {
				layer = 985,
				level_name = "levels/ui_inventory_preview/world",
				viewport_name = "inventory_preview_viewport",
				world_name = "inventory_preview",
				camera_position = {
					0,
					3,
					1.4
				},
				camera_lookat = {
					0,
					0,
					1
				}
			}
		},
		content = {
			button_hotspot = {}
		}
	},
	character_display_text_widget = {
		scenegraph_id = "character_display_text",
		element = UIElements.StaticText,
		style = {
			text = {
				font_size = 28,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark_header",
				text_color = Colors.color_definitions.white,
				offset = {
					0,
					0,
					1
				}
			}
		},
		content = {
			text_field = "placeholder_text"
		}
	}
}

local function create_selection_bar(textures, icons, tooltips, offset, scenegraph_base, size, icon_size)
	local passes = {}
	local element = {
		passes = passes
	}
	local style = {}
	local content_data = {}

	assert(textures.texture_hover_id, "missing texture")
	assert(textures.texture_click_id, "missing texture")

	local widget = {
		style = style,
		content = content_data,
		element = element,
		scenegraph_id = scenegraph_base
	}
	local num_buttons = #icons

	for i = 1, num_buttons, 1 do
		local button_hotspot_name = i
		local tooltip_text = "tooltip_text_" .. i
		local button_style_name = string.format("button_style_%d", i)
		local button_disabled_style_name = string.format("button_disabled_style_%d", i)
		local button_click_style_name = string.format("button_click_style_%d", i)
		local icon_texture_id = string.format("icon_%d", i)
		local icon_click_texture_id = string.format("icon_click_%d", i)

		table.append_varargs(passes, {
			pass_type = "hotspot",
			content_id = button_hotspot_name,
			style_id = button_hotspot_name
		}, {
			pass_type = "texture",
			texture_id = button_click_style_name,
			style_id = button_click_style_name
		}, {
			pass_type = "texture",
			texture_id = button_disabled_style_name,
			style_id = button_disabled_style_name,
			content_check_function = function (content)
				return content[button_hotspot_name].disable_button
			end
		}, {
			pass_type = "texture",
			texture_id = button_style_name,
			style_id = button_style_name
		}, {
			pass_type = "texture",
			texture_id = icon_texture_id,
			style_id = icon_texture_id
		}, {
			pass_type = "texture",
			texture_id = icon_click_texture_id,
			style_id = icon_click_texture_id
		}, {
			pass_type = "tooltip_text",
			text_id = tooltip_text,
			style_id = tooltip_text,
			content_check_function = function (content)
				return content[button_hotspot_name].is_hover
			end
		})

		local scenegraph_id = string.format("%s_%d", scenegraph_base, i)
		scenegraph_definition[scenegraph_id] = {
			parent = (i == 1 and scenegraph_base) or string.format("%s_%d", scenegraph_base, i - 1),
			size = size,
			offset = (i ~= 1 and offset) or nil
		}
		local style_scenegraph_id = string.format("%s_icon_%d", scenegraph_base, i)
		scenegraph_definition[style_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = scenegraph_id,
			size = icon_size,
			offset = {
				0,
				0,
				5
			}
		}
		content_data[button_hotspot_name] = {}
		content_data[tooltip_text] = tooltips[i]
		content_data[button_style_name] = textures.texture_hover_id
		content_data[icon_texture_id] = icons[i].texture_hover_id
		content_data[button_click_style_name] = textures.texture_click_id
		content_data[button_disabled_style_name] = "tab_small_disabled_overlay"
		content_data[icon_click_texture_id] = icons[i].texture_click_id
		style[tooltip_text] = {
			font_size = 24,
			max_width = 500,
			localize = true,
			horizontal_alignment = "left",
			vertical_alignment = "top",
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			line_colors = {},
			offset = {
				0,
				0,
				250
			}
		}
		style[button_hotspot_name] = {
			scenegraph_id = scenegraph_id,
			size = {
				size[1] - 12,
				size[2] - 12
			},
			offset = {
				6,
				6,
				0
			}
		}
		style[button_style_name] = {
			scenegraph_id = scenegraph_id,
			color = {
				178.5,
				255,
				255,
				255
			},
			size = size
		}
		style[button_disabled_style_name] = {
			scenegraph_id = scenegraph_id,
			offset = {
				0,
				0,
				8
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = size
		}
		style[icon_texture_id] = {
			scenegraph_id = style_scenegraph_id,
			color = {
				178.5,
				255,
				255,
				255
			},
			size = icon_size
		}
		style[button_click_style_name] = {
			scenegraph_id = scenegraph_id,
			color = {
				0,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				1
			},
			size = size
		}
		style[icon_click_texture_id] = {
			scenegraph_id = style_scenegraph_id,
			color = {
				0,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				2
			},
			size = icon_size
		}
	end

	return widget
end

local function create_equipment_selection_bar(textures, icons, tooltips, offset, scenegraph_base, size, icon_size, item_size)
	local passes = {}
	local element = {
		passes = passes
	}
	local style = {}
	local content_data = {}

	assert(textures.texture_hover_id, "missing texture")
	assert(textures.texture_click_id, "missing texture")

	local widget = {
		style = style,
		content = content_data,
		element = element,
		scenegraph_id = scenegraph_base
	}
	local num_buttons = #icons

	for i = 1, num_buttons, 1 do
		local button_hotspot_name = i
		local tooltip_text = "tooltip_text_" .. i
		local button_style_name = string.format("button_style_%d", i)
		local drag_hover_style_name = string.format("drag_hover_style_%d", i)
		local icon_texture_id = string.format("icon_%d", i)
		local icon_background_texture_id = string.format("icon_background_%d", i)
		local item_texture_id = string.format("item_%d", i)
		local item_frame_texture_id = string.format("item_frame_%d", i)
		local locked_id = string.format("item_lock_%d", i)
		local locked_texture_id = string.format("item_lock_texture_%d", i)
		local locked_text_id = string.format("item_lock_text_%d", i)
		local button_click_style_name = string.format("button_click_style_%d", i)
		local icon_click_texture_id = string.format("icon_click_%d", i)
		local gamepad_selection_id = string.format("gamepad_selection_%d", i)

		table.append_varargs(passes, {
			pass_type = "hotspot",
			content_id = button_hotspot_name,
			style_id = button_style_name
		}, {
			pass_type = "texture",
			texture_id = button_click_style_name,
			style_id = button_click_style_name
		}, {
			pass_type = "texture",
			texture_id = button_style_name,
			style_id = button_style_name,
			content_check_function = function (ui_content)
				return not ui_content[button_hotspot_name].is_selected
			end
		}, {
			pass_type = "texture",
			texture_id = drag_hover_style_name,
			style_id = drag_hover_style_name
		}, {
			pass_type = "texture",
			texture_id = icon_background_texture_id,
			style_id = icon_background_texture_id
		}, {
			pass_type = "texture",
			texture_id = icon_texture_id,
			style_id = icon_texture_id
		}, {
			pass_type = "texture",
			texture_id = icon_click_texture_id,
			style_id = icon_click_texture_id
		}, {
			pass_type = "texture",
			texture_id = item_texture_id,
			style_id = item_texture_id,
			content_check_function = function (content)
				return content[item_texture_id]
			end
		}, {
			pass_type = "texture",
			texture_id = item_frame_texture_id,
			style_id = item_frame_texture_id,
			content_check_function = function (content)
				return content[item_texture_id]
			end
		}, {
			pass_type = "texture",
			texture_id = locked_texture_id,
			style_id = locked_texture_id,
			content_check_function = function (content)
				return content[locked_id]
			end
		}, {
			pass_type = "text",
			text_id = locked_text_id,
			style_id = locked_text_id,
			content_check_function = function (content)
				return content[locked_id]
			end
		}, {
			pass_type = "tooltip_text",
			text_id = tooltip_text,
			style_id = tooltip_text,
			content_check_function = function (content)
				return content[button_hotspot_name].is_hover
			end
		})

		local scenegraph_id = string.format("%s_%d", scenegraph_base, i)
		scenegraph_definition[scenegraph_id] = {
			parent = (i == 1 and scenegraph_base) or string.format("%s_%d", scenegraph_base, i - 1),
			size = size,
			offset = (i ~= 1 and offset) or nil
		}
		local style_scenegraph_id = string.format("%s_icon_%d", scenegraph_base, i)
		scenegraph_definition[style_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = scenegraph_id,
			size = icon_size,
			offset = {
				0,
				0,
				4
			}
		}
		local select_frame_scenegraph_id = string.format("%s_select_frame_%d", scenegraph_base, i)
		scenegraph_definition[select_frame_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = scenegraph_id,
			size = {
				78,
				79
			},
			position = {
				0,
				0,
				7
			}
		}
		local item_scenegraph_id = string.format("%s_item_%d", scenegraph_base, i)
		scenegraph_definition[item_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = scenegraph_id,
			size = item_size,
			offset = {
				0,
				0,
				6
			}
		}
		scenegraph_definition[icon_background_texture_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = scenegraph_id,
			size = {
				78,
				79
			},
			offset = {
				0,
				0,
				-1
			}
		}
		scenegraph_definition[drag_hover_style_name] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = icon_background_texture_id,
			size = {
				127,
				127
			},
			position = {
				0,
				0,
				-1
			}
		}
		scenegraph_definition[locked_texture_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = icon_background_texture_id,
			size = {
				30,
				38
			},
			position = {
				0,
				2,
				7
			}
		}
		scenegraph_definition[gamepad_selection_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = icon_background_texture_id,
			size = {
				120,
				117
			},
			position = {
				0,
				0,
				10
			}
		}
		content_data[button_hotspot_name] = {}
		content_data[tooltip_text] = tooltips[i]
		content_data[button_style_name] = textures.texture_hover_id
		content_data[button_click_style_name] = textures.texture_click_id
		content_data[icon_texture_id] = icons[i].texture_hover_id
		content_data[icon_click_texture_id] = icons[i].texture_click_id
		content_data[icon_background_texture_id] = "item_slot_03"
		content_data[item_frame_texture_id] = "frame_01"
		content_data[drag_hover_style_name] = "item_slot_drag"
		content_data[locked_texture_id] = "locked_icon_01"
		content_data[locked_text_id] = "10"
		content_data[locked_id] = false
		style[tooltip_text] = {
			font_size = 24,
			max_width = 500,
			localize = true,
			horizontal_alignment = "left",
			vertical_alignment = "top",
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			line_colors = {},
			offset = {
				0,
				0,
				250
			}
		}
		style[locked_text_id] = {
			vertical_alignment = "center",
			font_size = 18,
			horizontal_alignment = "right",
			word_wrap = false,
			font_type = "hell_shark",
			scenegraph_id = locked_texture_id,
			text_color = Colors.get_color_table_with_alpha("red", 255),
			offset = {
				15,
				-25,
				1
			}
		}
		style[locked_texture_id] = {
			scenegraph_id = locked_texture_id,
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
		style[button_style_name] = {
			scenegraph_id = icon_background_texture_id,
			color = {
				0,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				1
			}
		}
		style[icon_texture_id] = {
			scenegraph_id = style_scenegraph_id,
			color = {
				178.5,
				255,
				255,
				255
			},
			size = icon_size
		}
		style[icon_background_texture_id] = {
			scenegraph_id = icon_background_texture_id,
			color = {
				255,
				255,
				255,
				255
			}
		}
		style[button_click_style_name] = {
			scenegraph_id = select_frame_scenegraph_id,
			color = {
				0,
				255,
				255,
				255
			},
			size = {
				78,
				79
			},
			offset = {
				0,
				0,
				1
			}
		}
		style[icon_click_texture_id] = {
			scenegraph_id = style_scenegraph_id,
			color = {
				0,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				1
			},
			size = icon_size
		}
		style[drag_hover_style_name] = {
			color = {
				0,
				255,
				255,
				255
			},
			scenegraph_id = drag_hover_style_name
		}
		style[item_texture_id] = {
			scenegraph_id = item_scenegraph_id,
			offset = {
				0,
				0,
				0
			}
		}
		style[item_frame_texture_id] = {
			scenegraph_id = item_scenegraph_id,
			offset = {
				0,
				0,
				2
			}
		}
		style[gamepad_selection_id] = {
			texture_size = {
				60,
				60
			},
			scenegraph_id = gamepad_selection_id
		}
	end

	return widget
end

local character_selection_bar = create_selection_bar({
	texture_hover_id = "tab_hover",
	texture_click_id = "tab_selected",
	texture_id = "tab_normal"
}, {
	{
		texture_hover_id = "tabs_class_icon_witch_hunter_hover",
		texture_click_id = "tabs_class_icon_witch_hunter_selected",
		texture_id = "tabs_class_icon_witch_hunter_normal"
	},
	{
		texture_hover_id = "tabs_class_icon_way_watcher_hover",
		texture_click_id = "tabs_class_icon_way_watcher_selected",
		texture_id = "tabs_class_icon_way_watcher_normal"
	},
	{
		texture_hover_id = "tabs_class_icon_dwarf_ranger_hover",
		texture_click_id = "tabs_class_icon_dwarf_ranger_selected",
		texture_id = "tabs_class_icon_dwarf_ranger_normal"
	},
	{
		texture_hover_id = "tabs_class_icon_bright_wizard_hover",
		texture_click_id = "tabs_class_icon_bright_wizard_selected",
		texture_id = "tabs_class_icon_bright_wizard_normal"
	},
	{
		texture_hover_id = "tabs_class_icon_empire_soldier_hover",
		texture_click_id = "tabs_class_icon_empire_soldier_selected",
		texture_id = "tabs_class_icon_empire_soldier_normal"
	}
}, {
	"inventory_screen_witch_hunter_tooltip",
	"inventory_screen_way_watcher_tooltip",
	"inventory_screen_dwarf_tooltip",
	"inventory_screen_bright_wizard_tooltip",
	"inventory_screen_empire_soldier_tooltip"
}, {
	114,
	0,
	0
}, "character_selection_bar", {
	116,
	40
}, {
	34,
	34
})
local equipment_selection_bar_widget = create_equipment_selection_bar({
	texture_hover_id = "item_slot_hover",
	texture_click_id = "item_slot_selected"
}, {
	{
		texture_hover_id = "tabs_inventory_icon_trinkets_hover",
		texture_click_id = "tabs_inventory_icon_trinkets_selected",
		texture_id = "tabs_inventory_icon_trinkets_normal"
	},
	{
		texture_hover_id = "tabs_inventory_icon_trinkets_hover",
		texture_click_id = "tabs_inventory_icon_trinkets_selected",
		texture_id = "tabs_inventory_icon_trinkets_normal"
	},
	{
		texture_hover_id = "tabs_inventory_icon_trinkets_hover",
		texture_click_id = "tabs_inventory_icon_trinkets_selected",
		texture_id = "tabs_inventory_icon_trinkets_normal"
	},
	{
		texture_hover_id = "tabs_inventory_icon_ranged_hover",
		texture_click_id = "tabs_inventory_icon_ranged_selected",
		texture_id = "tabs_inventory_icon_ranged_normal"
	},
	{
		texture_hover_id = "tabs_inventory_icon_melee_hover",
		texture_click_id = "tabs_inventory_icon_melee_selected",
		texture_id = "tabs_inventory_icon_melee_normal"
	},
	{
		texture_hover_id = "tabs_inventory_icon_hats_hover",
		texture_click_id = "tabs_inventory_icon_hats_selected",
		texture_id = "tabs_inventory_icon_hats_normal"
	}
}, {
	"inventory_screen_trinket_1_tooltip",
	"inventory_screen_trinket_2_tooltip",
	"inventory_screen_trinket_3_tooltip",
	"inventory_screen_ranged_weapon_tooltip",
	"inventory_screen_melee_weapon_tooltip",
	"inventory_screen_hat_tooltip"
}, {
	0,
	136,
	0
}, "character_equipment_bar", {
	78,
	79
}, {
	34,
	34
}, {
	64,
	64
})
local simple_texture_template = {
	scenegraph_id = "",
	element = UIElements.SimpleTexture,
	content = {
		texture_id = ""
	},
	style = {}
}

local function create_simple_texture_widget(texture_id, scenegraph_id)
	simple_texture_template.content.texture_id = texture_id
	simple_texture_template.scenegraph_id = scenegraph_id

	return UIWidget.init(simple_texture_template)
end

return {
	scenegraph_definition = scenegraph_definition,
	widgets = widget_definitions,
	create_simple_texture_widget = create_simple_texture_widget,
	character_selection_bar_widget = character_selection_bar,
	equipment_selection_bar_widget = equipment_selection_bar_widget
}
