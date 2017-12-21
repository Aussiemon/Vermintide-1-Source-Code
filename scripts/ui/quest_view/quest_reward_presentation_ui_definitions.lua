local SIZE_X = 1920
local SIZE_Y = 1080
local RETAINED_MODE_ENABLED = nil
local scenegraph_definition = {
	pivot = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		position = {
			0.5,
			0,
			1
		},
		size = {
			0,
			0
		}
	},
	root = {
		is_root = true,
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.end_screen
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
			UILayer.end_screen
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
	input_description_text = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1200,
			50
		},
		position = {
			0,
			80,
			5
		}
	}
}
local widget_definitions = {
	input_description_text = UIWidgets.create_simple_text("press_any_key_to_continue", "input_description_text", 18, Colors.get_color_table_with_alpha("white", 255))
}

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions,
	animation_definitions = {}
}
