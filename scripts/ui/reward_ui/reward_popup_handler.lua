local popup_definition = local_require("scripts/ui/reward_ui/reward_popup_definition_01")
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
RewardPopupHandler = class(RewardPopupHandler)
RewardPopupHandler.init = function (self, input_manager, ui_renderer, wait_time_after_animation, service_input_name, wait_for_player_continue)
	self.input_manager = input_manager
	local world_manager = Managers.world
	local ui_world_name = "ingame_view"
	local ui_world = world_manager.world(world_manager, ui_world_name)
	self.ui_world = ui_world
	local world = world_manager.world(world_manager, "level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.ui_renderer = ui_renderer
	self.ui_animations = {}

	self.create_ui_elements(self)

	self.service_input_name = service_input_name
	self.wait_time_after_animation = wait_time_after_animation
	self.wait_for_player_continue = wait_for_player_continue

	return 
end
RewardPopupHandler.create_ui_elements = function (self)
	self.popup_widget = UIWidget.init(popup_definition.widget_popup)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(popup_definition.scenegraph_definition)
	local widget_definitions = popup_definition.widgets
	self.trait_icon_widgets = {
		UIWidget.init(widget_definitions.trait_button_1),
		UIWidget.init(widget_definitions.trait_button_2),
		UIWidget.init(widget_definitions.trait_button_3),
		UIWidget.init(widget_definitions.trait_button_4)
	}
	self.tooltip_widgets = {
		UIWidget.init(widget_definitions.trait_tooltip_1),
		UIWidget.init(widget_definitions.trait_tooltip_2),
		UIWidget.init(widget_definitions.trait_tooltip_3),
		UIWidget.init(widget_definitions.trait_tooltip_4)
	}
	self.reward_text_widgets = {
		title_text = UIWidget.init(widget_definitions.reward_title_text),
		name_text = UIWidget.init(widget_definitions.reward_name_text),
		type_text = UIWidget.init(widget_definitions.reward_type_text)
	}
	self.hero_icon_widgets = {
		icon = UIWidget.init(widget_definitions.hero_icon),
		tooltip = UIWidget.init(widget_definitions.hero_icon_tooltip)
	}
	self.continue_button_widget = UIWidget.init(widget_definitions.continue_button)
	self.continue_button_widget.content.visible = false
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local trait_widget = self.trait_icon_widgets[i]
		local trait_widget_style = trait_widget.style
		trait_widget_style.texture_id.color[1] = 0
		trait_widget_style.texture_bg_id.color[1] = 0
		trait_widget_style.texture_lock_id.color[1] = 0
	end

	local hero_icon_widgets = self.hero_icon_widgets
	local hero_icon_widget = hero_icon_widgets.icon
	hero_icon_widget.style.texture_id.color[1] = 0

	return 
end
RewardPopupHandler.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
local zero_position = {
	0,
	0,
	996
}
RewardPopupHandler.update = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = (self.draw_tooltips and self.input_manager:get_service(self.service_input_name)) or fake_input_service

	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil

			if name == "animate_reward_info" then
				self.draw_tooltips = true
			end
		end
	end

	local animation_wait_time = self.wait_time_until_complete

	if animation_wait_time then
		animation_wait_time = animation_wait_time - dt

		if animation_wait_time <= 0 then
			self.on_wait_time_complete(self)
		else
			self.wait_time_until_complete = animation_wait_time
		end
	end

	local continue_button_hotspot = self.continue_button_widget.content.button_hotspot

	if continue_button_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if continue_button_hotspot.on_release then
		continue_button_hotspot.on_release = nil
		self.wait_time_until_complete = nil
		self.animation_completed = true
		self.continue_button_widget.content.visible = false
	end

	self.update_animation(self, dt)
	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self.popup_widget)

	if self.display_reward_texts then
		local reward_text_widgets = self.reward_text_widgets

		for key, text_widget in pairs(reward_text_widgets) do
			UIRenderer.draw_widget(ui_renderer, text_widget)
		end

		local trait_icon_widgets = self.trait_icon_widgets
		local number_of_traits_on_item = self.number_of_traits_on_item

		for i = 1, number_of_traits_on_item, 1 do
			local widget = trait_icon_widgets[i]

			UIRenderer.draw_widget(ui_renderer, widget)
		end

		if self.draw_tooltips then
			local tooltip_widgets = self.tooltip_widgets

			for i = 1, number_of_traits_on_item, 1 do
				local widget = tooltip_widgets[i]

				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end

		local hero_icon_widgets = self.hero_icon_widgets

		for key, widget in pairs(hero_icon_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end

		UIRenderer.draw_widget(ui_renderer, self.continue_button_widget)
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
RewardPopupHandler.destroy = function (self)
	self.ui_renderer = nil

	return 
end
RewardPopupHandler.start_animation = function (self, reward_item_key)
	self.animation_completed = nil
	self.wait_time_until_complete = nil

	self.play_sound(self, "hud_dice_game_unlock_item")

	self.draw_tooltips = nil
	local item = ItemMasterList[reward_item_key]

	self.set_reward_display_info(self, reward_item_key)
	self.set_popup_widget_item_info(self, item)

	self.animation_time = 0
	local scenegraph_definition = popup_definition.scenegraph_definition
	local animation_sequence = popup_definition.animation_sequence
	local ui_scenegraph = self.ui_scenegraph
	local widget = self.popup_widget

	for _, animation in pairs(animation_sequence) do
		animation.is_completed = nil

		animation.init(ui_scenegraph, scenegraph_definition, widget)
	end

	self.animate_reward_info(self)

	return 
end
RewardPopupHandler.animate_reward_info = function (self)
	local reward_text_widgets = self.reward_text_widgets
	local name_text_style = reward_text_widgets.name_text.style.text
	local type_text_style = reward_text_widgets.type_text.style.text
	local title_text_style = reward_text_widgets.title_text.style.text
	local hero_icon_widgets = self.hero_icon_widgets
	local hero_icon_widget = hero_icon_widgets.icon
	local trait_icon_widgets = self.trait_icon_widgets
	local animation_name = "animate_reward_info"
	local animation_time = 0.2
	local wait_time = 1.15
	local from = 0
	local to = 255
	name_text_style.text_color[1] = from
	type_text_style.text_color[1] = from
	title_text_style.text_color[1] = from
	hero_icon_widget.style.texture_id.color[1] = from
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local trait_widget = trait_icon_widgets[i]
		local trait_widget_style = trait_widget.style
		trait_widget_style.texture_id.color[1] = from
		trait_widget_style.texture_bg_id.color[1] = from
		trait_widget_style.texture_lock_id.color[1] = from
	end

	local ui_animations = self.ui_animations
	ui_animations[animation_name] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, name_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_2"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, type_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_3"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, title_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_4"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, hero_icon_widget.style.texture_id.color, 1, from, to, animation_time, math.easeInCubic)
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local trait_widget = trait_icon_widgets[i]
		local trait_widget_style = trait_widget.style
		ui_animations[animation_name .. "_trait_icon_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_id.color, 1, from, to, animation_time, math.easeInCubic)
		ui_animations[animation_name .. "_trait_bg_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_bg_id.color, 1, from, to, animation_time, math.easeInCubic)
		ui_animations[animation_name .. "_trait_lock_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_lock_id.color, 1, from, to, animation_time, math.easeInCubic)
	end

	self.display_reward_texts = true

	return 
end
RewardPopupHandler.set_popup_widget_item_info = function (self, item)
	local widget = self.popup_widget
	local widget_content = widget.content
	widget_content.icon = item.inventory_icon
	widget_content.title_text = Localize(item.name)
	local item_rarity = item.rarity
	local rarity_color = Colors.get_color_table_with_alpha(item_rarity, 0)
	widget.style.glow_background.color = rarity_color
	widget.style.icon_frame.color = rarity_color

	return 
end
RewardPopupHandler.set_reward_display_info = function (self, item_key)
	local item = ItemMasterList[item_key]
	local ratity_color = Colors.get_color_table_with_alpha(item.rarity, 0)
	local reward_text_widgets = self.reward_text_widgets
	reward_text_widgets.name_text.content.text = item.display_name
	reward_text_widgets.name_text.style.text.text_color = ratity_color
	reward_text_widgets.type_text.content.text = item.item_type
	reward_text_widgets.type_text.style.text.text_color[1] = 0
	reward_text_widgets.title_text.style.text.text_color[1] = 0
	local hero_icon_widgets = self.hero_icon_widgets
	local hero_icon_widget = hero_icon_widgets.icon
	local hero_tooltip_widget = hero_icon_widgets.tooltip
	local draw_hero_icon = (#item.can_wield == 1 and true) or false

	if draw_hero_icon then
		local key = item.can_wield[1]
		local hero_icon_texture = UISettings.hero_icons.medium[key]
		local hero_icon_tooltip = UISettings.hero_tooltips[key]
		hero_icon_widget.content.texture_id = hero_icon_texture
		hero_tooltip_widget.content.tooltip_text = Localize(hero_icon_tooltip)
	end

	self.draw_hero_icon = draw_hero_icon

	self.set_traits_info(self, item.traits, item.slot_type, item.rarity)

	return 
end
RewardPopupHandler.set_traits_info = function (self, traits, slot_type, rarity)
	local trait_icon_widgets = self.trait_icon_widgets
	local tooltip_widgets = self.tooltip_widgets
	local num_total_traits = ForgeSettings.num_traits
	local number_of_traits_on_item = 0
	local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local is_trinket = slot_type == "trinket"
	local trait_locked = not is_trinket and slot_type ~= "hat"

	for i = 1, num_total_traits, 1 do
		local trait_name = traits and traits[i]
		local trait_widget = trait_icon_widgets[i]
		local tooltip_trait_widget = tooltip_widgets[i]
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = trait_name == nil

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local description_text = BackendUtils.get_trait_description(trait_name, rarity)
				local tooltip_text = Localize(display_name) .. "\n" .. description_text

				if trait_locked or is_trinket then
					if is_trinket then
						tooltip_text = tooltip_text .. "\n" .. tooltip_trait_unique_text
					else
						tooltip_text = tooltip_text .. "\n" .. tooltip_trait_locked_text
					end

					trait_widget_hotspot.locked = trait_locked
					tooltip_trait_widget.style.tooltip_text.last_line_color = Colors.get_color_table_with_alpha("red", 255)
				else
					tooltip_trait_widget.style.tooltip_text.last_line_color = nil
					trait_widget_hotspot.locked = false
				end

				tooltip_trait_widget.content.tooltip_text = tooltip_text
				local icon = trait_template.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_hotspot.is_selected = false
				trait_widget_hotspot.on_pressed = false
				trait_widget_content.use_background = true
				trait_widget_content.use_glow = false
			end

			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	self.number_of_traits_on_item = number_of_traits_on_item

	self.update_trait_alignment(self, number_of_traits_on_item)

	return 
end
RewardPopupHandler.update_trait_alignment = function (self, number_of_traits)
	local ui_scenegraph = self.ui_scenegraph
	local width = 40
	local spacing = 80
	local half_trait_amount = (number_of_traits - 1) * 0.5
	local start_x_position = -((width + spacing) * half_trait_amount)

	for i = 1, number_of_traits, 1 do
		local trait_scenegraph_name = "trait_button_" .. i
		local trait_tooltip_scenegraph_name = "trait_tooltip_" .. i
		local position = ui_scenegraph[trait_scenegraph_name].local_position
		local tooltip_position = ui_scenegraph[trait_tooltip_scenegraph_name].local_position
		position[1] = start_x_position
		tooltip_position[1] = position[1]
		tooltip_position[2] = position[2]
		start_x_position = start_x_position + width + spacing
	end

	local trait_icon_widgets = self.trait_icon_widgets
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local widget = trait_icon_widgets[i]
		widget.content.visible = (i <= number_of_traits and true) or false
	end

	return 
end
RewardPopupHandler.on_wait_time_complete = function (self)
	if self.wait_for_player_continue then
		self.continue_button_widget.content.visible = true
	else
		self.wait_time_until_complete = nil
		self.animation_completed = true
	end

	return 
end
RewardPopupHandler.on_animation_complete = function (self)
	self.wait_time_until_complete = self.wait_time_after_animation

	return 
end
RewardPopupHandler.is_animation_completed = function (self)
	return self.animation_completed
end
RewardPopupHandler.update_animation = function (self, dt)
	local time = self.animation_time

	if time then
		time = time + dt
		local total_time = 2
		local progress = math.min(time / total_time, 1)

		self.update_animation_sequence(self, dt, progress)

		self.animation_time = (progress < 1 and time) or nil

		if not self.animation_time then
			self.on_animation_complete(self)
		end
	end

	return 
end
RewardPopupHandler.update_animation_sequence = function (self, dt, progress)
	local ui_scenegraph = self.ui_scenegraph
	local widget = self.popup_widget
	local scenegraph_definition = popup_definition.scenegraph_definition
	local animation_sequence = popup_definition.animation_sequence

	for _, animation in pairs(animation_sequence) do
		if not animation.is_completed then
			local start_progress = animation.start_progress
			local end_progress = animation.end_progress
			local update = true

			if start_progress then
				if progress < start_progress then
					update = false
				end
			else
				start_progress = 0
			end

			if update then
				end_progress = end_progress - start_progress
				start_progress = progress - start_progress
				local local_progress = math.min(start_progress / end_progress, 1)

				animation.update(ui_scenegraph, scenegraph_definition, widget, progress, local_progress)

				if local_progress == 1 then
					animation.is_completed = true

					animation.on_complete(ui_scenegraph, scenegraph_definition, widget)
				end
			end
		end
	end

	return 
end

return 
