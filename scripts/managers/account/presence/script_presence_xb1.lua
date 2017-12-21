ScriptPresence = class(ScriptPresence)
ScriptPresence.init = function (self)
	self._user_id = nil

	return 
end
ScriptPresence.set_user_id = function (self, id)
	self._user_id = id

	return 
end
ScriptPresence.set_presence_menu = function (self)
	if self._user_id then
		X360.set_context(self._user_id, X360.CONTEXT_PRESENCE, spa.CONTEXT_PRESENCE_MENU)
	end

	return 
end
ScriptPresence.set_presence_idle = function (self)
	if self._user_id then
		X360.set_context(self._user_id, X360.CONTEXT_PRESENCE, spa.CONTEXT_PRESENCE_IDLE)
	end

	return 
end
ScriptPresence.set_presence_credits = function (self)
	if self._user_id then
		X360.set_context(self._user_id, X360.CONTEXT_PRESENCE, spa.CONTEXT_PRESENCE_CREDITS)
	end

	return 
end
ScriptPresence.set_presence_ingame = function (self, level_key)
	if self._user_id then
		local spa_key = "CONTEXT_LEVEL_" .. string.upper(level_key)
		local spa_value = spa[spa_key]

		if spa_value then
			X360.set_context(self._user_id, spa.CONTEXT_LEVEL, spa_value)
			X360.set_context(self._user_id, X360.CONTEXT_PRESENCE, spa.CONTEXT_PRESENCE_INGAME)
		else
			print("[Presence] Context not found in XBOX Live Game Configuration: " .. tostring(spa_key))
		end
	end

	return 
end

return 
