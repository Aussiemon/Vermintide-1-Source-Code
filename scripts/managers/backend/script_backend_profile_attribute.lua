ScriptBackendProfileAttribute = ScriptBackendProfileAttribute or {}

ScriptBackendProfileAttribute.set = function (name, value)
	Backend.write_profile_attribute_as_number(name, value)
end

ScriptBackendProfileAttribute.get = function (name)
	return Backend.read_profile_attribute_as_number(name)
end

ScriptBackendProfileAttribute.set_string = function (name, value)
	Backend.write_profile_attribute_as_string(name, value)
end

ScriptBackendProfileAttribute.get_string = function (name)
	return Backend.read_profile_attribute_as_string(name)
end

function make_script_backend_profile_attribute_local()
	ScriptBackendProfileAttribute = ScriptBackendProfileAttributeLocal
end

BackendManagerLocalEnabled = BackendManagerLocalEnabled or false

if BackendManagerLocalEnabled then
	make_script_backend_profile_attribute_local()
end

return
