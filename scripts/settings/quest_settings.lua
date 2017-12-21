QuestSettings = {
	MAX_NUMBER_OF_POPUP_QUEST_LINKS_PER_ROW = 10,
	PREPARE_MENU_FOR_SYNC_DURATION = 8,
	quest_icon_unknown_fallback = "level_location_long_icon_01_quest_screen",
	MAX_NUMBER_OF_BOARD_CONTRACTS = 2,
	NUMBER_OF_SEAL_VARIATIONS_BG = 4,
	EXPIRE_CHECK_MARGIN = 5,
	MAX_NUMBER_OF_LOG_QUESTS = 1,
	LOG_CONTRACTS_HEIGHT_SPACING = 3,
	MAX_NUMBER_OF_BOARD_PAGES = 3,
	EXPIRE_CHECK_COOLDOWN = 45,
	MAX_NUMBER_OF_LOG_CONTRACTS = 3,
	MAX_NUMBER_OF_BOARD_QUESTS = 1,
	QUEST_LOG_WIDGET_SIZE = {
		369,
		191
	},
	CONTRACT_LOG_WIDGET_SIZE = {
		390,
		215
	},
	BOARD_CONTRACT_SIZE = {
		274,
		300
	},
	BOARD_CONTRACT_CANVAS_SIZE = {
		232,
		265
	},
	POPUP_BACKGROUND_SIZE = {
		781,
		904
	},
	STATUS_MESSAGES = {
		not_found = "not_found",
		requirements_not_met = "requirements_not_met",
		already_turned_in = "already_turned_in",
		success = "success",
		requirements_already_met = "requirements_already_met",
		not_active = "not_active"
	},
	task_type_titles = {
		tome = {
			"dlc1_3_1_task_title_tome_01"
		},
		grimoire = {
			"dlc1_3_1_task_title_grim_01"
		},
		ogre = {
			"dlc1_3_1_task_title_ogre_01"
		},
		level = {
			"dlc1_3_1_task_title_level_01"
		},
		unknown = {
			"dlc1_3_1_task_title_unknown"
		}
	},
	task_type_requirement_text = {
		tome = {
			"dlc1_3_1_task_requirement_tome_01"
		},
		grimoire = {
			"dlc1_3_1_task_requirement_grim_01"
		},
		ogre = {
			"dlc1_3_1_task_requirement_ogre_01"
		},
		level = {
			"dlc1_3_1_task_requirement_level_01"
		},
		quest = {
			"dlc1_3_1_task_requirement_key_01"
		},
		unknown = {
			"qnc_task_requirement_unknown"
		}
	},
	detailed_task_type_requirement_text = {},
	task_type_to_icon_lookup = {
		unknown = "quest_icon_map",
		tome = "quest_icon_tome",
		ogre = "quest_icon_rat_ogre",
		grimoire = "quest_icon_grimoire",
		level = "quest_icon_map"
	},
	task_type_to_name_lookup = {
		unknown = "dlc1_3_1_unknown",
		tome = "dlc1_3_1_tomes",
		ogre = "dlc1_3_1_rat_ogres",
		grimoire = "dlc1_3_1_grimoires",
		level = "dlc1_3_1_complete_level"
	},
	task_type_to_task_description_lookup = {
		unknown = "dlc1_3_1_unknown",
		tome = "dlc1_3_1_collect",
		ogre = "dlc1_3_1_kill",
		grimoire = "dlc1_3_1_collect",
		level = "dlc1_3_1_complete"
	},
	token_type_to_icon_lookup = {
		iron_tokens = "quest_screen_token_icon_01",
		silver_tokens = "quest_screen_token_icon_03",
		bronze_tokens = "quest_screen_token_icon_02",
		gold_tokens = "quest_screen_token_icon_04"
	},
	token_type_to_large_icon_lookup = {
		iron_tokens = "token_icon_01_large",
		silver_tokens = "token_icon_03_large",
		bronze_tokens = "token_icon_02_large",
		gold_tokens = "token_icon_04_large"
	},
	token_name_by_type_lookup = {
		iron_tokens = "upgrade_token_jacinth",
		silver_tokens = "upgrade_token_hematite",
		bronze_tokens = "upgrade_token_jade",
		gold_tokens = "upgrade_token_opal"
	},
	num_sigils_per_dlc = {
		drachenfels = 3,
		main = 4
	},
	contract_ui_dlc_colors = {
		main = {
			255,
			133,
			0,
			0
		},
		drachenfels = {
			255,
			82,
			37,
			95
		}
	},
	quest_bg_texture_names = {
		"quest_screen_bg_board_quest_01",
		"quest_screen_bg_board_quest_02",
		"quest_screen_bg_board_quest_03"
	},
	quest_popup_bg_texture_names = {
		"quest_screen_bg_contract_02",
		"quest_screen_bg_contract_03",
		"quest_screen_bg_contract_05"
	}
}
local new_contracts = {
	avoid_specials_damage_team = true,
	open_chests = false,
	avoid_deaths_team = true,
	damage_taken_individual = true,
	grenade_kills = false,
	last_stand_waves_defeated = false
}
local req_texts = QuestSettings.task_type_requirement_text
local detailed_req_texts = QuestSettings.detailed_task_type_requirement_text
local task_titles = QuestSettings.task_type_titles
local task_names = QuestSettings.task_type_to_name_lookup
local icons = QuestSettings.task_type_to_icon_lookup

for contract_name, has_detailed in pairs(new_contracts) do
	req_texts[contract_name] = {
		"qnc_task_requirement_" .. contract_name
	}

	if has_detailed then
		detailed_req_texts[contract_name] = {
			"qnc_task_requirement_detailed_" .. contract_name
		}
	end

	task_titles[contract_name] = {
		"qnc_task_type_title_" .. contract_name
	}
	task_names[contract_name] = "qnc_task_objective_" .. contract_name
	icons[contract_name] = "quest_icon_" .. contract_name
end

QuestTextSettings = {
	task_type_max_range = {
		grim = 6,
		open_chests = 2,
		avoid_deaths_team = 6,
		damage_taken_individual = 6,
		last_stand_waves_defeated = 2,
		avoid_specials_damage_team = 6,
		tome = 6,
		ogre = 8,
		grenade_kills = 6,
		level = 10
	},
	quest_giver_max_range = {
		borgun = 3,
		alfred = 0,
		gunter = 5,
		grodni = 5,
		heinrich = 3,
		marianne = 0,
		ulrike = 0,
		lorith = 3,
		rickard = 3,
		andrea = 3,
		manfred = 3,
		bernhardt = 3
	},
	quest_givers = {
		"andrea",
		"bernhardt",
		"borgun",
		"grodni",
		"gunter",
		"heinrich",
		"lorith",
		"manfred",
		"rickard"
	}
}
local meta = {
	__index = function (t, k)
		return t.unknown
	end
}
local replace_list = {
	"task_type_titles",
	"task_type_requirement_text",
	"task_type_to_icon_lookup",
	"task_type_to_name_lookup",
	"task_type_to_task_description_lookup"
}

for _, key in ipairs(replace_list) do
	setmetatable(QuestSettings[key], meta)
end

return 
