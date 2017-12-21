require("scripts/managers/backend/data_server_queue")

local function dprint(...)
	print("[BackendQuests]", ...)

	return 
end

BackendQuests = class(BackendQuests)
BackendQuests.init = function (self, boons_interface)
	self._tokens = {}
	self._initiated = false
	self._active_quest = nil
	self._available_quests = {}
	self._active_contracts = {}
	self._available_contracts = {}
	self._boons = boons_interface
	self._expire_times = {}
	self._reward_queue = {}

	return 
end
BackendQuests.setup = function (self, data_server_queue)
	self._register_executors(self, data_server_queue)

	self._queue = data_server_queue
	local token = self._queue:add_item("get_quest_state_1")

	return 
end
BackendQuests.initiated = function (self)
	return self._initiated
end
BackendQuests._register_executors = function (self, queue)
	queue.register_executor(queue, "quests", callback(self, "_command_quests"))
	queue.register_executor(queue, "contracts", callback(self, "_command_contracts"))
	queue.register_executor(queue, "contract_update", callback(self, "_command_contract_update"))
	queue.register_executor(queue, "contract_delete", callback(self, "_command_contract_delete"))
	queue.register_executor(queue, "quest_update", callback(self, "_command_quest_update"))
	queue.register_executor(queue, "quest_delete", callback(self, "_command_quest_delete"))
	queue.register_executor(queue, "rewarded", callback(self, "_command_rewarded"))
	queue.register_executor(queue, "expire_times", callback(self, "_command_expire_times"))
	queue.register_executor(queue, "boons", callback(self, "_command_boons"))

	return 
end
BackendQuests._command_quests = function (self, quests)
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

	for _, quest in pairs(quests) do
		quest.type = "main"
	end

	return 
end
BackendQuests._command_contracts = function (self, contracts)
	self._contracts = contracts
	self._contracts_dirty = true

	table.clear(self._active_contracts)
	table.clear(self._available_contracts)

	for contract_id, contract in pairs(contracts) do
		if contract.active then
			self._active_contracts[contract_id] = contract
		else
			self._available_contracts[contract_id] = contract
		end
	end

	return 
end
BackendQuests._command_contract_update = function (self, contract_update)
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
		end
	end

	return 
end
BackendQuests._command_contract_delete = function (self, contract_delete)
	self._contracts_dirty = true
	local id = contract_delete.id
	local contract = self._contracts[id]
	contract.deleted = true

	return 
end
BackendQuests._command_quest_update = function (self, quest_update)
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

	return 
end
BackendQuests._command_quest_delete = function (self, quest_delete)
	self._quests_dirty = true
	local id = quest_delete.id
	local quest = self._quests[id]
	quest.deleted = true

	return 
end
BackendQuests._command_rewarded = function (self, rewarded)
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

	return 
end
BackendQuests._command_expire_times = function (self, expire_times)
	self._expire_times = expire_times
	self._expire_times_dirty = true

	return 
end
BackendQuests._command_boons = function (self, boons)
	self._boons:set_boons(boons)

	return 
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
BackendQuests.get_active_quest = function (self)
	return self._active_quest
end
BackendQuests.set_active_quest = function (self, quest_id, active)
	local token = self._queue:add_item("set_quest_active_1", "quest_id", cjson.encode(quest_id), "active", cjson.encode(active))
	self._tokens[#self._tokens + 1] = token

	return 
end
BackendQuests.complete_quest = function (self, quest_id)
	local token = self._queue:add_item("turn_in_quest_1", "quest_id", cjson.encode(quest_id))
	self._tokens[#self._tokens + 1] = token

	return 
end
BackendQuests.are_contracts_dirty = function (self)
	local dirty = self._contracts_dirty
	self._contracts_dirty = false

	return dirty
end
BackendQuests.get_contracts = function (self)
	for _, contract in pairs(self._contracts) do
		if not contract.requirements.task then
			contract.requirements.task = {
				type = "complete_level",
				amount = {
					required = (contract.requirements.levels.required and #contract.requirements.levels.required) or 0,
					acquired = (contract.requirements.levels.acquired and #contract.requirements.levels.acquired) or 0
				}
			}
		end
	end

	return self._contracts
end
BackendQuests.get_available_contracts = function (self)
	return self._available_contracts
end
BackendQuests.get_active_contracts = function (self)
	return self._active_contracts
end
BackendQuests.set_contract_active = function (self, contract_id, active)
	local token = self._queue:add_item("set_contract_active_1", "contract_id", cjson.encode(contract_id), "active", cjson.encode(active))
	self._tokens[#self._tokens + 1] = token

	return 
end
BackendQuests.add_contract_progress = function (self, contract_id, task_type, amount)
	local token = self._queue:add_item("add_contract_progress_1", "contract_id", cjson.encode(contract_id), task_type, cjson.encode(amount))
	self._tokens[#self._tokens + 1] = token

	return 
end
BackendQuests.poll_reward = function (self)
	if not table.is_empty(self._reward_queue) then
		local reward = table.remove(self._reward_queue, 1)

		return reward
	end

	return 
end
BackendQuests.complete_contract = function (self, contract_id)
	local token = self._queue:add_item("turn_in_contract_1", "contract_id", cjson.encode(contract_id))
	self._tokens[#self._tokens + 1] = token

	return 
end
BackendQuests.query_boons = function (self)
	local token = self._queue:add_item("get_boons_1")
	self._tokens[#self._tokens + 1] = token

	return 
end
BackendQuests.reset_quests_and_contracts = function (self, reset_quests, reset_contracts)
	local config = cjson.encode({
		reset_quests = reset_quests,
		reset_contracts = reset_contracts
	})
	local token = self._queue:add_item("reset_quests_and_contracts_1", "param_config", config)
	self._tokens[#self._tokens + 1] = token
	local token2 = self._queue:add_item("get_quest_state_1")
	self._tokens[#self._tokens + 1] = token2

	return 
end
BackendQuests.query_quests_and_contracts = function (self)
	local token = self._queue:add_item("get_quest_state_1")
	self._tokens[#self._tokens + 1] = token

	return 
end
BackendQuests.query_expire_times = function (self)
	local token = self._queue:add_item("get_qnc_expire_times_1")
	self._tokens[#self._tokens + 1] = token

	return 
end
BackendQuests.are_expire_times_dirty = function (self)
	local dirty = self._expire_times_dirty
	self._expire_times_dirty = false

	return dirty
end
BackendQuests.get_expire_times = function (self)
	return self._expire_times
end

return 
