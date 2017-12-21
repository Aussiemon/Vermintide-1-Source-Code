AlwaysUnlocked = class(AlwaysUnlocked)
AlwaysUnlocked.init = function (self, name, app_id, backend_required)
	self._name = name
	self._id = app_id
	self._backend_required = false
	self._unlocked = true

	return 
end
AlwaysUnlocked.id = function (self)
	return self._id
end
AlwaysUnlocked.backend_required = function (self)
	return self._backend_required
end
AlwaysUnlocked.unlocked = function (self)
	return self._unlocked
end

return 
