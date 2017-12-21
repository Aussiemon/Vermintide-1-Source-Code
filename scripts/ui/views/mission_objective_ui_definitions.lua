local SIZE_X = 1920
local SIZE_Y = 1080
local ICON_SIZE = {
	64,
	64
}
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
		parent = "root",
		horizontal_alignment = "center",
		position = {
			ICON_SIZE[1]*0.5,
			SIZE_Y/2 - 150,
			100
		},
		size = {
			SIZE_X,
			100
		}
	},
	mission_icon_left = {
		vertical_alignment = "center",
		parent = "area_text_box",
		horizontal_alignment = "center",
		size = {
			ICON_SIZE[1],
			ICON_SIZE[2]
		},
		position = {
			0,
			ICON_SIZE[2]*0.3,
			1
		}
	},
	mission_icon_right = {
		vertical_alignment = "center",
		parent = "area_text_box",
		horizontal_alignment = "center",
		size = {
			ICON_SIZE[1],
			ICON_SIZE[2]
		},
		position = {
			0,
			ICON_SIZE[2]*0.3,
			1
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
				},
				{
					texture_id = "mission_icon_left",
					style_id = "mission_icon_left",
					pass_type = "texture"
				}
			}
		},
		content = {
			mission_icon_right = "hud_tutorial_icon_mission",
			area_text_content = "placeholder_area_text",
			mission_icon_left = "hud_tutorial_icon_mission"
		},
		style = {
			area_text_style = {
				vertical_alignment = "top",
				localize = false,
				font_size = 54,
				font_type = "hell_shark",
				horizontal_alignment = "center",
				text_color = color,
				offset = {
					0,
					-5,
					1
				}
			},
			mission_icon_left = {
				scenegraph_id = "mission_icon_left",
				offset = {
					0,
					0,
					1
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			mission_icon_right = {
				scenegraph_id = "mission_icon_right",
				offset = {
					0,
					0,
					1
				},
				color = {
					0,
					255,
					255,
					255
				}
			}
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions
}
