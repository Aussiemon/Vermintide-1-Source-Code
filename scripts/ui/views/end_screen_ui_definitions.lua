local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.end_screen
		},
		size = {
			1920,
			1080
		}
	},
	screen = {
		scale = "fit",
		position = {
			0,
			0,
			UILayer.end_screen
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
		}
	},
	level_completed_window = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			1920,
			1080
		}
	},
	level_completed_text = {
		vertical_alignment = "center",
		parent = "level_completed_window",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			1920,
			70
		}
	},
	gdc_logo = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			5
		},
		size = {
			1237,
			538
		}
	},
	defeat_screen = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			50,
			1
		},
		size = {
			524,
			768
		}
	},
	defeat_screen_button_1 = {
		vertical_alignment = "center",
		parent = "defeat_screen",
		horizontal_alignment = "center",
		position = {
			0,
			-40,
			1
		},
		size = {
			194,
			52
		}
	},
	defeat_screen_button_2 = {
		vertical_alignment = "bottom",
		parent = "defeat_screen_button_1",
		horizontal_alignment = "center",
		position = {
			0,
			-55,
			1
		},
		size = {
			194,
			52
		}
	},
	defeat_screen_button_3 = {
		vertical_alignment = "bottom",
		parent = "defeat_screen_button_2",
		horizontal_alignment = "center",
		position = {
			0,
			-55,
			1
		},
		size = {
			194,
			52
		}
	},
	end_screen_banner = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			2
		},
		size = {
			824,
			320
		}
	},
	end_screen_banner_overlay = {
		vertical_alignment = "center",
		parent = "end_screen_banner",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			824,
			320
		}
	},
	end_screen_banner_effect = {
		vertical_alignment = "center",
		parent = "end_screen_banner",
		horizontal_alignment = "center",
		position = {
			0,
			-50,
			-1
		},
		size = {
			1080,
			560
		}
	},
	end_screen_banner_difficulty_title = {
		vertical_alignment = "top",
		parent = "end_screen_banner",
		horizontal_alignment = "center",
		position = {
			0,
			-200,
			5
		},
		size = {
			160,
			40
		}
	},
	end_screen_banner_waves_title = {
		vertical_alignment = "top",
		parent = "end_screen_banner",
		horizontal_alignment = "center",
		position = {
			-85,
			-225,
			5
		},
		size = {
			160,
			40
		}
	},
	end_screen_banner_waves = {
		vertical_alignment = "bottom",
		parent = "end_screen_banner_waves_title",
		horizontal_alignment = "right",
		position = {
			160,
			0,
			0
		},
		size = {
			160,
			40
		}
	},
	end_screen_banner_time_title = {
		vertical_alignment = "bottom",
		parent = "end_screen_banner_waves_title",
		horizontal_alignment = "left",
		position = {
			0,
			-32,
			0
		},
		size = {
			160,
			40
		}
	},
	end_screen_banner_time = {
		vertical_alignment = "bottom",
		parent = "end_screen_banner_time_title",
		horizontal_alignment = "right",
		position = {
			160,
			0,
			0
		},
		size = {
			160,
			40
		}
	}
}
local widget_definitions = {
	background_rect = {
		scenegraph_id = "screen",
		element = {
			passes = {
				{
					pass_type = "rect",
					style_id = "rect"
				}
			}
		},
		content = {},
		style = {
			rect = {
				color = {
					0,
					0,
					0,
					0
				}
			}
		}
	},
	defeat_button_1 = {
		scenegraph_id = "defeat_screen_button_1",
		element = UIElements.Button4States,
		content = {
			text_field = "temp",
			texture_click_id = "failure_screen_button_01_clicked",
			texture_id = "failure_screen_button_01_normal",
			disabled = false,
			texture_hover_id = "failure_screen_button_01_hover",
			texture_disabled_id = "failure_screen_button_01_disabled",
			button_hotspot = {}
		},
		style = {
			color = {
				0,
				255,
				255,
				255
			},
			text = {
				font_size = 24,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 0),
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	defeat_button_2 = {
		scenegraph_id = "defeat_screen_button_2",
		element = UIElements.Button4States,
		content = {
			text_field = "temp",
			texture_click_id = "failure_screen_button_02_clicked",
			texture_id = "failure_screen_button_02_normal",
			disabled = false,
			texture_hover_id = "failure_screen_button_02_hover",
			texture_disabled_id = "failure_screen_button_02_disabled",
			button_hotspot = {}
		},
		style = {
			color = {
				0,
				255,
				255,
				255
			},
			text = {
				font_size = 24,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 0),
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	defeat_button_3 = {
		scenegraph_id = "defeat_screen_button_3",
		element = UIElements.Button4States,
		content = {
			text_field = "temp",
			texture_click_id = "failure_screen_button_01_clicked",
			texture_id = "failure_screen_button_01_normal",
			disabled = false,
			texture_hover_id = "failure_screen_button_01_hover",
			texture_disabled_id = "failure_screen_button_01_disabled",
			button_hotspot = {}
		},
		style = {
			color = {
				0,
				255,
				255,
				255
			},
			text = {
				font_size = 24,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 0),
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	defeat_screen = {
		scenegraph_id = "defeat_screen",
		element = {
			passes = {
				{
					texture_id = "background_texture",
					style_id = "background_texture",
					pass_type = "texture"
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				}
			}
		},
		content = {
			title_text = "temp",
			background_texture = "failure_screen"
		},
		style = {
			background_texture = {
				color = {
					0,
					255,
					255,
					255
				}
			},
			title_text = {
				word_wrap = true,
				font_size = 32,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				offset = {
					0,
					20,
					1
				},
				text_color = Colors.get_color_table_with_alpha("white", 0)
			}
		}
	},
	level_completed_widget = {
		scenegraph_id = "level_completed_window",
		element = {
			passes = {
				{
					texture_id = "banner_texture",
					style_id = "banner_texture",
					pass_type = "texture"
				},
				{
					texture_id = "banner_overlay_texture",
					style_id = "banner_overlay_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.use_overlay
					end
				},
				{
					texture_id = "banner_effect_texture",
					style_id = "banner_effect_texture",
					pass_type = "texture"
				},
				{
					pass_type = "rect",
					style_id = "rect"
				},
				{
					style_id = "difficulty_title",
					pass_type = "text",
					text_id = "difficulty_title",
					content_check_function = function (content)
						return content.is_survival
					end
				},
				{
					style_id = "waves_title",
					pass_type = "text",
					text_id = "waves_title",
					content_check_function = function (content)
						return content.is_survival
					end
				},
				{
					style_id = "waves",
					pass_type = "text",
					text_id = "waves",
					content_check_function = function (content)
						return content.is_survival
					end
				},
				{
					style_id = "time_title",
					pass_type = "text",
					text_id = "time_title",
					content_check_function = function (content)
						return content.is_survival
					end
				},
				{
					style_id = "time",
					pass_type = "text",
					text_id = "time",
					content_check_function = function (content)
						return content.is_survival
					end
				}
			}
		},
		content = {
			banner_texture = "end_screen_banner_survival",
			is_survival = false,
			time = "00:00:00",
			difficulty_title = "",
			waves_title = "dlc1_2_end_screen_waves",
			banner_overlay_texture = "end_screen_banner_skaven_overlay",
			time_title = "dlc1_2_end_screen_time",
			waves = "24",
			banner_effect_texture = "end_screen_banner_effect"
		},
		style = {
			rect = {
				scenegraph_id = "screen",
				color = {
					0,
					0,
					0,
					0
				},
				offset = {
					0,
					0,
					15
				}
			},
			banner_texture = {
				scenegraph_id = "end_screen_banner",
				color = {
					255,
					255,
					255,
					255
				}
			},
			banner_overlay_texture = {
				scenegraph_id = "end_screen_banner_overlay",
				color = {
					0,
					255,
					255,
					255
				}
			},
			banner_effect_texture = {
				scenegraph_id = "end_screen_banner_effect",
				offset = {
					0,
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
			difficulty_title = {
				dynamic_font = true,
				localize = false,
				horizontal_alignment = "center",
				font_size = 30,
				scenegraph_id = "end_screen_banner_difficulty_title",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			waves_title = {
				dynamic_font = true,
				localize = true,
				horizontal_alignment = "left",
				font_size = 30,
				scenegraph_id = "end_screen_banner_waves_title",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			waves = {
				dynamic_font = true,
				horizontal_alignment = "right",
				scenegraph_id = "end_screen_banner_waves",
				font_size = 30,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			time_title = {
				dynamic_font = true,
				localize = true,
				horizontal_alignment = "left",
				font_size = 30,
				scenegraph_id = "end_screen_banner_time_title",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			time = {
				dynamic_font = true,
				horizontal_alignment = "right",
				scenegraph_id = "end_screen_banner_time",
				font_size = 30,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255)
			}
		}
	},
	level_completed_widget_gdc = {
		scenegraph_id = "gdc_logo",
		element = {
			passes = {
				{
					texture_id = "texture",
					style_id = "texture",
					pass_type = "texture"
				}
			}
		},
		content = {
			texture = "vermintide_logo_transparent"
		},
		style = {
			texture = {
				color = {
					0,
					255,
					255,
					255
				}
			},
			texture_fg = {
				color = {
					0,
					255,
					0,
					0
				}
			}
		}
	}
}
local animations = {
	fade_in_background = {
		{
			name = "fade_in",
			start_progress = 0,
			end_progress = UISettings.end_screen.background_fade_in,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_background = true

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local color = widget.style.rect.color
				local alpha = local_progress*255

				if color[1] < alpha then
					color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_out_background = {
		{
			name = "fade_out",
			start_progress = 0,
			end_progress = UISettings.end_screen.background_fade_out,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_background = true

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local color = widget.style.rect.color
				local alpha = local_progress*255 - 255

				if alpha < color[1] then
					color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_background = false

				return 
			end
		}
	},
	auto_display_text = {
		{
			name = "fade_in",
			start_progress = 0.5,
			end_progress = 0.9,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local widget = widgets[1]
				local banner_effect_texture_scenegraph_id = widget.style.banner_effect_texture.scenegraph_id
				local banner_effect_size = ui_scenegraph[banner_effect_texture_scenegraph_id].size
				local banner_effect_default_size = scenegraph_definition[banner_effect_texture_scenegraph_id].size
				banner_effect_size[1] = banner_effect_default_size[1]
				banner_effect_size[2] = banner_effect_default_size[2]
				widget.style.rect.color[1] = 255
				widget.style.banner_effect_texture.color[1] = 255
				widget.style.banner_texture.color[1] = 255
				widget.style.banner_overlay_texture.color[1] = 255

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				params.draw_flags.draw_text = true
				local widget = widgets[1]
				widget.style.rect.color[1] = (local_progress - 1)*255

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "passive_grow",
			start_progress = 0.6,
			end_progress = 5.6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local banner_effect_texture_scenegraph_id = widget.style.banner_effect_texture.scenegraph_id
				local banner_effect_size = ui_scenegraph[banner_effect_texture_scenegraph_id].size
				local banner_effect_default_size = scenegraph_definition[banner_effect_texture_scenegraph_id].size
				local size_multiplier = local_progress*0.2 + 1
				banner_effect_size[1] = size_multiplier*banner_effect_default_size[1]
				banner_effect_size[2] = size_multiplier*banner_effect_default_size[2]

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out",
			start_progress = 5.6,
			end_progress = 7,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				widget.style.rect.color[1] = local_progress*255

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_text = false

				return 
			end
		}
	},
	fade_in_text = {
		{
			name = "fade_in_text",
			start_progress = 0.1,
			end_progress = UISettings.end_screen.text_fade_in,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_text = true

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local alpha = local_progress*255
				widget.style.banner_texture.color[1] = alpha
				widget.style.banner_overlay_texture.color[1] = alpha
				widget.style.banner_effect_texture.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_out_text = {
		{
			name = "fade_out_text",
			start_progress = 0,
			end_progress = UISettings.end_screen.text_fade_out,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_text = true

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local alpha = local_progress*255 - 255
				widget.style.banner_texture.color[1] = alpha
				widget.style.banner_overlay_texture.color[1] = alpha
				widget.style.banner_effect_texture.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_text = false

				return 
			end
		}
	},
	fade_in_continue = {
		{
			name = "fade_in_continue",
			start_progress = 0.1,
			end_progress = UISettings.end_screen.continue_fade_in,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_continue = true

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = local_progress*255
				local window_widget = widgets.window
				local button_1_widget = widgets.button_1
				local button_2_widget = widgets.button_2
				local button_3_widget = widgets.button_3
				local window_widget_style = window_widget.style
				local button_1_widget_style = button_1_widget.style
				local button_2_widget_style = button_2_widget.style
				local button_3_widget_style = button_3_widget.style
				window_widget_style.background_texture.color[1] = alpha
				window_widget_style.title_text.text_color[1] = alpha
				button_1_widget_style.text.text_color[1] = alpha
				button_2_widget_style.text.text_color[1] = alpha
				button_3_widget_style.text.text_color[1] = alpha
				button_1_widget_style.color[1] = alpha
				button_2_widget_style.color[1] = alpha
				button_3_widget_style.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	fade_out_continue = {
		{
			name = "fade_out_continue",
			start_progress = 0,
			end_progress = UISettings.end_screen.continue_fade_out,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_continue = true

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = local_progress*255 - 255
				local window_widget = widgets.window
				local button_1_widget = widgets.button_1
				local button_2_widget = widgets.button_2
				local button_3_widget = widgets.button_3
				local window_widget_style = window_widget.style
				local button_1_widget_style = button_1_widget.style
				local button_2_widget_style = button_2_widget.style
				local button_3_widget_style = button_3_widget.style
				window_widget_style.background_texture.color[1] = alpha
				window_widget_style.title_text.text_color[1] = alpha
				button_1_widget_style.text.text_color[1] = alpha
				button_2_widget_style.text.text_color[1] = alpha
				button_3_widget_style.text.text_color[1] = alpha
				button_1_widget_style.color[1] = alpha
				button_2_widget_style.color[1] = alpha
				button_3_widget_style.color[1] = alpha

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				params.draw_continue = false

				return 
			end
		}
	}
}

return {
	scenegraph = scenegraph_definition,
	widgets = widget_definitions,
	animations = animations
}
