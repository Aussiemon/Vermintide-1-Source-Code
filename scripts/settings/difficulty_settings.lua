DifficultySettings = DifficultySettings or {}
DifficultySettings.easy = {
	amount_storm_vermin_patrol = 6,
	friendly_fire_melee = false,
	allow_respawns = true,
	friendly_fire_ranged = false,
	display_name = "difficulty_easy",
	rank = 1,
	stagger_modifier = 1,
	slot_healthkit = "healthkit_first_aid_kit_01",
	slot_potion = "potion_damage_boost_01",
	max_hp = 150,
	attack_intensity_threshold = 3,
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
	},
	map_screen_textures = {
		top = "difficulty_banner_holder_01",
		banner = "gamepad_difficulty_banner_1"
	}
}
DifficultySettings.normal = {
	amount_storm_vermin_patrol = 6,
	friendly_fire_melee = false,
	friendly_fire_ranged = false,
	allow_respawns = true,
	slot_healthkit = "potion_healing_draught_01",
	stagger_modifier = 1,
	display_name = "difficulty_normal",
	rank = 2,
	max_hp = 150,
	attack_intensity_threshold = 4,
	wounds = 5,
	respawn = {
		ammo_melee = 0.5,
		damage = 75,
		ammo_ranged = 0.5
	},
	level_failed_reward = {
		token_type = "iron_tokens",
		token_amount = 8
	},
	map_screen_textures = {
		top = "difficulty_banner_holder_02",
		banner = "gamepad_difficulty_banner_2"
	}
}
DifficultySettings.hard = {
	amount_storm_vermin_patrol = 10,
	friendly_fire_melee = false,
	allow_respawns = true,
	stagger_modifier = 0.9,
	display_name = "difficulty_hard",
	friendly_fire_ranged = false,
	rank = 3,
	max_hp = 150,
	attack_intensity_threshold = 6,
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
	},
	map_screen_textures = {
		top = "difficulty_banner_holder_03",
		banner = "gamepad_difficulty_banner_3"
	}
}
DifficultySettings.survival_hard = table.clone(DifficultySettings.hard)
DifficultySettings.survival_hard.display_name = "dlc1_2_difficulty_survival_hard"
DifficultySettings.harder = {
	amount_storm_vermin_patrol = 14,
	friendly_fire_melee = false,
	allow_respawns = true,
	stagger_modifier = 0.8,
	display_name = "difficulty_harder",
	friendly_fire_ranged = true,
	rank = 4,
	max_hp = 150,
	attack_intensity_threshold = 8,
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
	},
	map_screen_textures = {
		top = "difficulty_banner_holder_04",
		banner = "gamepad_difficulty_banner_4"
	}
}
DifficultySettings.survival_harder = table.clone(DifficultySettings.harder)
DifficultySettings.survival_harder.friendly_fire_ranged = false
DifficultySettings.survival_harder.display_name = "dlc1_2_difficulty_survival_harder"
DifficultySettings.hardest = {
	amount_storm_vermin_patrol = 20,
	friendly_fire_melee = false,
	allow_respawns = true,
	stagger_modifier = 0.6,
	display_name = "difficulty_hardest",
	friendly_fire_ranged = true,
	rank = 5,
	max_hp = 100,
	attack_intensity_threshold = 10,
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
	},
	map_screen_textures = {
		top = "difficulty_banner_holder_05",
		banner = "gamepad_difficulty_banner_5"
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
DefaultQuickPlayStartingDifficulty = "normal"
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
