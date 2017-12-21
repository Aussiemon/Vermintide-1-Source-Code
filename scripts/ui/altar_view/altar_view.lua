-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
local definitions = local_require("scripts/ui/altar_view/altar_view_definitions")
local forge_animation_definitions = local_require("scripts/ui/views/inventory_view_animation_definitions")
local input_actions = definitions.input_actions

require("scripts/settings/equipment/item_master_list")
require("scripts/settings/altar_settings")
require("scripts/managers/backend/backend_utils")
require("scripts/ui/views/inventory_compare_ui")
require("scripts/ui/altar_view/altar_items_ui")
require("scripts/ui/altar_view/altar_trait_roll_ui")
require("scripts/ui/altar_view/altar_trait_proc_ui")
require("scripts/ui/altar_view/craft_confirmation_popup")
require("scripts/ui/forge_view/forge_logic")
require("scripts/ui/altar_view/altar_craft_ui")
require("scripts/ui/altar_view/altar_craft_ui_definitions")

local generic_input_actions = {
	{
		input_action = "l2_r2",
		priority = 1,
		description_text = "input_description_toggle_forge_tab",
		ignore_keybinding = true
	},
	{
		input_action = "l1_r1",
		priority = 2,
		description_text = "input_description_toggle_hero",
		ignore_keybinding = true
	},
	{
		input_action = "back",
		priority = 50,
		description_text = "input_description_back"
	}
}
local input_description_data = {
	gamepad_support = true,
	name = "inventory_view"
}
AltarView = class(AltarView)
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
AltarView.init = function (self, ingame_ui_context)
	self.world = ingame_ui_context.world
	self.player_manager = ingame_ui_context.player_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.peer_id = ingame_ui_context.peer_id
	self.local_player_id = ingame_ui_context.local_player_id
	self.is_server = ingame_ui_context.is_server
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager.create_input_service(input_manager, "enchantment_view", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "enchantment_view", "keyboard")
	input_manager.map_device_to_service(input_manager, "enchantment_view", "mouse")
	input_manager.map_device_to_service(input_manager, "enchantment_view", "gamepad")
	rawset(_G, "my_global_pointer", self)

	self.ui_animations = {}
	self.forge_logic = ForgeLogic:new(ingame_ui_context)
	local input_service = self.input_manager:get_service("enchantment_view")
	local number_of_actvie_descriptions = 8
	local gui_layer = UILayer.default
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, number_of_actvie_descriptions, gui_layer, generic_input_actions)

	self.menu_input_description:set_input_description(nil)
	self.create_ui_pages(self, ingame_ui_context)
	self.create_ui_elements(self)

	self.bar_animations = {}
	self.ui_animator = UIAnimator:new(self.ui_scenegraph, forge_animation_definitions)

	self.on_forge_selection_bar_index_changed(self, 1, true)

	self.ingame_ui_context = ingame_ui_context
	self.confirmation_popup = self.create_confirmation_popup(self)

	self.fit_title(self)

	return 
end
AltarView.fit_title = function (self)
	local style = self.widgets_by_name.title_widget.style.text
	local text = Localize(self.widgets_by_name.title_widget.content.text)
	local temp_vectors, temp_quaternions, temp_matrices = Script.temp_count()
	local continue = true

	repeat
		local font, scaled_font_size = UIFontByResolution(style)
		local text_width = UIRenderer.text_size(self.ui_renderer, text, font[1], scaled_font_size)

		Script.set_temp_count(temp_vectors, temp_quaternions, temp_matrices)

		if text_width <= 430 or style.font_size <= 1 then
			continue = false
		else
			style.font_size = style.font_size - 1
		end
	until not continue

	return 
end
AltarView.create_confirmation_popup = function (self)
	local context = {
		wwise_world = self.wwise_world,
		ui_renderer = self.ui_renderer,
		ui_top_renderer = self.ui_top_renderer,
		input_manager = self.input_manager
	}
	local position = definitions.scenegraph_definition.page_root_left.position

	return CraftConfirmationPopup:new(context, position)
end
AltarView.queue_popup = function (self, text, ...)
	return self.confirmation_popup:queue_popup(text, ...)
end
AltarView.cancel_popup = function (self, popup_id)
	self.confirmation_popup:cancel_popup(popup_id)

	return 
end
AltarView.cancel_all_popups = function (self)
	self.confirmation_popup:cancel_all_popups()

	return 
end
AltarView.page_input_service = function (self)
	return (self.input_blocked and fake_input_service) or self.input_manager:get_service("enchantment_view")
end
AltarView.input_service = function (self)
	local confirmation_popup = self.confirmation_popup

	if confirmation_popup.active_popup(confirmation_popup) then
		return confirmation_popup.input_service(confirmation_popup)
	end

	return self.input_manager:get_service("enchantment_view")
end
AltarView.create_ui_pages = function (self, ingame_ui_context)
	local items_ui_position = definitions.scenegraph_definition.items_ui_page.position
	local scenegraph_definition = definitions.scenegraph_definition
	local items_ui_page = AltarItemsUI:new(self, scenegraph_definition.page_root_center.position, forge_animation_definitions, ingame_ui_context)
	local trait_roll_ui_page = AltarTraitRollUI:new(self, scenegraph_definition.page_root_left.position, forge_animation_definitions, ingame_ui_context)
	local trait_proc_ui_page = AltarTraitProcUI:new(self, scenegraph_definition.page_root_left.position, forge_animation_definitions, ingame_ui_context)
	local craft_ui_page = AltarCraftUI:new(self, scenegraph_definition.page_root_left.position, forge_animation_definitions, ingame_ui_context)
	local compare_ui_page = InventoryCompareUI:new(self, scenegraph_definition.page_root_right.position, forge_animation_definitions, ingame_ui_context, "enchantment_view")
	items_ui_page.active = true
	compare_ui_page.active = true
	trait_roll_ui_page.active = false
	trait_proc_ui_page.active = false
	craft_ui_page.active = false

	compare_ui_page.set_title_text(compare_ui_page, "inventory_screen_compare_button")

	self.ui_pages = {
		items = items_ui_page,
		compare = compare_ui_page,
		trait_reroll = trait_roll_ui_page,
		trait_proc = trait_proc_ui_page,
		craft = craft_ui_page
	}
	self.ui_tab_pages = {
		trait_reroll = trait_roll_ui_page,
		trait_proc = trait_proc_ui_page,
		craft = craft_ui_page
	}

	return 
end
AltarView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.widgets = {}
	self.widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.widgets_definitions) do
		self.widgets_by_name[widget_name] = UIWidget.init(widget_definition)
		self.widgets[#self.widgets + 1] = self.widgets_by_name[widget_name]
	end

	self.token_widgets = {}
	local token_widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.token_widgets) do
		token_widgets_by_name[widget_name] = UIWidget.init(widget_definition)
		self.token_widgets[#self.token_widgets + 1] = token_widgets_by_name[widget_name]
	end

	self.token_widgets_by_name = token_widgets_by_name
	token_widgets_by_name.iron_tokens_glow.style.texture_id.color[1] = 0
	token_widgets_by_name.bronze_tokens_glow.style.texture_id.color[1] = 0
	token_widgets_by_name.silver_tokens_glow.style.texture_id.color[1] = 0
	token_widgets_by_name.gold_tokens_glow.style.texture_id.color[1] = 0
	self.forge_selection_bar_widget = self.widgets_by_name.forge_selection_bar
	self.exit_button_widget = self.widgets_by_name.exit_button_widget
	self.popup_close_widget = self.widgets_by_name.popup_close_widget
	self.page_left_glow_widget = UIWidget.init(definitions.gamepad_widgets_definitions.page_left_glow)
	self.page_center_glow_widget = UIWidget.init(definitions.gamepad_widgets_definitions.page_center_glow)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
AltarView.on_enter = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)

	local input_manager = self.input_manager

	input_manager.block_device_except_service(input_manager, "enchantment_view", "keyboard", 1)
	input_manager.block_device_except_service(input_manager, "enchantment_view", "mouse", 1)
	input_manager.block_device_except_service(input_manager, "enchantment_view", "gamepad", 1)
	self.create_display_item_popup(self)
	self.play_sound(self, "Play_hud_reroll_traits_open")

	self.active = true

	return 
end
AltarView.post_update_on_enter = function (self)
	local ui_pages = self.ui_pages

	for ui_name, ui_page in pairs(ui_pages) do
		ui_page.on_enter(ui_page)
	end

	local my_profile = self.profile_synchronizer:profile_by_peer(self.peer_id, self.local_player_id)
	local profile_name = SPProfiles[my_profile].display_name

	ui_pages.items:select_hero_by_name(profile_name, true)

	local selected_item = ui_pages.items:selected_item()
	local item_backend_id = selected_item and selected_item.backend_id

	self.compare_item_with_loadout_item(self, item_backend_id)
	self.refresh_tokens(self)

	return 
end
AltarView.on_exit = function (self)
	self.ui_pages.items:clear_disabled_backend_ids()
	self.close_item_display_popup(self)
	self.confirmation_popup:cancel_all_popups()

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)

	UIPasses.is_dragging_item = false
	self.exiting = nil
	self.active = nil

	return 
end
AltarView.exit = function (self, return_to_game)
	if self.menu_locked then
		if not self.popup_id then
			local text = Localize("dlc1_1_trait_roll_error_description")
			self.popup_id = Managers.popup:queue_popup(text, Localize("dlc1_1_trait_roll_error_topic"), "cancel_popup", Localize("popup_choice_ok"))
		end

		return 
	end

	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)
	self.play_sound(self, "Play_hud_reroll_traits_window_minimize")

	self.exiting = true

	self.ui_pages.items:on_focus_lost()

	return 
end
AltarView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	return 
end
AltarView.suspend = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)

	self.suspended = true

	return 
end
AltarView.unsuspend = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)
	self.input_manager:block_device_except_service("enchantment_view", "keyboard", 1)
	self.input_manager:block_device_except_service("enchantment_view", "mouse", 1)
	self.input_manager:block_device_except_service("enchantment_view", "gamepad", 1)

	self.suspended = nil

	return 
end
AltarView.update = function (self, dt)
	return 
end
AltarView.post_update = function (self, dt)
	if self.popup_id then
		local popup_result = Managers.popup:query_result(self.popup_id)

		if popup_result then
			self.popup_id = nil
		end
	end

	self.confirmation_popup:update(dt)

	local can_display_item_popup = self.can_display_item_popup

	if can_display_item_popup and self.craft_item_key then
		self.display_item_popup(self, self.craft_item_key)

		self.craft_item_key = nil
		self.can_display_item_popup = nil
	end

	local close_item_popup = self.close_item_popup

	if close_item_popup then
		local item_display_popup = self.item_display_popup

		if item_display_popup then
			item_display_popup.on_exit(item_display_popup)

			self.close_item_popup = nil

			self.on_item_display_popup_closed(self)
		end
	end

	if self.suspended then
		return 
	end

	local input_manager = self.input_manager
	local input_service = self.page_input_service(self)
	local transitioning = self.transitioning(self)

	self.ui_animator:update(dt)

	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil
		end
	end

	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local exit_button_widget = self.widgets_by_name.exit_button_widget

	if not self.active then
		return 
	end

	local forge_selection_bar = self.forge_selection_bar_widget

	if not transitioning then
		local forge_selection_bar_content = forge_selection_bar.content

		for i = 1, #forge_selection_bar_content, 1 do
			if not forge_selection_bar_content[i].disable_button and (forge_selection_bar_content[i].on_pressed or self.gamepad_changed_selection_bar_index == i) and i ~= self.selected_selection_bar_index then
				self.on_forge_selection_bar_index_changed(self, i)

				break
			end
		end

		self.gamepad_changed_selection_bar_index = nil

		if exit_button_widget.content.button_hotspot.on_hover_enter then
			self.play_sound(self, "Play_hud_hover")
		end

		if (not self.input_blocked and exit_button_widget.content.button_hotspot.on_release) or input_service.get(input_service, "toggle_menu") then
			local return_to_game = not self.ingame_ui.menu_active

			self.play_sound(self, "Play_hud_hover")
			self.exit(self, return_to_game)

			transitioning = self.transitioning(self)
		end
	end

	if not transitioning then
		self.handle_index_changes(self)
	end

	self.update_button_bar_animation(self, forge_selection_bar, "forge_selection_bar", dt)

	for ui_name, ui_page in pairs(self.ui_pages) do
		if ui_page.active then
			ui_page.update(ui_page, dt)
		end
	end

	if not transitioning then
		local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

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

		self.handle_item_drag(self)
	end

	if self.active then
		self.draw(self, dt)
	end

	if self.item_display_popup.active then
		self.item_display_popup:update(dt, self.input_manager:get_service("enchantment_view"))
	end

	return 
end
AltarView.on_forge_selection_bar_index_changed = function (self, index, ignore_sound)
	local forge_selection_bar = self.forge_selection_bar_widget
	local forge_selection_bar_content = forge_selection_bar.content

	for i = 1, #forge_selection_bar_content, 1 do
		forge_selection_bar_content[i].is_selected = i == index
	end

	if not ignore_sound then
		self.play_sound(self, "Play_hud_next_tab")
	end

	if index == 1 then
		self.select_craft_page(self, ignore_sound)
		self.set_gamepad_active_forge_page(self, "craft")
	elseif index == 2 then
		self.select_trait_reroll_page(self, ignore_sound)
		self.set_gamepad_active_forge_page(self, "trait_reroll")
	else
		self.select_trait_proc_page(self, ignore_sound)
		self.set_gamepad_active_forge_page(self, "trait_proc")
	end

	if self.selected_selection_bar_index then
		if self.forge_bar_select_anim_id then
			self.ui_animator:stop_animation(self.forge_bar_select_anim_id)
		end

		self.ui_animator:start_animation("bar_item_deselect", forge_selection_bar, definitions.scenegraph_definition, {
			scenegraph_base = "selection_bar",
			selected_index = self.selected_selection_bar_index
		})
	end

	self.forge_bar_select_anim_id = self.ui_animator:start_animation("bar_item_select", forge_selection_bar, definitions.scenegraph_definition, {
		scenegraph_base = "selection_bar",
		selected_index = index
	})
	self.selected_selection_bar_index = index

	return 
end
AltarView.set_menu_locked_state = function (self, is_locked)
	self.menu_locked = is_locked

	self.set_selection_bar_disabled(self, is_locked)

	return 
end
AltarView.set_selection_bar_disabled = function (self, disabled)
	local forge_selection_bar = self.forge_selection_bar_widget
	local forge_selection_bar_content = forge_selection_bar.content

	for i = 1, #forge_selection_bar_content, 1 do
		if i ~= self.selected_selection_bar_index then
			forge_selection_bar_content[i].disable_button = disabled
		end
	end

	return 
end
AltarView.select_craft_page = function (self, ignore_sound)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local compare_ui_page = ui_pages.compare
	local trait_proc_ui_page = ui_pages.trait_proc
	local trait_reroll_ui_page = ui_pages.trait_reroll
	local craft_ui_page = ui_pages.craft

	craft_ui_page.set_active(craft_ui_page, true)
	trait_proc_ui_page.set_active(trait_proc_ui_page, false)
	trait_reroll_ui_page.set_active(trait_reroll_ui_page, false)
	trait_proc_ui_page.remove_item(trait_proc_ui_page)
	trait_reroll_ui_page.remove_item(trait_reroll_ui_page)

	local accepted_rarities = {
		common = false,
		promo = true,
		exotic = false,
		plentiful = false,
		rare = false,
		unique = false
	}

	items_page.clear_disabled_backend_ids(items_page)
	items_page.set_accepted_rarities(items_page, accepted_rarities)
	items_page.set_disable_non_trait_items(items_page, false)
	items_page.set_disable_loadout_items(items_page, false)

	local item_filter = "item_key == trinket_class_bw or item_key == trinket_class_dr or item_key == trinket_class_es or item_key == trinket_class_we or item_key == trinket_class_wh"

	items_page.set_item_filter(items_page, item_filter)
	items_page.set_rarity(items_page, nil)
	items_page.set_drag_enabled(items_page, true)
	items_page.set_gamepad_focus(items_page, true)

	local slot_type_changed = items_page.set_selected_slot_type(items_page, "trinket")

	if slot_type_changed then
		items_page.refresh(items_page)
	end

	if not items_page.selected_item(items_page) then
		items_page.on_inventory_item_selected(items_page, 1)
	end

	local current_compare_item = compare_ui_page.item

	if current_compare_item then
		local selected_item = items_page.selected_item(items_page)

		if selected_item then
			local item_backend_id = selected_item and selected_item.backend_id
			local compare_item_backend_id = current_compare_item.backend_id

			if item_backend_id ~= compare_item_backend_id then
				self.compare_item_with_loadout_item(self, item_backend_id)
			end
		else
			compare_ui_page.clear_item_selected(compare_ui_page)
		end
	end

	if not ignore_sound then
		self.play_sound(self, "Play_hud_reroll_traits_switch_category3")
	end

	return 
end
AltarView.select_trait_reroll_page = function (self, ignore_sound)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local compare_ui_page = ui_pages.compare
	local trait_proc_ui_page = ui_pages.trait_proc
	local trait_reroll_ui_page = ui_pages.trait_reroll
	local craft_ui_page = ui_pages.craft

	craft_ui_page.set_active(craft_ui_page, false)
	trait_proc_ui_page.set_active(trait_proc_ui_page, false)
	trait_reroll_ui_page.set_active(trait_reroll_ui_page, true)
	craft_ui_page.remove_item(craft_ui_page)
	trait_proc_ui_page.remove_item(trait_proc_ui_page)

	local accepted_rarities = {
		common = true,
		exotic = true,
		plentiful = false,
		rare = true,
		unique = false
	}

	items_page.clear_disabled_backend_ids(items_page)
	items_page.set_accepted_rarities(items_page, accepted_rarities)
	items_page.set_disable_non_trait_items(items_page, false)
	items_page.set_disable_loadout_items(items_page, false)
	items_page.set_item_filter(items_page, nil)
	items_page.set_rarity(items_page, nil)
	items_page.set_drag_enabled(items_page, true)
	items_page.set_gamepad_focus(items_page, true)

	local slot_type_changed = items_page.set_selected_slot_type(items_page, "weapons")

	if slot_type_changed then
		items_page.refresh(items_page)
	end

	if not items_page.selected_item(items_page) then
		items_page.on_inventory_item_selected(items_page, 1)
	end

	local current_compare_item = compare_ui_page.item

	if current_compare_item then
		local selected_item = items_page.selected_item(items_page)

		if selected_item then
			local item_backend_id = selected_item and selected_item.backend_id
			local compare_item_backend_id = current_compare_item.backend_id

			if item_backend_id ~= compare_item_backend_id then
				self.compare_item_with_loadout_item(self, item_backend_id)
			end
		else
			compare_ui_page.clear_item_selected(compare_ui_page)
		end
	end

	if not ignore_sound then
		self.play_sound(self, "Play_hud_reroll_traits_switch_category1")
	end

	return 
end
AltarView.select_trait_proc_page = function (self, ignore_sound)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local compare_ui_page = ui_pages.compare
	local trait_proc_ui_page = ui_pages.trait_proc
	local trait_reroll_ui_page = ui_pages.trait_reroll
	local craft_ui_page = ui_pages.craft

	craft_ui_page.set_active(craft_ui_page, false)
	trait_proc_ui_page.set_active(trait_proc_ui_page, true)
	trait_reroll_ui_page.set_active(trait_reroll_ui_page, false)
	craft_ui_page.remove_item(craft_ui_page)
	trait_reroll_ui_page.remove_item(trait_reroll_ui_page)

	local accepted_rarities = {
		common = true,
		exotic = true,
		plentiful = false,
		rare = true,
		unique = false
	}

	items_page.clear_disabled_backend_ids(items_page)
	items_page.set_accepted_rarities(items_page, accepted_rarities)
	items_page.set_disable_non_trait_items(items_page, true)
	items_page.set_disable_loadout_items(items_page, false)
	items_page.set_item_filter(items_page, nil)
	items_page.set_rarity(items_page, nil)
	items_page.set_drag_enabled(items_page, true)
	items_page.set_gamepad_focus(items_page, true)

	local slot_type_changed = items_page.set_selected_slot_type(items_page, "weapons")

	if slot_type_changed then
		items_page.refresh(items_page)
	end

	if not items_page.selected_item(items_page) then
		items_page.on_inventory_item_selected(items_page, 1)
	end

	local current_compare_item = compare_ui_page.item

	if current_compare_item then
		local selected_item = items_page.selected_item(items_page)

		if selected_item then
			local item_backend_id = selected_item and selected_item.backend_id
			local compare_item_backend_id = current_compare_item.backend_id

			if item_backend_id ~= compare_item_backend_id then
				self.compare_item_with_loadout_item(self, item_backend_id)
			end
		else
			compare_ui_page.clear_item_selected(compare_ui_page)
		end
	end

	if not ignore_sound then
		self.play_sound(self, "Play_hud_reroll_traits_switch_category2")
	end

	return 
end
AltarView.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = self.page_input_service(self)
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local widgets_by_name = self.widgets_by_name

	UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt)

	local forge_selection_bar = self.forge_selection_bar_widget

	UIRenderer.draw_widget(ui_top_renderer, forge_selection_bar)
	UIRenderer.end_pass(ui_top_renderer)
	UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	local token_widgets = self.token_widgets

	for i = 1, #token_widgets, 1 do
		UIRenderer.draw_widget(ui_top_renderer, token_widgets[i])
	end

	UIRenderer.end_pass(ui_top_renderer)
	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	for widget_name, widget in pairs(widgets_by_name) do
		if widget_name ~= "exit_button_widget" and widget_name ~= "forge_selection_bar" then
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	if not gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.exit_button_widget)
	elseif not self.input_blocked then
		if self.ui_pages.items.use_gamepad then
			UIRenderer.draw_widget(ui_renderer, self.page_center_glow_widget)
		elseif self.ui_pages.craft.use_gamepad then
			UIRenderer.draw_widget(ui_renderer, self.page_left_glow_widget)
		end
	end

	UIRenderer.end_pass(ui_renderer)

	for ui_name, ui_page in pairs(self.ui_pages) do
		if ui_page.active then
			ui_page.draw(ui_page, dt)
		end
	end

	if gamepad_active and not self.popup_id then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
AltarView.handle_item_drag = function (self)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local compare_ui_page = ui_pages.compare
	local active_page = nil

	for page_name, page in pairs(self.ui_tab_pages) do
		if page.active then
			active_page = page

			break
		end
	end

	if active_page then
		local current_selected_list_index = items_page.current_selected_list_index(items_page)
		local dragged_upgrade_item_backend_id = active_page.on_dragging_item_stopped(active_page)

		if dragged_upgrade_item_backend_id and items_page.on_item_list_hover(items_page) then
			if active_page.can_remove_item(active_page) then
				active_page.remove_item(active_page)
				items_page.refresh_items_status(items_page)
				items_page.set_backend_id_disabled_state(items_page, dragged_upgrade_item_backend_id, false)
			end
		else
			local dragged_stopped, dragged_list_item = items_page.on_dragging_item_stopped(items_page)
			local slot_hovered = active_page.is_slot_hovered(active_page, dragged_list_item ~= nil)

			if dragged_stopped and dragged_list_item and slot_hovered then
				items_page.item_selected = dragged_list_item
			end
		end
	end

	return 
end
AltarView.handle_index_changes = function (self)
	local gamepad_active = self.input_manager:is_device_active("gamepad")
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local craft_ui_page = ui_pages.craft
	local compare_ui_page = ui_pages.compare
	local trait_proc_ui_page = ui_pages.trait_proc
	local trait_reroll_ui_page = ui_pages.trait_reroll
	local character_changed = items_page.character_changed

	if character_changed then
		items_page.set_selected_hero(items_page, character_changed)

		local selected_item = items_page.selected_item(items_page)
		local item_backend_id = selected_item and selected_item.backend_id

		self.compare_item_with_loadout_item(self, item_backend_id)
	end

	local list_item_pressed, inventory_list_index_pressed = items_page.is_list_item_pressed(items_page)
	self.gamepad_request_melt_item = nil
	local inventory_list_index_changed = items_page.has_list_index_changed(items_page)

	if inventory_list_index_changed then
		local play_sound = true

		items_page.on_inventory_item_selected(items_page, inventory_list_index_changed, play_sound)

		local selected_item = items_page.selected_item(items_page)
		local item_backend_id = selected_item and selected_item.backend_id

		self.compare_item_with_loadout_item(self, item_backend_id)
	end

	local current_selected_list_index = items_page.current_selected_list_index(items_page)
	local trait_reroll_item_remove_request = trait_reroll_ui_page.item_remove_request

	if trait_reroll_item_remove_request then
		items_page.set_backend_id_disabled_state(items_page, trait_reroll_ui_page.active_item_id, false)
		trait_reroll_ui_page.remove_item(trait_reroll_ui_page)
		items_page.refresh_items_status(items_page)
	end

	local pressed_item_backend_id = trait_reroll_ui_page.pressed_item_backend_id

	if pressed_item_backend_id then
		local item_list_index = items_page.index_by_backend_id(items_page, pressed_item_backend_id)

		if item_list_index and item_list_index ~= current_selected_list_index then
			local play_sound = true

			items_page.on_inventory_item_selected(items_page, item_list_index, play_sound)
			self.compare_item_with_loadout_item(self, pressed_item_backend_id)
		end
	end

	local trait_proc_item_remove_request = trait_proc_ui_page.item_remove_request

	if trait_proc_item_remove_request then
		items_page.set_backend_id_disabled_state(items_page, trait_proc_ui_page.active_item_id, false)
		trait_proc_ui_page.remove_item(trait_proc_ui_page)
		items_page.refresh_items_status(items_page)
	end

	local pressed_item_backend_id = trait_proc_ui_page.pressed_item_backend_id

	if pressed_item_backend_id then
		local item_list_index = items_page.index_by_backend_id(items_page, pressed_item_backend_id)

		if item_list_index and item_list_index ~= current_selected_list_index then
			local play_sound = true

			items_page.on_inventory_item_selected(items_page, item_list_index, play_sound)
			self.compare_item_with_loadout_item(self, pressed_item_backend_id)
		end
	end

	local craft_item_remove_request = craft_ui_page.item_remove_request

	if craft_item_remove_request then
		items_page.set_backend_id_disabled_state(items_page, craft_ui_page.active_item_id, false)
		craft_ui_page.remove_item(craft_ui_page)
		items_page.refresh_items_status(items_page)
		items_page.set_gamepad_focus(items_page, true)
	end

	local pressed_item_backend_id = craft_ui_page.pressed_item_backend_id

	if pressed_item_backend_id then
		local item_list_index = items_page.index_by_backend_id(items_page, pressed_item_backend_id)

		if item_list_index and item_list_index ~= current_selected_list_index then
			local play_sound = true

			items_page.on_inventory_item_selected(items_page, item_list_index, play_sound)
			self.compare_item_with_loadout_item(self, pressed_item_backend_id)
		end
	end

	self.handle_page_requests(self)

	return 
end
AltarView.handle_page_requests = function (self)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local craft_ui_page = ui_pages.craft
	local compare_ui_page = ui_pages.compare
	local trait_proc_ui_page = ui_pages.trait_proc
	local trait_reroll_ui_page = ui_pages.trait_reroll
	local item_selected = items_page.item_selected
	local item_selected_backend_id = item_selected and item_selected.backend_id
	local popup_result, popup_result_data = nil
	local confirm_popup_id = self.confirm_popup_id

	if confirm_popup_id then
		popup_result, popup_result_data = self.confirmation_popup:query_result(confirm_popup_id)

		if popup_result then
			self.confirm_popup_id = nil
		end
	end

	local current_selected_list_index = items_page.current_selected_list_index(items_page)

	if trait_reroll_ui_page.active then
		local poll_reroll_traits_state = self.poll_reroll_traits_state
		local reroll_traits_new_item_key = poll_reroll_traits_state == 1 and self.forge_logic:poll_reroll_traits()
		local new_item_data = poll_reroll_traits_state == 2 and self.forge_logic:poll_select_rerolled_traits()

		if trait_reroll_ui_page.reroll_request then
			local current_item_id = trait_reroll_ui_page.active_item_id
			local current_item_is_equipped = trait_reroll_ui_page.active_item_is_equipped

			self.forge_logic:reroll_traits(current_item_id, current_item_is_equipped)

			self.poll_reroll_traits_state = 1

			ScriptBackendItem.set_rerolling_trait_state(true)
			self.set_input_blocked(self, true)
			self.set_menu_locked_state(self, true)
		elseif reroll_traits_new_item_key then
			trait_reroll_ui_page.reroll(trait_reroll_ui_page, reroll_traits_new_item_key)
			self.refresh_tokens(self, true)

			self.poll_reroll_traits_state = nil
		elseif trait_reroll_ui_page.rerolling then
			if trait_reroll_ui_page.trait_options_presentation_complete then
				items_page.active = false
				compare_ui_page.active = false

				self.set_input_blocked(self, false)
			elseif trait_reroll_ui_page.reroll_option_selected then
				local reroll_option_keep_old = trait_reroll_ui_page.reroll_option_keep_old

				self.forge_logic:select_rerolled_traits(not reroll_option_keep_old)

				self.poll_reroll_traits_state = 2

				self.set_input_blocked(self, true)
			elseif new_item_data then
				local new_item_backend_id = new_item_data.backend_id
				local slot = new_item_data.slot
				local hero = new_item_data.hero

				if hero and slot and new_item_backend_id then
					local active_item_data = trait_reroll_ui_page.active_item_data
					local item_for_profile = active_item_data.can_wield[1]
					local player_manager = self.player_manager
					local player = player_manager.player_from_peer_id(player_manager, self.peer_id)
					local player_unit = player.player_unit
					local player_profile_index = player.profile_index

					if Unit.alive(player_unit) and FindProfileIndex(item_for_profile) == player_profile_index then
						local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
						local resyncing_loadout = inventory_extension.resyncing_loadout(inventory_extension)

						if resyncing_loadout or not Managers.state.network:game() then
							return 
						end

						inventory_extension.create_equipment_in_slot(inventory_extension, slot, new_item_backend_id)
					end
				end

				trait_reroll_ui_page.on_traits_option_response_done(trait_reroll_ui_page, new_item_backend_id)

				self.poll_reroll_traits_state = nil
				items_page.active = true
				compare_ui_page.active = true

				if new_item_backend_id then
					items_page.refresh(items_page)
					self.compare_item_with_loadout_item(self, new_item_backend_id)
					items_page.set_backend_id_disabled_state(items_page, new_item_backend_id, true)
					items_page.on_inventory_item_selected(items_page, current_selected_list_index or 1)
				end
			end
		elseif trait_reroll_ui_page.reroll_completed_value then
			self.set_input_blocked(self, false)
			self.set_menu_locked_state(self, false)
			ScriptBackendItem.set_rerolling_trait_state(false)
		elseif item_selected_backend_id then
			local current_item_id = trait_reroll_ui_page.active_item_id

			if current_item_id then
				items_page.set_backend_id_disabled_state(items_page, current_item_id, false)
			end

			local item_selected_is_equipped = items_page.item_selected_is_equipped

			trait_reroll_ui_page.add_item(trait_reroll_ui_page, item_selected_backend_id, nil, item_selected_is_equipped)
			items_page.refresh_items_status(items_page)
			items_page.set_backend_id_disabled_state(items_page, item_selected_backend_id, true)
		end
	elseif trait_proc_ui_page.active then
		if trait_proc_ui_page.roll_request then
			local item_backend_id, selected_trait_name = trait_proc_ui_page.get_item_roll_info(trait_proc_ui_page)
			local variable_name = "proc_chance"
			local new_variable_value = self.forge_logic:reroll_trait_variable(item_backend_id, selected_trait_name, variable_name)

			trait_proc_ui_page.roll(trait_proc_ui_page, new_variable_value)
			self.set_input_blocked(self, true)
		elseif trait_proc_ui_page.roll_completed then
			self.set_input_blocked(self, false)
			self.refresh_tokens(self, true)

			local better_proc_chance = trait_proc_ui_page.improved_value_last_roll

			if better_proc_chance then
				if trait_proc_ui_page.active_item_is_equipped then
					local active_item_data = trait_proc_ui_page.active_item_data
					local item_for_profile = active_item_data.can_wield[1]
					local slot_type = active_item_data.slot_type
					local slot = (slot_type == "melee" and "slot_melee") or "slot_ranged"
					local player_manager = self.player_manager
					local player = player_manager.player_from_peer_id(player_manager, self.peer_id)
					local player_unit = player.player_unit
					local player_profile_index = player.profile_index

					if Unit.alive(player_unit) and FindProfileIndex(item_for_profile) == player_profile_index then
						local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")

						inventory_extension.rewield_wielded_slot(inventory_extension)
						inventory_extension.apply_buffs_to_ammo(inventory_extension)
					end
				end

				local selected_item = ui_pages.items:selected_item()
				local item_backend_id = selected_item and selected_item.backend_id

				self.compare_item_with_loadout_item(self, item_backend_id)
				items_page.refresh_items_status(items_page)
			end
		elseif item_selected_backend_id then
			local current_item_id = trait_proc_ui_page.active_item_id

			if current_item_id then
				items_page.set_backend_id_disabled_state(items_page, current_item_id, false)
			end

			local item_selected_is_equipped = items_page.item_selected_is_equipped

			trait_proc_ui_page.add_item(trait_proc_ui_page, item_selected_backend_id, item_selected_is_equipped)
			items_page.refresh_items_status(items_page)
			items_page.set_backend_id_disabled_state(items_page, item_selected_backend_id, true)
		end
	elseif craft_ui_page.active then
		if confirm_popup_id then
		elseif item_selected_backend_id then
			local current_item_id = craft_ui_page.active_item_id

			if current_item_id then
				items_page.set_backend_id_disabled_state(items_page, current_item_id, false)
			end

			craft_ui_page.add_item(craft_ui_page, item_selected_backend_id)
			items_page.refresh_items_status(items_page)
			items_page.set_backend_id_disabled_state(items_page, item_selected_backend_id, true)
			items_page.set_gamepad_focus(items_page, false)
		elseif craft_ui_page.craft_request then
			local selected_slot_name = craft_ui_page.selected_slot_name(craft_ui_page)
			local selected_token_rarity = craft_ui_page.selected_token_rarity(craft_ui_page)
			local selected_profile_name = craft_ui_page.selected_profile_name(craft_ui_page)
			local rarity_settings = AltarSettings.pray_for_loot_cost[selected_token_rarity]
			local token_type = rarity_settings.token_type

			self.forge_logic:pray_for_loot(selected_profile_name, selected_token_rarity, selected_slot_name)
			craft_ui_page.craft(craft_ui_page)
			self.set_input_blocked(self, true)
		elseif craft_ui_page.crafting and craft_ui_page.craft_animation_ready then
			local item_key, item_backend_id = self.forge_logic:poll_pray_for_loot()

			if item_key then
				self.craft_item_key = item_key
				self.can_display_item_popup = true

				items_page.refresh(items_page)
				items_page.set_rarity(items_page, nil)
				items_page.on_inventory_item_selected(items_page, current_selected_list_index or 1)
				craft_ui_page.on_world_unit_spawn(craft_ui_page)
				self.refresh_tokens(self, true)
			end
		elseif craft_ui_page.crafting and self.item_display_popup.active then
			local popup_close_widget = self.popup_close_widget

			if (not self.close_item_popup and popup_close_widget.content.button_hotspot.on_pressed) or self.input_manager:any_input_pressed() then
				self.close_item_display_popup(self)
			end
		end
	end

	return 
end
AltarView.spawn_confirm_popup = function (self, localized_text, return_data)
	return self.queue_popup(self, localized_text, return_data, "confirm", Localize("input_description_confirm"), "cancel", Localize("input_description_cancel"))
end
AltarView.compare_item_with_loadout_item = function (self, item_backend_id)
	if not item_backend_id then
		return 
	end

	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local compare_ui_page = ui_pages.compare
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

	compare_ui_page.on_item_selected(compare_ui_page, item_backend_id, loadout_item_backend_id)

	return 
end
AltarView.refresh_tokens = function (self, play_animation)
	local num_tokens = AltarSettings.num_token_types
	local token_widgets_by_name = self.token_widgets_by_name
	local ui_animations = self.ui_animations

	for token_type, token_data in pairs(AltarSettings.token_types) do
		local widget_name = token_type .. "_widget"
		local widget = token_widgets_by_name[widget_name]

		if widget then
			local num_tokens = BackendUtils.get_tokens(token_type)
			local max_tokens = token_data.max
			local current_num_tokens = widget.content.num_tokens

			if play_animation and current_num_tokens and current_num_tokens ~= num_tokens then
				local widget_glow_name = token_type .. "_glow"
				local glow_widget = token_widgets_by_name[widget_glow_name]
				local glow_widget_color = glow_widget.style.texture_id.color
				ui_animations[widget_glow_name] = UIAnimation.init(UIAnimation.function_by_time, glow_widget_color, 1, 0, 255, 0.2, math.easeOutCubic, UIAnimation.function_by_time, glow_widget_color, 1, 255, 0, 0.2, math.easeInCubic)
			end

			widget.content.text = num_tokens
			widget.content.num_tokens = num_tokens
		end
	end

	return 
end
AltarView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
AltarView.update_button_bar_animation = function (self, widget, widget_name, dt)
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
AltarView.set_input_blocked = function (self, blocked)
	self.input_blocked = blocked
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local compare_ui_page = ui_pages.compare

	items_page.disable_input(items_page, blocked)
	compare_ui_page.disable_input(compare_ui_page, blocked)

	return 
end
AltarView.create_display_item_popup = function (self)
	if not self.item_display_popup then
		local ingame_ui_context = self.ingame_ui_context
		local position = definitions.scenegraph_definition.popup_root.position
		local world_name = "exotic_reward_preview"
		self.item_display_popup = ItemDisplayPopup:new(ingame_ui_context, world_name, "lua_spin_altar", position, self)
	end

	return 
end
AltarView.display_item_popup = function (self, item_key)
	self.item_display_popup:on_enter(item_key)

	return 
end
AltarView.diplay_popup_active = function (self)
	if self.item_display_popup.active then
		return true
	end

	return 
end
AltarView.close_item_display_popup = function (self)
	self.close_item_popup = true

	return 
end
AltarView.on_item_display_popup_closed = function (self)
	local ui_pages = self.ui_pages
	local craft_ui_page = ui_pages.craft

	if craft_ui_page.active and craft_ui_page.crafting then
		self.set_input_blocked(self, false)
		craft_ui_page.world_unit_presentation_complete(craft_ui_page)
	end

	return 
end
AltarView.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end
AltarView.destroy = function (self)
	self.confirmation_popup:cancel_all_popups()

	self.confirmation_popup = nil

	self.menu_input_description:destroy()

	self.menu_input_description = nil
	self.ingame_ui_context = nil
	self.ui_animator = nil
	local item_display_popup = self.item_display_popup

	if item_display_popup then
		item_display_popup.destroy(item_display_popup)

		self.item_display_popup = nil
	end

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)

	UIPasses.is_dragging_item = false

	return 
end
AltarView.on_gamepad_activated = function (self)
	local ui_pages = self.ui_pages

	ui_pages.items:set_gamepad_focus(true)

	local gamepad_selected_page = self.gamepad_selected_page

	if gamepad_selected_page and ui_pages[gamepad_selected_page].set_gamepad_focus then
		ui_pages[gamepad_selected_page]:set_gamepad_focus(true)
	end

	return 
end
AltarView.set_gamepad_active_forge_page = function (self, name)
	self.set_gamepad_page_focus(self, name)

	return 
end
AltarView.set_gamepad_page_focus = function (self, name)
	local ui_pages = self.ui_pages
	local gamepad_selected_page = self.gamepad_selected_page

	if gamepad_selected_page and ui_pages[gamepad_selected_page].set_gamepad_focus then
		ui_pages[gamepad_selected_page]:set_gamepad_focus(false)
	end

	ui_pages.items:on_focus_lost()

	if ui_pages[name].set_gamepad_focus then
		ui_pages[name]:set_gamepad_focus(true)
	end

	ui_pages.items:set_gamepad_press_input_enabled(name == "melt")

	self.gamepad_selected_page = name
	self.gamepad_active_actions_name = nil

	self.update_input_description(self)

	return 
end
AltarView.update_input_description = function (self)
	local ui_pages = self.ui_pages
	local gamepad_selected_page = self.gamepad_selected_page
	local page_input_actions = input_actions[gamepad_selected_page]
	local page = ui_pages[gamepad_selected_page]
	local actions_name_to_use = nil

	if not actions_name_to_use then
		actions_name_to_use = "default"

		if gamepad_selected_page == "craft" then
			local can_afford = page.can_afford_craft_cost(page)
			local active_item_id = page.active_item_id

			if active_item_id then
				local selected_item = ui_pages.items:selected_item()
				local item_backend_id = selected_item and selected_item.backend_id
				local is_selected_item = (item_backend_id and item_backend_id == active_item_id) or false

				if is_selected_item then
					if can_afford then
						actions_name_to_use = "item_added_selected"
					else
						actions_name_to_use = "item_added_selected_tokens_missing"
					end
				elseif can_afford then
					actions_name_to_use = "item_added"
				else
					actions_name_to_use = "item_added_tokens_missing"
				end
			elseif can_afford then
				actions_name_to_use = "default"
			else
				actions_name_to_use = "default_tokens_missing"
			end
		elseif gamepad_selected_page == "trait_proc" then
			local can_afford = page.can_afford_roll_cost(page)
			local active_item_id = page.active_item_id
			local selected_item, is_equipped, is_active = ui_pages.items:selected_item()

			if active_item_id then
				local item_backend_id = selected_item and selected_item.backend_id
				local is_selected_item = (item_backend_id and item_backend_id == active_item_id) or false

				if is_selected_item then
					if can_afford then
						actions_name_to_use = "item_added_and_selected_and_afford"
					else
						actions_name_to_use = "item_added_and_selected"
					end
				elseif can_afford then
					actions_name_to_use = "item_added_and_afford"
				else
					actions_name_to_use = "item_added"
				end
			elseif is_active then
				actions_name_to_use = "default"
			else
				actions_name_to_use = "disabled_item"
			end
		elseif gamepad_selected_page == "trait_reroll" then
			local can_afford = page.can_afford_reroll_cost(page)
			local active_item_id = page.active_item_id
			local selected_item, is_equipped, is_active = ui_pages.items:selected_item()
		end
	end

	if not self.gamepad_active_actions_name or self.gamepad_active_actions_name ~= actions_name_to_use then
		self.gamepad_active_actions_name = actions_name_to_use
		input_description_data.actions = page_input_actions[actions_name_to_use]

		self.menu_input_description:set_input_description(input_description_data)
	end

	return 
end
AltarView.on_gamepad_deactivated = function (self)
	local ui_pages = self.ui_pages

	ui_pages.items:set_gamepad_focus(true)

	local gamepad_selected_page = self.gamepad_selected_page

	if gamepad_selected_page and ui_pages[gamepad_selected_page].set_gamepad_focus then
		ui_pages[gamepad_selected_page]:set_gamepad_focus(false)
	end

	return 
end
AltarView.handle_gamepad_input = function (self, dt)
	self.update_input_description(self)

	local ui_pages = self.ui_pages
	local input_service = self.page_input_service(self)
	local gamepad_selected_page = self.gamepad_selected_page
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	else
		if input_service.get(input_service, "back") then
			local return_to_game = not self.ingame_ui.menu_active

			self.exit(self, return_to_game)
			self.play_sound(self, "Play_hud_select")

			return 
		end

		local selected_selection_bar_index = self.selected_selection_bar_index

		if selected_selection_bar_index then
			local new_selection_bar_index = nil

			if input_service.get(input_service, "trigger_cycle_next") then
				local forge_selection_bar = self.forge_selection_bar_widget
				local forge_selection_bar_content = forge_selection_bar.content
				new_selection_bar_index = math.min(selected_selection_bar_index + 1, #forge_selection_bar_content)
				self.controller_cooldown = GamepadSettings.menu_cooldown
			elseif input_service.get(input_service, "trigger_cycle_previous") then
				new_selection_bar_index = math.max(selected_selection_bar_index - 1, 1)
				self.controller_cooldown = GamepadSettings.menu_cooldown
			end

			if new_selection_bar_index and new_selection_bar_index ~= selected_selection_bar_index then
				self.gamepad_changed_selection_bar_index = new_selection_bar_index
			end
		end
	end

	return 
end

return 
