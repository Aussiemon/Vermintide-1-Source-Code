local profile_view = {
	scenegraph = {
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
		cancel_button = {
			parent = "menu_root",
			horizontal_alignment = "right",
			position = {
				-50,
				50,
				10
			},
			size = {
				318,
				84
			}
		},
		accept_button = {
			parent = "cancel_button",
			position = {
				0,
				100,
				10
			},
			size = {
				318,
				84
			}
		},
		character_info_root = {
			vertical_alignment = "bottom",
			parent = "menu_root",
			horizontal_alignment = "center",
			position = {
				0,
				50,
				0
			},
			size = {
				1,
				1
			}
		},
		character_title = {
			vertical_alignment = "center",
			parent = "character_info_root",
			horizontal_alignment = "center",
			position = {
				0,
				200,
				1
			},
			size = {
				450,
				40
			}
		},
		character_line_break = {
			vertical_alignment = "center",
			parent = "character_info_root",
			horizontal_alignment = "center",
			position = {
				0,
				160,
				1
			},
			size = {
				386,
				22
			}
		},
		character_info_text = {
			vertical_alignment = "center",
			parent = "character_info_root",
			horizontal_alignment = "center",
			position = {
				0,
				85,
				1
			},
			size = {
				800,
				85
			}
		},
		viewport = {
			parent = "menu_root",
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
		}
	},
	widgets = {
		viewport = {
			scenegraph_id = "viewport",
			element = UIElements.Viewport,
			style = {
				viewport = {
					layer = 989,
					level_name = "levels/ui_profile_selection/world",
					scenegraph_id = "viewport",
					enable_sub_gui = true,
					viewport_name = "profile_selection_viewport",
					world_name = "profile_selection",
					camera_position = {
						0,
						6,
						2
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
		character_info_widget = {
			scenegraph_id = "character_info_root",
			element = {
				passes = {
					{
						style_id = "title_text",
						pass_type = "text",
						text_id = "title_text"
					},
					{
						pass_type = "texture",
						style_id = "line_break_texture",
						texture_id = "line_break_texture"
					},
					{
						style_id = "description_text",
						pass_type = "text",
						text_id = "description_text"
					}
				}
			},
			content = {
				title_text = "",
				description_text = "",
				line_break_texture = "summary_screen_line_breaker"
			},
			style = {
				line_break_texture = {
					scenegraph_id = "character_line_break",
					color = {
						255,
						255,
						255,
						255
					}
				},
				title_text = {
					scenegraph_id = "character_title",
					font_size = 36,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "top",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255)
				},
				description_text = {
					scenegraph_id = "character_info_text",
					font_size = 30,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "top",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
				}
			}
		},
		button_widgets = {
			accept_button = UIWidgets.create_menu_button_medium("profile_accept_button", "accept_button"),
			cancel_button = UIWidgets.create_menu_button_medium("popup_choice_cancel", "cancel_button")
		},
		dead_space_filler_widget = UIWidgets.create_simple_rect("dead_space_filler", {
			255,
			0,
			0,
			0
		})
	}
}
local profile_world_view = {
	scenegraph = {
		root = {
			is_root = true,
			position = {
				0,
				0,
				UILayer.default + 1
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
		profile_selection_box_1 = {
			parent = "menu_root",
			position = {
				220,
				270,
				1
			},
			size = {
				240,
				600
			}
		},
		profile_selection_box_2 = {
			parent = "menu_root",
			position = {
				510,
				270,
				1
			},
			size = {
				240,
				600
			}
		},
		profile_selection_box_3 = {
			parent = "menu_root",
			position = {
				820,
				270,
				1
			},
			size = {
				270,
				600
			}
		},
		profile_selection_box_4 = {
			parent = "menu_root",
			position = {
				1150,
				270,
				1
			},
			size = {
				270,
				600
			}
		},
		profile_selection_box_5 = {
			parent = "menu_root",
			position = {
				1480,
				270,
				1
			},
			size = {
				350,
				600
			}
		}
	},
	button_widgets = {},
	character_info_widget = {
		scenegraph_id = "character_info_root",
		element = {
			passes = {
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					pass_type = "texture",
					style_id = "line_break_texture",
					texture_id = "line_break_texture"
				},
				{
					style_id = "description_text",
					pass_type = "text",
					text_id = "description_text"
				}
			}
		},
		content = {
			title_text = "",
			description_text = "",
			line_break_texture = "summary_screen_line_breaker"
		},
		style = {
			line_break_texture = {
				scenegraph_id = "character_line_break",
				color = {
					255,
					255,
					255,
					255
				}
			},
			title_text = {
				scenegraph_id = "character_title",
				font_size = 36,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			description_text = {
				scenegraph_id = "character_info_text",
				font_size = 30,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			}
		}
	},
	profile_selection_widgets = {
		{
			scenegraph_id = "profile_selection_box_1",
			element = {
				passes = {
					{
						pass_type = "hotspot"
					}
				}
			},
			content = {},
			style = {}
		},
		{
			scenegraph_id = "profile_selection_box_2",
			element = {
				passes = {
					{
						pass_type = "hotspot"
					}
				}
			},
			content = {},
			style = {}
		},
		{
			scenegraph_id = "profile_selection_box_3",
			element = {
				passes = {
					{
						pass_type = "hotspot"
					}
				}
			},
			content = {},
			style = {}
		},
		{
			scenegraph_id = "profile_selection_box_4",
			element = {
				passes = {
					{
						pass_type = "hotspot"
					}
				}
			},
			content = {},
			style = {}
		},
		{
			scenegraph_id = "profile_selection_box_5",
			element = {
				passes = {
					{
						pass_type = "hotspot"
					}
				}
			},
			content = {},
			style = {}
		}
	}
}
local definitions = {
	profile_view = profile_view,
	profile_world_view = profile_world_view
}

return definitions
