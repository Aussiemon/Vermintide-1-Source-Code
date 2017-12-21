MatchmakingStateRequestProfiles = class(MatchmakingStateRequestProfiles)
MatchmakingStateRequestProfiles.NAME = "MatchmakingStateRequestProfiles"
MatchmakingStateRequestProfiles.init = function (self, params)
	self.network_transmit = params.network_transmit
	self.matchmaking_manager = params.matchmaking_manager
	self.handshaker_client = params.handshaker_client
	self.matchmaking_ui = params.matchmaking_ui

	return 
end
MatchmakingStateRequestProfiles.destroy = function (self)
	return 
end
MatchmakingStateRequestProfiles.on_enter = function (self, state_context)
	self.matchmaking_manager.debug.profiles_data = {}
	self.state_context = state_context
	self.state_context.profiles_data = nil
	self.lobby_client = state_context.lobby_client

	self.request_profiles_data(self)

	self.reply_timer = MatchmakingSettings.REQUEST_PROFILES_REPLY_TIME

	self.matchmaking_manager:set_status_message("matchmaking_status_joining_game")

	self.profiles_data = {}

	return 
end
MatchmakingStateRequestProfiles.on_exit = function (self)
	return 
end
MatchmakingStateRequestProfiles.update = function (self, dt, t)
	if self.reply_timer then
		self.reply_timer = self.reply_timer - dt

		if self.reply_timer < 0 then
			mm_printf("NO REPLY WHEN REQUESTING PROFILES DATA")

			if self.state_context.game_search_data == nil then
				self.matchmaking_manager:cancel_matchmaking()
			else
				self._next_state = MatchmakingStateSearchGame
			end
		end
	end

	if self._next_state then
		return self._next_state, self.state_context
	end

	return nil
end
MatchmakingStateRequestProfiles.request_profiles_data = function (self)
	local host = self.lobby_client:lobby_host()

	self.handshaker_client:send_rpc_to_host("rpc_matchmaking_request_profiles_data")

	self.matchmaking_manager.debug.text = "requesting_profiles_data"

	return 
end
MatchmakingStateRequestProfiles.rpc_matchmaking_request_profiles_data_reply = function (self, sender, client_cookie, host_cookie, profiles_data)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	self._update_profiles_data(self, profiles_data)

	self._next_state = MatchmakingStateJoinGame
	self.matchmaking_manager.debug.text = "profiles_data_received"

	mm_printf("PROFILES DATA REPLY BY %s REPLY wh:%s | we:%s | dr:%s | bw:%s | es:%s", sender, profiles_data[1], profiles_data[2], profiles_data[3], profiles_data[4], profiles_data[5])

	return 
end
MatchmakingStateRequestProfiles.rpc_matchmaking_update_profiles_data = function (self, sender, client_cookie, host_cookie, profiles_data)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	self._update_profiles_data(self, profiles_data)

	if self.popup_id then
		self.popup_join_lobby_handler:update_lobby_data(self.profiles_data)
	end

	return 
end
MatchmakingStateRequestProfiles._update_profiles_data = function (self, profiles_data)
	local num_profiles = #SPProfiles

	for i = 1, num_profiles, 1 do
		local profile_data = (profiles_data[i] == "0" and "available") or profiles_data[i]
		self.profiles_data["player_slot_" .. i] = profile_data
	end

	self.state_context.profiles_data = self.profiles_data
	self.matchmaking_manager.debug.profiles_data = self.profiles_data

	return 
end

return 
