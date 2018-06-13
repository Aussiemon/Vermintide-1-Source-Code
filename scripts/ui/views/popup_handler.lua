require("scripts/managers/input/mock_input_manager")
require("scripts/settings/ui_settings")
require("scripts/ui/ui_elements")
require("scripts/ui/ui_widgets")

local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.popup + 1
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
			UILayer.popup
		},
		size = {
			1920,
			1080
		}
	},
	popup_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		position = {
			0,
			100,
			1
		},
		size = {
			794,
			610
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "popup_root",
		horizontal_alignment = "center",
		position = {
			0,
			-90,
			1
		},
		size = {
			700,
			60
		}
	},
	popup_text = {
		vertical_alignment = "top",
		parent = "popup_root",
		horizontal_alignment = "center",
		position = {
			0,
			-180,
			1
		},
		size = {
			520,
			260
		}
	},
	buttons_root = {
		vertical_alignment = "bottom",
		parent = "popup_root",
		horizontal_alignment = "center",
		position = {
			0,
			83,
			1
		},
		size = {
			1,
			1
		}
	},
	button_1_1 = {
		vertical_alignment = "center",
		parent = "buttons_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			220,
			62
		}
	},
	button_2_1 = {
		vertical_alignment = "center",
		parent = "buttons_root",
		horizontal_alignment = "center",
		position = {
			-150,
			0,
			1
		},
		size = {
			220,
			62
		}
	},
	button_2_2 = {
		vertical_alignment = "center",
		parent = "buttons_root",
		horizontal_alignment = "center",
		position = {
			150,
			0,
			1
		},
		size = {
			220,
			62
		}
	},
	button_3_1 = {
		vertical_alignment = "center",
		parent = "buttons_root",
		horizontal_alignment = "center",
		position = {
			-200,
			18,
			1
		},
		size = {
			220,
			62
		}
	},
	button_3_2 = {
		vertical_alignment = "center",
		parent = "buttons_root",
		horizontal_alignment = "center",
		position = {
			0,
			-15,
			1
		},
		size = {
			220,
			62
		}
	},
	button_3_3 = {
		vertical_alignment = "center",
		parent = "buttons_root",
		horizontal_alignment = "center",
		position = {
			200,
			18,
			1
		},
		size = {
			220,
			62
		}
	},
	timer = {
		vertical_alignment = "top",
		parent = "popup_root",
		horizontal_alignment = "right"
	},
	center_timer = {
		vertical_alignment = "bottom",
		parent = "buttons_root",
		horizontal_alignment = "center",
		position = {
			0,
			100,
			1
		}
	}
}
local frame_widget = {
	scenegraph_id = "popup_root",
	element = {
		passes = {
			{
				pass_type = "texture",
				style_id = "background_tint",
				texture_id = "background_tint"
			},
			{
				pass_type = "texture",
				texture_id = "background"
			},
			{
				style_id = "text",
				pass_type = "text",
				text_id = "text_field"
			},
			{
				style_id = "topic",
				pass_type = "text",
				text_id = "topic_field"
			},
			{
				style_id = "timer",
				pass_type = "text",
				text_id = "timer_field"
			},
			{
				style_id = "center_timer",
				pass_type = "text",
				text_id = "center_timer_field"
			}
		}
	},
	content = {
		topic_field = "",
		text_start_offset = 0,
		background = "prestige_bg",
		center_timer_field = "",
		timer_field = "",
		background_tint = "gradient_dice_game_reward",
		text_field = ""
	},
	style = {
		background_tint = {
			scenegraph_id = "screen",
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
			}
		},
		text = {
			word_wrap = true,
			scenegraph_id = "popup_text",
			font_size = 28,
			pixel_perfect = true,
			horizontal_alignment = "center",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				0,
				2
			}
		},
		topic = {
			font_size = 36,
			scenegraph_id = "title_text",
			pixel_perfect = true,
			horizontal_alignment = "center",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				8,
				2
			}
		},
		timer = {
			font_size = 36,
			scenegraph_id = "timer",
			pixel_perfect = true,
			horizontal_alignment = "center",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				320,
				203,
				8
			}
		},
		center_timer = {
			vertical_alignment = "center",
			dynamic_font = true,
			font_size = 44,
			horizontal_alignment = "center",
			pixel_perfect = true,
			font_type = "hell_shark",
			scenegraph_id = "center_timer",
			text_color = Colors.get_color_table_with_alpha("white", 255)
		}
	}
}

local function create_gamepad_button(input_action, scenegraph_id)
	return {
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
					texture_id = "icon"
				}
			}
		},
		content = {
			text = "",
			input_action = input_action
		},
		style = {
			text = {
				vertical_alignment = "center",
				font_size = 24,
				font_type = "hell_shark",
				horizontal_alignment = "center",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					1
				},
				scenegraph_id = scenegraph_id
			},
			icon = {
				size = {
					34,
					34
				},
				offset = {
					0,
					15,
					1
				},
				scenegraph_id = scenegraph_id
			}
		},
		scenegraph_id = scenegraph_id
	}
end

PopupHandler = class(PopupHandler)

PopupHandler.init = function (self, context, from_manager)
	fassert(from_manager, "Not created by the popoup manager")

	self.ui_renderer = context.ui_renderer
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.wwise_world = Managers.world:wwise_world(context.world)
	self.debug_num_updates = 0
	self.popup_results = {}
	self.popups = {}
	self.n_popups = 0
	self.popup_ids = 0

	self:create_ui_elements()

	self.gamepad_button_colors = {
		enabled = Colors.get_color_table_with_alpha("white", 255),
		disabled = Colors.get_color_table_with_alpha("gray", 255)
	}
	self.unblocked_services = {}
	self.unblocked_services_n = 0
	self.mock_input_manager = MockInputManager:new()
end

PopupHandler.set_input_manager = function (self, input_manager)
	self.input_manager = input_manager

	input_manager:create_input_service("popup", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager:map_device_to_service("popup", "keyboard")
	input_manager:map_device_to_service("popup", "mouse")
	input_manager:map_device_to_service("popup", "gamepad")

	if self:has_popup() then
		self:acquire_input()
	end
end

PopupHandler.get_input_manager = function (self)
	return self.input_manager
end

PopupHandler.remove_input_manager = function (self, application_shutdown)
	if self:has_popup() then
		self:release_input()
	end

	if not application_shutdown and self:has_popup() then
		local popup_id, popup = self:active_popup()

		error(string.format("Trying to proceed to next gamestate without handling popup %q: %q", popup.topic or "nil", popup.text or "nil"))
	end

	self.input_manager = nil
end

PopupHandler.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self.frame_widget = UIWidget.init(frame_widget)
	local button_widgets = {
		{},
		{},
		{}
	}
	local gamepad_button_widgets = {
		{},
		{},
		{}
	}
	local disable_localization = true
	button_widgets[1][1] = UIWidget.init(UIWidgets.create_menu_button_medium("", "button_1_1", disable_localization))
	button_widgets[2][1] = UIWidget.init(UIWidgets.create_menu_button_medium("", "button_2_1", disable_localization))
	button_widgets[2][2] = UIWidget.init(UIWidgets.create_menu_button_medium("", "button_2_2", disable_localization))
	button_widgets[3][1] = UIWidget.init(UIWidgets.create_menu_button_medium("", "button_3_1", disable_localization))
	button_widgets[3][2] = UIWidget.init(UIWidgets.create_menu_button_medium("", "button_3_2", disable_localization))
	button_widgets[3][3] = UIWidget.init(UIWidgets.create_menu_button_medium("", "button_3_3", disable_localization))
	gamepad_button_widgets[1][1] = UIWidget.init(create_gamepad_button("confirm", "button_1_1"))
	gamepad_button_widgets[2][1] = UIWidget.init(create_gamepad_button("confirm", "button_2_1"))
	gamepad_button_widgets[2][2] = UIWidget.init(create_gamepad_button("back", "button_2_2"))
	gamepad_button_widgets[3][1] = UIWidget.init(create_gamepad_button("confirm", "button_3_1"))
	gamepad_button_widgets[3][2] = UIWidget.init(create_gamepad_button("back", "button_3_2"))
	gamepad_button_widgets[3][3] = UIWidget.init(create_gamepad_button("refresh", "button_3_3"))
	self.button_widgets = button_widgets
	self.gamepad_button_widgets = gamepad_button_widgets
end

PopupHandler.acquire_input = function (self, ignore_cursor_stack)
	local input_manager = self.input_manager

	self:release_input(true)

	self.unblocked_services_n = input_manager:get_unblocked_services(nil, nil, self.unblocked_services)

	input_manager:device_block_services("keyboard", 1, self.unblocked_services, self.unblocked_services_n, "popup")
	input_manager:device_block_services("gamepad", 1, self.unblocked_services, self.unblocked_services_n, "popup")
	input_manager:device_block_services("mouse", 1, self.unblocked_services, self.unblocked_services_n, "popup")
	input_manager:device_unblock_service("keyboard", 1, "popup")
	input_manager:device_unblock_service("gamepad", 1, "popup")
	input_manager:device_unblock_service("mouse", 1, "popup")

	if not ignore_cursor_stack then
		ShowCursorStack.push()
	end
end

PopupHandler.release_input = function (self, ignore_cursor_stack)
	local input_manager = self.input_manager

	input_manager:device_block_service("keyboard", 1, "popup")
	input_manager:device_block_service("gamepad", 1, "popup")
	input_manager:device_block_service("mouse", 1, "popup")
	input_manager:device_unblock_services("keyboard", 1, self.unblocked_services, self.unblocked_services_n)
	input_manager:device_unblock_services("gamepad", 1, self.unblocked_services, self.unblocked_services_n)
	input_manager:device_unblock_services("mouse", 1, self.unblocked_services, self.unblocked_services_n)
	table.clear(self.unblocked_services)

	self.unblocked_services_n = 0

	if not ignore_cursor_stack then
		ShowCursorStack.pop()
	end
end

PopupHandler.update = function (self, dt, from_manager)
	fassert(from_manager, "Update does not come from the popup manager")

	self.debug_num_updates = self.debug_num_updates + 1
	local n_popups = self.n_popups
	local current_popup = self.popups[n_popups]

	if current_popup then
		local ui_renderer = self.ui_renderer
		local input_manager = self.input_manager or self.mock_input_manager
		local input_service = input_manager:get_service("popup")
		local gamepad_active = input_manager:is_device_active("gamepad")
		local frame_widget = self.frame_widget
		frame_widget.style.text.font_size = current_popup.text_font_size
		frame_widget.content.text_field = current_popup.text
		frame_widget.content.topic_field = current_popup.topic
		local result = nil

		if current_popup.timer then
			local timer = string.format("%d", math.floor(current_popup.timer))

			if current_popup.timer_format_func then
				timer = current_popup.timer_format_func(timer)
			end

			local timer_field, timer_style = nil

			if current_popup.timer_alignment == "center" then
				frame_widget.content.center_timer_field = timer
				timer_style = frame_widget.style.center_timer
			else
				frame_widget.content.timer_field = timer
				timer_style = frame_widget.style.timer
			end

			if current_popup.timer_font_size then
				frame_widget.style.timer.font_size = current_popup.timer_font_size
				frame_widget.style.center_timer.font_size = current_popup.timer_font_size
			end

			if current_popup.timer_blink then
				timer_style.font_size = 40 + 20 * math.smoothstep(current_popup.timer % 1, 0, 1)
				timer_style.text_color = Colors.lerp_color_tables(Colors.get_color_table_with_alpha("white", 255), Colors.get_color_table_with_alpha("cheeseburger", 255), current_popup.timer % 15 % 1)
			end

			current_popup.timer = current_popup.timer - dt

			if current_popup.timer <= 0 then
				result = current_popup.default_result
			end
		else
			frame_widget.content.timer_field = ""
			frame_widget.content.center_timer_field = ""
			frame_widget.style.timer.font_size = 36
			frame_widget.style.center_timer.font_size = 44
		end

		UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt, nil, self.render_settings)
		UIRenderer.draw_widget(ui_renderer, self.frame_widget)

		local n_args = current_popup.n_args
		local args = current_popup.args
		local buttons = self.button_widgets[n_args]
		local gamepad_buttons = self.gamepad_button_widgets[n_args]

		for i = 1, n_args, 1 do
			local button_text = " " .. args[i * 2]
			local button_enabled = current_popup.button_enabled_state[i] == true

			if gamepad_active then
				local gamepad_button = gamepad_buttons[i]
				local button_content = gamepad_button.content
				local input_action = button_content.input_action

				if not button_content.icon then
					local action_texture_data = self:get_gamepad_input_texture_data(input_service, input_action)
					button_content.icon = action_texture_data.texture
				end

				button_content.text = button_text
				local button_style = gamepad_button.style
				local text_style = button_style.text
				text_style.text_color = (button_enabled and self.gamepad_button_colors.enabled) or self.gamepad_button_colors.disabled
				local font, scaled_font_size = UIFontByResolution(text_style)
				local text_width, text_height, min = UIRenderer.text_size(ui_renderer, button_text, font[1], scaled_font_size)
				button_style.icon.offset[1] = 80 - text_width * 0.5

				UIRenderer.draw_widget(ui_renderer, gamepad_button)

				if input_service:get(input_action, true) then
					result = args[i * 2 - 1]

					self:play_sound("Play_hud_select")
				end
			else
				local button = buttons[i]
				button.content.text_field = button_text
				local button_hotspot = button.content.button_hotspot
				button_hotspot.disabled = not button_enabled

				UIRenderer.draw_widget(ui_renderer, button)

				if button_hotspot.on_hover_enter then
					self:play_sound("Play_hud_hover")
				end

				if button_hotspot.on_release then
					table.clear(button.content.button_hotspot)

					result = args[i * 2 - 1]

					self:play_sound("Play_hud_select")
				end
			end
		end

		if result then
			self.popup_results[current_popup.popup_id] = result
			n_popups = n_popups - 1
			self.n_popups = n_popups

			if n_popups == 0 then
				self:release_input()
			end
		end

		UIRenderer.end_pass(ui_renderer)
	end
end

PopupHandler.get_gamepad_input_texture_data = function (self, input_service, input_action, ignore_keybinding)
	local platform = PLATFORM

	if platform == "win32" then
		platform = "xb1"
	end

	if ignore_keybinding then
		return ButtonTextureByName(input_action, platform)
	else
		return UISettings.get_gamepad_input_texture_data(input_service, input_action, true)
	end
end

PopupHandler.set_button_enabled = function (self, popup_id, button_index, enabled)
	local popup = nil

	for i = 1, self.n_popups, 1 do
		local temp_popup = self.popups[i]

		if temp_popup.popup_id == popup_id then
			popup = temp_popup
		end
	end

	popup.button_enabled_state[button_index] = enabled
end

PopupHandler.active_popup = function (self)
	local popup = self.popups[self.n_popups]

	if popup then
		return popup.popup_id, popup
	end
end

PopupHandler.queue_popup = function (self, text, topic, ...)
	local n_popups = self.n_popups
	local popups = self.popups
	n_popups = n_popups + 1
	self.n_popups = n_popups

	if not popups[n_popups] then
		local new_popup = {
			args = {}
		}
	end

	self.popup_ids = self.popup_ids + 1
	local popup_id = tostring(self.popup_ids)
	new_popup.popup_id = popup_id
	local frame_widget = self.frame_widget
	local text_style = frame_widget.style.text
	local scaled_text_field_size = UIScaleVectorToResolution(scenegraph_definition.popup_text.size)
	local number_of_text_rows = self:get_number_of_rows(text, text_style, scaled_text_field_size[1])
	new_popup.text_font_size = (number_of_text_rows >= 7 and 20) or 28
	new_popup.text = text
	new_popup.topic = topic
	local n_args = select("#", ...)

	assert(math.floor(n_args / 2) * 2 == n_args, "Need one action for each button text")
	assert(n_args > 0, "Need at least one button...")

	new_popup.n_args = n_args / 2
	new_popup.button_enabled_state = {}

	for i = 1, new_popup.n_args, 1 do
		new_popup.button_enabled_state[i] = true
	end

	new_popup.timer = nil
	new_popup.default_result = nil

	pack_index[n_args](new_popup.args, 1, ...)

	local ignore_cursor_stack = n_popups > 1

	if self.input_manager then
		self:acquire_input(ignore_cursor_stack)
	end

	popups[n_popups] = new_popup

	return popup_id
end

PopupHandler.activate_timer = function (self, popup_id, time, default_result, alignment, blink, optional_timer_format_func, optional_font_size)
	local n_popups = self.n_popups
	local popups = self.popups
	local popup = nil

	for i = 1, n_popups, 1 do
		local temp_popup = popups[i]

		if temp_popup.popup_id == popup_id then
			popup = temp_popup
		end
	end

	assert(popup, string.format("[PopupHandler:activate_timer] There is no popup with id %s", popup_id))

	local index = nil

	for idx, value in ipairs(popup.args) do
		if value == default_result then
			index = idx

			break
		end
	end

	if default_result == "timeout" then
		index = 1
	end

	assert(index, string.format("[PopupHandler:activate_timer] There is no result named %s in popup declaration %s", default_result, popup.topic))
	assert(index % 2 == 1, string.format("[PopupHandler:activate_timer] You need to pass the result - not the text %s in popup declaration %s", default_result, popup.topic))

	popup.timer = time
	popup.default_result = default_result
	popup.timer_alignment = alignment or "right"
	popup.timer_blink = (blink == nil and true) or blink
	popup.timer_format_func = optional_timer_format_func
	popup.timer_font_size = optional_font_size
end

PopupHandler.has_popup = function (self)
	return self.n_popups > 0
end

PopupHandler.has_popup_with_id = function (self, popup_id)
	for _, popup in pairs(self.popups) do
		if popup.popup_id == popup_id then
			return true
		end
	end

	return false
end

PopupHandler.cancel_popup = function (self, popup_id)
	local n_popups = self.n_popups
	local popups = self.popups

	for i = 1, n_popups, 1 do
		local popup = popups[i]

		if popup.popup_id == popup_id then
			local temp = popups[n_popups]
			popups[n_popups] = popup
			popups[i] = temp
			self.n_popups = n_popups - 1

			if self.n_popups == 0 then
				self:release_input()
			end

			return
		end
	end
end

PopupHandler.cancel_all_popups = function (self)
	local n_popups = self.n_popups
	local popups = self.popups

	for i = 1, n_popups, 1 do
		popups[i] = nil
	end

	if n_popups > 0 then
		self:release_input()
	end

	self.n_popups = 0
end

PopupHandler.query_result = function (self, popup_id)
	local result = self.popup_results[popup_id]
	self.popup_results[popup_id] = nil

	return result
end

PopupHandler.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

PopupHandler.fit_text_width_to_popup = function (self, text)
	return UIRenderer.crop_text_width(self.ui_renderer, text, 500, self.frame_widget.style.text)
end

PopupHandler.get_number_of_rows = function (self, localized_text, text_style, text_area_width)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local lines = UIRenderer.word_wrap(self.ui_renderer, localized_text, font[1], scaled_font_size, text_area_width)

	return #lines
end

return
