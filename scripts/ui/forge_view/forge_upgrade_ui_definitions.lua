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
	text_frame = {
		vertical_alignment = "top",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			480,
			190
		},
		position = {
			0,
			-470,
			1
		}
	},
	text_frame_title = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			460,
			50
		},
		position = {
			0,
			-20,
			1
		}
	},
	text_frame_description = {
		vertical_alignment = "top",
		parent = "text_frame",
		horizontal_alignment = "center",
		size = {
			460,
			110
		},
		position = {
			0,
			-70,
			1
		}
	},
	upgrade_button = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			338,
			120
		},
		position = {
			0,
			92,
			1
		}
	},
	upgrade_button_fill = {
		vertical_alignment = "center",
		parent = "upgrade_button",
		horizontal_alignment = "left",
		size = {
			307,
			69
		},
		position = {
			16,
			-10,
			-1
		}
	},
	upgrade_button_eye_glow = {
		vertical_alignment = "center",
		parent = "upgrade_button",
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
			150,
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
	upgrade_button_text = {
		vertical_alignment = "center",
		parent = "upgrade_button",
		horizontal_alignment = "left",
		size = {
			60,
			20
		},
		position = {
			20,
			-10,
			1
		}
	},
	upgrade_button_token = {
		vertical_alignment = "center",
		parent = "upgrade_button",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			110,
			-10,
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
			85,
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
			85,
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
			85,
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
			85,
			5
		}
	},
	progress_bar_bg = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			303,
			59
		},
		position = {
			0,
			95,
			2
		}
	},
	progress_bar_abort_text = {
		vertical_alignment = "center",
		parent = "progress_bar_bg",
		horizontal_alignment = "center",
		size = {
			321,
			42
		},
		position = {
			0,
			0,
			1
		}
	},
	progress_bar = {
		vertical_alignment = "center",
		parent = "progress_bar_bg",
		horizontal_alignment = "left",
		size = {
			0,
			42
		},
		position = {
			36,
			0,
			1
		}
	},
	progress_bar_fg = {
		vertical_alignment = "center",
		parent = "progress_bar_bg",
		horizontal_alignment = "center",
		size = {
			303,
			59
		},
		position = {
			0,
			0,
			2
		}
	},
	progress_bar_glow = {
		vertical_alignment = "center",
		parent = "progress_bar_bg",
		horizontal_alignment = "center",
		size = {
			303,
			59
		},
		position = {
			0,
			0,
			3
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
	},
	description_failure = {
		vertical_alignment = "bottom",
		parent = "upgrade_button",
		horizontal_alignment = "center",
		size = {
			501,
			40
		},
		position = {
			0,
			-55,
			1
		}
	}
}
local widgets_definitions = {
	frame_widget = UIWidgets.create_simple_texture("character_selection_bg", "frame"),
	frame_background_widget = UIWidgets.create_simple_texture("forge_upgrade_bg", "frame_background"),
	upgrade_button_widget = UIWidgets.create_forge_upgrade_button("upgrade_button", "upgrade_button_text", "upgrade_button_token", "upgrade_button_eye_glow", "upgrade_button_fill"),
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
	description_failure = UIWidgets.create_simple_text("upgrade_description_failure", "description_failure", 28, Colors.get_color_table_with_alpha("red", 0)),
	title_text = UIWidgets.create_simple_text("forge_title_upgrade", "title_text", 32, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header")
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets_definitions = widgets_definitions
}
