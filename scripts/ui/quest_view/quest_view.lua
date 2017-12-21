local definitions = local_require("scripts/ui/quest_view/quest_view_definitions")

require("scripts/settings/equipment/item_master_list")
require("scripts/settings/quest_settings")
require("scripts/managers/backend/backend_utils")
require("scripts/ui/reward_ui/reward_popup_handler")
require("scripts/ui/quest_view/quest_reward_presentation_ui")

local function dprint(...)
	if false then
		print("[QuestView]", ...)
	end

	return 
end

local debug_draw_scenegraph = false
local get_atlas_settings_by_texture_name = UIAtlasHelper.get_atlas_settings_by_texture_name
local create_popup_quest = definitions.create_popup_quest
local create_log_quest = definitions.create_log_quest
local create_board_quest = definitions.create_board_quest
local create_popup_contract = definitions.create_popup_contract
local create_board_contract = definitions.create_board_contract
local create_log_contract = definitions.create_log_contract
local background_settings = definitions.background_settings
QuestView = class(QuestView)
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
local QuestSettings = QuestSettings
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
	default_dlc = {
		{
			input_action = "l1_r1",
			priority = 1,
			description_text = "input_description_switch_board",
			ignore_keybinding = true
		},
		{
			input_action = "back",
			priority = 50,
			description_text = "input_description_back"
		}
	},
	selection = {
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
	selection_dlc = {
		{
			input_action = "l1_r1",
			priority = 1,
			description_text = "input_description_switch_board",
			ignore_keybinding = true
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
	popup_turn_in = {
		{
			input_action = "confirm",
			priority = 49,
			description_text = "dlc1_3_1_turn_in"
		},
		{
			input_action = "back",
			priority = 50,
			description_text = "input_description_close"
		}
	},
	popup_decline = {
		{
			input_action = "confirm",
			priority = 49,
			description_text = "dlc1_3_1_decline"
		},
		{
			input_action = "back",
			priority = 50,
			description_text = "input_description_close"
		}
	},
	popup_accept = {
		{
			input_action = "confirm",
			priority = 49,
			description_text = "dlc1_3_1_accept"
		},
		{
			input_action = "back",
			priority = 50,
			description_text = "input_description_close"
		}
	},
	popup_full = {
		{
			input_action = "back",
			priority = 50,
			description_text = "input_description_close"
		}
	}
}
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
	self.reward_screen = QuestRewardPresentationUI:new(ingame_ui_context)
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager.create_input_service(input_manager, "quest_view", IngameMenuKeymaps)
	input_manager.map_device_to_service(input_manager, "quest_view", "keyboard")
	input_manager.map_device_to_service(input_manager, "quest_view", "mouse")
	input_manager.map_device_to_service(input_manager, "quest_view", "gamepad")
	rawset(_G, "global_quest_view", self)

	self.ui_animations = {}
	self._board_contract_widgets = {}
	self._board_quest_widgets = {}
	self._log_contract_widgets = {}
	self._log_quest_widgets = {}
	self.num_active_contracts = 0
	self.num_active_quests = 0
	self._page_index = 1

	self._set_num_pages_available(self)
	self.create_ui_elements(self)

	self.ingame_ui_context = ingame_ui_context
	local input_service = self.input_manager:get_service("quest_view")
	local number_of_actvie_descriptions = 8
	local gui_layer = UILayer.default + 35
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, number_of_actvie_descriptions, gui_layer, generic_input_actions)

	self.menu_input_description:set_input_description(nil)

	return 
end
QuestView._setup_gamepad_grid = function (self)
	self.gamepad_input_pressed = {}
	local get_grid_data = local_require("scripts/ui/quest_view/quest_view_gamepad_grid_layout")
	self.gamepad_grid_data = get_grid_data(self)

	return 
end
QuestView.input_service = function (self)
	return self.input_manager:get_service("quest_view")
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
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.widgets_definitions) do
		self.widgets_by_name[widget_name] = UIWidget.init(widget_definition)
	end

	self.gamepad_selection_widgets = {}

	for widget_name, widget_definition in pairs(definitions.gamepad_widget_definitions) do
		self.gamepad_selection_widgets[widget_name] = UIWidget.init(widget_definition)
	end

	self.detail_popup_widgets = {}

	for widget_name, widget_definition in pairs(definitions.detail_popup_widgets_definitions) do
		self.detail_popup_widgets[widget_name] = UIWidget.init(widget_definition)
	end

	self.detail_popup_widgets.detail_popup_decline_button.content.visible = false
	self.detail_popup_widgets.detail_popup_turn_in_button.content.visible = false
	self.detail_popup_widgets.detail_popup_accept_tooltip.content.visible = false
	self.reward_popup_widgets = {}

	for widget_name, widget_definition in pairs(definitions.reward_popup_widgets_definitions) do
		self.reward_popup_widgets[widget_name] = UIWidget.init(widget_definition)
	end

	self.reward_popup_widgets.reward_continue_button.content.visible = false
	self.completion_text_widgets = {}

	for widget_name, widget_definition in pairs(definitions.completion_text_widget_definitions) do
		self.completion_text_widgets[widget_name] = UIWidget.init(widget_definition)
	end

	self.trait_icon_widgets = {
		UIWidget.init(definitions.item_reward_button_definitions.trait_button_1),
		UIWidget.init(definitions.item_reward_button_definitions.trait_button_2),
		UIWidget.init(definitions.item_reward_button_definitions.trait_button_3),
		UIWidget.init(definitions.item_reward_button_definitions.trait_button_4)
	}
	self.tooltip_widgets = {
		UIWidget.init(definitions.item_reward_button_definitions.trait_tooltip_1),
		UIWidget.init(definitions.item_reward_button_definitions.trait_tooltip_2),
		UIWidget.init(definitions.item_reward_button_definitions.trait_tooltip_3),
		UIWidget.init(definitions.item_reward_button_definitions.trait_tooltip_4)
	}
	self.hero_icon_tooltip = UIWidget.init(definitions.item_reward_button_definitions.hero_icon_tooltip)
	self.board_title_text_widget = self.widgets_by_name.board_title_widget
	self.exit_button_widget = self.widgets_by_name.exit_button_widget
	self.previous_page_button_widget = self.widgets_by_name.previous_page_button_widget
	self.next_page_button_widget = self.widgets_by_name.next_page_button_widget
	self.previous_page_button_widget.content.visible = self._has_dlc
	self.next_page_button_widget.content.visible = self._has_dlc

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, definitions.animations)
	self.description_text_widgets = {
		description_background = UIWidget.init(definitions.description_text_widgets.description_background),
		title = UIWidget.init(definitions.description_text_widgets.description_title),
		description = UIWidget.init(definitions.description_text_widgets.description_text),
		input_description_text = UIWidget.init(definitions.description_text_widgets.input_description_text)
	}

	self._create_quest_board(self)
	self._create_quest_log(self)
	self._create_contract_board(self)
	self._create_contract_log(self)
	self._create_popup_quest_widget(self)
	self._create_popups_for_background_textures(self)
	self._update_board_and_log(self)
	self._setup_gamepad_grid(self)

	return 
end
QuestView._create_popup_quest_widget = function (self)
	local scenegraph_id = "detail_popup_bg_fade"
	local widget_definition = create_popup_quest(scenegraph_id)
	local widget = UIWidget.init(widget_definition)
	widget.content.button_hotspot.disabled = true
	self.quest_popup_widget = widget

	return 
end
QuestView._create_popups_for_background_textures = function (self)
	local popup_widgets = {}
	local scenegraph_id = "detail_popup_bg_fade"

	for background_texture_name, background_texture_settings in pairs(background_settings) do
		popup_widgets[background_texture_name] = self._create_popup_contract_popup_widget(self, scenegraph_id, background_texture_name, background_texture_settings)
	end

	self.popup_widgets = popup_widgets

	return 
end
QuestView._create_popup_contract_popup_widget = function (self, parent_scenegraph_id, background_texture, settings)
	local background_texture_settings = background_settings[background_texture]
	local widget_definition = create_popup_contract(parent_scenegraph_id, background_texture, {})
	local widget = UIWidget.init(widget_definition)
	widget.content.button_hotspot.disabled = true

	return widget
end
QuestView._set_num_pages_available = function (self)
	local num_pages = 1

	if Managers.unlock:is_dlc_unlocked("drachenfels") then
		num_pages = num_pages + 1
	end

	self._num_pages = num_pages
	self._has_dlc = 1 < num_pages

	return 
end
QuestView.on_enter = function (self)
	local input_manager = self.input_manager

	input_manager.block_device_except_service(input_manager, "quest_view", "keyboard", 1)
	input_manager.block_device_except_service(input_manager, "quest_view", "mouse", 1)
	input_manager.block_device_except_service(input_manager, "quest_view", "gamepad", 1)
	self._set_num_pages_available(self)

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)
	self.reward_screen:on_enter()
	table.clear(self.gamepad_input_pressed)
	self.quest_manager:query_expire_times()
	self.quest_manager:query_quests_and_contracts()
	self.play_sound(self, "Play_hud_quest_menu_open")

	self.active = true

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

	if self.decline_quest_popup_id then
		Managers.popup:cancel_popup(self.decline_quest_popup_id)

		self.decline_quest_popup_id = nil
	end

	if self.decline_contract_popup_id then
		Managers.popup:cancel_popup(self.decline_contract_popup_id)

		self.decline_contract_popup_id = nil
	end

	if self.accept_expired_quest_popup_id then
		Managers.popup:cancel_popup(self.accept_expired_quest_popup_id)

		self.accept_expired_quest_popup_id = nil
	end

	if self.accept_expired_contract_popup_id then
		Managers.popup:cancel_popup(self.accept_expired_contract_popup_id)

		self.accept_expired_contract_popup_id = nil
	end

	if self.new_contracts_available_popup_id then
		Managers.popup:cancel_popup(self.new_contracts_available_popup_id)

		self.new_contracts_available_popup_id = nil
	end

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	self.reward_screen:exit()

	return 
end
QuestView.exit = function (self, return_to_game)
	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)
	self.play_sound(self, "Play_hud_button_close")

	self.exiting = true

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
QuestView._has_intro_been_shown = function (self)
	if self.draw_intro_description == nil then
		local player_data = PlayerData
		local quest_data = player_data.quest_data or {}
		local intro_been_shown = quest_data.intro_been_shown or false
		self.draw_intro_description = not intro_been_shown
	end

	return self.draw_intro_description
end
QuestView._set_intro_has_been_shown = function (self)
	self.draw_intro_description = false
	local player_data = PlayerData
	local quest_data = player_data.quest_data or {}
	quest_data.intro_been_shown = true
	player_data.quest_data = quest_data

	Managers.save:auto_save(SaveFileName, SaveData)

	return 
end
QuestView.hide_popup_buttons = function (self, hide_buttons)
	local detail_popup_widgets = self.detail_popup_widgets
	local detail_popup_accept_button = detail_popup_widgets.detail_popup_accept_button
	local detail_popup_close_button = detail_popup_widgets.detail_popup_close_button
	local detail_popup_decline_button = detail_popup_widgets.detail_popup_decline_button
	local detail_popup_turn_in_button = detail_popup_widgets.detail_popup_turn_in_button
	detail_popup_decline_button.content.visible = not hide_buttons
	detail_popup_turn_in_button.content.visible = not hide_buttons
	detail_popup_accept_button.content.visible = not hide_buttons
	detail_popup_close_button.content.visible = not hide_buttons

	return 
end
QuestView.update = function (self, dt)
	return 
end
QuestView.post_update = function (self, dt, t)
	if self.suspended then
		return 
	end

	local input_manager = self.input_manager
	local input_service = self.menu_input_service(self)
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

	local draw_intro_description = self._has_intro_been_shown(self)

	if draw_intro_description then
		self.set_input_blocked(self, true)

		local description_text_widgets = self.description_text_widgets
		description_text_widgets.input_description_text.content.text = (gamepad_active and "press_any_button_to_continue") or "press_any_key_to_continue"
		input_service = fake_input_service

		if input_manager.any_input_pressed(input_manager) then
			self._set_intro_has_been_shown(self)
			self.set_input_blocked(self, nil)

			return 
		end
	end

	if not self.active then
		return 
	end

	if not transitioning then
		if gamepad_active then
			if not self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = true

				self.on_gamepad_activated(self)
			end

			if not reward_screen_active then
				self.handle_gamepad_input(self, dt)
			end
		elseif self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = false

			self.on_gamepad_deactivated(self)
		end

		if self.draw_detailed_popup then
			local detail_popup_widgets = self.detail_popup_widgets
			local detail_popup_accept_button = detail_popup_widgets.detail_popup_accept_button
			local detail_popup_close_button = detail_popup_widgets.detail_popup_close_button
			local detail_popup_decline_button = detail_popup_widgets.detail_popup_decline_button
			local detail_popup_turn_in_button = detail_popup_widgets.detail_popup_turn_in_button
			local decline_visible = detail_popup_decline_button.content.visible ~= false
			local turn_in_visible = detail_popup_turn_in_button.content.visible ~= false
			local accept_visible = detail_popup_accept_button.content.visible ~= false
			local close_visible = detail_popup_close_button.content.visible ~= false
			local decline_button_hotspot = detail_popup_decline_button.content.button_hotspot
			local turn_in_button_hotspot = detail_popup_turn_in_button.content.button_hotspot
			local accept_button_hotspot = detail_popup_accept_button.content.button_hotspot
			local close_button_hotspot = detail_popup_close_button.content.button_hotspot
			local accept_button_hotspot_enabled = accept_button_hotspot.disabled ~= true

			if decline_button_hotspot.on_hover_enter or turn_in_button_hotspot.on_hover_enter or accept_button_hotspot.on_hover_enter or close_button_hotspot.on_hover_enter then
				self.play_sound(self, "Play_hud_hover")
			end

			local escape_pressed = input_manager.get_service(input_manager, "quest_view"):get("toggle_menu")

			if accept_visible and accept_button_hotspot_enabled and (accept_button_hotspot.on_release or gamepad_input_pressed.confirm) then
				accept_button_hotspot.on_release = nil
				local active_popup_widget = self.active_popup_widget
				local quest_id = active_popup_widget.content.quest_id
				local contract_id = active_popup_widget.content.contract_id
				local expire_at = active_popup_widget.content.expire_at or 0
				local expired = self.quest_manager:has_time_expired(expire_at)

				if quest_id then
					if expired and self.accept_expired_quest_popup_id == nil then
						self.accept_expired_quest_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_accept_expired_quest_error_text"), Localize("dlc1_3_1_accept_expired_quest_error_title"), "ok", Localize("popup_choice_ok"))

						self.close_detailed_popup(self)

						self._suspend_polling = true
						self._popup_active = true
					else
						self._accept_quest(self, quest_id)
					end
				elseif expired and self.accept_expired_contract_popup_id == nil then
					self.accept_expired_contract_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_accept_expired_contract_error_text"), Localize("dlc1_3_1_accept_expired_contract_error_title"), "ok", Localize("popup_choice_ok"))

					self.close_detailed_popup(self)

					self._suspend_polling = true
					self._popup_active = true
				else
					self._accept_contract(self, contract_id)
				end
			elseif decline_visible and (decline_button_hotspot.on_release or gamepad_input_pressed.confirm) then
				decline_button_hotspot.on_release = nil
				local active_popup_widget = self.active_popup_widget
				local quest_id = active_popup_widget.content.quest_id
				local contract_id = active_popup_widget.content.contract_id
				local expire_at = active_popup_widget.content.expire_at or 0
				local expired = self.quest_manager:has_time_expired(expire_at)

				if quest_id then
					local has_progress = self.quest_manager:has_quest_progressed(quest_id)

					if expired and self.decline_quest_popup_id == nil then
						self.decline_quest_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_discard_quest_warning_text"), Localize("dlc1_3_1_discard_quest_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
						self._suspend_polling = true
						self._popup_active = true
					elseif has_progress and self.decline_quest_popup_id == nil then
						self.decline_quest_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_decline_quest_warning_text"), Localize("dlc1_3_1_decline_quest_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
						self._suspend_polling = true
						self._popup_active = true
					elseif not has_progress then
						self._decline_quest(self, quest_id)
					end
				else
					local has_progress = self.quest_manager:has_contract_progressed(contract_id)

					if expired and self.decline_contract_popup_id == nil then
						self.decline_contract_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_discard_contract_warning_text"), Localize("dlc1_3_1_discard_contract_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
						self._suspend_polling = true
						self._popup_active = true
					elseif has_progress and self.decline_contract_popup_id == nil then
						self.decline_contract_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_decline_contract_warning_text"), Localize("dlc1_3_1_decline_contract_warning_title"), "yes", Localize("popup_choice_yes"), "no", Localize("popup_choice_no"))
						self._suspend_polling = true
						self._popup_active = true
					elseif not has_progress then
						self._decline_contract(self, contract_id)
					end
				end
			elseif turn_in_visible and (turn_in_button_hotspot.on_release or gamepad_input_pressed.confirm) then
				turn_in_button_hotspot.on_release = nil
				local active_popup_widget = self.active_popup_widget
				local quest_id = active_popup_widget.content.quest_id
				local contract_id = active_popup_widget.content.contract_id

				if quest_id then
					self._turn_in_quest(self, quest_id)
				else
					self._turn_in_contract(self, contract_id)
				end
			elseif close_visible and (close_button_hotspot.on_release or escape_pressed or gamepad_input_pressed.back) then
				close_button_hotspot.on_release = nil

				self.close_detailed_popup(self)
				self.play_sound(self, "Play_hud_quest_menu_close_quest")
			end
		else
			if self._expire_times and not self.new_contracts_available_popup_id and not self._queried_quests_and_contracts then
				local quests_expire_at = self._expire_times.quests_expire_at
				local contracts_expire_at = self._expire_times.contracts_expire_at
				local quests_expired = self.quest_manager:has_time_expired(quests_expire_at)
				local contracts_expired = self.quest_manager:has_time_expired(contracts_expire_at)

				if quests_expired then
					self.new_contracts_available_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_new_quests_and_contracts_available_text"), Localize("popup_notice_topic"), "ok", Localize("popup_choice_ok"))

					self.quest_manager:query_expire_times()
					self.quest_manager:query_quests_and_contracts()

					self._suspend_polling = true
					self._popup_active = true
				elseif contracts_expired then
					self.new_contracts_available_popup_id = Managers.popup:queue_popup(Localize("dlc1_3_1_new_contracts_available_text"), Localize("popup_notice_topic"), "ok", Localize("popup_choice_ok"))

					self.quest_manager:query_expire_times()
					self.quest_manager:query_quests_and_contracts()

					self._suspend_polling = true
					self._popup_active = true
				end
			end

			self._handle_exit(self, input_service)
			self._handle_page_navigation(self, input_service)
			self._handle_log_contract_input(self)
			self._handle_log_quest_input(self)
			self._handle_board_contract_input(self)
			self._handle_board_quest_input(self)
		end

		self._poll_backend(self)
		self._update_popups(self)
	end

	if self.active then
		self.draw(self, dt, input_service)
	end

	return 
end
QuestView._get_next_expire_time = function (self)
	local board_contract_widgets = self._board_contract_widgets

	for page_index, widget_tabe in pairs(board_contract_widgets) do
		for _, widget in ipairs(board_contract_widgets[page_index]) do
			local widget_content = widget.content

			if widget_content.expire_at then
				return widget_content.expire_at
			end
		end
	end

	return 
end
QuestView._accept_quest = function (self, quest_id)
	self.play_sound(self, "Play_hud_quest_menu_accept_big_quest")
	self.quest_manager:accept_quest_by_id(quest_id)

	self._suspend_polling = true
	self.gamepad_selected_widget = nil

	self.set_input_blocked(self, true)
	self.hide_popup_buttons(self, true)
	self.fade_out_popup_quest(self)
	self.move_popup_quest_to_log(self)
	self.fade_out_board_quest(self, quest_id)

	self._quest_fade_data = {
		id = quest_id,
		fade_function = self.fade_in_log_quest,
		flash_function = self.flash_log_quest
	}

	return 
end
QuestView._accept_contract = function (self, contract_id)
	self.play_sound(self, "Play_hud_quest_menu_accept_small_quest")
	self.quest_manager:accept_contract_by_id(contract_id)

	self._suspend_polling = true
	self.gamepad_selected_widget = nil

	self.set_input_blocked(self, true)
	self.hide_popup_buttons(self, true)
	self.fade_out_popup_contract(self, contract_id)
	self.move_popup_contract_to_log(self, contract_id)
	self.fade_out_board_contract(self, contract_id)

	self._contract_fade_data = {
		id = contract_id,
		fade_function = self.fade_in_log_contract,
		flash_function = self.flash_log_contract
	}

	return 
end
QuestView._decline_quest = function (self, quest_id)
	self.play_sound(self, "Play_hud_quest_menu_decline_quest")
	self.quest_manager:decline_quest_by_id(quest_id)

	self._suspend_polling = true
	self.gamepad_selected_widget = nil

	self.set_input_blocked(self, true)
	self.hide_popup_buttons(self, true)
	self.fade_out_log_quest(self, quest_id)

	if self._quest_exists_on_board(self, quest_id) then
		self.fade_out_popup_quest(self)
		self.move_popup_quest_to_board(self, quest_id)

		self._quest_fade_data = {
			id = quest_id,
			fade_function = self.fade_in_board_quest,
			flash_function = self.flash_board_quest
		}
	else
		self.fade_out_popup_quest(self, true)

		self._quest_fade_data = {
			id = quest_id,
			fade_function = self._hide_log_quest
		}
	end

	return 
end
QuestView._decline_contract = function (self, contract_id)
	self.play_sound(self, "Play_hud_quest_menu_decline_quest")
	self.quest_manager:decline_contract_by_id(contract_id)

	self._suspend_polling = true
	self.gamepad_selected_widget = nil

	self.set_input_blocked(self, true)
	self.hide_popup_buttons(self, true)
	self.fade_out_log_contract(self, contract_id)

	if self._contract_exists_on_board(self, contract_id) then
		self.fade_out_popup_contract(self, contract_id)
		self.move_popup_contract_to_board(self, contract_id)

		self._contract_fade_data = {
			id = contract_id,
			fade_function = self.fade_in_board_contract,
			flash_function = self.flash_board_contract
		}
	else
		self.fade_out_popup_contract(self, contract_id, true)

		self._contract_fade_data = {
			id = contract_id,
			fade_function = self._hide_log_contract
		}
	end

	return 
end
QuestView._turn_in_quest = function (self, quest_id)
	self.play_sound(self, "Play_hud_quest_menu_finish_quest_turn_in_stamp")
	self.quest_manager:complete_quest_by_id(quest_id)

	self._waiting_for_reward = true
	self._suspend_polling = true
	self.gamepad_selected_widget = nil

	self.set_input_blocked(self, true)
	self.hide_popup_buttons(self, true)
	self.fade_out_popup_quest(self, true)
	self.fade_out_log_quest(self, quest_id)
	self.animate_turned_in_text(self, "dlc1_3_1_quest_completed", self.quest_manager:get_title_for_quest_id(quest_id))

	return 
end
QuestView._turn_in_contract = function (self, contract_id)
	self.play_sound(self, "Play_hud_quest_menu_finish_quest_turn_in_stamp")
	self.quest_manager:complete_contract_by_id(contract_id)

	self._waiting_for_reward = true
	self._suspend_polling = true
	self.gamepad_selected_widget = nil

	self.set_input_blocked(self, true)
	self.hide_popup_buttons(self, true)
	self.fade_out_popup_contract(self, contract_id, true)
	self.fade_out_log_contract(self, contract_id)
	self.animate_turned_in_text(self, "dlc1_3_1_contract_completed", self.quest_manager:get_title_for_contract_id(contract_id))

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
QuestView._poll_backend = function (self)
	local quest_manager = self.quest_manager

	if not self._suspend_polling then
		local dirty_quests = quest_manager.are_quests_dirty(quest_manager)
		local dirty_contracts = quest_manager.are_contracts_dirty(quest_manager)
		local dirty_expire_times = quest_manager.are_expire_times_dirty(quest_manager)

		if dirty_expire_times then
			local expire_times = quest_manager.get_expire_times(quest_manager)
			self._expire_times = expire_times
		end

		if dirty_quests or dirty_contracts then
			self._update_board_and_log(self)

			self._queried_quests_and_contracts = nil
		end
	elseif self._waiting_for_reward then
		if not self.turned_in_text_active(self) and not self.reward_screen:active() then
			local reward = quest_manager.poll_reward(quest_manager)

			if reward then
				self._got_first_reward = true

				self._show_reward(self, reward)
			elseif not reward and self._got_first_reward then
				self._waiting_for_reward = nil
				self._got_first_reward = nil

				self.close_detailed_popup(self)

				self.gamepad_selected_widget = nil
			end
		end
	elseif not self.quest_fading(self) and not self.contract_fading(self) and not self._popup_active and not self.quest_moving(self) and not self.contract_moving(self) then
		local dirty_quests = quest_manager.are_quests_dirty(quest_manager)
		local dirty_contracts = quest_manager.are_contracts_dirty(quest_manager)
		local dirty_expire_times = quest_manager.are_expire_times_dirty(quest_manager)

		if dirty_expire_times then
			local expire_times = quest_manager.get_expire_times(quest_manager)
			self._expire_times = expire_times
		end

		if dirty_quests or dirty_contracts then
			self.close_detailed_popup(self)
			self._update_board_and_log(self)

			self._suspend_polling = nil
			local quest_fade_data = self._quest_fade_data

			if quest_fade_data then
				if quest_fade_data.fade_function then
					quest_fade_data.fade_function(self, quest_fade_data.id)
				end

				if quest_fade_data.flash_function then
					quest_fade_data.flash_function(self, quest_fade_data.id)
				end
			end

			self._quest_fade_data = nil
			local contract_fade_data = self._contract_fade_data

			if contract_fade_data then
				if contract_fade_data.fade_function then
					contract_fade_data.fade_function(self, contract_fade_data.id)
				end

				if contract_fade_data.flash_function then
					contract_fade_data.flash_function(self, contract_fade_data.id)
				end
			end

			self._contract_fade_data = nil
		end
	end

	return 
end
QuestView._update_popups = function (self)
	if self.decline_quest_popup_id then
		local popup_result = Managers.popup:query_result(self.decline_quest_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self.decline_quest_popup_id)

			self.decline_quest_popup_id = nil
			self._popup_active = nil
		end

		if popup_result == "yes" then
			local quest_id = self.active_popup_widget.content.quest_id

			self._decline_quest(self, quest_id)

			self._popup_active = nil
		end
	end

	if self.decline_contract_popup_id then
		local popup_result = Managers.popup:query_result(self.decline_contract_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self.decline_contract_popup_id)

			self.decline_contract_popup_id = nil
			self._popup_active = nil
		end

		if popup_result == "yes" then
			local contract_id = self.active_popup_widget.content.contract_id

			self._decline_contract(self, contract_id)

			self._popup_active = nil
		end
	end

	if self.accept_expired_quest_popup_id then
		local popup_result = Managers.popup:query_result(self.accept_expired_quest_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self.accept_expired_quest_popup_id)

			self.accept_expired_quest_popup_id = nil

			self.quest_manager:query_expire_times()
			self.quest_manager:query_quests_and_contracts()

			self._suspend_polling = nil
			self._queried_quests_and_contracts = true
			self._popup_active = nil
		end
	end

	if self.accept_expired_contract_popup_id then
		local popup_result = Managers.popup:query_result(self.accept_expired_contract_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self.accept_expired_contract_popup_id)

			self.accept_expired_contract_popup_id = nil

			self.quest_manager:query_expire_times()
			self.quest_manager:query_quests_and_contracts()

			self._suspend_polling = nil
			self._queried_quests_and_contracts = true
			self._popup_active = nil
		end
	end

	if self.new_contracts_available_popup_id then
		local popup_result = Managers.popup:query_result(self.new_contracts_available_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self.new_contracts_available_popup_id)

			self.new_contracts_available_popup_id = nil
			self._suspend_polling = nil
			self._queried_quests_and_contracts = true
			self._popup_active = nil
		end
	end

	return 
end
QuestView._highlight_widgets = function (self)
	if self._previous_quest_hover_id ~= self._hovered_quest_id or self._previous_contract_hover_id ~= self._hovered_contract_id then
		self._stop_highlight_related_quests(self)
		self._stop_highlight_related_contracts(self)

		self._previous_quest_hover_id = nil
		self._previous_contract_hover_id = nil
	end

	if self._hovered_quest_id then
		self._start_highlight_related_contracts(self, self._hovered_quest_id)

		self._previous_quest_hover_id = self._hovered_quest_id
	end

	if self._hovered_contract_id then
		self._start_highlight_related_quests(self, self._hovered_contract_id)

		self._previous_contract_hover_id = self._hovered_contract_id
	end

	self._hovered_quest_id = nil
	self._hovered_contract_id = nil

	return 
end
QuestView._handle_exit = function (self, input_service)
	local exit_button_widget = self.exit_button_widget

	if exit_button_widget.content.button_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if exit_button_widget.content.button_hotspot.on_release or input_service.get(input_service, "toggle_menu") or self.gamepad_input_pressed.back then
		local return_to_game = not self.ingame_ui.menu_active

		self.play_sound(self, "Play_hud_hover")
		self.exit(self, return_to_game)
	end

	return 
end
QuestView._handle_page_navigation = function (self, input_service)
	local gamepad_input_pressed = self.gamepad_input_pressed
	local previous_page_button_widget_hotspot = self.previous_page_button_widget.content.button_hotspot

	if self._page_index == 1 then
		previous_page_button_widget_hotspot.disabled = true
	else
		previous_page_button_widget_hotspot.disabled = false
	end

	if previous_page_button_widget_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if previous_page_button_widget_hotspot.on_release or gamepad_input_pressed.cycle_previous then
		self.play_sound(self, "Play_hud_quest_menu_tab")

		self._page_index = math.max(self._page_index - 1, 1)
	end

	local next_page_button_widget_hotspot = self.next_page_button_widget.content.button_hotspot

	if self._page_index == self._num_pages then
		next_page_button_widget_hotspot.disabled = true
	else
		next_page_button_widget_hotspot.disabled = false
	end

	if next_page_button_widget_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if next_page_button_widget_hotspot.on_release or gamepad_input_pressed.cycle_next then
		self.play_sound(self, "Play_hud_quest_menu_tab")

		self._page_index = math.min(self._page_index + 1, self._num_pages)
	end

	local title = (self._page_index == 2 and "dlc1_3_1_board_title_drachenfels") or "dlc1_3_1_board_title_ubersreik"
	self.board_title_text_widget.content.text = title

	return 
end
QuestView._handle_log_contract_input = function (self)
	local page_index = 1
	local log_contract_widgets = self._log_contract_widgets[page_index]

	if log_contract_widgets then
		local gamepad_input_pressed = self.gamepad_input_pressed

		for widget_name, widget in pairs(log_contract_widgets) do
			local widget_content = widget.content
			local button_hotspot = widget_content.button_hotspot
			local contract_id = widget_content.contract_id

			if button_hotspot.internal_is_hover then
				self._hovered_contract_id = contract_id
			end

			if button_hotspot.on_hover_enter then
				self.play_sound(self, "Play_hud_hover")
			end

			if button_hotspot.on_release or (widget == self.gamepad_selected_widget and gamepad_input_pressed.confirm) then
				self._spawn_contract_popup(self, contract_id, true)

				break
			end
		end
	end

	return 
end
QuestView._handle_log_quest_input = function (self)
	local page_index = 1
	local log_quest_widgets = self._log_quest_widgets[page_index]

	if log_quest_widgets then
		local gamepad_input_pressed = self.gamepad_input_pressed

		for widget_name, widget in pairs(log_quest_widgets) do
			local widget_content = widget.content
			local button_hotspot = widget_content.button_hotspot
			local quest_id = widget_content.quest_id

			if button_hotspot.internal_is_hover then
				self._hovered_quest_id = quest_id
			end

			if button_hotspot.on_hover_enter then
				self.play_sound(self, "Play_hud_hover")
			end

			if button_hotspot.on_release or (widget == self.gamepad_selected_widget and gamepad_input_pressed.confirm) then
				self._spawn_quest_popup(self, quest_id, true)

				break
			end
		end
	end

	return 
end
QuestView._handle_board_contract_input = function (self)
	local page_index = self._page_index
	local board_contract_widgets = self._board_contract_widgets[page_index]

	if board_contract_widgets then
		local gamepad_input_pressed = self.gamepad_input_pressed

		for _, widget in ipairs(board_contract_widgets) do
			if widget then
				local widget_content = widget.content
				local button_hotspot = widget_content.button_hotspot
				local scenegraph_id = widget.scenegraph_id
				local contract_id = widget_content.contract_id

				if button_hotspot.internal_is_hover then
					self._hovered_contract_id = contract_id
				end

				if button_hotspot.on_hover_enter then
					self.play_sound(self, "Play_hud_hover")
				end

				if button_hotspot.on_release or (widget == self.gamepad_selected_widget and gamepad_input_pressed.confirm) then
					self._spawn_contract_popup(self, contract_id)

					break
				end
			end
		end
	end

	return 
end
QuestView._handle_board_quest_input = function (self)
	local page_index = self._page_index
	local board_quest_widgets = self._board_quest_widgets[page_index]

	if board_quest_widgets then
		local gamepad_input_pressed = self.gamepad_input_pressed

		for _, widget in ipairs(board_quest_widgets) do
			if widget then
				local widget_content = widget.content
				local button_hotspot = widget_content.button_hotspot
				local quest_id = widget_content.quest_id

				if button_hotspot.internal_is_hover then
					self._hovered_quest_id = quest_id
				end

				if button_hotspot.on_hover_enter then
					self.play_sound(self, "Play_hud_hover")
				end

				if button_hotspot.on_release or (widget == self.gamepad_selected_widget and gamepad_input_pressed.confirm) then
					self._spawn_quest_popup(self, quest_id)

					break
				end
			end
		end
	end

	return 
end
QuestView._start_highlight_related_contracts = function (self, quest_id)
	local quest = self.quest_manager:get_quest_by_id(quest_id)
	local quest_type = quest.type
	local page_index = self._page_index
	local board_contract_widgets = self._board_contract_widgets[page_index]

	for _, widget in pairs(board_contract_widgets) do
		local widget_content = widget.content

		if widget_content.has_quest_link and widget_content.quest_type == quest_type then
			widget_content.highlighted = true
		end
	end

	page_index = 1
	local log_contract_widgets = self._log_contract_widgets[page_index]

	for _, widget in pairs(log_contract_widgets) do
		local widget_content = widget.content

		if widget_content.has_quest_link and widget_content.quest_type == quest_type then
			widget_content.highlighted = true
		end
	end

	return 
end
QuestView._start_highlight_related_quests = function (self, contract_id)
	local widget = self._get_board_widget_for_contract_id(self, contract_id)
	widget = widget or self._get_log_widget_for_contract_id(self, contract_id)

	if widget.content.has_quest_link then
		local quest_type = widget.content.quest_type
		local page_index = self._page_index
		local board_quest_widgets = self._board_quest_widgets[page_index]

		for _, quest_widget in pairs(board_quest_widgets) do
			if quest_widget.content.type == quest_type then
				quest_widget.content.highlighted = true
			end
		end

		page_index = 1
		local log_quest_widgets = self._log_quest_widgets[page_index]

		for _, quest_widget in pairs(log_quest_widgets) do
			if quest_widget.content.type == quest_type then
				quest_widget.content.highlighted = true
			end
		end
	end

	return 
end
QuestView._stop_highlight_related_contracts = function (self)
	local page_index = self._page_index
	local board_contract_widgets = self._board_contract_widgets[page_index]

	for _, widget in pairs(board_contract_widgets) do
		widget.content.highlighted = false
	end

	page_index = 1
	local log_contract_widgets = self._log_contract_widgets[page_index]

	for _, widget in pairs(log_contract_widgets) do
		widget.content.highlighted = false
	end

	return 
end
QuestView._stop_highlight_related_quests = function (self)
	local page_index = self._page_index
	local board_quest_widgets = self._board_quest_widgets[page_index]

	for _, widget in pairs(board_quest_widgets) do
		widget.content.highlighted = false
	end

	page_index = 1
	local log_quest_widgets = self._log_quest_widgets[page_index]

	for _, widget in pairs(log_quest_widgets) do
		widget.content.highlighted = false
	end

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

	local gamepad_selection_widget = self.gamepad_selection_widget

	if gamepad_active and gamepad_selection_widget and not self.draw_detailed_popup then
		UIRenderer.draw_widget(ui_renderer, gamepad_selection_widget)
	end

	for widget_name, widget in pairs(widgets_by_name) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	local page_index = self._page_index
	local board_contract_widgets = self._board_contract_widgets[page_index]

	if board_contract_widgets then
		for _, widget in ipairs(board_contract_widgets) do
			if widget then
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end
	end

	local board_quest_widgets = self._board_quest_widgets[page_index]

	if board_quest_widgets then
		for _, widget in ipairs(board_quest_widgets) do
			if widget then
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end
	end

	page_index = 1
	local log_contract_widgets = self._log_contract_widgets[page_index]

	if log_contract_widgets then
		for _, widget in pairs(log_contract_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	local log_quest_widgets = self._log_quest_widgets[page_index]

	if log_quest_widgets then
		for _, widget in pairs(log_quest_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	local draw_intro_description = self.draw_intro_description

	if draw_intro_description then
		for _, widget in pairs(self.description_text_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	local draw_faded_background = self.draw_detailed_popup or self.decline_quest_popup_id or self.decline_contract_popup_id or reward_screen_active

	if draw_faded_background then
		UIRenderer.draw_widget(ui_renderer, self.reward_popup_widgets.reward_popup_bg_fade)
	end

	for _, widget in pairs(self.completion_text_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	if self.draw_detailed_popup and not self.decline_quest_popup_id and not self.decline_contract_popup_id then
		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_manager.get_service(input_manager, "quest_view"), dt)

		if not gamepad_active then
			local detail_popup_widgets = self.detail_popup_widgets

			for widget_name, widget in pairs(detail_popup_widgets) do
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end

		local active_popup_widget = self.active_popup_widget

		if active_popup_widget then
			UIRenderer.draw_widget(ui_renderer, active_popup_widget)
		end

		if self._draw_item_reward_buttons then
			for _, widget in pairs(self.trait_icon_widgets) do
				UIRenderer.draw_widget(ui_renderer, widget)
			end

			for _, widget in pairs(self.tooltip_widgets) do
				UIRenderer.draw_widget(ui_renderer, widget)
			end

			UIRenderer.draw_widget(ui_renderer, self.hero_icon_tooltip)
		end

		UIRenderer.end_pass(ui_renderer)
	end

	if gamepad_active and not reward_screen_active and not self.decline_quest_popup_id and not self.decline_contract_popup_id then
		self.menu_input_description:draw(ui_top_renderer, dt)
	end

	return 
end
QuestView.destroy = function (self)
	if self.reward_screen then
		self.reward_screen:destroy()
	end

	self.menu_input_description:destroy()

	self.menu_input_description = nil
	self.ingame_ui_context = nil
	self.ui_animator = nil
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)

	return 
end

if rawget(_G, "global_quest_view") then
	global_quest_view:create_ui_elements()
end

QuestView._is_contract_log_full = function (self)
	return QuestSettings.MAX_NUMBER_OF_LOG_CONTRACTS <= self.num_active_contracts
end
QuestView._is_quest_log_full = function (self)
	return QuestSettings.MAX_NUMBER_OF_LOG_QUESTS <= self.num_active_quests
end
QuestView._hide_board_contract = function (self, contract_id)
	local widget = self._get_board_widget_for_contract_id(self, contract_id)

	if widget then
		local widget_content = widget.content
		widget_content.visible = false
		widget_content.active = false
		widget_content.enabled = false
	end

	return 
end
QuestView._hide_log_contract = function (self, contract_id)
	local widget = self._get_log_widget_for_contract_id(self, contract_id)

	if widget then
		local widget_content = widget.content
		widget_content.visible = false
		widget_content.active = false
		widget_content.enabled = false
	end

	return 
end
QuestView._hide_board_quest = function (self, quest_id)
	local widget = self._get_board_widget_for_quest_id(self, quest_id)

	if widget then
		local widget_content = widget.content
		widget_content.visible = false
		widget_content.active = false
		widget_content.enabled = false
	end

	return 
end
QuestView._hide_log_quest = function (self, quest_id)
	local widget = self._get_log_widget_for_quest_id(self, quest_id)

	if widget then
		local widget_content = widget.content
		widget_content.visible = false
		widget_content.active = false
		widget_content.enabled = false
	end

	return 
end
QuestView._contract_exists_on_board = function (self, contract_id)
	return self._get_board_widget_for_contract_id(self, contract_id) ~= nil
end
QuestView._contract_exists_in_log = function (self, contract_id)
	return self._get_log_widget_for_contract_id(self, contract_id) ~= nil
end
QuestView._quest_exists_on_board = function (self, quest_id)
	return self._get_board_widget_for_quest_id(self, quest_id) ~= nil
end
QuestView._quest_exists_in_log = function (self, quest_id)
	return self._get_log_widget_for_quest_id(self, quest_id) ~= nil
end
QuestView._get_board_widget_for_contract_id = function (self, contract_id)
	local board_contract_widgets = self._board_contract_widgets

	for page_index, widget_tabe in pairs(board_contract_widgets) do
		for _, widget in ipairs(board_contract_widgets[page_index]) do
			local widget_content = widget.content

			if widget_content.contract_id == contract_id then
				return widget
			end
		end
	end

	return 
end
QuestView._get_board_widget_for_quest_id = function (self, quest_id)
	local board_quest_widgets = self._board_quest_widgets

	for page_index, widget_tabe in pairs(board_quest_widgets) do
		for _, widget in ipairs(board_quest_widgets[page_index]) do
			local widget_content = widget.content

			if widget_content.quest_id == quest_id then
				return widget
			end
		end
	end

	return 
end
QuestView._get_log_widget_for_contract_id = function (self, contract_id)
	local page_index = 1
	local log_contract_widgets = self._log_contract_widgets[page_index]

	for _, widget in ipairs(log_contract_widgets) do
		local widget_content = widget.content

		if widget_content.contract_id == contract_id then
			return widget
		end
	end

	return 
end
QuestView._get_log_widget_for_quest_id = function (self, quest_id)
	local page_index = 1
	local log_quest_widgets = self._log_quest_widgets[page_index]

	for _, widget in ipairs(log_quest_widgets) do
		local widget_content = widget.content

		if widget_content.quest_id == quest_id then
			return widget
		end
	end

	return 
end
QuestView._update_board_and_log = function (self)
	self._update_quest_board(self)
	self._update_quest_log(self)
	self._update_contract_board(self)
	self._update_contract_log(self)

	return 
end
QuestView._update_quest_board = function (self)
	local board_quests = table.clone(self.quest_manager:get_quests())

	for id, data in pairs(board_quests) do
		local expire_at = data.expire_at or 0
		local expired = self.quest_manager:has_time_expired(expire_at)
		local active = data.active

		if expired then
			board_quests[id] = nil
		end
	end

	if board_quests then
		local num_quests = 0
		local page_index = 1
		local board_quest_widgets = self._board_quest_widgets

		for quest_id, quest_data in pairs(board_quests) do
			num_quests = num_quests + 1

			if num_quests%(QuestSettings.MAX_NUMBER_OF_BOARD_QUESTS + 1) == 0 then
				page_index = page_index + 1
			end

			local widget = board_quest_widgets[page_index][num_quests]
			widget.content.active = quest_data.active
			widget.content.button_hotspot.active = quest_data.active
			widget.content.enabled = not quest_data.active

			if quest_data.turned_in then
				widget.content.visible = false
			end

			self._set_board_quest_widget_info(self, widget, quest_id, quest_data)
		end

		local index = num_quests + 1

		for i = num_quests + 1, QuestSettings.MAX_NUMBER_OF_BOARD_QUESTS*self._num_pages, 1 do
			if index%(QuestSettings.MAX_NUMBER_OF_BOARD_QUESTS + 1) == 0 then
				page_index = page_index + 1
				index = 1
			end

			local widget = board_quest_widgets[page_index][index]
			widget.content.active = false
			widget.content.button_hotspot.active = false
			widget.content.enabled = false
			widget.content.visible = false
			index = index + 1
		end
	end

	return 
end
QuestView._update_contract_board = function (self)
	local board_contracts = table.clone(self.quest_manager:get_contracts())

	for id, data in pairs(board_contracts) do
		local expire_at = data.expire_at or 0
		local expired = self.quest_manager:has_time_expired(expire_at)
		local active = data.active

		if expired then
			board_contracts[id] = nil
		end
	end

	local num_contracts = 0

	if board_contracts then
		local page_index = 1
		local board_contract_widgets = self._board_contract_widgets

		for contract_id, contract_data in pairs(board_contracts) do
			num_contracts = num_contracts + 1

			if QuestSettings.MAX_NUMBER_OF_BOARD_CONTRACTS < num_contracts then
				break
			end

			local widget = board_contract_widgets[page_index][num_contracts]
			local active = contract_data.active
			widget.content.active = active
			widget.content.button_hotspot.active = active
			widget.content.enabled = not active

			if contract_data.turned_in then
				widget.content.visible = false
				widget.content.enabled = false
			else
				widget.content.visible = true
				widget.content.enabled = true
			end

			self._set_board_contract_widget_info(self, widget, contract_data, contract_id)
		end

		local index = num_contracts + 1

		for i = num_contracts + 1, QuestSettings.MAX_NUMBER_OF_BOARD_CONTRACTS*self._num_pages, 1 do
			if index%(QuestSettings.MAX_NUMBER_OF_BOARD_CONTRACTS + 1) == 0 then
				page_index = page_index + 1
				index = 1
			end

			local widget = board_contract_widgets[page_index][index]
			widget.content.active = false
			widget.content.button_hotspot.active = false
			widget.content.visible = false
			widget.content.enabled = false
			index = index + 1
		end
	end

	return 
end
QuestView._update_quest_log = function (self)
	local all_quests = table.clone(self.quest_manager:get_quests())
	local quest = nil

	for id, data in pairs(all_quests) do
		local active = data.active
		local deleted = data.deleted

		if active and not deleted then
			quest = data

			break
		end
	end

	local page_index = 1
	local log_quest_widgets = self._log_quest_widgets
	local widget = log_quest_widgets[page_index][1]

	if quest and widget then
		widget.content.active = quest.active
		widget.content.button_hotspot.active = quest.active
		widget.content.enabled = quest.active

		self._set_log_quest_widget_info(self, widget, quest.id, quest)

		self.num_active_quests = 1
	else
		widget.content.active = false
		widget.content.button_hotspot.active = false
		widget.content.enabled = false
		self.num_active_quests = 0
	end

	return 
end
QuestView._update_contract_log = function (self)
	local active_contracts = table.clone(self.quest_manager:get_active_contracts())

	for id, data in pairs(active_contracts) do
		if data.deleted then
			active_contracts[id] = nil
		end
	end

	if active_contracts then
		local num_contracts = table.size(active_contracts)
		local page_index = 1
		local log_contract_widgets = self._log_contract_widgets[page_index]
		local id_to_index_lookup = {}
		local unused_indices = {}

		for i = 1, #log_contract_widgets, 1 do
			local widget = log_contract_widgets[i]
			local contract_still_exists = false

			for contract_id, _ in pairs(active_contracts) do
				if contract_id == widget.content.contract_id then
					contract_still_exists = true

					break
				end
			end

			if widget.content.contract_id and contract_still_exists then
				id_to_index_lookup[widget.content.contract_id] = i
			else
				unused_indices[#unused_indices + 1] = i
			end
		end

		for contract_id, widget_index in pairs(id_to_index_lookup) do
			local widget = log_contract_widgets[widget_index]
			local contract_data = active_contracts[contract_id]
			widget.content.active = contract_data.active
			widget.content.button_hotspot.active = contract_data.active
			widget.content.enabled = contract_data.active

			self._set_log_contract_widget_info(self, widget, contract_data, contract_id)

			active_contracts[contract_id] = nil
		end

		for contract_id, contract_data in pairs(active_contracts) do
			local widget_index = table.remove(unused_indices, 1)
			local widget = log_contract_widgets[widget_index]
			local contract_data = active_contracts[contract_id]
			widget.content.active = contract_data.active
			widget.content.button_hotspot.active = contract_data.active
			widget.content.enabled = contract_data.active

			self._set_log_contract_widget_info(self, widget, contract_data, contract_id)
		end

		for _, log_index in pairs(unused_indices) do
			local widget = log_contract_widgets[log_index]
			widget.content.active = false
			widget.content.button_hotspot.active = false
			widget.content.contract_id = nil
			widget.content.enabled = false
		end

		self.num_active_contracts = num_contracts
	end

	return 
end
local quest_board_indices_temp_table = {
	1,
	2,
	3
}
QuestView._create_quest_board = function (self)
	local board_quest_widgets = self._board_quest_widgets

	table.clear(board_quest_widgets)

	local parent_scenegraph_id = "board_quest_slot_"
	local page_index = 1
	local index = 1

	for i = 1, QuestSettings.MAX_NUMBER_OF_BOARD_QUESTS*self._num_pages, 1 do
		if index%(QuestSettings.MAX_NUMBER_OF_BOARD_QUESTS + 1) == 0 then
			page_index = page_index + 1
			index = 1
		end

		if not board_quest_widgets[page_index] then
			board_quest_widgets[page_index] = {}
		end

		local parent_scenegraph_index = quest_board_indices_temp_table[index]
		local scenegraph_id = parent_scenegraph_id .. tostring(parent_scenegraph_index)
		local widget_definition = create_board_quest(scenegraph_id)
		local widget = UIWidget.init(widget_definition)
		board_quest_widgets[page_index][index] = widget
		index = index + 1
	end

	return 
end
QuestView._create_quest_log = function (self)
	local log_quest_widgets = self._log_quest_widgets

	table.clear(log_quest_widgets)

	for i = 1, QuestSettings.MAX_NUMBER_OF_LOG_QUESTS, 1 do
		local max_quests_per_page = QuestSettings.MAX_NUMBER_OF_LOG_QUESTS
		local log_quest_widgets = self._log_quest_widgets
		local widget_definition = create_log_quest()
		local widget = UIWidget.init(widget_definition)

		for page_index, page_widgets in ipairs(log_quest_widgets) do
			for i = 1, max_quests_per_page, 1 do
				if not page_widgets[i] then
					page_widgets[i] = widget

					return 
				end
			end
		end

		log_quest_widgets[#log_quest_widgets + 1] = {
			widget
		}
	end

	return 
end
local contract_board_indices_temp_table = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8
}
QuestView._create_contract_board = function (self)
	local board_contract_widgets = self._board_contract_widgets

	table.clear(board_contract_widgets)

	local parent_scenegraph_id = "board_contract_slot_"
	local page_index = 1
	local index = 1

	for i = 1, QuestSettings.MAX_NUMBER_OF_BOARD_CONTRACTS*self._num_pages, 1 do
		if index%(QuestSettings.MAX_NUMBER_OF_BOARD_CONTRACTS + 1) == 0 then
			page_index = page_index + 1
			index = 1
		end

		if not board_contract_widgets[page_index] then
			board_contract_widgets[page_index] = {}
		end

		local parent_scenegraph_index = contract_board_indices_temp_table[index]
		local scenegraph_id = parent_scenegraph_id .. tostring(parent_scenegraph_index)
		local widget_definition = create_board_contract(scenegraph_id)
		local widget = UIWidget.init(widget_definition)
		board_contract_widgets[page_index][index] = widget
		index = index + 1
	end

	return 
end
local contract_log_indices_temp_table = {
	1,
	2,
	3
}
QuestView._create_contract_log = function (self)
	local log_contract_widgets = self._log_contract_widgets

	table.clear(log_contract_widgets)

	local parent_scenegraph_id = "log_contract_"
	local page_index = 1
	local index = 1

	for i = 1, QuestSettings.MAX_NUMBER_OF_LOG_CONTRACTS, 1 do
		local page_position_counter = index%(QuestSettings.MAX_NUMBER_OF_LOG_CONTRACTS + 1)
		local change_page = page_position_counter == 0

		if change_page then
			page_index = page_index + 1
			page_position_counter = 1
		end

		if not log_contract_widgets[page_index] then
			log_contract_widgets[page_index] = {}
		end

		local parent_scenegraph_index = contract_log_indices_temp_table[page_position_counter]
		local scenegraph_id = parent_scenegraph_id .. tostring(parent_scenegraph_index)
		local widget_definition = create_log_contract(QuestSettings.CONTRACT_LOG_WIDGET_SIZE, scenegraph_id)
		local widget = UIWidget.init(widget_definition)
		log_contract_widgets[page_index][page_position_counter] = widget
		index = index + 1
	end

	return 
end
QuestView._set_board_quest_widget_info = function (self, widget, quest_id, quest_data)
	local widget_style = widget.style
	local widget_content = widget.content
	local requirements = quest_data.requirements
	local rewards = quest_data.rewards
	widget_content.expire_at = quest_data.expire_at
	widget_content.quest_id = quest_id
	widget_content.type = quest_data.type
	widget_content.requirements_met = quest_data.requirements_met
	local required_seals = requirements.amount_sigils.required
	widget_content.quest_link_text = "x" .. tostring(required_seals)
	widget_content.has_item_reward = nil
	local reward_items = rewards.items
	local reward_tokens = rewards.tokens
	local reward_boons = rewards.boons
	local item_key = nil

	if reward_items then
		local data_type = type(reward_items)

		if data_type == "string" then
			item_key = reward_items
		elseif data_type == "table" and 0 < #reward_items then
			item_key = reward_items[1]
		end
	end

	local boon_key = nil

	if reward_boons then
		local data_type = type(reward_boons)

		if data_type == "string" then
			boon_key = reward_boons
		elseif data_type == "table" and 0 < #reward_boons then
			boon_key = reward_boons[1]
		end
	end

	if item_key then
		local item = ItemMasterList[item_key]
		widget_content.reward_icon = item.inventory_icon
		widget_style.item_reward_frame.color = Colors.get_table(item.rarity)
		widget_content.has_item_reward = true
	elseif reward_tokens then
		local token_type = reward_tokens.type
		local token_icon = QuestSettings.token_type_to_large_icon_lookup[token_type]
		widget_content.reward_icon = token_icon
	elseif boon_key then
		local boon_template = BoonTemplates[boon_key]
		local boon_icon = boon_template.ui_icon
		widget_content.reward_icon = boon_icon
	end

	local seed = self.quest_manager:get_random_seed_from_id(quest_id)
	local bg_texture, fg_texture = nil
	bg_texture, seed = self._get_sigil_bg_texture(self, quest_id, false, seed)
	fg_texture, seed = self._get_sigil_fg_texture(self, quest_id, quest_data.type, seed)
	widget_content.quest_link_marker_bg_texture = bg_texture
	widget_content.quest_link_marker_fg_texture = fg_texture
	widget_content.background_texture = self._get_quest_background(self, seed, quest_data)
	widget_content.title_text = self.quest_manager:get_title_for_quest_id(quest_id)

	return 
end
QuestView._set_log_quest_widget_info = function (self, widget, quest_id, quest_data)
	local widget_style = widget.style
	local widget_content = widget.content
	local requirements = quest_data.requirements
	local rewards = quest_data.rewards
	widget_content.expire_at = quest_data.expire_at
	widget_content.quest_id = quest_id
	widget_content.type = quest_data.type
	widget_content.requirements_met = quest_data.requirements_met
	local acquired_seals = requirements.amount_sigils.acquired
	local required_seals = requirements.amount_sigils.required
	local text = tostring(acquired_seals) .. "/" .. tostring(required_seals)
	widget_content.quest_link_text = text
	widget_content.has_item_reward = nil
	local reward_items = rewards.items
	local reward_tokens = rewards.tokens
	local reward_boons = rewards.boons
	local item_key = nil

	if reward_items then
		local data_type = type(reward_items)

		if data_type == "string" then
			item_key = reward_items
		elseif data_type == "table" and 0 < #reward_items then
			item_key = reward_items[1]
		end
	end

	local boon_key = nil

	if reward_boons then
		local data_type = type(reward_boons)

		if data_type == "string" then
			boon_key = reward_boons
		elseif data_type == "table" and 0 < #reward_boons then
			boon_key = reward_boons[1]
		end
	end

	if item_key then
		local item = ItemMasterList[item_key]
		widget_content.reward_icon = item.inventory_icon
		widget_style.item_reward_frame.color = Colors.get_table(item.rarity)
		widget_content.has_item_reward = true
	elseif reward_tokens then
		local token_type = reward_tokens.type
		local token_icon = QuestSettings.token_type_to_large_icon_lookup[token_type]
		widget_content.reward_icon = token_icon
	elseif boon_key then
		local boon_template = BoonTemplates[boon_key]
		local boon_icon = boon_template.ui_icon
		widget_content.reward_icon = boon_icon
	end

	local seed = self.quest_manager:get_random_seed_from_id(quest_id)
	local bg_texture, fg_texture = nil
	bg_texture, seed = self._get_sigil_bg_texture(self, quest_id, false, seed)
	fg_texture, seed = self._get_sigil_fg_texture(self, quest_id, quest_data.type, seed)
	widget_content.texture_quest_link_marker_bg = bg_texture
	widget_content.texture_quest_link_marker_fg = fg_texture
	widget_content.title_text = self.quest_manager:get_title_for_quest_id(quest_id)

	return 
end
QuestView._set_board_contract_widget_info = function (self, widget, contract_data, contract_id)
	local widget_style = widget.style
	local widget_content = widget.content
	local requirements = contract_data.requirements
	local levels = requirements.levels
	local difficulty = requirements.difficulty
	local task = requirements.task
	local rewards = contract_data.rewards
	local tags = contract_data.tags
	widget_content.expire_at = contract_data.expire_at
	widget_content.contract_id = contract_id
	widget_content.requirements_met = contract_data.requirements_met
	widget_content.has_quest_link = rewards.quest ~= nil
	widget_content.quest_type = (rewards.quest and rewards.quest.quest_type) or nil
	widget_content.title_text = self.quest_manager:get_title_for_contract_id(contract_id)
	widget_content.description_text = self.quest_manager:get_description_for_contract_id(contract_id)

	if difficulty then
		local difficulty_display_name = DifficultySettings[difficulty].display_name
		widget_content.difficulty_text = difficulty_display_name
	end

	table.clear(widget_content.texture_level_icons)

	local required_level = (levels and levels.required) or {
		"any"
	}
	local num_levels = #required_level
	local level_total_width = (num_levels - 1)*widget_style.level_icon_spacing

	for i = 1, num_levels, 1 do
		local level_icon = QuestSettings.level_icon_lookup[required_level[i]] or QuestSettings.level_icon_lookup.any
		widget_content.texture_level_icons[i] = level_icon
		local image_settings = get_atlas_settings_by_texture_name(level_icon)
		local image_width = image_settings.size[1]*widget_style.scale
		level_total_width = level_total_width + image_width
	end

	local x_offset = (widget_style.canvas_size[1] - level_total_width)*0.5
	widget_style.texture_level_icons.offset[1] = widget_style.canvas_offset[1] + x_offset

	if not task then
		widget_style.texture_level_icons.offset[2] = widget_style.no_task_level_y_offset
	else
		widget_style.texture_level_icons.offset[2] = widget_style.tasks_level_y_offset
	end

	table.clear(widget_content.texture_task_icons)
	table.clear(widget_content.task_amount_texts.texts)

	if task then
		local i = 1
		local task_type = task.type
		local task_amount = task.amount.required
		local task_icon = QuestSettings.task_type_to_icon_lookup[task_type]
		widget_content.texture_task_icons[1] = task_icon
		widget_content.task_amount_texts.texts[1] = "x" .. tostring(task_amount)
		i = i + 1
		local tasks_total_width = (i - 1)*(widget_style.task_icon_size[1] + widget_style.task_icon_spacing)
		local x_offset = (widget_style.canvas_size[1] - tasks_total_width)*0.5
		widget_style.texture_task_icons.offset[1] = widget_style.canvas_offset[1] + x_offset
		widget_style.task_amount_texts.offset[1] = widget_style.canvas_offset[1] + x_offset + widget_style.task_icon_size[1]
	end

	local reward_items = rewards.items
	local reward_tokens = rewards.tokens
	local reward_boons = rewards.boons
	local reward_quest = rewards.quest

	if reward_quest then
		local amount_seals = reward_quest.amount_sigils
		widget_content.quest_link_text = "x" .. tostring(amount_seals)
	end

	local item_key = nil

	if reward_items then
		local data_type = type(reward_items)

		if data_type == "string" then
			item_key = reward_items
		elseif data_type == "table" and 0 < #reward_items then
			item_key = reward_items[1]
		end
	end

	local boon_key = nil

	if reward_boons then
		local data_type = type(reward_boons)

		if data_type == "string" then
			boon_key = reward_boons
		elseif data_type == "table" and 0 < #reward_boons then
			boon_key = reward_boons[1]
		end
	end

	if item_key then
	elseif reward_tokens then
		local token_type = reward_tokens.type
		local token_amount = reward_tokens.amount
		local token_icon = QuestSettings.token_type_to_large_icon_lookup[token_type]
		local amount_text = "x" .. tostring(token_amount)
		widget_content.texture_token_reward_icon = token_icon
		widget_content.reward_amount_text = amount_text
	elseif boon_key then
		local boon_template = BoonTemplates[boon_key]
		local boon_icon = boon_template.ui_icon
		local duration = self._get_readable_boon_duration(self, boon_template.duration)
		widget_content.texture_token_reward_icon = boon_icon
		widget_content.reward_amount_text = duration
	end

	local seed = self.quest_manager:get_random_seed_from_id(contract_id)

	if reward_quest then
		local texture_bg, texture_fg = nil
		texture_bg, seed = self._get_sigil_bg_texture(self, contract_id, false, seed)
		texture_fg, seed = self._get_sigil_fg_texture(self, contract_id, rewards.quest.quest_type, seed)
		widget_content.texture_quest_link_bg = texture_bg
		widget_content.texture_quest_link_fg = texture_fg
	end

	widget_content.background_texture = self._get_contract_background(self, seed, contract_data)
	local corner_textures = self._get_contract_background_corners(self, seed, contract_data)
	widget_content.background_corner_texture_top_left = corner_textures[1]
	widget_content.background_corner_texture_top_right = corner_textures[2]
	widget_content.background_corner_texture_bottom_left = corner_textures[3]
	widget_content.background_corner_texture_bottom_right = corner_textures[4]

	return 
end
QuestView._set_contract_popup_widget_info = function (self, widget, contract_data, contract_id)
	self.reset_popup_contract_values(self, widget)

	local widget_style = widget.style
	local widget_content = widget.content
	local requirements = contract_data.requirements
	local levels = requirements.levels
	local difficulty = requirements.difficulty
	local task = requirements.task
	local rewards = contract_data.rewards
	local tags = contract_data.tags
	local requirements_met = contract_data.requirements_met
	widget_content.title_text = self.quest_manager:get_title_for_contract_id(contract_id)
	widget_content.description_text = self.quest_manager:get_description_for_contract_id(contract_id)
	widget_content.has_quest_link = rewards.quest ~= nil
	widget_content.quest_type = (rewards.quest and rewards.quest.quest_type) or nil
	widget_content.requirements_met = requirements_met

	if difficulty then
		local difficulty_display_name = DifficultySettings[difficulty].display_name

		if DifficultySettings[difficulty].rank < #DefaultDifficulties then
			widget_content.difficulty_text = string.format(Localize("dlc1_3_1_quests_difficulty_text"), Localize(difficulty_display_name))
		else
			widget_content.difficulty_text = Localize(difficulty_display_name)
		end
	end

	table.clear(widget_content.texture_level_icons)
	table.clear(widget_content.level_name_texts.texts)

	local required_level = (levels and levels.required) or {
		"any"
	}
	local acquired_level = (levels and levels.acquired) or {}
	local num_levels = #required_level
	local level_total_width = (num_levels - 1)*widget_style.level_icon_spacing
	local image_width = 0

	for i = 1, num_levels, 1 do
		local level_icon = QuestSettings.level_icon_lookup[required_level[i]] or QuestSettings.level_icon_lookup.any
		local level_name = QuestSettings.level_name_lookup[required_level[i]] or required_level[i]
		widget_content.texture_level_icons[i] = level_icon
		widget_content.level_name_texts.texts[i] = level_name

		if table.contains(acquired_level, required_level[i]) then
			widget_style.texture_level_checkmark_icons.texture_colors[i][1] = 255
			widget_content.completed_levels[i] = true
		else
			widget_style.texture_level_checkmark_icons.texture_colors[i][1] = 0
			widget_content.completed_levels[i] = false
		end

		local image_settings = get_atlas_settings_by_texture_name(level_icon)
		image_width = image_settings.size[1]
		level_total_width = level_total_width + image_width
	end

	widget_style.texture_level_checkmark_icons.draw_count = num_levels
	local x_offset = (widget_style.canvas_size[1] - level_total_width)*0.5
	widget_style.texture_level_icons.offset[1] = widget_style.canvas_offset[1] + x_offset
	widget_style.level_name_texts.offset[1] = widget_style.canvas_offset[1] + x_offset
	widget_style.texture_level_checkmark_icons.offset[1] = widget_style.canvas_offset[1] + x_offset

	table.clear(widget_content.texture_task_icons)
	table.clear(widget_content.task_amount_texts.texts)
	table.clear(widget_content.task_progress_texts.texts)
	table.clear(widget_content.task_name_texts.texts)

	if task then
		local i = 1
		local task_type = task.type
		local task_amount = task.amount.required
		local task_progress = task.amount.acquired
		local task_icon = QuestSettings.task_type_to_icon_lookup[task_type]
		local task_name = QuestSettings.task_type_to_task_description_lookup[task_type]
		widget_content.texture_task_icons[1] = task_icon
		widget_content.task_amount_texts.texts[1] = "x" .. tostring(task_amount)
		widget_content.task_progress_texts.texts[1] = tostring(task_progress) .. "/" .. tostring(task_amount)
		widget_content.task_name_texts.texts[1] = task_name
		i = i + 1
		widget_style.texture_task_checkmark_icons.draw_count = math.max(0, i - 1)
		local tasks_total_width = (i - 1)*(widget_style.task_icon_size[1] + widget_style.task_icon_spacing)
		local x_offset = (widget_style.canvas_size[1] - tasks_total_width)*0.5
		widget_style.texture_task_icons.offset[1] = widget_style.canvas_offset[1] + x_offset
		widget_style.task_amount_texts.offset[1] = widget_style.canvas_offset[1] + x_offset + widget_style.task_icon_size[1]
		widget_style.task_progress_texts.offset[1] = widget_style.canvas_offset[1] + x_offset
		widget_style.task_name_texts.offset[1] = widget_style.canvas_offset[1] + x_offset
		widget_style.texture_task_checkmark_icons.offset[1] = widget_style.canvas_offset[1] + x_offset + widget_style.task_icon_size[1]*0.35

		if task_amount <= task_progress then
			widget_style.texture_task_checkmark_icons.texture_colors[1][1] = 255
			widget_content.completed_tasks[i] = true
		else
			widget_style.texture_task_checkmark_icons.texture_colors[1][1] = 0
			widget_content.completed_tasks[i] = false
		end
	end

	widget_content.has_item_reward = nil
	widget_content.has_token_reward = nil
	widget_content.has_boon_reward = nil
	local reward_items = rewards.items
	local reward_tokens = rewards.tokens
	local reward_boons = rewards.boons
	local reward_quest = rewards.quest

	if reward_quest then
		local amount_seals = reward_quest.amount_sigils
		widget_content.quest_link_text = "x" .. tostring(amount_seals)
	end

	local item_key = nil

	if reward_items then
		local data_type = type(reward_items)

		if data_type == "string" then
			item_key = reward_items
		elseif data_type == "table" and 0 < #reward_items then
			item_key = reward_items[1]
		end
	end

	local boon_key = nil

	if reward_boons then
		local data_type = type(reward_boons)

		if data_type == "string" then
			boon_key = reward_boons
		elseif data_type == "table" and 0 < #reward_boons then
			boon_key = reward_boons[1]
		end
	end

	if item_key then
	elseif reward_tokens then
		local token_type = reward_tokens.type
		local token_amount = reward_tokens.amount
		local token_icon = QuestSettings.token_type_to_large_icon_lookup[token_type]
		local amount_text = "x" .. tostring(token_amount)
		widget_content.texture_token_reward_icon = token_icon
		widget_content.reward_amount_text = amount_text
		widget_content.has_token_reward = true
	elseif boon_key then
		local boon_template = BoonTemplates[boon_key]
		local boon_icon = boon_template.ui_icon
		local duration = self._get_readable_boon_duration(self, boon_template.duration)
		local name = boon_template.ui_name
		widget_content.texture_boon_reward_icon = boon_icon
		widget_content.boon_duration_text = duration
		widget_content.boon_name_text = name
		widget_content.has_boon_reward = true
	end

	local seed = self.quest_manager:get_random_seed_from_id(contract_id)

	if reward_quest then
		local texture_bg, texture_fg = nil
		texture_bg, seed = self._get_sigil_bg_texture(self, contract_id, false, seed)
		texture_fg, seed = self._get_sigil_fg_texture(self, contract_id, rewards.quest.quest_type, seed)
		widget_content.texture_quest_link_bg = texture_bg
		widget_content.texture_quest_link_fg = texture_fg
	end

	widget_content.background_texture = self._get_contract_background(self, seed, contract_data)

	return 
end
QuestView._set_log_contract_widget_info = function (self, widget, contract_data, contract_id)
	local widget_style = widget.style
	local widget_content = widget.content
	local requirements = contract_data.requirements
	local levels = requirements.levels
	local difficulty = requirements.difficulty
	local task = requirements.task
	local rewards = contract_data.rewards
	local tags = contract_data.tags
	local requirements_met = contract_data.requirements_met
	widget_content.expire_at = contract_data.expire_at
	widget_content.contract_id = contract_id
	widget_content.requirements_met = requirements_met
	widget_content.has_quest_link = rewards.quest ~= nil
	widget_content.quest_type = (rewards.quest and rewards.quest.quest_type) or nil
	local title = self.quest_manager:get_title_for_contract_id(contract_id)
	local font, scaled_font_size = UIFontByResolution(widget_style.title_text)
	local text_width = UIRenderer.text_size(self.ui_top_renderer, title, font[1], scaled_font_size)
	local width_percent = math.min(widget_style.title_text.size[1]/text_width, 1)
	local num_char = title.len(title)
	num_char = math.floor(num_char*width_percent - 3)

	if widget_style.title_text.size[1] < text_width then
		title = title.sub(title, 1, num_char) .. "..."
	end

	widget_content.title_text = title

	if difficulty then
		local difficulty_display_name = DifficultySettings[difficulty].display_name

		if DifficultySettings[difficulty].rank < #DefaultDifficulties then
			widget_content.difficulty_text = string.format(Localize("dlc1_3_1_quests_difficulty_text"), Localize(difficulty_display_name))
		else
			widget_content.difficulty_text = Localize(difficulty_display_name)
		end
	end

	table.clear(widget_content.texture_level_icons)

	local required_level = (levels and levels.required) or {
		"any"
	}
	local acquired_level = (levels and levels.acquired) or {}
	local num_levels = #required_level
	local level_total_width = (num_levels - 1)*widget_style.level_icon_spacing
	local image_width = 0

	for i = 1, num_levels, 1 do
		local image_name = QuestSettings.level_icon_lookup[required_level[i]] or QuestSettings.level_icon_lookup.any
		widget_content.texture_level_icons[i] = image_name

		if table.contains(acquired_level, required_level[i]) then
			widget_style.texture_level_checkmark_icons.texture_colors[i][1] = 255
			widget_content.completed_levels[i] = true
		else
			widget_style.texture_level_checkmark_icons.texture_colors[i][1] = 0
			widget_content.completed_levels[i] = false
		end

		image_width = widget_style.level_icon_size[1]
		level_total_width = level_total_width + image_width
	end

	widget_style.texture_level_checkmark_icons.draw_count = num_levels
	local x_offset = (widget_style.size[1] - level_total_width)*0.5
	widget_style.texture_level_icons.offset[1] = x_offset
	widget_style.texture_level_checkmark_icons.offset[1] = x_offset

	table.clear(widget_content.texture_task_icons)
	table.clear(widget_content.task_amount_texts.texts)

	if task then
		local i = 1
		local task_type = task.type
		local task_amount = task.amount.required
		local task_progress = task.amount.acquired
		local task_icon = QuestSettings.task_type_to_icon_lookup[task_type]
		local task_name = QuestSettings.task_type_to_task_description_lookup[task_type]
		widget_content.texture_task_icons[1] = task_icon
		widget_content.task_amount_texts.texts[1] = tostring(task_progress) .. "/" .. tostring(task_amount)
		i = i + 1
		widget_style.texture_task_checkmark_icons.draw_count = math.max(0, i - 1)
		local tasks_total_width = i*widget_style.task_icon_size[1]
		local x_offset = (widget_style.size[1] - tasks_total_width)*0.5
		widget_style.texture_task_icons.offset[1] = x_offset
		widget_style.task_amount_texts.offset[1] = x_offset + widget_style.task_icon_size[1]
		widget_style.texture_task_checkmark_icons.offset[1] = x_offset + widget_style.task_icon_size[1]*0.35

		if task_amount <= task_progress then
			widget_style.texture_task_checkmark_icons.texture_colors[1][1] = 255
			widget_content.completed_tasks[i] = true
		else
			widget_style.texture_task_checkmark_icons.texture_colors[1][1] = 0
			widget_content.completed_tasks[i] = false
		end
	end

	if rewards.quest then
		local amount_seals = rewards.quest.amount_sigils
		widget_content.quest_link_text = "x" .. tostring(amount_seals)
	end

	if rewards.quest then
		local seed = self.quest_manager:get_random_seed_from_id(contract_id)
		local texture_bg, texture_fg = nil
		texture_bg, seed = self._get_sigil_bg_texture(self, contract_id, false, seed)
		texture_fg, seed = self._get_sigil_fg_texture(self, contract_id, rewards.quest.quest_type, seed)
		widget_content.quest_link_marker_bg_texture = texture_bg
		widget_content.quest_link_marker_fg_texture = texture_fg
	end

	return 
end
QuestView._set_traits_info = function (self, item, traits)
	local trait_icon_widgets = self.trait_icon_widgets
	local tooltip_widgets = self.tooltip_widgets
	local num_total_traits = ForgeSettings.num_traits
	local number_of_traits_on_item = 0
	local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local slot_type = item.slot_type
	local is_trinket = slot_type == "trinket"
	local trait_locked = not is_trinket and slot_type ~= "hat"

	for i = 1, num_total_traits, 1 do
		local trait_name = traits and traits[i]
		local trait_widget = trait_icon_widgets[i]
		local tooltip_trait_widget = tooltip_widgets[i]
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = trait_name == nil

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
				local icon = trait_template.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_hotspot.is_selected = false
				trait_widget_hotspot.on_pressed = false
				trait_widget_content.use_background = true
				trait_widget_content.use_glow = false
			end

			trait_widget_hotspot.locked = trait_locked
			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	for i = 1, num_total_traits, 1 do
		local widget = trait_icon_widgets[i]
		widget.content.visible = (i <= number_of_traits_on_item and true) or false
		widget.content.use_background = false
		widget.content.use_glow = false
		widget.style.texture_hover_id.color[1] = 0
	end

	return 
end
QuestView._set_quest_popup_widget_info = function (self, widget, quest_id, data, is_log_quest)
	self.reset_popup_quest_values(self, widget)

	local widget_content = widget.content
	local widget_style = widget.style
	widget.content.requirements_met = data.requirements_met
	local requirements = data.requirements
	local rewards = data.rewards
	widget_content.title_text = self.quest_manager:get_title_for_quest_id(quest_id)
	widget_content.description_text = self.quest_manager:get_description_for_quest_id(quest_id)
	widget_content.has_item_reward = nil
	widget_content.has_token_reward = nil
	widget_content.has_boon_reward = nil

	table.clear(widget_content.texture_item_trait_icons)
	table.clear(widget_content.item_trait_texts.texts)

	local reward_items = rewards.items
	local reward_tokens = rewards.tokens
	local reward_boons = rewards.boons
	local item_key = nil

	if reward_items then
		local data_type = type(reward_items)

		if data_type == "string" then
			item_key = reward_items
		elseif data_type == "table" and 0 < #reward_items then
			item_key = reward_items[1]
		end
	end

	local boon_key = nil

	if reward_boons then
		local data_type = type(reward_boons)

		if data_type == "string" then
			boon_key = reward_boons
		elseif data_type == "table" and 0 < #reward_boons then
			boon_key = reward_boons[1]
		end
	end

	if item_key then
		local item = ItemMasterList[item_key]

		self._set_traits_info(self, item, item.traits)

		local draw_hero_icon = (#item.can_wield == 1 and true) or false

		if draw_hero_icon then
			local key = item.can_wield[1]
			local hero_icon_texture = UISettings.hero_icons.medium[key]
			local hero_icon_tooltip = UISettings.hero_tooltips[key]
			widget_content.texture_item_reward_hero_icon = hero_icon_texture
			self.hero_icon_tooltip.content.tooltip_text = Localize(hero_icon_tooltip)
		end

		widget_content.texture_item_reward_icon = item.inventory_icon
		widget_style.texture_item_reward_frame.color = Colors.get_table(item.rarity)
		widget_content.item_name = item.display_name
		widget_style.item_name.text_color = Colors.get_table(item.rarity)
		widget_content.item_type_text = item.item_type
		local traits = item.traits or {}

		for i = 1, #traits, 1 do
			local trait = BuffTemplates[traits[i]]
			widget_content.item_trait_texts.texts[i] = trait.display_name
		end

		self._draw_item_reward_buttons = true
		widget_content.has_item_reward = true
	elseif reward_tokens and 0 < table.size(reward_tokens) then
		local token_type = reward_tokens.type
		local token_amount = reward_tokens.amount
		local token_icon = QuestSettings.token_type_to_large_icon_lookup[token_type]
		widget_content.texture_token_reward_icon = token_icon
		widget_content.token_amount_text = "x" .. tostring(token_amount)
		widget_content.has_token_reward = true
	elseif boon_key then
		local boon_template = BoonTemplates[boon_key]
		local boon_icon = boon_template.ui_icon
		local duration = self._get_readable_boon_duration(self, boon_template.duration)
		local name = boon_template.ui_name
		widget_content.texture_boon_reward_icon = boon_icon
		widget_content.boon_duration_text = duration
		widget_content.boon_name_text = name
		widget_content.has_boon_reward = true
	end

	local required_seals = requirements.amount_sigils.required
	local acquired_seals = requirements.amount_sigils.acquired
	local num_row_1 = required_seals
	local num_row_2 = 0

	if QuestSettings.MAX_NUMBER_OF_POPUP_QUEST_LINKS_PER_ROW < num_row_1 then
		num_row_2 = num_row_1 - QuestSettings.MAX_NUMBER_OF_POPUP_QUEST_LINKS_PER_ROW
		num_row_1 = QuestSettings.MAX_NUMBER_OF_POPUP_QUEST_LINKS_PER_ROW
	end

	widget_style.texture_quest_link_marker_bg_icons_row_1.draw_count = num_row_1
	widget_style.texture_quest_link_marker_fg_icons_row_1.draw_count = num_row_1
	local quest_link_row_1_total_width = (num_row_1 - 1)*widget_style.quest_link_spacing + widget_style.quest_link_texture_size[1]*num_row_1
	local x_offset = (widget_style.canvas_size[1] - quest_link_row_1_total_width)*0.5
	widget_style.texture_quest_link_marker_bg_icons_row_1.offset[1] = widget_style.canvas_offset[1] + x_offset
	widget_style.texture_quest_link_marker_fg_icons_row_1.offset[1] = widget_style.canvas_offset[1] + x_offset
	local use_saturation = is_log_quest
	local tint_color = (is_log_quest and 150) or 255

	for i = 1, num_row_1, 1 do
		local marker_color = widget_style.texture_quest_link_marker_bg_icons_row_1.texture_colors[i]
		local seal_color = widget_style.texture_quest_link_marker_fg_icons_row_1.texture_colors[i]

		if i <= acquired_seals then
			widget_style.texture_quest_link_marker_bg_icons_row_1.texture_colors[i] = {
				255,
				255,
				255,
				255
			}
			widget_style.texture_quest_link_marker_fg_icons_row_1.texture_colors[i] = {
				255,
				255,
				255,
				255
			}
			widget_style.texture_quest_link_marker_bg_icons_row_1.texture_saturation[i] = false
			widget_style.texture_quest_link_marker_fg_icons_row_1.texture_saturation[i] = false
		else
			widget_style.texture_quest_link_marker_bg_icons_row_1.texture_colors[i] = {
				255,
				tint_color,
				tint_color,
				tint_color
			}
			widget_style.texture_quest_link_marker_fg_icons_row_1.texture_colors[i] = {
				255,
				tint_color,
				tint_color,
				tint_color
			}
			widget_style.texture_quest_link_marker_bg_icons_row_1.texture_saturation[i] = use_saturation
			widget_style.texture_quest_link_marker_fg_icons_row_1.texture_saturation[i] = use_saturation
		end
	end

	acquired_seals = acquired_seals - num_row_1
	widget_style.texture_quest_link_marker_bg_icons_row_2.draw_count = num_row_2
	widget_style.texture_quest_link_marker_fg_icons_row_2.draw_count = num_row_2
	local quest_link_row_2_total_width = (num_row_2 - 1)*widget_style.quest_link_spacing + widget_style.quest_link_texture_size[1]*num_row_2
	local x_offset = (widget_style.canvas_size[1] - quest_link_row_2_total_width)*0.5
	widget_style.texture_quest_link_marker_bg_icons_row_2.offset[1] = widget_style.canvas_offset[1] + x_offset
	widget_style.texture_quest_link_marker_fg_icons_row_2.offset[1] = widget_style.canvas_offset[1] + x_offset
	local use_saturation = is_log_quest
	local tint_color = (is_log_quest and 150) or 255

	for i = 1, num_row_1, 1 do
		if i <= acquired_seals then
			widget_style.texture_quest_link_marker_bg_icons_row_2.texture_colors[i] = {
				255,
				255,
				255,
				255
			}
			widget_style.texture_quest_link_marker_fg_icons_row_2.texture_colors[i] = {
				255,
				255,
				255,
				255
			}
			widget_style.texture_quest_link_marker_bg_icons_row_2.texture_saturation[i] = false
			widget_style.texture_quest_link_marker_fg_icons_row_2.texture_saturation[i] = false
		else
			widget_style.texture_quest_link_marker_bg_icons_row_2.texture_colors[i] = {
				255,
				tint_color,
				tint_color,
				tint_color
			}
			widget_style.texture_quest_link_marker_fg_icons_row_2.texture_colors[i] = {
				255,
				tint_color,
				tint_color,
				tint_color
			}
			widget_style.texture_quest_link_marker_bg_icons_row_2.texture_saturation[i] = use_saturation
			widget_style.texture_quest_link_marker_fg_icons_row_2.texture_saturation[i] = use_saturation
		end
	end

	local seed = self.quest_manager:get_random_seed_from_id(quest_id)
	local bg_texture_1, bg_texture_2, fg_texture_1, fg_texture_2 = nil

	for i = 1, QuestSettings.MAX_NUMBER_OF_POPUP_QUEST_LINKS_PER_ROW, 1 do
		bg_texture_1, seed = self._get_sigil_bg_texture(self, quest_id, true, seed)
		bg_texture_2, seed = self._get_sigil_bg_texture(self, quest_id, true, seed)
		fg_texture_1, seed = self._get_sigil_fg_texture(self, quest_id, data.type, seed)
		fg_texture_2, seed = self._get_sigil_fg_texture(self, quest_id, data.type, seed)
		widget_content.texture_quest_link_marker_bg_icons_row_1[i] = bg_texture_1
		widget_content.texture_quest_link_marker_bg_icons_row_2[i] = bg_texture_2
		widget_content.texture_quest_link_marker_fg_icons_row_1[i] = fg_texture_1
		widget_content.texture_quest_link_marker_fg_icons_row_2[i] = fg_texture_2
	end

	widget_content.background_texture = self._get_quest_popup_background(self, seed, data)

	return 
end
QuestView._spawn_contract_popup = function (self, contract_id, is_log_quest)
	self.play_sound(self, "Play_hud_quest_menu_select_quest")

	local contract_data = self.quest_manager:get_contract_by_id(contract_id)
	local is_log_full = false

	if not is_log_quest then
		is_log_full = self._is_contract_log_full(self)
	end

	local popup_widget = self._set_contract_popup_data(self, contract_data, is_log_full, is_log_quest, contract_id)
	popup_widget.content.quest_id = nil
	popup_widget.content.contract_id = contract_id
	popup_widget.content.expire_at = contract_data.expire_at
	self.active_popup_widget = popup_widget
	self.draw_detailed_popup = true

	self.set_input_blocked(self, true)

	return 
end
QuestView._spawn_quest_popup = function (self, quest_id, is_log_quest)
	self.play_sound(self, "Play_hud_quest_menu_select_quest")

	local quest_data = self.quest_manager:get_quest_by_id(quest_id)
	local is_log_full = false

	if not is_log_quest then
		is_log_full = self._is_quest_log_full(self)
	end

	local popup_widget = self._set_quest_popup_data(self, quest_data, is_log_full, is_log_quest, quest_id)
	popup_widget.content.quest_id = quest_id
	popup_widget.content.contract_id = nil
	popup_widget.content.expire_at = quest_data.expire_at
	self.active_popup_widget = popup_widget
	self.draw_detailed_popup = true

	self.set_input_blocked(self, true)

	return 
end
QuestView._set_contract_popup_data = function (self, data, is_log_full, is_log_quest, contract_id)
	self.hide_popup_buttons(self, false)

	local requirements_met = self.quest_manager:is_contract_requirements_met_by_id(contract_id) or false
	local detail_popup_widgets = self.detail_popup_widgets
	detail_popup_widgets.detail_popup_decline_button.content.visible = is_log_quest == true and not requirements_met and not data.locked
	detail_popup_widgets.detail_popup_turn_in_button.content.visible = is_log_quest == true and requirements_met
	detail_popup_widgets.detail_popup_accept_button.content.visible = not is_log_quest
	detail_popup_widgets.detail_popup_accept_button.content.button_hotspot.disabled = is_log_full
	detail_popup_widgets.detail_popup_accept_tooltip.content.visible = is_log_full
	detail_popup_widgets.detail_popup_accept_tooltip.content.tooltip_text = "dlc1_3_1_contract_log_full"
	local expire_at = data.expire_at or 0
	local expired = self.quest_manager:has_time_expired(expire_at)

	if expired then
		detail_popup_widgets.detail_popup_decline_button.content.text_field = "dlc1_3_1_discard"
	else
		detail_popup_widgets.detail_popup_decline_button.content.text_field = "dlc1_3_1_decline"
	end

	local background_texture = self._get_contract_background(self, contract_id, data)
	local widget = self.popup_widgets[background_texture]

	self._set_contract_popup_widget_info(self, widget, data, contract_id)

	return widget
end
QuestView._set_quest_popup_data = function (self, data, is_log_full, is_log_quest, quest_id)
	self.hide_popup_buttons(self, false)

	local requirements_met = self.quest_manager:is_quest_requirements_met_by_id(quest_id) or false
	local detail_popup_widgets = self.detail_popup_widgets
	detail_popup_widgets.detail_popup_decline_button.content.visible = is_log_quest == true and not requirements_met and not data.locked
	detail_popup_widgets.detail_popup_turn_in_button.content.visible = is_log_quest == true and requirements_met
	detail_popup_widgets.detail_popup_accept_button.content.visible = not is_log_quest
	detail_popup_widgets.detail_popup_accept_button.content.button_hotspot.disabled = is_log_full
	detail_popup_widgets.detail_popup_accept_tooltip.content.visible = is_log_full
	detail_popup_widgets.detail_popup_accept_tooltip.content.tooltip_text = "dlc1_3_1_quest_log_full"
	local expire_at = data.expire_at or 0
	local expired = self.quest_manager:has_time_expired(expire_at)

	if expired then
		detail_popup_widgets.detail_popup_decline_button.content.text_field = "dlc1_3_1_discard"
	else
		detail_popup_widgets.detail_popup_decline_button.content.text_field = "dlc1_3_1_decline"
	end

	local widget = self.quest_popup_widget

	self._set_quest_popup_widget_info(self, widget, quest_id, data, is_log_quest)

	return widget
end
QuestView.close_detailed_popup = function (self)
	self._draw_item_reward_buttons = nil
	self.draw_detailed_popup = nil
	self.active_popup_widget = nil

	self.set_input_blocked(self, nil)

	return 
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
QuestView._get_sigil_fg_texture = function (self, id, quest_type, start_seed)
	quest_type = quest_type or "main"

	if QuestSettings.num_sigils_per_dlc[quest_type] then
		local num_variants = QuestSettings.num_sigils_per_dlc[quest_type]
		local seed, value = Math.next_random(start_seed, num_variants)
		seed, value = Math.next_random(seed, num_variants)
		local index = (value < 10 and "0" .. tostring(value)) or tostring(value)
		local texture = "quest_link_marker_fg_" .. quest_type .. "_" .. index

		return texture, seed
	end

	return "quest_link_marker_fg_main_01"
end
QuestView._get_sigil_bg_texture = function (self, id, with_text, start_seed)
	local seed, value = Math.next_random(start_seed, QuestSettings.NUMBER_OF_SEAL_VARIATIONS_BG)
	seed, value = Math.next_random(seed, QuestSettings.NUMBER_OF_SEAL_VARIATIONS_BG)
	local index = (value < 10 and "0" .. tostring(value)) or tostring(value)
	local texture = ((with_text and "quest_link_marker_bg_") or "quest_link_marker_no_text_bg_") .. index

	return texture, seed
end
QuestView._get_contract_background = function (self, contract_id)
	local num_backgrounds = #QuestSettings.contract_bg_texture_names
	local seed, value = Math.next_random(contract_id, num_backgrounds)
	local seed, texture_index = Math.next_random(seed, num_backgrounds)
	local background_texture = QuestSettings.contract_bg_texture_names[texture_index]

	return background_texture
end
QuestView._get_contract_background_corners = function (self, contract_id)
	local background_texture = self._get_contract_background(self, contract_id)

	return {
		background_texture .. "_corner_01",
		background_texture .. "_corner_02",
		background_texture .. "_corner_03",
		background_texture .. "_corner_04"
	}
end
QuestView._get_quest_background = function (self, quest_id)
	local num_backgrounds = #QuestSettings.quest_bg_texture_names
	local seed, value = Math.next_random(quest_id, num_backgrounds)
	local seed, texture_index = Math.next_random(seed, num_backgrounds)
	local background_texture = QuestSettings.quest_bg_texture_names[texture_index]

	return background_texture
end
QuestView._get_quest_popup_background = function (self, quest_id)
	local num_backgrounds = #QuestSettings.quest_popup_bg_texture_names
	local seed, value = Math.next_random(quest_id, num_backgrounds)
	local seed, texture_index = Math.next_random(seed, num_backgrounds)
	local background_texture = QuestSettings.quest_popup_bg_texture_names[texture_index]

	return background_texture
end
QuestView.on_gamepad_activated = function (self)
	self.exit_button_widget.content.visible = false
	self.previous_page_button_widget.content.visible = false
	self.next_page_button_widget.content.visible = false
	local gamepad_grid_data = self.gamepad_grid_data

	if not gamepad_grid_data.selected_entry then
		self._set_new_gamepad_grid_selection(self, gamepad_grid_data.start_entry)
	end

	return 
end
QuestView.on_gamepad_deactivated = function (self)
	self.exit_button_widget.content.visible = true
	self.previous_page_button_widget.content.visible = self._has_dlc
	self.next_page_button_widget.content.visible = self._has_dlc

	return 
end
QuestView.update_input_description = function (self)
	local actions_name_to_use = nil

	if self.draw_detailed_popup then
		local detail_popup_widgets = self.detail_popup_widgets
		local popup_full = detail_popup_widgets.detail_popup_accept_tooltip.content.visible

		if popup_full then
			actions_name_to_use = "popup_full"
		else
			local detail_popup_accept_button = detail_popup_widgets.detail_popup_accept_button
			local detail_popup_decline_button = detail_popup_widgets.detail_popup_decline_button
			local detail_popup_turn_in_button = detail_popup_widgets.detail_popup_turn_in_button
			local decline_visible = detail_popup_decline_button.content.visible ~= false
			local turn_in_visible = detail_popup_turn_in_button.content.visible ~= false
			local accept_visible = detail_popup_accept_button.content.visible ~= false

			if turn_in_visible then
				actions_name_to_use = "popup_turn_in"
			elseif decline_visible then
				actions_name_to_use = "popup_decline"
			elseif accept_visible then
				actions_name_to_use = "popup_accept"
			end
		end
	else
		local gamepad_selected_widget = self.gamepad_selected_widget

		if gamepad_selected_widget then
			if self._has_dlc then
				actions_name_to_use = "selection_dlc"
			else
				actions_name_to_use = "selection"
			end
		end
	end

	actions_name_to_use = actions_name_to_use or (self._has_dlc and "default_dlc") or "default"

	if not self.gamepad_active_actions_name or self.gamepad_active_actions_name ~= actions_name_to_use then
		self.gamepad_active_actions_name = actions_name_to_use
		input_description_data.actions = input_actions[actions_name_to_use]

		self.menu_input_description:set_input_description(input_description_data)
	end

	return 
end
QuestView._handle_gamepad_navigation = function (self, input_service, dt)
	if self.draw_detailed_popup then
		return 
	end

	local gamepad_grid_data = self.gamepad_grid_data
	local grid = gamepad_grid_data.grid
	local selected_entry = gamepad_grid_data.selected_entry
	local new_grid_key = nil
	local slot_data = selected_entry and grid[selected_entry]

	if slot_data then
		local actions = slot_data.actions

		for input_action, grid_key in pairs(actions) do
			if input_service.get(input_service, input_action) then
				new_grid_key = grid_key

				break
			end
		end
	end

	if new_grid_key then
		self._set_new_gamepad_grid_selection(self, new_grid_key)
	end

	return 
end
QuestView._set_new_gamepad_grid_selection = function (self, key)
	local gamepad_grid_data = self.gamepad_grid_data
	local grid = gamepad_grid_data.grid
	local gamepad_selected_widget = nil
	local new_slot_data = grid[key]
	local scenegraph_id = new_slot_data.scenegraph_id
	local selection_widget = new_slot_data.selection_widget
	selection_widget.scenegraph_id = scenegraph_id
	gamepad_grid_data.selected_entry = key
	self.gamepad_selection_widget = selection_widget
	local widget_index = new_slot_data.widget_index
	local widget_table = new_slot_data.widget_table
	local page_index = self._page_index
	local table_widgets = widget_table[page_index]

	if not widget_index and table_widgets then
		for index, widget in ipairs(table_widgets) do
			if widget.scenegraph_id == scenegraph_id then
				gamepad_selected_widget = widget

				if widget.style.canvas_offset then
					selection_widget.style.gamepad_glow_1.offset[1] = (selection_widget.style.gamepad_glow_1.base_offset[1] + widget.style.canvas_offset[1]) - 20
					selection_widget.style.gamepad_glow_1.offset[2] = (selection_widget.style.gamepad_glow_1.base_offset[2] + widget.style.canvas_offset[2]) - 20
					selection_widget.style.gamepad_glow_2.offset[1] = (selection_widget.style.gamepad_glow_2.base_offset[1] + widget.style.canvas_offset[1]) - 20
					selection_widget.style.gamepad_glow_2.offset[2] = (selection_widget.style.gamepad_glow_2.base_offset[2] + widget.style.canvas_offset[2]) - 20
					selection_widget.style.gamepad_glow_3.offset[1] = (selection_widget.style.gamepad_glow_3.base_offset[1] + widget.style.canvas_offset[1]) - 20
					selection_widget.style.gamepad_glow_3.offset[2] = (selection_widget.style.gamepad_glow_3.base_offset[2] + widget.style.canvas_offset[2]) - 20
					selection_widget.style.gamepad_glow_4.offset[1] = (selection_widget.style.gamepad_glow_4.base_offset[1] + widget.style.canvas_offset[1]) - 20
					selection_widget.style.gamepad_glow_4.offset[2] = (selection_widget.style.gamepad_glow_4.base_offset[2] + widget.style.canvas_offset[2]) - 20
				end

				break
			end
		end
	else
		gamepad_selected_widget = table_widgets and table_widgets[widget_index]
	end

	self.gamepad_selected_widget = gamepad_selected_widget and gamepad_selected_widget.content.enabled and gamepad_selected_widget

	return 
end
QuestView.handle_gamepad_input = function (self, dt)
	local gamepad_input_pressed = self.gamepad_input_pressed
	gamepad_input_pressed.confirm = nil
	gamepad_input_pressed.back = nil

	if gamepad_input_pressed.cycle_previous or gamepad_input_pressed.cycle_next then
		self._set_new_gamepad_grid_selection(self, self.gamepad_grid_data.selected_entry)
	end

	gamepad_input_pressed.cycle_previous = nil
	gamepad_input_pressed.cycle_next = nil

	self.update_input_description(self)

	local input_service = self.input_manager:get_service("quest_view")
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	else
		if self._handle_gamepad_navigation(self, input_service, dt) then
			self.controller_cooldown = GamepadSettings.menu_cooldown

			return 
		end

		if input_service.get(input_service, "confirm") then
			self.gamepad_input_pressed.confirm = true
			self.controller_cooldown = GamepadSettings.menu_cooldown

			return 
		end

		if input_service.get(input_service, "back") then
			self.gamepad_input_pressed.back = true
			self.controller_cooldown = GamepadSettings.menu_cooldown

			return 
		end

		if self._has_dlc then
			if input_service.get(input_service, "cycle_previous") then
				self.gamepad_input_pressed.cycle_previous = true
				self.controller_cooldown = GamepadSettings.menu_cooldown

				return 
			end

			if input_service.get(input_service, "cycle_next") then
				self.gamepad_input_pressed.cycle_next = true
				self.controller_cooldown = GamepadSettings.menu_cooldown

				return 
			end
		end
	end

	return 
end
QuestView.fade_out_popup_quest = function (self, fade_background)
	local widget = self.quest_popup_widget
	local complete_texture_color = widget.style.complete_texture.color
	local title_text_color = widget.style.title_text.text_color
	local description_text_color = widget.style.description_text.text_color
	local reward_title_text_color = widget.style.reward_title_text.text_color
	local item_bg_texture_color = widget.style.item_bg_texture.color
	local texture_item_reward_hero_icon_color = widget.style.texture_item_reward_hero_icon.color
	local texture_item_reward_icon_color = widget.style.texture_item_reward_icon.color
	local texture_item_reward_frame_color = widget.style.texture_item_reward_frame.color
	local item_name_color = widget.style.item_name.text_color
	local item_type_text_color = widget.style.item_type_text.text_color
	local texture_item_trait_icons_color = widget.style.texture_item_trait_icons.color
	local item_trait_texts_color = widget.style.item_trait_texts.text_color
	local token_bg_texture_color = widget.style.token_bg_texture.color
	local texture_token_reward_icon_color = widget.style.texture_token_reward_icon.color
	local token_amount_text_color = widget.style.token_amount_text.text_color
	local boon_bg_texture_color = widget.style.boon_bg_texture.color
	local texture_boon_reward_icon_color = widget.style.texture_boon_reward_icon.color
	local boon_name_text_color = widget.style.boon_name_text.text_color
	local boon_duration_text_color = widget.style.boon_duration_text.text_color
	local texture_reward_divider_color = widget.style.texture_reward_divider.color
	local requirements_title_text_color = widget.style.requirements_title_text.text_color
	local texture_quest_link_marker_bg_icons_row_1_colors = widget.style.texture_quest_link_marker_bg_icons_row_1.texture_colors
	local texture_quest_link_marker_bg_icons_row_2_colors = widget.style.texture_quest_link_marker_bg_icons_row_2.texture_colors
	local texture_quest_link_marker_fg_icons_row_1_colors = widget.style.texture_quest_link_marker_fg_icons_row_1.texture_colors
	local texture_quest_link_marker_fg_icons_row_2_colors = widget.style.texture_quest_link_marker_fg_icons_row_2.texture_colors
	local texture_id_color = widget.style.texture_id.color
	local trait_button_widget_colors = {}
	local trait_icon_widgets = self.trait_icon_widgets
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local trait_widget = trait_icon_widgets[i]
		trait_button_widget_colors[i] = {
			trait_widget.style.texture_bg_id.color,
			trait_widget.style.texture_id.color,
			trait_widget.style.texture_hover_id.color,
			trait_widget.style.texture_selected_id.color,
			trait_widget.style.texture_lock_id.color,
			trait_widget.style.texture_glow_id.color,
			trait_widget.style.texture_trait_cover_id.color
		}
	end

	local animation_name = "fade_out_popup_quest"
	local animation_time = 0.2
	local wait_time = 0.1
	local from = 255
	local to = 0
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, complete_texture_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, title_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, description_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, reward_title_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, item_bg_texture_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_06"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_item_reward_hero_icon_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_07"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_item_reward_icon_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_08"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_item_reward_frame_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_09"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, item_name_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_00"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, item_type_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_11"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_item_trait_icons_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_12"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, item_trait_texts_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_13"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, token_bg_texture_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_14"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_token_reward_icon_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_15"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, token_amount_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_16"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, boon_bg_texture_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_17"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_boon_reward_icon_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_18"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, boon_name_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_19"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, boon_duration_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_20"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_reward_divider_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_21"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, requirements_title_text_color, 1, from, to, animation_time, math.easeOutCubic)

	for i = 1, QuestSettings.MAX_NUMBER_OF_POPUP_QUEST_LINKS_PER_ROW, 1 do
		ui_animations[animation_name .. "_22_" .. tostring(i)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_marker_bg_icons_row_1_colors[i], 1, from, to, animation_time, math.easeOutCubic)
		ui_animations[animation_name .. "_23_" .. tostring(i)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_marker_bg_icons_row_2_colors[i], 1, from, to, animation_time, math.easeOutCubic)
		ui_animations[animation_name .. "_24_" .. tostring(i)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_marker_fg_icons_row_1_colors[i], 1, from, to, animation_time, math.easeOutCubic)
		ui_animations[animation_name .. "_25_" .. tostring(i)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_marker_fg_icons_row_2_colors[i], 1, from, to, animation_time, math.easeOutCubic)
	end

	if fade_background then
		ui_animations[animation_name .. "_25"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_id_color, 1, from, to, animation_time, math.easeOutCubic)
	end

	for i = 1, num_total_traits, 1 do
		local trait_button_colors = trait_button_widget_colors[i]

		for j = 1, #trait_button_colors, 1 do
			ui_animations[animation_name .. "_26_" .. tostring(i) .. "_" .. tostring(j)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_button_widget_colors[i][j], 1, from, to, animation_time, math.easeOutCubic)
		end
	end

	return 
end
QuestView.fade_board_quest = function (self, quest_id, animation_time, wait_time, from, to)
	local widget = self._get_board_widget_for_quest_id(self, quest_id)
	local quest_link_marker_bg_texture_color = widget.style.quest_link_marker_bg_texture.color
	local quest_link_marker_fg_texture_color = widget.style.quest_link_marker_fg_texture.color
	local quest_link_text_color = widget.style.quest_link_text.text_color
	local reward_bg_color = widget.style.reward_bg.color
	local reward_icon_color = widget.style.reward_icon.color
	local item_reward_frame_color = widget.style.item_reward_frame.color
	local texture_id_color = widget.style.texture_id.color
	local texture_hover_id_top_color = widget.style.texture_hover_id_top.color
	local texture_selected_id_top_color = widget.style.texture_selected_id_top.color
	local texture_hover_id_bottom_color = widget.style.texture_hover_id_bottom.color
	local texture_selected_id_bottom_color = widget.style.texture_selected_id_bottom.color
	quest_link_marker_bg_texture_color[1] = from
	quest_link_marker_fg_texture_color[1] = from
	quest_link_text_color[1] = from
	reward_bg_color[1] = from
	reward_icon_color[1] = from
	item_reward_frame_color[1] = from
	texture_id_color[1] = from
	local hover_from = (from == 255 and 190) or from
	local hover_to = (to == 255 and 190) or to
	texture_hover_id_top_color[1] = hover_from
	texture_selected_id_top_color[1] = from
	texture_hover_id_bottom_color[1] = hover_from
	texture_selected_id_bottom_color[1] = from
	local animation_name = "fade_board_quest"
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_marker_bg_texture_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_marker_fg_texture_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, reward_bg_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, reward_icon_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_06"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, item_reward_frame_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_07"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_id_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_08"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_hover_id_top_color, 1, hover_from, hover_to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_09"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_selected_id_top_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_10"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_hover_id_bottom_color, 1, hover_from, hover_to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_11"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_selected_id_bottom_color, 1, from, to, animation_time, math.easeInCubic)

	return 
end
QuestView.fade_in_board_quest = function (self, quest_id)
	self.fade_board_quest(self, quest_id, 0.15, 0, 0, 255)

	return 
end
QuestView.fade_out_board_quest = function (self, quest_id)
	self.fade_board_quest(self, quest_id, 0.15, 0, 255, 0)

	return 
end
QuestView.fade_log_quest = function (self, quest_id, animation_time, wait_time, from, to)
	local widget = self._get_log_widget_for_quest_id(self, quest_id)
	local title_text_color = widget.style.title_text.text_color
	local reward_bg_color = widget.style.reward_bg.color
	local reward_icon_color = widget.style.reward_icon.color
	local item_reward_frame_color = widget.style.item_reward_frame.color
	local texture_quest_link_marker_bg_color = widget.style.texture_quest_link_marker_bg.color
	local texture_quest_link_marker_fg_color = widget.style.texture_quest_link_marker_fg.color
	local quest_link_text_color = widget.style.quest_link_text.text_color
	local texture_id_color = widget.style.texture_id.color
	local background_complete_texture_color = widget.style.background_complete_texture.color
	local texture_hover_id_top_color = widget.style.texture_hover_id_top.color
	local texture_selected_id_top_color = widget.style.texture_selected_id_top.color
	local texture_hover_id_bottom_color = widget.style.texture_hover_id_bottom.color
	local texture_selected_id_bottom_color = widget.style.texture_selected_id_bottom.color
	title_text_color[1] = from
	reward_bg_color[1] = from
	reward_icon_color[1] = from
	item_reward_frame_color[1] = from
	texture_quest_link_marker_bg_color[1] = from
	texture_quest_link_marker_fg_color[1] = from
	quest_link_text_color[1] = from
	texture_id_color[1] = from
	background_complete_texture_color[1] = from
	local hover_from = (from == 255 and 190) or from
	local hover_to = (to == 255 and 190) or to
	texture_hover_id_top_color[1] = hover_from
	texture_selected_id_top_color[1] = from
	texture_hover_id_bottom_color[1] = hover_from
	texture_selected_id_bottom_color[1] = from
	local animation_name = "fade_log_quest"
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, title_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, reward_bg_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, reward_icon_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, item_reward_frame_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_marker_bg_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_06"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_marker_fg_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_07"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_08"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_id_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_09"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, background_complete_texture_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_10"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_hover_id_top_color, 1, hover_from, hover_to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_11"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_selected_id_top_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_12"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_hover_id_bottom_color, 1, hover_from, hover_to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_13"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_selected_id_bottom_color, 1, from, to, animation_time, math.easeInCubic)

	return 
end
QuestView.fade_in_log_quest = function (self, quest_id)
	self.fade_log_quest(self, quest_id, 0.15, 0, 0, 255)

	return 
end
QuestView.fade_out_log_quest = function (self, quest_id)
	self.fade_log_quest(self, quest_id, 0.15, 0, 255, 0)

	return 
end
QuestView.move_popup_quest_to_board = function (self, quest_id)
	local popup_widget = self.quest_popup_widget
	local board_widget = self._get_board_widget_for_quest_id(self, quest_id)
	local board_world_position = UISceneGraph.get_world_position(self.ui_scenegraph, board_widget.scenegraph_id)
	local bg_size = popup_widget.style.texture_id.size
	local bg_offset = popup_widget.style.texture_id.offset
	local bg_color = popup_widget.style.texture_id.color
	local animation_name = "move_popup_quest_to_board"
	local animation_time = 0.3
	local wait_time = 0.3
	local fade_animation_time = 0.2
	local fade_wait_time = 0.4
	local size_from = table.clone(popup_widget.style.background_size)
	local size_to = QuestSettings.QUEST_LOG_WIDGET_SIZE
	local offset_from = table.clone(popup_widget.style.background_offset)
	local offset_to = {
		board_world_position[1],
		board_world_position[2]
	}
	local color_from = 255
	local color_to = 0
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_size, 1, size_from[1], size_to[1], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_size, 2, size_from[2], size_to[2], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_offset, 1, offset_from[1], offset_to[1], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_offset, 2, offset_from[2], offset_to[2], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, fade_wait_time, UIAnimation.function_by_time, bg_color, 1, color_from, color_to, fade_animation_time, math.easeOutCubic)

	return 
end
QuestView.move_popup_quest_to_log = function (self)
	local widget = self.quest_popup_widget
	local bg_size = widget.style.texture_id.size
	local bg_offset = widget.style.texture_id.offset
	local bg_color = widget.style.texture_id.color
	local animation_name = "move_popup_quest_to_log"
	local animation_time = 0.3
	local wait_time = 0.3
	local fade_animation_time = 0.2
	local fade_wait_time = 0.4
	local size_from = table.clone(widget.style.background_size)
	local size_to = QuestSettings.QUEST_LOG_WIDGET_SIZE
	local offset_from = table.clone(widget.style.background_offset)
	local offset_to = {
		QuestSettings.QUEST_LOG_WIDGET_SIZE[1] - 1920 - 40,
		QuestSettings.QUEST_LOG_WIDGET_SIZE[2] - 1080 - 40
	}
	local color_from = 255
	local color_to = 0
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_size, 1, size_from[1], size_to[1], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_size, 2, size_from[2], size_to[2], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_offset, 1, offset_from[1], offset_to[1], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_offset, 2, offset_from[2], offset_to[2], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, fade_wait_time, UIAnimation.function_by_time, bg_color, 1, color_from, color_to, fade_animation_time, math.easeOutCubic)

	return 
end
QuestView.reset_popup_quest_values = function (self, widget)
	local widget_style = widget.style
	widget_style.complete_texture.color[1] = 255
	widget_style.title_text.text_color[1] = 255
	widget_style.description_text.text_color[1] = 255
	widget_style.reward_title_text.text_color[1] = 255
	widget_style.item_bg_texture.color[1] = 255
	widget_style.texture_item_reward_hero_icon.color[1] = 255
	widget_style.texture_item_reward_icon.color[1] = 255
	widget_style.texture_item_reward_frame.color[1] = 255
	widget_style.item_name.text_color[1] = 255
	widget_style.item_type_text.text_color[1] = 255
	widget_style.texture_item_trait_icons.color[1] = 255
	widget_style.item_trait_texts.text_color[1] = 255
	widget_style.token_bg_texture.color[1] = 255
	widget_style.texture_token_reward_icon.color[1] = 255
	widget_style.token_amount_text.text_color[1] = 255
	widget_style.boon_bg_texture.color[1] = 255
	widget_style.texture_boon_reward_icon.color[1] = 255
	widget_style.boon_name_text.text_color[1] = 255
	widget_style.boon_duration_text.text_color[1] = 255
	widget_style.texture_reward_divider.color[1] = 255
	widget_style.requirements_title_text.text_color[1] = 255

	for i = 1, QuestSettings.MAX_NUMBER_OF_POPUP_QUEST_LINKS_PER_ROW, 1 do
		widget_style.texture_quest_link_marker_bg_icons_row_1.texture_colors[i][1] = 255
		widget_style.texture_quest_link_marker_bg_icons_row_2.texture_colors[i][1] = 255
		widget_style.texture_quest_link_marker_fg_icons_row_1.texture_colors[i][1] = 255
		widget_style.texture_quest_link_marker_fg_icons_row_2.texture_colors[i][1] = 255
	end

	local trait_button_widget_colors = {}
	local trait_icon_widgets = self.trait_icon_widgets
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local trait_widget = trait_icon_widgets[i]
		trait_widget.style.texture_bg_id.color[1] = 255
		trait_widget.style.texture_id.color[1] = 255
		trait_widget.style.texture_hover_id.color[1] = 255
		trait_widget.style.texture_selected_id.color[1] = 255
		trait_widget.style.texture_lock_id.color[1] = 255
		trait_widget.style.texture_glow_id.color[1] = 255
		trait_widget.style.texture_trait_cover_id.color[1] = 255
	end

	widget_style.texture_id.size = table.clone(widget.style.background_size)
	widget_style.texture_id.offset = table.clone(widget.style.background_offset)
	widget_style.texture_id.color[1] = 255

	return 
end
QuestView.flash_log_quest = function (self, quest_id)
	local widget = self._get_log_widget_for_quest_id(self, quest_id)

	self.flash_quest(self, widget)

	return 
end
QuestView.flash_board_quest = function (self, quest_id)
	local widget = self._get_board_widget_for_quest_id(self, quest_id)

	self.flash_quest(self, widget)

	return 
end
QuestView.flash_quest = function (self, widget)
	local top_flash = widget.style.texture_flashing_id_top.color
	local bottom_flash = widget.style.texture_flashing_id_bottom.color
	local animation_name = "flash_quest"
	local animation_time = 0.25
	local wait_time = 0.35
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, top_flash, 1, 0, 255, animation_time, math.easeCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time + animation_time, UIAnimation.function_by_time, top_flash, 1, 255, 0, animation_time, math.easeCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bottom_flash, 1, 0, 255, animation_time, math.easeCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time + animation_time, UIAnimation.function_by_time, bottom_flash, 1, 255, 0, animation_time, math.easeCubic)

	return 
end
QuestView.quest_moving = function (self)
	local ui_animations = self.ui_animations

	return ((ui_animations.move_popup_quest_to_board_01 or ui_animations.move_popup_quest_to_log_01) and true) or false
end
QuestView.quest_fading = function (self)
	local ui_animations = self.ui_animations

	return (ui_animations.fade_out_popup_quest_01 and true) or false
end
QuestView.fade_out_popup_contract = function (self, contract_id, fade_background)
	local background_texture = self._get_contract_background(self, contract_id)
	local widget = self.popup_widgets[background_texture]
	local title_text_color = widget.style.title_text.text_color
	local description_text_color = widget.style.description_text.text_color
	local level_title_text_color = widget.style.level_title_text.text_color
	local texture_level_title_bg_color = widget.style.texture_level_title_bg.color
	local difficulty_text_color = widget.style.difficulty_text.text_color
	local texture_level_icons_color = widget.style.texture_level_icons.color
	local level_name_texts_color = widget.style.level_name_texts.text_color
	local texture_level_checkmark_icons_colors = widget.style.texture_level_checkmark_icons.texture_colors
	local task_title_text_color = widget.style.task_title_text.text_color
	local texture_tasks_title_bg_color = widget.style.texture_tasks_title_bg.color
	local texture_task_icons_color = widget.style.texture_task_icons.color
	local texture_task_checkmark_icons_colors = widget.style.texture_task_checkmark_icons.texture_colors
	local task_amount_texts_color = widget.style.task_amount_texts.text_color
	local task_progress_texts_color = widget.style.task_progress_texts.text_color
	local task_name_texts_color = widget.style.task_name_texts.text_color
	local reward_title_text_color = widget.style.reward_title_text.text_color
	local texture_reward_bg_color = widget.style.texture_reward_bg.color
	local texture_token_reward_icon_color = widget.style.texture_token_reward_icon.color
	local reward_amount_text_color = widget.style.reward_amount_text.text_color
	local texture_boon_reward_icon_color = widget.style.texture_boon_reward_icon.color
	local boon_duration_text_color = widget.style.boon_duration_text.text_color
	local boon_name_text_color = widget.style.boon_name_text.text_color
	local texture_quest_link_bg_color = widget.style.texture_quest_link_bg.color
	local texture_quest_link_fg_color = widget.style.texture_quest_link_fg.color
	local quest_link_text_color = widget.style.quest_link_text.text_color
	local complete_texture_color = widget.style.complete_texture.color
	local texture_id_color = widget.style.texture_id.color
	local animation_name = "fade_out_popup_contract"
	local animation_time = 0.2
	local wait_time = 0.1
	local level_checkmarks_from = {}
	local task_checkmarks_from = {}

	for i = 1, 3, 1 do
		level_checkmarks_from[i] = (widget.content.completed_levels[i] and 255) or 0
	end

	for i = 1, 3, 1 do
		task_checkmarks_from[i] = (widget.content.completed_tasks[i] and 255) or 0
	end

	local from = 255
	local to = 0
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, title_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, description_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, level_title_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_level_title_bg_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, difficulty_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_06"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_level_icons_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_07"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, level_name_texts_color, 1, from, to, animation_time, math.easeOutCubic)

	for i = 1, 3, 1 do
		ui_animations[animation_name .. "_08_" .. tostring(i)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_level_checkmark_icons_colors[i], 1, level_checkmarks_from[i], to, animation_time, math.easeOutCubic)
	end

	ui_animations[animation_name .. "_09"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, task_title_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_10"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_tasks_title_bg_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_11"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_task_icons_color, 1, from, to, animation_time, math.easeOutCubic)

	for i = 1, 3, 1 do
		ui_animations[animation_name .. "_12_" .. tostring(i)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_task_checkmark_icons_colors[i], 1, task_checkmarks_from[i], to, animation_time, math.easeOutCubic)
	end

	ui_animations[animation_name .. "_13"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, task_amount_texts_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_14"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, task_progress_texts_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_15"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, task_name_texts_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_16"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, reward_title_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_17"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_reward_bg_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_18"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_token_reward_icon_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_19"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, reward_amount_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_20"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_boon_reward_icon_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_21"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, boon_duration_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_22"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, boon_name_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_23"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_bg_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_24"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_fg_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_25"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_text_color, 1, from, to, animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_26"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, complete_texture_color, 1, from, to, animation_time, math.easeOutCubic)

	if fade_background then
		ui_animations[animation_name .. "_27"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_id_color, 1, from, to, animation_time, math.easeOutCubic)
	end

	return 
end
QuestView.fade_in_board_contract = function (self, contract_id)
	self.fade_board_contract(self, contract_id, 0.15, 0, 0, 255)

	return 
end
QuestView.fade_out_board_contract = function (self, contract_id)
	self.fade_board_contract(self, contract_id, 0.15, 0, 255, 0)

	return 
end
QuestView.fade_board_contract = function (self, contract_id, animation_time, wait_time, from, to)
	local widget = self._get_board_widget_for_contract_id(self, contract_id)
	local title_text_color = widget.style.title_text.text_color
	local texture_title_divider_color = widget.style.texture_title_divider.color
	local texture_level_icons_color = widget.style.texture_level_icons.color
	local texture_level_divider_color = widget.style.texture_level_divider.color
	local texture_task_icons_color = widget.style.texture_task_icons.color
	local task_amount_texts_color = widget.style.task_amount_texts.text_color
	local texture_tasks_divider_color = widget.style.texture_tasks_divider.color
	local texture_token_reward_icon_color = widget.style.texture_token_reward_icon.color
	local reward_amount_text_color = widget.style.reward_amount_text.text_color
	local texture_reward_bg_color = widget.style.texture_reward_bg.color
	local texture_quest_link_bg_color = widget.style.texture_quest_link_bg.color
	local texture_quest_link_fg_color = widget.style.texture_quest_link_fg.color
	local quest_link_text_color = widget.style.quest_link_text.text_color
	local texture_id_color = widget.style.texture_id.color
	local texture_hover_id_left_color = widget.style.texture_hover_id_left.color
	local texture_selected_id_left_color = widget.style.texture_selected_id_left.color
	local texture_hover_id_right_color = widget.style.texture_hover_id_right.color
	local texture_selected_id_right_color = widget.style.texture_selected_id_right.color
	local hover_from = (from == 255 and 190) or from
	local hover_to = (to == 255 and 190) or to
	title_text_color[1] = from
	texture_title_divider_color[1] = from
	texture_level_icons_color[1] = from
	texture_level_divider_color[1] = from
	texture_task_icons_color[1] = from
	task_amount_texts_color[1] = from
	texture_tasks_divider_color[1] = from
	texture_token_reward_icon_color[1] = from
	reward_amount_text_color[1] = from
	texture_reward_bg_color[1] = from
	texture_quest_link_bg_color[1] = from
	texture_quest_link_fg_color[1] = from
	quest_link_text_color[1] = from
	texture_id_color[1] = from
	texture_hover_id_left_color[1] = hover_from
	texture_selected_id_left_color[1] = from
	texture_hover_id_right_color[1] = hover_from
	texture_selected_id_right_color[1] = from
	local animation_name = "fade_board_contract"
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, title_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_title_divider_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_level_icons_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_level_divider_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_task_icons_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_06"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, task_amount_texts_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_07"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_tasks_divider_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_08"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_token_reward_icon_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_09"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, reward_amount_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_10"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_reward_bg_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_11"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_bg_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_12"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_quest_link_fg_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_13"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_14"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_id_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_15"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_hover_id_left_color, 1, hover_from, hover_to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_16"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_selected_id_left_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_17"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_hover_id_right_color, 1, hover_from, hover_to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_18"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_selected_id_right_color, 1, from, to, animation_time, math.easeInCubic)

	return 
end
QuestView.fade_in_log_contract = function (self, contract_id)
	self.fade_log_contract(self, contract_id, 0.15, 0, 0, 255)

	return 
end
QuestView.fade_out_log_contract = function (self, contract_id)
	self.fade_log_contract(self, contract_id, 0.15, 0, 255, 0)

	return 
end
QuestView.fade_log_contract = function (self, contract_id, animation_time, wait_time, from, to)
	local widget = self._get_log_widget_for_contract_id(self, contract_id)
	local title_text_color = widget.style.title_text.text_color
	local texture_title_divider_color = widget.style.texture_title_divider.color
	local quest_link_marker_bg_texture_color = widget.style.quest_link_marker_bg_texture.color
	local quest_link_marker_fg_texture_color = widget.style.quest_link_marker_fg_texture.color
	local quest_link_text_color = widget.style.quest_link_text.text_color
	local difficulty_text_color = widget.style.difficulty_text.text_color
	local texture_level_icons_color = widget.style.texture_level_icons.color
	local texture_level_divider_color = widget.style.texture_level_divider.color
	local texture_requirements_tasks_vertical_divider_color = widget.style.texture_requirements_tasks_vertical_divider.color
	local texture_task_icons_color = widget.style.texture_task_icons.color
	local texture_level_checkmark_icons_colors = widget.style.texture_level_checkmark_icons.texture_colors
	local texture_task_checkmark_icons_colors = widget.style.texture_task_checkmark_icons.texture_colors
	local task_amount_texts_color = widget.style.task_amount_texts.text_color
	local texture_id_color = widget.style.texture_id.color
	local background_complete_texture_color = widget.style.background_complete_texture.color
	local texture_hover_id_left_color = widget.style.texture_hover_id_left.color
	local texture_selected_id_left_color = widget.style.texture_selected_id_left.color
	local texture_hover_id_right_color = widget.style.texture_hover_id_right.color
	local texture_selected_id_right_color = widget.style.texture_selected_id_right.color
	local hover_from = (from == 255 and 190) or from
	local hover_to = (to == 255 and 190) or to
	title_text_color[1] = from
	texture_title_divider_color[1] = from
	quest_link_marker_bg_texture_color[1] = from
	quest_link_marker_fg_texture_color[1] = from
	quest_link_text_color[1] = from
	difficulty_text_color[1] = from
	texture_level_icons_color[1] = from
	texture_level_divider_color[1] = from
	texture_requirements_tasks_vertical_divider_color[1] = from
	texture_task_icons_color[1] = from
	task_amount_texts_color[1] = from
	texture_id_color[1] = from
	background_complete_texture_color[1] = from
	texture_hover_id_left_color[1] = hover_from
	texture_selected_id_left_color[1] = from
	texture_hover_id_right_color[1] = hover_from
	texture_selected_id_right_color[1] = from
	local level_checkmarks_from = {}
	local task_checkmarks_from = {}
	local level_checkmarks_to = {}
	local task_checkmarks_to = {}

	for i = 1, 3, 1 do
		level_checkmarks_from[i] = (from == 255 and widget.content.completed_levels[i] and from) or 0
	end

	for i = 1, 3, 1 do
		task_checkmarks_from[i] = (from == 255 and widget.content.completed_tasks[i] and from) or 0
	end

	for i = 1, 3, 1 do
		level_checkmarks_to[i] = (to == 255 and widget.content.completed_levels[i] and to) or 0
	end

	for i = 1, 3, 1 do
		task_checkmarks_to[i] = (to == 255 and widget.content.completed_tasks[i] and to) or 0
	end

	local animation_name = "fade_log_contract"
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, title_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_title_divider_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_marker_bg_texture_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_marker_fg_texture_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, quest_link_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_06"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, difficulty_text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_07"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_level_icons_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_08"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_level_divider_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_09"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_requirements_tasks_vertical_divider_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_10"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_task_icons_color, 1, from, to, animation_time, math.easeInCubic)

	for i = 1, 3, 1 do
		ui_animations[animation_name .. "_11_" .. tostring(i)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_level_checkmark_icons_colors[i], 1, level_checkmarks_from[i], level_checkmarks_to[i], animation_time, math.easeInCubic)
	end

	for i = 1, 3, 1 do
		ui_animations[animation_name .. "_12_" .. tostring(i)] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_task_checkmark_icons_colors[i], 1, task_checkmarks_from[i], task_checkmarks_to[i], animation_time, math.easeInCubic)
	end

	ui_animations[animation_name .. "_13"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, task_amount_texts_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_14"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_id_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_15"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, background_complete_texture_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_16"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_hover_id_left_color, 1, hover_from, hover_to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_17"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_selected_id_left_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_18"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_hover_id_right_color, 1, hover_from, hover_to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_19"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, texture_selected_id_right_color, 1, from, to, animation_time, math.easeInCubic)

	return 
end
QuestView.move_popup_contract_to_log = function (self, contract_id)
	local background_texture = self._get_contract_background(self, contract_id)
	local widget = self.popup_widgets[background_texture]
	local bg_size = widget.style.texture_id.size
	local bg_offset = widget.style.texture_id.offset
	local bg_color = widget.style.texture_id.color
	local animation_name = "move_popup_contract_to_log"
	local animation_time = 0.3
	local wait_time = 0.3
	local fade_animation_time = 0.2
	local fade_wait_time = 0.4
	local size_from = table.clone(widget.style.background_size)
	local size_to = QuestSettings.CONTRACT_LOG_WIDGET_SIZE
	local offset_from = table.clone(widget.style.background_offset)
	local offset_to = {
		QuestSettings.CONTRACT_LOG_WIDGET_SIZE[1] - 1920 - 40,
		350
	}
	local color_from = 255
	local color_to = 0
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_size, 1, size_from[1], size_to[1], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_size, 2, size_from[2], size_to[2], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_offset, 1, offset_from[1], offset_to[1], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_offset, 2, offset_from[2], offset_to[2], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, fade_wait_time, UIAnimation.function_by_time, bg_color, 1, color_from, color_to, fade_animation_time, math.easeOutCubic)

	return 
end
QuestView.move_popup_contract_to_board = function (self, contract_id)
	local background_texture = self._get_contract_background(self, contract_id)
	local popup_widget = self.popup_widgets[background_texture]
	local board_widget = self._get_board_widget_for_contract_id(self, contract_id)
	local board_world_position = UISceneGraph.get_world_position(self.ui_scenegraph, board_widget.scenegraph_id)
	local bg_size = popup_widget.style.texture_id.size
	local bg_offset = popup_widget.style.texture_id.offset
	local bg_color = popup_widget.style.texture_id.color
	local animation_name = "move_popup_contract_to_board"
	local animation_time = 0.3
	local wait_time = 0.3
	local fade_animation_time = 0.2
	local fade_wait_time = 0.4
	local size_from = table.clone(popup_widget.style.background_size)
	local size_to = QuestSettings.BOARD_CONTRACT_SIZE
	local offset_from = table.clone(popup_widget.style.background_offset)
	local offset_to = {
		board_world_position[1],
		board_world_position[2]
	}
	local color_from = 255
	local color_to = 0
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_size, 1, size_from[1], size_to[1], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_size, 2, size_from[2], size_to[2], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_offset, 1, offset_from[1], offset_to[1], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, bg_offset, 2, offset_from[2], offset_to[2], animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, fade_wait_time, UIAnimation.function_by_time, bg_color, 1, color_from, color_to, fade_animation_time, math.easeOutCubic)

	return 
end
QuestView.flash_log_contract = function (self, contract_id)
	local widget = self._get_log_widget_for_contract_id(self, contract_id)

	self.flash_contract(self, widget)

	return 
end
QuestView.flash_board_contract = function (self, contract_id)
	local widget = self._get_board_widget_for_contract_id(self, contract_id)

	self.flash_contract(self, widget)

	return 
end
QuestView.flash_contract = function (self, widget)
	local left_flash = widget.style.texture_flashing_id_left.color
	local right_flash = widget.style.texture_flashing_id_right.color
	local animation_name = "flash_contract"
	local animation_time = 0.25
	local wait_time = 0.35
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, left_flash, 1, 0, 255, animation_time, math.easeCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, wait_time + animation_time, UIAnimation.function_by_time, left_flash, 1, 255, 0, animation_time, math.easeCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, right_flash, 1, 0, 255, animation_time, math.easeCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, wait_time + animation_time, UIAnimation.function_by_time, right_flash, 1, 255, 0, animation_time, math.easeCubic)

	return 
end
QuestView.reset_popup_contract_values = function (self, widget)
	local widget_style = widget.style
	widget_style.title_text.text_color[1] = 255
	widget_style.description_text.text_color[1] = 255
	widget_style.level_title_text.text_color[1] = 255
	widget_style.texture_level_title_bg.color[1] = 255
	widget_style.difficulty_text.text_color[1] = 255
	widget_style.texture_level_icons.color[1] = 255
	widget_style.level_name_texts.text_color[1] = 255
	widget_style.task_title_text.text_color[1] = 255
	widget_style.texture_tasks_title_bg.color[1] = 255
	widget_style.texture_task_icons.color[1] = 255
	widget_style.texture_task_checkmark_icons.color[1] = 255
	widget_style.task_amount_texts.text_color[1] = 255
	widget_style.task_progress_texts.text_color[1] = 255
	widget_style.task_name_texts.text_color[1] = 255
	widget_style.reward_title_text.text_color[1] = 255
	widget_style.texture_reward_bg.color[1] = 255
	widget_style.texture_token_reward_icon.color[1] = 255
	widget_style.reward_amount_text.text_color[1] = 255
	widget_style.texture_boon_reward_icon.color[1] = 255
	widget_style.boon_duration_text.text_color[1] = 255
	widget_style.boon_name_text.text_color[1] = 255
	widget_style.texture_quest_link_bg.color[1] = 255
	widget_style.texture_quest_link_fg.color[1] = 255
	widget_style.quest_link_text.text_color[1] = 255
	widget_style.complete_texture.color[1] = 255

	for i = 1, 3, 1 do
		widget_style.texture_level_checkmark_icons.texture_colors[i][1] = 255
	end

	widget_style.texture_id.size = table.clone(widget.style.background_size)
	widget_style.texture_id.offset = table.clone(widget.style.background_offset)
	widget_style.texture_id.color[1] = 255

	return 
end
QuestView.contract_moving = function (self)
	local ui_animations = self.ui_animations

	return ((ui_animations.move_popup_contract_to_board_01 or ui_animations.move_popup_contract_to_log_01) and true) or false
end
QuestView.contract_fading = function (self)
	local ui_animations = self.ui_animations

	return (ui_animations.fade_out_popup_contract_01 and true) or false
end
QuestView.turned_in_text_active = function (self)
	local ui_animations = self.ui_animations

	return ((ui_animations.animate_turned_in_text_01 or ui_animations.animate_turned_in_text_11) and true) or false
end
QuestView.animate_turned_in_text = function (self, header, title)
	local completion_text_widgets = self.completion_text_widgets
	local completion_header_widget = completion_text_widgets.completion_header_widget
	local completion_title_widget = completion_text_widgets.completion_title_widget
	completion_header_widget.content.text = header
	completion_title_widget.content.text = title
	local animation_name = "animate_turned_in_text"
	local slam_animation_time = 0.3
	local slam_wait_time = 0.1
	local pulse_animation_time = 0.1
	local pulse_wait_time = slam_wait_time + slam_animation_time
	local color_from = 0
	local color_to = 255
	local header_size_from = 200
	local header_size_to = 80
	local title_size_from = 80
	local title_size_to = 40
	local header_pulse_size_from = 84
	local header_pulse_size_to = 76
	local title_pulse_size_from = 42
	local title_pulse_size_to = 38
	local ui_animations = self.ui_animations
	ui_animations[animation_name .. "_01"] = UIAnimation.init(UIAnimation.wait, slam_wait_time, UIAnimation.function_by_time, completion_header_widget.style.text, "font_size", header_size_from, header_pulse_size_from, slam_animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_02"] = UIAnimation.init(UIAnimation.wait, slam_wait_time, UIAnimation.function_by_time, completion_title_widget.style.text, "font_size", title_size_from, title_pulse_size_from, slam_animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_03"] = UIAnimation.init(UIAnimation.wait, slam_wait_time, UIAnimation.function_by_time, completion_header_widget.style.text.text_color, 1, color_from, color_to, slam_animation_time, math.easeCubic)
	ui_animations[animation_name .. "_04"] = UIAnimation.init(UIAnimation.wait, slam_wait_time, UIAnimation.function_by_time, completion_title_widget.style.text.text_color, 1, color_from, color_to, slam_animation_time, math.easeCubic)
	ui_animations[animation_name .. "_05"] = UIAnimation.init(UIAnimation.wait, pulse_wait_time, UIAnimation.function_by_time, completion_header_widget.style.text, "font_size", header_pulse_size_from, header_pulse_size_to, pulse_animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_06"] = UIAnimation.init(UIAnimation.wait, pulse_wait_time, UIAnimation.function_by_time, completion_title_widget.style.text, "font_size", title_pulse_size_from, title_pulse_size_to, pulse_animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_07"] = UIAnimation.init(UIAnimation.wait, pulse_wait_time + pulse_animation_time, UIAnimation.function_by_time, completion_header_widget.style.text, "font_size", header_pulse_size_to, header_size_to, pulse_animation_time, math.easeOutCubic)
	ui_animations[animation_name .. "_08"] = UIAnimation.init(UIAnimation.wait, pulse_wait_time + pulse_animation_time, UIAnimation.function_by_time, completion_title_widget.style.text, "font_size", title_pulse_size_to, title_size_to, pulse_animation_time, math.easeOutCubic)
	local animation_time = 0.3
	local wait_time = pulse_wait_time + pulse_animation_time + pulse_animation_time + 0.3
	color_from = 255
	color_to = 0
	ui_animations[animation_name .. "_09"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, completion_header_widget.style.text.text_color, 1, color_from, color_to, animation_time, math.easeCubic)
	ui_animations[animation_name .. "_10"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, completion_title_widget.style.text.text_color, 1, color_from, color_to, animation_time, math.easeCubic)
	ui_animations[animation_name .. "_11"] = UIAnimation.init(UIAnimation.wait, wait_time*2)

	return 
end

return 
