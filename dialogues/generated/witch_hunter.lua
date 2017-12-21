return function ()
	define_rule({
		name = "pwh_gameplay_seeing_a_stormvermin",
		response = "pwh_gameplay_seeing_a_stormvermin",
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
		name = "pwh_gameplay_seeing_a_gutter_runner",
		response = "pwh_gameplay_seeing_a_gutter_runner",
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
		name = "pwh_gameplay_hearing_a_gutter_runner",
		response = "pwh_gameplay_hearing_a_gutter_runner",
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
		name = "pwh_gameplay_seeing_a_globadier",
		response = "pwh_gameplay_seeing_a_globadier",
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
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_gameplay_hearing_a_globadier",
		response = "pwh_gameplay_hearing_a_globadier",
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
		name = "pwh_gameplay_seeing_a_skaven_rat_ogre",
		response = "pwh_gameplay_seeing_a_skaven_rat_ogre",
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
				"last_seen_rate_ogre",
				OP.TIMEDIFF,
				OP.GT,
				30
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
		name = "pwh_gameplay_hearing_a_skaven_rat_ogre",
		response = "pwh_gameplay_hearing_a_skaven_rat_ogre",
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
		name = "pwh_gameplay_incoming_skaven_rat_ogre",
		response = "pwh_gameplay_incoming_skaven_rat_ogre",
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
		name = "pwh_gameplay_hears_incoming_horde",
		response = "pwh_gameplay_hears_incoming_horde",
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
		name = "pwh_gameplay_seeing_a_skaven_patrol_stormvermin",
		response = "pwh_gameplay_seeing_a_skaven_patrol_stormvermin",
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
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_gameplay_hearing_a_skaven_patrol_stormvermin",
		response = "pwh_gameplay_hearing_a_skaven_patrol_stormvermin",
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
		name = "pwh_gameplay_seeing_a_skaven_slaver",
		response = "pwh_gameplay_seeing_a_skaven_slaver",
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
		name = "pwh_gameplay_seeing_a_skaven_ratling_gun",
		response = "pwh_gameplay_seeing_a_skaven_ratling_gun",
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
		name = "pwh_gameplay_hearing_a_skaven_ratling_gun",
		response = "pwh_gameplay_hearing_a_skaven_ratling_gun",
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
		name = "pwh_gameplay_tension_no_enemies",
		response = "pwh_gameplay_tension_no_enemies",
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
		name = "pwh_gameplay_killing_globadier",
		response = "pwh_gameplay_killing_globadier",
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
				"witch_hunter_special_kills_in_row",
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
				"dwarf_ranger_special_kills_in_row",
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
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_killing_ratling",
		response = "pwh_gameplay_killing_ratling",
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
				"witch_hunter_special_kills_in_row",
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
				"dwarf_ranger_special_kills_in_row",
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
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_killing_packmaster",
		response = "pwh_gameplay_killing_packmaster",
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
				"witch_hunter_special_kills_in_row",
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
				"dwarf_ranger_special_kills_in_row",
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
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_killing_gutterrunner",
		response = "pwh_gameplay_killing_gutterrunner",
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
				"witch_hunter_special_kills_in_row",
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
				"dwarf_ranger_special_kills_in_row",
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
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_killing_lootrat",
		response = "pwh_gameplay_killing_lootrat",
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
				"witch_hunter_special_kills_in_row",
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
				"dwarf_ranger_special_kills_in_row",
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
				"wood_elf_special_kills_in_row",
				OP.NUMSET,
				0
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_globadier_guck",
		response = "pwh_gameplay_globadier_guck",
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
		response = "pwh_gameplay_hit_by_goo",
		name = "pwh_gameplay_hit_by_goo",
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
				"witch_hunter"
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
		name = "pwh_gameplay_taking_heavy_damage",
		response = "pwh_gameplay_taking_heavy_damage",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_incoming_globadier",
		response = "pwh_gameplay_incoming_globadier",
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
				"witch_hunter"
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
		name = "pwh_gameplay_knocked_down",
		response = "pwh_gameplay_knocked_down",
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
				"witch_hunter"
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
				"witch_hunter"
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
				"times_down_witch_hunter",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_player_pounced",
		response = "pwh_gameplay_player_pounced",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_empire_soldier_grabbed",
		response = "pwh_gameplay_empire_soldier_grabbed",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_bright_wizard_grabbed",
		response = "pwh_gameplay_bright_wizard_grabbed",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_dwarf_ranger_grabbed",
		response = "pwh_gameplay_dwarf_ranger_grabbed",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_wood_elf_grabbed",
		response = "pwh_gameplay_wood_elf_grabbed",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_heard_empire_soldier_in_trouble",
		response = "pwh_gameplay_heard_empire_soldier_in_trouble",
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
		name = "pwh_gameplay_heard_bright_wizard_in_trouble",
		response = "pwh_gameplay_heard_bright_wizard_in_trouble",
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
		name = "pwh_gameplay_heard_wood_elf_in_trouble",
		response = "pwh_gameplay_heard_wood_elf_in_trouble",
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
		name = "pwh_gameplay_heard_dwarf_ranger_in_trouble",
		response = "pwh_gameplay_heard_dwarf_ranger_in_trouble",
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
				"speaker_name",
				OP.EQ,
				"dwarf_ranger"
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
				"times_down_dwarf_ranger",
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
		name = "pwh_gameplay_no_nearby_teammates",
		response = "pwh_gameplay_no_nearby_teammates",
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
				"witch_hunter"
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
				30
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
		name = "pwh_gameplay_empire_soldier_dead",
		response = "pwh_gameplay_empire_soldier_dead",
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
		name = "pwh_gameplay_bright_wizard_dead",
		response = "pwh_gameplay_bright_wizard_dead",
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
		name = "pwh_gameplay_wood_elf_dead",
		response = "pwh_gameplay_wood_elf_dead",
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
		name = "pwh_gameplay_dwarf_ranger_dead",
		response = "pwh_gameplay_dwarf_ranger_dead",
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
				"time_since_pdr_death",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_pdr_death",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_ambush_horde_spawned",
		response = "pwh_gameplay_ambush_horde_spawned",
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
		name = "pwh_gameplay_casual_quotes",
		response = "pwh_gameplay_casual_quotes",
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
		response = "pwh_gameplay_empire_soldier_being_helped_up",
		name = "pwh_gameplay_empire_soldier_being_helped_up",
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
				"witch_hunter"
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
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_bright_wizard_being_helped_up",
		name = "pwh_gameplay_bright_wizard_being_helped_up",
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
				"witch_hunter"
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
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_wood_elf_being_helped_up",
		name = "pwh_gameplay_wood_elf_being_helped_up",
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
				"witch_hunter"
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
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_dwarf_ranger_being_helped",
		name = "pwh_gameplay_dwarf_ranger_being_helped",
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
				"witch_hunter"
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
				"witch_hunter"
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_healing_empire_soldier",
		response = "pwh_gameplay_healing_empire_soldier",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_healing_bright_wizard",
		response = "pwh_gameplay_healing_bright_wizard",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_healing_wood_elf",
		response = "pwh_gameplay_healing_wood_elf",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_healing_dwarf_ranger",
		response = "pwh_gameplay_healing_dwarf_ranger",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_helped_by_empire_soldier",
		response = "pwh_gameplay_helped_by_empire_soldier",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_helped_by_bright_wizard",
		response = "pwh_gameplay_helped_by_bright_wizard",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_helped_by_wood_elf",
		response = "pwh_gameplay_helped_by_wood_elf",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_helped_by_dwarf_ranger",
		response = "pwh_gameplay_helped_by_dwarf_ranger",
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
				"witch_hunter"
			},
			{
				"query_context",
				"healer_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_gameplay_low_on_health",
		response = "pwh_gameplay_low_on_health",
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
		name = "pwh_gameplay_empire_soldier_low_on_health",
		response = "pwh_gameplay_empire_soldier_low_on_health",
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
				"witch_hunter"
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
		name = "pwh_gameplay_bright_wizard_low_on_health",
		response = "pwh_gameplay_bright_wizard_low_on_health",
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
				"witch_hunter"
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
		name = "pwh_gameplay_wood_elf_low_on_health",
		response = "pwh_gameplay_wood_elf_low_on_health",
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
				"witch_hunter"
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
		name = "pwh_gameplay_dwarf_ranger_low_on_health",
		response = "pwh_gameplay_dwarf_ranger_low_on_health",
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
				"pdr_gameplay_low_on_health"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_low_health_pdr",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_low_health_pdr",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_spots_ammo",
		response = "pwh_gameplay_spots_ammo",
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
		name = "pwh_gameplay_spots_health",
		response = "pwh_gameplay_spots_health",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_healing_draught",
		response = "pwh_gameplay_healing_draught",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_spots_potion",
		response = "pwh_gameplay_spots_potion",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_spots_bomb",
		response = "pwh_gameplay_spots_bomb",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_out_of_ammo",
		response = "pwh_gameplay_out_of_ammo",
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
		name = "pwh_gameplay_using_potion",
		response = "pwh_gameplay_using_potion",
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
		name = "pwh_gameplay_self_heal",
		response = "pwh_gameplay_self_heal",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_throwing_bomb",
		response = "pwh_gameplay_throwing_bomb",
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
		name = "pwh_gameplay_activating_magic_weapon_offensive",
		response = "pwh_gameplay_activating_magic_weapon_offensive",
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
		name = "pwh_gameplay_activating_magic_weapon_defensive",
		response = "pwh_gameplay_activating_magic_weapon_defensive",
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
		name = "pwh_gameplay_friendly_fire_empire_soldier",
		response = "pwh_gameplay_friendly_fire_empire_soldier",
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
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_friendly_fire_bright_wizard",
		response = "pwh_gameplay_friendly_fire_bright_wizard",
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
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_friendly_fire_dwarf_ranger",
		response = "pwh_gameplay_friendly_fire_dwarf_ranger",
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
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_gameplay_friendly_fire_wood_elf",
		response = "pwh_gameplay_friendly_fire_wood_elf",
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
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_encouraging_words",
		response = "pwh_gameplay_encouraging_words",
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
		name = "pwh_gameplay_special_enemy_kill_melee",
		response = "pwh_gameplay_special_enemy_kill_melee",
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
				"witch_hunter"
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
		name = "pwh_gameplay_special_enemy_kill_ranged",
		response = "pwh_gameplay_special_enemy_kill_ranged",
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
				"witch_hunter"
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
		name = "pwh_gameplay_empire_soldier_on_a_frenzy",
		response = "pwh_gameplay_empire_soldier_on_a_frenzy",
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
				"witch_hunter"
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
		name = "pwh_gameplay_bright_wizard_on_a_frenzy",
		response = "pwh_gameplay_bright_wizard_on_a_frenzy",
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
				"witch_hunter"
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
		name = "pwh_gameplay_wood_elf_on_a_frenzy",
		response = "pwh_gameplay_wood_elf_on_a_frenzy",
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
				"witch_hunter"
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
		name = "pwh_gameplay_dwarf_ranger_on_a_frenzy",
		response = "pwh_gameplay_dwarf_ranger_on_a_frenzy",
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
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_last_frenzy_dwarf_ranger",
				OP.TIMEDIFF,
				OP.GT,
				90
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_frenzy_dwarf_ranger",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_armoured_enemy_bright_wizard",
		response = "pwh_gameplay_armoured_enemy_bright_wizard",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_armoured_enemy_dwarf",
		response = "pwh_gameplay_armoured_enemy_dwarf",
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
				"witch_hunter"
			},
			{
				"query_context",
				"profile_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_gameplay_armoured_enemy_wood_elf",
		response = "pwh_gameplay_armoured_enemy_wood_elf",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_gameplay_armoured_enemy_empire_soldier",
		response = "pwh_gameplay_armoured_enemy_empire_soldier",
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
				"witch_hunter"
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
				"witch_hunter"
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
		name = "pwh_objective_interacting_with_objective",
		response = "pwh_objective_interacting_with_objective",
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
		name = "pwh_objective_nearing_objective_deadline",
		response = "pwh_objective_nearing_objective_deadline",
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
		name = "pwh_objective_achieved_all_but_one_goal",
		response = "pwh_objective_achieved_all_but_one_goal",
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
		name = "pwh_objective_goal_achieved_more_left",
		response = "pwh_objective_goal_achieved_more_left",
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
		name = "pwh_objective_goal_achieved_escape",
		response = "pwh_objective_goal_achieved_escape",
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
		name = "pwh_objective_correct_path_this_way",
		response = "pwh_objective_correct_path_this_way",
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
		name = "pwh_objective_correct_path_up",
		response = "pwh_objective_correct_path_up",
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
		name = "pwh_objective_correct_path_down",
		response = "pwh_objective_correct_path_down",
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
		name = "pwh_objective_correct_path_bridge",
		response = "pwh_objective_correct_path_bridge",
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
		name = "pwh_objective_correct_path_street",
		response = "pwh_objective_correct_path_street",
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
		name = "pwh_objective_correct_path_door",
		response = "pwh_objective_correct_path_door",
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
		name = "pwh_objective_correct_path_stairs_up",
		response = "pwh_objective_correct_path_stairs_up",
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
		name = "pwh_objective_correct_path_stairs_down",
		response = "pwh_objective_correct_path_stairs_down",
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
		name = "pwh_spotting_ferry_lady",
		response = "pwh_spotting_ferry_lady",
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
		name = "pwh_objective_dropping_grimoire",
		response = "pwh_objective_dropping_grimoire",
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
		name = "pwh_objective_picking_up_grimoire",
		response = "pwh_objective_picking_up_grimoire",
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
		name = "pwh_gameplay_dead_body",
		response = "pwh_gameplay_dead_body",
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
				"level_time ",
				OP.GT,
				90
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
		name = "pwh_gameplay_dead_end",
		response = "pwh_gameplay_dead_end",
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
		name = "pwh_curse",
		response = "pwh_curse",
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
		name = "pwh_targeted_by_ratling",
		response = "pwh_targeted_by_ratling",
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
		pwh_gameplay_empire_soldier_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_empire_soldier_dead_01",
				"pwh_gameplay_empire_soldier_dead_02",
				"pwh_gameplay_empire_soldier_dead_03",
				"pwh_gameplay_empire_soldier_dead_04"
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
				"pwh_gameplay_empire_soldier_dead_01",
				"pwh_gameplay_empire_soldier_dead_02",
				"pwh_gameplay_empire_soldier_dead_03",
				"pwh_gameplay_empire_soldier_dead_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_picking_up_grimoire = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_objective_picking_up_grimoire_01",
				"pwh_objective_picking_up_grimoire_02",
				"pwh_objective_picking_up_grimoire_03",
				"pwh_objective_picking_up_grimoire_04",
				"pwh_objective_picking_up_grimoire_05",
				"pwh_objective_picking_up_grimoire_06",
				"pwh_objective_picking_up_grimoire_07",
				"pwh_objective_picking_up_grimoire_08"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_picking_up_grimoire_01",
				"pwh_objective_picking_up_grimoire_02",
				"pwh_objective_picking_up_grimoire_03",
				"pwh_objective_picking_up_grimoire_04",
				"pwh_objective_picking_up_grimoire_05",
				"pwh_objective_picking_up_grimoire_06",
				"pwh_objective_picking_up_grimoire_07",
				"pwh_objective_picking_up_grimoire_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_spots_ammo = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "seen_items",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_spots_ammo_01",
				"pwh_gameplay_spots_ammo_02",
				"pwh_gameplay_spots_ammo_03",
				"pwh_gameplay_spots_ammo_04",
				"pwh_gameplay_spots_ammo_05"
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
				"pwh_gameplay_spots_ammo_01",
				"pwh_gameplay_spots_ammo_02",
				"pwh_gameplay_spots_ammo_03",
				"pwh_gameplay_spots_ammo_04",
				"pwh_gameplay_spots_ammo_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_heard_wood_elf_in_trouble = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_heard_wood_elf_in_trouble_01",
				"pwh_gameplay_heard_wood_elf_in_trouble_02",
				"pwh_gameplay_heard_wood_elf_in_trouble_03",
				"pwh_gameplay_heard_wood_elf_in_trouble_04"
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
				"pwh_gameplay_heard_wood_elf_in_trouble_01",
				"pwh_gameplay_heard_wood_elf_in_trouble_02",
				"pwh_gameplay_heard_wood_elf_in_trouble_03",
				"pwh_gameplay_heard_wood_elf_in_trouble_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_heard_bright_wizard_in_trouble = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_heard_bright_wizard_in_trouble_01",
				"pwh_gameplay_heard_bright_wizard_in_trouble_02",
				"pwh_gameplay_heard_bright_wizard_in_trouble_03",
				"pwh_gameplay_heard_bright_wizard_in_trouble_04"
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
				"pwh_gameplay_heard_bright_wizard_in_trouble_01",
				"pwh_gameplay_heard_bright_wizard_in_trouble_02",
				"pwh_gameplay_heard_bright_wizard_in_trouble_03",
				"pwh_gameplay_heard_bright_wizard_in_trouble_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_spots_health = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "seen_items",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_spots_health_01",
				"pwh_gameplay_spots_health_02",
				"pwh_gameplay_spots_health_03",
				"pwh_gameplay_spots_health_04",
				"pwh_gameplay_spots_health_05"
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
				"pwh_gameplay_spots_health_01",
				"pwh_gameplay_spots_health_02",
				"pwh_gameplay_spots_health_03",
				"pwh_gameplay_spots_health_04",
				"pwh_gameplay_spots_health_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_incoming_globadier = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_incoming_globadier_01",
				"pwh_gameplay_incoming_globadier_02",
				"pwh_gameplay_incoming_globadier_03",
				"pwh_gameplay_incoming_globadier_04",
				"pwh_gameplay_incoming_globadier_05",
				"pwh_gameplay_incoming_globadier_06"
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
				"pwh_gameplay_incoming_globadier_01",
				"pwh_gameplay_incoming_globadier_02",
				"pwh_gameplay_incoming_globadier_03",
				"pwh_gameplay_incoming_globadier_04",
				"pwh_gameplay_incoming_globadier_05",
				"pwh_gameplay_incoming_globadier_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_spots_bomb = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "seen_items",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_spots_bomb_01",
				"pwh_gameplay_spots_bomb_02",
				"pwh_gameplay_spots_bomb_03",
				"pwh_gameplay_spots_bomb_04",
				"pwh_gameplay_spots_bomb_05"
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
				"pwh_gameplay_spots_bomb_01",
				"pwh_gameplay_spots_bomb_02",
				"pwh_gameplay_spots_bomb_03",
				"pwh_gameplay_spots_bomb_04",
				"pwh_gameplay_spots_bomb_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_healing_empire_soldier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_healing_empire_soldier_01",
				"pwh_gameplay_healing_empire_soldier_02",
				"pwh_gameplay_healing_empire_soldier_03",
				"pwh_gameplay_healing_empire_soldier_04"
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
				"pwh_gameplay_healing_empire_soldier_01",
				"pwh_gameplay_healing_empire_soldier_02",
				"pwh_gameplay_healing_empire_soldier_03",
				"pwh_gameplay_healing_empire_soldier_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_knocked_down = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_knocked_down_01",
				"pwh_gameplay_knocked_down_02",
				"pwh_gameplay_knocked_down_03",
				"pwh_gameplay_knocked_down_04",
				"pwh_gameplay_knocked_down_05",
				"pwh_gameplay_knocked_down_06"
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
				"pwh_gameplay_knocked_down_01",
				"pwh_gameplay_knocked_down_02",
				"pwh_gameplay_knocked_down_03",
				"pwh_gameplay_knocked_down_04",
				"pwh_gameplay_knocked_down_05",
				"pwh_gameplay_knocked_down_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_helped_by_bright_wizard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "help_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_helped_by_bright_wizard_01",
				"pwh_gameplay_helped_by_bright_wizard_02",
				"pwh_gameplay_helped_by_bright_wizard_03",
				"pwh_gameplay_helped_by_bright_wizard_04"
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
				"pwh_gameplay_helped_by_bright_wizard_01",
				"pwh_gameplay_helped_by_bright_wizard_02",
				"pwh_gameplay_helped_by_bright_wizard_03",
				"pwh_gameplay_helped_by_bright_wizard_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_armoured_enemy_empire_soldier = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_gameplay_armoured_enemy_empire_soldier_01",
				"pwh_gameplay_armoured_enemy_empire_soldier_02",
				"pwh_gameplay_armoured_enemy_empire_soldier_03"
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
				"pwh_gameplay_armoured_enemy_empire_soldier_01",
				"pwh_gameplay_armoured_enemy_empire_soldier_02",
				"pwh_gameplay_armoured_enemy_empire_soldier_03"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_dwarf_ranger_grabbed = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_dwarf_ranger_grabbed_01",
				"pwh_gameplay_dwarf_ranger_grabbed_02",
				"pwh_gameplay_dwarf_ranger_grabbed_03",
				"pwh_gameplay_dwarf_ranger_grabbed_04",
				"pwh_gameplay_dwarf_ranger_grabbed_05",
				"pwh_gameplay_dwarf_ranger_grabbed_06"
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
				"pwh_gameplay_dwarf_ranger_grabbed_01",
				"pwh_gameplay_dwarf_ranger_grabbed_02",
				"pwh_gameplay_dwarf_ranger_grabbed_03",
				"pwh_gameplay_dwarf_ranger_grabbed_04",
				"pwh_gameplay_dwarf_ranger_grabbed_05",
				"pwh_gameplay_dwarf_ranger_grabbed_06"
			},
			randomize_indexes = {}
		},
		pwh_objective_correct_path_stairs_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_correct_path_stairs_up_01",
				"pwh_objective_correct_path_stairs_up_02",
				"pwh_objective_correct_path_stairs_up_03",
				"pwh_objective_correct_path_stairs_up_04"
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
				"pwh_objective_correct_path_stairs_up_01",
				"pwh_objective_correct_path_stairs_up_02",
				"pwh_objective_correct_path_stairs_up_03",
				"pwh_objective_correct_path_stairs_up_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_globadier_guck = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_globadier_guck_01",
				"pwh_gameplay_globadier_guck_02",
				"pwh_gameplay_globadier_guck_03",
				"pwh_gameplay_globadier_guck_04",
				"pwh_gameplay_globadier_guck_05",
				"pwh_gameplay_globadier_guck_06"
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
				"pwh_gameplay_globadier_guck_01",
				"pwh_gameplay_globadier_guck_02",
				"pwh_gameplay_globadier_guck_03",
				"pwh_gameplay_globadier_guck_04",
				"pwh_gameplay_globadier_guck_05",
				"pwh_gameplay_globadier_guck_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_healing_wood_elf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_healing_wood_elf_01",
				"pwh_gameplay_healing_wood_elf_02",
				"pwh_gameplay_healing_wood_elf_03",
				"pwh_gameplay_healing_wood_elf_04"
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
				"pwh_gameplay_healing_wood_elf_01",
				"pwh_gameplay_healing_wood_elf_02",
				"pwh_gameplay_healing_wood_elf_03",
				"pwh_gameplay_healing_wood_elf_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_heard_empire_soldier_in_trouble = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_heard_empire_soldier_in_trouble_01",
				"pwh_gameplay_heard_empire_soldier_in_trouble_02",
				"pwh_gameplay_heard_empire_soldier_in_trouble_03",
				"pwh_gameplay_heard_empire_soldier_in_trouble_04"
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
				"pwh_gameplay_heard_empire_soldier_in_trouble_01",
				"pwh_gameplay_heard_empire_soldier_in_trouble_02",
				"pwh_gameplay_heard_empire_soldier_in_trouble_03",
				"pwh_gameplay_heard_empire_soldier_in_trouble_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_hearing_a_skaven_patrol_stormvermin = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_01",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_02",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_03",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_04",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_05",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_06",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_07"
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
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_01",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_02",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_03",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_04",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_05",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_06",
				"pwh_gameplay_hearing_a_skaven_patrol_stormvermin_07"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_no_nearby_teammates = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "casual_talk",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_no_nearby_teammates_01",
				"pwh_gameplay_no_nearby_teammates_02",
				"pwh_gameplay_no_nearby_teammates_03",
				"pwh_gameplay_no_nearby_teammates_07",
				"pwh_gameplay_no_nearby_teammates_08",
				"pwh_gameplay_no_nearby_teammates_04",
				"pwh_gameplay_no_nearby_teammates_05",
				"pwh_gameplay_no_nearby_teammates_06"
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
				"face_nervous",
				"face_nervous",
				"face_nervous",
				"face_nervous",
				"face_nervous",
				"face_nervous",
				"face_nervous",
				"face_nervous"
			},
			localization_strings = {
				"pwh_gameplay_no_nearby_teammates_01",
				"pwh_gameplay_no_nearby_teammates_02",
				"pwh_gameplay_no_nearby_teammates_03",
				"pwh_gameplay_no_nearby_teammates_07",
				"pwh_gameplay_no_nearby_teammates_08",
				"pwh_gameplay_no_nearby_teammates_04",
				"pwh_gameplay_no_nearby_teammates_05",
				"pwh_gameplay_no_nearby_teammates_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_bright_wizard_being_helped_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_bright_wizard_being_helped_up_01",
				"pwh_gameplay_bright_wizard_being_helped_up_02",
				"pwh_gameplay_bright_wizard_being_helped_up_03",
				"pwh_gameplay_bright_wizard_being_helped_up_04"
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
				"pwh_gameplay_bright_wizard_being_helped_up_01",
				"pwh_gameplay_bright_wizard_being_helped_up_02",
				"pwh_gameplay_bright_wizard_being_helped_up_03",
				"pwh_gameplay_bright_wizard_being_helped_up_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_correct_path_this_way = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_objective_correct_path_this_way_01",
				"pwh_objective_correct_path_this_way_02",
				"pwh_objective_correct_path_this_way_03",
				"pwh_objective_correct_path_this_way_04",
				"pwh_objective_correct_path_this_way_05",
				"pwh_objective_correct_path_this_way_06",
				"pwh_objective_correct_path_this_way_07",
				"pwh_objective_correct_path_this_way_08"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_correct_path_this_way_01",
				"pwh_objective_correct_path_this_way_02",
				"pwh_objective_correct_path_this_way_03",
				"pwh_objective_correct_path_this_way_04",
				"pwh_objective_correct_path_this_way_05",
				"pwh_objective_correct_path_this_way_06",
				"pwh_objective_correct_path_this_way_07",
				"pwh_objective_correct_path_this_way_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_hearing_a_globadier = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_hearing_a_globadier_02",
				"pwh_gameplay_hearing_a_globadier_05",
				"pwh_gameplay_hearing_a_globadier_06",
				"pwh_gameplay_hearing_a_globadier_01",
				"pwh_gameplay_hearing_a_globadier_03",
				"pwh_gameplay_hearing_a_globadier_04"
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
				"pwh_gameplay_hearing_a_globadier_02",
				"pwh_gameplay_hearing_a_globadier_05",
				"pwh_gameplay_hearing_a_globadier_06",
				"pwh_gameplay_hearing_a_globadier_01",
				"pwh_gameplay_hearing_a_globadier_03",
				"pwh_gameplay_hearing_a_globadier_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_hearing_a_gutter_runner = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_hearing_a_gutter_runner_01",
				"pwh_gameplay_hearing_a_gutter_runner_02",
				"pwh_gameplay_hearing_a_gutter_runner_03",
				"pwh_gameplay_hearing_a_gutter_runner_04",
				"pwh_gameplay_hearing_a_gutter_runner_05",
				"pwh_gameplay_hearing_a_gutter_runner_06"
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
				"pwh_gameplay_hearing_a_gutter_runner_01",
				"pwh_gameplay_hearing_a_gutter_runner_02",
				"pwh_gameplay_hearing_a_gutter_runner_03",
				"pwh_gameplay_hearing_a_gutter_runner_04",
				"pwh_gameplay_hearing_a_gutter_runner_05",
				"pwh_gameplay_hearing_a_gutter_runner_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_encouraging_words = {
			sound_events_n = 9,
			randomize_indexes_n = 0,
			face_animations_n = 9,
			database = "witch_hunter",
			category = "casual_talk",
			dialogue_animations_n = 9,
			sound_events = {
				"pwh_gameplay_encouraging_words_01",
				"pwh_gameplay_encouraging_words_02",
				"pwh_gameplay_encouraging_words_03",
				"pwh_gameplay_encouraging_words_05",
				"pwh_gameplay_encouraging_words_06",
				"pwh_gameplay_encouraging_words_07",
				"pwh_gameplay_encouraging_words_08",
				"pwh_gameplay_encouraging_words_09",
				"pwh_gameplay_encouraging_words_10"
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
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_gameplay_encouraging_words_01",
				"pwh_gameplay_encouraging_words_02",
				"pwh_gameplay_encouraging_words_03",
				"pwh_gameplay_encouraging_words_05",
				"pwh_gameplay_encouraging_words_06",
				"pwh_gameplay_encouraging_words_07",
				"pwh_gameplay_encouraging_words_08",
				"pwh_gameplay_encouraging_words_09",
				"pwh_gameplay_encouraging_words_10"
			},
			randomize_indexes = {}
		},
		pwh_curse = {
			sound_events_n = 12,
			randomize_indexes_n = 0,
			face_animations_n = 12,
			database = "witch_hunter",
			category = "casual_talk",
			dialogue_animations_n = 12,
			sound_events = {
				"pwh_curse_01",
				"pwh_curse_02",
				"pwh_curse_03",
				"pwh_curse_04",
				"pwh_curse_05",
				"pwh_curse_06",
				"pwh_curse_07",
				"pwh_curse_08",
				"pwh_curse_09",
				"pwh_curse_10",
				"pwh_curse_11",
				"pwh_curse_12"
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
				"pwh_curse_01",
				"pwh_curse_02",
				"pwh_curse_03",
				"pwh_curse_04",
				"pwh_curse_05",
				"pwh_curse_06",
				"pwh_curse_07",
				"pwh_curse_08",
				"pwh_curse_09",
				"pwh_curse_10",
				"pwh_curse_11",
				"pwh_curse_12"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_using_potion = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_using_potion_01",
				"pwh_gameplay_using_potion_03",
				"pwh_gameplay_using_potion_04",
				"pwh_gameplay_using_potion_05"
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
				"pwh_gameplay_using_potion_01",
				"pwh_gameplay_using_potion_03",
				"pwh_gameplay_using_potion_04",
				"pwh_gameplay_using_potion_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_casual_quotes = {
			sound_events_n = 10,
			randomize_indexes_n = 0,
			face_animations_n = 10,
			database = "witch_hunter",
			category = "casual_talk",
			dialogue_animations_n = 10,
			sound_events = {
				"pwh_gameplay_casual_quotes_01",
				"pwh_gameplay_casual_quotes_02",
				"pwh_gameplay_casual_quotes_03",
				"pwh_gameplay_casual_quotes_04",
				"pwh_gameplay_casual_quotes_05",
				"pwh_gameplay_casual_quotes_06",
				"pwh_gameplay_casual_quotes_07",
				"pwh_gameplay_casual_quotes_08",
				"pwh_gameplay_casual_quotes_09",
				"pwh_gameplay_casual_quotes_10"
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
				"dialogue_shout",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_sadness",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_gameplay_casual_quotes_01",
				"pwh_gameplay_casual_quotes_02",
				"pwh_gameplay_casual_quotes_03",
				"pwh_gameplay_casual_quotes_04",
				"pwh_gameplay_casual_quotes_05",
				"pwh_gameplay_casual_quotes_06",
				"pwh_gameplay_casual_quotes_07",
				"pwh_gameplay_casual_quotes_08",
				"pwh_gameplay_casual_quotes_09",
				"pwh_gameplay_casual_quotes_10"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_armoured_enemy_dwarf = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_gameplay_armoured_enemy_dwarf_01",
				"pwh_gameplay_armoured_enemy_dwarf_02",
				"pwh_gameplay_armoured_enemy_dwarf_03"
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
				"pwh_gameplay_armoured_enemy_dwarf_01",
				"pwh_gameplay_armoured_enemy_dwarf_02",
				"pwh_gameplay_armoured_enemy_dwarf_03"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_dead_end = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_dead_end_01",
				"pwh_gameplay_dead_end_02",
				"pwh_gameplay_dead_end_03",
				"pwh_gameplay_dead_end_04",
				"pwh_gameplay_dead_end_05",
				"pwh_gameplay_dead_end_06"
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
				"pwh_gameplay_dead_end_01",
				"pwh_gameplay_dead_end_02",
				"pwh_gameplay_dead_end_03",
				"pwh_gameplay_dead_end_04",
				"pwh_gameplay_dead_end_05",
				"pwh_gameplay_dead_end_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_dead_body = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "casual_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_dead_body_01",
				"pwh_gameplay_dead_body_02",
				"pwh_gameplay_dead_body_03",
				"pwh_gameplay_dead_body_04",
				"pwh_gameplay_dead_body_05"
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
				"pwh_gameplay_dead_body_01",
				"pwh_gameplay_dead_body_02",
				"pwh_gameplay_dead_body_03",
				"pwh_gameplay_dead_body_04",
				"pwh_gameplay_dead_body_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_helped_by_dwarf_ranger = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "help_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_helped_by_dwarf_ranger_01",
				"pwh_gameplay_helped_by_dwarf_ranger_02",
				"pwh_gameplay_helped_by_dwarf_ranger_03",
				"pwh_gameplay_helped_by_dwarf_ranger_04"
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
				"pwh_gameplay_helped_by_dwarf_ranger_01",
				"pwh_gameplay_helped_by_dwarf_ranger_02",
				"pwh_gameplay_helped_by_dwarf_ranger_03",
				"pwh_gameplay_helped_by_dwarf_ranger_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dropping_grimoire = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_objective_dropping_grimoire_01",
				"pwh_objective_dropping_grimoire_02",
				"pwh_objective_dropping_grimoire_03",
				"pwh_objective_dropping_grimoire_04",
				"pwh_objective_dropping_grimoire_05",
				"pwh_objective_dropping_grimoire_06",
				"pwh_objective_dropping_grimoire_07",
				"pwh_objective_dropping_grimoire_08"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_dropping_grimoire_01",
				"pwh_objective_dropping_grimoire_02",
				"pwh_objective_dropping_grimoire_03",
				"pwh_objective_dropping_grimoire_04",
				"pwh_objective_dropping_grimoire_05",
				"pwh_objective_dropping_grimoire_06",
				"pwh_objective_dropping_grimoire_07",
				"pwh_objective_dropping_grimoire_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_empire_soldier_on_a_frenzy = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_empire_soldier_on_a_frenzy_01",
				"pwh_gameplay_empire_soldier_on_a_frenzy_02",
				"pwh_gameplay_empire_soldier_on_a_frenzy_03",
				"pwh_gameplay_empire_soldier_on_a_frenzy_04"
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
				"pwh_gameplay_empire_soldier_on_a_frenzy_01",
				"pwh_gameplay_empire_soldier_on_a_frenzy_02",
				"pwh_gameplay_empire_soldier_on_a_frenzy_03",
				"pwh_gameplay_empire_soldier_on_a_frenzy_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_hears_incoming_horde = {
			sound_events_n = 9,
			randomize_indexes_n = 0,
			face_animations_n = 9,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 9,
			sound_events = {
				"pwh_gameplay_hears_incoming_horde_01",
				"pwh_gameplay_hears_incoming_horde_02",
				"pwh_gameplay_hears_incoming_horde_03",
				"pwh_gameplay_hears_incoming_horde_04",
				"pwh_gameplay_hears_incoming_horde_05",
				"pwh_gameplay_hears_incoming_horde_06",
				"pwh_gameplay_hears_incoming_horde_07",
				"pwh_gameplay_hears_incoming_horde_08",
				"pwh_gameplay_hears_incoming_horde_09"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_shout",
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
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pwh_gameplay_hears_incoming_horde_01",
				"pwh_gameplay_hears_incoming_horde_02",
				"pwh_gameplay_hears_incoming_horde_03",
				"pwh_gameplay_hears_incoming_horde_04",
				"pwh_gameplay_hears_incoming_horde_05",
				"pwh_gameplay_hears_incoming_horde_06",
				"pwh_gameplay_hears_incoming_horde_07",
				"pwh_gameplay_hears_incoming_horde_08",
				"pwh_gameplay_hears_incoming_horde_09"
			},
			randomize_indexes = {}
		},
		pwh_spotting_ferry_lady = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_spotting_ferry_lady_01",
				"pwh_spotting_ferry_lady_02",
				"pwh_spotting_ferry_lady_03",
				"pwh_spotting_ferry_lady_04",
				"pwh_spotting_ferry_lady_05",
				"pwh_spotting_ferry_lady_06"
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
				"pwh_spotting_ferry_lady_01",
				"pwh_spotting_ferry_lady_02",
				"pwh_spotting_ferry_lady_03",
				"pwh_spotting_ferry_lady_04",
				"pwh_spotting_ferry_lady_05",
				"pwh_spotting_ferry_lady_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_hearing_a_skaven_rat_ogre = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_hearing_a_skaven_rat_ogre_01",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_04",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_05",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_02",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_03",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_06"
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
				"pwh_gameplay_hearing_a_skaven_rat_ogre_01",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_04",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_05",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_02",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_03",
				"pwh_gameplay_hearing_a_skaven_rat_ogre_06"
			},
			randomize_indexes = {}
		},
		pwh_objective_correct_path_stairs_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_correct_path_stairs_down_01",
				"pwh_objective_correct_path_stairs_down_02",
				"pwh_objective_correct_path_stairs_down_03",
				"pwh_objective_correct_path_stairs_down_04"
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
				"pwh_objective_correct_path_stairs_down_01",
				"pwh_objective_correct_path_stairs_down_02",
				"pwh_objective_correct_path_stairs_down_03",
				"pwh_objective_correct_path_stairs_down_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_nearing_objective_deadline = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_nearing_objective_deadline_01",
				"pwh_objective_nearing_objective_deadline_02",
				"pwh_objective_nearing_objective_deadline_03"
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
				"pwh_objective_nearing_objective_deadline_01",
				"pwh_objective_nearing_objective_deadline_02",
				"pwh_objective_nearing_objective_deadline_03"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_dwarf_ranger_being_helped = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_dwarf_ranger_being_helped_up_01",
				"pwh_gameplay_dwarf_ranger_being_helped_up_02",
				"pwh_gameplay_dwarf_ranger_being_helped_up_03",
				"pwh_gameplay_dwarf_ranger_being_helped_up_04"
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
				"pwh_gameplay_dwarf_ranger_being_helped_up_01",
				"pwh_gameplay_dwarf_ranger_being_helped_up_02",
				"pwh_gameplay_dwarf_ranger_being_helped_up_03",
				"pwh_gameplay_dwarf_ranger_being_helped_up_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_bright_wizard_grabbed = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_bright_wizard_grabbed_01",
				"pwh_gameplay_bright_wizard_grabbed_02",
				"pwh_gameplay_bright_wizard_grabbed_03",
				"pwh_gameplay_bright_wizard_grabbed_04",
				"pwh_gameplay_bright_wizard_grabbed_05",
				"pwh_gameplay_bright_wizard_grabbed_06"
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
				"pwh_gameplay_bright_wizard_grabbed_01",
				"pwh_gameplay_bright_wizard_grabbed_02",
				"pwh_gameplay_bright_wizard_grabbed_03",
				"pwh_gameplay_bright_wizard_grabbed_04",
				"pwh_gameplay_bright_wizard_grabbed_05",
				"pwh_gameplay_bright_wizard_grabbed_06"
			},
			randomize_indexes = {}
		},
		pwh_objective_correct_path_street = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_correct_path_street_01",
				"pwh_objective_correct_path_street_02",
				"pwh_objective_correct_path_street_03",
				"pwh_objective_correct_path_street_04"
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
				"pwh_objective_correct_path_street_01",
				"pwh_objective_correct_path_street_02",
				"pwh_objective_correct_path_street_03",
				"pwh_objective_correct_path_street_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_wood_elf_being_helped_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_wood_elf_being_helped_up_02",
				"pwh_gameplay_wood_elf_being_helped_up_03",
				"pwh_gameplay_wood_elf_being_helped_up_01",
				"pwh_gameplay_wood_elf_being_helped_up_04"
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
				"pwh_gameplay_wood_elf_being_helped_up_02",
				"pwh_gameplay_wood_elf_being_helped_up_03",
				"pwh_gameplay_wood_elf_being_helped_up_01",
				"pwh_gameplay_wood_elf_being_helped_up_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_bright_wizard_on_a_frenzy = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_bright_wizard_on_a_frenzy_01",
				"pwh_gameplay_bright_wizard_on_a_frenzy_02",
				"pwh_gameplay_bright_wizard_on_a_frenzy_03",
				"pwh_gameplay_bright_wizard_on_a_frenzy_04"
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
				"pwh_gameplay_bright_wizard_on_a_frenzy_01",
				"pwh_gameplay_bright_wizard_on_a_frenzy_02",
				"pwh_gameplay_bright_wizard_on_a_frenzy_03",
				"pwh_gameplay_bright_wizard_on_a_frenzy_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_correct_path_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_correct_path_down_01",
				"pwh_objective_correct_path_down_02",
				"pwh_objective_correct_path_down_03",
				"pwh_objective_correct_path_down_04"
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
				"pwh_objective_correct_path_down_01",
				"pwh_objective_correct_path_down_02",
				"pwh_objective_correct_path_down_03",
				"pwh_objective_correct_path_down_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_empire_soldier_grabbed = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_empire_soldier_grabbed_01",
				"pwh_gameplay_empire_soldier_grabbed_02",
				"pwh_gameplay_empire_soldier_grabbed_03",
				"pwh_gameplay_empire_soldier_grabbed_04",
				"pwh_gameplay_empire_soldier_grabbed_05",
				"pwh_gameplay_empire_soldier_grabbed_06"
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
				"pwh_gameplay_empire_soldier_grabbed_01",
				"pwh_gameplay_empire_soldier_grabbed_02",
				"pwh_gameplay_empire_soldier_grabbed_03",
				"pwh_gameplay_empire_soldier_grabbed_04",
				"pwh_gameplay_empire_soldier_grabbed_05",
				"pwh_gameplay_empire_soldier_grabbed_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_low_on_health = {
			sound_events_n = 12,
			randomize_indexes_n = 0,
			face_animations_n = 12,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 12,
			sound_events = {
				"pwh_gameplay_low_on_health_01",
				"pwh_gameplay_low_on_health_02",
				"pwh_gameplay_low_on_health_03",
				"pwh_gameplay_low_on_health_04",
				"pwh_gameplay_low_on_health_05",
				"pwh_gameplay_low_on_health_06",
				"pwh_gameplay_low_on_health_07",
				"pwh_gameplay_low_on_health_08",
				"pwh_gameplay_taking_heavy_damage_01",
				"pwh_gameplay_taking_heavy_damage_02",
				"pwh_gameplay_taking_heavy_damage_03",
				"pwh_gameplay_taking_heavy_damage_05"
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
				"face_fear"
			},
			localization_strings = {
				"pwh_gameplay_low_on_health_01",
				"pwh_gameplay_low_on_health_02",
				"pwh_gameplay_low_on_health_03",
				"pwh_gameplay_low_on_health_04",
				"pwh_gameplay_low_on_health_05",
				"pwh_gameplay_low_on_health_06",
				"pwh_gameplay_low_on_health_07",
				"pwh_gameplay_low_on_health_08",
				"pwh_gameplay_taking_heavy_damage_01",
				"pwh_gameplay_taking_heavy_damage_02",
				"pwh_gameplay_taking_heavy_damage_03",
				"pwh_gameplay_taking_heavy_damage_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_friendly_fire_wood_elf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_friendly_fire_wood_elf_01",
				"pwh_gameplay_friendly_fire_wood_elf_02",
				"pwh_gameplay_friendly_fire_wood_elf_03",
				"pwh_gameplay_friendly_fire_wood_elf_04"
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
				"pwh_gameplay_friendly_fire_wood_elf_01",
				"pwh_gameplay_friendly_fire_wood_elf_02",
				"pwh_gameplay_friendly_fire_wood_elf_03",
				"pwh_gameplay_friendly_fire_wood_elf_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_bright_wizard_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_bright_wizard_dead_01",
				"pwh_gameplay_bright_wizard_dead_02",
				"pwh_gameplay_bright_wizard_dead_03",
				"pwh_gameplay_bright_wizard_dead_04"
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
				"pwh_gameplay_bright_wizard_dead_01",
				"pwh_gameplay_bright_wizard_dead_02",
				"pwh_gameplay_bright_wizard_dead_03",
				"pwh_gameplay_bright_wizard_dead_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_tension_no_enemies = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "casual_talk",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_tension_no_enemies_01",
				"pwh_gameplay_tension_no_enemies_02",
				"pwh_gameplay_tension_no_enemies_03",
				"pwh_gameplay_tension_no_enemies_04",
				"pwh_gameplay_tension_no_enemies_05",
				"pwh_gameplay_tension_no_enemies_06",
				"pwh_gameplay_tension_no_enemies_07",
				"pwh_gameplay_tension_no_enemies_08"
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
				"face_neutral",
				"face_neutral",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_gameplay_tension_no_enemies_01",
				"pwh_gameplay_tension_no_enemies_02",
				"pwh_gameplay_tension_no_enemies_03",
				"pwh_gameplay_tension_no_enemies_04",
				"pwh_gameplay_tension_no_enemies_05",
				"pwh_gameplay_tension_no_enemies_06",
				"pwh_gameplay_tension_no_enemies_07",
				"pwh_gameplay_tension_no_enemies_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_empire_soldier_being_helped_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_empire_soldier_being_helped_up_01",
				"pwh_gameplay_empire_soldier_being_helped_up_02",
				"pwh_gameplay_empire_soldier_being_helped_up_03",
				"pwh_gameplay_empire_soldier_being_helped_up_04"
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
				"pwh_gameplay_empire_soldier_being_helped_up_01",
				"pwh_gameplay_empire_soldier_being_helped_up_02",
				"pwh_gameplay_empire_soldier_being_helped_up_03",
				"pwh_gameplay_empire_soldier_being_helped_up_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_wood_elf_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_wood_elf_dead_01",
				"pwh_gameplay_wood_elf_dead_02",
				"pwh_gameplay_wood_elf_dead_03",
				"pwh_gameplay_wood_elf_dead_04"
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
				"pwh_gameplay_wood_elf_dead_01",
				"pwh_gameplay_wood_elf_dead_02",
				"pwh_gameplay_wood_elf_dead_03",
				"pwh_gameplay_wood_elf_dead_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_dwarf_ranger_on_a_frenzy = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_dwarf_ranger_on_a_frenzy_01",
				"pwh_gameplay_dwarf_ranger_on_a_frenzy_02",
				"pwh_gameplay_dwarf_ranger_on_a_frenzy_03",
				"pwh_gameplay_dwarf_ranger_on_a_frenzy_04"
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
				"pwh_gameplay_dwarf_ranger_on_a_frenzy_01",
				"pwh_gameplay_dwarf_ranger_on_a_frenzy_02",
				"pwh_gameplay_dwarf_ranger_on_a_frenzy_03",
				"pwh_gameplay_dwarf_ranger_on_a_frenzy_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_goal_achieved_escape = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_goal_achieved_escape_01",
				"pwh_objective_goal_achieved_escape_02",
				"pwh_objective_goal_achieved_escape_03",
				"pwh_objective_goal_achieved_escape_04"
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
				"pwh_objective_goal_achieved_escape_01",
				"pwh_objective_goal_achieved_escape_02",
				"pwh_objective_goal_achieved_escape_03",
				"pwh_objective_goal_achieved_escape_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_interacting_with_objective = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_interacting_with_objective_01",
				"pwh_objective_interacting_with_objective_02",
				"pwh_objective_interacting_with_objective_03"
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
				"pwh_objective_interacting_with_objective_01",
				"pwh_objective_interacting_with_objective_02",
				"pwh_objective_interacting_with_objective_03"
			},
			randomize_indexes = {}
		},
		pwh_objective_achieved_all_but_one_goal = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_achieved_all_but_one_goal_01",
				"pwh_objective_achieved_all_but_one_goal_02",
				"pwh_objective_achieved_all_but_one_goal_03",
				"pwh_objective_achieved_all_but_one_goal_04"
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
				"pwh_objective_achieved_all_but_one_goal_01",
				"pwh_objective_achieved_all_but_one_goal_02",
				"pwh_objective_achieved_all_but_one_goal_03",
				"pwh_objective_achieved_all_but_one_goal_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_correct_path_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_correct_path_door_01",
				"pwh_objective_correct_path_door_02",
				"pwh_objective_correct_path_door_03",
				"pwh_objective_correct_path_door_04"
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
				"pwh_objective_correct_path_door_01",
				"pwh_objective_correct_path_door_02",
				"pwh_objective_correct_path_door_03",
				"pwh_objective_correct_path_door_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_goal_achieved_more_left = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_objective_goal_achieved_more_left_01",
				"pwh_objective_goal_achieved_more_left_02",
				"pwh_objective_goal_achieved_more_left_03",
				"pwh_objective_goal_achieved_more_left_04",
				"pwh_objective_goal_achieved_more_left_05",
				"pwh_objective_goal_achieved_more_left_06",
				"pwh_objective_goal_achieved_more_left_07",
				"pwh_objective_goal_achieved_more_left_08"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_goal_achieved_more_left_01",
				"pwh_objective_goal_achieved_more_left_02",
				"pwh_objective_goal_achieved_more_left_03",
				"pwh_objective_goal_achieved_more_left_04",
				"pwh_objective_goal_achieved_more_left_05",
				"pwh_objective_goal_achieved_more_left_06",
				"pwh_objective_goal_achieved_more_left_07",
				"pwh_objective_goal_achieved_more_left_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_spots_potion = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "seen_items",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_spots_potion_01",
				"pwh_gameplay_spots_potion_02",
				"pwh_gameplay_spots_potion_03",
				"pwh_gameplay_spots_potion_04",
				"pwh_gameplay_spots_potion_05"
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
				"pwh_gameplay_spots_potion_01",
				"pwh_gameplay_spots_potion_02",
				"pwh_gameplay_spots_potion_03",
				"pwh_gameplay_spots_potion_04",
				"pwh_gameplay_spots_potion_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_empire_soldier_low_on_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_empire_soldier_low_on_health_01",
				"pwh_gameplay_empire_soldier_low_on_health_02",
				"pwh_gameplay_empire_soldier_low_on_health_03",
				"pwh_gameplay_empire_soldier_low_on_health_04"
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
				"pwh_gameplay_empire_soldier_low_on_health_01",
				"pwh_gameplay_empire_soldier_low_on_health_02",
				"pwh_gameplay_empire_soldier_low_on_health_03",
				"pwh_gameplay_empire_soldier_low_on_health_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_throwing_bomb = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_throwing_bomb_01",
				"pwh_gameplay_throwing_bomb_02",
				"pwh_gameplay_throwing_bomb_03",
				"pwh_gameplay_throwing_bomb_04",
				"pwh_gameplay_throwing_bomb_05"
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
				"pwh_gameplay_throwing_bomb_01",
				"pwh_gameplay_throwing_bomb_02",
				"pwh_gameplay_throwing_bomb_03",
				"pwh_gameplay_throwing_bomb_04",
				"pwh_gameplay_throwing_bomb_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_killing_ratling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_killing_ratling_01",
				"pwh_gameplay_killing_ratling_02",
				"pwh_gameplay_killing_ratling_03",
				"pwh_gameplay_killing_ratling_04"
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
				"pwh_gameplay_killing_ratling_01",
				"pwh_gameplay_killing_ratling_02",
				"pwh_gameplay_killing_ratling_03",
				"pwh_gameplay_killing_ratling_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_armoured_enemy_bright_wizard = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_gameplay_armoured_enemy_bright_wizard_01",
				"pwh_gameplay_armoured_enemy_bright_wizard_02",
				"pwh_gameplay_armoured_enemy_bright_wizard_03"
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
				"pwh_gameplay_armoured_enemy_bright_wizard_01",
				"pwh_gameplay_armoured_enemy_bright_wizard_02",
				"pwh_gameplay_armoured_enemy_bright_wizard_03"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_wood_elf_on_a_frenzy = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_wood_elf_on_a_frenzy_01",
				"pwh_gameplay_wood_elf_on_a_frenzy_02",
				"pwh_gameplay_wood_elf_on_a_frenzy_03",
				"pwh_gameplay_wood_elf_on_a_frenzy_04"
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
				"pwh_gameplay_wood_elf_on_a_frenzy_01",
				"pwh_gameplay_wood_elf_on_a_frenzy_02",
				"pwh_gameplay_wood_elf_on_a_frenzy_03",
				"pwh_gameplay_wood_elf_on_a_frenzy_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_special_enemy_kill_ranged = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_special_enemy_kill_ranged_01",
				"pwh_gameplay_special_enemy_kill_ranged_02",
				"pwh_gameplay_special_enemy_kill_ranged_03",
				"pwh_gameplay_special_enemy_kill_ranged_04",
				"pwh_gameplay_special_enemy_kill_ranged_05",
				"pwh_gameplay_special_enemy_kill_ranged_06",
				"pwh_gameplay_special_enemy_kill_ranged_07",
				"pwh_gameplay_special_enemy_kill_ranged_08"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_gameplay_special_enemy_kill_ranged_01",
				"pwh_gameplay_special_enemy_kill_ranged_02",
				"pwh_gameplay_special_enemy_kill_ranged_03",
				"pwh_gameplay_special_enemy_kill_ranged_04",
				"pwh_gameplay_special_enemy_kill_ranged_05",
				"pwh_gameplay_special_enemy_kill_ranged_06",
				"pwh_gameplay_special_enemy_kill_ranged_07",
				"pwh_gameplay_special_enemy_kill_ranged_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_ambush_horde_spawned = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_ambush_horde_spawned_01",
				"pwh_gameplay_ambush_horde_spawned_02",
				"pwh_gameplay_ambush_horde_spawned_03",
				"pwh_gameplay_ambush_horde_spawned_04",
				"pwh_gameplay_ambush_horde_spawned_05",
				"pwh_gameplay_ambush_horde_spawned_06",
				"pwh_gameplay_ambush_horde_spawned_07",
				"pwh_gameplay_ambush_horde_spawned_08"
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
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise"
			},
			localization_strings = {
				"pwh_gameplay_ambush_horde_spawned_01",
				"pwh_gameplay_ambush_horde_spawned_02",
				"pwh_gameplay_ambush_horde_spawned_03",
				"pwh_gameplay_ambush_horde_spawned_04",
				"pwh_gameplay_ambush_horde_spawned_05",
				"pwh_gameplay_ambush_horde_spawned_06",
				"pwh_gameplay_ambush_horde_spawned_07",
				"pwh_gameplay_ambush_horde_spawned_08"
			},
			randomize_indexes = {}
		},
		pwh_targeted_by_ratling = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_targeted_by_ratling_01",
				"pwh_targeted_by_ratling_02",
				"pwh_targeted_by_ratling_03",
				"pwh_targeted_by_ratling_04",
				"pwh_targeted_by_ratling_05",
				"pwh_targeted_by_ratling_06",
				"pwh_targeted_by_ratling_07",
				"pwh_targeted_by_ratling_08"
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
				"pwh_targeted_by_ratling_01",
				"pwh_targeted_by_ratling_02",
				"pwh_targeted_by_ratling_03",
				"pwh_targeted_by_ratling_04",
				"pwh_targeted_by_ratling_05",
				"pwh_targeted_by_ratling_06",
				"pwh_targeted_by_ratling_07",
				"pwh_targeted_by_ratling_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_friendly_fire_dwarf_ranger = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_friendly_fire_dwarf_ranger_01",
				"pwh_gameplay_friendly_fire_dwarf_ranger_02",
				"pwh_gameplay_friendly_fire_dwarf_ranger_03",
				"pwh_gameplay_friendly_fire_dwarf_ranger_04"
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
				"pwh_gameplay_friendly_fire_dwarf_ranger_01",
				"pwh_gameplay_friendly_fire_dwarf_ranger_02",
				"pwh_gameplay_friendly_fire_dwarf_ranger_03",
				"pwh_gameplay_friendly_fire_dwarf_ranger_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_hearing_a_skaven_ratling_gun = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwh_gameplay_hearing_a_skaven_ratling_gun_04",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_05",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_06",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_01",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_02",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_03",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_07"
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
				"pwh_gameplay_hearing_a_skaven_ratling_gun_04",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_05",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_06",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_01",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_02",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_03",
				"pwh_gameplay_hearing_a_skaven_ratling_gun_07"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_bright_wizard_low_on_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_bright_wizard_low_on_health_01",
				"pwh_gameplay_bright_wizard_low_on_health_02",
				"pwh_gameplay_bright_wizard_low_on_health_03",
				"pwh_gameplay_bright_wizard_low_on_health_04"
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
				"pwh_gameplay_bright_wizard_low_on_health_01",
				"pwh_gameplay_bright_wizard_low_on_health_02",
				"pwh_gameplay_bright_wizard_low_on_health_03",
				"pwh_gameplay_bright_wizard_low_on_health_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_dwarf_ranger_low_on_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_dwarf_ranger_low_on_health_01",
				"pwh_gameplay_dwarf_ranger_low_on_health_02",
				"pwh_gameplay_dwarf_ranger_low_on_health_03",
				"pwh_gameplay_dwarf_ranger_low_on_health_04"
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
				"pwh_gameplay_dwarf_ranger_low_on_health_01",
				"pwh_gameplay_dwarf_ranger_low_on_health_02",
				"pwh_gameplay_dwarf_ranger_low_on_health_03",
				"pwh_gameplay_dwarf_ranger_low_on_health_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_taking_heavy_damage = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwh_gameplay_taking_heavy_damage_04",
				"pwh_gameplay_taking_heavy_damage_06",
				"pwh_curse_01",
				"pwh_curse_04",
				"pwh_curse_01",
				"pwh_curse_10",
				"pwh_curse_12"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_fear",
				"face_pain",
				"face_pain",
				"face_pain",
				"face_pain",
				"face_pain",
				"face_pain"
			},
			localization_strings = {
				"pwh_gameplay_taking_heavy_damage_04",
				"pwh_gameplay_taking_heavy_damage_06",
				"pwh_curse_01",
				"pwh_curse_04",
				"pwh_curse_01",
				"pwh_curse_10",
				"pwh_curse_12"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_friendly_fire_bright_wizard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_friendly_fire_bright_wizard_01",
				"pwh_gameplay_friendly_fire_bright_wizard_02",
				"pwh_gameplay_friendly_fire_bright_wizard_03",
				"pwh_gameplay_friendly_fire_bright_wizard_04"
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
				"pwh_gameplay_friendly_fire_bright_wizard_01",
				"pwh_gameplay_friendly_fire_bright_wizard_02",
				"pwh_gameplay_friendly_fire_bright_wizard_03",
				"pwh_gameplay_friendly_fire_bright_wizard_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_friendly_fire_empire_soldier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_friendly_fire_empire_soldier_01",
				"pwh_gameplay_friendly_fire_empire_soldier_02",
				"pwh_gameplay_friendly_fire_empire_soldier_03",
				"pwh_gameplay_friendly_fire_empire_soldier_04"
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
				"pwh_gameplay_friendly_fire_empire_soldier_01",
				"pwh_gameplay_friendly_fire_empire_soldier_02",
				"pwh_gameplay_friendly_fire_empire_soldier_03",
				"pwh_gameplay_friendly_fire_empire_soldier_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_seeing_a_globadier = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_seeing_a_globadier_01",
				"pwh_gameplay_seeing_a_globadier_03",
				"pwh_gameplay_seeing_a_globadier_04",
				"pwh_gameplay_seeing_a_globadier_02",
				"pwh_gameplay_seeing_a_globadier_05",
				"pwh_gameplay_seeing_a_globadier_06"
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
				"pwh_gameplay_seeing_a_globadier_01",
				"pwh_gameplay_seeing_a_globadier_03",
				"pwh_gameplay_seeing_a_globadier_04",
				"pwh_gameplay_seeing_a_globadier_02",
				"pwh_gameplay_seeing_a_globadier_05",
				"pwh_gameplay_seeing_a_globadier_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_killing_lootrat = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_killing_lootrat_01",
				"pwh_gameplay_killing_lootrat_02",
				"pwh_gameplay_killing_lootrat_03",
				"pwh_gameplay_killing_lootrat_04"
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
				"pwh_gameplay_killing_lootrat_01",
				"pwh_gameplay_killing_lootrat_02",
				"pwh_gameplay_killing_lootrat_03",
				"pwh_gameplay_killing_lootrat_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_activating_magic_weapon_defensive = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_activating_magic_weapon_defensive_01",
				"pwh_gameplay_activating_magic_weapon_defensive_02",
				"pwh_gameplay_activating_magic_weapon_defensive_03",
				"pwh_gameplay_activating_magic_weapon_defensive_04",
				"pwh_gameplay_activating_magic_weapon_defensive_05"
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
				"pwh_gameplay_activating_magic_weapon_defensive_01",
				"pwh_gameplay_activating_magic_weapon_defensive_02",
				"pwh_gameplay_activating_magic_weapon_defensive_03",
				"pwh_gameplay_activating_magic_weapon_defensive_04",
				"pwh_gameplay_activating_magic_weapon_defensive_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_activating_magic_weapon_offensive = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_activating_magic_weapon_offensive_01",
				"pwh_gameplay_activating_magic_weapon_offensive_02",
				"pwh_gameplay_activating_magic_weapon_offensive_03",
				"pwh_gameplay_activating_magic_weapon_offensive_04",
				"pwh_gameplay_activating_magic_weapon_offensive_05"
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
				"pwh_gameplay_activating_magic_weapon_offensive_01",
				"pwh_gameplay_activating_magic_weapon_offensive_02",
				"pwh_gameplay_activating_magic_weapon_offensive_03",
				"pwh_gameplay_activating_magic_weapon_offensive_04",
				"pwh_gameplay_activating_magic_weapon_offensive_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_armoured_enemy_wood_elf = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_gameplay_armoured_enemy_wood_elf_01",
				"pwh_gameplay_armoured_enemy_wood_elf_02",
				"pwh_gameplay_armoured_enemy_wood_elf_03"
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
				"pwh_gameplay_armoured_enemy_wood_elf_01",
				"pwh_gameplay_armoured_enemy_wood_elf_02",
				"pwh_gameplay_armoured_enemy_wood_elf_03"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_killing_globadier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_killing_globadier_01",
				"pwh_gameplay_killing_globadier_02",
				"pwh_gameplay_killing_globadier_03",
				"pwh_gameplay_killing_globadier_04"
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
				"pwh_gameplay_killing_globadier_01",
				"pwh_gameplay_killing_globadier_02",
				"pwh_gameplay_killing_globadier_03",
				"pwh_gameplay_killing_globadier_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_hit_by_goo = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwh_gameplay_hit_by_goo_02",
				"pwh_gameplay_hit_by_goo_03",
				"pwh_gameplay_hit_by_goo_04",
				"pwh_gameplay_hit_by_goo_05",
				"pwh_gameplay_hit_by_goo_06",
				"pwh_gameplay_hit_by_goo_07",
				"pwh_gameplay_hit_by_goo_08"
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
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise",
				"face_surprise"
			},
			localization_strings = {
				"pwh_gameplay_hit_by_goo_02",
				"pwh_gameplay_hit_by_goo_03",
				"pwh_gameplay_hit_by_goo_04",
				"pwh_gameplay_hit_by_goo_05",
				"pwh_gameplay_hit_by_goo_06",
				"pwh_gameplay_hit_by_goo_07",
				"pwh_gameplay_hit_by_goo_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_killing_gutterrunner = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_killing_gutterrunner_01",
				"pwh_gameplay_killing_gutterrunner_02",
				"pwh_gameplay_killing_gutterrunner_03",
				"pwh_gameplay_killing_gutterrunner_04"
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
				"pwh_gameplay_killing_gutterrunner_01",
				"pwh_gameplay_killing_gutterrunner_02",
				"pwh_gameplay_killing_gutterrunner_03",
				"pwh_gameplay_killing_gutterrunner_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_seeing_a_skaven_patrol_stormvermin = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_01",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_02",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_03",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_04",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_05",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_06",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_07"
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
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_01",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_02",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_03",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_04",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_05",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_06",
				"pwh_gameplay_seeing_a_skaven_patrol_stormvermin_07"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_heard_dwarf_ranger_in_trouble = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_heard_dwarf_ranger_in_trouble_01",
				"pwh_gameplay_heard_dwarf_ranger_in_trouble_02",
				"pwh_gameplay_heard_dwarf_ranger_in_trouble_03",
				"pwh_gameplay_heard_dwarf_ranger_in_trouble_04"
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
				"pwh_gameplay_heard_dwarf_ranger_in_trouble_01",
				"pwh_gameplay_heard_dwarf_ranger_in_trouble_02",
				"pwh_gameplay_heard_dwarf_ranger_in_trouble_03",
				"pwh_gameplay_heard_dwarf_ranger_in_trouble_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_healing_draught = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "seen_items",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_healing_draught_01",
				"pwh_gameplay_healing_draught_02",
				"pwh_gameplay_healing_draught_03",
				"pwh_gameplay_healing_draught_04",
				"pwh_gameplay_healing_draught_05",
				"pwh_gameplay_healing_draught_06",
				"pwh_gameplay_healing_draught_07",
				"pwh_gameplay_healing_draught_08"
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
				"pwh_gameplay_healing_draught_01",
				"pwh_gameplay_healing_draught_02",
				"pwh_gameplay_healing_draught_03",
				"pwh_gameplay_healing_draught_04",
				"pwh_gameplay_healing_draught_05",
				"pwh_gameplay_healing_draught_06",
				"pwh_gameplay_healing_draught_07",
				"pwh_gameplay_healing_draught_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_incoming_skaven_rat_ogre = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_incoming_skaven_rat_ogre_01",
				"pwh_gameplay_incoming_skaven_rat_ogre_05",
				"pwh_gameplay_incoming_skaven_rat_ogre_06",
				"pwh_gameplay_incoming_skaven_rat_ogre_02",
				"pwh_gameplay_incoming_skaven_rat_ogre_03",
				"pwh_gameplay_incoming_skaven_rat_ogre_04",
				"pwh_gameplay_incoming_skaven_rat_ogre_07",
				"pwh_gameplay_incoming_skaven_rat_ogre_08"
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
				"pwh_gameplay_incoming_skaven_rat_ogre_01",
				"pwh_gameplay_incoming_skaven_rat_ogre_05",
				"pwh_gameplay_incoming_skaven_rat_ogre_06",
				"pwh_gameplay_incoming_skaven_rat_ogre_02",
				"pwh_gameplay_incoming_skaven_rat_ogre_03",
				"pwh_gameplay_incoming_skaven_rat_ogre_04",
				"pwh_gameplay_incoming_skaven_rat_ogre_07",
				"pwh_gameplay_incoming_skaven_rat_ogre_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_seeing_a_skaven_rat_ogre = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_seeing_a_skaven_rat_ogre_01",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_04",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_06",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_02",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_03",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_05"
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
				"pwh_gameplay_seeing_a_skaven_rat_ogre_01",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_04",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_06",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_02",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_03",
				"pwh_gameplay_seeing_a_skaven_rat_ogre_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_seeing_a_skaven_ratling_gun = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwh_gameplay_seeing_a_skaven_ratling_gun_01",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_02",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_03",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_04",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_05",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_06",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_07"
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
				"pwh_gameplay_seeing_a_skaven_ratling_gun_01",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_02",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_03",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_04",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_05",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_06",
				"pwh_gameplay_seeing_a_skaven_ratling_gun_07"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_player_pounced = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_player_pounced_01",
				"pwh_gameplay_player_pounced_02",
				"pwh_gameplay_player_pounced_03",
				"pwh_gameplay_player_pounced_04",
				"pwh_gameplay_player_pounced_05",
				"pwh_gameplay_player_pounced_06"
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
				"pwh_gameplay_player_pounced_01",
				"pwh_gameplay_player_pounced_02",
				"pwh_gameplay_player_pounced_03",
				"pwh_gameplay_player_pounced_04",
				"pwh_gameplay_player_pounced_05",
				"pwh_gameplay_player_pounced_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_seeing_a_gutter_runner = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_seeing_a_gutter_runner_01",
				"pwh_gameplay_seeing_a_gutter_runner_02",
				"pwh_gameplay_seeing_a_gutter_runner_03",
				"pwh_gameplay_seeing_a_gutter_runner_04",
				"pwh_gameplay_seeing_a_gutter_runner_05",
				"pwh_gameplay_seeing_a_gutter_runner_06"
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
				"pwh_gameplay_seeing_a_gutter_runner_01",
				"pwh_gameplay_seeing_a_gutter_runner_02",
				"pwh_gameplay_seeing_a_gutter_runner_03",
				"pwh_gameplay_seeing_a_gutter_runner_04",
				"pwh_gameplay_seeing_a_gutter_runner_05",
				"pwh_gameplay_seeing_a_gutter_runner_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_seeing_a_skaven_slaver = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_seeing_a_skaven_slaver_01",
				"pwh_gameplay_seeing_a_skaven_slaver_02",
				"pwh_gameplay_seeing_a_skaven_slaver_07",
				"pwh_gameplay_seeing_a_skaven_slaver_03",
				"pwh_gameplay_seeing_a_skaven_slaver_04",
				"pwh_gameplay_seeing_a_skaven_slaver_05",
				"pwh_gameplay_seeing_a_skaven_slaver_06",
				"pwh_gameplay_seeing_a_skaven_slaver_08"
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
				"pwh_gameplay_seeing_a_skaven_slaver_01",
				"pwh_gameplay_seeing_a_skaven_slaver_02",
				"pwh_gameplay_seeing_a_skaven_slaver_07",
				"pwh_gameplay_seeing_a_skaven_slaver_03",
				"pwh_gameplay_seeing_a_skaven_slaver_04",
				"pwh_gameplay_seeing_a_skaven_slaver_05",
				"pwh_gameplay_seeing_a_skaven_slaver_06",
				"pwh_gameplay_seeing_a_skaven_slaver_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_out_of_ammo = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_gameplay_out_of_ammo_01",
				"pwh_gameplay_out_of_ammo_03",
				"pwh_gameplay_out_of_ammo_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"pwh_gameplay_out_of_ammo_01",
				"pwh_gameplay_out_of_ammo_03",
				"pwh_gameplay_out_of_ammo_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_wood_elf_low_on_health = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_wood_elf_low_on_health_01",
				"pwh_gameplay_wood_elf_low_on_health_02",
				"pwh_gameplay_wood_elf_low_on_health_03",
				"pwh_gameplay_wood_elf_low_on_health_04"
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
				"pwh_gameplay_wood_elf_low_on_health_01",
				"pwh_gameplay_wood_elf_low_on_health_02",
				"pwh_gameplay_wood_elf_low_on_health_03",
				"pwh_gameplay_wood_elf_low_on_health_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_helped_by_wood_elf = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "help_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_helped_by_wood_elf_01",
				"pwh_gameplay_helped_by_wood_elf_02",
				"pwh_gameplay_helped_by_wood_elf_03",
				"pwh_gameplay_helped_by_wood_elf_04"
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
				"pwh_gameplay_helped_by_wood_elf_01",
				"pwh_gameplay_helped_by_wood_elf_02",
				"pwh_gameplay_helped_by_wood_elf_03",
				"pwh_gameplay_helped_by_wood_elf_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_correct_path_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_correct_path_bridge_01",
				"pwh_objective_correct_path_bridge_14",
				"pwh_objective_correct_path_bridge_15",
				"pwh_objective_correct_path_bridge_16"
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
				"pwh_objective_correct_path_bridge_01",
				"pwh_objective_correct_path_bridge_14",
				"pwh_objective_correct_path_bridge_15",
				"pwh_objective_correct_path_bridge_16"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_helped_by_empire_soldier = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "help_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_helped_by_empire_soldier_01",
				"pwh_gameplay_helped_by_empire_soldier_02",
				"pwh_gameplay_helped_by_empire_soldier_03",
				"pwh_gameplay_helped_by_empire_soldier_04"
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
				"pwh_gameplay_helped_by_empire_soldier_01",
				"pwh_gameplay_helped_by_empire_soldier_02",
				"pwh_gameplay_helped_by_empire_soldier_03",
				"pwh_gameplay_helped_by_empire_soldier_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_healing_bright_wizard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_healing_bright_wizard_01",
				"pwh_gameplay_healing_bright_wizard_02",
				"pwh_gameplay_healing_bright_wizard_03",
				"pwh_gameplay_healing_bright_wizard_04"
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
				"pwh_gameplay_healing_bright_wizard_01",
				"pwh_gameplay_healing_bright_wizard_02",
				"pwh_gameplay_healing_bright_wizard_03",
				"pwh_gameplay_healing_bright_wizard_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_seeing_a_stormvermin = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_seeing_a_stormvermin_01",
				"pwh_gameplay_seeing_a_stormvermin_02",
				"pwh_gameplay_seeing_a_stormvermin_03",
				"pwh_gameplay_seeing_a_stormvermin_04",
				"pwh_gameplay_seeing_a_stormvermin_05",
				"pwh_gameplay_seeing_a_stormvermin_06",
				"pwh_gameplay_seeing_a_stormvermin_07",
				"pwh_gameplay_seeing_a_stormvermin_08"
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
				"pwh_gameplay_seeing_a_stormvermin_01",
				"pwh_gameplay_seeing_a_stormvermin_02",
				"pwh_gameplay_seeing_a_stormvermin_03",
				"pwh_gameplay_seeing_a_stormvermin_04",
				"pwh_gameplay_seeing_a_stormvermin_05",
				"pwh_gameplay_seeing_a_stormvermin_06",
				"pwh_gameplay_seeing_a_stormvermin_07",
				"pwh_gameplay_seeing_a_stormvermin_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_healing_dwarf_ranger = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_healing_dwarf_ranger_01",
				"pwh_gameplay_healing_dwarf_ranger_02",
				"pwh_gameplay_healing_dwarf_ranger_03",
				"pwh_gameplay_healing_dwarf_ranger_04"
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
				"pwh_gameplay_healing_dwarf_ranger_01",
				"pwh_gameplay_healing_dwarf_ranger_02",
				"pwh_gameplay_healing_dwarf_ranger_03",
				"pwh_gameplay_healing_dwarf_ranger_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_special_enemy_kill_melee = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_special_enemy_kill_melee_01",
				"pwh_gameplay_special_enemy_kill_melee_02",
				"pwh_gameplay_special_enemy_kill_melee_03",
				"pwh_gameplay_special_enemy_kill_melee_04",
				"pwh_gameplay_special_enemy_kill_melee_05",
				"pwh_gameplay_special_enemy_kill_melee_06",
				"pwh_gameplay_special_enemy_kill_melee_07",
				"pwh_gameplay_special_enemy_kill_melee_08"
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_gameplay_special_enemy_kill_melee_01",
				"pwh_gameplay_special_enemy_kill_melee_02",
				"pwh_gameplay_special_enemy_kill_melee_03",
				"pwh_gameplay_special_enemy_kill_melee_04",
				"pwh_gameplay_special_enemy_kill_melee_05",
				"pwh_gameplay_special_enemy_kill_melee_06",
				"pwh_gameplay_special_enemy_kill_melee_07",
				"pwh_gameplay_special_enemy_kill_melee_08"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_dwarf_ranger_dead = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_dwarf_ranger_dead_01",
				"pwh_gameplay_dwarf_ranger_dead_02",
				"pwh_gameplay_dwarf_ranger_dead_03",
				"pwh_gameplay_dwarf_ranger_dead_04"
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
				"pwh_gameplay_dwarf_ranger_dead_01",
				"pwh_gameplay_dwarf_ranger_dead_02",
				"pwh_gameplay_dwarf_ranger_dead_03",
				"pwh_gameplay_dwarf_ranger_dead_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_killing_packmaster = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_gameplay_killing_packmaster_01",
				"pwh_gameplay_killing_packmaster_02",
				"pwh_gameplay_killing_packmaster_03",
				"pwh_gameplay_killing_packmaster_04"
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
				"pwh_gameplay_killing_packmaster_01",
				"pwh_gameplay_killing_packmaster_02",
				"pwh_gameplay_killing_packmaster_03",
				"pwh_gameplay_killing_packmaster_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_wood_elf_grabbed = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "witch_hunter",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_wood_elf_grabbed_01",
				"pwh_gameplay_wood_elf_grabbed_03",
				"pwh_gameplay_wood_elf_grabbed_05",
				"pwh_gameplay_wood_elf_grabbed_02",
				"pwh_gameplay_wood_elf_grabbed_04",
				"pwh_gameplay_wood_elf_grabbed_06"
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
				"pwh_gameplay_wood_elf_grabbed_01",
				"pwh_gameplay_wood_elf_grabbed_03",
				"pwh_gameplay_wood_elf_grabbed_05",
				"pwh_gameplay_wood_elf_grabbed_02",
				"pwh_gameplay_wood_elf_grabbed_04",
				"pwh_gameplay_wood_elf_grabbed_06"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_self_heal = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "witch_hunter",
			category = "player_feedback",
			dialogue_animations_n = 5,
			sound_events = {
				"pwh_gameplay_self_heal_01",
				"pwh_gameplay_self_heal_02",
				"pwh_gameplay_self_heal_03",
				"pwh_gameplay_self_heal_04",
				"pwh_gameplay_self_heal_05"
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
				"pwh_gameplay_self_heal_01",
				"pwh_gameplay_self_heal_02",
				"pwh_gameplay_self_heal_03",
				"pwh_gameplay_self_heal_04",
				"pwh_gameplay_self_heal_05"
			},
			randomize_indexes = {}
		},
		pwh_objective_correct_path_up = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "witch_hunter",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_correct_path_up_01",
				"pwh_objective_correct_path_up_02",
				"pwh_objective_correct_path_up_03",
				"pwh_objective_correct_path_up_04"
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
				"pwh_objective_correct_path_up_01",
				"pwh_objective_correct_path_up_02",
				"pwh_objective_correct_path_up_03",
				"pwh_objective_correct_path_up_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
