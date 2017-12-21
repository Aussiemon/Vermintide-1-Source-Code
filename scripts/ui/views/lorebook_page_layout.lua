local AllImages = {
	"journal_image_01",
	"journal_image_02",
	"journal_image_03",
	"journal_image_04",
	"journal_image_05",
	"journal_image_06",
	"journal_image_07",
	"journal_image_08",
	"journal_image_09",
	"journal_image_11",
	"journal_image_12",
	"journal_image_13",
	"journal_image_14",
	"journal_image_15",
	"journal_image_16",
	"journal_image_17",
	"journal_image_18"
}
local SkavenImages = {
	"journal_image_01",
	"journal_image_02",
	"journal_image_03",
	"journal_image_05",
	"journal_image_06",
	"journal_image_08"
}
local EmpireImages = {
	"journal_image_04",
	"journal_image_07",
	"journal_image_09",
	"journal_image_11",
	"journal_image_12",
	"journal_image_13",
	"journal_image_14",
	"journal_image_15",
	"journal_image_16",
	"journal_image_17",
	"journal_image_18"
}
JournalPageLayout = {
	{
		tab_icon = "test_icon",
		category_name = "dlc1_3_journal_tab_title_gameplay",
		sub_categories = {
			{
				category_name = "dlc1_3_gi_items_title",
				page_text = "dlc1_3_gi_items",
				page_title = "dlc1_3_gi_items_title",
				sub_categories = {
					{
						category_name = "dlc1_3_gi_items_mundane_title",
						page_text = "dlc1_3_gi_items_mundane",
						page_title = "dlc1_3_gi_items_mundane_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_items_mundane_medical_supplies_title",
								page_text = "dlc1_3_gi_items_mundane_medical_supplies",
								page_title = "dlc1_3_gi_items_mundane_medical_supplies_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_items_mundane_healing_draught_title",
								page_text = "dlc1_3_gi_items_mundane_healing_draught",
								page_title = "dlc1_3_gi_items_mundane_healing_draught_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_items_magic_title",
						page_text = "dlc1_3_gi_items_magic",
						page_title = "dlc1_3_gi_items_magic_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_items_magic_potion_speed_title",
								page_text = "dlc1_3_gi_items_magic_potion_speed",
								page_title = "dlc1_3_gi_items_magic_potion_speed_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_items_magic_potion_strength_title",
								page_text = "dlc1_3_gi_items_magic_potion_strength",
								page_title = "dlc1_3_gi_items_magic_potion_strength_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_items_engineer_title",
						page_text = "dlc1_3_gi_items_engineer",
						page_title = "dlc1_3_gi_items_engineer_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_items_engineer_bomb_title",
								page_text = "dlc1_3_gi_items_engineer_bomb",
								page_title = "dlc1_3_gi_items_engineer_bomb_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_items_engineer_incendiary_bomb_title",
								page_text = "dlc1_3_gi_items_engineer_incendiary_bomb",
								page_title = "dlc1_3_gi_items_engineer_incendiary_bomb_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_items_secret_items_title",
						page_text = "dlc1_3_gi_items_secret_items",
						page_title = "dlc1_3_gi_items_secret_items_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_items_secret_items_tomes_title",
								page_text = "dlc1_3_gi_items_secret_items_tomes",
								page_title = "dlc1_3_gi_items_secret_items_tomes_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_items_secret_items_grimoires_title",
								page_text = "dlc1_3_gi_items_secret_items_grimoires",
								page_title = "dlc1_3_gi_items_secret_items_grimoires_title",
								images = AllImages
							}
						}
					}
				}
			},
			{
				category_name = "dlc1_3_gi_weapons_title",
				page_text = "dlc1_3_gi_weapons",
				page_title = "dlc1_3_gi_weapons_title",
				sub_categories = {
					{
						category_name = "dlc1_3_gi_weapons_bw_title",
						page_text = "dlc1_3_gi_weapons_bw",
						page_title = "dlc1_3_gi_weapons_bw_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_weapons_bw_sword_title",
								page_text = "dlc1_3_gi_weapons_bw_sword",
								page_title = "dlc1_3_gi_weapons_bw_sword_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_bw_sword_flaming_title",
								page_text = "dlc1_3_gi_weapons_bw_sword_flaming",
								page_title = "dlc1_3_gi_weapons_bw_sword_flaming_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_bw_mace_title",
								page_text = "dlc1_3_gi_weapons_bw_mace",
								page_title = "dlc1_3_gi_weapons_bw_mace_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_bw_staff_fireball_title",
								page_text = "dlc1_3_gi_weapons_bw_staff_fireball",
								page_title = "dlc1_3_gi_weapons_bw_staff_fireball_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_bw_staff_bolt_title",
								page_text = "dlc1_3_gi_weapons_bw_staff_bolt",
								page_title = "dlc1_3_gi_weapons_bw_staff_bolt_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_bw_staff_beam_title",
								page_text = "dlc1_3_gi_weapons_bw_staff_beam",
								page_title = "dlc1_3_gi_weapons_bw_staff_beam_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_bw_staff_conflagration_title",
								page_text = "dlc1_3_gi_weapons_bw_staff_conflagration",
								page_title = "dlc1_3_gi_weapons_bw_staff_conflagration_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_weapons_dr_title",
						page_text = "dlc1_3_gi_weapons_dr",
						page_title = "dlc1_3_gi_weapons_dr_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_weapons_dr_axe_title",
								page_text = "dlc1_3_gi_weapons_dr_axe",
								page_title = "dlc1_3_gi_weapons_dr_axe_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_hammer_title",
								page_text = "dlc1_3_gi_weapons_dr_hammer",
								page_title = "dlc1_3_gi_weapons_dr_hammer_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_axe_shield_title",
								page_text = "dlc1_3_gi_weapons_dr_axe_shield",
								page_title = "dlc1_3_gi_weapons_dr_axe_shield_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_hammer_shield_title",
								page_text = "dlc1_3_gi_weapons_dr_hammer_shield",
								page_title = "dlc1_3_gi_weapons_dr_hammer_shield_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_axe_2h_title",
								page_text = "dlc1_3_gi_weapons_dr_axe_2h",
								page_title = "dlc1_3_gi_weapons_dr_axe_2h_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_hammer_2h_title",
								page_text = "dlc1_3_gi_weapons_dr_hammer_2h",
								page_title = "dlc1_3_gi_weapons_dr_hammer_2h_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_crossbow_title",
								page_text = "dlc1_3_gi_weapons_dr_crossbow",
								page_title = "dlc1_3_gi_weapons_dr_crossbow_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_grudge_raker_title",
								page_text = "dlc1_3_gi_weapons_dr_grudge_raker",
								page_title = "dlc1_3_gi_weapons_dr_grudge_raker_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_handgun_title",
								page_text = "dlc1_3_gi_weapons_dr_handgun",
								page_title = "dlc1_3_gi_weapons_dr_handgun_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_dr_drakefire_pistols_title",
								page_text = "dlc1_3_gi_weapons_dr_drakefire_pistols",
								page_title = "dlc1_3_gi_weapons_dr_drakefire_pistols_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_weapons_es_title",
						page_text = "dlc1_3_gi_weapons_es",
						page_title = "dlc1_3_gi_weapons_es_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_weapons_es_sword_title",
								page_text = "dlc1_3_gi_weapons_es_sword",
								page_title = "dlc1_3_gi_weapons_es_sword_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_es_sword_shield_title",
								page_text = "dlc1_3_gi_weapons_es_sword_shield",
								page_title = "dlc1_3_gi_weapons_es_sword_shield_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_es_mace_title",
								page_text = "dlc1_3_gi_weapons_es_mace",
								page_title = "dlc1_3_gi_weapons_es_mace_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_es_mace_shield_title",
								page_text = "dlc1_3_gi_weapons_es_mace_shield",
								page_title = "dlc1_3_gi_weapons_es_mace_shield_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_es_hammer_2h_title",
								page_text = "dlc1_3_gi_weapons_es_hammer_2h",
								page_title = "dlc1_3_gi_weapons_es_hammer_2h_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_es_blunderbuss_title",
								page_text = "dlc1_3_gi_weapons_es_blunderbuss",
								page_title = "dlc1_3_gi_weapons_es_blunderbuss_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_es_handgun_title",
								page_text = "dlc1_3_gi_weapons_es_handgun",
								page_title = "dlc1_3_gi_weapons_es_handgun_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_es_repeater_handgun_title",
								page_text = "dlc1_3_gi_weapons_es_repeater_handgun",
								page_title = "dlc1_3_gi_weapons_es_repeater_handgun_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_weapons_wh_title",
						page_text = "dlc1_3_gi_weapons_wh",
						page_title = "dlc1_3_gi_weapons_wh_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_weapons_wh_rapier_title",
								page_text = "dlc1_3_gi_weapons_wh_rapier",
								page_title = "dlc1_3_gi_weapons_wh_rapier_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_wh_axe_title",
								page_text = "dlc1_3_gi_weapons_wh_axe",
								page_title = "dlc1_3_gi_weapons_wh_axe_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_wh_sword_2h_title",
								page_text = "dlc1_3_gi_weapons_wh_sword_2h",
								page_title = "dlc1_3_gi_weapons_wh_sword_2h_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_wh_crossbow_title",
								page_text = "dlc1_3_gi_weapons_wh_crossbow",
								page_title = "dlc1_3_gi_weapons_wh_crossbow_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_wh_pistol_repeater_title",
								page_text = "dlc1_3_gi_weapons_wh_pistol_repeater",
								page_title = "dlc1_3_gi_weapons_wh_pistol_repeater_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_wh_pistol_brace_title",
								page_text = "dlc1_3_gi_weapons_wh_pistol_brace",
								page_title = "dlc1_3_gi_weapons_wh_pistol_brace_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_weapons_ww_title",
						page_text = "dlc1_3_gi_weapons_ww",
						page_title = "dlc1_3_gi_weapons_ww_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_weapons_ww_sword_title",
								page_text = "dlc1_3_gi_weapons_ww_sword",
								page_title = "dlc1_3_gi_weapons_ww_sword_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_ww_sword_dual_title",
								page_text = "dlc1_3_gi_weapons_ww_sword_dual",
								page_title = "dlc1_3_gi_weapons_ww_sword_dual_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_ww_daggers_dual_title",
								page_text = "dlc1_3_gi_weapons_ww_daggers_dual",
								page_title = "dlc1_3_gi_weapons_ww_daggers_dual_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_ww_sword_dagger_title",
								page_text = "dlc1_3_gi_weapons_ww_sword_dagger",
								page_title = "dlc1_3_gi_weapons_ww_sword_dagger_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_ww_bow_swift_title",
								page_text = "dlc1_3_gi_weapons_ww_bow_swift",
								page_title = "dlc1_3_gi_weapons_ww_bow_swift_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_ww_bow_swift_hagbane_title",
								page_text = "dlc1_3_gi_weapons_ww_bow_swift_hagbane",
								page_title = "dlc1_3_gi_weapons_ww_bow_swift_hagbane_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_ww_bow_longbow_title",
								page_text = "dlc1_3_gi_weapons_ww_bow_longbow",
								page_title = "dlc1_3_gi_weapons_ww_bow_longbow_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_ww_bow_longbow_trueflight_title",
								page_text = "dlc1_3_gi_weapons_ww_bow_longbow_trueflight",
								page_title = "dlc1_3_gi_weapons_ww_bow_longbow_trueflight_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_weapons_stats_title",
						page_text = "dlc1_3_gi_weapons_stats",
						page_title = "dlc1_3_gi_weapons_stats_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_weapons_stats_damage_title",
								page_text = "dlc1_3_gi_weapons_stats_damage",
								page_title = "dlc1_3_gi_weapons_stats_damage_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_stats_speed_title",
								page_text = "dlc1_3_gi_weapons_stats_speed",
								page_title = "dlc1_3_gi_weapons_stats_speed_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_stats_targets_title",
								page_text = "dlc1_3_gi_weapons_stats_targets",
								page_title = "dlc1_3_gi_weapons_stats_targets_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_stats_knockback_title",
								page_text = "dlc1_3_gi_weapons_stats_knockback",
								page_title = "dlc1_3_gi_weapons_stats_knockback_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_stats_range_title",
								page_text = "dlc1_3_gi_weapons_stats_range",
								page_title = "dlc1_3_gi_weapons_stats_range_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_weapons_abilites_title",
						page_text = "dlc1_3_gi_weapons_abilites",
						page_title = "dlc1_3_gi_weapons_abilites_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_weapons_abilites_headshot_title",
								page_text = "dlc1_3_gi_weapons_abilites_headshot",
								page_title = "dlc1_3_gi_weapons_abilites_headshot_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_abilites_armour_piercing_title",
								page_text = "dlc1_3_gi_weapons_abilites_armour_piercing",
								page_title = "dlc1_3_gi_weapons_abilites_armour_piercing_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_weapons_abilites_burn_poison_title",
								page_text = "dlc1_3_gi_weapons_abilites_burn_poison",
								page_title = "dlc1_3_gi_weapons_abilites_burn_poison_title",
								images = AllImages
							}
						}
					}
				}
			},
			{
				category_name = "dlc1_3_gi_gameplay_title",
				page_text = "dlc1_3_gi_gameplay",
				page_title = "dlc1_3_gi_gameplay_title",
				sub_categories = {
					{
						category_name = "dlc1_3_gi_gameplay_overview_title",
						page_text = "dlc1_3_gi_gameplay_overview",
						page_title = "dlc1_3_gi_gameplay_overview_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_gameplay_overview_tutorial_title",
								page_text = "dlc1_3_gi_gameplay_overview_tutorial",
								page_title = "dlc1_3_gi_gameplay_overview_tutorial_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_gameplay_melee_attack_title",
						page_text = "dlc1_3_gi_gameplay_melee_attack",
						page_title = "dlc1_3_gi_gameplay_melee_attack_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_gameplay_melee_attack_normal_title",
								page_text = "dlc1_3_gi_gameplay_melee_attack_normal",
								page_title = "dlc1_3_gi_gameplay_melee_attack_normal_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_melee_attack_combo_chain_title",
								page_text = "dlc1_3_gi_gameplay_melee_attack_combo_chain",
								page_title = "dlc1_3_gi_gameplay_melee_attack_combo_chain_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_melee_attack_charged_title",
								page_text = "dlc1_3_gi_gameplay_melee_attack_charged",
								page_title = "dlc1_3_gi_gameplay_melee_attack_charged_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_gameplay_ranged_attack_title",
						page_text = "dlc1_3_gi_gameplay_ranged_attack",
						page_title = "dlc1_3_gi_gameplay_ranged_attack_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_gameplay_ranged_attack_normal_title",
								page_text = "dlc1_3_gi_gameplay_ranged_attack_normal",
								page_title = "dlc1_3_gi_gameplay_ranged_attack_normal_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_ranged_attack_charged_title",
								page_text = "dlc1_3_gi_gameplay_ranged_attack_charged",
								page_title = "dlc1_3_gi_gameplay_ranged_attack_charged_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_gameplay_defense_title",
						page_text = "dlc1_3_gi_gameplay_defense",
						page_title = "dlc1_3_gi_gameplay_defense_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_gameplay_dodge_title",
								page_text = "dlc1_3_gi_gameplay_dodge",
								page_title = "dlc1_3_gi_gameplay_dodge_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_parry_title",
								page_text = "dlc1_3_gi_gameplay_parry",
								page_title = "dlc1_3_gi_gameplay_parry_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_block_title",
								page_text = "dlc1_3_gi_gameplay_block",
								page_title = "dlc1_3_gi_gameplay_block_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_push_title",
								page_text = "dlc1_3_gi_gameplay_push",
								page_title = "dlc1_3_gi_gameplay_push_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_gameplay_life_and_death_title",
						page_text = "dlc1_3_gi_gameplay_life_and_death",
						page_title = "dlc1_3_gi_gameplay_life_and_death_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_gameplay_health_kd_title",
								page_text = "dlc1_3_gi_gameplay_health_kd",
								page_title = "dlc1_3_gi_gameplay_health_kd_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_revive_bleed_title",
								page_text = "dlc1_3_gi_gameplay_revive_bleed",
								page_title = "dlc1_3_gi_gameplay_revive_bleed_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_gameplay_energy_management_title",
						page_text = "dlc1_3_gi_gameplay_energy_management",
						page_title = "dlc1_3_gi_gameplay_energy_management_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_gameplay_stamina_title",
								page_text = "dlc1_3_gi_gameplay_stamina",
								page_title = "dlc1_3_gi_gameplay_stamina_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_overcharge_title",
								page_text = "dlc1_3_gi_gameplay_overcharge",
								page_title = "dlc1_3_gi_gameplay_overcharge_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_gameplay_advanced_combat_title",
						page_text = "dlc1_3_gi_gameplay_advanced_combat",
						page_title = "dlc1_3_gi_gameplay_advanced_combat_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_gameplay_enemy_armour_title",
								page_text = "dlc1_3_gi_gameplay_enemy_armour",
								page_title = "dlc1_3_gi_gameplay_enemy_armour_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_headshot_title",
								page_text = "dlc1_3_gi_gameplay_headshot",
								page_title = "dlc1_3_gi_gameplay_headshot_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_stagger_title",
								page_text = "dlc1_3_gi_gameplay_stagger",
								page_title = "dlc1_3_gi_gameplay_stagger_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_hit_interrupts_title",
								page_text = "dlc1_3_gi_gameplay_hit_interrupts",
								page_title = "dlc1_3_gi_gameplay_hit_interrupts_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_gameplay_friendly_fire_title",
								page_text = "dlc1_3_gi_gameplay_friendly_fire",
								page_title = "dlc1_3_gi_gameplay_friendly_fire_title",
								images = AllImages
							}
						}
					}
				}
			},
			{
				category_name = "dlc1_3_gi_progression_title",
				page_text = "dlc1_3_gi_progression",
				page_title = "dlc1_3_gi_progression_title",
				sub_categories = {
					{
						category_name = "dlc1_3_gi_progression_levels_and_xp_title",
						page_text = "dlc1_3_gi_progression_levels_and_xp",
						page_title = "dlc1_3_gi_progression_levels_and_xp_title",
						images = AllImages
					},
					{
						category_name = "dlc1_3_gi_progression_dice_game_title",
						page_text = "dlc1_3_gi_progression_dice_game",
						page_title = "dlc1_3_gi_progression_dice_game_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_progression_dice_game_loot_dicetitle",
								page_text = "dlc1_3_gi_progression_dice_game_loot_dice",
								page_title = "dlc1_3_gi_progression_dice_game_loot_dicetitle",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_progression_shrine_of_solace_title",
						page_text = "dlc1_3_gi_progression_shrine_of_solace",
						page_title = "dlc1_3_gi_progression_shrine_of_solace_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_progression_shrine_pray_title",
								page_text = "dlc1_3_gi_progression_shrine_pray",
								page_title = "dlc1_3_gi_progression_shrine_pray_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_progression_shrine_offer_title",
								page_text = "dlc1_3_gi_progression_shrine_offer",
								page_title = "dlc1_3_gi_progression_shrine_offer_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_progression_shrine_invocate_title",
								page_text = "dlc1_3_gi_progression_shrine_invocate",
								page_title = "dlc1_3_gi_progression_shrine_invocate_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_progression_forge_title",
						page_text = "dlc1_3_gi_progression_forge",
						page_title = "dlc1_3_gi_progression_forge_title",
						sub_categories = {
							{
								category_name = "dlc1_3_gi_progression_forge_fuse_title",
								page_text = "dlc1_3_gi_progression_forge_fuse",
								page_title = "dlc1_3_gi_progression_forge_fuse_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_progression_forge_upgrade_title",
								page_text = "dlc1_3_gi_progression_forge_upgrade",
								page_title = "dlc1_3_gi_progression_forge_upgrade_title",
								images = AllImages
							},
							{
								category_name = "dlc1_3_gi_progression_forge_salvage_title",
								page_text = "dlc1_3_gi_progression_forge_salvage",
								page_title = "dlc1_3_gi_progression_forge_salvage_title",
								images = AllImages
							}
						}
					},
					{
						category_name = "dlc1_3_gi_progression_loot_title",
						page_text = "dlc1_3_gi_progression_loot",
						page_title = "dlc1_3_gi_progression_loot_title",
						images = AllImages
					}
				}
			}
		}
	},
	{
		tab_icon = "test_icon_2",
		category_name = "dlc1_3_journal_tab_title_lorebook",
		sub_categories = {
			{
				category_name = "dlc1_3_lb_vt_characters_title",
				category_image = "journal_category_image_characters",
				page_title = "dlc1_3_lb_vt_characters_title",
				sub_categories = {
					{
						category_name = "dlc1_3_lb_vt_characters_heroes_title",
						page_text = "dlc1_3_lb_vt_characters_heroes",
						page_title = "dlc1_3_lb_vt_characters_heroes_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_characters_heroes_wh_title",
								page_text = "dlc1_3_lb_vt_characters_heroes_wh",
								page_title = "dlc1_3_lb_vt_characters_heroes_wh_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_characters_heroes_wh_1",
										category_name = "dlc1_3_lb_vt_characters_heroes_wh_1_title",
										page_title = "dlc1_3_lb_vt_characters_heroes_wh_1_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_characters_heroes_wh_2",
										category_name = "dlc1_3_lb_vt_characters_heroes_wh_2_title",
										page_title = "dlc1_3_lb_vt_characters_heroes_wh_2_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_characters_heroes_bw_title",
								page_text = "dlc1_3_lb_vt_characters_heroes_bw",
								page_title = "dlc1_3_lb_vt_characters_heroes_bw_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_characters_heroes_bw_1",
										category_name = "dlc1_3_lb_vt_characters_heroes_bw_1_title",
										page_title = "dlc1_3_lb_vt_characters_heroes_bw_1_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_characters_heroes_bw_2",
										category_name = "dlc1_3_lb_vt_characters_heroes_bw_2_title",
										page_title = "dlc1_3_lb_vt_characters_heroes_bw_2_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									}
								}
							},
							{
								page_text = "dlc1_3_lb_vt_characters_heroes_ww",
								category_name = "dlc1_3_lb_vt_characters_heroes_ww_title",
								page_title = "dlc1_3_lb_vt_characters_heroes_ww_title",
								unlock_level = "whitebox_ai",
								images = EmpireImages
							},
							{
								category_name = "dlc1_3_lb_vt_characters_heroes_dr_title",
								page_text = "dlc1_3_lb_vt_characters_heroes_dr",
								page_title = "dlc1_3_lb_vt_characters_heroes_dr_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_characters_heroes_dr_1",
										category_name = "dlc1_3_lb_vt_characters_heroes_dr_1_title",
										page_title = "dlc1_3_lb_vt_characters_heroes_dr_1_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_characters_heroes_dr_2",
										category_name = "dlc1_3_lb_vt_characters_heroes_dr_2_title",
										page_title = "dlc1_3_lb_vt_characters_heroes_dr_2_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_characters_heroes_es_title",
								page_text = "dlc1_3_lb_vt_characters_heroes_es",
								page_title = "dlc1_3_lb_vt_characters_heroes_es_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_characters_heroes_es_1",
										category_name = "dlc1_3_lb_vt_characters_heroes_es_1_title",
										page_title = "dlc1_3_lb_vt_characters_heroes_es_1_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_characters_heroes_es_2",
										category_name = "dlc1_3_lb_vt_characters_heroes_es_2_title",
										page_title = "dlc1_3_lb_vt_characters_heroes_es_2_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									}
								}
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_characters_npc_title",
						page_text = "dlc1_3_lb_vt_characters_npc",
						page_title = "dlc1_3_lb_vt_characters_npc_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_characters_npc_nik_title",
								page_text = "dlc1_3_lb_vt_characters_npc_nik",
								page_title = "dlc1_3_lb_vt_characters_npc_nik_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_characters_npc_nik_1",
										category_name = "dlc1_3_lb_vt_characters_npc_nik_1_title",
										page_title = "dlc1_3_lb_vt_characters_npc_nik_1_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_characters_npc_nik_2",
										category_name = "dlc1_3_lb_vt_characters_npc_nik_2_title",
										page_title = "dlc1_3_lb_vt_characters_npc_nik_2_title",
										unlock_level = "whitebox_ai",
										images = EmpireImages
									}
								}
							},
							{
								page_text = "dlc1_3_lb_vt_characters_npc_nfl",
								category_name = "dlc1_3_lb_vt_characters_npc_nfl_title",
								page_title = "dlc1_3_lb_vt_characters_npc_nfl_title",
								unlock_level = "whitebox_ai",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_characters_npc_ntw",
								category_name = "dlc1_3_lb_vt_characters_npc_ntw_title",
								page_title = "dlc1_3_lb_vt_characters_npc_ntw_title",
								unlock_level = "whitebox_ai",
								images = EmpireImages
							}
						}
					}
				}
			},
			{
				category_name = "dlc1_3_lb_vt_skaven_title",
				category_image = "journal_category_image_skaven",
				page_title = "dlc1_3_lb_vt_skaven_title",
				sub_categories = {
					{
						category_name = "dlc1_3_lb_vt_skaven_beastiary_title",
						page_text = "dlc1_3_lb_vt_skaven_beastiary",
						page_title = "dlc1_3_lb_vt_skaven_beastiary_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_skaven_beastiary_core_title",
								page_text = "dlc1_3_lb_vt_skaven_beastiary_core",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_core_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_core_clanrat",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_core_clanrat_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_core_clanrat_title",
										unlock_level = "magnus",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_core_skavenslave",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_core_skavenslave_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_core_skavenslave_title",
										unlock_level = "magnus",
										images = SkavenImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_skaven_beastiary_special_title",
								page_text = "dlc1_3_lb_vt_skaven_beastiary_special",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_special_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_special_stormvermin",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_special_stormvermin_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_special_stormvermin_title",
										unlock_level = "magnus",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_special_ratling_gunner",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_special_ratling_gunner_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_special_ratling_gunner_title",
										unlock_level = "tunnels",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_special_gutter_runner",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_special_gutter_runner_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_special_gutter_runner_title",
										unlock_level = "wizard",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_special_pack_master",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_special_pack_master_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_special_pack_master_title",
										unlock_level = "merchant",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_special_globadier",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_special_globadier_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_special_globadier_title",
										unlock_level = "cemetery",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_loot_rat",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_loot_rat_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_loot_rat_title",
										unlock_level = "magnus",
										images = SkavenImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_skaven_beastiary_rare_title",
								page_text = "dlc1_3_lb_vt_skaven_beastiary_rare",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_rare_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_rare_rat_ogre",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_rare_rat_ogre_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_rare_rat_ogre_title",
										unlock_level = "farm",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_beastiary_rare_grey_seer",
										category_name = "dlc1_3_lb_vt_skaven_beastiary_rare_grey_seer_title",
										page_title = "dlc1_3_lb_vt_skaven_beastiary_rare_grey_seer_title",
										unlock_level = "end_boss",
										images = SkavenImages
									}
								}
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_skaven_characters_title",
						page_text = "dlc1_3_lb_vt_skaven_characters",
						page_title = "dlc1_3_lb_vt_skaven_characters_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_skaven_characters_rasknitt",
								category_name = "dlc1_3_lb_vt_skaven_characters_rasknitt_title",
								page_title = "dlc1_3_lb_vt_skaven_characters_rasknitt_title",
								unlock_level = "end_boss",
								images = SkavenImages
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_skaven_history_title",
						page_text = "dlc1_3_lb_vt_skaven_history",
						page_title = "dlc1_3_lb_vt_skaven_history_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_skaven_history_early_history_title",
								page_text = "dlc1_3_lb_vt_skaven_history_early_history",
								page_title = "dlc1_3_lb_vt_skaven_history_early_history_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_skaven_history_origins",
										category_name = "dlc1_3_lb_vt_skaven_history_origins_title",
										page_title = "dlc1_3_lb_vt_skaven_history_origins_title",
										unlock_level = "magnus",
										images = SkavenImages
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_kazvar_title",
										page_text = "dlc1_3_lb_vt_skaven_history_kazvar",
										page_title = "dlc1_3_lb_vt_skaven_history_kazvar_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_1",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_1_title",
												unlock_level = "merchant",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_2",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_2_title",
												unlock_level = "bridge",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_3",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_3_title",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_3_title",
												unlock_level = "city_walls",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_4",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_4_title",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_4_title",
												unlock_level = "docks_short_level",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_5",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_5_title",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_5_title",
												unlock_level = "courtyard_level",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_6",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_6_title",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_6_title",
												unlock_level = "farm",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_7",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_7_title",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_7_title",
												unlock_level = "wizard",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_8",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_8_title",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_8_title",
												unlock_level = "cemetery",
												images = SkavenImages
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_title",
										page_text = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight",
										page_title = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_1",
												category_name = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_1_title",
												unlock_level = "farm",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_2",
												category_name = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_2_title",
												unlock_level = "cemetery",
												images = SkavenImages
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_lords_of_decay_title",
										page_text = "dlc1_3_lb_vt_skaven_history_lords_of_decay",
										page_title = "dlc1_3_lb_vt_skaven_history_lords_of_decay_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_lords_of_decay_1",
												category_name = "dlc1_3_lb_vt_skaven_history_lords_of_decay_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_lords_of_decay_1_title",
												unlock_level = "cemetery",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_lords_of_decay_2",
												category_name = "dlc1_3_lb_vt_skaven_history_lords_of_decay_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_lords_of_decay_2_title",
												unlock_level = "sewers_short",
												images = SkavenImages
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_great_migration",
										category_name = "dlc1_3_lb_vt_skaven_history_great_migration_title",
										page_title = "dlc1_3_lb_vt_skaven_history_great_migration_title",
										unlock_level = "wizard",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_cripple_peak",
										category_name = "dlc1_3_lb_vt_skaven_history_cripple_peak_title",
										page_title = "dlc1_3_lb_vt_skaven_history_cripple_peak_title",
										unlock_level = "farm",
										images = SkavenImages
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_death_of_nagash_title",
										page_text = "dlc1_3_lb_vt_skaven_history_death_of_nagash",
										page_title = "dlc1_3_lb_vt_skaven_history_death_of_nagash_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_death_of_nagash_1",
												category_name = "dlc1_3_lb_vt_skaven_history_death_of_nagash_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_death_of_nagash_1_title",
												unlock_level = "cemetery",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_death_of_nagash_2",
												category_name = "dlc1_3_lb_vt_skaven_history_death_of_nagash_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_death_of_nagash_2_title",
												unlock_level = "city_walls",
												images = SkavenImages
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_rikek",
										category_name = "dlc1_3_lb_vt_skaven_history_rikek_title",
										page_title = "dlc1_3_lb_vt_skaven_history_rikek_title",
										unlock_level = "docks_short_level",
										images = SkavenImages
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_title",
										page_text = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens",
										page_title = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_1",
												category_name = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_1_title",
												unlock_level = "forest_ambush",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_2",
												category_name = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_2_title",
												unlock_level = "docks_short_level",
												images = SkavenImages
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_first_civil_war_title",
										page_text = "dlc1_3_lb_vt_skaven_history_first_civil_war",
										page_title = "dlc1_3_lb_vt_skaven_history_first_civil_war_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_first_civil_war_1",
												category_name = "dlc1_3_lb_vt_skaven_history_first_civil_war_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_first_civil_war_1_title",
												unlock_level = "merchant",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_first_civil_war_2",
												category_name = "dlc1_3_lb_vt_skaven_history_first_civil_war_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_first_civil_war_2_title",
												unlock_level = "courtyard_level",
												images = SkavenImages
											}
										}
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_skaven_history_later_history_title",
								page_text = "dlc1_3_lb_vt_skaven_history_later_history",
								page_title = "dlc1_3_lb_vt_skaven_history_later_history_title",
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_skaven_history_black_plague_title",
										page_text = "dlc1_3_lb_vt_skaven_history_black_plague",
										page_title = "dlc1_3_lb_vt_skaven_history_black_plague_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_black_plague_1",
												category_name = "dlc1_3_lb_vt_skaven_history_black_plague_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_1_title",
												unlock_level = "tunnels",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_black_plague_2",
												category_name = "dlc1_3_lb_vt_skaven_history_black_plague_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_2_title",
												unlock_level = "cemetery",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_black_plague_3",
												category_name = "dlc1_3_lb_vt_skaven_history_black_plague_3_title",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_3_title",
												unlock_level = "sewers_short",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_black_plague_4",
												category_name = "dlc1_3_lb_vt_skaven_history_black_plague_4_title",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_4_title",
												unlock_level = "merchant",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_black_plague_5",
												category_name = "dlc1_3_lb_vt_skaven_history_black_plague_5_title",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_5_title",
												unlock_level = "farm",
												images = SkavenImages
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_red_pox",
										category_name = "dlc1_3_lb_vt_skaven_history_red_pox_title",
										page_title = "dlc1_3_lb_vt_skaven_history_red_pox_title",
										unlock_level = "tunnels",
										images = SkavenImages
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_second_civil_war_title",
										page_text = "dlc1_3_lb_vt_skaven_history_second_civil_war",
										page_title = "dlc1_3_lb_vt_skaven_history_second_civil_war_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_second_civil_war_1",
												category_name = "dlc1_3_lb_vt_skaven_history_second_civil_war_title_1",
												page_title = "dlc1_3_lb_vt_skaven_history_second_civil_war_title_1",
												unlock_level = "merchant",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_second_civil_war_2",
												category_name = "dlc1_3_lb_vt_skaven_history_second_civil_war_title_2",
												page_title = "dlc1_3_lb_vt_skaven_history_second_civil_war_title_2",
												unlock_level = "sewers_short",
												images = SkavenImages
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_title",
										page_text = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us",
										page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_1",
												category_name = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_1_title",
												unlock_level = "tunnels",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_2",
												category_name = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_2_title",
												unlock_level = "wizard",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_3",
												category_name = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_3_title",
												page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_3_title",
												unlock_level = "sewers_short",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_4",
												category_name = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_4_title",
												page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_4_title",
												unlock_level = "end_boss",
												images = SkavenImages
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_title",
										page_text = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things",
										page_title = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_1",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_1_title",
												unlock_level = "merchant",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_2",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_2_title",
												unlock_level = "tunnels",
												images = SkavenImages
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_title",
										page_text = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks",
										page_title = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_1",
												category_name = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_1_title",
												unlock_level = "cemetery",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_2",
												category_name = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_2_title",
												unlock_level = "forest_ambush",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_3",
												category_name = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_3_title",
												page_title = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_3_title",
												unlock_level = "docks_short_level",
												images = SkavenImages
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_war_with_green_things",
										category_name = "dlc1_3_lb_vt_skaven_history_war_with_green_things_title",
										page_title = "dlc1_3_lb_vt_skaven_history_war_with_green_things_title",
										unlock_level = "forest_ambush",
										images = SkavenImages
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_title",
										page_text = "dlc1_3_lb_vt_skaven_history_attack_on_nuln",
										page_title = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_1",
												category_name = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_1_title",
												unlock_level = "city_walls",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_2",
												category_name = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_2_title",
												unlock_level = "merchant",
												images = SkavenImages
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_title",
										page_text = "dlc1_3_lb_vt_skaven_history_war_with_elf_things",
										page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_1",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_1_title",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_1_title",
												unlock_level = "forest_ambush",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_2",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_2_title",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_2_title",
												unlock_level = "merchant",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_3",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_3_title",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_3_title",
												unlock_level = "sewers_short",
												images = SkavenImages
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_4",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_4_title",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_4_title",
												unlock_level = "end_boss",
												images = SkavenImages
											}
										}
									}
								}
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_skaven_clans_title",
						page_text = "dlc1_3_lb_vt_skaven_clans",
						page_title = "dlc1_3_lb_vt_skaven_clans_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_skaven_clans_clan_fester",
								category_name = "dlc1_3_lb_vt_skaven_clans_clan_fester_title",
								page_title = "dlc1_3_lb_vt_skaven_clans_clan_fester_title",
								unlock_level = "magnus",
								images = SkavenImages
							},
							{
								category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_title",
								page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans",
								page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans_eshin",
										category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_eshin_title",
										page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_eshin_title",
										unlock_level = "tunnels",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans_moulder",
										category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_moulder_title",
										page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_moulder_title",
										unlock_level = "cemetery",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans_pestilens",
										category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_pestilens_title",
										page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_pestilens_title",
										unlock_level = "end_boss",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans_skryre",
										category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_skryre_title",
										page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_skryre_title",
										unlock_level = "forest_ambush",
										images = SkavenImages
									}
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_clans_warlord_clans",
								category_name = "dlc1_3_lb_vt_skaven_clans_warlord_clans_title",
								page_title = "dlc1_3_lb_vt_skaven_clans_warlord_clans_title",
								unlock_level = "bridge",
								images = SkavenImages
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_skaven_psychology_title",
						page_text = "dlc1_3_lb_vt_skaven_psychology",
						page_title = "dlc1_3_lb_vt_skaven_psychology_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_skaven_psychology_1",
								category_name = "dlc1_3_lb_vt_skaven_psychology_1_title",
								page_title = "dlc1_3_lb_vt_skaven_psychology_1_title",
								unlock_level = "cemetery",
								images = SkavenImages
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_psychology_2",
								category_name = "dlc1_3_lb_vt_skaven_psychology_2_title",
								page_title = "dlc1_3_lb_vt_skaven_psychology_2_title",
								unlock_level = "courtyard_level",
								images = SkavenImages
							}
						}
					},
					{
						page_text = "dlc1_3_lb_vt_skaven_physiology",
						category_name = "dlc1_3_lb_vt_skaven_physiology_title",
						page_title = "dlc1_3_lb_vt_skaven_physiology_title",
						unlock_level = "tunnels",
						images = SkavenImages
					},
					{
						category_name = "dlc1_3_lb_vt_world_religion_title",
						page_text = "dlc1_3_lb_vt_world_religion",
						page_title = "dlc1_3_lb_vt_world_religion_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_skaven_horned_rat",
								category_name = "dlc1_3_lb_vt_skaven_horned_rat_title",
								page_title = "dlc1_3_lb_vt_skaven_horned_rat_title",
								unlock_level = "end_boss",
								images = SkavenImages
							}
						}
					},
					{
						page_text = "dlc1_3_lb_vt_skaven_council_of_thirteen",
						category_name = "dlc1_3_lb_vt_skaven_council_of_thirteen_title",
						page_title = "dlc1_3_lb_vt_skaven_council_of_thirteen_title",
						unlock_level = "end_boss",
						images = SkavenImages
					},
					{
						category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_title",
						page_text = "dlc1_3_lb_vt_skaven_technology_and_magic",
						page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_doomwheel",
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_doomwheel_title",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_doomwheel_title",
								unlock_level = "forest_ambush",
								images = SkavenImages
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_screaming_bell",
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_screaming_bell_title",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_screaming_bell_title",
								unlock_level = "city_walls",
								images = SkavenImages
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_warp_lightning_cannon",
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_warp_lightning_cannon_title",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_warp_lightning_cannon_title",
								unlock_level = "city_walls",
								images = SkavenImages
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_tunneling",
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_tunneling_title",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_tunneling_title",
								unlock_level = "tunnels",
								images = SkavenImages
							},
							{
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_title",
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_magic",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_overview",
										category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_overview_title",
										page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_overview_title",
										unlock_level = "end_boss",
										images = SkavenImages
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_reports",
										category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_reports_title",
										page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_reports_title",
										unlock_level = "end_boss",
										images = SkavenImages
									}
								}
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_skaven_settlements_title",
						page_text = "dlc1_3_lb_vt_skaven_settlements",
						page_title = "dlc1_3_lb_vt_skaven_settlements_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_skaven_settlements_skavenblight",
								category_name = "dlc1_3_lb_vt_skaven_settlements_skavenblight_title",
								page_title = "dlc1_3_lb_vt_skaven_settlements_skavenblight_title",
								unlock_level = "tunnels",
								images = SkavenImages
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_settlements_under_empire",
								category_name = "dlc1_3_lb_vt_skaven_settlements_under_empire_title",
								page_title = "dlc1_3_lb_vt_skaven_settlements_under_empire_title",
								unlock_level = "tunnels",
								images = SkavenImages
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_settlements_hell_pit",
								category_name = "dlc1_3_lb_vt_skaven_settlements_hell_pit_title",
								page_title = "dlc1_3_lb_vt_skaven_settlements_hell_pit_title",
								unlock_level = "tunnels",
								images = SkavenImages
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_settlements_city_of_pillars",
								category_name = "dlc1_3_lb_vt_skaven_settlements_city_of_pillars_title",
								page_title = "dlc1_3_lb_vt_skaven_settlements_city_of_pillars_title",
								unlock_level = "tunnels",
								images = SkavenImages
							}
						}
					}
				}
			},
			{
				category_name = "dlc1_3_lb_vt_ubersreik_title",
				page_title = "dlc1_3_lb_vt_ubersreik_title",
				sub_categories = {
					{
						category_name = "dlc1_3_lb_vt_ubersreik_overview_title",
						page_text = "dlc1_3_lb_vt_ubersreik_overview",
						page_title = "dlc1_3_lb_vt_ubersreik_overview_title",
						images = EmpireImages
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_history_title",
						page_text = "dlc1_3_lb_vt_ubersreik_history",
						page_title = "dlc1_3_lb_vt_ubersreik_history_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_ubersreik_history_origins",
								category_name = "dlc1_3_lb_vt_ubersreik_history_origins_title",
								page_title = "dlc1_3_lb_vt_ubersreik_history_origins_title",
								unlock_level = "magnus",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_history_great_war_of_chaos",
								category_name = "dlc1_3_lb_vt_ubersreik_history_great_war_of_chaos_title",
								page_title = "dlc1_3_lb_vt_ubersreik_history_great_war_of_chaos_title",
								unlock_level = "city_walls",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_history_freistadt",
								category_name = "dlc1_3_lb_vt_ubersreik_history_freistadt_title",
								page_title = "dlc1_3_lb_vt_ubersreik_history_freistadt_title",
								unlock_level = "courtyard_level",
								images = EmpireImages
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_history_recent_event_title",
						page_text = "dlc1_3_lb_vt_ubersreik_history_recent_events",
						page_title = "dlc1_3_lb_vt_ubersreik_history_recent_event_title",
						images = EmpireImages
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_red_moon_inn_title",
						page_text = "dlc1_3_lb_vt_ubersreik_red_moon_inn",
						page_title = "dlc1_3_lb_vt_ubersreik_red_moon_inn_title",
						images = EmpireImages
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_prologue_title",
						page_text = "dlc1_3_lb_vt_ubersreik_prologue",
						page_title = "dlc1_3_lb_vt_ubersreik_prologue_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_ubersreik_prologue_precinct",
								category_name = "dlc1_3_lb_vt_ubersreik_prologue_precinct_title",
								page_title = "dlc1_3_lb_vt_ubersreik_prologue_precinct_title",
								unlock_level = "magnus",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_prologue_magnus_tower",
								category_name = "dlc1_3_lb_vt_ubersreik_prologue_magnus_tower_title",
								page_title = "dlc1_3_lb_vt_ubersreik_prologue_magnus_tower_title",
								unlock_level = "magnus",
								images = EmpireImages
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_title",
						page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas",
						page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_merchant_quarter",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_merchant_quarter_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_merchant_quarter_title",
								unlock_level = "merchant",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_market_square",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_market_square_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_market_square_title",
								unlock_level = "merchant",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_wizards_way",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_wizards_way_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_wizards_way_title",
								unlock_level = "wizard",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_sewers",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_sewers_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_sewers_title",
								unlock_level = "sewers_short",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_bridge",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_bridge_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_bridge_title",
								unlock_level = "bridge",
								images = EmpireImages
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_act_2_areas_title",
						page_text = "dlc1_3_lb_vt_ubersreik_act_2_areas",
						page_title = "dlc1_3_lb_vt_ubersreik_act_2_areas_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_2_areas_reikwald",
								category_name = "dlc1_3_lb_vt_ubersreik_act_2_areas_reikwald_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_2_areas_reikwald_title",
								unlock_level = "forest_ambush",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_2_areas_morrs_field",
								category_name = "dlc1_3_lb_vt_ubersreik_act_2_areas_morrs_field_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_2_areas_morrs_field_title",
								unlock_level = "cemetery",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_2_areas_walls",
								category_name = "dlc1_3_lb_vt_ubersreik_act_2_areas_walls_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_2_areas_walls_title",
								unlock_level = "city_walls",
								images = EmpireImages
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_act_3_areas_title",
						page_text = "dlc1_3_lb_vt_ubersreik_act_3_areas",
						page_title = "dlc1_3_lb_vt_ubersreik_act_3_areas_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_3_areas_docks",
								category_name = "dlc1_3_lb_vt_ubersreik_act_3_areas_docks_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_3_areas_docks_title",
								unlock_level = "docks_short_level",
								images = EmpireImages
							}
						}
					},
					{
						page_text = "dlc1_3_lb_vt_ubersreik_the_hill",
						category_name = "dlc1_3_lb_vt_ubersreik_the_hill_title",
						page_title = "dlc1_3_lb_vt_ubersreik_the_hill_title",
						unlock_level = "cemetery",
						images = EmpireImages
					},
					{
						page_text = "dlc1_3_lb_vt_ubersreik_dwarfen_quarter",
						category_name = "dlc1_3_lb_vt_ubersreik_dwarfen_quarter_title",
						page_title = "dlc1_3_lb_vt_ubersreik_dwarfen_quarter_title",
						unlock_level = "bridge",
						images = EmpireImages
					}
				}
			},
			{
				category_name = "dlc1_3_lb_vt_world_title",
				category_image = "journal_category_image_world",
				page_title = "dlc1_3_lb_vt_world_title",
				sub_categories = {
					{
						category_name = "dlc1_3_lb_vt_world_nations_title",
						page_text = "dlc1_3_lb_vt_world_nations",
						page_title = "dlc1_3_lb_vt_world_nations_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_world_nations_empire_title",
								page_text = "dlc1_3_lb_vt_world_nations_empire",
								page_title = "dlc1_3_lb_vt_world_nations_empire_title",
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_title",
										page_text = "dlc1_3_lb_vt_world_nations_empire_provinces",
										page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_provinces_1",
												category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_1_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_1_title",
												unlock_level = "magnus",
												images = EmpireImages
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_provinces_2",
												category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_2_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_2_title",
												unlock_level = "merchant",
												images = EmpireImages
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_world_nations_empire_provinces_reikland",
										category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_reikland_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_reikland_title",
										unlock_level = "forest_ambush",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_nations_empire_provinces_ostland",
										category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_ostland_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_ostland_title",
										unlock_level = "forest_ambush",
										images = EmpireImages
									},
									{
										category_name = "dlc1_3_lb_vt_world_nations_empire_history_title",
										page_text = "dlc1_3_lb_vt_world_nations_empire_history",
										page_title = "dlc1_3_lb_vt_world_nations_empire_history_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_history_sigmar",
												category_name = "dlc1_3_lb_vt_world_nations_empire_history_sigmar_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_history_sigmar_title",
												unlock_level = "merchant",
												images = EmpireImages
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_history_crisis",
												category_name = "dlc1_3_lb_vt_world_nations_empire_history_crisis_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_history_crisis_title",
												unlock_level = "end_boss",
												images = EmpireImages
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_history_war_against_chaos",
												category_name = "dlc1_3_lb_vt_world_nations_empire_history_war_against_chaos_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_history_war_against_chaos_title",
												unlock_level = "forest_ambush",
												images = EmpireImages
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_history_recent_events",
												category_name = "dlc1_3_lb_vt_world_nations_empire_history_recent_events_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_history_recent_events_title",
												unlock_level = "sewers_short",
												images = EmpireImages
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_world_nations_empire_knightly_orders",
										category_name = "dlc1_3_lb_vt_world_nations_empire_knightly_orders_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_knightly_orders_title",
										unlock_level = "magnus",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_nations_empire_holy_order_templar_sigmar",
										category_name = "dlc1_3_lb_vt_world_nations_empire_holy_order_templar_sigmar_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_holy_order_templar_sigmar_title",
										unlock_level = "merchant",
										images = EmpireImages
									},
									{
										category_name = "dlc1_3_lb_vt_world_nations_empire_settlements_title",
										page_text = "dlc1_3_lb_vt_world_nations_empire_settlements",
										page_title = "dlc1_3_lb_vt_world_nations_empire_settlements_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_settlements_altdorf",
												category_name = "dlc1_3_lb_vt_world_nations_empire_settlements_altdorf_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_settlements_altdorf_title",
												unlock_level = "merchant",
												images = EmpireImages
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_settlements_nuln",
												category_name = "dlc1_3_lb_vt_world_nations_empire_settlements_nuln_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_settlements_nuln_title",
												unlock_level = "docks_short_level",
												images = EmpireImages
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_settlements_middenheim",
												category_name = "dlc1_3_lb_vt_world_nations_empire_settlements_middenheim_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_settlements_middenheim_title",
												unlock_level = "cemetery",
												images = EmpireImages
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_settlements_talabheim",
												category_name = "dlc1_3_lb_vt_world_nations_empire_settlements_talabheim_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_settlements_talabheim_title",
												unlock_level = "forest_ambush",
												images = EmpireImages
											}
										}
									}
								}
							},
							{
								page_text = "dlc1_3_lb_vt_world_nations_bretonnia",
								category_name = "dlc1_3_lb_vt_world_nations_bretonnia_title",
								page_title = "dlc1_3_lb_vt_world_nations_bretonnia_title",
								unlock_level = "forest_ambush",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_world_nations_estalia",
								category_name = "dlc1_3_lb_vt_world_nations_estalia_title",
								page_title = "dlc1_3_lb_vt_world_nations_estalia_title",
								unlock_level = "tunnels",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_world_nations_kislev",
								category_name = "dlc1_3_lb_vt_world_nations_kislev_title",
								page_title = "dlc1_3_lb_vt_world_nations_kislev_title",
								unlock_level = "cemetery",
								images = EmpireImages
							},
							{
								page_text = "dlc1_3_lb_vt_world_nations_tilea",
								category_name = "dlc1_3_lb_vt_world_nations_tilea_title",
								page_title = "dlc1_3_lb_vt_world_nations_tilea_title",
								unlock_level = "docks_short_level",
								images = EmpireImages
							},
							{
								category_name = "dlc1_3_lb_vt_world_athel_loren_title",
								page_text = "dlc1_3_lb_vt_world_athel_loren",
								page_title = "dlc1_3_lb_vt_world_athel_loren_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_athel_loren_eternal_realms",
										category_name = "dlc1_3_lb_vt_world_athel_loren_eternal_realms_title",
										page_title = "dlc1_3_lb_vt_world_athel_loren_eternal_realms_title",
										unlock_level = "forest_ambush",
										images = EmpireImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_dwarfen_realm_title",
								page_text = "dlc1_3_lb_vt_world_dwarfen_realm",
								page_title = "dlc1_3_lb_vt_world_dwarfen_realm_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_karak_a_karaz",
										category_name = "dlc1_3_lb_vt_world_karak_a_karaz_title",
										page_title = "dlc1_3_lb_vt_world_karak_a_karaz_title",
										unlock_level = "farm",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_barak_varr",
										category_name = "dlc1_3_lb_vt_world_barak_varr_title",
										page_title = "dlc1_3_lb_vt_world_barak_varr_title",
										unlock_level = "courtyard_level",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_karak_azgaraz",
										category_name = "dlc1_3_lb_vt_world_karak_azgaraz_title",
										page_title = "dlc1_3_lb_vt_world_karak_azgaraz_title",
										unlock_level = "bridge",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_karak_eight_peaks",
										category_name = "dlc1_3_lb_vt_world_karak_eight_peaks_title",
										page_title = "dlc1_3_lb_vt_world_karak_eight_peaks_title",
										unlock_level = "cemetery",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_karak_kadrin",
										category_name = "dlc1_3_lb_vt_world_karak_kadrin_title",
										page_title = "dlc1_3_lb_vt_world_karak_kadrin_title",
										unlock_level = "farm",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_zhufbar",
										category_name = "dlc1_3_lb_vt_world_zhufbar_title",
										page_title = "dlc1_3_lb_vt_world_zhufbar_title",
										unlock_level = "tunnels",
										images = EmpireImages
									}
								}
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_world_notable_characters_title",
						page_text = "dlc1_3_lb_vt_world_notable_characters",
						page_title = "dlc1_3_lb_vt_world_notable_characters_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_world_notable_characters_empire_title",
								page_text = "dlc1_3_lb_vt_world_notable_characters_empire",
								page_title = "dlc1_3_lb_vt_world_notable_characters_empire_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_notable_characters_empire_magnus_the_pious",
										category_name = "dlc1_3_lb_vt_world_notable_characters_empire_magnus_the_pious_title",
										page_title = "dlc1_3_lb_vt_world_notable_characters_empire_magnus_the_pious_title",
										unlock_level = "merchant",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_notable_characters_empire_karl_franz",
										category_name = "dlc1_3_lb_vt_world_notable_characters_empire_karl_franz_title",
										page_title = "dlc1_3_lb_vt_world_notable_characters_empire_karl_franz_title",
										unlock_level = "merchant",
										images = EmpireImages
									}
								}
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_world_geography_title",
						page_text = "dlc1_3_lb_vt_world_geography",
						page_title = "dlc1_3_lb_vt_world_geography_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_world_geography_mountains_title",
								page_text = "dlc1_3_lb_vt_world_geography_mountains",
								page_title = "dlc1_3_lb_vt_world_geography_mountains_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_geography_mountains_grey",
										category_name = "dlc1_3_lb_vt_world_geography_mountains_grey_title",
										page_title = "dlc1_3_lb_vt_world_geography_mountains_grey_title",
										unlock_level = "cemetery",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_geography_mountains_worlds_edge",
										category_name = "dlc1_3_lb_vt_world_geography_mountains_worlds_edge_title",
										page_title = "dlc1_3_lb_vt_world_geography_mountains_worlds_edge_title",
										unlock_level = "tunnels",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_geography_mountains_black",
										category_name = "dlc1_3_lb_vt_world_geography_mountains_black_title",
										page_title = "dlc1_3_lb_vt_world_geography_mountains_black_title",
										unlock_level = "courtyard_level",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_geography_mountains_middle",
										category_name = "dlc1_3_lb_vt_world_geography_mountains_middle_title",
										page_title = "dlc1_3_lb_vt_world_geography_mountains_middle_title",
										unlock_level = "end_boss",
										images = EmpireImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_geography_rivers_title",
								page_text = "dlc1_3_lb_vt_world_geography_rivers",
								page_title = "dlc1_3_lb_vt_world_geography_rivers_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_geography_rivers_aver",
										category_name = "dlc1_3_lb_vt_world_geography_rivers_aver_title",
										page_title = "dlc1_3_lb_vt_world_geography_rivers_aver_title",
										unlock_level = "sewers_short",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_geography_rivers_stir",
										category_name = "dlc1_3_lb_vt_world_geography_rivers_stir_title",
										page_title = "dlc1_3_lb_vt_world_geography_rivers_stir_title",
										unlock_level = "bridge",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_geography_rivers_talabec",
										category_name = "dlc1_3_lb_vt_world_geography_rivers_talabec_title",
										page_title = "dlc1_3_lb_vt_world_geography_rivers_talabec_title",
										unlock_level = "forest_ambush",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_geography_rivers_reik",
										category_name = "dlc1_3_lb_vt_world_geography_rivers_reik_title",
										page_title = "dlc1_3_lb_vt_world_geography_rivers_reik_title",
										unlock_level = "tunnels",
										images = EmpireImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_geography_forests_title",
								page_text = "dlc1_3_lb_vt_world_geography_forests",
								page_title = "dlc1_3_lb_vt_world_geography_forests_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_geography_forests_forest_of_shadows",
										category_name = "dlc1_3_lb_vt_world_geography_forests_forest_of_shadows_title",
										page_title = "dlc1_3_lb_vt_world_geography_forests_forest_of_shadows_title",
										unlock_level = "bridge",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_geography_forests_drakwald",
										category_name = "dlc1_3_lb_vt_world_geography_forests_drakwald_title",
										page_title = "dlc1_3_lb_vt_world_geography_forests_drakwald_title",
										unlock_level = "forest_ambush",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_geography_forests_great_forest",
										category_name = "dlc1_3_lb_vt_world_geography_forests_great_forest_title",
										page_title = "dlc1_3_lb_vt_world_geography_forests_great_forest_title",
										unlock_level = "cemetery",
										images = EmpireImages
									}
								}
							}
						}
					},
					{
						page_text = "dlc1_3_lb_vt_world_astronomy",
						category_name = "dlc1_3_lb_vt_world_astronomy_title",
						page_title = "dlc1_3_lb_vt_world_astronomy_title",
						unlock_level = "wizard",
						images = EmpireImages
					},
					{
						category_name = "dlc1_3_lb_vt_world_religion_title",
						page_text = "dlc1_3_lb_vt_world_religion",
						page_title = "dlc1_3_lb_vt_world_religion_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_world_religion_imperial_title",
								page_text = "dlc1_3_lb_vt_world_religion_imperial",
								page_title = "dlc1_3_lb_vt_world_religion_imperial_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_manann",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_manann_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_manann_title",
										unlock_level = "magnus",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_morr",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_morr_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_morr_title",
										unlock_level = "merchant",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_myrmidia",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_myrmidia_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_myrmidia_title",
										unlock_level = "wizard",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_ranald",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_ranald_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_ranald_title",
										unlock_level = "forest_ambush",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_taal_rhya",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_taal_rhya_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_taal_rhya_title",
										unlock_level = "cemetery",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_shallya",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_shallya_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_shallya_title",
										unlock_level = "tunnels",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_sigmar",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_sigmar_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_sigmar_title",
										unlock_level = "end_boss",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_ulric",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_ulric_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_ulric_title",
										unlock_level = "sewers_short",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_verena",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_verena_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_verena_title",
										unlock_level = "forest_ambush",
										images = EmpireImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_religion_elven_title",
								page_text = "dlc1_3_lb_vt_world_religion_elven",
								page_title = "dlc1_3_lb_vt_world_religion_elven_title",
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_world_religion_elven_1_title",
										page_text = "dlc1_3_lb_vt_world_religion_elven_1",
										page_title = "dlc1_3_lb_vt_world_religion_elven_1_title",
										sub_categories = {
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_anath_raema_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_anath_raema",
												unlock_level = "city_walls",
												page_title = "dlc1_3_lb_vt_world_religion_elven_anath_raema_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_asuryan_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_asuryan",
												unlock_level = "docks_short_level",
												page_title = "dlc1_3_lb_vt_world_religion_elven_asuryan_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_drakira_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_drakira",
												unlock_level = "courtyard_level",
												page_title = "dlc1_3_lb_vt_world_religion_elven_drakira_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_eldrazor_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_eldrazor",
												unlock_level = "farm",
												page_title = "dlc1_3_lb_vt_world_religion_elven_eldrazor_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_ereth_kial_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_ereth_kial",
												unlock_level = "magnus",
												page_title = "dlc1_3_lb_vt_world_religion_elven_ereth_kial_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_hoeth_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_hoeth",
												unlock_level = "merchant",
												page_title = "dlc1_3_lb_vt_world_religion_elven_hoeth_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_isha_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_isha",
												unlock_level = "wizard",
												page_title = "dlc1_3_lb_vt_world_religion_elven_isha_title"
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_world_religion_elven_2_title",
										page_text = "dlc1_3_lb_vt_world_religion_elven_2",
										page_title = "dlc1_3_lb_vt_world_religion_elven_2_title",
										sub_categories = {
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_khaine_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_khaine",
												unlock_level = "forest_ambush",
												page_title = "dlc1_3_lb_vt_world_religion_elven_khaine_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_kurnous_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_kurnous",
												unlock_level = "cemetery",
												page_title = "dlc1_3_lb_vt_world_religion_elven_kurnous_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_lileath_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_lileath",
												unlock_level = "tunnels",
												page_title = "dlc1_3_lb_vt_world_religion_elven_lileath_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_loec_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_loec",
												unlock_level = "end_boss",
												page_title = "dlc1_3_lb_vt_world_religion_elven_loec_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_mathiann_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_mathiann",
												unlock_level = "wizard",
												page_title = "dlc1_3_lb_vt_world_religion_elven_mathiann_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_morai_heg_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_morai_heg",
												unlock_level = "bridge",
												page_title = "dlc1_3_lb_vt_world_religion_elven_morai_heg_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_vaul_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_vaul",
												unlock_level = "city_walls",
												page_title = "dlc1_3_lb_vt_world_religion_elven_vaul_title"
											}
										}
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_religion_dwarfen_title",
								page_text = "dlc1_3_lb_vt_world_religion_dwarfen",
								page_title = "dlc1_3_lb_vt_world_religion_dwarfen_title",
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_world_religion_dwarfen_ancestor_gods_title",
										page_text = "dlc1_3_lb_vt_world_religion_dwarfen_ancestor_gods",
										unlock_level = "docks_short_level",
										page_title = "dlc1_3_lb_vt_world_religion_dwarfen_ancestor_gods_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_religion_dwarfen_grimnir_grungni_valaya_title",
										page_text = "dlc1_3_lb_vt_world_religion_dwarfen_grimnir_grungni_valaya",
										unlock_level = "courtyard_level",
										page_title = "dlc1_3_lb_vt_world_religion_dwarfen_grimnir_grungni_valaya_title"
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_religion_ruinous_powers_title_title",
								page_text = "dlc1_3_lb_vt_world_religion_ruinous_powers",
								page_title = "dlc1_3_lb_vt_world_religion_ruinous_powers_title_title",
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_world_religion_ruinous_powers_nurgle_title",
										page_text = "dlc1_3_lb_vt_world_religion_ruinous_powers_nurgle",
										unlock_level = "end_boss",
										page_title = "dlc1_3_lb_vt_world_religion_ruinous_powers_nurgle_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_religion_ruinous_powers_khorne_title",
										page_text = "dlc1_3_lb_vt_world_religion_ruinous_powers_khorne",
										unlock_level = "end_boss",
										page_title = "dlc1_3_lb_vt_world_religion_ruinous_powers_khorne_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_religion_ruinous_powers_tzeentch_title",
										page_text = "dlc1_3_lb_vt_world_religion_ruinous_powers_tzeentch",
										unlock_level = "end_boss",
										page_title = "dlc1_3_lb_vt_world_religion_ruinous_powers_tzeentch_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_religion_ruinous_powers_slaneesh_title",
										page_text = "dlc1_3_lb_vt_world_religion_ruinous_powers_slaneesh",
										unlock_level = "end_boss",
										page_title = "dlc1_3_lb_vt_world_religion_ruinous_powers_slaneesh_title"
									}
								}
							}
						}
					},
					{
						page_text = "dlc1_3_lb_vt_world_magic",
						category_name = "dlc1_3_lb_vt_world_magic_title",
						category_image = "journal_category_image_magic",
						page_title = "dlc1_3_lb_vt_world_magic_title",
						sub_categories = {
							{
								category_name = "dlc1_3_lb_vt_world_magic_imperial_college_title",
								page_text = "dlc1_3_lb_vt_world_magic_imperial_college",
								page_title = "dlc1_3_lb_vt_world_magic_imperial_college_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_bright",
										category_name = "dlc1_3_lb_vt_world_magic_empire_bright_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_bright_title",
										unlock_level = "wizard",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_grey",
										category_name = "dlc1_3_lb_vt_world_magic_empire_grey_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_grey_title",
										unlock_level = "wizard",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_gold",
										category_name = "dlc1_3_lb_vt_world_magic_empire_gold_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_gold_title",
										unlock_level = "wizard",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_light",
										category_name = "dlc1_3_lb_vt_world_magic_empire_light_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_light_title",
										unlock_level = "wizard",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_amber",
										category_name = "dlc1_3_lb_vt_world_magic_empire_amber_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_amber_title",
										unlock_level = "wizard",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_jade",
										category_name = "dlc1_3_lb_vt_world_magic_empire_jade_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_jade_title",
										unlock_level = "wizard",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_celestial",
										category_name = "dlc1_3_lb_vt_world_magic_empire_celestial_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_celestial_title",
										unlock_level = "wizard",
										images = EmpireImages
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_amethyst",
										category_name = "dlc1_3_lb_vt_world_magic_empire_amethyst_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_amethyst_title",
										unlock_level = "wizard",
										images = EmpireImages
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_magic_wood_elf_title",
								page_text = "dlc1_3_lb_vt_world_magic_wood_elf",
								unlock_level = "forest_ambush",
								page_title = "dlc1_3_lb_vt_world_magic_wood_elf_title"
							},
							{
								category_name = "dlc1_3_lb_vt_world_magic_wood_chaos_title",
								page_text = "dlc1_3_lb_vt_world_magic_wood_chaos",
								unlock_level = "end_boss",
								page_title = "dlc1_3_lb_vt_world_magic_wood_chaos_title"
							}
						}
					}
				}
			}
		}
	}
}

return 
