local SIZE_X = 1920
local SIZE_Y = 1080
local RETAINED_MODE_ENABLED = true
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
	pivot = {
		vertical_alignment = "bottom",
		parent = "root",
		horizontal_alignment = "right",
		position = {
			-361,
			42,
			1
		},
		size = {
			0,
			0
		}
	}
}

local function create_boon_widget(index)
	local frame_offset = {
		0,
		0,
		0
	}
	local bg_color = {
		255,
		36,
		215,
		231
	}
	local icon_width = 38
	local icon_height = 38
	local frame_width = 44
	local frame_height = 44
	local bg_width = 60
	local bg_height = 84

	return {
		scenegraph_id = "pivot",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "texture_icon",
					texture_id = "texture_icon",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					pass_type = "gradient_mask_texture",
					style_id = "texture_frame",
					texture_id = "texture_frame",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					pass_type = "texture",
					style_id = "texture_bg",
					texture_id = "texture_bg",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					pass_type = "texture",
					style_id = "texture_bg",
					texture_id = "texture_bg_mask",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					style_id = "timer_text",
					pass_type = "text",
					text_id = "timer_text",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content)
						return not content.is_expired
					end
				}
			}
		},
		content = {
			texture_bg_mask = "boon_icon_bg_mask",
			timer_text = "n/a",
			is_expired = false,
			texture_bg = "boon_icon_bg",
			texture_icon = "teammate_consumable_icon_medpack",
			texture_frame = "boon_frame_path_" .. index,
			normal_color = bg_color,
			infinite_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
		},
		style = {
			texture_icon = {
				size = {
					icon_width,
					icon_height
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					frame_offset[1] + 3,
					frame_offset[2] + 3,
					2
				}
			},
			texture_frame = {
				gradient_threshold = 0.6,
				size = {
					frame_width,
					frame_height
				},
				color = {
					255,
					bg_color[2],
					bg_color[3],
					bg_color[4]
				},
				offset = {
					frame_offset[1],
					frame_offset[2],
					3
				}
			},
			timer_text = {
				vertical_alignment = "bottom",
				font_size = 16,
				horizontal_alignment = "center",
				font_type = "hell_shark",
				size = {
					frame_width,
					frame_height
				},
				offset = {
					frame_offset[1],
					frame_offset[2] - 20,
					4
				},
				text_color = {
					150,
					bg_color[2],
					bg_color[3],
					bg_color[4]
				}
			},
			texture_bg = {
				size = {
					bg_width,
					bg_height
				},
				color = {
					120,
					bg_color[2],
					bg_color[3],
					bg_color[4]
				},
				offset = {
					frame_offset[1] - 8,
					frame_offset[2] - 10,
					1
				}
			}
		},
		offset = {
			0,
			0,
			0
		}
	}
end

local widget_definitions = {}
local MAX_NUMBER_OF_BOONS = MaxDisplayableBoons

for i = 1, MAX_NUMBER_OF_BOONS, 1 do
	widget_definitions[i] = create_boon_widget(i)
end

return {
	MAX_NUMBER_OF_BOONS = MAX_NUMBER_OF_BOONS,
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions
}
