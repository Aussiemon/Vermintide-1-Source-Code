return function ()
	define_rule({
		name = "pbw_dialogue_01",
		response = "pbw_dialogue_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_03",
		response = "pwh_dialogue_response_03",
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
				"pbw_dialogue_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_dialogue_response_02",
		response = "pbw_dialogue_response_02",
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
				"pwh_dialogue_response_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_01",
		response = "pwe_dialogue_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_04",
		response = "pwh_dialogue_response_04",
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
				"pwe_dialogue_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_dialogue_response_01",
		response = "pwe_dialogue_response_01",
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
				"pwh_dialogue_response_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_dialogue_response_05",
		response = "pwh_dialogue_response_05",
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
				"pwe_dialogue_response_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_dialogue_response_02",
		response = "pwe_dialogue_response_02",
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
				"pwh_dialogue_response_05"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwe_dialogue_02",
		response = "pwe_dialogue_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_02",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_02",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_06",
		response = "pwh_dialogue_response_06",
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
				"pwe_dialogue_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_dialogue_response_03",
		response = "pwe_dialogue_response_03",
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
				"pwh_dialogue_response_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_01",
		response = "pdr_dialogue_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_04",
		response = "pes_dialogue_response_04",
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
				"pdr_dialogue_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_dialogue_response_06",
		response = "pdr_dialogue_response_06",
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
				"pes_dialogue_response_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_06",
		response = "pwe_dialogue_response_06",
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
				"pdr_dialogue_response_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_07",
		response = "pdr_dialogue_response_07",
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
				"pwe_dialogue_response_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_07",
		response = "pwe_dialogue_response_07",
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
				"pdr_dialogue_response_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_02",
		response = "pdr_dialogue_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_02",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_02",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_07",
		response = "pwh_dialogue_response_07",
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
				"pdr_dialogue_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_dialogue_response_08",
		response = "pdr_dialogue_response_08",
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
				"pwh_dialogue_response_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_dialogue_response_04",
		response = "pbw_dialogue_response_04",
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
				"pdr_dialogue_response_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_dialogue_response_09",
		response = "pdr_dialogue_response_09",
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
				"pbw_dialogue_response_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_dialogue_response_08",
		response = "pwh_dialogue_response_08",
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
				"pdr_dialogue_response_09"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_dialogue_response_09_1",
		response = "pdr_dialogue_response_09_1",
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
				"pwh_dialogue_response_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_08",
		response = "pwe_dialogue_response_08",
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
				"pdr_dialogue_response_09_1"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_10",
		response = "pdr_dialogue_response_10",
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
				"pwe_dialogue_response_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_03",
		response = "pwe_dialogue_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				0
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_03",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_03",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_05",
		response = "pbw_dialogue_response_05",
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
				"pwe_dialogue_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_response_09",
		response = "pwe_dialogue_response_09",
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
				"pbw_dialogue_response_05"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwe_dialogue_04",
		response = "pwe_dialogue_04",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_04",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_04",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_05",
		response = "pes_dialogue_response_05",
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
				"pwe_dialogue_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_dialogue_response_10",
		response = "pwe_dialogue_response_10",
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
				"pes_dialogue_response_05"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_dialogue_response_06",
		response = "pes_dialogue_response_06",
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
				"pwe_dialogue_response_10"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_dialogue_response_11",
		response = "pwe_dialogue_response_11",
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
				"pes_dialogue_response_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwe_dialogue_05",
		response = "pwe_dialogue_05",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_05",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_05",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_07",
		response = "pes_dialogue_response_07",
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
				"pwe_dialogue_05"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_06",
		response = "pbw_dialogue_response_06",
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
				"pes_dialogue_response_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_response_11",
		response = "pwh_dialogue_response_11",
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
				"pbw_dialogue_response_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_dialogue_response_12",
		response = "pwe_dialogue_response_12",
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
				"pwh_dialogue_response_11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwe_dialogue_06",
		response = "pwe_dialogue_06",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_07",
		response = "pbw_dialogue_response_07",
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
				"pwe_dialogue_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_response_13",
		response = "pwe_dialogue_response_13",
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
				"pbw_dialogue_response_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_dialogue_05",
		response = "pwh_dialogue_05",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_05",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_05",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_response_13",
		response = "pdr_dialogue_response_13",
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
				"pwh_dialogue_05"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_14",
		response = "pwe_dialogue_response_14",
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
				"pdr_dialogue_response_13"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_dialogue_06",
		response = "pbw_dialogue_06",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_15",
		response = "pwe_dialogue_response_15",
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
				"pbw_dialogue_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_dialogue_response_12",
		response = "pwh_dialogue_response_12",
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
				"pwe_dialogue_response_15"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_dialogue_03",
		response = "pdr_dialogue_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_03",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_03",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_08",
		response = "pes_dialogue_response_08",
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
				"pdr_dialogue_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_dialogue_response_15",
		response = "pdr_dialogue_response_15",
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
				"pes_dialogue_response_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_dialogue_response_08",
		response = "pbw_dialogue_response_08",
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
				"pdr_dialogue_response_15"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_06",
		response = "pwh_dialogue_06",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_16",
		response = "pwe_dialogue_response_16",
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
				"pwh_dialogue_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_dialogue_response_13",
		response = "pwh_dialogue_response_13",
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
				"pwe_dialogue_response_16"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_dialogue_response_09",
		response = "pes_dialogue_response_09",
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
				"pwh_dialogue_response_13"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_dialogue_response_17",
		response = "pwe_dialogue_response_17",
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
				"pes_dialogue_response_09"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwe_dialogue_07",
		response = "pwe_dialogue_07",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_10",
		response = "pes_dialogue_response_10",
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
				"pwe_dialogue_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_dialogue_response_18",
		response = "pwe_dialogue_response_18",
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
				"pes_dialogue_response_10"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_dialogue_response_09a",
		response = "pes_dialogue_response_09a",
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
				"pwe_dialogue_response_18"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_dialogue_response_18a",
		response = "pwe_dialogue_response_18a",
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
				"pes_dialogue_response_09a"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwe_dialogue_08",
		response = "pwe_dialogue_08",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_08",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_08",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_11",
		response = "pbw_dialogue_response_11",
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
				"pwe_dialogue_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_02",
		response = "pes_dialogue_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_02",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_02",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_response_17",
		response = "pdr_dialogue_response_17",
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
				"pes_dialogue_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_dialogue_response_15",
		response = "pwh_dialogue_response_15",
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
				"pdr_dialogue_response_17"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_dialogue_04",
		response = "pdr_dialogue_04",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_04",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_04",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_16",
		response = "pwh_dialogue_response_16",
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
				"pdr_dialogue_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_dialogue_07",
		response = "pbw_dialogue_07",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_response_18",
		response = "pdr_dialogue_response_18",
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
				"pbw_dialogue_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_dialogue_response_17",
		response = "pwh_dialogue_response_17",
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
				"pdr_dialogue_response_18"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_dialogue_03",
		response = "pes_dialogue_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_03",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_03",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_12",
		response = "pbw_dialogue_response_12",
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
				"pes_dialogue_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_04",
		response = "pes_dialogue_04",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_04",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_04",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_response_19",
		response = "pdr_dialogue_response_19",
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
				"pes_dialogue_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_dialogue_response_13",
		response = "pbw_dialogue_response_13",
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
				"pdr_dialogue_response_19"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_response_11",
		response = "pes_dialogue_response_11",
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
				"pbw_dialogue_response_13"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pes_dialogue_06",
		response = "pes_dialogue_06",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_14",
		response = "pbw_dialogue_response_14",
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
				"pes_dialogue_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_response_13",
		response = "pes_dialogue_response_13",
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
				"pbw_dialogue_response_14"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_15",
		response = "pbw_dialogue_response_15",
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
				"pes_dialogue_response_13"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_response_14",
		response = "pes_dialogue_response_14",
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
				"pbw_dialogue_response_15"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pes_dialogue_05",
		response = "pes_dialogue_05",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_05",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_05",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_response_20",
		response = "pdr_dialogue_response_20",
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
				"pes_dialogue_05"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_dialogue_response_15",
		response = "pes_dialogue_response_15",
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
				"pdr_dialogue_response_20"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_dialogue_response_21",
		response = "pdr_dialogue_response_21",
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
				"pes_dialogue_response_15"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_dialogue_response_16",
		response = "pbw_dialogue_response_16",
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
				"pdr_dialogue_response_21"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_dialogue_response_22",
		response = "pdr_dialogue_response_22",
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
				"pbw_dialogue_response_16"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_dialogue_09",
		response = "pes_dialogue_09",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_19",
		response = "pwh_dialogue_response_19",
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
				"pes_dialogue_09"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_dialogue_10",
		response = "pes_dialogue_10",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_17",
		response = "pbw_dialogue_response_17",
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
				"pes_dialogue_10"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_response_15_1",
		response = "pes_dialogue_response_15_1",
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
				"pbw_dialogue_response_17"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_18",
		response = "pbw_dialogue_response_18",
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
				"pes_dialogue_response_15_1"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_09",
		response = "pwe_dialogue_09",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_19",
		response = "pbw_dialogue_response_19",
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
				"pwe_dialogue_09"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_response_22",
		response = "pwe_dialogue_response_22",
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
				"pbw_dialogue_response_19"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_dialogue_response_20",
		response = "pbw_dialogue_response_20",
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
				"pwe_dialogue_response_22"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_07",
		response = "pwh_dialogue_07",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_22",
		response = "pbw_dialogue_response_22",
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
				"pwh_dialogue_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_response_20",
		response = "pwh_dialogue_response_20",
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
				"pbw_dialogue_response_22"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_dialogue_09_1",
		response = "pwe_dialogue_09_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_09_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_09_1",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_16",
		response = "pes_dialogue_response_16",
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
				"pwe_dialogue_09_1"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_23",
		response = "pbw_dialogue_response_23",
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
				"pes_dialogue_response_16"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_response_17",
		response = "pes_dialogue_response_17",
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
				"pbw_dialogue_response_23"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_24",
		response = "pbw_dialogue_response_24",
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
				"pes_dialogue_response_17"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_10",
		response = "pwe_dialogue_10",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_18",
		response = "pes_dialogue_response_18",
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
				"pwe_dialogue_10"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_25",
		response = "pbw_dialogue_response_25",
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
				"pes_dialogue_response_18"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_dialogue_08",
		response = "pbw_dialogue_08",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_08",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_08",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_21",
		response = "pwh_dialogue_response_21",
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
				"pbw_dialogue_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_dialogue_response_23",
		response = "pwe_dialogue_response_23",
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
				"pwh_dialogue_response_21"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_dialogue_07",
		response = "pes_dialogue_07",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_24",
		response = "pwe_dialogue_response_24",
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
				"pes_dialogue_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_dialogue_response_26",
		response = "pbw_dialogue_response_26",
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
				"pwe_dialogue_response_24"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_response_19",
		response = "pes_dialogue_response_19",
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
				"pbw_dialogue_response_26"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_dialogue_response_25",
		response = "pwe_dialogue_response_25",
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
				"pes_dialogue_response_19"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_05",
		response = "pdr_dialogue_05",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_05",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_05",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_20",
		response = "pes_dialogue_response_20",
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
				"pdr_dialogue_05"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_dialogue_response_22",
		response = "pwh_dialogue_response_22",
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
				"pes_dialogue_response_20"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_dialogue_11",
		response = "pwe_dialogue_11",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_11",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_11",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_21",
		response = "pes_dialogue_response_21",
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
				"pwe_dialogue_11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_dialogue_response_26",
		response = "pwe_dialogue_response_26",
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
				"pes_dialogue_response_21"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_24",
		response = "pdr_dialogue_response_24",
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
				"pwe_dialogue_response_26"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_27",
		response = "pwe_dialogue_response_27",
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
				"pdr_dialogue_response_24"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwe_dialogue_12",
		response = "pwe_dialogue_12",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_27",
		response = "pbw_dialogue_response_27",
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
				"pwe_dialogue_12"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_response_28",
		response = "pwe_dialogue_response_28",
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
				"pbw_dialogue_response_27"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_dialogue_response_23",
		response = "pwh_dialogue_response_23",
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
				"pwe_dialogue_response_28"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_dialogue_response_29",
		response = "pwe_dialogue_response_29",
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
				"pwh_dialogue_response_23"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_dialogue_09",
		response = "pbw_dialogue_09",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_30",
		response = "pwe_dialogue_response_30",
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
				"pbw_dialogue_09"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_dialogue_response_28",
		response = "pbw_dialogue_response_28",
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
				"pwe_dialogue_response_=Data!P11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_response_31",
		response = "pwe_dialogue_response_31",
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
				"pbw_dialogue_response_28"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_dialogue_10",
		response = "pbw_dialogue_10",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_24",
		response = "pwh_dialogue_response_24",
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
				"pbw_dialogue_10"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_dialogue_response_22",
		response = "pes_dialogue_response_22",
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
				"pwh_dialogue_response_24"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_dialogue_06",
		response = "pdr_dialogue_06",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_23",
		response = "pes_dialogue_response_23",
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
				"pdr_dialogue_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_dialogue_response_25",
		response = "pdr_dialogue_response_25",
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
				"pes_dialogue_response_23"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_dialogue_response_25",
		response = "pwh_dialogue_response_25",
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
				"pdr_dialogue_response_25"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_dialogue_11",
		response = "pbw_dialogue_11",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_11",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_11",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_response_26",
		response = "pdr_dialogue_response_26",
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
				"pbw_dialogue_11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_dialogue_response_29",
		response = "pbw_dialogue_response_29",
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
				"pdr_dialogue_response_26"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_dialogue_response_26_1",
		response = "pdr_dialogue_response_26_1",
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
				"pbw_dialogue_response_29"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pdr_dialogue_07",
		response = "pdr_dialogue_07",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_24",
		response = "pes_dialogue_response_24",
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
				"pdr_dialogue_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_dialogue_response_27",
		response = "pdr_dialogue_response_27",
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
				"pes_dialogue_response_24"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_32",
		response = "pwe_dialogue_response_32",
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
				"pdr_dialogue_response_27"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_08",
		response = "pdr_dialogue_08",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_08",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_08",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_30",
		response = "pbw_dialogue_response_30",
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
				"pdr_dialogue_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_response_33",
		response = "pwe_dialogue_response_33",
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
				"pbw_dialogue_response_=Data!P11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_09",
		response = "pdr_dialogue_09",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_response_26",
		response = "pwh_dialogue_response_26",
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
				"pdr_dialogue_09"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_dialogue_response_28",
		response = "pdr_dialogue_response_28",
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
				"pwh_dialogue_response_26"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pdr_dialogue_10",
		response = "pdr_dialogue_10",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_25",
		response = "pes_dialogue_response_25",
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
				"pdr_dialogue_10"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_dialogue_response_29",
		response = "pdr_dialogue_response_29",
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
				"pes_dialogue_response_25"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pdr_dialogue_11",
		response = "pdr_dialogue_11",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_11",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_11",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_34",
		response = "pwe_dialogue_response_34",
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
				"pdr_dialogue_11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_30",
		response = "pdr_dialogue_response_30",
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
				"pwe_dialogue_response_34"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_35",
		response = "pwe_dialogue_response_35",
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
				"pdr_dialogue_response_=Data!P11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_12",
		response = "pdr_dialogue_12",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_36",
		response = "pwe_dialogue_response_36",
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
				"pdr_dialogue_12"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_32",
		response = "pdr_dialogue_response_32",
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
				"pwe_dialogue_response_36"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_dialogue_response_31",
		response = "pbw_dialogue_response_31",
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
				"pdr_dialogue_response_32"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_08",
		response = "pwh_dialogue_08",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_08",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_08",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_32",
		response = "pbw_dialogue_response_32",
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
				"pwh_dialogue_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_09",
		response = "pwh_dialogue_09",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_33",
		response = "pbw_dialogue_response_33",
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
				"pwh_dialogue_09"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_respones_26b",
		response = "pwh_dialogue_respones_26b",
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
				"pbw_dialogue_response_33"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_dialogue_10",
		response = "pwh_dialogue_10",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_34",
		response = "pbw_dialogue_response_34",
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
				"pwh_dialogue_10"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_11",
		response = "pwh_dialogue_11",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_11",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_11",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_35",
		response = "pbw_dialogue_response_35",
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
				"pwh_dialogue_11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_12",
		response = "pwh_dialogue_12",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_36",
		response = "pbw_dialogue_response_36",
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
				"pwh_dialogue_12"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_13",
		response = "pwh_dialogue_13",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_13",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_13",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_37",
		response = "pbw_dialogue_response_37",
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
				"pwh_dialogue_13"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_dialogue_response_27",
		response = "pwh_dialogue_response_27",
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
				"pbw_dialogue_response_37"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_dialogue_14",
		response = "pwh_dialogue_14",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_14",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_14",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_26",
		response = "pes_dialogue_response_26",
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
				"pwh_dialogue_14"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_dialogue_response_28",
		response = "pwh_dialogue_response_28",
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
				"pes_dialogue_response_26"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_dialogue_08",
		response = "pes_dialogue_08",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_37",
		response = "pwe_dialogue_response_37",
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
				"pes_dialogue_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_dialogue_response_27",
		response = "pes_dialogue_response_27",
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
				"pwe_dialogue_response_37"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_dialogue_response_37_1",
		response = "pwe_dialogue_response_37_1",
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
				"pes_dialogue_response_27"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_dialogue_09_1",
		response = "pes_dialogue_09_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_09_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_09_1",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_38",
		response = "pbw_dialogue_response_38",
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
				"pes_dialogue_09_1"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_response_28",
		response = "pes_dialogue_response_28",
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
				"pbw_dialogue_response_38"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_38_1",
		response = "pbw_dialogue_response_38_1",
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
				"pes_dialogue_response_28"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_13",
		response = "pwe_dialogue_13",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_13",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_13",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_response_39",
		response = "pbw_dialogue_response_39",
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
				"pwe_dialogue_13"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_dialogue_response_38",
		response = "pwe_dialogue_response_38",
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
				"pbw_dialogue_response_39"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_13",
		response = "pdr_dialogue_13",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_13",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_13",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_39",
		response = "pwe_dialogue_response_39",
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
				"pdr_dialogue_13"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_33",
		response = "pdr_dialogue_response_33",
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
				"pwe_dialogue_response_39"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_40",
		response = "pwe_dialogue_response_40",
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
				"pdr_dialogue_response_33"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_34",
		response = "pdr_dialogue_response_34",
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
				"pwe_dialogue_response_40"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_41",
		response = "pwe_dialogue_response_41",
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
				"pdr_dialogue_response_34"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_dialogue_12",
		response = "pbw_dialogue_12",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_29",
		response = "pes_dialogue_response_29",
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
				"pbw_dialogue_12"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_40",
		response = "pbw_dialogue_response_40",
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
				"pes_dialogue_response_29"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_dialogue_response_30",
		response = "pes_dialogue_response_30",
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
				"pbw_dialogue_response_40"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_dialogue_response_41",
		response = "pbw_dialogue_response_41",
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
				"pes_dialogue_response_=Data!P11"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_dialogue_14",
		response = "pdr_dialogue_14",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_14",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_14",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_response_42",
		response = "pwe_dialogue_response_42",
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
				"pdr_dialogue_14"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_35",
		response = "pdr_dialogue_response_35",
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
				"pwe_dialogue_response_42"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_dialogue_response_43",
		response = "pwe_dialogue_response_43",
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
				"pdr_dialogue_response_35"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_dialogue_response_36",
		response = "pdr_dialogue_response_36",
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
				"pwe_dialogue_response_43"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_gameplay_entering_greyseer_lair_01",
		response = "pwh_gameplay_entering_greyseer_lair_01",
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
				"end_boss_entering_greyseer_lair"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_gameplay_response_09",
		response = "pbw_gameplay_response_09",
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
				"pwh_end_boss_entering_greyseer_lair_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_gameplay_response_09",
		response = "pwh_gameplay_response_09",
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
				"pbw_gameplay_response_09"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_gameplay_entering_greyseer_lair_01",
		response = "pwe_gameplay_entering_greyseer_lair_01",
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
				"end_boss_entering_greyseer_lair"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_gameplay_response_06",
		response = "pes_gameplay_response_06",
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
				"pwe_end_boss_entering_greyseer_lair_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_gameplay_response_10",
		response = "pwe_gameplay_response_10",
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
				"pes_gameplay_response_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_gameplay_entering_greyseer_lair_01",
		response = "pbw_gameplay_entering_greyseer_lair_01",
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
				"end_boss_entering_greyseer_lair"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_response_08",
		response = "pdr_gameplay_response_08",
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
				"pbw_end_boss_entering_greyseer_lair_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pdr_gameplay_entering_greyseer_lair_01",
		response = "pdr_gameplay_entering_greyseer_lair_01",
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
				"end_boss_entering_greyseer_lair"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_response_10",
		response = "pwh_gameplay_response_10",
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
				"pdr_end_boss_entering_greyseer_lair_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_gameplay_entering_greyseer_lair_01",
		response = "pes_gameplay_entering_greyseer_lair_01",
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
				"end_boss_entering_greyseer_lair"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_gameplay_entering_greyseer_lair",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_gameplay_response_10",
		response = "pbw_gameplay_response_10",
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
				"pes_end_boss_entering_greyseer_lair_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		response = "pdr_gameplay_killing_a_rat_ogre_01",
		name = "pdr_gameplay_killing_a_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_kill"
			},
			{
				"query_context",
				"killed_type",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"query_context",
				"weapon_slot",
				OP.EQ,
				"slot_melee"
			},
			{
				"user_memory",
				"times_killed_rat_ogre",
				OP.NEQ,
				2
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_response_07",
		name = "pbw_gameplay_response_07",
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
				"pdr_gameplay_killing_a_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_06",
		name = "pdr_gameplay_response_06",
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
				"pbw_gameplay_response_07"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_killing_rat_ogre_01",
		name = "pbw_gameplay_killing_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_kill"
			},
			{
				"query_context",
				"killed_type",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"user_memory",
				"times_killed_rat_ogre",
				OP.NEQ,
				2
			}
		}
	})
	define_rule({
		response = "pes_gameplay_response_04",
		name = "pes_gameplay_response_04",
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
				"pbw_gameplay_killing_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_soldier_shooting_rat_ogre_01",
		name = "pdr_gameplay_soldier_shooting_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"killed_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"query_context",
				"killer_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"weapon_slot",
				OP.EQ,
				"slot_ranged"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_response_07",
		name = "pwh_gameplay_response_07",
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
				"pdr_gameplay_soldier_shooting_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_killing_rat_ogre_01",
		name = "pes_gameplay_killing_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_kill"
			},
			{
				"query_context",
				"killed_type",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"query_context",
				"weapon_slot",
				OP.EQ,
				"slot_melee"
			},
			{
				"user_memory",
				"times_killed_rat_ogre",
				OP.NEQ,
				2
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_07",
		name = "pdr_gameplay_response_07",
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
				"pes_gameplay_killing_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pdr_hunter_shoots_rat_ogre_01",
		name = "pdr_hunter_shoots_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"killed_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"query_context",
				"killer_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"weapon_slot",
				OP.EQ,
				"slot_ranged"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_response_08",
		name = "pwh_gameplay_response_08",
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
				"pdr_hunter_shoots_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_response_08",
		name = "pbw_gameplay_response_08",
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
				"pwh_gameplay_response_08"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_killing_a_rat_ogre_01",
		name = "pwh_gameplay_killing_a_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_kill"
			},
			{
				"query_context",
				"killed_type",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"user_memory",
				"times_killed_rat_ogre",
				OP.NEQ,
				2
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_response_08",
		name = "pwe_gameplay_response_08",
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
				"pwh_gameplay_killing_a_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_elf_shoots_a_rat_ogre_01",
		name = "pes_gameplay_elf_shoots_a_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"killed_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"query_context",
				"killer_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"weapon_slot",
				OP.EQ,
				"slot_ranged"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_response_09",
		name = "pwe_gameplay_response_09",
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
				"pes_gameplay_elf_shoots_a_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_killing_a_rat_ogre_01",
		name = "pwe_gameplay_killing_a_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_kill"
			},
			{
				"query_context",
				"killed_type",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"query_context",
				"weapon_slot",
				OP.EQ,
				"slot_melee"
			},
			{
				"user_memory",
				"times_killed_rat_ogre",
				OP.NEQ,
				2
			}
		}
	})
	define_rule({
		response = "pes_gameplay_response_05",
		name = "pes_gameplay_response_05",
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
				"pwe_gameplay_killing_a_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_killing_a_rat_ogre_crossbow_01",
		name = "pdr_gameplay_killing_a_rat_ogre_crossbow_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_kill"
			},
			{
				"query_context",
				"killed_type",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"query_context",
				"weapon_type",
				OP.EQ,
				"dr_crossbow"
			},
			{
				"user_memory",
				"times_killed_rat_ogre",
				OP.NEQ,
				2
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_response_07",
		name = "pwe_gameplay_response_07",
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
				"pdr_gameplay_killing_a_rat_ogre_crossbow_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_wizard_fires_a_rat_ogre_01",
		name = "pdr_gameplay_wizard_fires_a_rat_ogre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"killed_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"query_context",
				"killer_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"query_context",
				"dot_type",
				OP.EQ,
				"burning_dot"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_response_06",
		name = "pwh_gameplay_response_06",
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
				"pdr_gameplay_wizard_fires_a_rat_ogre_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_response_07_b",
		name = "pbw_gameplay_response_07_b",
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
				"pwh_gameplay_response_06"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_hunter_misses_bomb_01",
		name = "pwe_gameplay_hunter_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_response_19",
		name = "pwh_gameplay_response_19",
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
				"pwe_gameplay_hunter_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_response_20",
		name = "pwe_gameplay_response_20",
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
				"pwh_gameplay_response_19"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_hunter_misses_bomb_01",
		name = "pdr_gameplay_hunter_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_response_20",
		name = "pwh_gameplay_response_20",
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
				"pdr_gameplay_hunter_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_17",
		name = "pdr_gameplay_response_17",
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
				"pwh_gameplay_response_20"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_hunter_misses_bomb_01",
		name = "pbw_gameplay_hunter_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_response_21",
		name = "pwh_gameplay_response_21",
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
				"pbw_gameplay_hunter_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_hunter_misses_bomb_01",
		name = "pes_gameplay_hunter_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_response_22",
		name = "pwh_gameplay_response_22",
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
				"pes_gameplay_hunter_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_elf_misses_bomb_01",
		name = "pwh_gameplay_elf_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_response_21",
		name = "pwe_gameplay_response_21",
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
				"pwh_gameplay_elf_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_elf_misses_bomb_01",
		name = "pdr_gameplay_elf_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_response_22",
		name = "pwe_gameplay_response_22",
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
				"pdr_gameplay_elf_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_elf_misses_bomb_01",
		name = "pbw_gameplay_elf_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_response_23",
		name = "pwe_gameplay_response_23",
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
				"pbw_gameplay_elf_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_elf_misses_bomb_01",
		name = "pes_gameplay_elf_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_response_24",
		name = "pwe_gameplay_response_24",
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
				"pes_gameplay_elf_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_wizard_misses_bomb_01",
		name = "pwh_gameplay_wizard_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_response_21",
		name = "pbw_gameplay_response_21",
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
				"pwh_gameplay_wizard_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_wizard_misses_bomb_01",
		name = "pdr_gameplay_wizard_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pwb_gameplay_response_18",
		name = "pwb_gameplay_response_18",
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
				"pdr_gameplay_wizard_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_wizard_misses_bomb_01",
		name = "pwe_gameplay_wizard_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_response_19",
		name = "pbw_gameplay_response_19",
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
				"pwe_gameplay_wizard_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_wizard_misses_bomb_01",
		name = "pes_gameplay_wizard_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_response_20",
		name = "pbw_gameplay_response_20",
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
				"pes_gameplay_wizard_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_solider_misses_bomb_01",
		name = "pwh_gameplay_solider_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_response_16",
		name = "pes_gameplay_response_16",
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
				"pwh_gameplay_solider_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_soldier_misses_bomb_01",
		name = "pdr_gameplay_soldier_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_response_13",
		name = "pes_gameplay_response_13",
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
				"pdr_gameplay_soldier_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_18",
		name = "pdr_gameplay_response_18",
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
				"pes_gameplay_response_13"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_soldier_misses_bomb_01",
		name = "pwe_gameplay_soldier_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_response_14",
		name = "pes_gameplay_response_14",
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
				"pwe_gameplay_soldier_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_soldier_misses_bomb_01",
		name = "pbw_gameplay_soldier_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_response_15",
		name = "pes_gameplay_response_15",
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
				"pbw_gameplay_soldier_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_ranger_misses_bomb_01",
		name = "pwh_gameplay_ranger_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_19",
		name = "pdr_gameplay_response_19",
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
				"pwh_gameplay_ranger_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_ranger_misses_bomb_01",
		name = "pes_gameplay_ranger_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_22",
		name = "pdr_gameplay_response_22",
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
				"pes_gameplay_ranger_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pes_gameplay_response_17",
		name = "pes_gameplay_response_17",
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
				"pdr_gameplay_response_22"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_23",
		name = "pdr_gameplay_response_23",
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
				"pes_gameplay_response_17"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pwe_gameplay_ranger_misses_bomb_01",
		name = "pwe_gameplay_ranger_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_20",
		name = "pdr_gameplay_response_20",
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
				"pwe_gameplay_ranger_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_ranger_misses_bomb_01",
		name = "pbw_gameplay_ranger_misses_bomb_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grenade_exp"
			},
			{
				"query_context",
				"grenade_owner",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"hit",
				OP.EQ,
				0
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_response_21",
		name = "pdr_gameplay_response_21",
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
				"pbw_gameplay_ranger_misses_bomb_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		name = "pwh_act1_imprisonment_story_one_01",
		response = "pwh_act1_imprisonment_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act1_imprisonment_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act1_imprisonment_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_imprisonment_story_one_01",
		response = "pbw_act1_imprisonment_story_one_01",
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
				"pwh_act1_imprisonment_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_act1_imprisonment_story_one_02",
		response = "pwh_act1_imprisonment_story_one_02",
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
				"pbw_act1_imprisonment_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_act1_imprisonment_story_two_01",
		response = "pbw_act1_imprisonment_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_imprisonment_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_imprisonment_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act1_imprisonment_story_two_01",
		response = "pwh_act1_imprisonment_story_two_01",
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
				"pbw_act1_imprisonment_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_act1_imprisonment_story_two_02",
		response = "pbw_act1_imprisonment_story_two_02",
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
				"pwh_act1_imprisonment_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_act2_imprisonment_story_one_01",
		response = "pbw_act2_imprisonment_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_imprisonment_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_imprisonment_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_imprisonment_story_one_01",
		response = "pwh_act2_imprisonment_story_one_01",
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
				"pbw_act2_imprisonment_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_act2_imprisonment_story_one_02",
		response = "pbw_act2_imprisonment_story_one_02",
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
				"pwh_act2_imprisonment_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act1_quest_story_one_01",
		response = "pdr_act1_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act1_quest_story_one_01",
		response = "pwh_act1_quest_story_one_01",
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
				"pdr_act1_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act1_quest_story_one_02",
		response = "pdr_act1_quest_story_one_02",
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
				"pwh_act1_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_act1_quest_story_two_01",
		response = "pbw_act1_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act1_quest_story_two_01",
		response = "pdr_act1_quest_story_two_01",
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
				"pbw_act1_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_act1_quest_story_two_02",
		response = "pbw_act1_quest_story_two_02",
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
				"pdr_act1_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_act1_quest_story_three_01",
		response = "pdr_act1_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_quest_story_three_01",
		response = "pes_act1_quest_story_three_01",
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
				"pdr_act1_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act1_quest_story_three_02",
		response = "pdr_act1_quest_story_three_02",
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
				"pes_act1_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_act1_quest_story_four_01",
		response = "pbw_act1_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act1_quest_story_four_01",
		response = "pwe_act1_quest_story_four_01",
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
				"pbw_act1_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act1_quest_story_four_02",
		response = "pbw_act1_quest_story_four_02",
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
				"pwe_act1_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act1_quest_story_four_02",
		response = "pwe_act1_quest_story_four_02",
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
				"pbw_act1_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act2_dwarf_quest_story_one_01",
		response = "pbw_act2_dwarf_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_dwarf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_dwarf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act2_dwarf_quest_story_one_01",
		response = "pdr_act2_dwarf_quest_story_one_01",
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
				"pbw_act2_dwarf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_act2_dwarf_quest_story_one_02",
		response = "pbw_act2_dwarf_quest_story_one_02",
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
				"pdr_act2_dwarf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_act2_dwarf_quest_story_one_02",
		response = "pdr_act2_dwarf_quest_story_one_02",
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
				"pbw_act2_dwarf_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pdr_act2_dwarf_quest_story_two_01",
		response = "pdr_act2_dwarf_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_dwarf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_dwarf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_dwarf_quest_story_two_01",
		response = "pwh_act2_dwarf_quest_story_two_01",
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
				"pdr_act2_dwarf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act2_dwarf_quest_story_two_02",
		response = "pdr_act2_dwarf_quest_story_two_02",
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
				"pwh_act2_dwarf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act2_dwarf_quest_story_two_02",
		response = "pwh_act2_dwarf_quest_story_two_02",
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
				"pdr_act2_dwarf_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_act2_dwarf_quest_story_three_01",
		response = "pes_act2_dwarf_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_dwarf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_dwarf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act2_dwarf_quest_story_three_01",
		response = "pdr_act2_dwarf_quest_story_three_01",
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
				"pes_act2_dwarf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_act2_dwarf_quest_story_three_02",
		response = "pes_act2_dwarf_quest_story_three_02",
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
				"pdr_act2_dwarf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act2_dwarf_quest_story_three_02",
		response = "pdr_act2_dwarf_quest_story_three_02",
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
				"pes_act2_dwarf_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_act2_dwarf_quest_story_four_01",
		response = "pwe_act2_dwarf_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_dwarf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_dwarf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act2_dwarf_quest_story_four_01",
		response = "pdr_act2_dwarf_quest_story_four_01",
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
				"pwe_act2_dwarf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_act2_dwarf_quest_story_four_02",
		response = "pwe_act2_dwarf_quest_story_four_02",
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
				"pdr_act2_dwarf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_act3_dwarf_quest_story_one_01",
		response = "pes_act3_dwarf_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act3_dwarf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act3_dwarf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_dwarf_quest_story_one_01",
		response = "pdr_act3_dwarf_quest_story_one_01",
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
				"pes_act3_dwarf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_act3_dwarf_quest_story_one_02",
		response = "pes_act3_dwarf_quest_story_one_02",
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
				"pdr_act3_dwarf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act3_dwarf_quest_story_two_01",
		response = "pbw_act3_dwarf_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_dwarf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_dwarf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_dwarf_quest_story_two_01",
		response = "pdr_act3_dwarf_quest_story_two_01",
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
				"pbw_act3_dwarf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_act3_dwarf_quest_story_two_02",
		response = "pbw_act3_dwarf_quest_story_two_02",
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
				"pdr_act3_dwarf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_act3_dwarf_quest_story_two_02",
		response = "pdr_act3_dwarf_quest_story_two_02",
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
				"pbw_act3_dwarf_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_act3_dwarf_quest_story_three_01",
		response = "pwe_act3_dwarf_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_dwarf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_dwarf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_dwarf_quest_story_three_01",
		response = "pdr_act3_dwarf_quest_story_three_01",
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
				"pwe_act3_dwarf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_act3_dwarf_quest_story_three_02",
		response = "pwe_act3_dwarf_quest_story_three_02",
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
				"pdr_act3_dwarf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act3_dwarf_quest_story_three_02",
		response = "pdr_act3_dwarf_quest_story_three_02",
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
				"pwe_act3_dwarf_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_act3_dwarf_quest_story_three_03",
		response = "pwe_act3_dwarf_quest_story_three_03",
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
				"pdr_act3_dwarf_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_act3_dwarf_quest_story_four_01",
		response = "pwh_act3_dwarf_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_dwarf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_dwarf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_dwarf_quest_story_four_01",
		response = "pdr_act3_dwarf_quest_story_four_01",
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
				"pwh_act3_dwarf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act3_dwarf_quest_story_four_02",
		response = "pwh_act3_dwarf_quest_story_four_02",
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
				"pdr_act3_dwarf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_act1_elf_quest_story_one_01",
		response = "pwh_act1_elf_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act1_elf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act1_elf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act1_elf_quest_story_one_01",
		response = "pwe_act1_elf_quest_story_one_01",
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
				"pwh_act1_elf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_act1_elf_quest_story_one_02",
		response = "pwh_act1_elf_quest_story_one_02",
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
				"pwe_act1_elf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_act1_elf_quest_story_one_02",
		response = "pwe_act1_elf_quest_story_one_02",
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
				"pwh_act1_elf_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act1_elf_quest_story_two_01",
		response = "pbw_act1_elf_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_elf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_elf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act1_elf_quest_story_two_01",
		response = "pwe_act1_elf_quest_story_two_01",
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
				"pbw_act1_elf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act1_elf_quest_story_two_02",
		response = "pbw_act1_elf_quest_story_two_02",
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
				"pwe_act1_elf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act1_elf_quest_story_two_02",
		response = "pwe_act1_elf_quest_story_two_02",
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
				"pbw_act1_elf_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act1_elf_quest_story_three_01",
		response = "pdr_act1_elf_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_elf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_elf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act1_elf_quest_story_three_01",
		response = "pwe_act1_elf_quest_story_three_01",
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
				"pdr_act1_elf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_act1_elf_quest_story_four_01",
		response = "pes_act1_elf_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act1_elf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act1_elf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act1_elf_quest_story_four_01",
		response = "pwe_act1_elf_quest_story_four_01",
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
				"pes_act1_elf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_act1_elf_quest_story_four_02",
		response = "pes_act1_elf_quest_story_four_02",
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
				"pwe_act1_elf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_act1_elf_quest_story_four_02",
		response = "pwe_act1_elf_quest_story_four_02",
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
				"pes_act1_elf_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_act2_elf_quest_story_one_01",
		response = "pwh_act2_elf_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act2_elf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act2_elf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act2_elf_quest_story_one_01",
		response = "pwe_act2_elf_quest_story_one_01",
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
				"pwh_act2_elf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_act2_elf_quest_story_one_02",
		response = "pwh_act2_elf_quest_story_one_02",
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
				"pwe_act2_elf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_act2_elf_quest_story_one_02",
		response = "pwe_act2_elf_quest_story_one_02",
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
				"pwh_act2_elf_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act2_elf_quest_story_two_01",
		response = "pbw_act2_elf_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_elf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_elf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act2_elf_quest_story_two_01",
		response = "pwe_act2_elf_quest_story_two_01",
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
				"pbw_act2_elf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act2_elf_quest_story_two_02",
		response = "pbw_act2_elf_quest_story_two_02",
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
				"pwe_act2_elf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act2_elf_quest_story_two_02",
		response = "pwe_act2_elf_quest_story_two_02",
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
				"pbw_act2_elf_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act2_elf_quest_story_three_01",
		response = "pdr_act2_elf_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_elf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_elf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act2_elf_quest_story_three_01",
		response = "pwe_act2_elf_quest_story_three_01",
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
				"pdr_act2_elf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act2_elf_quest_story_three_02",
		response = "pdr_act2_elf_quest_story_three_02",
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
				"pwe_act2_elf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_act2_elf_quest_story_three_02",
		response = "pwe_act2_elf_quest_story_three_02",
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
				"pdr_act2_elf_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_act2_elf_quest_story_four_01",
		response = "pes_act2_elf_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				0
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_elf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_elf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_elf_quest_story_four_01",
		response = "pbw_act2_elf_quest_story_four_01",
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
				"pes_act2_elf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act2_elf_quest_story_four_02",
		response = "pes_act2_elf_quest_story_four_02",
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
				"pbw_act2_elf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act2_elf_quest_story_four_02",
		response = "pbw_act2_elf_quest_story_four_02",
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
				"pes_act2_elf_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act2_elf_quest_story_four_03",
		response = "pes_act2_elf_quest_story_four_03",
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
				"pbw_act2_elf_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_act3_elf_quest_story_one_01",
		response = "pwh_act3_elf_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_elf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_elf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_elf_quest_story_one_01",
		response = "pwe_act3_elf_quest_story_one_01",
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
				"pwh_act3_elf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_act3_elf_quest_story_one_02",
		response = "pwh_act3_elf_quest_story_one_02",
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
				"pwe_act3_elf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_act3_elf_quest_story_two_01",
		response = "pwe_act3_elf_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_elf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_elf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_elf_quest_story_two_01",
		response = "pbw_act3_elf_quest_story_two_01",
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
				"pwe_act3_elf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act3_elf_quest_story_two_02",
		response = "pwe_act3_elf_quest_story_two_02",
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
				"pbw_act3_elf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act3_elf_quest_story_two_02",
		response = "pbw_act3_elf_quest_story_two_02",
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
				"pwe_act3_elf_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act3_elf_quest_story_two_03",
		response = "pwe_act3_elf_quest_story_two_03",
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
				"pbw_act3_elf_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwe_act3_elf_quest_story_three_01",
		response = "pwe_act3_elf_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_elf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_elf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_elf_quest_story_three_01",
		response = "pbw_act3_elf_quest_story_three_01",
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
				"pwe_act3_elf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act3_elf_quest_story_three_02",
		response = "pwe_act3_elf_quest_story_three_02",
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
				"pbw_act3_elf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act3_elf_quest_story_four_01",
		response = "pdr_act3_elf_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_elf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_elf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_elf_quest_story_four_01",
		response = "pwe_act3_elf_quest_story_four_01",
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
				"pdr_act3_elf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act3_elf_quest_story_five_01",
		response = "pdr_act3_elf_quest_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_elf_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_elf_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_elf_quest_story_five_01",
		response = "pwe_act3_elf_quest_story_five_01",
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
				"pdr_act3_elf_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act3_elf_quest_story_five_02",
		response = "pdr_act3_elf_quest_story_five_02",
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
				"pwe_act3_elf_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_act3_elf_quest_story_five_02",
		response = "pwe_act3_elf_quest_story_five_02",
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
				"pdr_act3_elf_quest_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act1_soldier_quest_story_one_01",
		response = "pdr_act1_soldier_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"magnus"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_soldier_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_soldier_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_soldier_quest_story_one_01",
		response = "pes_act1_soldier_quest_story_one_01",
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
				"pdr_act1_soldier_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act1_soldier_quest_story_one_02",
		response = "pdr_act1_soldier_quest_story_one_02",
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
				"pes_act1_soldier_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_act1_soldier_quest_story_one_02",
		response = "pes_act1_soldier_quest_story_one_02",
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
				"pdr_act1_soldier_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act1_soldier_quest_story_one_03",
		response = "pdr_act1_soldier_quest_story_one_03",
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
				"pes_act1_soldier_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act1_soldier_quest_story_two_01",
		response = "pwh_act1_soldier_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act1_soldier_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act1_soldier_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_soldier_quest_story_two_01",
		response = "pes_act1_soldier_quest_story_two_01",
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
				"pwh_act1_soldier_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_act1_soldier_quest_story_two_02",
		response = "pwh_act1_soldier_quest_story_two_02",
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
				"pes_act1_soldier_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_act1_soldier_quest_story_two_02",
		response = "pes_act1_soldier_quest_story_two_02",
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
				"pwh_act1_soldier_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act1_soldier_quest_story_three_01",
		response = "pbw_act1_soldier_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_soldier_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_soldier_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_soldier_quest_story_three_01",
		response = "pes_act1_soldier_quest_story_three_01",
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
				"pbw_act1_soldier_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act1_soldier_quest_story_three_02",
		response = "pbw_act1_soldier_quest_story_three_02",
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
				"pes_act1_soldier_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act1_soldier_quest_story_three_02",
		response = "pes_act1_soldier_quest_story_three_02",
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
				"pbw_act1_soldier_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_act1_soldier_quest_story_four_01",
		response = "pwe_act1_soldier_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"magnus"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act1_soldier_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act1_soldier_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_soldier_quest_story_four_01",
		response = "pes_act1_soldier_quest_story_four_01",
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
				"pwe_act1_soldier_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_act1_soldier_quest_story_four_02",
		response = "pwe_act1_soldier_quest_story_four_02",
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
				"pes_act1_soldier_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_act1_soldier_quest_story_four_02",
		response = "pes_act1_soldier_quest_story_four_02",
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
				"pwe_act1_soldier_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act1_soldier_quest_story_five_01",
		response = "pdr_act1_soldier_quest_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_soldier_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_soldier_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_soldier_quest_story_five_01",
		response = "pes_act1_soldier_quest_story_five_01",
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
				"pdr_act1_soldier_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act1_soldier_quest_story_five_02",
		response = "pdr_act1_soldier_quest_story_five_02",
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
				"pes_act1_soldier_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_act1_soldier_quest_story_five_02",
		response = "pes_act1_soldier_quest_story_five_02",
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
				"pdr_act1_soldier_quest_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act2_soldier_quest_story_one_01",
		response = "pdr_act2_soldier_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_soldier_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_soldier_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_soldier_quest_story_one_01",
		response = "pes_act2_soldier_quest_story_one_01",
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
				"pdr_act2_soldier_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act2_soldier_quest_story_one_02",
		response = "pdr_act2_soldier_quest_story_one_02",
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
				"pes_act2_soldier_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act2_soldier_quest_story_two_01",
		response = "pwh_act2_soldier_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act2_soldier_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act2_soldier_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_soldier_quest_story_two_01",
		response = "pes_act2_soldier_quest_story_two_01",
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
				"pwh_act2_soldier_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_act2_soldier_quest_story_two_02",
		response = "pwh_act2_soldier_quest_story_two_02",
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
				"pes_act2_soldier_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_act2_soldier_quest_story_two_02",
		response = "pes_act2_soldier_quest_story_two_02",
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
				"pwh_act2_soldier_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act2_soldier_quest_story_three_01",
		response = "pbw_act2_soldier_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_soldier_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_soldier_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_soldier_quest_story_three_01",
		response = "pes_act2_soldier_quest_story_three_01",
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
				"pbw_act2_soldier_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act2_soldier_quest_story_three_02",
		response = "pbw_act2_soldier_quest_story_three_02",
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
				"pes_act2_soldier_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act2_soldier_quest_story_three_02",
		response = "pes_act2_soldier_quest_story_three_02",
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
				"pbw_act2_soldier_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_act2_soldier_quest_story_four_01",
		response = "pwe_act2_soldier_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_soldier_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_soldier_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_soldier_quest_story_four_01",
		response = "pes_act2_soldier_quest_story_four_01",
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
				"pwe_act2_soldier_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_act2_soldier_quest_story_four_02",
		response = "pwe_act2_soldier_quest_story_four_02",
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
				"pes_act2_soldier_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_act2_soldier_quest_story_four_02",
		response = "pes_act2_soldier_quest_story_four_02",
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
				"pwe_act2_soldier_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act3_soldier_quest_story_one_01",
		response = "pdr_act3_soldier_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_soldier_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_soldier_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_soldier_quest_story_one_01",
		response = "pes_act3_soldier_quest_story_one_01",
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
				"pdr_act3_soldier_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act3_soldier_quest_story_one_02",
		response = "pdr_act3_soldier_quest_story_one_02",
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
				"pes_act3_soldier_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_act3_soldier_quest_story_one_02",
		response = "pes_act3_soldier_quest_story_one_02",
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
				"pdr_act3_soldier_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_act3_soldier_quest_story_two_01",
		response = "pwh_act3_soldier_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_soldier_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_soldier_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_soldier_quest_story_two_01",
		response = "pes_act3_soldier_quest_story_two_01",
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
				"pwh_act3_soldier_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_act3_soldier_quest_story_two_02",
		response = "pwh_act3_soldier_quest_story_two_02",
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
				"pes_act3_soldier_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_act3_soldier_quest_story_two_02",
		response = "pes_act3_soldier_quest_story_two_02",
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
				"pwh_act3_soldier_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act3_soldier_quest_story_three_01",
		response = "pbw_act3_soldier_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_soldier_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_soldier_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_soldier_quest_story_three_01",
		response = "pes_act3_soldier_quest_story_three_01",
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
				"pbw_act3_soldier_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act3_soldier_quest_story_three_02",
		response = "pbw_act3_soldier_quest_story_three_02",
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
				"pes_act3_soldier_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act3_soldier_quest_story_three_02",
		response = "pes_act3_soldier_quest_story_three_02",
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
				"pbw_act3_soldier_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwe_act3_soldier_quest_story_four_01",
		response = "pwe_act3_soldier_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_soldier_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_soldier_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_soldier_quest_story_four_01",
		response = "pes_act3_soldier_quest_story_four_01",
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
				"pwe_act3_soldier_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act1_wizard_quest_story_one_01",
		response = "pdr_act1_wizard_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_wizard_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_wizard_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_wizard_quest_story_one_01",
		response = "pbw_act1_wizard_quest_story_one_01",
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
				"pdr_act1_wizard_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_act1_wizard_quest_story_one_02",
		response = "pdr_act1_wizard_quest_story_one_02",
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
				"pbw_act1_wizard_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_act1_wizard_quest_story_one_02",
		response = "pbw_act1_wizard_quest_story_one_02",
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
				"pdr_act1_wizard_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_act1_wizard_quest_story_one_03",
		response = "pdr_act1_wizard_quest_story_one_03",
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
				"pbw_act1_wizard_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwe_act1_wizard_quest_story_two_01",
		response = "pwe_act1_wizard_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act1_wizard_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act1_wizard_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_wizard_quest_story_two_01",
		response = "pbw_act1_wizard_quest_story_two_01",
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
				"pwe_act1_wizard_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act1_wizard_quest_story_two_02",
		response = "pwe_act1_wizard_quest_story_two_02",
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
				"pbw_act1_wizard_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act1_wizard_quest_story_two_02",
		response = "pbw_act1_wizard_quest_story_two_02",
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
				"pwe_act1_wizard_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_act1_wizard_quest_story_three_01",
		response = "pwh_act1_wizard_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act1_wizard_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act1_wizard_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_wizard_quest_story_three_01",
		response = "pbw_act1_wizard_quest_story_three_01",
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
				"pwh_act1_wizard_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act1_wizard_quest_story_four_01",
		response = "pes_act1_wizard_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act1_wizard_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act1_wizard_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_wizard_quest_story_four_01",
		response = "pbw_act1_wizard_quest_story_four_01",
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
				"pes_act1_wizard_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act1_wizard_quest_story_four_02",
		response = "pes_act1_wizard_quest_story_four_02",
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
				"pbw_act1_wizard_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act1_wizard_quest_story_four_02",
		response = "pbw_act1_wizard_quest_story_four_02",
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
				"pes_act1_wizard_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act2_wizard_quest_story_one_01",
		response = "pes_act2_wizard_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_wizard_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_wizard_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_wizard_quest_story_one_01",
		response = "pbw_act2_wizard_quest_story_one_01",
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
				"pes_act2_wizard_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act2_wizard_quest_story_one_02",
		response = "pes_act2_wizard_quest_story_one_02",
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
				"pbw_act2_wizard_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act2_wizard_quest_story_two_01",
		response = "pbw_act2_wizard_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_wizard_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_wizard_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_wizard_quest_story_two_01",
		response = "pwh_act2_wizard_quest_story_two_01",
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
				"pbw_act2_wizard_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_act2_wizard_quest_story_two_02",
		response = "pbw_act2_wizard_quest_story_two_02",
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
				"pwh_act2_wizard_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act2_wizard_quest_story_three_01",
		response = "pwe_act2_wizard_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_wizard_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_wizard_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_wizard_quest_story_three_01",
		response = "pbw_act2_wizard_quest_story_three_01",
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
				"pwe_act2_wizard_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act2_wizard_quest_story_three_02",
		response = "pwe_act2_wizard_quest_story_three_02",
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
				"pbw_act2_wizard_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pdr_act2_wizard_quest_story_four_01",
		response = "pdr_act2_wizard_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_wizard_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_wizard_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_wizard_quest_story_four_01",
		response = "pbw_act2_wizard_quest_story_four_01",
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
				"pdr_act2_wizard_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act3_wizard_quest_story_one_01",
		response = "pwe_act3_wizard_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_wizard_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_wizard_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_wizard_quest_story_one_01",
		response = "pbw_act3_wizard_quest_story_one_01",
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
				"pwe_act3_wizard_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act3_wizard_quest_story_one_02",
		response = "pwe_act3_wizard_quest_story_one_02",
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
				"pbw_act3_wizard_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pbw_act3_wizard_quest_story_one_02",
		response = "pbw_act3_wizard_quest_story_one_02",
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
				"pwe_act3_wizard_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_act3_wizard_quest_story_two_01",
		response = "pbw_act3_wizard_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_wizard_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_wizard_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_wizard_quest_story_two_01",
		response = "pes_act3_wizard_quest_story_two_01",
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
				"pbw_act3_wizard_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act3_wizard_quest_story_two_02",
		response = "pbw_act3_wizard_quest_story_two_02",
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
				"pes_act3_wizard_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act3_wizard_quest_story_two_02",
		response = "pes_act3_wizard_quest_story_two_02",
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
				"pbw_act3_wizard_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_act3_wizard_quest_story_three_01",
		response = "pwh_act3_wizard_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_wizard_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_wizard_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_wizard_quest_story_three_01",
		response = "pbw_act3_wizard_quest_story_three_01",
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
				"pwh_act3_wizard_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_act3_wizard_quest_story_three_02",
		response = "pwh_act3_wizard_quest_story_three_02",
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
				"pbw_act3_wizard_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act3_wizard_quest_story_four_01",
		response = "pdr_act3_wizard_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_wizard_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_wizard_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_wizard_quest_story_four_01",
		response = "pbw_act3_wizard_quest_story_four_01",
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
				"pdr_act3_wizard_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_act3_wizard_quest_story_four_02",
		response = "pdr_act3_wizard_quest_story_four_02",
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
				"pbw_act3_wizard_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pbw_act1_hunter_quest_story_one_01",
		response = "pbw_act1_hunter_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_hunter_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_hunter_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_hunter_quest_story_one_01",
		response = "pes_act1_hunter_quest_story_one_01",
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
				"pbw_act1_hunter_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act1_hunter_quest_story_one_02",
		response = "pbw_act1_hunter_quest_story_one_02",
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
				"pes_act1_hunter_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act1_hunter_quest_story_one_02",
		response = "pes_act1_hunter_quest_story_one_02",
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
				"pbw_act1_hunter_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pdr_act1_hunter_quest_story_two_01",
		response = "pdr_act1_hunter_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_hunter_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_hunter_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act1_hunter_quest_story_two_01",
		response = "pwh_act1_hunter_quest_story_two_01",
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
				"pdr_act1_hunter_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act1_hunter_quest_story_two_02",
		response = "pdr_act1_hunter_quest_story_two_02",
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
				"pwh_act1_hunter_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act1_hunter_quest_story_two_02",
		response = "pwh_act1_hunter_quest_story_two_02",
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
				"pdr_act1_hunter_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_act1_hunter_quest_story_three_01",
		response = "pes_act1_hunter_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act1_hunter_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act1_hunter_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_hunter_quest_story_three_01",
		response = "pbw_act1_hunter_quest_story_three_01",
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
				"pes_act1_hunter_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act1_hunter_quest_story_three_02",
		response = "pes_act1_hunter_quest_story_three_02",
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
				"pbw_act1_hunter_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act1_hunter_quest_story_three_02",
		response = "pbw_act1_hunter_quest_story_three_02",
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
				"pes_act1_hunter_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act2_hunter_quest_story_one_01",
		response = "pwe_act2_hunter_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_hunter_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_hunter_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_hunter_quest_story_one_01",
		response = "pbw_act2_hunter_quest_story_one_01",
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
				"pwe_act2_hunter_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwe_act2_hunter_quest_story_one_02",
		response = "pwe_act2_hunter_quest_story_one_02",
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
				"pbw_act2_hunter_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pes_act2_hunter_quest_story_two_01",
		response = "pes_act2_hunter_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_hunter_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_hunter_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_hunter_quest_story_two_01",
		response = "pwh_act2_hunter_quest_story_two_01",
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
				"pes_act2_hunter_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act2_hunter_quest_story_three_01",
		response = "pdr_act2_hunter_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_hunter_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_hunter_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_hunter_quest_story_three_01",
		response = "pwh_act2_hunter_quest_story_three_01",
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
				"pdr_act2_hunter_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act2_hunter_quest_story_three_02",
		response = "pdr_act2_hunter_quest_story_three_02",
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
				"pwh_act2_hunter_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act2_hunter_quest_story_three_02",
		response = "pwh_act2_hunter_quest_story_three_02",
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
				"pdr_act2_hunter_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_act2_hunter_quest_story_four_01",
		response = "pes_act2_hunter_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_hunter_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_hunter_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_hunter_quest_story_four_01",
		response = "pwh_act2_hunter_quest_story_four_01",
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
				"pes_act2_hunter_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_act2_hunter_quest_story_four_02",
		response = "pes_act2_hunter_quest_story_four_02",
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
				"pwh_act2_hunter_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_act2_hunter_quest_story_four_02",
		response = "pwh_act2_hunter_quest_story_four_02",
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
				"pes_act2_hunter_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act3_hunter_quest_story_one_01",
		response = "pdr_act3_hunter_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_hunter_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_hunter_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_hunter_quest_story_one_01",
		response = "pwh_act3_hunter_quest_story_one_01",
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
				"pdr_act3_hunter_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act3_hunter_quest_story_one_02",
		response = "pdr_act3_hunter_quest_story_one_02",
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
				"pwh_act3_hunter_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act3_hunter_quest_story_one_03",
		response = "pwh_act3_hunter_quest_story_one_03",
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
				"pdr_act3_hunter_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act3_hunter_quest_story_one_04",
		response = "pdr_act3_hunter_quest_story_one_04",
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
				"pwh_act3_hunter_quest_story_one_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_act3_hunter_quest_story_two_01",
		response = "pes_act3_hunter_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act3_hunter_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act3_hunter_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_hunter_quest_story_two_01",
		response = "pwh_act3_hunter_quest_story_two_01",
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
				"pes_act3_hunter_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_act3_hunter_quest_story_two_02",
		response = "pes_act3_hunter_quest_story_two_02",
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
				"pwh_act3_hunter_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_act3_hunter_quest_story_two_02",
		response = "pwh_act3_hunter_quest_story_two_02",
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
				"pes_act3_hunter_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_act3_hunter_quest_story_three_01",
		response = "pwh_act3_hunter_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_hunter_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_hunter_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_hunter_quest_story_three_01",
		response = "pwe_act3_hunter_quest_story_three_01",
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
				"pwh_act3_hunter_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_act3_hunter_quest_story_three_02",
		response = "pwh_act3_hunter_quest_story_three_02",
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
				"pwe_act3_hunter_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_act3_hunter_quest_story_four_01",
		response = "pbw_act3_hunter_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_hunter_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_hunter_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_hunter_quest_story_four_01",
		response = "pwh_act3_hunter_quest_story_four_01",
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
				"pbw_act3_hunter_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_act3_hunter_quest_story_four_02",
		response = "pbw_act3_hunter_quest_story_four_02",
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
				"pwh_act3_hunter_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act3_hunter_quest_story_five_01",
		response = "pes_act3_hunter_quest_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act3_hunter_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act3_hunter_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_hunter_quest_story_five_01",
		response = "pbw_act3_hunter_quest_story_five_01",
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
				"pes_act3_hunter_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_act3_hunter_quest_story_five_02",
		response = "pdr_act3_hunter_quest_story_five_02",
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
				"pbw_act3_hunter_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act3_hunter_quest_story_five_02",
		response = "pbw_act3_hunter_quest_story_five_02",
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
				"pdr_act3_hunter_quest_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_act2_imprisonment_story_two_01",
		response = "pwh_act2_imprisonment_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act2_imprisonment_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act2_imprisonment_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_imprisonment_story_two_01",
		response = "pbw_act2_imprisonment_story_two_01",
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
				"pwh_act2_imprisonment_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_act2_imprisonment_story_two_02",
		response = "pwh_act2_imprisonment_story_two_02",
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
				"pbw_act2_imprisonment_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_act3_dwarf_quest_story_five_01",
		response = "pwh_act3_dwarf_quest_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_dwarf_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_dwarf_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_dwarf_quest_story_five_02",
		response = "pdr_act3_dwarf_quest_story_five_02",
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
				"pwh_act3_dwarf_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act3_dwarf_quest_story_five_03",
		response = "pwh_act3_dwarf_quest_story_five_03",
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
				"pdr_act3_dwarf_quest_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pdr_act3_dwarf_quest_story_five_04",
		response = "pdr_act3_dwarf_quest_story_five_04",
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
				"pwh_act3_dwarf_quest_story_five_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pwh_act3_dwarf_quest_story_five_05",
		response = "pwh_act3_dwarf_quest_story_five_05",
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
				"pdr_act3_dwarf_quest_story_five_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_act3_dwarf_quest_story_six_01",
		response = "pbw_act3_dwarf_quest_story_six_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_dwarf_quest_story_six_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_dwarf_quest_story_six_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_dwarf_quest_story_six_02",
		response = "pdr_act3_dwarf_quest_story_six_02",
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
				"pbw_act3_dwarf_quest_story_six_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
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
		name = "pes_act3_wizard_quest_story_five_01",
		response = "pes_act3_wizard_quest_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_act3_wizard_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act3_wizard_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_wizard_quest_story_five_02",
		response = "pbw_act3_wizard_quest_story_five_02",
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
				"pes_act3_wizard_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_act3_wizard_quest_story_five_03",
		response = "pes_act3_wizard_quest_story_five_03",
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
				"pbw_act3_wizard_quest_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_act3_wizard_quest_story_five_04",
		response = "pbw_act3_wizard_quest_story_five_04",
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
				"pes_act3_wizard_quest_story_five_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pwh_act3_wizard_quest_story_five_05",
		response = "pwh_act3_wizard_quest_story_five_05",
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
				"pbw_act3_wizard_quest_story_five_04"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_act2_hunter_quest_story_five_01",
		response = "pwe_act2_hunter_quest_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_hunter_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_hunter_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_hunter_quest_story_five_02",
		response = "pwh_act2_hunter_quest_story_five_02",
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
				"pwe_act2_hunter_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwe_act2_hunter_quest_story_six_01",
		response = "pwe_act2_hunter_quest_story_six_01",
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
				"pwh_act2_hunter_quest_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
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
		name = "pwh_act2_hunter_quest_story_six_02",
		response = "pwh_act2_hunter_quest_story_six_02",
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
				"pwe_act2_hunter_quest_story_six_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_docks_story_one_01",
		response = "pwh_docks_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"docks_short_level"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pes_docks_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_docks_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_docks_story_one_02",
		response = "pes_docks_story_one_02",
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
				"pwh_docks_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pbw_docks_story_three_01",
		response = "pbw_docks_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"docks_short_level"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_docks_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_docks_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_docks_story_three_02",
		response = "pwh_docks_story_three_02",
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
				"pbw_docks_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_docks_story_two_01",
		response = "pes_docks_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"docks_short_level"
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_pbw_docks_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_docks_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_docks_story_two_02",
		response = "pbw_docks_story_two_02",
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
				"pes_docks_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pes_docks_story_two_03",
		response = "pes_docks_story_two_03",
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
				"pbw_docks_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_dialogue_01",
		response = "pwh_dialogue_01",
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
				"sewers_intro"
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_sewers_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_sewers_intro",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_response_01",
		response = "pes_dialogue_response_01",
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
				"pwh_dialogue_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_dialogue_response_01",
		response = "pwh_dialogue_response_01",
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
				"pes_dialogue_response_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pes_dialogue_response_02",
		response = "pes_dialogue_response_02",
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
				"pwh_dialogue_response_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
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
		name = "pwh_dialogue_response_02",
		response = "pwh_dialogue_response_02",
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
				"pes_dialogue_response_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pbw_dialogue_response_01",
		response = "pbw_dialogue_response_01",
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
				"pwh_dialogue_response_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_dialogue_01_forced",
		response = "pbw_dialogue_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_01_forced",
		response = "pwe_dialogue_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"faction_memory",
				"once_per_level_pwe_dialogue_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_02_forced",
		response = "pwe_dialogue_02_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"faction_memory",
				"once_per_level_pwe_dialogue_02",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_02",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_01_forced",
		response = "pdr_dialogue_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_02_forced",
		response = "pdr_dialogue_02_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_02",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_02",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_03_forced",
		response = "pwe_dialogue_03_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				0
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_03",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_03",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_04_forced",
		response = "pwe_dialogue_04_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_04",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_04",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_05_forced",
		response = "pwe_dialogue_05_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_05",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_05",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_06_forced",
		response = "pwe_dialogue_06_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_05_forced",
		response = "pwh_dialogue_05_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_05",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_05",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_06_forced",
		response = "pbw_dialogue_06_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_03_forced",
		response = "pdr_dialogue_03_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_03",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_03",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_06_forced",
		response = "pwh_dialogue_06_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_07_forced",
		response = "pwe_dialogue_07_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_08_forced",
		response = "pwe_dialogue_08_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_08",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_08",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_02_forced",
		response = "pes_dialogue_02_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_02",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_02",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_04_forced",
		response = "pdr_dialogue_04_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_04",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_04",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_07_forced",
		response = "pbw_dialogue_07_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_03_forced",
		response = "pes_dialogue_03_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_03",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_03",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_04_forced",
		response = "pes_dialogue_04_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_04",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_04",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_06_forced",
		response = "pes_dialogue_06_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_05_forced",
		response = "pes_dialogue_05_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_05",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_05",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_09_forced",
		response = "pes_dialogue_09_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_10_forced",
		response = "pes_dialogue_10_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_09_forced",
		response = "pwe_dialogue_09_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_07_forced",
		response = "pwh_dialogue_07_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_09_1_forced",
		response = "pwe_dialogue_09_1_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_09_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_09_1",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_10_forced",
		response = "pwe_dialogue_10_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_08_forced",
		response = "pbw_dialogue_08_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_08",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_08",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_07_forced",
		response = "pes_dialogue_07_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_05_forced",
		response = "pdr_dialogue_05_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_05",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_05",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_11_forced",
		response = "pwe_dialogue_11_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_11",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_11",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_12_forced",
		response = "pwe_dialogue_12_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_09_forced",
		response = "pbw_dialogue_09_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_10_forced",
		response = "pbw_dialogue_10_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_06_forced",
		response = "pdr_dialogue_06_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_06",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_06",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_11_forced",
		response = "pbw_dialogue_11_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_11",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_11",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_07_forced",
		response = "pdr_dialogue_07_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_07",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_07",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_08_forced",
		response = "pdr_dialogue_08_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_08",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_08",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_09_forced",
		response = "pdr_dialogue_09_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_10_forced",
		response = "pdr_dialogue_10_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_11_forced",
		response = "pdr_dialogue_11_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_11",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_11",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_12_forced",
		response = "pdr_dialogue_12_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_08_forced",
		response = "pwh_dialogue_08_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_08",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_08",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_09_forced",
		response = "pwh_dialogue_09_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_09",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_09",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_10_forced",
		response = "pwh_dialogue_10_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_10",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_10",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_11_forced",
		response = "pwh_dialogue_11_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_11",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_11",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_12_forced",
		response = "pwh_dialogue_12_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_13_forced",
		response = "pwh_dialogue_13_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_13",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_13",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dialogue_14_forced",
		response = "pwh_dialogue_14_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_14",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_dialogue_14",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_08_forced",
		response = "pes_dialogue_08_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dialogue_09_1_forced",
		response = "pes_dialogue_09_1_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pes_dialogue_09_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_dialogue_09_1",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dialogue_13_forced",
		response = "pwe_dialogue_13_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_13",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_dialogue_13",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_13_forced",
		response = "pdr_dialogue_13_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_13",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_13",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dialogue_12_forced",
		response = "pbw_dialogue_12_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_12",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_dialogue_12",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dialogue_14_forced",
		response = "pdr_dialogue_14_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_14",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_dialogue_14",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act1_imprisonment_story_one_01_forced",
		response = "pwh_act1_imprisonment_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act1_imprisonment_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act1_imprisonment_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_imprisonment_story_two_01_forced",
		response = "pbw_act1_imprisonment_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_imprisonment_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_imprisonment_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_imprisonment_story_one_01_forced",
		response = "pbw_act2_imprisonment_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_imprisonment_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_imprisonment_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act1_quest_story_one_01_forced",
		response = "pdr_act1_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_quest_story_two_01_forced",
		response = "pbw_act1_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act1_quest_story_three_01_forced",
		response = "pdr_act1_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_quest_story_four_01_forced",
		response = "pbw_act1_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_dwarf_quest_story_one_01_forced",
		response = "pbw_act2_dwarf_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_dwarf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_dwarf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act2_dwarf_quest_story_two_01_forced",
		response = "pdr_act2_dwarf_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_dwarf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_dwarf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_dwarf_quest_story_three_01_forced",
		response = "pes_act2_dwarf_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_dwarf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_dwarf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act2_dwarf_quest_story_four_01_forced",
		response = "pwe_act2_dwarf_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_dwarf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_dwarf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_dwarf_quest_story_one_01_forced",
		response = "pes_act3_dwarf_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pes_act3_dwarf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act3_dwarf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_dwarf_quest_story_two_01_forced",
		response = "pbw_act3_dwarf_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_dwarf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_dwarf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_dwarf_quest_story_three_01_forced",
		response = "pwe_act3_dwarf_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_dwarf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_dwarf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_dwarf_quest_story_four_01_forced",
		response = "pwh_act3_dwarf_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_dwarf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_dwarf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act1_elf_quest_story_one_01_forced",
		response = "pwh_act1_elf_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act1_elf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act1_elf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_elf_quest_story_two_01_forced",
		response = "pbw_act1_elf_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_elf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_elf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act1_elf_quest_story_three_01_forced",
		response = "pdr_act1_elf_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_elf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_elf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_elf_quest_story_four_01_forced",
		response = "pes_act1_elf_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pes_act1_elf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act1_elf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_elf_quest_story_one_01_forced",
		response = "pwh_act2_elf_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act2_elf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act2_elf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_elf_quest_story_two_01_forced",
		response = "pbw_act2_elf_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_elf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_elf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act2_elf_quest_story_three_01_forced",
		response = "pdr_act2_elf_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_elf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_elf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_elf_quest_story_four_01_forced",
		response = "pes_act2_elf_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				0
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_elf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_elf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_elf_quest_story_one_01_forced",
		response = "pwh_act3_elf_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_elf_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_elf_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_elf_quest_story_two_01_forced",
		response = "pwe_act3_elf_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_elf_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_elf_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_elf_quest_story_three_01_forced",
		response = "pwe_act3_elf_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_elf_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_elf_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_elf_quest_story_four_01_forced",
		response = "pdr_act3_elf_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_elf_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_elf_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_elf_quest_story_five_01_forced",
		response = "pdr_act3_elf_quest_story_five_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_elf_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_elf_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act1_soldier_quest_story_one_01_forced",
		response = "pdr_act1_soldier_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"magnus"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_soldier_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_soldier_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act1_soldier_quest_story_two_01_forced",
		response = "pwh_act1_soldier_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act1_soldier_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act1_soldier_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_soldier_quest_story_three_01_forced",
		response = "pbw_act1_soldier_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_soldier_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_soldier_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act1_soldier_quest_story_four_01_forced",
		response = "pwe_act1_soldier_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act1_soldier_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act1_soldier_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act1_soldier_quest_story_five_01_forced",
		response = "pdr_act1_soldier_quest_story_five_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_soldier_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_soldier_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act2_soldier_quest_story_one_01_forced",
		response = "pdr_act2_soldier_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_soldier_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_soldier_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_soldier_quest_story_two_01_forced",
		response = "pwh_act2_soldier_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act2_soldier_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act2_soldier_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_soldier_quest_story_three_01_forced",
		response = "pbw_act2_soldier_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_soldier_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_soldier_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act2_soldier_quest_story_four_01_forced",
		response = "pwe_act2_soldier_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_soldier_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_soldier_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_soldier_quest_story_one_01_forced",
		response = "pdr_act3_soldier_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_soldier_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_soldier_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_soldier_quest_story_two_01_forced",
		response = "pwh_act3_soldier_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_soldier_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_soldier_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_soldier_quest_story_three_01_forced",
		response = "pbw_act3_soldier_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_soldier_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_soldier_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_soldier_quest_story_four_01_forced",
		response = "pwe_act3_soldier_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_soldier_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_soldier_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act1_wizard_quest_story_one_01_forced",
		response = "pdr_act1_wizard_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_wizard_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_wizard_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act1_wizard_quest_story_two_01_forced",
		response = "pwe_act1_wizard_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act1_wizard_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act1_wizard_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act1_wizard_quest_story_three_01_forced",
		response = "pwh_act1_wizard_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act1_wizard_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act1_wizard_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_wizard_quest_story_four_01_forced",
		response = "pes_act1_wizard_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pes_act1_wizard_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act1_wizard_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_wizard_quest_story_one_01_forced",
		response = "pes_act2_wizard_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_wizard_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_wizard_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act2_wizard_quest_story_two_01_forced",
		response = "pbw_act2_wizard_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act2_wizard_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act2_wizard_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act2_wizard_quest_story_three_01_forced",
		response = "pwe_act2_wizard_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_wizard_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_wizard_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act2_wizard_quest_story_four_01_forced",
		response = "pdr_act2_wizard_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_wizard_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_wizard_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act3_wizard_quest_story_one_01_forced",
		response = "pwe_act3_wizard_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act3_wizard_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act3_wizard_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_wizard_quest_story_two_01_forced",
		response = "pbw_act3_wizard_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_wizard_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_wizard_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_wizard_quest_story_three_01_forced",
		response = "pwh_act3_wizard_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_wizard_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_wizard_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_wizard_quest_story_four_01_forced",
		response = "pdr_act3_wizard_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_wizard_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_wizard_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act1_hunter_quest_story_one_01_forced",
		response = "pbw_act1_hunter_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act1_hunter_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act1_hunter_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act1_hunter_quest_story_two_01_forced",
		response = "pdr_act1_hunter_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act1_hunter_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act1_hunter_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act1_hunter_quest_story_three_01_forced",
		response = "pes_act1_hunter_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				0
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_1"
			},
			{
				"faction_memory",
				"once_per_level_pes_act1_hunter_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act1_hunter_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act2_hunter_quest_story_one_01_forced",
		response = "pwe_act2_hunter_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_hunter_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_hunter_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_hunter_quest_story_two_01_forced",
		response = "pes_act2_hunter_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_hunter_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_hunter_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act2_hunter_quest_story_three_01_forced",
		response = "pdr_act2_hunter_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act2_hunter_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act2_hunter_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act2_hunter_quest_story_four_01_forced",
		response = "pes_act2_hunter_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pes_act2_hunter_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act2_hunter_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_act3_hunter_quest_story_one_01_forced",
		response = "pdr_act3_hunter_quest_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pdr_act3_hunter_quest_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pdr_act3_hunter_quest_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_hunter_quest_story_two_01_forced",
		response = "pes_act3_hunter_quest_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pes_act3_hunter_quest_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act3_hunter_quest_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_hunter_quest_story_four_01_forced",
		response = "pbw_act3_hunter_quest_story_four_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_hunter_quest_story_four_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_hunter_quest_story_four_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_hunter_quest_story_five_01_forced",
		response = "pes_act3_hunter_quest_story_five_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pes_act3_hunter_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act3_hunter_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_hunter_quest_story_three_01_forced",
		response = "pwh_act3_hunter_quest_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_hunter_quest_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_hunter_quest_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act2_imprisonment_story_two_01_forced",
		response = "pwh_act2_imprisonment_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act2_imprisonment_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act2_imprisonment_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_act3_dwarf_quest_story_five_01_forced",
		response = "pwh_act3_dwarf_quest_story_five_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pwh_act3_dwarf_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwh_act3_dwarf_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_act3_dwarf_quest_story_six_01_forced",
		response = "pbw_act3_dwarf_quest_story_six_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pbw_act3_dwarf_quest_story_six_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_act3_dwarf_quest_story_six_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_act3_wizard_quest_story_five_01_forced",
		response = "pes_act3_wizard_quest_story_five_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_act",
				OP.EQ,
				"act_3"
			},
			{
				"faction_memory",
				"once_per_level_pes_act3_wizard_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_act3_wizard_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_act2_hunter_quest_story_five_01_forced",
		response = "pwe_act2_hunter_quest_story_five_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"current_act",
				OP.EQ,
				"act_2"
			},
			{
				"faction_memory",
				"once_per_level_pwe_act2_hunter_quest_story_five_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pwe_act2_hunter_quest_story_five_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_docks_story_one_01_forced",
		response = "pwh_docks_story_one_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"empire_soldier",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"docks_short_level"
			},
			{
				"faction_memory",
				"once_per_level_pes_docks_story_one_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_docks_story_one_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_docks_story_three_01_forced",
		response = "pbw_docks_story_three_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"docks_short_level"
			},
			{
				"faction_memory",
				"once_per_level_pbw_docks_story_three_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pbw_docks_story_three_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_docks_story_two_01_forced",
		response = "pes_docks_story_two_01_forced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"query_context",
				"is_forced",
				OP.EQ,
				1
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
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
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"docks_short_level"
			},
			{
				"faction_memory",
				"once_per_level_pes_docks_story_two_01",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_pes_docks_story_two_01",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwe_dialogue_response_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_01"
			}
		},
		pbw_act1_imprisonment_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_imprisonment_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_imprisonment_story_two_01"
			}
		},
		pbw_dialogue_response_24 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_24"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_24"
			}
		},
		pwe_dialogue_09_1_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_09_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_09_1"
			}
		},
		pwh_gameplay_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_07"
			}
		},
		pwe_dialogue_03_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_03"
			}
		},
		pes_dialogue_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_02"
			}
		},
		pwh_dialogue_06_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_06"
			}
		},
		pdr_dialogue_14_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_14"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_14"
			}
		},
		pwh_act1_imprisonment_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_imprisonment_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_imprisonment_story_two_01"
			}
		},
		pwh_dialogue_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_01"
			}
		},
		pdr_act1_hunter_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_hunter_quest_story_two_01"
			}
		},
		pes_act2_elf_quest_story_four_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_elf_quest_story_four_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_elf_quest_story_four_03"
			}
		},
		pbw_act1_wizard_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_wizard_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_wizard_quest_story_one_02"
			}
		},
		pdr_act1_wizard_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_wizard_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_wizard_quest_story_one_02"
			}
		},
		pwh_dialogue_response_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_03"
			}
		},
		pbw_dialogue_response_18 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_18"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_18"
			}
		},
		pwh_dialogue_respones_26b = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_respones_26b"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_respones_26b"
			}
		},
		pwh_act3_hunter_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_hunter_quest_story_three_01"
			}
		},
		pwh_act3_dwarf_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_dwarf_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_dwarf_quest_story_four_02"
			}
		},
		pdr_dialogue_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_02"
			}
		},
		pes_dialogue_response_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_05"
			}
		},
		pwh_act3_hunter_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_hunter_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_hunter_quest_story_two_02"
			}
		},
		pwe_dialogue_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_08"
			}
		},
		pbw_dialogue_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_10"
			}
		},
		pwe_dialogue_07_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_07"
			}
		},
		pwe_dialogue_response_23 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_23"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_23"
			}
		},
		pbw_docks_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_docks_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_docks_story_three_01"
			}
		},
		pwe_act3_elf_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_five_01"
			}
		},
		pdr_act3_dwarf_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_five_02"
			}
		},
		pwe_gameplay_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_08"
			}
		},
		pdr_dialogue_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_07"
			}
		},
		pbw_dialogue_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_07"
			}
		},
		pes_gameplay_response_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_response_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_response_05"
			}
		},
		pbw_dialogue_response_35 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_35"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_35"
			}
		},
		pdr_dialogue_response_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_13"
			}
		},
		pbw_act3_hunter_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_hunter_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_hunter_quest_story_four_01"
			}
		},
		pwh_gameplay_ranger_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_ranger_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_ranger_misses_bomb_01"
			}
		},
		pes_act1_soldier_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_one_02"
			}
		},
		pbw_dialogue_response_31 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_31"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_31"
			}
		},
		pes_act2_soldier_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_soldier_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_soldier_quest_story_four_02"
			}
		},
		pwh_act3_elf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_elf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_elf_quest_story_one_02"
			}
		},
		pdr_dialogue_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_03"
			}
		},
		pes_dialogue_response_18 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_18"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_18"
			}
		},
		pes_act3_dwarf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_dwarf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_dwarf_quest_story_one_02"
			}
		},
		pdr_act2_dwarf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_dwarf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_dwarf_quest_story_one_02"
			}
		},
		pwh_dialogue_response_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_02"
			}
		},
		pbw_act2_dwarf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_dwarf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_dwarf_quest_story_one_02"
			}
		},
		pwe_act1_elf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_elf_quest_story_one_01"
			}
		},
		pbw_dialogue_response_39 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_39"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_39"
			}
		},
		pwe_dialogue_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_04"
			}
		},
		pwh_gameplay_response_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_10"
			}
		},
		pes_gameplay_ranger_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_ranger_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_ranger_misses_bomb_01"
			}
		},
		pwh_dialogue_05_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_05"
			}
		},
		pbw_gameplay_ranger_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_ranger_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_ranger_misses_bomb_01"
			}
		},
		pwh_gameplay_response_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_06"
			}
		},
		pwe_act3_elf_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_two_01"
			}
		},
		pwe_dialogue_response_17 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_17"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_17"
			}
		},
		pdr_dialogue_response_35 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_35"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_35"
			}
		},
		pbw_act1_wizard_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_wizard_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_wizard_quest_story_four_02"
			}
		},
		pdr_dialogue_response_19 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_19"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_19"
			}
		},
		pbw_act1_elf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_elf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_elf_quest_story_two_02"
			}
		},
		pwe_dialogue_05_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_05"
			}
		},
		pwh_docks_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_docks_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_docks_story_three_02"
			}
		},
		pwe_dialogue_response_36 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_36"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_36"
			}
		},
		pbw_dialogue_response_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_13"
			}
		},
		pwe_dialogue_response_34 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_34"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_34"
			}
		},
		pbw_dialogue_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_07"
			}
		},
		pwe_dialogue_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_09"
			}
		},
		pdr_dialogue_response_15 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_15"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_15"
			}
		},
		pwe_dialogue_response_30 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_30"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_30"
			}
		},
		pwh_dialogue_response_20 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_20"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_20"
			}
		},
		pwe_act3_elf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_two_01"
			}
		},
		pbw_dialogue_response_14 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_14"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_14"
			}
		},
		pwh_dialogue_response_24 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_24"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_24"
			}
		},
		pwh_gameplay_response_20 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_20"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_20"
			}
		},
		pwh_dialogue_response_28 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_28"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_28"
			}
		},
		pdr_dialogue_11_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_11"
			}
		},
		pes_act1_wizard_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_wizard_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_wizard_quest_story_four_02"
			}
		},
		pwe_dialogue_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_05"
			}
		},
		pdr_act3_wizard_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_wizard_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_wizard_quest_story_four_02"
			}
		},
		pwe_act3_elf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_one_01"
			}
		},
		pdr_dialogue_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_07"
			}
		},
		pdr_dialogue_10_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_10"
			}
		},
		pbw_act2_wizard_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_wizard_quest_story_three_01"
			}
		},
		pes_act3_hunter_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_hunter_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_hunter_quest_story_two_02"
			}
		},
		pwe_dialogue_08_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_08"
			}
		},
		pdr_gameplay_response_23 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_23"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_23"
			}
		},
		pbw_act2_hunter_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_hunter_quest_story_one_01"
			}
		},
		pwh_act3_elf_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_elf_quest_story_one_01"
			}
		},
		pwe_act3_wizard_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_wizard_quest_story_one_01"
			}
		},
		pwe_dialogue_response_38 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_38"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_38"
			}
		},
		pwe_gameplay_response_20 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_20"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_20"
			}
		},
		pwh_dialogue_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_08"
			}
		},
		pes_dialogue_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_10"
			}
		},
		pdr_act2_dwarf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_dwarf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_dwarf_quest_story_four_01"
			}
		},
		pwh_gameplay_response_21 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_21"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_21"
			}
		},
		pwh_act2_hunter_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_hunter_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_hunter_quest_story_three_02"
			}
		},
		pdr_dialogue_response_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_10"
			}
		},
		pwe_dialogue_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_02"
			}
		},
		pdr_act1_wizard_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_wizard_quest_story_one_01"
			}
		},
		pwh_dialogue_response_16 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_16"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_16"
			}
		},
		pwe_act2_dwarf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_dwarf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_dwarf_quest_story_four_01"
			}
		},
		pes_dialogue_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_07"
			}
		},
		pes_dialogue_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_07"
			}
		},
		pdr_act3_hunter_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_hunter_quest_story_one_01"
			}
		},
		pdr_act2_hunter_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_hunter_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_hunter_quest_story_three_02"
			}
		},
		pwe_dialogue_response_41 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_41"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_41"
			}
		},
		pes_dialogue_response_19 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_19"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_19"
			}
		},
		pbw_dialogue_response_37 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_37"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_37"
			}
		},
		pwe_act2_wizard_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_wizard_quest_story_three_01"
			}
		},
		pdr_dialogue_response_09_1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_09_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_09_1"
			}
		},
		pwe_dialogue_response_42 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_42"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_42"
			}
		},
		pwe_act3_elf_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_five_02"
			}
		},
		pwh_act2_dwarf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_dwarf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_dwarf_quest_story_two_01"
			}
		},
		pes_act3_hunter_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_hunter_quest_story_two_01"
			}
		},
		pwh_dialogue_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_07"
			}
		},
		pdr_act2_dwarf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_dwarf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_dwarf_quest_story_two_01"
			}
		},
		pbw_act3_dwarf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_dwarf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_dwarf_quest_story_two_01"
			}
		},
		pes_gameplay_response_16 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_response_16"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_response_16"
			}
		},
		pwe_dialogue_04_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_04"
			}
		},
		pes_gameplay_wizard_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_wizard_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_wizard_misses_bomb_01"
			}
		},
		pdr_dialogue_response_27 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_27"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_27"
			}
		},
		pdr_gameplay_wizard_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_wizard_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_wizard_misses_bomb_01"
			}
		},
		pdr_act3_elf_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_elf_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_elf_quest_story_five_02"
			}
		},
		pwe_dialogue_response_18 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_18"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_18"
			}
		},
		pdr_gameplay_response_22 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_22"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_22"
			}
		},
		pbw_act2_imprisonment_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_imprisonment_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_imprisonment_story_two_01"
			}
		},
		pwe_act3_wizard_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_wizard_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_wizard_quest_story_one_02"
			}
		},
		pwh_act1_elf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_elf_quest_story_one_01"
			}
		},
		pwh_act1_imprisonment_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_imprisonment_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_imprisonment_story_one_02"
			}
		},
		pwh_act2_hunter_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_hunter_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_hunter_quest_story_four_01"
			}
		},
		pes_dialogue_response_16 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_16"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_16"
			}
		},
		pes_gameplay_elf_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_elf_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_elf_misses_bomb_01"
			}
		},
		pwe_gameplay_wizard_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_wizard_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_wizard_misses_bomb_01"
			}
		},
		pes_act2_hunter_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_hunter_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_hunter_quest_story_four_02"
			}
		},
		pbw_act3_hunter_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_hunter_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_hunter_quest_story_four_01"
			}
		},
		pes_dialogue_response_27 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_27"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_27"
			}
		},
		pdr_gameplay_response_18 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_18"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_18"
			}
		},
		pbw_act3_hunter_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_hunter_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_hunter_quest_story_four_02"
			}
		},
		pbw_dialogue_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_01"
			}
		},
		pwh_dialogue_response_17 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_17"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_17"
			}
		},
		pwe_dialogue_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_13"
			}
		},
		pes_act2_dwarf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_dwarf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_dwarf_quest_story_three_01"
			}
		},
		pdr_gameplay_elf_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_elf_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_elf_misses_bomb_01"
			}
		},
		pes_act2_wizard_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_wizard_quest_story_one_01"
			}
		},
		pbw_dialogue_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_06"
			}
		},
		pbw_dialogue_response_16 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_16"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_16"
			}
		},
		pes_dialogue_response_14 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_14"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_14"
			}
		},
		pbw_act2_wizard_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_wizard_quest_story_one_01"
			}
		},
		pbw_dialogue_response_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_04"
			}
		},
		pbw_gameplay_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_response_08"
			}
		},
		pbw_dialogue_response_17 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_17"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_17"
			}
		},
		pwe_act2_elf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_elf_quest_story_one_01"
			}
		},
		pwh_act1_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_quest_story_one_01"
			}
		},
		pwe_act3_dwarf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_dwarf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_dwarf_quest_story_three_01"
			}
		},
		pdr_act2_dwarf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_dwarf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_dwarf_quest_story_three_01"
			}
		},
		pes_act1_elf_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_elf_quest_story_four_01"
			}
		},
		pbw_act1_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_quest_story_four_01"
			}
		},
		pwe_act2_elf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_elf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_elf_quest_story_one_02"
			}
		},
		pes_dialogue_response_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_04"
			}
		},
		pwh_act2_elf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_elf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_elf_quest_story_one_02"
			}
		},
		pwe_dialogue_response_26 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_26"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_26"
			}
		},
		pdr_act3_hunter_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_hunter_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_hunter_quest_story_one_02"
			}
		},
		pes_act3_dwarf_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_dwarf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_dwarf_quest_story_one_01"
			}
		},
		pwh_dialogue_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_05"
			}
		},
		pdr_act3_elf_quest_story_five_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_elf_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_elf_quest_story_five_01"
			}
		},
		pdr_gameplay_soldier_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_soldier_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_soldier_misses_bomb_01"
			}
		},
		pbw_dialogue_response_28 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_28"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_28"
			}
		},
		pwe_gameplay_response_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_09"
			}
		},
		pes_dialogue_response_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_06"
			}
		},
		pwe_dialogue_response_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_10"
			}
		},
		pbw_gameplay_soldier_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_soldier_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_soldier_misses_bomb_01"
			}
		},
		pwh_gameplay_response_19 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_19"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_19"
			}
		},
		pbw_act1_soldier_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_soldier_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_soldier_quest_story_three_02"
			}
		},
		pwe_gameplay_response_24 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_24"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_24"
			}
		},
		pes_act1_soldier_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_three_02"
			}
		},
		pbw_act2_elf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_elf_quest_story_four_01"
			}
		},
		pdr_act3_dwarf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_four_01"
			}
		},
		pwe_dialogue_response_40 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_40"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_40"
			}
		},
		pdr_dialogue_response_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_06"
			}
		},
		pdr_act1_soldier_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_soldier_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_soldier_quest_story_five_01"
			}
		},
		pes_act1_soldier_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_five_01"
			}
		},
		pdr_dialogue_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_13"
			}
		},
		pwh_dialogue_response_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_06"
			}
		},
		pbw_gameplay_response_19 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_response_19"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_calm"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_response_19"
			}
		},
		pbw_dialogue_response_30 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_30"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_30"
			}
		},
		pes_dialogue_response_09a = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_09a"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_09a"
			}
		},
		pwe_dialogue_06_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_06"
			}
		},
		pbw_dialogue_response_40 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_40"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_40"
			}
		},
		pwh_act3_elf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_elf_quest_story_one_01"
			}
		},
		pes_act2_elf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_elf_quest_story_four_01"
			}
		},
		pes_dialogue_response_22 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_22"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_22"
			}
		},
		pwh_act2_imprisonment_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_imprisonment_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_imprisonment_story_two_02"
			}
		},
		pdr_act1_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_quest_story_two_01"
			}
		},
		pwe_dialogue_13_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_13"
			}
		},
		pes_gameplay_response_14 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_response_14"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_response_14"
			}
		},
		pbw_gameplay_response_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_response_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_response_10"
			}
		},
		pwe_dialogue_response_12 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_12"
			}
		},
		pes_act3_dwarf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_dwarf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_dwarf_quest_story_one_01"
			}
		},
		pes_dialogue_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_08"
			}
		},
		pwe_gameplay_response_22 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_22"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_22"
			}
		},
		pes_act1_elf_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_elf_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_elf_quest_story_four_02"
			}
		},
		pwe_act3_elf_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_three_01"
			}
		},
		pes_act3_wizard_quest_story_five_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_wizard_quest_story_five_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_wizard_quest_story_five_03"
			}
		},
		pbw_dialogue_11 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_11"
			}
		},
		pbw_act1_hunter_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_hunter_quest_story_one_01"
			}
		},
		pwh_act1_hunter_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_hunter_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_hunter_quest_story_two_02"
			}
		},
		pbw_act1_wizard_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_wizard_quest_story_two_01"
			}
		},
		pbw_dialogue_response_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_01"
			}
		},
		pbw_act1_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_quest_story_two_01"
			}
		},
		pes_dialogue_response_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_02"
			}
		},
		pes_act1_hunter_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_hunter_quest_story_three_01"
			}
		},
		pdr_act2_hunter_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_hunter_quest_story_three_01"
			}
		},
		pes_gameplay_response_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_response_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_response_13"
			}
		},
		pes_act1_soldier_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_two_02"
			}
		},
		pdr_act1_hunter_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_hunter_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_hunter_quest_story_two_02"
			}
		},
		pdr_dialogue_response_33 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_33"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_33"
			}
		},
		pbw_act1_soldier_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_soldier_quest_story_three_01"
			}
		},
		pwh_act1_elf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_elf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_elf_quest_story_one_02"
			}
		},
		pdr_dialogue_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_08"
			}
		},
		pes_act1_soldier_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_three_01"
			}
		},
		pwh_act1_soldier_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_soldier_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_soldier_quest_story_two_02"
			}
		},
		pbw_act1_elf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_elf_quest_story_two_01"
			}
		},
		pdr_dialogue_08_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_08"
			}
		},
		pdr_gameplay_wizard_fires_a_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_wizard_fires_a_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_wizard_fires_a_rat_ogre_01"
			}
		},
		pwe_dialogue_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_10"
			}
		},
		pwh_act1_hunter_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_hunter_quest_story_two_01"
			}
		},
		pdr_act2_hunter_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_hunter_quest_story_three_01"
			}
		},
		pwe_act1_wizard_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_wizard_quest_story_two_01"
			}
		},
		pwe_act2_wizard_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_wizard_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_wizard_quest_story_three_02"
			}
		},
		pdr_act1_elf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_elf_quest_story_three_01"
			}
		},
		pdr_gameplay_entering_greyseer_lair_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_entering_greyseer_lair_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_entering_greyseer_lair_01"
			}
		},
		pwh_dialogue_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_07"
			}
		},
		pbw_dialogue_response_29 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_29"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_29"
			}
		},
		pwh_dialogue_12 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_12"
			}
		},
		pbw_act2_elf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_elf_quest_story_two_01"
			}
		},
		pwe_act3_elf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_three_01"
			}
		},
		pbw_gameplay_hunter_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_hunter_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_hunter_misses_bomb_01"
			}
		},
		pbw_dialogue_response_12 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_12"
			}
		},
		pbw_act2_elf_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_elf_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_elf_quest_story_four_02"
			}
		},
		pes_dialogue_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_04"
			}
		},
		pes_act2_elf_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_elf_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_elf_quest_story_four_02"
			}
		},
		pbw_act3_wizard_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_two_01"
			}
		},
		pdr_gameplay_killing_a_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_killing_a_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_killing_a_rat_ogre_01"
			}
		},
		pbw_act3_elf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_elf_quest_story_three_01"
			}
		},
		pdr_act1_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_quest_story_three_01"
			}
		},
		pwh_act3_wizard_quest_story_five_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_wizard_quest_story_five_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_wizard_quest_story_five_05"
			}
		},
		pwh_dialogue_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_10"
			}
		},
		pwh_dialogue_11_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_11"
			}
		},
		pwh_dialogue_response_22 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_22"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_22"
			}
		},
		pes_docks_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_docks_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_docks_story_one_02"
			}
		},
		pbw_gameplay_response_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_response_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_response_09"
			}
		},
		pes_act2_wizard_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_wizard_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_wizard_quest_story_one_02"
			}
		},
		pwe_act3_elf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_four_01"
			}
		},
		pes_act2_soldier_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_soldier_quest_story_two_01"
			}
		},
		pwh_gameplay_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_08"
			}
		},
		pbw_dialogue_response_34 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_34"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_34"
			}
		},
		pdr_dialogue_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_04"
			}
		},
		pwe_act2_elf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_elf_quest_story_two_01"
			}
		},
		pwe_gameplay_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_07"
			}
		},
		pdr_dialogue_response_34 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_34"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_34"
			}
		},
		pes_act1_elf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_elf_quest_story_four_01"
			}
		},
		pbw_act2_imprisonment_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_imprisonment_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_imprisonment_story_one_01"
			}
		},
		pwh_act2_imprisonment_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_imprisonment_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_imprisonment_story_one_01"
			}
		},
		pwe_act3_wizard_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_wizard_quest_story_one_01"
			}
		},
		pes_dialogue_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_05"
			}
		},
		pes_dialogue_response_23 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_23"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_23"
			}
		},
		pdr_act1_soldier_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_soldier_quest_story_one_01"
			}
		},
		pes_act2_soldier_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_soldier_quest_story_one_01"
			}
		},
		pbw_act2_wizard_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_wizard_quest_story_two_01"
			}
		},
		pdr_act3_elf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_elf_quest_story_four_01"
			}
		},
		pwh_act3_hunter_quest_story_one_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_hunter_quest_story_one_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_hunter_quest_story_one_03"
			}
		},
		pwh_dialogue_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_08"
			}
		},
		pwe_dialogue_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_07"
			}
		},
		pwe_dialogue_response_25 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_25"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_25"
			}
		},
		pdr_gameplay_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_08"
			}
		},
		pwe_act1_elf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_elf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_elf_quest_story_one_02"
			}
		},
		pes_docks_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_docks_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_docks_story_two_01"
			}
		},
		pdr_dialogue_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_08"
			}
		},
		pbw_dialogue_response_38 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_38"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_38"
			}
		},
		pwh_docks_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_docks_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_docks_story_one_01"
			}
		},
		pbw_dialogue_response_41 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_41"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_41"
			}
		},
		pwe_act2_hunter_quest_story_five_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_hunter_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_hunter_quest_story_five_01"
			}
		},
		pes_act3_soldier_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_soldier_quest_story_four_01"
			}
		},
		pwe_dialogue_response_28 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_28"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_28"
			}
		},
		pwe_act1_soldier_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_soldier_quest_story_four_01"
			}
		},
		pbw_dialogue_response_36 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_36"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_36"
			}
		},
		pwe_gameplay_entering_greyseer_lair_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_entering_greyseer_lair_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_entering_greyseer_lair_01"
			}
		},
		pbw_act1_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_quest_story_two_01"
			}
		},
		pes_act1_hunter_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_hunter_quest_story_one_01"
			}
		},
		pbw_act3_wizard_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_one_02"
			}
		},
		pes_act3_hunter_quest_story_five_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_hunter_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_hunter_quest_story_five_01"
			}
		},
		pes_act3_hunter_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_hunter_quest_story_two_01"
			}
		},
		pwe_dialogue_02_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_02"
			}
		},
		pdr_act2_soldier_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_soldier_quest_story_one_01"
			}
		},
		pwe_act1_elf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_elf_quest_story_four_01"
			}
		},
		pwe_dialogue_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_06"
			}
		},
		pes_act2_hunter_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_hunter_quest_story_two_01"
			}
		},
		pdr_dialogue_05_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_05"
			}
		},
		pes_act2_dwarf_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_dwarf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_dwarf_quest_story_three_01"
			}
		},
		pbw_docks_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_docks_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_docks_story_three_01"
			}
		},
		pdr_dialogue_response_20 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_20"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_20"
			}
		},
		pes_dialogue_response_11 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_11"
			}
		},
		pdr_dialogue_11 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_11"
			}
		},
		pdr_dialogue_03_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_03"
			}
		},
		pwh_act3_wizard_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_wizard_quest_story_three_01"
			}
		},
		pbw_act3_wizard_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_two_01"
			}
		},
		pwh_act3_dwarf_quest_story_five_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_dwarf_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_dwarf_quest_story_five_01"
			}
		},
		pwe_act3_dwarf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_dwarf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_dwarf_quest_story_three_02"
			}
		},
		pwe_act2_wizard_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_wizard_quest_story_three_01"
			}
		},
		pes_act2_wizard_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_wizard_quest_story_one_01"
			}
		},
		pwe_dialogue_response_14 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_14"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_14"
			}
		},
		pes_act1_wizard_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_wizard_quest_story_four_01"
			}
		},
		pwh_act1_wizard_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_wizard_quest_story_three_01"
			}
		},
		pwe_act1_wizard_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_wizard_quest_story_two_01"
			}
		},
		pes_act1_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_quest_story_three_01"
			}
		},
		pwe_act3_soldier_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_soldier_quest_story_four_01"
			}
		},
		pdr_act2_dwarf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_dwarf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_dwarf_quest_story_three_02"
			}
		},
		pes_act2_dwarf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_dwarf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_dwarf_quest_story_three_02"
			}
		},
		pbw_act3_soldier_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_soldier_quest_story_three_01"
			}
		},
		pwh_act3_wizard_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_wizard_quest_story_three_01"
			}
		},
		pdr_dialogue_response_24 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_24"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_24"
			}
		},
		pes_dialogue_04_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_04"
			}
		},
		pwe_dialogue_response_37_1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_37_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_37_1"
			}
		},
		pdr_gameplay_response_19 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_19"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_19"
			}
		},
		pwe_gameplay_soldier_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_soldier_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_soldier_misses_bomb_01"
			}
		},
		pwe_act2_soldier_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_soldier_quest_story_four_01"
			}
		},
		pbw_act2_soldier_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_soldier_quest_story_three_01"
			}
		},
		pes_dialogue_03_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_03"
			}
		},
		pwe_act3_soldier_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_soldier_quest_story_four_01"
			}
		},
		pwh_dialogue_10_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_10"
			}
		},
		pwh_act2_soldier_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_soldier_quest_story_two_01"
			}
		},
		pwe_act2_elf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_elf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_elf_quest_story_three_02"
			}
		},
		pdr_act2_soldier_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_soldier_quest_story_one_01"
			}
		},
		pwh_act2_hunter_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_hunter_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_hunter_quest_story_four_02"
			}
		},
		pwe_dialogue_response_24 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_24"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_24"
			}
		},
		pwh_act1_elf_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_elf_quest_story_one_01"
			}
		},
		pwh_act1_soldier_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_soldier_quest_story_two_01"
			}
		},
		pes_gameplay_response_17 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_response_17"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_response_17"
			}
		},
		pbw_act3_wizard_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_one_01"
			}
		},
		pdr_act1_soldier_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_soldier_quest_story_one_01"
			}
		},
		pes_act1_hunter_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_hunter_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_hunter_quest_story_one_02"
			}
		},
		pwh_act2_hunter_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_hunter_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_hunter_quest_story_five_02"
			}
		},
		pdr_act3_elf_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_elf_quest_story_four_01"
			}
		},
		pes_act2_elf_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_elf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_elf_quest_story_four_01"
			}
		},
		pdr_act2_elf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_elf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_elf_quest_story_three_02"
			}
		},
		pbw_act1_hunter_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_hunter_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_hunter_quest_story_one_02"
			}
		},
		pes_dialogue_response_21 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_21"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_21"
			}
		},
		pdr_dialogue_02_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_02"
			}
		},
		pes_gameplay_killing_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_killing_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_killing_rat_ogre_01"
			}
		},
		pwe_dialogue_response_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_13"
			}
		},
		pbw_act2_elf_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_elf_quest_story_two_01"
			}
		},
		pdr_act3_hunter_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_hunter_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_hunter_quest_story_five_02"
			}
		},
		pbw_dialogue_response_26 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_26"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_26"
			}
		},
		pbw_gameplay_killing_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_killing_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_killing_rat_ogre_01"
			}
		},
		pbw_act3_hunter_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_hunter_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_hunter_quest_story_five_02"
			}
		},
		pbw_dialogue_response_33 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_33"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_33"
			}
		},
		pdr_act3_soldier_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_soldier_quest_story_one_01"
			}
		},
		pdr_act1_elf_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_elf_quest_story_three_01"
			}
		},
		pwh_gameplay_response_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_09"
			}
		},
		pbw_act1_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_quest_story_four_02"
			}
		},
		pdr_dialogue_04_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_04"
			}
		},
		pdr_gameplay_response_17 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_17"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_17"
			}
		},
		pbw_act1_soldier_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_soldier_quest_story_three_01"
			}
		},
		pwh_act1_imprisonment_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_imprisonment_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_imprisonment_story_one_01"
			}
		},
		pwe_act3_dwarf_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_dwarf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_dwarf_quest_story_three_01"
			}
		},
		pes_gameplay_response_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_response_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_response_06"
			}
		},
		pbw_act3_dwarf_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_dwarf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_dwarf_quest_story_two_01"
			}
		},
		pdr_act1_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_quest_story_three_01"
			}
		},
		pbw_act1_hunter_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_hunter_quest_story_one_01"
			}
		},
		pdr_act2_dwarf_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_dwarf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_dwarf_quest_story_two_01"
			}
		},
		pbw_act2_dwarf_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_dwarf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_dwarf_quest_story_one_01"
			}
		},
		pbw_act1_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_quest_story_four_01"
			}
		},
		pwe_act2_dwarf_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_dwarf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_dwarf_quest_story_four_01"
			}
		},
		pbw_act3_soldier_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_soldier_quest_story_three_01"
			}
		},
		pwe_gameplay_response_23 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_23"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_23"
			}
		},
		pbw_act2_imprisonment_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_imprisonment_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_imprisonment_story_one_01"
			}
		},
		pbw_act2_wizard_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_wizard_quest_story_two_01"
			}
		},
		pwh_act3_dwarf_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_dwarf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_dwarf_quest_story_four_01"
			}
		},
		pwe_act1_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_quest_story_four_01"
			}
		},
		pwh_act3_dwarf_quest_story_five_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_dwarf_quest_story_five_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_dwarf_quest_story_five_03"
			}
		},
		pbw_dialogue_12_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_12"
			}
		},
		pwe_act2_dwarf_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_dwarf_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_dwarf_quest_story_four_02"
			}
		},
		pbw_act1_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_quest_story_two_02"
			}
		},
		pwe_dialogue_11_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_11"
			}
		},
		pes_dialogue_09_1_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_09_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_09_1"
			}
		},
		pes_dialogue_08_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_08"
			}
		},
		pwh_dialogue_14_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_14"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_14"
			}
		},
		pwh_dialogue_13_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_13"
			}
		},
		pwe_dialogue_response_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_03"
			}
		},
		pwh_dialogue_12_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_12"
			}
		},
		pbw_dialogue_response_38_1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_38_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_38_1"
			}
		},
		pwh_dialogue_08_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_08"
			}
		},
		pdr_dialogue_12_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_12"
			}
		},
		pwe_dialogue_response_35 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_35"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_35"
			}
		},
		pdr_dialogue_07_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_07"
			}
		},
		pbw_dialogue_11_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_11"
			}
		},
		pdr_dialogue_06_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_06"
			}
		},
		pbw_gameplay_entering_greyseer_lair_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_entering_greyseer_lair_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_entering_greyseer_lair_01"
			}
		},
		pwe_dialogue_10_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_10"
			}
		},
		pwe_gameplay_hunter_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_hunter_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_hunter_misses_bomb_01"
			}
		},
		pbw_act3_wizard_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_three_01"
			}
		},
		pbw_act2_imprisonment_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_imprisonment_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_imprisonment_story_one_02"
			}
		},
		pwe_dialogue_12_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_12"
			}
		},
		pdr_dialogue_13_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_13"
			}
		},
		pdr_gameplay_soldier_shooting_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_soldier_shooting_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_soldier_shooting_rat_ogre_01"
			}
		},
		pdr_gameplay_response_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_06"
			}
		},
		pwe_act2_hunter_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_hunter_quest_story_one_01"
			}
		},
		pwh_gameplay_solider_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_solider_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_solider_misses_bomb_01"
			}
		},
		pwe_act2_hunter_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_hunter_quest_story_one_01"
			}
		},
		pbw_dialogue_08_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_08"
			}
		},
		pbw_dialogue_09_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_09"
			}
		},
		pwh_dialogue_07_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_07"
			}
		},
		pdr_gameplay_hunter_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_hunter_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_hunter_misses_bomb_01"
			}
		},
		pes_gameplay_hunter_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_hunter_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_hunter_misses_bomb_01"
			}
		},
		pwe_dialogue_09_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_09"
			}
		},
		pwh_gameplay_elf_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_elf_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_elf_misses_bomb_01"
			}
		},
		pes_dialogue_10_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_10"
			}
		},
		pes_dialogue_05_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_05"
			}
		},
		pes_dialogue_09_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_09"
			}
		},
		pes_dialogue_02_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_02"
			}
		},
		pes_dialogue_06_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_06"
			}
		},
		pwh_act3_soldier_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_soldier_quest_story_two_01"
			}
		},
		pbw_dialogue_07_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_07"
			}
		},
		pbw_act1_elf_quest_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_elf_quest_story_two_01"
			}
		},
		pbw_gameplay_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_response_07"
			}
		},
		pbw_dialogue_06_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_06"
			}
		},
		pes_act2_soldier_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_soldier_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_soldier_quest_story_two_02"
			}
		},
		pdr_act3_hunter_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_hunter_quest_story_one_01"
			}
		},
		pwe_dialogue_response_39 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_39"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_39"
			}
		},
		pwh_dialogue_14 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_14"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_14"
			}
		},
		pwh_act1_wizard_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_wizard_quest_story_three_01"
			}
		},
		pwe_dialogue_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_01"
			}
		},
		pbw_act3_elf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_elf_quest_story_two_01"
			}
		},
		pbw_dialogue_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_01"
			}
		},
		pwh_dialogue_response_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_01"
			}
		},
		pwh_dialogue_response_19 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_19"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_19"
			}
		},
		pes_dialogue_response_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_01"
			}
		},
		pbw_dialogue_12 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_12"
			}
		},
		pes_docks_story_two_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_docks_story_two_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_docks_story_two_03"
			}
		},
		pbw_docks_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_docks_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_docks_story_two_02"
			}
		},
		pes_docks_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_docks_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_docks_story_two_01"
			}
		},
		pdr_act3_wizard_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_wizard_quest_story_four_01"
			}
		},
		pwh_docks_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_docks_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_docks_story_one_01"
			}
		},
		pdr_act3_dwarf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_three_02"
			}
		},
		pwe_act2_hunter_quest_story_six_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_hunter_quest_story_six_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_hunter_quest_story_six_01"
			}
		},
		pwh_dialogue_response_23 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_23"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_23"
			}
		},
		pwh_dialogue_11 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_11"
			}
		},
		pdr_act1_soldier_quest_story_five_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_soldier_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_soldier_quest_story_five_01"
			}
		},
		pbw_act3_wizard_quest_story_five_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_five_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_five_04"
			}
		},
		pbw_act1_wizard_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_wizard_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_wizard_quest_story_three_01"
			}
		},
		pes_act2_hunter_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_hunter_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_hunter_quest_story_four_01"
			}
		},
		pes_act3_wizard_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_wizard_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_wizard_quest_story_five_01"
			}
		},
		pdr_act3_dwarf_quest_story_six_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_six_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_six_02"
			}
		},
		pbw_act3_dwarf_quest_story_six_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_dwarf_quest_story_six_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_dwarf_quest_story_six_01"
			}
		},
		pwh_act3_dwarf_quest_story_five_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_dwarf_quest_story_five_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_dwarf_quest_story_five_05"
			}
		},
		pdr_act3_dwarf_quest_story_five_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_five_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_five_04"
			}
		},
		pwh_act3_dwarf_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_dwarf_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_dwarf_quest_story_five_01"
			}
		},
		pbw_dialogue_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_08"
			}
		},
		pes_act1_wizard_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_wizard_quest_story_four_01"
			}
		},
		pdr_act2_wizard_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_wizard_quest_story_four_01"
			}
		},
		pdr_dialogue_response_36 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_36"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_36"
			}
		},
		pes_act1_hunter_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_hunter_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_hunter_quest_story_three_02"
			}
		},
		pwh_act2_imprisonment_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_imprisonment_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_imprisonment_story_two_01"
			}
		},
		pbw_act3_hunter_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_hunter_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_hunter_quest_story_five_01"
			}
		},
		pbw_act1_hunter_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_hunter_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_hunter_quest_story_three_02"
			}
		},
		pes_act3_hunter_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_hunter_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_hunter_quest_story_five_01"
			}
		},
		pwh_act3_hunter_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_hunter_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_hunter_quest_story_four_01"
			}
		},
		pwh_act3_hunter_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_hunter_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_hunter_quest_story_three_02"
			}
		},
		pwe_act3_hunter_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_hunter_quest_story_three_01"
			}
		},
		pdr_gameplay_response_20 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_20"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_20"
			}
		},
		pwh_act3_hunter_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_hunter_quest_story_two_01"
			}
		},
		pes_gameplay_entering_greyseer_lair_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_entering_greyseer_lair_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_entering_greyseer_lair_01"
			}
		},
		pdr_act3_elf_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_elf_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_elf_quest_story_five_01"
			}
		},
		pes_dialogue_response_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_10"
			}
		},
		pwe_dialogue_response_37 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_37"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_37"
			}
		},
		pdr_act3_hunter_quest_story_one_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_hunter_quest_story_one_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_hunter_quest_story_one_04"
			}
		},
		pwe_dialogue_response_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_06"
			}
		},
		pes_dialogue_response_20 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_20"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_20"
			}
		},
		pbw_act2_dwarf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_dwarf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_dwarf_quest_story_one_01"
			}
		},
		pwh_act3_hunter_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_hunter_quest_story_one_01"
			}
		},
		pwe_act1_elf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_elf_quest_story_three_01"
			}
		},
		pwe_dialogue_12 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_12"
			}
		},
		pwe_act1_soldier_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_soldier_quest_story_four_01"
			}
		},
		pwe_act2_hunter_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_hunter_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_hunter_quest_story_five_01"
			}
		},
		pbw_dialogue_response_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_02"
			}
		},
		pes_dialogue_response_26 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_26"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_26"
			}
		},
		pdr_gameplay_response_21 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_21"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_21"
			}
		},
		pdr_dialogue_response_26 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_26"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_26"
			}
		},
		pdr_dialogue_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_10"
			}
		},
		pdr_act2_dwarf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_dwarf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_dwarf_quest_story_one_01"
			}
		},
		pbw_act3_wizard_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_five_02"
			}
		},
		pbw_dialogue_10_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_10"
			}
		},
		pwh_act2_wizard_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_wizard_quest_story_two_01"
			}
		},
		pwe_gameplay_response_10 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_10"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_10"
			}
		},
		pwh_act2_hunter_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_hunter_quest_story_three_01"
			}
		},
		pwe_dialogue_response_27 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_27"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_27"
			}
		},
		pes_dialogue_response_30 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_30"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_30"
			}
		},
		pbw_gameplay_elf_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_elf_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_elf_misses_bomb_01"
			}
		},
		pes_act2_hunter_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_hunter_quest_story_two_01"
			}
		},
		pes_dialogue_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_08"
			}
		},
		pwe_act2_hunter_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_hunter_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_hunter_quest_story_one_02"
			}
		},
		pwh_dialogue_response_25 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_25"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_25"
			}
		},
		pwe_dialogue_response_11 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_11"
			}
		},
		pbw_act1_imprisonment_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_imprisonment_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_imprisonment_story_two_02"
			}
		},
		pwe_act3_elf_quest_story_two_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_two_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_two_03"
			}
		},
		pbw_act2_soldier_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_soldier_quest_story_three_01"
			}
		},
		pes_dialogue_07_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_07"
			}
		},
		pdr_dialogue_09_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_09"
			}
		},
		pwe_dialogue_11 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_11"
			}
		},
		pdr_dialogue_response_30 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_30"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_30"
			}
		},
		pdr_hunter_shoots_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_hunter_shoots_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_hunter_shoots_rat_ogre_01"
			}
		},
		pes_act1_soldier_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_two_01"
			}
		},
		pwh_act2_dwarf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_dwarf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_dwarf_quest_story_two_02"
			}
		},
		pes_act1_soldier_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_five_02"
			}
		},
		pdr_act2_elf_quest_story_three_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_elf_quest_story_three_01"
			}
		},
		pdr_act2_elf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_elf_quest_story_three_01"
			}
		},
		pbw_act2_wizard_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_wizard_quest_story_four_01"
			}
		},
		pes_act1_hunter_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_hunter_quest_story_three_01"
			}
		},
		pdr_act1_soldier_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_soldier_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_soldier_quest_story_five_02"
			}
		},
		pes_gameplay_response_15 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_response_15"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_response_15"
			}
		},
		pdr_act1_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_quest_story_one_01"
			}
		},
		pdr_gameplay_response_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_response_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_response_07"
			}
		},
		pdr_act1_hunter_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_hunter_quest_story_two_01"
			}
		},
		pes_act3_soldier_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_soldier_quest_story_three_01"
			}
		},
		pdr_act2_wizard_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_wizard_quest_story_four_01"
			}
		},
		pbw_dialogue_response_27 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_27"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_27"
			}
		},
		pbw_act3_wizard_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_four_01"
			}
		},
		pbw_dialogue_response_19 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_19"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_19"
			}
		},
		pes_act1_soldier_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_one_01"
			}
		},
		pdr_act3_wizard_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_wizard_quest_story_four_01"
			}
		},
		pdr_gameplay_killing_a_rat_ogre_crossbow_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_killing_a_rat_ogre_crossbow_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_killing_a_rat_ogre_crossbow_01"
			}
		},
		pes_act1_soldier_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_four_02"
			}
		},
		pwe_dialogue_response_43 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_43"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_43"
			}
		},
		pbw_act1_wizard_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_wizard_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_wizard_quest_story_two_02"
			}
		},
		pbw_gameplay_response_07_b = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_response_07_b"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_response_07_b"
			}
		},
		pwe_dialogue_response_33 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_33"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_33"
			}
		},
		pdr_dialogue_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_06"
			}
		},
		pes_act3_wizard_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_wizard_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_wizard_quest_story_two_01"
			}
		},
		pes_dialogue_response_24 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_24"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_24"
			}
		},
		pwh_act2_imprisonment_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_imprisonment_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_imprisonment_story_two_01"
			}
		},
		pbw_dialogue_response_25 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_25"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_25"
			}
		},
		pdr_act1_wizard_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_wizard_quest_story_one_01"
			}
		},
		pbw_act1_hunter_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_hunter_quest_story_three_01"
			}
		},
		pes_dialogue_response_15_1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_15_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_15_1"
			}
		},
		pes_gameplay_elf_shoots_a_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_elf_shoots_a_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_elf_shoots_a_rat_ogre_01"
			}
		},
		pwh_gameplay_entering_greyseer_lair_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_entering_greyseer_lair_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_entering_greyseer_lair_01"
			}
		},
		pwe_act2_elf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_elf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_elf_quest_story_three_01"
			}
		},
		pwe_dialogue_response_31 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_31"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_31"
			}
		},
		pes_act2_soldier_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_soldier_quest_story_four_01"
			}
		},
		pwh_act1_soldier_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_soldier_quest_story_two_01"
			}
		},
		pbw_dialogue_response_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_05"
			}
		},
		pdr_dialogue_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_05"
			}
		},
		pwh_dialogue_response_11 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_11"
			}
		},
		pwh_act3_dwarf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_dwarf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_dwarf_quest_story_four_01"
			}
		},
		pbw_act1_imprisonment_story_two_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_imprisonment_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_imprisonment_story_two_01"
			}
		},
		pwh_dialogue_response_15 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_15"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_15"
			}
		},
		pwe_dialogue_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_03"
			}
		},
		pwe_dialogue_response_15 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_15"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_15"
			}
		},
		pes_dialogue_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_06"
			}
		},
		pwh_dialogue_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_13"
			}
		},
		pwh_dialogue_response_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_04"
			}
		},
		pdr_act3_dwarf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_three_01"
			}
		},
		pbw_act1_wizard_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_wizard_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_wizard_quest_story_four_01"
			}
		},
		pwe_dialogue_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_01"
			}
		},
		pdr_dialogue_response_22 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_22"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_22"
			}
		},
		pdr_act2_dwarf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_dwarf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_dwarf_quest_story_two_02"
			}
		},
		pwe_dialogue_response_16 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_16"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_16"
			}
		},
		pdr_act1_wizard_quest_story_one_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_wizard_quest_story_one_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_wizard_quest_story_one_03"
			}
		},
		pbw_act1_wizard_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_wizard_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_wizard_quest_story_one_01"
			}
		},
		pbw_dialogue_response_32 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_32"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_32"
			}
		},
		pbw_act2_elf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_elf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_elf_quest_story_two_02"
			}
		},
		pes_act3_wizard_quest_story_five_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_wizard_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_wizard_quest_story_five_01"
			}
		},
		pwh_dialogue_response_27 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_27"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_27"
			}
		},
		pes_act3_soldier_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_soldier_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_soldier_quest_story_three_02"
			}
		},
		pbw_act3_soldier_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_soldier_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_soldier_quest_story_three_02"
			}
		},
		pdr_dialogue_response_21 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_21"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_21"
			}
		},
		pdr_act1_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_quest_story_one_01"
			}
		},
		pes_act3_soldier_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_soldier_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_soldier_quest_story_two_02"
			}
		},
		pwh_act2_hunter_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_hunter_quest_story_two_01"
			}
		},
		pwe_dialogue_response_18a = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_18a"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_18a"
			}
		},
		pwh_act3_soldier_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_soldier_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_soldier_quest_story_two_02"
			}
		},
		pes_act3_soldier_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_soldier_quest_story_two_01"
			}
		},
		pwh_act3_soldier_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_soldier_quest_story_two_01"
			}
		},
		pes_dialogue_response_15 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_15"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_15"
			}
		},
		pwe_dialogue_response_29 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_29"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_29"
			}
		},
		pwe_dialogue_response_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_09"
			}
		},
		pes_act3_soldier_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_soldier_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_soldier_quest_story_one_02"
			}
		},
		pdr_act3_soldier_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_soldier_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_soldier_quest_story_one_02"
			}
		},
		pdr_dialogue_response_28 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_28"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_28"
			}
		},
		pes_act3_soldier_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_soldier_quest_story_one_01"
			}
		},
		pwh_dialogue_response_21 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_21"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_21"
			}
		},
		pbw_act3_dwarf_quest_story_six_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_dwarf_quest_story_six_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_dwarf_quest_story_six_01"
			}
		},
		pdr_act1_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_quest_story_three_02"
			}
		},
		pwh_act2_elf_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_elf_quest_story_one_01"
			}
		},
		pwe_gameplay_response_21 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_response_21"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_response_21"
			}
		},
		pwe_act2_soldier_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_soldier_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_soldier_quest_story_four_02"
			}
		},
		pes_dialogue_response_28 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_28"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_28"
			}
		},
		pes_act2_soldier_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_soldier_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_soldier_quest_story_three_02"
			}
		},
		pbw_act2_soldier_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_soldier_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_soldier_quest_story_three_02"
			}
		},
		pes_act2_soldier_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_soldier_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_soldier_quest_story_three_01"
			}
		},
		pdr_dialogue_response_17 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_17"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_17"
			}
		},
		pdr_dialogue_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_01"
			}
		},
		pwh_act2_soldier_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_soldier_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_soldier_quest_story_two_02"
			}
		},
		pdr_dialogue_response_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_09"
			}
		},
		pwh_act2_soldier_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_soldier_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_soldier_quest_story_two_01"
			}
		},
		pes_dialogue_09_1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_09_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_09_1"
			}
		},
		pdr_act2_soldier_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act2_soldier_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act2_soldier_quest_story_one_02"
			}
		},
		pes_act2_hunter_quest_story_four_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act2_hunter_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act2_hunter_quest_story_four_01"
			}
		},
		pdr_act3_dwarf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_one_01"
			}
		},
		pwh_act3_wizard_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_wizard_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_wizard_quest_story_three_02"
			}
		},
		pbw_dialogue_response_20 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_20"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_20"
			}
		},
		pwh_dialogue_response_12 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_12"
			}
		},
		pbw_gameplay_response_21 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_response_21"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_response_21"
			}
		},
		pdr_act1_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_quest_story_one_02"
			}
		},
		pbw_dialogue_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_09"
			}
		},
		pes_dialogue_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_03"
			}
		},
		pdr_dialogue_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_09"
			}
		},
		pbw_act2_wizard_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act2_wizard_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act2_wizard_quest_story_two_02"
			}
		},
		pwh_dialogue_response_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_13"
			}
		},
		pbw_dialogue_response_11 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_11"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_11"
			}
		},
		pes_dialogue_response_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_09"
			}
		},
		pbw_gameplay_response_20 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_response_20"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_response_20"
			}
		},
		pes_dialogue_response_13 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_13"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_13"
			}
		},
		pdr_act1_soldier_quest_story_one_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_soldier_quest_story_one_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_soldier_quest_story_one_03"
			}
		},
		pdr_act1_soldier_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act1_soldier_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act1_soldier_quest_story_one_02"
			}
		},
		pwe_dialogue_07 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_07"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_07"
			}
		},
		pwe_dialogue_09_1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_09_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_09_1"
			}
		},
		pwe_dialogue_response_32 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_32"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_32"
			}
		},
		pbw_act3_elf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_elf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_elf_quest_story_two_02"
			}
		},
		pwh_act1_imprisonment_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act1_imprisonment_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act1_imprisonment_story_one_01"
			}
		},
		pwe_act3_elf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_three_02"
			}
		},
		pbw_dialogue_response_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_06"
			}
		},
		pes_dialogue_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_09"
			}
		},
		pwe_gameplay_killing_a_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_killing_a_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_killing_a_rat_ogre_01"
			}
		},
		pwh_act3_hunter_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act3_hunter_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act3_hunter_quest_story_three_01"
			}
		},
		pwe_act2_elf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_elf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_elf_quest_story_two_02"
			}
		},
		pes_dialogue_response_25 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_25"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_25"
			}
		},
		pwe_act1_soldier_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_soldier_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_soldier_quest_story_four_02"
			}
		},
		pdr_act3_dwarf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_two_01"
			}
		},
		pwe_act1_elf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_elf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_elf_quest_story_two_01"
			}
		},
		pbw_dialogue_response_15 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_15"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_15"
			}
		},
		pwh_act2_elf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_elf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_elf_quest_story_one_01"
			}
		},
		pwe_act1_elf_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_elf_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_elf_quest_story_four_02"
			}
		},
		pwh_gameplay_wizard_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_wizard_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_wizard_misses_bomb_01"
			}
		},
		pwe_act1_elf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_elf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_elf_quest_story_two_02"
			}
		},
		pdr_dialogue_14 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_14"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_14"
			}
		},
		pwe_act3_elf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_elf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_elf_quest_story_two_02"
			}
		},
		pwb_gameplay_response_18 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwb_gameplay_response_18"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "pwb_gameplay_response_18"
			}
		},
		pbw_dialogue_response_23 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_23"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_23"
			}
		},
		pwe_act3_dwarf_quest_story_three_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act3_dwarf_quest_story_three_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act3_dwarf_quest_story_three_03"
			}
		},
		pwh_act2_hunter_quest_story_six_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_act2_hunter_quest_story_six_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_act2_hunter_quest_story_six_02"
			}
		},
		pwe_act2_soldier_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act2_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act2_soldier_quest_story_four_01"
			}
		},
		pwh_dialogue_response_26 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_26"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_26"
			}
		},
		pdr_act3_dwarf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_dwarf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_dwarf_quest_story_two_02"
			}
		},
		pes_act1_soldier_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act1_soldier_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act1_soldier_quest_story_four_01"
			}
		},
		pdr_act3_soldier_quest_story_one_01_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_act3_soldier_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_act3_soldier_quest_story_one_01"
			}
		},
		pwe_dialogue_response_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_08"
			}
		},
		pwe_act1_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_quest_story_four_02"
			}
		},
		pdr_dialogue_response_26_1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_26_1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_26_1"
			}
		},
		pwh_dialogue_09 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_09"
			}
		},
		pbw_dialogue_08 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_08"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_08"
			}
		},
		pbw_act1_imprisonment_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act1_imprisonment_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act1_imprisonment_story_one_01"
			}
		},
		pwe_gameplay_ranger_misses_bomb_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "help_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_gameplay_ranger_misses_bomb_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "pwe_gameplay_ranger_misses_bomb_01"
			}
		},
		pdr_dialogue_response_32 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_32"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_32"
			}
		},
		pwh_gameplay_response_22 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "player_feedback",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_response_22"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_response_22"
			}
		},
		pes_dialogue_response_29 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_29"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_29"
			}
		},
		pdr_dialogue_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_01"
			}
		},
		pwe_act1_wizard_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_act1_wizard_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_act1_wizard_quest_story_two_02"
			}
		},
		pwh_dialogue_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_06"
			}
		},
		pwe_dialogue_response_22 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_22"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_22"
			}
		},
		pbw_act3_dwarf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_dwarf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_dwarf_quest_story_two_02"
			}
		},
		pes_act3_wizard_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_act3_wizard_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_act3_wizard_quest_story_two_02"
			}
		},
		pes_dialogue_response_17 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_dialogue_response_17"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_dialogue_response_17"
			}
		},
		pbw_dialogue_response_22 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_dialogue_response_22"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_dialogue_response_22"
			}
		},
		pbw_act3_wizard_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_act3_wizard_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_act3_wizard_quest_story_two_02"
			}
		},
		pwh_gameplay_killing_a_rat_ogre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_gameplay_killing_a_rat_ogre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_gameplay_killing_a_rat_ogre_01"
			}
		},
		pdr_dialogue_response_25 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_25"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_25"
			}
		},
		pdr_dialogue_12 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_12"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_12"
			}
		},
		pdr_dialogue_response_29 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_29"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_29"
			}
		},
		pes_gameplay_response_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_gameplay_response_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_gameplay_response_04"
			}
		},
		pwh_dialogue_09_forced = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_09"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_09"
			}
		},
		pdr_dialogue_response_18 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_dialogue_response_18"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_dialogue_response_18"
			}
		},
		pwh_dialogue_response_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_dialogue_response_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwh_dialogue_response_05"
			}
		},
		pwe_dialogue_response_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "player_conversations",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_dialogue_response_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_bored"
			},
			localization_strings = {
				[1.0] = "pwe_dialogue_response_02"
			}
		}
	})
end
