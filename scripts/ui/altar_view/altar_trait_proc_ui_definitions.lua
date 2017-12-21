local_require("scripts/ui/ui_widgets")

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
	page_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			0,
			0,
			1
		}
	},
	frame = {
		vertical_alignment = "center",
		parent = "page_root",
		horizontal_alignment = "center",
		size = {
			592,
			902
		},
		position = {
			0,
			0,
			3
		}
	},
	frame_background = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			564,
			834
		},
		position = {
			0,
			12,
			-1
		}
	},
	background_candle_top_left = {
		vertical_alignment = "top",
		parent = "frame_background",
		horizontal_alignment = "left",
		size = {
			5,
			11
		},
		position = {
			115,
			-136,
			2
		}
	},
	background_candle_left = {
		vertical_alignment = "top",
		parent = "frame_background",
		horizontal_alignment = "left",
		size = {
			5,
			11
		},
		position = {
			64,
			-213,
			2
		}
	},
	background_candle_right = {
		vertical_alignment = "top",
		parent = "frame_background",
		horizontal_alignment = "right",
		size = {
			5,
			11
		},
		position = {
			-95,
			-170,
			2
		}
	},
	candle_glow_top_left = {
		vertical_alignment = "center",
		parent = "background_candle_top_left",
		horizontal_alignment = "center",
		size = {
			74,
			75
		},
		position = {
			0,
			0,
			-1
		}
	},
	candle_glow_left = {
		vertical_alignment = "center",
		parent = "background_candle_left",
		horizontal_alignment = "center",
		size = {
			74,
			75
		},
		position = {
			0,
			0,
			-1
		}
	},
	candle_glow_right = {
		vertical_alignment = "center",
		parent = "background_candle_right",
		horizontal_alignment = "center",
		size = {
			74,
			75
		},
		position = {
			0,
			0,
			-1
		}
	},
	text_frame = {
		vertical_alignment = "top",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			445,
			240
		},
		position = {
			0,
			-347,
			1
		}
	},
	text_frame_title = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			430,
			50
		},
		position = {
			0,
			-25,
			1
		}
	},
	text_frame_description = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			430,
			160
		},
		position = {
			0,
			-70,
			1
		}
	},
	text_frame_divider = {
		vertical_alignment = "bottom",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			386,
			22
		},
		position = {
			0,
			-25,
			1
		}
	},
	proc_slider = {
		vertical_alignment = "bottom",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			480,
			100
		},
		position = {
			0,
			-103,
			1
		}
	},
	proc_slider_bar_fg = {
		vertical_alignment = "center",
		parent = "proc_slider",
		horizontal_alignment = "center",
		size = {
			380,
			20
		},
		position = {
			0,
			0,
			2
		}
	},
	proc_slider_bar = {
		vertical_alignment = "center",
		parent = "proc_slider_bar_fg",
		horizontal_alignment = "left",
		size = {
			380,
			20
		},
		position = {
			0,
			0,
			-1
		}
	},
	proc_slider_min_text = {
		vertical_alignment = "center",
		parent = "proc_slider_bar_fg",
		horizontal_alignment = "left",
		size = {
			50,
			30
		},
		position = {
			-74,
			0,
			1
		}
	},
	proc_slider_max_text = {
		vertical_alignment = "center",
		parent = "proc_slider_bar_fg",
		horizontal_alignment = "right",
		size = {
			50,
			30
		},
		position = {
			74,
			0,
			1
		}
	},
	proc_slider_current_box = {
		vertical_alignment = "center",
		parent = "proc_slider_bar_fg",
		horizontal_alignment = "left",
		size = {
			85,
			89
		},
		position = {
			0,
			23,
			1
		}
	},
	proc_slider_new_box = {
		vertical_alignment = "center",
		parent = "proc_slider_bar_fg",
		horizontal_alignment = "left",
		size = {
			85,
			89
		},
		position = {
			0,
			-21,
			3
		}
	},
	roll_button = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			318,
			84
		},
		position = {
			0,
			86,
			3
		}
	},
	roll_button_text = {
		vertical_alignment = "center",
		parent = "roll_button",
		horizontal_alignment = "left",
		size = {
			60,
			20
		},
		position = {
			20,
			-4,
			1
		}
	},
	roll_button_token = {
		vertical_alignment = "center",
		parent = "roll_button",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			112,
			-4,
			1
		}
	},
	item_button = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			78,
			79
		},
		position = {
			0,
			200,
			1
		}
	},
	item_button_icon = {
		vertical_alignment = "center",
		parent = "item_button",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			1,
			1
		}
	},
	trait_button_1 = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			40,
			5
		}
	},
	trait_button_2 = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			40,
			5
		}
	},
	trait_button_3 = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			40,
			5
		}
	},
	trait_button_4 = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			40,
			5
		}
	},
	description_text_1 = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			501,
			40
		},
		position = {
			0,
			322,
			1
		}
	},
	title_text = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			501,
			40
		},
		position = {
			0,
			380,
			1
		}
	}
}
local slider = {
	scenegraph_id = "proc_slider",
	element = {
		passes = {
			{
				texture_id = "bar_texture",
				style_id = "bar_texture",
				pass_type = "texture_uv",
				content_id = "bar_content"
			},
			{
				pass_type = "texture",
				style_id = "bar_texture_fg",
				texture_id = "bar_texture_fg"
			},
			{
				style_id = "min_text",
				pass_type = "text",
				text_id = "min_text"
			},
			{
				style_id = "max_text",
				pass_type = "text",
				text_id = "max_text"
			},
			{
				pass_type = "texture",
				style_id = "proc_slider_current_box",
				texture_id = "current_value_box"
			},
			{
				pass_type = "texture",
				style_id = "current_box_glow",
				texture_id = "box_glow"
			},
			{
				pass_type = "texture",
				style_id = "new_box_glow",
				texture_id = "box_fail_glow"
			},
			{
				style_id = "current_proc_text",
				pass_type = "text",
				text_id = "current_proc_text"
			},
			{
				pass_type = "texture",
				style_id = "proc_slider_new_box",
				texture_id = "new_value_box"
			},
			{
				style_id = "new_proc_text",
				pass_type = "text",
				text_id = "new_proc_text"
			}
		}
	},
	content = {
		max_text = "",
		new_proc_text = "",
		box_glow = "trait_proc_box_glow",
		current_proc_text = "",
		min_text = "",
		bar_texture_fg = "proc_fg",
		current_value_box = "proc_box_01",
		new_value_box = "proc_box_02",
		box_fail_glow = "trait_proc_box_fail_glow",
		bar_content = {
			bar_texture = "trait_proc_bar_glow",
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
	},
	style = {
		bar_texture = {
			scenegraph_id = "proc_slider_bar",
			color = {
				255,
				255,
				255,
				255
			}
		},
		bar_texture_fg = {
			scenegraph_id = "proc_slider_bar_fg",
			offset = {
				0,
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
		new_proc_text = {
			vertical_alignment = "center",
			scenegraph_id = "proc_slider_new_box",
			horizontal_alignment = "center",
			font_size = 28,
			font_type = "hell_shark",
			word_wrap = true,
			offset = {
				-39,
				-21,
				1
			},
			text_color = Colors.get_color_table_with_alpha("white", 255)
		},
		proc_slider_new_box = {
			scenegraph_id = "proc_slider_new_box",
			offset = {
				-40,
				0,
				0
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		new_box_glow = {
			scenegraph_id = "proc_slider_new_box",
			size = {
				120,
				80
			},
			offset = {
				-59,
				-15,
				2
			},
			color = {
				0,
				255,
				255,
				255
			}
		},
		current_proc_text = {
			vertical_alignment = "center",
			scenegraph_id = "proc_slider_current_box",
			horizontal_alignment = "center",
			font_size = 28,
			font_type = "hell_shark",
			word_wrap = true,
			offset = {
				-39,
				23,
				2
			},
			text_color = Colors.get_color_table_with_alpha("white", 255)
		},
		proc_slider_current_box = {
			scenegraph_id = "proc_slider_current_box",
			offset = {
				-40,
				0,
				0
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		current_box_glow = {
			scenegraph_id = "proc_slider_current_box",
			size = {
				120,
				80
			},
			offset = {
				-59,
				29,
				2
			},
			color = {
				0,
				255,
				255,
				255
			}
		},
		min_text = {
			vertical_alignment = "center",
			scenegraph_id = "proc_slider_min_text",
			horizontal_alignment = "center",
			font_size = 22,
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
		},
		max_text = {
			vertical_alignment = "center",
			scenegraph_id = "proc_slider_max_text",
			horizontal_alignment = "center",
			font_size = 22,
			word_wrap = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
		}
	}
}
local widgets_definitions = {
	frame_widget = UIWidgets.create_simple_texture("character_selection_bg", "frame"),
	frame_background_widget = UIWidgets.create_simple_texture("reroll_proc_bg", "frame_background"),
	slider_widget = slider,
	background_candle_left_top_widget = UIWidgets.create_simple_texture("candle_glow_02", "background_candle_top_left"),
	background_candle_left_widget = UIWidgets.create_simple_texture("candle_glow_02", "background_candle_left"),
	background_candle_right_widget = UIWidgets.create_simple_texture("candle_glow_02", "background_candle_right"),
	candle_glow_left_top_widget = UIWidgets.create_simple_texture("candle_glow_01", "candle_glow_top_left"),
	candle_glow_left_widget = UIWidgets.create_simple_texture("candle_glow_01", "candle_glow_left"),
	candle_glow_right_widget = UIWidgets.create_simple_texture("candle_glow_01", "candle_glow_right"),
	roll_button_widget = UIWidgets.create_altar_button("altar_screen_reroll_proc_tooltip", "roll_button", "roll_button_text", "roll_button_token"),
	item_button_widget = UIWidgets.create_attach_icon_button("item_slot_01", "item_button", "item_button_icon", scenegraph_definition.item_button_icon.size),
	text_frame_title = UIWidgets.create_simple_text("", "text_frame_title", 28, Colors.get_color_table_with_alpha("cheeseburger", 255), {
		font_size = 28,
		localize = true,
		word_wrap = true,
		pixel_perfect = true,
		horizontal_alignment = "left",
		vertical_alignment = "top",
		dynamic_font = true,
		font_type = "hell_shark_header",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	text_frame_description = UIWidgets.create_simple_text("", "text_frame_description", 18, Colors.get_color_table_with_alpha("white", 255), {
		font_size = 18,
		localize = false,
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
	}),
	trait_button_1 = UIWidgets.create_small_trait_button("trait_button_1", "trait_button_1"),
	trait_button_2 = UIWidgets.create_small_trait_button("trait_button_2", "trait_button_2"),
	trait_button_3 = UIWidgets.create_small_trait_button("trait_button_3", "trait_button_3"),
	trait_button_4 = UIWidgets.create_small_trait_button("trait_button_4", "trait_button_4"),
	description_text_1 = UIWidgets.create_simple_text("upgrade_description_1", "description_text_1", 24, Colors.get_color_table_with_alpha("white", 255)),
	title_text = UIWidgets.create_simple_text("altar_title_trait_proc", "title_text", 32, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header")
}
local animations = {
	min_max_value_change = {
		{
			name = "fade_out",
			start_progress = 0,
			end_progress = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				local alpha = (local_progress - 1)*255
				widget_style.min_text.text_color[1] = alpha
				widget_style.max_text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "value_change",
			start_progress = 0.2,
			end_progress = 0.21,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_content = widget.content
				widget_content.min_text = params.min_display_text
				widget_content.max_text = params.max_display_text

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in",
			start_progress = 0.21,
			end_progress = 0.4,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				local alpha = local_progress*255
				widget_style.min_text.text_color[1] = alpha
				widget_style.max_text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	current_value = {
		{
			name = "current_box_text_fade_out",
			start_progress = 0,
			end_progress = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				local alpha = (local_progress - 1)*255
				widget_style.current_proc_text.text_color[1] = alpha
				widget_style.new_proc_text.text_color[1] = 0

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "current_box_move",
			scale_duration_by_speed = true,
			start_progress = 0.2,
			end_progress = 1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local current_box_position = ui_scenegraph.proc_slider_current_box.local_position
				params.start_x_position = current_box_position[1]

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				if not params.move_sound_played then
					WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_window_move")

					params.move_sound_played = true
				end

				local line_end_progress = params.end_progress
				local current_box_position = ui_scenegraph.proc_slider_current_box.local_position
				local default_position = scenegraph_definition.proc_slider_current_box.position
				local start_x_position = params.start_x_position
				local bar_default_length = scenegraph_definition.proc_slider_bar.size[1]
				local pos_diff = math.abs(start_x_position - bar_default_length*line_end_progress)
				local fraction_diff = pos_diff/bar_default_length
				local eased_progress = math.easeCubic(local_progress)
				local current_bar_length = bar_default_length*line_end_progress
				local new_box_x_position = current_bar_length*eased_progress

				if new_box_x_position < start_x_position then
					current_box_position[1] = start_x_position - (start_x_position - current_bar_length)*eased_progress
				elseif start_x_position < new_box_x_position then
					current_box_position[1] = start_x_position + (current_bar_length - start_x_position)*eased_progress
				else
					current_box_position[1] = new_box_x_position
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0,
			name = "current_box_text_fade_in",
			start_relative_to = 2,
			duration = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				if not params.value_change_sound_played then
					WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_glow_small")

					params.value_change_sound_played = true
				end

				local widget = widgets.slider_widget
				local widget_content = widget.content
				local widget_style = widget.style
				local formatting = params.formatting
				local multiplier = params.multiplier
				local current_value = params.current_value*multiplier
				local min_value = params.min_value*multiplier
				widget_content.current_proc_text = string.format(formatting, current_value)
				widget_content.new_proc_text = string.format(formatting, min_value)
				local alpha = local_progress*255
				widget_style.current_proc_text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	change_box_values_only = {
		{
			name = "fade_out",
			start_progress = 0,
			end_progress = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				local alpha = (local_progress - 1)*255
				widget_style.current_proc_text.text_color[1] = alpha
				widget_style.new_proc_text.text_color[1] = 0

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "value_change",
			start_progress = 0.2,
			end_progress = 0.21,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				if not params.value_change_sound_played then
					WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_glow_small")

					params.value_change_sound_played = true
				end

				local widget = widgets.slider_widget
				local widget_content = widget.content
				local formatting = params.formatting
				local multiplier = params.multiplier
				local current_value = params.current_value*multiplier
				local min_value = params.min_value*multiplier
				widget_content.current_proc_text = string.format(formatting, current_value)
				widget_content.new_proc_text = string.format(formatting, min_value)

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_in",
			start_progress = 0.21,
			end_progress = 0.4,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				local alpha = local_progress*255
				widget_style.current_proc_text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	new_value = {
		{
			name = "new_box_move",
			scale_duration_by_speed = true,
			start_progress = 0,
			end_progress = 1.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_invocate_start")

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_content = widget.content
				local new_box_position = ui_scenegraph.proc_slider_new_box.local_position
				local current_box_position = ui_scenegraph.proc_slider_current_box.local_position
				local default_position = scenegraph_definition.proc_slider_new_box.position
				local bar_size = ui_scenegraph.proc_slider_bar.size
				local bar_default_length = scenegraph_definition.proc_slider_bar.size[1]
				local line_end_progress = params.end_progress
				local eased_progress = math.easeOutCubic(local_progress)
				local new_bar_length = bar_default_length*line_end_progress*eased_progress
				bar_size[1] = new_bar_length
				new_box_position[1] = new_bar_length
				local bar_uvs = widget_content.bar_content.uvs
				bar_uvs[2][1] = line_end_progress*eased_progress

				if current_box_position[1] < new_box_position[1] then
					current_box_position[1] = new_bar_length
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_invocate_stop_bad")

				return 
			end
		},
		{
			name = "new_box_text",
			scale_duration_by_speed = true,
			start_progress = 0,
			end_progress = 1.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				widget_style.new_proc_text.text_color[1] = 255

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_content = widget.content
				local line_end_progress = params.end_progress
				local eased_progress = math.easeCubic(local_progress)
				local formatting = params.formatting
				local multiplier = params.multiplier
				local min_value = params.min_value*multiplier
				local max_value = params.max_value*multiplier
				local new_value = params.new_value*multiplier
				local current_value = params.current_value*multiplier
				local progress_value = min_value + math.max(new_value - min_value, 0)*eased_progress
				local text = string.format(formatting, progress_value)

				if current_value < progress_value then
					widget_content.current_proc_text = text
				end

				widget_content.new_proc_text = text

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0,
			name = "new_box_glow_pulse",
			start_relative_to = 1,
			duration = 0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				widget_style.new_box_glow.color[1] = math.ease_pulse(local_progress)*255

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0.2,
			name = "new_box_move_back",
			start_relative_to = 3,
			duration = 0.6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				if not params.move_sound_played then
					WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_window_move")

					params.move_sound_played = true
				end

				if not params.start_x_position then
					params.start_x_position = ui_scenegraph.proc_slider_new_box.local_position[1]
				end

				local widget = widgets.slider_widget
				local widget_content = widget.content
				local new_box_position = ui_scenegraph.proc_slider_new_box.local_position
				local default_position = scenegraph_definition.proc_slider_new_box.position
				local start_x_position = params.start_x_position
				local bar_size = ui_scenegraph.proc_slider_bar.size
				local bar_default_length = scenegraph_definition.proc_slider_bar.size[1]
				local line_end_progress = params.end_progress
				local eased_progress = math.easeCubic(local_progress)
				local new_bar_length = start_x_position - start_x_position*eased_progress
				bar_size[1] = new_bar_length
				new_box_position[1] = new_bar_length
				local bar_uvs = widget_content.bar_content.uvs
				bar_uvs[2][1] = eased_progress - 1

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0.2,
			name = "new_box_text_move_back",
			start_relative_to = 3,
			duration = 0.6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_content = widget.content
				local line_end_progress = params.end_progress
				local eased_progress = math.easeCubic(local_progress - 1)
				local formatting = params.formatting
				local multiplier = params.multiplier
				local min_value = params.min_value*multiplier
				local max_value = params.max_value*multiplier
				local new_value = params.new_value*multiplier
				local progress_value = min_value + math.max(new_value - min_value, 0)*eased_progress
				local text = string.format(formatting, progress_value)
				widget_content.new_proc_text = text

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0,
			name = "new_box_text_fade_out",
			start_relative_to = 4,
			duration = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				local alpha = (local_progress - 1)*255
				widget_style.new_proc_text.text_color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	new_value_better = {
		{
			name = "new_box_move",
			scale_duration_by_speed = true,
			start_progress = 0,
			end_progress = 1.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_invocate_start")

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_content = widget.content
				local new_box_position = ui_scenegraph.proc_slider_new_box.local_position
				local current_box_position = ui_scenegraph.proc_slider_current_box.local_position
				local default_position = scenegraph_definition.proc_slider_new_box.position
				local bar_size = ui_scenegraph.proc_slider_bar.size
				local bar_default_length = scenegraph_definition.proc_slider_bar.size[1]
				local line_end_progress = params.end_progress
				local eased_progress = math.easeInCubic(local_progress)
				local new_bar_length = bar_default_length*line_end_progress*eased_progress
				bar_size[1] = new_bar_length
				new_box_position[1] = new_bar_length
				local bar_uvs = widget_content.bar_content.uvs
				bar_uvs[2][1] = line_end_progress*eased_progress

				if current_box_position[1] < new_box_position[1] then
					current_box_position[1] = new_bar_length
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				WwiseWorld.trigger_event(params.wwise_world, "Play_hud_invocate_stop_good")

				return 
			end
		},
		{
			name = "new_box_text",
			scale_duration_by_speed = true,
			start_progress = 0,
			end_progress = 1.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				widget_style.new_proc_text.text_color[1] = 255

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_content = widget.content
				local line_end_progress = params.end_progress
				local eased_progress = math.easeCubic(local_progress)
				local formatting = params.formatting
				local multiplier = params.multiplier
				local min_value = params.min_value*multiplier
				local max_value = params.max_value*multiplier
				local new_value = params.new_value*multiplier
				local current_value = params.current_value*multiplier
				local progress_value = min_value + math.max(new_value - min_value, 0)*eased_progress
				local text = string.format(formatting, progress_value)

				if current_value < progress_value then
					widget_content.current_proc_text = text
				end

				widget_content.new_proc_text = text

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0,
			name = "current_box_glow_pulse",
			start_relative_to = 1,
			duration = 0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style

				if 0.5 < local_progress and not params.glow_sound_played then
					WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_random_enchant")

					params.glow_sound_played = true
				end

				widget_style.current_box_glow.color[1] = math.ease_pulse(local_progress)*255

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0.2,
			name = "new_box_move_back",
			start_relative_to = 3,
			duration = 0.6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				if not params.move_sound_played then
					WwiseWorld.trigger_event(params.wwise_world, "Play_hud_reroll_traits_window_move")

					params.move_sound_played = true
				end

				if not params.start_x_position then
					params.start_x_position = ui_scenegraph.proc_slider_new_box.local_position[1]
				end

				local widget = widgets.slider_widget
				local widget_content = widget.content
				local new_box_position = ui_scenegraph.proc_slider_new_box.local_position
				local default_position = scenegraph_definition.proc_slider_new_box.position
				local start_x_position = params.start_x_position
				local bar_size = ui_scenegraph.proc_slider_bar.size
				local bar_default_length = scenegraph_definition.proc_slider_bar.size[1]
				local line_end_progress = params.end_progress
				local eased_progress = math.easeCubic(local_progress)
				local new_bar_length = start_x_position - start_x_position*eased_progress
				bar_size[1] = new_bar_length
				new_box_position[1] = new_bar_length
				local bar_uvs = widget_content.bar_content.uvs
				bar_uvs[2][1] = eased_progress - 1

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0.2,
			name = "new_box_text_move_back",
			start_relative_to = 3,
			duration = 0.6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_content = widget.content
				local line_end_progress = params.end_progress
				local eased_progress = math.easeCubic(local_progress - 1)
				local formatting = params.formatting
				local multiplier = params.multiplier
				local min_value = params.min_value*multiplier
				local max_value = params.max_value*multiplier
				local new_value = params.new_value*multiplier
				local progress_value = min_value + math.max(new_value - min_value, 0)*eased_progress
				local text = string.format(formatting, progress_value)
				widget_content.new_proc_text = text

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			start_relative_time_offset = 0,
			name = "new_box_text_fade_out",
			start_relative_to = 4,
			duration = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets.slider_widget
				local widget_style = widget.style
				local alpha = (local_progress - 1)*255
				widget_style.new_proc_text.text_color[1] = alpha

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
	widgets_definitions = widgets_definitions,
	animations = animations
}
