MatchmakingStateJoinGame = class(MatchmakingStateJoinGame)
MatchmakingStateJoinGame.NAME = "MatchmakingStateJoinGame"
MatchmakingStateJoinGame.init = function (self, params)
	self.lobby = params.lobby
	self.network_options = params.network_options
	self.network_transmit = params.network_transmit
	self.level_transition_handler = params.level_transition_handler
	self.network_server = params.network_server
	self.popup_join_lobby_handler = params.popup_join_lobby_handler
	self.matchmaking_manager = params.matchmaking_manager
	self.is_server = params.is_server
	self.profile_synchronizer = params.profile_synchronizer
	self.handshaker_client = params.handshaker_client
	self.matchmaking_ui = params.matchmaking_ui
	self.statistics_db = params.statistics_db
	self.matchmaking_manager.selected_profile_index = nil
	self.matchmaking_loading_context = {}
	self.hero_popup_at_t = nil
	self.selected_hero_at_t = nil
	self.show_popup = false
	local level_key = self.level_transition_handler:get_current_level_keys()
	self.is_in_inn = level_key and level_key == "inn_level"

	return 
end
MatchmakingStateJoinGame.destroy = function (self)
	return 
end
MatchmakingStateJoinGame.on_enter = function (self, state_context)
	self.lobby_data = state_context.profiles_data
	self.state_context = state_context
	self.lobby_client = state_context.lobby_client
	self.join_lobby_data = state_context.join_lobby_data
	self.lobby_data.selected_level_key = self.join_lobby_data.selected_level_key
	self.lobby_data.difficulty = self.join_lobby_data.difficulty
	local matchmaking_manager = self.matchmaking_manager
	local hero_index, hero_name = self._current_hero(self)

	assert(hero_index, "no hero index? this is wrong")

	self.wanted_profile_index = hero_index

	if matchmaking_manager.hero_available_in_lobby_data(matchmaking_manager, hero_index, self.join_lobby_data) then
		local hero = SPProfiles[hero_index]
		self.selected_hero_name = hero_name

		self.request_profile_from_host(self, hero_index)
	else
		self.show_popup = true
	end

	self.matchmaking_manager:set_status_message("matchmaking_status_joining_game")

	self._update_lobby_data_timer = 0

	return 
end
MatchmakingStateJoinGame.on_exit = function (self)
	return 
end
MatchmakingStateJoinGame.update = function (self, dt, t)
	local popup_join_lobby_handler = self.popup_join_lobby_handler

	if popup_join_lobby_handler and self.popup_id then
		local popup_result = popup_join_lobby_handler.query_result(popup_join_lobby_handler, self.popup_id)

		if popup_result then
			self.selected_hero_at_t = t

			self.handle_popup_result(self, popup_result, t)
		end

		self._update_lobby_data(self, dt, t)
	end

	if self.handshaker_client:is_timed_out_from_server(t) then
		mm_printf_force("Timed out from server")
		Managers.matchmaking:cancel_matchmaking()
		self.network_transmit:queue_local_rpc("rpc_stop_enter_game_countdown")
	end

	if self._exit_to_search_game then
		local matchmaking_manager = self.matchmaking_manager
		local matchmaking_ui = self.matchmaking_ui
		local lobby_id = self.lobby_client:id()

		matchmaking_manager.add_broken_lobby(matchmaking_manager, lobby_id, t, false)

		if self.lobby_client then
			self.lobby_client:destroy()

			self.lobby_client = nil
		end

		table.clear(matchmaking_manager.ready_peers)

		for i = 1, MatchmakingSettings.MAX_NUMBER_OF_PLAYERS, 1 do
			matchmaking_ui.large_window_set_player_ready_state(matchmaking_ui, i, false)
		end

		self.state_context.join_lobby_data = nil

		self.handshaker_client:reset()

		local non_matchmaking_join = self.state_context.non_matchmaking_join

		if non_matchmaking_join then
			self.matchmaking_manager:cancel_join_lobby("user_cancel")

			return MatchmakingStateIdle, self.state_context
		else
			return MatchmakingStateSearchGame, self.state_context
		end
	end

	if self.show_popup then
		local backend_manager = Managers.backend
		local waiting_user_input = backend_manager.is_waiting_for_user_input(backend_manager)
		local waiting_for_item_poll = ScriptBackendItem.num_current_item_server_requests() ~= 0
		local rerolling = ScriptBackendItem.get_rerolling_trait_state() and not backend_manager.is_disconnected(backend_manager)

		if not waiting_user_input and not waiting_for_item_poll and not rerolling then
			self.show_popup = false

			self.spawn_join_popup(self)
		end
	end

	return nil
end
MatchmakingStateJoinGame._update_lobby_data = function (self, dt, t)
	self._update_lobby_data_timer = self._update_lobby_data_timer - dt

	if self._update_lobby_data_timer < 0 then
		self._update_lobby_data_timer = 0.5
		local lobby_data = self.lobby_data
		local lobby_client = self.lobby_client
		local selected_level_key = lobby_client.lobby_data(lobby_client, "selected_level_key")

		if lobby_data.selected_level_key ~= selected_level_key then
			lobby_data.selected_level_key = selected_level_key
		end

		local difficulty = lobby_client.lobby_data(lobby_client, "difficulty")

		if lobby_data.difficulty ~= difficulty then
			lobby_data.difficulty = difficulty
		end
	end

	return 
end
MatchmakingStateJoinGame.handle_popup_result = function (self, result, t)
	self.popup_id = nil
	local selected_hero_name = nil

	if result.accepted then
		selected_hero_name = result.selected_hero_name
		local hero_index = FindProfileIndex(selected_hero_name)
		self.selected_hero_name = selected_hero_name

		self.request_profile_from_host(self, hero_index)
	else
		if GameSettingsDevelopment.use_telemetry then
			reason = (self.popup_join_lobby_handler.cancel_timer < 0 and "timed_out") or "cancelled"
			local player_manager = Managers.player
			local player = player_manager.local_player(player_manager, 1)
			local current_hero_name = player.profile_display_name(player)
			local telemetry_id = player.telemetry_id(player)
			local time_taken = (self.selected_hero_at_t and self.selected_hero_at_t - self.hero_popup_at_t) or 0
			local telemetry_manager = Managers.telemetry

			telemetry_manager.add_matchmaking_select_player_telemetry(telemetry_manager, telemetry_id, current_hero_name, reason, selected_hero_name, time_taken)
		end

		self._exit_to_search_game = true
		local lobby_id = self.lobby_client:id()
		local is_bad_connection = false

		self.matchmaking_manager:add_broken_lobby(lobby_id, t, is_bad_connection)
	end

	return 
end
MatchmakingStateJoinGame.rpc_matchmaking_update_profiles_data = function (self, sender, client_cookie, host_cookie, profiles_data)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	self._update_profiles_data(self, profiles_data)

	if self.popup_id then
		self.popup_join_lobby_handler:update_lobby_data(self.lobby_data)
	end

	return 
end
MatchmakingStateJoinGame._update_profiles_data = function (self, profiles_data)
	local num_profiles = #SPProfiles

	for i = 1, num_profiles, 1 do
		local profile_data = (profiles_data[i] == "0" and "available") or profiles_data[i]
		self.lobby_data["player_slot_" .. i] = profile_data
	end

	self.matchmaking_manager.debug.profiles_data = self.lobby_data

	return 
end
MatchmakingStateJoinGame.get_transition = function (self)
	if self.join_lobby_data and self.next_transition_state then
		local start_lobby_data = {
			lobby_client = self.lobby_client
		}

		return self.next_transition_state, start_lobby_data
	end

	return 
end
MatchmakingStateJoinGame.spawn_join_popup = function (self)
	local state_context = self.state_context
	local peer_id = Network.peer_id()
	local player = Managers.player:player_from_peer_id(peer_id)
	local hero_index = player.profile_index
	local hero_data = SPProfiles[hero_index]
	local hero_name = hero_data.display_name
	local auto_cancel_time = MatchmakingSettings.JOIN_LOBBY_TIME_UNTIL_AUTO_CANCEL
	local lobby_data = self.lobby_data
	local join_by_lobby_browser = self.state_context.join_by_lobby_browser
	self.popup_id = self.popup_join_lobby_handler:show(hero_name, lobby_data, auto_cancel_time, join_by_lobby_browser)
	local time_manager = Managers.time
	self.hero_popup_at_t = time_manager.time(time_manager, "game")

	return 
end
MatchmakingStateJoinGame.request_profile_from_host = function (self, hero_index)
	local host = self.lobby_client:lobby_host()
	local lobby_client = self.lobby_client
	self.matchmaking_manager.selected_profile_index = hero_index

	self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_profile", hero_index)

	local host_name = host

	if rawget(_G, "Steam") and GameSettingsDevelopment.network_mode == "steam" then
		host_name = Steam.user_name(host)
	end

	self.matchmaking_manager.debug.text = "requesting_profile"
	self.matchmaking_manager.debug.state = "hosted by: " .. host_name
	self.matchmaking_manager.debug.level = lobby_client.lobby_data(lobby_client, "selected_level_key")

	return 
end
MatchmakingStateJoinGame.rpc_matchmaking_request_profile_reply = function (self, sender, client_cookie, host_cookie, profile, reply)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	local selected_hero_name = self.selected_hero_name
	local selected_hero_index = FindProfileIndex(selected_hero_name)
	local current_hero_index, current_hero_name = self._current_hero(self)
	local reason = nil

	fassert(profile == selected_hero_index, "wrong profile in rpc_matchmaking_request_profile_reply")

	if reply == true then
		self.matchmaking_manager.debug.text = "profile_accepted"
		reason = "profile_accepted"

		if current_hero_name == selected_hero_name then
			local level_started, level_key = self._level_started(self)

			if self.is_in_inn and level_started then
				mm_printf("Level already started, starting the countdown manually.")

				self.waiting_for_local_countdown = true

				self.network_transmit:queue_local_rpc("rpc_start_game_countdown", "game_starts_prepare")
			else
				self.set_state_to_start_lobby(self)
			end
		else
			self.set_state_to_start_lobby(self)
		end
	else
		reason = "profile_declined"
		self.matchmaking_manager.debug.text = "profile_declined"
		self.show_popup = true
	end

	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local player = player_manager.local_player(player_manager, 1)
		local telemetry_id = player.telemetry_id(player)
		local time_taken = (self.selected_hero_at_t and self.selected_hero_at_t - self.hero_popup_at_t) or 0
		local telemetry_manager = Managers.telemetry

		telemetry_manager.add_matchmaking_select_player_telemetry(telemetry_manager, telemetry_id, current_hero_name, reason, selected_hero_name, time_taken)
	end

	return 
end
MatchmakingStateJoinGame._current_hero = function (self)
	local peer_id = Network.peer_id()
	local player = Managers.player:player_from_peer_id(peer_id)
	local current_hero_index = player.profile_index
	local current_hero = SPProfiles[current_hero_index]
	local current_hero_name = current_hero.display_name

	return current_hero_index, current_hero_name
end
MatchmakingStateJoinGame._level_started = function (self)
	local lobby_client = self.lobby_client
	local selected_level_key = lobby_client.lobby_data(lobby_client, "selected_level_key")
	local level_key = lobby_client.lobby_data(lobby_client, "level_key")
	local level_started = selected_level_key == level_key

	return level_started, level_key
end
MatchmakingStateJoinGame.loading_context = function (self)
	return self.matchmaking_loading_context
end
MatchmakingStateJoinGame.rpc_matchmaking_join_game = function (self, sender, client_cookie, host_cookie)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	self.set_state_to_start_lobby(self)

	return 
end
MatchmakingStateJoinGame.active_lobby = function (self)
	return self.lobby_client
end
MatchmakingStateJoinGame.countdown_completed = function (self)
	if self.waiting_for_local_countdown then
		mm_printf("Countdown completed, joining game")

		local level_started, level_key = self._level_started(self)

		self.set_state_to_start_lobby(self)
	end

	return 
end
MatchmakingStateJoinGame.set_state_to_start_lobby = function (self)
	self.matchmaking_manager.debug.text = "starting_game"
	self.next_transition_state = "start_lobby"

	if Application.platform() == "ps4" and self.state_context.game_search_data then
		local statistics_db = self.statistics_db
		local state_context = self.state_context
		local game_search_data = state_context.game_search_data
		local search_region_level = game_search_data.search_region_level
		local started_matchmaking_t = game_search_data.started_matchmaking_t
		local time_manager = Managers.time
		local t = time_manager.time(time_manager, "game") or started_matchmaking_t
		local time_taken = t - started_matchmaking_t

		if search_region_level == "primary" then
			StatisticsUtil.register_matchmaking_game_joined_primary_region(statistics_db)
		elseif search_region_level == "secondary" then
			StatisticsUtil.register_matchmaking_game_joined_secondary_region(statistics_db)
		else
			print("Matchmaking Error: Joined without having a search_region_level!")
		end

		StatisticsUtil.register_matchmaking_game_joined(statistics_db)
		StatisticsUtil.register_matchmaking_game_joined_total_search_time(statistics_db, time_taken)
	end

	return 
end

return 
