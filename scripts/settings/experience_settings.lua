local experience_levels_main = {
	300,
	550,
	600,
	650,
	700,
	750,
	800,
	850,
	900,
	1000,
	1100,
	1200,
	1300,
	1400,
	1500,
	1600,
	1700,
	1800,
	1900,
	2000,
	2100,
	2200,
	2300,
	2400,
	2500,
	2600,
	2700,
	2800,
	2900,
	3000,
	3100,
	3200,
	3300,
	3500,
	3550,
	3600,
	3650,
	3700,
	3750,
	3800,
	3850,
	3900,
	3950,
	4000,
	4050,
	4100,
	4150,
	4200,
	4250,
	4300,
	4350,
	4400,
	4450,
	4500,
	4550,
	4600,
	4650,
	4700,
	4750,
	4800,
	4850,
	4900,
	4950,
	5000
}
local experience_for_levels_after_main = 5000
local total_experience_for_main_levels = 0

for i = 1, #experience_levels_main, 1 do
	total_experience_for_main_levels = total_experience_for_main_levels + experience_levels_main[i]
end

ExperienceSettings = {
	get_player_level = function (player)
		local network_manager = Managers.state.network
		local network_game = network_manager.game(network_manager)

		if not network_game then
			return nil
		end

		local unit_storage = Managers.state.unit_storage
		local unit = player.player_unit
		local go_id = unit_storage.go_id(unit_storage, unit)

		if not go_id then
			return nil
		end

		local level = GameSession.game_object_field(network_game, go_id, "level")

		return level
	end,
	get_experience = function ()
		return ScriptBackendProfileAttribute.get("experience")
	end,
	get_level = function (experience)
		assert(0 <= experience, "Negative XP!??")

		local exp_total = 0
		local level = 0
		local progress = 0
		local experience_into_level = 0
		local num_defined_experience_levels = #experience_levels_main
		local previous_exp_total = 0

		if experience < total_experience_for_main_levels then
			for i = 1, num_defined_experience_levels, 1 do
				previous_exp_total = exp_total
				exp_total = exp_total + experience_levels_main[i]

				if experience < exp_total then
					level = i - 1
					experience_into_level = experience - previous_exp_total
					progress = experience_into_level / experience_levels_main[i]

					break
				end
			end
		else
			local after_main_level_experience = experience - total_experience_for_main_levels
			experience_into_level = after_main_level_experience % experience_for_levels_after_main
			level = num_defined_experience_levels + math.floor(after_main_level_experience / experience_for_levels_after_main)
			progress = experience_into_level / experience_for_levels_after_main
		end

		return level, progress, experience_into_level
	end,
	get_experience_required_for_level = function (level)
		local experience = 0

		if level <= #experience_levels_main then
			experience = experience_levels_main[level]
		else
			experience = experience_for_levels_after_main
		end

		return experience
	end,
	max_experience = 2000,
	multiplier = 1,
	level_length_experience_multiplier = {
		short = 0.5,
		long = 1
	}
}

return 
