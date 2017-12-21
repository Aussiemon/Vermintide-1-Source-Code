local_require("scripts/ui/ui_widgets")

local FONT_SIZE = 18
local MAX_NUMBER_OF_MESSAGES = 5
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
	message_animated = {
		parent = "root",
		size = {
			0,
			0
		},
		position = {
			30,
			450,
			0
		}
	}
}
local widget_definitions = {
	message_animated = {
		scenegraph_id = "message_animated",
		element = {
			passes = {
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					pass_type = "texture",
					style_id = "icon",
					texture_id = "icon_texture",
					content_check_function = function (content)
						if not content.icon_texture then
							return false
						end

						return true
					end
				}
			}
		},
		content = {
			text = "",
			icon_texture = "",
			message_tables = {}
		},
		style = {
			text = {
				vertical_alignment = "top",
				dynamic_font = true,
				scenegraph_id = "message_animated",
				font_type = "hell_shark",
				font_size = FONT_SIZE,
				text_color = Colors.get_table("white"),
				offset = {
					0,
					0,
					0
				}
			},
			icon = {
				scenegraph_id = "message_animated",
				size = {
					20,
					20
				},
				offset = {
					-20,
					-20,
					0
				},
				color = Colors.get_table("white")
			}
		}
	}
}

local function create_message_widgets(number_of_slots)
	local entries = {}

	for i = 1, number_of_slots, 1 do
		local scenegraph_id = "message_" .. i
		local y_pos = scenegraph_definition.message_animated.position[2] - 4
		scenegraph_definition[scenegraph_id] = {
			parent = "root",
			position = {
				30,
				y_pos + FONT_SIZE*(i - 1),
				1
			},
			size = {
				0,
				0
			}
		}
		local message = {
			element = {
				passes = {
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text"
					},
					{
						pass_type = "texture",
						style_id = "icon",
						texture_id = "icon_texture",
						content_check_function = function (content)
							if not content.icon_texture then
								return false
							end

							return true
						end
					}
				}
			},
			content = {
				text = "",
				icon_texture = "hud_tutorial_icon_info",
				message_tables = {}
			},
			style = {
				text = {
					dynamic_font = true,
					font_size = 18,
					font_type = "hell_shark",
					scenegraph_id = scenegraph_id,
					text_color = Colors.get_table("white"),
					offset = {
						0,
						0,
						0
					}
				},
				icon = {
					scenegraph_id = scenegraph_id,
					size = {
						20,
						20
					},
					offset = {
						-20,
						0,
						0
					},
					color = Colors.get_table("white")
				}
			},
			scenegraph_id = scenegraph_id
		}
		entries[i] = message
	end

	return entries
end

local message_widgets = create_message_widgets(MAX_NUMBER_OF_MESSAGES - 1)

return {
	scenegraph_definition = scenegraph_definition,
	animated_message_widget = widget_definitions.message_animated,
	message_widgets = message_widgets,
	MAX_NUMBER_OF_MESSAGES = MAX_NUMBER_OF_MESSAGES
}
