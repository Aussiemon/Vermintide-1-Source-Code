return function ()
	define_rule({
		response = "pdr_tutorial_dialogue_meeting_01",
		name = "pdr_tutorial_dialogue_meeting_01",
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
				"pdr_tutorial_dialogue_meeting_01"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_dialogue_meeting_01",
		name = "pwe_tutorial_dialogue_meeting_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_meeting_01"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_meeting_02",
		name = "pdr_tutorial_dialogue_meeting_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"pwe_tutorial_dialogue_meeting_01"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_dialogue_revive_01",
		name = "pwe_tutorial_dialogue_revive_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_meeting_02"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_revive_01",
		name = "pdr_tutorial_dialogue_revive_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_tutorial_dialogue_revive_01"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_dialogue_revive_02",
		name = "pwe_tutorial_dialogue_revive_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_revive_01"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_revive_02",
		name = "pdr_tutorial_dialogue_revive_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_tutorial_dialogue_revive_02"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_loot_01",
		name = "pdr_tutorial_dialogue_loot_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_tutorial_dialogue_revive_02"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_weather_01",
		name = "pdr_tutorial_dialogue_weather_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_loot_01"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_dialogue_weather_01",
		name = "pwe_tutorial_dialogue_weather_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_weather_01"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_weather_02",
		name = "pdr_tutorial_dialogue_weather_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_tutorial_dialogue_weather_01"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_dialogue_weather_02",
		name = "pwe_tutorial_dialogue_weather_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_weather_02"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_weather_03",
		name = "pdr_tutorial_dialogue_weather_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_tutorial_dialogue_weather_02"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_dialogue_weather_03",
		name = "pwe_tutorial_dialogue_weather_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_weather_03"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_weather_04",
		name = "pdr_tutorial_dialogue_weather_04",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_tutorial_dialogue_weather_03"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_dialogue_weather_04",
		name = "pwe_tutorial_dialogue_weather_04",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_weather_04"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_weather_05",
		name = "pdr_tutorial_dialogue_weather_05",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_tutorial_dialogue_weather_04"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_dialogue_weather_05",
		name = "pwe_tutorial_dialogue_weather_05",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_dialogue_weather_05"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_dialogue_weather_06",
		name = "pdr_tutorial_dialogue_weather_06",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_tutorial_dialogue_weather_05"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_battle_01",
		name = "pdr_tutorial_battle_01",
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
				"pdr_tutorial_battle_01"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_tutorial_battle_01",
		name = "pwe_tutorial_battle_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_tutorial_battle_01"
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
				"wood_elf",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pdr_tutorial_after_battle_01",
		name = "pdr_tutorial_after_battle_01",
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
				"pdr_tutorial_after_battle_01"
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
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"global_context",
				"current_level",
				OP.EQ,
				"tutorial"
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_intro",
		name = "pwe_mono_tutorial_intro",
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
				"tutorial_intro"
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
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_path",
		name = "pwe_mono_tutorial_path",
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
				"tutorial_path"
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
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_skaven_stink",
		name = "pwe_mono_tutorial_skaven_stink",
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
				"tutorial_skaven_stink"
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
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_ascending_jump",
		name = "pwe_mono_tutorial_ascending_jump",
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
				"tutorial_ascending_jump"
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
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_ascending_jump_reminder",
		name = "pwe_mono_tutorial_ascending_jump_reminder",
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
				"tutorial_ascending_jump_reminder"
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
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_spotting_skaven",
		name = "pwe_mono_tutorial_spotting_skaven",
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
				"tutorial_spotting_skaven"
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
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_general_battle",
		name = "pwe_mono_tutorial_general_battle",
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
				"tutorial_general_battle"
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
			}
		}
	})
	define_rule({
		name = "pwe_mono_tutorial_armour_hit",
		response = "pwe_mono_tutorial_armour_hit",
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
				"tutorial_armour_hit"
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
				"time_since_last_tutorial_armour_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_tutorial_armour_hit",
				OP.TIMEDIFF
			}
		}
	})
	define_rule({
		name = "pwe_mono_tutorial_armour_attack",
		response = "pwe_mono_tutorial_armour_attack",
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
				"tutorial_armour_attack"
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
				"user_memory",
				"time_since_tutorial_armour_attack",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_tutorial_armour_attack",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_swap_to_bow",
		name = "pwe_mono_tutorial_swap_to_bow",
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
				"tutorial_swap_to_bow"
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
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_long_range",
		name = "pwe_mono_tutorial_long_range",
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
				"tutorial_long_range"
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
			}
		}
	})
	define_rule({
		name = "pwe_mono_tutorial_parry",
		response = "pwe_mono_tutorial_parry",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
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
				"tutorial_parry"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_last_tutorial_parry",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_tutorial_parry",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_mono_tutorial_geting_hit",
		response = "pwe_mono_tutorial_geting_hit",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"target_name",
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
				"user_memory",
				"time_since_tutorial_geting_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_tutorial_geting_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_mono_tutorial_pushing",
		response = "pwe_mono_tutorial_pushing",
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
				"tutorial_pushing"
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
				"time_since_last_tutorial_pushing",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_tutorial_pushing",
				OP.TIMEDIFF
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_kill_remaining",
		name = "pwe_mono_tutorial_kill_remaining",
		criterias = {
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
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"tutorial_kill_remaining"
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_spotting_camp",
		name = "pwe_mono_tutorial_spotting_camp",
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
				"tutorial_spotting_camp"
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
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"tutorial_spotting_camp"
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_spotting_grenade",
		name = "pwe_mono_tutorial_spotting_grenade",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bomb"
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
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"tutorial_spotting_grenade"
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_speed_potion",
		name = "pwe_mono_tutorial_speed_potion",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"potion"
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
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"tutorial_speed_potion"
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_strength_potion",
		name = "pwe_mono_tutorial_strength_potion",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"potion"
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
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"tutorial_strength_potion"
			}
		}
	})
	define_rule({
		response = "pwe_mono_tutorial_healing_draught",
		name = "pwe_mono_tutorial_healing_draught",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
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
				"tutorial_healing_draught"
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
			}
		}
	})
	add_dialogues({
		pwe_mono_tutorial_armour_hit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "tutorial",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_mono_tutorial_armour_hit_01",
				"pwe_mono_tutorial_armour_hit_02",
				"pwe_mono_tutorial_armour_hit_03",
				"pwe_mono_tutorial_armour_hit_04"
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
				"pwe_mono_tutorial_armour_hit_01",
				"pwe_mono_tutorial_armour_hit_02",
				"pwe_mono_tutorial_armour_hit_03",
				"pwe_mono_tutorial_armour_hit_04"
			},
			randomize_indexes = {}
		},
		pdr_tutorial_dialogue_weather_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_weather_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_weather_01"
			}
		},
		pdr_tutorial_dialogue_revive_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_revive_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_revive_02"
			}
		},
		pwe_tutorial_dialogue_weather_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_dialogue_weather_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_dialogue_weather_05"
			}
		},
		pwe_mono_tutorial_kill_remaining = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "tutorial",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_kill_remaining_01",
				[2.0] = "pwe_mono_tutorial_kill_remaining_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned",
				[2.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_kill_remaining_01",
				[2.0] = "pwe_mono_tutorial_kill_remaining_02"
			},
			randomize_indexes = {}
		},
		pwe_mono_tutorial_long_range = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "tutorial",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_long_range_01",
				[2.0] = "pwe_mono_tutorial_long_range_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned",
				[2.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_long_range_01",
				[2.0] = "pwe_mono_tutorial_long_range_02"
			},
			randomize_indexes = {}
		},
		pwe_tutorial_dialogue_meeting_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_dialogue_meeting_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_dialogue_meeting_01"
			}
		},
		pdr_tutorial_dialogue_weather_06 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_weather_06"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_weather_06"
			}
		},
		pwe_tutorial_dialogue_weather_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_dialogue_weather_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_dialogue_weather_02"
			}
		},
		pdr_tutorial_after_battle_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_after_battle_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_after_battle_01"
			}
		},
		pdr_tutorial_dialogue_weather_05 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_weather_05"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_weather_05"
			}
		},
		pwe_mono_tutorial_speed_potion = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "seen_items",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_speed_potion"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_speed_potion"
			}
		},
		pwe_mono_tutorial_healing_draught = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "seen_items",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_healing_draught"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_healing_draught"
			}
		},
		pwe_mono_tutorial_strength_potion = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "seen_items",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_strength_potion"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_strength_potion"
			}
		},
		pwe_mono_tutorial_spotting_grenade = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "tutorial",
			category = "seen_items",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_spotting_grenade_01",
				[2.0] = "pwe_mono_tutorial_spotting_grenade_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout",
				[2.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_happy",
				[2.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_spotting_grenade_01",
				[2.0] = "pwe_mono_tutorial_spotting_grenade_02"
			},
			randomize_indexes = {}
		},
		pdr_tutorial_dialogue_meeting_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_meeting_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_meeting_01"
			}
		},
		pdr_tutorial_dialogue_meeting_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_meeting_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_meeting_02"
			}
		},
		pwe_tutorial_dialogue_weather_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_dialogue_weather_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_dialogue_weather_04"
			}
		},
		pwe_tutorial_dialogue_weather_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_dialogue_weather_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_dialogue_weather_03"
			}
		},
		pwe_tutorial_dialogue_revive_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_dialogue_revive_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_dialogue_revive_02"
			}
		},
		pwe_mono_tutorial_pushing = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "tutorial",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_mono_tutorial_pushing_01",
				"pwe_mono_tutorial_pushing_02",
				"pwe_mono_tutorial_pushing_03",
				"pwe_mono_tutorial_pushing_04"
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
				"pwe_mono_tutorial_pushing_01",
				"pwe_mono_tutorial_pushing_02",
				"pwe_mono_tutorial_pushing_03",
				"pwe_mono_tutorial_pushing_04"
			},
			randomize_indexes = {}
		},
		pdr_tutorial_dialogue_weather_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_weather_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_weather_02"
			}
		},
		pwe_mono_tutorial_path = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_path_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_path_01"
			}
		},
		pwe_mono_tutorial_parry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "tutorial",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_mono_tutorial_parry_01",
				"pwe_mono_tutorial_parry_02",
				"pwe_mono_tutorial_parry_03",
				"pwe_mono_tutorial_parry_04"
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
				"pwe_mono_tutorial_parry_01",
				"pwe_mono_tutorial_parry_02",
				"pwe_mono_tutorial_parry_03",
				"pwe_mono_tutorial_parry_04"
			},
			randomize_indexes = {}
		},
		pdr_tutorial_battle_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_battle_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_battle_01"
			}
		},
		pwe_mono_tutorial_armour_attack = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "tutorial",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_mono_tutorial_armour_attack_01",
				"pwe_mono_tutorial_armour_attack_02",
				"pwe_mono_tutorial_armour_attack_03",
				"pwe_mono_tutorial_armour_attack_04"
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
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwe_mono_tutorial_armour_attack_01",
				"pwe_mono_tutorial_armour_attack_02",
				"pwe_mono_tutorial_armour_attack_03",
				"pwe_mono_tutorial_armour_attack_04"
			},
			randomize_indexes = {}
		},
		pwe_tutorial_dialogue_weather_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_dialogue_weather_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_dialogue_weather_01"
			}
		},
		pwe_tutorial_dialogue_revive_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_dialogue_revive_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_dialogue_revive_01"
			}
		},
		pwe_mono_tutorial_geting_hit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "tutorial",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_mono_tutorial_geting_hit_01",
				"pwe_mono_tutorial_geting_hit_02",
				"pwe_mono_tutorial_geting_hit_03",
				"pwe_mono_tutorial_geting_hit_04"
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
				"pwe_mono_tutorial_geting_hit_01",
				"pwe_mono_tutorial_geting_hit_02",
				"pwe_mono_tutorial_geting_hit_03",
				"pwe_mono_tutorial_geting_hit_04"
			},
			randomize_indexes = {}
		},
		pdr_tutorial_dialogue_weather_04 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_weather_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_weather_04"
			}
		},
		pwe_mono_tutorial_ascending_jump = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_ascending_jump"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_calm"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_ascending_jump"
			}
		},
		pwe_mono_tutorial_general_battle = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_general_battle"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_general_battle"
			}
		},
		pdr_tutorial_dialogue_loot_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_loot_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_loot_01"
			}
		},
		pwe_mono_tutorial_spotting_skaven = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_spotting_skaven"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_spotting_skaven"
			}
		},
		pdr_tutorial_dialogue_revive_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_revive_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_revive_01"
			}
		},
		pwe_tutorial_battle_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_tutorial_battle_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_tutorial_battle_01"
			}
		},
		pwe_mono_tutorial_swap_to_bow = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "tutorial",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_swap_to_bow_01",
				[2.0] = "pwe_mono_tutorial_swap_to_bow_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned",
				[2.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_swap_to_bow_01",
				[2.0] = "pwe_mono_tutorial_swap_to_bow_02"
			},
			randomize_indexes = {}
		},
		pdr_tutorial_dialogue_weather_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_tutorial_dialogue_weather_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_tutorial_dialogue_weather_03"
			}
		},
		pwe_mono_tutorial_ascending_jump_reminder = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_ascending_jump_reminder"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_ascending_jump_reminder"
			}
		},
		pwe_mono_tutorial_intro = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_intro_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_intro_01"
			}
		},
		pwe_mono_tutorial_skaven_stink = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_skaven_stink"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_skaven_stink"
			}
		},
		pwe_mono_tutorial_spotting_camp = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "tutorial",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_mono_tutorial_spotting_camp"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_mono_tutorial_spotting_camp"
			}
		}
	})

	return 
end
