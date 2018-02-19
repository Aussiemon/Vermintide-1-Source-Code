return function ()
	define_rule({
		name = "pwh_level_reikwald_forest_skaven_infestation",
		response = "pwh_level_reikwald_forest_skaven_infestation",
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
				"level_reikwald_forest_skaven_infestation"
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
				"level_reikwald_forest_skaven_infestation",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_skaven_infestation",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_bandit_camp",
		response = "pwh_level_reikwald_forest_bandit_camp",
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
				"level_reikwald_forest_bandit_camp"
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
				"level_reikwald_forest_bandit_camp",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_bandit_camp",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_bridge_stream",
		response = "pwh_level_reikwald_forest_bridge_stream",
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
				"level_reikwald_forest_bridge_stream"
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
				"level_reikwald_forest_bridge_stream",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_bridge_stream",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_vista_village",
		response = "pwh_level_reikwald_forest_vista_village",
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
				"level_reikwald_forest_vista_village"
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
				"level_reikwald_forest_vista_village",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_vista_village",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_vista_river",
		response = "pwh_level_reikwald_forest_vista_river",
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
				"level_reikwald_forest_vista_river"
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
				"level_reikwald_forest_vista_river",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_vista_river",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_herdstone",
		response = "pwh_level_reikwald_forest_herdstone",
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
				"level_reikwald_forest_herdstone"
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
				"level_reikwald_forest_herdstone",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_herdstone",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_village",
		response = "pwh_level_reikwald_forest_village",
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
				"level_reikwald_forest_village"
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
				"level_reikwald_forest_village",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_village",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_missing_ship",
		response = "pwh_level_reikwald_forest_missing_ship",
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
				"level_reikwald_forest_missing_ship"
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
				"level_reikwald_forest_missing_ship",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_missing_ship",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_jetty_fire",
		response = "pwh_level_reikwald_forest_jetty_fire",
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
				"level_reikwald_forest_jetty_fire"
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
				"level_reikwald_forest_jetty_fire",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_jetty_fire",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_blow_up_stoppage",
		response = "pwh_level_reikwald_forest_blow_up_stoppage",
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
				"level_reikwald_forest_blow_up_stoppage"
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
				"level_reikwald_forest_blow_up_stoppage",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_blow_up_stoppage",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_fires_out",
		response = "pwh_level_reikwald_forest_fires_out",
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
				"level_reikwald_forest_fires_out"
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
				"level_reikwald_forest_fires_out",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_fires_out",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_level_reikwald_forest_board_barge",
		response = "pwh_level_reikwald_forest_board_barge",
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
				"level_reikwald_forest_board_barge"
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
				"level_reikwald_forest_board_barge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_reikwald_forest_board_barge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_reikwald_forest_intro_a",
		response = "pwh_reikwald_forest_intro_a",
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
				"reikwald_forest_intro_a"
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
				"reikwald_forest_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"reikwald_forest_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_reikwald_forest_intro_b",
		response = "pwh_reikwald_forest_intro_b",
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
				"reikwald_forest_intro_a"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"reikwald_forest_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"reikwald_forest_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_reikwald_forest_intro_c",
		response = "pwh_reikwald_forest_intro_c",
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
				"reikwald_forest_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"reikwald_forest_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"reikwald_forest_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_level_reikwald_forest_blow_up_stoppage = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_blow_up_stoppage_01",
				"pwh_level_reikwald_forest_blow_up_stoppage_02",
				"pwh_level_reikwald_forest_blow_up_stoppage_03",
				"pwh_level_reikwald_forest_blow_up_stoppage_04"
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
				"pwh_level_reikwald_forest_blow_up_stoppage_01",
				"pwh_level_reikwald_forest_blow_up_stoppage_02",
				"pwh_level_reikwald_forest_blow_up_stoppage_03",
				"pwh_level_reikwald_forest_blow_up_stoppage_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_vista_river = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_vista_river_01",
				"pwh_level_reikwald_forest_vista_river_02",
				"pwh_level_reikwald_forest_vista_river_03",
				"pwh_level_reikwald_forest_vista_river_04"
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
				"pwh_level_reikwald_forest_vista_river_01",
				"pwh_level_reikwald_forest_vista_river_02",
				"pwh_level_reikwald_forest_vista_river_03",
				"pwh_level_reikwald_forest_vista_river_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_bridge_stream = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_bridge_stream_01",
				"pwh_level_reikwald_forest_bridge_stream_02",
				"pwh_level_reikwald_forest_bridge_stream_03",
				"pwh_level_reikwald_forest_bridge_stream_04"
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
				"pwh_level_reikwald_forest_bridge_stream_01",
				"pwh_level_reikwald_forest_bridge_stream_02",
				"pwh_level_reikwald_forest_bridge_stream_03",
				"pwh_level_reikwald_forest_bridge_stream_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_skaven_infestation = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_skaven_infestation_01",
				"pwh_level_reikwald_forest_skaven_infestation_02",
				"pwh_level_reikwald_forest_skaven_infestation_03",
				"pwh_level_reikwald_forest_skaven_infestation_04"
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
				"pwh_level_reikwald_forest_skaven_infestation_01",
				"pwh_level_reikwald_forest_skaven_infestation_02",
				"pwh_level_reikwald_forest_skaven_infestation_03",
				"pwh_level_reikwald_forest_skaven_infestation_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_vista_village = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_vista_village_01",
				"pwh_level_reikwald_forest_vista_village_02",
				"pwh_level_reikwald_forest_vista_village_03",
				"pwh_level_reikwald_forest_vista_village_04"
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
				"pwh_level_reikwald_forest_vista_village_01",
				"pwh_level_reikwald_forest_vista_village_02",
				"pwh_level_reikwald_forest_vista_village_03",
				"pwh_level_reikwald_forest_vista_village_04"
			},
			randomize_indexes = {}
		},
		pwh_reikwald_forest_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_reikwald_forest_intro_c_01",
				[2.0] = "pwh_reikwald_forest_intro_c_02"
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
				[1.0] = "pwh_reikwald_forest_intro_c_01",
				[2.0] = "pwh_reikwald_forest_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_fires_out = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_fires_out_01",
				"pwh_level_reikwald_forest_fires_out_02",
				"pwh_level_reikwald_forest_fires_out_03",
				"pwh_level_reikwald_forest_fires_out_04"
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
				"pwh_level_reikwald_forest_fires_out_01",
				"pwh_level_reikwald_forest_fires_out_02",
				"pwh_level_reikwald_forest_fires_out_03",
				"pwh_level_reikwald_forest_fires_out_04"
			},
			randomize_indexes = {}
		},
		pwh_reikwald_forest_intro_a = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_reikwald_forest_intro_a_01",
				[2.0] = "pwh_reikwald_forest_intro_a_02"
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
				[1.0] = "pwh_reikwald_forest_intro_a_01",
				[2.0] = "pwh_reikwald_forest_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_village = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_village_01",
				"pwh_level_reikwald_forest_village_02",
				"pwh_level_reikwald_forest_village_03",
				"pwh_level_reikwald_forest_village_04"
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
				"pwh_level_reikwald_forest_village_01",
				"pwh_level_reikwald_forest_village_02",
				"pwh_level_reikwald_forest_village_03",
				"pwh_level_reikwald_forest_village_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_missing_ship = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_missing_ship_01",
				"pwh_level_reikwald_forest_missing_ship_02",
				"pwh_level_reikwald_forest_missing_ship_03",
				"pwh_level_reikwald_forest_missing_ship_04"
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
				"pwh_level_reikwald_forest_missing_ship_01",
				"pwh_level_reikwald_forest_missing_ship_02",
				"pwh_level_reikwald_forest_missing_ship_03",
				"pwh_level_reikwald_forest_missing_ship_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_jetty_fire = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_jetty_fire_01",
				"pwh_level_reikwald_forest_jetty_fire_02",
				"pwh_level_reikwald_forest_jetty_fire_03",
				"pwh_level_reikwald_forest_jetty_fire_04"
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
				"pwh_level_reikwald_forest_jetty_fire_01",
				"pwh_level_reikwald_forest_jetty_fire_02",
				"pwh_level_reikwald_forest_jetty_fire_03",
				"pwh_level_reikwald_forest_jetty_fire_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_board_barge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_board_barge_01",
				"pwh_level_reikwald_forest_board_barge_02",
				"pwh_level_reikwald_forest_board_barge_03",
				"pwh_level_reikwald_forest_board_barge_04"
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
				"pwh_level_reikwald_forest_board_barge_01",
				"pwh_level_reikwald_forest_board_barge_02",
				"pwh_level_reikwald_forest_board_barge_03",
				"pwh_level_reikwald_forest_board_barge_04"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_herdstone = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_herdstone_01",
				"pwh_level_reikwald_forest_herdstone_02",
				"pwh_level_reikwald_forest_herdstone_03",
				"pwh_level_reikwald_forest_herdstone_04"
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
				"pwh_level_reikwald_forest_herdstone_01",
				"pwh_level_reikwald_forest_herdstone_02",
				"pwh_level_reikwald_forest_herdstone_03",
				"pwh_level_reikwald_forest_herdstone_04"
			},
			randomize_indexes = {}
		},
		pwh_reikwald_forest_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_reikwald_forest_intro_b_01",
				[2.0] = "pwh_reikwald_forest_intro_b_02"
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
				[1.0] = "pwh_reikwald_forest_intro_b_01",
				[2.0] = "pwh_reikwald_forest_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_level_reikwald_forest_bandit_camp = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_reikwald_forest",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_level_reikwald_forest_bandit_camp_01",
				"pwh_level_reikwald_forest_bandit_camp_02",
				"pwh_level_reikwald_forest_bandit_camp_03",
				"pwh_level_reikwald_forest_bandit_camp_04"
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
				"pwh_level_reikwald_forest_bandit_camp_01",
				"pwh_level_reikwald_forest_bandit_camp_02",
				"pwh_level_reikwald_forest_bandit_camp_03",
				"pwh_level_reikwald_forest_bandit_camp_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
