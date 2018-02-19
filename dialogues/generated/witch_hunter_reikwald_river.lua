return function ()
	define_rule({
		name = "pwh_level_reikwald_river_missing_barge",
		response = "pwh_level_reikwald_river_missing_barge",
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
				"level_reikwald_river_missing_barge"
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
				"level_reikwald_river_missing_barge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_missing_barge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_river_bodies",
		response = "pwh_level_reikwald_river_bodies",
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
				"level_reikwald_river_bodies"
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
				"level_reikwald_river_bodies",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_bodies",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_river_new_barge",
		response = "pwh_level_reikwald_river_new_barge",
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
				"level_reikwald_river_new_barge"
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
				"level_reikwald_river_new_barge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_new_barge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_river_current",
		response = "pwh_level_reikwald_river_current",
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
				"level_reikwald_river_current"
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
				"level_reikwald_river_current",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_current",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_river_boarding",
		response = "pwh_level_reikwald_river_boarding",
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
				"level_reikwald_river_boarding"
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
				"level_reikwald_river_boarding",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_boarding",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_river_boarding_again",
		response = "pwh_level_reikwald_river_boarding_again",
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
				"level_reikwald_river_boarding_again"
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
				"level_reikwald_river_boarding_again",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_boarding_again",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_river_dawnrunner_sighted",
		response = "pwh_level_reikwald_river_dawnrunner_sighted",
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
				"level_reikwald_river_dawnrunner_sighted"
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
				"level_reikwald_river_dawnrunner_sighted",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_dawnrunner_sighted",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwalk_river_dead_thief",
		response = "pwh_level_reikwalk_river_dead_thief",
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
				"level_reikwalk_river_dead_thief"
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
				"level_reikwalk_river_dead_thief",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwalk_river_dead_thief",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwalk_river_burn",
		response = "pwh_level_reikwalk_river_burn",
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
				"level_reikwalk_river_burn"
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
				"level_reikwalk_river_burn",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwalk_river_burn",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_river_complete",
		response = "pwh_level_reikwald_river_complete",
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
				"level_reikwald_river_complete"
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
				"level_reikwald_river_complete",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_complete",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_river_rune",
		response = "pwh_level_reikwald_river_rune",
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
				"level_reikwald_river_rune"
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
				"level_reikwald_river_rune",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_river_rune",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_reikwald_river_intro_a",
		response = "pwh_reikwald_river_intro_a",
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
				"reikwald_river_intro_a"
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
				"reikwald_river_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"reikwald_river_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_reikwald_river_intro_b",
		response = "pwh_reikwald_river_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"reikwald_river_intro_a"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"reikwald_river_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"reikwald_river_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_reikwald_river_intro_c",
		response = "pwh_reikwald_river_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"reikwald_river_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"reikwald_river_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"reikwald_river_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_level_reikwalk_river_dead_thief = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwalk_river_dead_thief_01",
				"pwh_level_reikwalk_river_dead_thief_02",
				"pwh_level_reikwalk_river_dead_thief_03",
				"pwh_level_reikwalk_river_dead_thief_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pwh_level_reikwalk_river_dead_thief_01",
				"pwh_level_reikwalk_river_dead_thief_02",
				"pwh_level_reikwalk_river_dead_thief_03",
				"pwh_level_reikwalk_river_dead_thief_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_rune = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_level_reikwald_river_rune_01",
				[2.0] = "pwh_level_reikwald_river_rune_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout",
				[2.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_fear",
				[2.0] = "face_fear"
			},
			localization_strings = {
				[1.0] = "pwh_level_reikwald_river_rune_01",
				[2.0] = "pwh_level_reikwald_river_rune_02"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_missing_barge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_river_missing_barge_01",
				"pwh_level_reikwald_river_missing_barge_02",
				"pwh_level_reikwald_river_missing_barge_03",
				"pwh_level_reikwald_river_missing_barge_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_calm",
				"face_calm",
				"face_calm",
				"face_calm"
			},
			localization_strings = {
				"pwh_level_reikwald_river_missing_barge_01",
				"pwh_level_reikwald_river_missing_barge_02",
				"pwh_level_reikwald_river_missing_barge_03",
				"pwh_level_reikwald_river_missing_barge_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_boarding = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_river_boarding_01",
				"pwh_level_reikwald_river_boarding_02",
				"pwh_level_reikwald_river_boarding_03",
				"pwh_level_reikwald_river_boarding_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_level_reikwald_river_boarding_01",
				"pwh_level_reikwald_river_boarding_02",
				"pwh_level_reikwald_river_boarding_03",
				"pwh_level_reikwald_river_boarding_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_dawnrunner_sighted = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_river_dawnrunner_sighted_01",
				"pwh_level_reikwald_river_dawnrunner_sighted_02",
				"pwh_level_reikwald_river_dawnrunner_sighted_03",
				"pwh_level_reikwald_river_dawnrunner_sighted_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise"
			},
			localization_strings = {
				"pwh_level_reikwald_river_dawnrunner_sighted_01",
				"pwh_level_reikwald_river_dawnrunner_sighted_02",
				"pwh_level_reikwald_river_dawnrunner_sighted_03",
				"pwh_level_reikwald_river_dawnrunner_sighted_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_bodies = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_river_bodies_01",
				"pwh_level_reikwald_river_bodies_02",
				"pwh_level_reikwald_river_bodies_03",
				"pwh_level_reikwald_river_bodies_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_calm",
				"face_calm",
				"face_calm",
				"face_calm"
			},
			localization_strings = {
				"pwh_level_reikwald_river_bodies_01",
				"pwh_level_reikwald_river_bodies_02",
				"pwh_level_reikwald_river_bodies_03",
				"pwh_level_reikwald_river_bodies_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_current = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_river_current_01",
				"pwh_level_reikwald_river_current_02",
				"pwh_level_reikwald_river_current_03",
				"pwh_level_reikwald_river_current_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pwh_level_reikwald_river_current_01",
				"pwh_level_reikwald_river_current_02",
				"pwh_level_reikwald_river_current_03",
				"pwh_level_reikwald_river_current_04"
			},
			randomize_indexes = {}
		},
		pwh_reikwald_river_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_reikwald_river_intro_c_01",
				[2.0] = "pwh_reikwald_river_intro_c_02"
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
				[1.0] = "pwh_reikwald_river_intro_c_01",
				[2.0] = "pwh_reikwald_river_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_reikwald_river_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_reikwald_river_intro_b_01",
				[2.0] = "pwh_reikwald_river_intro_b_02"
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
				[1.0] = "pwh_reikwald_river_intro_b_01",
				[2.0] = "pwh_reikwald_river_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_boarding_again = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_river_boarding_again_01",
				"pwh_level_reikwald_river_boarding_again_02",
				"pwh_level_reikwald_river_boarding_again_03",
				"pwh_level_reikwald_river_boarding_again_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_level_reikwald_river_boarding_again_01",
				"pwh_level_reikwald_river_boarding_again_02",
				"pwh_level_reikwald_river_boarding_again_03",
				"pwh_level_reikwald_river_boarding_again_04"
			},
			randomize_indexes = {}
		},
		pwh_reikwald_river_intro_a = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_reikwald_river_intro_a_01",
				[2.0] = "pwh_reikwald_river_intro_a_02"
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
				[1.0] = "pwh_reikwald_river_intro_a_01",
				[2.0] = "pwh_reikwald_river_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_complete = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_river_complete_01",
				"pwh_level_reikwald_river_complete_02",
				"pwh_level_reikwald_river_complete_03",
				"pwh_level_reikwald_river_complete_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pwh_level_reikwald_river_complete_01",
				"pwh_level_reikwald_river_complete_02",
				"pwh_level_reikwald_river_complete_03",
				"pwh_level_reikwald_river_complete_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwalk_river_burn = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwalk_river_burn_01",
				"pwh_level_reikwalk_river_burn_02",
				"pwh_level_reikwalk_river_burn_03",
				"pwh_level_reikwalk_river_burn_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pwh_level_reikwalk_river_burn_01",
				"pwh_level_reikwalk_river_burn_02",
				"pwh_level_reikwalk_river_burn_03",
				"pwh_level_reikwalk_river_burn_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_river_new_barge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_river",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_river_new_barge_01",
				"pwh_level_reikwald_river_new_barge_02",
				"pwh_level_reikwald_river_new_barge_03",
				"pwh_level_reikwald_river_new_barge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_calm",
				"face_calm",
				"face_calm",
				"face_calm"
			},
			localization_strings = {
				"pwh_level_reikwald_river_new_barge_01",
				"pwh_level_reikwald_river_new_barge_02",
				"pwh_level_reikwald_river_new_barge_03",
				"pwh_level_reikwald_river_new_barge_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
