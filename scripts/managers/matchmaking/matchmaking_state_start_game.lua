MatchmakingStateStartGame = class(MatchmakingStateStartGame)
MatchmakingStateStartGame.NAME = "MatchmakingStateStartGame"
local telemetry_data = {}

local function _add_matchmaking_starting_game_telemetry(player, nr_friends)
	local telemetry_id = player.telemetry_id(player)
	local hero = player.profile_display_name(player)

	table.clear(telemetry_data)

	telemetry_data.player_id = telemetry_id
	telemetry_data.hero = hero
	telemetry_data.nr_friends = nr_friends
	local telemetry_manager = Managers.telemetry

	telemetry_manager.register_event(telemetry_manager, "matchmaking_starting_game", telemetry_data)

	return 
end

MatchmakingStateStartGame.init = function (self, params)
	self.lobby = params.lobby
	self.network_transmit = params.network_transmit
	self.level_transition_handler = params.level_transition_handler
	self.handshaker_host = params.handshaker_host
	self.network_server = params.network_server

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
	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local player = player_manager.local_player(player_manager, 1)
		local lobby_members = self.lobby:members()
		local members_joined = lobby_members.get_members_joined(lobby_members)
		local nr_friends = 0

		for _, peer_id in pairs(members_joined) do
			if rawget(_G, "Steam") and rawget(_G, "Friends") then
				local is_friend = Friends.in_category(peer_id, Friends.FRIEND_FLAG)

				if is_friend then
					nr_friends = nr_friends + 1
				end
			end
		end

		_add_matchmaking_starting_game_telemetry(player, nr_friends)
	end

	self.handshaker_host:send_rpc_to_clients("rpc_matchmaking_join_game")
	Managers.state.game_mode:complete_level()

	return 
end

return 
