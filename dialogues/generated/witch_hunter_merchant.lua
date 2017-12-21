return function ()
	define_rule({
		name = "pwh_objective_merchant_district_spotting_ruins",
		response = "pwh_objective_merchant_district_spotting_ruins",
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
				"merchant_district_spotting_ruins"
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
				"time_since_merchant_district_spotting_ruins",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_spotting_ruins",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_spotting_market",
		response = "pwh_objective_merchant_district_spotting_market",
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
				"merchant_district_spotting_market"
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
				"time_since_merchant_district_spotting_market",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_spotting_market",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_spotting_blocked_route",
		response = "pwh_objective_merchant_district_spotting_blocked_route",
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
				"merchant_district_spotting_blocked_route"
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
				"time_since_merchant_district_spotting_blocked_route",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_spotting_blocked_route",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_crescendo_starting",
		response = "pwh_objective_merchant_district_crescendo_starting",
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
				"merchant_district_crescendo_starting"
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
				"time_since_merchant_district_crescendo_starting",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_crescendo_starting",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_approaching_timelimit",
		response = "pwh_objective_merchant_district_approaching_timelimit",
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
				"merchant_district_approaching_timelimit"
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
				"time_since_merchant_district_approaching_timelimit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_approaching_timelimit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_delivered_first_supply",
		response = "pwh_objective_merchant_district_delivered_first_supply",
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
				"merchant_district_delivered_first_supply"
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
				"time_since_merchant_district_delivered_first_supply",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_delivered_first_supply",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_delivered_quarter_supply",
		response = "pwh_objective_merchant_district_delivered_quarter_supply",
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
				"merchant_district_delivered_quarter_supply"
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
				"time_since_merchant_district_delivered_quarter_supply",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_delivered_quarter_supply",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_delivered_half_supply",
		response = "pwh_objective_merchant_district_delivered_half_supply",
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
				"merchant_district_delivered_half_supply"
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
				"time_since_merchant_district_delivered_half_supply",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_delivered_half_supply",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_delivered_most_supply",
		response = "pwh_objective_merchant_district_delivered_most_supply",
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
				"merchant_district_delivered_most_supply"
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
				"time_since_merchant_district_delivered_most_supply",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_delivered_most_supply",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_through_granary",
		response = "pwh_objective_merchant_district_through_granary",
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
				"merchant_district_through_granary"
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
				"time_since_merchant_district_through_granary",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_through_granary",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_drop_down_street",
		response = "pwh_objective_merchant_district_drop_down_street",
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
				"merchant_district_drop_down_street"
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
				"time_since_merchant_district_drop_down_street",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_drop_down_street",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_through_gardens",
		response = "pwh_objective_merchant_district_through_gardens",
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
				"merchant_district_through_gardens"
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
				"time_since_merchant_district_through_gardens",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_through_gardens",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_apothecary",
		response = "pwh_objective_merchant_district_apothecary",
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
				"merchant_district_apothecary"
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
				"time_since_merchant_district_apothecary",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_apothecary",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_merchant_district_treasure",
		response = "pwh_objective_merchant_district_treasure",
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
				"merchant_district_treasure"
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
				"time_since_merchant_district_treasure",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_treasure",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_merchant_district_intro",
		response = "pwh_merchant_district_intro",
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
				"merchant_intro"
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
				"time_since_merchant_district_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_merchant_district_intro_b",
		response = "pwh_merchant_district_intro_b",
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
				"merchant_district_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_merchant_district_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_merchant_district_intro_c",
		response = "pwh_merchant_district_intro_c",
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
				"merchant_district_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_merchant_district_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_merchant_district_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_merchant_district_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_merchant_district_intro_a_01",
				[2.0] = "pwh_merchant_district_intro_a_02"
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
				[1.0] = "pwh_merchant_district_intro_a_01",
				[2.0] = "pwh_merchant_district_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_delivered_first_supply = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_delivered_first_supply_01",
				"pwh_objective_merchant_district_delivered_first_supply_02",
				"pwh_objective_merchant_district_delivered_first_supply_03",
				"pwh_objective_merchant_district_delivered_first_supply_04"
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
				"pwh_objective_merchant_district_delivered_first_supply_01",
				"pwh_objective_merchant_district_delivered_first_supply_02",
				"pwh_objective_merchant_district_delivered_first_supply_03",
				"pwh_objective_merchant_district_delivered_first_supply_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_spotting_ruins = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_spotting_ruins_01",
				"pwh_objective_merchant_district_spotting_ruins_02",
				"pwh_objective_merchant_district_spotting_ruins_03",
				"pwh_objective_merchant_district_spotting_ruins_04"
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
				"pwh_objective_merchant_district_spotting_ruins_01",
				"pwh_objective_merchant_district_spotting_ruins_02",
				"pwh_objective_merchant_district_spotting_ruins_03",
				"pwh_objective_merchant_district_spotting_ruins_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_through_gardens = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_merchant_district_through_gardens_01",
				[2.0] = "pwh_objective_merchant_district_through_gardens_02"
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
				[1.0] = "pwh_objective_merchant_district_through_gardens_01",
				[2.0] = "pwh_objective_merchant_district_through_gardens_02"
			},
			randomize_indexes = {}
		},
		pwh_merchant_district_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_merchant_district_intro_b_01",
				[2.0] = "pwh_merchant_district_intro_b_02"
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
				[1.0] = "pwh_merchant_district_intro_b_01",
				[2.0] = "pwh_merchant_district_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_spotting_blocked_route = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_spotting_blocked_route_01",
				"pwh_objective_merchant_district_spotting_blocked_route_02",
				"pwh_objective_merchant_district_spotting_blocked_route_03",
				"pwh_objective_merchant_district_spotting_blocked_route_04"
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
				"pwh_objective_merchant_district_spotting_blocked_route_01",
				"pwh_objective_merchant_district_spotting_blocked_route_02",
				"pwh_objective_merchant_district_spotting_blocked_route_03",
				"pwh_objective_merchant_district_spotting_blocked_route_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_delivered_quarter_supply = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_delivered_quarter_supply_01",
				"pwh_objective_merchant_district_delivered_quarter_supply_02",
				"pwh_objective_merchant_district_delivered_quarter_supply_03",
				"pwh_objective_merchant_district_delivered_quarter_supply_04"
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
				"pwh_objective_merchant_district_delivered_quarter_supply_01",
				"pwh_objective_merchant_district_delivered_quarter_supply_02",
				"pwh_objective_merchant_district_delivered_quarter_supply_03",
				"pwh_objective_merchant_district_delivered_quarter_supply_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_treasure = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_merchant_district_treasure_01",
				[2.0] = "pwh_objective_merchant_district_treasure_02"
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
				[1.0] = "pwh_objective_merchant_district_treasure_01",
				[2.0] = "pwh_objective_merchant_district_treasure_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_crescendo_starting = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_crescendo_starting_01",
				"pwh_objective_merchant_district_crescendo_starting_02",
				"pwh_objective_merchant_district_crescendo_starting_03",
				"pwh_objective_merchant_district_crescendo_starting_04"
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
				"pwh_objective_merchant_district_crescendo_starting_01",
				"pwh_objective_merchant_district_crescendo_starting_02",
				"pwh_objective_merchant_district_crescendo_starting_03",
				"pwh_objective_merchant_district_crescendo_starting_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_delivered_most_supply = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_delivered_most_supply_01",
				"pwh_objective_merchant_district_delivered_most_supply_02",
				"pwh_objective_merchant_district_delivered_most_supply_03",
				"pwh_objective_merchant_district_delivered_most_supply_04"
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
				"pwh_objective_merchant_district_delivered_most_supply_01",
				"pwh_objective_merchant_district_delivered_most_supply_02",
				"pwh_objective_merchant_district_delivered_most_supply_03",
				"pwh_objective_merchant_district_delivered_most_supply_04"
			},
			randomize_indexes = {}
		},
		pwh_merchant_district_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_merchant_district_intro_c_01",
				[2.0] = "pwh_merchant_district_intro_c_02"
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
				[1.0] = "pwh_merchant_district_intro_c_01",
				[2.0] = "pwh_merchant_district_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_apothecary = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_merchant_district_apothecary_01",
				[2.0] = "pwh_objective_merchant_district_apothecary_02"
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
				[1.0] = "pwh_objective_merchant_district_apothecary_01",
				[2.0] = "pwh_objective_merchant_district_apothecary_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_drop_down_street = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_merchant_district_drop_down_street_01",
				[2.0] = "pwh_objective_merchant_district_drop_down_street_02"
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
				[1.0] = "pwh_objective_merchant_district_drop_down_street_01",
				[2.0] = "pwh_objective_merchant_district_drop_down_street_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_through_granary = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_merchant_district_through_granary_01",
				[2.0] = "pwh_objective_merchant_district_through_granary_02"
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
				[1.0] = "pwh_objective_merchant_district_through_granary_01",
				[2.0] = "pwh_objective_merchant_district_through_granary_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_approaching_timelimit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_approaching_timelimit_01",
				"pwh_objective_merchant_district_approaching_timelimit_02",
				"pwh_objective_merchant_district_approaching_timelimit_03",
				"pwh_objective_merchant_district_approaching_timelimit_04"
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
				"pwh_objective_merchant_district_approaching_timelimit_01",
				"pwh_objective_merchant_district_approaching_timelimit_02",
				"pwh_objective_merchant_district_approaching_timelimit_03",
				"pwh_objective_merchant_district_approaching_timelimit_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_delivered_half_supply = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_delivered_half_supply_01",
				"pwh_objective_merchant_district_delivered_half_supply_02",
				"pwh_objective_merchant_district_delivered_half_supply_03",
				"pwh_objective_merchant_district_delivered_half_supply_04"
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
				"pwh_objective_merchant_district_delivered_half_supply_01",
				"pwh_objective_merchant_district_delivered_half_supply_02",
				"pwh_objective_merchant_district_delivered_half_supply_03",
				"pwh_objective_merchant_district_delivered_half_supply_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_merchant_district_spotting_market = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_merchant",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_merchant_district_spotting_market_01",
				"pwh_objective_merchant_district_spotting_market_02",
				"pwh_objective_merchant_district_spotting_market_03",
				"pwh_objective_merchant_district_spotting_market_04"
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
				"pwh_objective_merchant_district_spotting_market_01",
				"pwh_objective_merchant_district_spotting_market_02",
				"pwh_objective_merchant_district_spotting_market_03",
				"pwh_objective_merchant_district_spotting_market_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
