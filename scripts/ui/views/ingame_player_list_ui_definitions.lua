local PLAYER_LIST_SIZE = {
	1920,
	36
}
local POPUP_ELEMENT_SIZE = {
	500,
	36
}
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.ingame_player_list
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
			UILayer.ingame_player_list
		},
		size = {
			1920,
			1080
		}
	},
	background = {
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
	game_level = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			-200,
			5
		},
		size = {
			1920,
			45
		}
	},
	game_difficulty = {
		vertical_alignment = "bottom",
		parent = "game_level",
		horizontal_alignment = "center",
		position = {
			0,
			-45,
			5
		},
		size = {
			1920,
			45
		}
	},
	headers = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			-320,
			5
		},
		size = {
			1920,
			45
		}
	},
	player_list = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			90,
			5
		},
		size = {
			PLAYER_LIST_SIZE[1],
			PLAYER_LIST_SIZE[2]
		}
	},
	player_list_input_description = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			-300,
			5
		},
		size = {
			1200,
			50
		}
	},
	popup = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			-200,
			10
		},
		size = {
			POPUP_ELEMENT_SIZE[1],
			POPUP_ELEMENT_SIZE[2]
		}
	},
	private_checkbox = {
		vertical_alignment = "top",
		parent = "game_level",
		horizontal_alignment = "center",
		size = {
			100,
			34
		},
		position = {
			-10,
			40,
			10
		}
	}
}
local widget_definitions = {
	input_description_text = UIWidgets.create_simple_text("player_list_show_mouse_description", "player_list_input_description", 24, Colors.get_table("white")),
	background = {
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
			}
		}
	},
	headers = {
		scenegraph_id = "headers",
		element = {
			passes = {
				{
					style_id = "players",
					pass_type = "text",
					text_id = "players"
				},
				{
					style_id = "level",
					pass_type = "text",
					text_id = "level"
				},
				{
					style_id = "hero",
					pass_type = "text",
					text_id = "hero"
				},
				{
					style_id = "game_level",
					pass_type = "text",
					text_id = "game_level"
				},
				{
					style_id = "game_difficulty",
					pass_type = "text",
					text_id = "game_difficulty"
				}
			}
		},
		content = {
			players = "friend_list_players",
			game_difficulty = "player_list_title_hero",
			game_level = "player_list_title_hero",
			hero = "player_list_title_hero",
			level = "level"
		},
		style = {
			players = {
				vertical_alignment = "center",
				localize = true,
				font_type = "hell_shark",
				font_size = 36,
				horizontal_alignment = "left",
				offset = {
					627,
					0,
					0
				},
				text_color = Colors.get_table("cheeseburger")
			},
			level = {
				vertical_alignment = "center",
				localize = true,
				font_type = "hell_shark",
				font_size = 36,
				horizontal_alignment = "center",
				offset = {
					0,
					0,
					0
				},
				text_color = Colors.get_table("cheeseburger")
			},
			hero = {
				vertical_alignment = "center",
				localize = true,
				font_type = "hell_shark",
				font_size = 36,
				horizontal_alignment = "left",
				offset = {
					1200,
					0,
					0
				},
				text_color = Colors.get_table("cheeseburger")
			},
			game_level = {
				vertical_alignment = "center",
				scenegraph_id = "game_level",
				localize = true,
				horizontal_alignment = "center",
				font_size = 40,
				font_type = "hell_shark",
				text_color = Colors.get_table("white")
			},
			game_difficulty = {
				vertical_alignment = "center",
				scenegraph_id = "game_difficulty",
				localize = false,
				horizontal_alignment = "center",
				font_size = 40,
				font_type = "hell_shark",
				text_color = Colors.get_table("white")
			}
		}
	},
	private_checkbox = {
		scenegraph_id = "private_checkbox",
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "tooltip_text",
					content_check_function = function (ui_content)
						return ui_content.button_hotspot.is_hover
					end
				},
				{
					style_id = "setting_text",
					pass_type = "text",
					text_id = "setting_text",
					content_check_function = function (content)
						return not content.button_hotspot.is_hover
					end
				},
				{
					style_id = "setting_text_hover",
					pass_type = "text",
					text_id = "setting_text",
					content_check_function = function (content)
						return content.button_hotspot.is_hover
					end
				},
				{
					pass_type = "texture",
					style_id = "checkbox_style",
					texture_id = "checkbox_unchecked_texture",
					content_check_function = function (content)
						return not content.selected
					end
				},
				{
					pass_type = "texture",
					style_id = "checkbox_style",
					texture_id = "checkbox_checked_texture",
					content_check_function = function (content)
						return content.selected
					end
				}
			}
		},
		content = {
			tooltip_text = "map_private_setting_tooltip",
			checkbox_unchecked_texture = "checkbox_unchecked",
			checkbox_checked_texture = "checkbox_checked",
			selected = false,
			setting_text = "map_screen_private_button",
			button_hotspot = {}
		},
		style = {
			checkbox_style = {
				size = {
					16,
					16
				},
				offset = {
					84,
					6,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			setting_text = {
				vertical_alignment = "center",
				font_size = 20,
				localize = true,
				horizontal_alignment = "right",
				word_wrap = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-16,
					-2,
					4
				}
			},
			setting_text_hover = {
				vertical_alignment = "center",
				font_size = 20,
				localize = true,
				horizontal_alignment = "right",
				word_wrap = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					-16,
					-2,
					4
				}
			},
			tooltip_text = {
				font_size = 18,
				max_width = 500,
				localize = true,
				cursor_side = "left",
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {},
				offset = {
					0,
					0,
					50
				},
				cursor_offset = {
					-10,
					-27
				}
			}
		}
	}
}
local popup_buttons = {
	{
		text = "player_list_kick_player",
		func_name = "kick_player",
		availability_func = "kick_player_available"
	},
	{
		text = "player_list_mute_player",
		func_name = "popup_test_func"
	}
}
local popup_widget_definition = {
	scenegraph_id = "popup",
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
						content_check_function = function (content, style)
							return content.button_hotspot.disable_button ~= true
						end
					},
					{
						style_id = "button_text",
						pass_type = "text",
						text_id = "button_text",
						content_check_function = function (content, style)
							if content.button_hotspot.disable_button ~= true then
								if content.button_hotspot.is_hover then
									style.button_text.text_color = style.button_text.hover_color
								else
									style.button_text.text_color = style.button_text.base_color
								end
							end

							return true
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
local popup_buttons_n = #popup_buttons

for i = 1, popup_buttons_n, 1 do
	local popup_button = popup_buttons[i]
	local content = {
		button_hotspot = {},
		button_text = popup_button.text,
		button_func_name = popup_button.func_name,
		button_availability_func_name = popup_button.availability_func
	}
	local style = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		size = {
			POPUP_ELEMENT_SIZE[1],
			POPUP_ELEMENT_SIZE[2]
		},
		list_member_offset = {
			0,
			-POPUP_ELEMENT_SIZE[2],
			0
		},
		button_text = {
			font_size = 28,
			localize = true,
			horizontal_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			base_color = Colors.get_table("dark_gray"),
			hover_color = Colors.get_table("white"),
			disabled_color = Colors.get_table("dim_gray"),
			text_color = Colors.get_table("dark_gray")
		}
	}
	popup_widget_definition.content.list_content[i] = content
	popup_widget_definition.style.list_style.item_styles[i] = style
end

popup_widget_definition.style.list_style.num_draws = popup_buttons_n
local hero_textures = {
	bright_wizard = {
		{
			"is_hover",
			"tabs_class_icon_bright_wizard_selected"
		},
		{
			"tabs_class_icon_bright_wizard_normal"
		}
	},
	dwarf_ranger = {
		{
			"is_hover",
			"tabs_class_icon_dwarf_ranger_selected"
		},
		{
			"tabs_class_icon_dwarf_ranger_normal"
		}
	},
	empire_soldier = {
		{
			"is_hover",
			"tabs_class_icon_empire_soldier_selected"
		},
		{
			"tabs_class_icon_empire_soldier_normal"
		}
	},
	wood_elf = {
		{
			"is_hover",
			"tabs_class_icon_way_watcher_selected"
		},
		{
			"tabs_class_icon_way_watcher_normal"
		}
	},
	witch_hunter = {
		{
			"is_hover",
			"tabs_class_icon_witch_hunter_selected"
		},
		{
			"tabs_class_icon_witch_hunter_normal"
		}
	},
	unspawned = {
		{
			"is_hover",
			"tabs_class_icon_bright_wizard_selected"
		},
		{
			"tabs_class_icon_bright_wizard_normal"
		}
	}
}
local Y_OFFSET = 35

local function player_widget_definition(index)
	local i = index - 1
	local y_offset = -(PLAYER_LIST_SIZE[2]*i + Y_OFFSET*i)
	local text_y_offset = 9
	local start_x = 400
	local definition = {
		scenegraph_id = "player_list",
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot",
					content_check_function = function (content)
						return not content.disable_button
					end
				},
				{
					pass_type = "controller_hotspot",
					content_id = "controller_button_hotspot"
				},
				{
					pass_type = "texture",
					style_id = "hover_texture",
					texture_id = "hover_texture",
					content_check_function = function (content)
						return content.button_hotspot.is_hover or content.button_hotspot.is_selected or content.controller_button_hotspot.is_hover
					end
				},
				{
					pass_type = "texture",
					style_id = "host_texture",
					texture_id = "host_texture",
					content_check_function = function (content)
						return content.show_host
					end
				},
				{
					pass_type = "texture",
					style_id = "ping_texture",
					texture_id = "ping_texture",
					content_check_function = function (content)
						return content.show_ping
					end
				},
				{
					pass_type = "texture",
					style_id = "ping_texture_fg",
					texture_id = "ping_texture_fg",
					content_check_function = function (content)
						return content.show_ping
					end
				},
				{
					pass_type = "texture",
					style_id = "chat_button_hotspot",
					texture_id = "chat_button_texture",
					content_check_function = function (content)
						return content.show_chat_button
					end
				},
				{
					pass_type = "texture",
					style_id = "chat_button_disabled",
					texture_id = "disabled_texture",
					content_check_function = function (content)
						return content.show_chat_button and content.chat_button_hotspot.is_selected
					end
				},
				{
					style_id = "chat_button_hotspot",
					pass_type = "hotspot",
					content_id = "chat_button_hotspot",
					content_check_function = function (content)
						return not content.disable_button
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "chat_tooltip_text_mute",
					content_check_function = function (content)
						return content.show_chat_button and not content.chat_button_hotspot.is_selected and content.chat_button_hotspot.is_hover
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "chat_tooltip_text_unmute",
					content_check_function = function (content)
						return content.show_chat_button and content.chat_button_hotspot.is_selected and content.chat_button_hotspot.is_hover
					end
				},
				{
					pass_type = "texture",
					style_id = "voice_button_hotspot",
					texture_id = "voice_button_texture",
					content_check_function = function (content)
						return content.show_voice_button
					end
				},
				{
					pass_type = "texture",
					style_id = "voice_button_disabled",
					texture_id = "disabled_texture",
					content_check_function = function (content)
						return content.show_voice_button and content.voice_button_hotspot.is_selected
					end
				},
				{
					style_id = "voice_button_hotspot",
					pass_type = "hotspot",
					content_id = "voice_button_hotspot",
					content_check_function = function (content)
						return not content.disable_button
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "voice_tooltip_text_mute",
					content_check_function = function (content)
						return content.show_voice_button and not content.voice_button_hotspot.is_selected and content.voice_button_hotspot.is_hover
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "voice_tooltip_text_unmute",
					content_check_function = function (content)
						return content.show_voice_button and content.voice_button_hotspot.is_selected and content.voice_button_hotspot.is_hover
					end
				},
				{
					style_id = "kick_button_hotspot",
					pass_type = "hotspot",
					content_id = "kick_button_hotspot",
					content_check_function = function (content)
						return not content.disable_button
					end
				},
				{
					pass_type = "texture",
					style_id = "kick_button_hotspot",
					texture_id = "kick_button_texture",
					content_check_function = function (content)
						return content.show_kick_button
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "kick_tooltip_text",
					content_check_function = function (content)
						return content.show_kick_button and content.kick_button_hotspot.is_hover
					end
				},
				{
					style_id = "profile_button_hotspot",
					pass_type = "hotspot",
					content_id = "profile_button_hotspot",
					content_check_function = function (content)
						return not content.disable_button
					end
				},
				{
					pass_type = "texture",
					style_id = "profile_button_hotspot",
					texture_id = "profile_button_texture",
					content_check_function = function (content)
						return content.show_profile_button
					end
				},
				{
					style_id = "tooltip_text",
					pass_type = "tooltip_text",
					text_id = "profile_tooltip_text",
					content_check_function = function (content)
						return content.show_profile_button and content.profile_button_hotspot.is_hover
					end
				},
				{
					style_id = "name",
					pass_type = "text",
					text_id = "name",
					content_check_function = function (content, style)
						if content.button_hotspot.is_hover or content.button_hotspot.is_selected or content.controller_button_hotspot.is_hover then
							style.text_color = style.hover_color
						else
							style.text_color = style.color
						end

						return true
					end
				},
				{
					style_id = "level",
					pass_type = "text",
					text_id = "level",
					content_check_function = function (content, style)
						if content.button_hotspot.is_hover or content.button_hotspot.is_selected or content.controller_button_hotspot.is_hover then
							style.text_color = style.hover_color
						else
							style.text_color = style.color
						end

						return true
					end
				},
				{
					style_id = "hero_texture",
					state_content_id = "button_hotspot",
					pass_type = "state_texture",
					texture_content_id = "hero_texture"
				},
				{
					style_id = "hero",
					pass_type = "text",
					text_id = "hero",
					content_check_function = function (content, style)
						if content.button_hotspot.is_hover or content.button_hotspot.is_selected or content.controller_button_hotspot.is_hover then
							style.text_color = style.hover_color
						else
							style.text_color = style.color
						end

						return true
					end
				}
			}
		},
		content = {
			chat_tooltip_text_unmute = "input_description_unmute_chat",
			name = "n/a",
			show_chat_button = false,
			ping_texture = "ping_icon_bg",
			show_kick_button = false,
			hero = "Witch Hunter",
			hover_texture = "playerlist_hover",
			chat_tooltip_text_mute = "input_description_mute_chat",
			profile_tooltip_text = "input_description_show_profile",
			chat_button_texture = "tab_menu_icon_02",
			profile_button_texture = "tab_menu_icon_05",
			disabled_texture = "tab_menu_icon_03",
			level = "n/a",
			host_texture = "host_icon",
			kick_tooltip_text = "input_description_vote_kick_player",
			voice_tooltip_text_unmute = "input_description_unmute_voice",
			kick_button_texture = "tab_menu_icon_04",
			ping_texture_fg = "ping_icon_fg",
			show_voice_button = false,
			voice_tooltip_text_mute = "input_description_mute_voice",
			show_profile_button = false,
			voice_button_texture = "tab_menu_icon_01",
			show_ping = false,
			button_hotspot = {},
			chat_button_hotspot = {},
			kick_button_hotspot = {},
			voice_button_hotspot = {},
			profile_button_hotspot = {},
			controller_button_hotspot = {},
			hero_texture = {
				{
					"is_hover",
					"tabs_class_icon_bright_wizard_selected"
				},
				{
					"tabs_class_icon_bright_wizard_normal"
				}
			}
		},
		style = {
			tooltip_text = {
				vertical_alignment = "top",
				max_width = 500,
				localize = true,
				horizontal_alignment = "left",
				font_size = 18,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					1
				}
			},
			profile_button_hotspot = {
				size = {
					40,
					40
				},
				offset = {
					0,
					0,
					0
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					352,
					text_y_offset + y_offset,
					0
				}
			},
			chat_button_hotspot = {
				size = {
					40,
					40
				},
				offset = {
					0,
					0,
					0
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					402,
					text_y_offset + y_offset,
					0
				}
			},
			chat_button_disabled = {
				size = {
					40,
					40
				},
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
				offset = {
					402,
					text_y_offset + y_offset,
					0
				}
			},
			voice_button_hotspot = {
				size = {
					40,
					40
				},
				offset = {
					0,
					0,
					0
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					452,
					text_y_offset + y_offset,
					0
				}
			},
			voice_button_disabled = {
				size = {
					40,
					40
				},
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
				offset = {
					452,
					text_y_offset + y_offset,
					0
				}
			},
			kick_button_hotspot = {
				size = {
					40,
					40
				},
				offset = {
					0,
					0,
					0
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					502,
					text_y_offset + y_offset,
					0
				}
			},
			ping_texture = {
				size = {
					20,
					20
				},
				offset = {
					0,
					0,
					0
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					602,
					text_y_offset + y_offset + 10,
					0
				}
			},
			ping_texture_fg = {
				size = {
					20,
					20
				},
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
				offset = {
					602,
					text_y_offset + y_offset + 10,
					0
				}
			},
			offset = {
				0,
				y_offset,
				0
			},
			hover_texture = {
				offset = {
					0,
					y_offset + 12,
					-1
				},
				color = Colors.get_table("white"),
				size = {
					PLAYER_LIST_SIZE[1],
					PLAYER_LIST_SIZE[2]
				}
			},
			host_texture = {
				offset = {
					577,
					y_offset + 22,
					0
				},
				size = {
					18,
					14
				}
			},
			name = {
				font_type = "hell_shark",
				font_size = 28,
				offset = {
					627,
					text_y_offset + y_offset,
					0
				},
				color = Colors.get_table("dark_gray"),
				hover_color = Colors.get_table("white"),
				text_color = Colors.get_table("dark_gray")
			},
			level = {
				font_type = "hell_shark",
				font_size = 28,
				horizontal_alignment = "center",
				offset = {
					0,
					text_y_offset + y_offset,
					0
				},
				color = Colors.get_table("dark_gray"),
				hover_color = Colors.get_table("white"),
				text_color = Colors.get_table("dark_gray")
			},
			hero_texture = {
				offset = {
					1200,
					y_offset + 14,
					0
				},
				color = {
					255,
					255,
					255,
					255
				},
				size = {
					34,
					34
				}
			},
			hero = {
				localize = true,
				font_size = 28,
				font_type = "hell_shark",
				offset = {
					1239,
					text_y_offset + y_offset,
					0
				},
				color = Colors.get_table("dark_gray"),
				hover_color = Colors.get_table("white"),
				text_color = Colors.get_table("dark_gray")
			}
		}
	}

	return definition
end

local generic_input_actions = {
	own_player = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "back",
			priority = 5,
			description_text = "input_description_close"
		}
	},
	server_default = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "mute_chat",
			priority = 2,
			description_text = "input_description_mute_chat"
		},
		{
			input_action = "mute_voice",
			priority = 3,
			description_text = "input_description_mute_voice"
		},
		{
			input_action = "show_profile",
			priority = 4,
			description_text = "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 5,
			description_text = "input_description_close"
		}
	},
	server_chat_muted = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "mute_chat",
			priority = 2,
			description_text = "input_description_unmute_chat"
		},
		{
			input_action = "mute_voice",
			priority = 3,
			description_text = "input_description_mute_voice"
		},
		{
			input_action = "show_profile",
			priority = 4,
			description_text = "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 5,
			description_text = "input_description_close"
		}
	},
	server_voice_muted = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "mute_chat",
			priority = 2,
			description_text = "input_description_mute_chat"
		},
		{
			input_action = "mute_voice",
			priority = 3,
			description_text = "input_description_unmute_voice"
		},
		{
			input_action = "show_profile",
			priority = 4,
			description_text = "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 5,
			description_text = "input_description_close"
		}
	},
	server_voice_and_chat_muted = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "mute_chat",
			priority = 2,
			description_text = "input_description_unmute_chat"
		},
		{
			input_action = "mute_voice",
			priority = 3,
			description_text = "input_description_unmute_voice"
		},
		{
			input_action = "show_profile",
			priority = 4,
			description_text = "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 5,
			description_text = "input_description_close"
		}
	},
	default = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "kick_player",
			priority = 2,
			description_text = "input_description_vote_kick_player"
		},
		{
			input_action = "mute_chat",
			priority = 3,
			description_text = "input_description_mute_chat"
		},
		{
			input_action = "mute_voice",
			priority = 4,
			description_text = "input_description_mute_voice"
		},
		{
			input_action = "show_profile",
			priority = 5,
			description_text = "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 6,
			description_text = "input_description_close"
		}
	},
	chat_muted = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "kick_player",
			priority = 2,
			description_text = "input_description_vote_kick_player"
		},
		{
			input_action = "mute_chat",
			priority = 3,
			description_text = "input_description_unmute_chat"
		},
		{
			input_action = "mute_voice",
			priority = 4,
			description_text = "input_description_mute_voice"
		},
		{
			input_action = "show_profile",
			priority = 5,
			description_text = "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 6,
			description_text = "input_description_close"
		}
	},
	voice_muted = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "kick_player",
			priority = 2,
			description_text = "input_description_vote_kick_player"
		},
		{
			input_action = "mute_chat",
			priority = 3,
			description_text = "input_description_mute_chat"
		},
		{
			input_action = "mute_voice",
			priority = 4,
			description_text = "input_description_unmute_voice"
		},
		{
			input_action = "show_profile",
			priority = 5,
			description_text = "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 6,
			description_text = "input_description_close"
		}
	},
	voice_and_chat_muted = {
		{
			input_action = "d_vertical",
			priority = 1,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "kick_player",
			priority = 2,
			description_text = "input_description_vote_kick_player"
		},
		{
			input_action = "mute_chat",
			priority = 3,
			description_text = "input_description_unmute_chat"
		},
		{
			input_action = "mute_voice",
			priority = 4,
			description_text = "input_description_unmute_voice"
		},
		{
			input_action = "show_profile",
			priority = 5,
			description_text = "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 6,
			description_text = "input_description_close"
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions,
	player_widget_definition = player_widget_definition,
	popup_widget_definition = popup_widget_definition,
	generic_input_actions = generic_input_actions,
	hero_textures = hero_textures
}
