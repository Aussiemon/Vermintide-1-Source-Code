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

DLCSettings = {
	stromdorf = {
		product_label = "",
		unit_extension_templates = "scripts/network/unit_extension_templates_stromdorf",
		level_settings = "scripts/settings/level_settings_dlc_stromdorf",
		package_name = "resource_packages/dlcs/stromdorf/stromdorf",
		level_unlock_settings = "scripts/settings/level_unlock_settings_dlc_stromdorf",
		area_settings = {
			stromdorf = {
				area_icon_background_texture = "stromdorf_icon",
				display_name = "dlc1_8_area_stromdorf",
				sorting = 5,
				map_icon = "level_location_any_icon",
				area_icon_hover_texture = "stromdorf_icon_glow",
				banner_texture = "stromdorf_location_icon_banner",
				dlc_name = "stromdorf",
				dlc_url = "http://store.steampowered.com/app/463795",
				level_image = "level_image_location_stromdorf",
				map_texture = "map_stromdorf",
				map_position = {
					295,
					17
				},
				console_map_textures = {
					selected = "area_image_karak_azgaraz_01",
					normal = "area_image_karak_azgaraz_02"
				},
				banner_texture_size = {
					48,
					148
				}
			}
		},
		unlock_settings = {
			stromdorf = {
				class = "UnlockDlc",
				id = "463795"
			}
		},
		weapons = {
			"scripts/settings/equipment/2h_swords_executioner"
		},
		breeds = {
			"scripts/settings/breeds/breed_skaven_storm_vermin_champion"
		},
		behaviour_trees_precompiled = {
			"scripts/entity_system/systems/behaviour/nodes/generated/bt_selector_storm_vermin_champion"
		},
		behaviour_tree_nodes = {
			"scripts/entity_system/systems/behaviour/nodes/bt_spawn_allies_action"
		},
		behaviour_trees = {
			"scripts/entity_system/systems/behaviour/bt_storm_vermin_champion"
		},
		terror_event_blueprints = {
			stromdorf_pacing_off = {
				{
					"control_pacing",
					enable = false
				},
				{
					"control_specials",
					enable = false
				}
			},
			stromdorf_town_boss = {
				{
					"set_master_event_running",
					name = "stromdorf_boss"
				},
				{
					"event_horde",
					spawner_id = "stromdorf_boss",
					composition_type = "event_strom_boss"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_event_breed("skaven_storm_vermin_champion") == 0
					end
				},
				{
					"flow_event",
					flow_event_name = "stromdorf_boss_killed"
				}
			},
			stromdorf_pacing_on = {
				{
					"control_pacing",
					enable = true
				},
				{
					"control_specials",
					enable = true
				}
			},
			stromdorf_town_flee = {
				{
					"set_master_event_running",
					name = "stromdorf_town_flee"
				},
				{
					"event_horde",
					spawner_id = "tannery_door_spawner",
					composition_type = "event_smaller"
				},
				{
					"delay",
					duration = 1
				},
				{
					"event_horde",
					spawner_id = "tannery_well_spawner",
					composition_type = "event_smaller"
				},
				{
					"event_horde",
					spawner_id = "tannery_well_spawner_2",
					composition_type = "event_small"
				}
			},
			stromdorf_town_flee_2 = {
				{
					"set_master_event_running",
					name = "stromdorf_town_flee_2"
				},
				{
					"event_horde",
					spawner_id = "tannery_flee_spawner_2",
					composition_type = "event_small"
				}
			}
		},
		weighted_random_terror_events = {},
		missions = {
			stromdorf_hills_courier = {
				mission_template_name = "goal",
				text = "mission_stromdorf_hills_find_courier"
			},
			stromdorf_hills_tower = {
				mission_template_name = "goal",
				text = "mission_stromdorf_hills_search_tower"
			},
			stromdorf_hills_goto_stromdorf = {
				mission_template_name = "goal",
				text = "mission_stromdorf_hills_goto_stromdorf"
			},
			stromdorf_town_goto_town = {
				mission_template_name = "goal",
				text = "mission_stromdorf_town_goto_town"
			},
			stromdorf_town_find_tannery = {
				mission_template_name = "goal",
				text = "mission_stromdorf_town_find_tannery"
			},
			stromdorf_town_investigate_tannery = {
				mission_template_name = "goal",
				text = "mission_stromdorf_town_investigate_tannery"
			},
			stromdorf_town_kill_boss = {
				mission_template_name = "goal",
				text = "mission_stromdorf_town_kill_boss"
			},
			stromdorf_town_goto_coach = {
				mission_template_name = "goal",
				text = "mission_stromdorf_town_goto_coach"
			}
		},
		dialogue_lookup = {
			"dialogues/generated/lookup_wood_elf_stromdorf_hills",
			"dialogues/generated/lookup_witch_hunter_stromdorf_hills",
			"dialogues/generated/lookup_empire_soldier_stromdorf_hills",
			"dialogues/generated/lookup_dwarf_ranger_stromdorf_hills",
			"dialogues/generated/lookup_bright_wizard_stromdorf_hills",
			"dialogues/generated/lookup_wood_elf_stromdorf_town",
			"dialogues/generated/lookup_witch_hunter_stromdorf_town",
			"dialogues/generated/lookup_empire_soldier_stromdorf_town",
			"dialogues/generated/lookup_dwarf_ranger_stromdorf_town",
			"dialogues/generated/lookup_bright_wizard_stromdorf_town",
			"dialogues/generated/lookup_enemy_champion_chieftain_stromdorf_town",
			"dialogues/generated/lookup_hero_conversations_stromdorf"
		},
		dialogue_settings = {
			dlc_stromdorf_hills = {
				"dialogues/generated/bright_wizard_stromdorf_hills",
				"dialogues/generated/dwarf_ranger_stromdorf_hills",
				"dialogues/generated/witch_hunter_stromdorf_hills",
				"dialogues/generated/wood_elf_stromdorf_hills",
				"dialogues/generated/dwarf_ranger_stromdorf_hills",
				"dialogues/generated/empire_soldier_stromdorf_hills",
				"dialogues/generated/hero_conversations_stromdorf"
			},
			dlc_stromdorf_town = {
				"dialogues/generated/bright_wizard_stromdorf_town",
				"dialogues/generated/empire_soldier_stromdorf_town",
				"dialogues/generated/dwarf_ranger_stromdorf_town",
				"dialogues/generated/witch_hunter_stromdorf_town",
				"dialogues/generated/wood_elf_stromdorf_town",
				"dialogues/generated/dwarf_ranger_stromdorf_town",
				"dialogues/generated/enemy_champion_chieftain_stromdorf_town",
				"dialogues/generated/hero_conversations_stromdorf"
			}
		},
		horde_settings_compositions = {
			event_strom_boss = {
				{
					name = "champion",
					weight = 1,
					breeds = {
						"skaven_storm_vermin_champion",
						1
					}
				}
			}
		},
		lorebook_pages = {
			"dlc1_3_lb_vt_world_nations_empire_reikshammer_title",
			"dlc1_3_lb_vt_stromdorf_title",
			"dlc1_3_lb_vt_stromdorf_overview_title",
			"dlc1_3_lb_vt_stromdorf_locations_title",
			"dlc1_3_lb_vt_stromdorf_thunderwater_inn_title",
			"dlc1_3_lb_vt_stromdorf_stewpot_hostelry_title",
			"dlc1_3_lb_vt_stromdorf_temple_of_sigmar_title",
			"dlc1_3_lb_vt_stromdorf_reikland_gate_title",
			"dlc1_3_lb_vt_stromdorf_field_of_verena_title",
			"dlc1_3_lb_vt_stromdorf_cursed_well_title",
			"dlc1_3_lb_vt_stromdorf_characters_title",
			"dlc1_3_lb_vt_stromdorf_lazarus_mourn_title",
			"dlc1_3_lb_vt_stromdorf_captain_kessler_title",
			"dlc1_3_lb_vt_stromdorf_keila_cobblepot_title",
			"dlc1_3_lb_vt_stromdorf_holtz_family_title",
			"dlc1_3_lb_vt_stromdorf_krench_title"
		}
	},
	dlc_challenge_wizard = {
		unit_extension_templates = "scripts/network/unit_extension_templates_stromdorf",
		product_label = "",
		level_settings = "scripts/settings/level_settings_dlc_challenge_wizard",
		package_name = "resource_packages/dlcs/challenge_wizard/challenge_wizard",
		level_unlock_settings = "scripts/settings/level_unlock_settings_dlc_challenge_wizard",
		unlock_settings = {
			challenge_wizard = {
				class = "AlwaysUnlocked"
			}
		},
		weapons = {},
		breeds = {
			"scripts/settings/breeds/breed_skaven_storm_vermin_champion"
		},
		behaviour_trees_precompiled = {
			"scripts/entity_system/systems/behaviour/nodes/generated/bt_selector_storm_vermin_champion"
		},
		behaviour_tree_nodes = {
			"scripts/entity_system/systems/behaviour/nodes/bt_spawn_allies_action"
		},
		behaviour_trees = {
			"scripts/entity_system/systems/behaviour/bt_storm_vermin_champion"
		},
		terror_event_blueprints = {
			snow_boss = {
				{
					"set_master_event_running",
					name = "snow_boss"
				},
				{
					"spawn_at_raw",
					spawner_id = "snow_boss",
					breed_name = "skaven_rat_ogre"
				},
				{
					"spawn_at_raw",
					spawner_id = "snow_boss_02",
					breed_name = "skaven_rat_ogre"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_rat_ogre") <= 1
					end
				},
				{
					"flow_event",
					flow_event_name = "snow_boss_killed_one"
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_rat_ogre") == 0
					end
				},
				{
					"flow_event",
					flow_event_name = "snow_boss_killed_two"
				}
			},
			general_wizard = {
				{
					"set_master_event_running",
					name = "general_wizard"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "general_wizard",
					composition_type = "event_general_trickle_hub"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "general_wizard_loop"
				}
			},
			general_forest = {
				{
					"set_master_event_running",
					name = "general_forest"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "general_forest",
					composition_type = "event_general_trickle"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "general_forest_loop"
				}
			},
			general_town = {
				{
					"set_master_event_running",
					name = "general_town"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "general_town",
					composition_type = "event_general_trickle"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "general_town_loop"
				}
			},
			general_snow = {
				{
					"set_master_event_running",
					name = "general_snow"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "general_snow",
					composition_type = "event_general_trickle"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "general_snow_loop"
				}
			},
			general_escher = {
				{
					"set_master_event_running",
					name = "general_escher"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 8 and count_breed("skaven_slave") < 8 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "general_escher",
					composition_type = "event_general_trickle"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "general_escher_loop"
				}
			},
			general_final_showdown = {
				{
					"set_master_event_running",
					name = "end"
				},
				{
					"event_horde",
					spawner_id = "general_wizard",
					composition_type = "event_general_trickle"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "general_final_showdown_loop"
				}
			},
			town_open_chest = {
				{
					"set_master_event_running",
					name = "town"
				},
				{
					"delay",
					duration = 3
				},
				{
					"spawn",
					2,
					breed_name = "skaven_gutter_runner"
				}
			},
			town_01 = {
				{
					"set_master_event_running",
					name = "town"
				},
				{
					"spawn",
					2,
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_pack_master"
				}
			},
			town_02 = {
				{
					"set_master_event_running",
					name = "town"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_ratling_gunner"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_pack_master"
				}
			},
			town_03 = {
				{
					"set_master_event_running",
					name = "town"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_ratling_gunner"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_poison_wind_globadier"
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
				}
			},
			town_grabbed_ingredient = {
				{
					"set_master_event_running",
					name = "town"
				},
				{
					"event_horde",
					spawner_id = "general_town_tear",
					composition_type = "event_general_trickle"
				}
			},
			snow_01 = {
				{
					"set_master_event_running",
					name = "snow"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_ratling_gunner"
				}
			},
			snow_02 = {
				{
					"set_master_event_running",
					name = "snow"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_poison_wind_globadier"
				}
			},
			snow_03 = {
				{
					"set_master_event_running",
					name = "snow"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_ratling_gunner"
				}
			},
			snow_grabbed_ingredient = {
				{
					"set_master_event_running",
					name = "snow"
				},
				{
					"event_horde",
					spawner_id = "general_snow_tear",
					composition_type = "event_general_trickle"
				}
			},
			forest_01 = {
				{
					"set_master_event_running",
					name = "forest"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_poison_wind_globadier"
				}
			},
			forest_02 = {
				{
					"set_master_event_running",
					name = "forest"
				},
				{
					"spawn",
					2,
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_pack_master"
				}
			},
			forest_03 = {
				{
					"set_master_event_running",
					name = "forest"
				},
				{
					"spawn",
					5,
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_gutter_runner"
				}
			},
			forest_grabbed_ingredient = {
				{
					"set_master_event_running",
					name = "forest"
				},
				{
					"event_horde",
					spawner_id = "general_forest_tear",
					composition_type = "event_general_trickle"
				}
			},
			escher_special_01 = {
				{
					"set_master_event_running",
					name = "escher"
				},
				{
					"delay",
					duration = 5
				}
			},
			final_showdown = {
				{
					"set_master_event_running",
					name = "end"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"delay",
					duration = 20
				},
				{
					"spawn",
					1,
					breed_name = "skaven_ratling_gunner"
				},
				{
					"delay",
					duration = 20
				},
				{
					"spawn",
					1,
					breed_name = "skaven_pack_master"
				},
				{
					"delay",
					duration = 20
				},
				{
					"spawn",
					1,
					breed_name = "skaven_poison_wind_globadier"
				},
				{
					"spawn",
					1,
					breed_name = "skaven_ratling_gunner"
				},
				{
					"delay",
					duration = 20
				},
				{
					"spawn",
					1,
					breed_name = "skaven_gutter_runner"
				},
				{
					"spawn",
					5,
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"delay",
					duration = 20
				},
				{
					"spawn",
					1,
					breed_name = "skaven_poison_wind_globadier"
				}
			}
		},
		weighted_random_terror_events = {},
		missions = {
			dlc_challenge_wizard_hub_overall = {
				mission_template_name = "goal",
				text = "objective_foolhardy_wizard_hub_overall"
			},
			dlc_challenge_wizard_snow_collect_keys = {
				text = "objective_foolhardy_snow_search_cargo_for_keys",
				mission_template_name = "collect",
				collect_amount = 3
			},
			dlc_challenge_wizard_snow_kill = {
				text = "objective_foolhardy_snow_slain",
				mission_template_name = "collect",
				collect_amount = 2
			},
			dlc_challenge_wizard_forest_break_seals = {
				text = "objective_foolhardy_forest_break_seals",
				mission_template_name = "collect",
				collect_amount = 3
			},
			dlc_challenge_wizard_town_ward_area = {
				text = "objective_foolhardy_town_ward_area",
				mission_template_name = "collect",
				collect_amount = 3
			},
			dlc_challenge_wizard_end_challenge = {
				mission_template_name = "goal",
				text = "objective_foolhardy_wizard_end_challenge_2"
			}
		},
		horde_settings_compositions = {
			event_boss = {
				{
					name = "champion",
					weight = 1,
					breeds = {
						"skaven_storm_vermin_champion",
						1
					}
				}
			},
			event_boss_temp = {
				{
					name = "ogre",
					weight = 1,
					breeds = {
						"skaven_rat_ogre",
						1
					}
				}
			},
			event_general_trickle_hub = {
				{
					name = "plain",
					weight = 6,
					breeds = {
						"skaven_slave",
						{
							6,
							10
						},
						"skaven_clan_rat",
						{
							8,
							10
						}
					}
				}
			},
			event_general_trickle = {
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
						},
						"skaven_storm_vermin_commander",
						{
							5,
							6
						}
					}
				}
			}
		},
		lorebook_pages = {},
		dialogue_lookup = {
			"dialogues/generated/lookup_dlc_challenge_wizard"
		},
		dialogue_settings = {
			dlc_challenge_wizard = {
				"dialogues/generated/dlc_challenge_wizard"
			}
		}
	}
}

return 
