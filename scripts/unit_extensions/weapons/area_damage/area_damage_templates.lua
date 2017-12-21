AreaDamageTemplates = {}
local ai_units = {}
AreaDamageTemplates.templates = {
	area_dot_damage = {
		server = {
			update = function (damage_source, unit, radius, damage, life_time, life_timer, damage_interval, damage_timer, aoe_dot_player_take_damage)
				if life_time < life_timer then
					Managers.state.unit_spawner:mark_for_deletion(unit)

					return false
				end

				local area_damage_position = Unit.local_position(unit, 0)

				if 0 < damage_timer and damage_timer < damage_interval then
					return false
				end

				local damage_buffer = {}

				if aoe_dot_player_take_damage then
					for _, player in pairs(Managers.player:players()) do
						local player_unit = player.player_unit

						if player_unit ~= nil then
							local unit_position = POSITION_LOOKUP[player_unit]
							local distance = Vector3.distance(unit_position, area_damage_position)
							local is_inside_radius = distance < radius

							if is_inside_radius then
								local damage_data = {
									area_damage_template = "area_dot_damage",
									unit = player_unit,
									damage = damage,
									damage_source = damage_source
								}
								damage_buffer[#damage_buffer + 1] = damage_data
							end
						end
					end
				end

				return true, damage_buffer
			end,
			do_damage = function (data, extension_unit)
				local unit = data.unit
				local damage = data.damage
				local damage_source = data.damage_source

				DamageUtils.add_damage_network(unit, extension_unit, damage, "torso", "damage_over_time", Vector3(1, 0, 0), damage_source)

				return 
			end
		},
		client = {
			update = function (world, radius, aoe_unit, player_screen_effect_name, player_unit_particles, aoe_dot_player_take_damage)
				for _, player in pairs(Managers.player:players()) do
					local player_unit = player.player_unit

					if player.local_player and Unit.alive(player_unit) and aoe_dot_player_take_damage and player_screen_effect_name ~= nil and not ScriptUnit.extension(player_unit, "buff_system"):has_buff_type("poison_screen_effect_immune") then
						local unit_position = POSITION_LOOKUP[player_unit]
						local area_damage_position = Unit.local_position(aoe_unit, 0)
						local distance_sq = Vector3.distance_squared(unit_position, area_damage_position)
						local is_inside_radius = distance_sq < radius*radius
						local t = Managers.time:time("game")

						if is_inside_radius and not player_unit_particles[player_unit] then
							local particle_id = World.create_particles(world, player_screen_effect_name, Vector3(0, 0, 0))
							player_unit_particles[player_unit] = {
								particle_id = particle_id,
								start_time = t
							}
						elseif is_inside_radius and player_unit_particles[player_unit].start_time + 5 <= t then
							local particle_id = player_unit_particles[player_unit].particle_id

							World.stop_spawning_particles(world, particle_id)

							player_unit_particles[player_unit] = nil
						elseif not is_inside_radius and player_unit_particles[player_unit] and not player_unit_particles[player_unit].fade_time then
							local particle_id = player_unit_particles[player_unit].particle_id

							World.stop_spawning_particles(world, particle_id)

							local new_particle_id = World.create_particles(world, player_screen_effect_name, Vector3(0, 0, 0))
							player_unit_particles[player_unit].fade_time = t + 1.5
							player_unit_particles[player_unit].particle_id = new_particle_id
						elseif not is_inside_radius and player_unit_particles[player_unit] and player_unit_particles[player_unit].fade_time <= t then
							local particle_id = player_unit_particles[player_unit].particle_id

							World.stop_spawning_particles(world, particle_id)

							player_unit_particles[player_unit] = nil
						end
					end
				end

				return 
			end,
			spawn_effect = function (world, unit, effect_name, particle_var_table)
				local position = Unit.local_position(unit, 0)
				local effect_id = World.create_particles(world, effect_name, position)
				local effect_variable_id = nil

				if particle_var_table ~= nil then
					for index, element in pairs(particle_var_table) do
						effect_variable_id = World.find_particles_variable(world, effect_name, element.particle_variable)

						World.set_particles_variable(world, effect_id, effect_variable_id, element.value)
					end
				end

				return effect_id
			end,
			destroy = function ()
				return 
			end
		}
	},
	area_dot_damage_courtyard_well_hack = {
		server = {
			update = function (damage_source, unit, radius, damage, life_time, life_timer, damage_interval, damage_timer, aoe_dot_player_take_damage)
				local area_damage_position = Unit.local_position(unit, 0)

				if 0 < damage_timer and damage_timer < damage_interval then
					return false
				end

				local damage_buffer = {}

				if aoe_dot_player_take_damage then
					for _, player in pairs(Managers.player:players()) do
						local player_unit = player.player_unit

						if player_unit ~= nil then
							local unit_position = POSITION_LOOKUP[player_unit]
							local distance = Vector3.distance(unit_position, area_damage_position)
							local is_inside_radius = distance < radius

							if is_inside_radius then
								local damage_data = {
									area_damage_template = "area_dot_damage_courtyard_well_hack",
									unit = player_unit,
									damage = damage,
									damage_source = damage_source
								}
								damage_buffer[#damage_buffer + 1] = damage_data
							end
						end
					end
				end

				return true, damage_buffer
			end,
			do_damage = function (data, extension_unit)
				local unit = data.unit
				local damage = data.damage
				local damage_source = data.damage_source

				DamageUtils.add_damage_network(unit, unit, damage, "torso", "damage_over_time", Vector3(1, 0, 0), damage_source)

				return 
			end
		},
		client = {
			update = function (world, radius, aoe_unit, player_screen_effect_name, player_unit_particles, aoe_dot_player_take_damage)
				for _, player in pairs(Managers.player:players()) do
					local player_unit = player.player_unit

					if player.local_player and Unit.alive(player_unit) and aoe_dot_player_take_damage and player_screen_effect_name ~= nil and not ScriptUnit.extension(player_unit, "buff_system"):has_buff_type("poison_screen_effect_immune") then
						local unit_position = POSITION_LOOKUP[player_unit]
						local area_damage_position = Unit.local_position(aoe_unit, 0)
						local distance_sq = Vector3.distance_squared(unit_position, area_damage_position)
						local is_inside_radius = distance_sq < radius*radius
						local t = Managers.time:time("game")

						if is_inside_radius and not player_unit_particles[player_unit] then
							local particle_id = World.create_particles(world, player_screen_effect_name, Vector3(0, 0, 0))
							player_unit_particles[player_unit] = {
								particle_id = particle_id,
								start_time = t
							}
						elseif is_inside_radius and player_unit_particles[player_unit].start_time + 5 <= t then
							local particle_id = player_unit_particles[player_unit].particle_id

							World.stop_spawning_particles(world, particle_id)

							player_unit_particles[player_unit] = nil
						elseif not is_inside_radius and player_unit_particles[player_unit] and not player_unit_particles[player_unit].fade_time then
							local particle_id = player_unit_particles[player_unit].particle_id

							World.stop_spawning_particles(world, particle_id)

							local new_particle_id = World.create_particles(world, player_screen_effect_name, Vector3(0, 0, 0))
							player_unit_particles[player_unit].fade_time = t + 1.5
							player_unit_particles[player_unit].particle_id = new_particle_id
						elseif not is_inside_radius and player_unit_particles[player_unit] and player_unit_particles[player_unit].fade_time <= t then
							local particle_id = player_unit_particles[player_unit].particle_id

							World.stop_spawning_particles(world, particle_id)

							player_unit_particles[player_unit] = nil
						end
					end
				end

				return 
			end,
			spawn_effect = function (world, unit, effect_name, particle_var_table)
				local position = Unit.local_position(unit, 0)
				local effect_id = World.create_particles(world, effect_name, position)
				local effect_variable_id = nil

				if particle_var_table ~= nil then
					for index, element in pairs(particle_var_table) do
						effect_variable_id = World.find_particles_variable(world, effect_name, element.particle_variable)

						World.set_particles_variable(world, effect_id, effect_variable_id, element.value)
					end
				end

				return effect_id
			end,
			destroy = function ()
				return 
			end
		}
	},
	explosion_template_aoe = {
		server = {
			update = function (damage_source, unit, radius, damage, life_time, life_timer, damage_interval, damage_timer, aoe_dot_player_take_damage, explosion_template_name)
				if life_time < life_timer then
					Managers.state.unit_spawner:mark_for_deletion(unit)

					return false
				end

				local area_damage_position = Unit.world_position(unit, 0)
				local explosion_template = ExplosionTemplates[explosion_template_name]
				local aoe_data = explosion_template.aoe
				local friendly_fire_data = true

				if explosion_template.friendly_fire ~= nil then
					friendly_fire_data = explosion_template.friendly_fire
				end

				if aoe_data.attack_template then
					if 0 < damage_timer and damage_timer < damage_interval then
						return false
					end

					local damage_buffer = {}
					local attack_template_name = aoe_data.attack_template
					local attack_template_damage_type_name = aoe_data.attack_template_damage_type
					local hit_zone_name = "full"
					local dot_damage = aoe_data.dot_damage
					local num_ai_units = AiUtils.broadphase_query(area_damage_position, radius, ai_units)

					for i = 1, num_ai_units, 1 do
						local ai_unit = ai_units[i]
						local backstab_multiplier = 1
						local damage_data = {
							hit_ragdoll_actor = "n/a",
							area_damage_template = "explosion_template_aoe",
							unit = ai_unit,
							damage_source = damage_source,
							attack_template_name = attack_template_name,
							attack_template_damage_type_name = attack_template_damage_type_name or "n/a",
							hit_zone_name = hit_zone_name,
							backstab_multiplier = backstab_multiplier
						}
						damage_buffer[#damage_buffer + 1] = damage_data
					end

					local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()

					if aoe_dot_player_take_damage and difficulty_settings.friendly_fire_ranged and friendly_fire_data then
						for _, player in pairs(Managers.player:players()) do
							local player_unit = player.player_unit

							if player_unit ~= nil then
								local unit_position = POSITION_LOOKUP[player_unit]
								local distance = Vector3.distance(unit_position, area_damage_position)
								local is_inside_radius = distance < radius
								local backstab_multiplier = 1

								if is_inside_radius then
									local damage_data = {
										hit_ragdoll_actor = "n/a",
										area_damage_template = "explosion_template_aoe",
										unit = player_unit,
										damage_source = damage_source,
										attack_template_name = attack_template_name,
										attack_template_damage_type_name = attack_template_damage_type_name or "n/a",
										hit_zone_name = hit_zone_name,
										backstab_multiplier = backstab_multiplier
									}
									damage_buffer[#damage_buffer + 1] = damage_data
								end
							end
						end
					end

					return true, damage_buffer
				end

				return 
			end,
			do_damage = function (data, extension_unit)
				local unit = data.unit
				local unit_position = POSITION_LOOKUP[unit]
				local damage_position = POSITION_LOOKUP[extension_unit]
				local hit_direction = unit_position - damage_position
				local hit_direction_normalized = Vector3.normalize(hit_direction)
				local network_manager = Managers.state.network
				local damage_source_id = NetworkLookup.damage_sources[data.damage_source]
				local attacker_unit_id = network_manager.unit_game_object_id(network_manager, extension_unit)
				local unit_id = network_manager.unit_game_object_id(network_manager, unit)
				local attack_template_id = NetworkLookup.attack_templates[data.attack_template_name]
				local attack_template_damage_type_id = NetworkLookup.attack_damage_values[data.attack_template_damage_type_name]
				local hit_zone_id = NetworkLookup.hit_zones[data.hit_zone_name]
				local hit_ragdoll_actor_id = NetworkLookup.hit_ragdoll_actors[data.hit_ragdoll_actor]
				local backstab_multiplier = data.backstab_multiplier
				local weapon_system = Managers.state.entity:system("weapon_system")

				weapon_system.rpc_attack_hit(weapon_system, nil, damage_source_id, attacker_unit_id, unit_id, attack_template_id, hit_zone_id, hit_direction_normalized, attack_template_damage_type_id, hit_ragdoll_actor_id, backstab_multiplier)

				return 
			end
		},
		client = {
			update = function (world, radius, aoe_unit, player_screen_effect_name, player_unit_particles, damage_players, explosion_template_name)
				return 
			end,
			spawn_effect = function (world, unit, effect_name, particle_var_table, override_position)
				local position = override_position or Unit.world_position(unit, 0)
				local effect_id = World.create_particles(world, effect_name, position)
				local effect_variable_id = nil

				if particle_var_table ~= nil then
					for index, element in pairs(particle_var_table) do
						effect_variable_id = World.find_particles_variable(world, effect_name, element.particle_variable)

						World.set_particles_variable(world, effect_id, effect_variable_id, element.value)
					end
				end

				return effect_id
			end
		}
	},
	area_poison_ai_random_death = {
		server = {
			update = function (damage_source, unit, radius, death_interval, damage_timer)
				if 0 < damage_timer and damage_timer < death_interval then
					return false
				end

				local area_damage_position = Unit.world_position(unit, 0)
				local damage_buffer = {}
				local ai_units_n = AiUtils.broadphase_query(area_damage_position, radius, ai_units)

				for i = 1, ai_units_n, 1 do
					local ai_unit = ai_units[i]
					local breed = Unit.get_data(ai_unit, "breed")
					local chance_to_die = breed.poison_resistance - 100
					local health_extension = ScriptUnit.extension(ai_unit, "health_system")

					assert(health_extension)

					local is_alive = health_extension.is_alive(health_extension)

					if is_alive then
						local die_roll = math.random(1, 100)

						if die_roll < chance_to_die then
							local damage_data = {
								area_damage_template = "area_poison_ai_random_death",
								unit = ai_unit
							}
							damage_buffer[#damage_buffer + 1] = damage_data
						end
					end
				end

				return true, damage_buffer
			end,
			do_damage = function (data, extension_unit)
				local unit = data.unit
				local area_damage_position = Unit.world_position(extension_unit, 0)
				local unit_position = POSITION_LOOKUP[unit]
				local damage_direction = Vector3.normalize(unit_position - area_damage_position)

				DamageUtils.deal_damage("skaven_poison_wind_globadier", unit, unit, damage_direction, "poison_globe_ai_initial_damage", "full")

				return 
			end
		}
	}
}
AreaDamageTemplates.get_template = function (area_damage_template, is_husk)
	local templates = AreaDamageTemplates.templates
	local husk_key = (is_husk == true and "husk") or (is_husk == false and "unit") or nil
	local template = (husk_key and templates[area_damage_template][husk_key]) or templates[area_damage_template]

	fassert(template, "no area_damage_template called %s", area_damage_template)

	return template
end

return 
