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
			UILayer.item_display_popup
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
	page_root = {
		vertical_alignment = "center",
		parent = "menu_root",
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
	screen = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.item_display_popup
		}
	},
	overlay = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1198,
			870
		},
		position = {
			0,
			0,
			3
		}
	},
	reward_viewport = {
		vertical_alignment = "center",
		parent = "page_root",
		horizontal_alignment = "center",
		size = {
			563,
			655
		},
		position = {
			1,
			0,
			1
		}
	},
	reward_title_text = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			560,
			80
		},
		position = {
			0,
			-5,
			-300
		}
	},
	reward_name_text = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			560,
			80
		},
		position = {
			0,
			110,
			-300
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
		parent = "reward_viewport",
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
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "left",
		size = {
			46,
			46
		},
		position = {
			5,
			-5,
			-300
		}
	},
	hero_icon_tooltip = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "left",
		size = {
			46,
			46
		},
		position = {
			5,
			-5,
			5
		}
	},
	trait_button_1 = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			30,
			-300
		}
	},
	trait_button_2 = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			30,
			-300
		}
	},
	trait_button_3 = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			30,
			-300
		}
	},
	trait_button_4 = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			30,
			-300
		}
	},
	trait_tooltip_1 = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			30,
			5
		}
	},
	trait_tooltip_2 = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			30,
			5
		}
	},
	trait_tooltip_3 = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			30,
			5
		}
	},
	trait_tooltip_4 = {
		vertical_alignment = "bottom",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			30,
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
local widgets = {
	reward_viewport = {
		scenegraph_id = "reward_viewport",
		element = UIElements.Viewport,
		style = {
			viewport = {
				layer = 985,
				level_name = "levels/ui_loot_preview/world",
				clear_screen_on_create = true,
				viewport_name = "reward_preview_viewport",
				world_name = "reward_preview",
				camera_position = {
					0,
					3,
					1.4
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

return {
	scenegraph_definition = scenegraph_definition,
	widgets = widgets
}
