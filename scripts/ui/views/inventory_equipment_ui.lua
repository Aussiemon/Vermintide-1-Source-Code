local definitions = local_require("scripts/ui/views/inventory_equipment_ui_definitions")
local NUM_PROFILE_BUTTONS = 5
local NUM_EQUIPMENT_SLOT_BUTTONS = 6
local button_index_profile_map = {
	"witch_hunter",
	"wood_elf",
	"dwarf_ranger",
	"bright_wizard",
	"empire_soldier"
}
local profile_map_by_button_index = {
	witch_hunter = 1,
	empire_soldier = 5,
	dwarf_ranger = 3,
	wood_elf = 2,
	bright_wizard = 4
}
local character_equipment_template = {
	hat = {},
	melee = {},
	ranged = {},
	trinket = {}
}
local drag_colors = {
	normal = Colors.get_color_table_with_alpha("drag_same_slot", 255),
	hover = Colors.get_color_table_with_alpha("drag_same_slot_hover", 255),
	disabled = Colors.get_color_table_with_alpha("drag_same_slot_disabled", 255)
}
local slot_button_index = {}

for index, slot in ipairs(InventorySettings.slots_by_inventory_button_index) do
	slot_button_index[index] = slot.type
end

local slot_by_button_index = InventorySettings.slots_by_inventory_button_index
InventoryEquipmentUI = class(InventoryEquipmentUI)

InventoryEquipmentUI.init = function (self, parent, window_position, animation_definitions, ingame_ui_context)
	self.parent = parent
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.player_manager = ingame_ui_context.player_manager
	self.world_manager = ingame_ui_context.world_manager
	self.input_manager = ingame_ui_context.input_manager
	self.is_in_inn = ingame_ui_context.is_in_inn
	self.peer_id = ingame_ui_context.peer_id
	self.inventory_previewer = InventoryViewPreviewer:new(ingame_ui_context)
	self.widgets_definitions = definitions.widgets
	self.scenegraph_definition = definitions.scenegraph_definition
	self.scenegraph_definition.page_root.position = window_position
	self.bar_animations = {}
	self.render_settings = {
		snap_pixel_positions = true
	}
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)

	self:create_ui_elements()

	self.ui_animator = UIAnimator:new(self.scenegraph_definition, animation_definitions)
end

InventoryEquipmentUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled
end

InventoryEquipmentUI.on_enter = function (self)
	local preview_viewport_widget = self.preview_viewport_widget or UIWidget.init(self.widgets_definitions.preview_viewport)
	self.preview_viewport_widget = preview_viewport_widget

	self.inventory_previewer:on_enter(preview_viewport_widget)
	self:update_equipment_slots_lock_state()
end

InventoryEquipmentUI.on_exit = function (self)
	self:destroy_preview_viewport_widget()
end

InventoryEquipmentUI.destroy_preview_viewport_widget = function (self)
	if self.preview_viewport_widget then
		self.inventory_previewer:prepare_exit()
		self.inventory_previewer:on_exit()
		UIWidget.destroy(self.ui_renderer, self.preview_viewport_widget)

		self.preview_viewport_widget = nil
	end
end

InventoryEquipmentUI.suspend = function (self)
	local preview_viewport_widget = self.preview_viewport_widget

	if preview_viewport_widget then
		local previewer_pass_data = preview_viewport_widget.element.pass_data[1]
		local viewport = previewer_pass_data.viewport
		local world = previewer_pass_data.world

		ScriptWorld.deactivate_viewport(world, viewport)
	end
end

InventoryEquipmentUI.unsuspend = function (self)
	local preview_viewport_widget = self.preview_viewport_widget

	if preview_viewport_widget then
		local previewer_pass_data = preview_viewport_widget.element.pass_data[1]
		local viewport = previewer_pass_data.viewport
		local world = previewer_pass_data.world

		ScriptWorld.activate_viewport(world, viewport)
	end
end

InventoryEquipmentUI.destroy = function (self)
	self:destroy_preview_viewport_widget()
	self.inventory_previewer:destroy()

	self.inventory_previewer = nil
	self.ui_animator = nil
end

InventoryEquipmentUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(self.scenegraph_definition)
	self.controller_window_highlight = definitions.create_simple_texture_widget("selected_window_glow", "window_background_glow")
	self.background_widgets = {
		definitions.create_simple_texture_widget("items_list_bg", "window_background"),
		definitions.create_simple_texture_widget("character_frame", "preview_foreground"),
		definitions.create_simple_texture_widget("character_frame_part", "preview_foreground_divider_1")
	}
	self.character_selection_bar_widget = UIWidget.init(definitions.character_selection_bar_widget)
	self.equipment_selection_bar_widget = UIWidget.init(definitions.equipment_selection_bar_widget)
	self.preview_viewport_overlay_widget = UIWidget.init(self.widgets_definitions.preview_viewport_overlay)
	self.preview_viewport_loading_widget = UIWidget.init(self.widgets_definitions.preview_viewport_loading)
	self.character_display_text_widget = UIWidget.init(self.widgets_definitions.character_display_text_widget)
	self.gamepad_slot_selection_widget = UIWidget.init(self.widgets_definitions.gamepad_slot_selection)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.preview_viewport_loading_widget.style.texture_id.color[1] = 0
end

InventoryEquipmentUI.handle_gamepad_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("inventory_menu")
	local use_gamepad = self.use_gamepad
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and controller_cooldown > 0 then
		self.controller_cooldown = controller_cooldown - dt
		local speed_multiplier = self.speed_multiplier or 1
		local decrease = GamepadSettings.menu_speed_multiplier_frame_decrease
		local min_multiplier = GamepadSettings.menu_min_speed_multiplier
		self.speed_multiplier = math.max(speed_multiplier - decrease, min_multiplier)

		return
	else
		if self.is_in_inn then
			local selected_profile_index = self.selected_profile_index

			if selected_profile_index then
				local new_profile_index = nil

				if input_service:get("cycle_next") then
					new_profile_index = math.min(selected_profile_index + 1, NUM_PROFILE_BUTTONS)
					self.controller_cooldown = GamepadSettings.menu_cooldown
				elseif input_service:get("cycle_previous") then
					new_profile_index = math.max(selected_profile_index - 1, 1)
					self.controller_cooldown = GamepadSettings.menu_cooldown
				end

				if new_profile_index and new_profile_index ~= selected_profile_index then
					self.gamepad_changed_profile_index = new_profile_index
				end
			end
		end

		local selected_equipment_index = self.selected_equipment_index

		if selected_equipment_index and use_gamepad then
			local speed_multiplier = self.speed_multiplier or 1
			local new_equipment_index = nil
			local move_down = input_service:get("move_down")
			local move_down_hold = input_service:get("move_down_hold")

			if move_down or move_down_hold then
				new_equipment_index = math.max(selected_equipment_index - 1, 1)
				self.controller_cooldown = GamepadSettings.menu_cooldown * speed_multiplier
			else
				local move_up = input_service:get("move_up")
				local move_up_hold = input_service:get("move_up_hold")

				if move_up or move_up_hold then
					new_equipment_index = math.min(selected_equipment_index + 1, NUM_EQUIPMENT_SLOT_BUTTONS)
					self.controller_cooldown = GamepadSettings.menu_cooldown * speed_multiplier
				end
			end

			if new_equipment_index and new_equipment_index ~= selected_equipment_index then
				self.gamepad_changed_equipment_index = new_equipment_index
			end
		end
	end

	self.speed_multiplier = 1
end

InventoryEquipmentUI.update = function (self, dt)
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("inventory_menu")
	local gamepad_active = input_manager:is_device_active("gamepad")

	self.ui_animator:update(dt)
	self.inventory_previewer:update(dt)
	self.inventory_previewer:handle_input(input_service)
	self.inventory_previewer:handle_controller_input(input_service, dt)

	if gamepad_active then
		self:handle_gamepad_input(dt)
	end

	self.specific_equip_index = nil
	local character_selection_bar_widget = self.character_selection_bar_widget
	local char_select_bar_content = character_selection_bar_widget.content
	local selected_profile_index = self.selected_profile_index
	self.character_profile_changed = nil

	for i = 1, NUM_PROFILE_BUTTONS, 1 do
		if (char_select_bar_content[i].on_pressed or self.gamepad_changed_profile_index == i) and i ~= selected_profile_index then
			self:play_sound("Play_hud_next_tab")

			self.character_profile_changed = button_index_profile_map[i]

			break
		end
	end

	local equipment_selection_bar_widget = self.equipment_selection_bar_widget
	local equipment_selection_content = equipment_selection_bar_widget.content
	local selected_equipment_index = self.selected_equipment_index
	self.remove_slot_item_request_index = nil

	for i = 1, NUM_EQUIPMENT_SLOT_BUTTONS, 1 do
		if not self:is_slot_locked(i) then
			local hotspot = equipment_selection_content[i]

			if hotspot.on_double_click or hotspot.on_right_click then
				if hotspot.on_right_click or (selected_equipment_index == i and hotspot.on_double_click) then
					self:play_sound("Play_hud_select")
				end

				self.remove_slot_item_request_index = i

				break
			end
		end
	end

	self.loadout_slot_changed = nil
	self.loadout_slot_index_pressed = nil

	for i = 1, NUM_EQUIPMENT_SLOT_BUTTONS, 1 do
		if equipment_selection_content[i].on_pressed or self.gamepad_changed_equipment_index == i then
			if not self:is_slot_locked(i) and i ~= selected_equipment_index then
				self:play_sound("Play_hud_select")

				self.loadout_slot_changed = slot_by_button_index[i].name

				break
			end

			self.loadout_slot_index_pressed = i

			break
		end
	end

	self:update_button_bar_animation(self.character_selection_bar_widget, "character_selection", dt)
	self:update_button_bar_animation(self.equipment_selection_bar_widget, "equipment_selection", dt)

	self.gamepad_changed_profile_index = nil
	self.gamepad_changed_equipment_index = nil

	if self.fade_out_on_items_loaded and self.inventory_previewer:items_spawned() then
		self:preview_overlay_fade_out()

		self.fade_out_on_items_loaded = nil
	end
end

InventoryEquipmentUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("inventory_menu")
	local gamepad_active = input_manager:is_device_active("gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	if gamepad_active and self.use_gamepad then
		UIRenderer.draw_widget(ui_renderer, self.controller_window_highlight)
		UIRenderer.draw_widget(ui_renderer, self.gamepad_slot_selection_widget)
	end

	for _, widget in ipairs(self.background_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.character_display_text_widget)
	UIRenderer.draw_widget(ui_renderer, self.equipment_selection_bar_widget)
	UIRenderer.end_pass(ui_renderer)
	UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_top_renderer, self.character_selection_bar_widget)
	UIRenderer.end_pass(ui_top_renderer)
end

InventoryEquipmentUI.draw_viewport = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("inventory_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	if self.preview_viewport_widget then
		UIRenderer.draw_widget(ui_renderer, self.preview_viewport_widget)
	end

	UIRenderer.end_pass(ui_renderer)
	self:rotate_loading_icon(dt)
	UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_top_renderer, self.preview_viewport_loading_widget)
	UIRenderer.draw_widget(ui_top_renderer, self.preview_viewport_overlay_widget)
	UIRenderer.end_pass(ui_top_renderer)
end

InventoryEquipmentUI.rotate_loading_icon = function (self, dt)
	local loading_icon_style = self.preview_viewport_loading_widget.style.texture_id
	local angle_fraction = loading_icon_style.fraction or 0
	angle_fraction = (angle_fraction + dt) % 1
	local anim_fraction = math.easeOutCubic(angle_fraction)
	local angle = anim_fraction * math.degrees_to_radians(360)
	loading_icon_style.angle = angle
	loading_icon_style.fraction = angle_fraction
end

InventoryEquipmentUI.disable_other_characters = function (self)
	local character_selection_bar_widget = self.character_selection_bar_widget
	local char_select_bar_content = character_selection_bar_widget.content
	local selected_profile_index = self.selected_profile_index

	for i = 1, NUM_PROFILE_BUTTONS, 1 do
		char_select_bar_content[i].disable_button = selected_profile_index ~= i
	end
end

InventoryEquipmentUI.get_player_level = function (self)
	local experience = ExperienceSettings.max_experience
	local prestige = 0
	local backend_manager = Managers.backend

	if backend_manager:available() and backend_manager:profiles_loaded() then
		experience = ScriptBackendProfileAttribute.get("experience")
	end

	local level = ExperienceSettings.get_level(experience)

	return level, prestige
end

InventoryEquipmentUI.update_equipment_slots_lock_state = function (self)
	local player_level, player_prestige_level = self:get_player_level()
	local slots = InventorySettings.slots_by_inventory_button_index
	local equipment_bar_widget = self.equipment_selection_bar_widget
	local equipment_bar_content = equipment_bar_widget.content

	for index = 1, NUM_EQUIPMENT_SLOT_BUTTONS, 1 do
		local locked_text_id = string.format("item_lock_text_%d", index)
		local locked_id = string.format("item_lock_%d", index)
		local slot = slots[index]
		local slot_name = slot.name
		local unlock_template = ProgressionUnlocks.get_unlock(slot_name)

		if not script_data.unlock_all_trinket_slots and unlock_template and not ProgressionUnlocks.is_unlocked(unlock_template.name, player_level, player_prestige_level) then
			local level_requirement = tostring(unlock_template.level_requirement)
			equipment_bar_content[locked_id] = true
			equipment_bar_content[locked_text_id] = level_requirement
		else
			equipment_bar_content[locked_id] = false
		end
	end
end

InventoryEquipmentUI.is_slot_locked = function (self, index)
	local equipment_bar_widget = self.equipment_selection_bar_widget
	local equipment_bar_content = equipment_bar_widget.content
	local locked_id = string.format("item_lock_%d", index)

	return equipment_bar_content[locked_id]
end

InventoryEquipmentUI.selected_profile_name = function (self)
	return self.current_selected_profile_name
end

InventoryEquipmentUI.current_profile_index = function (self)
	return self.selected_profile_index
end

InventoryEquipmentUI.current_equipment_index = function (self)
	return self.selected_equipment_index
end

InventoryEquipmentUI.on_character_profile_selected = function (self, profile_name)
	local selection_index = profile_map_by_button_index[profile_name]
	local bar_widget = self.character_selection_bar_widget
	local bar_content = bar_widget.content

	if self.selected_profile_index then
		local character_bar_select_anim_id = self.character_bar_select_anim_id

		if character_bar_select_anim_id then
			self.ui_animator:stop_animation(character_bar_select_anim_id)
		end

		self.ui_animator:start_animation("bar_item_deselect", bar_widget, self.scenegraph_definition, {
			scenegraph_base = "character_selection_bar",
			selected_index = self.selected_profile_index
		})
	end

	self.selected_profile_index = selection_index

	for i = 1, NUM_PROFILE_BUTTONS, 1 do
		bar_content[i].is_selected = i == selection_index
	end

	assert(button_index_profile_map[selection_index], "Missing profile type in index map in inventory_equipment_ui.lua")

	local sp_profile_index = FindProfileIndex(button_index_profile_map[selection_index])
	local sp_profile = SPProfiles[sp_profile_index]
	local ingame_display_name = sp_profile.ingame_display_name
	local display_name = sp_profile.display_name
	self.current_selected_profile_name = display_name
	local character_display_text_widget = self.character_display_text_widget
	local character_display_text_content = character_display_text_widget.content
	character_display_text_content.text_field = Localize(ingame_display_name)

	self.inventory_previewer:update_selected_character(sp_profile.display_name)

	self.character_bar_select_anim_id = self.ui_animator:start_animation("bar_item_select", bar_widget, self.scenegraph_definition, {
		scenegraph_base = "character_selection_bar",
		selected_index = selection_index
	})

	self:reset_equipment_slots()

	self.current_equipment = table.clone(character_equipment_template)
	local profile = sp_profile.display_name
	local slots = InventorySettings.slots

	for _, slot in pairs(slots) do
		local slot_name = slot.name
		local item_data = BackendUtils.get_loadout_item(profile, slot_name)
		local index = slot.inventory_button_index

		if item_data then
			self:equip_item(item_data, index)
		end
	end

	self:preview_overlay_fade_in(255)

	self.fade_out_on_items_loaded = true
end

InventoryEquipmentUI.item_backend_id_selected = function (self)
	local selected_equipment_index = self.selected_equipment_index
	local backend_id = self.current_equipment[selected_equipment_index]

	return backend_id
end

InventoryEquipmentUI.select_equipment_slot_by_slot = function (self, slot_type)
	local num_slot_buttons = #slot_button_index

	for i = num_slot_buttons, 1, -1 do
		if slot_button_index[i] == slot_type then
			self:on_equipment_slot_selected(slot_by_button_index[i])

			break
		end
	end
end

InventoryEquipmentUI.on_equipment_slot_selected = function (self, slot)
	local selection_index = slot.inventory_button_index
	local equipment_selection_bar_widget = self.equipment_selection_bar_widget
	local equipment_selection_content = equipment_selection_bar_widget.content
	local equipment_selection_style = equipment_selection_bar_widget.style
	local animate = selection_index ~= self.selected_equipment_index

	if animate and self.selected_equipment_index then
		if self.equipment_bar_select_anim_id then
			self.ui_animator:stop_animation(self.equipment_bar_select_anim_id)
		end

		self.ui_animator:start_animation("item_deselect", equipment_selection_bar_widget, self.scenegraph_definition, {
			scenegraph_base = "character_equipment_bar",
			selected_index = self.selected_equipment_index
		})
	end

	self.selected_equipment_index = selection_index

	for i = 1, NUM_EQUIPMENT_SLOT_BUTTONS, 1 do
		equipment_selection_content[i].is_selected = i == selection_index
	end

	local selected_slot_type = slot_button_index[selection_index]

	if selected_slot_type == "melee" or selected_slot_type == "ranged" then
		self.inventory_previewer:wield_weapon_slot(selected_slot_type)
	end

	if animate then
		self.equipment_bar_select_anim_id = self.ui_animator:start_animation("item_select", equipment_selection_bar_widget, self.scenegraph_definition, {
			scenegraph_base = "character_equipment_bar",
			selected_index = selection_index
		})
	end

	local gamepad_selection_id = string.format("gamepad_selection_%d", selection_index)
	local gamepad_selection_style = equipment_selection_style[gamepad_selection_id]

	if gamepad_selection_style then
		local scenegraph_id = gamepad_selection_style.scenegraph_id
		local texture_size = gamepad_selection_style.texture_size
		self.gamepad_slot_selection_widget.scenegraph_id = scenegraph_id
		local gamepad_widget_style = self.gamepad_slot_selection_widget.style
		gamepad_widget_style.texture_top_left.texture_size = texture_size
		gamepad_widget_style.texture_top_right.texture_size = texture_size
		gamepad_widget_style.texture_bottom_left.texture_size = texture_size
		gamepad_widget_style.texture_bottom_right.texture_size = texture_size
	end
end

InventoryEquipmentUI.trinkets_using_same_unique_id = function (self, trinket_backend_id, compare_trinket_backend_id)
	assert(trinket_backend_id, "[InventoryEquipmentUI] - Need backend id does not exist")
	assert(compare_trinket_backend_id, "[InventoryEquipmentUI] - Need backend id does not exist")

	local ItemMasterList = ItemMasterList
	local BuffTemplates = BuffTemplates
	local trinket_item = ScriptBackendItem.get_item_from_id(trinket_backend_id)
	local trinket_item_key = trinket_item.key
	local trinket_item_data = ItemMasterList[trinket_item_key]
	local trinket_trait = trinket_item_data.traits[1]

	if not trinket_trait then
		return false
	end

	local trinket_trait_unique_id = BuffTemplates[trinket_trait].unique_id
	local compare_trinket_item = ScriptBackendItem.get_item_from_id(compare_trinket_backend_id)
	local compare_trinket_item_key = compare_trinket_item.key
	local compare_trinket_item_data = ItemMasterList[compare_trinket_item_key]
	local compare_trinket_trait = compare_trinket_item_data.traits[1]

	if not compare_trinket_trait then
		return false
	end

	local compare_trinket_trait_unique_id = BuffTemplates[compare_trinket_trait].unique_id

	return trinket_trait_unique_id == compare_trinket_trait_unique_id, compare_trinket_item_data
end

InventoryEquipmentUI.remove_inventory_item = function (self, item_data, specific_slot_index)
	local player_manager = self.player_manager
	local player = player_manager:player_from_peer_id(self.peer_id)
	local player_profile_index = player.profile_index
	local unit = player.player_unit
	local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
	local resyncing_loadout = inventory_extension:resyncing_loadout()

	if resyncing_loadout or not Managers.state.network:game() then
		return
	end

	local slots = InventorySettings.slots_by_inventory_button_index
	local selected_equipment_index = specific_slot_index

	if not item_data then
		local equipment = self.current_equipment

		for i = 1, #slots, 1 do
			if i == selected_equipment_index then
				local equipped_item_backend_id = equipment[i]

				if not equipped_item_backend_id then
					return
				end

				local item = ScriptBackendItem.get_item_from_id(equipped_item_backend_id)
				local item_key = item.key
				item_data = ItemMasterList[item_key]

				break
			end
		end
	elseif not selected_equipment_index then
		local equipment = self.current_equipment
		local item_backend_id = item_data.backend_id

		for i = 1, #slots, 1 do
			local equipped_item_backend_id = equipment[i]

			if equipped_item_backend_id and equipped_item_backend_id == item_backend_id then
				selected_equipment_index = i

				break
			end
		end
	end

	if not selected_equipment_index then
		return
	end

	local profile_name = self:selected_profile_name()
	local selected_profile_index = FindProfileIndex(profile_name)
	local slot_type = item_data.slot_type
	local slot = slots[selected_equipment_index]
	local slot_name = slot.name

	if slot_type == "trinket" then
		if player_profile_index == selected_profile_index then
			local attachment_extension = ScriptUnit.extension(unit, "attachment_system")

			attachment_extension:remove_attachment(slot_name)
		end

		self:unequip_item(item_data, selected_equipment_index)
		BackendUtils.set_loadout_item(nil, profile_name, slot_name)

		self.current_equipment[selected_equipment_index] = nil

		self:play_sound("Play_hud_inventory_drop_item")

		return true
	end
end

InventoryEquipmentUI.equip_inventory_item = function (self, item_data, specific_slot_index)
	local player_manager = self.player_manager
	local player = player_manager:player_from_peer_id(self.peer_id)
	local player_profile_index = player.profile_index
	local unit = player.player_unit

	if not unit or not Unit.alive(unit) then
		return
	end

	local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
	local resyncing_loadout = inventory_extension:resyncing_loadout()

	if resyncing_loadout or not Managers.state.network:game() then
		return
	end

	local selected_equipment_index = specific_slot_index or self.specific_equip_index or self.selected_equipment_index

	if self:is_slot_locked(selected_equipment_index) then
		return
	end

	local equipment = self.current_equipment
	local backend_id = item_data.backend_id
	local profile_name = self:selected_profile_name()
	local selected_profile_index = FindProfileIndex(profile_name)
	local slot_type = item_data.slot_type
	local slots = InventorySettings.slots_by_inventory_button_index
	local slot = slots[selected_equipment_index]
	local slot_name = slot.name

	if slot_type == "trinket" then
		local current_equipped_item_backend_id = equipment[selected_equipment_index]

		if current_equipped_item_backend_id and current_equipped_item_backend_id == backend_id then
			return
		else
			local is_same_unique_id = current_equipped_item_backend_id and self:trinkets_using_same_unique_id(current_equipped_item_backend_id, backend_id)
			local _ = nil

			if current_equipped_item_backend_id and not is_same_unique_id then
				local trinket_slot_index = 3
				local new_slot_found = false

				while trinket_slot_index > 0 do
					local trinket_slot = slots[trinket_slot_index]
					local trinket_slot_name = trinket_slot.name
					local trinket_slot_item_backend_id = equipment[trinket_slot_index]

					if trinket_slot_item_backend_id then
						if trinket_slot_item_backend_id == backend_id then
							return
						end
					elseif not new_slot_found and not self:is_slot_locked(trinket_slot_index) then
						new_slot_found = true
						selected_equipment_index = trinket_slot_index
						slot_name = slots[trinket_slot_index].name
					end

					trinket_slot_index = trinket_slot_index - 1
				end
			end
		end

		if player_profile_index == selected_profile_index then
			local attachment_extension = ScriptUnit.extension(unit, "attachment_system")

			attachment_extension:create_attachment_in_slot(slot_name, backend_id)

			for i = 1, 3, 1 do
				local trinket_slot = slots[i]
				local trinket_slot_name = trinket_slot.name

				if trinket_slot_name ~= slot_name then
					local trinket_slot_item_backend_id = equipment[i]

					if trinket_slot_item_backend_id then
						local is_same_unique_id, compare_item_data = self:trinkets_using_same_unique_id(trinket_slot_item_backend_id, backend_id)

						if is_same_unique_id then
							attachment_extension:remove_attachment(trinket_slot_name)
							BackendUtils.set_loadout_item(nil, profile_name, trinket_slot_name)
							self:unequip_item(compare_item_data, i)
						end
					end
				end
			end
		else
			for i = 1, 3, 1 do
				local trinket_slot = slots[i]
				local trinket_slot_name = trinket_slot.name

				if trinket_slot_name ~= slot_name then
					local trinket_slot_item_backend_id = equipment[i]

					if trinket_slot_item_backend_id then
						local is_same_unique_id, compare_item_data = self:trinkets_using_same_unique_id(trinket_slot_item_backend_id, backend_id)

						if is_same_unique_id then
							BackendUtils.set_loadout_item(nil, profile_name, trinket_slot_name)
							self:unequip_item(compare_item_data, i)
						end
					end
				end
			end
		end
	end

	if slot_type == "hat" and player_profile_index == selected_profile_index then
		local attachment_extension = ScriptUnit.extension(unit, "attachment_system")

		attachment_extension:create_attachment_in_slot(slot_name, backend_id)
	end

	if (slot_type == "melee" or slot_type == "ranged") and player_profile_index == selected_profile_index then
		local slot = (slot_type == "melee" and "slot_melee") or "slot_ranged"
		local item_template = BackendUtils.get_item_template(item_data)
		local backend_id = item_data.backend_id
		local item_name = item_data.name

		inventory_extension:create_equipment_in_slot(slot, backend_id)
	end

	self:equip_item(item_data, selected_equipment_index)
	BackendUtils.set_loadout_item(item_data, profile_name, slot_name)
	self:play_sound("Play_hud_inventory_drop_item")

	return true
end

InventoryEquipmentUI.equip_item = function (self, item_data, specific_index)
	local backend_id = item_data.backend_id
	local item_name = item_data.name
	local item_slot_type = item_data.slot_type
	local item_inventory_icon = item_data.inventory_icon
	local selected_equipment_index = self.selected_equipment_index
	local equipment_slot_index = (specific_index and specific_index) or selected_equipment_index
	local equipment = self.current_equipment
	equipment[equipment_slot_index] = backend_id
	local equipment_bar_widget = self.equipment_selection_bar_widget
	local equipment_bar_style = equipment_bar_widget.style
	local equipment_bar_content = equipment_bar_widget.content
	local item_content_id = string.format("%s_%d", "item", equipment_slot_index)
	local item_frame_content_id = string.format("%s_%d", "item_frame", equipment_slot_index)
	equipment_bar_content[item_content_id] = item_inventory_icon
	equipment_bar_style[item_frame_content_id].color = Colors.get_table(item_data.rarity)

	self.inventory_previewer:equip_item(item_name, item_slot_type, equipment_slot_index)
	self:preview_overlay_fade_in(180)

	self.fade_out_on_items_loaded = true
end

InventoryEquipmentUI.unequip_item = function (self, item_data, specific_index)
	local item_slot_type = item_data.slot_type
	local selected_equipment_index = self.selected_equipment_index
	local equipment_slot_index = (specific_index and specific_index) or selected_equipment_index
	local equipment = self.current_equipment
	equipment[equipment_slot_index] = nil
	local equipment_bar_widget = self.equipment_selection_bar_widget
	local equipment_bar_content = equipment_bar_widget.content
	local item_content_id = string.format("%s_%d", "item", equipment_slot_index)
	equipment_bar_content[item_content_id] = nil

	self.inventory_previewer:unequip_item_in_slot(item_slot_type, equipment_slot_index)
end

InventoryEquipmentUI.reset_equipment_slots = function (self)
	local equipment_bar_widget = self.equipment_selection_bar_widget
	local equipment_bar_content = equipment_bar_widget.content

	for index = 1, NUM_EQUIPMENT_SLOT_BUTTONS, 1 do
		local item_content_id = string.format("%s_%d", "item", index)
		equipment_bar_content[item_content_id] = nil
	end
end

InventoryEquipmentUI.preview_overlay_fade_in = function (self, alpha)
	local widget = self.preview_viewport_loading_widget
	local style = widget.style
	local color = style.texture_id.color
	local animation = UIAnimation.init(UIAnimation.function_by_time, color, 1, color[1], alpha, 0.15, math.easeOutCubic)

	table.clear(widget.animations)

	widget.animations[animation] = true

	table.clear(self.preview_viewport_overlay_widget.animations)

	self.preview_viewport_overlay_widget.style.rect.color[1] = alpha
end

InventoryEquipmentUI.preview_overlay_fade_out = function (self)
	local function fade(widget, color)
		local animation = UIAnimation.init(UIAnimation.function_by_time, color, 1, color[1], 0, 0.2, math.easeOutCubic)

		table.clear(widget.animations)

		widget.animations[animation] = true
	end

	fade(self.preview_viewport_overlay_widget, self.preview_viewport_overlay_widget.style.rect.color)
	fade(self.preview_viewport_loading_widget, self.preview_viewport_loading_widget.style.texture_id.color)
end

InventoryEquipmentUI.on_item_hover_enter = function (self)
	local equipment = self.current_equipment
	local equipment_bar_widget = self.equipment_selection_bar_widget
	local equipment_bar_content = equipment_bar_widget.content

	for index = 1, NUM_EQUIPMENT_SLOT_BUTTONS, 1 do
		local button_hotspot = equipment_bar_content[index]

		if button_hotspot.on_hover_enter then
			return index, equipment[index]
		end
	end
end

InventoryEquipmentUI.on_item_hover_exit = function (self)
	local equipment = self.current_equipment
	local equipment_bar_widget = self.equipment_selection_bar_widget
	local equipment_bar_content = equipment_bar_widget.content

	for index = 1, NUM_EQUIPMENT_SLOT_BUTTONS, 1 do
		local button_hotspot = equipment_bar_content[index]

		if button_hotspot.on_hover_exit then
			return index, equipment[index]
		end
	end
end

InventoryEquipmentUI.on_equipment_slot_hover = function (self, dragged_item)
	local equipment_bar_widget = self.equipment_selection_bar_widget
	local equipment_bar_content = equipment_bar_widget.content
	local equipment_bar_style = equipment_bar_widget.style
	local is_dragging = dragged_item ~= nil
	local dragged_item_slot_type = dragged_item and dragged_item.slot_type
	local hovered_slot_index, hovered_slot = nil
	local drag_hover_color = drag_colors.hover
	local drag_normal_color = drag_colors.normal
	local drag_disabled_color = drag_colors.disabled

	for index = 1, NUM_EQUIPMENT_SLOT_BUTTONS, 1 do
		local locked_id = string.format("item_lock_%d", index)
		local drag_hover_style_name = string.format("drag_hover_style_%d", index)
		local drag_hover_style = equipment_bar_style[drag_hover_style_name]
		local button_hotspot = equipment_bar_content[index]
		local is_locked = equipment_bar_content[locked_id]
		local slot = slot_by_button_index[index]
		local is_same_slot_type = dragged_item_slot_type == slot.type

		if not is_locked and button_hotspot.internal_is_hover then
			if is_dragging and is_same_slot_type then
				drag_hover_style.color[1] = drag_hover_color[1]
				drag_hover_style.color[2] = drag_hover_color[2]
				drag_hover_style.color[3] = drag_hover_color[3]
				drag_hover_style.color[4] = drag_hover_color[4]
			elseif not is_dragging then
				drag_hover_style.color[1] = 0
			end

			hovered_slot = slot
			hovered_slot_index = index
		elseif is_same_slot_type then
			if not is_locked then
				drag_hover_style.color[1] = drag_normal_color[1]
				drag_hover_style.color[2] = drag_normal_color[2]
				drag_hover_style.color[3] = drag_normal_color[3]
				drag_hover_style.color[4] = drag_normal_color[4]
			else
				drag_hover_style.color[1] = drag_disabled_color[1]
				drag_hover_style.color[2] = drag_disabled_color[2]
				drag_hover_style.color[3] = drag_disabled_color[3]
				drag_hover_style.color[4] = drag_disabled_color[4]
			end
		else
			drag_hover_style.color[1] = 0
		end
	end

	return hovered_slot_index, hovered_slot
end

InventoryEquipmentUI.update_button_bar_animation = function (self, widget, widget_name, dt)
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

		if button_hotspot.on_hover_enter then
			if not is_selected then
				self:play_sound("Play_hud_hover")

				local background_fade_in_time = bar_settings.background.fade_in_time
				local icon_fade_in_time = bar_settings.icon.fade_in_time
				local background_alpha_hover = bar_settings.background.alpha_hover
				local icon_alpha_hover = bar_settings.icon.alpha_hover
				active_animations[button_style_name] = self:animate_element_by_time(button_style.color, 1, button_style.color[1], background_alpha_hover, background_fade_in_time)
				active_animations[icon_texture_id] = self:animate_element_by_time(icon_style.color, 1, icon_style.color[1], icon_alpha_hover, icon_fade_in_time)
			end
		elseif button_hotspot.on_hover_exit then
			local background_fade_out_time = bar_settings.background.fade_out_time
			local icon_fade_out_time = bar_settings.icon.fade_out_time
			local background_alpha_normal = (widget_name == "equipment_selection" and 0) or bar_settings.background.alpha_normal
			local icon_alpha_normal = bar_settings.icon.alpha_normal
			active_animations[button_style_name] = self:animate_element_by_time(button_style.color, 1, button_style.color[1], background_alpha_normal, background_fade_out_time)
			active_animations[icon_texture_id] = self:animate_element_by_time(icon_style.color, 1, icon_style.color[1], icon_alpha_normal, icon_fade_out_time)
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
end

InventoryEquipmentUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end

InventoryEquipmentUI.handle_character_preview_input = function (self)
	if self.rotate_left_widget.content.button_hotspot.is_clicked == 0 then
		self:start_character_rotation(0)
	elseif self.rotate_left_widget.content.button_hotspot.on_release then
		self:end_character_rotation()
	end

	if self.rotate_right_widget.content.button_hotspot.is_clicked == 0 then
		self:start_character_rotation(1)
	elseif self.rotate_right_widget.content.button_hotspot.on_release then
		self:end_character_rotation()
	end

	if self.zoom_in_widget.content.button_hotspot.is_clicked == 0 then
	elseif self.zoom_in_widget.content.button_hotspot.on_release then
	end

	if self.zoom_out_widget.content.button_hotspot.is_clicked == 0 then
	elseif self.zoom_out_widget.content.button_hotspot.on_release then
	end
end

InventoryEquipmentUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

return
