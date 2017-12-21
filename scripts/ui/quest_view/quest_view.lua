local definitions = local_require("scripts/ui/quest_view/quest_view_definitions")

require("scripts/settings/equipment/item_master_list")
require("scripts/managers/backend/backend_utils")
require("scripts/ui/reward_ui/reward_popup_handler")
require("scripts/settings/quest_settings")
require("scripts/ui/quest_view/quest_reward_presentation_ui")

local widget_definitions = definitions.widgets_definitions
local scenegraph_definition = definitions.scenegraph_definition
local create_quest_widget = definitions.create_quest_widget
local create_log_contract_widget = definitions.create_log_contract_widget
local create_board_contract_widget = definitions.create_board_contract_widget
local contract_lists_scenegraph_ids = definitions.contract_lists_scenegraph_ids

local function dprint(...)
	print("[QuestView]", ...)

	return 
end

local DO_RELOAD = true
local debug_draw_scenegraph = false
QuestView = class(QuestView)
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
local contract_list_types = {
	"main",
	"drachenfels",
	"dwarfs"
}
local contract_list_index_by_type = {
	drachenfels = 3,
	main = 2
}
local button_texts = {
	turn_in = "dlc1_3_1_turn_in",
	decline = "dlc1_3_1_decline",
	discard = "dlc1_3_1_discard",
	accept = "dlc1_3_1_accept"
}
local button_tooltips = {
	quests_full = "dlc1_3_1_quest_log_full",
	contracts_full = "dlc1_3_1_contract_log_full"
}
local contract_large_paper_by_type = {
	dwarfs = "contract_large_dwarf",
	drachenfels = "contract_large_drachenfels",
	main = "contract_large_ubersreik"
}
local quest_title_by_type = {
	dwarfs = "dlc1_5_area_dwarf",
	drachenfels = "dlc1_4_area_drachenfels",
	main = "dlc1_4_area_ubersreik"
}
local entries_per_board_list = {
	3,
	2,
	4
}
local input_description_data = {
	gamepad_support = true,
	name = "quest_view"
}
local generic_input_actions = {}
local input_actions = {
	default = {
		{
			input_action = "back",
			priority = 50,
			description_text = "input_description_back"
		}
	},
	selection = {
		{
			input_action = "cycle_previous",
			priority = 48,
			description_text = "input_description_inspect_reward"
		},
		{
			input_action = "confirm",
			priority = 49,
			description_text = "input_description_open"
		},
		{
			input_action = "back",
			priority = 50,
			description_text = "input_description_back"
		}
	},
	selection_disabled = {
		{
			input_action = "cycle_previous",
			priority = 48,
			description_text = "input_description_inspect_reward"
		},
		{
			input_action = "back",
			priority = 50,
			description_text = "input_description_back"
		}
	}
}
local QuestSettings = QuestSettings
QuestView.init = function (self, ingame_ui_context)
	self.world = ingame_ui_context.world
	self.player_manager = ingame_ui_context.player_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.peer_id = ingame_ui_context.peer_id
	self.local_player_id = ingame_ui_context.local_player_id
	self.is_server = ingame_ui_context.is_server
	self.quest_manager = Managers.state.quest
	self.statistics_db = ingame_ui_context.statistics_db
	self.player_manager = ingame_ui_context.player_manager
	local player = Managers.player:local_player()
	self.player_stats_id = player.stats_id(player)
	self.reward_screen = QuestRewardPresentationUI:new(ingame_ui_context)
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager.create_input_service(input_manager, "quest_view", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "quest_view", "keyboard")
	input_manager.map_device_to_service(input_manager, "quest_view", "mouse")
	input_manager.map_device_to_service(input_manager, "quest_view", "gamepad")

	if not PlayerData.quest_data then
		local quest_data = {
			stored_board_ids = {},
			stored_log_ids = {}
		}
	end

	if not quest_data.stored_board_ids then
		quest_data.stored_board_ids = {}
	end

	if not quest_data.stored_log_ids then
		quest_data.stored_log_ids = {}
	end

	self._stored_board_ids = quest_data.stored_board_ids
	self._stored_log_ids = quest_data.stored_log_ids
	self.quest_data = quest_data
	self.ingame_ui_context = ingame_ui_context
	self.ui_animations = {}

	self.create_ui_elements(self)

	local input_service = self.input_manager:get_service("quest_view")
	local number_of_actvie_descriptions = 3
	local gui_layer = UILayer.default + 35
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, number_of_actvie_descriptions, gui_layer, generic_input_actions)

	self.menu_input_description:set_input_description(nil)

	DO_RELOAD = false

	return 
end
QuestView.input_service = function (self)
	return (self._waiting_for_reward_presentation and fake_input_service) or self.input_manager:get_service("quest_view")
end
QuestView.menu_input_service = function (self)
	return (self.input_blocked and fake_input_service) or self.input_service(self)
end
QuestView.set_input_blocked = function (self, blocked)
	self.input_blocked = blocked

	return 
end
QuestView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
QuestView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._background_hotspot = UIWidget.init(widget_definitions.background_hotspot)
	self._static_widgets = {
		UIWidget.init(widget_definitions.background),
		UIWidget.init(widget_definitions.title_text),
		UIWidget.init(widget_definitions.contract_log_title),
		UIWidget.init(widget_definitions.contract_list_title),
		UIWidget.init(widget_definitions.contract_log_holder_1),
		UIWidget.init(widget_definitions.contract_log_holder_2),
		UIWidget.init(widget_definitions.contract_log_holder_3),
		UIWidget.init(widget_definitions.dead_space_filler)
	}
	local num_board_lists = #contract_lists_scenegraph_ids
	local board_widgets = {}
	local gamepad_widget_navigation_table = {
		{},
		{}
	}

	for i = 1, num_board_lists, 1 do
		local parent_scenegraph_id = contract_lists_scenegraph_ids[i]
		local contract_widgets = {}
		local num_entries_per_list = entries_per_board_list[i]

		for k = 1, num_entries_per_list, 1 do
			if i == 1 then
				contract_widgets[k] = UIWidget.init(create_quest_widget(parent_scenegraph_id))
			else
				contract_widgets[k] = UIWidget.init(create_board_contract_widget(parent_scenegraph_id))
			end

			gamepad_widget_navigation_table[1][#gamepad_widget_navigation_table[1] + 1] = contract_widgets[k]
		end

		board_widgets[i] = contract_widgets
	end

	self._board_widgets = board_widgets
	local num_entries_per_log = QuestSettings.MAX_NUMBER_OF_LOG_CONTRACTS + QuestSettings.MAX_NUMBER_OF_LOG_QUESTS
	local log_widgets = {}
	local contract_log_scenegraph_id = "contract_log"

	for i = 1, num_entries_per_log, 1 do
		if i == 1 then
			log_widgets[i] = UIWidget.init(create_quest_widget(contract_log_scenegraph_id))
			local tooltip_style = log_widgets[i].style.tooltip_text
			tooltip_style.cursor_side = "left"
			tooltip_style.draw_downwards = true
			tooltip_style.cursor_offset = {
				-10,
				0
			}
		else
			log_widgets[i] = UIWidget.init(create_log_contract_widget(contract_log_scenegraph_id))
		end

		gamepad_widget_navigation_table[2][#gamepad_widget_navigation_table[2] + 1] = log_widgets[i]
	end

	self._log_widgets = log_widgets
	self._gamepad_widget_navigation_table = gamepad_widget_navigation_table
	self._exit_button_widget = UIWidget.init(widget_definitions.exit_button)
	self._accept_button_widget = UIWidget.init(widget_definitions.accept_button)
	self._progress_button_widget = UIWidget.init(widget_definitions.progress_button)
	local presentation_widgets = {
		background = UIWidget.init(widget_definitions.presentation_bg),
		title = UIWidget.init(widget_definitions.presentation_title),
		sub_title = UIWidget.init(widget_definitions.presentation_sub_title),
		difficulty = UIWidget.init(widget_definitions.presentation_difficulty),
		text = UIWidget.init(widget_definitions.presentation_text),
		reward_title = UIWidget.init(widget_definitions.presentation_reward_title),
		objective_icon = UIWidget.init(widget_definitions.presentation_objective_icon),
		objective_counter = UIWidget.init(widget_definitions.presentation_objective_counter),
		objective_title = UIWidget.init(widget_definitions.presentation_objective_title),
		completed = UIWidget.init(widget_definitions.presentation_completed),
		divider = UIWidget.init(widget_definitions.presentation_title_divider),
		token = UIWidget.init(widget_definitions.presentation_reward_token),
		boon = UIWidget.init(widget_definitions.presentation_reward_boon),
		item = UIWidget.init(widget_definitions.presentation_reward_item),
		item_frame = UIWidget.init(widget_definitions.presentation_reward_item_frame),
		item_name = UIWidget.init(widget_definitions.presentation_item_name),
		item_type_name = UIWidget.init(widget_definitions.presentation_item_type_name),
		item_hero_icon = UIWidget.init(widget_definitions.presentation_item_hero_icon),
		item_hero_tooltip = UIWidget.init(widget_definitions.presentation_item_hero_tooltip),
		item_border = UIWidget.init(widget_definitions.presentation_item_border),
		item_border_icon = UIWidget.init(widget_definitions.presentation_item_border_icon),
		trait_button_1 = UIWidget.init(widget_definitions.presentation_trait_button_1),
		trait_button_2 = UIWidget.init(widget_definitions.presentation_trait_button_2),
		trait_button_3 = UIWidget.init(widget_definitions.presentation_trait_button_3),
		trait_button_4 = UIWidget.init(widget_definitions.presentation_trait_button_4),
		trait_tooltip_1 = UIWidget.init(widget_definitions.presentation_trait_tooltip_1),
		trait_tooltip_2 = UIWidget.init(widget_definitions.presentation_trait_tooltip_2),
		trait_tooltip_3 = UIWidget.init(widget_definitions.presentation_trait_tooltip_3),
		trait_tooltip_4 = UIWidget.init(widget_definitions.presentation_trait_tooltip_4)
	}
	presentation_widgets.trait_button_1.content.use_background = false
	presentation_widgets.trait_button_2.content.use_background = false
	presentation_widgets.trait_button_3.content.use_background = false
	presentation_widgets.trait_button_4.content.use_background = false
	presentation_widgets.difficulty.style.text.localize = false
	presentation_widgets.item_type_name.style.text.text_color = {
		255,
		255,
		255,
		255
	}
	self._presentation_widgets = presentation_widgets
	local loading_widgets = {
		overlay = UIWidget.init(widget_definitions.loading_overlay),
		icon = UIWidget.init(widget_definitions.loading_icon),
		text = UIWidget.init(widget_definitions.loading_text)
	}
	loading_widgets.overlay.style.rect.color[1] = 0
	loading_widgets.icon.style.texture_id.color[1] = 0
	loading_widgets.text.style.text.text_color[1] = 0
	self._loading_widgets = loading_widgets
	self._quest_bar_widgets = {
		bar = UIWidget.init(widget_definitions.quest_progress_bar),
		bar_dots = UIWidget.init(widget_definitions.quest_progress_bar_dots),
		bar_dot_slots = UIWidget.init(widget_definitions.quest_progress_bar_dot_slots),
		bar_slots_dots = UIWidget.init(widget_definitions.quest_progress_bar_slots_dots)
	}

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, definitions.animations)
	self._reload_button_widget = UIWidget.init(widget_definitions.reload_button)

	self._align_board_entries(self)
	self._align_log_entries(self)

	return 
end
QuestView.draw = function (self, dt, input_service)
	local ui_renderer = self.ui_renderer
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local reward_screen_active = self.reward_screen:active()
	local widgets_by_name = self.widgets_by_name

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	if debug_draw_scenegraph then
		UISceneGraph.debug_render_scenegraph(ui_renderer, ui_scenegraph)
	end

	for _, widget in ipairs(self._static_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	for _, widget in ipairs(self._log_widgets) do
		local active = widget.content.active

		if active then
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	for list_index, widget_list in ipairs(self._board_widgets) do
		for widget_index, widget in ipairs(widget_list) do
			local active = widget.content.active

			if active then
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end
	end

	UIRenderer.draw_widget(ui_renderer, self._exit_button_widget)
	UIRenderer.draw_widget(ui_renderer, self._background_hotspot)

	if self._selected_widget or self._hovered_widget then
		UIRenderer.draw_widget(ui_renderer, self._accept_button_widget)

		if self._debug_menu and self._draw_progress_button then
			UIRenderer.draw_widget(ui_renderer, self._progress_button_widget)

			if self._progress_button_widget.content.button_hotspot.on_release then
				local id = self._selected_widget.content.data.id

				Managers.backend:get_interface("quests"):add_all_contract_progress(id)
				self._deselect_selection_widget(self)
			end
		end

		for _, widget in pairs(self._presentation_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	for _, widget in pairs(self._loading_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	for _, widget in pairs(self._quest_bar_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	if self._debug_menu then
		UIRenderer.draw_widget(ui_renderer, self._reload_button_widget)

		if self._reload_button_widget.content.button_hotspot.on_release then
			self._reload_button_widget.content.button_hotspot.on_release = nil

			self._refresh_quest_and_contracts(self)
		end
	end

	UIRenderer.end_pass(ui_renderer)

	if gamepad_active and not reward_screen_active and not self._decline_contract_popup_id and not self._decline_quest_popup_id and not self._turn_in_contract_popup_id then
		self.menu_input_description:draw(ui_top_renderer, dt)
	end

	return 
end
QuestView.post_update = function (self, dt, t)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if self.suspended then
		return 
	end

	local quest_manager = self.quest_manager
	local is_querying_quests_and_contracts = quest_manager.is_querying_quests_and_contracts(quest_manager)
	local is_time_to_prepare_sync = quest_manager.prepare_for_new_quests_and_contracts(quest_manager)
	local loading = (is_querying_quests_and_contracts or is_time_to_prepare_sync) and not self._waiting_for_reward_presentation

	if loading then
		if not self._loading_previous_frame then
			self._terminate_all_popups(self)
			self._deselect_selection_widget(self)
			self._loading_overlay_fade_in(self, 180)
		end

		self._rotate_loading_icon(self, dt)
	elseif self._loading_previous_frame then
		self._loading_overlay_fade_out(self)
	end

	self._loading_previous_frame = loading

	self._poll_backend(self)
	self._poll_popups(self)

	local input_manager = self.input_manager
	local input_service = (loading and fake_input_service) or self.menu_input_service(self)
	local transitioning = self.transitioning(self)
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local gamepad_input_pressed = self.gamepad_input_pressed
	local reward_screen = self.reward_screen
	local reward_screen_active = reward_screen and reward_screen.active(reward_screen)

	if reward_screen_active then
		Profiler.start("reward_screen")
		reward_screen.update(reward_screen, dt, t)
		Profiler.stop()

		input_service = fake_input_service
	end

	self.ui_animator:update(dt)

	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil
		end
	end

	if not self.active then
		return 
	end

	if not transitioning then
		if gamepad_active then
			if not self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = true

				self._on_gamepad_activated(self)
			end

			if not reward_screen_active then
				self._handle_gamepad_input(self, dt, t, input_service)
			end

			self._update_input_description(self)
		else
			if self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = false

				self._on_gamepad_deactivated(self)
			end

			if not loading then
				self._handle_mouse_input(self, dt, t, input_service)
			end
		end
	end

	if self.active then
		self.draw(self, dt, input_service)
	end

	return 
end
QuestView.update = function (self, dt, t)
	return 
end
QuestView._poll_popups = function (self)
	if self._decline_contract_popup_id then
		local popup_result = Managers.popup:query_result(self._decline_contract_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self._decline_contract_popup_id)

			self._decline_contract_popup_id = nil
		end

		if popup_result == "yes" then
			local selected_contract_list_widget = self._selected_widget

			if selected_contract_list_widget then
				local data = selected_contract_list_widget.content.data
				local id = data.id

				self._decline_contract(self, id)
			end
		end
	end

	if self._decline_quest_popup_id then
		local popup_result = Managers.popup:query_result(self._decline_quest_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self._decline_quest_popup_id)

			self._decline_quest_popup_id = nil
		end

		if popup_result == "yes" then
			local selected_contract_list_widget = self._selected_widget

			if selected_contract_list_widget then
				local data = selected_contract_list_widget.content.data
				local id = data.id

				self._decline_quest(self, id)
			end
		end
	end

	if self._turn_in_contract_popup_id then
		local popup_result = Managers.popup:query_result(self._turn_in_contract_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self._turn_in_contract_popup_id)

			self._turn_in_contract_popup_id = nil
		end

		if popup_result == "yes" then
			local selected_contract_list_widget = self._selected_widget

			if selected_contract_list_widget then
				local data = selected_contract_list_widget.content.data
				local id = data.id

				self._turn_in_contract(self, id)
			end
		end
	end

	return 
end
QuestView.on_enter = function (self)
	local input_manager = self.input_manager

	input_manager.block_device_except_service(input_manager, "quest_view", "keyboard", 1)
	input_manager.block_device_except_service(input_manager, "quest_view", "mouse", 1)
	input_manager.block_device_except_service(input_manager, "quest_view", "gamepad", 1)

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)
	self.reward_screen:on_enter()
	self.quest_manager:set_poll_active(true)
	self.play_sound(self, "Play_hud_quest_menu_open")

	self.active = true
	self._debug_menu = Development.parameter("debug_quest_view")

	self._sync_quests_and_contracts(self)

	return 
end
QuestView.post_update_on_enter = function (self)
	return 
end
QuestView.post_update_on_exit = function (self)
	return 
end
QuestView.on_exit = function (self)
	self.exiting = nil
	self.active = nil
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	self.reward_screen:exit()
	self._terminate_all_popups(self)
	self._deselect_selection_widget(self)

	return 
end
QuestView.exit = function (self, return_to_game)
	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)
	self.play_sound(self, "Play_hud_button_close")

	self.exiting = true

	self.quest_manager:set_poll_active(false)

	PlayerData.quest_data = self.quest_data

	Managers.save:auto_save(SaveFileName, SaveData)

	return 
end
QuestView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	return 
end
QuestView.suspend = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)

	self.suspended = true

	self._terminate_all_popups(self)
	self._deselect_selection_widget(self)

	return 
end
QuestView.unsuspend = function (self)
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)
	self.input_manager:block_device_except_service("quest_view", "keyboard", 1)
	self.input_manager:block_device_except_service("quest_view", "mouse", 1)
	self.input_manager:block_device_except_service("quest_view", "gamepad", 1)

	self.suspended = nil

	return 
end
QuestView._show_reward = function (self, rewards)
	self.reward_screen:start_reward_presentation(rewards)

	return 
end
QuestView._hide_reward = function (self)
	self.reward_screen:stop_reward_presentation()

	local input_manager = self.input_manager

	input_manager.block_device_except_service(input_manager, "quest_view", "mouse")
	input_manager.block_device_except_service(input_manager, "quest_view", "keyboard")
	input_manager.block_device_except_service(input_manager, "quest_view", "gamepad")

	return 
end
QuestView._handle_exit = function (self, input_service)
	local exit_button_widget = self._exit_button_widget

	if exit_button_widget.content.button_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if exit_button_widget.content.button_hotspot.on_release or input_service.get(input_service, "toggle_menu") then
		local return_to_game = not self.ingame_ui.menu_active

		self.exit(self, return_to_game)

		return true
	end

	return 
end
QuestView.destroy = function (self)
	if self.reward_screen then
		self.reward_screen:destroy()
	end

	if self.menu_input_description then
		self.menu_input_description:destroy()

		self.menu_input_description = nil
	end

	self.ingame_ui_context = nil
	self.ui_animator = nil
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	self.quest_manager:set_poll_active(false)

	self.quest_manager = nil

	return 
end
QuestView._on_gamepad_activated = function (self)
	self._exit_button_widget.content.visible = false
	self._accept_button_widget.content.visible = false
	local use_fixed_position = true

	for table_index, widgets in ipairs(self._gamepad_widget_navigation_table) do
		for widget_index, widget in ipairs(widgets) do
			widget.style.tooltip_text.use_fixed_position = use_fixed_position
		end
	end

	return 
end
QuestView._on_gamepad_deactivated = function (self)
	self._exit_button_widget.content.visible = true
	self._accept_button_widget.content.visible = true
	local use_fixed_position = false

	for table_index, widgets in ipairs(self._gamepad_widget_navigation_table) do
		for widget_index, widget in ipairs(widgets) do
			widget.style.tooltip_text.use_fixed_position = use_fixed_position
		end
	end

	return 
end
QuestView._update_input_description = function (self)
	local actions_name_to_use = nil

	if self._selected_widget then
		if self._accept_button_widget.content.button_hotspot.disabled then
			actions_name_to_use = "selection_disabled"
		else
			actions_name_to_use = "selection"
		end
	else
		actions_name_to_use = "default"
	end

	if not self.gamepad_active_actions_name or self.gamepad_active_actions_name ~= actions_name_to_use then
		self.gamepad_active_actions_name = actions_name_to_use
		input_description_data.actions = input_actions[actions_name_to_use]

		self.menu_input_description:set_input_description(input_description_data)
	end

	return 
end
QuestView._is_widget_selectable = function (self, widget)
	local data = widget.content.data

	return data ~= nil
end
QuestView._get_closest_widget_by_direction = function (self, table_index, current_selection_index, direction)
	local gamepad_widget_navigation_table = self._gamepad_widget_navigation_table
	local widgets = gamepad_widget_navigation_table[table_index]
	local num_widgets = #widgets
	local closest_index = nil

	if direction == "down" then
		for index = current_selection_index, (num_widgets + current_selection_index) - 2, 1 do
			local read_index = index%num_widgets + 1
			local widget = widgets[read_index]

			if self._is_widget_selectable(self, widget) then
				closest_index = read_index

				break
			end
		end
	else
		for index = (num_widgets + current_selection_index) - 2, current_selection_index, -1 do
			local read_index = index%num_widgets + 1
			local widget = widgets[read_index]

			if self._is_widget_selectable(self, widget) then
				closest_index = read_index

				break
			end
		end
	end

	if closest_index then
		return widgets[closest_index], closest_index
	end

	return 
end
QuestView._gamepad_navigate_selection = function (self, direction)
	local new_select_table_index = nil

	if direction == "left" then
		new_select_table_index = 1
	elseif direction == "right" then
		new_select_table_index = 2
	end

	if new_select_table_index then
		if new_select_table_index ~= self._gamepad_select_table_index then
			local widget, index = self._get_closest_widget_by_direction(self, new_select_table_index, 0, "down")

			if widget then
				self._gamepad_select_table_index = new_select_table_index
				self._gamepad_select_widget_index = index

				self._select_entry_widget(self, widget)
			end
		end
	else
		local widget, index = self._get_closest_widget_by_direction(self, self._gamepad_select_table_index or 1, self._gamepad_select_widget_index or 0, direction)

		if index and index ~= self._gamepad_select_widget_index then
			self._gamepad_select_widget_index = index

			self._select_entry_widget(self, widget)
		end
	end

	return 
end
QuestView._handle_gamepad_input = function (self, dt, t, input_service)
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	else
		local gamepad_preview = false

		if input_service.get(input_service, "move_left") or input_service.get(input_service, "move_left_hold") then
			self.controller_cooldown = GamepadSettings.quest_menu_navigation_cooldown

			self._gamepad_navigate_selection(self, "left")
		elseif input_service.get(input_service, "move_right") or input_service.get(input_service, "move_right_hold") then
			self.controller_cooldown = GamepadSettings.quest_menu_navigation_cooldown

			self._gamepad_navigate_selection(self, "right")
		elseif input_service.get(input_service, "move_up") or input_service.get(input_service, "move_up_hold") then
			self.controller_cooldown = GamepadSettings.quest_menu_navigation_cooldown

			self._gamepad_navigate_selection(self, "up")
		elseif input_service.get(input_service, "move_down") or input_service.get(input_service, "move_down_hold") then
			self.controller_cooldown = GamepadSettings.quest_menu_navigation_cooldown

			self._gamepad_navigate_selection(self, "down")
		elseif input_service.get(input_service, "cycle_previous_hold") and self._selected_widget then
			gamepad_preview = true
		elseif not self._accept_input_blocked and input_service.get(input_service, "confirm") then
			self.controller_cooldown = GamepadSettings.menu_cooldown
			local input_handled = self._on_accept_pressed(self)

			if input_handled then
				self.play_sound(self, "Play_hud_select")
			end
		elseif input_service.get(input_service, "back") or input_service.get(input_service, "toggle_menu") then
			self.controller_cooldown = GamepadSettings.menu_cooldown

			self.play_sound(self, "Play_hud_select")

			local return_to_game = not self.ingame_ui.menu_active

			self.exit(self, return_to_game)
		end

		if self._selected_widget then
			self._selected_widget.content.gamepad_preview = gamepad_preview
		end
	end

	return 
end
QuestView._handle_mouse_input = function (self, dt, t, input_service)
	local quest_manager = self.quest_manager
	local input_pressed = false
	local any_hovered = false
	local button_on_hover_enter = self._button_on_hover_enter(self, self._accept_button_widget)
	local on_pressed = self._is_button_pressed(self, self._accept_button_widget)

	if button_on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if on_pressed then
		input_pressed = self._on_accept_pressed(self)

		if input_pressed then
			self.play_sound(self, "Play_hud_select")
		end
	end

	local new_selection = false

	for list_index, widget_list in ipairs(self._board_widgets) do
		for widget_index, widget in ipairs(widget_list) do
			local content = widget.content
			local active = content.active
			local is_selected = content.button_hotspot.is_selected

			if active and not is_selected then
				local button_hotspot = content.button_hotspot
				local on_release = button_hotspot.on_release
				local on_pressed = button_hotspot.on_pressed
				local is_hover = button_hotspot.is_hover
				local on_hover_enter = button_hotspot.on_hover_enter

				if on_hover_enter then
					self.play_sound(self, "Play_hud_hover")
				end

				if is_hover then
					any_hovered = true
				end

				if on_pressed then
					self._select_entry_widget(self, widget)

					new_selection = true
					input_pressed = true
				end
			end
		end
	end

	if not new_selection then
		local log_widgets = self._log_widgets

		for _, widget in ipairs(log_widgets) do
			local content = widget.content
			local active = content.active
			local is_selected = content.button_hotspot.is_selected

			if active and not is_selected then
				local button_hotspot = content.button_hotspot
				local on_release = button_hotspot.on_release
				local on_pressed = button_hotspot.on_pressed
				local is_hover = button_hotspot.is_hover
				local on_hover_enter = button_hotspot.on_hover_enter

				if on_hover_enter then
					self.play_sound(self, "Play_hud_hover")
				end

				if is_hover then
					any_hovered = true
				end

				if on_pressed then
					self._select_entry_widget(self, widget)

					new_selection = true
					input_pressed = true
				end
			end
		end
	end

	local exit_pressed = self._handle_exit(self, input_service)

	if exit_pressed then
		self.play_sound(self, "Play_hud_select")
	end

	if not any_hovered and self._hovered_widget then
		self._select_entry_widget(self, self._selected_widget)
	end

	return 
end
QuestView._on_accept_pressed = function (self)
	local selected_contract_list_widget = self._selected_widget

	if selected_contract_list_widget then
		local widget_content = selected_contract_list_widget.content

		if widget_content.active then
			local data = selected_contract_list_widget.content.data
			local active_contract = data.active

			if active_contract then
				local id = data.id
				local data_type = data.type
				local is_quest = data.is_quest
				local requirements_met = data.requirements_met
				local expired = data.ttl <= 0

				if requirements_met then
					if is_quest then
						self._turn_in_quest(self, id)
					else
						local has_key = data_type == "main"

						if has_key then
							self._request_turn_in_contract(self, id)
						else
							self._turn_in_contract(self, id)
						end
					end
				elseif is_quest then
					self._request_decline_quest(self, id, expired)
				else
					self._request_decline_contract(self, id, expired)
				end

				return true
			else
				local id = data.id
				local is_quest = data.is_quest

				if is_quest then
					self._accept_quest(self, id)
				else
					self._accept_contract(self, id)
				end

				return true
			end
		end
	end

	return 
end
QuestView._is_button_pressed = function (self, widget)
	local button_hotspot = widget.content.button_hotspot

	if button_hotspot.on_release then
		button_hotspot.on_release = false

		return true
	end

	return 
end
QuestView._button_on_hover_enter = function (self, widget)
	local button_hotspot = widget.content.button_hotspot
	local on_hover_enter = button_hotspot.on_hover_enter

	if on_hover_enter then
		return true
	end

	return 
end
QuestView._is_cursor_over = function (self, widget)
	local button_hotspot = widget.content.button_hotspot

	if button_hotspot.cursor_hover then
		return true
	end

	return 
end
QuestView._refresh_quest_and_contracts = function (self)
	self.quest_manager:query_quests_and_contracts()
	self._deselect_selection_widget(self)

	return 
end
QuestView._terminate_all_popups = function (self)
	if self._decline_quest_popup_id then
		Managers.popup:cancel_popup(self._decline_quest_popup_id)

		self._decline_quest_popup_id = nil
	end

	if self._decline_contract_popup_id then
		Managers.popup:cancel_popup(self._decline_contract_popup_id)

		self._decline_contract_popup_id = nil
	end

	if self._turn_in_contract_popup_id then
		Managers.popup:cancel_popup(self._turn_in_contract_popup_id)

		self._turn_in_contract_popup_id = nil
	end

	return 
end
QuestView._sync_quests_and_contracts = function (self)
	self._terminate_all_popups(self)
	self._deselect_selection_widget(self)

	local quest_manager = self.quest_manager
	local quests = quest_manager.get_quests(quest_manager)
	local contracts = quest_manager.get_contracts(quest_manager)

	dprint("RESYNC ALL LISTS")
	self._clear_board(self)
	self._clear_log(self)

	local log_id_fill_list = {}
	local board_id_fill_list = {}

	self._set_number_of_progress_steps_for_active_quest(self, 0)
	self._set_quest_bar_progress(self, 0)

	local is_quests = true

	self._populate_board(self, quests, board_id_fill_list, is_quests)

	self._num_log_quests = self._populate_log(self, quests, log_id_fill_list, is_quests)
	is_quests = false

	self._populate_board(self, contracts, board_id_fill_list, is_quests)

	self._num_log_contracts = self._populate_log(self, contracts, log_id_fill_list, is_quests)
	self._stored_log_ids = log_id_fill_list
	self._stored_board_ids = board_id_fill_list

	return 
end
QuestView._poll_backend = function (self)
	local quest_manager = self.quest_manager
	local quests_and_contracts_dirty = quest_manager.is_quests_and_contracts_dirty(quest_manager)

	if quests_and_contracts_dirty then
		self._sync_quests_and_contracts(self)
	end

	if not self.reward_screen:active() then
		local reward = quest_manager.poll_reward(quest_manager)

		if reward then
			self._got_first_reward = true

			self._show_reward(self, reward)
		elseif not reward and self._got_first_reward then
			self._waiting_for_reward_presentation = nil
			self._got_first_reward = nil
		end
	end

	return 
end
QuestView._level_locked = function (self, level_key)
	local settings = LevelSettings[level_key]
	local dlc_name = settings.dlc_name

	if dlc_name then
		return Managers.unlock:is_dlc_unlocked(dlc_name)
	end

	return false
end
QuestView._assign_widget_data = function (self, widget, data)
	local content = widget.content
	local style = widget.style

	table.clear(content.button_hotspot)

	local id = data.id
	local data_type = data.type
	local active = data.active
	local rewards = data.rewards
	local boons = rewards.boons
	local tokens = rewards.tokens
	local items = rewards.items
	local is_quest = data.is_quest
	local requirements = data.requirements
	local requirements_met = data.requirements_met
	local task = requirements.task
	content.is_quest = is_quest
	content.completed = requirements_met

	if not is_quest then
		if not active then
			content.background_texture = "board_contract_bg_default"
		else
			content.background_texture = "log_contract_bg_default"
		end

		local has_key = data_type == "main"
		content.has_key = has_key

		if has_key then
			content.key_tooltip_text = Localize("dlc1_3_1_quest_key_title") .. "\n" .. Localize("dlc1_3_1_quest_key_description")
		end

		if task then
			local task_type = task.type
			local task_amount = task.amount
			local icon = QuestSettings.task_type_to_icon_lookup[task_type]
			content.task_texture = icon
			local amount_acquired = (task_amount and task_amount.acquired) or ""
			local amount_required = (task_amount and task_amount.required) or ""
			local amount_text = (task_amount and amount_acquired .. "/" .. amount_required) or ""
			content.task_text = amount_text
			local requirement_text = QuestSettings.task_type_requirement_text[task_type][1]
			content.title_text = requirement_text
			content.task_tooltip_text = Localize(requirement_text) .. "\n" .. amount_text
		end

		local level_key = requirements.level

		if level_key then
			local level_settings = LevelSettings[level_key]
			local map_settings = level_settings.map_settings
			local display_name = level_settings.display_name
			local level_icon = map_settings.icon
			content.level_texture = level_icon .. "_quest_screen"
			content.level_tooltip_text = Localize(display_name)
			local level_unlocked = LevelUnlockUtils.level_unlocked(self.statistics_db, self.player_stats_id, level_key)
			content.locked = not level_unlocked
		end

		local difficulty_key = requirements.difficulty

		if difficulty_key then
			local difficulty_settings = DifficultySettings[difficulty_key]
			local display_name = difficulty_settings.display_name
			local rank = difficulty_settings.rank
			style.difficulty_texture.draw_count = rank
			content.level_tooltip_text = content.level_tooltip_text .. "\n" .. Localize(display_name)
		end
	else
		local quest_title_text = self.quest_manager:get_title_for_quest_id(id)
		content.title_text = quest_title_text
	end

	if boons then
		local data_type = type(boons)
		local boon_key = nil

		if data_type == "string" then
			boon_key = boons
		elseif data_type == "table" and 0 < #boons then
			boon_key = boons[1]
		end

		local boon_template = boon_key and BoonTemplates[boon_key]
		local boon_icon = boon_template and boon_template.ui_icon
		content.has_boon = boon_icon ~= nil
		content.boon_reward_texture = boon_icon

		if boon_template then
			local duration = boon_template and self._get_readable_boon_duration(self, boon_template.duration)
			content.tooltip_text = Localize(boon_template.ui_name) .. " (" .. duration .. ")" .. "\n" .. Localize(boon_template.tooltip)
		end
	else
		content.has_boon = false
	end

	if items then
		local data_type = type(items)
		local item_key = nil

		if data_type == "string" then
			item_key = items
		elseif data_type == "table" and 0 < #boons then
			item_key = items[1]
		end

		local item = item_key and ItemMasterList[item_key]
		content.item_reward_texture = item and item.inventory_icon

		if item then
			local item_color = Colors.get_table(item.rarity)
			style.item_reward_frame_texture.color = item_color
			style.tooltip_text.line_colors[1] = item_color
			local item_name = Localize(item.display_name)
			local item_type_name = Localize(item.item_type)
			content.tooltip_text = item_name .. "\n" .. item_type_name
		end

		content.has_item = true
		local tooltip_text, tooltip_colors = self._get_item_tooltip(self, item_key, style.tooltip_text)
		content.tooltip_text = tooltip_text
		style.tooltip_text.line_colors = tooltip_colors
	else
		content.has_item = false
	end

	if tokens then
		local token_type = tokens.type
		local amount = tokens.amount
		local token_icon = QuestSettings.token_type_to_large_icon_lookup[token_type]
		local token_name = QuestSettings.token_name_by_type_lookup[token_type]
		content.has_tokens = token_icon ~= nil
		content.token_reward_texture = token_icon
		content.tooltip_text = Localize(token_name) .. "\n x" .. amount
	else
		content.has_tokens = false
	end

	content.data = data
	content.active = true

	return 
end
local default_reward_name_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
QuestView._present_data = function (self, data)
	local presentation_widgets = self._presentation_widgets
	local id = data.id
	local is_quest = data.is_quest
	local requirements = data.requirements
	local requirements_met = data.requirements_met
	local task = requirements.task
	self.ui_scenegraph.presentation_title.local_position[2] = (is_quest and -50) or 0

	if is_quest then
		self._set_presentation_background(self, "quest_paper_bg")

		local acquired = requirements.task.amount.acquired
		local required = requirements.task.amount.required
		local requirement_text = QuestSettings.task_type_requirement_text.quest[1]
		presentation_widgets.objective_counter.content.text = acquired .. "/" .. required .. " " .. Localize(requirement_text)
		local data_type = data.type
		local icon_texture = "contract_key_icon"
		local icon_texture_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(icon_texture)
		local icon_size = self.ui_scenegraph.presentation_objective_icon.size
		icon_size[1] = icon_texture_settings.size[1]
		icon_size[2] = icon_texture_settings.size[2]
		presentation_widgets.objective_icon.content.texture_id = icon_texture
		presentation_widgets.title.content.text = "dlc1_3_1_quest_title"
		local quest_title_text = self.quest_manager:get_title_for_quest_id(id)
		presentation_widgets.sub_title.content.text = quest_title_text
		local description_text = self.quest_manager:get_description_for_quest_id(id)
		presentation_widgets.text.content.text = Localize(description_text)
		presentation_widgets.difficulty.content.visible = false
		presentation_widgets.item_border_icon.content.texture_id = "quest_chest_icon"
		presentation_widgets.item_border_icon.content.visible = true
	else
		self._set_presentation_background(self, "contract_paper_bg")

		local difficulty_key = requirements.difficulty
		local difficulty_settings = DifficultySettings[difficulty_key]
		local difficulty_display_name = difficulty_settings.display_name
		local difficulty_display_text = string.format(Localize("dlc1_3_1_quests_difficulty_text"), Localize(difficulty_display_name))
		presentation_widgets.difficulty.content.visible = true
		presentation_widgets.difficulty.content.text = difficulty_display_text
		local description_text = self.quest_manager:get_description_for_contract_id(id)
		presentation_widgets.text.content.text = Localize(description_text)

		if task then
			local task_type = task.type
			local task_amount = task.amount
			local icon_texture = QuestSettings.task_type_to_icon_lookup[task_type]
			local icon_texture_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(icon_texture)
			local icon_size = self.ui_scenegraph.presentation_objective_icon.size
			icon_size[1] = icon_texture_settings.size[1]
			icon_size[2] = icon_texture_settings.size[2]
			presentation_widgets.objective_icon.content.texture_id = icon_texture
			local amount_acquired = (task_amount and task_amount.acquired) or ""
			local amount_required = (task_amount and task_amount.required) or ""
			local requirement_text = QuestSettings.task_type_requirement_text[task_type][1]
			local count_text = (task_amount and amount_acquired .. "/" .. amount_required .. " " .. Localize(requirement_text)) or ""
			presentation_widgets.objective_counter.content.text = count_text
			slot22 = QuestSettings.task_type_titles[task_type]
		end

		presentation_widgets.title.content.text = "dlc1_3_1_contract_title"
		presentation_widgets.item_border_icon.content.texture_id = "contract_key_icon"
		presentation_widgets.item_border_icon.content.visible = data.type == "main"
		local level_key = requirements.level

		if level_key then
			local display_name = LevelSettings[level_key].display_name
			presentation_widgets.sub_title.content.text = display_name
		end
	end

	local rewards = data.rewards
	local boons = rewards.boons
	local tokens = rewards.tokens
	local items = rewards.items

	if boons then
		local data_type = type(boons)
		local boon_key = nil

		if data_type == "string" then
			boon_key = boons
		elseif data_type == "table" and 0 < #boons then
			boon_key = boons[1]
		end

		local boon_template = boon_key and BoonTemplates[boon_key]
		local boon_icon = boon_template and boon_template.ui_icon

		if boon_template then
			local duration = self._get_readable_boon_duration(self, boon_template.duration)
			presentation_widgets.item_name.content.text = Localize(boon_template.ui_name) .. " (" .. duration .. ")"
			presentation_widgets.item_name.style.text.text_color = default_reward_name_color
			presentation_widgets.item_type_name.content.text = Localize(boon_template.tooltip)
		end

		presentation_widgets.boon.content.texture_id = boon_icon
		presentation_widgets.boon.content.visible = true
	else
		presentation_widgets.boon.content.visible = false
	end

	if items then
		local data_type = type(items)
		local item_key = nil

		if data_type == "string" then
			item_key = items
		elseif data_type == "table" and 0 < #boons then
			item_key = items[1]
		end

		local item = item_key and ItemMasterList[item_key]
		presentation_widgets.item.content.texture_id = item and item.inventory_icon

		if item then
			local item_color = Colors.get_table(item.rarity)
			presentation_widgets.item_frame.style.texture_id.color = item_color
			presentation_widgets.item_name.content.text = Localize(item.display_name)
			presentation_widgets.item_name.style.text.text_color = item_color
			presentation_widgets.item_type_name.content.text = Localize(item.item_type)

			self._set_traits_info(self, item, item.traits)

			local draw_hero_icon = (#item.can_wield == 1 and true) or false

			if draw_hero_icon then
				local key = item.can_wield[1]
				local hero_icon_texture = "quest_class_icon_" .. key
				local hero_icon_tooltip = UISettings.hero_tooltips[key]
				presentation_widgets.item_hero_tooltip.content.tooltip_text = Localize(hero_icon_tooltip)
				presentation_widgets.item_hero_icon.content.texture_id = hero_icon_texture
			end

			presentation_widgets.item_hero_icon.content.visible = draw_hero_icon
			presentation_widgets.item_hero_tooltip.content.visible = draw_hero_icon
		end

		presentation_widgets.item.content.visible = true
		presentation_widgets.item_frame.content.visible = true
		presentation_widgets.item_name.content.visible = true
		presentation_widgets.item_type_name.content.visible = true
	else
		presentation_widgets.item.content.visible = false
		presentation_widgets.item_frame.content.visible = false
		presentation_widgets.item_hero_tooltip.content.visible = false
		presentation_widgets.item_hero_icon.content.visible = false

		self._set_traits_info(self, nil, nil)
	end

	if tokens then
		local token_type = tokens.type
		local amount = tokens.amount
		local token_icon = QuestSettings.token_type_to_large_icon_lookup[token_type]
		local token_name = QuestSettings.token_name_by_type_lookup[token_type]
		presentation_widgets.token.content.texture_id = token_icon
		presentation_widgets.token.content.visible = true
		presentation_widgets.item_name.content.text = Localize(token_name)
		presentation_widgets.item_name.style.text.text_color = default_reward_name_color
		presentation_widgets.item_type_name.content.text = "x" .. amount
	else
		presentation_widgets.token.content.visible = false
	end

	presentation_widgets.completed.content.visible = false

	return 
end
QuestView._set_presentation_background = function (self, texture)
	local presentation_widgets = self._presentation_widgets
	local widget = presentation_widgets.background
	widget.content.texture_id = texture
	local texture_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(texture)
	local size = self.ui_scenegraph.presentation_bg.size
	size[1] = texture_settings.size[1]
	size[2] = texture_settings.size[2]

	return 
end
QuestView._set_traits_info = function (self, item, traits)
	local presentation_widgets = self._presentation_widgets
	local num_total_traits = ForgeSettings.num_traits
	local number_of_traits_on_item = 0
	local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local slot_type = item and item.slot_type
	local is_trinket = slot_type == "trinket"
	local trait_locked = not is_trinket and slot_type ~= "hat"

	for i = 1, num_total_traits, 1 do
		local trait_name = traits and traits[i]
		local trait_widget = presentation_widgets["trait_button_" .. i]
		local tooltip_trait_widget = presentation_widgets["trait_tooltip_" .. i]
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = trait_name == nil
		trait_widget_content.visible = false
		tooltip_trait_widget.content.visible = false

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local rarity = item.rarity
				local description_text = BackendUtils.get_trait_description(trait_name, rarity)
				local tooltip_text = Localize(display_name) .. "\n" .. description_text

				if is_trinket or trait_locked then
					if is_trinket then
						tooltip_text = tooltip_text .. "\n" .. tooltip_trait_unique_text
					else
						tooltip_text = tooltip_text .. "\n" .. tooltip_trait_locked_text
					end

					tooltip_trait_widget.style.tooltip_text.last_line_color = Colors.get_color_table_with_alpha("red", 255)
				else
					tooltip_trait_widget.style.tooltip_text.last_line_color = nil
				end

				tooltip_trait_widget.content.tooltip_text = tooltip_text
				tooltip_trait_widget.content.visible = true
				local icon = trait_template.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_hotspot.is_selected = false
				trait_widget_hotspot.on_pressed = false
				trait_widget_content.use_background = false
				trait_widget_content.use_glow = false
			end

			trait_widget_hotspot.locked = trait_locked
			number_of_traits_on_item = number_of_traits_on_item + 1
			trait_widget.content.visible = true
		end
	end

	self._numb_traits_on_item = number_of_traits_on_item

	return 
end
local tooltip_color_orange = Colors.get_color_table_with_alpha("cheeseburger", 255)
local tooltip_color_white = Colors.get_color_table_with_alpha("white", 255)
local tooltip_color_red = Colors.get_color_table_with_alpha("red", 255)
QuestView._get_item_tooltip = function (self, item_key, style)
	local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local item = ItemMasterList[item_key]
	local traits = item.traits
	local rarity = item.rarity
	local item_color = Colors.get_table(item.rarity)
	local slot_type = item and item.slot_type
	local is_trinket = slot_type == "trinket"
	local trait_locked = not is_trinket and slot_type ~= "hat"
	local tooltip_text = ""
	local tooltip_text_colors = {
		[#tooltip_text_colors + 1] = item_color,
		[#tooltip_text_colors + 1] = tooltip_color_white,
		[#tooltip_text_colors + 1] = tooltip_text_colors[#tooltip_text_colors]
	}
	local item_name = Localize(item.display_name)
	local item_type_name = Localize(item.item_type)
	tooltip_text = item_name .. "\n" .. item_type_name .. "\n"
	local draw_hero_icon = (#item.can_wield == 1 and true) or false

	if draw_hero_icon then
		local key = item.can_wield[1]
		local hero_icon_tooltip = UISettings.hero_tooltips[key]
		tooltip_text = tooltip_text .. Localize(hero_icon_tooltip) .. "\n"
		tooltip_text_colors[#tooltip_text_colors + 1] = tooltip_color_white
	end

	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local trait_name = traits and traits[i]

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local description_text = BackendUtils.get_trait_description(trait_name, rarity)
				local description_rows = self._get_number_of_rows(self, style, description_text)
				tooltip_text = tooltip_text .. "\n" .. Localize(display_name) .. "\n" .. description_text
				tooltip_text_colors[#tooltip_text_colors + 1] = tooltip_color_orange

				for k = 1, description_rows, 1 do
					tooltip_text_colors[#tooltip_text_colors + 1] = tooltip_color_white
				end

				if is_trinket or trait_locked then
					if is_trinket then
						tooltip_text = tooltip_text .. "\n" .. tooltip_trait_unique_text
					else
						tooltip_text = tooltip_text .. "\n" .. tooltip_trait_locked_text
					end

					tooltip_text_colors[#tooltip_text_colors + 1] = tooltip_color_red
				end

				tooltip_text = tooltip_text .. "\n"
				tooltip_text_colors[#tooltip_text_colors + 1] = tooltip_color_white
			end
		end
	end

	return tooltip_text, tooltip_text_colors
end
QuestView._get_readable_boon_duration = function (self, duration)
	local text = ""

	if duration and 0 < duration then
		local days = math.floor(duration/86400)
		local hours = math.floor(duration/3600)
		local minutes = math.floor(duration/60)
		local seconds = math.floor(duration)

		if 0 < days then
			text = tostring(days) .. "d"
		elseif 0 < hours then
			text = tostring(hours) .. "h"
		elseif 0 < minutes then
			text = tostring(minutes) .. "m"
		elseif 0 <= seconds then
			text = tostring(seconds) .. "s"
		end
	end

	return text
end
QuestView._clear_entry_widget = function (self, widget)
	local content = widget.content

	table.clear(content.button_hotspot)

	content.active = false
	content.data = nil

	return 
end
QuestView._accept_quest = function (self, quest_id)
	self._num_log_quests = self._num_log_quests + 1

	self.play_sound(self, "Play_hud_quest_menu_accept_big_quest")
	self.quest_manager:accept_quest_by_id(quest_id)
	self._deselect_selection_widget(self)

	return 
end
QuestView._request_decline_quest = function (self, quest_id, expired)
	if expired then
		self._decline_quest_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_discard_quest_warning_text"), Localize("dlc1_3_1_discard_quest_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
	else
		self._decline_quest_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_decline_quest_warning_text"), Localize("dlc1_3_1_decline_quest_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
	end

	return 
end
QuestView._decline_quest = function (self, quest_id)
	self.play_sound(self, "Play_hud_quest_menu_decline_quest")
	self.quest_manager:decline_quest_by_id(quest_id)
	self._deselect_selection_widget(self)

	return 
end
QuestView._turn_in_quest = function (self, quest_id)
	self.play_sound(self, "Play_hud_quest_menu_finish_quest_turn_in_stamp")
	self.quest_manager:complete_quest_by_id(quest_id)

	self._waiting_for_reward_presentation = true

	self._deselect_selection_widget(self)

	return 
end
QuestView._accept_contract = function (self, contract_id)
	self._num_log_contracts = self._num_log_contracts + 1

	self.play_sound(self, "Play_hud_quest_menu_accept_small_quest")
	self.quest_manager:accept_contract_by_id(contract_id)
	self._deselect_selection_widget(self)

	return 
end
QuestView._request_decline_contract = function (self, contract_id, expired)
	if expired then
		self._decline_contract_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_discard_contract_warning_text"), Localize("dlc1_3_1_discard_contract_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
	else
		self._decline_contract_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_decline_contract_warning_text"), Localize("dlc1_3_1_decline_contract_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
	end

	return 
end
QuestView._decline_contract = function (self, contract_id)
	self._num_log_contracts = self._num_log_contracts - 1

	self.play_sound(self, "Play_hud_quest_menu_decline_quest")
	self.quest_manager:decline_contract_by_id(contract_id)
	self._deselect_selection_widget(self)

	return 
end
QuestView._request_turn_in_contract = function (self, contract_id)
	local has_no_quest = not self._num_log_quests or self._num_log_quests == 0

	if has_no_quest then
		self._turn_in_contract_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_key_contract_warning_text"), Localize("dlc1_3_1_key_contract_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
	else
		self._turn_in_contract(self, contract_id)
	end

	return 
end
QuestView._turn_in_contract = function (self, contract_id)
	self.play_sound(self, "Play_hud_quest_menu_finish_quest_turn_in_stamp")
	self.quest_manager:complete_contract_by_id(contract_id)

	self._waiting_for_reward_presentation = true

	self._deselect_selection_widget(self)

	return 
end
QuestView._get_number_of_rows = function (self, text_style, text)
	local ui_renderer = self.ui_renderer
	local max_width = text_style.max_width
	local font, size_of_font = UIFontByResolution(text_style, nil)
	local font_material = font[1]
	local _ = font[2]
	local font_name = font[3]
	local font_size = size_of_font
	local font_height, font_min, font_max = UIGetFontHeight(ui_renderer.gui, font_name, font_size)
	local texts = UIRenderer.word_wrap(ui_renderer, text, font_material, font_size, max_width)

	return #texts
end
QuestView._populate_board = function (self, entries, id_fill_list, is_quest)
	local counter = 0
	local quest_manager = self.quest_manager
	local stored_board_ids = self._stored_board_ids

	for _, data in pairs(entries) do
		local id = data.id
		local expire_at = data.expire_at or 0
		local expired = quest_manager.has_time_expired(quest_manager, expire_at)
		local active = data.active
		local requirements_met = data.requirements_met
		local add_contract = not expired and not active and not requirements_met

		if add_contract then
			local new_entry = not stored_board_ids[id]
			local contract_type = data.type
			local list_index = (is_quest and 1) or contract_list_index_by_type[contract_type]
			local widget_index = (list_index == 3 and data.index - 2) or data.index
			local widget = self._get_inactive_board_widget(self, list_index, widget_index)

			if widget then
				id_fill_list[id] = true
				local widget_content = widget.content
				data.is_quest = is_quest

				self._assign_widget_data(self, widget, data)

				counter = counter + 1
			end
		end
	end

	return counter
end
QuestView._clear_board = function (self)
	local board_widgets = self._board_widgets

	for _, widget_list in ipairs(board_widgets) do
		for _, widget in ipairs(widget_list) do
			self._clear_entry_widget(self, widget)
		end
	end

	return 
end
QuestView._align_board_entries = function (self)
	local list_spacing = 18
	local widget_spacing = 11
	local target_index = 2
	local total_list_height = 0

	for list_index, widget_list in ipairs(self._board_widgets) do
		for widget_index, widget in ipairs(widget_list) do
			local scenegraph_id = widget.scenegraph_id
			local widget_parent_definition = scenegraph_definition[scenegraph_id]
			local size = widget_parent_definition.size
			local offset = widget.offset
			offset[target_index] = total_list_height
			local target_offset = size[target_index]
			total_list_height = total_list_height - (target_offset + widget_spacing)
		end

		if list_index == 1 then
			list_spacing = 38
			widget_spacing = 21
		else
			list_spacing = 0
		end

		total_list_height = total_list_height - list_spacing
	end

	return 
end
QuestView._show_entry_marked = function (self, widget)
	self._draw_progress_button = nil

	if widget then
		local content = widget.content
		local button_hotspot = content.button_hotspot
		local data = content.data

		self._present_data(self, data)

		local active = data.active
		local is_quest = data.is_quest
		local requirements_met = data.requirements_met
		local button_text = nil
		local button_disabled = true

		if active then
			if requirements_met then
				button_text = button_texts.turn_in
			else
				button_text = button_texts.decline
			end

			button_disabled = false
		else
			button_text = button_texts.accept

			if is_quest then
				if self._num_log_quests < QuestSettings.MAX_NUMBER_OF_LOG_QUESTS then
					button_disabled = false
				end
			else
				if self._num_log_contracts < QuestSettings.MAX_NUMBER_OF_LOG_CONTRACTS then
					button_disabled = false
				end

				if self._selected_widget and self._selected_widget.content.locked then
					button_disabled = true
				end
			end

			button_text = button_texts.accept
		end

		self._accept_button_widget.content.text_field = button_text
		input_actions.selection[2].description_text = button_text
		self.gamepad_active_actions_name = nil
		self._accept_button_widget.content.button_hotspot.disabled = button_disabled
		self._accept_input_blocked = button_disabled
		self._draw_progress_button = active
	end

	return 
end
QuestView._select_entry_widget = function (self, widget)
	if self._selected_widget then
		local prev_selection_widget = self._selected_widget
		local content = prev_selection_widget.content
		local button_hotspot = content.button_hotspot
		button_hotspot.is_selected = false

		self._deselect_selection_widget(self)
	end

	self._selected_widget = widget

	self._show_entry_marked(self, widget)

	if widget then
		local content = widget.content
		local button_hotspot = content.button_hotspot
		button_hotspot.is_selected = true

		if not self._hovered_widget or widget.content.data.id ~= self._hovered_widget.content.data.id then
			self._fade_in_presentation_widgets(self)
		end

		self.play_sound(self, "Play_hud_quest_menu_select_quest")
	end

	self._hovered_widget = nil

	return 
end
QuestView._deselect_selection_widget = function (self)
	if self._selected_widget then
		self._selected_widget.content.gamepad_preview = false
		self._selected_widget = nil
	end

	return 
end
QuestView._hover_entry_widget = function (self, widget)
	self._show_entry_marked(self, widget)

	self._hovered_widget = widget

	self._fade_in_presentation_widgets(self)

	return 
end
QuestView._get_inactive_board_widget = function (self, list_index, specific_index)
	local board_widgets = self._board_widgets
	local widget_list = board_widgets[list_index]

	for widget_index, widget in ipairs(widget_list) do
		local widget_content = widget.content

		if specific_index then
			if widget_index == specific_index then
				return widget
			end
		elseif not widget_content.active then
			return widget
		end
	end

	return 
end
QuestView._populate_log = function (self, entries, id_fill_list, is_quest)
	local stored_log_ids = self._stored_log_ids
	local counter = 0

	for _, data in pairs(entries) do
		local id = data.id
		local active = data.active

		if active then
			local new_entry = stored_log_ids[id] == nil

			if not new_entry then
				local widget_index = stored_log_ids[id]
				local widget = self._get_inactive_log_widget(self, widget_index)

				if widget then
					id_fill_list[id] = widget_index
					data.is_quest = is_quest

					self._assign_widget_data(self, widget, data)

					counter = counter + 1

					dprint("added to log:", id, new_entry, widget_index)

					if is_quest then
						local requirements = data.requirements
						local requirements_met = data.requirements_met
						local acquired = requirements.task.amount.acquired
						local required = requirements.task.amount.required

						self._set_number_of_progress_steps_for_active_quest(self, required - 1)

						local progress = acquired/required

						self._set_quest_bar_progress(self, progress)
					end
				end
			end
		end
	end

	for _, data in pairs(entries) do
		local id = data.id
		local active = data.active

		if active then
			local new_entry = stored_log_ids[id] == nil

			if new_entry then
				local widget, widget_index = self._get_inactive_log_widget(self, is_quest and 1)

				if widget then
					id_fill_list[id] = widget_index
					data.is_quest = is_quest

					self._assign_widget_data(self, widget, data)

					counter = counter + 1

					dprint("added to log:", id, new_entry, widget_index)
				end

				if is_quest then
					local requirements = data.requirements
					local requirements_met = data.requirements_met
					local acquired = requirements.task.amount.acquired
					local required = requirements.task.amount.required

					self._set_number_of_progress_steps_for_active_quest(self, required - 1)

					local progress = acquired/required

					self._set_quest_bar_progress(self, progress)
				end
			end
		end
	end

	return counter
end
QuestView._clear_log = function (self)
	local log_widgets = self._log_widgets

	for _, widget in ipairs(log_widgets) do
		self._clear_entry_widget(self, widget)
	end

	return 
end
QuestView._align_log_entries = function (self)
	local first_widget_spacing = 140
	local widget_spacing = 63
	local target_index = 2
	local total_list_height = 0

	for widget_index, widget in ipairs(self._log_widgets) do
		local scenegraph_id = widget.scenegraph_id
		local widget_parent_definition = scenegraph_definition[scenegraph_id]
		local size = widget_parent_definition.size
		local offset = widget.offset
		offset[target_index] = total_list_height
		local target_offset = size[target_index]
		local spacing = (widget_index == 1 and first_widget_spacing) or widget_spacing
		total_list_height = total_list_height - (target_offset + spacing)
	end

	return 
end
QuestView._get_inactive_log_widget = function (self, specific_index)
	local widget_list = self._log_widgets

	for widget_index, widget in ipairs(widget_list) do
		local widget_content = widget.content

		if specific_index then
			if widget_index == specific_index then
				return widget, widget_index
			end
		elseif 1 < widget_index and not widget_content.active then
			return widget, widget_index
		end
	end

	return 
end
QuestView._rotate_loading_icon = function (self, dt)
	local widgets = self._loading_widgets
	local loading_icon_style = widgets.icon.style.texture_id
	local angle_fraction = loading_icon_style.fraction or 0
	angle_fraction = (angle_fraction + dt)%1
	local anim_fraction = math.easeOutCubic(angle_fraction)
	local angle = anim_fraction*math.degrees_to_radians(360)
	loading_icon_style.angle = angle
	loading_icon_style.fraction = angle_fraction

	return 
end
QuestView._loading_overlay_fade_in = function (self, alpha)
	local widgets = self._loading_widgets
	local widget = widgets.icon
	local style = widget.style
	local color = style.texture_id.color
	local animation = UIAnimation.init(UIAnimation.function_by_time, color, 1, color[1], 255, 0.3, math.easeOutCubic)

	table.clear(widget.animations)

	widget.animations[animation] = true

	table.clear(widgets.overlay.animations)

	widgets.overlay.style.rect.color[1] = alpha

	self._animate_loading_text(self)

	return 
end
QuestView._loading_overlay_fade_out = function (self)
	local function fade(widget, color)
		local animation = UIAnimation.init(UIAnimation.function_by_time, color, 1, color[1], 0, 0.3, math.easeOutCubic)

		table.clear(widget.animations)

		widget.animations[animation] = true

		return 
	end

	local widgets = self._loading_widgets

	fade(widgets.overlay, widgets.overlay.style.rect.color)
	fade(widgets.icon, widgets.icon.style.texture_id.color)
	fade(widgets.text, widgets.text.style.text.text_color)

	return 
end
QuestView._animate_loading_text = function (self)
	local widgets = self._loading_widgets
	local widget = widgets.text
	local style = widget.style
	local color = style.text.text_color

	if color[1] ~= 255 then
		local animation = UIAnimation.init(UIAnimation.function_by_time, color, 1, color[1], 255, 0.3, math.easeOutCubic, UIAnimation.wait, QuestSettings.PREPARE_MENU_FOR_SYNC_DURATION, UIAnimation.function_by_time, color, 1, 255, 0, 0.3, math.easeOutCubic)

		table.clear(widget.animations)

		widget.animations[animation] = true
	end

	return 
end
QuestView._set_number_of_progress_steps_for_active_quest = function (self, amount)
	local widgets = self._quest_bar_widgets
	widgets.bar_dots.style.texture_id.texture_amount = amount
	widgets.bar_dot_slots.style.texture_id.texture_amount = amount
	widgets.bar_slots_dots.style.texture_id.texture_amount = amount

	return 
end
QuestView._set_quest_bar_progress = function (self, progress)
	local ui_scenegraph = self.ui_scenegraph
	local widgets = self._quest_bar_widgets
	local bar_widget = widgets.bar
	local dots_widget = widgets.bar_dots
	local bar_scenegraph_id = bar_widget.scenegraph_id
	local bar_size = ui_scenegraph[bar_scenegraph_id].size
	local bar_size_default = scenegraph_definition[bar_scenegraph_id].size
	local bar_uvs = bar_widget.content.texture_id.uvs
	bar_uvs[2][1] = progress
	bar_size[1] = bar_size_default[1]*progress
	local dots_uvs = dots_widget.style.texture_id.texture_uvs
	local dots_sizes = dots_widget.style.texture_id.texture_sizes
	local default_texture_size = dots_widget.style.texture_id.texture_size
	local dots_amount = dots_widget.style.texture_id.texture_amount
	local total_steps = dots_amount + 1
	local progress_per_dot = total_steps/1
	local dot_size_fraction = default_texture_size[1]/bar_size_default[1]

	for i = 1, dots_amount, 1 do
		local progress_required = progress_per_dot*i - dot_size_fraction*0.5
		local dot_progress = (progress - progress_required)/dot_size_fraction
		dot_progress = math.clamp(dot_progress*2, 0, 1)
		local uvs = dots_uvs[i]
		local size = dots_sizes[i]
		size[1] = default_texture_size[1]*dot_progress
		uvs[2][1] = dot_progress
	end

	return 
end

local function animate_widget_style_alpha(widget, target)
	local anim_time = 0.25
	local target_index = 1
	local from = 0
	local to = 255
	local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, math.easeCubic)

	UIWidget.animate(widget, animation)

	return 
end

QuestView._fade_in_presentation_widgets = function (self)
	local widgets = self._presentation_widgets

	for _, widget in pairs(widgets) do
		local style = widget.style
		local target_style = style.texture_id or style.text

		if target_style then
			table.clear(widget.animations)

			local target = (style.text and target_style.text_color) or target_style.color

			animate_widget_style_alpha(widget, target)
		end

		if style.texture_lock_id then
			local target = style.texture_lock_id.color

			animate_widget_style_alpha(widget, target)
		end
	end

	return 
end

return 
