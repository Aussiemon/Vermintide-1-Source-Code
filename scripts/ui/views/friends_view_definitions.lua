local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.default + 50
		},
		size = {
			1920,
			1080
		}
	},
	fade_background = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.default + 50
		}
	},
	background = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			938,
			720
		},
		position = {
			0,
			0,
			1
		}
	},
	background_statue_left = {
		parent = "background",
		size = {
			68,
			206
		},
		position = {
			0,
			0,
			10
		}
	},
	title = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			420,
			22
		},
		position = {
			42,
			-115,
			1
		}
	},
	info_title = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "right",
		size = {
			420,
			22
		},
		position = {
			-42,
			-115,
			1
		}
	},
	friend_list_window = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			425,
			540
		},
		position = {
			40,
			-145,
			1
		}
	},
	friend_list = {
		vertical_alignment = "top",
		parent = "friend_list_window",
		horizontal_alignment = "left",
		size = {
			355,
			25
		},
		position = {
			0,
			-10,
			1
		}
	},
	friend_list_scrollbar_root = {
		vertical_alignment = "bottom",
		parent = "friend_list_window",
		horizontal_alignment = "right",
		position = {
			-2,
			0,
			10
		},
		size = {
			22,
			540
		}
	},
	friend_info_window = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			425,
			540
		},
		position = {
			472,
			-145,
			1
		}
	},
	update_friend_info_icon = {
		vertical_alignment = "center",
		parent = "friend_info_window",
		horizontal_alignment = "center",
		size = {
			50,
			50
		},
		position = {
			0,
			0,
			1
		}
	},
	friends_info_player_name_line_breaker = {
		vertical_alignment = "top",
		parent = "friend_info_window",
		horizontal_alignment = "center",
		size = {
			386,
			22
		},
		position = {
			0,
			-45,
			2
		}
	},
	level_image = {
		vertical_alignment = "top",
		parent = "friends_info_player_name_line_breaker",
		horizontal_alignment = "center",
		position = {
			0,
			-90,
			2
		},
		size = {
			300,
			170
		}
	},
	friend_info_title_text = {
		vertical_alignment = "top",
		parent = "level_image",
		horizontal_alignment = "center",
		position = {
			0,
			60,
			2
		},
		size = {
			400,
			40
		}
	},
	disable_image = {
		vertical_alignment = "center",
		parent = "friend_info_window",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			2
		},
		size = {
			378,
			378
		}
	},
	button_1 = {
		vertical_alignment = "bottom",
		parent = "friend_info_window",
		horizontal_alignment = "center",
		size = {
			188,
			50
		},
		position = {
			95,
			10,
			1
		}
	},
	button_2 = {
		vertical_alignment = "bottom",
		parent = "friend_info_window",
		horizontal_alignment = "center",
		size = {
			188,
			50
		},
		position = {
			0,
			10,
			1
		}
	},
	button_3 = {
		vertical_alignment = "bottom",
		parent = "friend_info_window",
		horizontal_alignment = "center",
		size = {
			188,
			50
		},
		position = {
			-95,
			10,
			1
		}
	},
	join_button = {
		vertical_alignment = "bottom",
		parent = "friend_info_window",
		horizontal_alignment = "center",
		size = {
			188,
			50
		},
		position = {
			95,
			10,
			1
		}
	},
	invite_button = {
		vertical_alignment = "bottom",
		parent = "friend_info_window",
		horizontal_alignment = "center",
		size = {
			188,
			50
		},
		position = {
			-95,
			10,
			1
		}
	},
	close_button = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "right",
		size = {
			35,
			35
		},
		position = {
			-7,
			-70,
			1
		}
	},
	eye_glow = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		size = {
			59,
			59
		},
		position = {
			0,
			-41,
			1
		}
	}
}
local widget_definitions = {
	scroll_field = {
		scenegraph_id = "friend_list_window",
		element = {
			passes = {
				{
					pass_type = "scroll",
					scroll_function = function (ui_scenegraph, ui_style, ui_content, input_service, scroll_axis)
						local scroll_step = ui_content.scroll_step or 0.1
						local current_scroll_value = ui_content.internal_scroll_value
						current_scroll_value = current_scroll_value + scroll_step*-scroll_axis.y
						ui_content.internal_scroll_value = math.clamp(current_scroll_value, 0, 1)

						return 
					end
				}
			}
		},
		content = {
			scroll_step = 0.05,
			internal_scroll_value = 0
		}
	},
	fade_background = {
		scenegraph_id = "fade_background",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "gradient_friend_list"
		},
		style = {
			color = {
				255,
				255,
				255,
				255
			}
		}
	},
	background = {
		scenegraph_id = "background",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "friends_list_bg"
		},
		style = {
			color = {
				255,
				255,
				255,
				255
			}
		}
	},
	background_statue_left = UIWidgets.create_simple_uv_texture("friends_list_bg_statue", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "background_statue_left"),
	title = {
		scenegraph_id = "title",
		element = UIElements.StaticText,
		content = {
			text_field = "friend_list_friends"
		},
		style = {
			text = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				localize = true,
				font_size = 28,
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	info_title = {
		scenegraph_id = "info_title",
		element = UIElements.StaticText,
		content = {
			text_field = "friend_list_info_title"
		},
		style = {
			text = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				localize = true,
				font_size = 28,
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					2
				}
			}
		}
	}
}
local button_widgets = {
	close_button = {
		scenegraph_id = "close_button",
		element = UIElements.Simple3StatesButton,
		content = {
			texture_hover_id = "back_button_hover",
			texture_click_id = "back_button_clicked",
			texture_id = "back_button_normal",
			button_hotspot = {}
		},
		style = {}
	},
	join_button = UIWidgets.create_menu_button_medium("friend_list_join", "join_button"),
	invite_button = UIWidgets.create_menu_button_medium("friend_list_invite", "invite_button")
}
local friend_list_definition = {
	scenegraph_id = "friend_list",
	element = {
		passes = {
			{
				style_id = "list_style",
				pass_type = "list_pass",
				content_id = "list_content",
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "controller_hotspot",
						content_id = "controller_button_hotspot"
					},
					{
						style_id = "name",
						pass_type = "text",
						text_id = "name"
					},
					{
						pass_type = "texture",
						style_id = "hover_texture",
						texture_id = "hover_texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (button_hotspot.gamepad_active and content.selected) or button_hotspot.is_hover or content.controller_button_hotspot.is_hover
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
		list_style = {
			start_index = 1,
			num_draws = 0,
			item_styles = {}
		}
	}
}
local friend_info_widget_definitions = {
	update_friend_info_icon = UIWidgets.create_simple_rotated_texture("matchmaking_connecting_icon", 0, {
		25,
		25
	}, "update_friend_info_icon"),
	controller_invite_text = {
		scenegraph_id = "friend_info_window",
		element = {
			passes = {
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				}
			}
		},
		content = {
			text = Localize("friend_list_invitation_sent")
		},
		style = {
			text = {
				vertical_alignment = "bottom",
				font_type = "hell_shark",
				font_size = 24,
				horizontal_alignment = "center",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 0),
				offset = {
					0,
					35,
					2
				}
			}
		}
	},
	friend_info_title = {
		scenegraph_id = "friend_info_window",
		element = {
			passes = {
				{
					style_id = "status",
					pass_type = "text",
					text_id = "status"
				},
				{
					pass_type = "texture",
					style_id = "player_name_line_breaker",
					texture_id = "line_breaker"
				}
			}
		},
		content = {
			line_breaker = "summary_screen_line_breaker",
			name = Localize("dlc1_2_difficulty_unavailable"),
			status = Localize("dlc1_2_difficulty_unavailable")
		},
		style = {
			player_name_line_breaker = {
				scenegraph_id = "friends_info_player_name_line_breaker"
			},
			status = {
				vertical_alignment = "top",
				font_type = "hell_shark",
				font_size = 24,
				horizontal_alignment = "center",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					-12,
					2
				}
			},
			name = {
				vertical_alignment = "top",
				font_type = "hell_shark",
				font_size = 24,
				horizontal_alignment = "center",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					-110,
					-12,
					2
				}
			}
		}
	},
	friend_info = {
		scenegraph_id = "friend_info_window",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "disable_image",
					texture_id = "disable_image",
					content_check_function = function (content)
						return not content.display_game_info and not content.in_idle
					end
				},
				{
					style_id = "info_title",
					pass_type = "text",
					text_id = "info_title"
				},
				{
					pass_type = "texture",
					style_id = "level_image",
					texture_id = "level_image",
					content_check_function = function (content)
						return content.display_game_info or content.in_idle
					end
				},
				{
					style_id = "level_prefix",
					pass_type = "text",
					text_id = "level_prefix",
					content_check_function = function (content)
						return content.display_game_info
					end
				},
				{
					style_id = "level_name",
					pass_type = "text",
					text_id = "level_name",
					content_check_function = function (content)
						return content.display_game_info
					end
				},
				{
					style_id = "difficulty_prefix",
					pass_type = "text",
					text_id = "difficulty_prefix",
					content_check_function = function (content)
						return content.display_game_info
					end
				},
				{
					style_id = "difficulty_name",
					pass_type = "text",
					text_id = "difficulty_name",
					content_check_function = function (content)
						return content.display_game_info
					end
				},
				{
					style_id = "players_prefix",
					pass_type = "text",
					text_id = "players_prefix",
					content_check_function = function (content)
						return content.display_game_info
					end
				},
				{
					style_id = "difficulty_name",
					pass_type = "text",
					text_id = "difficulty_name",
					content_check_function = function (content)
						return content.display_game_info
					end
				},
				{
					style_id = "num_players",
					pass_type = "text",
					text_id = "num_players",
					content_check_function = function (content)
						return content.display_game_info
					end
				}
			}
		},
		content = {
			disable_image = "friendslist_image_01",
			num_players = "1/4",
			display_game_info = false,
			in_idle = false,
			level_image = "level_image_any",
			level_prefix = Localize("map_level_setting") .. ":",
			difficulty_prefix = Localize("prefix_difficulty") .. ":",
			players_prefix = Localize("friend_list_players") .. ":",
			info_title = Localize("dlc1_2_difficulty_unavailable"),
			level_name = Localize("dlc1_2_difficulty_unavailable"),
			difficulty_name = Localize("dlc1_2_difficulty_unavailable")
		},
		style = {
			disable_image = {
				scenegraph_id = "disable_image"
			},
			level_image = {
				scenegraph_id = "level_image"
			},
			level_prefix = {
				vertical_alignment = "bottom",
				scenegraph_id = "level_image",
				horizontal_alignment = "left",
				font_type = "hell_shark",
				font_size = 18,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-45,
					-35,
					2
				}
			},
			level_name = {
				vertical_alignment = "bottom",
				scenegraph_id = "level_image",
				horizontal_alignment = "right",
				font_type = "hell_shark",
				font_size = 18,
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					45,
					-35,
					2
				}
			},
			difficulty_prefix = {
				vertical_alignment = "bottom",
				scenegraph_id = "level_image",
				horizontal_alignment = "left",
				font_type = "hell_shark",
				font_size = 18,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-45,
					-60,
					2
				}
			},
			difficulty_name = {
				vertical_alignment = "bottom",
				scenegraph_id = "level_image",
				horizontal_alignment = "right",
				font_type = "hell_shark",
				font_size = 18,
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					45,
					-60,
					2
				}
			},
			players_prefix = {
				vertical_alignment = "bottom",
				scenegraph_id = "level_image",
				horizontal_alignment = "left",
				font_type = "hell_shark",
				font_size = 18,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-45,
					-85,
					2
				}
			},
			num_players = {
				vertical_alignment = "bottom",
				scenegraph_id = "level_image",
				horizontal_alignment = "right",
				debug_draw_box = false,
				font_size = 18,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					45,
					-85,
					2
				}
			},
			info_title = {
				vertical_alignment = "center",
				scenegraph_id = "friend_info_title_text",
				horizontal_alignment = "center",
				font_type = "hell_shark",
				font_size = 18,
				word_wrap = true,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					2
				}
			}
		}
	}
}
LEVEL_TRANSLATIONS = {
	merchant = {
		"Supply and Demand",
		"Podaż i popyt",
		"Oferta y demanda",
		