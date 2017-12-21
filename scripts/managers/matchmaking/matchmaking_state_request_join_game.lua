MatchmakingStateRequestJoinGame = class(MatchmakingStateRequestJoinGame)
MatchmakingStateRequestJoinGame.NAME = "MatchmakingStateRequestJoinGame"
MatchmakingStateRequestJoinGame.init = function (self, params)
	self.lobby = params.lobby
	self.network_options = params.network_options
	self.network_transmit = params.network_transmit
	self.level_transition_handler = params.level_transition_handler
	self.network_server = params.network_server
	self.popup_join_lobby_handler = params.popup_join_lobby_handler
	self.hero_spawner_handler = params.hero_spawner_handler
	self.matchmaking_manager = params.matchmaking_manager
	self.is_server = params.is_server
	self.profile_synchronizer = params.profile_synchronizer
	self.handshaker_client = params.handshaker_client
	self.matchmaking_ui = params.matchmaking_ui
	self.matchmaking_manager.selected_profile_index = nil
	self.matchmaking_loading_context = {}
	self.state = "waiting_to_join_lobby"

	return 
end
MatchmakingStateRequestJoinGame.destroy = function (self)
	return 
end
MatchmakingStateRequestJoinGame.on_enter = function (self, state_context)
	self.game_reply = nil
	self.connected_to_server = false
	self.connect_timeout = nil
	self.join_timeout = nil
	self.state_context = state_context
	self.join_lobby_data = state_context.join_lobby_data

	self._setup_lobby_connection(self, self.join_lobby_data)

	local host = self.join_lobby_data.host or "nohostname"
	self.matchmaking_manager.debug.text = "Joining lobby"
	self.matchmaking_manager.debug.state = "hosted by: " .. host

	self.matchmaking_manager:set_status_message("matchmaking_status_joining_game")

	return 
end
MatchmakingStateRequestJoinGame.on_exit = function (self)
	return 
end
MatchmakingStateRequestJoinGame._setup_lobby_connection = function (self, join_lobby_data)
	local development_port = Development.parameter("server_port") or GameSettingsDevelopment.network_port
	development_port = development_port + 0
	local lobby_port = (LEVEL_EDITOR_TEST and GameSettingsDevelopment.editor_lobby_port) or development_port
	local network_options = {
		project_hash = "bulldozer",
		max_members = 4,
		config_file_name = "global",
		lobby_port = lobby_port
	}
	self.lobby_client = LobbyClient:new(network_options, join_lobby_data)

	return 
end
MatchmakingStateRequestJoinGame.update = function (self, dt, t)
	local lobby_client = self.lobby_client

	lobby_client.update(lobby_client, dt)

	local host = lobby_client.lobby_host(lobby_client)
	local lobby_id = lobby_client.id(lobby_client)
	local new_lobby_state = lobby_client.state

	if new_lobby_state == LobbyState.FAILED then
		return self.join_game_failed(self, lobby_id, new_lobby_state, t, true)
	end

	local state = self.state

	if state == "waiting_to_join_lobby" then
		if new_lobby_state == LobbyState.JOINED and host ~= "0" then
			self.matchmaking_manager.debug.text = "Connecting to host"
			local host_name = (LobbyInternal.user_name and LobbyInternal.user_name(host)) or (lobby_client.user_name and lobby_client.user_name(lobby_client, host)) or "-"

			mm_printf("Joined lobby, waiting to connect to host with user name '%s'...", tostring(host_name))

			self.state = "waiting_to_connect"
			self.connect_timeout = t + MatchmakingSettings.REQUEST_JOIN_LOBBY_REPLY_TIME
		end
	elseif state == "waiting_to_connect" then
		if self.connected_to_server then
			self.matchmaking_manager.debug.text = "Handshaking"

			mm_printf("Connected, starting handshake...")
			self.handshaker_client:start_handshake(host)

			self.handshake_timeout = t + MatchmakingSettings.REQUEST_JOIN_LOBBY_REPLY_TIME
			self.state = "waiting_for_handshake"
		elseif self.connect_timeout < t then
			local host_name = (LobbyInternal.user_name and LobbyInternal.user_name(host)) or "-"

			mm_printf_force("Failed to connect to host due to timeout. lobby_id=%s, host_id:%s", lobby_id, host_name)

			return self.join_game_failed(self, lobby_id, "connection_timeout", t, true)
		end
	elseif self.state == "waiting_for_handshake" then
		local handshake_time = self.handshake_timeout - t + 1
		self.matchmaking_manager.debug.text = string.format("Waiting for handshake %s [%.0f]", self.lobby_client:id(), handshake_time)

		if self.handshaker_client:handshake_done() then
			self.matchmaking_manager.debug.text = "Requesting to join"

			mm_printf("Handshake done, requesting to join game...")

			local friend_join = not not self.state_context.friend_join

			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_join_lobby", lobby_id, friend_join)

			self.join_timeout = t + MatchmakingSettings.REQUEST_JOIN_LOBBY_REPLY_TIME
			self.state = "asking_to_join"
		elseif self.handshake_timeout < t then
			local host_name = (LobbyInternal.user_name and LobbyInternal.user_name(host)) or "-"

			mm_printf("Failed to resolve handshake in time. lobby_id=%s, host_id:%s", lobby_id, host_name)

			return self.join_game_failed(self, lobby_id, "handshake_timeout", t, true)
		end
	elseif state == "asking_to_join" then
		local join_time = MatchmakingSettings.REQUEST_JOIN_LOBBY_REPLY_TIME - self.join_timeout - t
		self.matchmaking_manager.debug.text = string.format("Requesting to join game %s [%.0f]", self.lobby_client:id(), join_time)
		local host_name = (LobbyInternal.user_name and LobbyInternal.user_name(host)) or "-"
		local game_reply = self.game_reply

		if self.join_timeout < t then
			mm_printf_force("Failed to join game due to timeout. lobby_id=%s, host_id:%s", lobby_id, host_name)

			return self.join_game_failed(self, lobby_id, "join_timeout", t, true)
		elseif game_reply ~= nil then
			if game_reply == "lobby_ok" then
				mm_printf("Successfully joined game after %.2f seconds: lobby_id=%s host_id:%s", join_time, lobby_id, host_name)

				return self.join_game_success(self, t)
			else
				mm_printf_force("Failed to join game due to host responding '%s'. lobby_id=%s, host_id:%s", game_reply, lobby_id, host_name)

				return self.join_game_failed(self, lobby_id, game_reply, t, game_reply == "lobby_id_mismatch")
			end
		end
	end

	return nil
end
MatchmakingStateRequestJoinGame.join_game_success = function (self, t)
	self.state_context.lobby_client = self.lobby_client

	return MatchmakingStateRequestProfiles, self.state_context
end
MatchmakingStateRequestJoinGame.join_game_failed = function (self, lobby_id, reason, t, is_bad_connection)
	self.matchmaking_manager:add_broken_lobby(lobby_id, t, is_bad_connection)
	self.lobby_client:destroy()

	self.lobby_client = nil

	self.handshaker_client:reset()

	self.state_context.join_lobby_data = nil
	local non_matchmaking_join = self.state_context.non_matchmaking_join

	if non_matchmaking_join then
		self.matchmaking_manager:cancel_join_lobby(reason)

		return MatchmakingStateIdle, self.state_context
	else
		return MatchmakingStateSearchGame, self.state_context
	end

	return 
end
MatchmakingStateRequestJoinGame.rpc_matchmaking_request_join_lobby_reply = function (self, sender, client_cookie, host_cookie, reply_id)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	self.game_reply = NetworkLookup.game_ping_reply[reply_id]

	return 
end
MatchmakingStateRequestJoinGame.rpc_notify_connected = function (self, sender)
	self.connected_to_server = true

	return 
end

return 
