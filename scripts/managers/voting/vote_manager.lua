require("scripts/managers/voting/vote_templates")

VoteManager = class(VoteManager)
local VOTING_RPCS = {
	"rpc_server_request_start_vote_peer_id",
	"rpc_server_request_start_vote_lookup",
	"rpc_client_start_vote_peer_id",
	"rpc_client_start_vote_lookup",
	"rpc_client_add_vote",
	"rpc_vote",
	"rpc_client_complete_vote",
	"rpc_client_vote_kick_enabled"
}

VoteManager.init = function (self, ingame_context)
	self.is_server = ingame_context.is_server
	self.network_event_delegate = ingame_context.network_event_delegate
	self.level_transition_handler = ingame_context.level_transition_handler
	self.input_manager = ingame_context.input_manager
	self.ingame_context = ingame_context

	self.network_event_delegate:register(self, unpack(VOTING_RPCS))

	self._vote_kick_enabled = true
end

VoteManager.request_vote = function (self, name, vote_data, voter_peer_id)
	local vote_template = VoteTemplates[name]

	assert(vote_template, "Could not find voting template by name: %q", name)

	local vote_type_id = NetworkLookup.voting_types[name]

	fassert(voter_peer_id ~= nil, "No voter peer id sent")

	vote_data = vote_data or {}
	vote_data.voter_peer_id = voter_peer_id

	if self.is_server then
		local start_new_voting = self:can_start_vote(name, vote_data)

		if start_new_voting then
			self:server_start_vote(name, nil, vote_data)

			local sync_data = vote_template.pack_sync_data(vote_data)
			local server_start_vote_rpc = vote_template.server_start_vote_rpc

			Managers.state.network.network_transmit:send_rpc_clients(server_start_vote_rpc, vote_type_id, sync_data)

			if vote_template.initial_vote_func then
				local votes = vote_template.initial_vote_func(vote_data)

				for peer_id, vote in pairs(votes) do
					self:rpc_vote(peer_id, vote)
				end
			end

			return true
		end
	else
		local client_start_vote_rpc = vote_template.client_start_vote_rpc
		local sync_data = vote_template.pack_sync_data(vote_data)

		Managers.state.network.network_transmit:send_rpc_server(client_start_vote_rpc, vote_type_id, sync_data)
	end
end

VoteManager.can_start_vote = function (self, name, vote_data)
	local vote_template = VoteTemplates[name]
	local human_players = Managers.player:human_players()
	local num_players = 0

	for peer_id, player in pairs(human_players) do
		num_players = num_players + 1
	end

	local min_required_voters = vote_template.min_required_voters or 1
	local enough_players = num_players >= min_required_voters

	if not enough_players then
		return false
	end

	local active_voting = self.active_voting

	if active_voting and vote_template.priority <= active_voting.template.priority then
		return false
	end

	return true
end

VoteManager.vote = function (self, vote)
	local valid_vote = vote ~= nil

	assert(valid_vote, "Incorrect vote: %s. Casteted by: %s", vote, Network.peer_id())

	local is_server = self.is_server
	local network_manager = Managers.state.network

	if is_server then
		self:rpc_vote(Network.peer_id(), vote)
	elseif network_manager:in_game_session() then
		network_manager.network_transmit:send_rpc_server("rpc_vote", vote)
	end
end

VoteManager.number_of_votes = function (self)
	local active_voting = self.active_voting

	if active_voting then
		local number_of_votes = 0
		local number_of_confirm_votes = 0
		local current_vote_results = {}
		local vote_options = active_voting.template.vote_options

		for index, option_data in ipairs(vote_options) do
			current_vote_results[index] = 0
		end

		for peer_id, vote in pairs(active_voting.votes) do
			number_of_votes = number_of_votes + 1
			current_vote_results[vote] = current_vote_results[vote] + 1
		end

		return number_of_votes, current_vote_results
	end

	return 0, nil
end

VoteManager.has_voted = function (self, peer_id)
	local active_voting = self.active_voting

	return active_voting and active_voting.votes[peer_id] ~= nil
end

VoteManager.vote_in_progress = function (self)
	return self.active_voting ~= nil
end

VoteManager.active_vote_template = function (self)
	return self.active_voting.template
end

VoteManager.active_vote_data = function (self)
	return self.active_voting.data
end

VoteManager.previous_vote_info = function (self)
	return self.previous_voting_info
end

VoteManager.is_ingame_vote = function (self)
	return self.active_voting.template.ingame_vote
end

VoteManager.allow_vote_input = function (self, enable)
	self._allow_vote_input = enable
end

VoteManager.vote_time_left = function (self)
	local network_time = Managers.state.network:network_time()
	local active_voting = self.active_voting

	if active_voting and active_voting.end_time then
		return math.max(active_voting.end_time - network_time, 0)
	end

	return nil
end

VoteManager.update = function (self, dt)
	local t = Managers.state.network:network_time()

	if self.is_server then
		self:server_update(dt, t)
	else
		self:client_update(dt, t)
	end

	if self._allow_vote_input then
		local active_voting = self.active_voting

		if active_voting and active_voting.template.ingame_vote and not self:has_voted(Network.peer_id()) then
			local input_manager = self.input_manager
			local gamepad_active = input_manager:is_device_active("gamepad")
			local input_source = input_manager:get_service("ingame_menu")
			local vote_options = active_voting.template.vote_options
			local vote_options_n = #vote_options
			local input_hold_timer = active_voting.input_hold_timer or 0

			for i = 1, vote_options_n, 1 do
				local vote_option = vote_options[i]

				if gamepad_active then
					local input = vote_option.input

					if input_source:get(input) then
						if input ~= active_voting.current_hold_input then
							active_voting.current_hold_input = input
							input_hold_timer = 0
						end

						local input_hold_time = vote_option.input_hold_time

						if input_hold_timer == input_hold_time then
							active_voting.input_hold_timer = nil

							self:vote(vote_option.vote)
						else
							active_voting.input_hold_timer = math.min(input_hold_timer + dt, input_hold_time)
							active_voting.input_hold_progress = active_voting.input_hold_timer / input_hold_time
						end
					elseif input == active_voting.current_hold_input then
						active_voting.current_hold_input = nil
						active_voting.input_hold_timer = nil
						active_voting.input_hold_progress = nil
					end
				elseif input_source:get(vote_option.input) then
					self:vote(vote_option.vote)
				end
			end
		end
	end
end

VoteManager.time_ended = function (self, t)
	local active_voting = self.active_voting

	if active_voting.end_time and active_voting.end_time <= t then
		return true
	end

	return false
end

VoteManager.vote_result = function (self, vote_time_ended)
	local active_voting = self.active_voting
	local template = active_voting.template
	local num_of_votes, current_vote_results = self:number_of_votes()
	local number_of_voters = #active_voting.voters
	local votes = active_voting.votes
	local minimum_voter_percent = template.minimum_voter_percent
	local success_percent = template.success_percent or 0.51
	local min_required_voters = template.min_required_voters or 1

	if number_of_voters < min_required_voters then
		return 0
	end

	if vote_time_ended or num_of_votes == number_of_voters then
		for vote_option, vote_option_count in ipairs(current_vote_results) do
			local vote_success_ratio = vote_option_count / num_of_votes

			if success_percent <= vote_success_ratio then
				return vote_option
			end
		end
	end

	local num_of_votes_needed = (minimum_voter_percent and minimum_voter_percent <= num_of_votes / number_of_voters) or false

	if num_of_votes_needed or num_of_votes == number_of_voters then
		return 0
	end

	return nil
end

VoteManager.hot_join_sync = function (self, peer_id)
	if self.active_voting then
		local active_voting = self.active_voting
		local template = active_voting.template
		local name_id = NetworkLookup.voting_types[template.name]
		local sync_data = template.pack_sync_data(active_voting.data)
		local server_start_vote_rpc = template.server_start_vote_rpc

		RPC[server_start_vote_rpc](peer_id, name_id, sync_data)

		local votes = active_voting.votes

		for voter_peer_id, vote_option in pairs(votes) do
			RPC.rpc_client_add_vote(peer_id, voter_peer_id, vote_option)
		end
	end

	RPC.rpc_client_vote_kick_enabled(peer_id, self._vote_kick_enabled)
end

VoteManager.destroy = function (self)
	self.network_event_delegate:unregister(self)

	self.network_event_delegate = nil
end

VoteManager.server_start_vote = function (self, name, ignore_peer_list, data)
	local vote_template = VoteTemplates[name]
	local network_time = Managers.state.network:network_time()
	self.active_voting = {
		template = vote_template,
		end_time = (vote_template.duration and network_time + vote_template.duration) or nil,
		votes = {},
		voters = self:get_voter_start_list(ignore_peer_list),
		data = data
	}
end

VoteManager.get_voter_start_list = function (self, ignore_list)
	local ignore_peers = {}

	if ignore_list then
		for i = 1, #ignore_list, 1 do
			ignore_peers[ignore_list[i]] = true
		end
	end

	local voters = {}
	local human_players = Managers.player:human_players()
	local num_of_human_players = 0

	for peer_id, player in pairs(human_players) do
		if not ignore_peers[peer_id] then
			voters[#voters + 1] = peer_id
		end
	end

	return voters
end

VoteManager.update_voter_list_by_active_peers = function (self, vote_list)
	local active_peers = {}
	local human_players = Managers.player:human_players()
	local num_of_human_players = 0

	for peer_id, player in pairs(human_players) do
		active_peers[peer_id] = true
	end

	local voter_peer_list = {}

	for i = 1, #vote_list, 1 do
		local voter_peer_id = vote_list[i]

		if active_peers[voter_peer_id] then
			voter_peer_list[#voter_peer_list + 1] = voter_peer_id
		end
	end

	return voter_peer_list
end

VoteManager.rpc_vote = function (self, peer_id, vote_cast)
	local active_voting = self.active_voting

	if active_voting then
		local current_votes = active_voting.votes
		local current_voters = active_voting.voters

		if self:has_voted(peer_id) then
			return
		end

		Managers.state.network.network_transmit:send_rpc_clients("rpc_client_add_vote", peer_id, vote_cast)
		self:server_add_vote(peer_id, vote_cast)
	end
end

VoteManager.server_add_vote = function (self, peer_id, vote_option)
	self.active_voting.votes[peer_id] = vote_option
end

VoteManager.server_update = function (self, dt, t)
	local active_voting = self.active_voting

	if not active_voting then
		return
	end

	active_voting.voters = self:update_voter_list_by_active_peers(active_voting.voters)
	local vote_time_ended = self:time_ended(t)
	local vote_result = self:vote_result(vote_time_ended)

	if vote_result ~= nil then
		local result_data = active_voting.template.on_complete(vote_result, self.ingame_context, active_voting.data)

		Managers.state.network.network_transmit:send_rpc_all("rpc_client_complete_vote", vote_result)
	elseif vote_time_ended then
		local result_data = active_voting.template.on_complete(0, self.ingame_context, active_voting.data)

		Managers.state.network.network_transmit:send_rpc_all("rpc_client_complete_vote", 0)
	end
end

VoteManager.rpc_server_request_start_vote_base = function (self, peer_id, vote_type_id, sync_data)
	local vote_type_name = NetworkLookup.voting_types[vote_type_id]
	local vote_template = VoteTemplates[vote_type_name]
	local vote_data = vote_template.extract_sync_data(sync_data)

	self:request_vote(vote_type_name, vote_data, peer_id)
end

VoteManager.rpc_server_request_start_vote_peer_id = function (self, peer_id, vote_type_id, sync_data)
	self:rpc_server_request_start_vote_base(peer_id, vote_type_id, sync_data)
end

VoteManager.rpc_server_request_start_vote_lookup = function (self, peer_id, vote_type_id, sync_data)
	self:rpc_server_request_start_vote_base(peer_id, vote_type_id, sync_data)
end

VoteManager.start_vote_base = function (self, peer_id, vote_type_id, sync_data)
	local vote_type_name = NetworkLookup.voting_types[vote_type_id]
	local vote_template = VoteTemplates[vote_type_name]

	assert(vote_template, "Could not find voting template by name: %q", vote_type_name)

	local network_time = Managers.state.network:network_time()
	local data = vote_template.extract_sync_data(sync_data)
	self.active_voting = {
		template = vote_template,
		end_time = (vote_template.duration and network_time + vote_template.duration) or nil,
		votes = {},
		data = data
	}
end

VoteManager.rpc_client_start_vote_peer_id = function (self, peer_id, vote_type_id, sync_data)
	self:start_vote_base(peer_id, vote_type_id, sync_data)
end

VoteManager.rpc_client_start_vote_lookup = function (self, peer_id, vote_type_id, sync_data)
	self:start_vote_base(peer_id, vote_type_id, sync_data)
end

VoteManager.rpc_client_add_vote = function (self, sender_id, peer_id, vote_option)
	local active_voting = self.active_voting

	if active_voting then
		active_voting.votes[peer_id] = vote_option
	end
end

VoteManager.rpc_client_complete_vote = function (self, sender_id, vote_result)
	if self.active_voting then
		local number_of_votes, vote_results = self:number_of_votes()
		self.previous_voting_info = {
			text = self.active_voting.text,
			number_of_votes = number_of_votes,
			vote_results = vote_results,
			vote_result = vote_result,
			votes = self.active_voting.votes
		}
	end

	self.active_voting = nil
end

VoteManager.rpc_client_vote_kick_enabled = function (self, sender_id, is_enabled)
	self._vote_kick_enabled = is_enabled
end

VoteManager.client_update = function (self, dt, t)
	return
end

VoteManager.set_vote_kick_enabled = function (self, is_enabled)
	if self.is_server then
		self._vote_kick_enabled = is_enabled

		Managers.state.network.network_transmit:send_rpc_clients("rpc_client_vote_kick_enabled", is_enabled)
	end
end

VoteManager.vote_kick_enabled = function (self)
	if self._vote_kick_enabled then
		return Managers.player:num_human_players() > 2
	end

	return false
end

return
