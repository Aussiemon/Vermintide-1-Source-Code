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
		product_label = "VTMAPPACK0000002",
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
					selected = "area_image_stromdorf_01",
					normal = "area_image_stromdorf_01"
				},
				banner_texture_size = {
					48,
					148
				}
			}
		},
		unlock_settings = {
			stromdorf = {
				id = "463795",
				index = 4,
				class = "UnlockDlc",
				purchase_type = "dlc"
			}
		},
		unlock_settings_xb1 = {
			stromdorf = {
				id = "EDC6C5F6-4564-4783-9853-8C69E23A9C32",
				index = 4,
				class = "UnlockDlc",
				purchase_type = "dlc"
			}
		},
		unlock_settings_ps4 = {
			stromdorf = {
				id = "6c4fa61ec654d8b64e6febcd126acd6c",
				index = 4,
				class = "UnlockDlc",
				purchase_type = "dlc"
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
		product_label = "",
		level_settings = "scripts/settings/level_settings_dlc_challenge_wizard",
		package_name = "resource_packages/dlcs/challenge_wizard/challenge_wizard",
		level_unlock_settings = "scripts/settings/level_unlock_settings_dlc_challenge_wizard",
		unlock_settings = {
			challenge_wizard = {
				class = "AlwaysUnlocked"
			}
		},
		unlock_settings_xb1 = {
			challenge_wizard = {
				class = "AlwaysLocked"
			}
		},
		unlock_settings_ps4 = {
			challenge_wizard = {
				class = "AlwaysLocked"
			}
		},
		weapons = {},
		breeds = {},
		behaviour_trees_precompiled = {},
		behaviour_tree_nodes = {},
		behaviour_trees = {},
		terror_event_blueprints = {
			challenge_pacing_off = {
				{
					"control_pacing",
					enable = false
				},
				{
					"control_specials",
					enable = false
				}
			},
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
	},
	reikwald = {
		level_settings = "scripts/settings/level_settings_dlc_reikwald",
		package_name = "resource_packages/dlcs/reikwald/reikwald",
		level_unlock_settings = "scripts/settings/level_unlock_settings_dlc_reikwald",
		area_settings = {
			reikwald = {
				area_icon_background_texture = "reikwald_location_icon",
				display_name = "dlc1_10_area_reikwald",
				sorting = 6,
				map_icon = "level_location_any_icon",
				area_icon_hover_texture = "reikwald_location_icon_glow",
				banner_texture = "reikwald_location_icon_banner",
				dlc_name = "reikwald",
				dlc_url = "http://store.steampowered.com/app/741420",
				level_image = "level_image_dlc_reikwald_forest",
				map_texture = "map_reikwald",
				map_position = {
					595,
					140
				},
				console_map_textures = {
					selected = "area_image_karak_azgaraz_01",
					normal = "area_image_karak_azgaraz_02"
				},
				banner_texture_size = {
					48,
					160
				}
			}
		},
		unlock_settings = {
			reikwald = {
				id = "741420",
				index = 5,
				class = "UnlockDlc",
				purchase_type = "dlc"
			}
		},
		unlock_settings_xb1 = {
			reikwald = {
				index = 5,
				purchase_type = "dlc",
				class = "UnlockDlc"
			}
		},
		unlock_settings_ps4 = {
			reikwald = {
				index = 5,
				purchase_type = "dlc",
				class = "UnlockDlc"
			}
		},
		weapons = {},
		breeds = {},
		behaviour_trees_precompiled = {},
		behaviour_tree_nodes = {},
		behaviour_trees = {},
		terror_event_blueprints = {
			reikwald_mid_event_start = {
				{
					"play_stinger",
					stinger_name = "enemy_horde_stinger"
				},
				{
					"control_pacing",
					enable = false
				}
			},
			reikwald_mid_event = {
				{
					"set_master_event_running",
					name = "reikwald_mid_starting"
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
					"spawn_at_raw",
					spawner_id = "reikwald_mid_spawner_raw01",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "reikwald_mid_spawner_raw02",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "reikwald_mid_spawner_raw03",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"event_horde",
					spawner_id = "reikwald_mid_spawner",
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
						3,
						4
					}
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_medium"
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_large"
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_mid_spawner",
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
						3,
						4
					}
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_medium"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"continue_when",
					duration = 50,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"flow_event",
					flow_event_name = "reikwald_mid_event_done"
				},
				{
					"control_pacing",
					enable = true
				}
			},
			reikwald_mid_event_loop = {
				{
					"control_pacing",
					enable = false
				},
				{
					"control_specials",
					enable = false
				},
				{
					"set_master_event_running",
					name = "reikwald_mid_starting"
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_mid_spawner",
					composition_type = "event_medium"
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
					duration = 2
				},
				{
					"flow_event",
					flow_event_name = "reikwald_mid_event_loop_done"
				}
			},
			reikwald_mid_event_loop_extra_spice = {
				{
					"set_master_event_running",
					name = "reikwald_mid_starting"
				},
				{
					"event_horde",
					spawner_id = "reikwald_mid_spawner_spice",
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
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "reikwald_mid_spawner_spice",
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
					duration = 5
				},
				{
					"flow_event",
					flow_event_name = "reikwald_mid_event_loop_extra_spice_done"
				}
			},
			reikwald_end_event = {
				{
					"set_master_event_running",
					name = "reikwald_end_starting"
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
					"play_stinger",
					stinger_name = "enemy_horde_stinger"
				},
				{
					"event_horde",
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_large"
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_medium"
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"spawn_at_raw",
					spawner_id = "reikwald_end_spawner_raw01",
					breed_name = "skaven_rat_ogre"
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_small"
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_medium"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_end_spawner",
					composition_type = "event_medium"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"continue_when",
					duration = 50,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"control_pacing",
					enable = true
				}
			},
			reikwald_end_event_loop_extra_spice = {
				{
					"set_master_event_running",
					name = "reikwald_end_spice_starting"
				},
				{
					"event_horde",
					spawner_id = "reikwald_end_spawner_spice",
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
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "reikwald_end_spawner_spice",
					composition_type = "event_smaller"
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
					duration = 5
				},
				{
					"flow_event",
					flow_event_name = "reikwald_end_event_loop_extra_spice_done"
				}
			},
			reikwald_wharf_event = {
				{
					"set_master_event_running",
					name = "reikwald_wharf_starting"
				},
				{
					"play_stinger",
					stinger_name = "enemy_horde_stinger"
				},
				{
					"spawn_at_raw",
					spawner_id = "reikwald_wharf_spawner_raw01",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "reikwald_wharf_spawner_raw02",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "reikwald_wharf_spawner_raw03",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"event_horde",
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_medium"
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_small"
				},
				{
					"continue_when",
					duration = 20,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_docks_warehouse_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"continue_when",
					duration = 50,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_docks_warehouse_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"continue_when",
					duration = 50,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_docks_warehouse_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_small"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"continue_when",
					duration = 50,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				}
			},
			reikwald_wharf_event_part2 = {
				{
					"set_master_event_running",
					name = "reikwald_wharf_starting"
				},
				{
					"event_horde",
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_large"
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_docks_warehouse_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"continue_when",
					duration = 50,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_docks_warehouse_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					limit_spawners = 2,
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_generic_long_level_extra_spice"
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_large"
				},
				{
					"continue_when",
					duration = 40,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						9,
						11
					}
				},
				{
					"event_horde",
					spawner_id = "reikwald_wharf_spawner",
					composition_type = "event_medium"
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"delay",
					duration = {
						3,
						4
					}
				},
				{
					"continue_when",
					duration = 50,
					condition = function (t)
						return count_event_breed("skaven_clan_rat") < 5 and count_event_breed("skaven_slave") < 5
					end
				},
				{
					"control_pacing",
					enable = true
				}
			},
			reikwald_wharf_event_loop_extra_spice = {
				{
					"set_master_event_running",
					name = "reikwald_wharf_spice_starting"
				},
				{
					"event_horde",
					spawner_id = "reikwald_wharf_spawner_spice",
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
					duration = 5
				},
				{
					"event_horde",
					spawner_id = "reikwald_wharf_spawner_spice",
					composition_type = "event_smaller"
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
					duration = 5
				},
				{
					"flow_event",
					flow_event_name = "reikwald_wharf_event_loop_extra_spice_done"
				}
			},
			reikwald_river_plaza_01 = {
				{
					"delay",
					duration = 5
				}
			},
			reikwald_river_sea_battle_landside_01 = {
				{
					"control_pacing",
					enable = false
				},
				{
					"control_specials",
					enable = false
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_landside_raw_01",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_landside_raw_01",
					breed_name = "skaven_ratling_gunner"
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_landside_raw_01",
					breed_name = "skaven_poison_wind_globadier"
				}
			},
			reikwald_river_sea_battle_right_01 = {
				{
					"event_horde",
					spawner_id = "sea_battle_right_01",
					composition_type = "event_medium"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "sea_battle_right_01",
					composition_type = "event_large"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "reikwald_river_sea_battle_right_01_done"
				}
			},
			reikwald_river_sea_battle_left_01 = {
				{
					"event_horde",
					spawner_id = "sea_battle_left_01",
					composition_type = "event_medium"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "sea_battle_left_01",
					composition_type = "event_large"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
					end
				},
				{
					"flow_event",
					flow_event_name = "reikwald_river_sea_battle_left_01_done"
				}
			},
			reikwald_river_sea_battle_right_02 = {
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_right_02_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_right_02_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"event_horde",
					spawner_id = "sea_battle_right_02",
					composition_type = "event_medium"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "sea_battle_right_02",
					composition_type = "event_large"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"flow_event",
					flow_event_name = "reikwald_river_sea_battle_right_02_done"
				}
			},
			reikwald_river_sea_battle_left_02 = {
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_left_02_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_left_02_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"event_horde",
					spawner_id = "sea_battle_left_02",
					composition_type = "event_medium"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "sea_battle_left_02",
					composition_type = "event_large"
				},
				{
					"flow_event",
					flow_event_name = "reikwald_river_sea_battle_left_02_done"
				}
			},
			reikwald_river_sea_battle_right_03 = {
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_right_03_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_right_03_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"event_horde",
					spawner_id = "sea_battle_right_03",
					composition_type = "event_medium"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_right_03_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_right_03_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "sea_battle_right_03",
					composition_type = "event_large"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"flow_event",
					flow_event_name = "reikwald_river_sea_battle_right_03_done"
				}
			},
			reikwald_river_sea_battle_left_03 = {
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_left_03_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_left_03_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"event_horde",
					spawner_id = "sea_battle_left_03",
					composition_type = "event_small"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"spawn_at_raw",
					spawner_id = "sea_battle_left_03_storm",
					breed_name = "skaven_storm_vermin_commander"
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"event_horde",
					spawner_id = "sea_battle_left_03",
					composition_type = "event_large"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 4 and count_breed("skaven_slave") < 4 and count_breed("skaven_storm_vermin_commander") < 4
					end
				},
				{
					"flow_event",
					flow_event_name = "reikwald_river_sea_battle_left_03_done"
				}
			},
			reikwald_river_sea_battle_front_03 = {
				{
					"event_horde",
					spawner_id = "sea_battle_front_03",
					composition_type = "event_small"
				},
				{
					"delay",
					duration = 10
				},
				{
					"continue_when",
					duration = 80,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 2 and count_breed("skaven_slave") < 2
					end
				},
				{
					"event_horde",
					spawner_id = "sea_battle_front_03",
					composition_type = "event_small"
				},
				{
					"delay",
					duration = 10
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
					flow_event_name = "reikwald_river_sea_battle_front_03_done"
				}
			},
			reikwald_river_pacing_on = {
				{
					"control_pacing",
					enable = true
				},
				{
					"control_specials",
					enable = true
				}
			},
			reikwald_river_pacing_off = {
				{
					"control_pacing",
					enable = false
				},
				{
					"control_specials",
					enable = false
				}
			},
			reikwald_river_sea_battle_replace_left_01 = {
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_01_clan_01",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_01_clan_02",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_01_clan_03",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_01_clan_04",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_01_captain",
					breed_name = "skaven_storm_vermin_commander"
				}
			},
			reikwald_river_sea_battle_replace_right_01 = {
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_01_clan_01",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_01_clan_02",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_01_clan_03",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_01_clan_04",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_01_captain",
					breed_name = "skaven_storm_vermin_commander"
				}
			},
			reikwald_river_sea_battle_replace_left_02 = {
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_02_clan_01",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_02_clan_02",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_02_clan_03",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_02_clan_04",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_02_captain",
					breed_name = "skaven_storm_vermin_commander"
				}
			},
			reikwald_river_sea_battle_replace_right_02 = {
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_02_clan_01",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_02_clan_02",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_02_clan_03",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_02_clan_04",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_02_captain",
					breed_name = "skaven_storm_vermin_commander"
				}
			},
			reikwald_river_sea_battle_replace_left_03 = {
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_03_clan_01",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_03_clan_02",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_03_clan_03",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_03_clan_04",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_left_03_captain",
					breed_name = "skaven_storm_vermin_commander"
				}
			},
			reikwald_river_sea_battle_replace_right_03 = {
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_03_clan_01",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_03_clan_02",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_03_clan_03",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_03_clan_04",
					breed_name = "skaven_clan_rat"
				},
				{
					"spawn_at_raw",
					spawner_id = "raw_skaven_ship_right_03_captain",
					breed_name = "skaven_storm_vermin_commander"
				}
			},
			reikwald_river_shore_crash_01 = {
				{
					"event_horde",
					spawner_id = "shore_crash_01",
					composition_type = "event_reikwald_shore_mix"
				}
			},
			reikwald_river_gauntlet_01 = {
				{
					"event_horde",
					spawner_id = "gauntlet_01_front",
					composition_type = "event_reikwald_gauntlet_front_mix"
				},
				{
					"event_horde",
					spawner_id = "gauntlet_01",
					composition_type = "event_reikwald_gauntlet_mix"
				},
				{
					"delay",
					duration = 5
				},
				{
					"continue_when",
					duration = 30,
					condition = function (t)
						return count_breed("skaven_clan_rat") < 5 and count_breed("skaven_slave") < 5
					end
				},
				{
					"event_horde",
					spawner_id = "gauntlet_01",
					composition_type = "event_reikwald_gauntlet_mix"
				}
			},
			reset_event_right_01 = {
				{
					"reset_event_horde",
					spawner_id = "sea_battle_right_01"
				}
			},
			reset_event_left_01 = {
				{
					"reset_event_horde",
					spawner_id = "sea_battle_left_01"
				}
			},
			reset_event_right_02 = {
				{
					"reset_event_horde",
					spawner_id = "sea_battle_right_02"
				}
			},
			reset_event_left_02 = {
				{
					"reset_event_horde",
					spawner_id = "sea_battle_left_02"
				}
			},
			reset_event_right_03 = {
				{
					"reset_event_horde",
					spawner_id = "sea_battle_right_03"
				}
			},
			reset_event_left_03 = {
				{
					"reset_event_horde",
					spawner_id = "sea_battle_left_03"
				}
			}
		},
		weighted_random_terror_events = {},
		missions = {
			dlc1_10_mission_forest_reikwald_reach_river = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_forest_reikwald_reach_river"
			},
			dlc1_10_mission_forest_reikwald_through_camp = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_forest_reikwald_through_camp"
			},
			dlc1_10_mission_forest_reikwald_follow_river = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_forest_reikwald_follow_river"
			},
			dlc1_10_mission_forest_reikwald_extinguish = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_forest_reikwald_extinguish"
			},
			dlc1_10_mission_forest_reikwald_find_ship = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_forest_reikwald_find_ship"
			},
			dlc1_10_mission_reik_find_dawnrunner = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_reik_find_dawnrunner"
			},
			dlc1_10_mission_reik_find_a_way_out_01 = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_reik_find_a_way_out_01"
			},
			dlc1_10_mission_reik_find_a_way_out_02 = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_reik_find_a_way_out_02"
			},
			dlc1_10_mission_reik_goto_ship = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_reik_goto_ship"
			},
			dlc1_10_mission_reik_use_ship = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_reik_use_ship"
			},
			dlc1_10_mission_reik_search_dawnrunner = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_reik_search_dawnrunner"
			},
			dlc1_10_mission_reik_burn_everything_dawnrunner = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_reik_burn_everything_dawnrunner"
			},
			dlc1_10_mission_reik_search_thief = {
				mission_template_name = "goal",
				text = "dlc1_10_mission_reik_search_thief"
			}
		},
		dialogue_lookup = {
			"dialogues/generated/lookup_witch_hunter_reikwald_forest",
			"dialogues/generated/lookup_empire_soldier_reikwald_forest",
			"dialogues/generated/lookup_wood_elf_reikwald_forest",
			"dialogues/generated/lookup_bright_wizard_reikwald_forest",
			"dialogues/generated/lookup_dwarf_ranger_reikwald_forest",
			"dialogues/generated/lookup_witch_hunter_reikwald_river",
			"dialogues/generated/lookup_empire_soldier_reikwald_river",
			"dialogues/generated/lookup_wood_elf_reikwald_river",
			"dialogues/generated/lookup_bright_wizard_reikwald_river",
			"dialogues/generated/lookup_dwarf_ranger_reikwald_river"
		},
		dialogue_settings = {
			"dialogues/generated/witch_hunter_reikwald_forest",
			"dialogues/generated/empire_soldier_reikwald_forest",
			"dialogues/generated/wood_elf_reikwald_forest",
			"dialogues/generated/bright_wizard_reikwald_forest",
			"dialogues/generated/dwarf_ranger_reikwald_forest",
			"dialogues/generated/witch_hunter_reikwald_river",
			"dialogues/generated/empire_soldier_reikwald_river",
			"dialogues/generated/wood_elf_reikwald_river",
			"dialogues/generated/bright_wizard_reikwald_river",
			"dialogues/generated/dwarf_ranger_reikwald_river"
		},
		horde_settings_compositions = {
			event_reikwald_shore_mix = {
				{
					name = "few_stormvermins",
					weight = 1,
					breeds = {
						"skaven_storm_vermin_commander",
						{
							5,
							8
						}
					}
				},
				{
					name = "some_slaves",
					weight = 1,
					breeds = {
						"skaven_slave",
						{
							22,
							23
						}
					}
				},
				{
					name = "few_clanrats",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							5,
							6
						}
					}
				}
			},
			event_reikwald_gauntlet_mix = {
				{
					name = "some_slaves",
					weight = 1,
					breeds = {
						"skaven_slave",
						{
							27,
							29
						}
					}
				},
				{
					name = "few_clanrats",
					weight = 1,
					breeds = {
						"skaven_clan_rat",
						{
							6,
							7
						}
					}
				}
			},
			event_reikwald_gauntlet_front_mix = {
				{
					name = "few_stormvermins",
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
		lorebook_pages = {}
	}
}

return 
