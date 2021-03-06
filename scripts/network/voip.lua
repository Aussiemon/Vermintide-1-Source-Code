local function voip_info_print(...)
	if script_data.debug_voip then
		printf(...)
	end
end

local function voip_warning_print(...)
	Application.warning(...)
end

Voip = class(Voip)
local has_steam = rawget(_G, "Steam") and rawget(_G, "Steam").connected() and not Development.parameter("use_lan_backend")
local disable_voip = Development.parameter("disable_voip")

if has_steam and not disable_voip then
	Voip.init = function (self, params)
		self.connection_handler = params.connection_handler

		voip_info_print("[VOIP] Initializing Steam Voip")

		local world_name = "voip_world"
		local shading_callback, layer = nil
		local world = Managers.world:create_world(world_name, GameSettingsDevelopment.default_environment, shading_callback, layer, Application.DISABLE_PHYSICS, Application.DISABLE_APEX_CLOTH, Application.DISABLE_RENDERING)
		self.world = world
		self.timpani_world = World.timpani_world(world)

		Timpani.set_master("timpani/voip")
		TimpaniWorld.set_listener_mode(self.timpani_world, 0, TimpaniWorld.LISTENER_2D)
		Timpani.load_bank("timpani/sounds")

		local voip_bus_volume = Application.user_setting("voip_bus_volume")

		if voip_bus_volume ~= nil then
			Timpani.set_bus_volume("voip", voip_bus_volume)
		end

		local member_list = {}
		self.member_list = member_list
		local added_members = {}
		self.added_members = added_members
		self.muted_peers = {}
		local my_peer_id = params.my_peer_id
		self.peer_id = my_peer_id
		self.push_to_talk = Application.user_setting("voip_push_to_talk")
		self.push_to_talk_active = false
		self.enabled = Application.user_setting("voip_is_enabled")
		local is_server = params.is_server

		if is_server then
			voip_info_print("[VOIP] Is server. Creating room / joining my own room.")

			self.is_server = is_server
			self.room_id = SteamVoip.create_room()

			if self.enabled then
				self.voip_client = SteamVoip.join_room(my_peer_id, self.room_id)

				SteamVoipRoom.add_member(self.room_id, my_peer_id)
			end

			self.room_host = my_peer_id
		end

		self.room_member_removed = function (room_id, peer_id)
			if room_id == self.room_id then
				if self.member_list[peer_id] then
					self.member_list[peer_id] = nil

					voip_info_print("[VOIP] Removed member: %q", peer_id)
				else
					voip_info_print("[VOIP] Trying to remove member that doesn't exist in room: %q", peer_id)
				end
			else
				voip_info_print("[VOIP] Trying to remove member from bad room: %q, current room id: %q", room_id, self.room_id)
			end
		end

		self.room_member_added = function (room_id, peer_id)
			voip_info_print("[VOIP] Peer %s joined room %s (my room id %q)", peer_id, tostring(room_id), tostring(self.room_id))

			if room_id == self.room_id then
				member_list[peer_id] = true
			end

			added_members[peer_id] = true

			return self.timpani_world, "temp_voip_event"
		end
	end

	Voip.set_input_manager = function (self, input_manager)
		return
	end

	Voip.register_rpcs = function (self, network_event_delegate, network_transmit)
		self.network_transmit = network_transmit
		self.network_event_delegate = network_event_delegate

		network_event_delegate:register(self, "rpc_voip_room_to_join", "rpc_voip_room_request", "rpc_notify_connected")
	end

	Voip.unregister_rpcs = function (self)
		self.network_event_delegate:unregister(self)

		self.network_event_delegate = nil
		self.network_transmit = nil
	end

	Voip.rpc_notify_connected = function (self, sender)
		if self.enabled and not self.is_server then
			self.requesting_room = true

			self.network_transmit:send_rpc_server("rpc_voip_room_request", true)
		end
	end

	Voip.rpc_voip_room_request = function (self, sender, enter)
		local room_id = self.room_id

		if not self.is_server then
			voip_warning_print("[VOIP] Got request from %s to %s but is not server", sender, (enter and "enter") or "leave")

			return
		end

		local room_members = SteamVoipRoom.members(room_id)
		local member_is_in_room = table.find(room_members, sender)

		if enter and not member_is_in_room then
			self:add_voip_member(sender)
		elseif not enter and member_is_in_room then
			self:remove_member(sender)
		else
			voip_warning_print("[VOIP] Got request from %s to %s room %s but member_is_in_room was %s", sender, (enter and "enter") or "leave", self.room_id, member_is_in_room)
		end
	end

	Voip.rpc_voip_room_to_join = function (self, sender, room_id)
		self.requesting_room = false

		if self.room_id then
			voip_warning_print("[VOIP] Received rpc 'rpc_voip_room_to_join' from host %s but we're already in a room.", sender)
		else
			voip_info_print("[VOIP] Joining room %s (host %q) as client.", room_id, sender)

			self.room_id = room_id
			self.room_host = sender
			local voip_client = SteamVoip.join_room(sender, room_id)
			self.voip_client = voip_client
		end
	end

	Voip.destroy = function (self)
		voip_info_print("[VOIP] Destroying VOIP.")

		if self.room_id then
			if self.voip_client then
				self:leave_voip_room()
			end

			if self.is_server then
				SteamVoip.destroy_room(self.room_id)
			end

			self.room_id = nil
		end

		Managers.world:destroy_world(self.world)

		self.room_member_removed = nil
		self.room_member_added = nil
		self.member_list = nil
	end

	Voip.update = function (self, dt)
		SteamVoip.update(self)

		if self.voip_client then
			if SteamVoipClient.broken_host(self.voip_client) then
				voip_warning_print("[STEAM VOIP]: Connection to host %q broken. Leaving room.", tostring(self.room_host))
				self:leave_voip_room()
			else
				for peer_id, _ in pairs(self.added_members) do
					if not self.muted_peers[peer_id] then
						self:unmute_member(peer_id)
					end

					local mute_out = self.push_to_talk and not self.push_to_talk_active

					if mute_out then
						voip_info_print("[VOIP] Muting voip out for %q due to push_to_talk", peer_id)
						SteamVoipClient.select_out(self.voip_client, false, peer_id)
					end

					self.added_members[peer_id] = nil
				end
			end

			if self.push_to_talk then
				local input_service = Managers.input:get_service("Player")
				local push_to_talk_active = input_service:get("voip_push_to_talk")

				if push_to_talk_active and not self.push_to_talk_active then
					self.push_to_talk_active = true

					for index, member_peer_id in pairs(SteamVoipClient.members(self.voip_client)) do
						SteamVoipClient.select_out(self.voip_client, true, member_peer_id)
					end
				elseif not push_to_talk_active and self.push_to_talk_active then
					self.push_to_talk_active = false

					for index, member_peer_id in pairs(SteamVoipClient.members(self.voip_client)) do
						SteamVoipClient.select_out(self.voip_client, false, member_peer_id)
					end
				end
			end
		end

		local room_id = self.room_id

		if room_id and self.is_server then
			local broken_members = SteamVoipRoom.broken_members(room_id)

			if broken_members then
				for _, peer_id in pairs(broken_members) do
					voip_info_print("[VOIP] Removing broken voip member: %q", tostring(peer_id))
					SteamVoipRoom.remove_member(room_id, peer_id)

					if self.voip_client then
						SteamVoipClient.select_out(self.voip_client, false, peer_id)
						SteamVoipClient.select_in(self.voip_client, false, peer_id)
					end
				end
			end

			for peer_index, peer_id in pairs(SteamVoipRoom.members(self.room_id)) do
				if peer_id ~= self.peer_id and self.connection_handler.current_connections[peer_id] == nil then
					voip_info_print("[VOIP] Removing voip member due to not having a connection to it: %q", tostring(peer_id))
					SteamVoipRoom.remove_member(room_id, peer_id)

					if self.voip_client then
						SteamVoipClient.select_out(self.voip_client, false, peer_id)
						SteamVoipClient.select_in(self.voip_client, false, peer_id)
					end
				end
			end
		end

		if script_data.debug_voip then
			if self.voip_client then
				Debug.text("VoIP")
				Debug.text("VoIP - PushToTalk %s (%s)", (self.push_to_talk and "on") or "off", (self.push_to_talk_active and "pushing") or "-")
				Debug.text("VoIP - Client members")

				for peer_index, peer_id in pairs(SteamVoipClient.members(self.voip_client)) do
					local speaking = (SteamVoip.is_peer_speaking and SteamVoip.is_peer_speaking(peer_id)) or false

					Debug.text("%s [%s] %s", tostring(peer_index), tostring(peer_id), (speaking and "speaking") or "")
				end

				if self.is_server and self.room_id then
					Debug.text("VoIP - Room members %s", tostring(self.room_id))

					for peer_index, peer_id in pairs(SteamVoipRoom.members(self.room_id)) do
						local speaking = (SteamVoip.is_peer_speaking and SteamVoip.is_peer_speaking(peer_id)) or false

						Debug.text("%s [%s] %s", tostring(peer_index), tostring(peer_id), (speaking and "speaking") or "")
					end
				end
			else
				Debug.text("VoIP - disabled")
			end
		end
	end

	Voip.add_voip_member = function (self, member)
		voip_info_print("[VOIP] Adding voip member: %q", tostring(member))

		local voip_room = self.room_id

		assert(voip_room, "Trying to add a member to a none existing voip room.")
		SteamVoipRoom.add_member(voip_room, member)
		self.network_transmit:send_rpc("rpc_voip_room_to_join", member, tostring(self.room_id))
	end

	Voip.remove_member = function (self, member)
		voip_info_print("[VOIP] Removing voip member: %q", tostring(member))

		local voip_room = self.room_id

		assert(voip_room, "Trying to remove a member from a none existing voip room.")
		SteamVoipRoom.remove_member(voip_room, member)
	end

	Voip.mute_member = function (self, member)
		if self.voip_client == nil then
			return
		end

		self.muted_peers[member] = true

		if self.member_list[member] == nil then
			voip_info_print("[VOIP] Muting voip member: %q even though it's not in the room (yet).", tostring(member))

			return
		end

		voip_info_print("[VOIP] Muting voip member: %q", tostring(member))
		SteamVoipClient.select_out(self.voip_client, false, member)
		SteamVoipClient.select_in(self.voip_client, false, member)
	end

	Voip.unmute_member = function (self, member)
		if self.voip_client == nil then
			return
		end

		self.muted_peers[member] = nil

		if self.member_list[member] == nil then
			voip_info_print("[VOIP] Unmuting voip member: %q even though it's not in the room (yet).", tostring(member))

			return
		end

		voip_info_print("[VOIP] Unmuting voip member: %q", tostring(member))
		SteamVoipClient.select_out(self.voip_client, true, member)
		SteamVoipClient.select_in(self.voip_client, true, member)
	end

	Voip.peer_muted = function (self, peer_id)
		return self.muted_peers[peer_id]
	end

	Voip.leave_voip_room = function (self)
		voip_info_print("[VOIP] Leaving VOIP room.")
		assert(self.room_id, "Trying to leave when we're not in any room.")
		assert(self.voip_client, "Trying to leave a voip room when we've never joined or created one.")
		SteamVoip.leave_room(self.voip_client)

		self.room_host = nil
		self.voip_client = nil

		if not self.is_server then
			self.room_id = nil
		end
	end

	Voip.set_volume = function (self, voip_bus_volume)
		assert(voip_bus_volume >= 0 and voip_bus_volume <= 100)

		voip_bus_volume = voip_bus_volume * 0.5 - 50

		Timpani.set_bus_volume("voip", voip_bus_volume)
		Timpani.set_bus_volume("Master Bus", voip_bus_volume)
	end

	Voip.set_enabled = function (self, enabled)
		self.enabled = enabled

		if self.is_server then
			if enabled and not self.voip_client and self.room_host then
				voip_info_print("[VOIP] Enabling")

				self.voip_client = SteamVoip.join_room(self.room_host, self.room_id)

				SteamVoipRoom.add_member(self.room_id, self.room_host)
			elseif not enabled and self.voip_client and self.room_host then
				voip_info_print("[VOIP] Disabling")
				SteamVoipRoom.remove_member(self.room_id, self.room_host)
				SteamVoip.leave_room(self.voip_client)

				self.voip_client = nil
			end
		elseif enabled and not self.voip_client then
			voip_info_print("[VOIP] Enabling, requesting to enter room")
			self.network_transmit:send_rpc_server("rpc_voip_room_request", true)
		elseif not enabled and self.voip_client then
			voip_info_print("[VOIP] Enabling, requesting to leave room")
			self:leave_voip_room()
			self.network_transmit:send_rpc_server("rpc_voip_room_request", false)
		end
	end

	Voip.set_push_to_talk = function (self, push_to_talk)
		self.push_to_talk = push_to_talk

		if self.voip_client then
			for index, member_peer_id in pairs(SteamVoipClient.members(self.voip_client)) do
				SteamVoipClient.select_out(self.voip_client, not push_to_talk, member_peer_id)
			end
		end
	end

	Voip.is_talking = function (self, peer_id)
		return false
	end
else
	Voip.init = function (self)
		return
	end

	Voip.set_input_manager = function (self, input_manager)
		return
	end

	Voip.destroy = function (self)
		return
	end

	Voip.destroy_voip_system = function (self)
		return
	end

	Voip.register_rpcs = function (self)
		return
	end

	Voip.unregister_rpcs = function (self)
		return
	end

	Voip.add_voip_member = function (self)
		return
	end

	Voip.mute_member = function (self)
		return
	end

	Voip.unmute_member = function (self)
		return
	end

	Voip.update = function (self)
		return
	end

	Voip.peer_muted = function (self)
		return
	end

	Voip.set_volume = function (self)
		return
	end

	Voip.set_enabled = function (self)
		return
	end

	Voip.set_push_to_talk = function (self)
		return
	end

	Voip.is_talking = function (self)
		return
	end
end

return
