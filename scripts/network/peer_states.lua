PeerStates = {}
local time_between_resend_rpc_notify_connected = 2
PeerStates.Connecting = {
	on_enter = function (self, previous_state)
		self.server.network_transmit:send_rpc("rpc_notify_connected", self.peer_id)

		self.loaded_level = nil
		self.resend_timer = time_between_resend_rpc_notify_connected
		self.resend_post_game_timer = time_between_resend_rpc_notify_connected

		printf("[PSM] Sending rpc_notify_connected to Peer %s", tostring(self.peer_id))
	end,
	rpc_notify_lobby_joined = function (self, wanted_profile_index, clan_tag)
		self.num_players = 1
		self.has_received_rpc_notify_lobby_joined = true
		self.clan_tag = clan_tag

		printf("[PSM] Peer %s joined. Want to use profile index %q", tostring(self.peer_id), tostring(wanted_profile_index), tostring(clan_tag))

		self.wanted_profile_index = wanted_profile_index
	end,
	rpc_post_game_notified = function (self, in_post_game)
		self._has_been_notfied_of_post_game_state = true
		self._in_post_game = in_post_game
	end,
	rpc_level_loaded = function (self, level_id)
		self.loaded_level = NetworkLookup.level_keys[level_id]
	end,
	update = function (self, dt)
		if not self.has_received_rpc_notify_lobby_joined then
			self.resend_timer = self.resend_timer - dt
			local resend_rpc_notify_connected = self.resend_timer < 0

			if resend_rpc_notify_connected then
				self.server.network_transmit:send_rpc("rpc_notify_connected", self.peer_id)
				printf("[PSM] Resendind rpc_notify_connected to Peer %s", tostring(self.peer_id))

				self.resend_timer = time_between_resend_rpc_notify_connected
			end
		end

		local server_in_post_game = self.server:is_in_post_game()

		if self._has_been_notfied_of_post_game_state then
			if not server_in_post_game then
				local server_was_in_post_game = self._in_post_game

				if server_was_in_post_game then
					self._has_been_notfied_of_post_game_state = nil
				elseif self.has_received_rpc_notify_lobby_joined then
					return PeerStates.Loading
				end
			end
		else
			self.resend_post_game_timer = self.resend_post_game_timer - dt
			local resend_rpc_notify_in_post_game = self.resend_post_game_timer < 0

			if resend_rpc_notify_in_post_game then
				self.server.network_transmit:send_rpc("rpc_notify_in_post_game", self.peer_id, server_in_post_game)
				printf("[PSM] Sending rpc_notify_in_post_game to Peer %s", tostring(self.peer_id))

				self.resend_post_game_timer = time_between_resend_rpc_notify_connected
			end
		end
	end,
	on_exit = function (self, new_state)
		self._has_been_notfied_of_post_game_state = nil
		self.has_received_rpc_notify_lobby_joined = nil
		self._in_post_game = nil
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
	end,
	rpc_is_ingame = function (self)
		print("[PSM] Got rpc_is_ingame in PeerStates.Loading, is that ok?")

		self.is_ingame = true
	end,
	rpc_level_loaded = function (self, level_id)
		self.loaded_level = NetworkLookup.level_keys[level_id]
	end,
	update = function (self, dt)
		local server_level_key = self.server.level_key

		if self.loaded_level == server_level_key then
			return PeerStates.LoadingProfilePackages
		end
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
		local old_index = profile_synchronizer:profile_by_peer(peer_id, local_player_id)
		local wanted_profile_index = self.wanted_profile_index
		self.wait_for_bot_despawn = false

		if old_index then
			self.my_profile_index = old_index

			return
		elseif wanted_profile_index == 0 then
			self.my_profile_index = profile_synchronizer:get_first_free_profile()
		else
			local owner_type = profile_synchronizer:owner_type(wanted_profile_index)

			if owner_type == "human" then
				self.my_profile_index = profile_synchronizer:get_first_free_profile()
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
			profile_synchronizer:reserve_profile(self.my_profile_index, peer_id, local_player_id)
		else
			profile_synchronizer:peer_entered_session(peer_id)
			profile_synchronizer:set_profile_peer_id(self.my_profile_index, peer_id, local_player_id)
			profile_synchronizer:hot_join_sync(peer_id, {
				local_player_id
			})
		end
	end,
	rpc_is_ingame = function (self)
		self.is_ingame = true
	end,
	update = function (self, dt)
		local server = self.server
		local synchronizer = server.profile_synchronizer

		if self.wait_for_bot_despawn then
			local profile_index = self.my_profile_index
			local owner = synchronizer:owner(profile_index)

			if not owner then
				local peer_id = self.peer_id
				local local_player_id = 1

				synchronizer:unreserve_profile(profile_index, peer_id, local_player_id)
				synchronizer:peer_entered_session(peer_id)
				synchronizer:set_profile_peer_id(profile_index, peer_id, local_player_id)
				synchronizer:hot_join_sync(peer_id, {
					local_player_id
				})

				self.wait_for_bot_despawn = false
			end
		elseif synchronizer:all_synced() then
			server.network_transmit:send_rpc("rpc_loading_synced", self.peer_id)

			return PeerStates.WaitingForEnterGame
		end
	end,
	on_exit = function (self, new_state)
		if self.wait_for_bot_despawn then
			local peer_id = self.peer_id
			local local_player_id = 1
			local profile_index = self.my_profile_index
			local server = self.server
			local synchronizer = server and server.profile_synchronizer

			if synchronizer then
				synchronizer:unreserve_profile(profile_index, peer_id, local_player_id)
			end
		end
	end
}
PeerStates.WaitingForEnterGame = {
	on_enter = function (self, previous_state)
		return
	end,
	rpc_is_ingame = function (self)
		self.is_ingame = true
	end,
	update = function (self, dt)
		local server = self.server

		if self.is_ingame and server.game_network_manager then
			local peer_id = self.peer_id

			if not server.peers_added_to_gamesession[peer_id] then
				server.game_network_manager:set_peer_synchronizing(peer_id)

				local game_session = server.game_session
				local all_synced = server.profile_synchronizer:all_synced()

				if game_session and all_synced then
					GameSession.add_peer(game_session, peer_id)

					server.peers_added_to_gamesession[peer_id] = true
				else
					return
				end
			end

			self:change_state(PeerStates.WaitingForGameObjectSync)
		end
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
				if PLATFORM == "xb1" then
					self.server.network_transmit:send_rpc("rpc_game_started", self.peer_id, Managers.account:round_id() or "")
				else
					self.server.network_transmit:send_rpc("rpc_game_started", self.peer_id, "")
				end

				self.game_started = true
			end

			return PeerStates.WaitingForPlayers
		end
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

			if server:are_all_peers_ready() then
				return PeerStates.SpawningPlayer
			end
		elseif cutscene_system:has_intro_cutscene_finished_playing() then
			return PeerStates.SpawningPlayer
		end
	end,
	on_exit = function (self, new_state)
		return
	end
}
PeerStates.SpawningPlayer = {
	on_enter = function (self, previous_state)
		return
	end,
	update = function (self, dt)
		local server = self.server

		if server.profile_synchronizer:all_synced() then
			local peer_id = self.peer_id

			for i = 1, self.num_players, 1 do
				self.server.game_network_manager:spawn_peer_player(peer_id, i, self.clan_tag)
			end

			return PeerStates.InGame
		end
	end,
	on_exit = function (self, new_state)
		return
	end
}
PeerStates.InGame = {
	on_enter = function (self, previous_state)
		return
	end,
	respawn_player = function (self)
		assert(self.despawned_player, "[PeerStates] - Trying to respawn player without having despawned the player.")

		self.respawn_player = true
	end,
	despawned_player = function (self)
		self.despawned_player = true
	end,
	update = function (self, dt)
		if self.respawn_player then
			self.respawn_player = nil

			return PeerStates.SpawningPlayer
		elseif self.despawned_player then
			local profile_index = self.server.profile_synchronizer:profile_by_peer(self.peer_id, 1)

			if profile_index ~= self.my_profile_index then
				self.my_profile_index = profile_index
				self.despawned_player = nil

				return PeerStates.LoadingProfilePackages
			end
		end
	end,
	on_exit = function (self, new_state)
		self.despawned_player = nil
		self.respawn_player = nil
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
			game_network_manager:remove_peer(peer_id)
		end

		server.peers_completed_game_object_sync[peer_id] = nil
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
		local old_index = profile_synchronizer:profile_by_peer(peer_id, 1)

		if old_index then
			profile_synchronizer:set_profile_peer_id(old_index, nil)
		end

		profile_synchronizer:peer_left_session(peer_id)
		server.connection_handler:disconnect_peers(peer_id)
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
