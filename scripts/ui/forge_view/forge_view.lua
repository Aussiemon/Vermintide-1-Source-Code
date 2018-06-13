local definitions = local_require("scripts/ui/forge_view/forge_view_definitions")
local forge_animation_definitions = local_require("scripts/ui/views/inventory_view_animation_definitions")

require("scripts/settings/equipment/item_master_list")
require("scripts/settings/forge_settings")
require("scripts/managers/backend/backend_utils")
require("scripts/ui/views/inventory_items_ui")
require("scripts/ui/views/inventory_compare_ui")
require("scripts/ui/forge_view/forge_items_ui")
require("scripts/ui/forge_view/forge_merge_ui")
require("scripts/ui/forge_view/forge_melt_ui")
require("scripts/ui/forge_view/forge_upgrade_ui")
require("scripts/ui/forge_view/forge_logic")

local DO_RELOAD = true
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
local input_actions = {
	merge = {
		default = {
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_add"
			}
		},
		item_added_and_selected = {
			{
				input_action = "special_1",
				priority = 49,
				description_text = "input_description_remove"
			}
		},
		item_added_not_selected = {
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_remove"
			},
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_add"
			}
		},
		all_items_added = {
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_remove"
			},
			{
				input_action = "refresh",
				priority = 49,
				description_text = "input_description_merge"
			}
		},
		item_added_not_selected_can_afford = {
			{
				input_action = "special_1",
				priority = 47,
				description_text = "input_description_remove"
			},
			{
				input_action = "confirm",
				priority = 48,
				description_text = "input_description_add"
			},
			{
				input_action = "refresh",
				priority = 49,
				description_text = "input_description_merge"
			}
		},
		disabled_item = {}
	},
	melt = {
		default = {
			{
				input_action = "refresh",
				priority = 49,
				description_text = "input_description_melt"
			}
		},
		disabled_item = {}
	},
	upgrade = {
		default = {
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_add"
			}
		},
		item_added_and_selected = {
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_remove"
			},
			{
				input_action = "refresh",
				priority = 49,
				description_text = "input_description_upgrade"
			}
		},
		item_added_not_selected = {
			{
				input_action = "special_1",
				priority = 47,
				description_text = "input_description_remove"
			},
			{
				input_action = "refresh",
				priority = 48,
				description_text = "input_description_upgrade"
			},
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_add"
			}
		},
		item_added_and_selected_upgrade_disabled = {
			{
				input_action = "special_1",
				priority = 49,
				description_text = "input_description_remove"
			}
		},
		item_added_not_selected_upgrade_disabled = {
			{
				input_action = "special_1",
				priority = 48,
				description_text = "input_description_remove"
			},
			{
				input_action = "confirm",
				priority = 49,
				description_text = "input_description_add"
			}
		},
		item_added_not_selected_upgrade_disabled_item_disabled = {
			{
				input_action = "special_1",
				priority = 49,
				description_text = "input_description_remove"
			}
		},
		disabled_item = {}
	}
}
local fake_input_service = {
	get = function ()
		return
	end,
	has = function ()
		return
	end
}
ForgeView = class(ForgeView)

ForgeView.init = function (self, ingame_ui_context)
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

	input_manager:create_input_service("forge_view", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager:map_device_to_service("forge_view", "keyboard")
	input_manager:map_device_to_service("forge_view", "mouse")
	input_manager:map_device_to_service("forge_view", "gamepad")
	rawset(_G, "my_global_ass_pointer", self)

	self.ui_animations = {}
	self.forge_logic = ForgeLogic:new(ingame_ui_context)
	local input_service = self.input_manager:get_service("forge_view")
	local number_of_actvie_descriptions = 8
	local gui_layer = UILayer.default
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, number_of_actvie_descriptions, gui_layer, generic_input_actions)

	self.menu_input_description:set_input_description(nil)
	self:create_ui_pages(ingame_ui_context)
	self:create_ui_elements()

	self.bar_animations = {}
	self.ui_animator = UIAnimator:new(self.ui_scenegraph, forge_animation_definitions)

	self:on_forge_selection_bar_index_changed(1, true)

	self.ingame_ui_context = ingame_ui_context
	DO_RELOAD = false
end

ForgeView.page_input_service = function (self)
	return (self.input_blocked and fake_input_service) or self.input_manager:get_service("forge_view")
end

ForgeView.input_service = function (self)
	return self.input_manager:get_service("forge_view")
end

ForgeView.create_ui_pages = function (self, ingame_ui_context)
	local items_ui_position = definitions.scenegraph_definition.items_ui_page.position
	local merge_ui_position = definitions.scenegraph_definition.merge_ui_page.position
	local scenegraph_definition = definitions.scenegraph_definition
	local items_ui_page = ForgeItemsUI:new(self, scenegraph_definition.page_root_center.position, forge_animation_definitions, ingame_ui_context)
	local merge_ui_page = ForgeMergeUI:new(self, scenegraph_definition.page_root_left.position, forge_animation_definitions, ingame_ui_context)
	local melt_ui_page = ForgeMeltUI:new(self, scenegraph_definition.page_root_left.position, forge_animation_definitions, ingame_ui_context)
	local upgrade_ui_page = ForgeUpgradeUI:new(self, scenegraph_definition.page_root_left.position, forge_animation_definitions, ingame_ui_context)
	local compare_ui_page = InventoryCompareUI:new(self, scenegraph_definition.page_root_right.position, forge_animation_definitions, ingame_ui_context, "forge_view")
	merge_ui_page.active = true
	items_ui_page.active = true
	compare_ui_page.active = true
	upgrade_ui_page.active = false
	melt_ui_page.active = false

	compare_ui_page:set_title_text("inventory_screen_compare_button")

	self.ui_pages = {
		items = items_ui_page,
		merge = merge_ui_page,
		melt = melt_ui_page,
		upgrade = upgrade_ui_page,
		compare = compare_ui_page
	}
end

ForgeView.create_ui_elements = function (self)
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
	self.dead_space_4k_filler = UIWidget.init(UIWidgets.create_4k_filler())

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
end

ForgeView.on_enter = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)
	self:create_display_item_popup()

	local input_manager = self.input_manager

	input_manager:block_device_except_service("forge_view", "keyboard", 1)
	input_manager:block_device_except_service("forge_view", "mouse", 1)
	input_manager:block_device_except_service("forge_view", "gamepad", 1)

	self.active = true
	self.melt_active = false

	self:play_sound("Play_hud_forge_open")
	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_on")
end

ForgeView.on_exit = function (self)
	self.exiting = nil
	self.active = nil
	UIPasses.is_dragging_item = false

	self.ui_pages.items:clear_disabled_backend_ids()
	self:close_item_display_popup()

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_off")
end

ForgeView.post_update_on_enter = function (self)
	local ui_pages = self.ui_pages

	for ui_name, ui_page in pairs(ui_pages) do
		ui_page:on_enter()
	end

	local my_profile = self.profile_synchronizer:profile_by_peer(self.peer_id, self.local_player_id)
	local profile_name = SPProfiles[my_profile].display_name

	ui_pages.items:select_hero_by_name(profile_name, true)
	self:_apply_item_filter(self.item_filter, true)

	local selected_item = ui_pages.items:selected_item()
	local item_backend_id = selected_item and selected_item.backend_id

	self:compare_item_with_loadout_item(item_backend_id)
	self:refresh_tokens()
end

ForgeView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	if PLATFORM == "xb1" and BackendManagerLocalEnabled then
		Managers.save:auto_save(SaveFileName, SaveData)
	end
end

ForgeView.exit = function (self, return_to_game)
	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	if self.melt_active then
		local toggle_off_melt = true

		self:toggle_melt_mode(toggle_off_melt)
	end

	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local melt_ui_page = ui_pages.melt
	local merge_ui_page = ui_pages.merge
	local upgrade_ui_page = ui_pages.upgrade

	merge_ui_page:remove_all_items()
	upgrade_ui_page:remove_item()
	melt_ui_page:clear()
	items_page:on_focus_lost()
	self.ingame_ui:transition_with_fade(exit_transition)
	self:play_sound("Play_hud_button_close")

	self.exiting = true
end

ForgeView.suspend = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)

	self.suspended = true
end

ForgeView.unsuspend = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)
	self.input_manager:block_device_except_service("forge_view", "keyboard", 1)
	self.input_manager:block_device_except_service("forge_view", "mouse", 1)
	self.input_manager:block_device_except_service("forge_view", "gamepad", 1)

	self.suspended = nil
end

ForgeView.update = function (self, dt)
	return
end

ForgeView.post_update = function (self, dt)
	if DO_RELOAD then
		self:create_ui_elements()

		DO_RELOAD = false
	end

	local can_display_item_popup = self.can_display_item_popup

	if can_display_item_popup and self.merged_item_key then
		self:display_item_popup(self.merged_item_key)

		self.merged_item_key = nil
		self.can_display_item_popup = nil
	end

	local close_item_popup = self.close_item_popup

	if close_item_popup then
		local item_display_popup = self.item_display_popup

		if item_display_popup then
			item_display_popup:on_exit()

			self.close_item_popup = nil
		end
	end

	if self.suspended then
		return
	end

	local input_manager = self.input_manager
	local input_service = self:page_input_service()
	local transitioning = self:transitioning()

	self.ui_animator:update(dt)

	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil
		end
	end

	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local melt_ui_page = ui_pages.melt
	local merge_ui_page = ui_pages.merge
	local upgrade_ui_page = ui_pages.upgrade
	local exit_button_widget = self.widgets_by_name.exit_button_widget

	if not self.active then
		return
	end

	local forge_selection_bar = self.forge_selection_bar_widget

	if not transitioning then
		local forge_selection_bar_content = forge_selection_bar.content

		for i = 1, #forge_selection_bar_content, 1 do
			if (forge_selection_bar_content[i].on_pressed or self.gamepad_changed_selection_bar_index == i) and i ~= self.selected_selection_bar_index then
				self:on_forge_selection_bar_index_changed(i)

				break
			end
		end

		self.gamepad_changed_selection_bar_index = nil

		if self.item_display_popup.active then
			local popup_close_widget = self.popup_close_widget

			if popup_close_widget.content.button_hotspot.on_pressed or input_manager:any_input_pressed() then
				self:close_item_display_popup()
			end
		end

		if exit_button_widget.content.button_hotspot.on_hover_enter then
			self:play_sound("Play_hud_hover")
		end

		if not self.input_blocked and (exit_button_widget.content.button_hotspot.on_release or input_service:get("toggle_menu")) then
			local return_to_game = not self.ingame_ui.menu_active

			self:play_sound("Play_hud_hover")
			self:exit(return_to_game)

			transitioning = self:transitioning()
		end

		if melt_ui_page:on_melt_button_pressed() or (self.melt_active and input_service:get("right_press")) then
			self:toggle_melt_mode()
		end
	end

	self:handle_index_changes()
	self:update_button_bar_animation(forge_selection_bar, "forge_selection_bar", dt)

	for ui_name, ui_page in pairs(self.ui_pages) do
		if ui_page.active then
			ui_page:update(dt)
		end
	end

	if not transitioning then
		local gamepad_active = input_manager:is_device_active("gamepad")

		if gamepad_active then
			if not self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = true

				self:on_gamepad_activated()
			end

			self:handle_gamepad_input(dt)
		elseif self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = false

			self:on_gamepad_deactivated()
		end

		self:handle_item_drag()
	end

	if self.active then
		self:draw(dt)
	end

	if self.item_display_popup.active then
		self.item_display_popup:update(dt, (not merge_ui_page:animation_doors() and input_service) or nil)
	end
end

ForgeView.on_forge_selection_bar_index_changed = function (self, index, ignore_sound)
	local forge_selection_bar = self.forge_selection_bar_widget
	local forge_selection_bar_content = forge_selection_bar.content

	for i = 1, #forge_selection_bar_content, 1 do
		forge_selection_bar_content[i].is_selected = i == index
	end

	if not ignore_sound then
		self:play_sound("Play_hud_next_tab")
	end

	if self.melt_active then
		local toggle_off_melt = true

		self:toggle_melt_mode(toggle_off_melt)
	end

	if index == 1 then
		self:activate_merge_view(ignore_sound)
		self:set_gamepad_active_forge_page("merge")
	elseif index == 2 then
		self:activate_upgrade_view()
		self:set_gamepad_active_forge_page("upgrade")
	else
		self:activate_melt_view(ignore_sound)
		self:set_gamepad_active_forge_page("melt")
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
end

ForgeView._apply_item_filter = function (self, item_filter, update_list)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	self.item_filter = item_filter
	local current_profile_name = items_page:current_profile_name()

	if item_filter and current_profile_name and current_profile_name ~= "all" then
		local can_wield_name = "can_wield_" .. current_profile_name
		item_filter = item_filter .. " and " .. can_wield_name .. " == true"
	end

	items_page:set_item_filter(item_filter)

	if update_list then
		local play_sound = false

		items_page:refresh()
		items_page:on_inventory_item_selected(1, play_sound)
	end
end

ForgeView.activate_merge_view = function (self, ignore_sound)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local melt_ui_page = ui_pages.melt
	local merge_ui_page = ui_pages.merge
	local compare_ui_page = ui_pages.compare
	local upgrade_ui_page = ui_pages.upgrade

	merge_ui_page:set_active(true)
	melt_ui_page:set_active(false)
	upgrade_ui_page:set_active(false)
	melt_ui_page:clear()
	merge_ui_page:remove_all_items()
	upgrade_ui_page:remove_item()

	local accepted_rarities = {
		common = true,
		plentiful = true,
		rare = true
	}

	items_page:clear_disabled_backend_ids()
	items_page:set_accepted_rarities(accepted_rarities)
	items_page:set_disable_non_trait_items(false)
	items_page:set_disable_loadout_items(true)

	local slot_type_changed = items_page:set_selected_slot_type("weapons")

	items_page:set_rarity(nil)
	items_page:set_drag_enabled(true)

	local item_filter = "item_rarity ~= promo and ( slot_type == melee or slot_type == ranged )"

	self:_apply_item_filter(item_filter, true)

	if slot_type_changed then
		local selected_item = items_page:selected_item()

		if selected_item then
			local item_backend_id = selected_item and selected_item.backend_id

			self:compare_item_with_loadout_item(item_backend_id)
		else
			compare_ui_page:clear_item_selected()
		end
	end

	if not ignore_sound then
		self:play_sound("Play_hud_forge_switch_to_merge")
	end
end

ForgeView.activate_melt_view = function (self, ignore_sound)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local melt_ui_page = ui_pages.melt
	local merge_ui_page = ui_pages.merge
	local compare_ui_page = ui_pages.compare
	local upgrade_ui_page = ui_pages.upgrade
	upgrade_ui_page.active = false
	merge_ui_page.active = false
	melt_ui_page.active = true

	melt_ui_page:set_active(true)
	merge_ui_page:set_active(false)
	upgrade_ui_page:set_active(false)
	merge_ui_page:remove_all_items()
	upgrade_ui_page:remove_item()

	local accepted_rarities = {
		common = true,
		plentiful = true,
		exotic = true,
		rare = true,
		unique = true
	}

	items_page:clear_disabled_backend_ids()
	items_page:set_accepted_rarities(accepted_rarities)
	items_page:set_disable_non_trait_items(false)
	items_page:set_disable_loadout_items(true)

	local slot_type_changed = items_page:set_selected_slot_type({
		"melee",
		"ranged",
		"trinket",
		"hat"
	})
	local item_filter = "item_rarity ~= promo and ( slot_type == trinket or slot_type == melee or slot_type == ranged or slot_type == hat )"

	self:_apply_item_filter(item_filter, true)
	items_page:set_rarity(nil)
	items_page:set_drag_enabled(true)

	if slot_type_changed then
		local selected_item = items_page:selected_item()

		if selected_item then
			local item_backend_id = selected_item and selected_item.backend_id

			self:compare_item_with_loadout_item(item_backend_id)
		else
			compare_ui_page:clear_item_selected()
		end
	end

	if not ignore_sound then
		self:play_sound("Play_hud_forge_switch_to_melt")
	end

	local input_manager = self.input_manager
	local input_service = input_manager:get_service("forge_view")
	local gamepad_active = input_manager:is_device_active("gamepad")

	if gamepad_active then
		melt_ui_page:toggle_melt_mode(true, true)
	end
end

ForgeView.activate_upgrade_view = function (self, ignore_sound)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local melt_ui_page = ui_pages.melt
	local merge_ui_page = ui_pages.merge
	local compare_ui_page = ui_pages.compare
	local upgrade_ui_page = ui_pages.upgrade

	upgrade_ui_page:set_active(true)
	merge_ui_page:set_active(false)
	melt_ui_page:set_active(false)
	melt_ui_page:clear()
	merge_ui_page:remove_all_items()
	upgrade_ui_page:remove_item()

	local accepted_rarities = {
		common = true,
		exotic = true,
		rare = true,
		unique = true
	}

	items_page:clear_disabled_backend_ids()
	items_page:set_accepted_rarities(accepted_rarities)
	items_page:set_disable_non_trait_items(true)
	items_page:set_disable_loadout_items(false)

	local slot_type_changed = items_page:set_selected_slot_type("weapons")

	items_page:set_rarity(nil)
	items_page:set_drag_enabled(true)

	local item_filter = "item_rarity ~= promo and ( slot_type == melee or slot_type == ranged )"

	self:_apply_item_filter(item_filter, true)

	if slot_type_changed then
		local selected_item = items_page:selected_item()

		if selected_item then
			local item_backend_id = selected_item and selected_item.backend_id

			self:compare_item_with_loadout_item(item_backend_id)
		else
			compare_ui_page:clear_item_selected()
		end
	end

	if not ignore_sound then
		self:play_sound("Play_hud_forge_switch_to_upgrade")
	end
end

ForgeView.toggle_melt_mode = function (self, force_shutdown, used_by_gamepad)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local melt_ui_page = ui_pages.melt
	local merge_ui_page = ui_pages.merge
	local upgrade_ui_page = ui_pages.upgrade

	if force_shutdown then
	end

	self.melt_active = not self.melt_active

	if self.melt_active then
		merge_ui_page:remove_all_items()
		upgrade_ui_page:remove_item()
		items_page:set_rarity(nil)
		self:play_sound("Play_hud_button_open")
		Window.set_cursor("gui/cursors/mouse_cursor_forge")
	else
		self:play_sound("Play_hud_button_close")
		Window.set_cursor("gui/cursors/mouse_cursor")
	end

	melt_ui_page:toggle_melt_mode(self.melt_active, used_by_gamepad, force_shutdown)
	items_page:set_drag_enabled(not self.melt_active)
end

ForgeView.handle_item_drag = function (self)
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local melt_ui_page = ui_pages.melt
	local merge_ui_page = ui_pages.merge
	local upgrade_ui_page = ui_pages.upgrade
	local current_selected_list_index = items_page:current_selected_list_index()

	if merge_ui_page.active then
		local dragged_merge_item_backend_id = merge_ui_page:on_dragging_item_stopped()

		if dragged_merge_item_backend_id and items_page:on_item_list_hover() then
			merge_ui_page:remove_item_by_id(dragged_merge_item_backend_id)

			local num_items_to_merge = merge_ui_page.num_items_to_merge

			if num_items_to_merge == 0 then
				items_page:set_rarity(nil)
			elseif num_items_to_merge == 1 then
				items_page:refresh_items_status()
			end

			items_page:set_backend_id_disabled_state(dragged_merge_item_backend_id, false)
		else
			local dragged_stopped, dragged_list_item = items_page:on_dragging_item_stopped()
			local slot_index = merge_ui_page:is_slot_hovered(dragged_list_item ~= nil)

			if dragged_stopped and dragged_list_item and slot_index then
				items_page.item_selected = dragged_list_item
				merge_ui_page.specific_slot_index = slot_index
			end
		end
	elseif upgrade_ui_page.active then
		local dragged_upgrade_item_backend_id = upgrade_ui_page:on_dragging_item_stopped()

		if dragged_upgrade_item_backend_id and items_page:on_item_list_hover() then
			upgrade_ui_page:remove_item()
			items_page:refresh_items_status()
			items_page:set_backend_id_disabled_state(dragged_upgrade_item_backend_id, false)
		else
			local dragged_stopped, dragged_list_item = items_page:on_dragging_item_stopped()
			local slot_hovered = upgrade_ui_page:is_slot_hovered(dragged_list_item ~= nil)

			if dragged_stopped and dragged_list_item and slot_hovered then
				items_page.item_selected = dragged_list_item
			end
		end
	elseif melt_ui_page.active then
		local dragged_stopped, dragged_list_item = items_page:on_dragging_item_stopped()
		local slot_hovered = melt_ui_page:is_slot_hovered(dragged_list_item ~= nil)

		if dragged_stopped and dragged_list_item and slot_hovered then
			melt_ui_page.item_to_melt = dragged_list_item
		end
	end
end

ForgeView.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = self:page_input_service()
	local gamepad_active = input_manager:is_device_active("gamepad")
	script_data.wtf = ui_scenegraph
	local widgets_by_name = self.widgets_by_name

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	local forge_selection_bar = self.forge_selection_bar_widget

	UIRenderer.draw_widget(ui_renderer, forge_selection_bar)
	UIRenderer.end_pass(ui_renderer)
	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	local token_widgets = self.token_widgets

	for i = 1, #token_widgets, 1 do
		UIRenderer.draw_widget(ui_renderer, token_widgets[i])
	end

	UIRenderer.draw_widget(ui_renderer, self.dead_space_4k_filler)
	UIRenderer.end_pass(ui_renderer)
	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	for widget_name, widget in pairs(widgets_by_name) do
		if widget_name ~= "exit_button_widget" and widget_name ~= "forge_selection_bar" then
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	if not gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.exit_button_widget)
	else
		UIRenderer.draw_widget(ui_renderer, self.page_center_glow_widget)
	end

	UIRenderer.end_pass(ui_renderer)

	for ui_name, ui_page in pairs(self.ui_pages) do
		if ui_page.active then
			ui_page:draw(dt)
		end
	end

	if gamepad_active then
		self.menu_input_description:draw(ui_renderer, dt)
	end
end

ForgeView.handle_index_changes = function (self)
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("forge_view")
	local gamepad_active = input_manager:is_device_active("gamepad")
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local melt_ui_page = ui_pages.melt
	local merge_ui_page = ui_pages.merge
	local upgrade_ui_page = ui_pages.upgrade
	local compare_ui_page = ui_pages.compare
	local melt_active = self.melt_active
	local item_selected = items_page.item_selected
	local character_changed = items_page.character_changed

	if character_changed then
		if melt_active and melt_ui_page.melting then
			melt_ui_page:abort_melt()
		end

		items_page:set_selected_hero(character_changed)

		local item_filter = self.item_filter

		self:_apply_item_filter(item_filter, true)
	end

	local list_item_pressed, inventory_list_index_pressed = items_page:is_list_item_pressed()

	if melt_active then
		if inventory_list_index_pressed and not gamepad_active then
			item_selected = list_item_pressed
		elseif self.gamepad_request_melt_item then
			item_selected = items_page:selected_item()
		end
	end

	self.gamepad_request_melt_item = nil
	local inventory_list_index_changed = items_page:has_list_index_changed()

	if inventory_list_index_changed then
		local play_sound = true

		items_page:on_inventory_item_selected(inventory_list_index_changed, play_sound)

		local selected_item = items_page:selected_item()
		local item_backend_id = selected_item and selected_item.backend_id

		self:compare_item_with_loadout_item(item_backend_id)
	end

	local current_selected_list_index = items_page:current_selected_list_index()
	local merge_item_to_remove_index = merge_ui_page.item_to_remove_index

	if merge_item_to_remove_index then
		local backend_id = merge_ui_page:remove_item(merge_item_to_remove_index)
		local num_items_to_merge = merge_ui_page.num_items_to_merge

		if num_items_to_merge == 0 then
			items_page:set_rarity(nil)
		end

		items_page:set_backend_id_disabled_state(backend_id, false)
	end

	local pressed_item_backend_id = merge_ui_page.pressed_item_backend_id

	if pressed_item_backend_id then
		local item_list_index = items_page:index_by_backend_id(pressed_item_backend_id)

		if item_list_index and item_list_index ~= current_selected_list_index then
			local play_sound = true

			items_page:on_inventory_item_selected(item_list_index, play_sound)
			self:compare_item_with_loadout_item(pressed_item_backend_id)
		end
	end

	local merge_request = merge_ui_page.merge_request

	if merge_request and merge_ui_page:is_merge_possible() then
		self:set_input_blocked(true)

		local items_to_merge, token_type, num_tokens = merge_ui_page:get_items()

		self.forge_logic:merge_items(items_to_merge, token_type, num_tokens)

		self.poll_forge = true
	end

	local poll_forge = self.poll_forge

	if poll_forge then
		local merged_item_key, backend_id = self.forge_logic:poll_forge()

		if merged_item_key then
			merge_ui_page:set_merged_item(merged_item_key)
			merge_ui_page:merge()

			self.poll_forge = false

			self:play_sound("Play_hud_forge_merge_result")

			self.merged_item_key = merged_item_key
			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				local player = Managers.player:local_player()
				local stats_id = player:stats_id()
				local statistics_db = Managers.player:statistics_db()
				local current_amount = statistics_db:get_persistent_stat(stats_id, "fused_items")
				local new_amount = current_amount + 5

				statistics_db:set_stat(stats_id, "fused_items", new_amount)
				Managers.player:set_stats_backend(player)
				Managers.backend:commit()
			end
		end
	end

	local merge_completed = merge_ui_page.merge_completed

	if merge_completed then
		self.can_display_item_popup = true
		local backend_ids = merge_ui_page:remove_all_items()

		items_page:refresh()
		items_page:set_rarity(nil)
		items_page:on_inventory_item_selected(current_selected_list_index or 1)
		self:set_input_blocked(false)
		self:refresh_tokens(true)
	end

	local upgrade_item_remove_request = upgrade_ui_page.item_remove_request

	if upgrade_item_remove_request then
		items_page:set_backend_id_disabled_state(upgrade_ui_page.active_item_id, false)
		upgrade_ui_page:remove_item()
		items_page:refresh_items_status()
	end

	local pressed_item_backend_id = upgrade_ui_page.pressed_item_backend_id

	if pressed_item_backend_id then
		local item_list_index = items_page:index_by_backend_id(pressed_item_backend_id)

		if item_list_index and item_list_index ~= current_selected_list_index then
			local play_sound = true

			items_page:on_inventory_item_selected(item_list_index, play_sound)
			self:compare_item_with_loadout_item(pressed_item_backend_id)
		end
	end

	local upgrade_request = upgrade_ui_page.upgrade_request

	if upgrade_request then
		local active_item_id = upgrade_ui_page.active_item_id
		local selected_trait_name = upgrade_ui_page.selected_trait_name
		local token_type, traits_cost = upgrade_ui_page:get_upgrade_cost()
		local upgrade_success = self.forge_logic:upgrade_item(active_item_id, selected_trait_name, token_type, traits_cost)

		if upgrade_success then
			upgrade_ui_page:upgrade()
			self:play_sound("Play_hud_forge_upgrade")
			self:set_input_blocked(true)

			local selected_item = items_page:selected_item()

			if selected_item and selected_item.backend_id == active_item_id then
				self:compare_item_with_loadout_item(active_item_id)
			end

			local backend_manager = Managers.backend

			if backend_manager:available() and backend_manager:profiles_loaded() then
				local stats_id = Managers.player:local_player():stats_id()
				local statistics_db = Managers.player:statistics_db()

				statistics_db:increment_stat(stats_id, "upgraded_items")
			end

			items_page:refresh_items_status()
		else
			upgrade_ui_page:upgrade_failed()
		end
	end

	local upgrade_completed = upgrade_ui_page.upgrade_completed

	if upgrade_completed then
		upgrade_ui_page:refresh()
		self:refresh_tokens(true)
		items_page:refresh_items_status()
		self:set_input_blocked(false)

		local player = Managers.player:local_player()
		local player_unit = player.player_unit

		if Unit.alive(player_unit) then
			local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")

			inventory_extension:rewield_wielded_slot()
			inventory_extension:apply_buffs_to_ammo()
		end
	end

	if item_selected then
		local item_backend_id = item_selected.backend_id

		if melt_active then
			if melt_ui_page.melting then
				melt_ui_page:abort_melt()
			elseif ScriptBackendItem.is_salvageable(item_backend_id) then
				melt_ui_page:start_melt_progress(item_backend_id)
			end
		elseif merge_ui_page.active then
			local specific_slot_index = merge_ui_page.specific_slot_index

			if merge_ui_page.num_items_to_merge < 5 then
				local added = merge_ui_page:add_item(item_backend_id, specific_slot_index)
				local num_items_to_merge = merge_ui_page.num_items_to_merge

				if added then
					if num_items_to_merge == 1 then
						local rarity = item_selected.rarity

						items_page:set_rarity(rarity)
					end

					items_page:set_backend_id_disabled_state(item_backend_id, true)
				end

				merge_ui_page:clear_merged_item()
			end
		elseif upgrade_ui_page.active then
			local current_item_id = upgrade_ui_page.active_item_id

			if current_item_id then
				items_page:set_backend_id_disabled_state(current_item_id, false)
			end

			upgrade_ui_page:add_item(item_backend_id)
			items_page:refresh_items_status()
			items_page:set_backend_id_disabled_state(item_backend_id, true)
		end
	elseif melt_ui_page.active and melt_ui_page.item_to_melt then
		local item_to_melt = melt_ui_page.item_to_melt
		local backend_id_to_melt = item_to_melt.backend_id

		if melt_ui_page.melting then
			melt_ui_page:abort_melt()
		elseif ScriptBackendItem.is_salvageable(backend_id_to_melt) then
			melt_ui_page:start_melt_progress(backend_id_to_melt)
		end
	elseif melt_ui_page.active and melt_ui_page.melting and gamepad_active and (not input_service:get("refresh_hold") or input_service:get("move_up") or input_service:get("move_down")) then
		melt_ui_page:abort_melt()
	end

	if melt_ui_page.active and not melt_ui_page.melting then
		local melted_item_id = melt_ui_page.melted_item_id

		if melted_item_id then
			local melt_successful, item_name, number_of_tokens = self.forge_logic:melt_item(melted_item_id)

			if melt_successful then
				self:refresh_tokens(true)

				local ignore_scroll_reset = true

				items_page:remove_item(melted_item_id, ignore_scroll_reset)

				local backend_manager = Managers.backend

				if backend_manager:available() and backend_manager:profiles_loaded() then
					local player = Managers.player:local_player()
					local stats_id = player:stats_id()
					local statistics_db = Managers.player:statistics_db()

					statistics_db:increment_stat(stats_id, "salvaged_items")
					Managers.player:set_stats_backend(player)
					Managers.backend:commit()
				end

				melt_ui_page:melt(item_name, number_of_tokens)
				self:play_sound("Play_hud_forge_activate_melt")
				self:play_sound("Play_hud_forge_disassemble")
			end
		end
	end
end

ForgeView.compare_item_with_loadout_item = function (self, item_backend_id)
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
		local selected_profile_name = items_page:current_profile_name()
		local slot_names_by_type = InventorySettings.slot_names_by_type
		local slots_by_name = InventorySettings.slots_by_name
		local slot_name = slot_names_by_type[item_type][1]
		local loadout_item = BackendUtils.get_loadout_item(selected_profile_name, slot_name)
		loadout_item_backend_id = loadout_item.backend_id
	end

	compare_ui_page:on_item_selected(item_backend_id, loadout_item_backend_id)
end

ForgeView.refresh_tokens = function (self, play_animation)
	local num_tokens = ForgeSettings.num_token_types
	local token_widgets_by_name = self.token_widgets_by_name
	local ui_animations = self.ui_animations

	for token_type, token_data in pairs(ForgeSettings.token_types) do
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
end

ForgeView.get_rarity_color = function (self, rarity)
	local color_name = ForgeSettings.rarity_colors[rarity] or "white"

	return Colors.get_color_table_with_alpha(color_name, 255)
end

ForgeView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

ForgeView.update_button_bar_animation = function (self, widget, widget_name, dt)
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
			self:play_sound("Play_hud_hover")

			local background_fade_in_time = bar_settings.background.fade_in_time
			local icon_fade_in_time = bar_settings.icon.fade_in_time
			local background_alpha_hover = bar_settings.background.alpha_hover
			local icon_alpha_hover = bar_settings.icon.alpha_hover
			active_animations[button_style_name] = self:animate_element_by_time(button_style.color, 1, button_style.color[1], background_alpha_hover, background_fade_in_time)
			active_animations[icon_texture_id] = self:animate_element_by_time(icon_style.color, 1, icon_style.color[1], icon_alpha_hover, icon_fade_in_time)
		elseif button_hotspot.on_hover_exit then
			local background_fade_out_time = bar_settings.background.fade_out_time
			local icon_fade_out_time = bar_settings.icon.fade_out_time
			local background_alpha_normal = bar_settings.background.alpha_normal
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

ForgeView.set_input_blocked = function (self, blocked)
	self.input_blocked = blocked
	local ui_pages = self.ui_pages
	local items_page = ui_pages.items
	local compare_ui_page = ui_pages.compare

	items_page:disable_input(blocked)
	compare_ui_page:disable_input(blocked)
end

ForgeView.create_display_item_popup = function (self)
	if not self.item_display_popup then
		local ingame_ui_context = self.ingame_ui_context
		local position = definitions.scenegraph_definition.popup_root.position
		local world_name = "reward_preview"
		self.item_display_popup = ItemDisplayPopup:new(ingame_ui_context, world_name, "lua_spin", position, self)
	end
end

ForgeView.display_item_popup = function (self, item_key)
	self.item_display_popup:on_enter(item_key)
end

ForgeView.diplay_popup_active = function (self)
	if self.item_display_popup.active then
		return true
	end
end

ForgeView.close_item_display_popup = function (self)
	self.close_item_popup = true
end

ForgeView.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end

ForgeView.destroy = function (self)
	if self.melt_active then
		local toggle_off_melt = true

		self:toggle_melt_mode(toggle_off_melt)
	end

	self.menu_input_description:destroy()

	self.menu_input_description = nil
	self.ingame_ui_context = nil
	self.ui_animator = nil
	local item_display_popup = self.item_display_popup

	if item_display_popup then
		item_display_popup:destroy()

		self.item_display_popup = nil
	end

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)

	UIPasses.is_dragging_item = false
end

ForgeView.on_gamepad_activated = function (self)
	local ui_pages = self.ui_pages

	ui_pages.items:set_gamepad_focus(true)

	local gamepad_selected_page = self.gamepad_selected_page

	if gamepad_selected_page and ui_pages[gamepad_selected_page].set_gamepad_focus then
		ui_pages[gamepad_selected_page]:set_gamepad_focus(true)
	end
end

ForgeView.set_gamepad_active_forge_page = function (self, name)
	self:set_gamepad_page_focus(name)
end

ForgeView.set_gamepad_page_focus = function (self, name)
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

	self:update_input_description()
end

ForgeView.update_input_description = function (self)
	local ui_pages = self.ui_pages
	local gamepad_selected_page = self.gamepad_selected_page
	local page_input_actions = input_actions[gamepad_selected_page]
	local page = ui_pages[gamepad_selected_page]
	local actions_name_to_use = nil

	if gamepad_selected_page == "merge" then
		local merge_item_ids = page.item_list
		local num_merge_item_ids = #merge_item_ids
		local items_page = ui_pages.items
		local selected_item, is_equipped, is_active = items_page:selected_item()
		local same_item = false

		if selected_item then
			local selected_item_backend_id = selected_item.backend_id

			for index, item_id in ipairs(merge_item_ids) do
				if item_id == selected_item_backend_id then
					same_item = true

					break
				end
			end
		end

		if page.merging then
			actions_name_to_use = "disabled_item"
		elseif num_merge_item_ids == 5 or (num_merge_item_ids > 0 and page:enough_tokens_available()) then
			if page:is_merge_possible() then
				if num_merge_item_ids ~= 5 and is_active and not same_item then
					actions_name_to_use = "item_added_not_selected_can_afford"
				else
					actions_name_to_use = "all_items_added"
				end
			else
				actions_name_to_use = "item_added_and_selected"
			end
		elseif selected_item then
			if same_item or (not is_active and num_merge_item_ids > 0) then
				actions_name_to_use = "item_added_and_selected"
			elseif not is_active then
				actions_name_to_use = "disabled_item"
			elseif num_merge_item_ids > 0 then
				actions_name_to_use = "item_added_not_selected"
			end
		elseif num_merge_item_ids > 0 then
			actions_name_to_use = "item_added_not_selected"
		end
	elseif gamepad_selected_page == "upgrade" then
		local upgrade_item_backend_id = page.active_item_id
		local items_page = ui_pages.items
		local selected_item, is_equipped, is_active = items_page:selected_item()

		if selected_item then
			local is_upgrade_possible = page:is_upgrade_possible()

			if upgrade_item_backend_id then
				if selected_item.backend_id == upgrade_item_backend_id then
					if is_upgrade_possible then
						actions_name_to_use = "item_added_and_selected"
					else
						actions_name_to_use = "item_added_and_selected_upgrade_disabled"
					end
				elseif is_upgrade_possible then
					if not is_active then
						actions_name_to_use = "item_added_and_selected"
					else
						actions_name_to_use = "item_added_not_selected"
					end
				elseif not is_active then
					actions_name_to_use = "item_added_not_selected_upgrade_disabled_item_disabled"
				else
					actions_name_to_use = "item_added_not_selected_upgrade_disabled"
				end
			elseif not is_active then
				actions_name_to_use = "disabled_item"
			end
		end
	elseif gamepad_selected_page == "melt" then
		local items_page = ui_pages.items
		local selected_item, is_equipped, is_active = items_page:selected_item()

		if selected_item then
			local selected_item_backend_id = selected_item.backend_id

			if selected_item_backend_id then
				local is_salvageable = ScriptBackendItem.is_salvageable(selected_item_backend_id)

				ui_pages.melt:can_melt_selected_item(is_salvageable)
			end

			if page.melting then
				if selected_item_backend_id == page.item_id_to_melt then
					actions_name_to_use = "melting"
				end
			elseif not is_active then
				actions_name_to_use = "disabled_item"
			end
		end
	end

	actions_name_to_use = actions_name_to_use or "default"

	if not self.gamepad_active_actions_name or self.gamepad_active_actions_name ~= actions_name_to_use then
		self.gamepad_active_actions_name = actions_name_to_use
		input_description_data.actions = page_input_actions[actions_name_to_use]

		self.menu_input_description:set_input_description(input_description_data)
	end
end

ForgeView.on_gamepad_deactivated = function (self)
	local ui_pages = self.ui_pages

	ui_pages.items:set_gamepad_focus(true)

	local gamepad_selected_page = self.gamepad_selected_page

	if gamepad_selected_page and ui_pages[gamepad_selected_page].set_gamepad_focus then
		ui_pages[gamepad_selected_page]:set_gamepad_focus(false)
	end
end

ForgeView.handle_gamepad_input = function (self, dt)
	self:update_input_description()

	local ui_pages = self.ui_pages
	local input_service = self:page_input_service()
	local gamepad_selected_page = self.gamepad_selected_page
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and controller_cooldown > 0 then
		self.controller_cooldown = controller_cooldown - dt
	else
		if input_service:get("back") then
			local melt_ui_page = ui_pages.melt

			if melt_ui_page.melting then
				melt_ui_page:abort_melt()
			else
				local return_to_game = not self.ingame_ui.menu_active

				self:exit(return_to_game)
				self:play_sound("Play_hud_select")

				return
			end
		end

		local selected_selection_bar_index = self.selected_selection_bar_index

		if selected_selection_bar_index then
			local new_selection_bar_index = nil

			if input_service:get("trigger_cycle_next") then
				local forge_selection_bar = self.forge_selection_bar_widget
				local forge_selection_bar_content = forge_selection_bar.content
				new_selection_bar_index = math.min(selected_selection_bar_index + 1, #forge_selection_bar_content)
				self.controller_cooldown = GamepadSettings.menu_cooldown
			elseif input_service:get("trigger_cycle_previous") then
				new_selection_bar_index = math.max(selected_selection_bar_index - 1, 1)
				self.controller_cooldown = GamepadSettings.menu_cooldown
			end

			if new_selection_bar_index and new_selection_bar_index ~= selected_selection_bar_index then
				self.gamepad_changed_selection_bar_index = new_selection_bar_index
			end
		end

		if gamepad_selected_page == "melt" then
			if not self.melt_active then
				local used_by_gamepad = true

				self:toggle_melt_mode(nil, used_by_gamepad)
			end

			if input_service:get("refresh_press") then
				self.gamepad_request_melt_item = true
				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		end
	end
end

return
