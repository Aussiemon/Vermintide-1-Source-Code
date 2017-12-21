local function network_printf(format, ...)
	if script_data.network_debug_connections then
		printf("[StateLoadingMigrateHost] " .. format, ...)
	end

	return 
end

StateLoadingMigrateHost = class(StateLoadingMigrateHost)
StateLoadingMigrateHost.NAME = "StateLoadingMigrateHost"
StateLoadingMigrateHost.on_enter = function (self, params)
	print("[Gamestate] Enter Substate StateLoadingMigrateHost")
	self._init_params(self, params)
	self._init_network(self)

	return 
end
StateLoadingMigrateHost._init_params = function (self, params)
	self._loading_view = params.loading_view
	self._lobby_client = params.lobby_client
	self._lobby_joined = false
	self._server_created = false

	return 
end
StateLoadingMigrateHost._init_network = function (self)
	self.parent:setup_network_options()

	if not self.parent:has_registered_rpcs() then
		self.parent:register_rpcs()
	end

	local loading_context = self.parent.parent.loading_context
	local host_to_migrate_to = loading_context.host_to_migrate_to
	local host_peer_id = host_to_migrate_to and host_to_migrate_to.peer_id

	if host_peer_id == Network.peer_id() then
		network_printf("creating host for people to migrate to")
		self.parent:setup_lobby_host(callback(self, "cb_server_created"))
		self.parent:start_matchmaking()
	else
		network_printf("Migrating to host %s, trying to find its lobby...", host_to_migrate_to)
		self.parent:setup_lobby_finder(callback(self, "cb_lobby_joined"), nil, host_to_migrate_to)

		local requirements = {
			free_slots = 1,
			distance_filter = LobbyDistanceFilter.WORLD,
			filters = {
				host = {
					value = host_peer_id,
					comparison = LobbyComparison.EQUAL
				}
			}
		}

		LobbyInternal.clear_filter_requirements()
		LobbyInternal.add_filter_requirements(requirements)
	end

	return 
end
StateLoadingMigrateHost.update = function (self, dt, t)
	if self._server_created or self._lobby_joined then
		return StateLoadingRunning
	end

	return 
end
StateLoadingMigrateHost.on_exit = function (self, application_shutdown)
	return 
end
StateLoadingMigrateHost.cb_server_created = function (self)
	network_printf("cb_server_created")

	self._server_created = true

	return 
end
StateLoadingMigrateHost.cb_lobby_joined = function (self)
	network_printf("cb_lobby_joined")

	self._lobby_joined = true

	return 
end

return 
