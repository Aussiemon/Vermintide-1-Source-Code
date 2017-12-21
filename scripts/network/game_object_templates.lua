local game_object_templates = {
	player_unit = {
		game_object_created_func_name = "game_object_created_player_unit",
		syncs_position = true,
		syncs_pitch_yaw = true,
		game_object_destroyed_func_name = "game_object_destroyed_player_unit",
		is_level_unit = false
	},
	ai_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	player_bot_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_pitch_yaw = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	ai_unit_with_inventory = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	ai_unit_pack_master = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	ai_unit_ratling_gunner = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	player_projectile_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = false,
		syncs_rotation = false,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	flame_wave_projectile_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = false,
		syncs_rotation = false,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	true_flight_projectile_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	aoe_projectile_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = false,
		syncs_rotation = false,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	projectile_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = false,
		syncs_rotation = false,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	pickup_projectile_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	pickup_torch_unit_init = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	pickup_torch_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	pickup_projectile_unit_limited = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	explosive_pickup_projectile_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	explosive_pickup_projectile_unit_limited = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	aoe_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	pickup_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	objective_pickup_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	prop_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = false,
		syncs_rotation = false,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	interest_point_level_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		is_level_unit = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit"
	},
	interest_point_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		syncs_position = true,
		syncs_rotation = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit",
		is_level_unit = false
	},
	player = {
		game_object_created_func_name = "game_object_created_player",
		game_object_destroyed_func_name = "game_object_destroyed_player"
	},
	music_states = {
		game_object_created_func_name = "game_object_created_music_states",
		game_session_disconnect_func_name = "game_session_disconnect_music_states",
		game_object_destroyed_func_name = "game_object_destroyed_music_states"
	},
	base_level_unit = {
		game_object_created_func_name = "game_object_created_network_unit",
		is_level_unit = true,
		game_object_destroyed_func_name = "game_object_destroyed_network_unit"
	},
	sync_unit = {
		game_object_created_func_name = "game_object_created_sync_unit",
		is_level_unit = false,
		game_object_destroyed_func_name = "game_object_destroyed_sync_unit"
	}
}

for go_template_name, go_template in pairs(game_object_templates) do
	go_template.go_type = go_template_name
end

return game_object_templates
