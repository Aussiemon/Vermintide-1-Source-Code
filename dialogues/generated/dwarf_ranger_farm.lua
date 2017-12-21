return function ()
	define_rule({
		name = "pdr_objective_farm_supply_started",
		response = "pdr_objective_farm_supply_started",
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
				"objective_farm_supply_started"
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
				"time_since_objective_farm_supply_started",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_farm_supply_started",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_farm_supply_midway",
		response = "pdr_objective_farm_supply_midway",
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
				"objective_farm_supply_midway"
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
				"time_since_objective_farm_supply_midway",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_farm_supply_midway",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_farm_supply_successful",
		response = "pdr_objective_farm_supply_successful",
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
				"objective_farm_supply_successful"
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
				"time_since_objective_farm_supply_successful",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_farm_supply_successful",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_farm_mission_successful",
		response = "pdr_objective_farm_mission_successful",
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
				"objective_farm_mission_successful"
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
				"time_since_objective_farm_mission_successful",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_farm_mission_successful",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_farm_spotting_farm",
		response = "pdr_objective_farm_spotting_farm",
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
				"objective_farm_spotting_farm"
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
				"time_since_objective_farm_spotting_farm",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_farm_spotting_farm",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_farm_search_the_area",
		response = "pdr_objective_farm_search_the_area",
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
				"objective_farm_search_the_area"
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
				"time_since_objective_farm_search_the_area",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_farm_search_the_area",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_farm_intro",
		response = "pdr_farm_intro",
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
				"objective_farm_intro"
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
				"time_since_farm_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_farm_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_farm_intro_b",
		response = "pdr_farm_intro_b",
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
				"objective_farm_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_farm_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_farm_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_farm_intro_c",
		response = "pdr_farm_intro_c",
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
				"farm_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_farm_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_farm_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pdr_objective_farm_search_the_area = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_farm_search_the_area_01",
				"pdr_objective_farm_search_the_area_02",
				"pdr_objective_farm_search_the_area_03",
				"pdr_objective_farm_search_the_area_04"
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
				"pdr_objective_farm_search_the_area_01",
				"pdr_objective_farm_search_the_area_02",
				"pdr_objective_farm_search_the_area_03",
				"pdr_objective_farm_search_the_area_04"
			},
			randomize_indexes = {}
		},
		pdr_farm_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_farm_intro_c_01",
				[2.0] = "pdr_farm_intro_c_02"
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
				[1.0] = "pdr_farm_intro_c_01",
				[2.0] = "pdr_farm_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_farm_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_farm_intro_a_01",
				[2.0] = "pdr_farm_intro_a_02"
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
				[1.0] = "pdr_farm_intro_a_01",
				[2.0] = "pdr_farm_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_farm_spotting_farm = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_farm_spotting_farm_01",
				"pdr_objective_farm_spotting_farm_02",
				"pdr_objective_farm_spotting_farm_03",
				"pdr_objective_farm_spotting_farm_04"
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
				"pdr_objective_farm_spotting_farm_01",
				"pdr_objective_farm_spotting_farm_02",
				"pdr_objective_farm_spotting_farm_03",
				"pdr_objective_farm_spotting_farm_04"
			},
			randomize_indexes = {}
		},
		pdr_farm_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_farm_intro_b_01",
				[2.0] = "pdr_farm_intro_b_02"
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
				[1.0] = "pdr_farm_intro_b_01",
				[2.0] = "pdr_farm_intro_b_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_farm_supply_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_farm_supply_successful_01",
				"pdr_objective_farm_supply_successful_02",
				"pdr_objective_farm_supply_successful_03",
				"pdr_objective_farm_supply_successful_04"
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
				"pdr_objective_farm_supply_successful_01",
				"pdr_objective_farm_supply_successful_02",
				"pdr_objective_farm_supply_successful_03",
				"pdr_objective_farm_supply_successful_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_farm_supply_started = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_farm_supply_started_01",
				"pdr_objective_farm_supply_started_02",
				"pdr_objective_farm_supply_started_03",
				"pdr_objective_farm_supply_started_04"
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
				"pdr_objective_farm_supply_started_01",
				"pdr_objective_farm_supply_started_02",
				"pdr_objective_farm_supply_started_03",
				"pdr_objective_farm_supply_started_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_farm_supply_midway = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_farm_supply_midway_01",
				"pdr_objective_farm_supply_midway_02",
				"pdr_objective_farm_supply_midway_03",
				"pdr_objective_farm_supply_midway_04"
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
				"pdr_objective_farm_supply_midway_01",
				"pdr_objective_farm_supply_midway_02",
				"pdr_objective_farm_supply_midway_03",
				"pdr_objective_farm_supply_midway_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_farm_mission_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger_farm",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_farm_mission_successful_01",
				"pdr_objective_farm_mission_successful_02",
				"pdr_objective_farm_mission_successful_03",
				"pdr_objective_farm_mission_successful_04"
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
				"pdr_objective_farm_mission_successful_01",
				"pdr_objective_farm_mission_successful_02",
				"pdr_objective_farm_mission_successful_03",
				"pdr_objective_farm_mission_successful_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
