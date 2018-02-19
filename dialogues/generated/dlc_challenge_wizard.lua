return function ()
	define_rule({
		name = "pwe_level_wizard_challenge_surprise",
		response = "pwe_level_wizard_challenge_surprise",
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
				"level_wizard_challenge_surprise"
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
				"time_since_level_wizard_challenge_surprise",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_level_wizard_challenge_surprise",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_wizard_challenge_surprise",
		response = "pwh_level_wizard_challenge_surprise",
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
				"level_wizard_challenge_surprise"
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
				"time_since_level_wizard_challenge_surprise",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_level_wizard_challenge_surprise",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_level_wizard_challenge_surprise",
		response = "pbw_level_wizard_challenge_surprise",
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
				"level_wizard_challenge_surprise"
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
				"time_since_level_wizard_challenge_surprise",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_level_wizard_challenge_surprise",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_level_wizard_challenge_surprise",
		response = "pes_level_wizard_challenge_surprise",
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
				"level_wizard_challenge_surprise"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_level_wizard_challenge_surprise",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_level_wizard_challenge_surprise",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_level_wizard_challenge_surprise",
		response = "pdr_level_wizard_challenge_surprise",
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
				"level_wizard_challenge_surprise"
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
				"time_since_level_wizard_challenge_surprise",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_level_wizard_challenge_surprise",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "ntw_gameplay_greeting_challenge",
		name = "ntw_gameplay_greeting_challenge",
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
				"ntw_gameplay_greeting_challenge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"grey_wizard"
			}
		}
	})
	define_rule({
		response = "ntw_challenge_level_almost_closed",
		name = "ntw_challenge_level_almost_closed",
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
				"ntw_challenge_level_almost_closed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"grey_wizard"
			}
		}
	})
	define_rule({
		response = "ntw_challange_level_closing_time",
		name = "ntw_challange_level_closing_time",
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
				"ntw_challange_level_closing_time"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"grey_wizard"
			}
		}
	})
	add_dialogues({
		ntw_challenge_level_almost_closed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_challenge_wizard",
			category = "npc_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"ntw_gameplay_spell_progress_second_01",
				"ntw_gameplay_spell_progress_third_01",
				"ntw_gameplay_spell_progress_second_02",
				"ntw_gameplay_spell_progress_second_03"
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
				"ntw_gameplay_spell_progress_second_01",
				"ntw_gameplay_spell_progress_third_01",
				"ntw_gameplay_spell_progress_second_02",
				"ntw_gameplay_spell_progress_second_03"
			},
			randomize_indexes = {}
		},
		pes_level_wizard_challenge_surprise = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dlc_challenge_wizard",
			category = "player_alerts_boss",
			dialogue_animations_n = 3,
			sound_events = {
				"pes_objective_wizards_tower_generic_surprise_01",
				"pes_objective_wizards_tower_generic_surprise_02",
				"pes_objective_wizards_tower_wastelands_01"
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
				"pes_objective_wizards_tower_generic_surprise_01",
				"pes_objective_wizards_tower_generic_surprise_02",
				"pes_objective_wizards_tower_wastelands_01"
			},
			randomize_indexes = {}
		},
		ntw_challange_level_closing_time = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dlc_challenge_wizard",
			category = "npc_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "ntw_gameplay_spell_finished_challenge_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "ntw_gameplay_spell_finished_challenge_01"
			}
		},
		pwe_level_wizard_challenge_surprise = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_challenge_wizard",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_wizards_tower_generic_surprise_second_01",
				"pwe_objective_wizards_tower_generic_surprise_second_02",
				"pwe_objective_wizards_tower_generic_surprise_second_04",
				"pwe_objective_wizards_tower_generic_surprise_04"
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
				"pwe_objective_wizards_tower_generic_surprise_second_01",
				"pwe_objective_wizards_tower_generic_surprise_second_02",
				"pwe_objective_wizards_tower_generic_surprise_second_04",
				"pwe_objective_wizards_tower_generic_surprise_04"
			},
			randomize_indexes = {}
		},
		pwh_level_wizard_challenge_surprise = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_challenge_wizard",
			category = "player_alerts_boss",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_wizards_tower_hall_of_mysteries_04",
				[2.0] = "pwh_objective_wizards_tower_hall_of_mysteries_01"
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
				[1.0] = "pwh_objective_wizards_tower_hall_of_mysteries_04",
				[2.0] = "pwh_objective_wizards_tower_hall_of_mysteries_01"
			},
			randomize_indexes = {}
		},
		pbw_level_wizard_challenge_surprise = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_challenge_wizard",
			category = "player_alerts_boss",
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
		pdr_level_wizard_challenge_surprise = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dlc_challenge_wizard",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_wizards_tower_generic_surprise_02",
				"pdr_objective_wizards_tower_wastelands_01",
				"pdr_objective_wizards_tower_generic_surprise_second_02",
				"pdr_objective_wizards_tower_generic_surprise_second_01"
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
				"pdr_objective_wizards_tower_generic_surprise_02",
				"pdr_objective_wizards_tower_wastelands_01",
				"pdr_objective_wizards_tower_generic_surprise_second_02",
				"pdr_objective_wizards_tower_generic_surprise_second_01"
			},
			randomize_indexes = {}
		},
		ntw_gameplay_greeting_challenge = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dlc_challenge_wizard",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "ntw_gameplay_greeting_challenge_01",
				[2.0] = "ntw_gameplay_greeting_challenge_02"
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
				[1.0] = "ntw_gameplay_greeting_challenge_01",
				[2.0] = "ntw_gameplay_greeting_challenge_02"
			},
			randomize_indexes = {}
		}
	})

	return 
end
