local DWARF_IMAGES = {
	"journal_image_dwarf_01",
	"journal_image_dwarf_02",
	"journal_image_dwarf_03"
}
local EMPIRE_IMAGES = {
	"journal_image_empire_03",
	"journal_image_empire_06",
	"journal_image_empire_08",
	"journal_image_empire_14",
	"journal_image_empire_16",
	"journal_image_empire_17",
	"journal_image_empire_18",
	"journal_image_empire_19",
	"journal_image_empire_20",
	"journal_image_empire_21",
	"journal_image_empire_22",
	"journal_image_empire_23",
	"journal_image_empire_24"
}
local SKAVEN_IMAGES = {
	"journal_image_skaven_01",
	"journal_image_skaven_02",
	"journal_image_skaven_03"
}
local WOOD_ELF_IMAGES = {
	"journal_image_wood_elf_01",
	"journal_image_wood_elf_02",
	"journal_image_wood_elf_03",
	"journal_image_wood_elf_04",
	"journal_image_wood_elf_05"
}
JournalPageLayout = {
	{
		tab_icon = "test_icon_2",
		category_name = "dlc1_3_journal_tab_title_lorebook",
		sub_categories = {
			{
				page_text = "dlc1_3_lb_vt_characters",
				category_name = "dlc1_3_lb_vt_characters_title",
				page_title = "dlc1_3_lb_vt_characters_title",
				image = {
					vertical_alignment = "bottom",
					name = "journal_category_image_characters",
					horizontal_alignment = "center"
				},
				sub_categories = {
					{
						category_name = "dlc1_3_lb_vt_characters_heroes_title",
						page_text = "dlc1_3_lb_vt_characters_heroes",
						page_title = "dlc1_3_lb_vt_characters_heroes_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_characters_heroes_wh_1",
								category_name = "dlc1_3_lb_vt_characters_heroes_wh_1_title",
								unlock_level = "magnus",
								page_title = "dlc1_3_lb_vt_characters_heroes_wh_1_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_character_04",
									horizontal_alignment = "left"
								}
							},
							{
								category_name = "dlc1_3_lb_vt_characters_heroes_wh_2_title",
								page_text = "dlc1_3_lb_vt_characters_heroes_wh_2",
								unlock_level = "merchant",
								page_title = "dlc1_3_lb_vt_characters_heroes_wh_2_title"
							},
							{
								page_text = "dlc1_3_lb_vt_characters_heroes_bw_1",
								category_name = "dlc1_3_lb_vt_characters_heroes_bw_1_title",
								unlock_level = "magnus",
								page_title = "dlc1_3_lb_vt_characters_heroes_bw_1_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_character_03",
									horizontal_alignment = "left"
								}
							},
							{
								category_name = "dlc1_3_lb_vt_characters_heroes_bw_2_title",
								page_text = "dlc1_3_lb_vt_characters_heroes_bw_2",
								unlock_level = "wizard",
								page_title = "dlc1_3_lb_vt_characters_heroes_bw_2_title"
							},
							{
								page_text = "dlc1_3_lb_vt_characters_heroes_ww",
								category_name = "dlc1_3_lb_vt_characters_heroes_ww_title",
								unlock_level = "magnus",
								page_title = "dlc1_3_lb_vt_characters_heroes_ww_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_character_05",
									horizontal_alignment = "left"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_characters_heroes_dr_1",
								category_name = "dlc1_3_lb_vt_characters_heroes_dr_1_title",
								unlock_level = "magnus",
								page_title = "dlc1_3_lb_vt_characters_heroes_dr_1_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_character_01",
									horizontal_alignment = "left"
								}
							},
							{
								category_name = "dlc1_3_lb_vt_characters_heroes_dr_2_title",
								page_text = "dlc1_3_lb_vt_characters_heroes_dr_2",
								unlock_level = "bridge",
								page_title = "dlc1_3_lb_vt_characters_heroes_dr_2_title"
							},
							{
								page_text = "dlc1_3_lb_vt_characters_heroes_es_1",
								category_name = "dlc1_3_lb_vt_characters_heroes_es_1_title",
								unlock_level = "magnus",
								page_title = "dlc1_3_lb_vt_characters_heroes_es_1_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_character_02",
									horizontal_alignment = "left"
								}
							},
							{
								category_name = "dlc1_3_lb_vt_characters_heroes_es_2_title",
								page_text = "dlc1_3_lb_vt_characters_heroes_es_2",
								unlock_level = "merchant",
								page_title = "dlc1_3_lb_vt_characters_heroes_es_2_title"
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_characters_npc_title",
						page_text = "dlc1_3_lb_vt_characters_npc",
						page_title = "dlc1_3_lb_vt_characters_npc_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_characters_npc_nik_1",
								category_name = "dlc1_3_lb_vt_characters_npc_nik_1_title",
								page_title = "dlc1_3_lb_vt_characters_npc_nik_1_title",
								unlock_level = "magnus",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_characters_npc_nik_2",
								category_name = "dlc1_3_lb_vt_characters_npc_nik_2_title",
								page_title = "dlc1_3_lb_vt_characters_npc_nik_2_title",
								unlock_level = "merchant",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_characters_npc_nfl",
								category_name = "dlc1_3_lb_vt_characters_npc_nfl_title",
								page_title = "dlc1_3_lb_vt_characters_npc_nfl_title",
								unlock_level = "courtyard_level",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_characters_npc_ntw",
								category_name = "dlc1_3_lb_vt_characters_npc_ntw_title",
								page_title = "dlc1_3_lb_vt_characters_npc_ntw_title",
								unlock_level = "wizard",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_characters_rasknitt",
								category_name = "dlc1_3_lb_vt_skaven_characters_rasknitt_title",
								page_title = "dlc1_3_lb_vt_skaven_characters_rasknitt_title",
								unlock_level = "end_boss",
								images = SKAVEN_IMAGES
							}
						}
					}
				}
			},
			{
				page_text = "dlc1_3_lb_vt_skaven",
				category_name = "dlc1_3_lb_vt_skaven_title",
				page_title = "dlc1_3_lb_vt_skaven_title",
				image = {
					vertical_alignment = "bottom",
					name = "journal_category_image_skaven",
					horizontal_alignment = "center"
				},
				sub_categories = {
					{
						page_text = "dlc1_3_lb_vt_skaven_overview",
						category_name = "dlc1_3_lb_vt_skaven_overview_title",
						unlock_level = "magnus",
						page_title = "dlc1_3_lb_vt_skaven_overview_title",
						image = {
							vertical_alignment = "top",
							name = "journal_image_skaven_01"
						}
					},
					{
						category_name = "dlc1_3_lb_vt_skaven_beastiary_title",
						page_text = "dlc1_3_lb_vt_skaven_beastiary",
						page_title = "dlc1_3_lb_vt_skaven_beastiary_title",
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_core_skavenslave",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_core_skavenslave_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_core_skavenslave_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_skaven_slave"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_core_clanrat",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_core_clanrat_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_core_clanrat_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_skaven_clanrat"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_special_stormvermin",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_special_stormvermin_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_special_stormvermin_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_stormvermin"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_special_ratling_gunner",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_special_ratling_gunner_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_special_ratling_gunner_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_skaven_ratlinggunner"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_special_gutter_runner",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_special_gutter_runner_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_special_gutter_runner_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_gutter_runner"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_special_pack_master",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_special_pack_master_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_special_pack_master_title",
								image = {
									vertical_alignment = "bottom",
									name = "journal_image_skaven_packmaster",
									horizontal_alignment = "left"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_special_globadier",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_special_globadier_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_special_globadier_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_skaven_globadier"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_loot_rat",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_loot_rat_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_loot_rat_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_skaven_lootrat"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_rare_rat_ogre",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_rare_rat_ogre_title",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_rare_rat_ogre_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_skaven_ogre"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_beastiary_rare_grey_seer",
								category_name = "dlc1_3_lb_vt_skaven_beastiary_rare_grey_seer_title",
								unlock_level = "end_boss",
								page_title = "dlc1_3_lb_vt_skaven_beastiary_rare_grey_seer_title",
								image = {
									vertical_alignment = "top",
									name = "journal_image_skaven_greyseer"
								}
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
										images = SKAVEN_IMAGES
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_kazvar_title",
										page_text = "dlc1_3_lb_vt_skaven_history_kazvar",
										page_title = "dlc1_3_lb_vt_skaven_history_kazvar_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_1",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_1_title",
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_1_title",
												unlock_level = "dlc_castle",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_2",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_2_title",
												unlock_level = "dlc_castle",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_3",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_3_title",
												index_name = "dlc1_3_lb_vt_part_3",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_3_title",
												unlock_level = "dlc_castle_dungeon",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_4",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_4_title",
												index_name = "dlc1_3_lb_vt_part_4",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_4_title",
												unlock_level = "dlc_castle_dungeon",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_5",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_5_title",
												index_name = "dlc1_3_lb_vt_part_5",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_5_title",
												unlock_level = "dlc_castle_dungeon",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_6",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_6_title",
												index_name = "dlc1_3_lb_vt_part_6",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_6_title",
												unlock_level = "dlc_portals",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_7",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_7_title",
												index_name = "dlc1_3_lb_vt_part_7",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_7_title",
												unlock_level = "dlc_portals",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_kazvar_8",
												category_name = "dlc1_3_lb_vt_skaven_history_kazvar_8_title",
												index_name = "dlc1_3_lb_vt_part_8",
												page_title = "dlc1_3_lb_vt_skaven_history_kazvar_8_title",
												unlock_level = "dlc_portals",
												images = SKAVEN_IMAGES
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
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_1_title",
												unlock_level = "magnus",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_2",
												category_name = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_rise_and_fall_skavenblight_2_title",
												unlock_level = "magnus",
												images = SKAVEN_IMAGES
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
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_lords_of_decay_1_title",
												unlock_level = "merchant",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_lords_of_decay_2",
												category_name = "dlc1_3_lb_vt_skaven_history_lords_of_decay_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_lords_of_decay_2_title",
												unlock_level = "merchant",
												images = SKAVEN_IMAGES
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_great_migration",
										category_name = "dlc1_3_lb_vt_skaven_history_great_migration_title",
										page_title = "dlc1_3_lb_vt_skaven_history_great_migration_title",
										unlock_level = "forest_ambush",
										images = SKAVEN_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_cripple_peak",
										category_name = "dlc1_3_lb_vt_skaven_history_cripple_peak_title",
										page_title = "dlc1_3_lb_vt_skaven_history_cripple_peak_title",
										unlock_level = "cemetery",
										images = SKAVEN_IMAGES
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_death_of_nagash_title",
										page_text = "dlc1_3_lb_vt_skaven_history_death_of_nagash",
										page_title = "dlc1_3_lb_vt_skaven_history_death_of_nagash_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_death_of_nagash_1",
												category_name = "dlc1_3_lb_vt_skaven_history_death_of_nagash_1_title",
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_death_of_nagash_1_title",
												unlock_level = "cemetery",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_death_of_nagash_2",
												category_name = "dlc1_3_lb_vt_skaven_history_death_of_nagash_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_death_of_nagash_2_title",
												unlock_level = "cemetery",
												images = SKAVEN_IMAGES
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_rikek",
										category_name = "dlc1_3_lb_vt_skaven_history_rikek_title",
										page_title = "dlc1_3_lb_vt_skaven_history_rikek_title",
										unlock_level = "docks_short_level",
										images = SKAVEN_IMAGES
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_title",
										page_text = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens",
										page_title = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_1",
												category_name = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_1_title",
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_1_title",
												unlock_level = "courtyard_level",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_2",
												category_name = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_rise_of_clan_pestlens_2_title",
												unlock_level = "courtyard_level",
												images = SKAVEN_IMAGES
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
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_first_civil_war_1_title",
												unlock_level = "sewers_short",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_first_civil_war_2",
												category_name = "dlc1_3_lb_vt_skaven_history_first_civil_war_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_first_civil_war_2_title",
												unlock_level = "sewers_short",
												images = SKAVEN_IMAGES
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
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_1_title",
												unlock_level = "cemetery",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_black_plague_2",
												category_name = "dlc1_3_lb_vt_skaven_history_black_plague_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_2_title",
												unlock_level = "cemetery",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_black_plague_3",
												category_name = "dlc1_3_lb_vt_skaven_history_black_plague_3_title",
												index_name = "dlc1_3_lb_vt_part_3",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_3_title",
												unlock_level = "cemetery",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_black_plague_4",
												category_name = "dlc1_3_lb_vt_skaven_history_black_plague_4_title",
												index_name = "dlc1_3_lb_vt_part_4",
												page_title = "dlc1_3_lb_vt_skaven_history_black_plague_4_title",
												unlock_level = "cemetery",
												images = SKAVEN_IMAGES
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_red_pox",
										category_name = "dlc1_3_lb_vt_skaven_history_red_pox_title",
										page_title = "dlc1_3_lb_vt_skaven_history_red_pox_title",
										unlock_level = "cemetery",
										images = SKAVEN_IMAGES
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_second_civil_war_title",
										page_text = "dlc1_3_lb_vt_skaven_history_second_civil_war",
										page_title = "dlc1_3_lb_vt_skaven_history_second_civil_war_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_second_civil_war_1",
												category_name = "dlc1_3_lb_vt_skaven_history_second_civil_war_title_1",
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_second_civil_war_title_1",
												unlock_level = "sewers_short",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_second_civil_war_2",
												category_name = "dlc1_3_lb_vt_skaven_history_second_civil_war_title_2",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_second_civil_war_title_2",
												unlock_level = "sewers_short",
												images = SKAVEN_IMAGES
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
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_1_title",
												unlock_level = "city_wall",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_2",
												category_name = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_2_title",
												unlock_level = "city_wall",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_3",
												category_name = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_3_title",
												index_name = "dlc1_3_lb_vt_part_3",
												page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_3_title",
												unlock_level = "city_wall",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_4",
												category_name = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_4_title",
												index_name = "dlc1_3_lb_vt_part_4",
												page_title = "dlc1_3_lb_vt_skaven_history_horned_rat_walks_among_us_4_title",
												unlock_level = "city_wall",
												images = SKAVEN_IMAGES
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
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_1_title",
												unlock_level = "dlc_dwarf_interior",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_2",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_dwarf_things_2_title",
												unlock_level = "dlc_dwarf_interior",
												images = SKAVEN_IMAGES
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
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_1_title",
												unlock_level = "dlc_dwarf_exterior",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_2",
												category_name = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_2_title",
												unlock_level = "dlc_dwarf_exterior",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_3",
												category_name = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_3_title",
												index_name = "dlc1_3_lb_vt_part_3",
												page_title = "dlc1_3_lb_vt_skaven_history_fall_of_karak_eight_peaks_3_title",
												unlock_level = "dlc_dwarf_exterior",
												images = SKAVEN_IMAGES
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_history_war_with_green_things",
										category_name = "dlc1_3_lb_vt_skaven_history_war_with_green_things_title",
										page_title = "dlc1_3_lb_vt_skaven_history_war_with_green_things_title",
										unlock_level = "courtyard_level",
										images = SKAVEN_IMAGES
									},
									{
										category_name = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_title",
										page_text = "dlc1_3_lb_vt_skaven_history_attack_on_nuln",
										page_title = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_1",
												category_name = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_1_title",
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_1_title",
												unlock_level = "courtyard_level",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_2",
												category_name = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_attack_on_nuln_2_title",
												unlock_level = "courtyard_level",
												images = SKAVEN_IMAGES
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
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_1_title",
												unlock_level = "farm",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_2",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_2_title",
												unlock_level = "farm",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_3",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_3_title",
												index_name = "dlc1_3_lb_vt_part_3",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_3_title",
												unlock_level = "farm",
												images = SKAVEN_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_4",
												category_name = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_4_title",
												index_name = "dlc1_3_lb_vt_part_4",
												page_title = "dlc1_3_lb_vt_skaven_history_war_with_elf_things_4_title",
												unlock_level = "farm",
												images = SKAVEN_IMAGES
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
								page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans_eshin",
								category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_eshin_title",
								page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_eshin_title",
								unlock_level = "tunnels",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans_moulder",
								category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_moulder_title",
								page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_moulder_title",
								unlock_level = "merchant",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans_pestilens",
								category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_pestilens_title",
								page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_pestilens_title",
								unlock_level = "cemetery",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_clans_the_great_clans_skryre",
								category_name = "dlc1_3_lb_vt_skaven_clans_the_great_clans_skryre_title",
								page_title = "dlc1_3_lb_vt_skaven_clans_the_great_clans_skryre_title",
								unlock_level = "forest_ambush",
								images = SKAVEN_IMAGES
							},
							{
								category_name = "dlc1_3_lb_vt_skaven_clans_clan_fester_title",
								page_text = "dlc1_3_lb_vt_skaven_clans_clan_fester",
								page_title = "dlc1_3_lb_vt_skaven_clans_clan_fester_title",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_clans_warlord_clans",
								category_name = "dlc1_3_lb_vt_skaven_clans_warlord_clans_title",
								page_title = "dlc1_3_lb_vt_skaven_clans_warlord_clans_title",
								unlock_level = "tunnels",
								images = SKAVEN_IMAGES
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
								index_name = "dlc1_3_lb_vt_part_1",
								page_title = "dlc1_3_lb_vt_skaven_psychology_1_title",
								unlock_level = "tunnels",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_psychology_2",
								category_name = "dlc1_3_lb_vt_skaven_psychology_2_title",
								index_name = "dlc1_3_lb_vt_part_2",
								page_title = "dlc1_3_lb_vt_skaven_psychology_2_title",
								unlock_level = "tunnels",
								images = SKAVEN_IMAGES
							}
						}
					},
					{
						page_text = "dlc1_3_lb_vt_skaven_physiology",
						category_name = "dlc1_3_lb_vt_skaven_physiology_title",
						page_title = "dlc1_3_lb_vt_skaven_physiology_title",
						unlock_level = "tunnels",
						images = SKAVEN_IMAGES
					},
					{
						page_text = "dlc1_3_lb_vt_skaven_horned_rat",
						category_name = "dlc1_3_lb_vt_skaven_horned_rat_title",
						page_title = "dlc1_3_lb_vt_skaven_horned_rat_title",
						unlock_level = "end_boss",
						images = SKAVEN_IMAGES
					},
					{
						page_text = "dlc1_3_lb_vt_skaven_council_of_thirteen",
						category_name = "dlc1_3_lb_vt_skaven_council_of_thirteen_title",
						page_title = "dlc1_3_lb_vt_skaven_council_of_thirteen_title",
						unlock_level = "end_boss",
						images = SKAVEN_IMAGES
					},
					{
						page_text = "dlc1_3_lb_vt_skaven_technology_and_magic",
						category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_title",
						page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_title",
						image = {
							vertical_alignment = "bottom",
							name = "journal_category_image_skaven_technology_magic",
							horizontal_alignment = "center"
						},
						sub_categories = {
							{
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_doomwheel",
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_doomwheel_title",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_doomwheel_title",
								unlock_level = "forest_ambush",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_screaming_bell",
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_screaming_bell_title",
								unlock_level = "city_wall",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_screaming_bell_title",
								image = {
									vertical_alignment = "bottom",
									name = "journal_image_skaven_screaming_bell"
								}
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_warp_lightning_cannon",
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_warp_lightning_cannon_title",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_warp_lightning_cannon_title",
								unlock_level = "city_wall",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_tunneling",
								category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_tunneling_title",
								page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_tunneling_title",
								unlock_level = "tunnels",
								images = SKAVEN_IMAGES
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
										images = SKAVEN_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_reports",
										category_name = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_reports_title",
										page_title = "dlc1_3_lb_vt_skaven_technology_and_magic_magic_reports_title",
										unlock_level = "end_boss",
										images = SKAVEN_IMAGES
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
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_settlements_under_empire",
								category_name = "dlc1_3_lb_vt_skaven_settlements_under_empire_title",
								page_title = "dlc1_3_lb_vt_skaven_settlements_under_empire_title",
								unlock_level = "tunnels",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_settlements_hell_pit",
								category_name = "dlc1_3_lb_vt_skaven_settlements_hell_pit_title",
								page_title = "dlc1_3_lb_vt_skaven_settlements_hell_pit_title",
								unlock_level = "tunnels",
								images = SKAVEN_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_skaven_settlements_city_of_pillars",
								category_name = "dlc1_3_lb_vt_skaven_settlements_city_of_pillars_title",
								page_title = "dlc1_3_lb_vt_skaven_settlements_city_of_pillars_title",
								unlock_level = "tunnels",
								images = SKAVEN_IMAGES
							}
						}
					}
				}
			},
			{
				page_text = "dlc1_3_lb_vt_ubersreik",
				category_name = "dlc1_3_lb_vt_ubersreik_title",
				page_title = "dlc1_3_lb_vt_ubersreik_title",
				image = {
					vertical_alignment = "bottom",
					name = "journal_category_image_ubersreik",
					horizontal_alignment = "center"
				},
				sub_categories = {
					{
						category_name = "dlc1_3_lb_vt_ubersreik_overview_title",
						page_text = "dlc1_3_lb_vt_ubersreik_overview",
						page_title = "dlc1_3_lb_vt_ubersreik_overview_title",
						images = EMPIRE_IMAGES
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
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_history_great_war_of_chaos",
								category_name = "dlc1_3_lb_vt_ubersreik_history_great_war_of_chaos_title",
								page_title = "dlc1_3_lb_vt_ubersreik_history_great_war_of_chaos_title",
								unlock_level = "city_wall",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_history_freistadt",
								category_name = "dlc1_3_lb_vt_ubersreik_history_freistadt_title",
								page_title = "dlc1_3_lb_vt_ubersreik_history_freistadt_title",
								unlock_level = "courtyard_level",
								images = EMPIRE_IMAGES
							}
						}
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_history_recent_event_title",
						page_text = "dlc1_3_lb_vt_ubersreik_history_recent_events",
						page_title = "dlc1_3_lb_vt_ubersreik_history_recent_event_title",
						images = EMPIRE_IMAGES
					},
					{
						category_name = "dlc1_3_lb_vt_ubersreik_red_moon_inn_title",
						page_text = "dlc1_3_lb_vt_ubersreik_red_moon_inn",
						page_title = "dlc1_3_lb_vt_ubersreik_red_moon_inn_title",
						images = EMPIRE_IMAGES
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
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_prologue_magnus_tower",
								category_name = "dlc1_3_lb_vt_ubersreik_prologue_magnus_tower_title",
								page_title = "dlc1_3_lb_vt_ubersreik_prologue_magnus_tower_title",
								unlock_level = "magnus",
								images = EMPIRE_IMAGES
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
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_market_square",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_market_square_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_market_square_title",
								unlock_level = "merchant",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_wizards_way",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_wizards_way_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_wizards_way_title",
								unlock_level = "wizard",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_sewers",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_sewers_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_sewers_title",
								unlock_level = "sewers_short",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_1_areas_bridge",
								category_name = "dlc1_3_lb_vt_ubersreik_act_1_areas_bridge_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_1_areas_bridge_title",
								unlock_level = "bridge",
								images = EMPIRE_IMAGES
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
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_2_areas_morrs_field",
								category_name = "dlc1_3_lb_vt_ubersreik_act_2_areas_morrs_field_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_2_areas_morrs_field_title",
								unlock_level = "cemetery",
								images = EMPIRE_IMAGES
							},
							{
								page_text = "dlc1_3_lb_vt_ubersreik_act_2_areas_walls",
								category_name = "dlc1_3_lb_vt_ubersreik_act_2_areas_walls_title",
								page_title = "dlc1_3_lb_vt_ubersreik_act_2_areas_walls_title",
								unlock_level = "city_wall",
								images = EMPIRE_IMAGES
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
								images = EMPIRE_IMAGES
							}
						}
					},
					{
						page_text = "dlc1_3_lb_vt_ubersreik_the_hill",
						category_name = "dlc1_3_lb_vt_ubersreik_the_hill_title",
						page_title = "dlc1_3_lb_vt_ubersreik_the_hill_title",
						unlock_level = "merchant",
						images = EMPIRE_IMAGES
					},
					{
						page_text = "dlc1_3_lb_vt_ubersreik_dwarfen_quarter",
						category_name = "dlc1_3_lb_vt_ubersreik_dwarfen_quarter_title",
						page_title = "dlc1_3_lb_vt_ubersreik_dwarfen_quarter_title",
						unlock_level = "bridge",
						images = EMPIRE_IMAGES
					}
				}
			},
			{
				category_name = "dlc1_3_lb_vt_drachenfels_title",
				page_text = "dlc1_3_lb_vt_drachenfels",
				page_title = "dlc1_3_lb_vt_drachenfels_title",
				sub_categories = {
					{
						category_name = "dlc1_3_lb_vt_drachenfels_castle_drachenfels_title",
						page_text = "dlc1_3_lb_vt_drachenfels_castle_drachenfels",
						unlock_level = "dlc_castle_dungeon",
						page_title = "dlc1_3_lb_vt_drachenfels_castle_drachenfels_title"
					},
					{
						category_name = "dlc1_3_lb_vt_drachenfels_constant_drachenfels_title",
						page_text = "dlc1_3_lb_vt_drachenfels_constant_drachenfels",
						unlock_level = "dlc_castle",
						page_title = "dlc1_3_lb_vt_drachenfels_constant_drachenfels_title"
					},
					{
						category_name = "dlc1_3_lb_vt_drachenfels_poison_feast_title",
						page_text = "dlc1_3_lb_vt_drachenfels_poison_feast",
						unlock_level = "dlc_castle",
						page_title = "dlc1_3_lb_vt_drachenfels_poison_feast_title"
					},
					{
						category_name = "dlc1_3_lb_vt_drachenfels_drachenfels_final_performance_title",
						page_text = "dlc1_3_lb_vt_drachenfels_drachenfels_final_performance",
						unlock_level = "dlc_castle",
						page_title = "dlc1_3_lb_vt_drachenfels_drachenfels_final_performance_title"
					},
					{
						category_name = "dlc1_3_lb_vt_drachenfels_drachengral_title",
						page_text = "dlc1_3_lb_vt_drachenfels_drachengral",
						unlock_level = "dlc_castle",
						page_title = "dlc1_3_lb_vt_drachenfels_drachengral_title"
					},
					{
						category_name = "dlc1_3_lb_vt_drachenfels_flask_of_wayward_souls_title",
						page_text = "dlc1_3_lb_vt_drachenfels_flask_of_wayward_souls",
						unlock_level = "dlc_castle_dungeon",
						page_title = "dlc1_3_lb_vt_drachenfels_flask_of_wayward_souls_title"
					},
					{
						category_name = "dlc1_3_lb_vt_drachenfels_summoners_peak_title",
						page_text = "dlc1_3_lb_vt_drachenfels_summoners_peak",
						unlock_level = "dlc_portals",
						page_title = "dlc1_3_lb_vt_drachenfels_summoners_peak_title"
					}
				}
			},
			{
				category_name = "dlc1_3_lb_vt_karak_azgaraz_title",
				page_text = "dlc1_3_lb_vt_karak_azgaraz",
				page_title = "dlc1_3_lb_vt_karak_azgaraz_title",
				sub_categories = {
					{
						category_name = "dlc1_3_lb_vt_world_karak_azgaraz_title",
						page_text = "dlc1_3_lb_vt_world_karak_azgaraz",
						unlock_level = "dlc_dwarf_interior",
						page_title = "dlc1_3_lb_vt_world_karak_azgaraz_title"
					},
					{
						category_name = "dlc1_3_lb_vt_karak_azgaraz_geography_title",
						page_text = "dlc1_3_lb_vt_karak_azgaraz_geography",
						unlock_level = "dlc_dwarf_beacons",
						page_title = "dlc1_3_lb_vt_karak_azgaraz_geography_title"
					},
					{
						category_name = "dlc1_3_lb_vt_karak_azgaraz_economy_title",
						page_text = "dlc1_3_lb_vt_karak_azgaraz_economy",
						unlock_level = "dlc_dwarf_beacons",
						page_title = "dlc1_3_lb_vt_karak_azgaraz_economy_title"
					},
					{
						category_name = "dlc1_3_lb_vt_karak_azgaraz_khazid_kro_title",
						page_text = "dlc1_3_lb_vt_karak_azgaraz_khazid_kro",
						unlock_level = "dlc_dwarf_interior",
						page_title = "dlc1_3_lb_vt_karak_azgaraz_khazid_kro_title"
					},
					{
						category_name = "dlc1_3_lb_vt_karak_azgaraz_mad_dog_mine_title",
						page_text = "dlc1_3_lb_vt_karak_azgaraz_mad_dog_mine",
						unlock_level = "dlc_dwarf_exterior",
						page_title = "dlc1_3_lb_vt_karak_azgaraz_mad_dog_mine_title"
					},
					{
						category_name = "dlc1_3_lb_vt_karak_azgaraz_halgrim_halgrimsson_title",
						page_text = "dlc1_3_lb_vt_karak_azgaraz_halgrim_halgrimsson",
						unlock_level = "dlc_dwarf_interior",
						page_title = "dlc1_3_lb_vt_karak_azgaraz_halgrim_halgrimsson_title"
					}
				}
			},
			{
				page_text = "dlc1_3_lb_vt_world",
				category_name = "dlc1_3_lb_vt_world_title",
				page_title = "dlc1_3_lb_vt_world_title",
				image = {
					vertical_alignment = "bottom",
					name = "journal_category_image_world",
					horizontal_alignment = "center"
				},
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
										page_text = "dlc1_3_lb_vt_world_nations_empire_overview",
										category_name = "dlc1_3_lb_vt_world_nations_empire_overview_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_overview_title",
										unlock_level = "magnus",
										images = EMPIRE_IMAGES
									},
									{
										category_name = "dlc1_3_lb_vt_world_notable_characters_title",
										page_text = "dlc1_3_lb_vt_world_notable_characters",
										page_title = "dlc1_3_lb_vt_world_notable_characters_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_world_notable_characters_empire_magnus_the_pious",
												category_name = "dlc1_3_lb_vt_world_notable_characters_empire_magnus_the_pious_title",
												page_title = "dlc1_3_lb_vt_world_notable_characters_empire_magnus_the_pious_title",
												unlock_level = "magnus",
												images = EMPIRE_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_world_notable_characters_empire_karl_franz",
												category_name = "dlc1_3_lb_vt_world_notable_characters_empire_karl_franz_title",
												unlock_level = "merchant",
												page_title = "dlc1_3_lb_vt_world_notable_characters_empire_karl_franz_title",
												image = {
													vertical_alignment = "top",
													name = "journal_image_empire_13"
												}
											}
										}
									},
									{
										category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_title",
										page_text = "dlc1_3_lb_vt_world_nations_empire_provinces",
										page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_provinces_1",
												category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_1_title",
												index_name = "dlc1_3_lb_vt_part_1",
												page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_1_title",
												unlock_level = "any",
												images = EMPIRE_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_provinces_2",
												category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_2_title",
												index_name = "dlc1_3_lb_vt_part_2",
												page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_2_title",
												unlock_level = "any",
												images = EMPIRE_IMAGES
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_world_nations_empire_provinces_reikland",
										category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_reikland_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_reikland_title",
										unlock_level = "farm",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_nations_empire_provinces_ostland",
										category_name = "dlc1_3_lb_vt_world_nations_empire_provinces_ostland_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_provinces_ostland_title",
										unlock_level = "any",
										images = EMPIRE_IMAGES
									},
									{
										category_name = "dlc1_3_lb_vt_world_nations_empire_history_title",
										page_text = "dlc1_3_lb_vt_world_nations_empire_history",
										page_title = "dlc1_3_lb_vt_world_nations_empire_history_title",
										sub_categories = {
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_history_sigmar",
												category_name = "dlc1_3_lb_vt_world_nations_empire_history_sigmar_title",
												unlock_level = "merchant",
												page_title = "dlc1_3_lb_vt_world_nations_empire_history_sigmar_title",
												image = {
													vertical_alignment = "top",
													name = "journal_image_empire_15"
												}
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_history_crisis",
												category_name = "dlc1_3_lb_vt_world_nations_empire_history_crisis_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_history_crisis_title",
												unlock_level = "end_boss",
												images = EMPIRE_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_history_war_against_chaos",
												category_name = "dlc1_3_lb_vt_world_nations_empire_history_war_against_chaos_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_history_war_against_chaos_title",
												unlock_level = "any",
												images = EMPIRE_IMAGES
											}
										}
									},
									{
										page_text = "dlc1_3_lb_vt_world_nations_empire_knightly_orders",
										category_name = "dlc1_3_lb_vt_world_nations_empire_knightly_orders_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_knightly_orders_title",
										unlock_level = "any",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_nations_empire_holy_order_templar_sigmar",
										category_name = "dlc1_3_lb_vt_world_nations_empire_holy_order_templar_sigmar_title",
										page_title = "dlc1_3_lb_vt_world_nations_empire_holy_order_templar_sigmar_title",
										unlock_level = "merchant",
										images = EMPIRE_IMAGES
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
												images = EMPIRE_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_settlements_nuln",
												category_name = "dlc1_3_lb_vt_world_nations_empire_settlements_nuln_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_settlements_nuln_title",
												unlock_level = "docks_short_level",
												images = EMPIRE_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_settlements_middenheim",
												category_name = "dlc1_3_lb_vt_world_nations_empire_settlements_middenheim_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_settlements_middenheim_title",
												unlock_level = "docks_short_level",
												images = EMPIRE_IMAGES
											},
											{
												page_text = "dlc1_3_lb_vt_world_nations_empire_settlements_talabheim",
												category_name = "dlc1_3_lb_vt_world_nations_empire_settlements_talabheim_title",
												page_title = "dlc1_3_lb_vt_world_nations_empire_settlements_talabheim_title",
												unlock_level = "forest_ambush",
												images = EMPIRE_IMAGES
											}
										}
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_nations_bretonnia_title",
								page_text = "dlc1_3_lb_vt_world_nations_bretonnia",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_world_nations_bretonnia_title"
							},
							{
								category_name = "dlc1_3_lb_vt_world_nations_estalia_title",
								page_text = "dlc1_3_lb_vt_world_nations_estalia",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_world_nations_estalia_title"
							},
							{
								category_name = "dlc1_3_lb_vt_world_nations_kislev_title",
								page_text = "dlc1_3_lb_vt_world_nations_kislev",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_world_nations_kislev_title"
							},
							{
								category_name = "dlc1_3_lb_vt_world_nations_tilea_title",
								page_text = "dlc1_3_lb_vt_world_nations_tilea",
								unlock_level = "any",
								page_title = "dlc1_3_lb_vt_world_nations_tilea_title"
							},
							{
								category_name = "dlc1_3_lb_vt_world_athel_loren_title",
								page_text = "dlc1_3_lb_vt_world_athel_loren",
								page_title = "dlc1_3_lb_vt_world_athel_loren_title",
								sub_categories = {
									{
										page_text = "dlc1_3_lb_vt_world_athel_loren_overview",
										category_name = "dlc1_3_lb_vt_world_athel_loren_overview_title",
										page_title = "dlc1_3_lb_vt_world_athel_loren_overview_title",
										unlock_level = "forest_ambush",
										images = WOOD_ELF_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_athel_loren_eternal_realms",
										category_name = "dlc1_3_lb_vt_world_athel_loren_eternal_realms_title",
										page_title = "dlc1_3_lb_vt_world_athel_loren_eternal_realms_title",
										unlock_level = "forest_ambush",
										images = WOOD_ELF_IMAGES
									}
								}
							},
							{
								page_text = "dlc1_3_lb_vt_world_dwarfen_realm",
								category_name = "dlc1_3_lb_vt_world_dwarfen_realm_title",
								page_title = "dlc1_3_lb_vt_world_dwarfen_realm_title",
								image = {
									vertical_alignment = "bottom",
									name = "journal_category_image_dwarfen_realm",
									horizontal_alignment = "center"
								},
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_world_karak_a_karaz_title",
										page_text = "dlc1_3_lb_vt_world_karak_a_karaz",
										unlock_level = "bridge",
										page_title = "dlc1_3_lb_vt_world_karak_a_karaz_title"
									},
									{
										page_text = "dlc1_3_lb_vt_world_barak_varr",
										category_name = "dlc1_3_lb_vt_world_barak_varr_title",
										unlock_level = "bridge",
										page_title = "dlc1_3_lb_vt_world_barak_varr_title",
										image = {
											vertical_alignment = "top",
											name = "journal_image_dwarf_02",
											horizontal_alignment = "left"
										}
									},
									{
										page_text = "dlc1_3_lb_vt_world_karak_eight_peaks",
										category_name = "dlc1_3_lb_vt_world_karak_eight_peaks_title",
										unlock_level = "bridge",
										page_title = "dlc1_3_lb_vt_world_karak_eight_peaks_title",
										image = {
											vertical_alignment = "top",
											name = "journal_image_dwarf_01",
											horizontal_alignment = "right"
										}
									},
									{
										category_name = "dlc1_3_lb_vt_world_karak_kadrin_title",
										page_text = "dlc1_3_lb_vt_world_karak_kadrin",
										unlock_level = "bridge",
										page_title = "dlc1_3_lb_vt_world_karak_kadrin_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_zhufbar_title",
										page_text = "dlc1_3_lb_vt_world_zhufbar",
										unlock_level = "bridge",
										page_title = "dlc1_3_lb_vt_world_zhufbar_title"
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
										category_name = "dlc1_3_lb_vt_world_geography_mountains_grey_title",
										page_text = "dlc1_3_lb_vt_world_geography_mountains_grey",
										unlock_level = "dlc_dwarf_exterior",
										page_title = "dlc1_3_lb_vt_world_geography_mountains_grey_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_geography_mountains_worlds_edge_title",
										page_text = "dlc1_3_lb_vt_world_geography_mountains_worlds_edge",
										unlock_level = "dlc_dwarf_exterior",
										page_title = "dlc1_3_lb_vt_world_geography_mountains_worlds_edge_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_geography_mountains_black_title",
										page_text = "dlc1_3_lb_vt_world_geography_mountains_black",
										unlock_level = "dlc_dwarf_beacons",
										page_title = "dlc1_3_lb_vt_world_geography_mountains_black_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_geography_mountains_middle_title",
										page_text = "dlc1_3_lb_vt_world_geography_mountains_middle",
										unlock_level = "dlc_dwarf_beacons",
										page_title = "dlc1_3_lb_vt_world_geography_mountains_middle_title"
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_geography_rivers_title",
								page_text = "dlc1_3_lb_vt_world_geography_rivers",
								page_title = "dlc1_3_lb_vt_world_geography_rivers_title",
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_world_geography_rivers_aver_title",
										page_text = "dlc1_3_lb_vt_world_geography_rivers_aver",
										unlock_level = "docks_short_level",
										page_title = "dlc1_3_lb_vt_world_geography_rivers_aver_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_geography_rivers_stir_title",
										page_text = "dlc1_3_lb_vt_world_geography_rivers_stir",
										unlock_level = "docks_short_level",
										page_title = "dlc1_3_lb_vt_world_geography_rivers_stir_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_geography_rivers_talabec_title",
										page_text = "dlc1_3_lb_vt_world_geography_rivers_talabec",
										unlock_level = "docks_short_level",
										page_title = "dlc1_3_lb_vt_world_geography_rivers_talabec_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_geography_rivers_reik_title",
										page_text = "dlc1_3_lb_vt_world_geography_rivers_reik",
										unlock_level = "docks_short_level",
										page_title = "dlc1_3_lb_vt_world_geography_rivers_reik_title"
									}
								}
							},
							{
								category_name = "dlc1_3_lb_vt_world_geography_forests_title",
								page_text = "dlc1_3_lb_vt_world_geography_forests",
								page_title = "dlc1_3_lb_vt_world_geography_forests_title",
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_world_geography_forests_forest_of_shadows_title",
										page_text = "dlc1_3_lb_vt_world_geography_forests_forest_of_shadows",
										unlock_level = "forest_ambush",
										page_title = "dlc1_3_lb_vt_world_geography_forests_forest_of_shadows_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_geography_forests_drakwald_title",
										page_text = "dlc1_3_lb_vt_world_geography_forests_drakwald",
										unlock_level = "forest_ambush",
										page_title = "dlc1_3_lb_vt_world_geography_forests_drakwald_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_geography_forests_great_forest_title",
										page_text = "dlc1_3_lb_vt_world_geography_forests_great_forest",
										unlock_level = "forest_ambush",
										page_title = "dlc1_3_lb_vt_world_geography_forests_great_forest_title"
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
						images = EMPIRE_IMAGES
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
										unlock_level = "any",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_morr",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_morr_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_morr_title",
										unlock_level = "cemetery",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_myrmidia",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_myrmidia_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_myrmidia_title",
										unlock_level = "any",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_ranald",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_ranald_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_ranald_title",
										unlock_level = "any",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_taal_rhya",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_taal_rhya_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_taal_rhya_title",
										unlock_level = "forest_ambush",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_shallya",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_shallya_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_shallya_title",
										unlock_level = "tunnels",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_sigmar",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_sigmar_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_sigmar_title",
										unlock_level = "end_boss",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_ulric",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_ulric_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_ulric_title",
										unlock_level = "any",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_religion_imperial_verena",
										category_name = "dlc1_3_lb_vt_world_religion_imperial_verena_title",
										page_title = "dlc1_3_lb_vt_world_religion_imperial_verena_title",
										unlock_level = "any",
										images = EMPIRE_IMAGES
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
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_anath_raema_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_asuryan_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_asuryan",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_asuryan_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_drakira_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_drakira",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_drakira_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_eldrazor_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_eldrazor",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_eldrazor_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_ereth_kial_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_ereth_kial",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_ereth_kial_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_hoeth_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_hoeth",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_hoeth_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_isha_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_isha",
												unlock_level = "any",
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
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_khaine_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_kurnous_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_kurnous",
												unlock_level = "forest_ambush",
												page_title = "dlc1_3_lb_vt_world_religion_elven_kurnous_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_lileath_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_lileath",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_lileath_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_loec_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_loec",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_loec_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_mathlann_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_mathlann",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_mathlann_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_morai_heg_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_morai_heg",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_morai_heg_title"
											},
											{
												category_name = "dlc1_3_lb_vt_world_religion_elven_vaul_title",
												page_text = "dlc1_3_lb_vt_world_religion_elven_vaul",
												unlock_level = "any",
												page_title = "dlc1_3_lb_vt_world_religion_elven_vaul_title"
											}
										}
									}
								}
							},
							{
								page_text = "dlc1_3_lb_vt_world_religion_dwarfen",
								category_name = "dlc1_3_lb_vt_world_religion_dwarfen_title",
								page_title = "dlc1_3_lb_vt_world_religion_dwarfen_title",
								image = {
									vertical_alignment = "bottom",
									name = "journal_category_image_dwarf_religion",
									horizontal_alignment = "center"
								},
								sub_categories = {
									{
										category_name = "dlc1_3_lb_vt_world_religion_dwarfen_ancestor_gods_title",
										page_text = "dlc1_3_lb_vt_world_religion_dwarfen_ancestor_gods",
										unlock_level = "dlc_dwarf_exterior",
										page_title = "dlc1_3_lb_vt_world_religion_dwarfen_ancestor_gods_title"
									},
									{
										category_name = "dlc1_3_lb_vt_world_religion_dwarfen_grimnir_grungni_valaya_title",
										page_text = "dlc1_3_lb_vt_world_religion_dwarfen_grimnir_grungni_valaya",
										unlock_level = "dlc_dwarf_exterior",
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
						page_title = "dlc1_3_lb_vt_world_magic_title",
						image = {
							vertical_alignment = "bottom",
							name = "journal_category_image_magic",
							horizontal_alignment = "center"
						},
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
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_grey",
										category_name = "dlc1_3_lb_vt_world_magic_empire_grey_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_grey_title",
										unlock_level = "wizard",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_gold",
										category_name = "dlc1_3_lb_vt_world_magic_empire_gold_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_gold_title",
										unlock_level = "wizard",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_light",
										category_name = "dlc1_3_lb_vt_world_magic_empire_light_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_light_title",
										unlock_level = "wizard",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_amber",
										category_name = "dlc1_3_lb_vt_world_magic_empire_amber_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_amber_title",
										unlock_level = "wizard",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_jade",
										category_name = "dlc1_3_lb_vt_world_magic_empire_jade_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_jade_title",
										unlock_level = "wizard",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_celestial",
										category_name = "dlc1_3_lb_vt_world_magic_empire_celestial_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_celestial_title",
										unlock_level = "wizard",
										images = EMPIRE_IMAGES
									},
									{
										page_text = "dlc1_3_lb_vt_world_magic_empire_amethyst",
										category_name = "dlc1_3_lb_vt_world_magic_empire_amethyst_title",
										page_title = "dlc1_3_lb_vt_world_magic_empire_amethyst_title",
										unlock_level = "wizard",
										images = EMPIRE_IMAGES
									}
								}
							},
							{
								page_text = "dlc1_3_lb_vt_world_magic_wood_elf",
								category_name = "dlc1_3_lb_vt_world_magic_wood_elf_title",
								page_title = "dlc1_3_lb_vt_world_magic_wood_elf_title",
								unlock_level = "forest_ambush",
								images = WOOD_ELF_IMAGES
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
