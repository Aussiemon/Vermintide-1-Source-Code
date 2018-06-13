DamageUtils = {}
local unit_local_position = Unit.local_position
local unit_set_local_rotation = Unit.set_local_rotation
local quaternion_look = Quaternion.look
local PLAYER_AND_BOT_UNITS = PLAYER_AND_BOT_UNITS
local PLAYER_TARGET_ARMOR = 4
local max_nr_of_armor = 3

DamageUtils.get_breed_armor = function (target_unit)
	local breed = target_unit and Unit.get_data(target_unit, "breed")
	local player_armor = 1
	local target_unit_armor = (breed and breed.armor_category) or player_armor

	return target_unit_armor
end

local DEFAULT_DAMAGE_TABLE = {
	0,
	0,
	0,
	0
}

DamageUtils.calculate_damage = function (damage_table, target_unit, attacker_unit, hit_zone_name, headshot_multiplier, backstab_multiplier, hawkeye_multiplier)
	local target_unit_armor = DamageUtils.get_breed_armor(target_unit)
	local breed = target_unit and Unit.get_data(target_unit, "breed")
	local blackboard = nil
	damage_table = damage_table or DEFAULT_DAMAGE_TABLE

	if breed then
		blackboard = Unit.get_data(target_unit, "blackboard")
	end

	local ranged_shield = breed and breed.ranged_shield

	if ranged_shield then
		local attacker_location = POSITION_LOOKUP[attacker_unit]
		local self_location = POSITION_LOOKUP[target_unit]
		local attacker_distance = Vector3.distance(attacker_location, self_location)
		local ranged_shield_distance = ranged_shield.distance

		if ranged_shield_distance < attacker_distance then
			return 0
		end
	end

	local has_damage_boost = false

	if attacker_unit and Unit.alive(attacker_unit) and ScriptUnit.has_extension(attacker_unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(attacker_unit, "buff_system")
		has_damage_boost = buff_extension:has_buff_type("armor penetration")
	end

	if not has_damage_boost and Unit.alive(attacker_unit) and Unit.alive(target_unit) and ScriptUnit.has_extension(target_unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(target_unit, "buff_system")

		if buff_extension and buff_extension:has_buff_type("increase_incoming_damage") then
			local buff = buff_extension:get_non_stacking_buff("increase_incoming_damage")

			if attacker_unit ~= buff.attacker_unit then
				has_damage_boost = true
			end
		end
	end

	hit_ward = hit_zone_name == "ward"
	local damage = nil

	if has_damage_boost and not hit_ward then
		if target_unit_armor == 1 then
			damage = damage_table[target_unit_armor] * 3
		elseif target_unit_armor == 2 then
			damage = damage_table[1]
		elseif target_unit_armor == 3 then
			damage = damage_table[target_unit_armor] * 2
		end
	elseif attacker_unit and table.contains(PLAYER_AND_BOT_UNITS, target_unit) and table.contains(PLAYER_AND_BOT_UNITS, attacker_unit) then
		if #damage_table > 3 then
			damage = damage_table[PLAYER_TARGET_ARMOR]
		else
			damage = 1
		end
	else
		damage = damage_table[target_unit_armor]
	end

	if headshot_multiplier and headshot_multiplier ~= -1 and hawkeye_multiplier then
		headshot_multiplier = headshot_multiplier + hawkeye_multiplier
	end

	if (hit_zone_name == "head" or hit_zone_name == "neck") and headshot_multiplier ~= -1 then
		if headshot_multiplier and damage > 0 then
			damage = damage * headshot_multiplier
		elseif target_unit_armor == 2 and damage == 0 then
			damage = headshot_multiplier or 1
		elseif target_unit_armor == 3 then
			damage = damage * 1.5
		elseif target_unit_armor == 2 then
			damage = damage + 0.5
		else
			damage = damage + 1
		end
	end

	if backstab_multiplier then
		damage = damage * backstab_multiplier
	end

	if hit_ward then
		damage = damage * 0.5
	end

	return damage
end

local upgraded_staggers = {
	2,
	3,
	6,
	[4] = 2,
	[5] = 2,
	[7] = 2
}

DamageUtils.calculate_stagger = function (damage_table, duration_table, target_unit, attacker_unit, attack_template)
	local breed = Unit.get_data(target_unit, "breed")
	local target_unit_armor = breed.armor_category
	local stagger = 0
	local duration = 0.5

	if damage_table then
		stagger = damage_table[target_unit_armor]
	end

	if breed.boss_staggers and stagger < 6 then
		stagger = 0
	end

	local blackboard = Unit.get_data(target_unit, "blackboard")
	local action = blackboard.action
	local ignore_staggers = action and action.ignore_staggers

	if ignore_staggers then
		local owner_buff_extension = ScriptUnit.has_extension(attacker_unit, "buff_system")

		if owner_buff_extension and owner_buff_extension:has_buff_type("push_increase") then
			ignore_staggers = false
		end
	end

	if ignore_staggers and ignore_staggers[stagger] and (not ignore_staggers.allow_push or not attack_template or not attack_template.is_push) then
		return 0, 0
	end

	if duration_table then
		duration = duration_table[target_unit_armor]
	end

	if breed.no_stagger_duration then
		duration = 0
	end

	duration = math.max((duration + math.random()) - 0.5, 0)

	if DamageUtils.is_player_unit(attacker_unit) then
		local player = Managers.player:owner(attacker_unit)
		local boon_handler = player.boon_handler

		if boon_handler then
			local boon_name = "increased_stagger_type"
			local has_increased_stagger_type_boon = boon_handler:has_boon(boon_name)

			if has_increased_stagger_type_boon then
				local num_increased_damage_boons = boon_handler:get_num_boons(boon_name)
				local boon_template = BoonTemplates[boon_name]
				local duration_multiplier = 1 + boon_template.duration_multiplier
				duration = duration * duration_multiplier
			end
		end
	end

	return stagger, duration
end

DamageUtils.is_player_unit = function (unit)
	return Managers.player:is_player_unit(unit)
end

DamageUtils.hit_zone = function (unit, actor)
	local breed = Unit.get_data(unit, "breed")

	if breed then
		local node = Actor.node(actor)
		local hit_zone = breed.hit_zones_lookup[node]
		local hit_zone_name = hit_zone.name

		return hit_zone_name
	elseif DamageUtils.is_player_unit(unit) then
		return "torso"
	else
		return "full"
	end
end

DamageUtils.aoe_hit_zone = function (unit, actor)
	local breed = Unit.get_data(unit, "breed")

	if breed then
		local node = Actor.node(actor)
		local hit_zone = breed.hit_zones_lookup[node]
		local hit_zone_name = hit_zone.name

		return (hit_zone_name == "afro" and "afro") or "torso"
	elseif DamageUtils.is_player_unit(unit) then
		return "torso"
	else
		return "full"
	end
end

DamageUtils.draw_aoe_size = function (target_unit)
	local radius, height = DamageUtils.calculate_aoe_size(target_unit)
	local unit_position = POSITION_LOOKUP[target_unit]
	local unit_top_position = unit_position + Vector3(0, 0, math.max(height - radius * 0.5, height * 0.5))
	local unit_bottom_position = unit_position + Vector3(0, 0, math.min(radius * 0.5, height * 0.5))

	QuickDrawer:capsule(unit_bottom_position, unit_top_position, radius, Color(255, 255, 0, 255))
end

DamageUtils.calculate_aoe_size = function (target_unit)
	local radius, height = nil
	local breed = target_unit and Unit.get_data(target_unit, "breed")

	if breed then
		radius = breed.aoe_radius or 0.3
		height = breed.aoe_height or 1.5
	elseif DamageUtils.is_player_unit(target_unit) then
		radius = 0.3
		height = 1.7
	else
		radius = 1
		height = 1
	end

	return radius, height
end

local units = {}

DamageUtils.create_explosion = function (world, attacker_unit, position, rotation, explosion_template, scale, damage_source, is_server, is_husk, damaging_unit)
	if explosion_template.effect_name then
		World.create_particles(world, explosion_template.effect_name, position, rotation)
	end

	local attacker_unit_alive = Unit.alive(attacker_unit)

	if explosion_template.sound_event_name then
		local wwise_source_id, wwise_world = WwiseUtils.make_position_auto_source(world, position)
		local husk = (is_husk and "true") or "false"

		WwiseWorld.set_switch(wwise_world, "husk", husk, wwise_source_id)
		WwiseWorld.trigger_event(wwise_world, explosion_template.sound_event_name, wwise_source_id)
	end

	if is_server and attacker_unit_alive then
		if explosion_template.alert_enemies then
			Managers.state.entity:system("ai_system"):alert_enemies_within_range(attacker_unit, position, explosion_template.alert_enemies_radius)
		end

		local weapon_system = Managers.state.entity:system("weapon_system")
		local network_manager = Managers.state.network
		local attack_template_name = explosion_template.attack_template
		local attack_template_glance_name = explosion_template.attack_template_glance
		local attack_template_damage_type_name = explosion_template.attack_template_damage_type
		local attack_template_id, attack_template_damage_type_id = nil

		if attack_template_name then
			attack_template_id = NetworkLookup.attack_templates[attack_template_name]
			attack_template_damage_type_id = NetworkLookup.attack_damage_values[attack_template_damage_type_name or "n/a"]
		end

		local attack_template_glance_id = nil

		if attack_template_glance_name then
			attack_template_glance_id = NetworkLookup.attack_templates[attack_template_glance_name]
		end

		local falloff_damage = explosion_template.falloff_damage
		local push_speed = explosion_template.player_push_speed
		local damage_type = explosion_template.damage_type
		local damage_type_glance = explosion_template.damage_type_glance
		local radius = explosion_template.radius
		local max_damage_radius = explosion_template.max_damage_radius or 0
		local radius_min = explosion_template.radius_min
		local radius_max = explosion_template.radius_max

		if radius_min and radius_max then
			radius = math.lerp(radius_min, radius_max, scale)

			if explosion_template.max_damage_radius_min then
				local max_damage_radius_min = explosion_template.max_damage_radius_min
				local max_damage_radius_max = explosion_template.max_damage_radius_max
				max_damage_radius = math.lerp(max_damage_radius_min, max_damage_radius_max, scale)
			end
		end

		local glance_radius = max_damage_radius
		local grenade_friendly_fire = true

		fassert(radius, "Explosion with attack template %q has no radius or radius_min&radius_max set", attack_template_damage_type_name or "")

		if ScriptUnit.has_extension(attacker_unit, "buff_system") and (explosion_template.attack_template == "grenade" or explosion_template.attack_template == "fire_grenade_explosion") then
			local buff_extension = ScriptUnit.extension(attacker_unit, "buff_system")
			radius = buff_extension:apply_buffs_to_value(radius, StatBuffIndex.GRENADE_RADIUS)
			max_damage_radius = buff_extension:apply_buffs_to_value(max_damage_radius, StatBuffIndex.GRENADE_RADIUS)

			if buff_extension and buff_extension:has_buff_type("grenade_radius") then
				grenade_friendly_fire = false
			end
		end

		do_damage = explosion_template.damage or (explosion_template.damage_min and explosion_template.damage_max) or false
		local ignore_attacker_unit = explosion_template.ignore_attacker_unit
		local collision_filter = "filter_explosion_overlap_no_player"
		local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
		local attacker_player = Managers.player:owner(attacker_unit)
		local attacker_is_player = attacker_player ~= nil

		if (attacker_is_player and DamageUtils.allow_friendly_fire_ranged(difficulty_settings, attacker_player) and grenade_friendly_fire) or explosion_template.always_hurt_players then
			collision_filter = "filter_explosion_overlap"
		end

		local physics_world = World.physics_world(world)
		local actors, num_actors = PhysicsWorld.immediate_overlap(physics_world, "shape", "sphere", "position", position, "size", radius, "collision_filter", collision_filter, "use_global_table")
		local is_inside_inn = Managers.state.game_mode:level_key() == "inn_level"

		table.clear(units)

		local unit_get_data = Unit.get_data
		local actor_position = Actor.position
		local actor_unit = Actor.unit
		local impact_position = position
		local DamageUtils = DamageUtils
		local hit = 0

		for i = 1, num_actors, 1 do
			local hit_actor = actors[i]
			local hit_unit = actor_unit(hit_actor)

			if ScriptUnit.has_extension(hit_unit, "damage_system") then
				local ignore_damage = unit_get_data(hit_unit, "ignore_explosion_damage")

				if not units[hit_unit] and (not ignore_attacker_unit or hit_unit ~= attacker_unit) and not ignore_damage then
					local hit_zone_name = DamageUtils.aoe_hit_zone(hit_unit, hit_actor)

					if hit_zone_name ~= "afro" then
						units[hit_unit] = true
						hit = 1
						local target_radius, target_height = DamageUtils.calculate_aoe_size(hit_unit)
						local unit_position = POSITION_LOOKUP[hit_unit] or Unit.local_position(hit_unit, 0)
						local unit_top_position = unit_position + Vector3(0, 0, math.max(target_height - target_radius * 0.5, target_height * 0.5))
						local unit_bottom_position = unit_position + Vector3(0, 0, math.min(target_radius * 0.5, target_height * 0.5))
						local closest_point = Geometry.closest_point_on_line(impact_position, unit_bottom_position, unit_top_position)
						local hit_direction = closest_point - impact_position
						local hit_distance = math.max(Vector3.length(hit_direction) - target_radius, 0)
						local hit_direction_normalized = Vector3.normalize(hit_direction)

						if script_data.debug_projectiles then
							QuickDrawerStay:vector(position, hit_direction, Colors.get("brown"))
						end

						local hit_unit_id = network_manager:unit_game_object_id(hit_unit)
						local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]

						if glance_radius < hit_distance and attack_template_glance_id then
							attack_template_id = attack_template_glance_id
						end

						local breed = unit_get_data(hit_unit, "breed")

						if attacker_is_player then
							local attacker_unit_id = network_manager:unit_game_object_id(attacker_unit)

							if attack_template_id then
								local backstab_multiplier = 1
								local hawkeye_multiplier = 0

								weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[damage_source], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, hit_direction_normalized, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier, hawkeye_multiplier)
							end

							if breed then
								local item_data = ItemMasterList[damage_source]

								if item_data and not IGNORED_ITEM_TYPES_FOR_BUFFS[item_data.item_type] then
									local attacker_player = Managers.player:owner(attacker_unit)

									if attacker_player.remote then
										local peer_id = attacker_player.peer_id
										local attack_type_id = NetworkLookup.buff_proc_attack_types.aoe

										RPC.rpc_buff_on_attack(peer_id, attacker_unit_id, hit_unit_id, attack_type_id)
									else
										DamageUtils.buff_on_attack(attacker_unit, hit_unit, "aoe")
									end
								end

								AiUtils.aggro_unit_of_enemy(hit_unit, attacker_unit)
							end
						end

						if do_damage then
							local damage = nil
							local damage_min = explosion_template.damage_min
							local damage_max = explosion_template.damage_max
							local damage_table_to_use = explosion_template.damage
							local damage_type_real = damage_type

							if glance_radius < hit_distance and damage_type_glance then
								damage_type_real = damage_type_glance

								if falloff_damage then
									damage_table_to_use = falloff_damage
								end
							end

							if damage_min and damage_max then
								local damage_at_min = DamageUtils.calculate_damage(damage_min, hit_unit, attacker_unit, hit_zone_name, nil)
								local damage_at_max = DamageUtils.calculate_damage(damage_max, hit_unit, attacker_unit, hit_zone_name, nil)
								damage = math.lerp(damage_at_min, damage_at_max, scale)
							else
								damage = DamageUtils.calculate_damage(damage_table_to_use, hit_unit, attacker_unit, hit_zone_name, nil)
							end

							if max_damage_radius then
								damage = math.floor(math.auto_lerp(max_damage_radius, radius, damage, 1, math.clamp(hit_distance, max_damage_radius, radius)))
								push_speed = push_speed and math.auto_lerp(max_damage_radius, radius, push_speed, 1, math.clamp(hit_distance, max_damage_radius, radius))
							end

							local hit_ragdoll_actor = nil

							if breed and breed.hitbox_ragdoll_translation then
								hit_ragdoll_actor = breed.hitbox_ragdoll_translation.j_spine
							end

							if not is_inside_inn then
								DamageUtils.add_damage_network(hit_unit, attacker_unit, damage, hit_zone_name, damage_type_real, hit_direction_normalized, damage_source, hit_ragdoll_actor, damaging_unit)
							end

							if push_speed and DamageUtils.is_player_unit(hit_unit) then
								local status_extension = ScriptUnit.extension(hit_unit, "status_system")

								if not status_extension:is_disabled() then
									ScriptUnit.extension(hit_unit, "locomotion_system"):add_external_velocity(hit_direction_normalized * push_speed)
								end
							end
						end
					end
				end
			elseif hit_unit then
				local hit_direction = actor_position(hit_actor) - impact_position
				local unit_set_flow_variable = Unit.set_flow_variable

				unit_set_flow_variable(hit_unit, "hit_actor", hit_actor)
				unit_set_flow_variable(hit_unit, "hit_direction", hit_direction)
				unit_set_flow_variable(hit_unit, "hit_position", impact_position)
				Unit.flow_event(hit_unit, "lua_simple_damage")
			end
		end

		if explosion_template.attack_template == "grenade" then
			SurroundingAwareSystem.add_event(attacker_unit, "grenade_exp", DialogueSettings.grabbed_broadcast_range, "hit", hit, "grenade_owner", ScriptUnit.extension(attacker_unit, "dialogue_system").context.player_profile)
		end
	end
end

DamageUtils.create_aoe = function (world, attacker_unit, position, damage_source, explosion_template)
	local aoe_data = explosion_template.aoe
	local radius = aoe_data.radius
	local grenade_friendly_fire = true

	if ScriptUnit.has_extension(attacker_unit, "buff_system") and (explosion_template.name == "fire_grenade" or explosion_template.name == "smoke_grenade") then
		local buff_extension = ScriptUnit.extension(attacker_unit, "buff_system")
		radius = buff_extension:apply_buffs_to_value(radius, StatBuffIndex.GRENADE_RADIUS)

		if buff_extension and buff_extension:has_buff_type("grenade_radius") then
			grenade_friendly_fire = false
		end
	end

	local attacker_player = Managers.player:owner(attacker_unit)
	local damage_players = true

	if attacker_player ~= nil then
		local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
		damage_players = DamageUtils.allow_friendly_fire_ranged(difficulty_settings, attacker_player) and grenade_friendly_fire
	end

	local extension_init_data = {
		area_damage_system = {
			invisible_unit = true,
			aoe_dot_damage = 0,
			aoe_dot_damage_interval = aoe_data.damage_interval,
			radius = radius,
			life_time = aoe_data.duration,
			damage_players = damage_players,
			player_screen_effect_name = aoe_data.player_screen_effect_name,
			dot_effect_name = aoe_data.effect_name,
			extra_dot_effect_name = aoe_data.extra_effect_name,
			nav_mesh_effect = aoe_data.nav_mesh_effect,
			area_damage_template = aoe_data.area_damage_template or "explosion_template_aoe",
			damage_source = damage_source,
			create_nav_tag_volume = aoe_data.create_nav_tag_volume,
			nav_tag_volume_layer = aoe_data.nav_tag_volume_layer,
			explosion_template_name = explosion_template.name,
			owner_player = attacker_player
		}
	}
	local aoe_unit_name = "units/weapons/projectile/poison_wind_globe/poison_wind_globe"
	local aoe_unit = Managers.state.unit_spawner:spawn_network_unit(aoe_unit_name, "aoe_unit", extension_init_data, position)
	local unit_id = Managers.state.unit_storage:go_id(aoe_unit)

	Unit.set_unit_visibility(aoe_unit, false)
	Managers.state.network.network_transmit:send_rpc_all("rpc_area_damage", unit_id, position)
end

DamageUtils.calculate_damage_range_dropoff = function (damage_near_table, damage_far_table, range_dropoff_settings, target_unit, attacker_unit, hit_zone_name, headshot_multiplier)
	local near_damage = DamageUtils.calculate_damage(damage_near_table, target_unit, attacker_unit, hit_zone_name, headshot_multiplier)
	local far_damage = DamageUtils.calculate_damage(damage_far_table, target_unit, attacker_unit, hit_zone_name, headshot_multiplier)
	local attacker_position = Unit.local_position(attacker_unit, 0)
	local target_position = Unit.local_position(target_unit, 0)
	local dropoff_start = range_dropoff_settings.dropoff_start
	local dropoff_end = range_dropoff_settings.dropoff_end
	local dropoff_scale = dropoff_end - dropoff_start
	local distance = Vector3.distance(target_position, attacker_position)
	local new_distance = math.clamp(distance - dropoff_start, 0, dropoff_scale)
	local scalar = new_distance / dropoff_scale
	local damage = math.lerp(near_damage, far_damage, scalar)

	return damage
end

DamageUtils.networkify_damage = function (damage_amount)
	local damage = NetworkConstants.damage
	damage_amount = math.clamp(damage_amount, damage.min, damage.max)
	local decimal = damage_amount % 1
	local rounded_decimal = math.round(decimal * 4) * 0.25

	return math.floor(damage_amount) + rounded_decimal
end

DamageUtils.disable_collisions = function (unit)
	local num_actors = Unit.num_actors(unit)

	for i = 0, num_actors - 1, 1 do
		local actor = Unit.actor(unit, i)

		if actor then
			Actor.set_collision_enabled(actor, false)
			Actor.set_scene_query_enabled(actor, false)
		end
	end
end

DamageUtils.debug_swing = function (drawer, data)
	local extents = Vector3(0.5, 0.8, 0.1)
	local pos = data.camera_position:unbox()
	local rot = data.camera_rotation:unbox()
	local pos = pos + Vector3.normalize(Quaternion.forward(rot)) * (extents[2] * 0.5 + 0.44)
	local pose = Matrix4x4.from_quaternion_position(rot, pos)

	drawer:box(pose, extents)
end

DamageUtils.create_hit_zone_lookup = function (unit, breed)
	local hit_zones = breed.hit_zones
	local hit_zones_lookup = {}

	for zone_name, zone in pairs(hit_zones) do
		for k, actor_name in ipairs(zone.actors) do
			local actor = Unit.actor(unit, actor_name)

			if not actor then
				print("Actor ", actor_name .. " not found in ", breed.name)
			end

			local node = Actor.node(actor)
			hit_zones_lookup[node] = {
				name = zone_name,
				prio = zone.prio,
				actor_name = actor_name
			}
		end
	end

	breed.hit_zones_lookup = hit_zones_lookup
	BreedHitZonesLookup[breed.name] = hit_zones_lookup
end

DamageUtils.setup_single_frame_sweep = function (physics_world, pos, rot, extents, half_width)
	local right = Vector3.normalize(Quaternion.right(rot)) * half_width
	local height = Vector3.normalize(Quaternion.up(rot)) * 0.2
	local forward = Vector3.normalize(Quaternion.forward(rot)) * (extents[2] * 0.5 + 0.4) - height
	local pos1 = pos + forward + right
	local pos2 = (pos + forward) - right
	local hits = PhysicsWorld.linear_obb_sweep(physics_world, pos1, pos2, extents, rot, 3, "types", "dynamics", "collision_filter", "filter_melee_trigger")

	if hits and #hits > 0 and DamageUtils.handle_single_frame_sweep_per_units(hits, pos1, pos2, half_width * 2) then
		return hits
	end
end

DamageUtils.handle_single_frame_sweep = function (hits, p1, p2, width)
	local best_prio = 0
	local best_index, best_zone = nil

	for k, data in ipairs(hits) do
		local unit = Actor.unit(data.actor)
		local breed = Unit.get_data(unit, "breed") or Unit.get_data(unit, "bot")

		if breed then
			local node = Actor.node(data.actor)
			local hit_zone = breed.hit_zones_lookup[node]

			if hit_zone and hit_zone.prio and best_zone ~= hit_zone and best_prio <= hit_zone.prio then
				best_prio = hit_zone.prio
				best_index = k
				best_zone = hit_zone
			end

			local point = Geometry.closest_point_on_line(data.position, p1, p2)
			local d = Vector3.distance(p1, point)
			local time = d / width * 0.3
			data.when = time
			data.position = Vector3Box(data.position)
		end
	end

	if best_index then
		hits[best_index].hit_zone = best_zone
	end
end

DamageUtils.handle_single_frame_sweep_per_units = function (hits, p1, p2, width)
	local best_index, best_zone = nil
	local units_hit = {}

	for k, data in ipairs(hits) do
		if data.actor then
			local unit = Actor.unit(data.actor)
			local breed = Unit.get_data(unit, "breed") or Unit.get_data(unit, "bot")

			if breed then
				units_hit[unit] = units_hit[unit] or {
					best_prio = 0
				}
				local node = Actor.node(data.actor)
				local hit_zone = breed.hit_zones_lookup[node]
				local unit_prio = units_hit[unit]

				if hit_zone and hit_zone.prio and unit_prio.best_zone ~= hit_zone and unit_prio.best_prio <= hit_zone.prio then
					unit_prio.best_prio = hit_zone.prio
					unit_prio.best_index = k
					unit_prio.best_zone = hit_zone
				end

				local point = Geometry.closest_point_on_line(data.position, p1, p2)
				local d = Vector3.distance(p1, point)
				local time = d / width * 0.2
				data.when = time
				data.position = Vector3Box(data.position)
			else
				return false
			end
		else
			return false
		end
	end

	for unit, unit_prio in pairs(units_hit) do
		if unit_prio.best_index then
			hits[unit_prio.best_index].hit_zone = unit_prio.best_zone
		end
	end

	return true
end

local victim_units = {}

DamageUtils.add_damage_network = function (attacked_unit, attacker_unit, original_damage_amount, hit_zone_name, damage_type, damage_direction, damage_source, hit_ragdoll_actor, damaging_unit)
	local network_manager = Managers.state.network

	if not network_manager:game() then
		return
	end

	local player_manager = Managers.player
	local attacker_player = player_manager:owner(attacker_unit)
	local is_character, _ = DamageUtils.is_character(attacked_unit)
	local unit_id, is_level_unit = network_manager:game_object_or_level_id(attacked_unit)

	if attacker_player and attacker_player.bot_player and not is_character and not is_level_unit then
		return
	end

	if player_manager.is_server or LEVEL_EDITOR_TEST then
		table.clear(victim_units)

		local networkified_value = DamageUtils.networkify_damage(original_damage_amount)
		original_damage_amount = DamageUtils.apply_buffs_to_damage(networkified_value, attacked_unit, attacker_unit, damage_source, victim_units, damage_type)
	end

	local damage_amount = DamageUtils.networkify_damage(original_damage_amount)
	local attacker_unit_id, attacker_is_level_unit = network_manager:game_object_or_level_id(attacker_unit)
	local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
	local damage_type_id = NetworkLookup.damage_types[damage_type]
	local damage_source_id = NetworkLookup.damage_sources[damage_source or "n/a"]

	if player_manager.is_server or LEVEL_EDITOR_TEST then
		local num_victim_units = #victim_units

		for i = 1, num_victim_units, 1 do
			local victim_unit = victim_units[i]
			unit_id, is_level_unit = network_manager:game_object_or_level_id(victim_unit)
			damage_type = (victim_unit == attacked_unit and damage_type) or "buff"
			damage_type_id = NetworkLookup.damage_types[damage_type]
			local damage_extension = ScriptUnit.extension(victim_unit, "damage_system")

			damage_extension:add_damage(attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source, hit_ragdoll_actor, damaging_unit)

			if ScriptUnit.has_extension(attacker_unit, "hud_system") then
				local health_extension = ScriptUnit.extension(victim_unit, "health_system")
				local damage_source = NetworkLookup.damage_sources[damage_source_id]
				local should_indicate_hit = health_extension:is_alive() and attacker_unit ~= victim_unit and damage_source ~= "wounded_degen"

				if should_indicate_hit then
					local hud_extension = ScriptUnit.extension(attacker_unit, "hud_system")
					hud_extension.hit_enemy = true
				end
			end

			local owner = player_manager:owner(victim_unit)
			local breed = Unit.get_data(attacker_unit, "breed")

			if breed and owner then
				local has_inventory_extension = ScriptUnit.has_extension(attacker_unit, "ai_inventory_system")

				if has_inventory_extension then
					local inventory_extension = ScriptUnit.extension(attacker_unit, "ai_inventory_system")

					inventory_extension:play_hit_sound(victim_unit, damage_type)
				end
			end

			if not ScriptUnit.extension(attacked_unit, "health_system"):is_alive() then
				Managers.state.unit_spawner:prioritize_death_watch_unit(attacked_unit, Managers.time:time("game"))
			end

			local hit_ragdoll_actor_id = NetworkLookup.hit_ragdoll_actors[hit_ragdoll_actor or "n/a"]

			if not LEVEL_EDITOR_TEST then
				if is_level_unit then
					network_manager.network_transmit:send_rpc_clients("rpc_level_object_damage", unit_id, damage_amount, damage_direction, damage_source_id)
				else
					network_manager.network_transmit:send_rpc_clients("rpc_add_damage", unit_id, attacker_unit_id, attacker_is_level_unit, damage_amount, hit_zone_id, damage_type_id, damage_direction, damage_source_id, hit_ragdoll_actor_id)
				end
			end
		end
	elseif is_level_unit then
		network_manager.network_transmit:send_rpc_server("rpc_level_object_damage", unit_id, damage_amount, damage_direction, damage_source_id)
	else
		network_manager.network_transmit:send_rpc_server("rpc_add_damage_network", unit_id, attacker_unit_id, attacker_is_level_unit, damage_amount, hit_zone_id, damage_type_id, damage_direction, damage_source_id)
	end
end

local buff_params = {}

DamageUtils.buff_on_attack = function (unit, hit_unit, attack_type, predicted_damage)
	local network_manager = Managers.state.network
	local buff_extension = ScriptUnit.extension(unit, "buff_system")
	local health_extension = ScriptUnit.extension(unit, "health_system")
	local inventory_extension = ScriptUnit.extension(unit, "inventory_system")

	if not Unit.alive(hit_unit) then
		return false
	end

	local hit_unit_health_extension = ScriptUnit.extension(hit_unit, "health_system")

	if not hit_unit_health_extension:is_alive() then
		return false
	end

	if health_extension:current_health_percent() < 1 then
		local heal_type = "proc"
		local heal_amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.HEAL_PROC)

		if not procced and attack_type == "heavy_attack" then
			heal_amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.HEAVY_HEAL_PROC)
		end

		if not procced and attack_type == "light_attack" then
			heal_amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.LIGHT_HEAL_PROC)
		end

		if procced then
			if Managers.player.is_server or LEVEL_EDITOR_TEST then
				DamageUtils.heal_network(unit, unit, heal_amount, heal_type)
			else
				local network_transmit = network_manager.network_transmit
				local owner_unit_id = network_manager:unit_game_object_id(unit)
				local heal_type_id = NetworkLookup.heal_types[heal_type]

				network_transmit:send_rpc_server("rpc_request_heal", owner_unit_id, heal_amount, heal_type_id)
			end
		end
	end

	local attack_speed_multiplier, procced, parent_id = buff_extension:apply_buffs_to_value(1, StatBuffIndex.ATTACK_SPEED_PROC)

	if not procced and attack_type == "heavy_attack" then
		attack_speed_multiplier, procced, parent_id = buff_extension:apply_buffs_to_value(1, StatBuffIndex.HEAVY_ATTACK_SPEED_PROC)
	end

	if not procced and attack_type == "light_attack" then
		attack_speed_multiplier, procced, parent_id = buff_extension:apply_buffs_to_value(1, StatBuffIndex.LIGHT_ATTACK_SPEED_PROC)
	end

	if procced then
		table.clear(buff_params)

		buff_params.external_optional_multiplier = attack_speed_multiplier - 1
		buff_params.parent_id = parent_id

		buff_extension:add_buff("attack_speed_from_proc", buff_params)

		if inventory_extension:get_wielded_slot_name() == "slot_ranged" and not buff_extension:has_buff_type("infinite_ammo_from_proc") then
			buff_extension:add_buff("infinite_ammo_from_proc")
		elseif inventory_extension:get_wielded_slot_name() == "slot_melee" then
			buff_extension:add_buff("move_speed_from_proc")
		end
	end

	if attack_type ~= "heavy_attack" then
	end

	local fatigue_regen_multiplier, procced, parent_id = buff_extension:apply_buffs_to_value(1, StatBuffIndex.FATIGUE_REGEN_PROC)

	if procced then
		local status_extension = ScriptUnit.has_extension(unit, "status_system")

		table.clear(buff_params)

		buff_params.external_optional_multiplier = fatigue_regen_multiplier - 1
		buff_params.parent_id = parent_id

		buff_extension:add_buff("fatigue_regen_from_proc", buff_params)
		status_extension:reset_fatigue()
	end

	local amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.AMMO_PROC)

	if not procced and attack_type == "heavy_attack" then
		amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.HEAVY_AMMO_PROC)
	end

	if not procced and attack_type == "light_attack" then
		amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.LIGHT_AMMO_PROC)
	end

	if procced then
		local slot_data = inventory_extension:get_slot_data("slot_ranged")
		local right_unit_1p = slot_data.right_unit_1p
		local left_unit_1p = slot_data.left_unit_1p
		local right_hand_ammo_extension = ScriptUnit.has_extension(right_unit_1p, "ammo_system") and ScriptUnit.extension(right_unit_1p, "ammo_system")
		local left_hand_ammo_extension = ScriptUnit.has_extension(left_unit_1p, "ammo_system") and ScriptUnit.extension(left_unit_1p, "ammo_system")
		local ammo_extension = right_hand_ammo_extension

		if not ammo_extension and left_hand_ammo_extension then
			ammo_extension = left_hand_ammo_extension
		end

		if ammo_extension then
			local max_ammo = ammo_extension:max_ammo_count()
			local restore_amount = math.clamp(math.floor(max_ammo * 0.1), 1, math.huge)

			ammo_extension:add_ammo_to_reserve(restore_amount)
		end
	end

	local amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.OVERCHARGE_PROC)

	if not procced and attack_type == "heavy_attack" then
		amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.HEAVY_OVERCHARGE_PROC)
	end

	if not procced and attack_type == "light_attack" then
		amount, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.LIGHT_OVERCHARGE_PROC)
	end

	if procced then
		local slot_data = inventory_extension:get_slot_data("slot_ranged")
		local right_unit_1p = slot_data.right_unit_1p
		local left_unit_1p = slot_data.left_unit_1p
		local right_hand_overcharge_extension = ScriptUnit.has_extension(right_unit_1p, "overcharge_system") and ScriptUnit.extension(right_unit_1p, "overcharge_system")
		local left_hand_overcharge_extension = ScriptUnit.has_extension(left_unit_1p, "overcharge_system") and ScriptUnit.extension(left_unit_1p, "overcharge_system")
		local overcharge_extension = right_hand_overcharge_extension

		if not overcharge_extension and left_hand_overcharge_extension then
			overcharge_extension = left_hand_overcharge_extension
		end

		if overcharge_extension then
			overcharge_extension:remove_charge(amount)
		end
	end

	local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.POISON_PROC)

	if procced then
		DamageUtils.buff_attack_hit(inventory_extension, unit, hit_unit, "poison_proc")
	end

	local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.ADDED_PUSH)

	if procced then
		local breed = Unit.get_data(hit_unit, "breed")

		if not breed or not breed.boss then
			DamageUtils.buff_attack_hit(inventory_extension, unit, hit_unit, "added_push")
		end
	end

	local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.KILLING_BLOW_PROC)

	if not procced and attack_type == "light_attack" then
		_, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.LIGHT_KILLING_BLOW_PROC)
	end

	if procced and predicted_damage > 0 then
		DamageUtils.buff_attack_hit(inventory_extension, unit, hit_unit, "killing_blow_proc")

		return "killing_blow"
	end

	if attack_type == "heavy_attack" then
		local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.HEAVY_KILLING_BLOW_PROC)

		if procced then
			local health_extension = ScriptUnit.extension(hit_unit, "health_system")
			local health = health_extension:current_health()
			local calls = math.ceil(health / 255)

			for i = 1, calls, 1 do
				DamageUtils.buff_attack_hit(inventory_extension, unit, hit_unit, "heroic_killing_blow_proc")
			end

			return "killing_blow"
		end
	end

	return true
end

local ignored_shared_damage_types = {
	wounded_dot = true,
	suicide = true,
	knockdown_bleed = true
}

DamageUtils.apply_buffs_to_damage = function (current_damage, attacked_unit, attacker_unit, damage_source, victim_units, damage_type)
	local damage = current_damage
	victim_units[#victim_units + 1] = attacked_unit
	local damage_ext = ScriptUnit.extension(attacked_unit, "damage_system")

	if damage_ext:has_assist_shield() and not ignored_shared_damage_types[damage_source] then
		local network_manager = Managers.state.network
		local attacked_unit_id = network_manager:unit_game_object_id(attacked_unit)

		network_manager.network_transmit:send_rpc_clients("rpc_remove_assist_shield", attacked_unit_id)
	end

	damage = damage_ext:get_damage_after_shield(damage)
	local attacked_player = Managers.player:owner(attacked_unit)
	local attacker_player = Managers.player:owner(attacker_unit)

	if ScriptUnit.has_extension(attacked_unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(attacked_unit, "buff_system")
		local status_extension = ScriptUnit.has_extension(attacked_unit, "status_system")
		local is_packmaster_victim = status_extension and (status_extension:is_grabbed_by_pack_master() or status_extension:is_hanging_from_hook())

		if damage_source == "skaven_poison_wind_globadier" then
			damage = buff_extension:apply_buffs_to_value(damage, StatBuffIndex.PROTECTION_POISON_WIND)
		end

		if damage_source == "skaven_gutter_runner" then
			damage = buff_extension:apply_buffs_to_value(damage, StatBuffIndex.PROTECTION_GUTTER_RUNNER)
		end

		if damage_source == "skaven_ratling_gunner" then
			damage = buff_extension:apply_buffs_to_value(damage, StatBuffIndex.PROTECTION_RATLING_GUNNER)
		end

		if is_packmaster_victim then
			damage = buff_extension:apply_buffs_to_value(damage, StatBuffIndex.PROTECTION_PACK_MASTER)
		end

		if buff_extension and buff_extension:has_buff_type("damage_reduction_from_proc") then
			damage = buff_extension:apply_buffs_to_value(damage, StatBuffIndex.DAMAGE_REDUCTION_FROM_PROC)
		end

		if buff_extension:has_buff_type("shared_health_pool") and not ignored_shared_damage_types[damage_source] then
			local player_and_bot_units = PLAYER_AND_BOT_UNITS
			local num_player_and_bot_units = #player_and_bot_units
			local num_players_with_shared_health_pool = 1

			for i = 1, num_player_and_bot_units, 1 do
				local unit = player_and_bot_units[i]

				if unit ~= attacked_unit then
					local buff_extension = ScriptUnit.extension(unit, "buff_system")

					if buff_extension:has_buff_type("shared_health_pool") then
						num_players_with_shared_health_pool = num_players_with_shared_health_pool + 1
						victim_units[#victim_units + 1] = unit
					end
				end
			end

			damage = damage / num_players_with_shared_health_pool
		end

		local is_invulnerable = buff_extension:has_buff_type("invulnerable")

		if is_invulnerable then
			damage = 0
		end

		damage = buff_extension:apply_buffs_to_value(damage, StatBuffIndex.DAMAGE_TAKEN)
		local is_knocked_down = status_extension and status_extension:is_knocked_down()

		if is_knocked_down then
			damage = buff_extension:apply_buffs_to_value(damage, StatBuffIndex.DAMAGE_TAKEN_KD)
		end
	end

	boon_handler = attacked_player and attacked_player.boon_handler

	if boon_handler then
		local boon_name = "reduced_damage"

		if damage_type ~= "overcharge" then
			local num_reduced_damage_boons = boon_handler:get_num_boons(boon_name)
			local boon_template = BoonTemplates[boon_name]
			local reduced_damage_amount = boon_template.reduced_damage_amount
			local reduced_damage_percent = math.max(1 - reduced_damage_amount * num_reduced_damage_boons, 0)
			damage = damage * reduced_damage_percent
		end
	end

	boon_handler = attacker_player and attacker_player.boon_handler

	if boon_handler and not DamageUtils.is_player_unit(attacked_unit) then
		local boon_name = "increased_damage"
		local num_increased_damage_boons = boon_handler:get_num_boons(boon_name)
		local boon_template = BoonTemplates[boon_name]
		local increased_damage_amount = boon_template.increased_damage_amount
		local increased_damage_percent = 1 + increased_damage_amount * num_increased_damage_boons
		damage = damage * increased_damage_percent
	end

	return damage
end

DamageUtils.buff_attack_hit = function (inventory_extension, unit, hit_unit, attack_template)
	local network_manager = Managers.state.network
	local wielded_slot_name = inventory_extension:get_wielded_slot_name()
	local slot_data = inventory_extension:get_slot_data(wielded_slot_name)
	local item_data = slot_data.item_data
	local item_name = item_data.name
	local damage_source_id = NetworkLookup.damage_sources[item_name]
	local unit_id = network_manager:unit_game_object_id(unit)
	local hit_unit_id = network_manager:unit_game_object_id(hit_unit)
	local attack_template_id = NetworkLookup.attack_templates[attack_template]
	local attack_damage_values_id = NetworkLookup.attack_damage_values["n/a"]
	local hit_zone_id = NetworkLookup.hit_zones.full
	local attack_direction = Vector3.normalize(POSITION_LOOKUP[hit_unit] - POSITION_LOOKUP[unit])
	local hit_ragdoll_actor_id = NetworkLookup.hit_ragdoll_actors["n/a"]
	local backstab_multiplier = 1
	local hawkeye_multiplier = 0
	local is_server = network_manager.is_server

	if is_server or LEVEL_EDITOR_TEST then
		local weapon_system = Managers.state.entity:system("weapon_system")

		weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[item_name], unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_damage_values_id, hit_ragdoll_actor_id, backstab_multiplier, hawkeye_multiplier)
	else
		network_manager.network_transmit:send_rpc_server("rpc_attack_hit", damage_source_id, unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_damage_values_id, hit_ragdoll_actor_id, backstab_multiplier, hawkeye_multiplier)
	end
end

DamageUtils.assist_shield_network = function (shielded_unit, shielder_unit, shield_amount)
	assert(Managers.player.is_server or LEVEL_EDITOR_TEST)

	local damage_extension = ScriptUnit.extension(shielded_unit, "damage_system")

	damage_extension:shield(shield_amount)

	local status_extension = ScriptUnit.extension(shielded_unit, "status_system")

	status_extension:set_shielded(true)

	if not LEVEL_EDITOR_TEST then
		local network_manager = Managers.state.network
		local unit_id = network_manager:unit_game_object_id(shielded_unit)
		local shielder_unit_id = network_manager:unit_game_object_id(shielder_unit)

		network_manager.network_transmit:send_rpc_clients("rpc_heal", unit_id, shielder_unit_id, shield_amount, NetworkLookup.heal_types.shield_by_assist)
	end
end

local healed_units = {}

DamageUtils.heal_network = function (healed_unit, healer_unit, heal_amount, heal_type)
	assert(Managers.player.is_server or LEVEL_EDITOR_TEST)
	table.clear(healed_units)

	local shared_medpack = false
	heal_amount, shared_medpack = DamageUtils.apply_buffs_to_heal(healed_unit, healer_unit, heal_amount, heal_type, healed_units)
	heal_amount = DamageUtils.networkify_damage(heal_amount)
	heal_amount = heal_amount or 0
	local num_healed_units = #healed_units

	for i = 1, num_healed_units, 1 do
		local unit = healed_units[i]
		heal_type = (shared_medpack and "buff_shared_medpack") or (unit == healed_unit and heal_type) or "buff"
		local damage_extension = ScriptUnit.extension(unit, "damage_system")

		damage_extension:heal(unit, heal_amount)

		local status_extension = ScriptUnit.extension(unit, "status_system")

		status_extension:healed(heal_type)

		if not LEVEL_EDITOR_TEST then
			local network_manager = Managers.state.network
			local unit_id = network_manager:unit_game_object_id(unit)
			local healer_unit_id = network_manager:unit_game_object_id(healer_unit)

			if status_extension:heal_can_remove_wounded(heal_type) then
				StatusUtils.set_wounded_network(unit, false, "healed")
			end

			network_manager.network_transmit:send_rpc_clients("rpc_heal", unit_id, healer_unit_id, heal_amount, NetworkLookup.heal_types[heal_type])
		end
	end

	if healed_unit == healer_unit and (heal_type == "bandage" or heal_type == "healing_draught" or heal_type == "buff_shared_medpack") and ScriptUnit.has_extension(healer_unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(healer_unit, "buff_system")

		if buff_extension and buff_extension:has_buff_type("medpack_spread_area") then
			local player_and_bot_units = PLAYER_AND_BOT_UNITS
			local num_player_units = #player_and_bot_units

			for i = 1, num_player_units, 1 do
				local unit = player_and_bot_units[i]
				local unit_position = POSITION_LOOKUP[unit]
				local healer_position = POSITION_LOOKUP[healer_unit]

				if unit ~= healer_unit and Vector3.distance(unit_position, healer_position) < TrinketSpreadDistance then
					local health_extension = ScriptUnit.extension(unit, "health_system")
					local damage_taken = health_extension.damage
					local heal_amount = buff_extension:apply_buffs_to_value(damage_taken, StatBuffIndex.MEDPACK_SPREAD_AREA)
					heal_amount = heal_amount - damage_taken

					DamageUtils.heal_network(unit, healer_unit, heal_amount, "bandage_trinket")
				end
			end
		end
	end
end

DamageUtils.apply_buffs_to_heal = function (healed_unit, healer_unit, heal_amount, heal_type, healed_units)
	local shared_medpack = false
	healed_units[#healed_units + 1] = healed_unit

	if ScriptUnit.has_extension(healed_unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(healed_unit, "buff_system")

		if buff_extension:has_buff_type("shared_health_pool") then
			local player_and_bot_units = PLAYER_AND_BOT_UNITS
			local num_player_and_bot_units = #player_and_bot_units
			local num_players_with_shared_health_pool = 1

			for i = 1, num_player_and_bot_units, 1 do
				local unit = player_and_bot_units[i]

				if unit ~= healed_unit then
					local buff_extension = ScriptUnit.extension(unit, "buff_system")

					if buff_extension:has_buff_type("shared_health_pool") then
						num_players_with_shared_health_pool = num_players_with_shared_health_pool + 1
						healed_units[#healed_units + 1] = unit
					end
				end
			end

			heal_amount = heal_amount / num_players_with_shared_health_pool

			if heal_type == "bandage" or heal_type == "healing_draught" then
				shared_medpack = true
			end
		end
	end

	return heal_amount, shared_medpack
end

DamageUtils.debug_deal_damage = function (victim_unit, attack_template_name, hit_zone_name)
	local network_manager = Managers.state.network
	local attack_direction = Vector3(1, 0, 0)
	local hit_unit_id = network_manager:unit_game_object_id(victim_unit)

	if hit_unit_id == nil then
		print("DamageUtils.debug_deal_damage failed, victim_unit had no go_id")

		return
	end

	local attacker_unit_id = hit_unit_id
	hit_zone_name = hit_zone_name or "torso"
	local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
	local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
	local attack_template_damage_type_id = NetworkLookup.attack_damage_values["n/a"]
	local backstab_multiplier = 1
	local hawkeye_multiplier = 0

	network_manager.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources.debug, attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier, hawkeye_multiplier)
end

DamageUtils.deal_damage = function (source, victim_unit, attacker_unit, attack_direction, attack_template_name, hit_zone_name)
	attack_template_name = attack_template_name or "basic_sweep_damage"
	local network_manager = Managers.state.network
	local hit_unit_id = network_manager:unit_game_object_id(victim_unit)
	local attacker_unit_id = network_manager:unit_game_object_id(attacker_unit)
	hit_zone_name = hit_zone_name or "torso"
	local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
	local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
	local attack_template_damage_type_id = NetworkLookup.attack_damage_values["n/a"]
	local backstab_multiplier = 1
	local hawkeye_multiplier = 0

	network_manager.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources[source], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier, hawkeye_multiplier)
end

DamageUtils.check_distance = function (action, blackboard, attacking_unit, target_unit)
	local breed_attacker = Unit.get_data(attacking_unit, "breed")
	local pos_attacker = Unit.local_position(attacking_unit, 0)
	local pos_target = Unit.local_position(target_unit, 0)
	local to_target = pos_target - pos_attacker
	local blackboard = Unit.get_data(attacking_unit, "blackboard")
	local player_radius = 1

	if blackboard.target_dodged_during_attack then
		player_radius = 0.5
	end

	if action.use_box_range then
		local x = to_target.x
		local y = to_target.y
		local z = to_target.z
		local flat_range = blackboard.attack_range_flat + player_radius

		if z < blackboard.attack_range_up and blackboard.attack_range_down < z and x * x + y * y < flat_range * flat_range then
			return true
		end
	else
		local dist = Vector3.length(to_target)

		if dist <= (breed_attacker.weapon_reach or breed_attacker.radius) + player_radius then
			return true
		end
	end

	return false
end

DamageUtils.check_infront = function (attacking_unit, target_unit)
	local pos_attacker = Unit.local_position(attacking_unit, 0)
	local pos_target = Unit.local_position(target_unit, 0)
	local to_target = Vector3.flat(pos_target - pos_attacker)
	local rot_attacker = Unit.local_rotation(attacking_unit, 0)
	local fwd_attacker = Quaternion.forward(rot_attacker)
	local cos_a = Vector3.dot(Vector3.normalize(to_target), fwd_attacker)
	local breed_attacker = Unit.get_data(attacking_unit, "breed")
	local blackboard = Unit.get_data(attacking_unit, "blackboard")
	local default_reach_cone = 0.866

	if blackboard.target_dodged_during_attack then
		default_reach_cone = 0.95
	end

	if (breed_attacker.weapon_reach_cone or default_reach_cone) < cos_a then
		return true
	end

	return false
end

DamageUtils.check_block = function (attacking_unit, target_unit, fatigue_type)
	if attacking_unit == target_unit then
		return false
	end

	local network_manager = Managers.state.network
	local _, is_level_unit = network_manager:game_object_or_level_id(target_unit)

	if is_level_unit or DamageUtils.is_enemy(target_unit) then
		return false
	end

	local status_extension = ScriptUnit.extension(target_unit, "status_system")

	if status_extension:is_blocking() then
		status_extension:blocked_attack(fatigue_type, attacking_unit)

		if not LEVEL_EDITOR_TEST and Managers.player.is_server then
			local unit_storage = Managers.state.unit_storage
			local go_id = unit_storage:go_id(target_unit)
			local fatigue_type_id = NetworkLookup.fatigue_types[fatigue_type]
			local attacking_unit_id = unit_storage:go_id(attacking_unit)

			network_manager.network_transmit:send_rpc_clients("rpc_player_blocked_attack", go_id, fatigue_type_id, attacking_unit_id)

			local blackboard = Unit.get_data(attacking_unit, "blackboard")

			if blackboard then
				blackboard.blocked = true
			end
		end

		return true
	end

	return false
end

DamageUtils.check_ranged_block = function (attacking_unit, target_unit, attack_direction, fatigue_type, can_be_blocked_by_parry)
	local status_extension = ScriptUnit.extension(target_unit, "status_system")
	local network_manager = Managers.state.network
	local player = Managers.player

	if status_extension:is_blocking() then
		local inventory_extension = ScriptUnit.extension(target_unit, "inventory_system")
		local weapon_data = inventory_extension:get_wielded_slot_item_template()

		if not weapon_data then
			return false
		end

		if not can_be_blocked_by_parry and not weapon_data.can_block_ranged_attacks then
			return false
		end

		local network_manager = Managers.state.network
		local game = network_manager:game()
		local unit_id = network_manager:unit_game_object_id(target_unit)
		local aim_direction = GameSession.game_object_field(game, unit_id, "aim_direction")
		local dot = Vector3.dot(Vector3.normalize(attack_direction), Vector3.normalize(aim_direction))

		if dot > -0.7 then
			return false
		end

		status_extension:blocked_attack(fatigue_type, attacking_unit)

		if not LEVEL_EDITOR_TEST and Managers.player.is_server then
			local unit_storage = Managers.state.unit_storage
			local go_id = unit_storage:go_id(target_unit)
			local fatigue_type_id = NetworkLookup.fatigue_types[fatigue_type]
			local attacking_unit_id = unit_storage:go_id(attacking_unit)

			network_manager.network_transmit:send_rpc_clients("rpc_player_blocked_attack", go_id, fatigue_type_id, attacking_unit_id or 0)
		end

		return true
	end

	return false
end

DamageUtils.camera_shake_by_distance = function (shake_name, start_time, player_unit, source_unit, near_dist, far_dist, near_value, far_value)
	local local_player = Managers.player:local_player()

	if not local_player then
		return
	end

	local player_unit_to_shake = player_unit or local_player.player_unit

	if not player_unit_to_shake then
		return
	end

	local scale = 1

	if source_unit then
		local d = Vector3.distance(Unit.local_position(source_unit, 0), Unit.local_position(player_unit_to_shake, 0))
		scale = 1 - math.clamp((d - near_dist) / (far_dist - near_dist), 0, 1)
		scale = far_value + scale * (near_value - far_value)
	end

	Managers.state.camera:camera_effect_shake_event(shake_name, start_time, scale)
end

local INDEX_POSITION = 1
local INDEX_DISTANCE = 2
local INDEX_NORMAL = 3
local INDEX_ACTOR = 4
local hit_units = {}
local hit_data = {}

DamageUtils.is_enemy = function (unit)
	return Unit.has_data(unit, "breed")
end

DamageUtils.is_character = function (unit)
	local has_breed = Unit.has_data(unit, "breed")

	return has_breed or table.contains(PLAYER_AND_BOT_UNITS, unit), has_breed
end

DamageUtils.allow_friendly_fire_ranged = function (difficulty_settings, attacker_player)
	return difficulty_settings.friendly_fire_ranged and not attacker_player.bot_player
end

DamageUtils.allow_friendly_fire_melee = function (difficulty_settings, attacker_player)
	local network_manager = Managers.state.network
	local game = network_manager:game()
	local attacker_unit = attacker_player.player_unit
	local attacker_unit_id = network_manager:unit_game_object_id(attacker_unit)
	local friendly_fire_override = GameSession.game_object_field(game, attacker_unit_id, "friendly_fire_melee")

	return friendly_fire_override or (difficulty_settings.friendly_fire_melee and not attacker_player.bot_player)
end

DamageUtils.damage_level_unit = function (hit_unit, hit_normal, level_index, attack_template_name, attack_template_damage_type_name, damage_source, attacker_unit, attack_direction, is_server)
	local attack_template = AttackTemplates[attack_template_name]

	if attack_template.attack_type then
		local hit_zone_name = "full"
		local attack_damage_value = AttackDamageValues[attack_template_damage_type_name]
		local hit_ragdoll_actor = nil
		local backstab_multiplier = 1
		local attack = Attacks[attack_template.attack_type]
		local damage_amount = attack.get_damage_amount(damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, backstab_multiplier)
		local damage_extension = ScriptUnit.extension(hit_unit, "damage_system")

		damage_extension:add_damage(hit_unit, damage_amount, hit_zone_name, "destructible_level_object_hit", hit_normal, damage_source)

		local damage_source_id = NetworkLookup.damage_sources[damage_source]

		if is_server then
			Managers.state.network.network_transmit:send_rpc_clients("rpc_level_object_damage", level_index, damage_amount, hit_normal, damage_source_id)
		else
			Managers.state.network.network_transmit:send_rpc_server("rpc_level_object_damage", level_index, damage_amount, hit_normal, damage_source_id)
		end
	end
end

script_data.debug_legendary_traits = script_data.debug_legendary_traits or Development.parameter("debug_legendary_traits")

DamageUtils.process_projectile_hit = function (world, damage_source, owner_unit, is_server, raycast_result, current_action, direction, check_buffs, target)
	local hit_units = hit_units

	table.clear(hit_units)
	table.clear(hit_data)

	local attack_direction = direction
	local owner_is_player = owner_unit and Managers.player:owner(owner_unit)
	local damage_source_id = NetworkLookup.damage_sources[damage_source]
	local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
	local num_penetrations = 0
	local max_penetrations = current_action.max_penetrations or 1
	local buff_extension = nil

	if ScriptUnit.has_extension(owner_unit, "buff_system") then
		buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
	end

	if owner_is_player then
		max_penetrations = buff_extension:apply_buffs_to_value(max_penetrations, StatBuffIndex.PENETRATING_SHOT_PROC)
	end

	local ai_system = Managers.state.entity:system("ai_system")
	local owner_is_bot = owner_is_player and owner_is_player.bot_player
	local is_husk = (owner_is_bot and true) or false
	local hit_effect = current_action.hit_effect
	local num_hits = #raycast_result
	hit_data.hits = num_penetrations

	for i = 1, num_hits, 1 do
		local hit = raycast_result[i]
		local hit_position = hit[INDEX_POSITION]
		local hit_distance = hit[INDEX_DISTANCE]
		local hit_normal = hit[INDEX_NORMAL]
		local hit_actor = hit[INDEX_ACTOR]
		local hit_valid_target = hit_actor ~= nil
		local hit_unit = (hit_valid_target and Actor.unit(hit_actor)) or nil
		local attack_hit_self = hit_unit == owner_unit

		if not attack_hit_self and hit_valid_target then
			local hit_rotation = Quaternion.look(hit_normal)
			local is_inventory_item = ScriptUnit.has_extension(hit_unit, "ai_inventory_item_system")
			local is_target = hit_unit == target or target == nil

			if is_inventory_item then
				Unit.flow_event(hit_unit, "break_shield")

				hit_units[hit_unit] = true
			end

			local breed = Unit.get_data(hit_unit, "breed")
			local is_player = table.contains(PLAYER_AND_BOT_UNITS, hit_unit)
			local is_character = breed or is_player

			if not is_character then
				local network_manager = Managers.state.network
				local level_index, is_level_unit = network_manager:game_object_or_level_id(hit_unit)
				local has_damage_extension = ScriptUnit.has_extension(hit_unit, "damage_system")
				local owner = Managers.player:owner(hit_unit)

				if is_level_unit and not hit_units[hit_unit] and (GameSettingsDevelopment.allow_ranged_attacks_to_damage_props or Unit.get_data(hit_unit, "allow_ranged_damage")) and has_damage_extension then
					hit_units[hit_unit] = true

					DamageUtils.damage_level_unit(hit_unit, hit_normal, level_index, current_action.attack_template, current_action.attack_template_damage_type, damage_source, owner_unit, attack_direction, is_server)

					hit_data.stop = true
					hit_data.hits = num_penetrations + 1

					return hit_data
				elseif not is_level_unit and has_damage_extension and not owner then
					hit_units[hit_unit] = true
					local network_manager = Managers.state.network
					local attacker_unit_id = network_manager:unit_game_object_id(owner_unit)
					local hit_unit_id = network_manager:unit_game_object_id(hit_unit)
					local hit_zone_name = "full"
					local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
					local attack_template_id = NetworkLookup.attack_templates[current_action.attack_template]
					local attack_template_damage_type_id = NetworkLookup.attack_damage_values[current_action.attack_template_damage_type or "n/a"]
					local backstab_multiplier = 1
					local hawkeye_multiplier = 0

					if is_server or LEVEL_EDITOR_TEST then
						local weapon_system = Managers.state.entity:system("weapon_system")

						weapon_system:rpc_attack_hit(nil, damage_source_id, attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier, hawkeye_multiplier)
					else
						network_manager.network_transmit:send_rpc_server("rpc_attack_hit", damage_source_id, attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier, hawkeye_multiplier)
					end

					EffectHelper.play_surface_material_effects(hit_effect, world, hit_unit, hit_position, hit_rotation, hit_normal, nil, is_husk)

					if Managers.state.network:game() then
						EffectHelper.remote_play_surface_material_effects(hit_effect, world, hit_unit, hit_position, hit_rotation, hit_normal, is_server)
					end

					hit_data.stop = true
					hit_data.hits = num_penetrations + 1

					return hit_data
				else
					if current_action.alert_sound_range_hit and owner_unit then
						ai_system:alert_enemies_within_range(owner_unit, hit_position, current_action.alert_sound_range_fire)
					end

					if not is_inventory_item then
						local hit_unit_owner = Managers.player:owner(hit_unit)

						if hit_unit_owner == nil or hit_unit_owner.player_unit == nil then
							EffectHelper.play_surface_material_effects(hit_effect, world, hit_unit, hit_position, hit_rotation, hit_normal, nil, is_husk)

							if Managers.state.network:game() then
								EffectHelper.remote_play_surface_material_effects(hit_effect, world, hit_unit, hit_position, hit_rotation, hit_normal, is_server)
							end

							local unit_set_flow_variable = Unit.set_flow_variable
							local hit_direction = Vector3.multiply(hit_normal, -1)

							unit_set_flow_variable(hit_unit, "hit_actor", hit_actor)
							unit_set_flow_variable(hit_unit, "hit_direction", hit_direction)
							unit_set_flow_variable(hit_unit, "hit_position", hit_position)
							Unit.flow_event(hit_unit, "lua_simple_damage")
						end

						hit_data.stop = true
						hit_data.hits = 1

						return hit_data
					end
				end
			elseif not hit_units[hit_unit] and is_target and ((is_player and (not owner_is_player or DamageUtils.allow_friendly_fire_ranged(difficulty_settings, owner_is_player))) or breed) then
				local network_manager = Managers.state.network
				local attacker_unit_id = network_manager:unit_game_object_id(owner_unit)
				local hit_unit_id = network_manager:unit_game_object_id(hit_unit)
				local hit_zone_name = nil

				if breed then
					local node = Actor.node(hit_actor)
					local hit_zone = breed.hit_zones_lookup[node]
					hit_zone_name = hit_zone.name

					if hit_zone_name ~= "afro" and owner_is_player then
						local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.AUTOMATIC_HEAD_SHOT)

						if procced and breed.hit_zones.head then
							hit_zone_name = "head"
						end
					end
				else
					hit_zone_name = "torso"
				end

				if breed and hit_zone_name == "head" and owner_is_player then
					local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.COOP_STAMINA)

					if (procced or script_data.debug_legendary_traits) and AiUtils.unit_alive(hit_unit) then
						local headshot_coop_stamina_fatigue_type = breed.headshot_coop_stamina_fatigue_type or "headshot_clan_rat"
						local fatigue_type_id = NetworkLookup.fatigue_types[headshot_coop_stamina_fatigue_type]

						if is_server then
							network_manager.network_transmit:send_rpc_clients("rpc_replenish_fatigue_other_players", fatigue_type_id)
						else
							network_manager.network_transmit:send_rpc_server("rpc_replenish_fatigue_other_players", fatigue_type_id)
						end

						StatusUtils.replenish_stamina_local_players(owner_unit, headshot_coop_stamina_fatigue_type)

						local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

						first_person_extension:play_hud_sound_event("hud_player_buff_headshot")
					end
				end

				local hit_unit_player = Managers.player:owner(hit_unit)

				if hit_zone_name == "afro" then
					local attacker_is_player = Managers.player:owner(owner_unit)

					if attacker_is_player then
						if is_server then
							if ScriptUnit.has_extension(hit_unit, "ai_system") then
								AiUtils.alert_unit_of_enemy(hit_unit, owner_unit)
							end
						else
							local network_manager = Managers.state.network

							network_manager.network_transmit:send_rpc_server("rpc_alert_enemy", hit_unit_id, attacker_unit_id)
						end
					end
				elseif hit_unit_player and hit_actor == Unit.actor(hit_unit, "c_afro") then
					local afro_hit_sound = current_action.afro_hit_sound

					if afro_hit_sound and not hit_unit_player.bot_player and Managers.state.network:game() then
						local sound_id = NetworkLookup.sound_events[afro_hit_sound]

						network_manager.network_transmit:send_rpc("rpc_play_first_person_sound", hit_unit_player.peer_id, hit_unit_id, sound_id, hit_position)
					end
				else
					hit_units[hit_unit] = true
					local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
					local attack_template_name = current_action.attack_template
					local attack_template = AttackTemplates[attack_template_name]
					local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
					local attack_damage_values_name = current_action.attack_template_damage_type
					local attack_template_damage_type_id = NetworkLookup.attack_damage_values[attack_damage_values_name or "n/a"]

					if owner_is_player and breed and check_buffs then
						local buffs_checked = DamageUtils.buff_on_attack(owner_unit, hit_unit, "instant_projectile")
						hit_data.buffs_checked = hit_data.buffs_checked or buffs_checked
					end

					local damage_sound = attack_template.sound_type
					local backstab_multiplier = 1
					local hawkeye_multiplier = 0
					local hawkeye = buff_extension and buff_extension:has_buff_type("increased_zoom")

					if hawkeye and (hit_zone_name == "head" or hit_zone_name == "neck") then
						hawkeye_multiplier = buff_extension:apply_buffs_to_value(hawkeye_multiplier, StatBuffIndex.HAWKEYE)
					end

					local predicted_damage = 0

					if attack_template.attack_type then
						local attack_damage_value = AttackDamageValues[attack_damage_values_name]
						local attack = Attacks[attack_template.attack_type]
						local hit_ragdoll_actor = nil
						predicted_damage = attack.get_damage_amount(damage_source, attack_template, owner_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, backstab_multiplier, hawkeye_multiplier)
					end

					no_damage = predicted_damage <= 0

					if breed then
						local enemy_type = breed.name

						EffectHelper.play_skinned_surface_material_effects(hit_effect, world, hit_unit, hit_position, hit_rotation, hit_normal, is_husk, enemy_type, damage_sound, no_damage, hit_zone_name)

						if Managers.state.network:game() then
							EffectHelper.remote_play_skinned_surface_material_effects(hit_effect, world, hit_position, hit_rotation, hit_normal, enemy_type, damage_sound, no_damage, hit_zone_name, is_server)
						end
					elseif hit_unit_player and current_action.player_push_velocity then
						local status_extension = ScriptUnit.extension(hit_unit, "status_system")

						if not status_extension:is_disabled() then
							local max_impact_push_speed = current_action.max_impact_push_speed
							local locomotion = ScriptUnit.extension(hit_unit, "locomotion_system")

							locomotion:add_external_velocity(current_action.player_push_velocity:unbox(), max_impact_push_speed)
						end
					end

					local deal_damage = true

					if hit_unit_player then
						deal_damage = not DamageUtils.check_ranged_block(owner_unit, hit_unit, attack_direction, "blocked_ranged", current_action.can_be_blocked_by_parry)
					end

					if deal_damage then
						if is_server or LEVEL_EDITOR_TEST then
							local weapon_system = Managers.state.entity:system("weapon_system")

							weapon_system:rpc_attack_hit(nil, damage_source_id, attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier, hawkeye_multiplier)
						else
							network_manager.network_transmit:send_rpc_server("rpc_attack_hit", damage_source_id, attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier, hawkeye_multiplier)
						end
					end

					if no_damage then
						max_penetrations = num_penetrations
					else
						num_penetrations = num_penetrations + 1
					end

					if max_penetrations <= num_penetrations then
						hit_data.stop = true
						hit_data.hits = num_penetrations

						return hit_data
					end
				end
			end
		end
	end

	return hit_data
end

DamageUtils.pitch_from_rotation = function (rotation)
	local forward = Vector3.normalize(Quaternion.forward(rotation))
	local forward_flat = Vector3.normalize(Vector3.flat(forward))
	local dot = Vector3.dot(forward, forward_flat)
	dot = math.clamp(dot, -1, 1)
	local forward_flat_length = Vector3.length(forward_flat)
	local angle = math.radians_to_degrees(math.acos(dot))
	local up_vector = Vector3(0, 0, 1)
	local up_dot = Vector3.dot(forward, up_vector)

	if up_dot < 0 then
		angle = -angle
	end

	return angle
end

DamageUtils.modify_damage_taken = function (unit, multiplier, bonus_reduction_damage)
	local damage_extension = ScriptUnit.extension(unit, "damage_system")
	local recent_damages, num_damages = damage_extension:recent_damages()

	for j = 1, num_damages / DamageDataIndex.STRIDE, 1 do
		local damage_type = recent_damages[(j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_TYPE]

		if damage_type ~= "heal" then
			local damage_index = (j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_AMOUNT
			local damage = math.max(recent_damages[damage_index] - bonus_reduction_damage, 0)
			local reduced_damage = damage * multiplier
			recent_damages[damage_index] = reduced_damage
		end
	end
end

DamageUtils.modify_damage = function (unit, victims, multiplier, bonus_damage)
	local num_victims = #victims

	for i = 1, num_victims, 1 do
		local victim = victims[i]
		local damage_extension = ScriptUnit.extension(victim, "damage_system")
		local recent_damages, num_damages = damage_extension:recent_damages()

		for j = 1, num_damages / DamageDataIndex.STRIDE, 1 do
			local attacker = recent_damages[(j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.ATTACKER]
			local damage_type = recent_damages[(j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_TYPE]

			if attacker == unit and victim ~= attacker and damage_type ~= "heal" then
				local damage_index = (j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_AMOUNT
				local damage = recent_damages[damage_index] + bonus_damage
				local boosted_damage = damage * multiplier
				recent_damages[damage_index] = boosted_damage
			end
		end
	end
end

DamageUtils.modify_healing_taken_from_self = function (unit, multiplier, bonus_healing)
	local damage_extension = ScriptUnit.extension(unit, "damage_system")
	local recent_damages, num_damages = damage_extension:recent_damages()

	for j = 1, num_damages / DamageDataIndex.STRIDE, 1 do
		local attacker = recent_damages[(j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.ATTACKER]
		local damage_type = recent_damages[(j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_TYPE]

		if attacker == unit and damage_type == "heal" then
			local damage_index = (j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_AMOUNT
			local healing = recent_damages[damage_index] + bonus_healing
			local modified_healing = healing * multiplier
			recent_damages[damage_index] = modified_healing
		end
	end
end

DamageUtils.modify_healing_taken_from_other = function (unit, multiplier, bonus_healing)
	local damage_extension = ScriptUnit.extension(unit, "damage_system")
	local recent_damages, num_damages = damage_extension:recent_damages()

	for j = 1, num_damages / DamageDataIndex.STRIDE, 1 do
		local attacker = recent_damages[(j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.ATTACKER]
		local damage_type = recent_damages[(j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_TYPE]

		if attacker ~= unit and damage_type == "heal" then
			local damage_index = (j - 1) * DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_AMOUNT
			local healing = recent_damages[damage_index] + bonus_healing
			local modified_healing = healing * multiplier
			recent_damages[damage_index] = modified_healing
		end
	end
end

DamageUtils.modify_healing_done_to_others = function (healer_unit, healed_unit, heal_amount)
	if heal_amount and healer_unit ~= healed_unit and ScriptUnit.has_extension(healer_unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(healer_unit, "buff_system")
		local new_heal_amount = buff_extension:apply_buffs_to_value(heal_amount, StatBuffIndex.HEALING_DONE_TO_OTHERS)

		return new_heal_amount
	end

	return heal_amount
end

DamageUtils.modify_push_distance_with_buff = function (attacker, value)
	if Unit.alive(attacker) and ScriptUnit.has_extension(attacker, "buff_system") then
		local buff_extension = ScriptUnit.extension(attacker, "buff_system")
		local new_value = buff_extension:apply_buffs_to_value(value, StatBuffIndex.PUSH)

		return new_value
	end

	return value
end

DamageUtils.server_apply_hit = function (t, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, hit_ragdoll_actor, damage_source, attack_damage_value_type, backstab_multiplier, hawkeye_multiplier)
	if attack_template.attack_type then
		local attack_type = attack_template.attack_type
		local attack = Attacks[attack_type]
		local damage_amount = attack.get_damage_amount(damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value_type, hit_ragdoll_actor, backstab_multiplier, hawkeye_multiplier)

		attack.do_damage(damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value_type, hit_ragdoll_actor, damage_amount)
	end

	if attack_template.stagger_type then
		local stagger_func = Staggers[attack_template.stagger_type]

		stagger_func(attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, t)
	end

	if attack_template.dot_type then
		local dot_func = Dots[attack_template.dot_type]

		dot_func(attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value_type, damage_source)
	end
end

return
