DifficultySettings = DifficultySettings or {}
DifficultySettings.easy = {
	amount_storm_vermin_patrol = 6,
	friendly_fire_melee = false,
	allow_respawns = true,
	display_name = "difficulty_easy",
	slot_healthkit = "healthkit_first_aid_kit_01",
	slot_potion = "potion_damage_boost_01",
	rank = 1,
	max_hp = 150,
	friendly_fire_ranged = false,
	wounds = math.huge,
	respawn = {
		ammo_melee = 0.5,
		damage = 75,
		ammo_ranged = 0.5
	},
	level_failed_reward = {
		token_type = "iron_tokens",
		token_amount = 8
	},
	intensity_overrides = {
		intensity_add_per_percent_dmg_taken = 3
	},
	pacing_overrides = {
		peak_intensity_threshold = 35
	}
}
DifficultySettings.normal = {
	amount_storm_vermin_patrol = 6,
	friendly_fire_melee = false,
	display_name = "difficulty_normal",
	allow_respawns = true,
	slot_healthkit = "potion_healing_draught_01",
	rank = 2,
	max_hp = 150,
	friendly_fire_ranged = false,
	wounds = 5,
	respawn = {
		ammo_melee = 0.5,
		damage = 75,
		ammo_ranged = 0.5
	},
	level_failed_reward = {
		token_type = "iron_tokens",
		token_amount = 8
	}
}
DifficultySettings.hard = {
	amount_storm_vermin_patrol = 8,
	display_name = "difficulty_hard",
	allow_respawns = true,
	friendly_fire_melee = false,
	rank = 3,
	max_hp = 150,
	friendly_fire_ranged = false,
	wounds = 3,
	respawn = {
		ammo_melee = 0.5,
		damage = 75,
		ammo_ranged = 0.5
	},
	level_failed_reward = {
		token_type = "bronze_tokens",
		token_amount = 8
	},
	intensity_overrides = {
		intensity_add_per_percent_dmg_taken = 0.8
	},
	pacing_overrides = {
		peak_intensity_threshold = 40
	}
}
DifficultySettings.survival_hard = table.clone(DifficultySettings.hard)
DifficultySettings.survival_hard.display_name = "dlc1_2_difficulty_survival_hard"
DifficultySettings.harder = {
	amount_storm_vermin_patrol = 8,
	display_name = "difficulty_harder",
	allow_respawns = true,
	friendly_fire_melee = false,
	rank = 4,
	max_hp = 150,
	friendly_fire_ranged = true,
	wounds = 2,
	respawn = {
		ammo_melee = 0.5,
		damage = 75,
		ammo_ranged = 0.5
	},
	level_failed_reward = {
		token_type = "bronze_tokens",
		token_amount = 8
	},
	intensity_overrides = {
		intensity_add_per_percent_dmg_taken = 0.7
	},
	pacing_overrides = {
		peak_intensity_threshold = 50
	}
}
DifficultySettings.survival_harder = table.clone(DifficultySettings.harder)
DifficultySettings.survival_harder.friendly_fire_ranged = false
DifficultySettings.survival_harder.display_name = "dlc1_2_difficulty_survival_harder"
DifficultySettings.hardest = {
	amount_storm_vermin_patrol = 10,
	display_name = "difficulty_hardest",
	allow_respawns = true,
	friendly_fire_melee = false,
	rank = 5,
	max_hp = 100,
	friendly_fire_ranged = true,
	wounds = 2,
	respawn = {
		ammo_melee = 0.5,
		damage = 75,
		ammo_ranged = 0.5
	},
	level_failed_reward = {
		token_type = "silver_tokens",
		token_amount = 8
	},
	intensity_overrides = {
		intensity_add_per_percent_dmg_taken = 0.5
	},
	pacing_overrides = {
		peak_intensity_threshold = 70
	}
}
DifficultySettings.survival_hardest = table.clone(DifficultySettings.hardest)
DifficultySettings.survival_hardest.max_hp = 150
DifficultySettings.survival_hardest.friendly_fire_ranged = false
DifficultySettings.survival_hardest.display_name = "dlc1_2_difficulty_survival_hardest"
DifficultyRanks = {}

for _, settings in pairs(DifficultySettings) do
	DifficultyRanks[#DifficultyRanks + 1] = settings.rank
end

Difficulties = {
	"easy",
	"normal",
	"hard",
	"harder",
	"hardest",
	"survival_hard",
	"survival_harder",
	"survival_hardest"
}
DefaultDifficulties = {
	"easy",
	"normal",
	"hard",
	"harder",
	"hardest"
}
SurvivalDifficulties = {
	"survival_hard",
	"survival_harder",
	"survival_hardest"
}
DefaultStartingDifficulty = "hard"
SurvivalStartWaveByDifficulty = {
	survival_harder = 13,
	survival_hardest = 26,
	survival_hard = 0
}
SurvivalDifficultyByStartWave = {}

for difficulty, wave in pairs(SurvivalStartWaveByDifficulty) do
	SurvivalDifficultyByStartWave[wave] = difficulty
end

SurvivalEndWaveByDifficulty = {
	survival_harder = 26,
	survival_hardest = 39,
	survival_hard = 13
}

return 
