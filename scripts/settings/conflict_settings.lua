HordeSettings = {
	default = {
		skip_chance = 0,
		chance_of_vector = 0.75,
		spawn_cooldown = 0.7,
		retry_cap = 20,
		disabled = false,
		mix_paced_hordes = true,
		breeds = {
			Breeds.skaven_clan_rat
		},
		compositions = {
			event_smaller = {
				{
					name = "plain",
					weight = 7,
					breeds = {
						"skaven_slave",
						{
							8,
							10
						}
					}
				},
				{
					name = "mixed",
					weight = 3,
					breeds = {
						"skaven_slave",
						{
							5,
							6
						},
						"skaven_clan_rat",
						{
							1,
							2
						}
					}
				}
			},
			event_small = {
				{
					name = "plain",
					weight = 7,
					breeds = {
						"skaven_slave",
						{
							13,
							15
						}
					}
				},
				{
					name = "mixed",
					weight = 3,
					breeds = {
						"skaven_slave",
						{
							10,
							12
						},
						"skaven_clan_rat",
						{
							2,
							4
						}
					}
				}
			},
			event_medium = {
				{
					name = "plain",
					weight = 7,
					breeds = {
						"skaven_slave",
						{
							22,
							23
						}
					}
				},
				{
					name = "mixed",
					weight = 3,
					breeds = {
						"skaven_slave",
						{
							12,
							14
						},
						"skaven_clan_rat",
						{
							5,
							6
						}
					}
				}
			},
			event_large = {
				{
					name = "plain",
					weight = 7,
					breeds = {
						"skaven_slave",
						{
							32,
							35
						}
					}
				},
				{
					name = "mixed",
					weight = 3,
					breeds = {
						"skaven_slave",
						{
							27,
							29
						},
						"skaven_clan_rat",
						{
							6,
							7
						}
					}
				}
			},
			performance_test = {
				{
					name = "mixed",
					weight = 3,
					breeds = {
						"skaven_slave",
						{
							15,
							15
						},
						"skaven_clan_rat",
						{
							15,
							15
						}
					}
				}
			},
			pathfind_test_light = {
				{
					name = "plain",
					weight = 7,
					breeds = {
						"skaven_slave",
						{
							50,
							50
						}
					}
				}
			},
			small = {
				{
					name = "plain",
					weight = 7,
					breeds = {
						"skaven_slave",
						{
							20,
							22
						}
					}
				},
				{
					name = "mixed",
					weight = 3,
					breeds = {
						"skaven_slave",
						{
							14,
							18
						}
					}
				}
			},
			medium = {
				{
					name = "plain",
					weight = 7,
					breeds = {
						"skaven_slave",
						{
							35,
							40
						}
					}
				}
			},
			large = {
				{
					name = "plain",
					weight = 7,
					breeds = {
						"skaven_slave",
						{
							40,
							45
						}
					}
				}
			},
			mini_patrol = {
				{
					name = "few_clanrats",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							3,
							5
						}
					}
				}
			},
			slave_trickle = {
				{
					name = "few_slaves",
					weight = 10,
					breeds = {
						"skaven_slave",
						{
							4,
							5
						}
					}
				}
			},
			stormdorf_boss_event_defensive_easy = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_slave",
						{
							3,
							5
						},
						"skaven_clan_rat",
						{
							3,
							5
						}
					}
				}
			},
			stormdorf_boss_event_defensive_normal = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_slave",
						{
							3,
							5
						},
						"skaven_clan_rat",
						{
							3,
							5
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							5,
							7
						}
					}
				}
			},
			stormdorf_boss_event_defensive_hard = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_slave",
						{
							4,
							6
						},
						"skaven_clan_rat",
						{
							5,
							7
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							8,
							10
						}
					}
				}
			},
			stormdorf_boss_event_defensive_harder = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_slave",
						{
							6,
							8
						},
						"skaven_clan_rat",
						{
							6,
							8
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							12,
							14
						}
					}
				}
			},
			stormdorf_boss_event_defensive_hardest = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_slave",
						{
							8,
							12
						},
						"skaven_clan_rat",
						{
							10,
							14
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							16,
							20
						}
					}
				}
			},
			event_courtyard_extra_spice = {
				{
					name = "plain",
					weight = 25,
					breeds = {
						"skaven_slave",
						{
							0,
							5
						},
						"skaven_clan_rat",
						{
							6,
							9
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							5,
							7
						},
						"skaven_storm_vermin_commander",
						{
							1,
							2
						}
					}
				}
			},
			event_courtyard_extra_big_spice = {
				{
					name = "plain",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							11,
							13
						}
					}
				},
				{
					name = "lotsofvermin",
					weight = 3,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							3,
							4
						}
					}
				}
			},
			event_farm_extra_spice = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_clan_rat",
						{
							8,
							11
						}
					}
				},
				{
					name = "avermin",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							8,
							11
						},
						"skaven_storm_vermin_commander",
						1
					}
				},
				{
					name = "somevermin",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							4,
							6
						},
						"skaven_storm_vermin_commander",
						2
					}
				}
			},
			event_farm_extra_big_spice = {
				{
					name = "plain",
					weight = 5,
					breeds = {
						"skaven_clan_rat",
						{
							13,
							16
						},
						"skaven_storm_vermin_commander",
						1
					}
				},
				{
					name = "lotsofvermin",
					weight = 5,
					breeds = {
						"skaven_slave",
						{
							7,
							10
						},
						"skaven_storm_vermin_commander",
						3
					}
				}
			},
			event_merchant_ambush = {
				{
					name = "plain",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							11,
							14
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							6,
							8
						},
						"skaven_storm_vermin_commander",
						{
							1,
							2
						}
					}
				}
			},
			wizard_event_smaller_hard = {
				{
					name = "plain",
					weight = 25,
					breeds = {
						"skaven_clan_rat",
						{
							12,
							14
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							7,
							8
						},
						"skaven_storm_vermin_commander",
						{
							1,
							2
						}
					}
				}
			},
			wizard_event_small_hard = {
				{
					name = "plain",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							18,
							19
						}
					}
				},
				{
					name = "somevermin",
					weight = 3,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							2,
							3
						}
					}
				}
			},
			sewers_event_smaller_hard = {
				{
					name = "plain",
					weight = 5,
					breeds = {
						"skaven_clan_rat",
						{
							6,
							9
						}
					}
				},
				{
					name = "somevermin",
					weight = 5,
					breeds = {
						"skaven_clan_rat",
						{
							4,
							5
						},
						"skaven_storm_vermin_commander",
						1
					}
				}
			},
			sewers_event_small_hard = {
				{
					name = "plain",
					weight = 5,
					breeds = {
						"skaven_slave",
						{
							2,
							4
						},
						"skaven_clan_rat",
						{
							12,
							14
						}
					}
				},
				{
					name = "somevermin",
					weight = 5,
					breeds = {
						"skaven_clan_rat",
						{
							4,
							5
						},
						"skaven_storm_vermin_commander",
						2
					}
				}
			},
			end_boss_event_smaller_hard = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_slave",
						{
							4,
							6
						},
						"skaven_clan_rat",
						{
							6,
							9
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							6,
							8
						},
						"skaven_storm_vermin_commander",
						1
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							8,
							11
						}
					}
				}
			},
			end_boss_event_small_hard = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_clan_rat",
						{
							11,
							13
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_storm_vermin_commander",
						3
					}
				},
				{
					name = "clanvermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							3,
							5
						},
						"skaven_storm_vermin_commander",
						2
					}
				}
			},
			end_boss_event_stormvermin = {
				{
					name = "somevermin",
					weight = 3,
					breeds = {
						"skaven_storm_vermin_commander",
						6
					}
				}
			},
			end_boss_event_stormvermin_small = {
				{
					name = "somevermin",
					weight = 3,
					breeds = {
						"skaven_storm_vermin_commander",
						4
					}
				}
			},
			end_boss_event_rolling = {
				{
					name = "plain",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							8,
							13
						}
					}
				},
				{
					name = "plain_slave",
					weight = 3,
					breeds = {
						"skaven_slave",
						{
							4,
							9
						},
						"skaven_clan_rat",
						{
							5,
							9
						}
					}
				},
				{
					name = "somevermin",
					weight = 2,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							2,
							3
						}
					}
				},
				{
					name = "somevermin_slave",
					weight = 2,
					breeds = {
						"skaven_slave",
						{
							4,
							9
						},
						"skaven_storm_vermin_commander",
						2
					}
				}
			},
			event_docks_warehouse_extra_spice = {
				{
					name = "few_clanrats",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							5,
							7
						}
					}
				},
				{
					name = "storm_clanrats",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							3,
							5
						},
						"skaven_storm_vermin_commander",
						{
							1,
							2
						}
					}
				}
			},
			event_generic_short_level_extra_spice = {
				{
					name = "few_clanrats",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							5,
							7
						}
					}
				},
				{
					name = "storm_clanrats",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							3,
							5
						},
						"skaven_storm_vermin_commander",
						{
							1,
							2
						}
					}
				}
			},
			event_generic_short_level_stormvermin = {
				{
					name = "somevermin",
					weight = 3,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							3,
							4
						}
					}
				}
			},
			city_wall_extra_spice = {
				{
					name = "few_clanrats",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							5,
							7
						}
					}
				},
				{
					name = "storm_clanrats",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							4,
							5
						},
						"skaven_storm_vermin_commander",
						1
					}
				}
			},
			event_generic_long_level_extra_spice = {
				{
					name = "few_clanrats",
					weight = 25,
					breeds = {
						"skaven_clan_rat",
						{
							4,
							5
						}
					}
				},
				{
					name = "storm_clanrats",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							2,
							3
						},
						"skaven_storm_vermin_commander",
						1
					}
				}
			},
			event_generic_long_level_stormvermin = {
				{
					name = "somevermin",
					weight = 3,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							2,
							3
						}
					}
				}
			},
			event_magnus_horn_smaller = {
				{
					name = "plain",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							6,
							9
						}
					}
				},
				{
					name = "somevermin",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							4,
							5
						},
						"skaven_storm_vermin_commander",
						{
							1,
							2
						}
					}
				}
			},
			event_magnus_horn_small = {
				{
					name = "plain",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							17,
							19
						}
					}
				},
				{
					name = "lotsofvermin",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							4,
							5
						},
						"skaven_storm_vermin_commander",
						{
							2,
							3
						}
					}
				}
			},
			event_dwarf_exterior_extra_spice = {
				{
					name = "few_clanrats",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							6,
							7
						},
						"skaven_storm_vermin_commander",
						1
					}
				},
				{
					name = "storm_clanrats",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							3,
							5
						},
						"skaven_storm_vermin_commander",
						2
					}
				}
			},
			event_dwarf_exterior_extra_spice_02 = {
				{
					name = "few_clanrats",
					weight = 10,
					breeds = {
						"skaven_clan_rat",
						{
							8,
							9
						}
					}
				},
				{
					name = "storm_clanrats",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							10,
							12
						}
					}
				}
			},
			event_survival_medium_intensity = {
				{
					name = "clanrats",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							15,
							21
						}
					}
				}
			},
			event_survival_high_intensity = {
				{
					name = "many_clanrats",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							25,
							31
						}
					}
				}
			},
			event_survival_storm_horde = {
				{
					name = "many_stormvermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							6,
							8
						},
						"skaven_storm_vermin_commander",
						{
							14,
							17
						}
					}
				}
			},
			event_survival_storm_band = {
				{
					name = "some_stormvermin",
					weight = 2,
					breeds = {
						"skaven_clan_rat",
						{
							6,
							8
						},
						"skaven_storm_vermin_commander",
						{
							2,
							3
						}
					}
				}
			},
			event_survival_slaves_small = {
				{
					name = "slaves_a",
					weight = 1,
					breeds = {
						"skaven_slave",
						{
							25,
							25
						}
					}
				}
			},
			event_survival_slaves_large = {
				{
					name = "slaves_a",
					weight = 1,
					breeds = {
						"skaven_slave",
						{
							40,
							40
						}
					}
				}
			},
			event_survival_main = {
				{
					name = "main_a",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							28,
							30
						}
					}
				}
			},
			event_survival_flank = {
				{
					name = "flank_a",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							17,
							30
						}
					}
				},
				{
					name = "flank_b",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							9,
							11
						},
						"skaven_slave",
						{
							25,
							30
						}
					}
				}
			},
			event_survival_pinch = {
				{
					name = "pinch_a",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							20,
							23
						}
					}
				},
				{
					name = "pinch_b",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							12,
							12
						},
						"skaven_slave",
						{
							20,
							22
						}
					}
				}
			},
			event_survival_flush = {
				{
					name = "main_a",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							25,
							28
						}
					}
				},
				{
					name = "main_b",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							7,
							13
						},
						"skaven_slave",
						{
							28,
							28
						}
					}
				}
			},
			event_survival_pack = {
				{
					name = "pack_a",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						13,
						"skaven_storm_vermin_commander",
						2
					}
				}
			},
			event_survival_stormvermin = {
				{
					name = "main_a",
					weight = 1,
					breeds = {
						"skaven_storm_vermin_commander",
						5
					}
				}
			},
			event_survival_stormvermin_few = {
				{
					name = "main_a",
					weight = 1,
					breeds = {
						"skaven_storm_vermin_commander",
						3
					}
				}
			},
			event_survival_extra = {
				{
					name = "extra_a",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							14,
							15
						},
						"skaven_storm_vermin_commander",
						{
							2,
							3
						}
					}
				}
			},
			event_tutorial_slave = {
				{
					name = "plain",
					weight = 1,
					breeds = {
						"skaven_slave",
						{
							1,
							1
						}
					}
				}
			},
			event_tutorial_clanrat = {
				{
					name = "plain",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							1,
							1
						}
					}
				}
			},
			event_tutorial_stormvermin = {
				{
					name = "plain",
					weight = 1,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							1,
							1
						}
					}
				}
			},
			benchmark_clanrat = {
				{
					name = "plain",
					weight = 25,
					breeds = {
						"skaven_clan_rat",
						{
							5,
							5
						}
					}
				}
			},
			benchmark_stormvermin = {
				{
					name = "lotsofvermin",
					weight = 3,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							2,
							2
						}
					}
				}
			},
			ai_benchmark_cycle_slaves = {
				{
					name = "slaves",
					weight = 3,
					breeds = {
						"skaven_slave",
						{
							20,
							20
						}
					}
				}
			},
			ai_benchmark_cycle_clanrat = {
				{
					name = "clanrats",
					weight = 3,
					breeds = {
						"skaven_clan_rat",
						{
							10,
							10
						}
					}
				}
			},
			ai_benchmark_cycle_stormvermin = {
				{
					name = "stormvermins",
					weight = 3,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							4,
							4
						}
					}
				}
			},
			event_portals_slaves_small = {
				{
					name = "slaves_small",
					weight = 1,
					breeds = {
						"skaven_slave",
						{
							15,
							20
						}
					}
				}
			},
			event_portals_slaves_large = {
				{
					name = "slaves_large",
					weight = 1,
					breeds = {
						"skaven_slave",
						{
							28,
							32
						}
					}
				}
			},
			event_portals_clanrats = {
				{
					name = "clanrats",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							17,
							18
						}
					}
				}
			},
			event_portals_flank = {
				{
					name = "flank_a",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							10,
							12
						}
					}
				},
				{
					name = "flank_b",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							2,
							3
						},
						"skaven_slave",
						{
							10,
							15
						}
					}
				}
			},
			event_portals_flush = {
				{
					name = "flush",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							7,
							8
						},
						"skaven_slave",
						{
							20,
							30
						}
					}
				}
			},
			event_portals_pack = {
				{
					name = "pack",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						8,
						"skaven_storm_vermin_commander",
						2
					}
				}
			},
			event_portals_stormvermin = {
				{
					name = "stormvermin",
					weight = 1,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							3,
							4
						}
					}
				}
			}
		},
		ambush = {
			max_size,
			max_horde_spawner_dist = 35,
			max_spawners = 15,
			min_hidden_spawner_dist = 10,
			composition_type = "medium",
			start_delay = 3.45,
			max_hidden_spawner_dist = 20,
			min_horde_spawner_dist = 1
		},
		vector = {
			max_size,
			max_horde_spawner_dist = 15,
			start_delay = 8,
			max_hidden_spawner_dist = 20,
			min_hidden_spawner_dist = 0,
			main_path_dist_from_players = 30,
			composition_type = "large",
			max_spawners = 4,
			main_path_chance_spawning_ahead = 0.67,
			min_horde_spawner_dist = 0
		},
		amount = {
			27,
			30
		},
		range_spawner_units = {
			2,
			6
		},
		range_hidden_spawn = {
			5,
			30
		},
		num_spawnpoints = {
			4,
			8
		}
	}
}

for dlc_name, dlc_settings in pairs(DLCSettings) do
	for name, data in pairs(dlc_settings.horde_settings_compositions) do
		HordeSettings.default.compositions[name] = data
	end
end

HordeSettings.disabled = table.clone(HordeSettings.default)
HordeSettings.disabled.disabled = true
local weights = {}

for key, setting in pairs(HordeSettings) do
	if setting.compositions then
		for size, composition in pairs(setting.compositions) do
			table.clear_array(weights, #weights)

			for i, variant in ipairs(composition) do
				weights[i] = variant.weight
			end

			composition.loaded_probs = {
				LoadedDice.create(weights)
			}
		end
	end
end

PackDistributions = {
	periodical = {
		min_hi_dist = 1,
		min_low_dist = 3,
		max_low_density = 0.4,
		min_hi_density = 0.7,
		random_dist = false,
		zero_density_below = 0,
		max_hi_dist = 2,
		min_low_density = 0.2,
		max_low_dist = 6,
		max_hi_density = 1
	},
	waved = {},
	random = {},
	uphill = {}
}
PackSpawningSettings = {
	clamp_main_path_zone_area = 100,
	length_density_coefficient = 0,
	calculate_nearby_islands = false,
	spawn_cycle_length = 350,
	clamp_outer_zones_used = 1,
	populate_by_area_and_length = true,
	populate_by_squeezed = false,
	area_density_coefficient = 5,
	distribution_method = "periodical",
	squezed_rats_per_10_meter = 10
}
RoamingSettings = {
	default = {
		despawn_distance = 45,
		despawn_path_distance = 90,
		despawn_distance_z = 30,
		disabled = false
	},
	disabled = {
		despawn_distance = 45,
		despawn_path_distance = 90,
		despawn_distance_z = 30,
		disabled = true
	},
	gdc_build = {
		despawn_distance = 45,
		despawn_path_distance = 90,
		despawn_distance_z = 30
	},
	challenge = {
		despawn_distance = 45,
		despawn_path_distance = 400,
		despawn_distance_z = 30,
		disabled = false
	}
}
SpecialsSettings = {
	default = {
		spawn_method = "specials_by_slots",
		disabled = false,
		max_specials = 3,
		breeds = {
			"skaven_gutter_runner",
			"skaven_poison_wind_globadier",
			"skaven_pack_master",
			"skaven_ratling_gunner"
		},
		methods = {
			specials_by_time_window = {
				even_out_breeds = true,
				spawn_interval = {
					90,
					120
				},
				lull_time = {
					20,
					40
				}
			},
			specials_by_slots = {
				max_of_same = 2,
				chance_of_coordinated_attack = 0,
				select_next_breed = "get_random_breed",
				after_safe_zone_delay = {
					5,
					150
				},
				spawn_cooldown = {
					100,
					200
				}
			}
		},
		outside_navmesh_intervention = {
			delay_between_interventions = 10,
			needed_ordinary_enemy_aggro = 5,
			disabled = true,
			needed_special_enemy_aggro = 1,
			intervention_time = 5,
			breeds = {
				"skaven_ratling_gunner",
				"skaven_poison_wind_globadier"
			}
		},
		rush_intervention = {
			loneliness_value_for_ambush_horde = 25,
			delay_between_interventions = 30,
			chance_of_ambush_horde = 0.25,
			loneliness_value_for_special = 15,
			distance_until_next_intervention = 30,
			breeds = {
				"skaven_pack_master",
				"skaven_gutter_runner"
			}
		}
	},
	survival = {
		spawn_method = "specials_by_slots",
		disabled = false,
		max_specials = 3,
		breeds = {
			"skaven_gutter_runner",
			"skaven_poison_wind_globadier",
			"skaven_pack_master",
			"skaven_ratling_gunner"
		},
		methods = {
			specials_by_time_window = {
				even_out_breeds = true,
				spawn_interval = {
					80,
					100
				},
				lull_time = {
					15,
					35
				}
			},
			specials_by_slots = {
				max_of_same = 2,
				chance_of_coordinated_attack = 0,
				select_next_breed = "get_random_breed",
				after_safe_zone_delay = {
					5,
					150
				},
				spawn_cooldown = {
					100,
					200
				}
			}
		},
		outside_navmesh_intervention = {
			delay_between_interventions = 8,
			needed_ordinary_enemy_aggro = 5,
			disabled = true,
			needed_special_enemy_aggro = 1,
			intervention_time = 3,
			breeds = {
				"skaven_ratling_gunner",
				"skaven_poison_wind_globadier"
			}
		},
		rush_intervention = {
			loneliness_value_for_ambush_horde = 25,
			delay_between_interventions = 30,
			chance_of_ambush_horde = 0.25,
			loneliness_value_for_special = 15,
			distance_until_next_intervention = 30,
			breeds = {
				"skaven_pack_master",
				"skaven_gutter_runner"
			}
		}
	},
	gdc_build = {
		spawn_method = "specials_by_slots",
		disabled = false,
		max_specials = 3,
		breeds = {
			"skaven_poison_wind_globadier",
			"skaven_ratling_gunner"
		},
		methods = {
			specials_by_time_window = {
				even_out_breeds = true,
				lull_time = {
					20,
					40
				}
			},
			specials_by_slots = {
				select_next_breed = "get_random_breed",
				max_of_same = 2,
				spawn_interval = {
					30,
					60
				},
				spawn_cooldown = {
					30,
					40
				}
			}
		},
		rush_intervention = {
			loneliness_value_for_ambush_horde = 25,
			delay_between_interventions = 30,
			chance_of_ambush_horde = 0.25,
			loneliness_value_for_special = 15,
			distance_until_next_intervention = 30,
			breeds = {
				"skaven_pack_master",
				"skaven_gutter_runner"
			}
		}
	},
	disabled = {
		disabled = true,
		rush_intervention = {},
		outside_navmesh_intervention = {}
	}
}
BossSettings = {
	default = {
		disabled = false,
		boss_events = {
			safe_dist = 150,
			name = "boss_events",
			recurring_distance = 300,
			terror_events_using_packs = false,
			padding_dist = 100,
			debug_color = "deep_sky_blue",
			hand_placed_padding_dist = 10,
			events = {
				"boss_event_rat_ogre",
				"boss_event_storm_vermin_patrol",
				"nothing"
			},
			max_events_of_this_kind = {
				boss_event_rat_ogre = 1
			},
			editor_event_legend = {
				boss_event_storm_vermin_patrol = "event_patrol",
				boss_event_rat_ogre = "event_boss"
			}
		},
		rare_events = {
			safe_dist = 50,
			recurring_distance = 1500,
			name = "rare_events",
			debug_color = "deep_pink",
			padding_dist = 100,
			events = {
				"rare_event_loot_rat"
			},
			max_events_of_this_kind = {},
			editor_event_legend = {
				rare_event_loot_rat = "event_boss"
			}
		}
	},
	gdc_build = {
		disabled = false,
		boss_events = {
			safe_dist = 150,
			recurring_distance = 300,
			name = "boss_events",
			debug_color = "deep_sky_blue",
			events = {
				"nothing"
			}
		},
		rare_events = {
			safe_dist = 50,
			recurring_distance = 1500,
			name = "rare_events",
			debug_color = "deep_pink",
			events = {}
		}
	},
	disabled = {
		safe_distance = 100,
		disabled = true
	}
}
IntensitySettings = {
	default = {
		intensity_add_per_percent_dmg_taken = 1,
		decay_delay = 4,
		decay_per_second = 3,
		intensity_add_knockdown = 50,
		intensity_add_pounced_down = 10,
		max_intensity = 100,
		intensity_add_nearby_kill = 1,
		disabled = false,
		difficulty_overrides = {}
	},
	disabled = {
		intensity_add_per_percent_dmg_taken = 0,
		decay_delay = 0,
		decay_per_second = 100,
		disabled = true,
		intensity_add_knockdown = 0,
		intensity_add_pounced_down = 0,
		intensity_add_nearby_kill = 0,
		max_intensity = 100
	}
}
local difficulty_overrides = IntensitySettings.default.difficulty_overrides

for difficulty_name, settings in pairs(DifficultySettings) do
	difficulty_overrides[difficulty_name] = settings.intensity_overrides
end

PacingSettings = {
	default = {
		peak_intensity_threshold = 35,
		leave_relax_if_zero_intensity = true,
		horde_in_relax_if_rushing = false,
		leave_relax_if_rushing = true,
		relax_rushing_distance = 70,
		disabled = false,
		peak_fade_threshold = 32.5,
		sustain_peak_duration = {
			3,
			5
		},
		relax_duration = {
			35,
			45
		},
		horde_frequency = {
			90,
			180
		},
		horde_startup_time = {
			25,
			90
		},
		horde = HordeSettings.default,
		horde_delay = {
			0,
			0
		},
		mini_patrol = {
			composition = "mini_patrol",
			override_timer = 35,
			only_spawn_below_intensity = 25,
			frequency = {
				7,
				15
			}
		},
		difficulty_overrides = {}
	},
	defaultfrom20140702 = {
		peak_intensity_threshold = 70,
		disabled = false,
		peak_fade_threshold = 65,
		sustain_peak_duration = {
			3,
			5
		},
		relax_duration = {
			30,
			45
		},
		horde_frequency = {
			45,
			75
		},
		horde_startup_time = {
			15,
			180
		},
		horde = HordeSettings.default,
		horde_delay = {
			4,
			4
		}
	},
	intense = {
		peak_intensity_threshold = 80,
		disabled = false,
		peak_fade_threshold = 75,
		sustain_peak_duration = {
			5,
			10
		},
		relax_duration = {
			15,
			25
		},
		horde_frequency = {
			15,
			45
		},
		horde_startup_time = {
			15,
			180
		},
		horde = HordeSettings.default,
		horde_delay = {
			4,
			5
		}
	},
	city_wall = {
		peak_intensity_threshold = 35,
		leave_relax_if_zero_intensity = true,
		horde_in_relax_if_rushing = false,
		leave_relax_if_rushing = true,
		relax_rushing_distance = 70,
		disabled = false,
		peak_fade_threshold = 32.5,
		sustain_peak_duration = {
			3,
			5
		},
		relax_duration = {
			25,
			35
		},
		horde_frequency = {
			120,
			180
		},
		horde_startup_time = {
			15,
			180
		},
		horde = HordeSettings.default,
		horde_delay = {
			0,
			0
		},
		mini_patrol = {
			composition = "city_wall_extra_spice",
			override_timer = 25,
			only_spawn_below_intensity = 65,
			frequency = {
				10,
				15
			}
		}
	},
	disabled = {
		peak_intensity_threshold = 0,
		disabled = true,
		peak_fade_threshold = 75,
		sustain_peak_duration = {
			5,
			10
		},
		relax_duration = {
			10000,
			10000
		},
		horde_frequency = {
			0,
			0
		},
		horde_startup_time = {
			0,
			0
		},
		horde = HordeSettings.disabled,
		horde_delay = {
			4,
			5
		}
	}
}
local difficulty_overrides = PacingSettings.default.difficulty_overrides

for difficulty_name, settings in pairs(DifficultySettings) do
	difficulty_overrides[difficulty_name] = settings.pacing_overrides
end

ConflictDirectors = {
	default = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.default,
		boss = BossSettings.default,
		specials = SpecialsSettings.default,
		roaming = RoamingSettings.default
	},
	level_editor = {
		disabled = true,
		intensity = IntensitySettings.disabled,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.disabled,
		roaming = RoamingSettings.disabled
	},
	event_level = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.default,
		roaming = RoamingSettings.disabled
	},
	event_level_with_roaming = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.default,
		roaming = RoamingSettings.default
	},
	event_level_with_roaming_no_specials = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.disabled,
		roaming = RoamingSettings.default
	},
	event_level_with_roaming_less_roamers = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.default,
		roaming = RoamingSettings.default
	},
	city_wall = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.city_wall,
		boss = BossSettings.default,
		specials = SpecialsSettings.default,
		roaming = RoamingSettings.default
	},
	srekel = {
		disabled = false,
		intensity = IntensitySettings.disabled,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.disabled,
		roaming = RoamingSettings.srekel
	},
	endboss = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.default,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.default,
		roaming = RoamingSettings.default
	},
	disabled = {
		disabled = true,
		intensity = IntensitySettings.disabled,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.disabled,
		roaming = RoamingSettings.disabled
	},
	victor = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.default,
		boss = BossSettings.default,
		specials = SpecialsSettings.victor,
		roaming = RoamingSettings.victor
	},
	gdc_build = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.default,
		boss = BossSettings.gdc_build,
		specials = SpecialsSettings.gdc_build,
		roaming = RoamingSettings.default
	},
	survival = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.survival,
		roaming = RoamingSettings.disabled
	},
	dlc_portals = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.default,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.default,
		roaming = RoamingSettings.default
	},
	tutorial = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.disabled,
		boss = BossSettings.disabled,
		specials = SpecialsSettings.disabled,
		roaming = RoamingSettings.disabled
	},
	challenge = {
		disabled = false,
		intensity = IntensitySettings.default,
		pacing = PacingSettings.default,
		boss = BossSettings.default,
		specials = SpecialsSettings.default,
		roaming = RoamingSettings.challenge
	}
}
RecycleSettings = {
	push_horde_if_num_alive_grunts_above = 60,
	push_horde_in_time = false,
	destroy_los_distance_squared = 8100,
	use_horde_composition_lists = false,
	max_grunts = 70,
	destroy_stuck_distance_squared = 625,
	destroy_no_path_only_behind = true,
	ai_stuck_check_start_time = 10,
	destroy_no_path_found_time = 10,
	composition_list = {
		{
			vector = "large",
			spawned_threshold = 50,
			ambush = "medium"
		},
		{
			vector = "medium",
			spawned_threshold = 60,
			ambush = "small"
		}
	}
}
CurrentConflictSettings = CurrentConflictSettings or false
CurrentIntensitySettings = CurrentIntensitySettings or false
CurrentPacing = CurrentPacing or false
CurrentBossSettings = CurrentBossSettings or false
CurrentSpecialsSettings = CurrentSpecialsSettings or false
CurrentHordeSettings = CurrentHordeSettings or false
CurrentRoamingSettings = CurrentRoamingSettings or false
PackSpawningSettings = PackSpawningSettings or false
local crash = false
local compositions = HordeSettings.default.compositions

for name, elements in pairs(TerrorEventBlueprints) do
	for i = 1, #elements, 1 do
		local element = elements[i]
		local element_type = element[1]

		if element_type == "event_horde" and not compositions[element.composition_type] then
			print(string.format("Bad or misspelled composition_type '%s' in event '%s', element number %d", tostring(element.composition_type), name, i))

			crash = true
		end
	end
end

if crash then
end

return 
