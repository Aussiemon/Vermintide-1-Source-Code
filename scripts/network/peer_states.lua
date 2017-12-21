PeerStates = {}
PeerStates.Connecting = {
	on_enter = function (self, previous_state)
		self.server.network_transmit:send_rpc("rpc_notify_connected", self.peer_id)

		self.loaded_level = nil

		return 
	end,
	rpc_notify_lobby_joined = function (self, wanted_profile_index, clan_tag)
		self.num_players = 1
		self.has_received_rpc_notify_lobby_joined = true
		self.clan_tag = clan_tag

		printf("[PSM] Peer %s joined. Want to use profile index %q", tostring(self.peer_id), tostring(wanted_profile_index), tostring(clan_tag))

		self.wanted_profile_index = wanted_profile_index

		return 
	end,
	rpc_level_loaded = function (self, level_id)
		self.loaded_level = NetworkLookup.level_keys[level_id]

		return 
	end,
	update = function (self, dt)
		if Application.platform() == "xb1" and not self.has_received_rpc_notify_lobby_joined then
			self.server.network_transmit:send_rpc("rpc_notify_connected", self.peer_id)
		end

		local server_in_post_game = self.server:is_in_post_game()

		if not server_in_post_game and self.has_received_rpc_notify_lobby_joined then
			self.has_received_rpc_notify_lobby_joined = false

			return PeerStates.Loading
		end

		return 
	end,
	on_exit = function (self, new_state)
		return 
	end
}
PeerStates.Loading = {
	on_enter = function (self, previous_state)
		self.game_started = false
		self.is_ingame = nil
		local level_key = self.server.level_key
		local game_mode_manager = Managers.state.game_mode
		local level_seed = self.server.level_transition_handler.level_seed

		if level_seed == nil then
			Application.warning("[PSM] No level seed set, fallbacking to 0")

			level_seed = 0
		end

		self.server.network_transmit:send_rpc("rpc_load_level", self.peer_id, NetworkLookup.level_keys[level_key], level_seed)

		return 
	end,
	rpc_is_ingame = function (self)
		print("[PSM] Got rpc_is_ingame in PeerStates.Loading, is that ok?")

		self.is_ingame = true

		return 
	end,
	rpc_level_loaded = function (self, level_id)
		self.loaded_level = NetworkLookup.level_keys[level_id]

		return 
	end,
	update = function (self, dt)
		local server_level_key = self.server.level_key

		if self.loaded_level == server_level_key then
			return PeerStates.LoadingProfilePackages
		end

		return 
	end,
	on_exit = function (self, new_state)
		return 
	end
}
PeerStates.LoadingProfilePackages = {
	on_enter = function (self, previous_state)
		local server = self.server
		local profile_synchronizer = server.profile_synchronizer
		local peer_id = self.peer_id
		local local_player_id = 1
		local old_index = profile_synchronizer.profile_by_peer(profile_synchronizer, peer_id, local_player_id)
		local wanted_profile_index = self.wanted_profile_index
		self.wait_for_bot_despawn = false

		if old_index then
			self.my_profile_index = old_index

			return 
		elseif wanted_profile_index == 0 then
			self.my_profile_index = profile_synchronizer.get_first_free_profile(profile_synchronizer)
		else
			local owner_type = profile_synchronizer.owner_type(profile_synchronizer, wanted_profile_index)

			if owner_type == "human" then
				self.my_profile_index = profile_synchronizer.get_first_free_profile(profile_synchronizer)
			elseif owner_type == "bot" then
				self.my_profile_index = wanted_profile_index
				self.wait_for_bot_despawn = true
			elseif owner_type == "available" then
				self.my_profile_index = wanted_profile_index
			else
				Application.error("owner type unknown", owner_type)
			end
		end

		if self.wait_for_bot_despawn then
			profile_synchronizer.reserve_profile(profile_synchronizer, self.my_profile_index, peer_id, local_player_id)
		else
			profile_synchronizer.peer_entered_session(profile_synchronizer, peer_id)
			profile_synchronizer.set_profile_peer_id(profile_synchronizer, self.my_profile_index, peer_id, local_player_id)
			profile_synchronizer.hot_join_sync(profile_synchronizer, peer_id, {
				local_player_id
			})
		end

		return 
	end,
	rpc_is_ingame = function (self)
		self.is_ingame = true

		return 
	end,
	update = function (self, dt)
		local server = self.server
		local synchronizer = server.profile_synchronizer

		if self.wait_for_bot_despawn then
			local profile_index = self.my_profile_index
			local owner = synchronizer.owner(synchronizer, profile_index)

			if not owner then
				local peer_id = self.peer_id
				local local_player_id = 1

				synchronizer.unreserve_profile(synchronizer, profile_index, peer_id, local_player_id)
				synchronizer.peer_entered_session(synchronizer, peer_id)
				synchronizer.set_profile_peer_id(synchronizer, profile_index, peer_id, local_player_id)
				synchronizer.hot_join_sync(synchronizer, peer_id, {
					local_player_id
				})

				self.wait_for_bot_despawn = false
			end
		elseif synchronizer.all_synced(synchronizer) then
			server.network_transmit:send_rpc("rpc_loading_synced", self.peer_id)

			return PeerStates.WaitingForEnterGame
		end

		return 
	end,
	on_exit = function (self, new_state)
		if self.wait_for_bot_despawn then
			local peer_id = self.peer_id
			local local_player_id = 1
			local profile_index = self.my_profile_index

			synchronizer:unreserve_profile(profile_index, peer_id, local_player_id)
		end

		return 
	end
}
PeerStates.WaitingForEnterGame = {
	on_enter = function (self, previous_state)
		return 
	end,
	rpc_is_ingame = function (self)
		self.is_ingame = true

		return 
	end,
	update = function (self, dt)
		local server = self.server

		if self.is_ingame and server.game_network_manager then
			local peer_id = self.peer_id

			if not server.peers_added_to_gamesession[peer_id] then
				server.game_network_manager:set_peer_synchronizing(peer_id)

				local game_session = server.game_session

				if game_session then
					GameSession.add_peer(game_session, peer_id)

					server.peers_added_to_gamesession[peer_id] = true
				end
			end

			self.change_state(self, PeerStates.WaitingForGameObjectSync)
		end

		return 
	end,
	on_exit = function (self, new_state)
		return 
	end
}
PeerStates.WaitingForGameObjectSync = {
	on_enter = function (self, previous_state)
		return 
	end,
	update = function (self, dt)
		local peer_id = self.peer_id

		if self.server.peers_completed_game_object_sync[peer_id] then
			if not self.game_started then
				self.server.network_transmit:send_rpc("rpc_game_started", self.peer_id)

				self.game_started = true
			end

			return PeerStates.WaitingForPlayers
		end

		return 
	end,
	on_exit = function (self, new_state)
		return 
	end
}
PeerStates.WaitingForPlayers = {
	on_enter = function (self, previous_state)
		return 
	end,
	update = function (self, dt)
		local cutscene_system = Managers.state.entity:system("cutscene_system")

		if not cutscene_system.cutscene_started then
			local server = self.server

			if server.are_all_peers_ready(server) then
				return PeerStates.SpawningPlayer
			end
		elseif cutscene_system.has_intro_cutscene_finished_playing(cutscene_system) then
			return PeerStates.SpawningPlayer
		end

		return 
	end,
	on_exit = function (self, new_state)
		return 
	end
}
PeerStates.SpawningPlayer = {
	on_enter = function (self, previous_state)
		return 
	end,
	spawned_player = function (self)
		self.has_spawned_player = true

		return 
	end,
	rpc_to_client_spawn_player = function (self, local_player_id, spawn_index, profile_index)
		assert(self.peer_id == self.server.my_peer_id, "Received rpc_to_client_spawn_player from someone other than the server. This is illegal.")

		self.has_spawned_player = true

		return 
	end,
	update = function (self, dt)
		local server = self.server

		if server.profile_synchronizer:all_synced() and not self.sent_spawn_peer_player then
			local peer_id = self.peer_id
			self.sent_spawn_peer_player = true

			for i = 1, self.num_players, 1 do
				self.server.game_network_manager:spawn_peer_player(peer_id, i, self.clan_tag)
			end
		end

		if self.has_spawned_player then
			self.has_spawned_player = nil
			self.sent_spawn_peer_player = nil

			return PeerStates.InGame
		end

		return 
	end,
	on_exit = function (self, new_state)
		self.sent_spawn_peer_player = nil
		self.has_spawned_player = nil

		return 
	end
}
PeerStates.InGame = {
	on_enter = function (self, previous_state)
		return 
	end,
	despawned_player = function (self)
		self.despawned_player = true

		return 
	end,
	update = function (self, dt)
		if self.despawned_player then
			local profile_index = self.server.profile_synchronizer:profile_by_peer(self.peer_id, 1)

			if profile_index ~= self.my_profile_index then
				self.my_profile_index = profile_index
				self.despawned_player = nil

				return PeerStates.LoadingProfilePackages
			end
		end

		return 
	end,
	on_exit = function (self, new_state)
		self.despawned_player = nil

		return 
	end
}
PeerStates.InPostGame = {
	on_enter = function (self, previous_state)
		return 
	end,
	update = function (self, dt)
		return 
	end,
	on_exit = function (self, new_state)
		return 
	end
}
PeerStates.Disconnecting = {
	on_enter = function (self, previous_state)
		self.is_ingame = nil
		local server = self.server
		local game_session = server.game_session
		local peer_id = self.peer_id
		local game_network_manager = server.game_network_manager

		if game_session and server.peers_added_to_gamesession[peer_id] then
			printf("[PSM] Disconnected peer %s is being removed from session.", peer_id)

			local in_session = server.game_network_manager:in_game_session()

			if in_session then
				GameSession.remove_peer(game_session, peer_id, game_network_manager)
			end

			server.peers_added_to_gamesession[peer_id] = nil
		end

		if game_network_manager then
			game_network_manager.remove_peer(game_network_manager, peer_id)
		end

		server.peers_completed_game_object_sync[peer_id] = nil

		return 
	end,
	update = function (self, dt)
		local peer_id = self.peer_id

		return PeerStates.Disconnected
	end,
	on_exit = function (self, new_state)
		return 
	end
}
PeerStates.Disconnected = {
	on_enter = function (self, previous_state)
		local peer_id = self.peer_id
		local server = self.server
		local profile_synchronizer = server.profile_synchronizer
		local old_index = profile_synchronizer.profile_by_peer(profile_synchronizer, peer_id, 1)

		if old_index then
			profile_synchronizer.set_profile_peer_id(profile_synchronizer, old_index, nil)
		end

		profile_synchronizer.peer_left_session(profile_synchronizer, peer_id)
		server.connection_handler:disconnect_peers(peer_id)

		return 
	end,
	update = function (self, dt)
		return 
	end,
	on_exit = function (self, new_state)
		return 
	end
}

for state_name, state_table in pairs(PeerStates) do
	state_table.state_name = state_name

	setmetatable(state_table, {
		__tostring = function ()
			return state_name
		end
	})
end

return 
