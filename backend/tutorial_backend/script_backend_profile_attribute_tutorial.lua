ScriptBackendProfileAttributeTutorial = ScriptBackendProfileAttributeTutorial or {}
ScriptBackendProfileAttributeTutorial.set = function (name, value)
	return 
end
ScriptBackendProfileAttributeTutorial.get = function (name)
	local backend_data = Managers.backend._backend_data

	return backend_data.profile_attributes[name]
end
ScriptBackendProfileAttributeTutorial.set_string = function (name, value)
	return 
end
ScriptBackendProfileAttributeTutorial.get_string = function (name)
	local backend_data = Managers.backend._backend_data

	return backend_data.profile_attributes[name]
end

return 
