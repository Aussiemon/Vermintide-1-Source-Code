require("scripts/managers/input/input_service")
require("scripts/managers/input/play_recording_input_device")
require("scripts/managers/input/network_input_device")
require("scripts/managers/input/input_aux")
require("scripts/managers/input/input_filters")
require("scripts/managers/input/input_debugger")

local most_recent_input_device = most_recent_input_device or (Application.platform() == "win32" and Keyboard) or Pad1
InputManager2 = class(InputManager2)
InputManager2.init = function (self)
	self.input_services = {}
	self.input_devices = {}

	Pad1.set_down_threshold(0.25)

	return 
end
InputManager2.destroy = function (self)
	self.input_services = nil
	self.input_devices = nil

	return 
end
InputManager2.initialize_device = function (self, input_device_type, input_device_slot)
	if Development.parameter("disable_gamepad") and input_device_type == "gamepad" then
		return 
	end

	local device_list = assert(InputAux.input_device_mapping[input_device_type], "No such input device type: %s", input_device_type)
	input_device_slot = input_device_slot or 1
	local input_device = assert(device_list[input_device_slot], "No input device %s with index %d", input_device_type, input_device_slot)

	assert(not self.input_devices[input_device], "Input device already initialized %s %d.", input_device_type, input_device_slot)

	self.input_devices[input_device] = {
		pressed = {},
		released = {},
		held = {},
		soft_button = {},
		num_buttons = input_device.num_buttons(),
		axis = {},
		num_axes = input_device.num_axes(),
		blocked_access = {},
		consumed_input = {}
	}

	return 
end
InputManager2.block_device_except_service = function (self, service_exception, device_type, device_index, block_reason)
	if Development.parameter("disable_gamepad") and device_type == "gamepad" then
		return 
	end

	device_index = device_index or 1
	local device_list = InputAux.input_device_mapping[device_type]

	if not device_list then
		return 
	end

	local input_device = device_list[device_index]
	local device_data = self.input_devices[input_device]

	for name, service in pairs(self.input_services) do
		if service.block_reasons and service.block_reasons[block_reason] then
			device_data.blocked_access[name] = true

			service.set_blocked(service, true)
		elseif not service.block_reasons then
			device_data.blocked_access[name] = true

			service.set_blocked(service, true)
		end
	end

	if service_exception and device_data.blocked_access[service_exception] then
		self.input_services[service_exception]:set_blocked(nil)

		device_data.blocked_access[service_exception] = nil
	end

	return 
end
InputManager2.device_unblock_all_services = function (self, device_type, device_index)
	if Development.parameter("disable_gamepad") and device_type == "gamepad" then
		return 
	end

	device_index = device_index or 1
	local device_list = InputAux.input_device_mapping[device_type]
	local input_device = device_list[device_index]
	local device_data = self.input_devices[input_device]
	local input_services = self.input_services

	for name, _ in pairs(device_data.blocked_access) do
		input_services[name]:set_blocked(nil)

		device_data.blocked_access[name] = nil
	end

	return 
end
InputManager2.device_block_service = function (self, device_type, device_index, service_name, block_reason)
	if Development.parameter("disable_gamepad") and device_type == "gamepad" then
		return 
	end

	local input_service = self.input_services[service_name]

	if input_service.block_reasons and not input_service.block_reasons[block_reason] then
		return 
	end

	device_index = device_index or 1
	local device_list = InputAux.input_device_mapping[device_type]
	local input_device = device_list[device_index]
	local device_data = self.input_devices[input_device]
	device_data.blocked_access[service_name] = true

	input_service.set_blocked(input_service, true)

	return 
end
InputManager2.device_unblock_service = function (self, device_type, device_index, service_name)
	if Development.parameter("disable_gamepad") and device_type == "gamepad" then
		return 
	end

	device_index = device_index or 1
	local device_list = InputAux.input_device_mapping[device_type]
	local input_device = device_list[device_index]
	local device_data = self.input_devices[input_device]
	device_data.blocked_access[service_name] = nil

	self.input_services[service_name]:set_blocked(nil)

	return 
end
InputManager2.get_unblocked_services = function (self, device_type, device_index, services_dest)
	local services_n = 0

	for service_name, service in pairs(self.input_services) do
		if not service.is_blocked(service) then
			services_n = services_n + 1
			services_dest[services_n] = service_name
		end
	end

	return services_n
end
InputManager2.get_blocked_services = function (self, device_type, device_index, services_dest)
	local services_n = 0

	for service_name, service in pairs(self.input_services) do
		if service.is_blocked(service) then
			services_n = services_n + 1
			services_dest[services_n] = service_name
		end
	end

	return services_n
end
InputManager2.device_block_services = function (self, device_type, device_index, services, services_n, block_reason)
	device_index = device_index or 1

	for i = 1, services_n, 1 do
		local service_name = services[i]

		self.device_block_service(self, device_type, device_index, service_name, block_reason)
	end

	return 
end
InputManager2.device_unblock_services = function (self, device_type, device_index, services, services_n)
	device_index = device_index or 1

	for i = 1, services_n, 1 do
		local service_name = services[i]

		self.device_unblock_service(self, device_type, device_index, service_name)
	end

	return 
end
InputManager2.create_input_service = function (self, input_service_name, keymaps, filters, block_reasons)
	self.input_services[input_service_name] = InputService:new(input_service_name, keymaps, filters, block_reasons)

	return 
end
InputManager2.map_device_to_service = function (self, input_service_name, input_device_type, input_device_slot)
	if Development.parameter("disable_gamepad") and input_device_type == "gamepad" then
		return 
	end

	local input_service = assert(self.input_services[input_service_name], "No such input service name: %s", input_service_name)
	local device_list = assert(InputAux.input_device_mapping[input_device_type], "No such input device type: %s", input_device_type)
	input_device_slot = input_device_slot or 1
	local input_device = assert(device_list[input_device_slot], "No input device %s with index %d", input_device_type, input_device_slot)
	local input_device_data = self.input_devices[input_device]

	input_service.map_device(input_service, input_device_type, input_device, input_device_data)

	return 
end
InputManager2.update = function (self, dt, t)
	Profiler.start("InputManager2")

	InputAux.default_values_for_types.Vector3 = Vector3.zero()

	Profiler.start("device_updates")
	self.update_devices(self, dt, t)
	Profiler.stop()
	InputDebugger:finalize_update(self.input_services, dt, t)
	Profiler.stop()

	return 
end
InputManager2.update_devices = function (self, dt, t)
	local input_devices = self.input_devices
	self.any_device_input_pressed = nil
	self.any_device_input_axis_moved = nil

	for input_device, device_data in pairs(input_devices) do
		InputDebugger:pre_update_device(input_device, device_data, dt)

		local pressed = device_data.pressed
		local held = device_data.held
		local soft_button = device_data.soft_button
		local num_buttons = device_data.num_buttons - 1

		for key = 0, num_buttons, 1 do
			local button_value = input_device.button(key)
			soft_button[key] = button_value
			held[key] = 0.5 < button_value
		end

		local any_pressed = input_device.any_pressed()

		if any_pressed then
			for key = 0, num_buttons, 1 do
				pressed[key] = input_device.pressed(key)
			end
		else
			for key = 0, num_buttons, 1 do
				pressed[key] = false
			end
		end

		local any_released = input_device.any_released()
		local released = device_data.released

		if any_released then
			for key = 0, num_buttons, 1 do
				released[key] = input_device.released(key)
			end
		else
			for key = 0, num_buttons, 1 do
				released[key] = false
			end
		end

		local any_device_input_axis_moved = false
		local axis = device_data.axis

		for key = 0, device_data.num_axes - 1, 1 do
			axis[key] = input_device.axis(key)
			local button_name = input_device.axis_name(key)
			local test = 1
			test = math.random()

			if input_device.axis_name(key) ~= "cursor" and Vector3.length(axis[key]) ~= 0 then
				any_device_input_axis_moved = true
			end
		end

		InputDebugger:post_update_device(input_device, device_data, dt)

		if any_pressed then
			self.any_device_input_pressed = true
		end

		if any_device_input_axis_moved then
			self.any_device_input_axis_moved = true
		end

		if any_pressed or any_device_input_axis_moved then
			self.last_active_time = t

			if most_recent_input_device ~= input_device then
				most_recent_input_device = input_device
				local device_name = input_device._name
				local allow_cursor_rendering = device_name == "Keyboard" or device_name == "Mouse"

				ShowCursorStack.render_cursor(allow_cursor_rendering)
			end
		end

		table.clear(device_data.consumed_input)
	end

	return 
end
InputManager2.get_service = function (self, input_service_name)
	return self.input_services[input_service_name]
end
local disabled_gamepad = {
	active = function ()
		return false
	end
}
InputManager2.get_device = function (self, input_device_type, input_device_slot)
	if Development.parameter("disable_gamepad") and input_device_type == "gamepad" then
		return disabled_gamepad
	end

	local device_list = assert(InputAux.input_device_mapping[input_device_type], "No such input device type: %s", input_device_type)
	input_device_slot = input_device_slot or 1

	return device_list[input_device_slot]
end
InputManager2.any_input_pressed = function (self)
	return self.any_device_input_pressed
end
InputManager2.any_input_axis_moved = function (self)
	return self.any_device_input_axis_moved
end
InputManager2.get_most_recent_device = function (self)
	return most_recent_input_device
end
InputManager2.is_device_active = function (self, input_device_type, input_device_slot)
	local most_recent_device = most_recent_input_device
	local device = self.get_device(self, input_device_type, input_device_slot)

	return device == most_recent_device
end

return 
