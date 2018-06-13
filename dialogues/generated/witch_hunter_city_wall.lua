return function ()
	define_rule({
		name = "pwh_objective_city_wall_reaching_elevator",
		response = "pwh_objective_city_wall_reaching_elevator",
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
				"city_wall_reaching_elevator"
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
				"time_since_city_wall_reaching_elevator",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_reaching_elevator",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_lets_reach_the_city_gate",
		response = "pwh_objective_city_wall_lets_reach_the_city_gate",
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
				"city_wall_lets_reach_the_city_gate"
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
				"time_since_city_wall_lets_reach_the_city_gate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_lets_reach_the_city_gate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_crescendo_starting",
		response = "pwh_objective_city_wall_crescendo_starting",
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
				"city_wall_crescendo_starting"
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
				"time_since_city_wall_crescendo_starting",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_crescendo_starting",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_bell_brought_down",
		response = "pwh_objective_city_wall_bell_brought_down",
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
				"city_wall_bell_brought_down"
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
				"time_since_city_wall_bell_brought_down",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_bell_brought_down",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_bringing_down_first_attachment",
		response = "pwh_objective_city_wall_bringing_down_first_attachment",
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
				"city_wall_bringing_down_first_attachment"
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
				"time_since_city_wall_bringing_down_first_attachment",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_bringing_down_first_attachment",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_bringing_down_second_attachment",
		response = "pwh_objective_city_wall_bringing_down_second_attachment",
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
				"city_wall_bringing_down_second_attachment"
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
				"time_since_city_wall_bringing_down_second_attachment",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_bringing_down_second_attachment",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_bringing_down_third_attachment",
		response = "pwh_objective_city_wall_bringing_down_third_attachment",
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
				"city_wall_bringing_down_third_attachment"
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
				"time_since_city_wall_bringing_down_third_attachment",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_bringing_down_third_attachment",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_bringing_down_fourth_attachment",
		response = "pwh_objective_city_wall_bringing_down_fourth_attachment",
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
				"city_wall_bringing_down_fourth_attachment"
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
				"time_since_city_wall_bringing_down_fourth_attachment",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_bringing_down_fourth_attachment",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_seeing_bell",
		response = "pwh_objective_city_wall_seeing_bell",
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
				"city_wall_seeing bell"
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
				"time_since_city_wall_seeing bell",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_seeing bell",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_city_wall_door_opened_by_the_falling_bell",
		response = "pwh_objective_city_wall_door_opened_by_the_falling_bell",
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
				"city_wall_door_opened_by_the_falling_bell"
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
				"time_since_city_wall_door_opened_by_the_falling_bell",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_wall_door_opened_by_the_falling_bell",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_city_walls_intro",
		response = "pwh_city_walls_intro",
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
				"city_wall_intro"
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
				"time_since_city_walls_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_walls_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_city_walls_intro_b",
		response = "pwh_city_walls_intro_b",
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
				"city_walls_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_city_walls_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_walls_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_city_walls_intro_c",
		response = "pwh_city_walls_intro_c",
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
				"city_walls_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_city_walls_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_city_walls_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_city_walls_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_city_walls_intro_b_01",
				[2.0] = "pwh_city_walls_intro_b_02"
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
				[1.0] = "pwh_city_walls_intro_b_01",
				[2.0] = "pwh_city_walls_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_bringing_down_second_attachment = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_bringing_down_second_attachment_01",
				"pwh_objective_city_wall_bringing_down_second_attachment_02",
				"pwh_objective_city_wall_bringing_down_second_attachment_03",
				"pwh_objective_city_wall_bringing_down_second_attachment_04"
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
				"pwh_objective_city_wall_bringing_down_second_attachment_01",
				"pwh_objective_city_wall_bringing_down_second_attachment_02",
				"pwh_objective_city_wall_bringing_down_second_attachment_03",
				"pwh_objective_city_wall_bringing_down_second_attachment_04"
			},
			randomize_indexes = {}
		},
		pwh_city_walls_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_city_walls_intro_c_01",
				[2.0] = "pwh_city_walls_intro_c_02"
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
				[1.0] = "pwh_city_walls_intro_c_01",
				[2.0] = "pwh_city_walls_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_lets_reach_the_city_gate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_lets_reach_the_city_gate_01",
				"pwh_objective_city_wall_lets_reach_the_city_gate_02",
				"pwh_objective_city_wall_lets_reach_the_city_gate_03",
				"pwh_objective_city_wall_lets_reach_the_city_gate_04"
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
				"pwh_objective_city_wall_lets_reach_the_city_gate_01",
				"pwh_objective_city_wall_lets_reach_the_city_gate_02",
				"pwh_objective_city_wall_lets_reach_the_city_gate_03",
				"pwh_objective_city_wall_lets_reach_the_city_gate_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_bringing_down_third_attachment = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_bringing_down_third_attachment_01",
				"pwh_objective_city_wall_bringing_down_third_attachment_02",
				"pwh_objective_city_wall_bringing_down_third_attachment_03",
				"pwh_objective_city_wall_bringing_down_third_attachment_04"
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
				"pwh_objective_city_wall_bringing_down_third_attachment_01",
				"pwh_objective_city_wall_bringing_down_third_attachment_02",
				"pwh_objective_city_wall_bringing_down_third_attachment_03",
				"pwh_objective_city_wall_bringing_down_third_attachment_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_bringing_down_fourth_attachment = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_bringing_down_fourth_attachment_01",
				"pwh_objective_city_wall_bringing_down_fourth_attachment_02",
				"pwh_objective_city_wall_bringing_down_fourth_attachment_03",
				"pwh_objective_city_wall_bringing_down_fourth_attachment_04"
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
				"pwh_objective_city_wall_bringing_down_fourth_attachment_01",
				"pwh_objective_city_wall_bringing_down_fourth_attachment_02",
				"pwh_objective_city_wall_bringing_down_fourth_attachment_03",
				"pwh_objective_city_wall_bringing_down_fourth_attachment_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_bringing_down_first_attachment = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_bringing_down_first_attachment_01",
				"pwh_objective_city_wall_bringing_down_first_attachment_02",
				"pwh_objective_city_wall_bringing_down_first_attachment_03",
				"pwh_objective_city_wall_bringing_down_first_attachment_04"
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
				"pwh_objective_city_wall_bringing_down_first_attachment_01",
				"pwh_objective_city_wall_bringing_down_first_attachment_02",
				"pwh_objective_city_wall_bringing_down_first_attachment_03",
				"pwh_objective_city_wall_bringing_down_first_attachment_04"
			},
			randomize_indexes = {}
		},
		pwh_city_walls_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_city_walls_intro_a_01",
				[2.0] = "pwh_city_walls_intro_a_02"
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
				[1.0] = "pwh_city_walls_intro_a_01",
				[2.0] = "pwh_city_walls_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_crescendo_starting = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_crescendo_starting_01",
				"pwh_objective_city_wall_crescendo_starting_02",
				"pwh_objective_city_wall_crescendo_starting_03",
				"pwh_objective_city_wall_crescendo_starting_04"
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
				"pwh_objective_city_wall_crescendo_starting_01",
				"pwh_objective_city_wall_crescendo_starting_02",
				"pwh_objective_city_wall_crescendo_starting_03",
				"pwh_objective_city_wall_crescendo_starting_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_bell_brought_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_bell_brought_down_01",
				"pwh_objective_city_wall_bell_brought_down_02",
				"pwh_objective_city_wall_bell_brought_down_03",
				"pwh_objective_city_wall_bell_brought_down_04"
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
				"pwh_objective_city_wall_bell_brought_down_01",
				"pwh_objective_city_wall_bell_brought_down_02",
				"pwh_objective_city_wall_bell_brought_down_03",
				"pwh_objective_city_wall_bell_brought_down_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_door_opened_by_the_falling_bell = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_door_opened_by_the_falling_bell_01",
				"pwh_objective_city_wall_door_opened_by_the_falling_bell_02",
				"pwh_objective_city_wall_door_opened_by_the_falling_bell_03",
				"pwh_objective_city_wall_door_opened_by_the_falling_bell_04"
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
				"pwh_objective_city_wall_door_opened_by_the_falling_bell_01",
				"pwh_objective_city_wall_door_opened_by_the_falling_bell_02",
				"pwh_objective_city_wall_door_opened_by_the_falling_bell_03",
				"pwh_objective_city_wall_door_opened_by_the_falling_bell_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_reaching_elevator = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_reaching_elevator_01",
				"pwh_objective_city_wall_reaching_elevator_02",
				"pwh_objective_city_wall_reaching_elevator_03",
				"pwh_objective_city_wall_reaching_elevator_04"
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
				"pwh_objective_city_wall_reaching_elevator_01",
				"pwh_objective_city_wall_reaching_elevator_02",
				"pwh_objective_city_wall_reaching_elevator_03",
				"pwh_objective_city_wall_reaching_elevator_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_city_wall_seeing_bell = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_city_wall",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_city_wall_seeing_bell_01",
				"pwh_objective_city_wall_seeing_bell_02",
				"pwh_objective_city_wall_seeing_bell_03",
				"pwh_objective_city_wall_seeing_bell_04"
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
				"pwh_objective_city_wall_seeing_bell_01",
				"pwh_objective_city_wall_seeing_bell_02",
				"pwh_objective_city_wall_seeing_bell_03",
				"pwh_objective_city_wall_seeing_bell_04"
			},
			randomize_indexes = {}
		}
	})
end
