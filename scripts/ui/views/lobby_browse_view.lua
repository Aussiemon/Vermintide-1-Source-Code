require("scripts/ui/views/menu_input_description_ui")
require("scripts/ui/views/lobby_item_list")
require("scripts/network/lobby_aux")

local LobbyBrowseDefinitions = require("scripts/ui/views/lobby_browse_view_definitions")
DO_RELOAD = false
LobbyBrowseView = class(LobbyBrowseView)
local input_delay_before_start_new_search = 0
local platform = Application.platform()

if platform ~= "ps4" or not {
	LobbyDistanceFilter.CLOSE,
	LobbyDistanceFilter.MEDIUM,
	LobbyDistanceFilter.WORLD
} then
	local MapLobbyDistanceFilter = {
		LobbyDistanceFilter.CLOSE,
		LobbyDistanceFilter.MEDIUM,
		LobbyDistanceFilter.FAR,
		LobbyDistanceFilter.WORLD
	}
end

local generic_input_actions = {
	default = {
		{
			input_action = "confirm",
			priority = 1,
			description_text = "lb_search"
		},
		{
			input_action = "special_1",
			priority = 2,
			description_text = "lb_reset_filters"
		},
		{
			input_action = "back",
			priority = 3,
			description_text = "input_description_close"
		}
	},
	lobby_list = {
		{
			input_action = "confirm",
			priority = 1,
			description_text = "lb_join"
		},
		{
			input_action = "back",
			priority = 2,
			description_text = "input_description_back"
		}
	},
	lobby_list_no_join = {
		{
			input_action = "back",
			priority = 1,
			description_text = "input_description_back"
		}
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
LobbyBrowseView.init = function (self, ingame_ui_context)
	local player_manager = Managers.player
	local player = player_manager.local_player(player_manager)
	local statistics_db = player_manager.statistics_db(player_manager)
	local player_stats_id = player.stats_id(player)
	LobbyBrowseDefinitions.game_mode_data = LobbyBrowseDefinitions.setup_game_mode_data(statistics_db, player_stats_id)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_scenegraph = UISceneGraph.init_scenegraph(LobbyBrowseDefinitions.scenegraph_definition)
	self.difficulty_manager = Managers.state.difficulty
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager
	self.ingame_ui = ingame_ui_context.ingame_ui

	input_manager.create_input_service(input_manager, "lobby_browser", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "lobby_browser", "keyboard")
	input_manager.map_device_to_service(input_manager, "lobby_browser", "mouse")
	input_manager.map_device_to_service(input_manager, "lobby_browser", "gamepad")
	self.create_ui_elements(self)

	local settings = {
		input_service_name = "lobby_browser",
		use_top_renderer = false,
		num_list_items = 17
	}
	self.lobby_list = LobbyItemsList:new(LobbyBrowseDefinitions.lobby_list_position, ingame_ui_context, settings)
	self.lobby_list_update_timer = MatchmakingSettings.TIME_BETWEEN_EACH_SEARCH
	self.show_invalid = false
	self.selected_gamepad_widget_index = 1
	local input_service = self.input_service(self)
	self.menu_input_description_ui = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 3, UILayer.default, generic_input_actions.default)

	self.menu_input_description_ui:change_generic_actions(generic_input_actions.default)

	self.active_menu_input_description = "default"
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self._draw_invalid_checkbox = Application.build() == "dev" or Application.build() == "debug"
	self.gamepad_selected_page = "filters"

	return 
end
LobbyBrowseView.create_ui_elements = function (self)
	self.ui_animations = {}
	self.background_widget = UIWidget.init(LobbyBrowseDefinitions.background_widget)
	self.title_widget = UIWidget.init(LobbyBrowseDefinitions.title_widget)
	self.lobby_list_frame_widget = UIWidget.init(LobbyBrowseDefinitions.lobby_list_frame_widget)
	self.filter_frame_widget = UIWidget.init(LobbyBrowseDefinitions.filter_frame_widget)
	self.filter_divider_widget = UIWidget.init(LobbyBrowseDefinitions.filter_divider_widget)
	self.lobby_list_title_line_widget = UIWidget.init(LobbyBrowseDefinitions.lobby_list_title_line_widget)
	self.status_background = UIWidget.init(LobbyBrowseDefinitions.status_background)
	self.status_fade = UIWidget.init(LobbyBrowseDefinitions.status_fade)
	self.status_cancel_button = UIWidget.init(LobbyBrowseDefinitions.status_cancel_button)
	self.status_text = UIWidget.init(LobbyBrowseDefinitions.status_text)
	self.status_title = UIWidget.init(LobbyBrowseDefinitions.status_title)
	self.search_button = UIWidget.init(LobbyBrowseDefinitions.search_button)
	self.reset_button = UIWidget.init(LobbyBrowseDefinitions.reset_button)
	self.join_button = UIWidget.init(LobbyBrowseDefinitions.join_button)
	self.back_button = UIWidget.init(LobbyBrowseDefinitions.back_button)
	self.game_mode_stepper = UIWidget.init(LobbyBrowseDefinitions.game_mode_stepper)
	self.level_stepper = UIWidget.init(LobbyBrowseDefinitions.level_stepper)
	self.difficulty_stepper = UIWidget.init(LobbyBrowseDefinitions.difficulty_stepper)
	self.show_lobbies_stepper = UIWidget.init(LobbyBrowseDefinitions.show_lobbies_stepper)
	self.distance_stepper = UIWidget.init(LobbyBrowseDefinitions.distance_stepper)
	self.game_mode_banner_widget = UIWidget.init(LobbyBrowseDefinitions.game_mode_banner_widget)
	self.level_banner_widget = UIWidget.init(LobbyBrowseDefinitions.level_banner_widget)
	self.difficulty_banner_widget = UIWidget.init(LobbyBrowseDefinitions.difficulty_banner_widget)
	self.show_lobbies_banner_widget = UIWidget.init(LobbyBrowseDefinitions.show_lobbies_banner_widget)
	self.distance_banner_widget = UIWidget.init(LobbyBrowseDefinitions.distance_banner_widget)
	self.dead_space_filler = UIWidget.init(LobbyBrowseDefinitions.dead_space_filler)
	self.gamepad_stepper_selection_widget = UIWidget.init(LobbyBrowseDefinitions.gamepad_stepper_selection)
	self.frame_divider_widget = UIWidget.init(LobbyBrowseDefinitions.frame_divider)
	self.left_frame_glow_widget = UIWidget.init(LobbyBrowseDefinitions.left_frame_glow)
	self.right_frame_glow_widget = UIWidget.init(LobbyBrowseDefinitions.right_frame_glow)
	self.checkboxes = {
		invalid = UIWidget.init(LobbyBrowseDefinitions.invalid_checkbox)
	}

	self.on_game_mode_stepper_input(self, 0, 1)
	self._reset_filters(self)

	self.gamepad_widgets = {
		{
			widget = self.game_mode_stepper,
			data = LobbyBrowserGamepadWidgets.stepper
		},
		{
			widget = self.level_stepper,
			data = LobbyBrowserGamepadWidgets.stepper
		},
		{
			widget = self.difficulty_stepper,
			data = LobbyBrowserGamepadWidgets.stepper
		},
		{
			widget = self.show_lobbies_stepper,
			data = LobbyBrowserGamepadWidgets.stepper
		},
		{
			widget = self.distance_stepper,
			data = LobbyBrowserGamepadWidgets.stepper
		}
	}

	return 
end
LobbyBrowseView.on_enter = function (self)
	self.populate_lobby_list(self)
	self.input_manager:block_device_except_service("lobby_browser", "keyboard", 1)
	self.input_manager:block_device_except_service("lobby_browser", "mouse", 1)
	self.input_manager:block_device_except_service("lobby_browser", "gamepad", 1)

	self.status_text.content.text = ""

	self.play_sound(self, "Play_hud_button_open")

	self.active = true

	self.search(self)
	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_on")

	return 
end
LobbyBrowseView.on_exit = function (self)
	self.exiting = nil
	self.active = nil
	self._current_status_message = nil

	if self.status_join_lobby_popup_id then
		Managers.popup:cancel_popup(self.status_join_lobby_popup_id)

		self.status_join_lobby_popup_id = nil
	end

	if self.cancel_join_lobby_popup_id then
		Managers.popup:cancel_popup(self.cancel_join_lobby_popup_id)

		self.cancel_join_lobby_popup_id = nil
	end

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)
	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_off")

	return 
end
LobbyBrowseView.exit = function (self, return_to_game)
	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)
	self.play_sound(self, "Play_hud_button_close")

	self.exiting = true

	return 
end
LobbyBrowseView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	return 
end
LobbyBrowseView.cancel_join_lobby = function (self, status_message)
	if self.active then
		if self.status_join_lobby_popup_id then
			Managers.popup:cancel_popup(self.status_join_lobby_popup_id)

			self.status_join_lobby_popup_id = nil
		end

		if status_message and not self.cancel_join_lobby_popup_id then
			self.cancel_join_lobby_popup_id = Managers.popup:queue_popup(Localize(status_message), Localize("popup_message_topic"), "ok", Localize("popup_choice_ok"))
		end

		self.join_lobby_data_id = nil
	end

	return 
end
local dummy_lobby = {
	difficulty = "normal",
	player_slot_3 = "available",
	player_slot_4 = "available",
	network_hash = "a0ccda7e1f4dcc9a",
	player_slot_5 = "available",
	num_players = 1,
	country_code = "CD",
	address = "172.16.2.29:10003",
	matchmaking = "true",
	valid = true,
	player_slot_2 = "available",
	selected_level_key = "magnus",
	player_slot_1 = "291f62d6dd09f4b1:1",
	level_key = "inn_level",
	is_private = "false",
	host = "291f62d6dd09f4b1",
	unique_server_name = "sebgra"
}
local emtpy_lobby_list = {}
LobbyBrowseView.populate_lobby_list = function (self, auto_update)
	local selected_lobby_data = self.lobby_list:selected_lobby()
	local lobby_finder = Managers.matchmaking.lobby_finder
	local lobbies = lobby_finder.latest_filter_lobbies(lobby_finder) or emtpy_lobby_list
	local ignore_scroll_reset = true
	local show_lobbies_index = self.selected_show_lobbies_index
	local show_all_lobbies = (show_lobbies_index == 2 and true) or false
	local lobbies_to_present = {}
	local lobby_count = 0

	for lobby_id, lobby_data in pairs(lobbies) do
		if show_all_lobbies or self.valid_lobby(self, lobby_data) then
			lobbies_to_present[lobby_id] = lobby_data
			lobby_count = lobby_count + 1
		end
	end

	local keep_searching = lobby_count == 0

	if auto_update and keep_searching and self.lobby_list_update_timer then
		self.lobby_list:animate_loading_text()
	end

	self.lobby_list_update_timer = (keep_searching and MatchmakingSettings.TIME_BETWEEN_EACH_SEARCH) or nil

	self.lobby_list:populate_lobby_list(lobbies_to_present, ignore_scroll_reset)

	if selected_lobby_data then
		self.lobby_list:set_selected_lobby(selected_lobby_data)
	end

	return 
end
LobbyBrowseView.valid_lobby = function (self, lobby_data)
	local is_valid = lobby_data.valid
	local is_matchmaking = lobby_data.matchmaking and lobby_data.matchmaking ~= "false"
	local level_key = lobby_data.selected_level_key or lobby_data.level_key
	local difficulty = lobby_data.difficulty
	local num_players = tonumber(lobby_data.num_players)

	if not is_valid or not is_matchmaking or not level_key or not difficulty or num_players == MatchmakingSettings.MAX_NUMBER_OF_PLAYERS then
		return false
	end

	local player_manager = Managers.player
	local player = player_manager.local_player(player_manager)
	local statistics_db = player_manager.statistics_db(player_manager)
	local player_stats_id = player.stats_id(player)
	local level_unlocked = LevelUnlockUtils.level_unlocked(statistics_db, player_stats_id, level_key)

	if not level_unlocked then
		return false
	end

	local unlocked_level_difficulty_index = LevelUnlockUtils.unlocked_level_difficulty_index(statistics_db, player_stats_id, level_key)

	if not unlocked_level_difficulty_index then
		return false
	end

	local level_difficulties = self.difficulty_manager:get_level_difficulties(level_key)
	local unlocked_difficulty_key = level_difficulties[unlocked_level_difficulty_index]
	local unlocked_difficulty_settings = DifficultySettings[unlocked_difficulty_key]
	local difficulty_setting = DifficultySettings[difficulty]

	if unlocked_difficulty_settings.rank < difficulty_setting.rank then
		return false
	end

	return true
end
LobbyBrowseView.destroy = function (self)
	self.menu_input_description_ui:destroy()

	self.menu_input_description_ui = nil
	self.ingame_ui = nil
	self.join_lobby_data_id = nil

	return 
end
LobbyBrowseView.set_status_message = function (self, status_message)
	if self._current_status_message ~= status_message then
		self._current_status_message = status_message

		if self.status_join_lobby_popup_id then
			Managers.popup:cancel_popup(self.status_join_lobby_popup_id)

			self.status_join_lobby_popup_id = nil
		end

		self.status_join_lobby_popup_id = Managers.popup:queue_popup(Localize(status_message), Localize("popup_message_topic"), "cancel", Localize("popup_choice_cancel"))
	end

	return 
end
LobbyBrowseView.input_service = function (self)
	return self.input_manager:get_service("lobby_browser")
end
LobbyBrowseView.update_auto_refresh = function (self, dt)
	local lobby_list_update_timer = self.lobby_list_update_timer

	if lobby_list_update_timer then
		lobby_list_update_timer = lobby_list_update_timer - dt

		if lobby_list_update_timer < 0 then
			self.populate_lobby_list(self, true)
		else
			self.lobby_list_update_timer = lobby_list_update_timer
		end
	end

	return 
end
LobbyBrowseView._handle_input = function (self, dt)
	local input_service = self.input_service(self)
	local join_button_hotspot = self.join_button.content.button_hotspot
	local back_button_hotspot = self.back_button.content.button_hotspot
	local search_button_hotspot = self.search_button.content.button_hotspot
	local reset_button_hotspot = self.reset_button.content.button_hotspot
	local lobby_data = self.lobby_list:selected_lobby()

	self._update_join_button(self, lobby_data)

	if back_button_hotspot.on_hover_enter or search_button_hotspot.on_hover_enter or join_button_hotspot.on_hover_enter or reset_button_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if not join_button_hotspot.disabled and join_button_hotspot.on_release and not self.join_lobby_data_id then
		local lobby_data = self.lobby_list:selected_lobby()

		if lobby_data then
			self.play_sound(self, "Play_hud_select")
			Managers.matchmaking:request_join_lobby(lobby_data)

			self.join_lobby_data_id = lobby_data.id
		end
	end

	if input_service.get(input_service, "toggle_menu") or back_button_hotspot.on_release then
		self.play_sound(self, "Play_hud_select")

		local return_to_game = not self.ingame_ui.menu_active

		self.exit(self, return_to_game)
	end

	if search_button_hotspot.on_release then
		self.play_sound(self, "Play_hud_select")

		search_button_hotspot.on_release = nil

		self.search(self)
	end

	if reset_button_hotspot.on_release then
		self.play_sound(self, "Play_hud_select")

		reset_button_hotspot.on_release = nil

		self._reset_filters(self)
	end

	self._handle_stepper_input(self, dt)

	return 
end
LobbyBrowseView._handle_gamepad_input = function (self, dt)
	local input_service = self.input_service(self)
	local gamepad_selected_page = self.gamepad_selected_page

	if gamepad_selected_page == "filters" then
		if input_service.get(input_service, "confirm") then
			self.search(self)
			self.deselect_gamepad_widget_by_index(self, self.selected_gamepad_widget_index)

			gamepad_selected_page = "lobby_list"
		elseif input_service.get(input_service, "toggle_menu") or input_service.get(input_service, "back") then
			local return_to_game = not self.ingame_ui.menu_active

			self.exit(self, return_to_game)
		end

		self.handle_gamepad_navigation_input(self, dt)
		self._handle_stepper_input(self, dt)
	elseif input_service.get(input_service, "confirm") then
		local lobby_data = self.lobby_list:selected_lobby()

		if lobby_data then
			self.play_sound(self, "Play_hud_select")
			Managers.matchmaking:request_join_lobby(lobby_data)

			self.join_lobby_data_id = lobby_data.id
		end
	elseif input_service.get(input_service, "back") then
		gamepad_selected_page = "filters"

		self._set_selected_gamepad_widget(self, self.selected_gamepad_widget_index)
	elseif input_service.get(input_service, "toggle_menu") then
		local return_to_game = not self.ingame_ui.menu_active

		self.exit(self, return_to_game)
	end

	self._update_input_description(self)

	self.gamepad_selected_page = gamepad_selected_page

	return 
end
LobbyBrowseView._handle_stepper_input = function (self, dt)
	self.handle_stepper_input(self, "game_mode_stepper", self.game_mode_stepper, callback(self, "on_game_mode_stepper_input"))
	self.handle_stepper_input(self, "level_stepper", self.level_stepper, callback(self, "on_level_stepper_input"))
	self.handle_stepper_input(self, "difficulty_stepper", self.difficulty_stepper, callback(self, "on_difficulty_stepper_input"))
	self.handle_stepper_input(self, "show_lobbies_stepper", self.show_lobbies_stepper, callback(self, "on_show_lobbies_stepper_input"))
	self.handle_stepper_input(self, "distance_stepper", self.distance_stepper, callback(self, "on_distance_stepper_input"))

	return 
end
LobbyBrowseView.update = function (self, dt)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	local ui_renderer = self.ui_renderer
	local input_manager = self.input_manager
	local input_service = self.input_service(self)
	local ui_scenegraph = self.ui_scenegraph
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local matchmaking_manager = Managers.matchmaking

	for name, animation in pairs(self.ui_animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.ui_animations[name] = nil
		end
	end

	local loading = self.lobby_list_update_timer ~= nil
	local join_lobby_data_id = self.join_lobby_data_id
	self.search_button.content.button_hotspot.disabled = join_lobby_data_id or loading

	if self.active then
		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
		UIRenderer.draw_widget(ui_renderer, self.background_widget)
		UIRenderer.draw_widget(ui_renderer, self.title_widget)
		UIRenderer.draw_widget(ui_renderer, self.lobby_list_title_line_widget)
		UIRenderer.draw_widget(ui_renderer, self.level_stepper)
		UIRenderer.draw_widget(ui_renderer, self.game_mode_stepper)
		UIRenderer.draw_widget(ui_renderer, self.difficulty_stepper)
		UIRenderer.draw_widget(ui_renderer, self.show_lobbies_stepper)
		UIRenderer.draw_widget(ui_renderer, self.distance_stepper)
		UIRenderer.draw_widget(ui_renderer, self.game_mode_banner_widget)
		UIRenderer.draw_widget(ui_renderer, self.level_banner_widget)
		UIRenderer.draw_widget(ui_renderer, self.difficulty_banner_widget)
		UIRenderer.draw_widget(ui_renderer, self.show_lobbies_banner_widget)
		UIRenderer.draw_widget(ui_renderer, self.distance_banner_widget)
		UIRenderer.draw_widget(ui_renderer, self.dead_space_filler)
		UIRenderer.draw_widget(ui_renderer, self.frame_divider_widget)

		if not gamepad_active then
			UIRenderer.draw_widget(ui_renderer, self.back_button)
			UIRenderer.draw_widget(ui_renderer, self.join_button)
			UIRenderer.draw_widget(ui_renderer, self.reset_button)
			UIRenderer.draw_widget(ui_renderer, self.search_button)
			UIRenderer.draw_widget(ui_renderer, self.filter_divider_widget)
		end

		if gamepad_active then
			if self.gamepad_selected_page == "filters" then
				UIRenderer.draw_widget(ui_renderer, self.left_frame_glow_widget)
				UIRenderer.draw_widget(ui_renderer, self.gamepad_stepper_selection_widget)
			else
				UIRenderer.draw_widget(ui_renderer, self.right_frame_glow_widget)
			end
		end

		if self._draw_invalid_checkbox then
			local checkbox_content = self.checkboxes.invalid.content
			local checkbox_hotspot = checkbox_content.button_hotspot

			if checkbox_hotspot.on_hover_enter then
				self.play_sound(self, "Play_hud_hover")
			end

			if checkbox_hotspot.on_release then
				checkbox_content.checked = not checkbox_content.checked
				self.search_timer = input_delay_before_start_new_search

				self.play_sound(self, "Play_hud_select")
			end

			UIRenderer.draw_widget(ui_renderer, self.checkboxes.invalid)
		end

		UIRenderer.end_pass(ui_renderer)
	end

	if gamepad_active then
		if not self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = true

			self._on_gamepad_activated(self)
		end

		self.menu_input_description_ui:draw(ui_renderer, dt)
	elseif self.gamepad_active_last_frame then
		self.gamepad_active_last_frame = false

		self._on_gamepad_deactivated(self)
	end

	if gamepad_active then
		self._handle_gamepad_input(self, dt)
	else
		self._handle_input(self, dt)
	end

	self.update_auto_refresh(self, dt)

	local ignore_gamepad_input = self.gamepad_selected_page == "filters"

	self.lobby_list:update(dt, loading, ignore_gamepad_input)

	if self.active then
		self.lobby_list:draw(dt)
	end

	local lobby_index_selected = self.lobby_list.lobby_list_index_changed

	if lobby_index_selected then
		self.lobby_list:on_lobby_selected(lobby_index_selected)
	end

	if self.search_timer then
		self.search_timer = self.search_timer - dt

		if self.search_timer < 0 then
			self.search(self)

			self.search_timer = nil
		end
	end

	if self.cancel_join_lobby_popup_id then
		local popup_result = Managers.popup:query_result(self.cancel_join_lobby_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self.cancel_join_lobby_popup_id)

			self.cancel_join_lobby_popup_id = nil
		end
	end

	if self.status_join_lobby_popup_id then
		local popup_result = Managers.popup:query_result(self.status_join_lobby_popup_id)

		if popup_result then
			Managers.popup:cancel_popup(self.status_join_lobby_popup_id)

			self.status_join_lobby_popup_id = nil
			self._current_status_message = nil

			Managers.matchmaking:cancel_matchmaking()
			Managers.matchmaking:cancel_join_lobby()
		end
	end

	return 
end
LobbyBrowseView._update_join_button = function (self, lobby_data)
	local menu_input_description_ui = self.menu_input_description_ui
	local active_menu_input_description = self.active_menu_input_description
	local matchmaking_manager = Managers.matchmaking
	local is_matchmaking = matchmaking_manager.is_game_matchmaking(matchmaking_manager)

	if lobby_data and not is_matchmaking then
		local valid_lobby = self.valid_lobby(self, lobby_data)

		if valid_lobby then
			self.join_button.content.button_hotspot.disabled = false
		else
			self.join_button.content.button_hotspot.disabled = true
		end
	else
		self.join_button.content.button_hotspot.disabled = true
	end

	return 
end
LobbyBrowseView._update_input_description = function (self)
	local menu_input_description_ui = self.menu_input_description_ui
	local active_menu_input_description = self.active_menu_input_description
	local matchmaking_manager = Managers.matchmaking
	local is_matchmaking = matchmaking_manager.is_game_matchmaking(matchmaking_manager)
	local gamepad_selected_page = self.gamepad_selected_page

	if gamepad_selected_page == "filters" then
		if active_menu_input_description ~= "default" then
			menu_input_description_ui.change_generic_actions(menu_input_description_ui, generic_input_actions.default)

			self.active_menu_input_description = "default"
		end
	else
		local lobby_data = self.lobby_list:selected_lobby()
		local valid_lobby = lobby_data and self.valid_lobby(self, lobby_data)

		if valid_lobby then
			if active_menu_input_description ~= "lobby_list" then
				menu_input_description_ui.change_generic_actions(menu_input_description_ui, generic_input_actions.lobby_list)

				self.active_menu_input_description = "lobby_list"
			end
		elseif active_menu_input_description ~= "lobby_list_no_join" then
			menu_input_description_ui.change_generic_actions(menu_input_description_ui, generic_input_actions.lobby_list_no_join)

			self.active_menu_input_description = "lobby_list_no_join"
		end
	end

	return 
end
LobbyBrowseView._reset_filters = function (self)
	local levels_table = self._get_levels(self)
	local any_level_index = #levels_table

	self.on_level_stepper_input(self, 0, any_level_index)

	local difficulties_table = self._get_difficulties(self)
	local any_difficulty_index = #difficulties_table

	self.on_difficulty_stepper_input(self, 0, any_difficulty_index)
	self.on_show_lobbies_stepper_input(self, 0, 1)
	self.on_distance_stepper_input(self, 0, 2)

	return 
end
LobbyBrowseView._create_filter_requirements = function (self)
	local lobby_finder = Managers.matchmaking.lobby_finder
	local level_index = self.selected_level_index
	local levels_table = self._get_levels(self)
	local level_key = levels_table[level_index]
	local difficulty_index = self.selected_difficulty_index
	local difficulty_table = self._get_difficulties(self)
	local difficulty_key = difficulty_table[difficulty_index]
	local only_show_valid_lobbies = not self.checkboxes.invalid.content.checked
	local distance_index = self.selected_distance_index
	local distance_filter = MapLobbyDistanceFilter[distance_index]
	local show_lobbies_index = self.selected_show_lobbies_index
	local show_all_lobbies = (show_lobbies_index == 2 and true) or false
	local matchmaking = not show_all_lobbies
	local free_slots = 1
	local player_manager = Managers.player
	local player = player_manager.local_player(player_manager)
	local statistics_db = player_manager.statistics_db(player_manager)
	local player_stats_id = player.stats_id(player)
	local player_progression = (script_data.unlock_all_levels and #GameActsOrder - 1) or LevelUnlockUtils.current_act_progression_index(statistics_db, player_stats_id)
	local game_mode_data = LobbyBrowseDefinitions.game_mode_data
	local game_mode_index = self.selected_game_mode_index
	local game_mode = game_mode_data[game_mode_index].game_mode_key
	local requirements = {
		free_slots = free_slots,
		distance_filter = platform ~= "ps4" and distance_filter,
		filters = {}
	}

	if platform == "ps4" then
		local user_region = Managers.account:region()

		if distance_filter == LobbyDistanceFilter.CLOSE then
			requirements.filters.primary_region = {
				value = MatchmakingRegionLookup.primary[user_region],
				comparison = LobbyComparison.EQUAL
			}
		elseif distance_filter == LobbyDistanceFilter.MEDIUM then
			requirements.filters.secondary_region = {
				value = MatchmakingRegionLookup.secondary[user_region],
				comparison = LobbyComparison.EQUAL
			}
		end
	end

	if game_mode then
		requirements.filters.game_mode = {
			value = game_mode,
			comparison = LobbyComparison.EQUAL
		}
	end

	if only_show_valid_lobbies then
		requirements.filters.network_hash = {
			value = lobby_finder.network_hash,
			comparison = LobbyComparison.EQUAL
		}
	end

	if level_key ~= "any" then
		requirements.filters.selected_level_key = {
			value = level_key,
			comparison = LobbyComparison.EQUAL
		}
	end

	if difficulty_key ~= "any" then
		requirements.filters.difficulty = {
			value = difficulty_key,
			comparison = LobbyComparison.EQUAL
		}
	end

	if matchmaking then
		requirements.filters.matchmaking = {
			value = "false",
			comparison = LobbyComparison.NOT_EQUAL
		}
	end

	if not show_all_lobbies then
		requirements.filters.required_progression = {
			value = player_progression,
			comparison = LobbyComparison.LESS_OR_EQUAL
		}
	end

	return requirements
end
LobbyBrowseView.search = function (self)
	local requirements = self._create_filter_requirements(self)

	LobbyInternal.clear_filter_requirements()

	local force_refresh = true
	local lobby_finder = Managers.matchmaking.lobby_finder

	lobby_finder.add_filter_requirements(lobby_finder, requirements, force_refresh)
	self.populate_lobby_list(self)

	return 
end
LobbyBrowseView._get_levels = function (self)
	local game_mode_data = LobbyBrowseDefinitions.game_mode_data
	local game_mode_index = self.selected_game_mode_index or 1
	local data = game_mode_data[game_mode_index]
	local levels = data.levels

	return levels
end
LobbyBrowseView._get_difficulties = function (self)
	local game_mode_data = LobbyBrowseDefinitions.game_mode_data
	local game_mode_index = self.selected_game_mode_index or 1
	local data = game_mode_data[game_mode_index]
	local difficulties = data.difficulties

	return difficulties
end
LobbyBrowseView.on_game_mode_stepper_input = function (self, index_change, specific_index)
	local stepper = self.game_mode_stepper
	local game_mode_display_table = LobbyBrowseDefinitions.game_mode_data
	local current_index = self.selected_game_mode_index or 1
	local new_index = self._on_stepper_input(self, stepper, game_mode_display_table, current_index, index_change, specific_index)
	local data = game_mode_display_table[new_index]
	local game_mode_text = data.game_mode_display_name
	stepper.content.setting_text = Localize(game_mode_text)
	self.selected_game_mode_index = new_index
	self.search_timer = input_delay_before_start_new_search
	local levels_table = self._get_levels(self)
	local any_level_index = #levels_table

	self.on_level_stepper_input(self, 0, any_level_index)

	local difficulties_table = self._get_difficulties(self)
	local any_difficulty_index = #difficulties_table

	self.on_difficulty_stepper_input(self, 0, any_difficulty_index)

	return 
end
LobbyBrowseView.on_level_stepper_input = function (self, index_change, specific_index)
	local stepper = self.level_stepper
	local levels_table = self._get_levels(self)
	local current_index = self.selected_level_index or 1
	local new_index = self._on_stepper_input(self, stepper, levels_table, current_index, index_change, specific_index)
	local level_display_name = "lobby_browser_mission"
	local level = levels_table[new_index]

	if level ~= "any" then
		local level_setting = LevelSettings[level]
		level_display_name = level_setting.display_name
	end

	stepper.content.setting_text = Localize(level_display_name)
	self.selected_level_index = new_index
	self.search_timer = input_delay_before_start_new_search

	return 
end
LobbyBrowseView.on_difficulty_stepper_input = function (self, index_change, specific_index)
	local stepper = self.difficulty_stepper
	local difficulties_table = self._get_difficulties(self)
	local current_index = self.selected_difficulty_index or 1
	local new_index = self._on_stepper_input(self, stepper, difficulties_table, current_index, index_change, specific_index)
	local difficulty_display_name = "lobby_browser_difficulty"
	local difficulty = difficulties_table[new_index]

	if difficulty ~= "any" then
		local difficulty_setting = DifficultySettings[difficulty]
		difficulty_display_name = difficulty_setting.display_name
	end

	stepper.content.setting_text = Localize(difficulty_display_name)
	self.selected_difficulty_index = new_index
	self.search_timer = input_delay_before_start_new_search

	return 
end
LobbyBrowseView.on_show_lobbies_stepper_input = function (self, index_change, specific_index)
	local stepper = self.show_lobbies_stepper
	local show_lobbies_table = LobbyBrowseDefinitions.show_lobbies_table
	local current_index = self.selected_show_lobbies_index or 1
	local new_index = self._on_stepper_input(self, stepper, show_lobbies_table, current_index, index_change, specific_index)
	local show_lobbies_text = show_lobbies_table[new_index]
	stepper.content.setting_text = Localize(show_lobbies_text)
	self.selected_show_lobbies_index = new_index
	self.search_timer = input_delay_before_start_new_search

	return 
end
LobbyBrowseView.on_distance_stepper_input = function (self, index_change, specific_index)
	local stepper = self.distance_stepper
	local distance_table = LobbyBrowseDefinitions.distance_table
	local current_index = self.selected_distance_index or 1
	local new_index = self._on_stepper_input(self, stepper, distance_table, current_index, index_change, specific_index)
	local distance_text = distance_table[new_index]
	stepper.content.setting_text = Localize(distance_text)
	self.selected_distance_index = new_index
	self.search_timer = input_delay_before_start_new_search

	return 
end
LobbyBrowseView._on_stepper_input = function (self, stepper, data_table, current_index, index_change, specific_index)
	local num_data = #data_table

	if specific_index then
		assert(0 < specific_index and specific_index <= num_data, "stepper_index out of range")

		return specific_index
	end

	local new_index = current_index + index_change

	if new_index < 1 then
		new_index = num_data
	elseif num_data < new_index then
		new_index = 1
	end

	return new_index
end
LobbyBrowseView.handle_stepper_input = function (self, stepper_name, stepper, step_function)
	local stepper_widget = stepper
	local stepper_content = stepper_widget.content
	local stepper_hotspot = stepper_content.button_hotspot
	local stepper_left_hotspot = stepper_content.left_button_hotspot
	local stepper_right_hotspot = stepper_content.right_button_hotspot
	local gamepad_active = self.input_manager:is_device_active("gamepad")

	if stepper_left_hotspot.on_hover_enter then
		self.on_stepper_arrow_hover(self, stepper_widget, stepper_name, "left_button_texture_clicked")
	elseif stepper_right_hotspot.on_hover_enter then
		self.on_stepper_arrow_hover(self, stepper_widget, stepper_name, "right_button_texture_clicked")
	end

	if stepper_left_hotspot.on_hover_exit then
		self.on_stepper_arrow_dehover(self, stepper_widget, stepper_name, "left_button_texture_clicked")
	elseif stepper_right_hotspot.on_hover_exit then
		self.on_stepper_arrow_dehover(self, stepper_widget, stepper_name, "right_button_texture_clicked")
	end

	if stepper_left_hotspot.on_hover_enter or stepper_right_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	if stepper_left_hotspot.on_release then
		stepper_left_hotspot.on_release = nil

		step_function(-1)
		self.play_sound(self, "Play_hud_select")

		if not gamepad_active then
			self.on_stepper_arrow_pressed(self, stepper_widget, stepper_name, "left_button_texture")
			self.on_stepper_arrow_pressed(self, stepper_widget, stepper_name, "left_button_texture_clicked")
		end
	elseif stepper_right_hotspot.on_release then
		stepper_right_hotspot.on_release = nil

		step_function(1)
		self.play_sound(self, "Play_hud_select")

		if not gamepad_active then
			self.on_stepper_arrow_pressed(self, stepper_widget, stepper_name, "right_button_texture")
			self.on_stepper_arrow_pressed(self, stepper_widget, stepper_name, "right_button_texture_clicked")
		end
	end

	return 
end
LobbyBrowseView.on_stepper_arrow_pressed = function (self, widget, name, style_id)
	local ui_animations = self.ui_animations
	local animation_name = "stepper_widget_arrow_" .. name .. style_id
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local default_size = {
		28,
		34
	}
	local current_alpha = pass_style.color[1]
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_hover"] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
		ui_animations[animation_name .. "_selected_size_width"] = self.animate_element_by_catmullrom(self, pass_style.size, 1, default_size[1], 0.7, 1, 1, 0.7, animation_duration)
		ui_animations[animation_name .. "_selected_size_height"] = self.animate_element_by_catmullrom(self, pass_style.size, 2, default_size[2], 0.7, 1, 1, 0.7, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	return 
end
LobbyBrowseView.on_stepper_arrow_hover = function (self, widget, name, style_id)
	local ui_animations = self.ui_animations
	local animation_name = "stepper_widget_arrow_" .. name .. style_id
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local current_alpha = pass_style.color[1]
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = (current_alpha/target_alpha - 1)*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_hover"] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	self.play_sound(self, "Play_hud_hover")

	return 
end
LobbyBrowseView.on_stepper_arrow_dehover = function (self, widget, name, style_id)
	local ui_animations = self.ui_animations
	local animation_name = "stepper_widget_arrow_" .. name .. style_id
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local current_alpha = pass_style.color[1]
	local target_alpha = 0
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = current_alpha/255*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_hover"] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	return 
end
LobbyBrowseView._on_gamepad_activated = function (self)
	local index = self.selected_gamepad_widget_index

	self._set_selected_gamepad_widget(self, index)

	return 
end
LobbyBrowseView._on_gamepad_deactivated = function (self)
	self._set_selected_gamepad_widget(self, nil)

	return 
end
LobbyBrowseView._get_selected_gamepad_widget = function (self)
	local index = self.selected_gamepad_widget_index
	local selected_gamepad_widget = self.gamepad_widgets[index]

	return selected_gamepad_widget
end
LobbyBrowseView._cycle_next_gamepad_widget = function (self)
	local num_widgets = #self.gamepad_widgets
	local index = self.selected_gamepad_widget_index + 1

	if num_widgets < index then
		index = 1
	end

	self._set_selected_gamepad_widget(self, index)

	return 
end
LobbyBrowseView._cycle_previous_gamepad_widget = function (self)
	local num_widgets = #self.gamepad_widgets
	local index = self.selected_gamepad_widget_index - 1

	if index < 1 then
		index = num_widgets
	end

	self._set_selected_gamepad_widget(self, index)

	return 
end
LobbyBrowseView._set_selected_gamepad_widget = function (self, index)
	local num_widgets = #self.gamepad_widgets

	for i = 1, num_widgets, 1 do
		local gamepad_widget = self.gamepad_widgets[i]
		local widget = gamepad_widget.widget
		local button_hotspot = widget.content.button_hotspot
		button_hotspot.is_selected = false
	end

	if not index then
		return 
	end

	self.selected_gamepad_widget_index = index
	local selected_gamepad_widget = self.gamepad_widgets[index]
	local widget = selected_gamepad_widget.widget
	local button_hotspot = widget.content.button_hotspot
	button_hotspot.is_selected = true
	local gamepad_selection_style = widget.style.gamepad_selection

	if gamepad_selection_style then
		local scenegraph_id = gamepad_selection_style.scenegraph_id
		local texture_size = gamepad_selection_style.texture_size
		self.gamepad_stepper_selection_widget.scenegraph_id = scenegraph_id
		local gamepad_widget_style = self.gamepad_stepper_selection_widget.style
		gamepad_widget_style.texture_top_left.texture_size = texture_size
		gamepad_widget_style.texture_top_right.texture_size = texture_size
		gamepad_widget_style.texture_bottom_left.texture_size = texture_size
		gamepad_widget_style.texture_bottom_right.texture_size = texture_size
	end

	return 
end
LobbyBrowseView.deselect_gamepad_widget_by_index = function (self, index)
	self.selected_gamepad_widget_index = index
	local selected_gamepad_widget = self.gamepad_widgets[index]
	local widget = selected_gamepad_widget.widget
	widget.content.button_hotspot.is_selected = nil

	return 
end
LobbyBrowseView.handle_gamepad_navigation_input = function (self, dt)
	local input_service = self.input_service(self)
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
		local speed_multiplier = self.speed_multiplier or 1
		local decrease = GamepadSettings.menu_speed_multiplier_frame_decrease
		local min_multiplier = GamepadSettings.menu_min_speed_multiplier
		self.speed_multiplier = math.max(speed_multiplier - decrease, min_multiplier)

		return 
	else
		speed_multiplier = self.speed_multiplier or 1
		local move_up = input_service.get(input_service, "move_up")
		local move_up_hold = input_service.get(input_service, "move_up_hold")

		if move_up or move_up_hold then
			self._cycle_previous_gamepad_widget(self)

			self.controller_cooldown = GamepadSettings.menu_cooldown*speed_multiplier
		else
			local move_down = input_service.get(input_service, "move_down")
			local move_down_hold = input_service.get(input_service, "move_down_hold")

			if move_down or move_down_hold then
				self._cycle_next_gamepad_widget(self)

				self.controller_cooldown = GamepadSettings.menu_cooldown*speed_multiplier
			end
		end
	end

	local selected_gamepad_widget = self._get_selected_gamepad_widget(self)
	local data = selected_gamepad_widget.data
	local widget = selected_gamepad_widget.widget
	local input_function = data.input_function
	local input_handled = input_function(widget, input_service)

	if input_handled then
		return 
	end

	self.speed_multiplier = 1

	return 
end
LobbyBrowseView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
LobbyBrowseView.animate_element_by_time = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, time, math.ease_out_quad)

	return new_animation
end
LobbyBrowseView.animate_element_by_catmullrom = function (self, target, target_index, target_value, p0, p1, p2, p3, time)
	local new_animation = UIAnimation.init(UIAnimation.catmullrom, target, target_index, target_value, p0, p1, p2, p3, time)

	return new_animation
end

return 
