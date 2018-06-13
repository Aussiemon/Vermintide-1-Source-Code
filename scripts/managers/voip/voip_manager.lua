local RPCS = {
	"rpc_request_join_voip_room",
	"rpc_accept_join_voip_room"
}
VOIPManager = class(VOIPManager)

VOIPManager.init = function (self)
	self.room_id = nil
	self.peers = {}
end

VOIPManager.register_network_event_delegate = function (self, network_event_delegate)
	self.network_event_delegate = network_event_delegate

	network_event_delegate:register(self, unpack(RPCS))

	self.peer_id = Network.peer_id()
end

VOIPManager.unregister_network_event_delegate = function (self)
	self.network_event_delegate:unregister(self)

	self.network_event_delegate = nil
end

VOIPManager.create_room = function (self)
	self.room_id = SteamVoip.create_room()

	print(" CREATING VOIP LOBBY ")
	SteamVoipRoom.add_member(self.room_id, self.peer_id)

	self.client = SteamVoip.join_room(self.peer_id, self.room_id)
	self.is_server = true
end

VOIPManager.join_room = function (self)
	local network_manager = Managers.state.network
	local network_transmit = network_manager.network_transmit

	network_transmit:send_rpc_server("rpc_request_join_voip_room")
end

VOIPManager.update = function (self, dt, t)
	SteamVoip.update(self)

	if self.is_server then
		local room_id = self.room_id
		local broken_members = SteamVoipRoom:broken_members(room_id)

		if broken_members then
			for _, peer_id in pairs(broken_members) do
				SteamVoipRoom:remove_member(room_id, peer_id)
			end
		end
	end
end

VOIPManager.room_member_added = function (self, room_id, peer_id)
	local timpani_world = nil
	local dummy_sound_event = ""

	return timpani_world, dummy_sound_event
end

VOIPManager.room_member_removed = function (self, room_id, peer_id)
	return
end

VOIPManager.mute_peer = function (self, peer_id)
	local voip_client = self.client

	SteamVoipClient:select_in(voip_client, false, peer_id)
	SteamVoipClient:select_out(voip_client, false, peer_id)
end

VOIPManager.mute_all = function (self)
	local voip_client = self.client

	SteamVoipClient:select_in(voip_client, false)
	SteamVoipClient:select_out(voip_client, false)
end

VOIPManager.unmute_peer = function (self, peer_id)
	local voip_client = self.client

	SteamVoipClient:select_in(voip_client, true, peer_id)
	SteamVoipClient:select_out(voip_client, true, peer_id)
end

VOIPManager.unmute_all = function (self)
	local voip_client = self.client

	SteamVoipClient:select_in(voip_client, true)
	SteamVoipClient:select_out(voip_client, true)
end

VOIPManager.destroy = function (self)
	if self.is_server then
		SteamVoip.destroy_room(self.room_id)
	end
end

VOIPManager.rpc_request_join_voip_room = function (self, sender)
	fassert(self.is_server, "Requesting to join a clients room, clients cant have rooms")
	SteamVoipRoom.add_member(self.room_id, sender)
	RPC.rpc_accept_join_voip_room(sender, self.room_id)
end

VOIPManager.rpc_accept_join_voip_room = function (self, sender, room_id)
	self.room_id = room_id
	self.client = SteamVoip.join_room(self.peer_id, room_id)
end

return
