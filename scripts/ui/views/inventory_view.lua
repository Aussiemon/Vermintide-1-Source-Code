local animation_definitions = local_require("scripts/ui/views/inventory_view_animation_definitions")
local definitions = local_require("scripts/ui/views/inventory_view_definitions")

require("scripts/settings/inventory_settings")
require("scripts/ui/views/inventory_view_previewer")
require("scripts/managers/backend/backend_utils")
require("scripts/ui/views/inventory_equipment_ui")
require("scripts/ui/views/inventory_compare_ui")
require("scripts/ui/views/inventory_items_ui")

local RELOAD_INVENTORY_GUI = false
local generic_input_actions = {
	default = {
		{
			input_action = "l2_r2",
			priority = 0,
			description_text = "input_description_rotate_hero",
			ignore_keybinding = true
		},
		{
			input_action = "l1_r1",
			priority = 1,
			description_text = "input_description_toggle_hero",
			ignore_keybinding = true
		}
	},
	ingame = {}
}
local input_description_data = {
	gamepad_support = true,
	name = "inventory_view"
}
local input_actions = {
	equipment = {
		default = {
			{
				input_action = "confirm",
				priority = 4,
				description_text = "input_description_select"
			},
			{
				input_action = "back",
				priority = 5,
				description_text = "input_description_close"
			}
		}
	},
	items = {
		default = {
			{
				input_action = "confirm",
				priority = 4,
				description_text = "input_description_equip"
			},
			{
				input_action = "back",
				priority = 5,
				description_text = "input_description_back"
			}
		},
		equipped_item = {
			{
				input_action = "back",
				priority = 5,
				description_text = "input_description_back"
			}
		},
		equipped_trinket_item = {
			{
				input_action = "confirm",
				priority = 4,
				description_text = "input_description_remove"
			},
			{
				input_action = "back",
				priority = 5,
				description_text = "input_description_back"
			}
		}
	}
}
local PAGE_SPACING = definitions.PAGE_SPACING
local scenegraph_definition = definitions.scenegraph_definition
local SLOT_TYPES = InventorySettings.inventory_slot_types_button_index
InventoryView = class(InventoryView)
InventoryView.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	local input_manager = ingame_ui_context.input_manager
	self.world_manager = ingame_ui_context.world_manager
	self.input_manager = input_manager
	self.ingame_ui = ingame_ui_context.ingame_ui

	input_manager.create_input_service(input_manager, "inventory_menu", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "inventory_menu", "keyboard")
	input_manager.map_device_to_service(input_manager, "inventory_menu", "mouse")
	input_manager.map_device_to_service(input_manager, "inventory_menu", "gamepad")

	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.player_manager = ingame_ui_context.player_manager
	self.peer_id = ingame_ui_context.peer_id
	self.local_player_id = ingame_ui_context.local_player_id
	self.is_in_inn = ingame_ui_context.is_in_inn
	self.is_server = ingame_ui_context.is_server
	self.world = ingame_ui_context.world
	self.ui_animations = {}
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)

	rawset(_G, "my_global_ass_pointer", self)

	self.ui_pages = {
		equipment = InventoryEquipmentUI:new(self, scenegraph_definition.page_root_left.position, animation_definitions, ingame_ui_context),
		items = InventoryItemsUI:new(self, scenegraph_definition.page_root_center.position, PAGE_SPACING, animation_definitions, ingame_ui_context),
		compare = InventoryCompareUI:new(self, scenegraph_definition.page_root_right.position, animation_definitions, ingame_ui_context, "inventory_menu")
	}
	self.gamepad_pages = {
		equipment = self.ui_pages.equipment,
		items = self.ui_pages.items
	}

	self.ui_pages.items:sort_items_by_rarity(true)
	self.ui_pages.compare:set_title_text("inventory_screen_compare_button")
	self.create_ui_elements(self)

	local input_service = self.input_manager:get_service("inventory_menu")
	local number_of_actvie_descriptions = 5
	local gui_layer = scenegraph_definition.root.position[3]
	local input_description = (self.is_in_inn and generic_input_actions.default) or generic_input_actions.ingame
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, number_of_actvie_descriptions, gui_layer, input_description)

	self.menu_input_description:set_input_description(nil)

	return 
end
InventoryView.input_service = function (self)
	return self.input_manager:get_service("inventory_menu")
end
InventoryView.suspend = function (self)
	self.suspended = true

	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)

	for page_name, page in pairs(self.ui_pages) do
		if page.suspend then
			page.suspend(page)
		end
	end

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)

	return 
end
InventoryView.unsuspend = function (self)
	self.input_manager:block_device_except_service("inventory_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("inventory_menu", "mouse", 1)
	self.input_manager:block_device_except_service("inventory_menu", "gamepad", 1)

	for page_name, page in pairs(self.ui_pages) do
		if page.unsuspend then
			page.unsuspend(page)
		end
	end

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)

	self.suspended = nil

	return 
end
InventoryView.on_enter = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)
	self.input_manager:block_device_except_service("inventory_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("inventory_menu", "mouse", 1)
	self.input_manager:block_device_except_service("inventory_menu", "gamepad", 1)
	self.play_sound(self, "Play_hud_button_open")

	self.waiting_for_post_update_enter = true
	self.active = true

	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_on")

	return 
end
InventoryView.post_update_on_enter = function (self)
	local pages = self.ui_pages

	pages.equipment:on_enter()
	pages.items:on_enter()
	pages.compare:on_enter()

	local my_profile = self.profile_synchronizer:profile_by_peer(self.peer_id, self.local_player_id)
	local profile_name = SPProfiles[my_profile].display_name
	local items_page = pages.items
	local equipment_page = pages.equipment

	equipment_page.on_character_profile_selected(equipment_page, profile_name)
	items_page.set_selected_hero(items_page, profile_name)

	local first_selection_slot = InventorySettings.slots_by_name.slot_melee
	local first_selection_slot_type = first_selection_slot.type

	equipment_page.on_equipment_slot_selected(equipment_page, first_selection_slot)
	items_page.on_inventory_type_selected(items_page, first_selection_slot_type)

	local item = items_page.on_inventory_item_selected(items_page, 1)

	if item then
		self.compare_item_with_loadout_item(self, item.backend_id)
	end

	if not self.is_in_inn then
		pages.equipment:disable_other_characters()
	end

	self.waiting_for_post_update_enter = nil

	return 
end
InventoryView.on_exit = function (self)
	self.exiting = nil
	self.active = nil
	UIPasses.is_dragging_item = false
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_off")

	return 
end
InventoryView.post_update_on_exit = function (self)
	local pages = self.ui_pages

	pages.equipment:on_exit()
	pages.items:on_exit()
	pages.compare:on_exit()
	Managers.backend:commit()

	return 
end
InventoryView.destroy = function (self)
	self.menu_input_description:destroy()

	self.menu_input_description = nil
	local pages = self.ui_pages

	for page_name, page in pairs(pages) do
		page.destroy(page)
	end

	self.ui_pages = nil

	return 
end
InventoryView.exit = function (self, return_to_game)
	self.exiting = true

	self.play_sound(self, "Play_hud_button_close")

	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)

	return 
end
InventoryView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	return 
end
InventoryView.update_animations = function (self, dt)
	local ui_scenegraph = self.ui_scenegraph

	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil
		end
	end

	return 
end
InventoryView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self.background_widgets = {
		definitions.create_simple_texture_widget("large_frame_01", "menu_root")
	}
	local widget_definitions = definitions.widget_definitions
	self.title_widget = UIWidget.init(widget_definitions.title_widget)
	self.cancel_button_widget = UIWidget.init(widget_definitions.cancel_button)
	self.equip_button_widget = UIWidget.init(widget_definitions.equip_button)
	self.dead_space_filler = UIWidget.init(widget_definitions.dead_space_filler)
	self.dead_space_4k_filler = UIWidget.init(UIWidgets.create_4k_filler())

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
InventoryView.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "inventory_menu")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	for _, widget in ipairs(self.background_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.title_widget)
	UIRenderer.draw_widget(ui_renderer, self.dead_space_filler)
	UIRenderer.draw_widget(ui_renderer, self.dead_space_4k_filler)

	if not gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.equip_button_widget)
		UIRenderer.draw_widget(ui_renderer, self.cancel_button_widget)
	end

	UIRenderer.end_pass(ui_renderer)

	for ui_name, ui_page in pairs(self.ui_pages) do
		ui_page.draw(ui_page, dt)
	end

	if gamepad_active then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
InventoryView.update = function (self, dt)
	if self.waiting_for_post_update_enter then
		return 
	end

	if not self.transitioning(self) then
		local local_player = Managers.player:local_player()
		local player_unit = local_player and local_player.player_unit

		if not player_unit or (player_unit and not Unit.alive(player_unit)) then
			local return_to_game = not self.ingame_ui.menu_active

			self.exit(self, return_to_game)
		end
	end

	return 
end
InventoryView.post_update = function (self, dt)
	if RELOAD_INVENTORY_GUI then
		self.create_ui_elements(self)

		RELOAD_INVENTORY_GUI = false
	end

	if self.suspended then
		return 
	end

	local is_transitioning = nil

	if next(self.ui_animations) ~= nil or self.transitioning(self) then
		is_transitioning = true
	end

	self.update_animations(self, dt)

	if self.active then
		self.draw(self, dt)
	end

	self.handle_index_changes(self)

	for ui_name, ui_page in pairs(self.ui_pages) do
		ui_page.update(ui_page, dt, is_transitioning)

		if ui_page.draw_viewport then
			ui_page.draw_viewport(ui_page, dt)
		end
	end

	if not is_transitioning then
		local gamepad_active = self.input_manager:is_device_active("gamepad")

		if gamepad_active then
			if not self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = true

				self.on_gamepad_activated(self)
			end

			self.handle_gamepad_input(self, dt)
		elseif self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = false

			self.on_gamepad_deactivated(self)
		end

		self.handle_input(self, dt)
		self.handle_item_drag(self)
	end

	return 
end
InventoryView.handle_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "inventory_menu")
	local equip_button_widget = self.equip_button_widget
	local equip_button_hotspot = equip_button_widget.content.button_hotspot
	local cancel_button_widget = self.cancel_button_widget
	local cancel_button_hotspot = cancel_button_widget.content.button_hotspot

	if equip_button_hotspot.on_hover_enter or cancel_button_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if input_service.get(input_service, "toggle_menu") or cancel_button_hotspot.on_release then
		local return_to_game = not self.ingame_ui.menu_active

		self.exit(self, return_to_game)
	end

	return 
end
InventoryView.handle_item_drag = function (self)
	local pages = self.ui_pages
	local equipment_page = pages.equipment
	local items_page = pages.items
	local compare_page = pages.compare
	local dragged_stopped, dragged_list_item = items_page.on_dragging_item_stopped(items_page)
	local hovered_slot_index, hovered_slot = equipment_page.on_equipment_slot_hover(equipment_page, dragged_list_item)

	if dragged_stopped and hovered_slot_index and dragged_list_item.slot_type == hovered_slot.type then
		items_page.item_to_equip = dragged_list_item
		equipment_page.specific_equip_index = hovered_slot_index
	end

	return 
end
InventoryView.handle_index_changes = function (self)
	local pages = self.ui_pages
	local items_page = pages.items
	local equipment_page = pages.equipment
	local compare_page = pages.compare
	local equip_button_widget = self.equip_button_widget
	local equip_button_hotspot = equip_button_widget.content.button_hotspot
	local skip_select_sound = false
	local selected_item, is_equipped, active = items_page.selected_item(items_page)
	local can_remove_item = selected_item and selected_item.slot_type == "trinket" and is_equipped
	equip_button_hotspot.disabled = (not can_remove_item and not is_equipped and not active) or false
	self.equip_button_widget.content.text_field = (is_equipped and "input_description_remove_item") or "inventory_screen_equip_button"
	local item_to_equip = items_page.item_to_equip

	if item_to_equip then
		if equip_button_hotspot.on_release then
			self.play_sound(self, "Play_hud_select")
		end

		local success = equipment_page.equip_inventory_item(equipment_page, item_to_equip, equipment_page.specific_equip_index)

		if success then
			items_page.refresh_items_status(items_page)
		end
	elseif equip_button_hotspot.on_release then
		equip_button_hotspot.on_release = nil

		if selected_item then
			if can_remove_item then
				local remove_successful = equipment_page.remove_inventory_item(equipment_page, selected_item)

				self.play_sound(self, "Play_hud_select")
				items_page.refresh_items_status(items_page)
			elseif active and not is_equipped then
				local success = equipment_page.equip_inventory_item(equipment_page, selected_item, equipment_page.specific_equip_index)

				if success then
					items_page.refresh_items_status(items_page)
				end

				self.play_sound(self, "Play_hud_select")
			end
		end
	end

	local remove_slot_item_request_index = equipment_page.remove_slot_item_request_index
	local item_to_remove = items_page.item_to_remove

	if item_to_remove and item_to_remove.slot_type == "trinket" then
		local remove_successful = equipment_page.remove_inventory_item(equipment_page, item_to_remove, equipment_page.specific_equip_index)

		if remove_successful then
			items_page.refresh_items_status(items_page)
		end
	elseif remove_slot_item_request_index then
		local remove_successful = equipment_page.remove_inventory_item(equipment_page, nil, remove_slot_item_request_index)

		if remove_successful then
			items_page.refresh_items_status(items_page)
		end
	end

	local character_profile_changed = equipment_page.character_profile_changed

	if character_profile_changed then
		equipment_page.on_character_profile_selected(equipment_page, character_profile_changed)
		items_page.set_selected_hero(items_page, character_profile_changed)

		items_page.inventory_list_index_changed = 1
		skip_select_sound = true
	end

	local loadout_slot_changed = equipment_page.loadout_slot_changed
	local loadout_slot_index_pressed = equipment_page.loadout_slot_index_pressed

	if loadout_slot_changed then
		local slot = InventorySettings.slots_by_name[loadout_slot_changed]

		equipment_page.on_equipment_slot_selected(equipment_page, slot)
		items_page.on_inventory_type_selected(items_page, slot.type)

		local equipment_backend_id_selected = equipment_page.item_backend_id_selected(equipment_page)
		local equipement_item_list_index = items_page.index_by_backend_id(items_page, equipment_backend_id_selected)
		items_page.inventory_list_index_changed = equipement_item_list_index or 1
		skip_select_sound = true
	elseif loadout_slot_index_pressed then
		local equipment_backend_id_selected = equipment_page.item_backend_id_selected(equipment_page)
		local equipement_item_list_index = items_page.index_by_backend_id(items_page, equipment_backend_id_selected)
		items_page.inventory_list_index_changed = equipement_item_list_index or 1
	end

	local slot_type_changed = items_page.slot_type_changed

	if slot_type_changed then
		items_page.on_inventory_type_selected(items_page, slot_type_changed)
		equipment_page.select_equipment_slot_by_slot(equipment_page, slot_type_changed)

		items_page.inventory_list_index_changed = 1
		skip_select_sound = true
	end

	local inventory_list_index_changed = items_page.inventory_list_index_changed

	if inventory_list_index_changed then
		local play_sound = not skip_select_sound
		local item = items_page.on_inventory_item_selected(items_page, inventory_list_index_changed, play_sound)

		if item then
			local item_backend_id = item and item.backend_id

			self.compare_item_with_loadout_item(self, item_backend_id)
		end

		items_page.inventory_list_index_changed = nil
	end

	return 
end
InventoryView.compare_item_with_loadout_item = function (self, item_backend_id)
	if not item_backend_id then
		return 
	end

	local pages = self.ui_pages
	local items_page = pages.items
	local compare_page = pages.compare
	local loadout_item_backend_id = nil
	local item = BackendUtils.get_item_from_masterlist(item_backend_id)
	local item_type = item.slot_type

	if item_type == "melee" or item_type == "ranged" then
		local selected_profile_name = items_page.current_profile_name(items_page)
		local slot_names_by_type = InventorySettings.slot_names_by_type
		local slots_by_name = InventorySettings.slots_by_name
		local slot_name = slot_names_by_type[item_type][1]
		local loadout_item = BackendUtils.get_loadout_item(selected_profile_name, slot_name)
		loadout_item_backend_id = loadout_item.backend_id
	end

	compare_page.on_item_selected(compare_page, item_backend_id, loadout_item_backend_id)

	return 
end
InventoryView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
InventoryView.on_gamepad_activated = function (self)
	local start_page = "equipment"

	self.set_gamepad_page_focus(self, start_page)

	return 
end
InventoryView.set_gamepad_page_focus = function (self, name)
	for page_name, page in pairs(self.gamepad_pages) do
		local page_enabled = page_name == name

		page.set_gamepad_focus(page, page_enabled)
	end

	self.gamepad_selected_page = name

	self.update_input_description(self)

	return 
end
InventoryView.update_input_description = function (self)
	local gamepad_selected_page = self.gamepad_selected_page
	local actions_name_to_use = nil

	if gamepad_selected_page == "items" then
		local page = self.gamepad_pages[gamepad_selected_page]
		local selected_item, is_equipped, is_active = page.selected_item(page)

		if is_equipped then
			if selected_item.slot_type == "trinket" then
				actions_name_to_use = "equipped_trinket_item"
			else
				actions_name_to_use = "equipped_item"
			end
		else
			actions_name_to_use = "default"
		end
	else
		actions_name_to_use = "default"
	end

	if not self.gamepad_active_actions_name or self.gamepad_active_actions_name ~= actions_name_to_use then
		self.gamepad_active_actions_name = actions_name_to_use
		local page_input_actions = input_actions[gamepad_selected_page]
		input_description_data.actions = page_input_actions[actions_name_to_use]

		self.menu_input_description:set_input_description(input_description_data)
	end

	return 
end
InventoryView.on_gamepad_deactivated = function (self)
	for page_name, page in pairs(self.gamepad_pages) do
		page.set_gamepad_focus(page, false)
	end

	self.gamepad_selected_page = nil

	return 
end
InventoryView.handle_gamepad_input = function (self, dt)
	self.update_input_description(self)

	local input_service = self.input_manager:get_service("inventory_menu")
	local gamepad_selected_page = self.gamepad_selected_page

	if gamepad_selected_page == "equipment" then
		if input_service.get(input_service, "confirm") then
			self.play_sound(self, "Play_hud_select")
			self.set_gamepad_page_focus(self, "items")
		elseif input_service.get(input_service, "back") then
			local return_to_game = not self.ingame_ui.menu_active

			self.exit(self, return_to_game)
			self.play_sound(self, "Play_hud_select")

			return 
		end
	elseif input_service.get(input_service, "back") then
		self.play_sound(self, "Play_hud_select")
		self.set_gamepad_page_focus(self, "equipment")
	end

	return 
end

return 
