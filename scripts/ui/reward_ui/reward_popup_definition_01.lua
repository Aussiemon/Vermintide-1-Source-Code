local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.end_screen_reward
		},
		size = {
			1920,
			1080
		}
	},
	screen = {
		scale = "fit",
		position = {
			0,
			0,
			UILayer.end_screen_reward
		},
		size = {
			1920,
			1080
		}
	},
	overlay = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			1920,
			1080
		}
	},
	glow_background = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			355,
			426
		},
		position = {
			0,
			10,
			1
		}
	},
	cross = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			154,
			154
		},
		position = {
			0,
			0,
			8
		}
	},
	icon = {
		vertical_alignment = "center",
		parent = "cross",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			0,
			4
		}
	},
	top = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			224,
			146
		},
		position = {
			0,
			144,
			5
		}
	},
	title_text = {
		vertical_alignment = "center",
		parent = "top",
		horizontal_alignment = "center",
		size = {
			205,
			60
		},
		position = {
			0,
			-21,
			6
		}
	},
	sun = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			144,
			134
		},
		position = {
			0,
			-95,
			9
		}
	},
	hammer_left = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			280,
			200
		},
		position = {
			-35,
			-10,
			5
		}
	},
	hammer_right = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			280,
			200
		},
		position = {
			35,
			-10,
			5
		}
	},
	banner_left = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			62,
			208
		},
		position = {
			-140,
			29,
			3
		}
	},
	banner_right = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			56,
			208
		},
		position = {
			140,
			29,
			3
		}
	},
	banner_holder_left = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			144,
			42
		},
		position = {
			-165,
			140,
			4
		}
	},
	banner_holder_right = {
		vertical_alignment = "center",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			144,
			42
		},
		position = {
			166,
			140,
			4
		}
	},
	reward_title_text = {
		vertical_alignment = "top",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			800,
			80
		},
		position = {
			0,
			-280,
			5
		}
	},
	reward_name_text = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			800,
			80
		},
		position = {
			0,
			300,
			5
		}
	},
	reward_type_text = {
		vertical_alignment = "center",
		parent = "reward_name_text",
		horizontal_alignment = "center",
		size = {
			800,
			50
		},
		position = {
			0,
			-45,
			5
		}
	},
	hero_icon = {
		vertical_alignment = "bottom",
		parent = "reward_type_text",
		horizontal_alignment = "center",
		size = {
			46,
			46
		},
		position = {
			0,
			-35,
			5
		}
	},
	hero_icon_tooltip = {
		vertical_alignment = "bottom",
		parent = "reward_type_text",
		horizontal_alignment = "center",
		size = {
			46,
			46
		},
		position = {
			0,
			-35,
			5
		}
	},
	trait_button_1 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			185,
			5
		}
	},
	trait_button_2 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			185,
			5
		}
	},
	trait_button_3 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			185,
			5
		}
	},
	trait_button_4 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			185,
			5
		}
	},
	trait_tooltip_1 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			185,
			5
		}
	},
	trait_tooltip_2 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			185,
			5
		}
	},
	trait_tooltip_3 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			185,
			5
		}
	},
	trait_tooltip_4 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			185,
			5
		}
	},
	continue_button = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			220,
			62
		},
		position = {
			0,
			40,
			5
		}
	}
}
local default_tooltip_style = {
	font_size = 24,
	max_width = 500,
	localize = false,
	horizontal_alignment = "left",
	vertical_alignment = "top",
	font_type = "hell_shark",
	text_color = Colors.get_color_table_with_alpha("white", 255),
	line_colors = {},
	offset = {
		0,
		0,
		3
	}
}
local trait_tooltip_style = table.clone(default_tooltip_style)
trait_tooltip_style.line_colors = {
	Colors.get_color_table_with_alpha("cheeseburger", 255),
	Colors.get_color_table_with_alpha("white", 255)
}
trait_tooltip_style.last_line_color = Colors.get_color_table_with_alpha("red", 255)
local widgets = {
	hero_icon = UIWidgets.create_simple_texture("hero_icon_medium_dwarf_ranger_yellow", "hero_icon"),
	hero_icon_tooltip = UIWidgets.create_simple_tooltip("", "hero_icon_tooltip", nil, default_tooltip_style),
	trait_button_1 = UIWidgets.create_small_trait_button("trait_button_1", "trait_button_1"),
	trait_button_2 = UIWidgets.create_small_trait_button("trait_button_2", "trait_button_2"),
	trait_button_3 = UIWidgets.create_small_trait_button("trait_button_3", "trait_button_3"),
	trait_button_4 = UIWidgets.create_small_trait_button("trait_button_4", "trait_button_4"),
	trait_tooltip_1 = UIWidgets.create_simple_tooltip("", "trait_tooltip_1", nil, trait_tooltip_style),
	trait_tooltip_2 = UIWidgets.create_simple_tooltip("", "trait_tooltip_2", nil, trait_tooltip_style),
	trait_tooltip_3 = UIWidgets.create_simple_tooltip("", "trait_tooltip_3", nil, trait_tooltip_style),
	trait_tooltip_4 = UIWidgets.create_simple_tooltip("", "trait_tooltip_4", nil, trait_tooltip_style),
	reward_title_text = UIWidgets.create_simple_text("dice_game_reward_title", "reward_title_text", 72, Colors.get_color_table_with_alpha("cheeseburger", 0), nil, "hell_shark_header"),
	reward_name_text = UIWidgets.create_simple_text("", "reward_name_text", 56, Colors.get_color_table_with_alpha("white", 0), nil, "hell_shark_header"),
	reward_type_text = UIWidgets.create_simple_text("", "reward_type_text", 24, Colors.get_color_table_with_alpha("cheeseburger", 0)),
	continue_button = UIWidgets.create_menu_button_medium("dlc1_3_1_continue", "continue_button")
}
local banner_offset_table = {
	0,
	0,
	0
}
local widget_popup = {
	scenegraph_id = "overlay",
	element = {
		passes = {
			{
				pass_type = "texture",
				style_id = "background",
				texture_id = "background"
			},
			{
				pass_type = "texture",
				style_id = "glow_background",
				texture_id = "glow_background"
			},
			{
				pass_type = "texture",
				style_id = "cross",
				texture_id = "cross"
			},
			{
				style_id = "title_text",
				pass_type = "text",
				text_id = "title_text"
			},
			{
				pass_type = "rotated_texture",
				style_id = "top",
				texture_id = "top"
			},
			{
				pass_type = "texture",
				style_id = "sun",
				texture_id = "sun"
			},
			{
				pass_type = "texture",
				style_id = "icon",
				texture_id = "icon"
			},
			{
				pass_type = "texture",
				style_id = "icon_frame",
				texture_id = "icon_frame"
			},
			{
				pass_type = "rotated_texture",
				style_id = "hammer_left",
				texture_id = "hammer_left"
			},
			{
				pass_type = "rotated_texture",
				style_id = "hammer_right",
				texture_id = "hammer_right"
			},
			{
				style_id = "banner_left",
				pass_type = "texture_uv_dynamic_color_uvs_size_offset",
				content_id = "banner_left",
				dynamic_function = function (content, style, size, dt)
					local bar_value = content.bar_value
					local uv_start_pixels = style.uv_start_pixels
					local uv_scale_pixels = style.uv_scale_pixels
					local uv_pixels = uv_start_pixels + uv_scale_pixels * bar_value
					local uvs = style.uvs
					local uv_scale_axis = style.scale_axis
					local offset_scale = style.offset_scale
					banner_offset_table[uv_scale_axis] = size[uv_scale_axis] - uv_pixels
					uvs[1][uv_scale_axis] = math.max(1 - uv_pixels / (uv_start_pixels + uv_scale_pixels), 0)
					size[uv_scale_axis] = uv_pixels

					return content.color, uvs, size, banner_offset_table
				end
			},
			{
				style_id = "banner_right",
				pass_type = "texture_uv_dynamic_color_uvs_size_offset",
				content_id = "banner_right",
				dynamic_function = function (content, style, size, dt)
					local bar_value = content.bar_value
					local uv_start_pixels = style.uv_start_pixels
					local uv_scale_pixels = style.uv_scale_pixels
					local uv_pixels = uv_start_pixels + uv_scale_pixels * bar_value
					local uvs = style.uvs
					local uv_scale_axis = style.scale_axis
					local offset_scale = style.offset_scale
					banner_offset_table[uv_scale_axis] = size[uv_scale_axis] - uv_pixels
					uvs[1][uv_scale_axis] = math.max(1 - uv_pixels / (uv_start_pixels + uv_scale_pixels), 0)
					size[uv_scale_axis] = uv_pixels

					return content.color, uvs, size, banner_offset_table
				end
			},
			{
				pass_type = "texture",
				style_id = "banner_holder_left",
				texture_id = "banner_holder_left"
			},
			{
				pass_type = "texture",
				style_id = "banner_holder_right",
				texture_id = "banner_holder_right"
			}
		}
	},
	content = {
		banner_holder_left = "banner_holder_01",
		title_text = "this is a test item",
		glow_background = "loot_pop_up_bg",
		icon_frame = "frame_01",
		cross = "cross",
		top = "top",
		hammer_right = "hammer_02",
		banner_holder_right = "banner_holder_02",
		background = "gradient_dice_game_reward",
		hammer_left = "hammer_01",
		sun = "sun",
		icon = "icons_placeholder",
		banner_left = {
			texture_id = "banner_01",
			bar_value = 0
		},
		banner_right = {
			texture_id = "banner_02",
			bar_value = 0
		}
	},
	style = {
		title_text = {
			scenegraph_id = "title_text",
			word_wrap = true,
			font_size = 32,
			pixel_perfect = true,
			horizontal_alignment = "center",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("forest_green", 0),
			offset = {
				0,
				0,
				1
			}
		},
		background = {
			scenegraph_id = "screen",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			}
		},
		glow_background = {
			scenegraph_id = "glow_background",
			color = {
				255,
				255,
				255,
				255
			}
		},
		icon = {
			scenegraph_id = "icon",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				2
			}
		},
		icon_frame = {
			scenegraph_id = "icon",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				3
			}
		},
		cross = {
			scenegraph_id = "cross",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			}
		},
		top = {
			angle = 0,
			scenegraph_id = "top",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			},
			pivot = {
				112,
				73
			}
		},
		sun = {
			scenegraph_id = "sun",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			}
		},
		hammer_left = {
			angle = 0,
			scenegraph_id = "hammer_left",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			},
			pivot = {
				140,
				100
			}
		},
		hammer_right = {
			angle = 0,
			scenegraph_id = "hammer_right",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			},
			pivot = {
				140,
				100
			}
		},
		banner_left = {
			uv_start_pixels = 0,
			scenegraph_id = "banner_left",
			uv_scale_pixels = 208,
			offset_scale = 1,
			scale_axis = 2,
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
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
			}
		},
		banner_right = {
			uv_start_pixels = 0,
			scenegraph_id = "banner_right",
			uv_scale_pixels = 208,
			offset_scale = 1,
			scale_axis = 2,
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
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
			}
		},
		banner_holder_left = {
			scenegraph_id = "banner_holder_left",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			}
		},
		banner_holder_right = {
			scenegraph_id = "banner_holder_right",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			}
		}
	}
}
local animation_sequence = {
	{
		start_progress = 0,
		name = "cross_entry",
		is_completed = false,
		end_progress = 0.1,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			local widget_style = widget.style
			local widget_content = widget.content
			widget_style.cross.color[1] = 0
			widget_style.sun.color[1] = 0
			widget_style.icon.color[1] = 0
			widget.style.icon_frame.color[1] = 0
			widget_style.banner_holder_left.color[1] = 0
			widget_style.banner_holder_right.color[1] = 0
			widget_style.hammer_left.color[1] = 0
			widget_style.hammer_right.color[1] = 0
			widget_style.title_text.text_color[1] = 0
			widget_content.banner_left.bar_value = 0
			widget_content.banner_right.bar_value = 0
			ui_scenegraph.top.local_position[2] = -1000
			ui_scenegraph.hammer_left.local_position[2] = -1000
			ui_scenegraph.hammer_right.local_position[2] = -1000
			ui_scenegraph.banner_holder_left.local_position[1] = -1000
			ui_scenegraph.banner_holder_right.local_position[1] = 1000
			ui_scenegraph.glow_background.size[1] = 0
			ui_scenegraph.glow_background.size[2] = 0
			widget_style.glow_background.color[1] = 0
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 7, 7, 1, 1)
			local cross_scenegraph = ui_scenegraph.cross
			local cross_definition = scenegraph_definition.cross
			local cross_default_size = cross_definition.size
			local cross_style = widget.style.cross
			cross_scenegraph.size[1] = catmullrom_value * cross_default_size[1]
			cross_scenegraph.size[2] = catmullrom_value * cross_default_size[2]
			cross_style.color[1] = local_progress * 255
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.1,
		name = "cross_pulse",
		is_completed = false,
		end_progress = 0.13,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 0.7, 1, 1, 0.7)
			local cross_scenegraph = ui_scenegraph.cross
			local cross_definition = scenegraph_definition.cross
			local cross_default_size = cross_definition.size
			cross_scenegraph.size[1] = catmullrom_value * cross_default_size[1]
			cross_scenegraph.size[2] = catmullrom_value * cross_default_size[2]
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.13,
		name = "top_entry",
		is_completed = false,
		end_progress = 0.22,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 0.7, 1, 1, 0.7)
			local style = widget.style.top
			local top_scenegraph = ui_scenegraph.top
			local top_definition = scenegraph_definition.top
			local top_default_position = top_definition.position
			top_scenegraph.local_position[2] = top_default_position[2] + (1 - local_progress) * 500
			local degree_amount = 5
			local rotation_angle = local_progress * degree_amount - degree_amount * 0.5
			local radians = math.degrees_to_radians(rotation_angle)
			style.angle = radians
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.22,
		name = "top_rotate_back",
		is_completed = false,
		end_progress = 0.23,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local style = widget.style.top
			local degree_amount = 5
			local rotation_angle = (local_progress - 1) * degree_amount
			local radians = math.degrees_to_radians(rotation_angle)
			style.angle = radians
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.18,
		name = "sun_entry",
		is_completed = false,
		end_progress = 0.22,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 9, 9, 1, 1)
			local sun_scenegraph = ui_scenegraph.sun
			local sun_definition = scenegraph_definition.sun
			local sun_default_position = sun_definition.position
			local sun_default_size = sun_definition.size
			local sun_style = widget.style.sun
			sun_scenegraph.size[1] = catmullrom_value * sun_default_size[1]
			sun_scenegraph.size[2] = catmullrom_value * sun_default_size[2]
			sun_scenegraph.local_position[2] = sun_default_position[2] - (1 - catmullrom_value) * -50
			sun_style.color[1] = local_progress * 255
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.22,
		name = "sun_pulse",
		is_completed = false,
		end_progress = 0.24,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 0, 1, 1, 0.7)
			local scenegraph = ui_scenegraph.sun
			local definition = scenegraph_definition.sun
			local default_position = definition.position
			local default_size = definition.size
			scenegraph.size[1] = catmullrom_value * default_size[1]
			scenegraph.size[2] = catmullrom_value * default_size[2]
			scenegraph.local_position[2] = default_position[2] - (1 - catmullrom_value) * -50
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.2,
		name = "hammer_left_entry",
		is_completed = false,
		end_progress = 0.3,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			widget.style.hammer_left.color[1] = 255
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 0.7, 1, 1, 0.7)
			local scenegraph = ui_scenegraph.hammer_left
			local definition = scenegraph_definition.hammer_left
			local default_position = definition.position
			local default_size = definition.size
			local style = widget.style.hammer_left
			scenegraph.local_position[1] = default_position[1] - (1 - local_progress) * 700
			scenegraph.local_position[2] = default_position[2] - (1 - local_progress) * 500
			local rotation_angle = (local_progress * 720) % 360
			local radians = math.degrees_to_radians(rotation_angle)
			style.angle = radians
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.2,
		name = "hammer_right_entry",
		is_completed = false,
		end_progress = 0.3,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			widget.style.hammer_right.color[1] = 255
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 0.7, 1, 1, 0.7)
			local scenegraph = ui_scenegraph.hammer_right
			local definition = scenegraph_definition.hammer_right
			local default_position = definition.position
			local default_size = definition.size
			local style = widget.style.hammer_right
			scenegraph.local_position[1] = default_position[1] + (1 - local_progress) * 700
			scenegraph.local_position[2] = default_position[2] - (1 - local_progress) * 500
			local rotation_angle = (local_progress * 720) % 360
			local radians = math.degrees_to_radians(-rotation_angle)
			style.angle = radians
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.3,
		name = "hammer_left_pulse",
		is_completed = false,
		end_progress = 0.4,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 0) or math.catmullrom(local_progress, -0.7, 0, 0, -0.7)
			local style = widget.style.hammer_left
			local rotation_angle = catmullrom_value * -35
			local radians = math.degrees_to_radians(rotation_angle)
			style.angle = radians
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.3,
		name = "hammer_right_pulse",
		is_completed = false,
		end_progress = 0.4,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 0) or math.catmullrom(local_progress, -0.7, 0, 0, -0.7)
			local style = widget.style.hammer_right
			local rotation_angle = catmullrom_value * 35
			local radians = math.degrees_to_radians(rotation_angle)
			style.angle = radians
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.63,
		name = "banner_holder_left_entry",
		is_completed = false,
		end_progress = 0.7,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			widget.style.banner_holder_left.color[1] = 255
			local catmullrom_value = (local_progress == 1 and 0) or math.catmullrom(local_progress, 5, 1, 0, 2)
			local scenegraph = ui_scenegraph.banner_holder_left
			local definition = scenegraph_definition.banner_holder_left
			local default_position = definition.position
			local default_size = definition.size
			scenegraph.local_position[1] = default_position[1] + catmullrom_value * default_size[1]
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.63,
		name = "banner_holder_right_entry",
		is_completed = false,
		end_progress = 0.7,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			widget.style.banner_holder_right.color[1] = 255
			local catmullrom_value = (local_progress == 1 and 0) or math.catmullrom(local_progress, 5, 1, 0, 2)
			local scenegraph = ui_scenegraph.banner_holder_right
			local definition = scenegraph_definition.banner_holder_right
			local default_position = definition.position
			local default_size = definition.size
			scenegraph.local_position[1] = default_position[1] - catmullrom_value * default_size[1]
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.6,
		name = "final_hammer_left_pulse",
		is_completed = false,
		end_progress = 0.63,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 0) or math.catmullrom(local_progress, -0.7, 0, 0, -0.7)
			local style = widget.style.hammer_left
			local rotation_angle = catmullrom_value * 35
			local radians = math.degrees_to_radians(rotation_angle)
			style.angle = radians
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.6,
		name = "final_hammer_right_pulse",
		is_completed = false,
		end_progress = 0.63,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 0) or math.catmullrom(local_progress, -0.7, 0, 0, -0.7)
			local style = widget.style.hammer_right
			local rotation_angle = catmullrom_value * -35
			local radians = math.degrees_to_radians(rotation_angle)
			style.angle = radians
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.75,
		name = "banner_left_entry",
		is_completed = false,
		end_progress = 0.98,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, -10, 0, 1, 0)
			local content = widget.content.banner_left
			content.bar_value = catmullrom_value
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.7,
		name = "banner_right_entry",
		is_completed = false,
		end_progress = 0.75,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, -10, 0, 1, 0)
			local content = widget.content.banner_right
			content.bar_value = catmullrom_value
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.58,
		name = "icon_entry",
		is_completed = false,
		end_progress = 0.62,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 10, 3, 1, 1)
			local style = widget.style.icon
			local definition = scenegraph_definition.icon
			local scenegraph = ui_scenegraph.icon
			scenegraph.size[1] = catmullrom_value * definition.size[1]
			scenegraph.size[2] = catmullrom_value * definition.size[2]
			style.color[1] = local_progress * 255
			widget.style.icon_frame.color[1] = style.color[1]
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.6,
		name = "text_entry",
		is_completed = false,
		end_progress = 0.61,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 15, 9, 1, 1)
			local style = widget.style.title_text
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.6,
		name = "final_pulse",
		is_completed = false,
		end_progress = 0.63,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local catmullrom_value = (local_progress == 1 and 1) or math.catmullrom(local_progress, 1.7, 1, 1, 1.7)
			local widget_scenegraph_top = ui_scenegraph.top
			local widget_definition_top = scenegraph_definition.top
			local top_default_size = widget_definition_top.size
			local top_default_position = widget_definition_top.position
			local widget_scenegraph_sun = ui_scenegraph.sun
			local widget_definition_sun = scenegraph_definition.sun
			local sun_default_size = widget_definition_sun.size
			local sun_default_position = widget_definition_sun.position
			local widget_scenegraph_cross = ui_scenegraph.cross
			local widget_definition_cross = scenegraph_definition.cross
			local cross_default_size = widget_definition_cross.size
			widget_scenegraph_cross.size[1] = catmullrom_value * cross_default_size[1]
			widget_scenegraph_cross.size[2] = catmullrom_value * cross_default_size[2]
			local cross_half_height_diff = (cross_default_size[2] - widget_scenegraph_cross.size[2]) * 0.5
			widget_scenegraph_top.size[1] = catmullrom_value * top_default_size[1]
			widget_scenegraph_top.size[2] = catmullrom_value * top_default_size[2]
			local top_half_height_diff = (top_default_size[2] - widget_scenegraph_top.size[2]) * 0.5
			widget_scenegraph_top.local_position[2] = top_default_position[2] - (cross_half_height_diff + top_half_height_diff)
			widget_scenegraph_sun.size[1] = catmullrom_value * sun_default_size[1]
			widget_scenegraph_sun.size[2] = catmullrom_value * sun_default_size[2]
			widget_scenegraph_sun.local_position[2] = sun_default_position[2] + cross_half_height_diff
		end,
		on_complete = function ()
			return
		end
	},
	{
		start_progress = 0.63,
		name = "glow_background",
		is_completed = false,
		end_progress = 0.68,
		init = function (ui_scenegraph, scenegraph_definition, widget)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, local_progress)
			local widget_scenegraph_glow_background = ui_scenegraph.glow_background
			local widget_definition_glow_background = scenegraph_definition.glow_background
			local glow_background_default_size = widget_definition_glow_background.size
			local fraction = math.easeOutCubic(local_progress)
			local style = widget.style.glow_background
			style.color[1] = 150 * fraction
			widget_scenegraph_glow_background.size[1] = fraction * glow_background_default_size[1]
			widget_scenegraph_glow_background.size[2] = fraction * glow_background_default_size[2]
		end,
		on_complete = function ()
			return
		end
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	animation_sequence = animation_sequence,
	widgets = widgets,
	widget_popup = widget_popup
}
