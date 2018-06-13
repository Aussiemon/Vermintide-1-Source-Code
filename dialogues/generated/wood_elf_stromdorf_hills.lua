return function ()
	define_rule({
		name = "pwe_objective_stromdorf_hills_find_the_courier",
		response = "pwe_objective_stromdorf_hills_find_the_courier",
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
				"objective_stromdorf_hills_find_the_courier"
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
				"time_since_objective_stromdorf_hills_find_the_courier",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_find_the_courier",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_tower_sighted",
		response = "pwe_objective_stromdorf_hills_tower_sighted",
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
				"objective_stromdorf_hills_tower_sighted"
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
				"time_since_objective_stromdorf_hills_tower_sighted",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_tower_sighted",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_arriving_at_tower",
		response = "pwe_objective_stromdorf_hills_arriving_at_tower",
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
				"objective_stromdorf_hills_arriving_at_tower"
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
				"time_since_objective_stromdorf_hills_arriving_at_tower",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_arriving_at_tower",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_search_the_tower",
		response = "pwe_objective_stromdorf_hills_search_the_tower",
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
				"objective_stromdorf_hills_search_the_tower"
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
				"time_since_objective_stromdorf_hills_search_the_tower",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_search_the_tower",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_top_of_the_tower",
		response = "pwe_objective_stromdorf_hills_top_of_the_tower",
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
				"objective_stromdorf_hills_top_of_the_tower"
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
				"time_since_objective_stromdorf_hills_top_of_the_tower",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_top_of_the_tower",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_the_message",
		response = "pwe_objective_stromdorf_hills_the_message",
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
				"objective_stromdorf_hills_the_message"
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
				"time_since_objective_stromdorf_hills_the_message",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_the_message",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_get_to_stromdorf",
		response = "pwe_objective_stromdorf_hills_get_to_stromdorf",
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
				"objective_stromdorf_hills_get_to_stromdorf"
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
				"time_since_objective_stromdorf_hills_get_to_stromdorf",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_get_to_stromdorf",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_tower_ramp",
		response = "pwe_objective_stromdorf_hills_tower_ramp",
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
				"objective_stromdorf_hills_tower_ramp"
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
				"time_since_objective_stromdorf_hills_tower_ramp",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_tower_ramp",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_horrible_swamp",
		response = "pwe_objective_stromdorf_hills_horrible_swamp",
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
				"objective_stromdorf_hills_horrible_swamp"
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
				"time_since_objective_stromdorf_hills_horrible_swamp",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_horrible_swamp",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_seeing_garden_of_morr",
		response = "pwe_objective_stromdorf_hills_seeing_garden_of_morr",
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
				"objective_stromdorf_hills_seeing_garden_of_morr"
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
				"time_since_objective_stromdorf_hills_seeing_garden_of_morr",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_seeing_garden_of_morr",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_passing_garden_of_morr",
		response = "pwe_objective_stromdorf_hills_passing_garden_of_morr",
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
				"objective_stromdorf_hills_passing_garden_of_morr"
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
				"time_since_objective_stromdorf_hills_passing_garden_of_morr",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_passing_garden_of_morr",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_entering_garden_of_morr",
		response = "pwe_objective_stromdorf_hills_entering_garden_of_morr",
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
				"objective_stromdorf_hills_entering_garden_of_morr"
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
				"time_since_objective_stromdorf_hills_entering_garden_of_morr",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_entering_garden_of_morr",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_grave_tomb",
		response = "pwe_objective_stromdorf_hills_grave_tomb",
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
				"objective_stromdorf_hills_grave_tomb"
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
				"time_since_objective_stromdorf_hills_grave_tomb",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_grave_tomb",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_exiting_garden_of_morr",
		response = "pwe_objective_stromdorf_hills_exiting_garden_of_morr",
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
				"objective_stromdorf_hills_exiting_garden_of_morr"
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
				"time_since_objective_stromdorf_hills_exiting_garden_of_morr",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_exiting_garden_of_morr",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr",
		response = "pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr",
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
				"objective_stromdorf_hills_dark_tunnel_garden_of_morr"
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
				"time_since_objective_stromdorf_hills_dark_tunnel_garden_of_morr",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_dark_tunnel_garden_of_morr",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_seeing_stromdorf",
		response = "pwe_objective_stromdorf_hills_seeing_stromdorf",
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
				"objective_stromdorf_hills_seeing_stromdorf"
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
				"time_since_objective_stromdorf_hills_seeing_stromdorf",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_seeing_stromdorf",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_weather_drizzle",
		response = "pwe_objective_stromdorf_hills_weather_drizzle",
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
				"objective_stromdorf_hills_weather_drizzle"
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
				"time_since_objective_stromdorf_hills_weather_drizzle",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_weather_drizzle",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_weather_fog",
		response = "pwe_objective_stromdorf_hills_weather_fog",
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
				"objective_stromdorf_hills_weather_fog"
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
				"time_since_objective_stromdorf_hills_weather_fog",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_weather_fog",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_weather_rain",
		response = "pwe_objective_stromdorf_hills_weather_rain",
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
				"objective_stromdorf_hills_weather_rain"
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
				"time_since_objective_stromdorf_hills_weather_rain",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_weather_rain",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_seeing_ferry",
		response = "pwe_objective_stromdorf_hills_seeing_ferry",
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
				"objective_stromdorf_hills_seeing_ferry"
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
				"time_since_objective_stromdorf_hills_seeing_ferry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_hills_seeing_ferry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_intro_a",
		response = "pwe_objective_stromdorf_hills_intro_a",
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
				"stromdorf_hills_intro"
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
				"time_since_stromdorf_hills_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_hills_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_intro_b",
		response = "pwe_objective_stromdorf_hills_intro_b",
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
				"objective_stromdorf_hills_intro_a"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_stromdorf_hills_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_hills_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_stromdorf_hills_intro_c",
		response = "pwe_objective_stromdorf_hills_intro_c",
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
				"objective_stromdorf_hills_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_stromdorf_hills_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_hills_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwe_objective_stromdorf_hills_the_message = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_the_message_01",
				"pwe_objective_stromdorf_hills_the_message_02",
				"pwe_objective_stromdorf_hills_the_message_03",
				"pwe_objective_stromdorf_hills_the_message_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwe_objective_stromdorf_hills_the_message_01",
				"pwe_objective_stromdorf_hills_the_message_02",
				"pwe_objective_stromdorf_hills_the_message_03",
				"pwe_objective_stromdorf_hills_the_message_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_seeing_garden_of_morr = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_seeing_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_seeing_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_seeing_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_seeing_garden_of_morr_04"
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
				"pwe_objective_stromdorf_hills_seeing_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_seeing_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_seeing_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_seeing_garden_of_morr_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_entering_garden_of_morr = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_entering_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_entering_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_entering_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_entering_garden_of_morr_04"
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
				"pwe_objective_stromdorf_hills_entering_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_entering_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_entering_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_entering_garden_of_morr_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_get_to_stromdorf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_get_to_stromdorf_01",
				"pwe_objective_stromdorf_hills_get_to_stromdorf_02",
				"pwe_objective_stromdorf_hills_get_to_stromdorf_03",
				"pwe_objective_stromdorf_hills_get_to_stromdorf_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwe_objective_stromdorf_hills_get_to_stromdorf_01",
				"pwe_objective_stromdorf_hills_get_to_stromdorf_02",
				"pwe_objective_stromdorf_hills_get_to_stromdorf_03",
				"pwe_objective_stromdorf_hills_get_to_stromdorf_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_seeing_ferry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_seeing_ferry_01",
				"pwe_objective_stromdorf_hills_seeing_ferry_02",
				"pwe_objective_stromdorf_hills_seeing_ferry_03",
				"pwe_objective_stromdorf_hills_seeing_ferry_04"
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
				"pwe_objective_stromdorf_hills_seeing_ferry_01",
				"pwe_objective_stromdorf_hills_seeing_ferry_02",
				"pwe_objective_stromdorf_hills_seeing_ferry_03",
				"pwe_objective_stromdorf_hills_seeing_ferry_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_search_the_tower = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_search_the_tower_01",
				"pwe_objective_stromdorf_hills_search_the_tower_02",
				"pwe_objective_stromdorf_hills_search_the_tower_03",
				"pwe_objective_stromdorf_hills_search_the_tower_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_stromdorf_hills_search_the_tower_01",
				"pwe_objective_stromdorf_hills_search_the_tower_02",
				"pwe_objective_stromdorf_hills_search_the_tower_03",
				"pwe_objective_stromdorf_hills_search_the_tower_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr_04"
			},
			dialogue_animations = {
				"dialogue_shout",
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
				"pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_dark_tunnel_garden_of_morr_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_stromdorf_hills_intro_c_01",
				[2.0] = "pwe_objective_stromdorf_hills_intro_c_02"
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
				[1.0] = "pwe_objective_stromdorf_hills_intro_c_01",
				[2.0] = "pwe_objective_stromdorf_hills_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_seeing_stromdorf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_seeing_stromdorf_01",
				"pwe_objective_stromdorf_hills_seeing_stromdorf_02",
				"pwe_objective_stromdorf_hills_seeing_stromdorf_03",
				"pwe_objective_stromdorf_hills_seeing_stromdorf_04"
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
				"pwe_objective_stromdorf_hills_seeing_stromdorf_01",
				"pwe_objective_stromdorf_hills_seeing_stromdorf_02",
				"pwe_objective_stromdorf_hills_seeing_stromdorf_03",
				"pwe_objective_stromdorf_hills_seeing_stromdorf_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_stromdorf_hills_intro_b_01",
				[2.0] = "pwe_objective_stromdorf_hills_intro_b_02"
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
				[1.0] = "pwe_objective_stromdorf_hills_intro_b_01",
				[2.0] = "pwe_objective_stromdorf_hills_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_tower_sighted = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_tower_sighted_01",
				"pwe_objective_stromdorf_hills_tower_sighted_02",
				"pwe_objective_stromdorf_hills_tower_sighted_03",
				"pwe_objective_stromdorf_hills_tower_sighted_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_stromdorf_hills_tower_sighted_01",
				"pwe_objective_stromdorf_hills_tower_sighted_02",
				"pwe_objective_stromdorf_hills_tower_sighted_03",
				"pwe_objective_stromdorf_hills_tower_sighted_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_top_of_the_tower = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_top_of_the_tower_01",
				"pwe_objective_stromdorf_hills_top_of_the_tower_02",
				"pwe_objective_stromdorf_hills_top_of_the_tower_03",
				"pwe_objective_stromdorf_hills_top_of_the_tower_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwe_objective_stromdorf_hills_top_of_the_tower_01",
				"pwe_objective_stromdorf_hills_top_of_the_tower_02",
				"pwe_objective_stromdorf_hills_top_of_the_tower_03",
				"pwe_objective_stromdorf_hills_top_of_the_tower_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_intro_a = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_stromdorf_hills_intro_a_01",
				[2.0] = "pwe_objective_stromdorf_hills_intro_a_02"
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
				[1.0] = "pwe_objective_stromdorf_hills_intro_a_01",
				[2.0] = "pwe_objective_stromdorf_hills_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_weather_rain = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_weather_rain_01",
				"pwe_objective_stromdorf_hills_weather_rain_02",
				"pwe_objective_stromdorf_hills_weather_rain_03",
				"pwe_objective_stromdorf_hills_weather_rain_04"
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
				"pwe_objective_stromdorf_hills_weather_rain_01",
				"pwe_objective_stromdorf_hills_weather_rain_02",
				"pwe_objective_stromdorf_hills_weather_rain_03",
				"pwe_objective_stromdorf_hills_weather_rain_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_weather_fog = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_weather_fog_01",
				"pwe_objective_stromdorf_hills_weather_fog_02",
				"pwe_objective_stromdorf_hills_weather_fog_03",
				"pwe_objective_stromdorf_hills_weather_fog_04"
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
				"pwe_objective_stromdorf_hills_weather_fog_01",
				"pwe_objective_stromdorf_hills_weather_fog_02",
				"pwe_objective_stromdorf_hills_weather_fog_03",
				"pwe_objective_stromdorf_hills_weather_fog_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_weather_drizzle = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_weather_drizzle_01",
				"pwe_objective_stromdorf_hills_weather_drizzle_02",
				"pwe_objective_stromdorf_hills_weather_drizzle_03",
				"pwe_objective_stromdorf_hills_weather_drizzle_04"
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
				"pwe_objective_stromdorf_hills_weather_drizzle_01",
				"pwe_objective_stromdorf_hills_weather_drizzle_02",
				"pwe_objective_stromdorf_hills_weather_drizzle_03",
				"pwe_objective_stromdorf_hills_weather_drizzle_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_exiting_garden_of_morr = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_exiting_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_exiting_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_exiting_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_exiting_garden_of_morr_04"
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
				"pwe_objective_stromdorf_hills_exiting_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_exiting_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_exiting_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_exiting_garden_of_morr_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_tower_ramp = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_tower_ramp_01",
				"pwe_objective_stromdorf_hills_tower_ramp_02",
				"pwe_objective_stromdorf_hills_tower_ramp_03",
				"pwe_objective_stromdorf_hills_tower_ramp_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_happy",
				"face_contempt",
				"face_contempt",
				"face_neutral"
			},
			localization_strings = {
				"pwe_objective_stromdorf_hills_tower_ramp_01",
				"pwe_objective_stromdorf_hills_tower_ramp_02",
				"pwe_objective_stromdorf_hills_tower_ramp_03",
				"pwe_objective_stromdorf_hills_tower_ramp_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_horrible_swamp = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_horrible_swamp_01",
				"pwe_objective_stromdorf_hills_horrible_swamp_02",
				"pwe_objective_stromdorf_hills_horrible_swamp_03",
				"pwe_objective_stromdorf_hills_horrible_swamp_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
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
				"pwe_objective_stromdorf_hills_horrible_swamp_01",
				"pwe_objective_stromdorf_hills_horrible_swamp_02",
				"pwe_objective_stromdorf_hills_horrible_swamp_03",
				"pwe_objective_stromdorf_hills_horrible_swamp_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_grave_tomb = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_grave_tomb_01",
				"pwe_objective_stromdorf_hills_grave_tomb_02",
				"pwe_objective_stromdorf_hills_grave_tomb_03",
				"pwe_objective_stromdorf_hills_grave_tomb_04"
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
				"pwe_objective_stromdorf_hills_grave_tomb_01",
				"pwe_objective_stromdorf_hills_grave_tomb_02",
				"pwe_objective_stromdorf_hills_grave_tomb_03",
				"pwe_objective_stromdorf_hills_grave_tomb_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_find_the_courier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_find_the_courier_01",
				"pwe_objective_stromdorf_hills_find_the_courier_02",
				"pwe_objective_stromdorf_hills_find_the_courier_03",
				"pwe_objective_stromdorf_hills_find_the_courier_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_stromdorf_hills_find_the_courier_01",
				"pwe_objective_stromdorf_hills_find_the_courier_02",
				"pwe_objective_stromdorf_hills_find_the_courier_03",
				"pwe_objective_stromdorf_hills_find_the_courier_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_passing_garden_of_morr = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_passing_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_passing_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_passing_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_passing_garden_of_morr_04"
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
				"pwe_objective_stromdorf_hills_passing_garden_of_morr_01",
				"pwe_objective_stromdorf_hills_passing_garden_of_morr_02",
				"pwe_objective_stromdorf_hills_passing_garden_of_morr_03",
				"pwe_objective_stromdorf_hills_passing_garden_of_morr_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_stromdorf_hills_arriving_at_tower = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_stromdorf_hills",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_stromdorf_hills_arriving_at_tower_01",
				"pwe_objective_stromdorf_hills_arriving_at_tower_02",
				"pwe_objective_stromdorf_hills_arriving_at_tower_03",
				"pwe_objective_stromdorf_hills_arriving_at_tower_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_stromdorf_hills_arriving_at_tower_01",
				"pwe_objective_stromdorf_hills_arriving_at_tower_02",
				"pwe_objective_stromdorf_hills_arriving_at_tower_03",
				"pwe_objective_stromdorf_hills_arriving_at_tower_04"
			},
			randomize_indexes = {}
		}
	})
end
