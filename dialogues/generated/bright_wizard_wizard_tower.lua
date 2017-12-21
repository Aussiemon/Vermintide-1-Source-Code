return function ()
	define_rule({
		name = "pbw_objective_wizards_tower_reaching_apothecary_shop",
		response = "pbw_objective_wizards_tower_reaching_apothecary_shop",
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
				"wizards_tower_reaching_apothecary_shop"
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
				"faction_memory",
				"time_since_wizards_tower_reaching_apothecary_shop",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_reaching_apothecary_shop",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_skaven_attacking_wards",
		response = "pbw_objective_wizards_tower_skaven_attacking_wards",
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
				"wizards_tower_skaven_attacking_wards"
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
				"faction_memory",
				"time_since_wizards_tower_skaven_attacking_wards",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_skaven_attacking_wards",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_mission_successful",
		response = "pbw_objective_wizards_tower_mission_successful",
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
				"wizards_tower_mission_successful"
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
				"faction_memory",
				"time_since_wizards_tower_mission_successful",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_mission_successful",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_generic_surprise",
		response = "pbw_objective_wizards_tower_generic_surprise",
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
				"wizards_tower_generic_surprise"
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
				"faction_memory",
				"time_since_wizards_tower_generic_surprise",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_generic_surprise",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_library",
		response = "pbw_objective_wizards_tower_library",
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
				"wizards_tower_library"
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
				"faction_memory",
				"time_since_wizards_tower_library",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_library",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_open_door",
		response = "pbw_objective_wizards_tower_open_door",
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
				"wizards_tower_open_door"
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
				"faction_memory",
				"time_since_wizards_tower_open_door",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_open_door",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_wastelands",
		response = "pbw_objective_wizards_tower_wastelands",
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
				"wizards_tower_wastelands"
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
				"faction_memory",
				"time_since_wizards_tower_wastelands",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_wastelands",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_seeing_tower_from_from_afar",
		response = "pbw_objective_wizards_tower_seeing_tower_from_from_afar",
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
				"wizards_tower_seeing_tower_from_from_afar"
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
				"faction_memory",
				"time_since_wizards_tower_seeing_tower_from_from_afar",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_seeing_tower_from_from_afar",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_seeing_the_apotechary",
		response = "pbw_objective_wizards_tower_seeing_the_apotechary",
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
				"wizards_tower_seeing_the_apotechary"
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
				"faction_memory",
				"time_since_wizards_tower_seeing_the_apotechary",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_seeing_the_apotechary",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_crescendo_starting",
		response = "pbw_objective_wizards_tower_crescendo_starting",
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
				"wizards_tower_crescendo_starting"
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
				"faction_memory",
				"time_since_wizards_tower_crescendo_starting",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_crescendo_starting",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_generic_surprise_second",
		response = "pbw_objective_wizards_tower_generic_surprise_second",
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
				"wizards_tower_generic_surprise_second"
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
				"faction_memory",
				"time_since_wizards_tower_generic_surprise_second",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_generic_surprise_second",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_crescendo_end",
		response = "pbw_objective_wizards_tower_crescendo_end",
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
				"wizards_tower_crescendo_end"
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
				"faction_memory",
				"time_since_wizards_tower_crescendo_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_crescendo_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_finding_wizard",
		response = "pbw_objective_wizards_tower_finding_wizard",
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
				"wizards_tower_finding_wizard"
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
				"faction_memory",
				"time_since_wizards_tower_finding_wizard",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_finding_wizard",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_commenting_skaven",
		response = "pbw_objective_wizards_tower_commenting_skaven",
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
				"wizards_tower_commenting_skaven"
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
				"faction_memory",
				"time_since_wizards_tower_commenting_skaven",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_commenting_skaven",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_hall_of_mysteries",
		response = "pbw_objective_wizards_tower_hall_of_mysteries",
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
				"wizards_tower_hall_of_mysteries"
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
				"faction_memory",
				"time_since_wizards_tower_hall_of_mysteries",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_hall_of_mysteries",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_illusion_room",
		response = "pbw_objective_wizards_tower_illusion_room",
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
				"wizards_tower_illusion_room"
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
				"faction_memory",
				"time_since_wizards_tower_illusion_room",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_illusion_room",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_close_to_wizard",
		response = "pbw_objective_wizards_tower_close_to_wizard",
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
				"wizards_tower_close_to_wizard"
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
				"faction_memory",
				"time_since_wizards_tower_close_to_wizard",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_close_to_wizard",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_wizards_tower_commenting_paintings",
		response = "pbw_objective_wizards_tower_commenting_paintings",
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
				"wizards_tower_commenting_paintings"
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
				"faction_memory",
				"time_since_wizards_tower_commenting_paintings",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_commenting_paintings",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_wizards_tower_intro",
		response = "pbw_wizards_tower_intro",
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
				"wizards_tower_intro"
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
				"faction_memory",
				"time_since_wizards_tower_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_wizards_tower_intro_b",
		response = "pbw_wizards_tower_intro_b",
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
				"wizards_tower_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_wizards_tower_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_wizards_tower_intro_c",
		response = "pbw_wizards_tower_intro_c",
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
				"wizards_tower_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_wizards_tower_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_wizards_tower_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pbw_objective_wizards_tower_generic_surprise_second = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_generic_surprise_second_01",
				"pbw_objective_wizards_tower_generic_surprise_second_02",
				"pbw_objective_wizards_tower_generic_surprise_second_03",
				"pbw_objective_wizards_tower_generic_surprise_second_04"
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
				"pbw_objective_wizards_tower_generic_surprise_second_01",
				"pbw_objective_wizards_tower_generic_surprise_second_02",
				"pbw_objective_wizards_tower_generic_surprise_second_03",
				"pbw_objective_wizards_tower_generic_surprise_second_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_library = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_library_01",
				"pbw_objective_wizards_tower_library_02",
				"pbw_objective_wizards_tower_library_03",
				"pbw_objective_wizards_tower_library_04"
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
				"pbw_objective_wizards_tower_library_01",
				"pbw_objective_wizards_tower_library_02",
				"pbw_objective_wizards_tower_library_03",
				"pbw_objective_wizards_tower_library_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_close_to_wizard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_close_to_wizard_01",
				"pbw_objective_wizards_tower_close_to_wizard_02",
				"pbw_objective_wizards_tower_close_to_wizard_03",
				"pbw_objective_wizards_tower_close_to_wizard_04"
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
				"pbw_objective_wizards_tower_close_to_wizard_01",
				"pbw_objective_wizards_tower_close_to_wizard_02",
				"pbw_objective_wizards_tower_close_to_wizard_03",
				"pbw_objective_wizards_tower_close_to_wizard_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_finding_wizard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_finding_wizard_01",
				"pbw_objective_wizards_tower_finding_wizard_02",
				"pbw_objective_wizards_tower_finding_wizard_03",
				"pbw_objective_wizards_tower_finding_wizard_04"
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
				"pbw_objective_wizards_tower_finding_wizard_01",
				"pbw_objective_wizards_tower_finding_wizard_02",
				"pbw_objective_wizards_tower_finding_wizard_03",
				"pbw_objective_wizards_tower_finding_wizard_04"
			},
			randomize_indexes = {}
		},
		pbw_wizards_tower_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_wizards_tower_intro_c_01",
				[2.0] = "pbw_wizards_tower_intro_c_02"
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
				[1.0] = "pbw_wizards_tower_intro_c_01",
				[2.0] = "pbw_wizards_tower_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_commenting_skaven = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_commenting_skaven_01",
				"pbw_objective_wizards_tower_commenting_skaven_02",
				"pbw_objective_wizards_tower_commenting_skaven_03",
				"pbw_objective_wizards_tower_commenting_skaven_04"
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
				"pbw_objective_wizards_tower_commenting_skaven_01",
				"pbw_objective_wizards_tower_commenting_skaven_02",
				"pbw_objective_wizards_tower_commenting_skaven_03",
				"pbw_objective_wizards_tower_commenting_skaven_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_crescendo_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_crescendo_end_01",
				"pbw_objective_wizards_tower_crescendo_end_02",
				"pbw_objective_wizards_tower_crescendo_end_03",
				"pbw_objective_wizards_tower_crescendo_end_04"
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
				"pbw_objective_wizards_tower_crescendo_end_01",
				"pbw_objective_wizards_tower_crescendo_end_02",
				"pbw_objective_wizards_tower_crescendo_end_03",
				"pbw_objective_wizards_tower_crescendo_end_04"
			},
			randomize_indexes = {}
		},
		pbw_wizards_tower_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_wizards_tower_intro_b_01",
				[2.0] = "pbw_wizards_tower_intro_b_02"
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
				[1.0] = "pbw_wizards_tower_intro_b_01",
				[2.0] = "pbw_wizards_tower_intro_b_02"
			},
			randomize_indexes = {}
		},
		pbw_wizards_tower_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_wizards_tower_intro_a_01",
				[2.0] = "pbw_wizards_tower_intro_a_02"
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
				[1.0] = "pbw_wizards_tower_intro_a_01",
				[2.0] = "pbw_wizards_tower_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_commenting_paintings = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_commenting_paintings_01",
				"pbw_objective_wizards_tower_commenting_paintings_02",
				"pbw_objective_wizards_tower_commenting_paintings_03",
				"pbw_objective_wizards_tower_commenting_paintings_04"
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
				"pbw_objective_wizards_tower_commenting_paintings_01",
				"pbw_objective_wizards_tower_commenting_paintings_02",
				"pbw_objective_wizards_tower_commenting_paintings_03",
				"pbw_objective_wizards_tower_commenting_paintings_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_skaven_attacking_wards = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_skaven_attacking_wards_01",
				"pbw_objective_wizards_tower_skaven_attacking_wards_02",
				"pbw_objective_wizards_tower_skaven_attacking_wards_03",
				"pbw_objective_wizards_tower_skaven_attacking_wards_04"
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
				"pbw_objective_wizards_tower_skaven_attacking_wards_01",
				"pbw_objective_wizards_tower_skaven_attacking_wards_02",
				"pbw_objective_wizards_tower_skaven_attacking_wards_03",
				"pbw_objective_wizards_tower_skaven_attacking_wards_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_illusion_room = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_illusion_room_01",
				"pbw_objective_wizards_tower_illusion_room_02",
				"pbw_objective_wizards_tower_illusion_room_03",
				"pbw_objective_wizards_tower_illusion_room_04"
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
				"pbw_objective_wizards_tower_illusion_room_01",
				"pbw_objective_wizards_tower_illusion_room_02",
				"pbw_objective_wizards_tower_illusion_room_03",
				"pbw_objective_wizards_tower_illusion_room_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_generic_surprise = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_generic_surprise_01",
				"pbw_objective_wizards_tower_generic_surprise_02",
				"pbw_objective_wizards_tower_generic_surprise_03",
				"pbw_objective_wizards_tower_generic_surprise_04"
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
				"pbw_objective_wizards_tower_generic_surprise_01",
				"pbw_objective_wizards_tower_generic_surprise_02",
				"pbw_objective_wizards_tower_generic_surprise_03",
				"pbw_objective_wizards_tower_generic_surprise_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_crescendo_starting = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_crescendo_starting_01",
				"pbw_objective_wizards_tower_crescendo_starting_02",
				"pbw_objective_wizards_tower_crescendo_starting_03",
				"pbw_objective_wizards_tower_crescendo_starting_04"
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
				"pbw_objective_wizards_tower_crescendo_starting_01",
				"pbw_objective_wizards_tower_crescendo_starting_02",
				"pbw_objective_wizards_tower_crescendo_starting_03",
				"pbw_objective_wizards_tower_crescendo_starting_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_wastelands = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_wastelands_01",
				"pbw_objective_wizards_tower_wastelands_02",
				"pbw_objective_wizards_tower_wastelands_03",
				"pbw_objective_wizards_tower_wastelands_04"
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
				"pbw_objective_wizards_tower_wastelands_01",
				"pbw_objective_wizards_tower_wastelands_02",
				"pbw_objective_wizards_tower_wastelands_03",
				"pbw_objective_wizards_tower_wastelands_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_hall_of_mysteries = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_hall_of_mysteries_01",
				"pbw_objective_wizards_tower_hall_of_mysteries_02",
				"pbw_objective_wizards_tower_hall_of_mysteries_03",
				"pbw_objective_wizards_tower_hall_of_mysteries_04"
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
				"pbw_objective_wizards_tower_hall_of_mysteries_01",
				"pbw_objective_wizards_tower_hall_of_mysteries_02",
				"pbw_objective_wizards_tower_hall_of_mysteries_03",
				"pbw_objective_wizards_tower_hall_of_mysteries_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_seeing_tower_from_from_afar = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_seeing_tower_from_from_afar_01",
				"pbw_objective_wizards_tower_seeing_tower_from_from_afar_02",
				"pbw_objective_wizards_tower_seeing_tower_from_from_afar_03",
				"pbw_objective_wizards_tower_seeing_tower_from_from_afar_04"
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
				"pbw_objective_wizards_tower_seeing_tower_from_from_afar_01",
				"pbw_objective_wizards_tower_seeing_tower_from_from_afar_02",
				"pbw_objective_wizards_tower_seeing_tower_from_from_afar_03",
				"pbw_objective_wizards_tower_seeing_tower_from_from_afar_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_mission_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_mission_successful_01",
				"pbw_objective_wizards_tower_mission_successful_02",
				"pbw_objective_wizards_tower_mission_successful_03",
				"pbw_objective_wizards_tower_mission_successful_04"
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
				"pbw_objective_wizards_tower_mission_successful_01",
				"pbw_objective_wizards_tower_mission_successful_02",
				"pbw_objective_wizards_tower_mission_successful_03",
				"pbw_objective_wizards_tower_mission_successful_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_seeing_the_apotechary = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_seeing_the_apotechary_01",
				"pbw_objective_wizards_tower_seeing_the_apotechary_02",
				"pbw_objective_wizards_tower_seeing_the_apotechary_03",
				"pbw_objective_wizards_tower_seeing_the_apotechary_04"
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
				"pbw_objective_wizards_tower_seeing_the_apotechary_01",
				"pbw_objective_wizards_tower_seeing_the_apotechary_02",
				"pbw_objective_wizards_tower_seeing_the_apotechary_03",
				"pbw_objective_wizards_tower_seeing_the_apotechary_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_open_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_open_door_01",
				"pbw_objective_wizards_tower_open_door_02",
				"pbw_objective_wizards_tower_open_door_03",
				"pbw_objective_wizards_tower_open_door_04"
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
				"pbw_objective_wizards_tower_open_door_01",
				"pbw_objective_wizards_tower_open_door_02",
				"pbw_objective_wizards_tower_open_door_03",
				"pbw_objective_wizards_tower_open_door_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_wizards_tower_reaching_apothecary_shop = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_wizard_tower",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_wizards_tower_reaching_apothecary_shop_01",
				"pbw_objective_wizards_tower_reaching_apothecary_shop_02",
				"pbw_objective_wizards_tower_reaching_apothecary_shop_03",
				"pbw_objective_wizards_tower_reaching_apothecary_shop_04"
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
				"pbw_objective_wizards_tower_reaching_apothecary_shop_01",
				"pbw_objective_wizards_tower_reaching_apothecary_shop_02",
				"pbw_objective_wizards_tower_reaching_apothecary_shop_03",
				"pbw_objective_wizards_tower_reaching_apothecary_shop_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
