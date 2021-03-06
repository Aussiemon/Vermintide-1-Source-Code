-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- Decompilation Error: _run_step(_unwarp_expressions, node)

-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
require("scripts/ui/views/ui_calibration_view")

OptionsView = class(OptionsView)
local definitions = local_require("scripts/ui/views/options_view_definitions")
local settings_definitions = local_require("scripts/ui/views/options_view_settings")
local gamepad_frame_widget_definitions = definitions.gamepad_frame_widget_definitions
local background_widget_definitions = definitions.background_widget_definitions
local widget_definitions = definitions.widget_definitions
local title_button_definitions = settings_definitions.title_button_definitions
local button_definitions = definitions.button_definitions
local child_input_services = definitions.child_input_services
local SettingsMenuNavigation = SettingsMenuNavigation
local SettingsWidgetTypeTemplate = SettingsWidgetTypeTemplate

local function get_slider_value(min, max, value)
	local range = max - min
	local norm_value = math.clamp(value, min, max) - min

	return norm_value / range
end

local function assigned(a, b)
	if a == nil then
		return b
	else
		return a
	end
end

local generic_input_actions = {
	main_menu = {
		default = {
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_select"
			},
			{
				input_action = "back",
				priority = 50,
				description_text = "input_description_close"
			}
		},
		reset = {
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_reset"
			},
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_select"
			},
			{
				input_action = "back",
				priority = 50,
				description_text = "input_description_close"
			}
		},
		reset_and_apply = {
			{
				input_action = "special_1",
				priority = 47,
				description_text = "input_description_reset"
			},
			{
				input_action = "refresh",
				priority = 48,
				description_text = "input_description_apply"
			},
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_select"
			},
			{
				input_action = "back",
				priority = 50,
				description_text = "input_description_close"
			}
		},
		apply = {
			{
				input_action = "refresh",
				priority = 49,
				description_text = "input_description_apply"
			},
			{
				input_action = "back",
				priority = 50,
				description_text = "input_description_close"
			}
		}
	},
	sub_menu = {
		default = {
			{
				input_action = "cycle_previous",
				priority = 49,
				description_text = "input_description_information"
			},
			{
				input_action = "back",
				priority = 50,
				description_text = "input_description_back"
			}
		},
		reset = {
			{
				input_action = "cycle_previous",
				priority = 48,
				description_text = "input_description_information"
			},
			{
				input_action = "special_1",
				priority = 49,
				description_text = "input_description_reset"
			},
			{
				input_action = "back",
				priority = 50,
				description_text = "input_description_back"
			}
		},
		reset_and_apply = {
			{
				input_action = "cycle_previous",
				priority = 47,
				description_text = "input_description_information"
			},
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_reset"
			},
			{
				input_action = "refresh",
				priority = 49,
				description_text = "input_description_apply"
			},
			{
				input_action = "back",
				priority = 50,
				description_text = "input_description_back"
			}
		},
		apply = {
			{
				input_action = "cycle_previous",
				priority = 48,
				description_text = "input_description_information"
			},
			{
				input_action = "refresh",
				priority = 49,
				description_text = "input_description_apply"
			},
			{
				input_action = "back",
				priority = 50,
				description_text = "input_description_back"
			}
		}
	}
}
local disabled_mouse_input_table = {
	activate_chat_input = {
		"left",
		"right",
		"left_double",
		"right_double"
	}
}

local function mouse_input_allowed(content_actions, mouse_input)
	for _, content_action in ipairs(content_actions) do
		local disabled_mouse_inputs = disabled_mouse_input_table[content_action]

		if disabled_mouse_inputs then
			for _, disabled_mouse_input in ipairs(disabled_mouse_inputs) do
				if disabled_mouse_input == mouse_input then
					return false
				end
			end
		end
	end

	return true
end

OptionsView.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.level_transition_handler = ingame_ui_context.level_transition_handler
	self.voip = ingame_ui_context.voip
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.platform = PLATFORM
	local input_manager = ingame_ui_context.input_manager

	input_manager:create_input_service("options_menu", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager:map_device_to_service("options_menu", "keyboard")
	input_manager:map_device_to_service("options_menu", "mouse")
	input_manager:map_device_to_service("options_menu", "gamepad")

	self.input_manager = input_manager
	self.controller_cooldown = 0
	local world = ingame_ui_context.world_manager:world("music_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.ui_animations = {}

	self:reset_changed_settings()
	self:create_ui_elements()

	local input_service = input_manager:get_service("options_menu")
	local gui_layer = definitions.scenegraph_definition.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 6, gui_layer, generic_input_actions.main_menu.reset)
	self._input_functions = {
		checkbox = function (widget, input_source)
			if widget.content.hotspot.on_release then
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
				widget.content.callback(widget.content)
			end
		end,
		slider = function (widget, input_source)
			if widget.content.changed then
				widget.content.changed = nil

				widget.content.callback(widget.content)
			end

			if not input_source:get("left_hold") then
				widget.content.altering_value = nil
			else
				widget.content.altering_value = true
			end
		end,
		drop_down = function (widget, input_source)
			local content = widget.content
			local style = widget.style

			if not content.active then
				local hotspot = content.hotspot

				if hotspot.on_hover_enter then
					WwiseWorld.trigger_event(self.wwise_world, "Play_hud_hover")
				end

				if hotspot.on_release then
					content.active = true
					style.list_style.active = true
					self.disable_all_input = true

					WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
				end
			else
				local list_style = style.list_style
				local item_contents = content.list_content
				local item_styles = list_style.item_styles
				local num_draws = list_style.num_draws
				local options_texts = content.options_texts

				for i = 1, num_draws, 1 do
					local item_content = item_contents[i]
					local hotspot = item_content.hotspot

					if hotspot.on_hover_enter then
						WwiseWorld.trigger_event(self.wwise_world, "Play_hud_hover")
					end

					if hotspot.on_release then
						WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")

						content.current_selection = i

						content:callback()

						content.active = false
						list_style.active = false
						self.disable_all_input = false

						break
					end
				end

				if content.active and input_source:get("left_release") then
					content.active = false
					list_style.active = false
					self.disable_all_input = false

					WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
				end
			end
		end,
		stepper = function (widget, input_source)
			local content = widget.content
			local current_selection = content.current_selection or 0
			local new_selection = current_selection
			local left_hotspot = content.left_hotspot
			local right_hotspot = content.right_hotspot

			if left_hotspot.on_release or content.controller_on_release_left then
				content.controller_on_release_left = nil
				new_selection = new_selection - 1

				if new_selection == 0 then
					new_selection = content.num_options
				end
			end

			if right_hotspot.on_release or content.controller_on_release_right then
				content.controller_on_release_right = nil
				new_selection = new_selection + 1

				if content.num_options < new_selection then
					new_selection = 1
				end
			end

			if new_selection ~= current_selection then
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")

				content.current_selection = new_selection

				content:callback()
			end
		end,
		keybind = function (widget, input_source)
			local content = widget.content

			if not content.active then
				if content.hotspot.on_release then
					content.active = true
					content.active_t = 0
					self.disable_all_input = true

					self.input_manager:block_device_except_service("options_menu", "keyboard", 1, "keybind")
					self.input_manager:block_device_except_service("options_menu", "mouse", 1, "keybind")
					self.input_manager:block_device_except_service("options_menu", "gamepad", 1, "keybind")
					WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
				end
			else
				local stop = false

				if content.controller_input_pressed then
					stop = true
				end

				local button = Keyboard.any_released()

				if not stop and button == 27 then
					stop = true
				end

				if not stop and button ~= nil then
					local new_key = Keyboard.button_name(button)

					if new_key and new_key ~= "" then
						content.callback(new_key, "keyboard", content)

						stop = true
					end
				end

				button = Mouse.any_released()

				if not stop and button ~= nil then
					local new_key = Mouse.button_name(button)
					local input_allowed = mouse_input_allowed(content.actions, new_key)

					if input_allowed then
						content.callback(new_key, "mouse", content)

						stop = true
					end
				end

				if stop then
					content.controller_input_pressed = nil
					content.active = false
					self.disable_all_input = false

					self.input_manager:device_unblock_all_services("keyboard", 1)
					self.input_manager:device_unblock_all_services("mouse", 1)
					self.input_manager:device_unblock_all_services("gamepad", 1)
					self.input_manager:block_device_except_service("options_menu", "keyboard", 1)
					self.input_manager:block_device_except_service("options_menu", "mouse", 1)
					self.input_manager:block_device_except_service("options_menu", "gamepad", 1)
				end
			end
		end,
		image = function ()
			return
		end,
		gamepad_layout = function ()
			return
		end
	}
end

OptionsView.input_service = function (self)
	return self.input_manager:get_service("options_menu")
end

OptionsView.cleanup_popups = function (self)
	if self.save_data_error_popup_id then
		Managers.popup:cancel_popup(self.save_data_error_popup_id)

		self.save_data_error_popup_id = nil
	end

	if self.apply_popup_id then
		Managers.popup:cancel_popup(self.apply_popup_id)

		self.apply_popup_id = nil

		self:handle_apply_popup_results("revert_changes")
	end

	if self.save_error_popup_id then
		Managers.popup:cancel_popup(self.save_error_popup_id)

		self.save_error_popup_id = nil
	end

	if self.title_popup_id then
		Managers.popup:cancel_popup(self.title_popup_id)

		self.title_popup_id = nil
	end

	if self.exit_popup_id then
		Managers.popup:cancel_popup(self.exit_popup_id)

		self.exit_popup_id = nil
	end
end

OptionsView.suspend = function (self)
	self.suspended = true

	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)
	self:cleanup_popups()
end

OptionsView.unsuspend = function (self)
	if Managers.chat:chat_is_focused() then
		Managers.chat.chat_gui:block_input()
	else
		self.input_manager:block_device_except_service("options_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("options_menu", "mouse", 1)
		self.input_manager:block_device_except_service("options_menu", "gamepad", 1)
	end

	self.suspended = nil
end

OptionsView.destroy = function (self)
	self:cleanup_popups()
	self.menu_input_description:destroy()

	self.menu_input_description = nil

	GarbageLeakDetector.register_object(self, "OptionsView")
end

RELOAD_OPTIONS_VIEW = true

OptionsView.create_ui_elements = function (self)
	self.background_widgets = {}
	local background_widgets_n = 0

	for name, definition in pairs(background_widget_definitions) do
		background_widgets_n = background_widgets_n + 1
		self.background_widgets[background_widgets_n] = UIWidget.init(definition)

		if name == "right_frame" then
			self.scroll_field_widget = self.background_widgets[background_widgets_n]
		end
	end

	self.background_widgets_n = background_widgets_n
	self.left_frame_glow_widget = UIWidget.init(gamepad_frame_widget_definitions.left_frame_glow)
	self.right_frame_glow_widget = UIWidget.init(gamepad_frame_widget_definitions.right_frame_glow)
	self.gamepad_tooltip_text_widget = UIWidget.init(gamepad_frame_widget_definitions.gamepad_tooltip_text)
	self.gamepad_reset_text_widget = UIWidget.init(gamepad_frame_widget_definitions.gamepad_reset_text)
	self.gamepad_button_selection_widget = UIWidget.init(gamepad_frame_widget_definitions.gamepad_button_selection)
	self.title_buttons = {}
	local title_buttons_n = 0

	for i, definition in ipairs(title_button_definitions) do
		title_buttons_n = title_buttons_n + 1
		self.title_buttons[title_buttons_n] = UIWidget.init(definition)
	end

	self.title_buttons_n = title_buttons_n
	self.exit_button = UIWidget.init(button_definitions.exit_button)
	self.apply_button = UIWidget.init(button_definitions.apply_button)
	self.reset_to_default = UIWidget.init(button_definitions.reset_to_default)
	self.scrollbar = UIWidget.init(definitions.scrollbar_definition)
	self.scrollbar.content.disable_frame = true
	local calibrate_ui_settings_list_dummy = {
		hide_reset = true,
		widgets_n = 0,
		scenegraph_id_start = "calibrate_ui_dummy",
		widgets = {}
	}
	local settings_lists = {}

	if PLATFORM == "win32" then
		if rawget(_G, "Tobii") then
			settings_lists.tobii_eyetracking_settings = self:build_settings_list(settings_definitions.tobii_settings_definition, "tobii_eyetracking_settings_list")
		end

		settings_lists.video_settings = self:build_settings_list(settings_definitions.video_settings_definition, "video_settings_list")
		settings_lists.audio_settings = self:build_settings_list(settings_definitions.audio_settings_definition, "audio_settings_list")
		settings_lists.gameplay_settings = self:build_settings_list(settings_definitions.gameplay_settings_definition, "gameplay_settings_list")
		settings_lists.display_settings = self:build_settings_list(settings_definitions.display_settings_definition, "display_settings_list")
		settings_lists.keybind_settings = self:build_settings_list(settings_definitions.keybind_settings_definition, "keybind_settings_list")
		settings_lists.gamepad_settings = self:build_settings_list(settings_definitions.gamepad_settings_definition, "gamepad_settings_list")
		settings_lists.video_settings.hide_reset = true
		settings_lists.video_settings.needs_apply_confirmation = true
	else
		if (Managers.voice_chat and Managers.voice_chat:initiated()) or self.voip then
			settings_lists.audio_settings = self:build_settings_list(settings_definitions.audio_settings_definition, "audio_settings_list")
		else
			settings_lists.audio_settings = self:build_settings_list(settings_definitions.audio_settings_definition_without_voip, "audio_settings_list")
		end

		settings_lists.gameplay_settings = self:build_settings_list(settings_definitions.gameplay_settings_definition, "gameplay_settings_list")
		settings_lists.display_settings = self:build_settings_list(settings_definitions.display_settings_definition, "display_settings_list")
		settings_lists.gamepad_settings = self:build_settings_list(settings_definitions.gamepad_settings_definition, "gamepad_settings_list")
	end

	self.settings_lists = settings_lists
	self.selected_widget = nil
	self.selected_title = nil
	self.dead_space_4k_filler = UIWidget.init(UIWidgets.create_4k_filler())
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.ui_calibration_view = UICalibrationView:new()
	RELOAD_OPTIONS_VIEW = false
end

OptionsView.build_settings_list = function (self, definition, scenegraph_id)
	local scenegraph_definition = definitions.scenegraph_definition
	local scenegraph_id_start = scenegraph_id .. "start"
	local list_size_y = 0
	local widgets = {}
	local widgets_n = 0
	local definition_n = #definition

	for i = 1, definition_n, 1 do
		local element = definition[i]
		local base_offset = {
			0,
			-list_size_y,
			0
		}
		local widget = nil
		local size_y = 0
		local widget_type = element.widget_type

		if widget_type == "drop_down" then
			widget = self:build_drop_down_widget(element, scenegraph_id_start, base_offset)
		elseif widget_type == "slider" then
			widget = self:build_slider_widget(element, scenegraph_id_start, base_offset)
		elseif widget_type == "checkbox" then
			widget = self:build_checkbox_widget(element, scenegraph_id_start, base_offset)
		elseif widget_type == "stepper" then
			widget = self:build_stepper_widget(element, scenegraph_id_start, base_offset)
		elseif widget_type == "keybind" then
			widget = self:build_keybind_widget(element, scenegraph_id_start, base_offset)
		elseif widget_type == "image" then
			widget = self:build_image(element, scenegraph_id_start, base_offset)
		elseif widget_type == "gamepad_layout" then
			widget = self:build_gamepad_layout(element, scenegraph_id_start, base_offset)
			self.gamepad_layout_widget = widget
			local using_left_handed_option = assigned(self.changed_user_settings.gamepad_left_handed, Application.user_setting("gamepad_left_handed"))

			self:update_gamepad_layout_widget(DefaultGamepadLayoutKeymaps, using_left_handed_option)
		elseif widget_type == "empty" then
			size_y = element.size_y
		else
			error("[OptionsView] Unsupported widget type")
		end

		if widget then
			local name = element.callback
			size_y = widget.style.size[2]
			widget.type = widget_type
			widget.name = name
			widget.ui_animations = {}
		end

		list_size_y = list_size_y + size_y

		if widget then
			if element.name then
				widget.name = element.name
			end

			widgets_n = widgets_n + 1
			widgets[widgets_n] = widget
		end
	end

	local mask_size = scenegraph_definition.list_mask.size
	local size_x = mask_size[1]
	scenegraph_definition[scenegraph_id] = {
		vertical_alignment = "top",
		parent = "list_mask",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			-1
		},
		offset = {
			0,
			0,
			0
		},
		size = {
			size_x,
			list_size_y
		}
	}
	scenegraph_definition[scenegraph_id_start] = {
		vertical_alignment = "top",
		horizontal_alignment = "left",
		parent = scenegraph_id,
		position = {
			30,
			0,
			10
		},
		size = {
			1,
			1
		}
	}
	local scrollbar = false
	local max_offset_y = 0

	if mask_size[2] < list_size_y then
		scrollbar = true
		max_offset_y = list_size_y - mask_size[2]
	end

	local widget_list = {
		visible_widgets_n = 0,
		scenegraph_id = scenegraph_id,
		scenegraph_id_start = scenegraph_id_start,
		scrollbar = scrollbar,
		max_offset_y = max_offset_y,
		widgets = widgets,
		widgets_n = widgets_n
	}

	return widget_list
end

OptionsView.make_callback = function (self, callback_name)
	local function new_callback(...)
		self[callback_name](self, ...)

		local changed_user_settings = self.changed_user_settings
		local original_user_settings = self.original_user_settings

		for setting, value in pairs(changed_user_settings) do
			if not original_user_settings[setting] then
				original_user_settings[setting] = Application.user_setting(setting)
			end

			if value == original_user_settings[setting] then
				changed_user_settings[setting] = nil
			end
		end

		local changed_render_settings = self.changed_render_settings
		local original_render_settings = self.original_render_settings

		for setting, value in pairs(self.changed_render_settings) do
			if not original_render_settings[setting] then
				original_render_settings[setting] = Application.user_setting("render_settings", setting)
			end

			if value == original_render_settings[setting] then
				changed_render_settings[setting] = nil
			end
		end
	end

	return new_callback
end

OptionsView.build_stepper_widget = function (self, element, scenegraph_id, base_offset)
	local callback_name = element.callback
	local callback_func = self:make_callback(callback_name)
	local saved_value_cb_name = element.saved_value
	local saved_value_cb = callback(self, saved_value_cb_name)
	local setup_name = element.setup
	local selected_option, options, text, default_value = self[setup_name](self)
	local widget = definitions.create_stepper_widget(text, options, selected_option, element.tooltip_text, scenegraph_id, base_offset)
	local content = widget.content
	content.callback = callback_func
	content.saved_value_cb = saved_value_cb
	content.on_hover_enter_callback = callback(self, "on_stepper_arrow_hover", widget)
	content.on_hover_exit_callback = callback(self, "on_stepper_arrow_dehover", widget)
	content.on_pressed_callback = callback(self, "on_stepper_arrow_pressed", widget)
	content.default_value = default_value

	return widget
end

OptionsView.build_drop_down_widget = function (self, element, scenegraph_id, base_offset)
	local callback_name = element.callback
	local callback_func = self:make_callback(callback_name)
	local saved_value_cb_name = element.saved_value
	local saved_value_cb = callback(self, saved_value_cb_name)
	local setup_name = element.setup
	local selected_option, options, text, default_value = self[setup_name](self)
	local widget = definitions.create_drop_down_widget(text, options, selected_option, element.tooltip_text, scenegraph_id, base_offset)
	local content = widget.content
	content.callback = callback_func
	content.saved_value_cb = saved_value_cb
	content.default_value = default_value

	return widget
end

OptionsView.build_slider_widget = function (self, element, scenegraph_id, base_offset)
	local callback_name = element.callback
	local callback_func = self:make_callback(callback_name)
	local saved_value_cb_name = element.saved_value
	local saved_value_cb = callback(self, saved_value_cb_name)
	local setup_name = element.setup
	local slider_image = element.slider_image
	local value, min, max, num_decimals, text, default_value = self[setup_name](self)

	fassert(type(value) == "number", "Value type is wrong, need number, got %q", type(value))

	local widget = definitions.create_slider_widget(text, element.tooltip_text, scenegraph_id, base_offset, slider_image)
	local content = widget.content
	content.min = min
	content.max = max
	content.internal_value = value
	content.num_decimals = num_decimals
	content.callback = callback_func
	content.saved_value_cb = saved_value_cb
	content.default_value = default_value

	return widget
end

OptionsView.build_image = function (self, element, scenegraph_id, base_offset)
	local widget = definitions.create_simple_texture_widget(element.image, element.image_size, scenegraph_id, base_offset)
	local content = widget.content

	content.callback = function ()
		return
	end

	content.saved_value_cb = function ()
		return
	end

	content.disabled = true

	return widget
end

OptionsView.clear_gamepad_layout_widget = function (self)
	local using_left_handed_option = assigned(self.changed_user_settings.gamepad_left_handed, Application.user_setting("gamepad_left_handed"))
	local default_gamepad_actions_by_key = (using_left_handed_option and AlternatateGamepadSettings.left_handed.default_gamepad_actions_by_key) or AlternatateGamepadSettings.default.default_gamepad_actions_by_key
	local widget = self.gamepad_layout_widget
	local widget_content = widget.content
	local background_texture = widget_content.background
	local background1_texture = widget_content.background1
	local background2_texture = widget_content.background2
	local saved_value_cb = widget_content.saved_value_cb

	table.clear(widget_content)

	widget_content.background = background_texture
	widget_content.background1 = background1_texture
	widget_content.background2 = background2_texture
	widget_content.saved_value_cb = saved_value_cb

	if PLATFORM == "win32" then
		local gamepad_use_ps4_style_input_icons = assigned(self.changed_user_settings.gamepad_use_ps4_style_input_icons, Application.user_setting("gamepad_use_ps4_style_input_icons"))
		widget_content.use_texture2_layout = gamepad_use_ps4_style_input_icons
	end

	for input_key, action_name in pairs(default_gamepad_actions_by_key) do
		widget_content[input_key] = Localize(action_name)
	end
end

OptionsView.update_gamepad_layout_widget = function (self, keymaps, using_left_handed_option)
	local widget = self.gamepad_layout_widget
	local widget_content = widget.content
	local display_keybinds = {}

	self:clear_gamepad_layout_widget()

	local ignore_gamepad_action_names = (using_left_handed_option and AlternatateGamepadSettings.left_handed.ignore_gamepad_action_names) or AlternatateGamepadSettings.default.ignore_gamepad_action_names

	for keymaps_table_name, keymaps_table in pairs(keymaps) do
		for keybindings_name, keybindings in pairs(keymaps_table) do
			for action_name, keybind in pairs(keybindings) do
				repeat
					if not settings_definitions.ignore_keybind[action_name] then
						if ignore_gamepad_action_names and ignore_gamepad_action_names[action_name] then
							break
						end

						local num_variables = #keybind

						if num_variables < 3 then
							break
						end

						local button_name = keybind[2]
						local actions = display_keybinds[button_name] or {}
						display_keybinds[button_name] = actions
						actions[#actions + 1] = action_name
					end
				until true
			end
		end
	end

	for button_name, actions in pairs(display_keybinds) do
		for i = 1, #actions, 1 do
			local action_name = actions[i]

			if not widget_content[button_name] then
				widget_content[button_name] = Localize(action_name)
			else
				local display_text = widget_content[button_name] .. "/" .. Localize(action_name)
				widget_content[button_name] = display_text
			end
		end
	end
end

OptionsView.build_gamepad_layout = function (self, element, scenegraph_id, base_offset)
	local widget = definitions.create_gamepad_layout_widget(element.bg_image, element.bg_image_size, element.bg_image2, element.bg_image_size2, scenegraph_id, base_offset)
	local widget_content = widget.content

	widget_content.callback = function ()
		return
	end

	widget_content.saved_value_cb = function ()
		return
	end

	widget_content.disabled = true

	return widget
end

OptionsView.build_checkbox_widget = function (self, element, scenegraph_id, base_offset)
	local callback_name = element.callback
	local callback_func = self:make_callback(callback_name)
	local saved_value_cb_name = element.saved_value
	local saved_value_cb = callback(self, saved_value_cb_name)
	local setup_name = element.setup
	local flag, text, default_value = self[setup_name](self)

	fassert(type(flag) == "boolean", "Flag type is wrong, need boolean, got %q", type(flag))

	local widget = definitions.create_checkbox_widget(text, scenegraph_id, base_offset)
	local content = widget.content
	content.flag = flag
	content.callback = callback_func
	content.saved_value_cb = saved_value_cb
	content.default_value = default_value

	return widget
end

OptionsView.build_keybind_widget = function (self, element, scenegraph_id, base_offset)
	local callback_func = callback(self, "cb_keybind_changed")
	local saved_value_cb = callback(self, "cb_keybind_saved_value")
	local selected_key, actions_info, default_value = self:cb_keybind_setup(element.keymappings_key, element.keymappings_table_key, element.actions)
	local widget = definitions.create_keybind_widget(selected_key, element.actions, actions_info, scenegraph_id, base_offset)
	local content = widget.content
	content.callback = callback_func
	content.saved_value_cb = saved_value_cb
	content.default_value = default_value
	content.keymappings_key = element.keymappings_key
	content.keymappings_table_key = element.keymappings_table_key

	return widget
end

OptionsView.widget_from_name = function (self, name)
	local selected_settings_list = self.selected_settings_list

	fassert(selected_settings_list, "[OptionsView] Trying to set disable on widget without a selected settings list.")

	local widgets = selected_settings_list.widgets
	local widgets_n = selected_settings_list.widgets_n

	for i = 1, widgets_n, 1 do
		local widget = widgets[i]

		if widget.name and widget.name == name then
			return widget
		end
	end
end

OptionsView.force_set_widget_value = function (self, name, value)
	local widget = self:widget_from_name(name)

	fassert(widget, "No widget with name %q in current settings list", name)

	local widget_type = widget.type

	if widget_type == "stepper" then
		local content = widget.content
		local options_values = content.options_values

		for i = 1, #options_values, 1 do
			if value == options_values[i] then
				content.current_selection = i
			end
		end

		content:callback()
	else
		fassert(false, "Force set widget value not supported for widget type %q yet", wiget_type)
	end
end

OptionsView.set_widget_disabled = function (self, name, disable)
	local widget = self:widget_from_name(name)

	if widget then
		widget.content.disabled = disable
	end
end

OptionsView.on_enter = function (self)
	self:set_original_settings()
	self:reset_changed_settings()
	self:select_settings_title(1)

	self.in_settings_sub_menu = false
	self.gamepad_active_generic_actions_name = nil
	self.gamepad_tooltip_available = nil
	local input_manager = self.input_manager
	local gamepad_active = input_manager:is_device_active("gamepad")

	if gamepad_active then
		self.selected_title = nil

		self:set_console_title_selection(1, true)
	end

	WwiseWorld.trigger_event(self.wwise_world, "Play_hud_button_open")

	self.active = true

	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_on")
end

OptionsView.on_exit = function (self)
	self.exiting = nil
	self.active = nil

	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_off")
end

OptionsView.exit = function (self, return_to_game)
	self:cleanup_popups()

	if self.selected_title then
		self:deselect_title(self.selected_title)

		self.in_settings_sub_menu = false
	end

	self.gamepad_active_generic_actions_name = nil
	self.gamepad_tooltip_available = nil

	self:cancel_gamepad_reset_animation()

	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)
	WwiseWorld.trigger_event(self.wwise_world, "Play_hud_button_close")

	self.exiting = true
end

OptionsView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end
end

OptionsView.get_keymaps = function (self, include_saved_keybinds, optional_platform_key)
	local keybindings_mappings = {}
	local kebindings_definitions = settings_definitions.keybind_settings_definition

	if not kebindings_definitions then
		return
	end

	for index, kebinding_definition in ipairs(kebindings_definitions) do
		local keymappings_key = kebinding_definition.keymappings_key
		local actions = kebinding_definition.actions

		if actions then
			local keymappings_table_key = kebinding_definition.keymappings_table_key

			if not keybindings_mappings[keymappings_key] then
				keybindings_mappings[keymappings_key] = {}
			end

			local keymapping_table = keybindings_mappings[keymappings_key]
			local keymaps_table = rawget(_G, keymappings_key)

			for keymaps_table_key, keymaps in pairs(keymaps_table) do
				if not optional_platform_key or optional_platform_key == keymaps_table_key then
					if not keymapping_table[keymaps_table_key] then
						keymapping_table[keymaps_table_key] = {}
					end

					local keymaps_sub_table = keymapping_table[keymaps_table_key]

					for action, keybinding in pairs(keymaps) do
						if table.contains(actions, action) then
							keymaps_sub_table[action] = table.clone(keybinding)
						end
					end
				end
			end
		end
	end

	if include_saved_keybinds then
		local saved_controls = PlayerData.controls or {}

		for keymappings_key, keymappings in pairs(keybindings_mappings) do
			local saved_keybindings_table = saved_controls[keymappings_key]

			if saved_keybindings_table then
				for saved_keybinding_table_key, saved_keybindings in pairs(saved_keybindings_table) do
					if not optional_platform_key or optional_platform_key == saved_keybinding_table_key then
						for action, keybinding in pairs(saved_keybindings) do
							local original_keymappings = keymappings[saved_keybinding_table_key]

							if original_keymappings and original_keymappings[action] then
								local saved_action_keybind = table.clone(keybinding)
								original_keymappings[action] = saved_action_keybind
							end
						end
					end
				end
			end
		end
	end

	return keybindings_mappings
end

OptionsView.reset_changed_settings = function (self)
	self.changed_user_settings = {}
	self.changed_render_settings = {}
	local include_saved_keybinds = true
	self.session_keymaps = self:get_keymaps(include_saved_keybinds, "win32")
	self.changed_keymaps = false
end

OptionsView.set_original_settings = function (self)
	self.original_user_settings = {}
	self.original_render_settings = {}
	local include_saved_keybinds = true
	self.original_keymaps = self:get_keymaps(include_saved_keybinds, "win32")
end

OptionsView.set_wwise_parameter = function (self, name, value)
	WwiseWorld.set_global_parameter(self.wwise_world, name, value)
end

OptionsView.changes_been_made = function (self)
	local changed_user_settings = table.size(self.changed_user_settings) > 0
	local changed_render_settings = table.size(self.changed_render_settings) > 0
	local changed_keymaps = self.changed_keymaps

	return changed_user_settings or changed_render_settings or changed_keymaps
end

local save_error_code_key_lookup = {
	[0] = "save_error_no_error",
	"save_error_no_settings_file",
	"save_error_no_appdata_folder",
	"save_error_cannot_open_file"
}
local needs_reload_settings = settings_definitions.needs_reload_settings

OptionsView.apply_changes = function (self, user_settings, render_settings, pending_user_settings)
	local needs_reload = false

	for setting, value in pairs(user_settings) do
		Application.set_user_setting(setting, value)

		if table.contains(needs_reload_settings, setting) then
			needs_reload = true
		end
	end

	for setting, value in pairs(render_settings) do
		Application.set_user_setting("render_settings", setting, value)

		if table.contains(needs_reload_settings, setting) then
			needs_reload = true
		end
	end

	local char_texture_quality = user_settings.char_texture_quality

	if char_texture_quality then
		local char_texture_settings = TextureQuality.characters[char_texture_quality]

		for id, setting in ipairs(char_texture_settings) do
			Application.set_user_setting("texture_settings", setting.texture_setting, setting.mip_level)
		end
	end

	local env_texture_quality = user_settings.env_texture_quality

	if env_texture_quality then
		local char_texture_settings = TextureQuality.environment[env_texture_quality]

		for id, setting in ipairs(char_texture_settings) do
			Application.set_user_setting("texture_settings", setting.texture_setting, setting.mip_level)
		end
	end

	local save_error_code, error_path = nil

	if PLATFORM == "win32" then
		save_error_code, error_path = Application.save_user_settings()
		save_error_code = save_error_code and ((save_error_code > 0 and save_error_code) or nil)
	else
		Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_save_done"))
	end

	if not save_error_code then
		if PLATFORM == "win32" then
			local max_fps = user_settings.max_fps

			if max_fps then
				if max_fps == 0 then
					Application.set_time_step_policy("no_throttle")
				else
					Application.set_time_step_policy("throttle", max_fps)
				end
			end
		end

		local max_upload = user_settings.max_upload_speed
		local network_manager = Managers.state.network

		if max_upload and network_manager then
			network_manager:set_max_upload_speed(max_upload)
		end

		local max_stacking_frames = user_settings.max_stacking_frames

		if max_stacking_frames then
			Application.set_max_frame_stacking(max_stacking_frames)
		end

		local use_hud_screen_fit = user_settings.use_hud_screen_fit

		if use_hud_screen_fit ~= nil then
			UISettings.use_hud_screen_fit = use_hud_screen_fit
		end

		local use_subtitles = user_settings.use_subtitles

		if use_subtitles ~= nil then
			UISettings.use_subtitles = use_subtitles
		end

		local master_bus_volume = user_settings.master_bus_volume

		if master_bus_volume then
			self:set_wwise_parameter("master_bus_volume", master_bus_volume)
		end

		local music_bus_volume = user_settings.music_bus_volume

		if music_bus_volume then
			Managers.music:set_music_volume(music_bus_volume)
		end

		local sfx_bus_volume = user_settings.sfx_bus_volume

		if sfx_bus_volume then
			self:set_wwise_parameter("sfx_bus_volume", sfx_bus_volume)
		end

		local voice_bus_volume = user_settings.voice_bus_volume

		if voice_bus_volume then
			self:set_wwise_parameter("voice_bus_volume", voice_bus_volume)
		end

		local voip_bus_volume = user_settings.voip_bus_volume

		if voip_bus_volume then
			if PLATFORM == "xb1" then
				Managers.voice_chat:set_chat_volume(voip_bus_volume)
			else
				self.voip:set_volume(voip_bus_volume)
			end
		end

		local voip_enabled = user_settings.voip_is_enabled

		if voip_enabled ~= nil then
			if PLATFORM == "xb1" then
				Managers.voice_chat:set_enabled(voip_enabled)
			else
				self.voip:set_enabled(voip_enabled)
			end
		end

		local voip_push_to_talk = user_settings.voip_push_to_talk

		if voip_push_to_talk then
			self.voip:set_push_to_talk(voip_push_to_talk)
		end

		local dynamic_range_sound = user_settings.dynamic_range_sound

		if dynamic_range_sound then
			local setting = 1

			if dynamic_range_sound == "high" then
				setting = 0
			end

			self:set_wwise_parameter("dynamic_range_sound", setting)
		end

		local sound_panning_rule = user_settings.sound_panning_rule

		if sound_panning_rule then
			local value = (sound_panning_rule == "headphones" and "PANNING_RULE_HEADPHONES") or "PANNING_RULE_SPEAKERS"

			Managers.music:set_panning_rule(value)
		end

		local sound_quality = user_settings.sound_quality

		if sound_quality then
			SoundQualitySettings.set_sound_quality(self.wwise_world, sound_quality)
		end

		local fov = render_settings.fov

		if fov then
			local base_fov = CameraSettings.first_person._node.vertical_fov
			local fov_multiplier = fov / base_fov
			local camera_manager = Managers.state.camera

			if camera_manager then
				camera_manager:set_fov_multiplier(fov_multiplier)
			end
		end

		local enabled_crosshairs = user_settings.enabled_crosshairs

		if enabled_crosshairs and self.ingame_ui and self.ingame_ui.ingame_hud and self.ingame_ui.ingame_hud.crosshair then
			self.ingame_ui.ingame_hud.crosshair:set_enabled_crosshair_styles(enabled_crosshairs)
		end

		local player_input_service = self.input_manager:get_service("Player")
		local mouse_look_sensitivity = user_settings.mouse_look_sensitivity

		if mouse_look_sensitivity then
			local platform_key = "win32"
			local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
			local base_look_multiplier = base_filter.look.multiplier
			local input_filters = player_input_service:get_active_filters(platform_key)
			local look_filter = input_filters.look
			local function_data = look_filter.function_data
			function_data.multiplier = base_look_multiplier * 0.85^(-mouse_look_sensitivity)
		end

		local mouse_look_invert_y = user_settings.mouse_look_invert_y

		if mouse_look_invert_y ~= nil then
			local platform_key = "win32"
			local input_filters = player_input_service:get_active_filters(platform_key)
			local look_filter = input_filters.look
			local function_data = look_filter.function_data
			function_data.filter_type = (mouse_look_invert_y and "scale_vector3") or "scale_vector3_invert_y"
		end

		local gamepad_look_sensitivity = user_settings.gamepad_look_sensitivity

		if gamepad_look_sensitivity then
			local platform_key = (self.platform == "win32" and "xb1") or self.platform
			local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
			local base_look_multiplier = base_filter.look_controller.multiplier_x
			local base_melee_look_multiplier = base_filter.look_controller_melee.multiplier_x
			local base_ranged_look_multiplier = base_filter.look_controller_ranged.multiplier_x
			local input_filters = player_input_service:get_active_filters(platform_key)
			local look_filter = input_filters.look_controller
			local function_data = look_filter.function_data
			function_data.multiplier_x = base_look_multiplier * 0.85^(-gamepad_look_sensitivity)
			function_data.min_multiplier_x = (base_filter.look_controller.multiplier_min_x and base_filter.look_controller.multiplier_min_x * 0.85^(-gamepad_look_sensitivity)) or function_data.multiplier_x * 0.25
			local melee_look_filter = input_filters.look_controller_melee
			local function_data = melee_look_filter.function_data
			function_data.multiplier_x = base_melee_look_multiplier * 0.85^(-gamepad_look_sensitivity)
			function_data.min_multiplier_x = (base_filter.look_controller_melee.multiplier_min_x and base_filter.look_controller_melee.multiplier_min_x * 0.85^(-gamepad_look_sensitivity)) or function_data.multiplier_x * 0.25
			local ranged_look_filter = input_filters.look_controller_ranged
			local function_data = ranged_look_filter.function_data
			function_data.multiplier_x = base_ranged_look_multiplier * 0.85^(-gamepad_look_sensitivity)
			function_data.min_multiplier_x = (base_filter.look_controller_ranged.multiplier_min_x and base_filter.look_controller_ranged.multiplier_min_x * 0.85^(-gamepad_look_sensitivity)) or function_data.multiplier_x * 0.25
		end

		local gamepad_look_sensitivity_y = user_settings.gamepad_look_sensitivity_y

		if gamepad_look_sensitivity_y then
			local platform_key = (self.platform == "win32" and "xb1") or self.platform
			local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
			local base_look_multiplier = base_filter.look_controller.multiplier_y
			local base_melee_look_multiplier = base_filter.look_controller.multiplier_y
			local base_ranged_look_multiplier = base_filter.look_controller.multiplier_y
			local input_filters = player_input_service:get_active_filters(platform_key)
			local look_filter = input_filters.look_controller
			local function_data = look_filter.function_data
			function_data.multiplier_y = base_look_multiplier * 0.85^(-gamepad_look_sensitivity_y)
			local melee_look_filter = input_filters.look_controller_melee
			local function_data = melee_look_filter.function_data
			function_data.multiplier_y = base_melee_look_multiplier * 0.85^(-gamepad_look_sensitivity_y)
			local ranged_look_filter = input_filters.look_controller_ranged
			local function_data = ranged_look_filter.function_data
			function_data.multiplier_y = base_ranged_look_multiplier * 0.85^(-gamepad_look_sensitivity_y)
		end

		local gamepad_zoom_sensitivity = user_settings.gamepad_zoom_sensitivity

		if gamepad_zoom_sensitivity then
			local platform_key = (self.platform == "win32" and "xb1") or self.platform
			local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
			local base_look_multiplier = base_filter.look_controller_zoom.multiplier_x
			local input_filters = player_input_service:get_active_filters(platform_key)
			local look_filter = input_filters.look_controller_zoom
			local function_data = look_filter.function_data
			function_data.multiplier_x = base_look_multiplier * 0.85^(-gamepad_zoom_sensitivity)
			function_data.min_multiplier_x = (base_filter.look_controller_zoom.multiplier_min_x and base_filter.look_controller_zoom.multiplier_min_x * 0.85^(-gamepad_zoom_sensitivity)) or function_data.multiplier_x * 0.25
		end

		local gamepad_zoom_sensitivity_y = user_settings.gamepad_zoom_sensitivity_y

		if gamepad_zoom_sensitivity_y then
			local platform_key = (self.platform == "win32" and "xb1") or self.platform
			local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
			local base_look_multiplier = base_filter.look_controller_zoom.multiplier_y
			local input_filters = player_input_service:get_active_filters(platform_key)
			local look_filter = input_filters.look_controller_zoom
			local function_data = look_filter.function_data
			function_data.multiplier_y = base_look_multiplier * 0.85^(-gamepad_zoom_sensitivity_y)
		end

		local gamepad_look_invert_y = user_settings.gamepad_look_invert_y

		if gamepad_look_invert_y ~= nil then
			local platform_key = (self.platform == "win32" and "xb1") or self.platform
			local input_filters = player_input_service:get_active_filters(platform_key)
			local look_filter = input_filters.look_controller
			local function_data = look_filter.function_data
			function_data.inverted_y = gamepad_look_invert_y
			local look_filter = input_filters.look_controller_melee
			local function_data = look_filter.function_data
			function_data.inverted_y = gamepad_look_invert_y
			local look_filter = input_filters.look_controller_ranged
			local function_data = look_filter.function_data
			function_data.inverted_y = gamepad_look_invert_y
			local look_filter = input_filters.look_controller_zoom
			local function_data = look_filter.function_data
			function_data.inverted_y = gamepad_look_invert_y
		end

		local gamepad_use_ps4_style_input_icons = user_settings.gamepad_use_ps4_style_input_icons

		if gamepad_use_ps4_style_input_icons ~= nil then
			UISettings.use_ps4_input_icons = gamepad_use_ps4_style_input_icons
		end

		local changed_gamepad_layout = user_settings.gamepad_layout ~= nil
		local changed_gamepad_left_handed = user_settings.gamepad_left_handed ~= nil

		if changed_gamepad_layout or changed_gamepad_left_handed then
			local default_value = DefaultUserSettings.get("user_settings", "gamepad_layout") or "default"
			local gamepad_layout = assigned(user_settings.gamepad_layout, Application.user_setting("gamepad_layout")) or default_value

			if gamepad_layout then
				local using_left_handed_option = assigned(user_settings.gamepad_left_handed, Application.user_setting("gamepad_left_handed"))
				local gamepad_keymaps_layout = nil

				if using_left_handed_option then
					gamepad_keymaps_layout = AlternatateGamepadKeymapsLayoutsLeftHanded
				else
					gamepad_keymaps_layout = AlternatateGamepadKeymapsLayouts
				end

				local gamepad_keymaps = gamepad_keymaps_layout[gamepad_layout]

				self:apply_gamepad_changes(gamepad_keymaps, using_left_handed_option)
			end
		end

		local animation_lod_distance_multiplier = user_settings.animation_lod_distance_multiplier

		if animation_lod_distance_multiplier then
			GameSettingsDevelopment.bone_lod_husks.lod_multiplier = animation_lod_distance_multiplier
		end

		local player_outlines = user_settings.player_outlines

		if player_outlines then
			local players = Managers.player:players()

			for _, player in pairs(players) do
				local player_unit = player.player_unit

				if not player.local_player and Unit.alive(player_unit) then
					local outline_extension = ScriptUnit.extension(player_unit, "outline_system")

					outline_extension.update_override_method_player_setting()
				end
			end
		end

		local toggle_crouch = user_settings.toggle_crouch

		if toggle_crouch ~= nil then
			local units = (Managers.state.entity and Managers.state.entity:get_entities("PlayerInputExtension")) or {}

			for unit, extension in pairs(units) do
				local player = Managers.player:owner(unit)

				if player.local_player and not player.bot_player then
					local input_extension = ScriptUnit.extension(unit, "input_system")
					input_extension.toggle_crouch = toggle_crouch
				end
			end
		end

		local double_tap_dodge = user_settings.double_tap_dodge

		if double_tap_dodge ~= nil then
			local units = Managers.state.entity:get_entities("PlayerInputExtension")

			for unit, extension in pairs(units) do
				local player = Managers.player:owner(unit)

				if player.local_player and not player.bot_player then
					local input_extension = ScriptUnit.extension(unit, "input_system")
					input_extension.double_tap_dodge = double_tap_dodge
				end
			end
		end

		local dodge_on_jump_key = user_settings.dodge_on_jump_key

		if dodge_on_jump_key ~= nil then
			local units = Managers.state.entity:get_entities("PlayerInputExtension")

			for unit, extension in pairs(units) do
				local player = Managers.player:owner(unit)

				if player.local_player and not player.bot_player then
					local input_extension = ScriptUnit.extension(unit, "input_system")
					input_extension.dodge_on_jump_key = dodge_on_jump_key
				end
			end
		end

		local dodge_on_forward_diagonal = user_settings.dodge_on_forward_diagonal

		if dodge_on_forward_diagonal ~= nil then
			local units = Managers.state.entity:get_entities("PlayerInputExtension")

			for unit, extension in pairs(units) do
				local player = Managers.player:owner(unit)

				if player.local_player and not player.bot_player then
					local input_extension = ScriptUnit.extension(unit, "input_system")
					input_extension.dodge_on_forward_diagonal = dodge_on_forward_diagonal
				end
			end
		end

		local toggle_alternate_attack = user_settings.toggle_alternate_attack

		if toggle_alternate_attack ~= nil then
			local units = Managers.state.entity:get_entities("PlayerInputExtension")

			for unit, extension in pairs(units) do
				local player = Managers.player:owner(unit)

				if player.local_player and not player.bot_player then
					local input_extension = ScriptUnit.extension(unit, "input_system")
					input_extension.toggle_alternate_attack = toggle_alternate_attack
				end
			end
		end

		local overcharge_opacity = user_settings.overcharge_opacity
		local player_manager = Managers.player

		if overcharge_opacity and player_manager then
			local local_player = player_manager:local_player()
			local player_unit = local_player.player_unit
			local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
			local melee_slot_data = inventory_extension:get_slot_data("slot_melee")
			local ranged_slot_data = inventory_extension:get_slot_data("slot_ranged")

			local function set_opacity(slot_data)
				if not slot_data then
					return
				end

				local left_hand_wielded_unit = slot_data.left_unit_1p
				local right_hand_wielded_unit = slot_data.right_unit_1p
				local overcharge_extension = nil

				if right_hand_wielded_unit and ScriptUnit.has_extension(right_hand_wielded_unit, "overcharge_system") then
					overcharge_extension = ScriptUnit.extension(right_hand_wielded_unit, "overcharge_system")
				elseif left_hand_wielded_unit and ScriptUnit.has_extension(left_hand_wielded_unit, "overcharge_system") then
					overcharge_extension = ScriptUnit.extension(left_hand_wielded_unit, "overcharge_system")
				end

				if overcharge_extension then
					overcharge_extension:set_screen_particle_opacity_modifier(overcharge_opacity)
				end
			end

			set_opacity(melee_slot_data)
			set_opacity(ranged_slot_data)
		end

		local chat_enabled = user_settings.chat_enabled
		local chat_manager = Managers.chat

		if chat_enabled ~= nil and chat_manager then
			chat_manager:set_chat_enabled(chat_enabled)
		end

		local chat_font_size = user_settings.chat_font_size
		local chat_manager = Managers.chat

		if chat_font_size and chat_manager then
			chat_manager:set_font_size(chat_font_size)
		end

		local language_id = user_settings.language_id

		if language_id then
			self:reload_language(language_id)
		end

		local ui_scale = user_settings.ui_scale

		if ui_scale ~= nil then
			UISettings.ui_scale = ui_scale
			local force_update = true

			UPDATE_RESOLUTION_LOOKUP(force_update)
		end

		if needs_reload then
			Application.apply_user_settings()
			Renderer.bake_static_shadows()
		end
	elseif not self.delayed_title_change then
		local error_text = Localize(save_error_code_key_lookup[save_error_code])

		if error_path then
			error_text = string.format(error_text, error_path) or error_text
		end

		self.save_error_popup_id = Managers.popup:queue_popup(error_text, Localize("popup_save_error"), "ok", Localize("popup_choice_ok"))
		self.has_save_error = true
	end

	self.has_save_error = save_error_code ~= nil

	ShowCursorStack.update_clip_cursor()
end

OptionsView.apply_keymap_changes = function (self, keymaps_data, save_keymaps)
	if not PlayerData.controls then
		PlayerData.controls = {}
	end

	local saved_controls = save_keymaps and PlayerData.controls

	for keybinding_table_name, keybinding_table in pairs(keymaps_data) do
		for keybindings_table_key, keybindings in pairs(keybinding_table) do
			for action, keybind in pairs(keybindings) do
				if save_keymaps then
					if not saved_controls[keybinding_table_name] then
						saved_controls[keybinding_table_name] = {}
					end

					local saved_keybinding_data = saved_controls[keybinding_table_name]

					if not saved_keybinding_data[keybindings_table_key] then
						saved_keybinding_data[keybindings_table_key] = {}
					end

					local saved_keybindings = saved_keybinding_data[keybindings_table_key]
					local changed = keybind.changed

					if changed then
						saved_keybindings[action] = table.clone(keybind)
					else
						saved_keybindings[action] = nil
					end
				end

				self:_apply_keybinding_changes(keybinding_table_name, keybindings_table_key, action, keybind)
			end
		end
	end

	if save_keymaps then
		if PLATFORM == "win32" then
			Managers.save:auto_save(SaveFileName, SaveData)
		else
			Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_save_done"))
		end
	end
end

OptionsView._apply_keybinding_changes = function (self, keybinding_table_name, keybinding_table_key, action, keybind)
	local input_manager = Managers.input

	if #keybind >= 3 then
		local device = keybind[1]
		local button_name = keybind[2]
		local input_type = keybind[3]
		local button_index = nil

		if device == "gamepad" then
			if input_type == "axis" then
				button_index = Pad1.axis_index(button_name)
			else
				button_index = Pad1.button_index(button_name)
			end
		elseif device == "keyboard" then
			button_index = Keyboard.button_index(button_name)
		elseif device == "mouse" then
			if input_type == "axis" then
				button_index = Mouse.axis_index(button_name)
			else
				button_index = Mouse.button_index(button_name)
			end
		else
			assert(device, "[OptionsView] - Trying to keybind unrecognized device for action %s in keybinds %s, %s", action, keybinding_table_name, keybinding_table_key)
		end

		input_manager:change_keybinding(keybinding_table_name, keybinding_table_key, action, button_index, device, input_type)
	else
		input_manager:clear_keybinding(keybinding_table_name, keybinding_table_key, action)
	end
end

OptionsView.cb_save_done = function (self, result)
	Managers.transition:hide_loading_icon()

	self.disable_all_input = false
end

OptionsView.apply_gamepad_changes = function (self, keymaps, using_left_handed_option)
	local save_keymaps = false

	self:apply_keymap_changes(keymaps, save_keymaps)
	self:update_gamepad_layout_widget(keymaps, using_left_handed_option)
end

OptionsView.has_popup = function (self)
	return self.exit_popup_id or self.title_popup_id or self.apply_popup_id or self.save_error_popup_id
end

OPTIONS_VIEW_PRINT_ORIGINAL_VALUES = false
local HAS_TOBII = rawget(_G, "Tobii")

OptionsView.update = function (self, dt)
	if self.suspended then
		return
	end

	local disable_all_input = self.disable_all_input

	if RELOAD_OPTIONS_VIEW then
		self:create_ui_elements()
	end

	local transitioning = self:transitioning()

	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil
		end
	end

	if not self.active then
		return
	end

	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("options_menu")
	local gamepad_active = input_manager:is_device_active("gamepad")
	local selected_widget = self.selected_widget

	if gamepad_active then
		if not self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = true

			self:on_gamepad_activated()
		end
	elseif self.gamepad_active_last_frame then
		self.gamepad_active_last_frame = false

		self:on_gamepad_deactivated()
	end

	self:update_apply_button()

	if gamepad_active and not self:has_popup() and not transitioning and not disable_all_input then
		self:handle_controller_navigation_input(dt, input_service)
	end

	if not transitioning then
		self:update_mouse_scroll_input(disable_all_input)

		local allow_gamepad_input = gamepad_active and not self.draw_gamepad_tooltip and not disable_all_input

		self:handle_apply_button(input_service, allow_gamepad_input)

		if self.selected_settings_list then
			self:handle_reset_to_default_button(input_service, allow_gamepad_input)
		end
	end

	self:draw_widgets(dt, disable_all_input)

	if self.save_data_error_popup_id then
		local result = Managers.popup:query_result(self.save_data_error_popup_id)

		if result then
			if result == "delete" then
				Managers.save:delete_save(SaveFileName, callback(self, "cb_delete_save"))

				self.disable_all_input = true
			end

			Managers.popup:cancel_popup(self.save_data_error_popup_id)

			self.save_data_error_popup_id = nil
		end
	end

	if self.title_popup_id then
		local result = Managers.popup:query_result(self.title_popup_id)

		if result then
			Managers.popup:cancel_popup(self.title_popup_id)

			self.title_popup_id = nil

			self:handle_title_buttons_popup_results(result)
		end
	end

	if self.apply_popup_id then
		local result = Managers.popup:query_result(self.apply_popup_id)

		if result then
			Managers.popup:cancel_popup(self.apply_popup_id)

			self.apply_popup_id = nil

			self:handle_apply_popup_results(result)
		end
	end

	if self.save_error_popup_id then
		local result = Managers.popup:query_result(self.save_error_popup_id)

		if result then
			Managers.popup:cancel_popup(self.save_error_popup_id)

			self.save_error_popup_id = nil
		end
	end

	if self.exit_popup_id then
		local result = Managers.popup:query_result(self.exit_popup_id)

		if result then
			Managers.popup:cancel_popup(self.exit_popup_id)

			self.exit_popup_id = nil

			self:handle_exit_button_popup_results(result)
		end
	end

	if OPTIONS_VIEW_PRINT_ORIGINAL_VALUES then
		print("------------------------")
		print("ORIGINAL USER SETTINGS")

		local original_user_settings = self.original_user_settings

		for setting, value in pairs(original_user_settings) do
			printf("  - %s  %s", setting, tostring(value))
		end

		print("ORIGINAL RENDER SETTINGS")

		local original_render_settings = self.original_render_settings

		for setting, value in pairs(original_render_settings) do
			printf("  - %s  %s", setting, tostring(value))
		end

		print("/-----------------------")

		OPTIONS_VIEW_PRINT_ORIGINAL_VALUES = false
	end

	if not transitioning then
		local exit_button_hotspot = self.exit_button.content.button_hotspot

		if exit_button_hotspot.on_hover_enter then
			WwiseWorld.trigger_event(self.wwise_world, "Play_hud_hover")
		end

		if not disable_all_input and not self:has_popup() and not self.draw_gamepad_tooltip and ((not selected_widget and input_service:get("toggle_menu")) or (exit_button_hotspot.is_hover and exit_button_hotspot.on_release)) then
			WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
			self:on_exit_pressed()
		end
	end
end

OptionsView.cb_delete_save = function (self, result)
	if result.error then
		Application.warning(string.format("[StateTitleScreenLoadSave] Error when overriding save data %q", result.error))
	end

	self.disable_all_input = false
end

OptionsView.on_gamepad_activated = function (self)
	local title_buttons = self.title_buttons
	local title_buttons_n = self.title_buttons_n

	for i = 1, title_buttons_n, 1 do
		local widget = title_buttons[i]
		widget.content.disable_side_textures = true
	end
end

OptionsView.on_gamepad_deactivated = function (self)
	local title_buttons = self.title_buttons
	local title_buttons_n = self.title_buttons_n

	for i = 1, title_buttons_n, 1 do
		local widget = title_buttons[i]
		widget.content.disable_side_textures = false
	end
end

OptionsView.on_exit_pressed = function (self)
	if self:changes_been_made() then
		local text = Localize("unapplied_changes_popup_text")
		self.exit_popup_id = Managers.popup:queue_popup(text, Localize("popup_discard_changes_topic"), "revert_changes", Localize("popup_choice_discard"), "cancel", Localize("popup_choice_cancel"))
	else
		self:exit()
	end
end

local needs_restart_settings = settings_definitions.needs_restart_settings

OptionsView.handle_apply_popup_results = function (self, result)
	if result == "keep_changes" then
		local needs_restart = false

		for setting, value in pairs(self.changed_user_settings) do
			if table.contains(needs_restart_settings, setting) then
				needs_restart = true

				break
			end
		end

		for setting, value in pairs(self.changed_render_settings) do
			if table.contains(needs_restart_settings, setting) then
				needs_restart = true

				break
			end
		end

		if needs_restart then
			local text = Localize("changes_need_restart_popup_text")
			self.apply_popup_id = Managers.popup:queue_popup(text, Localize("popup_needs_restart_topic"), "continue", Localize("popup_choice_continue"), "restart", Localize("popup_choice_restart_now"))
		else
			if not self.has_save_error then
				self:unsuspend()
			end

			if self.delayed_title_change then
				self:select_settings_title(self.delayed_title_change)

				self.delayed_title_change = nil
			end
		end

		self:set_original_settings()

		if not self.has_save_error then
			self:reset_changed_settings()
		end
	elseif result == "revert_changes" then
		if self.changed_keymaps then
			self:apply_keymap_changes(self.original_keymaps, true)
		else
			self:apply_changes(self.original_user_settings, self.original_render_settings)
		end

		self:unsuspend()

		if self.delayed_title_change then
			self:select_settings_title(self.delayed_title_change)

			self.delayed_title_change = nil
		else
			self:set_original_settings()
			self:reset_changed_settings()
			self:set_widget_values(self.selected_settings_list)
		end
	elseif result == "restart" then
		self:unsuspend()
		self:restart()
	elseif result == "continue" then
		self:unsuspend()

		if self.delayed_title_change then
			self:select_settings_title(self.delayed_title_change)

			self.delayed_title_change = nil
		end
	else
		print(result)
	end
end

OptionsView.restart = function (self)
	self.level_transition_handler:set_next_level("inn_level")
	self.ingame_ui:handle_transition("restart_game")
end

OptionsView.handle_title_buttons_popup_results = function (self, result)
	if result == "revert_changes" then
		if self.changed_keymaps then
			self:apply_keymap_changes(self.original_keymaps, true)
		else
			self:apply_changes(self.original_user_settings, self.original_render_settings)
		end

		self:unsuspend()
		self:reset_changed_settings()

		if self.delayed_title_change then
			self:select_settings_title(self.delayed_title_change)

			self.delayed_title_change = nil
		else
			self:set_original_settings()
			self:set_widget_values(self.selected_settings_list)
		end
	elseif result == "apply_changes" then
		self:unsuspend()
		self:handle_apply_changes()
	else
		print(result)
	end
end

OptionsView.handle_exit_button_popup_results = function (self, result)
	if result == "revert_changes" then
		if self.changed_keymaps then
			self:apply_keymap_changes(self.original_keymaps, true)
		else
			self:apply_changes(self.original_user_settings, self.original_render_settings)
		end

		self:set_original_settings()
		self:reset_changed_settings()
		self:exit()
	elseif result == "cancel" then
		self:unsuspend()
	else
		print(result)
	end
end

OptionsView.update_apply_button = function (self)

	-- Decompilation error in this vicinity:
	local widget = self.apply_button

	if self:changes_been_made() then
		widget.content.button_hotspot.disabled = false
	else
		widget.content.button_hotspot.disabled = true
	end
end

OptionsView.handle_apply_changes = function (self)
	if PLATFORM == "win32" then
		self:_handle_apply_changes()
	else
		Managers.transition:show_loading_icon()

		self.disable_all_input = true

		Managers.save:auto_load(SaveFileName, callback(self, "cb_load_done"))
	end
end

OptionsView.cb_load_done = function (self, result)
	if result.error and result.error ~= "NOT_FOUND" then
		self.save_data_error_popup_id = Managers.popup:queue_popup(Localize("ps4_save_error_broken"), Localize("popup_error_topic"), "delete", Localize("button_delete_save"), "back_to_title", Localize("button_back_to_title"))

		Managers.transition:hide_loading_icon()

		self.disable_all_input = false
	else
		self:_handle_apply_changes()
	end
end

OptionsView._handle_apply_changes = function (self)
	if self.changed_keymaps then
		self:apply_keymap_changes(self.session_keymaps, true)
	else
		self:apply_changes(self.changed_user_settings, self.changed_render_settings)
	end

	if self.selected_settings_list.needs_apply_confirmation then
		local text = Localize("keep_changes_popup_text")
		self.apply_popup_id = Managers.popup:queue_popup(text, Localize("popup_keep_changes_topic"), "keep_changes", Localize("popup_choice_keep"), "revert_changes", Localize("popup_choice_revert"))

		Managers.popup:activate_timer(self.apply_popup_id, 15, "revert_changes")
	else
		self:handle_apply_popup_results("keep_changes")

		if self.delayed_title_change then
			self:select_settings_title(self.delayed_title_change)

			self.delayed_title_change = nil
		end
	end
end

OptionsView.handle_apply_button = function (self, input_service, allow_gamepad_input)
	if self.apply_button.content.button_hotspot.disabled then
		return
	end

	local apply_button_hotspot = self.apply_button.content.button_hotspot

	if apply_button_hotspot.on_hover_enter then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_hover")
	end

	if (apply_button_hotspot.is_hover and apply_button_hotspot.on_release) or (allow_gamepad_input and input_service:get("refresh")) then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")

		if self.apply_popup_id then
			local gamepad_active = self.input_manager:is_device_active("gamepad")
			local changes_been_made = self:changes_been_made()
			local num_popups = Managers.popup._handler.n_popups

			table.dump(Managers.popup._handler.popups, "popups", 2)

			local blocked_input_services = {}

			self.input_manager:get_blocked_services(nil, nil, blocked_input_services)
			table.dump(blocked_input_services, "blocked_input_services", 2)
			ScriptApplication.send_to_crashify("OptionsView", "Apply button wasn't disabled, even though we had an apply popup...")
		else
			self:handle_apply_changes()
		end
	end
end

OptionsView.reset_to_default_drop_down = function (self, widget)
	local content = widget.content
	local default_value = content.default_value
	content.current_selection = default_value
	content.selected_option = content.options_texts[default_value]

	content:callback(default_value)
end

OptionsView.reset_to_default_slider = function (self, widget)
	local content = widget.content
	local default_value = content.default_value
	content.value = default_value
	content.internal_value = get_slider_value(content.min, content.max, default_value)

	content:callback()
end

OptionsView.reset_to_default_checkbox = function (self, widget)
	local content = widget.content
	local default_value = content.default_value
	content.flag = default_value

	content:callback()
end

OptionsView.reset_to_default_stepper = function (self, widget)
	local content = widget.content
	local default_value = content.default_value
	content.current_selection = default_value

	content:callback()
end

OptionsView.reset_to_default_keybind = function (self, widget)
	local content = widget.content
	local default_value = content.default_value

	content.callback(default_value.key, default_value.controller, content)
end

OptionsView.reset_current_settings_list_to_default = function (self)
	local selected_settings_list = self.selected_settings_list
	local widgets = selected_settings_list.widgets
	local widgets_n = selected_settings_list.widgets_n

	for i = 1, widgets_n, 1 do
		local widget = widgets[i]

		if widget.content.default_value then
			local widget_type = widget.type

			if widget_type == "drop_down" then
				self:reset_to_default_drop_down(widget)
			elseif widget_type == "slider" then
				self:reset_to_default_slider(widget)
			elseif widget_type == "checkbox" then
				self:reset_to_default_checkbox(widget)
			elseif widget_type == "stepper" then
				self:reset_to_default_stepper(widget)
			elseif widget_type == "keybind" then
				self:reset_to_default_keybind(widget)
			else
				error("Not supported widget type..")
			end
		end
	end
end

OptionsView.handle_reset_to_default_button = function (self, input_service, allow_gamepad_input)
	local reset_to_default_content = self.reset_to_default.content

	if reset_to_default_content.button_hotspot.disabled or reset_to_default_content.hidden then
		return
	end

	local reset_to_default_hotspot = self.reset_to_default.content.button_hotspot

	if reset_to_default_hotspot.on_hover_enter then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_hover")
	end

	if reset_to_default_hotspot.on_release or (allow_gamepad_input and input_service:get("special_1")) then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
		self:start_gamepad_reset_animation()
		self:reset_current_settings_list_to_default()
	end
end

OptionsView.start_gamepad_reset_animation = function (self)
	local animation_name = "gamepad_reset"
	local from = 0
	local to = 255
	local widget = self.gamepad_reset_text_widget
	self.ui_animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.text.text_color, 1, from, to, 0.2, math.easeInCubic, UIAnimation.wait, 0.3, UIAnimation.function_by_time, widget.style.text.text_color, 1, to, from, 0.3, math.easeInCubic)
end

OptionsView.cancel_gamepad_reset_animation = function (self)
	local widget = self.gamepad_reset_text_widget
	widget.style.text.text_color[1] = 0
	local animation_name = "gamepad_reset"
	self.ui_animations[animation_name] = nil
end

OptionsView.draw_widgets = function (self, dt, disable_all_input)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("options_menu")
	local gamepad_active = input_manager:is_device_active("gamepad")
	local draw_gamepad_tooltip = self.draw_gamepad_tooltip

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	local background_widgets = self.background_widgets
	local background_widgets_n = self.background_widgets_n

	for i = 1, background_widgets_n, 1 do
		UIRenderer.draw_widget(ui_renderer, background_widgets[i])
	end

	if self.selected_settings_list and not draw_gamepad_tooltip then
		self:update_settings_list(self.selected_settings_list, ui_renderer, ui_scenegraph, input_service, dt, disable_all_input)
	end

	self:handle_title_buttons(ui_renderer, disable_all_input)

	self.reset_to_default.content.button_hotspot.disable_button = disable_all_input
	self.apply_button.content.button_hotspot.disable_button = disable_all_input
	self.exit_button.content.button_hotspot.disable_button = disable_all_input

	if not gamepad_active then
		if not self.reset_to_default.content.hidden then
			UIRenderer.draw_widget(ui_renderer, self.reset_to_default)
		end

		UIRenderer.draw_widget(ui_renderer, self.apply_button)
		UIRenderer.draw_widget(ui_renderer, self.exit_button)
	else
		if self.in_settings_sub_menu then
			UIRenderer.draw_widget(ui_renderer, self.right_frame_glow_widget)
		else
			UIRenderer.draw_widget(ui_renderer, self.left_frame_glow_widget)
			UIRenderer.draw_widget(ui_renderer, self.gamepad_button_selection_widget)
		end

		if draw_gamepad_tooltip then
			UIRenderer.draw_widget(ui_renderer, self.gamepad_tooltip_text_widget)
		end

		UIRenderer.draw_widget(ui_renderer, self.gamepad_reset_text_widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.dead_space_4k_filler)
	UIRenderer.end_pass(ui_renderer)

	local selected_title_name = SettingsMenuNavigation[self.selected_title]

	if selected_title_name == "calibrate_ui" then
		self.ui_calibration_view:update(self.ui_top_renderer, input_service, dt)
	end

	if gamepad_active then
		local popup_active = self.save_data_error_popup_id or self.exit_popup_id or self.title_popup_id or self.apply_popup_id or self.save_error_popup_id

		if not popup_active and not self.disable_all_input then
			self.menu_input_description:draw(ui_renderer, dt)
		end
	end
end

local temp_pos_table = {
	x = 0,
	y = 0
}

OptionsView.update_settings_list = function (self, settings_list, ui_renderer, ui_scenegraph, input_service, dt, disable_all_input)
	if settings_list.scrollbar then
		local scrollbar = self.scrollbar
		local content = scrollbar.content
		content.button_up_hotspot.disable_button = disable_all_input
		content.button_down_hotspot.disable_button = disable_all_input
		content.scroll_bar_info.disable_button = disable_all_input

		UIRenderer.draw_widget(ui_renderer, self.scrollbar)
		self:update_scrollbar(settings_list, ui_scenegraph)
	end

	local scenegraph_id_start = settings_list.scenegraph_id_start
	local list_position = UISceneGraph.get_world_position(ui_scenegraph, scenegraph_id_start)
	local mask_pos = Vector3.deprecated_copy(UISceneGraph.get_world_position(ui_scenegraph, "list_mask"))
	local mask_size = UISceneGraph.get_size(ui_scenegraph, "list_mask")
	local selected_widget = self.selected_widget
	local widgets = settings_list.widgets
	local widgets_n = settings_list.widgets_n
	local visible_widgets_n = 0

	for i = 1, widgets_n, 1 do
		local widget = widgets[i]
		local style = widget.style
		local widget_name = widget.name
		local size = style.size
		local offset = style.offset
		temp_pos_table.x = list_position[1] + offset[1]
		temp_pos_table.y = list_position[2] + offset[2]
		local lower_visible = math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)
		temp_pos_table.y = temp_pos_table.y + size[2] / 2
		local middle_visible = math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)
		temp_pos_table.y = temp_pos_table.y + size[2] / 2
		local top_visible = math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)
		local visible = lower_visible or top_visible
		widget.content.visible = visible

		if visible then
			visible_widgets_n = visible_widgets_n + 1
		end

		local disable_widget_input = true

		if widget.content.is_highlighted then
			disable_widget_input = false
		end

		if widget.content.disabled then
			disable_widget_input = true
		end

		if not middle_visible then
			disable_widget_input = true
		end

		local content = widget.content
		local hotspot_content_ids = content.hotspot_content_ids

		if hotspot_content_ids then
			for i = 1, #hotspot_content_ids, 1 do
				content[hotspot_content_ids[i]].disable_button = disable_widget_input
			end
		end

		if content.highlight_hotspot then
			content.highlight_hotspot.disable_button = disable_all_input
		end

		local ui_animations = widget.ui_animations

		for name, animation in pairs(ui_animations) do
			UIAnimation.update(animation, dt)

			if UIAnimation.completed(animation) then
				ui_animations[name] = nil
			end
		end

		UIRenderer.draw_widget(ui_renderer, widget)

		if widget.content.is_highlighted then
			self:handle_mouse_widget_input(widget, input_service)
		end

		if content.highlight_hotspot and content.highlight_hotspot.on_hover_enter then
			widget.content.is_highlighted = true

			self:select_settings_list_widget(i)
		end
	end

	settings_list.visible_widgets_n = visible_widgets_n
end

OptionsView.update_scrollbar = function (self, settings_list, ui_scenegraph)
	local scrollbar = self.scrollbar
	local value = scrollbar.content.scroll_bar_info.value
	local max_offset_y = settings_list.max_offset_y
	local offset_y = max_offset_y * value
	local scenegraph = ui_scenegraph[settings_list.scenegraph_id]
	scenegraph.offset[2] = offset_y
end

OptionsView.handle_title_buttons = function (self, ui_renderer, disable_all_input)
	local title_buttons = self.title_buttons
	local title_buttons_n = self.title_buttons_n

	for i = 1, title_buttons_n, 1 do
		local widget = title_buttons[i]
		widget.content.button_hotspot.disable_button = disable_all_input

		UIRenderer.draw_widget(ui_renderer, widget)

		if self.selected_title ~= i then
			local on_release = false
			local button_hotspot = widget.content.button_hotspot

			if button_hotspot and button_hotspot.on_hover_enter then
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_hover")
			end

			if button_hotspot and button_hotspot.on_release then
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")

				widget.content.button_hotspot.is_selected = true
				on_release = true
			end

			if widget.content.controller_button_hotspot and widget.content.controller_button_hotspot.on_release then
				widget.content.controller_button_hotspot.is_selected = true
				on_release = true
			end

			if on_release then
				if self:changes_been_made() then
					local text = Localize("unapplied_changes_popup_text")
					self.title_popup_id = Managers.popup:queue_popup(text, Localize("popup_discard_changes_topic"), "apply_changes", Localize("menu_settings_apply"), "revert_changes", Localize("popup_choice_discard"))
					self.delayed_title_change = i
				else
					self:select_settings_title(i)

					self.in_settings_sub_menu = true
				end
			end
		end
	end
end

OptionsView.trigger_menu_button_animation = function (self, widget)
	local destination = widget.style.right_detail.offset
	local from = 294
	local to = 304
	local new_animation = UIAnimation.init(UIAnimation.linear_scale, destination, 1, from, to, 0.1)

	UIWidget.animate(widget, new_animation)

	destination = widget.style.left_detail.offset
	from = 1
	to = -10
	new_animation = UIAnimation.init(UIAnimation.linear_scale, destination, 1, from, to, 0.1)

	UIWidget.animate(widget, new_animation)

	local to_color = Colors.color_definitions.white
	local from_color = widget.style.text.text_color
	new_animation = UIAnimation.init(UIAnimation.linear_scale_color, widget.style.text.text_color, from_color[2], from_color[3], from_color[4], to_color[2], to_color[3], to_color[4], 0.1)

	UIWidget.animate(widget, new_animation)
end

OptionsView.set_widget_values = function (self, settings_list)
	local widgets = settings_list.widgets
	local widgets_n = settings_list.widgets_n

	for i = 1, widgets_n, 1 do
		local widget = widgets[i]
		local saved_value_cb = widget.content.saved_value_cb

		saved_value_cb(widget)
	end
end

OptionsView.select_settings_list_widget = function (self, i)
	local selected_settings_list = self.selected_settings_list

	if not selected_settings_list then
		return
	end

	local selected_list_index = selected_settings_list.selected_index
	local list_widgets = selected_settings_list.widgets

	if selected_list_index then
		local deselect_widget = list_widgets[selected_list_index]

		self:deselect_settings_list_widget(deselect_widget)
	else
		self.gamepad_active_generic_actions_name = nil

		self:change_gamepad_generic_input_action()
	end

	local widget = list_widgets[i]
	widget.content.is_highlighted = true
	selected_settings_list.selected_index = i
	self.gamepad_tooltip_text_widget.content.text = widget.content.tooltip_text
	self.gamepad_tooltip_available = widget.content.tooltip_text ~= nil
	self.in_settings_sub_menu = true
	local widget_type = widget.type
	local widget_type_template = SettingsWidgetTypeTemplate[widget_type]
	local widget_input_description = widget_type_template.input_description

	if widget.content.disabled then
		self.menu_input_description:set_input_description(nil)
	else
		self.menu_input_description:set_input_description(widget_input_description)
	end
end

OptionsView.deselect_settings_list_widget = function (self, widget)
	widget.content.is_highlighted = false

	if widget.content.highlight_hotspot then
		table.clear(widget.content.highlight_hotspot)
	end

	self.menu_input_description:set_input_description(nil)
end

OptionsView.settings_list_widget_enter = function (self, i)
	local selected_settings_list = self.selected_settings_list

	if not selected_settings_list then
		return
	end

	local list_widgets = selected_settings_list.widgets
	local widget = list_widgets[i]
	widget.content.is_active = true
end

OptionsView.select_settings_title = function (self, i)
	self.menu_input_description:set_input_description(nil)

	if self.selected_title then
		self:deselect_title(self.selected_title)
	end

	local title_buttons = self.title_buttons
	local widget = title_buttons[i]
	local widget_scenegraph_id = widget.scenegraph_id
	local widget_current_position = self.ui_scenegraph[widget_scenegraph_id].local_position
	widget.content.button_hotspot.is_selected = true
	local gamepad_selection_scenegraph_id = self.gamepad_button_selection_widget.scenegraph_id
	local gamepad_selection_default_position = definitions.scenegraph_definition[gamepad_selection_scenegraph_id].position
	local gamepad_selection_current_position = self.ui_scenegraph[gamepad_selection_scenegraph_id].local_position
	gamepad_selection_current_position[2] = gamepad_selection_default_position[2] + widget_current_position[2]

	self:trigger_menu_button_animation(widget)

	self.selected_title = i
	local settings_list_name = SettingsMenuNavigation[i]

	fassert(self.settings_lists[settings_list_name], "No settings list called %q", settings_list_name)

	local settings_list = self.settings_lists[settings_list_name]

	if settings_list.scrollbar then
		self:setup_scrollbar(settings_list)
	end

	if settings_list.hide_reset then
		self.reset_to_default.content.hidden = true
	else
		self.reset_to_default.content.hidden = false
	end

	if settings_list_name == "calibrate_ui" then
		self.disable_all_input = true
	else
		self.disable_all_input = false
	end

	self:set_widget_values(settings_list)

	self.selected_settings_list = settings_list
end

OptionsView.deselect_title = function (self, i)
	self.selected_title = nil
	local selected_settings_list = self.selected_settings_list
	local selected_list_index = selected_settings_list.selected_index
	local list_widgets = selected_settings_list.widgets

	if selected_list_index then
		local deselect_widget = list_widgets[selected_list_index]

		self:deselect_settings_list_widget(deselect_widget)
	end

	self.selected_settings_list.selected_index = nil
	self.selected_settings_list = nil
	local widget = self.title_buttons[i]
	local button_hotspot = widget.content.button_hotspot
	button_hotspot.is_selected = false
	local destination = widget.style.right_detail.offset
	local from = 304
	local to = 294
	local new_animation = UIAnimation.init(UIAnimation.linear_scale, destination, 1, from, to, 0.1)

	UIWidget.animate(widget, new_animation)

	destination = widget.style.left_detail.offset
	from = -10
	to = 1
	new_animation = UIAnimation.init(UIAnimation.linear_scale, destination, 1, from, to, 0.1)

	UIWidget.animate(widget, new_animation)

	local to_color = Colors.color_definitions.cheeseburger
	local from_color = widget.style.text.text_color
	new_animation = UIAnimation.init(UIAnimation.linear_scale_color, widget.style.text.text_color, from_color[2], from_color[3], from_color[4], to_color[2], to_color[3], to_color[4], 0.1)

	UIWidget.animate(widget, new_animation)
end

OptionsView.handle_dropdown_lists = function (self, dropdown_lists, dropdown_lists_n)
	for i = 1, dropdown_lists_n, 1 do
		local ddl = dropdown_lists[i]
		local ddl_content = ddl.content
		local list_content = content.list_content

		for i = 1, #list_content, 1 do
			local content = list_content[i]

			if content.selected then
				ddl_content.callback(ddl_content.options, i)

				break
			end
		end
	end
end

OptionsView.setup_scrollbar = function (self, settings_list)
	local scrollbar = self.scrollbar
	local scenegraph_id = settings_list.scenegraph_id
	local settings_list_size_y = self.ui_scenegraph[scenegraph_id].size[2]
	local mask_size_y = self.ui_scenegraph.list_mask.size[2]
	local percentage = mask_size_y / settings_list_size_y
	scrollbar.content.scroll_bar_info.bar_height_percentage = percentage

	self:set_scrollbar_value(0)
end

OptionsView.update_mouse_scroll_input = function (self, disable_all_input)
	local selected_settings_list = self.selected_settings_list
	local using_scrollbar = selected_settings_list and selected_settings_list.scrollbar

	if using_scrollbar then
		local scrollbar = self.scrollbar
		local scroll_bar_value = scrollbar.content.scroll_bar_info.value

		if disable_all_input then
			self.scroll_field_widget.content.internal_scroll_value = scroll_bar_value
		end

		local mouse_scroll_value = self.scroll_field_widget.content.internal_scroll_value

		if not mouse_scroll_value then
			return
		end

		local current_scroll_value = self.scroll_value

		if current_scroll_value ~= mouse_scroll_value then
			self:set_scrollbar_value(mouse_scroll_value)
		elseif current_scroll_value ~= scroll_bar_value then
			self:set_scrollbar_value(scroll_bar_value)
		end
	end
end

OptionsView.set_scrollbar_value = function (self, value)
	local current_scroll_value = self.scroll_value

	if not current_scroll_value or value ~= current_scroll_value then
		local widget_scroll_bar_info = self.scrollbar.content.scroll_bar_info
		widget_scroll_bar_info.value = value
		self.scroll_field_widget.content.internal_scroll_value = value
		self.scroll_value = value
	end
end

OptionsView.change_gamepad_generic_input_action = function (self, reset_input_description)
	local in_settings_sub_menu = self.in_settings_sub_menu
	local actions_name_to_use = "default"
	local menu_name_to_use = (in_settings_sub_menu and "sub_menu") or "main_menu"
	local reset_disabled = self.reset_to_default.content.hidden or self.reset_to_default.content.button_hotspot.disabled
	local apply_disabled = self.apply_button.content.button_hotspot.disabled

	if not reset_disabled then
		if not apply_disabled then
			actions_name_to_use = "reset_and_apply"
		else
			actions_name_to_use = "reset"
		end
	elseif not apply_disabled then
		actions_name_to_use = "apply"
	end

	if not self.gamepad_active_generic_actions_name or self.gamepad_active_generic_actions_name ~= actions_name_to_use then
		self.gamepad_active_generic_actions_name = actions_name_to_use
		local actions_table = generic_input_actions[menu_name_to_use]
		local generic_actions = actions_table[actions_name_to_use]

		self.menu_input_description:change_generic_actions(generic_actions)
	end

	if reset_input_description then
		self.menu_input_description:set_input_description(nil)
	end
end

OptionsView.handle_controller_navigation_input = function (self, dt, input_service)
	self:change_gamepad_generic_input_action()

	if self.controller_cooldown > 0 then
		self.controller_cooldown = self.controller_cooldown - dt
		local speed_multiplier = self.speed_multiplier or 1
		local decrease = GamepadSettings.menu_speed_multiplier_frame_decrease
		local min_multiplier = GamepadSettings.menu_min_speed_multiplier
		self.speed_multiplier = math.max(speed_multiplier - decrease, min_multiplier)

		return
	else
		local in_settings_sub_menu = self.in_settings_sub_menu

		if in_settings_sub_menu then
			self.draw_gamepad_tooltip = self.gamepad_tooltip_available and input_service:get("cycle_previous_hold")

			if self.draw_gamepad_tooltip then
				return
			end

			local input_handled, is_active = self:handle_settings_list_widget_input(input_service, dt)

			if input_handled then
				if is_active ~= nil then
					self:set_selected_input_description_by_active(is_active)
				end

				return
			elseif input_service:get("back", true) then
				local selected_settings_list = self.selected_settings_list

				if selected_settings_list.scrollbar then
					self:setup_scrollbar(selected_settings_list)
				end

				in_settings_sub_menu = false
				self.in_settings_sub_menu = in_settings_sub_menu

				self:clear_console_setting_list_selection()

				self.gamepad_active_generic_actions_name = nil

				self:change_gamepad_generic_input_action(true)
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")

				if self:changes_been_made() then
					local text = Localize("unapplied_changes_popup_text")
					self.title_popup_id = Managers.popup:queue_popup(text, Localize("popup_discard_changes_topic"), "apply_changes", Localize("menu_settings_apply"), "revert_changes", Localize("popup_choice_discard"))
				end
			end
		elseif input_service:get("confirm") then
			in_settings_sub_menu = true
			self.in_settings_sub_menu = in_settings_sub_menu

			self:set_console_setting_list_selection(1, true, false)
		elseif input_service:get("back", true) then
			WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
			self:on_exit_pressed()
		end

		if in_settings_sub_menu then
			local speed_multiplier = self.speed_multiplier or 1
			local selected_settings_list = self.selected_settings_list
			local list_widgets = selected_settings_list.widgets
			local selected_list_index = selected_settings_list.selected_index or 0

			repeat

				-- Decompilation error in this vicinity:
				local move_up = input_service:get("move_up")
				local move_up_hold = input_service:get("move_up_hold")

				if move_up or move_up_hold then
					self.controller_cooldown = GamepadSettings.menu_cooldown * speed_multiplier

					self:set_console_setting_list_selection(selected_list_index - 1, false)

					return
				end

				local move_down = input_service:get("move_down")
				local move_down_hold = input_service:get("move_down_hold")
				self.controller_cooldown = GamepadSettings.menu_cooldown * speed_multiplier

				self:set_console_setting_list_selection(selected_list_index + 1, true)

				return
			until true
		else
			local speed_multiplier = self.speed_multiplier or 1
			local selected_title_index = self.selected_title or 0

			repeat
				local move_up = input_service:get("move_up")
				local move_up_hold = input_service:get("move_up_hold")

				if move_up or move_up_hold then
					self.controller_cooldown = GamepadSettings.menu_cooldown * speed_multiplier

					self:set_console_title_selection(selected_title_index - 1)

					return
				end

				local move_down = input_service:get("move_down")
				local move_down_hold = input_service:get("move_down_hold")

				if move_down or move_down_hold then
					self.controller_cooldown = GamepadSettings.menu_cooldown * speed_multiplier

					self:set_console_title_selection(selected_title_index + 1)

					return
				end
			until true
		end
	end

	local in_settings_sub_menu = 1
	self.speed_multiplier = in_settings_sub_menu
end

OptionsView.handle_mouse_widget_input = function (self, widget, input_service)
	local widget_type = widget.type

	self._input_functions[widget_type](widget, input_service)
end

OptionsView.handle_settings_list_widget_input = function (self, input_service, dt)
	local selected_settings_list = self.selected_settings_list
	local widgets = selected_settings_list.widgets

	if not selected_settings_list.selected_index then
		local selected_list_index = 1
	end

	local selected_widget = widgets[selected_list_index]
	local widgets_n = selected_settings_list.widgets_n

	if widgets_n == 0 or selected_widget.content.disabled then
		return false
	end

	local widget_type = selected_widget.type
	local widget_type_template = SettingsWidgetTypeTemplate[widget_type]
	local input_function = widget_type_template.input_function

	return input_function(selected_widget, input_service, dt)
end

OptionsView.set_console_title_selection = function (self, index, ignore_sound)
	local selected_title_index = self.selected_title

	if selected_title_index == index then
		return
	elseif not selected_title_index then
		index = 1
	end

	local number_of_menu_entries = #SettingsMenuNavigation

	if index > number_of_menu_entries or index <= 0 then
		return
	end

	if not ignore_sound then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
	end

	self:select_settings_title(index)
end

OptionsView.set_console_setting_list_selection = function (self, index, increment_if_disabled, ignore_sound)
	local selected_settings_list = self.selected_settings_list
	local selected_list_index = selected_settings_list.selected_index
	local list_widgets = selected_settings_list.widgets
	local widgets_n = selected_settings_list.widgets_n
	local new_index = index
	local widget = list_widgets[new_index]
	local is_valid_index = self:is_widget_selectable(widget)

	while not is_valid_index do
		if increment_if_disabled then
			new_index = math.min(new_index + 1, widgets_n + 1)
		else
			new_index = math.max(new_index - 1, 0)
		end

		if new_index < 1 or widgets_n < new_index then
			return
		end

		widget = list_widgets[new_index]
		is_valid_index = self:is_widget_selectable(widget)
	end

	if not ignore_sound then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
	end

	local using_scrollbar = selected_settings_list.scrollbar

	if using_scrollbar then
		self:move_scrollbar_based_on_selection(new_index)
	end

	self:select_settings_list_widget(new_index)
end

OptionsView.is_widget_selectable = function (self, widget)
	if widget then
		if widget.type == "image" or widget.type == "gamepad_layout" then
			slot2 = false
		else
			slot2 = true
		end
	end

	return slot2
end

OptionsView.clear_console_setting_list_selection = function (self)
	local selected_settings_list = self.selected_settings_list

	if not selected_settings_list then
		return
	end

	local selected_list_index = selected_settings_list.selected_index

	if selected_list_index then
		local list_widgets = selected_settings_list.widgets
		local deselect_widget = list_widgets[selected_list_index]

		self:deselect_settings_list_widget(deselect_widget)

		selected_settings_list.selected_index = nil
	end
end

OptionsView.move_scrollbar_based_on_selection = function (self, index)
	local selected_settings_list = self.selected_settings_list
	local selected_list_index = selected_settings_list.selected_index

	if not selected_list_index then
		slot4 = true
	elseif selected_list_index >= index then
		slot4 = false
	else
		local going_downwards = true
	end

	local widgets = selected_settings_list.widgets

	if not going_downwards or not widgets[index + 1] then
		local base_widget = widgets[index - 1]
	end

	if base_widget then
		local max_offset_y = selected_settings_list.max_offset_y
		local ui_scenegraph = self.ui_scenegraph
		local scenegraph_id_start = selected_settings_list.scenegraph_id_start
		local mask_pos = Vector3.deprecated_copy(UISceneGraph.get_world_position(ui_scenegraph, "list_mask"))
		local mask_size = UISceneGraph.get_size(ui_scenegraph, "list_mask")
		local list_position = UISceneGraph.get_world_position(ui_scenegraph, scenegraph_id_start)

		if selected_list_index then
			local selected_widget = widgets[selected_list_index]
			local selected_widget_offset = selected_widget.style.offset
			local selected_widget_size = selected_widget.style.size
			temp_pos_table.x = list_position[1] + selected_widget_offset[1]
			temp_pos_table.y = list_position[2] + selected_widget_offset[2]
			local selected_widget_visible = math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)
			temp_pos_table.y = temp_pos_table.y + selected_widget_size[2]

			if selected_widget_visible then
				selected_widget_visible = math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)
			end

			if not selected_widget_visible then
				local below_baseline = nil

				if list_position[2] + selected_widget_offset[2] < mask_pos[2] then
					below_baseline = true
				else
					below_baseline = false
				end

				if (not going_downwards and below_baseline) or (going_downwards and not below_baseline) then
					going_downwards = not going_downwards
					base_widget = selected_widget
				end
			end
		end

		local base_widget_style = base_widget.style
		local base_widget_size = base_widget_style.size
		local base_widget_offset = base_widget_style.offset
		temp_pos_table.x = list_position[1] + base_widget_offset[1]
		temp_pos_table.y = list_position[2] + base_widget_offset[2]
		local widget_visible = math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)
		temp_pos_table.y = temp_pos_table.y + base_widget_size[2]

		if widget_visible then
			widget_visible = math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)
		end

		if not widget_visible then
			local step = 0

			if going_downwards then
				local mask_pos_y = mask_pos[2]
				local widget_pos_y = list_position[2] + base_widget_offset[2]
				local diff = math.abs(mask_pos_y - widget_pos_y)
				step = diff / max_offset_y
			else
				local mask_upper_pos_y = mask_pos[2] + mask_size[2]
				local widget_upper_pos_y = temp_pos_table.y
				local diff = math.abs(mask_upper_pos_y - widget_upper_pos_y)
				step = -(diff / max_offset_y)
			end

			local scrollbar = self.scrollbar
			local value = scrollbar.content.scroll_bar_info.value

			self:set_scrollbar_value(math.clamp(value + step, 0, 1))
		end
	else
		local scrollbar = self.scrollbar

		if going_downwards then
			self:set_scrollbar_value(1)
		else
			self:set_scrollbar_value(0)
		end
	end
end

OptionsView.set_selected_input_description_by_active = function (self, is_active)
	local selected_settings_list = self.selected_settings_list

	if not selected_settings_list then
		return
	end

	local selected_list_index = selected_settings_list.selected_index
	local list_widgets = selected_settings_list.widgets
	local widget = list_widgets[selected_list_index]
	local is_disabled = widget.content.disabled
	local widget_type = widget.type
	local widget_type_template = SettingsWidgetTypeTemplate[widget_type]

	if not is_active or not widget_type_template.active_input_description then
		local widget_input_description = widget_type_template.input_description
	end

	if is_disabled then
		self.menu_input_description:set_input_description(nil)
	else
		self.menu_input_description:set_input_description(widget_input_description)
	end
end

OptionsView.animate_element_by_time = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, time, math.ease_out_quad)

	return new_animation
end

OptionsView.animate_element_by_catmullrom = function (self, target, target_index, target_value, p0, p1, p2, p3, time)
	local new_animation = UIAnimation.init(UIAnimation.catmullrom, target, target_index, target_value, p0, p1, p2, p3, time)

	return new_animation
end

OptionsView.on_stepper_arrow_pressed = function (self, widget, style_id)
	local widget_animations = widget.ui_animations
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local default_size = {
		28,
		34
	}
	local current_alpha = pass_style.color[1]
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = total_time

	if animation_duration > 0 then
		local animation_name_hover = "stepper_widget_arrow_hover_" .. style_id
		local animation_name_width = "stepper_widget_arrow_width_" .. style_id
		local animation_name_height = "stepper_widget_arrow_height_" .. style_id
		widget_animations[animation_name_hover] = self:animate_element_by_time(pass_style.color, 1, current_alpha, target_alpha, animation_duration)
		widget_animations[animation_name_width] = self:animate_element_by_catmullrom(pass_style.size, 1, default_size[1], 0.7, 1, 1, 0.7, animation_duration)
		widget_animations[animation_name_height] = self:animate_element_by_catmullrom(pass_style.size, 2, default_size[2], 0.7, 1, 1, 0.7, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end
end

OptionsView.on_stepper_arrow_hover = function (self, widget, style_id)
	local widget_animations = widget.ui_animations
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local current_alpha = pass_style.color[1]
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = (1 - current_alpha / target_alpha) * total_time

	if animation_duration > 0 then
		local animation_name_hover = "stepper_widget_arrow_hover_" .. style_id
		widget_animations[animation_name_hover] = self:animate_element_by_time(pass_style.color, 1, current_alpha, target_alpha, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end
end

OptionsView.on_stepper_arrow_dehover = function (self, widget, style_id)
	local widget_animations = widget.ui_animations
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local current_alpha = pass_style.color[1]
	local target_alpha = 0
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = current_alpha / 255 * total_time

	if animation_duration > 0 then
		local animation_name_hover = "stepper_widget_arrow_hover_" .. style_id
		widget_animations[animation_name_hover] = self:animate_element_by_time(pass_style.color, 1, current_alpha, target_alpha, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end
end

OptionsView.checkbox_test_setup = function (self)
	return false, "test"
end

OptionsView.checkbox_test_saved_value = function (self, widget)
	widget.content.flag = false
end

OptionsView.checkbox_test = function (self, content)
	local flag = content.flag

	print("OptionsView:checkbox_test(flag)", self, flag)
end

OptionsView.slider_test_setup = function (self)
	return 0.5, 5, 500, 0, "Music Volume"
end

OptionsView.slider_test_saved_value = function (self, widget)
	widget.content.value = 0.5
end

OptionsView.slider_test = function (self, content)
	local value = content.value

	print("OptionsView:slider_test(flag)", self, value)
end

OptionsView.drop_down_test_setup = function (self)
	local options = {
		{
			text = "1920x1080",
			value = {
				1920,
				1080
			}
		},
		{
			text = "1680x1050",
			value = {
				1680,
				1050
			}
		},
		{
			text = "1680x1050",
			value = {
				1680,
				1050
			}
		}
	}

	return 1, options, "Resolution"
end

OptionsView.drop_down_test_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local options_texts = widget.content.options_texts
	widget.content.selected_option = options_texts[1]
end

OptionsView.drop_down_test = function (self, content, i)
	print("OptionsView:dropdown_test(flag)", self, content, i)
end

OptionsView.cb_stepper_test_setup = function (self)
	local options = {
		{
			text = "value_1",
			value = 1
		},
		{
			text = "value_2_maddafakkaaa",
			value = 2
		},
		{
			text = "value_3_yobro",
			value = 3
		}
	}

	return 1, options, "stepper_test"
end

OptionsView.cb_stepper_test_saved_value = function (self, widget)
	widget.content.current_selection = 1
end

OptionsView.cb_stepper_test = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	local value = options_values[current_selection]

	print(value)
end

OptionsView.cb_vsync_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not Application.user_setting("vsync") then
		local vsync = false
	end

	if vsync then
		slot3 = 2
	else
		local selection = 1
	end

	if DefaultUserSettings.get("user_settings", "vsync") then
		slot4 = 2
	else
		local default_value = 1
	end

	return selection, options, "settings_menu_vsync", default_value
end

OptionsView.cb_vsync_saved_value = function (self, widget)
	local vsync = assigned(self.changed_user_settings.vsync, Application.user_setting("vsync"))
	slot3 = widget.content

	if vsync then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_vsync = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.vsync = options_values[current_selection]
end

OptionsView.cb_hud_screen_fit_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not Application.user_setting("use_hud_screen_fit") then
		local use_hud_screen_fit = false
	end

	if use_hud_screen_fit then
		slot3 = 2
	else
		local selection = 1
	end

	if DefaultUserSettings.get("user_settings", "use_hud_screen_fit") then
		slot4 = 2
	else
		local default_value = 1
	end

	return selection, options, "settings_menu_hud_screen_fit", default_value
end

OptionsView.cb_hud_screen_fit_saved_value = function (self, widget)
	local use_hud_screen_fit = assigned(self.changed_user_settings.use_hud_screen_fit, Application.user_setting("use_hud_screen_fit"))
	slot3 = widget.content

	if use_hud_screen_fit then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_hud_screen_fit = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_hud_screen_fit = options_values[current_selection]
end

OptionsView.cb_fullscreen_setup = function (self)
	local options = {
		{
			value = "fullscreen",
			text = Localize("menu_settings_fullscreen")
		},
		{
			value = "borderless_fullscreen",
			text = Localize("menu_settings_borderless_window")
		},
		{
			value = "windowed",
			text = Localize("menu_settings_windowed")
		}
	}
	local fullscreen = Application.user_setting("fullscreen")
	local borderless_fullscreen = Application.user_setting("borderless_fullscreen")

	if not fullscreen then
		slot4 = not borderless_fullscreen
	else
		slot4 = false

		if false then
			local windowed = true
		end
	end

	if fullscreen then
		slot5 = 1
	elseif borderless_fullscreen then
		slot5 = 2
	else
		local selected_option = 3
	end

	local default_fullscreen = DefaultUserSettings.get("user_settings", "fullscreen")
	local default_borderless_fullscreen = DefaultUserSettings.get("user_settings", "borderless_fullscreen")

	if default_fullscreen then
		slot8 = 1
	elseif borderless_fullscreen then
		slot8 = 2
	else
		local default_option = 3
	end

	return selected_option, options, "menu_settings_windowed_mode", default_option
end

OptionsView.cb_fullscreen_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local options_texts = widget.content.options_texts
	local fullscreen = assigned(self.changed_user_settings.fullscreen, Application.user_setting("fullscreen"))
	local borderless_fullscreen = assigned(self.changed_user_settings.borderless_fullscreen, Application.user_setting("borderless_fullscreen"))

	if not fullscreen then
		slot6 = not borderless_fullscreen
	else
		slot6 = false

		if false then
			local windowed = true
		end
	end

	if fullscreen then
		slot7 = 1
	elseif borderless_fullscreen then
		slot7 = 2
	else
		local selected_option = 3
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_fullscreen = function (self, content)
	local selected_index = content.current_selection
	local options_values = content.options_values
	local value = options_values[selected_index]
	local changed_user_settings = self.changed_user_settings

	if value == "fullscreen" then
		changed_user_settings.fullscreen = true
		changed_user_settings.borderless_fullscreen = false
	elseif value == "borderless_fullscreen" then
		changed_user_settings.fullscreen = false
		changed_user_settings.borderless_fullscreen = true
	elseif value == "windowed" then
		changed_user_settings.fullscreen = false
		changed_user_settings.borderless_fullscreen = false
	end

	if value == "borderless_fullscreen" then
		self:set_widget_disabled("resolutions", true)
	else
		self:set_widget_disabled("resolutions", false)
	end
end

OptionsView.cb_adapter_setup = function (self)
	local num_adapters = DisplayAdapter.num_adapters()
	local options = {}

	for i = 0, num_adapters - 1, 1 do
		options[#options + 1] = {
			text = tostring(i),
			value = i
		}
	end

	local adapter_index = Application.user_setting("adapter_index")
	local selected_option = adapter_index + 1
	local default_adapter = DefaultUserSettings.get("user_settings", "adapter_index")
	local default_option = default_adapter + 1

	return selected_option, options, "menu_settings_adapter", default_option
end

OptionsView.cb_adapter_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local adapter_index = assigned(self.changed_user_settings.adapter_index, Application.user_setting("adapter_index"))
	local selected_option = adapter_index + 1
	widget.content.current_selection = selected_option
end

OptionsView.cb_adapter = function (self, content, selected_index)
	local options_values = content.options_values
	local value = options_values[content.current_selection]
	self.changed_user_settings.adapter_index = value
end

OptionsView.cb_graphics_quality_setup = function (self)
	local options = {
		{
			value = "custom",
			text = Localize("menu_settings_custom")
		},
		{
			value = "lowest",
			text = Localize("menu_settings_lowest")
		},
		{
			value = "low",
			text = Localize("menu_settings_low")
		},
		{
			value = "medium",
			text = Localize("menu_settings_medium")
		},
		{
			value = "high",
			text = Localize("menu_settings_high")
		},
		{
			value = "extreme",
			text = Localize("menu_settings_extreme")
		}
	}
	local graphics_quality = Application.user_setting("graphics_quality")
	local selected_option = 1

	for i, step in ipairs(options) do
		if graphics_quality == step.value then
			selected_option = i

			break
		end
	end

	return selected_option, options, "menu_settings_graphics_quality", "high"
end

OptionsView.cb_graphics_quality_saved_value = function (self, widget)
	local graphics_quality = assigned(self.changed_user_settings.graphics_quality, Application.user_setting("graphics_quality"))
	local options_values = widget.content.options_values
	local selected_option = 1

	for i, value in ipairs(options_values) do
		if graphics_quality == value then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_graphics_quality = function (self, content)
	local options_values = content.options_values
	local value = options_values[content.current_selection]
	self.changed_user_settings.graphics_quality = value

	if value == "custom" then
		return
	end

	local settings = GraphicsQuality[value]
	local user_settings = settings.user_settings

	for setting, value in pairs(user_settings) do
		self.changed_user_settings[setting] = value
	end

	local render_settings = settings.render_settings

	for setting, value in pairs(render_settings) do
		self.changed_render_settings[setting] = value
	end

	local widgets = self.selected_settings_list.widgets
	local widgets_n = self.selected_settings_list.widgets_n

	for i = 1, widgets_n, 1 do
		local widget = widgets[i]

		if widget.name ~= "graphics_quality_settings" then
			local content = widget.content

			content.saved_value_cb(widget)
			content:callback(true)
		end
	end
end

OptionsView.cb_resolutions_setup = function (self)
	local screen_resolution = Application.user_setting("screen_resolution")
	local output_screen = Application.user_setting("fullscreen_output")
	local adapter_index = Application.user_setting("adapter_index")

	if DisplayAdapter.num_outputs(adapter_index) < 1 then
		local num_adapters = DisplayAdapter.num_adapters()

		for i = 0, num_adapters - 1, 1 do
			if DisplayAdapter.num_outputs(i) > 0 then
				adapter_index = i

				break
			end
		end
	end

	local options = {}
	local num_modes = DisplayAdapter.num_modes(adapter_index, output_screen)

	for i = 0, num_modes - 1, 1 do
		repeat
			local width, height = DisplayAdapter.mode(adapter_index, output_screen, i)

			if width < GameSettingsDevelopment.lowest_resolution then
				break
			end

			local text = tostring(width) .. "x" .. tostring(height)
			options[#options + 1] = {
				text = text,
				value = {
					width,
					height
				}
			}
		until true
	end

	local function comparator(a, b)
		if b.value[1] >= a.value[1] then
			slot2 = false
		else
			slot2 = true
		end

		return slot2
	end

	table.sort(options, comparator)

	local selected_option = nil

	for i = 1, #options, 1 do
		local resolution = options[i]

		if resolution.value[1] == screen_resolution[1] and resolution.value[2] == screen_resolution[2] then
			selected_option = i

			break
		end
	end

	return selected_option, options, "menu_settings_resolution"
end

OptionsView.cb_resolutions_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local options_texts = widget.content.options_texts
	local resolution = assigned(self.changed_user_settings.screen_resolution, Application.user_setting("screen_resolution"))
	local selected_option = nil

	for i = 1, #options_values, 1 do
		local value = options_values[i]

		if value[1] == resolution[1] and value[2] == resolution[2] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
	local fullscreen = assigned(self.changed_user_settings.fullscreen, Application.user_setting("fullscreen"))
	local borderless_fullscreen = assigned(self.changed_user_settings.borderless_fullscreen, Application.user_setting("borderless_fullscreen"))

	if not fullscreen and borderless_fullscreen then
		widget.content.disabled = true
	else
		widget.content.disabled = false
	end
end

OptionsView.cb_resolutions = function (self, content)
	local selected_index = content.current_selection
	local options_values = content.options_values
	local value = options_values[selected_index]
	self.changed_user_settings.screen_resolution = table.clone(value)
end

OptionsView.cb_lock_framerate_setup = function (self)
	local options = {
		{
			value = 0,
			text = Localize("menu_settings_off")
		},
		{
			text = "30",
			value = 30
		},
		{
			text = "60",
			value = 60
		},
		{
			text = "90",
			value = 90
		},
		{
			text = "120",
			value = 120
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "max_fps")
	local default_option = nil
	local selected_option = 1

	if not Application.user_setting("max_fps") then
		local max_fps = 0
	end

	for i = 1, #options, 1 do
		if max_fps == options[i].value then
			selected_option = i
		end

		if default_value == options[i].value then
			default_option = i
		end
	end

	return selected_option, options, "menu_settings_lock_framerate", default_option
end

OptionsView.cb_lock_framerate_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local options_texts = widget.content.options_texts
	local selected_option = nil

	if not assigned(self.changed_user_settings.max_fps, Application.user_setting("max_fps")) then
		local max_fps = 0
	end

	for i = 1, #options_values, 1 do
		if max_fps == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_lock_framerate = function (self, content)
	local selected_index = content.current_selection
	local value = content.options_values[selected_index]
	self.changed_user_settings.max_fps = value
end

OptionsView.cb_max_stacking_frames_setup = function (self)
	local options = {
		{
			value = -1,
			text = Localize("menu_settings_auto")
		},
		{
			text = "1",
			value = 1
		},
		{
			text = "2",
			value = 2
		},
		{
			text = "3",
			value = 3
		},
		{
			text = "4",
			value = 4
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "max_stacking_frames")
	local default_option = nil
	local selected_option = 1

	if not Application.user_setting("max_stacking_frames") then
		local max_stacking_frames = -1
	end

	for i = 1, #options, 1 do
		if max_stacking_frames == options[i].value then
			selected_option = i
		end

		if default_value == options[i].value then
			default_option = i
		end
	end

	return selected_option, options, "menu_settings_max_stacking_frames", default_option
end

OptionsView.cb_max_stacking_frames_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local current_selection = nil

	if not assigned(self.changed_user_settings.max_stacking_frames, Application.user_setting("max_stacking_frames")) then
		local max_stacking_frames = -1
	end

	for i = 1, #options_values, 1 do
		if max_stacking_frames == options_values[i] then
			current_selection = i

			break
		end
	end

	widget.content.current_selection = current_selection
end

OptionsView.cb_max_stacking_frames = function (self, content)
	self.changed_user_settings.max_stacking_frames = content.options_values[content.current_selection]
end

OptionsView.cb_anti_aliasing_setup = function (self)
	local options = {
		{
			value = "none",
			text = Localize("menu_settings_none")
		},
		{
			value = "FXAA",
			text = Localize("menu_settings_fxaa")
		},
		{
			value = "TAA",
			text = Localize("menu_settings_taa")
		}
	}
	local fxaa_enabled = Application.user_setting("render_settings", "fxaa_enabled")
	local taa_enabled = Application.user_setting("render_settings", "taa_enabled")

	if fxaa_enabled then
		slot4 = 2
	elseif taa_enabled then
		slot4 = 3
	else
		local selected_option = 1
	end

	local default_fxaa_enabled = DefaultUserSettings.get("render_settings", "fxaa_enabled")
	local default_taa_enabled = DefaultUserSettings.get("render_settings", "taa_enabled")

	if default_fxaa_enabled then
		slot7 = 2
	elseif default_taa_enabled then
		slot7 = 3
	else
		local default_option = 1
	end

	return selected_option, options, "menu_settings_anti_aliasing", default_option
end

OptionsView.cb_anti_aliasing_saved_value = function (self, widget)
	local fxaa_enabled = assigned(self.changed_render_settings.fxaa_enabled, Application.user_setting("render_settings", "fxaa_enabled"))
	local taa_enabled = assigned(self.changed_render_settings.taa_enabled, Application.user_setting("render_settings", "taa_enabled"))

	if fxaa_enabled then
		slot4 = 2
	elseif taa_enabled then
		slot4 = 3
	else
		local selected_option = 1
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_anti_aliasing = function (self, content, called_from_graphics_quality)
	local selected_index = content.current_selection
	local value = content.options_values[selected_index]

	if value == "FXAA" then
		self.changed_render_settings.fxaa_enabled = true
		self.changed_render_settings.taa_enabled = false
	elseif value == "TAA" then
		self.changed_render_settings.fxaa_enabled = false
		self.changed_render_settings.taa_enabled = true
	else
		self.changed_render_settings.fxaa_enabled = false
		self.changed_render_settings.taa_enabled = false
	end

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_gamma_setup = function (self)
	local min = 1.5
	local max = 5

	if not Application.user_setting("render_settings", "gamma") then
		local gamma = 2.2
	end

	local value = get_slider_value(min, max, gamma)
	local default_value = math.clamp(DefaultUserSettings.get("render_settings", "gamma"), min, max)

	Application.set_render_setting("gamma", gamma)

	return value, min, max, 1, "menu_settings_gamma", default_value
end

OptionsView.cb_gamma_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_render_settings.gamma, Application.user_setting("render_settings", "gamma")) then
		local gamma = 2.2
	end

	gamma = math.clamp(gamma, min, max)
	content.internal_value = get_slider_value(min, max, gamma)
	content.value = gamma
end

OptionsView.cb_gamma = function (self, content)
	self.changed_render_settings.gamma = content.value

	Application.set_render_setting("gamma", content.value)
end

OptionsView.cb_sun_shadows_setup = function (self)
	local options = {
		{
			value = "off",
			text = Localize("menu_settings_off")
		},
		{
			value = "low",
			text = Localize("menu_settings_low")
		},
		{
			value = "medium",
			text = Localize("menu_settings_medium")
		},
		{
			value = "high",
			text = Localize("menu_settings_high")
		},
		{
			value = "extreme",
			text = Localize("menu_settings_extreme")
		}
	}
	local sun_shadows = Application.user_setting("render_settings", "sun_shadows")
	local sun_shadow_quality = Application.user_setting("sun_shadow_quality")
	local selection = nil

	if sun_shadows then
		if sun_shadow_quality == "low" then
			selection = 2
		elseif sun_shadow_quality == "medium" then
			selection = 3
		elseif sun_shadow_quality == "high" then
			selection = 4
		elseif sun_shadow_quality == "extreme" then
			selection = 5
		end
	else
		selection = 1
	end

	return selection, options, "menu_settings_sun_shadows"
end

OptionsView.cb_sun_shadows_saved_value = function (self, widget)
	local sun_shadows = assigned(self.changed_render_settings.sun_shadows, Application.user_setting("render_settings", "sun_shadows"))
	local sun_shadow_quality = assigned(self.changed_user_settings.sun_shadow_quality, Application.user_setting("sun_shadow_quality"))
	local selection = nil

	if sun_shadows then
		if sun_shadow_quality == "low" then
			selection = 2
		elseif sun_shadow_quality == "medium" then
			selection = 3
		elseif sun_shadow_quality == "high" then
			selection = 4
		elseif sun_shadow_quality == "extreme" then
			selection = 5
		end
	else
		selection = 1
	end

	widget.content.current_selection = selection
end

OptionsView.cb_sun_shadows = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	local sun_shadow_quality = nil
	local value = options_values[current_selection]

	if value == "off" then
		self.changed_render_settings.sun_shadows = false
		sun_shadow_quality = "low"
	else
		self.changed_render_settings.sun_shadows = true
		sun_shadow_quality = value
	end

	self.changed_user_settings.sun_shadow_quality = sun_shadow_quality
	local sun_shadow_quality_settings = SunShadowQuality[sun_shadow_quality]

	for setting, key in pairs(sun_shadow_quality_settings) do
		self.changed_render_settings[setting] = key
	end

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_lod_quality_setup = function (self)
	local options = {
		{
			value = 0.6,
			text = Localize("menu_settings_low")
		},
		{
			value = 0.8,
			text = Localize("menu_settings_medium")
		},
		{
			value = 1,
			text = Localize("menu_settings_high")
		}
	}
	local default_value = DefaultUserSettings.get("render_settings", "lod_object_multiplier")
	local default_option = nil

	if not Application.user_setting("render_settings", "lod_object_multiplier") then
		local saved_option = 1
	end

	local selected_option = 1

	for i = 1, #options, 1 do
		if saved_option == options[i].value then
			selected_option = i
		end

		if default_value == options[i].value then
			default_option = i
		end
	end

	return selected_option, options, "menu_settings_lod_quality", default_option
end

OptionsView.cb_lod_quality_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local selected_option = 1

	if not assigned(self.changed_render_settings.lod_object_multiplier, Application.user_setting("render_settings", "lod_object_multiplier")) then
		local lod_object_multiplier = 1
	end

	for i = 1, #options_values, 1 do
		if lod_object_multiplier == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_lod_quality = function (self, content)
	if not content.options_values[content.current_selection] then
		local value = 1
	end

	self.changed_render_settings.lod_object_multiplier = value
end

OptionsView.cb_scatter_density_setup = function (self)
	local options = {
		{
			value = 0,
			text = Localize("menu_settings_off")
		},
		{
			text = "25%",
			value = 0.25
		},
		{
			text = "50%",
			value = 0.5
		},
		{
			text = "75%",
			value = 0.75
		},
		{
			text = "100%",
			value = 1
		}
	}
	local default_value = DefaultUserSettings.get("render_settings", "lod_scatter_density")
	local default_option = nil

	if not Application.user_setting("render_settings", "lod_scatter_density") then
		local saved_option = 1
	end

	local selected_option = 1

	for i = 1, #options, 1 do
		if saved_option == options[i].value then
			selected_option = i
		end

		if default_value == options[i].value then
			default_option = i
		end
	end

	return selected_option, options, "menu_settings_scatter_density", default_option
end

OptionsView.cb_scatter_density_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local selected_option = 1

	if not assigned(self.changed_render_settings.lod_scatter_density, Application.user_setting("render_settings", "lod_scatter_density")) then
		local lod_scatter_density = 1
	end

	for i = 1, #options_values, 1 do
		if lod_scatter_density == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_scatter_density = function (self, content, called_from_graphics_quality)
	if not content.options_values[content.current_selection] then
		local value = 1
	end

	self.changed_render_settings.lod_scatter_density = value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_decoration_density_setup = function (self)
	local options = {
		{
			value = 0,
			text = Localize("menu_settings_off")
		},
		{
			text = "25%",
			value = 0.25
		},
		{
			text = "50%",
			value = 0.5
		},
		{
			text = "75%",
			value = 0.75
		},
		{
			text = "100%",
			value = 1
		}
	}

	if not Application.user_setting("render_settings", "lod_decoration_density") then
		local saved_option = 1
	end

	local selected_option = 1

	for i = 1, #options, 1 do
		if saved_option == options[i].value then
			selected_option = i

			break
		end
	end

	return selected_option, options, "menu_settings_decoration_density"
end

OptionsView.cb_decoration_density_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local selected_option = 1

	if not assigned(self.changed_render_settings.lod_decoration_density, Application.user_setting("render_settings", "lod_decoration_density")) then
		local lod_decoration_density = 1
	end

	for i = 1, #options_values, 1 do
		if lod_decoration_density == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_decoration_density = function (self, content)
	if not content.options_values[content.current_selection] then
		local value = 1
	end

	self.changed_render_settings.lod_decoration_density = value
end

OptionsView.cb_maximum_shadow_casting_lights_setup = function (self)
	local min = 1
	local max = 10
	local max_shadow_casting_lights = Application.user_setting("render_settings", "max_shadow_casting_lights")
	local value = get_slider_value(min, max, max_shadow_casting_lights)

	return value, min, max, 0, "menu_settings_maximum_shadow_casting_lights"
end

OptionsView.cb_maximum_shadow_casting_lights_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local max_shadow_casting_lights = assigned(self.changed_render_settings.max_shadow_casting_lights, Application.user_setting("render_settings", "max_shadow_casting_lights"))
	max_shadow_casting_lights = math.clamp(max_shadow_casting_lights, min, max)
	content.internal_value = get_slider_value(min, max, max_shadow_casting_lights)
	content.value = max_shadow_casting_lights
end

OptionsView.cb_maximum_shadow_casting_lights = function (self, content, called_from_graphics_quality)
	self.changed_render_settings.max_shadow_casting_lights = content.value

	for i = 1, 10, 1 do
		print("max_shadow_casting_lights", content.value)
	end

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_local_light_shadow_quality_setup = function (self)
	local options = {
		{
			value = "off",
			text = Localize("menu_settings_off")
		},
		{
			value = "low",
			text = Localize("menu_settings_low")
		},
		{
			value = "medium",
			text = Localize("menu_settings_medium")
		},
		{
			value = "high",
			text = Localize("menu_settings_high")
		},
		{
			value = "extreme",
			text = Localize("menu_settings_extreme")
		}
	}
	local local_light_shadow_quality = Application.user_setting("local_light_shadow_quality")
	local deferred_local_lights_cast_shadows = Application.user_setting("render_settings", "deferred_local_lights_cast_shadows")
	local forward_local_lights_cast_shadows = Application.user_setting("render_settings", "forward_local_lights_cast_shadows")
	local selection = nil

	if not deferred_local_lights_cast_shadows or not forward_local_lights_cast_shadows then
		selection = 1
	elseif local_light_shadow_quality == "low" then
		selection = 2
	elseif local_light_shadow_quality == "medium" then
		selection = 3
	elseif local_light_shadow_quality == "high" then
		selection = 4
	elseif local_light_shadow_quality == "extreme" then
		selection = 5
	end

	return selection, options, "menu_settings_local_light_shadow_quality"
end

OptionsView.cb_local_light_shadow_quality_saved_value = function (self, widget)
	local local_light_shadow_quality = assigned(self.changed_user_settings.local_light_shadow_quality, Application.user_setting("local_light_shadow_quality"))
	local deferred_local_lights_cast_shadows = assigned(self.changed_render_settings.deferred_local_lights_cast_shadows, Application.user_setting("render_settings", "deferred_local_lights_cast_shadows"))
	local forward_local_lights_cast_shadows = assigned(self.changed_render_settings.forward_local_lights_cast_shadows, Application.user_setting("render_settings", "forward_local_lights_cast_shadows"))
	local selection = nil

	if not deferred_local_lights_cast_shadows or not forward_local_lights_cast_shadows then
		selection = 1
	elseif local_light_shadow_quality == "low" then
		selection = 2
	elseif local_light_shadow_quality == "medium" then
		selection = 3
	elseif local_light_shadow_quality == "high" then
		selection = 4
	elseif local_light_shadow_quality == "extreme" then
		selection = 5
	end

	widget.content.current_selection = selection
end

OptionsView.cb_local_light_shadow_quality = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	local local_light_shadow_quality = nil

	if value == "off" then
		self.changed_render_settings.deferred_local_lights_cast_shadows = false
		self.changed_render_settings.forward_local_lights_cast_shadows = false
		local_light_shadow_quality = "low"
	else
		self.changed_render_settings.deferred_local_lights_cast_shadows = true
		self.changed_render_settings.forward_local_lights_cast_shadows = true
		local_light_shadow_quality = value
	end

	self.changed_user_settings.local_light_shadow_quality = local_light_shadow_quality
	local local_light_shadow_quality_settings = LocalLightShadowQuality[local_light_shadow_quality]

	for setting, key in pairs(local_light_shadow_quality_settings) do
		self.changed_render_settings[setting] = key
	end

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_motion_blur_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not Application.user_setting("render_settings", "motion_blur_enabled") then
		local motion_blur_enabled = true
	end

	if motion_blur_enabled then
		slot3 = 2
	else
		local selected_option = 1
	end

	return selected_option, options, "menu_settings_motion_blur"
end

OptionsView.cb_motion_blur_saved_value = function (self, widget)
	local motion_blur_enabled = assigned(self.changed_render_settings.motion_blur_enabled, Application.user_setting("render_settings", "motion_blur_enabled"))

	if motion_blur_enabled then
		slot3 = 2
	else
		local selected_option = 1
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_motion_blur = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.motion_blur_enabled = value

	if PLATFORM == "win32" and not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_dof_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}
	local dof_enabled = Application.user_setting("render_settings", "dof_enabled")

	if dof_enabled then
		slot3 = 2
	else
		local selected_option = 1
	end

	return selected_option, options, "menu_settings_dof"
end

OptionsView.cb_dof_saved_value = function (self, widget)
	local dof_enabled = assigned(self.changed_render_settings.dof_enabled, Application.user_setting("render_settings", "dof_enabled"))

	if dof_enabled then
		slot3 = 2
	else
		local selected_option = 1
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_dof = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.dof_enabled = value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_bloom_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not Application.user_setting("render_settings", "bloom_enabled") then
		local bloom_enabled = false
	end

	local default_value = DefaultUserSettings.get("render_settings", "bloom_enabled")

	if bloom_enabled then
		slot4 = 2
	else
		local selection = 1
	end

	if default_value then
		slot5 = 2
	else
		local default_option = 1
	end

	return selection, options, "menu_settings_bloom", default_option
end

OptionsView.cb_bloom_saved_value = function (self, widget)
	if not assigned(self.changed_render_settings.bloom_enabled, Application.user_setting("render_settings", "bloom_enabled")) then
		local bloom_enabled = false
	end

	slot3 = widget.content

	if bloom_enabled then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_bloom = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_render_settings.bloom_enabled = options_values[current_selection]

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_light_shafts_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not Application.user_setting("render_settings", "light_shaft_enabled") then
		local light_shaft_enabled = false
	end

	local default_value = DefaultUserSettings.get("render_settings", "light_shaft_enabled")

	if light_shaft_enabled then
		slot4 = 2
	else
		local selection = 1
	end

	if default_value then
		slot5 = 2
	else
		local default_option = 1
	end

	return selection, options, "menu_settings_light_shafts", default_option
end

OptionsView.cb_light_shafts_saved_value = function (self, widget)
	if not assigned(self.changed_render_settings.light_shaft_enabled, Application.user_setting("render_settings", "light_shaft_enabled")) then
		local light_shaft_enabled = false
	end

	slot3 = widget.content

	if light_shaft_enabled then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_light_shafts = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_render_settings.light_shaft_enabled = options_values[current_selection]

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_skin_shading_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not Application.user_setting("render_settings", "skin_material_enabled") then
		local skin_material_enabled = false
	end

	local default_value = DefaultUserSettings.get("render_settings", "skin_material_enabled")

	if skin_material_enabled then
		slot4 = 2
	else
		local selection = 1
	end

	if default_value then
		slot5 = 2
	else
		local default_option = 1
	end

	return selection, options, "menu_settings_skin_shading", default_option
end

OptionsView.cb_skin_shading_saved_value = function (self, widget)
	if not assigned(self.changed_render_settings.skin_material_enabled, Application.user_setting("render_settings", "skin_material_enabled")) then
		local skin_material_enabled = false
	end

	slot3 = widget.content

	if skin_material_enabled then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_skin_shading = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_render_settings.skin_material_enabled = options_values[current_selection]

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_ssao_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}
	local ao_enabled = Application.user_setting("render_settings", "ao_enabled")

	if ao_enabled then
		slot3 = 2
	else
		local selected_option = 1
	end

	return selected_option, options, "menu_settings_ssao"
end

OptionsView.cb_ssao_saved_value = function (self, widget)
	local ao_enabled = assigned(self.changed_render_settings.ao_enabled, Application.user_setting("render_settings", "ao_enabled"))

	if ao_enabled then
		slot3 = 2
	else
		local selected_option = 1
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_ssao = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.ao_enabled = value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_char_texture_quality_setup = function (self)
	local options = {
		{
			value = "low",
			text = Localize("menu_settings_low")
		},
		{
			value = "medium",
			text = Localize("menu_settings_medium")
		},
		{
			value = "high",
			text = Localize("menu_settings_high")
		},
		{
			value = "extreme",
			text = Localize("menu_settings_extreme")
		}
	}
	local char_texture_quality = Application.user_setting("char_texture_quality")
	local default_value = DefaultUserSettings.get("user_settings", "char_texture_quality")
	local selected_option = 1
	local default_option = nil

	for i = 1, #options, 1 do
		if char_texture_quality == options[i].value then
			selected_option = i
		end

		if default_value == options[i].value then
			default_option = i
		end
	end

	return selected_option, options, "menu_settings_char_texture_quality", default_option
end

OptionsView.cb_char_texture_quality_saved_value = function (self, widget)
	local char_texture_quality = assigned(self.changed_user_settings.char_texture_quality, Application.user_setting("char_texture_quality"))
	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if char_texture_quality == options_values[i] then
			selected_option = i
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_char_texture_quality = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.char_texture_quality = value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_env_texture_quality_setup = function (self)
	local options = {
		{
			value = "low",
			text = Localize("menu_settings_low")
		},
		{
			value = "medium",
			text = Localize("menu_settings_medium")
		},
		{
			value = "high",
			text = Localize("menu_settings_high")
		}
	}
	local env_texture_quality = Application.user_setting("env_texture_quality")
	local default_value = DefaultUserSettings.get("user_settings", "env_texture_quality")
	local selected_option = 1
	local default_option = nil

	for i = 1, #options, 1 do
		if env_texture_quality == options[i].value then
			selected_option = i
		end

		if default_value == options[i].value then
			default_option = i
		end
	end

	return selected_option, options, "menu_settings_env_texture_quality", default_option
end

OptionsView.cb_env_texture_quality_saved_value = function (self, widget)
	local env_texture_quality = assigned(self.changed_user_settings.env_texture_quality, Application.user_setting("env_texture_quality"))
	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if env_texture_quality == options_values[i] then
			selected_option = i
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_env_texture_quality = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.env_texture_quality = value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_subtitles_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not Application.user_setting("use_subtitles") then
		local use_subtitles = false
	end

	if use_subtitles then
		slot3 = 2
	else
		local selection = 1
	end

	if DefaultUserSettings.get("user_settings", "use_subtitles") then
		slot4 = 2
	else
		local default_value = 1
	end

	return selection, options, "menu_settings_subtitles", default_value
end

OptionsView.cb_subtitles_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.use_subtitles, Application.user_setting("use_subtitles")) then
		local use_subtitles = false
	end

	slot3 = widget.content

	if use_subtitles then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_subtitles = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_subtitles = options_values[current_selection]
end

OptionsView.cb_language_setup = function (self)
	local options = {
		{
			value = "en",
			text = Localize("english")
		},
		{
			value = "fr",
			text = Localize("french")
		},
		{
			value = "pl",
			text = Localize("polish")
		},
		{
			value = "es",
			text = Localize("spanish")
		},
		{
			value = "tr",
			text = Localize("turkish")
		},
		{
			value = "de",
			text = Localize("german")
		},
		{
			value = "br-pt",
			text = Localize("brazilian")
		},
		{
			value = "ru",
			text = Localize("russian")
		}
	}

	if not Application.user_setting("language_id") and (not rawget(_G, "Steam") or not Steam.language()) then
		local language_id = "en"
	end

	if not DefaultUserSettings.get("user_settings", "language_id") then
		local default_value = "en"
	end

	local selection = 1

	for idx, option in ipairs(options) do
		if option.value == language_id then
			selection = idx
		end

		if option.value == default_value then
			default_value = idx
		end
	end

	return selection, options, "menu_settings_language", default_value
end

OptionsView.cb_language_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.language_id, Application.user_setting("language_id")) then
		local language_id = "en"
	end

	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if language_id == options_values[i] then
			selected_option = i
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_language = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.language_id = options_values[current_selection]
end

OptionsView.reload_language = function (self, language_id)
	if Managers.package:has_loaded("resource_packages/strings", "boot") then
		Managers.package:unload("resource_packages/strings", "boot")
	end

	Application.set_resource_property_preference_order(language_id)
	Managers.package:load("resource_packages/strings", "boot")
	Managers.package:load("resource_packages/post_localization_boot", "boot")

	Managers.localizer = LocalizationManager:new("localization/game", language_id)

	local function tweak_parser(tweak_name)
		if not LocalizerTweakData[tweak_name] then
			slot1 = "<missing LocalizerTweakData \"" .. tweak_name .. "\">"
		end

		return slot1
	end

	Managers.localizer:add_macro("TWEAK", tweak_parser)

	local function key_parser(input_service_and_key_name)
		local split_start, split_end = string.find(input_service_and_key_name, "__")
		slot3 = assert

		if split_start then
			slot4 = split_end
		end

		slot3(slot4, "[key_parser] You need to specify a key using this format $KEY;<input_service>__<key>. Example: $KEY;options_menu__back (note the dubbel underline separating input service and key")

		local input_service_name = string.sub(input_service_and_key_name, 1, split_start - 1)
		local key_name = string.sub(input_service_and_key_name, split_end + 1)
		local input_service = Managers.input:get_service(input_service_name)

		fassert(input_service, "[key_parser] No input service with the name %s", input_service_name)

		local key = input_service:get_keymapping(key_name)

		fassert(key, "[key_parser] There is no such key: %s in input service: %s", key_name, input_service_name)

		local device = Managers.input:get_most_recent_device()
		local device_type = InputAux.get_device_type(device)
		local button_index = nil

		for _, mapping in ipairs(key.input_mappings) do
			if mapping[1] == device_type then
				button_index = mapping[2]

				break
			end
		end

		local key_locale_name = nil

		if button_index then
			key_locale_name = device.button_name(button_index)

			if device_type == "keyboard" and not device.button_locale_name(button_index) then
				key_locale_name = key_locale_name
			end

			if device_type == "mouse" then
				key_locale_name = string.format("%s %s", "mouse", key_locale_name)
			end
		else
			local button_index = nil
			local default_device_type = "keyboard"

			for _, mapping in ipairs(key.input_mappings) do
				if mapping[1] == default_device_type then
					button_index = mapping[2]

					break
				end
			end

			if button_index then
				key_locale_name = Keyboard.button_name(button_index)

				if not Keyboard.button_locale_name(button_index) then
					key_locale_name = key_locale_name
				end
			else
				key_locale_name = string.format("<Mapping missing for key %s on device %s>", key_name, device_type)
			end
		end

		return key_locale_name
	end

	Managers.localizer:add_macro("KEY", key_parser)
end

OptionsView.cb_mouse_look_sensitivity_setup = function (self)
	local min = -10
	local max = 10

	if not Application.user_setting("mouse_look_sensitivity") then
		local sensitivity = 0
	end

	local default_value = DefaultUserSettings.get("user_settings", "mouse_look_sensitivity")
	local value = get_slider_value(min, max, sensitivity)
	sensitivity = math.clamp(sensitivity, min, max)
	local platform_key = "win32"
	local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
	local base_look_multiplier = base_filter.look.multiplier
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service:get_active_filters(platform_key)
	local look_filter = input_filters.look
	local function_data = look_filter.function_data
	function_data.multiplier = base_look_multiplier * 0.85^(-sensitivity)

	return value, min, max, 1, "menu_settings_mouse_look_sensitivity", default_value
end

OptionsView.cb_mouse_look_sensitivity_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.mouse_look_sensitivity, Application.user_setting("mouse_look_sensitivity")) then
		local sensitivity = 0
	end

	sensitivity = math.clamp(sensitivity, min, max)
	content.internal_value = get_slider_value(min, max, sensitivity)
	content.value = sensitivity
end

OptionsView.cb_mouse_look_sensitivity = function (self, content)
	self.changed_user_settings.mouse_look_sensitivity = content.value
end

OptionsView.cb_ui_scale_setup = function (self)
	local min = 70
	local max = 100

	if PLATFORM == "xb1" then
		local console_type = XboxOne.console_type()

		if console_type == XboxOne.CONSOLE_TYPE_XBOX_ONE_X_DEVKIT or console_type == XboxOne.CONSOLE_TYPE_XBOX_ONE_X then
			max = 200
		end
	end

	if not Application.user_setting("ui_scale") then
		local ui_scale = 100
	end

	local value = get_slider_value(min, max, ui_scale)
	local default_value = math.clamp(DefaultUserSettings.get("user_settings", "ui_scale"), min, max)

	return value, min, max, 1, "settings_menu_ui_scale", default_value
end

OptionsView.cb_ui_scale_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.ui_scale, Application.user_setting("ui_scale")) then
		local ui_scale = 100
	end

	ui_scale = math.clamp(ui_scale, min, max)
	content.internal_value = get_slider_value(min, max, ui_scale)
	content.value = ui_scale
end

OptionsView.cb_ui_scale = function (self, content)
	local value = content.value
	self.changed_user_settings.ui_scale = value
	UISettings.ui_scale = value
	local force_update = true

	UPDATE_RESOLUTION_LOOKUP(force_update)
end

OptionsView.cb_gamepad_look_sensitivity_setup = function (self)
	local min = -10
	local max = 10

	if not Application.user_setting("gamepad_look_sensitivity") then
		local sensitivity = 0
	end

	local default_value = DefaultUserSettings.get("user_settings", "gamepad_look_sensitivity")
	local value = get_slider_value(min, max, sensitivity)
	sensitivity = math.clamp(sensitivity, min, max)

	if self.platform == "win32" then
		slot6 = "xb1"
	else
		local platform_key = self.platform
	end

	local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
	local base_look_multiplier = base_filter.look_controller.multiplier_x
	local base_melee_look_multiplier = base_filter.look_controller_melee.multiplier_x
	local base_ranged_look_multiplier = base_filter.look_controller_ranged.multiplier_x
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service:get_active_filters(platform_key)
	local look_filter = input_filters.look_controller
	local function_data = look_filter.function_data
	function_data.multiplier_x = base_look_multiplier * 0.85^(-sensitivity)

	if not base_filter.look_controller.multiplier_min_x or not (base_filter.look_controller.multiplier_min_x * 0.85^(-sensitivity)) then
		slot15 = function_data.multiplier_x * 0.25
	end

	function_data.min_multiplier_x = slot15
	local melee_look_filter = input_filters.look_controller_melee
	local function_data = melee_look_filter.function_data
	function_data.multiplier_x = base_melee_look_multiplier * 0.85^(-sensitivity)

	if not base_filter.look_controller_melee.multiplier_min_x or not (base_filter.look_controller_melee.multiplier_min_x * 0.85^(-sensitivity)) then
		slot17 = function_data.multiplier_x * 0.25
	end

	function_data.min_multiplier_x = slot17
	local ranged_look_filter = input_filters.look_controller_ranged
	local function_data = ranged_look_filter.function_data
	function_data.multiplier_x = base_ranged_look_multiplier * 0.85^(-sensitivity)

	if not base_filter.look_controller_ranged.multiplier_min_x or not (base_filter.look_controller_ranged.multiplier_min_x * 0.85^(-sensitivity)) then
		slot19 = function_data.multiplier_x * 0.25
	end

	function_data.min_multiplier_x = slot19

	return value, min, max, 1, "menu_settings_gamepad_look_sensitivity", default_value
end

OptionsView.cb_gamepad_look_sensitivity_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.gamepad_look_sensitivity, Application.user_setting("gamepad_look_sensitivity")) then
		local sensitivity = 0
	end

	sensitivity = math.clamp(sensitivity, min, max)
	content.internal_value = get_slider_value(min, max, sensitivity)
	content.value = sensitivity
end

OptionsView.cb_gamepad_look_sensitivity = function (self, content)
	self.changed_user_settings.gamepad_look_sensitivity = content.value
end

OptionsView.cb_gamepad_look_sensitivity_y_setup = function (self)
	local min = -10
	local max = 10

	if not Application.user_setting("gamepad_look_sensitivity_y") then
		local sensitivity = 0
	end

	local default_value = DefaultUserSettings.get("user_settings", "gamepad_look_sensitivity_y")
	local value = get_slider_value(min, max, sensitivity)
	sensitivity = math.clamp(sensitivity, min, max)

	if self.platform == "win32" then
		slot6 = "xb1"
	else
		local platform_key = self.platform
	end

	local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
	local base_look_multiplier = base_filter.look_controller.multiplier_y
	local base_melee_look_multiplier = base_filter.look_controller_melee.multiplier_y
	local base_ranged_look_multiplier = base_filter.look_controller_ranged.multiplier_y
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service:get_active_filters(platform_key)
	local look_filter = input_filters.look_controller
	local function_data = look_filter.function_data
	function_data.multiplier_y = base_look_multiplier * 0.85^(-sensitivity)
	local melee_look_filter = input_filters.look_controller_melee
	local function_data = melee_look_filter.function_data
	function_data.multiplier_y = base_melee_look_multiplier * 0.85^(-sensitivity)
	local ranged_look_filter = input_filters.look_controller_ranged
	local function_data = ranged_look_filter.function_data
	function_data.multiplier_y = base_ranged_look_multiplier * 0.85^(-sensitivity)

	return value, min, max, 1, "menu_settings_gamepad_look_sensitivity_y", default_value
end

OptionsView.cb_gamepad_look_sensitivity_y_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.gamepad_look_sensitivity_y, Application.user_setting("gamepad_look_sensitivity_y")) then
		local sensitivity = 0
	end

	sensitivity = math.clamp(sensitivity, min, max)
	content.internal_value = get_slider_value(min, max, sensitivity)
	content.value = sensitivity
end

OptionsView.cb_gamepad_look_sensitivity_y = function (self, content)
	self.changed_user_settings.gamepad_look_sensitivity_y = content.value
end

OptionsView.cb_gamepad_zoom_sensitivity_setup = function (self)
	local min = -10
	local max = 10

	if not Application.user_setting("gamepad_zoom_sensitivity") then
		local sensitivity = 0
	end

	local default_value = DefaultUserSettings.get("user_settings", "gamepad_zoom_sensitivity")
	local value = get_slider_value(min, max, sensitivity)
	sensitivity = math.clamp(sensitivity, min, max)

	if self.platform == "win32" then
		slot6 = "xb1"
	else
		local platform_key = self.platform
	end

	local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
	local base_look_multiplier = base_filter.look_controller_zoom.multiplier_x
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service:get_active_filters(platform_key)
	local look_filter = input_filters.look_controller_zoom
	local function_data = look_filter.function_data
	function_data.multiplier_x = base_look_multiplier * 0.85^(-sensitivity)

	if not base_filter.look_controller_zoom.multiplier_min_x or not (base_filter.look_controller_zoom.multiplier_min_x * 0.85^(-sensitivity)) then
		slot13 = function_data.multiplier_x * 0.25
	end

	function_data.min_multiplier_x = slot13

	return value, min, max, 1, "menu_settings_gamepad_zoom_sensitivity", default_value
end

OptionsView.cb_gamepad_zoom_sensitivity_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.gamepad_zoom_sensitivity, Application.user_setting("gamepad_zoom_sensitivity")) then
		local sensitivity = 0
	end

	sensitivity = math.clamp(sensitivity, min, max)
	content.internal_value = get_slider_value(min, max, sensitivity)
	content.value = sensitivity
end

OptionsView.cb_gamepad_zoom_sensitivity = function (self, content)
	self.changed_user_settings.gamepad_zoom_sensitivity = content.value
end

OptionsView.cb_gamepad_zoom_sensitivity_y_setup = function (self)
	local min = -10
	local max = 10

	if not Application.user_setting("gamepad_zoom_sensitivity_y") then
		local sensitivity = 0
	end

	local default_value = DefaultUserSettings.get("user_settings", "gamepad_zoom_sensitivity_y")
	local value = get_slider_value(min, max, sensitivity)
	sensitivity = math.clamp(sensitivity, min, max)

	if self.platform == "win32" then
		slot6 = "xb1"
	else
		local platform_key = self.platform
	end

	local base_filter = InputUtils.get_platform_filters(PlayerControllerFilters, platform_key)
	local base_look_multiplier = base_filter.look_controller_zoom.multiplier_y
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service:get_active_filters(platform_key)
	local look_filter = input_filters.look_controller_zoom
	local function_data = look_filter.function_data
	function_data.multiplier_y = base_look_multiplier * 0.85^(-sensitivity)

	return value, min, max, 1, "menu_settings_gamepad_zoom_sensitivity_y", default_value
end

OptionsView.cb_gamepad_zoom_sensitivity_y_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.gamepad_zoom_sensitivity_y, Application.user_setting("gamepad_zoom_sensitivity_y")) then
		local sensitivity = 0
	end

	sensitivity = math.clamp(sensitivity, min, max)
	content.internal_value = get_slider_value(min, max, sensitivity)
	content.value = sensitivity
end

OptionsView.cb_gamepad_zoom_sensitivity_y = function (self, content)
	self.changed_user_settings.gamepad_zoom_sensitivity_y = content.value
end

OptionsView.cb_max_upload_speed = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.max_upload_speed = options_values[current_selection]
end

OptionsView.cb_max_upload_speed_setup = function (self)
	local options = {
		{
			value = 256,
			text = Localize("menu_settings_256kbit")
		},
		{
			value = 512,
			text = Localize("menu_settings_512kbit")
		},
		{
			value = 1024,
			text = Localize("menu_settings_1mbit")
		},
		{
			value = 2048,
			text = Localize("menu_settings_2mbit")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "max_upload_speed")
	local user_settings_value = Application.user_setting("max_upload_speed")
	local default_option, selected_option = nil

	for i, option in ipairs(options) do
		if option.value == user_settings_value then
			selected_option = i
		end

		if option.value == default_value then
			default_option = i
		end
	end

	fassert(default_option, "default option %i does not exist in cb_max_upload_speed_setup options table", default_value)

	if not selected_option then
		slot6 = default_option
	end

	return slot6, options, "menu_settings_max_upload", default_option
end

OptionsView.cb_max_upload_speed_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.max_upload_speed, Application.user_setting("max_upload_speed")) then
		local value = DefaultUserSettings.get("user_settings", "max_upload_speed")
	end

	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if value == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_mouse_look_invert_y_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "mouse_look_invert_y")
	local invert_mouse_y = Application.user_setting("mouse_look_invert_y")
	local input_service = self.input_manager:get_service("Player")
	local platform_key = "win32"
	local input_filters = input_service:get_active_filters(platform_key)
	local look_filter = input_filters.look
	local function_data = look_filter.function_data

	if invert_mouse_y then
		slot9 = "scale_vector3"
	else
		slot9 = "scale_vector3_invert_y"
	end

	function_data.filter_type = slot9

	if invert_mouse_y then
		slot9 = 2
	else
		local selection = 1
	end

	if default_value then
		slot10 = 2
	else
		local default_option = 1
	end

	return selection, options, "menu_settings_mouse_look_invert_y", default_option
end

OptionsView.cb_mouse_look_invert_y_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.mouse_look_invert_y, Application.user_setting("mouse_look_invert_y")) then
		local invert_mouse_y = false
	end

	slot3 = widget.content

	if invert_mouse_y then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_mouse_look_invert_y = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.mouse_look_invert_y = options_values[current_selection]
end

OptionsView.cb_gamepad_look_invert_y_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not DefaultUserSettings.get("user_settings", "gamepad_look_invert_y") then
		local default_value = false
	end

	local invert_gamepad_y = Application.user_setting("gamepad_look_invert_y")
	local input_service = self.input_manager:get_service("Player")

	if self.platform == "win32" then
		slot5 = "xb1"
	else
		local platform_key = self.platform
	end

	local input_filters = input_service:get_active_filters(platform_key)
	local look_filter = input_filters.look_controller
	local function_data = look_filter.function_data
	function_data.inverted_y = invert_gamepad_y
	local look_filter = input_filters.look_controller_ranged
	local function_data = look_filter.function_data
	function_data.inverted_y = invert_gamepad_y
	local look_filter = input_filters.look_controller_melee
	local function_data = look_filter.function_data
	function_data.inverted_y = invert_gamepad_y
	local look_filter = input_filters.look_controller_zoom
	local function_data = look_filter.function_data
	function_data.inverted_y = invert_gamepad_y

	if invert_gamepad_y then
		slot15 = 2
	else
		local selection = 1
	end

	if default_value then
		slot16 = 2
	else
		local default_option = 1
	end

	return selection, options, "menu_settings_gamepad_look_invert_y", default_option
end

OptionsView.cb_gamepad_look_invert_y_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.gamepad_look_invert_y, Application.user_setting("gamepad_look_invert_y")) then
		local invert_gamepad_y = false
	end

	slot3 = widget.content

	if invert_gamepad_y then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_gamepad_look_invert_y = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_look_invert_y = options_values[current_selection]
end

OptionsView.cb_gamepad_legacy_controller_input_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}

	if not DefaultUserSettings.get("user_settings", "gamepad_legacy_controller") then
		local default_value = false
	end

	local gamepad_legacy_controller = Application.user_setting("gamepad_legacy_controller")
	local input_service = self.input_manager:get_service("Player")

	if self.platform == "win32" then
		slot5 = "xb1"
	else
		local platform_key = self.platform
	end

	local input_filters = input_service:get_active_filters(platform_key)
	local look_filter = input_filters.look_controller
	local function_data = look_filter.function_data

	if gamepad_legacy_controller then
		slot9 = "scale_vector3_xy_accelerated_x_legacy"
	else
		slot9 = "scale_vector3_xy_accelerated_x"
	end

	function_data.filter_type = slot9
	local look_filter = input_filters.look_controller_ranged
	local function_data = look_filter.function_data

	if gamepad_legacy_controller then
		slot11 = "scale_vector3_xy_accelerated_x_legacy"
	else
		slot11 = "scale_vector3_xy_accelerated_x"
	end

	function_data.filter_type = slot11
	local look_filter = input_filters.look_controller_melee
	local function_data = look_filter.function_data

	if gamepad_legacy_controller then
		slot13 = "scale_vector3_xy_accelerated_x_legacy"
	else
		slot13 = "scale_vector3_xy_accelerated_x"
	end

	function_data.filter_type = slot13
	local look_filter = input_filters.look_controller_zoom
	local function_data = look_filter.function_data

	if gamepad_legacy_controller then
		slot15 = "scale_vector3_xy_accelerated_x_legacy"
	else
		slot15 = "scale_vector3_xy_accelerated_x"
	end

	function_data.filter_type = slot15

	if gamepad_legacy_controller then
		slot15 = 2
	else
		local selection = 1
	end

	if default_value then
		slot16 = 2
	else
		local default_option = 1
	end

	return selection, options, "legacy_controls_xb1", default_option
end

OptionsView.cb_gamepad_legacy_controller_input_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.gamepad_legacy_controller, Application.user_setting("gamepad_legacy_controller")) then
		local gamepad_legacy_controller = false
	end

	slot3 = widget.content

	if gamepad_legacy_controller then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_gamepad_legacy_controller_input = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_legacy_controller = options_values[current_selection]
end

OptionsView.cb_gamepad_auto_aim_enabled_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}

	if not DefaultUserSettings.get("user_settings", "gamepad_auto_aim_enabled") then
		local default_value = true
	end

	local enable_auto_aim = Application.user_setting("gamepad_auto_aim_enabled")

	if enable_auto_aim then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_gamepad_auto_aim_enabled", default_option
end

OptionsView.cb_gamepad_auto_aim_enabled_saved_value = function (self, widget)
	local gamepad_auto_aim_enabled = assigned(self.changed_user_settings.gamepad_auto_aim_enabled, Application.user_setting("gamepad_auto_aim_enabled"))
	slot3 = widget.content

	if gamepad_auto_aim_enabled then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_gamepad_auto_aim_enabled = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_auto_aim_enabled = options_values[current_selection]
end

OptionsView.cb_gamepad_rumble_enabled_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}

	if not DefaultUserSettings.get("user_settings", "gamepad_rumble_enabled") then
		local default_value = true
	end

	local enable_rumble = Application.user_setting("gamepad_rumble_enabled")

	if enable_rumble then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_gamepad_rumble_enabled", default_option
end

OptionsView.cb_gamepad_rumble_enabled_saved_value = function (self, widget)
	local gamepad_rumble_enabled = assigned(self.changed_user_settings.gamepad_rumble_enabled, Application.user_setting("gamepad_rumble_enabled"))
	slot3 = widget.content

	if gamepad_rumble_enabled then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_gamepad_rumble_enabled = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_rumble_enabled = options_values[current_selection]
end

OptionsView.cb_gamepad_use_ps4_style_input_icons_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_xb1_input_icons")
		},
		{
			value = true,
			text = Localize("menu_settings_ps4_input_icons")
		}
	}

	if not DefaultUserSettings.get("user_settings", "gamepad_use_ps4_style_input_icons") then
		local default_value = false
	end

	local use_ps4_style_icons = Application.user_setting("gamepad_use_ps4_style_input_icons")

	if use_ps4_style_icons then
		slot4 = 2
	else
		local selection = 1
	end

	if default_value then
		slot5 = 2
	else
		local default_option = 1
	end

	return selection, options, "menu_settings_gamepad_use_ps4_style_input_icons", default_option
end

OptionsView.cb_gamepad_use_ps4_style_input_icons_saved_value = function (self, widget)
	local gamepad_use_ps4_style_input_icons = assigned(self.changed_user_settings.gamepad_use_ps4_style_input_icons, Application.user_setting("gamepad_use_ps4_style_input_icons"))
	slot3 = widget.content

	if gamepad_use_ps4_style_input_icons then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_gamepad_use_ps4_style_input_icons = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_use_ps4_style_input_icons = options_values[current_selection]
	local gamepad_layout_widget = self.gamepad_layout_widget
	local gamepad_use_ps4_style_input_icons = assigned(self.changed_user_settings.gamepad_use_ps4_style_input_icons, Application.user_setting("gamepad_use_ps4_style_input_icons"))
	gamepad_layout_widget.content.use_texture2_layout = gamepad_use_ps4_style_input_icons
end

OptionsView.cb_gamepad_layout_setup = function (self)
	local options = AlternatateGamepadKeymapsOptionsMenu

	if not DefaultUserSettings.get("user_settings", "gamepad_layout") then
		local default_value = "default"
	end

	local gamepad_layout = Application.user_setting("gamepad_layout")
	local selected_option = 1
	local default_option = nil

	for i = 1, #options, 1 do
		local option = options[i]

		if gamepad_layout == option.value then
			selected_option = i
		end

		if default_value == option.value then
			default_option = i
		end

		if not option.localized then
			option.localized = true
			option.text = Localize(option.text)
		end
	end

	return selected_option, options, "menu_settings_gamepad_layout", default_option
end

OptionsView.cb_gamepad_layout_saved_value = function (self, widget)
	local gamepad_layout = assigned(self.changed_user_settings.gamepad_layout, Application.user_setting("gamepad_layout"))
	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if gamepad_layout == options_values[i] then
			selected_option = i
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_gamepad_layout = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.gamepad_layout = value
	local using_left_handed_option = assigned(self.changed_user_settings.gamepad_left_handed, Application.user_setting("gamepad_left_handed"))
	local gamepad_keymaps_layout = nil

	if using_left_handed_option then
		gamepad_keymaps_layout = AlternatateGamepadKeymapsLayoutsLeftHanded
	else
		gamepad_keymaps_layout = AlternatateGamepadKeymapsLayouts
	end

	local gamepad_keymaps = gamepad_keymaps_layout[value]

	self:update_gamepad_layout_widget(gamepad_keymaps, using_left_handed_option)
end

OptionsView.using_left_handed_gamepad_layout = function (self)
	local default_left_handed_option = Application.user_setting("gamepad_left_handed")
	local changed_left_handed_option = self.changed_user_settings.gamepad_left_handed
	local using_left_handed_option = nil

	if changed_left_handed_option ~= nil then
		using_left_handed_option = changed_left_handed_option
	else
		using_left_handed_option = default_left_handed_option
	end

	return using_left_handed_option
end

OptionsView.cb_gamepad_left_handed_enabled_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}

	if not DefaultUserSettings.get("user_settings", "gamepad_left_handed") then
		local default_value = false
	end

	local enable_left_handed = Application.user_setting("gamepad_left_handed")

	if enable_left_handed then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_gamepad_left_handed_enabled", default_option
end

OptionsView.cb_gamepad_left_handed_enabled_saved_value = function (self, widget)
	local gamepad_left_handed = assigned(self.changed_user_settings.gamepad_left_handed, Application.user_setting("gamepad_left_handed"))
	slot3 = widget.content

	if gamepad_left_handed then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_gamepad_left_handed_enabled = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_left_handed = options_values[current_selection]
	local gamepad_layout = assigned(self.changed_user_settings.gamepad_layout, Application.user_setting("gamepad_layout"))

	self:force_set_widget_value("gamepad_layout", gamepad_layout)
end

OptionsView.cb_toggle_crouch_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "toggle_crouch")
	local toggle_crouch = Application.user_setting("toggle_crouch")

	if toggle_crouch then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_toggle_crouch", default_option
end

OptionsView.cb_toggle_crouch_saved_value = function (self, widget)
	local toggle_crouch = assigned(self.changed_user_settings.toggle_crouch, Application.user_setting("toggle_crouch"))
	slot3 = widget.content

	if toggle_crouch then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_toggle_crouch = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.toggle_crouch = options_values[current_selection]
end

OptionsView.cb_toggle_stationary_dodge_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "toggle_stationary_dodge")
	local toggle_stationary_dodge = Application.user_setting("toggle_stationary_dodge")

	if toggle_stationary_dodge then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_toggle_stationary_dodge", default_option
end

OptionsView.cb_toggle_stationary_dodge_saved_value = function (self, widget)
	local toggle_stationary_dodge = assigned(self.changed_user_settings.toggle_stationary_dodge, Application.user_setting("toggle_stationary_dodge"))
	slot3 = widget.content

	if toggle_stationary_dodge then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_toggle_stationary_dodge = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.toggle_stationary_dodge = options_values[current_selection]
end

OptionsView.cb_matchmaking_region_setup = function (self)
	local temp = {}

	for region_type, regions in pairs(MatchmakingRegions) do
		if region_type == "primary" then
			for region, _ in pairs(regions) do
				temp[region] = true
			end
		end
	end

	local options = {
		{
			value = "auto",
			text = Localize("menu_settings_auto")
		}
	}

	for region, _ in pairs(temp) do
		options[#options + 1] = {
			text = Localize(region),
			value = region
		}
	end

	local default_value = DefaultUserSettings.get("user_settings", "matchmaking_region")
	local saved_value = Application.user_setting("matchmaking_region")
	local default_option = 1
	local selected_option = 1

	for i, option in ipairs(options) do
		if option.value == saved_value then
			selected_option = i

			break
		end
	end

	if saved_value ~= nil and saved_value ~= "auto" and not temp[saved_value] then
		Application.set_user_setting("matchmaking_region", "auto")
	end

	return selected_option, options, "menu_settings_matchmaking_region", default_option
end

OptionsView.cb_matchmaking_region_saved_value = function (self, widget)
	local matchmaking_region = assigned(self.changed_user_settings.matchmaking_region, Application.user_setting("matchmaking_region"))
	local current_selection = 1

	for i, value in ipairs(widget.content.options_values) do
		if value == matchmaking_region then
			current_selection = i

			break
		end
	end

	widget.content.current_selection = current_selection
end

OptionsView.cb_matchmaking_region = function (self, content)
	local selected_index = content.current_selection
	local options_values = content.options_values
	local value = options_values[selected_index]
	self.changed_user_settings.matchmaking_region = value
end

OptionsView.cb_overcharge_opacity_setup = function (self)
	local min = 0
	local max = 100

	if not Application.user_setting("overcharge_opacity") then
		local overcharge_opacity = DefaultUserSettings.get("user_settings", "overcharge_opacity")
	end

	local default_value = DefaultUserSettings.get("user_settings", "overcharge_opacity")
	local value = get_slider_value(min, max, overcharge_opacity)

	return value, min, max, 0, "menu_settings_overcharge_opacity", default_value
end

OptionsView.cb_overcharge_opacity_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	slot5 = assigned
	slot6 = self.changed_user_settings.overcharge_opacity

	if not Application.user_setting("overcharge_opacity") then
		slot7 = DefaultUserSettings.get("user_settings", "overcharge_opacity")
	end

	local overcharge_opacity = slot5(slot6, slot7)
	overcharge_opacity = math.clamp(overcharge_opacity, min, max)
	content.internal_value = get_slider_value(min, max, overcharge_opacity)
	content.value = overcharge_opacity
end

OptionsView.cb_overcharge_opacity = function (self, content)
	self.changed_user_settings.overcharge_opacity = content.value
end

OptionsView.cb_weapon_scroll_type_setup = function (self)
	local options = {
		{
			value = "scroll_wrap",
			text = Localize("menu_settings_scroll_type_wrap")
		},
		{
			value = "scroll_clamp",
			text = Localize("menu_settings_scroll_type_clamp")
		},
		{
			value = "scroll_disabled",
			text = Localize("menu_settings_off")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "weapon_scroll_type")

	if not Application.user_setting("weapon_scroll_type") then
		local scroll_type = "scroll_wrap"
	end

	if scroll_type == "scroll_clamp" then
		slot4 = 2
	elseif scroll_type == "scroll_disabled" then
		slot4 = 3
	else
		local selection = 1
	end

	if default_value == "scroll_clamp" then
		slot5 = 2
	elseif default_value == "scroll_disabled" then
		slot5 = 3
	else
		local default_option = 1
	end

	return selection, options, "menu_settings_weapon_scroll_type", default_option
end

OptionsView.cb_weapon_scroll_type_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.weapon_scroll_type, Application.user_setting("weapon_scroll_type")) then
		local scroll_type = "scroll_wrap"
	end

	slot3 = widget.content

	if scroll_type == "scroll_clamp" then
		slot4 = 2
	elseif scroll_type == "scroll_disabled" then
		slot4 = 3
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_weapon_scroll_type = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.weapon_scroll_type = options_values[current_selection]
end

OptionsView.cb_double_tap_dodge = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.double_tap_dodge = options_values[current_selection]
end

OptionsView.cb_double_tap_dodge_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "double_tap_dodge")
	local enabled = Application.user_setting("double_tap_dodge")

	if enabled == nil then
		enabled = default_value
	end

	if enabled then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_double_tap_dodge", default_option
end

OptionsView.cb_double_tap_dodge_saved_value = function (self, widget)
	local enabled = assigned(self.changed_user_settings.double_tap_dodge, Application.user_setting("double_tap_dodge"))

	if enabled == nil then
		enabled = DefaultUserSettings.get("user_settings", "double_tap_dodge")
	end

	slot3 = widget.content

	if enabled then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_dodge_on_jump_key = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.dodge_on_jump_key = options_values[current_selection]
end

OptionsView.cb_dodge_on_jump_key_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "dodge_on_jump_key")
	local enabled = Application.user_setting("dodge_on_jump_key")

	if enabled == nil then
		enabled = default_value
	end

	if enabled then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_dodge_on_jump_key", default_option
end

OptionsView.cb_dodge_on_jump_key_saved_value = function (self, widget)
	local enabled = assigned(self.changed_user_settings.dodge_on_jump_key, Application.user_setting("dodge_on_jump_key"))

	if enabled == nil then
		enabled = DefaultUserSettings.get("user_settings", "dodge_on_jump_key")
	end

	slot3 = widget.content

	if enabled then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_dodge_on_forward_diagonal = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.dodge_on_forward_diagonal = options_values[current_selection]
end

OptionsView.cb_dodge_on_forward_diagonal_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "dodge_on_forward_diagonal")
	local enabled = Application.user_setting("dodge_on_forward_diagonal")

	if enabled == nil then
		enabled = default_value
	end

	if enabled then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_dodge_on_forward_diagonal", default_option
end

OptionsView.cb_dodge_on_forward_diagonal_saved_value = function (self, widget)
	local enabled = assigned(self.changed_user_settings.dodge_on_forward_diagonal, Application.user_setting("dodge_on_forward_diagonal"))

	if enabled == nil then
		enabled = DefaultUserSettings.get("user_settings", "dodge_on_forward_diagonal")
	end

	slot3 = widget.content

	if enabled then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_tutorials_enabled_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "tutorials_enabled")
	local tutorials_enabled = Application.user_setting("tutorials_enabled")

	if tutorials_enabled == nil then
		tutorials_enabled = true
	end

	if tutorials_enabled then
		slot4 = 1
	else
		local selection = 2
	end

	if default_value then
		slot5 = 1
	else
		local default_option = 2
	end

	return selection, options, "menu_settings_tutorials_enabled", default_option
end

OptionsView.cb_tutorials_enabled_saved_value = function (self, widget)
	local tutorials_enabled = assigned(self.changed_user_settings.tutorials_enabled, Application.user_setting("tutorials_enabled"))

	if tutorials_enabled == nil then
		tutorials_enabled = true
	end

	slot3 = widget.content

	if tutorials_enabled then
		slot4 = 1
	else
		slot4 = 2
	end

	slot3.current_selection = slot4
end

OptionsView.cb_tutorials_enabled = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.tutorials_enabled = options_values[current_selection]
end

OptionsView.cb_master_volume_setup = function (self)
	local min = 0
	local max = 100

	if not Application.user_setting("master_bus_volume") then
		local master_bus_volume = 90
	end

	local value = get_slider_value(min, max, master_bus_volume)

	return value, min, max, 0, "menu_settings_master_volume", DefaultUserSettings.get("user_settings", "master_bus_volume")
end

OptionsView.cb_master_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.master_bus_volume, Application.user_setting("master_bus_volume")) then
		local master_bus_volume = 90
	end

	content.internal_value = get_slider_value(min, max, master_bus_volume)
	content.value = master_bus_volume
end

OptionsView.cb_master_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.master_bus_volume = value

	self:set_wwise_parameter("master_bus_volume", value)
	Managers.music:set_master_volume(value)
end

OptionsView.cb_music_bus_volume_setup = function (self)
	local min = 0
	local max = 100

	if not Application.user_setting("music_bus_volume") then
		local music_bus_volume = 90
	end

	local value = get_slider_value(min, max, music_bus_volume)

	return value, min, max, 0, "menu_settings_music_volume", DefaultUserSettings.get("user_settings", "music_bus_volume")
end

OptionsView.cb_music_bus_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.music_bus_volume, Application.user_setting("music_bus_volume")) then
		local music_bus_volume = 90
	end

	content.internal_value = get_slider_value(min, max, music_bus_volume)
	content.value = music_bus_volume
end

OptionsView.cb_music_bus_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.music_bus_volume = value

	Managers.music:set_music_volume(value)
end

OptionsView.cb_sfx_bus_volume_setup = function (self)
	local min = 0
	local max = 100

	if not Application.user_setting("sfx_bus_volume") then
		local sfx_bus_volume = 90
	end

	local value = get_slider_value(min, max, sfx_bus_volume)

	return value, min, max, 0, "menu_settings_sfx_volume", DefaultUserSettings.get("user_settings", "sfx_bus_volume")
end

OptionsView.cb_sfx_bus_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.sfx_bus_volume, Application.user_setting("sfx_bus_volume")) then
		local sfx_bus_volume = 90
	end

	content.internal_value = get_slider_value(min, max, sfx_bus_volume)
	content.value = sfx_bus_volume
end

OptionsView.cb_sfx_bus_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.sfx_bus_volume = value

	self:set_wwise_parameter("sfx_bus_volume", value)
end

OptionsView.cb_voice_bus_volume_setup = function (self)
	local min = 0
	local max = 100

	if not Application.user_setting("voice_bus_volume") then
		local voice_bus_volume = 90
	end

	local value = get_slider_value(min, max, voice_bus_volume)

	return value, min, max, 0, "menu_settings_voice_volume", DefaultUserSettings.get("user_settings", "voice_bus_volume")
end

OptionsView.cb_voice_bus_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.voice_bus_volume, Application.user_setting("voice_bus_volume")) then
		local voice_bus_volume = 90
	end

	content.internal_value = get_slider_value(min, max, voice_bus_volume)
	content.value = voice_bus_volume
end

OptionsView.cb_voice_bus_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.voice_bus_volume = value

	self:set_wwise_parameter("voice_bus_volume", value)
end

OptionsView.cb_voip_bus_volume_setup = function (self)
	local min = 0
	local max = 100

	if not Application.user_setting("voip_bus_volume") then
		local voip_bus_volume = 0
	end

	local value = get_slider_value(min, max, voip_bus_volume)

	return value, min, max, 0, "menu_settings_voip_volume", DefaultUserSettings.get("user_settings", "voip_bus_volume")
end

OptionsView.cb_voip_bus_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.voip_bus_volume, Application.user_setting("voip_bus_volume")) then
		local voip_bus_volume = 90
	end

	content.internal_value = get_slider_value(min, max, voip_bus_volume)
	content.value = voip_bus_volume
end

OptionsView.cb_voip_bus_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.voip_bus_volume = value

	if PLATFORM == "xb1" then
		Managers.voice_chat:set_chat_volume(value)
	else
		self.voip:set_volume(value)
	end
end

OptionsView.cb_voip_enabled_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local voip_enabled = Application.user_setting("voip_is_enabled")
	local default_value = DefaultUserSettings.get("user_settings", "voip_is_enabled")

	if voip_enabled == nil then
		voip_enabled = default_value
	end

	if self.voip then
		self.voip:set_enabled(voip_enabled)
	end

	if PLATFORM == "xb1" and Managers.voice_chat then
		Managers.voice_chat:set_enabled(voip_enabled)
	end

	local selected_option = 1

	if not voip_enabled then
		selected_option = 2
	end

	local default_option = 1

	if not default_value then
		default_option = 2
	end

	return selected_option, options, "menu_settings_voip_enabled", default_option
end

OptionsView.cb_voip_enabled_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local voip_enabled = assigned(self.changed_user_settings.voip_is_enabled, Application.user_setting("voip_is_enabled"))

	if voip_enabled == nil then
		voip_enabled = true
	end

	local selected_option = 1

	for idx, value in pairs(options_values) do
		if value == voip_enabled then
			selected_option = idx

			break
		end
	end

	widget.content.current_selection = selected_option
	widget.content.selected_option = selected_option
end

OptionsView.cb_voip_enabled = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.voip_is_enabled = value

	if PLATFORM == "xb1" then
		Managers.voice_chat:set_enabled(value)
	else
		self.voip:set_enabled(value)
	end
end

OptionsView.cb_voip_push_to_talk_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local voip_push_to_talk = Application.user_setting("voip_push_to_talk")
	local default_value = DefaultUserSettings.get("user_settings", "voip_push_to_talk")

	if voip_push_to_talk == nil then
		voip_push_to_talk = default_value
	end

	if self.voip then
		self.voip:set_push_to_talk(voip_push_to_talk)
	end

	local selected_option = 1

	if not voip_push_to_talk then
		selected_option = 2
	end

	local default_option = 1

	if not default_value then
		default_option = 2
	end

	return selected_option, options, "menu_settings_voip_push_to_talk", default_option
end

OptionsView.cb_voip_push_to_talk_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local voip_push_to_talk = assigned(self.changed_user_settings.voip_push_to_talk, Application.user_setting("voip_push_to_talk"))

	if voip_push_to_talk == nil then
		voip_push_to_talk = true
	end

	local selected_option = 1

	for idx, value in pairs(options_values) do
		if value == voip_push_to_talk then
			selected_option = idx

			break
		end
	end

	widget.content.current_selection = selected_option
	widget.content.selected_option = selected_option
end

OptionsView.cb_voip_push_to_talk = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.voip_push_to_talk = value

	self.voip:set_push_to_talk(value)
end

OptionsView.cb_particles_resolution_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_high")
		},
		{
			value = true,
			text = Localize("menu_settings_low")
		}
	}
	local low_res_transparency = Application.user_setting("render_settings", "low_res_transparency")

	if low_res_transparency then
		slot3 = 2
	else
		local selected_option = 1
	end

	return selected_option, options, "menu_settings_low_res_transparency"
end

OptionsView.cb_particles_resolution_saved_value = function (self, widget)
	local low_res_transparency = assigned(self.changed_render_settings.low_res_transparency, Application.user_setting("render_settings", "low_res_transparency"))

	if low_res_transparency then
		slot3 = 2
	else
		local selected_option = 1
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_particles_resolution = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.low_res_transparency = value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_particles_quality_setup = function (self)
	local options = {
		{
			value = "low",
			text = Localize("menu_settings_low")
		},
		{
			value = "medium",
			text = Localize("menu_settings_medium")
		},
		{
			value = "high",
			text = Localize("menu_settings_high")
		},
		{
			value = "extreme",
			text = Localize("menu_settings_extreme")
		}
	}
	local particles_quality = Application.user_setting("particles_quality")
	local default_value = DefaultUserSettings.get("user_settings", "particles_quality")
	local selected_option = 1
	local default_option = nil

	for i = 1, #options, 1 do
		if options[i].value == particles_quality then
			selected_option = i
		end

		if default_value == options[i].value then
			default_option = i
		end
	end

	return selected_option, options, "menu_settings_particles_quality", default_option
end

OptionsView.cb_particles_quality_saved_value = function (self, widget)
	local particles_quality = assigned(self.changed_user_settings.particles_quality, Application.user_setting("particles_quality"))
	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if particles_quality == options_values[i] then
			selected_option = i
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_particles_quality = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.particles_quality = value
	local particle_quality_settings = ParticlesQuality[value]

	for setting, key in pairs(particle_quality_settings) do
		self.changed_render_settings[setting] = key
	end

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_physic_debris_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}
	local use_physic_debris = Application.user_setting("use_physic_debris")

	if use_physic_debris == nil then
		use_physic_debris = true
	end

	if use_physic_debris then
		slot3 = 2
	else
		local selection = 1
	end

	if DefaultUserSettings.get("user_settings", "use_physic_debris") then
		slot4 = 2
	else
		local default_selection = 1
	end

	return selection, options, "menu_settings_physic_debris", default_selection
end

OptionsView.cb_physic_debris_saved_value = function (self, widget)
	local use_physic_debris = assigned(self.changed_user_settings.use_physic_debris, Application.user_setting("use_physic_debris"))

	if use_physic_debris == nil then
		use_physic_debris = true
	end

	slot3 = widget.content

	if use_physic_debris then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_physic_debris = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_physic_debris = options_values[current_selection]

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_high_quality_fur_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}
	local use_high_quality_fur = Application.user_setting("use_high_quality_fur")

	if use_high_quality_fur == nil then
		use_high_quality_fur = true
	end

	if use_high_quality_fur then
		slot3 = 2
	else
		local selection = 1
	end

	if DefaultUserSettings.get("user_settings", "use_high_quality_fur") then
		slot4 = 2
	else
		local default_selection = 1
	end

	return selection, options, "menu_settings_high_quality_fur", default_selection
end

OptionsView.cb_high_quality_fur_saved_value = function (self, widget)
	local use_high_quality_fur = assigned(self.changed_user_settings.use_high_quality_fur, Application.user_setting("use_high_quality_fur"))

	if use_high_quality_fur == nil then
		use_high_quality_fur = true
	end

	slot3 = widget.content

	if use_high_quality_fur then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_high_quality_fur = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_high_quality_fur = options_values[current_selection]
	GameSettingsDevelopment.use_high_quality_fur = options_values[current_selection]
	local entity_manager = Managers.state.entity

	if not Managers.player.is_server or not entity_manager:get_entities("AISimpleExtension") then
		local ai_units = entity_manager:get_entities("AiHuskBaseExtension")
	end

	for unit, extension in pairs(ai_units) do
		if Unit.alive(unit) then
			Unit.flow_event(unit, "lua_settings_updated")
		end
	end

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_alien_fx_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}
	local use_alien_fx = Application.user_setting("use_alien_fx")

	if use_alien_fx == nil then
		use_alien_fx = true
	end

	if use_alien_fx then
		slot3 = 2
	else
		local selection = 1
	end

	if DefaultUserSettings.get("user_settings", "use_alien_fx") then
		slot4 = 2
	else
		local default_selection = 1
	end

	GameSettingsDevelopment.use_alien_fx = use_alien_fx

	return selection, options, "menu_settings_alien_fx", default_selection
end

OptionsView.cb_alien_fx_saved_value = function (self, widget)
	local use_alien_fx = assigned(self.changed_user_settings.use_alien_fx, Application.user_setting("use_alien_fx"))

	if use_alien_fx == nil then
		use_alien_fx = true
	end

	slot3 = widget.content

	if use_alien_fx then
		slot4 = 2
	else
		slot4 = 1
	end

	slot3.current_selection = slot4
end

OptionsView.cb_alien_fx = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_alien_fx = options_values[current_selection]
	GameSettingsDevelopment.use_alien_fx = options_values[current_selection]
end

OptionsView.cb_ssr_setup = function (self)
	local options = {
		{
			value = false,
			text = Localize("menu_settings_off")
		},
		{
			value = true,
			text = Localize("menu_settings_on")
		}
	}
	local ssr_enabled = Application.user_setting("render_settings", "ssr_enabled")

	if ssr_enabled then
		slot3 = 2
	else
		local selected_option = 1
	end

	return selected_option, options, "menu_settings_ssr"
end

OptionsView.cb_ssr_saved_value = function (self, widget)
	local ssr_enabled = assigned(self.changed_render_settings.ssr_enabled, Application.user_setting("render_settings", "ssr_enabled"))

	if ssr_enabled then
		slot3 = 2
	else
		local selected_option = 1
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_ssr = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.ssr_enabled = value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_fov_setup = function (self)
	local min = 45
	local max = 120
	local base_fov = CameraSettings.first_person._node.vertical_fov

	if not Application.user_setting("render_settings", "fov") then
		local fov = base_fov
	end

	local value = get_slider_value(min, max, fov)
	fov = math.clamp(fov, min, max)
	local fov_multiplier = fov / base_fov
	local camera_manager = Managers.state.camera

	if camera_manager then
		camera_manager:set_fov_multiplier(fov_multiplier)
	end

	local default_value = math.clamp(DefaultUserSettings.get("render_settings", "fov"), min, max)

	return value, min, max, 0, "menu_settings_fov", default_value
end

OptionsView.cb_fov_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local base_fov = CameraSettings.first_person._node.vertical_fov

	if not assigned(self.changed_render_settings.fov, Application.user_setting("render_settings", "fov")) then
		local fov = base_fov
	end

	fov = math.clamp(fov, min, max)
	content.internal_value = get_slider_value(min, max, fov)
	content.value = fov
end

OptionsView.cb_fov = function (self, content)
	self.changed_render_settings.fov = content.value
end

OptionsView.cb_enabled_crosshairs = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.enabled_crosshairs = options_values[current_selection]
end

OptionsView.cb_enabled_crosshairs_setup = function (self)
	local options = {
		{
			value = "all",
			text = Localize("menu_settings_crosshair_all")
		},
		{
			value = "melee",
			text = Localize("menu_settings_crosshair_melee")
		},
		{
			value = "ranged",
			text = Localize("menu_settings_crosshair_ranged")
		},
		{
			value = "none",
			text = Localize("menu_settings_crosshair_none")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "enabled_crosshairs")
	local user_settings_value = Application.user_setting("enabled_crosshairs")
	local default_option, selected_option = nil

	for i, option in ipairs(options) do
		if option.value == user_settings_value then
			selected_option = i
		end

		if option.value == default_value then
			default_option = i
		end
	end

	fassert(default_option, "default option %i does not exist in cb_enabled_crosshairs_setup options table", default_value)

	if not selected_option then
		slot6 = default_option
	end

	return slot6, options, "menu_settings_enabled_crosshairs", default_option
end

OptionsView.cb_enabled_crosshairs_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.enabled_crosshairs, Application.user_setting("enabled_crosshairs")) then
		local value = DefaultUserSettings.get("user_settings", "enabled_crosshairs")
	end

	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if value == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_blood_enabled_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local blood_enabled = Application.user_setting("blood_enabled")
	local default_value = DefaultUserSettings.get("user_settings", "blood_enabled")

	if blood_enabled == nil then
		blood_enabled = default_value
	end

	local selected_option = 1

	if not blood_enabled then
		selected_option = 2
	end

	local default_option = 1

	if not default_value then
		default_option = 2
	end

	return selected_option, options, "menu_settings_blood_enabled", default_option
end

OptionsView.cb_blood_enabled_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local blood_enabled = assigned(self.changed_user_settings.blood_enabled, Application.user_setting("blood_enabled"))

	if blood_enabled == nil then
		blood_enabled = true
	end

	local selected_option = 1

	for idx, value in pairs(options_values) do
		if value == blood_enabled then
			selected_option = idx

			break
		end
	end

	widget.content.current_selection = selected_option
	widget.content.selected_option = selected_option
end

OptionsView.cb_blood_enabled = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.blood_enabled = value
end

OptionsView.cb_chat_enabled_setup = function (self)
	local options = {
		{
			value = true,
			text = Localize("menu_settings_on")
		},
		{
			value = false,
			text = Localize("menu_settings_off")
		}
	}
	local chat_enabled = Application.user_setting("chat_enabled")
	local default_value = DefaultUserSettings.get("user_settings", "chat_enabled")

	if chat_enabled == nil then
		chat_enabled = default_value
	end

	local selected_option = 1

	if not chat_enabled then
		selected_option = 2
	end

	local default_option = 1

	if not default_value then
		default_option = 2
	end

	return selected_option, options, "menu_settings_chat_enabled", default_option
end

OptionsView.cb_chat_enabled_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local chat_enabled = assigned(self.changed_user_settings.chat_enabled, Application.user_setting("chat_enabled"))

	if chat_enabled == nil then
		chat_enabled = true
	end

	local selected_option = 1

	for idx, value in pairs(options_values) do
		if value == chat_enabled then
			selected_option = idx

			break
		end
	end

	widget.content.current_selection = selected_option
	widget.content.selected_option = selected_option
end

OptionsView.cb_chat_enabled = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.chat_enabled = value
end

OptionsView.cb_chat_font_size = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.chat_font_size = options_values[current_selection]
end

OptionsView.cb_chat_font_size_setup = function (self)
	local options = {
		{
			text = "16",
			value = 16
		},
		{
			text = "20",
			value = 20
		},
		{
			text = "24",
			value = 24
		},
		{
			text = "28",
			value = 28
		},
		{
			text = "32",
			value = 32
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "chat_font_size")
	local user_settings_value = Application.user_setting("chat_font_size")
	local default_option, selected_option = nil

	for i, option in ipairs(options) do
		if option.value == user_settings_value then
			selected_option = i
		end

		if option.value == default_value then
			default_option = i
		end
	end

	fassert(default_option, "default option %i does not exist in cb_chat_font_size_setup options table", default_value)

	if not selected_option then
		slot6 = default_option
	end

	return slot6, options, "menu_settings_chat_font_size", default_option
end

OptionsView.cb_chat_font_size_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.chat_font_size, Application.user_setting("chat_font_size")) then
		local value = DefaultUserSettings.get("user_settings", "chat_font_size")
	end

	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if value == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_clan_tag_setup = function (self)
	local options = {
		{
			value = "0",
			text = Localize("menu_settings_none")
		}
	}
	local clan_tag = Application.user_setting("clan_tag")
	local clans = SteamHelper.clans_short()
	local i = 2
	local default_option = 1
	local selected_option = default_option

	for id, clan_name in pairs(clans) do
		if clan_name ~= "" then
			options[i] = {
				text = clan_name,
				value = id
			}

			if id == clan_tag then
				selected_option = i
			end

			i = i + 1
		end
	end

	return selected_option, options, "menu_settings_clan_tag", default_option
end

OptionsView.cb_clan_tag_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local clan_tag = assigned(self.changed_user_settings.clan_tag, Application.user_setting("clan_tag"))

	if clan_tag == nil then
		clan_tag = "0"
	end

	local selected_option = 1

	for idx, value in pairs(options_values) do
		if value == clan_tag then
			selected_option = idx

			break
		end
	end

	widget.content.current_selection = selected_option
	widget.content.selected_option = selected_option
end

OptionsView.cb_clan_tag = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.clan_tag = value
end

OptionsView.cb_blood_decals_setup = function (self)
	local min = 0
	local max = 500

	if not Application.user_setting("num_blood_decals") then
		local num_blood_decals = BloodSettings.blood_decals.num_decals
	end

	local default_value = DefaultUserSettings.get("user_settings", "num_blood_decals")
	local value = get_slider_value(min, max, num_blood_decals)
	num_blood_decals = math.clamp(num_blood_decals, min, max)
	BloodSettings.blood_decals.num_decals = num_blood_decals

	return value, min, max, 0, "menu_settings_num_blood_decals", default_value
end

OptionsView.cb_blood_decals_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.num_blood_decals, Application.user_setting("num_blood_decals")) then
		local num_blood_decals = BloodSettings.blood_decals.num_decals
	end

	num_blood_decals = math.clamp(num_blood_decals, min, max)
	content.internal_value = get_slider_value(min, max, num_blood_decals)
	content.value = num_blood_decals
end

OptionsView.cb_blood_decals = function (self, content, called_from_graphics_quality)
	self.changed_user_settings.num_blood_decals = content.value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_dynamic_range_sound_setup = function (self)
	local options = {
		{
			value = "low",
			text = Localize("menu_settings_low")
		},
		{
			value = "high",
			text = Localize("menu_settings_high")
		}
	}
	local default_value = DefaultUserSettings.get("user_settings", "dynamic_range_sound")

	if not Application.user_setting("dynamic_range_sound") then
		local dynamic_range_sound = default_value
	end

	local selected_option = 1

	if dynamic_range_sound == "high" then
		selected_option = 2
	end

	local default_option = 1

	if default_value == "high" then
		default_option = 2
	end

	return selected_option, options, "menu_settings_dynamic_range_sound", default_option
end

OptionsView.cb_dynamic_range_sound_saved_value = function (self, widget)
	if not assigned(self.changed_user_settings.dynamic_range_sound, Application.user_setting("dynamic_range_sound")) then
		local dynamic_range_sound = "low"
	end

	local selected_option = 1

	if dynamic_range_sound == "high" then
		selected_option = 2
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_dynamic_range_sound = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.dynamic_range_sound = value
	local setting = nil

	if value == "low" then
		setting = 1
	elseif value == "high" then
		setting = 0
	end

	self:set_wwise_parameter("dynamic_range_sound", setting)
end

OptionsView.cb_sound_panning_rule_setup = function (self)
	local options = {
		{
			value = "headphones",
			text = Localize("menu_settings_headphones")
		},
		{
			value = "speakers",
			text = Localize("menu_settings_speakers")
		}
	}
	local selected_option = 1
	local default_option = nil
	local default_value = DefaultUserSettings.get("user_settings", "sound_panning_rule")

	if not Application.user_setting("sound_panning_rule") then
		local sound_panning_rule = default_value
	end

	if sound_panning_rule == "headphones" then
		selected_option = 1
	elseif sound_panning_rule == "speakers" then
		selected_option = 2
	end

	if default_value == "headphones" then
		default_option = 1
	elseif default_value == "speakers" then
		default_option = 2
	end

	return selected_option, options, "menu_settings_sound_panning_rule", default_option
end

OptionsView.cb_sound_panning_rule_saved_value = function (self, widget)
	local selected_option = 1

	if not assigned(self.changed_user_settings.sound_panning_rule, Application.user_setting("sound_panning_rule")) then
		local sound_panning_rule = "headphones"
	end

	if sound_panning_rule == "headphones" then
		selected_option = 1
	elseif sound_panning_rule == "speakers" then
		selected_option = 2
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_sound_panning_rule = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.sound_panning_rule = value

	if value == "headphones" then
		Managers.music:set_panning_rule("PANNING_RULE_HEADPHONES")
	elseif value == "speakers" then
		Managers.music:set_panning_rule("PANNING_RULE_SPEAKERS")
	end
end

OptionsView.cb_sound_quality_setup = function (self)
	local options = {
		{
			value = "low",
			text = Localize("menu_settings_low")
		},
		{
			value = "medium",
			text = Localize("menu_settings_medium")
		},
		{
			value = "high",
			text = Localize("menu_settings_high")
		}
	}
	local sound_quality = Application.user_setting("sound_quality")
	local default_option = DefaultUserSettings.get("user_settings", "sound_quality")
	local selected_option = nil

	for i = 1, #options, 1 do
		local value = options[i].value

		if sound_quality == value then
			selected_option = i
		end

		if default_option == value then
			default_option = i
		end
	end

	return selected_option, options, "menu_settings_sound_quality", default_option
end

OptionsView.cb_sound_quality_saved_value = function (self, widget)
	local sound_quality = assigned(self.changed_user_settings.sound_quality, Application.user_setting("sound_quality"))
	local options_values = widget.content.options_values
	local selected_option = nil

	for i = 1, #options_values, 1 do
		if sound_quality == options_values[i] then
			selected_option = i
		end
	end

	widget.content.current_selection = selected_option
end

OptionsView.cb_sound_quality = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.sound_quality = value
end

OptionsView.cb_animation_lod_distance_setup = function (self)
	local min = 0
	local max = 1

	if not Application.user_setting("animation_lod_distance_multiplier") then
		local animation_lod_distance_multiplier = GameSettingsDevelopment.bone_lod_husks.lod_multiplier
	end

	local value = get_slider_value(min, max, animation_lod_distance_multiplier)

	return value, min, max, 1, "menu_settings_animation_lod_multiplier"
end

OptionsView.cb_animation_lod_distance_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max

	if not assigned(self.changed_user_settings.animation_lod_distance_multiplier, Application.user_setting("animation_lod_distance_multiplier")) then
		local animation_lod_distance_multiplier = GameSettingsDevelopment.bone_lod_husks.lod_multiplier
	end

	animation_lod_distance_multiplier = math.clamp(animation_lod_distance_multiplier, min, max)
	content.internal_value = get_slider_value(min, max, animation_lod_distance_multiplier)
	content.value = animation_lod_distance_multiplier
end

OptionsView.cb_animation_lod_distance = function (self, content, called_from_graphics_quality)
	self.changed_user_settings.animation_lod_distance_multiplier = content.value

	if not called_from_graphics_quality then
		self:force_set_widget_value("graphics_quality_settings", "custom")
	end
end

OptionsView.cb_player_outlines_setup = function (self)
	local options = {
		{
			value = "off",
			text = Localize("menu_settings_off")
		},
		{
			value = "on",
			text = Localize("menu_settings_on")
		},
		{
			value = "always_on",
			text = Localize("menu_settings_always_on")
		}
	}
	local player_outlines = Application.user_setting("player_outlines")
	local default_value = DefaultUserSettings.get("user_settings", "player_outlines")
	local selection, default_selection = nil

	for i, option in ipairs(options) do
		if player_outlines == option.value then
			selection = i
		end

		if default_value == option.value then
			default_selection = i
		end
	end

	return selection, options, "menu_settings_player_outlines", default_selection
end

OptionsView.cb_player_outlines_saved_value = function (self, widget)
	local player_outlines = assigned(self.changed_user_settings.player_outlines, Application.user_setting("player_outlines"))
	local selection = nil
	local options_values = widget.content.options_values

	for i = 1, #options_values, 1 do
		local value = options_values[i]

		if player_outlines == value then
			selection = i
		end
	end

	widget.content.current_selection = selection
end

OptionsView.cb_player_outlines = function (self, content)
	local current_selection = content.current_selection
	local options_values = content.options_values
	local value = options_values[current_selection]
	self.changed_user_settings.player_outlines = value
end

local function AddStepperSetting(setting_name)
	local value_set_name = "cb_" .. setting_name
	local value_setup_name = value_set_name .. "_setup"

	OptionsView[value_setup_name] = function (self)
		local options = {
			{
				value = false,
				text = Localize("menu_settings_off")
			},
			{
				value = true,
				text = Localize("menu_settings_on")
			}
		}
		local use_tobii = Application.user_setting(setting_name)

		if use_tobii == nil then
			use_tobii = true
		end

		if use_tobii then
			slot3 = 2
		else
			local selection = 1
		end

		if DefaultUserSettings.get("user_settings", setting_name) then
			slot4 = 2
		else
			local default_selection = 1
		end

		GameSettingsDevelopment[setting_name] = use_tobii

		return selection, options, "menu_settings_" .. setting_name, default_selection
	end

	OptionsView[value_set_name] = function (self, content)
		local options_values = content.options_values
		local current_selection = content.current_selection
		self.changed_user_settings[setting_name] = options_values[current_selection]
		GameSettingsDevelopment[setting_name] = options_values[current_selection]
	end

	local value_saved_name = value_set_name .. "_saved_value"

	OptionsView[value_saved_name] = function (self, widget)
		local use_tobii = assigned(self.changed_user_settings[setting_name], Application.user_setting(setting_name))

		if use_tobii == nil then
			use_tobii = true
		end

		slot3 = widget.content

		if use_tobii then
			slot4 = 2
		else
			slot4 = 1
		end

		slot3.current_selection = slot4
	end
end

AddStepperSetting("tobii_eyetracking")
AddStepperSetting("tobii_extended_view")
AddStepperSetting("tobii_tag_at_gaze")
AddStepperSetting("tobii_clean_ui")
AddStepperSetting("tobii_interact_at_gaze")
AddStepperSetting("tobii_fire_at_gaze_blunderbuss")
AddStepperSetting("tobii_fire_at_gaze_grudgeraker")
AddStepperSetting("tobii_fire_at_gaze_fireball")
AddStepperSetting("tobii_fire_at_gaze_geiser")
AddStepperSetting("tobii_fire_at_gaze_sparks")
AddStepperSetting("tobii_aim_at_gaze_hagbane")
AddStepperSetting("tobii_fire_at_gaze_hagbane")
AddStepperSetting("tobii_aim_at_gaze_shortbow")
AddStepperSetting("tobii_fire_at_gaze_shortbow")
AddStepperSetting("tobii_aim_at_gaze_longbow")
AddStepperSetting("tobii_fire_at_gaze_longbow")
AddStepperSetting("tobii_aim_at_gaze_crossbow")
AddStepperSetting("tobii_aim_at_gaze_handgun")
AddStepperSetting("tobii_fire_at_gaze_drake_pistols")
AddStepperSetting("tobii_fire_at_gaze_brace_of_pistols")
AddStepperSetting("tobii_fire_at_gaze_repeating_pistol")
AddStepperSetting("tobii_fire_at_gaze_repeating_handgun")

local function AddSliderSetting(setting_name, setting_min, setting_max, num_decimals)
	local value_set_name = "cb_" .. setting_name
	local value_setup_name = value_set_name .. "_setup"

	OptionsView[value_setup_name] = function (self)
		if not Application.user_setting(setting_name) then
			local value = DefaultUserSettings[setting_name]
		end

		local default_value = DefaultUserSettings.get("user_settings", setting_name)
		local new_value = get_slider_value(setting_min, setting_max, value)

		return new_value, setting_min, setting_max, num_decimals, "menu_settings_" .. setting_name, default_value
	end

	OptionsView[value_set_name] = function (self, content)
		self.changed_user_settings[setting_name] = content.value
	end

	local value_saved_name = value_set_name .. "_saved_value"

	OptionsView[value_saved_name] = function (self, widget)
		local content = widget.content
		local new_value = assigned(self.changed_user_settings[setting_name], Application.user_setting(setting_name))
		new_value = math.clamp(new_value, setting_min, setting_max)
		content.internal_value = get_slider_value(setting_min, setting_max, new_value)
		content.value = new_value
	end
end

AddSliderSetting("tobii_clean_ui_alpha", 0, 1, 2)
AddSliderSetting("tobii_extended_view_speed", 0.1, 10, 1)
AddSliderSetting("tobii_extended_view_max_yaw", 1, 25, 0)
AddSliderSetting("tobii_extended_view_max_pitch_up", 1, 25, 0)
AddSliderSetting("tobii_extended_view_max_pitch_down", 1, 25, 0)
AddSliderSetting("tobii_extended_view_deadzone", 0, 0.2, 4)
AddSliderSetting("tobii_extended_view_curve_slope", 1, 10, 1)
AddSliderSetting("tobii_extended_view_curve_shoulder", 0.1, 0.99, 1)

local function get_button_locale_name(controller_type, button_name)
	local button_locale_name = nil

	if controller_type == "keyboard" then
		local button_index = Keyboard.button_index(button_name)
		button_locale_name = Keyboard.button_locale_name(button_index)
	elseif controller_type == "mouse" then
		button_locale_name = string.format("%s %s", "mouse", button_name)
	elseif controller_type == "gamepad" then
		local button_index = Pad1.button_index(button_name)

		if Pad1.button_locale_name(button_index) == "" then
			button_locale_name = button_name

			if button_name then
				button_locale_name = false
			end
		else
			button_locale_name = true
		end
	end

	if button_locale_name == "" or not button_locale_name then
		slot3 = string.upper(button_name)
	end

	return slot3
end

OptionsView.cb_keybind_setup = function (self, keymappings_key, keymappings_table_key, actions)
	local session_keymaps = self.session_keymaps
	local session_keybindings = session_keymaps[keymappings_key][keymappings_table_key]
	local actions_info = {}

	for i, action in ipairs(actions) do
		local keybind = session_keybindings[action]
		actions_info[i] = {
			action = action,
			keybind = table.clone(keybind)
		}
	end

	local controller_type = actions_info[1].keybind[1]
	local mapped_key = actions_info[1].keybind[2]
	local button_locale_name = get_button_locale_name(controller_type, mapped_key)
	local default_keymappings_data = rawget(_G, keymappings_key)
	local default_keymappings = default_keymappings_data[keymappings_table_key]
	local default_keybind = default_keymappings[actions[1]]
	local default_value = {
		controller = default_keybind[1],
		key = default_keybind[2]
	}

	return button_locale_name, actions_info, default_value
end

OptionsView.cb_keybind_saved_value = function (self, widget)
	local actions = widget.content.actions

	if not actions then
		return
	end

	local keymappings_key = widget.content.keymappings_key
	local keymappings_table_key = widget.content.keymappings_table_key
	local keymaps = self.original_keymaps
	local keybindings = keymaps[keymappings_key][keymappings_table_key]
	local actions_info = {}

	for i, action in ipairs(actions) do
		local keybind = keybindings[action]
		actions_info[i] = {
			action = action,
			keybind = table.clone(keybind)
		}
	end

	local controller_type = actions_info[1].keybind[1]
	local mapped_key = actions_info[1].keybind[2]
	slot10 = widget.content

	if mapped_key == "left button **" then
		slot11 = ""
	else
		slot11 = get_button_locale_name(controller_type, mapped_key)
	end

	slot10.selected_key = slot11
	widget.content.mapped_key = mapped_key
	widget.content.actions_info = actions_info
end

OptionsView.cleanup_duplicates = function (self, new_key)
	local selected_settings_list = self.selected_settings_list
	local widgets = selected_settings_list.widgets
	local widgets_n = selected_settings_list.widgets_n

	for i = 1, widgets_n, 1 do
		local widget = widgets[i]
		local content = widget.content
		local mapped_key = content.mapped_key

		if mapped_key == new_key then
			content.callback("delete", "keyboard", content)
		end
	end
end

OptionsView.cb_keybind_changed = function (self, new_key, device, content)
	local actions_info = content.actions_info

	if not actions_info then
		return
	end

	local session_keymaps = self.session_keymaps
	local keymappings_key = content.keymappings_key
	local keymappings_table_key = content.keymappings_table_key

	if new_key == "delete" and device == "keyboard" then
		new_key = "left button **"
	else
		self:cleanup_duplicates(new_key)
	end

	local input_manager = Managers.input

	for i, info in ipairs(actions_info) do
		local keybind = info.keybind
		local action = info.action
		keybind[1] = device
		keybind[2] = new_key
		keybind.changed = true
		local session_keybind = session_keymaps[keymappings_key][keymappings_table_key][action]
		session_keybind[1] = device
		session_keybind[2] = new_key
		session_keybind.changed = true
	end

	self.changed_keymaps = true

	if new_key == "left button **" then
		slot9 = ""
	else
		slot9 = get_button_locale_name(device, new_key)
	end

	content.selected_key = slot9
end

return
