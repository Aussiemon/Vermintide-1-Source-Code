ScriptBackendProfileAttributeLocal = ScriptBackendProfileAttributeLocal or {}

ScriptBackendProfileAttributeLocal.set = function (name, value)
	local save_data = Managers.backend._save_data
	save_data.profile_attributes[name] = value
end

ScriptBackendProfileAttributeLocal.get = function (name)
	local save_data = Managers.backend._save_data

	return save_data.profile_attributes[name]
end

ScriptBackendProfileAttributeLocal.set_string = function (name, value)
	local save_data = Managers.backend._save_data
	save_data.profile_attributes[name] = value
end

ScriptBackendProfileAttributeLocal.get_string = function (name)
	local save_data = Managers.backend._save_data

	return save_data.profile_attributes[name]
end

return
