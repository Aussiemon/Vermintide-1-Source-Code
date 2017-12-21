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
	frame_console_overlay = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			1920,
			253
		},
		position = {
			0,
			0,
			1
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			420,
			28
		},
		position = {
			0,
			-10,
			1
		}
	},
	menu_map = {
		vertical_alignment = "top",
		parent = "frame",
		horizontal_alignment = "right",
		size = {
			1372,
			778
		},
		position = {
			-48,
			-53,
			1
		}
	},
	settings_window = {
		vertical_alignment = "top",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			422,
			504
		},
		position = {
			50,
			-64,
			1
		}
	},
	difficulty_stepper = {
		vertical_alignment = "center",
		parent = "banner_difficulty",
		horizontal_alignment = "center",
		size = {
			300,
			34
		},
		position = {
			0,
			-60,
			1
		}
	},
	private_checkbox = {
		vertical_alignment = "center",
		parent = "cancel_button",
		horizontal_alignment = "right",
		size = {
			100,
			34
		},
		position = {
			-230,
			0,
			1
		}
	},
	pc_private_checkbox = {
		vertical_alignment = "center",
		parent = "cancel_button",
		horizontal_alignment = "right",
		size = {
			100,
			34
		},
		position = {
			-230,
			0,
			1
		}
	},
	gamepad_private_checkbox = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "right",
		size = {
			100,
			34
		},
		position = {
			20,
			75,
			3
		}
	},
	level_stepper = {
		vertical_alignment = "top",
		parent = "banner_level",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			-150,
			1
		}
	},
	difficulty_stepper_unlock_icon = {
		vertical_alignment = "bottom",
		parent = "difficulty_stepper",
		horizontal_alignment = "right",
		size = {
			30,
			38
		},
		position = {
			-40,
			-45,
			1
		}
	},
	game_mode_selection_bar_bg = {
		vertical_alignment = "top",
		parent = "banner_level",
		horizontal_alignment = "center",
		size = {
			436,
			59
		},
		position = {
			0,
			60,
			1
		}
	},
	game_mode_selection_bar = {
		vertical_alignment = "center",
		parent = "game_mode_selection_bar_bg",
		horizontal_alignment = "center",
		size = {
			418,
			40
		},
		position = {
			-1,
			11,
			1
		}
	},
	level_preview = {
		vertical_alignment = "center",
		parent = "level_stepper",
		horizontal_alignment = "center",
		size = {
			300,
			170
		},
		position = {
			0,
			0,
			1
		}
	},
	preview_text = {
		vertical_alignment = "center",
		parent = "level_stepper",
		horizontal_alignment = "center",
		size = {
			300,
			50
		},
		position = {
			0,
			-120,
			5
		}
	},
	play_button_console = {
		vertical_alignment = "bottom",
		parent = "level_preview",
		horizontal_alignment = "center",
		size = {
			300,
			34
		},
		position = {
			0,
			-50,
			1
		}
	},
	description_field = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			970,
			85
		},
		position = {
			512,
			140,
			1
		}
	},
	input_description_field = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			1800,
			80
		},
		position = {
			0,
			50,
			1
		}
	},
	friends_button = {
		vertical_alignment = "bottom",
		parent = "banner_party",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			90,
			1
		}
	},
	settings_button = {
		vertical_alignment = "bottom",
		parent = "banner_party",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			-100,
			90,
			1
		}
	},
	lobby_button = {
		vertical_alignment = "bottom",
		parent = "banner_party",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			100,
			90,
			1
		}
	},
	confirm_button = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "right",
		size = {
			338,
			120
		},
		position = {
			-62,
			130.5,
			1
		}
	},
	confirm_button_disabled_tooltip = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "right",
		size = {
			338,
			120
		},
		position = {
			-62,
			130,
			1
		}
	},
	confirm_button_eye_glow = {
		vertical_alignment = "center",
		parent = "confirm_button",
		horizontal_alignment = "center",
		size = {
			63,
			46
		},
		position = {
			-1,
			35,
			1
		}
	},
	cancel_button = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "right",
		size = {
			220,
			62
		},
		position = {
			-62,
			55,
			1
		}
	},
	player_list_slot_1 = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			370,
			40
		},
		position = {
			82,
			290,
			1
		}
	},
	player_list_slot_2 = {
		vertical_alignment = "bottom",
		parent = "player_list_slot_1",
		horizontal_alignment = "left",
		size = {
			370,
			40
		},
		position = {
			0,
			-40,
			1
		}
	},
	player_list_slot_3 = {
		vertical_alignment = "bottom",
		parent = "player_list_slot_2",
		horizontal_alignment = "left",
		size = {
			370,
			40
		},
		position = {
			0,
			-40,
			1
		}
	},
	player_list_slot_4 = {
		vertical_alignment = "bottom",
		parent = "player_list_slot_3",
		horizontal_alignment = "left",
		size = {
			370,
			40
		},
		position = {
			0,
			-40,
			1
		}
	},
	gamepad_selection_pivot = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
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
	gamepad_button_selection = {
		vertical_alignment = "center",
		parent = "gamepad_selection_pivot",
		horizontal_alignment = "center",
		size = {
			300,
			170
		},
		position = {
			0,
			0,
			1
		}
	},
	gamepad_node_level_stepper = {
		vertical_alignment = "center",
		parent = "level_preview",
		horizontal_alignment = "center",
		size = {
			395,
			260
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_difficulty_stepper = {
		vertical_alignment = "center",
		parent = "difficulty_stepper",
		horizontal_alignment = "center",
		size = {
			330,
			85
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_search_zone_stepper = {
		vertical_alignment = "center",
		parent = "stepper_search_zone",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_host_setting_stepper = {
		vertical_alignment = "center",
		parent = "stepper_host_setting",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_ready_setting_stepper = {
		vertical_alignment = "center",
		parent = "stepper_ready_setting",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_wanted_hero_list = {
		vertical_alignment = "center",
		parent = "wanted_hero_list",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_player_list_slot_1 = {
		vertical_alignment = "center",
		parent = "player_list_slot_1",
		horizontal_alignment = "center",
		size = {
			400,
			60
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_player_list_slot_2 = {
		vertical_alignment = "center",
		parent = "player_list_slot_2",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_player_list_slot_3 = {
		vertical_alignment = "center",
		parent = "player_list_slot_3",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	gamepad_node_player_list_slot_4 = {
		vertical_alignment = "center",
		parent = "player_list_slot_4",
		horizontal_alignment = "center",
		size = {
			330,
			75
		},
		position = {
			0,
			0,
			10
		}
	},
	player_list_conuter_text = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			70,
			40
		},
		position = {
			405,
			140,
			1
		}
	},
	banner_party = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			370,
			56
		},
		position = {
			82,
			340.5,
			1
		}
	},
	banner_party_text = {
		vertical_alignment = "center",
		parent = "banner_party",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	banner_difficulty = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			370,
			56
		},
		position = {
			82,
			605.5,
			1
		}
	},
	banner_difficulty_text = {
		vertical_alignment = "center",
		parent = "banner_difficulty",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	banner_level = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			370,
			56
		},
		position = {
			82,
			920.5,
			1
		}
	},
	banner_level_text = {
		vertical_alignment = "center",
		parent = "banner_level",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	banner_hero_list = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			370,
			56
		},
		position = {
			82,
			805.5,
			1
		}
	},
	banner_hero_list_text = {
		vertical_alignment = "center",
		parent = "banner_hero_list",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	banner_host_setting = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			370,
			56
		},
		position = {
			82,
			685.5,
			1
		}
	},
	banner_host_setting_text = {
		vertical_alignment = "center",
		parent = "banner_host_setting",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	banner_ready_setting = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "left",
		size = {
			370,
			56
		},
		position = {
			82,
			565.5,
			1
		}
	},
	banner_ready_setting_text = {
		vertical_alignment = "center",
		parent = "banner_ready_setting",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	stepper_search_zone = {
		vertical_alignment = "top",
		parent = "banner_level",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			-65,
			1
		}
	},
	stepper_host_setting = {
		vertical_alignment = "top",
		parent = "banner_host_setting",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			-65,
			1
		}
	},
	stepper_ready_setting = {
		vertical_alignment = "top",
		parent = "banner_ready_setting",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			-65,
			1
		}
	},
	stepper_game_mode = {
		vertical_alignment = "center",
		parent = "banner_level",
		horizontal_alignment = "center",
		size = {
			300,
			34
		},
		position = {
			0,
			0,
			1
		}
	},
	wanted_hero_list = {
		vertical_alignment = "top",
		parent = "banner_hero_list",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			0,
			-65,
			1
		}
	},
	performance_window = {
		vertical_alignment = "bottom",
		parent = "menu_map",
		horizontal_alignment = "right",
		size = {
			302,
			314
		},
		position = {
			4,
			5.5,
			1
		}
	},
	performance_window_icon = {
		vertical_alignment = "top",
		parent = "performance_window",
		horizontal_alignment = "center",
		size = {
			42,
			45
		},
		position = {
			5,
			-12,
			1
		}
	},
	banner_performance_text = {
		vertical_alignment = "top",
		parent = "performance_window",
		horizontal_alignment = "center",
		size = {
			300,
			40
		},
		position = {
			10,
			-63,
			1
		}
	},
	best_performance_1 = {
		vertical_alignment = "top",
		parent = "performance_window",
		horizontal_alignment = "center",
		size = {
			265,
			40
		},
		position = {
			10,
			-125,
			1
		}
	},
	best_performance_2 = {
		vertical_alignment = "center",
		parent = "best_performance_1",
		horizontal_alignment = "center",
		size = {
			265,
			40
		},
		position = {
			0,
			-70,
			1
		}
	},
	best_performance_3 = {
		vertical_alignment = "center",
		parent = "best_performance_2",
		horizontal_alignment = "center",
		size = {
			265,
			40
		},
		position = {
			0,
			-70,
			1
		}
	},
	description_background = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.end_screen + 60
		}
	},
	description_title = {
		vertical_alignment = "top",
		parent = "description_background",
		horizontal_alignment = "center",
		size = {
			300,
			60
		},
		position = {
			0,
			-200,
			60
		}
	},
	description_text = {
		vertical_alignment = "top",
		parent = "description_title",
		horizontal_alignment = "center",
		size = {
			850,
			800
		},
		position = {
			0,
			-60,
			1
		}
	},
	input_description_text = {
		vertical_alignment = "bottom",
		parent = "description_background",
		horizontal_alignment = "center",
		size = {
			800,
			50
		},
		position = {
			0,
			110,
			1
		}
	}
}

local function create_game_mode_selection_bar(scenegraph_base, textures, offset, size, titles, tooltips)
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

local function create_input_description_widgets(amount)
	local input_description_widgets = {}

	for i = 1, amount, 1 do
		local scenegraph_root_id = "input_description_root_" .. i
		local scenegraph_id = "input_description_" .. i
		local scenegraph_icon_id = "input_description_icon_" .. i
		local scenegraph_text_id = "input_description_text_" .. i
		scenegraph_definition[scenegraph_root_id] = {
			vertical_alignment = "center",
			parent = "input_description_field",
			horizontal_alignment = "left",
			size = {
				1,
				1
			},
			position = {
				0,
				0,
				1
			}
		}
		scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = scenegraph_root_id,
			size = {
				200,
				40
			},
			position = {
				0,
				0,
				1
			}
		}
		scenegraph_definition[scenegraph_icon_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = scenegraph_id,
			size = {
				40,
				40
			},
			position = {
				0,
				0,
				1
			}
		}
		scenegraph_definition[scenegraph_text_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = scenegraph_icon_id,
			size = {
				160,
				40
			},
			position = {
				40,
				0,
				1
			}
		}
		local widget_definition = {
			element = {
				passes = {
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text"
					},
					{
						pass_type = "texture",
						style_id = "icon",
						texture_id = "icon"
					}
				}
			},
			content = {
				text = "",
				icon = "xbone_button_icon_a"
			},
			style = {
				text = {
					font_size = 24,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "left",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						0,
						1
					},
					scenegraph_id = scenegraph_text_id
				},
				icon = {
					scenegraph_id = scenegraph_icon_id
				}
			},
			scenegraph_id = scenegraph_id
		}
		input_description_widgets[#input_description_widgets + 1] = UIWidget.init(widget_definition)
	end

	return input_description_widgets
end

local function create_performance_time_entry(scenegraph_id, difficulty_title, use_divider)
	return {
		element = {
			passes = {
				{
					style_id = "waves_hotspot",
					pass_type = "hotspot",
					content_id = "waves_hotspot"
				},
				{
					style_id = "waves_tooltip_text",
					pass_type = "tooltip_text",
					text_id = "waves_tooltip_text",
					content_check_function = function (ui_content)
						return ui_content.waves_hotspot.is_hover
					end
				},
				{
					style_id = "waves",
					pass_type = "text",
					text_id = "waves"
				},
				{
					style_id = "wave_title",
					pass_type = "text",
					text_id = "wave_title"
				},
				{
					style_id = "time_hotspot",
					pass_type = "hotspot",
					content_id = "time_hotspot"
				},
				{
					style_id = "time_tooltip_text",
					pass_type = "tooltip_text",
					text_id = "time_tooltip_text",
					content_check_function = function (ui_content)
						return ui_content.time_hotspot.is_hover
					end
				},
				{
					style_id = "time",
					pass_type = "text",
					text_id = "time"
				},
				{
					style_id = "time_title",
					pass_type = "text",
					text_id = "time_title"
				},
				{
					style_id = "difficulty_title",
					pass_type = "text",
					text_id = "difficulty_title"
				},
				{
					pass_type = "texture",
					style_id = "divider_texture",
					texture_id = "divider_texture",
					content_check_function = function (ui_content)
						return ui_content.use_divider
					end
				}
			}
		},
		content = {
			divider_texture = "survival_divider",
			time = "00:00:00",
			wave_title = "dlc1_2_survival_mission_wave",
			time_title = "dlc1_2_end_screen_time",
			waves = "0",
			waves_tooltip_text = "dlc1_2_map_best_waves",
			time_tooltip_text = "dlc1_2_map_best_time",
			use_divider = use_divider,
			waves_hotspot = {},
			time_hotspot = {},
			difficulty_title = difficulty_title
		},
		style = {
			divider_texture = {
				offset = {
					36.5,
					-11,
					0
				},
				size = {
					192,
					8
				}
			},
			waves_hotspot = {
				offset = {
					0,
					20,
					0
				},
				size = {
					265,
					20
				}
			},
			waves_tooltip_text = {
				font_size = 24,
				max_width = 500,
				localize = true,
				cursor_side = "left",
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {},
				offset = {
					0,
					0,
					50
				},
				cursor_offset = {
					-10,
					-27
				}
			},
			wave_title = {
				font_size = 18,
				localize = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					2
				}
			},
			difficulty_title = {
				vertical_alignment = "top",
				dynamic_font = true,
				horizontal_alignment = "center",
				font_size = 20,
				pixel_perfect = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					19,
					2
				}
			},
			waves = {
				vertical_alignment = "top",
				dynamic_font = true,
				horizontal_alignment = "right",
				font_size = 18,
				pixel_perfect = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					2
				}
			},
			time_hotspot = {
				offset = {
					0,
					0,
					0
				},
				size = {
					265,
					20
				}
			},
			time_tooltip_text = {
				font_size = 24,
				max_width = 500,
				localize = true,
				cursor_side = "left",
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {},
				offset = {
					0,
					0,
					50
				},
				cursor_offset = {
					-10,
					-27
				}
			},
			time_title = {
				font_size = 18,
				localize = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					-20,
					2
				}
			},
			time = {
				font_size = 18,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "right",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					-20,
					2
				}
			}
		},
		scenegraph_id = scenegraph_id
	}
end

local party_text = (Application.platform() == "xb1" and "map_party_title_xb1") or "map_party_title"
local num_players_tooltip = (Application.platform() == "xb1" and "map_number_of_players_tooltip_xb1") or "map_number_of_players_tooltip"
local widgets = {
	gamepad_button_selection = UIWidgets.create_gamepad_selection("gamepad_button_selection", nil, nil, {
		70,
		70
	}),
	description_background = UIWidgets.create_simple_texture("gradient_credits_menu", "description_background"),
	description_title = UIWidgets.create_simple_text("dlc1_2_game_mode_info_survival_title", "description_title", nil, nil, {
		vertical_alignment = "center",
		font_size = 36,
		localize = true,
		horizontal_alignment = "center",
		word_wrap = true,
		font_type = "hell_shark_header",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	input_description_text = UIWidgets.create_simple_text("press_any_key_to_continue", "input_description_text", 18, Colors.get_color_table_with_alpha("white", 255)),
	description_text = UIWidgets.create_simple_text("dlc1_2_game_mode_info_survival_text", "description_text", nil, nil, {
		vertical_alignment = "top",
		font_size = 24,
		localize = true,
		horizontal_alignment = "left",
		word_wrap = true,
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("white", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	game_mode_selection_bar = create_game_mode_selection_bar("game_mode_selection_bar", {
		disabled = "survival_button_disabled",
		click = "survival_button_selected",
		hover = "survival_button_hover",
		normal = "survival_button_normal"
	}, {
		209,
		0,
		0
	}, {
		209,
		25
	}, {
		"dlc1_2_map_game_mode_adventure",
		"dlc1_2_map_game_mode_survival"
	}, {
		"dlc1_2_map_game_mode_adventure_tooltip",
		"dlc1_2_map_game_mode_survival_tooltip"
	}),
	game_mode_selection_bar_bg = UIWidgets.create_simple_texture("survival_button_bg", "game_mode_selection_bar_bg"),
	performance_window = UIWidgets.create_simple_texture("map_performance_window", "performance_window"),
	performance_window_icon = UIWidgets.create_simple_texture("level_location_any_icon", "performance_window_icon"),
	player_list_slot_1 = UIWidgets.create_map_player_entry("player_list_slot_1", "gamepad_node_player_list_slot_1"),
	player_list_slot_2 = UIWidgets.create_map_player_entry("player_list_slot_2", "gamepad_node_player_list_slot_2"),
	player_list_slot_3 = UIWidgets.create_map_player_entry("player_list_slot_3", "gamepad_node_player_list_slot_3"),
	player_list_slot_4 = UIWidgets.create_map_player_entry("player_list_slot_4", "gamepad_node_player_list_slot_4"),
	player_list_conuter_text = UIWidgets.create_simple_text_tooltip("", num_players_tooltip, "player_list_conuter_text", nil, nil, {
		vertical_alignment = "bottom",
		word_wrap = true,
		font_type = "hell_shark",
		font_size = 24,
		horizontal_alignment = "right",
		text_color = Colors.get_color_table_with_alpha("white", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	difficulty_stepper = {
		scenegraph_id = "difficulty_stepper",
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot",
					content_check_function = function (content)
						return not content.disabled
					end
				},
				{
					pass_type = "texture",
					style_id = "hover_texture",
					texture_id = "hover_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot
						local gamepad_active = button_hotspot.gamepad_active

						return not gamepad_active and (button_hotspot.is_selected or button_hotspot.is_hover)
					end
				},
				{
					style_id = "left_button_texture",
					pass_type = "hotspot",
					content_id = "left_button_hotspot",
					content_check_function = function (content)
						return not content.disabled
					end
				},
				{
					style_id = "right_button_texture",
					pass_type = "hotspot",
					content_id = "right_button_hotspot",
					content_check_function = function (content)
						return not content.disabled
					end
				},
				{
					pass_type = "texture",
					style_id = "left_button_texture",
					texture_id = "left_button_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot
						local gamepad_active = button_hotspot.gamepad_active

						if gamepad_active then
							return button_hotspot.is_selected
						else
							return true
						end

						return 
					end
				},
				{
					pass_type = "rotated_texture",
					style_id = "right_button_texture",
					texture_id = "right_button_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot
						local gamepad_active = button_hotspot.gamepad_active

						if gamepad_active then
							return button_hotspot.is_selected
						else
							return true
						end

						return 
					end
				},
				{
					pass_type = "texture",
					style_id = "left_button_texture_clicked",
					texture_id = "left_button_texture_clicked",
					content_check_function = function (content)
						return not content.left_button_hotspot.disabled
					end
				},
				{
					pass_type = "rotated_texture",
					style_id = "right_button_texture_clicked",
					texture_id = "right_button_texture_clicked",
					content_check_function = function (content)
						return not content.right_button_hotspot.disabled
					end
				},
				{
					style_id = "difficulty_icon_1",
					pass_type = "hotspot",
					content_id = "difficulty_icon_hotspot_1"
				},
				{
					style_id = "difficulty_icon_2",
					pass_type = "hotspot",
					content_id = "difficulty_icon_hotspot_2"
				},
				{
					style_id = "difficulty_icon_3",
					pass_type = "hotspot",
					content_id = "difficulty_icon_hotspot_3"
				},
				{
					style_id = "difficulty_icon_4",
					pass_type = "hotspot",
					content_id = "difficulty_icon_hotspot_4"
				},
				{
					style_id = "difficulty_icon_5",
					pass_type = "hotspot",
					content_id = "difficulty_icon_hotspot_5"
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_1",
					texture_id = "difficulty_icon_1_empty"
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_2",
					texture_id = "difficulty_icon_2_empty"
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_3",
					texture_id = "difficulty_icon_3_empty"
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_4",
					texture_id = "difficulty_icon_4_empty"
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_5",
					texture_id = "difficulty_icon_5_empty"
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_selected_1",
					texture_id = "difficulty_icon_1_filled",
					content_check_function = function (content)
						local difficulty_level = content.difficulty_level
						local internal_difficulty_level = content.internal_difficulty_level
						local is_hover = content.difficulty_icon_hotspot_global.is_hover

						return (is_hover and 0 < content.internal_difficulty_level) or (not is_hover and 0 < content.difficulty_level)
					end
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_selected_2",
					texture_id = "difficulty_icon_2_filled",
					content_check_function = function (content)
						local difficulty_level = content.difficulty_level
						local internal_difficulty_level = content.internal_difficulty_level
						local is_hover = content.difficulty_icon_hotspot_global.is_hover

						return (is_hover and 1 < content.internal_difficulty_level) or (not is_hover and 1 < content.difficulty_level)
					end
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_selected_3",
					texture_id = "difficulty_icon_3_filled",
					content_check_function = function (content)
						local difficulty_level = content.difficulty_level
						local internal_difficulty_level = content.internal_difficulty_level
						local is_hover = content.difficulty_icon_hotspot_global.is_hover

						return (is_hover and 2 < content.internal_difficulty_level) or (not is_hover and 2 < content.difficulty_level)
					end
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_selected_4",
					texture_id = "difficulty_icon_4_filled",
					content_check_function = function (content)
						local difficulty_level = content.difficulty_level
						local internal_difficulty_level = content.internal_difficulty_level
						local is_hover = content.difficulty_icon_hotspot_global.is_hover

						return (is_hover and 3 < content.internal_difficulty_level) or (not is_hover and 3 < content.difficulty_level)
					end
				},
				{
					pass_type = "texture",
					style_id = "difficulty_icon_selected_5",
					texture_id = "difficulty_icon_5_filled",
					content_check_function = function (content)
						local difficulty_level = content.difficulty_level
						local internal_difficulty_level = content.internal_difficulty_level
						local is_hover = content.difficulty_icon_hotspot_global.is_hover

						return (is_hover and 4 < content.internal_difficulty_level) or (not is_hover and 4 < content.difficulty_level)
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "difficulty_tooltip_1",
					content_check_function = function (content)
						local is_hover = content.difficulty_icon_hotspot_1.is_hover

						return is_hover and content.difficulty_tooltip_1
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "difficulty_tooltip_2",
					content_check_function = function (content)
						local is_hover = content.difficulty_icon_hotspot_2.is_hover

						return is_hover and content.difficulty_tooltip_2
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "difficulty_tooltip_3",
					content_check_function = function (content)
						local is_hover = content.difficulty_icon_hotspot_3.is_hover

						return is_hover and content.difficulty_tooltip_3
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "difficulty_tooltip_4",
					content_check_function = function (content)
						local is_hover = content.difficulty_icon_hotspot_4.is_hover

						return is_hover and content.difficulty_tooltip_4
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "difficulty_tooltip_5",
					content_check_function = function (content)
						local is_hover = content.difficulty_icon_hotspot_5.is_hover

						return is_hover and content.difficulty_tooltip_5
					end
				},
				{
					style_id = "difficulty_icon_hotspot_global",
					pass_type = "hotspot",
					content_id = "difficulty_icon_hotspot_global"
				},
				{
					style_id = "setting_text",
					pass_type = "text",
					text_id = "setting_text",
					content_check_function = function (content)
						return not content.inactive and not content.difficulty_icon_hotspot_global.is_hover and content.setting_text
					end
				},
				{
					style_id = "setting_text",
					pass_type = "text",
					text_id = "setting_text_hover",
					content_check_function = function (content)
						return not content.inactive and content.difficulty_icon_hotspot_global.is_hover and content.setting_text_hover
					end
				}
			}
		},
		content = {
			difficulty_icon_1_filled = "difficulty_icon_large_02",
			difficulty_icon_4_empty = "difficulty_icon_large_01",
			difficulty_icon_2_filled = "difficulty_icon_large_02",
			difficulty_icon_1_empty = "difficulty_icon_large_01",
			setting_text = "n/a",
			difficulty_icon_2_empty = "difficulty_icon_large_01",
			difficulty_icon_3_empty = "difficulty_icon_large_01",
			hover_texture = "map_setting_bg_fade",
			right_button_texture_clicked = "settings_arrow_clicked",
			left_button_texture_clicked = "settings_arrow_clicked",
			difficulty_icon_3_filled = "difficulty_icon_large_02",
			difficulty_icon_4_filled = "difficulty_icon_large_02",
			difficulty_level = 0,
			difficulty_icon_5_empty = "difficulty_icon_large_01",
			internal_difficulty_level = 0,
			difficulty_icon_fill_texture = "difficulty_icon_large_02",
			right_button_texture = "settings_arrow_normal",
			difficulty_icon_texture = "difficulty_icon_large_01",
			left_button_texture = "settings_arrow_normal",
			setting_text_hover = "n/a",
			difficulties_unlocked = 0,
			difficulty_icon_empty_texture = "difficulty_icon_large_01",
			difficulties_unavailable = 0,
			difficulty_icon_5_filled = "difficulty_icon_large_02",
			button_hotspot = {},
			difficulty_icon_hotspot_global = {},
			difficulty_icon_hotspot_1 = {},
			difficulty_icon_hotspot_2 = {},
			difficulty_icon_hotspot_3 = {},
			difficulty_icon_hotspot_4 = {},
			difficulty_icon_hotspot_5 = {},
			left_button_hotspot = {},
			right_button_hotspot = {}
		},
		style = {
			gamepad_selection = {
				scenegraph_id = "gamepad_node_difficulty_stepper",
				texture_size = {
					40,
					40
				}
			},
			hover_texture = {
				size = {
					410,
					50
				},
				offset = {
					-55,
					-8,
					0
				}
			},
			tooltip_text = {
				vertical_alignment = "top",
				font_type = "hell_shark",
				horizontal_alignment = "left",
				font_size = 24,
				max_width = 500,
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {},
				offset = {
					0,
					0,
					50
				}
			},
			difficulty_icon_hotspot_global = {
				size = {
					295,
					59
				},
				offset = {
					2,
					-12.5,
					1
				}
			},
			difficulty_icon_1 = {
				size = {
					59,
					59
				},
				offset = {
					2,
					-12.5,
					1
				}
			},
			difficulty_icon_2 = {
				size = {
					59,
					59
				},
				offset = {
					61,
					-12.5,
					1
				}
			},
			difficulty_icon_3 = {
				size = {
					59,
					59
				},
				offset = {
					120,
					-12.5,
					1
				}
			},
			difficulty_icon_4 = {
				size = {
					59,
					59
				},
				offset = {
					179,
					-12.5,
					1
				}
			},
			difficulty_icon_5 = {
				size = {
					59,
					59
				},
				offset = {
					238,
					-12.5,
					1
				}
			},
			difficulty_icon_selected_1 = {
				size = {
					59,
					59
				},
				offset = {
					2,
					-12.5,
					1
				},
				color = {
					180,
					255,
					255,
					255
				}
			},
			difficulty_icon_selected_2 = {
				size = {
					59,
					59
				},
				offset = {
					61,
					-12.5,
					1
				},
				color = {
					180,
					255,
					255,
					255
				}
			},
			difficulty_icon_selected_3 = {
				size = {
					59,
					59
				},
				offset = {
					120,
					-12.5,
					1
				},
				color = {
					180,
					255,
					255,
					255
				}
			},
			difficulty_icon_selected_4 = {
				size = {
					59,
					59
				},
				offset = {
					179,
					-12.5,
					1
				},
				color = {
					180,
					255,
					255,
					255
				}
			},
			difficulty_icon_selected_5 = {
				size = {
					59,
					59
				},
				offset = {
					238,
					-12.5,
					1
				},
				color = {
					180,
					255,
					255,
					255
				}
			},
			selection_texture = {
				size = {
					308,
					26
				},
				offset = {
					-4,
					0,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			left_button_texture = {
				size = {
					28,
					34
				},
				offset = {
					-40,
					-3,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			right_button_texture = {
				angle = 3.1415926499999998,
				pivot = {
					14,
					17
				},
				size = {
					28,
					34
				},
				offset = {
					315,
					-3,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			left_button_texture_clicked = {
				color = {
					0,
					255,
					255,
					255
				},
				size = {
					28,
					34
				},
				offset = {
					-40,
					-3,
					1
				}
			},
			right_button_texture_clicked = {
				angle = 3.1415926499999998,
				color = {
					0,
					255,
					255,
					255
				},
				pivot = {
					14,
					17
				},
				size = {
					28,
					34
				},
				offset = {
					315,
					-3,
					1
				}
			},
			setting_text = {
				vertical_alignment = "center",
				word_wrap = true,
				horizontal_alignment = "center",
				font_size = 28,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					-40,
					4
				}
			}
		}
	},
	level_stepper = {
		scenegraph_id = "level_stepper",
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					pass_type = "texture",
					style_id = "hover_texture",
					texture_id = "hover_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot
						local gamepad_active = button_hotspot.gamepad_active

						return not gamepad_active and (button_hotspot.is_selected or button_hotspot.is_hover)
					end
				},
				{
					style_id = "left_button_texture",
					pass_type = "hotspot",
					content_id = "left_button_hotspot"
				},
				{
					style_id = "right_button_texture",
					pass_type = "hotspot",
					content_id = "right_button_hotspot"
				},
				{
					style_id = "setting_text",
					pass_type = "text",
					text_id = "setting_text"
				},
				{
					pass_type = "texture",
					style_id = "left_button_texture",
					texture_id = "left_button_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot
						local gamepad_active = button_hotspot.gamepad_active
						local left_button_hotspot = content.left_button_hotspot

						if left_button_hotspot.disable_button then
							return false
						end

						if gamepad_active then
							return button_hotspot.is_selected
						else
							return true
						end

						return 
					end
				},
				{
					pass_type = "rotated_texture",
					style_id = "right_button_texture",
					texture_id = "right_button_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot
						local gamepad_active = button_hotspot.gamepad_active
						local right_button_hotspot = content.right_button_hotspot

						if right_button_hotspot.disable_button then
							return false
						end

						if gamepad_active then
							return button_hotspot.is_selected
						else
							return true
						end

						return 
					end
				},
				{
					pass_type = "texture",
					style_id = "left_button_texture_clicked",
					texture_id = "left_button_texture_clicked",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot
						local gamepad_active = button_hotspot.gamepad_active

						if gamepad_active then
							return button_hotspot.is_selected
						else
							return true
						end

						return 
					end
				},
				{
					pass_type = "rotated_texture",
					style_id = "right_button_texture_clicked",
					texture_id = "right_button_texture_clicked",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot
						local gamepad_active = button_hotspot.gamepad_active

						if gamepad_active then
							return button_hotspot.is_selected
						else
							return true
						end

						return 
					end
				}
			}
		},
		content = {
			left_button_texture = "settings_arrow_normal",
			hover_texture = "map_setting_bg_fade_02",
			setting_text = "test_text",
			right_button_texture_clicked = "settings_arrow_clicked",
			right_button_texture = "settings_arrow_normal",
			left_button_texture_clicked = "settings_arrow_clicked",
			button_hotspot = {},
			left_button_hotspot = {},
			right_button_hotspot = {}
		},
		style = {
			hover_texture = {
				scenegraph_id = "level_preview",
				size = {
					397,
					209
				},
				offset = {
					-48.5,
					-19.5,
					0
				}
			},
			gamepad_selection = {
				scenegraph_id = "gamepad_node_level_stepper",
				texture_size = {
					90,
					90
				}
			},
			left_button_texture = {
				size = {
					28,
					34
				},
				offset = {
					-40,
					-3,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			right_button_texture = {
				angle = 3.1415926499999998,
				pivot = {
					14,
					17
				},
				size = {
					28,
					34
				},
				offset = {
					315,
					-3,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			left_button_texture_clicked = {
				color = {
					0,
					255,
					255,
					255
				},
				size = {
					28,
					34
				},
				offset = {
					-40,
					-3,
					1
				}
			},
			right_button_texture_clicked = {
				angle = 3.1415926499999998,
				color = {
					0,
					255,
					255,
					255
				},
				pivot = {
					14,
					17
				},
				size = {
					28,
					34
				},
				offset = {
					315,
					-3,
					1
				}
			},
			setting_text = {
				font_size = 28,
				word_wrap = false,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					-120,
					4
				}
			}
		}
	},
	private_checkbox = {
		scenegraph_id = "private_checkbox",
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "tooltip_text",
					content_check_function = function (ui_content)
						return ui_content.button_hotspot.is_hover
					end
				},
				{
					style_id = "setting_text",
					pass_type = "text",
					text_id = "setting_text",
					content_check_function = function (content)
						return not content.button_hotspot.is_hover
					end
				},
				{
					style_id = "setting_text_hover",
					pass_type = "text",
					text_id = "setting_text",
					content_check_function = function (content)
						return content.button_hotspot.is_hover
					end
				},
				{
					pass_type = "texture",
					style_id = "checkbox_style",
					texture_id = "checkbox_unchecked_texture",
					content_check_function = function (content)
						return not content.selected
					end
				},
				{
					pass_type = "texture",
					style_id = "checkbox_style",
					texture_id = "checkbox_checked_texture",
					content_check_function = function (content)
						return content.selected
					end
				}
			}
		},
		content = {
			tooltip_text = "map_private_setting_tooltip",
			checkbox_unchecked_texture = "checkbox_unchecked",
			checkbox_checked_texture = "checkbox_checked",
			selected = false,
			setting_text = "map_screen_private_button",
			button_hotspot = {}
		},
		style = {
			checkbox_style = {
				size = {
					16,
					16
				},
				offset = {
					84,
					6,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			setting_text = {
				vertical_alignment = "center",
				font_size = 20,
				localize = true,
				horizontal_alignment = "right",
				word_wrap = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-16,
					-2,
					4
				}
			},
			setting_text_hover = {
				vertical_alignment = "center",
				font_size = 20,
				localize = true,
				horizontal_alignment = "right",
				word_wrap = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					-16,
					-2,
					4
				}
			},
			tooltip_text = {
				font_size = 18,
				max_width = 500,
				localize = true,
				cursor_side = "left",
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {},
				offset = {
					0,
					0,
					50
				},
				cursor_offset = {
					-10,
					-27
				}
			}
		}
	},
	play_button_console = {
		scenegraph_id = "play_button_console",
		element = {
			passes = {
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					pass_type = "texture",
					style_id = "selection_texture",
					texture_id = "selection_texture",
					content_check_function = function (content)
						return content.selected
					end
				},
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				}
			}
		},
		content = {
			selection_texture = "map_setting_bg_fade",
			text = Localize("map_screen_confirm_button"),
			button_hotspot = {}
		},
		style = {
			selection_texture = {
				size = {
					308,
					26
				},
				offset = {
					-4,
					-4,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			text = {
				font_size = 24,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				text_color_disabled = table.clone(Colors.color_definitions.gray),
				text_color_enabled = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	level_preview = {
		scenegraph_id = "level_preview",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "texture_overlay",
					texture_id = "texture_overlay",
					content_check_function = function (content)
						return content.locked
					end
				},
				{
					pass_type = "texture",
					style_id = "texture",
					texture_id = "texture"
				},
				{
					pass_type = "texture",
					style_id = "frame_texture",
					texture_id = "frame_texture"
				}
			}
		},
		content = {
			texture = "level_image_any",
			locked = false,
			texture_overlay = "level_image_locked_overlay",
			frame_texture = "map_level_preview_frame"
		},
		style = {
			texture = {
				color = {
					255,
					255,
					255,
					255
				}
			},
			texture_overlay = {
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
				}
			},
			frame_texture = {
				size = {
					325,
					197
				},
				offset = {
					-13,
					-14,
					2
				},
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	description_field = {
		scenegraph_id = "description_field",
		element = {
			passes = {
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				}
			}
		},
		content = {
			text = ""
		},
		style = {
			text = {
				font_size = 18,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	best_performance_1 = create_performance_time_entry("best_performance_1", Localize("dlc1_2_difficulty_survival_hard"), true),
	best_performance_2 = create_performance_time_entry("best_performance_2", Localize("dlc1_2_difficulty_survival_harder"), true),
	best_performance_3 = create_performance_time_entry("best_performance_3", Localize("dlc1_2_difficulty_survival_hardest")),
	title_text = UIWidgets.create_title_text("menu_title_map", "title_text"),
	cancel_button = UIWidgets.create_menu_button_medium("map_screen_cancel_button", "cancel_button"),
	friends_button = UIWidgets.create_octagon_button({
		"map_icon_friends_01",
		"map_icon_friends_02"
	}, {
		"map_friend_button_tooltip",
		"map_friend_button_tooltip"
	}, "friends_button"),
	settings_button = UIWidgets.create_octagon_button({
		"map_icon_advanced_settings_01",
		"map_icon_advanced_settings_02"
	}, {
		"map_advanced_button_tooltip_1",
		"map_advanced_button_tooltip_2"
	}, "settings_button"),
	lobby_button = UIWidgets.create_octagon_button({
		"map_icon_browser_01",
		"map_icon_browser_02"
	}, {
		"lobby_browser_button_name",
		"lobby_browser_button_name"
	}, "lobby_button"),
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
	},
	confirm_button = UIWidgets.create_dice_game_button("confirm_button"),
	confirm_button_disabled_tooltip = UIWidgets.create_simple_tooltip("map_confirm_button_disabled_tooltip", "confirm_button_disabled_tooltip", nil, {
		font_size = 24,
		max_width = 500,
		localize = true,
		cursor_side = "left",
		horizontal_alignment = "left",
		vertical_alignment = "top",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("white", 255),
		line_colors = {},
		offset = {
			0,
			0,
			3
		},
		cursor_offset = {
			-10,
			-10
		}
	}),
	button_eye_glow_widget = UIWidgets.create_simple_texture("forge_button_03_glow_effect", "confirm_button_eye_glow"),
	banner_party_widget = UIWidgets.create_texture_with_text_and_tooltip("title_bar", party_text, "map_party_setting_tooltip", "banner_party", "banner_party_text", {
		vertical_alignment = "center",
		scenegraph_id = "banner_party_text",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	}),
	banner_level_widget = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_level_setting", "map_level_setting_tooltip", "banner_level", "banner_level_text", {
		vertical_alignment = "center",
		scenegraph_id = "banner_level_text",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	}),
	banner_difficulty_widget = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_difficulty_setting", "map_difficulty_setting_tooltip", "banner_difficulty", "banner_difficulty_text", {
		vertical_alignment = "center",
		scenegraph_id = "banner_difficulty_text",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	}),
	banner_performance = UIWidgets.create_simple_text("dlc1_2_map_best_performance", "banner_performance_text", 28, Colors.get_color_table_with_alpha("cheeseburger", 255), {
		vertical_alignment = "center",
		scenegraph_id = "banner_performance_text",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	}),
	banner_hero_list = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_wanted_hero_list_setting", "map_wanted_hero_list_setting_tooltip", "banner_hero_list", "banner_hero_list_text", {
		vertical_alignment = "center",
		scenegraph_id = "banner_hero_list_text",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	}),
	banner_search_zone = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_search_zone_setting", "map_search_zone_setting_tooltip", "banner_level", "banner_level_text", {
		vertical_alignment = "center",
		scenegraph_id = "banner_level_text",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	}),
	banner_host_setting = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_host_setting", "map_host_setting_tooltip", "banner_host_setting", "banner_host_setting_text", {
		vertical_alignment = "center",
		scenegraph_id = "banner_host_setting_text",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	}),
	banner_ready_setting = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_ready_setting", "map_ready_setting_tooltip", "banner_ready_setting", "banner_ready_setting_text", {
		vertical_alignment = "center",
		scenegraph_id = "banner_ready_setting_text",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
	}),
	stepper_ready_setting = UIWidgets.create_map_settings_stepper("stepper_ready_setting", "gamepad_node_ready_setting_stepper"),
	stepper_host_setting = UIWidgets.create_map_settings_stepper("stepper_host_setting", "gamepad_node_host_setting_stepper"),
	stepper_search_zone = UIWidgets.create_map_settings_stepper("stepper_search_zone", "gamepad_node_search_zone_stepper"),
	stepper_game_mode = UIWidgets.create_map_settings_stepper("stepper_game_mode"),
	wanted_hero_list = UIWidgets.create_map_hero_list_widget("wanted_hero_list", "gamepad_node_wanted_hero_list"),
	level_preview_text = UIWidgets.create_simple_text("test", "preview_text", 18, Colors.get_color_table_with_alpha("red", 255), {
		vertical_alignment = "center",
		scenegraph_id = "preview_text",
		horizontal_alignment = "center",
		word_wrap = true,
		font_size = 18,
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("red", 255)
	})
}
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

MapWidgetsGamepadController = {
	level_stepper = {
		input_function = function (widget, input_service)
			local content = widget.content
			content.confirm_pressed = nil

			if input_service.get(input_service, "move_left") then
				content.left_button_hotspot.on_release = true

				return true
			elseif input_service.get(input_service, "move_right") then
				content.right_button_hotspot.on_release = true

				return true
			elseif content.location_selected and input_service.get(input_service, "confirm") then
				content.confirm_pressed = true

				return true
			end

			return 
		end,
		input_description = {
			name = "stepper",
			gamepad_support = true,
			actions = {}
		},
		disabled_input_description = {
			name = "stepper",
			gamepad_support = true,
			actions = {}
		},
		location_input_description = {
			name = "stepper",
			gamepad_support = true,
			actions = {
				{
					input_action = "confirm",
					priority = 8,
					description_text = "input_description_open"
				}
			}
		}
	},
	stepper = {
		input_function = function (widget, input_service)
			local content = widget.content

			if input_service.get(input_service, "move_left") then
				content.left_button_hotspot.on_release = true

				return true
			elseif input_service.get(input_service, "move_right") then
				content.right_button_hotspot.on_release = true

				return true
			end

			return 
		end,
		input_description = {
			name = "stepper",
			gamepad_support = true,
			actions = {}
		},
		disabled_input_description = {
			name = "stepper",
			gamepad_support = true,
			actions = {}
		}
	},
	hero_filter = {
		input_function = function (widget, input_service)
			local content = widget.content

			if input_service.get(input_service, "move_left") then
				local internal_index = content.internal_index
				content.internal_index = math.max(internal_index - 1, 1)

				if internal_index ~= content.internal_index then
					return true
				end
			elseif input_service.get(input_service, "move_right") then
				local internal_index = content.internal_index
				content.internal_index = math.min(internal_index + 1, 5)

				if internal_index ~= content.internal_index then
					return true
				end
			elseif input_service.get(input_service, "confirm") then
				local internal_index = content.internal_index
				local hotspot_name = "hotspot_" .. internal_index
				content[hotspot_name].on_release = true

				return true
			end

			return 
		end,
		input_description = {
			name = "stepper",
			gamepad_support = true,
			actions = {}
		}
	},
	player_entry = {
		input_function = function (widget, input_service)
			local content = widget.content

			if content.kick_enabled and input_service.get(input_service, "confirm", true) then
				content.kick_button_hotspot.on_release = true

				return true
			end

			return 
		end,
		input_description = {
			name = "stepper",
			gamepad_support = true,
			actions = {
				{
					input_action = "confirm",
					priority = 6,
					description_text = "map_setting_kick_player"
				}
			}
		}
	}
}

local function setup_console_widget_selections()
	local steppers = self.steppers
	local console_widget_selections = {
		{
			name = "difficulty",
			gamepad_support = true,
			widget = steppers.difficulty.widget,
			actions = {
				{
					hotspot_id = "left_button_hotspot",
					input_action = "move_left",
					description_text = "input_description_previous"
				},
				{
					hotspot_id = "right_button_hotspot",
					input_action = "move_right",
					description_text = "input_description_next"
				}
			}
		},
		{
			name = "privacy",
			gamepad_support = true,
			widget = steppers.privacy.widget,
			actions = {
				{
					hotspot_id = "left_button_hotspot",
					input_action = "move_left",
					description_text = "input_description_previous"
				},
				{
					hotspot_id = "right_button_hotspot",
					input_action = "move_right",
					description_text = "input_description_next"
				}
			}
		},
		{
			name = "level",
			gamepad_support = true,
			widget = steppers.level.widget,
			actions = {
				{
					hotspot_id = "left_button_hotspot",
					input_action = "move_left",
					description_text = "input_description_previous"
				},
				{
					hotspot_id = "right_button_hotspot",
					input_action = "move_right",
					description_text = "input_description_next"
				}
			}
		},
		{
			name = "play_button",
			gamepad_support = false,
			widget = self.play_button_console_widget,
			actions = {
				{
					hotspot_id = "button_hotspot",
					input_action = "confirm",
					description_text = "input_description_confirm"
				}
			}
		},
		{
			name = "quickmatch_button",
			gamepad_support = false,
			widget = self.quickmatch_button_console_widget,
			actions = {
				{
					hotspot_id = "button_hotspot",
					input_action = "confirm",
					description_text = "input_description_confirm"
				}
			}
		}
	}

	return console_widget_selections
end

local temp_pos = {
	0,
	0,
	0
}

local function animate_style_on_select(style, size, progress, catmullrom_value, default_style, ignore_color)
	local offset_fraction = (progress < 1 and catmullrom_value - 1) or 0
	local original_size = (default_style and default_style.size) or size
	local original_position = (default_style and default_style.position) or temp_pos
	local x_offset = (offset_fraction*original_size[1])/2
	local y_offset = offset_fraction*original_size[2]/2
	style.size[1] = catmullrom_value*original_size[1]
	style.size[2] = catmullrom_value*original_size[2]
	style.offset[1] = original_position[1] + x_offset
	style.offset[2] = original_position[2] + y_offset

	if not ignore_color then
		style.color[1] = math.min(progress*4, 1)*255
	end

	return 
end

local animations = {
	bar_item_select = {
		{
			name = "bar_item_select",
			start_progress = 0,
			end_progress = UISettings.inventory.button_bars.selected_fade_in,
			init = function (ui_scenegraph, scenegraph_definition, widget, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widget, progress, params)
				local catmullrom_value = (progress == 1 and 1) or math.catmullrom(progress, 1, 0.95, 1, 0.7)
				local widget_style = widget.style
				local selected_index = params.selected_index
				local scenegraph_base = params.scenegraph_base
				local scenegraph_id = string.format("%s_%d", scenegraph_base, selected_index)
				local button_click_style = widget_style[string.format("button_click_style_%d", selected_index)]
				local title_text_style = widget_style[string.format("title_text_%d", selected_index)]
				local default_font_size = 20
				title_text_style.font_size = default_font_size*catmullrom_value
				local button_size = scenegraph_definition[scenegraph_id].size

				animate_style_on_select(button_click_style, button_size, progress, catmullrom_value)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widget, params)
				return 
			end
		}
	},
	bar_item_deselect = {
		{
			name = "bar_item_deselect",
			start_progress = 0,
			end_progress = UISettings.inventory.button_bars.selected_fade_out,
			init = function (ui_scenegraph, scenegraph_definition, widget, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widget, progress, params)
				local catmullrom_value = (progress == 1 and 1) or math.catmullrom(progress, 1, 0.95, 1, 0.7)
				local widget_style = widget.style
				local selected_index = params.selected_index
				local scenegraph_base = params.scenegraph_base
				local scenegraph_id = string.format("%s_%d", scenegraph_base, selected_index)
				local button_click_style = widget_style[string.format("button_click_style_%d", selected_index)]
				local title_text_style = widget_style[string.format("title_text_%d", selected_index)]
				local default_font_size = 20
				title_text_style.font_size = default_font_size
				button_click_style.color[1] = math.max(button_click_style.color[1] - progress*255, 0)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widget, params)
				return 
			end
		}
	}
}
local generic_input_actions = {}
local default_input = {
	{
		input_action = "l1_r1",
		priority = 1,
		description_text = "dlc1_2_input_description_switch_game_mode",
		ignore_keybinding = true
	},
	{
		input_action = "left_stick_press",
		priority = 3,
		description_text = "input_description_switch_settings"
	},
	{
		input_action = "right_stick_press",
		priority = 4,
		description_text = "input_description_friends"
	},
	{
		input_action = "special_1",
		priority = 5,
		description_text = "input_description_toggle_private"
	},
	{
		input_action = "back",
		priority = 50,
		description_text = "input_description_close"
	}
}

if Application.platform() == "xb1" then
	table.remove(default_input, 2)
	Application.warning("[MapViewDefinitions] Removed switch settings for lite optional cert")
end

generic_input_actions.play_disabled = table.clone(default_input)
generic_input_actions.default = table.clone(default_input)
generic_input_actions.default[#generic_input_actions.default + 1] = {
	input_action = "refresh",
	priority = 49,
	description_text = "input_description_play"
}
generic_input_actions.dlc_selected = table.clone(default_input)
generic_input_actions.dlc_selected[#generic_input_actions.dlc_selected + 1] = {
	input_action = "refresh",
	priority = 49,
	description_text = "dlc1_4_input_description_storepage"
}
generic_input_actions.play_disabled_step_back = table.clone(default_input)
generic_input_actions.play_disabled_step_back[#generic_input_actions.play_disabled_step_back].description_text = "input_description_back"
generic_input_actions.default_step_back = table.clone(default_input)
generic_input_actions.default_step_back[#generic_input_actions.default_step_back].description_text = "input_description_back"
generic_input_actions.default_step_back[#generic_input_actions.default_step_back + 1] = {
	input_action = "refresh",
	priority = 49,
	description_text = "input_description_play"
}
generic_input_actions.dlc_selected_step_back = table.clone(default_input)
generic_input_actions.dlc_selected_step_back[#generic_input_actions.dlc_selected_step_back].description_text = "input_description_back"
generic_input_actions.dlc_selected_step_back[#generic_input_actions.dlc_selected_step_back + 1] = {
	input_action = "refresh",
	priority = 49,
	description_text = "dlc1_4_input_description_storepage"
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets = widgets,
	create_simple_texture_widget = create_simple_texture_widget,
	create_input_description_widgets = create_input_description_widgets,
	generic_input_actions = generic_input_actions,
	animations = animations
}
