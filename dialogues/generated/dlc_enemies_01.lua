return function ()
	define_rule({
		name = "pwh_gameplay_seeing_a_scr",
		response = "pwh_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_clan_rat_shield"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_clan_rat_shield",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_clan_rat_shield",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_gameplay_seeing_a_scr",
		response = "pes_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_clan_rat_shield"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_clan_rat_shield",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_clan_rat_shield",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_gameplay_seeing_a_scr",
		response = "pbw_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_clan_rat_shield"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_clan_rat_shield",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_clan_rat_shield",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_seeing_a_scr",
		response = "pdr_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_clan_rat_shield"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_clan_rat_shield",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_clan_rat_shield",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_gameplay_seeing_a_scr",
		response = "pwe_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_clan_rat_shield"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_clan_rat_shield",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_clan_rat_shield",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwe_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dlc_enemies_01",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwe_gameplay_seeing_a_scr_01",
				"pwe_gameplay_seeing_a_scr_02",
				"pwe_gameplay_seeing_a_scr_03",
				"pwe_gameplay_seeing_a_scr_04",
				"pwe_gameplay_seeing_a_scr_05",
				"pwe_gameplay_seeing_a_scr_06",
				"pwe_gameplay_seeing_a_scr_07"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_neutral",
				"face_neutral",
				"face_contempt",
				"face_neutral"
			},
			localization_strings = {
				"pwe_gameplay_seeing_a_scr_01",
				"pwe_gameplay_seeing_a_scr_02",
				"pwe_gameplay_seeing_a_scr_03",
				"pwe_gameplay_seeing_a_scr_04",
				"pwe_gameplay_seeing_a_scr_05",
				"pwe_gameplay_seeing_a_scr_06",
				"pwe_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pes_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dlc_enemies_01",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pes_gameplay_seeing_a_scr_01",
				"pes_gameplay_seeing_a_scr_02",
				"pes_gameplay_seeing_a_scr_03",
				"pes_gameplay_seeing_a_scr_04",
				"pes_gameplay_seeing_a_scr_05",
				"pes_gameplay_seeing_a_scr_06",
				"pes_gameplay_seeing_a_scr_07"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_neutral",
				"face_neutral",
				"face_contempt",
				"face_neutral"
			},
			localization_strings = {
				"pes_gameplay_seeing_a_scr_01",
				"pes_gameplay_seeing_a_scr_02",
				"pes_gameplay_seeing_a_scr_03",
				"pes_gameplay_seeing_a_scr_04",
				"pes_gameplay_seeing_a_scr_05",
				"pes_gameplay_seeing_a_scr_06",
				"pes_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dlc_enemies_01",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pbw_gameplay_seeing_a_scr_01",
				"pbw_gameplay_seeing_a_scr_02",
				"pbw_gameplay_seeing_a_scr_03",
				"pbw_gameplay_seeing_a_scr_04",
				"pbw_gameplay_seeing_a_scr_05",
				"pbw_gameplay_seeing_a_scr_06",
				"pbw_gameplay_seeing_a_scr_07"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_neutral",
				"face_neutral",
				"face_contempt",
				"face_neutral"
			},
			localization_strings = {
				"pbw_gameplay_seeing_a_scr_01",
				"pbw_gameplay_seeing_a_scr_02",
				"pbw_gameplay_seeing_a_scr_03",
				"pbw_gameplay_seeing_a_scr_04",
				"pbw_gameplay_seeing_a_scr_05",
				"pbw_gameplay_seeing_a_scr_06",
				"pbw_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dlc_enemies_01",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pdr_gameplay_seeing_a_scr_01",
				"pdr_gameplay_seeing_a_scr_02",
				"pdr_gameplay_seeing_a_scr_03",
				"pdr_gameplay_seeing_a_scr_04",
				"pdr_gameplay_seeing_a_scr_05",
				"pdr_gameplay_seeing_a_scr_06",
				"pdr_gameplay_seeing_a_scr_07"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_neutral",
				"face_neutral",
				"face_contempt",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_scr_01",
				"pdr_gameplay_seeing_a_scr_02",
				"pdr_gameplay_seeing_a_scr_03",
				"pdr_gameplay_seeing_a_scr_04",
				"pdr_gameplay_seeing_a_scr_05",
				"pdr_gameplay_seeing_a_scr_06",
				"pdr_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dlc_enemies_01",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwh_gameplay_seeing_a_scr_01",
				"pwh_gameplay_seeing_a_scr_02",
				"pwh_gameplay_seeing_a_scr_03",
				"pwh_gameplay_seeing_a_scr_04",
				"pwh_gameplay_seeing_a_scr_05",
				"pwh_gameplay_seeing_a_scr_06",
				"pwh_gameplay_seeing_a_scr_07"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_neutral",
				"face_neutral",
				"face_contempt",
				"face_neutral"
			},
			localization_strings = {
				"pwh_gameplay_seeing_a_scr_01",
				"pwh_gameplay_seeing_a_scr_02",
				"pwh_gameplay_seeing_a_scr_03",
				"pwh_gameplay_seeing_a_scr_04",
				"pwh_gameplay_seeing_a_scr_05",
				"pwh_gameplay_seeing_a_scr_06",
				"pwh_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		}
	})

	return 
end
