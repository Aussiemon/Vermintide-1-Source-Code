-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
require("scripts/ui/views/ui_calibration_view")

OptionsView = class(OptionsView)
local definitions = local_require("scripts/ui/views/options_view_definitions")
local gamepad_frame_widget_definitions = definitions.gamepad_frame_widget_definitions
local background_widget_definitions = definitions.background_widget_definitions
local widget_definitions = definitions.widget_definitions
local title_button_definitions = definitions.title_button_definitions
local button_definitions = definitions.button_definitions
local SettingsMenuNavigation = SettingsMenuNavigation
local SettingsWidgetTypeTemplate = SettingsWidgetTypeTemplate

local function get_slider_value(min, max, value)
	local range = max - min
	local norm_value = math.clamp(value, min, max) - min

	return norm_value/range
end

local function assigned(a, b)
	if a == nil then
		return b
	else
		return a
	end

	return 
end

local generic_input_actions = {
	main_menu = {
		default = {
			{
				input_action = "d_vertical",
				priority = 1,
				description_text = "input_description_navigate",
				ignore_keybinding = true
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
		reset = {
			{
				input_action = "d_vertical",
				priority = 1,
				description_text = "input_description_navigate",
				ignore_keybinding = true
			},
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
				input_action = "d_vertical",
				priority = 1,
				description_text = "input_description_navigate",
				ignore_keybinding = true
			},
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
				input_action = "d_vertical",
				priority = 1,
				description_text = "input_description_navigate",
				ignore_keybinding = true
			},
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
				input_action = "d_vertical",
				priority = 1,
				description_text = "input_description_navigate",
				ignore_keybinding = true
			},
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
				input_action = "d_vertical",
				priority = 1,
				description_text = "input_description_navigate",
				ignore_keybinding = true
			},
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
				input_action = "d_vertical",
				priority = 1,
				description_text = "input_description_navigate",
				ignore_keybinding = true
			},
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
				input_action = "d_vertical",
				priority = 1,
				description_text = "input_description_navigate",
				ignore_keybinding = true
			},
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

local function mouse_input_allowed(content_keys, mouse_input)
	for _, content_key in ipairs(content_keys) do
		local disabled_mouse_inputs = disabled_mouse_input_table[content_key]

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
	local input_manager = ingame_ui_context.input_manager

	input_manager.create_input_service(input_manager, "options_menu", IngameMenuKeymaps)
	input_manager.map_device_to_service(input_manager, "options_menu", "keyboard")
	input_manager.map_device_to_service(input_manager, "options_menu", "mouse")
	input_manager.map_device_to_service(input_manager, "options_menu", "gamepad")

	self.input_manager = input_manager
	self.controller_cooldown = 0
	local world = ingame_ui_context.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.ui_animations = {}

	self.reset_changed_settings(self)
	self.create_ui_elements(self)

	local input_service = input_manager.get_service(input_manager, "options_menu")
	local gui_layer = definitions.scenegraph_definition.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 6, gui_layer, generic_input_actions.main_menu.reset)
	self._input_functions = {
		checkbox = function (widget, input_source)
			if widget.content.hotspot.on_release then
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
				widget.content.callback(widget.content)
			end

			return 
		end,
		slider = function (widget, input_source)
			if widget.content.changed then
				widget.content.changed = nil
				self.disable_all_input = true

				widget.content.callback(widget.content)
			end

			if self.disable_all_input then
				if not input_source.get(input_source, "left_hold") then
					widget.content.altering_value = nil
					self.disable_all_input = nil
				else
					widget.content.altering_value = true
				end
			end

			return 
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

						content.callback(content)

						content.active = false
						list_style.active = false
						self.disable_all_input = false

						break
					end
				end

				if content.active and input_source.get(input_source, "left_release") then
					content.active = false
					list_style.active = false
					self.disable_all_input = false

					WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
				end
			end

			return 
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

				content.callback(content)
			end

			return 
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

					content.callback(new_key, "keyboard", content)

					stop = true
				end

				button = Mouse.any_released()

				if not stop and button ~= nil then
					local new_key = Mouse.button_name(button)
					local input_allowed = mouse_input_allowed(content.keys, new_key)

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

			return 
		end,
		image = function ()
			return 
		end
	}

	return 
end
OptionsView.input_service = function (self)
	return self.input_manager:get_service("options_menu")
end
OptionsView.cleanup_popups = function (self)
	if self.apply_popup_id then
		Managers.popup:cancel_popup(self.apply_popup_id)

		self.apply_popup_id = nil

		self.handle_apply_popup_results(self, "revert_changes")
	end

	if self.title_popup_id then
		Managers.popup:cancel_popup(self.title_popup_id)

		self.title_popup_id = nil
	end

	if self.exit_popup_id then
		Managers.popup:cancel_popup(self.exit_popup_id)

		self.exit_popup_id = nil
	end

	return 
end
OptionsView.suspend = function (self)
	self.suspended = true

	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)
	self.cleanup_popups(self)

	return 
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

	return 
end
OptionsView.destroy = function (self)
	self.cleanup_popups(self)
	self.menu_input_description:destroy()

	self.menu_input_description = nil

	GarbageLeakDetector.register_object(self, "OptionsView")

	return 
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
	local calibrate_ui_settings_list_dummy = {
		hide_reset = true,
		widgets_n = 0,
		scenegraph_id_start = "calibrate_ui_dummy",
		widgets = {}
	}
	local settings_lists = {}

	if Application.platform() == "win32" then
		settings_lists.video_settings = self.build_settings_list(self, definitions.video_settings_definition, "video_settings_list")
		settings_lists.audio_settings = self.build_settings_list(self, definitions.audio_settings_definition, "audio_settings_list")
		settings_lists.gameplay_settings = self.build_settings_list(self, definitions.gameplay_settings_definition, "gameplay_settings_list")
		settings_lists.display_settings = self.build_settings_list(self, definitions.display_settings_definition, "display_settings_list")
		settings_lists.keybind_settings = self.build_settings_list(self, definitions.keybind_settings_definition, "keybind_settings_list")
		settings_lists.gamepad_settings = self.build_settings_list(self, definitions.gamepad_settings_definition, "gamepad_settings_list")
	end

	settings_lists.video_settings.hide_reset = true
	settings_lists.video_settings.needs_apply_confirmation = true
	self.settings_lists = settings_lists
	self.selected_widget = nil
	self.selected_title = nil
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.ui_calibration_view = UICalibrationView:new()
	RELOAD_OPTIONS_VIEW = false

	return 
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
			widget = self.build_drop_down_widget(self, element, scenegraph_id_start, base_offset)
		elseif widget_type == "slider" then
			widget = self.build_slider_widget(self, element, scenegraph_id_start, base_offset)
		elseif widget_type == "checkbox" then
			widget = self.build_checkbox_widget(self, element, scenegraph_id_start, base_offset)
		elseif widget_type == "stepper" then
			widget = self.build_stepper_widget(self, element, scenegraph_id_start, base_offset)
		elseif widget_type == "keybind" then
			widget = self.build_keybind_widget(self, element, scenegraph_id_start, base_offset)
		elseif widget_type == "image" then
			widget = self.build_image(self, element, scenegraph_id_start, base_offset)
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

		local original_user_settings = self.original_user_settings

		for setting, value in pairs(self.changed_user_settings) do
			if not original_user_settings[setting] then
				original_user_settings[setting] = Application.user_setting(setting)
			end
		end

		local original_render_settings = self.original_render_settings

		for setting, value in pairs(self.changed_render_settings) do
			if not original_render_settings[setting] then
				original_render_settings[setting] = Application.user_setting("render_settings", setting)
			end
		end

		return 
	end

	return new_callback
end
OptionsView.build_stepper_widget = function (self, element, scenegraph_id, base_offset)
	local callback_name = element.callback
	local callback_func = self.make_callback(self, callback_name)
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
	local callback_func = self.make_callback(self, callback_name)
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
	local callback_func = self.make_callback(self, callback_name)
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
OptionsView.build_checkbox_widget = function (self, element, scenegraph_id, base_offset)
	local callback_name = element.callback
	local callback_func = self.make_callback(self, callback_name)
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
	local selected_key, key_info, default_value = self.cb_keybind_setup(self, element.input_service_name, element.keys)
	local widget = definitions.create_keybind_widget(selected_key, element.keys, key_info, scenegraph_id, base_offset)
	local content = widget.content
	content.callback = callback_func
	content.saved_value_cb = saved_value_cb
	content.default_value = default_value
	content.input_service_name = element.input_service_name

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

	return 
end
OptionsView.force_set_widget_value = function (self, name, value)
	local widget = self.widget_from_name(self, name)

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

		content.callback(content)
	else
		fassert(false, "Force set widget value not supported for widget type %q yet", wiget_type)
	end

	return 
end
OptionsView.set_widget_disabled = function (self, name, disable)
	local widget = self.widget_from_name(self, name)

	if widget then
		widget.content.disabled = disable
	end

	return 
end
OptionsView.on_enter = function (self)
	self.set_original_settings(self)
	self.reset_changed_settings(self)
	self.select_settings_title(self, 1)

	self.in_settings_sub_menu = false
	self.gamepad_active_generic_actions_name = nil
	self.gamepad_tooltip_available = nil
	local input_manager = self.input_manager
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	if gamepad_active then
		self.selected_title = nil

		self.set_console_title_selection(self, 1, true)
	end

	WwiseWorld.trigger_event(self.wwise_world, "Play_hud_button_open")

	self.active = true

	return 
end
OptionsView.on_exit = function (self)
	self.exiting = nil
	self.active = nil

	return 
end
OptionsView.exit = function (self, return_to_game)
	self.cleanup_popups(self)

	if self.selected_title then
		self.deselect_title(self, self.selected_title)

		self.in_settings_sub_menu = false
	end

	self.gamepad_active_generic_actions_name = nil
	self.gamepad_tooltip_available = nil

	self.cancel_gamepad_reset_animation(self)

	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)
	WwiseWorld.trigger_event(self.wwise_world, "Play_hud_button_close")

	self.exiting = true

	return 
end
OptionsView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	return 
end
OptionsView.get_saved_keymaps = function (self)
	local keymaps = {
		Player = {
			settings_name = "PlayerControllerKeymaps",
			keymap = table.clone(PlayerControllerKeymaps)
		},
		ingame_menu = {
			settings_name = "IngameMenuKeymaps",
			keymap = table.clone(IngameMenuKeymaps)
		},
		player_list_input = {
			settings_name = "IngamePlayerListKeymaps",
			keymap = table.clone(IngamePlayerListKeymaps)
		},
		chat_input = {
			settings_name = "ChatControllerSettings",
			keymap = table.clone(ChatControllerSettings)
		}
	}

	if PlayerData.controls then
		for input_service_name, data in pairs(keymaps) do
			if PlayerData.controls[input_service_name] then
				local saved_keymaps = PlayerData.controls[input_service_name].keymap

				table.merge_recursive(data.keymap, saved_keymaps)
			end
		end
	end

	return keymaps
end
OptionsView.reset_changed_settings = function (self)
	self.changed_user_settings = {}
	self.changed_render_settings = {}
	self.keymaps = self.get_saved_keymaps(self)
	self.changed_keymaps = false

	return 
end
OptionsView.set_original_settings = function (self)
	self.original_user_settings = {}
	self.original_render_settings = {}
	self.original_keymaps = self.get_saved_keymaps(self)

	return 
end
OptionsView.set_wwise_parameter = function (self, name, value)
	WwiseWorld.set_global_parameter(self.wwise_world, name, value)

	return 
end
OptionsView.changes_been_made = function (self)
	return 0 < table.size(self.changed_user_settings) or 0 < table.size(self.changed_render_settings) or self.changed_keymaps
end
local needs_reload_settings = definitions.needs_reload_settings
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

	local max_fps = user_settings.max_fps

	if max_fps then
		if max_fps == 0 then
			Application.set_time_step_policy("no_throttle")
		else
			Application.set_time_step_policy("throttle", max_fps)
		end
	end

	local max_upload = user_settings.max_upload_speed
	local network_manager = Managers.state.network

	if max_upload and network_manager then
		network_manager.set_max_upload_speed(network_manager, max_upload)
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
		self.set_wwise_parameter(self, "master_bus_volume", master_bus_volume)
	end

	local music_bus_volume = user_settings.music_bus_volume

	if music_bus_volume then
		Managers.music:set_music_volume(music_bus_volume)
	end

	local sfx_bus_volume = user_settings.sfx_bus_volume

	if sfx_bus_volume then
		self.set_wwise_parameter(self, "sfx_bus_volume", sfx_bus_volume)
	end

	local voice_bus_volume = user_settings.voice_bus_volume

	if voice_bus_volume then
		self.set_wwise_parameter(self, "voice_bus_volume", voice_bus_volume)
	end

	local voip_bus_volume = user_settings.voip_bus_volume

	if voip_bus_volume then
		self.voip:set_volume(voip_bus_volume)
	end

	local voip_enabled = user_settings.voip_is_enabled

	if voip_enabled then
		self.voip:set_enabled(voip_enabled)
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

		self.set_wwise_parameter(self, "dynamic_range_sound", setting)
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
		local fov_multiplier = fov/base_fov
		local camera_manager = Managers.state.camera

		camera_manager.set_fov_multiplier(camera_manager, fov_multiplier)
	end

	local mouse_look_sensitivity = user_settings.mouse_look_sensitivity

	if mouse_look_sensitivity then
		local base_look_multiplier = PlayerControllerFilters.look.multiplier
		local input_service = self.input_manager:get_service("Player")
		local input_filters = input_service.input_filters
		local look_filter = input_filters.look
		local function_data = look_filter.function_data
		function_data.multiplier = base_look_multiplier*0.85^(-mouse_look_sensitivity)
	end

	local mouse_look_invert_y = user_settings.mouse_look_invert_y

	if mouse_look_invert_y ~= nil then
		local input_service = self.input_manager:get_service("Player")
		local input_filters = input_service.input_filters
		local look_filter = input_filters.look
		local function_data = look_filter.function_data
		function_data.filter_type = (mouse_look_invert_y and "scale_vector3") or "scale_vector3_invert_y"
	end

	local gamepad_look_sensitivity = user_settings.gamepad_look_sensitivity

	if gamepad_look_sensitivity then
		local base_look_multiplier = PlayerControllerFilters.look_controller.multiplier_x
		local input_service = self.input_manager:get_service("Player")
		local input_filters = input_service.input_filters
		local look_filter = input_filters.look_controller
		local function_data = look_filter.function_data
		function_data.multiplier_x = base_look_multiplier*0.85^(-gamepad_look_sensitivity)
		function_data.min_multiplier_x = function_data.multiplier_x*0.25
	end

	local gamepad_zoom_sensitivity = user_settings.gamepad_zoom_sensitivity

	if gamepad_zoom_sensitivity then
		local base_look_multiplier = PlayerControllerFilters.look_controller_zoom.multiplier_x
		local input_service = self.input_manager:get_service("Player")
		local input_filters = input_service.input_filters
		local look_filter = input_filters.look_controller_zoom
		local function_data = look_filter.function_data
		function_data.multiplier_x = base_look_multiplier*0.85^(-gamepad_zoom_sensitivity)
		function_data.min_multiplier_x = function_data.multiplier_x*0.25
	end

	local gamepad_look_invert_y = user_settings.gamepad_look_invert_y

	if gamepad_look_invert_y ~= nil then
		local input_service = self.input_manager:get_service("Player")
		local input_filters = input_service.input_filters
		local look_filter = input_filters.look_controller
		local function_data = look_filter.function_data
		function_data.filter_type = (gamepad_look_invert_y and "scale_vector3_xy_accelerated_x_inverted") or "scale_vector3_xy_accelerated_x"
		local input_service = self.input_manager:get_service("Player")
		local input_filters = input_service.input_filters
		local look_filter = input_filters.look_controller_zoom
		local function_data = look_filter.function_data
		function_data.filter_type = (gamepad_look_invert_y and "scale_vector3_xy_accelerated_x_inverted") or "scale_vector3_xy_accelerated_x"
	end

	local gamepad_use_ps4_style_input_icons = user_settings.gamepad_use_ps4_style_input_icons

	if gamepad_use_ps4_style_input_icons ~= nil then
		UISettings.use_ps4_input_icons = gamepad_use_ps4_style_input_icons
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
		local units = Managers.state.entity:get_entities("PlayerInputExtension")

		for unit, extension in pairs(units) do
			local player = Managers.player:owner(unit)

			if player.local_player and not player.bot_player then
				local input_extension = ScriptUnit.extension(unit, "input_system")
				input_extension.toggle_crouch = toggle_crouch
			end
		end
	end

	local overcharge_opacity = user_settings.overcharge_opacity
	local player_manager = Managers.player

	if overcharge_opacity and player_manager then
		local local_player = player_manager.local_player(player_manager)
		local player_unit = local_player.player_unit
		local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
		local melee_slot_data = inventory_extension.get_slot_data(inventory_extension, "slot_melee")
		local ranged_slot_data = inventory_extension.get_slot_data(inventory_extension, "slot_ranged")

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
				overcharge_extension.set_screen_particle_opacity_modifier(overcharge_extension, overcharge_opacity)
			end

			return 
		end

		set_opacity(melee_slot_data)
		set_opacity(ranged_slot_data)
	end

	local chat_enabled = user_settings.chat_enabled
	local chat_manager = Managers.chat

	if chat_enabled ~= nil and chat_manager then
		chat_manager.set_chat_enabled(chat_manager, chat_enabled)
	end

	local chat_font_size = user_settings.chat_font_size
	local chat_manager = Managers.chat

	if chat_font_size and chat_manager then
		chat_manager.set_font_size(chat_manager, chat_font_size)
	end

	local language_id = user_settings.language_id

	if language_id then
		self.reload_language(self, language_id)
	end

	Application.save_user_settings()

	if needs_reload then
		Application.apply_user_settings()
		Renderer.bake_static_shadows()
	end

	return 
end
OptionsView.apply_keymap_changes = function (self, keymaps)
	PlayerData.controls = PlayerData.controls or {}

	for input_service_name, data in pairs(keymaps) do
		PlayerData.controls[input_service_name] = PlayerData.controls[input_service_name] or {}
		PlayerData.controls[input_service_name].keymap = data.keymap
		local input_service = Managers.input:get_service(input_service_name)

		for key, map in pairs(data.keymap) do
			if definitions.ignore_keybind[key] then
			else
				for i, inputs in ipairs(map.input_mappings) do
					local num_inputs = #inputs/3

					for j = 1, num_inputs, 1 do

						-- decompilation error in this vicinity
						local ij = (j - 1)*3
						local device = inputs[ij + 1]
						local button_name = inputs[ij + 2]
						local button_index = nil
					end
				end
			end
		end
	end

	Managers.save:auto_save(SaveFileName, SaveData)

	return 
end
OPTIONS_VIEW_PRINT_ORIGINAL_VALUES = false
OptionsView.update = function (self, dt)
	if self.suspended then
		return 
	end

	local disable_all_input = self.disable_all_input

	if RELOAD_OPTIONS_VIEW then
		self.create_ui_elements(self)
	end

	local transitioning = self.transitioning(self)

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
	local input_service = input_manager.get_service(input_manager, "options_menu")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local selected_widget = self.selected_widget

	if gamepad_active and not self.exit_popup_id and not transitioning then
		self.handle_controller_navigation_input(self, dt, input_service)
	end

	self.draw_widgets(self, dt, disable_all_input)

	if not transitioning then
		self.update_mouse_scroll_input(self, disable_all_input)

		local allow_gamepad_input = gamepad_active and not self.draw_gamepad_tooltip

		self.handle_apply_button(self, input_service, allow_gamepad_input)

		if self.selected_settings_list then
			self.handle_reset_to_default_button(self, input_service, allow_gamepad_input)
		end
	end

	if self.title_popup_id then
		local result = Managers.popup:query_result(self.title_popup_id)

		if result then
			Managers.popup:cancel_popup(self.title_popup_id)

			self.title_popup_id = nil

			self.handle_title_buttons_popup_results(self, result)
		end
	end

	if self.apply_popup_id then
		local result = Managers.popup:query_result(self.apply_popup_id)

		if result then
			Managers.popup:cancel_popup(self.apply_popup_id)

			self.apply_popup_id = nil

			self.handle_apply_popup_results(self, result)
		end
	end

	if self.exit_popup_id then
		local result = Managers.popup:query_result(self.exit_popup_id)

		if result then
			Managers.popup:cancel_popup(self.exit_popup_id)

			self.exit_popup_id = nil

			self.handle_exit_button_popup_results(self, result)
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

		if not disable_all_input and not self.draw_gamepad_tooltip and ((not selected_widget and input_service.get(input_service, "toggle_menu")) or (exit_button_hotspot.is_hover and exit_button_hotspot.on_release)) then
			WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
			self.on_exit_pressed(self)
		end
	end

	return 
end
OptionsView.on_exit_pressed = function (self)
	if self.changes_been_made(self) then
		local text = Localize("unapplied_changes_popup_text")
		self.exit_popup_id = Managers.popup:queue_popup(text, Localize("popup_discard_changes_topic"), "revert_changes", Localize("popup_choice_discard"), "cancel", Localize("popup_choice_cancel"))
	else
		self.exit(self)
	end

	return 
end
local needs_restart_settings = definitions.needs_restart_settings
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
			self.unsuspend(self)

			if self.delayed_title_change then
				self.select_settings_title(self, self.delayed_title_change)

				self.delayed_title_change = nil
			end
		end

		self.set_original_settings(self)
		self.reset_changed_settings(self)
	elseif result == "revert_changes" then
		if self.changed_keymaps then
			self.apply_keymap_changes(self, self.original_keymaps)
		else
			self.apply_changes(self, self.original_user_settings, self.original_render_settings)
		end

		self.unsuspend(self)

		if self.delayed_title_change then
			self.select_settings_title(self, self.delayed_title_change)

			self.delayed_title_change = nil
		else
			self.set_original_settings(self)
			self.reset_changed_settings(self)
			self.set_widget_values(self, self.selected_settings_list)
		end
	elseif result == "restart" then
		self.unsuspend(self)
		self.level_transition_handler:set_next_level("inn_level")
		self.ingame_ui:handle_transition("restart_game")
	elseif result == "continue" then
		self.unsuspend(self)

		if self.delayed_title_change then
			self.select_settings_title(self, self.delayed_title_change)

			self.delayed_title_change = nil
		end
	else
		print(result)
	end

	return 
end
OptionsView.handle_title_buttons_popup_results = function (self, result)
	if result == "revert_changes" then
		if self.changed_keymaps then
			self.apply_keymap_changes(self, self.original_keymaps)
		else
			self.apply_changes(self, self.original_user_settings, self.original_render_settings)
		end

		self.unsuspend(self)
		self.reset_changed_settings(self)

		if self.delayed_title_change then
			self.select_settings_title(self, self.delayed_title_change)

			self.delayed_title_change = nil
		else
			self.set_original_settings(self)
			self.set_widget_values(self, self.selected_settings_list)
		end
	elseif result == "apply_changes" then
		self.unsuspend(self)
		self.handle_apply_changes(self)
	else
		print(result)
	end

	return 
end
OptionsView.handle_exit_button_popup_results = function (self, result)
	if result == "revert_changes" then
		if self.changed_keymaps then
			self.apply_keymap_changes(self, self.original_keymaps)
		else
			self.apply_changes(self, self.original_user_settings, self.original_render_settings)
		end

		self.set_original_settings(self)
		self.reset_changed_settings(self)
		self.exit(self)
	elseif result == "cancel" then
		self.unsuspend(self)
	else
		print(result)
	end

	return 
end
OptionsView.update_apply_button = function (self)

	-- decompilation error in this vicinity
	local widget = self.apply_button

	if self.changes_been_made(self) then
		widget.content.button_hotspot.disabled = false
	else
		widget.content.button_hotspot.disabled = true
	end

	return 
end
OptionsView.handle_apply_changes = function (self)
	if self.changed_keymaps then
		self.apply_keymap_changes(self, self.keymaps)
	else
		self.apply_changes(self, self.changed_user_settings, self.changed_render_settings)
	end

	if self.selected_settings_list.needs_apply_confirmation then
		local text = Localize("keep_changes_popup_text")
		self.apply_popup_id = Managers.popup:queue_popup(text, Localize("popup_keep_changes_topic"), "keep_changes", Localize("popup_choice_keep"), "revert_changes", Localize("popup_choice_revert"))

		Managers.popup:activate_timer(self.apply_popup_id, 15, "revert_changes")
	else
		self.handle_apply_popup_results(self, "keep_changes")

		if self.delayed_title_change then
			self.select_settings_title(self, self.delayed_title_change)

			self.delayed_title_change = nil
		end
	end

	return 
end
OptionsView.handle_apply_button = function (self, input_service, allow_gamepad_input)
	if self.apply_button.content.button_hotspot.disabled then
		return 
	end

	local apply_button_hotspot = self.apply_button.content.button_hotspot

	if apply_button_hotspot.on_hover_enter then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_hover")
	end

	if (apply_button_hotspot.is_hover and apply_button_hotspot.on_release) or (allow_gamepad_input and input_service.get(input_service, "refresh")) then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
		self.handle_apply_changes(self)
	end

	return 
end
OptionsView.reset_to_default_drop_down = function (self, widget)
	local content = widget.content
	local default_value = content.default_value
	content.current_selection = default_value
	content.selected_option = content.options_texts[default_value]

	content.callback(content, default_value)

	return 
end
OptionsView.reset_to_default_slider = function (self, widget)
	local content = widget.content
	local default_value = content.default_value
	content.value = default_value
	content.internal_value = get_slider_value(content.min, content.max, default_value)

	content.callback(content)

	return 
end
OptionsView.reset_to_default_checkbox = function (self, widget)
	local content = widget.content
	local default_value = content.default_value
	content.flag = default_value

	content.callback(content)

	return 
end
OptionsView.reset_to_default_stepper = function (self, widget)
	local content = widget.content
	local default_value = content.default_value
	content.current_selection = default_value

	content.callback(content)

	return 
end
OptionsView.reset_to_default_keybind = function (self, widget)
	local content = widget.content
	local default_value = content.default_value

	content.callback(default_value.key, default_value.controller, content)

	return 
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
				self.reset_to_default_drop_down(self, widget)
			elseif widget_type == "slider" then
				self.reset_to_default_slider(self, widget)
			elseif widget_type == "checkbox" then
				self.reset_to_default_checkbox(self, widget)
			elseif widget_type == "stepper" then
				self.reset_to_default_stepper(self, widget)
			elseif widget_type == "keybind" then
				self.reset_to_default_keybind(self, widget)
			else
				error("Not supported widget type..")
			end
		end
	end

	return 
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

	if reset_to_default_hotspot.on_release or (allow_gamepad_input and input_service.get(input_service, "special_1")) then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
		self.start_gamepad_reset_animation(self)
		self.reset_current_settings_list_to_default(self)
	end

	return 
end
OptionsView.start_gamepad_reset_animation = function (self)
	local animation_name = "gamepad_reset"
	local from = 0
	local to = 255
	local widget = self.gamepad_reset_text_widget
	self.ui_animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.text.text_color, 1, from, to, 0.2, math.easeInCubic, UIAnimation.wait, 0.3, UIAnimation.function_by_time, widget.style.text.text_color, 1, to, from, 0.3, math.easeInCubic)

	return 
end
OptionsView.cancel_gamepad_reset_animation = function (self)
	local widget = self.gamepad_reset_text_widget
	widget.style.text.text_color[1] = 0
	local animation_name = "gamepad_reset"
	self.ui_animations[animation_name] = nil

	return 
end
OptionsView.draw_widgets = function (self, dt, disable_all_input)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "options_menu")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local draw_gamepad_tooltip = self.draw_gamepad_tooltip

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	local background_widgets = self.background_widgets
	local background_widgets_n = self.background_widgets_n

	for i = 1, background_widgets_n, 1 do
		UIRenderer.draw_widget(ui_renderer, background_widgets[i])
	end

	if self.selected_settings_list and not draw_gamepad_tooltip then
		self.update_settings_list(self, self.selected_settings_list, ui_renderer, ui_scenegraph, input_service, dt, disable_all_input)
	end

	self.handle_title_buttons(self, ui_renderer, disable_all_input)
	self.update_apply_button(self)

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
		end

		if draw_gamepad_tooltip then
			UIRenderer.draw_widget(ui_renderer, self.gamepad_tooltip_text_widget)
		end

		UIRenderer.draw_widget(ui_renderer, self.gamepad_reset_text_widget)
	end

	UIRenderer.end_pass(ui_renderer)

	local selected_title_name = SettingsMenuNavigation[self.selected_title]

	if selected_title_name == "calibrate_ui" then
		self.ui_calibration_view:update(self.ui_top_renderer, input_service, dt)
	end

	if gamepad_active then
		local popup_active = self.exit_popup_id or self.title_popup_id or self.apply_popup_id

		if not popup_active then
			self.menu_input_description:draw(ui_renderer, dt)
		end
	end

	return 
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
		self.update_scrollbar(self, settings_list, ui_scenegraph)
	end

	local scenegraph_id_start = settings_list.scenegraph_id_start
	local list_position = UISceneGraph.get_world_position(ui_scenegraph, scenegraph_id_start)
	local mask_pos = Vector3.copy(UISceneGraph.get_world_position(ui_scenegraph, "list_mask"))
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
		temp_pos_table.y = temp_pos_table.y + size[2]/2
		local middle_visible = math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)
		temp_pos_table.y = temp_pos_table.y + size[2]/2
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
			self.handle_mouse_widget_input(self, widget, input_service)
		end

		if content.highlight_hotspot and content.highlight_hotspot.on_hover_enter then
			widget.content.is_highlighted = true

			self.select_settings_list_widget(self, i)
		end
	end

	settings_list.visible_widgets_n = visible_widgets_n

	return 
end
OptionsView.update_scrollbar = function (self, settings_list, ui_scenegraph)
	local scrollbar = self.scrollbar
	local value = scrollbar.content.scroll_bar_info.value
	local max_offset_y = settings_list.max_offset_y
	local offset_y = max_offset_y*value
	local scenegraph = ui_scenegraph[settings_list.scenegraph_id]
	scenegraph.offset[2] = offset_y

	return 
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
				if self.changes_been_made(self) then
					local text = Localize("unapplied_changes_popup_text")
					self.title_popup_id = Managers.popup:queue_popup(text, Localize("popup_discard_changes_topic"), "apply_changes", Localize("menu_settings_apply"), "revert_changes", Localize("popup_choice_discard"))
					self.delayed_title_change = i
				else
					self.select_settings_title(self, i)

					self.in_settings_sub_menu = true
				end
			end
		end
	end

	return 
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

	return 
end
OptionsView.set_widget_values = function (self, settings_list)
	local widgets = settings_list.widgets
	local widgets_n = settings_list.widgets_n

	for i = 1, widgets_n, 1 do
		local widget = widgets[i]
		local saved_value_cb = widget.content.saved_value_cb

		saved_value_cb(widget)
	end

	return 
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

		self.deselect_settings_list_widget(self, deselect_widget)
	else
		self.gamepad_active_generic_actions_name = nil

		self.change_gamepad_generic_input_action(self)
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

	return 
end
OptionsView.deselect_settings_list_widget = function (self, widget)
	widget.content.is_highlighted = false

	self.menu_input_description:set_input_description(nil)

	return 
end
OptionsView.settings_list_widget_enter = function (self, i)
	local selected_settings_list = self.selected_settings_list

	if not selected_settings_list then
		return 
	end

	local list_widgets = selected_settings_list.widgets
	local widget = list_widgets[i]
	widget.content.is_active = true

	return 
end
OptionsView.select_settings_title = function (self, i)
	self.menu_input_description:set_input_description(nil)

	if self.selected_title then
		self.deselect_title(self, self.selected_title)
	end

	local title_buttons = self.title_buttons
	local widget = title_buttons[i]
	widget.content.button_hotspot.is_selected = true

	self.trigger_menu_button_animation(self, widget)

	self.selected_title = i
	local settings_list_name = SettingsMenuNavigation[i]

	fassert(self.settings_lists[settings_list_name], "No settings list called %q", settings_list_name)

	local settings_list = self.settings_lists[settings_list_name]

	if settings_list.scrollbar then
		self.setup_scrollbar(self, settings_list)
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

	self.set_widget_values(self, settings_list)

	self.selected_settings_list = settings_list

	return 
end
OptionsView.deselect_title = function (self, i)
	self.selected_title = nil
	local selected_settings_list = self.selected_settings_list
	local selected_list_index = selected_settings_list.selected_index
	local list_widgets = selected_settings_list.widgets

	if selected_list_index then
		local deselect_widget = list_widgets[selected_list_index]

		self.deselect_settings_list_widget(self, deselect_widget)
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

	return 
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

	return 
end
OptionsView.setup_scrollbar = function (self, settings_list)
	local scrollbar = self.scrollbar
	local scenegraph_id = settings_list.scenegraph_id
	local settings_list_size_y = self.ui_scenegraph[scenegraph_id].size[2]
	local mask_size_y = self.ui_scenegraph.list_mask.size[2]
	local percentage = mask_size_y/settings_list_size_y
	scrollbar.content.scroll_bar_info.bar_height_percentage = percentage

	self.set_scrollbar_value(self, 0)

	return 
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
			self.set_scrollbar_value(self, mouse_scroll_value)
		elseif current_scroll_value ~= scroll_bar_value then
			self.set_scrollbar_value(self, scroll_bar_value)
		end
	end

	return 
end
OptionsView.set_scrollbar_value = function (self, value)
	local current_scroll_value = self.scroll_value

	if not current_scroll_value or value ~= current_scroll_value then
		local widget_scroll_bar_info = self.scrollbar.content.scroll_bar_info
		widget_scroll_bar_info.value = value
		self.scroll_field_widget.content.internal_scroll_value = value
		self.scroll_value = value
	end

	return 
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

	return 
end
OptionsView.handle_controller_navigation_input = function (self, dt, input_service)
	self.change_gamepad_generic_input_action(self)

	if 0 < self.controller_cooldown then
		self.controller_cooldown = self.controller_cooldown - dt
	else
		local in_settings_sub_menu = self.in_settings_sub_menu

		if in_settings_sub_menu then
			self.draw_gamepad_tooltip = self.gamepad_tooltip_available and input_service.get(input_service, "cycle_previous_hold")

			if self.draw_gamepad_tooltip then
				return 
			end

			local input_handled, is_active = self.handle_settings_list_widget_input(self, input_service, dt)

			if input_handled then
				if is_active ~= nil then
					self.set_selected_input_description_by_active(self, is_active)
				end

				return 
			elseif input_service.get(input_service, "back", true) then
				local selected_settings_list = self.selected_settings_list

				if selected_settings_list.scrollbar then
					self.setup_scrollbar(self, selected_settings_list)
				end

				in_settings_sub_menu = false
				self.in_settings_sub_menu = in_settings_sub_menu

				self.clear_console_setting_list_selection(self)

				self.gamepad_active_generic_actions_name = nil

				self.change_gamepad_generic_input_action(self, true)
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")

				if self.changes_been_made(self) then
					local text = Localize("unapplied_changes_popup_text")
					self.title_popup_id = Managers.popup:queue_popup(text, Localize("popup_discard_changes_topic"), "apply_changes", Localize("menu_settings_apply"), "revert_changes", Localize("popup_choice_discard"))
				end
			end
		else
			if input_service.get(input_service, "confirm") then
				in_settings_sub_menu = true
				self.in_settings_sub_menu = in_settings_sub_menu

				self.set_console_setting_list_selection(self, 1, true, false)
			end

			if input_service.get(input_service, "back", true) then
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
				self.on_exit_pressed(self)
			end
		end

		if in_settings_sub_menu then
			local selected_settings_list = self.selected_settings_list
			local list_widgets = selected_settings_list.widgets
			local selected_list_index = selected_settings_list.selected_index or 0
			local move_up = input_service.get(input_service, "move_up")
			local move_up_hold = input_service.get(input_service, "move_up_hold")

			if move_up or move_up_hold then
				self.controller_cooldown = GamepadSettings.menu_cooldown

				self.set_console_setting_list_selection(self, selected_list_index - 1, false)
			else
				local move_down = input_service.get(input_service, "move_down")
				local move_down_hold = input_service.get(input_service, "move_down_hold")

				if move_down or move_down_hold then
					self.controller_cooldown = GamepadSettings.menu_cooldown

					self.set_console_setting_list_selection(self, selected_list_index + 1, true)
				end
			end
		else
			selected_title_index = self.selected_title or 0
			local move_up = input_service.get(input_service, "move_up")
			local move_up_hold = input_service.get(input_service, "move_up_hold")

			if move_up or move_up_hold then
				self.controller_cooldown = GamepadSettings.menu_cooldown

				self.set_console_title_selection(self, selected_title_index - 1)
			else
				local move_down = input_service.get(input_service, "move_down")
				local move_down_hold = input_service.get(input_service, "move_down_hold")

				if move_down or move_down_hold then
					self.controller_cooldown = GamepadSettings.menu_cooldown

					self.set_console_title_selection(self, selected_title_index + 1)
				end
			end
		end
	end

	return 
end
OptionsView.handle_mouse_widget_input = function (self, widget, input_service)
	local widget_type = widget.type

	self._input_functions[widget_type](widget, input_service)

	return 
end
OptionsView.handle_settings_list_widget_input = function (self, input_service, dt)
	local selected_settings_list = self.selected_settings_list
	local widgets = selected_settings_list.widgets
	local selected_list_index = selected_settings_list.selected_index or 1
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

	if number_of_menu_entries < index or index <= 0 then
		return 
	end

	if not ignore_sound then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
	end

	self.select_settings_title(self, index)

	return 
end
OptionsView.set_console_setting_list_selection = function (self, index, increment_if_disabled, ignore_sound)
	local selected_settings_list = self.selected_settings_list
	local selected_list_index = selected_settings_list.selected_index
	local list_widgets = selected_settings_list.widgets
	local widgets_n = selected_settings_list.widgets_n
	local new_index = index
	local widget = list_widgets[new_index]
	local is_valid_index = self.is_widget_selectable(self, widget)

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
		is_valid_index = self.is_widget_selectable(self, widget)
	end

	if not ignore_sound then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
	end

	local using_scrollbar = selected_settings_list.scrollbar

	if using_scrollbar then
		self.move_scrollbar_based_on_selection(self, new_index)
	end

	self.select_settings_list_widget(self, new_index)

	return 
end
OptionsView.is_widget_selectable = function (self, widget)
	return widget and widget.type ~= "image"
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

		self.deselect_settings_list_widget(self, deselect_widget)

		selected_settings_list.selected_index = nil
	end

	return 
end
OptionsView.move_scrollbar_based_on_selection = function (self, index)
	local selected_settings_list = self.selected_settings_list
	local selected_list_index = selected_settings_list.selected_index
	local going_downwards = (not selected_list_index and true) or selected_list_index < index
	local widgets = selected_settings_list.widgets
	local base_widget = (going_downwards and widgets[index + 1]) or widgets[index - 1]

	if base_widget then
		local max_offset_y = selected_settings_list.max_offset_y
		local ui_scenegraph = self.ui_scenegraph
		local scenegraph_id_start = selected_settings_list.scenegraph_id_start
		local mask_pos = Vector3.copy(UISceneGraph.get_world_position(ui_scenegraph, "list_mask"))
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
			selected_widget_visible = selected_widget_visible and math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)

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
		widget_visible = widget_visible and math.point_is_inside_2d_box(temp_pos_table, mask_pos, mask_size)

		if not widget_visible then
			local step = 0

			if going_downwards then
				local mask_pos_y = mask_pos[2]
				local widget_pos_y = list_position[2] + base_widget_offset[2]
				local diff = math.abs(mask_pos_y - widget_pos_y)
				step = diff/max_offset_y
			else
				local mask_upper_pos_y = mask_pos[2] + mask_size[2]
				local widget_upper_pos_y = temp_pos_table.y
				local diff = math.abs(mask_upper_pos_y - widget_upper_pos_y)
				step = -(diff/max_offset_y)
			end

			local scrollbar = self.scrollbar
			local value = scrollbar.content.scroll_bar_info.value

			self.set_scrollbar_value(self, math.clamp(value + step, 0, 1))
		end
	else
		local scrollbar = self.scrollbar

		if going_downwards then
			self.set_scrollbar_value(self, 1)
		else
			self.set_scrollbar_value(self, 0)
		end
	end

	return 
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
	local widget_input_description = (is_active and widget_type_template.active_input_description) or widget_type_template.input_description

	if is_disabled then
		self.menu_input_description:set_input_description(nil)
	else
		self.menu_input_description:set_input_description(widget_input_description)
	end

	return 
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

	if 0 < animation_duration then
		local animation_name_hover = "stepper_widget_arrow_hover_" .. style_id
		local animation_name_width = "stepper_widget_arrow_width_" .. style_id
		local animation_name_height = "stepper_widget_arrow_height_" .. style_id
		widget_animations[animation_name_hover] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
		widget_animations[animation_name_width] = self.animate_element_by_catmullrom(self, pass_style.size, 1, default_size[1], 0.7, 1, 1, 0.7, animation_duration)
		widget_animations[animation_name_height] = self.animate_element_by_catmullrom(self, pass_style.size, 2, default_size[2], 0.7, 1, 1, 0.7, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	return 
end
OptionsView.on_stepper_arrow_hover = function (self, widget, style_id)
	local widget_animations = widget.ui_animations
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local current_alpha = pass_style.color[1]
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = (current_alpha/target_alpha - 1)*total_time

	if 0 < animation_duration then
		local animation_name_hover = "stepper_widget_arrow_hover_" .. style_id
		widget_animations[animation_name_hover] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	return 
end
OptionsView.on_stepper_arrow_dehover = function (self, widget, style_id)
	local widget_animations = widget.ui_animations
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local current_alpha = pass_style.color[1]
	local target_alpha = 0
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = current_alpha/255*total_time

	if 0 < animation_duration then
		local animation_name_hover = "stepper_widget_arrow_hover_" .. style_id
		widget_animations[animation_name_hover] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	return 
end
OptionsView.checkbox_test_setup = function (self)
	return false, "test"
end
OptionsView.checkbox_test_saved_value = function (self, widget)
	widget.content.flag = false

	return 
end
OptionsView.checkbox_test = function (self, content)
	local flag = content.flag

	print("OptionsView:checkbox_test(flag)", self, flag)

	return 
end
OptionsView.slider_test_setup = function (self)
	return 0.5, 5, 500, 0, "Music Volume"
end
OptionsView.slider_test_saved_value = function (self, widget)
	widget.content.value = 0.5

	return 
end
OptionsView.slider_test = function (self, content)
	local value = content.value

	print("OptionsView:slider_test(flag)", self, value)

	return 
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

	return 
end
OptionsView.drop_down_test = function (self, content, i)
	print("OptionsView:dropdown_test(flag)", self, content, i)

	return 
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

	return 
end
OptionsView.cb_stepper_test = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	local value = options_values[current_selection]

	print(value)

	return 
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
	local vsync = Application.user_setting("vsync") or false
	local selection = (vsync and 2) or 1
	local default_value = (DefaultUserSettings.get("user_settings", "vsync") and 2) or 1

	return selection, options, "settings_menu_vsync", default_value
end
OptionsView.cb_vsync_saved_value = function (self, widget)
	local vsync = assigned(self.changed_user_settings.vsync, Application.user_setting("vsync"))
	widget.content.current_selection = (vsync and 2) or 1

	return 
end
OptionsView.cb_vsync = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.vsync = options_values[current_selection]

	return 
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
	local use_hud_screen_fit = Application.user_setting("use_hud_screen_fit") or false
	local selection = (use_hud_screen_fit and 2) or 1
	local default_value = (DefaultUserSettings.get("user_settings", "use_hud_screen_fit") and 2) or 1

	return selection, options, "settings_menu_hud_screen_fit", default_value
end
OptionsView.cb_hud_screen_fit_saved_value = function (self, widget)
	local use_hud_screen_fit = assigned(self.changed_user_settings.use_hud_screen_fit, Application.user_setting("use_hud_screen_fit"))
	widget.content.current_selection = (use_hud_screen_fit and 2) or 1

	return 
end
OptionsView.cb_hud_screen_fit = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_hud_screen_fit = options_values[current_selection]

	return 
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
	local windowed = not fullscreen and not borderless_fullscreen
	local selected_option = (fullscreen and 1) or (borderless_fullscreen and 2) or 3
	local default_fullscreen = DefaultUserSettings.get("user_settings", "fullscreen")
	local default_borderless_fullscreen = DefaultUserSettings.get("user_settings", "borderless_fullscreen")
	local default_option = (default_fullscreen and 1) or (borderless_fullscreen and 2) or 3

	return selected_option, options, "menu_settings_windowed_mode", default_option
end
OptionsView.cb_fullscreen_saved_value = function (self, widget)
	local options_values = widget.content.options_values
	local options_texts = widget.content.options_texts
	local fullscreen = assigned(self.changed_user_settings.fullscreen, Application.user_setting("fullscreen"))
	local borderless_fullscreen = assigned(self.changed_user_settings.borderless_fullscreen, Application.user_setting("borderless_fullscreen"))
	local windowed = not fullscreen and not borderless_fullscreen
	local selected_option = (fullscreen and 1) or (borderless_fullscreen and 2) or 3
	widget.content.current_selection = selected_option

	return 
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
		self.set_widget_disabled(self, "resolutions", true)
	else
		self.set_widget_disabled(self, "resolutions", false)
	end

	return 
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

	return 
end
OptionsView.cb_adapter = function (self, content, selected_index)
	local options_values = content.options_values
	local value = options_values[content.current_selection]
	local changed_user_settings = self.changed_user_settings
	changed_user_settings.adapter_index = value

	return 
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

	return 
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
			content.callback(content, true)
		end
	end

	return 
end
OptionsView.cb_resolutions_setup = function (self)
	local screen_resolution = Application.user_setting("screen_resolution")
	local output_screen = Application.user_setting("fullscreen_output")
	local adapter_index = Application.user_setting("adapter_index")

	if DisplayAdapter.num_outputs(adapter_index) < 1 then
		local num_adapters = DisplayAdapter.num_adapters()

		for i = 0, num_adapters - 1, 1 do
			if 0 < DisplayAdapter.num_outputs(i) then
				adapter_index = i

				break
			end
		end
	end

	local options = {}
	local num_modes = DisplayAdapter.num_modes(adapter_index, output_screen)

	for i = 0, num_modes - 1, 1 do
		local width, height = DisplayAdapter.mode(adapter_index, output_screen, i)

		if width < GameSettingsDevelopment.lowest_resolution then
		else
			local text = tostring(width) .. "x" .. tostring(height)
			options[#options + 1] = {
				text = text,
				value = {
					width,
					height
				}
			}
		end
	end

	local function comparator(a, b)
		return b.value[1] < a.value[1]
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

	return 
end
OptionsView.cb_resolutions = function (self, content)
	local selected_index = content.current_selection
	local options_values = content.options_values
	local value = options_values[selected_index]
	self.changed_user_settings.screen_resolution = table.clone(value)

	return 
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
	local max_fps = Application.user_setting("max_fps") or 0

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
	local max_fps = assigned(self.changed_user_settings.max_fps, Application.user_setting("max_fps")) or 0

	for i = 1, #options_values, 1 do
		if max_fps == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_lock_framerate = function (self, content)
	local selected_index = content.current_selection
	local value = content.options_values[selected_index]
	self.changed_user_settings.max_fps = value

	return 
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
	local max_stacking_frames = Application.user_setting("max_stacking_frames") or -1

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
	local max_stacking_frames = assigned(self.changed_user_settings.max_stacking_frames, Application.user_setting("max_stacking_frames")) or -1

	for i = 1, #options_values, 1 do
		if max_stacking_frames == options_values[i] then
			current_selection = i

			break
		end
	end

	widget.content.current_selection = current_selection

	return 
end
OptionsView.cb_max_stacking_frames = function (self, content)
	self.changed_user_settings.max_stacking_frames = content.options_values[content.current_selection]

	return 
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
	local selected_option = (fxaa_enabled and 2) or (taa_enabled and 3) or 1
	local default_fxaa_enabled = DefaultUserSettings.get("render_settings", "fxaa_enabled")
	local default_taa_enabled = DefaultUserSettings.get("render_settings", "taa_enabled")
	local default_option = (default_fxaa_enabled and 2) or (default_taa_enabled and 3) or 1

	return selected_option, options, "menu_settings_anti_aliasing", default_option
end
OptionsView.cb_anti_aliasing_saved_value = function (self, widget)
	local fxaa_enabled = assigned(self.changed_render_settings.fxaa_enabled, Application.user_setting("render_settings", "fxaa_enabled"))
	local taa_enabled = assigned(self.changed_render_settings.taa_enabled, Application.user_setting("render_settings", "taa_enabled"))
	local selected_option = (fxaa_enabled and 2) or (taa_enabled and 3) or 1
	widget.content.current_selection = selected_option

	return 
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
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
end
OptionsView.cb_gamma_setup = function (self)
	local min = 1.5
	local max = 5
	local gamma = Application.user_setting("render_settings", "gamma") or 2.2
	local value = get_slider_value(min, max, gamma)
	local default_value = math.clamp(DefaultUserSettings.get("render_settings", "gamma"), min, max)

	return value, min, max, 1, "menu_settings_gamma", default_value
end
OptionsView.cb_gamma_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local gamma = assigned(self.changed_render_settings.gamma, Application.user_setting("render_settings", "gamma")) or 2.2
	gamma = math.clamp(gamma, min, max)
	content.internal_value = get_slider_value(min, max, gamma)
	content.value = gamma

	return 
end
OptionsView.cb_gamma = function (self, content)
	self.changed_render_settings.gamma = content.value

	Application.set_render_setting("gamma", content.value)

	return 
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

	return 
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
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local saved_option = Application.user_setting("render_settings", "lod_object_multiplier") or 1
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
	local lod_object_multiplier = assigned(self.changed_render_settings.lod_object_multiplier, Application.user_setting("render_settings", "lod_object_multiplier")) or 1

	for i = 1, #options_values, 1 do
		if lod_object_multiplier == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_lod_quality = function (self, content)
	local value = content.options_values[content.current_selection] or 1
	self.changed_render_settings.lod_object_multiplier = value

	return 
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
	local saved_option = Application.user_setting("render_settings", "lod_scatter_density") or 1
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
	local lod_scatter_density = assigned(self.changed_render_settings.lod_scatter_density, Application.user_setting("render_settings", "lod_scatter_density")) or 1

	for i = 1, #options_values, 1 do
		if lod_scatter_density == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_scatter_density = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection] or 1
	self.changed_render_settings.lod_scatter_density = value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local saved_option = Application.user_setting("render_settings", "lod_decoration_density") or 1
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
	local lod_decoration_density = assigned(self.changed_render_settings.lod_decoration_density, Application.user_setting("render_settings", "lod_decoration_density")) or 1

	for i = 1, #options_values, 1 do
		if lod_decoration_density == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_decoration_density = function (self, content)
	local value = content.options_values[content.current_selection] or 1
	self.changed_render_settings.lod_decoration_density = value

	return 
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

	return 
end
OptionsView.cb_maximum_shadow_casting_lights = function (self, content, called_from_graphics_quality)
	self.changed_render_settings.max_shadow_casting_lights = content.value

	for i = 1, 10, 1 do
		print("max_shadow_casting_lights", content.value)
	end

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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

	return 
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
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local motion_blur_enabled = Application.user_setting("render_settings", "motion_blur_enabled")
	local selected_option = (motion_blur_enabled and 2) or 1

	return selected_option, options, "menu_settings_motion_blur"
end
OptionsView.cb_motion_blur_saved_value = function (self, widget)
	local motion_blur_enabled = assigned(self.changed_render_settings.motion_blur_enabled, Application.user_setting("render_settings", "motion_blur_enabled"))
	local selected_option = (motion_blur_enabled and 2) or 1
	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_motion_blur = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.motion_blur_enabled = value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local selected_option = (dof_enabled and 2) or 1

	return selected_option, options, "menu_settings_dof"
end
OptionsView.cb_dof_saved_value = function (self, widget)
	local dof_enabled = assigned(self.changed_render_settings.dof_enabled, Application.user_setting("render_settings", "dof_enabled"))
	local selected_option = (dof_enabled and 2) or 1
	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_dof = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.dof_enabled = value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local bloom_enabled = Application.user_setting("render_settings", "bloom_enabled") or false
	local default_value = DefaultUserSettings.get("render_settings", "bloom_enabled")
	local selection = (bloom_enabled and 2) or 1
	local default_option = (default_value and 2) or 1

	return selection, options, "menu_settings_bloom", default_option
end
OptionsView.cb_bloom_saved_value = function (self, widget)
	local bloom_enabled = assigned(self.changed_render_settings.bloom_enabled, Application.user_setting("render_settings", "bloom_enabled")) or false
	widget.content.current_selection = (bloom_enabled and 2) or 1

	return 
end
OptionsView.cb_bloom = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_render_settings.bloom_enabled = options_values[current_selection]

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local light_shaft_enabled = Application.user_setting("render_settings", "light_shaft_enabled") or false
	local default_value = DefaultUserSettings.get("render_settings", "light_shaft_enabled")
	local selection = (light_shaft_enabled and 2) or 1
	local default_option = (default_value and 2) or 1

	return selection, options, "menu_settings_light_shafts", default_option
end
OptionsView.cb_light_shafts_saved_value = function (self, widget)
	local light_shaft_enabled = assigned(self.changed_render_settings.light_shaft_enabled, Application.user_setting("render_settings", "light_shaft_enabled")) or false
	widget.content.current_selection = (light_shaft_enabled and 2) or 1

	return 
end
OptionsView.cb_light_shafts = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_render_settings.light_shaft_enabled = options_values[current_selection]

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local skin_material_enabled = Application.user_setting("render_settings", "skin_material_enabled") or false
	local default_value = DefaultUserSettings.get("render_settings", "skin_material_enabled")
	local selection = (skin_material_enabled and 2) or 1
	local default_option = (default_value and 2) or 1

	return selection, options, "menu_settings_skin_shading", default_option
end
OptionsView.cb_skin_shading_saved_value = function (self, widget)
	local skin_material_enabled = assigned(self.changed_render_settings.skin_material_enabled, Application.user_setting("render_settings", "skin_material_enabled")) or false
	widget.content.current_selection = (skin_material_enabled and 2) or 1

	return 
end
OptionsView.cb_skin_shading = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_render_settings.skin_material_enabled = options_values[current_selection]

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local selected_option = (ao_enabled and 2) or 1

	return selected_option, options, "menu_settings_ssao"
end
OptionsView.cb_ssao_saved_value = function (self, widget)
	local ao_enabled = assigned(self.changed_render_settings.ao_enabled, Application.user_setting("render_settings", "ao_enabled"))
	local selected_option = (ao_enabled and 2) or 1
	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_ssao = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.ao_enabled = value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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

	return 
end
OptionsView.cb_char_texture_quality = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.char_texture_quality = value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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

	return 
end
OptionsView.cb_env_texture_quality = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.env_texture_quality = value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local use_subtitles = Application.user_setting("use_subtitles") or false
	local selection = (use_subtitles and 2) or 1
	local default_value = (DefaultUserSettings.get("user_settings", "use_subtitles") and 2) or 1

	return selection, options, "menu_settings_subtitles", default_value
end
OptionsView.cb_subtitles_saved_value = function (self, widget)
	local use_subtitles = assigned(self.changed_user_settings.use_subtitles, Application.user_setting("use_subtitles")) or false
	widget.content.current_selection = (use_subtitles and 2) or 1

	return 
end
OptionsView.cb_subtitles = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_subtitles = options_values[current_selection]

	return 
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
	local language_id = Application.user_setting("language_id") or (rawget(_G, "Steam") and Steam.language()) or "en"
	local default_value = DefaultUserSettings.get("user_settings", "language_id") or "en"
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
	local language_id = assigned(self.changed_user_settings.language_id, Application.user_setting("language_id")) or "en"
	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if language_id == options_values[i] then
			selected_option = i
		end
	end

	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_language = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.language_id = options_values[current_selection]

	return 
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
		return LocalizerTweakData[tweak_name] or "<missing LocalizerTweakData \"" .. tweak_name .. "\">"
	end

	Managers.localizer:add_macro("TWEAK", tweak_parser)

	local function key_parser(input_service_and_key_name)
		local split_start, split_end = string.find(input_service_and_key_name, "__")

		assert(split_start and split_end, "[key_parser] You need to specify a key using this format $KEY;<input_service>__<key>. Example: $KEY;options_menu__back (note the dubbel underline separating input service and key")

		local input_service_name = string.sub(input_service_and_key_name, 1, split_start - 1)
		local key_name = string.sub(input_service_and_key_name, split_end + 1)
		local input_service = Managers.input:get_service(input_service_name)

		fassert(input_service, "[key_parser] No input service with the name %s", input_service_name)

		local key = input_service.get_keymapping(input_service, key_name)

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
				end
			else
				key_locale_name = string.format("<Mapping missing for key %s on device %s>", key_name, device_type)
			end
		end

		return key_locale_name
	end

	Managers.localizer:add_macro("KEY", key_parser)

	return 
end
OptionsView.cb_mouse_look_sensitivity_setup = function (self)
	local min = -10
	local max = 10
	local sensitivity = Application.user_setting("mouse_look_sensitivity") or 0
	local default_value = DefaultUserSettings.get("user_settings", "mouse_look_sensitivity")
	local value = get_slider_value(min, max, sensitivity)
	sensitivity = math.clamp(sensitivity, min, max)
	local base_look_multiplier = PlayerControllerFilters.look.multiplier
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service.input_filters
	local look_filter = input_filters.look
	local function_data = look_filter.function_data
	function_data.multiplier = base_look_multiplier*0.85^(-sensitivity)

	return value, min, max, 1, "menu_settings_mouse_look_sensitivity", default_value
end
OptionsView.cb_mouse_look_sensitivity_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local sensitivity = assigned(self.changed_user_settings.mouse_look_sensitivity, Application.user_setting("mouse_look_sensitivity")) or 0
	sensitivity = math.clamp(sensitivity, min, max)
	content.internal_value = get_slider_value(min, max, sensitivity)
	content.value = sensitivity

	return 
end
OptionsView.cb_mouse_look_sensitivity = function (self, content)
	self.changed_user_settings.mouse_look_sensitivity = content.value

	return 
end
OptionsView.cb_gamepad_look_sensitivity_setup = function (self)
	local min = -10
	local max = 10
	local sensitivity = Application.user_setting("gamepad_look_sensitivity") or 0
	local default_value = DefaultUserSettings.get("user_settings", "gamepad_look_sensitivity")
	local value = get_slider_value(min, max, sensitivity)
	sensitivity = math.clamp(sensitivity, min, max)
	local base_look_multiplier = PlayerControllerFilters.look_controller.multiplier_x
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service.input_filters
	local look_filter = input_filters.look_controller
	local function_data = look_filter.function_data
	function_data.multiplier_x = base_look_multiplier*0.85^(-sensitivity)
	function_data.min_multiplier_x = function_data.multiplier_x*0.25

	return value, min, max, 1, "menu_settings_gamepad_look_sensitivity", default_value
end
OptionsView.cb_gamepad_look_sensitivity_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local sensitivity = assigned(self.changed_user_settings.gamepad_look_sensitivity, Application.user_setting("gamepad_look_sensitivity")) or 0
	sensitivity = math.clamp(sensitivity, min, max)
	content.internal_value = get_slider_value(min, max, sensitivity)
	content.value = sensitivity

	return 
end
OptionsView.cb_gamepad_look_sensitivity = function (self, content)
	self.changed_user_settings.gamepad_look_sensitivity = content.value

	return 
end
OptionsView.cb_gamepad_zoom_sensitivity_setup = function (self)
	local min = -10
	local max = 10
	local sensitivity = Application.user_setting("gamepad_zoom_sensitivity") or 0
	local default_value = DefaultUserSettings.get("user_settings", "gamepad_zoom_sensitivity")
	local value = get_slider_value(min, max, sensitivity)
	sensitivity = math.clamp(sensitivity, min, max)
	local base_look_multiplier = PlayerControllerFilters.look_controller_zoom.multiplier_x
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service.input_filters
	local look_filter = input_filters.look_controller_zoom
	local function_data = look_filter.function_data
	function_data.multiplier_x = base_look_multiplier*0.85^(-sensitivity)
	function_data.min_multiplier_x = function_data.multiplier_x*0.25

	return value, min, max, 1, "menu_settings_gamepad_zoom_sensitivity", default_value
end
OptionsView.cb_gamepad_zoom_sensitivity_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local sensitivity = assigned(self.changed_user_settings.gamepad_zoom_sensitivity, Application.user_setting("gamepad_zoom_sensitivity")) or 0
	sensitivity = math.clamp(sensitivity, min, max)
	content.internal_value = get_slider_value(min, max, sensitivity)
	content.value = sensitivity

	return 
end
OptionsView.cb_gamepad_zoom_sensitivity = function (self, content)
	self.changed_user_settings.gamepad_zoom_sensitivity = content.value

	return 
end
OptionsView.cb_max_upload_speed = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.max_upload_speed = options_values[current_selection]

	return 
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
			text = Localize("menu_settings_2mbit+")
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

	return selected_option or default_option, options, "menu_settings_max_upload", default_option
end
OptionsView.cb_max_upload_speed_saved_value = function (self, widget)
	local value = assigned(self.changed_user_settings.max_upload_speed, Application.user_setting("max_upload_speed")) or DefaultUserSettings.get("user_settings", "max_upload_speed")
	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if value == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option

	return 
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
	local input_filters = input_service.input_filters
	local look_filter = input_filters.look
	local function_data = look_filter.function_data
	function_data.filter_type = (invert_mouse_y and "scale_vector3") or "scale_vector3_invert_y"
	local selection = (invert_mouse_y and 2) or 1
	local default_option = (default_value and 2) or 1

	return selection, options, "menu_settings_mouse_look_invert_y", default_option
end
OptionsView.cb_mouse_look_invert_y_saved_value = function (self, widget)
	local invert_mouse_y = assigned(self.changed_user_settings.mouse_look_invert_y, Application.user_setting("mouse_look_invert_y")) or false
	widget.content.current_selection = (invert_mouse_y and 2) or 1

	return 
end
OptionsView.cb_mouse_look_invert_y = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.mouse_look_invert_y = options_values[current_selection]

	return 
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
	local default_value = DefaultUserSettings.get("user_settings", "gamepad_look_invert_y") or false
	local invert_gamepad_y = Application.user_setting("gamepad_look_invert_y")
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service.input_filters
	local look_filter = input_filters.look_controller
	local function_data = look_filter.function_data
	function_data.filter_type = (invert_gamepad_y and "scale_vector3_xy_accelerated_x_inverted") or "scale_vector3_xy_accelerated_x"
	local input_service = self.input_manager:get_service("Player")
	local input_filters = input_service.input_filters
	local look_filter = input_filters.look_controller_zoom
	local function_data = look_filter.function_data
	function_data.filter_type = (invert_gamepad_y and "scale_vector3_xy_accelerated_x_inverted") or "scale_vector3_xy_accelerated_x"
	local selection = (invert_gamepad_y and 2) or 1
	local default_option = (default_value and 2) or 1

	return selection, options, "menu_settings_gamepad_look_invert_y", default_option
end
OptionsView.cb_gamepad_look_invert_y_saved_value = function (self, widget)
	local invert_gamepad_y = assigned(self.changed_user_settings.gamepad_look_invert_y, Application.user_setting("gamepad_look_invert_y")) or false
	widget.content.current_selection = (invert_gamepad_y and 2) or 1

	return 
end
OptionsView.cb_gamepad_look_invert_y = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_look_invert_y = options_values[current_selection]

	return 
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
	local default_value = DefaultUserSettings.get("user_settings", "gamepad_auto_aim_enabled") or true
	local enable_auto_aim = Application.user_setting("gamepad_auto_aim_enabled")
	local selection = (enable_auto_aim and 1) or 2
	local default_option = (default_value and 1) or 2

	return selection, options, "menu_settings_gamepad_auto_aim_enabled", default_option
end
OptionsView.cb_gamepad_auto_aim_enabled_saved_value = function (self, widget)
	local gamepad_auto_aim_enabled = assigned(self.changed_user_settings.gamepad_auto_aim_enabled, Application.user_setting("gamepad_auto_aim_enabled"))
	widget.content.current_selection = (gamepad_auto_aim_enabled and 1) or 2

	return 
end
OptionsView.cb_gamepad_auto_aim_enabled = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_auto_aim_enabled = options_values[current_selection]

	return 
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
	local default_value = DefaultUserSettings.get("user_settings", "gamepad_use_ps4_style_input_icons") or false
	local use_ps4_style_icons = Application.user_setting("gamepad_use_ps4_style_input_icons")
	local selection = (use_ps4_style_icons and 2) or 1
	local default_option = (default_value and 2) or 1

	return selection, options, "menu_settings_gamepad_use_ps4_style_input_icons", default_option
end
OptionsView.cb_gamepad_use_ps4_style_input_icons_saved_value = function (self, widget)
	local gamepad_use_ps4_style_input_icons = assigned(self.changed_user_settings.gamepad_use_ps4_style_input_icons, Application.user_setting("gamepad_use_ps4_style_input_icons"))
	widget.content.current_selection = (gamepad_use_ps4_style_input_icons and 2) or 1

	return 
end
OptionsView.cb_gamepad_use_ps4_style_input_icons = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.gamepad_use_ps4_style_input_icons = options_values[current_selection]

	return 
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
	local selection = (toggle_crouch and 1) or 2
	local default_option = (default_value and 1) or 2

	return selection, options, "menu_settings_toggle_crouch", default_option
end
OptionsView.cb_toggle_crouch_saved_value = function (self, widget)
	local toggle_crouch = assigned(self.changed_user_settings.toggle_crouch, Application.user_setting("toggle_crouch"))
	widget.content.current_selection = (toggle_crouch and 1) or 2

	return 
end
OptionsView.cb_toggle_crouch = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.toggle_crouch = options_values[current_selection]

	return 
end
OptionsView.cb_overcharge_opacity_setup = function (self)
	local min = 0
	local max = 100
	local overcharge_opacity = Application.user_setting("overcharge_opacity") or DefaultUserSettings.get("user_settings", "overcharge_opacity")
	local default_value = DefaultUserSettings.get("user_settings", "overcharge_opacity")
	local value = get_slider_value(min, max, overcharge_opacity)

	return value, min, max, 0, "menu_settings_overcharge_opacity", default_value
end
OptionsView.cb_overcharge_opacity_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local overcharge_opacity = assigned(self.changed_user_settings.overcharge_opacity, Application.user_setting("overcharge_opacity") or DefaultUserSettings.get("user_settings", "overcharge_opacity"))
	overcharge_opacity = math.clamp(overcharge_opacity, min, max)
	content.internal_value = get_slider_value(min, max, overcharge_opacity)
	content.value = overcharge_opacity

	return 
end
OptionsView.cb_overcharge_opacity = function (self, content)
	self.changed_user_settings.overcharge_opacity = content.value

	return 
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
	local scroll_type = Application.user_setting("weapon_scroll_type") or "scroll_wrap"
	local selection = (scroll_type == "scroll_clamp" and 2) or (scroll_type == "scroll_disabled" and 3) or 1
	local default_option = (default_value == "scroll_clamp" and 2) or (default_value == "scroll_disabled" and 3) or 1

	return selection, options, "menu_settings_weapon_scroll_type", default_option
end
OptionsView.cb_weapon_scroll_type_saved_value = function (self, widget)
	local scroll_type = assigned(self.changed_user_settings.weapon_scroll_type, Application.user_setting("weapon_scroll_type")) or "scroll_wrap"
	widget.content.current_selection = (scroll_type == "scroll_clamp" and 2) or (scroll_type == "scroll_disabled" and 3) or 1

	return 
end
OptionsView.cb_weapon_scroll_type = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.weapon_scroll_type = options_values[current_selection]

	return 
end
OptionsView.cb_double_tap_dodge = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.double_tap_dodge = options_values[current_selection]
	local units = Managers.state.entity:get_entities("PlayerInputExtension")

	for unit, extension in pairs(units) do
		local player = Managers.player:owner(unit)

		if player.local_player and not player.bot_player then
			local input_extension = ScriptUnit.extension(unit, "input_system")
			input_extension.double_tap_dodge = options_values[current_selection]
		end
	end

	return 
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

	local selection = (enabled and 1) or 2
	local default_option = (default_value and 1) or 2

	return selection, options, "menu_settings_double_tap_dodge", default_option
end
OptionsView.cb_double_tap_dodge_saved_value = function (self, widget)
	local enabled = assigned(self.changed_user_settings.double_tap_dodge, Application.user_setting("double_tap_dodge"))

	if enabled == nil then
		enabled = DefaultUserSettings.get("user_settings", "double_tap_dodge")
	end

	widget.content.current_selection = (enabled and 1) or 2

	return 
end
OptionsView.cb_dodge_on_jump_key = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.dodge_on_jump_key = options_values[current_selection]
	local units = Managers.state.entity:get_entities("PlayerInputExtension")

	for unit, extension in pairs(units) do
		local player = Managers.player:owner(unit)

		if player.local_player and not player.bot_player then
			local input_extension = ScriptUnit.extension(unit, "input_system")
			input_extension.dodge_on_jump_key = options_values[current_selection]
		end
	end

	return 
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

	local selection = (enabled and 1) or 2
	local default_option = (default_value and 1) or 2

	return selection, options, "menu_settings_dodge_on_jump_key", default_option
end
OptionsView.cb_dodge_on_jump_key_saved_value = function (self, widget)
	local enabled = assigned(self.changed_user_settings.dodge_on_jump_key, Application.user_setting("dodge_on_jump_key"))

	if enabled == nil then
		enabled = DefaultUserSettings.get("user_settings", "dodge_on_jump_key")
	end

	widget.content.current_selection = (enabled and 1) or 2

	return 
end
OptionsView.cb_dodge_on_forward_diagonal = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.dodge_on_forward_diagonal = options_values[current_selection]
	local units = Managers.state.entity:get_entities("PlayerInputExtension")

	for unit, extension in pairs(units) do
		local player = Managers.player:owner(unit)

		if player.local_player and not player.bot_player then
			local input_extension = ScriptUnit.extension(unit, "input_system")
			input_extension.dodge_on_forward_diagonal = options_values[current_selection]
		end
	end

	return 
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

	local selection = (enabled and 1) or 2
	local default_option = (default_value and 1) or 2

	return selection, options, "menu_settings_dodge_on_forward_diagonal", default_option
end
OptionsView.cb_dodge_on_forward_diagonal_saved_value = function (self, widget)
	local enabled = assigned(self.changed_user_settings.dodge_on_forward_diagonal, Application.user_setting("dodge_on_forward_diagonal"))

	if enabled == nil then
		enabled = DefaultUserSettings.get("user_settings", "dodge_on_forward_diagonal")
	end

	widget.content.current_selection = (enabled and 1) or 2

	return 
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

	local selection = (tutorials_enabled and 1) or 2
	local default_option = (default_value and 1) or 2

	return selection, options, "menu_settings_tutorials_enabled", default_option
end
OptionsView.cb_tutorials_enabled_saved_value = function (self, widget)
	local tutorials_enabled = assigned(self.changed_user_settings.tutorials_enabled, Application.user_setting("tutorials_enabled"))

	if tutorials_enabled == nil then
		tutorials_enabled = true
	end

	widget.content.current_selection = (tutorials_enabled and 1) or 2

	return 
end
OptionsView.cb_tutorials_enabled = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.tutorials_enabled = options_values[current_selection]

	return 
end
OptionsView.cb_master_volume_setup = function (self)
	local min = 0
	local max = 100
	local master_bus_volume = Application.user_setting("master_bus_volume") or 90
	local value = get_slider_value(min, max, master_bus_volume)

	return value, min, max, 0, "menu_settings_master_volume", DefaultUserSettings.get("user_settings", "master_bus_volume")
end
OptionsView.cb_master_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local master_bus_volume = assigned(self.changed_user_settings.master_bus_volume, Application.user_setting("master_bus_volume")) or 90
	content.internal_value = get_slider_value(min, max, master_bus_volume)
	content.value = master_bus_volume

	return 
end
OptionsView.cb_master_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.master_bus_volume = value

	self.set_wwise_parameter(self, "master_bus_volume", value)
	Managers.music:set_master_volume(value)

	return 
end
OptionsView.cb_music_bus_volume_setup = function (self)
	local min = 0
	local max = 100
	local music_bus_volume = Application.user_setting("music_bus_volume") or 90
	local value = get_slider_value(min, max, music_bus_volume)

	return value, min, max, 0, "menu_settings_music_volume", DefaultUserSettings.get("user_settings", "music_bus_volume")
end
OptionsView.cb_music_bus_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local music_bus_volume = assigned(self.changed_user_settings.music_bus_volume, Application.user_setting("music_bus_volume")) or 90
	content.internal_value = get_slider_value(min, max, music_bus_volume)
	content.value = music_bus_volume

	return 
end
OptionsView.cb_music_bus_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.music_bus_volume = value

	Managers.music:set_music_volume(value)

	return 
end
OptionsView.cb_sfx_bus_volume_setup = function (self)
	local min = 0
	local max = 100
	local sfx_bus_volume = Application.user_setting("sfx_bus_volume") or 90
	local value = get_slider_value(min, max, sfx_bus_volume)

	return value, min, max, 0, "menu_settings_sfx_volume", DefaultUserSettings.get("user_settings", "sfx_bus_volume")
end
OptionsView.cb_sfx_bus_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local sfx_bus_volume = assigned(self.changed_user_settings.sfx_bus_volume, Application.user_setting("sfx_bus_volume")) or 90
	content.internal_value = get_slider_value(min, max, sfx_bus_volume)
	content.value = sfx_bus_volume

	return 
end
OptionsView.cb_sfx_bus_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.sfx_bus_volume = value

	self.set_wwise_parameter(self, "sfx_bus_volume", value)

	return 
end
OptionsView.cb_voice_bus_volume_setup = function (self)
	local min = 0
	local max = 100
	local voice_bus_volume = Application.user_setting("voice_bus_volume") or 90
	local value = get_slider_value(min, max, voice_bus_volume)

	return value, min, max, 0, "menu_settings_voice_volume", DefaultUserSettings.get("user_settings", "voice_bus_volume")
end
OptionsView.cb_voice_bus_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local voice_bus_volume = assigned(self.changed_user_settings.voice_bus_volume, Application.user_setting("voice_bus_volume")) or 90
	content.internal_value = get_slider_value(min, max, voice_bus_volume)
	content.value = voice_bus_volume

	return 
end
OptionsView.cb_voice_bus_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.voice_bus_volume = value

	self.set_wwise_parameter(self, "voice_bus_volume", value)

	return 
end
OptionsView.cb_voip_bus_volume_setup = function (self)
	local min = 0
	local max = 100
	local voip_bus_volume = Application.user_setting("voip_bus_volume") or 0
	local value = get_slider_value(min, max, voip_bus_volume)

	return value, min, max, 0, "menu_settings_voip_volume", DefaultUserSettings.get("user_settings", "voip_bus_volume")
end
OptionsView.cb_voip_bus_volume_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local voip_bus_volume = assigned(self.changed_user_settings.voip_bus_volume, Application.user_setting("voip_bus_volume")) or 90
	content.internal_value = get_slider_value(min, max, voip_bus_volume)
	content.value = voip_bus_volume

	return 
end
OptionsView.cb_voip_bus_volume = function (self, content)
	local value = content.value
	self.changed_user_settings.voip_bus_volume = value

	self.voip:set_volume(value)

	return 
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

	self.voip:set_enabled(voip_enabled)

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

	return 
end
OptionsView.cb_voip_enabled = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.voip_is_enabled = value

	self.voip:set_enabled(value)

	return 
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

	self.voip:set_push_to_talk(voip_push_to_talk)

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

	return 
end
OptionsView.cb_voip_push_to_talk = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.voip_push_to_talk = value

	self.voip:set_push_to_talk(value)

	return 
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
	local selected_option = (low_res_transparency and 2) or 1

	return selected_option, options, "menu_settings_low_res_transparency"
end
OptionsView.cb_particles_resolution_saved_value = function (self, widget)
	local low_res_transparency = assigned(self.changed_render_settings.low_res_transparency, Application.user_setting("render_settings", "low_res_transparency"))
	local selected_option = (low_res_transparency and 2) or 1
	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_particles_resolution = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.low_res_transparency = value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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

	return 
end
OptionsView.cb_particles_quality = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.particles_quality = value
	local particle_quality_settings = ParticlesQuality[value]

	for setting, key in pairs(particle_quality_settings) do
		self.changed_render_settings[setting] = key
	end

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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

	local selection = (use_physic_debris and 2) or 1
	local default_selection = (DefaultUserSettings.get("user_settings", "use_physic_debris") and 2) or 1

	return selection, options, "menu_settings_physic_debris", default_selection
end
OptionsView.cb_physic_debris_saved_value = function (self, widget)
	local use_physic_debris = assigned(self.changed_user_settings.use_physic_debris, Application.user_setting("use_physic_debris"))

	if use_physic_debris == nil then
		use_physic_debris = true
	end

	widget.content.current_selection = (use_physic_debris and 2) or 1

	return 
end
OptionsView.cb_physic_debris = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_physic_debris = options_values[current_selection]

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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

	local selection = (use_high_quality_fur and 2) or 1
	local default_selection = (DefaultUserSettings.get("user_settings", "use_high_quality_fur") and 2) or 1

	return selection, options, "menu_settings_high_quality_fur", default_selection
end
OptionsView.cb_high_quality_fur_saved_value = function (self, widget)
	local use_high_quality_fur = assigned(self.changed_user_settings.use_high_quality_fur, Application.user_setting("use_high_quality_fur"))

	if use_high_quality_fur == nil then
		use_high_quality_fur = true
	end

	widget.content.current_selection = (use_high_quality_fur and 2) or 1

	return 
end
OptionsView.cb_high_quality_fur = function (self, content, called_from_graphics_quality)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_high_quality_fur = options_values[current_selection]
	GameSettingsDevelopment.use_high_quality_fur = options_values[current_selection]
	local entity_manager = Managers.state.entity
	local ai_units = (Managers.player.is_server and entity_manager.get_entities(entity_manager, "AISimpleExtension")) or entity_manager.get_entities(entity_manager, "AiHuskBaseExtension")

	for unit, extension in pairs(ai_units) do
		if Unit.alive(unit) then
			Unit.flow_event(unit, "lua_settings_updated")
		end
	end

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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

	local selection = (use_alien_fx and 2) or 1
	local default_selection = (DefaultUserSettings.get("user_settings", "use_alien_fx") and 2) or 1
	GameSettingsDevelopment.use_alien_fx = use_alien_fx

	return selection, options, "menu_settings_alien_fx", default_selection
end
OptionsView.cb_alien_fx_saved_value = function (self, widget)
	local use_alien_fx = assigned(self.changed_user_settings.use_alien_fx, Application.user_setting("use_alien_fx"))

	if use_alien_fx == nil then
		use_alien_fx = true
	end

	widget.content.current_selection = (use_alien_fx and 2) or 1

	return 
end
OptionsView.cb_alien_fx = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.use_alien_fx = options_values[current_selection]
	GameSettingsDevelopment.use_alien_fx = options_values[current_selection]

	return 
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
	local selected_option = (ssr_enabled and 2) or 1

	return selected_option, options, "menu_settings_ssr"
end
OptionsView.cb_ssr_saved_value = function (self, widget)
	local ssr_enabled = assigned(self.changed_render_settings.ssr_enabled, Application.user_setting("render_settings", "ssr_enabled"))
	local selected_option = (ssr_enabled and 2) or 1
	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_ssr = function (self, content, called_from_graphics_quality)
	local value = content.options_values[content.current_selection]
	self.changed_render_settings.ssr_enabled = value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
end
OptionsView.cb_fov_setup = function (self)
	local min = 45
	local max = 120
	local base_fov = CameraSettings.first_person._node.vertical_fov
	local fov = Application.user_setting("render_settings", "fov") or base_fov
	local value = get_slider_value(min, max, fov)
	fov = math.clamp(fov, min, max)
	local fov_multiplier = fov/base_fov
	local camera_manager = Managers.state.camera

	camera_manager.set_fov_multiplier(camera_manager, fov_multiplier)

	local default_value = math.clamp(DefaultUserSettings.get("render_settings", "fov"), min, max)

	return value, min, max, 0, "menu_settings_fov", default_value
end
OptionsView.cb_fov_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local base_fov = CameraSettings.first_person._node.vertical_fov
	local fov = assigned(self.changed_render_settings.fov, Application.user_setting("render_settings", "fov")) or base_fov
	fov = math.clamp(fov, min, max)
	content.internal_value = get_slider_value(min, max, fov)
	content.value = fov

	return 
end
OptionsView.cb_fov = function (self, content)
	self.changed_render_settings.fov = content.value

	return 
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

	return 
end
OptionsView.cb_blood_enabled = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.blood_enabled = value

	return 
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

	return 
end
OptionsView.cb_chat_enabled = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.chat_enabled = value

	return 
end
OptionsView.cb_chat_font_size = function (self, content)
	local options_values = content.options_values
	local current_selection = content.current_selection
	self.changed_user_settings.chat_font_size = options_values[current_selection]

	return 
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

	return selected_option or default_option, options, "menu_settings_chat_font_size", default_option
end
OptionsView.cb_chat_font_size_saved_value = function (self, widget)
	local value = assigned(self.changed_user_settings.chat_font_size, Application.user_setting("chat_font_size")) or DefaultUserSettings.get("user_settings", "chat_font_size")
	local options_values = widget.content.options_values
	local selected_option = 1

	for i = 1, #options_values, 1 do
		if value == options_values[i] then
			selected_option = i

			break
		end
	end

	widget.content.current_selection = selected_option

	return 
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

	return 
end
OptionsView.cb_clan_tag = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.clan_tag = value

	return 
end
OptionsView.cb_blood_decals_setup = function (self)
	local min = 0
	local max = 500
	local num_blood_decals = Application.user_setting("num_blood_decals") or BloodSettings.blood_decals.num_decals
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
	local num_blood_decals = assigned(self.changed_user_settings.num_blood_decals, Application.user_setting("num_blood_decals")) or BloodSettings.blood_decals.num_decals
	num_blood_decals = math.clamp(num_blood_decals, min, max)
	content.internal_value = get_slider_value(min, max, num_blood_decals)
	content.value = num_blood_decals

	return 
end
OptionsView.cb_blood_decals = function (self, content, called_from_graphics_quality)
	self.changed_user_settings.num_blood_decals = content.value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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
	local dynamic_range_sound = Application.user_setting("dynamic_range_sound") or default_value
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
	local dynamic_range_sound = assigned(self.changed_user_settings.dynamic_range_sound, Application.user_setting("dynamic_range_sound")) or "low"
	local selected_option = 1

	if dynamic_range_sound == "high" then
		selected_option = 2
	end

	widget.content.current_selection = selected_option

	return 
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

	self.set_wwise_parameter(self, "dynamic_range_sound", setting)

	return 
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
	local sound_panning_rule = Application.user_setting("sound_panning_rule") or default_value

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
	local sound_panning_rule = assigned(self.changed_user_settings.sound_panning_rule, Application.user_setting("sound_panning_rule")) or "headphones"

	if sound_panning_rule == "headphones" then
		selected_option = 1
	elseif sound_panning_rule == "speakers" then
		selected_option = 2
	end

	widget.content.current_selection = selected_option

	return 
end
OptionsView.cb_sound_panning_rule = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.sound_panning_rule = value

	if value == "headphones" then
		Managers.music:set_panning_rule("PANNING_RULE_HEADPHONES")
	elseif value == "speakers" then
		Managers.music:set_panning_rule("PANNING_RULE_SPEAKERS")
	end

	return 
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

	return 
end
OptionsView.cb_sound_quality = function (self, content)
	local value = content.options_values[content.current_selection]
	self.changed_user_settings.sound_quality = value

	return 
end
OptionsView.cb_animation_lod_distance_setup = function (self)
	local min = 0
	local max = 1
	local animation_lod_distance_multiplier = Application.user_setting("animation_lod_distance_multiplier") or GameSettingsDevelopment.bone_lod_husks.lod_multiplier
	local value = get_slider_value(min, max, animation_lod_distance_multiplier)

	return value, min, max, 1, "menu_settings_animation_lod_multiplier"
end
OptionsView.cb_animation_lod_distance_saved_value = function (self, widget)
	local content = widget.content
	local min = content.min
	local max = content.max
	local animation_lod_distance_multiplier = assigned(self.changed_user_settings.animation_lod_distance_multiplier, Application.user_setting("animation_lod_distance_multiplier")) or GameSettingsDevelopment.bone_lod_husks.lod_multiplier
	animation_lod_distance_multiplier = math.clamp(animation_lod_distance_multiplier, min, max)
	content.internal_value = get_slider_value(min, max, animation_lod_distance_multiplier)
	content.value = animation_lod_distance_multiplier

	return 
end
OptionsView.cb_animation_lod_distance = function (self, content, called_from_graphics_quality)
	self.changed_user_settings.animation_lod_distance_multiplier = content.value

	if not called_from_graphics_quality then
		self.force_set_widget_value(self, "graphics_quality_settings", "custom")
	end

	return 
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

	return 
end
OptionsView.cb_player_outlines = function (self, content)
	local current_selection = content.current_selection
	local options_values = content.options_values
	local value = options_values[current_selection]
	self.changed_user_settings.player_outlines = value

	return 
end

local function get_key_map(keymaps, key)
	local index = 1
	local map = keymaps[key].input_mappings[1]

	if map[1] == "gamepad" then
		index = 2
		map = keymaps[key].input_mappings[2]
	end

	return map, index
end

local function get_button_locale_name(controller_type, button_name)
	local button_locale_name = nil

	if controller_type == "keyboard" then
		local button_index = Keyboard.button_index(button_name)
		button_locale_name = Keyboard.button_locale_name(button_index)
	elseif controller_type == "mouse" then
		button_locale_name = string.format("%s %s", "mouse", button_name)
	end

	fassert(button_locale_name, "No button_locale_name found")

	return button_locale_name
end

OptionsView.cb_keybind_setup = function (self, input_service_name, keys)
	local key_info = {}

	for i, key in ipairs(keys) do
		local map, index = get_key_map(self.keymaps[input_service_name].keymap, key)
		key_info[i] = {
			key = key,
			map = map,
			index = index
		}
	end

	local mapped_key = get_button_locale_name(key_info[1].map[1], key_info[1].map[2])
	local map, index = get_key_map(rawget(_G, self.keymaps[input_service_name].settings_name), keys[1])
	local default_value = {
		controller = map[1],
		key = map[2]
	}

	return mapped_key, key_info, default_value
end
OptionsView.cb_keybind_saved_value = function (self, widget)
	local keys = widget.content.keys
	local input_service_name = widget.content.input_service_name
	local key_info = {}

	for i, key in ipairs(keys) do
		local map, index = get_key_map(self.original_keymaps[input_service_name].keymap, key)
		key_info[i] = {
			key = key,
			map = map,
			index = index
		}
	end

	local controller_type = key_info[1].map[1]
	local mapped_key = key_info[1].map[2]
	widget.content.selected_key = get_button_locale_name(controller_type, mapped_key)
	widget.content.key_info = key_info

	return 
end
OptionsView.cleanup_duplicates = function (self, key, controller, input_service_name)
	local selected_settings_list = self.selected_settings_list
	local widgets = selected_settings_list.widgets
	local widgets_n = selected_settings_list.widgets_n
	local locale_key = get_button_locale_name(controller, key)

	for i = 1, widgets_n, 1 do
		local widget = widgets[i]
		local content = widget.content

		if content.selected_key == locale_key then
			content.callback("delete", "keyboard", content)
		end
	end

	return 
end
OptionsView.cb_keybind_changed = function (self, new_key, controller, content)
	local key_info = content.key_info
	local input_service_name = content.input_service_name

	if new_key == "delete" and controller == "keyboard" then
		new_key = "left button **"
	else
		self.cleanup_duplicates(self, new_key, controller, input_service_name)
	end

	for i, info in ipairs(key_info) do
		local input_mappings = self.keymaps[input_service_name].keymap[info.key].input_mappings[info.index]
		input_mappings[1] = controller
		input_mappings[2] = new_key
	end

	self.changed_keymaps = true
	content.selected_key = get_button_locale_name(controller, new_key)

	return 
end

return 