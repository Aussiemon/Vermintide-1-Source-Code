ScriptLeaderboardToken = class(ScriptLeaderboardToken)
ScriptLeaderboardToken.init = function (self, token)
	self._token = token
	self._done = false
	self._result = nil

	return 
end
ScriptLeaderboardToken.update = function (self)
	local token = self._token
	local progress_data = Leaderboard.progress(token)

	if progress_data.transaction_status == "done" then
		self._done = true
		self._result = progress_data.work_status
	end

	return 
end
ScriptLeaderboardToken.info = function (self)
	local info = {
		result = self._result
	}

	return info
end
ScriptLeaderboardToken.done = function (self)
	return self._done
end
ScriptLeaderboardToken.close = function (self)
	Leaderboard.close(self._token)

	return 
end

return 
