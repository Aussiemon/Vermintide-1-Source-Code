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
	pivot = {
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
	token_icon = {
		vertical_alignment = "center",
		parent = "pivot",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			10
		}
	},
	token_glow = {
		vertical_alignment = "center",
		parent = "token_icon",
		horizontal_alignment = "center",
		size = {
			80,
			64
		},
		position = {
			5,
			-18,
			-1
		}
	},
	token_bg = {
		vertical_alignment = "center",
		parent = "pivot",
		horizontal_alignment = "center",
		size = {
			135,
			135
		},
		position = {
			-1.5,
			0.5,
			1
		}
	},
	glow_background = {
		vertical_alignment = "center",
		parent = "pivot",
		horizontal_alignment = "center",
		size = {
			355,
			426
		},
		position = {
			-3,
			18,
			0
		}
	},
	frame_left = {
		vertical_alignment = "center",
		parent = "pivot",
		horizontal_alignment = "center",
		size = {
			66,
			100
		},
		position = {
			-60,
			-2,
			5
		}
	},
	frame_right = {
		vertical_alignment = "center",
		parent = "pivot",
		horizontal_alignment = "center",
		size = {
			66,
			99
		},
		position = {
			56,
			2.5,
			5
		}
	},
	frame_top = {
		vertical_alignment = "center",
		parent = "pivot",
		horizontal_alignment = "center",
		size = {
			105,
			70
		},
		position = {
			-3.5,
			60,
			5
		}
	},
	frame_bottom = {
		vertical_alignment = "center",
		parent = "pivot",
		horizontal_alignment = "center",
		size = {
			91,
			66
		},
		position = {
			-3.5,
			-56,
			5
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
	}
}
local widget_definitions = {
	icon = UIWidgets.create_simple_texture("token_icon_01_large", "token_icon"),
	token_bg = UIWidgets.create_simple_texture("quest_reward_token_bg", "token_bg"),
	token_glow = UIWidgets.create_simple_texture("quest_token_glow_effect", "token_glow"),
	frame_left = UIWidgets.create_simple_texture("quest_reward_token_frame_04", "frame_left"),
	frame_right = UIWidgets.create_simple_texture("quest_reward_token_frame_02", "frame_right"),
	frame_top = UIWidgets.create_simple_texture("quest_reward_token_frame_01", "frame_top"),
	frame_bottom = UIWidgets.create_simple_texture("quest_reward_token_frame_03", "frame_bottom"),
	title_text = UIWidgets.create_simple_text("dice_game_reward_title", "reward_title_text", 56, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header"),
	name_text = UIWidgets.create_simple_text("", "reward_name_text", 36, Colors.get_color_table_with_alpha("white", 255), nil, "hell_shark_header"),
	type_text = UIWidgets.create_simple_text("", "reward_type_text", 28, Colors.get_color_table_with_alpha("cheeseburger", 255)),
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
	}, "banner_bg")
}
local animation_definitions = {
	token = {
		{
			name = "reset",
			start_progress = 0,
			end_progress = 0,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				for _, widget in pairs(widgets) do
					local widget_color = (widget.style.texture_id and widget.style.texture_id.color) or widget.style.text.text_color
					widget_color[1] = 0
				end

				local banner_bg_size = ui_scenegraph.banner_bg.size
				banner_bg_size[2] = 0
				widgets.banner_bg.style.texture_id.color[1] = 255

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
			name = "reset_frame",
			start_progress = 0,
			end_progress = 0,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				ui_scenegraph.frame_top.local_position[2] = scenegraph_definition.frame_top.position[2] + 300
				ui_scenegraph.frame_left.local_position[1] = scenegraph_definition.frame_left.position[1] - 300
				ui_scenegraph.frame_right.local_position[1] = scenegraph_definition.frame_right.position[1] + 300
				ui_scenegraph.frame_bottom.local_position[2] = scenegraph_definition.frame_bottom.position[2] - 300

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
			name = "fade_in_background",
			start_progress = 0,
			end_progress = 0.4,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local widget = widgets.token_bg
				local widget_color = widget.style.texture_id.color
				widget_color[1] = 255 * math.easeInCubic(progress)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "frame_move_1",
			start_progress = 0.6,
			end_progress = 0.8,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_in_exp(progress)
				local distance = (1 - eased_progress) * 300
				ui_scenegraph.frame_top.local_position[2] = scenegraph_definition.frame_top.position[2] + distance
				local alpha = 255 * math.ease_exp(progress)
				local frame_top = widgets.frame_top
				frame_top.style.texture_id.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_quest_menu_finish_quest_turn_in_stone_metal_hit")

				return 
			end
		},
		{
			name = "frame_move_2",
			start_progress = 0.75,
			end_progress = 1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_in_exp(progress)
				local distance = (1 - eased_progress) * 300
				ui_scenegraph.frame_bottom.local_position[2] = scenegraph_definition.frame_bottom.position[2] - distance
				local alpha = 255 * math.ease_exp(progress)
				local frame_bottom = widgets.frame_bottom
				frame_bottom.style.texture_id.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_quest_menu_finish_quest_turn_in_stone_metal_hit")

				return 
			end
		},
		{
			name = "frame_move_3",
			start_progress = 0.9,
			end_progress = 1.1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_in_exp(progress)
				local distance = (1 - eased_progress) * 300
				ui_scenegraph.frame_left.local_position[1] = scenegraph_definition.frame_left.position[1] - distance
				local alpha = 255 * math.ease_exp(progress)
				local frame_left = widgets.frame_left
				frame_left.style.texture_id.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_quest_menu_finish_quest_turn_in_stone_metal_hit")

				return 
			end
		},
		{
			name = "frame_move_4",
			start_progress = 1.05,
			end_progress = 1.25,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.ease_in_exp(progress)
				local distance = (1 - eased_progress) * 300
				ui_scenegraph.frame_right.local_position[1] = scenegraph_definition.frame_right.position[1] + distance
				local alpha = 255 * math.ease_exp(progress)
				local frame_right = widgets.frame_right
				frame_right.style.texture_id.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_quest_menu_finish_quest_turn_in_stone_metal_hit")

				return 
			end
		},
		{
			name = "icon_size_decrease",
			start_progress = 1.3,
			end_progress = 1.45,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeOutCubic(progress)
				local scale_progress = math.catmullrom(eased_progress, 4, 4, 1, 1)
				local token_icon_size = ui_scenegraph.token_icon.size
				local token_icon_default_size = scenegraph_definition.token_icon.size
				token_icon_size[1] = token_icon_default_size[1] * scale_progress
				token_icon_size[2] = token_icon_default_size[2] * scale_progress

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_quest_menu_finish_quest_turn_in_reward_stone")

				return 
			end
		},
		{
			name = "fade_in_icon",
			start_progress = 1.3,
			end_progress = 1.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local widget = widgets.icon
				local widget_color = widget.style.texture_id.color
				widget_color[1] = 255 * math.easeOutCubic(progress)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_glow",
			start_progress = 1.35,
			end_progress = 1.55,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeOutCubic(progress)
				local widget = widgets.token_glow
				local widget_color = widget.style.texture_id.color
				widget_color[1] = 255 * eased_progress

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "bump",
			start_progress = 1.45,
			end_progress = 1.65,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local eased_progress = math.easeOutCubic(progress)
				local scale_progress = math.catmullrom(eased_progress, 2, 1, 1, 2)
				local frame_top_size = ui_scenegraph.frame_top.size
				local frame_top_default_size = scenegraph_definition.frame_top.size
				local frame_left_size = ui_scenegraph.frame_left.size
				local frame_left_default_size = scenegraph_definition.frame_left.size
				local frame_right_size = ui_scenegraph.frame_right.size
				local frame_right_default_size = scenegraph_definition.frame_right.size
				local frame_bottom_size = ui_scenegraph.frame_bottom.size
				local frame_bottom_default_size = scenegraph_definition.frame_bottom.size
				frame_top_size[1] = frame_top_default_size[1] * scale_progress
				frame_top_size[2] = frame_top_default_size[2] * scale_progress
				frame_left_size[1] = frame_left_default_size[1] * scale_progress
				frame_left_size[2] = frame_left_default_size[2] * scale_progress
				frame_right_size[1] = frame_right_default_size[1] * scale_progress
				frame_right_size[2] = frame_right_default_size[2] * scale_progress
				frame_bottom_size[1] = frame_bottom_default_size[1] * scale_progress
				frame_bottom_size[2] = frame_bottom_default_size[2] * scale_progress
				ui_scenegraph.frame_top.local_position[2] = scenegraph_definition.frame_top.position[2] * scale_progress
				ui_scenegraph.frame_left.local_position[1] = scenegraph_definition.frame_left.position[1] * scale_progress
				ui_scenegraph.frame_right.local_position[1] = scenegraph_definition.frame_right.position[1] * scale_progress
				ui_scenegraph.frame_bottom.local_position[2] = scenegraph_definition.frame_bottom.position[2] * scale_progress
				local token_bg_size = ui_scenegraph.token_bg.size
				local token_bg_default_size = scenegraph_definition.token_bg.size
				token_bg_size[1] = token_bg_default_size[1] * scale_progress
				token_bg_size[2] = token_bg_default_size[2] * scale_progress
				local token_icon_size = ui_scenegraph.token_icon.size
				local token_icon_default_size = scenegraph_definition.token_icon.size
				token_icon_size[1] = token_icon_default_size[1] * scale_progress
				token_icon_size[2] = token_icon_default_size[2] * scale_progress
				local token_glow_size = ui_scenegraph.token_glow.size
				local token_glow_default_size = scenegraph_definition.token_glow.size
				token_glow_size[1] = token_glow_default_size[1] * scale_progress
				token_glow_size[2] = token_glow_default_size[2] * scale_progress

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_banner_top",
			start_progress = 1.6,
			end_progress = 2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local alpha = 255 * math.easeCubic(progress)
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
			start_progress = 2,
			end_progress = 2.5,
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
				banner_bg_size[2] = anim_progress * banner_bg_default_size[2]
				uvs[2][2] = math.min(anim_progress, 1)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "title_fade_in",
			start_progress = 2.4,
			end_progress = 2.9,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local alpha = 255 * math.easeOutCubic(progress)
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
