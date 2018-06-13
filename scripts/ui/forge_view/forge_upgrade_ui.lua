local definitions = dofile("scripts/ui/forge_view/forge_upgrade_ui_definitions")
ForgeUpgradeUI = class(ForgeUpgradeUI)
local drag_colors = {
	normal = Colors.get_color_table_with_alpha("drag_same_slot", 255),
	hover = Colors.get_color_table_with_alpha("drag_same_slot_hover", 255)
}

ForgeUpgradeUI.init = function (self, parent, position, animation_definitions, ingame_ui_context)
	self.world = ingame_ui_context.world
	self.player_manager = ingame_ui_context.player_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.parent = parent
	self.traits_list = {}
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.widget_definitions = definitions.widget_definitions
	self.scenegraph_definition = definitions.scenegraph_definition
	self.scenegraph_definition.page_root.position = position
	self.animations = {}

	self:create_ui_elements()
	self:clear_item_display_data()
end

ForgeUpgradeUI.on_enter = function (self)
	self:remove_item()
end

ForgeUpgradeUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled
end

ForgeUpgradeUI.handle_gamepad_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = self.parent:page_input_service()
	local use_gamepad = self.use_gamepad
	local widgets_by_name = self.widgets_by_name
	local upgrade_button_widget = widgets_by_name.upgrade_button_widget
	local upgrade_disabled = upgrade_button_widget.content.button_hotspot.disabled
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and controller_cooldown > 0 then
		self.controller_cooldown = controller_cooldown - dt
	elseif use_gamepad and self.active_item_id then
		if (input_service:get("back", true) or input_service:get("special_1")) and not self.upgrading then
			self.controller_cooldown = GamepadSettings.menu_cooldown
			self.gamepad_item_remove_request = true
		elseif input_service:get("refresh_press") and not self.upgrading and not self.charging then
			if not upgrade_disabled then
				self:start_charge_progress()
			end
		elseif self.charging and not input_service:get("refresh_hold", nil, true) and not upgrade_disabled then
			self:abort_charge_progress()

			self.controller_cooldown = GamepadSettings.menu_cooldown
		end

		if not self.upgrading then
			local number_of_traits_on_item = self.number_of_traits_on_item
			local selected_trait_index = self.selected_trait_index

			if number_of_traits_on_item and selected_trait_index then
				local new_trait_index = nil

				if input_service:get("move_right") then
					new_trait_index = math.min(selected_trait_index + 1, number_of_traits_on_item)
					self.controller_cooldown = GamepadSettings.menu_cooldown
				elseif input_service:get("move_left") then
					new_trait_index = math.max(selected_trait_index - 1, 1)
					self.controller_cooldown = GamepadSettings.menu_cooldown
				end

				if new_trait_index and new_trait_index ~= selected_trait_index then
					self.gamepad_changed_selected_trait_index = new_trait_index
				end
			end
		end
	end
end

ForgeUpgradeUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.widgets = {}
	self.widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.widgets_definitions) do
		self.widgets_by_name[widget_name] = UIWidget.init(widget_definition)
		self.widgets[#self.widgets + 1] = self.widgets_by_name[widget_name]
	end

	local upgrade_button_widget = self.widgets_by_name.upgrade_button_widget
	upgrade_button_widget.style.eye_glow_texture.color[1] = 0

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	if not self.animations.eye_glow then
		self.animations.eye_glow = UIAnimation.init(UIAnimation.pulse_animation, upgrade_button_widget.style.eye_glow_texture.color, 1, 150, 255, 2)
		self.animations.gamepad_glow = UIAnimation.init(UIAnimation.pulse_animation, upgrade_button_widget.style.gamepad_glow_texture.color, 1, 150, 255, 2)
	end
end

ForgeUpgradeUI.update = function (self, dt)
	local input_manager = self.input_manager
	local gamepad_active = input_manager:is_device_active("gamepad")

	if gamepad_active then
		if not self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = true

			self:on_gamepad_activated()
		end
	elseif self.gamepad_active_last_frame then
		self.gamepad_active_last_frame = false

		self:on_gamepad_deactivated()
	end

	self.upgrade_completed = nil

	if self.upgrading and self.upgrade_animation then
		UIAnimation.update(self.upgrade_animation, dt)

		if UIAnimation.completed(self.upgrade_animation) then
			self.upgrade_animation = nil
			self.upgrading = nil
			self.upgrade_completed = true
		end
	end

	self:handle_gamepad_input(dt)

	for name, animation in pairs(self.animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.animations[name] = nil

			self:on_charge_animations_complete(name)
		end
	end

	self.item_remove_request = nil
	self.pressed_item_backend_id = nil
	local widget = self.widgets_by_name.item_button_widget
	local item_slot_button_hotspot = widget.content.button_hotspot

	if item_slot_button_hotspot.on_hover_enter and not self.upgrading then
		if self.active_item_id then
			self:play_sound("Play_hud_hover")
		end

		local bar_settings = UISettings.inventory.button_bars
		local fade_in_time = bar_settings.background.fade_in_time
		local alpha_hover = bar_settings.background.alpha_hover
		local widget_hover_color = widget.style.hover_texture.color
		self.animations.item_slot_hover = self:animate_element_by_time(widget_hover_color, 1, widget_hover_color[1], alpha_hover, fade_in_time)
	elseif item_slot_button_hotspot.on_hover_exit then
		local bar_settings = UISettings.inventory.button_bars
		local fade_out_time = bar_settings.background.fade_out_time
		local widget_hover_color = widget.style.hover_texture.color
		self.animations.item_slot_hover = self:animate_element_by_time(widget_hover_color, 1, widget_hover_color[1], 0, fade_out_time)
	end

	if not self.upgrading then
		if item_slot_button_hotspot.on_double_click or item_slot_button_hotspot.on_right_click or self.gamepad_item_remove_request then
			if widget.content.icon_texture_id then
				self.item_remove_request = true
			end
		elseif item_slot_button_hotspot.on_pressed then
			self.pressed_item_backend_id = self.active_item_id
		end
	end

	self.gamepad_item_remove_request = nil
	self.upgrade_request = nil
	local upgrade_button_widget = self.widgets_by_name.upgrade_button_widget
	local upgrade_button_content = upgrade_button_widget.content
	local upgrade_button_hotspot = upgrade_button_content.button_hotspot

	if upgrade_button_hotspot.on_hover_enter then
		self:play_sound("Play_hud_hover")
	end

	if not self.upgrading and self:is_upgrade_possible() and (upgrade_button_hotspot.on_release or self.gamepad_upgrade_request) then
		if self:can_afford_upgrade_cost() then
			self.upgrading_trait_index = self.selected_trait_index
			self.upgrade_request = true
		else
			self:upgrade_failed()
		end
	end

	self.gamepad_upgrade_request = nil
	local num_traits = ForgeSettings.num_traits
	local current_traits_data = self.current_traits_data

	if current_traits_data then
		for i = 1, num_traits, 1 do
			local widget_name = "trait_button_" .. i
			local widget = self.widgets_by_name[widget_name]
			local button_hotspot = widget.content.button_hotspot

			if button_hotspot.on_hover_enter and not button_hotspot.is_selected and current_traits_data[i] then
				self:play_sound("Play_hud_hover")
			end
		end
	end

	for i = 1, num_traits, 1 do
		local widget_name = "trait_button_" .. i
		local widget = self.widgets_by_name[widget_name]
		local button_hotspot = widget.content.button_hotspot

		if (button_hotspot.on_pressed or self.gamepad_changed_selected_trait_index == i) and not button_hotspot.is_selected and i ~= self.selected_trait_index then
			self:play_sound("Play_hud_select")
			self:set_selected_trait(i)

			widget.content.button_hotspot.on_pressed = nil

			break
		end
	end

	self.gamepad_changed_selected_trait_index = nil

	self:on_item_dragged()

	if self:is_dragging_started() then
		self:play_sound("Play_hud_inventory_pickup_item")
	end
end

ForgeUpgradeUI.is_dragging_started = function (self)
	local widget = self.widgets_by_name.item_button_widget

	return widget.content.on_drag_started
end

ForgeUpgradeUI.on_item_hover_enter = function (self)
	local widget = self.widgets_by_name.item_button_widget

	if widget.content.button_hotspot.on_hover_enter then
		return 0, self.active_item_id
	end
end

ForgeUpgradeUI.on_item_hover_exit = function (self)
	local widget = self.widgets_by_name.item_button_widget

	if widget.content.button_hotspot.on_hover_exit then
		return 0, self.active_item_id
	end
end

ForgeUpgradeUI.is_slot_hovered = function (self, is_dragging_item)
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

ForgeUpgradeUI.on_dragging_item_stopped = function (self)
	local active_item_id = self.active_item_id

	if active_item_id then
		local widget = self.widgets_by_name.item_button_widget

		if widget.content.on_drag_stopped then
			return active_item_id
		end
	end
end

ForgeUpgradeUI.on_item_dragged = function (self)
	local widget = self.widgets_by_name.item_button_widget
	local content = widget.content
	local icon_color = widget.style.icon_texture_id.color

	if content.is_dragging and icon_color[1] ~= 150 then
		icon_color[1] = 150
	elseif content.on_drag_stopped and icon_color[1] ~= 255 then
		icon_color[1] = 255
	end
end

ForgeUpgradeUI.set_selected_trait = function (self, selected_index)
	local num_traits = ForgeSettings.num_traits
	local widgets_by_name = self.widgets_by_name

	for i = 1, num_traits, 1 do
		local widget_name = "trait_button_" .. i
		local widget = widgets_by_name[widget_name]
		widget.content.button_hotspot.is_selected = i == selected_index
	end

	local current_traits_data = self.current_traits_data
	local trait_display_data = current_traits_data[selected_index]
	local is_trait_unlocked = nil

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
			is_trait_unlocked = true
		else
			is_trait_unlocked = false
		end

		self.selected_trait_name = trait_name
		self.selected_trait_widget_name = "trait_button_" .. selected_index
	else
		self.selected_trait_name = nil
		self.selected_trait_widget_name = nil
	end

	self:set_upgrade_button_disabled(is_trait_unlocked)
	self:update_trait_cost_display(is_trait_unlocked)

	self.selected_trait_index = selected_index
end

ForgeUpgradeUI.clear_item_display_data = function (self)
	local widgets_by_name = self.widgets_by_name
	local num_traits = ForgeSettings.num_traits

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

	self:set_description_text("upgrade_description_1")
	self:set_upgrade_button_disabled(true)
	self:update_trait_alignment(num_traits - 1)
end

ForgeUpgradeUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.parent:page_input_service()
	local gamepad_active = Managers.input:get_device("gamepad").active()

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	local num_widgets = #self.widgets

	for i = 1, num_widgets, 1 do
		local widget = self.widgets[i]

		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)
end

ForgeUpgradeUI.set_upgrade_button_disabled = function (self, disabled)
	local widgets_by_name = self.widgets_by_name
	local upgrade_button_widget = widgets_by_name.upgrade_button_widget
	upgrade_button_widget.content.button_hotspot.disabled = disabled
	upgrade_button_widget.content.show_title = disabled
end

ForgeUpgradeUI.is_upgrade_possible = function (self)
	local widgets_by_name = self.widgets_by_name
	local upgrade_button_widget = widgets_by_name.upgrade_button_widget

	return not upgrade_button_widget.content.button_hotspot.disabled
end

ForgeUpgradeUI.set_description_text = function (self, text)
	local widgets_by_name = self.widgets_by_name
	local description_widget = widgets_by_name.description_text_1
	description_widget.content.text = text
end

ForgeUpgradeUI.add_item = function (self, backend_item_id)
	local upgrade_button_widget = self.widgets_by_name.upgrade_button_widget

	if self.charging or upgrade_button_widget.content.show_cancel_text then
		local force_cancel = true

		self:abort_charge_progress(force_cancel)
	end

	self:clear_item_display_data()
	self:play_sound("Play_hud_inventory_drop_item")

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
	local traits = item_data.traits
	local num_traits = ForgeSettings.num_traits
	local current_traits_data = {}
	local can_unlock_traits_on_this_item = false
	local number_of_traits_on_item = 0
	local first_locked_trait_index = nil

	for i = 1, num_traits, 1 do
		local trait_name = traits and traits[i]
		local widget_name = "trait_button_" .. i
		local trait_widget = widgets_by_name[widget_name]
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = trait_name == nil

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

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
					icon = icon or "trait_icon_empty"
				}
			end

			local item_has_trait = BackendUtils.item_has_trait(backend_item_id, trait_name)
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

	if number_of_traits_on_item > 0 then
		self:set_upgrade_button_disabled(false)
	end

	self.number_of_traits_on_item = number_of_traits_on_item

	self:update_trait_alignment(number_of_traits_on_item)
	self:set_selected_trait(first_locked_trait_index or 1)

	if can_unlock_traits_on_this_item then
		self:set_description_text("upgrade_description_2")
	else
		self:set_description_text("upgrade_description_3")
	end
end

ForgeUpgradeUI.update_trait_alignment = function (self, number_of_traits)
	local ui_scenegraph = self.ui_scenegraph
	local width = 40
	local spacing = 80
	local half_trait_amount = (number_of_traits - 1) * 0.5
	local start_x_position = -((width + spacing) * half_trait_amount)

	for i = 1, number_of_traits, 1 do
		local widget_name = "trait_button_" .. i
		local position = ui_scenegraph[widget_name].local_position
		position[1] = start_x_position
		start_x_position = start_x_position + width + spacing
	end

	local widgets_by_name = self.widgets_by_name
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local widget_name = "trait_button_" .. i
		local widget = widgets_by_name[widget_name]
		widget.content.visible = (i <= number_of_traits and true) or false
	end
end

ForgeUpgradeUI.update_trait_cost_display = function (self, is_trait_unlocked)
	local upgrade_button_widget = self.widgets_by_name.upgrade_button_widget
	local can_afford = self:can_afford_upgrade_cost()
	local token_type, traits_cost, texture = self:get_upgrade_cost()

	if traits_cost then
		upgrade_button_widget.content.texture_token_type = texture
		upgrade_button_widget.content.token_text = traits_cost .. " x"
	else
		upgrade_button_widget.content.texture_token_type = nil
		upgrade_button_widget.content.token_text = ""
	end

	if is_trait_unlocked then
		upgrade_button_widget.content.text_field = Localize("owned")
	else
		upgrade_button_widget.content.text_field = Localize("upgrade")
	end

	upgrade_button_widget.content.button_hotspot.disabled = (is_trait_unlocked and true) or not can_afford
	upgrade_button_widget.content.button_hotspot.is_selected = false
	upgrade_button_widget.content.button_hotspot.is_hover = false

	if can_afford then
		upgrade_button_widget.style.token_text_selected.text_color = Colors.get_table("cheeseburger", 255)
		upgrade_button_widget.style.token_text.text_color = Colors.get_table("cheeseburger", 255)
		upgrade_button_widget.style.text_selected.text_color = Colors.get_table("cheeseburger", 255)
		upgrade_button_widget.style.text.text_color = Colors.get_table("cheeseburger", 255)
	else
		upgrade_button_widget.style.token_text_selected.text_color = Colors.get_table("red", 255)
		upgrade_button_widget.style.token_text.text_color = Colors.get_table("red", 255)
		upgrade_button_widget.style.text_selected.text_color = Colors.get_table("red", 255)
		upgrade_button_widget.style.text.text_color = Colors.get_table("red", 255)
	end
end

ForgeUpgradeUI.get_upgrade_cost = function (self)
	local item_data = self.active_item_data
	local number_of_owned_traits = self.number_of_owned_traits or 0
	local rarity = item_data.rarity
	local upgrade_settings = ForgeSettings.trait_unlock_cost[rarity]
	local token_type = upgrade_settings.token_type
	local token_texture = upgrade_settings.token_texture
	local token_cost = nil
	local upgrade_settings_key_table = VaultForgeUnlockKeyTable[rarity]
	local token_cost_key = upgrade_settings_key_table[number_of_owned_traits + 1]
	token_cost = (token_cost_key and Vault.withdraw_single_ex(token_cost_key, upgrade_settings.cost[number_of_owned_traits + 1])) or nil

	return token_type, token_cost, token_texture
end

ForgeUpgradeUI.can_afford_upgrade_cost = function (self)
	local token_type, traits_cost = self:get_upgrade_cost()
	local num_tokens_owned = BackendUtils.get_tokens(token_type)

	return (traits_cost and traits_cost <= num_tokens_owned) or false
end

ForgeUpgradeUI.refresh = function (self)
	local selected_index = self.selected_trait_index

	self:set_selected_trait(selected_index)
end

ForgeUpgradeUI.remove_item = function (self)
	self.number_of_traits_on_item = nil
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.item_button_widget
	widget.content.icon_texture_id = nil
	local widget_hotspot = widget.content.button_hotspot

	if widget_hotspot.is_hover then
		widget_hotspot.on_hover_exit = true
	end

	if self.active_item_id then
		self:play_sound("Play_hud_forge_item_remove")
	end

	self.active_item_id = nil
	self.selected_trait_name = nil
	local upgrade_button_widget = widgets_by_name.upgrade_button_widget

	if self.charging or upgrade_button_widget.content.show_cancel_text then
		local force_cancel = true

		self:abort_charge_progress(force_cancel)
	end

	self:clear_item_display_data()
end

ForgeUpgradeUI.upgrade = function (self)
	if self.charging then
		return
	end

	self.upgrading = true
	local widgets_by_name = self.widgets_by_name
	local selected_trait_widget_name = self.selected_trait_widget_name
	local widget = widgets_by_name[selected_trait_widget_name]
	self.number_of_owned_traits = math.min(self.number_of_owned_traits + 1, ForgeSettings.num_traits)
	self.upgrade_animation = UIAnimation.init(UIAnimation.function_by_time, widget.style.texture_glow_id.color, 1, 0, 255, 0.5, math.easeInCubic, UIAnimation.function_by_time, widget.style.texture_lock_id.color, 1, 255, 0, 0.5, math.easeInCubic, UIAnimation.function_by_time, widget.style.texture_glow_id.color, 1, 255, 0, 0.5, math.easeInCubic)

	self:set_upgrade_button_disabled(true)
	self:update_trait_cost_display(true)

	local selected_index = self.upgrading_trait_index
	self.upgrading_trait_index = nil
	local description_text = BackendUtils.get_item_trait_description(self.active_item_id, selected_index)
	self.current_traits_data[selected_index].description_text = description_text

	self:set_selected_trait(selected_index)
end

ForgeUpgradeUI.upgrade_failed = function (self)
	self.upgrading_trait_index = nil
end

ForgeUpgradeUI.display_upgrade_failure_message = function (self)
	local description_failure = self.widgets_by_name.description_failure
	local failure_color = description_failure.style.text.text_color
	self.animations.failure_message = UIAnimation.init(UIAnimation.function_by_time, failure_color, 1, 0, 255, 0.1, math.easeCubic, UIAnimation.wait, 2, UIAnimation.function_by_time, failure_color, 1, 255, 0, 1.5, math.easeInCubic)
end

ForgeUpgradeUI.hide_upgrade_failure_message = function (self)
	self.animations.failure_message = nil
	local description_failure = self.widgets_by_name.description_failure
	local failure_color = description_failure.style.text.text_color
	failure_color[1] = 0
end

ForgeUpgradeUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

ForgeUpgradeUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end

ForgeUpgradeUI.start_charge_progress = function (self)
	self.charging = true
	local animation_name = "gamepad_charge_progress"
	local animation_time = 1.5
	local from = 0
	local to = 307
	local widget = self.widgets_by_name.upgrade_button_widget
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, self.ui_scenegraph.upgrade_button_fill.size, 1, from, to, animation_time, math.ease_out_quad)
	self.animations[animation_name .. "_uv"] = UIAnimation.init(UIAnimation.function_by_time, widget.content.progress_fill.uvs[2], 1, 0, 1, animation_time, math.ease_out_quad)

	self:cancel_abort_animation()

	widget.content.charging = true
	widget.style.progress_fill.color[1] = 255

	self:play_sound("Play_hud_forge_charge")
end

ForgeUpgradeUI.abort_charge_progress = function (self, force_shutdown)
	local animation_name = "gamepad_charge_progress"
	self.animations[animation_name] = nil
	self.animations[animation_name .. "_uv"] = nil
	self.charging = nil
	self.ui_scenegraph.upgrade_button_fill.size[1] = 0

	self:play_sound("Stop_hud_forge_charge")

	if force_shutdown then
		self:cancel_abort_animation()
	else
		self:start_abort_animation()
	end
end

ForgeUpgradeUI.on_charge_complete = function (self)
	self.charging = nil
	self.gamepad_upgrade_request = true
	local widget = self.widgets_by_name.upgrade_button_widget
	widget.content.charging = false
	local animation_name = "progress_bar_complete"
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 0, 255, 0.2, math.easeCubic, UIAnimation.function_by_time, self.ui_scenegraph.upgrade_button_fill.size, 1, 0, 0, 0.01, math.easeCubic, UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 255, 0, 0.2, math.easeOutCubic)
	self.animations[animation_name .. "2"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.token_text.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "3"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.texture_token_type.color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "4"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.text.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	self.animations[animation_name .. "5"] = UIAnimation.init(UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.text_disabled.text_color, 1, 0, 255, 0.3, math.easeInCubic)
	widget.style.text.text_color[1] = 0
	widget.style.token_text.text_color[1] = 0
	widget.style.text_disabled.text_color[1] = 0
	widget.style.texture_token_type.color[1] = 0

	self:play_sound("Stop_hud_forge_charge")
end

ForgeUpgradeUI.start_abort_animation = function (self)
	local animation_name = "gamepad_charge_progress_abort"
	local from = 0
	local to = 255
	local widget = self.widgets_by_name.upgrade_button_widget
	widget.style.progress_fill.color[1] = 0
	widget.content.show_cancel_text = true
	widget.content.charging = false
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, from, to, 0.2, math.easeInCubic, UIAnimation.wait, 0.3, UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, to, from, 0.3, math.easeInCubic)
	self.animations[animation_name .. "2"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.token_text.text_color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "3"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.texture_token_type.color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "4"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.text.text_color, 1, from, to, 0.3, math.easeInCubic)
end

ForgeUpgradeUI.cancel_abort_animation = function (self)
	local animations = self.animations
	animations.gamepad_charge_progress_abort = nil
	animations.progress_bar_complete = nil

	for i = 2, 4, 1 do
		animations["gamepad_charge_progress_abort" .. i] = nil
	end

	for i = 2, 5, 1 do
		animations["progress_bar_complete" .. i] = nil
	end

	local widget = self.widgets_by_name.upgrade_button_widget
	widget.content.charging = false
	widget.content.show_cancel_text = false
	widget.style.progress_fill.color[1] = 0
	widget.style.text_charge_cancelled.text_color[1] = 0
	widget.style.texture_token_type.color[1] = 255
	widget.style.text_disabled.text_color[1] = 255
	widget.style.token_text.text_color[1] = 255
	widget.style.text.text_color[1] = 255
end

ForgeUpgradeUI.on_charge_animations_complete = function (self, animation_name)
	if animation_name == "gamepad_charge_progress" then
		self:on_charge_complete()
	end

	if animation_name == "gamepad_charge_progress_abort" then
		local widget = self.widgets_by_name.upgrade_button_widget
		widget.content.show_cancel_text = false
	end
end

ForgeUpgradeUI.on_gamepad_activated = function (self)
	local input_service = self.input_manager:get_service("forge_view")
	local button_texture_data = UISettings.get_gamepad_input_texture_data(input_service, "refresh", true)
	local button_texture = button_texture_data.texture
	local button_size = button_texture_data.size
	local widget = self.widgets_by_name.upgrade_button_widget
	widget.content.progress_input_icon = button_texture
end

ForgeUpgradeUI.on_gamepad_deactivated = function (self)
	return
end

ForgeUpgradeUI.set_active = function (self, active)
	self.active = active
	local widget = self.widgets_by_name.upgrade_button_widget

	if self.charging or widget.content.show_cancel_text then
		local force_cancel = true

		self:abort_charge_progress(force_cancel)
	end
end

return
