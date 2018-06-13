return function ()
	define_rule({
		response = "egs_gameplay_started",
		name = "egs_gameplay_started",
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
				"egs_gameplay_started"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_shielded",
		name = "egs_gameplay_shielded",
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
				"egs_gameplay_shielded"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_witchhunter_knock_down",
		name = "egs_gameplay_witchhunter_knock_down",
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
				"pwh_gameplay_knocked_down"
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
		response = "egs_gameplay_brightwizard_knock_down",
		name = "egs_gameplay_brightwizard_knock_down",
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
				"pbw_gameplay_knocked_down"
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
		response = "egs_gameplay_dwarfranger_knock_down",
		name = "egs_gameplay_dwarfranger_knock_down",
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
				"pdr_gameplay_knocked_down"
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
		response = "egs_gameplay_woodelf_knock_down",
		name = "egs_gameplay_woodelf_knock_down",
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
				"esr_gameplay_wood_elf_knocked_down"
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
		response = "egs_gameplay_empiresoldier_knock_down",
		name = "egs_gameplay_empiresoldier_knock_down",
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
				"pes_gameplay_knocked_down"
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
		response = "egs_gameplay_witchhunter_killed",
		name = "egs_gameplay_witchhunter_killed",
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
				"grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_brightwizard_killed",
		name = "egs_gameplay_brightwizard_killed",
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
				"grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_dwarfranger_killed",
		name = "egs_gameplay_dwarfranger_killed",
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
				"grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_woodelf_killed",
		name = "egs_gameplay_woodelf_killed",
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
				"grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_empiresoldier_killed",
		name = "egs_gameplay_empiresoldier_killed",
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
				"grey_seer"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_hitting_bell_early",
		name = "egs_gameplay_hitting_bell_early",
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
				"egs_gameplay_hitting_bell_early"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_hitting_bell_medium",
		name = "egs_gameplay_hitting_bell_medium",
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
				"egs_gameplay_hitting_bell_medium"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_hitting_bell_late",
		name = "egs_gameplay_hitting_bell_late",
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
				"egs_gameplay_hitting_bell_late"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_hitting_bell_climax",
		name = "egs_gameplay_hitting_bell_climax",
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
				"egs_gameplay_hitting_bell_climax"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_hitting_bell_story_reveal_part_1",
		name = "egs_gameplay_hitting_bell_story_reveal_part_1",
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
				"egs_gameplay_hitting_bell_story_reveal_part_1"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_hitting_bell_story_reveal_part_2",
		name = "egs_gameplay_hitting_bell_story_reveal_part_2",
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
				"egs_gameplay_hitting_bell_story_reveal_part_2"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_hitting_bell_story_reveal_part_3",
		name = "egs_gameplay_hitting_bell_story_reveal_part_3",
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
				"egs_gameplay_hitting_bell_story_reveal_part_3"
			}
		}
	})
	define_rule({
		response = "egs_gameplay_being_killed",
		name = "egs_gameplay_being_killed",
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
				"egs_gameplay_being_killed"
			}
		}
	})
	define_rule({
		response = "egs_player_achieved_objective",
		name = "egs_player_achieved_objective",
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
				"egs_player_achieved_objective"
			}
		}
	})
	define_rule({
		response = "egs_player_achieved_objective_gate",
		name = "egs_player_achieved_objective_gate",
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
				"egs_player_achieved_objective_gate"
			}
		}
	})
	define_rule({
		response = "egs_player_achieved_objective_kegs",
		name = "egs_player_achieved_objective_kegs",
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
				"egs_player_achieved_objective_kegs"
			}
		}
	})
	define_rule({
		response = "egs_player_achieved_objective_chain",
		name = "egs_player_achieved_objective_chain",
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
				"egs_player_achieved_objective_chain"
			}
		}
	})
	define_rule({
		response = "egs_warp_moon_meteor",
		name = "egs_warp_moon_meteor",
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
				"egs_warp_moon_meteor"
			}
		}
	})
	add_dialogues({
		egs_gameplay_dwarfranger_killed = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_dwarfranger_killed_01",
				"egs_gameplay_dwarfranger_killed_02",
				"egs_gameplay_dwarfranger_killed_03",
				"egs_gameplay_dwarfranger_killed_04",
				"egs_gameplay_dwarfranger_killed_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		egs_gameplay_hitting_bell_story_reveal_part_2 = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_hitting_bell_story_reveal_part_2_01",
				"egs_gameplay_hitting_bell_story_reveal_part_2_02",
				"egs_gameplay_hitting_bell_story_reveal_part_2_03",
				"egs_gameplay_hitting_bell_story_reveal_part_2_04",
				"egs_gameplay_hitting_bell_story_reveal_part_2_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_hitting_bell_story_reveal_part_2_01",
				"egs_gameplay_hitting_bell_story_reveal_part_2_02",
				"egs_gameplay_hitting_bell_story_reveal_part_2_03",
				"egs_gameplay_hitting_bell_story_reveal_part_2_04",
				"egs_gameplay_hitting_bell_story_reveal_part_2_05"
			},
			randomize_indexes = {}
		},
		egs_gameplay_being_killed = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_being_killed_01",
				"egs_gameplay_being_killed_02",
				"egs_gameplay_being_killed_03",
				"egs_gameplay_being_killed_04",
				"egs_gameplay_being_killed_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_being_killed_01",
				"egs_gameplay_being_killed_02",
				"egs_gameplay_being_killed_03",
				"egs_gameplay_being_killed_04",
				"egs_gameplay_being_killed_05"
			},
			randomize_indexes = {}
		},
		egs_gameplay_dwarfranger_knock_down = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_dwarfranger_knock_down_01",
				"egs_gameplay_dwarfranger_knock_down_02",
				"egs_gameplay_dwarfranger_knock_down_03",
				"egs_gameplay_dwarfranger_knock_down_04",
				"egs_gameplay_dwarfranger_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		egs_gameplay_shielded = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer",
			category = "boss_reaction_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_gameplay_shielded_01",
				"egs_gameplay_shielded_02",
				"egs_gameplay_shielded_03",
				"egs_gameplay_shielded_04"
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
				"egs_gameplay_shielded_01",
				"egs_gameplay_shielded_02",
				"egs_gameplay_shielded_03",
				"egs_gameplay_shielded_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_hitting_bell_early = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"egs_gameplay_hitting_bell_early_01",
				"egs_gameplay_hitting_bell_early_02",
				"egs_gameplay_hitting_bell_early_03",
				"egs_gameplay_hitting_bell_early_04",
				"egs_gameplay_hitting_bell_early_05",
				"egs_gameplay_hitting_bell_early_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
				"egs_gameplay_hitting_bell_early_01",
				"egs_gameplay_hitting_bell_early_02",
				"egs_gameplay_hitting_bell_early_03",
				"egs_gameplay_hitting_bell_early_04",
				"egs_gameplay_hitting_bell_early_05",
				"egs_gameplay_hitting_bell_early_06"
			},
			randomize_indexes = {}
		},
		egs_gameplay_empiresoldier_killed = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_empiresoldier_killed_01",
				"egs_gameplay_empiresoldier_killed_02",
				"egs_gameplay_empiresoldier_killed_03",
				"egs_gameplay_empiresoldier_killed_04",
				"egs_gameplay_empiresoldier_killed_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		egs_warp_moon_meteor = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_warp_moon_meteor_01",
				"egs_warp_moon_meteor_02",
				"egs_warp_moon_meteor_03",
				"egs_warp_moon_meteor_04"
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
				"egs_warp_moon_meteor_01",
				"egs_warp_moon_meteor_02",
				"egs_warp_moon_meteor_03",
				"egs_warp_moon_meteor_04"
			},
			randomize_indexes = {}
		},
		egs_player_achieved_objective_chain = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_player_achieved_objective_chain_01",
				"egs_player_achieved_objective_chain_02",
				"egs_player_achieved_objective_chain_03",
				"egs_player_achieved_objective_chain_04"
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
				"egs_player_achieved_objective_chain_01",
				"egs_player_achieved_objective_chain_02",
				"egs_player_achieved_objective_chain_03",
				"egs_player_achieved_objective_chain_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_hitting_bell_late = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"egs_gameplay_hitting_bell_late_01",
				"egs_gameplay_hitting_bell_late_02",
				"egs_gameplay_hitting_bell_late_03",
				"egs_gameplay_hitting_bell_late_04",
				"egs_gameplay_hitting_bell_late_05",
				"egs_gameplay_hitting_bell_late_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
				"egs_gameplay_hitting_bell_late_01",
				"egs_gameplay_hitting_bell_late_02",
				"egs_gameplay_hitting_bell_late_03",
				"egs_gameplay_hitting_bell_late_04",
				"egs_gameplay_hitting_bell_late_05",
				"egs_gameplay_hitting_bell_late_06"
			},
			randomize_indexes = {}
		},
		egs_gameplay_empiresoldier_knock_down = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_empiresoldier_knock_down_01",
				"egs_gameplay_empiresoldier_knock_down_02",
				"egs_gameplay_empiresoldier_knock_down_03",
				"egs_gameplay_empiresoldier_knock_down_04",
				"egs_gameplay_empiresoldier_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		egs_player_achieved_objective_gate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_player_achieved_objective_gate_01",
				"egs_player_achieved_objective_gate_02",
				"egs_player_achieved_objective_gate_03",
				"egs_player_achieved_objective_gate_04"
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
				"egs_player_achieved_objective_gate_01",
				"egs_player_achieved_objective_gate_02",
				"egs_player_achieved_objective_gate_03",
				"egs_player_achieved_objective_gate_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_witchhunter_killed = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_witchhunter_killed_01",
				"egs_gameplay_witchhunter_killed_02",
				"egs_gameplay_witchhunter_killed_03",
				"egs_gameplay_witchhunter_killed_04",
				"egs_gameplay_witchhunter_killed_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		egs_player_achieved_objective = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_player_achieved_objective_01",
				"egs_player_achieved_objective_02",
				"egs_player_achieved_objective_03",
				"egs_player_achieved_objective_04"
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
				"egs_player_achieved_objective_01",
				"egs_player_achieved_objective_02",
				"egs_player_achieved_objective_03",
				"egs_player_achieved_objective_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_witchhunter_knock_down = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_witchhunter_knock_down_01",
				"egs_gameplay_witchhunter_knock_down_02",
				"egs_gameplay_witchhunter_knock_down_03",
				"egs_gameplay_witchhunter_knock_down_04",
				"egs_gameplay_witchhunter_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		egs_gameplay_woodelf_killed = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_woodelf_killed_01",
				"egs_gameplay_woodelf_killed_02",
				"egs_gameplay_woodelf_killed_03",
				"egs_gameplay_woodelf_killed_04",
				"egs_gameplay_woodelf_killed_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		},
		egs_gameplay_hitting_bell_story_reveal_part_1 = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_hitting_bell_story_reveal_part_1_01",
				"egs_gameplay_hitting_bell_story_reveal_part_1_02",
				"egs_gameplay_hitting_bell_story_reveal_part_1_03",
				"egs_gameplay_hitting_bell_story_reveal_part_1_04",
				"egs_gameplay_hitting_bell_story_reveal_part_1_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_hitting_bell_story_reveal_part_1_01",
				"egs_gameplay_hitting_bell_story_reveal_part_1_02",
				"egs_gameplay_hitting_bell_story_reveal_part_1_03",
				"egs_gameplay_hitting_bell_story_reveal_part_1_04",
				"egs_gameplay_hitting_bell_story_reveal_part_1_05"
			},
			randomize_indexes = {}
		},
		egs_gameplay_hitting_bell_story_reveal_part_3 = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_hitting_bell_story_reveal_part_3_01",
				"egs_gameplay_hitting_bell_story_reveal_part_3_02",
				"egs_gameplay_hitting_bell_story_reveal_part_3_03",
				"egs_gameplay_hitting_bell_story_reveal_part_3_04",
				"egs_gameplay_hitting_bell_story_reveal_part_3_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"egs_gameplay_hitting_bell_story_reveal_part_3_01",
				"egs_gameplay_hitting_bell_story_reveal_part_3_02",
				"egs_gameplay_hitting_bell_story_reveal_part_3_03",
				"egs_gameplay_hitting_bell_story_reveal_part_3_04",
				"egs_gameplay_hitting_bell_story_reveal_part_3_05"
			},
			randomize_indexes = {}
		},
		egs_gameplay_started = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_gameplay_started_01",
				"egs_gameplay_started_02",
				"egs_gameplay_started_03",
				"egs_gameplay_started_04"
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
				"egs_gameplay_started_01",
				"egs_gameplay_started_02",
				"egs_gameplay_started_03",
				"egs_gameplay_started_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_hitting_bell_climax = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"egs_gameplay_hitting_bell_climax_01",
				"egs_gameplay_hitting_bell_climax_02",
				"egs_gameplay_hitting_bell_climax_03",
				"egs_gameplay_hitting_bell_climax_04",
				"egs_gameplay_hitting_bell_climax_05",
				"egs_gameplay_hitting_bell_climax_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
				"egs_gameplay_hitting_bell_climax_01",
				"egs_gameplay_hitting_bell_climax_02",
				"egs_gameplay_hitting_bell_climax_03",
				"egs_gameplay_hitting_bell_climax_04",
				"egs_gameplay_hitting_bell_climax_05",
				"egs_gameplay_hitting_bell_climax_06"
			},
			randomize_indexes = {}
		},
		egs_gameplay_woodelf_knock_down = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_woodelf_knock_down_01",
				"egs_gameplay_woodelf_knock_down_02",
				"egs_gameplay_woodelf_knock_down_03",
				"egs_gameplay_woodelf_knock_down_04",
				"egs_gameplay_woodelf_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		egs_player_achieved_objective_kegs = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"egs_player_achieved_objective_kegs_01",
				"egs_player_achieved_objective_kegs_02",
				"egs_player_achieved_objective_kegs_03",
				"egs_player_achieved_objective_kegs_04"
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
				"egs_player_achieved_objective_kegs_01",
				"egs_player_achieved_objective_kegs_02",
				"egs_player_achieved_objective_kegs_03",
				"egs_player_achieved_objective_kegs_04"
			},
			randomize_indexes = {}
		},
		egs_gameplay_brightwizard_killed = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_brightwizard_killed_01",
				"egs_gameplay_brightwizard_killed_02",
				"egs_gameplay_brightwizard_killed_03",
				"egs_gameplay_brightwizard_killed_04",
				"egs_gameplay_brightwizard_killed_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		egs_gameplay_hitting_bell_medium = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"egs_gameplay_hitting_bell_medium_01",
				"egs_gameplay_hitting_bell_medium_02",
				"egs_gameplay_hitting_bell_medium_03",
				"egs_gameplay_hitting_bell_medium_04",
				"egs_gameplay_hitting_bell_medium_05",
				"egs_gameplay_hitting_bell_medium_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
				"egs_gameplay_hitting_bell_medium_01",
				"egs_gameplay_hitting_bell_medium_02",
				"egs_gameplay_hitting_bell_medium_03",
				"egs_gameplay_hitting_bell_medium_04",
				"egs_gameplay_hitting_bell_medium_05",
				"egs_gameplay_hitting_bell_medium_06"
			},
			randomize_indexes = {}
		},
		egs_gameplay_brightwizard_knock_down = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "grey_seer",
			category = "boss_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"egs_gameplay_brightwizard_knock_down_01",
				"egs_gameplay_brightwizard_knock_down_02",
				"egs_gameplay_brightwizard_knock_down_03",
				"egs_gameplay_brightwizard_knock_down_04",
				"egs_gameplay_brightwizard_knock_down_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
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
		}
	})
end
