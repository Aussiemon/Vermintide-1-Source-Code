return function ()
	define_rule({
		response = "ect_gameplay_introduction",
		name = "ect_gameplay_introduction",
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
				"introduction_talk"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"skaven_storm_vermin_champion"
			}
		}
	})
	define_rule({
		name = "ect_gameplay_introduction_evil_laugh",
		response = "ect_gameplay_introduction_evil_laugh",
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
				"gameplay_introduction_evil_laugh"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"user_memory",
				"time_since_ect_gameplay_introduction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_ect_gameplay_introduction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "ect_gameplay_banter",
		response = "ect_gameplay_banter",
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
				"ect_gameplay_banter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"user_memory",
				"time_since_ect_gameplay_banter",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_ect_gameplay_banter",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "ect_gameplay_summoning_skaven",
		response = "ect_gameplay_summoning_skaven",
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
				"ect_gameplay_summoning_skaven"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"user_memory",
				"time_since_ect_gameplay_summoning_skaven",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_ect_gameplay_summoning_skaven",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "ect_gameplay_witch_hunter_knocked_down",
		response = "ect_gameplay_witch_hunter_knocked_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"knocked_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMEDIFF,
				OP.GT,
				3
			}
		},
		on_done = {
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "ect_gameplay_bright_wizard_knocked_down",
		response = "ect_gameplay_bright_wizard_knocked_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"knocked_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMEDIFF,
				OP.GT,
				3
			}
		},
		on_done = {
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "ect_gameplay_dwarf_ranger_knocked_down",
		response = "ect_gameplay_dwarf_ranger_knocked_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"knocked_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMEDIFF,
				OP.GT,
				3
			}
		},
		on_done = {
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "ect_gameplay_wood_elf_knocked_down",
		response = "ect_gameplay_wood_elf_knocked_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"knocked_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMEDIFF,
				OP.GT,
				3
			}
		},
		on_done = {
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "ect_gameplay_empire_soldier_knocked_down",
		response = "ect_gameplay_empire_soldier_knocked_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"knocked_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_storm_vermin_champion"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMEDIFF,
				OP.GT,
				3
			}
		},
		on_done = {
			{
				"user_memory",
				"last_cr_seen_knockdown",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		ect_gameplay_introduction_evil_laugh = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "ect_intro_evil_laugh_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "ect_intro_evil_laugh_01"
			}
		},
		ect_gameplay_dwarf_ranger_knocked_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_reaction_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"ect_gameplay_dwarf_ranger_knocked_down_01",
				"ect_gameplay_dwarf_ranger_knocked_down_02",
				"ect_gameplay_dwarf_ranger_knocked_down_03",
				"ect_gameplay_dwarf_ranger_knocked_down_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"ect_gameplay_dwarf_ranger_knocked_down_01",
				"ect_gameplay_dwarf_ranger_knocked_down_02",
				"ect_gameplay_dwarf_ranger_knocked_down_03",
				"ect_gameplay_dwarf_ranger_knocked_down_04"
			},
			randomize_indexes = {}
		},
		ect_gameplay_witch_hunter_knocked_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_reaction_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"ect_gameplay_witch_hunter_knocked_down_01",
				"ect_gameplay_witch_hunter_knocked_down_02",
				"ect_gameplay_witch_hunter_knocked_down_03",
				"ect_gameplay_witch_hunter_knocked_down_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"ect_gameplay_witch_hunter_knocked_down_01",
				"ect_gameplay_witch_hunter_knocked_down_02",
				"ect_gameplay_witch_hunter_knocked_down_03",
				"ect_gameplay_witch_hunter_knocked_down_04"
			},
			randomize_indexes = {}
		},
		ect_gameplay_wood_elf_knocked_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_reaction_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"ect_gameplay_wood_elf_knocked_down_01",
				"ect_gameplay_wood_elf_knocked_down_02",
				"ect_gameplay_wood_elf_knocked_down_03",
				"ect_gameplay_wood_elf_knocked_down_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"ect_gameplay_wood_elf_knocked_down_01",
				"ect_gameplay_wood_elf_knocked_down_02",
				"ect_gameplay_wood_elf_knocked_down_03",
				"ect_gameplay_wood_elf_knocked_down_04"
			},
			randomize_indexes = {}
		},
		ect_gameplay_empire_soldier_knocked_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_reaction_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"ect_gameplay_empire_soldier_knocked_down_01",
				"ect_gameplay_empire_soldier_knocked_down_02",
				"ect_gameplay_empire_soldier_knocked_down_03",
				"ect_gameplay_empire_soldier_knocked_down_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"ect_gameplay_empire_soldier_knocked_down_01",
				"ect_gameplay_empire_soldier_knocked_down_02",
				"ect_gameplay_empire_soldier_knocked_down_03",
				"ect_gameplay_empire_soldier_knocked_down_04"
			},
			randomize_indexes = {}
		},
		ect_gameplay_banter = {
			sound_events_n = 10,
			randomize_indexes_n = 0,
			face_animations_n = 10,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_talk",
			dialogue_animations_n = 10,
			sound_events = {
				"ect_gameplay_banter_01",
				"ect_gameplay_banter_02",
				"ect_gameplay_banter_03",
				"ect_gameplay_banter_04",
				"ect_gameplay_banter_05",
				"ect_gameplay_banter_06",
				"ect_gameplay_banter_07",
				"ect_gameplay_banter_08",
				"ect_gameplay_banter_09",
				"ect_gameplay_banter_10"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"ect_gameplay_banter_01",
				"ect_gameplay_banter_02",
				"ect_gameplay_banter_03",
				"ect_gameplay_banter_04",
				"ect_gameplay_banter_05",
				"ect_gameplay_banter_06",
				"ect_gameplay_banter_07",
				"ect_gameplay_banter_08",
				"ect_gameplay_banter_09",
				"ect_gameplay_banter_10"
			},
			randomize_indexes = {}
		},
		ect_gameplay_summoning_skaven = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_talk",
			dialogue_animations_n = 8,
			sound_events = {
				"ect_gameplay_summoning_skaven_01",
				"ect_gameplay_summoning_skaven_02",
				"ect_gameplay_summoning_skaven_03",
				"ect_gameplay_summoning_skaven_04",
				"ect_gameplay_summoning_skaven_05",
				"ect_gameplay_summoning_skaven_06",
				"ect_gameplay_summoning_skaven_07",
				"ect_gameplay_summoning_skaven_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"ect_gameplay_summoning_skaven_01",
				"ect_gameplay_summoning_skaven_02",
				"ect_gameplay_summoning_skaven_03",
				"ect_gameplay_summoning_skaven_04",
				"ect_gameplay_summoning_skaven_05",
				"ect_gameplay_summoning_skaven_06",
				"ect_gameplay_summoning_skaven_07",
				"ect_gameplay_summoning_skaven_08"
			},
			randomize_indexes = {}
		},
		ect_gameplay_bright_wizard_knocked_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_reaction_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"ect_gameplay_bright_wizard_knocked_down_01",
				"ect_gameplay_bright_wizard_knocked_down_02",
				"ect_gameplay_bright_wizard_knocked_down_03",
				"ect_gameplay_bright_wizard_knocked_down_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"ect_gameplay_bright_wizard_knocked_down_01",
				"ect_gameplay_bright_wizard_knocked_down_02",
				"ect_gameplay_bright_wizard_knocked_down_03",
				"ect_gameplay_bright_wizard_knocked_down_04"
			},
			randomize_indexes = {}
		},
		ect_gameplay_introduction = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "enemy_champion_chieftain_stromdorf_town",
			category = "boss_talk_2",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "ect_gameplay_introduction_02",
				[2.0] = "ect_gameplay_introduction_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout",
				[2.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_angry",
				[2.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "ect_gameplay_introduction_02",
				[2.0] = "ect_gameplay_introduction_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
