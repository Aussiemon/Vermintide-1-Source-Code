require("scripts/settings/game_mode_settings")
require("scripts/settings/level_unlock_settings")

WARM_CAMERA_BACKLIGHT = {
	intensity = 0,
	falloff_exponent = 1,
	end_falloff = 20,
	start_falloff = 2,
	color = Vector3Box(1, 0.8, 0.6)
}
COLD_CAMERA_BACKLIGHT = {
	intensity = 0.03,
	falloff_exponent = 1,
	end_falloff = 2,
	start_falloff = 0,
	color = Vector3Box(0.9, 0.7, 0.6)
}

dofile("scripts/settings/level_settings_dlc_dwarf")

for _, dlc in pairs(DLCSettings) do
	local level_settings = dlc.level_settings

	if level_settings then
		dofile(level_settings)
	end
end

local DEFAULT_TIP_LIST = {
	"tip_1",
	"tip_2",
	"tip_3",
	"tip_4",
	"tip_5",
	"tip_6",
	"tip_7",
	"tip_8",
	"tip_9"
}
LevelSettings = LevelSettings or {}
local default_start_level = (Development.parameter("gdc") and "magnus") or "inn_level"
LevelSettings.default_start_level = default_start_level
LevelSettings.editor_level = {
	conflict_settings = "level_editor",
	display_name = "level_editor",
	package_name = "resource_packages/levels/debug/whitebox",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	knocked_down_setting = "knocked_down",
	ambient_sound_event = "silent_default_world_sound",
	level_name = "__level_editor_test",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_image = "level_image_any",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		area = "world",
		sorting = 0
	}
}
LevelSettings.inn_level = {
	level_image = "level_image_red_moon_inn",
	ambient_sound_event = "silent_default_world_sound",
	package_name = "resource_packages/levels/inn",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "interior",
	display_name = "inn_level",
	conflict_settings = "disabled",
	loading_bg_image = "loading_screen_inn_level",
	has_multiple_loading_images = true,
	no_bots_allowed = true,
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_inn_level",
	knocked_down_setting = "knocked_down",
	level_name = "levels/inn/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		area = "world",
		sorting = 0
	}
}
LevelSettings.city_level = {
	level_name = "levels/city_01/world",
	display_name = "city_level",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/debug/city_test",
	terrain = "city",
	loading_bg_image = "loading_screen_city_wall",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_city_wall",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_image = "level_image_any",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		area = "world",
		sorting = 0
	}
}
LevelSettings.docks_art = {
	player_aux_bus_name = "environment_reverb_outside",
	display_name = "level_docks_artlevel",
	package_name = "resource_packages/levels/debug/docks_art",
	environment_state = "exterior",
	ambient_sound_event = "silent_default_world_sound",
	level_image = "level_image_any",
	level_name = "levels/docks_art/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		area = "world",
		sorting = 0
	}
}
LevelSettings.forest_artlevel = {
	player_aux_bus_name = "environment_reverb_outside",
	display_name = "level_forest_robert",
	music_won_state = "won_boat",
	environment_state = "exterior",
	ambient_sound_event = "silent_default_world_sound",
	package_name = "resource_packages/levels/debug/forest_robert",
	level_name = "levels/forest_robert/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		area = "world",
		sorting = 0
	}
}
LevelSettings.tunnels_artlevel = {
	player_aux_bus_name = "environment_reverb_outside",
	display_name = "level_tunnels_art",
	package_name = "resource_packages/levels/debug/tunnels_art",
	environment_state = "exterior",
	ambient_sound_event = "silent_default_world_sound",
	level_image = "level_image_any",
	level_name = "levels/tunnels_art/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		area = "world",
		sorting = 0
	}
}
LevelSettings.whitebox = {
	level_image = "level_image_any",
	display_name = "level_whitebox",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/debug/whitebox",
	loading_bg_image = "loading_screen_cemetery",
	ambient_sound_event = "silent_default_world_sound",
	boss_spawning_method = "hand_placed",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	boss_events = {
		safe_dist = 50,
		recurring_distance = 300,
		padding_dist = 100
	},
	rare_events = {
		safe_dist = 50,
		recurring_distance = 1500,
		padding_dist = 100
	},
	map_settings = {
		area = "world",
		sorting = 0
	}
}
LevelSettings.whitebox_basic = {
	display_name = "level_whitebox_basic",
	package_name = "resource_packages/levels/debug/whitebox_basic",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox_basic/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	conflict_settings = "disabled",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_image = "level_image_any",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "world"
	}
}
LevelSettings.whitebox_zones = {
	display_name = "level_whitebox_zones",
	package_name = "resource_packages/levels/debug/whitebox_zones",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox_zones/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "world"
	}
}
LevelSettings.whitebox_ai = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "level_whitebox_ai",
	player_aux_bus_name = "environment_reverb_outside",
	music_won_state = "won_boat",
	environment_state = "exterior",
	package_name = "resource_packages/levels/debug/whitebox_ai",
	loading_bg_image = "loading_screen_cemetery",
	level_image = "level_image_any",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox_ai/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			lorebook_pages = 3,
			primary = {
				ammo = 2,
				grenades = 4,
				healing = 6,
				potions = 8
			},
			secondary = {
				healing = {
					first_aid_kit = 6
				}
			}
		}
	},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "world",
		wwise_events = {
			"nik_map_brief_magnus_tower_01",
			"nik_map_brief_magnus_tower_02"
		}
	}
}
LevelSettings.whitebox_crossroads = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "level_whitebox_crossroads",
	map_sorting = 0,
	music_won_state = "won_boat",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/debug/whitebox_crossroads",
	loading_bg_image = "loading_screen_cemetery",
	level_image = "level_image_any",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox_crossroads/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 8,
			lorebook_pages = 0,
			potions = 10,
			grenades = 9,
			healing = 14
		},
		{
			ammo = 8,
			lorebook_pages = 0,
			potions = 10,
			grenades = 9,
			healing = 15
		},
		{
			ammo = 8,
			lorebook_pages = 0,
			potions = 10,
			grenades = 9,
			healing = 10
		},
		{
			ammo = 8,
			lorebook_pages = 0,
			potions = 10,
			grenades = 9,
			healing = 10
		},
		{
			ammo = 8,
			lorebook_pages = 0,
			potions = 10,
			grenades = 9,
			healing = 10
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_magnus_tower_01",
		"nik_loading_screen_magnus_tower_02"
	},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "world",
		wwise_events = {
			"nik_map_brief_magnus_tower_01",
			"nik_map_brief_magnus_tower_02"
		}
	}
}
LevelSettings.tutorial = {
	level_name = "levels/play_go_tutorial/world",
	environment_state = "exterior",
	music_won_state = "won_boat",
	player_aux_bus_name = "environment_reverb_outside",
	display_name = "level_tutorial",
	mini_patrol = false,
	level_image = "level_image_any",
	loading_bg_image = "loading_screen_tutorial_level",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_tutorial",
	conflict_settings = "tutorial",
	ambient_sound_event = "silent_default_world_sound",
	game_mode = "tutorial",
	default_surface_material = "forest_grass",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/play_go_tutorial",
	source_aux_bus_name = "environment_reverb_outside_source",
	pickup_settings = {
		{
			ammo = 0,
			grenades = 0,
			healing = 0,
			potions = 0
		}
	},
	map_screen_wwise_events = {
		"",
		""
	},
	loading_screen_wwise_events = {
		"",
		""
	},
	locations = {},
	level_particle_effects = {},
	level_screen_effects = {
		"fx/screenspace_raindrops"
	},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "ubersreik"
	}
}
LevelSettings.whitebox_wwise = {
	map_sorting = 0,
	display_name = "whitebox_wwise",
	package_name = "resource_packages/levels/debug/whitebox_wwise",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	knocked_down_setting = "knocked_down",
	ambient_sound_event = "silent_default_world_sound",
	level_name = "levels/debug/whitebox_wwise/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_image = "level_image_any",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "ubersreik"
	}
}
LevelSettings.whitebox_climb = {
	display_name = "level_whitebox_climb",
	package_name = "resource_packages/levels/debug/whitebox_climb",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox_climb/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	destroy_los_distance_squared = 40000,
	source_aux_bus_name = "environment_reverb_outside_source",
	level_image = "level_image_any",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "ubersreik"
	}
}
LevelSettings.whitebox_tutorial = {
	display_name = "level_whitebox_tutorial",
	package_name = "resource_packages/levels/debug/whitebox_tutorial",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox_tutorial/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {
		"location_whitebox_MISSIONS",
		"location_whitebox_HORSE"
	},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "ubersreik"
	}
}
LevelSettings.whitebox_profiling = {
	display_name = "level_whitebox_profiling",
	package_name = "resource_packages/levels/debug/whitebox_profiling",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox_profiling/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "ubersreik"
	}
}
LevelSettings.storm_vermin_patrol_test = {
	display_name = "level_storm_vermin_patrol_test",
	package_name = "resource_packages/levels/debug/storm_vermin_patrol_test",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/storm_vermin_patrol_test/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_long_icon_02",
		area = "ubersreik"
	}
}
LevelSettings.merchant = {
	level_name = "levels/merchant/world",
	display_name = "level_long_2",
	ambient_sound_event = "silent_default_world_sound",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	act = "act_1",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_merchant",
	loading_bg_image = "loading_screen_merchant",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_2",
	level_image = "level_image_merchant",
	loading_screen_gamemode_name = "level_gamemode_raid",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/merchant",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 13,
			lorebook_pages = 3,
			potions = 12,
			grenades = 8,
			healing = 16
		},
		{
			ammo = 13,
			lorebook_pages = 3,
			potions = 12,
			grenades = 7,
			healing = 16
		},
		{
			ammo = 11,
			lorebook_pages = 3,
			potions = 12,
			grenades = 5,
			healing = 14
		},
		{
			ammo = 10,
			lorebook_pages = 3,
			potions = 12,
			grenades = 5,
			healing = 14
		},
		{
			ammo = 10,
			lorebook_pages = 3,
			potions = 12,
			grenades = 5,
			healing = 14
		}
	},
	map_screen_wwise_events = {
		"nik_map_brief_merchant_district_01",
		"nik_map_brief_merchant_district_02",
		"nik_map_brief_merchant_district_03",
		"nik_map_brief_merchant_district_04"
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_district_01",
		"nik_loading_screen_district_02",
		"nik_loading_screen_district_03",
		"nik_loading_screen_district_04"
	},
	locations = {
		"location_merchant_alleyways",
		"location_merchant_first_street",
		"location_merchant_granary",
		"location_merchant_market_square",
		"location_merchant_second_street",
		"location_merchant_small_townsquare",
		"location_merchant_third_street",
		"location_merchant_randomleftside",
		"location_merchant_randomrightside",
		"location_merchant_firsthouse",
		"location_merchant_park",
		"location_merchant_firstarea",
		"location_merchant_bathpool"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 2,
		icon = "level_location_long_icon_02",
		area = "ubersreik",
		console_sorting = 3,
		wwise_events = {
			"nik_map_brief_merchant_district_01",
			"nik_map_brief_merchant_district_02"
		},
		area_position = {
			115,
			-280
		}
	}
}
LevelSettings.tunnels = {
	level_name = "levels/tunnels/world",
	display_name = "level_long_6",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	source_aux_bus_name = "environment_reverb_outside_source",
	act = "act_3",
	level_image = "level_image_tunnels",
	loading_bg_image = "loading_screen_tunnels",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_tunnels",
	ambient_sound_event = "silent_default_world_sound",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_3",
	boss_spawning_method = "hand_placed",
	loading_screen_gamemode_name = "level_gamemode_sabotage",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/tunnels",
	spawn_safe_zone_radius = 7,
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 9,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 19
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 17
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 14
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 14
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 14
		}
	},
	map_screen_wwise_events = {
		"nik_map_brief_skaven_tunnels_01",
		"nik_map_brief_skaven_tunnels_02",
		"nik_map_brief_skaven_tunnels_03",
		"nik_map_brief_skaven_tunnels_04"
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_skaven_tunnels_01",
		"nik_loading_screen_skaven_tunnels_02",
		"nik_loading_screen_skaven_tunnels_03",
		"nik_loading_screen_skaven_tunnels_04"
	},
	locations = {
		"location_tunnels_ubersreik_sewers",
		"location_tunnels_hub_room",
		"location_tunnels_sewer_tunnels",
		"location_tunnels_narrow_stairs",
		"location_tunnels_labyrinth",
		"location_tunnels_skaven_tunnels",
		"location_tunnels_lower_sewer_tunnels",
		"location_tunnels_wide_chasm",
		"location_tunnels_pillar_room",
		"location_tunnels_escape_tunnels",
		"location_tunnels_end_forest"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 10,
		icon = "level_location_long_icon_06",
		area = "ubersreik",
		console_sorting = 11,
		wwise_events = {
			"nik_map_brief_skaven_tunnels_01",
			"nik_map_brief_skaven_tunnels_02"
		},
		area_position = {
			-298,
			150
		}
	}
}
LevelSettings.whitebox_combat = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "level_whitebox_combat",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/debug/whitebox_combat",
	level_image = "level_image_any",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/whitebox_combat/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 4,
			grenades = 4,
			healing = 8,
			potions = 4
		}
	},
	locations = {},
	mini_patrol = {
		composition = "mini_patrol"
	},
	map_settings = {
		sorting = 0,
		icon = "level_location_short_icon_06",
		area = "ubersreik"
	}
}
LevelSettings.character_presentation_scene = {
	level_image = "level_image_any",
	display_name = "character_presentation_scene",
	ambient_sound_event = "silent_default_world_sound",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/debug/character_presentation_scene",
	loading_logo_image = "loading_logo_cemetery",
	loading_bg_image = "loading_bg_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/character_presentation_scene/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 4,
			grenades = 4,
			healing = 8,
			potions = 4
		}
	},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_short_icon_06",
		area = "ubersreik"
	}
}
LevelSettings.farm = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "level_short_4",
	level_name = "levels/farm/world",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	conflict_settings = "event_level_with_roaming",
	act = "act_2",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_farm",
	loading_bg_image = "loading_screen_farm",
	level_image = "level_image_farm",
	loading_screen_gamemode_name = "level_gamemode_raid",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_event",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/farm",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	loading_screen_wwise_events = {
		"nik_loading_screen_farm_01",
		"nik_loading_screen_farm_02"
	},
	pickup_settings = {
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 12
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 12
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 9
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 7
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 7
		}
	},
	locations = {
		"location_farm_left",
		"location_farm_middle",
		"location_farm_right"
	},
	map_settings = {
		sorting = 9,
		icon = "level_location_short_icon_06",
		area = "ubersreik",
		console_sorting = 10,
		wwise_events = {
			"nik_map_brief_farm_01",
			"nik_map_brief_farm_02"
		},
		area_position = {
			540,
			-150
		}
	}
}
LevelSettings.merchant_pretty_corner = {
	map_sorting = 0,
	display_name = "merchant_pretty_corner",
	package_name = "resource_packages/levels/debug/merchant_pretty_corner",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	knocked_down_setting = "knocked_down",
	ambient_sound_event = "silent_default_world_sound",
	level_name = "levels/merchant_pretty_corner/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_image = "level_image_any",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_short_icon_05",
		area = "ubersreik"
	}
}
LevelSettings.city_wall = {
	display_name = "level_short_3",
	level_name = "levels/city_wall_01/world",
	ambient_sound_event = "silent_default_world_sound",
	player_aux_bus_name = "environment_reverb_outside",
	act = "act_2",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_city_wall",
	loading_bg_image = "loading_screen_city_wall",
	conflict_settings = "city_wall",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_1",
	level_image = "level_image_city_wall",
	loading_screen_gamemode_name = "level_gamemode_sabotage",
	boss_spawning_method = "hand_placed",
	environment_state = "exterior",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/city_wall",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 8,
			lorebook_pages = 2,
			potions = 12,
			grenades = 9,
			healing = 15
		},
		{
			ammo = 8,
			lorebook_pages = 2,
			potions = 12,
			grenades = 9,
			healing = 15
		},
		{
			ammo = 8,
			lorebook_pages = 2,
			potions = 12,
			grenades = 9,
			healing = 10
		},
		{
			ammo = 8,
			lorebook_pages = 2,
			potions = 12,
			grenades = 9,
			healing = 10
		},
		{
			ammo = 8,
			lorebook_pages = 2,
			potions = 12,
			grenades = 9,
			healing = 10
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_city_wall_01",
		"nik_loading_screen_city_wall_02"
	},
	locations = {
		"location_city_wall_tower_1",
		"location_city_wall_tower_2",
		"location_city_wall_tower_3",
		"location_city_wall_tower_4"
	},
	mini_patrol = {
		composition = "city_wall_extra_spice"
	},
	boss_events = {
		safe_dist = 90,
		recurring_distance = 200,
		padding_dist = 100,
		events = {
			"nothing"
		},
		max_events_of_this_kind = {
			boss_event_storm_vermin_patrol = 1
		}
	},
	map_settings = {
		sorting = 7,
		icon = "level_location_short_icon_05",
		area = "ubersreik",
		console_sorting = 8,
		wwise_events = {
			"nik_map_brief_city_wall_01",
			"nik_map_brief_city_wall_02"
		},
		area_position = {
			-245,
			250
		}
	}
}
LevelSettings.cemetery = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "level_long_5",
	map_sorting = 5,
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	package_name = "resource_packages/levels/cemetery",
	act = "act_2",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	loading_bg_image = "loading_screen_cemetery",
	level_image = "level_image_cemetery",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_3",
	loading_screen_gamemode_name = "level_gamemode_sabotage",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone_wet",
	knocked_down_setting = "knocked_down",
	level_name = "levels/cemetery/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 10,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 18
		},
		{
			ammo = 10,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 18
		},
		{
			ammo = 10,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 13
		},
		{
			ammo = 10,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 13
		},
		{
			ammo = 10,
			lorebook_pages = 3,
			potions = 12,
			grenades = 9,
			healing = 13
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_cemetary_01",
		"nik_loading_screen_cemetary_02"
	},
	locations = {
		"location_cemetery_1",
		"location_cemetery_2",
		"location_cemetery_3",
		"location_cemetery_4",
		"location_cemetery_5",
		"location_cemetery_6",
		"location_cemetery_7",
		"location_cemetery_8",
		"location_cemetery_9",
		"location_cemetery_10",
		"location_cemetery_11",
		"location_cemetery_12",
		"location_cemetery_13"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 8,
		icon = "level_location_long_icon_05",
		area = "ubersreik",
		console_sorting = 9,
		wwise_events = {
			"nik_map_brief_cemetary_01",
			"nik_map_brief_cemetary_02"
		},
		area_position = {
			-490,
			55
		}
	}
}
LevelSettings.arena = {
	display_name = "arena",
	package_name = "resource_packages/levels/debug/arena",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/arena/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_short_icon_03",
		area = "ubersreik"
	}
}
LevelSettings.courtyard_level = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "level_short_5",
	knocked_down_setting = "knocked_down",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	package_name = "resource_packages/levels/courtyard_level",
	act = "act_3",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_courtyard",
	loading_bg_image = "loading_screen_courtyard_level",
	loading_screen_gamemode_name = "level_gamemode_defend",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_event",
	level_image = "level_image_courtyard",
	default_surface_material = "stone",
	conflict_settings = "event_level_with_roaming",
	level_name = "levels/courtyard_level/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 8
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 10
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 8
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 6
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 4,
			grenades = 6,
			healing = 6
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_courtyard_01",
		"nik_loading_screen_courtyard_01"
	},
	locations = {
		"location_courtyard_leftwell",
		"location_courtyard_rightwell",
		"location_courtyard_courtyard"
	},
	map_settings = {
		sorting = 11,
		icon = "level_location_short_icon_03",
		area = "ubersreik",
		console_sorting = 12,
		wwise_events = {
			"nik_map_brief_courtyard_01",
			"nik_map_brief_courtyard_02"
		},
		area_position = {
			-145,
			-200
		}
	}
}
LevelSettings.sewers_short = {
	level_name = "levels/sewers_short_alt/world",
	display_name = "level_short_1",
	ambient_sound_event = "silent_default_world_sound",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	act = "act_1",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_sewers",
	loading_bg_image = "loading_screen_sewers_short",
	level_image = "level_image_sewers",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_1",
	loading_screen_gamemode_name = "level_gamemode_defend",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/sewers_short_alt",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	map_screen_wwise_events = {
		"nik_map_brief_sewers_01",
		"nik_map_brief_sewers_02",
		"nik_map_brief_sewers_03",
		"nik_map_brief_sewers_04"
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_sewers_01",
		"nik_loading_screen_sewers_02",
		"nik_loading_screen_sewers_03",
		"nik_loading_screen_sewers_04"
	},
	locations = {},
	pickup_settings = {
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 11
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 10
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 9
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 8
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 8
		}
	},
	locations = {
		"location_sewers_smugglers",
		"location_sewers_sewers",
		"location_sewers_street",
		"location_sewers_hall",
		"location_sewers_gate_01",
		"location_sewers_gate_02"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 3,
		icon = "level_location_short_icon_01",
		area = "ubersreik",
		console_sorting = 4,
		wwise_events = {
			"nik_map_brief_sewers_01",
			"nik_map_brief_sewers_02"
		},
		area_position = {
			170,
			243
		}
	}
}
LevelSettings.wizard = {
	level_name = "levels/wizard/world",
	display_name = "level_long_3",
	ambient_sound_event = "silent_default_world_sound",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	act = "act_1",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_wizard",
	loading_bg_image = "loading_screen_wizard",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_2",
	level_image = "level_image_wizard",
	loading_screen_gamemode_name = "level_gamemode_defend",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/wizard",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 14
		},
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 15
		},
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 10
		},
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 10
		},
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 10
		}
	},
	map_screen_wwise_events = {
		"nik_map_brief_wizard_tower_01",
		"nik_map_brief_wizard_tower_01_b",
		"nik_map_brief_wizard_tower_02",
		"nik_map_brief_wizard_tower_02_b"
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_wizard_tower_01",
		"nik_loading_screen_wizard_tower_02",
		"nik_loading_screen_wizard_tower_01_b",
		"nik_loading_screen_wizard_tower_02_b"
	},
	locations = {
		"location_wizard_apothecary",
		"location_wizard_street",
		"location_wizard_library",
		"location_wizard_unknown",
		"location_wizard_wasteland",
		"location_wizard_endroom",
		"location_wizard_library_2",
		"location_wizard_escher_1",
		"location_wizard_escher_2",
		"location_wizard_escher_3",
		"location_wizard_dome_hall",
		"location_wizard_secret_passage"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 4,
		icon = "level_location_long_icon_03",
		area = "ubersreik",
		console_sorting = 5,
		wwise_events = {
			"nik_map_brief_wizard_tower_01",
			"nik_map_brief_wizard_tower_02"
		},
		area_position = {
			265,
			-80
		}
	}
}
LevelSettings.magnus = {
	environment_state = "exterior",
	display_name = "level_long_1",
	map_sorting = 1,
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/magnus",
	act = "prologue",
	level_image = "level_image_magnus",
	loading_bg_image = "loading_screen_magnus",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_magnus",
	ambient_sound_event = "silent_default_world_sound",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_2",
	boss_spawning_method = "hand_placed",
	loading_screen_gamemode_name = "level_gamemode_defend",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	level_name = "levels/magnus/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 14
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 15
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 10
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 10
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 10
		}
	},
	map_screen_wwise_events = {
		"nik_map_brief_magnus_tower_01",
		"nik_map_brief_magnus_tower_02",
		"nik_map_brief_magnus_tower_03",
		"nik_map_brief_magnus_tower_04"
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_magnus_tower_01",
		"nik_loading_screen_magnus_tower_02",
		"nik_loading_screen_magnus_tower_03",
		"nik_loading_screen_magnus_tower_04"
	},
	locations = {
		"location_magnus_gate_plaza",
		"location_magnus_guardhouse",
		"location_magnus_street",
		"location_magnus_the_slums",
		"location_magnus_waterfront",
		"location_magnus_tavern",
		"location_magnus_rooftops",
		"location_magnus_the_tower",
		"location_magnus_the_plaza",
		"location_magnus_horn_room",
		"location_magnus_the_garrison"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 1,
		icon = "level_location_long_icon_01",
		area = "ubersreik",
		console_sorting = 2,
		wwise_events = {
			"nik_map_brief_magnus_tower_01",
			"nik_map_brief_magnus_tower_02"
		},
		area_position = {
			-25,
			220
		}
	}
}
LevelSettings.end_boss = {
	knocked_down_setting = "knocked_down",
	display_name = "level_long_7",
	ambient_sound_event = "silent_default_world_sound",
	music_won_state = "won_endboss",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	act = "act_3",
	level_image = "level_image_end_boss",
	loading_bg_image = "loading_screen_end_boss",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_end_boss",
	level_name = "levels/end_boss/world",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_event",
	loading_screen_gamemode_name = "level_gamemode_boss_level",
	default_surface_material = "stone",
	conflict_settings = "endboss",
	package_name = "resource_packages/levels/end_boss",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 9,
			grenades = 9,
			healing = 11
		},
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 9,
			grenades = 9,
			healing = 12
		},
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 9,
			grenades = 9,
			healing = 8
		},
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 9,
			grenades = 9,
			healing = 7
		},
		{
			ammo = 6,
			lorebook_pages = 3,
			potions = 9,
			grenades = 9,
			healing = 7
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_end_boss_01",
		"nik_loading_screen_end_boss_02"
	},
	locations = {
		"location_endboss_street",
		"location_endboss_lair",
		"location_endboss_vista"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 13,
		icon = "level_location_long_icon_07",
		area = "ubersreik",
		console_sorting = 14,
		wwise_events = {
			"nik_map_brief_end_boss_01",
			"nik_map_brief_end_boss_02"
		},
		area_position = {
			380,
			150
		}
	}
}
LevelSettings.forest_ambush = {
	level_name = "levels/forest_ambush/world",
	display_name = "level_long_4",
	ambient_sound_event = "silent_default_world_sound",
	music_won_state = "won_boat",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	act = "act_2",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_forest_ambush",
	loading_bg_image = "loading_screen_forest_ambush",
	level_image = "level_image_forest_ambush",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_3",
	loading_screen_gamemode_name = "level_gamemode_sabotage",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/forest_ambush",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 6,
			grenades = 7,
			healing = 14
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 6,
			grenades = 7,
			healing = 15
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 6,
			grenades = 5,
			healing = 10
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 6,
			grenades = 5,
			healing = 10
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 6,
			grenades = 5,
			healing = 10
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_forest_ambush_01",
		"nik_loading_screen_forest_ambush_02"
	},
	locations = {
		"location_forest_reikwald",
		"location_forest_skaven_camp",
		"location_forest_mother_black",
		"location_forest_after_bridge",
		"location_forest_cave",
		"location_forest_road",
		"location_forest_ruins_entrance",
		"location_forest_ruins_inneryard",
		"location_forest_swamp"
	},
	level_particle_effects = {
		"fx/level_particles_dust"
	},
	level_screen_effects = {
		"fx/level_effect_screenspace_lensdirt"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 6,
		icon = "level_location_long_icon_04",
		area = "ubersreik",
		console_sorting = 7,
		wwise_events = {
			"nik_map_brief_forest_ambush_01",
			"nik_map_brief_forest_ambush_02"
		},
		area_position = {
			555,
			25
		}
	}
}
LevelSettings.docks_short_level = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "level_short_6",
	knocked_down_setting = "knocked_down",
	music_won_state = "won_boat",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	act = "act_3",
	level_image = "level_image_docks",
	loading_bg_image = "loading_screen_docks_short_level",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_docks",
	level_name = "levels/docks_short_level/world",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_1",
	loading_screen_gamemode_name = "level_gamemode_sabotage",
	disable_bot_main_path_teleport_check = true,
	default_surface_material = "stone_wet",
	conflict_settings = "event_level_with_roaming",
	package_name = "resource_packages/levels/docks_short_level",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 3,
			grenades = 4,
			healing = 10
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 3,
			grenades = 4,
			healing = 11
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 3,
			grenades = 4,
			healing = 7
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 3,
			grenades = 4,
			healing = 6
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 3,
			grenades = 4,
			healing = 6
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_docks_01",
		"nik_loading_screen_docks_02"
	},
	locations = {
		"location_docks_shipyard",
		"location_docks_warehouse",
		"location_docks_docks",
		"location_docks_back_streets",
		"location_docks_backyard",
		"location_docks_lumberyard"
	},
	map_settings = {
		sorting = 12,
		icon = "level_location_short_icon_04",
		area = "ubersreik",
		console_sorting = 13,
		wwise_events = {
			"nik_map_brief_docks_01",
			"nik_map_brief_docks_02"
		},
		area_position = {
			-266,
			-76
		}
	}
}
LevelSettings.dlc_castle = {
	level_name = "levels/dlc_castle/world",
	display_name = "dlc1_4_level_castle",
	default_surface_material = "stone",
	ambient_sound_event = "ambience_dlc_castle_inside_small_corridor",
	player_aux_bus_name = "environment_reverb_castle_small_hall",
	environment_state = "interior",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_dlc_castle",
	loading_bg_image = "loading_screen_dlc_castle",
	level_image = "level_image_dlc_castle",
	dlc_name = "drachenfels",
	required_act_completed = "prologue",
	boss_spawning_method = "hand_placed",
	game_mode = "adventure",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/dlc_castle",
	source_aux_bus_name = "environment_reverb_castle_small_hall_source",
	level_particle_effects = {},
	level_screen_effects = {},
	loading_screen_wwise_events = {
		"nik_loading_screen_castle_b_01",
		"nik_loading_screen_castle_b_02"
	},
	pickup_settings = {
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 8,
			grenades = 8,
			healing = 12
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 8,
			grenades = 8,
			healing = 13
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 8,
			grenades = 8,
			healing = 9
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 8,
			grenades = 8,
			healing = 9
		},
		{
			ammo = 7,
			lorebook_pages = 3,
			potions = 8,
			grenades = 8,
			healing = 9
		}
	},
	locations = {
		"dlc1_4_location_castle_ballroom",
		"dlc1_4_location_castle_before_sanctum",
		"dlc1_4_location_castle_floor_1",
		"dlc1_4_location_castle_floor_2",
		"dlc1_4_location_castle_catacombs",
		"dlc1_4_location_castle_entering_castle",
		"dlc1_4_location_castle_escape_catacombs",
		"dlc1_4_location_castle_inner_sanctum",
		"dlc1_4_location_castle_outside_end",
		"dlc1_4_location_castle_outside_start",
		"dlc1_4_location_castle_outside_bridge"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 16,
		icon = "level_location_dlc_icon_castle",
		area = "drachenfels",
		console_sorting = 17,
		wwise_events = {
			"nik_map_brief_castle_a_01",
			"nik_map_brief_castle_a_02"
		},
		area_position = {
			-212,
			107
		}
	}
}
LevelSettings.dlc_castle_dungeon = {
	level_name = "levels/dlc_castle_dungeon/world",
	display_name = "dlc1_4_level_castle_dungeon",
	environment_state = "interior",
	player_aux_bus_name = "environment_reverb_castle_medium_hall",
	game_mode = "adventure",
	loading_bg_image = "loading_screen_dlc_castle_dungeon",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_dlc_castle_dungeon",
	level_image = "level_image_dlc_castle_dungeon",
	dlc_name = "drachenfels",
	ambient_sound_event = "ambience_dlc_castle_inside_hall_corridor",
	required_act_completed = "prologue",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/dlc_castle_dungeon",
	source_aux_bus_name = "environment_reverb_castle_medium_hall_source",
	level_particle_effects = {},
	level_screen_effects = {},
	camera_backlight = COLD_CAMERA_BACKLIGHT,
	loading_screen_wwise_events = {
		"nik_loading_screen_dungeon_01",
		"nik_loading_screen_dungeon_02"
	},
	darkness_settings = {
		volumes = {
			"environment_catacombs_dark",
			"environment_tunnels_darker",
			"environment_catacombs_dark_1",
			"environment_catacombs_dark_trans_01",
			"environment_catacombs_dark_first"
		}
	},
	pickup_settings = {
		{
			ammo = 6,
			lorebook_pages = 2,
			potions = 9,
			grenades = 7,
			healing = 10
		},
		{
			ammo = 6,
			lorebook_pages = 2,
			potions = 8,
			grenades = 7,
			healing = 11
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 7,
			grenades = 7,
			healing = 9
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 7,
			grenades = 7,
			healing = 9
		},
		{
			ammo = 5,
			lorebook_pages = 2,
			potions = 7,
			grenades = 7,
			healing = 9
		}
	},
	locations = {
		"dlc1_4_location_dungeon_atrium",
		"dlc1_4_location_dungeon_dark_artifact2",
		"dlc1_4_location_dungeon_dark_part1",
		"dlc1_4_location_dungeon_dark_part2",
		"dlc1_4_location_dungeon_dark_part3",
		"dlc1_4_location_dungeon_entrance",
		"dlc1_4_location_dungeon_fenceroom",
		"dlc1_4_location_dungeon_jailroom",
		"dlc1_4_location_dungeon_outdoorbreak",
		"dlc1_4_location_dungeon_pillarroom",
		"dlc1_4_location_dungeon_alexander_tomb"
	},
	mini_patrol = {
		composition = mini_patrol
	},
	map_settings = {
		sorting = 17,
		icon = "level_location_dlc_icon_dungeon",
		area = "drachenfels",
		console_sorting = 18,
		wwise_events = {
			"nik_map_brief_dungeon_01",
			"nik_map_brief_dungeon_02"
		},
		area_position = {
			38,
			-65
		}
	}
}
LevelSettings.dlc_portals = {
	default_surface_material = "stone",
	display_name = "dlc1_4_level_portals",
	knocked_down_setting = "knocked_down",
	ambient_sound_event = "silent_default_world_sound",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	level_image = "level_image_dlc_portals",
	loading_bg_image = "loading_screen_dlc_portals",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_dlc_portals",
	level_name = "levels/dlc_portals/world",
	dlc_name = "drachenfels",
	required_act_completed = "prologue",
	game_mode = "adventure",
	conflict_settings = "dlc_portals",
	package_name = "resource_packages/levels/dlc_portals",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	loading_screen_wwise_events = {
		"nik_loading_screen_map_01",
		"nik_loading_screen_map_02"
	},
	pickup_settings = {
		{
			ammo = 12,
			lorebook_pages = 2,
			potions = 6,
			grenades = 8,
			healing = 10
		},
		{
			ammo = 12,
			lorebook_pages = 2,
			potions = 6,
			grenades = 8,
			healing = 10
		},
		{
			ammo = 12,
			lorebook_pages = 2,
			potions = 6,
			grenades = 8,
			healing = 10
		},
		{
			ammo = 12,
			lorebook_pages = 2,
			potions = 6,
			grenades = 8,
			healing = 10
		},
		{
			ammo = 12,
			lorebook_pages = 2,
			potions = 6,
			grenades = 8,
			healing = 10
		}
	},
	locations = {
		"dlc1_4_location_portals_outlook",
		"dlc1_4_location_portals_cliffside",
		"dlc1_4_location_portals_portal_a",
		"dlc1_4_location_portals_grave",
		"dlc1_4_location_portals_camp_a",
		"dlc1_4_location_portals_portal_b",
		"dlc1_4_location_portals_camp_b",
		"dlc1_4_location_portals_portal_c"
	},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 18,
		icon = "level_location_dlc_icon_portals",
		area = "drachenfels",
		console_sorting = 19,
		wwise_events = {
			"nik_map_brief_portals_01",
			"nik_map_brief_portals_02"
		},
		area_position = {
			470,
			120
		}
	}
}
LevelSettings.umbratest = {
	display_name = "Umbratest",
	package_name = "resource_packages/levels/debug/umbratest",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/umbratest/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 2,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.cutscene_test = {
	aux_bus_name = "environment_reverb_outside",
	level_name = "levels/debug/cutscene_test/world",
	display_name = "Cutscene Test",
	environment_state = "exterior",
	knocked_down_setting = "knocked_down",
	level_image = "level_image_any",
	package_name = "resource_packages/levels/debug/cutscene_test",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	ambient_sound_event = "silent_default_world_sound",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 2,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.vector_field_test = {
	aux_bus_name = "environment_reverb_outside",
	level_name = "levels/debug/vector_field_test/world",
	display_name = "Cutscene Test",
	environment_state = "exterior",
	knocked_down_setting = "knocked_down",
	level_image = "level_image_any",
	package_name = "resource_packages/levels/debug/vector_field_test",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	ambient_sound_event = "silent_default_world_sound",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 2,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.gdc_presentation = {
	display_name = "GDC AUTODESK PRESENTATION",
	package_name = "resource_packages/levels/debug/gdc_presentation",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/gdc_presentation/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 2,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.ai_benchmark = {
	display_name = "GDC AUTODESK PRESENTATION",
	package_name = "resource_packages/levels/benchmark/ai_benchmark",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/ai_benchmark/world",
	loading_bg_image = "loading_screen_cemetery",
	conflict_settings = "event_level_with_roaming_no_specials",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_image = "level_image_any",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 2,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.ai_benchmark_cycle = {
	level_image = "level_image_any",
	ambient_sound_event = "silent_default_world_sound",
	map_sorting = 0,
	package_name = "resource_packages/levels/benchmark/ai_benchmark_cycle",
	environment_state = "exterior",
	knocked_down_setting = "knocked_down",
	display_name = "AI BENCHMARK CYCLE",
	player_aux_bus_name = "environment_reverb_outside",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	conflict_settings = "event_level_with_roaming_no_specials",
	level_name = "levels/debug/ai_benchmark_cycle/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 2,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.outpost = {
	knocked_down_setting = "knocked_down",
	destroy_los_distance_squared = 600000,
	ambient_sound_event = "silent_default_world_sound",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/debug/outpost",
	display_name = "Outpost Survival",
	loading_bg_image = "loading_screen_cemetery",
	level_image = "level_image_any",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	conflict_settings = "event_level",
	level_name = "levels/debug/outpost/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 2,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.dark_woods = {
	level_image = "level_image_any",
	ambient_sound_event = "silent_default_world_sound",
	destroy_los_distance_squared = 600000,
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/debug/dark_woods",
	display_name = "Dark Woods Survival",
	conflict_settings = "survival",
	loading_bg_image = "loading_screen_cemetery",
	score_type = "wave_and_time",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/dark_woods/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	mini_patrol = {
		composition = false
	},
	map_settings = {
		sorting = 2,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.pickup_areas = {
	display_name = "Pickup Areas",
	package_name = "resource_packages/levels/debug/pickup_areas",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/pickup_areas/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 0,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.patrik_test = {
	display_name = "Patrik",
	package_name = "resource_packages/levels/debug/patrik_test",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/patrik_test/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 200,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.patrik_test_2 = {
	display_name = "Patrik 2",
	package_name = "resource_packages/levels/debug/patrik_test_2",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	ambient_sound_event = "silent_default_world_sound",
	knocked_down_setting = "knocked_down",
	level_name = "levels/debug/patrik_test_2/world",
	loading_bg_image = "loading_screen_cemetery",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_cemetery",
	level_image = "level_image_any",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {},
	map_settings = {
		sorting = 200,
		icon = "level_location_dlc_icon_01",
		area = "world"
	}
}
LevelSettings.dlc_survival_ruins = {
	ambient_sound_event = "silent_default_world_sound",
	destroy_los_distance_squared = 600000,
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/dlc_survival_ruins",
	environment_state = "exterior",
	display_name = "dlc1_2_level_survival_ruins",
	mini_patrol = false,
	conflict_settings = "survival",
	loading_bg_image = "loading_screen_survival_01_level",
	game_mode = "survival",
	dlc_name = "survival_ruins",
	level_image = "level_image_survival_02",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_survival_01",
	knocked_down_setting = "knocked_down",
	level_name = "levels/dlc_survival_ruins/world",
	starting_difficulty = "survival_hard",
	source_aux_bus_name = "environment_reverb_outside_source",
	loading_screen_wwise_events = {
		"nik_loading_screen_dlc_survival_ruins_01",
		"nik_loading_screen_dlc_survival_ruins_02"
	},
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {
		"dlc1_2_location_survival_ruins_castle",
		"dlc1_2_location_survival_ruins_bridge",
		"dlc1_2_location_survival_ruins_crane",
		"dlc1_2_location_survival_ruins_forest",
		"dlc1_2_location_survival_ruins_gate"
	},
	difficulties = {
		"survival_hard",
		"survival_harder",
		"survival_hardest"
	},
	map_settings = {
		sorting = 15,
		icon = "level_location_dlc_icon_01",
		area = "world",
		console_sorting = 16,
		wwise_events = {
			"nik_map_brief_dlc_survival_ruins_01",
			"nik_map_brief_dlc_survival_ruins_02"
		},
		area_position = {
			-240,
			-52
		}
	}
}
LevelSettings.dlc_survival_magnus = {
	ambient_sound_event = "silent_default_world_sound",
	destroy_los_distance_squared = 600000,
	player_aux_bus_name = "environment_reverb_outside",
	package_name = "resource_packages/levels/dlc_survival_magnus",
	environment_state = "exterior",
	display_name = "dlc1_2_level_survival_magnus",
	mini_patrol = false,
	loading_bg_image = "loading_screen_survival_02_level",
	conflict_settings = "survival",
	game_mode = "survival",
	level_image = "level_image_survival_01",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_survival_02",
	knocked_down_setting = "knocked_down",
	level_name = "levels/dlc_survival_magnus/world",
	starting_difficulty = "survival_hard",
	source_aux_bus_name = "environment_reverb_outside_source",
	loading_screen_wwise_events = {
		"nik_loading_screen_dlc_survival_general_01",
		"nik_loading_screen_dlc_survival_general_02",
		"nik_loading_screen_dlc_survival_general_03",
		"nik_loading_screen_dlc_survival_general_04",
		"nik_loading_screen_dlc_survival_general_05",
		"nik_loading_screen_dlc_survival_general_06"
	},
	level_particle_effects = {},
	level_screen_effects = {},
	locations = {
		"dlc1_2_location_survival_magnus_plaza",
		"dlc1_2_location_survival_magnus_tower",
		"dlc1_2_location_survival_magnus_wall",
		"dlc1_2_location_survival_magnus_market",
		"dlc1_2_location_survival_magnus_gate"
	},
	difficulties = {
		"survival_hard",
		"survival_harder",
		"survival_hardest"
	},
	map_settings = {
		sorting = 14,
		icon = "level_location_dlc_icon_02",
		area = "world",
		console_sorting = 15,
		wwise_events = {
			"nik_map_brief_dlc_survival_general_01",
			"nik_map_brief_dlc_survival_general_02",
			"nik_map_brief_dlc_survival_general_03",
			"nik_map_brief_dlc_survival_general_05",
			"nik_map_brief_dlc_survival_general_06"
		},
		area_position = {
			72,
			-30
		}
	}
}
LevelSettings.bridge = {
	knocked_down_setting = "knocked_down",
	display_name = "level_short_2",
	environment_state = "exterior",
	music_won_state = "won_boat",
	player_aux_bus_name = "environment_reverb_outside",
	act = "act_1",
	loading_bg_image = "loading_screen_bridge",
	level_image = "level_image_bridge",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_bridge",
	level_name = "levels/bridge/world",
	ambient_sound_event = "silent_default_world_sound",
	loading_screen_gamemode_name = "level_gamemode_raid",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_event",
	default_surface_material = "stone",
	conflict_settings = "event_level_with_roaming",
	package_name = "resource_packages/levels/bridge",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 12
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 12
		},
		{
			ammo = 3,
			lorebook_pages = 2,
			potions = 4,
			grenades = 2,
			healing = 7
		},
		{
			ammo = 3,
			lorebook_pages = 2,
			potions = 4,
			grenades = 2,
			healing = 7
		},
		{
			ammo = 3,
			lorebook_pages = 2,
			potions = 4,
			grenades = 2,
			healing = 7
		}
	},
	map_screen_wwise_events = {
		"nik_map_brief_bridge_01",
		"nik_map_brief_bridge_02",
		"nik_map_brief_bridge_03",
		"nik_map_brief_bridge_03"
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_bridge_01",
		"nik_loading_screen_bridge_02",
		"nik_loading_screen_bridge_03",
		"nik_loading_screen_bridge_04"
	},
	locations = {
		"location_bridge_port",
		"location_bridge_underbelly"
	},
	map_settings = {
		sorting = 5,
		icon = "level_location_short_icon_02",
		area = "ubersreik",
		console_sorting = 6,
		wwise_events = {
			"nik_map_brief_bridge_01",
			"nik_map_brief_bridge_02"
		},
		area_position = {
			70,
			0
		}
	}
}
LevelSettings.jansson = {
	knocked_down_setting = "knocked_down",
	display_name = "level_short_2",
	environment_state = "exterior",
	music_won_state = "won_boat",
	player_aux_bus_name = "environment_reverb_outside",
	act = "act_1",
	loading_bg_image = "loading_screen_bridge",
	level_image = "level_image_bridge",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_bridge",
	level_name = "levels/debug/testrange_jansson/world",
	ambient_sound_event = "silent_default_world_sound",
	loading_screen_gamemode_name = "level_gamemode_raid",
	loading_screen_gamemode_prefix = "level_gamemode_prefix_event",
	default_surface_material = "stone",
	conflict_settings = "event_level_with_roaming",
	package_name = "resource_packages/levels/debug/testrange_jansson",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	pickup_settings = {
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 12
		},
		{
			ammo = 4,
			lorebook_pages = 2,
			potions = 5,
			grenades = 4,
			healing = 12
		},
		{
			ammo = 3,
			lorebook_pages = 2,
			potions = 4,
			grenades = 2,
			healing = 7
		},
		{
			ammo = 3,
			lorebook_pages = 2,
			potions = 4,
			grenades = 2,
			healing = 7
		},
		{
			ammo = 3,
			lorebook_pages = 2,
			potions = 4,
			grenades = 2,
			healing = 7
		}
	},
	map_screen_wwise_events = {
		"nik_map_brief_bridge_01",
		"nik_map_brief_bridge_02",
		"nik_map_brief_bridge_03",
		"nik_map_brief_bridge_03"
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_bridge_01",
		"nik_loading_screen_bridge_02",
		"nik_loading_screen_bridge_03",
		"nik_loading_screen_bridge_04"
	},
	locations = {},
	map_settings = {
		sorting = 5,
		icon = "level_location_short_icon_02",
		area = "ubersreik",
		console_sorting = 6,
		wwise_events = {
			"nik_map_brief_bridge_01",
			"nik_map_brief_bridge_02"
		},
		area_position = {
			70,
			0
		}
	}
}

for level_key, level_data in pairs(LevelSettings) do
	if level_data.display_name then
		level_data.level_id = level_key
		level_data.game_mode = level_data.game_mode or "adventure"

		fassert(LevelGameModeTypes[level_data.game_mode], "Unsupported game mode type specified on %q", level_key)
	end
end

LevelSettingsMeta = LevelSettingsMeta or {}

LevelSettingsMeta.__index = function (table, key)
	Application.error(string.format("LevelSettings has no level %q\n", tostring(key)))
	Application.error("Maybe you were looking for one of these:")

	for key, value in pairs(LevelSettings) do
		Application.error(key)
	end

	error("")
end

setmetatable(LevelSettings, LevelSettingsMeta)

return
