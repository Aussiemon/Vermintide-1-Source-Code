local progression_unlocks = {
	forge = {
		description = "unlock_forge",
		icon = "forge_unlocked_icon",
		level_requirement = 1,
		disabled = GameSettingsDevelopment.disable_crafting
	},
	altar = {
		description = "dlc1_1_unlock_altar",
		backend_item = true,
		icon = "altar_unlocked_icon",
		level_requirement = 5,
		disabled = GameSettingsDevelopment.disable_crafting
	},
	slot_trinket_2 = {
		description = "unlock_trinket_slot_2",
		icon = "trinket_slot_unlocked_icon",
		level_requirement = 15
	},
	slot_trinket_3 = {
		description = "unlock_trinket_slot_3",
		icon = "trinket_slot_unlocked_icon",
		level_requirement = 30
	},
	quests = {
		description = "dlc1_3_1_quest_board_title",
		icon = "quest_board_unlocked_icon",
		disabled = GameSettingsDevelopment.backend_settings.quests_enabled
	}
}

for unlock_name, template in pairs(progression_unlocks) do
	template.name = unlock_name
end

local profile_unlocks = {}

for unlock_name, template in pairs(progression_unlocks) do
	local profile = template.profile

	if profile ~= nil then
		if profile_unlocks[profile] == nil then
			profile_unlocks[profile] = {}
		end

		profile_unlocks[profile][template.base_name] = template
	end
end

ProgressionUnlocks = {
	all_unlocks_for_debug = progression_unlocks,
	get_unlock = function (unlock_name)
		local template = progression_unlocks[unlock_name]

		return template
	end,
	is_unlocked = function (unlock_name, level)
		local template = progression_unlocks[unlock_name]

		fassert(template, "[ProgressionUnlocks] no template named %q", tostring(unlock_name))

		if not template.disabled and template.level_requirement <= level then
			return true
		end

		return 
	end,
	get_level_unlock = function (level)
		local result_template = nil

		for unlock_name, template in pairs(progression_unlocks) do
			if template.level_requirement == level and not template.disabled then
				assert(result_template == nil, "Two or more progession unlocks have the same prerequisites. (%s and %s)", (result_template and result_template.name) or "wtf", unlock_name)

				result_template = template
			end
		end

		return result_template
	end,
	is_unlocked_for_profile = function (unlock_name, profile, level)
		local profile_templates = profile_unlocks[profile]

		assert(profile_templates, "No unlocks found for profile %s", profile)

		local template = profile_templates[unlock_name]

		if template == nil then
			return true
		end

		if template.level_requirement <= level then
			return true
		end

		return 
	end,
	get_quests_unlocked = function (level_key)
		local level_settings = LevelSettings[level_key]

		if level_settings.dlc_name then
			return 
		end

		local statistics_db = Managers.player:statistics_db()
		local player = Managers.player:local_player()
		local stats_id = player.stats_id(player)
		local quests_unlocked = true

		for _, act_levels in pairs(GameActs) do
			local num_act_levels = #act_levels

			for i = 1, num_act_levels, 1 do
				local act_level_key = act_levels[i]
				local completed_times = statistics_db.get_persistent_stat(statistics_db, stats_id, "completed_levels", act_level_key)

				if completed_times == 0 or (level_key == act_level_key and 1 < completed_times) then
					quests_unlocked = false

					break
				end
			end

			if not quests_unlocked then
				break
			end
		end

		if quests_unlocked then
			return progression_unlocks.quests
		end

		return 
	end
}
ProgressionUnlocks.can_upgrade_prestige = function ()
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local can_unlock = ProgressionUnlocks.is_unlocked("prestige", level, prestige)

	return can_unlock
end
ProgressionUnlocks.upgrade_prestige = function ()
	local can_unlock = ProgressionUnlocks.can_upgrade_prestige()

	fassert(can_unlock, "Trying to upgrade prestige although requirements are not met")

	local prestige = ScriptBackendProfileAttribute.get("prestige")

	ScriptBackendProfileAttribute.set("prestige", prestige + 1)
	ScriptBackendProfileAttribute.set("experience", 0)

	return 
end
ProgressionUnlocks.get_prestige_level = function ()
	return ScriptBackendProfileAttribute.get("prestige")
end
local DO_DEBUG_PRINT = false
local NUM_LEVELS = 40
local NUM_PRESTIGE_LEVELS = 5

for prestige_level = 0, NUM_PRESTIGE_LEVELS, 1 do
	for level = 1, NUM_LEVELS, 1 do
		local template = ProgressionUnlocks.get_level_unlock(level, prestige_level)

		if template then
			assert(ProgressionUnlocks.is_unlocked(template.name, level, prestige_level))

			if DO_DEBUG_PRINT then
				if template.profile then
					assert(ProgressionUnlocks.is_unlocked_for_profile(template.name, template.profile, level, prestige_level))
					printf("At prestige %d and level %2d we unlock %-20s for %s", prestige_level, level, template.name, template.profile)
				else
					printf("At prestige %d and level %2d we unlock %-20s", prestige_level, level, template.name)
				end
			end
		end
	end
end

return 
