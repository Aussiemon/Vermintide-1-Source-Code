InputFilters = InputFilters or {}

local function input_threshold(input_axis, threshold)
	local length = Vector3.length(input_axis)

	if length < threshold then
		input_axis.x = 0
		input_axis.y = 0
		input_axis.z = 0
	end

	return 
end

InputFilters.virtual_axis = {
	init = function (filter_data)
		return table.clone(filter_data)
	end,
	update = function (filter_data, input_service)
		local input_mappings = filter_data.input_mappings
		local right = input_service.get(input_service, input_mappings.right)
		local left = input_service.get(input_service, input_mappings.left)
		local forward = input_service.get(input_service, input_mappings.forward)
		local back = input_service.get(input_service, input_mappings.back)
		local up_key = input_mappings.up
		local up = (up_key and input_service.get(input_service, up_key)) or 0
		local down_key = input_mappings.down
		local down = (down_key and input_service.get(input_service, down_key)) or 0
		local result = Vector3(right - left, forward - back, up - down)

		return result
	end,
	edit_types = {
		{
			"up",
			"keymap",
			"soft_button",
			"input_mappings"
		},
		{
			"down",
			"keymap",
			"soft_button",
			"input_mappings"
		},
		{
			"left",
			"keymap",
			"soft_button",
			"input_mappings"
		},
		{
			"right",
			"keymap",
			"soft_button",
			"input_mappings"
		},
		{
			"forward",
			"keymap",
			"soft_button",
			"input_mappings"
		},
		{
			"back",
			"keymap",
			"soft_button",
			"input_mappings"
		}
	}
}
InputFilters.scale_vector3 = {
	init = function (filter_data)
		return table.clone(filter_data)
	end,
	update = function (filter_data, input_service)
		local val = input_service.get(input_service, filter_data.input_mapping)

		input_threshold(val, filter_data.input_threshold or 0)

		return val*filter_data.multiplier
	end,
	edit_types = {
		{
			"multiplier",
			"number"
		}
	}
}
InputFilters.scale_vector3_xy = {
	init = function (filter_data)
		return table.clone(filter_data)
	end,
	update = function (filter_data, input_service)
		local val = input_service.get(input_service, filter_data.input_mapping)

		input_threshold(val, filter_data.input_threshold or 0)

		local x = val.x*filter_data.multiplier_x
		local y = val.y*filter_data.multiplier_y
		local z = val.z

		return Vector3(x, y, z)
	end,
	edit_types = {
		{
			"multiplier_x",
			"number"
		},
		{
			"multiplier_y",
			"number"
		}
	}
}
InputFilters.scale_vector3_xy_accelerated_x = {
	init = function (filter_data)
		local internal_filter_data = table.clone(filter_data)
		internal_filter_data.input_x = 0
		internal_filter_data.input_x_t = 0
		internal_filter_data.min_multiplier_x = internal_filter_data.multiplier_x*0.25

		return internal_filter_data
	end,
	update = function (filter_data, input_service)
		local val = input_service.get(input_service, filter_data.input_mapping)

		input_threshold(val, filter_data.input_threshold or 0)

		local time = Application.time_since_launch()

		if filter_data.threshold <= math.abs(val.x) and math.sign(val.x) ~= filter_data.input_x then
			filter_data.input_x = math.sign(val.x)
			filter_data.input_x_t = time
		elseif math.abs(val.x) < filter_data.threshold and Vector3.length(val) < filter_data.threshold then
			filter_data.input_x_t = time
		end

		local value = math.clamp((time - filter_data.input_x_t)/filter_data.accelerate_time_ref, 0, 1)
		local x = val.x*math.lerp(filter_data.min_multiplier_x, filter_data.multiplier_x, math.pow(value, filter_data.power_of))*Managers.time._mean_dt
		local y = val.y*filter_data.multiplier_y*Managers.time._mean_dt
		local z = val.z

		return Vector3(x, y, z)
	end,
	edit_types = {
		{
			"multiplier_x",
			"number"
		},
		{
			"multiplier_y",
			"number"
		}
	}
}
InputFilters.scale_vector3_xy_accelerated_x_inverted = {
	init = function (filter_data)
		local internal_filter_data = table.clone(filter_data)
		internal_filter_data.input_x = 0
		internal_filter_data.input_x_t = 0
		internal_filter_data.min_multiplier_x = internal_filter_data.multiplier_x*0.25

		return internal_filter_data
	end,
	update = function (filter_data, input_service)
		local val = input_service.get(input_service, filter_data.input_mapping)

		input_threshold(val, filter_data.input_threshold or 0)

		local time = Application.time_since_launch()

		if filter_data.threshold <= math.abs(val.x) and math.sign(val.x) ~= filter_data.input_x then
			filter_data.input_x = math.sign(val.x)
			filter_data.input_x_t = time
		elseif math.abs(val.x) < filter_data.threshold and Vector3.length(val) < filter_data.threshold then
			filter_data.input_x_t = time
		end

		local x = val.x*math.lerp(filter_data.min_multiplier_x, filter_data.multiplier_x, math.clamp((time - filter_data.input_x_t)/filter_data.accelerate_time_ref, 0, 1))*Managers.time._mean_dt
		local y = -val.y*filter_data.multiplier_y*Managers.time._mean_dt
		local z = val.z

		return Vector3(x, y, z)
	end,
	edit_types = {
		{
			"multiplier_x",
			"number"
		},
		{
			"multiplier_y",
			"number"
		}
	}
}
InputFilters.scale_vector3_invert_y = {
	init = function (filter_data)
		return table.clone(filter_data)
	end,
	update = function (filter_data, input_service)
		local val = Vector3(Vector3.to_elements(input_service.get(input_service, filter_data.input_mapping)))

		input_threshold(val, filter_data.input_threshold or 0)

		val.y = -val.y

		return val*filter_data.multiplier
	end,
	edit_types = {
		{
			"multiplier",
			"number"
		}
	}
}
InputFilters.threshhold = {
	init = function (filter_data)
		return table.clone(filter_data)
	end,
	update = function (filter_data, input_service)
		local val = input_service.get(input_service, filter_data.input_mapping)

		if filter_data.threshhold <= val then
			return false
		else
			return true
		end

		return 
	end
}

return 
