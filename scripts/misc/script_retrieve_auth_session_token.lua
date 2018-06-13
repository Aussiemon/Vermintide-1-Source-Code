ScriptSteamAuthSessionToken = class(ScriptSteamAuthSessionToken)

ScriptSteamAuthSessionToken.init = function (self, token)
	self._done = false
	self._error = true
	self._token = token
end

ScriptSteamAuthSessionToken.update = function (self)
	local auth_session_ticket = Steam.poll_auth_session_ticket(self._token)

	if auth_session_ticket then
		self._auth_session_ticket = auth_session_ticket
		self._done = true
		self._error = false
	end
end

ScriptSteamAuthSessionToken.info = function (self)
	local info = {
		auth_session_ticket = self._auth_session_ticket,
		error = self._error
	}

	return info
end

ScriptSteamAuthSessionToken.done = function (self)
	return self._done
end

ScriptSteamAuthSessionToken.close = function (self)
	return
end

return
