local SIZE_X = 1920
local SIZE_Y = 1080
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.hud
		},
		size = {
			SIZE_X,
			SIZE_Y
		}
	},
	area_text_box = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		position = {
			0,
			100,
			100
		},
		size = {
			SIZE_X,
			100
		}
	}
}
local color = table.clone(Colors.color_definitions.white)
color[1] = 0
local widget_definitions = {
	area_text_box = {
		scenegraph_id = "area_text_box",
		element = {
			passes = {
				{
					style_id = "area_text_style",
					pass_type = "text",
					text_id = "area_text_content"
				}
			}
		},
		content = {
			area_text_content = "placeholder_area_text"
		},
		style = {
			area_text_style = {
				vertical_alignment = "top",
				localize = true,
				font_size = 36,
				font_type = "hell_shark",
				horizontal_alignment = "center",
				text_color = color,
				offset = {
					0,
					0,
					1
				}
			}
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions
}
