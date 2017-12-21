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
	}
}

return 
