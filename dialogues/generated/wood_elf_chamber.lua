return function ()
	define_rule({
		name = "pwe_level_chamber_attacked",
		response = "pwe_level_chamber_attacked",
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
				"objective_chamber_attacked"
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
				"chamber_attacked",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"chamber_attacked",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_chandelier",
		response = "pwe_level_chamber_chandelier",
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
				"objective_chamber_chandelier"
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
				"time_since_objective_chamber_chandelier",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_chamber_chandelier",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_all_clear",
		response = "pwe_level_chamber_all_clear",
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
				"objective_chamber_all_clear"
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
				"time_since_chamber_cellar",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_cellar",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_chamber_lohner_room",
		response = "pwe_objective_chamber_lohner_room",
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
				"objective_chamber_lohner_room"
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
				"time_since_chamber_lohner_room",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_lohner_room",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_chamber_pig",
		response = "pwe_objective_chamber_pig",
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
				"objective_chamber_pig"
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
				"time_since_chamber_pig",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_pig",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_chamber_paintings_old",
		response = "pwe_objective_chamber_paintings_old",
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
				"objective_chamber_paintings_old"
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
				"time_since_objective_chamber_paintings_old",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_chamber_paintings_old",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_chamber_paintings_new",
		response = "pwe_objective_chamber_paintings_new",
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
				"objective_chamber_paintings_new"
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
				"time_since_objective_chamber_paintings_new",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_chamber_paintings_new",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_olesya_room",
		response = "pwe_level_chamber_olesya_room",
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
				"objective_chamber_olesya_room"
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
				"time_since_objective_chamber_olesya_room",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_chamber_olesya_room",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_chamber_barrels",
		response = "pwe_objective_chamber_barrels",
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
				"objective_chamber_barrels"
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
				"time_since_objective_chamber_barrels",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_chamber_barrels",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_chamber_sacks",
		response = "pwe_objective_chamber_sacks",
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
				"objective_chamber_sacks"
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
				"time_since_objective_chamber_sacks",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_chamber_sacks",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_chamber_beer",
		response = "pwe_objective_chamber_beer",
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
				"objective_chamber_beer"
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
				"time_since_objective_chamber_beer",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_chamber_beer",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_press_on",
		response = "pwe_level_chamber_press_on",
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
				"objective_chamber_press_on"
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
				"time_since_chamber_press_on",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_press_on",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_supplies",
		response = "pwe_level_chamber_supplies",
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
				"objective_chamber_supplies"
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
				"time_since_chamber_supplies",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_supplies",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_sewers",
		response = "pwe_level_chamber_sewers",
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
				"objective_chamber_sewers"
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
				"time_since_chamber_sewers",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_sewers",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_tight",
		response = "pwe_level_chamber_tight",
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
				"objective_chamber_tight"
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
				"time_since_chamber_tight",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_tight",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_pipe",
		response = "pwe_level_chamber_pipe",
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
				"objective_chamber_pipe"
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
				"time_since_chamber_pipe",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_pipe",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_lair",
		response = "pwe_level_chamber_lair",
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
				"objective_chamber_lair"
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
				"time_since_chamber_lair",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_lair",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_machines",
		response = "pwe_level_chamber_machines",
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
				"objective_chamber_machines"
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
				"time_since_chamber_machines",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_machines",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_bad_feeling",
		response = "pwe_level_chamber_bad_feeling",
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
				"objective_chamber_bad_feeling"
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
				"time_since_chamber_bad_feeling",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_bad_feeling",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_gate",
		response = "pwe_level_chamber_gate",
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
				"objective_chamber_gate"
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
				"time_since_chamber_gate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_gate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_bridge",
		response = "pwe_level_chamber_bridge",
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
				"objective_chamber_bridge"
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
				"time_since_chamber_bridge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_bridge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_chamber_intro_a",
		response = "pwe_chamber_intro_a",
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
				"objective_chamber_intro"
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
				"time_since_chamber_intro_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_intro_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_chamber_intro_b",
		response = "pwe_chamber_intro_b",
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
				"chamber_intro_a"
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
				"time_since_chamber_intro_b",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_chamber_intro_b",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_lohner_cellar_a",
		response = "pwe_level_chamber_lohner_cellar_a",
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
				"level_chamber_lohner_cellar_a"
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
				"level_chamber_lohner_cellar_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_lohner_cellar_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_lohner_cellar_c",
		response = "pwe_level_chamber_lohner_cellar_c",
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
				"level_chamber_lohner_cellar_b"
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
				"level_chamber_lohner_cellar_c",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_lohner_cellar_c",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_lohner_cellar_talk_more_a",
		response = "pwe_level_chamber_lohner_cellar_talk_more_a",
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
				"level_chamber_lohner_cellar_talk_more_a"
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
				"level_chamber_lohner_cellar_talk_more_a",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_lohner_cellar_talk_more_a",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_lohner_cellar_talk_more_c",
		response = "pwe_level_chamber_lohner_cellar_talk_more_c",
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
				"level_chamber_lohner_cellar_talk_more_b"
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
				"level_chamber_lohner_cellar_talk_more_c",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_lohner_cellar_talk_more_c",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_olesya_cellar_kerillian",
		response = "pwe_level_chamber_olesya_cellar_kerillian",
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
				"level_chamber_olesya_cellar"
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
				"level_chamber_olesya_cellar",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_olesya_cellar",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_olesya_cellar_kerillian_talk_more",
		response = "pwe_level_chamber_olesya_cellar_kerillian_talk_more",
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
				"level_chamber_olesya_cellar_talk_more"
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
				"level_chamber_olesya_cellar_talk_more",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_olesya_cellar_talk_more",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_flask_kerillian",
		response = "pwe_level_chamber_flask_kerillian",
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
				"level_chamber_flask"
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
				"level_chamber_flask",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_flask",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_rasknitt_sighted_a",
		response = "pwe_level_chamber_rasknitt_sighted_a",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"egs_objective_presentation_01"
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
				"level_chamber_rasknitt_sighted_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_rasknitt_sighted_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_rasknitt_flees_one_a",
		response = "pwe_level_chamber_rasknitt_flees_one_a",
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
				"level_chamber_rasknitt_flees_one_a"
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
				"level_chamber_rasknitt_flees_one_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_rasknitt_flees_one_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_rasknitt_flees_three_a",
		response = "pwe_level_chamber_rasknitt_flees_three_a",
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
				"level_chamber_rasknitt_flees_three_a"
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
				"level_chamber_rasknitt_flees_three_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_rasknitt_flees_three_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_rasknitt_flees_two_a",
		response = "pwe_level_chamber_rasknitt_flees_two_a",
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
				"level_chamber_rasknitt_flees_two_a"
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
				"level_chamber_rasknitt_flees_two_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"level_chamber_rasknitt_flees_two_a",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_level_chamber_rasknitt_ward",
		response = "pwe_level_chamber_rasknitt_ward",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.EQ,
				"egs_objective_hit_01"
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
				"chamber_rasknitt_ward",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"chamber_rasknitt_ward",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwe_level_chamber_gate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_gate_01",
				"pwe_level_chamber_gate_02",
				"pwe_level_chamber_gate_03",
				"pwe_level_chamber_gate_04"
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
				"pwe_level_chamber_gate_01",
				"pwe_level_chamber_gate_02",
				"pwe_level_chamber_gate_03",
				"pwe_level_chamber_gate_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_chamber_beer = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_objective_chamber_beer_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_objective_chamber_beer_01"
			}
		},
		pwe_level_chamber_all_clear = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_cellar_01",
				"pwe_level_chamber_cellar_02",
				"pwe_level_chamber_cellar_03",
				"pwe_level_chamber_cellar_04"
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
				"pwe_level_chamber_cellar_01",
				"pwe_level_chamber_cellar_02",
				"pwe_level_chamber_cellar_03",
				"pwe_level_chamber_cellar_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_lohner_cellar_talk_more_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_level_chamber_lohner_cellar_talk_more_c_01",
				[2.0] = "pwe_level_chamber_lohner_cellar_talk_more_c_02"
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
				[1.0] = "pwe_level_chamber_lohner_cellar_talk_more_c_01",
				[2.0] = "pwe_level_chamber_lohner_cellar_talk_more_c_02"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_lohner_cellar_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_level_chamber_lohner_cellar_c_01",
				[2.0] = "pwe_level_chamber_lohner_cellar_c_02"
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
				[1.0] = "pwe_level_chamber_lohner_cellar_c_01",
				[2.0] = "pwe_level_chamber_lohner_cellar_c_02"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_olesya_cellar_kerillian = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_level_chamber_olesya_cellar_kerillian_01",
				[2.0] = "pwe_level_chamber_olesya_cellar_kerillian_02"
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
				[1.0] = "pwe_level_chamber_olesya_cellar_kerillian_01",
				[2.0] = "pwe_level_chamber_olesya_cellar_kerillian_02"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_bad_feeling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_bad_feeling_01",
				"pwe_level_chamber_bad_feeling_02",
				"pwe_level_chamber_bad_feeling_03",
				"pwe_level_chamber_bad_feeling_04"
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
				"pwe_level_chamber_bad_feeling_01",
				"pwe_level_chamber_bad_feeling_02",
				"pwe_level_chamber_bad_feeling_03",
				"pwe_level_chamber_bad_feeling_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_press_on = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_press_on_01",
				"pwe_level_chamber_press_on_02",
				"pwe_level_chamber_press_on_03",
				"pwe_level_chamber_press_on_04"
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
				"pwe_level_chamber_press_on_01",
				"pwe_level_chamber_press_on_02",
				"pwe_level_chamber_press_on_03",
				"pwe_level_chamber_press_on_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_pipe = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_pipe_01",
				"pwe_level_chamber_pipe_02",
				"pwe_level_chamber_pipe_03",
				"pwe_level_chamber_pipe_04"
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
				"pwe_level_chamber_pipe_01",
				"pwe_level_chamber_pipe_02",
				"pwe_level_chamber_pipe_03",
				"pwe_level_chamber_pipe_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_chandelier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_chandelier_01",
				"pwe_level_chamber_chandelier_02",
				"pwe_level_chamber_chandelier_03",
				"pwe_level_chamber_chandelier_04"
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
				"pwe_level_chamber_chandelier_01",
				"pwe_level_chamber_chandelier_02",
				"pwe_level_chamber_chandelier_03",
				"pwe_level_chamber_chandelier_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_supplies = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_supplies_01",
				"pwe_level_chamber_supplies_02",
				"pwe_level_chamber_supplies_03",
				"pwe_level_chamber_supplies_04"
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
				"pwe_level_chamber_supplies_01",
				"pwe_level_chamber_supplies_02",
				"pwe_level_chamber_supplies_03",
				"pwe_level_chamber_supplies_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_lohner_cellar_a = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_level_chamber_lohner_cellar_a_01",
				[2.0] = "pwe_level_chamber_lohner_cellar_a_02"
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
				[1.0] = "pwe_level_chamber_lohner_cellar_a_01",
				[2.0] = "pwe_level_chamber_lohner_cellar_a_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_chamber_pig = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_objective_chamber_pig_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_curious"
			},
			localization_strings = {
				[1.0] = "pwe_objective_chamber_pig_01"
			}
		},
		pwe_objective_chamber_paintings_old = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_objective_chamber_paintings_old_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_objective_chamber_paintings_old_01"
			}
		},
		pwe_objective_chamber_barrels = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_objective_chamber_barrels_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_curious"
			},
			localization_strings = {
				[1.0] = "pwe_objective_chamber_barrels_01"
			}
		},
		pwe_objective_chamber_sacks = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_objective_chamber_sacks_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_curious"
			},
			localization_strings = {
				[1.0] = "pwe_objective_chamber_sacks_01"
			}
		},
		pwe_level_chamber_tight = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_tight_01",
				"pwe_level_chamber_tight_02",
				"pwe_level_chamber_tight_03",
				"pwe_level_chamber_tight_04"
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
				"pwe_level_chamber_tight_01",
				"pwe_level_chamber_tight_02",
				"pwe_level_chamber_tight_03",
				"pwe_level_chamber_tight_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_olesya_room = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_olesya_room_01",
				"pwe_level_chamber_olesya_room_02",
				"pwe_level_chamber_olesya_room_03",
				"pwe_level_chamber_olesya_room_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_curious",
				"face_curious",
				"face_curious",
				"face_curious"
			},
			localization_strings = {
				"pwe_level_chamber_olesya_room_01",
				"pwe_level_chamber_olesya_room_02",
				"pwe_level_chamber_olesya_room_03",
				"pwe_level_chamber_olesya_room_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_machines = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_machines_01",
				"pwe_level_chamber_machines_02",
				"pwe_level_chamber_machines_03",
				"pwe_level_chamber_machines_04"
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
				"pwe_level_chamber_machines_01",
				"pwe_level_chamber_machines_02",
				"pwe_level_chamber_machines_03",
				"pwe_level_chamber_machines_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_olesya_cellar_kerillian_talk_more = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_level_chamber_olesya_cellar_kerillian_talk_more_01",
				[2.0] = "pwe_level_chamber_olesya_cellar_kerillian_talk_more_02"
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
				[1.0] = "pwe_level_chamber_olesya_cellar_kerillian_talk_more_01",
				[2.0] = "pwe_level_chamber_olesya_cellar_kerillian_talk_more_02"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_rasknitt_flees_two_a = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_rasknitt_flees_two_a_01",
				"pwe_level_chamber_rasknitt_flees_two_a_02",
				"pwe_level_chamber_rasknitt_flees_two_a_03",
				"pwe_level_chamber_rasknitt_flees_two_a_04"
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
				"pwe_level_chamber_rasknitt_flees_two_a_01",
				"pwe_level_chamber_rasknitt_flees_two_a_02",
				"pwe_level_chamber_rasknitt_flees_two_a_03",
				"pwe_level_chamber_rasknitt_flees_two_a_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_bridge_01",
				"pwe_level_chamber_bridge_02",
				"pwe_level_chamber_bridge_03",
				"pwe_level_chamber_bridge_04"
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
				"pwe_level_chamber_bridge_01",
				"pwe_level_chamber_bridge_02",
				"pwe_level_chamber_bridge_03",
				"pwe_level_chamber_bridge_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_sewers = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_sewers_01",
				"pwe_level_chamber_sewers_02",
				"pwe_level_chamber_sewers_03",
				"pwe_level_chamber_sewers_04"
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
				"pwe_level_chamber_sewers_01",
				"pwe_level_chamber_sewers_02",
				"pwe_level_chamber_sewers_03",
				"pwe_level_chamber_sewers_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_flask_kerillian = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_level_chamber_flask_kerillian_01",
				[2.0] = "pwe_level_chamber_flask_kerillian_02"
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
				[1.0] = "pwe_level_chamber_flask_kerillian_01",
				[2.0] = "pwe_level_chamber_flask_kerillian_02"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_rasknitt_ward = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_rasknitt_ward_01",
				"pwe_level_chamber_rasknitt_ward_02",
				"pwe_level_chamber_rasknitt_ward_03",
				"pwe_level_chamber_rasknitt_ward_04"
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
				"pwe_level_chamber_rasknitt_ward_01",
				"pwe_level_chamber_rasknitt_ward_02",
				"pwe_level_chamber_rasknitt_ward_03",
				"pwe_level_chamber_rasknitt_ward_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_chamber_paintings_new = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_objective_chamber_paintings_new_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_objective_chamber_paintings_new_01"
			}
		},
		pwe_level_chamber_rasknitt_flees_three_a = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_rasknitt_flees_three_a_01",
				"pwe_level_chamber_rasknitt_flees_three_a_02",
				"pwe_level_chamber_rasknitt_flees_three_a_03",
				"pwe_level_chamber_rasknitt_flees_three_a_04"
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
				"pwe_level_chamber_rasknitt_flees_three_a_01",
				"pwe_level_chamber_rasknitt_flees_three_a_02",
				"pwe_level_chamber_rasknitt_flees_three_a_03",
				"pwe_level_chamber_rasknitt_flees_three_a_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_attacked = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_rat_ogre_01",
				"pwe_level_chamber_rat_ogre_02",
				"pwe_level_chamber_rat_ogre_03",
				"pwe_level_chamber_rat_ogre_04"
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
				"pwe_level_chamber_rat_ogre_01",
				"pwe_level_chamber_rat_ogre_02",
				"pwe_level_chamber_rat_ogre_03",
				"pwe_level_chamber_rat_ogre_04"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_rasknitt_flees_one_a = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_rasknitt_flees_one_a_01",
				"pwe_level_chamber_rasknitt_flees_one_a_02",
				"pwe_level_chamber_rasknitt_flees_one_a_03",
				"pwe_level_chamber_rasknitt_flees_one_a_04"
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
				"pwe_level_chamber_rasknitt_flees_one_a_01",
				"pwe_level_chamber_rasknitt_flees_one_a_02",
				"pwe_level_chamber_rasknitt_flees_one_a_03",
				"pwe_level_chamber_rasknitt_flees_one_a_04"
			},
			randomize_indexes = {}
		},
		pwe_chamber_intro_a = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_chamber_intro_a_01",
				[2.0] = "pwe_chamber_intro_a_02"
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
				[1.0] = "pwe_chamber_intro_a_01",
				[2.0] = "pwe_chamber_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_rasknitt_sighted_a = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_rasknitt_sighted_a_01",
				"pwe_level_chamber_rasknitt_sighted_a_02",
				"pwe_level_chamber_rasknitt_sighted_a_03",
				"pwe_level_chamber_rasknitt_sighted_a_04"
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
				"pwe_level_chamber_rasknitt_sighted_a_01",
				"pwe_level_chamber_rasknitt_sighted_a_02",
				"pwe_level_chamber_rasknitt_sighted_a_03",
				"pwe_level_chamber_rasknitt_sighted_a_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_chamber_lohner_room = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_objective_chamber_lohner_room_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_curious"
			},
			localization_strings = {
				[1.0] = "pwe_objective_chamber_lohner_room_01"
			}
		},
		pwe_chamber_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "player_alerts_boss",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_chamber_intro_b_01",
				[2.0] = "pwe_chamber_intro_b_02"
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
				[1.0] = "pwe_chamber_intro_b_01",
				[2.0] = "pwe_chamber_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_lohner_cellar_talk_more_a = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_level_chamber_lohner_cellar_talk_more_a_01",
				[2.0] = "pwe_level_chamber_lohner_cellar_talk_more_a_02"
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
				[1.0] = "pwe_level_chamber_lohner_cellar_talk_more_a_01",
				[2.0] = "pwe_level_chamber_lohner_cellar_talk_more_a_02"
			},
			randomize_indexes = {}
		},
		pwe_level_chamber_lair = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "wood_elf_chamber",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_level_chamber_lair_01",
				"pwe_level_chamber_lair_02",
				"pwe_level_chamber_lair_03",
				"pwe_level_chamber_lair_04"
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
				"pwe_level_chamber_lair_01",
				"pwe_level_chamber_lair_02",
				"pwe_level_chamber_lair_03",
				"pwe_level_chamber_lair_04"
			},
			randomize_indexes = {}
		}
	})
end
