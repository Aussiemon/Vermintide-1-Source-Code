UnlockSettings = {
	{
		unlock_script_param = "param_dlcs",
		profile_attribute = "dlcs_unlocked",
		unlocks = {
			pre_order = {
				id = "373540",
				backend_id = "373540",
				class = "UnlockDlc"
			},
			alienware = {
				id = "410400",
				backend_id = "410400",
				class = "UnlockDlc"
			},
			drkn = {
				id = "412500",
				backend_id = "412500",
				class = "UnlockDlc"
			},
			logitech = {
				id = "412501",
				backend_id = "412501",
				class = "UnlockDlc"
			},
			humble_bundle = {
				id = "412502",
				backend_id = "412502",
				class = "UnlockDlc"
			},
			razer = {
				id = "412503",
				backend_id = "412503",
				class = "UnlockDlc"
			},
			hero_trinkets = {
				class = "AlwaysUnlocked"
			},
			survival_ruins = {
				class = "UnlockDlc",
				id = "437070"
			},
			drachenfels = {
				class = "UnlockDlc",
				id = "453280"
			},
			dwarfs = {
				class = "UnlockDlc",
				id = "463791"
			}
		},
		unlock_script = GameSettingsDevelopment.backend_settings.dlcs_unlock_script
	},
	{
		unlock_script_param = "param_clans",
		profile_attribute = "clans_unlocked",
		unlocks = {
			official_vermintide_group = {
				id = "1700000004637f6",
				backend_id = "1700000004637f6",
				class = "UnlockClan"
			}
		},
		unlock_script = GameSettingsDevelopment.backend_settings.clan_unlock_script
	}
}

for _, dlc in pairs(DLCSettings) do
	local unlocks = dlc.unlock_settings

	if unlocks then
		for key, value in pairs(unlocks) do
			UnlockSettings[1].unlocks[key] = value
		end
	end
end

return 
