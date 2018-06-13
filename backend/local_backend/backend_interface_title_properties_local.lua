BackendInterfaceTitlePropertiesLocal = class(BackendInterfaceTitlePropertiesLocal)

BackendInterfaceTitlePropertiesLocal.init = function (self)
	self._data = {
		brawl_enabled = false
	}
end

BackendInterfaceTitlePropertiesLocal.get = function (self)
	return self._data
end

BackendInterfaceTitlePropertiesLocal.get_value = function (self, key)
	local value = self._data[key]

	return value
end

return
