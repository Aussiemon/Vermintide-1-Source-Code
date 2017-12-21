local definitions = dofile("scripts/ui/altar_view/altar_trait_roll_ui_definitions")
AltarTraitRollUI = class(AltarTraitRollUI)
local drag_colors = {
	normal = Colors.get_color_table_with_alpha("drag_same_slot", 255),
	hover = Colors.get_color_table_with_alpha("drag_same_slot_hover", 255)
}
AltarTraitRollUI.init = function (self, parent, position, animation_definitions, ingame_ui_context)
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
	self.total_rotation_animation_time = 0.5

	self.create_ui_elements(self)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, definitions.animations)

	self._clear_item_display_data(self)

	return 
end
AltarTraitRollUI.on_enter = function (self)
	self.remove_item(self)

	return 
end
AltarTraitRollUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled

	return 
end
AltarTraitRollUI._handle_gamepad_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = self.parent:page_input_service()
	local use_gamepad = self.use_gamepad
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	elseif use_gamepad then
		if self.active_item_id then
			if (input_service.get(input_service, "back", true) or input_service.get(input_service, "special_1")) and self.can_remove_item(self) then
				self.controller_cooldown = GamepadSettings.menu_cooldown
				self.gamepad_item_remove_request = true
			elseif input_service.get(input_service, "refresh_press") and not self.charging and self.can_afford_reroll_cost(self) then
				self.start_charge_progress(self)
			elseif self.charging and not input_service.get(input_service, "refresh_hold") then
				self.abort_charge_progress(self)

				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		end

		if self.handling_reroll_answer and not self.charging then
			local trait_window_selection_index = self.trait_window_selection_index

			if trait_window_selection_index then
				local new_trait_setup_selection_index = nil

				if input_service.get(input_service, "move_right") then
					new_trait_setup_selection_index = math.min(trait_window_selection_index + 1, 2)
				elseif input_service.get(input_service, "move_left") then
					new_trait_setup_selection_index = math.max(trait_window_selection_index - 1, 1)
				end

				if new_trait_setup_selection_index and new_trait_setup_selection_index ~= trait_window_selection_index then
					if trait_window_selection_index == 1 then
						self._on_preview_window_1_button_hover_exit(self)
					elseif trait_window_selection_index == 2 then
						self._on_preview_window_2_button_hover_exit(self)
					end

					if new_trait_setup_selection_index == 1 then
						self._on_preview_window_1_button_hovered(self)
					elseif new_trait_setup_selection_index == 2 then
						self._on_preview_window_2_button_hovered(self)
					end

					self.controller_cooldown = GamepadSettings.menu_cooldown
				elseif input_service.get(input_service, "confirm") then
					local preview_window_button_hotspot = self.widgets_by_name["preview_window_" .. trait_window_selection_index .. "_button"].content.button_hotspot
					preview_window_button_hotspot.on_release = true
					self.controller_cooldown = GamepadSettings.menu_cooldown
				end
			end
		else
			local number_of_traits_on_item = self.number_of_traits_on_item
			local selected_trait_index = self.selected_trait_index

			if number_of_traits_on_item and selected_trait_index then
				local new_trait_index = nil

				if input_service.get(input_service, "move_right") then
					new_trait_index = math.min(selected_trait_index + 1, number_of_traits_on_item)
				elseif input_service.get(input_service, "move_left") then
					new_trait_index = math.max(selected_trait_index - 1, 1)
				end

				if new_trait_index and new_trait_index ~= selected_trait_index then
					self.gamepad_changed_selected_trait_index = new_trait_index
					self.controller_cooldown = GamepadSettings.menu_cooldown
				end
			end
		end
	end

	return 
end
AltarTraitRollUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.trait_preview_widgets = {}
	local trait_preview_widgets_by_name = {}
	local traits_preview_definitions = definitions.traits_preview_definitions

	for i = 1, 8, 1 do
		local widget_name = "trait_preview_" .. i
		local trait_widget_definition = traits_preview_definitions[widget_name]
		trait_preview_widgets_by_name[widget_name] = UIWidget.init(trait_widget_definition)
		self.trait_preview_widgets[#self.trait_preview_widgets + 1] = trait_preview_widgets_by_name[widget_name]
	end

	self.trait_preview_widgets_by_name = trait_preview_widgets_by_name
	self.widgets = {}
	local widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.widgets_definitions) do
		widgets_by_name[widget_name] = UIWidget.init(widget_definition)
		self.widgets[#self.widgets + 1] = widgets_by_name[widget_name]
	end

	self.widgets_by_name = widgets_by_name
	local reroll_button_widget = widgets_by_name.reroll_button_widget
	reroll_button_widget.content.text_field = Localize("reroll")
	reroll_button_widget.default_text_on_disable = false
	reroll_button_widget.content.enable_charge = true
	local rotating_disk_glow_widget = self.widgets_by_name.rotating_disk_glow_widget
	rotating_disk_glow_widget.style.texture_id.color[1] = 0
	local preview_window_1_button_content = widgets_by_name.preview_window_1_button.content
	local preview_window_2_button_content = widgets_by_name.preview_window_2_button.content
	preview_window_1_button_content.show_frame = false
	preview_window_2_button_content.show_frame = false
	preview_window_1_button_content.default_text_on_disable = false
	preview_window_2_button_content.default_text_on_disable = false
	self.ui_scenegraph.expand_frame_background.size[1] = 0

	self._set_option_buttons_visibility(self, false)
	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self._setup_candle_animations(self)

	return 
end
AltarTraitRollUI._setup_candle_animations = function (self)
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
AltarTraitRollUI._update_animations = function (self, dt)
	local ui_animator = self.ui_animator

	ui_animator.update(ui_animator, dt)

	self.trait_options_presentation_complete = nil

	if (self.preview_window_open_anim_id and ui_animator.is_animation_completed(ui_animator, self.preview_window_open_anim_id)) or (self.fade_in_preview_window_new_traits_anim_id and ui_animator.is_animation_completed(ui_animator, self.fade_in_preview_window_new_traits_anim_id)) then
		self.preview_window_open_anim_id = nil
		self.fade_in_preview_window_new_traits_anim_id = nil

		self._update_trait_cost_display(self)
		self._on_trait_options_presentation_complete(self)
	elseif self.preview_window_close_anim_id and ui_animator.is_animation_completed(ui_animator, self.preview_window_close_anim_id) then
		self.preview_window_close_anim_id = nil

		self._on_reroll_completed(self)
	elseif self.fade_out_preview_window_new_traits_anim_id and ui_animator.is_animation_completed(ui_animator, self.fade_out_preview_window_new_traits_anim_id) then
		self.fade_out_preview_window_new_traits_anim_id = nil
		local new_item_key = self.new_item_key
		local new_item_data = ItemMasterList[new_item_key]
		local new_item_traits = new_item_data.traits
		local new_item_rarity = new_item_data.rarity

		self._set_new_traits(self, new_item_traits, new_item_rarity)
		self._start_traits_reroll_animation(self)

		self.fade_in_preview_window_new_traits_anim_id = self._animate_preview_window(self, "fade_in_preview_window_2_traits")
	end

	return 
end
AltarTraitRollUI.update = function (self, dt)
	local gamepad_active = self.input_manager:is_device_active("gamepad")

	if gamepad_active then
		if not self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = true

			self.on_gamepad_activated(self)
		end
	elseif self.gamepad_active_last_frame then
		self.gamepad_active_last_frame = false

		self.on_gamepad_deactivated(self)
	end

	if gamepad_active then
		if self.handling_reroll_answer and not self.fade_out_preview_window_new_traits_anim_id and not self.fade_in_preview_window_new_traits_anim_id then
			local trait_window_selection_index = self.trait_window_selection_index

			if not trait_window_selection_index then
				self._on_preview_window_1_button_hovered(self)
			elseif trait_window_selection_index == 1 and not self.window_1_corner_glow_anim_id then
				self._on_preview_window_1_button_hovered(self)
			elseif trait_window_selection_index == 2 and not self.window_2_corner_glow_anim_id then
				self._on_preview_window_2_button_hovered(self)
			end
		end
	elseif self.gamepad_active_last_frame then
		local trait_window_selection_index = self.trait_window_selection_index

		if trait_window_selection_index == 1 then
			self._on_preview_window_1_button_hover_exit(self)
		elseif trait_window_selection_index == 2 then
			self._on_preview_window_2_button_hover_exit(self)
		end

		self.trait_window_selection_index = nil
	end

	self.reroll_completed_value = nil

	self._update_animations(self, dt)

	local handling_reroll_answer = self.handling_reroll_answer

	self._update_rotation_animation(self, dt)

	if gamepad_active and (not self.preview_window_open_anim_id or not self.preview_window_close_anim_id) then
		self._handle_gamepad_input(self, dt)
	end

	for name, animation in pairs(self.animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.animations[name] = nil

			self.on_charge_animations_complete(self, name)
		end
	end

	local widgets_by_name = self.widgets_by_name
	self.item_remove_request = nil
	self.pressed_item_backend_id = nil
	local widget = widgets_by_name.item_button_widget
	local item_slot_button_hotspot = widget.content.button_hotspot

	if item_slot_button_hotspot.on_hover_enter and (not self.preview_window_open_anim_id or not self.preview_window_close_anim_id) then
		if self.active_item_id then
			self._play_sound(self, "Play_hud_hover")
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

	if self.handling_reroll_answer then
		if not gamepad_active then
			local preview_window_1_hotspot = widgets_by_name.preview_window_1.content.hotspot
			local preview_window_2_hotspot = widgets_by_name.preview_window_2.content.hotspot

			if preview_window_1_hotspot.on_hover_enter or (preview_window_1_hotspot.is_hover and self.trait_window_selection_index ~= 1) then
				self._on_preview_window_1_button_hovered(self)

				preview_window_1_hotspot.on_hover_enter = nil
			elseif preview_window_1_hotspot.on_hover_exit then
				self._on_preview_window_1_button_hover_exit(self)
			end

			if preview_window_2_hotspot.on_hover_enter or (preview_window_2_hotspot.is_hover and self.trait_window_selection_index ~= 2) then
				self._on_preview_window_2_button_hovered(self)

				preview_window_2_hotspot.on_hover_enter = nil
			elseif preview_window_2_hotspot.on_hover_exit then
				self._on_preview_window_2_button_hover_exit(self)
			end
		end

		local preview_window_1_button_hotspot = widgets_by_name.preview_window_1_button.content.button_hotspot
		local preview_window_2_button_hotspot = widgets_by_name.preview_window_2_button.content.button_hotspot

		if preview_window_1_button_hotspot.on_hover_enter or preview_window_2_button_hotspot.on_hover_enter then
			self._play_sound(self, "Play_hud_hover")
		end

		self.reroll_option_selected = nil
		self.reroll_option_keep_old = nil

		if preview_window_1_button_hotspot.on_release then
			preview_window_1_button_hotspot.on_release = nil
			local keep_old_traits = true

			self.handle_traits_reroll_options(self, keep_old_traits)
			self._play_sound(self, "Play_hud_reroll_traits_accept")
		elseif preview_window_2_button_hotspot.on_release then
			preview_window_2_button_hotspot.on_release = nil
			local keep_old_traits = false

			self.handle_traits_reroll_options(self, keep_old_traits)
			self._play_sound(self, "Play_hud_reroll_traits_accept")
		end
	elseif item_slot_button_hotspot.on_double_click or item_slot_button_hotspot.on_right_click or self.gamepad_item_remove_request then
		if not self.rerolling and widget.content.icon_texture_id then
			self.item_remove_request = true
		end
	elseif item_slot_button_hotspot.on_pressed then
		self.pressed_item_backend_id = self.active_item_id
	end

	self.gamepad_item_remove_request = nil
	self.reroll_request = nil

	if not self.preview_window_open_anim_id or not self.preview_window_close_anim_id then
		local reroll_button_widget = widgets_by_name.reroll_button_widget
		local reroll_button_content = reroll_button_widget.content
		local reroll_button_hotspot = reroll_button_content.button_hotspot

		if reroll_button_hotspot.on_hover_enter then
			self._play_sound(self, "Play_hud_hover")
		end

		if reroll_button_hotspot.on_release or self.gamepad_reroll_request then
			reroll_button_hotspot.on_release = nil

			if self.can_afford_reroll_cost(self) then
				self.reroll_request = true

				self._play_sound(self, "Play_hud_select")
			end
		end
	end

	self.gamepad_reroll_request = nil
	local num_traits = AltarSettings.num_traits
	local current_traits_data = self.current_traits_data
	local new_traits_data = self.new_traits_data

	if current_traits_data then
		for i = 1, num_traits*2, 1 do
			local widget_name = "trait_button_" .. i
			local widget = widgets_by_name[widget_name]
			local button_hotspot = widget.content.button_hotspot
			local has_trait_data = (i <= num_traits and current_traits_data[i]) or (new_traits_data and new_traits_data[i])

			if button_hotspot.on_hover_enter and not button_hotspot.is_selected and has_trait_data then
				self._play_sound(self, "Play_hud_hover")
			end
		end
	end

	for i = 1, num_traits*2, 1 do
		local widget_name = "trait_button_" .. i
		local widget = widgets_by_name[widget_name]
		local button_hotspot = widget.content.button_hotspot

		if (button_hotspot.on_pressed or self.gamepad_changed_selected_trait_index == i) and not button_hotspot.is_selected and i ~= self.selected_trait_index then
			self._play_sound(self, "Play_hud_select")
			self._set_selected_trait(self, i)

			widget.content.button_hotspot.on_pressed = nil

			break
		end
	end

	self.gamepad_changed_selected_trait_index = nil

	self.on_item_dragged(self)

	if self.is_dragging_started(self) then
		self._play_sound(self, "Play_hud_inventory_pickup_item")
	end

	self.gamepad_active_last_frame = gamepad_active

	return 
end
AltarTraitRollUI._set_selected_trait = function (self, selected_index)
	local num_traits = AltarSettings.num_traits
	local widgets_by_name = self.widgets_by_name

	for i = 1, num_traits*2, 1 do
		local widget_name = "trait_button_" .. i
		local widget = widgets_by_name[widget_name]
		widget.content.button_hotspot.is_selected = i == selected_index
	end

	local traits_data = (selected_index and ((selected_index <= num_traits and self.current_traits_data) or self.new_traits_data)) or nil
	local trait_display_data = traits_data and traits_data[selected_index]

	if trait_display_data then
		local title_widget = widgets_by_name.text_frame_title
		title_widget.content.text = trait_display_data.display_name
		title_widget.content.visible = true
		local description_widget = widgets_by_name.text_frame_description
		description_widget.content.text = trait_display_data.description_text
		description_widget.content.visible = true
		local trait_name = trait_display_data.trait_name
		local backend_item_id = self.active_item_id
		local item_has_trait = BackendUtils.item_has_trait(backend_item_id, trait_name)

		if item_has_trait then
			description_widget.style.text.last_line_color = nil
		else
			description_widget.style.text.last_line_color = Colors.get_color_table_with_alpha("red", 255)
		end

		self.selected_trait_name = trait_name
		self.selected_trait_widget_name = "trait_button_" .. selected_index
	else
		self.selected_trait_name = nil
		self.selected_trait_widget_name = nil
		local title_widget = widgets_by_name.text_frame_title
		title_widget.content.text = ""
		title_widget.content.visible = false
		local description_widget = widgets_by_name.text_frame_description
		description_widget.content.text = ""
		description_widget.content.visible = false
	end

	self.selected_trait_index = selected_index

	return 
end
AltarTraitRollUI._clear_item_display_data = function (self)
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

	self._set_description_text(self, "altar_trait_roll_description_1")
	self._update_trait_cost_display(self, true)
	self._update_trait_alignment(self, num_traits - 1, false)
	self._clear_new_trait_slots(self)
	self._set_option_buttons_visibility(self, false)

	return 
end
AltarTraitRollUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.parent:page_input_service()

	UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	local widgets = self.widgets
	local num_widgets = #widgets

	for i = 1, num_widgets, 1 do
		local widget = widgets[i]

		UIRenderer.draw_widget(ui_top_renderer, widget)
	end

	local trait_preview_widgets = self.trait_preview_widgets
	local num_preview_widgets = #trait_preview_widgets
	local current_traits_data = self.current_traits_data
	local new_traits_data = self.new_traits_data

	if current_traits_data and new_traits_data then
		for i = 1, num_preview_widgets, 1 do
			if current_traits_data[i] or new_traits_data[i] then
				local widget = trait_preview_widgets[i]

				UIRenderer.draw_widget(ui_top_renderer, widget)
			end
		end
	end

	UIRenderer.end_pass(ui_top_renderer)

	return 
end
AltarTraitRollUI._set_reroll_button_disabled = function (self, disabled)
	local widgets_by_name = self.widgets_by_name
	local reroll_button_widget = widgets_by_name.reroll_button_widget
	reroll_button_widget.content.button_hotspot.disabled = disabled
	reroll_button_widget.content.show_title = disabled
	reroll_button_widget.content.show_glow = not disabled

	return 
end
AltarTraitRollUI._set_description_text = function (self, text)
	local widgets_by_name = self.widgets_by_name
	local description_widget = widgets_by_name.description_text_1
	description_widget.content.text = text

	return 
end
AltarTraitRollUI.add_item = function (self, backend_item_id, ignore_sound, is_equipped)
	local gamepad_active = self.input_manager:is_device_active("gamepad")
	local reroll_button_widget = self.widgets_by_name.reroll_button_widget

	if self.charging or reroll_button_widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	if self.active_item_id and self.active_item_id ~= backend_item_id then
		self.popup_confirmed = nil
	end

	self._clear_item_display_data(self)

	if not ignore_sound then
		self._play_sound(self, "Play_hud_inventory_drop_item")
	end

	local item_data = BackendUtils.get_item_from_masterlist(backend_item_id)
	local icon_texture = item_data.inventory_icon
	local rarity = item_data.rarity
	local num_owned_traits = 0
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.item_button_widget
	widget.content.icon_texture_id = icon_texture
	widget.style.icon_frame_texture_id.color = Colors.get_table(rarity)
	self.active_item_id = backend_item_id
	self.active_item_data = item_data
	self.active_item_is_equipped = is_equipped
	local traits = item_data.traits
	local num_traits = AltarSettings.num_traits
	local current_traits_data = {}
	local can_unlock_traits_on_this_item = false
	local number_of_traits_on_item = 0
	local first_locked_trait_index = nil
	local trait_locked_text = Localize("tooltip_trait_locked")

	for i = 1, num_traits, 1 do
		local trait_name = traits and traits[i]
		local widget_name = "trait_button_" .. i
		local trait_widget = widgets_by_name[widget_name]
		local trait_widget_content = trait_widget.content
		local trait_widget_style = trait_widget.style
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = trait_name == nil
		trait_widget_style.texture_id.color[1] = 255
		trait_widget_style.texture_lock_id.color[1] = 255
		trait_widget_style.texture_glow_id.color[1] = 0

		if trait_name then
			local trait_template = BuffTemplates[trait_name]
			local item_has_trait = BackendUtils.item_has_trait(backend_item_id, trait_name)

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local description_text = BackendUtils.get_item_trait_description(backend_item_id, i)

				if not item_has_trait then
					description_text = description_text .. "\n" .. trait_locked_text
				end

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

			if not item_has_trait then
				can_unlock_traits_on_this_item = true

				if not first_locked_trait_index then
					first_locked_trait_index = i
				end
			else
				num_owned_traits = num_owned_traits + 1
			end

			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	self.current_traits_data = current_traits_data
	self.number_of_owned_traits = num_owned_traits

	if 0 < number_of_traits_on_item then
		self._set_reroll_button_disabled(self, false)
	end

	self.number_of_traits_on_item = number_of_traits_on_item

	self._update_trait_alignment(self, number_of_traits_on_item, false)
	self._set_selected_trait(self, 1)

	local platform = PLATFORM
	local description_text = "altar_trait_roll_description_2"

	if (platform == "win32" and gamepad_active) or platform == "xb1" then
		description_text = description_text .. "_xb1"
	elseif (platform == "win32" and gamepad_active and UISettings.use_ps4_input_icons) or platform == "ps4" then
		description_text = description_text .. "_ps4"
	end

	self._set_description_text(self, description_text)

	local item_button_bg_glow_widget = widgets_by_name.item_button_bg_glow_widget
	item_button_bg_glow_widget.style.texture_id.color[1] = 0

	self._clear_new_trait_slots(self, true)
	self.set_traits_info(self, self.current_traits_data, 1, num_traits)

	local platform = PLATFORM
	local description_text = "altar_trait_roll_description_2"

	if (platform == "win32" and gamepad_active) or platform == "xb1" then
		description_text = description_text .. "_xb1"
	elseif (platform == "win32" and gamepad_active and UISettings.use_ps4_input_icons) or platform == "ps4" then
		description_text = description_text .. "_ps4"
	end

	self._set_description_text(self, description_text)
	self._update_trait_cost_display(self)

	local reroll_button_widget = self.widgets_by_name.reroll_button_widget
	reroll_button_widget.content.default_text_on_disable = true

	return 
end
AltarTraitRollUI._set_new_traits = function (self, traits, rarity)
	local widgets_by_name = self.widgets_by_name
	local num_traits = AltarSettings.num_traits
	local trait_locked_text = Localize("tooltip_trait_locked")
	local new_traits_data = {}
	local trait_index = #traits

	for i = num_traits + 1, num_traits + #traits, 1 do
		local trait_name = traits and traits[trait_index]
		local widget_name = "trait_button_" .. i
		local trait_widget = widgets_by_name[widget_name]
		local trait_widget_content = trait_widget.content
		local trait_widget_style = trait_widget.style
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_style.texture_id.color[1] = 0
		trait_widget_style.texture_lock_id.color[1] = 0
		trait_widget_style.texture_glow_id.color[1] = 0

		if trait_name then
			local trait_template = BuffTemplates[trait_name]
			local item_has_trait = false

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local description_text = BackendUtils.get_trait_description(trait_name, rarity)

				if not item_has_trait then
					description_text = description_text .. "\n" .. trait_locked_text
				end

				local icon = trait_template.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_hotspot.is_selected = false
				trait_widget_hotspot.on_pressed = false
				new_traits_data[i] = {
					trait_name = trait_name,
					display_name = display_name,
					description_text = description_text,
					icon = icon or "trait_icon_empty",
					locked = not item_has_trait
				}
			end

			trait_widget_hotspot.locked = not item_has_trait
		end

		trait_index = trait_index - 1
	end

	self.new_traits_data = new_traits_data

	self.set_traits_info(self, self.new_traits_data, num_traits + 1, num_traits*2)

	return 
end
AltarTraitRollUI._clear_new_trait_slots = function (self, use_unknown_texture)
	local widgets_by_name = self.widgets_by_name
	local num_traits = AltarSettings.num_traits

	for i = num_traits + 1, num_traits*2, 1 do
		local widget_name = "trait_button_" .. i
		local trait_widget = widgets_by_name[widget_name]
		local trait_widget_style = trait_widget.style
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_content.texture_id = (use_unknown_texture and "icon_any") or nil
		trait_widget_hotspot.disabled = true
		trait_widget_style.texture_id.color[1] = (use_unknown_texture and 255) or nil
		trait_widget_style.texture_lock_id.color[1] = 0
		trait_widget_style.texture_glow_id.color[1] = 0
	end

	return 
end
AltarTraitRollUI._update_trait_alignment = function (self, number_of_traits, rotate_background)
	local ui_scenegraph = self.ui_scenegraph
	local num_total_traits = AltarSettings.num_traits
	local max_angle_between = number_of_traits/180
	local actual_angle_between = (number_of_traits ~= 1 or 0) and max_angle_between
	local start_angle = 90
	local trait_start_angle = start_angle + actual_angle_between*(number_of_traits - 1)*0.5
	local r = 105

	for i = 1, number_of_traits, 1 do
		local angle = (trait_start_angle*math.pi)/180
		local pos_x = r*math.cos(angle)
		local pos_y = r*math.sin(angle)
		local widget_name = "trait_button_" .. i
		local position = ui_scenegraph[widget_name].local_position
		position[1] = pos_x
		position[2] = pos_y
		trait_start_angle = trait_start_angle - actual_angle_between
	end

	start_angle = 270
	trait_start_angle = start_angle - actual_angle_between*(number_of_traits - 1)*0.5

	for i = num_total_traits + 1, num_total_traits + number_of_traits, 1 do
		local angle = (trait_start_angle*math.pi)/180
		local pos_x = r*math.cos(angle)
		local pos_y = r*math.sin(angle)
		local widget_name = "trait_button_" .. i
		local position = ui_scenegraph[widget_name].local_position
		position[1] = pos_x
		position[2] = pos_y
		trait_start_angle = trait_start_angle + actual_angle_between
	end

	local widgets_by_name = self.widgets_by_name

	for i = 1, 8, 1 do
		local widget_name = "trait_button_" .. i
		local widget = widgets_by_name[widget_name]
		local active = ((i <= number_of_traits or (num_total_traits < i and i <= num_total_traits + number_of_traits)) and true) or false
		widget.content.button_hotspot.disable_button = not active
		widget.content.visible = active
	end

	if rotate_background then
		local rotating_disk_widget = self.widgets_by_name.rotating_disk_widget
		rotating_disk_widget.style.texture_id.angle = 0
	end

	return 
end
AltarTraitRollUI.set_disk_rotation = function (self, progress)
	local number_of_traits_on_item = self.number_of_traits_on_item

	if not number_of_traits_on_item then
		return 
	end

	local ui_scenegraph = self.ui_scenegraph
	local num_total_traits = AltarSettings.num_traits
	local rotating_disk_widget = self.widgets_by_name.rotating_disk_widget
	local progress_angle = progress*360
	local start_angle = progress_angle%360 + 90
	local max_angle_between = number_of_traits_on_item/180
	local actual_angle_between = (number_of_traits_on_item ~= 1 or 0) and max_angle_between
	local trait_start_angle = start_angle + actual_angle_between*(number_of_traits_on_item - 1)*0.5
	rotating_disk_widget.style.texture_id.angle = -math.degrees_to_radians(progress_angle)
	local r = 105

	for i = 1, number_of_traits_on_item, 1 do
		local angle = (trait_start_angle*math.pi)/180
		local pos_x = r*math.cos(angle)
		local pos_y = r*math.sin(angle)
		local widget_name = "trait_button_" .. i
		local position = ui_scenegraph[widget_name].local_position
		position[1] = pos_x
		position[2] = pos_y
		trait_start_angle = trait_start_angle - actual_angle_between
	end

	start_angle = progress_angle%360 + 270
	trait_start_angle = start_angle - actual_angle_between*(number_of_traits_on_item - 1)*0.5

	for i = num_total_traits + 1, num_total_traits + number_of_traits_on_item, 1 do
		local angle = (trait_start_angle*math.pi)/180
		local pos_x = r*math.cos(angle)
		local pos_y = r*math.sin(angle)
		local widget_name = "trait_button_" .. i
		local position = ui_scenegraph[widget_name].local_position
		position[1] = pos_x
		position[2] = pos_y
		trait_start_angle = trait_start_angle + actual_angle_between
	end

	return 
end
AltarTraitRollUI._update_rotation_animation = function (self, dt)
	local animation_time = self.rotation_animation_time

	if animation_time then
		local total_rotation_animation_time = self.total_rotation_animation_time
		animation_time = animation_time + dt
		local progress = math.min(animation_time/total_rotation_animation_time, 1)
		local fraction = math.easeCubic(progress)

		self.set_disk_rotation(self, fraction*0.5)

		if progress == 1 then
			local rotating_disk_glow_widget = self.widgets_by_name.rotating_disk_glow_widget
			self.animations.large_glow = self.animate_element_by_time(self, rotating_disk_glow_widget.style.texture_id.color, 1, rotating_disk_glow_widget.style.texture_id.color[1], 0, 0.3)

			self._on_rotation_animation_complete(self)
		elseif self.rotation_animation_time == 0 then
			local rotating_disk_glow_widget = self.widgets_by_name.rotating_disk_glow_widget
			self.animations.large_glow = self.animate_element_by_time(self, rotating_disk_glow_widget.style.texture_id.color, 1, rotating_disk_glow_widget.style.texture_id.color[1], 255, 0.2)
		end

		self.rotation_animation_time = (animation_time < total_rotation_animation_time and animation_time) or nil
	end

	return 
end
AltarTraitRollUI._on_rotation_animation_complete = function (self)
	local new_item_backend_id = self.new_item_backend_id

	if new_item_backend_id then
		local item_backend_id = new_item_backend_id or self.active_item_id

		self.add_item(self, item_backend_id, true)
	end

	return 
end
AltarTraitRollUI._update_trait_cost_display = function (self, force_disable_button)
	local reroll_button_widget = self.widgets_by_name.reroll_button_widget
	local can_afford = self.can_afford_reroll_cost(self)
	local token_type, traits_cost, texture = self._get_upgrade_cost(self)

	if token_type then
		reroll_button_widget.content.texture_token_type = texture
		reroll_button_widget.content.token_text = traits_cost .. " x"
	else
		reroll_button_widget.content.texture_token_type = nil
		reroll_button_widget.content.token_text = ""
	end

	reroll_button_widget.content.text_field = Localize("altar_trait_roll_button_text")

	if force_disable_button ~= nil then
		can_afford = not force_disable_button
	end

	self._set_reroll_button_disabled(self, not can_afford)

	reroll_button_widget.content.button_hotspot.is_selected = false
	reroll_button_widget.content.button_hotspot.is_hover = false
	reroll_button_widget.content.default_text_on_disable = not force_disable_button

	if can_afford then
		reroll_button_widget.style.token_text_selected.text_color = Colors.get_table("cheeseburger", 255)
		reroll_button_widget.style.token_text.text_color = Colors.get_table("cheeseburger", 255)
		reroll_button_widget.style.text_selected.text_color = Colors.get_table("cheeseburger", 255)
		reroll_button_widget.style.text.text_color = Colors.get_table("cheeseburger", 255)
	else
		reroll_button_widget.style.token_text_selected.text_color = Colors.get_table("red", 255)
		reroll_button_widget.style.token_text.text_color = Colors.get_table("red", 255)
		reroll_button_widget.style.text_selected.text_color = Colors.get_table("red", 255)
		reroll_button_widget.style.text.text_color = Colors.get_table("red", 255)
	end

	return 
end
AltarTraitRollUI._get_upgrade_cost = function (self)
	local item_data = self.active_item_data

	if item_data then
		local rarity = item_data.rarity
		local reroll_traits = AltarSettings.reroll_traits
		local rarity_settings = reroll_traits[rarity]
		local token_type = rarity_settings.token_type
		local traits_cost = rarity_settings.cost
		local texture = rarity_settings.token_texture

		return token_type, traits_cost, texture
	end

	return 
end
AltarTraitRollUI.can_afford_reroll_cost = function (self)
	local token_type, traits_cost = self._get_upgrade_cost(self)

	if traits_cost then
		local num_tokens_owned = BackendUtils.get_tokens(token_type)

		return traits_cost <= num_tokens_owned
	end

	return 
end
AltarTraitRollUI.can_remove_item = function (self)
	return self.active_item_id and not self.handling_reroll_answer and not self.rerolling
end
AltarTraitRollUI.remove_item = function (self)
	local reroll_button_widget = self.widgets_by_name.reroll_button_widget

	if self.charging or reroll_button_widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	self.popup_confirmed = nil
	self.number_of_traits_on_item = nil
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.item_button_widget
	widget.content.icon_texture_id = nil
	local widget_hotspot = widget.content.button_hotspot

	if widget_hotspot.is_hover then
		widget_hotspot.on_hover_exit = true
	end

	if self.active_item_id then
		self._play_sound(self, "Play_hud_forge_item_remove")
	end

	self.active_item_id = nil
	self.active_item_data = nil
	self.selected_trait_name = nil
	self.active_item_is_equipped = nil
	local item_button_bg_glow_widget = widgets_by_name.item_button_bg_glow_widget
	item_button_bg_glow_widget.style.texture_id.color[1] = 255
	local reroll_button_widget = self.widgets_by_name.reroll_button_widget
	reroll_button_widget.content.default_text_on_disable = false

	self._clear_item_display_data(self)

	return 
end
AltarTraitRollUI.reroll = function (self, new_item_key)
	self._play_sound(self, "Play_hud_reroll_traits_magic_process")

	self.popup_confirmed = true

	self._set_selected_trait(self, nil)

	self.new_item_key = new_item_key
	local preview_window_1_button = self.widgets_by_name.preview_window_1_button
	preview_window_1_button.content.disable_input_icon = true
	local preview_window_2_button = self.widgets_by_name.preview_window_2_button
	preview_window_2_button.content.disable_input_icon = true

	if self.rerolling then
		self.fade_out_preview_window_new_traits_anim_id = self._animate_preview_window(self, "fade_out_preview_window_2_traits")

		self._instant_fade_out_traits_options_glow(self)
	else
		local new_item_data = ItemMasterList[new_item_key]
		local new_item_traits = new_item_data.traits
		local new_item_rarity = new_item_data.rarity

		self._set_new_traits(self, new_item_traits, new_item_rarity)

		local widgets_by_name = self.widgets_by_name
		local num_traits = AltarSettings.num_traits

		for i = 1, num_traits*2, 1 do
			local widget_name = "trait_button_" .. i
			local trait_widget = widgets_by_name[widget_name]
			local trait_widget_content = trait_widget.content
			local trait_widget_hotspot = trait_widget_content.button_hotspot
			trait_widget_hotspot.disabled = true
		end

		self.preview_window_open_anim_id = self._animate_preview_window(self, "preview_window_open")

		self._start_traits_reroll_animation(self)
	end

	self._update_trait_cost_display(self, true)

	self.rerolling = true

	self.set_drag_enabled(self, false)
	self._set_description_text(self, "altar_trait_roll_description_3")

	return 
end
AltarTraitRollUI.handle_traits_reroll_options = function (self, keep_old_traits)
	self.reroll_option_selected = true
	self.reroll_option_keep_old = keep_old_traits

	return 
end
AltarTraitRollUI.on_traits_option_response_done = function (self, new_item_backend_id)
	local num_traits = AltarSettings.num_traits
	local number_of_traits_on_item = self.number_of_traits_on_item
	self.new_item_backend_id = new_item_backend_id

	if new_item_backend_id then
		self.rotation_animation_time = 0

		self._play_sound(self, "Play_hud_reroll_traits_wheel")
		self._set_glow_enabled_for_traits(self, num_traits + 1, num_traits + number_of_traits_on_item, true)
	else
		local item_backend_id = self.active_item_id

		self.add_item(self, item_backend_id, true)
	end

	self.handling_reroll_answer = nil

	self._set_option_buttons_visibility(self, false)

	self.preview_window_close_anim_id = self._animate_preview_window(self, "preview_window_close")

	self._update_trait_cost_display(self, true)

	return 
end
AltarTraitRollUI.pending_reroll_answer = function (self)
	return self.handling_reroll_answer
end
AltarTraitRollUI._set_option_buttons_visibility = function (self, visible)
	local widgets_by_name = self.widgets_by_name
	local preview_window_1_button = widgets_by_name.preview_window_1_button
	local preview_window_2_button = widgets_by_name.preview_window_2_button
	local preview_window_1_button_content = preview_window_1_button.content
	local preview_window_2_button_content = preview_window_2_button.content
	preview_window_1_button_content.visible = visible
	preview_window_1_button_content.button_hotspot.disabled = not visible
	preview_window_2_button_content.visible = visible
	preview_window_2_button_content.button_hotspot.disabled = not visible

	if visible then
		local preview_window_1_button_style = preview_window_1_button.style
		local preview_window_2_button_style = preview_window_2_button.style
		preview_window_1_button_style.button_frame_glow_texture.color[1] = 0
		preview_window_2_button_style.button_frame_glow_texture.color[1] = 0
	end

	return 
end
AltarTraitRollUI._set_glow_enabled_for_traits = function (self, trait_start_index, trait_end_index, enabled)
	local widgets_by_name = self.widgets_by_name

	for i = trait_start_index, trait_end_index, 1 do
		local trait_widget_name = "trait_button_" .. i
		local widget = widgets_by_name[trait_widget_name]
		widget.style.texture_glow_id.color[1] = (enabled and 255) or 0
	end

	return 
end
AltarTraitRollUI._play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
AltarTraitRollUI._on_trait_options_presentation_complete = function (self)
	self.trait_options_presentation_complete = true
	self.handling_reroll_answer = true

	self._update_trait_cost_display(self)
	self._set_option_buttons_visibility(self, true)

	return 
end
AltarTraitRollUI._on_reroll_completed = function (self)
	local widgets_by_name = self.widgets_by_name
	local number_of_traits_on_item = self.number_of_traits_on_item

	for i = 1, number_of_traits_on_item, 1 do
		local widget_name = "trait_button_" .. i
		local trait_widget = widgets_by_name[widget_name]
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = false
	end

	self._set_selected_trait(self, 1)

	self.reroll_completed_value = (self.new_item_backend_id and "new") or "old"
	self.rerolling = nil

	self.set_drag_enabled(self, true)

	self.trait_window_selection_index = nil

	self._instant_fade_out_traits_options_glow(self)

	self.new_item_key = nil
	self.new_item_backend_id = nil

	self._update_trait_cost_display(self)

	return 
end
AltarTraitRollUI._start_traits_reroll_animation = function (self)
	local num_traits = self.number_of_traits_on_item
	local max_num_traits = AltarSettings.num_traits
	local glow_animation_data = {
		duration = 0.7,
		target_index = 1,
		from = 0,
		animation_name = "traits_glow_fade_in",
		texture_id = "texture_glow_id",
		to = 255,
		start_index = max_num_traits + 1,
		end_index = max_num_traits + num_traits,
		func = UIAnimation.function_by_time,
		easing = math.easeOutCubic
	}

	self._animate_traits_widget_texture(self, glow_animation_data, true)

	glow_animation_data.animation_name = "traits_glow_fade_out"
	glow_animation_data.from = 255
	glow_animation_data.to = 0
	glow_animation_data.start_delay = 0.9
	glow_animation_data.duration = 0.2

	self._animate_traits_widget_texture(self, glow_animation_data, true)
	self._play_sound(self, "Play_hud_reroll_traits_glow")

	local icon_animation_data = {
		duration = 0.2,
		start_delay = 0.7,
		from = 255,
		start_index = 1,
		target_index = 1,
		animation_name = "traits_icon",
		texture_id = "texture_id",
		to = 0,
		end_index = num_traits,
		func = UIAnimation.function_by_time,
		easing = math.easeInCubic,
		animation_name = "traits_icon_new",
		texture_id = "texture_id",
		start_index = max_num_traits + 1,
		end_index = max_num_traits + num_traits,
		from = 0,
		to = 255
	}

	self._animate_traits_widget_texture(self, icon_animation_data, true)

	icon_animation_data.animation_name = "traits_lock_new"
	icon_animation_data.texture_id = "texture_lock_id"

	self._animate_traits_widget_texture(self, icon_animation_data, true)

	return 
end
AltarTraitRollUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end
AltarTraitRollUI.animate_element_pulse = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.pulse_animation, target, target_index, from, to, time)

	return new_animation
end
AltarTraitRollUI._animate_traits_widget_texture = function (self, data, unique_animations)
	local widgets_by_name = self.widgets_by_name
	local target = data.target_index
	local from = data.from
	local to = data.to
	local func = data.func
	local easing = data.easing
	local animation_name = data.animation_name
	local start_index = data.start_index
	local end_index = data.end_index
	local texture_id = data.texture_id
	local time_between_each_animation = data.time_between_each_animation
	local start_delay = data.start_delay
	local duration = data.duration
	local animations = self.animations
	local params = {}

	if not unique_animations and start_delay then
		params[#params + 1] = UIAnimation.wait
		params[#params + 1] = start_delay
	end

	for i = start_index, end_index, 1 do
		local trait_widget_name = "trait_button_" .. i
		local widget = widgets_by_name[trait_widget_name]

		if unique_animations and start_delay then
			params[#params + 1] = UIAnimation.wait
			params[#params + 1] = start_delay
		end

		params[#params + 1] = func
		params[#params + 1] = widget.style[texture_id].color
		params[#params + 1] = target
		params[#params + 1] = from
		params[#params + 1] = to
		params[#params + 1] = duration
		params[#params + 1] = easing

		if time_between_each_animation and i < end_index then
			params[#params + 1] = UIAnimation.wait
			params[#params + 1] = time_between_each_animation
		end

		if unique_animations then
			animations[animation_name .. "_" .. i] = UIAnimation.init(unpack(params))

			table.clear(params)
		end
	end

	if not unique_animations then
		animations[animation_name] = UIAnimation.init(unpack(params))
	end

	return 
end
AltarTraitRollUI._animate_preview_window = function (self, animation_name)
	local widgets_by_name = self.widgets_by_name
	local trait_preview_widgets_by_name = self.trait_preview_widgets_by_name
	local widgets = {
		expand_frame_background = widgets_by_name.expand_frame_background,
		preview_window_1_corner = widgets_by_name.preview_window_1_corner,
		preview_window_2_corner = widgets_by_name.preview_window_2_corner,
		preview_window_1_title = widgets_by_name.preview_window_1_title,
		preview_window_2_title = widgets_by_name.preview_window_2_title,
		trait_preview_1 = trait_preview_widgets_by_name.trait_preview_1,
		trait_preview_2 = trait_preview_widgets_by_name.trait_preview_2,
		trait_preview_3 = trait_preview_widgets_by_name.trait_preview_3,
		trait_preview_4 = trait_preview_widgets_by_name.trait_preview_4,
		trait_preview_5 = trait_preview_widgets_by_name.trait_preview_5,
		trait_preview_6 = trait_preview_widgets_by_name.trait_preview_6,
		trait_preview_7 = trait_preview_widgets_by_name.trait_preview_7,
		trait_preview_8 = trait_preview_widgets_by_name.trait_preview_8
	}
	local params = {
		wwise_world = self.wwise_world
	}

	return self.ui_animator:start_animation(animation_name, widgets, self.scenegraph_definition, params)
end
AltarTraitRollUI.set_drag_enabled = function (self, enabled)
	local widget = self.widgets_by_name.item_button_widget
	widget.content.button_hotspot.disable_interaction = not enabled

	return 
end
AltarTraitRollUI.is_dragging_started = function (self)
	local widget = self.widgets_by_name.item_button_widget

	return widget.content.on_drag_started
end
AltarTraitRollUI.on_item_hover_enter = function (self)
	local widget = self.widgets_by_name.item_button_widget

	if widget.content.button_hotspot.on_hover_enter then
		return 0, self.active_item_id
	end

	return 
end
AltarTraitRollUI.on_item_hover_exit = function (self)
	local widget = self.widgets_by_name.item_button_widget

	if widget.content.button_hotspot.on_hover_exit then
		return 0, self.active_item_id
	end

	return 
end
AltarTraitRollUI.is_slot_hovered = function (self, is_dragging_item)
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
AltarTraitRollUI.on_dragging_item_stopped = function (self)
	local active_item_id = self.active_item_id

	if active_item_id then
		local widget = self.widgets_by_name.item_button_widget

		if widget.content.on_drag_stopped then
			return active_item_id
		end
	end

	return 
end
AltarTraitRollUI.on_item_dragged = function (self)
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
AltarTraitRollUI._on_preview_window_1_button_hovered = function (self)
	local params = {
		wwise_world = self.wwise_world
	}

	if self.window_2_corner_glow_anim_id then
		self.window_2_corner_glow_anim_id = self.ui_animator:start_animation("fade_out_window_2_corner_glow", self.widgets_by_name, self.scenegraph_definition, params)
	end

	self.window_1_corner_glow_anim_id = self.ui_animator:start_animation("fade_in_window_1_corner_glow", self.widgets_by_name, self.scenegraph_definition, params)
	self.trait_window_selection_index = 1
	local preview_window_1_button = self.widgets_by_name.preview_window_1_button
	preview_window_1_button.content.disable_input_icon = false

	return 
end
AltarTraitRollUI._on_preview_window_2_button_hovered = function (self)
	local params = {
		wwise_world = self.wwise_world
	}

	if self.window_1_corner_glow_anim_id then
		self.window_1_corner_glow_anim_id = self.ui_animator:start_animation("fade_out_window_1_corner_glow", self.widgets_by_name, self.scenegraph_definition, params)
	end

	self.window_2_corner_glow_anim_id = self.ui_animator:start_animation("fade_in_window_2_corner_glow", self.widgets_by_name, self.scenegraph_definition, params)
	self.trait_window_selection_index = 2
	local preview_window_2_button = self.widgets_by_name.preview_window_2_button
	preview_window_2_button.content.disable_input_icon = false

	return 
end
AltarTraitRollUI._on_preview_window_1_button_hover_exit = function (self)
	local params = {
		wwise_world = self.wwise_world
	}

	if self.window_1_corner_glow_anim_id then
		self.window_1_corner_glow_anim_id = self.ui_animator:start_animation("fade_out_window_1_corner_glow", self.widgets_by_name, self.scenegraph_definition, params)
	end

	if self.trait_window_selection_index == 1 then
		self.trait_window_selection_index = nil
	end

	local preview_window_1_button = self.widgets_by_name.preview_window_1_button
	preview_window_1_button.content.disable_input_icon = true

	return 
end
AltarTraitRollUI._on_preview_window_2_button_hover_exit = function (self)
	local params = {
		wwise_world = self.wwise_world
	}

	if self.window_2_corner_glow_anim_id then
		self.window_2_corner_glow_anim_id = self.ui_animator:start_animation("fade_out_window_2_corner_glow", self.widgets_by_name, self.scenegraph_definition, params)
	end

	if self.trait_window_selection_index == 2 then
		self.trait_window_selection_index = nil
	end

	local preview_window_2_button = self.widgets_by_name.preview_window_2_button
	preview_window_2_button.content.disable_input_icon = true

	return 
end
AltarTraitRollUI._on_option_button_hovered_exit = function (self)
	self._on_preview_window_1_button_hover_exit(self)
	self._on_preview_window_2_button_hover_exit(self)

	return 
end
AltarTraitRollUI._instant_fade_out_traits_options_glow = function (self)
	local widgets = self.widgets_by_name
	local alpha = 0
	widgets.preview_window_1_button.style.button_frame_glow_texture.color[1] = alpha
	widgets.preview_window_1_corner.style_global.glow_corner_color[1] = alpha
	widgets.preview_window_1_corner.style_global.glow_skull_color[1] = alpha
	widgets.preview_window_2_button.style.button_frame_glow_texture.color[1] = alpha
	widgets.preview_window_2_corner.style_global.glow_corner_color[1] = alpha
	widgets.preview_window_2_corner.style_global.glow_skull_color[1] = alpha

	for i = 1, 8, 1 do
		local widget_name = "trait_button_" .. i
		local widget = widgets[widget_name]
		local widget_style = widget.style
		local color = widget_style.texture_glow_id.color

		if alpha < color[1] then
			color[1] = alpha
		end
	end

	self.window_1_corner_glow_anim_id = nil
	self.window_2_corner_glow_anim_id = nil

	return 
end
AltarTraitRollUI.set_traits_info = function (self, traits_data, start_index, end_index)
	local num_total_traits = AltarSettings.num_traits
	local number_of_traits_on_item = 0
	local is_trinket = false
	local never_locked = false
	local trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local total_traits_height = 0
	local trait_start_spacing = 25
	local trait_end_spacing = 25
	local icon_height = 40
	local divider_height = 60
	local description_text_spacing = 15
	local trait_preview_widgets_by_name = self.trait_preview_widgets_by_name
	local ui_scenegraph = self.ui_scenegraph

	for i = start_index, end_index, 1 do
		local is_first_widget = i == start_index
		local trait_data = traits_data[i]
		local trait_name = trait_data and trait_data.trait_name
		local trait_widget = trait_preview_widgets_by_name["trait_preview_" .. i]
		local trait_widget_style = trait_widget.style
		local trait_widget_content = trait_widget.content
		trait_widget_content.visible = (trait_name and true) or false

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local trait_unlocked = not trait_data.locked
				local display_name = trait_data.display_name or "Unknown"
				local description_text = trait_data.description_text
				local trait_display_name = Localize(display_name)
				local description_text = description_text

				if not is_trinket and trait_unlocked then
					trait_widget_style.description_text.last_line_color = nil
				else
					trait_widget_style.description_text.last_line_color = Colors.get_color_table_with_alpha("red", trait_widget_style.description_text.text_color[1])
				end

				local icon = trait_data.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_content.use_background = false
				trait_widget_content.use_glow = false
				trait_widget_content.use_divider = not is_first_widget
				trait_widget.content.locked = not trait_unlocked
				trait_widget.content.title_text = trait_display_name
				trait_widget.content.description_text = description_text
				local trait_scenegraph_name = "trait_preview_" .. i
				local description_scenegraph_id = "trait_description_" .. i
				local description_field_scenegraph = ui_scenegraph[description_scenegraph_id]
				local _, description_text_height = self.get_word_wrap_size(self, description_text, trait_widget_style.description_text, description_field_scenegraph.size[1])
				local trait_total_height = icon_height + description_text_spacing + description_text_height

				if not is_first_widget then
					trait_total_height = trait_total_height + divider_height
				end

				local position = ui_scenegraph[trait_scenegraph_name].local_position
				position[2] = (not is_first_widget or 0) and -(total_traits_height + divider_height)
				total_traits_height = total_traits_height + trait_total_height
			end

			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	return 
end
AltarTraitRollUI.get_text_size = function (self, localized_text, text_style)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_top_renderer, localized_text, font[1], scaled_font_size)

	return text_width, text_height
end
AltarTraitRollUI.get_word_wrap_size = function (self, localized_text, text_style, text_area_width)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local lines = UIRenderer.word_wrap(self.ui_top_renderer, localized_text, font[1], scaled_font_size, text_area_width)
	local text_width, text_height = self.get_text_size(self, localized_text, text_style)

	return text_width, text_height*#lines
end
AltarTraitRollUI.start_charge_progress = function (self)
	self.charging = true
	local animation_name = "gamepad_charge_progress"
	local animation_time = 1.5
	local from = 0
	local to = 307
	local widget = self.widgets_by_name.reroll_button_widget
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, self.ui_scenegraph.reroll_button_fill.size, 1, from, to, animation_time, math.ease_out_quad)
	self.animations[animation_name .. "_uv"] = UIAnimation.init(UIAnimation.function_by_time, widget.content.progress_fill.uvs[2], 1, 0, 1, animation_time, math.ease_out_quad)

	self.cancel_abort_animation(self)

	widget.content.charging = true
	widget.style.progress_fill.color[1] = 255

	self._play_sound(self, "Play_hud_reroll_traits_charge")

	return 
end
AltarTraitRollUI.abort_charge_progress = function (self, force_shutdown)
	local animation_name = "gamepad_charge_progress"
	self.animations[animation_name] = nil
	self.animations[animation_name .. "_uv"] = nil
	self.charging = nil
	self.ui_scenegraph.reroll_button_fill.size[1] = 0

	self._play_sound(self, "Stop_hud_reroll_traits_charge")

	if force_shutdown then
		self.cancel_abort_animation(self)
	else
		self.start_abort_animation(self)
	end

	return 
end
AltarTraitRollUI.on_charge_complete = function (self)
	self.charging = nil
	self.gamepad_reroll_request = true
	local widget = self.widgets_by_name.reroll_button_widget
	widget.content.charging = false
	local animation_name = "progress_bar_complete"
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 0, 255, 0.2, math.easeCubic, UIAnimation.function_by_time, self.ui_scenegraph.reroll_button_fill.size, 1, 0, 0, 0.01, math.easeCubic, UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 255, 0, 0.2, math.easeOutCubic)
	self.animations[animation_name .. "2"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.token_text.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "3"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.texture_token_type.color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "4"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.text.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "5"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.text_disabled.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	widget.style.text.text_color[1] = 0
	widget.style.token_text.text_color[1] = 0
	widget.style.texture_token_type.color[1] = 0
	widget.style.text_disabled.text_color[1] = 0

	self._play_sound(self, "Stop_hud_reroll_traits_charge")

	return 
end
AltarTraitRollUI.start_abort_animation = function (self)
	local animation_name = "gamepad_charge_progress_abort"
	local from = 0
	local to = 255
	local widget = self.widgets_by_name.reroll_button_widget
	widget.content.show_cancel_text = true
	widget.content.charging = false
	widget.style.progress_fill.color[1] = 0
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, from, to, 0.2, math.easeInCubic, UIAnimation.wait, 0.3, UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, to, from, 0.3, math.easeInCubic)
	self.animations[animation_name .. "2"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.token_text.text_color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "3"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.texture_token_type.color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "4"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.text.text_color, 1, from, to, 0.3, math.easeInCubic)

	return 
end
AltarTraitRollUI.cancel_abort_animation = function (self)
	local animations = self.animations
	animations.gamepad_charge_progress_abort = nil
	animations.progress_bar_complete = nil

	for i = 2, 4, 1 do
		animations["gamepad_charge_progress_abort" .. i] = nil
	end

	for i = 2, 5, 1 do
		animations["progress_bar_complete" .. i] = nil
	end

	local widget = self.widgets_by_name.reroll_button_widget
	widget.content.charging = false
	widget.content.show_cancel_text = false
	widget.style.progress_fill.color[1] = 0
	widget.style.text_charge_cancelled.text_color[1] = 0
	widget.style.texture_token_type.color[1] = 255
	widget.style.token_text.text_color[1] = 255
	widget.style.text.text_color[1] = 255
	widget.style.text_disabled.text_color[1] = 255

	return 
end
AltarTraitRollUI.on_charge_animations_complete = function (self, animation_name)
	if animation_name == "gamepad_charge_progress" then
		self.on_charge_complete(self)
	end

	if animation_name == "gamepad_charge_progress_abort" then
		local widget = self.widgets_by_name.reroll_button_widget
		widget.content.show_cancel_text = false
	end

	return 
end
AltarTraitRollUI.on_gamepad_activated = function (self)
	local widgets_by_name = self.widgets_by_name
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "enchantment_view")
	local button_texture_data = UISettings.get_gamepad_input_texture_data(input_service, "refresh", true)
	local button_texture = button_texture_data.texture
	local button_size = button_texture_data.size
	local widget = widgets_by_name.reroll_button_widget
	widget.content.progress_input_icon = button_texture
	local select_button_texture_data = UISettings.get_gamepad_input_texture_data(input_service, "confirm", true)
	local select_button_texture = select_button_texture_data.texture
	local preview_window_1_button = widgets_by_name.preview_window_1_button
	local preview_window_2_button = widgets_by_name.preview_window_2_button
	preview_window_1_button.content.enable_input_icon = true
	preview_window_2_button.content.enable_input_icon = true
	preview_window_1_button.content.progress_input_icon = select_button_texture
	preview_window_2_button.content.progress_input_icon = select_button_texture

	return 
end
AltarTraitRollUI.on_gamepad_deactivated = function (self)
	return 
end
AltarTraitRollUI.set_active = function (self, active)
	self.active = active
	local widget = self.widgets_by_name.reroll_button_widget

	if self.charging or widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	return 
end

return 
