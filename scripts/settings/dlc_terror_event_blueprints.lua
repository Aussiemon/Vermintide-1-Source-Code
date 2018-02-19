DLCTerrorEventBlueprints = {}

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

local TerrorEventBlueprints = {
	chamber = {
		win32 = {
			chamber_pacing_off = {
				{
					"control_pacing",
					enable = false
				},
				{
					"control_specials",
					enable = false
				}
			},
			chamber_pacing_on = {
				{
					"control_pacing",
					enable = true
				},
				{
					"control_specials",
					enable = true
				}
			},
			chamber_inn_setup_a = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_inn_setup_b = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_inn_setup_c = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_end_a = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"control_specials",
					enable = true
				},
				{
					"event_horde",
					spawner_id = "chamber_end_a_spawn",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "chamber_backfill",
					composition_type = "event_chamber_stormvermin"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_end_a_front_spawn",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_a_done"
				}
			},
			chamber_end_b = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_end_b_spawn",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "chamber_end_b_front_spawn",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_b_done"
				}
			},
			chamber_end_c = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_end_c_spawn",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_c_done"
				}
			},
			chamber_grey_seer = {
				{
					"spawn_at_raw",
					spawner_id = "chamber_grey_seer",
					breed_name = "skaven_grey_seer"
				}
			},
			grey_seer_terror_event = {
				{
					"control_specials",
					enable = false
				},
				{
					"spawn_at_raw",
					spawner_id = "grey_seer_end_event",
					breed_name = "skaven_grey_seer"
				},
				{
					"delay",
					duration = 10
				},
				{
					"control_specials",
					enable = true
				}
			}
		},
		xb1 = {
			xb1 = {},
			chamber_pacing_off = {
				{
					"control_pacing",
					enable = false
				},
				{
					"control_specials",
					enable = false
				}
			},
			chamber_pacing_on = {
				{
					"control_pacing",
					enable = true
				},
				{
					"control_specials",
					enable = true
				}
			},
			chamber_inn_setup_a = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 30
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 25,
						exchange_ratio = 2
					}
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_inn_setup_b = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 30
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 25,
						exchange_ratio = 2
					}
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_inn_setup_c = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 30
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 25,
						exchange_ratio = 2
					}
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_end_a = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"control_specials",
					enable = true
				},
				{
					"set_freeze_condition",
					max_active_enemies = 35
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 30,
						exchange_ratio = 2
					}
				},
				{
					"event_horde",
					spawner_id = "chamber_end_a_spawn",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "chamber_backfill",
					composition_type = "event_chamber_stormvermin"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_end_a_front_spawn",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_a_done"
				}
			},
			chamber_end_b = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 35
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 30,
						exchange_ratio = 2
					}
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_end_b_spawn",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "chamber_end_b_front_spawn",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_b_done"
				}
			},
			chamber_end_c = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 35
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 30,
						exchange_ratio = 2
					}
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_end_c_spawn",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_c_done"
				}
			},
			chamber_grey_seer = {
				{
					"spawn_at_raw",
					spawner_id = "chamber_grey_seer",
					breed_name = "skaven_grey_seer"
				}
			},
			grey_seer_terror_event = {
				{
					"control_specials",
					enable = false
				},
				{
					"spawn_at_raw",
					spawner_id = "grey_seer_end_event",
					breed_name = "skaven_grey_seer"
				},
				{
					"delay",
					duration = 10
				},
				{
					"control_specials",
					enable = true
				}
			}
		},
		ps4 = {
			chamber_pacing_off = {
				{
					"control_pacing",
					enable = false
				},
				{
					"control_specials",
					enable = false
				}
			},
			chamber_pacing_on = {
				{
					"control_pacing",
					enable = true
				},
				{
					"control_specials",
					enable = true
				}
			},
			chamber_inn_setup_a = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 30
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 25,
						exchange_ratio = 2
					}
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_inn_setup_b = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 30
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 25,
						exchange_ratio = 2
					}
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_inn_setup_c = {
				{
					"set_master_event_running",
					name = "chamber_inn"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 30
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 25,
						exchange_ratio = 2
					}
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_floor_roger",
					breed_name = "skaven_rat_ogre"
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
					spawner_id = "inn_floor_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_c"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_roof_c",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"flow_event",
					flow_event_name = "inn_roof_destroy_a"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_b",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_room_a",
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_c",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 3
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_halfway"
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_slaves_large"
				},
				{
					"flow_event",
					flow_event_name = "inn_chimney_event"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 2
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_b",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"delay",
					duration = 5
				},
				{
					"spawn_at_raw",
					spawner_id = "inn_manual_spawn_window_b",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_ratling_gunner") < 1
					end
				},
				{
					"event_horde",
					spawner_id = "inn_room_spawn_a",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"event_horde",
					spawner_id = "inn_roof_spawn_c",
					composition_type = "event_chamber_slaves_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "inn_chimney_spawn_a",
					composition_type = "event_chamber_clanrats"
				},
				{
					"delay",
					duration = 10
				},
				{
					"event_horde",
					spawner_id = "inn_door_window_spawn_a",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_slave") < 1 and count_event_breed("skaven_clan_rat") < 1 and count_event_breed("skaven_gutter_runner") < 1 and count_event_breed("skaven_ratling_gunner") < 1 and count_event_breed("skaven_poison_wind_globadier") < 1 and count_event_breed("skaven_storm_vermin_commander") < 1
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_inn_event_done"
				}
			},
			chamber_end_a = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"control_specials",
					enable = true
				},
				{
					"set_freeze_condition",
					max_active_enemies = 35
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 30,
						exchange_ratio = 2
					}
				},
				{
					"delay",
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "chamber_end_a_spawn",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_backfill",
					composition_type = "event_chamber_stormvermin"
				},
				{
					"event_horde",
					spawner_id = "chamber_end_a_front_spawn",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_a_done"
				}
			},
			chamber_end_b = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 35
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 30,
						exchange_ratio = 2
					}
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_end_b_spawn",
					composition_type = "event_chamber_mixed_a"
				},
				{
					"delay",
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "chamber_end_b_front_spawn",
					composition_type = "event_chamber_mixed_c"
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_b_done"
				}
			},
			chamber_end_c = {
				{
					"set_master_event_running",
					name = "chamber_end"
				},
				{
					"set_freeze_condition",
					max_active_enemies = 35
				},
				{
					"set_breed_event_horde_spawn_limit",
					breed_name = "skaven_slave",
					limit = {
						spawn_breed = "skaven_clan_rat",
						max_active_enemies = 30,
						exchange_ratio = 2
					}
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 8 and count_event_breed("skaven_slave") < 8
					end
				},
				{
					"event_horde",
					spawner_id = "chamber_end_c_spawn",
					composition_type = "event_chamber_mixed_b"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 3 and count_event_breed("skaven_slave") < 5 and count_event_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "chamber_end_c_done"
				}
			},
			chamber_grey_seer = {
				{
					"spawn_at_raw",
					spawner_id = "chamber_grey_seer",
					breed_name = "skaven_grey_seer"
				}
			},
			grey_seer_terror_event = {
				{
					"control_specials",
					enable = false
				},
				{
					"spawn_at_raw",
					spawner_id = "grey_seer_end_event",
					breed_name = "skaven_grey_seer"
				},
				{
					"delay",
					duration = 10
				},
				{
					"control_specials",
					enable = true
				}
			}
		}
	}
}
DLCTerrorEventBlueprints.get_terror_event_blueprints = function (level_name)
	assert(TerrorEventBlueprints[level_name][PLATFORM], string.format("There is no DLC level called %q", level_name))

	return TerrorEventBlueprints[level_name][PLATFORM]
end

return 
