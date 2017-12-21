LeaderboardSettings = {}

if Application.platform() == "win32" and rawget(_G, "Leaderboard") then
	LeaderboardSettings.template = {
		Leaderboard.INT(32),
		Leaderboard.INT(32),
		Leaderboard.INT(32),
		Leaderboard.INT(32),
		Leaderboard.INT(32),
		Leaderboard.INT(32),
		Leaderboard.INT(32)
	}
	LeaderboardSettings.data_setup = {
		"INT",
		"INT",
		"INT",
		"INT",
		"INT",
		"INT",
		"INT"
	}
	LeaderboardSettings.leaderboards = {
		"dlc_survival_magnus_bright_wizard",
		"dlc_survival_magnus_dwarf_ranger",
		"dlc_survival_magnus_empire_soldier",
		"dlc_survival_magnus_overall",
		"dlc_survival_magnus_witch_hunter",
		"dlc_survival_magnus_wood_elf",
		"dlc_survival_ruins_bright_wizard",
		"dlc_survival_ruins_dwarf_ranger",
		"dlc_survival_ruins_empire_soldier",
		"dlc_survival_ruins_overall",
		"dlc_survival_ruins_witch_hunter",
		"dlc_survival_ruins_wood_elf"
	}
elseif Application.platform() == "xb1" then
	LeaderboardSettings.xdp_leaderboard_stats = {
		dlc_survival_ruins_bright_wizard = "LBRuinsBrightScore",
		dlc_survival_ruins_empire_soldier = "LBRuinsEmpireScore",
		dlc_survival_ruins_wood_elf = "LBRuinsWoodScore",
		dlc_survival_magnus_empire_soldier = "LBMagnusEmpireScore",
		dlc_survival_ruins_witch_hunter = "LBRuinsWitchScore",
		dlc_survival_magnus_dwarf_ranger = "LBMagnusDwarfScore",
		dlc_survival_magnus_bright_wizard = "LBMagnusBrightScore",
		dlc_survival_magnus_witch_hunter = "LBMagnusWitchScore",
		dlc_survival_magnus_wood_elf = "LBMagnusWoodScore",
		dlc_survival_ruins_dwarf_ranger = "LBRuinsDwarfScore"
	}
	LeaderboardSettings.xdp_leaderboard_name = {
		dlc_survival_ruins_bright_wizard = "LBRuinsBright",
		dlc_survival_ruins_empire_soldier = "LBRuinsEmpire",
		dlc_survival_ruins_wood_elf = "LBRuinsWood",
		dlc_survival_magnus_empire_soldier = "LBMagnusEmpire",
		dlc_survival_ruins_witch_hunter = "LBRuinsWitch",
		dlc_survival_magnus_dwarf_ranger = "LBMagnusDwarf",
		dlc_survival_magnus_bright_wizard = "LBMagnusBright",
		dlc_survival_magnus_witch_hunter = "LBMagnusWitch",
		dlc_survival_magnus_wood_elf = "LBMagnusWood",
		dlc_survival_ruins_dwarf_ranger = "LBRuinsDwarf"
	}
	LeaderboardSettings.template = {
		"Slave",
		"Clan",
		"Storm",
		"Special",
		"Ogre",
		"Waves",
		"Time"
	}
end

LeaderboardSettings.characters = {
	"witch_hunter",
	"bright_wizard",
	"dwarf_ranger",
	"wood_elf",
	"empire_soldier"
}

return 
