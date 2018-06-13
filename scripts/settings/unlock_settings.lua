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
				id = "437070",
				purchase_type = "dlc",
				class = "UnlockDlc",
				index = 1
			},
			drachenfels = {
				id = "453280",
				purchase_type = "dlc",
				class = "UnlockDlc",
				index = 2
			},
			dwarfs = {
				id = "463791",
				purchase_type = "dlc",
				class = "UnlockDlc",
				index = 3
			},
			witch_hunter_skin_01 = {
				id = "463790",
				purchase_type = "skin",
				class = "UnlockDlc",
				index = 1
			},
			bright_wizard_skin_01 = {
				id = "463796",
				purchase_type = "skin",
				class = "UnlockDlc",
				index = 2
			},
			dwarf_ranger_skin_01 = {
				id = "463799",
				purchase_type = "skin",
				class = "UnlockDlc",
				index = 3
			},
			wood_elf_skin_01 = {
				id = "463798",
				purchase_type = "skin",
				class = "UnlockDlc",
				index = 4
			},
			empire_soldier_skin_01 = {
				id = "463797",
				purchase_type = "skin",
				class = "UnlockDlc",
				index = 5
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

CommunityUnlocks = {}
GrantDlcSettings = {
	grants = {
		owns_vermintide_two = {
			grant_unlock = "reikwald",
			use_fallback = true,
			class = "GrantDlcFromOwnership",
			host_address = "http://backup01.i.fatshark.se:8080",
			app_id_to_check = "552500"
		}
	}
}

return
