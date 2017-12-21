InputUtils = InputUtils or {}
InputUtils.keymaps_key_approved = function (platform_key)
	local platform = Application.platform()

	if platform == "win32" then
		return ((platform_key == platform or platform_key == "xb1") and true) or nil
	else
		return (platform_key == platform and true) or nil
	end

	return 
end
InputUtils.get_platform_keymaps = function (keymappings, optional_platform_key)
	local platform = optional_platform_key or Application.platform()

	return keymappings[platform]
end
InputUtils.get_platform_filters = function (filters, optional_platform_key)
	local platform = optional_platform_key or Application.platform()

	return filters[platform]
end

return 
