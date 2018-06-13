LevelSettings = LevelSettings or {}
LevelSettings.chamber = {
	level_image = "level_image_dlc_chamber",
	display_name = "dlc1_11_chamber",
	package_name = "resource_packages/levels/dlc_chamber/chamber",
	music_won_state = "won_boat",
	player_aux_bus_name = "environment_reverb_outside",
	environment_state = "exterior",
	use_end_screen_overlay = true,
	loading_bg_image = "loading_screen_dlc_challenge_wizard",
	console_area = "location_wizard_wasteland",
	console_level_filter_image = "area_image_chamber_01",
	dlc_name = "chamber",
	required_act_completed = "act_4",
	boss_spawning_method = "hand_placed",
	ambient_sound_event = "silent_default_world_sound",
	loading_ui_package_name = "resource_packages/loading_screens/loading_bg_dlc_challenge_wizard",
	dlc_level = true,
	knocked_down_setting = "knocked_down",
	level_name = "levels/dlc_chamber/world",
	source_aux_bus_name = "environment_reverb_outside_source",
	level_particle_effects = {},
	level_screen_effects = {},
	loading_screen_wwise_events = {
		"nik_loading_screen_chamber_01",
		"nik_loading_screen_chamber_02"
	},
	locations = {
		"location_chamber_cellar",
		"location_chamber_sewers",
		"location_chamber_corridors",
		"location_chamber_tunnels",
		"location_chamber_chamber"
	},
	pickup_settings = {
		{
			ammo = 4,
			grenades = 4,
			healing = 12,
			potions = 5
		},
		{
			ammo = 4,
			grenades = 4,
			healing = 12,
			potions = 5
		},
		{
			ammo = 3,
			grenades = 2,
			healing = 7,
			potions = 4
		},
		{
			ammo = 3,
			grenades = 2,
			healing = 7,
			potions = 4
		},
		{
			ammo = 3,
			grenades = 2,
			healing = 7,
			potions = 4
		}
	},
	loading_screen_wwise_events = {
		"nik_loading_screen_chamber_01",
		"nik_loading_screen_chamber_02"
	},
	map_settings = {
		sorting = 27,
		icon = "level_location_dlc_icon_chamber",
		area = "ubersreik",
		console_sorting = 101,
		area_position = {
			-150,
			290
		},
		wwise_events = {
			"nik_map_brief_chamber_01",
			"nik_map_brief_chamber_02"
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
	},
	dlc_stat_dependency_func = function (statistics_db, stats_id)
		if PLATFORM ~= "win32" then
			local title_properties = Managers.backend:get_interface("title_properties")
			local dlc_chamber_enabled = title_properties:get_value("dlc_chamber_enabled")

			return (dlc_chamber_enabled and "visible") or "hidden", dlc_chamber_enabled, ""
		else
			return "visible", true, ""
		end
	end
}

return
