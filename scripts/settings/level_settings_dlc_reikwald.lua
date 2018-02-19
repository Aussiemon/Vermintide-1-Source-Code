LevelSettings = LevelSettings or {}
LevelSettings.dlc_reikwald_forest = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "dlc1_10_reikwald_forest_name",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside_forest",
	level_name = "levels/dlc_reikwald_forest/world",
	level_image = "level_image_dlc_reikwald_forest",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_dlc_reikwald_forest",
	dlc_level = true,
	loading_bg_image = "loading_screen_dlc_reikwald_forest",
	dlc_name = "reikwald",
	required_act_completed = "prologue",
	boss_spawning_method = "hand_placed",
	default_surface_material = "dirt",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/dlc_reikwald/dlc_reikwald_forest",
	source_aux_bus_name = "environment_reverb_outside_forest_source",
	level_particle_effects = {},
	level_screen_effects = {},
	camera_backlight = COLD_CAMERA_BACKLIGHT,
	pickup_settings = {
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 16
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 17
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 12
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 12
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 12
		}
	},
	darkness_settings = {
		local_player_light_intensity = 3,
		volumes = {}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_reikwald_forest_01",
		"nik_loading_screen_reikwald_forest_02"
	},
	locations = {
		"dlc1_10_reikwald_location_forest",
		"dlc1_10_reikwald_location_glade",
		"dlc1_10_reikwald_location_camp",
		"dlc1_10_reikwald_location_cave",
		"dlc1_10_reikwald_location_stream",
		"dlc1_10_reikwald_location_forest2",
		"dlc1_10_reikwald_location_village",
		"dlc1_10_reikwald_location_docks"
	},
	map_settings = {
		sorting = 26,
		icon = "level_location_dlc_icon_reikwald_01",
		area = "reikwald",
		area_position = {
			-250,
			-230
		},
		wwise_events = {
			"nik_map_brief_reikwald_forest_01",
			"nik_map_brief_reikwald_forest_02"
		}
	},
	mini_patrol = {
		composition = false
	},
	quest_settings = {
		level = true,
		tome = true,
		grimoire = true,
		ogre = true
	}
}
LevelSettings.dlc_reikwald_river = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "dlc1_10_reikwald_river_name",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	level_name = "levels/dlc_reikwald_river/world",
	level_image = "level_image_dlc_reikwald_river",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_dlc_reikwald_river",
	dlc_level = true,
	loading_bg_image = "loading_screen_dlc_reikwald_river",
	dlc_name = "reikwald",
	required_act_completed = "prologue",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone_wet",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/dlc_reikwald/dlc_reikwald_river",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	camera_backlight = COLD_CAMERA_BACKLIGHT,
	pickup_settings = {
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 16
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 17
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 12
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 12
		},
		{
			ammo = 8,
			lorebook_pages = 3,
			potions = 10,
			grenades = 9,
			healing = 12
		}
	},
	darkness_settings = {
		local_player_light_intensity = 3,
		volumes = {
			"volume_environment_fog"
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_reikwald_river_01",
		"nik_loading_screen_reikwald_river_02"
	},
	locations = {
		"dlc1_10_reik_location_campsite",
		"dlc1_10_reik_location_cave",
		"dlc1_10_reik_location_cellar",
		"dlc1_10_reik_location_coaching_inn",
		"dlc1_10_reik_location_cottage",
		"dlc1_10_reik_location_cove",
		"dlc1_10_reik_location_dawnrunner",
		"dlc1_10_reik_location_flats",
		"dlc1_10_reik_location_mud_mine",
		"dlc1_10_reik_location_river",
		"dlc1_10_reik_location_river_boat",
		"dlc1_10_reik_location_swamp",
		"dlc1_10_reik_location_tributary"
	},
	map_settings = {
		sorting = 26,
		icon = "level_location_dlc_icon_reikwald_02",
		area = "reikwald",
		area_position = {
			450,
			-70
		},
		wwise_events = {
			"nik_map_brief_reikwald_river_01",
			"nik_map_brief_reikwald_river_02"
		}
	},
	mini_patrol = {
		composition = false
	},
	quest_settings = {
		level = true,
		tome = true,
		grimoire = true,
		ogre = true
	}
}

return 
