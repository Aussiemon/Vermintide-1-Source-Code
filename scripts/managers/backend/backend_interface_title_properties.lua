BackendInterfaceTitleProperties = class(BackendInterfaceTitleProperties)
BackendInterfaceTitleProperties.init = function (self)
	return 
end
BackendInterfaceTitleProperties.get = function (self)
	self._data = self._data or Backend.get_title_properties()

	return self._data
end
BackendInterfaceTitleProperties.get_value = function (self, key)
	self._data = self._data or Backend.get_title_properties()
	local value = self._data[key]

	fassert(value ~= nil, "No such key '%s'", key)

	return value
end

return 
