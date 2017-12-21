require("scripts/managers/quest/contract_templates")
require("scripts/managers/quest/quest_templates")
require("scripts/managers/quest/quest_contract_texts")

QuestManager = class(QuestManager)
QuestManager.init = function (self, statistics_db, level_key)
	local backend_settings = GameSettingsDevelopment.backend_settings

	if backend_settings.quests_enabled then
		local statistics_db = statistics_db
		local difficulty_manager = Managers.state.difficulty
		local difficulty_rank = difficulty_manager.get_difficulty_rank(difficulty_manager)
		self.evaluation_params = {
			statistics_db = statistics_db,
			level_key = level_key,
			difficulty_rank = difficulty_rank
		}
		local quest_interface = Managers.backend:get_interface("quests")

		quest_interface.are_contracts_dirty(quest_interface)
		quest_interface.are_quests_dirty(quest_interface)
		quest_interface.are_expire_times_dirty(quest_interface)

		self.quest_interface = quest_interface
		self.session_progress = {}
		self.all_quests = quest_interface.get_quests(quest_interface)
		self.active_quest = quest_interface.get_active_quest(quest_interface)
		self.available_quests = quest_interface.get_available_quests(quest_interface)
		self.all_contracts = quest_interface.get_contracts(quest_interface)
		self.active_contracts = quest_interface.get_active_contracts(quest_interface)
		self.available_contracts = quest_interface.get_available_contracts(quest_interface)
		self.expire_times = quest_interface.get_expire_times(quest_interface)
	end

	return 
end
QuestManager.evaluate_level_end = function (self, statistics_db, level_key)
	local backend_settings = GameSettingsDevelopment.backend_settings

	if backend_settings.quests_enabled then
		local params = self.evaluation_params
		local active_contracts = self.active_contracts

		for contract_id, contract in pairs(active_contracts) do
			self._commit_contract_progress(self, contract_id, contract, params)
		end
	end

	return 
end
QuestManager.update = function (self, statistics_db, dt, t)
	local quest_interface = self.quest_interface
	self.all_quests = quest_interface.get_quests(quest_interface)
	self.active_quest = quest_interface.get_active_quest(quest_interface)
	self.available_quests = quest_interface.get_available_quests(quest_interface)
	self.all_contracts = quest_interface.get_contracts(quest_interface)
	self.active_contracts = quest_interface.get_active_contracts(quest_interface)
	self.available_contracts = quest_interface.get_available_contracts(quest_interface)
	self.expire_times = quest_interface.get_expire_times(quest_interface)
	local session_progress = self.session_progress
	local active_contracts = self.active_contracts
	local params = self.evaluation_params

	for contract_id, contract in pairs(active_contracts) do
		if not self._progress_valid(self, contract, params) then
		else
			if not session_progress[contract_id] then
				session_progress[contract_id] = {
					changed = false,
					amount = 0
				}
			end

			local progress = session_progress[contract_id]
			local amount = progress.amount
			local session_amount = self._calculate_contract_session_progress(self, contract, params)
			local new_amount = amount + session_amount

			if amount ~= session_amount then
				progress.amount = session_amount
				progress.changed = true
			else
				progress.changed = false
			end
		end
	end

	return 
end
QuestManager.has_contract_session_changes = function (self, contract_id)
	local session_progress = self.session_progress
	local progress = session_progress[contract_id]

	if progress then
		return progress.changed
	end

	return 
end
QuestManager.get_session_progress_by_contract_id = function (self, contract_id)
	local session_progress = self.session_progress
	local progress = session_progress[contract_id]

	if progress then
		return progress.amount
	end

	return 
end
QuestManager._progress_valid = function (self, contract, params)
	local requirements = contract.requirements
	local required_difficulty = requirements.difficulty
	local required_rank = DifficultySettings[required_difficulty].rank
	local levels = requirements.levels
	local task = requirements.task
	local level_key = params.level_key
	local difficulty_rank = params.difficulty_rank
	local correct_difficulty = required_rank <= difficulty_rank

	if not correct_difficulty then
		return false
	end

	local correct_level = table.contains(levels.required, "any") or table.contains(levels.required, level_key)

	if not correct_level then
		return false
	end

	local tasks_done = false

	if task then
		local amount = task.amount
		local acquired = amount.acquired
		local required = amount.required

		if required <= acquired then
			tasks_done = true
		end
	end

	levels_done = #levels.required <= #levels.acquired

	if tasks_done and levels_done then
		return false
	end

	return true
end
QuestManager._calculate_contract_session_progress = function (self, contract, params)
	local requirements = contract.requirements
	local task = requirements.task

	if task then
		local task_type = task.type
		local statistics_db = params.statistics_db
		local stats_id = Managers.player:local_player(1):stats_id()
		local mission_system = Managers.state.entity:system("mission_system")

		if task_type == "complete_level" then
			return 1
		end

		if task_type == "ogre" then
			local num_killed = 0
			local players = Managers.player:human_and_bot_players()

			for _, player in pairs(players) do
				local player_killed = statistics_db.get_stat(statistics_db, player.stats_id(player), "kills_per_breed", "skaven_rat_ogre")
				num_killed = num_killed + player_killed
			end

			return num_killed
		end

		if task_type == "tome" then
			local mission_data = mission_system.get_level_end_mission_data(mission_system, "tome_bonus_mission")
			local num_collected = (mission_data and mission_data.get_current_amount(mission_data)) or 0

			return num_collected
		end

		if task_type == "grimoire" then
			local mission_data = mission_system.get_level_end_mission_data(mission_system, "grimoire_hidden_mission")
			local num_collected = (mission_data and mission_data.get_current_amount(mission_data)) or 0

			return num_collected
		end

		fassert(false, "trying to calculate session progress on a contract with an unsuported task: %s", task_type)
	end

	return 0
end
QuestManager._commit_contract_progress = function (self, contract_id, contract, params)
	local quest_interface = self.quest_interface
	local requirements = contract.requirements
	local task = requirements.task

	if task then
		local task_type = task.type
		local statistics_db = params.statistics_db
		local stats_id = Managers.player:local_player(1):stats_id()
		local mission_system = Managers.state.entity:system("mission_system")

		if not self._progress_valid(self, contract, params) then
			return 
		end

		if task_type == "ogre" then
			local num_killed = 0
			local players = Managers.player:human_and_bot_players()

			for _, player in pairs(players) do
				local player_killed = statistics_db.get_stat(statistics_db, player.stats_id(player), "kills_per_breed", "skaven_rat_ogre")
				num_killed = num_killed + player_killed
			end

			if 0 < num_killed then
				quest_interface.add_contract_progress(quest_interface, contract_id, "task_amount", num_killed)
			end
		end

		if task_type == "tome" then
			local mission_data = mission_system.get_level_end_mission_data(mission_system, "tome_bonus_mission")
			local num_collected = (mission_data and mission_data.get_current_amount(mission_data)) or 0

			if 0 < num_collected then
				quest_interface.add_contract_progress(quest_interface, contract_id, "task_amount", num_collected)
			end
		end

		if task_type == "grimoire" then
			local mission_data = mission_system.get_level_end_mission_data(mission_system, "grimoire_hidden_mission")
			local num_collected = (mission_data and mission_data.get_current_amount(mission_data)) or 0

			if 0 < num_collected then
				quest_interface.add_contract_progress(quest_interface, contract_id, "task_amount", num_collected)
			end
		end

		quest_interface.add_contract_progress(quest_interface, contract_id, "level", params.level_key)
	end

	return 
end
QuestManager.get_contract_progress = function (self, contract_id)
	local contract = self.get_contract_by_id(self, contract_id)
	local task = contract.requirements.task

	if not task then
		return 0
	end

	local progress = task.amount.acquired

	return progress
end
QuestManager.get_contract_level_progress = function (self, contract_id)
	local contract = self.get_contract_by_id(self, contract_id)
	local levels = contract.requirements.levels

	if not levels then
		return 0
	end

	local progress = #levels.acquired

	return progress
end
QuestManager.has_contract_progressed = function (self, contract_id)
	local progress = self.get_contract_progress(self, contract_id)
	local level_progress = self.get_contract_level_progress(self, contract_id)

	if progress and 0 < progress then
		return true
	end

	if level_progress and 0 < level_progress then
		return true
	end

	return false
end
QuestManager.get_contracts = function (self)
	return self.all_contracts
end
QuestManager.get_available_contracts = function (self)
	return self.available_contracts
end
QuestManager.get_contract_by_id = function (self, contract_id)
	local quest_interface = self.quest_interface
	local contracts = quest_interface.get_contracts(quest_interface)
	local contract = contracts[contract_id]

	return contract
end
QuestManager.accept_contract_by_id = function (self, contract_id)
	local quest_interface = self.quest_interface

	quest_interface.set_contract_active(quest_interface, contract_id, true)
	self.query_quests_and_contracts(self)

	return 
end
QuestManager.decline_contract_by_id = function (self, contract_id)
	local quest_interface = self.quest_interface

	quest_interface.set_contract_active(quest_interface, contract_id, false)
	self.query_quests_and_contracts(self)

	return 
end
QuestManager.complete_contract_by_id = function (self, contract_id)
	local quest_interface = self.quest_interface

	quest_interface.complete_contract(quest_interface, contract_id)
	self.query_quests_and_contracts(self)

	return 
end
QuestManager.is_contract_requirements_met_by_id = function (self, contract_id)
	local contract = self.get_contract_by_id(self, contract_id)
	local requirements_met = contract.requirements_met

	return requirements_met
end
local active_contract_ids = {}
QuestManager.get_active_contract_ids = function (self)
	table.clear(active_contract_ids)

	local active_contracts = self.active_contracts

	for contract_id, _ in pairs(active_contracts) do
		active_contract_ids[#active_contract_ids + 1] = contract_id
	end

	return active_contract_ids
end
QuestManager.get_active_contracts = function (self)
	local active_contracts = self.active_contracts

	return active_contracts
end
QuestManager.is_contract_able_to_progress = function (self, contract_id)
	local params = self.evaluation_params
	local contract = self.get_contract_by_id(self, contract_id)
	local progress_valid = self._progress_valid(self, contract, params)

	return progress_valid
end
QuestManager.is_task_available_for_contract = function (self, contract_id)
	local params = self.evaluation_params
	local contract = self.get_contract_by_id(self, contract_id)
	local task = contract.requirements.task
	local task_type = task.type
	local level_key = params.level_key
	local available_tasks = LevelSettings[level_key].quest_settings

	return available_tasks[task_type]
end
QuestManager.are_contracts_dirty = function (self)
	local quest_interface = self.quest_interface
	local dirty = quest_interface.are_contracts_dirty(quest_interface)

	return dirty
end
local task_type_max_range = {
	generic = 5,
	tome = 5,
	ogre = 5,
	complete_level = 5,
	grimoire = 5
}
QuestManager.get_title_for_contract_id = function (self, contract_id)
	local contract = self.get_contract_by_id(self, contract_id)
	local task = contract.requirements.task
	local task_type = (task and task.type) or "generic"
	local max_range = task_type_max_range[task_type]
	local start_seed = self.get_random_seed_from_id(self, contract_id)
	local seed, value = Math.next_random(start_seed, max_range)
	seed, value = Math.next_random(seed, max_range)
	local index = (value < 10 and "0" .. tostring(value)) or tostring(value)
	local localization_key = "dlc1_3_1_contract_title_" .. task_type .. "_" .. index
	local title = Localize(localization_key)

	return title
end
QuestManager.get_description_for_contract_id = function (self, contract_id)
	local contract = self.get_contract_by_id(self, contract_id)
	local task = contract.requirements.task
	local task_type = (task and task.type) or "generic"
	local max_range = task_type_max_range[task_type]
	local start_seed = self.get_random_seed_from_id(self, contract_id)
	local seed, value = Math.next_random(start_seed, max_range)
	seed, value = Math.next_random(seed, max_range)
	local index = (value < 10 and "0" .. tostring(value)) or tostring(value)
	local localization_key = "dlc1_3_1_contract_description_" .. task_type .. "_" .. index
	local description = Localize(localization_key)

	return description
end
QuestManager.get_quest_progress = function (self, quest_id)
	local quest = self.get_quest_by_id(self, quest_id)
	local progress = quest.requirements.amount_sigils.acquired

	return progress
end
QuestManager.has_quest_progressed = function (self, contract_id)
	local progress = self.get_quest_progress(self, contract_id)

	if progress and 0 < progress then
		return true
	end

	return false
end
QuestManager.get_quests = function (self)
	return self.all_quests
end
QuestManager.get_available_quests = function (self)
	return self.available_quests
end
QuestManager.get_quest_by_id = function (self, quest_id)
	local quest_interface = self.quest_interface
	local quests = quest_interface.get_quests(quest_interface)
	local quest = quests[quest_id]

	return quest
end
QuestManager.accept_quest_by_id = function (self, quest_id)
	local quest_interface = self.quest_interface

	quest_interface.set_active_quest(quest_interface, quest_id, true)
	self.query_quests_and_contracts(self)

	return 
end
QuestManager.decline_quest_by_id = function (self, quest_id)
	local quest_interface = self.quest_interface

	quest_interface.set_active_quest(quest_interface, quest_id, false)
	self.query_quests_and_contracts(self)

	return 
end
QuestManager.complete_quest_by_id = function (self, quest_id)
	local quest_interface = self.quest_interface

	quest_interface.complete_quest(quest_interface, quest_id)
	self.query_quests_and_contracts(self)

	return 
end
QuestManager.is_quest_requirements_met_by_id = function (self, quest_id)
	local quest = self.get_quest_by_id(self, quest_id)
	local requirements_met = quest.requirements_met

	return requirements_met
end
QuestManager.get_active_quest = function (self)
	local active_quest = self.active_quest

	return active_quest
end
QuestManager.are_quests_dirty = function (self)
	local quest_interface = self.quest_interface
	local dirty = quest_interface.are_quests_dirty(quest_interface)

	return dirty
end
QuestManager.get_title_for_quest_id = function (self, quest_id)
	local quest = self.get_quest_by_id(self, quest_id)
	local giver = "generic"
	local title = string.format(Localize("dlc1_3_1_quest_giver_title"), Localize(giver))

	return title
end
local quest_giver_max_range = {
	grodni = 5,
	generic = 5
}
QuestManager.get_description_for_quest_id = function (self, quest_id)
	local quest = self.get_quest_by_id(self, quest_id)
	local giver = "generic"
	local max_range = quest_giver_max_range[giver]
	local start_seed = self.get_random_seed_from_id(self, quest_id)
	local seed, value = Math.next_random(start_seed, max_range)
	seed, value = Math.next_random(seed, max_range)
	local index = (value < 10 and "0" .. tostring(value)) or tostring(value)
	local localization_key = "dlc1_3_1_quest_description_" .. giver .. "_" .. index
	local description = Localize(localization_key)

	return description
end
QuestManager.query_expire_times = function (self)
	local quest_interface = self.quest_interface

	quest_interface.query_expire_times(quest_interface)

	return 
end
QuestManager.are_expire_times_dirty = function (self, keep_dirty)
	local quest_interface = self.quest_interface
	local dirty = quest_interface.are_expire_times_dirty(quest_interface, keep_dirty)

	return dirty
end
QuestManager.get_expire_times = function (self)
	return self.expire_times
end
QuestManager.query_quests_and_contracts = function (self)
	local quest_interface = self.quest_interface

	quest_interface.query_quests_and_contracts(quest_interface)

	return 
end
QuestManager.poll_reward = function (self)
	local quest_interface = self.quest_interface
	local reward = quest_interface.poll_reward(quest_interface)

	return reward
end
QuestManager.get_random_seed_from_id = function (self, id)
	local id_seed = nil

	if type(id) == "number" then
		id_seed = id
	else
		id_seed = id.sub(id, -12, -6) + id.sub(id, -6)
	end

	local seed = Math.next_random(id_seed)

	return seed
end
QuestManager.has_time_expired = function (self, expire_at)
	local current_time = os.time()
	local diff = expire_at - current_time
	local expired = diff <= 0

	return expired
end

return 
