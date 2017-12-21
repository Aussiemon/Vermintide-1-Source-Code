local COMPACT_PREVIEW_SPACING = {
	20,
	15
}
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
			UILayer.end_screen
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
			15,
			50,
			0
		}
	},
	scoreboard_window = {
		vertical_alignment = "center",
		parent = "menu_root",
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
	scoreboard_window_title = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			-10,
			2
		},
		size = {
			420,
			30
		}
	},
	scoreboard_window_button = {
		vertical_alignment = "bottom",
		parent = "scoreboard_window",
		horizontal_alignment = "left",
		size = {
			220,
			62
		},
		position = {
			62,
			55,
			1
		}
	},
	controller_info = {
		vertical_alignment = "bottom",
		parent = "player_list_window",
		position = {
			0,
			-105,
			1
		},
		size = {
			400,
			100
		}
	},
	controller_info_navigation_icon_root = {
		vertical_alignment = "center",
		parent = "controller_info_navigation_text",
		position = {
			-45,
			0,
			2
		},
		size = {
			1,
			1
		}
	},
	controller_info_continue_icon_root = {
		vertical_alignment = "center",
		parent = "controller_info_continue_text",
		position = {
			-45,
			0,
			2
		},
		size = {
			1,
			1
		}
	},
	controller_info_navigation_text = {
		vertical_alignment = "center",
		parent = "controller_info",
		position = {
			70,
			-23,
			2
		},
		size = {
			250,
			50
		}
	},
	controller_info_continue_text = {
		vertical_alignment = "center",
		parent = "controller_info",
		position = {
			70,
			33,
			2
		},
		size = {
			250,
			50
		}
	},
	controller_info_navigation_icon = {
		vertical_alignment = "center",
		parent = "controller_info_navigation_icon_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			2
		},
		size = {
			50,
			50
		}
	},
	controller_info_continue_icon = {
		vertical_alignment = "center",
		parent = "controller_info_continue_icon_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			2
		},
		size = {
			50,
			50
		}
	},
	level_vote_texts = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "right",
		position = {
			-230,
			105,
			10
		},
		size = {
			326,
			594
		}
	},
	voting_widget_1 = {
		vertical_alignment = "top",
		parent = "level_vote_texts",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			10
		},
		size = {
			326,
			198
		}
	},
	voting_widget_2 = {
		vertical_alignment = "top",
		parent = "level_vote_texts",
		horizontal_alignment = "center",
		position = {
			0,
			-205,
			1
		},
		size = {
			326,
			198
		}
	},
	voting_widget_3 = {
		vertical_alignment = "top",
		parent = "level_vote_texts",
		horizontal_alignment = "center",
		position = {
			0,
			-410,
			1
		},
		size = {
			326,
			198
		}
	},
	level_vote_timer_prefix = {
		vertical_alignment = "top",
		parent = "level_vote_texts",
		horizontal_alignment = "left",
		position = {
			15,
			0,
			1
		},
		size = {
			326,
			41
		}
	},
	level_vote_timer = {
		vertical_alignment = "center",
		parent = "level_vote_timer_prefix",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			326,
			41
		}
	},
	player_list_window = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			-180,
			-138,
			2
		},
		size = {
			1160,
			614
		}
	},
	player_list_topic_title = {
		vertical_alignment = "top",
		parent = "player_list_window",
		horizontal_alignment = "center",
		position = {
			0,
			-5,
			3
		},
		size = {
			1160,
			56
		}
	},
	player_list_title = {
		vertical_alignment = "top",
		parent = "player_list_window",
		horizontal_alignment = "center",
		position = {
			0,
			-50,
			3
		},
		size = {
			1160,
			56
		}
	},
	topic_root = {
		vertical_alignment = "bottom",
		parent = "player_list_window",
		horizontal_alignment = "center",
		position = {
			-COMPACT_PREVIEW_SPACING[1],
			-250,
			1
		},
		size = {
			COMPACT_PREVIEW_SPACING[1]*3 + 912,
			260
		}
	},
	topic_mask = {
		vertical_alignment = "center",
		parent = "topic_root",
		horizontal_alignment = "center",
		position = {
			COMPACT_PREVIEW_SPACING[1],
			0,
			1
		},
		size = {
			COMPACT_PREVIEW_SPACING[1]*3 + 912,
			260
		}
	},
	topic_widget_root = {
		vertical_alignment = "center",
		parent = "topic_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			COMPACT_PREVIEW_SPACING[1]*3 + 912,
			260
		}
	},
	topic_dummy_root = {
		vertical_alignment = "center",
		parent = "topic_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			COMPACT_PREVIEW_SPACING[1]*3 + 912,
			260
		}
	},
	topic_arrow_button_left = {
		vertical_alignment = "center",
		parent = "topic_root",
		horizontal_alignment = "left",
		position = {
			COMPACT_PREVIEW_SPACING[1] + -90,
			0,
			10
		},
		size = {
			80,
			80
		}
	},
	topic_arrow_button_left_controller = {
		vertical_alignment = "bottom",
		parent = "topic_arrow_button_left",
		horizontal_alignment = "center",
		position = {
			0,
			-50,
			1
		},
		size = {
			50,
			50
		}
	},
	topic_arrow_button_right = {
		vertical_alignment = "center",
		parent = "topic_root",
		horizontal_alignment = "right",
		position = {
			COMPACT_PREVIEW_SPACING[1] + 90,
			0,
			10
		},
		size = {
			80,
			80
		}
	},
	topic_arrow_button_right_controller = {
		vertical_alignment = "bottom",
		parent = "topic_arrow_button_right",
		horizontal_alignment = "center",
		position = {
			0,
			-50,
			1
		},
		size = {
			50,
			50
		}
	},
	topic_index_counter = {
		vertical_alignment = "bottom",
		parent = "topic_root",
		horizontal_alignment = "center",
		position = {
			COMPACT_PREVIEW_SPACING[1],
			-10,
			10
		},
		size = {
			COMPACT_PREVIEW_SPACING[1] + 716,
			14
		}
	}
}
local compact_topic_offset = {
	0,
	0,
	0
}

local function create_voting_widget(scenegraph_id)
	return {
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot",
					content_check_function = function (content)
						return not content.disabled
					end
				},
				{
					pass_type = "texture",
					texture_id = "texture_id",
					content_check_function = function (content)
						return not content.button_hotspot.is_selected and (not content.selected or not content.button_hotspot.is_hover or 0 >= content.button_hotspot.is_clicked)
					end
				},
				{
					pass_type = "texture",
					texture_id = "texture_hover_id",
					content_check_function = function (content)
						return not content.button_hotspot.is_selected and (content.selected or (content.button_hotspot.is_hover and 0 < content.button_hotspot.is_clicked))
					end
				},
				{
					texture_id = "gamepad_texture_selected_id",
					style_id = "gamepad_texture_selected_id",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.button_hotspot.is_selected and content.selected
					end
				},
				{
					pass_type = "texture",
					texture_id = "texture_click_id",
					content_check_function = function (content)
						return content.button_hotspot.is_selected
					end
				},
				{
					pass_type = "texture",
					style_id = "background_texture_id",
					texture_id = "background_texture_id"
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				},
				{
					pass_type = "multi_texture",
					style_id = "vote_marker",
					texture_id = "vote_marker",
					content_check_function = function (content)
						return 1 <= #content.vote_marker
					end
				}
			}
		},
		content = {
			gamepad_texture_selected_id = "map_setting_bg_fade_02",
			texture_hover_id = "scoreboard_level_window_hover",
			texture_click_id = "scoreboard_level_window_selected",
			texture_id = "scoreboard_level_window_normal",
			visible = true,
			background_texture_id = "level_image_red_moon_inn",
			vote_marker = {},
			text = Localize("return_to_inn"),
			button_hotspot = {}
		},
		style = {
			background_texture_id = {
				offset = {
					0,
					0,
					-1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			text = {
				font_size = 18,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					22,
					40,
					3
				},
				size = {
					294,
					24
				}
			},
			vote_marker = {
				texture_sizes = {
					{
						22,
						22
					},
					{
						22,
						22
					},
					{
						22,
						22
					},
					{
						22,
						22
					}
				},
				spacing = {
					0,
					0,
					0
				},
				offset = {
					20,
					143,
					3
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			gamepad_texture_selected_id = {
				size = {
					397,
					209
				},
				offset = {
					-35.5,
					-5.5,
					-1
				}
			}
		},
		scenegraph_id = scenegraph_id
	}
end

local widgets = {
	voting_widget_1 = create_voting_widget("voting_widget_1"),
	voting_widget_2 = create_voting_widget("voting_widget_2"),
	voting_widget_3 = create_voting_widget("voting_widget_3"),
	topic_mask = UIWidgets.create_simple_texture("mask_rect", "topic_mask"),
	background_tint = {
		scenegraph_id = "screen",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "gradient_dice_game_reward"
		},
		style = {
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
	},
	controller_info = {
		scenegraph_id = "controller_info",
		element = {
			passes = {
				{
					style_id = "navigation_text",
					pass_type = "text",
					text_id = "navigation_text"
				},
				{
					style_id = "continue_text",
					pass_type = "text",
					text_id = "continue_text"
				},
				{
					texture_id = "continue_icon",
					style_id = "continue_icon",
					pass_type = "texture"
				},
				{
					texture_id = "navigation_icon",
					style_id = "navigation_icon",
					pass_type = "texture"
				}
			}
		},
		content = {
			navigation_icon = "ps4_button_icon_r2",
			navigation_text = "scoreboard_navigation",
			continue_text = "scoreboard_continue",
			continue_icon = "ps4_button_icon_r2"
		},
		style = {
			navigation_icon = {
				scenegraph_id = "controller_info_navigation_icon",
				offset = {
					0,
					0,
					0
				}
			},
			continue_icon = {
				scenegraph_id = "controller_info_continue_icon",
				offset = {
					0,
					0,
					0
				}
			},
			navigation_text = {
				word_wrap = true,
				scenegraph_id = "controller_info_navigation_text",
				localize = true,
				font_size = 32,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			continue_text = {
				word_wrap = true,
				scenegraph_id = "controller_info_continue_text",
				localize = true,
				font_size = 32,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			}
		}
	},
	window = {
		scenegraph_id = "scoreboard_window",
		element = {
			passes = {
				{
					texture_id = "player_list_window",
					style_id = "player_list_window",
					pass_type = "texture"
				},
				{
					style_id = "player_list_topic",
					pass_type = "text",
					text_id = "player_list_topic"
				},
				{
					style_id = "player_list_title",
					pass_type = "text",
					text_id = "player_list_title"
				},
				{
					style_id = "player_list_title_hero",
					pass_type = "text",
					text_id = "player_list_title_hero"
				},
				{
					style_id = "player_list_title_score",
					pass_type = "text",
					text_id = "player_list_title_score"
				}
			}
		},
		content = {
			window_title = "scoreboard_title_text",
			player_list_topic = "",
			player_list_window = "scoreboard_window",
			player_list_title = "player_list_title_name",
			player_list_title_hero = "player_list_title_hero",
			player_list_title_score = "player_list_title_score"
		},
		style = {
			player_list_topic = {
				vertical_alignment = "center",
				scenegraph_id = "player_list_topic_title",
				localize = true,
				font_size = 36,
				font_type = "hell_shark_header",
				horizontal_alignment = "center",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					1
				}
			},
			player_list_window = {
				scenegraph_id = "player_list_window",
				offset = {
					0,
					0,
					1
				}
			},
			player_list_title = {
				scenegraph_id = "player_list_title",
				localize = true,
				font_size = 36,
				word_wrap = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					225,
					0,
					1
				}
			},
			player_list_title_hero = {
				font_size = 36,
				scenegraph_id = "player_list_title",
				localize = true,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					55,
					0,
					1
				}
			},
			player_list_title_score = {
				font_size = 36,
				scenegraph_id = "player_list_title",
				localize = true,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					840,
					0,
					1
				}
			},
			window_title = {
				font_size = 32,
				scenegraph_id = "scoreboard_window_title",
				localize = true,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark_header",
				text_color = Colors.color_definitions.cheeseburger
			}
		}
	},
	topic_arrow_button_left = {
		scenegraph_id = "topic_arrow_button_left",
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					texture_id = "texture_id",
					style_id = "normal",
					pass_type = "texture"
				},
				{
					texture_id = "texture_glow",
					style_id = "glow",
					pass_type = "texture"
				},
				{
					texture_id = "controller_icon",
					style_id = "controller_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return content.controller_active
					end
				},
				{
					texture_id = "texture_click_id",
					style_id = "selected",
					pass_type = "texture",
					content_check_function = function (content)
						return content.button_hotspot.is_clicked == 0 or content.button_hotspot.is_selected
					end
				}
			}
		},
		content = {
			texture_glow = "scoreboard_arrow_glow",
			texture_click_id = "scoreboard_arrow_left_lit",
			texture_id = "scoreboard_arrow_left_normal",
			controller_icon = "xbone_button_icon_lt",
			button_hotspot = {}
		},
		style = {
			normal = {
				color = {
					180,
					255,
					255,
					255
				},
				size = {
					206,
					204
				},
				offset = {
					-63,
					-62,
					1
				}
			},
			selected = {
				color = {
					0,
					255,
					255,
					255
				},
				size = {
					206,
					204
				},
				offset = {
					-63,
					-62,
					1
				}
			},
			glow = {
				color = {
					0,
					255,
					255,
					255
				},
				size = {
					206,
					204
				},
				offset = {
					-63,
					-62,
					0
				}
			},
			controller_icon = {
				scenegraph_id = "topic_arrow_button_left_controller",
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	topic_arrow_button_right = {
		scenegraph_id = "topic_arrow_button_right",
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					texture_id = "texture_id",
					style_id = "normal",
					pass_type = "texture"
				},
				{
					texture_id = "texture_glow",
					style_id = "glow",
					pass_type = "texture"
				},
				{
					texture_id = "controller_icon",
					style_id = "controller_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return content.controller_active
					end
				},
				{
					texture_id = "texture_click_id",
					style_id = "selected",
					pass_type = "texture",
					content_check_function = function (content)
						return content.button_hotspot.is_clicked == 0 or content.button_hotspot.is_selected
					end
				}
			}
		},
		content = {
			texture_glow = "scoreboard_arrow_glow",
			texture_click_id = "scoreboard_arrow_right_lit",
			texture_id = "scoreboard_arrow_right_normal",
			controller_icon = "button_xb1_lt",
			button_hotspot = {}
		},
		style = {
			normal = {
				color = {
					180,
					255,
					255,
					255
				},
				size = {
					206,
					204
				},
				offset = {
					-63,
					-62
				}
			},
			selected = {
				color = {
					0,
					255,
					255,
					255
				},
				size = {
					206,
					204
				},
				offset = {
					-63,
					-62
				}
			},
			glow = {
				color = {
					0,
					255,
					255,
					255
				},
				size = {
					206,
					204
				},
				offset = {
					-63,
					-62
				}
			},
			controller_icon = {
				scenegraph_id = "topic_arrow_button_right_controller",
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	topic_index_counter = {
		scenegraph_id = "topic_index_counter",
		element = {
			passes = {
				{
					style_id = "list_style",
					pass_type = "list_pass",
					content_id = "list_content",
					passes = {
						{
							pass_type = "hotspot",
							content_id = "button_hotspot",
							content_check_function = function (content)
								return not content.disabled
							end
						},
						{
							click_check_content_id = "button_hotspot",
							pass_type = "on_click",
							content_check_function = function (content)
								return not content.disabled
							end,
							click_function = function (ui_scenegraph, ui_style, ui_content, input_service)
								ui_content.button_hotspot.is_selected = true

								return 
							end
						},
						{
							pass_type = "texture",
							style_id = "background_texture_id",
							texture_id = "background_texture_id"
						},
						{
							pass_type = "texture",
							style_id = "background_click_texture_id",
							texture_id = "background_click_texture_id",
							content_check_function = function (content)
								return content.button_hotspot.is_selected
							end
						}
					}
				}
			}
		},
		content = {
			list_content = {}
		},
		style = {
			list_style = {}
		}
	},
	level_vote_texts = {
		scenegraph_id = "level_vote_texts",
		element = {
			passes = {
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "timer_prefix",
					pass_type = "text",
					text_id = "timer_prefix"
				},
				{
					style_id = "timer_text",
					pass_type = "text",
					text_id = "timer_text"
				}
			}
		},
		content = {
			title_text = "vote_for_next_level",
			timer_prefix = "time_left",
			timer_text = "timer_text"
		},
		style = {
			timer_prefix = {
				font_size = 28,
				scenegraph_id = "level_vote_timer_prefix",
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			timer_text = {
				font_size = 28,
				scenegraph_id = "level_vote_timer",
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			title_text = {
				font_size = 32,
				localize = true,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					35,
					3
				}
			}
		}
	},
	continue_button = UIWidgets.create_menu_button_medium("leave_party", "scoreboard_window_button")
}

local function create_compact_topic_widgets(number_of_elements)
	local compact_topic_widgets = {}

	for i = 1, number_of_elements, 1 do
		local scenegraph_id = "compact_preview_" .. i
		local scenegraph_internal_id = "compact_preview_internal_" .. i
		scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "center",
			parent = "topic_widget_root",
			horizontal_alignment = "center",
			position = {
				0,
				0,
				1
			},
			size = {
				COMPACT_PREVIEW_SPACING[1] + 304,
				214
			}
		}
		scenegraph_definition[scenegraph_internal_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = scenegraph_id,
			position = {
				0,
				0,
				1
			},
			size = {
				304,
				214
			}
		}
		compact_topic_widgets[#compact_topic_widgets + 1] = {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						texture_id = "texture_hover_id",
						style_id = "background_hover",
						pass_type = "texture",
						content_check_function = function (content)
							return not content.button_hotspot.disabled
						end
					},
					{
						texture_id = "texture_select_id",
						style_id = "background_select",
						pass_type = "texture",
						content_check_function = function (content)
							return not content.button_hotspot.disabled
						end
					},
					{
						style_id = "background",
						pass_type = "texture_uv_dynamic_color_uvs_size_offset",
						content_id = "background",
						dynamic_function = function (content, style, size, dt)
							local fraction = content.fraction
							local direction = content.direction
							local color = style.color
							local uv_start_pixels = style.uv_start_pixels
							local uv_scale_pixels = style.uv_scale_pixels
							local uv_pixels = uv_start_pixels + uv_scale_pixels*fraction
							local uvs = style.uvs
							local uv_scale_axis = style.scale_axis

							if direction == 1 then
								uvs[1][uv_scale_axis] = 0
								uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
								size[uv_scale_axis] = uv_pixels
								compact_topic_offset[uv_scale_axis] = 0
							else
								uvs[2][uv_scale_axis] = 1
								uvs[1][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels) - 1
								size[uv_scale_axis] = uv_pixels
								compact_topic_offset[uv_scale_axis] = -(uv_pixels - (uv_start_pixels + uv_scale_pixels))
							end

							return style.color, uvs, size, compact_topic_offset
						end
					},
					{
						style_id = "title_text",
						pass_type = "text",
						text_id = "title_text"
					},
					{
						style_id = "player_name",
						pass_type = "text",
						text_id = "player_name"
					},
					{
						style_id = "score_text",
						pass_type = "text",
						text_id = "score_text"
					}
				}
			},
			content = {
				score_text = "score_text",
				title_text = "title_text",
				player_name = "player_name",
				texture_hover_id = "scoreboard_topic_button_hover",
				texture_select_id = "scoreboard_topic_button_highlight",
				background = {
					texture_id = "scoreboard_topic_button_normal",
					direction = 1,
					fraction = 1
				},
				button_hotspot = {}
			},
			style = {
				background_hover = {
					masked = true,
					color = {
						0,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						1
					},
					scenegraph_id = scenegraph_internal_id
				},
				background_select = {
					masked = true,
					size = {
						350,
						260
					},
					color = {
						0,
						255,
						255,
						255
					},
					offset = {
						-23,
						-23,
						-1
					},
					scenegraph_id = scenegraph_internal_id
				},
				background = {
					uv_start_pixels = 0,
					uv_scale_pixels = 304,
					offset_scale = 1,
					scale_axis = 1,
					masked = true,
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
					scenegraph_id = scenegraph_internal_id
				},
				score_text = {
					font_size = 42,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark_masked",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						5,
						5
					},
					scenegraph_id = scenegraph_internal_id
				},
				title_text = {
					font_size = 32,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "top",
					dynamic_font = true,
					font_type = "hell_shark_header_masked",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						0,
						-30,
						5
					},
					scenegraph_id = scenegraph_internal_id
				},
				player_name = {
					font_size = 18,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "bottom",
					dynamic_font = true,
					font_type = "hell_shark_masked",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						50,
						5
					},
					scenegraph_id = scenegraph_internal_id
				}
			},
			scenegraph_id = scenegraph_id
		}
	end

	return compact_topic_widgets
end

local function create_detailed_preview_widget_entries(num_of_entries)
	local widgets = {}

	for i = 1, num_of_entries, 1 do
		local scenegraph_id = string.format("%s%d%s", "preview_entry_widget_", i, "_id")
		local scenegraph_title_id = string.format("%s%d%s", "preview_entry_widget_", i, "_title_id")
		local scenegraph_score_id = string.format("%s%d%s", "preview_entry_widget_", i, "_score_id")
		local scenegraph_icon_id = string.format("%s%d%s", "preview_entry_widget_", i, "_icon_id")
		local parent_scenegraph_id = nil

		if 1 < i then
			parent_scenegraph_id = string.format("%s%d%s", "preview_entry_widget_", i - 1, "_id")
		else
			parent_scenegraph_id = "player_list_window"
		end

		local widget_position = (i ~= 1 and {
			0,
			-120,
			3
		}) or {
			150,
			-130,
			3
		}

		if not scenegraph_definition[scenegraph_id] then
			scenegraph_definition[scenegraph_id] = {
				vertical_alignment = "top",
				parent = parent_scenegraph_id,
				position = widget_position,
				size = {
					926,
					46
				}
			}
			scenegraph_definition[scenegraph_title_id] = {
				vertical_alignment = "center",
				parent = scenegraph_id,
				position = {
					80,
					0,
					1
				},
				size = {
					400,
					40
				}
			}
			scenegraph_definition[scenegraph_score_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				parent = scenegraph_id,
				position = {
					700,
					0,
					1
				},
				size = {
					250,
					40
				}
			}
			scenegraph_definition[scenegraph_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				parent = scenegraph_title_id,
				position = {
					-180,
					0,
					1
				},
				size = {
					46,
					46
				}
			}
		end

		local widget_definition = {
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "icon",
						texture_id = "icon"
					},
					{
						pass_type = "texture",
						style_id = "highlight",
						texture_id = "highlight",
						content_check_function = function (content)
							return content.highlight_enabled
						end
					},
					{
						style_id = "title_text",
						pass_type = "text",
						text_id = "title_text"
					},
					{
						style_id = "score_text",
						pass_type = "text",
						text_id = "score_text",
						content_check_function = function (content)
							return content.experience_text ~= ""
						end
					}
				}
			},
			content = {
				score_text = "-",
				icon = "hero_icon_medium_bright_wizard_white",
				highlight = "scoreboard_window_highlight",
				title_text = "unknown_player"
			},
			style = {
				title_text = {
					vertical_alignment = "center",
					dynamic_font = true,
					font_size = 24,
					word_wrap = true,
					pixel_perfect = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					scenegraph_id = scenegraph_title_id
				},
				score_text = {
					font_size = 24,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "left",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					scenegraph_id = scenegraph_score_id
				},
				icon = {
					vertical_alignment = "center",
					scenegraph_id = scenegraph_icon_id,
					color = {
						255,
						255,
						255,
						255
					}
				},
				highlight = {
					size = {
						926,
						46
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
						0
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
		widgets[#widgets + 1] = widget_definition
	end

	return widgets
end

local hero_icons = {
	white = {
		witch_hunter = "hero_icon_medium_witch_hunter_white",
		empire_soldier = "hero_icon_medium_empire_soldier_white",
		dwarf_ranger = "hero_icon_medium_dwarf_ranger_white",
		test_profile = "hero_icon_medium_empire_soldier_white",
		wood_elf = "hero_icon_medium_way_watcher_white",
		bright_wizard = "hero_icon_medium_bright_wizard_white"
	},
	yellow = {
		witch_hunter = "hero_icon_medium_witch_hunter_yellow",
		empire_soldier = "hero_icon_medium_empire_soldier_yellow",
		dwarf_ranger = "hero_icon_medium_dwarf_ranger_yellow",
		test_profile = "hero_icon_medium_empire_soldier_yellow",
		wood_elf = "hero_icon_medium_way_watcher_yellow",
		bright_wizard = "hero_icon_medium_bright_wizard_yellow"
	}
}

return {
	scenegraph = scenegraph_definition,
	widgets = widgets,
	topic_widgets = create_compact_topic_widgets(6),
	player_entries = create_detailed_preview_widget_entries(4),
	COMPACT_PREVIEW_SPACING = COMPACT_PREVIEW_SPACING,
	hero_icons = hero_icons
}
