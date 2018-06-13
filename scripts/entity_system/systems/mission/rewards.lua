require("scripts/settings/economy")

Rewards = class(Rewards)

Rewards.init = function (self, level_key)
	self._level_key = level_key
	self._base_experience = ScriptBackendProfileAttribute.get("experience")
	self._multiplier = ExperienceSettings.multiplier
	self.mission_rewards_n = 0
end

local function experience_sort_function(a, b)
	return b.experience < a.experience
end

local dice_textures = {
	gold = "dice_04",
	metal = "dice_02",
	warpstone = "dice_05",
	wood = "dice_01"
}
local token_textures = {
	iron_tokens = "token_icon_01",
	silver_tokens = "token_icon_03",
	bronze_tokens = "token_icon_02",
	gold_tokens = "token_icon_04"
}
local line_break_table = {}

Rewards._add_rewards_from_completed_missions = function (self, completed_missions, mission_rewards, difficulty_rank, level_length_modifier)
	local mission_rewards_n = self.mission_rewards_n

	for mission_name, data in pairs(completed_missions) do
		if not data.is_goal then
			local experience = data.experience or 0
			local bonus_dice = data.bonus_dice or 0
			local bonus_tokens = data.bonus_tokens or 0
			local lorebook_pages = data.lorebook_pages or 0
			local dice_type = data.dice_type
			local token_type = data.token_type
			local line_break = false

			if experience > 0 or bonus_dice > 0 or bonus_tokens > 0 or lorebook_pages > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					text = data.mission_data.text
				}
				line_break = true
			end

			if experience > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					text = "dlc1_2_experience",
					experience = experience * difficulty_rank * level_length_modifier * self._multiplier
				}
			end

			if bonus_dice > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					text = "dlc1_2_dice",
					bonus = true,
					value = bonus_dice,
					icon = dice_textures[dice_type]
				}
			end

			if bonus_tokens > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					text = "dlc1_2_tokens",
					bonus = true,
					value = bonus_tokens,
					icon = token_textures[token_type]
				}
			end

			if lorebook_pages > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					icon = "summary_lore_page",
					text = "dlc1_3_lorebook_pages",
					bonus = false,
					value = lorebook_pages
				}
			end

			if line_break then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = line_break_table
			end
		end
	end

	self.mission_rewards_n = mission_rewards_n
end

Rewards._add_rewards_from_active_missions = function (self, active_missions, mission_rewards, difficulty_rank, level_length_modifier)
	local mission_rewards_n = self.mission_rewards_n

	for mission_name, data in pairs(active_missions) do
		if not data.is_goal then
			local mission_template_name = data.mission_data.mission_template_name
			local template = MissionTemplates[mission_template_name]
			local done, amount = template.evaluate_mission(data)

			fassert(not done, "mission was active AND done...")

			local experience = 0
			local bonus_dice = 0
			local dice_type = data.dice_type
			local bonus_tokens = 0
			local lorebook_pages = 0
			local token_type = data.token_type
			local line_break = false

			if data.evaluation_type == "percent" then
				local percent_completed = amount * 100
				local experience_per_percent = data.experience_per_percent or 0
				local dice_per_percent = data.dice_per_percent or 0
				local tokens_per_percent = data.tokens_per_percent or 0
				local lorebook_pages_per_percent = data.lorebook_pages_per_percent or 0
				experience = math.ceil(percent_completed * experience_per_percent)
				bonus_dice = math.floor(percent_completed * dice_per_percent)
				bonus_tokens = math.floor(percent_completed * tokens_per_percent)
				lorebook_pages = math.floor(percent_completed * lorebook_pages_per_percent)

				if experience > 0 or bonus_dice > 0 or bonus_tokens > 0 or lorebook_pages > 0 then
					mission_rewards_n = mission_rewards_n + 1
					mission_rewards[mission_rewards_n] = {
						text = data.mission_data.text
					}
					line_break = true
				end
			elseif data.evaluation_type == "amount" then
				local collected_amount = amount
				local experience_per_amount = data.experience_per_amount or 0
				local dice_per_amount = data.dice_per_amount or 0
				local tokens_per_amount = data.tokens_per_amount or 0
				local lorebook_pages_per_amount = data.lorebook_pages_per_amount or 0
				experience = collected_amount * experience_per_amount
				bonus_dice = collected_amount * dice_per_amount
				bonus_tokens = collected_amount * tokens_per_amount
				lorebook_pages = collected_amount * lorebook_pages_per_amount

				if experience > 0 or bonus_dice > 0 or bonus_tokens > 0 or lorebook_pages > 0 then
					mission_rewards_n = mission_rewards_n + 1
					mission_rewards[mission_rewards_n] = {
						text = data.mission_data.text
					}
					local collected_item_texture = data.mission_data.collected_item_texture

					if collected_item_texture then
						mission_rewards[mission_rewards_n].value = collected_amount
						mission_rewards[mission_rewards_n].icon = collected_item_texture
					end

					line_break = true
				end
			end

			if experience > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					text = "dlc1_2_experience",
					experience = experience * difficulty_rank * level_length_modifier * self._multiplier
				}
			end

			if bonus_dice > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					text = "dlc1_2_dice",
					bonus = true,
					value = bonus_dice,
					icon = dice_textures[dice_type]
				}
			end

			if bonus_tokens > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					text = "dlc1_2_tokens",
					bonus = true,
					value = bonus_tokens,
					icon = token_textures[token_type]
				}
			end

			if lorebook_pages > 0 then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = {
					icon = "summary_lore_page",
					text = "dlc1_3_lorebook_pages",
					bonus = false,
					value = lorebook_pages
				}
			end

			if line_break then
				mission_rewards_n = mission_rewards_n + 1
				mission_rewards[mission_rewards_n] = line_break_table
			end
		end
	end

	self.mission_rewards_n = mission_rewards_n
end

Rewards._add_missions_from_mission_system = function (self, mission_rewards, difficulty_rank, level_length_modifier)
	local mission_system = Managers.state.entity:system("mission_system")
	local active_missions, completed_missions = mission_system:get_missions()
	self.mission_rewards_n = 0

	self:_add_rewards_from_completed_missions(completed_missions, mission_rewards, difficulty_rank, level_length_modifier)
	self:_add_rewards_from_active_missions(active_missions, mission_rewards, difficulty_rank, level_length_modifier)
end

Rewards.get_mission_results = function (self, completed_level, game_mode_key)
	local mission_rewards = {}
	local difficulty_manager = Managers.state.difficulty
	local difficulty = difficulty_manager:get_difficulty()
	local difficulty_rank = difficulty_manager:get_difficulty_rank()
	local level_length_type = LengthTypeByLevel[self._level_key] or "long"
	local level_length_modifier = ExperienceSettings.level_length_experience_multiplier[level_length_type]

	if game_mode_key == "survival" then
		self:_add_missions_from_mission_system(mission_rewards, 1, 1)
	elseif completed_level then
		self:_add_missions_from_mission_system(mission_rewards, difficulty_rank, level_length_modifier)

		local mission_complete_reward = {
			text = "mission_completed_" .. difficulty,
			experience = 100 * difficulty_rank * level_length_modifier * self._multiplier
		}

		table.insert(mission_rewards, 1, mission_complete_reward)
		table.insert(mission_rewards, 2, line_break_table)
	else
		local mission_system = Managers.state.entity:system("mission_system")
		local completed_distance = mission_system:percentage_completed() or 0
		local mission_failed_reward = {
			text = "mission_failed_" .. difficulty,
			experience = 100 * difficulty_rank * level_length_modifier * completed_distance * self._multiplier
		}

		table.insert(mission_rewards, 1, mission_failed_reward)
		table.insert(mission_rewards, 2, line_break_table)
	end

	if mission_rewards[#mission_rewards] == line_break_table then
		table.remove(mission_rewards, #mission_rewards)
	end

	return mission_rewards
end

Rewards.get_level_start = function (self)
	return ExperienceSettings.get_level(self._base_experience), self._base_experience
end

Rewards.get_level_end = function (self, completed_level, game_mode_key)
	local mission_rewards = self:get_mission_results(completed_level, game_mode_key)
	local gained_xp = 0

	for _, mission_reward in ipairs(mission_rewards) do
		gained_xp = gained_xp + (mission_reward.experience or 0)
	end

	local experience = self._base_experience + gained_xp

	return ExperienceSettings.get_level(experience), experience
end

Rewards._query_upgrades_failed_game = function (self, level_start, level_end, token_rewards)
	if level_start < level_end then
		ScriptBackendItem.upgrades_failed_game(level_start, level_end)
	else
		self._upgrades = {}
	end
end

Rewards._loss_tokens = function (self)
	local level_length_type = LengthTypeByLevel[self._level_key]

	if level_length_type == "long" then
		local mission_system = Managers.state.entity:system("mission_system")
		local completed_distance = mission_system:percentage_completed() or 0

		if Math.random_range(0.3, 0.6) < completed_distance then
			local difficulty_manager = Managers.state.difficulty
			local difficulty = difficulty_manager:get_difficulty()
			local difficulty_settings = difficulty_manager:get_difficulty_settings()
			local level_failed_reward = difficulty_settings.level_failed_reward
			local token_type = level_failed_reward.token_type
			local token_amount = Vault.withdraw_single_ex(VaultEconomyLevelFailedKeyTable[difficulty].amount, level_failed_reward.token_amount)
			local token_rewards = {
				token_type = token_type,
				token_amount = token_amount
			}

			return token_rewards
		end
	end
end

Rewards.poll_upgrades_failed_game = function (self)
	if not self._upgrades then
		self._upgrades = ScriptBackendItem.poll_upgrades_failed_game()
	end

	return not not self._upgrades
end

Rewards.get_upgrades_failed_game = function (self)
	fassert(self._upgrades, "Trying to get level up upgrades before they arrived")

	return self._upgrades, self._token_rewards
end

Rewards.award_experience = function (self, completed_level, game_mode_key)
	local level_start, start_experience = self:get_level_start()
	local level_end, end_experience = self:get_level_end(completed_level, game_mode_key)

	print("Backend Experience Commit: Previous Experience = " .. tostring(start_experience) .. ", New Experience = " .. tostring(end_experience))

	if not completed_level or game_mode_key == "survival" then
		local token_rewards = self:_loss_tokens()
		self._token_rewards = token_rewards

		self:_query_upgrades_failed_game(level_start, level_end)

		if token_rewards then
			BackendUtils.add_tokens(token_rewards.token_amount, token_rewards.token_type)
		end
	end

	ScriptBackendProfileAttribute.set("experience", end_experience)
	Managers.backend:commit()
end

return
