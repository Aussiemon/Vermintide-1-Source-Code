return function ()
	define_rule({
		name = "pwh_objective_stromdorf_town_enter_stromdorf",
		response = "pwh_objective_stromdorf_town_enter_stromdorf",
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
				"objective_stromdorf_town_enter_stromdorf"
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
				"time_since_objective_stromdorf_town_enter_stromdorf",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_enter_stromdorf",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_seeing_field_of_verena",
		response = "pwh_objective_stromdorf_town_seeing_field_of_verena",
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
				"objective_stromdorf_town_seeing_field_of_verena"
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
				"time_since_objective_stromdorf_town_seeing_field_of_verena",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_seeing_field_of_verena",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_entering_reikland_gate",
		response = "pwh_objective_stromdorf_town_entering_reikland_gate",
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
				"objective_stromdorf_town_entering_reikland_gate"
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
				"time_since_objective_stromdorf_town_entering_reikland_gate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_entering_reikland_gate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_find_tannery",
		response = "pwh_objective_stromdorf_town_find_tannery",
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
				"objective_stromdorf_town_find_tannery"
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
				"time_since_objective_stromdorf_town_find_tannery",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_find_tannery",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_seeing_stewpot_hostelry",
		response = "pwh_objective_stromdorf_town_seeing_stewpot_hostelry",
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
				"objective_stromdorf_town_seeing_stewpot_hostelry"
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
				"time_since_objective_stromdorf_town_seeing_stewpot_hostelry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_seeing_stewpot_hostelry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_seeing_thunderwater",
		response = "pwh_objective_stromdorf_town_seeing_thunderwater",
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
				"objective_stromdorf_town_seeing_thunderwater"
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
				"time_since_objective_stromdorf_town_seeing_thunderwater",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_seeing_thunderwater",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_seeing_well",
		response = "pwh_objective_stromdorf_town_seeing_well",
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
				"objective_stromdorf_town_seeing_well"
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
				"time_since_objective_stromdorf_town_seeing_well",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_seeing_well",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_seeing_barber_surgeon",
		response = "pwh_objective_stromdorf_town_seeing_barber_surgeon",
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
				"objective_stromdorf_town_seeing_barber_surgeon"
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
				"time_since_objective_stromdorf_town_seeing_barber_surgeon",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_seeing_barber_surgeon",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_seeing_tannery",
		response = "pwh_objective_stromdorf_town_seeing_tannery",
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
				"objective_stromdorf_town_seeing_tannery"
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
				"time_since_objective_stromdorf_town_seeing_tannery",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_seeing_tannery",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_kill_emissary",
		response = "pwh_objective_stromdorf_town_kill_emissary",
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
				"objective_stromdorf_town_kill_emissary"
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
				"time_since_objective_stromdorf_town_kill_emissary",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_kill_emissary",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_emissary_dead",
		response = "pwh_objective_stromdorf_town_emissary_dead",
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
				"objective_stromdorf_town_emissary_dead"
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
				"time_since_objective_stromdorf_town_emissary_dead",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_emissary_dead",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_go_to_olesya",
		response = "pwh_objective_stromdorf_town_go_to_olesya",
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
				"objective_stromdorf_town_go_to_olesya"
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
				"time_since_objective_stromdorf_town_go_to_olesya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_go_to_olesya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_fleeing",
		response = "pwh_objective_stromdorf_town_fleeing",
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
				"objective_stromdorf_town_fleeing"
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
				"time_since_objective_stromdorf_town_fleeing",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_fleeing",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_emissary_anticipation",
		response = "pwh_objective_stromdorf_town_emissary_anticipation",
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
				"objective_stromdorf_town_emissary_anticipation"
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
				"time_since_objective_stromdorf_town_emissary_anticipation",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_emissary_anticipation",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_chieftain_charge_attack_taunt",
		response = "pwh_gameplay_chieftain_charge_attack_taunt",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_attack"
			},
			{
				"query_context",
				"attack_tag",
				OP.EQ,
				"special_lunge_attack"
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
				"last_played_special_lunge_attack_taunt",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_played_special_lunge_attack_taunt",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_chieftain_cleave_attack_taunt",
		response = "pwh_gameplay_chieftain_cleave_attack_taunt",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_attack"
			},
			{
				"query_context",
				"attack_tag",
				OP.EQ,
				"special_attack_cleave"
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
				"last_played_special_attack_cleave",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_played_special_attack_cleave",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_intro_a",
		response = "pwh_objective_stromdorf_town_intro_a",
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
				OP.LT,
				3
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
		name = "pwh_objective_stromdorf_town_intro_b",
		response = "pwh_objective_stromdorf_town_intro_b",
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
				"objective_stromdorf_town_intro_a"
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
				OP.LT,
				3
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
		name = "pwh_objective_stromdorf_town_intro_c",
		response = "pwh_objective_stromdorf_town_intro_c",
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
				"objective_stromdorf_town_intro_b"
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
				OP.LT,
				3
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_chieftain_tips_special_attack_cleave",
		response = "pwh_gameplay_chieftain_tips_special_attack_cleave",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_attack"
			},
			{
				"query_context",
				"attack_hit",
				OP.EQ,
				1
			},
			{
				"query_context",
				"attack_tag",
				OP.EQ,
				"special_attack_cleave"
			},
			{
				"user_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"target_name",
				OP.NEQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_last_special_attack_cleave_hit",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_special_attack_cleave_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_chieftain_tips_special_lunge_attack_2",
		response = "pwh_gameplay_chieftain_tips_special_lunge_attack_2",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_attack"
			},
			{
				"query_context",
				"attack_hit",
				OP.EQ,
				1
			},
			{
				"query_context",
				"attack_tag",
				OP.EQ,
				"special_lunge_attack_2"
			},
			{
				"user_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"target_name",
				OP.NEQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_last_special_lunge_attack_2_hit",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_special_lunge_attack_2_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_chieftain_banter_reply",
		response = "pwh_gameplay_chieftain_banter_reply",
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
				"gameplay_banter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_gameplay_banter",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_gameplay_banter",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_stromdorf_town_intro_a_gt",
		response = "pwh_objective_stromdorf_town_intro_a_gt",
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
				6
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
		name = "pwh_objective_stromdorf_town_intro_b_gt",
		response = "pwh_objective_stromdorf_town_intro_b_gt",
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
				"objective_stromdorf_town_intro_a_gt"
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
				6
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
		name = "pwh_objective_stromdorf_town_intro_c_gt",
		response = "pwh_objective_stromdorf_town_intro_c_gt",
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
				"objective_stromdorf_town_intro_b_gt"
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
				6
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_gameplay_chieftain_tips_special_lunge_attack_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_chieftain_tips_01",
				"pwh_gameplay_chieftain_tips_02",
				"pwh_gameplay_chieftain_tips_03",
				"pwh_gameplay_chieftain_tips_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_gameplay_chieftain_tips_01",
				"pwh_gameplay_chieftain_tips_02",
				"pwh_gameplay_chieftain_tips_03",
				"pwh_gameplay_chieftain_tips_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_emissary_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_emissary_dead_01",
				"pwh_objective_stromdorf_town_emissary_dead_02",
				"pwh_objective_stromdorf_town_emissary_dead_03",
				"pwh_objective_stromdorf_town_emissary_dead_04"
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
				"pwh_objective_stromdorf_town_emissary_dead_01",
				"pwh_objective_stromdorf_town_emissary_dead_02",
				"pwh_objective_stromdorf_town_emissary_dead_03",
				"pwh_objective_stromdorf_town_emissary_dead_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_emissary_anticipation = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_emissary_anticipation_01",
				"pwh_objective_stromdorf_town_emissary_anticipation_02",
				"pwh_objective_stromdorf_town_emissary_anticipation_03",
				"pwh_objective_stromdorf_town_emissary_anticipation_04"
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
				"pwh_objective_stromdorf_town_emissary_anticipation_01",
				"pwh_objective_stromdorf_town_emissary_anticipation_02",
				"pwh_objective_stromdorf_town_emissary_anticipation_03",
				"pwh_objective_stromdorf_town_emissary_anticipation_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_chieftain_cleave_attack_taunt = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_chieftain_cleave_attack_taunt_01",
				"pwh_gameplay_chieftain_cleave_attack_taunt_02",
				"pwh_gameplay_chieftain_cleave_attack_taunt_03",
				"pwh_gameplay_chieftain_cleave_attack_taunt_04"
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
				"pwh_gameplay_chieftain_cleave_attack_taunt_01",
				"pwh_gameplay_chieftain_cleave_attack_taunt_02",
				"pwh_gameplay_chieftain_cleave_attack_taunt_03",
				"pwh_gameplay_chieftain_cleave_attack_taunt_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_seeing_thunderwater = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_seeing_thunderwater_inn_01",
				"pwh_objective_stromdorf_town_seeing_thunderwater_inn_02",
				"pwh_objective_stromdorf_town_seeing_thunderwater_inn_03",
				"pwh_objective_stromdorf_town_seeing_thunderwater_inn_04"
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
				"pwh_objective_stromdorf_town_seeing_thunderwater_inn_01",
				"pwh_objective_stromdorf_town_seeing_thunderwater_inn_02",
				"pwh_objective_stromdorf_town_seeing_thunderwater_inn_03",
				"pwh_objective_stromdorf_town_seeing_thunderwater_inn_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_chieftain_tips_special_attack_cleave = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_chieftain_tips_01",
				"pwh_gameplay_chieftain_tips_02",
				"pwh_gameplay_chieftain_tips_03",
				"pwh_gameplay_chieftain_tips_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_gameplay_chieftain_tips_01",
				"pwh_gameplay_chieftain_tips_02",
				"pwh_gameplay_chieftain_tips_03",
				"pwh_gameplay_chieftain_tips_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_enter_stromdorf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_enter_stromdorf_01",
				"pwh_objective_stromdorf_town_enter_stromdorf_02",
				"pwh_objective_stromdorf_town_enter_stromdorf_03",
				"pwh_objective_stromdorf_town_enter_stromdorf_04"
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
				"pwh_objective_stromdorf_town_enter_stromdorf_01",
				"pwh_objective_stromdorf_town_enter_stromdorf_02",
				"pwh_objective_stromdorf_town_enter_stromdorf_03",
				"pwh_objective_stromdorf_town_enter_stromdorf_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_intro_c_gt = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_stromdorf_town_intro_c_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_c_02"
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
				[1.0] = "pwh_objective_stromdorf_town_intro_c_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_go_to_olesya = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_go_to_olesya_01",
				"pwh_objective_stromdorf_town_go_to_olesya_02",
				"pwh_objective_stromdorf_town_go_to_olesya_03",
				"pwh_objective_stromdorf_town_go_to_olesya_04"
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
				"pwh_objective_stromdorf_town_go_to_olesya_01",
				"pwh_objective_stromdorf_town_go_to_olesya_02",
				"pwh_objective_stromdorf_town_go_to_olesya_03",
				"pwh_objective_stromdorf_town_go_to_olesya_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_intro_b_gt = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_stromdorf_town_intro_b_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_b_02"
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
				[1.0] = "pwh_objective_stromdorf_town_intro_b_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_find_tannery = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_find_tannery_01",
				"pwh_objective_stromdorf_town_find_tannery_02",
				"pwh_objective_stromdorf_town_find_tannery_03",
				"pwh_objective_stromdorf_town_find_tannery_04"
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
				"pwh_objective_stromdorf_town_find_tannery_01",
				"pwh_objective_stromdorf_town_find_tannery_02",
				"pwh_objective_stromdorf_town_find_tannery_03",
				"pwh_objective_stromdorf_town_find_tannery_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_intro_a_gt = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_stromdorf_town_intro_a_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_a_02"
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
				[1.0] = "pwh_objective_stromdorf_town_intro_a_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_stromdorf_town_intro_b_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_b_02"
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
				[1.0] = "pwh_objective_stromdorf_town_intro_b_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_seeing_well = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_seeing_well_01",
				"pwh_objective_stromdorf_town_seeing_well_02",
				"pwh_objective_stromdorf_town_seeing_well_03",
				"pwh_objective_stromdorf_town_seeing_well_04"
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
				"pwh_objective_stromdorf_town_seeing_well_01",
				"pwh_objective_stromdorf_town_seeing_well_02",
				"pwh_objective_stromdorf_town_seeing_well_03",
				"pwh_objective_stromdorf_town_seeing_well_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_kill_emissary = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_kill_emissary_01",
				"pwh_objective_stromdorf_town_kill_emissary_02",
				"pwh_objective_stromdorf_town_kill_emissary_03",
				"pwh_objective_stromdorf_town_kill_emissary_04"
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
				"pwh_objective_stromdorf_town_kill_emissary_01",
				"pwh_objective_stromdorf_town_kill_emissary_02",
				"pwh_objective_stromdorf_town_kill_emissary_03",
				"pwh_objective_stromdorf_town_kill_emissary_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_stromdorf_town_intro_c_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_c_02"
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
				[1.0] = "pwh_objective_stromdorf_town_intro_c_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_seeing_tannery = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_seeing_tannery_01",
				"pwh_objective_stromdorf_town_seeing_tannery_02",
				"pwh_objective_stromdorf_town_seeing_tannery_03",
				"pwh_objective_stromdorf_town_seeing_tannery_04"
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
				"pwh_objective_stromdorf_town_seeing_tannery_01",
				"pwh_objective_stromdorf_town_seeing_tannery_02",
				"pwh_objective_stromdorf_town_seeing_tannery_03",
				"pwh_objective_stromdorf_town_seeing_tannery_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_fleeing = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_fleeing_01",
				"pwh_objective_stromdorf_town_fleeing_02",
				"pwh_objective_stromdorf_town_fleeing_03",
				"pwh_objective_stromdorf_town_fleeing_04"
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
				"pwh_objective_stromdorf_town_fleeing_01",
				"pwh_objective_stromdorf_town_fleeing_02",
				"pwh_objective_stromdorf_town_fleeing_03",
				"pwh_objective_stromdorf_town_fleeing_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_chieftain_banter_reply = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_chieftain_banter_reply_01",
				"pwh_gameplay_chieftain_banter_reply_02",
				"pwh_gameplay_chieftain_banter_reply_03",
				"pwh_gameplay_chieftain_banter_reply_04"
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
				"pwh_gameplay_chieftain_banter_reply_01",
				"pwh_gameplay_chieftain_banter_reply_02",
				"pwh_gameplay_chieftain_banter_reply_03",
				"pwh_gameplay_chieftain_banter_reply_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_seeing_barber_surgeon = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_seeing_barber_surgeon_01",
				"pwh_objective_stromdorf_town_seeing_barber_surgeon_02",
				"pwh_objective_stromdorf_town_seeing_barber_surgeon_03",
				"pwh_objective_stromdorf_town_seeing_barber_surgeon_04"
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
				"pwh_objective_stromdorf_town_seeing_barber_surgeon_01",
				"pwh_objective_stromdorf_town_seeing_barber_surgeon_02",
				"pwh_objective_stromdorf_town_seeing_barber_surgeon_03",
				"pwh_objective_stromdorf_town_seeing_barber_surgeon_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_chieftain_charge_attack_taunt = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "player_alerts_boss",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_chieftain_charge_attack_taunt_01",
				"pwh_gameplay_chieftain_charge_attack_taunt_02",
				"pwh_gameplay_chieftain_charge_attack_taunt_03",
				"pwh_gameplay_chieftain_charge_attack_taunt_04"
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
				"pwh_gameplay_chieftain_charge_attack_taunt_01",
				"pwh_gameplay_chieftain_charge_attack_taunt_02",
				"pwh_gameplay_chieftain_charge_attack_taunt_03",
				"pwh_gameplay_chieftain_charge_attack_taunt_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_seeing_field_of_verena = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_seeing_field_of_verena_01",
				"pwh_objective_stromdorf_town_seeing_field_of_verena_02",
				"pwh_objective_stromdorf_town_seeing_field_of_verena_03",
				"pwh_objective_stromdorf_town_seeing_field_of_verena_04"
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
				"pwh_objective_stromdorf_town_seeing_field_of_verena_01",
				"pwh_objective_stromdorf_town_seeing_field_of_verena_02",
				"pwh_objective_stromdorf_town_seeing_field_of_verena_03",
				"pwh_objective_stromdorf_town_seeing_field_of_verena_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_intro_a = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_stromdorf_town_intro_a_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_a_02"
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
				[1.0] = "pwh_objective_stromdorf_town_intro_a_01",
				[2.0] = "pwh_objective_stromdorf_town_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_seeing_stewpot_hostelry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_seeing_stewpot_hostelry_01",
				"pwh_objective_stromdorf_town_seeing_stewpot_hostelry_02",
				"pwh_objective_stromdorf_town_seeing_stewpot_hostelry_03",
				"pwh_objective_stromdorf_town_seeing_stewpot_hostelry_04"
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
				"pwh_objective_stromdorf_town_seeing_stewpot_hostelry_01",
				"pwh_objective_stromdorf_town_seeing_stewpot_hostelry_02",
				"pwh_objective_stromdorf_town_seeing_stewpot_hostelry_03",
				"pwh_objective_stromdorf_town_seeing_stewpot_hostelry_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_stromdorf_town_entering_reikland_gate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_stromdorf_town_entering_reikland_gate_01",
				"pwh_objective_stromdorf_town_entering_reikland_gate_02",
				"pwh_objective_stromdorf_town_entering_reikland_gate_03",
				"pwh_objective_stromdorf_town_entering_reikland_gate_04"
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
				"pwh_objective_stromdorf_town_entering_reikland_gate_01",
				"pwh_objective_stromdorf_town_entering_reikland_gate_02",
				"pwh_objective_stromdorf_town_entering_reikland_gate_03",
				"pwh_objective_stromdorf_town_entering_reikland_gate_04"
			},
			randomize_indexes = {}
		}
	})
end
