DialogueSettings = DialogueSettings or {}
DialogueSettings.markers_enabled = false
DialogueSettings.auto_load_files = {
	"dialogues/generated/witch_hunter",
	"dialogues/generated/bright_wizard",
	"dialogues/generated/dwarf_ranger",
	"dialogues/generated/wood_elf",
	"dialogues/generated/empire_soldier",
	"dialogues/generated/player_conversations",
	"dialogues/generated/npcs",
	"dialogues/generated/special_occasions",
	"dialogues/generated/enemies",
	"dialogues/generated/dlc_01",
	"dialogues/generated/drachenfels",
	"dialogues/generated/dlc_enemies_01",
	"dialogues/generated/dwarf_dlc"
}
DialogueSettings.level_specific_load_files = {
	inn_level = {
		"dialogues/generated/pub_brawl",
		"dialogues/generated/npcs"
	},
	tutorial = {
		"dialogues/generated/tutorial",
		"dialogues/generated/enemies"
	},
	bridge = {
		"dialogues/generated/bright_wizard_bridge",
		"dialogues/generated/dwarf_ranger_bridge",
		"dialogues/generated/witch_hunter_bridge",
		"dialogues/generated/wood_elf_bridge",
		"dialogues/generated/dwarf_ranger_bridge"
	},
	cemetery = {
		"dialogues/generated/bright_wizard_cemetery",
		"dialogues/generated/dwarf_ranger_cemetery",
		"dialogues/generated/witch_hunter_cemetery",
		"dialogues/generated/wood_elf_cemetery",
		"dialogues/generated/dwarf_ranger_cemetery"
	},
	city_wall = {
		"dialogues/generated/bright_wizard_city_wall",
		"dialogues/generated/dwarf_ranger_city_wall",
		"dialogues/generated/witch_hunter_city_wall",
		"dialogues/generated/wood_elf_city_wall",
		"dialogues/generated/dwarf_ranger_city_wall"
	},
	courtyard = {
		"dialogues/generated/bright_wizard_courtyard",
		"dialogues/generated/dwarf_ranger_courtyard",
		"dialogues/generated/witch_hunter_courtyard",
		"dialogues/generated/wood_elf_courtyard",
		"dialogues/generated/dwarf_ranger_courtyard"
	},
	docks = {
		"dialogues/generated/bright_wizard_docks",
		"dialogues/generated/dwarf_ranger_docks",
		"dialogues/generated/witch_hunter_docks",
		"dialogues/generated/wood_elf_docks",
		"dialogues/generated/dwarf_ranger_docks"
	},
	end_boss = {
		"dialogues/generated/bright_wizard_end_boss",
		"dialogues/generated/dwarf_ranger_end_boss",
		"dialogues/generated/witch_hunter_end_boss",
		"dialogues/generated/wood_elf_end_boss",
		"dialogues/generated/dwarf_ranger_end_boss",
		"dialogues/generated/grey_seer"
	},
	farm = {
		"dialogues/generated/bright_wizard_farm",
		"dialogues/generated/dwarf_ranger_farm",
		"dialogues/generated/witch_hunter_farm",
		"dialogues/generated/wood_elf_farm",
		"dialogues/generated/dwarf_ranger_farm"
	},
	forest_ambush = {
		"dialogues/generated/bright_wizard_forest_ambush",
		"dialogues/generated/dwarf_ranger_forest_ambush",
		"dialogues/generated/witch_hunter_forest_ambush",
		"dialogues/generated/wood_elf_forest_ambush",
		"dialogues/generated/dwarf_ranger_forest_ambush"
	},
	magnus = {
		"dialogues/generated/bright_wizard_magnus_tower",
		"dialogues/generated/dwarf_ranger_magnus_tower",
		"dialogues/generated/witch_hunter_magnus_tower",
		"dialogues/generated/wood_elf_magnus_tower",
		"dialogues/generated/dwarf_ranger_magnus_tower"
	},
	merchant = {
		"dialogues/generated/bright_wizard_merchant",
		"dialogues/generated/dwarf_ranger_merchant",
		"dialogues/generated/witch_hunter_merchant",
		"dialogues/generated/wood_elf_merchant",
		"dialogues/generated/dwarf_ranger_merchant"
	},
	sewers = {
		"dialogues/generated/bright_wizard_sewers",
		"dialogues/generated/dwarf_ranger_sewers",
		"dialogues/generated/witch_hunter_sewers",
		"dialogues/generated/wood_elf_sewers",
		"dialogues/generated/dwarf_ranger_sewers"
	},
	skaven_tunnels = {
		"dialogues/generated/bright_wizard_skaven_tunnels",
		"dialogues/generated/dwarf_ranger_skaven_tunnels",
		"dialogues/generated/witch_hunter_skaven_tunnels",
		"dialogues/generated/wood_elf_skaven_tunnels",
		"dialogues/generated/dwarf_ranger_skaven_tunnels"
	},
	wizard = {
		"dialogues/generated/bright_wizard_wizard_tower",
		"dialogues/generated/dwarf_ranger_wizard_tower",
		"dialogues/generated/witch_hunter_wizard_tower",
		"dialogues/generated/wood_elf_wizard_tower",
		"dialogues/generated/dwarf_ranger_wizard_tower"
	},
	dlc_stromdorf_town = {
		"dialogues/generated/bright_wizard_stromdorf_town",
		"dialogues/generated/dwarf_ranger_stromdorf_town",
		"dialogues/generated/witch_hunter_stromdorf_town",
		"dialogues/generated/wood_elf_stromdorf_town",
		"dialogues/generated/dwarf_ranger_stromdorf_town",
		"dialogues/generated/enemy_champion_chieftain_stromdorf_town",
		"dialogues/generated/hero_conversations_stromdorf"
	},
	dlc_stromdorf_hills = {
		"dialogues/generated/bright_wizard_stromdorf_hill",
		"dialogues/generated/dwarf_ranger_stromdorf_hill",
		"dialogues/generated/witch_hunter_stromdorf_hill",
		"dialogues/generated/wood_elf_stromdorf_hill",
		"dialogues/generated/dwarf_ranger_stromdorf_hill",
		"dialogues/generated/hero_conversations_stromdorf"
	},
	chamber = {
		"dialogues/generated/bright_wizard_chamber",
		"dialogues/generated/empire_soldier_chamber",
		"dialogues/generated/dwarf_ranger_chamber",
		"dialogues/generated/witch_hunter_chamber",
		"dialogues/generated/wood_elf_chamber",
		"dialogues/generated/dwarf_ranger_chamber",
		"dialogues/generated/grey_seer_chamber"
	},
	whitebox_climb = {
		"dialogues/generated/bright_wizard_chamber",
		"dialogues/generated/empire_soldier_chamber",
		"dialogues/generated/dwarf_ranger_chamber",
		"dialogues/generated/witch_hunter_chamber",
		"dialogues/generated/wood_elf_chamber",
		"dialogues/generated/dwarf_ranger_chamber",
		"dialogues/generated/grey_seer_chamber"
	},
	dlc_challenge_wizard = {
		"dialogues/generated/dlc_challenge_wizard"
	},
	dlc_reikwald_forest = {
		"dialogues/generated/witch_hunter_reikwald_forest",
		"dialogues/generated/empire_soldier_reikwald_forest",
		"dialogues/generated/wood_elf_reikwald_forest",
		"dialogues/generated/bright_wizard_reikwald_forest",
		"dialogues/generated/dwarf_ranger_reikwald_forest"
	},
	dlc_reikwald_river = {
		"dialogues/generated/witch_hunter_reikwald_river",
		"dialogues/generated/empire_soldier_reikwald_river",
		"dialogues/generated/wood_elf_reikwald_river",
		"dialogues/generated/bright_wizard_reikwald_river",
		"dialogues/generated/dwarf_ranger_reikwald_river"
	}
}

for dlc_name, dlc_settings in pairs(DLCSettings) do
	for level_name, dialogues in pairs(dlc_settings.dialogue_settings) do
		DialogueSettings.level_specific_load_files[level_name] = dialogues
	end
end

DialogueSettings.blocked_auto_load_files = {
	inn_level = true,
	tutorial = true
}
DialogueSettings.max_view_distance = 50
DialogueSettings.default_view_distance = 10
DialogueSettings.default_hear_distance = 10
DialogueSettings.death_discover_distance = 40
DialogueSettings.discover_enemy_attack_distance = 25
DialogueSettings.view_event_trigger_interval = 1
DialogueSettings.seen_recently_threshold = 10
DialogueSettings.friends_close_distance = 20
DialogueSettings.friends_distant_distance = 50
DialogueSettings.enemies_close_distance = 10
DialogueSettings.enemies_distant_distance = 40
DialogueSettings.enemy_attack_distance = 40
DialogueSettings.enemy_spawn_allies = 10
DialogueSettings.knocked_down_broadcast_range = 40
DialogueSettings.pounced_down_broadcast_range = 40
DialogueSettings.suicide_run_broadcast_range = 40
DialogueSettings.grabbed_broadcast_range = 40
DialogueSettings.dialogue_level_start_delay = 120
DialogueSettings.story_start_delay = 60
DialogueSettings.story_tick_time = 10
DialogueSettings.ambush_delay = 2
DialogueSettings.vector_delay = 3
DialogueSettings.max_hear_distance = math.max(10, DialogueSettings.knocked_down_broadcast_range, DialogueSettings.pounced_down_broadcast_range, DialogueSettings.death_discover_distance)
DialogueSettings.dialogue_category_config = {
	default = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk_2 = true,
			boss_talk = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {}
	},
	help_talk = {
		interrupted_by = {
			npc_talk_interrupt = true,
			player_alerts_boss = true
		},
		playable_during_category = {
			default = true,
			enemy_high_prio = true,
			guidance = true,
			player_feedback = true,
			enemy_alerts = true,
			story_talk = true,
			seen_items = true,
			casual_talk = true,
			player_alerts = true,
			enemy_basic_prio = true,
			knocked_down_override = true
		}
	},
	player_alerts_boss = {
		interrupted_by = {
			npc_talk_interrupt = true
		},
		playable_during_category = {
			default = true,
			enemy_high_prio = true,
			guidance = true,
			enemy_alerts = true,
			player_feedback = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			help_talk = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			boss_talk = true
		}
	},
	player_alerts = {
		interrupted_by = {
			boss_talk_3 = true,
			boss_talk_2 = true,
			player_alerts_boss = true,
			boss_talk = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			default = true,
			enemy_high_prio = true,
			guidance = true,
			enemy_alerts = true,
			player_feedback = true,
			seen_items = true,
			casual_talk = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true
		}
	},
	player_feedback = {
		interrupted_by = {
			boss_talk = true,
			boss_talk_2 = true,
			player_alerts_boss = true,
			boss_talk_3 = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			default = true,
			enemy_high_prio = true,
			guidance = true,
			enemy_alerts = true,
			npc_talk_special = true,
			npc_talk_interrupt_special = true,
			seen_items = true,
			casual_talk = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true
		}
	},
	npc_talk_special = {
		mutually_exclusive = true,
		interrupted_by = {
			npc_talk_interrupt_special = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			default = true,
			enemy_high_prio = true,
			guidance = true,
			enemy_alerts = true,
			seen_items = true,
			casual_talk = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			knocked_down_override = true
		}
	},
	npc_talk_interrupt_special = {
		mutually_exclusive = true,
		interrupted_by = {},
		playable_during_category = {
			enemy_alerts = true,
			enemy_high_prio = true,
			help_talk = true,
			player_feedback = true,
			npc_talk_special = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			guidance = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			npc_talk = true,
			knocked_down_override = true,
			default = true
		}
	},
	guidance = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk = true,
			boss_talk_2 = true,
			player_alerts_boss = true,
			boss_talk_3 = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			default = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			enemy_alerts = true,
			enemy_high_prio = true,
			seen_items = true,
			casual_talk = true
		}
	},
	enemy_alerts = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk = true,
			boss_talk_2 = true,
			player_alerts_boss = true,
			boss_talk_3 = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			default = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			player_feedback = true,
			enemy_high_prio = true,
			seen_items = true,
			casual_talk = true
		}
	},
	seen_items = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk = true,
			boss_talk_2 = true,
			player_alerts_boss = true,
			boss_talk_3 = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			default = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			enemy_high_prio = true,
			casual_talk = true
		}
	},
	level_talk = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk = true,
			boss_talk_2 = true,
			player_alerts_boss = true,
			boss_talk_3 = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			default = true,
			enemy_high_prio = true,
			npc_talk_special = true,
			enemy_basic_prio = true
		}
	},
	casual_talk = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk = true,
			boss_talk_2 = true,
			player_alerts_boss = true,
			boss_talk_3 = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			enemy_high_prio = true,
			enemy_basic_prio = true
		}
	},
	story_talk = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk_2 = true,
			player_alerts_boss = true,
			boss_talk = true,
			npc_talk_interrupt = true
		},
		playable_during_category = {
			enemy_high_prio = true,
			enemy_basic_prio = true
		}
	},
	knocked_down_override = {
		interrupted_by = {
			npc_talk_interrupt = true
		},
		playable_during_category = {
			enemy_alerts = true,
			enemy_high_prio = true,
			help_talk = true,
			player_feedback = true,
			default = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			guidance = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true
		}
	},
	npc_talk = {
		mutually_exclusive = true,
		interrupted_by = {
			npc_talk_interrupt = true
		},
		playable_during_category = {
			enemy_alerts = true,
			enemy_high_prio = true,
			help_talk = true,
			player_feedback = true,
			default = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			guidance = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			knocked_down_override = true
		}
	},
	npc_talk_interrupt = {
		mutually_exclusive = true,
		interrupted_by = {},
		playable_during_category = {
			enemy_alerts = true,
			enemy_high_prio = true,
			help_talk = true,
			player_feedback = true,
			default = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			guidance = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			npc_talk = true,
			knocked_down_override = true
		}
	},
	boss_talk = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk_3 = true,
			boss_talk_2 = true
		},
		playable_during_category = {
			enemy_alerts = true,
			enemy_high_prio = true,
			help_talk = true,
			player_feedback = true,
			default = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			enemy_basic_prio = true,
			story_talk = true,
			level_talk = true,
			boss_reaction_talk = true,
			guidance = true,
			knocked_down_override = true,
			player_alerts_boss = true
		}
	},
	boss_talk_2 = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk_3 = true
		},
		playable_during_category = {
			enemy_alerts = true,
			enemy_high_prio = true,
			help_talk = true,
			player_feedback = true,
			default = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			enemy_basic_prio = true,
			story_talk = true,
			level_talk = true,
			boss_reaction_talk = true,
			guidance = true,
			knocked_down_override = true,
			player_alerts_boss = true,
			boss_talk = true
		}
	},
	boss_talk_3 = {
		mutually_exclusive = true,
		interrupted_by = {},
		playable_during_category = {
			default = true,
			enemy_basic_prio = true,
			player_feedback = true,
			help_talk = true,
			enemy_alerts = true,
			boss_talk_2 = true,
			boss_talk = true,
			casual_talk = true,
			story_talk = true,
			level_talk = true,
			boss_reaction_talk = true,
			knocked_down_override = true,
			enemy_high_prio = true,
			guidance = true,
			seen_items = true,
			player_alerts = true,
			player_alerts_boss = true
		}
	},
	boss_reaction_talk = {
		mutually_exclusive = true,
		interrupted_by = {
			boss_talk = true,
			boss_talk_2 = true
		},
		playable_during_category = {
			enemy_alerts = true,
			enemy_high_prio = true,
			help_talk = true,
			player_feedback = true,
			default = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			guidance = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			knocked_down_override = true
		}
	},
	enemy_basic_prio = {
		interrupted_by = {
			boss_talk_2 = true,
			enemy_high_prio = true,
			boss_talk = true
		},
		playable_during_category = {
			enemy_alerts = true,
			enemy_high_prio = true,
			help_talk = true,
			player_feedback = true,
			default = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			boss_talk = true,
			story_talk = true,
			level_talk = true,
			boss_reaction_talk = true,
			guidance = true,
			knocked_down_override = true
		}
	},
	enemy_high_prio = {
		interrupted_by = {
			boss_talk_2 = true
		},
		playable_during_category = {
			enemy_alerts = true,
			guidance = true,
			help_talk = true,
			player_feedback = true,
			default = true,
			player_alerts = true,
			seen_items = true,
			casual_talk = true,
			boss_talk = true,
			story_talk = true,
			level_talk = true,
			boss_reaction_talk = true,
			enemy_basic_prio = true,
			knocked_down_override = true
		}
	}
}
DialogueSettings.breed_types_trigger_on_spawn = {
	skaven_rat_ogre = true
}
DialogueSettings.bunny_jumping = {
	tick_time = 5,
	jump_threshold = 6
}
DialogueSettings.raycast_enemy_check_interval = 0.25
DialogueSettings.hear_enemy_check_interval = 10
DialogueSettings.special_proximity_distance = 30
DialogueSettings.special_proximity_distance_heard = 20
HealthTriggerSettings = {
	levels = {
		0.2,
		0.5,
		1
	},
	rapid_health_loss = {
		tick_time = 2,
		tick_loss_threshold = 0.2
	}
}
SpecialSubtitleEvents = {
	end_boss_outro = {
		outro_subtitle_04 = 24,
		outro_subtitle_09 = 53,
		outro_subtitle_03 = 17,
		outro_subtitle_06 = 37,
		outro_subtitle_05 = 30,
		outro_subtitle_08 = 45,
		outro_subtitle_07 = 40,
		outro_subtitle_02 = 11,
		outro_subtitle_01 = 0
	}
}

return
