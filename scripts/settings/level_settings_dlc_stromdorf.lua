LevelSettings = LevelSettings or {}
LevelSettings.dlc_stromdorf_town = {
	level_name = "levels/dlc_stromdorf_town/world",
	display_name = "dlc1_6_stromdorf_town",
	ambient_sound_event = "silent_default_world_sound",
	environment_state = "exterior",
	player_aux_bus_name = "environment_reverb_outside",
	dlc_level = true,
	loading_bg_image = "loading_screen_dlc_stromdorf_town",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_dlc_stromdorf_town",
	dlc_name = "stromdorf",
	required_act_completed = "prologue",
	level_image = "level_image_dlc_stromdorf_town",
	boss_spawning_method = "hand_placed",
	default_surface_material = "stone_wet",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/dlc_stromdorf/dlc_stromdorf_town",
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
	loading_screen_wwise_events = {
		"nik_loading_screen_stromdorf_town_01",
		"nik_loading_screen_stromdorf_town_02"
	},
	locations = {
		"location_stromdorf_coffin_road",
		"location_stromdorf_west_gate",
		"location_stromdorf_west_road",
		"location_stromdorf_market",
		"location_stromdorf_east_road",
		"location_stromdorf_alleys",
		"location_stromdorf_north_road",
		"location_stromdorf_tannery",
		"location_stromdorf_north_gate"
	},
	map_settings = {
		sorting = 27,
		icon = "level_location_dlc_icon_stromdorf_02",
		area = "stromdorf",
		console_sorting = 28,
		area_position = {
			50,
			-40
		},
		wwise_events = {
			"nik_map_brief_stromdorf_town_01",
			"nik_map_brief_stromdorf_town_02"
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
LevelSettings.dlc_stromdorf_hills = {
	ambient_sound_event = "silent_default_world_sound",
	display_name = "dlc1_6_stromdorf_hills",
	environment_state = "exterior",
	music_won_state = "won_boat",
	player_aux_bus_name = "environment_reverb_outside",
	level_name = "levels/dlc_stromdorf_hills/world",
	level_image = "level_image_dlc_stromdorf_hills",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_dlc_stromdorf_hills",
	dlc_level = true,
	loading_bg_image = "loading_screen_dlc_stromdorf_hills",
	dlc_name = "stromdorf",
	required_act_completed = "prologue",
	boss_spawning_method = "hand_placed",
	default_surface_material = "grass",
	knocked_down_setting = "knocked_down",
	package_name = "resource_packages/levels/dlc_stromdorf/dlc_stromdorf_hills",
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
	locations = {
		"location_stromdorf_hills_beach",
		"location_stromdorf_hills_hills",
		"location_stromdorf_hills_canyon",
		"location_stromdorf_hills_tower",
		"location_stromdorf_hills_marsh",
		"location_stromdorf_hills_cemetery",
		"location_stromdorf_hills_chamber",
		"location_stromdorf_hills_passage",
		"location_stromdorf_hills_gate"
	},
	darkness_settings = {
		volumes = {
			"environment_darkness"
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_stromdorf_hills_01",
		"nik_loading_screen_stromdorf_hills_02"
	},
	map_settings = {
		sorting = 26,
		icon = "level_location_dlc_icon_stromdorf_01",
		area = "stromdorf",
		console_sorting = 27,
		area_position = {
			-130,
			50
		},
		wwise_events = {
			"nik_map_brief_stromdorf_hills_01",
			"nik_map_brief_stromdorf_hills_02"
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
