AlwaysLocked = class(AlwaysLocked)
AlwaysLocked.init = function (self, name, app_id, backend_id)
	self._name = name
	self._id = "0"
	self._backend_id = nil
	self._unlocked = false
	self._owned = false

	return 
end
AlwaysLocked.id = function (self)
	return self._id
end
AlwaysLocked.backend_id = function (self)
	return self._backend_id
end
AlwaysLocked.unlocked = function (self)
	return self._unlocked
end
AlwaysLocked.owned = function (self)
	return self._owned
end

return 
