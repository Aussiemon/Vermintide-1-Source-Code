local definitions = local_require("scripts/ui/views/inventory_items_ui_definitions")

require("scripts/ui/views/inventory_items_list")

local SLOT_TYPES = InventorySettings.inventory_slot_types_button_index
local SLOT_INDEX_BY_TYPE = InventorySettings.inventory_slot_button_index_by_type
local NUM_INVENTORY_TYPE_BUTTONS = 4
local slot_button_index = {}

for index, slot in ipairs(InventorySettings.slots_by_inventory_button_index) do
	slot_button_index[index] = slot.type
end

local slot_type_title_names = {
	ranged = "inventory_screen_ranged_weapon_tooltip",
	melee = "inventory_screen_melee_weapon_tooltip",
	hat = "inventory_screen_hat_tooltip",
	trinket = "inventory_screen_trinket_1_tooltip"
}
InventoryItemsUI = class(InventoryItemsUI)
InventoryItemsUI.init = function (self, parent, window_position, page_spacing, animation_definitions, ingame_ui_context)
	self.parent = parent
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.world_manager = ingame_ui_context.world_manager
	self.widget_definitions = definitions.widget_definitions
	self.scenegraph_definition = definitions.scenegraph_definition
	self.scenegraph_definition.page_root.position = window_position
	self.ui_animator = UIAnimator:new(self.scenegraph_definition, animation_definitions)
	self.animation_definitions = animation_definitions
	self.bar_animations = {}
	self.inventory_list_animations = {}
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)

	self.create_ui_elements(self)

	local settings = {
		input_service_name = "inventory_menu",
		use_top_renderer = true,
		num_list_items = 7
	}
	local item_list_position = {
		682,
		-124,
		10
	}
	self.inventory_item_list = InventoryItemsList:new(item_list_position, ingame_ui_context, settings)

	self.inventory_item_list:mark_equipped_items()
	self.inventory_item_list:sort_by_loadout_first()

	return 
end
InventoryItemsUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled

	return 
end
InventoryItemsUI.on_enter = function (self)
	self.set_disable_loadout_items(self, true)

	return 
end
InventoryItemsUI.on_exit = function (self)
	return 
end
InventoryItemsUI.destroy = function (self)
	self.ui_animator = nil

	return 
end
InventoryItemsUI.current_profile_name = function (self)
	return self.inventory_item_list:current_profile_name()
end
InventoryItemsUI.set_disable_loadout_items = function (self, disabled)
	self.inventory_item_list:set_disable_loadout_items(disabled)

	return 
end
InventoryItemsUI.sort_items_by_rarity = function (self, enabled)
	self.inventory_item_list:sort_items_by_rarity(enabled)

	return 
end
InventoryItemsUI.set_selected_hero = function (self, hero)
	self.selected_profile_name = hero

	self.inventory_item_list:set_selected_profile_name(hero)
	self.inventory_item_list:populate_inventory_list()

	return 
end
InventoryItemsUI.set_rarity = function (self, rarity)
	self.inventory_item_list:set_rarity(rarity)
	self.inventory_item_list:populate_inventory_list()

	return 
end
InventoryItemsUI.refresh = function (self, alternate_start_select_index)
	self.inventory_item_list:refresh()

	if alternate_start_select_index then
		self.inventory_list_index_changed = alternate_start_select_index
	end

	return 
end
InventoryItemsUI.refresh_items_status = function (self, alternate_start_select_index)
	self.inventory_item_list:refresh_items_status()

	if alternate_start_select_index then
		self.inventory_list_index_changed = alternate_start_select_index
	end

	return 
end
InventoryItemsUI.is_dragging_started = function (self)
	return self.inventory_item_list:is_dragging_item_started()
end
InventoryItemsUI.is_dragging_item = function (self)
	return self.inventory_item_list:is_dragging_item()
end
InventoryItemsUI.on_dragging_item_stopped = function (self)
	return self.inventory_item_list:on_dragging_item_stopped()
end
InventoryItemsUI.on_item_list_hover = function (self)
	return self.inventory_item_list:on_item_list_hover()
end
InventoryItemsUI.on_item_hover_enter = function (self)
	return self.inventory_item_list:on_item_hover_enter()
end
InventoryItemsUI.on_item_hover_exit = function (self)
	return self.inventory_item_list:on_item_hover_exit()
end
InventoryItemsUI.selected_item = function (self)
	return self.inventory_item_list:selected_item()
end
InventoryItemsUI.select_inventory_type_by_slot = function (self, slot_type, force_update)
	for i = 1, #SLOT_TYPES, 1 do
		if SLOT_TYPES[i] == slot_type then
			self.on_inventory_type_selected(self, i, force_update)

			break
		end
	end

	return 
end
InventoryItemsUI.on_inventory_type_selected = function (self, slot_type, force_update)
	local button_index = (slot_type and SLOT_INDEX_BY_TYPE[slot_type]) or self.selected_inventory_type_index

	if self.selected_inventory_type_index == button_index then
		return 
	end

	slot_type = slot_type or SLOT_TYPES[button_index]
	local inventory_selection_bar_widget = self.inventory_selection_bar_widget
	local inventory_selection_content = inventory_selection_bar_widget.content

	if not force_update and self.selected_inventory_type_index then
		if self.inventory_bar_select_anim_id then
			self.ui_animator:stop_animation(self.inventory_bar_select_anim_id)
		end

		self.ui_animator:start_animation("bar_item_deselect", inventory_selection_bar_widget, self.scenegraph_definition, {
			scenegraph_base = "inventory_selection_bar",
			selected_index = self.selected_inventory_type_index
		})
	end

	for i = 1, NUM_INVENTORY_TYPE_BUTTONS, 1 do
		inventory_selection_content[i].is_selected = i == button_index
	end

	self.selected_inventory_type_index = button_index

	self.inventory_item_list:set_selected_slot_type(slot_type)
	self.inventory_item_list:refresh()

	if not force_update then
		self.inventory_bar_select_anim_id = self.ui_animator:start_animation("bar_item_select", inventory_selection_bar_widget, self.scenegraph_definition, {
			scenegraph_base = "inventory_selection_bar",
			selected_index = button_index
		})
	end

	local title_text = Localize(slot_type_title_names[slot_type])
	self.item_type_display_text.content.text_field = string.upper(title_text)

	return 
end
InventoryItemsUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(self.scenegraph_definition)
	self.background_widgets = {
		definitions.create_simple_texture_widget("items_list_bg", "window_background")
	}
	self.controller_window_highlight = definitions.create_simple_texture_widget("selected_window_glow", "window_background_glow")
	self.inventory_selection_bar_widget = UIWidget.init(definitions.inventory_selection_bar_widget)
	self.item_type_display_text = UIWidget.init(definitions.widget_definitions.item_type_display_text)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
InventoryItemsUI.update = function (self, dt)
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "inventory_menu")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	self.ui_animator:update(dt)

	local inventory_selection_bar_widget = self.inventory_selection_bar_widget
	local inventory_selection_content = inventory_selection_bar_widget.content
	local selected_inventory_type_index = self.selected_inventory_type_index
	self.slot_type_changed = nil

	for i = 1, NUM_INVENTORY_TYPE_BUTTONS, 1 do
		if inventory_selection_content[i].is_selected and i ~= selected_inventory_type_index then
			self.play_sound(self, "Play_hud_next_tab")

			self.slot_type_changed = SLOT_TYPES[i]

			break
		end
	end

	self.update_button_bar_animation(self, inventory_selection_bar_widget, "inventory_selection", dt)

	local inventory_item_list = self.inventory_item_list
	local handle_gamepad = gamepad_active and self.use_gamepad

	inventory_item_list.update(inventory_item_list, dt, handle_gamepad)

	self.inventory_list_index_changed = nil
	self.inventory_list_index_changed = inventory_item_list.inventory_list_index_changed
	self.item_to_equip = nil
	self.item_to_remove = nil
	local item_selected = inventory_item_list.get_pressed_item(inventory_item_list)

	if item_selected then
		local selected_profile_name = self.selected_profile_name

		assert(selected_profile_name, "No selected profile name was set when trying to equip item %s.", item_selected.key)

		if not ScriptBackendItem.is_equipped(item_selected.backend_id, selected_profile_name) then
			self.item_to_equip = item_selected
		else
			self.item_to_remove = item_selected
		end
	end

	if self.is_dragging_started(self) then
		self.play_sound(self, "Play_hud_inventory_pickup_item")
	end

	return 
end
InventoryItemsUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "inventory_menu")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	if gamepad_active and self.use_gamepad then
		UIRenderer.draw_widget(ui_renderer, self.controller_window_highlight)
	end

	for _, widget in ipairs(self.background_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	if not gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.inventory_selection_bar_widget)
	else
		UIRenderer.draw_widget(ui_renderer, self.item_type_display_text)
	end

	UIRenderer.end_pass(ui_renderer)
	self.inventory_item_list:draw(dt)

	return 
end
InventoryItemsUI.on_inventory_item_selected = function (self, index, play_sound)
	return self.inventory_item_list:on_inventory_item_selected(index, play_sound)
end
InventoryItemsUI.index_by_backend_id = function (self, backend_id)
	return self.inventory_item_list:index_by_backend_id(backend_id)
end
InventoryItemsUI.update_button_bar_animation = function (self, widget, widget_name, dt)
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
InventoryItemsUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end
InventoryItemsUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end

return 
