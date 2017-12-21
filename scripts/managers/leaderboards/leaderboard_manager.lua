require("scripts/managers/leaderboards/script_leaderboard_token")
require("scripts/managers/leaderboards/script_fetch_leaderboard_token")
require("scripts/managers/leaderboards/leaderboard_settings")

LeaderboardManager = class(LeaderboardManager)
LeaderboardManager.init = function (self)
	self._platform = Application.platform()

	if self._platform == "win32" and rawget(_G, "Steam") then
		self._score_template = LeaderboardSettings.template
		self._score_data_setup = LeaderboardSettings.data_setup

		if not self._score_template then
			self._current_leaderboard = nil
			self._leaderboards_enabled = false

			Application.error("[LeaderboardManager] Leaderboards disabled")

			return 
		end

		self._current_leaderboard = "global"
		self._leaderboards_enabled = true
		local token = Leaderboard.init_leaderboards(LeaderboardSettings.leaderboards)
		local script_token = ScriptLeaderboardToken:new(token)

		Managers.token:register_token(script_token, callback(self, "cb_leaderboards_loaded"))
	else
		self._current_leaderboard = nil
		self._leaderboards_enabled = false

		Application.error("[LeaderboardManager] Leaderboards disabled")
	end

	return 
end
LeaderboardManager.initialized = function (self)
	return self._leaderboards_initialized
end
LeaderboardManager.enabled = function (self)
	return self._leaderboards_enabled and Managers.lobby and Managers.lobby:using_steam()
end
LeaderboardManager.cb_leaderboards_loaded = function (self, info)
	Application.error("[LeaderboardManager] INFO: " .. info.result)

	self._leaderboards_initialized = true

	return 
end
LeaderboardManager._verify_data = function (self, score_data)
	for idx, data_type in ipairs(self._score_data_setup) do
		local data = score_data[idx]

		if not data then
			return true, string.format("Not enought elements in score_data. Index %i is missing", idx)
		end

		if data_type == "UINT" then
			if type(data) ~= "number" then
				return true, string.format("The %i:th score element is not a number (Needs to be a UINT)", idx)
			elseif data < 0 then
				return true, string.format("The %i:th score element is a negative number (Needs to be a UINT)", idx)
			end
		elseif data_type == "INT" then
			if type(data) ~= "number" then
				return true, string.format("The %i:th score element is not a number (Needs to be a INT)", idx)
			end
		elseif data_type == "STRING" and type(data) ~= "string" then
			return true, string.format("The %i:th score element is not a string", idx)
		end
	end

	return false
end
LeaderboardManager.register_score = function (self, leaderboard_name, score, score_data)
	self._score_template = LeaderboardSettings.template
	self._score_data_setup = LeaderboardSettings.data_setup
	local error, error_msg = self._verify_data(self, score_data)

	if error then
		Application.error("[LeaderboardManager] ERROR: " .. error_msg)
	else
		local token = Leaderboard.register_score(leaderboard_name, score, Leaderboard.KEEP_BEST, self._score_template, score_data)
		local script_token = ScriptLeaderboardToken:new(token)

		Managers.token:register_token(script_token, callback(self, "cb_score_registered"))
	end

	return 
end
LeaderboardManager.get_leaderboard = function (self, leaderboard_name, leaderboard_type, in_callback, start_rank, num_ranks)
	local token = nil

	if leaderboard_type == Leaderboard.RT_AROUND_USER then
		local ranks_before_player = start_rank or 5
		local ranks_after_player = num_ranks or 15
		token = Leaderboard.ranking_around_self(leaderboard_name, ranks_before_player, ranks_after_player, self._score_template)
	elseif leaderboard_type == Leaderboard.RT_FRIENDS then
		token = Leaderboard.ranking_for_friends(leaderboard_name, self._score_template)
	else
		start_rank = start_rank or 1
		num_ranks = num_ranks or 20
		token = Leaderboard.ranking_range(leaderboard_name, start_rank, num_ranks, self._score_template)
	end

	fassert(token, "[LeaderboardManager] Could not create token for leaderbord: %s with type %d", leaderboard_name, leaderboard_type)

	local script_token = ScriptFetchLeaderboardToken:new(token, in_callback)

	Managers.token:register_token(script_token, callback(self, "cb_leaderboard_fetched"))

	return 
end
LeaderboardManager.get_global_leaderboard = function (self, leaderboard_name, in_callback, start_rank, num_ranks)
	local token = Leaderboard.ranking_range(leaderboard_name, start_rank, num_ranks, self._score_template)
	local script_token = ScriptFetchLeaderboardToken:new(token, in_callback)

	Managers.token:register_token(script_token, callback(self, "cb_leaderboard_fetched"))

	return 
end
LeaderboardManager.get_friend_leaderboard = function (self, leaderboard_name, in_callback)
	local token = Leaderboard.ranking_for_friends(leaderboard_name, self._score_template)
	local script_token = ScriptFetchLeaderboardToken:new(token, in_callback)

	Managers.token:register_token(script_token, callback(self, "cb_leaderboard_fetched"))

	return 
end
LeaderboardManager.get_around_player_leaderboard = function (self, leaderboard_name, in_callback)
	local token = Leaderboard.ranking_around_self(leaderboard_name, 5, 15, self._score_template)
	local script_token = ScriptFetchLeaderboardToken:new(token, in_callback)

	Managers.token:register_token(script_token, callback(self, "cb_leaderboard_fetched"))

	return 
end
LeaderboardManager.cb_score_registered = function (self, info)
	Application.error("[LeaderboardManager] INFO: " .. info.result)

	return 
end
LeaderboardManager.cb_leaderboard_fetched = function (self, info)
	if info.callback then
		info.callback(info)
	end

	return 
end
LeaderboardManager.update = function (self, dt)
	return 
end
LeaderboardManager.destroy = function (self)
	return 
end

return 
