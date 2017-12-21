MatchmakingStateFriendClient = class(MatchmakingStateFriendClient)
MatchmakingStateFriendClient.NAME = "MatchmakingStateFriendClient"
MatchmakingStateFriendClient.init = function (self, params)
	self.matchmaking_ui = params.matchmaking_ui
	self.matchmaking_manager = params.matchmaking_manager
	self.handshaker_client = params.handshaker_client
	self.wwise_world = params.wwise_world

	return 
end
MatchmakingStateFriendClient.destroy = function (self)
	return 
end
MatchmakingStateFriendClient.on_enter = function (self, state_context)
	self.matchmaking_ui:large_window_cancel_enable(false)
	self.matchmaking_ui:large_window_ready_enable(true)

	local peer_id = Network.peer_id()
	self.ready = false
	self.request_data_done = false

	self.matchmaking_ui:set_search_zone_host_title("matchmaking_status_client")

	local private_game = state_context.private_game
	local window_title = (private_game and "status_private") or "status_matchmaking"

	self.matchmaking_ui:large_window_set_title(window_title)

	return 
end
MatchmakingStateFriendClient.on_exit = function (self)
	self.matchmaking_ui:large_window_cancel_enable(true)

	return 
end
MatchmakingStateFriendClient.update = function (self, dt, t)
	if not Managers.state.game_mode or Managers.state.game_mode:level_key() ~= "inn_level" then
		return 
	end

	if self.handshaker_client:handshake_done() then
		if not self.request_data_done then
			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_ready_data")
			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_selected_level")
			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_selected_difficulty")
			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_status_message")

			self.request_data_done = true
			local peer_id = Network.peer_id()

			if MatchmakingSettings.auto_ready and not self.ready then
				self.ready = true

				self.handshaker_client:send_rpc_to_host("rpc_matchmaking_set_ready", peer_id, self.ready)
				self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_unready", "matchmaking_ready")
				self.matchmaking_ui:large_window_stop_ready_pulse()
			else
				self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_ready", "matchmaking_ready")
				self.matchmaking_ui:large_window_start_ready_pulse()
			end

			self.matchmaking_manager.ready_peers[peer_id] = self.ready
		else
			local input_service = Managers.input:get_service("ingame_menu")

			if self.controller_cooldown and 0 < self.controller_cooldown then
				self.controller_cooldown = self.controller_cooldown - dt
			elseif input_service and input_service.get(input_service, "matchmaking_ready", true) then
				local ready_changed = false

				if Managers.input:is_device_active("gamepad") then
					local total_time = 1
					local cancel_timer = self.cancel_timer
					cancel_timer = (cancel_timer and cancel_timer + dt) or dt
					local progress = math.min(cancel_timer/total_time, 1)

					if progress == 1 then
						self.ready = not self.ready
						self.cancel_timer = nil
						ready_changed = true

						self.matchmaking_ui:set_ready_progress(0)

						self.controller_cooldown = GamepadSettings.menu_cooldown
					else
						self.cancel_timer = cancel_timer

						self.matchmaking_ui:set_ready_progress(progress)
					end
				else
					self.ready = not self.ready
					ready_changed = true

					self.matchmaking_ui:set_ready_progress(0)

					self.controller_cooldown = GamepadSettings.menu_cooldown
				end

				local peer_id = Network.peer_id()

				if ready_changed then
					self.handshaker_client:send_rpc_to_host("rpc_matchmaking_set_ready", peer_id, self.ready)

					if self.ready then
						self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_unready", "matchmaking_ready")
						self.matchmaking_ui:large_window_stop_ready_pulse()
					else
						self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_ready", "matchmaking_ready")
						self.matchmaking_ui:large_window_start_ready_pulse()
					end
				end

				self.matchmaking_manager.ready_peers[peer_id] = self.ready
			else
				self.cancel_timer = nil

				self.matchmaking_ui:set_ready_progress(0)
			end
		end
	end

	return 
end
MatchmakingStateFriendClient.rpc_matchmaking_set_ready = function (self, sender, client_cookie, host_cookie, peer_id, ready)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	local matchmaking_manager = self.matchmaking_manager
	local portrait_index = matchmaking_manager.get_portrait_index(matchmaking_manager, peer_id)

	if not portrait_index then
		return 
	end

	self.matchmaking_manager.ready_peers[peer_id] = ready

	self.matchmaking_ui:large_window_set_player_ready_state(portrait_index, ready)

	if ready then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_matchmaking_ready")
	end

	return 
end
MatchmakingStateFriendClient.rpc_matchmaking_request_selected_level_reply = function (self, sender, client_cookie, host_cookie, selected_level_id)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	local selected_level = NetworkLookup.level_keys[selected_level_id]

	self.matchmaking_ui:large_window_set_level(selected_level)

	return 
end
MatchmakingStateFriendClient.rpc_matchmaking_request_selected_difficulty_reply = function (self, sender, client_cookie, host_cookie, difficulty_id)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	local difficulty = NetworkLookup.difficulties[difficulty_id]

	self.matchmaking_ui:large_window_set_difficulty(difficulty)

	return 
end
MatchmakingStateFriendClient.rpc_matchmaking_status_message = function (self, sender, client_cookie, host_cookie, status_message)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	self.matchmaking_manager:set_status_message(status_message)

	return 
end

return 
