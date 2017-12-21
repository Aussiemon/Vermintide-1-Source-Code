local SIZE_X = 1920
local SIZE_Y = 1080
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.hud
		},
		size = {
			SIZE_X,
			SIZE_Y
		}
	},
	background = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		position = {
			0,
			340,
			1
		},
		size = {
			819,
			222
		}
	},
	background_top = {
		vertical_alignment = "bottom",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0.5,
			119,
			2
		},
		size = {
			819,
			119
		}
	},
	background_bottom = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0.5,
			-103,
			2
		},
		size = {
			819,
			103
		}
	},
	background_center = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			8,
			1
		},
		size = {
			819,
			79
		}
	},
	difficulty_title_text = {
		vertical_alignment = "center",
		parent = "background_center",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			5
		},
		size = {
			1500,
			50
		}
	},
	difficulty_text = {
		vertical_alignment = "center",
		parent = "background_center",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			5
		},
		size = {
			1500,
			50
		}
	}
}
local widget_definitions = {
	background_top = UIWidgets.create_simple_texture("hud_difficulty_notification_bg_top", "background_top"),
	background_center = UIWidgets.create_simple_uv_texture("hud_difficulty_notification_bg_center", {
		{
			0,
			0.5
		},
		{
			1,
			0.5
		}
	}, "background_center"),
	background_bottom = UIWidgets.create_simple_texture("hud_difficulty_notification_bg_bottom", "background_bottom"),
	difficulty_title_text = UIWidgets.create_simple_text("dlc1_2_difficulty_notification_complete_text", "difficulty_title_text", 40, Colors.get_color_table_with_alpha("cheeseburger", 0)),
	difficulty_text = UIWidgets.create_simple_text("dlc1_2_difficulty_notification_info_text", "difficulty_text", 40, Colors.get_color_table_with_alpha("white", 0))
}
local animations = {
	presentation = {
		{
			name = "reset",
			start_progress = 0,
			end_progress = 0,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local difficulty_text_widget = widgets.difficulty_text
				difficulty_text_widget.style.text.text_color[1] = 0
				local background_top_widget = widgets.background_top
				local background_bottom_widget = widgets.background_bottom
				local background_center_widget = widgets.background_center
				local background_center_scenegraph_id = background_center_widget.scenegraph_id
				local current_background_center_size = ui_scenegraph[background_center_scenegraph_id].size
				current_background_center_size[2] = 0
				background_top_widget.style.texture_id.color[1] = 0
				background_bottom_widget.style.texture_id.color[1] = 0
				background_center_widget.style.texture_id.color[1] = 255

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
			name = "background_fade_in",
			start_progress = 0,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				if not params.played_start_sound then
					params.played_start_sound = true

					WwiseWorld.trigger_event(params.wwise_world, "hud_difficulty_increased_start")
				end

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local anim_fraction = math.easeInCubic(progress)
				local background_top_widget = widgets.background_top
				local background_bottom_widget = widgets.background_bottom
				local alpha = anim_fraction*255
				background_top_widget.style.texture_id.color[1] = alpha
				background_bottom_widget.style.texture_id.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "background_entry",
			start_progress = 0.2,
			end_progress = 0.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local anim_fraction = math.easeOutCubic(progress)
				local background_top_widget = widgets.background_top
				local background_top_scenegraph_id = background_top_widget.scenegraph_id
				local default_background_top_size = scenegraph_definition[background_top_scenegraph_id].size
				local current_background_top_size = ui_scenegraph[background_top_scenegraph_id].size
				local background_bottom_widget = widgets.background_bottom
				local background_bottom_scenegraph_id = background_bottom_widget.scenegraph_id
				local default_background_bottom_size = scenegraph_definition[background_bottom_scenegraph_id].size
				local current_background_bottom_size = ui_scenegraph[background_bottom_scenegraph_id].size
				local anim_size_fraction = math.catmullrom(progress, -4, 1, 1, -1)
				current_background_top_size[1] = default_background_top_size[1]*anim_size_fraction
				current_background_top_size[2] = default_background_top_size[2]*anim_size_fraction
				current_background_bottom_size[1] = default_background_bottom_size[1]*anim_size_fraction
				current_background_bottom_size[2] = default_background_bottom_size[2]*anim_size_fraction

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "background_expand",
			start_progress = 0.4,
			end_progress = 0.7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local anim_fraction = math.easeOutCubic(progress)
				local background_top_widget = widgets.background_top
				local background_top_scenegraph_id = background_top_widget.scenegraph_id
				local default_background_top_position = scenegraph_definition[background_top_scenegraph_id].position
				local current_background_top_position = ui_scenegraph[background_top_scenegraph_id].local_position
				local background_bottom_widget = widgets.background_bottom
				local background_bottom_scenegraph_id = background_bottom_widget.scenegraph_id
				local default_background_bottom_position = scenegraph_definition[background_bottom_scenegraph_id].position
				local current_background_bottom_position = ui_scenegraph[background_bottom_scenegraph_id].local_position
				local background_center_widget = widgets.background_center
				local background_center_scenegraph_id = background_center_widget.scenegraph_id
				local current_background_center_size = ui_scenegraph[background_center_scenegraph_id].size
				local default_background_center_size = scenegraph_definition[background_center_scenegraph_id].size
				local center_uvs = background_center_widget.content.texture_id.uvs
				local total_uv_change = anim_fraction*0.5
				center_uvs[1][2] = total_uv_change
				center_uvs[2][2] = total_uv_change - 1
				current_background_center_size[2] = default_background_center_size[2]*anim_fraction
				local half_center_height = default_background_center_size[2]/2
				current_background_top_position[2] = default_background_top_position[2] + half_center_height*anim_fraction
				current_background_bottom_position[2] = default_background_bottom_position[2] - half_center_height*anim_fraction

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_title_text",
			start_progress = 0.7,
			end_progress = 0.9,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				if not params.played_text_reveal_sound_1 then
					params.played_text_reveal_sound_1 = true

					WwiseWorld.trigger_event(params.wwise_world, "hud_compleation_ver2")
				end

				local anim_fraction = math.easeOutCubic(progress)
				local difficulty_title_text_widget = widgets.difficulty_title_text
				local text_style = difficulty_title_text_widget.style.text
				text_style.text_color[1] = anim_fraction*255
				text_style.font_size = math.catmullrom(math.easeOutCubic(progress), -0.5, 1, 1, -0.5)*40

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_title_text",
			start_progress = 2.3,
			end_progress = 2.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local anim_fraction = math.easeOutCubic(progress)
				local difficulty_title_text_widget = widgets.difficulty_title_text
				difficulty_title_text_widget.style.text.text_color[1] = anim_fraction*255 - 255

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in_text",
			start_progress = 2.6,
			end_progress = 2.8,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				if not params.played_text_reveal_sound then
					params.played_text_reveal_sound = true

					WwiseWorld.trigger_event(params.wwise_world, "music_stinger_survival_difficulty_increased")
				end

				local anim_fraction = math.easeOutCubic(progress)
				local difficulty_text_widget = widgets.difficulty_text
				local text_style = difficulty_text_widget.style.text
				text_style.text_color[1] = anim_fraction*255
				text_style.font_size = math.catmullrom(math.easeOutCubic(progress), -0.5, 1, 1, -0.5)*40

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out_text",
			start_progress = 5.5,
			end_progress = 6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local anim_fraction = math.easeInCubic(progress)
				local difficulty_text_widget = widgets.difficulty_text
				difficulty_text_widget.style.text.text_color[1] = anim_fraction*255 - 255

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "background_collapse",
			start_progress = 6,
			end_progress = 6.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local anim_fraction = math.easeInCubic(progress)
				local background_top_widget = widgets.background_top
				local background_top_scenegraph_id = background_top_widget.scenegraph_id
				local default_background_top_position = scenegraph_definition[background_top_scenegraph_id].position
				local current_background_top_position = ui_scenegraph[background_top_scenegraph_id].local_position
				local background_bottom_widget = widgets.background_bottom
				local background_bottom_scenegraph_id = background_bottom_widget.scenegraph_id
				local default_background_bottom_position = scenegraph_definition[background_bottom_scenegraph_id].position
				local current_background_bottom_position = ui_scenegraph[background_bottom_scenegraph_id].local_position
				local background_center_widget = widgets.background_center
				local background_center_scenegraph_id = background_center_widget.scenegraph_id
				local current_background_center_size = ui_scenegraph[background_center_scenegraph_id].size
				local default_background_center_size = scenegraph_definition[background_center_scenegraph_id].size
				local center_uvs = background_center_widget.content.texture_id.uvs
				local total_uv_change = anim_fraction*0.5 - 0.5
				center_uvs[1][2] = total_uv_change
				center_uvs[2][2] = total_uv_change - 1
				current_background_center_size[2] = default_background_center_size[2] - default_background_center_size[2]*anim_fraction
				local half_center_height = default_background_center_size[2]/2
				current_background_top_position[2] = (default_background_top_position[2] + half_center_height) - half_center_height*anim_fraction
				current_background_bottom_position[2] = default_background_bottom_position[2] - half_center_height + half_center_height*anim_fraction

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				if not params.played_end_sound then
					params.played_end_sound = true

					WwiseWorld.trigger_event(params.wwise_world, "hud_difficulty_increased_end")
				end

				return 
			end
		},
		{
			name = "fade_out_background",
			start_progress = 6.3,
			end_progress = 6.8,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local background_top_widget = widgets.background_top
				local background_center_widget = widgets.background_center
				local background_bottom_widget = widgets.background_bottom
				local anim_fraction = math.easeOutCubic(progress)
				local alpha = anim_fraction*255 - 255
				background_top_widget.style.texture_id.color[1] = alpha
				background_bottom_widget.style.texture_id.color[1] = alpha
				background_center_widget.style.texture_id.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	}
}

return {
	animations = animations,
	mission_names = mission_names,
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions
}
