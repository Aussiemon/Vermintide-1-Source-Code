return function ()
	define_rule({
		name = "pwh_objective_sewers_disgust",
		response = "pwh_objective_sewers_disgust",
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
				"sewers_disgust"
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
				"time_since_sewers_disgust",
				OP.TIMEDIFF,
				OP.GT,
				"#REF!"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_disgust",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_sewers_horde_defeated",
		response = "pwh_objective_sewers_horde_defeated",
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
				"sewers_horde_defeated"
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
				"time_since_sewers_horde_defeated",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_horde_defeated",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_sewers_seeing_first_gate",
		response = "pwh_objective_sewers_seeing_first_gate",
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
				"sewers_seeing_first_gate"
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
				"time_since_sewers_seeing_first_gate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_seeing_first_gate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_sewers_seeing_last_gate",
		response = "pwh_objective_sewers_seeing_last_gate",
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
				"sewers_seeing_last_gate"
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
				"time_since_sewers_seeing_last_gate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_seeing_last_gate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_sewers_crescendo_starting",
		response = "pwh_objective_sewers_crescendo_starting",
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
				"sewers_crescendo_starting"
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
				"time_since_sewers_crescendo_starting",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_crescendo_starting",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_sewers_entering_sewers",
		response = "pwh_objective_sewers_entering_sewers",
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
				"sewers_entering_sewers"
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
				"time_since_sewers_entering_sewers",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_entering_sewers",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_sewers_door_has_opened",
		response = "pwh_objective_sewers_door_has_opened",
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
				"sewers_door_has_opened"
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
				"time_since_sewers_door_has_opened",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_door_has_opened",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_sewers_intro",
		response = "pwh_sewers_intro",
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
				"sewers_intro"
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
				"time_since_sewers_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_sewers_intro_b",
		response = "pwh_sewers_intro_b",
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
				"sewers_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_sewers_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_sewers_intro_c",
		response = "pwh_sewers_intro_c",
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
				"sewers_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_sewers_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_objective_sewers_seeing_first_gate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_sewers_seeing_first_gate_01",
				"pwh_objective_sewers_seeing_first_gate_02",
				"pwh_objective_sewers_seeing_first_gate_03",
				"pwh_objective_sewers_seeing_first_gate_04"
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
				"pwh_objective_sewers_seeing_first_gate_01",
				"pwh_objective_sewers_seeing_first_gate_02",
				"pwh_objective_sewers_seeing_first_gate_03",
				"pwh_objective_sewers_seeing_first_gate_04"
			},
			randomize_indexes = {}
		},
		pwh_sewers_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_sewers_intro_a_01",
				[2.0] = "pwh_sewers_intro_a_02"
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
				[1.0] = "pwh_sewers_intro_a_01",
				[2.0] = "pwh_sewers_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_sewers_entering_sewers = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_sewers_entering_sewers_01",
				"pwh_objective_sewers_entering_sewers_02",
				"pwh_objective_sewers_entering_sewers_03",
				"pwh_objective_sewers_entering_sewers_04"
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
				"pwh_objective_sewers_entering_sewers_01",
				"pwh_objective_sewers_entering_sewers_02",
				"pwh_objective_sewers_entering_sewers_03",
				"pwh_objective_sewers_entering_sewers_04"
			},
			randomize_indexes = {}
		},
		pwh_sewers_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_sewers_intro_c_01",
				[2.0] = "pwh_sewers_intro_c_02"
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
				[1.0] = "pwh_sewers_intro_c_01",
				[2.0] = "pwh_sewers_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_sewers_disgust = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_sewers_disgust_01",
				"pwh_objective_sewers_disgust_02",
				"pwh_objective_sewers_disgust_03",
				"pwh_objective_sewers_disgust_04"
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
				"pwh_objective_sewers_disgust_01",
				"pwh_objective_sewers_disgust_02",
				"pwh_objective_sewers_disgust_03",
				"pwh_objective_sewers_disgust_04"
			},
			randomize_indexes = {}
		},
		pwh_sewers_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_sewers_intro_b_01",
				[2.0] = "pwh_sewers_intro_b_02"
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
				[1.0] = "pwh_sewers_intro_b_01",
				[2.0] = "pwh_sewers_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_sewers_crescendo_starting = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_sewers_crescendo_starting_01",
				"pwh_objective_sewers_crescendo_starting_02",
				"pwh_objective_sewers_crescendo_starting_03",
				"pwh_objective_sewers_crescendo_starting_04"
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
				"pwh_objective_sewers_crescendo_starting_01",
				"pwh_objective_sewers_crescendo_starting_02",
				"pwh_objective_sewers_crescendo_starting_03",
				"pwh_objective_sewers_crescendo_starting_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_sewers_door_has_opened = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_sewers_door_has_opened_01",
				"pwh_objective_sewers_door_has_opened_02",
				"pwh_objective_sewers_door_has_opened_03",
				"pwh_objective_sewers_door_has_opened_04"
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
				"pwh_objective_sewers_door_has_opened_01",
				"pwh_objective_sewers_door_has_opened_02",
				"pwh_objective_sewers_door_has_opened_03",
				"pwh_objective_sewers_door_has_opened_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_sewers_horde_defeated = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_sewers_horde_defeated_01",
				"pwh_objective_sewers_horde_defeated_02",
				"pwh_objective_sewers_horde_defeated_03",
				"pwh_objective_sewers_horde_defeated_04"
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
				"pwh_objective_sewers_horde_defeated_01",
				"pwh_objective_sewers_horde_defeated_02",
				"pwh_objective_sewers_horde_defeated_03",
				"pwh_objective_sewers_horde_defeated_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_sewers_seeing_last_gate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_sewers",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_sewers_seeing_last_gate_01",
				"pwh_objective_sewers_seeing_last_gate_02",
				"pwh_objective_sewers_seeing_last_gate_03",
				"pwh_objective_sewers_seeing_last_gate_04"
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
				"pwh_objective_sewers_seeing_last_gate_01",
				"pwh_objective_sewers_seeing_last_gate_02",
				"pwh_objective_sewers_seeing_last_gate_03",
				"pwh_objective_sewers_seeing_last_gate_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
