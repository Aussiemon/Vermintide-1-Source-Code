return function ()
	define_rule({
		name = "pwh_objective_end_boss_reaching_the_tunnels",
		response = "pwh_objective_end_boss_reaching_the_tunnels",
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
				"end_boss_reaching_the_tunnels"
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
				"time_since_end_boss_reaching_the_tunnels",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_reaching_the_tunnels",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_vista",
		response = "pwh_objective_end_boss_vista",
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
				"end_boss_vista"
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
				"time_since_end_boss_vista",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_vista",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_reaching_the_inner_sanctum",
		response = "pwh_objective_end_boss_reaching_the_inner_sanctum",
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
				"end_boss_reaching_the_inner_sanctum"
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
				"time_since_end_boss_reaching_the_inner_sanctum",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_reaching_the_inner_sanctum",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_hitting_bell_repeatedly",
		response = "pwh_objective_end_boss_hitting_bell_repeatedly",
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
				"end_boss_hitting_bell_repeatedly"
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
				"time_since_end_boss_hitting_bell_repeatedly",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_hitting_bell_repeatedly",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_spot_moon",
		response = "pwh_objective_end_boss_spot_moon",
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
				"end_boss_spot_moon"
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
				"time_since_end_boss_spot_moon",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_spot_moon",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_destroy_pillar_first",
		response = "pwh_objective_end_boss_destroy_pillar_first",
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
				"end_boss_destroy_pillar_first"
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
				"time_since_end_boss_destroy_pillar_first",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_destroy_pillar_first",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_destroy_pillar_second",
		response = "pwh_objective_end_boss_destroy_pillar_second",
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
				"end_boss_destroy_pillar_second"
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
				"time_since_end_boss_destroy_pillar_second",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_destroy_pillar_second",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_destroy_pillar_third",
		response = "pwh_objective_end_boss_destroy_pillar_third",
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
				"end_boss_destroy_pillar_third"
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
				"time_since_end_boss_destroy_pillar_third",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_destroy_pillar_third",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_outro",
		response = "pwh_objective_end_boss_outro",
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
				"end_boss_outro"
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
				"time_since_end_boss_outro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_outro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_moon_break",
		response = "pwh_objective_end_boss_moon_break",
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
				"end_boss_moon_break"
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
				"time_since_end_boss_moon_break",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_moon_break",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_end_boss_find_your_way_up",
		response = "pwh_objective_end_boss_find_your_way_up",
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
				"end_boss_find_your_way_up"
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
				"time_since_end_boss_find_your_way_up",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_find_your_way_up",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_end_boss_intro",
		response = "pwh_end_boss_intro",
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
				"end_boss_intro"
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
				"time_since_end_boss_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_end_boss_intro_b",
		response = "pwh_end_boss_intro_b",
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
				"end_boss_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_end_boss_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_end_boss_intro_c",
		response = "pwh_end_boss_intro_c",
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
				"end_boss_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_end_boss_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_end_boss_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_objective_end_boss_reaching_the_inner_sanctum = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_reaching_the_inner_sanctum_01",
				"pwh_objective_end_boss_reaching_the_inner_sanctum_02",
				"pwh_objective_end_boss_reaching_the_inner_sanctum_03",
				"pwh_objective_end_boss_reaching_the_inner_sanctum_04"
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
				"pwh_objective_end_boss_reaching_the_inner_sanctum_01",
				"pwh_objective_end_boss_reaching_the_inner_sanctum_02",
				"pwh_objective_end_boss_reaching_the_inner_sanctum_03",
				"pwh_objective_end_boss_reaching_the_inner_sanctum_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_outro = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_outro_01",
				"pwh_objective_end_boss_outro_02",
				"pwh_objective_end_boss_outro_03",
				"pwh_objective_end_boss_outro_04"
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
				"pwh_objective_end_boss_outro_01",
				"pwh_objective_end_boss_outro_02",
				"pwh_objective_end_boss_outro_03",
				"pwh_objective_end_boss_outro_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_hitting_bell_repeatedly = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_hitting_bell_repeatedly_01",
				"pwh_objective_end_boss_hitting_bell_repeatedly_02",
				"pwh_objective_end_boss_hitting_bell_repeatedly_03",
				"pwh_objective_end_boss_hitting_bell_repeatedly_04"
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
				"pwh_objective_end_boss_hitting_bell_repeatedly_01",
				"pwh_objective_end_boss_hitting_bell_repeatedly_02",
				"pwh_objective_end_boss_hitting_bell_repeatedly_03",
				"pwh_objective_end_boss_hitting_bell_repeatedly_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_moon_break = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_moon_break_01",
				"pwh_objective_end_boss_moon_break_02",
				"pwh_objective_end_boss_moon_break_03",
				"pwh_objective_end_boss_moon_break_04"
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
				"pwh_objective_end_boss_moon_break_01",
				"pwh_objective_end_boss_moon_break_02",
				"pwh_objective_end_boss_moon_break_03",
				"pwh_objective_end_boss_moon_break_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_find_your_way_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_find_your_way_up_01",
				"pwh_objective_end_boss_find_your_way_up_02",
				"pwh_objective_end_boss_find_your_way_up_03",
				"pwh_objective_end_boss_find_your_way_up_04"
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
				"pwh_objective_end_boss_find_your_way_up_01",
				"pwh_objective_end_boss_find_your_way_up_02",
				"pwh_objective_end_boss_find_your_way_up_03",
				"pwh_objective_end_boss_find_your_way_up_04"
			},
			randomize_indexes = {}
		},
		pwh_end_boss_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_end_boss_intro_c_01",
				[2.0] = "pwh_end_boss_intro_c_02"
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
				[1.0] = "pwh_end_boss_intro_c_01",
				[2.0] = "pwh_end_boss_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_destroy_pillar_third = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_destroy_pillar_third_01",
				"pwh_objective_end_boss_destroy_pillar_third_02",
				"pwh_objective_end_boss_destroy_pillar_third_03",
				"pwh_objective_end_boss_destroy_pillar_third_04"
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
				"pwh_objective_end_boss_destroy_pillar_third_01",
				"pwh_objective_end_boss_destroy_pillar_third_02",
				"pwh_objective_end_boss_destroy_pillar_third_03",
				"pwh_objective_end_boss_destroy_pillar_third_04"
			},
			randomize_indexes = {}
		},
		pwh_end_boss_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_end_boss_intro_b_01",
				[2.0] = "pwh_end_boss_intro_b_02"
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
				[1.0] = "pwh_end_boss_intro_b_01",
				[2.0] = "pwh_end_boss_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_reaching_the_tunnels = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_reaching_the_tunnels_01",
				"pwh_objective_end_boss_reaching_the_tunnels_02",
				"pwh_objective_end_boss_reaching_the_tunnels_03",
				"pwh_objective_end_boss_reaching_the_tunnels_04"
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
				"pwh_objective_end_boss_reaching_the_tunnels_01",
				"pwh_objective_end_boss_reaching_the_tunnels_02",
				"pwh_objective_end_boss_reaching_the_tunnels_03",
				"pwh_objective_end_boss_reaching_the_tunnels_04"
			},
			randomize_indexes = {}
		},
		pwh_end_boss_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_end_boss_intro_a_01",
				[2.0] = "pwh_end_boss_intro_a_02"
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
				[1.0] = "pwh_end_boss_intro_a_01",
				[2.0] = "pwh_end_boss_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_vista = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_vista_01",
				"pwh_objective_end_boss_vista_02",
				"pwh_objective_end_boss_vista_03",
				"pwh_objective_end_boss_vista_04"
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
				"pwh_objective_end_boss_vista_01",
				"pwh_objective_end_boss_vista_02",
				"pwh_objective_end_boss_vista_03",
				"pwh_objective_end_boss_vista_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_destroy_pillar_second = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_destroy_pillar_second_01",
				"pwh_objective_end_boss_destroy_pillar_second_02",
				"pwh_objective_end_boss_destroy_pillar_second_03",
				"pwh_objective_end_boss_destroy_pillar_second_04"
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
				"pwh_objective_end_boss_destroy_pillar_second_01",
				"pwh_objective_end_boss_destroy_pillar_second_02",
				"pwh_objective_end_boss_destroy_pillar_second_03",
				"pwh_objective_end_boss_destroy_pillar_second_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_spot_moon = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_spot_moon_01",
				"pwh_objective_end_boss_spot_moon_02",
				"pwh_objective_end_boss_spot_moon_03",
				"pwh_objective_end_boss_spot_moon_04"
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
				"pwh_objective_end_boss_spot_moon_01",
				"pwh_objective_end_boss_spot_moon_02",
				"pwh_objective_end_boss_spot_moon_03",
				"pwh_objective_end_boss_spot_moon_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_end_boss_destroy_pillar_first = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_end_boss",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_end_boss_destroy_pillar_first_01",
				"pwh_objective_end_boss_destroy_pillar_first_02",
				"pwh_objective_end_boss_destroy_pillar_first_03",
				"pwh_objective_end_boss_destroy_pillar_first_04"
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
				"pwh_objective_end_boss_destroy_pillar_first_01",
				"pwh_objective_end_boss_destroy_pillar_first_02",
				"pwh_objective_end_boss_destroy_pillar_first_03",
				"pwh_objective_end_boss_destroy_pillar_first_04"
			},
			randomize_indexes = {}
		}
	})
end
