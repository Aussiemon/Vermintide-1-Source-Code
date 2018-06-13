return function ()
	define_rule({
		name = "pbw_objective_stromdorf_town_enter_stromdorf",
		response = "pbw_objective_stromdorf_town_enter_stromdorf",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_weather_rain",
		response = "pbw_objective_stromdorf_town_weather_rain",
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
				"objective_stromdorf_town_weather_rain"
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
				"faction_memory",
				"time_since_objective_stromdorf_town_weather_rain",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_weather_rain",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_stromdorf_town_seeing_field_of_verena",
		response = "pbw_objective_stromdorf_town_seeing_field_of_verena",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_find_tannery",
		response = "pbw_objective_stromdorf_town_find_tannery",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_seeing_well",
		response = "pbw_objective_stromdorf_town_seeing_well",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_seeing_shallya_shrine",
		response = "pbw_objective_stromdorf_town_seeing_shallya_shrine",
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
				"objective_stromdorf_town_seeing_shallya_shrine"
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
				"faction_memory",
				"time_since_objective_stromdorf_town_seeing_shallya_shrine",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_stromdorf_town_seeing_shallya_shrine",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_stromdorf_town_seeing_barber_surgeon",
		response = "pbw_objective_stromdorf_town_seeing_barber_surgeon",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_seeing_tannery",
		response = "pbw_objective_stromdorf_town_seeing_tannery",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_kill_emissary",
		response = "pbw_objective_stromdorf_town_kill_emissary",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_emissary_dead",
		response = "pbw_objective_stromdorf_town_emissary_dead",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_go_to_olesya",
		response = "pbw_objective_stromdorf_town_go_to_olesya",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_fleeing",
		response = "pbw_objective_stromdorf_town_fleeing",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_gameplay_chieftain_cleave_attack_taunt",
		response = "pbw_gameplay_chieftain_cleave_attack_taunt",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_gameplay_chieftain_charge_attack_taunt",
		response = "pbw_gameplay_chieftain_charge_attack_taunt",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_intro_a",
		response = "pbw_objective_stromdorf_town_intro_a",
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
		name = "pbw_objective_stromdorf_town_intro_b",
		response = "pbw_objective_stromdorf_town_intro_b",
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
				"bright_wizard"
			},
			{
				"global_context",
				"completed_times",
				OP.LT,
				3
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_stromdorf_town_intro_c",
		response = "pbw_objective_stromdorf_town_intro_c",
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
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_emissary_anticipation",
		response = "pbw_objective_stromdorf_town_emissary_anticipation",
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
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
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
		name = "pbw_gameplay_chieftain_tips_special_attack_cleave",
		response = "pbw_gameplay_chieftain_tips_special_attack_cleave",
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
				"bright_wizard"
			},
			{
				"query_context",
				"target_name",
				OP.NEQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_last_special_attack_cleave_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
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
		name = "pbw_gameplay_chieftain_tips_special_lunge_attack_2",
		response = "pbw_gameplay_chieftain_tips_special_lunge_attack_2",
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
				"special_lunge_attack"
			},
			{
				"user_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"target_name",
				OP.NEQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_last_special_lunge_attack_2_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
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
		name = "pbw_gameplay_chieftain_banter_reply",
		response = "pbw_gameplay_chieftain_banter_reply",
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
				"bright_wizard"
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
		name = "pbw_objective_stromdorf_town_intro_a_gt",
		response = "pbw_objective_stromdorf_town_intro_a_gt",
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
		name = "pbw_objective_stromdorf_town_intro_b_gt",
		response = "pbw_objective_stromdorf_town_intro_b_gt",
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
				"bright_wizard"
			},
			{
				"global_context",
				"completed_times",
				OP.GTEQ,
				6
			},
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_stromdorf_town_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_stromdorf_town_intro_c_gt",
		response = "pbw_objective_stromdorf_town_intro_c_gt",
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
				"bright_wizard"
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
		pbw_objective_stromdorf_town_kill_emissary = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_kill_emissary_01",
				"pbw_objective_stromdorf_town_kill_emissary_02",
				"pbw_objective_stromdorf_town_kill_emissary_03",
				"pbw_objective_stromdorf_town_kill_emissary_04"
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
				"pbw_objective_stromdorf_town_kill_emissary_01",
				"pbw_objective_stromdorf_town_kill_emissary_02",
				"pbw_objective_stromdorf_town_kill_emissary_03",
				"pbw_objective_stromdorf_town_kill_emissary_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_seeing_well = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_seeing_well_01",
				"pbw_objective_stromdorf_town_seeing_well_02",
				"pbw_objective_stromdorf_town_seeing_well_03",
				"pbw_objective_stromdorf_town_seeing_well_04"
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
				"pbw_objective_stromdorf_town_seeing_well_01",
				"pbw_objective_stromdorf_town_seeing_well_02",
				"pbw_objective_stromdorf_town_seeing_well_03",
				"pbw_objective_stromdorf_town_seeing_well_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_seeing_shallya_shrine = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_seeing_shallya_shrine_01",
				"pbw_objective_stromdorf_town_seeing_shallya_shrine_02",
				"pbw_objective_stromdorf_town_seeing_shallya_shrine_03",
				"pbw_objective_stromdorf_town_seeing_shallya_shrine_04"
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
				"pbw_objective_stromdorf_town_seeing_shallya_shrine_01",
				"pbw_objective_stromdorf_town_seeing_shallya_shrine_02",
				"pbw_objective_stromdorf_town_seeing_shallya_shrine_03",
				"pbw_objective_stromdorf_town_seeing_shallya_shrine_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_seeing_tannery = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_seeing_tannery_01",
				"pbw_objective_stromdorf_town_seeing_tannery_02",
				"pbw_objective_stromdorf_town_seeing_tannery_03",
				"pbw_objective_stromdorf_town_seeing_tannery_04"
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
				"pbw_objective_stromdorf_town_seeing_tannery_01",
				"pbw_objective_stromdorf_town_seeing_tannery_02",
				"pbw_objective_stromdorf_town_seeing_tannery_03",
				"pbw_objective_stromdorf_town_seeing_tannery_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_fleeing = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_fleeing_01",
				"pbw_objective_stromdorf_town_fleeing_02",
				"pbw_objective_stromdorf_town_fleeing_03",
				"pbw_objective_stromdorf_town_fleeing_04"
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
				"pbw_objective_stromdorf_town_fleeing_01",
				"pbw_objective_stromdorf_town_fleeing_02",
				"pbw_objective_stromdorf_town_fleeing_03",
				"pbw_objective_stromdorf_town_fleeing_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_intro_a = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_stromdorf_town_intro_a_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_a_02"
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
				[1.0] = "pbw_objective_stromdorf_town_intro_a_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_seeing_barber_surgeon = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pbw_objective_stromdorf_town_seeing_barber_surgeon_01",
				"pbw_objective_stromdorf_town_seeing_barber_surgeon_02",
				""
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pbw_objective_stromdorf_town_seeing_barber_surgeon_01",
				"pbw_objective_stromdorf_town_seeing_barber_surgeon_02",
				""
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_stromdorf_town_intro_b_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_b_02"
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
				[1.0] = "pbw_objective_stromdorf_town_intro_b_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_b_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_intro_a_gt = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_stromdorf_town_intro_a_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_a_02"
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
				[1.0] = "pbw_objective_stromdorf_town_intro_a_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_seeing_field_of_verena = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_seeing_field_of_verena_01",
				"pbw_objective_stromdorf_town_seeing_field_of_verena_02",
				"pbw_objective_stromdorf_town_seeing_field_of_verena_03",
				"pbw_objective_stromdorf_town_seeing_field_of_verena_04"
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
				"pbw_objective_stromdorf_town_seeing_field_of_verena_01",
				"pbw_objective_stromdorf_town_seeing_field_of_verena_02",
				"pbw_objective_stromdorf_town_seeing_field_of_verena_03",
				"pbw_objective_stromdorf_town_seeing_field_of_verena_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_emissary_anticipation = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_emissary_anticipation_01",
				"pbw_objective_stromdorf_town_emissary_anticipation_02",
				"pbw_objective_stromdorf_town_emissary_anticipation_03",
				"pbw_objective_stromdorf_town_emissary_anticipation_04"
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
				"pbw_objective_stromdorf_town_emissary_anticipation_01",
				"pbw_objective_stromdorf_town_emissary_anticipation_02",
				"pbw_objective_stromdorf_town_emissary_anticipation_03",
				"pbw_objective_stromdorf_town_emissary_anticipation_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_stromdorf_town_intro_c_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_c_02"
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
				[1.0] = "pbw_objective_stromdorf_town_intro_c_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_intro_c_gt = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_stromdorf_town_intro_c_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_c_02"
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
				[1.0] = "pbw_objective_stromdorf_town_intro_c_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_intro_b_gt = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_stromdorf_town_intro_b_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_b_02"
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
				[1.0] = "pbw_objective_stromdorf_town_intro_b_01",
				[2.0] = "pbw_objective_stromdorf_town_intro_b_02"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_chieftain_banter_reply = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "bright_wizard_stromdorf_town",
			category = "player_alerts_boss",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_gameplay_chieftain_banter_reply_01",
				[2.0] = "pbw_gameplay_chieftain_banter_reply_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout",
				[2.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_angry",
				[2.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_chieftain_banter_reply_01",
				[2.0] = "pbw_gameplay_chieftain_banter_reply_04"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_chieftain_tips_special_lunge_attack_2 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "bright_wizard_stromdorf_town",
			category = "player_alerts",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_chieftain_tips_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_chieftain_tips_01"
			}
		},
		pbw_objective_stromdorf_town_enter_stromdorf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_enter_stromdorf_01",
				"pbw_objective_stromdorf_town_enter_stromdorf_02",
				"pbw_objective_stromdorf_town_enter_stromdorf_03",
				"pbw_objective_stromdorf_town_enter_stromdorf_04"
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
				"pbw_objective_stromdorf_town_enter_stromdorf_01",
				"pbw_objective_stromdorf_town_enter_stromdorf_02",
				"pbw_objective_stromdorf_town_enter_stromdorf_03",
				"pbw_objective_stromdorf_town_enter_stromdorf_04"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_chieftain_tips_special_attack_cleave = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "bright_wizard_stromdorf_town",
			category = "player_alerts",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_gameplay_chieftain_tips_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_shout"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pbw_gameplay_chieftain_tips_01"
			}
		},
		pbw_gameplay_chieftain_cleave_attack_taunt = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_gameplay_chieftain_cleave_attack_taunt_01",
				"pbw_gameplay_chieftain_cleave_attack_taunt_02",
				"pbw_gameplay_chieftain_cleave_attack_taunt_03",
				"pbw_gameplay_chieftain_cleave_attack_taunt_04"
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
				"pbw_gameplay_chieftain_cleave_attack_taunt_01",
				"pbw_gameplay_chieftain_cleave_attack_taunt_02",
				"pbw_gameplay_chieftain_cleave_attack_taunt_03",
				"pbw_gameplay_chieftain_cleave_attack_taunt_04"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_chieftain_charge_attack_taunt = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_gameplay_chieftain_charge_attack_taunt_01",
				"pbw_gameplay_chieftain_charge_attack_taunt_02",
				"pbw_gameplay_chieftain_charge_attack_taunt_03",
				"pbw_gameplay_chieftain_charge_attack_taunt_04"
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
				"pbw_gameplay_chieftain_charge_attack_taunt_01",
				"pbw_gameplay_chieftain_charge_attack_taunt_02",
				"pbw_gameplay_chieftain_charge_attack_taunt_03",
				"pbw_gameplay_chieftain_charge_attack_taunt_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_go_to_olesya = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_go_to_olesya_01",
				"pbw_objective_stromdorf_town_go_to_olesya_02",
				"pbw_objective_stromdorf_town_go_to_olesya_03",
				"pbw_objective_stromdorf_town_go_to_olesya_04"
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
				"pbw_objective_stromdorf_town_go_to_olesya_01",
				"pbw_objective_stromdorf_town_go_to_olesya_02",
				"pbw_objective_stromdorf_town_go_to_olesya_03",
				"pbw_objective_stromdorf_town_go_to_olesya_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_weather_rain = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_weather_rain_01",
				"pbw_objective_stromdorf_town_weather_rain_02",
				"pbw_objective_stromdorf_town_weather_rain_03",
				"pbw_objective_stromdorf_town_weather_rain_04"
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
				"pbw_objective_stromdorf_town_weather_rain_01",
				"pbw_objective_stromdorf_town_weather_rain_02",
				"pbw_objective_stromdorf_town_weather_rain_03",
				"pbw_objective_stromdorf_town_weather_rain_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_find_tannery = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_find_tannery_01",
				"pbw_objective_stromdorf_town_find_tannery_02",
				"pbw_objective_stromdorf_town_find_tannery_03",
				"pbw_objective_stromdorf_town_find_tannery_04"
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
				"pbw_objective_stromdorf_town_find_tannery_01",
				"pbw_objective_stromdorf_town_find_tannery_02",
				"pbw_objective_stromdorf_town_find_tannery_03",
				"pbw_objective_stromdorf_town_find_tannery_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_stromdorf_town_emissary_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "bright_wizard_stromdorf_town",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_stromdorf_town_emissary_dead_01",
				"pbw_objective_stromdorf_town_emissary_dead_02",
				"pbw_objective_stromdorf_town_emissary_dead_03",
				"pbw_objective_stromdorf_town_emissary_dead_04"
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
				"pbw_objective_stromdorf_town_emissary_dead_01",
				"pbw_objective_stromdorf_town_emissary_dead_02",
				"pbw_objective_stromdorf_town_emissary_dead_03",
				"pbw_objective_stromdorf_town_emissary_dead_04"
			},
			randomize_indexes = {}
		}
	})
end
