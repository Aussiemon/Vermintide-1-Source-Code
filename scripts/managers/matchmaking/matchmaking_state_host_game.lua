-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
MatchmakingStateHostGame = class(MatchmakingStateHostGame)
MatchmakingStateHostGame.NAME = "MatchmakingStateHostGame"
MatchmakingStateHostGame.init = function (self, params)
	self.lobby = params.lobby
	self.network_transmit = params.network_transmit
	self.difficulty_manager = params.difficulty
	self.level_transition_handler = params.level_transition_handler
	self.is_server = params.is_server
	self.profile_synchronizer = params.profile_synchronizer
	self.popup_join_lobby_handler = params.popup_join_lobby_handler
	self.hero_spawner_handler = params.hero_spawner_handler
	self.matchmaking_manager = params.matchmaking_manager
	self.handshaker_host = params.handshaker_host
	self.connection_handler = params.network_transmit.connection_handler
	self.matchmaking_ui = params.matchmaking_ui
	self.wwise_world = params.wwise_world
	local network_event_delegate = params.network_event_delegate
	self.network_event_delegate = network_event_delegate
	self.hero_popup_at_t = nil
	self.selected_hero_at_t = nil

	return 
end
MatchmakingStateHostGame.destroy = function (self)
	return 
end
MatchmakingStateHostGame.on_enter = function (self, state_context)
	self.state_context = state_context
	self.game_declined = false
	local game_data = state_context.game_search_data
	local number_of_players = Managers.player:num_human_players()
	local private_game = game_data.private_game
	local num_connections = table.size(self.connection_handler.current_connections)

	self.start_hosting_game(self)
	self.set_debug_info(self)

	local level = game_data.level_key
	local difficulty = game_data.difficulty

	self.matchmaking_ui:large_window_set_level(level)
	self.matchmaking_ui:large_window_set_difficulty(difficulty)
	self.matchmaking_ui:set_search_zone_host_title("matchmaking_status_host")

	self.next_state_timer = nil
	local window_title = (private_game and "status_private") or "status_matchmaking"

	self.matchmaking_ui:large_window_set_title(window_title)

	local peer_id = Network.peer_id()

	self.matchmaking_ui:large_window_stop_ready_pulse()
	self.matchmaking_ui:large_window_ready_enable(false)

	if MatchmakingSettings.auto_ready then
		self.ready = true

		self.handshaker_host:send_rpc_to_self("rpc_matchmaking_set_ready", peer_id, self.ready)
		self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_unready")
	else
		self.ready = false

		self.handshaker_host:send_rpc_to_self("rpc_matchmaking_set_ready", peer_id, self.ready)
		self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_ready")
	end

	return 
end
MatchmakingStateHostGame.set_debug_info = function (self)
	local game_data = self.state_context.game_search_data
	local level = game_data.level_key
	local difficulty = game_data.difficulty
	local peer_id = Network.peer_id()
	local player = Managers.player:player_from_peer_id(peer_id)
	local hero_index = player.profile_index
	local hero_data = SPProfiles[hero_index]
	local hero_name = hero_data.display_name
	Managers.matchmaking.debug.state = "hosting game"
	Managers.matchmaking.debug.level = level
	Managers.matchmaking.debug.difficulty = difficulty
	Managers.matchmaking.debug.hero = hero_name
	Managers.matchmaking.debug.progression = game_data.required_progression

	return 
end
MatchmakingStateHostGame.on_exit = function (self)
	return 
end
MatchmakingStateHostGame.update = function (self, dt, t)
	if self.spawn_join_popup_timer then
		self.spawn_join_popup_timer = self.spawn_join_popup_timer - dt

		if self.spawn_join_popup_timer < 0 then
			self.spawn_join_popup(self, t)

			self.spawn_join_popup_timer = nil
		end
	end

	local popup_join_lobby_handler = self.popup_join_lobby_handler
	local popup_id = self.popup_id

	if popup_id then
		local popup_result = popup_join_lobby_handler.query_result(popup_join_lobby_handler, popup_id)

		if popup_result then
			self.selected_hero_at_t = t

			self.handle_popup_result(self, popup_result)
		end
	end

	local hero_spawner_handler = self.hero_spawner_handler
	local hero_spawner_request_id = self.hero_spawner_request_id

	if hero_spawner_request_id then
		local hero_spawner_result = hero_spawner_handler.query_result(hero_spawner_handler, hero_spawner_request_id)

		if hero_spawner_result then
			self.handle_hero_spawner_result(self, hero_spawner_result)
		end
	end

	local input_service = Managers.input:get_service("ingame_menu")

	if self.controller_cooldown and 0 < self.controller_cooldown then
		self.controller_cooldown = self.controller_cooldown - dt
	end

	if self.game_created then
		if not self.next_state_timer then
			self.matchmaking_manager:set_status_message("matchmaking_status_start_hosting_game")

			self.next_state_timer = MatchmakingSettings.MIN_STATUS_MESSAGE_TIME
		end

		self.next_state_timer = self.next_state_timer - dt

		if 0 < self.next_state_timer then
			return nil
		end

		if self.start_directly then
			if GameSettingsDevelopment.use_telemetry then
				local player_manager = Managers.player
				local player = player_manager.local_player(player_manager, 1)
				local started_matchmaking_t = self.matchmaking_manager.started_matchmaking_t
				local time_taken = t - started_matchmaking_t
				local connection_state = "host_game_start_directly"
				local telemetry_manager = Managers.telemetry

				telemetry_manager.add_matchmaking_connection_telemetry(telemetry_manager, player, connection_state, time_taken)
			end

			return MatchmakingStateStartGame, self.state_context
		else
			return MatchmakingStateSearchPlayers, self.state_context
		end
	end

	if self.game_declined then
		return MatchmakingStateIdle, self.state_context
	end

	return nil
end
MatchmakingStateHostGame.spawn_join_popup = function (self, t)
	local lobby_data = self.lobby:get_stored_lobby_data()
	local state_context = self.state_context
	local game_data = state_context.game_search_data
	local level = game_data.level_key
	local difficulty = game_data.difficulty
	local peer_id = Network.peer_id()
	local player = Managers.player:player_from_peer_id(peer_id)
	local hero_index = player.profile_index
	local hero_data = SPProfiles[hero_index]
	local hero_name = hero_data.display_name
	local auto_cancel_time = MatchmakingSettings.JOIN_LOBBY_TIME_UNTIL_AUTO_CANCEL
	self.popup_id = self.popup_join_lobby_handler:show(hero_name, difficulty, level, lobby_data, auto_cancel_time)
	self.hero_popup_at_t = t

	return 
end
MatchmakingStateHostGame.handle_popup_result = function (self, result)
	self.popup_id = nil
	local reason, selected_hero_name = nil

	if result.accepted then
		local peer_id = Network.peer_id()
		local player = Managers.player:player_from_peer_id(peer_id)
		local current_hero_index = player.profile_index
		local current_hero = SPProfiles[current_hero_index]
		local current_hero_name = current_hero.display_name
		local hero_spawner_handler = self.hero_spawner_handler
		selected_hero_name = result.selected_hero_name
		self.selected_hero_name = selected_hero_name

		if current_hero_name == selected_hero_name then
			self.start_hosting_game(self)
		else
			self.hero_spawner_request_id = hero_spawner_handler.spawn_hero_request(hero_spawner_handler, player, selected_hero_name)
		end

		reason = "profile_accepted"
	else
		local popup_join_lobby_handler = self.popup_join_lobby_handler
		local cancel_timer = popup_join_lobby_handler.cancel_timer

		if cancel_timer < 0 then
			reason = "timed_out"
		else
			reason = "cancelled"
		end

		self.matchmaking_manager:cancel_matchmaking()
	end

	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local player = player_manager.local_player(player_manager, 1)
		local telemetry_id = player.telemetry_id(player)
		local hero = player.profile_display_name(player)
		local time_taken = (self.selected_hero_at_t and self.selected_hero_at_t - self.hero_popup_at_t) or 0
		local telemetry_manager = Managers.telemetry

		telemetry_manager.add_matchmaking_select_player_telemetry(telemetry_manager, telemetry_id, hero, reason, selected_hero_name, time_taken)
	end

	return 
end
MatchmakingStateHostGame.handle_hero_spawner_result = function (self, result)
	if result == "success" then
		self.start_hosting_game(self)
	end

	self.hero_spawner_request_id = nil

	return 
end
MatchmakingStateHostGame.start_hosting_game = function (self)
	local state_context = self.state_context
	local game_data = state_context.game_search_data

	self.profile_synchronizer:update_lobby_profile_data()

	self.start_directly = self.host_game(self, game_data.level_key, game_data.difficulty, game_data.game_mode, game_data.private_game, game_data.required_progression)
	self.private_game = game_data.private_game
	self.game_created = true

	return 
end
MatchmakingStateHostGame.host_game = function (self, next_level_key, difficulty, game_mode, private_game, required_progression)
	self.difficulty_manager:set_difficulty(difficulty)

	local level_transition_handler = self.level_transition_handler
	local current_level_key = level_transition_handler.get_current_level_keys(level_transition_handler)
	local lobby_members = self.lobby:members()
	local members = lobby_members.get_members(lobby_members)
	local num_players = #members
	local start_directly = false
	local is_matchmaking = not private_game
	local lobby_data = self.lobby:get_stored_lobby_data()
	lobby_data.level_key = current_level_key
	lobby_data.game_mode = game_mode
	lobby_data.matchmaking = (is_matchmaking and "true") or "false"
	lobby_data.selected_level_key = next_level_key
	lobby_data.unique_server_name = LobbyAux.get_unique_server_name()
	lobby_data.host = Network.peer_id()
	lobby_data.num_players = num_players
	lobby_data.difficulty = difficulty
	lobby_data.required_progression = required_progression
	lobby_data.country_code = rawget(_G, "Steam") and Steam.user_country_code()

	level_transition_handler.set_next_level(level_transition_handler, next_level_key)
	self.lobby:set_lobby_data(lobby_data)
	print("[MATCHMAKING] - Hosting game on level:", current_level_key, next_level_key)

	return start_directly
end
MatchmakingStateHostGame.rpc_matchmaking_set_ready = function (self, sender, client_cookie, host_cookie, peer_id, ready)
	if not self.handshaker_host:validate_cookies(sender, client_cookie, host_cookie) then
		return 
	end

	local matchmaking_manager = self.matchmaking_manager
	local portrait_index = matchmaking_manager.get_portrait_index(matchmaking_manager, peer_id)
	local ready_peers = matchmaking_manager.ready_peers
	ready_peers[peer_id] = ready

	self.matchmaking_ui:large_window_set_player_ready_state(portrait_index, ready)
	self.handshaker_host:send_rpc_to_clients("rpc_matchmaking_set_ready", peer_id, ready)

	if ready then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_matchmaking_ready")
	end

	return 
end
MatchmakingStateHostGame.rpc_matchmaking_request_ready_data = function (self, sender, client_cookie, host_cookie)
	if not self.handshaker_host:validate_cookies(sender, client_cookie, host_cookie) then
		return 
	end

	local matchmaking_manager = self.matchmaking_manager
	local ready_peers = matchmaking_manager.ready_peers
	local host_peer_id = Network.peer_id()
	local host_ready = ready_peers[host_peer_id] or false

	self.handshaker_host:send_rpc_to_client("rpc_matchmaking_set_ready", sender, host_peer_id, host_ready)

	local current_connections = self.network_transmit.connection_handler.current_connections

	for peer_id, _ in pairs(current_connections) do
		local ready = ready_peers[peer_id] or false

		self.handshaker_host:send_rpc_to_client("rpc_matchmaking_set_ready", sender, peer_id, ready)
	end

	return 
end

return 
