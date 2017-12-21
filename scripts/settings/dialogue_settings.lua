DialogueSettings = DialogueSettings or {}
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
	"dialogues/generated/tutorial",
	"dialogues/generated/drachenfels"
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
		interrupted_by = {},
		playable_during_category = {}
	},
	help_talk = {
		interrupted_by = {},
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
	player_alerts = {
		interrupted_by = {},
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
		interrupted_by = {},
		playable_during_category = {
			default = true,
			enemy_high_prio = true,
			guidance = true,
			enemy_alerts = true,
			seen_items = true,
			casual_talk = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true
		}
	},
	guidance = {
		mutually_exclusive = true,
		interrupted_by = {},
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
		interrupted_by = {},
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
		interrupted_by = {},
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
		interrupted_by = {},
		playable_during_category = {
			default = true,
			enemy_high_prio = true,
			enemy_basic_prio = true
		}
	},
	casual_talk = {
		mutually_exclusive = true,
		interrupted_by = {},
		playable_during_category = {
			enemy_high_prio = true,
			enemy_basic_prio = true
		}
	},
	story_talk = {
		mutually_exclusive = true,
		interrupted_by = {},
		playable_during_category = {
			enemy_high_prio = true,
			enemy_basic_prio = true
		}
	},
	knocked_down_override = {
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
			enemy_basic_prio = true,
			story_talk = true,
			level_talk = true,
			boss_reaction_talk = true,
			guidance = true,
			knocked_down_override = true
		}
	},
	boss_reaction_talk = {
		mutually_exclusive = true,
		interrupted_by = {
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
			guidance = true,
			story_talk = true,
			level_talk = true,
			enemy_basic_prio = true,
			knocked_down_override = true
		}
	},
	enemy_basic_prio = {
		interrupted_by = {
			enemy_high_prio = true
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
		interrupted_by = {},
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
