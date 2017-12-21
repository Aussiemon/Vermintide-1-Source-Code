ScriptFetchLeaderboardToken = class(ScriptFetchLeaderboardToken)
ScriptFetchLeaderboardToken.init = function (self, token, callback)
	self._token = token
	self._done = false
	self._callback = callback
	self._result = nil

	return 
end
ScriptFetchLeaderboardToken.update = function (self)
	local token = self._token
	local progress_data = Leaderboard.progress(token)

	if progress_data.transaction_status == "done" then
		self._done = true
		self._result = progress_data.work_status
		self._scores = progress_data.scores
		self._total_scores = progress_data.total_scores
		self._entry_count = progress_data.leaderboard_entry_count
	end

	return 
end
ScriptFetchLeaderboardToken.info = function (self)
	local info = {
		result = self._result,
		callback = self._callback,
		scores = self._scores,
		total_scores = self._total_scores,
		entry_count = self._entry_count
	}

	return info
end
ScriptFetchLeaderboardToken.done = function (self)
	return self._done
end
ScriptFetchLeaderboardToken.close = function (self)
	Leaderboard.close(self._token)

	return 
end

return 
