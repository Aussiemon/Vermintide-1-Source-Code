local function count_event_breed(breed_name)
	return Managers.state.conflict:count_units_by_breed_during_event(breed_name)
end

local function count_breed(breed_name)
	return Managers.state.conflict:count_units_by_breed(breed_name)
end

local function current_intensity()
	return Managers.state.conflict.pacing:get_intensity()
end

local function current_difficulty()
	return Managers.state.difficulty.difficulty
end

WeightedRandomTerrorEvents = {
	roger_and_friends = {
		"roger_mayhem",
		10,
		"lonely_roger",
		1
	},
	chunk_cemetery_alt_objective_1 = {
		"cemetery_alt_objective_1_v1",
		1,
		"cemetery_alt_objective_1_v2",
		1
	},
	forest_end = {
		"forest_end_event_a",
		5,
		"forest_end_event_b",
		5,
		"forest_end_event_c",
		3
	},
	forest_skaven_camp = {
		"forest_skaven_camp_a",
		1,
		"forest_skaven_camp_b",
		1,
		"forest_skaven_camp_c",
		1
	},
	farm_larger_events = {
		"farm_event_larger",
		1,
		"farm_event_larger_vermin",
		0.5
	},
	farm_larger_2ndevents = {
		"farm_event_larger_second",
		1,
		"farm_event_larger_second_vermin",
		0.5
	},
	farm_larger_3rdevents = {
		"farm_event_larger_third",
		1,
		"farm_event_larger_third_vermin",
		0.5
	},
	magnus_door = {
		"magnus_door_a",
		1,
		"magnus_door_b",
		1
	},
	tunnels_elevator_event_random = {
		"tunnels_elevator_event_a",
		1,
		"tunnels_elevator_event_b",
		1,
		"tunnels_elevator_event_c",
		1
	},
	tunnels_elevator_event_random_start = {
		"tunnels_elevator_event_a",
		1,
		"tunnels_elevator_event_b",
		1
	},
	tunnels_end_room_random = {
		"random_skaven_end_event_smaller",
		1,
		"random_skaven_end_event_small",
		1,
		"random_skaven_end_event_medium",
		1
	},
	courtyard_events = {
		"courtyard_rolling_event",
		1
	},
	courtyard_special_fun = {
		"generic_specials_fun_a",
		1,
		"generic_specials_fun_b",
		1
	},
	cemetery_plague_brew_event_1 = {
		"cemetery_plague_brew_event_1_a",
		1,
		"cemetery_plague_brew_event_1_b",
		1
	},
	cemetery_plague_brew_event_2 = {
		"cemetery_plague_brew_event_2_a",
		1,
		"cemetery_plague_brew_event_2_b",
		1
	},
	cemetery_plague_brew_event_3 = {
		"cemetery_plague_brew_event_3_a",
		1,
		"cemetery_plague_brew_event_3_b",
		1
	},
	cemetery_plague_brew_event_4 = {
		"cemetery_plague_brew_event_4_a",
		1,
		"cemetery_plague_brew_event_4_b",
		1
	},
	end_boss_terror_c = {
		"end_boss_terror_c1",
		1,
		"end_boss_terror_c2",
		1
	},
	city_wall_a = {
		"city_wall_a",
		1
	},
	city_wall_b = {
		"city_wall_b",
		1
	},
	city_wall_c = {
		"city_wall_c",
		1
	},
	city_wall_d = {
		"city_wall_d",
		1
	},
	city_wall_end = {
		"city_wall_end",
		1
	},
	generic_special_fun = {
		"generic_specials_fun_a",
		1,
		"generic_specials_fun_b",
		1
	},
	merchant_market_event = {
		"merchant_market_event_a",
		1,
		"merchant_market_event_b",
		1,
		"merchant_market_event_c",
		1
	},
	merchant_market_event_no_b = {
		"merchant_market_event_a",
		1,
		"merchant_market_event_c",
		1
	},
	walls_gate_guards = {
		"walls_gate_guards_a",
		1,
		"walls_gate_guards_b",
		1
	},
	dlc_portals_a = {
		"dlc_portals_a",
		1
	},
	dlc_portals_b = {
		"dlc_portals_b",
		1
	},
	dlc_portals_c = {
		"dlc_portals_c",
		1
	},
	end_event_statuette_guards = {
		"end_event_statuette_guards_01",
		1,
		"end_event_statuette_guards_02",
		1,
		"end_event_statuette_guards_03",
		1,
		"end_event_statuette_guards_04",
		1
	},
	dungeon_random_stormvermin_addition = {
		"dungeon_random_stormvermin_addition_a",
		1,
		"dungeon_random_stormvermin_addition_b",
		1,
		"dungeon_random_stormvermin_addition_c",
		1
	},
	survival_wave_initial = {
		"survival_wave_abd",
		1
	},
	survival_wave_a = {
		"survival_wave_bac",
		1
	},
	survival_wave_b = {
		"survival_wave_cad",
		1
	},
	survival_wave_c = {
		"survival_wave_dba",
		1
	},
	survival_wave_d = {
		"survival_wave_cdb",
		1
	},
	survival_wave_e = {
		"survival_wave_acd",
		1
	},
	survival_wave_f = {
		"survival_wave_dab",
		1
	},
	survival_wave_easy_a = {
		"survival_wave_easy_a_1",
		1,
		"survival_wave_easy_a_2",
		1
	},
	survival_wave_easy_b = {
		"survival_wave_easy_b_1",
		1,
		"survival_wave_easy_b_2",
		1
	},
	survival_wave_flush_a = {
		"survival_flush_in",
		1
	},
	survival_wave_flush_b = {
		"survival_flush_out",
		1
	},
	survival_wave_extra_spice_round_2 = {
		"survival_esr2_a",
		1
	},
	survival_wave_extra_spice_round_3 = {
		"survival_esr3_a",
		1
	},
	survival_wave_specials_a = {
		"survival_specials_a",
		1
	},
	survival_wave_specials_b = {
		"survival_specials_b",
		1
	},
	survival_wave_specials_c = {
		"survival_specials_c",
		1
	},
	survival_wave_specials_d = {
		"survival_specials_d",
		1
	},
	survival_wave_boss_a = {
		"survival_boss_a",
		1
	},
	survival_wave_boss_13 = {
		"survival_13_a",
		1
	},
	survival_nightmare_wave_easy_a = {
		"survival_nightmare_wave_easy_a_1",
		1,
		"survival_nightmare_wave_easy_a_2",
		1
	},
	survival_nightmare_wave_easy_b = {
		"survival_nightmare_wave_easy_b_1",
		1,
		"survival_nightmare_wave_easy_b_2",
		1
	},
	survival_nightmare_wave_specials_a = {
		"survival_nightmare_specials_a",
		1
	},
	survival_nightmare_wave_specials_b = {
		"survival_nightmare_specials_b",
		1
	},
	survival_nightmare_wave_specials_c = {
		"survival_nightmare_specials_c",
		1
	},
	survival_nightmare_wave_boss_a = {
		"survival_nightmare_boss_a",
		1
	},
	survival_nightmare_wave_boss_13 = {
		"survival_nightmare_13_a",
		1
	},
	survival_cataclysm_wave_a = {
		"survival_cataclysm_wave_bac",
		1
	},
	survival_cataclysm_wave_b = {
		"survival_cataclysm_wave_cad",
		1
	},
	survival_cataclysm_wave_c = {
		"survival_cataclysm_wave_dba",
		1
	},
	survival_cataclysm_wave_d = {
		"survival_cataclysm_wave_cdb",
		1
	},
	survival_cataclysm_wave_e = {
		"survival_cataclysm_wave_acd",
		1
	},
	survival_cataclysm_wave_f = {
		"survival_cataclysm_wave_dab",
		1
	},
	survival_cataclysm_wave_flush_a = {
		"survival_flush_in",
		1
	},
	survival_cataclysm_wave_flush_b = {
		"survival_flush_out",
		1
	},
	survival_cataclysm_wave_extra_spice_round_2 = {
		"survival_esr2_a",
		1
	},
	survival_cataclysm_wave_extra_spice_round_3 = {
		"survival_esr3_a",
		1
	},
	survival_cataclysm_wave_specials_a = {
		"survival_cataclysm_specials_a",
		1
	},
	survival_cataclysm_wave_specials_b = {
		"survival_cataclysm_specials_b",
		1
	},
	survival_cataclysm_wave_specials_c = {
		"survival_cataclysm_specials_c",
		1
	},
	survival_cataclysm_wave_specials_d = {
		"survival_cataclysm_specials_d",
		1
	},
	survival_cataclysm_wave_specials_e = {
		"survival_cataclysm_specials_e",
		1
	},
	survival_cataclysm_wave_specials_f = {
		"survival_cataclysm_specials_f",
		1
	},
	survival_cataclysm_wave_specials_g = {
		"survival_cataclysm_specials_g",
		1
	},
	survival_cataclysm_wave_specials_h = {
		"survival_cataclysm_specials_h",
		1
	},
	survival_cataclysm_wave_specials_i = {
		"survival_cataclysm_specials_i",
		1
	},
	survival_cataclysm_wave_boss_a = {
		"survival_cataclysm_boss_a",
		1,
		"survival_cataclysm_boss_b",
		1
	},
	survival_cataclysm_wave_boss_b = {
		"survival_cataclysm_boss_c",
		1,
		"survival_cataclysm_boss_d",
		1
	},
	survival_cataclysm_wave_boss_13_a = {
		"survival_cataclysm_13_a",
		1,
		"survival_cataclysm_13_b",
		1
	},
	survival_cataclysm_wave_boss_13_b = {
		"survival_cataclysm_13_c",
		1,
		"survival_cataclysm_13_d",
		1
	},
	survival_cataclysm_wave_boss_13_c = {
		"survival_cataclysm_13_e",
		1,
		"survival_cataclysm_13_f",
		1
	},
	survival_magnus_wave_initial = {
		"survival_magnus_wave_intro",
		1
	},
	survival_magnus_wave_a = {
		"survival_magnus_wave_bac",
		1
	},
	survival_magnus_wave_b = {
		"survival_magnus_wave_cad",
		1
	},
	survival_magnus_wave_c = {
		"survival_magnus_wave_dba",
		1
	},
	survival_magnus_wave_d = {
		"survival_magnus_wave_cdb",
		1
	},
	survival_magnus_wave_e = {
		"survival_magnus_wave_acd",
		1
	},
	survival_magnus_wave_f = {
		"survival_magnus_wave_dab",
		1
	},
	survival_magnus_wave_easy_a = {
		"survival_magnus_wave_easy_a_1",
		1,
		"survival_magnus_wave_easy_a_2",
		1
	},
	survival_magnus_wave_easy_b = {
		"survival_magnus_wave_easy_b_1",
		1,
		"survival_magnus_wave_easy_b_2",
		1
	},
	survival_magnus_wave_flush_a = {
		"survival_magnus_flush_in",
		1
	},
	survival_magnus_wave_flush_b = {
		"survival_magnus_flush_out",
		1
	},
	survival_magnus_wave_extra_spice_round_2 = {
		"survival_magnus_esr2_a",
		1
	},
	survival_magnus_wave_extra_spice_round_3 = {
		"survival_magnus_esr3_a",
		1
	},
	survival_magnus_wave_specials_a = {
		"survival_magnus_specials_a",
		1
	},
	survival_magnus_wave_specials_b = {
		"survival_magnus_specials_b",
		1
	},
	survival_magnus_wave_specials_c = {
		"survival_magnus_specials_c",
		1
	},
	survival_magnus_wave_specials_d = {
		"survival_magnus_specials_d",
		1
	},
	survival_magnus_wave_boss_a = {
		"survival_magnus_boss_a",
		1
	},
	survival_magnus_wave_boss_13 = {
		"survival_magnus_13_a",
		1
	},
	survival_magnus_nightmare_wave_easy_a = {
		"survival_magnus_nightmare_wave_easy_a_1",
		1,
		"survival_magnus_nightmare_wave_easy_a_2",
		1
	},
	survival_magnus_nightmare_wave_easy_b = {
		"survival_magnus_nightmare_wave_easy_b_1",
		1,
		"survival_magnus_nightmare_wave_easy_b_1",
		1
	},
	survival_magnus_nightmare_wave_specials_a = {
		"survival_magnus_nightmare_specials_a",
		1
	},
	survival_magnus_nightmare_wave_specials_b = {
		"survival_magnus_nightmare_specials_b",
		1
	},
	survival_magnus_nightmare_wave_specials_c = {
		"survival_magnus_nightmare_specials_c",
		1
	},
	survival_magnus_nightmare_wave_boss_a = {
		"survival_magnus_nightmare_boss_a",
		1
	},
	survival_magnus_nightmare_wave_boss_13 = {
		"survival_magnus_nightmare_13_a",
		1
	},
	survival_magnus_cataclysm_wave_a = {
		"survival_magnus_cataclysm_wave_bac",
		1
	},
	survival_magnus_cataclysm_wave_b = {
		"survival_magnus_cataclysm_wave_cad",
		1
	},
	survival_magnus_cataclysm_wave_c = {
		"survival_magnus_cataclysm_wave_dba",
		1
	},
	survival_magnus_cataclysm_wave_d = {
		"survival_magnus_cataclysm_wave_cdb",
		1
	},
	survival_magnus_cataclysm_wave_e = {
		"survival_magnus_cataclysm_wave_acd",
		1
	},
	survival_magnus_cataclysm_wave_f = {
		"survival_magnus_cataclysm_wave_dab",
		1
	},
	survival_magnus_cataclysm_wave_specials_a = {
		"survival_magnus_cataclysm_specials_a",
		1
	},
	survival_magnus_cataclysm_wave_specials_b = {
		"survival_magnus_cataclysm_specials_b",
		1
	},
	survival_magnus_cataclysm_wave_specials_c = {
		"survival_magnus_cataclysm_specials_c",
		1
	},
	survival_magnus_cataclysm_wave_specials_d = {
		"survival_magnus_cataclysm_specials_d",
		1
	},
	survival_magnus_cataclysm_wave_specials_e = {
		"survival_magnus_cataclysm_specials_e",
		1
	},
	survival_magnus_cataclysm_wave_specials_f = {
		"survival_magnus_cataclysm_specials_f",
		1
	},
	survival_magnus_cataclysm_wave_specials_g = {
		"survival_magnus_cataclysm_specials_g",
		1
	},
	survival_magnus_cataclysm_wave_specials_h = {
		"survival_magnus_cataclysm_specials_h",
		1
	},
	survival_magnus_cataclysm_wave_specials_i = {
		"survival_magnus_cataclysm_specials_i",
		1
	},
	survival_magnus_cataclysm_wave_boss_a = {
		"survival_magnus_cataclysm_boss_a",
		1,
		"survival_magnus_cataclysm_boss_b",
		1
	},
	survival_magnus_cataclysm_wave_boss_b = {
		"survival_magnus_cataclysm_boss_c",
		1,
		"survival_magnus_cataclysm_boss_d",
		1
	},
	survival_magnus_cataclysm_wave_boss_13_a = {
		"survival_magnus_cataclysm_13_a",
		1,
		"survival_magnus_cataclysm_13_b",
		1
	},
	survival_magnus_cataclysm_wave_boss_13_b = {
		"survival_magnus_cataclysm_13_c",
		1,
		"survival_magnus_cataclysm_13_d",
		1
	},
	survival_magnus_cataclysm_wave_boss_13_c = {
		"survival_magnus_cataclysm_13_e",
		1,
		"survival_magnus_cataclysm_13_f",
		1
	}
}
TerrorEventBlueprints = {
	generic_specials_fun_a = {
		{
			"spawn",
			{
				2,
				3
			},
			breed_name = "skaven_poison_wind_globadier"
		}
	},
	generic_specials_fun_b = {
		{
			"spawn",
			{
				1,
				2
			},
			breed_name = "skaven_ratling_gunner"
		}
	},
	roger_mayhem = {
		{
			"control_pacing",
			enable = false
		},
		{
			"text",
			text = "Event starts... can you beat it?",
			duration = 2
		},
		{
			"start_event",
			start_event_name = "lonely_roger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"horde",
			duration = 40,
			min_amount = 30,
			peak_amount = 50
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5
			end
		},
		{
			"delay",
			duration = {
				20,
				30
			}
		},
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 15
		},
		{
			"horde",
			duration = 40,
			min_amount = 30,
			peak_amount = 50
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5
			end
		},
		{
			"delay",
			duration = {
				20,
				30
			}
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"text",
			text = "You beat the event",
			duration = 2
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"stop_event",
			stop_event_name = "roger_mayhem"
		},
		{
			"text",
			text = "This will never be shown.. since we run 'stop_event' element above",
			duration = 2
		}
	},
	lonely_roger = {
		{
			"control_pacing",
			enable = false
		},
		{
			"text",
			text = "Lonely Roger wants to be friends!",
			duration = {
				2,
				3
			}
		},
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"text",
			text = "stops in 3 secs",
			duration = 3
		},
		{
			"stop_event",
			stop_event_name = "lonely_roger"
		},
		{
			"text",
			text = "XXXXXX Lonely Roger wants to be friends!",
			duration = {
				20,
				30
			}
		}
	},
	event_horde = {
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "",
			composition_type = "event_smaller"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "",
			composition_type = "event_smaller"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "",
			composition_type = "event_smaller"
		},
		{
			"control_pacing",
			enable = true
		}
	},
	steady_70_horde = {
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"debug_horde",
			duration = 3600,
			amount = 70
		},
		{
			"control_pacing",
			enable = true
		}
	},
	steady_60_horde = {
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"debug_horde",
			duration = 3600,
			amount = 60
		},
		{
			"control_pacing",
			enable = true
		}
	},
	steady_50_horde = {
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"debug_horde",
			duration = 3600,
			amount = 50
		},
		{
			"control_pacing",
			enable = true
		}
	},
	steady_40_horde = {
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"debug_horde",
			duration = 3600,
			amount = 40
		},
		{
			"control_pacing",
			enable = true
		}
	},
	force_horde = {
		{
			"force_horde",
			horde_type = "random",
			duration = 5
		}
	},
	test_raw_spawn = {
		{
			"control_specials",
			enable = false
		},
		{
			"spawn_at_raw",
			spawner_id = "roger",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 10
		},
		{
			"control_specials",
			enable = true
		}
	},
	magnus_gdc_event = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "magnus_gdc_event",
			composition_type = "event_large"
		}
	},
	magnus_door_a = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_a",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_large"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 4
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_c",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_c",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 9
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_c",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_c",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		}
	},
	magnus_door_b = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_a",
			composition_type = "event_large"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 4
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_c",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_c",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_c",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_b",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "magnus_door_event_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		}
	},
	magnus_end_horde = {
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "magnus_end_horde_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "magnus_end_horde_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 9
		},
		{
			"event_horde",
			spawner_id = "magnus_end_horde_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		}
	},
	magnus_door_event_stop = {
		{
			"stop_event",
			stop_event_name = "magnus_door_a"
		},
		{
			"stop_event",
			stop_event_name = "magnus_door_b"
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"control_specials",
			enable = true
		},
		{
			"disable_bots_in_carry_event"
		}
	},
	magnus_tower_tower_climb = {
		{
			"event_horde",
			spawner_id = "magnus_tower_tower_climb_spawners",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		}
	},
	magnus_end_event = {
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		},
		{
			"flow_event",
			flow_event_name = "magnus_horn_crescendo_starting"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "magnus_tower_horn_first",
			composition_type = "event_large"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_magnus_horn_smaller"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 10 and count_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_magnus_horn_small"
		},
		{
			"disable_kick"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 10 and count_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_magnus_horn_small"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 10 and count_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"control_specials",
			enable = true
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_medium"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_magnus_horn_small"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 7 and count_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_magnus_horn_small"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5 and count_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "magnus_tower_horn",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "magnus_tower_horn",
			composition_type = "event_magnus_horn_small"
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_slave") < 3
			end
		},
		{
			"flow_event",
			flow_event_name = "magnus_horn_event_done"
		},
		{
			"delay",
			duration = 5
		},
		{
			"control_pacing",
			enable = true
		}
	},
	magnus_disable_pacing = {
		{
			"control_pacing",
			enable = false
		}
	},
	bridge_event_horde_a = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"set_master_event_running",
			name = "bridge"
		},
		{
			"flow_event",
			flow_event_name = "crescendo_start"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "crescendo_pause"
		},
		{
			"delay",
			duration = 15
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 20
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"continue_when",
			duration = 120,
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 2
		},
		{
			"flow_event",
			flow_event_name = "crescendo_pause"
		},
		{
			"delay",
			duration = 12
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "crescendo_pause"
		},
		{
			"delay",
			duration = 20
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "crescendo_pause"
		},
		{
			"delay",
			duration = 16
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "crescendo_pause"
		},
		{
			"delay",
			duration = 18
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "crescendo_pause"
		},
		{
			"delay",
			duration = 23
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "bridge_event_a",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 20
		}
	},
	bridge_event_horde_b = {
		{
			"control_specials",
			enable = false
		}
	},
	bridge_event_horde_c = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "bridge_event_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 12
		},
		{
			"control_specials",
			enable = true
		}
	},
	bridge_event_horde_d = {
		{
			"control_pacing",
			enable = false
		},
		{
			"delay",
			duration = {
				4,
				5
			}
		},
		{
			"horde",
			duration = 20,
			min_amount = 12,
			peak_amount = 17
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 3
			end
		},
		{
			"delay",
			duration = {
				5,
				8
			}
		},
		{
			"spawn",
			{
				1,
				2
			},
			breed_name = "skaven_poison_wind_globadier"
		}
	},
	bridge_event_horde_e = {
		{
			"control_pacing",
			enable = false
		},
		{
			"delay",
			duration = {
				4,
				5
			}
		},
		{
			"horde",
			duration = 20,
			min_amount = 12,
			peak_amount = 17
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 3
			end
		},
		{
			"delay",
			duration = {
				5,
				8
			}
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		}
	},
	boss_event_rat_ogre = {
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		}
	},
	boss_event_storm_vermin_patrol = {
		{
			"spawn_patrol",
			breed_name = "skaven_storm_vermin",
			patrol_template = "storm_vermin_formation_patrol"
		}
	},
	rare_event_loot_rat = {
		{
			"spawn",
			breed_name = "skaven_loot_rat"
		}
	},
	tunnels_random_chance_event = {
		{
			"control_pacing",
			enable = false
		},
		{
			"delay",
			duration = {
				1,
				3
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "tunnels_random_chance_event",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				10,
				12
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_random_chance_event_done"
		}
	},
	skaven_end_event_start = {
		{
			"control_pacing",
			enable = false
		},
		{
			"delay",
			duration = {
				1,
				3
			}
		},
		{
			"event_horde",
			spawner_id = "tunnels_end_event_room",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				10,
				12
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "skaven_end_event_start_done"
		}
	},
	skaven_pillar = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "skaven_pillar",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "skaven_pillar_done"
		}
	},
	skaven_pillar_2 = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "skaven_pillar_2",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "skaven_pillar_2_done"
		}
	},
	random_skaven_end_event_medium = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "tunnels_end_event_room",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "random_skaven_end_event_done"
		}
	},
	random_skaven_end_event_small = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "tunnels_end_event_room",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "random_skaven_end_event_done"
		}
	},
	random_skaven_end_event_smaller = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "tunnels_end_event_room",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "random_skaven_end_event_done"
		}
	},
	tunnels_end_event_loop = {
		{
			"control_pacing",
			enable = false
		},
		{
			"set_master_event_running",
			name = "master_tunnels_end_event_loop"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "tunnels_end_event_room",
			composition_type = "event_generic_long_level_extra_spice"
		},
		{
			"delay",
			duration = 7
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "tunnels_end_event_room",
			composition_type = "event_smaller"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 15,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"delay",
			duration = 15
		},
		{
			"stop_master_event"
		},
		{
			"flow_event",
			flow_event_name = "tunnels_end_event_loop_restart"
		}
	},
	tunnels_end_room_stop_event = {
		{
			"stop_event",
			stop_event_name = "random_skaven_end_event_medium"
		},
		{
			"stop_event",
			stop_event_name = "random_skaven_end_event_small"
		},
		{
			"stop_event",
			stop_event_name = "random_skaven_end_event_smaller"
		},
		{
			"stop_event",
			stop_event_name = "skaven_pillar"
		},
		{
			"stop_event",
			stop_event_name = "skaven_end_event_start"
		},
		{
			"stop_event",
			stop_event_name = "tunnels_end_event_loop"
		}
	},
	tunnels_end_event_escape = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			spawner_id = "tunnels_end_event_escape",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_end_event_escape_done"
		}
	},
	tunnels_escape_tunnels_1 = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "escape_tunnels_1",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_end_event_escape_done"
		}
	},
	tunnels_escape_tunnels_2_left = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "escape_tunnels_2_left",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_end_event_escape_done"
		}
	},
	tunnels_escape_tunnels_2_right = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "escape_tunnels_2_right",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_end_event_escape_done"
		}
	},
	tunnels_escape_tunnels_end = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "escape_tunnels_end",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_end_event_escape_done"
		}
	},
	tunnels_end_event_escape_stop_event = {
		{
			"stop_event",
			stop_event_name = "tunnels_end_event_escape"
		},
		{
			"stop_event",
			stop_event_name = "tunnels_escape_tunnels_1"
		},
		{
			"stop_event",
			stop_event_name = "tunnels_escape_tunnels_2_left"
		},
		{
			"stop_event",
			stop_event_name = "tunnels_escape_tunnels_2_right"
		},
		{
			"stop_event",
			stop_event_name = "tunnels_escape_tunnels_end"
		}
	},
	tunnels_elevator_event_a = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "tunnels_elevator_event_a",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 12
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_elevator_event_done"
		}
	},
	tunnels_elevator_event_b = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "tunnels_elevator_event_b",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 12
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_elevator_event_done"
		}
	},
	tunnels_elevator_event_c = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "tunnels_elevator_event_c",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 12
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnels_elevator_event_done"
		}
	},
	tunnels_elevator_stop_event = {
		{
			"stop_event",
			stop_event_name = "tunnels_elevator_event_a"
		},
		{
			"stop_event",
			stop_event_name = "tunnels_elevator_event_b"
		},
		{
			"stop_event",
			stop_event_name = "tunnels_elevator_event_c"
		}
	},
	tunnels_pillar_guards = {
		{
			"spawn_at_raw",
			spawner_id = "bridge1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "bridge2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "bridge3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "bridge4",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"delay",
			duration = 5
		}
	},
	cemetery_plague_brew_event_1_a = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = {
				3,
				5
			}
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_smaller"
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_plague_brew_event_1_b = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = {
				3,
				5
			}
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_smaller"
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_plague_brew_event_2_a = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = {
				3,
				5
			}
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_smaller"
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_plague_brew_event_2_b = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = {
				3,
				5
			}
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_smaller"
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_plague_brew_event_3_a = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = {
				3,
				5
			}
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_smaller"
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_plague_brew_event_3_b = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = {
				3,
				5
			}
		},
		{
			"event_horde",
			composition_type = "event_magnus_horn_smaller"
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_plague_brew_event_4_a = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_plague_brew_event_4_b = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_alt_objective_1_v1 = {
		{
			"control_pacing",
			enable = false
		},
		{
			"text",
			text = "Prepare to fight the horde, v1...",
			duration = 3
		},
		{
			"delay",
			duration = 5
		},
		{
			"horde",
			min_amount = 15,
			peak_amount = 25,
			duration = {
				15,
				25
			}
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_alt_objective_1_v2 = {
		{
			"control_pacing",
			enable = false
		},
		{
			"text",
			text = "Prepare to fight the horde, v2...",
			duration = 3
		},
		{
			"delay",
			duration = 5
		},
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = {
				10,
				25
			}
		},
		{
			"horde",
			duration = 10,
			min_amount = 5,
			peak_amount = 10
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_alt_objective_2 = {
		{
			"control_pacing",
			enable = false
		},
		{
			"text",
			text = "Prepare to fight the horde...",
			duration = 3
		},
		{
			"delay",
			duration = 5
		},
		{
			"horde",
			duration = 20,
			min_amount = 15,
			peak_amount = 25
		},
		{
			"delay",
			duration = 20
		},
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"control_pacing",
			enable = true
		}
	},
	cemetery_alt_objective_3 = {
		{
			"control_pacing",
			enable = false
		},
		{
			"text",
			text = "Prepare to fight the horde...",
			duration = 3
		},
		{
			"delay",
			duration = 5
		},
		{
			"horde",
			duration = 20,
			min_amount = 15,
			peak_amount = 25
		},
		{
			"delay",
			duration = 20
		},
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "cemetery_alt_objective_3_end_event"
		}
	},
	cemetery_random_terror_event = {
		{
			"delay",
			duration = {
				5,
				40
			}
		},
		{
			"event_horde",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = {
				5,
				10
			}
		},
		{
			"event_horde",
			composition_type = "event_generic_short_level_extra_spice"
		}
	},
	courtyard_benchmark_clanrats = {
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 55
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_clanrat"
		},
		{
			"delay",
			duration = 5
		}
	},
	courtyard_benchmark_stormvermin = {
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_a",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin_b",
			composition_type = "benchmark_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 8
			end
		}
	},
	courtyard_specials_off = {
		{
			"control_specials",
			enable = false
		},
		{
			"delay",
			duration = 40
		},
		{
			"control_specials",
			enable = true
		}
	},
	event_courtyard_extra_spice = {
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		}
	},
	courtyard_rolling_event = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "courtyard"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "c_wave_01"
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_starting"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_pause"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"flow_event",
			flow_event_name = "courtyard_objective_a"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "courtyard_b",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "courtyard_b_ambush",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_slave") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "courtyard_c",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "courtyard_b_ambush",
			composition_type = "event_small"
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_midway_specials"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "courtyard_objective_a_end"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 1
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_pause"
		},
		{
			"delay",
			duration = 15
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_midway_specials"
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"flow_event",
			flow_event_name = "courtyard_objective_b"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "courtyard_a",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "courtyard_b_ambush",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_slave") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "courtyard_a",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "courtyard_b_ambush",
			composition_type = "event_small"
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_midway_specials"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "courtyard_objective_b_end"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_pause"
		},
		{
			"delay",
			duration = 15
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"flow_event",
			flow_event_name = "courtyard_objective_a"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "courtyard_b",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "courtyard_a_ambush",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_slave") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "courtyard_c",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "courtyard_a_ambush",
			composition_type = "event_small"
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_midway_specials"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "courtyard_objective_a_end"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_pause"
		},
		{
			"delay",
			duration = 15
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 1
			end
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			duration = 120,
			condition = function (t)
				return count_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"disable_kick"
		},
		{
			"delay",
			duration = 7
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_close_to_ending"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_big_spice"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"flow_event",
			flow_event_name = "courtyard_objective_b"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "courtyard_a",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "courtyard_b_ambush",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_slave") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "courtyard_a",
			composition_type = "event_large"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "courtyard_b_ambush",
			composition_type = "event_small"
		},
		{
			"flow_event",
			flow_event_name = "courtyard_crescendo_midway_specials"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "courtyard_objective_b_end"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "courtyard_vermin",
			composition_type = "event_courtyard_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"flow_event",
			flow_event_name = "courtyard_end"
		},
		{
			"stop_master_event"
		}
	},
	docks_warehouse_event = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "docks_warehouse"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "docks_warehouse_event",
			composition_type = "event_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = {
				10,
				12
			}
		},
		{
			"event_horde",
			spawner_id = "docks_warehouse_event",
			composition_type = "event_docks_warehouse_extra_spice"
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "docks_warehouse_end"
		}
	},
	docks_warehouse_extra_spice_event = {
		{
			"set_master_event_running",
			name = "docks_warehouse"
		},
		{
			"event_horde",
			spawner_id = "docks_warehouse_event",
			composition_type = "event_docks_warehouse_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "docks_warehouse_extra_spice_event_done"
		}
	},
	docks_warehouse_end_event = {
		{
			"set_master_event_running",
			name = "docks_warehouse"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "docks_warehouse_event_end",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = {
				10,
				12
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"disable_bots_in_carry_event"
		},
		{
			"flow_event",
			flow_event_name = "docks_warehouse_end"
		}
	},
	docks_warehouse_stop_event = {
		{
			"stop_event",
			stop_event_name = "docks_warehouse_event"
		},
		{
			"stop_event",
			stop_event_name = "docks_warehouse_extra_spice_event"
		}
	},
	docks_warehouse_stop_end_event = {
		{
			"stop_event",
			stop_event_name = "docks_warehouse_end_event"
		},
		{
			"stop_master_event"
		}
	},
	docks_shipyard_event = {
		{
			"set_master_event_running",
			name = "docks_shipyard"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "docks_shipyard_event",
			composition_type = "event_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = {
				10,
				12
			}
		},
		{
			"event_horde",
			spawner_id = "docks_warehouse_event",
			composition_type = "event_docks_warehouse_extra_spice"
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "docks_shipyard_end"
		}
	},
	docks_shipyard_extra_spice_event = {
		{
			"set_master_event_running",
			name = "docks_shipyard"
		},
		{
			"event_horde",
			spawner_id = "docks_shipyard_event",
			composition_type = "event_docks_warehouse_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "docks_shipyard_extra_spice_event_done"
		}
	},
	docks_shipyard_stop_event = {
		{
			"stop_event",
			stop_event_name = "docks_shipyard_event"
		},
		{
			"stop_event",
			stop_event_name = "docks_shipyard_extra_spice_event"
		},
		{
			"stop_master_event"
		}
	},
	docks_extra_spice_event = {
		{
			"event_horde",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"flow_event",
			flow_event_name = "docks_extra_spice_event_done"
		}
	},
	docks_end_event = {
		{
			"set_master_event_running",
			name = "docks_ending"
		},
		{
			"disable_kick"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			composition_type = "event_small"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 6
			end
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "docks_end_event_done"
		}
	},
	docks_end_ogre_event = {
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			duration = 120,
			condition = function (t)
				return count_breed("skaven_rat_ogre") < 1 and count_breed("skaven_slave") < 8
			end
		},
		{
			"delay",
			duration = {
				10,
				12
			}
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "docks_end_event_done"
		}
	},
	city_wall_running_event = {
		{
			"set_master_event_running",
			name = "wall"
		},
		{
			"delay",
			duration = {
				10,
				17
			}
		},
		{
			"event_horde",
			spawner_id = "city_wall_generic",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "city_wall_rolling_event_restart"
		}
	},
	city_wall_a = {
		{
			"set_master_event_running",
			name = "wall"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "city_wall_a",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "city_wall_b",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5 and count_breed("skaven_storm_vermin_commander") < 2
			end
		}
	},
	city_wall_b = {
		{
			"set_master_event_running",
			name = "wall"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "city_wall_b",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "city_wall_c",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5 and count_breed("skaven_storm_vermin_commander") < 2
			end
		}
	},
	city_wall_c = {
		{
			"set_master_event_running",
			name = "wall"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			spawner_id = "city_wall_c",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "city_wall_d",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5 and count_breed("skaven_storm_vermin_commander") < 2
			end
		}
	},
	city_wall_d = {
		{
			"set_master_event_running",
			name = "wall"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			spawner_id = "city_wall_d",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "city_wall_b",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 5 and count_breed("skaven_storm_vermin_commander") < 2
			end
		}
	},
	city_wall_end = {
		{
			"control_pacing",
			enable = false
		},
		{
			"delay",
			duration = 20
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			spawner_id = "city_wall_end",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "city_wall_b",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = 20
		},
		{
			"stop_master_event"
		},
		{
			"control_pacing",
			enable = true
		}
	},
	walls_gate_guards_a = {
		{
			"spawn_at_raw",
			spawner_id = "gateguard_a_1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_a_2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_a_3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_a_4",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_a_5",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_a_6",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"delay",
			duration = 5
		}
	},
	walls_gate_guards_b = {
		{
			"spawn_at_raw",
			spawner_id = "gateguard_b_1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_b_2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_b_3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_b_4",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_b_5",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "gateguard_b_6",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"delay",
			duration = 5
		}
	},
	walls_attachment_guards = {
		{
			"spawn_at_raw",
			spawner_id = "attachment_guard_a_1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "attachment_guard_a_2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "attachment_guard_b_1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "attachment_guard_b_2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "attachment_guard_c_1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "attachment_guard_c_2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "attachment_guard_d_1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "attachment_guard_d_2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"delay",
			duration = 5
		}
	},
	open_door = {
		{
			"control_pacing",
			enable = false
		},
		{
			"set_master_event_running",
			name = "wizard_open_door"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "object_set_room_spawners",
			composition_type = "wizard_event_small_hard"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 70,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "object_set_room_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 70,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "object_set_room_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"delay",
			duration = 4
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "object_set_room_spawners",
			composition_type = "event_smaller"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 70,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 6
		},
		{
			"event_horde",
			spawner_id = "object_set_room_spawners",
			composition_type = "event_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 4
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "object_set_room_spawners",
			composition_type = "event_smaller"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 70,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 2
			end
		},
		{
			"stop_master_event"
		},
		{
			"control_pacing",
			enable = true
		}
	},
	garden_mayhem = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "chaos_room_spawners",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 10,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "chaos_room_spawners",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 10,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "garden_done"
		},
		{
			"control_pacing",
			enable = true
		}
	},
	endroom_mayhem = {
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = true
		},
		{
			"event_horde",
			spawner_id = "endroom_spawners",
			composition_type = "event_small"
		},
		{
			"delay",
			duration = 20
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 3 and count_breed("skaven_slave") < 3
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			spawner_id = "endroom_spawners",
			composition_type = "event_small"
		},
		{
			"delay",
			duration = 20
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 20
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "endroom_spawners",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wizard_endroom_done"
		}
	},
	wizard_disable_pacing = {
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		}
	},
	wizard_end_event = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		},
		{
			"delay",
			duration = 5
		},
		{
			"set_master_event_running",
			name = "wizard_finale"
		},
		{
			"flow_event",
			flow_event_name = "wizard_crescendo_starting"
		},
		{
			"disable_kick"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners_side",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_small_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 2
		},
		{
			"flow_event",
			flow_event_name = "wizard_end_event_pause_a"
		},
		{
			"delay",
			duration = 5
		},
		{
			"control_specials",
			enable = true
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_small_hard"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners_side",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "wizard_alt_objectives"
		},
		{
			"delay",
			duration = 7
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "endroom_spawners",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 7
		},
		{
			"flow_event",
			flow_event_name = "wizard_end_event_pause_b"
		},
		{
			"delay",
			duration = 10
		},
		{
			"delay",
			duration = 5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "endroom_spawners_side",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"event_horde",
			spawner_id = "endroom_spawners",
			composition_type = "event_small"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_small_hard"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"spawn",
			{
				2,
				4
			},
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 7
		},
		{
			"flow_event",
			flow_event_name = "wizard_end_event_pause_c"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners_side",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "endroom_spawners_side",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "endroom_spawners_side",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"event_horde",
			spawner_id = "endroom_spawners",
			composition_type = "wizard_event_smaller_hard"
		},
		{
			"delay",
			duration = 7
		},
		{
			"continue_when",
			duration = 120,
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 7
		},
		{
			"flow_event",
			flow_event_name = "wizard_end_event_done"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_bots_in_carry_event"
		},
		{
			"stop_master_event"
		}
	},
	sewers_alt_door_event_01 = {
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "sewers_alt_door_01",
			composition_type = "event_medium"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "sewers_alt_door_01",
			composition_type = "sewers_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "sewers_event_smaller_hard"
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "sewers_event_small_hard"
		},
		{
			"delay",
			duration = 4
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "sewers_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "sewers_event_small_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "sewers_event_small_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"control_pacing",
			enable = true
		}
	},
	sewers_alt_door_event_01_stopped = {
		{
			"control_pacing",
			enable = true
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "sewers_alt_door_event_01_vo"
		}
	},
	sewers_alt_door_event_02 = {
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "sewers_alt_door_02",
			composition_type = "event_small"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "sewers_alt_door_02",
			composition_type = "sewers_event_small_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "sewers_event_small_hard"
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "sewers_event_smaller_hard"
		},
		{
			"delay",
			duration = 4
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "sewers_event_smaller_hard"
		}
	},
	sewers_end_event = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "sewers_end_event_a",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "sewers_alt_door_02",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 12 and count_breed("skaven_slave") < 8
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "event_smaller"
		},
		{
			"delay",
			duration = 4
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 12 and count_breed("skaven_slave") < 8
			end
		},
		{
			"event_horde",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 12 and count_breed("skaven_slave") < 8
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "event_smaller"
		},
		{
			"delay",
			duration = 4
		},
		{
			"control_pacing",
			enable = true
		}
	},
	farm_event_larger = {
		{
			"set_master_event_running",
			name = "farm"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin_larger",
			composition_type = "medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		}
	},
	farm_event_larger_vermin = {
		{
			"set_master_event_running",
			name = "farm"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin_larger",
			composition_type = "event_generic_short_level_stormvermin"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		}
	},
	farm_event_larger_second = {
		{
			"set_master_event_running",
			name = "farm"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "farm_vermin_larger_second",
			composition_type = "medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		}
	},
	farm_event_larger_second_vermin = {
		{
			"set_master_event_running",
			name = "farm"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "farm_vermin_larger_second",
			composition_type = "event_generic_short_level_stormvermin"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		}
	},
	farm_event_larger_third = {
		{
			"set_master_event_running",
			name = "farm"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "farm_vermin_larger_third",
			composition_type = "medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		}
	},
	farm_event_larger_third_vermin = {
		{
			"set_master_event_running",
			name = "farm"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "farm_vermin_larger_third",
			composition_type = "event_generic_short_level_stormvermin"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		}
	},
	farm_event_ogre = {
		{
			"set_master_event_running",
			name = "farm"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		},
		{
			"disable_kick"
		},
		{
			"delay",
			duration = {
				5,
				40
			}
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			duration = 160,
			condition = function (t)
				return count_breed("skaven_rat_ogre") < 1 and count_breed("skaven_slave") < 12
			end
		},
		{
			"control_specials",
			enable = true
		}
	},
	farm_event = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "farm"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			duration = 100,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 25
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"disable_kick"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 100,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 25
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 100,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			duration = 100,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 25
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 25
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 25
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 25
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = 25
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 12 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "farm_vermin",
			composition_type = "event_farm_extra_big_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "farm_event_ended"
		}
	},
	forest_end_event_start = {
		{
			"control_pacing",
			enable = false
		},
		{
			"flow_event",
			flow_event_name = "forest_end_event_start_debug"
		},
		{
			"disable_kick"
		}
	},
	forest_end_event_a = {
		{
			"set_master_event_running",
			name = "forest_finale"
		},
		{
			"disable_kick"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "forest_end_event",
			composition_type = "event_small"
		},
		{
			"delay",
			duration = {
				15,
				17
			}
		},
		{
			"event_horde",
			spawner_id = "forest_end_event",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "forest_end_event_restart"
		}
	},
	forest_end_event_b = {
		{
			"set_master_event_running",
			name = "forest_finale"
		},
		{
			"disable_kick"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "forest_end_event",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"event_horde",
			spawner_id = "forest_end_event",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "forest_end_event_restart"
		}
	},
	forest_end_event_c = {
		{
			"set_master_event_running",
			name = "forest_finale"
		},
		{
			"disable_kick"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "forest_end_event",
			composition_type = "event_large"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "forest_end_event_restart"
		}
	},
	forest_end_finale = {
		{
			"set_master_event_running",
			name = "forest_finale"
		},
		{
			"disable_kick"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "forest_end_event_finale",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "forest_end_event_finale",
			composition_type = "event_large"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "forest_end_event_restart"
		}
	},
	forest_end_event_loop = {
		{
			"set_master_event_running",
			name = "forest_finale"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "forest_end_event",
			composition_type = "event_generic_long_level_extra_spice"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "forest_end_event_loop_restart"
		}
	},
	forest_end_cutscene = {
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "forest_cutscene_a",
			composition_type = "event_smaller"
		}
	},
	forest_skaven_camp_loop = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "forest_camp"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "skaven_camp_loop",
			composition_type = "event_generic_long_level_extra_spice"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "forest_skaven_camp_loop_restart"
		}
	},
	forest_skaven_camp_a = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "forest_camp"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "forest_skaven_camp",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"event_horde",
			spawner_id = "forest_skaven_camp",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "forest_skaven_camp_a_done"
		}
	},
	forest_skaven_camp_b = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "forest_camp"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "forest_skaven_camp",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "forest_skaven_camp_b_done"
		}
	},
	forest_skaven_camp_c = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "forest_camp"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "forest_skaven_camp",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"event_horde",
			spawner_id = "forest_skaven_camp",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "forest_skaven_camp_c_done"
		}
	},
	forest_skaven_camp_finale = {
		{
			"set_master_event_running",
			name = "forest_camp"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "forest_door_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			spawner_id = "forest_skaven_camp",
			composition_type = "event_smaller"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 4
			end
		},
		{
			"stop_master_event"
		},
		{
			"flow_event",
			flow_event_name = "forest_skaven_camp_finale_done"
		},
		{
			"disable_bots_in_carry_event"
		},
		{
			"control_pacing",
			enable = true
		}
	},
	merchant_alley_ambush = {
		{
			"delay",
			duration = {
				1,
				2
			}
		},
		{
			"event_horde",
			limit_spawners = 8,
			spawner_id = "merchant_alley_ambush",
			composition_type = "event_merchant_ambush"
		}
	},
	merchant_granary_ambush = {
		{
			"delay",
			duration = {
				1,
				3
			}
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "merchant_granary_ambush",
			composition_type = "event_merchant_ambush"
		}
	},
	merchant_market_event_a = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"disable_kick"
		},
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 3
			end
		},
		{
			"delay",
			duration = {
				20,
				24
			}
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_restart"
		}
	},
	merchant_market_event_b = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"disable_kick"
		},
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 3
			end
		},
		{
			"delay",
			duration = {
				20,
				23
			}
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_restart"
		}
	},
	merchant_market_event_c = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"disable_kick"
		},
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_smaller"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 3
			end
		},
		{
			"delay",
			duration = {
				22,
				23
			}
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 3
			end
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_restart"
		}
	},
	merchant_market_event_hard_a = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"disable_kick"
		},
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			duration = 180,
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = {
				22,
				30
			}
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_post_pause_start"
		}
	},
	merchant_market_event_hard_b = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"disable_kick"
		},
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_generic_long_level_stormvermin"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = {
				13,
				17
			}
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_post_pause_start"
		}
	},
	merchant_market_event_hard_c = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"disable_kick"
		},
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 7
			end
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				13,
				16
			}
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_post_pause_start"
		}
	},
	merchant_market_event_hard_d = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"disable_kick"
		},
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"spawn",
			{
				6,
				8
			},
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") < 2
			end
		},
		{
			"delay",
			duration = {
				14,
				18
			}
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_post_pause_start"
		}
	},
	merchant_market_event_pre_pause = {
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "crescendo_pause"
		},
		{
			"delay",
			duration = 22
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_hard_start"
		}
	},
	merchant_market_event_post_pause = {
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "crescendo_pause"
		},
		{
			"delay",
			duration = 20
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_restart"
		}
	},
	merchant_market_event_finale = {
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"disable_kick"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 120,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_finale_restart"
		}
	},
	merchant_market_event_loop = {
		{
			"set_master_event_running",
			name = "merchant_event"
		},
		{
			"disable_kick"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "market_event",
			composition_type = "event_generic_long_level_extra_spice"
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "merchant_market_event_loop_restart"
		}
	},
	merchant_market_stop_event = {
		{
			"stop_event",
			stop_event_name = "merchant_market_event_a"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_b"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_c"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_hard_a"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_hard_b"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_hard_c"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_pre_pause"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_post_pause"
		}
	},
	merchant_market_stop_chunk_event = {
		{
			"stop_event",
			stop_event_name = "merchant_market_event_a"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_b"
		},
		{
			"stop_event",
			stop_event_name = "merchant_market_event_c"
		},
		{
			"text",
			text = "events stopped!",
			duration = 2
		}
	},
	end_boss_terror_a = {
		{
			"set_master_event_running",
			name = "end_boss"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "end_boss_spawners_a",
			composition_type = "end_boss_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "end_boss_spawners_a",
			composition_type = "end_boss_event_small_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "end_boss_spawners_a",
			composition_type = "end_boss_event_smaller_hard"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		}
	},
	end_boss_guards = {
		{
			"spawn_at_raw",
			spawner_id = "guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "guard3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "guard4",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"delay",
			duration = 5
		}
	},
	end_boss_terror_b = {
		{
			"enable_bots_in_carry_event"
		},
		{
			"disable_kick"
		},
		{
			"set_master_event_running",
			name = "end_boss"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "end_boss_spawners_b",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 10,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		}
	},
	end_boss_terror_c1 = {
		{
			"disable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "end_boss"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "end_boss_spawners_c_1",
			composition_type = "event_large"
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"control_specials",
			enable = false
		},
		{
			"delay",
			duration = 6
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_ogre1",
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			duration = 120,
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"control_specials",
			enable = true
		}
	},
	end_boss_terror_c2 = {
		{
			"disable_bots_in_carry_event"
		},
		{
			"set_master_event_running",
			name = "end_boss"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "end_boss_spawners_c_1",
			composition_type = "event_large"
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"control_specials",
			enable = false
		},
		{
			"delay",
			duration = 6
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_ogre2",
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			duration = 120,
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"control_specials",
			enable = true
		}
	},
	end_boss_bell_a = {
		{
			"set_master_event_running",
			name = "end_boss"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "end_boss_spawners_a",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 20
		},
		{
			"flow_event",
			flow_event_name = "end_boss_bell_a_restart"
		}
	},
	end_boss_bell_a_gate = {
		{
			"set_master_event_running",
			name = "end_boss"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "end_boss_spawners_a",
			composition_type = "end_boss_event_stormvermin"
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 1
			end
		},
		{
			"delay",
			duration = 20
		}
	},
	end_boss_bell_b = {
		{
			"set_master_event_running",
			name = "end_boss"
		},
		{
			"disable_kick"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "end_boss_spawners_b",
			composition_type = "event_medium"
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"flow_event",
			flow_event_name = "end_boss_bell_b_restart"
		}
	},
	end_boss_bell_c = {
		{
			"set_master_event_running",
			name = "end_boss"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "end_boss_spawners_c",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 40,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "end_boss_spawners_c",
			composition_type = "end_boss_event_rolling"
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 1
			end
		},
		{
			"delay",
			duration = 15
		},
		{
			"flow_event",
			flow_event_name = "end_boss_bell_c_restart"
		}
	},
	end_boss_bell_done = {
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		}
	},
	castle_inner_sanctum_extra_spice_loop = {
		{
			"set_master_event_running",
			name = "inner_sanctum"
		},
		{
			"event_horde",
			spawner_id = "inner_sanctum",
			composition_type = "event_generic_long_level_extra_spice"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = {
				10,
				12
			}
		},
		{
			"flow_event",
			flow_event_name = "castle_inner_sanctum_extra_spice_loop_restart"
		}
	},
	castle_inner_sanctum_stop_pacing = {
		{
			"control_pacing",
			enable = false
		},
		{
			"enable_bots_in_carry_event"
		}
	},
	castle_inner_sanctum_event_loop = {
		{
			"set_master_event_running",
			name = "inner_sanctum"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "inner_sanctum",
			composition_type = "event_smaller"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = {
				8,
				10
			}
		},
		{
			"flow_event",
			flow_event_name = "castle_inner_sanctum_event_loop_restart"
		}
	},
	castle_inner_sanctum_stop_event = {
		{
			"stop_event",
			stop_event_name = "castle_inner_sanctum_event_loop"
		},
		{
			"stop_event",
			stop_event_name = "castle_inner_sanctum_extra_spice_loop"
		},
		{
			"disable_bots_in_carry_event"
		}
	},
	castle_catacombs_end_event_start = {
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"disable_kick"
		}
	},
	castle_catacombs_end_event_loop = {
		{
			"set_master_event_running",
			name = "escape_catacombs"
		},
		{
			"event_horde",
			limit_spawners = 4,
			spawner_id = "escape_catacombs",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "castle_catacombs_end_event_loop_done"
		}
	},
	castle_catacombs_end_event_loop_extra_spice = {
		{
			"set_master_event_running",
			name = "escape_catacombs"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "end_event_escape_spice",
			composition_type = "event_generic_long_level_extra_spice"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "castle_catacombs_end_event_loop_extra_spice_done"
		}
	},
	end_event_statuette_guards_01 = {
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard3",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	end_event_statuette_guards_02 = {
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard3",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	end_event_statuette_guards_03 = {
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard3",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	end_event_statuette_guards_04 = {
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette1_guard3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette2_guard3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard2",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "end_event_statuette3_guard3",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	castle_inner_sanctum_statuette_extra = {
		{
			"set_master_event_running",
			name = "inner_sanctum"
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "inner_sanctum",
			composition_type = "event_smaller"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "castle_inner_sanctum_statuette_extra_done"
		}
	},
	whitebox_combat_event_a = {
		{
			"control_pacing",
			enable = false
		},
		{
			"text",
			text = "Spawning horde",
			duration = 2
		},
		{
			"horde",
			duration = 20,
			min_amount = 15,
			peak_amount = 20
		},
		{
			"delay",
			duration = {
				5,
				7
			}
		},
		{
			"text",
			text = "Spawning Pack Master",
			duration = 2
		},
		{
			"spawn",
			{
				1,
				2
			},
			breed_name = "skaven_pack_master"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8
			end
		},
		{
			"text",
			text = "Spawning Rat Ogre",
			duration = 2
		},
		{
			"spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"horde",
			duration = 20,
			min_amount = 10,
			peak_amount = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_rat_ogre") == 0
			end
		},
		{
			"delay",
			duration = {
				10,
				15
			}
		},
		{
			"text",
			text = "Wave 2 incoming",
			duration = 2
		},
		{
			"horde",
			duration = 30,
			min_amount = 20,
			peak_amount = 25
		},
		{
			"text",
			text = "Spawning Globadier",
			duration = 2
		},
		{
			"spawn",
			{
				1,
				2
			},
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8
			end
		},
		{
			"delay",
			duration = {
				5,
				10
			}
		},
		{
			"text",
			text = "Wave 3 incoming",
			duration = 2
		},
		{
			"text",
			text = "Spawning Gutter Runner",
			duration = 2
		},
		{
			"spawn",
			{
				1,
				2
			},
			breed_name = "skaven_gutter_runner"
		},
		{
			"horde",
			duration = 40,
			min_amount = 15,
			peak_amount = 20
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8
			end
		},
		{
			"text",
			text = "Event done",
			duration = 2
		},
		{
			"control_pacing",
			enable = true
		}
	},
	outpost_disable_pacing_a = {
		{
			"control_pacing",
			enable = false
		}
	},
	outpost_wave_event_climb_01 = {
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_medium"
		}
	},
	outpost_wave_01_a = {
		{
			"control_pacing",
			enable = false
		},
		{
			"text",
			text = "Hold out as long as possible!",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_storm_band"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_tower",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_tower",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_b",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_b",
			composition_type = "event_large"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_c",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_c",
			composition_type = "event_large"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_large"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 90,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_large"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_tower",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_tower",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_f",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_f",
			composition_type = "event_survival_high_intensity"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_survival_high_intensity"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_small"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_survival_high_intensity"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_horde"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_large"
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_tower",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_small"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_storm_band"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_b",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_b",
			composition_type = "event_survival_high_intensity"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_storm_band"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2 and count_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_f",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_f",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_f",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_medium_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_horde"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_f",
			composition_type = "event_large"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_f",
			composition_type = "event_survival_storm_band"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_tower",
			composition_type = "event_survival_high_intensity"
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_d",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_climb",
			composition_type = "event_medium"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_storm_band"
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "wait_for_next_horde"
		},
		{
			"delay",
			duration = 15
		},
		{
			"delay",
			duration = 30
		},
		{
			"text",
			text = "last stand",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "last_stand_start"
		}
	},
	outpost_death_wave_01 = {
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_tower",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_tower",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_storm_band"
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_medium"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_storm_horde"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_small"
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_horde"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_horde"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_f",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"flow_event",
			flow_event_name = "specials"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_band"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 11
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_b",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_survival_high_intensity"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_e",
			composition_type = "event_survival_storm_band"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_b",
			composition_type = "event_survival_storm_band"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_horde"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_survival_storm_horde"
		},
		{
			"event_horde",
			spawner_id = "outpost_wave_event_a",
			composition_type = "event_large"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 80,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"flow_event",
			flow_event_name = "last_stand_start"
		}
	},
	outpost_extra_spice_01 = {
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "outpost_wave_event_omni",
			composition_type = "event_courtyard_extra_spice"
		}
	},
	performance_test_1 = {
		{
			"event_horde",
			spawner_id = "performancetester",
			composition_type = "performance_test"
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_ratling_gunner"
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 2
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		}
	},
	ai_benchmark_cycle = {
		{
			"control_pacing",
			enable = false
		},
		{
			"control_specials",
			enable = false
		},
		{
			"text",
			text = "Turned off pacing and specials",
			duration = 5
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 20 slaves (wait max 60 sec until continue)",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "ai_benchmark_cycle_slaves"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_breed("skaven_slave") < 1
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 10 clanrats (wait max 60 sec until continue)",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "ai_benchmark_cycle_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_breed("skaven_clan_rat") < 1
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 4 storm vermin (wait max 60 sec until continue)",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			composition_type = "ai_benchmark_cycle_stormvermin"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 1
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 1 globadier",
			duration = 3
		},
		{
			"spawn",
			{
				1,
				1
			},
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 1 ratling gunner",
			duration = 3
		},
		{
			"spawn",
			{
				1,
				1
			},
			breed_name = "skaven_ratling_gunner"
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 1 gutter runner",
			duration = 3
		},
		{
			"spawn",
			{
				1,
				1
			},
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 1 pack master (wait max 60 sec until continue)",
			duration = 5
		},
		{
			"spawn",
			{
				1,
				1
			},
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_breed("skaven_poison_wind_globadier") < 1 and count_breed("skaven_ratling_gunner") < 1 and count_breed("skaven_gutter_runner") < 1 and count_breed("skaven_pack_master") < 1
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 1 rat ogre (wait max 120 sec until continue)",
			duration = 5
		},
		{
			"spawn",
			{
				1
			},
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 120,
			condition = function (t)
				return count_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"text",
			text = "Spawning 10 clanrats 100 m away (wait max 60 sec until continue)",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 2,
			spawner_id = "spawner_100m_away",
			composition_type = "ai_benchmark_cycle_clanrat"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_breed("skaven_storm_vermin_commander") < 1
			end
		},
		{
			"text",
			text = "Restarting",
			duration = 5
		},
		{
			"flow_event",
			flow_event_name = "ai_benchmark_cycle_restart"
		}
	},
	pathfind_test_climb = {
		{
			"event_horde",
			spawner_id = "pathfind_test_climb",
			composition_type = "pathfind_test_light"
		}
	},
	pathfind_test_straight = {
		{
			"event_horde",
			spawner_id = "pathfind_test_straight",
			composition_type = "pathfind_test_light"
		}
	},
	survival_control = {
		{
			"control_specials",
			enable = false
		},
		{
			"control_pacing",
			enable = false
		}
	},
	survival_wave_abd = {
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"control_specials",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"flow_event",
			flow_event_name = "survival_direction_west"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"flow_event",
			flow_event_name = "survival_direction_north"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"flow_event",
			flow_event_name = "survival_direction_east"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"flow_event",
			flow_event_name = "survival_direction_south"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_wave_bac = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 25
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 25
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_pack"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 10 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_wave_cad = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 10 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_wave_dba = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_wave_cdb = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_wave_acd = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_wave_dab = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_slave") < 10
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_slave") < 10
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_wave_easy_a_1 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_wave_easy_b_1 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 4 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_wave_easy_a_2 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_wave_easy_b_2 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 4 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_flush_in = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_flush_out = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_esr2_a = {
		{
			"delay",
			duration = {
				10,
				20
			}
		},
		{
			"event_horde",
			composition_type = "event_survival_extra"
		}
	},
	survival_esr3_a = {
		{
			"delay",
			duration = {
				10,
				20
			}
		},
		{
			"event_horde",
			composition_type = "event_survival_extra"
		}
	},
	survival_specials_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_pinch"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_specials_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_pinch"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_specials_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_pinch"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_specials_d = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_pinch"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_boss_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_13_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_wave_intro = {
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"control_specials",
			enable = false
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "survival_direction_east"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "survival_direction_south"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "survival_direction_west"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 4
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"flow_event",
			flow_event_name = "survival_direction_north"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_wave_bac = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 25
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 25
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_pack"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 10 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_wave_cad = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 10 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_wave_dba = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_wave_cdb = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_wave_acd = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_wave_dab = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_slave") < 10
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_slave") < 10
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_wave_easy_a_1 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_flank"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_wave_easy_b_1 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 4 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_wave_easy_a_2 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_flank"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_wave_easy_b_2 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 4 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_main"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_flush_in = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_flush_out = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_esr2_a = {
		{
			"delay",
			duration = {
				10,
				20
			}
		},
		{
			"event_horde",
			composition_type = "event_survival_extra"
		}
	},
	survival_magnus_esr3_a = {
		{
			"delay",
			duration = {
				10,
				20
			}
		},
		{
			"event_horde",
			composition_type = "event_survival_extra"
		}
	},
	survival_magnus_specials_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_pinch"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_specials_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_pinch"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_specials_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_pinch"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_specials_d = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_pinch"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_boss_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_13_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_wave_easy_a_1 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_wave_easy_b_1 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 4 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_wave_easy_a_2 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_wave_easy_b_2 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 4 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_specials_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"delay",
			duration = 1
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_specials_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 1
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_specials_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 1
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_boss_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"delay",
			duration = 5
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_ratling_gunner") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_nightmare_13_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2 and count_event_breed("skaven_poison_wind_globadier") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_wave_easy_a_1 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_wave_easy_b_1 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 4 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_wave_easy_a_2 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_wave_easy_b_2 = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 4 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_specials_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"delay",
			duration = 1
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_specials_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 1
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_specials_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 1
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_boss_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"delay",
			duration = 5
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_ratling_gunner") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_nightmare_13_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 2
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2 and count_event_breed("skaven_poison_wind_globadier") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_wave_bac = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 25
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 25
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 10 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_cataclysm_wave_cad = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 10 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_cataclysm_wave_dba = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_cataclysm_wave_cdb = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_cataclysm_wave_acd = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_magnus_cataclysm_wave_dab = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				70,
				30,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_slave") < 10
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				85,
				-12,
				15
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-45,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_slave") < 10
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				14,
				24,
				15
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_cataclysm_wave_bac = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 25
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 25
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 10 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_pack"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_cataclysm_wave_cad = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 10 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 15
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 3
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_cataclysm_wave_dba = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_cataclysm_wave_cdb = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_cataclysm_wave_acd = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_cataclysm_wave_dab = {
		{
			"control_specials",
			enable = true
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				20,
				50,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_slave") < 10
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				90,
				0,
				18
			}
		},
		{
			"delay",
			duration = 0.5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				25,
				-55,
				25
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_pack"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 20 and count_event_breed("skaven_slave") < 10
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger",
			optional_pos = {
				-20,
				-5,
				20
			}
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		},
		{
			"control_specials",
			enable = false
		}
	},
	survival_cataclysm_specials_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_specials_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_specials_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_specials_d = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 1
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_gutter_runner") < 2 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_specials_e = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_specials_f = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_specials_g = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_specials_h = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_specials_i = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_boss_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_boss_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 2
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_boss_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_boss_d = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 2
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_13_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_13_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2 and count_event_breed("skaven_pack_master") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_13_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_13_d = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_gutter_runner"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_gutter_runner") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_13_e = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_cataclysm_13_f = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_gutter_runner") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_d",
			breed_name = "skaven_pack_master"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_d = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_gutter_runner"
		},
		{
			"delay",
			duration = 1
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_gutter_runner") < 2 and count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_flush"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_e = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_a",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_f = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_poison_wind_globadier"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_g = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_ratling_gunner"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_h = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_gutter_runner"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_specials_i = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_slaves_large"
		},
		{
			"delay",
			duration = {
				12,
				18
			}
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"spawn",
			1,
			breed_name = "skaven_pack_master"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = {
				20,
				25
			}
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_boss_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_boss_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 2
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_boss_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_b",
			composition_type = "event_survival_stormvermin_few"
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_d",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_a",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_boss_d = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 2
			end
		},
		{
			"delay",
			duration = 8
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_c",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_13_a = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_13_b = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2 and count_event_breed("skaven_pack_master") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_13_c = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_pack_master"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_pack_master") < 1 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_13_d = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_gutter_runner"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_gutter_runner") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_13_e = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 4
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_in",
			composition_type = "event_survival_stormvermin"
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_stormvermin"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_poison_wind_globadier") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	survival_magnus_cataclysm_13_f = {
		{
			"control_specials",
			enable = false
		},
		{
			"set_master_event_running",
			name = "survival"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_special"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_b",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_gutter_runner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn_c",
			breed_name = "skaven_ratling_gunner"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"spawn_at_raw",
			spawner_id = "boss_spawn",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"delay",
			duration = 3
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			spawner_id = "spawner_flush_out",
			composition_type = "event_survival_main"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") == 0 and count_event_breed("skaven_slave") < 2 and count_event_breed("skaven_storm_vermin_commander") == 0 and count_event_breed("skaven_clan_rat") < 2 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_gutter_runner") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "survival_wave_complete"
		}
	},
	tutorial_kill_remaining = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 1
			end
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 1
			end
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_kill_remaining_complete"
		}
	},
	tutorial_dodge_attack = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_a",
			breed_name = "skaven_slave"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_dodge_attack_complete"
		}
	},
	tutorial_light_attack = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_a",
			breed_name = "skaven_slave"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_b",
			breed_name = "skaven_slave"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_c",
			breed_name = "skaven_slave"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_light_attack_complete"
		}
	},
	tutorial_heavy_attack = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_a",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_storm_vermin_commander") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_heavy_attack_complete"
		}
	},
	tutorial_ranged_normal_attack = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_ranged_spawner_a",
			breed_name = "skaven_clan_rat"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_ranged_spawner_b",
			breed_name = "skaven_clan_rat"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_ranged_spawner_c",
			breed_name = "skaven_clan_rat"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_ranged_normal_attack_complete"
		}
	},
	tutorial_ranged_alternative_attack = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_long_ranged_spawner_a",
			breed_name = "skaven_clan_rat"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_ranged_alternative_attack_complete"
		}
	},
	tutorial_blocking = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_a",
			breed_name = "skaven_clan_rat"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_blocking_complete"
		}
	},
	tutorial_pushing = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_a",
			breed_name = "skaven_slave"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_b",
			breed_name = "skaven_slave"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_spawner_c",
			breed_name = "skaven_slave"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_slave") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_pushing_complete"
		}
	},
	tutorial_throw_grenade = {
		{
			"set_master_event_running",
			name = "tutorial"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_grenade_spawner_a",
			breed_name = "skaven_clan_rat"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_grenade_spawner_b",
			breed_name = "skaven_clan_rat"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_grenade_spawner_c",
			breed_name = "skaven_clan_rat"
		},
		{
			"spawn_at_raw",
			spawner_id = "tutorial_grenade_spawner_d",
			breed_name = "skaven_clan_rat"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 1
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_throw_grenade_complete"
		}
	},
	tutorial_end_horde = {
		{
			"event_horde",
			spawner_id = "tutorial_end_horde_a",
			composition_type = "event_small"
		},
		{
			"delay",
			duration = 9
		},
		{
			"continue_when",
			condition = function (t)
				return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
			end
		},
		{
			"flow_event",
			flow_event_name = "tutorial_end_horde_complete"
		}
	},
	dlc_portals_control_pacing_disabled = {
		{
			"control_pacing",
			enable = false
		}
	},
	dlc_portals_control_pacing_enabled = {
		{
			"control_pacing",
			enable = true
		}
	},
	dlc_portals_a = {
		{
			"set_master_event_running",
			name = "dlc_portals_a"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 8
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_stormvermin"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			composition_type = "event_portals_flush"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			composition_type = "event_portals_flush"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_large"
		},
		{
			"delay",
			duration = 8
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"event_horde",
			composition_type = "event_portals_flush"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_a",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"flow_event",
			flow_event_name = "portals_terror_event_a_complete"
		}
	},
	dlc_portals_b = {
		{
			"set_master_event_running",
			name = "dlc_portals_b"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 8
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 20
		},
		{
			"flow_event",
			flow_event_name = "event_portal_b_spawn_ogre"
		},
		{
			"delay",
			duration = 30
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"event_horde",
			composition_type = "event_portals_flush"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			composition_type = "event_portals_flush"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_b",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_clanrats"
		},
		{
			"flow_event",
			flow_event_name = "portals_terror_event_b_complete"
		}
	},
	dlc_portals_c = {
		{
			"set_master_event_running",
			name = "dlc_portals_c"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			composition_type = "event_portals_flush"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_stormvermin"
		},
		{
			"delay",
			duration = 15
		},
		{
			"flow_event",
			flow_event_name = "event_portal_c_spawn_ogre"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_stormvermin"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"delay",
			duration = 3
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_rat_ogre") < 1
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_flush"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 3 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			composition_type = "event_portals_flush"
		},
		{
			"delay",
			duration = 3
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_flank"
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_flank"
		},
		{
			"delay",
			duration = 15
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_1",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			limit_spawners = 5,
			spawner_id = "spawner_portal_c_2",
			composition_type = "event_portals_slaves_small"
		},
		{
			"delay",
			duration = 10
		},
		{
			"continue_when",
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 6 and count_event_breed("skaven_storm_vermin_commander") < 2 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "portals_terror_event_c_complete"
		}
	},
	dlc_portals_guards_cliff = {
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_stormvermin_guard_1",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	dlc_portals_guards_portal_a = {
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_stormvermin_guard_8",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	dlc_portals_guards_camp_a = {
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_stormvermin_guard_3",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_stormvermin_guard_7",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	dlc_portals_guards_portal_b = {
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_stormvermin_guard_2",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	dlc_portals_guards_camp_b = {
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_stormvermin_guard_4",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_stormvermin_guard_6",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	dlc_portals_guards_portal_c = {
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_stormvermin_guard_5",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	dlc_portals_b_ogre = {
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_portal_b",
			breed_name = "skaven_rat_ogre"
		}
	},
	dlc_portals_c_ogre = {
		{
			"spawn_at_raw",
			spawner_id = "spawner_manual_event_portal_c_2",
			breed_name = "skaven_rat_ogre"
		}
	},
	dungeon_event_dark_end_ogre = {
		{
			"set_master_event_running",
			name = "dungeon"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"delay",
			duration = {
				1,
				3
			}
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "dark_finale_spawn",
			composition_type = "event_medium"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "dark_finale_spawn",
			composition_type = "event_medium"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"event_horde",
			spawner_id = "dark_finale_spawn",
			composition_type = "event_medium"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"event_horde",
			spawner_id = "dark_finale_spawn",
			composition_type = "event_medium"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 60,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_slave") < 5
			end
		},
		{
			"control_specials",
			enable = false
		},
		{
			"delay",
			duration = 7
		},
		{
			"spawn_at_raw",
			spawner_id = "dark_ogre1",
			breed_name = "skaven_rat_ogre"
		},
		{
			"delay",
			duration = 5
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "dark_finale_spawn",
			composition_type = "medium"
		},
		{
			"delay",
			duration = 20
		},
		{
			"event_horde",
			spawner_id = "dark_finale_spawn",
			composition_type = "event_small"
		},
		{
			"delay",
			duration = 5
		},
		{
			"continue_when",
			duration = 140,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_rat_ogre") < 1 and count_event_breed("skaven_slave") < 12
			end
		},
		{
			"control_specials",
			enable = true
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "dungeon_event_dark_doors"
		}
	},
	dungeon_escape_tunnels = {
		{
			"set_master_event_running",
			name = "dungeon"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "escape_tunnel",
			composition_type = "event_small"
		},
		{
			"continue_when",
			duration = 30,
			condition = function (t)
				return count_event_breed("skaven_slave") < 5
			end
		},
		{
			"delay",
			duration = 5
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "tunnel_end_event_escape_done"
		}
	},
	dungeon_artifact_defend = {
		{
			"set_master_event_running",
			name = "dungeon"
		},
		{
			"control_pacing",
			enable = false
		},
		{
			"event_horde",
			spawner_id = "dungeon1_artifactroom",
			composition_type = "event_generic_short_level_extra_spice"
		},
		{
			"delay",
			duration = 3
		},
		{
			"continue_when",
			duration = 20,
			condition = function (t)
				return count_event_breed("skaven_clan_rat") < 4 and count_event_breed("skaven_storm_vermin_commander") < 2
			end
		},
		{
			"control_pacing",
			enable = true
		},
		{
			"flow_event",
			flow_event_name = "dungeon_artifact_defend_done"
		}
	},
	dungeon_artifact_stormvermin = {
		{
			"set_master_event_running",
			name = "dungeon"
		},
		{
			"play_stinger",
			stinger_name = "enemy_horde_stinger"
		},
		{
			"event_horde",
			spawner_id = "dungeon1_artifactroom",
			composition_type = "event_generic_short_level_stormvermin"
		},
		{
			"delay",
			duration = 3
		}
	},
	dungeon_random_stormvermin_addition_a = {
		{
			"spawn_at_raw",
			spawner_id = "stormverminhaxA1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "stormverminhaxA2",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	dungeon_random_stormvermin_addition_b = {
		{
			"spawn_at_raw",
			spawner_id = "stormverminhaxB1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "stormverminhaxB2",
			breed_name = "skaven_storm_vermin_commander"
		}
	},
	dungeon_random_stormvermin_addition_c = {
		{
			"spawn_at_raw",
			spawner_id = "stormverminhaxC1",
			breed_name = "skaven_storm_vermin_commander"
		},
		{
			"spawn_at_raw",
			spawner_id = "stormverminhaxC2",
			breed_name = "skaven_storm_vermin_commander"
		}
	}
}

for chunk_name, chunk in pairs(WeightedRandomTerrorEvents) do
	for i = 1, #chunk, 2 do
		local event_name = chunk[i]

		fassert(TerrorEventBlueprints[event_name], "TerrorEventChunk %s has a bad event: '%s'.", chunk_name, tostring(event_name))
	end

	chunk.loaded_probability_table = LoadedDice.create_from_mixed(chunk)
end

return 
