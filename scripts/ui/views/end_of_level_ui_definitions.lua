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
	root_filler = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
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
			UILayer.end_screen - 2
		},
		size = {
			1920,
			1080
		}
	},
	dead_space_filler = {
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
			200
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
	roll_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			220,
			58
		},
		position = {
			0,
			50,
			60
		}
	},
	curtain_left = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			960,
			1080
		},
		position = {
			0,
			0,
			-1
		}
	},
	curtain_right = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "right",
		size = {
			960,
			1080
		},
		position = {
			0,
			0,
			-1
		}
	}
}
local widgets = {
	dead_space_filler = {
		scenegraph_id = "dead_space_filler",
		element = {
			passes = {
				{
					pass_type = "border_fill_rect"
				}
			}
		},
		content = {},
		style = {}
	},
	curtain_left = {
		scenegraph_id = "curtain_left",
		element = {
			passes = {
				{
					style_id = "background",
					pass_type = "texture_uv",
					content_id = "background"
				}
			}
		},
		content = {
			background = {
				texture_id = "dice_game_curtain",
				uvs = {
					{
						1,
						0
					},
					{
						0,
						1
					}
				}
			}
		},
		style = {
			background = {
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	curtain_right = {
		scenegraph_id = "curtain_right",
		element = {
			passes = {
				{
					style_id = "background",
					pass_type = "texture_uv",
					content_id = "background"
				}
			}
		},
		content = {
			background = {
				texture_id = "dice_game_curtain",
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
			background = {
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
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
	roll_button = {
		scenegraph_id = "roll_button",
		element = UIElements.Button3States,
		content = {
			texture_click_id = "small_button_selected",
			texture_id = "small_button_normal",
			texture_hover_id = "small_button_hover",
			text_field = "",
			button_hotspot = {}
		},
		style = {
			text = {
				font_size = 24,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
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
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets = widgets
}
