local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.end_screen + 2
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
	menu_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			0
		}
	},
	reward_window = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			25
		},
		size = {
			1308,
			464
		}
	},
	reward_window_bg = {
		vertical_alignment = "center",
		parent = "reward_window",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			592,
			212
		}
	},
	reward_window_left = {
		vertical_alignment = "center",
		parent = "reward_window_bg",
		horizontal_alignment = "left",
		position = {
			-308,
			-65,
			2
		},
		size = {
			358,
			464
		}
	},
	reward_window_right = {
		vertical_alignment = "center",
		parent = "reward_window_bg",
		horizontal_alignment = "right",
		position = {
			295,
			79,
			1
		},
		size = {
			358,
			464
		}
	},
	reward_window_highlight_glow = {
		vertical_alignment = "center",
		parent = "reward_window_bg",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			5
		},
		size = {
			1018,
			600
		}
	},
	reward_window_glow_bg = {
		vertical_alignment = "center",
		parent = "reward_window_bg",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			3
		},
		size = {
			592,
			600
		}
	},
	reward_window_glow_left = {
		vertical_alignment = "center",
		parent = "reward_window_bg",
		horizontal_alignment = "left",
		position = {
			-214,
			0,
			4
		},
		size = {
			214,
			600
		}
	},
	reward_window_glow_right = {
		vertical_alignment = "center",
		parent = "reward_window_bg",
		horizontal_alignment = "right",
		position = {
			214,
			0,
			4
		},
		size = {
			214,
			600
		}
	},
	reward_window_icon = {
		vertical_alignment = "center",
		parent = "reward_window_bg",
		horizontal_alignment = "center",
		position = {
			0,
			5,
			2
		},
		size = {
			256,
			64
		}
	},
	reward_window_icon_bg = {
		vertical_alignment = "center",
		parent = "reward_window_bg",
		horizontal_alignment = "center",
		position = {
			0,
			10,
			1
		},
		size = {
			149,
			158
		}
	},
	reward_window_title_text = {
		vertical_alignment = "top",
		parent = "reward_window_bg",
		horizontal_alignment = "center",
		position = {
			0,
			-15,
			3
		},
		size = {
			438,
			60
		}
	},
	reward_window_description_text = {
		vertical_alignment = "bottom",
		parent = "reward_window_bg",
		horizontal_alignment = "center",
		position = {
			0,
			17,
			3
		},
		size = {
			300,
			60
		}
	},
	summary_window = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			-10,
			3
		},
		size = {
			712,
			898
		}
	},
	summary_background = {
		vertical_alignment = "top",
		parent = "summary_window",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			712,
			898
		}
	},
	summary_entries_root = {
		vertical_alignment = "top",
		parent = "summary_background",
		horizontal_alignment = "center",
		position = {
			0,
			-225,
			1
		},
		size = {
			1,
			1
		}
	},
	summary_entries_top_mask = {
		vertical_alignment = "top",
		parent = "summary_entries_root",
		horizontal_alignment = "center",
		position = {
			0,
			10,
			1
		},
		size = {
			522,
			15
		}
	},
	summary_entries_mask = {
		vertical_alignment = "top",
		parent = "summary_entries_top_mask",
		horizontal_alignment = "center",
		position = {
			0,
			-15,
			1
		},
		size = {
			522,
			330
		}
	},
	summary_line_break = {
		vertical_alignment = "center",
		parent = "summary_background",
		horizontal_alignment = "center",
		position = {
			0,
			-106,
			1
		},
		size = {
			386,
			22
		}
	},
	summary_window_title_text = {
		vertical_alignment = "top",
		parent = "summary_window",
		horizontal_alignment = "center",
		position = {
			0,
			-55,
			1
		},
		size = {
			280,
			40
		}
	},
	summary_window_entry_title_text = {
		vertical_alignment = "top",
		parent = "summary_window",
		position = {
			95,
			-175,
			1
		},
		size = {
			250,
			40
		}
	},
	summary_window_experience_title_text = {
		vertical_alignment = "top",
		parent = "summary_window",
		horizontal_alignment = "right",
		position = {
			-95,
			-175,
			1
		},
		size = {
			200,
			40
		}
	},
	summary_window_dice_text = {
		vertical_alignment = "bottom",
		parent = "summary_window",
		position = {
			95,
			295,
			1
		},
		size = {
			200,
			40
		}
	},
	summary_window_total_experience_title_text = {
		vertical_alignment = "bottom",
		parent = "summary_window",
		horizontal_alignment = "right",
		position = {
			-95,
			295,
			1
		},
		size = {
			200,
			40
		}
	},
	summary_window_total_experience_text = {
		vertical_alignment = "bottom",
		parent = "summary_window",
		horizontal_alignment = "right",
		position = {
			-95,
			260,
			1
		},
		size = {
			200,
			40
		}
	},
	experience_bars_window = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			40,
			1
		},
		size = {
			1042,
			202
		}
	},
	experience_bars_window_background = {
		vertical_alignment = "center",
		parent = "experience_bars_window",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			2
		},
		size = {
			1042,
			202
		}
	},
	experience_window_statue_1 = {
		vertical_alignment = "top",
		parent = "experience_bars_window",
		horizontal_alignment = "left",
		position = {
			85,
			223,
			1
		},
		size = {
			72,
			238
		}
	},
	experience_window_statue_2 = {
		vertical_alignment = "top",
		parent = "experience_bars_window",
		horizontal_alignment = "right",
		position = {
			-85,
			225,
			1
		},
		size = {
			72,
			238
		}
	},
	experience_bar_background_hero = {
		vertical_alignment = "center",
		parent = "experience_bars_window",
		horizontal_alignment = "center",
		position = {
			32,
			-13,
			2
		},
		size = {
			814,
			28
		}
	},
	experience_bar_fill_hero = {
		vertical_alignment = "center",
		parent = "experience_bar_background_hero",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			814,
			28
		}
	},
	experience_bar_hero_level_box = {
		vertical_alignment = "center",
		parent = "experience_bar_background_hero",
		horizontal_alignment = "left",
		position = {
			-65,
			0,
			2
		},
		size = {
			64,
			38
		}
	},
	experience_bar_hero_level_text = {
		vertical_alignment = "top",
		parent = "experience_bar_hero_level_box",
		position = {
			0,
			0,
			2
		},
		size = {
			64,
			38
		}
	},
	experience_bar_hero_title_text = {
		vertical_alignment = "top",
		parent = "experience_bar_background_hero",
		position = {
			5,
			35,
			2
		},
		size = {
			500,
			30
		}
	},
	experience_bar_hero_experience_text = {
		vertical_alignment = "center",
		parent = "experience_bar_background_hero",
		horizontal_alignment = "right",
		position = {
			-8,
			-2,
			2
		},
		size = {
			150,
			30
		}
	},
	experience_bar_background_prestige = {
		vertical_alignment = "center",
		parent = "experience_bars_window",
		horizontal_alignment = "center",
		position = {
			-35,
			-33,
			2
		},
		size = {
			814,
			28
		}
	},
	experience_bar_fill_prestige = {
		vertical_alignment = "center",
		parent = "experience_bars_window",
		horizontal_alignment = "center",
		position = {
			-35,
			-33,
			2
		},
		size = {
			814,
			28
		}
	},
	experience_bar_prestige_level_box = {
		vertical_alignment = "center",
		parent = "experience_bar_background_prestige",
		horizontal_alignment = "right",
		position = {
			68,
			0,
			2
		},
		size = {
			64,
			38
		}
	},
	experience_bar_prestige_level_text = {
		vertical_alignment = "top",
		parent = "experience_bar_prestige_level_box",
		position = {
			0,
			0,
			2
		},
		size = {
			64,
			38
		}
	},
	experience_bar_prestige_title_text = {
		vertical_alignment = "top",
		parent = "experience_bar_background_prestige",
		position = {
			5,
			35,
			2
		},
		size = {
			300,
			30
		}
	},
	experience_bar_prestige_experience_text = {
		vertical_alignment = "center",
		parent = "experience_bar_background_prestige",
		horizontal_alignment = "right",
		position = {
			-8,
			-2,
			2
		},
		size = {
			150,
			30
		}
	}
}
local widget_definitions = {
	summary_entries_top_mask_widget = UIWidgets.create_simple_texture("mask_rect_edge_fade", "summary_entries_top_mask"),
	summary_entries_mask_widget = UIWidgets.create_simple_texture("mask_rect", "summary_entries_mask"),
	summary_window = {
		scenegraph_id = "summary_window",
		element = {
			passes = {
				{
					texture_id = "background_texture",
					style_id = "background",
					pass_type = "texture"
				},
				{
					texture_id = "line_break_texture",
					style_id = "line_break",
					pass_type = "texture"
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "entry_title_text",
					pass_type = "text",
					text_id = "entry_title_text"
				},
				{
					style_id = "experience_title_text",
					pass_type = "text",
					text_id = "experience_title_text"
				},
				{
					style_id = "dice_text",
					pass_type = "text",
					text_id = "dice_text"
				},
				{
					style_id = "total_experience_title_text",
					pass_type = "text",
					text_id = "total_experience_title_text"
				},
				{
					style_id = "total_experience_text",
					pass_type = "text",
					text_id = "total_experience_text"
				}
			}
		},
		content = {
			total_experience_text = "",
			title_text = "dlc1_2_summary_screen_main_title",
			background_texture = "summary_window",
			dice_text = "dlc1_2_summary_screen_bonus_title",
			line_break_texture = "summary_screen_line_breaker",
			experience_title_text = "dlc1_2_summary_screen_entry_reward_title",
			entry_title_text = "dlc1_2_summary_screen_entry_title",
			total_experience_title_text = "dlc1_2_summary_screen_total_exp_title"
		},
		style = {
			background = {
				scenegraph_id = "summary_background"
			},
			line_break = {
				scenegraph_id = "summary_line_break"
			},
			title_text = {
				word_wrap = true,
				scenegraph_id = "summary_window_title_text",
				localize = true,
				horizontal_alignment = "center",
				font_type = "hell_shark_header",
				font_size = 36,
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					1,
					1
				}
			},
			entry_title_text = {
				word_wrap = true,
				scenegraph_id = "summary_window_entry_title_text",
				localize = true,
				font_size = 24,
				font_type = "hell_shark",
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					0,
					1
				}
			},
			experience_title_text = {
				word_wrap = true,
				scenegraph_id = "summary_window_experience_title_text",
				localize = true,
				horizontal_alignment = "right",
				font_type = "hell_shark",
				font_size = 24,
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					0,
					1
				}
			},
			dice_text = {
				word_wrap = true,
				scenegraph_id = "summary_window_dice_text",
				localize = true,
				font_size = 24,
				font_type = "hell_shark",
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					0,
					1
				}
			},
			total_experience_title_text = {
				word_wrap = true,
				scenegraph_id = "summary_window_total_experience_title_text",
				localize = true,
				horizontal_alignment = "right",
				font_type = "hell_shark",
				font_size = 24,
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					0,
					1
				}
			},
			total_experience_text = {
				word_wrap = true,
				scenegraph_id = "summary_window_total_experience_text",
				horizontal_alignment = "right",
				font_size = 24,
				font_type = "hell_shark",
				text_color = Colors.color_definitions.white,
				offset = {
					0,
					0,
					1
				}
			}
		}
	},
	experience_bars_window = {
		scenegraph_id = "experience_bars_window",
		element = {
			passes = {
				{
					texture_id = "background_texture",
					style_id = "background",
					pass_type = "texture"
				},
				{
					texture_id = "statue_1_texture",
					style_id = "statue_1",
					pass_type = "texture"
				},
				{
					texture_id = "statue_2_texture",
					style_id = "statue_2",
					pass_type = "texture"
				}
			}
		},
		content = {
			statue_2_texture = "summary_screen_statue_02",
			statue_1_texture = "summary_screen_statue_01",
			background_texture = "progression_window"
		},
		style = {
			background = {
				scenegraph_id = "experience_bars_window_background"
			},
			statue_1 = {
				scenegraph_id = "experience_window_statue_1"
			},
			statue_2 = {
				scenegraph_id = "experience_window_statue_2"
			}
		}
	},
	experience_bar_hero = {
		scenegraph_id = "experience_bar_background_hero",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "background",
					texture_id = "background"
				},
				{
					pass_type = "texture",
					style_id = "foreground",
					texture_id = "foreground"
				},
				{
					pass_type = "texture",
					style_id = "level_box_fg",
					texture_id = "level_box_fg"
				},
				{
					pass_type = "texture",
					style_id = "level_box_bg",
					texture_id = "level_box_bg"
				},
				{
					pass_type = "texture",
					style_id = "level_box_bg_lit",
					texture_id = "level_box_bg_lit"
				},
				{
					pass_type = "texture_uv_dynamic_size_uvs",
					style_id = "bar",
					texture_id = "bar",
					dynamic_function = function (content, size, style, dt)
						local bar_value = content.bar_value
						local uvs = content.uvs
						local uv_pixels = style.size[1]*bar_value
						uvs[2][1] = bar_value
						size[1] = uv_pixels

						return uvs, size
					end
				},
				{
					style_id = "level_text",
					pass_type = "text",
					text_id = "level_text"
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "experience_text",
					pass_type = "text",
					text_id = "experience_text"
				},
				{
					pass_type = "texture",
					style_id = "bar_glow",
					texture_id = "bar_glow",
					content_check_function = function (content)
						return content.bar_glow
					end
				}
			}
		},
		content = {
			bar = "summary_screen_experience_bar",
			title_text = "summary_screen_hero_title",
			level_text = "1",
			level_box_bg = "lvl_box_bg_02",
			bar_glow = "glow_effect_01",
			foreground = "exp_bar_01_fg",
			level_box_fg = "lvl_box_fg",
			level_box_bg_lit = "lvl_box_bg_02_lit",
			experience_text = "",
			background = "exp_bar_01_bg",
			bar_value = 0,
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
			bar_glow = {
				offset = {
					0,
					6,
					2
				},
				size = {
					8,
					16
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			foreground = {
				offset = {
					0,
					0,
					3
				}
			},
			bar = {
				scenegraph_id = "experience_bar_fill_hero",
				size = {
					814,
					28
				}
			},
			level_box_fg = {
				scenegraph_id = "experience_bar_hero_level_box",
				offset = {
					0,
					0,
					2
				}
			},
			level_box_bg = {
				scenegraph_id = "experience_bar_hero_level_box"
			},
			level_box_bg_lit = {
				scenegraph_id = "experience_bar_hero_level_box",
				color = {
					0,
					255,
					255,
					255
				}
			},
			level_text = {
				vertical_alignment = "center",
				scenegraph_id = "experience_bar_hero_level_text",
				horizontal_alignment = "center",
				font_type = "hell_shark",
				font_size = 24,
				text_color = Colors.color_definitions.white,
				offset = {
					0,
					-2,
					1
				}
			},
			title_text = {
				scenegraph_id = "experience_bar_hero_title_text",
				localize = true,
				font_size = 16,
				font_type = "hell_shark",
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					-1,
					1
				}
			},
			experience_text = {
				vertical_alignment = "center",
				scenegraph_id = "experience_bar_hero_experience_text",
				horizontal_alignment = "right",
				word_wrap = true,
				font_size = 12,
				font_type = "hell_shark",
				text_color = Colors.color_definitions.white,
				offset = {
					-2,
					3,
					1
				}
			}
		}
	},
	experience_bar_prestige = {
		scenegraph_id = "experience_bar_background_prestige",
		element = {
			passes = {
				{
					pass_type = "texture",
					texture_id = "background"
				},
				{
					pass_type = "texture",
					style_id = "foreground",
					texture_id = "foreground"
				},
				{
					pass_type = "texture",
					style_id = "level_box_fg",
					texture_id = "level_box_fg"
				},
				{
					pass_type = "texture",
					style_id = "level_box_bg",
					texture_id = "level_box_bg"
				},
				{
					pass_type = "texture",
					style_id = "level_box_bg_lit",
					texture_id = "level_box_bg_lit"
				},
				{
					pass_type = "texture",
					style_id = "bar_glow",
					texture_id = "bar_glow",
					content_check_function = function (content)
						return content.bar_glow
					end
				},
				{
					pass_type = "texture_uv_dynamic_size_uvs",
					style_id = "bar",
					texture_id = "bar",
					dynamic_function = function (content, size, style, dt)
						local bar_value = content.bar_value
						local uvs = content.uvs
						local uv_pixels = style.size[1]*bar_value
						uvs[2][1] = bar_value
						size[1] = uv_pixels

						return uvs, size
					end
				},
				{
					style_id = "level_text",
					pass_type = "text",
					text_id = "level_text"
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "experience_text",
					pass_type = "text",
					text_id = "experience_text"
				}
			}
		},
		content = {
			bar = "exp_bar_02_progression",
			title_text = "summary_screen_prestige_title",
			level_text = "1",
			level_box_bg = "lvl_box_bg_01",
			background = "exp_bar_02_bg",
			foreground = "exp_bar_02_fg",
			level_box_fg = "lvl_box_fg",
			level_box_bg_lit = "lvl_box_bg_01_lit",
			experience_text = "",
			bar_glow = "glow_effect_01",
			bar_value = 0,
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
			bar_glow = {
				offset = {
					0,
					6,
					2
				},
				size = {
					8,
					16
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			foreground = {
				offset = {
					0,
					0,
					3
				}
			},
			bar = {
				scenegraph_id = "experience_bar_fill_prestige",
				offset = {
					0,
					0,
					1
				},
				size = {
					814,
					28
				}
			},
			level_box_fg = {
				scenegraph_id = "experience_bar_prestige_level_box",
				offset = {
					0,
					0,
					2
				}
			},
			level_box_bg = {
				scenegraph_id = "experience_bar_prestige_level_box"
			},
			level_box_bg_lit = {
				scenegraph_id = "experience_bar_prestige_level_box",
				color = {
					0,
					255,
					255,
					255
				}
			},
			level_text = {
				vertical_alignment = "center",
				scenegraph_id = "experience_bar_prestige_level_text",
				horizontal_alignment = "center",
				font_type = "hell_shark",
				font_size = 24,
				text_color = Colors.color_definitions.white,
				offset = {
					0,
					1,
					1
				}
			},
			title_text = {
				scenegraph_id = "experience_bar_prestige_title_text",
				localize = true,
				font_size = 16,
				font_type = "hell_shark",
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					-1,
					1
				}
			},
			experience_text = {
				vertical_alignment = "center",
				scenegraph_id = "experience_bar_prestige_experience_text",
				horizontal_alignment = "right",
				word_wrap = true,
				font_size = 12,
				font_type = "hell_shark",
				text_color = Colors.color_definitions.white,
				offset = {
					0,
					1,
					1
				}
			}
		}
	},
	reward_widget = {
		scenegraph_id = "reward_window",
		element = {
			passes = {
				{
					style_id = "background",
					pass_type = "texture_uv_dynamic_color_uvs_size_offset",
					content_id = "background",
					dynamic_function = function (content, style, size, dt)
						local fraction = content.fraction
						local color = style.color
						local uv_start_pixels = style.uv_start_pixels
						local uv_scale_pixels = style.uv_scale_pixels
						local uv_pixels = uv_start_pixels + uv_scale_pixels*fraction
						local uvs = style.uvs
						local uv_scale_axis = style.scale_axis
						local uv_diff = uv_pixels/(uv_start_pixels + uv_scale_pixels)
						local side_scale = (uv_diff - 1)*0.5
						uvs[1][uv_scale_axis] = side_scale
						uvs[2][uv_scale_axis] = side_scale - 1

						return style.color, uvs, size, style.offset
					end
				},
				{
					style_id = "glow_middle",
					pass_type = "texture_uv_dynamic_color_uvs_size_offset",
					content_id = "glow_middle",
					dynamic_function = function (content, style, size, dt)
						local fraction = content.fraction
						local color = style.color
						local uv_start_pixels = style.uv_start_pixels
						local uv_scale_pixels = style.uv_scale_pixels
						local uv_pixels = uv_start_pixels + uv_scale_pixels*fraction
						local uvs = style.uvs
						local uv_scale_axis = style.scale_axis
						local uv_diff = uv_pixels/(uv_start_pixels + uv_scale_pixels)
						local side_scale = (uv_diff - 1)*0.5
						uvs[1][uv_scale_axis] = side_scale
						uvs[2][uv_scale_axis] = side_scale - 1

						return style.color, uvs, size, style.offset
					end
				},
				{
					pass_type = "texture",
					style_id = "glow_left",
					texture_id = "glow_left",
					content_check_function = function (content)
						return 0 < content.glow_middle.fraction
					end
				},
				{
					pass_type = "texture",
					style_id = "glow_right",
					texture_id = "glow_right",
					content_check_function = function (content)
						return 0 < content.glow_middle.fraction
					end
				},
				{
					pass_type = "texture",
					style_id = "sun_left",
					texture_id = "sun_left"
				},
				{
					pass_type = "texture",
					style_id = "sun_right",
					texture_id = "sun_right"
				},
				{
					texture_id = "icon",
					style_id = "icon",
					pass_type = "texture"
				},
				{
					style_id = "icon_text",
					pass_type = "text",
					text_id = "icon_text"
				},
				{
					texture_id = "icon_bg",
					style_id = "icon_bg",
					pass_type = "texture"
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "description_text",
					pass_type = "text",
					text_id = "description_text"
				},
				{
					pass_type = "texture",
					style_id = "highlight_glow",
					texture_id = "highlight_glow"
				}
			}
		},
		content = {
			title_text = "reward_popup_title",
			sun_left = "unlock_window_part_01",
			highlight_glow = "unlock_window_glow_2",
			icon_bg = "level_location_selected",
			sun_right = "unlock_window_part_02",
			glow_left = "unlock_window_glow_left",
			glow_right = "unlock_window_glow_right",
			icon_text = "",
			icon = "class_icon_witch_hunter",
			description_text = "description_text",
			background = {
				texture_id = "unlock_window_bg",
				fraction = 0
			},
			glow_middle = {
				texture_id = "unlock_window_glow_middle",
				fraction = 0
			}
		},
		style = {
			background = {
				uv_start_pixels = 0,
				scenegraph_id = "reward_window_bg",
				uv_scale_pixels = 592,
				offset_scale = 1,
				scale_axis = 1,
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
			glow_middle = {
				uv_start_pixels = 0,
				scenegraph_id = "reward_window_glow_bg",
				uv_scale_pixels = 592,
				offset_scale = 1,
				scale_axis = 1,
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
			highlight_glow = {
				scenegraph_id = "reward_window_highlight_glow",
				color = {
					0,
					255,
					255,
					255
				}
			},
			glow_left = {
				scenegraph_id = "reward_window_glow_left",
				color = {
					255,
					255,
					255,
					255
				}
			},
			glow_right = {
				scenegraph_id = "reward_window_glow_right",
				color = {
					255,
					255,
					255,
					255
				}
			},
			sun_left = {
				scenegraph_id = "reward_window_left",
				color = {
					255,
					255,
					255,
					255
				}
			},
			sun_right = {
				scenegraph_id = "reward_window_right",
				color = {
					255,
					255,
					255,
					255
				}
			},
			icon_bg = {
				scenegraph_id = "reward_window_icon_bg",
				color = {
					0,
					255,
					255,
					255
				}
			},
			icon = {
				scenegraph_id = "reward_window_icon",
				color = {
					0,
					255,
					255,
					255
				}
			},
			icon_text = {
				vertical_alignment = "bottom",
				scenegraph_id = "reward_window_icon",
				horizontal_alignment = "right",
				font_size = 20,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					1
				}
			},
			title_text = {
				scenegraph_id = "reward_window_title_text",
				localize = false,
				font_size = 32,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					1
				}
			},
			description_text = {
				vertical_alignment = "bottom",
				scenegraph_id = "reward_window_description_text",
				horizontal_alignment = "center",
				font_size = 24,
				word_wrap = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					1
				}
			}
		}
	}
}

local function create_bonus_entries(num_of_dices)
	local dices = {}

	for i = 1, num_of_dices, 1 do
		local scenegraph_id = string.format("%s%d%s", "summary_bonus_", i, "_id")
		local scenegraph_icon_id = string.format("%s%d%s", "summary_bonus_icon_", i, "_id")
		local scenegraph_value_text_id = string.format("%s%d%s", "summary_bonus_value_", i, "_id")
		local parent_scenegraph_id = nil

		if 1 < i then
			parent_scenegraph_id = string.format("%s%d%s", "summary_bonus_", i - 1, "_id")
		else
			parent_scenegraph_id = "summary_window_dice_text"
		end

		local widget_position = (i == 1 and {
			0,
			-25,
			1
		}) or (i ~= 6 and {
			64,
			0,
			1
		}) or {
			-256,
			-45,
			1
		}

		if not scenegraph_definition[scenegraph_id] then
			scenegraph_definition[scenegraph_id] = {
				vertical_alignment = "bottom",
				parent = parent_scenegraph_id,
				position = widget_position,
				size = {
					1,
					1
				}
			}
		end

		if not scenegraph_definition[scenegraph_icon_id] then
			scenegraph_definition[scenegraph_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				parent = scenegraph_id,
				position = {
					0,
					0,
					1
				},
				size = {
					42,
					42
				}
			}
		end

		if not scenegraph_definition[scenegraph_value_text_id] then
			scenegraph_definition[scenegraph_value_text_id] = {
				vertical_alignment = "bottom",
				horizontal_alignment = "right",
				parent = scenegraph_icon_id,
				position = {
					-5,
					5,
					1
				},
				size = {
					0,
					0
				}
			}
		end

		local widget_definition = {
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "icon_texture",
						texture_id = "icon_texture"
					},
					{
						style_id = "value_text",
						pass_type = "text",
						text_id = "value_text"
					}
				}
			},
			content = {
				value = 0,
				icon_texture = "",
				value_text = ""
			},
			style = {
				icon_texture = {
					scenegraph_id = scenegraph_icon_id
				},
				value_text = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 20,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					scenegraph_id = scenegraph_value_text_id
				}
			},
			scenegraph_id = scenegraph_id
		}
		dices[#dices + 1] = widget_definition
	end

	return dices
end

local function create_summary_entry(num_of_entries)
	local summary_widgets = {}

	for i = 1, num_of_entries, 1 do
		local scenegraph_id = string.format("%s%d%s", "summary_widget_", i, "_id")
		local scenegraph_title_id = string.format("%s%d%s", "summary_widget_", i, "_title_id")
		local scenegraph_value_text_id = string.format("%s%d%s", "summary_widget_", i, "_value_id")
		local scenegraph_icon_id = string.format("%s%d%s", "summary_widget_", i, "_icon_id")
		local parent_scenegraph_id = "summary_entries_root"

		if not scenegraph_definition[scenegraph_id] then
			scenegraph_definition[scenegraph_id] = {
				vertical_alignment = "top",
				horizontal_alignment = "center",
				parent = parent_scenegraph_id,
				position = {
					0,
					0,
					1
				},
				size = {
					522,
					40
				}
			}
			scenegraph_definition[scenegraph_title_id] = {
				parent = scenegraph_id,
				position = {
					0,
					0,
					1
				},
				size = {
					382,
					40
				}
			}
			scenegraph_definition[scenegraph_value_text_id] = {
				horizontal_alignment = "right",
				parent = scenegraph_id,
				position = {
					0,
					0,
					1
				},
				size = {
					100,
					40
				}
			}
			scenegraph_definition[scenegraph_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				parent = scenegraph_value_text_id,
				position = {
					0,
					0,
					1
				},
				size = {
					34,
					34
				}
			}
		end

		local widget_definition = {
			element = {
				passes = {
					{
						style_id = "title_text",
						pass_type = "text",
						text_id = "title_text"
					},
					{
						style_id = "value_text",
						pass_type = "text",
						text_id = "value_text"
					},
					{
						pass_type = "texture",
						style_id = "icon_texture",
						texture_id = "icon_texture",
						content_check_function = function (content)
							return content.icon_texture
						end
					}
				}
			},
			content = {
				title_text = "",
				value_text = ""
			},
			style = {
				title_text = {
					vertical_alignment = "center",
					font_size = 24,
					font_type = "hell_shark_masked",
					text_color = Colors.get_color_table_with_alpha("white", 0),
					scenegraph_id = scenegraph_title_id
				},
				value_text = {
					vertical_alignment = "center",
					font_type = "hell_shark_masked",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("white", 0),
					scenegraph_id = scenegraph_value_text_id
				},
				icon_texture = {
					masked = true,
					offset = {
						0,
						0,
						3
					},
					color = {
						0,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_icon_id
				}
			},
			scenegraph_id = scenegraph_id
		}
		summary_widgets[#summary_widgets + 1] = widget_definition
	end

	return summary_widgets
end

local summary_widgets = create_summary_entry(7)
local bonus_widgets = create_bonus_entries(10)

return {
	scenegraph = scenegraph_definition,
	widgets = widget_definitions,
	summary_widgets = summary_widgets,
	bonus_widgets = bonus_widgets,
	hero_icons = hero_icons
}
