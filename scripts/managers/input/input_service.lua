-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
InputService = class(InputService)
InputService.init = function (self, input_service_name, keymaps, filters, block_reasons)
	keymaps = table.clone(keymaps)
	local input_map_types = InputAux.input_map_types
	local input_device_mapping = InputAux.input_device_mapping
	local default_data_types = {}

	for name, keymap in pairs(keymaps) do
		local input_mappings = keymap.input_mappings
		local n_input_mappings = #input_mappings
		input_mappings.n = n_input_mappings
		local combination_type = keymap.combination_type

		assert(n_input_mappings <= 1 or combination_type, "Mapping %q needs to specify \"combination_type\" due to multiple input mappings.", name)

		if combination_type then
			keymap.combination_function = InputAux.combination_functions[combination_type]

			assert(keymap.combination_function, "Unknown combination type %q for keymap %q.", combination_type, name)
		end

		for i = 1, n_input_mappings, 1 do
			local input_mapping = input_mappings[i]
			local n_input_mapping = #input_mapping
			input_mapping.n = n_input_mapping

			assert(n_input_mapping/3 == math.floor(n_input_mapping/3), "An input mapping must be paired by three arguments: device-type, button-name, operation")

			local input_map_type = nil

			for j = 1, n_input_mapping, 3 do
				local input_device_type = input_mapping[j]
				local input_device_list = input_device_mapping[input_device_type]
				local input_device = input_device_list[1]
				local current_input_map_type = input_map_types[input_mapping[j + 2]]

				assert(not input_map_type or input_map_type == current_input_map_type, "Bad input map combination for %q. Combinations must have the same result (%s vs %s)", name, current_input_map_type, input_map_type)

				input_map_type = current_input_map_type
				local key_index = nil

				if Application.platform() == "ps4" or Application.platform() == "xb1" then
					if input_mapping[j + 2] == "axis" then
						key_index = input_device.axis_index(input_mapping[j + 1])
					else
						key_index = input_device.button_index(input_mapping[j + 1])
					end

					if not key_index then
						printf("No such %q %q in input device type %q.", tostring(input_mapping[j + 2]), input_mapping[j + 1], input_device_type)
					end
				elseif input_mapping[j + 2] == "axis" then
					key_index = input_device.axis_index(input_mapping[j + 1])

					assert(key_index, "No such axis %q in input device type %q.", input_mapping[j + 1], input_device_type)
				else
					key_index = input_device.button_index(input_mapping[j + 1])

					assert(key_index, "No such key %q in input device type %q.", input_mapping[j + 1], input_device_type)
				end

				input_mapping[j + 1] = key_index
			end

			default_data_types[name] = input_map_type
		end
	end

	local input_filters = {}

	if filters then
		for filter_output, filter_data in pairs(filters) do
			local filter_type = filter_data.filter_type
			local new_filter_data = {
				function_data = InputFilters[filter_type].init(filter_data) or true,
				filter_output = filter_output,
				filter_type = filter_type,
				filter_function = InputFilters[filter_type].update
			}
			input_filters[filter_output] = new_filter_data
		end
	end

	self.keymaps = keymaps
	self.input_filters = input_filters
	self.default_data_types = default_data_types
	self.mapped_devices = {
		gamepad = {},
		mouse = {},
		keyboard = {},
		synergy_mouse = {},
		synergy_keyboard = {},
		network = {},
		recording = {}
	}
	self.input_devices_data = {}
	self.name = input_service_name
	self.controller_select = Vector3Box()
	self.block_reasons = block_reasons

	return 
end
InputService.map_device = function (self, input_device_type, input_device, input_device_data)
	local input_device_type_list = self.mapped_devices[input_device_type]
	input_device_type_list[#input_device_type_list + 1] = input_device
	input_device_type_list.n = #input_device_type_list
	self.input_devices_data[input_device] = input_device_data

	return 
end
InputService.unmap_device = function (self, input_device_type, input_device)
	local input_device_type_list = self.mapped_devices[input_device_type]
	local index = table.find(input_device_type_list, input_device)

	if not index then
		Application.error("[InputService] No mapped input called %s for input service %s", input_device.name(), self.name)

		return 
	end

	table.remove(input_device_type_list, index)

	input_device_type_list.n = #input_device_type_list

	return 
end
InputService.get = function (self, input_data_name, consume)
	local keymap_bindings = self.keymaps[input_data_name]
	local filter_binding = self.input_filters[input_data_name]

	if keymap_bindings then
		local default_data_types = self.default_data_types
		local input_mappings = keymap_bindings.input_mappings
		local n_input_mappings = input_mappings.n
		local combination_function = keymap_bindings.combination_function
		local mapped_devices = self.mapped_devices
		local input_devices_data = self.input_devices_data
		local name = self.name
		local result = nil

		for i = 1, n_input_mappings, 1 do
			local action_value = false
			local input_mapping = input_mappings[i]

			for j = 1, input_mapping.n, 3 do
				local device_type = input_mapping[j]
				local key_index = input_mapping[j + 1]
				local key_action_type = input_mapping[j + 2]
				local device_list = mapped_devices[device_type]

				if device_list and device_list.n then

					-- decompilation error in this vicinity
					for k = 1, device_list.n, 1 do
						local input_device = device_list[k]
						local input_device_data = input_devices_data[input_device]

						if input_device.active(input_device) and not input_device_data.blocked_access[name] then
							action_value = action_value or input_device_data[key_action_type][key_index]

							if action_value == true then
								if input_device_data.consumed_input[key_index] then
									action_value = nil
								elseif consume then
									input_device_data.consumed_input[key_index] = true
								end
							end
						elseif input_device.active(input_device) then
							action_value = nil

							break
						end
					end

					if not action_value then
						break
					end
				end
			end

			if action_value == nil then
				action_value = InputAux.default_values_for_types[default_data_types[input_data_name]]
			end

			if combination_function and result ~= nil then
				result = combination_function(result, action_value)
			else
				result = action_value
			end
		end

		return result
	elseif filter_binding then
		local function_data = filter_binding.function_data
		local value = InputFilters[function_data.filter_type].update(function_data, self)

		return value
	end

	return 
end
InputService.get_controller_cursor_position = function (self)
	return self.controller_select:unbox()
end
InputService.set_controller_cursor_position = function (self, x, y, z)
	self.controller_select:store(x, y, z)

	return 
end
InputService.change_keybinding = function (self, keymap_name, binding_index, sub_key_binding, new_button_index, new_device_type)
	assert(type(new_button_index) == "number", "New button index must be a number.")

	local keymapping = self.keymaps[keymap_name]

	assert(keymapping, "No such keymap name %s in service %s", keymap_name, self.name)

	local keymap_binding = keymapping.input_mappings[binding_index]

	assert(keymap_binding, "No such binding %d in keymap name %s for service %s", binding_index, keymap_name, self.name)
	assert(keymap_binding[sub_key_binding*3], "No such button combination key %d in kepmap name %s for service %s in binding %d", sub_key_binding, keymap_name, self.name, sub_key_binding)
	assert(InputAux.input_device_mapping[new_device_type], "No such input device type %s", new_device_type)

	keymap_binding[sub_key_binding*3 - 1] = new_button_index
	keymap_binding[sub_key_binding*3 - 2] = new_device_type

	return 
end
InputService.add_keybinding = function (self, keymap_name, ...)
	local keymapping = self.keymaps[keymap_name]

	assert(keymapping, "No such keymap name %s in service %s", keymap_name, self.name)

	local input_mappings = keymapping.input_mappings
	local n_varargs = select("#", ...)

	assert(n_varargs/3 == math.floor(n_varargs/3), "Bad amount of arguments (%d) to :add_keybinding(). Must supply input device type, keymap button index and keymap type for every key.", n_varargs)

	local input_mappings_n = input_mappings.n
	local new_mapping = {
		n = 0
	}
	input_mappings.input_mappings_n = input_mappings_n + 1
	input_mappings[input_mappings_n + 1] = new_mapping

	for i = 1, n_varargs/3, 1 do
		local n = new_mapping.n
		local input_device_type = select(i*3 - 2, ...)
		local keymap_button_index = select(i*3 - 1, ...)
		local keymap_type = select(i*3, ...)

		assert(type(keymap_button_index) == "number", "New button index must be a number.")

		local input_device_list = InputAux.input_device_mapping[input_device_type]

		assert(input_device_list, "No such input device type %s", input_device_type)

		local input_device = input_device_list[1]

		if keymap_type ~= "axis" then
			assert(input_device.button_name(keymap_button_index), "No such button index %d in device type %s", keymap_button_index, input_device_type)
		else
			assert(input_device.axis_name(keymap_button_index), "No such axis index %d in device type %s", keymap_button_index, input_device_type)
		end

		assert(InputAux.input_map_types[keymap_type], "Bad keymap type %s to add_keybinding() at vararg %d", keymap_type, i*3)

		new_mapping[n + 1] = input_device_type
		new_mapping[n + 2] = keymap_button_index
		new_mapping[n + 3] = keymap_type
		new_mapping.n = n + 3
	end

	return 
end
InputService.remove_keybinding = function (self, keymap_name, keymap_button_index)
	local keymapping = self.keymaps[keymap_name]

	assert(keymapping, "No such keymap name %s in service %s", keymap_name, self.name)
	assert(keymapping.input_mappings[keymap_button_index], "No such binding %d for keymap %s in service %s", keymap_button_index, keymap_name, self.name)

	keymapping.input_mappings[keymap_button_index] = nil

	return 
end
InputService.get_keymapping = function (self, keymap_name)
	return self.keymaps[keymap_name]
end
InputService.add_keymap = function (self, keymap_name)
	local keymapping = not self.keymaps[keymap_name]

	assert(keymapping, "Keymap already exists: name %s in service %s", keymap_name, input_service_name)

	self.keymaps[keymap_name] = {
		input_mappings = {
			n = 0
		}
	}

	return 
end
InputService.remove_keymap = function (self, keymap_name)
	local keymapping = self.keymaps[keymap_name]

	assert(keymapping, "No such keymap name %s in service %s", keymap_name, self.name)

	self.keymaps[keymap_name] = nil

	return 
end
InputService.generate_keybinding_setting = function (self)
	local new_keymaps = {}
	local current_keymaps = self.keymaps

	for keymap_name, keymap_data in pairs(current_keymaps) do
		local new_keymap_data = {}
		new_keymaps[keymap_name] = {
			input_mappings = new_keymap_data,
			combination_type = keymap_data.combination_type
		}

		for i = 1, keymap_data.input_mappings.n, 1 do
			local new_binding = {}
			new_keymap_data[i] = new_binding
			local current_binding = keymap_data.input_mappings[i]

			for j = 1, current_binding.n, 3 do
				local device_type = current_binding[j]
				new_binding[j] = device_type
				local input_device = InputAux.input_device_mapping[device_type][1]
				local key_name = nil

				if current_binding[j + 2] == "axis" then
					key_name = input_device.axis_name(current_binding[j + 1])
				else
					key_name = input_device.button_name(current_binding[j + 1])

					assert(current_binding[j + 1] == input_device.button_index(key_name))
				end

				new_binding[j + 1] = key_name
				new_binding[j + 2] = current_binding[j + 2]
			end
		end
	end

	return new_keymaps
end
InputService.generate_filters_setting = function (self)
	local new_filters = {}
	local current_filters = self.input_filters

	for filter_output, filter_data in pairs(current_filters) do
		local new_filter_data = table.clone(filter_data.function_data)
		new_filter_data.filter_type = filter_data.filter_type
		new_filters[filter_output] = new_filter_data
	end

	return new_filters
end
InputService.has = function (self, keymap_name)
	return self.keymaps[keymap_name] or (self.input_filters[keymap_name] and true) or false
end
InputService.is_blocked = function (self)
	return self.service_is_blocked
end
InputService.set_blocked = function (self, is_blocked)
	self.service_is_blocked = is_blocked

	return 
end

return 
