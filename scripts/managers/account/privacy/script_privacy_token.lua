ScriptPrivacyToken = class(ScriptPrivacyToken)
ScriptPrivacyToken.init = function (self)
	self._result = {}
	self._done = false

	return 
end
ScriptPrivacyToken.update = function (self)
	local in_progress = Privacy.status()
	self._done = not in_progress

	return 
end
ScriptPrivacyToken.info = function (self)
	local info = Privacy.result()

	return info
end
ScriptPrivacyToken.done = function (self)
	return self._done
end
ScriptPrivacyToken.close = function (self)
	Privacy.close()

	return 
end

return 
