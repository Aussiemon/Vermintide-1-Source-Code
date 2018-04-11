local SIZE_X = 1920
local SIZE_Y = 1080
local RETAINED_MODE_ENABLED = nil
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
			UILayer.end_screen
		}
	},
	screen = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.end_screen
		}
	},
	menu_root = {
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
			0
		}
	},
	reward_title_text = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			560,
			80
		},
		position = {
			0,
			-30,
			0
		}
	},
	reward_name_text = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			560,
			80
		},
		position = {
			0,
			250,
			0
		}
	},
	reward_type_text = {
		vertical_alignment = "center",
		parent = "reward_name_text",
		horizontal_alignment = "center",
		size = {
			560,
			50
		},
		position = {
			0,
			-40,
			1
		}
	},
	exit_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			220,
			62
		},
		position = {
			0,
			0,
			2
		}
	},
	hero_icon = {
		vertical_alignment = "center",
		parent = "reward_title_text",
		horizontal_alignment = "center",
		size = {
			46,
			46
		},
		position = {
			0,
			-50,
			5
		}
	},
	hero_icon_tooltip = {
		vertical_alignment = "center",
		parent = "reward_title_text",
		horizontal_alignment = "center",
		size = {
			46,
			46
		},
		position = {
			0,
			-50,
			5
		}
	},
	trait_button_1 = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			170,
			0
		}
	},
	trait_button_2 = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			170,
			0
		}
	},
	trait_button_3 = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			170,
			0
		}
	},
	trait_button_4 = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			170,
			0
		}
	},
	trait_tooltip_1 = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			170,
			5
		}
	},
	trait_tooltip_2 = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			170,
			5
		}
	},
	trait_tooltip_3 = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			170,
			5
		}
	},
	trait_tooltip_4 = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			170,
			5
		}
	}
}
local default_tooltip_style = {
	font_size = 24,
	max_width = 500,
	localize = false,
	horizontal_alignment = "left",
	vertical_alignment = "top",
	font_type = "hell_shark",
	text_color = Colors.get_color_table_with_alpha("white", 255),
	line_colors = {},
	offset = {
		0,
		0,
		3
	}
}
local trait_tooltip_style = table.clone(default_tooltip_style)
trait_tooltip_style.line_colors = {
	Colors.get_color_table_with_alpha("cheeseburger", 255),
	Colors.get_color_table_with_alpha("white", 255)
}
trait_tooltip_style.last_line_color = Colors.get_color_table_with_alpha("red", 255)
local widget_definitions = {
	reward_title_text = UIWidgets.create_simple_text("dice_game_reward_title", "reward_title_text", 56, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header"),
	reward_name_text = UIWidgets.create_simple_text("", "reward_name_text", 36, Colors.get_color_table_with_alpha("white", 255), nil, "hell_shark_header"),
	reward_type_text = UIWidgets.create_simple_text("", "reward_type_text", 28, Colors.get_color_table_with_alpha("cheeseburger", 255)),
	trait_button_1 = UIWidgets.create_small_trait_button("trait_button_1", "trait_button_1"),
	trait_button_2 = UIWidgets.create_small_trait_button("trait_button_2", "trait_button_2"),
	trait_button_3 = UIWidgets.create_small_trait_button("trait_button_3", "trait_button_3"),
	trait_button_4 = UIWidgets.create_small_trait_button("trait_button_4", "trait_button_4"),
	trait_tooltip_1 = UIWidgets.create_simple_tooltip("", "trait_tooltip_1", nil, trait_tooltip_style),
	trait_tooltip_2 = UIWidgets.create_simple_tooltip("", "trait_tooltip_2", nil, trait_tooltip_style),
	trait_tooltip_3 = UIWidgets.create_simple_tooltip("", "trait_tooltip_3", nil, trait_tooltip_style),
	trait_tooltip_4 = UIWidgets.create_simple_tooltip("", "trait_tooltip_4", nil, trait_tooltip_style),
	hero_icon = UIWidgets.create_simple_texture("hero_icon_medium_dwarf_ranger_yellow", "hero_icon"),
	hero_icon_tooltip = UIWidgets.create_simple_tooltip("", "hero_icon_tooltip", nil, default_tooltip_style)
}
local animation_definitions = {
	contract_entry = {
		{
			name = "reset",
			start_progress = 0,
			end_progress = 0,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local alpha = 0
				local widget_index = params.widget_index
				local widget = widgets[widget_index]
				local widget_style = widget.style
				local widget_content = widget.content
				widget_style.texture_divider.color[1] = alpha
				widget_style.progress_bar.color[1] = alpha
				widget_style.texture_bg.color[1] = alpha
				widget_style.bar_text.text_color[1] = alpha
				widget_style.title_text.text_color[1] = alpha
				widget_style.texture_task_marker_1.color[1] = alpha
				widget_style.texture_task_marker_2.color[1] = alpha
				widget_style.texture_task_marker_3.color[1] = alpha
				widget_style.task_text_1.text_color[1] = alpha
				widget_style.task_text_2.text_color[1] = alpha
				widget_style.task_text_3.text_color[1] = alpha
				widget_style.task_value_1.text_color[1] = alpha
				widget_style.task_value_2.text_color[1] = alpha
				widget_style.task_value_3.text_color[1] = alpha
				widget_style.texture_task_icon_1.color[1] = alpha
				widget_style.texture_task_icon_2.color[1] = alpha
				widget_style.texture_task_icon_3.color[1] = alpha
				local scenegraph_id = "entry_" .. widget_index
				local position = ui_scenegraph[scenegraph_id].local_position
				position[2] = scenegraph_definition[scenegraph_id].position[2]

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local alpha = math.easeCubic(progress) * 255
				local text_alpha = math.easeCubic(progress) * 150
				local widget_index = params.widget_index
				local widget = widgets[widget_index]
				local widget_style = widget.style
				widget_style.texture_divider.color[1] = alpha
				widget_style.progress_bar.color[1] = alpha
				widget_style.texture_bg.color[1] = alpha
				widget_style.bar_text.text_color[1] = text_alpha
				widget_style.title_text.text_color[1] = text_alpha
				widget_style.texture_task_marker_1.color[1] = alpha
				widget_style.texture_task_marker_2.color[1] = alpha
				widget_style.texture_task_marker_3.color[1] = alpha
				widget_style.texture_task_icon_1.color[1] = alpha
				widget_style.texture_task_icon_2.color[1] = alpha
				widget_style.texture_task_icon_3.color[1] = alpha
				widget_style.task_text_1.text_color[1] = text_alpha
				widget_style.task_text_2.text_color[1] = text_alpha
				widget_style.task_text_3.text_color[1] = text_alpha
				widget_style.task_value_1.text_color[1] = text_alpha
				widget_style.task_value_2.text_color[1] = text_alpha
				widget_style.task_value_3.text_color[1] = text_alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	contract_move = {
		{
			name = "move",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local parent_position = ui_scenegraph.pivot.local_position
				params.parent_start_position_x = parent_position[1]

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local parent_position = ui_scenegraph.pivot.local_position
				local parent_default_position = scenegraph_definition.pivot.position
				parent_position[1] = params.parent_start_position_x - 1000 * math.easeOutCubic(progress)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	contracts_exit = {
		{
			name = "fade_in",
			start_progress = 0,
			end_progress = 0.6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local alpha = 255 - math.easeCubic(progress) * 255
				local text_alpha = 150 - math.easeCubic(progress) * 150
				local overlay_alpha = 50 - math.easeCubic(progress) * 50
				local completed_alpha = 120 - math.easeCubic(progress) * 120
				local num_widgets = params.num_widgets

				for i = 1, num_widgets, 1 do
					local widget = widgets[i]
					local widget_style = widget.style

					if overlay_alpha < widget_style.overlay.color[1] then
						widget_style.overlay.color[1] = overlay_alpha
					end

					if completed_alpha < widget_style.texture_completed.color[1] then
						widget_style.texture_completed.color[1] = completed_alpha
					end

					widget_style.texture_divider.color[1] = alpha
					widget_style.progress_bar.color[1] = alpha
					widget_style.texture_bg.color[1] = alpha
					widget_style.bar_text.text_color[1] = text_alpha
					widget_style.title_text.text_color[1] = text_alpha
					widget_style.texture_task_marker_1.color[1] = alpha
					widget_style.texture_task_marker_2.color[1] = alpha
					widget_style.texture_task_marker_3.color[1] = alpha
					widget_style.texture_task_icon_1.color[1] = alpha
					widget_style.texture_task_icon_2.color[1] = alpha
					widget_style.texture_task_icon_3.color[1] = alpha
					widget_style.task_text_1.text_color[1] = text_alpha
					widget_style.task_text_2.text_color[1] = text_alpha
					widget_style.task_text_3.text_color[1] = text_alpha
					widget_style.task_value_1.text_color[1] = text_alpha
					widget_style.task_value_2.text_color[1] = text_alpha
					widget_style.task_value_3.text_color[1] = text_alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	animation_definitions = animation_definitions,
	widget_definitions = widget_definitions
}
