require("scripts/managers/backend/data_server_queue")

local function dprint(...)
	print("[BackendQuests]", ...)
end

BackendQuests = class(BackendQuests)

BackendQuests.init = function (self, boons_interface)
	self._tokens = {}
	self._initiated = false
	self._active_quest = nil
	self._available_quests = {}
	self._active_contracts = {}
	self._available_contracts = {}
	self._mutators = {}
	self._boons = boons_interface
	self._expire_times = nil
	self._reward_queue = {}
end

BackendQuests.setup = function (self, data_server_queue)
	self:_register_executors(data_server_queue)

	self._queue = data_server_queue
	local param_config = {
		reset_contracts = true,
		reset_quests = true
	}

	self._queue:add_item(GameSettingsDevelopment.backend_settings.qnc_get_state_script)
end

BackendQuests.initiated = function (self)
	return self._initiated
end

BackendQuests._register_executors = function (self, queue)
	queue:register_executor("quests", callback(self, "_command_quests"))
	queue:register_executor("contracts", callback(self, "_command_contracts"))
	queue:register_executor("contract_update", callback(self, "_command_contract_update"))
	queue:register_executor("contract_delete", callback(self, "_command_contract_delete"))
	queue:register_executor("quest_update", callback(self, "_command_quest_update"))
	queue:register_executor("quest_delete", callback(self, "_command_quest_delete"))
	queue:register_executor("rewarded", callback(self, "_command_rewarded"))
	queue:register_executor("expire_times", callback(self, "_command_expire_times"))
	queue:register_executor("status", callback(self, "_command_status"))
	queue:register_executor("mutators", callback(self, "_command_mutators"))
	queue:register_executor("boons", callback(self, "_command_boons"))
	queue:register_executor("boons_add", callback(self, "_command_boons_add"))
end

BackendQuests._command_mutators = function (self, mutator_data)
	dprint("_command_mutators")

	local mutators = self._mutators

	table.clear(mutators)

	for _, data in ipairs(mutator_data) do
		local level = data.level
		local level_table = mutators[level]

		if not level_table then
			level_table = {}
			mutators[level] = level_table
		end

		local difficulty = data.difficulty
		local difficulty_table = level_table[difficulty]

		if not difficulty_table then
			difficulty_table = {}
			level_table[difficulty] = difficulty_table
		end

		difficulty_table[#difficulty_table + 1] = data.mutator
	end
end

BackendQuests._command_quests = function (self, quests)
	dprint("_command_quests")

	self._initiated = true
	self._quests = quests
	self._quests_dirty = true

	table.clear(self._available_quests)

	for quest_id, quest in pairs(quests) do
		if quest.active then
			self._active_quest = quest
		else
			self._available_quests[quest_id] = quest
		end
	end
end

BackendQuests._command_contracts = function (self, contracts)
	dprint("_command_contracts")

	self._contracts = contracts
	self._contracts_dirty = true

	table.clear(self._active_contracts)
	table.clear(self._available_contracts)

	local t = Managers.time:time("main")

	for contract_id, contract in pairs(contracts) do
		if contract.active then
			self._active_contracts[contract_id] = contract
		else
			self._available_contracts[contract_id] = contract
		end

		contract.main_time_expire = t + contract.ttl
		local requirements = contract.requirements
		local backend_difficulty = requirements.difficulty
		local level_settings = LevelSettings[requirements.level]
		local allowed_difficulties = level_settings.difficulties

		if allowed_difficulties then
			for _, difficulty_name in ipairs(allowed_difficulties) do
				local settings = DifficultySettings[difficulty_name]

				if settings.rank == backend_difficulty then
					requirements.difficulty = difficulty_name
				end
			end
		else
			requirements.difficulty = Difficulties[backend_difficulty]
		end
	end
end

BackendQuests._command_contract_update = function (self, contract_update)
	dprint("_command_contract_update")

	self._contracts_dirty = true
	local id = contract_update.id
	local contract = self._contracts[id]
	local data = contract_update.data

	for key, value in pairs(data) do
		contract[key] = value

		if key == "active" then
			if value then
				self._available_contracts[id] = nil
				self._active_contracts[id] = contract
			else
				self._available_contracts[id] = contract
				self._active_contracts[id] = nil
			end
		elseif key == "requirements" then
			local backend_difficulty = value.difficulty
			local requirements = contract.requirements
			local level_settings = LevelSettings[requirements.level]
			local allowed_difficulties = level_settings.difficulties

			if allowed_difficulties then
				for _, difficulty_name in ipairs(allowed_difficulties) do
					local settings = DifficultySettings[difficulty_name]

					if settings.rank == backend_difficulty then
						requirements.difficulty = difficulty_name
					end
				end
			else
				requirements.difficulty = Difficulties[backend_difficulty]
			end
		end
	end
end

BackendQuests._command_contract_delete = function (self, contract_delete)
	dprint("_command_contract_delete")

	self._contracts_dirty = true
	local id = contract_delete.id
	self._contracts[id] = nil
	local active_contracts = self._active_contracts

	if active_contracts[id] then
		active_contracts[id] = nil
	end
end

BackendQuests._command_quest_update = function (self, quest_update)
	dprint("_command_quest_update")

	self._quests_dirty = true
	local id = quest_update.id
	local quest = self._quests[id]
	local data = quest_update.data

	for key, value in pairs(data) do
		quest[key] = value

		if key == "active" then
			if value then
				self._available_quests[id] = nil
				self._active_quest = quest
			else
				self._available_quests[id] = quest
				self._active_quest = nil
			end
		end
	end
end

BackendQuests._command_quest_delete = function (self, quest_delete)
	dprint("_command_quest_delete")

	self._quests_dirty = true
	local id = quest_delete.id
	self._quests[id] = nil
	local active_quest = self._active_quest

	if active_quest and active_quest.id == id then
		self._active_quest = nil
	end
end

BackendQuests._command_rewarded = function (self, rewarded)
	dprint("_command_rewarded")

	for _, reward in ipairs(rewarded) do
		if reward.type == "item" then
			local gui_reward = {
				reward.data
			}

			table.insert(self._reward_queue, reward)
		elseif reward.type == "token" then
			local gui_reward = {
				type = reward.token_type,
				amount = reward.amount
			}

			table.insert(self._reward_queue, reward)
		elseif reward.type == "boon" then
			local gui_reward = {
				reward.data
			}

			table.insert(self._reward_queue, reward)
		end
	end
end

BackendQuests._command_expire_times = function (self, expire_times)
	dprint("_command_expire_times")

	self._expire_times_dirty = true
	self._expire_times = expire_times
end

BackendQuests._command_status = function (self, status)
	dprint("_command_status", status)

	self._status_dirty = true
	self._status = status
end

BackendQuests._command_boons = function (self, boons)
	self._boons:set_boons(boons)
end

BackendQuests._command_boons_add = function (self, boons)
	self._boons:add_boons(boons)
end

BackendQuests.are_quests_dirty = function (self)
	local dirty = self._quests_dirty
	self._quests_dirty = false

	return dirty
end

BackendQuests.get_quests = function (self)
	return self._quests
end

BackendQuests.get_available_quests = function (self)
	return self._available_quests
end

BackendQuests.get_mutators = function (self)
	return self._mutators
end

BackendQuests.get_active_quest = function (self)
	return self._active_quest
end

BackendQuests.set_active_quest = function (self, quest_id, active)
	local token = self._queue:add_item("qnc_set_quest_active_1", "quest_id", cjson.encode(quest_id), "active", cjson.encode(active))
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.complete_quest = function (self, quest_id)
	local token = self._queue:add_item("qnc_turn_in_quest_1", "quest_id", cjson.encode(quest_id))
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.are_contracts_dirty = function (self)
	local dirty = self._contracts_dirty
	self._contracts_dirty = false

	return dirty
end

BackendQuests.get_contracts = function (self)
	return self._contracts
end

BackendQuests.get_available_contracts = function (self)
	return self._available_contracts
end

BackendQuests.get_active_contracts = function (self)
	return self._active_contracts
end

BackendQuests.set_contract_active = function (self, contract_id, active)
	local token = self._queue:add_item("qnc_set_contract_active_1", "contract_id", cjson.encode(contract_id), "active", cjson.encode(active))
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.add_contract_progress = function (self, contract_id, level, amount)
	local token = self._queue:add_item("qnc_add_contract_progress_1", "contract_id", cjson.encode(contract_id), "level", cjson.encode(level), "task_amount", cjson.encode(amount))
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.add_all_contract_progress = function (self, contract_id)
	local token = self._queue:add_item("qnc_add_all_contract_progress_1", "contract_id", cjson.encode(contract_id))
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.poll_reward = function (self)
	if not table.is_empty(self._reward_queue) then
		local reward = table.remove(self._reward_queue, 1)

		return reward
	end
end

BackendQuests.complete_contract = function (self, contract_id)
	local token = self._queue:add_item("qnc_turn_in_contract_1", "contract_id", cjson.encode(contract_id))
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.query_boons = function (self)
	local token = self._queue:add_item("qnc_get_boons_1")
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.reset_quests_and_contracts = function (self, reset_quests, reset_contracts)
	local config = cjson.encode({
		reset_quests = reset_quests,
		reset_contracts = reset_contracts
	})
	local token = self._queue:add_item("qnc_reset_1", "param_config", config)
	self._tokens[#self._tokens + 1] = token
	local token2 = self._queue:add_item(GameSettingsDevelopment.backend_settings.qnc_get_state_script)
	self._tokens[#self._tokens + 1] = token2
end

local time_offset = 0

BackendQuests.reset_quests_and_contracts_with_time_offset = function (self, reset_quests, reset_contracts, add_time_offset)
	local config = cjson.encode({
		reset_quests = reset_quests,
		reset_contracts = reset_contracts
	})
	local token = self._queue:add_item("qnc_reset_1", "param_config", config)
	self._tokens[#self._tokens + 1] = token

	if add_time_offset then
		time_offset = time_offset + add_time_offset
	else
		time_offset = 0
	end

	local debug_time = os.time() + time_offset
	local token2 = self._queue:add_item("get_quest_state_debug_1", "debug_time", debug_time)
	self._tokens[#self._tokens + 1] = token2
end

BackendQuests.query_quests_and_contracts = function (self)
	local token = self._queue:add_item(GameSettingsDevelopment.backend_settings.qnc_get_state_script)
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.query_expire_times = function (self)
	dprint("query_expire_times")

	local token = self._queue:add_item("qnc_get_expire_times_1")
	self._tokens[#self._tokens + 1] = token
end

BackendQuests.are_expire_times_dirty = function (self)
	local dirty = self._expire_times_dirty
	self._expire_times_dirty = false

	return dirty
end

BackendQuests.get_expire_times = function (self)
	return self._expire_times
end

BackendQuests.are_status_dirty = function (self)
	local dirty = self._status_dirty
	self._status_dirty = false

	return dirty
end

BackendQuests.get_status = function (self)
	return self._status
end

return
