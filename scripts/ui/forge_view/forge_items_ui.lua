local definitions = dofile("scripts/ui/forge_view/forge_items_ui_definitions")

require("scripts/ui/views/inventory_items_list")

ForgeItemsUI = class(ForgeItemsUI)
local character_button_index = {
	"witch_hunter",
	"wood_elf",
	"dwarf_ranger",
	"bright_wizard",
	"empire_soldier"
}
local character_buttons_n = #character_button_index
ForgeItemsUI.init = function (self, parent, position, animation_definitions, ingame_ui_context)
	self.world = ingame_ui_context.world
	self.player_manager = ingame_ui_context.player_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.item_list = {}
	self.widget_definitions = definitions.widget_definitions
	self.scenegraph_definition = definitions.scenegraph_definition
	self.scenegraph_definition.page_root.position = position
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)

	self.create_ui_elements(self)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, animation_definitions)
	local settings = {
		input_service_name = "forge_view",
		use_top_renderer = true,
		num_list_items = 7
	}
	local item_list_position = {
		682,
		-124,
		10
	}
	local inventory_item_list = InventoryItemsList:new(item_list_position, ingame_ui_context, settings)
	self.inventory_item_list = inventory_item_list

	inventory_item_list.mark_equipped_items(inventory_item_list)
	inventory_item_list.tag_all_equipped_items(inventory_item_list)
	inventory_item_list.set_selected_profile_name(inventory_item_list, "all")
	inventory_item_list.set_selected_slot_type(inventory_item_list, "weapons")

	local item_filter = self.item_filter

	inventory_item_list.populate_inventory_list(inventory_item_list, nil, nil, item_filter)

	self.bar_animations = {}

	return 
end
ForgeItemsUI.on_enter = function (self)
	self.inventory_item_list:set_rarity(nil)

	return 
end
ForgeItemsUI.set_gamepad_press_input_enabled = function (self, enabled)
	self.use_gamepad_press_input = enabled

	return 
end
ForgeItemsUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled

	return 
end
ForgeItemsUI.handle_gamepad_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "forge_view")
	local use_gamepad = self.use_gamepad
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	else
		local selected_inventory_type_index = self.selected_inventory_type_index

		if selected_inventory_type_index then
			local new_inventory_type_index = nil

			if input_service.get(input_service, "cycle_next") then
				new_inventory_type_index = math.min(selected_inventory_type_index + 1, character_buttons_n)
				self.controller_cooldown = GamepadSettings.menu_cooldown
			elseif input_service.get(input_service, "cycle_previous") then
				new_inventory_type_index = math.max(selected_inventory_type_index - 1, 1)
				self.controller_cooldown = GamepadSettings.menu_cooldown
			end

			if new_inventory_type_index and new_inventory_type_index ~= selected_inventory_type_index then
				self.gamepad_changed_new_inventory_type_index = new_inventory_type_index
			end
		end
	end

	return 
end
ForgeItemsUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(self.scenegraph_definition)
	self.background_widgets = {
		definitions.create_simple_texture_widget("items_list_bg", "window_background")
	}
	self.inventory_selection_bar_widget = UIWidget.init(definitions.inventory_selection_bar_widget)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
ForgeItemsUI.remove_item = function (self, item_backend_id, ignore_scroll_reset)
	self.inventory_item_list:remove_item(item_backend_id, ignore_scroll_reset)

	return 
end
ForgeItemsUI.setup_list_item_compare_with_character_loadout_items = function (self, profile, slot)
	local loadout_item = BackendUtils.get_loadout_item(profile, slot)

	self.inventory_item_list:set_list_compare_against_item(loadout_item.name)

	return 
end
ForgeItemsUI.select_hero_by_name = function (self, hero, force_update)
	local button_index = nil

	for i = 1, #character_button_index, 1 do
		local character_by_index = character_button_index[i]

		if hero == character_by_index then
			button_index = i

			break
		end
	end

	self.on_hero_index_changed(self, button_index, force_update)

	return 
end
ForgeItemsUI.on_hero_index_changed = function (self, index, force_update)
	local inventory_selection_bar_widget = self.inventory_selection_bar_widget
	local inventory_selection_content = inventory_selection_bar_widget.content

	if self.selected_inventory_type_index then
		if self.inventory_bar_select_anim_id then
			self.ui_animator:stop_animation(self.inventory_bar_select_anim_id)
		end

		self.ui_animator:start_animation("bar_item_deselect", inventory_selection_bar_widget, self.scenegraph_definition, {
			scenegraph_base = "inventory_selection_bar",
			selected_index = self.selected_inventory_type_index
		})
	end

	for i = 1, character_buttons_n, 1 do
		inventory_selection_content[i].is_selected = i == index
	end

	self.selected_inventory_type_index = index
	self.inventory_bar_select_anim_id = self.ui_animator:start_animation("bar_item_select", inventory_selection_bar_widget, self.scenegraph_definition, {
		scenegraph_base = "inventory_selection_bar",
		selected_index = index
	})

	if force_update then
		self.set_selected_hero(self, character_button_index[index])
	else
		self.character_changed = character_button_index[index]
	end

	return 
end
ForgeItemsUI.set_selected_slot_type = function (self, slot_type)
	local selected_slot_type = self.inventory_item_list.selected_slot_type

	if not selected_slot_type or selected_slot_type ~= slot_type then
		self.inventory_item_list:set_selected_slot_type(slot_type)
		self.refresh(self)
		self.on_inventory_item_selected(self, 1)

		return true
	end

	return 
end
ForgeItemsUI.current_profile_name = function (self)
	return self.inventory_item_list:current_profile_name()
end
ForgeItemsUI.set_selected_hero = function (self, hero)
	self.inventory_item_list:set_selected_profile_name(hero)

	local item_filter = self.item_filter

	self.inventory_item_list:populate_inventory_list(nil, nil, item_filter)
	self.on_inventory_item_selected(self, 1)

	self.character_changed = nil

	return 
end
ForgeItemsUI.set_rarity = function (self, rarity)
	self.inventory_item_list:set_rarity(rarity)

	return 
end
ForgeItemsUI.set_item_filter = function (self, item_filter)
	self.item_filter = item_filter

	return 
end
ForgeItemsUI.set_accepted_rarities = function (self, rarity_list)
	self.inventory_item_list:set_accepted_rarities(rarity_list)

	return 
end
ForgeItemsUI.clear_disabled_backend_ids = function (self)
	self.inventory_item_list:clear_disabled_backend_ids()

	return 
end
ForgeItemsUI.set_backend_id_disabled_state = function (self, backend_id, disabled)
	self.inventory_item_list:set_backend_id_disabled_state(backend_id, disabled)

	return 
end
ForgeItemsUI.refresh = function (self, ignore_scroll_reset)
	local item_filter = self.item_filter

	self.inventory_item_list:refresh(ignore_scroll_reset, nil, item_filter)

	return 
end
ForgeItemsUI.refresh_items_status = function (self)
	self.inventory_item_list:refresh_items_status()

	return 
end
ForgeItemsUI.set_disable_loadout_items = function (self, disabled)
	self.inventory_item_list:set_disable_loadout_items(disabled)

	return 
end
ForgeItemsUI.set_disable_non_trait_items = function (self, enabled)
	self.inventory_item_list:set_disable_non_trait_items(enabled)

	return 
end
ForgeItemsUI.update = function (self, dt)
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "forge_view")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	if gamepad_active then
		self.handle_gamepad_input(self, dt)
	end

	self.ui_animator:update(dt)

	local inventory_selection_bar_widget = self.inventory_selection_bar_widget
	local inventory_selection_content = inventory_selection_bar_widget.content
	local selected_inventory_type_index = self.selected_inventory_type_index
	self.character_changed = nil

	for i = 1, character_buttons_n, 1 do
		if (inventory_selection_content[i].is_selected or self.gamepad_changed_new_inventory_type_index == i) and i ~= selected_inventory_type_index then
			self.play_sound(self, "Play_hud_next_tab")
			self.on_hero_index_changed(self, i)

			break
		end
	end

	self.update_button_bar_animation(self, inventory_selection_bar_widget, "character_selection", dt)

	local handle_gamepad = gamepad_active and self.use_gamepad
	local inventory_item_list = self.inventory_item_list

	inventory_item_list.update(inventory_item_list, dt, handle_gamepad, self.use_gamepad_press_input)

	self.item_selected = inventory_item_list.item_selected

	if self.is_dragging_started(self) then
		self.play_sound(self, "Play_hud_inventory_pickup_item")
	end

	self.gamepad_changed_new_inventory_type_index = nil

	return 
end
ForgeItemsUI.is_list_item_pressed = function (self)
	local inventory_item_list = self.inventory_item_list
	local inventory_list_index_pressed = inventory_item_list.inventory_list_index_pressed

	if inventory_list_index_pressed then
		local item = inventory_item_list.item_by_index(inventory_item_list, inventory_list_index_pressed)

		return item, inventory_list_index_pressed
	end

	return 
end
ForgeItemsUI.current_selected_list_index = function (self)
	return self.inventory_item_list.selected_list_index
end
ForgeItemsUI.selected_item = function (self)
	return self.inventory_item_list:selected_item()
end
ForgeItemsUI.has_list_index_changed = function (self)
	return self.inventory_item_list.inventory_list_index_changed
end
ForgeItemsUI.on_inventory_item_selected = function (self, index, play_sound)
	return self.inventory_item_list:on_inventory_item_selected(index, play_sound)
end
ForgeItemsUI.index_by_backend_id = function (self, backend_id)
	return self.inventory_item_list:index_by_backend_id(backend_id)
end
ForgeItemsUI.set_list_item_select_sound = function (self, sound_event)
	self.inventory_item_list:set_list_item_select_sound(sound_event)

	return 
end
ForgeItemsUI.is_dragging_started = function (self)
	return self.inventory_item_list:is_dragging_item_started()
end
ForgeItemsUI.is_dragging_item = function (self)
	return self.inventory_item_list:is_dragging_item()
end
ForgeItemsUI.on_dragging_item_stopped = function (self)
	return self.inventory_item_list:on_dragging_item_stopped()
end
ForgeItemsUI.on_item_list_hover = function (self)
	return self.inventory_item_list:on_item_list_hover()
end
ForgeItemsUI.on_item_hover_enter = function (self)
	return self.inventory_item_list:on_item_hover_enter()
end
ForgeItemsUI.on_item_hover_exit = function (self)
	return self.inventory_item_list:on_item_hover_exit()
end
ForgeItemsUI.set_drag_enabled = function (self, enabled)
	self.inventory_item_list:set_drag_enabled(enabled)

	return 
end
ForgeItemsUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "forge_view")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	for _, widget in ipairs(self.background_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.inventory_selection_bar_widget)
	UIRenderer.end_pass(ui_renderer)
	self.inventory_item_list:draw(dt)

	return 
end
ForgeItemsUI.update_button_bar_animation = function (self, widget, widget_name, dt)
	local content = widget.content
	local style = widget.style
	local bar_settings = UISettings.inventory.button_bars
	local bar_animations = self.bar_animations

	if not bar_animations[widget_name] then
		bar_animations[widget_name] = {}
	end

	for i = 1, #content, 1 do
		local button_style_name = string.format("button_style_%d", i)
		local icon_texture_id = string.format("icon_%d", i)
		local button_click_style_name = string.format("button_click_style_%d", i)
		local icon_click_texture_id = string.format("icon_click_%d", i)
		local button_style = style[button_style_name]
		local icon_style = style[icon_texture_id]
		local active_animations = bar_animations[widget_name][i] or {}
		local button_hotspot = content[i]
		local is_selected = content[i].is_selected

		if not is_selected and button_hotspot.on_hover_enter then
			self.play_sound(self, "Play_hud_hover")

			local background_fade_in_time = bar_settings.background.fade_in_time
			local icon_fade_in_time = bar_settings.icon.fade_in_time
			local background_alpha_hover = bar_settings.background.alpha_hover
			local icon_alpha_hover = bar_settings.icon.alpha_hover
			active_animations[button_style_name] = self.animate_element_by_time(self, button_style.color, 1, button_style.color[1], background_alpha_hover, background_fade_in_time)
			active_animations[icon_texture_id] = self.animate_element_by_time(self, icon_style.color, 1, icon_style.color[1], icon_alpha_hover, icon_fade_in_time)
		elseif button_hotspot.on_hover_exit then
			local background_fade_out_time = bar_settings.background.fade_out_time
			local icon_fade_out_time = bar_settings.icon.fade_out_time
			local background_alpha_normal = bar_settings.background.alpha_normal
			local icon_alpha_normal = bar_settings.icon.alpha_normal
			active_animations[button_style_name] = self.animate_element_by_time(self, button_style.color, 1, button_style.color[1], background_alpha_normal, background_fade_out_time)
			active_animations[icon_texture_id] = self.animate_element_by_time(self, icon_style.color, 1, icon_style.color[1], icon_alpha_normal, icon_fade_out_time)
		end

		if active_animations then
			for name, animation in pairs(active_animations) do
				UIAnimation.update(animation, dt)

				if UIAnimation.completed(animation) then
					animation = nil
					self.bar_animations[widget_name][i] = nil
				end
			end
		end

		self.bar_animations[widget_name][i] = active_animations
	end

	return 
end
ForgeItemsUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end
ForgeItemsUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
ForgeItemsUI.destroy = function (self)
	self.ui_animator = nil

	return 
end

return 
