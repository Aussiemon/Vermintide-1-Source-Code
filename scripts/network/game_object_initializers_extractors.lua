local go_type_table = nil
local temp_table = {}

local function enemy_unit_common_extractor(unit, game_session, game_object_id)
	local breed_name_id = GameSession.game_object_field(game_session, game_object_id, "breed_name")
	local breed_name = NetworkLookup.breeds[breed_name_id]
	local breed = Breeds[breed_name]

	Unit.set_data(unit, "breed", breed)

	local level_settings = LevelSettings[Managers.state.game_mode:level_key()]

	if level_settings.climate_type then
		Unit.set_flow_variable(unit, "climate_type", level_settings.climate_type)
		Unit.flow_event(unit, "climate_type_set")
	end

	local size_variation_range = breed.size_variation_range

	if size_variation_range then
		local size_variation_normalized = GameSession.game_object_field(game_session, game_object_id, "size_variation_normalized")
		local size_variation = math.lerp(size_variation_range[1], size_variation_range[2], size_variation_normalized)
		local root_node = Unit.node(unit, "root_point")

		Unit.set_local_scale(unit, root_node, Vector3(size_variation, size_variation, size_variation))
	end

	return breed, breed_name
end

go_type_table = {
	initializers = {
		player_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local player = ScriptUnit.extension(unit, "input_system").player
			local mover = Unit.mover(unit)
			local profile_id = player.profile_index

			assert(profile_id)

			local profile = SPProfiles[profile_id]

			assert(profile, "No such profile with index %s", tostring(profile_id))

			local husk_unit = profile.base_units.third_person_husk
			local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
			local aim_position = first_person_extension.current_position(first_person_extension)
			local rotation = Unit.local_rotation(unit, 0)
			local experience = ExperienceSettings.get_experience()
			local level = ExperienceSettings.get_level(experience)
			local max_health = ScriptUnit.extension(unit, "health_system"):initial_max_health()

			fassert(max_health and 0 < max_health, "Trying to create player unit with invalid max health: %s", tostring(max_health))

			local max_wounds = ScriptUnit.extension(unit, "status_system"):max_wounds_network_safe()
			local data_table = {
				moving_platform = 0,
				go_type = NetworkLookup.go_types.player_unit,
				husk_unit = NetworkLookup.husks[husk_unit],
				health = max_health,
				wounds = max_wounds,
				level = level,
				prestige_level = ProgressionUnlocks.get_prestige_level(),
				position = Mover.position(mover),
				pitch = Quaternion.pitch(rotation),
				yaw = Quaternion.yaw(rotation),
				owner_peer_id = player.network_id(player),
				local_player_id = player.local_player_id(player),
				aim_direction = Vector3(1, 0, 0),
				aim_position = aim_position,
				velocity = Vector3(0, 0, 0),
				average_velocity = Vector3(0, 0, 0),
				profile_id = profile_id
			}

			return data_table
		end,
		ai_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local mover = Unit.mover(unit)
			local breed = Unit.get_data(unit, "breed")
			local ai_extension = ScriptUnit.extension(unit, "ai_system")
			local size_variation, size_variation_normalized = ai_extension.size_variation(ai_extension)
			local data_table = {
				has_teleported = 1,
				go_type = NetworkLookup.go_types.ai_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				health = ScriptUnit.extension(unit, "health_system"):get_max_health(),
				position = (mover and Mover.position(mover)) or Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				velocity = Vector3(0, 0, 0),
				breed_name = NetworkLookup.breeds[breed.name],
				size_variation_normalized = size_variation_normalized,
				bt_action_name = NetworkLookup.bt_action_names["n/a"]
			}

			return data_table
		end,
		player_bot_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local player = Managers.player:owner(unit)
			local mover = Unit.mover(unit)
			local profile_id = player.profile_index

			assert(profile_id)

			local profile = SPProfiles[profile_id]

			assert(profile, "No such profile with index %s", tostring(profile_id))

			local husk_unit = profile.base_units.third_person_husk
			local max_health = ScriptUnit.extension(unit, "health_system"):initial_max_health()
			local max_wounds = ScriptUnit.extension(unit, "status_system"):max_wounds_network_safe()
			local rotation = Unit.local_rotation(unit, 0)
			local data_table = {
				prestige_level = 0,
				moving_platform = 0,
				level = 0,
				go_type = NetworkLookup.go_types.player_bot_unit,
				husk_unit = NetworkLookup.husks[husk_unit],
				health = max_health,
				wounds = max_wounds,
				position = (mover and Mover.position(mover)) or Unit.local_position(unit, 0),
				pitch = Quaternion.pitch(rotation),
				yaw = Quaternion.yaw(rotation),
				velocity = Vector3(0, 0, 0),
				average_velocity = Vector3(0, 0, 0),
				owner_peer_id = player.network_id(player),
				local_player_id = player.local_player_id(player),
				aim_direction = Vector3(1, 0, 0),
				profile_id = profile_id
			}

			return data_table
		end,
		ai_unit_with_inventory = function (unit, unit_name, unit_template, gameobject_functor_context)
			local mover = Unit.mover(unit)
			local breed = Unit.get_data(unit, "breed")
			local ai_extension = ScriptUnit.extension(unit, "ai_system")
			local size_variation, size_variation_normalized = ai_extension.size_variation(ai_extension)
			local inventory_configuration_name = ScriptUnit.extension(unit, "ai_inventory_system").inventory_configuration_name
			local data_table = {
				has_teleported = 1,
				go_type = NetworkLookup.go_types.ai_unit_with_inventory,
				husk_unit = NetworkLookup.husks[unit_name],
				health = ScriptUnit.extension(unit, "health_system"):get_max_health(),
				position = (mover and Mover.position(mover)) or Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				velocity = Vector3(0, 0, 0),
				breed_name = NetworkLookup.breeds[breed.name],
				size_variation_normalized = size_variation_normalized,
				inventory_configuration = NetworkLookup.ai_inventory[inventory_configuration_name],
				bt_action_name = NetworkLookup.bt_action_names["n/a"]
			}

			return data_table
		end,
		ai_unit_pack_master = function (unit, unit_name, unit_template, gameobject_functor_context)
			local mover = Unit.mover(unit)
			local breed = Unit.get_data(unit, "breed")
			local ai_extension = ScriptUnit.extension(unit, "ai_system")
			local size_variation, size_variation_normalized = ai_extension.size_variation(ai_extension)
			local inventory_configuration_name = ScriptUnit.extension(unit, "ai_inventory_system").inventory_configuration_name
			local data_table = {
				has_teleported = 1,
				go_type = NetworkLookup.go_types.ai_unit_pack_master,
				husk_unit = NetworkLookup.husks[unit_name],
				health = ScriptUnit.extension(unit, "health_system"):get_max_health(),
				position = (mover and Mover.position(mover)) or Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				velocity = Vector3(0, 0, 0),
				breed_name = NetworkLookup.breeds[breed.name],
				size_variation_normalized = size_variation_normalized,
				inventory_configuration = NetworkLookup.ai_inventory[inventory_configuration_name],
				bt_action_name = NetworkLookup.bt_action_names["n/a"]
			}

			return data_table
		end,
		ai_unit_ratling_gunner = function (unit, unit_name, unit_template, gameobject_functor_context)
			local mover = Unit.mover(unit)
			local breed = Unit.get_data(unit, "breed")
			local ai_extension = ScriptUnit.extension(unit, "ai_system")
			local size_variation, size_variation_normalized = ai_extension.size_variation(ai_extension)
			local inventory_configuration_name = ScriptUnit.extension(unit, "ai_inventory_system").inventory_configuration_name
			local data_table = {
				has_teleported = 1,
				go_type = NetworkLookup.go_types.ai_unit_ratling_gunner,
				husk_unit = NetworkLookup.husks[unit_name],
				health = ScriptUnit.extension(unit, "health_system"):get_max_health(),
				position = (mover and Mover.position(mover)) or Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				velocity = Vector3(0, 0, 0),
				breed_name = NetworkLookup.breeds[breed.name],
				size_variation_normalized = size_variation_normalized,
				inventory_configuration = NetworkLookup.ai_inventory[inventory_configuration_name],
				aim_target = Vector3.zero(),
				bt_action_name = NetworkLookup.bt_action_names["n/a"]
			}

			return data_table
		end,
		flame_wave_projectile_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local projectile_extension = ScriptUnit.extension(unit, "projectile_system")
			local item_name = projectile_extension.item_name
			local item_template_name = projectile_extension.action_lookup_data.item_template_name
			local action_name = projectile_extension.action_lookup_data.action_name
			local sub_action_name = projectile_extension.action_lookup_data.sub_action_name
			local scale = projectile_extension.scale*100
			local impact_extension = ScriptUnit.extension(unit, "projectile_impact_system")
			local owner_unit = impact_extension.owner_unit
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local position, flat_angle, lateral_speed, initial_forward_speed, distance_travelled = locomotion_extension.get_game_object_data(locomotion_extension)
			local data_table = {
				go_type = NetworkLookup.go_types.flame_wave_projectile_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				owner_unit = (Unit.alive(owner_unit) and Managers.state.network:unit_game_object_id(owner_unit)) or 0,
				item_name = NetworkLookup.item_names[item_name],
				item_template_name = NetworkLookup.item_template_names[item_template_name],
				action_name = NetworkLookup.actions[action_name],
				sub_action_name = NetworkLookup.sub_actions[sub_action_name],
				scale = scale,
				position = position,
				flat_angle = flat_angle%(math.pi*2),
				lateral_speed = lateral_speed,
				distance_travelled = distance_travelled,
				initial_forward_speed = initial_forward_speed
			}

			return data_table
		end,
		player_projectile_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local angle = locomotion_extension.angle
			local target_vector = locomotion_extension.target_vector
			local initial_position = locomotion_extension.initial_position_boxed:unbox()
			local speed = locomotion_extension.speed
			local gravity_settings = locomotion_extension.gravity_settings
			local trajectory_template_name = locomotion_extension.trajectory_template_name
			local fast_forward_time = -(locomotion_extension.t - Managers.time:time("game"))
			local impact_extension = ScriptUnit.extension(unit, "projectile_impact_system")
			local owner_unit = impact_extension.owner_unit
			local projectile_extension = ScriptUnit.extension(unit, "projectile_system")
			local item_name = projectile_extension.item_name
			local item_template_name = projectile_extension.action_lookup_data.item_template_name
			local action_name = projectile_extension.action_lookup_data.action_name
			local sub_action_name = projectile_extension.action_lookup_data.sub_action_name
			local scale = projectile_extension.scale*100
			local data_table = {
				go_type = NetworkLookup.go_types.player_projectile_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				angle = angle,
				initial_position = initial_position,
				target_vector = target_vector,
				speed = speed,
				gravity_settings = NetworkLookup.projectile_gravity_settings[gravity_settings],
				trajectory_template_name = NetworkLookup.projectile_templates[trajectory_template_name],
				owner_unit = (Unit.alive(owner_unit) and Managers.state.network:unit_game_object_id(owner_unit)) or 0,
				item_name = NetworkLookup.item_names[item_name],
				item_template_name = NetworkLookup.item_template_names[item_template_name],
				action_name = NetworkLookup.actions[action_name],
				sub_action_name = NetworkLookup.sub_actions[sub_action_name],
				scale = scale,
				fast_forward_time = fast_forward_time
			}

			return data_table
		end,
		player_projectile_physic_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local owner_unit = locomotion_extension.owner_unit
			local network_position = locomotion_extension.network_position
			local network_rotation = locomotion_extension.network_rotation
			local network_velocity = locomotion_extension.network_velocity
			local network_angular_velocity = locomotion_extension.network_angular_velocity
			local impact_extension = ScriptUnit.extension(unit, "projectile_impact_system")
			local collision_filter = impact_extension.collision_filter
			local owner_unit = impact_extension.owner_unit
			local projectile_extension = ScriptUnit.extension(unit, "projectile_system")
			local item_name = projectile_extension.item_name
			local item_template_name = projectile_extension.action_lookup_data.item_template_name
			local action_name = projectile_extension.action_lookup_data.action_name
			local sub_action_name = projectile_extension.action_lookup_data.sub_action_name
			local time_initialized = projectile_extension.time_initialized
			local scale = projectile_extension.scale*100
			local data_table = {
				go_type = NetworkLookup.go_types.player_projectile_physic_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				collision_filter = NetworkLookup.collision_filters[collision_filter],
				owner_unit = Managers.state.network:unit_game_object_id(owner_unit),
				item_name = NetworkLookup.item_names[item_name],
				item_template_name = NetworkLookup.item_template_names[item_template_name],
				action_name = NetworkLookup.actions[action_name],
				sub_action_name = NetworkLookup.sub_actions[sub_action_name],
				scale = scale
			}

			return data_table
		end,
		pickup_projectile_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local network_position = locomotion_extension.network_position
			local network_rotation = locomotion_extension.network_rotation
			local network_velocity = locomotion_extension.network_velocity
			local network_angular_velocity = locomotion_extension.network_angular_velocity
			local pickup_extension = ScriptUnit.extension(unit, "pickup_system")
			local pickup_name = pickup_extension.pickup_name
			local has_physics = pickup_extension.has_physics
			local spawn_type = pickup_extension.spawn_type
			local data_table = {
				go_type = NetworkLookup.go_types.pickup_projectile_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				network_position = network_position,
				network_rotation = network_rotation,
				network_velocity = network_velocity,
				network_angular_velocity = network_angular_velocity,
				debug_pos = Unit.local_position(unit, 0),
				pickup_name = NetworkLookup.pickup_names[pickup_name],
				has_physics = has_physics,
				spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
			}

			return data_table
		end,
		pickup_torch_unit_init = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local network_position = locomotion_extension.network_position
			local network_rotation = locomotion_extension.network_rotation
			local network_velocity = locomotion_extension.network_velocity
			local network_angular_velocity = locomotion_extension.network_angular_velocity
			local pickup_extension = ScriptUnit.extension(unit, "pickup_system")
			local pickup_name = pickup_extension.pickup_name
			local has_physics = pickup_extension.has_physics
			local spawn_type = pickup_extension.spawn_type
			local data_table = {
				go_type = NetworkLookup.go_types.pickup_torch_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				network_position = network_position,
				network_rotation = network_rotation,
				network_velocity = network_velocity,
				network_angular_velocity = network_angular_velocity,
				debug_pos = Unit.local_position(unit, 0),
				pickup_name = NetworkLookup.pickup_names[pickup_name],
				has_physics = has_physics,
				spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
			}

			return data_table
		end,
		pickup_torch_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local network_position = locomotion_extension.network_position
			local network_rotation = locomotion_extension.network_rotation
			local network_velocity = locomotion_extension.network_velocity
			local network_angular_velocity = locomotion_extension.network_angular_velocity
			local pickup_extension = ScriptUnit.extension(unit, "pickup_system")
			local pickup_name = pickup_extension.pickup_name
			local has_physics = pickup_extension.has_physics
			local spawn_type = pickup_extension.spawn_type
			local data_table = {
				go_type = NetworkLookup.go_types.pickup_torch_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				network_position = network_position,
				network_rotation = network_rotation,
				network_velocity = network_velocity,
				network_angular_velocity = network_angular_velocity,
				debug_pos = Unit.local_position(unit, 0),
				pickup_name = NetworkLookup.pickup_names[pickup_name],
				has_physics = has_physics,
				spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
			}

			return data_table
		end,
		pickup_projectile_unit_limited = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local network_position = locomotion_extension.network_position
			local network_rotation = locomotion_extension.network_rotation
			local network_velocity = locomotion_extension.network_velocity
			local network_angular_velocity = locomotion_extension.network_angular_velocity
			local pickup_extension = ScriptUnit.extension(unit, "pickup_system")
			local pickup_name = pickup_extension.pickup_name
			local has_physics = pickup_extension.has_physics
			local spawn_type = pickup_extension.spawn_type
			local limited_item_extension = ScriptUnit.extension(unit, "limited_item_track_system")
			local spawner_unit = limited_item_extension.spawner_unit
			local id = limited_item_extension.id
			local world = gameobject_functor_context.world
			local level = LevelHelper:current_level(world)
			local spawner_unit_index = Level.unit_index(level, spawner_unit)
			local data_table = {
				go_type = NetworkLookup.go_types.pickup_projectile_unit_limited,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				network_position = network_position,
				network_rotation = network_rotation,
				network_velocity = network_velocity,
				network_angular_velocity = network_angular_velocity,
				debug_pos = Unit.local_position(unit, 0),
				spawner_unit = spawner_unit_index,
				limited_item_id = id,
				pickup_name = NetworkLookup.pickup_names[pickup_name],
				has_physics = has_physics,
				spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
			}

			return data_table
		end,
		explosive_pickup_projectile_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local network_position = locomotion_extension.network_position
			local network_rotation = locomotion_extension.network_rotation
			local network_velocity = locomotion_extension.network_velocity
			local network_angular_velocity = locomotion_extension.network_angular_velocity
			local pickup_extension = ScriptUnit.extension(unit, "pickup_system")
			local pickup_name = pickup_extension.pickup_name
			local has_physics = pickup_extension.has_physics
			local spawn_type = pickup_extension.spawn_type
			local health_extension = ScriptUnit.extension(unit, "health_system")
			local damage = health_extension.damage
			local death_extension = ScriptUnit.extension(unit, "death_system")
			local explode_time = 0
			local fuse_time = 0

			if death_extension.has_death_started(death_extension) then
				explode_time = death_extension.death_reaction_data.explode_time
				fuse_time = death_extension.death_reaction_data.fuse_time
			end

			local item_name = death_extension.item_name
			local data_table = {
				go_type = NetworkLookup.go_types.explosive_pickup_projectile_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				network_position = network_position,
				network_rotation = network_rotation,
				network_velocity = network_velocity,
				network_angular_velocity = network_angular_velocity,
				debug_pos = Unit.local_position(unit, 0),
				pickup_name = NetworkLookup.pickup_names[pickup_name],
				has_physics = has_physics,
				spawn_type = NetworkLookup.pickup_spawn_types[spawn_type],
				damage = damage,
				explode_time = explode_time,
				fuse_time = fuse_time,
				item_name = NetworkLookup.item_names[item_name]
			}

			return data_table
		end,
		explosive_pickup_projectile_unit_limited = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local network_position = locomotion_extension.network_position
			local network_rotation = locomotion_extension.network_rotation
			local network_velocity = locomotion_extension.network_velocity
			local network_angular_velocity = locomotion_extension.network_angular_velocity
			local pickup_extension = ScriptUnit.extension(unit, "pickup_system")
			local pickup_name = pickup_extension.pickup_name
			local has_physics = pickup_extension.has_physics
			local spawn_type = pickup_extension.spawn_type
			local limited_item_extension = ScriptUnit.extension(unit, "limited_item_track_system")
			local spawner_unit = limited_item_extension.spawner_unit
			local id = limited_item_extension.id
			local health_extension = ScriptUnit.extension(unit, "health_system")
			local damage = health_extension.damage
			local death_extension = ScriptUnit.extension(unit, "death_system")
			local explode_time = 0
			local fuse_time = 0

			if death_extension.has_death_started(death_extension) then
				explode_time = death_extension.death_reaction_data.explode_time
				fuse_time = death_extension.death_reaction_data.fuse_time
			end

			local item_name = death_extension.item_name
			local world = gameobject_functor_context.world
			local level = LevelHelper:current_level(world)
			local spawner_unit_index = Level.unit_index(level, spawner_unit)
			local data_table = {
				go_type = NetworkLookup.go_types.explosive_pickup_projectile_unit_limited,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				network_position = network_position,
				network_rotation = network_rotation,
				network_velocity = network_velocity,
				network_angular_velocity = network_angular_velocity,
				debug_pos = Unit.local_position(unit, 0),
				pickup_name = NetworkLookup.pickup_names[pickup_name],
				has_physics = has_physics,
				spawn_type = NetworkLookup.pickup_spawn_types[spawn_type],
				spawner_unit = spawner_unit_index,
				limited_item_id = id,
				damage = damage,
				explode_time = explode_time,
				fuse_time = fuse_time,
				item_name = NetworkLookup.item_names[item_name]
			}

			return data_table
		end,
		true_flight_projectile_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local true_flight_template = locomotion_extension.true_flight_template
			local angle = locomotion_extension.angle
			local target_vector = locomotion_extension.target_vector
			local speed = locomotion_extension.speed
			local gravity_settings = locomotion_extension.gravity_settings
			local initial_position = locomotion_extension.initial_position_boxed:unbox()
			local trajectory_template_name = locomotion_extension.trajectory_template_name
			local target_unit_id = NetworkConstants.game_object_id_max

			if locomotion_extension.target_unit then
				target_unit_id = Managers.state.network:unit_game_object_id(locomotion_extension.target_unit)
			end

			local impact_extension = ScriptUnit.extension(unit, "projectile_impact_system")
			local server_side_raycast = impact_extension.server_side_raycast
			local collision_filter = impact_extension.collision_filter
			local owner_unit = impact_extension.owner_unit
			local projectile_extension = ScriptUnit.extension(unit, "projectile_system")
			local item_name = projectile_extension.item_name
			local item_template_name = projectile_extension.action_lookup_data.item_template_name
			local action_name = projectile_extension.action_lookup_data.action_name
			local sub_action_name = projectile_extension.action_lookup_data.sub_action_name
			local time_initialized = projectile_extension.time_initialized
			local scale = projectile_extension.scale*100
			local data_table = {
				go_type = NetworkLookup.go_types.true_flight_projectile_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				true_flight_template_id = TrueFlightTemplates[true_flight_template].lookup_id,
				target_unit_id = target_unit_id,
				angle = angle,
				initial_position = initial_position,
				target_vector = target_vector,
				speed = speed,
				gravity_settings = NetworkLookup.projectile_gravity_settings[gravity_settings],
				trajectory_template_id = NetworkLookup.projectile_templates[trajectory_template_name],
				collision_filter = NetworkLookup.collision_filters[collision_filter],
				server_side_raycast = server_side_raycast,
				owner_unit = Managers.state.network:unit_game_object_id(owner_unit),
				item_name = NetworkLookup.item_names[item_name],
				item_template_name = NetworkLookup.item_template_names[item_template_name],
				action_name = NetworkLookup.actions[action_name],
				sub_action_name = NetworkLookup.sub_actions[sub_action_name],
				scale = scale
			}

			return data_table
		end,
		aoe_projectile_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
			local angle = locomotion_extension.angle
			local speed = locomotion_extension.speed
			local gravity_settings = locomotion_extension.gravity_settings
			local target_vector = locomotion_extension.target_vector
			local initial_position = locomotion_extension.initial_position_boxed:unbox()
			local trajectory_template_name = locomotion_extension.trajectory_template_name
			local impact_extension = ScriptUnit.extension(unit, "projectile_impact_system")
			local collision_filter = impact_extension.collision_filter
			local server_side_raycast = impact_extension.server_side_raycast
			local owner_unit = impact_extension.owner_unit
			local projectile_extension = ScriptUnit.extension(unit, "projectile_system")
			local impact_template_name = projectile_extension.impact_template_name
			local damage_source = projectile_extension.damage_source
			local area_damage_system = ScriptUnit.extension(unit, "area_damage_system")
			local aoe_dot_damage = area_damage_system.aoe_dot_damage
			local aoe_init_damage = area_damage_system.aoe_init_damage
			local aoe_dot_damage_interval = area_damage_system.aoe_dot_damage_interval
			local radius = area_damage_system.radius
			local life_time = area_damage_system.life_time
			local damage_players = area_damage_system.damage_players
			local player_screen_effect_name = area_damage_system.player_screen_effect_name
			local dot_effect_name = area_damage_system.dot_effect_name
			local area_damage_template = area_damage_system.area_damage_template
			local network_manager = Managers.state.network
			local data_table = {
				go_type = NetworkLookup.go_types.aoe_projectile_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				angle = angle,
				speed = speed,
				gravity_settings = NetworkLookup.projectile_gravity_settings[gravity_settings],
				initial_position = initial_position,
				target_vector = target_vector,
				trajectory_template_name = NetworkLookup.projectile_templates[trajectory_template_name],
				owner_unit = network_manager.unit_game_object_id(network_manager, owner_unit),
				collision_filter = NetworkLookup.collision_filters[collision_filter],
				server_side_raycast = server_side_raycast,
				impact_template_name = NetworkLookup.projectile_templates[impact_template_name],
				aoe_dot_damage = aoe_dot_damage,
				aoe_init_damage = aoe_init_damage,
				aoe_dot_damage_interval = aoe_dot_damage_interval,
				radius = radius,
				life_time = life_time,
				damage_players = damage_players,
				player_screen_effect_name = NetworkLookup.effects[player_screen_effect_name],
				dot_effect_name = NetworkLookup.effects[dot_effect_name],
				area_damage_template = NetworkLookup.area_damage_templates[area_damage_template],
				damage_source_id = NetworkLookup.damage_sources[damage_source]
			}

			return data_table
		end,
		projectile_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local projectile_system = ScriptUnit.extension(unit, "projectile_system")
			local angle = projectile_system.angle
			local speed = projectile_system.speed
			local target_vector = projectile_system.target_vector
			local initial_position = projectile_system.initial_position
			local trajectory_template_name = projectile_system.trajectory_template_name
			local impact_template_name = projectile_system.impact_template_name
			local owner_unit = projectile_system.owner_unit
			local network_manager = Managers.state.network
			local data_table = {
				go_type = NetworkLookup.go_types.projectile_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				angle = angle,
				speed = speed,
				initial_position = initial_position,
				target_vector = target_vector,
				trajectory_template_name = NetworkLookup.projectile_templates[trajectory_template_name],
				impact_template_name = NetworkLookup.projectile_templates[impact_template_name],
				owner_unit = network_manager.unit_game_object_id(network_manager, owner_unit)
			}

			return data_table
		end,
		aoe_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local area_damage_system = ScriptUnit.extension(unit, "area_damage_system")
			local aoe_dot_damage = area_damage_system.aoe_dot_damage
			local aoe_init_damage = area_damage_system.aoe_init_damage
			local aoe_dot_damage_interval = area_damage_system.aoe_dot_damage_interval
			local radius = area_damage_system.radius
			local life_time = area_damage_system.life_time
			local player_screen_effect_name = area_damage_system.player_screen_effect_name
			local dot_effect_name = area_damage_system.dot_effect_name
			local area_damage_template = area_damage_system.area_damage_template
			local invisible_unit = area_damage_system.invisible_unit
			local extra_dot_effect_name = area_damage_system.extra_dot_effect_name
			local explosion_template_name = area_damage_system.explosion_template_name

			if dot_effect_name == nil then
				dot_effect_name = "n/a"
			end

			if extra_dot_effect_name == nil then
				extra_dot_effect_name = "n/a"
			end

			if explosion_template_name == nil then
				explosion_template_name = "n/a"
			end

			if player_screen_effect_name == nil then
				player_screen_effect_name = "n/a"
			end

			local data_table = {
				go_type = NetworkLookup.go_types.aoe_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				aoe_dot_damage = aoe_dot_damage,
				aoe_init_damage = aoe_init_damage,
				aoe_dot_damage_interval = aoe_dot_damage_interval,
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0),
				radius = radius,
				life_time = life_time,
				player_screen_effect_name = NetworkLookup.effects[player_screen_effect_name],
				dot_effect_name = NetworkLookup.effects[dot_effect_name],
				extra_dot_effect_name = NetworkLookup.effects[extra_dot_effect_name],
				invisible_unit = invisible_unit,
				area_damage_template = NetworkLookup.area_damage_templates[area_damage_template],
				explosion_template_name = NetworkLookup.explosion_templates[explosion_template_name]
			}

			return data_table
		end,
		pickup_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local pickup_extension = ScriptUnit.extension(unit, "pickup_system")
			local pickup_name = pickup_extension.pickup_name
			local has_physics = pickup_extension.has_physics
			local spawn_type = pickup_extension.spawn_type
			local data_table = {
				go_type = NetworkLookup.go_types.pickup_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				pickup_name = NetworkLookup.pickup_names[pickup_name],
				has_physics = has_physics,
				spawn_type = NetworkLookup.pickup_spawn_types[spawn_type],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0)
			}

			return data_table
		end,
		objective_pickup_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local pickup_system = ScriptUnit.extension(unit, "pickup_system")
			local pickup_name = pickup_system.pickup_name
			local has_physics = pickup_system.has_physics
			local spawn_type = pickup_system.spawn_type
			local data_table = {
				go_type = NetworkLookup.go_types.objective_pickup_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				pickup_name = NetworkLookup.pickup_names[pickup_name],
				has_physics = has_physics,
				spawn_type = NetworkLookup.pickup_spawn_types[spawn_type],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0)
			}

			return data_table
		end,
		prop_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local data_table = {
				go_type = NetworkLookup.go_types.prop_unit,
				husk_unit = NetworkLookup.husks[unit_name]
			}

			return data_table
		end,
		interest_point_level_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local data_table = {
				go_type = NetworkLookup.go_types.interest_point_level_unit
			}

			return data_table
		end,
		interest_point_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local data_table = {
				go_type = NetworkLookup.go_types.interest_point_unit,
				husk_unit = NetworkLookup.husks[unit_name],
				position = Unit.local_position(unit, 0),
				rotation = Unit.local_rotation(unit, 0)
			}

			return data_table
		end,
		sync_unit = function (unit, unit_name, unit_template, gameobject_functor_context)
			local game_object_extension = ScriptUnit.extension(unit, "game_object_system")
			local data_table = {
				go_type = NetworkLookup.go_types.sync_unit,
				sync_name = NetworkLookup.sync_names[game_object_extension.sync_name]
			}

			return data_table
		end
	},
	extractors = {
		player_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local player_health = GameSession.game_object_field(game_session, go_id, "health")
			local player_wounds = GameSession.game_object_field(game_session, go_id, "wounds")
			local profile_id = GameSession.game_object_field(game_session, go_id, "profile_id")
			local profile = SPProfiles[profile_id]

			assert(profile, "No such profile with index %s", tostring(profile_id))
			Unit.set_data(unit, "sound_character", profile.sound_character)

			local player_id = GameSession.game_object_field(game_session, go_id, "local_player_id")
			local peer_id = GameSession.game_object_field(game_session, go_id, "owner_peer_id")
			local player = Managers.player:player(peer_id, player_id)
			local extension_init_data = {
				locomotion_system = {
					id = go_id,
					game = game_session,
					player = player
				},
				health_system = {
					health = player_health,
					player = player,
					game_object_id = go_id
				},
				hit_reaction_system = {
					is_husk = true,
					hit_reaction_template = "player"
				},
				death_system = {
					death_reaction_template = "player",
					is_husk = true
				},
				aim_system = {
					template = "player",
					is_husk = true,
					go_id = go_id
				},
				status_system = {
					wounds = player_wounds,
					profile_id = profile_id,
					player = player
				},
				inventory_system = {},
				attachment_system = {
					profile = profile
				},
				dialogue_context_system = {
					profile = profile
				},
				dialogue_system = {
					faction = "player",
					wwise_voice_switch_group = "character",
					profile = profile,
					wwise_voice_switch_value = profile.character_vo
				},
				buff_system = {
					is_husk = true
				},
				statistics_system = {
					template = "player",
					statistics_id = player.stats_id(player)
				},
				ai_slot_system = {
					profile_index = profile_id
				}
			}

			Unit.set_animation_merge_options(unit)

			local level_settings = LevelHelper:current_level_settings()

			if level_settings.climate_type then
				Unit.set_flow_variable(unit, "climate_type", level_settings.climate_type)
				Unit.flow_event(unit, "climate_type_set")
			end

			local unit_template_name = "player_unit_3rd"

			return unit_template_name, extension_init_data
		end,
		player_bot_unit = function (game_session, go_id, owner, unit, gameobject_functor_context)
			local player_health = GameSession.game_object_field(game_session, go_id, "health")
			local player_wounds = GameSession.game_object_field(game_session, go_id, "wounds")
			local profile_id = GameSession.game_object_field(game_session, go_id, "profile_id")
			local profile = SPProfiles[profile_id]

			assert(profile, "No such profile with index %s", tostring(profile_id))

			if player_health == 0 then
				local difficulty_manager = Managers.state.difficulty
				local difficulty_settings = difficulty_manager.get_difficulty_settings(difficulty_manager)
				player_health = difficulty_settings.max_hp
			end

			Unit.set_data(unit, "sound_character", SPProfiles[profile_id].sound_character)

			local player_id = GameSession.game_object_field(game_session, go_id, "local_player_id")
			local peer_id = GameSession.game_object_field(game_session, go_id, "owner_peer_id")
			local player = Managers.player:player(peer_id, player_id)
			local extension_init_data = {
				locomotion_system = {
					id = go_id,
					game = game_session,
					player = player
				},
				health_system = {
					health = player_health,
					player = player,
					game_object_id = go_id
				},
				death_system = {
					death_reaction_template = "player",
					is_husk = true
				},
				inventory_system = {},
				hit_reaction_system = {
					is_husk = true,
					hit_reaction_template = "player"
				},
				dialogue_context_system = {
					profile = profile
				},
				aim_system = {
					template = "player",
					is_husk = true,
					go_id = go_id
				},
				status_system = {
					wounds = player_wounds,
					profile_id = profile_id,
					player = player
				},
				dialogue_system = {
					faction = "player",
					wwise_voice_switch_group = "character",
					profile = profile,
					wwise_voice_switch_value = profile.character_vo
				},
				attachment_system = {
					profile = profile
				},
				buff_system = {
					is_husk = true
				},
				statistics_system = {
					template = "player",
					statistics_id = player.stats_id(player)
				},
				ai_slot_system = {
					profile_index = profile_id
				}
			}
			local unit_template_name = "player_bot_unit"

			return unit_template_name, extension_init_data
		end,
		ai_unit = function (game_session, game_object_id, owner_id, unit, gameobject_functor_context)
			local breed, breed_name = enemy_unit_common_extractor(unit, game_session, game_object_id)
			local health = GameSession.game_object_field(game_session, game_object_id, "health")
			local extension_init_data = {
				ai_system = {
					go_id = game_object_id,
					game = game_session
				},
				locomotion_system = {
					go_id = game_object_id,
					breed = breed,
					game = game_session
				},
				health_system = {
					health = health
				},
				death_system = {
					is_husk = true,
					death_reaction_template = breed.death_reaction
				},
				hit_reaction_system = {
					is_husk = true,
					hit_reaction_template = breed.hit_reaction,
					hit_effect_template = breed.hit_effect_template
				},
				dialogue_system = {
					faction = "enemy",
					breed_name = breed_name
				}
			}
			local unit_template_name = breed.unit_template

			return unit_template_name, extension_init_data
		end,
		ai_unit_with_inventory = function (game_session, game_object_id, owner_id, unit, gameobject_functor_context)
			local breed, breed_name = enemy_unit_common_extractor(unit, game_session, game_object_id)
			local inventory_configuration_name = NetworkLookup.ai_inventory[GameSession.game_object_field(game_session, game_object_id, "inventory_configuration")]
			local health = GameSession.game_object_field(game_session, game_object_id, "health")
			local extension_init_data = {
				ai_system = {
					go_id = game_object_id,
					game = game_session
				},
				locomotion_system = {
					go_id = game_object_id,
					breed = breed,
					game = game_session
				},
				health_system = {
					health = health
				},
				death_system = {
					is_husk = true,
					death_reaction_template = breed.death_reaction
				},
				hit_reaction_system = {
					is_husk = true,
					hit_reaction_template = breed.hit_reaction,
					hit_effect_template = breed.hit_effect_template
				},
				ai_inventory_system = {
					inventory_configuration_name = inventory_configuration_name
				},
				dialogue_system = {
					faction = "enemy",
					breed_name = breed_name
				}
			}
			local unit_template_name = breed.unit_template

			return unit_template_name, extension_init_data
		end,
		ai_unit_pack_master = function (game_session, game_object_id, owner_id, unit, gameobject_functor_context)
			local breed, breed_name = enemy_unit_common_extractor(unit, game_session, game_object_id)
			local inventory_configuration_name = NetworkLookup.ai_inventory[GameSession.game_object_field(game_session, game_object_id, "inventory_configuration")]
			local health = GameSession.game_object_field(game_session, game_object_id, "health")
			local extension_init_data = {
				ai_system = {
					go_id = game_object_id,
					game = game_session
				},
				locomotion_system = {
					go_id = game_object_id,
					breed = breed,
					game = game_session
				},
				health_system = {
					health = health
				},
				death_system = {
					is_husk = true,
					death_reaction_template = breed.death_reaction
				},
				hit_reaction_system = {
					is_husk = true,
					hit_reaction_template = breed.hit_reaction,
					hit_effect_template = breed.hit_effect_template
				},
				ai_inventory_system = {
					inventory_configuration_name = inventory_configuration_name
				},
				dialogue_system = {
					faction = "enemy",
					breed_name = breed_name
				}
			}
			local unit_template_name = breed.unit_template

			return unit_template_name, extension_init_data
		end,
		ai_unit_ratling_gunner = function (game_session, game_object_id, owner_id, unit, gameobject_functor_context)
			local breed, breed_name = enemy_unit_common_extractor(unit, game_session, game_object_id)
			local inventory_configuration_name = NetworkLookup.ai_inventory[GameSession.game_object_field(game_session, game_object_id, "inventory_configuration")]
			local health = GameSession.game_object_field(game_session, game_object_id, "health")
			local extension_init_data = {
				ai_system = {
					go_id = game_object_id,
					game = game_session
				},
				locomotion_system = {
					go_id = game_object_id,
					breed = breed,
					game = game_session
				},
				health_system = {
					health = health
				},
				death_system = {
					is_husk = true,
					death_reaction_template = breed.death_reaction
				},
				hit_reaction_system = {
					is_husk = true,
					hit_reaction_template = breed.hit_reaction,
					hit_effect_template = breed.hit_effect_template
				},
				ai_inventory_system = {
					inventory_configuration_name = inventory_configuration_name
				},
				dialogue_system = {
					faction = "enemy",
					breed_name = breed_name
				},
				aim_system = {
					template = "ratling_gunner",
					is_husk = true
				}
			}
			local unit_template_name = breed.unit_template

			return unit_template_name, extension_init_data
		end,
		flame_wave_projectile_unit = function (game_session, game_object_id, owner_id, unit, gameobject_functor_context)
			local owner_unit_id = GameSession.game_object_field(game_session, game_object_id, "owner_unit")
			local owner_unit = (owner_unit_id ~= 0 and Managers.state.unit_storage:unit(owner_unit_id)) or nil
			local item_name_id = GameSession.game_object_field(game_session, game_object_id, "item_name")
			local item_template_name_id = GameSession.game_object_field(game_session, game_object_id, "item_template_name")
			local action_name_id = GameSession.game_object_field(game_session, game_object_id, "action_name")
			local sub_action_name_id = GameSession.game_object_field(game_session, game_object_id, "sub_action_name")
			local item_name = NetworkLookup.item_names[item_name_id]
			local item_template_name = NetworkLookup.item_template_names[item_template_name_id]
			local action_name = NetworkLookup.actions[action_name_id]
			local sub_action_name = NetworkLookup.sub_actions[sub_action_name_id]
			local scale = GameSession.game_object_field(game_session, game_object_id, "scale")/100
			local position = GameSession.game_object_field(game_session, game_object_id, "position")
			local flat_angle = GameSession.game_object_field(game_session, game_object_id, "flat_angle")
			local lateral_speed = GameSession.game_object_field(game_session, game_object_id, "lateral_speed")
			local initial_forward_speed = GameSession.game_object_field(game_session, game_object_id, "initial_forward_speed")
			local distance_travelled = GameSession.game_object_field(game_session, game_object_id, "distance_travelled")
			local time_initialized = Managers.time:time("game")
			local extension_init_data = {
				projectile_locomotion_system = {
					is_husk = true,
					owner_unit = owner_unit,
					scale = scale,
					item_name = item_name,
					item_template_name = item_template_name,
					action_name = action_name,
					sub_action_name = sub_action_name,
					position = position,
					flat_angle = flat_angle,
					lateral_speed = lateral_speed,
					initial_forward_speed = initial_forward_speed,
					distance_travelled = distance_travelled
				},
				projectile_impact_system = {
					item_name = item_name,
					item_template_name = item_template_name,
					action_name = action_name,
					sub_action_name = sub_action_name,
					owner_unit = owner_unit
				},
				projectile_system = {
					item_name = item_name,
					item_template_name = item_template_name,
					action_name = action_name,
					sub_action_name = sub_action_name,
					owner_unit = owner_unit,
					time_initialized = time_initialized,
					scale = scale
				}
			}
			local action = Weapons[item_template_name].actions[action_name][sub_action_name]
			local projectile_info = action.projectile_info
			local unit_template_name = projectile_info.projectile_unit_template_name or "player_projectile_unit"

			return unit_template_name, extension_init_data
		end,
		player_projectile_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local angle = GameSession.game_object_field(game_session, go_id, "angle")
			local target_vector = GameSession.game_object_field(game_session, go_id, "target_vector")
			local initial_position = GameSession.game_object_field(game_session, go_id, "initial_position")
			local speed = GameSession.game_object_field(game_session, go_id, "speed")
			local gravity_settings = GameSession.game_object_field(game_session, go_id, "gravity_settings")
			local trajectory_template_name = GameSession.game_object_field(game_session, go_id, "trajectory_template_name")
			local owner_unit_id = GameSession.game_object_field(game_session, go_id, "owner_unit")
			local item_name_id = GameSession.game_object_field(game_session, go_id, "item_name")
			local item_template_name_id = GameSession.game_object_field(game_session, go_id, "item_template_name")
			local action_name_id = GameSession.game_object_field(game_session, go_id, "action_name")
			local sub_action_name_id = GameSession.game_object_field(game_session, go_id, "sub_action_name")
			local time_initialized = Managers.time:time("game")
			local fast_forward_time = GameSession.game_object_field(game_session, go_id, "fast_forward_time")
			local scale = GameSession.game_object_field(game_session, go_id, "scale")/100
			local item_name = NetworkLookup.item_names[item_name_id]
			local item_template_name = NetworkLookup.item_template_names[item_template_name_id]
			local action_name = NetworkLookup.actions[action_name_id]
			local sub_action_name = NetworkLookup.sub_actions[sub_action_name_id]
			local owner_unit = (owner_unit_id ~= 0 and Managers.state.unit_storage:unit(owner_unit_id)) or nil
			local extension_init_data = {
				projectile_locomotion_system = {
					is_husk = true,
					angle = angle,
					speed = speed,
					target_vector = target_vector,
					initial_position = initial_position,
					gravity_settings = NetworkLookup.projectile_gravity_settings[gravity_settings],
					trajectory_template_name = NetworkLookup.projectile_templates[trajectory_template_name],
					fast_forward_time = fast_forward_time
				},
				projectile_impact_system = {
					item_name = item_name,
					owner_unit = owner_unit
				},
				projectile_system = {
					item_name = item_name,
					item_template_name = item_template_name,
					action_name = action_name,
					sub_action_name = sub_action_name,
					owner_unit = owner_unit,
					time_initialized = time_initialized,
					scale = scale
				}
			}
			local action = Weapons[item_template_name].actions[action_name][sub_action_name]
			local projectile_info = action.projectile_info
			local unit_template_name = projectile_info.projectile_unit_template_name or "player_projectile_unit"

			return unit_template_name, extension_init_data
		end,
		pickup_projectile_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local network_position = GameSession.game_object_field(game_session, go_id, "network_position")
			local network_rotation = GameSession.game_object_field(game_session, go_id, "network_rotation")
			local network_velocity = GameSession.game_object_field(game_session, go_id, "network_velocity")
			local network_angular_velocity = GameSession.game_object_field(game_session, go_id, "network_angular_velocity")
			local pickup_name = GameSession.game_object_field(game_session, go_id, "pickup_name")
			local has_physics = GameSession.game_object_field(game_session, go_id, "has_physics")
			local spawn_type = GameSession.game_object_field(game_session, go_id, "spawn_type")
			local extension_init_data = {
				projectile_locomotion_system = {
					network_position = network_position,
					network_rotation = network_rotation,
					network_velocity = network_velocity,
					network_angular_velocity = network_angular_velocity
				},
				pickup_system = {
					pickup_name = NetworkLookup.pickup_names[pickup_name],
					has_physics = has_physics,
					spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
				}
			}
			local unit_template_name = "pickup_projectile_unit"

			return unit_template_name, extension_init_data
		end,
		pickup_torch_unit_init = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local network_position = GameSession.game_object_field(game_session, go_id, "network_position")
			local network_rotation = GameSession.game_object_field(game_session, go_id, "network_rotation")
			local network_velocity = GameSession.game_object_field(game_session, go_id, "network_velocity")
			local network_angular_velocity = GameSession.game_object_field(game_session, go_id, "network_angular_velocity")
			local pickup_name = GameSession.game_object_field(game_session, go_id, "pickup_name")
			local has_physics = GameSession.game_object_field(game_session, go_id, "has_physics")
			local spawn_type = GameSession.game_object_field(game_session, go_id, "spawn_type")
			local extension_init_data = {
				projectile_locomotion_system = {
					network_position = network_position,
					network_rotation = network_rotation,
					network_velocity = network_velocity,
					network_angular_velocity = network_angular_velocity
				},
				pickup_system = {
					pickup_name = NetworkLookup.pickup_names[pickup_name],
					has_physics = has_physics,
					spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
				}
			}
			local unit_template_name = "pickup_torch_unit"

			return unit_template_name, extension_init_data
		end,
		pickup_torch_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local network_position = GameSession.game_object_field(game_session, go_id, "network_position")
			local network_rotation = GameSession.game_object_field(game_session, go_id, "network_rotation")
			local network_velocity = GameSession.game_object_field(game_session, go_id, "network_velocity")
			local network_angular_velocity = GameSession.game_object_field(game_session, go_id, "network_angular_velocity")
			local pickup_name = GameSession.game_object_field(game_session, go_id, "pickup_name")
			local has_physics = GameSession.game_object_field(game_session, go_id, "has_physics")
			local spawn_type = GameSession.game_object_field(game_session, go_id, "spawn_type")
			local extension_init_data = {
				projectile_locomotion_system = {
					network_position = network_position,
					network_rotation = network_rotation,
					network_velocity = network_velocity,
					network_angular_velocity = network_angular_velocity
				},
				pickup_system = {
					pickup_name = NetworkLookup.pickup_names[pickup_name],
					has_physics = has_physics,
					spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
				}
			}
			local unit_template_name = "pickup_torch_unit"

			return unit_template_name, extension_init_data
		end,
		pickup_projectile_unit_limited = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local network_position = GameSession.game_object_field(game_session, go_id, "network_position")
			local network_rotation = GameSession.game_object_field(game_session, go_id, "network_rotation")
			local network_velocity = GameSession.game_object_field(game_session, go_id, "network_velocity")
			local network_angular_velocity = GameSession.game_object_field(game_session, go_id, "network_angular_velocity")
			local pickup_name = GameSession.game_object_field(game_session, go_id, "pickup_name")
			local has_physics = GameSession.game_object_field(game_session, go_id, "has_physics")
			local spawn_type = GameSession.game_object_field(game_session, go_id, "spawn_type")
			local spawner_unit_index = GameSession.game_object_field(game_session, go_id, "spawner_unit")
			local limited_item_id = GameSession.game_object_field(game_session, go_id, "limited_item_id")
			local world = gameobject_functor_context.world
			local level = LevelHelper:current_level(world)
			local spawner_unit = Level.unit_by_index(level, spawner_unit_index)
			local extension_init_data = {
				projectile_locomotion_system = {
					network_position = network_position,
					network_rotation = network_rotation,
					network_velocity = network_velocity,
					network_angular_velocity = network_angular_velocity
				},
				pickup_system = {
					pickup_name = NetworkLookup.pickup_names[pickup_name],
					has_physics = has_physics,
					spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
				},
				limited_item_track_system = {
					spawner_unit = spawner_unit,
					id = limited_item_id
				}
			}
			local unit_template_name = "pickup_projectile_unit_limited"

			return unit_template_name, extension_init_data
		end,
		explosive_pickup_projectile_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local network_position = GameSession.game_object_field(game_session, go_id, "network_position")
			local network_rotation = GameSession.game_object_field(game_session, go_id, "network_rotation")
			local network_velocity = GameSession.game_object_field(game_session, go_id, "network_velocity")
			local network_angular_velocity = GameSession.game_object_field(game_session, go_id, "network_angular_velocity")
			local pickup_name = GameSession.game_object_field(game_session, go_id, "pickup_name")
			local has_physics = GameSession.game_object_field(game_session, go_id, "has_physics")
			local spawn_type = GameSession.game_object_field(game_session, go_id, "spawn_type")
			local damage = GameSession.game_object_field(game_session, go_id, "damage")
			local explode_time = GameSession.game_object_field(game_session, go_id, "explode_time")
			local fuse_time = GameSession.game_object_field(game_session, go_id, "fuse_time")
			local item_name_id = GameSession.game_object_field(game_session, go_id, "item_name")
			local death_data = nil

			if explode_time ~= 0 then
				death_data = {
					explode_time = explode_time,
					fuse_time = fuse_time
				}
			end

			local extension_init_data = {
				projectile_locomotion_system = {
					network_position = network_position,
					network_rotation = network_rotation,
					network_velocity = network_velocity,
					network_angular_velocity = network_angular_velocity
				},
				pickup_system = {
					pickup_name = NetworkLookup.pickup_names[pickup_name],
					has_physics = has_physics,
					spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
				},
				health_system = {
					damage = damage
				},
				death_system = {
					in_hand = false,
					death_data = death_data,
					item_name = NetworkLookup.item_names[item_name_id]
				}
			}
			local unit_template_name = "explosive_pickup_projectile_unit"

			return unit_template_name, extension_init_data
		end,
		explosive_pickup_projectile_unit_limited = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local network_position = GameSession.game_object_field(game_session, go_id, "network_position")
			local network_rotation = GameSession.game_object_field(game_session, go_id, "network_rotation")
			local network_velocity = GameSession.game_object_field(game_session, go_id, "network_velocity")
			local network_angular_velocity = GameSession.game_object_field(game_session, go_id, "network_angular_velocity")
			local pickup_name = GameSession.game_object_field(game_session, go_id, "pickup_name")
			local has_physics = GameSession.game_object_field(game_session, go_id, "has_physics")
			local spawn_type = GameSession.game_object_field(game_session, go_id, "spawn_type")
			local spawner_unit_index = GameSession.game_object_field(game_session, go_id, "spawner_unit")
			local limited_item_id = GameSession.game_object_field(game_session, go_id, "limited_item_id")
			local damage = GameSession.game_object_field(game_session, go_id, "damage")
			local explode_time = GameSession.game_object_field(game_session, go_id, "explode_time")
			local fuse_time = GameSession.game_object_field(game_session, go_id, "fuse_time")
			local item_name_id = GameSession.game_object_field(game_session, go_id, "item_name")
			local death_data = nil

			if explode_time ~= 0 then
				death_data = {
					explode_time = explode_time,
					fuse_time = fuse_time
				}
			end

			local world = gameobject_functor_context.world
			local level = LevelHelper:current_level(world)
			local spawner_unit = Level.unit_by_index(level, spawner_unit_index)
			local extension_init_data = {
				projectile_locomotion_system = {
					network_position = network_position,
					network_rotation = network_rotation,
					network_velocity = network_velocity,
					network_angular_velocity = network_angular_velocity
				},
				pickup_system = {
					pickup_name = NetworkLookup.pickup_names[pickup_name],
					has_physics = has_physics,
					spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
				},
				health_system = {
					damage = damage
				},
				death_system = {
					in_hand = false,
					death_data = death_data,
					item_name = NetworkLookup.item_names[item_name_id]
				},
				limited_item_track_system = {
					spawner_unit = spawner_unit,
					id = limited_item_id
				}
			}
			local unit_template_name = "explosive_pickup_projectile_unit_limited"

			return unit_template_name, extension_init_data
		end,
		true_flight_projectile_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local angle = GameSession.game_object_field(game_session, go_id, "angle")
			local target_vector = GameSession.game_object_field(game_session, go_id, "target_vector")
			local initial_position = GameSession.game_object_field(game_session, go_id, "initial_position")
			local speed = GameSession.game_object_field(game_session, go_id, "speed")
			local gravity_settings = GameSession.game_object_field(game_session, go_id, "gravity_settings")
			local trajectory_template_id = GameSession.game_object_field(game_session, go_id, "trajectory_template_id")
			local true_flight_template_id = GameSession.game_object_field(game_session, go_id, "true_flight_template_id")
			local target_unit_id = GameSession.game_object_field(game_session, go_id, "target_unit_id")
			local collision_filter_id = GameSession.game_object_field(game_session, go_id, "collision_filter")
			local server_side_raycast = GameSession.game_object_field(game_session, go_id, "server_side_raycast")
			local owner_unit_id = GameSession.game_object_field(game_session, go_id, "owner_unit")
			local item_template_name_id = GameSession.game_object_field(game_session, go_id, "item_template_name")
			local item_name_id = GameSession.game_object_field(game_session, go_id, "item_name")
			local action_name_id = GameSession.game_object_field(game_session, go_id, "action_name")
			local sub_action_name_id = GameSession.game_object_field(game_session, go_id, "sub_action_name")
			local time_initialized = Managers.time:time("game")
			local scale = GameSession.game_object_field(game_session, go_id, "scale")
			scale = scale/100
			local item_template_name = NetworkLookup.item_template_names[item_template_name_id]
			local item_name = NetworkLookup.item_names[item_name_id]
			local action_name = NetworkLookup.actions[action_name_id]
			local sub_action_name = NetworkLookup.sub_actions[sub_action_name_id]
			local target_unit = nil

			if target_unit_id ~= NetworkConstants.game_object_id_max then
				target_unit = Managers.state.unit_storage:unit(target_unit_id)
			end

			local owner_unit = Managers.state.unit_storage:unit(owner_unit_id)
			local extension_init_data = {
				projectile_locomotion_system = {
					is_husk = true,
					true_flight_template_name = TrueFlightTemplatesLookup[true_flight_template_id],
					target_unit = target_unit,
					owner_unit = owner_unit,
					angle = angle,
					speed = speed,
					target_vector = target_vector,
					initial_position = initial_position,
					gravity_settings = NetworkLookup.projectile_gravity_settings[gravity_settings],
					trajectory_template_name = NetworkLookup.projectile_templates[trajectory_template_id]
				},
				projectile_impact_system = {
					item_name = item_name,
					collision_filter = NetworkLookup.collision_filters[collision_filter_id],
					server_side_raycast = server_side_raycast,
					owner_unit = owner_unit
				},
				projectile_system = {
					item_name = item_name,
					item_template_name = item_template_name,
					action_name = action_name,
					sub_action_name = sub_action_name,
					owner_unit = owner_unit,
					time_initialized = time_initialized,
					scale = scale
				}
			}
			local unit_template_name = "true_flight_projectile_unit"

			return unit_template_name, extension_init_data
		end,
		aoe_projectile_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local angle = GameSession.game_object_field(game_session, go_id, "angle")
			local speed = GameSession.game_object_field(game_session, go_id, "speed")
			local gravity_settings = GameSession.game_object_field(game_session, go_id, "gravity_settings")
			local target_vector = GameSession.game_object_field(game_session, go_id, "target_vector")
			local initial_position = GameSession.game_object_field(game_session, go_id, "initial_position")
			local trajectory_template_name = GameSession.game_object_field(game_session, go_id, "trajectory_template_name")
			local owner_unit = GameSession.game_object_field(game_session, go_id, "owner_unit")
			local server_side_raycast = GameSession.game_object_field(game_session, go_id, "server_side_raycast")
			local collision_filter_id = GameSession.game_object_field(game_session, go_id, "collision_filter")
			local impact_template_name = GameSession.game_object_field(game_session, go_id, "impact_template_name")
			local aoe_init_damage = GameSession.game_object_field(game_session, go_id, "aoe_init_damage")
			local aoe_dot_damage = GameSession.game_object_field(game_session, go_id, "aoe_dot_damage")
			local aoe_dot_damage_interval = GameSession.game_object_field(game_session, go_id, "aoe_dot_damage_interval")
			local radius = GameSession.game_object_field(game_session, go_id, "radius")
			local life_time = GameSession.game_object_field(game_session, go_id, "life_time")
			local damage_players = GameSession.game_object_field(game_session, go_id, "damage_players")
			local player_screen_effect_name = GameSession.game_object_field(game_session, go_id, "player_screen_effect_name")
			local dot_effect_name = GameSession.game_object_field(game_session, go_id, "dot_effect_name")
			local area_damage_template = GameSession.game_object_field(game_session, go_id, "area_damage_template")
			local damage_source_id = GameSession.game_object_field(game_session, go_id, "damage_source_id")
			local owner_unit = Managers.state.unit_storage:unit(owner_unit)
			local extension_init_data = {
				projectile_locomotion_system = {
					is_husk = true,
					angle = angle,
					speed = speed,
					gravity_settings = NetworkLookup.projectile_gravity_settings[gravity_settings],
					target_vector = target_vector,
					initial_position = initial_position,
					trajectory_template_name = NetworkLookup.projectile_templates[trajectory_template_name]
				},
				projectile_impact_system = {
					collision_filter = NetworkLookup.collision_filters[collision_filter_id],
					server_side_raycast = server_side_raycast,
					owner_unit = owner_unit
				},
				projectile_system = {
					impact_template_name = NetworkLookup.projectile_templates[impact_template_name],
					owner_unit = owner_unit,
					damage_source = NetworkLookup.damage_sources[damage_source_id]
				},
				area_damage_system = {
					aoe_dot_damage = aoe_dot_damage,
					aoe_init_damage = aoe_init_damage,
					aoe_dot_damage_interval = aoe_dot_damage_interval,
					radius = radius,
					life_time = life_time,
					damage_players = damage_players,
					player_screen_effect_name = NetworkLookup.effects[player_screen_effect_name],
					dot_effect_name = NetworkLookup.effects[dot_effect_name],
					area_damage_template = NetworkLookup.area_damage_templates[area_damage_template],
					damage_source = NetworkLookup.damage_sources[damage_source_id]
				}
			}
			local unit_template_name = "aoe_projectile_unit"

			return unit_template_name, extension_init_data
		end,
		projectile_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local angle = GameSession.game_object_field(game_session, go_id, "angle")
			local speed = GameSession.game_object_field(game_session, go_id, "speed")
			local target_vector = GameSession.game_object_field(game_session, go_id, "target_vector")
			local initial_position = GameSession.game_object_field(game_session, go_id, "initial_position")
			local trajectory_template_name = GameSession.game_object_field(game_session, go_id, "trajectory_template_name")
			local impact_template_name = GameSession.game_object_field(game_session, go_id, "impact_template_name")
			local owner_unit = GameSession.game_object_field(game_session, go_id, "owner_unit")
			local extension_init_data = {
				projectile_system = {
					is_husk = true,
					angle = angle,
					speed = speed,
					target_vector = target_vector,
					initial_position = initial_position,
					trajectory_template_name = NetworkLookup.projectile_templates[trajectory_template_name],
					impact_template_name = NetworkLookup.projectile_templates[impact_template_name],
					owner_unit = Managers.state.unit_storage:unit(owner_unit)
				}
			}
			local unit_template_name = "projectile_unit"

			return unit_template_name, extension_init_data
		end,
		aoe_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local aoe_dot_damage = GameSession.game_object_field(game_session, go_id, "aoe_dot_damage")
			local aoe_init_damage = GameSession.game_object_field(game_session, go_id, "aoe_init_damage")
			local aoe_dot_damage_interval = GameSession.game_object_field(game_session, go_id, "aoe_dot_damage_interval")
			local radius = GameSession.game_object_field(game_session, go_id, "radius")
			local life_time = GameSession.game_object_field(game_session, go_id, "life_time")
			local player_screen_effect_name = GameSession.game_object_field(game_session, go_id, "player_screen_effect_name")
			local dot_effect_name = GameSession.game_object_field(game_session, go_id, "dot_effect_name")
			local area_damage_template = GameSession.game_object_field(game_session, go_id, "area_damage_template")
			local invisible_unit = GameSession.game_object_field(game_session, go_id, "invisible_unit")
			local extra_dot_effect_name = GameSession.game_object_field(game_session, go_id, "extra_dot_effect_name")
			local explosion_template_name = GameSession.game_object_field(game_session, go_id, "explosion_template_name")
			extra_dot_effect_name = NetworkLookup.effects[extra_dot_effect_name]

			if extra_dot_effect_name == "n/a" then
				extra_dot_effect_name = nil
			end

			explosion_template_name = NetworkLookup.explosion_templates[explosion_template_name]

			if explosion_template_name == "n/a" then
				explosion_template_name = nil
			end

			local player_screen_effect_name = NetworkLookup.effects[player_screen_effect_name]

			if player_screen_effect_name == "n/a" then
				player_screen_effect_name = nil
			end

			local dot_effect_name = NetworkLookup.effects[dot_effect_name]

			if dot_effect_name == "n/a" then
				dot_effect_name = nil
			end

			local nav_mesh_effect = nil

			if explosion_template_name then
				local template = ExplosionTemplates[explosion_template_name]

				if template then
					local aoe_data = template.aoe
					nav_mesh_effect = aoe_data.nav_mesh_effect
				end
			end

			local extension_init_data = {
				area_damage_system = {
					aoe_dot_damage = aoe_dot_damage,
					aoe_init_damage = aoe_init_damage,
					aoe_dot_damage_interval = aoe_dot_damage_interval,
					radius = radius,
					life_time = life_time,
					invisible_unit = invisible_unit,
					player_screen_effect_name = player_screen_effect_name,
					dot_effect_name = dot_effect_name,
					nav_mesh_effect = nav_mesh_effect,
					extra_dot_effect_name = extra_dot_effect_name,
					area_damage_template = NetworkLookup.area_damage_templates[area_damage_template],
					explosion_template_name = explosion_template_name
				}
			}
			local unit_template_name = "aoe_unit"

			return unit_template_name, extension_init_data
		end,
		pickup_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local pickup_name = GameSession.game_object_field(game_session, go_id, "pickup_name")
			local has_physics = GameSession.game_object_field(game_session, go_id, "has_physics")
			local spawn_type = GameSession.game_object_field(game_session, go_id, "spawn_type")
			local extension_init_data = {
				pickup_system = {
					pickup_name = NetworkLookup.pickup_names[pickup_name],
					has_physics = has_physics,
					spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
				}
			}
			local unit_template_name = "pickup_unit"

			return unit_template_name, extension_init_data
		end,
		objective_pickup_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local pickup_name = GameSession.game_object_field(game_session, go_id, "pickup_name")
			local has_physics = GameSession.game_object_field(game_session, go_id, "has_physics")
			local spawn_type = GameSession.game_object_field(game_session, go_id, "spawn_type")
			local extension_init_data = {
				pickup_system = {
					pickup_name = NetworkLookup.pickup_names[pickup_name],
					has_physics = has_physics,
					spawn_type = NetworkLookup.pickup_spawn_types[spawn_type]
				}
			}
			local unit_template_name = "objective_pickup_unit"

			return unit_template_name, extension_init_data
		end,
		prop_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local unit_template_name = "prop_unit"
			local extension_init_data = nil

			return unit_template_name, extension_init_data
		end,
		interest_point_level_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local unit_template_name = "interest_point_level"
			local extension_init_data = nil

			return unit_template_name, extension_init_data
		end,
		interest_point_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			local unit_template_name = "interest_point"
			local extension_init_data = nil

			return unit_template_name, extension_init_data
		end,
		sync_unit = function (game_session, go_id, owner_id, unit, gameobject_functor_context)
			assert(false)

			return 
		end
	},
	unit_from_gameobject_creator_func = function (unit_spawner, game_session, go_id, go_template)
		local unit = nil
		local is_level_unit = go_template.is_level_unit

		if is_level_unit then
			local unit_index = GameSession.game_object_field(game_session, go_id, "level_id")

			assert(false, "NetworkLookup.levels doesn´t exist. Talk to Anders E")

			local level_name = NetworkLookup.levels[GameSession.game_object_field(game_session, go_id, "level_name_id")]
			local level = GLOBAL.current_levels[level_name]
			unit = Level.unit_by_index(level, unit_index)
		else
			local husk_unit = NetworkLookup.husks[GameSession.game_object_field(game_session, go_id, "husk_unit")]
			local position, rotation = nil

			if go_template.syncs_position then
				position = GameSession.game_object_field(game_session, go_id, "position")
			end

			if go_template.syncs_rotation then
				rotation = GameSession.game_object_field(game_session, go_id, "rotation")
			elseif go_template.syncs_pitch_yaw then
				local new_yaw = GameSession.game_object_field(game_session, go_id, "yaw")
				local new_pitch = GameSession.game_object_field(game_session, go_id, "pitch")
				local yaw_rotation = Quaternion(Vector3.up(), new_yaw)
				local pitch_rotation = Quaternion(Vector3.right(), new_pitch)
				slot13 = Quaternion.multiply(yaw_rotation, pitch_rotation)
			end

			unit = unit_spawner.spawn_local_unit(unit_spawner, husk_unit, position, rotation)
		end

		return unit
	end
}

return go_type_table
