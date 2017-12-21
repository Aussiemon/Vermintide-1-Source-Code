local definitions = dofile("scripts/ui/altar_view/altar_trait_proc_ui_definitions")
AltarTraitProcUI = class(AltarTraitProcUI)
local drag_colors = {
	normal = Colors.get_color_table_with_alpha("drag_same_slot", 255),
	hover = Colors.get_color_table_with_alpha("drag_same_slot_hover", 255)
}
AltarTraitProcUI.init = function (self, parent, position, animation_definitions, ingame_ui_context)
	self.parent = parent
	self.world = ingame_ui_context.world
	self.player_manager = ingame_ui_context.player_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.traits_list = {}
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.widget_definitions = definitions.widget_definitions
	self.scenegraph_definition = definitions.scenegraph_definition
	self.scenegraph_definition.page_root.position = position
	self.animations = {}

	self.create_ui_elements(self)
	self.clear_item_display_data(self)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, definitions.animations)

	return 
end
AltarTraitProcUI.on_enter = function (self)
	self.remove_item(self)

	return 
end
AltarTraitProcUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled

	return 
end
AltarTraitProcUI.handle_gamepad_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = self.parent:page_input_service()
	local use_gamepad = self.use_gamepad
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	elseif use_gamepad then
		if self.active_item_id then
			local roll_button_widget = self.widgets_by_name.roll_button_widget
			local roll_disabled = roll_button_widget.content.button_hotspot.disabled

			if input_service.get(input_service, "special_1") or input_service.get(input_service, "back", true) then
				self.controller_cooldown = GamepadSettings.menu_cooldown
				self.gamepad_item_remove_request = true
			elseif input_service.get(input_service, "refresh_press") and not roll_disabled and not self.charging and self.is_roll_possible(self) then
				self.start_charge_progress(self)
			elseif self.charging and not input_service.get(input_service, "refresh_hold") then
				self.abort_charge_progress(self)

				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		end

		if not self.charging then
			local number_of_traits_on_item = self.number_of_traits_on_item
			local selected_trait_index = self.selected_trait_index

			if number_of_traits_on_item and selected_trait_index then
				local new_trait_index = nil

				if input_service.get(input_service, "move_right") then
					new_trait_index = math.min(selected_trait_index + 1, number_of_traits_on_item)
					self.controller_cooldown = GamepadSettings.menu_cooldown
				elseif input_service.get(input_service, "move_left") then
					new_trait_index = math.max(selected_trait_index - 1, 1)
					self.controller_cooldown = GamepadSettings.menu_cooldown
				end

				if new_trait_index and new_trait_index ~= selected_trait_index then
					self.gamepad_changed_selected_trait_index = new_trait_index
				end
			end
		end
	end

	return 
end
AltarTraitProcUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.widgets = {}
	self.widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.widgets_definitions) do
		self.widgets_by_name[widget_name] = UIWidget.init(widget_definition)
		self.widgets[#self.widgets + 1] = self.widgets_by_name[widget_name]
	end

	self.widgets_by_name.trait_button_1.content.use_trait_cover = true
	self.widgets_by_name.trait_button_2.content.use_trait_cover = true
	self.widgets_by_name.trait_button_3.content.use_trait_cover = true
	self.widgets_by_name.trait_button_4.content.use_trait_cover = true
	local roll_button_widget = self.widgets_by_name.roll_button_widget
	roll_button_widget.content.enable_charge = true

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self._setup_candle_animations(self)

	return 
end
AltarTraitProcUI._setup_candle_animations = function (self)
	local widgets_by_name = self.widgets_by_name
	local animations = self.animations
	local candle_top_left_widget = widgets_by_name.background_candle_left_top_widget
	local candle_left_widget = widgets_by_name.background_candle_left_widget
	local candle_right_widget = widgets_by_name.background_candle_right_widget
	local candle_glow_left_top_widget = widgets_by_name.candle_glow_left_top_widget
	local candle_glow_left_widget = widgets_by_name.candle_glow_left_widget
	local candle_glow_right_widget = widgets_by_name.candle_glow_right_widget
	animations.candle_top_left_flame = self.animate_element_pulse(self, candle_top_left_widget.style.texture_id.color, 1, 255, 175, 2.3)
	animations.candle_top_left_glow = self.animate_element_pulse(self, candle_glow_left_top_widget.style.texture_id.color, 1, 205, 125, 1.9)
	animations.candle_left_flame = self.animate_element_pulse(self, candle_left_widget.style.texture_id.color, 1, 255, 210, 1)
	animations.candle_left_glow = self.animate_element_pulse(self, candle_glow_left_widget.style.texture_id.color, 1, 205, 160, 1)
	animations.candle_right_flame = self.animate_element_pulse(self, candle_right_widget.style.texture_id.color, 1, 255, 185, 1.5)
	animations.candle_right_glow = self.animate_element_pulse(self, candle_glow_right_widget.style.texture_id.color, 1, 205, 125, 1.5)

	return 
end
AltarTraitProcUI.update_animations = function (self, dt)
	local ui_animator = self.ui_animator

	ui_animator.update(ui_animator, dt)

	if self.current_value_animation_id and ui_animator.is_animation_completed(ui_animator, self.current_value_animation_id) then
		self.current_value_animation_id = nil

		if self.rolling and self.new_rolling_value then
			self.roll(self, self.new_rolling_value)

			self.new_rolling_value = nil
		end
	end

	if self.new_value_animation_id and ui_animator.is_animation_completed(ui_animator, self.new_value_animation_id) then
		self.new_value_animation_id = nil
		self.roll_trait_index = nil
		self.rolling = nil
		self.roll_completed = true

		self.update_selected_trait_description(self)
		self.update_trait_cost_display(self)
	end

	return 
end
AltarTraitProcUI.update = function (self, dt)
	local input_manager = self.input_manager
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	if gamepad_active then
		if not self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = true

			self.on_gamepad_activated(self)
		end
	elseif self.gamepad_active_last_frame then
		self.gamepad_active_last_frame = false

		self.on_gamepad_deactivated(self)
	end

	self.roll_completed = nil

	self.update_animations(self, dt)

	if self.rolling then
		if self.roll_animation then
			UIAnimation.update(self.roll_animation, dt)
		end
	else
		self.handle_gamepad_input(self, dt)
	end

	for name, animation in pairs(self.animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.animations[name] = nil

			self.on_charge_animations_complete(self, name)
		end
	end

	self.item_remove_request = nil
	self.pressed_item_backend_id = nil
	local widget = self.widgets_by_name.item_button_widget
	local item_slot_button_hotspot = widget.content.button_hotspot

	if item_slot_button_hotspot.on_hover_enter and not self.rolling then
		if self.active_item_id then
			self.play_sound(self, "Play_hud_hover")
		end

		local bar_settings = UISettings.inventory.button_bars
		local fade_in_time = bar_settings.background.fade_in_time
		local alpha_hover = bar_settings.background.alpha_hover
		local widget_hover_color = widget.style.hover_texture.color
		self.animations.item_slot_hover = self.animate_element_by_time(self, widget_hover_color, 1, widget_hover_color[1], alpha_hover, fade_in_time)
	elseif item_slot_button_hotspot.on_hover_exit then
		local bar_settings = UISettings.inventory.button_bars
		local fade_out_time = bar_settings.background.fade_out_time
		local widget_hover_color = widget.style.hover_texture.color
		self.animations.item_slot_hover = self.animate_element_by_time(self, widget_hover_color, 1, widget_hover_color[1], 0, fade_out_time)
	end

	if not self.rolling then
		if item_slot_button_hotspot.on_double_click or item_slot_button_hotspot.on_right_click or self.gamepad_item_remove_request then
			if widget.content.icon_texture_id then
				self.item_remove_request = true
			end
		elseif item_slot_button_hotspot.on_pressed then
			self.pressed_item_backend_id = self.active_item_id
		end
	end

	self.gamepad_item_remove_request = nil
	self.roll_request = nil
	local roll_button_widget = self.widgets_by_name.roll_button_widget
	local roll_button_content = roll_button_widget.content
	local roll_button_hotspot = roll_button_content.button_hotspot

	if roll_button_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if not self.rolling and (roll_button_hotspot.on_release or self.gamepad_roll_request) then
		roll_button_hotspot.on_release = nil

		if self.can_afford_roll_cost(self) then
			self.roll_trait_index = self.selected_trait_index
			self.roll_request = true
		else
			self.roll_failed(self)
		end
	end

	self.gamepad_roll_request = nil
	local num_traits = AltarSettings.num_traits
	local current_traits_data = self.current_traits_data

	if current_traits_data then
		for i = 1, num_traits, 1 do
			local widget_name = "trait_button_" .. i
			local widget = self.widgets_by_name[widget_name]
			local button_hotspot = widget.content.button_hotspot

			if button_hotspot.on_hover_enter and not button_hotspot.is_selected and current_traits_data[i] then
				self.play_sound(self, "Play_hud_hover")
			end
		end
	end

	for i = 1, num_traits, 1 do
		local widget_name = "trait_button_" .. i
		local widget = self.widgets_by_name[widget_name]
		local button_hotspot = widget.content.button_hotspot

		if not button_hotspot.disabled and (button_hotspot.on_pressed or self.gamepad_changed_selected_trait_index == i) and not button_hotspot.is_selected and i ~= self.selected_trait_index then
			self.play_sound(self, "Play_hud_select")
			self.set_selected_trait(self, i)

			widget.content.button_hotspot.on_pressed = nil

			break
		end
	end

	self.gamepad_changed_selected_trait_index = nil

	self.on_item_dragged(self)

	if self.is_dragging_started(self) then
		self.play_sound(self, "Play_hud_inventory_pickup_item")
	end

	return 
end
AltarTraitProcUI.is_dragging_started = function (self)
	local widget = self.widgets_by_name.item_button_widget

	return widget.content.on_drag_started
end
AltarTraitProcUI.on_item_hover_enter = function (self)
	local widget = self.widgets_by_name.item_button_widget

	if widget.content.button_hotspot.on_hover_enter then
		return 0, self.active_item_id
	end

	return 
end
AltarTraitProcUI.on_item_hover_exit = function (self)
	local widget = self.widgets_by_name.item_button_widget

	if widget.content.button_hotspot.on_hover_exit then
		return 0, self.active_item_id
	end

	return 
end
AltarTraitProcUI.is_slot_hovered = function (self, is_dragging_item)
	local widget = self.widgets_by_name.item_button_widget
	local internal_is_hover = widget.content.button_hotspot.internal_is_hover
	local style = widget.style.drag_select_frame

	if is_dragging_item then
		if internal_is_hover then
			style.color = drag_colors.hover
			style.color[1] = 255
		else
			style.color = drag_colors.normal
			style.color[1] = 255
		end
	else
		style.color[1] = 0
	end

	return internal_is_hover
end
AltarTraitProcUI.on_dragging_item_stopped = function (self)
	local active_item_id = self.active_item_id

	if active_item_id then
		local widget = self.widgets_by_name.item_button_widget

		if widget.content.on_drag_stopped then
			return active_item_id
		end
	end

	return 
end
AltarTraitProcUI.on_item_dragged = function (self)
	local widget = self.widgets_by_name.item_button_widget
	local content = widget.content
	local icon_color = widget.style.icon_texture_id.color

	if content.is_dragging and icon_color[1] ~= 150 then
		icon_color[1] = 150
	elseif content.on_drag_stopped and icon_color[1] ~= 255 then
		icon_color[1] = 255
	end

	return 
end
AltarTraitProcUI.can_select_trait = function (self, trait_name)
	local active_item_id = self.active_item_id

	if not active_item_id or not trait_name then
		return false
	end

	local proc_chance_data = self.get_trait_proc_data(self, active_item_id, trait_name)

	return (proc_chance_data and true) or false
end
AltarTraitProcUI.update_selected_trait_description = function (self)
	local selected_index = self.selected_trait_index
	local description_text = BackendUtils.get_item_trait_description(self.active_item_id, selected_index)
	local current_traits_data = self.current_traits_data
	local trait_display_data = current_traits_data[selected_index]
	trait_display_data.description_text = description_text
	local description_widget = self.widgets_by_name.text_frame_description
	local trait_locked_text = Localize("tooltip_trait_locked")

	if trait_display_data.locked then
		description_text = description_text .. "\n" .. trait_locked_text
		description_widget.style.text.last_line_color = Colors.get_color_table_with_alpha("red", 255)
	else
		description_widget.style.text.last_line_color = nil
	end

	description_widget.content.text = description_text

	return 
end
AltarTraitProcUI.set_selected_trait = function (self, selected_index)
	local widget = self.widgets_by_name.roll_button_widget

	if self.charging or widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	local num_traits = AltarSettings.num_traits
	local widgets_by_name = self.widgets_by_name
	local trait_locked_text = Localize("tooltip_trait_locked")

	for i = 1, num_traits, 1 do
		local widget_name = "trait_button_" .. i
		local widget = widgets_by_name[widget_name]
		widget.content.button_hotspot.is_selected = i == selected_index
	end

	local current_traits_data = self.current_traits_data
	local trait_display_data = current_traits_data[selected_index]

	if trait_display_data then
		local title_widget = widgets_by_name.text_frame_title
		title_widget.content.text = trait_display_data.display_name
		title_widget.content.visible = true
		local description_widget = widgets_by_name.text_frame_description
		local description_text = trait_display_data.description_text

		if trait_display_data.locked then
			description_text = description_text .. "\n" .. trait_locked_text
			description_widget.style.text.last_line_color = Colors.get_color_table_with_alpha("red", 255)
		else
			description_widget.style.text.last_line_color = nil
		end

		description_widget.content.text = description_text
		description_widget.content.visible = true
		local trait_name = trait_display_data.trait_name
		self.selected_trait_name = trait_name
		self.selected_trait_widget_name = "trait_button_" .. selected_index
	else
		self.selected_trait_name = nil
		self.selected_trait_widget_name = nil
	end

	if selected_index then
		self.update_slider_by_trait(self, self.active_item_id, self.selected_trait_name)
	end

	local roll_button_widget = widgets_by_name.roll_button_widget
	roll_button_widget.content.default_text_on_disable = selected_index ~= nil
	self.selected_trait_index = selected_index

	self.update_trait_cost_display(self)

	return 
end
AltarTraitProcUI.get_trait_proc_data = function (self, backend_id, trait_name)
	local buff_key = "proc_chance"
	local trait_template = BuffTemplates[trait_name]
	local buff_data = trait_template.buffs
	local proc_chance_data = buff_data and buff_data[1][buff_key]

	return proc_chance_data
end
AltarTraitProcUI.update_slider_by_trait = function (self, backend_id, trait_name)
	if self.current_value_animation_id then
		self.ui_animator:stop_animation(self.current_value_animation_id)

		self.current_value_animation_id = nil
	end

	if self.min_max_value_animation_id then
		self.ui_animator:stop_animation(self.min_max_value_animation_id)

		self.min_max_value_animation_id = nil
	end

	local widget = self.widgets_by_name.slider_widget
	local widget_content = widget.content
	local draw_widget = false
	local proc_chance_data = self.get_trait_proc_data(self, backend_id, trait_name)
	local proc_data = {}

	if proc_chance_data then
		local formatting = "%.1f"
		local multiplier = 100
		local min_value = proc_chance_data[1]
		local max_value = proc_chance_data[2]
		local min_display_text = string.format(formatting, min_value*multiplier)
		local max_display_text = string.format(formatting, max_value*multiplier)
		local trait_info = nil
		local unlocked_traits = ScriptBackendItem.get_traits(backend_id)

		for _, trait_data in pairs(unlocked_traits) do
			if trait_name == trait_data.trait_name then
				trait_info = trait_data
			end
		end

		local buff_key = "proc_chance"
		local value = (trait_info and trait_info[buff_key]) or min_value
		local progress = (value - min_value)/(max_value - min_value)
		proc_data.progress = progress
		proc_data.min_value = min_value
		proc_data.max_value = max_value
		proc_data.current_value = value
		draw_widget = true
		local line_length = self.scenegraph_definition.proc_slider_bar.size[1]
		local current_box_position = self.ui_scenegraph.proc_slider_current_box.local_position
		local length_diff = math.abs(current_box_position[1] - progress*line_length)

		if 0 < length_diff then
			local length_diff_fraction = length_diff/line_length
			local speed = length_diff_fraction - 1 + 1
			self.current_value_animation_id = self.animate_current_value(self, "current_value", value, min_value, max_value, speed)
		else
			self.current_value_animation_id = self.animate_current_value(self, "change_box_values_only", value, min_value, max_value)
		end

		min_display_text = min_display_text .. "%"
		max_display_text = max_display_text .. "%"
		self.min_max_value_animation_id = self.animate_min_max_change(self, min_display_text, max_display_text)
	end

	self.selected_proc_data = proc_data
	widget_content.visible = true

	return 
end
AltarTraitProcUI.animate_min_max_change = function (self, min_display_text, max_display_text)
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.slider_widget
	local params = {
		min_display_text = min_display_text,
		max_display_text = max_display_text,
		wwise_world = self.wwise_world
	}
	local animation_name = "min_max_value_change"

	return self.ui_animator:start_animation(animation_name, widgets_by_name, self.scenegraph_definition, params)
end
AltarTraitProcUI.animate_current_value = function (self, animation_name, current_value, min, max, time_multiplier)
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.slider_widget
	local progress = (current_value - min)/(max - min)
	local params = {
		multiplier = 100,
		formatting = "%.1f",
		min_value = min,
		max_value = max,
		current_value = current_value,
		end_progress = progress,
		wwise_world = self.wwise_world
	}

	return self.ui_animator:start_animation(animation_name, widgets_by_name, self.scenegraph_definition, params, time_multiplier)
end
AltarTraitProcUI.animate_new_value = function (self, new_value, current_value, min, max, time_multiplier)
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.slider_widget
	local progress = (new_value - min)/(max - min)
	local params = {
		formatting = "%.1f",
		multiplier = 100,
		min_value = min,
		max_value = max,
		new_value = new_value,
		current_value = current_value,
		end_progress = progress,
		wwise_world = self.wwise_world
	}
	local animation_name = (current_value <= new_value and "new_value_better") or "new_value"

	return self.ui_animator:start_animation(animation_name, widgets_by_name, self.scenegraph_definition, params, time_multiplier)
end
AltarTraitProcUI.clear_item_display_data = function (self)
	local widgets_by_name = self.widgets_by_name
	local num_traits = AltarSettings.num_traits

	for i = 1, num_traits, 1 do
		local widget_name = "trait_button_" .. i
		local trait_widget = widgets_by_name[widget_name]
		local trait_widget_hotspot = trait_widget.content.button_hotspot
		trait_widget.content.texture_id = nil
		trait_widget_hotspot.disabled = true
		trait_widget_hotspot.locked = true
	end

	local title_widget = widgets_by_name.text_frame_title
	title_widget.content.text = ""
	title_widget.content.visible = false
	local description_widget = widgets_by_name.text_frame_description
	description_widget.content.text = ""
	description_widget.content.visible = false

	self.set_description_text(self, "dlc1_1_roll_proc_description_1")
	self.set_roll_button_disabled(self, true)

	local ui_scenegraph = self.ui_scenegraph
	local slider_widget = self.widgets_by_name.slider_widget
	slider_widget.content.bar_content.uvs[2][1] = 0
	slider_widget.content.new_proc_text = "?"
	ui_scenegraph.proc_slider_bar.size[1] = 0
	ui_scenegraph.proc_slider_new_box.local_position[1] = 0

	self.update_trait_alignment(self, num_traits - 1)

	local slider_widget = widgets_by_name.slider_widget
	local slider_widget_content = slider_widget.content
	slider_widget_content.min_text = ""
	slider_widget_content.max_text = ""
	slider_widget_content.new_proc_text = ""
	slider_widget_content.current_proc_text = ""
	ui_scenegraph.proc_slider_new_box.local_position[1] = 0
	ui_scenegraph.proc_slider_current_box.local_position[1] = 0

	return 
end
AltarTraitProcUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.parent:page_input_service()

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	local num_widgets = #self.widgets

	for i = 1, num_widgets, 1 do
		local widget = self.widgets[i]

		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
AltarTraitProcUI.set_roll_button_disabled = function (self, disabled)
	local widgets_by_name = self.widgets_by_name
	local roll_button_widget = widgets_by_name.roll_button_widget
	roll_button_widget.content.button_hotspot.disabled = disabled
	roll_button_widget.content.show_title = disabled
	roll_button_widget.content.show_glow = not disabled

	return 
end
AltarTraitProcUI.is_roll_possible = function (self)
	local widgets_by_name = self.widgets_by_name
	local roll_button_widget = widgets_by_name.roll_button_widget

	return not roll_button_widget.content.button_hotspot.disabled
end
AltarTraitProcUI.set_description_text = function (self, text)
	local widgets_by_name = self.widgets_by_name
	local description_widget = widgets_by_name.description_text_1
	description_widget.content.text = text

	return 
end
AltarTraitProcUI.add_item = function (self, backend_item_id, is_equipped)
	local roll_button_widget = self.widgets_by_name.roll_button_widget

	if self.charging or roll_button_widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	self.clear_item_display_data(self)
	self.play_sound(self, "Play_hud_inventory_drop_item")

	local item_data = BackendUtils.get_item_from_masterlist(backend_item_id)
	local icon_texture = item_data.inventory_icon
	local rarity = item_data.rarity
	local num_owned_traits = 0
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.item_button_widget
	widget.content.icon_texture_id = icon_texture
	widget.style.icon_frame_texture_id.color = Colors.get_table(rarity)
	self.active_item_id = backend_item_id
	self.active_item_is_equipped = is_equipped
	self.active_item_data = item_data
	local traits = item_data.traits
	local num_traits = AltarSettings.num_traits
	local current_traits_data = {}
	local can_unlock_traits_on_this_item = false
	local number_of_traits_on_item = 0
	local trait_index_with_proc_data, trait_index_with_unlock = nil

	for i = 1, num_traits, 1 do
		local trait_name = traits and traits[i]
		local widget_name = "trait_button_" .. i
		local trait_widget = widgets_by_name[widget_name]
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = not self.can_select_trait(self, trait_name)

		if trait_name then
			local trait_template = BuffTemplates[trait_name]
			local item_has_trait = BackendUtils.item_has_trait(backend_item_id, trait_name)

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local description_text = BackendUtils.get_item_trait_description(backend_item_id, i)
				local icon = trait_template.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_hotspot.is_selected = false
				trait_widget_hotspot.on_pressed = false
				current_traits_data[i] = {
					trait_name = trait_name,
					display_name = display_name,
					description_text = description_text,
					icon = icon or "trait_icon_empty",
					locked = not item_has_trait
				}
			end

			trait_widget_hotspot.locked = not item_has_trait
			trait_widget.style.texture_lock_id.color[1] = 255

			if not trait_index_with_proc_data and self.get_trait_proc_data(self, backend_item_id, trait_name) then
				trait_index_with_proc_data = i
			elseif not trait_index_with_unlock and item_has_trait then
				trait_index_with_unlock = i
			end

			if item_has_trait and not trait_index_with_proc_data then
			else
				num_owned_traits = num_owned_traits + 1
			end

			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	self.current_traits_data = current_traits_data
	self.number_of_owned_traits = num_owned_traits

	if 0 < number_of_traits_on_item then
		self.set_roll_button_disabled(self, false)
	end

	self.number_of_traits_on_item = number_of_traits_on_item

	self.update_trait_alignment(self, number_of_traits_on_item)

	local new_trait_selection_index = trait_index_with_proc_data or trait_index_with_unlock

	self.set_selected_trait(self, new_trait_selection_index)

	return 
end
AltarTraitProcUI.update_trait_alignment = function (self, number_of_traits)
	local ui_scenegraph = self.ui_scenegraph
	local width = 40
	local spacing = 80
	local half_trait_amount = (number_of_traits - 1)*0.5
	local start_x_position = -((width + spacing)*half_trait_amount)

	for i = 1, number_of_traits, 1 do
		local widget_name = "trait_button_" .. i
		local position = ui_scenegraph[widget_name].local_position
		position[1] = start_x_position
		start_x_position = start_x_position + width + spacing
	end

	local widgets_by_name = self.widgets_by_name
	local num_total_traits = AltarSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local widget_name = "trait_button_" .. i
		local widget = widgets_by_name[widget_name]
		widget.content.visible = (i <= number_of_traits and true) or false
	end

	return 
end
AltarTraitProcUI.is_selected_trait_unlocked = function (self)
	local active_item_id = self.active_item_id
	local selected_trait_index = self.selected_trait_index

	if active_item_id and selected_trait_index then
		local current_traits_data = self.current_traits_data
		local trait_display_data = current_traits_data[selected_trait_index]
		local trait_name = trait_display_data.trait_name

		return BackendUtils.item_has_trait(active_item_id, trait_name)
	end

	return 
end
AltarTraitProcUI.update_trait_cost_display = function (self, force_disable_button)
	local roll_button_widget = self.widgets_by_name.roll_button_widget
	local selected_trait_unlocked = self.is_selected_trait_unlocked(self)
	local selected_proc_data = self.selected_proc_data
	local has_selected_trait_max_proc_chance = selected_proc_data and selected_proc_data.current_value == selected_proc_data.max_value
	local can_afford = self.can_afford_roll_cost(self)
	local token_type, traits_cost, texture = self.get_roll_cost(self)

	if token_type then
		roll_button_widget.content.texture_token_type = texture
		roll_button_widget.content.token_text = traits_cost .. " x"
	else
		roll_button_widget.content.texture_token_type = nil
		roll_button_widget.content.token_text = ""
	end

	roll_button_widget.content.text_field = Localize("altar_screen_reroll_proc_tooltip")

	if force_disable_button ~= nil then
		can_afford = not force_disable_button
	end

	local button_enabled = selected_trait_unlocked and can_afford and not has_selected_trait_max_proc_chance

	self.set_roll_button_disabled(self, not button_enabled)

	roll_button_widget.content.button_hotspot.is_selected = false
	roll_button_widget.content.button_hotspot.is_hover = false
	local show_centered_text = selected_trait_unlocked and not has_selected_trait_max_proc_chance
	roll_button_widget.content.default_text_on_disable = show_centered_text

	if can_afford then
		roll_button_widget.style.token_text_selected.text_color = Colors.get_table("cheeseburger", 255)
		roll_button_widget.style.token_text.text_color = Colors.get_table("cheeseburger", 255)
		roll_button_widget.style.text_selected.text_color = Colors.get_table("cheeseburger", 255)
		roll_button_widget.style.text.text_color = Colors.get_table("cheeseburger", 255)
	else
		roll_button_widget.style.token_text_selected.text_color = Colors.get_table("red", 255)
		roll_button_widget.style.token_text.text_color = Colors.get_table("red", 255)
		roll_button_widget.style.text_selected.text_color = Colors.get_table("red", 255)
		roll_button_widget.style.text.text_color = Colors.get_table("red", 255)
	end

	if self.active_item_id then
		if selected_trait_unlocked then
			if has_selected_trait_max_proc_chance then
				self.set_description_text(self, "dlc1_1_roll_proc_description_4")
			else
				self.set_description_text(self, "dlc1_1_roll_proc_description_2")
			end
		else
			self.set_description_text(self, "dlc1_1_roll_proc_description_3")
		end
	else
		self.set_description_text(self, "dlc1_1_roll_proc_description_1")
	end

	return 
end
AltarTraitProcUI.get_item_roll_info = function (self)
	return self.active_item_id, self.selected_trait_name
end
AltarTraitProcUI.get_roll_cost = function (self)
	local item_data = self.active_item_data

	if item_data then
		local rarity = item_data.rarity
		local proc_reroll_trait = AltarSettings.proc_reroll_trait
		local rarity_settings = proc_reroll_trait[rarity]
		local token_type = rarity_settings.token_type
		local traits_cost = rarity_settings.cost
		local texture = rarity_settings.token_texture

		return token_type, traits_cost, texture
	end

	return 
end
AltarTraitProcUI.can_afford_roll_cost = function (self)
	local token_type, traits_cost = self.get_roll_cost(self)

	if traits_cost then
		local num_tokens_owned = BackendUtils.get_tokens(token_type)

		return traits_cost <= num_tokens_owned
	end

	return 
end
AltarTraitProcUI.refresh = function (self)
	local selected_index = self.selected_trait_index

	self.set_selected_trait(self, selected_index)

	return 
end
AltarTraitProcUI.can_remove_item = function (self)
	return self.active_item_id
end
AltarTraitProcUI.remove_item = function (self)
	local roll_button_widget = self.widgets_by_name.roll_button_widget

	if self.charging or roll_button_widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	if self.current_value_animation_id then
		self.ui_animator:stop_animation(self.current_value_animation_id)

		self.current_value_animation_id = nil
	end

	if self.min_max_value_animation_id then
		self.ui_animator:stop_animation(self.min_max_value_animation_id)

		self.min_max_value_animation_id = nil
	end

	if self.new_value_animation_id then
		self.ui_animator:stop_animation(self.new_value_animation_id)

		self.new_value_animation_id = nil
	end

	self.number_of_traits_on_item = nil
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.item_button_widget
	widget.content.icon_texture_id = nil
	local widget_hotspot = widget.content.button_hotspot

	if widget_hotspot.is_hover then
		widget_hotspot.on_hover_exit = true
	end

	if self.active_item_id then
		self.play_sound(self, "Play_hud_forge_item_remove")
	end

	self.active_item_id = nil
	self.active_item_is_equipped = nil
	self.active_item_data = nil
	self.selected_trait_name = nil
	local roll_button_widget = widgets_by_name.roll_button_widget

	self.clear_item_display_data(self)

	local roll_button_widget = widgets_by_name.roll_button_widget
	roll_button_widget.content.default_text_on_disable = false

	return 
end
AltarTraitProcUI.roll = function (self, new_value)
	self.rolling = true
	local roll_button_widget = self.widgets_by_name.roll_button_widget
	roll_button_widget.content.default_text_on_disable = false

	self.set_roll_button_disabled(self, true)

	if not self.current_value_animation_id then
		local formatting = "%.1f"
		local multiplier = 100
		local selected_proc_data = self.selected_proc_data
		local min_value = selected_proc_data.min_value
		local max_value = selected_proc_data.max_value
		local current_value = selected_proc_data.current_value
		local progress = (new_value - min_value)/(max_value - min_value)
		local speed = progress - 1 + 1
		self.new_value_animation_id = self.animate_new_value(self, new_value, current_value, min_value, max_value, speed)
		local improved_value_last_roll = current_value < new_value

		if improved_value_last_roll then
			self.selected_proc_data.current_value = new_value
		end

		self.improved_value_last_roll = improved_value_last_roll
	else
		self.new_rolling_value = new_value
	end

	return 
end
AltarTraitProcUI.roll_failed = function (self)
	self.roll_trait_index = nil

	return 
end
AltarTraitProcUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
AltarTraitProcUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end
AltarTraitProcUI.animate_element_pulse = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.pulse_animation, target, target_index, from, to, time)

	return new_animation
end
AltarTraitProcUI.start_charge_progress = function (self)
	self.charging = true
	local animation_name = "gamepad_charge_progress"
	local animation_time = 1.5
	local from = 0
	local to = 307
	local widget = self.widgets_by_name.roll_button_widget
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, self.ui_scenegraph.roll_button_fill.size, 1, from, to, animation_time, math.ease_out_quad)
	self.animations[animation_name .. "_uv"] = UIAnimation.init(UIAnimation.function_by_time, widget.content.progress_fill.uvs[2], 1, 0, 1, animation_time, math.ease_out_quad)

	self.cancel_abort_animation(self)

	widget.content.charging = true
	widget.style.progress_fill.color[1] = 255

	self.play_sound(self, "Play_hud_reroll_traits_charge")

	return 
end
AltarTraitProcUI.abort_charge_progress = function (self, force_shutdown)
	local animation_name = "gamepad_charge_progress"
	self.animations[animation_name] = nil
	self.animations[animation_name .. "_uv"] = nil
	self.charging = nil
	self.ui_scenegraph.roll_button_fill.size[1] = 0

	self.play_sound(self, "Stop_hud_reroll_traits_charge")

	if force_shutdown then
		self.cancel_abort_animation(self)
	else
		self.start_abort_animation(self)
	end

	return 
end
AltarTraitProcUI.on_charge_complete = function (self)
	self.charging = nil
	self.gamepad_roll_request = true
	local widget = self.widgets_by_name.roll_button_widget
	widget.content.charging = false
	local animation_name = "progress_bar_complete"
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 0, 255, 0.2, math.easeCubic, UIAnimation.function_by_time, self.ui_scenegraph.roll_button_fill.size, 1, 0, 0, 0.01, math.easeCubic, UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 255, 0, 0.2, math.easeOutCubic)
	self.animations[animation_name .. "2"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.token_text.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "3"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.texture_token_type.color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "4"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.text.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "5"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.text_disabled.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	widget.style.text.text_color[1] = 0
	widget.style.token_text.text_color[1] = 0
	widget.style.text_disabled.text_color[1] = 0
	widget.style.texture_token_type.color[1] = 0

	self.play_sound(self, "Stop_hud_reroll_traits_charge")

	return 
end
AltarTraitProcUI.start_abort_animation = function (self)
	local animation_name = "gamepad_charge_progress_abort"
	local from = 0
	local to = 255
	local widget = self.widgets_by_name.roll_button_widget
	widget.content.show_cancel_text = true
	widget.content.charging = false
	widget.style.progress_fill.color[1] = 0
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, from, to, 0.2, math.easeInCubic, UIAnimation.wait, 0.3, UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, to, from, 0.3, math.easeInCubic)
	self.animations[animation_name .. "2"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.token_text.text_color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "3"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.texture_token_type.color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "4"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.text.text_color, 1, from, to, 0.3, math.easeInCubic)

	return 
end
AltarTraitProcUI.cancel_abort_animation = function (self)
	local animations = self.animations
	animations.gamepad_charge_progress_abort = nil
	animations.progress_bar_complete = nil

	for i = 2, 4, 1 do
		animations["gamepad_charge_progress_abort" .. i] = nil
	end

	for i = 2, 5, 1 do
		animations["progress_bar_complete" .. i] = nil
	end

	local widget = self.widgets_by_name.roll_button_widget
	widget.content.charging = false
	widget.content.show_cancel_text = false
	widget.style.progress_fill.color[1] = 0
	widget.style.text_charge_cancelled.text_color[1] = 0
	widget.style.texture_token_type.color[1] = 255
	widget.style.token_text.text_color[1] = 255
	widget.style.text_disabled.text_color[1] = 255
	widget.style.text.text_color[1] = 255

	return 
end
AltarTraitProcUI.on_charge_animations_complete = function (self, animation_name)
	if animation_name == "gamepad_charge_progress" then
		self.on_charge_complete(self)
	end

	if animation_name == "gamepad_charge_progress_abort" then
		local widget = self.widgets_by_name.roll_button_widget
		widget.content.show_cancel_text = false
	end

	return 
end
AltarTraitProcUI.on_gamepad_activated = function (self)
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "enchantment_view")
	local button_texture_data = UISettings.get_gamepad_input_texture_data(input_service, "refresh", true)
	local button_texture = button_texture_data.texture
	local button_size = button_texture_data.size
	local widget = self.widgets_by_name.roll_button_widget
	widget.content.progress_input_icon = button_texture

	return 
end
AltarTraitProcUI.on_gamepad_deactivated = function (self)
	return 
end
AltarTraitProcUI.set_active = function (self, active)
	self.active = active
	local widget = self.widgets_by_name.roll_button_widget

	if self.charging or widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	return 
end

return 
