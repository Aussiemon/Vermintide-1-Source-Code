MatchmakingStateFriendClient = class(MatchmakingStateFriendClient)
MatchmakingStateFriendClient.NAME = "MatchmakingStateFriendClient"
local fake_input_service = {
	get = function ()
		return
	end,
	has = function ()
		return
	end
}

MatchmakingStateFriendClient.init = function (self, params)
	self.matchmaking_ui = params.matchmaking_ui
	self.matchmaking_manager = params.matchmaking_manager
	self.handshaker_client = params.handshaker_client
	self.wwise_world = params.wwise_world
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
end

MatchmakingStateFriendClient.on_exit = function (self)
	self.matchmaking_ui:large_window_cancel_enable(true)
end

MatchmakingStateFriendClient.update = function (self, dt, t)
	if not Managers.state.game_mode or Managers.state.game_mode:level_key() ~= "inn_level" then
		return
	end

	local gamepad_active_last_frame = self._gamepad_active_last_frame
	local gamepad_active = Managers.input:is_device_active("gamepad")

	if gamepad_active ~= gamepad_active_last_frame then
		if not gamepad_active then
			self.matchmaking_ui:set_ready_progress(1)
			self.matchmaking_ui:set_cancel_progress(1)
		else
			self.matchmaking_ui:set_ready_progress(0)
			self.matchmaking_ui:set_cancel_progress(0)
		end
	end

	if self.handshaker_client:handshake_done() then
		local peer_id = Network.peer_id()

		if not self.request_data_done then
			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_ready_data")
			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_selected_level")
			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_selected_difficulty")
			self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_status_message")

			self.request_data_done = true

			if MatchmakingSettings.auto_ready and not self.ready then
				self.ready = true

				self.handshaker_client:send_rpc_to_host("rpc_matchmaking_set_ready", peer_id, self.ready)
				self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_unready")
				self.matchmaking_ui:large_window_stop_ready_pulse()
			else
				self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_ready")
				self.matchmaking_ui:large_window_start_ready_pulse()
			end

			self.matchmaking_manager.ready_peers[peer_id] = self.ready
		else
			local player_manager = Managers.player
			local player = player_manager:player(peer_id, 1)
			local can_use_input = player and Unit.alive(player.player_unit)
			local input_service = (can_use_input and Managers.input:get_service("ingame_menu")) or fake_input_service

			if self.controller_cooldown and self.controller_cooldown > 0 then
				self.controller_cooldown = self.controller_cooldown - dt
			else
				if input_service and input_service:get("matchmaking_ready_instigate") then
					self._started_readying = true
				end

				if input_service and input_service:get("matchmaking_ready") and self._started_readying then
					local ready_changed = false

					if gamepad_active then
						local total_time = 1
						local cancel_timer = self.cancel_timer
						cancel_timer = (cancel_timer and cancel_timer + dt) or dt
						local progress = math.min(cancel_timer / total_time, 1)

						if progress == 1 then
							self.ready = not self.ready
							ready_changed = true

							self.matchmaking_ui:set_ready_progress(0)

							self._started_readying = false
							self.controller_cooldown = GamepadSettings.menu_cooldown
						else
							self.cancel_timer = cancel_timer

							self.matchmaking_ui:set_ready_progress(progress)
						end
					else
						self.ready = not self.ready
						ready_changed = true
						self.cancel_timer = nil
						self._started_readying = false
					end

					if ready_changed then
						self.handshaker_client:send_rpc_to_host("rpc_matchmaking_set_ready", peer_id, self.ready)

						if self.ready then
							self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_unready")
							self.matchmaking_ui:large_window_stop_ready_pulse()
						else
							self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_ready")
							self.matchmaking_ui:large_window_start_ready_pulse()
						end
					end

					self.matchmaking_manager.ready_peers[peer_id] = self.ready
				elseif self.cancel_timer then
					self.cancel_timer = nil

					self.matchmaking_ui:set_ready_progress(0)

					self._started_readying = false
				end
			end
		end
	end

	self._gamepad_active_last_frame = gamepad_active
end

MatchmakingStateFriendClient.rpc_matchmaking_set_ready = function (self, sender, client_cookie, host_cookie, peer_id, ready)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return
	end

	local matchmaking_manager = self.matchmaking_manager
	local portrait_index = matchmaking_manager:get_portrait_index(peer_id)

	if not portrait_index then
		return
	end

	self.matchmaking_manager.ready_peers[peer_id] = ready

	self.matchmaking_ui:large_window_set_player_ready_state(portrait_index, ready)

	if ready then
		WwiseWorld.trigger_event(self.wwise_world, "Play_hud_matchmaking_ready")
	end
end

MatchmakingStateFriendClient.rpc_matchmaking_request_selected_level_reply = function (self, sender, client_cookie, host_cookie, selected_level_id)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return
	end

	local selected_level = NetworkLookup.level_keys[selected_level_id]

	self.matchmaking_ui:large_window_set_level(selected_level)
end

MatchmakingStateFriendClient.rpc_matchmaking_request_selected_difficulty_reply = function (self, sender, client_cookie, host_cookie, difficulty_id)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return
	end

	local difficulty = NetworkLookup.difficulties[difficulty_id]

	self.matchmaking_ui:large_window_set_difficulty(difficulty)
end

MatchmakingStateFriendClient.rpc_matchmaking_status_message = function (self, sender, client_cookie, host_cookie, status_message)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return
	end

	self.matchmaking_manager:set_status_message(status_message)
end

return
