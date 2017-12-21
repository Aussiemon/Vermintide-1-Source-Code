-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
require("scripts/ui/views/menu_input_description_ui")

PopupJoinLobbyHandler = class(PopupJoinLobbyHandler)
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
			UILayer.matchmaking
		}
	},
	screen = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.matchmaking - 1
		}
	},
	background = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			1
		}
	},
	title_bar_caption = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		size = {
			500,
			150
		},
		position = {
			0,
			-100,
			1
		}
	},
	level_image = {
		vertical_alignment = "top",
		parent = "title_divider",
		horizontal_alignment = "center",
		size = {
			300,
			170
		},
		position = {
			0,
			-60,
			1
		}
	},
	title_divider = {
		vertical_alignment = "bottom",
		parent = "title_bar_caption",
		horizontal_alignment = "center",
		size = {
			386,
			22
		},
		position = {
			0,
			-30,
			1
		}
	},
	level_divider = {
		vertical_alignment = "bottom",
		parent = "level_image",
		horizontal_alignment = "center",
		size = {
			386,
			22
		},
		position = {
			0,
			-60,
			1
		}
	},
	hero_divider = {
		vertical_alignment = "bottom",
		parent = "button_swap_charcter",
		horizontal_alignment = "center",
		size = {
			386,
			22
		},
		position = {
			0,
			-20,
			1
		}
	},
	selected_hero = {
		vertical_alignment = "top",
		parent = "level_divider",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			0,
			-90,
			1
		}
	},
	selected_hero_frame = {
		vertical_alignment = "center",
		parent = "selected_hero",
		horizontal_alignment = "center",
		size = {
			141,
			198
		},
		position = {
			0,
			0,
			1
		}
	},
	button_swap_charcter = {
		vertical_alignment = "bottom",
		parent = "selected_hero",
		horizontal_alignment = "center",
		size = {
			220,
			62
		},
		position = {
			0,
			-90,
			1
		}
	},
	button_confirm = {
		vertical_alignment = "bottom",
		parent = "hero_divider",
		horizontal_alignment = "center",
		size = {
			220,
			62
		},
		position = {
			-120,
			-80,
			1
		}
	},
	button_decline = {
		vertical_alignment = "bottom",
		parent = "hero_divider",
		horizontal_alignment = "center",
		size = {
			260,
			62
		},
		position = {
			0,
			-80,
			1
		}
	},
	button_decline_timer = {
		vertical_alignment = "center",
		parent = "button_decline",
		horizontal_alignment = "right",
		size = {
			40,
			20
		},
		position = {
			-8,
			-2,
			1
		}
	},
	text_level = {
		vertical_alignment = "top",
		parent = "level_image",
		horizontal_alignment = "center",
		size = {
			300,
			30
		},
		position = {
			0,
			40,
			1
		}
	},
	text_difficulty = {
		vertical_alignment = "bottom",
		parent = "level_image",
		horizontal_alignment = "center",
		size = {
			300,
			30
		},
		position = {
			0,
			-30,
			1
		}
	},
	text_hero = {
		vertical_alignment = "top",
		parent = "selected_hero",
		horizontal_alignment = "center",
		size = {
			300,
			30
		},
		position = {
			0,
			65,
			1
		}
	},
	text_swap_hero = {
		vertical_alignment = "center",
		parent = "level_divider",
		horizontal_alignment = "center",
		size = {
			400,
			60
		},
		position = {
			0,
			-40,
			1
		}
	},
	text_controller_timer_text = {
		vertical_alignment = "bottom",
		parent = "hero_divider",
		horizontal_alignment = "center",
		size = {
			300,
			30
		},
		position = {
			0,
			-40,
			1
		}
	},
	text_controller_timer = {
		vertical_alignment = "bottom",
		parent = "text_controller_timer_text",
		horizontal_alignment = "center",
		size = {
			300,
			30
		},
		position = {
			0,
			-60,
			1
		}
	},
	button_witch_hunter = {
		vertical_alignment = "top",
		parent = "level_divider",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			-260,
			-140,
			1
		}
	},
	button_frame_witch_hunter = {
		vertical_alignment = "center",
		parent = "button_witch_hunter",
		horizontal_alignment = "center",
		size = {
			87,
			121
		},
		position = {
			0,
			0,
			3
		}
	},
	button_hotspot_witch_hunter = {
		vertical_alignment = "center",
		parent = "button_witch_hunter",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			0,
			0,
			1
		}
	},
	button_wood_elf = {
		vertical_alignment = "top",
		parent = "level_divider",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			-130,
			-140,
			1
		}
	},
	button_frame_wood_elf = {
		vertical_alignment = "center",
		parent = "button_wood_elf",
		horizontal_alignment = "center",
		size = {
			87,
			121
		},
		position = {
			0,
			0,
			3
		}
	},
	button_hotspot_wood_elf = {
		vertical_alignment = "center",
		parent = "button_wood_elf",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			0,
			0,
			1
		}
	},
	button_dwarf_ranger = {
		vertical_alignment = "top",
		parent = "level_divider",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			0,
			-140,
			1
		}
	},
	button_frame_dwarf_ranger = {
		vertical_alignment = "center",
		parent = "button_dwarf_ranger",
		horizontal_alignment = "center",
		size = {
			87,
			121
		},
		position = {
			0,
			0,
			3
		}
	},
	button_hotspot_dwarf_ranger = {
		vertical_alignment = "center",
		parent = "button_dwarf_ranger",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			0,
			0,
			1
		}
	},
	button_bright_wizard = {
		vertical_alignment = "top",
		parent = "level_divider",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			130,
			-140,
			1
		}
	},
	button_frame_bright_wizard = {
		vertical_alignment = "center",
		parent = "button_bright_wizard",
		horizontal_alignment = "center",
		size = {
			87,
			121
		},
		position = {
			0,
			0,
			3
		}
	},
	button_hotspot_bright_wizard = {
		vertical_alignment = "center",
		parent = "button_bright_wizard",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			0,
			0,
			1
		}
	},
	button_empire_soldier = {
		vertical_alignment = "top",
		parent = "level_divider",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			260,
			-140,
			1
		}
	},
	button_frame_empire_soldier = {
		vertical_alignment = "center",
		parent = "button_empire_soldier",
		horizontal_alignment = "center",
		size = {
			87,
			121
		},
		position = {
			0,
			0,
			3
		}
	},
	button_hotspot_empire_soldier = {
		vertical_alignment = "center",
		parent = "button_empire_soldier",
		horizontal_alignment = "center",
		size = {
			66,
			101
		},
		position = {
			0,
			0,
			1
		}
	}
}
local generic_input_actions = {
	default = {
		{
			input_action = "confirm",
			priority = 2,
			description_text = "input_description_select"
		},
		{
			input_action = "back",
			priority = 3,
			description_text = "popup_keep_searching"
		}
	},
	unavailable = {
		{
			input_action = "back",
			priority = 1,
			description_text = "popup_keep_searching"
		}
	}
}
local widgets = {
	background_widget = {
		scenegraph_id = "background",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "background",
					texture_id = "background_texture"
				},
				{
					style_id = "title_bar_caption",
					pass_type = "text",
					text_id = "title_bar_caption"
				},
				{
					pass_type = "texture",
					style_id = "title_divider",
					texture_id = "divider_texture"
				},
				{
					pass_type = "texture",
					style_id = "level_texture",
					texture_id = "level_texture"
				},
				{
					style_id = "text_level",
					pass_type = "text",
					text_id = "text_level"
				},
				{
					style_id = "text_difficulty",
					pass_type = "text",
					text_id = "text_difficulty"
				},
				{
					style_id = "text_controller_timer",
					pass_type = "text",
					text_id = "text_controller_timer",
					content_check_function = function (content)
						return Managers.input:is_device_active("gamepad")
					end
				},
				{
					style_id = "text_controller_timer_text",
					pass_type = "text",
					text_id = "text_controller_timer_text",
					content_check_function = function (content)
						return Managers.input:is_device_active("gamepad")
					end
				},
				{
					pass_type = "texture",
					style_id = "hero_divider",
					texture_id = "divider_texture"
				},
				{
					pass_type = "texture",
					style_id = "level_divider",
					texture_id = "divider_texture"
				}
			}
		},
		content = {
			text_level = "",
			text_difficulty = "",
			level_texture = "level_image_farm",
			text_controller_timer = "",
			divider_texture = "summary_screen_line_breaker",
			background_texture = "gradient_credits_menu",
			title_bar_caption = Localize("matchmaking_join_game"),
			text_level_caption = Localize("level") .. ":",
			text_controller_timer_text = Localize("popup_keep_searching")
		},
		style = {
			background = {
				scenegraph_id = "screen",
				color = {
					255,
					255,
					255,
					255
				}
			},
			title_divider = {
				scenegraph_id = "title_divider",
				color = {
					255,
					255,
					255,
					255
				}
			},
			level_texture = {
				scenegraph_id = "level_image",
				color = {
					255,
					255,
					255,
					255
				}
			},
			level_divider = {
				scenegraph_id = "level_divider",
				color = {
					255,
					255,
					255,
					255
				}
			},
			hero_divider = {
				scenegraph_id = "hero_divider",
				color = {
					255,
					255,
					255,
					255
				}
			},
			title_bar_caption = {
				scenegraph_id = "title_bar_caption",
				horizontal_alignment = "center",
				font_size = 100,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					4
				}
			},
			text_level = {
				font_size = 24,
				scenegraph_id = "text_level",
				horizontal_alignment = "center",
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					4
				}
			},
			text_difficulty = {
				scenegraph_id = "text_difficulty",
				horizontal_alignment = "center",
				font_size = 24,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					4
				}
			},
			text_controller_timer = {
				scenegraph_id = "text_controller_timer",
				horizontal_alignment = "center",
				font_size = 75,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					4
				}
			},
			text_controller_timer_text = {
				scenegraph_id = "text_controller_timer_text",
				horizontal_alignment = "center",
				font_size = 30,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					4
				}
			}
		}
	},
	swap_hero_text_widget = {
		scenegraph_id = "selected_hero_frame",
		element = {
			passes = {
				{
					style_id = "text_swap_hero",
					pass_type = "text",
					text_id = "text_swap_hero"
				}
			}
		},
		content = {
			text_swap_hero = Localize("swap_hero_text")
		},
		style = {
			text_swap_hero = {
				scenegraph_id = "text_swap_hero",
				horizontal_alignment = "center",
				font_size = 24,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					4
				}
			}
		}
	},
	selected_hero_widget = {
		scenegraph_id = "selected_hero_frame",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "selected_hero_frame",
					texture_id = "selected_hero_frame_texture"
				},
				{
					pass_type = "texture",
					style_id = "selected_hero",
					texture_id = "selected_hero_texture"
				},
				{
					style_id = "text_hero",
					pass_type = "text",
					text_id = "text_hero"
				}
			}
		},
		content = {
			selected_hero_texture = "unit_frame_portrait_dead",
			text_hero = "",
			selected_hero_frame_texture = "unit_frame_07",
			text_hero_caption = Localize("player_list_title_hero") .. ":"
		},
		style = {
			selected_hero = {
				scenegraph_id = "selected_hero",
				color = {
					255,
					255,
					255,
					255
				}
			},
			selected_hero_frame = {
				scenegraph_id = "selected_hero_frame",
				color = {
					255,
					255,
					255,
					255
				}
			},
			text_hero = {
				scenegraph_id = "text_hero",
				horizontal_alignment = "center",
				font_size = 24,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					4
				}
			}
		}
	},
	button_confirm_widget = UIWidgets.create_menu_button_medium("popup_choice_accept", "button_confirm"),
	button_swap_hero_widget = UIWidgets.create_menu_button_medium("popup_choice_switch_hero", "button_swap_charcter"),
	button_decline_widget = UIWidgets.create_menu_button_medium_with_timer("popup_keep_searching", "10", "button_decline_timer", "button_decline")
}
local hero_table = {
	{
		texture = "unit_frame_portrait_witch_hunter",
		name = "witch_hunter"
	},
	{
		texture = "unit_frame_portrait_way_watcher",
		name = "wood_elf"
	},
	{
		texture = "unit_frame_portrait_dwarf_ranger",
		name = "dwarf_ranger"
	},
	{
		texture = "unit_frame_portrait_bright_wizard",
		name = "bright_wizard"
	},
	{
		texture = "unit_frame_portrait_empire_soldier",
		name = "empire_soldier"
	}
}

local function create_hero_widgets()
	local hero_table_n = #hero_table
	local hero_widgets = {}

	for i = 1, hero_table_n, 1 do
		local hero = hero_table[i]
		local hero_name = hero.name
		local widget_name = hero_name
		local button_scenegraph_id = "button_" .. hero_name
		local button_frame_scenegraph_id = "button_frame_" .. hero_name
		local button_hotspot_scenegraph_id = "button_hotspot_" .. hero_name
		local widget_definition = {
			element = {
				passes = {
					{
						style_id = "button_hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "texture",
						style_id = "hero_texture",
						texture_id = "hero_texture"
					},
					{
						pass_type = "texture",
						style_id = "frame_disabled",
						texture_id = "frame_disabled",
						content_check_function = function (content)
							return content.button_hotspot.disable_button
						end
					},
					{
						pass_type = "texture",
						style_id = "frame_selected",
						texture_id = "frame_selected",
						content_check_function = function (content)
							return content.button_hotspot.is_selected and not content.button_hotspot.disable_button
						end
					},
					{
						pass_type = "texture",
						style_id = "frame_normal",
						texture_id = "frame_normal",
						content_check_function = function (content)
							return not content.button_hotspot.is_selected
						end
					},
					{
						pass_type = "texture",
						style_id = "frame_hover",
						texture_id = "frame_hover",
						content_check_function = function (content)
							return content.button_hotspot.is_hover or (Managers.input:is_device_active("gamepad") and content.button_hotspot.is_selected)
						end
					}
				}
			},
			content = {
				frame_disabled = "unit_frame_portrait_matchmaking_04",
				frame_selected = "matchmaking_portrait_frame_04",
				frame_hover = "matchmaking_portrait_frame_hover",
				frame_normal = "matchmaking_portrait_frame_02",
				button_hotspot = {},
				hero_texture = hero.texture
			},
			style = {
				hero_texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				frame_disabled = {
					color = {
						255,
						255,
						255,
						255
					},
					size = {
						66,
						101
					},
					offset = {
						10,
						14
					},
					scenegraph_id = button_frame_scenegraph_id
				},
				frame_selected = {
					color = {
						255,
						255,
						255,
						255
					},
					scenegraph_id = button_frame_scenegraph_id
				},
				frame_normal = {
					color = {
						100,
						255,
						255,
						255
					},
					scenegraph_id = button_frame_scenegraph_id
				},
				frame_hover = {
					size = {
						117,
						152
					},
					offset = {
						-25.5,
						-25.5,
						10
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				button_hotspot = {
					scenegraph_id = button_hotspot_scenegraph_id
				}
			},
			scenegraph_id = button_scenegraph_id
		}
		hero_widgets[widget_name] = UIWidget.init(widget_definition)
	end

	return hero_widgets
end

local DO_RELOAD = true
PopupJoinLobbyHandler.init = function (self, ingame_ui_context)
	self.network_event_delegate = ingame_ui_context.network_event_delegate
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.peer_id = Network:peer_id()
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager.create_input_service(input_manager, "popup_join_lobby_handler", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "popup_join_lobby_handler", "keyboard")
	input_manager.map_device_to_service(input_manager, "popup_join_lobby_handler", "mouse")
	input_manager.map_device_to_service(input_manager, "popup_join_lobby_handler", "gamepad")

	local input_service = Managers.input:get_service("popup_join_lobby_handler")
	local gui_layer = scenegraph_definition.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, #generic_input_actions.default, gui_layer, generic_input_actions.default)

	self.menu_input_description:set_input_description(nil)
	rawset(_G, "GLOBAL_MM_JL_UI", self)
	self.create_ui_elements(self)

	self.visible = false
	self.popup_id = 0
	DO_RELOAD = false

	return 
end
PopupJoinLobbyHandler.create_ui_elements = function (self)
	self.ui_animations = {}
	self.background_widget = UIWidget.init(widgets.background_widget)
	self.selected_hero_widget = UIWidget.init(widgets.selected_hero_widget)
	self.swap_hero_text_widget = UIWidget.init(widgets.swap_hero_text_widget)
	self.button_swap_hero_widget = UIWidget.init(widgets.button_swap_hero_widget)
	self.button_confirm_widget = UIWidget.init(widgets.button_confirm_widget)
	self.button_decline_widget = UIWidget.init(widgets.button_decline_widget)
	self.button_hero_widgets = create_hero_widgets()
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
PopupJoinLobbyHandler.update = function (self, dt)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if self.visible and self.block_all_services_timer then
		self.block_all_services_timer = self.block_all_services_timer - dt

		if self.block_all_services_timer < 0 then
			local input_manager = self.input_manager

			input_manager.block_device_except_service(input_manager, "popup_join_lobby_handler", "keyboard", 1)
			input_manager.block_device_except_service(input_manager, "popup_join_lobby_handler", "mouse", 1)
			input_manager.block_device_except_service(input_manager, "popup_join_lobby_handler", "gamepad", 1)

			self.block_all_services_timer = nil
		end
	end

	local ui_renderer = self.ui_renderer
	local input_service = self.input_service(self)

	if self.cancel_timer then
		self.cancel_timer = self.cancel_timer - dt
		self.button_decline_widget.content.timer_text_field = math.ceil(self.cancel_timer)

		self.update_controller_timer(self, dt)

		if self.cancel_timer < 0 and self.visible then
			local accepted = false

			self.set_result(self, accepted)
		end
	end

	if self.unblock_all_services_timer then
		self.unblock_all_services_timer = self.unblock_all_services_timer - dt

		if self.unblock_all_services_timer < 0 then
			self.unblock_all_services(self)

			self.unblock_all_services_timer = nil
		end
	end

	if not self.visible then
		return 
	end

	for name, animation in pairs(self.ui_animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			animation = nil
		end
	end

	self.update_lobby(self, dt)
	self.draw(self, ui_renderer, input_service, dt)

	return 
end
PopupJoinLobbyHandler.update_controller_timer = function (self, dt)
	local lerp_value = self.cancel_timer%1

	Colors.lerp_color_tables(Colors.get_table("white"), Colors.get_table("cheeseburger"), lerp_value, self.background_widget.style.text_controller_timer.text_color)

	self.background_widget.style.text_controller_timer.font_size = lerp_value*10 + 75
	self.background_widget.content.text_controller_timer = math.floor(self.cancel_timer)

	return 
end
PopupJoinLobbyHandler.update_lobby = function (self, dt)
	if not self.profiles_data then
		return 
	end

	self.lobby_update_timer = self.lobby_update_timer - dt

	if 0 < self.lobby_update_timer then
		return 
	end

	local profiles_data = self.profiles_data
	local num_heroes = #SPProfiles

	for i = 1, num_heroes, 1 do
		local hero = SPProfiles[i]
		local hero_name = hero.display_name
		local hero_available = Managers.matchmaking:hero_available_in_lobby_data(i, profiles_data)
		local widget = self.button_hero_widgets[hero_name]
		widget.content.button_hotspot.disable_button = not hero_available
	end

	self.lobby_update_timer = 0.5

	return 
end
PopupJoinLobbyHandler.show = function (self, profile_name, difficulty, level, lobby_data, time_until_cancel, join_by_lobby_browser)
	fassert(self.visible == false, "trying to show PopupJoinLobbyHandler when its already visible")

	local is_host = lobby_data.host == Network.peer_id()
	self.background_widget.content.title_bar_caption = (is_host and Localize("matchmaking_host_game")) or Localize("matchmaking_join_game")
	self.button_swap_hero_widget.content.button_hotspot.on_release = false
	self.button_confirm_widget.content.button_hotspot.on_release = false
	self.button_decline_widget.content.button_hotspot.on_release = false
	self.visible = true
	local transition = (join_by_lobby_browser and "exit_menu") or "close_active"
	self.block_all_services_timer = (transition == "exit_menu" and 0.1) or 0

	self.ingame_ui:handle_transition(transition)
	ShowCursorStack.push()

	local wanted_hero_name = profile_name
	self.profiles_data = lobby_data
	self.swap_hero_active = true

	if not self.swap_hero_active then
		self.set_selected_hero(self, wanted_hero_name)
	end

	self.set_selected_level(self, level)
	self.set_selected_difficulty(self, difficulty)

	self.join_lobby_result = nil
	self.lobby_update_timer = 0
	self.popup_id = self.popup_id + 1
	self.cancel_timer = time_until_cancel

	if join_by_lobby_browser then
		self.button_decline_widget.content.text_field = "button_cancel"
	else
		self.button_decline_widget.content.text_field = "popup_keep_searching"
	end

	return self.popup_id
end
PopupJoinLobbyHandler.hide = function (self)
	local input_manager = self.input_manager

	input_manager.device_unblock_all_services(input_manager, "keyboard", 1)
	input_manager.device_unblock_all_services(input_manager, "mouse", 1)
	input_manager.device_unblock_all_services(input_manager, "gamepad", 1)
	ShowCursorStack.pop()

	self.selected_hero_name = nil
	self.profiles_data = nil
	self.visible = false

	return 
end
PopupJoinLobbyHandler.unblock_all_services = function (self)
	local input_manager = self.input_manager

	input_manager.device_unblock_all_services(input_manager, "keyboard", 1)
	input_manager.device_unblock_all_services(input_manager, "mouse", 1)
	input_manager.device_unblock_all_services(input_manager, "gamepad", 1)

	return 
end
PopupJoinLobbyHandler.update_profiles_data = function (self, profiles_data)
	self.profiles_data = profiles_data

	if Application.platform() == "win32" and not Managers.input:is_device_active("gamepad") then
		self.set_selected_hero(self, self.selected_hero_name)
	else
		self._update_controller_input_description(self)
	end

	return 
end
PopupJoinLobbyHandler.input_service = function (self)
	return self.input_manager:get_service("popup_join_lobby_handler")
end
PopupJoinLobbyHandler._update_controller_input_description = function (self)
	self.controller_selection_index = self.controller_selection_index or 1

	if not self._hero_available_by_controller(self, self.controller_selection_index) then
		self.menu_input_description:change_generic_actions(generic_input_actions.unavailable)
	else
		self.menu_input_description:change_generic_actions(generic_input_actions.default)
	end

	return 
end
PopupJoinLobbyHandler._hero_available_by_controller = function (self, controller_index)
	local hero_name = nil
	local selected_button = self.active_button_data[controller_index]

	for name, button in pairs(self.button_hero_widgets) do
		if button == selected_button then
			hero_name = name

			break
		end
	end

	local profile_slot = nil

	for idx, profile in ipairs(SPProfiles) do
		if profile.display_name == hero_name then
			profile_slot = "player_slot_" .. idx

			break
		end
	end

	return self.profiles_data[profile_slot] == "available", hero_name
end
PopupJoinLobbyHandler.draw = function (self, ui_renderer, input_service, dt)

	-- decompilation error in this vicinity
	local gamepad_active = Managers.input:is_device_active("gamepad")

	if gamepad_active and not self.gamepad_active_last_frame then
		self.setup_controller_selection(self)
	elseif not gamepad_active then
		self.gamepad_active_last_frame = false
	end

	local swap_hero_active = self.swap_hero_active

	UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self.background_widget)

	if not gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.button_decline_widget)
	end

	if not swap_hero_active then
		UIRenderer.draw_widget(ui_renderer, self.button_swap_hero_widget)
		UIRenderer.draw_widget(ui_renderer, self.selected_hero_widget)
	else
		UIRenderer.draw_widget(ui_renderer, self.swap_hero_text_widget)
	end

	if gamepad_active then
		if input_service.get(input_service, "move_right") then
			self.controller_select_button_index(self, math.clamp(self.controller_selection_index + 1, 1, #self.active_button_data), nil, true)
			self._update_controller_input_description(self)
		end

		if input_service.get(input_service, "move_left") then
			self.controller_select_button_index(self, math.clamp(self.controller_selection_index - 1, 1, #self.active_button_data), nil, false)
			self._update_controller_input_description(self)
		end

		if input_service.get(input_service, "confirm") and self.controller_select_button_index(self, self.controller_selection_index, true) then
			local hero_available, hero_name = self._hero_available_by_controller(self, self.controller_selection_index)

			if hero_available then
				local accepted = true
				self.selected_hero_name = hero_name

				self.set_result(self, accepted)
			end
		end

		if input_service.get(input_service, "back") then
			local accepted = false

			self.set_result(self, accepted)
		end
	end

	if self.button_confirm_widget.content.button_hotspot.on_release then
		local accepted = true

		self.set_result(self, accepted)
	end

	if self.button_decline_widget.content.button_hotspot.on_release or input_service.get(input_service, "toggle_menu") then
		local accepted = false

		self.set_result(self, accepted)
	end

	if swap_hero_active then
		for name, widget in pairs(self.button_hero_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)

			if widget.content.button_hotspot.on_release then
				local accepted = true
				self.selected_hero_name = name

				self.set_result(self, accepted)
			end
		end
	end

	if self.selected_hero_name then
		self.button_confirm_widget.content.button_hotspot.disable_button = false
	else
		self.button_confirm_widget.content.button_hotspot.disable_button = true
	end

	if self.button_swap_hero_widget.content.button_hotspot.on_release then
		self.button_swap_hero_widget.content.button_hotspot.on_release = false
		self.swap_hero_active = not self.swap_hero_active
	end

	UIRenderer.end_pass(ui_renderer)

	if gamepad_active then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
PopupJoinLobbyHandler.setup_controller_selection = function (self)
	local selected_index = 1

	self.setup_controller_buttons(self)

	self.gamepad_active_last_frame = true

	self.controller_select_button_index(self, selected_index, true, true)

	return 
end
PopupJoinLobbyHandler.setup_controller_buttons = function (self)
	local active_button_data = self.active_button_data

	if active_button_data then
		table.clear(active_button_data)
	else
		self.active_button_data = {}
		active_button_data = self.active_button_data
	end

	local test = hero_table

	for _, hero_data in ipairs(hero_table) do
		active_button_data[#active_button_data + 1] = self.button_hero_widgets[hero_data.name]
	end

	return 
end
PopupJoinLobbyHandler.controller_select_button_index = function (self, index, ignore_sound, increment_if_disabled)
	local selection_accepted = false
	local active_button_data = self.active_button_data
	local new_selection_data = active_button_data[index]

	if not new_selection_data or new_selection_data.content.button_hotspot.disable_button then
		local temp_data = nil

		if increment_if_disabled then
			for i = index, #active_button_data, 1 do
				local temp_data = active_button_data[i]

				if temp_data and not temp_data.content.button_hotspot.disable_button then
					new_selection_data = temp_data
					index = i

					break
				end
			end
		else
			for i = index, 1, -1 do
				temp_data = active_button_data[i]

				if not temp_data.content.button_hotspot.disable_button then
					new_selection_data = temp_data
					index = i

					break
				end
			end
		end

		if new_selection_data.content.button_hotspot.disable_button then
			return selection_accepted
		end
	end

	for i, widget in ipairs(active_button_data) do
		widget.content.button_hotspot.is_selected = i == index
		widget.content.button_hotspot.is_hover = i == index
	end

	if not ignore_sound and index ~= self.controller_selection_index then
		Managers.music:trigger_event("Play_hud_hover")
	end

	self.controller_selection_index = index
	selection_accepted = true

	return selection_accepted
end
PopupJoinLobbyHandler.set_selected_hero = function (self, selected_hero_name)
	self.swap_hero_active = false
	local profiles_data = self.profiles_data
	local hero_index = FindProfileIndex(selected_hero_name)
	local hero_available = Managers.matchmaking:hero_available_in_lobby_data(hero_index, profiles_data)
	local hero_not_available = not hero_available

	if hero_not_available then
		selected_hero_name = nil
	end

	for name, widget in pairs(self.button_hero_widgets) do
		widget.content.button_hotspot.is_selected = name == selected_hero_name
	end

	local localized_hero_name = (selected_hero_name and Localize(selected_hero_name)) or ""
	self.selected_hero_name = selected_hero_name
	local hero_texture = "unit_frame_portrait_dead"

	for index, data in ipairs(hero_table) do
		if data.name == selected_hero_name then
			hero_texture = data.texture

			break
		end
	end

	self.selected_hero_widget.content.text_hero = Localize("player_list_title_hero") .. ": " .. localized_hero_name
	self.selected_hero_widget.content.selected_hero_texture = hero_texture

	return 
end
PopupJoinLobbyHandler.set_selected_level = function (self, level_key)

	-- decompilation error in this vicinity
	local display_image, display_name = nil
	self.background_widget.content.level_texture = display_image

	return 
end
PopupJoinLobbyHandler.set_selected_difficulty = function (self, difficulty)
	local difficulty_settings = DifficultySettings[difficulty]
	local localization_key = difficulty_settings.display_name
	local display_text = Localize(localization_key)
	self.background_widget.content.text_difficulty = Localize("lorebook_difficulty") .. ": " .. display_text

	return 
end
PopupJoinLobbyHandler.set_result = function (self, accepted)
	local selected_hero_name = accepted and self.selected_hero_name
	self.join_lobby_result = {
		accepted = accepted,
		selected_hero_name = selected_hero_name
	}

	self.hide(self)

	return 
end
PopupJoinLobbyHandler.query_result = function (self)
	return self.join_lobby_result
end
PopupJoinLobbyHandler.destroy = function (self)
	rawset(_G, "GLOBAL_MM_JL_UI", nil)
	self.network_event_delegate:unregister(self)

	return 
end

return 
