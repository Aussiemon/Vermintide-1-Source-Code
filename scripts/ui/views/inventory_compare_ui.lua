local definitions = local_require("scripts/ui/views/inventory_compare_ui_definitions")

require("scripts/unit_extensions/default_player_unit/buffs/buff_templates")

InventoryCompareUI = class(InventoryCompareUI)
local STATS_BAR_LENGTH = definitions.STATS_BAR_LENGTH
local NUM_STATS_BARS = 5
local page_default_height = 800
local index_by_stats_type = {
	speed = 4,
	range = 1,
	damage = 5,
	targets = 3,
	stagger = 2
}
local stats_localization_keys = {
	burn = "item_compare_burn",
	range = "item_compare_range",
	armor_penetration = "item_compare_armor_penetration",
	damage = "item_compare_damage",
	head_shot = "item_compare_head_shot",
	poison = "item_compare_poison",
	speed = "item_compare_attack_speed",
	targets = "item_compare_targets",
	stagger = "item_compare_stagger"
}
local stats_bar_backgrouds = {
	active = "compare_bar_bg",
	disabled = "compare_bar_disabled"
}
local compare_bar_colors = {
	positive = Colors.get_color_table_with_alpha("green", 255),
	negative = Colors.get_color_table_with_alpha("red", 255),
	none = Colors.get_color_table_with_alpha("white", 255)
}
local fake_input_service = {
	get = function ()
		return
	end,
	has = function ()
		return
	end
}

InventoryCompareUI.init = function (self, parent, window_position, animation_definitions, ingame_ui_context, input_service_name)
	self.parent = parent
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.world_manager = ingame_ui_context.world_manager
	self.input_service_name = input_service_name
	self.widgets_definitions = definitions.widgets
	self.scenegraph_definition = definitions.scenegraph_definition
	self.scenegraph_definition.page_root.position = window_position
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.ui_animator = UIAnimator:new(self.scenegraph_definition, animation_definitions)
	self.animation_definitions = animation_definitions

	self:create_ui_elements()

	local light_attack_widget = self.light_attack_info_widget
	local heavy_attack_widget = self.heavy_attack_info_widget
	light_attack_widget.content.title_text = Localize("item_compare_attack_title_light")
	heavy_attack_widget.content.title_text = Localize("item_compare_attack_title_heavy")

	self:set_attack_title(light_attack_widget, "light_attack_frame", 1, Localize("item_compare_damage"))
	self:set_attack_title(light_attack_widget, "light_attack_frame", 2, Localize("item_compare_armor_penetration"))
	self:set_attack_title(light_attack_widget, "light_attack_frame", 3, Localize("item_compare_status"))
	self:set_attack_title(light_attack_widget, "light_attack_frame", 4, Localize("item_compare_head_shot"))
	self:set_attack_title(light_attack_widget, "light_attack_frame", 5, Localize("item_compare_elemental"))
	self:set_attack_title(heavy_attack_widget, "heavy_attack_frame", 1, Localize("item_compare_damage"))
	self:set_attack_title(heavy_attack_widget, "heavy_attack_frame", 2, Localize("item_compare_armor_penetration"))
	self:set_attack_title(heavy_attack_widget, "heavy_attack_frame", 3, Localize("item_compare_status"))
	self:set_attack_title(heavy_attack_widget, "heavy_attack_frame", 4, Localize("item_compare_head_shot"))
	self:set_attack_title(heavy_attack_widget, "heavy_attack_frame", 5, Localize("item_compare_elemental"))

	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)

	self:clear_item_selected()
end

InventoryCompareUI.disable_input = function (self, blocked)
	self.input_blocked = blocked
end

InventoryCompareUI.on_enter = function (self)
	return
end

InventoryCompareUI.on_exit = function (self)
	return
end

InventoryCompareUI.destroy = function (self)
	self.ui_animator = nil
end

InventoryCompareUI.create_ui_elements = function (self)
	self.light_attack_info_widget = definitions.create_attack_detailed_info_widget(NUM_STATS_BARS, "light_attack_frame")
	self.heavy_attack_info_widget = definitions.create_attack_detailed_info_widget(NUM_STATS_BARS, "heavy_attack_frame")
	self.ui_scenegraph = UISceneGraph.init_scenegraph(self.scenegraph_definition)
	local widgets = self.widgets_definitions
	self.background_widgets = {
		definitions.create_simple_texture_widget("items_list_bg", "window_background"),
		definitions.create_simple_texture_widget("compare_window_bg_large", "compare_window_bg"),
		definitions.create_simple_texture_widget("mask_rect", "compare_window_mask")
	}
	self.traits_title_widget = UIWidget.init(widgets.traits_title)
	self.trait_background_widget = UIWidget.init(widgets.trait_background)
	self.trait_icon_widgets = {
		UIWidget.init(widgets.trait_button_1),
		UIWidget.init(widgets.trait_button_2),
		UIWidget.init(widgets.trait_button_3),
		UIWidget.init(widgets.trait_button_4)
	}
	local scrollbar_scenegraph_id = "scrollbar_root"
	local scrollbar_scenegraph = self.scenegraph_definition[scrollbar_scenegraph_id]
	self.scrollbar_widget = UIWidget.init(UIWidgets.create_scrollbar(scrollbar_scenegraph.size[2], scrollbar_scenegraph_id))
	self.scroll_field_widget = UIWidget.init(self.widgets_definitions.scroll_field)
	self.window_title_text_widget = UIWidget.init(self.widgets_definitions.window_title_text)
	self.item_info_widget = UIWidget.init(self.widgets_definitions.item_info)
	self.stamina_field_widget = UIWidget.init(self.widgets_definitions.stamina_field)
	self.ammo_field_widget = UIWidget.init(self.widgets_definitions.ammo_field)
	self.description_field_widget = UIWidget.init(self.widgets_definitions.item_description_field)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
end

InventoryCompareUI.update = function (self, dt)
	local input_manager = self.input_manager
	local gamepad_active = input_manager:is_device_active("gamepad")
	local gamepad_scroll_value = nil

	if gamepad_active then
		local input_service_name = self.input_service_name
		local input_service = (self.input_blocked and fake_input_service) or input_manager:get_service(input_service_name)
		local scroll_axis = input_service:get("gamepad_right_axis")

		if scroll_axis and Vector3.length(scroll_axis) > 0 then
			local current_scroll_value = self.scroll_value
			local scroll_step = self.scroll_field_widget.content.scroll_step or 0.1
			gamepad_scroll_value = current_scroll_value + scroll_step * -scroll_axis.y
			gamepad_scroll_value = math.clamp(gamepad_scroll_value, 0, 1)
		end
	end

	self:update_scroll(gamepad_scroll_value)
end

InventoryCompareUI.set_scrollbar_length = function (self, total_height, start_scroll_value, draw_attack_info)
	local ui_scenegraph = self.ui_scenegraph
	local actual_height = 0
	local start_position = ui_scenegraph.item_icon_background.position[2]
	local end_position = ui_scenegraph
	local scrollbar_content = self.scrollbar_widget.content
	local widget_scroll_bar_info = scrollbar_content.scroll_bar_info
	local bar_fraction = 0
	local step_fraction = 0
	local draw_scrollbar = false
	local default_page_size = {
		0,
		page_default_height
	}
	local scaled_default_page_size = UIScaleVectorToResolution(default_page_size)
	local default_height = scaled_default_page_size[2]

	if draw_attack_info then
		total_height = total_height + default_height
	end

	if default_height >= total_height then
		bar_fraction = 1
	else
		local height_fraction = default_height / total_height
		bar_fraction = height_fraction
		step_fraction = 0.15
		draw_scrollbar = true
	end

	widget_scroll_bar_info.bar_height_percentage = bar_fraction
	self.scroll_field_widget.content.scroll_step = step_fraction
	scrollbar_content.button_scroll_step = step_fraction

	self:set_scroll_amount(start_scroll_value or 0)

	self.draw_scrollbar = draw_scrollbar
end

InventoryCompareUI.update_scroll = function (self, override_value)
	local scroll_bar_value = self.scrollbar_widget.content.scroll_bar_info.value
	local mouse_scroll_value = self.scroll_field_widget.content.internal_scroll_value
	local current_scroll_value = self.scroll_value

	if override_value and override_value ~= current_scroll_value then
		self:set_scroll_amount(override_value)
	elseif current_scroll_value ~= mouse_scroll_value then
		self:set_scroll_amount(mouse_scroll_value)
	elseif current_scroll_value ~= scroll_bar_value then
		self:set_scroll_amount(scroll_bar_value)
	end
end

InventoryCompareUI.set_scroll_amount = function (self, value)
	local current_scroll_value = self.scroll_value

	if not current_scroll_value or value ~= current_scroll_value then
		local ui_scenegraph = self.ui_scenegraph
		local start_position = 22
		local size = self.total_widgets_height or 0
		ui_scenegraph.compare_window.local_position[2] = math.ceil(start_position + size * value)
		local widget_scroll_bar_info = self.scrollbar_widget.content.scroll_bar_info
		widget_scroll_bar_info.value = value
		self.scroll_field_widget.content.internal_scroll_value = value
		self.scroll_value = value
	end
end

InventoryCompareUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service_name = self.input_service_name
	local input_service = (self.input_blocked and fake_input_service) or input_manager:get_service(input_service_name)
	local gamepad_active = input_manager:is_device_active("gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self.window_title_text_widget)

	for _, widget in ipairs(self.background_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	if self.item then
		UIRenderer.draw_widget(ui_renderer, self.scroll_field_widget)

		if self.draw_scrollbar then
			UIRenderer.draw_widget(ui_renderer, self.scrollbar_widget)
		end

		UIRenderer.draw_widget(ui_renderer, self.item_info_widget)
		UIRenderer.draw_widget(ui_renderer, self.description_field_widget)

		if self.draw_attack_info then
			UIRenderer.draw_widget(ui_renderer, self.light_attack_info_widget)

			local heavy_attack_info_widget = self.heavy_attack_info_widget

			UIRenderer.draw_widget(ui_renderer, self.heavy_attack_info_widget)

			if self.draw_stamina then
				UIRenderer.draw_widget(ui_renderer, self.stamina_field_widget)
			end

			if self.draw_ammo then
				UIRenderer.draw_widget(ui_renderer, self.ammo_field_widget)
			end
		end

		local trait_icon_widgets = self.trait_icon_widgets
		local number_of_traits_on_item = self.number_of_traits_on_item

		for i = 1, number_of_traits_on_item, 1 do
			local widget = trait_icon_widgets[i]

			UIRenderer.draw_widget(ui_renderer, widget)
		end

		if number_of_traits_on_item > 0 then
			UIRenderer.draw_widget(ui_renderer, self.traits_title_widget)
			UIRenderer.draw_widget(ui_renderer, self.trait_background_widget)
		end
	end

	UIRenderer.end_pass(ui_renderer)
end

InventoryCompareUI.set_title_text = function (self, text)
	local widget = self.window_title_text_widget
	widget.content.text = text
end

InventoryCompareUI.on_item_selected = function (self, item_backend_id, compare_item_backend_id)
	if not item_backend_id then
		self.item = nil

		return
	end

	self:clear_item_selected()

	local item = BackendUtils.get_item_from_masterlist(item_backend_id)
	self.scrollbar_widget.content.scroll_bar_info.bar_height_percentage = (item and 0.5) or 1
	local total_widgets_height = 0
	local draw_attack_info = false

	if item then
		local compare_item = compare_item_backend_id and BackendUtils.get_item_from_masterlist(compare_item_backend_id)
		self.item = item
		local slot_type = item.slot_type
		local info_widget = self.item_info_widget
		local info_widget_content = info_widget.content
		local info_widget_style = info_widget.style
		local item_name = item.name
		local rarity_color = self:get_rarity_color(item.rarity)
		local item_name = Localize(item.display_name)

		if info_widget_style.text_title and UTF8Utils.string_length(item_name) > 25 and not UIRenderer.crop_text_width(self.ui_renderer, item_name, 400, info_widget_style.text_title) then
		end

		info_widget_content.text_title = item_name
		info_widget_content.sub_text_title = Localize(item.item_type)
		info_widget_style.text_title.text_color = rarity_color
		info_widget_style.icon_frame_texture.color = rarity_color
		info_widget_content.icon_texture = item.inventory_icon or "icons_placeholder"
		local traits = item.traits
		local item_template = BackendUtils.get_item_template(item)
		local item_statistics = item_template.compare_statistics
		local stats_by_attack = item_statistics and item_statistics.attacks
		local perks_by_attack = item_statistics and item_statistics.perks
		local item_compare_template = compare_item and BackendUtils.get_item_template(compare_item)
		local item_compare_statistics = item_compare_template and item_compare_template.compare_statistics and item_compare_template.compare_statistics
		local item_compare_statistics_attacks = item_compare_statistics and item_compare_statistics.attacks
		local item_compare_statistics_perks = item_compare_statistics and item_compare_statistics.perks
		local draw_stamina = false
		local draw_ammo = false

		if slot_type == "melee" or slot_type == "ranged" then
			draw_attack_info = true

			if slot_type == "melee" then
				draw_stamina = true
			end

			if item_template.ammo_data then
				draw_ammo = true
			end
		end

		local light_attack_statistics = stats_by_attack and stats_by_attack.light_attack and stats_by_attack.light_attack
		local light_attack_compare_statistics = item_compare_statistics_attacks and item_compare_statistics_attacks.light_attack and item_compare_statistics_attacks.light_attack

		self:set_item_data(self.light_attack_info_widget, "light_attack_frame", light_attack_statistics, light_attack_compare_statistics)

		local heavy_attack_statistics = stats_by_attack and stats_by_attack.heavy_attack and stats_by_attack.heavy_attack
		local heavy_attack_compare_statistics = item_compare_statistics_attacks and item_compare_statistics_attacks.heavy_attack and item_compare_statistics_attacks.heavy_attack

		self:set_item_data(self.heavy_attack_info_widget, "heavy_attack_frame", heavy_attack_statistics, heavy_attack_compare_statistics)

		local light_attack_perks = perks_by_attack and perks_by_attack.light_attack and perks_by_attack.light_attack

		self:set_perks(self.light_attack_info_widget, light_attack_perks)

		local heavy_attack_perks = perks_by_attack and perks_by_attack.heavy_attack and perks_by_attack.heavy_attack

		self:set_perks(self.heavy_attack_info_widget, heavy_attack_perks)

		local light_attack_frame_height = self:calculate_attack_frame_height(self.light_attack_info_widget, "light_attack_frame", light_attack_perks and true, light_attack_statistics)
		local heavy_attack_frame_height = self:calculate_attack_frame_height(self.heavy_attack_info_widget, "heavy_attack_frame", heavy_attack_perks and true, heavy_attack_statistics)

		if draw_stamina then
			local max_fatigue_points = item_template.max_fatigue_points

			self:set_stamina(max_fatigue_points or 0)
		end

		if draw_ammo then
			self:set_ammo(item_template)
		end

		self.trait_widgets_height = self:set_traits_info(item, traits)
		local total_description_height = self:set_item_description(item.description)
		self.total_description_height = total_description_height
		total_widgets_height = total_widgets_height + total_description_height + self.trait_widgets_height
		self.draw_attack_info = draw_attack_info
		self.draw_stamina = draw_stamina
		self.draw_ammo = draw_ammo
	end

	show_traits = self.number_of_traits_on_item > 0
	local height, spacing_height = self:handle_widget_positions(draw_attack_info, show_traits, self.draw_stamina, self.draw_ammo)
	total_widgets_height = total_widgets_height + spacing_height
	self.total_widgets_height = total_widgets_height

	self:set_scrollbar_length(total_widgets_height, 0, draw_attack_info)
end

InventoryCompareUI.handle_widget_positions = function (self, show_attack_info, show_traits, show_stamina, show_ammo)
	local ui_scenegraph = self.ui_scenegraph
	local scenegraph_definition = self.scenegraph_definition
	local stamina_position_default = scenegraph_definition.stamina_field.position
	local ammo_position_default = scenegraph_definition.ammo_field.position
	local traits_position_default = scenegraph_definition.item_traits_root.position
	local light_attack_position_default = scenegraph_definition.light_attack_frame.position
	local heavy_attack_position_default = scenegraph_definition.heavy_attack_frame.position
	local description_position_default = scenegraph_definition.item_description_field.position
	local stamina_size_default = scenegraph_definition.stamina_field.size
	local ammo_size_default = scenegraph_definition.ammo_field.size
	local traits_size_default = scenegraph_definition.item_traits_root.size
	local light_attack_size_default = scenegraph_definition.light_attack_frame.size
	local heavy_attack_size_default = scenegraph_definition.heavy_attack_frame.size
	local description_size_default = scenegraph_definition.item_description_field.size
	local stamina_position = ui_scenegraph.stamina_field.local_position
	local ammo_position = ui_scenegraph.ammo_field.local_position
	local traits_position = ui_scenegraph.item_traits_root.local_position
	local light_attack_position = ui_scenegraph.light_attack_frame.local_position
	local heavy_attack_position = ui_scenegraph.heavy_attack_frame.local_position
	local description_position = ui_scenegraph.item_description_field.local_position
	local trait_widgets_height = self.trait_widgets_height
	local total_description_height = self.total_description_height
	local total_height = 0
	local total_spacing = 0
	local large_spacing = 45
	local small_spacing = 15

	if show_traits then
		traits_position[2] = traits_position_default[2]
		total_height = total_height + trait_widgets_height
	end

	if show_attack_info then
		if show_traits then
			light_attack_position[2] = light_attack_position_default[2] - total_height - large_spacing
			total_height = total_height + light_attack_size_default[2] + large_spacing
			total_spacing = total_spacing + large_spacing
		else
			light_attack_position[2] = light_attack_position_default[2] - total_height
			total_height = total_height + light_attack_size_default[2]
		end

		heavy_attack_position[2] = heavy_attack_position_default[2] - total_height - large_spacing
		total_height = total_height + heavy_attack_size_default[2] + large_spacing
		total_spacing = total_spacing + large_spacing

		if show_stamina and show_ammo then
			stamina_position[2] = stamina_position_default[2] - total_height - large_spacing
			total_height = total_height + stamina_size_default[2] + large_spacing
			total_spacing = total_spacing + large_spacing
			ammo_position[2] = ammo_position_default[2] - total_height - small_spacing
			total_height = total_height + ammo_size_default[2] + small_spacing
			total_spacing = total_spacing + small_spacing
		elseif show_stamina then
			stamina_position[2] = stamina_position_default[2] - total_height - large_spacing
			total_height = total_height + stamina_size_default[2] + large_spacing
			total_spacing = total_spacing + large_spacing
		elseif show_ammo then
			ammo_position[2] = ammo_position_default[2] - total_height - large_spacing
			total_height = total_height + ammo_size_default[2] + large_spacing
			total_spacing = total_spacing + large_spacing
		end

		if show_stamina or show_ammo then
			description_position[2] = description_position_default[2] - total_height - small_spacing
			total_height = total_height + total_description_height + small_spacing
			total_spacing = total_spacing + small_spacing
		else
			description_position[2] = description_position_default[2] - total_height - large_spacing
			total_height = total_height + total_description_height + large_spacing
			total_spacing = total_spacing + large_spacing
		end
	elseif show_traits then
		description_position[2] = description_position_default[2] - total_height - large_spacing
		total_height = total_height + total_description_height + large_spacing
		total_spacing = total_spacing + large_spacing
	else
		description_position[2] = light_attack_position_default[2] - total_height
		total_height = total_height + total_description_height
	end

	return total_height, math.max(total_spacing - 150, 0)
end

InventoryCompareUI.calculate_attack_frame_height = function (self, widget, scenegraph_id, using_perks, attack_statistics)
	local ui_scenegraph = self.ui_scenegraph
	local widget_content = widget.content
	local widget_style = widget.style
	local total_height = 0

	if attack_statistics then
		if using_perks then
			local _, perk_text_height = self:get_text_size(widget_content.perk_text, widget_style.perk_text)
			total_height = total_height + perk_text_height
		end

		local bar_height = 20
		local bar_height_spacing = 15
		local total_bars_height = 5

		for attack_stat_key, value in pairs(attack_statistics) do
			total_bars_height = total_bars_height + bar_height + bar_height_spacing
		end

		total_height = total_height + total_bars_height
		ui_scenegraph[scenegraph_id].size[2] = 275
	else
		ui_scenegraph[scenegraph_id].size[2] = 0
	end

	return total_height
end

InventoryCompareUI.get_text_size = function (self, localized_text, text_style)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, localized_text, font[1], scaled_font_size)

	return text_width, text_height
end

InventoryCompareUI.get_word_wrap_size = function (self, localized_text, text_style, text_area_width)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local lines = UIRenderer.word_wrap(self.ui_renderer, localized_text, font[1], scaled_font_size, text_area_width)
	local text_width, text_height = self:get_text_size(localized_text, text_style)

	return text_width, text_height * #lines
end

InventoryCompareUI.clear_item_selected = function (self)
	self.item = nil

	self:reset_stat_bars(self.light_attack_info_widget, "light_attack_frame")
	self:reset_stat_bars(self.heavy_attack_info_widget, "heavy_attack_frame")
	self:set_scroll_amount(0)
end

InventoryCompareUI.set_item_data = function (self, widget, scenegraph_id, stats_data, compare_stats_data)
	if stats_data then
		local counter = 0

		for key, value in pairs(stats_data) do
			local index = index_by_stats_type[key]

			if index then
				local bar_background = "bar_background_" .. index
				local bar_background_active = "bar_background_active_" .. index
				local bar_background_texture = stats_bar_backgrouds.active
				widget.content[bar_background] = bar_background_texture
				widget.content[bar_background_active] = true

				if compare_stats_data then
					for compare_key, compare_value in pairs(compare_stats_data) do
						if key == compare_key then
							self:set_bar_value(widget, scenegraph_id, index, value, compare_value)

							break
						end
					end
				else
					self:set_bar_value(widget, scenegraph_id, index, value, value)
				end

				counter = counter + 1
			end
		end

		widget.content.number_of_bars = counter
	end
end

InventoryCompareUI.reset_stat_bars = function (self, widget, scenegraph_id)
	local ui_scenegraph = self.ui_scenegraph

	for i = 1, NUM_STATS_BARS, 1 do
		local stats_bar_scenegraph_id = scenegraph_id .. "_stats_bar_" .. i
		local stats_compare_bar_scenegraph_id = scenegraph_id .. "_stats_compare_bar_" .. i
		ui_scenegraph[stats_bar_scenegraph_id].size[1] = 0
		ui_scenegraph[stats_compare_bar_scenegraph_id].size[1] = 0
		local bar_background = "bar_background_" .. i
		local bar_background_active = "bar_background_active_" .. i
		widget.content[bar_background] = stats_bar_backgrouds.disabled
		widget.content[bar_background_active] = false
	end
end

InventoryCompareUI.set_bar_value = function (self, widget, scenegraph_id, index, value, compare_value)
	local ui_scenegraph = self.ui_scenegraph
	local bar = "bar_" .. index
	local compare_bar = "compare_bar_" .. index
	local stats_bar_scenegraph_id = scenegraph_id .. "_stats_bar_" .. index
	local stats_compare_bar_scenegraph_id = scenegraph_id .. "_stats_compare_bar_" .. index
	local stats_bar_edge_marker_scenegraph_id = scenegraph_id .. "_stats_bar_edge_marker_" .. index
	local bar_style = widget.style[bar]
	local bar_content = widget.content.bar_1
	local compare_bar_style = widget.style[compare_bar]
	local compare_bar_content = widget.content.bar_2
	local normal_bar_value = 0
	local compare_bar_value = 0
	local normal_bar_fraction = 0
	local compare_bar_fraction = 0
	local normal_bar_color, compare_bar_color = nil
	local edge_marker_position_value = 0

	if compare_value < value then
		normal_bar_value = math.clamp(compare_value * STATS_BAR_LENGTH, 0, STATS_BAR_LENGTH)
		compare_bar_value = math.clamp(value * STATS_BAR_LENGTH, 0, STATS_BAR_LENGTH)
		normal_bar_fraction = compare_value
		compare_bar_fraction = value
		normal_bar_color = compare_bar_colors.none
		compare_bar_color = compare_bar_colors.positive
		edge_marker_position_value = compare_bar_value
	elseif value < compare_value then
		normal_bar_value = math.clamp(value * STATS_BAR_LENGTH, 0, STATS_BAR_LENGTH)
		compare_bar_value = math.clamp(compare_value * STATS_BAR_LENGTH, 0, STATS_BAR_LENGTH)
		normal_bar_fraction = value
		compare_bar_fraction = compare_value
		normal_bar_color = compare_bar_colors.none
		compare_bar_color = compare_bar_colors.negative
		edge_marker_position_value = normal_bar_value
	else
		normal_bar_value = math.clamp(value * STATS_BAR_LENGTH, 0, STATS_BAR_LENGTH)
		compare_bar_value = math.clamp(value * STATS_BAR_LENGTH, 0, STATS_BAR_LENGTH)
		normal_bar_fraction = value
		compare_bar_fraction = value
		normal_bar_color = compare_bar_colors.none
		compare_bar_color = compare_bar_colors.none
		edge_marker_position_value = normal_bar_value
	end

	bar_style.color = table.clone(normal_bar_color)
	compare_bar_style.color = table.clone(compare_bar_color)
	bar_content.uvs[2][1] = normal_bar_fraction
	compare_bar_content.uvs[2][1] = compare_bar_fraction
	ui_scenegraph[stats_bar_scenegraph_id].size[1] = normal_bar_value
	ui_scenegraph[stats_compare_bar_scenegraph_id].size[1] = compare_bar_value
	ui_scenegraph[stats_bar_edge_marker_scenegraph_id].position[1] = edge_marker_position_value
end

InventoryCompareUI.set_perks = function (self, widget, perks)
	if perks then
		local text = ""

		for index, perk in ipairs(perks) do
			local localization_key = stats_localization_keys[perk]

			if index == #perks then
				text = text .. Localize(localization_key)
			else
				text = text .. Localize(localization_key) .. ", "
			end
		end

		widget.content.perk_text = text
		widget.content.use_perks = true
	else
		widget.content.use_perks = nil
	end
end

InventoryCompareUI.set_attack_title = function (self, widget, scenegraph_id, row_index, text)
	local title_text_name = scenegraph_id .. "_title_text_" .. row_index
	widget.content[title_text_name] = text
end

InventoryCompareUI.set_stamina = function (self, max_fatigue_points)
	local max_shields = 6
	local remaining_fatigue_points = max_fatigue_points
	local widget = self.stamina_field_widget
	local widget_content = widget.content
	local widget_style = widget.style

	for i = 1, max_shields, 1 do
		remaining_fatigue_points = remaining_fatigue_points - 2

		if remaining_fatigue_points >= 0 then
			widget_content.icon_textures[i] = "fatigue_icon_full"
		elseif remaining_fatigue_points == -1 then
			widget_content.icon_textures[i] = "fatigue_icon_broken"
		else
			widget_content.icon_textures[i] = "fatigue_icon_empty"
		end
	end
end

InventoryCompareUI.set_ammo = function (self, item_template)
	local widget = self.ammo_field_widget
	local widget_content = widget.content
	local ammo_data = item_template.ammo_data
	local single_clip = ammo_data.single_clip
	local ammo_count = ammo_data.ammo_per_clip or ammo_data.max_ammo
	local max_ammo = ammo_data.max_ammo
	local ammo_text_1 = (not single_clip and tostring(ammo_count)) or ""
	local ammo_text_2 = (not single_clip and tostring(max_ammo - ammo_count)) or tostring(ammo_count)
	widget_content.ammo_text_1 = ammo_text_1
	widget_content.ammo_text_2 = ammo_text_2
end

InventoryCompareUI.set_item_description = function (self, text)
	local widget = self.description_field_widget
	local widget_content = widget.content
	local description_text = Localize(text)
	widget_content.description_text = description_text
	local scenegraph_id = "item_description_field"
	local description_field_scenegraph = self.ui_scenegraph[scenegraph_id]
	local scaled_text_area_width = UIScaleVectorToResolution(description_field_scenegraph.size)
	local _, description_text_height = self:get_word_wrap_size(description_text, widget.style.description_text, scaled_text_area_width[1])

	return description_text_height + 60
end

InventoryCompareUI.set_traits_info = function (self, item, traits)
	local item_backend_id = item.backend_id
	local slot_type = item.slot_type
	local trait_icon_widgets = self.trait_icon_widgets
	local num_total_traits = ForgeSettings.num_traits
	local number_of_traits_on_item = 0
	local is_trinket = slot_type == "trinket"
	local never_locked = is_trinket or slot_type == "hat"
	local trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local total_traits_height = 0
	local trait_start_spacing = 25
	local trait_end_spacing = 25
	local icon_height = 40
	local divider_height = 60
	local description_text_spacing = 15
	local background_default_height = 148
	local ui_scenegraph = self.ui_scenegraph

	for i = 1, num_total_traits, 1 do
		local is_first_widget = i == 1
		local trait_name = traits and traits[i]
		local trait_widget = trait_icon_widgets[i]
		local trait_widget_style = trait_widget.style
		local trait_widget_content = trait_widget.content

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local trait_unlocked = ((never_locked or BackendUtils.item_has_trait(item_backend_id, trait_name)) and true) or false
				local display_name = trait_template.display_name or "Unknown"
				local description_text = BackendUtils.get_item_trait_description(item_backend_id, i)
				local trait_display_name = Localize(display_name)
				local description_text = description_text

				if not is_trinket and trait_unlocked then
					trait_widget_style.description_text.last_line_color = nil
				else
					if is_trinket then
						description_text = description_text .. "\n" .. tooltip_trait_unique_text
					else
						description_text = description_text .. "\n" .. trait_locked_text
					end

					trait_widget_style.description_text.last_line_color = Colors.get_color_table_with_alpha("red", 255)
				end

				local icon = trait_template.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_content.use_background = false
				trait_widget_content.use_glow = false
				trait_widget_content.use_divider = not is_first_widget
				trait_widget.content.locked = not trait_unlocked
				trait_widget.content.title_text = trait_display_name
				trait_widget.content.description_text = description_text
				local trait_scenegraph_name = "trait_button_" .. i
				local description_scenegraph_id = "trait_description_" .. i
				local description_field_scenegraph = ui_scenegraph[description_scenegraph_id]
				local _, description_text_height = self:get_word_wrap_size(description_text, trait_widget_style.description_text, description_field_scenegraph.size[1])
				local trait_total_height = icon_height + description_text_spacing + description_text_height

				if not is_first_widget then
					trait_total_height = trait_total_height + divider_height
				end

				local position = ui_scenegraph[trait_scenegraph_name].local_position
				position[2] = (is_first_widget and 0) or -(total_traits_height + divider_height)
				total_traits_height = total_traits_height + trait_total_height
			end

			trait_widget_content.visible = (trait_template and true) or false
			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	ui_scenegraph.item_traits_background_center.size[2] = (total_traits_height + trait_start_spacing + trait_end_spacing) - background_default_height
	self.number_of_traits_on_item = number_of_traits_on_item

	return math.ceil((self.number_of_traits_on_item > 0 and total_traits_height + trait_start_spacing + trait_end_spacing) or 0)
end

InventoryCompareUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

InventoryCompareUI.get_rarity_color = function (self, rarity)
	return Colors.get_table(rarity or "white")
end

return
