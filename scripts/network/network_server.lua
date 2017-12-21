require("scripts/network/peer_state_machine")
require("scripts/network/connection_handler")
require("scripts/network/voip")
require("scripts/game_state/components/profile_synchronizer")

local DISCONNECT_TIMER = 4

local function network_printf(format, ...)
	if script_data.network_debug_connections then
		printf("[NetworkServer] " .. format, ...)
	end

	return 
end

PeerState = PeerState or CreateStrictEnumTable("Broken", "Connecting", "Connected", "Disconnected", "Loading", "LoadingLevelComplete", "WaitingForEnter", "WaitingForGameObjectSync", "WaitingForSpawnPlayer", "InGame", "InPostGame")
NetworkServer = class(NetworkServer)
NetworkServer.init = function (self, player_manager, lobby_host, initial_level, wanted_profile_index, level_transition_handler)
	self.peer_connections = {}
	local my_peer_id = Network.peer_id()
	self.my_peer_id = my_peer_id
	self.connection_handler = ConnectionHandler:new()
	self.peers_to_disconnect = {}
	self.peers_added_to_gamesession = {}
	self.peers_completed_game_object_sync = {}
	self.player_manager = player_manager
	self.lobby_host = lobby_host
	self.peer_state_machines = {}
	self.level_transition_handler = level_transition_handler

	self.set_current_level(self, initial_level)

	local is_server = true
	self.profile_synchronizer = ProfileSynchronizer:new(is_server, lobby_host, self)
	self.voip = Voip:new(is_server, my_peer_id, self.connection_handler)
	self.wanted_profile_index = wanted_profile_index

	return 
end
NetworkServer.server_join = function (self)
	print(string.format("### Created peer state machine for %s", self.my_peer_id))

	local peer_id = self.my_peer_id
	self.peer_state_machines[peer_id] = PeerStateMachine.create(self, peer_id)

	return 
end
NetworkServer.rpc_notify_connected = function (self, sender)
	if sender == self.my_peer_id then
		local wanted_profile_index = FindProfileIndex(Development.parameter("wanted_profile")) or self.wanted_profile_index or SaveData.wanted_profile_index
		local profile_index = wanted_profile_index or self.profile_synchronizer:get_first_free_profile()

		self.peer_state_machines[sender].rpc_notify_lobby_joined(profile_index)
	end

	return 
end
NetworkServer.rpc_game_started = function (self, sender)
	if sender == self.my_peer_id then
		Managers.state.event:trigger("game_started")
	end

	return 
end
NetworkServer.can_enter_game = function (self)
	return self.peer_state_machines[self.my_peer_id].current_state == PeerStates.WaitingForEnterGame
end
NetworkServer.enter_post_game = function (self)
	network_printf("Entering post game")

	local peer_state_machines = self.peer_state_machines

	for peer_id, peer_state_machine in pairs(peer_state_machines) do
		if peer_state_machine.current_state == PeerStates.InGame then
			peer_state_machine.state_data:change_state(PeerStates.InPostGame)
		end
	end

	return 
end
NetworkServer.is_in_post_game = function (self)
	return self.peer_state_machines[self.my_peer_id].current_state == PeerStates.InPostGame
end
NetworkServer.rpc_to_client_spawn_player = function (self, sender, ...)
	if sender == self.my_peer_id then
		self.peer_state_machines[sender].rpc_to_client_spawn_player(...)
	end

	return 
end
NetworkServer.set_current_level = function (self, level_key)
	network_printf("Current level key %s", level_key)
	self.level_transition_handler:generate_level_seed()

	self.level_key = level_key

	return 
end
NetworkServer.on_game_entered = function (self, game_network_manager)
	network_printf("[NETWORK SERVER]: On Game Entered")

	self.game_session = Network.game_session()

	assert(self.game_session, "Unable to find game session in NetworkServer:on_game_entered.")

	self.game_network_manager = game_network_manager
	self.peers_completed_game_object_sync[self.my_peer_id] = true

	self.peer_state_machines[self.my_peer_id].rpc_is_ingame()

	return 
end
NetworkServer.rpc_is_ingame = function (self, sender)
	local peer_state_machine = self.peer_state_machines[sender]

	if not peer_state_machine or not peer_state_machine.has_function(peer_state_machine, "rpc_is_ingame") then
		network_printf("RPC.rpc_connection_failed(sender, NetworkLookup.connection_fails.no_peer_data_on_join)", "rpc_is_ingame")
		RPC.rpc_connection_failed(sender, NetworkLookup.connection_fails.no_peer_data_on_join)
	else
		peer_state_machine.rpc_is_ingame()
	end

	return 
end
NetworkServer.rpc_loading_synced = function (self, sender)
	return 
end
NetworkServer.peer_spawned_player = function (self, peer_id)
	network_printf("Peer %s spawned player.", peer_id)

	local peer_state_machine = self.peer_state_machines[peer_id]

	if peer_state_machine.has_function(peer_state_machine, "spawned_player") then
		peer_state_machine.spawned_player()
	end

	return 
end
NetworkServer.peer_despawned_player = function (self, peer_id)
	network_printf("Peer %s despawned player.", peer_id)

	local peer_state_machine = self.peer_state_machines[peer_id]

	if peer_state_machine.has_function(peer_state_machine, "despawned_player") then
		peer_state_machine.despawned_player()
	end

	return 
end
NetworkServer.peer_respawn_player = function (self, peer_id)
	network_printf("Peer %s respawn player.", peer_id)

	local peer_state_machine = self.peer_state_machines[peer_id]

	if peer_state_machine.has_function(peer_state_machine, "respawn_player") then
		peer_state_machine.respawn_player()
	end

	return 
end
NetworkServer.rpc_client_respawn_player = function (self, sender)
	self.peer_respawn_player(self, sender)

	return 
end
NetworkServer.destroy = function (self)
	if self.network_event_delegate then
		self.unregister_rpcs(self)
	end

	self.voip:destroy()

	self.voip = nil

	self.profile_synchronizer:destroy()

	self.profile_synchronizer = nil

	self.connection_handler:update(0)
	GarbageLeakDetector.register_object(self, "NetworkServer")

	return 
end
NetworkServer.register_rpcs = function (self, network_event_delegate, network_transmit)
	network_event_delegate.register(network_event_delegate, self, "rpc_client_connection_state", "rpc_notify_lobby_joined", "rpc_to_client_spawn_player", "rpc_want_to_spawn_player", "rpc_level_loaded", "rpc_game_started", "rpc_is_ingame", "game_object_sync_done", "rpc_notify_connected", "rpc_loading_synced", "rpc_clear_peer_state", "rpc_client_respawn_player")

	self.network_event_delegate = network_event_delegate

	self.profile_synchronizer:register_rpcs(network_event_delegate, network_transmit)

	self.network_transmit = network_transmit

	self.voip:register_rpcs(network_event_delegate, network_transmit)

	return 
end
NetworkServer.on_level_exit = function (self)
	table.clear(self.peers_completed_game_object_sync)

	for peer_id, peer_data in pairs(self.peer_connections) do
		if peer_data.state == PeerState.InPostGame then
			peer_data.state = PeerState.Loading
		end
	end

	local peer_state_machines = self.peer_state_machines

	for peer_id, peer_state_machine in pairs(peer_state_machines) do
		local current_state = peer_state_machine.current_state

		if current_state ~= PeerStates.Connecting and current_state ~= PeerStates.Disconnecting and current_state ~= PeerStates.Disconnected then
			peer_state_machine.state_data:change_state(PeerStates.Loading)
		end
	end

	table.clear(self.peers_added_to_gamesession)
	self.unregister_rpcs(self)

	self.game_network_manager = nil
	self.game_session = nil

	return 
end
NetworkServer.unregister_rpcs = function (self)
	self.voip:unregister_rpcs()

	if self.network_event_delegate then
		self.network_event_delegate:unregister(self)

		self.network_event_delegate = nil
	end

	self.profile_synchronizer:unregister_network_events()

	self.network_transmit = nil

	return 
end
NetworkServer.has_all_peers_loaded_packages = function (self)
	return self.profile_synchronizer:all_synced()
end
NetworkServer.kick_peer = function (self, peer_id)
	self.network_transmit:send_rpc("rpc_kick_peer", peer_id)

	return 
end
NetworkServer.disconnect_all_peers = function (self, reason)
	local reason_id = NetworkLookup.connection_fails[reason]
	local peer_state_machines = self.peer_state_machines

	for peer_id, peer_state_machine in pairs(peer_state_machines) do
		if peer_state_machine.current_state ~= PeerStates.Disconnecting and peer_state_machine.current_state ~= PeerStates.Disconnected then
			RPC.rpc_connection_failed(peer_id, reason_id)
		end
	end

	return 
end
NetworkServer.force_disconnect_all_client_peers = function (self)
	local peer_state_machines = self.peer_state_machines

	for peer_id, peer_state_machine in pairs(peer_state_machines) do
		local client = peer_id ~= self.my_peer_id

		if client and peer_state_machine.current_state ~= PeerStates.Disconnecting and peer_state_machine.current_state ~= PeerStates.Disconnected then
			peer_state_machine.state_data:change_state(PeerStates.Disconnecting)
		end
	end

	return 
end
NetworkServer.rpc_client_connection_state = function (self, sender, peer_id, peer_state)
	return 
end
NetworkServer.rpc_notify_lobby_joined = function (self, sender, wanted_profile_index, clan_tag)
	network_printf("Peer %s has sent rpc_notify_lobby_joined", tostring(sender))

	local peer_state_machine = self.peer_state_machines[sender]

	if not peer_state_machine or not peer_state_machine.has_function(peer_state_machine, "rpc_notify_lobby_joined") then
		network_printf("RPC.rpc_connection_failed(sender, NetworkLookup.connection_fails.no_peer_data_on_join)", "rpc_notify_lobby_joined")
		RPC.rpc_connection_failed(sender, NetworkLookup.connection_fails.no_peer_data_on_join)
	else
		peer_state_machine.rpc_notify_lobby_joined(wanted_profile_index, clan_tag)
	end

	return 
end
NetworkServer.rpc_level_loaded = function (self, sender, level_id)
	print("### Sending rpc_level_loaded")

	local peer_state_machine = self.peer_state_machines[sender]

	if not peer_state_machine then
		network_printf("RPC.rpc_connection_failed(sender, NetworkLookup.connection_fails.no_peer_data_on_enter_game)", "rpc_level_loaded")
		RPC.rpc_connection_failed(sender, NetworkLookup.connection_fails.no_peer_data_on_enter_game)
	else
		print(string.format("#### Has state machine: %s, sender: %s, level_id: %s", peer_state_machine.has_function(peer_state_machine, "rpc_level_loaded"), sender, level_id))

		if peer_state_machine.has_function(peer_state_machine, "rpc_level_loaded") then
			peer_state_machine.rpc_level_loaded(level_id)
		end
	end

	return 
end
NetworkServer.rpc_want_to_spawn_player = function (self, sender)
	local peer_state_machine = self.peer_state_machines[sender]

	if not peer_state_machine or not peer_state_machine.has_function(peer_state_machine, "rpc_want_to_spawn_player") then
		network_printf("RPC.rpc_connection_failed(sender, NetworkLookup.connection_fails.no_peer_data_on_enter_game)", "rpc_want_to_spawn_player")
		RPC.rpc_connection_failed(sender, NetworkLookup.connection_fails.no_peer_data_on_enter_game)
	else
		peer_state_machine.rpc_want_to_spawn_player()
	end

	return 
end
NetworkServer.game_object_sync_done = function (self, peer_id)
	network_printf("Game_object_sync_done for peer %s", peer_id)

	self.peers_completed_game_object_sync[peer_id] = true

	self.game_network_manager:_hot_join_sync(peer_id)
	RPC.rpc_set_migration_host(peer_id, self.host_to_migrate_to or "", (self.host_to_migrate_to and true) or false)

	return 
end
NetworkServer.update = function (self, dt)
	self.profile_synchronizer:update()

	local connection_handler = self.connection_handler
	local peer_state_machines = self.peer_state_machines
	local new_connections = connection_handler.update(connection_handler, dt)

	for peer_id, _ in pairs(new_connections) do
		network_printf("New connection detected in NetworkServer from %q", peer_id)
	end

	local lobby_members = self.lobby_host:members()

	if lobby_members then
		local members_joined = lobby_members.get_members_joined(lobby_members)

		for i, peer_id in ipairs(members_joined) do
			if peer_id ~= self.lobby_host:lobby_host() then
				network_printf("Peer %s joined server lobby.", peer_id)
				network_printf("Creating peer info.")

				peer_state_machines[peer_id] = PeerStateMachine.create(self, peer_id)
				local sender = (rawget(_G, "Steam") and Steam.user_name(peer_id)) or tostring(peer_id)

				Managers.chat:send_system_chat_message_to_all_except(1, "system_chat_player_joined_the_game", sender, peer_id, true)
			end
		end

		local members_left = lobby_members.get_members_left(lobby_members)

		for i, peer_id in ipairs(members_left) do
			network_printf("Peer %s left server lobby.", peer_id)

			local sender = (rawget(_G, "Steam") and Steam.user_name(peer_id)) or tostring(peer_id)

			Managers.chat:send_system_chat_message_to_all_except(1, "system_chat_player_left_the_game", sender, peer_id, true)

			local peer_state_machine = peer_state_machines[peer_id]

			if peer_state_machine and peer_state_machine.current_state ~= PeerStates.Disconnecting and peer_state_machine.current_state ~= PeerStates.Disconnected then
				network_printf("Disconnecting peer.")
				peer_state_machine.state_data:change_state(PeerStates.Disconnecting)
			end
		end
	end

	local broken_connections, broken_connections_n = connection_handler.get_broken_connections(connection_handler)

	for i = 1, broken_connections_n, 1 do
		local peer_id = broken_connections[i]
		local peer_state_machine = peer_state_machines[peer_id]

		if peer_state_machine and peer_state_machine.current_state ~= PeerStates.Disconnecting and peer_state_machine.current_state ~= PeerStates.Disconnected then
			peer_state_machine.state_data:change_state(PeerStates.Disconnecting)
			network_printf("Broken connection to peer id %s discovered in connection handler. Server selecting peer to disconnect.", peer_id)
		end

		broken_connections[peer_id] = nil
	end

	local game_session = self.game_network_manager and self.game_network_manager:game()

	if game_session then
		local peer_id = GameSession.wants_to_leave(game_session)
		local peer_state_machine = peer_state_machines[peer_id]

		if peer_state_machine and peer_state_machine.current_state ~= PeerStates.Disconnecting and peer_state_machine.current_state ~= PeerStates.Disconnected then
			peer_state_machine.state_data:change_state(PeerStates.Disconnecting)
		end
	end

	for peer_id, peer_state_machine in pairs(peer_state_machines) do
		peer_state_machine.update(peer_state_machine, dt)
	end

	if self.game_network_manager and not self.game_network_manager:is_leaving_game() then
		local peers_ingame = 0
		local host_to_migrate_to = self.host_to_migrate_to

		for peer_id, peer_state_machine in pairs(peer_state_machines) do
			if peer_id ~= Network.peer_id() and peer_state_machine.current_state == PeerStates.InGame then
				host_to_migrate_to = peer_id
				peers_ingame = peers_ingame + 1
			end
		end

		if peers_ingame < 2 then
			host_to_migrate_to = nil
		end

		if host_to_migrate_to ~= self.host_to_migrate_to then
			self.host_to_migrate_to = host_to_migrate_to

			self.network_transmit:send_rpc_clients("rpc_set_migration_host", host_to_migrate_to or "", (host_to_migrate_to and true) or false)
		end
	end

	if not LEVEL_EDITOR_TEST then
		self.voip:update()
	end

	return 
end
NetworkServer.rpc_clear_peer_state = function (self, sender)
	print(string.format("### CLEARING PEER STATE FOR %s", tostring(sender)))
	self.peer_state_machines[sender].state_data:change_state(PeerStates.Connecting)

	local players_by_peer = Managers.player:players_at_peer(sender)

	if not players_by_peer then
		return 
	end

	for _, player in pairs(players_by_peer) do
		local profile_index = self.profile_synchronizer:profile_by_peer(sender, player.local_player_id(player))

		if profile_index then
			self.profile_synchronizer:clear_ownership(profile_index)
		end
	end

	return 
end
NetworkServer.player_is_joining = function (self, peer_id)
	local peer_state_machines = self.peer_state_machines
	local peer_state_machine = peer_state_machines[peer_id]

	if not peer_state_machine then
		return false
	end

	local joining = peer_state_machine.current_state == PeerStates.Connecting or peer_state_machine.current_state == PeerStates.Loading or peer_state_machine.current_state == PeerStates.LoadingProfilePackages or peer_state_machine.current_state == PeerStates.WaitingForEnterGame or peer_state_machine.current_state == PeerStates.WaitingForGameObjectSync or peer_state_machine.current_state == PeerStates.SpawningPlayer

	return joining
end
local dummy_ignore_map = {}
NetworkServer.are_all_peers_ingame = function (self, ignore_map)
	ignore_map = ignore_map or dummy_ignore_map
	local peer_state_machines = self.peer_state_machines

	for peer_id, peer_state_machine in pairs(peer_state_machines) do
		local state_name = peer_state_machine.current_state.state_name

		if ignore_map[peer_id] == nil and state_name ~= "InGame" and state_name ~= "InPostGame" and state_name ~= "Disconnected" then
			return false
		end
	end

	return true
end
NetworkServer.are_all_peers_ready = function (self)
	local peer_state_machines = self.peer_state_machines

	for peer_id, peer_state_machine in pairs(peer_state_machines) do
		local state_name = peer_state_machine.current_state.state_name

		if state_name ~= "WaitingForPlayers" and state_name ~= "InGame" and state_name ~= "SpawningPlayer" and state_name ~= "Disconnected" then
			return false
		end
	end

	return true
end
NetworkServer.all_client_peers_disconnected = function (self)
	local peer_state_machines = self.peer_state_machines

	for peer_id, peer_state_machine in pairs(peer_state_machines) do
		local state_name = peer_state_machine.current_state.state_name
		local client = peer_id ~= self.my_peer_id

		if client and state_name ~= "Disconnected" then
			return false
		end
	end

	return true
end

return 
