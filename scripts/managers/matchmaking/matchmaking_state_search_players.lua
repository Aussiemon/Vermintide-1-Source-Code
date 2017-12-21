MatchmakingStateSearchPlayers = class(MatchmakingStateSearchPlayers)
MatchmakingStateSearchPlayers.NAME = "MatchmakingStateSearchPlayers"
local telemetry_data = {}
MatchmakingStateSearchPlayers.init = function (self, params)
	self.lobby = params.lobby
	self.network_transmit = params.network_transmit
	self.network_server = params.network_server
	self.matchmaking_manager = params.matchmaking_manager
	self._popup_handler = params.popup_handler
	self.handshaker_host = params.handshaker_host
	self.matchmaking_ui = params.matchmaking_ui
	self.wwise_world = params.wwise_world

	return 
end
MatchmakingStateSearchPlayers.destroy = function (self)
	return 
end
MatchmakingStateSearchPlayers.on_enter = function (self, state_context)
	self.state_context = state_context
	local lobby_members = self.lobby:members()
	local members_joined = lobby_members.get_members(lobby_members)
	self.number_of_players = #members_joined
	local game_data = state_context.game_search_data
	local private_game = game_data.private_game
	self.status_message = (private_game and "matchmaking_status_waiting_for_other_players") or "matchmaking_status_searching_for_players"

	self.matchmaking_manager:set_status_message(self.status_message)
	self.matchmaking_ui:large_window_ready_enable(true)

	return 
end
MatchmakingStateSearchPlayers.on_exit = function (self)
	self.matchmaking_ui:large_window_stop_ready_pulse()
	self.matchmaking_ui:large_window_ready_enable(false)
	self.matchmaking_ui:set_action_area_visible(false)

	return 
end
MatchmakingStateSearchPlayers.update = function (self, dt, t)
	local status_message = self.status_message
	local peer_id = Network.peer_id()
	local current_number_of_members = self.current_number_lobby_members(self)
	local ready_peers = self.matchmaking_manager.ready_peers
	local all_peers_ingame = self.network_server:are_all_peers_ingame()
	local all_peers_ready = self.matchmaking_manager:all_peers_ready()
	local full_group = current_number_of_members == MatchmakingSettings.MAX_NUMBER_OF_PLAYERS
	local private_game = self.state_context.game_search_data.private_game

	if full_group or private_game then
		if not all_peers_ingame then
			status_message = "matchmaking_status_waiting_for_other_players"
		elseif all_peers_ready then
			status_message = "matchmaking_status_waiting_for_host"
		else
			local clients_ready = table.size(ready_peers) == MatchmakingSettings.MAX_NUMBER_OF_PLAYERS

			for client_peer_id, ready in pairs(ready_peers) do
				if not ready and client_peer_id ~= peer_id then
					clients_ready = false

					break
				end
			end

			if not clients_ready then
				status_message = "matchmaking_status_waiting_for_other_players"
			else
				status_message = "matchmaking_status_waiting_for_host"
			end
		end
	else
		status_message = "matchmaking_status_searching_for_players"
	end

	if status_message ~= self.status_message then
		self.status_message = status_message

		self.matchmaking_manager:set_status_message(status_message)
	end

	local input_service = Managers.input:get_service("ingame_menu")

	if self.full_group_timer then
		local full_group_timer_ended = (all_peers_ready and all_peers_ingame and self.update_full_group_timer(self, dt)) or false

		if full_group_timer_ended then
			if GameSettingsDevelopment.use_telemetry then
				local player_manager = Managers.player
				local player = player_manager.local_player(player_manager, 1)
				local started_matchmaking_t = self.matchmaking_manager.started_matchmaking_t
				local time_taken = t - started_matchmaking_t
				local connection_state = "search_players_successful"
				local telemetry_manager = Managers.telemetry

				telemetry_manager.add_matchmaking_connection_telemetry(telemetry_manager, player, connection_state, time_taken)
			end

			return MatchmakingStateStartGame, self.state_context
		end
	elseif all_peers_ready and all_peers_ingame then
		if self.full_group_timer == nil then
			if not self.can_start then
				self.can_start = true

				self.matchmaking_ui:set_action_area_visible(true)
				self.matchmaking_ui:large_window_set_action_button_text("matchmaking_surfix_start", "matchmaking_start")
			end

			if self.controller_cooldown and 0 < self.controller_cooldown then
				self.controller_cooldown = self.controller_cooldown - dt
			elseif input_service.get(input_service, "matchmaking_start", true) then
				if Managers.input:is_device_active("gamepad") then
					local total_time = 1
					local cancel_timer = self.start_cancel_timer
					cancel_timer = (cancel_timer and cancel_timer + dt) or dt
					local progress = math.min(cancel_timer/total_time, 1)

					if progress == 1 then
						self.full_group_timer = 1

						self.matchmaking_ui:set_action_area_visible(false)

						self.start_cancel_timer = nil

						self.matchmaking_ui:set_start_progress(0)

						self.controller_cooldown = GamepadSettings.menu_cooldown
					else
						self.start_cancel_timer = cancel_timer

						self.matchmaking_ui:set_start_progress(progress)
					end
				else
					self.full_group_timer = 1

					self.matchmaking_ui:set_action_area_visible(false)
					self.matchmaking_ui:set_start_progress(0)

					self.controller_cooldown = GamepadSettings.menu_cooldown
				end
			else
				self.start_cancel_timer = nil

				self.matchmaking_ui:set_start_progress(0)
			end
		end
	elseif self.can_start then
		self.can_start = false

		self.matchmaking_ui:set_action_area_visible(false)
	end

	if self.controller_cooldown and 0 < self.controller_cooldown then
		self.controller_cooldown = self.controller_cooldown - dt
	elseif input_service.get(input_service, "matchmaking_ready", true) then
		local ready = nil
		local ready_changed = false

		if Managers.input:is_device_active("gamepad") then
			local total_time = 1
			local cancel_timer = self.cancel_timer
			cancel_timer = (cancel_timer and cancel_timer + dt) or dt
			local progress = math.min(cancel_timer/total_time, 1)

			if progress == 1 then
				ready = not self.matchmaking_manager.ready_peers[peer_id]
				self.cancel_timer = nil
				ready_changed = true

				self.matchmaking_ui:set_ready_progress(0)

				self.controller_cooldown = GamepadSettings.menu_cooldown
			else
				self.cancel_timer = cancel_timer

				self.matchmaking_ui:set_ready_progress(progress)
			end
		else
			ready = not self.matchmaking_manager.ready_peers[peer_id]
			ready_changed = true

			self.matchmaking_ui:set_ready_progress(0)

			self.controller_cooldown = GamepadSettings.menu_cooldown
		end

		if ready_changed then
			self.handshaker_host:send_rpc_to_self("rpc_matchmaking_set_ready", peer_id, ready)

			if ready then
				self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_unready", "matchmaking_ready")
				self.matchmaking_ui:large_window_stop_ready_pulse()
			else
				self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_ready", "matchmaking_ready")
				self.matchmaking_ui:large_window_start_ready_pulse()
			end
		end
	elseif self.cancel_timer then
		self.cancel_timer = nil

		self.matchmaking_ui:set_ready_progress(0)
	end

	local can_flash_window = _G.Window ~= nil and Window.flash_window ~= nil

	if can_flash_window and not Window.has_focus() and self.number_of_players < current_number_of_members then
		Window.flash_window(nil, "start", 5)
	end

	self.number_of_players = current_number_of_members

	return nil
end
MatchmakingStateSearchPlayers.update_full_group_timer = function (self, dt)
	self.full_group_timer = self.full_group_timer - dt
	local time_left = math.round(self.full_group_timer)
	Managers.matchmaking.debug.text = "full group, starting in: " .. time_left

	return self.full_group_timer < 0
end
MatchmakingStateSearchPlayers.current_number_lobby_members = function (self)
	local lobby_members = self.lobby:members()
	local members_joined = lobby_members.get_members(lobby_members)

	return #members_joined
end
MatchmakingStateSearchPlayers.rpc_matchmaking_request_profile = function (self, sender, client_cookie, host_cookie, profile)
	if not self.handshaker_host:validate_cookies(sender, client_cookie, host_cookie) then
		return 
	end

	return 
end
MatchmakingStateSearchPlayers.rpc_matchmaking_set_ready = function (self, sender, client_cookie, host_cookie, peer_id, ready)
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
MatchmakingStateSearchPlayers.rpc_matchmaking_request_ready_data = function (self, sender, client_cookie, host_cookie)
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
