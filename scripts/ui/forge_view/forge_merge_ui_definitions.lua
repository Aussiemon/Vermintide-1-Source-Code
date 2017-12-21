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
	frame_door_left = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "left",
		size = {
			283,
			655
		},
		position = {
			0,
			-28,
			20
		}
	},
	frame_door_right = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "right",
		size = {
			283,
			655
		},
		position = {
			0,
			-28,
			20
		}
	},
	item_button_1 = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			78,
			79
		},
		position = {
			0,
			159,
			10
		}
	},
	item_button_2 = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			78,
			79
		},
		position = {
			163,
			31,
			10
		}
	},
	item_button_3 = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			78,
			79
		},
		position = {
			93,
			-145,
			10
		}
	},
	item_button_4 = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			78,
			79
		},
		position = {
			-91,
			-145,
			10
		}
	},
	item_button_5 = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			78,
			79
		},
		position = {
			-161,
			31,
			10
		}
	},
	item_reward_slot = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			102,
			102
		},
		position = {
			1,
			2,
			10
		}
	},
	merge_button = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			338,
			120
		},
		position = {
			0,
			-278,
			9
		}
	},
	merge_button_eye_glow = {
		vertical_alignment = "center",
		parent = "merge_button",
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
	merge_button_text = {
		vertical_alignment = "center",
		parent = "merge_button",
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
	merge_button_token = {
		vertical_alignment = "center",
		parent = "merge_button",
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
	item_button_1_icon = {
		vertical_alignment = "center",
		parent = "item_button_1",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			0,
			1
		}
	},
	item_button_2_icon = {
		vertical_alignment = "center",
		parent = "item_button_2",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			0,
			1
		}
	},
	item_button_3_icon = {
		vertical_alignment = "center",
		parent = "item_button_3",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			0,
			1
		}
	},
	item_button_4_icon = {
		vertical_alignment = "center",
		parent = "item_button_4",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			0,
			1
		}
	},
	item_button_5_icon = {
		vertical_alignment = "center",
		parent = "item_button_5",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			0,
			1
		}
	},
	melted_iron_1 = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			91,
			88
		},
		position = {
			0,
			181,
			7
		}
	},
	melted_iron_2 = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			91,
			88
		},
		position = {
			163,
			53,
			7
		}
	},
	melted_iron_3 = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			91,
			88
		},
		position = {
			93,
			-123,
			7
		}
	},
	melted_iron_4 = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			91,
			88
		},
		position = {
			-91,
			-123,
			7
		}
	},
	melted_iron_5 = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			91,
			88
		},
		position = {
			-161,
			53,
			7
		}
	},
	melted_iron_6 = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			114,
			112
		},
		position = {
			0,
			24,
			7
		}
	},
	melted_iron_1_link = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			123,
			98
		},
		position = {
			100,
			141,
			1
		}
	},
	melted_iron_2_link = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			63,
			101
		},
		position = {
			132,
			-35,
			2
		}
	},
	melted_iron_3_link = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			106,
			24
		},
		position = {
			2,
			-124,
			3
		}
	},
	melted_iron_4_link = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			63,
			101
		},
		position = {
			-129,
			-35,
			4
		}
	},
	melted_iron_5_link = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			83,
			31
		},
		position = {
			-87,
			38,
			5
		}
	},
	melted_iron_6_link = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			45,
			172
		},
		position = {
			-1,
			-112,
			6
		}
	},
	item_reward_slot_icon = {
		vertical_alignment = "center",
		parent = "item_reward_slot",
		horizontal_alignment = "center",
		size = {
			85,
			85
		},
		position = {
			0,
			1,
			1
		}
	},
	item_button_1_animation = {
		vertical_alignment = "center",
		parent = "item_button_1",
		horizontal_alignment = "center",
		size = {
			132,
			132
		},
		position = {
			0,
			0,
			8
		}
	},
	item_button_2_animation = {
		vertical_alignment = "center",
		parent = "item_button_2",
		horizontal_alignment = "center",
		size = {
			132,
			132
		},
		position = {
			0,
			0,
			8
		}
	},
	item_button_3_animation = {
		vertical_alignment = "center",
		parent = "item_button_3",
		horizontal_alignment = "center",
		size = {
			132,
			132
		},
		position = {
			0,
			0,
			8
		}
	},
	item_button_4_animation = {
		vertical_alignment = "center",
		parent = "item_button_4",
		horizontal_alignment = "center",
		size = {
			132,
			132
		},
		position = {
			0,
			0,
			8
		}
	},
	item_button_5_animation = {
		vertical_alignment = "center",
		parent = "item_button_5",
		horizontal_alignment = "center",
		size = {
			132,
			132
		},
		position = {
			0,
			0,
			8
		}
	},
	item_reward_slot_animation = {
		vertical_alignment = "center",
		parent = "item_reward_slot",
		horizontal_alignment = "center",
		size = {
			153,
			153
		},
		position = {
			0,
			0,
			8
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
local widgets_definitions = {
	melted_iron_1 = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_01", "melted_iron_1"),
	melted_iron_2 = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_02", "melted_iron_2"),
	melted_iron_3 = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_03", "melted_iron_3"),
	melted_iron_4 = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_04", "melted_iron_4"),
	melted_iron_5 = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_05", "melted_iron_5"),
	melted_iron_6 = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_06", "melted_iron_6"),
	melted_iron_1_link = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_01_path", "melted_iron_1_link"),
	melted_iron_2_link = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_02_path", "melted_iron_2_link"),
	melted_iron_3_link = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_03_path", "melted_iron_3_link"),
	melted_iron_4_link = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_04_path", "melted_iron_4_link"),
	melted_iron_5_link = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_05_path", "melted_iron_5_link"),
	melted_iron_6_link = UIWidgets.create_simple_gradient_mask_texture("forge_merge_trail_06_path", "melted_iron_6_link"),
	frame_widget = UIWidgets.create_simple_texture("character_selection_bg", "frame"),
	frame_background_widget = UIWidgets.create_simple_texture("forge_merge_bg", "frame_background"),
	door_left_widget = UIWidgets.create_simple_uv_texture("forge_door_01", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "frame_door_left"),
	door_right_widget = UIWidgets.create_simple_uv_texture("forge_door_02", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "frame_door_right"),
	button_eye_glow_widget = UIWidgets.create_simple_texture("forge_button_03_glow_effect", "merge_button_eye_glow"),
	merge_button_widget = UIWidgets.create_forge_merge_button("merge_button", "merge_button_text", "merge_button_token"),
	item_button_1_widget = UIWidgets.create_attach_icon_button("item_slot_01", "item_button_1", "item_button_1_icon", scenegraph_definition.item_button_1_icon.size, "item_button_1_animation", "item_slot_glow"),
	item_button_2_widget = UIWidgets.create_attach_icon_button("item_slot_01", "item_button_2", "item_button_2_icon", scenegraph_definition.item_button_2_icon.size, "item_button_2_animation", "item_slot_glow"),
	item_button_3_widget = UIWidgets.create_attach_icon_button("item_slot_01", "item_button_3", "item_button_3_icon", scenegraph_definition.item_button_3_icon.size, "item_button_3_animation", "item_slot_glow"),
	item_button_4_widget = UIWidgets.create_attach_icon_button("item_slot_01", "item_button_4", "item_button_4_icon", scenegraph_definition.item_button_4_icon.size, "item_button_4_animation", "item_slot_glow"),
	item_button_5_widget = UIWidgets.create_attach_icon_button("item_slot_01", "item_button_5", "item_button_5_icon", scenegraph_definition.item_button_5_icon.size, "item_button_5_animation", "item_slot_glow"),
	item_reward_slot_widget = UIWidgets.create_attach_icon_button("item_slot_02", "item_reward_slot", "item_reward_slot_icon", scenegraph_definition.item_reward_slot_icon.size, "item_reward_slot_animation", "item_slot_glow_02", true),
	description_text_1 = UIWidgets.create_simple_text("merge_description_1", "description_text_1", 24, Colors.get_color_table_with_alpha("white", 255)),
	title_text = UIWidgets.create_simple_text("forge_title_merge", "title_text", 32, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header")
}
local settings = {
	num_item_buttons = 5
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets_definitions = widgets_definitions,
	settings = settings
}
