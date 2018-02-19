return function ()
	define_rule({
		response = "egs_gameplay_witchhunter_knock_down_chamber",
		name = "egs_gameplay_witchhunter_knock_down_chamber",
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
				"pdr_gameplay_knocked_down_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_brightwizard_knock_down_chamber",
		name = "egs_gameplay_brightwizard_knock_down_chamber",
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
				"pbw_gameplay_knocked_down_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_dwarfranger_knock_down_chamber",
		name = "egs_gameplay_dwarfranger_knock_down_chamber",
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
				"pdr_gameplay_knocked_down_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_woodelf_knock_down_chamber",
		name = "egs_gameplay_woodelf_knock_down_chamber",
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
				"pwe_gameplay_knocked_down_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_empiresoldier_knock_down_chamber",
		name = "egs_gameplay_empiresoldier_knock_down_chamber",
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
				"pes_gameplay_knocked_down_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_witchhunter_killed_chamber",
		name = "egs_gameplay_witchhunter_killed_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"player_death"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_brightwizard_killed_chamber",
		name = "egs_gameplay_brightwizard_killed_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"player_death"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_dwarfranger_killed_chamber",
		name = "egs_gameplay_dwarfranger_killed_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"player_death"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_woodelf_killed_chamber",
		name = "egs_gameplay_woodelf_killed_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"player_death"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_empiresoldier_killed_chamber",
		name = "egs_gameplay_empiresoldier_killed_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"player_death"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_presentation",
		name = "egs_objective_presentation",
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
				"egs_objective_presentation"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_manipulating_battery",
		name = "egs_objective_manipulating_battery",
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
				"egs_objective_manipulating_battery"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_shot_at",
		name = "egs_objective_shot_at",
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
				"egs_objective_shot_at"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_hit_01",
		name = "egs_objective_hit_01",
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
				"egs_objective_hit_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_general_banter",
		name = "egs_objective_general_banter",
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
				"egs_objective_general_banter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_teleport_01",
		name = "egs_objective_teleport_01",
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
				"egs_objective_teleport_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_teleport_flee_01",
		name = "egs_objective_teleport_flee_01",
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
				"egs_objective_teleport_flee_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_weakness",
		name = "egs_objective_weakness",
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
				"egs_objective_weakness"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_knocked_down",
		name = "egs_objective_knocked_down",
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
				"egs_objective_knocked_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_rising",
		name = "egs_objective_rising",
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
				"egs_objective_rising"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_knocks_players_back",
		name = "egs_objective_knocks_players_back",
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
				"egs_objective_knocks_players_back"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_villain_monologue_bridge",
		name = "egs_objective_villain_monologue_bridge",
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
				"egs_objective_villain_monologue_bridge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_activate_trap",
		name = "egs_objective_activate_trap",
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
				"egs_objective_activate_trap"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_objective_scaffold_monologue",
		name = "egs_objective_scaffold_monologue",
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
				"egs_objective_scaffold_monologue"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "nik_level_chamber_lohner_cellar_b",
		name = "nik_level_chamber_lohner_cellar_b",
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
				"level_chamber_lohner_cellar_a"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"inn_keeper"
			}
		}
	})
	define_rule({
		response = "nik_level_chamber_lohner_cellar_d",
		name = "nik_level_chamber_lohner_cellar_d",
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
				"level_chamber_lohner_cellar_c"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"inn_keeper"
			}
		}
	})
	define_rule({
		response = "nik_level_chamber_lohner_cellar_talk_more_b",
		name = "nik_level_chamber_lohner_cellar_talk_more_b",
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
				"level_chamber_lohner_cellar_talk_more_a"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"inn_keeper"
			}
		}
	})
	define_rule({
		response = "nik_level_chamber_lohner_cellar_talk_more_d",
		name = "nik_level_chamber_lohner_cellar_talk_more_d",
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
				"level_chamber_lohner_cellar_talk_more_c"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"inn_keeper"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_saltzpyre_01",
		name = "nfl_level_chamber_olesya_cellar_saltzpyre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_level_chamber_olesya_cellar_saltzpyre_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_saltzpyre_02",
		name = "nfl_level_chamber_olesya_cellar_saltzpyre_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_level_chamber_olesya_cellar_a_saltspyre_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_sienna_01",
		name = "nfl_level_chamber_olesya_cellar_sienna_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_level_chamber_olesya_cellar_sienna_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_sienna_02",
		name = "nfl_level_chamber_olesya_cellar_sienna_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_level_chamber_olesya_cellar_sienna_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_bardin_01",
		name = "nfl_level_chamber_olesya_cellar_bardin_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_level_chamber_olesya_cellar_bardin_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_bardin_02",
		name = "nfl_level_chamber_olesya_cellar_bardin_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_level_chamber_olesya_cellar_bardin_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_kerillian_01",
		name = "nfl_level_chamber_olesya_cellar_kerillian_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_level_chamber_olesya_cellar_kerillian_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_kerillian_02",
		name = "nfl_level_chamber_olesya_cellar_kerillian_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_level_chamber_olesya_cellar_kerillian_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_kruber_01",
		name = "nfl_level_chamber_olesya_cellar_kruber_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_level_chamber_olesya_cellar_kruber_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_kruber_02",
		name = "nfl_level_chamber_olesya_cellar_kruber_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_level_chamber_olesya_cellar_kruber_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_01",
		name = "nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_level_chamber_olesya_cellar_saltzpyre_talk_more_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_02",
		name = "nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_level_chamber_olesya_cellar_saltzpyre_talk_more_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_sienna_talk_more_01",
		name = "nfl_level_chamber_olesya_cellar_sienna_talk_more_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_level_chamber_olesya_cellar_sienna_talk_more_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_sienna_talk_more_02",
		name = "nfl_level_chamber_olesya_cellar_sienna_talk_more_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_level_chamber_olesya_cellar_sienna_talk_more_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_bardin_talk_more_01",
		name = "nfl_level_chamber_olesya_cellar_bardin_talk_more_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_level_chamber_olesya_cellar_bardin_talk_more_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_bardin_talk_more_02",
		name = "nfl_level_chamber_olesya_cellar_bardin_talk_more_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_level_chamber_olesya_cellar_bardin_talk_more_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_kerillian_talk_more_01",
		name = "nfl_level_chamber_olesya_cellar_kerillian_talk_more_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_level_chamber_olesya_cellar_kerillian_talk_more_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_kerillian_talk_more_02",
		name = "nfl_level_chamber_olesya_cellar_kerillian_talk_more_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_level_chamber_olesya_cellar_kerillian_talk_more_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_kruber_talk_more_01",
		name = "nfl_level_chamber_olesya_cellar_kruber_talk_more_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_level_chamber_olesya_cellar_kruber_talk_more_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_olesya_cellar_kruber_talk_more_02",
		name = "nfl_level_chamber_olesya_cellar_kruber_talk_more_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_level_chamber_olesya_cellar_kruber_talk_more_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_saltzpyre_01",
		name = "nfl_level_chamber_flask_saltzpyre_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_level_chamber_flask_saltzpyre_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_saltzpyre_02",
		name = "nfl_level_chamber_flask_saltzpyre_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_level_chamber_flask_saltzpyre_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_kerillian_01",
		name = "nfl_level_chamber_flask_kerillian_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_level_chamber_flask_kerillian_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_kerillian_02",
		name = "nfl_level_chamber_flask_kerillian_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_level_chamber_flask_kerillian_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_sienna_01",
		name = "nfl_level_chamber_flask_sienna_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_level_chamber_flask_sienna_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_sienna_02",
		name = "nfl_level_chamber_flask_sienna_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_level_chamber_flask_sienna_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_bardin_01",
		name = "nfl_level_chamber_flask_bardin_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_level_chamber_flask_bardin_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_bardin_02",
		name = "nfl_level_chamber_flask_bardin_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_level_chamber_flask_bardin_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_kruber_01",
		name = "nfl_level_chamber_flask_kruber_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_level_chamber_flask_kruber_01"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "nfl_level_chamber_flask_kruber_02",
		name = "nfl_level_chamber_flask_kruber_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_level_chamber_flask_kruber_02"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"ferry_lady"
			}
		}
	})
	define_rule({
		response = "egs_level_chamber_rasknitt_sighted_b",
		name = "egs_level_chamber_rasknitt_sighted_b",
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
				"level_chamber_rasknitt_sighted_a"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_level_chamber_rasknitt_flees_one_b",
		name = "egs_level_chamber_rasknitt_flees_one_b",
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
				"level_chamber_rasknitt_flees_one_a"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_level_chamber_rasknitt_flees_two_b",
		name = "egs_level_chamber_rasknitt_flees_two_b",
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
				"level_chamber_rasknitt_flees_two_a"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_level_chamber_rasknitt_flees_three_b",
		name = "egs_level_chamber_rasknitt_flees_three_b",
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
				"level_chamber_rasknitt_flees_three_a"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"skaven_grey_seer"
			}
		}
	})
	add_dialogues({
		egs_gameplay_empiresoldier_knock_down_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_empiresoldier_knock_down_01",
				"egs_gameplay_empiresoldier_knock_down_02",
				"egs_gameplay_empiresoldier_knock_down_03",
				"egs_gameplay_empiresoldier_knock_down_04",
				"egs_gameplay_empiresoldier_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_empiresoldier_knock_down_01",
				"egs_gameplay_empiresoldier_knock_down_02",
				"egs_gameplay_empiresoldier_knock_down_03",
				"egs_gameplay_empiresoldier_knock_down_04",
				"egs_gameplay_empiresoldier_knock_down_05"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_kerillian_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kerillian_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kerillian_01"
			}
		},
		egs_objective_general_banter = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"egs_objective_general_banter_01",
				"egs_objective_general_banter_02",
				"egs_objective_hit_01_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_objective_general_banter_01",
				"egs_objective_general_banter_02",
				"egs_objective_hit_01_03"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_bardin_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_bardin_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_bardin_02"
			}
		},
		nfl_level_chamber_flask_sienna_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_sienna_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_sienna_02"
			}
		},
		nfl_level_chamber_flask_saltzpyre_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_saltzpyre_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_contempt"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_saltzpyre_02"
			}
		},
		nik_level_chamber_lohner_cellar_d = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 4,
			sound_events = {
				"nik_level_chamber_lohner_cellar_d_01",
				"nik_level_chamber_lohner_cellar_d_02",
				"nik_level_chamber_lohner_cellar_d_03",
				"nik_level_chamber_lohner_cellar_d_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_calm",
				"face_calm",
				"face_calm",
				"face_calm"
			},
			localization_strings = {
				"nik_level_chamber_lohner_cellar_d_01",
				"nik_level_chamber_lohner_cellar_d_02",
				"nik_level_chamber_lohner_cellar_d_03",
				"nik_level_chamber_lohner_cellar_d_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_dwarfranger_knock_down_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_dwarfranger_knock_down_01",
				"egs_gameplay_dwarfranger_knock_down_02",
				"egs_gameplay_dwarfranger_knock_down_03",
				"egs_gameplay_dwarfranger_knock_down_04",
				"egs_gameplay_dwarfranger_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_dwarfranger_knock_down_01",
				"egs_gameplay_dwarfranger_knock_down_02",
				"egs_gameplay_dwarfranger_knock_down_03",
				"egs_gameplay_dwarfranger_knock_down_04",
				"egs_gameplay_dwarfranger_knock_down_05"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_saltzpyre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_saltzpyre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_contempt"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_saltzpyre_01"
			}
		},
		egs_objective_weakness = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"egs_objective_weakness_01",
				"egs_objective_weakness_01_a",
				"egs_objective_weakness_02",
				"egs_objective_weakness_02_a",
				"egs_objective_weakness_03",
				"egs_objective_weakness_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_objective_weakness_01",
				"egs_objective_weakness_01_a",
				"egs_objective_weakness_02",
				"egs_objective_weakness_02_a",
				"egs_objective_weakness_03",
				"egs_objective_weakness_04"
			},
			randomize_indexes = {}
		},
		egs_objective_rising = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "boss_talk_2",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "egs_objective_rising_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_objective_rising_01"
			}
		},
		nfl_level_chamber_olesya_cellar_sienna_talk_more_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_sienna_talk_more_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_contempt"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_sienna_talk_more_01"
			}
		},
		egs_objective_knocks_players_back = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "boss_talk_3",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "egs_objective_knocks_players_back_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_objective_knocks_players_back_02"
			}
		},
		egs_objective_activate_trap = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "boss_talk_2",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "egs_objective_activate_trap_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_objective_activate_trap_01"
			}
		},
		nfl_level_chamber_flask_bardin_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_bardin_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_bardin_02"
			}
		},
		egs_objective_shot_at = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 8,
			sound_events = {
				"egs_objective_shot_at_01 ",
				"egs_objective_shot_at_02",
				"egs_objective_shot_at_03",
				"egs_objective_shot_at_04",
				"egs_objective_shot_at_05",
				"egs_objective_shot_at_06",
				"egs_objective_shot_at_07",
				"egs_objective_shot_at_08"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_objective_shot_at_01 ",
				"egs_objective_shot_at_02",
				"egs_objective_shot_at_03",
				"egs_objective_shot_at_04",
				"egs_objective_shot_at_05",
				"egs_objective_shot_at_06",
				"egs_objective_shot_at_07",
				"egs_objective_shot_at_08"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_bardin_talk_more_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_bardin_talk_more_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_bardin_talk_more_01"
			}
		},
		nfl_level_chamber_olesya_cellar_bardin_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_bardin_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_bardin_01"
			}
		},
		nfl_level_chamber_olesya_cellar_kruber_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kruber_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kruber_02"
			}
		},
		egs_level_chamber_rasknitt_flees_three_b = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_level_chamber_rasknitt_flees_three_b_01",
				"egs_level_chamber_rasknitt_flees_three_b_02",
				"egs_level_chamber_rasknitt_flees_three_b_03",
				"egs_level_chamber_rasknitt_flees_three_b_04"
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
				"egs_level_chamber_rasknitt_flees_three_b_01",
				"egs_level_chamber_rasknitt_flees_three_b_02",
				"egs_level_chamber_rasknitt_flees_three_b_03",
				"egs_level_chamber_rasknitt_flees_three_b_04"
			},
			randomize_indexes = {}
		},
		egs_level_chamber_rasknitt_flees_two_b = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_level_chamber_rasknitt_flees_two_b_01",
				"egs_level_chamber_rasknitt_flees_two_b_02",
				"egs_level_chamber_rasknitt_flees_two_b_03",
				"egs_level_chamber_rasknitt_flees_two_b_04"
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
				"egs_level_chamber_rasknitt_flees_two_b_01",
				"egs_level_chamber_rasknitt_flees_two_b_02",
				"egs_level_chamber_rasknitt_flees_two_b_03",
				"egs_level_chamber_rasknitt_flees_two_b_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_brightwizard_killed_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_brightwizard_killed_01",
				"egs_gameplay_brightwizard_killed_02",
				"egs_gameplay_brightwizard_killed_03",
				"egs_gameplay_brightwizard_killed_04",
				"egs_gameplay_brightwizard_killed_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_brightwizard_killed_01",
				"egs_gameplay_brightwizard_killed_02",
				"egs_gameplay_brightwizard_killed_03",
				"egs_gameplay_brightwizard_killed_04",
				"egs_gameplay_brightwizard_killed_05"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_kruber_talk_more_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kruber_talk_more_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kruber_talk_more_02"
			}
		},
		egs_gameplay_brightwizard_knock_down_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_brightwizard_knock_down_01",
				"egs_gameplay_brightwizard_knock_down_02",
				"egs_gameplay_brightwizard_knock_down_03",
				"egs_gameplay_brightwizard_knock_down_04",
				"egs_gameplay_brightwizard_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_brightwizard_knock_down_01",
				"egs_gameplay_brightwizard_knock_down_02",
				"egs_gameplay_brightwizard_knock_down_03",
				"egs_gameplay_brightwizard_knock_down_04",
				"egs_gameplay_brightwizard_knock_down_05"
			},
			randomize_indexes = {}
		},
		egs_objective_teleport_flee_01 = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "egs_objective_teleport_flee_01_01",
				[2.0] = "egs_objective_teleport_flee_01_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry",
				[2.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_objective_teleport_flee_01_01",
				[2.0] = "egs_objective_teleport_flee_01_02"
			},
			randomize_indexes = {}
		},
		egs_level_chamber_rasknitt_sighted_b = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_level_chamber_rasknitt_sighted_b_01",
				"egs_level_chamber_rasknitt_sighted_b_02",
				"egs_level_chamber_rasknitt_sighted_b_03",
				"egs_level_chamber_rasknitt_sighted_b_04"
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
				"egs_level_chamber_rasknitt_sighted_b_01",
				"egs_level_chamber_rasknitt_sighted_b_02",
				"egs_level_chamber_rasknitt_sighted_b_03",
				"egs_level_chamber_rasknitt_sighted_b_04"
			},
			randomize_indexes = {}
		},
		nik_level_chamber_lohner_cellar_b = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 4,
			sound_events = {
				"nik_level_chamber_lohner_cellar_b_01",
				"nik_level_chamber_lohner_cellar_b_02",
				"nik_level_chamber_lohner_cellar_b_03",
				"nik_level_chamber_lohner_cellar_b_04"
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
				"nik_level_chamber_lohner_cellar_b_01",
				"nik_level_chamber_lohner_cellar_b_02",
				"nik_level_chamber_lohner_cellar_b_03",
				"nik_level_chamber_lohner_cellar_b_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_witchhunter_killed_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_witchhunter_killed_01",
				"egs_gameplay_witchhunter_killed_02",
				"egs_gameplay_witchhunter_killed_03",
				"egs_gameplay_witchhunter_killed_04",
				"egs_gameplay_witchhunter_killed_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_witchhunter_killed_01",
				"egs_gameplay_witchhunter_killed_02",
				"egs_gameplay_witchhunter_killed_03",
				"egs_gameplay_witchhunter_killed_04",
				"egs_gameplay_witchhunter_killed_05"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_flask_kruber_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_kruber_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_kruber_01"
			}
		},
		nfl_level_chamber_olesya_cellar_kruber_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kruber_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kruber_01"
			}
		},
		nfl_level_chamber_olesya_cellar_sienna_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_sienna_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_contempt"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_sienna_01"
			}
		},
		nfl_level_chamber_flask_sienna_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_sienna_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_sienna_01"
			}
		},
		nfl_level_chamber_olesya_cellar_kruber_talk_more_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kruber_talk_more_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kruber_talk_more_01"
			}
		},
		nfl_level_chamber_flask_kerillian_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_kerillian_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_kerillian_02"
			}
		},
		nfl_level_chamber_olesya_cellar_saltzpyre_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_saltzpyre_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_saltzpyre_02"
			}
		},
		nfl_level_chamber_flask_kerillian_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_kerillian_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_smug"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_kerillian_01"
			}
		},
		nfl_level_chamber_flask_saltzpyre_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_saltzpyre_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_contempt"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_saltzpyre_01"
			}
		},
		nfl_level_chamber_olesya_cellar_bardin_talk_more_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_bardin_talk_more_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_calm"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_bardin_talk_more_02"
			}
		},
		nfl_level_chamber_olesya_cellar_kerillian_talk_more_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kerillian_talk_more_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_calm"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kerillian_talk_more_01"
			}
		},
		nfl_level_chamber_olesya_cellar_kerillian_talk_more_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kerillian_talk_more_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_calm"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kerillian_talk_more_02"
			}
		},
		egs_gameplay_witchhunter_knock_down_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_witchhunter_knock_down_01",
				"egs_gameplay_witchhunter_knock_down_02",
				"egs_gameplay_witchhunter_knock_down_03",
				"egs_gameplay_witchhunter_knock_down_04",
				"egs_gameplay_witchhunter_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_witchhunter_knock_down_01",
				"egs_gameplay_witchhunter_knock_down_02",
				"egs_gameplay_witchhunter_knock_down_03",
				"egs_gameplay_witchhunter_knock_down_04",
				"egs_gameplay_witchhunter_knock_down_05"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_flask_kruber_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_kruber_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_happy"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_kruber_02"
			}
		},
		egs_objective_villain_monologue_bridge = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "egs_objective_villain_monologue_bridge_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_objective_villain_monologue_bridge_01"
			}
		},
		egs_objective_manipulating_battery = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 7,
			sound_events = {
				"egs_objective_manipulating_battery_01",
				"egs_objective_manipulating_battery_01_b",
				"egs_objective_manipulating_battery_02",
				"egs_objective_manipulating_battery_03",
				"egs_objective_manipulating_battery_04",
				"egs_objective_manipulating_battery_a_04",
				"egs_objective_manipulating_battery_a_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_objective_manipulating_battery_01",
				"egs_objective_manipulating_battery_01_b",
				"egs_objective_manipulating_battery_02",
				"egs_objective_manipulating_battery_03",
				"egs_objective_manipulating_battery_04",
				"egs_objective_manipulating_battery_a_04",
				"egs_objective_manipulating_battery_a_04"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_bored"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_02"
			}
		},
		nfl_level_chamber_olesya_cellar_kerillian_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kerillian_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_kerillian_02"
			}
		},
		egs_objective_presentation = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "egs_objective_presentation_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_objective_presentation_01"
			}
		},
		egs_gameplay_empiresoldier_killed_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_empiresoldier_killed_01",
				"egs_gameplay_empiresoldier_killed_02",
				"egs_gameplay_empiresoldier_killed_03",
				"egs_gameplay_empiresoldier_killed_04",
				"egs_gameplay_empiresoldier_killed_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_empiresoldier_killed_01",
				"egs_gameplay_empiresoldier_killed_02",
				"egs_gameplay_empiresoldier_killed_03",
				"egs_gameplay_empiresoldier_killed_04",
				"egs_gameplay_empiresoldier_killed_05"
			},
			randomize_indexes = {}
		},
		egs_objective_knocked_down = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "egs_objective_knocked_down_01",
				[2.0] = "egs_objective_knocked_down_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry",
				[2.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_objective_knocked_down_01",
				[2.0] = "egs_objective_knocked_down_02"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_bored"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_saltzpyre_talk_more_01"
			}
		},
		nfl_level_chamber_flask_bardin_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_flask_bardin_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_contempt"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_flask_bardin_01"
			}
		},
		egs_gameplay_woodelf_knock_down_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_woodelf_knock_down_01",
				"egs_gameplay_woodelf_knock_down_02",
				"egs_gameplay_woodelf_knock_down_03",
				"egs_gameplay_woodelf_knock_down_04",
				"egs_gameplay_woodelf_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_woodelf_knock_down_01",
				"egs_gameplay_woodelf_knock_down_02",
				"egs_gameplay_woodelf_knock_down_03",
				"egs_gameplay_woodelf_knock_down_04",
				"egs_gameplay_woodelf_knock_down_05"
			},
			randomize_indexes = {}
		},
		egs_level_chamber_rasknitt_flees_one_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "egs_level_chamber_rasknitt_flees_sneaky_01",
				[2.0] = "egs_level_chamber_rasknitt_flees_sneaky_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry",
				[2.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_level_chamber_rasknitt_flees_sneaky_01",
				[2.0] = "egs_level_chamber_rasknitt_flees_sneaky_02"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_sienna_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_sienna_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_contempt"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_sienna_02"
			}
		},
		egs_objective_teleport_01 = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "grey_seer_chamber",
			category = "boss_talk",
			dialogue_animations_n = 8,
			sound_events = {
				"egs_objective_teleport_01_01",
				"egs_objective_teleport_01_02",
				"egs_objective_teleport_01_03",
				"egs_objective_teleport_04",
				"egs_objective_teleport_05",
				"egs_objective_teleport_06",
				"egs_objective_teleport_07",
				"egs_objective_teleport_08"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_objective_teleport_01_01",
				"egs_objective_teleport_01_02",
				"egs_objective_teleport_01_03",
				"egs_objective_teleport_04",
				"egs_objective_teleport_05",
				"egs_objective_teleport_06",
				"egs_objective_teleport_07",
				"egs_objective_teleport_08"
			},
			randomize_indexes = {}
		},
		nfl_level_chamber_olesya_cellar_sienna_talk_more_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nfl_level_chamber_olesya_cellar_sienna_talk_more_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_contempt"
			},
			localization_strings = {
				[1.0] = "nfl_level_chamber_olesya_cellar_sienna_talk_more_02"
			}
		},
		nik_level_chamber_lohner_cellar_talk_more_d = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 4,
			sound_events = {
				"nik_level_chamber_lohner_cellar_talk_more_d_01",
				"nik_level_chamber_lohner_cellar_talk_more_d_02",
				"nik_level_chamber_lohner_cellar_talk_more_d_03",
				"nik_level_chamber_lohner_cellar_talk_more_d_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_bored",
				"face_bored",
				"face_bored",
				"face_bored"
			},
			localization_strings = {
				"nik_level_chamber_lohner_cellar_talk_more_d_01",
				"nik_level_chamber_lohner_cellar_talk_more_d_02",
				"nik_level_chamber_lohner_cellar_talk_more_d_03",
				"nik_level_chamber_lohner_cellar_talk_more_d_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_dwarfranger_killed_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_dwarfranger_killed_01",
				"egs_gameplay_dwarfranger_killed_02",
				"egs_gameplay_dwarfranger_killed_03",
				"egs_gameplay_dwarfranger_killed_04",
				"egs_gameplay_dwarfranger_killed_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_dwarfranger_killed_01",
				"egs_gameplay_dwarfranger_killed_02",
				"egs_gameplay_dwarfranger_killed_03",
				"egs_gameplay_dwarfranger_killed_04",
				"egs_gameplay_dwarfranger_killed_05"
			},
			randomize_indexes = {}
		},
		egs_objective_scaffold_monologue = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "grey_seer_chamber",
			category = "boss_talk_2",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "egs_objective_scaffold_monologue_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_angry"
			},
			localization_strings = {
				[1.0] = "egs_objective_scaffold_monologue_01"
			}
		},
		nik_level_chamber_lohner_cellar_talk_more_b = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer_chamber",
			category = "npc_talk_interrupt",
			dialogue_animations_n = 4,
			sound_events = {
				"nik_level_chamber_lohner_cellar_talk_more_b_01",
				"nik_level_chamber_lohner_cellar_talk_more_b_02",
				"nik_level_chamber_lohner_cellar_talk_more_b_03",
				"nik_level_chamber_lohner_cellar_talk_more_b_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_calm",
				"face_calm",
				"face_calm",
				"face_calm"
			},
			localization_strings = {
				"nik_level_chamber_lohner_cellar_talk_more_b_01",
				"nik_level_chamber_lohner_cellar_talk_more_b_02",
				"nik_level_chamber_lohner_cellar_talk_more_b_03",
				"nik_level_chamber_lohner_cellar_talk_more_b_04"
			},
			randomize_indexes = {}
		},
		egs_objective_hit_01 = {
			sound_events_n = 14,
			randomize_indexes_n = 0,
			face_animations_n = 14,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 14,
			sound_events = {
				"egs_objective_hit_01_01",
				"egs_objective_hit_01_02",
				"egs_objective_hit_02_02_a",
				"egs_objective_hit_01_03",
				"egs_objective_hit_01_04",
				"egs_objective_hit_a_04",
				"egs_objective_hit_02_01_a",
				"egs_objective_hit_05",
				"egs_objective_hit_01_06",
				"egs_objective_hit_06",
				"egs_objective_hit_07",
				"egs_objective_hit_02_01_b",
				"egs_objective_hit_08-001",
				"egs_objective_hit_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_objective_hit_01_01",
				"egs_objective_hit_01_02",
				"egs_objective_hit_02_02_a",
				"egs_objective_hit_01_03",
				"egs_objective_hit_01_04",
				"egs_objective_hit_a_04",
				"egs_objective_hit_02_01_a",
				"egs_objective_hit_05",
				"egs_objective_hit_01_06",
				"egs_objective_hit_06",
				"egs_objective_hit_07",
				"egs_objective_hit_02_01_b",
				"egs_objective_hit_08-001",
				"egs_objective_hit_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_woodelf_killed_chamber = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer_chamber",
			category = "boss_reaction_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_woodelf_killed_01",
				"egs_gameplay_woodelf_killed_02",
				"egs_gameplay_woodelf_killed_03",
				"egs_gameplay_woodelf_killed_04",
				"egs_gameplay_woodelf_killed_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_woodelf_killed_01",
				"egs_gameplay_woodelf_killed_02",
				"egs_gameplay_woodelf_killed_03",
				"egs_gameplay_woodelf_killed_04",
				"egs_gameplay_woodelf_killed_05"
			},
			randomize_indexes = {}
		}
	})

	return 
end
