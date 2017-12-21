require("scripts/managers/quest/contract_templates")
require("scripts/managers/quest/quest_templates")
require("scripts/managers/quest/quest_contract_texts")
require("scripts/settings/quest_settings")

local QuestTextSettings = QuestTextSettings
local NUM_QUEST_GIVERS = table.size(QuestTextSettings.quest_givers)
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
		self.mutators = quest_interface.get_mutators(quest_interface)
		self.status = quest_interface.get_status(quest_interface)
		self.active_mutators = self._update_active_mutators(self, {})
	end

	return 
end
QuestManager.evaluate_level_end = function (self, statistics_db, level_key)
	local backend_settings = GameSettingsDevelopment.backend_settings

	if backend_settings.quests_enabled then
		local params = self.evaluation_params
		local active_contracts = self.active_contracts
		local session_progress = self.session_progress

		for contract_id, contract in pairs(active_contracts) do
			self._commit_contract_progress(self, contract_id, contract, params)

			local contract_session_progress = session_progress[contract_id]

			if contract_session_progress then
				contract_session_progress.commited = true
			end
		end
	end

	return 
end
QuestManager._update_active_mutators = function (self, return_table)
	table.clear(return_table)

	local params = self.evaluation_params
	local mutator_data = self.mutators[params.level_key]
	local current_difficulty_rank = params.difficulty_rank

	if mutator_data then
		for difficulty_rank, mutators in pairs(mutator_data) do
			if difficulty_rank <= current_difficulty_rank then
				for _, mutator in ipairs(mutators) do
					return_table[mutator] = true
				end
			end
		end
	end

	return return_table
end
QuestManager.is_mutator_active = function (self, mutator_name)
	local active = self.active_mutators

	return active and active[mutator_name]
end
QuestManager.update = function (self, statistics_db, dt, t)
	local quest_interface = self.quest_interface
	self.evaluation_params.difficulty_rank = Managers.state.difficulty:get_difficulty_rank()
	self.all_quests = quest_interface.get_quests(quest_interface)
	self.active_quest = quest_interface.get_active_quest(quest_interface)
	self.available_quests = quest_interface.get_available_quests(quest_interface)
	self.all_contracts = quest_interface.get_contracts(quest_interface)
	self.active_contracts = quest_interface.get_active_contracts(quest_interface)
	self.available_contracts = quest_interface.get_available_contracts(quest_interface)
	self.mutators = quest_interface.get_mutators(quest_interface)
	self.active_mutators = self._update_active_mutators(self, self.active_mutators)

	if script_data.debug_mutators then
		for k, v in pairs(self.mutators) do
			Debug.text("%s", k)

			for k1, v1 in pairs(v) do
				Debug.text("   %s", k1)

				for k2, v2 in pairs(v1) do
					Debug.text("      %s:%s", k2, v2)
				end
			end
		end

		Debug.text("ACTIVE:")

		for k, v in pairs(self.active_mutators) do
			Debug.text("   " .. k)
		end
	end

	local session_progress = self.session_progress
	local active_contracts = self.active_contracts
	local params = self.evaluation_params

	for contract_id, contract in pairs(active_contracts) do
		if not self._progress_valid(self, contract, params) then
			local contract_session_progress = session_progress[contract_id]

			if contract_session_progress and not contract_session_progress.commited then
				session_progress[contract_id] = nil
			end
		else
			if not session_progress[contract_id] then
				session_progress[contract_id] = {
					changed = false,
					commited = false,
					amount = 0
				}
			end

			local progress = session_progress[contract_id]
			local amount = progress.amount
			local session_amount, negative_progress = self._calculate_contract_session_progress(self, contract, params, false)
			progress.negative_progress = negative_progress

			if amount ~= session_amount then
				local task = contract.requirements.task
				local amount = task.amount
				local acquired = amount.acquired
				local required = amount.required
				local missing_progress = required - acquired
				local negative_score = amount.negative_score

				if negative_score then
					progress.amount = session_amount
				else
					progress.amount = math.min(session_amount, missing_progress)
				end

				progress.changed = true
			end
		end
	end

	if self._poll then
		self._poll_backend(self, dt, t)
	end

	return 
end
QuestManager.has_contract_session_changes = function (self, contract_id)
	local session_progress = self.session_progress
	local progress = session_progress[contract_id]

	if progress then
		local changed = progress.changed
		progress.changed = false

		return changed or progress.negative_progress
	end

	return 
end
QuestManager.get_session_progress_by_contract_id = function (self, contract_id)
	local session_progress = self.session_progress
	local progress = session_progress[contract_id]

	if progress then
		return progress.amount, progress.negative_progress
	end

	return 
end
QuestManager._progress_valid = function (self, contract, params, ignore_level_and_difficulty)
	local requirements = contract.requirements

	if not ignore_level_and_difficulty then
		local level_key = params.level_key
		local required_level = requirements.level

		if required_level and required_level ~= level_key then
			return false
		end

		local difficulty_rank = params.difficulty_rank
		local required_difficulty = requirements.difficulty

		if required_difficulty then
			local required_rank = DifficultySettings[required_difficulty].rank
			local correct_difficulty = required_rank <= difficulty_rank

			if not correct_difficulty then
				return false
			end
		end
	end

	local task = requirements.task

	if task then
		local amount = task.amount
		local acquired = amount.acquired
		local required = amount.required

		if required <= acquired then
			return false
		end
	end

	return true
end
local SPECIALS = {}

for breed_name, breed in pairs(Breeds) do
	if breed.special then
		SPECIALS[#SPECIALS + 1] = breed_name
	end
end

QuestManager._calculate_contract_session_progress = function (self, contract, params, finished_level)
	local requirements = contract.requirements
	local task = requirements.task

	if task then
		local task_type = task.type
		local statistics_db = params.statistics_db
		local stats_id = Managers.player:local_player(1):stats_id()
		local mission_system = Managers.state.entity:system("mission_system")

		if task_type == "level" then
			return (finished_level and 1) or 0
		elseif task_type == "ogre" then
			local local_player = Managers.player:local_player()
			local stats_id = local_player.stats_id(local_player)
			local player_killed = statistics_db.get_stat(statistics_db, stats_id, "kills_per_breed", "skaven_rat_ogre")
			local player_assists = statistics_db.get_stat(statistics_db, stats_id, "kill_assists_per_breed", "skaven_rat_ogre")

			return player_killed + player_assists
		elseif task_type == "tome" then
			local mission_data = mission_system.get_level_end_mission_data(mission_system, "tome_bonus_mission")
			local num_collected = (mission_data and mission_data.get_current_amount(mission_data)) or 0

			return num_collected
		elseif task_type == "grimoire" then
			local mission_data = mission_system.get_level_end_mission_data(mission_system, "grimoire_hidden_mission")
			local num_collected = (mission_data and mission_data.get_current_amount(mission_data)) or 0

			return num_collected
		elseif task_type == "grenade_kills" then
			local local_player = Managers.player:local_player()
			local stats_id = local_player.stats_id(local_player)
			local player_killed = statistics_db.get_stat(statistics_db, stats_id, "kills_grenade")
			local player_assists = statistics_db.get_stat(statistics_db, stats_id, "kill_assists_grenade")
			local grenade_kills = player_killed + player_assists

			return grenade_kills
		elseif task_type == "open_chests" then
			return statistics_db.get_stat(statistics_db, "session", "chests_opened")
		elseif task_type == "damage_taken_individual" then
			local local_player = Managers.player:local_player()
			local stats_id = local_player.stats_id(local_player)
			local local_player_unit = local_player.player_unit

			local function get_stat(...)
				return statistics_db:get_stat(stats_id, ...)
			end

			local function set_stat(stat, v)
				statistics_db:set_stat(stats_id, stat, v)

				return 
			end

			local function inc_stat(stat)
				statistics_db:increment_stat(stats_id, stat)

				return 
			end

			local damage_taken = 0

			for breed_name, _ in pairs(Breeds) do
				damage_taken = damage_taken + get_stat("damage_taken_per_breed", breed_name)
			end

			local last_checkpoint_damage_taken = get_stat("checkpoint_damage_taken")
			local progress = statistics_db.get_stat(statistics_db, "session", "level_progress_distance")
			local last_checkpoint_progress = get_stat("checkpoint_progress")
			local distance = 91.44
			local allowed_damage = 30
			local player_dead = not AiUtils.unit_alive(local_player_unit)
			local negative_progress = false

			if player_dead and not last_checkpoint_progress then
			elseif player_dead or not last_checkpoint_progress or last_checkpoint_damage_taken + allowed_damage < damage_taken then
				if last_checkpoint_progress and last_checkpoint_damage_taken + allowed_damage < damage_taken and 5 < progress - last_checkpoint_progress then
					negative_progress = true
				end

				set_stat("checkpoint_damage_taken", damage_taken)
				set_stat("checkpoint_progress", progress)
			elseif distance < progress - last_checkpoint_progress then
				set_stat("checkpoint_damage_taken", damage_taken)
				set_stat("checkpoint_progress", last_checkpoint_progress + distance)
				inc_stat("completed_checkpoints")
			end

			return get_stat("completed_checkpoints"), negative_progress
		elseif task_type == "avoid_deaths_team" then
			local starting_points = 4
			local deaths = statistics_db.get_stat(statistics_db, "session", "deaths")

			return math.max(0, starting_points - deaths)
		elseif task_type == "avoid_specials_damage_team" then
			local allowed_damage = 150
			local damage = 0
			local progress_percent = statistics_db.get_stat(statistics_db, "session", "level_progress")

			for _, breed_name in ipairs(SPECIALS) do
				damage = damage + statistics_db.get_stat(statistics_db, "session", "damage_taken_per_breed", breed_name)
			end

			local estimated_damage = (damage*100)/math.max(progress_percent, 1)
			local damage_multiplier = estimated_damage/allowed_damage
			local penalty = nil

			if damage_multiplier <= 1 then
				return math.floor(damage_multiplier*30 - 100)
			else
				return math.floor(damage_multiplier/70)
			end
		elseif task_type == "last_stand_waves_defeated" then
			local local_player = Managers.player:local_player()
			local stats_id = local_player.stats_id(local_player)
			local diffs = SurvivalDifficulties
			local num_diffs = #diffs
			local difficulty = requirements.difficulty
			local found = false
			local waves = 0

			for i = 1, num_diffs, 1 do
				local diff_name = diffs[i]

				if found or diff_name == difficulty then
					found = true
					waves = waves + statistics_db.get_stat(statistics_db, stats_id, "last_stand_waves_completed", diff_name)
				end
			end

			return waves
		elseif task_type == "find_event_items" then
			local local_player = Managers.player:local_player()
			local stats_id = local_player.stats_id(local_player)
			local event_items_found = statistics_db.get_stat(statistics_db, stats_id, "event_items_found")

			return event_items_found
		end

		fassert(false, "trying to calculate session progress on a contract with an unsuported task: %s", task_type)
	end

	return 0
end
QuestManager._commit_contract_progress = function (self, contract_id, contract, params)
	if not self._progress_valid(self, contract, params) then
		return 
	end

	local task_amount = self._calculate_contract_session_progress(self, contract, params, true)

	if GameSettingsDevelopment.use_telemetry then
		local local_player = Managers.player:local_player(1)
		local requirements = contract.requirements
		local task = requirements.task

		if task and local_player then
			local telemetry_data = {}
			local amount = task.amount
			local acquired = amount.acquired
			local required = amount.required
			local telemetry_id = local_player.telemetry_id(local_player)
			local progress = acquired + task_amount
			telemetry_data.complete = required <= progress
			telemetry_data.old_progress = acquired
			telemetry_data.new_progress = task_amount
			telemetry_data.goal_progress = required
			telemetry_data.contract = task.type
			telemetry_data.player_id = telemetry_id
			telemetry_data.level_key = params.level_key
			telemetry_data.requirement_difficulty = requirements
			telemetry_data.played_difficulty = Managers.state.difficulty:get_difficulty()

			Managers.telemetry:register_event("contract_progress", telemetry_data)
		end
	end

	if 0 < task_amount then
		local level_key = params.level_key

		self.quest_interface:add_contract_progress(contract_id, level_key, task_amount)
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
QuestManager.has_contract_progressed = function (self, contract_id)
	local progress = self.get_contract_progress(self, contract_id)

	if progress and 0 < progress then
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

	return 
end
QuestManager.decline_contract_by_id = function (self, contract_id)
	local quest_interface = self.quest_interface

	quest_interface.set_contract_active(quest_interface, contract_id, false)

	return 
end
QuestManager.complete_contract_by_id = function (self, contract_id)
	local quest_interface = self.quest_interface

	quest_interface.complete_contract(quest_interface, contract_id)

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

	local quest_interface = self.quest_interface
	local active_contracts = self.active_contracts

	for contract_id, data in pairs(active_contracts) do
		active_contract_ids[#active_contract_ids + 1] = contract_id
	end

	return active_contract_ids
end
QuestManager.get_active_contracts = function (self)
	local active_contracts = self.active_contracts

	return active_contracts
end
QuestManager.should_contract_progress_be_shown = function (self, contract_id, ignore_level_and_difficulty)
	local params = self.evaluation_params
	local contract = self.get_contract_by_id(self, contract_id)

	if not contract then
		return false
	end

	local progress_valid = self._progress_valid(self, contract, params, ignore_level_and_difficulty)

	return progress_valid
end
QuestManager.are_contracts_dirty = function (self)
	local quest_interface = self.quest_interface
	local dirty = quest_interface.are_contracts_dirty(quest_interface)

	return dirty
end
QuestManager.get_title_for_contract_id = function (self, contract_id)
	local contract = self.get_contract_by_id(self, contract_id)
	local task = contract.requirements.task
	local task_type = task and task.type
	local dlc_type = contract.type
	local titles = QuestSettings.task_type_titles[task_type]
	local title = Localize(titles[1])

	return title
end
QuestManager.get_description_for_contract_id = function (self, contract_id)
	local contract = self.get_contract_by_id(self, contract_id)
	local task = contract.requirements.task
	local task_type = task and task.type

	if task_type == "grimoire" then
		task_type = "grim"
	end

	local start_seed = self.get_random_seed_from_id(self, contract_id)
	local max_range = QuestTextSettings.task_type_max_range[task_type]

	if not max_range then
		printf("QuestManager:get_description_for_contract_id() ERROR! Missing max_range for task type %q in QuestSettings, defaulting to 1", task_type)

		max_range = 1
	end

	local seed, value = Math.next_random(start_seed, max_range)
	local index = (value < 10 and "0" .. tostring(value)) or tostring(value)
	local localization_key = "dlc1_3_1_task_description_" .. task_type .. "_" .. index

	return localization_key
end
QuestManager.get_quest_progress = function (self, quest_id)
	local quest = self.get_quest_by_id(self, quest_id)
	local progress = quest.requirements.task.amount.acquired

	return progress
end
QuestManager.has_quest_progressed = function (self, contract_id)
	local progress = self.get_quest_progress(self, contract_id)

	if progress and 0 < progress then
		return true
	end

	return false
end
QuestManager.get_mutators = function (self, level_key, difficulty)
	local level_data = self.mutators[level_key]

	if not level_data then
		return 
	end

	local mutators = level_data[difficulty]

	return mutators
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

	self.quest_interface:set_active_quest(quest_id, true)

	return 
end
QuestManager.decline_quest_by_id = function (self, quest_id)
	local quest_interface = self.quest_interface

	quest_interface.set_active_quest(quest_interface, quest_id, false)

	return 
end
QuestManager.complete_quest_by_id = function (self, quest_id)
	local quest_interface = self.quest_interface

	quest_interface.complete_quest(quest_interface, quest_id)

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
	local start_seed = self.get_random_seed_from_id(self, quest_id)
	local seed, value = Math.next_random(start_seed, NUM_QUEST_GIVERS)
	local giver = QuestTextSettings.quest_givers[value]
	local max_range = QuestTextSettings.quest_giver_max_range[giver]
	seed, value = Math.next_random(seed, max_range)
	local index = (value < 10 and "0" .. tostring(value)) or tostring(value)
	local localization_key = "dlc1_3_1_quest_title_" .. giver .. "_" .. index

	return localization_key
end
QuestManager.get_description_for_quest_id = function (self, quest_id)
	local quest = self.get_quest_by_id(self, quest_id)
	local start_seed = self.get_random_seed_from_id(self, quest_id)
	local seed, value = Math.next_random(start_seed, NUM_QUEST_GIVERS)
	local giver = QuestTextSettings.quest_givers[value]
	local max_range = QuestTextSettings.quest_giver_max_range[giver]
	seed, value = Math.next_random(seed, max_range)
	local index = (value < 10 and "0" .. tostring(value)) or tostring(value)
	local localization_key = "dlc1_3_1_quest_description_" .. giver .. "_" .. index

	return localization_key
end
QuestManager._refresh_expire_times = function (self)
	self.quest_interface:query_expire_times()

	self._query_expire_times = true

	return 
end
QuestManager._update_expire_times = function (self, dt, t)
	local quest_interface = self.quest_interface

	if quest_interface.are_expire_times_dirty(quest_interface) then
		self.expire_times = quest_interface.get_expire_times(quest_interface)
		local lowest_time_left = math.min(self.expire_times.quests_ttl, self.expire_times.contracts_ttl)
		self._expire_check_cooldown = math.min(lowest_time_left + QuestSettings.EXPIRE_CHECK_MARGIN, QuestSettings.EXPIRE_CHECK_COOLDOWN)
		self._query_expire_times = nil
	end

	if self.expire_times then
		local quests_expired = self.has_time_expired(self, self.expire_times.quests_ttl)
		local contracts_expired = self.has_time_expired(self, self.expire_times.contracts_ttl)
		self.quests_expired = quests_expired
		self.contracts_expired = contracts_expired

		if quests_expired or contracts_expired then
			self.query_quests_and_contracts(self)
		elseif not self._query_expire_times then
			self._expire_check_cooldown = self._expire_check_cooldown - dt

			if self._expire_check_cooldown <= 0 then
				self._refresh_expire_times(self)
			end
		end
	end

	return 
end
QuestManager.has_quests_expired = function (self)
	return self.quests_expired
end
QuestManager.has_contracts_expired = function (self)
	return self.contracts_expired
end
QuestManager.are_status_dirty = function (self)
	local quest_interface = self.quest_interface
	local dirty = quest_interface.are_status_dirty(quest_interface)

	return dirty
end
QuestManager.get_status = function (self)
	return self.status
end
QuestManager.set_poll_active = function (self, poll)
	self._poll = poll

	if poll and not self.expire_times then
		self.query_quests_and_contracts(self)
	end

	return 
end
QuestManager.query_quests_and_contracts = function (self)
	local quest_interface = self.quest_interface

	quest_interface.query_quests_and_contracts(quest_interface)

	self._query_quests_and_contracts = true

	return 
end
QuestManager.is_querying_quests_and_contracts = function (self)
	return self._query_quests_and_contracts
end
QuestManager.prepare_for_new_quests_and_contracts = function (self)
	local expire_times = self.expire_times

	if expire_times then
		local duration = QuestSettings.PREPARE_MENU_FOR_SYNC_DURATION
		local lowest_time_left = math.min(self.expire_times.quests_ttl, self.expire_times.contracts_ttl)

		if lowest_time_left < QuestSettings.EXPIRE_CHECK_COOLDOWN and self._expire_check_cooldown < duration then
			return true
		end
	end

	return false
end
QuestManager.is_quests_and_contracts_dirty = function (self)
	return self._quests_and_contracts_dirty
end
QuestManager._poll_backend = function (self, dt, t)
	local dirty_quests = self.are_quests_dirty(self)
	local dirty_contracts = self.are_contracts_dirty(self)
	local dirty = dirty_quests or dirty_contracts

	if self._query_quests_and_contracts then
		if dirty then
			self._query_quests_and_contracts = nil

			self._refresh_expire_times(self)
		end
	else
		self._update_expire_times(self, dt, t)
	end

	self._quests_and_contracts_dirty = dirty

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
QuestManager.has_time_expired = function (self, ttl)
	return ttl < 0
end

return 
