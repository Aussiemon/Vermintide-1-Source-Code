return function ()
	define_rule({
		name = "pdr_gameplay_seeing_a_stormvermin",
		response = "pdr_gameplay_seeing_a_stormvermin",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_storm_vermin_commander"
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
				"faction_memory",
				"last_seen_storm_vermin_commander",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_storm_vermin_commander",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_seeing_a_gutter_runner",
		response = "pdr_gameplay_seeing_a_gutter_runner",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_gutter_runner"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"faction_memory",
				"last_seen_gutter_runner",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_gutter_runner",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_gutter_runner",
		response = "pdr_gameplay_hearing_a_gutter_runner",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_gutter_runner"
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
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
				"faction_memory",
				"last_seen_gutter_runner",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_gutter_runner",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_gutter_runner",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_seeing_a_globadier",
		response = "pdr_gameplay_seeing_a_globadier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_poison_wind_globadier"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"faction_memory",
				"last_seen_globadier",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_globadier",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_globadier",
		response = "pdr_gameplay_hearing_a_globadier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_poison_wind_globadier"
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
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
				"faction_memory",
				"last_seen_globadier",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_globadier",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_globadier",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_seeing_a_skaven_rat_ogre",
		response = "pdr_gameplay_seeing_a_skaven_rat_ogre",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"faction_memory",
				"last_seen_rate_ogre",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_rate_ogre",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_skaven_rat_ogre",
		response = "pdr_gameplay_hearing_a_skaven_rat_ogre",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
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
				"faction_memory",
				"last_seen_rate_ogre",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_skaven_rat_ogre",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_skaven_rat_ogre",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_incoming_skaven_rat_ogre",
		response = "pdr_gameplay_incoming_skaven_rat_ogre",
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
				"rat_ogre_charge"
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
				"faction_memory",
				"ogre_charges",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"ogre_charges",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hears_incoming_horde",
		response = "pdr_gameplay_hears_incoming_horde",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"horde"
			},
			{
				"query_context",
				"horde_type",
				OP.EQ,
				"vector"
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
				"faction_memory",
				"time_since_horde",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_horde",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_seeing_a_skaven_patrol_stormvermin",
		response = "pdr_gameplay_seeing_a_skaven_patrol_stormvermin",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_storm_vermin"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"faction_memory",
				"last_seen_storm_vermin",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_storm_vermin",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_skaven_patrol_stormvermin",
		response = "pdr_gameplay_hearing_a_skaven_patrol_stormvermin",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_storm_vermin"
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
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
				"faction_memory",
				"last_seen_storm_vermin",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_storm_vermin",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_storm_vermin",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_seeing_a_skaven_slaver",
		response = "pdr_gameplay_seeing_a_skaven_slaver",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_pack_master"
			},
			{
				"query_context",
				"distance",
				OP.GT,
				4
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
				"faction_memory",
				"time_since_slaver",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_slaver",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_seeing_a_skaven_ratling_gun",
		response = "pdr_gameplay_seeing_a_skaven_ratling_gun",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_ratling_gunner"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"faction_memory",
				"last_seen_skaven_ratling_gunner",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_ratling_gunner",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_skaven_ratling_gun",
		response = "pdr_gameplay_hearing_a_skaven_ratling_gun",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_ratling_gunner"
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
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
				"faction_memory",
				"last_seen_skaven_ratling_gunner",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_skaven_ratling_gunner",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_skaven_ratling_gunner",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_tension_no_enemies",
		response = "pdr_gameplay_tension_no_enemies",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemies_distant"
			},
			{
				"query_context",
				"num_units",
				OP.GT,
				5
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				90
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
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
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_killing_globadier",
		response = "pdr_gameplay_killing_globadier",
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
				"skaven_poison_wind_globadier"
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
				"user_memory",
				"time_since_killing_globadier",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_killing_globadier",
				OP.TIMESET
			},
			{
				"faction_memory",
				"dwarf_ranger_special_kills_in_row",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"empire_soldier_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"bright_wizard_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"witch_hunter_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_killing_ratling",
		response = "pdr_gameplay_killing_ratling",
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
				"skaven_ratling_gunner"
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
				"user_memory",
				"time_since_killing_ratling",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_killing_ratling",
				OP.TIMESET
			},
			{
				"faction_memory",
				"dwarf_ranger_special_kills_in_row",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"empire_soldier_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"bright_wizard_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"witch_hunter_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_killing_packmaster",
		response = "pdr_gameplay_killing_packmaster",
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
				"skaven_pack_master"
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
				"user_memory",
				"time_since_killing_packmaster",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_killing_packmaster",
				OP.TIMESET
			},
			{
				"faction_memory",
				"dwarf_ranger_special_kills_in_row",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"empire_soldier_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"bright_wizard_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"witch_hunter_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_killing_gutterrunner",
		response = "pdr_gameplay_killing_gutterrunner",
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
				"skaven_gutter_runner"
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
				"user_memory",
				"time_since_killing_gutterrunner",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_killing_gutterrunner",
				OP.TIMESET
			},
			{
				"faction_memory",
				"dwarf_ranger_special_kills_in_row",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"empire_soldier_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"bright_wizard_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"witch_hunter_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_killing_lootrat",
		response = "pdr_gameplay_killing_lootrat",
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
				"skaven_loot_rat"
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
				"user_memory",
				"time_since_killing_lootrat",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_killing_lootrat",
				OP.TIMESET
			},
			{
				"faction_memory",
				"dwarf_ranger_special_kills_in_row",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"empire_soldier_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"bright_wizard_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"witch_hunter_special_kills_in_row",
				OP.NUMSET,
				0
			},
			{
				"faction_memory",
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_gutter_runner_combat",
		response = "pdr_gameplay_hearing_a_gutter_runner_combat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_gutter_runner"
			},
			{
				"user_context",
				"enemies_close",
				OP.GT,
				0
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
				"faction_memory",
				"last_seen_gutter_runner",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_gutter_runner",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_gutter_runner",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_globadier_combat",
		response = "pdr_gameplay_hearing_a_globadier_combat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_poison_wind_globadier"
			},
			{
				"user_context",
				"enemies_close",
				OP.GT,
				0
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
				"faction_memory",
				"last_seen_globadier",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_globadier",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_globadier",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_skaven_rat_ogre_combat",
		response = "pdr_gameplay_hearing_a_skaven_rat_ogre_combat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_rat_ogre"
			},
			{
				"user_context",
				"enemies_close",
				OP.GT,
				0
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
				"faction_memory",
				"last_seen_rate_ogre",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_skaven_rat_ogre",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_skaven_rat_ogre",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_hearing_a_skaven_ratling_gun_combat",
		response = "pdr_gameplay_hearing_a_skaven_ratling_gun_combat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_ratling_gunner"
			},
			{
				"user_context",
				"enemies_close",
				OP.GT,
				0
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
				"faction_memory",
				"last_seen_skaven_ratling_gunner",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_skaven_ratling_gunner",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_skaven_ratling_gunner",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_globadier_guck",
		response = "pdr_gameplay_globadier_guck",
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
				"pwg_projectile"
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
				"faction_memory",
				"pwg_projectile_thrown",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"pwg_projectile_thrown",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_hit_by_goo",
		name = "pdr_gameplay_hit_by_goo",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"hit_by_goo"
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
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_taking_heavy_damage",
		response = "pdr_gameplay_taking_heavy_damage",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"health_trigger"
			},
			{
				"query_context",
				"trigger_type",
				OP.EQ,
				"losing_rapidly"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
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
				"user_memory",
				"time_since_taking_heavy_damage",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_taking_heavy_damage",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_incoming_globadier",
		response = "pdr_gameplay_incoming_globadier",
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
				"pwg_suicide_run"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"pwg_suicides",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"pwg_suicides",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_knocked_down",
		response = "pdr_gameplay_knocked_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"knocked_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
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
				"user_memory",
				"time_since_knocked_down",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_knocked_down",
				OP.TIMESET
			},
			{
				"faction_memory",
				"times_we_downed",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"times_down_dwarf_ranger",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_player_pounced",
		response = "pdr_gameplay_player_pounced",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"pounced_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
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
				"user_memory",
				"time_since_knocked_down",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_knocked_down",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_empire_soldier_grabbed",
		response = "pdr_gameplay_empire_soldier_grabbed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grabbed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"times_since_we_grabbed",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"times_since_we_grabbed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_witch_hunter_grabbed",
		response = "pdr_gameplay_witch_hunter_grabbed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grabbed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"times_since_we_grabbed",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"times_since_we_grabbed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_bright_wizard_grabbed",
		response = "pdr_gameplay_bright_wizard_grabbed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grabbed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"times_since_we_grabbed",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"times_since_we_grabbed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_wood_elf_grabbed",
		response = "pdr_gameplay_wood_elf_grabbed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"grabbed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
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
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"times_since_we_grabbed",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"times_since_we_grabbed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_heard_empire_soldier_in_trouble",
		response = "pdr_gameplay_heard_empire_soldier_in_trouble",
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
				"speaker_name",
				OP.EQ,
				"empire_soldier"
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
				"faction_memory",
				"times_down_empire_soldier",
				OP.NEQ,
				2
			},
			{
				"faction_memory",
				"time_since_we_downed",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_we_downed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_heard_witch_hunter_in_trouble",
		response = "pdr_gameplay_heard_witch_hunter_in_trouble",
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
				"speaker_name",
				OP.EQ,
				"witch_hunter"
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
				"faction_memory",
				"times_down_witch_hunter",
				OP.NEQ,
				2
			},
			{
				"faction_memory",
				"time_since_we_downed",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_we_downed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_heard_wood_elf_in_trouble",
		response = "pdr_gameplay_heard_wood_elf_in_trouble",
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
				"pwe_gameplay_knocked_down"
			},
			{
				"query_context",
				"speaker_name",
				OP.EQ,
				"wood_elf"
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
				"faction_memory",
				"times_down_wood_elf",
				OP.NEQ,
				2
			},
			{
				"faction_memory",
				"time_since_we_downed",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_we_downed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_heard_bright_wizard_in_trouble",
		response = "pdr_gameplay_heard_bright_wizard_in_trouble",
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
				"speaker_name",
				OP.EQ,
				"bright_wizard"
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
				"faction_memory",
				"times_down_bright_wizard",
				OP.NEQ,
				2
			},
			{
				"faction_memory",
				"time_since_we_downed",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_we_downed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_no_nearby_teammates",
		response = "pdr_gameplay_no_nearby_teammates",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friends_distant"
			},
			{
				"user_context",
				"friends_close",
				OP.EQ,
				0
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				60
			},
			{
				"user_memory",
				"time_since_alone",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_alone",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_empire_soldier_dead",
		response = "pdr_gameplay_empire_soldier_dead",
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
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_pes_death",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_pes_death",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_witch_hunter_dead",
		response = "pdr_gameplay_witch_hunter_dead",
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
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_pwh_death",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_pwh_death",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_wood_elf_dead",
		response = "pdr_gameplay_wood_elf_dead",
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
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_pwe_death",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_pwe_death",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_bright_wizard_dead",
		response = "pdr_gameplay_bright_wizard_dead",
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
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_pbw_death",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_pbw_death",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_ambush_horde_spawned",
		response = "pdr_gameplay_ambush_horde_spawned",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"horde"
			},
			{
				"query_context",
				"horde_type",
				OP.EQ,
				"ambush"
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
				"faction_memory",
				"time_since_ambush",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_ambush",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_casual_quotes",
		response = "pdr_gameplay_casual_quotes",
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
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
			},
			{
				"user_context",
				"enemies_distant",
				OP.EQ,
				0
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
				"current_level",
				OP.NEQ,
				"inn_level"
			},
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_casual_quotes_city_01",
		response = "pdr_gameplay_casual_quotes_city_01",
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
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
			},
			{
				"user_context",
				"enemies_distant",
				OP.EQ,
				0
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
				"current_level",
				OP.EQ,
				"magnus"
			},
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_casual_quotes_city_02",
		response = "pdr_gameplay_casual_quotes_city_02",
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
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
			},
			{
				"user_context",
				"enemies_distant",
				OP.EQ,
				0
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
				"current_level",
				OP.EQ,
				"merchant"
			},
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_empire_soldier_being_helped_up",
		name = "pdr_gameplay_empire_soldier_being_helped_up",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"start_revive"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"empire_soldier"
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
		response = "pdr_gameplay_witch_hunter_being_helped_up",
		name = "pdr_gameplay_witch_hunter_being_helped_up",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"start_revive"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"witch_hunter"
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
		response = "pdr_gameplay_wood_elf_being_helped_up",
		name = "pdr_gameplay_wood_elf_being_helped_up",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"start_revive"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
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
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_bright_wizard_being_helped_up",
		name = "pdr_gameplay_bright_wizard_being_helped_up",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"start_revive"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"bright_wizard"
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
		name = "pdr_gameplay_healing_empire_soldier",
		response = "pdr_gameplay_healing_empire_soldier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_start"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_healing_witch_hunter",
		response = "pdr_gameplay_healing_witch_hunter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_start"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_healing_wood_elf",
		response = "pdr_gameplay_healing_wood_elf",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_start"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
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
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_healing_bright_wizard",
		response = "pdr_gameplay_healing_bright_wizard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_start"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_helped_by_empire_soldier",
		response = "pdr_gameplay_helped_by_empire_soldier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_completed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"healer_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_helped",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_helped",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_helped_by_witch_hunter",
		response = "pdr_gameplay_helped_by_witch_hunter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_completed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"healer_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_helped",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_helped",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_helped_by_wood_elf",
		response = "pdr_gameplay_helped_by_wood_elf",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_completed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"healer_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_helped",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_helped",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_helped_by_bright_wizard",
		response = "pdr_gameplay_helped_by_bright_wizard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_completed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"healer_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_helped",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_helped",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_low_on_health",
		response = "pdr_gameplay_low_on_health",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"health_trigger"
			},
			{
				"query_context",
				"current_amount",
				OP.LTEQ,
				0.4
			},
			{
				"query_context",
				"current_amount",
				OP.GTEQ,
				0.1
			},
			{
				"query_context",
				"trigger_type",
				OP.EQ,
				"decreasing"
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
				"user_memory",
				"low_health",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"low_health",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_empire_soldier_low_on_health",
		response = "pdr_gameplay_empire_soldier_low_on_health",
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
				"pes_gameplay_low_on_health"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_low_health_pes",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_low_health_pes",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_witch_hunter_low_on_health",
		response = "pdr_gameplay_witch_hunter_low_on_health",
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
				"pwh_gameplay_low_on_health"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_low_health_pwh",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_low_health_pwh",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_wood_elf_low_on_health",
		response = "pdr_gameplay_wood_elf_low_on_health",
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
				"pwe_gameplay_low_on_health"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_low_health_pwe",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_low_health_pwe",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_bright_wizard_low_on_health",
		response = "pdr_gameplay_bright_wizard_low_on_health",
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
				"pbw_gameplay_low_on_health"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_low_health_pbw",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_low_health_pbw",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_spots_ammo",
		response = "pdr_gameplay_spots_ammo",
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
				"ammo"
			},
			{
				"query_context",
				"distance",
				OP.GT,
				1
			},
			{
				"query_context",
				"distance",
				OP.LT,
				25
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
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
				"current_level",
				OP.NEQ,
				"inn_level"
			},
			{
				"faction_memory",
				"last_saw_ammo",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_saw_ammo",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_spots_health",
		response = "pdr_gameplay_spots_health",
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
				"health"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"enemies_distant",
				OP.EQ,
				0
			},
			{
				"query_context",
				"distance",
				OP.GT,
				1
			},
			{
				"query_context",
				"distance",
				OP.LT,
				25
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_healing_draught",
		response = "pdr_gameplay_healing_draught",
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
				"health_flask"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"enemies_distant",
				OP.EQ,
				0
			},
			{
				"query_context",
				"distance",
				OP.GT,
				1
			},
			{
				"query_context",
				"distance",
				OP.LT,
				25
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_spots_potion",
		response = "pdr_gameplay_spots_potion",
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
				"potion"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"enemies_close",
				OP.EQ,
				0
			},
			{
				"query_context",
				"distance",
				OP.GT,
				1
			},
			{
				"query_context",
				"distance",
				OP.LT,
				25
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"last_saw_potion",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_saw_potion",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_spots_bomb",
		response = "pdr_gameplay_spots_bomb",
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
				"bomb"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"enemies_close",
				OP.EQ,
				0
			},
			{
				"query_context",
				"distance",
				OP.GT,
				1
			},
			{
				"query_context",
				"distance",
				OP.LT,
				25
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"last_saw_bomb",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_saw_bomb",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_out_of_ammo",
		response = "pdr_gameplay_out_of_ammo",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"reload_failed"
			},
			{
				"query_context",
				"fail_reason",
				OP.EQ,
				"out_of_ammo"
			},
			{
				"query_context",
				"item_name",
				OP.NEQ,
				"healthkit_first_aid_kit_01"
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
				"user_memory",
				"time_since_out_of_ammo",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_out_of_ammo",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_using_potion",
		response = "pdr_gameplay_using_potion",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"on_healing_draught"
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
				"user_memory",
				"time_since_used_potion",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_used_potion",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_self_heal",
		response = "pdr_gameplay_self_heal",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heal_start"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
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
				"user_memory",
				"last_healed_someone",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_healed_someone",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_throwing_bomb",
		response = "pdr_gameplay_throwing_bomb",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"throwing_item"
			},
			{
				"query_context",
				"item_type",
				OP.EQ,
				"grenade"
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
				"user_memory",
				"time_since_throwing_bomb",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_throwing_bomb",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_activating_magic_weapon_offensive",
		response = "pdr_gameplay_activating_magic_weapon_offensive",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"stance_triggered"
			},
			{
				"query_context",
				"stance_type",
				OP.EQ,
				"offensive"
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
				"user_memory",
				"time_since_stance_triggered",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_stance_triggered",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_activating_magic_weapon_defensive",
		response = "pdr_gameplay_activating_magic_weapon_defensive",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"stance_triggered"
			},
			{
				"query_context",
				"stance_type",
				OP.EQ,
				"defensive"
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
				"user_memory",
				"time_since_stance_triggered",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_stance_triggered",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_friendly_fire_witch_hunter",
		response = "pdr_gameplay_friendly_fire_witch_hunter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_friendly_fire",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_friendly_fire_bright_wizard",
		response = "pdr_gameplay_friendly_fire_bright_wizard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_friendly_fire",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_friendly_fire_wood_elf",
		response = "pdr_gameplay_friendly_fire_wood_elf",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_friendly_fire",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_friendly_fire_empire_soldier",
		response = "pdr_gameplay_friendly_fire_empire_soldier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_friendly_fire",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_encouraging_words",
		response = "pdr_gameplay_encouraging_words",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friends_close"
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
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_special_enemy_kill_melee",
		response = "pdr_gameplay_special_enemy_kill_melee",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"killed_enemy"
			},
			{
				"query_context",
				"hit_zone",
				OP.EQ,
				"head"
			},
			{
				"query_context",
				"weapon_slot",
				OP.EQ,
				"slot_melee"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_special_kill_melee",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_special_kill_melee",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_special_enemy_kill_ranged",
		response = "pdr_gameplay_special_enemy_kill_ranged",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"killed_enemy"
			},
			{
				"query_context",
				"hit_zone",
				OP.EQ,
				"head"
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
			},
			{
				"faction_memory",
				"time_since_last_special_kill_ranged",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_special_kill_ranged",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_empire_soldier_on_a_frenzy",
		response = "pdr_gameplay_empire_soldier_on_a_frenzy",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"multikill"
			},
			{
				"query_context",
				"number_of_kills",
				OP.EQ,
				7
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_frenzy_empire_soldier",
				OP.TIMEDIFF,
				OP.GT,
				90
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_frenzy_empire_soldier",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_witch_hunter_on_a_frenzy",
		response = "pdr_gameplay_witch_hunter_on_a_frenzy",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"multikill"
			},
			{
				"query_context",
				"number_of_kills",
				OP.EQ,
				7
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_frenzy_witch_hunter",
				OP.TIMEDIFF,
				OP.GT,
				90
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_frenzy_witch_hunter",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_wood_elf_on_a_frenzy",
		response = "pdr_gameplay_wood_elf_on_a_frenzy",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"multikill"
			},
			{
				"query_context",
				"number_of_kills",
				OP.EQ,
				7
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_frenzy_wood_elf",
				OP.TIMEDIFF,
				OP.GT,
				90
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_frenzy_wood_elf",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_bright_wizard_on_a_frenzy",
		response = "pdr_gameplay_bright_wizard_on_a_frenzy",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"multikill"
			},
			{
				"query_context",
				"number_of_kills",
				OP.EQ,
				7
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_frenzy_bright_wizard",
				OP.TIMEDIFF,
				OP.GT,
				90
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_frenzy_bright_wizard",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_armoured_enemy_witch_hunter",
		response = "pdr_gameplay_armoured_enemy_witch_hunter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_armoured_enemy_bright_wizard",
		response = "pdr_gameplay_armoured_enemy_bright_wizard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_armoured_enemy_wood_elf",
		response = "pdr_gameplay_armoured_enemy_wood_elf",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_armoured_enemy_empire_soldier",
		response = "pdr_gameplay_armoured_enemy_empire_soldier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_interacting_with_objective",
		response = "pdr_objective_interacting_with_objective",
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
				"objective_interacting_with_objective"
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
				"faction_memory",
				"time_since_objective_interacting_with_objective_done",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_interacting_with_objective_done",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_nearing_objective_deadline",
		response = "pdr_objective_nearing_objective_deadline",
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
				"objective_nearing_objective_deadline"
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
				"faction_memory",
				"time_since_objective_nearing_objective_deadline_done",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_nearing_objective_deadline_done",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_achieved_all_but_one_goal",
		response = "pdr_objective_achieved_all_but_one_goal",
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
				"objective_achieved_all_but_one_goal"
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
				"faction_memory",
				"time_since_objective_achieved_all_but_one_goal_done",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_achieved_all_but_one_goal_done",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_goal_achieved_more_left",
		response = "pdr_objective_goal_achieved_more_left",
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
				"objective_goal_achieved_more_left"
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
				"faction_memory",
				"time_since_objective_goal_achieved_more_left_done",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_goal_achieved_more_left_done",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_goal_achieved_escape",
		response = "pdr_objective_goal_achieved_escape",
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
				"objective_goal_achieved_escape"
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
				"faction_memory",
				"time_since_objective_goal_achieved_escape_done",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_goal_achieved_escape_done",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_correct_path_this_way",
		response = "pdr_objective_correct_path_this_way",
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
				"this_way"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"faction_memory",
				"time_since_found_way",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_found_way",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_correct_path_up",
		response = "pdr_objective_correct_path_up",
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
				"this_way_up"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"faction_memory",
				"time_since_found_way_up",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_found_way_up",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_correct_path_down",
		response = "pdr_objective_correct_path_down",
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
				"this_way_down"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"faction_memory",
				"time_since_found_way_down",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_found_way_down",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_correct_path_bridge",
		response = "pdr_objective_correct_path_bridge",
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
				"this_way_bridge"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"faction_memory",
				"time_since_found_way_bridge",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_found way_bridge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_correct_path_street",
		response = "pdr_objective_correct_path_street",
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
				"this_way_street"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"faction_memory",
				"time_since_found_way_street",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_found_way_street",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_correct_path_door",
		response = "pdr_objective_correct_path_door",
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
				"this_way_door"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"faction_memory",
				"time_since_found_way_door",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_found_way_door",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_correct_path_stairs_up",
		response = "pdr_objective_correct_path_stairs_up",
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
				"this_way_stairs_up"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				7
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
				"faction_memory",
				"time_since_found_way_stairs_up",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_found_way_stairs_up",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_correct_path_stairs_down",
		response = "pdr_objective_correct_path_stairs_down",
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
				"this_way_stairs_down"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				7
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
				"faction_memory",
				"time_since_found_way_stairs_down",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_found_way_stairs_down",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_spotting_ferry_lady",
		response = "pdr_spotting_ferry_lady",
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
				"generic_spotting_ferry_lady"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"faction_memory",
				"time_since_spotting_ferry_lady",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_spotting_ferry_lady",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dropping_grimoire",
		response = "pdr_objective_dropping_grimoire",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"throwing_item"
			},
			{
				"query_context",
				"item_type",
				OP.EQ,
				"grimoire"
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
				"user_memory",
				"time_since_throwing_grimoire",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_throwing_grimoire",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_picking_up_grimoire",
		response = "pdr_objective_picking_up_grimoire",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"on_pickup"
			},
			{
				"query_context",
				"pickup_name",
				OP.EQ,
				"pickup_grimoire"
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
				"user_memory",
				"time_since_picking_up_grimoire",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_picking_up_grimoire",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_dead_body",
		response = "pdr_gameplay_dead_body",
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
				"generic_spotting_dead_body"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"level_time ",
				OP.GT,
				120
			},
			{
				"faction_memory",
				"time_since_spotting_dead_body",
				OP.TIMEDIFF,
				OP.GT,
				180
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_spotting_dead_body",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_dead_end",
		response = "pdr_gameplay_dead_end",
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
				"generic_dead_end"
			},
			{
				"query_context",
				"distance",
				OP.LTEQ,
				15
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
				"faction_memory",
				"time_since_dead_end",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dead_end",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_curse",
		response = "pdr_curse",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemies_close"
			},
			{
				"query_context",
				"num_units      ",
				OP.GT,
				5
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
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_casual_quotes",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_overcharge",
		response = "pdr_gameplay_overcharge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"overcharge"
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
				"user_memory",
				"time_since_overcharge",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_overcharge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_targeted_by_ratling",
		response = "pdr_targeted_by_ratling",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"ratling_target"
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
				"user_memory",
				"time_since_ratling_target",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_ratling_target",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pdr_objective_interacting_with_objective = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_objective_interacting_with_objective_01",
				"pdr_objective_interacting_with_objective_02",
				"pdr_objective_interacting_with_objective_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_interacting_with_objective_01",
				"pdr_objective_interacting_with_objective_02",
				"pdr_objective_interacting_with_objective_03"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_seeing_a_stormvermin = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pdr_gameplay_seeing_a_stormvermin_01",
				"pdr_gameplay_seeing_a_stormvermin_02",
				"pdr_gameplay_seeing_a_stormvermin_03",
				"pdr_gameplay_seeing_a_stormvermin_04",
				"pdr_gameplay_seeing_a_stormvermin_05",
				"pdr_gameplay_seeing_a_stormvermin_06",
				"pdr_gameplay_seeing_a_stormvermin_07",
				"pdr_gameplay_seeing_a_stormvermin_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_neutral",
				"face_neutral",
				"face_contempt",
				"face_neutral",
				"face_angry"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_stormvermin_01",
				"pdr_gameplay_seeing_a_stormvermin_02",
				"pdr_gameplay_seeing_a_stormvermin_03",
				"pdr_gameplay_seeing_a_stormvermin_04",
				"pdr_gameplay_seeing_a_stormvermin_05",
				"pdr_gameplay_seeing_a_stormvermin_06",
				"pdr_gameplay_seeing_a_stormvermin_07",
				"pdr_gameplay_seeing_a_stormvermin_08"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_using_potion = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_using_potion_01",
				"pdr_gameplay_using_potion_02",
				"pdr_gameplay_using_potion_03",
				"pdr_gameplay_using_potion_05"
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
				"pdr_gameplay_using_potion_01",
				"pdr_gameplay_using_potion_02",
				"pdr_gameplay_using_potion_03",
				"pdr_gameplay_using_potion_05"
			},
			randomize_indexes = {}
		},
		pdr_targeted_by_ratling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_targeted_by_ratling_01",
				"pdr_targeted_by_ratling_02",
				"pdr_targeted_by_ratling_03",
				"pdr_targeted_by_ratling_04"
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
				"pdr_targeted_by_ratling_01",
				"pdr_targeted_by_ratling_02",
				"pdr_targeted_by_ratling_03",
				"pdr_targeted_by_ratling_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_heard_bright_wizard_in_trouble = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_heard_bright_wizard_in_trouble_01",
				"pdr_gameplay_heard_bright_wizard_in_trouble_02",
				"pdr_gameplay_heard_bright_wizard_in_trouble_03",
				"pdr_gameplay_heard_bright_wizard_in_trouble_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_heard_bright_wizard_in_trouble_01",
				"pdr_gameplay_heard_bright_wizard_in_trouble_02",
				"pdr_gameplay_heard_bright_wizard_in_trouble_03",
				"pdr_gameplay_heard_bright_wizard_in_trouble_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_healing_witch_hunter = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_healing_witch_hunter_01",
				"pdr_gameplay_healing_witch_hunter_02",
				"pdr_gameplay_healing_witch_hunter_03",
				"pdr_gameplay_healing_witch_hunter_04"
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
				"pdr_gameplay_healing_witch_hunter_01",
				"pdr_gameplay_healing_witch_hunter_02",
				"pdr_gameplay_healing_witch_hunter_03",
				"pdr_gameplay_healing_witch_hunter_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_correct_path_stairs_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_correct_path_stairs_up_01",
				"pdr_objective_correct_path_stairs_up_02",
				"pdr_objective_correct_path_stairs_up_03",
				"pdr_objective_correct_path_stairs_up_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_correct_path_stairs_up_01",
				"pdr_objective_correct_path_stairs_up_02",
				"pdr_objective_correct_path_stairs_up_03",
				"pdr_objective_correct_path_stairs_up_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_skaven_rat_ogre = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_hearing_a_skaven_rat_ogre_01",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_04",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_05",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_02",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_03",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_contempt",
				"face_fear"
			},
			localization_strings = {
				"pdr_gameplay_hearing_a_skaven_rat_ogre_01",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_04",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_05",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_02",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_03",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_skaven_ratling_gun_combat = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_gameplay_hearing_a_skaven_ratling_gun_05",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_combat_01",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_hearing_a_skaven_ratling_gun_05",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_combat_01",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_wood_elf_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_wood_elf_dead_01",
				"pdr_gameplay_wood_elf_dead_02",
				"pdr_gameplay_wood_elf_dead_03",
				"pdr_gameplay_wood_elf_dead_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_sadness",
				"face_sadness",
				"face_sadness",
				"face_sadness"
			},
			localization_strings = {
				"pdr_gameplay_wood_elf_dead_01",
				"pdr_gameplay_wood_elf_dead_02",
				"pdr_gameplay_wood_elf_dead_03",
				"pdr_gameplay_wood_elf_dead_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_witch_hunter_on_a_frenzy = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_witch_hunter_on_a_frenzy_01",
				"pdr_gameplay_witch_hunter_on_a_frenzy_02",
				"pdr_gameplay_witch_hunter_on_a_frenzy_03",
				"pdr_gameplay_witch_hunter_on_a_frenzy_04"
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
				"pdr_gameplay_witch_hunter_on_a_frenzy_01",
				"pdr_gameplay_witch_hunter_on_a_frenzy_02",
				"pdr_gameplay_witch_hunter_on_a_frenzy_03",
				"pdr_gameplay_witch_hunter_on_a_frenzy_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_killing_gutterrunner = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_killing_gutterrunner_01",
				"pdr_gameplay_killing_gutterrunner_02",
				"pdr_gameplay_killing_gutterrunner_03",
				"pdr_gameplay_killing_gutterrunner_04"
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
				"pdr_gameplay_killing_gutterrunner_01",
				"pdr_gameplay_killing_gutterrunner_02",
				"pdr_gameplay_killing_gutterrunner_03",
				"pdr_gameplay_killing_gutterrunner_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hit_by_goo = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_hit_by_goo_01",
				"pdr_gameplay_hit_by_goo_02",
				"pdr_gameplay_hit_by_goo_03",
				"pdr_gameplay_hit_by_goo_04",
				"pdr_gameplay_hit_by_goo_05",
				"pdr_gameplay_hit_by_goo_06"
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
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise"
			},
			localization_strings = {
				"pdr_gameplay_hit_by_goo_01",
				"pdr_gameplay_hit_by_goo_02",
				"pdr_gameplay_hit_by_goo_03",
				"pdr_gameplay_hit_by_goo_04",
				"pdr_gameplay_hit_by_goo_05",
				"pdr_gameplay_hit_by_goo_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_wood_elf_grabbed = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_wood_elf_grabbed_01",
				"pdr_gameplay_wood_elf_grabbed_03",
				"pdr_gameplay_wood_elf_grabbed_05",
				"pdr_gameplay_wood_elf_grabbed_02",
				"pdr_gameplay_wood_elf_grabbed_04",
				"pdr_gameplay_wood_elf_grabbed_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_wood_elf_grabbed_01",
				"pdr_gameplay_wood_elf_grabbed_03",
				"pdr_gameplay_wood_elf_grabbed_05",
				"pdr_gameplay_wood_elf_grabbed_02",
				"pdr_gameplay_wood_elf_grabbed_04",
				"pdr_gameplay_wood_elf_grabbed_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_healing_empire_soldier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_healing_empire_soldier_01",
				"pdr_gameplay_healing_empire_soldier_02",
				"pdr_gameplay_healing_empire_soldier_03",
				"pdr_gameplay_healing_empire_soldier_04"
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
				"pdr_gameplay_healing_empire_soldier_01",
				"pdr_gameplay_healing_empire_soldier_02",
				"pdr_gameplay_healing_empire_soldier_03",
				"pdr_gameplay_healing_empire_soldier_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_skaven_patrol_stormvermin = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_01",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_02",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_03",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_04",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_05",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_06",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_07"
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
				"face_nervous",
				"face_concerned",
				"face_concerned",
				"face_nervous",
				"face_nervous",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_01",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_02",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_03",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_04",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_05",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_06",
				"pdr_gameplay_hearing_a_skaven_patrol_stormvermin_07"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_killing_globadier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_killing_globadier_01",
				"pdr_gameplay_killing_globadier_02",
				"pdr_gameplay_killing_globadier_03",
				"pdr_gameplay_killing_globadier_04"
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
				"pdr_gameplay_killing_globadier_01",
				"pdr_gameplay_killing_globadier_02",
				"pdr_gameplay_killing_globadier_03",
				"pdr_gameplay_killing_globadier_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_killing_lootrat = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_killing_lootrat_01",
				"pdr_gameplay_killing_lootrat_02",
				"pdr_gameplay_killing_lootrat_03",
				"pdr_gameplay_killing_lootrat_04"
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
				"pdr_gameplay_killing_lootrat_01",
				"pdr_gameplay_killing_lootrat_02",
				"pdr_gameplay_killing_lootrat_03",
				"pdr_gameplay_killing_lootrat_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_empire_soldier_grabbed = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_empire_soldier_grabbed_01",
				"pdr_gameplay_empire_soldier_grabbed_02",
				"pdr_gameplay_empire_soldier_grabbed_03",
				"pdr_gameplay_empire_soldier_grabbed_04",
				"pdr_gameplay_empire_soldier_grabbed_05",
				"pdr_gameplay_empire_soldier_grabbed_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_empire_soldier_grabbed_01",
				"pdr_gameplay_empire_soldier_grabbed_02",
				"pdr_gameplay_empire_soldier_grabbed_03",
				"pdr_gameplay_empire_soldier_grabbed_04",
				"pdr_gameplay_empire_soldier_grabbed_05",
				"pdr_gameplay_empire_soldier_grabbed_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hears_incoming_horde = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pdr_gameplay_hears_incoming_horde_01",
				"pdr_gameplay_hears_incoming_horde_02",
				"pdr_gameplay_hears_incoming_horde_03",
				"pdr_gameplay_hears_incoming_horde_04",
				"pdr_gameplay_hears_incoming_horde_05",
				"pdr_gameplay_hears_incoming_horde_06",
				"pdr_gameplay_hears_incoming_horde_07",
				"pdr_gameplay_hears_incoming_horde_09"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_smug",
				"face_smug",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pdr_gameplay_hears_incoming_horde_01",
				"pdr_gameplay_hears_incoming_horde_02",
				"pdr_gameplay_hears_incoming_horde_03",
				"pdr_gameplay_hears_incoming_horde_04",
				"pdr_gameplay_hears_incoming_horde_05",
				"pdr_gameplay_hears_incoming_horde_06",
				"pdr_gameplay_hears_incoming_horde_07",
				"pdr_gameplay_hears_incoming_horde_09"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_witch_hunter_grabbed = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_witch_hunter_grabbed_01",
				"pdr_gameplay_witch_hunter_grabbed_02",
				"pdr_gameplay_witch_hunter_grabbed_03",
				"pdr_gameplay_witch_hunter_grabbed_04",
				"pdr_gameplay_witch_hunter_grabbed_05",
				"pdr_gameplay_witch_hunter_grabbed_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_witch_hunter_grabbed_01",
				"pdr_gameplay_witch_hunter_grabbed_02",
				"pdr_gameplay_witch_hunter_grabbed_03",
				"pdr_gameplay_witch_hunter_grabbed_04",
				"pdr_gameplay_witch_hunter_grabbed_05",
				"pdr_gameplay_witch_hunter_grabbed_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_overcharge = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_overcharge_01",
				"pdr_gameplay_overcharge_02",
				"pdr_gameplay_overcharge_03",
				"pdr_gameplay_overcharge_04",
				"pdr_gameplay_overcharge_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_pain",
				"face_pain",
				"face_pain",
				"face_pain",
				"face_pain"
			},
			localization_strings = {
				"pdr_gameplay_overcharge_01",
				"pdr_gameplay_overcharge_02",
				"pdr_gameplay_overcharge_03",
				"pdr_gameplay_overcharge_04",
				"pdr_gameplay_overcharge_05"
			},
			randomize_indexes = {}
		},
		pdr_curse = {
			sound_events_n = 12,
			randomize_indexes_n = 0,
			face_animations_n = 12,
			database = "dwarf_ranger",
			category = "casual_talk",
			dialogue_animations_n = 12,
			sound_events = {
				"pdr_curse_01",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_06",
				"pdr_curse_07",
				"pdr_curse_08",
				"pdr_curse_09",
				"pdr_curse_10",
				"pdr_curse_11",
				"pdr_curse_12"
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
				"face_angry"
			},
			localization_strings = {
				"pdr_curse_01",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_06",
				"pdr_curse_07",
				"pdr_curse_08",
				"pdr_curse_09",
				"pdr_curse_10",
				"pdr_curse_11",
				"pdr_curse_12"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_dead_end = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_dead_end_01",
				"pdr_gameplay_dead_end_02",
				"pdr_gameplay_dead_end_03",
				"pdr_gameplay_dead_end_04",
				"pdr_gameplay_dead_end_05",
				"pdr_gameplay_dead_end_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_dead_end_01",
				"pdr_gameplay_dead_end_02",
				"pdr_gameplay_dead_end_03",
				"pdr_gameplay_dead_end_04",
				"pdr_gameplay_dead_end_05",
				"pdr_gameplay_dead_end_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_armoured_enemy_bright_wizard = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_gameplay_armoured_enemy_bright_wizard_01",
				"pdr_gameplay_armoured_enemy_bright_wizard_02",
				"pdr_gameplay_armoured_enemy_bright_wizard_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_armoured_enemy_bright_wizard_01",
				"pdr_gameplay_armoured_enemy_bright_wizard_02",
				"pdr_gameplay_armoured_enemy_bright_wizard_03"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_skaven_rat_ogre_combat = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_hearing_a_skaven_rat_ogre_01",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_01",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_04",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pdr_gameplay_hearing_a_skaven_rat_ogre_01",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_01",
				"pdr_gameplay_hearing_a_skaven_rat_ogre_04",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_03"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_incoming_globadier = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_incoming_globadier_01",
				"pdr_gameplay_incoming_globadier_02",
				"pdr_gameplay_incoming_globadier_03",
				"pdr_gameplay_incoming_globadier_04",
				"pdr_gameplay_incoming_globadier_05",
				"pdr_gameplay_incoming_globadier_06"
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
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pdr_gameplay_incoming_globadier_01",
				"pdr_gameplay_incoming_globadier_02",
				"pdr_gameplay_incoming_globadier_03",
				"pdr_gameplay_incoming_globadier_04",
				"pdr_gameplay_incoming_globadier_05",
				"pdr_gameplay_incoming_globadier_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_dead_body = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "casual_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_dead_body_01",
				"pdr_gameplay_dead_body_02",
				"pdr_gameplay_dead_body_03",
				"pdr_gameplay_dead_body_04",
				"pdr_gameplay_dead_body_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_dead_body_01",
				"pdr_gameplay_dead_body_02",
				"pdr_gameplay_dead_body_03",
				"pdr_gameplay_dead_body_04",
				"pdr_gameplay_dead_body_05"
			},
			randomize_indexes = {}
		},
		pdr_objective_picking_up_grimoire = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_picking_up_grimoire_01",
				"pdr_objective_picking_up_grimoire_02",
				"pdr_objective_picking_up_grimoire_03",
				"pdr_objective_picking_up_grimoire_04"
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
				"pdr_objective_picking_up_grimoire_01",
				"pdr_objective_picking_up_grimoire_02",
				"pdr_objective_picking_up_grimoire_03",
				"pdr_objective_picking_up_grimoire_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_empire_soldier_on_a_frenzy = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_empire_soldier_on_a_frenzy_01",
				"pdr_gameplay_empire_soldier_on_a_frenzy_02",
				"pdr_gameplay_empire_soldier_on_a_frenzy_03",
				"pdr_gameplay_empire_soldier_on_a_frenzy_04"
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
				"pdr_gameplay_empire_soldier_on_a_frenzy_01",
				"pdr_gameplay_empire_soldier_on_a_frenzy_02",
				"pdr_gameplay_empire_soldier_on_a_frenzy_03",
				"pdr_gameplay_empire_soldier_on_a_frenzy_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_ambush_horde_spawned = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_ambush_horde_spawned_01",
				"pdr_gameplay_ambush_horde_spawned_02",
				"pdr_gameplay_ambush_horde_spawned_03",
				"pdr_gameplay_ambush_horde_spawned_04",
				"pdr_gameplay_ambush_horde_spawned_05",
				"pdr_gameplay_ambush_horde_spawned_06"
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
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise"
			},
			localization_strings = {
				"pdr_gameplay_ambush_horde_spawned_01",
				"pdr_gameplay_ambush_horde_spawned_02",
				"pdr_gameplay_ambush_horde_spawned_03",
				"pdr_gameplay_ambush_horde_spawned_04",
				"pdr_gameplay_ambush_horde_spawned_05",
				"pdr_gameplay_ambush_horde_spawned_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_no_nearby_teammates = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "casual_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_no_nearby_teammates_01",
				"pdr_gameplay_no_nearby_teammates_02",
				"pdr_gameplay_no_nearby_teammates_03",
				"pdr_gameplay_no_nearby_teammates_04",
				"pdr_gameplay_no_nearby_teammates_05",
				"pdr_gameplay_no_nearby_teammates_06"
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
				"face_nervous",
				"face_nervous",
				"face_nervous",
				"face_nervous",
				"face_nervous",
				"face_nervous"
			},
			localization_strings = {
				"pdr_gameplay_no_nearby_teammates_01",
				"pdr_gameplay_no_nearby_teammates_02",
				"pdr_gameplay_no_nearby_teammates_03",
				"pdr_gameplay_no_nearby_teammates_04",
				"pdr_gameplay_no_nearby_teammates_05",
				"pdr_gameplay_no_nearby_teammates_06"
			},
			randomize_indexes = {}
		},
		pdr_objective_correct_path_this_way = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_objective_correct_path_this_way_01",
				"pdr_objective_correct_path_this_way_02",
				"pdr_objective_correct_path_this_way_03",
				"pdr_objective_correct_path_this_way_04",
				"pdr_objective_correct_path_this_way_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_correct_path_this_way_01",
				"pdr_objective_correct_path_this_way_02",
				"pdr_objective_correct_path_this_way_03",
				"pdr_objective_correct_path_this_way_04",
				"pdr_objective_correct_path_this_way_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_killing_ratling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_killing_ratling_01",
				"pdr_gameplay_killing_ratling_02",
				"pdr_gameplay_killing_ratling_03",
				"pdr_gameplay_killing_ratling_04"
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
				"pdr_gameplay_killing_ratling_01",
				"pdr_gameplay_killing_ratling_02",
				"pdr_gameplay_killing_ratling_03",
				"pdr_gameplay_killing_ratling_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_casual_quotes_city_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_ranger",
			category = "casual_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_casual_quotes_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_casual_quotes_02"
			}
		},
		pdr_spotting_ferry_lady = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_spotting_ferry_lady_01",
				"pdr_spotting_ferry_lady_02",
				"pdr_spotting_ferry_lady_03",
				"pdr_spotting_ferry_lady_04",
				"pdr_spotting_ferry_lady_05",
				"pdr_spotting_ferry_lady_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_spotting_ferry_lady_01",
				"pdr_spotting_ferry_lady_02",
				"pdr_spotting_ferry_lady_03",
				"pdr_spotting_ferry_lady_04",
				"pdr_spotting_ferry_lady_05",
				"pdr_spotting_ferry_lady_06"
			},
			randomize_indexes = {}
		},
		pdr_objective_correct_path_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_correct_path_up_01",
				"pdr_objective_correct_path_up_02",
				"pdr_objective_correct_path_up_03",
				"pdr_objective_correct_path_up_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_correct_path_up_01",
				"pdr_objective_correct_path_up_02",
				"pdr_objective_correct_path_up_03",
				"pdr_objective_correct_path_up_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_correct_path_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_correct_path_door_01",
				"pdr_objective_correct_path_door_02",
				"pdr_objective_correct_path_door_03",
				"pdr_objective_correct_path_door_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_correct_path_door_01",
				"pdr_objective_correct_path_door_02",
				"pdr_objective_correct_path_door_03",
				"pdr_objective_correct_path_door_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_heard_empire_soldier_in_trouble = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_heard_empire_soldier_in_trouble_01",
				"pdr_gameplay_heard_empire_soldier_in_trouble_02",
				"pdr_gameplay_heard_empire_soldier_in_trouble_03",
				"pdr_gameplay_heard_empire_soldier_in_trouble_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_heard_empire_soldier_in_trouble_01",
				"pdr_gameplay_heard_empire_soldier_in_trouble_02",
				"pdr_gameplay_heard_empire_soldier_in_trouble_03",
				"pdr_gameplay_heard_empire_soldier_in_trouble_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_knocked_down = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_knocked_down_01",
				"pdr_gameplay_knocked_down_02",
				"pdr_gameplay_knocked_down_03",
				"pdr_gameplay_knocked_down_04",
				"pdr_gameplay_knocked_down_05",
				"pdr_gameplay_knocked_down_06"
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
				"face_fear",
				"face_fear",
				"face_exhausted"
			},
			localization_strings = {
				"pdr_gameplay_knocked_down_01",
				"pdr_gameplay_knocked_down_02",
				"pdr_gameplay_knocked_down_03",
				"pdr_gameplay_knocked_down_04",
				"pdr_gameplay_knocked_down_05",
				"pdr_gameplay_knocked_down_06"
			},
			randomize_indexes = {}
		},
		pdr_objective_correct_path_street = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_correct_path_street_01",
				"pdr_objective_correct_path_street_02",
				"pdr_objective_correct_path_street_03",
				"pdr_objective_correct_path_street_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_correct_path_street_01",
				"pdr_objective_correct_path_street_02",
				"pdr_objective_correct_path_street_03",
				"pdr_objective_correct_path_street_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_gutter_runner = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_hearing_a_gutter_runner_01",
				"pdr_gameplay_hearing_a_gutter_runner_02",
				"pdr_gameplay_hearing_a_gutter_runner_03",
				"pdr_gameplay_hearing_a_gutter_runner_04",
				"pdr_gameplay_hearing_a_gutter_runner_05",
				"pdr_gameplay_hearing_a_gutter_runner_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pdr_gameplay_hearing_a_gutter_runner_01",
				"pdr_gameplay_hearing_a_gutter_runner_02",
				"pdr_gameplay_hearing_a_gutter_runner_03",
				"pdr_gameplay_hearing_a_gutter_runner_04",
				"pdr_gameplay_hearing_a_gutter_runner_05",
				"pdr_gameplay_hearing_a_gutter_runner_06"
			},
			randomize_indexes = {}
		},
		pdr_objective_correct_path_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_correct_path_bridge_01",
				"pdr_objective_correct_path_bridge_14",
				"pdr_objective_correct_path_bridge_15",
				"pdr_objective_correct_path_bridge_16"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_correct_path_bridge_01",
				"pdr_objective_correct_path_bridge_14",
				"pdr_objective_correct_path_bridge_15",
				"pdr_objective_correct_path_bridge_16"
			},
			randomize_indexes = {}
		},
		pdr_objective_correct_path_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_correct_path_down_01",
				"pdr_objective_correct_path_down_02",
				"pdr_objective_correct_path_down_03",
				"pdr_objective_correct_path_down_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_correct_path_down_01",
				"pdr_objective_correct_path_down_02",
				"pdr_objective_correct_path_down_03",
				"pdr_objective_correct_path_down_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_seeing_a_globadier = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_seeing_a_globadier_01",
				"pdr_gameplay_seeing_a_globadier_03",
				"pdr_gameplay_seeing_a_globadier_04",
				"pdr_gameplay_seeing_a_globadier_02",
				"pdr_gameplay_seeing_a_globadier_05",
				"pdr_gameplay_seeing_a_globadier_06"
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
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_globadier_01",
				"pdr_gameplay_seeing_a_globadier_03",
				"pdr_gameplay_seeing_a_globadier_04",
				"pdr_gameplay_seeing_a_globadier_02",
				"pdr_gameplay_seeing_a_globadier_05",
				"pdr_gameplay_seeing_a_globadier_06"
			},
			randomize_indexes = {}
		},
		pdr_objective_correct_path_stairs_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_correct_path_stairs_down_01",
				"pdr_objective_correct_path_stairs_down_02",
				"pdr_objective_correct_path_stairs_down_03",
				"pdr_objective_correct_path_stairs_down_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_correct_path_stairs_down_01",
				"pdr_objective_correct_path_stairs_down_02",
				"pdr_objective_correct_path_stairs_down_03",
				"pdr_objective_correct_path_stairs_down_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_goal_achieved_escape = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_goal_achieved_escape_01",
				"pdr_objective_goal_achieved_escape_02",
				"pdr_objective_goal_achieved_escape_03",
				"pdr_objective_goal_achieved_escape_04"
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
				"pdr_objective_goal_achieved_escape_01",
				"pdr_objective_goal_achieved_escape_02",
				"pdr_objective_goal_achieved_escape_03",
				"pdr_objective_goal_achieved_escape_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_armoured_enemy_witch_hunter = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_gameplay_armoured_enemy_witch_hunter_01",
				"pdr_gameplay_armoured_enemy_witch_hunter_02",
				"pdr_gameplay_armoured_enemy_witch_hunter_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_armoured_enemy_witch_hunter_01",
				"pdr_gameplay_armoured_enemy_witch_hunter_02",
				"pdr_gameplay_armoured_enemy_witch_hunter_03"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_globadier = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_hearing_a_globadier_02",
				"pdr_gameplay_hearing_a_globadier_05",
				"pdr_gameplay_hearing_a_globadier_06",
				"pdr_gameplay_hearing_a_globadier_01",
				"pdr_gameplay_hearing_a_globadier_03",
				"pdr_gameplay_hearing_a_globadier_04"
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
				"face_contempt",
				"face_fear",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pdr_gameplay_hearing_a_globadier_02",
				"pdr_gameplay_hearing_a_globadier_05",
				"pdr_gameplay_hearing_a_globadier_06",
				"pdr_gameplay_hearing_a_globadier_01",
				"pdr_gameplay_hearing_a_globadier_03",
				"pdr_gameplay_hearing_a_globadier_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_player_pounced = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_player_pounced_01",
				"pdr_gameplay_player_pounced_02",
				"pdr_gameplay_player_pounced_03",
				"pdr_gameplay_player_pounced_04",
				"pdr_gameplay_player_pounced_05",
				"pdr_gameplay_player_pounced_06"
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
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pdr_gameplay_player_pounced_01",
				"pdr_gameplay_player_pounced_02",
				"pdr_gameplay_player_pounced_03",
				"pdr_gameplay_player_pounced_04",
				"pdr_gameplay_player_pounced_05",
				"pdr_gameplay_player_pounced_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_casual_quotes_city_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_ranger",
			category = "casual_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_gameplay_casual_quotes_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_gameplay_casual_quotes_02"
			}
		},
		pdr_objective_achieved_all_but_one_goal = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_achieved_all_but_one_goal_01",
				"pdr_objective_achieved_all_but_one_goal_02",
				"pdr_objective_achieved_all_but_one_goal_03",
				"pdr_objective_achieved_all_but_one_goal_04"
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
				"pdr_objective_achieved_all_but_one_goal_01",
				"pdr_objective_achieved_all_but_one_goal_02",
				"pdr_objective_achieved_all_but_one_goal_03",
				"pdr_objective_achieved_all_but_one_goal_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_helped_by_bright_wizard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "help_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_helped_by_bright_wizard_01",
				"pdr_gameplay_helped_by_bright_wizard_02",
				"pdr_gameplay_helped_by_bright_wizard_03",
				"pdr_gameplay_helped_by_bright_wizard_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_helped_by_bright_wizard_01",
				"pdr_gameplay_helped_by_bright_wizard_02",
				"pdr_gameplay_helped_by_bright_wizard_03",
				"pdr_gameplay_helped_by_bright_wizard_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_encouraging_words = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "casual_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_encouraging_words_01",
				"pdr_gameplay_encouraging_words_02",
				"pdr_gameplay_encouraging_words_03",
				"pdr_gameplay_encouraging_words_04",
				"pdr_gameplay_encouraging_words_05",
				"pdr_gameplay_encouraging_words_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_encouraging_words_01",
				"pdr_gameplay_encouraging_words_02",
				"pdr_gameplay_encouraging_words_03",
				"pdr_gameplay_encouraging_words_04",
				"pdr_gameplay_encouraging_words_05",
				"pdr_gameplay_encouraging_words_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_empire_soldier_being_helped_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_empire_soldier_being_helped_up_01",
				"pdr_gameplay_empire_soldier_being_helped_up_02",
				"pdr_gameplay_empire_soldier_being_helped_up_03",
				"pdr_gameplay_empire_soldier_being_helped_up_04"
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
				"pdr_gameplay_empire_soldier_being_helped_up_01",
				"pdr_gameplay_empire_soldier_being_helped_up_02",
				"pdr_gameplay_empire_soldier_being_helped_up_03",
				"pdr_gameplay_empire_soldier_being_helped_up_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_bright_wizard_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_bright_wizard_dead_01",
				"pdr_gameplay_bright_wizard_dead_02",
				"pdr_gameplay_bright_wizard_dead_03",
				"pdr_gameplay_bright_wizard_dead_04"
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
				"pdr_gameplay_bright_wizard_dead_01",
				"pdr_gameplay_bright_wizard_dead_02",
				"pdr_gameplay_bright_wizard_dead_03",
				"pdr_gameplay_bright_wizard_dead_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_armoured_enemy_empire_soldier = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_gameplay_armoured_enemy_empire_soldier_01",
				"pdr_gameplay_armoured_enemy_empire_soldier_02",
				"pdr_gameplay_armoured_enemy_empire_soldier_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_armoured_enemy_empire_soldier_01",
				"pdr_gameplay_armoured_enemy_empire_soldier_02",
				"pdr_gameplay_armoured_enemy_empire_soldier_03"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_spots_potion = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "seen_items",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_spots_potion_01",
				"pdr_gameplay_spots_potion_02",
				"pdr_gameplay_spots_potion_03",
				"pdr_gameplay_spots_potion_04",
				"pdr_gameplay_spots_potion_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_spots_potion_01",
				"pdr_gameplay_spots_potion_02",
				"pdr_gameplay_spots_potion_03",
				"pdr_gameplay_spots_potion_04",
				"pdr_gameplay_spots_potion_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_witch_hunter_being_helped_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_witch_hunter_being_helped_up_01",
				"pdr_gameplay_witch_hunter_being_helped_up_02",
				"pdr_gameplay_witch_hunter_being_helped_up_03",
				"pdr_gameplay_witch_hunter_being_helped_up_04"
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
				"pdr_gameplay_witch_hunter_being_helped_up_01",
				"pdr_gameplay_witch_hunter_being_helped_up_02",
				"pdr_gameplay_witch_hunter_being_helped_up_03",
				"pdr_gameplay_witch_hunter_being_helped_up_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_heard_wood_elf_in_trouble = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_heard_wood_elf_in_trouble_01",
				"pdr_gameplay_heard_wood_elf_in_trouble_02",
				"pdr_gameplay_heard_wood_elf_in_trouble_03",
				"pdr_gameplay_heard_wood_elf_in_trouble_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_heard_wood_elf_in_trouble_01",
				"pdr_gameplay_heard_wood_elf_in_trouble_02",
				"pdr_gameplay_heard_wood_elf_in_trouble_03",
				"pdr_gameplay_heard_wood_elf_in_trouble_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_wood_elf_on_a_frenzy = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_wood_elf_on_a_frenzy_01",
				"pdr_gameplay_wood_elf_on_a_frenzy_02",
				"pdr_gameplay_wood_elf_on_a_frenzy_03",
				"pdr_gameplay_wood_elf_on_a_frenzy_04"
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
				"pdr_gameplay_wood_elf_on_a_frenzy_01",
				"pdr_gameplay_wood_elf_on_a_frenzy_02",
				"pdr_gameplay_wood_elf_on_a_frenzy_03",
				"pdr_gameplay_wood_elf_on_a_frenzy_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_healing_wood_elf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_healing_wood_elf_01",
				"pdr_gameplay_healing_wood_elf_02",
				"pdr_gameplay_healing_wood_elf_03",
				"pdr_gameplay_healing_wood_elf_04"
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
				"pdr_gameplay_healing_wood_elf_01",
				"pdr_gameplay_healing_wood_elf_02",
				"pdr_gameplay_healing_wood_elf_03",
				"pdr_gameplay_healing_wood_elf_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_special_enemy_kill_ranged = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_special_enemy_kill_ranged_01",
				"pdr_gameplay_special_enemy_kill_ranged_02",
				"pdr_gameplay_special_enemy_kill_ranged_03",
				"pdr_gameplay_special_enemy_kill_ranged_04",
				"pdr_gameplay_special_enemy_kill_ranged_05",
				"pdr_gameplay_special_enemy_kill_ranged_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_special_enemy_kill_ranged_01",
				"pdr_gameplay_special_enemy_kill_ranged_02",
				"pdr_gameplay_special_enemy_kill_ranged_03",
				"pdr_gameplay_special_enemy_kill_ranged_04",
				"pdr_gameplay_special_enemy_kill_ranged_05",
				"pdr_gameplay_special_enemy_kill_ranged_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_bright_wizard_grabbed = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_bright_wizard_grabbed_01",
				"pdr_gameplay_bright_wizard_grabbed_02",
				"pdr_gameplay_bright_wizard_grabbed_03",
				"pdr_gameplay_bright_wizard_grabbed_04",
				"pdr_gameplay_bright_wizard_grabbed_05",
				"pdr_gameplay_bright_wizard_grabbed_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_bright_wizard_grabbed_01",
				"pdr_gameplay_bright_wizard_grabbed_02",
				"pdr_gameplay_bright_wizard_grabbed_03",
				"pdr_gameplay_bright_wizard_grabbed_04",
				"pdr_gameplay_bright_wizard_grabbed_05",
				"pdr_gameplay_bright_wizard_grabbed_06"
			},
			randomize_indexes = {}
		},
		pdr_objective_nearing_objective_deadline = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_objective_nearing_objective_deadline_01",
				"pdr_objective_nearing_objective_deadline_02",
				"pdr_objective_nearing_objective_deadline_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_nearing_objective_deadline_01",
				"pdr_objective_nearing_objective_deadline_02",
				"pdr_objective_nearing_objective_deadline_03"
			},
			randomize_indexes = {}
		},
		pdr_objective_dropping_grimoire = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dropping_grimoire_01",
				"pdr_objective_dropping_grimoire_02",
				"pdr_objective_dropping_grimoire_03",
				"pdr_objective_dropping_grimoire_04"
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
				"pdr_objective_dropping_grimoire_01",
				"pdr_objective_dropping_grimoire_02",
				"pdr_objective_dropping_grimoire_03",
				"pdr_objective_dropping_grimoire_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_activating_magic_weapon_offensive = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_activating_magic_weapon_offensive_01",
				"pdr_gameplay_activating_magic_weapon_offensive_02",
				"pdr_gameplay_activating_magic_weapon_offensive_03",
				"pdr_gameplay_activating_magic_weapon_offensive_04",
				"pdr_gameplay_activating_magic_weapon_offensive_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_activating_magic_weapon_offensive_01",
				"pdr_gameplay_activating_magic_weapon_offensive_02",
				"pdr_gameplay_activating_magic_weapon_offensive_03",
				"pdr_gameplay_activating_magic_weapon_offensive_04",
				"pdr_gameplay_activating_magic_weapon_offensive_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_helped_by_wood_elf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "help_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_helped_by_wood_elf_01",
				"pdr_gameplay_helped_by_wood_elf_02",
				"pdr_gameplay_helped_by_wood_elf_03",
				"pdr_gameplay_helped_by_wood_elf_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_helped_by_wood_elf_01",
				"pdr_gameplay_helped_by_wood_elf_02",
				"pdr_gameplay_helped_by_wood_elf_03",
				"pdr_gameplay_helped_by_wood_elf_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_spots_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "seen_items",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_spots_health_01",
				"pdr_gameplay_spots_health_03",
				"pdr_gameplay_spots_health_04",
				"pdr_gameplay_spots_health_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_spots_health_01",
				"pdr_gameplay_spots_health_03",
				"pdr_gameplay_spots_health_04",
				"pdr_gameplay_spots_health_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_friendly_fire_witch_hunter = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_friendly_fire_witch_hunter_01",
				"pdr_gameplay_friendly_fire_witch_hunter_02",
				"pdr_gameplay_friendly_fire_witch_hunter_03",
				"pdr_gameplay_friendly_fire_witch_hunter_04"
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
				"pdr_gameplay_friendly_fire_witch_hunter_01",
				"pdr_gameplay_friendly_fire_witch_hunter_02",
				"pdr_gameplay_friendly_fire_witch_hunter_03",
				"pdr_gameplay_friendly_fire_witch_hunter_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_bright_wizard_on_a_frenzy = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_bright_wizard_on_a_frenzy_01",
				"pdr_gameplay_bright_wizard_on_a_frenzy_02",
				"pdr_gameplay_bright_wizard_on_a_frenzy_03",
				"pdr_gameplay_bright_wizard_on_a_frenzy_04"
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
				"pdr_gameplay_bright_wizard_on_a_frenzy_01",
				"pdr_gameplay_bright_wizard_on_a_frenzy_02",
				"pdr_gameplay_bright_wizard_on_a_frenzy_03",
				"pdr_gameplay_bright_wizard_on_a_frenzy_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_empire_soldier_low_on_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_empire_soldier_low_on_health_01",
				"pdr_gameplay_empire_soldier_low_on_health_02",
				"pdr_gameplay_empire_soldier_low_on_health_03",
				"pdr_gameplay_empire_soldier_low_on_health_04"
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
				"pdr_gameplay_empire_soldier_low_on_health_01",
				"pdr_gameplay_empire_soldier_low_on_health_02",
				"pdr_gameplay_empire_soldier_low_on_health_03",
				"pdr_gameplay_empire_soldier_low_on_health_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_throwing_bomb = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_throwing_bomb_01",
				"pdr_gameplay_throwing_bomb_02",
				"pdr_gameplay_throwing_bomb_03",
				"pdr_gameplay_throwing_bomb_04",
				"pdr_gameplay_throwing_bomb_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_throwing_bomb_01",
				"pdr_gameplay_throwing_bomb_02",
				"pdr_gameplay_throwing_bomb_03",
				"pdr_gameplay_throwing_bomb_04",
				"pdr_gameplay_throwing_bomb_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_self_heal = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_self_heal_01",
				"pdr_gameplay_self_heal_02",
				"pdr_gameplay_self_heal_03",
				"pdr_gameplay_self_heal_04",
				"pdr_gameplay_self_heal_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted"
			},
			localization_strings = {
				"pdr_gameplay_self_heal_01",
				"pdr_gameplay_self_heal_02",
				"pdr_gameplay_self_heal_03",
				"pdr_gameplay_self_heal_04",
				"pdr_gameplay_self_heal_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_seeing_a_skaven_rat_ogre = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_seeing_a_skaven_rat_ogre_01",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_04",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_06",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_02",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_03",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_05"
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
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_skaven_rat_ogre_01",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_04",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_06",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_02",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_03",
				"pdr_gameplay_seeing_a_skaven_rat_ogre_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_out_of_ammo = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_out_of_ammo_01",
				"pdr_gameplay_out_of_ammo_02",
				"pdr_gameplay_out_of_ammo_03",
				"pdr_gameplay_out_of_ammo_04",
				"pdr_gameplay_out_of_ammo_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pdr_gameplay_out_of_ammo_01",
				"pdr_gameplay_out_of_ammo_02",
				"pdr_gameplay_out_of_ammo_03",
				"pdr_gameplay_out_of_ammo_04",
				"pdr_gameplay_out_of_ammo_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_spots_bomb = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "seen_items",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_spots_bomb_01",
				"pdr_gameplay_spots_bomb_02",
				"pdr_gameplay_spots_bomb_03",
				"pdr_gameplay_spots_bomb_04",
				"pdr_gameplay_spots_bomb_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_spots_bomb_01",
				"pdr_gameplay_spots_bomb_02",
				"pdr_gameplay_spots_bomb_03",
				"pdr_gameplay_spots_bomb_04",
				"pdr_gameplay_spots_bomb_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_healing_draught = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "dwarf_ranger",
			category = "seen_items",
			dialogue_animations_n = 8,
			sound_events = {
				"pdr_gameplay_healing_draught_01",
				"pdr_gameplay_healing_draught_02",
				"pdr_gameplay_healing_draught_03",
				"pdr_gameplay_healing_draught_04",
				"pdr_gameplay_healing_draught_05",
				"pdr_gameplay_healing_draught_06",
				"pdr_gameplay_healing_draught_07",
				"pdr_gameplay_healing_draught_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_healing_draught_01",
				"pdr_gameplay_healing_draught_02",
				"pdr_gameplay_healing_draught_03",
				"pdr_gameplay_healing_draught_04",
				"pdr_gameplay_healing_draught_05",
				"pdr_gameplay_healing_draught_06",
				"pdr_gameplay_healing_draught_07",
				"pdr_gameplay_healing_draught_08"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_friendly_fire_bright_wizard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_friendly_fire_bright_wizard_01",
				"pdr_gameplay_friendly_fire_bright_wizard_02",
				"pdr_gameplay_friendly_fire_bright_wizard_03",
				"pdr_gameplay_friendly_fire_bright_wizard_04"
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
				"pdr_gameplay_friendly_fire_bright_wizard_01",
				"pdr_gameplay_friendly_fire_bright_wizard_02",
				"pdr_gameplay_friendly_fire_bright_wizard_03",
				"pdr_gameplay_friendly_fire_bright_wizard_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_helped_by_witch_hunter = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "help_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_helped_by_witch_hunter_01",
				"pdr_gameplay_helped_by_witch_hunter_02",
				"pdr_gameplay_helped_by_witch_hunter_03",
				"pdr_gameplay_helped_by_witch_hunter_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_helped_by_witch_hunter_01",
				"pdr_gameplay_helped_by_witch_hunter_02",
				"pdr_gameplay_helped_by_witch_hunter_03",
				"pdr_gameplay_helped_by_witch_hunter_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_skaven_ratling_gun = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pdr_gameplay_hearing_a_skaven_ratling_gun_04",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_05",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_06",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_01",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_02",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_03",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_07"
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_hearing_a_skaven_ratling_gun_04",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_05",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_06",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_01",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_02",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_03",
				"pdr_gameplay_hearing_a_skaven_ratling_gun_07"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_incoming_skaven_rat_ogre = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pdr_gameplay_incoming_skaven_rat_ogre_01",
				"pdr_gameplay_incoming_skaven_rat_ogre_05",
				"pdr_gameplay_incoming_skaven_rat_ogre_06",
				"pdr_gameplay_incoming_skaven_rat_ogre_02",
				"pdr_gameplay_incoming_skaven_rat_ogre_03",
				"pdr_gameplay_incoming_skaven_rat_ogre_04",
				"pdr_gameplay_incoming_skaven_rat_ogre_07",
				"pdr_gameplay_incoming_skaven_rat_ogre_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pdr_gameplay_incoming_skaven_rat_ogre_01",
				"pdr_gameplay_incoming_skaven_rat_ogre_05",
				"pdr_gameplay_incoming_skaven_rat_ogre_06",
				"pdr_gameplay_incoming_skaven_rat_ogre_02",
				"pdr_gameplay_incoming_skaven_rat_ogre_03",
				"pdr_gameplay_incoming_skaven_rat_ogre_04",
				"pdr_gameplay_incoming_skaven_rat_ogre_07",
				"pdr_gameplay_incoming_skaven_rat_ogre_08"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_witch_hunter_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_witch_hunter_dead_01",
				"pdr_gameplay_witch_hunter_dead_02",
				"pdr_gameplay_witch_hunter_dead_03",
				"pdr_gameplay_witch_hunter_dead_04"
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
				"pdr_gameplay_witch_hunter_dead_01",
				"pdr_gameplay_witch_hunter_dead_02",
				"pdr_gameplay_witch_hunter_dead_03",
				"pdr_gameplay_witch_hunter_dead_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_bright_wizard_low_on_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_bright_wizard_low_on_health_01",
				"pdr_gameplay_bright_wizard_low_on_health_02",
				"pdr_gameplay_bright_wizard_low_on_health_03",
				"pdr_gameplay_bright_wizard_low_on_health_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_bright_wizard_low_on_health_01",
				"pdr_gameplay_bright_wizard_low_on_health_02",
				"pdr_gameplay_bright_wizard_low_on_health_03",
				"pdr_gameplay_bright_wizard_low_on_health_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_wood_elf_low_on_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_wood_elf_low_on_health_01",
				"pdr_gameplay_wood_elf_low_on_health_02",
				"pdr_gameplay_wood_elf_low_on_health_03",
				"pdr_gameplay_wood_elf_low_on_health_04"
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
				"pdr_gameplay_wood_elf_low_on_health_01",
				"pdr_gameplay_wood_elf_low_on_health_02",
				"pdr_gameplay_wood_elf_low_on_health_03",
				"pdr_gameplay_wood_elf_low_on_health_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_gutter_runner_combat = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_hearing_a_gutter_runner_combat_01",
				"pdr_gameplay_hearing_a_gutter_runner_combat_02",
				"pdr_gameplay_hearing_a_gutter_runner_06",
				"pdr_gameplay_seeing_a_gutter_runner_02",
				"pdr_gameplay_seeing_a_gutter_runner_03"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pdr_gameplay_hearing_a_gutter_runner_combat_01",
				"pdr_gameplay_hearing_a_gutter_runner_combat_02",
				"pdr_gameplay_hearing_a_gutter_runner_06",
				"pdr_gameplay_seeing_a_gutter_runner_02",
				"pdr_gameplay_seeing_a_gutter_runner_03"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_friendly_fire_empire_soldier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_friendly_fire_empire_soldier_01",
				"pdr_gameplay_friendly_fire_empire_soldier_02",
				"pdr_gameplay_friendly_fire_empire_soldier_03",
				"pdr_gameplay_friendly_fire_empire_soldier_04"
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
				"pdr_gameplay_friendly_fire_empire_soldier_01",
				"pdr_gameplay_friendly_fire_empire_soldier_02",
				"pdr_gameplay_friendly_fire_empire_soldier_03",
				"pdr_gameplay_friendly_fire_empire_soldier_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_witch_hunter_low_on_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_witch_hunter_low_on_health_01",
				"pdr_gameplay_witch_hunter_low_on_health_02",
				"pdr_gameplay_witch_hunter_low_on_health_03",
				"pdr_gameplay_witch_hunter_low_on_health_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_witch_hunter_low_on_health_01",
				"pdr_gameplay_witch_hunter_low_on_health_02",
				"pdr_gameplay_witch_hunter_low_on_health_03",
				"pdr_gameplay_witch_hunter_low_on_health_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_taking_heavy_damage = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_taking_heavy_damage_01",
				"pdr_gameplay_taking_heavy_damage_02",
				"pdr_curse_11",
				"pdr_curse_06",
				"pdr_gameplay_taking_heavy_damage_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_pain",
				"face_pain",
				"face_pain",
				"face_pain",
				"face_pain"
			},
			localization_strings = {
				"pdr_gameplay_taking_heavy_damage_01",
				"pdr_gameplay_taking_heavy_damage_02",
				"pdr_curse_11",
				"pdr_curse_06",
				"pdr_gameplay_taking_heavy_damage_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_wood_elf_being_helped_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_wood_elf_being_helped_up_02",
				"pdr_gameplay_wood_elf_being_helped_up_03",
				"pdr_gameplay_wood_elf_being_helped_up_01",
				"pdr_gameplay_wood_elf_being_helped_up_04"
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
				"pdr_gameplay_wood_elf_being_helped_up_02",
				"pdr_gameplay_wood_elf_being_helped_up_03",
				"pdr_gameplay_wood_elf_being_helped_up_01",
				"pdr_gameplay_wood_elf_being_helped_up_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_tension_no_enemies = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "casual_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_tension_no_enemies_01",
				"pdr_gameplay_tension_no_enemies_02",
				"pdr_gameplay_tension_no_enemies_03",
				"pdr_gameplay_tension_no_enemies_04",
				"pdr_gameplay_tension_no_enemies_05",
				"pdr_gameplay_tension_no_enemies_06"
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
				"face_neutral",
				"face_neutral",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_tension_no_enemies_01",
				"pdr_gameplay_tension_no_enemies_02",
				"pdr_gameplay_tension_no_enemies_03",
				"pdr_gameplay_tension_no_enemies_04",
				"pdr_gameplay_tension_no_enemies_05",
				"pdr_gameplay_tension_no_enemies_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_special_enemy_kill_melee = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_special_enemy_kill_melee_01",
				"pdr_gameplay_special_enemy_kill_melee_02",
				"pdr_gameplay_special_enemy_kill_melee_03",
				"pdr_gameplay_special_enemy_kill_melee_04",
				"pdr_gameplay_special_enemy_kill_melee_05",
				"pdr_gameplay_special_enemy_kill_melee_06"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_special_enemy_kill_melee_01",
				"pdr_gameplay_special_enemy_kill_melee_02",
				"pdr_gameplay_special_enemy_kill_melee_03",
				"pdr_gameplay_special_enemy_kill_melee_04",
				"pdr_gameplay_special_enemy_kill_melee_05",
				"pdr_gameplay_special_enemy_kill_melee_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_heard_witch_hunter_in_trouble = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_heard_witch_hunter_in_trouble_01",
				"pdr_gameplay_heard_witch_hunter_in_trouble_02",
				"pdr_gameplay_heard_witch_hunter_in_trouble_03",
				"pdr_gameplay_heard_witch_hunter_in_trouble_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_heard_witch_hunter_in_trouble_01",
				"pdr_gameplay_heard_witch_hunter_in_trouble_02",
				"pdr_gameplay_heard_witch_hunter_in_trouble_03",
				"pdr_gameplay_heard_witch_hunter_in_trouble_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_goal_achieved_more_left = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_objective_goal_achieved_more_left_01",
				"pdr_objective_goal_achieved_more_left_02",
				"pdr_objective_goal_achieved_more_left_03",
				"pdr_objective_goal_achieved_more_left_04",
				"pdr_objective_goal_achieved_more_left_06",
				"pdr_objective_goal_achieved_more_left_08"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_goal_achieved_more_left_01",
				"pdr_objective_goal_achieved_more_left_02",
				"pdr_objective_goal_achieved_more_left_03",
				"pdr_objective_goal_achieved_more_left_04",
				"pdr_objective_goal_achieved_more_left_06",
				"pdr_objective_goal_achieved_more_left_08"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_low_on_health = {
			sound_events_n = 13,
			randomize_indexes_n = 0,
			face_animations_n = 13,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 13,
			sound_events = {
				"pdr_gameplay_low_on_health_01",
				"pdr_gameplay_low_on_health_02",
				"pdr_gameplay_low_on_health_03",
				"pdr_gameplay_low_on_health_04",
				"pdr_gameplay_low_on_health_05",
				"pdr_gameplay_low_on_health_06",
				"pdr_gameplay_low_on_health_07",
				"pdr_gameplay_low_on_health_08",
				"pdr_gameplay_taking_heavy_damage_01_low",
				"pdr_gameplay_taking_heavy_damage_02_low",
				"pdr_gameplay_taking_heavy_damage_03",
				"pdr_gameplay_taking_heavy_damage_04",
				"pdr_gameplay_taking_heavy_damage_05"
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
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_pain",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pdr_gameplay_low_on_health_01",
				"pdr_gameplay_low_on_health_02",
				"pdr_gameplay_low_on_health_03",
				"pdr_gameplay_low_on_health_04",
				"pdr_gameplay_low_on_health_05",
				"pdr_gameplay_low_on_health_06",
				"pdr_gameplay_low_on_health_07",
				"pdr_gameplay_low_on_health_08",
				"pdr_gameplay_taking_heavy_damage_01_low",
				"pdr_gameplay_taking_heavy_damage_02_low",
				"pdr_gameplay_taking_heavy_damage_03",
				"pdr_gameplay_taking_heavy_damage_04",
				"pdr_gameplay_taking_heavy_damage_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_friendly_fire_wood_elf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_friendly_fire_wood_elf_01",
				"pdr_gameplay_friendly_fire_wood_elf_02",
				"pdr_gameplay_friendly_fire_wood_elf_03",
				"pdr_gameplay_friendly_fire_wood_elf_04"
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
				"pdr_gameplay_friendly_fire_wood_elf_01",
				"pdr_gameplay_friendly_fire_wood_elf_02",
				"pdr_gameplay_friendly_fire_wood_elf_03",
				"pdr_gameplay_friendly_fire_wood_elf_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_seeing_a_gutter_runner = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_seeing_a_gutter_runner_01",
				"pdr_gameplay_seeing_a_gutter_runner_02",
				"pdr_gameplay_seeing_a_gutter_runner_03",
				"pdr_gameplay_seeing_a_gutter_runner_04",
				"pdr_gameplay_seeing_a_gutter_runner_05",
				"pdr_gameplay_seeing_a_gutter_runner_06"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_surprise",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_gutter_runner_01",
				"pdr_gameplay_seeing_a_gutter_runner_02",
				"pdr_gameplay_seeing_a_gutter_runner_03",
				"pdr_gameplay_seeing_a_gutter_runner_04",
				"pdr_gameplay_seeing_a_gutter_runner_05",
				"pdr_gameplay_seeing_a_gutter_runner_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_armoured_enemy_wood_elf = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_gameplay_armoured_enemy_wood_elf_01",
				"pdr_gameplay_armoured_enemy_wood_elf_02",
				"pdr_gameplay_armoured_enemy_wood_elf_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_armoured_enemy_wood_elf_01",
				"pdr_gameplay_armoured_enemy_wood_elf_02",
				"pdr_gameplay_armoured_enemy_wood_elf_03"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_spots_ammo = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "seen_items",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_spots_ammo_01",
				"pdr_gameplay_spots_ammo_02",
				"pdr_gameplay_spots_ammo_03",
				"pdr_gameplay_spots_ammo_04",
				"pdr_gameplay_spots_ammo_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_spots_ammo_01",
				"pdr_gameplay_spots_ammo_02",
				"pdr_gameplay_spots_ammo_03",
				"pdr_gameplay_spots_ammo_04",
				"pdr_gameplay_spots_ammo_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_seeing_a_skaven_patrol_stormvermin = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_01",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_02",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_03",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_04",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_05",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_06",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_07"
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
				"face_calm",
				"face_concerned",
				"face_concerned",
				"face_contempt",
				"face_nervous",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_01",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_02",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_03",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_04",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_05",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_06",
				"pdr_gameplay_seeing_a_skaven_patrol_stormvermin_07"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_helped_by_empire_soldier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "help_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_helped_by_empire_soldier_01",
				"pdr_gameplay_helped_by_empire_soldier_02",
				"pdr_gameplay_helped_by_empire_soldier_03",
				"pdr_gameplay_helped_by_empire_soldier_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_gameplay_helped_by_empire_soldier_01",
				"pdr_gameplay_helped_by_empire_soldier_02",
				"pdr_gameplay_helped_by_empire_soldier_03",
				"pdr_gameplay_helped_by_empire_soldier_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_activating_magic_weapon_defensive = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pdr_gameplay_activating_magic_weapon_defensive_01",
				"pdr_gameplay_activating_magic_weapon_defensive_02",
				"pdr_gameplay_activating_magic_weapon_defensive_03",
				"pdr_gameplay_activating_magic_weapon_defensive_04",
				"pdr_gameplay_activating_magic_weapon_defensive_05"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_activating_magic_weapon_defensive_01",
				"pdr_gameplay_activating_magic_weapon_defensive_02",
				"pdr_gameplay_activating_magic_weapon_defensive_03",
				"pdr_gameplay_activating_magic_weapon_defensive_04",
				"pdr_gameplay_activating_magic_weapon_defensive_05"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_bright_wizard_being_helped_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_bright_wizard_being_helped_up_01",
				"pdr_gameplay_bright_wizard_being_helped_up_02",
				"pdr_gameplay_bright_wizard_being_helped_up_03",
				"pdr_gameplay_bright_wizard_being_helped_up_04"
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
				"pdr_gameplay_bright_wizard_being_helped_up_01",
				"pdr_gameplay_bright_wizard_being_helped_up_02",
				"pdr_gameplay_bright_wizard_being_helped_up_03",
				"pdr_gameplay_bright_wizard_being_helped_up_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_killing_packmaster = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_killing_packmaster_01",
				"pdr_gameplay_killing_packmaster_02",
				"pdr_gameplay_killing_packmaster_03",
				"pdr_gameplay_killing_packmaster_04"
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
				"pdr_gameplay_killing_packmaster_01",
				"pdr_gameplay_killing_packmaster_02",
				"pdr_gameplay_killing_packmaster_03",
				"pdr_gameplay_killing_packmaster_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_seeing_a_skaven_ratling_gun = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pdr_gameplay_seeing_a_skaven_ratling_gun_01",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_02",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_03",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_04",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_05",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_06",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_07"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_skaven_ratling_gun_01",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_02",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_03",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_04",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_05",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_06",
				"pdr_gameplay_seeing_a_skaven_ratling_gun_07"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_casual_quotes = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "casual_talk",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_casual_quotes_01",
				"pdr_gameplay_casual_quotes_03",
				"pdr_gameplay_casual_quotes_04",
				"pdr_gameplay_casual_quotes_05",
				"pdr_gameplay_casual_quotes_06",
				"pdr_gameplay_casual_quotes_10"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_casual_quotes_01",
				"pdr_gameplay_casual_quotes_03",
				"pdr_gameplay_casual_quotes_04",
				"pdr_gameplay_casual_quotes_05",
				"pdr_gameplay_casual_quotes_06",
				"pdr_gameplay_casual_quotes_10"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_seeing_a_skaven_slaver = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pdr_gameplay_seeing_a_skaven_slaver_01",
				"pdr_gameplay_seeing_a_skaven_slaver_02",
				"pdr_gameplay_seeing_a_skaven_slaver_07",
				"pdr_gameplay_seeing_a_skaven_slaver_03",
				"pdr_gameplay_seeing_a_skaven_slaver_04",
				"pdr_gameplay_seeing_a_skaven_slaver_05",
				"pdr_gameplay_seeing_a_skaven_slaver_06",
				"pdr_gameplay_seeing_a_skaven_slaver_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_skaven_slaver_01",
				"pdr_gameplay_seeing_a_skaven_slaver_02",
				"pdr_gameplay_seeing_a_skaven_slaver_07",
				"pdr_gameplay_seeing_a_skaven_slaver_03",
				"pdr_gameplay_seeing_a_skaven_slaver_04",
				"pdr_gameplay_seeing_a_skaven_slaver_05",
				"pdr_gameplay_seeing_a_skaven_slaver_06",
				"pdr_gameplay_seeing_a_skaven_slaver_08"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_healing_bright_wizard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_healing_bright_wizard_01",
				"pdr_gameplay_healing_bright_wizard_02",
				"pdr_gameplay_healing_bright_wizard_03",
				"pdr_gameplay_healing_bright_wizard_04"
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
				"pdr_gameplay_healing_bright_wizard_01",
				"pdr_gameplay_healing_bright_wizard_02",
				"pdr_gameplay_healing_bright_wizard_03",
				"pdr_gameplay_healing_bright_wizard_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_empire_soldier_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_gameplay_empire_soldier_dead_01",
				"pdr_gameplay_empire_soldier_dead_02",
				"pdr_gameplay_empire_soldier_dead_03",
				"pdr_gameplay_empire_soldier_dead_04"
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
				"pdr_gameplay_empire_soldier_dead_01",
				"pdr_gameplay_empire_soldier_dead_02",
				"pdr_gameplay_empire_soldier_dead_03",
				"pdr_gameplay_empire_soldier_dead_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_globadier_guck = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "dwarf_ranger",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_globadier_guck_01",
				"pdr_gameplay_globadier_guck_02",
				"pdr_gameplay_globadier_guck_03",
				"pdr_gameplay_globadier_guck_04",
				"pdr_gameplay_globadier_guck_05",
				"pdr_gameplay_globadier_guck_06"
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
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise"
			},
			localization_strings = {
				"pdr_gameplay_globadier_guck_01",
				"pdr_gameplay_globadier_guck_02",
				"pdr_gameplay_globadier_guck_03",
				"pdr_gameplay_globadier_guck_04",
				"pdr_gameplay_globadier_guck_05",
				"pdr_gameplay_globadier_guck_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_hearing_a_globadier_combat = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_ranger",
			category = "enemy_alerts",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_gameplay_seeing_a_globadier_01",
				"pdr_gameplay_seeing_a_globadier_03",
				"pdr_gameplay_seeing_a_globadier_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_contempt",
				"face_fear",
				"face_contempt"
			},
			localization_strings = {
				"pdr_gameplay_seeing_a_globadier_01",
				"pdr_gameplay_seeing_a_globadier_03",
				"pdr_gameplay_seeing_a_globadier_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
