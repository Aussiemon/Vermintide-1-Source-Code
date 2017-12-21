require("scripts/utils/script_application")

BackendSettings = BackendSettings or {}
local build = Application.build()
local allow_local = build == "dev" or build == "debug"
BackendSettings.main = {
	quests_enabled = true,
	enable_sessions = false,
	pray_for_loot_script = "pray_for_loot_script_2",
	dlcs_unlock_script = "dlc_unlock_script_2",
	upgrades_failed_script = "levelling_script_4",
	real_quests = true,
	title_id = 1001,
	clan_unlock_script = "clan_unlock_script_2",
	allow_local = false,
	forge_script = "fuse_script_4",
	dice_script = "dice_script_5",
	environment = rawget(_G, "Backend") and Backend.ENV_PROD
}
BackendSettings.beta = {
	quests_enabled = true,
	enable_sessions = false,
	pray_for_loot_script = "pray_for_loot_script_2",
	dlcs_unlock_script = "dlc_unlock_script_2",
	upgrades_failed_script = "levelling_script_4",
	real_quests = true,
	title_id = 1002,
	clan_unlock_script = "clan_unlock_script_2",
	allow_local = false,
	forge_script = "fuse_script_4",
	dice_script = "dice_script_5",
	environment = rawget(_G, "Backend") and Backend.ENV_DEV
}
BackendSettings.beta2 = {
	quests_enabled = true,
	enable_sessions = false,
	pray_for_loot_script = "pray_for_loot_script_2",
	dlcs_unlock_script = "dlc_unlock_script_2",
	upgrades_failed_script = "levelling_script_4",
	real_quests = true,
	title_id = 1004,
	clan_unlock_script = "clan_unlock_script_2",
	forge_script = "fuse_script_4",
	dice_script = "dice_script_5",
	environment = rawget(_G, "Backend") and Backend.ENV_STAGE,
	allow_local = not ScriptApplication.is_bundled() and allow_local
}
BackendSettings.ps4 = {
	title_id = 1003,
	pray_for_loot_script = "pray_for_loot_script_1003_2",
	dlcs_unlock_script = "dlc_unlock_script_1003_2",
	upgrades_failed_script = "levelling_script_1003_4",
	real_quests = false,
	enable_sessions = false,
	forge_script = "fuse_script_1003_4",
	dice_script = "dice_script_1003_5",
	allow_local = allow_local
}
BackendSettings.xb1 = {
	title_id = 3001,
	pray_for_loot_script = "pray_for_loot_script_1003_2",
	dlcs_unlock_script = "dlc_unlock_script_1003_2",
	upgrades_failed_script = "levelling_script_1003_4",
	real_quests = false,
	enable_sessions = false,
	forge_script = "fuse_script_1003_4",
	dice_script = "dice_script_1003_5",
	allow_local = allow_local
}

return 
