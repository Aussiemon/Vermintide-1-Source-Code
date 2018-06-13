BackendQuestsLocal = class(BackendQuestsLocal)
local MAX_NUMBER_OF_BOARD_QUESTS = 3
local MAX_NUMBER_OF_BOARD_CONTRACTS = 8
local SIMULATE_BACKEND_DELAY = true

BackendQuestsLocal.init = function (self)
	self._simulated_backend_delays = {
		set_quests_active = {},
		complete_quests = {},
		set_contracts_active = {},
		add_contracts_progress = {},
		complete_contracts = {}
	}
end

BackendQuestsLocal.setup = function (self, save_data)
	if save_data then
		if not save_data.quests_and_contracts then
			save_data.quests_and_contracts = {}
			local quests_and_contracts = save_data.quests_and_contracts
			quests_and_contracts.index = 1
			quests_and_contracts.quests = {}
			quests_and_contracts.contracts = {}
			quests_and_contracts.quest_update_time = 0
			quests_and_contracts.contract_update_time = 0
		end

		self._quests_and_contracts = save_data.quests_and_contracts
	else
		self._quests_and_contracts = {}
	end

	self._setup = true
end

BackendQuestsLocal.update = function (self, dt)
	if not self._setup then
		return
	end

	if SIMULATE_BACKEND_DELAY then
		self:_simulate_backend_delay(dt)
	end

	self:_update_quests_complete()
	self:_update_contracts_complete()
	self:_update_rewards()
end

BackendQuestsLocal._simulate_backend_delay = function (self, dt)
	local simulated_backend_delays = self._simulated_backend_delays
	local set_quests_active = simulated_backend_delays.set_quests_active

	for index, data in ipairs(set_quests_active) do
		local data = set_quests_active[index]
		data.time = data.time - dt

		if index == 1 and data.time <= 0 then
			self:_set_active_quest(data.quest_id, data.active)

			data, set_quests_active[index] = nil
		end
	end

	local complete_quests = simulated_backend_delays.complete_quests

	for index, data in ipairs(complete_quests) do
		local data = complete_quests[index]
		data.time = data.time - dt

		if index == 1 and data.time <= 0 then
			self:_complete_quest(data.quest_id)

			data, complete_quests[index] = nil
		end
	end

	local set_contracts_active = simulated_backend_delays.set_contracts_active

	for index, data in ipairs(set_contracts_active) do
		local data = set_contracts_active[index]
		data.time = data.time - dt

		if index == 1 and data.time <= 0 then
			self:_set_contract_active(data.contract_id, data.active)

			data, set_contracts_active[index] = nil
		end
	end

	local add_contracts_progress = simulated_backend_delays.add_contracts_progress

	for index, data in ipairs(add_contracts_progress) do
		local data = add_contracts_progress[index]
		data.time = data.time - dt

		if index == 1 and data.time <= 0 then
			self:_add_contract_progress(data.contract_id, data.value)

			data, add_contracts_progress[index] = nil
		end
	end

	local complete_contracts = simulated_backend_delays.complete_contracts

	for index, data in ipairs(complete_contracts) do
		local data = complete_contracts[index]
		data.time = data.time - dt

		if index == 1 and data.time <= 0 then
			self:_complete_contract(data.contract_id)

			data, complete_contracts[index] = nil
		end
	end
end

BackendQuestsLocal._update_quests_complete = function (self)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local quests = quests_and_contracts_save_data.quests

	for id, quest in pairs(quests) do
		if quest.active then
			local acquired = quest.requirements.task.amount.acquired
			local required = quest.requirements.task.amount.required

			if required <= acquired then
				quest.complete = true
			end
		end
	end
end

BackendQuestsLocal._update_contracts_complete = function (self)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local contracts = quests_and_contracts_save_data.contracts

	for id, contract in pairs(contracts) do
		if contract.active then
			local acquired = contract.requirements.task.amount.acquired
			local required = contract.requirements.task.amount.required

			if required <= acquired then
				contract.complete = true
			end
		end
	end
end

BackendQuestsLocal._update_rewards = function (self)
	local quest_rewards = self._quest_rewards_temp

	if quest_rewards then
		self.quest_rewards = table.clone(quest_rewards)
		self._quest_rewards_temp = nil
	else
		self.quest_rewards = nil
	end

	local contract_rewards = self._contract_rewards_temp

	if contract_rewards then
		self.contract_rewards = table.clone(contract_rewards)
		self._contract_rewards_temp = nil
	else
		self.contract_rewards = nil
	end
end

BackendQuestsLocal.initiated = function (self)
	return true
end

BackendQuestsLocal.get_quests = function (self)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local previous_quest_update_time = quests_and_contracts_save_data.quest_update_time
	local new_quests_available = false

	if previous_quest_update_time + 604800 < os.time() then
		self:_generate_new_quests(quests_and_contracts_save_data)

		new_quests_available = true
	end

	local quests = quests_and_contracts_save_data.quests

	return quests, new_quests_available
end

BackendQuestsLocal._generate_new_quests = function (self, save_data)
	local quests = save_data.quests

	for id, quest in pairs(quests) do
		if not quest.active then
			quests[id] = nil
		end
	end

	for i = 1, MAX_NUMBER_OF_BOARD_QUESTS, 1 do
		local quest_id = save_data.index
		local quest = table.clone(LocalQuestTemplates[math.random(1, #LocalQuestTemplates)])
		quest.id = quest_id
		quests[quest_id] = quest
		save_data.index = quest_id + 1
	end

	save_data.quest_update_time = os.time()

	self:_save()

	self._quests_dirty = true
end

local function get_delay_time()
	local delay = math.random()

	return delay
end

BackendQuestsLocal.set_active_quest = function (self, quest_id, active)
	local set_quests_active = self._simulated_backend_delays.set_quests_active
	local t = Managers.time:time("game")
	local time = get_delay_time()

	if SIMULATE_BACKEND_DELAY then
		set_quests_active[#set_quests_active + 1] = {
			quest_id = quest_id,
			active = active,
			time = time
		}
	else
		self:_set_active_quest(quest_id, active)
	end
end

BackendQuestsLocal._set_active_quest = function (self, quest_id, active)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local quests = quests_and_contracts_save_data.quests
	local quest = quests[quest_id]
	quest.active = active

	if not active then
		quest.requirements.task.amount.acquired = 0
	end

	self:_save()

	self._quests_dirty = true
end

BackendQuestsLocal.complete_quest = function (self, quest_id)
	local complete_quests = self._simulated_backend_delays.complete_quests
	local t = Managers.time:time("game")
	local time = get_delay_time()

	if SIMULATE_BACKEND_DELAY then
		complete_quests[#complete_quests + 1] = {
			quest_id = quest_id,
			time = time
		}
	else
		self:_complete_quest(quest_id)
	end
end

BackendQuestsLocal._complete_quest = function (self, quest_id)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local quests = quests_and_contracts_save_data.quests
	local quest = quests[quest_id]
	self._quest_rewards_temp = table.clone(quest.rewards)
	quests[quest_id] = nil

	self:_save()

	self._quests_dirty = true
end

local available_quests = {}

BackendQuestsLocal.get_available_quests = function (self)
	table.clear(available_quests)

	local quests = self:get_quests()

	for id, quest in pairs(quests) do
		if not quest.active then
			available_quests[id] = quest
		end
	end

	return available_quests
end

BackendQuestsLocal.get_active_quest = function (self)
	local quests = self:get_quests()

	for id, quest in pairs(quests) do
		if quest.active then
			return quest
		end
	end

	return nil
end

BackendQuestsLocal.get_quest_rewards = function (self)
	return self.quest_rewards
end

BackendQuestsLocal.are_quests_dirty = function (self)
	local dirty = self._quests_dirty
	self._quests_dirty = false

	return dirty
end

BackendQuestsLocal.get_contracts = function (self)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local previous_contract_update_time = quests_and_contracts_save_data.contract_update_time
	local new_contracts_available = false

	if previous_contract_update_time + 86400 < os.time() then
		self:_generate_new_contracts(quests_and_contracts_save_data)

		new_contracts_available = true
	end

	local contracts = quests_and_contracts_save_data.contracts

	return contracts, new_contracts_available
end

BackendQuestsLocal._generate_new_contracts = function (self, save_data)
	local contracts = save_data.contracts

	for id, contract in pairs(contracts) do
		if not contract.active then
			contracts[id] = nil
		end
	end

	for i = 1, MAX_NUMBER_OF_BOARD_CONTRACTS, 1 do
		local contract_id = save_data.index
		local contract = table.clone(LocalContractTemplates[math.random(1, #LocalContractTemplates)])
		contract.id = contract_id
		contracts[contract_id] = contract
		save_data.index = contract_id + 1

		if contract.rewards.quest.amount_sigils > 0 then
			local quests = save_data.quests
			local rand = math.random(1, table.size(quests))
			local index = 1
			local chosen_id = nil

			for quest_id, quest in pairs(quests) do
				if index == rand then
					chosen_id = quest_id
				end
			end

			contract.rewards.quest.quest_id = chosen_id
		else
			contract.rewards.quest = nil
		end
	end

	save_data.contract_update_time = os.time()

	self:_save()

	self._contracts_dirty = true
end

BackendQuestsLocal.set_contract_active = function (self, contract_id, active)
	local set_contracts_active = self._simulated_backend_delays.set_contracts_active
	local t = Managers.time:time("game")
	local time = get_delay_time()

	if SIMULATE_BACKEND_DELAY then
		set_contracts_active[#set_contracts_active + 1] = {
			contract_id = contract_id,
			active = active,
			time = time
		}
	else
		self:_set_contract_active(contract_id, active)
	end
end

BackendQuestsLocal._set_contract_active = function (self, contract_id, active)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local contracts = quests_and_contracts_save_data.contracts
	local contract = contracts[contract_id]
	contract.active = active

	if not active then
		contract.requirements.task.amount.acquired = 0
	end

	self:_save()

	self._contracts_dirty = true
end

BackendQuestsLocal.add_contract_progress = function (self, contract_id, value)
	local add_contracts_progress = self._simulated_backend_delays.add_contracts_progress
	local t = Managers.time:time("game")
	local time = get_delay_time()

	if SIMULATE_BACKEND_DELAY then
		add_contracts_progress[#add_contracts_progress + 1] = {
			contract_id = contract_id,
			value = value,
			time = time
		}
	else
		self:_add_contract_progress(contract_id, value)
	end
end

BackendQuestsLocal._add_contract_progress = function (self, contract_id, value)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local contracts = quests_and_contracts_save_data.contracts
	local contract = contracts[contract_id]
	local current_value = contract.requirements.task.amount.acquired
	local required_value = contract.requirements.task.amount.required
	contract.requirements.task.amount.acquired = current_value + math.min(value, required_value - current_value)

	self:_save()

	self._contracts_dirty = true
end

BackendQuestsLocal.complete_contract = function (self, contract_id)
	local complete_contracts = self._simulated_backend_delays.complete_contracts
	local t = Managers.time:time("game")
	local time = get_delay_time()

	if SIMULATE_BACKEND_DELAY then
		complete_contracts[#complete_contracts + 1] = {
			contract_id = contract_id,
			time = time
		}
	else
		self:_complete_contract(contract_id)
	end
end

BackendQuestsLocal._complete_contract = function (self, contract_id)
	local player_data = PlayerData
	local quests_and_contracts_save_data = self._quests_and_contracts
	local contracts = quests_and_contracts_save_data.contracts
	local contract = contracts[contract_id]
	self._contract_rewards_temp = table.clone(contract.rewards)
	local quest_id = (contract.rewards.quest and contract.rewards.quest.quest_id) or nil

	if quest_id then
		local quests = quests_and_contracts_save_data.quests
		local quest = quests[quest_id]

		if quest then
			local sigils = contract.rewards.quest.amount_sigils
			local current_value = quest.requirements.amount_sigils.acquired
			local required_value = quest.requirements.amount_sigils.required
			quest.requirements.amount_sigils.acquired = current_value + math.min(sigils, required_value - current_value)
		end
	end

	contracts[contract_id] = nil

	self:_save()

	self._contracts_dirty = true
end

local available_contracts = {}

BackendQuestsLocal.get_available_contracts = function (self)
	table.clear(available_contracts)

	local contracts = self:get_contracts()

	for id, contract in pairs(contracts) do
		if not contract.active then
			available_contracts[id] = contract
		end
	end

	return available_contracts
end

local active_contracts = {}

BackendQuestsLocal.get_active_contracts = function (self)
	table.clear(active_contracts)

	local contracts = self:get_contracts()

	for id, contract in pairs(contracts) do
		if contract.active then
			active_contracts[id] = contract
		end
	end

	return active_contracts
end

BackendQuestsLocal.get_contract_rewards = function (self)
	return self.contract_rewards
end

BackendQuestsLocal.are_contracts_dirty = function (self)
	local dirty = self._contracts_dirty
	self._contracts_dirty = false

	return dirty
end

BackendQuestsLocal.query_boons = function (self)
	return
end

BackendQuestsLocal.query_expire_times = function (self)
	return
end

BackendQuestsLocal.are_expire_times_dirty = function (self)
	return
end

BackendQuestsLocal.get_expire_times = function (self)
	return
end

BackendQuestsLocal.are_status_dirty = function (self)
	return
end

BackendQuestsLocal.get_status = function (self)
	return
end

BackendQuestsLocal._save = function (self)
	return
end

function has_boons()
	local quests = Managers.backend:get_interface("quests")
	local contracts = quests:get_contracts()

	for id, data in pairs(contracts) do
		if data.active and data.rewards.boons then
			print("got boons!")
		else
			print("no boons :(")
		end
	end
end

function add_progress()
	local quests = Managers.backend:get_interface("quests")
	local contracts = quests:get_contracts()

	for id, data in pairs(contracts) do
		if data.active then
			table.dump(data.requirements.task, "tasks", 3)
			quests:add_contract_progress(id, 100)
		end
	end
end

function complete()
	local quests = Managers.backend:get_interface("quests")
	local contracts = quests:get_contracts()

	for id, data in pairs(contracts) do
		if data.active then
			quests:complete_contract(id)
		end
	end
end

return
