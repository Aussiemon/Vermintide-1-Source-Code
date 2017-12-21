return function ()
	define_rule({
		name = "pbw_dialogue_01_dlc",
		response = "pbw_dialogue_01_dlc",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				40
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_build_up"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				100
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"dlc_castle"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_01_dlc",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_01_dlc",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_response_02_dlc",
		response = "pdr_dialogue_response_02_dlc",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_dialogue_01_dlc"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_02_dlc",
		response = "pbw_dialogue_response_02_dlc",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_dialogue_response_02_dlc"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "nik_map_brief_dlc_survival_ruins",
		name = "nik_map_brief_dlc_survival_ruins",
		criterias = {}
	})
	define_rule({
		response = "nik_map_brief_dlc_survival_general",
		name = "nik_map_brief_dlc_survival_general",
		criterias = {}
	})
	define_rule({
		response = "nik_loading_screen_dlc_survival_ruins",
		name = "nik_loading_screen_dlc_survival_ruins",
		criterias = {}
	})
	define_rule({
		response = "nik_loading_screen_dlc_survival_general",
		name = "nik_loading_screen_dlc_survival_general",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nik_loading_screen_dlc_survival_general"
			}
		}
	})
	define_rule({
		response = "nik_altar",
		name = "nik_altar",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nik_altar"
			}
		}
	})
	define_rule({
		response = "nik_forge",
		name = "nik_forge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nik_forge"
			}
		}
	})
	define_rule({
		response = "nik_banter",
		name = "nik_banter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nik_banter"
			}
		}
	})
	define_rule({
		response = "nik_survival_mode",
		name = "nik_survival_mode",
		criterias = {}
	})
	define_rule({
		response = "nfl_survival_ruins_intro",
		name = "nfl_survival_ruins_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_ruins_intro"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_wave_completed",
		name = "nfl_survival_generic_wave_completed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_wave_completed"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_directional_warning_north",
		name = "nfl_survival_generic_directional_warning_north",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_directional_warning_north"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_directional_warning_east",
		name = "nfl_survival_generic_directional_warning_east",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_directional_warning_east"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_directional_warning_west",
		name = "nfl_survival_generic_directional_warning_west",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_directional_warning_west"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_directional_warning_south",
		name = "nfl_survival_generic_directional_warning_south",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_directional_warning_south"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_wave_starting",
		name = "nfl_survival_generic_wave_starting",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_wave_starting"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_supply_drop",
		name = "nfl_survival_generic_supply_drop",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_supply_drop"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_progression_1",
		name = "nfl_survival_generic_progression_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_progression_1"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_progression_2",
		name = "nfl_survival_generic_progression_2",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_progression_2"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_progression_3",
		name = "nfl_survival_generic_progression_3",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_progression_3"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_prepare_wave",
		name = "nfl_survival_generic_prepare_wave",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_prepare_wave"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_defeat",
		name = "nfl_survival_generic_defeat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_defeat"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_ff_reminder",
		name = "nfl_survival_generic_ff_reminder",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_ff_reminder"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_cataclysm",
		name = "nfl_survival_generic_cataclysm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_cataclysm"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_directional_warning_ everywhere",
		name = "nfl_survival_generic_directional_warning_ everywhere",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_directional_warning_ everywhere"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_progression_1_defeat",
		name = "nfl_survival_generic_progression_1_defeat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_progression_1_defeat"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_progression_2_defeat",
		name = "nfl_survival_generic_progression_2_defeat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_progression_2_defeat"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_progression_3_defeat",
		name = "nfl_survival_generic_progression_3_defeat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_progression_3_defeat"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_supply_room",
		name = "nfl_survival_generic_supply_room",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_supply_room"
			}
		}
	})
	define_rule({
		response = "nfl_survival_generic_intro",
		name = "nfl_survival_generic_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"nfl_survival_generic_intro"
			}
		}
	})
	define_rule({
		name = "pwh_drachenfels_intro",
		response = "pwh_drachenfels_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_drachenfels_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_drachenfels_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_drachenfels_intro",
				OP.ADD,
				1
			}
		}
	})
	add_dialogues({
		nfl_survival_generic_progression_3 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"nfl_survival_generic_progression_3_01",
				"nfl_survival_generic_progression_3_02",
				"nfl_survival_generic_progression_3_03",
				"nfl_survival_generic_progression_3_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_progression_3_01",
				"nfl_survival_generic_progression_3_02",
				"nfl_survival_generic_progression_3_03",
				"nfl_survival_generic_progression_3_04"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_directional_warning_north = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"nfl_survival_generic_directional_warning_north_01",
				"nfl_survival_generic_directional_warning_north_02",
				"nfl_survival_generic_directional_warning_north_03",
				"nfl_survival_generic_directional_warning_north_04",
				"nfl_survival_generic_directional_warning_north_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_directional_warning_north_01",
				"nfl_survival_generic_directional_warning_north_02",
				"nfl_survival_generic_directional_warning_north_03",
				"nfl_survival_generic_directional_warning_north_04",
				"nfl_survival_generic_directional_warning_north_05"
			},
			randomize_indexes = {}
		},
		nik_map_brief_dlc_survival_ruins = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_map_brief_dlc_survival_ruins_01",
				[2.0] = "nik_map_brief_dlc_survival_ruins_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nik_map_brief_dlc_survival_ruins_01",
				[2.0] = "nik_map_brief_dlc_survival_ruins_02"
			},
			randomize_indexes = {}
		},
		nik_altar = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"nik_altar_01",
				"nik_altar_02",
				"nik_altar_03",
				"nik_altar_04",
				"nik_altar_05",
				"nik_altar_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nik_altar_01",
				"nik_altar_02",
				"nik_altar_03",
				"nik_altar_04",
				"nik_altar_05",
				"nik_altar_06"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_wave_completed = {
			sound_events_n = 10,
			randomize_indexes_n = 0,
			face_animations_n = 10,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 10,
			sound_events = {
				"nfl_survival_generic_wave_completed_01",
				"nfl_survival_generic_wave_completed_02",
				"nfl_survival_generic_wave_completed_03",
				"nfl_survival_generic_wave_completed_04",
				"nfl_survival_generic_wave_completed_05",
				"nfl_survival_generic_wave_completed_06",
				"nfl_survival_generic_wave_completed_07",
				"nfl_survival_generic_wave_completed_08",
				"nfl_survival_generic_wave_completed_09",
				"nfl_survival_generic_wave_completed_10"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_wave_completed_01",
				"nfl_survival_generic_wave_completed_02",
				"nfl_survival_generic_wave_completed_03",
				"nfl_survival_generic_wave_completed_04",
				"nfl_survival_generic_wave_completed_05",
				"nfl_survival_generic_wave_completed_06",
				"nfl_survival_generic_wave_completed_07",
				"nfl_survival_generic_wave_completed_08",
				"nfl_survival_generic_wave_completed_09",
				"nfl_survival_generic_wave_completed_10"
			},
			randomize_indexes = {}
		},
		nik_map_brief_dlc_survival_general = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"nik_map_brief_dlc_survival_general_01",
				"nik_map_brief_dlc_survival_general_02",
				"nik_map_brief_dlc_survival_general_03",
				"nik_map_brief_dlc_survival_general_05",
				"nik_map_brief_dlc_survival_general_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nik_map_brief_dlc_survival_general_01",
				"nik_map_brief_dlc_survival_general_02",
				"nik_map_brief_dlc_survival_general_03",
				"nik_map_brief_dlc_survival_general_05",
				"nik_map_brief_dlc_survival_general_06"
			},
			randomize_indexes = {}
		},
		nik_loading_screen_dlc_survival_general = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"nik_loading_screen_dlc_survival_general_01",
				"nik_loading_screen_dlc_survival_general_02",
				"nik_loading_screen_dlc_survival_general_03",
				"nik_loading_screen_dlc_survival_general_04",
				"nik_loading_screen_dlc_survival_general_05",
				"nik_loading_screen_dlc_survival_general_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nik_loading_screen_dlc_survival_general_01",
				"nik_loading_screen_dlc_survival_general_02",
				"nik_loading_screen_dlc_survival_general_03",
				"nik_loading_screen_dlc_survival_general_04",
				"nik_loading_screen_dlc_survival_general_05",
				"nik_loading_screen_dlc_survival_general_06"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_ff_reminder = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nfl_survival_generic_ff_reminder_01",
				[2.0] = "nfl_survival_generic_ff_reminder_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nfl_survival_generic_ff_reminder_01",
				[2.0] = "nfl_survival_generic_ff_reminder_02"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_directional_warning_south = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"nfl_survival_generic_directional_warning_south_01",
				"nfl_survival_generic_directional_warning_south_02",
				"nfl_survival_generic_directional_warning_south_03",
				"nfl_survival_generic_directional_warning_south_04",
				"nfl_survival_generic_directional_warning_south_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_directional_warning_south_01",
				"nfl_survival_generic_directional_warning_south_02",
				"nfl_survival_generic_directional_warning_south_03",
				"nfl_survival_generic_directional_warning_south_04",
				"nfl_survival_generic_directional_warning_south_05"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_intro = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"nfl_survival_generic_intro_01",
				"nfl_survival_generic_intro_02",
				"nfl_survival_generic_intro_03",
				"nfl_survival_generic_intro_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_intro_01",
				"nfl_survival_generic_intro_02",
				"nfl_survival_generic_intro_03",
				"nfl_survival_generic_intro_04"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_supply_drop = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"nfl_survival_generic_supply_drop_01",
				"nfl_survival_generic_supply_drop_02",
				"nfl_survival_generic_supply_drop_03",
				"nfl_survival_generic_supply_drop_04",
				"nfl_survival_generic_supply_drop_05",
				"nfl_survival_generic_supply_drop_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_supply_drop_01",
				"nfl_survival_generic_supply_drop_02",
				"nfl_survival_generic_supply_drop_03",
				"nfl_survival_generic_supply_drop_04",
				"nfl_survival_generic_supply_drop_05",
				"nfl_survival_generic_supply_drop_06"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_defeat = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"nfl_survival_generic_defeat_01",
				"nfl_survival_generic_defeat_02",
				"nfl_survival_generic_defeat_03",
				"nfl_survival_generic_defeat_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_defeat_01",
				"nfl_survival_generic_defeat_02",
				"nfl_survival_generic_defeat_03",
				"nfl_survival_generic_defeat_04"
			},
			randomize_indexes = {}
		},
		["nfl_survival_generic_directional_warning_ everywhere"] = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"nfl_survival_generic_directional_warning_ everywhere_01",
				"nfl_survival_generic_directional_warning_ everywhere_02",
				"nfl_survival_generic_directional_warning_ everywhere_03",
				"nfl_survival_generic_directional_warning_ everywhere_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_directional_warning_ everywhere_01",
				"nfl_survival_generic_directional_warning_ everywhere_02",
				"nfl_survival_generic_directional_warning_ everywhere_03",
				"nfl_survival_generic_directional_warning_ everywhere_04"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_progression_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"nfl_survival_generic_progression_1_01",
				"nfl_survival_generic_progression_1_02",
				"nfl_survival_generic_progression_1_03",
				"nfl_survival_generic_progression_1_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_progression_1_01",
				"nfl_survival_generic_progression_1_02",
				"nfl_survival_generic_progression_1_03",
				"nfl_survival_generic_progression_1_04"
			},
			randomize_indexes = {}
		},
		pbw_dialogue_01_dlc = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dlc_01",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_01_dlc"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_01_dlc"
			}
		},
		pwh_drachenfels_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_01",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_drachenfels_intro_a_01_dlc",
				[2.0] = "pwh_drachenfels_intro_a_02_dlc"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_drachenfels_intro_a_01_dlc",
				[2.0] = "pwh_drachenfels_intro_a_02_dlc"
			},
			randomize_indexes = {}
		},
		pdr_dialogue_response_02_dlc = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dlc_01",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_02_dlc"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_02_dlc"
			}
		},
		pbw_dialogue_response_02_dlc = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dlc_01",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_02_dlc"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_02_dlc"
			}
		},
		nik_loading_screen_dlc_survival_ruins = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_loading_screen_dlc_survival_ruins_01",
				[2.0] = "nik_loading_screen_dlc_survival_ruins_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nik_loading_screen_dlc_survival_ruins_01",
				[2.0] = "nik_loading_screen_dlc_survival_ruins_02"
			},
			randomize_indexes = {}
		},
		nik_banter = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 8,
			sound_events = {
				"nik_banter_01",
				"nik_banter_02",
				"nik_banter_03",
				"nik_banter_04",
				"nik_banter_05",
				"nik_banter_06",
				"nik_banter_07",
				"nik_banter_08"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nik_banter_01",
				"nik_banter_02",
				"nik_banter_03",
				"nik_banter_04",
				"nik_banter_05",
				"nik_banter_06",
				"nik_banter_07",
				"nik_banter_08"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_prepare_wave = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 8,
			sound_events = {
				"nfl_survival_generic_prepare_wave_01",
				"nfl_survival_generic_prepare_wave_02",
				"nfl_survival_generic_prepare_wave_03",
				"nfl_survival_generic_prepare_wave_04",
				"nfl_survival_generic_prepare_wave_05",
				"nfl_survival_generic_prepare_wave_06",
				"nfl_survival_generic_prepare_wave_07",
				"nfl_survival_generic_prepare_wave_08"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_prepare_wave_01",
				"nfl_survival_generic_prepare_wave_02",
				"nfl_survival_generic_prepare_wave_03",
				"nfl_survival_generic_prepare_wave_04",
				"nfl_survival_generic_prepare_wave_05",
				"nfl_survival_generic_prepare_wave_06",
				"nfl_survival_generic_prepare_wave_07",
				"nfl_survival_generic_prepare_wave_08"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_progression_1_defeat = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"nfl_survival_generic_progression_1_defeat_01",
				"nfl_survival_generic_progression_1_defeat_02",
				"nfl_survival_generic_progression_1_defeat_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_progression_1_defeat_01",
				"nfl_survival_generic_progression_1_defeat_02",
				"nfl_survival_generic_progression_1_defeat_03"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_supply_room = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_survival_generic_supply_room"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nfl_survival_generic_supply_room"
			}
		},
		nfl_survival_ruins_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nfl_survival_ruins_intro_01",
				[2.0] = "nfl_survival_ruins_intro_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nfl_survival_ruins_intro_01",
				[2.0] = "nfl_survival_ruins_intro_02"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_directional_warning_east = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"nfl_survival_generic_directional_warning_east_01",
				"nfl_survival_generic_directional_warning_east_02",
				"nfl_survival_generic_directional_warning_east_03",
				"nfl_survival_generic_directional_warning_east_04",
				"nfl_survival_generic_directional_warning_east_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_directional_warning_east_01",
				"nfl_survival_generic_directional_warning_east_02",
				"nfl_survival_generic_directional_warning_east_03",
				"nfl_survival_generic_directional_warning_east_04",
				"nfl_survival_generic_directional_warning_east_05"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_progression_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"nfl_survival_generic_progression_2_01",
				"nfl_survival_generic_progression_2_02",
				"nfl_survival_generic_progression_2_03",
				"nfl_survival_generic_progression_2_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_progression_2_01",
				"nfl_survival_generic_progression_2_02",
				"nfl_survival_generic_progression_2_03",
				"nfl_survival_generic_progression_2_04"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_progression_3_defeat = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"nfl_survival_generic_progression_3_defeat_01",
				"nfl_survival_generic_progression_3_defeat_02",
				"nfl_survival_generic_progression_3_defeat_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_progression_3_defeat_01",
				"nfl_survival_generic_progression_3_defeat_02",
				"nfl_survival_generic_progression_3_defeat_03"
			},
			randomize_indexes = {}
		},
		nik_forge = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"nik_forge_01",
				"nik_forge_02",
				"nik_forge_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nik_forge_01",
				"nik_forge_02",
				"nik_forge_03"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_cataclysm = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nfl_survival_generic_cataclysm_01",
				[2.0] = "nfl_survival_generic_cataclysm_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nfl_survival_generic_cataclysm_01",
				[2.0] = "nfl_survival_generic_cataclysm_02"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_progression_2_defeat = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"nfl_survival_generic_progression_2_defeat_01",
				"nfl_survival_generic_progression_2_defeat_02",
				"nfl_survival_generic_progression_2_defeat_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_progression_2_defeat_01",
				"nfl_survival_generic_progression_2_defeat_02",
				"nfl_survival_generic_progression_2_defeat_03"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_wave_starting = {
			sound_events_n = 9,
			randomize_indexes_n = 0,
			face_animations_n = 9,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 9,
			sound_events = {
				"nfl_survival_generic_wave_starting_01",
				"nfl_survival_generic_wave_starting_02",
				"nfl_survival_generic_wave_starting_03",
				"nfl_survival_generic_wave_starting_04",
				"nfl_survival_generic_wave_starting_05",
				"nfl_survival_generic_wave_starting_06",
				"nfl_survival_generic_wave_starting_07",
				"nfl_survival_generic_wave_starting_08",
				"nfl_survival_generic_wave_starting_09"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_wave_starting_01",
				"nfl_survival_generic_wave_starting_02",
				"nfl_survival_generic_wave_starting_03",
				"nfl_survival_generic_wave_starting_04",
				"nfl_survival_generic_wave_starting_05",
				"nfl_survival_generic_wave_starting_06",
				"nfl_survival_generic_wave_starting_07",
				"nfl_survival_generic_wave_starting_08",
				"nfl_survival_generic_wave_starting_09"
			},
			randomize_indexes = {}
		},
		nfl_survival_generic_directional_warning_west = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"nfl_survival_generic_directional_warning_west_01",
				"nfl_survival_generic_directional_warning_west_02",
				"nfl_survival_generic_directional_warning_west_03",
				"nfl_survival_generic_directional_warning_west_04",
				"nfl_survival_generic_directional_warning_west_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nfl_survival_generic_directional_warning_west_01",
				"nfl_survival_generic_directional_warning_west_02",
				"nfl_survival_generic_directional_warning_west_03",
				"nfl_survival_generic_directional_warning_west_04",
				"nfl_survival_generic_directional_warning_west_05"
			},
			randomize_indexes = {}
		},
		nik_survival_mode = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_01",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_survival_mode_01",
				[2.0] = "nik_survival_mode_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nik_survival_mode_01",
				[2.0] = "nik_survival_mode_02"
			},
			randomize_indexes = {}
		}
	})

	return 
end
