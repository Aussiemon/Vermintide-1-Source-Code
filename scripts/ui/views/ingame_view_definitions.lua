local create_menu_button = UIWidgets.create_menu_button
local create_simple_texture = UIWidgets.create_simple_texture
local create_simple_uv_texture = UIWidgets.create_simple_uv_texture
local MENU_BUTTON_SIZE = {
	318,
	84
}
local MENU_BUTTON_POSITION = {
	0,
	-84,
	1
}
IngameViewDefinitions = {
	scenegraph_definition = {
		root = {
			is_root = true,
			position = {
				0,
				0,
				UILayer.main_menu
			},
			size = {
				1920,
				1080
			}
		},
		screen = {
			vertical_alignment = "center",
			parent = "root",
			horizontal_alignment = "center",
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
		background_top = {
			vertical_alignment = "top",
			parent = "screen",
			horizontal_alignment = "center",
			position = {
				0,
				-130,
				2
			},
			size = {
				430,
				159
			}
		},
		background_bottom = {
			vertical_alignment = "top",
			parent = "background_top",
			horizontal_alignment = "center",
			position = {
				-6,
				-132,
				-1
			},
			size = {
				446,
				879
			}
		},
		main_menu = {
			vertical_alignment = "center",
			parent = "root",
			horizontal_alignment = "center",
			offset = {
				-6,
				50,
				1
			},
			size = {
				614,
				876
			}
		},
		button_gamepad_selection = {
			vertical_alignment = "bottom",
			parent = "button_1",
			horizontal_alignment = "center",
			position = {
				0,
				62,
				10
			},
			size = {
				369,
				127
			}
		},
		button_1 = {
			vertical_alignment = "top",
			parent = "background_top",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = {
				0,
				-140,
				1
			}
		},
		button_2 = {
			vertical_alignment = "bottom",
			parent = "button_1",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = MENU_BUTTON_POSITION
		},
		button_3 = {
			vertical_alignment = "bottom",
			parent = "button_2",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = MENU_BUTTON_POSITION
		},
		button_4 = {
			vertical_alignment = "bottom",
			parent = "button_3",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = MENU_BUTTON_POSITION
		},
		button_5 = {
			vertical_alignment = "bottom",
			parent = "button_4",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = MENU_BUTTON_POSITION
		},
		button_6 = {
			vertical_alignment = "bottom",
			parent = "button_5",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = MENU_BUTTON_POSITION
		},
		button_7 = {
			vertical_alignment = "bottom",
			parent = "button_6",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = MENU_BUTTON_POSITION
		},
		button_8 = {
			vertical_alignment = "bottom",
			parent = "button_7",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = MENU_BUTTON_POSITION
		},
		button_9 = {
			vertical_alignment = "bottom",
			parent = "button_8",
			horizontal_alignment = "center",
			size = MENU_BUTTON_SIZE,
			position = MENU_BUTTON_POSITION
		}
	},
	widgets = {
		button_1 = create_menu_button("test", "button_1"),
		button_2 = create_menu_button("test", "button_2"),
		button_3 = create_menu_button("test", "button_3"),
		button_4 = create_menu_button("test", "button_4"),
		button_5 = create_menu_button("test", "button_5"),
		button_6 = create_menu_button("test", "button_6"),
		button_7 = create_menu_button("test", "button_7"),
		button_8 = create_menu_button("test", "button_8"),
		button_9 = create_menu_button("test", "button_9"),
		background_top_widget = create_simple_texture("main_menu_bg_part_02", "background_top"),
		background_bottom_widget = create_simple_uv_texture("main_menu_bg_part_01", {
			{
				0,
				0
			},
			{
				1,
				1
			}
		}, "background_bottom"),
		background_widget = create_simple_texture("main_menu_bg", "main_menu"),
		gamepad_button_selection = UIWidgets.create_gamepad_selection("button_gamepad_selection", nil, nil, {
			70,
			70
		})
	}
}

return 
