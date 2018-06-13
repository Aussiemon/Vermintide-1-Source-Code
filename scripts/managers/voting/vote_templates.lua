VoteTemplates = {
	retry_level = {
		priority = 100,
		client_start_vote_rpc = "rpc_server_request_start_vote_peer_id",
		text = "vote_retry_level_title",
		minimum_voter_percent = 1,
		server_start_vote_rpc = "rpc_client_start_vote_peer_id",
		duration = 20,
		vote_options = {
			{
				text = "vote_retry_level_yes",
				vote = 1
			},
			{
				text = "vote_retry_level_no",
				vote = 2
			}
		},
		on_complete = function (vote_result, ingame_context)
			local level_transition_handler = ingame_context.level_transition_handler

			if level_transition_handler:transition_in_progress() then
				return
			end

			if vote_result == 1 then
				level_transition_handler:reload_level()
			else
				level_transition_handler:set_next_level("inn_level")
				level_transition_handler:level_completed()
			end
		end,
		pack_sync_data = function (data)
			local sync_data = {}

			return sync_data
		end,
		extract_sync_data = function (sync_data)
			local data = {}

			return data
		end
	},
	continue_level = {
		priority = 100,
		client_start_vote_rpc = "rpc_server_request_start_vote_peer_id",
		text = "vote_retry_level_title",
		minimum_voter_percent = 1,
		server_start_vote_rpc = "rpc_client_start_vote_peer_id",
		duration = 20,
		vote_options = {
			{
				text = "vote_retry_level_continue",
				vote = 1
			},
			{
				text = "vote_retry_level_restart",
				vote = 2
			},
			{
				text = "vote_retry_level_cancel",
				vote = 3
			}
		},
		on_complete = function (vote_result, ingame_context)
			local level_transition_handler = ingame_context.level_transition_handler

			if vote_result == 1 then
				local checkpoint_data = Managers.state.spawn:checkpoint_data()

				level_transition_handler:reload_level(checkpoint_data)
			elseif vote_result == 2 then
				level_transition_handler:reload_level()
			else
				Managers.state.event:trigger("checkpoint_vote_cancelled")
			end
		end,
		pack_sync_data = function (data)
			local sync_data = {}

			return sync_data
		end,
		extract_sync_data = function (sync_data)
			local data = {}

			return data
		end
	},
	kick_player = {
		client_start_vote_rpc = "rpc_server_request_start_vote_peer_id",
		priority = 10,
		ingame_vote = true,
		min_required_voters = 3,
		text = "input_description_vote_kick_player",
		minimum_voter_percent = 1,
		success_percent = 0.51,
		server_start_vote_rpc = "rpc_client_start_vote_peer_id",
		duration = 30,
		vote_options = {
			{
				text = "vote_kick_player_yes",
				vote = 1,
				input_hold_time = 1,
				gamepad_input = "ingame_vote_yes",
				input = "ingame_vote_yes"
			},
			{
				text = "vote_kick_player_no",
				input_hold_time = 1,
				vote = 2,
				input = "ingame_vote_no"
			}
		},
		on_complete = function (vote_result, ingame_context, data)
			if vote_result == 1 then
				local network_server = ingame_context.network_server

				network_server:kick_peer(data.kick_peer_id)
			end
		end,
		pack_sync_data = function (data)
			local sync_data = {
				data.voter_peer_id,
				data.kick_peer_id
			}

			return sync_data
		end,
		extract_sync_data = function (sync_data)
			local voter_peer_id = sync_data[1]
			local kick_peer_id = sync_data[2]
			local data = {
				voter_peer_id = voter_peer_id,
				kick_peer_id = kick_peer_id
			}

			return data
		end,
		modify_title_text = function (text, data)
			local player = Managers.player:player_from_peer_id(data.kick_peer_id)
			local name = (player and player:name()) or "n/a"

			return sprintf("%s\n%s", text, tostring(name))
		end,
		initial_vote_func = function (data)
			local votes = {
				[data.voter_peer_id] = 1,
				[data.kick_peer_id] = 2
			}

			return votes
		end,
		can_start_vote = function (data)
			local player = Managers.player:player_from_peer_id(data.kick_peer_id)

			if player then
				return true
			end

			return false
		end
	},
	afk_kick = {
		client_start_vote_rpc = "rpc_server_request_start_vote_peer_id",
		priority = 10,
		ingame_vote = true,
		min_required_voters = 2,
		text = "afk_vote_kick_player",
		minimum_voter_percent = 1,
		success_percent = 0.51,
		server_start_vote_rpc = "rpc_client_start_vote_peer_id",
		duration = 30,
		vote_options = {
			{
				text = "vote_kick_player_yes",
				vote = 1,
				input = "ingame_vote_yes"
			},
			{
				text = "vote_kick_player_no",
				vote = 2,
				input = "ingame_vote_no"
			}
		},
		on_complete = function (vote_result, ingame_context, data)
			if vote_result == 1 then
				local network_server = ingame_context.network_server

				network_server:kick_peer(data.kick_peer_id)
			end
		end,
		pack_sync_data = function (data)
			local sync_data = {
				data.voter_peer_id,
				data.kick_peer_id
			}

			return sync_data
		end,
		extract_sync_data = function (sync_data)
			local voter_peer_id = sync_data[1]
			local kick_peer_id = sync_data[2]
			local data = {
				voter_peer_id = voter_peer_id,
				kick_peer_id = kick_peer_id
			}

			return data
		end,
		modify_title_text = function (text, data)
			local player = Managers.player:player_from_peer_id(data.kick_peer_id)
			local name = player:name()

			return sprintf("%s\n%s", text, tostring(name))
		end
	},
	vote_for_level = {
		client_start_vote_rpc = "rpc_server_request_start_vote_lookup",
		priority = 110,
		ingame_vote = false,
		min_required_voters = 1,
		text = "vote_for_next_level",
		minimum_voter_percent = 1,
		success_percent = 0.51,
		server_start_vote_rpc = "rpc_client_start_vote_lookup",
		duration = 180,
		vote_options = {
			{
				text = "",
				vote = 1
			},
			{
				text = "",
				vote = 2
			},
			{
				text = "",
				vote = 3
			}
		},
		on_complete = function (vote_result, ingame_context, data)
			local level_transition_handler = ingame_context.level_transition_handler
			local next_level_key = "inn_level"
			local next_level_difficulty = nil

			if vote_result == 1 then
				next_level_key = data[1]
				next_level_difficulty = data[3]
			elseif vote_result == 2 then
				next_level_key = data[2]
				next_level_difficulty = data[4]
			end

			if next_level_difficulty then
				Managers.state.difficulty:set_difficulty(next_level_difficulty)
			end

			Managers.state.game_mode:start_specific_level(next_level_key, 5)

			return next_level_key
		end,
		pack_sync_data = function (data)
			local sync_data = {
				NetworkLookup.level_keys[data[1]],
				NetworkLookup.level_keys[data[2]],
				NetworkLookup.difficulties[data[3]],
				NetworkLookup.difficulties[data[4]]
			}

			return sync_data
		end,
		extract_sync_data = function (sync_data)
			local data = {
				NetworkLookup.level_keys[sync_data[1]],
				NetworkLookup.level_keys[sync_data[2]],
				NetworkLookup.difficulties[sync_data[3]],
				NetworkLookup.difficulties[sync_data[4]]
			}

			return data
		end
	}
}

for name, template in pairs(VoteTemplates) do
	template.name = name
end

return
