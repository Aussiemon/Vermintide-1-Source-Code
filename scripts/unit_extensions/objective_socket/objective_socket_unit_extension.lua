ObjectiveSocketUnitExtension = class(ObjectiveSocketUnitExtension)
script_data.debug_objective_socket = false
ObjectiveSocketUnitExtension.init = function (self, extension_init_context, unit, extension_init_data, is_server)
	self.world = extension_init_context.world
	self.unit = unit
	self.is_server = is_server
	self.sockets = {}
	self.num_sockets = 0
	self.num_open_sockets = 0
	self.num_closed_sockets = 0

	self.setup_sockets(self, unit)

	self.pick_config = Unit.get_data(unit, "pick_config") or "ordered"
	POSITION_LOOKUP[unit] = Unit.world_position(unit, 0)

	return 
end
ObjectiveSocketUnitExtension.destroy = function (self)
	POSITION_LOOKUP[self.unit] = nil

	return 
end
ObjectiveSocketUnitExtension.setup_sockets = function (self, unit)
	local sockets = self.sockets
	local base = "socket_"
	local i = 1
	local socket_name = "socket_1"

	while Unit.has_node(unit, socket_name) do
		local node_index = Unit.node(unit, socket_name)
		sockets[i] = {
			open = true,
			socket_name = socket_name,
			node_index = node_index
		}
		i = i + 1
		socket_name = base .. i
	end

	fassert(0 < i - 1, "No socket nodes in unit %q", unit)

	self.num_sockets = i - 1

	return 
end
ObjectiveSocketUnitExtension.pick_socket_ordered = function (self, sockets)
	local num_sockets = self.num_sockets

	for i = 1, num_sockets, 1 do
		local socket = sockets[i]

		if socket.open then
			return socket, i
		end
	end

	print("[ObjectiveSocketUnitExtension]: No sockets open")

	return 
end
ObjectiveSocketUnitExtension.pick_socket_closest = function (self, sockets, unit)
	local position = POSITION_LOOKUP[unit]
	local socket_unit = self.unit
	local num_sockets = self.num_sockets
	local closest_dsq = math.huge
	local closest_socket, closest_id = nil

	for i = 1, num_sockets, 1 do
		local socket = sockets[i]

		if socket.open then
			local socket_position = Unit.world_position(socket_unit, socket.node_index)
			local distance_squared = Vector3.distance_squared(position, socket_position)

			if distance_squared < closest_dsq then
				closest_dsq = distance_squared
				closest_socket = socket
				closest_id = i
			end
		end
	end

	if not closest_socket then
		print("[ObjectiveSocketUnitExtension]: No sockets open")
	end

	return closest_socket, closest_id
end
ObjectiveSocketUnitExtension.pick_socket = function (self, unit)
	local socket, i = nil
	local pick_config = self.pick_config

	if pick_config == "ordered" then
		socket, i = self.pick_socket_ordered(self, self.sockets)
	elseif pick_config == "closest" then
		socket, i = self.pick_socket_closest(self, self.sockets, unit)
	else
		fassert(false, "[ObjectiveSocketSystem] Unknown pick_config %q in unit %q", pick_config, self.unit)
	end

	return socket, i
end
ObjectiveSocketUnitExtension.socket_from_id = function (self, socket_id)
	return self.sockets[socket_id]
end
ObjectiveSocketUnitExtension.update = function (self, unit, input, dt, context, t)
	if script_data.debug_objective_socket then
		local sockets = self.sockets
		local num_sockets = self.num_sockets

		for i = 1, num_sockets, 1 do
			local socket = sockets[i]

			if socket.open then
				local position = Unit.world_position(unit, socket.node_index)

				QuickDrawer:sphere(position, 0.05, Color(255, 0, 255, 0))
			else
				local position = Unit.world_position(unit, socket.node_index)

				QuickDrawer:sphere(position, 0.05, Color(255, 255, 0, 0))
			end
		end
	end

	return 
end

return 
