return function ()
	define_rule({
		name = "pwh_objective_docks_first_warehouse_door",
		response = "pwh_objective_docks_first_warehouse_door",
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
				"docks_first_warehouse_door"
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
				"time_since_docks_first_warehouse_door",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_first_warehouse_door",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_docks_second_warehouse_door",
		response = "pwh_objective_docks_second_warehouse_door",
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
				"docks_second_warehouse_door"
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
				"time_since_docks_second_warehouse_door",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_second_warehouse_door",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_docks_leave",
		response = "pwh_objective_docks_leave",
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
				"docks_leave"
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
				"time_since_docks_leave",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_leave",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_docks_first_warehouse_inside",
		response = "pwh_objective_docks_first_warehouse_inside",
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
				"docks_first_warehouse_inside"
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
				"time_since_docks_first_warehouse_inside",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_first_warehouse_inside",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_docks_second_warehouse_inside",
		response = "pwh_objective_docks_second_warehouse_inside",
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
				"docks_second_warehouse_inside"
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
				"time_since_docks_second_warehouse_inside",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_second_warehouse_inside",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_docks_second_warehouse_escape",
		response = "pwh_objective_docks_second_warehouse_escape",
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
				"docks_second_warehouse_escape"
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
				"time_since_docks_second_warehouse_escape",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_second_warehouse_escape",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_docks_explosion",
		response = "pwh_objective_docks_explosion",
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
				"docks_explosion"
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
				"time_since_docks_explosion",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_explosion",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_docks_intro",
		response = "pwh_docks_intro",
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
				"docks_intro"
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
				"time_since_docks_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_docks_intro_b",
		response = "pwh_docks_intro_b",
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
				"docks_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_docks_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_docks_intro_c",
		response = "pwh_docks_intro_c",
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
				"docks_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_docks_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_docks_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_objective_docks_first_warehouse_inside = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_docks_first_warehouse_inside_01",
				"pwh_objective_docks_first_warehouse_inside_02",
				"pwh_objective_docks_first_warehouse_inside_03",
				"pwh_objective_docks_first_warehouse_inside_04"
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
				"pwh_objective_docks_first_warehouse_inside_01",
				"pwh_objective_docks_first_warehouse_inside_02",
				"pwh_objective_docks_first_warehouse_inside_03",
				"pwh_objective_docks_first_warehouse_inside_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_docks_second_warehouse_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_docks_second_warehouse_door_01",
				"pwh_objective_docks_second_warehouse_door_02",
				"pwh_objective_docks_second_warehouse_door_03",
				"pwh_objective_docks_second_warehouse_door_04"
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
				"pwh_objective_docks_second_warehouse_door_01",
				"pwh_objective_docks_second_warehouse_door_02",
				"pwh_objective_docks_second_warehouse_door_03",
				"pwh_objective_docks_second_warehouse_door_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_docks_first_warehouse_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_docks_first_warehouse_door_01",
				"pwh_objective_docks_first_warehouse_door_02",
				"pwh_objective_docks_first_warehouse_door_03",
				"pwh_objective_docks_first_warehouse_door_04"
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
				"pwh_objective_docks_first_warehouse_door_01",
				"pwh_objective_docks_first_warehouse_door_02",
				"pwh_objective_docks_first_warehouse_door_03",
				"pwh_objective_docks_first_warehouse_door_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_docks_explosion = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_docks_explosion_01",
				[2.0] = "pwh_objective_docks_explosion_02"
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
				[1.0] = "pwh_objective_docks_explosion_01",
				[2.0] = "pwh_objective_docks_explosion_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_docks_second_warehouse_inside = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_docks_second_warehouse_inside_01",
				"pwh_objective_docks_second_warehouse_inside_02",
				"pwh_objective_docks_second_warehouse_inside_03",
				"pwh_objective_docks_second_warehouse_inside_04"
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
				"pwh_objective_docks_second_warehouse_inside_01",
				"pwh_objective_docks_second_warehouse_inside_02",
				"pwh_objective_docks_second_warehouse_inside_03",
				"pwh_objective_docks_second_warehouse_inside_04"
			},
			randomize_indexes = {}
		},
		pwh_docks_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_docks_intro_c_01",
				[2.0] = "pwh_docks_intro_c_02"
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
				[1.0] = "pwh_docks_intro_c_01",
				[2.0] = "pwh_docks_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_docks_second_warehouse_escape = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_docks_second_warehouse_escape_01",
				"pwh_objective_docks_second_warehouse_escape_02",
				"pwh_objective_docks_second_warehouse_escape_03",
				"pwh_objective_docks_second_warehouse_escape_04"
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
				"pwh_objective_docks_second_warehouse_escape_01",
				"pwh_objective_docks_second_warehouse_escape_02",
				"pwh_objective_docks_second_warehouse_escape_03",
				"pwh_objective_docks_second_warehouse_escape_04"
			},
			randomize_indexes = {}
		},
		pwh_docks_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_docks_intro_b_01",
				[2.0] = "pwh_docks_intro_b_02"
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
				[1.0] = "pwh_docks_intro_b_01",
				[2.0] = "pwh_docks_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_docks_leave = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_docks_leave_01",
				"pwh_objective_docks_leave_02",
				"pwh_objective_docks_leave_03",
				"pwh_objective_docks_leave_04"
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
				"pwh_objective_docks_leave_01",
				"pwh_objective_docks_leave_02",
				"pwh_objective_docks_leave_03",
				"pwh_objective_docks_leave_04"
			},
			randomize_indexes = {}
		},
		pwh_docks_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_docks",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_docks_intro_a_01",
				[2.0] = "pwh_docks_intro_a_02"
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
				[1.0] = "pwh_docks_intro_a_01",
				[2.0] = "pwh_docks_intro_a_02"
			},
			randomize_indexes = {}
		}
	})
end
