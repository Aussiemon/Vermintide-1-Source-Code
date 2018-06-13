return function ()
	define_rule({
		name = "pbw_stromdorf_weather_stromdorf_story_two_01",
		response = "pbw_stromdorf_weather_stromdorf_story_two_01",
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
				"stromdorf_town_intro"
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
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_weather_stromdorf_story_two_01",
		response = "pwe_stromdorf_weather_stromdorf_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_stromdorf_weather_stromdorf_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_stromdorf_weather_stromdorf_story_two_02",
		response = "pbw_stromdorf_weather_stromdorf_story_two_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_weather_stromdorf_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_weather_stromdorf_story_two_02",
		response = "pwe_stromdorf_weather_stromdorf_story_two_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_weather_stromdorf_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_stromdorf_history_stromdorf_story_three_01",
		response = "pdr_stromdorf_history_stromdorf_story_three_01",
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
				"stromdorf_town_intro"
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
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_history_stromdorf_story_three_01",
		response = "pwh_stromdorf_history_stromdorf_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_stromdorf_history_stromdorf_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_stormdorf_history_stromdorf_story_three_02",
		response = "pdr_stormdorf_history_stromdorf_story_three_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_stromdorf_history_stromdorf_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_history_stromdorf_story_three_02",
		response = "pwh_stromdorf_history_stromdorf_story_three_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_stormdorf_history_stromdorf_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_stormdorf_history_stromdorf_story_three_03",
		response = "pdr_stormdorf_history_stromdorf_story_three_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_stromdorf_history_stromdorf_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_history_stromdorf_story_three_03",
		response = "pwh_stromdorf_history_stromdorf_story_three_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_stormdorf_history_stromdorf_story_three_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_personal_three_01",
		response = "pes_stromdorf_personal_three_01",
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
				"stromdorf_town_intro"
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
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_personal_three_01",
		response = "pwe_stromdorf_personal_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_stromdorf_personal_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_personal_three_02",
		response = "pes_stromdorf_personal_three_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_personal_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_personal_three_02",
		response = "pwe_stromdorf_personal_three_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_stromdorf_personal_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_personal_three_03",
		response = "pes_stromdorf_personal_three_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_personal_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_personal_three_03",
		response = "pwe_stromdorf_personal_three_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_stromdorf_personal_three_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_weather_stromdorf_story_four_01",
		response = "pwe_stromdorf_weather_stromdorf_story_four_01",
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
				"stromdorf_town_intro"
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
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_stromdorf_weather_stromdorf_story_four_01",
		response = "pdr_stromdorf_weather_stromdorf_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_weather_stromdorf_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_weather_stromdorf_story_four_01",
		response = "pes_stromdorf_weather_stromdorf_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_stromdorf_weather_stromdorf_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_stromdorf_weather_stromdorf_story_four_02",
		response = "pdr_stromdorf_weather_stromdorf_story_four_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_stromdorf_weather_stromdorf_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_weather_stromdorf_story_four_02",
		response = "pes_stromdorf_weather_stromdorf_story_four_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_stromdorf_weather_stromdorf_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_history_stromdorf_story_five_01",
		response = "pwe_stromdorf_history_stromdorf_story_five_01",
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
				"stromdorf_town_intro"
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
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_history_stromdorf_story_five_01",
		response = "pwh_stromdorf_history_stromdorf_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_history_stromdorf_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_history_stromdorf_story_five_02",
		response = "pwe_stromdorf_history_stromdorf_story_five_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_stromdorf_history_stromdorf_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_history_stromdorf_story_five_01",
		response = "pes_stromdorf_history_stromdorf_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_history_stromdorf_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_history_stromdorf_story_five_03",
		response = "pwe_stromdorf_history_stromdorf_story_five_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_stromdorf_history_stromdorf_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_history_stromdorf_story_five_02",
		response = "pes_stromdorf_history_stromdorf_story_five_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_history_stromdorf_story_five_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_history_stromdorf_story_five_04",
		response = "pwe_stromdorf_history_stromdorf_story_five_04",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_stromdorf_history_stromdorf_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_history_stromdorf_story_five_02",
		response = "pwh_stromdorf_history_stromdorf_story_five_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_history_stromdorf_story_five_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_history_stromdorf_story_five_05",
		response = "pwe_stromdorf_history_stromdorf_story_five_05",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_stromdorf_history_stromdorf_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_personal_two_01",
		response = "pwe_stromdorf_personal_two_01",
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
				"stromdorf_town_intro"
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
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_stromdorf_personal_two_01",
		response = "pbw_stromdorf_personal_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_personal_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_stromdorf_personal_two_02",
		response = "pwe_stromdorf_personal_two_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_stromdorf_personal_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_stromdorf_personal_two_02",
		response = "pbw_stromdorf_personal_two_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_stromdorf_personal_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_personal_two_01_optional",
		response = "pwh_stromdorf_personal_two_01_optional",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_stromdorf_personal_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_personal_one_01",
		response = "pwh_stromdorf_personal_one_01",
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
				"stromdorf_town_intro"
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
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_personal_one_01",
		response = "pes_stromdorf_personal_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_stromdorf_personal_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_personal_one_02",
		response = "pwh_stromdorf_personal_one_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_stromdorf_personal_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_stromdorf_personal_one_02",
		response = "pes_stromdorf_personal_one_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_stromdorf_personal_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_stromdorf_personal_one_03",
		response = "pwh_stromdorf_personal_one_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_stromdorf_personal_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				3
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pes_stromdorf_weather_stromdorf_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_weather_stromdorf_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_weather_stromdorf_story_four_01"
			}
		},
		pdr_stromdorf_weather_stromdorf_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_stromdorf_weather_stromdorf_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_stromdorf_weather_stromdorf_story_four_01"
			}
		},
		pwe_stromdorf_personal_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_personal_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_personal_two_02"
			}
		},
		pwh_stromdorf_history_stromdorf_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_three_01"
			}
		},
		pwh_stromdorf_personal_two_01_optional = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_personal_two_01_optional"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_personal_two_01_optional"
			}
		},
		pwe_stromdorf_personal_three_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_personal_three_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_personal_three_03"
			}
		},
		pes_stromdorf_personal_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_personal_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_personal_one_01"
			}
		},
		pbw_stromdorf_personal_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_stromdorf_personal_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_stromdorf_personal_two_01"
			}
		},
		pwe_stromdorf_weather_stromdorf_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_weather_stromdorf_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_weather_stromdorf_story_two_01"
			}
		},
		pwe_stromdorf_history_stromdorf_story_five_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_03"
			}
		},
		pwe_stromdorf_history_stromdorf_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_02"
			}
		},
		pes_stromdorf_personal_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_personal_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_personal_three_02"
			}
		},
		pwe_stromdorf_history_stromdorf_story_five_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_04"
			}
		},
		pwe_stromdorf_weather_stromdorf_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_weather_stromdorf_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_weather_stromdorf_story_two_02"
			}
		},
		pwe_stromdorf_history_stromdorf_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_01"
			}
		},
		pes_stromdorf_history_stromdorf_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_history_stromdorf_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_history_stromdorf_story_five_02"
			}
		},
		pwe_stromdorf_personal_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_personal_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_personal_three_01"
			}
		},
		pwh_stromdorf_personal_one_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_personal_one_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_personal_one_03"
			}
		},
		pes_stromdorf_personal_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_personal_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_personal_one_02"
			}
		},
		pwh_stromdorf_history_stromdorf_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_five_02"
			}
		},
		pdr_stormdorf_history_stromdorf_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_stormdorf_history_stromdorf_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_stormdorf_history_stromdorf_story_three_02"
			}
		},
		pwh_stromdorf_history_stromdorf_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_three_02"
			}
		},
		pes_stromdorf_personal_three_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_personal_three_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_personal_three_03"
			}
		},
		pdr_stromdorf_weather_stromdorf_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_stromdorf_weather_stromdorf_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_stromdorf_weather_stromdorf_story_four_02"
			}
		},
		pes_stromdorf_history_stromdorf_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_history_stromdorf_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_history_stromdorf_story_five_01"
			}
		},
		pwh_stromdorf_personal_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_personal_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_personal_one_01"
			}
		},
		pbw_stromdorf_personal_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_stromdorf_personal_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_stromdorf_personal_two_02"
			}
		},
		pes_stromdorf_weather_stromdorf_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_weather_stromdorf_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_weather_stromdorf_story_four_02"
			}
		},
		pdr_stromdorf_history_stromdorf_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_stromdorf_history_stromdorf_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_stromdorf_history_stromdorf_story_three_01"
			}
		},
		pwh_stromdorf_history_stromdorf_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_five_01"
			}
		},
		pwe_stromdorf_weather_stromdorf_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_weather_stromdorf_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_weather_stromdorf_story_four_01"
			}
		},
		pbw_stromdorf_weather_stromdorf_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_stromdorf_weather_stromdorf_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_stromdorf_weather_stromdorf_story_two_01"
			}
		},
		pes_stromdorf_personal_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_stromdorf_personal_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pes_stromdorf_personal_three_01"
			}
		},
		pwe_stromdorf_personal_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_personal_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_personal_two_01"
			}
		},
		pbw_stromdorf_weather_stromdorf_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_stromdorf_weather_stromdorf_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_stromdorf_weather_stromdorf_story_two_02"
			}
		},
		pdr_stormdorf_history_stromdorf_story_three_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_stormdorf_history_stromdorf_story_three_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_stormdorf_history_stromdorf_story_three_03"
			}
		},
		pwe_stromdorf_history_stromdorf_story_five_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_history_stromdorf_story_five_05"
			}
		},
		pwh_stromdorf_personal_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_personal_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_personal_one_02"
			}
		},
		pwh_stromdorf_history_stromdorf_story_three_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_three_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_stromdorf_history_stromdorf_story_three_03"
			}
		},
		pwe_stromdorf_personal_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "hero_conversations_stromdorf",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_stromdorf_personal_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_stromdorf_personal_three_02"
			}
		}
	})
end
