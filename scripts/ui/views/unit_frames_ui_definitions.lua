local RETAINED_MODE_ENABLED = true
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.unit_frames
		},
		size = {
			1920,
			1080
		}
	},
	player_unit_frame = {
		parent = "root",
		horizontal_alignment = "right",
		position = {
			0,
			0,
			1
		},
		size = {
			340,
			200
		}
	},
	character_portrait = {
		vertical_alignment = "center",
		parent = "portrait_frame",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			-2
		},
		size = {
			66,
			101
		}
	},
	talk_indicator = {
		vertical_alignment = "bottom",
		parent = "character_portrait",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			70,
			105
		}
	},
	portrait_icon = {
		vertical_alignment = "bottom",
		parent = "character_portrait",
		horizontal_alignment = "right",
		position = {
			-4,
			2,
			1
		},
		size = {
			33,
			39
		}
	},
	portrait_frame = {
		vertical_alignment = "center",
		parent = "player_unit_frame",
		horizontal_alignment = "right",
		position = {
			0,
			0,
			2
		},
		size = {
			142,
			198
		}
	},
	hp_bar_bg = {
		vertical_alignment = "bottom",
		parent = "portrait_frame",
		position = {
			-172,
			50,
			3
		},
		size = {
			198,
			24
		}
	},
	hp_bar_fg = {
		parent = "hp_bar_bg",
		position = {
			0,
			0,
			2
		},
		size = {
			198,
			24
		}
	},
	hp_bar_fill = {
		parent = "hp_bar_bg",
		position = {
			10,
			0,
			1
		},
		size = {
			178,
			24
		}
	},
	hp_bar_grimoire_debuff_fill = {
		parent = "hp_bar_bg",
		position = {
			6,
			0,
			4
		},
		size = {
			188,
			24
		}
	},
	hp_bar_shield_fill = {
		parent = "hp_bar_bg",
		position = {
			10,
			0,
			1
		},
		size = {
			178,
			24
		}
	},
	hp_bar_divider = {
		vertical_alignment = "center",
		parent = "hp_bar_fg",
		position = {
			10,
			0,
			1
		},
		size = {
			178,
			14
		}
	},
	hp_bar_max_health_divider = {
		vertical_alignment = "center",
		parent = "hp_bar_grimoire_debuff_fill",
		position = {
			0,
			0,
			1
		},
		size = {
			2,
			24
		}
	},
	hp_bar_grimoire_icon = {
		vertical_alignment = "center",
		parent = "hp_bar_grimoire_debuff_fill",
		position = {
			-12,
			0,
			1
		},
		size = {
			24,
			16
		}
	},
	player_name = {
		parent = "player_unit_frame",
		position = {
			20,
			60,
			1
		},
		size = {
			100,
			24
		}
	},
	player_level = {
		vertical_alignment = "bottom",
		parent = "character_portrait",
		horizontal_alignment = "center",
		position = {
			0,
			-30,
			2
		},
		size = {
			57,
			28
		}
	}
}

local function create_player_portrait_widget_scenegraph_small(index)
	local frame_name = "player_unit_frame_" .. index
	scenegraph_definition[frame_name] = {
		vertical_alignment = "bottom",
		parent = "root",
		position = {
			(index - 1)*340,
			0,
			1
		},
		size = {
			340,
			200
		}
	}
	local portrait_frame_name = "portrait_frame_" .. index
	scenegraph_definition[portrait_frame_name] = {
		vertical_alignment = "center",
		horizontal_alignment = "left",
		parent = frame_name,
		position = {
			0,
			0,
			2
		},
		size = {
			142,
			198
		}
	}
	local character_portrait_name = "character_portrait_" .. index
	scenegraph_definition[character_portrait_name] = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		parent = portrait_frame_name,
		position = {
			0,
			0,
			-2
		},
		size = {
			66,
			101
		}
	}
	local portrait_icon_name = "portrait_icon_" .. index
	scenegraph_definition[portrait_icon_name] = {
		vertical_alignment = "bottom",
		horizontal_alignment = "right",
		parent = character_portrait_name,
		position = {
			-4,
			2,
			1
		},
		size = {
			33,
			39
		}
	}
	local talk_indicator_frame_name = "talk_indicator_" .. index
	scenegraph_definition[talk_indicator_frame_name] = {
		vertical_alignment = "bottom",
		horizontal_alignment = "center",
		parent = character_portrait_name,
		position = {
			0,
			-2,
			1
		},
		size = {
			70,
			105
		}
	}
	local inventory_bg_name = "inventory_bg_" .. index
	scenegraph_definition[inventory_bg_name] = {
		vertical_alignment = "bottom",
		horizontal_alignment = "right",
		parent = portrait_frame_name,
		position = {
			165,
			50,
			1
		},
		size = {
			190,
			90
		}
	}
	local hp_bar_bg_name = "hp_bar_bg_" .. index
	scenegraph_definition[hp_bar_bg_name] = {
		vertical_alignment = "top",
		horizontal_alignment = "center",
		parent = inventory_bg_name,
		position = {
			0,
			0,
			3
		},
		size = {
			190,
			18
		}
	}
	local hp_bar_fg_name = "hp_bar_fg_" .. index
	scenegraph_definition[hp_bar_fg_name] = {
		parent = hp_bar_bg_name,
		position = {
			0,
			2,
			2
		},
		size = {
			190,
			18
		}
	}
	scenegraph_definition["hp_bar_fill_" .. index] = {
		parent = hp_bar_bg_name,
		position = {
			6,
			2,
			1
		},
		size = {
			178,
			18
		}
	}
	local hp_bar_grimoire_debuff_fill_name = "hp_bar_grimoire_debuff_fill_" .. index
	scenegraph_definition[hp_bar_grimoire_debuff_fill_name] = {
		parent = hp_bar_fg_name,
		position = {
			2,
			1,
			4
		},
		size = {
			186,
			16
		}
	}
	scenegraph_definition["hp_bar_shield_fill_" .. index] = {
		vertical_alignment = "center",
		parent = hp_bar_bg_name,
		position = {
			6,
			2,
			2
		},
		size = {
			178,
			18
		}
	}
	scenegraph_definition["hp_bar_divider_" .. index] = {
		vertical_alignment = "center",
		parent = hp_bar_fg_name,
		position = {
			6,
			0,
			1
		},
		size = {
			178,
			10
		}
	}
	scenegraph_definition["hp_bar_max_health_divider_" .. index] = {
		vertical_alignment = "center",
		parent = hp_bar_grimoire_debuff_fill_name,
		position = {
			184,
			0,
			5
		},
		size = {
			2,
			18
		}
	}
	scenegraph_definition["hp_bar_grimoire_icon_" .. index] = {
		vertical_alignment = "center",
		parent = hp_bar_grimoire_debuff_fill_name,
		position = {
			172,
			0,
			1
		},
		size = {
			24,
			16
		}
	}
	local player_name = "player_name_" .. index
	scenegraph_definition[player_name] = {
		vertical_alignment = "top",
		parent = inventory_bg_name,
		position = {
			0,
			23,
			2
		},
		size = {
			100,
			20
		}
	}
	local player_level = "player_level_" .. index
	scenegraph_definition[player_level] = {
		vertical_alignment = "bottom",
		horizontal_alignment = "center",
		parent = character_portrait_name,
		position = {
			0,
			-30,
			2
		},
		size = {
			57,
			28
		}
	}

	return 
end

create_player_portrait_widget_scenegraph_small(1)
create_player_portrait_widget_scenegraph_small(2)
create_player_portrait_widget_scenegraph_small(3)

local temp_offext = {
	0,
	0,
	0
}
UIElements.TeamPlayerPortrait = {
	passes = {
		{
			pass_type = "texture",
			style_id = "portrait_frame",
			texture_id = "portrait_frame",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "character_portrait",
			texture_id = "character_portrait",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "portrait_overlay",
			texture_id = "portrait_overlay",
			retained_mode = RETAINED_MODE_ENABLED,
			content_check_function = function (content)
				return content.display_portrait_overlay
			end
		},
		{
			pass_type = "texture",
			style_id = "portrait_icon",
			texture_id = "portrait_icon",
			retained_mode = RETAINED_MODE_ENABLED,
			content_check_function = function (content)
				return content.display_portrait_icon
			end
		},
		{
			pass_type = "rotated_texture",
			style_id = "connecting_icon",
			texture_id = "connecting_icon",
			content_check_function = function (content)
				return content.connecting
			end
		},
		{
			pass_type = "texture",
			style_id = "talk_indicator_highlight",
			texture_id = "talk_indicator_highlight",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "inventory_bg",
			texture_id = "inventory_bg",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_bg",
			texture_id = "hp_bar_bg",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_fg",
			texture_id = "hp_bar_fg",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_highlight",
			texture_id = "hp_bar_highlight",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			style_id = "hp_bar",
			pass_type = "texture_uv_dynamic_color_uvs_size_offset",
			content_id = "hp_bar",
			content_check_function = function (content)
				return content.draw_health_bar
			end,
			dynamic_function = function (content, style, size, dt, ui_renderer)
				local bar_value = content.bar_value
				local is_wounded = content.is_wounded
				local inverted_bar_value = bar_value - 1

				if is_wounded then
					content.texture_id = content.wounded_texture_id
				else
					content.texture_id = content.normal_texture_id
					local gui = ui_renderer.gui
					local gui_material = Gui.material(gui, content.texture_id)

					if content.is_knocked_down then
						Material.set_vector2(gui_material, "color_tint_uv", Vector2(1, 0.5))
					else
						Material.set_vector2(gui_material, "color_tint_uv", Vector2(inverted_bar_value, 0.5))
					end
				end

				local uv_start_pixels = style.uv_start_pixels
				local uv_scale_pixels = style.uv_scale_pixels
				local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value
				local uvs = style.uvs
				local uv_scale_axis = style.scale_axis
				local offset_scale = style.offset_scale
				uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
				size[uv_scale_axis] = uv_pixels

				return style.color, uvs, size
			end
		},
		{
			style_id = "hp_bar_grimoire_debuff",
			pass_type = "texture_uv_dynamic_color_uvs_size_offset",
			content_id = "hp_bar_grimoire_debuff",
			dynamic_function = function (content, style, size, dt)
				local bar_value = content.bar_value
				local alpha_value = 0
				local color = style.color
				color[2] = 255
				color[3] = 255
				color[4] = 255
				local uv_start_pixels = style.uv_start_pixels
				local uv_scale_pixels = style.uv_scale_pixels
				local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value
				local uvs = style.uvs
				local uv_scale_axis = style.scale_axis
				local offset_scale = style.offset_scale
				local offset = temp_offext
				offset[1] = 0
				offset[2] = 0
				offset[3] = 0
				uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
				size[uv_scale_axis] = uv_pixels
				offset[uv_scale_axis] = ((uv_start_pixels + uv_scale_pixels) - uv_pixels)*offset_scale

				return color, uvs, size, offset
			end
		},
		{
			style_id = "hp_bar_shield",
			pass_type = "texture_uv_dynamic_color_uvs_size_offset",
			content_id = "hp_bar_shield",
			dynamic_function = function (content, style, size, dt, ui_renderer)
				local bar_value_position = content.bar_value_position
				local bar_value_offset = content.bar_value_offset
				local bar_value_size = content.bar_value_size
				local uv_start_pixels = style.uv_start_pixels
				local uv_scale_pixels = style.uv_scale_pixels
				local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value_position
				local uvs = style.uvs
				local uv_scale_axis = style.scale_axis
				local offset_scale = style.offset_scale
				local offset = temp_offext
				offset[1] = 0
				offset[2] = 0
				offset[3] = 0
				uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
				local shield_size = uv_start_pixels + uv_scale_pixels*bar_value_size
				size[uv_scale_axis] = shield_size
				local bar_offset = bar_value_offset*uv_scale_pixels
				local pos = uv_scale_pixels - shield_size - bar_offset

				if shield_size + uv_pixels < uv_scale_pixels - bar_offset then
					pos = uv_pixels
				end

				offset[uv_scale_axis] = pos

				return style.color, uvs, size, offset
			end
		},
		{
			pass_type = "centered_texture_amount",
			style_id = "hp_bar_divider",
			texture_id = "hp_bar_divider",
			content_check_function = function (content, style)
				return 0 < style.texture_amount
			end
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_grimoire_icon",
			texture_id = "hp_bar_grimoire_icon",
			content_id = "hp_bar_grimoire_icon",
			retained_mode = RETAINED_MODE_ENABLED,
			content_check_function = function (content, style)
				return content.active
			end
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_max_health_divider",
			texture_id = "hp_bar_max_health_divider",
			content_id = "hp_bar_max_health_divider",
			retained_mode = RETAINED_MODE_ENABLED,
			content_check_function = function (content, style)
				return content.active
			end
		},
		{
			style_id = "player_name",
			pass_type = "text",
			text_id = "player_name",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "player_level_bg",
			texture_id = "player_level_bg",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			style_id = "player_level",
			pass_type = "text",
			text_id = "player_level",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "host_icon",
			texture_id = "host_icon",
			content_check_function = function (content)
				return content.is_host
			end
		}
	}
}
local portraits = {
	"unit_frame_02",
	"unit_frame_03",
	"unit_frame_04",
	"unit_frame_05",
	"unit_frame_06",
	"unit_frame_07"
}

local function get_portrait_from_level(level)
	return portraits[level]
end

local function create_player_portrait_widget_definition_small(index)
	return {
		element = UIElements.TeamPlayerPortrait,
		content = {
			talk_indicator_highlight = "talk_indicator_frame",
			hp_bar_divider = "teammate_hp_bar_divider",
			display_portrait_icon = true,
			portrait_frame = "unit_frame_01",
			player_level_bg = "unit_frame_lvl_bg",
			portrait_icon = "unit_frame_icon_01",
			display_portrait_overlay = true,
			connecting = false,
			portrait_overlay = "unit_frame_red_overlay",
			connecting_icon = "matchmaking_connecting_icon",
			hp_bar_fg = "teammate_hp_bar_fg",
			player_name = "Ola Bengtsson",
			inventory_bg = "teammate_bg",
			hp_bar_bg = "teammate_hp_bar_bg",
			character_portrait = "unit_frame_portrait_empire_soldier",
			player_level = "1",
			host_icon = "host_icon",
			hp_bar_highlight = "teammate_hp_bar_highlight",
			bar_value = 1,
			hp_bar = {
				low_health = false,
				wounded_texture_id = "teammate_hp_bar",
				texture_id = "teammate_hp_bar",
				draw_health_bar = true,
				bar_value = 1,
				is_knocked_down = false,
				is_wounded = false,
				normal_texture_id = "teammate_hp_bar_color_tint_" .. index
			},
			hp_bar_grimoire_debuff = {
				texture_id = "teammate_hp_bar_overlay",
				bar_value = 0
			},
			hp_bar_shield = {
				texture_id = "teammate_hp_bar",
				bar_value_offset = 0,
				bar_value_position = 0,
				bar_value_size = 0
			},
			hp_bar_grimoire_icon = {
				hp_bar_grimoire_icon = "grimoire_icon",
				active = false
			},
			hp_bar_max_health_divider = {
				hp_bar_max_health_divider = "max_health_divider_teammate",
				active = false
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
		},
		style = {
			host_icon = {
				size = {
					18,
					14
				},
				offset = {
					0,
					0,
					8
				},
				color = {
					180,
					255,
					255,
					255
				},
				scenegraph_id = "character_portrait_" .. index
			},
			character_portrait = {
				scenegraph_id = "character_portrait_" .. index
			},
			connecting_icon = {
				angle = 0,
				scenegraph_id = "character_portrait_" .. index,
				size = {
					50,
					50
				},
				offset = {
					9,
					22,
					1
				},
				color = {
					255,
					255,
					255,
					255
				},
				pivot = {
					25,
					25
				}
			},
			portrait_frame = {
				scenegraph_id = "portrait_frame_" .. index
			},
			portrait_icon = {
				scenegraph_id = "portrait_icon_" .. index
			},
			portrait_overlay = {
				scenegraph_id = "character_portrait_" .. index,
				size = {
					66,
					101
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					1
				}
			},
			talk_indicator_highlight = {
				scenegraph_id = "talk_indicator_" .. index,
				color = {
					0,
					255,
					255,
					255
				}
			},
			inventory_bg = {
				scenegraph_id = "inventory_bg_" .. index
			},
			hp_bar_fg = {
				scenegraph_id = "hp_bar_fg_" .. index
			},
			hp_bar_bg = {
				scenegraph_id = "hp_bar_bg_" .. index
			},
			hp_bar = {
				uv_start_pixels = 0,
				uv_scale_pixels = 178,
				offset_scale = 1,
				scale_axis = 1,
				scenegraph_id = "hp_bar_fill_" .. index,
				color = {
					255,
					255,
					255,
					255
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
				},
				offset = {
					0,
					0,
					0
				}
			},
			hp_bar_grimoire_debuff = {
				uv_start_pixels = 0,
				uv_scale_pixels = 186,
				offset_scale = 1,
				scale_axis = 1,
				scenegraph_id = "hp_bar_grimoire_debuff_fill_" .. index,
				color = {
					255,
					0,
					0,
					0
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
				},
				offset = {
					0,
					0,
					0
				}
			},
			hp_bar_shield = {
				uv_start_pixels = 0,
				uv_scale_pixels = 178,
				offset_scale = 1,
				scale_axis = 1,
				scenegraph_id = "hp_bar_shield_fill_" .. index,
				color = {
					255,
					0,
					166,
					255
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
				},
				offset = {
					0,
					0,
					0
				}
			},
			hp_bar_divider = {
				texture_axis = 1,
				texture_amount = 9,
				scenegraph_id = "hp_bar_divider_" .. index,
				texture_size = {
					4,
					10
				}
			},
			hp_bar_highlight = {
				scenegraph_id = "hp_bar_fg_" .. index,
				color = {
					0,
					255,
					255,
					255
				}
			},
			hp_bar_grimoire_icon = {
				scenegraph_id = "hp_bar_grimoire_icon_" .. index,
				offset = {
					0,
					0,
					0
				}
			},
			hp_bar_max_health_divider = {
				scenegraph_id = "hp_bar_max_health_divider_" .. index,
				offset = {
					0,
					0,
					0
				}
			},
			player_name = {
				font_type = "hell_shark",
				font_size = 16,
				text_color = Colors.color_definitions.white,
				scenegraph_id = "player_name_" .. index
			},
			player_level_bg = {
				scenegraph_id = "player_level_" .. index
			},
			player_level = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				font_type = "hell_shark",
				font_size = 18,
				offset = {
					0,
					0,
					1
				},
				text_color = Colors.color_definitions.cheeseburger,
				scenegraph_id = "player_level_" .. index
			}
		},
		scenegraph_id = "player_unit_frame_" .. index
	}
end

UIElements.PlayerPortrait = {
	passes = {
		{
			pass_type = "texture",
			style_id = "portrait_frame",
			texture_id = "portrait_frame",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "character_portrait",
			texture_id = "character_portrait",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "host_icon",
			texture_id = "host_icon",
			content_check_function = function (content)
				return content.is_host
			end,
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "portrait_overlay",
			texture_id = "portrait_overlay",
			content_check_function = function (content)
				return content.display_portrait_overlay
			end,
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "portrait_icon",
			texture_id = "portrait_icon",
			content_check_function = function (content)
				return content.display_portrait_icon
			end,
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "talk_indicator_highlight",
			texture_id = "talk_indicator_highlight",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_bg",
			texture_id = "hp_bar_bg",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_fg",
			texture_id = "hp_bar_fg",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_highlight",
			texture_id = "hp_bar_highlight",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			style_id = "hp_bar",
			pass_type = "texture_uv_dynamic_color_uvs_size_offset",
			content_id = "hp_bar",
			content_check_function = function (content)
				return content.draw_health_bar
			end,
			dynamic_function = function (content, style, size, dt, ui_renderer)
				local bar_value = content.bar_value
				local is_wounded = content.is_wounded
				local inverted_bar_value = bar_value - 1

				if is_wounded then
					content.texture_id = content.wounded_texture_id
				else
					content.texture_id = content.normal_texture_id
					local gui = ui_renderer.gui
					local gui_material = Gui.material(gui, content.texture_id)

					if content.is_knocked_down then
						Material.set_vector2(gui_material, "color_tint_uv", Vector2(1, 0.5))
					else
						Material.set_vector2(gui_material, "color_tint_uv", Vector2(inverted_bar_value, 0.5))
					end
				end

				local uv_start_pixels = style.uv_start_pixels
				local uv_scale_pixels = style.uv_scale_pixels
				local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value
				local uvs = style.uvs
				local uv_scale_axis = style.scale_axis
				local offset_scale = style.offset_scale
				local offset = temp_offext
				offset[1] = 0
				offset[2] = 0
				offset[3] = 0
				uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
				size[uv_scale_axis] = uv_pixels
				offset[uv_scale_axis] = ((uv_start_pixels + uv_scale_pixels) - uv_pixels)*offset_scale

				return style.color, uvs, size, offset
			end
		},
		{
			style_id = "hp_bar_grimoire_debuff",
			pass_type = "texture_uv_dynamic_color_uvs_size_offset",
			content_id = "hp_bar_grimoire_debuff",
			dynamic_function = function (content, style, size, dt)
				local bar_value = content.bar_value
				local alpha_value = 0
				local color = style.color
				color[2] = 255
				color[3] = 255
				color[4] = 255
				local uv_start_pixels = style.uv_start_pixels
				local uv_scale_pixels = style.uv_scale_pixels
				local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value
				local uvs = style.uvs
				local uv_scale_axis = style.scale_axis
				local offset_scale = style.offset_scale
				uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
				size[uv_scale_axis] = uv_pixels

				return color, uvs, size
			end
		},
		{
			style_id = "hp_bar_shield",
			pass_type = "texture_uv_dynamic_color_uvs_size_offset",
			content_id = "hp_bar_shield",
			dynamic_function = function (content, style, size, dt, ui_renderer)
				local bar_value_position = content.bar_value_position
				local bar_value_offset = content.bar_value_offset
				local bar_value_size = content.bar_value_size
				local uv_start_pixels = style.uv_start_pixels
				local uv_scale_pixels = style.uv_scale_pixels
				local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value_position
				local uvs = style.uvs
				local uv_scale_axis = style.scale_axis
				local offset_scale = style.offset_scale
				local offset = temp_offext
				offset[1] = 0
				offset[2] = 0
				offset[3] = 0
				uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
				local shield_size = uv_start_pixels + uv_scale_pixels*bar_value_size
				size[uv_scale_axis] = shield_size
				local bar_offset = bar_value_offset*uv_scale_pixels
				local pos = bar_offset

				if shield_size + uv_pixels < uv_scale_pixels - bar_offset then
					pos = ((uv_start_pixels + uv_scale_pixels) - uv_pixels)*offset_scale - shield_size
				end

				offset[uv_scale_axis] = pos

				return style.color, uvs, size, offset
			end
		},
		{
			pass_type = "centered_texture_amount",
			style_id = "hp_bar_divider",
			texture_id = "hp_bar_divider",
			content_check_function = function (content, style)
				return 0 < style.texture_amount
			end
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_grimoire_icon",
			texture_id = "hp_bar_grimoire_icon",
			content_id = "hp_bar_grimoire_icon",
			retained_mode = RETAINED_MODE_ENABLED,
			content_check_function = function (content, style)
				return content.active
			end
		},
		{
			pass_type = "texture",
			style_id = "hp_bar_max_health_divider",
			texture_id = "hp_bar_max_health_divider",
			content_id = "hp_bar_max_health_divider",
			retained_mode = RETAINED_MODE_ENABLED,
			content_check_function = function (content, style)
				return content.active
			end
		},
		{
			style_id = "player_name",
			pass_type = "text",
			text_id = "player_name",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			pass_type = "texture",
			style_id = "player_level_bg",
			texture_id = "player_level_bg",
			retained_mode = RETAINED_MODE_ENABLED
		},
		{
			style_id = "player_level",
			pass_type = "text",
			text_id = "player_level",
			retained_mode = RETAINED_MODE_ENABLED
		}
	}
}
local player_portrait_widget_definition = {
	scenegraph_id = "player_unit_frame",
	element = UIElements.PlayerPortrait,
	content = {
		talk_indicator_highlight = "talk_indicator_frame",
		host_icon = "host_icon",
		portrait_frame = "unit_frame_01",
		player_level_bg = "unit_frame_lvl_bg",
		portrait_icon = "unit_frame_icon_01",
		hp_bar_divider = "player_hp_bar_divider",
		display_portrait_overlay = true,
		display_portrait_icon = true,
		character_portrait = "unit_frame_portrait_empire_soldier",
		portrait_overlay = "unit_frame_red_overlay",
		hp_bar_fg = "player_hp_bar_fg",
		player_name = "",
		hp_bar_highlight = "player_hp_bar_highlight",
		player_level = "30",
		hp_bar_bg = "player_hp_bar_bg",
		hp_bar = {
			low_health = false,
			wounded_texture_id = "player_hp_bar",
			texture_id = "player_hp_bar",
			draw_health_bar = true,
			bar_value = 1,
			is_knocked_down = false,
			is_wounded = false,
			normal_texture_id = "player_hp_bar_color_tint"
		},
		hp_bar_grimoire_debuff = {
			texture_id = "player_hp_bar_overlay",
			bar_value = 0
		},
		hp_bar_shield = {
			texture_id = "player_hp_bar",
			bar_value_offset = 0,
			bar_value_position = 0,
			bar_value_size = 0
		},
		hp_bar_grimoire_icon = {
			hp_bar_grimoire_icon = "grimoire_icon",
			active = false
		},
		hp_bar_max_health_divider = {
			hp_bar_max_health_divider = "max_health_divider",
			active = false
		}
	},
	style = {
		host_icon = {
			scenegraph_id = "character_portrait",
			size = {
				18,
				14
			},
			offset = {
				0,
				0,
				8
			},
			color = {
				180,
				255,
				255,
				255
			}
		},
		portrait_frame = {
			scenegraph_id = "portrait_frame"
		},
		character_portrait = {
			scenegraph_id = "character_portrait"
		},
		portrait_icon = {
			scenegraph_id = "portrait_icon"
		},
		portrait_overlay = {
			scenegraph_id = "character_portrait",
			size = {
				66,
				101
			},
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				1
			}
		},
		talk_indicator_highlight = {
			scenegraph_id = "talk_indicator",
			color = {
				0,
				255,
				255,
				255
			}
		},
		hp_bar_fg = {
			scenegraph_id = "hp_bar_fg"
		},
		hp_bar_bg = {
			scenegraph_id = "hp_bar_bg"
		},
		hp_bar = {
			uv_start_pixels = 0,
			scenegraph_id = "hp_bar_fill",
			uv_scale_pixels = 178,
			offset_scale = 1,
			scale_axis = 1,
			color = {
				255,
				255,
				255,
				255
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
			},
			offset = {
				0,
				0,
				0
			}
		},
		hp_bar_grimoire_debuff = {
			uv_start_pixels = 0,
			scenegraph_id = "hp_bar_grimoire_debuff_fill",
			uv_scale_pixels = 188,
			offset_scale = 1,
			scale_axis = 1,
			color = {
				255,
				0,
				0,
				0
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
			},
			offset = {
				0,
				0,
				0
			}
		},
		hp_bar_shield = {
			uv_start_pixels = 0,
			scenegraph_id = "hp_bar_shield_fill",
			uv_scale_pixels = 178,
			offset_scale = 1,
			scale_axis = 1,
			color = {
				255,
				0,
				166,
				255
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
			},
			offset = {
				0,
				0,
				0
			}
		},
		hp_bar_divider = {
			texture_axis = 1,
			scenegraph_id = "hp_bar_divider",
			texture_amount = 9,
			texture_size = {
				4,
				14
			}
		},
		hp_bar_grimoire_icon = {
			scenegraph_id = "hp_bar_grimoire_icon",
			offset = {
				0,
				0,
				0
			}
		},
		hp_bar_max_health_divider = {
			scenegraph_id = "hp_bar_max_health_divider",
			offset = {
				0,
				0,
				0
			}
		},
		hp_bar_highlight = {
			scenegraph_id = "hp_bar_fg",
			color = {
				0,
				255,
				255,
				255
			}
		},
		player_name = {
			font_type = "hell_shark",
			scenegraph_id = "player_name",
			font_size = 14,
			horizontal_alignment = "center",
			text_color = Colors.color_definitions.white
		},
		player_level_bg = {
			scenegraph_id = "player_level"
		},
		player_level = {
			vertical_alignment = "center",
			scenegraph_id = "player_level",
			horizontal_alignment = "center",
			font_type = "hell_shark",
			font_size = 18,
			offset = {
				0,
				0,
				1
			},
			text_color = Colors.color_definitions.cheeseburger
		}
	}
}
local character_portrait_mapping = {
	witch_hunter = "unit_frame_portrait_witch_hunter",
	empire_soldier = "unit_frame_portrait_empire_soldier",
	dwarf_ranger = "unit_frame_portrait_dwarf_ranger",
	test_profile = "unit_frame_portrait_empire_soldier",
	wood_elf = "unit_frame_portrait_way_watcher",
	bright_wizard = "unit_frame_portrait_bright_wizard",
	downed = "unit_frame_portrait_downed",
	dead = "unit_frame_portrait_dead"
}
local character_portrait_mapping_point_sample = {
	witch_hunter = "unit_frame_portrait_witch_hunter_point_sample",
	empire_soldier = "unit_frame_portrait_empire_soldier_point_sample",
	dwarf_ranger = "unit_frame_portrait_dwarf_ranger_point_sample",
	test_profile = "unit_frame_portrait_empire_soldier_point_sample",
	wood_elf = "unit_frame_portrait_way_watcher_point_sample",
	bright_wizard = "unit_frame_portrait_bright_wizard_point_sample",
	downed = "unit_frame_portrait_downed",
	dead = "unit_frame_portrait_dead"
}
local inventory_consumable_icons = {
	wpn_grimoire_01 = "teammate_consumable_icon_grimoire",
	potion_speed_boost_01 = "teammate_consumable_icon_speed",
	potion_healing_draught_01 = "teammate_consumable_icon_potion_01",
	grenade_frag_02 = "teammate_consumable_icon_frag",
	[3.0] = "teammate_consumable_icon_grenade_empty",
	grenade_frag_01 = "teammate_consumable_icon_frag",
	grenade_smoke_02 = "teammate_consumable_icon_smoke",
	grenade_fire_01 = "teammate_consumable_icon_fire",
	grenade_fire_02 = "teammate_consumable_icon_fire",
	[1.0] = "teammate_consumable_icon_medpack_empty",
	[2.0] = "teammate_consumable_icon_potion_empty",
	grenade_smoke_01 = "teammate_consumable_icon_smoke",
	wpn_side_objective_tome_01 = "teammate_consumable_icon_book",
	potion_damage_boost_01 = "teammate_consumable_icon_strength",
	healthkit_first_aid_kit_01 = "teammate_consumable_icon_medpack"
}

local function create_player_inventory_widget_scenegraph(index)
	local scenegraph_name = "player_inventory_" .. index
	local parent_name = "inventory_bg_" .. index
	scenegraph_definition[scenegraph_name] = {
		vertical_alignment = "bottom",
		parent = parent_name,
		position = {
			10,
			10,
			1
		},
		size = {
			190,
			60
		}
	}

	return 
end

create_player_inventory_widget_scenegraph(1)
create_player_inventory_widget_scenegraph(2)
create_player_inventory_widget_scenegraph(3)

local function create_player_inventory_list_widget_definition(index)
	local scenegraph_id = "player_inventory_" .. index

	return {
		element = {
			passes = {
				{
					style_id = "list_style",
					pass_type = "list_pass",
					content_id = "list_content",
					passes = {
						{
							pass_type = "texture",
							style_id = "item_texture",
							texture_id = "item_texture"
						},
						{
							pass_type = "texture",
							style_id = "item_highlight",
							texture_id = "item_highlight"
						}
					}
				}
			}
		},
		content = {
			list_content = {}
		},
		style = {
			list_style = {
				start_index = 1,
				num_draws = 0,
				item_styles = {}
			}
		},
		scenegraph_id = scenegraph_id
	}
end

return {
	scenegraph_definition = scenegraph_definition,
	create_player_inventory_list_widget_definition = create_player_inventory_list_widget_definition,
	create_player_portrait_widget_definition_small = create_player_portrait_widget_definition_small,
	player_portrait_widget_definition = player_portrait_widget_definition,
	character_portrait_mapping = character_portrait_mapping,
	character_portrait_mapping_point_sample = character_portrait_mapping_point_sample,
	inventory_consumable_icons = inventory_consumable_icons,
	get_portrait_from_level = get_portrait_from_level
}
