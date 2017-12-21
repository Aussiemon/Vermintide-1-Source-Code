MatchmakingStateStartGame = class(MatchmakingStateStartGame)
MatchmakingStateStartGame.NAME = "MatchmakingStateStartGame"
MatchmakingStateStartGame.init = function (self, params)
	self.lobby = params.lobby
	self.network_transmit = params.network_transmit
	self.level_transition_handler = params.level_transition_handler
	self.handshaker_host = params.handshaker_host
	self.network_server = params.network_server
	self.statistics_db = params.statistics_db

	return 
end
MatchmakingStateStartGame.destroy = function (self)
	return 
end
MatchmakingStateStartGame.on_enter = function (self, state_context)
	self.state_context = state_context

	self.start_game_countdown(self)
	self.network_server:enter_post_game()

	return 
end
MatchmakingStateStartGame.on_exit = function (self)
	return 
end
MatchmakingStateStartGame.start_game_countdown = function (self)
	local current_level_key, _ = self.level_transition_handler:get_current_level_keys()

	if current_level_key == "inn_level" then
		self.start_game_timer = 0

		self.handshaker_host:send_rpc_to_all("rpc_start_game_countdown")
	else
		self.not_in_level = true
	end

	return 
end
MatchmakingStateStartGame.update = function (self, dt, t)
	if self.start_game_timer then
		local start_game = self.update_start_game_timer(self, dt)

		if start_game then
			self.start_game(self)
		end
	end

	return nil
end
MatchmakingStateStartGame.update_start_game_timer = function (self, dt)
	local time = self.start_game_timer
	time = time + dt

	if MatchmakingSettings.START_GAME_TIME <= time then
		self.start_game_timer = nil

		return true
	else
		self.start_game_timer = time
	end

	return 
end
MatchmakingStateStartGame.start_game = function (self)
	local lobby_members = self.lobby:members()
	local members = lobby_members.get_members(lobby_members)
	local nr_friends = 0

	for _, peer_id in pairs(members) do
		if rawget(_G, "Steam") and rawget(_G, "Friends") then
			local is_friend = Friends.in_category(peer_id, Friends.FRIEND_FLAG)

			if is_friend then
				nr_friends = nr_friends + 1
			end
		end
	end

	local player = Managers.player:local_player(1)

	Managers.telemetry.events:matchmaking_starting_game(player, nr_friends)

	if Application.platform() == "ps4" then
		local statistics_db = self.statistics_db
		local state_context = self.state_context
		local game_search_data = state_context.game_search_data
		local started_matchmaking_t = game_search_data.started_matchmaking_t
		local time_manager = Managers.time
		local t = time_manager.time(time_manager, "game") or started_matchmaking_t
		local time_taken = t - started_matchmaking_t
		local nr_members = table.size(members)

		StatisticsUtil.register_matchmaking_game_started(statistics_db)
		StatisticsUtil.register_matchmaking_game_started_total_time(statistics_db, time_taken)
		StatisticsUtil.register_matchmaking_game_started_player_amount(statistics_db, nr_members)

		if nr_members == 4 then
			StatisticsUtil.register_matchmaking_game_started_full_team(statistics_db)
		end
	end

	self.handshaker_host:send_rpc_to_clients("rpc_matchmaking_join_game")
	Managers.state.game_mode:complete_level()

	return 
end

return 
