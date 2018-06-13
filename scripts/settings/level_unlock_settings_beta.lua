DefaultVariant = "VARIANT1"
SelectedBetaLevelSettingsVariant = "VARIANT2"

if SelectedBetaLevelSettingsVariant == "VARIANT1" then
	GameActs = {
		prologue = {
			"magnus"
		},
		act_1 = {
			"sewers_short",
			"merchant"
		}
	}
	LevelUnlockOrder = {
		GameActs.prologue,
		GameActs.act_1
	}
	UnlockableLevels = {
		"magnus",
		"sewers_short",
		"merchant"
	}
	GameActsOrder = {
		"prologue",
		"act_1"
	}
end

if SelectedBetaLevelSettingsVariant == "VARIANT2" then
	GameActs = {
		prologue = {
			"magnus"
		},
		act_1 = {
			"city_wall",
			"forest_ambush"
		}
	}
	LevelUnlockOrder = {
		GameActs.prologue,
		GameActs.act_1
	}
	UnlockableLevels = {
		"magnus",
		"forest_ambush",
		"city_wall"
	}
	GameActsOrder = {
		"prologue",
		"act_1"
	}
end

if SelectedBetaLevelSettingsVariant == "VARIANT3" then
	GameActs = {
		prologue = {
			"magnus"
		},
		act_1 = {
			"city_wall",
			"forest_ambush"
		}
	}
	LevelUnlockOrder = {
		GameActs.prologue,
		GameActs.act_1
	}
	UnlockableLevels = {
		"magnus",
		"forest_ambush",
		"city_wall"
	}
	GameActsOrder = {
		"prologue",
		"act_1"
	}
end

if SelectedBetaLevelSettingsVariant == "VARIANT4" then
	GameActs = {
		prologue = {
			"magnus"
		},
		act_1 = {
			"merchant",
			"sewers_short",
			"wizard",
			"bridge"
		},
		act_2 = {
			"forest_ambush",
			"city_wall",
			"cemetery",
			"farm"
		},
		act_3 = {
			"tunnels",
			"courtyard_level",
			"docks_short_level"
		},
		act_4 = {
			"end_boss"
		}
	}
	LevelUnlockOrder = {
		GameActs.prologue,
		GameActs.act_1,
		GameActs.act_2,
		GameActs.act_3,
		GameActs.act_4
	}
	UnlockableLevels = {
		"magnus",
		"merchant",
		"wizard",
		"forest_ambush",
		"cemetery",
		"tunnels",
		"end_boss",
		"sewers_short",
		"bridge",
		"city_wall",
		"farm",
		"courtyard_level",
		"docks_short_level",
		"dlc_survival_ruins",
		"dlc_survival_magnus"
	}
	GameActsOrder = {
		"prologue",
		"act_1",
		"act_2",
		"act_3",
		"act_4"
	}
end

return
