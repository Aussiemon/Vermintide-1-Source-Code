local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.transition
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
	loading_icon = {
		parent = "screen",
		horizontal_alignment = "right",
		size = {
			1280,
			1280
		},
		position = {
			1088,
			21,
			1
		}
	}
}
local loading_icon = {
	scenegraph_id = "loading_icon",
	element = {
		passes = {
			{
				pass_type = "rect",
				style_id = "background_rect"
			},
			{
				pass_type = "texture_uv_dynamic_size_uvs",
				style_id = "icon",
				texture_id = "icon_texture",
				dynamic_function = function (content, size, style, dt)
					local row_index = style.row_index
					local column_index = style.column_index
					local texture_size = style.texture_size
					local num_of_rows = size[1] / texture_size[1]
					local num_of_columns = size[2] / texture_size[2]
					local uv_row_start = (row_index - 1) / num_of_rows
					local uv_row_end = row_index / num_of_rows
					local uv_column_start = (column_index - 1) / num_of_columns
					local uv_column_end = column_index / num_of_columns
					local uvs = style.uvs
					uvs[1][1] = uv_column_end
					uvs[2][1] = uv_column_start
					uvs[1][2] = uv_row_start
					uvs[2][2] = uv_row_end

					return uvs, texture_size
				end
			}
		}
	},
	content = {
		icon_texture = "loading_icon"
	},
	style = {
		background_rect = {
			offset = {
				0,
				0,
				-1
			},
			color = {
				0,
				0,
				0,
				0
			},
			size = {
				128,
				128
			}
		},
		icon = {
			column_index = 1,
			row_index = 1,
			offset = {
				0,
				0,
				1
			},
			color = {
				255,
				255,
				255,
				255
			},
			texture_size = {
				128,
				128
			},
			uvs = {
				{
					0,
					0
				},
				{
					1,
					1
				}
			}
		}
	}
}
local definitions = {
	scenegraph_definition = scenegraph_definition,
	loading_icon = loading_icon
}

return definitions
