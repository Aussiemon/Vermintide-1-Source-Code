MatchmakingStateSearchGame = class(MatchmakingStateSearchGame)
MatchmakingStateSearchGame.NAME = "MatchmakingStateSearchGame"
MatchmakingStateSearchGame.init = function (self, params)
	self.lobby = params.lobby
	self.lobby_finder = params.lobby_finder
	self.peer_id = Network:peer_id()
	self.matchmaking_manager = params.matchmaking_manager
	self.connection_handler = params.network_transmit.connection_handler
	self.matchmaking_ui = params.matchmaking_ui
	self.level_transition_handler = params.level_transition_handler

	return 
end
MatchmakingStateSearchGame.destroy = function (self)
	return 
end
MatchmakingStateSearchGame.on_enter = function (self, state_context)
	self.state_context = state_context
	self.game_search_data = state_context.game_search_data
	self.total_search_timer = 0
	self.num_searches = 0

	self.matchmaking_manager:add_filter_requirements()

	local lobby_data = self.lobby:get_stored_lobby_data()
	lobby_data.matchmaking = "searching"
	lobby_data.time_of_search = tostring(os.time())

	self.lobby:set_lobby_data(lobby_data)
	self.matchmaking_ui:set_zone_visible(true)
	self.matchmaking_ui:large_window_set_search_zone_title("matchmaking_zone_close")
	self.matchmaking_manager:set_status_message("matchmaking_status_searching_for_game")

	local game_search_data = self.game_search_data

	if game_search_data.level_filter then
		self.matchmaking_ui:large_window_set_level(nil, "title_mission_list", "level_image_level_list")
	else
		local level_image = (game_search_data.quick_game and "level_any") or game_search_data.level_key

		self.matchmaking_ui:large_window_set_level(level_image)
	end

	local difficulty = game_search_data.difficulty

	self.matchmaking_ui:large_window_set_difficulty(difficulty)

	self.host_game_countdown_timer = nil

	self.level_transition_handler:set_next_level(nil)
	self.matchmaking_ui:large_window_ready_enable(true)
	self.matchmaking_ui:large_window_set_ready_button_text("matchmaking_surfix_become_host")
	self.matchmaking_ui:large_window_stop_ready_pulse()

	local private_game = state_context.private_game
	local window_title = (private_game and "status_private") or "status_matchmaking"

	self.matchmaking_ui:large_window_set_title(window_title)

	return 
end
MatchmakingStateSearchGame.on_exit = function (self)
	self.matchmaking_ui:large_window_ready_enable(false)

	return 
end
MatchmakingStateSearchGame.update = function (self, dt, t)
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

	local num_connections = table.size(self.connection_handler.current_connections)

	if 0 < num_connections then
		mm_printf("Leaving MatchmakingStateSearchGame and becoming host due to having connections, probably a friend joining.")

		return MatchmakingStateHostGame, self.state_context
	end

	if self.state_context.join_lobby_data then
		if not self.next_state_timer then
			self.matchmaking_manager:set_status_message("matchmaking_status_found_game")

			self.next_state_timer = MatchmakingSettings.MIN_STATUS_MESSAGE_TIME
		end

		self.next_state_timer = self.next_state_timer - dt

		if 0 < self.next_state_timer then
			return nil
		end

		return MatchmakingStateRequestJoinGame, self.state_context
	end

	local new_lobby = self.search_for_game(self, dt)
	local search_time_ended = self.update_search_timer(self, dt)

	if search_time_ended then
		local distance_filter = self.state_context.game_search_data.distance_filter
		local next_distance_filter = LobbyDistanceFilter.get_next(distance_filter, MatchmakingSettings.max_distance_filter)

		if next_distance_filter ~= nil then
			mm_printf("Changing distance filter from %s to %s", distance_filter, next_distance_filter)
			self.matchmaking_manager:add_filter_requirements(next_distance_filter)
			self.matchmaking_ui:large_window_set_search_zone_title("matchmaking_zone_" .. next_distance_filter)

			self.total_search_timer = 0
			search_time_ended = false
		end

		if MatchmakingSettings.host_games == "never" then
			search_time_ended = false
		end
	end

	local become_host = false
	local input_service = Managers.input:get_service("ingame_menu")

	if self.controller_cooldown and 0 < self.controller_cooldown then
		self.controller_cooldown = self.controller_cooldown - dt
	else
		if input_service and input_service.get(input_service, "matchmaking_ready_instigate") then
			self._started_readying = true
		end

		if input_service.get(input_service, "matchmaking_ready") and self.next_state_timer == nil and self._started_readying then
			if gamepad_active then
				local total_time = 1
				local cancel_timer = self.cancel_timer
				cancel_timer = (cancel_timer and cancel_timer + dt) or dt
				local progress = math.min(cancel_timer / total_time, 1)

				if progress == 1 then
					self.ready = not self.ready
					become_host = true
					self.controller_cooldown = GamepadSettings.menu_cooldown

					self.matchmaking_ui:large_window_ready_enable(false)
					self.matchmaking_ui:set_ready_progress(0)

					self._started_readying = false
				else
					self.cancel_timer = cancel_timer

					self.matchmaking_ui:set_ready_progress(progress)
				end
			else
				self.ready = not self.ready
				become_host = true
			end
		elseif self.cancel_timer then
			self.cancel_timer = nil

			self.matchmaking_ui:set_ready_progress(0)

			self._started_readying = false
		end
	end

	if new_lobby then
		self.state_context.join_lobby_data = new_lobby
	elseif search_time_ended or become_host then
		if become_host then
			self.next_state_timer = 0
		elseif not self.next_state_timer then
			self.matchmaking_manager:set_status_message("matchmaking_status_cannot_find_game")
			self.matchmaking_ui:large_window_ready_enable(false)

			self.next_state_timer = MatchmakingSettings.MIN_STATUS_MESSAGE_TIME
		end

		self.next_state_timer = self.next_state_timer - dt

		if 0 < self.next_state_timer then
			return nil
		end

		local player = Managers.player:local_player(1)
		local connection_state = "search_game_timeout"
		local started_matchmaking_t = self.matchmaking_manager.started_matchmaking_t
		local time_taken = t - started_matchmaking_t

		Managers.telemetry.events:matchmaking_connection(player, connection_state, time_taken)

		return MatchmakingStateHostGame, self.state_context
	end

	self._gamepad_active_last_frame = gamepad_active

	return nil
end
MatchmakingStateSearchGame.search_for_game = function (self, dt)
	local search_data = self.game_search_data
	local wait_time = self.search_wait_timer

	if wait_time then
		wait_time = wait_time - dt

		if wait_time <= 0 then
			self.search_wait_timer = nil
		else
			self.search_wait_timer = wait_time

			return 
		end
	end

	local lobbies = self.get_lobbies(self)
	local active_lobby, wanted_profile_index = nil
	local profile_priority = search_data.profile_priority
	local quick_game = search_data.quick_game
	local level_filter = search_data.level_filter
	local game_mode = search_data.game_mode
	local player = Managers.player:player_from_peer_id(self.peer_id)
	local wanted_profile = (self.total_search_timer < MatchmakingSettings.TOTAL_GAME_SEARCH_TIME / 2 and player.profile_index) or nil

	if wanted_profile == 0 then
		wanted_profile = nil
	end

	local matchmaking_manager = self.matchmaking_manager
	matchmaking_manager.debug.level = ((quick_game or level_filter) and "random") or search_data.level_key
	matchmaking_manager.debug.difficulty = search_data.difficulty
	matchmaking_manager.debug.hero = (wanted_profile and SPProfiles[wanted_profile].display_name) or "any"
	matchmaking_manager.debug.progression = search_data.player_progression
	matchmaking_manager.debug.lobbies = lobbies
	matchmaking_manager.debug.distance = string.format("%s (max:%s)", search_data.distance_filter, MatchmakingSettings.max_distance_filter)
	active_lobby = self.find_matchmaking_lobby(self, lobbies, search_data, wanted_profile, quick_game, game_mode)

	if active_lobby then
		if active_lobby.matchmaking == "searching" then
			local host_peer_id = active_lobby.host
			local time_of_search_self = tonumber(self.lobby:lobby_data("time_of_search") or "1000000000000")
			local time_of_search_other = tonumber(active_lobby.time_of_search or "0")

			if time_of_search_self < time_of_search_other then
				mm_printf("Found another player searching for the same kind of game, changing to MatchmakingStateHostGame")

				self.total_search_timer = MatchmakingSettings.TOTAL_GAME_SEARCH_TIME

				return nil
			else
				active_lobby = nil
			end
		else
			self.state_context.wanted_profile = wanted_profile
		end
	end

	if not self.search_wait_timer then
		self.search_wait_timer = MatchmakingSettings.TIME_BETWEEN_EACH_SEARCH
		self.num_searches = self.num_searches + 1
	end

	return active_lobby
end
MatchmakingStateSearchGame.get_lobbies = function (self)
	return self.lobby_finder:lobbies()
end
MatchmakingStateSearchGame.find_matchmaking_lobby = function (self, lobbies, search_data, wanted_profile_id, quick_game, game_mode)
	local level_key = search_data.level_key
	local level_filter = search_data.level_filter
	local difficulty = search_data.difficulty
	local player_peer_id = search_data.player_peer_id
	local matchmaking_manager = self.matchmaking_manager

	if quick_game then
		level_key = nil
	end

	if level_filter then
		for _, filter_level_key in ipairs(level_filter) do
			local matched_lobby = self.lobby_match(self, lobbies, filter_level_key, difficulty, game_mode, wanted_profile_id, player_peer_id)

			print("find_matchmaking_lobby: ", filter_level_key, matched_lobby)

			if matched_lobby then
				return matched_lobby
			end
		end
	else
		return self.lobby_match(self, lobbies, level_key, difficulty, game_mode, wanted_profile_id, player_peer_id)
	end

	return 
end
MatchmakingStateSearchGame.lobby_match = function (self, lobbies, level_key, difficulty, game_mode, wanted_profile_id, player_peer_id)
	local best_lobby_data = nil
	local matchmaking_manager = self.matchmaking_manager

	for _, lobby_data in ipairs(lobbies) do
		local lobby_match = matchmaking_manager.lobby_match(matchmaking_manager, lobby_data, level_key, difficulty, game_mode, wanted_profile_id, player_peer_id)

		if lobby_match then
			if lobby_data.matchmaking == "searching" then
				best_lobby_data = lobby_data
			elseif lobby_data.host_afk == "true" then
				best_lobby_data = lobby_data
			else
				return lobby_data
			end
		end
	end

	return best_lobby_data
end
MatchmakingStateSearchGame.update_search_timer = function (self, dt)
	local total_search_timer = self.total_search_timer
	self.total_search_timer = total_search_timer + dt
	local time_left = math.round(MatchmakingSettings.TOTAL_GAME_SEARCH_TIME - self.total_search_timer)
	self.matchmaking_manager.debug.text = "searching for games: " .. time_left
	self.matchmaking_manager.debug.state = "searching"

	return MatchmakingSettings.TOTAL_GAME_SEARCH_TIME <= self.total_search_timer
end

return 
