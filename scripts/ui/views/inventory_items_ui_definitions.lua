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
	item_type_display_text = {
		vertical_alignment = "top",
		parent = "window_background",
		horizontal_alignment = "center",
		position = {
			0,
			-15,
			1
		},
		size = {
			580,
			30
		}
	},
	inventory_selection_bar = {
		vertical_alignment = "top",
		parent = "window_background",
		horizontal_alignment = "center",
		size = {
			576,
			40
		},
		position = {
			3,
			-10,
			1
		}
	}
}
local widget_definitions = {
	item_type_display_text = {
		scenegraph_id = "item_type_display_text",
		element = UIElements.StaticText,
		style = {
			text = {
				vertical_alignment = "center",
				word_wrap = true,
				horizontal_alignment = "center",
				font_size = 32,
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
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
		local tooltip_text = "tooltip_text" .. i
		local button_style_name = string.format("button_style_%d", i)
		local button_click_style_name = string.format("button_click_style_%d", i)
		local icon_texture_id = string.format("icon_%d", i)
		local icon_click_texture_id = string.format("icon_click_%d", i)

		table.append_varargs(passes, {
			pass_type = "hotspot",
			content_id = button_hotspot_name,
			style_id = button_hotspot_name
		}, {
			pass_type = "on_click",
			click_check_content_id = button_hotspot_name,
			click_function = function (ui_scenegraph, ui_style, ui_content, input_service)
				for j = 1, num_buttons, 1 do
					ui_content[j].is_selected = false
				end

				ui_content[button_hotspot_name].is_selected = true

				return 
			end
		}, {
			pass_type = "texture",
			texture_id = button_click_style_name,
			style_id = button_click_style_name
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

local inventory_selection_bar_widget = create_selection_bar({
	texture_hover_id = "tab_hover",
	texture_click_id = "tab_selected",
	texture_id = "tab_normal"
}, {
	{
		texture_hover_id = "tabs_inventory_icon_melee_hover",
		texture_click_id = "tabs_inventory_icon_melee_selected",
		texture_id = "tabs_inventory_icon_melee_normal"
	},
	{
		texture_hover_id = "tabs_inventory_icon_ranged_hover",
		texture_click_id = "tabs_inventory_icon_ranged_selected",
		texture_id = "tabs_inventory_icon_ranged_normal"
	},
	{
		texture_hover_id = "tabs_inventory_icon_trinkets_hover",
		texture_click_id = "tabs_inventory_icon_trinkets_selected",
		texture_id = "tabs_inventory_icon_trinkets_normal"
	},
	{
		texture_hover_id = "tabs_inventory_icon_hats_hover",
		texture_click_id = "tabs_inventory_icon_hats_selected",
		texture_id = "tabs_inventory_icon_hats_normal"
	}
}, {
	"inventory_screen_melee_weapon_tooltip",
	"inventory_screen_ranged_weapon_tooltip",
	"inventory_screen_trinket_1_tooltip",
	"inventory_screen_hat_tooltip"
}, {
	142,
	0,
	0
}, "inventory_selection_bar", {
	144,
	40
}, {
	34,
	34
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
	widget_definitions = widget_definitions,
	create_simple_texture_widget = create_simple_texture_widget,
	inventory_selection_bar_widget = inventory_selection_bar_widget
}
