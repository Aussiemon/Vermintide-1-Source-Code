return function ()
	define_rule({
		name = "pwe_objective_bridge_shanty_town",
		response = "pwe_objective_bridge_shanty_town",
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
				"bridge_shanty_town"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_bridge_shanty_town",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_bridge_shanty_town",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_bridge_crescendo_starting",
		response = "pwe_objective_bridge_crescendo_starting",
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
				"bridge_reaching_the_bridge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_bridge_reaching_the_bridge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_bridge_reaching_the_bridge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_bridge_close_to_the_bridge",
		response = "pwe_objective_bridge_close_to_the_bridge",
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
				"bridge_close_to_the_bridge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_bridge_close_to_the_bridge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_bridge_close_to_the_bridge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_bridge_mission_completed",
		response = "pwe_objective_bridge_mission_completed",
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
				"bridge_mission_completed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_bridge_mission_completed",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_bridge_mission_completed",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_bridge_treasure",
		response = "pwe_objective_bridge_treasure",
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
				"bridge_treasure"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_bridge_treasure",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_bridge_treasure",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_bridge_intro",
		response = "pwe_bridge_intro",
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
				"bridge_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_bridge_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_bridge_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_bridge_intro_b",
		response = "pwe_bridge_intro_b",
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
				"bridge_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_bridge_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_bridge_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_bridge_intro_c",
		response = "pwe_bridge_intro_c",
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
				"bridge_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_bridge_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_bridge_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwe_bridge_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_bridge",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_bridge_intro_c_01",
				[2.0] = "pwe_bridge_intro_c_02"
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
				[1.0] = "pwe_bridge_intro_c_01",
				[2.0] = "pwe_bridge_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwe_bridge_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_bridge",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_bridge_intro_b_01",
				[2.0] = "pwe_bridge_intro_b_02"
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
				[1.0] = "pwe_bridge_intro_b_01",
				[2.0] = "pwe_bridge_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_bridge_crescendo_starting = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_bridge",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_bridge_crescendo_starting_01",
				"pwe_objective_bridge_crescendo_starting_02",
				"pwe_objective_bridge_crescendo_starting_03",
				"pwe_objective_bridge_crescendo_starting_04"
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
				"pwe_objective_bridge_crescendo_starting_01",
				"pwe_objective_bridge_crescendo_starting_02",
				"pwe_objective_bridge_crescendo_starting_03",
				"pwe_objective_bridge_crescendo_starting_04"
			},
			randomize_indexes = {}
		},
		pwe_bridge_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_bridge",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_bridge_intro_a_01",
				[2.0] = "pwe_bridge_intro_a_02"
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
				[1.0] = "pwe_bridge_intro_a_01",
				[2.0] = "pwe_bridge_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_bridge_mission_completed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_bridge",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_bridge_mission_completed_01",
				"pwe_objective_bridge_mission_completed_02",
				"pwe_objective_bridge_mission_completed_03",
				"pwe_objective_bridge_mission_completed_04"
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
				"pwe_objective_bridge_mission_completed_01",
				"pwe_objective_bridge_mission_completed_02",
				"pwe_objective_bridge_mission_completed_03",
				"pwe_objective_bridge_mission_completed_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_bridge_treasure = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_bridge",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_bridge_treasure_01",
				[2.0] = "pwe_objective_bridge_treasure_02"
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
				[1.0] = "pwe_objective_bridge_treasure_01",
				[2.0] = "pwe_objective_bridge_treasure_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_bridge_close_to_the_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_bridge",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_bridge_close_to_the_bridge_01",
				"pwe_objective_bridge_close_to_the_bridge_02",
				"pwe_objective_bridge_close_to_the_bridge_03",
				"pwe_objective_bridge_close_to_the_bridge_04"
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
				"pwe_objective_bridge_close_to_the_bridge_01",
				"pwe_objective_bridge_close_to_the_bridge_02",
				"pwe_objective_bridge_close_to_the_bridge_03",
				"pwe_objective_bridge_close_to_the_bridge_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_bridge_shanty_town = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_bridge",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_bridge_shanty_town_01",
				"pwe_objective_bridge_shanty_town_02",
				"pwe_objective_bridge_shanty_town_03",
				"pwe_objective_bridge_shanty_town_04"
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
				"pwe_objective_bridge_shanty_town_01",
				"pwe_objective_bridge_shanty_town_02",
				"pwe_objective_bridge_shanty_town_03",
				"pwe_objective_bridge_shanty_town_04"
			},
			randomize_indexes = {}
		}
	})
end
