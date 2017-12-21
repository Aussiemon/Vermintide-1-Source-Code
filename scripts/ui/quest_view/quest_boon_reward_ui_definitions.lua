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
			-260,
			0
		}
	},
	reward_name_text = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			560,
			80
		},
		position = {
			0,
			-140,
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
	boon_pivot = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			45,
			1
		}
	},
	boon_icon = {
		vertical_alignment = "center",
		parent = "boon_pivot",
		horizontal_alignment = "center",
		size = {
			38,
			38
		},
		position = {
			0,
			0,
			4
		}
	},
	boon_bg = {
		vertical_alignment = "center",
		parent = "boon_pivot",
		horizontal_alignment = "center",
		size = {
			66,
			66
		},
		position = {
			0,
			0,
			2
		}
	},
	glow_background = {
		vertical_alignment = "center",
		parent = "boon_pivot",
		horizontal_alignment = "center",
		size = {
			260,
			280
		},
		position = {
			2,
			-4,
			1
		}
	},
	icon_frame_glow = {
		vertical_alignment = "center",
		parent = "boon_icon",
		horizontal_alignment = "center",
		size = {
			164,
			140
		},
		position = {
			0,
			0,
			-2
		}
	},
	banner_top = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			626,
			49
		},
		position = {
			0,
			-130,
			0
		}
	},
	banner_bg = {
		vertical_alignment = "top",
		parent = "banner_top",
		horizontal_alignment = "center",
		size = {
			384,
			790
		},
		position = {
			0,
			-25,
			-1
		}
	},
	part_1 = {
		vertical_alignment = "top",
		parent = "boon_bg",
		horizontal_alignment = "left",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			3
		}
	},
	part_1_corner = {
		vertical_alignment = "bottom",
		parent = "part_1",
		horizontal_alignment = "right",
		size = {
			12,
			12
		},
		position = {
			6,
			-6,
			-1
		}
	},
	part_1_1 = {
		vertical_alignment = "bottom",
		parent = "part_1",
		horizontal_alignment = "right",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			1
		}
	},
	part_1_2 = {
		vertical_alignment = "bottom",
		parent = "part_1",
		horizontal_alignment = "right",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			1
		}
	},
	part_2 = {
		vertical_alignment = "top",
		parent = "boon_bg",
		horizontal_alignment = "right",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			3
		}
	},
	part_2_corner = {
		vertical_alignment = "bottom",
		parent = "part_2",
		horizontal_alignment = "left",
		size = {
			12,
			12
		},
		position = {
			-6,
			-6,
			-1
		}
	},
	part_2_1 = {
		vertical_alignment = "bottom",
		parent = "part_2",
		horizontal_alignment = "left",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			1
		}
	},
	part_2_2 = {
		vertical_alignment = "bottom",
		parent = "part_2",
		horizontal_alignment = "left",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			1
		}
	},
	part_3 = {
		vertical_alignment = "bottom",
		parent = "boon_bg",
		horizontal_alignment = "left",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			3
		}
	},
	part_3_corner = {
		vertical_alignment = "top",
		parent = "part_3",
		horizontal_alignment = "right",
		size = {
			12,
			12
		},
		position = {
			6,
			6,
			-1
		}
	},
	part_3_1 = {
		vertical_alignment = "bottom",
		parent = "part_3",
		horizontal_alignment = "right",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			1
		}
	},
	part_3_2 = {
		vertical_alignment = "bottom",
		parent = "part_3",
		horizontal_alignment = "right",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			1
		}
	},
	part_4 = {
		vertical_alignment = "bottom",
		parent = "boon_bg",
		horizontal_alignment = "right",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			3
		}
	},
	part_4_corner = {
		vertical_alignment = "top",
		parent = "part_4",
		horizontal_alignment = "left",
		size = {
			12,
			12
		},
		position = {
			-6,
			6,
			-1
		}
	},
	part_4_1 = {
		vertical_alignment = "bottom",
		parent = "part_4",
		horizontal_alignment = "left",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			1
		}
	},
	part_4_2 = {
		vertical_alignment = "bottom",
		parent = "part_4",
		horizontal_alignment = "left",
		size = {
			33,
			33
		},
		position = {
			0,
			0,
			1
		}
	},
	glow_pivot = {
		vertical_alignment = "center",
		parent = "boon_bg",
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
	boon_glow_01 = {
		vertical_alignment = "bottom",
		parent = "glow_pivot",
		horizontal_alignment = "center",
		size = {
			60,
			80
		},
		position = {
			0,
			0,
			1
		}
	},
	boon_glow_02 = {
		vertical_alignment = "top",
		parent = "glow_pivot",
		horizontal_alignment = "center",
		size = {
			60,
			80
		},
		position = {
			0,
			0,
			1
		}
	},
	boon_glow_03 = {
		vertical_alignment = "center",
		parent = "glow_pivot",
		horizontal_alignment = "left",
		size = {
			60,
			80
		},
		position = {
			0,
			0,
			1
		}
	},
	boon_glow_04 = {
		vertical_alignment = "center",
		parent = "glow_pivot",
		horizontal_alignment = "right",
		size = {
			60,
			80
		},
		position = {
			0,
			0,
			1
		}
	},
	boon_glow_05 = {
		vertical_alignment = "bottom",
		parent = "glow_pivot",
		horizontal_alignment = "left",
		size = {
			60,
			60
		},
		position = {
			0,
			0,
			1
		}
	},
	boon_glow_06 = {
		vertical_alignment = "top",
		parent = "glow_pivot",
		horizontal_alignment = "right",
		size = {
			60,
			60
		},
		position = {
			0,
			0,
			1
		}
	},
	boon_glow_07 = {
		vertical_alignment = "top",
		parent = "glow_pivot",
		horizontal_alignment = "left",
		size = {
			60,
			60
		},
		position = {
			0,
			0,
			1
		}
	},
	boon_glow_08 = {
		vertical_alignment = "bottom",
		parent = "glow_pivot",
		horizontal_alignment = "right",
		size = {
			60,
			60
		},
		position = {
			0,
			0,
			1
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
	boon_icon = UIWidgets.create_simple_texture("teammate_consumable_icon_medpack", "boon_icon"),
	boon_bg = UIWidgets.create_simple_texture("quest_reward_boon_bg", "boon_bg"),
	glow_background = UIWidgets.create_simple_texture("quest_reward_boon_glow_bg", "glow_background"),
	icon_frame_glow = UIWidgets.create_simple_texture("quest_reward_boon_icon_frame", "icon_frame_glow"),
	banner_top = UIWidgets.create_simple_texture("quest_reward_banner_top", "banner_top"),
	banner_bg = UIWidgets.create_simple_uv_texture("quest_reward_banner", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "banner_bg"),
	part_1_corner = UIWidgets.create_simple_texture("quest_reward_boon_detail", "part_1_corner"),
	part_1_1 = UIWidgets.create_simple_rotated_texture("quest_reward_boon_frame_01", 0, {
		33,
		0
	}, "part_1_1"),
	part_1_2 = UIWidgets.create_simple_rotated_texture("quest_reward_boon_frame_02", 0, {
		33,
		0
	}, "part_1_2"),
	part_2_corner = UIWidgets.create_simple_texture("quest_reward_boon_detail", "part_2_corner"),
	part_2_1 = UIWidgets.create_simple_rotated_texture("quest_reward_boon_frame_06", 0, {
		0,
		0
	}, "part_2_1"),
	part_2_2 = UIWidgets.create_simple_rotated_texture("quest_reward_boon_frame_05", 0, {
		0,
		0
	}, "part_2_2"),
	part_3_corner = UIWidgets.create_simple_texture("quest_reward_boon_detail", "part_3_corner"),
	part_3_1 = UIWidgets.create_simple_rotated_texture("quest_reward_boon_frame_03", 0, {
		33,
		33
	}, "part_3_1"),
	part_3_2 = UIWidgets.create_simple_rotated_texture("quest_reward_boon_frame_04", 0, {
		33,
		33
	}, "part_3_2"),
	part_4_corner = UIWidgets.create_simple_texture("quest_reward_boon_detail", "part_4_corner"),
	part_4_1 = UIWidgets.create_simple_rotated_texture("quest_reward_boon_frame_08", 0, {
		0,
		33
	}, "part_4_1"),
	part_4_2 = UIWidgets.create_simple_rotated_texture("quest_reward_boon_frame_07", 0, {
		0,
		33
	}, "part_4_2"),
	boon_glow_01 = UIWidgets.create_simple_gradient_mask_texture("quest_boon_glow_01", "boon_glow_01"),
	boon_glow_02 = UIWidgets.create_simple_gradient_mask_texture("quest_boon_glow_02", "boon_glow_02"),
	boon_glow_03 = UIWidgets.create_simple_gradient_mask_texture("quest_boon_glow_03", "boon_glow_03"),
	boon_glow_04 = UIWidgets.create_simple_gradient_mask_texture("quest_boon_glow_04", "boon_glow_04"),
	boon_glow_05 = UIWidgets.create_simple_gradient_mask_texture("quest_boon_glow_05", "boon_glow_05"),
	boon_glow_06 = UIWidgets.create_simple_gradient_mask_texture("quest_boon_glow_06", "boon_glow_06"),
	boon_glow_07 = UIWidgets.create_simple_gradient_mask_texture("quest_boon_glow_07", "boon_glow_07"),
	boon_glow_08 = UIWidgets.create_simple_gradient_mask_texture("quest_boon_glow_08", "boon_glow_08"),
	title_text = UIWidgets.create_simple_text("dice_game_reward_title", "reward_title_text", 56, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header"),
	name_text = UIWidgets.create_simple_text("", "reward_name_text", 36, Colors.get_color_table_with_alpha("white", 255), nil, "hell_shark_header"),
	type_text = UIWidgets.create_simple_text("", "reward_type_text", 28, Colors.get_color_table_with_alpha("cheeseburger", 255))
}
local animation_definitions = {
	boon = {
		{
			name = "reset",
			start_progress = 0,
			end_progress = 0,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				widgets.part_1_1.style.texture_id.angle = 0
				widgets.part_1_2.style.texture_id.angle = 0
				widgets.part_2_1.style.texture_id.angle = 0
				widgets.part_2_2.style.texture_id.angle = 0
				widgets.part_3_1.style.texture_id.angle = 0
				widgets.part_3_2.style.texture_id.angle = 0
				widgets.part_4_1.style.texture_id.angle = 0
				widgets.part_4_2.style.texture_id.angle = 0
				ui_scenegraph.part_1.local_position[1] = scenegraph_definition.part_1.position[1]
				ui_scenegraph.part_1.local_position[2] = scenegraph_definition.part_1.position[2]
				ui_scenegraph.part_2.local_position[1] = scenegraph_definition.part_2.position[1]
				ui_scenegraph.part_2.local_position[2] = scenegraph_definition.part_2.position[2]
				ui_scenegraph.part_3.local_position[1] = scenegraph_definition.part_3.position[1]
				ui_scenegraph.part_3.local_position[2] = scenegraph_definition.part_3.position[2]
				ui_scenegraph.part_4.local_position[1] = scenegraph_definition.part_4.position[1]
				ui_scenegraph.part_4.local_position[2] = scenegraph_definition.part_4.position[2]
				local gradient_threshold = 0
				widgets.boon_glow_01.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_02.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_03.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_04.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_05.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_06.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_07.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_08.style.texture_id.gradient_threshold = gradient_threshold
				local banner_bg_size = ui_scenegraph.banner_bg.size
				banner_bg_size[2] = 0
				local alpha = 0
				widgets.title_text.style.text.text_color[1] = alpha
				widgets.name_text.style.text.text_color[1] = alpha
				widgets.type_text.style.text.text_color[1] = alpha

				for i = 1, 4, 1 do
					local prefix_name = "part_" .. i

					for k = 1, 2, 1 do
						local part_name = prefix_name .. "_" .. k
						local widget = widgets[part_name]
						local texture_style = widget.style.texture_id
						widget.style.texture_id.color[1] = alpha
					end

					local corner_name = prefix_name .. "_corner"
					local widget = widgets[corner_name]
					widget.style.texture_id.color[1] = alpha
				end

				local bg_widget = widgets.boon_bg
				local icon_widget = widgets.boon_icon
				local glow_bg_widget = widgets.glow_background
				local icon_frame_widget = widgets.icon_frame_glow
				local banner_top_widget = widgets.banner_top
				banner_top_widget.style.texture_id.color[1] = alpha
				bg_widget.style.texture_id.color[1] = alpha
				icon_widget.style.texture_id.color[1] = alpha
				glow_bg_widget.style.texture_id.color[1] = alpha
				icon_frame_widget.style.texture_id.color[1] = alpha

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
			name = "widget_fade_in",
			start_progress = 0.2,
			end_progress = 0.4,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local alpha = math.easeOutCubic(progress)*255

				for i = 1, 4, 1 do
					local prefix_name = "part_" .. i

					for k = 1, 2, 1 do
						local part_name = prefix_name .. "_" .. k
						local widget = widgets[part_name]
						local texture_style = widget.style.texture_id
						widget.style.texture_id.color[1] = alpha
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local alpha = 255

				for i = 1, 4, 1 do
					local prefix_name = "part_" .. i
					local corner_name = prefix_name .. "_corner"
					local widget = widgets[corner_name]
					widget.style.texture_id.color[1] = alpha
				end

				local bg_widget = widgets.boon_bg
				local icon_widget = widgets.boon_icon
				bg_widget.style.texture_id.color[1] = alpha
				icon_widget.style.texture_id.color[1] = alpha

				return 
			end
		},
		{
			name = "rumble_1",
			start_progress = 0.7,
			end_progress = 1.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeCubic(progress)
				local position = ui_scenegraph.boon_bg.local_position
				local default_position = scenegraph_definition.boon_bg.position
				local amount = 7
				position[1] = (default_position[1] + amount) - amount*math.catmullrom(math.bounce(eased_progress), 2, 1, 1, -1)
				position[2] = (default_position[2] + amount) - amount*math.catmullrom(math.bounce(eased_progress), -1, 1, 1, 2)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "glow_spread",
			start_progress = 0.4,
			end_progress = 1.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeInCubic(progress)
				local gradient_threshold = eased_progress
				widgets.boon_glow_01.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_02.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_03.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_04.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_05.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_06.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_07.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_08.style.texture_id.gradient_threshold = gradient_threshold

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "glow_despread",
			start_progress = 1.7,
			end_progress = 1.9,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeInCubic(progress - 1)
				local gradient_threshold = eased_progress
				widgets.boon_glow_01.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_02.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_03.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_04.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_05.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_06.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_07.style.texture_id.gradient_threshold = gradient_threshold
				widgets.boon_glow_08.style.texture_id.gradient_threshold = gradient_threshold

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_glow_bg",
			start_progress = 1.6,
			end_progress = 2.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local pulse_progress = math.ease_pulse(progress)
				local alpha = pulse_progress*255
				local widget = widgets.glow_background
				widget.style.texture_id.color[1] = alpha
				local eased_progress = math.ease_in_exp(progress)
				local scale_progress = math.catmullrom(eased_progress, 1, 1, 6, -1)
				local glow_background_size = ui_scenegraph.glow_background.size
				local glow_background_default_size = scenegraph_definition.glow_background.size
				glow_background_size[1] = glow_background_default_size[1]*scale_progress
				glow_background_size[2] = glow_background_default_size[2]*scale_progress

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "move_part_1",
			start_progress = 1.8,
			end_progress = 2.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeOutCubic(progress)
				local distance = eased_progress*33
				local position = ui_scenegraph.part_1.local_position
				local default_position = scenegraph_definition.part_1.position
				position[1] = default_position[1] - distance
				position[2] = default_position[2] + distance

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "move_part_2",
			start_progress = 1.8,
			end_progress = 2.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeOutCubic(progress)
				local distance = eased_progress*33
				local position = ui_scenegraph.part_2.local_position
				local default_position = scenegraph_definition.part_2.position
				position[1] = default_position[1] + distance
				position[2] = default_position[2] + distance

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "move_part_3",
			start_progress = 1.8,
			end_progress = 2.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeOutCubic(progress)
				local distance = eased_progress*33
				local position = ui_scenegraph.part_3.local_position
				local default_position = scenegraph_definition.part_3.position
				position[1] = default_position[1] - distance
				position[2] = default_position[2] - distance

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "move_part_4",
			start_progress = 1.8,
			end_progress = 2.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeOutCubic(progress)
				local distance = eased_progress*33
				local position = ui_scenegraph.part_4.local_position
				local default_position = scenegraph_definition.part_4.position
				position[1] = default_position[1] + distance
				position[2] = default_position[2] - distance

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "open_part_1",
			start_progress = 1.8,
			end_progress = 2.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_in_exp(progress)
				local part_1 = widgets.part_1_1
				local part_2 = widgets.part_1_2
				local angle = math.degrees_to_radians(90)
				local progress_angle = angle*eased_progress
				part_1.style.texture_id.angle = -progress_angle
				part_2.style.texture_id.angle = progress_angle

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "open_part_2",
			start_progress = 1.8,
			end_progress = 2.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_in_exp(progress)
				local part_1 = widgets.part_2_1
				local part_2 = widgets.part_2_2
				local angle = math.degrees_to_radians(90)
				local progress_angle = angle*eased_progress
				part_1.style.texture_id.angle = -progress_angle
				part_2.style.texture_id.angle = progress_angle

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "open_part_3",
			start_progress = 1.8,
			end_progress = 2.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_in_exp(progress)
				local part_1 = widgets.part_3_1
				local part_2 = widgets.part_3_2
				local angle = math.degrees_to_radians(90)
				local progress_angle = angle*eased_progress
				part_1.style.texture_id.angle = progress_angle
				part_2.style.texture_id.angle = -progress_angle

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "open_part_4",
			start_progress = 1.8,
			end_progress = 2.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_in_exp(progress)
				local part_1 = widgets.part_4_1
				local part_2 = widgets.part_4_2
				local angle = math.degrees_to_radians(90)
				local progress_angle = angle*eased_progress
				part_1.style.texture_id.angle = progress_angle
				part_2.style.texture_id.angle = -progress_angle

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_quest_menu_finish_quest_turn_in_reward_boon")

				return 
			end
		},
		{
			name = "bump",
			start_progress = 2.2,
			end_progress = 2.4,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_out_exp(progress)
				local scale_progress = math.catmullrom(eased_progress, 2, 1, 1, 2)

				for i = 1, 4, 1 do
					local prefix_name = "part_" .. i

					for k = 1, 2, 1 do
						local part_name = prefix_name .. "_" .. k
						local part_size = ui_scenegraph[part_name].size
						local part_default_size = scenegraph_definition[part_name].size
						part_size[1] = part_default_size[1]*scale_progress
						part_size[2] = part_default_size[2]*scale_progress
						local widget = widgets[part_name]
						local texture_style = widget.style.texture_id
						local pivot = texture_style.pivot
						local offset = texture_style.offset

						if not texture_style.default_pivot then
							texture_style.default_pivot = table.clone(pivot)
						end

						local default_pivot = texture_style.default_pivot
						pivot[2] = default_pivot[2]*scale_progress
						pivot[1] = default_pivot[1]*scale_progress

						if 2 < i then
							offset[2] = part_default_size[2] - part_size[2]
						end
					end

					local corner_name = prefix_name .. "_corner"
					local corner_size = ui_scenegraph[corner_name].size
					local corner_default_size = scenegraph_definition[corner_name].size
					corner_size[1] = corner_default_size[1]*scale_progress
					corner_size[2] = corner_default_size[2]*scale_progress
				end

				local boon_bg_size = ui_scenegraph.boon_bg.size
				local boon_bg_default_size = scenegraph_definition.boon_bg.size
				boon_bg_size[1] = boon_bg_default_size[1]*scale_progress
				boon_bg_size[2] = boon_bg_default_size[2]*scale_progress
				local boon_icon_size = ui_scenegraph.boon_icon.size
				local boon_icon_default_size = scenegraph_definition.boon_icon.size
				boon_icon_size[1] = boon_icon_default_size[1]*scale_progress
				boon_icon_size[2] = boon_icon_default_size[2]*scale_progress

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_banner_top",
			start_progress = 2.2,
			end_progress = 2.6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local alpha = math.easeCubic(progress)*255
				local widget = widgets.banner_top
				widget.style.texture_id.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_quest_menu_finish_quest_turn_in_reward_cloth")

				return 
			end
		},
		{
			name = "banner_entry",
			start_progress = 2.6,
			end_progress = 3.1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local widget = widgets.banner_bg
				local texture_style = widget.style.texture_id
				local texture_content = widget.content.texture_id
				local uvs = texture_content.uvs
				local anim_progress = math.catmullrom(math.easeInCubic(progress), 0, 0, 1, 1)
				local banner_bg_size = ui_scenegraph.banner_bg.size
				local banner_bg_default_size = scenegraph_definition.banner_bg.size
				banner_bg_size[2] = anim_progress*banner_bg_default_size[2]
				uvs[2][2] = math.min(anim_progress, 1)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "title_fade_in",
			start_progress = 3,
			end_progress = 3.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local alpha = math.easeOutCubic(progress)*255
				widgets.title_text.style.text.text_color[1] = alpha
				widgets.name_text.style.text.text_color[1] = alpha
				widgets.type_text.style.text.text_color[1] = alpha

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
