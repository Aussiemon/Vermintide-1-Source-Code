require("scripts/utils/script_application")

BackendSettings = BackendSettings or {}
local build = BUILD
local allow_local = build == "dev" or build == "debug"
local platform = PLATFORM

if platform == "ps4" then
	allow_local = false
elseif platform == "xb1" then
	allow_local = false
end

BackendSettings.main = {
	qnc_get_state_script = "qnc_get_state_3",
	pray_for_loot_script = "pray_for_loot_script_3",
	enable_sessions = false,
	startup_script = "script_startup_2",
	dlcs_unlock_script = "dlc_unlock_script_2",
	upgrades_failed_script = "levelling_script_4",
	real_quests = true,
	title_id = 1001,
	clan_unlock_script = "clan_unlock_script_2",
	allow_local = false,
	quests_enabled = true,
	forge_script = "fuse_script_5",
	dice_script = "dice_script_6",
	environment = rawget(_G, "Backend") and Backend.ENV_PROD
}
BackendSettings.beta = {
	qnc_get_state_script = "qnc_get_state_2",
	pray_for_loot_script = "pray_for_loot_script_2",
	enable_sessions = false,
	startup_script = "script_startup_2",
	dlcs_unlock_script = "dlc_unlock_script_2",
	upgrades_failed_script = "levelling_script_4",
	real_quests = false,
	title_id = 1002,
	clan_unlock_script = "clan_unlock_script_2",
	allow_local = false,
	quests_enabled = false,
	forge_script = "fuse_script_4",
	dice_script = "dice_script_5",
	environment = rawget(_G, "Backend") and Backend.ENV_DEV
}
BackendSettings.beta2 = {
	qnc_get_state_script = "qnc_get_state_3",
	allow_tutorial = false,
	pray_for_loot_script = "pray_for_loot_script_3",
	startup_script = "script_startup_2",
	dlcs_unlock_script = "dlc_unlock_script_2",
	upgrades_failed_script = "levelling_script_4",
	real_quests = true,
	title_id = 1004,
	clan_unlock_script = "clan_unlock_script_2",
	allow_local = true,
	quests_enabled = true,
	enable_sessions = false,
	forge_script = "fuse_script_5",
	dice_script = "dice_script_6",
	environment = rawget(_G, "Backend") and Backend.ENV_STAGE
}
BackendSettings.ps4 = {
	qnc_get_state_script = "qnc_get_state_2",
	pray_for_loot_script = "pray_for_loot_script_2",
	allow_tutorial = true,
	enable_sessions = false,
	startup_script = "script_startup_2",
	dlcs_unlock_script = "dlc_unlock_script_3",
	upgrades_failed_script = "levelling_script_4",
	real_quests = true,
	title_id = 1003,
	quests_enabled = true,
	forge_script = "fuse_script_4",
	dice_script = "dice_script_5",
	allow_local = allow_local
}
BackendSettings.xb1 = {
	qnc_get_state_script = "qnc_get_state_2",
	allow_tutorial = true,
	pray_for_loot_script = "pray_for_loot_script_2",
	startup_script = "script_startup_2",
	dlcs_unlock_script = "dlc_unlock_script_2",
	upgrades_failed_script = "levelling_script_4",
	real_quests = true,
	title_id = 3001,
	quests_enabled = true,
	enable_sessions = false,
	forge_script = "fuse_script_4",
	dice_script = "dice_script_5",
	environment = rawget(_G, "Backend") and (((build == "dev" or build == "debug") and Backend.ENV_STAGE) or Backend.ENV_PROD),
	allow_local = allow_local
}
BackendSettings.robin = {
	qnc_get_state_script = "qnc_get_state_2",
	allow_tutorial = false,
	pray_for_loot_script = "pray_for_loot_script_2",
	startup_script = "script_startup_2",
	dlcs_unlock_script = "dlc_unlock_script_2",
	upgrades_failed_script = "levelling_script_4",
	real_quests = true,
	title_id = 1103,
	clan_unlock_script = "clan_unlock_script_2",
	allow_local = true,
	quests_enabled = true,
	enable_sessions = false,
	forge_script = "fuse_script_4",
	dice_script = "dice_script_5",
	environment = rawget(_G, "Backend") and Backend.ENV_DEV
}

for k, v in pairs(BackendSettings) do
	v.name = k
end

return
