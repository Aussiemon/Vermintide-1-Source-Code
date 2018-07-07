local definitions = local_require("scripts/ui/views/inventory_items_list_definitions")
local animation_definitions = local_require("scripts/ui/views/inventory_view_animation_definitions")
local setup_mouse_scroll_widget_definition = definitions.setup_mouse_scroll_widget_definition
local create_empty_inventory_item_template = definitions.create_empty_inventory_item_template
local create_inventory_item_template = definitions.create_inventory_item_template
local set_item_element_info = definitions.set_item_element_info
local element_settings = definitions.element_settings
local scrollbar_width = definitions.scrollbar_width

local function setup_list_hover_area(width, height)
	local list_definition = definitions.widget_definitions.inventory_list_widget
	local hover_pass = list_definition.element.passes[2]
	local hover_style_definition = list_definition.style.hover
	local size = hover_style_definition.size
	local offset = hover_style_definition.offset
	size[1] = width
	size[2] = height
	offset[2] = 0
end

local function create_item_data(item)
	local data = {}
	local trait_data = nil
	local traits = item.traits

	if traits then
		local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
		local tooltip_trait_unique_text = Localize("unique_trait_description")
		local slot_type = item.slot_type
		local is_trinket = slot_type == "trinket"
		local never_locked = is_trinket or slot_type == "hat"

		for i = #traits, 1, -1 do
			local trait_name = traits[i]
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local backend_id = item.backend_id
				local trait_unlocked = ((never_locked or BackendUtils.item_has_trait(backend_id, trait_name)) and true) or false
				local title_text = (trait_template.display_name and Localize(trait_template.display_name)) or "Unknown"
				local description_text = BackendUtils.get_item_trait_description(backend_id, i)
				local tooltip_text = title_text .. "\n" .. description_text

				if is_trinket then
					tooltip_text = tooltip_text .. "\n" .. tooltip_trait_unique_text
				elseif not trait_unlocked then
					tooltip_text = tooltip_text .. "\n" .. tooltip_trait_locked_text
				end

				trait_data = trait_data or {}
				trait_data[#trait_data + 1] = {
					unlocked = trait_unlocked,
					title = title_text,
					tooltip = tooltip_text,
					texture = trait_template.icon or "icons_placeholder"
				}
			end
		end
	end

	local item_rarity = item.rarity
	local item_color = self:get_rarity_color(item_rarity)
	data.item = item
	data.rarity = item_rarity
	data.item_color = item_color
	data.trait_data = trait_data
	data.locked_text = ""
	data.icon = item.inventory_icon or "icons_placeholder"
	data.title = (item.name and item.localized_name) or "Unknown"
	data.sub_title = (item.item_type and Localize(item.item_type)) or "Unknown"
	data.description = (item.description and Localize(item.description)) or "Unknown"

	return data
end

local SLOT_TYPES = InventorySettings.inventory_slot_types_button_index
local index_by_stats_type = {
	damage = 1,
	armor_penetration = 2,
	elemental_effect = 5,
	status_effect = 3,
	head_shot = 4
}
local compare_state_textures = {
	equal = "stats_equal",
	up = {
		"stats_arrow_01",
		"stats_arrow_02",
		"stats_arrow_03"
	},
	down = {
		"stats_arrow_04",
		"stats_arrow_05",
		"stats_arrow_06"
	}
}
local compare_state_colors = {
	up = {
		255,
		0,
		255,
		0
	},
	down = {
		255,
		255,
		0,
		0
	},
	equal = {
		255,
		255,
		255,
		255
	}
}
local temp_stats = {
	damage = {
		3,
		1,
		1,
		0,
		0
	},
	armor_penetration = {
		2,
		0,
		0,
		0,
		0
	},
	status_effect = {
		1,
		2,
		3,
		0,
		0
	},
	head_shot = {
		1,
		0,
		0,
		0,
		0
	},
	elemental_effect = {
		1,
		2,
		0,
		0,
		0
	}
}
local possible_quick_compare_slots = {
	melee = "slot_melee",
	ranged = "slot_ranged"
}
local rarity_order = {
	common = 4,
	promo = 6,
	plentiful = 5,
	exotic = 2,
	rare = 3,
	unique = 1
}

local function rarity_sortation(a, b)
	return rarity_order[a.rarity] < rarity_order[b.rarity]
end

local function sort_by_loadout_rarity_name(a, b)
	if a.equipped and not b.equipped then
		return true
	elseif b.equipped and not a.equipped then
		return false
	else
		local a_rarity_order = rarity_order[a.rarity]
		local b_rarity_order = rarity_order[b.rarity]

		if a_rarity_order == b_rarity_order then
			local a_name = a.localized_name
			local b_name = b.localized_name

			if a_name == b_name then
				return a.backend_id < b.backend_id
			end

			return a_name < b_name
		else
			return a_rarity_order < b_rarity_order
		end
	end
end

local function sort_by_rarity_name(a, b)
	local a_rarity_order = rarity_order[a.rarity]
	local b_rarity_order = rarity_order[b.rarity]

	if a_rarity_order == b_rarity_order then
		local a_name = a.localized_name
		local b_name = b.localized_name

		if a_name == b_name then
			return a.backend_id < b.backend_id
		end

		return a_name < b_name
	else
		return a_rarity_order < b_rarity_order
	end
end

local fake_input_service = {
	get = function ()
		return
	end,
	has = function ()
		return
	end
}
InventoryItemsList = class(InventoryItemsList)

InventoryItemsList.init = function (self, position, ingame_ui_context, settings)
	self.ui_renderer = ingame_ui_context.ui_top_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	local num_list_items = settings.num_list_items
	local columns = settings.columns
	local column_offset = settings.column_offset
	self.disabled_backend_ids = {}

	if settings.use_top_renderer then
		self.ui_renderer = ingame_ui_context.ui_top_renderer
	else
		self.ui_renderer = ingame_ui_context.ui_renderer
	end

	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	local scenegraph_definition = definitions.scenegraph_definition
	local item_list_definitions = scenegraph_definition.item_list
	local scroll_field_width = 0
	local scroll_field_height = 0

	if columns then
		item_list_definitions.size[1] = element_settings.width * columns + column_offset
		local list_items_per_column = num_list_items / columns
		item_list_definitions.size[2] = element_settings.height * list_items_per_column + element_settings.height_spacing * (list_items_per_column - 1)
		scroll_field_width = item_list_definitions.size[1] + scrollbar_width
		scroll_field_height = item_list_definitions.size[2]
	else
		item_list_definitions.size[1] = element_settings.width
		item_list_definitions.size[2] = element_settings.height * num_list_items + element_settings.height_spacing * (num_list_items - 1)
		scroll_field_width = item_list_definitions.size[1]
		scroll_field_height = item_list_definitions.size[2]
	end

	settings.list_size = {
		item_list_definitions.size[1],
		item_list_definitions.size[2]
	}

	setup_mouse_scroll_widget_definition(scroll_field_width, scroll_field_height)
	setup_list_hover_area(scroll_field_width, scroll_field_height)

	self.settings = settings
	self.widget_definitions = definitions.widget_definitions
	scenegraph_definition.page_root.position = position
	self.ui_animator = UIAnimator:new(scenegraph_definition, animation_definitions)
	self.bar_animations = {}
	self.inventory_list_animations = {}
	self.scenegraph_definition = scenegraph_definition
	self.input_service_name = settings.input_service_name

	self:set_list_item_select_sound("Play_hud_select")
	self:create_ui_elements()

	local item_widget_elements = {}

	for i = 1, 8, 1 do
		local content, style = create_inventory_item_template()
		item_widget_elements[i] = {
			content = content,
			style = style
		}
	end

	self.item_widget_elements = item_widget_elements
	local empty_widget_elements = {}

	for i = 1, 8, 1 do
		local content, style = create_empty_inventory_item_template()
		empty_widget_elements[i] = {
			content = content,
			style = style
		}
	end

	self.empty_widget_elements = empty_widget_elements
end

InventoryItemsList.destroy = function (self)
	self.ui_animator:destroy()

	self.ui_animator = nil
end

InventoryItemsList.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(self.scenegraph_definition)
	local scrollbar_scenegraph_id = "item_list_scrollbar_root"
	local scrollbar_scenegraph = self.scenegraph_definition[scrollbar_scenegraph_id]
	self.scrollbar_widget = UIWidget.init(UIWidgets.create_scrollbar(scrollbar_scenegraph.size[2], scrollbar_scenegraph_id))
	self.item_list_widget = UIWidget.init(self.widget_definitions.inventory_list_widget)
	self.scroll_field_widget = UIWidget.init(self.widget_definitions.scroll_field)
	self.gamepad_slot_selection_widget = UIWidget.init(self.widget_definitions.gamepad_slot_selection)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
end

InventoryItemsList.handle_gamepad_input = function (self, dt, num_elements)
	local input_manager = self.input_manager
	local input_service = (self.input_disabled and fake_input_service) or input_manager:get_service(self.input_service_name)
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and controller_cooldown > 0 then
		self.controller_cooldown = controller_cooldown - dt
		local speed_multiplier = self.speed_multiplier or 1
		local decrease = 0.005
		local min_multiplier = 0
		self.speed_multiplier = math.max(speed_multiplier - decrease, min_multiplier)

		return
	else
		local selected_absolute_list_index = self.selected_absolute_list_index

		if selected_absolute_list_index then
			local speed_multiplier = self.speed_multiplier or 1
			local new_list_index = nil
			local move_up = input_service:get("move_up")
			local move_up_hold = input_service:get("move_up_hold")

			if move_up or move_up_hold then
				new_list_index = math.max(selected_absolute_list_index - 1, 1)
				self.controller_cooldown = GamepadSettings.menu_cooldown * speed_multiplier
			else
				local move_down = input_service:get("move_down")
				local move_down_hold = input_service:get("move_down_hold")

				if move_down or move_down_hold then
					self.controller_cooldown = GamepadSettings.menu_cooldown * speed_multiplier
					new_list_index = math.min(selected_absolute_list_index + 1, num_elements)
				end
			end

			if new_list_index and new_list_index ~= selected_absolute_list_index then
				self.gamepad_changed_selected_list_index = new_list_index

				return
			end
		end
	end

	self.speed_multiplier = 1
end

InventoryItemsList.update_gamepad_list_scroll = function (self)
	local selected_absolute_list_index = self.selected_absolute_list_index

	if not selected_absolute_list_index then
		return
	end

	local is_outside, state = self:is_entry_outside(selected_absolute_list_index)

	while is_outside do
		local button_scroll_step = self.scrollbar_widget.content.button_scroll_step
		local scroll_value = self.scroll_value

		if state == "below" then
			scroll_value = math.min(scroll_value + button_scroll_step, 1)
		else
			scroll_value = math.max(scroll_value - button_scroll_step, 0)
		end

		if scroll_value ~= self.scroll_value then
			self:set_scroll_amount(scroll_value)
		end

		is_outside, state = self:is_entry_outside(self.selected_absolute_list_index)
	end
end

InventoryItemsList.update = function (self, dt, use_gamepad, disable_gamepad_pressed)
	local input_manager = self.input_manager
	local input_service = (self.input_disabled and fake_input_service) or input_manager:get_service(self.input_service_name)

	self.ui_animator:update(dt)

	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local list_style = item_list_widget.style.list_style
	local selected_list_index = self.selected_list_index
	local hover_list_index = self.hover_list_index
	local number_of_items_in_list = self.number_of_items_in_list
	self.inventory_list_index_changed = nil
	self.inventory_list_index_pressed = nil
	local num_list_content = #list_content

	if use_gamepad then
		local number_of_real_items = self.number_of_real_items

		if number_of_real_items then
			self:handle_gamepad_input(dt, number_of_real_items)
			self:update_gamepad_list_scroll()
		end
	end

	local hover_index, hover_backend_id = self:on_item_hover_exit()

	if hover_index and hover_backend_id then
		local widget_content = list_content[hover_index]

		if widget_content and widget_content.new then
			widget_content.new = false

			ItemHelper.unmark_backend_id_as_new(hover_backend_id)
		end
	end

	local list_start_index = list_style.list_start_index
	local selected_list_index = self.selected_list_index
	local selected_absolute_list_index = self.selected_absolute_list_index
	local gamepad_changed_selected_list_index = self.gamepad_changed_selected_list_index

	if gamepad_changed_selected_list_index then
		if gamepad_changed_selected_list_index ~= selected_absolute_list_index then
			self.inventory_list_index_changed = gamepad_changed_selected_list_index
			local widget_content = list_content[selected_list_index]

			if widget_content and widget_content.new then
				local selected_content_item = widget_content.item

				if selected_content_item then
					local backend_id = selected_content_item.backend_id
					widget_content.new = false

					ItemHelper.unmark_backend_id_as_new(backend_id)
				end
			end
		end
	else
		for i = 1, num_list_content, 1 do
			local button_content = list_content[i]
			local button_hotspot = button_content.button_hotspot
			local relative_index = i - 1

			if button_hotspot.is_selected and i ~= selected_list_index then
				self.inventory_list_index_changed = list_start_index + relative_index

				break
			end
		end
	end

	for i = 1, num_list_content, 1 do
		local content = list_content[i]
		local button_hotspot = content.button_hotspot

		if button_hotspot.on_pressed and content.active then
			local relative_index = i - 1
			self.inventory_list_index_pressed = list_start_index + relative_index

			break
		end
	end

	self.item_selected = nil
	self.item_selected_local = nil
	self.item_selected_is_equipped = nil

	for i = 1, #list_content, 1 do
		local button_widget_content = list_content[i]
		local button_hotspot = button_widget_content.button_hotspot
		local is_equipped = button_widget_content.equipped
		local is_active = button_widget_content.active
		local is_fake = button_widget_content.fake

		if not is_fake and ((button_hotspot.is_selected and button_hotspot.on_double_click) or button_hotspot.on_right_click or (use_gamepad and i == selected_list_index and not disable_gamepad_pressed and input_service:get("confirm"))) then
			local item = button_widget_content.item

			if is_active then
				self.item_selected = item
				self.item_selected_is_equipped = is_equipped
			end

			self.item_selected_local = item

			break
		end
	end

	if Debug.select_item then
		local i = Debug.select_item
		local button_widget_content = list_content[i]
		local is_equipped = button_widget_content.equipped
		local is_active = button_widget_content.active
		local is_fake = button_widget_content.fake

		if is_active then
			self.item_selected = button_widget_content.item
			self.item_selected_is_equipped = is_equipped
		end

		self.item_selected_local = button_widget_content.item
		Debug.select_item = nil
	end

	for i = 1, num_list_content, 1 do
		local button_content = list_content[i]
		local button_hotspot = button_content.button_hotspot

		if button_hotspot.on_hover_enter then
			if not button_content.fake then
				self:play_sound("Play_hud_hover")
			end

			if i ~= hover_list_index then
				self.hover_list_index = i
			end

			button_hotspot.on_hover_enter = nil
		elseif button_hotspot.on_hover_exit then
			if i == hover_list_index then
				self.hover_list_index = nil
			end

			button_hotspot.on_hover_exit = nil
		end
	end

	self:on_item_dragged()
	self:update_scroll()

	if self.inventory_list_animation_time then
	end

	self.gamepad_changed_selected_list_index = nil
end

InventoryItemsList.draw = function (self, dt, use_gamepad)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = (self.input_disabled and fake_input_service) or input_manager:get_service(self.input_service_name)
	local gamepad_active = input_manager:is_device_active("gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	local item_list_widget = self.item_list_widget

	if self.draw_inventory_list then
		UIRenderer.draw_widget(ui_renderer, self.scroll_field_widget)
		UIRenderer.draw_widget(ui_renderer, self.item_list_widget)
		UIRenderer.draw_widget(ui_renderer, self.scrollbar_widget)

		if use_gamepad and gamepad_active then
			UIRenderer.draw_widget(ui_renderer, self.gamepad_slot_selection_widget)
		end
	end

	UIRenderer.end_pass(ui_renderer)
end

InventoryItemsList.disable_input = function (self, disable)
	self.input_disabled = disable
end

InventoryItemsList.get_pressed_item = function (self)
	return self.item_selected_local
end

InventoryItemsList.set_list_item_select_sound = function (self, sound_event)
	self.item_select_sound_event = sound_event
end

InventoryItemsList.set_selected_profile_name = function (self, selected_profile_name)
	self.selected_profile_name = selected_profile_name
	self.inventory_list_animation_time = 0
end

InventoryItemsList.current_profile_name = function (self)
	return self.selected_profile_name
end

InventoryItemsList.set_selected_slot_type = function (self, selected_slot_type)
	self.selected_slot_type = selected_slot_type
	self.inventory_list_animation_time = 0
end

InventoryItemsList.refresh = function (self, ignore_scroll_reset, backend_id_ignore_list, optional_filter)
	self:populate_inventory_list(ignore_scroll_reset, backend_id_ignore_list, optional_filter)

	self.inventory_list_animation_time = 0
end

InventoryItemsList.remove_item = function (self, item_backend_id, ignore_scroll_reset)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local items = self.stored_items
	local list_style = item_list_widget.style.list_style
	local item_styles = list_style.item_styles
	local column_count = list_style.columns
	local start_index = list_style.start_index
	local num_draws = list_style.num_draws
	local list_start_index = list_style.list_start_index

	if not ignore_scroll_reset then
		list_start_index = 1
	end

	local selected_absolute_list_index = self.selected_absolute_list_index

	for i = 1, #items, 1 do
		local item = items[i]

		if item and item.backend_id == item_backend_id then
			table.remove(items, i)

			local num_items = #items
			local number_of_items_in_list = math.max(self.number_of_items_in_list - 1, 0)
			self.number_of_items_in_list = number_of_items_in_list
			self.number_of_real_items = self.number_of_real_items - 1

			if number_of_items_in_list <= 0 then
				self.draw_inventory_list = false

				break
			end

			local selected_list_index = self.selected_list_index
			local move_scroll = false

			if num_draws > num_items - (list_start_index - 1) then
				list_style.list_start_index = math.max(list_start_index - 1, 1)

				if list_start_index > 1 then
					selected_absolute_list_index = math.max(selected_absolute_list_index - 1, 1)
				end

				move_scroll = true
			elseif list_start_index > 1 then
				move_scroll = true
			end

			self.selected_absolute_list_index = selected_absolute_list_index
			local new_list_start_index = (not ignore_scroll_reset and 1) or nil

			self:populate_widget_list(new_list_start_index)

			local widget_scroll_bar_info = self.scrollbar_widget.content.scroll_bar_info
			local previous_bar_fraction = widget_scroll_bar_info.bar_height_percentage

			self:set_scrollbar_length(nil, ignore_scroll_reset, ignore_scroll_reset)

			local new_bar_fraction = widget_scroll_bar_info.bar_height_percentage
			local bar_fraction_difference = new_bar_fraction - previous_bar_fraction

			if move_scroll then
				local button_scroll_step = self.scrollbar_widget.content.button_scroll_step
				local scroll_value = self.scroll_value
				scroll_value = math.max(math.min(scroll_value + bar_fraction_difference, 1), 0)
				local ignore_list_scroll = true

				self:set_scroll_amount(scroll_value, ignore_list_scroll)
			end

			break
		end
	end
end

InventoryItemsList.clear_disabled_backend_ids = function (self)
	self.disabled_backend_ids = {}
end

InventoryItemsList.set_backend_id_disabled_state = function (self, backend_id, disabled)
	self.disabled_backend_ids[backend_id] = disabled

	self:set_item_active_by_backend_id(backend_id, not disabled)
end

InventoryItemsList.set_item_active_by_backend_id = function (self, backend_id, active)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local selected_profile_name = self.selected_profile_name
	local selected_slot_type = self.selected_slot_type
	local selected_rarity = self.selected_rarity
	local disable_equipped_items = self.disable_equipped_items

	if selected_profile_name and selected_slot_type then
		self.item_active_list[backend_id] = active

		for i = 1, #list_content, 1 do
			local widget_content = list_content[i]

			if widget_content then
				local item = widget_content.item

				if item and item.backend_id == backend_id then
					widget_content.allow_equipped_drag = not disable_equipped_items
					local is_active = true
					local item_slot_type = item.slot_type
					local slot_names = InventorySettings.slot_names_by_type[item_slot_type]
					local item_equipped = false

					for k = 1, #slot_names, 1 do
						local slot_name = slot_names[k]
						local equipped_slot_item = BackendUtils.get_loadout_item(selected_profile_name, slot_name)

						if equipped_slot_item and equipped_slot_item.backend_id == item.backend_id then
							item_equipped = true

							break
						end
					end

					if (selected_rarity and item.rarity ~= selected_rarity) or (disable_equipped_items and item_equipped) then
						is_active = false
					end

					if is_active and self.disable_non_trait_items then
						local item_traits = item.traits

						if not item_traits or #item_traits < 1 then
							is_active = false
						end
					end

					if active and not is_active then
						return
					end

					widget_content.active = active

					break
				end
			end
		end
	end
end

InventoryItemsList.set_drag_enabled = function (self, enabled)
	local drag_disabled = not enabled
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local selected_profile_name = self.selected_profile_name
	local selected_slot_type = self.selected_slot_type

	if selected_profile_name and selected_slot_type then
		for i = 1, #list_content, 1 do
			local widget_content = list_content[i]

			if widget_content then
				local item = widget_content.item

				if item then
					widget_content.drag_disabled = drag_disabled
				end
			end
		end
	end
end

InventoryItemsList.set_rarity = function (self, rarity)
	self.selected_rarity = rarity

	self:refresh_items_status()
end

InventoryItemsList.sort_items_by_rarity = function (self, enabled)
	self.sort_by_rarity = enabled
end

InventoryItemsList.on_item_list_hover = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		return item_list_widget.content.internal_is_hover
	end
end

InventoryItemsList.on_item_hover_enter = function (self)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content

	for i = 1, #list_content, 1 do
		local button_content = list_content[i]
		local button_hotspot = button_content.button_hotspot

		if button_hotspot.on_hover_enter then
			local item = button_content.item

			return i, item and item.backend_id
		end
	end
end

InventoryItemsList.on_item_hover_exit = function (self)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content

	for i = 1, #list_content, 1 do
		local button_content = list_content[i]
		local button_hotspot = button_content.button_hotspot

		if button_hotspot.on_hover_exit then
			local item = button_content.item

			return i, item and item.backend_id
		end
	end
end

InventoryItemsList.is_dragging_item = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content

		for i = 1, #list_content, 1 do
			local ui_content = list_content[i]

			if ui_content.is_dragging then
				return true
			end
		end
	end
end

InventoryItemsList.is_dragging_item_started = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content

		for i = 1, #list_content, 1 do
			local ui_content = list_content[i]

			if ui_content.on_drag_started then
				return true
			end
		end
	end
end

InventoryItemsList.on_dragging_item_stopped = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content

		for i = 1, #list_content, 1 do
			local ui_content = list_content[i]

			if ui_content.on_drag_stopped or ui_content.is_dragging then
				return ui_content.on_drag_stopped, ui_content.item
			end
		end
	end
end

InventoryItemsList.on_item_dragged = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content
		local item_styles = item_list_widget.style.list_style.item_styles

		for i = 1, #list_content, 1 do
			local ui_content = list_content[i]
			local ui_style = item_styles[i]
			local icon_color = ui_style.item_texture_id.color
			local icon_frame_color = ui_style.item_frame_texture_id.color

			if ui_content.is_dragging and icon_color[1] ~= 150 then
				icon_color[1] = 150
				icon_frame_color[1] = 150
			elseif ui_content.on_drag_stopped and icon_color[1] ~= 255 then
				icon_color[1] = 255
				icon_frame_color[1] = 255
			end
		end
	end
end

InventoryItemsList.deselect_all_list_items = function (self)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local num_list_content = #list_content

	for i = 1, num_list_content, 1 do
		local button_hotspot = list_content[i].button_hotspot
		button_hotspot.is_selected = false
		button_hotspot.on_hover_enter = false
		button_hotspot.on_hover_exit = false
		button_hotspot.is_hover = false
	end

	self.selected_list_index = nil
	self.selected_absolute_list_index = nil
end

InventoryItemsList.set_accepted_rarities = function (self, rarity_list)
	self.accepted_rarity_list = rarity_list
end

InventoryItemsList.set_disable_non_trait_items = function (self, enabled)
	self.disable_non_trait_items = enabled
end

InventoryItemsList.mark_equipped_items = function (self)
	self.tag_equipped_items = true
end

InventoryItemsList.tag_all_equipped_items = function (self)
	self._tag_all_equipped_items = true
end

InventoryItemsList.sort_by_loadout_first = function (self)
	self.sort_by_equipment = true
end

InventoryItemsList.set_disable_loadout_items = function (self, disabled)
	self.disable_equipped_items = disabled
end

InventoryItemsList.populate_inventory_list = function (self, ignore_scroll_reset, backend_id_ignore_list, optional_item_filter)
	self:deselect_all_list_items()

	local settings = self.settings
	local selected_profile_name = self.selected_profile_name
	local selected_slot_type = self.selected_slot_type
	local selected_rarity = self.selected_rarity
	local backend_items, items = nil
	local tag_equipped_items = self.tag_equipped_items

	if optional_item_filter then
		backend_items = ScriptBackendItem.get_filtered_items(optional_item_filter)
	elseif type(selected_slot_type) == "table" then
		backend_items = {}

		for index, slot_type_name in ipairs(selected_slot_type) do
			local new_items = (tag_equipped_items and BackendUtils.get_inventory_items(selected_profile_name, slot_type_name)) or BackendUtils.get_inventory_items_except_loadout(selected_profile_name, slot_type_name)

			table.append(backend_items, new_items)
		end
	elseif selected_slot_type == "weapons" then
		local melee_items = (tag_equipped_items and BackendUtils.get_inventory_items(selected_profile_name, "melee")) or BackendUtils.get_inventory_items_except_loadout(selected_profile_name, "melee")
		local ranged_items = (tag_equipped_items and BackendUtils.get_inventory_items(selected_profile_name, "ranged")) or BackendUtils.get_inventory_items_except_loadout(selected_profile_name, "ranged")
		backend_items = {}

		table.append(backend_items, melee_items)
		table.append(backend_items, ranged_items)
	else
		selected_slot_type = selected_slot_type or "melee"
		backend_items = (tag_equipped_items and BackendUtils.get_inventory_items(selected_profile_name, selected_slot_type)) or BackendUtils.get_inventory_items_except_loadout(selected_profile_name, selected_slot_type)
	end

	if backend_items then
		items = {}

		if backend_id_ignore_list then
			for index, item in ipairs(backend_items) do
				local add_item = true

				for i = 1, #backend_id_ignore_list, 1 do
					local backend_id_to_ignore = backend_id_ignore_list[i]

					if backend_id_to_ignore and backend_id_to_ignore == item.backend_id then
						add_item = false

						break
					end
				end

				if add_item then
					items[#items + 1] = item
				end
			end
		else
			items = backend_items
		end
	end

	self:_sync_loadout_items()

	local number_of_items_in_list = (items and #items) or 0
	self.number_of_items_in_list = number_of_items_in_list
	self.draw_inventory_list = number_of_items_in_list > 0
	self.stored_items = items
	local num_item_slots = settings.num_list_items
	local list_start_index = (not ignore_scroll_reset and 1) or nil

	self:populate_widget_list(list_start_index, true)
	self:set_scrollbar_length(nil, ignore_scroll_reset)
end

InventoryItemsList.populate_widget_list = function (self, list_start_index, sort_list)
	local items = self.stored_items

	if items then
		local item_list_widget = self.item_list_widget
		list_start_index = list_start_index or item_list_widget.style.list_style.list_start_index or 1
		local num_items_in_list = #items

		if list_start_index > num_items_in_list then
			return
		end

		self:_sync_item_list_equipped_status(items)

		if sort_list then
			if self.sort_by_equipment then
				table.sort(items, sort_by_loadout_rarity_name)
			else
				table.sort(items, sort_by_rarity_name)
			end
		end

		local settings = self.settings
		local new_backend_ids = ItemHelper.get_new_backend_ids()
		local disable_equipped_items = self.disable_equipped_items
		local accepted_rarity_list = self.accepted_rarity_list
		local disabled_backend_ids = self.disabled_backend_ids
		local tag_equipped_items = self.tag_equipped_items
		local selected_rarity = self.selected_rarity
		local num_item_slots = settings.num_list_items
		local num_draws = num_item_slots
		local list_content = {}
		local list_style = {
			vertical_alignment = "top",
			scenegraph_id = "item_list",
			size = settings.list_size,
			list_member_offset = {
				0,
				-(element_settings.height + element_settings.height_spacing),
				0
			},
			item_styles = {},
			columns = settings.columns,
			column_offset = settings.columns and element_settings.width + settings.column_offset
		}
		local item_active_list = (self.item_active_list and table.clear(self.item_active_list)) or {}
		local index = 1

		for i = list_start_index, (list_start_index + num_draws) - 1, 1 do
			local item = items[i]

			if item then
				local is_equipped = item.equipped
				local is_locked = false
				local is_active = true
				local is_new = false
				local item_rarity = item.rarity
				local item_color = self:get_rarity_color(item_rarity)
				local item_backend_id = item.backend_id

				if new_backend_ids and new_backend_ids[item_backend_id] then
					is_new = true
				end

				if (selected_rarity and item_rarity ~= selected_rarity) or (disable_equipped_items and is_equipped) then
					is_active = false
				end

				if is_active and self.disable_non_trait_items then
					local item_traits = item.traits

					if not item_traits or #item_traits < 1 then
						is_active = false
					end
				end

				if accepted_rarity_list and not accepted_rarity_list[item_rarity] then
					is_active = false
				end

				if disabled_backend_ids[item_backend_id] then
					is_active = is_active and false
				end

				local item_element = self.item_widget_elements[index]

				set_item_element_info(item_element, true, item, item_color, is_equipped, is_new, is_active, is_locked, not disable_equipped_items, self.ui_renderer)

				local content = item_element.content
				local style = item_element.style
				list_content[index] = content
				list_style.item_styles[index] = style
				item_active_list[item_backend_id] = is_active
				index = index + 1
			end
		end

		self.item_active_list = item_active_list
		list_style.start_index = 1
		list_style.list_start_index = list_start_index
		list_style.num_draws = num_draws
		item_list_widget.style.list_style = list_style
		item_list_widget.content.list_content = list_content
		item_list_widget.element.pass_data[1].num_list_elements = nil
		local list_content_n = #list_content
		self.number_of_real_items = num_items_in_list

		if list_content_n < num_draws then
			local padding_n = num_draws - #list_content % num_draws

			if num_draws > padding_n then
				for i = 1, padding_n, 1 do
					local empty_element = self.empty_widget_elements[i]
					local index = #list_content + 1
					list_content[index] = empty_element.content
					list_style.item_styles[index] = empty_element.style
				end

				self.used_empty_elements = padding_n
			end
		end

		local selected_absolute_list_index = self.selected_absolute_list_index

		if selected_absolute_list_index then
			self:on_inventory_item_selected(selected_absolute_list_index)
		end
	end
end

InventoryItemsList.refresh_items_status = function (self)
	self:_sync_loadout_items()
	self:populate_widget_list()
end

InventoryItemsList._sync_loadout_items = function (self)
	local loadout_items = {}
	local slots_by_name = InventorySettings.slots_by_name

	for i = 1, #SPProfiles, 1 do
		local profile = SPProfiles[i]
		local profile_name = profile.display_name

		if not loadout_items[profile_name] then
			loadout_items[profile_name] = {}
		end

		local profile_loadout_items = loadout_items[profile_name]

		for slot_name, _ in pairs(slots_by_name) do
			local item = BackendUtils.get_loadout_item(profile_name, slot_name)

			if item then
				local backend_id = item.backend_id
				profile_loadout_items[backend_id] = item
			end
		end
	end

	self.loadout_items = loadout_items
end

InventoryItemsList._sync_item_list_equipped_status = function (self, item_list)
	local loadout_items = self.loadout_items

	if loadout_items and item_list then
		local selected_profile_name = self.selected_profile_name

		for i = 1, #item_list, 1 do
			local item = item_list[i]
			local item_backend_id = item.backend_id
			local is_equipped = nil

			if self._tag_all_equipped_items then
				for profile_name, profile_loadout_items in pairs(loadout_items) do
					for backend_id, loadout_item in pairs(profile_loadout_items) do
						if backend_id == item_backend_id then
							is_equipped = true

							break
						end
					end
				end
			else
				local selected_profile_name = self.selected_profile_name
				local profile_loadout = loadout_items[selected_profile_name]

				if profile_loadout then
					for backend_id, loadout_item in pairs(profile_loadout) do
						if backend_id == item_backend_id then
							is_equipped = true

							break
						end
					end
				end
			end

			item.equipped = is_equipped
		end
	end
end

InventoryItemsList._get_item_id_list_index = function (self, backend_id)
	local items = self.stored_items

	for index, item in ipairs(items) do
		if item.backend_id == backend_id then
			return index
		end
	end
end

InventoryItemsList.set_scroll_amount = function (self, value, ignore_list_scroll)
	local current_scroll_value = self.scroll_value

	if not current_scroll_value or value ~= current_scroll_value then
		local widget_scroll_bar_info = self.scrollbar_widget.content.scroll_bar_info
		widget_scroll_bar_info.value = value
		self.scroll_field_widget.content.internal_scroll_value = value
		self.scroll_value = value

		if not ignore_list_scroll then
			self:scroll_inventory_list(value)
		end
	end
end

InventoryItemsList.set_scrollbar_length = function (self, start_scroll_value, ignore_scroll_reset, ignore_scroll_set)
	local settings = self.settings
	local columns = settings.columns
	local total_inventory_slots = settings.num_list_items
	local number_of_items_in_list = self.number_of_items_in_list
	local item_diff_count = math.max(number_of_items_in_list - total_inventory_slots, 0)
	local scrollbar_content = self.scrollbar_widget.content
	local widget_scroll_bar_info = scrollbar_content.scroll_bar_info
	local previous_bar_fraction = widget_scroll_bar_info.bar_height_percentage
	local bar_fraction = 0
	local step_fraction = 0

	if item_diff_count > 0 then
		local number_of_elements_per_step = (columns and columns) or 1
		local number_of_steps_possible = math.ceil(item_diff_count / number_of_elements_per_step)
		local number_of_steps_total = math.ceil(number_of_items_in_list / number_of_elements_per_step)
		local list_fraction = 1 / number_of_steps_total
		bar_fraction = 1 - list_fraction * number_of_steps_possible
		step_fraction = 1 / number_of_steps_possible
	else
		bar_fraction = 1
		step_fraction = 1
	end

	widget_scroll_bar_info.bar_height_percentage = bar_fraction
	self.scroll_field_widget.content.scroll_step = step_fraction
	scrollbar_content.button_scroll_step = step_fraction

	if not ignore_scroll_set then
		if ignore_scroll_reset then
			local current_scroll_value = self.scroll_value
			self.scroll_value = nil

			self:set_scroll_amount(current_scroll_value or 0)
		else
			self:set_scroll_amount(start_scroll_value or 0)
		end
	end
end

InventoryItemsList.scroll_inventory_list = function (self, value)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local items = self.stored_items
		local total_elements = #items
		local list_content = item_list_widget.content.list_content
		local list_style = item_list_widget.style.list_style
		local max_visible_elements = list_style.num_draws
		local column_count = list_style.columns

		if max_visible_elements and max_visible_elements < total_elements then
			local elements_to_scroll = total_elements - max_visible_elements
			local new_start_index = math.max(0, math.round(value * elements_to_scroll)) + 1

			if column_count and new_start_index % column_count == 0 then
				new_start_index = (new_start_index + column_count) - 1
			end

			self:populate_widget_list(new_start_index)
		end
	end
end

InventoryItemsList.is_entry_outside = function (self, absolute_index)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local items = self.stored_items
		local total_elements = #items
		local list_style = item_list_widget.style.list_style
		local max_visible_elements = list_style.num_draws
		local absolute_start_index = list_style.list_start_index

		if absolute_index < absolute_start_index then
			return true, "above"
		elseif math.min((absolute_start_index + max_visible_elements) - 1, total_elements) < absolute_index then
			return true, "below"
		end
	end

	return false
end

InventoryItemsList.update_scroll = function (self)
	local scroll_bar_value = self.scrollbar_widget.content.scroll_bar_info.value
	local mouse_scroll_value = self.scroll_field_widget.content.internal_scroll_value
	local current_scroll_value = self.scroll_value

	if current_scroll_value ~= mouse_scroll_value then
		self:set_scroll_amount(mouse_scroll_value)
	elseif current_scroll_value ~= scroll_bar_value then
		self:set_scroll_amount(scroll_bar_value)
	end
end

InventoryItemsList.on_inventory_item_selected = function (self, absolute_index, play_sound)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local list_style = item_list_widget.style.list_style
	local list_start_index = list_style.list_start_index
	local number_of_items_in_list = self.number_of_items_in_list
	local num_draws = list_style.num_draws
	local items = self.stored_items

	if not number_of_items_in_list or number_of_items_in_list < 1 then
		return
	end

	if play_sound then
		self:play_sound(self.item_select_sound_event)
	end

	absolute_index = math.min(absolute_index, #items)
	local selected_absolute_list_index = absolute_index
	self.selected_absolute_list_index = selected_absolute_list_index
	self.selected_list_index = nil
	local item = items[absolute_index]
	self.selected_backend_id = item.backend_id

	for i = 1, #list_content, 1 do
		local entry_content = list_content[i]
		entry_content.button_hotspot.is_selected = false
	end

	if list_start_index <= absolute_index and absolute_index < list_start_index + num_draws then
		local relative_index = math.abs(absolute_index - list_start_index) + 1
		local content = list_content[relative_index]

		if content then
			content.button_hotspot.is_selected = true
			local item = content.item
			local backend_id = item.backend_id
			self.inventory_list_select_animation_time = 0
			self.selected_list_index = relative_index
		end

		local gamepad_slot_selection_widget = self.gamepad_slot_selection_widget
		local selection_scenegraph_id = gamepad_slot_selection_widget.scenegraph_id
		local height_spacing = element_settings.height_spacing
		local height = element_settings.height
		local index_from_bottom = num_draws - relative_index
		local y_position = index_from_bottom * height + index_from_bottom * height_spacing
		local selection_default_position = self.scenegraph_definition.gamepad_slot_selection.position
		self.ui_scenegraph[selection_scenegraph_id].local_position[2] = selection_default_position[2] + y_position
	end

	return item
end

InventoryItemsList.index_by_backend_id = function (self, backend_id)
	local items = self.stored_items

	if items then
		for index, item in ipairs(items) do
			if item.backend_id == backend_id then
				return index
			end
		end
	end
end

InventoryItemsList.item_by_index = function (self, index)
	local items = self.stored_items

	if items then
		for item_index, item in ipairs(items) do
			if index == item_index then
				return item
			end
		end
	end
end

InventoryItemsList.selected_item = function (self)
	local selected_absolute_list_index = self.selected_absolute_list_index

	if selected_absolute_list_index then
		local items = self.stored_items

		if items then
			local item = items[selected_absolute_list_index]
			local backend_id = item and item.backend_id

			if backend_id then
				local is_active = self:is_item_active(backend_id)
				local is_equipped = self:is_item_equipped(backend_id)

				return item, is_equipped, is_active
			end
		end
	end
end

InventoryItemsList.is_item_active = function (self, backend_id)
	return self.item_active_list[backend_id]
end

InventoryItemsList.is_item_equipped = function (self, backend_id)
	local loadout_items = self.loadout_items

	for profile_name, profile_loadout_items in pairs(loadout_items) do
		for item_backend_id, loadout_item in pairs(profile_loadout_items) do
			if backend_id == item_backend_id then
				return true
			end
		end
	end
end

InventoryItemsList.get_available_equipment_slot_by_type = function (self, slot_type)
	for index, slot in ipairs(slot_button_index) do
		if slot == slot_type then
			return index
		end
	end
end

InventoryItemsList.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end

InventoryItemsList.update_inventory_list_animations = function (self, dt)
	local item_list_widget = self.item_list_widget
	local content = item_list_widget.content.list_content
	local style = item_list_widget.style
	local list_style = style.list_style
	local inventory_list_animations = self.inventory_list_animations
	local border_settings = UISettings.inventory.item_list.border
	local hover_fade_in = border_settings.hover_fade_in_time
	local hover_fade_out = border_settings.hover_fade_out_time
	local alpha_normal = border_settings.alpha_normal
	local alpha_hover = border_settings.alpha_hover
	local non_room_item_alpha_value = UISettings.inventory.item_list.intro.non_room_item_alpha_value
	local start_index = list_style.start_index

	if not start_index then
		return
	end

	local num_draws = list_style.num_draws
	local stop_index = math.min(start_index + num_draws, self.number_of_items_in_list)

	for i = 1, #content, 1 do
		local outside_view = i < start_index or stop_index < i
		local element_style = (list_style.item_styles and list_style.item_styles[i]) or list_style
		local element_content = content[i]
		local button_hotspot = element_content.button_hotspot
		local background_click_style = element_style.background_click_texture_id
		local background_hover_style = element_style.background_hover_texture_id
		local background_style = element_style.background_texture_id
		local border_style = element_style.border_texture_id
		local active_animations = inventory_list_animations[i] or {}
		local is_selected = button_hotspot.is_selected
		local select_anim_time = self.inventory_list_select_animation_time

		if select_anim_time and (is_selected or element_content.tweened_click) then
			local total_time = 0.2
			element_content.tweened_click = true
			select_anim_time = select_anim_time + dt
			local progress = math.min(select_anim_time / total_time, 1)
			local catmullrom_value = math.catmullrom(progress, 0.97, 1, 1, 0.57)
			local background_hover_default_style = definitions.scenegraph_definition.inventory_selection_item_background_hover
			local background_default_size = definitions.scenegraph_definition.inventory_selection_item_background.size
			local border_default_style = definitions.scenegraph_definition.inventory_selection_item_icon_border
			local background_default_style = definitions.scenegraph_definition.inventory_selection_item_background
			local item_default_style = definitions.scenegraph_definition.inventory_selection_item_icon

			animation_definitions.animate_style_on_select(background_click_style, background_default_size, progress, catmullrom_value)
			animation_definitions.animate_style_on_select(background_hover_style, background_hover_default_style.size, progress, catmullrom_value, background_hover_default_style, true)

			self.inventory_list_select_animation_time = (progress < 1 and select_anim_time) or nil
			background_style.color[1] = 0
		end

		if not is_selected and element_content.tweened_click then
			background_click_style.color[1] = alpha_normal
			background_style.color[1] = (element_content.room_item and 255) or non_room_item_alpha_value
			active_animations.background = self:animate_element_by_time(background_style.color, 1, background_style.color[1], 255, 0.1)
			element_content.tweened_click = nil
		end

		if button_hotspot.is_hover and not is_selected and not outside_view then
			if not element_content.tween_in then
				element_content.tween_in = true
				active_animations.hover = self:animate_element_by_time(background_hover_style.color, 1, background_hover_style.color[1], alpha_hover, hover_fade_in)

				self:play_sound("Play_hud_hover")
			end
		elseif element_content.tween_in then
			element_content.tween_in = nil
			active_animations.hover = self:animate_element_by_time(background_hover_style.color, 1, background_hover_style.color[1], alpha_normal, hover_fade_out)
		end

		if active_animations then
			for name, animation in pairs(active_animations) do
				UIAnimation.update(animation, dt)

				if UIAnimation.completed(animation) then
					animation = nil
					self.inventory_list_animations[i] = nil
				end
			end
		end

		self.inventory_list_animations[i] = active_animations
	end
end

InventoryItemsList.update_inventory_list_intro_animation = function (self, dt)
	local time = self.inventory_list_animation_time
	local list_times = UISettings.inventory.item_list.intro
	local total_time = list_times.total_tween_time
	local alpha_fade_in_start_fraction = list_times.alpha_fade_in_start_fraction
	local size_fade_in_start_fraction = list_times.size_fade_in_start_fraction
	local item_fade_in_start_fraction = list_times.item_fade_in_start_fraction
	local item_fade_in_end_fraction = list_times.item_fade_in_end_fraction
	local background_fade_in_start_fraction = list_times.background_fade_in_start_fraction
	local background_fade_in_end_fraction = list_times.background_fade_in_end_fraction
	local text_fade_in_start_fraction = list_times.text_fade_in_start_fraction
	local text_fade_in_end_fraction = list_times.text_fade_in_end_fraction
	local non_room_item_alpha_value = list_times.non_room_item_alpha_value
	local item_list_widget = self.item_list_widget
	local content = item_list_widget.content
	local style = item_list_widget.style
	local list_style = style.list_style
	local scenegraph_definition = self.scenegraph_definition
	local background_default_style = scenegraph_definition.inventory_selection_item_background
	local item_default_style = scenegraph_definition.inventory_selection_item_icon
	time = time + dt
	local progress = math.min(time / total_time, 1)

	for i = 1, #content.list_content, 1 do
		local element_content = content.list_content[i]
		local element_style = (list_style.item_styles and list_style.item_styles[i]) or list_style
		local background_style = element_style.background_texture_id
		local item_style = element_style.item_texture_id
		local text_style = element_style.text_title
		local text_equipped_style = element_style.text_equipped
		local sub_text_style = element_style.text_sub_title

		if item_fade_in_start_fraction <= progress then
			local item_progress = progress - item_fade_in_start_fraction
			local item_tween_progress = (item_progress > 0 and math.min(item_progress / (item_fade_in_end_fraction - item_fade_in_start_fraction), 1)) or 0
			local catmullrom_value = math.catmullrom(item_tween_progress, -0.5, 1, 1, -0.5)
			item_style.color[1] = math.max(122.5, item_tween_progress * 255)
			local offset_fraction = (item_tween_progress < 1 and 1 - catmullrom_value) or 0
			local x_offset = (offset_fraction * item_default_style.size[1]) / 2
			local y_offset = offset_fraction * item_default_style.size[2] / 2
			item_style.size = {
				catmullrom_value * item_default_style.size[1],
				catmullrom_value * item_default_style.size[2]
			}
			item_style.offset = {
				item_default_style.position[1] + x_offset,
				item_default_style.position[2] + y_offset,
				item_style.offset[3]
			}
		else
			item_style.color[1] = 0
		end

		if background_fade_in_start_fraction <= progress then
			local background_progress = progress - background_fade_in_start_fraction
			local background_tween_progress = (background_progress > 0 and math.min(background_progress / (background_fade_in_end_fraction - background_fade_in_start_fraction), 1)) or 0
			local catmullrom_value = math.catmullrom(background_tween_progress, 1.2, 1, 1, 1.2)
			background_style.color[1] = math.max(122.5, background_tween_progress * 255)
			background_style.size[1] = catmullrom_value * background_default_style.size[1]
			background_style.size[2] = catmullrom_value * background_default_style.size[2]
			local offset_fraction = (background_tween_progress < 1 and 1 - catmullrom_value) or 0
			local x_offset = (offset_fraction * background_default_style.size[1]) / 2
			local y_offset = offset_fraction * background_default_style.size[2] / 2
			background_style.offset[1] = x_offset
			background_style.offset[2] = y_offset
			background_style.offset[3] = background_style.offset[3]
		else
			background_style.color[1] = 0
		end

		if text_fade_in_start_fraction <= progress then
			local text_progress = progress - text_fade_in_start_fraction
			local text_tween_progress = (text_progress > 0 and math.min(text_progress / text_fade_in_end_fraction, 1)) or 0
			local text_color = progress * 255
			text_style.text_color[1] = text_color
			sub_text_style.text_color[1] = text_color
			text_equipped_style.text_color[1] = text_color

			for k = 1, 5, 1 do
				local widget_stat_id = "stat_" .. k
				local widget_stat_title_id = "stat_title_icon_" .. k
				local compare_symbol_style = element_style[widget_stat_id]
				local compare_title_symbol_style = element_style[widget_stat_title_id]
				compare_symbol_style.color[1] = text_color
				compare_title_symbol_style.color[1] = text_color
			end

			if not element_content.room_item then
				background_style.color[1] = 255 - progress * (255 - non_room_item_alpha_value)
			end
		else
			local text_color = 0
			text_style.text_color[1] = text_color
			sub_text_style.text_color[1] = text_color
			text_equipped_style.text_color[1] = text_color

			for k = 1, 5, 1 do
				local widget_stat_id = "stat_" .. k
				local widget_stat_title_id = "stat_title_icon_" .. k
				local compare_symbol_style = element_style[widget_stat_id]
				local compare_title_symbol_style = element_style[widget_stat_title_id]
				compare_symbol_style.color[1] = text_color
				compare_title_symbol_style.color[1] = text_color
			end
		end
	end

	if progress == 1 then
		self.inventory_list_animation_time = nil
	else
		self.inventory_list_animation_time = time
	end
end

InventoryItemsList.get_rarity_color = function (self, rarity)
	return Colors.get_table(rarity or "white")
end

InventoryItemsList.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

InventoryItemsList.on_focus_lost = function (self)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local selected_list_index = self.selected_list_index
	local widget_content = list_content[selected_list_index]

	if widget_content and widget_content.new then
		local selected_content_item = widget_content.item

		if selected_content_item then
			local backend_id = selected_content_item.backend_id
			widget_content.new = false

			ItemHelper.unmark_backend_id_as_new(backend_id)
		end
	end
end

return
