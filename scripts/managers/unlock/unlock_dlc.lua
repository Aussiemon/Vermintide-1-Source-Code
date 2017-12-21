UnlockDlc = class(UnlockDlc)
UnlockDlc.init = function (self, name, app_id, local_only)
	self._name = name
	self._id = app_id
	self._local_only = local_only
	self._unlocked = false

	if rawget(_G, "Steam") and Steam.is_installed(app_id) then
		self._unlocked = true
	end

	return 
end
UnlockDlc.id = function (self)
	return self._id
end
UnlockDlc.local_only = function (self)
	return self._local_only
end
UnlockDlc.unlocked = function (self)
	return self._unlocked
end

return 
