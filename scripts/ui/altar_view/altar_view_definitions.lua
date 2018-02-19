local_require("scripts/ui/ui_widgets")

local PAGE_SPACING = 25
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
	root_filler = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
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
		},
		position = {
			0,
			0,
			0
		}
	},
	popup_root = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			-(PAGE_SPACING + 592),
			-30,
			25
		}
	},
	page_root_left = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			-(PAGE_SPACING + 592),
			20,
			1
		}
	},
	page_root_center = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			0,
			20,
			1
		}
	},
	page_root_right = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			PAGE_SPACING + 592,
			20,
			1
		}
	},
	page_left_glow = {
		vertical_alignment = "center",
		parent = "page_root_left",
		horizontal_alignment = "center",
		size = {
			622,
			936
		},
		position = {
			0,
			0,
			0
		}
	},
	page_center_glow = {
		vertical_alignment = "center",
		parent = "page_root_center",
		horizontal_alignment = "center",
		size = {
			622,
			936
		},
		position = {
			0,
			0,
			0
		}
	},
	selection_bar = {
		vertical_alignment = "center",
		parent = "page_root_left",
		horizontal_alignment = "center",
		size = {
			580,
			40
		},
		position = {
			3,
			421,
			55
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			450,
			28
		},
		position = {
			0,
			-10,
			1
		}
	},
	frame = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			1198,
			870
		},
		position = {
			40,
			-60,
			1
		}
	},
	items_ui_page = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			1,
			1
		},
		position = {
			95,
			-300,
			1
		}
	},
	items2_ui_page = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			1,
			1
		},
		position = {
			1200,
			0,
			2
		}
	},
	merge_ui_page = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			1,
			1
		},
		position = {
			1200,
			0,
			2
		}
	},
	token_frame = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			1150,
			94
		},
		position = {
			62,
			176,
			2
		}
	},
	exit_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "right",
		size = {
			220,
			62
		},
		position = {
			-50,
			40,
			2
		}
	},
	token_root = {
		vertical_alignment = "center",
		parent = "page_root_left",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			0,
			-411,
			55
		}
	},
	iron_tokens_bg = {
		vertical_alignment = "center",
		parent = "token_root",
		horizontal_alignment = "center",
		size = {
			48,
			46
		},
		position = {
			-220,
			0,
			1
		}
	},
	bronze_tokens_bg = {
		vertical_alignment = "center",
		parent = "token_root",
		horizontal_alignment = "left",
		size = {
			48,
			46
		},
		position = {
			-105,
			0,
			1
		}
	},
	silver_tokens_bg = {
		vertical_alignment = "center",
		parent = "token_root",
		horizontal_alignment = "left",
		size = {
			48,
			46
		},
		position = {
			25,
			0,
			1
		}
	},
	gold_tokens_bg = {
		vertical_alignment = "center",
		parent = "token_root",
		horizontal_alignment = "left",
		size = {
			48,
			46
		},
		position = {
			155,
			0,
			1
		}
	},
	iron_tokens_glow = {
		vertical_alignment = "center",
		parent = "iron_tokens_bg",
		horizontal_alignment = "center",
		size = {
			62,
			62
		},
		position = {
			0,
			0,
			1
		}
	},
	bronze_tokens_glow = {
		vertical_alignment = "center",
		parent = "bronze_tokens_bg",
		horizontal_alignment = "center",
		size = {
			62,
			62
		},
		position = {
			0,
			0,
			1
		}
	},
	silver_tokens_glow = {
		vertical_alignment = "center",
		parent = "silver_tokens_bg",
		horizontal_alignment = "center",
		size = {
			62,
			62
		},
		position = {
			0,
			0,
			1
		}
	},
	gold_tokens_glow = {
		vertical_alignment = "center",
		parent = "gold_tokens_bg",
		horizontal_alignment = "center",
		size = {
			62,
			62
		},
		position = {
			0,
			0,
			1
		}
	},
	iron_tokens = {
		vertical_alignment = "center",
		parent = "iron_tokens_bg",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			2
		}
	},
	bronze_tokens = {
		vertical_alignment = "center",
		parent = "bronze_tokens_bg",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			2
		}
	},
	silver_tokens = {
		vertical_alignment = "center",
		parent = "silver_tokens_bg",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			2
		}
	},
	gold_tokens = {
		vertical_alignment = "center",
		parent = "gold_tokens_bg",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			2
		}
	},
	iron_tokens_text = {
		vertical_alignment = "center",
		parent = "iron_tokens",
		horizontal_alignment = "left",
		size = {
			100,
			40
		},
		position = {
			50,
			0,
			1
		}
	},
	bronze_tokens_text = {
		vertical_alignment = "center",
		parent = "bronze_tokens",
		horizontal_alignment = "left",
		size = {
			100,
			40
		},
		position = {
			50,
			0,
			1
		}
	},
	silver_tokens_text = {
		vertical_alignment = "center",
		parent = "silver_tokens",
		horizontal_alignment = "left",
		size = {
			100,
			40
		},
		position = {
			50,
			0,
			1
		}
	},
	gold_tokens_text = {
		vertical_alignment = "center",
		parent = "gold_tokens",
		horizontal_alignment = "left",
		size = {
			100,
			40
		},
		position = {
			50,
			0,
			1
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
}
local token_widgets = {
	iron_tokens_bg = UIWidgets.create_simple_texture("token_bg", "iron_tokens_bg"),
	bronze_tokens_bg = UIWidgets.create_simple_texture("token_bg", "bronze_tokens_bg"),
	silver_tokens_bg = UIWidgets.create_simple_texture("token_bg", "silver_tokens_bg"),
	gold_tokens_bg = UIWidgets.create_simple_texture("token_bg", "gold_tokens_bg"),
	iron_tokens_glow = UIWidgets.create_simple_texture("token_bg_glow", "iron_tokens_glow"),
	bronze_tokens_glow = UIWidgets.create_simple_texture("token_bg_glow", "bronze_tokens_glow"),
	silver_tokens_glow = UIWidgets.create_simple_texture("token_bg_glow", "silver_tokens_glow"),
	gold_tokens_glow = UIWidgets.create_simple_texture("token_bg_glow", "gold_tokens_glow"),
	iron_tokens_widget = UIWidgets.create_texture_with_text("token_icon_01", "0", "iron_tokens", "iron_tokens_text"),
	bronze_tokens_widget = UIWidgets.create_texture_with_text("token_icon_02", "0", "bronze_tokens", "bronze_tokens_text"),
	silver_tokens_widget = UIWidgets.create_texture_with_text("token_icon_03", "0", "silver_tokens", "silver_tokens_text"),
	gold_tokens_widget = UIWidgets.create_texture_with_text("token_icon_04", "0", "gold_tokens", "gold_tokens_text"),
	iron_tokens_tooltip = UIWidgets.create_simple_tooltip("forge_screen_plentiful_token_tooltip", "iron_tokens", 500),
	bronze_tokens_tooltip = UIWidgets.create_simple_tooltip("forge_screen_common_token_tooltip", "bronze_tokens", 500),
	silver_tokens_tooltip = UIWidgets.create_simple_tooltip("forge_screen_rare_token_tooltip", "silver_tokens", 500),
	gold_tokens_tooltip = UIWidgets.create_simple_tooltip("forge_screen_exotic_token_tooltip", "gold_tokens", 500)
}
local widgets_definitions = {
	title_widget = UIWidgets.create_title_text("altar_title", "title_text"),
	background_widget = UIWidgets.create_simple_texture("large_frame_01", "menu_root"),
	exit_button_widget = UIWidgets.create_menu_button_medium("close", "exit_button"),
	dead_space_filler = {
		scenegraph_id = "dead_space_filler",
		element = {
			passes = {
				{
					pass_type = "rect"
				}
			}
		},
		content = {},
		style = {
			color = {
				255,
				0,
				0,
				0
			}
		}
	},
	popup_close_widget = {
		scenegraph_id = "frame",
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				}
			}
		},
		content = {
			button_hotspot = {}
		},
		style = {}
	},
	forge_selection_bar = UIWidgets.create_menu_selection_bar(scenegraph_definition, {
		texture_hover_id = "forge_tab_button_hover",
		texture_click_id = "forge_tab_button_selected",
		texture_id = "forge_tab_button_normal"
	}, {
		{
			texture_hover_id = "altar_tabs_icon_01_normal",
			texture_click_id = "altar_tabs_icon_01_selected",
			texture_id = "altar_tabs_icon_01_normal"
		},
		{
			texture_hover_id = "altar_tabs_icon_02_normal",
			texture_click_id = "altar_tabs_icon_02_selected",
			texture_id = "altar_tabs_icon_02_normal"
		},
		{
			texture_hover_id = "altar_tabs_icon_03_normal",
			texture_click_id = "altar_tabs_icon_03_selected",
			texture_id = "altar_tabs_icon_03_normal"
		}
	}, {
		"altar_screen_craft_tooltip",
		"altar_screen_reroll_traits_tooltip",
		"altar_screen_reroll_proc_tooltip"
	}, {
		190,
		0,
		0
	}, "selection_bar", {
		193,
		41
	}, {
		34,
		34
	})
}
local gamepad_widgets_definitions = {
	page_left_glow = UIWidgets.create_simple_texture("selected_window_glow", "page_left_glow"),
	page_center_glow = UIWidgets.create_simple_texture("selected_window_glow", "page_center_glow")
}
local input_actions = {
	craft = {
		default = {
			{
				input_action = "left_stick",
				priority = 3,
				description_text = "input_description_switch_settings",
				ignore_keybinding = true
			},
			{
				input_action = "refresh",
				priority = 5,
				description_text = "altar_craft_button_text"
			},
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_add"
			}
		},
		default_tokens_missing = {
			{
				input_action = "left_stick",
				priority = 3,
				description_text = "input_description_switch_settings",
				ignore_keybinding = true
			},
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_add"
			}
		},
		item_added = {
			{
				input_action = "left_stick",
				priority = 3,
				description_text = "input_description_switch_settings",
				ignore_keybinding = true
			},
			{
				input_action = "refresh",
				priority = 5,
				description_text = "altar_craft_button_text"
			},
			{
				input_action = "confirm",
				priority = 48,
				description_text = "input_description_add"
			},
			{
				input_action = "special_1",
				priority = 49,
				description_text = "input_description_remove"
			}
		},
		item_added_tokens_missing = {
			{
				input_action = "left_stick",
				priority = 3,
				description_text = "input_description_switch_settings",
				ignore_keybinding = true
			},
			{
				input_action = "confirm",
				priority = 48,
				description_text = "input_description_add"
			},
			{
				input_action = "special_1",
				priority = 49,
				description_text = "input_description_remove"
			}
		},
		item_added_selected = {
			{
				input_action = "left_stick",
				priority = 3,
				description_text = "input_description_switch_settings",
				ignore_keybinding = true
			},
			{
				input_action = "refresh",
				priority = 5,
				description_text = "altar_craft_button_text"
			},
			{
				input_action = "special_1",
				priority = 49,
				description_text = "input_description_remove"
			}
		},
		item_added_selected_tokens_missing = {
			{
				input_action = "left_stick",
				priority = 3,
				description_text = "input_description_switch_settings",
				ignore_keybinding = true
			},
			{
				input_action = "special_1",
				priority = 49,
				description_text = "input_description_remove"
			}
		}
	},
	trait_proc = {
		default = {
			{
				input_action = "confirm",
				priority = 48,
				description_text = "input_description_add"
			}
		},
		disabled_item = {},
		item_added = {
			{
				input_action = "confirm",
				priority = 47,
				description_text = "input_description_add"
			},
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_remove"
			}
		},
		item_added_and_afford = {
			{
				input_action = "confirm",
				priority = 46,
				description_text = "input_description_add"
			},
			{
				input_action = "special_1",
				priority = 47,
				description_text = "input_description_remove"
			},
			{
				input_action = "refresh",
				priority = 48,
				description_text = "dlc1_1_input_description_invocate"
			}
		},
		item_added_and_selected_and_afford = {
			{
				input_action = "special_1",
				priority = 47,
				description_text = "input_description_remove"
			},
			{
				input_action = "refresh",
				priority = 48,
				description_text = "dlc1_1_input_description_invocate"
			}
		},
		item_added_and_selected = {
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_remove"
			}
		}
	},
	trait_reroll = {
		default = {
			{
				input_action = "confirm",
				priority = 48,
				description_text = "input_description_add"
			}
		},
		disabled_item = {},
		item_added = {
			{
				input_action = "confirm",
				priority = 47,
				description_text = "input_description_add"
			},
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_remove"
			}
		},
		item_added_and_afford = {
			{
				input_action = "confirm",
				priority = 46,
				description_text = "input_description_add"
			},
			{
				input_action = "special_1",
				priority = 47,
				description_text = "input_description_remove"
			},
			{
				input_action = "refresh",
				priority = 48,
				description_text = "dlc1_1_input_description_offer"
			}
		},
		item_added_and_selected_and_afford = {
			{
				input_action = "special_1",
				priority = 47,
				description_text = "input_description_remove"
			},
			{
				input_action = "refresh",
				priority = 48,
				description_text = "dlc1_1_input_description_offer"
			}
		},
		item_added_and_selected = {
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_remove"
			}
		},
		select_trait_setup = {
			{
				input_action = "refresh",
				priority = 47,
				description_text = "dlc1_1_input_description_offer_again"
			},
			{
				input_action = "confirm",
				priority = 48,
				description_text = "dlc1_1_input_description_select_traits"
			}
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets_definitions = widgets_definitions,
	gamepad_widgets_definitions = gamepad_widgets_definitions,
	token_widgets = token_widgets,
	input_actions = input_actions,
	PAGE_SPACING = PAGE_SPACING
}
