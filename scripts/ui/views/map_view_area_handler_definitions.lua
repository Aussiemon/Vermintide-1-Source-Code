require("scripts/settings/ui_settings")

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
	screen = {
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
	menu_map = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "right",
		size = {
			1374,
			767
		},
		position = {
			-46,
			-56.5,
			3
		}
	},
	map_overlay = {
		vertical_alignment = "center",
		parent = "menu_map",
		horizontal_alignment = "center",
		size = {
			1374,
			767
		},
		position = {
			0,
			0,
			20
		}
	},
	back_button = {
		vertical_alignment = "bottom",
		parent = "menu_map",
		horizontal_alignment = "left",
		size = {
			84,
			84
		},
		position = {
			25,
			23,
			1
		}
	}
}
local level_element_definition = {
	passes = {
		{
			pass_type = "hotspot",
			content_id = "button_hotspot",
			content_check_function = function (content)
				return not content.is_preview
			end
		},
		{
			click_check_content_id = "button_hotspot",
			pass_type = "on_click",
			content_check_function = function (content)
				return not content.is_preview
			end,
			click_function = function (ui_scenegraph, ui_style, ui_content, input_service)
				ui_content.button_hotspot.is_selected = true

				return 
			end
		},
		{
			pass_type = "texture",
			style_id = "background",
			texture_id = "background",
			content_check_function = function (content)
				return not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "level_icon",
			texture_id = "level_icon",
			content_check_function = function (content)
				return not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "selected",
			texture_id = "selected",
			content_check_function = function (content)
				return not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "hover",
			texture_id = "hover",
			content_check_function = function (content)
				return not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "tiled_texture",
			style_id = "text_background_center",
			texture_id = "text_background_center",
			content_check_function = function (content)
				return not content.is_new and not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "text_background_left",
			texture_id = "text_background_left",
			content_check_function = function (content)
				return not content.is_new and not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "text_background_right",
			texture_id = "text_background_right",
			content_check_function = function (content)
				return not content.is_new and not content.button_hotspot.is_preview
			end
		},
		{
			style_id = "title_text",
			pass_type = "text",
			text_id = "title_text",
			content_check_function = function (content)
				return not content.is_new and not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "new_background",
			texture_id = "new_background",
			content_check_function = function (content)
				return content.is_new and not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "new_flag",
			texture_id = "new_flag",
			content_check_function = function (content)
				return content.is_new and not content.button_hotspot.is_preview
			end
		},
		{
			pass_type = "hotspot",
			content_id = "preview_hotspot",
			content_check_function = function (content)
				return content.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "preview_texture",
			texture_id = "preview_texture",
			content_check_function = function (content)
				return content.button_hotspot.is_preview and not content.preview_hotspot.is_hover
			end
		},
		{
			pass_type = "texture",
			style_id = "preview_texture_hover",
			texture_id = "preview_texture",
			content_check_function = function (content)
				return content.button_hotspot.is_preview and content.preview_hotspot.is_hover
			end
		},
		{
			style_id = "preview_tooltip",
			pass_type = "tooltip_text",
			text_id = "preview_tooltip",
			content_check_function = function (content)
				return content.button_hotspot.is_preview and content.preview_hotspot.is_hover
			end
		}
	}
}
local area_element_definition_drachenfels = {
	passes = {
		{
			pass_type = "hotspot",
			content_id = "button_hotspot"
		},
		{
			click_check_content_id = "button_hotspot",
			pass_type = "on_click",
			content_check_function = function (content)
				return not content.button_hotspot.is_preview
			end,
			click_function = function (ui_scenegraph, ui_style, ui_content, input_service)
				ui_content.button_hotspot.is_selected = true

				return 
			end
		},
		{
			pass_type = "hotspot",
			content_id = "preview_hotspot",
			content_check_function = function (content)
				return content and content.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "background",
			texture_id = "background"
		},
		{
			pass_type = "texture",
			style_id = "hover",
			texture_id = "hover"
		},
		{
			pass_type = "texture",
			style_id = "front_texture",
			texture_id = "front_texture"
		},
		{
			pass_type = "texture",
			style_id = "skull_eye",
			texture_id = "skull_eye"
		},
		{
			pass_type = "texture",
			style_id = "glass",
			texture_id = "glass"
		},
		{
			style_id = "banner",
			pass_type = "texture_uv",
			content_id = "banner"
		}
	}
}
local area_element_definition_ubersreik = {
	passes = {
		{
			pass_type = "hotspot",
			content_id = "button_hotspot"
		},
		{
			click_check_content_id = "button_hotspot",
			pass_type = "on_click",
			content_check_function = function (content)
				return not content.button_hotspot.is_preview
			end,
			click_function = function (ui_scenegraph, ui_style, ui_content, input_service)
				ui_content.button_hotspot.is_selected = true

				return 
			end
		},
		{
			pass_type = "hotspot",
			content_id = "preview_hotspot",
			content_check_function = function (content)
				return content and content.is_preview
			end
		},
		{
			pass_type = "texture",
			style_id = "background",
			texture_id = "background"
		},
		{
			pass_type = "texture",
			style_id = "hover",
			texture_id = "hover"
		},
		{
			style_id = "banner",
			pass_type = "texture_uv",
			content_id = "banner"
		}
	}
}

local function add_level_location_difficulty_definitions(passes, style, content, is_area, optional_parent_scenegraph_id)
	local difficulties = DefaultDifficulties
	local num_difficulties = #difficulties
	local max_num_difficulties = 5
	local even_amount_of_difficulties = num_difficulties%2 == 0
	local predefined_styles = {
		{
			size = (is_area and {
				20,
				20
			}) or {
				21,
				50
			},
			offset = (is_area and {
				14,
				100,
				5
			}) or {
				3,
				-1,
				5
			},
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = optional_parent_scenegraph_id
		},
		{
			size = (is_area and {
				20,
				20
			}) or {
				21,
				50
			},
			offset = (is_area and {
				14,
				80,
				5
			}) or {
				16,
				-15,
				7
			},
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = optional_parent_scenegraph_id
		},
		{
			size = (is_area and {
				20,
				20
			}) or {
				21,
				50
			},
			offset = (is_area and {
				14,
				60,
				5
			}) or {
				34,
				-22,
				9
			},
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = optional_parent_scenegraph_id
		},
		{
			size = (is_area and {
				20,
				20
			}) or {
				21,
				50
			},
			offset = (is_area and {
				14,
				40,
				5
			}) or {
				52,
				-15,
				8
			},
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = optional_parent_scenegraph_id
		},
		{
			size = (is_area and {
				20,
				20
			}) or {
				21,
				50
			},
			offset = (is_area and {
				14,
				20,
				5
			}) or {
				65,
				-1,
				6
			},
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = optional_parent_scenegraph_id
		}
	}
	local center_index = math.ceil(max_num_difficulties/2)
	local index = center_index - math.floor(num_difficulties/2)

	for i = 1, num_difficulties, 1 do
		local style_index = index

		if center_index <= index and even_amount_of_difficulties then
			style_index = index + 1
		end

		local style_name = string.format("%s%d", "difficulty_icon_", i)
		style[style_name] = predefined_styles[style_index]
		content[style_name] = "difficulty_icon_small_locked"
		passes[#passes + 1] = {
			pass_type = "texture",
			texture_id = style_name,
			style_id = style_name,
			content_check_function = function (content)
				return not content.is_new and not content.button_hotspot.is_preview
			end
		}
		index = index + 1
	end

	return 
end

local game_mode_level_area_textures = {
	adventure = {
		background = "level_location_bg_01",
		locked = "level_location_icon_03",
		hover = "level_location_bg_01_hover",
		selected = "level_location_selected",
		new = "level_location_icon_01_unlocked",
		icon = "level_location_any_icon",
		difficulty_icons = {}
	},
	survival = {
		background = "level_location_bg_03",
		locked = "level_location_icon_03",
		hover = "level_location_bg_03_hover",
		selected = "level_location_selected",
		new = "level_location_icon_01_unlocked",
		icon = "level_location_any_icon",
		difficulty_icons = {}
	}
}
game_mode_level_area_textures.adventure.difficulty_icons[1] = "difficulty_icon_small_01"
game_mode_level_area_textures.adventure.difficulty_icons[2] = "difficulty_icon_small_01"
game_mode_level_area_textures.adventure.difficulty_icons[3] = "difficulty_icon_small_01"
game_mode_level_area_textures.adventure.difficulty_icons[4] = "difficulty_icon_small_01"
game_mode_level_area_textures.adventure.difficulty_icons[5] = "difficulty_icon_small_01"
game_mode_level_area_textures.adventure.difficulty_icons.locked = "difficulty_icon_small_locked"
game_mode_level_area_textures.adventure.difficulty_icons.unlocked = "difficulty_icon_small_02"
game_mode_level_area_textures.survival.difficulty_icons[3] = "difficulty_icon_small_01"
game_mode_level_area_textures.survival.difficulty_icons[4] = "difficulty_icon_small_01"
game_mode_level_area_textures.survival.difficulty_icons[5] = "difficulty_icon_small_01"
game_mode_level_area_textures.survival.difficulty_icons.locked = "difficulty_icon_small_locked"
game_mode_level_area_textures.survival.difficulty_icons.unlocked = "difficulty_icon_small_02"

local function create_level_widget(index)
	local textures = game_mode_level_area_textures.adventure
	local background_texture = textures.background
	local selected_texture = textures.selected
	local locked_texture = textures.locked
	local hover_texture = textures.hover
	local icon_texture = textures.icon
	local new_texture = textures.new
	local scenegraph_id = string.format("%s%s", "level_location_", index)
	local background_scenegraph_id = string.format("%s%s", "background_level_location_", index)
	local text_background_root_scenegraph_id = string.format("%s%s", "text_background_root_level_location_", index)
	local text_background_left_scenegraph_id = string.format("%s%s", "text_background_left_level_location_", index)
	local text_background_right_scenegraph_id = string.format("%s%s", "text_background_right_level_location_", index)
	local text_background_center_scenegraph_id = string.format("%s%s", "text_background_center_level_location_", index)
	local selected_scenegraph_id = string.format("%s%s", "selected_level_location_", index)
	local hover_scenegraph_id = string.format("%s%s", "hover_level_location_", index)
	local widget_scenegraph_definition = scenegraph_definition[scenegraph_id]

	if not widget_scenegraph_definition then
		scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "center",
			parent = "menu_map",
			horizontal_alignment = "center",
			position = {
				0,
				0,
				5
			},
			size = {
				90,
				100
			}
		}
	end

	if not scenegraph_definition[background_scenegraph_id] then
		scenegraph_definition[background_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				90,
				100
			},
			position = {
				0,
				0,
				2
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[selected_scenegraph_id] then
		scenegraph_definition[selected_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				149,
				158
			},
			position = {
				-4,
				8,
				-1
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[hover_scenegraph_id] then
		scenegraph_definition[hover_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				110,
				120
			},
			position = {
				0,
				0,
				3
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[text_background_root_scenegraph_id] then
		scenegraph_definition[text_background_root_scenegraph_id] = {
			vertical_alignment = "top",
			horizontal_alignment = "center",
			parent = background_scenegraph_id,
			position = {
				-2,
				16,
				2
			},
			size = {
				1,
				1
			}
		}
	end

	if not scenegraph_definition[text_background_center_scenegraph_id] then
		scenegraph_definition[text_background_center_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				26,
				35
			},
			position = {
				0,
				0,
				2
			},
			parent = text_background_root_scenegraph_id
		}
	end

	if not scenegraph_definition[text_background_left_scenegraph_id] then
		scenegraph_definition[text_background_left_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			size = {
				58,
				43
			},
			position = {
				-58,
				-4,
				0
			},
			parent = text_background_center_scenegraph_id
		}
	end

	if not scenegraph_definition[text_background_right_scenegraph_id] then
		scenegraph_definition[text_background_right_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "right",
			size = {
				58,
				43
			},
			position = {
				58,
				-4,
				0
			},
			parent = text_background_center_scenegraph_id
		}
	end

	local element = table.clone(level_element_definition)
	local passes = element.passes
	local content = {
		is_new = false,
		locked_dlc = false,
		text_background_left = "level_title_banner_left",
		preview_tooltip = "n/a",
		text_background_right = "level_title_banner_right",
		text_background_center = "level_title_banner_middle",
		preview_texture = "level_location_icon_03",
		new_flag = "level_location_unlocked_text",
		preview_hotspot = {
			is_preview = false
		},
		button_hotspot = {
			is_preview = false
		},
		background = background_texture,
		new_background = new_texture,
		selected = selected_texture,
		level_icon = icon_texture,
		hover = hover_texture,
		title_text = index
	}
	local style = {
		preview_tooltip = {
			vertical_alignment = "top",
			font_type = "hell_shark",
			horizontal_alignment = "left",
			font_size = 24,
			max_width = 500,
			cursor_offset = {
				25,
				15
			},
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				50
			}
		},
		level_icon = {
			size = {
				42,
				45
			},
			offset = {
				23,
				38,
				4
			}
		},
		preview_texture = {
			offset = {
				-1,
				1,
				5
			},
			color = {
				150,
				255,
				255,
				255
			},
			size = {
				85,
				92
			}
		},
		preview_texture_hover = {
			offset = {
				-1,
				1,
				6
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				85,
				92
			}
		},
		new_background = {
			offset = {
				0,
				0,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		new_flag = {
			size = {
				81,
				18
			},
			offset = {
				5,
				50,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		background = {
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = background_scenegraph_id
		},
		selected = {
			color = {
				0,
				255,
				211,
				109
			},
			scenegraph_id = selected_scenegraph_id
		},
		hover = {
			color = {
				0,
				255,
				255,
				255
			},
			scenegraph_id = hover_scenegraph_id
		},
		text_background_left = {
			color = {
				0,
				255,
				255,
				255
			},
			scenegraph_id = text_background_left_scenegraph_id
		},
		text_background_right = {
			color = {
				0,
				255,
				255,
				255
			},
			scenegraph_id = text_background_right_scenegraph_id
		},
		text_background_center = {
			offset = {
				0,
				0,
				0
			},
			color = {
				0,
				255,
				255,
				255
			},
			texture_tiling_size = {
				26,
				35
			},
			scenegraph_id = text_background_center_scenegraph_id
		},
		title_text = {
			vertical_alignment = "center",
			localize = false,
			font_size = 26,
			font_type = "hell_shark_no_outline",
			horizontal_alignment = "center",
			text_color = Colors.get_color_table_with_alpha("black", 0),
			offset = {
				0,
				0,
				1
			},
			scenegraph_id = text_background_center_scenegraph_id
		},
		title_text_highlight = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			localize = false,
			font_size = 26,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("yellow", 255),
			offset = {
				0,
				-35,
				5
			}
		}
	}

	add_level_location_difficulty_definitions(passes, style, content)

	local widget_template = {
		style = style,
		content = content,
		element = element,
		scenegraph_id = scenegraph_id
	}
	local widget = UIWidget.init(widget_template)

	return widget
end

local function create_drachenfels_widget(widget_name)
	local scenegraph_id = string.format("%s%s", "level_location_", widget_name)
	local background_scenegraph_id = string.format("%s%s", "background_level_location_", widget_name)
	local hover_scenegraph_id = string.format("%s%s", "hover_level_location_", widget_name)
	local front_texture_scenegraph_id = string.format("%s%s", "front_texture_location_", widget_name)
	local banner_scenegraph_id = string.format("%s%s", "banner_level_location_", widget_name)
	local widget_scenegraph_definition = scenegraph_definition[scenegraph_id]

	if not widget_scenegraph_definition then
		scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "center",
			parent = "menu_map",
			horizontal_alignment = "center",
			position = {
				0,
				0,
				5
			},
			size = {
				114,
				116
			}
		}
	end

	if not scenegraph_definition[background_scenegraph_id] then
		scenegraph_definition[background_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				114,
				116
			},
			position = {
				0,
				0,
				2
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[hover_scenegraph_id] then
		scenegraph_definition[hover_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				128,
				128
			},
			position = {
				-2,
				4,
				7
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[front_texture_scenegraph_id] then
		scenegraph_definition[front_texture_scenegraph_id] = {
			vertical_alignment = "bottom",
			horizontal_alignment = "center",
			size = {
				112,
				114
			},
			position = {
				-2,
				5,
				4
			},
			parent = background_scenegraph_id
		}
	end

	if not scenegraph_definition[banner_scenegraph_id] then
		scenegraph_definition[banner_scenegraph_id] = {
			vertical_alignment = "top",
			horizontal_alignment = "center",
			size = {
				48,
				148
			},
			position = {
				-2,
				-80,
				-1
			},
			parent = background_scenegraph_id
		}
	end

	local element = table.clone(area_element_definition_drachenfels)
	local passes = element.passes
	local content = {
		front_texture = "drachenfels_location_icon_part_fg",
		hover = "drachenfels_location_icon_glow",
		glass = "drachenfels_area_icon_glass",
		background = "drachenfels_location_icon_part_01",
		skull_eye = "drachenfels_location_icon_part_06",
		area_name = widget_name,
		button_hotspot = {
			is_preview = false
		},
		preview_hotspot = {},
		banner = {
			texture_id = "drachenfels_area_icon_banner",
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
	}
	local style = {
		background = {
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = background_scenegraph_id
		},
		hover = {
			color = {
				0,
				255,
				255,
				255
			},
			scenegraph_id = hover_scenegraph_id
		},
		glass = {
			size = {
				68,
				84
			},
			offset = {
				21,
				17,
				1
			},
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = background_scenegraph_id
		},
		front_texture = {
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = front_texture_scenegraph_id
		},
		banner = {
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = banner_scenegraph_id
		},
		skull_eye = {
			size = {
				45,
				35
			},
			offset = {
				34,
				5,
				1
			},
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = front_texture_scenegraph_id
		},
		selected = {
			color = {
				0,
				255,
				255,
				255
			}
		}
	}

	add_level_location_difficulty_definitions(passes, style, content, true, banner_scenegraph_id)

	local widget_template = {
		style = style,
		content = content,
		element = element,
		scenegraph_id = scenegraph_id
	}
	local widget = UIWidget.init(widget_template)

	return widget
end

local function create_ubersreik_widget(widget_name)
	local scenegraph_id = string.format("%s%s", "level_location_", widget_name)
	local background_scenegraph_id = string.format("%s%s", "background_level_location_", widget_name)
	local hover_scenegraph_id = string.format("%s%s", "hover_level_location_", widget_name)
	local banner_scenegraph_id = string.format("%s%s", "banner_level_location_", widget_name)
	local widget_scenegraph_definition = scenegraph_definition[scenegraph_id]

	if not widget_scenegraph_definition then
		scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "center",
			parent = "menu_map",
			horizontal_alignment = "center",
			position = {
				0,
				0,
				5
			},
			size = {
				215,
				178
			}
		}
	end

	if not scenegraph_definition[background_scenegraph_id] then
		scenegraph_definition[background_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				215,
				178
			},
			position = {
				0,
				0,
				2
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[hover_scenegraph_id] then
		scenegraph_definition[hover_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				228,
				187
			},
			position = {
				-1,
				4,
				5
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[banner_scenegraph_id] then
		scenegraph_definition[banner_scenegraph_id] = {
			vertical_alignment = "top",
			horizontal_alignment = "center",
			size = {
				48,
				148
			},
			position = {
				0,
				-137,
				-1
			},
			parent = background_scenegraph_id
		}
	end

	local element = table.clone(area_element_definition_ubersreik)
	local passes = element.passes
	local content = {
		background = "ubersreik_location_icon",
		hover = "ubersreik_location_icon_glow",
		area_name = widget_name,
		button_hotspot = {
			is_preview = false
		},
		preview_hotspot = {},
		banner = {
			texture_id = "ubersreik_area_icon_banner",
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
	}
	local style = {
		background = {
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = background_scenegraph_id
		},
		hover = {
			color = {
				0,
				255,
				255,
				255
			},
			scenegraph_id = hover_scenegraph_id
		},
		banner = {
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = banner_scenegraph_id
		},
		selected = {
			color = {
				0,
				255,
				255,
				255
			}
		}
	}

	add_level_location_difficulty_definitions(passes, style, content, true, banner_scenegraph_id)

	local widget_template = {
		style = style,
		content = content,
		element = element,
		scenegraph_id = scenegraph_id
	}
	local widget = UIWidget.init(widget_template)

	return widget
end

local function create_dwarfs_widget(widget_name)
	local scenegraph_id = string.format("%s%s", "level_location_", widget_name)
	local background_scenegraph_id = string.format("%s%s", "background_level_location_", widget_name)
	local hover_scenegraph_id = string.format("%s%s", "hover_level_location_", widget_name)
	local banner_scenegraph_id = string.format("%s%s", "banner_level_location_", widget_name)
	local widget_scenegraph_definition = scenegraph_definition[scenegraph_id]

	if not widget_scenegraph_definition then
		scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "center",
			parent = "menu_map",
			horizontal_alignment = "center",
			position = {
				0,
				0,
				5
			},
			size = {
				94,
				116
			}
		}
	end

	if not scenegraph_definition[background_scenegraph_id] then
		scenegraph_definition[background_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				94,
				116
			},
			position = {
				0,
				0,
				2
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[hover_scenegraph_id] then
		scenegraph_definition[hover_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				115,
				134
			},
			position = {
				-1,
				4,
				5
			},
			parent = scenegraph_id
		}
	end

	if not scenegraph_definition[banner_scenegraph_id] then
		scenegraph_definition[banner_scenegraph_id] = {
			vertical_alignment = "top",
			horizontal_alignment = "center",
			size = {
				48,
				148
			},
			position = {
				0,
				-80,
				-1
			},
			parent = background_scenegraph_id
		}
	end

	local element = table.clone(area_element_definition_ubersreik)
	local passes = element.passes
	local content = {
		background = "karak_azgaraz_icon",
		hover = "karak_azgaraz_icon_glow",
		area_name = widget_name,
		button_hotspot = {
			is_preview = false
		},
		preview_hotspot = {},
		banner = {
			texture_id = "karak_azgaraz_location_icon_banner",
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
	}
	local style = {
		background = {
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = background_scenegraph_id
		},
		hover = {
			color = {
				0,
				255,
				255,
				255
			},
			scenegraph_id = hover_scenegraph_id
		},
		banner = {
			color = {
				255,
				255,
				255,
				255
			},
			scenegraph_id = banner_scenegraph_id
		},
		selected = {
			color = {
				0,
				255,
				255,
				255
			}
		}
	}

	add_level_location_difficulty_definitions(passes, style, content, true, banner_scenegraph_id)

	local widget_template = {
		style = style,
		content = content,
		element = element,
		scenegraph_id = scenegraph_id
	}
	local widget = UIWidget.init(widget_template)

	return widget
end

local function create_area_widget(widget_name)
	if widget_name == "ubersreik" then
		return create_ubersreik_widget(widget_name)
	elseif widget_name == "drachenfels" then
		return create_drachenfels_widget(widget_name)
	elseif widget_name == "dwarfs" then
		return create_dwarfs_widget(widget_name)
	else
		return create_dwarfs_widget(widget_name)
	end

	return 
end

local function create_zoom_bar(scenegraph_base, textures, offset, size, titles, tooltips)
	local passes = {}
	local element = {
		passes = passes
	}
	local style = {}
	local content = {}
	local widget = {
		style = style,
		content = content,
		element = element,
		scenegraph_id = scenegraph_base
	}
	local num_buttons = #titles

	for i = 1, num_buttons, 1 do
		local scenegraph_id = string.format("%s_%d", scenegraph_base, i)
		scenegraph_definition[scenegraph_id] = {
			parent = (i == 1 and scenegraph_base) or string.format("%s_%d", scenegraph_base, i - 1),
			size = size,
			offset = (i ~= 1 and offset) or nil
		}
		local button_hotspot_name = i
		local title_text = "title_text_" .. i
		local tooltip_text = "tooltip_text_" .. i
		local button_normal_id = string.format("button_style_%d", i)
		local button_hover_id = string.format("button_hover_style_%d", i)
		local button_disabled_id = string.format("button_disabled_style_%d", i)
		local button_click_id = string.format("button_click_style_%d", i)

		table.append_varargs(passes, {
			pass_type = "hotspot",
			content_id = button_hotspot_name,
			style_id = button_hotspot_name
		}, {
			pass_type = "texture",
			texture_id = button_disabled_id,
			style_id = button_disabled_id,
			content_check_function = function (content)
				return content[button_hotspot_name].disable_button
			end
		}, {
			pass_type = "texture",
			texture_id = button_normal_id,
			style_id = button_normal_id,
			content_check_function = function (content)
				local button_hotspot = content[button_hotspot_name]

				return not button_hotspot.is_selected and not button_hotspot.is_hover
			end
		}, {
			pass_type = "texture",
			texture_id = button_hover_id,
			style_id = button_hover_id,
			content_check_function = function (content)
				local button_hotspot = content[button_hotspot_name]

				return not button_hotspot.is_selected and button_hotspot.is_hover
			end
		}, {
			pass_type = "texture",
			texture_id = button_click_id,
			style_id = button_click_id,
			content_check_function = function (content)
				local button_hotspot = content[button_hotspot_name]

				return button_hotspot.is_selected
			end
		}, {
			pass_type = "tooltip_text",
			text_id = tooltip_text,
			style_id = tooltip_text,
			content_check_function = function (content)
				return content[button_hotspot_name].is_hover
			end
		}, {
			pass_type = "text",
			text_id = title_text,
			style_id = title_text
		})

		content[button_hotspot_name] = {}
		content[title_text] = titles[i]
		content[tooltip_text] = tooltips[i]
		content[button_normal_id] = textures.normal
		content[button_hover_id] = textures.hover
		content[button_click_id] = textures.click
		content[button_disabled_id] = textures.disabled
		style[title_text] = {
			localize = true,
			horizontal_alignment = "center",
			font_size = 20,
			vertical_alignment = "center",
			font_type = "hell_shark",
			size = size,
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				0,
				0,
				2
			},
			scenegraph_id = scenegraph_id
		}
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
				size[1],
				size[2]
			},
			offset = {
				0,
				0,
				0
			}
		}
		style[button_normal_id] = {
			scenegraph_id = scenegraph_id,
			color = {
				255,
				255,
				255,
				255
			},
			size = size
		}
		style[button_click_id] = {
			scenegraph_id = scenegraph_id,
			color = {
				255,
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
		style[button_hover_id] = {
			scenegraph_id = scenegraph_id,
			color = {
				255,
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
		style[button_disabled_id] = {
			scenegraph_id = scenegraph_id,
			offset = {
				0,
				0,
				5
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = size
		}
	end

	return widget
end

local widget_definitions = {
	map_overlay = UIWidgets.create_simple_texture("map_ubersreik", "map_overlay"),
	area_map = UIWidgets.create_simple_texture("map_ubersreik", "menu_map"),
	back_button = UIWidgets.create_hover_button("back_button", "last_stand_back_button_normal", "last_stand_back_button_hover")
}
local animations = {}

return {
	scenegraph_definition = scenegraph_definition,
	widgets = widget_definitions,
	game_mode_level_area_textures = game_mode_level_area_textures,
	create_area_widget = create_area_widget,
	create_level_widget = create_level_widget,
	animations = animations
}
