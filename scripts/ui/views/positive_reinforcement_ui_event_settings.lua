return {
	save = {
		text_function = function (amount, player_1_name, player_2_name)
			if 1 < amount then
				return string.format(Localize("positive_reinforcement_player_saved_player_multiple"), player_1_name, player_2_name, amount)
			else
				return string.format(Localize("positive_reinforcement_player_saved_player"), player_1_name, player_2_name)
			end

			return 
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	heal = {
		text_function = function (amount, player_1_name, player_2_name)
			if 1 < amount then
				return string.format(Localize("positive_reinforcement_player_healed_player_multiple"), player_1_name, player_2_name, amount)
			else
				return string.format(Localize("positive_reinforcement_player_healed_player"), player_1_name, player_2_name)
			end

			return 
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	revive = {
		text_function = function (amount, player_1_name, player_2_name)
			if 1 < amount then
				return string.format(Localize("positive_reinforcement_player_revived_player_multiple"), player_1_name, player_2_name, amount)
			else
				return string.format(Localize("positive_reinforcement_player_revived_player"), player_1_name, player_2_name)
			end

			return 
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	assisted_respawn = {
		text_function = function (amount, player_1_name, player_2_name)
			if 1 < amount then
				return string.format(Localize("positive_reinforcement_player_rescued_player_multiple"), player_1_name, player_2_name, amount)
			else
				return string.format(Localize("positive_reinforcement_player_rescued_player"), player_1_name, player_2_name)
			end

			return 
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	aid = {
		text_function = function (amount, player_1_name, player_2_name)
			if 1 < amount then
				return string.format(Localize("positive_reinforcement_player_aided_player_multiple"), player_1_name, player_2_name, amount)
			else
				return string.format(Localize("positive_reinforcement_player_aided_player"), player_1_name, player_2_name)
			end

			return 
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	give_item = {
		text_function = function (amount, player_1_name, player_2_name)
			if 1 < amount then
				return string.format(Localize("positive_reinforcement_player_gave_item_player_multiple"), player_1_name, player_2_name, amount)
			else
				return string.format(Localize("positive_reinforcement_player_gave_item_player"), player_1_name, player_2_name)
			end

			return 
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	picked_up_loot_dice = {
		text_function = function (amount, player_name)
			if 1 < amount then
				return string.format(Localize("positive_reinforcement_player_picked_up_loot_dice_multiple"), player_name, amount)
			else
				return string.format(Localize("positive_reinforcement_player_picked_up_loot_dice"), player_name)
			end

			return 
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	picked_up_grimoire = {
		text_function = function (amount, player_name)
			return string.format(Localize("positive_reinforcement_player_picked_up_grimoire"), player_name)
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	picked_up_tome = {
		text_function = function (amount, player_name)
			return string.format(Localize("positive_reinforcement_player_picked_up_tome"), player_name)
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	discarded_grimoire = {
		text_function = function (amount, player_name)
			return string.format(Localize("positive_reinforcement_player_discarded_grimoire"), player_name)
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	discarded_tome = {
		text_function = function (amount, player_name)
			return string.format(Localize("positive_reinforcement_player_discarded_tome"), player_name)
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	killed_special = {
		text_function = function (amount, player_name, breed_name)
			if 1 < amount then
				return string.format(Localize("positive_reinforcement_player_killed_special_multiple"), player_name, Localize(breed_name), amount)
			else
				return string.format(Localize("positive_reinforcement_player_killed_special"), player_name, Localize(breed_name))
			end

			return 
		end,
		sound_function = function ()
			return nil
		end,
		icon_function = function ()
			return nil
		end
	},
	picked_up_endurance_badge = {
		text_function = function (amount, player_name)
			if 1 < amount then
				return string.format(Localize("dlc1_2_positive_reinforcement_player_picked_up_endurance_badge_multiple"), player_name, amount)
			else
				return string.format(Localize("dlc1_2_positive_reinforcement_player_picked_up_endurance_badge"), player_name)
			end

			return 
		end,
		sound_function = function ()
			return script_data.reinforcement_ui_local_sound or "hud_achievement_unlock_02" or (script_data.enable_reinforcement_ui_remote_sound and "hud_info")
		end,
		icon_function = function ()
			return nil
		end
	},
	picked_up_lorebook_page = {
		text_function = function (amount, page_title)
			return string.format(Localize("dlc1_3_positive_reinforcement_picked_up_lorebook_page"), Localize(page_title))
		end,
		sound_function = function ()
			return "Play_hud_lorebook_unlock_page"
		end,
		icon_function = function ()
			return "icon_lore_page"
		end
	},
	interaction_warning = {
		text_function = function (amount, localized_text)
			return localized_text
		end,
		sound_function = function ()
			return nil
		end,
		icon_function = function ()
			return nil
		end
	}
}
