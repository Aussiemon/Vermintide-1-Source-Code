local definitions = dofile("scripts/ui/altar_view/altar_craft_ui_definitions")
AltarCraftUI = class(AltarCraftUI)
local drag_colors = {
	normal = Colors.get_color_table_with_alpha("drag_same_slot", 255),
	hover = Colors.get_color_table_with_alpha("drag_same_slot_hover", 255)
}
local token_total_rotation_time = 0.3
local weapon_type_total_rotation_time = 0.3
local world_cover_total_animation_time = 0.3
local token_index_list = {
	"exotic",
	"rare",
	"common",
	"plentiful"
}
local weapon_type_index_list = {
	"melee",
	"any",
	"ranged"
}
AltarCraftUI.init = function (self, parent, position, animation_definitions, ingame_ui_context)
	self.parent = parent
	self.world = ingame_ui_context.world
	self.player_manager = ingame_ui_context.player_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.peer_id = ingame_ui_context.peer_id
	self.local_player_id = ingame_ui_context.local_player_id
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
	self.ui_animator = UIAnimator:new(self.ui_scenegraph, definitions.animations)

	self.create_ui_elements(self)
	self.select_token(self, 1, true)
	self.select_weapon_type(self, 1, true)
	self._update_token_rotation_animation(self, math.huge)
	self._update_weapon_type_rotation_animation(self, math.huge)
	self.update_craft_cost_display(self)

	return 
end
AltarCraftUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.widgets = {}
	self.widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.widgets_definitions) do
		self.widgets_by_name[widget_name] = UIWidget.init(widget_definition)
		self.widgets[#self.widgets + 1] = self.widgets_by_name[widget_name]
	end

	local token_widgets = {}
	local token_wheel_widgets_definition = definitions.token_wheel_widgets_definition

	for i = 1, #token_wheel_widgets_definition, 1 do
		token_widgets[i] = UIWidget.init(token_wheel_widgets_definition[i])
	end

	self.token_widgets = token_widgets
	local weapon_type_widgets = {}
	local weapon_type_wheel_widgets_definition = definitions.weapon_type_wheel_widgets_definition

	for i = 1, #weapon_type_wheel_widgets_definition, 1 do
		weapon_type_widgets[i] = UIWidget.init(weapon_type_wheel_widgets_definition[i])
	end

	self.weapon_type_widgets = weapon_type_widgets

	for i = 1, 4, 1 do
		local token_glow_widget = self.widgets_by_name["token_icon_" .. i .. "_glow_widget"]
		local weapon_type_glow_widget = self.widgets_by_name["weapon_type_icon_" .. i .. "_glow_widget"]

		if token_glow_widget then
			token_glow_widget.style.texture_id.color[1] = 0
		end

		if weapon_type_glow_widget then
			weapon_type_glow_widget.style.texture_id.color[1] = 0
		end
	end

	self.widgets_by_name.frame_glow_skull_widget.style.texture_id.color[1] = 0
	local top_rendering_widgets = definitions.top_rendering_widgets
	self.fg_glow_widget = UIWidget.init(top_rendering_widgets.fg_glow_widget)
	self.item_button_widget = UIWidget.init(top_rendering_widgets.item_button_widget)
	self.item_button_class_icon_widget = UIWidget.init(top_rendering_widgets.item_button_class_icon)
	self.widgets_by_name.wheel_glow_token_widget.style.texture_id.color[1] = 0
	self.widgets_by_name.wheel_glow_weapon_type_widget.style.texture_id.color[1] = 0
	local craft_button_widget = self.widgets_by_name.craft_button_widget
	craft_button_widget.content.enable_charge = true
	local item_button_widget = self.item_button_widget
	item_button_widget.content.drag_select_frame = "craft_slot_drag_glow"
	item_button_widget.style.drag_select_frame.size = {
		92,
		92
	}
	item_button_widget.style.drag_select_frame.offset = {
		-7,
		-6.5
	}

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self._setup_candle_animations(self)

	return 
end
AltarCraftUI._setup_candle_animations = function (self)
	local widgets_by_name = self.widgets_by_name
	local animations = self.animations
	local candle_left_widget = widgets_by_name.background_candle_left_widget
	local candle_right_widget = widgets_by_name.background_candle_right_widget
	local candle_glow_left_widget = widgets_by_name.candle_glow_left_widget
	local candle_glow_right_widget = widgets_by_name.candle_glow_right_widget
	animations.candle_left_flame = self.animate_element_pulse(self, candle_left_widget.style.texture_id.color, 1, 255, 210, 1)
	animations.candle_left_glow = self.animate_element_pulse(self, candle_glow_left_widget.style.texture_id.color, 1, 205, 160, 1)
	animations.candle_right_flame = self.animate_element_pulse(self, candle_right_widget.style.texture_id.color, 1, 255, 185, 1.5)
	animations.candle_right_glow = self.animate_element_pulse(self, candle_glow_right_widget.style.texture_id.color, 1, 205, 125, 1.5)

	return 
end
AltarCraftUI.on_enter = function (self)
	local my_profile = self.profile_synchronizer:profile_by_peer(self.peer_id, self.local_player_id)
	local profile_name = SPProfiles[my_profile].display_name
	local texture_name = "altar_craft_icon_" .. profile_name
	self.item_button_class_icon_widget.content.texture_id = texture_name

	self.remove_item(self)
	self.update_craft_cost_display(self)

	return 
end
AltarCraftUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled

	return 
end
AltarCraftUI.handle_gamepad_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = self.parent:page_input_service()
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local use_gamepad = self.use_gamepad

	if self.had_active_item_id ~= self.active_item_id then
		if self.active_item_id then
			local wheel_glow_weapon_type_widget = self.widgets_by_name.wheel_glow_weapon_type_widget
			wheel_glow_weapon_type_widget.style.texture_id.color[1] = (self.gamepad_setting_selection == 1 and 255) or 0
			local wheel_glow_token_widget = self.widgets_by_name.wheel_glow_token_widget
			wheel_glow_token_widget.style.texture_id.color[1] = (self.gamepad_setting_selection == 2 and 255) or 0
		else
			local wheel_glow_weapon_type_widget = self.widgets_by_name.wheel_glow_weapon_type_widget
			wheel_glow_weapon_type_widget.style.texture_id.color[1] = 0
			local wheel_glow_token_widget = self.widgets_by_name.wheel_glow_token_widget
			wheel_glow_token_widget.style.texture_id.color[1] = 0
		end
	end

	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	elseif use_gamepad then
		if self.active_item_id then
			if input_service.get(input_service, "special_1") or input_service.get(input_service, "back", true) then
				if self.active_item_id then
					self.controller_cooldown = GamepadSettings.menu_cooldown
					self.gamepad_item_remove_request = true
				end
			elseif input_service.get(input_service, "refresh_press") and not self.charging and self.can_afford_craft_cost(self) then
				self.start_charge_progress(self)
			elseif self.charging and not input_service.get(input_service, "refresh_hold") then
				self.abort_charge_progress(self)

				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		end

		if not self.charging and self.active_item_id then
			local move_left = input_service.get(input_service, "move_left")
			local move_right = input_service.get(input_service, "move_right")
			local move_up = input_service.get(input_service, "move_up")
			local move_down = input_service.get(input_service, "move_down")
			local gamepad_setting_selection = self.gamepad_setting_selection

			if gamepad_setting_selection then
				if move_up or move_down then
					if move_up and 1 < gamepad_setting_selection then
						self.gamepad_setting_selection = gamepad_setting_selection - 1
						local wheel_glow_weapon_type_widget = self.widgets_by_name.wheel_glow_weapon_type_widget
						wheel_glow_weapon_type_widget.style.texture_id.color[1] = 255
						local wheel_glow_token_widget = self.widgets_by_name.wheel_glow_token_widget
						wheel_glow_token_widget.style.texture_id.color[1] = 0
						self.settings_selection_changed = true

						self.play_sound(self, "Play_hud_select")
					elseif move_down and gamepad_setting_selection < 2 then
						self.gamepad_setting_selection = self.gamepad_setting_selection + 1
						local wheel_glow_weapon_type_widget = self.widgets_by_name.wheel_glow_weapon_type_widget
						wheel_glow_weapon_type_widget.style.texture_id.color[1] = 0
						local wheel_glow_token_widget = self.widgets_by_name.wheel_glow_token_widget
						wheel_glow_token_widget.style.texture_id.color[1] = 255
						self.settings_selection_changed = true

						self.play_sound(self, "Play_hud_select")
					end
				end

				if not move_left and not move_right and not move_up and not move_down then
					self.settings_selection_changed = false
				end

				if not self.settings_selection_changed then
					local token_rotation_time = self.token_rotation_time
					local selected_token_index = self.selected_token_index
					local weapon_type_rotation_time = self.weapon_type_rotation_time
					local selected_weapon_type_index = self.selected_weapon_type_index
					gamepad_setting_selection = self.gamepad_setting_selection

					if move_right then
						if gamepad_setting_selection == 1 then
							if not weapon_type_rotation_time and 0 < selected_weapon_type_index then
								self.select_weapon_type(self, selected_weapon_type_index - 1)
								self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
							end
						elseif not token_rotation_time and 0 < selected_token_index then
							self.select_token(self, selected_token_index - 1)
							self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
						end
					elseif move_left then
						if gamepad_setting_selection == 1 then
							if not weapon_type_rotation_time and selected_weapon_type_index < #weapon_type_index_list - 1 then
								self.select_weapon_type(self, selected_weapon_type_index + 1)
								self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
							end
						elseif not token_rotation_time and selected_token_index < #token_index_list - 1 then
							self.select_token(self, selected_token_index + 1)
							self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
						end
					end
				else
					use_button_glow = (self.active_item_id and true) or false

					self._set_token_step_button_glow_state(self, (gamepad_setting_selection == 1 and use_button_glow) or false)
					self._set_weapon_type_step_button_glow_state(self, (gamepad_setting_selection == 2 and use_button_glow) or false)
				end
			end
		end

		if gamepad_active then
			if not self.gamepad_setting_selection then
				self.gamepad_setting_selection = 1
				local wheel_glow_weapon_type_widget = self.widgets_by_name.wheel_glow_weapon_type_widget
				local wheel_glow_token_widget = self.widgets_by_name.wheel_glow_token_widget
				wheel_glow_weapon_type_widget.style.texture_id.color[1] = 255
				wheel_glow_token_widget.style.texture_id.color[1] = 0
				local use_button_glow = (self.active_item_id and true) or false

				self._set_token_step_button_glow_state(self, (self.gamepad_setting_selection == 2 and use_button_glow) or false)
				self._set_weapon_type_step_button_glow_state(self, (self.gamepad_setting_selection == 1 and use_button_glow) or false)
			end
		elseif self.gamepad_setting_selection then
			self.gamepad_setting_selection = nil
			local wheel_glow_weapon_type_widget = self.widgets_by_name.wheel_glow_weapon_type_widget
			local wheel_glow_token_widget = self.widgets_by_name.wheel_glow_token_widget
			wheel_glow_weapon_type_widget.style.texture_id.color[1] = 0
			wheel_glow_token_widget.style.texture_id.color[1] = 0
			local use_button_glow = (self.active_item_id and true) or false

			self._set_token_step_button_glow_state(self, use_button_glow)
			self._set_weapon_type_step_button_glow_state(self, use_button_glow)
		end
	end

	self.had_active_item_id = self.active_item_id

	return 
end
AltarCraftUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.parent:page_input_service()

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	local num_widgets = #self.widgets

	for i = 1, num_widgets, 1 do
		local widget = self.widgets[i]

		UIRenderer.draw_widget(ui_renderer, widget)
	end

	local token_widgets = self.token_widgets

	for i = 1, #token_widgets, 1 do
		UIRenderer.draw_widget(ui_renderer, token_widgets[i])
	end

	local weapon_type_widgets = self.weapon_type_widgets

	for i = 1, #weapon_type_widgets, 1 do
		UIRenderer.draw_widget(ui_renderer, weapon_type_widgets[i])
	end

	UIRenderer.end_pass(ui_renderer)

	local ui_top_renderer = self.ui_top_renderer

	UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_top_renderer, self.fg_glow_widget)
	UIRenderer.draw_widget(ui_top_renderer, self.item_button_widget)
	UIRenderer.end_pass(ui_top_renderer)

	return 
end
AltarCraftUI.update = function (self, dt)
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

	local ignore_frame_input = self.ignore_frame_input
	self.craft_request = nil
	self.pre_craft_request = nil
	self.item_remove_request = nil
	self.pressed_item_backend_id = nil

	self._update_token_rotation_animation(self, dt)
	self._update_weapon_type_rotation_animation(self, dt)
	self._update_world_cover_animation(self, dt)
	self._update_animations(self, dt)

	if not self.crafting then
		self.handle_gamepad_input(self, dt)
	end

	for name, animation in pairs(self.animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.animations[name] = nil

			self.on_charge_animations_complete(self, name)
		end
	end

	local widgets_by_name = self.widgets_by_name

	if not self.crafting and not ignore_frame_input then
		local weapon_type_step_button_1_hotspot = widgets_by_name.weapon_type_step_button_1.content.button_hotspot
		local weapon_type_step_button_2_hotspot = widgets_by_name.weapon_type_step_button_2.content.button_hotspot
		local token_step_button_1_hotspot = widgets_by_name.token_step_button_1.content.button_hotspot
		local token_step_button_2_hotspot = widgets_by_name.token_step_button_2.content.button_hotspot

		if not self.weapon_type_rotation_time then
			local selected_weapon_type_index = self.selected_weapon_type_index

			if weapon_type_step_button_2_hotspot.on_release then
				if 0 < selected_weapon_type_index then
					self.select_weapon_type(self, selected_weapon_type_index - 1)
					self.play_sound(self, "Play_hud_select")
					self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
				end
			elseif weapon_type_step_button_1_hotspot.on_release and selected_weapon_type_index < #weapon_type_index_list - 1 then
				self.select_weapon_type(self, selected_weapon_type_index + 1)
				self.play_sound(self, "Play_hud_select")
				self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
			end

			local selected_weapon_type_index = self.selected_weapon_type_index
			local new_weapon_type_selection_index = self.new_weapon_type_selection_index

			for i, weapon_type_widget in ipairs(self.weapon_type_widgets) do
				local button_hotspot = weapon_type_widget.content.button_hotspot
				local required_hover_hotspot = weapon_type_widget.content.required_hover_hotspot

				if button_hotspot.on_hover_enter then
					self.play_sound(self, "Play_hud_hover")
				end

				if button_hotspot.on_pressed and required_hover_hotspot.is_hover then
					local list_index = i - 1

					if list_index ~= selected_weapon_type_index and list_index ~= new_weapon_type_selection_index then
						self.select_weapon_type(self, list_index)
						self.play_sound(self, "Play_hud_select")
						self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
					end
				end
			end
		end

		if not self.token_rotation_time then
			local selected_token_index = self.selected_token_index

			if token_step_button_2_hotspot.on_release then
				if 0 < selected_token_index then
					self.select_token(self, selected_token_index - 1)
					self.play_sound(self, "Play_hud_select")
					self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
				end
			elseif token_step_button_1_hotspot.on_release and selected_token_index < #token_index_list - 1 then
				self.select_token(self, selected_token_index + 1)
				self.play_sound(self, "Play_hud_select")
				self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
			end

			local selected_token_index = self.selected_token_index
			local new_token_selection_index = self.new_token_selection_index

			for i, token_widget in ipairs(self.token_widgets) do
				local button_hotspot = token_widget.content.button_hotspot
				local required_hover_hotspot = token_widget.content.required_hover_hotspot

				if button_hotspot.on_hover_enter then
					self.play_sound(self, "Play_hud_hover")
				end

				if button_hotspot.on_pressed and required_hover_hotspot.is_hover then
					local list_index = i - 1

					if list_index ~= selected_token_index and list_index ~= new_token_selection_index then
						self.select_token(self, list_index)
						self.play_sound(self, "Play_hud_select")
						self.play_sound(self, "Play_hud_reroll_traits_half_table_spin")
					end
				end
			end
		end

		if token_step_button_1_hotspot.on_hover_enter or token_step_button_2_hotspot.on_hover_enter then
			self.play_sound(self, "Play_hud_hover")
		elseif not token_step_button_1_hotspot.on_hover_exit and token_step_button_2_hotspot.on_hover_exit then
		end

		if weapon_type_step_button_1_hotspot.on_hover_enter or weapon_type_step_button_2_hotspot.on_hover_enter then
			self.play_sound(self, "Play_hud_hover")
		elseif not weapon_type_step_button_1_hotspot.on_hover_exit and weapon_type_step_button_2_hotspot.on_hover_exit then
		end

		local widget = self.item_button_widget
		local item_slot_button_hotspot = widget.content.button_hotspot

		if item_slot_button_hotspot.on_hover_enter then
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

		if item_slot_button_hotspot.on_double_click or item_slot_button_hotspot.on_right_click or self.gamepad_item_remove_request then
			if widget.content.icon_texture_id then
				self.item_remove_request = true
			end
		elseif item_slot_button_hotspot.on_pressed then
			self.pressed_item_backend_id = self.active_item_id
		end

		local craft_button_widget = widgets_by_name.craft_button_widget
		local craft_button_content = craft_button_widget.content
		local craft_button_hotspot = craft_button_content.button_hotspot

		if craft_button_hotspot.on_hover_enter then
			self.play_sound(self, "Play_hud_hover")
		end

		if craft_button_hotspot.on_release or self.gamepad_craft_request then
			craft_button_hotspot.on_release = nil

			if self.can_afford_craft_cost(self) then
				self.craft_request = true

				self.play_sound(self, "Play_hud_select")
				self.play_sound(self, "Play_hud_reroll_traits_create_weapon")
			end
		end

		self.on_item_dragged(self)
	end

	self.gamepad_item_remove_request = nil
	self.gamepad_craft_request = nil

	if self.is_dragging_started(self) then
		self.play_sound(self, "Play_hud_inventory_pickup_item")
	end

	self.ignore_frame_input = nil

	return 
end
AltarCraftUI._set_weapon_type_step_button_glow_state = function (self, active)
	local widgets_by_name = self.widgets_by_name
	widgets_by_name.weapon_type_step_button_1.content.show_glow = active
	widgets_by_name.weapon_type_step_button_2.content.show_glow = active

	return 
end
AltarCraftUI._set_token_step_button_glow_state = function (self, active)
	local widgets_by_name = self.widgets_by_name
	widgets_by_name.token_step_button_1.content.show_glow = active
	widgets_by_name.token_step_button_2.content.show_glow = active

	return 
end
AltarCraftUI._update_token_rotation_animation = function (self, dt)
	local animation_time = self.token_rotation_time

	if animation_time then
		local total_time = token_total_rotation_time
		animation_time = math.min(animation_time + dt, total_time)
		local time_progress = animation_time/total_time
		local time_easing_progress = math.easeCubic(time_progress)
		local token_widgets = self.token_widgets
		local num_widgets = #token_widgets
		local old_selection_index = self.selected_token_index or 0
		local new_selection_index = self.new_token_selection_index
		local total_progress = num_widgets/0.5
		local old_index_progress = old_selection_index*total_progress
		local new_index_progress = new_selection_index*total_progress
		local progress_diff = new_index_progress - old_index_progress
		local rotation_progress = old_index_progress + progress_diff*time_easing_progress
		local radius = 170

		self._rotate_widgets(self, self.token_widgets, radius, rotation_progress)

		local disk_angle = math.degrees_to_radians(rotation_progress*360)
		local wheel_token_widget = self.widgets_by_name.wheel_token_widget
		wheel_token_widget.style.texture_id.angle = -disk_angle

		if 0.9 < time_easing_progress then
			slot18 = self.widgets_by_name.wheel_glow_token_widget
		elseif self.token_rotation_time == 0 then
			slot18 = self.widgets_by_name.wheel_glow_token_widget
		end

		if time_progress == 1 then
			self.token_rotation_time = nil
			local selected_token_index = self.selected_token_index
			self.selected_token_index = self.new_token_selection_index
			self.new_token_selection_index = nil

			if selected_token_index then
				self.update_craft_cost_display(self)
			end
		else
			self.token_rotation_time = animation_time
		end
	end

	return 
end
AltarCraftUI._update_weapon_type_rotation_animation = function (self, dt)
	local animation_time = self.weapon_type_rotation_time

	if animation_time then
		local total_time = weapon_type_total_rotation_time
		animation_time = math.min(animation_time + dt, total_time)
		local time_progress = animation_time/total_time
		local time_easing_progress = math.easeCubic(time_progress)
		local weapon_type_widgets = self.weapon_type_widgets
		local num_widgets = #weapon_type_widgets
		local old_selection_index = self.selected_weapon_type_index or 0
		local new_selection_index = self.new_weapon_type_selection_index
		local total_progress = num_widgets/0.5
		local old_index_progress = old_selection_index*total_progress
		local new_index_progress = new_selection_index*total_progress
		local progress_diff = new_index_progress - old_index_progress
		local rotation_progress = old_index_progress + progress_diff*time_easing_progress
		local radius = 104

		self._rotate_widgets(self, weapon_type_widgets, radius, rotation_progress)

		local disk_angle = math.degrees_to_radians(rotation_progress*360)
		local wheel_weapon_type_widget = self.widgets_by_name.wheel_weapon_type_widget
		wheel_weapon_type_widget.style.texture_id.angle = -disk_angle

		if 0.9 < time_easing_progress then
			slot18 = self.widgets_by_name.wheel_glow_weapon_type_widget
		elseif self.weapon_type_rotation_time == 0 then
			slot18 = self.widgets_by_name.wheel_glow_weapon_type_widget
		end

		if time_progress == 1 then
			self.weapon_type_rotation_time = nil
			local selected_weapon_type_index = self.selected_weapon_type_index
			self.selected_weapon_type_index = self.new_weapon_type_selection_index
			self.new_weapon_type_selection_index = nil

			if selected_weapon_type_index then
				self.update_craft_cost_display(self)
			end
		else
			self.weapon_type_rotation_time = animation_time
		end
	end

	return 
end
AltarCraftUI._update_world_cover_animation = function (self, dt)
	local animation_time = self.world_cover_animation_time

	if animation_time then
		local world_cover_fade_in = self.world_cover_fade_in
		local total_time = world_cover_total_animation_time
		animation_time = math.min(animation_time + dt, total_time)
		local time_progress = animation_time/total_time
		local easing = (world_cover_fade_in and math.easeOutCubic) or math.easeInCubic
		local time_easing_progress = easing(time_progress)
		local max_value = 10
		local new_value = time_easing_progress*max_value

		if world_cover_fade_in then
			new_value = max_value - new_value
		end

		self._set_world_cover_gradient_exponent(self, new_value)

		if time_progress == 1 then
			self.world_cover_animation_time = nil

			if world_cover_fade_in then
				self.craft_animation_ready = true
			end
		else
			self.world_cover_animation_time = animation_time
		end
	end

	return 
end
AltarCraftUI._rotate_widgets = function (self, widgets, radius, progress)
	local ui_scenegraph = self.ui_scenegraph
	local num_widgets = #widgets
	local progress_angle = progress*360
	local start_angle = progress_angle - 90
	local max_angle_between = num_widgets/180
	local actual_angle_between = (num_widgets ~= 1 or 0) and max_angle_between
	local widget_start_angle = start_angle

	for i = 1, num_widgets, 1 do
		local angle = (widget_start_angle%360*math.pi)/180
		local pos_x = radius*math.cos(angle)
		local pos_y = radius*math.sin(angle)
		local widget = widgets[i]
		local widget_scenegraph_id = widget.scenegraph_id
		local position = ui_scenegraph[widget_scenegraph_id].local_position
		position[1] = pos_x
		position[2] = pos_y
		widget_start_angle = widget_start_angle - actual_angle_between
	end

	return 
end
AltarCraftUI.selected_profile_name = function (self)
	local active_item_data = self.active_item_data

	if active_item_data then
		for _, trait_name in ipairs(active_item_data.traits) do
			local trait_config = BuffTemplates[trait_name]
			local roll_dice_as_hero = trait_config.roll_dice_as_hero

			if roll_dice_as_hero then
				return roll_dice_as_hero
			end
		end
	else
		local my_profile = self.profile_synchronizer:profile_by_peer(self.peer_id, self.local_player_id)
		local profile_name = SPProfiles[my_profile].display_name

		return profile_name
	end

	return 
end
AltarCraftUI.selected_slot_name = function (self)
	local selected_weapon_type_index = self.selected_weapon_type_index + 1

	return weapon_type_index_list[selected_weapon_type_index]
end
AltarCraftUI.selected_token_rarity = function (self)
	local selected_token_index = self.selected_token_index + 1

	return token_index_list[selected_token_index]
end
AltarCraftUI.craft = function (self)
	local selected_token_index = self.selected_token_index + 1
	local selected_weapon_type_index = self.selected_weapon_type_index + 1
	local widgets_by_name = self.widgets_by_name
	local selected_token_glow_widget = widgets_by_name["token_icon_" .. selected_token_index .. "_glow_widget"]
	local selected_weapon_type_glow_widget = widgets_by_name["weapon_type_icon_" .. selected_weapon_type_index .. "_glow_widget"]
	widgets_by_name.frame_glow_skull_widget.style.texture_id.color[1] = 0
	local widgets = {
		selected_token_glow_widget,
		selected_weapon_type_glow_widget,
		widgets_by_name.frame_glow_skull_widget
	}
	local params = {
		wwise_world = self.wwise_world
	}
	local animation_name = "glow_slots"
	self.craft_anim_id = self.ui_animator:start_animation(animation_name, widgets, self.scenegraph_definition, params)
	self.crafting = true

	return 
end
AltarCraftUI.world_unit_presentation_complete = function (self)
	self.craft_animation_ready = nil
	self.item_button_widget.content.visible = true
	self.item_button_class_icon_widget.content.visible = true
	self.crafting = nil
	self.ignore_frame_input = true

	self.update_craft_cost_display(self)

	return 
end
AltarCraftUI.on_world_unit_spawn = function (self)
	self.craft_animation_ready = nil
	self.item_button_widget.content.visible = false
	self.item_button_class_icon_widget.content.visible = false

	self._animate_out_world_cover(self)
	self.update_craft_cost_display(self, true)

	return 
end
AltarCraftUI.select_token = function (self, index, instant)
	if self.charging then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	if self.token_rotation_time then
		self.selected_token_index = self.new_token_selection_index
	end

	self.new_token_selection_index = index
	self.token_rotation_time = (instant and token_total_rotation_time) or 0

	return 
end
AltarCraftUI.select_weapon_type = function (self, index, instant)
	if self.charging then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	if self.weapon_type_rotation_time then
		self.selected_weapon_type_index = self.new_weapon_type_selection_index
	end

	self.new_weapon_type_selection_index = index
	self.weapon_type_rotation_time = (instant and weapon_type_total_rotation_time) or 0

	return 
end
AltarCraftUI._animate_in_world_cover = function (self)
	self.world_cover_animation_time = 0
	self.world_cover_fade_in = true

	return 
end
AltarCraftUI._animate_out_world_cover = function (self)
	self.world_cover_animation_time = 0
	self.world_cover_fade_in = nil

	return 
end
AltarCraftUI._set_world_cover_gradient_exponent = function (self, value)
	local material_name = "gradient_enchantment_craft"
	local ui_top_renderer = self.ui_top_renderer
	local gui = ui_top_renderer.gui
	local gui_material = Gui.material(gui, material_name)

	Material.set_scalar(gui_material, "exponent", value)

	return 
end
AltarCraftUI._update_animations = function (self, dt)
	local ui_animator = self.ui_animator

	ui_animator.update(ui_animator, dt)

	if self.craft_anim_id and ui_animator.is_animation_completed(ui_animator, self.craft_anim_id) then
		self._animate_in_world_cover(self)

		self.craft_anim_id = nil
	end

	return 
end
AltarCraftUI.is_dragging_started = function (self)
	local widget = self.item_button_widget

	return widget.content.on_drag_started
end
AltarCraftUI.on_item_hover_enter = function (self)
	local widget = self.item_button_widget

	if widget.content.button_hotspot.on_hover_enter then
		return 0, self.active_item_id
	end

	return 
end
AltarCraftUI.on_item_hover_exit = function (self)
	local widget = self.item_button_widget

	if widget.content.button_hotspot.on_hover_exit then
		return 0, self.active_item_id
	end

	return 
end
AltarCraftUI.is_slot_hovered = function (self, is_dragging_item)
	local widget = self.item_button_widget
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
AltarCraftUI.on_dragging_item_stopped = function (self)
	local active_item_id = self.active_item_id

	if active_item_id then
		local widget = self.item_button_widget

		if widget.content.on_drag_stopped then
			return active_item_id
		end
	end

	return 
end
AltarCraftUI.on_item_dragged = function (self)
	local widget = self.item_button_widget
	local content = widget.content
	local icon_color = widget.style.icon_texture_id.color

	if content.is_dragging and icon_color[1] ~= 150 then
		icon_color[1] = 150
	elseif content.on_drag_stopped and icon_color[1] ~= 255 then
		icon_color[1] = 255
	end

	return 
end
AltarCraftUI.set_craft_button_disabled = function (self, disabled)
	local widgets_by_name = self.widgets_by_name
	local craft_button_widget = widgets_by_name.craft_button_widget
	craft_button_widget.content.button_hotspot.disabled = disabled
	craft_button_widget.content.show_title = disabled
	craft_button_widget.content.show_glow = not disabled

	return 
end
AltarCraftUI.is_craft_possible = function (self)
	local widgets_by_name = self.widgets_by_name
	local craft_button_widget = widgets_by_name.craft_button_widget

	return not craft_button_widget.content.button_hotspot.disabled
end
AltarCraftUI.set_description_text = function (self, text)
	local widgets_by_name = self.widgets_by_name
	local description_widget = widgets_by_name.description_text_1
	description_widget.content.text = text

	return 
end
AltarCraftUI.add_item = function (self, backend_item_id)
	local craft_button_widget = self.widgets_by_name.craft_button_widget

	if self.charging or craft_button_widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	local gamepad_active = self.input_manager:is_device_active("gamepad")

	if not gamepad_active then
		self._set_token_step_button_glow_state(self, true)
		self._set_weapon_type_step_button_glow_state(self, true)
	else
		local gamepad_setting_selection = self.gamepad_setting_selection

		if gamepad_setting_selection == 1 then
			self._set_weapon_type_step_button_glow_state(self, true)
		else
			self._set_token_step_button_glow_state(self, true)
		end
	end

	self.play_sound(self, "Play_hud_inventory_drop_item")

	local item_data = BackendUtils.get_item_from_masterlist(backend_item_id)
	local icon_texture = item_data.inventory_icon
	local rarity = item_data.rarity
	local num_owned_traits = 0
	local widgets_by_name = self.widgets_by_name
	local widget = self.item_button_widget
	widget.content.icon_texture_id = icon_texture
	widget.style.icon_frame_texture_id.color = Colors.get_table(rarity)
	self.active_item_id = backend_item_id
	self.active_item_data = item_data
	local platform = Application.platform()
	local description_text = "altar_craft_description_2"

	if (platform == "win32" and gamepad_active) or platform == "xb1" then
		description_text = description_text .. "_xb1"
	elseif (platform == "win32" and gamepad_active and UISettings.use_ps4_input_icons) or platform == "ps4" then
		description_text = description_text .. "_ps4"
	end

	self.set_description_text(self, description_text)

	local craft_button_widget = self.widgets_by_name.craft_button_widget
	craft_button_widget.content.default_text_on_disable = true

	self.update_craft_cost_display(self)

	return 
end
AltarCraftUI.update_craft_cost_display = function (self, force_disable_button)
	local craft_button_widget = self.widgets_by_name.craft_button_widget
	local can_afford = self.can_afford_craft_cost(self)
	local token_type, traits_cost, texture = self.get_craft_cost(self)

	if token_type then
		craft_button_widget.content.texture_token_type = texture
		craft_button_widget.content.token_text = traits_cost .. " x"
	else
		craft_button_widget.content.texture_token_type = nil
		craft_button_widget.content.token_text = ""
	end

	self.set_craft_button_disabled(self, force_disable_button or not can_afford)

	craft_button_widget.content.button_hotspot.is_selected = false
	craft_button_widget.content.button_hotspot.is_hover = false

	if can_afford then
		craft_button_widget.style.token_text_selected.text_color = Colors.get_table("cheeseburger", 255)
		craft_button_widget.style.token_text.text_color = Colors.get_table("cheeseburger", 255)
		craft_button_widget.style.text_selected.text_color = Colors.get_table("cheeseburger", 255)
		craft_button_widget.style.text.text_color = Colors.get_table("cheeseburger", 255)
	else
		craft_button_widget.style.token_text_selected.text_color = Colors.get_table("red", 255)
		craft_button_widget.style.token_text.text_color = Colors.get_table("red", 255)
		craft_button_widget.style.text_selected.text_color = Colors.get_table("red", 255)
		craft_button_widget.style.text.text_color = Colors.get_table("red", 255)
	end

	return 
end
AltarCraftUI.get_craft_cost = function (self)
	local selected_token_rarity = self.selected_token_rarity(self)
	local rarity_settings = AltarSettings.pray_for_loot_cost[selected_token_rarity]
	local selected_slot_name = self.selected_slot_name(self)
	local traits_cost = 0

	if Application.platform() == "xb1" then
		if selected_slot_name == "any" then
			traits_cost = rarity_settings.random
		else
			traits_cost = rarity_settings.specific
		end
	elseif selected_slot_name == "any" then
		traits_cost = Vault.withdraw_single_ex(VaultAltarCostKeyTable[selected_token_rarity].random, rarity_settings.random)
	else
		traits_cost = Vault.withdraw_single_ex(VaultAltarCostKeyTable[selected_token_rarity].specific, rarity_settings.specific)
	end

	local token_type = rarity_settings.token_type
	local token_texture = rarity_settings.token_texture

	return token_type, traits_cost, token_texture
end
AltarCraftUI.can_afford_craft_cost = function (self)
	if not self.active_item_id then
		return 
	end

	local token_type, traits_cost = self.get_craft_cost(self)
	local num_tokens_owned = BackendUtils.get_tokens(token_type)

	return traits_cost <= num_tokens_owned
end
AltarCraftUI.can_remove_item = function (self)
	return self.active_item_id and not self.crafting
end
AltarCraftUI.remove_item = function (self)
	local craft_button_widget = self.widgets_by_name.craft_button_widget

	if self.charging or craft_button_widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	self.number_of_traits_on_item = nil
	local widgets_by_name = self.widgets_by_name
	local widget = self.item_button_widget
	widget.content.icon_texture_id = nil
	local widget_hotspot = widget.content.button_hotspot

	if widget_hotspot.is_hover then
		widget_hotspot.on_hover_exit = true
	end

	if self.active_item_id then
		self.play_sound(self, "Play_hud_forge_item_remove")
	end

	self.active_item_id = nil

	self.set_description_text(self, "altar_craft_description_1")
	self.update_craft_cost_display(self)
	self._set_token_step_button_glow_state(self, false)
	self._set_weapon_type_step_button_glow_state(self, false)

	local craft_button_widget = self.widgets_by_name.craft_button_widget
	craft_button_widget.content.default_text_on_disable = false

	return 
end
AltarCraftUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
AltarCraftUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end
AltarCraftUI.animate_element_pulse = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.pulse_animation, target, target_index, from, to, time)

	return new_animation
end
AltarCraftUI.start_charge_progress = function (self)
	self.charging = true
	local animation_name = "gamepad_charge_progress"
	local animation_time = 1.5
	local from = 0
	local to = 307
	local widget = self.widgets_by_name.craft_button_widget
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, self.ui_scenegraph.craft_button_fill.size, 1, from, to, animation_time, math.ease_out_quad)
	self.animations[animation_name .. "_uv"] = UIAnimation.init(UIAnimation.function_by_time, widget.content.progress_fill.uvs[2], 1, 0, 1, animation_time, math.ease_out_quad)

	self.cancel_abort_animation(self)

	widget.content.charging = true
	widget.style.progress_fill.color[1] = 255

	self.play_sound(self, "Play_hud_reroll_traits_charge")

	return 
end
AltarCraftUI.abort_charge_progress = function (self, force_shutdown)
	local animation_name = "gamepad_charge_progress"
	self.animations[animation_name] = nil
	self.animations[animation_name .. "_uv"] = nil
	self.charging = nil
	self.ui_scenegraph.craft_button_fill.size[1] = 0

	self.play_sound(self, "Stop_hud_reroll_traits_charge")

	if force_shutdown then
		self.cancel_abort_animation(self)
	else
		self.start_abort_animation(self)
	end

	return 
end
AltarCraftUI.on_charge_complete = function (self)
	self.charging = nil
	self.gamepad_craft_request = true
	local widget = self.widgets_by_name.craft_button_widget
	widget.content.charging = false
	local animation_name = "progress_bar_complete"
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 0, 255, 0.2, math.easeCubic, UIAnimation.function_by_time, self.ui_scenegraph.craft_button_fill.size, 1, 0, 0, 0.01, math.easeCubic, UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 255, 0, 0.2, math.easeOutCubic)
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
AltarCraftUI.start_abort_animation = function (self)
	local animation_name = "gamepad_charge_progress_abort"
	local from = 0
	local to = 255
	local widget = self.widgets_by_name.craft_button_widget
	widget.content.show_cancel_text = true
	widget.content.charging = false
	widget.style.progress_fill.color[1] = 0
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, from, to, 0.2, math.easeInCubic, UIAnimation.wait, 0.3, UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, to, from, 0.3, math.easeInCubic)
	self.animations[animation_name .. "2"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.token_text.text_color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "3"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.texture_token_type.color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "4"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.text.text_color, 1, from, to, 0.3, math.easeInCubic)

	return 
end
AltarCraftUI.cancel_abort_animation = function (self)
	local animations = self.animations
	animations.gamepad_charge_progress_abort = nil
	animations.progress_bar_complete = nil

	for i = 2, 4, 1 do
		animations["gamepad_charge_progress_abort" .. i] = nil
	end

	for i = 2, 5, 1 do
		animations["progress_bar_complete" .. i] = nil
	end

	local widget = self.widgets_by_name.craft_button_widget
	widget.content.charging = false
	widget.content.show_cancel_text = false
	widget.style.progress_fill.color[1] = 0
	widget.style.text_charge_cancelled.text_color[1] = 0
	widget.style.texture_token_type.color[1] = 255
	widget.style.text_disabled.text_color[1] = 255
	widget.style.token_text.text_color[1] = 255
	widget.style.text.text_color[1] = 255

	return 
end
AltarCraftUI.on_charge_animations_complete = function (self, animation_name)
	if animation_name == "gamepad_charge_progress" then
		self.on_charge_complete(self)
	end

	if animation_name == "gamepad_charge_progress_abort" then
		local widget = self.widgets_by_name.craft_button_widget
		widget.content.show_cancel_text = false
	end

	return 
end
AltarCraftUI.on_gamepad_activated = function (self)
	local input_manager = self.input_manager
	local input_service = self.parent:page_input_service()
	local button_texture_data = UISettings.get_gamepad_input_texture_data(input_service, "refresh", true)
	local button_texture = button_texture_data.texture
	local button_size = button_texture_data.size
	local widget = self.widgets_by_name.craft_button_widget
	widget.content.progress_input_icon = button_texture

	return 
end
AltarCraftUI.on_gamepad_deactivated = function (self)
	return 
end
AltarCraftUI.set_active = function (self, active)
	self.active = active
	local widget = self.widgets_by_name.craft_button_widget

	if self.charging or widget.content.show_cancel_text then
		local force_cancel = true

		self.abort_charge_progress(self, force_cancel)
	end

	return 
end

return 
