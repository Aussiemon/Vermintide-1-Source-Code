UnlockDlc = class(UnlockDlc)
UnlockDlc.init = function (self, name, app_id, backend_id)
	self._name = name
	self._id = app_id
	self._backend_id = backend_id
	self._unlocked = false
	self._owned = false

	if rawget(_G, "Steam") and app_id then
		if Steam.is_installed(app_id) then
			self._unlocked = true
		end

		if Steam.owns_app(app_id) then
			self._owned = true
		end
	end

	return 
end
UnlockDlc.name = function (self)
	return self._name
end
UnlockDlc.owned = function (self)
	return self._owned
end
UnlockDlc.id = function (self)
	return self._id
end
UnlockDlc.backend_id = function (self)
	return self._backend_id
end
UnlockDlc.unlocked = function (self)
	return self._unlocked
end
UnlockDlc.reevaluate = function (self)
	if rawget(_G, "Steam") and self._id then
		if Steam.is_installed(self._id) then
			self._unlocked = true
		end

		if Steam.owns_app(self._id) then
			self._owned = true
		end
	end

	return 
end
UnlockDlc.set_unlocked = function (self, unlocked)
	self._unlocked = unlocked

	return 
end
UnlockDlc.set_owned = function (self, owned)
	self._owned = true

	return 
end

return 
