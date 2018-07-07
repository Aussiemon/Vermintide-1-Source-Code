require("scripts/settings/forge_settings")

local definitions = dofile("scripts/ui/forge_view/forge_merge_ui_definitions")
local num_item_buttons = definitions.settings.num_item_buttons
ForgeMergeUI = class(ForgeMergeUI)
local drag_colors = {
	normal = Colors.get_color_table_with_alpha("drag_same_slot", 255),
	hover = Colors.get_color_table_with_alpha("drag_same_slot_hover", 255)
}
local reward_textures_by_type = {
	ranged = "dice_game_icon_02",
	hat = "dice_game_icon_03",
	trinket = "dice_game_icon_04",
	melee = "dice_game_icon_01",
	any = "cogwheel_01"
}
local rarity_order = {
	common = 2,
	plentiful = 1,
	exotic = 4,
	rare = 3,
	unique = 5
}
local fake_input_service = {
	get = function ()
		return
	end,
	has = function ()
		return
	end
}

ForgeMergeUI.init = function (self, parent, position, animation_definitions, ingame_ui_context)
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
	self.item_list = {}
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.widget_definitions = definitions.widget_definitions
	self.scenegraph_definition = definitions.scenegraph_definition
	self.scenegraph_definition.page_root.position = position
	local default_rarity = "plentiful"
	local merge_cost_settings = ForgeSettings.merge_cost[default_rarity]
	local token_type = merge_cost_settings.token_type
	local token_texture = merge_cost_settings.token_texture
	self.num_items_to_merge = 0
	self.tokens_required_to_merge = 0
	self.token_merge_type = token_type
	self.current_rarity_color = Colors.get_table(default_rarity)
	self.current_rarity = default_rarity
	self.animations = {}

	self:create_ui_elements()
	self:update_description_text()
end

ForgeMergeUI.on_enter = function (self)
	self:clear_merged_item()
end

ForgeMergeUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled
end

ForgeMergeUI.handle_gamepad_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = self.parent:page_input_service()
	local merge_button_widget = self.widgets_by_name.merge_button_widget
	local use_gamepad = self.use_gamepad
	local controller_cooldown = self.controller_cooldown

	if input_service:get("back") then
		controller_cooldown = 0
	end

	if controller_cooldown and controller_cooldown > 0 then
		self.controller_cooldown = controller_cooldown - dt

		if use_gamepad then
			local item_list = self.item_list
			local num_items = table.size(item_list)

			if num_items > 0 then
				input_service:get("back", true)
			end
		end
	elseif use_gamepad and not self.merging then
		local item_list = self.item_list
		local num_items = table.size(item_list)

		if num_items > 0 then
			local all_items_added = num_items == 5
			local enough_tokens = self.tokens_required_to_merge <= BackendUtils.get_tokens(self.token_merge_type) and num_items >= 1

			if input_service:get("back", true) or input_service:get("special_1") then
				local id_to_remove = item_list[num_items]
				self.gamepad_remove_item_id = id_to_remove
				self.controller_cooldown = GamepadSettings.menu_cooldown
			elseif input_service:get("refresh_press") and (all_items_added or enough_tokens) then
				self:start_charge_progress()
			elseif self.charging and not input_service:get("refresh_hold") then
				self:abort_charge_progress()

				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		end
	end
end

ForgeMergeUI.enough_tokens_available = function (self)
	local available_tokens = BackendUtils.get_tokens(self.token_merge_type)
	local needed_tokens = self.tokens_required_to_merge
	local can_afford = needed_tokens <= available_tokens

	return can_afford
end

ForgeMergeUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.widgets = {}
	self.widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.widgets_definitions) do
		self.widgets_by_name[widget_name] = UIWidget.init(widget_definition)
		self.widgets[#self.widgets + 1] = self.widgets_by_name[widget_name]
	end

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	local merge_button_widget = self.widgets_by_name.merge_button_widget
	merge_button_widget.content.button_hotspot.disabled = true
	merge_button_widget.style.eye_glow_texture.color[1] = 0
	local right_door_default_size = self.scenegraph_definition.frame_door_right.size
	self.ui_scenegraph.frame_door_right.size[1] = 0
	self.widgets_by_name.door_right_widget.content.texture_id.uvs[2][1] = 0
	local left_door_default_size = self.scenegraph_definition.frame_door_left.size
	self.ui_scenegraph.frame_door_left.size[1] = 0
	self.widgets_by_name.door_left_widget.content.texture_id.uvs[1][1] = 1

	if not self.animations.eye_glow then
		self.animations.eye_glow = UIAnimation.init(UIAnimation.pulse_animation, merge_button_widget.style.eye_glow_texture.color, 1, 150, 255, 2)
		self.animations.gamepad_glow = UIAnimation.init(UIAnimation.pulse_animation, merge_button_widget.style.gamepad_glow_texture.color, 1, 150, 255, 2)
	end
end

ForgeMergeUI.update = function (self, dt)
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

	self.merge_completed = nil
	local melt_trail_animation_event_names = self.melt_trail_animation_event_names

	for name, animation in pairs(self.animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.animations[name] = nil

			if melt_trail_animation_event_names then
				for i = 1, #melt_trail_animation_event_names, 1 do
					local trail_anim_name = melt_trail_animation_event_names[i]

					if name == trail_anim_name then
						self:play_sound("Play_hud_forge_melt_process")
					end
				end
			end

			if self.merging and name == "merge_animation" then
				self:merge_animation_complete()
			end

			if name == self.trail_complete_animation_name then
				self:on_trail_animation_complete()
			elseif name == "door_slam" then
				self:play_sound("Play_hud_forge_stone_door")
			elseif name == "reward_slot_glow" then
				self:on_reward_slot_glow_animation_complete()
			end

			self:on_charge_animations_complete(name)
		end
	end

	if not self.merging then
		self:handle_gamepad_input(dt)
	end

	self.specific_slot_index = nil
	self.item_to_remove_index = nil
	self.pressed_item_backend_id = nil

	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]
		local button_hotspot = widget.content.button_hotspot

		if button_hotspot.on_hover_enter then
			if widget.content.icon_texture_id then
				self:play_sound("Play_hud_hover")
			end

			local bar_settings = UISettings.inventory.button_bars
			local fade_in_time = bar_settings.background.fade_in_time
			local alpha_hover = bar_settings.background.alpha_hover
			local widget_hover_color = widget.style.hover_texture.color
			self.animations[widget_name .. "_hover"] = self:animate_element_by_time(widget_hover_color, 1, widget_hover_color[1], alpha_hover, fade_in_time)
		elseif button_hotspot.on_hover_exit then
			local bar_settings = UISettings.inventory.button_bars
			local fade_out_time = bar_settings.background.fade_out_time
			local widget_hover_color = widget.style.hover_texture.color
			self.animations[widget_name .. "_hover"] = self:animate_element_by_time(widget_hover_color, 1, widget_hover_color[1], 0, fade_out_time)
		end

		local item_list = self.item_list

		if button_hotspot.on_double_click or button_hotspot.on_right_click or self.gamepad_remove_item_id == item_list[i] then
			if widget.content.icon_texture_id then
				self.item_to_remove_index = i
			end
		elseif button_hotspot.on_pressed and item_list then
			local item_backend_id = item_list[i]
			self.pressed_item_backend_id = item_backend_id
		end
	end

	self.gamepad_remove_item_id = nil
	self.merge_request = nil
	local merge_button_widget = self.widgets_by_name.merge_button_widget
	local merge_button_content = merge_button_widget.content
	local merge_button_hotspot = merge_button_content.button_hotspot

	if merge_button_hotspot.on_hover_enter then
		self:play_sound("Play_hud_hover")
	end

	local _internal_merge_request = self._internal_merge_request

	if (not merge_button_hotspot.disabled and (merge_button_hotspot.on_release or self.gamepad_merge_request)) or _internal_merge_request then
		merge_button_hotspot.on_release = nil

		if not _internal_merge_request then
			local button_disabled = true
			local show_tokens = false

			self:set_merge_button_disabled(button_disabled, show_tokens)
			self:fill_remaining_slots_with_tokens()
		end

		self.merge_request = true
	end

	self.gamepad_merge_request = nil
	self._internal_merge_request = nil

	self:on_item_dragged()

	if self:is_dragging_started() then
		self:play_sound("Play_hud_inventory_pickup_item")
	end
end

ForgeMergeUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.parent:page_input_service()
	local gamepad_active = Managers.input:get_device("gamepad").active()
	local widgets_by_name = self.widgets_by_name
	local merging = self.merging
	local parent = self.parent
	local playing_door_animation = ((self.animations.door_left_widget_uv or parent:diplay_popup_active()) and true) or false
	local active_ui_renderer = (playing_door_animation and ui_renderer) or ui_top_renderer
	local active_input_service = (playing_door_animation and fake_input_service) or input_service

	if merging or playing_door_animation then
		UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, active_input_service, dt, nil, self.render_settings)
		UIRenderer.draw_widget(ui_top_renderer, widgets_by_name.door_left_widget)
		UIRenderer.draw_widget(ui_top_renderer, widgets_by_name.door_right_widget)
		UIRenderer.end_pass(ui_top_renderer)
	end

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, active_input_service, dt, nil, self.render_settings)

	for widget_name, widget in pairs(widgets_by_name) do
		if (widget_name ~= "door_left_widget" and widget_name ~= "door_right_widget") or (not merging and not playing_door_animation) then
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	UIRenderer.end_pass(ui_renderer)
end

ForgeMergeUI.is_dragging_started = function (self)
	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]

		if widget.content.on_drag_started then
			return true
		end
	end
end

ForgeMergeUI.on_item_hover_enter = function (self)
	if self.merging then
		return
	end

	local widgets_by_name = self.widgets_by_name

	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = widgets_by_name[widget_name]
		local button_hotspot = widget.content.button_hotspot

		if button_hotspot.on_hover_enter then
			local item_backend_id = self.item_list[i]

			return i, item_backend_id
		end
	end
end

ForgeMergeUI.on_item_hover_exit = function (self)
	if self.merging then
		return
	end

	local widgets_by_name = self.widgets_by_name

	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = widgets_by_name[widget_name]
		local button_hotspot = widget.content.button_hotspot

		if button_hotspot.on_hover_exit then
			local item_backend_id = self.item_list[i]

			return i, item_backend_id
		end
	end
end

ForgeMergeUI.is_slot_hovered = function (self, is_dragging_item)
	local hovered_slot_index = nil
	local drag_hover_color = drag_colors.hover
	local drag_normal_color = drag_colors.normal

	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]
		local button_hotspot = widget.content.button_hotspot
		local style = widget.style.drag_select_frame

		if is_dragging_item and not widget.content.icon_texture_id then
			if button_hotspot.internal_is_hover then
				style.color[1] = drag_hover_color[1]
				style.color[2] = drag_hover_color[2]
				style.color[3] = drag_hover_color[3]
				style.color[4] = drag_hover_color[4]
				hovered_slot_index = i
			else
				style.color[1] = drag_normal_color[1]
				style.color[2] = drag_normal_color[2]
				style.color[3] = drag_normal_color[3]
				style.color[4] = drag_normal_color[4]
			end
		else
			style.color[1] = 0
		end
	end

	return hovered_slot_index
end

ForgeMergeUI.on_dragging_item_stopped = function (self)
	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]

		if widget.content.on_drag_stopped then
			local backend_item_id = self.item_list[i]

			return backend_item_id
		end
	end
end

ForgeMergeUI.on_item_dragged = function (self)
	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]
		local content = widget.content
		local icon_color = widget.style.icon_texture_id.color

		if content.is_dragging and icon_color[1] ~= 150 then
			icon_color[1] = 150
		elseif content.on_drag_stopped and icon_color[1] ~= 255 then
			icon_color[1] = 255
		end
	end
end

ForgeMergeUI.add_item = function (self, backend_item_id, specific_slot_index)
	local merge_button_widget = self.widgets_by_name.merge_button_widget

	if self.charging or merge_button_widget.content.show_cancel_text then
		local force_cancel = true

		self:abort_charge_progress(force_cancel)
	end

	specific_slot_index = nil
	self.specific_slot_index = nil
	local item_data = BackendUtils.get_item_from_masterlist(backend_item_id)
	local icon_texture = item_data.inventory_icon

	for i = 1, num_item_buttons, 1 do
		if self.item_list[i] == backend_item_id then
			return false
		end
	end

	local item_rarity = item_data.rarity
	local current_item_rarity_index = rarity_order[item_rarity]
	local merge_rarity = item_data.rarity

	for rarity, index in pairs(rarity_order) do
		if index == current_item_rarity_index + 1 then
			merge_rarity = rarity

			break
		end
	end

	local merge_cost_settings = ForgeSettings.merge_cost[item_rarity]
	local token_type = merge_cost_settings.token_type
	local token_texture = merge_cost_settings.token_texture
	self.token_merge_type = token_type
	self.merge_rarity_color = Colors.get_table(merge_rarity)
	self.current_rarity_color = Colors.get_table(item_rarity)
	self.current_rarity = item_rarity
	local is_added = false
	local i = specific_slot_index or 1

	while true do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]

		if not widget.content.icon_texture_id then
			widget.content.icon_texture_id = icon_texture
			widget.style.icon_frame_texture_id.color = table.clone(self.current_rarity_color)
			self.item_list[i] = backend_item_id
			is_added = true

			break
		elseif specific_slot_index then
			break
		elseif i ~= num_item_buttons then
			i = i + 1
		else
			break
		end
	end

	if is_added then
		self:play_sound("Play_hud_inventory_drop_item")
	end

	local num_items = table.size(self.item_list)
	self.num_items_to_merge = num_items

	self:set_reward_texture()
	self:update_token_cost()
	self:update_token_cost_display()
	self:update_description_text()
	self:update_melted_iron_trail()

	return is_added
end

ForgeMergeUI.fill_remaining_slots_with_tokens = function (self, remove_all_tokens)
	if remove_all_tokens then
	end

	local texture_id = (self.num_items_to_merge > 0 and ForgeSettings.token_textures_by_type[self.token_merge_type] .. "_large") or nil

	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]

		if not widget.content.icon_texture_id then
			widget.content.bg_overlay_texture_id = texture_id
			widget.style.icon_frame_texture_id.color = table.clone(self.current_rarity_color)
		end
	end

	if not remove_all_tokens then
		local force_fill = true

		self:update_melted_iron_trail(force_fill)
	end
end

ForgeMergeUI.clear_tokens_in_slots = function (self)
	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]
		widget.content.bg_overlay_texture_id = nil
	end
end

ForgeMergeUI.update_melted_iron_trail = function (self, force_fill)
	local widgets_by_name = self.widgets_by_name
	local num_items_to_merge = self.num_items_to_merge
	local all_items_added = num_items_to_merge == 5
	local melt_trail_animation_event_names = {}
	local default_animation_time = 0.2
	local wait_time = 0
	local is_missing_item = false
	local is_missing_next_item = false

	for i = 1, 6, 1 do
		local slot_texture = string.format("melted_iron_%d", i)
		local slot_trail_texture = string.format("melted_iron_%d_link", i)
		local slot_texture_widget = widgets_by_name[slot_texture]
		local slot_trail_texture_widget = widgets_by_name[slot_trail_texture]

		if not is_missing_item then
			local current_widget_name = "item_button_" .. i .. "_widget"
			local current_widget = widgets_by_name[current_widget_name]

			if current_widget and not current_widget.content.icon_texture_id and not current_widget.content.bg_overlay_texture_id then
				is_missing_item = true
			end
		end

		if not is_missing_next_item then
			local next_widget_name = "item_button_" .. i + 1 .. "_widget"
			local next_widget = widgets_by_name[next_widget_name]

			if next_widget and not next_widget.content.icon_texture_id and not next_widget.content.bg_overlay_texture_id then
				is_missing_next_item = true
			end
		end

		local slot_visible = force_fill or (not is_missing_item and i <= num_items_to_merge) or (all_items_added and i <= 6)
		local trail_visible = force_fill or (not is_missing_item and not is_missing_next_item and num_items_to_merge >= i + 1) or (all_items_added and i <= 6)

		if slot_texture_widget then
			slot_texture_widget.content.visible = slot_visible
		end

		if slot_trail_texture_widget then
			if type(slot_trail_texture_widget.content.texture_id) == "string" then
				slot_trail_texture_widget.content.visible = trail_visible
			else
				slot_trail_texture_widget.content.texture_id.visible = trail_visible
			end
		end

		if slot_visible then
			local current_gradient_threshold = slot_texture_widget.style.texture_id.gradient_threshold
			local animation_time = (1 - current_gradient_threshold) * default_animation_time

			if animation_time > 0 then
				local animation_name = "trail_" .. slot_texture
				self.animations[animation_name] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, slot_texture_widget.style.texture_id, "gradient_threshold", current_gradient_threshold, 1, animation_time, math.easeCubic)
				melt_trail_animation_event_names[#melt_trail_animation_event_names + 1] = animation_name
			end

			wait_time = wait_time + animation_time
		else
			local animation_name = "trail_" .. slot_texture
			self.animations[animation_name] = nil
			slot_texture_widget.style.texture_id.gradient_threshold = 0
		end

		if trail_visible then
			local current_gradient_threshold = slot_trail_texture_widget.style.texture_id.gradient_threshold
			local animation_time = (1 - current_gradient_threshold) * default_animation_time

			if animation_time > 0 then
				local animation_name = "trail_" .. slot_trail_texture
				self.animations[animation_name] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, slot_trail_texture_widget.style.texture_id, "gradient_threshold", current_gradient_threshold, 1, animation_time, math.easeCubic)

				if i == 6 then
					self.trail_complete_animation_name = animation_name
				end

				if i ~= 1 then
					melt_trail_animation_event_names[#melt_trail_animation_event_names + 1] = animation_name
				else
					self:play_sound("Play_hud_forge_melt_process")
				end
			end

			wait_time = wait_time + animation_time
		else
			local animation_name = "trail_" .. slot_trail_texture
			self.animations[animation_name] = nil
			slot_trail_texture_widget.style.texture_id.gradient_threshold = 0
		end
	end

	self.melt_trail_animation_event_names = (#melt_trail_animation_event_names > 0 and melt_trail_animation_event_names) or nil
end

ForgeMergeUI.on_trail_animation_complete = function (self)
	local num_items_to_merge = self.num_items_to_merge
	local no_items_added = num_items_to_merge == 0
	local all_items_added = num_items_to_merge == 5
	local enough_tokens = self:enough_tokens()

	if all_items_added then
		self:set_merge_button_disabled(false)
	end

	if num_items_to_merge < 5 and enough_tokens then
		self._internal_merge_request = true
	end

	self.trail_complete_animation_name = nil
end

ForgeMergeUI.is_merge_possible = function (self)
	local num_items_to_merge = self.num_items_to_merge
	local all_items_added = num_items_to_merge == 5
	local enough_tokens = self:enough_tokens()
	local trail_animation_complete = self.trail_complete_animation_name

	return not trail_animation_complete and (all_items_added or enough_tokens)
end

ForgeMergeUI.update_description_text = function (self)
	local widget = self.widgets_by_name.description_text_1
	local num_items_to_merge = self.num_items_to_merge
	local no_items_added = num_items_to_merge == 0
	local all_items_added = num_items_to_merge == 5
	local enough_tokens = self:enough_tokens()
	local disable_button = all_items_added or not enough_tokens

	self:set_merge_button_disabled(disable_button, not all_items_added and not no_items_added)

	if not all_items_added then
		local num_missing_items = 5 - num_items_to_merge
		local text = ""

		if enough_tokens and not no_items_added and not all_items_added then
			local localization_key = "dlc1_1_merge_description_1"
			local localization_text = Localize(localization_key)
			text = string.format(localization_text, num_missing_items)
		else
			local localization_key = (num_missing_items == 5 and "merge_description_1") or "merge_description_2"
			local localization_text = Localize(localization_key)
			text = string.format(localization_text, num_missing_items)
		end

		widget.content.text = text
		widget.style.text.localize = false
	else
		local text = Localize("merge_description_3")
		widget.content.text = text
		widget.style.text.localize = false
	end
end

ForgeMergeUI.enough_tokens = function (self)
	local token_merge_type = self.token_merge_type
	local num_items_to_merge = self.num_items_to_merge
	local tokens_required_to_merge = self.tokens_required_to_merge

	return (num_items_to_merge and tokens_required_to_merge and token_merge_type and tokens_required_to_merge <= BackendUtils.get_tokens(token_merge_type) and num_items_to_merge >= 1) or false
end

ForgeMergeUI.set_reward_texture = function (self, removing_all)
	local widget = self.widgets_by_name.item_reward_slot_widget
	local widget_content = widget.content
	local current_type = not removing_all and self:get_reward_type()

	if current_type then
		local reward_texture = "forge_icon_" .. current_type
		widget_content.icon_texture_id = reward_texture
		local merge_rarity_color = self.merge_rarity_color

		if merge_rarity_color then
			widget.style.icon_frame_texture_id.color = table.clone(merge_rarity_color)
		end
	else
		widget_content.icon_texture_id = nil
	end
end

ForgeMergeUI.get_reward_type = function (self)
	local num_items_to_merge = self.num_items_to_merge

	if not num_items_to_merge or num_items_to_merge <= 0 then
		return
	end

	local is_same_type = true
	local current_type = nil
	local item_list = self.item_list

	for i, backend_item_id in pairs(item_list) do
		if backend_item_id then
			local item_data = BackendUtils.get_item_from_masterlist(backend_item_id)

			if item_data then
				local item_type = item_data.item_type

				if current_type and current_type ~= item_type then
					is_same_type = false
				else
					current_type = item_type
				end
			end
		end
	end

	if is_same_type then
		return current_type
	end

	return "any"
end

ForgeMergeUI.set_merged_item = function (self, item_key)
	local item_data = ItemMasterList[item_key]
	local icon_texture = item_data.inventory_icon
	local item_name = item_data.name
	local item_rarity = item_data.rarity
end

ForgeMergeUI.clear_merged_item = function (self)
	return
end

ForgeMergeUI.remove_item = function (self, item_index, ignore_sound, removing_all)
	local merge_button_widget = self.widgets_by_name.merge_button_widget

	if self.charging or merge_button_widget.content.show_cancel_text then
		local force_cancel = true

		self:abort_charge_progress(force_cancel)
	end

	local widget_name = "item_button_" .. item_index .. "_widget"
	local widget = self.widgets_by_name[widget_name]
	local widget_hotspot = widget.content.button_hotspot

	if widget_hotspot.is_hover then
		widget_hotspot.on_hover_exit = true
	end

	local item_backend_id = self.item_list[item_index]

	if item_backend_id and not ignore_sound then
		self:play_sound("Play_hud_forge_item_remove")
	end

	widget.content.icon_texture_id = nil
	self.item_list[item_index] = nil
	local num_items = table.size(self.item_list)
	self.num_items_to_merge = num_items

	self:set_reward_texture(removing_all)
	self:update_token_cost()
	self:update_token_cost_display()
	self:update_description_text()
	self:update_melted_iron_trail()
	self:clear_tokens_in_slots()

	return item_backend_id
end

ForgeMergeUI.remove_item_by_id = function (self, backend_item_id)
	for i = 1, num_item_buttons, 1 do
		if self.item_list[i] == backend_item_id then
			self:remove_item(i)

			return
		end
	end
end

ForgeMergeUI.remove_all_items = function (self)
	local backend_ids = {}

	for i = 1, num_item_buttons, 1 do
		backend_ids[i] = self:remove_item(i, true, true)
	end

	self.num_items_to_merge = 0
	local remove_all_tokens = true

	self:fill_remaining_slots_with_tokens(remove_all_tokens)

	return backend_ids
end

ForgeMergeUI.get_items = function (self)
	return self.item_list, self.token_merge_type, self.tokens_required_to_merge
end

ForgeMergeUI.merge = function (self)
	self.merging = true
	local widgets_by_name = self.widgets_by_name

	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local animation_name = (i == 1 and "merge_animation") or widget_name
		local widget = widgets_by_name[widget_name]
		self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.glow_animation.color, 1, 0, 255, 0.4, math.easeOutCubic, UIAnimation.wait, 0.2, UIAnimation.function_by_time, widget.style.glow_animation.color, 1, 255, 0, 0.3, math.easeInCubic, UIAnimation.wait, 0.45)
		self.animations["icon_fadeout_" .. i] = UIAnimation.init(UIAnimation.wait, 0.4, UIAnimation.function_by_time, widget.style.icon_texture_id.color, 1, 255, 0, 0.01, math.easeInCubic)
		self.animations["frame_fadeout_" .. i] = UIAnimation.init(UIAnimation.wait, 0.4, UIAnimation.function_by_time, widget.style.icon_frame_texture_id.color, 1, 255, 0, 0.01, math.easeInCubic)
	end

	local item_reward_slot_widget = self.widgets_by_name.item_reward_slot_widget
	self.animations.reward_slot_glow = UIAnimation.init(UIAnimation.wait, 0.7, UIAnimation.function_by_time, item_reward_slot_widget.style.glow_animation.color, 1, 0, 255, 0.4, math.easeOutCubic, UIAnimation.wait, 0.25)

	for i = 1, 6, 1 do
		local melted_iron_frame = "melted_iron_" .. i
		local melted_iron_link = "melted_iron_" .. i .. "_link"
		local frame_widget = widgets_by_name[melted_iron_frame]
		local link_widget = widgets_by_name[melted_iron_link]
		self.animations[melted_iron_frame] = UIAnimation.init(UIAnimation.function_by_time, frame_widget.style.texture_id.color, 1, 255, 0, 0.6, math.easeOutCubic)
		self.animations[melted_iron_link] = UIAnimation.init(UIAnimation.function_by_time, link_widget.style.texture_id.color, 1, 255, 0, 0.6, math.easeOutCubic)
	end

	local door_left_widget = widgets_by_name.door_left_widget
	local left_door_default_size = self.scenegraph_definition.frame_door_left.size
	local left_door_current_size = self.ui_scenegraph.frame_door_left.size
	self.animations.door_slam = UIAnimation.init(UIAnimation.wait, 1.1)
	self.animations.door_left_widget_uv = UIAnimation.init(UIAnimation.wait, 0.9, UIAnimation.function_by_time, door_left_widget.content.texture_id.uvs[1], 1, 1, 0, 0.4, math.easeInCubic, UIAnimation.wait, 0.1, UIAnimation.function_by_time, door_left_widget.content.texture_id.uvs[1], 1, 0, 1, 0.5, math.easeOutCubic)
	self.animations.door_left_widget_size = UIAnimation.init(UIAnimation.wait, 0.9, UIAnimation.function_by_time, left_door_current_size, 1, 0, left_door_default_size[1], 0.4, math.easeInCubic, UIAnimation.wait, 0.1, UIAnimation.function_by_time, left_door_current_size, 1, left_door_default_size[1], 0, 0.5, math.easeOutCubic)
	local door_right_widget = widgets_by_name.door_right_widget
	local right_door_default_size = self.scenegraph_definition.frame_door_right.size
	local right_door_current_size = self.ui_scenegraph.frame_door_right.size
	self.animations.door_right_widget_uv = UIAnimation.init(UIAnimation.wait, 0.9, UIAnimation.function_by_time, door_right_widget.content.texture_id.uvs[2], 1, 0, 1, 0.4, math.easeInCubic, UIAnimation.wait, 0.1, UIAnimation.function_by_time, door_right_widget.content.texture_id.uvs[2], 1, 1, 0, 0.5, math.easeOutCubic)
	self.animations.door_right_widget_size = UIAnimation.init(UIAnimation.wait, 0.9, UIAnimation.function_by_time, right_door_current_size, 1, 0, right_door_default_size[1], 0.4, math.easeInCubic, UIAnimation.wait, 0.1, UIAnimation.function_by_time, right_door_current_size, 1, right_door_default_size[1], 0, 0.5, math.easeOutCubic)
	local merge_button_widget = widgets_by_name.merge_button_widget
	merge_button_widget.content.button_hotspot.disabled = true
end

ForgeMergeUI.animation_doors = function (self)
	return (self.animations.door_left_widget_uv and true) or false
end

ForgeMergeUI.on_reward_slot_glow_animation_complete = function (self)
	local max_alpha = 255

	for i = 1, 6, 1 do
		local melted_iron_frame = "melted_iron_" .. i
		local melted_iron_link = "melted_iron_" .. i .. "_link"
		local frame_widget = self.widgets_by_name[melted_iron_frame]
		local link_widget = self.widgets_by_name[melted_iron_link]
		frame_widget.style.texture_id.color[1] = max_alpha
		link_widget.style.texture_id.color[1] = max_alpha
	end

	for i = 1, num_item_buttons, 1 do
		local widget_name = "item_button_" .. i .. "_widget"
		local widget = self.widgets_by_name[widget_name]
		widget.style.glow_animation.color[1] = 0
		widget.style.icon_texture_id.color[1] = max_alpha
		widget.style.icon_frame_texture_id.color[1] = max_alpha
	end

	local item_reward_slot_widget = self.widgets_by_name.item_reward_slot_widget
	item_reward_slot_widget.style.glow_animation.color[1] = 0
end

ForgeMergeUI.merge_animation_complete = function (self)
	self.merging = nil
	self.merge_completed = true
end

ForgeMergeUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

ForgeMergeUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end

ForgeMergeUI.set_merge_button_disabled = function (self, is_disabled, show_tokens)
	local widgets_by_name = self.widgets_by_name
	local merge_button_widget = widgets_by_name.merge_button_widget
	merge_button_widget.content.button_hotspot.disabled = is_disabled
	merge_button_widget.content.is_disabled = is_disabled and not show_tokens
	merge_button_widget.content.show_tokens = show_tokens
	merge_button_widget.content.button_hotspot.is_selected = false
	merge_button_widget.content.button_hotspot.is_hover = false
end

ForgeMergeUI.update_token_cost = function (self)
	local num_items = table.size(self.item_list)
	local empty_slots = num_item_buttons - num_items
	local rarity = self.current_rarity
	local merge_cost_settings = ForgeSettings.merge_cost[rarity]
	local token_type = merge_cost_settings.token_type
	local costs = merge_cost_settings.cost
	local key_table = VaultForgeMergeKeyTable[rarity]
	local token_cost = (key_table[empty_slots] and Vault.withdraw_single_ex(key_table[empty_slots], costs[empty_slots])) or 0
	self.tokens_required_to_merge = token_cost or 0
end

ForgeMergeUI.update_token_cost_display = function (self)
	local merge_button_widget = self.widgets_by_name.merge_button_widget
	local merge_button_content = merge_button_widget.content
	local available_tokens = BackendUtils.get_tokens(self.token_merge_type)
	local needed_tokens = self.tokens_required_to_merge
	local can_afford = (needed_tokens and needed_tokens <= available_tokens) or false

	if needed_tokens and needed_tokens > 0 then
		local rarity = self.current_rarity
		local merge_cost_settings = ForgeSettings.merge_cost[rarity]
		local token_texture = merge_cost_settings.token_texture
		merge_button_content.texture_token_type = token_texture
		merge_button_content.token_text = needed_tokens .. " x"
		merge_button_content.text_field = Localize("merge")
		merge_button_content.text_field_center = Localize("merge")
	end

	if can_afford then
		merge_button_widget.style.token_text_selected.text_color = Colors.get_table("cheeseburger", 255)
		merge_button_widget.style.token_text.text_color = Colors.get_table("cheeseburger", 255)
		merge_button_widget.style.text_selected.text_color = Colors.get_table("cheeseburger", 255)
		merge_button_widget.style.text.text_color = Colors.get_table("cheeseburger", 255)
	else
		merge_button_widget.style.token_text_selected.text_color = Colors.get_table("red", 255)
		merge_button_widget.style.token_text.text_color = Colors.get_table("red", 255)
		merge_button_widget.style.text_selected.text_color = Colors.get_table("red", 255)
		merge_button_widget.style.text.text_color = Colors.get_table("red", 255)
	end
end

ForgeMergeUI.start_charge_progress = function (self)
	self.charging = true
	local animation_name = "gamepad_charge_progress"
	local animation_time = 1.5
	local from = 0
	local to = 307
	local widget = self.widgets_by_name.merge_button_widget
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, self.ui_scenegraph.merge_button_fill.size, 1, from, to, animation_time, math.ease_out_quad)
	self.animations[animation_name .. "_uv"] = UIAnimation.init(UIAnimation.function_by_time, widget.content.progress_fill.uvs[2], 1, 0, 1, animation_time, math.ease_out_quad)

	self:cancel_abort_animation()

	widget.content.charging = true
	widget.style.progress_fill.color[1] = 255

	self:play_sound("Play_hud_forge_charge")
end

ForgeMergeUI.abort_charge_progress = function (self, force_shutdown)
	local animation_name = "gamepad_charge_progress"
	self.animations[animation_name] = nil
	self.animations[animation_name .. "_uv"] = nil
	self.charging = nil
	self.ui_scenegraph.merge_button_fill.size[1] = 0

	self:play_sound("Stop_hud_forge_charge")

	if force_shutdown then
		self:cancel_abort_animation()
	else
		self:start_abort_animation()
	end
end

ForgeMergeUI.on_charge_complete = function (self)
	self.charging = nil
	self.gamepad_merge_request = true
	local widget = self.widgets_by_name.merge_button_widget
	widget.content.charging = false
	local animation_name = "progress_bar_complete"
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 0, 255, 0.2, math.easeCubic, UIAnimation.function_by_time, self.ui_scenegraph.merge_button_fill.size, 1, 0, 0, 0.01, math.easeCubic, UIAnimation.function_by_time, widget.style.progress_fill_glow.color, 1, 255, 0, 0.2, math.easeOutCubic)
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

ForgeMergeUI.start_abort_animation = function (self)
	local animation_name = "gamepad_charge_progress_abort"
	local from = 0
	local to = 255
	local widget = self.widgets_by_name.merge_button_widget
	widget.style.progress_fill.color[1] = 0
	widget.content.show_cancel_text = true
	widget.content.charging = false
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, from, to, 0.2, math.easeInCubic, UIAnimation.wait, 0.3, UIAnimation.function_by_time, widget.style.text_charge_cancelled.text_color, 1, to, from, 0.3, math.easeInCubic)
	self.animations[animation_name .. "2"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.token_text.text_color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "3"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.texture_token_type.color, 1, from, to, 0.3, math.easeInCubic)
	self.animations[animation_name .. "4"] = UIAnimation.init(UIAnimation.wait, 0.8, UIAnimation.function_by_time, widget.style.text.text_color, 1, from, to, 0.3, math.easeInCubic)
end

ForgeMergeUI.cancel_abort_animation = function (self)
	local animations = self.animations
	animations.gamepad_charge_progress_abort = nil
	animations.progress_bar_complete = nil

	for i = 2, 4, 1 do
		animations["gamepad_charge_progress_abort" .. i] = nil
	end

	for i = 2, 5, 1 do
		animations["progress_bar_complete" .. i] = nil
	end

	local widget = self.widgets_by_name.merge_button_widget
	widget.content.charging = false
	widget.content.show_cancel_text = false
	widget.style.progress_fill.color[1] = 0
	widget.style.text_charge_cancelled.text_color[1] = 0
	widget.style.texture_token_type.color[1] = 255
	widget.style.text_disabled.text_color[1] = 255
	widget.style.token_text.text_color[1] = 255
	widget.style.text.text_color[1] = 255
end

ForgeMergeUI.on_charge_animations_complete = function (self, animation_name)
	if animation_name == "gamepad_charge_progress" then
		self:on_charge_complete()
	end

	if animation_name == "gamepad_charge_progress_abort" then
		local widget = self.widgets_by_name.merge_button_widget
		widget.content.show_cancel_text = false
	end
end

ForgeMergeUI.on_gamepad_activated = function (self)
	local input_service = self.input_manager:get_service("forge_view")
	local button_texture_data = UISettings.get_gamepad_input_texture_data(input_service, "refresh", true)
	local button_texture = button_texture_data.texture
	local button_size = button_texture_data.size
	local widget = self.widgets_by_name.merge_button_widget
	widget.content.progress_input_icon = button_texture
end

ForgeMergeUI.on_gamepad_deactivated = function (self)
	return
end

ForgeMergeUI.set_active = function (self, active)
	self.active = active
	local widget = self.widgets_by_name.merge_button_widget

	if self.charging or widget.content.show_cancel_text then
		local force_cancel = true

		self:abort_charge_progress(force_cancel)
	end
end

return
