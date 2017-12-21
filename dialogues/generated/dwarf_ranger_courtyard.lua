return function ()
	define_rule({
		name = "pdr_objective_courtyard_crescendo_starting",
		response = "pdr_objective_courtyard_crescendo_starting",
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
				"courtyard_crescendo_starting"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_crescendo_starting",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_crescendo_starting",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_courtyard_crescendo_close_to_ending",
		response = "pdr_objective_courtyard_crescendo_close_to_ending",
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
				"courtyard_crescendo_close_to_ending"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_crescendo_close_to_ending",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_crescendo_close_to_ending",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_courtyard_mission_completed",
		response = "pdr_objective_courtyard_mission_completed",
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
				"courtyard_mission_completed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_mission_completed",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_mission_completed",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_courtyard_well_in_danger",
		response = "pdr_objective_courtyard_well_in_danger",
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
				"courtyard_well_in_danger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_well_in_danger",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_well_in_danger",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_courtyard_well_is_lost",
		response = "pdr_objective_courtyard_well_is_lost",
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
				"courtyard_well_is_lost"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_well_is_lost",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_well_is_lost",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_courtyard_well_targeted",
		response = "pdr_objective_courtyard_well_targeted",
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
				"courtyard_well_targeted"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_well_targeted",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_well_targeted",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_courtyard_well_safe",
		response = "pdr_objective_courtyard_well_safe",
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
				"courtyard_well_safe"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_well_safe",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_well_safe",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_courtyard_calm_time",
		response = "pdr_objective_courtyard_calm_time",
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
				"courtyard_calm_time"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_calm_time",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_calm_time",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_courtyard_intro",
		response = "pdr_courtyard_intro",
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
				"courtyard_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_courtyard_intro_b",
		response = "pdr_courtyard_intro_b",
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
				"courtyard_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_courtyard_intro_c",
		response = "pdr_courtyard_intro_c",
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
				"courtyard_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_courtyard_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_courtyard_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pdr_objective_courtyard_crescendo_starting = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_courtyard_crescendo_starting_01",
				"pdr_objective_courtyard_crescendo_starting_02",
				"pdr_objective_courtyard_crescendo_starting_03",
				"pdr_objective_courtyard_crescendo_starting_04"
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
				"pdr_objective_courtyard_crescendo_starting_01",
				"pdr_objective_courtyard_crescendo_starting_02",
				"pdr_objective_courtyard_crescendo_starting_03",
				"pdr_objective_courtyard_crescendo_starting_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_courtyard_crescendo_close_to_ending = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_courtyard_crescendo_close_to_ending_01",
				"pdr_objective_courtyard_crescendo_close_to_ending_02",
				"pdr_objective_courtyard_crescendo_close_to_ending_03",
				"pdr_objective_courtyard_crescendo_close_to_ending_04"
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
				"pdr_objective_courtyard_crescendo_close_to_ending_01",
				"pdr_objective_courtyard_crescendo_close_to_ending_02",
				"pdr_objective_courtyard_crescendo_close_to_ending_03",
				"pdr_objective_courtyard_crescendo_close_to_ending_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_courtyard_calm_time = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_courtyard_calm_time_01",
				"pdr_objective_courtyard_calm_time_02",
				"pdr_objective_courtyard_calm_time_03",
				"pdr_objective_courtyard_calm_time_04"
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
				"pdr_objective_courtyard_calm_time_01",
				"pdr_objective_courtyard_calm_time_02",
				"pdr_objective_courtyard_calm_time_03",
				"pdr_objective_courtyard_calm_time_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_courtyard_well_in_danger = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_courtyard_well_in_danger_01",
				"pdr_objective_courtyard_well_in_danger_02",
				"pdr_objective_courtyard_well_in_danger_03",
				"pdr_objective_courtyard_well_in_danger_04"
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
				"pdr_objective_courtyard_well_in_danger_01",
				"pdr_objective_courtyard_well_in_danger_02",
				"pdr_objective_courtyard_well_in_danger_03",
				"pdr_objective_courtyard_well_in_danger_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_courtyard_well_is_lost = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_courtyard_well_is_lost_01",
				"pdr_objective_courtyard_well_is_lost_02",
				"pdr_objective_courtyard_well_is_lost_03",
				"pdr_objective_courtyard_well_is_lost_04"
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
				"pdr_objective_courtyard_well_is_lost_01",
				"pdr_objective_courtyard_well_is_lost_02",
				"pdr_objective_courtyard_well_is_lost_03",
				"pdr_objective_courtyard_well_is_lost_04"
			},
			randomize_indexes = {}
		},
		pdr_courtyard_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_courtyard_intro_a_01",
				[2.0] = "pdr_courtyard_intro_a_02"
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
				[1.0] = "pdr_courtyard_intro_a_01",
				[2.0] = "pdr_courtyard_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_courtyard_well_safe = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_courtyard_well_safe_01",
				"pdr_objective_courtyard_well_safe_02",
				"pdr_objective_courtyard_well_safe_03",
				"pdr_objective_courtyard_well_safe_04"
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
				"pdr_objective_courtyard_well_safe_01",
				"pdr_objective_courtyard_well_safe_02",
				"pdr_objective_courtyard_well_safe_03",
				"pdr_objective_courtyard_well_safe_04"
			},
			randomize_indexes = {}
		},
		pdr_courtyard_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_courtyard_intro_b_01",
				[2.0] = "pdr_courtyard_intro_b_02"
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
				[1.0] = "pdr_courtyard_intro_b_01",
				[2.0] = "pdr_courtyard_intro_b_02"
			},
			randomize_indexes = {}
		},
		pdr_courtyard_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_courtyard_intro_c_01",
				[2.0] = "pdr_courtyard_intro_c_02"
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
				[1.0] = "pdr_courtyard_intro_c_01",
				[2.0] = "pdr_courtyard_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_courtyard_well_targeted = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_courtyard_well_targeted_01",
				"pdr_objective_courtyard_well_targeted_02",
				"pdr_objective_courtyard_well_targeted_03",
				"pdr_objective_courtyard_well_targeted_04"
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
				"pdr_objective_courtyard_well_targeted_01",
				"pdr_objective_courtyard_well_targeted_02",
				"pdr_objective_courtyard_well_targeted_03",
				"pdr_objective_courtyard_well_targeted_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_courtyard_mission_completed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_courtyard",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_courtyard_mission_completed_01",
				"pdr_objective_courtyard_mission_completed_02",
				"pdr_objective_courtyard_mission_completed_03",
				"pdr_objective_courtyard_mission_completed_04"
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
				"pdr_objective_courtyard_mission_completed_01",
				"pdr_objective_courtyard_mission_completed_02",
				"pdr_objective_courtyard_mission_completed_03",
				"pdr_objective_courtyard_mission_completed_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
