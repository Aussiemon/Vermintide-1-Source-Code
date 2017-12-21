PlayerProjectileHuskExtension = class(PlayerProjectileHuskExtension)
PlayerProjectileHuskExtension.init = function (self, extension_init_context, unit, extension_init_data)
	local owner_unit = extension_init_data.owner_unit
	self.world = extension_init_context.world
	self.unit = unit
	self.owner_unit = owner_unit
	self.owner_player = Managers.player:owner(owner_unit)
	local item_name = extension_init_data.item_name
	local item_data = ItemMasterList[item_name]
	local item_template = BackendUtils.get_item_template(item_data)
	local item_template_name = extension_init_data.item_template_name
	local action_name = extension_init_data.action_name
	local sub_action_name = extension_init_data.sub_action_name
	self.item_name = item_name
	self.action_lookup_data = {
		item_template_name = item_template_name,
		action_name = action_name,
		sub_action_name = sub_action_name
	}
	self.action = item_template.actions[action_name][sub_action_name]
	local projectile_info = self.action.projectile_info
	self.projectile_info = projectile_info
	self.time_initialized = extension_init_data.time_initialized
	self.scale = extension_init_data.scale
	self.hit_targets = 0
	self.hit_units = {}
	local entity_manager = Managers.state.entity
	self.projectile_linker_system = entity_manager.system(entity_manager, "projectile_linker_system")
	self.is_server = Managers.player.is_server
	self.active = true
	self.was_active = true
	self.did_damage = false

	self.initialize_projectile(self, projectile_info)

	self._kills = 0

	return 
end
PlayerProjectileHuskExtension.destroy = function (self)
	if 0 < self._kills and self.projectile_info.is_grenade then
		local player_manager = Managers.player
		local player = self.owner_player
		local local_player = player_manager.local_player(player_manager)

		if self.is_server then
			if player == local_player then
				local statistics_db = player_manager.statistics_db(player_manager)
				local stats_id = player.stats_id(player)
				local best_projectile_multikill = statistics_db.get_stat(statistics_db, stats_id, "best_projectile_multikill")

				if best_projectile_multikill < self._kills then
					statistics_db.set_stat(statistics_db, stats_id, "best_projectile_multikill", self._kills)
				end
			elseif player.is_player_controlled(player) then
				local peer_id = player.network_id(player)
				local network_manager = Managers.state.network
				local in_game_session = network_manager.in_game_session(network_manager)

				if in_game_session then
					network_manager.network_transmit:send_rpc("rpc_set_local_player_stat", peer_id, NetworkLookup.statistics.best_projectile_multikill, self._kills)
				end
			end
		end
	end

	return 
end
PlayerProjectileHuskExtension.extensions_ready = function (self, world, unit)
	self.locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")

	return 
end
PlayerProjectileHuskExtension.initialize_projectile = function (self, projectile_info)
	local unit = self.unit
	local impact_data = projectile_info.impact_data

	if impact_data then
		self.is_impact = true
		self.num_targets = impact_data.targets
	end

	local timed_data = projectile_info.timed_data

	if timed_data then
		self.is_timed = true
		self.life_time = self.time_initialized + timed_data.life_time
	end

	if projectile_info.times_bigger then
		local scale = self.scale

		Unit.set_flow_variable(unit, "scale", scale)

		local times_bigger = projectile_info.times_bigger
		local unit_scale = math.lerp(1, times_bigger, scale)

		Unit.set_local_scale(unit, 0, Vector3(unit_scale, unit_scale, unit_scale))
	end

	Unit.flow_event(unit, "lua_projectile_init")
	Unit.flow_event(unit, "lua_trail")

	return 
end
PlayerProjectileHuskExtension.update = function (self, unit, input, _, context, t)
	if not self.active then
		if self.was_active then
			self.was_active = false
		end

		return 
	end

	if self.is_timed then
		self.handle_timed_events(self, t)
	end

	return 
end
PlayerProjectileHuskExtension.stop = function (self)
	Unit.flow_event(self.unit, "lua_projectile_end")
	self.locomotion_extension:stop()

	self.stop_impacts = true
	self.active = false

	return 
end
PlayerProjectileHuskExtension.handle_timed_events = function (self, t)
	if self.life_time <= t then
		local unit = self.unit
		local timed_data = self.projectile_info.timed_data
		local aoe_data = timed_data.aoe

		if aoe_data then
			self.do_aoe(self, aoe_data, POSITION_LOOKUP[unit])
		end

		self.stop(self)
	end

	return 
end
PlayerProjectileHuskExtension.impact_level = function (self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, level_index)
	local impact_data = self.projectile_info.impact_data

	self.hit_level_unit(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, self.hit_units, level_index)

	return 
end
PlayerProjectileHuskExtension.impact_dynamic = function (self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
	local impact_data = self.projectile_info.impact_data
	local breed = Unit.get_data(hit_unit, "breed")
	local is_player = table.contains(PLAYER_AND_BOT_UNITS, hit_unit)

	if breed then
		self.hit_enemy(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, breed, self.hit_units)
	elseif is_player then
		self.hit_player(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, self.hit_units)
	elseif not is_player then
		self.hit_non_level_unit(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, self.hit_units)
	end

	return 
end
PlayerProjectileHuskExtension.hit_afro = function (self, breed, hit_actor)
	local node = Actor.node(hit_actor)
	local hit_zone = breed.hit_zones_lookup[node]
	local hit_zone_name = hit_zone.name

	return hit_zone_name == "afro", hit_zone_name
end
PlayerProjectileHuskExtension.hit_enemy = function (self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, breed, hit_units)
	if hit_actor == nil then
		return 
	end

	if self.hit_afro(self, breed, hit_actor) then
		return 
	end

	local damage_data = impact_data.damage

	if damage_data and hit_units[hit_unit] == nil then
		self.hit_enemy_damage(self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, breed, hit_units)

		if not impact_data.aoe then
			DamageUtils.buff_on_attack(self.owner_unit, hit_unit, "projectile")
		end
	end

	local aoe_data = impact_data.aoe

	if aoe_data then
		self.do_aoe(self, aoe_data, hit_position)
		self.stop(self)
	end

	if self.hit_targets == self.num_targets then
		if impact_data.link and self.did_damage then
			self.link_projectile(self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, self.did_damage)
		end

		self.stop(self)
	end

	return 
end
PlayerProjectileHuskExtension.hit_enemy_damage = function (self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, breed, hit_units)
	local enemy_impact_data = damage_data.enemy_unit_hit
	local network_manager = Managers.state.network
	local owner_unit = self.owner_unit
	local owner = self.owner_player
	local action = self.action
	local node = Actor.node(hit_actor)
	local hit_zone = breed.hit_zones_lookup[node]
	local hit_zone_name = hit_zone.name
	local attack_direction = hit_direction
	local hit_targets = self.hit_targets + 1
	self.hit_targets = hit_targets
	hit_units[hit_unit] = true
	local target_settings = (enemy_impact_data.targets and enemy_impact_data.targets[hit_targets]) or enemy_impact_data.default_target
	local attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(target_settings, false)
	local attack_template = AttackTemplates[attack_template_name]
	local hit_effect = action.hit_effect
	local is_husk = not owner.local_player
	local damage_sound = attack_template.sound_type
	local enemy_type = breed.name
	local hit_rotation = Quaternion.look(hit_normal)
	local predicted_damage = 0

	if attack_template.attack_type then
		local attack_damage_value = (attack_template_damage_type_name and AttackDamageValues[attack_template_damage_type_name]) or nil
		local attack = Attacks[attack_template.attack_type]
		local hit_ragdoll_actor = nil
		local backstab_multiplier = 1
		predicted_damage = attack.get_damage_amount(self.item_name, attack_template, owner_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, backstab_multiplier)
	end

	no_damage = predicted_damage <= 0

	if no_damage then
		self.did_damage = false

		self.stop(self)
	else
		self.did_damage = predicted_damage

		if hit_zone_name == "head" or hit_zone_name == "neck" then
			self.did_damage = predicted_damage - 1
		end
	end

	local breed = hit_unit and Unit.get_data(hit_unit, "breed")

	if breed.armor_category == 2 then
		self.hit_targets = self.num_targets
	end

	if hit_effect then
		EffectHelper.play_skinned_surface_material_effects(hit_effect, self.world, hit_position, hit_rotation, hit_normal, is_husk, enemy_type, damage_sound, no_damage, hit_zone_name)
	end

	return 
end
PlayerProjectileHuskExtension.hit_player = function (self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units)
	if hit_actor == nil then
		return 
	end

	local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
	local hit = false
	local owner_player = self.owner_player
	local damage_data = impact_data.damage

	if damage_data and DamageUtils.allow_friendly_fire_ranged(difficulty_settings, owner_player) and hit_units[hit_unit] == nil then
		self.hit_player_damage(self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units)

		hit = true
	end

	if hit then
		local aoe_data = impact_data.aoe

		if aoe_data then
			self.do_aoe(self, aoe_data, hit_position)
			self.stop(self)
		end

		if self.hit_targets == self.num_targets then
			self.stop(self)
		end
	end

	return 
end
PlayerProjectileHuskExtension.hit_player_damage = function (self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units)
	local hit_targets = self.hit_targets + 1
	self.hit_targets = hit_targets
	hit_units[hit_unit] = true
	local enemy_impact_data = damage_data.enemy_unit_hit
	local target_settings = (enemy_impact_data.targets and enemy_impact_data.targets[hit_targets]) or enemy_impact_data.default_target
	local attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(target_settings, false)
	local attack_template = AttackTemplates[attack_template_name]
	local hit_zone_name = "torso"
	local attack_template_damage_type_id = -1

	if attack_template_damage_type_name then
		local attack_damage_value = AttackDamageValues[attack_template_damage_type_name]
		attack_template_damage_type_id = attack_damage_value.lookup_id
	end

	local action = self.action
	local hit_effect = action.hit_effect
	local owner_unit = self.owner_unit
	local owner = self.owner_player
	local is_husk = not owner.local_player
	local damage_sound = attack_template.sound_type
	local hit_rotation = Quaternion.look(hit_direction, Vector3.up())
	local predicted_damage = 0

	if attack_template.attack_type then
		local attack_damage_value = (attack_template_damage_type_name and AttackDamageValues[attack_template_damage_type_name]) or nil
		local attack = Attacks[attack_template.attack_type]
		local hit_ragdoll_actor = nil
		local backstab_multiplier = 1
		predicted_damage = attack.get_damage_amount(self.item_name, attack_template, owner_unit, hit_unit, hit_zone_name, hit_direction, attack_damage_value, hit_ragdoll_actor, backstab_multiplier)
	end

	no_damage = predicted_damage <= 0

	if no_damage then
		self.did_damage = false
		self.stop_impacts = true
	else
		self.did_damage = predicted_damage
	end

	if hit_effect then
		EffectHelper.play_skinned_surface_material_effects(hit_effect, self.world, hit_position, hit_rotation, hit_normal, is_husk)
	end

	return 
end
PlayerProjectileHuskExtension.hit_level_unit = function (self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units, level_index)
	local has_damage_extension = ScriptUnit.has_extension(hit_unit, "damage_system")
	local damage_data = impact_data.damage

	if (GameSettingsDevelopment.allow_ranged_attacks_to_damage_props or Unit.get_data(hit_unit, "allow_ranged_damage")) and damage_data then
		if has_damage_extension and hit_units[hit_unit] == nil then
			self.hit_damagable_prop(self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units, level_index)
		elseif hit_actor then
			local unit_set_flow_variable = Unit.set_flow_variable

			unit_set_flow_variable(hit_unit, "hit_actor", hit_actor)
			unit_set_flow_variable(hit_unit, "hit_direction", hit_direction)
			unit_set_flow_variable(hit_unit, "hit_position", hit_position)
			Unit.flow_event(hit_unit, "lua_simple_damage")
		end
	end

	local action = self.action
	local hit_effect = action.hit_effect

	if hit_effect then
		local world = self.world
		local hit_rotation = Quaternion.look(hit_direction)
		local owner = self.owner_player
		local is_husk = not owner.local_player

		EffectHelper.play_surface_material_effects(hit_effect, world, hit_unit, hit_position, hit_rotation, hit_normal, nil, is_husk)
	end

	local aoe_data = impact_data.aoe

	if aoe_data then
		self.do_aoe(self, aoe_data, hit_position)
	end

	if impact_data.link and hit_actor then
		self.link_projectile(self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
	end

	self.stop(self)

	return 
end
PlayerProjectileHuskExtension.hit_damagable_prop = function (self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units, level_index)
	hit_units[hit_unit] = true

	return 
end
PlayerProjectileHuskExtension.hit_non_level_unit = function (self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units)
	local stop_impacts = false
	local damage_data = impact_data.damage

	if damage_data and ScriptUnit.has_extension(hit_unit, "damage_system") and hit_units[hit_unit] == nil then
		self.hit_non_level_damagable_unit(self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units)

		stop_impacts = true
	end

	local aoe_data = impact_data.aoe

	if aoe_data then
		self.do_aoe(self, aoe_data, hit_position)

		stop_impacts = true
	end

	if stop_impacts then
		self.stop(self)
	end

	return 
end
PlayerProjectileHuskExtension.hit_non_level_damagable_unit = function (self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, hit_units)
	local network_manager = Managers.state.network
	local level_impact_data = damage_data.damagable_prop_hit
	hit_units[hit_unit] = true
	local action = self.action
	local hit_effect = action.hit_effect

	if hit_effect then
		local world = self.world
		local hit_rotation = Quaternion.look(hit_direction)
		local owner = self.owner_player
		local is_husk = not owner.local_player

		EffectHelper.play_surface_material_effects(hit_effect, world, hit_unit, hit_position, hit_rotation, hit_normal, nil, is_husk)
	end

	return 
end
PlayerProjectileHuskExtension.link_projectile = function (self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, damage)
	local unit_spawner = Managers.state.unit_spawner
	local projectile_linker_system = self.projectile_linker_system
	local owner_unit = self.owner_unit
	local projectile_info = self.projectile_info
	local dummy_linker_unit_name = projectile_info.dummy_linker_unit_name
	local broken_chance = math.random()
	local impact_data = projectile_info.impact_data
	local depth = impact_data.depth or 0.15
	local depth_offset = impact_data.depth_offset or 0.15

	if damage then
		broken_chance = broken_chance*math.clamp(damage/2, 0.75, 1.25)
	else
		broken_chance = broken_chance*2
	end

	if broken_chance <= 0.5 and projectile_info.dummy_linker_broken_units then
		local broken_unit_variations = #projectile_info.dummy_linker_broken_units
		local random_pick = math.floor(math.random(1, broken_unit_variations))
		dummy_linker_unit_name = projectile_info.dummy_linker_broken_units[random_pick]

		if random_pick == 1 then
			depth = 0.05
			depth_offset = 0.1
		else
			depth_offset = 0.15
		end
	elseif damage then
		depth = depth*math.clamp(damage, 1, 3)
	end

	local normalized_direction = Vector3.normalize(hit_direction)
	depth = depth + depth_offset
	local random_bank = math.random()*2.14 - 0.5
	local link_position = hit_position + normalized_direction*depth
	local link_rotation = Quaternion.look(normalized_direction)
	local new_link_rotation = Quaternion.multiply(link_rotation, Quaternion(Vector3.forward(), random_bank))
	local has_projectile_linker_extension = ScriptUnit.has_extension(hit_unit, "projectile_linker_system")

	if has_projectile_linker_extension and hit_actor then
		local projectile_dummy = unit_spawner.spawn_local_unit(unit_spawner, dummy_linker_unit_name, link_position, new_link_rotation)
		local node_index = Actor.node(hit_actor)
		local hit_node_rot = Unit.world_rotation(hit_unit, node_index)
		local hit_node_pos = Unit.world_position(hit_unit, node_index)
		local rel_pos = link_position - hit_node_pos
		local offset_position = Vector3(Vector3.dot(Quaternion.right(hit_node_rot), rel_pos), Vector3.dot(Quaternion.forward(hit_node_rot), rel_pos), Vector3.dot(Quaternion.up(hit_node_rot), rel_pos))
		local linker_extension = ScriptUnit.extension(hit_unit, "projectile_linker_system")

		linker_extension.link_projectile(linker_extension, projectile_dummy, offset_position, new_link_rotation, node_index)
		projectile_linker_system.add_linked_projectile_reference(projectile_linker_system, owner_unit, projectile_dummy)
	elseif not has_projectile_linker_extension then
		local projectile_dummy = unit_spawner.spawn_local_unit(unit_spawner, dummy_linker_unit_name, link_position, new_link_rotation)

		projectile_linker_system.add_linked_projectile_reference(projectile_linker_system, owner_unit, projectile_dummy)
	end

	return 
end
PlayerProjectileHuskExtension.do_aoe = function (self, aoe_data, position)
	local world = self.world
	local owner_unit = self.owner_unit

	if aoe_data.explosion then
		local is_husk = true

		DamageUtils.create_explosion(world, owner_unit, position, Unit.local_rotation(self.unit, 0), aoe_data.explosion, self.scale, self.item_name, self.is_server, is_husk, self.unit)
	end

	if aoe_data.aoe and self.is_server then
		DamageUtils.create_aoe(world, owner_unit, position, self.item_name, aoe_data)
	end

	return 
end
PlayerProjectileHuskExtension.add_kill = function (self)
	self._kills = self._kills + 1

	return 
end

return 
