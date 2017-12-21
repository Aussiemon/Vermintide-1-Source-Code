MapViewHelper = class(MapViewHelper)
DEBUG_UNLOCK_ALL = false
MapViewHelper.init = function (self, statistics_db, player_stats_id)
	self.statistics_db = statistics_db
	self.player_stats_id = player_stats_id

	for index, act_key in ipairs(GameActsOrder) do
		local act_unlocked = LevelUnlockUtils.act_unlocked(statistics_db, player_stats_id, act_key)

		if not act_unlocked then
			self.current_act_key = GameActsOrder[index - 1]
			self.next_act_key = act_key

			break
		end
	end

	self.difficulty_manager = Managers.state.difficulty

	return 
end
MapViewHelper.get_level_visibility = function (self, level_key, level_settings)
	if DEBUG_UNLOCK_ALL or script_data.unlock_all_levels then
		return "visible"
	end

	local game_mode = level_settings.game_mode or "adventure"

	if game_mode == "adventure" then
		return self.get_adventure_level_visibility(self, level_key, level_settings)
	elseif game_mode == "survival" then
		return self.get_survival_level_visibility(self, level_key, level_settings)
	end

	return 
end
MapViewHelper.get_adventure_level_visibility = function (self, level_key, level_settings)
	local current_act_key = self.current_act_key
	local next_act_key = self.next_act_key
	local dlc_name = level_settings.dlc_name

	if dlc_name then
		local is_dlc_unlocked = Managers.unlock:is_dlc_unlocked(dlc_name)

		if is_dlc_unlocked then
			return "visible"
		else
			local tooltip_text = Localize("dlc1_2_dlc_level_locked_tooltip")

			return "dlc", tooltip_text
		end
	end

	if current_act_key then
		local act_levels = GameActs[current_act_key]
		local next_act_levels = GameActs[next_act_key]
		local statistics_db = self.statistics_db
		local player_stats_id = self.player_stats_id

		if LevelUnlockUtils.level_unlocked(statistics_db, player_stats_id, level_key) or table.find(NoneActLevels, level_key) then
			return "visible"
		end

		if not table.find(next_act_levels, level_key) then
			return "hidden"
		end

		local show_next_act, required_level_key = nil

		for i = 1, #act_levels, 1 do
			local act_level_key = act_levels[i]
			local level_stat = statistics_db.get_persistent_stat(statistics_db, player_stats_id, "completed_levels", act_level_key)
			local level_completed = level_stat and level_stat ~= 0

			if not level_completed then
				if show_next_act then
					show_next_act = false

					break
				else
					show_next_act = true
					required_level_key = act_level_key
				end
			end
		end

		if show_next_act then
			local required_level_display_name = LevelSettings[required_level_key].display_name
			local tooltip_text = string.format(Localize("map_level_preview_tooltip"), Localize(required_level_display_name))

			return "locked", tooltip_text
		else
			return "hidden"
		end
	end

	return "visible"
end
MapViewHelper.get_survival_level_visibility = function (self, level_key, level_settings)
	local is_required_act_unlocked = self.is_survival_unlocked(self)
	local dlc_name = level_settings.dlc_name

	if dlc_name then
		local is_dlc_unlocked = Managers.unlock:is_dlc_unlocked(dlc_name)

		if is_dlc_unlocked then
			if is_required_act_unlocked then
				return "visible"
			else
				local required_level_display_name = LevelSettings.magnus.display_name
				local tooltip_text = string.format(Localize("map_level_preview_tooltip"), Localize(required_level_display_name))

				return "locked", tooltip_text
			end
		else
			local tooltip_text = Localize("dlc1_2_dlc_level_locked_tooltip")

			return "dlc", tooltip_text
		end
	end

	if is_required_act_unlocked then
		return "visible"
	else
		local required_level_display_name = LevelSettings.magnus.display_name
		local tooltip_text = string.format(Localize("map_level_preview_tooltip"), Localize(required_level_display_name))

		return "locked", tooltip_text
	end

	return 
end
MapViewHelper.get_completed_level_difficulty = function (self, level_key)
	local statistics_db = self.statistics_db
	local player_stats_id = self.player_stats_id

	return LevelUnlockUtils.completed_level_difficulty_index(statistics_db, player_stats_id, level_key)
end
MapViewHelper.is_survival_unlocked = function (self)
	local statistics_db = self.statistics_db
	local player_stats_id = self.player_stats_id
	local required_act_unlocked = SurvivalSettings.required_act_unlocked
	local is_required_act_unlocked = LevelUnlockUtils.act_unlocked(statistics_db, player_stats_id, required_act_unlocked)

	return is_required_act_unlocked
end
local difficulty_data_layout = {
	available = false,
	tooltip = Localize("map_confirm_button_disabled_tooltip"),
	setting_text = Localize("dlc1_2_difficulty_unavailable")
}
MapViewHelper.get_difficulty_data = function (self, level_key, level_settings)
	local statistics_db = self.statistics_db
	local player_stats_id = self.player_stats_id
	local difficulty_data = {
		table.clone(difficulty_data_layout),
		table.clone(difficulty_data_layout),
		table.clone(difficulty_data_layout),
		table.clone(difficulty_data_layout),
		table.clone(difficulty_data_layout)
	}
	local difficulties, starting_difficulty = self.difficulty_manager:get_level_difficulties(level_key)
	local difficulty_settings = DifficultySettings
	local highest_completed_difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, player_stats_id, level_key)
	local highest_completed_difficulty = highest_completed_difficulty_index and difficulties[highest_completed_difficulty_index]
	local highest_completed_difficulty_rank = highest_completed_difficulty and difficulty_settings[highest_completed_difficulty].rank
	local starting_difficulty_rank = difficulty_settings[starting_difficulty].rank
	local num_difficulties = #difficulties
	local highest_unlock_rank = (highest_completed_difficulty_rank and starting_difficulty_rank < highest_completed_difficulty_rank + 1 and math.min(highest_completed_difficulty_rank + 1, 5)) or starting_difficulty_rank

	for i = 1, num_difficulties, 1 do
		local difficulty_key = difficulties[i]
		local settings = difficulty_settings[difficulty_key]
		local rank = settings.rank
		local layout = difficulty_data[rank]
		layout.key = difficulty_key
		layout.rank = rank
		layout.unlocked = rank <= highest_unlock_rank
		layout.completed = (highest_completed_difficulty_rank and rank <= highest_completed_difficulty_rank) or false
		layout.available = true
		layout.setting_text = Localize(settings.display_name)

		if level_settings.game_mode == "survival" then
			layout.scores = self._get_survival_level_difficulty_score(self, statistics_db, level_settings, difficulty_key)
		end

		if layout.unlocked then
			layout.tooltip = nil
		else
			local previous_difficulty_key = difficulties[i - 1]
			local previous_settings = difficulty_settings[previous_difficulty_key]
			local previous_display_name = previous_settings.display_name
			local current_display_name = settings.display_name
			layout.tooltip = string.format(Localize("dlc1_2_difficulty_dynamic_tooltip"), Localize(previous_display_name), Localize(current_display_name))
		end
	end

	return difficulty_data
end
MapViewHelper.get_difficulty_data_summary = function (self, level_data_list)
	local summary_difficulty_data = {
		table.clone(difficulty_data_layout),
		table.clone(difficulty_data_layout),
		table.clone(difficulty_data_layout),
		table.clone(difficulty_data_layout),
		table.clone(difficulty_data_layout)
	}

	for level_key, level_information in pairs(level_data_list) do
		local difficulty_data = level_information.difficulty_data

		if difficulty_data then
			for rank, layout in ipairs(difficulty_data) do
				local summary_layout = summary_difficulty_data[rank]

				if not summary_layout.key then
					summary_layout.key = layout.key
					summary_layout.rank = layout.rank
					summary_layout.setting_text = layout.setting_text
				end

				local unlocked = layout.unlocked
				local summary_unlocked = summary_layout.unlocked

				if summary_unlocked == nil or (not summary_layout.unlocked and unlocked) then
					summary_layout.unlocked = unlocked
					summary_layout.tooltip = layout.tooltip
				end

				local available = layout.available
				local summary_available = summary_layout.available

				if summary_available == nil or (not summary_layout.available and available) then
					summary_layout.available = available
				end

				local completed = layout.completed
				local summary_completed = summary_layout.completed

				if summary_completed == nil or (summary_completed and not completed) then
					summary_layout.completed = completed
				end
			end
		end
	end

	return summary_difficulty_data
end
MapViewHelper._get_survival_level_difficulty_score = function (self, statistics_db, level_settings, difficulty)
	local level_id = level_settings.level_id
	local scores = {
		waves = StatisticsUtil.get_survival_stat(statistics_db, level_id, difficulty, "waves"),
		time = StatisticsUtil.get_survival_stat(statistics_db, level_id, difficulty, "time"),
		kills = StatisticsUtil.get_survival_stat(statistics_db, level_id, difficulty, "kills")
	}

	return scores
end

return 
