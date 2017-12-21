require("scripts/game_state/components/profile_synchronizer")

NetworkClient = class(NetworkClient)
local CONNECTION_TIMEOUT = 15

local function network_printf(format, ...)
	if script_data.network_debug_connections then
		printf("[NetworkClient] " .. format, ...)
	end

	return 
end

NetworkClient.init = function (self, level_transition_handler, server_peer_id, level_index, wanted_profile_index, clear_peer_states)
	self.level_transition_handler = level_transition_handler

	self.set_state(self, "connecting")

	self.connection_handler = ConnectionHandler:new(server_peer_id)
	self.server_peer_id = server_peer_id
	self.profile_synchronizer = ProfileSynchronizer:new(false)
	self.wanted_profile_index = wanted_profile_index or SaveData.wanted_profile_index or 1
	local profile = SPProfiles[self.wanted_profile_index]
	local display_name = (profile and profile.display_name) or "no profile wanted"

	network_printf("init - wanted_profile_index, %s, %s", self.wanted_profile_index, display_name)

	self.last_level_index = level_index

	if clear_peer_states then
		network_printf("SENDING rpc_clear_peer_state to %s", self.server_peer_id)
		RPC.rpc_clear_peer_state(self.server_peer_id)
	end

	local is_server = false
	self.voip = Voip:new(is_server, nil, self.connection_handler)
	self.connecting_timeout = 0

	return 
end
NetworkClient.destroy = function (self)
	if self.network_message_router then
		self.unregister_rpcs(self)
	end

	self.voip:destroy()

	self.voip = nil

	self.profile_synchronizer:destroy()

	self.profile_synchronizer = nil

	self.connection_handler:update(0)
	GarbageLeakDetector.register_object(self, "Network Client")

	return 
end
NetworkClient.register_rpcs = function (self, network_message_router, network_transmit)
	network_message_router.register(network_message_router, self, "rpc_loading_synced", "rpc_reload_level", "rpc_load_level", "rpc_game_started", "rpc_disconnect_peer", "rpc_connection_failed", "rpc_notify_connected", "rpc_set_migration_host")

	self.network_message_router = network_message_router

	self.profile_synchronizer:register_rpcs(network_message_router, network_transmit)
	self.voip:register_rpcs(network_message_router, network_transmit)

	return 
end
NetworkClient.unregister_rpcs = function (self)
	self.voip:unregister_rpcs()
	self.network_message_router:unregister(self)

	self.network_message_router = nil

	self.profile_synchronizer:unregister_network_events()

	return 
end
NetworkClient.rpc_connection_failed = function (self, sender, reason)
	self.fail_reason = NetworkLookup.connection_fails[reason]

	network_printf("rpc_connection_failed due to %s", self.fail_reason)
	self.set_state(self, "denied_enter_game")

	for i = 1, 10, 1 do
		network_printf("Connection to server failed with reason %s", self.fail_reason)
	end

	return 
end
NetworkClient.rpc_notify_connected = function (self, sender)
	if not self._notification_sent then
		RPC.rpc_notify_lobby_joined(self.server_peer_id, self.wanted_profile_index, Application.user_setting("clan_tag") or "0")

		self._notification_sent = true

		self.set_state(self, "connected")

		if self.loaded_level_name then
			local level_name = self.loaded_level_name

			RPC.rpc_level_loaded(self.server_peer_id, NetworkLookup.level_keys[level_name])

			self.loaded_level_name = nil
		end
	end

	return 
end
NetworkClient.rpc_disconnect_peer = function (self, sender, peer_id)
	self.connection_handler:disconnect_peers(peer_id)

	return 
end
NetworkClient.rpc_loading_synced = function (self, sender)
	if self.state ~= "game_started" then
		self.set_state(self, "waiting_enter_game")
	end

	return 
end
NetworkClient.rpc_reload_level = function (self, sender)
	self.set_state(self, "loading")

	return 
end
NetworkClient.rpc_load_level = function (self, sender, level_index, level_seed)
	local level_transition_handler = self.level_transition_handler

	if level_transition_handler.transition_in_progress(level_transition_handler) then
		return 
	end

	self.set_state(self, "loading")

	local level_key = NetworkLookup.level_keys[level_index]

	self.level_transition_handler:prepare_load_level(level_index, level_seed)

	return 
end
NetworkClient.rpc_set_migration_host = function (self, sender, peer_id, do_migrate)
	if do_migrate then
		local player = Managers.player:player_from_peer_id(peer_id)
		local name = player.name(player)
		self.host_to_migrate_to = {
			peer_id = peer_id,
			name = name
		}
	else
		self.host_to_migrate_to = nil
	end

	return 
end
NetworkClient.set_state = function (self, new_state)
	network_printf("New State %s (old state %s)", new_state, tostring(self.state))

	self.state = new_state

	return 
end
NetworkClient.on_game_entered = function (self)
	self.set_state(self, "is_ingame")
	RPC.rpc_is_ingame(self.server_peer_id)

	return 
end
NetworkClient.rpc_game_started = function (self, sender)
	network_printf("rpc_game_started")
	self.set_state(self, "game_started")
	Managers.state.event:trigger("game_started")

	return 
end
NetworkClient.on_level_loaded = function (self, level_name)
	network_printf("on_level_loaded %s", level_name)

	if self.state ~= "connecting" then
		RPC.rpc_level_loaded(self.server_peer_id, NetworkLookup.level_keys[level_name])
	else
		self.loaded_level_name = level_name
	end

	return 
end
NetworkClient.update = function (self, dt)
	self.profile_synchronizer:update()
	self.connection_handler:update(dt)

	if not self.wait_for_state_loading then
		if self.level_transition_handler:all_packages_loaded() then
			if self.state == "loading" then
				network_printf("All level packages loaded!", self.level_transition_handler:get_current_level_keys())
				self.set_state(self, "loaded")
				self.on_level_loaded(self, self.level_transition_handler:get_current_level_keys())
			end
		elseif self.state ~= "loading" then
			network_printf("Forcing state to 'loading'")
			self.set_state(self, "loading")
		end
	end

	local connection_handler = self.connection_handler
	local broken_connections = connection_handler.get_broken_connections(connection_handler)

	for index, peer_id in pairs(broken_connections) do
		broken_connections[peer_id] = nil

		if peer_id == self.server_peer_id and self.state ~= "lost_connection_to_host" then
			self.fail_reason = "broken_connection"

			network_printf("broken_connection to %s", peer_id)
			self.set_state(self, "lost_connection_to_host")
		end
	end

	if self.state == "connecting" then
		self.connecting_timeout = self.connecting_timeout + dt

		if CONNECTION_TIMEOUT < self.connecting_timeout then
			self.connecting_timeout = 0
			self.fail_reason = "broken_connection"

			network_printf("connection timeout leading to broken_connection")
			self.set_state(self, "denied_enter_game")
		end
	end

	self.voip:update()

	return 
end
NetworkClient.can_enter_game = function (self)
	return self.state == "waiting_enter_game"
end
NetworkClient.is_ingame = function (self)
	return self.state == "is_ingame" or self.state == "game_started"
end
NetworkClient.set_wait_for_state_loading = function (self, wait)
	self.wait_for_state_loading = wait

	return 
end

return 