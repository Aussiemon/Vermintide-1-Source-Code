UnlockSettings = {
	{
		unlock_script_param = "param_dlcs",
		profile_attribute = "dlcs_unlocked",
		unlocks = {
			pre_order = {
				id = "373540",
				backend_required = true,
				class = "UnlockDlc"
			},
			alienware = {
				id = "410400",
				backend_required = true,
				class = "UnlockDlc"
			},
			drkn = {
				id = "412500",
				backend_required = true,
				class = "UnlockDlc"
			},
			logitech = {
				id = "412501",
				backend_required = true,
				class = "UnlockDlc"
			},
			humble_bundle = {
				id = "412502",
				backend_required = true,
				class = "UnlockDlc"
			},
			razer = {
				id = "412503",
				backend_required = true,
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
				backend_required = true,
				class = "UnlockClan"
			}
		},
		unlock_script = GameSettingsDevelopment.backend_settings.clan_unlock_script
	}
}

return 
