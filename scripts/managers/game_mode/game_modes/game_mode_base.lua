GameModeBase = class(GameModeBase)
GameModeBase.init = function (self, settings, world, network_server)
	self._network_server = network_server
	self._settings = settings
	self._world = world
	self._level_completed = false
	self._level_failed = false
	self._lose_condition_disabled = false

	return 
end
GameModeBase.settings = function (self)
	return self._settings
end
GameModeBase.fail_level = function (self)
	self._level_failed = true

	return 
end
GameModeBase.disable_lose_condition = function (self)
	self._lose_condition_disabled = true

	return 
end
GameModeBase.level_completed = function (self)
	return self._level_completed
end
GameModeBase.complete_level = function (self)
	self._level_completed = true

	return 
end
GameModeBase.evaluate_end_conditions = function (self)
	return false, nil
end
GameModeBase.object_sets = function (self)
	return self._settings.object_sets
end
GameModeBase.hot_join_sync = function (self, sender)
	return 
end

return 
