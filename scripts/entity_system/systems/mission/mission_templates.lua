MissionTemplates = {
	collect = {
		init = function (mission_data, unit)
			assert(0 < mission_data.collect_amount, "Collect mission with 0 needed collects")

			local collect_amount = mission_data.collect_amount
			local mission_text = Localize(mission_data.text)
			local evaluate_at_level_end = mission_data.evaluate_at_level_end
			local data = {
				info_slate_type = "mission_objective",
				manual_update = true,
				current_amount = 0,
				update_sound = true,
				get_current_amount = function (self)
					return Vault.withdraw_single_ex(self.mission_text, self.current_amount)
				end,
				set_current_amount = function (self, value)
					Vault.deposit_single(self.mission_text, value)

					self.current_amount = value

					return 
				end,
				increase_current_amount = function (self, amount)
					local ret = Vault.single_add_ex(self.mission_text, amount, self.current_amount)
					self.current_amount = ret

					return ret
				end,
				collect_amount = collect_amount,
				mission_text = mission_text,
				unit = unit,
				mission_data = mission_data,
				evaluate_at_level_end = evaluate_at_level_end,
				evaluation_type = mission_data.evaluation_type or "percent",
				experience = mission_data.experience,
				bonus_dice = mission_data.bonus_dice,
				experience_per_percent = mission_data.experience_per_percent,
				dice_per_percent = mission_data.dice_per_percent,
				tokens_per_percent = mission_data.tokens_per_percent,
				experience_per_amount = mission_data.experience_per_amount,
				dice_per_amount = mission_data.dice_per_amount,
				tokens_per_amount = mission_data.tokens_per_amount,
				dice_type = mission_data.dice_type,
				token_type = mission_data.token_type
			}

			Vault.deposit_single(data.mission_text, data.current_amount)

			return data
		end,
		update = function (data, positive, unique_id, peer_id, dt, network_time)
			local collect_amount = data.collect_amount
			local evaluate_at_level_end = data.evaluate_at_level_end
			local current_amount = data.increase_current_amount(data, (positive and 1) or -1)

			return not evaluate_at_level_end and current_amount == collect_amount
		end,
		update_text = function (data)
			local collect_amount = data.collect_amount
			local current_amount = data.get_current_amount(data)
			local text = string.format("%s/%s\n%s", tostring(current_amount), tostring(collect_amount), data.mission_text)
			local center_text = string.format("%s/%s %s", tostring(current_amount), tostring(collect_amount), data.mission_text)
			data.text = text
			data.center_text = center_text

			return 
		end,
		evaluate_mission = function (data, dt)
			return data.get_current_amount(data) == data.collect_amount, data.get_current_amount(data) / data.collect_amount
		end,
		create_sync_data = function (data)
			local sync_data = {
				data.get_current_amount(data)
			}

			return sync_data
		end,
		sync = function (data, sync_data)
			data.set_current_amount(data, sync_data[1])

			return 
		end
	},
	defend = {
		init = function (mission_data, unit)
			assert(0 < mission_data.defend_amount, "Defend mission with 0 needed defends")

			local defend_amount = mission_data.defend_amount
			local mission_text = Localize(mission_data.text)
			local data = {
				info_slate_type = "mission_objective",
				update_sound = true,
				manual_update = true,
				flow_update = true,
				defend_amount = defend_amount,
				current_amount = defend_amount,
				mission_text = mission_text,
				unit = unit,
				mission_data = mission_data
			}

			return data
		end,
		update = function (data, positive, unique_id, peer_id, dt, network_time)
			local current_amount = data.current_amount - 1
			data.current_amount = current_amount

			return current_amount == 0
		end,
		update_text = function (data)
			local defend_amount = data.defend_amount
			local current_amount = data.current_amount
			local text = data.mission_text
			data.text = text

			return 
		end,
		evaluate_mission = function (data, dt)
			return data.current_amount == data.defend_amount, data.current_amount / data.defend_amount
		end,
		create_sync_data = function (data)
			local sync_data = {
				data.current_amount
			}

			return sync_data
		end,
		sync = function (data, sync_data)
			local current_amount = sync_data[1]
			data.current_amount = current_amount

			return 
		end
	},
	simple = {
		init = function (mission_data, unit)
			local mission_text = Localize(mission_data.text)
			local text = string.format("%s", mission_text)
			local data = {
				info_slate_type = "mission_objective",
				update_sound = true,
				manual_update = true,
				done = false,
				flow_update = true,
				mission_text = mission_text,
				unit = unit,
				mission_data = mission_data,
				text = text
			}

			return data
		end,
		update = function (data, positive, unique_id, peer_id, dt, network_time)
			data.done = true

			return true
		end,
		update_text = function (data)
			return 
		end,
		evaluate_mission = function (data, dt)
			return data.done, (data.done and 1) or 0
		end,
		create_sync_data = function (data)
			local sync_data = {}

			return sync_data
		end,
		sync = function (data, sync_data)
			return 
		end
	},
	timed = {
		init = function (mission_data, unit)
			local duration = mission_data.duration
			local mission_text = Localize(mission_data.text)
			local network_time = Managers.state.network:network_time()
			local end_time = math.floor(network_time + duration)
			local time_left = math.max(end_time - network_time, 0)
			local data = {
				info_slate_type = "mission_objective",
				end_time = end_time,
				time_left = time_left,
				mission_text = mission_text,
				unit = unit,
				mission_data = mission_data
			}

			return data
		end,
		update = function (data, positive, unique_id, peer_id, dt, network_time)
			local end_time = data.end_time
			data.time_left = math.max(end_time - network_time, 0)

			return end_time <= network_time
		end,
		update_text = function (data)
			local time = math.ceil(data.time_left)
			local minutes = math.floor(time / 60)
			local seconds = time % 60
			local sminutes = (10 <= minutes and tostring(minutes)) or string.format("0%s", tostring(minutes))
			local sseconds = (10 <= seconds and tostring(seconds)) or string.format("0%s", tostring(seconds))
			local text = string.format("%s:%s\n%s", sminutes, sseconds, data.mission_text)
			data.text = text

			return 
		end,
		evaluate_mission = function (data, dt)
			return 0 < data.time_left, 0
		end,
		create_sync_data = function (data)
			local sync_data = {
				data.end_time
			}

			return sync_data
		end,
		sync = function (data, sync_data)
			local end_time = sync_data[1]
			data.end_time = end_time

			return 
		end
	},
	goal = {
		init = function (mission_data, unit)
			local mission_text = Localize(mission_data.text)
			local data = {
				generic_counter = 0,
				manual_update = true,
				info_slate_type = "mission_goal",
				is_goal = true,
				mission_text = mission_text,
				mission_data = mission_data,
				unit = unit,
				start_time = Managers.state.network:network_time()
			}

			return data
		end,
		update = function (data, positive, unique_id, peer_id, dt, network_time)
			return 
		end,
		update_text = function (data)
			data.text = data.mission_text

			return 
		end,
		evaluate_mission = function (data, dt)
			data.end_time = Managers.state.network:network_time() - data.start_time

			return true, 1
		end,
		create_sync_data = function (data)
			local sync_data = {
				data.start_time,
				data.generic_counter
			}

			return sync_data
		end,
		sync = function (data, sync_data)
			local start_time = sync_data[1]
			data.start_time = start_time
			local generic_counter = sync_data[2]
			data.generic_counter = generic_counter

			return 
		end
	},
	players_alive = {
		init = function (mission_data, unit)
			local mission_text = Localize(mission_data.text)
			local evaluate_at_level_end = mission_data.evaluate_at_level_end
			local data = {
				info_slate_type = "mission_objective",
				mission_text = mission_text,
				unit = unit,
				mission_data = mission_data,
				evaluate_at_level_end = evaluate_at_level_end,
				experience_per_amount = mission_data.experience_per_amount,
				evaluation_type = mission_data.evaluation_type
			}

			return data
		end,
		update = function (data, positive, unique_id, peer_id, dt, network_time)
			return 
		end,
		update_text = function (data)
			data.text = ""

			return 
		end,
		evaluate_mission = function (data, dt)
			local players = Managers.player:human_and_bot_players()
			local num_alive = 0

			for _, player in pairs(players) do
				local unit = player.player_unit

				if Unit.alive(unit) then
					local status_extension = ScriptUnit.extension(unit, "status_system")

					if not status_extension.is_disabled(status_extension) then
						num_alive = num_alive + 1
					end
				end
			end

			return false, num_alive
		end,
		create_sync_data = function (data)
			local sync_data = {}

			return 
		end,
		sync = function (data, sync_data)
			return 
		end
	},
	survival = {
		init = function (mission_data, unit)
			local wave = SurvivalSettings.wave
			local starting_wave = SurvivalSettings.initial_wave
			local states = {
				wave = 2,
				completed = 3,
				prepare = 1
			}
			local wave_state = states.prepare
			local wave_completed_text = nil

			if mission_data.wave_completed_text then
				wave_completed_text = Localize(mission_data.wave_completed_text)
			else
				wave_completed_text = nil
			end

			local wave_prepare_text = nil

			if mission_data.wave_prepare_text then
				wave_prepare_text = Localize(mission_data.wave_prepare_text)
			else
				wave_prepare_text = nil
			end

			local mission_text = Localize(mission_data.wave_text)
			local start_time = Managers.state.network:network_time()
			local data = {
				info_slate_type = "mission_objective",
				manual_update = true,
				flow_update = true,
				wave_completed = 0,
				update_sound = true,
				mission_text = mission_text,
				mission_data = mission_data,
				unit = unit,
				wave = wave,
				wave_state = wave_state,
				wave_completed_text = wave_completed_text,
				wave_prepare_text = wave_prepare_text,
				states = states,
				evaluate_at_level_end = mission_data.evaluate_at_level_end,
				experience_per_percent = mission_data.experience_per_percent,
				start_time = start_time,
				wave_completed_time = start_time,
				wave_times = {},
				starting_wave = starting_wave
			}

			return data
		end,
		update = function (data, positive, unique_id, peer_id, dt, network_time)
			if data.wave_state == data.states.wave and data.wave_completed_text then
				data.wave_state = data.states.completed
				data.wave_completed = data.wave
				data.wave_completed_time = network_time
				data.wave_times[data.wave] = network_time

				Managers.state.game_mode:trigger_event("survival_wave_completed", Managers.state.difficulty:get_difficulty())
			elseif data.wave_state == data.states.completed and data.wave_prepare_text then
				data.wave_state = data.states.prepare
			elseif data.wave_state == data.states.prepare then
				data.wave_state = data.states.wave
				data.wave = data.wave + 1
			elseif data.wave_state == data.states.wave and data.wave_prepare_text then
				data.wave_state = data.states.prepare
			else
				data.wave_state = data.states.wave
				data.wave = data.wave + 1
			end

			return 
		end,
		update_text = function (data)
			if PLATFORM == "xb1" then
				if data.wave_state == data.states.wave then
					data.text = data.mission_text .. " " .. data.wave
				elseif data.wave_state == data.states.completed then
					data.text = data.mission_text .. " " .. data.wave .. " " .. data.wave_completed_text
				elseif data.wave_state == data.states.prepare then
					data.text = data.wave_prepare_text .. " " .. data.wave + 1
				else
					data.text = data.mission_text .. " " .. data.wave
				end
			elseif data.wave_state == data.states.wave then
				data.text = data.mission_text .. " " .. data.wave - data.starting_wave
			elseif data.wave_state == data.states.completed then
				data.text = data.mission_text .. " " .. data.wave - data.starting_wave .. " " .. data.wave_completed_text
			elseif data.wave_state == data.states.prepare then
				data.text = data.wave_prepare_text .. " " .. data.wave - data.starting_wave + 1
			else
				data.text = data.mission_text .. " " .. data.wave - data.starting_wave
			end

			return 
		end,
		evaluate_mission = function (data, dt)
			return false, data.wave_completed
		end,
		create_sync_data = function (data)
			local sync_data = {
				data.wave,
				data.wave_state,
				data.start_time,
				data.wave_completed,
				data.wave_completed_time,
				data.starting_wave
			}

			return sync_data
		end,
		sync = function (data, sync_data)
			local wave_num = sync_data[1]
			data.wave = wave_num
			local state = sync_data[2]
			data.wave_state = state
			local start_time = sync_data[3]
			data.start_time = start_time
			local wave_completed = sync_data[4]
			data.wave_completed = wave_completed
			local wave_completed_time = sync_data[5]
			data.wave_completed_time = wave_completed_time
			local starting_wave = sync_data[6]
			data.starting_wave = starting_wave

			return 
		end
	},
	tutorial = {
		init = function (mission_data, unit)
			local start_time = Managers.state.network:network_time()
			local data = {
				manual_update = true,
				info_slate_type = "mission_goal",
				done = false,
				flow_update = true,
				start_time = start_time,
				unit = unit,
				mission_data = mission_data
			}

			return data
		end,
		update = function (data, positive, unique_id, peer_id, dt, network_time)
			data.done = true

			return true
		end,
		update_text = function (data)
			data.text = ""

			return 
		end,
		evaluate_mission = function (data, dt)
			return data.done, (data.done and 1) or 0
		end,
		create_sync_data = function (data)
			local sync_data = {}

			return sync_data
		end,
		sync = function (data, sync_data)
			return 
		end
	}
}
MissionTemplates.collect_uncompletable = table.clone(MissionTemplates.collect)
MissionTemplates.collect_uncompletable.evaluate_mission = function (data, dt)
	return false, data.get_current_amount(data)
end
MissionTemplates.collect_unique_uncompletable = table.clone(MissionTemplates.collect)
MissionTemplates.collect_unique_uncompletable.init = function (mission_data, unit)
	local evaluate_at_level_end = mission_data.evaluate_at_level_end
	local data = {
		info_slate_type = "mission_objective",
		update_sound = true,
		manual_update = true,
		add_unique_id_for_peer = function (self, peer_id, unique_id)
			if not self.unique_ids_per_peer[peer_id] then
				self.unique_ids_per_peer[peer_id] = {}
			end

			self.unique_ids_per_peer[peer_id][unique_id] = true

			return 
		end,
		get_current_amount = function (self)
			return table.size(self.unique_ids_per_peer[Network.peer_id()] or {})
		end,
		get_unique_ids = function (self)
			return self.unique_ids_per_peer[Network.peer_id()] or {}
		end,
		get_unique_ids_for_peer_id = function (self, peer_id)
			return self.unique_ids_per_peer[peer_id] or {}
		end,
		unique_ids_per_peer = {},
		unit = unit,
		mission_data = mission_data,
		evaluate_at_level_end = evaluate_at_level_end,
		evaluation_type = mission_data.evaluation_type,
		lorebook_pages_per_amount = mission_data.lorebook_pages_per_amount
	}

	return data
end
MissionTemplates.collect_unique_uncompletable.update = function (data, positive, unique_id, peer_id, dt, network_time)
	data.add_unique_id_for_peer(data, peer_id, unique_id)

	return false
end
MissionTemplates.collect_unique_uncompletable.update_text = function (data)
	data.text = ""

	return 
end
MissionTemplates.collect_unique_uncompletable.evaluate_mission = function (data, dt)
	return false, data.get_current_amount(data)
end
MissionTemplates.collect_unique_uncompletable.create_sync_data = function (data, peer_id)
	local sync_data = {}
	local counter = 1

	for unique_id, _ in pairs(data.get_unique_ids_for_peer_id(data, peer_id)) do
		sync_data[counter] = unique_id
		counter = counter + 1
	end

	return sync_data
end
MissionTemplates.collect_unique_uncompletable.sync = function (data, sync_data)
	local peer_id = Network.peer_id()

	for _, unique_id in pairs(sync_data) do
		data.add_unique_id_for_peer(data, peer_id, unique_id)
	end

	return 
end

return 
