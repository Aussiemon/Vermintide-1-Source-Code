PlayerProjectileUnitExtension = class(PlayerProjectileUnitExtension)
local DELETION_GRACE_TIMER = 0.3
PlayerProjectileUnitExtension.init = function (self, extension_init_context, unit, extension_init_data)
	local world = extension_init_context.world
	local owner_unit = extension_init_data.owner_unit
	self.world = world
	self.physics_world = World.get_data(world, "physics_world")
	self.unit = unit
	self.owner_unit = owner_unit
	self.owner_player = Managers.player:owner(owner_unit)
	local item_name = extension_init_data.item_name
	self.item_name = item_name
	local item_data = ItemMasterList[item_name]
	local item_template = BackendUtils.get_item_template(item_data)
	local item_template_name = extension_init_data.item_template_name
	local action_name = extension_init_data.action_name
	local sub_action_name = extension_init_data.sub_action_name
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
	self.hit_affro_units = {}
	local entity_manager = Managers.state.entity
	self.weapon_system = entity_manager.system(entity_manager, "weapon_system")
	self.projectile_linker_system = entity_manager.system(entity_manager, "projectile_linker_system")
	self.is_server = Managers.player.is_server
	self.marked_for_deletion = false
	self.did_damage = false

	self.initialize_projectile(self, projectile_info)

	self._kills = 0

	return 
end
PlayerProjectileUnitExtension.extensions_ready = function (self, world, unit)
	self.locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
	self.impact_extension = ScriptUnit.extension(unit, "projectile_impact_system")

	return 
end
PlayerProjectileUnitExtension.initialize_projectile = function (self, projectile_info)
	local unit = self.unit
	local impact_data = projectile_info.impact_data

	if impact_data then
		self.is_impact = true
		self.num_targets = impact_data.targets
		self.stop_impacts = false
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
PlayerProjectileUnitExtension.mark_for_deletion = function (self)
	if not self.marked_for_deletion then
		self.locomotion_extension:stop()

		self.marked_for_deletion = true
		self.deletion_time = Managers.time:time("game") + DELETION_GRACE_TIMER

		Unit.flow_event(self.unit, "lua_projectile_end")
	end

	return 
end
PlayerProjectileUnitExtension.update = function (self, unit, input, _, context, t)
	if self.marked_for_deletion then
		if self.deletion_time <= t and not self.delete_done then
			self.delete_done = true

			Managers.state.unit_spawner:mark_for_deletion(self.unit)
		end

		return 
	end

	if self.is_timed then
		self.handle_timed_events(self, t)
	end

	if self.is_impact and not self.stop_impacts then
		local impact_extension = self.impact_extension
		local recent_impacts, num_impacts = impact_extension.recent_impacts(impact_extension)

		if 0 < num_impacts then
			self.handle_impacts(self, recent_impacts, num_impacts)
		end
	end

	return 
end
PlayerProjectileUnitExtension.handle_timed_events = function (self, t)
	if self.life_time <= t then
		local unit = self.unit
		local timed_data = self.projectile_info.timed_data
		local aoe_data = timed_data.aoe

		if aoe_data then
			self.do_aoe(self, aoe_data, POSITION_LOOKUP[unit])
		end

		self.mark_for_deletion(self)

		self.stop_impacts = true
	end

	return 
end
PlayerProjectileUnitExtension.destroy = function (self)
	if 0 < self._kills and self.projectile_info.is_grenade then
		local player = self.owner_player
		local player_manager = Managers.player
		local local_player = player_manager.local_player(player_manager)

		if self.is_server and player then
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

				network_manager.network_transmit:send_rpc("rpc_set_local_player_stat", peer_id, NetworkLookup.statistics.best_projectile_multikill, self._kills)
			end
		end
	end

	return 
end
PlayerProjectileUnitExtension.validate_position = function (self, position, min, max)
	for i = 1, 3, 1 do
		local coord = position[i]

		if coord < min or max < coord then
			print("[PlayerProjectileUnitExtension] position is not valid, outside of NetworkConstants.position")

			return false
		end
	end

	return true
end
PlayerProjectileUnitExtension.handle_impacts = function (self, impacts, num_impacts)
	local unit = self.unit
	local owner_unit = self.owner_unit
	local UNIT_INDEX = ProjectileImpactDataIndex.UNIT
	local POSITION_INDEX = ProjectileImpactDataIndex.POSITION
	local DIRECTION_INDEX = ProjectileImpactDataIndex.DIRECTION
	local NORMAL_INDEX = ProjectileImpactDataIndex.NORMAL
	local ACTOR_INDEX = ProjectileImpactDataIndex.ACTOR_INDEX
	local hit_units = self.hit_units
	local hit_affro_units = self.hit_affro_units
	local impact_data = self.projectile_info.impact_data
	local link = impact_data.link
	local num_targets = self.num_targets
	local network_manager = Managers.state.network
	local network_transmit = network_manager.network_transmit
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)
	local pos_min = NetworkConstants.position.min
	local pos_max = NetworkConstants.position.max

	for i = 1, num_impacts/ProjectileImpactDataIndex.STRIDE, 1 do
		if self.stop_impacts then
			break
		end

		local j = (i - 1)*ProjectileImpactDataIndex.STRIDE
		local hit_unit = impacts[j + UNIT_INDEX]
		local hit_position = impacts[j + POSITION_INDEX]:unbox()
		local hit_direction = impacts[j + DIRECTION_INDEX]:unbox()
		local hit_normal = impacts[j + NORMAL_INDEX]:unbox()
		local actor_index = impacts[j + ACTOR_INDEX]
		local hit_actor = Unit.actor(hit_unit, actor_index)
		local validate_position = self.validate_position(self, hit_position, pos_min, pos_max)

		if not validate_position then
			self.mark_for_deletion(self)

			self.stop_impacts = true
		end

		local hit_self = hit_unit == owner_unit

		if not hit_self and validate_position and not hit_units[hit_unit] then
			local breed = Unit.get_data(hit_unit, "breed")
			local hit_affro = false

			if breed and self.hit_afro(self, breed, hit_actor) then
				if not hit_affro_units[hit_unit] then
					if ScriptUnit.has_extension(hit_unit, "ai_system") then
						if self.is_server then
							AiUtils.alert_unit_of_enemy(hit_unit, owner_unit)
						elseif Unit.alive(owner_unit) then
							local network_manager = Managers.state.network

							network_manager.network_transmit:send_rpc_server("rpc_alert_enemy", network_manager.unit_game_object_id(network_manager, hit_unit), network_manager.unit_game_object_id(network_manager, owner_unit))
						end
					end

					if script_data.ai_debug_sound_detection then
						local drawer = Managers.state.debug:drawer({
							mode = "retained",
							name = "sound_alert_wizz"
						})

						drawer.sphere(drawer, hit_position, 1.5, Colors.get("blue"))
					end

					hit_affro_units[hit_unit] = true
				end

				hit_affro = true
			else
				hit_units[hit_unit] = true
			end

			if not hit_affro then
				if breed then
					local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
					local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.AUTOMATIC_HEAD_SHOT)
					local node = Actor.node(hit_actor)
					local hit_zone = breed.hit_zones_lookup[node]

					if procced and breed.hit_zones.head and hit_zone.name ~= "head" then
						local head_hit_zone = breed.hit_zones.head
						local actors = head_hit_zone.actors
						local num_actors = #actors

						for i = 1, num_actors, 1 do
							local actor_name = actors[i]
							local head_actor_index = Unit.find_actor(hit_unit, actor_name)

							if head_actor_index then
								local head_actor = Unit.actor(hit_unit, head_actor_index)
								local actor_position = Actor.center_of_mass(head_actor)
								local validate_position = self.validate_position(self, actor_position, pos_min, pos_max)

								if validate_position then
									hit_actor = head_actor
									actor_index = head_actor_index
									hit_position = actor_position

									break
								end
							end
						end
					end
				end

				local level_index, is_level_unit = network_manager.game_object_or_level_id(network_manager, hit_unit)

				if self.is_server then
					if is_level_unit then
						network_transmit.send_rpc_clients(network_transmit, "rpc_player_projectile_impact_level", unit_id, level_index, hit_position, hit_direction, hit_normal, actor_index)
					elseif level_index then
						network_transmit.send_rpc_clients(network_transmit, "rpc_player_projectile_impact_dynamic", unit_id, level_index, hit_position, hit_direction, hit_normal, actor_index)
					end
				elseif is_level_unit then
					network_transmit.send_rpc_server(network_transmit, "rpc_player_projectile_impact_level", unit_id, level_index, hit_position, hit_direction, hit_normal, actor_index)
				elseif level_index then
					network_transmit.send_rpc_server(network_transmit, "rpc_player_projectile_impact_dynamic", unit_id, level_index, hit_position, hit_direction, hit_normal, actor_index)
				end

				if breed then
					self.hit_enemy(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, breed)
				elseif table.contains(PLAYER_AND_BOT_UNITS, hit_unit) then
					self.hit_player(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
				elseif is_level_unit then
					self.hit_level_unit(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, level_index)
				elseif not is_level_unit then
					self.hit_non_level_unit(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
				end
			end
		end
	end

	return 
end
PlayerProjectileUnitExtension.hit_afro = function (self, breed, hit_actor)
	local node = Actor.node(hit_actor)
	local hit_zone = breed.hit_zones_lookup[node]
	local hit_zone_name = hit_zone.name

	return hit_zone_name == "afro", hit_zone_name
end
PlayerProjectileUnitExtension.hit_enemy = function (self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, breed)
	local owner_unit = self.owner_unit
	local damage_data = impact_data.damage

	if damage_data then
		self.hit_enemy_damage(self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, breed)

		if not impact_data.aoe then
			DamageUtils.buff_on_attack(self.owner_unit, hit_unit, "projectile")
		end
	end

	local aoe_data = impact_data.aoe
	local grenade = impact_data.grenade or nil

	if grenade or (aoe_data and self.hit_targets == self.num_targets) then
		self.do_aoe(self, aoe_data, hit_position)
		self.mark_for_deletion(self)

		self.stop_impacts = true
	end

	if self.hit_targets == self.num_targets then
		if impact_data.link and self.did_damage then
			self.link_projectile(self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, self.did_damage)
		end

		self.mark_for_deletion(self)

		self.stop_impacts = true
	end

	if self.locomotion_extension.notify_hit_enemy then
		self.locomotion_extension:notify_hit_enemy(hit_unit)
	end

	self._check_projectile_spawn(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)

	return 
end
PlayerProjectileUnitExtension.hit_enemy_damage = function (self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, breed)
	local enemy_impact_data = damage_data.enemy_unit_hit
	local network_manager = Managers.state.network
	local owner_unit = self.owner_unit
	local owner = self.owner_player
	local action = self.action
	local node = Actor.node(hit_actor)
	local hit_zone = breed.hit_zones_lookup[node]
	local hit_zone_name = action.projectile_info.forced_hitzone or hit_zone.name
	local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
	local attack_direction = hit_direction
	local hit_targets = self.hit_targets

	if AiUtils.unit_alive(hit_unit) then
		hit_targets = hit_targets + 1
		self.hit_targets = hit_targets
	end

	local target_settings = (enemy_impact_data.targets and enemy_impact_data.targets[hit_targets]) or enemy_impact_data.default_target
	local attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(target_settings, false)
	local attack_template = AttackTemplates[attack_template_name]
	local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
	local attack_template_damage_type_id = NetworkLookup.attack_damage_values[attack_template_damage_type_name or "n/a"]
	local attacker_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
	local hit_unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
	local wall_nail = action.projectile_info.impact_data.wall_nail
	local hit_ragdoll_actor = nil

	if wall_nail then
		local actor_name = hit_zone.actor_name

		if breed.hitbox_ragdoll_translation then
			hit_ragdoll_actor = breed.hitbox_ragdoll_translation[actor_name]
		end
	end

	if hit_ragdoll_actor == nil then
		hit_ragdoll_actor = "n/a"
	end

	local backstab_multiplier = 1

	if self.is_server then
		self.weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors[hit_ragdoll_actor], backstab_multiplier)
	else
		Managers.state.network.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors[hit_ragdoll_actor], backstab_multiplier)
	end

	local hit_effect = action.hit_effect
	local is_husk = not owner.local_player
	local damage_sound = attack_template.sound_type
	local enemy_type = breed.name
	local hit_rotation = Quaternion.look(attack_direction, Vector3.up())
	local predicted_damage = 0

	if attack_template.attack_type then
		local attack_damage_value = (attack_template_damage_type_name and AttackDamageValues[attack_template_damage_type_name]) or nil
		local attack = Attacks[attack_template.attack_type]
		predicted_damage = attack.get_damage_amount(self.item_name, attack_template, owner_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, backstab_multiplier)
	end

	no_damage = predicted_damage <= 0

	if no_damage then
		self.did_damage = false

		self.mark_for_deletion(self)

		self.stop_impacts = true
	else
		self.did_damage = predicted_damage

		if hit_zone_name == "head" or hit_zone_name == "neck" then
			self.did_damage = predicted_damage - 1
		end
	end

	if breed.armor_category == 2 or breed.armor_category == 3 then
		self.hit_targets = self.num_targets
	end

	if hit_effect then
		EffectHelper.play_skinned_surface_material_effects(hit_effect, self.world, hit_position, hit_rotation, hit_normal, is_husk, enemy_type, damage_sound, no_damage, hit_zone_name)
	end

	if hit_zone_name == "head" then
		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
		local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.COOP_STAMINA)

		if (procced or script_data.debug_legendary_traits) and AiUtils.unit_alive(hit_unit) then
			local headshot_coop_stamina_fatigue_type = breed.headshot_coop_stamina_fatigue_type or "headshot_clan_rat"
			local fatigue_type_id = NetworkLookup.fatigue_types[headshot_coop_stamina_fatigue_type]

			if self.is_server then
				network_manager.network_transmit:send_rpc_clients("rpc_replenish_fatigue_other_players", fatigue_type_id)
			else
				network_manager.network_transmit:send_rpc_server("rpc_replenish_fatigue_other_players", fatigue_type_id)
			end

			StatusUtils.replenish_stamina_local_players(owner_unit, headshot_coop_stamina_fatigue_type)

			local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

			first_person_extension.play_hud_sound_event(first_person_extension, "hud_player_buff_headshot")
		end
	end

	return 
end
PlayerProjectileUnitExtension.hit_player = function (self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
	local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
	local hit = false
	local owner_player = self.owner_player
	local damage_data = impact_data.damage

	if damage_data and DamageUtils.allow_friendly_fire_ranged(difficulty_settings, owner_player) then
		self.hit_player_damage(self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)

		hit = true
	end

	if hit then
		local aoe_data = impact_data.aoe

		if aoe_data and self.hit_targets == self.num_targets then
			self.do_aoe(self, aoe_data, hit_position)
			self.mark_for_deletion(self)

			self.stop_impacts = true
		end

		if self.hit_targets == self.num_targets then
			self.mark_for_deletion(self)

			self.stop_impacts = true
		end
	end

	self._check_projectile_spawn(self, self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)

	return 
end
ProjectileSpawners = {
	flame_wave = function (self, projectile_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
		local owner_unit = self.owner_unit
		local scale = projectile_data.scale
		local item_name = self.item_name
		local action_lookup_data = self.action_lookup_data
		local item_template_name = action_lookup_data.item_template_name
		local action_name = action_lookup_data.action_name
		local sub_action_name = projectile_data.sub_action_name
		local position = hit_position
		local flat_direction = Vector3.normalize(Vector3.flat(hit_direction))
		local flat_angle = -math.atan2(flat_direction.x, flat_direction.y)
		local lateral_speed = 0
		local initial_forward_speed = projectile_data.initial_forward_speed

		Managers.state.entity:system("projectile_system"):spawn_flame_wave_projectile(owner_unit, scale, item_name, item_template_name, action_name, sub_action_name, position, flat_angle, lateral_speed, initial_forward_speed, 0)

		return 
	end,
	split_bounce = function (self, projectile_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
		local owner_unit = self.owner_unit
		local scale = projectile_data.scale
		local item_name = self.item_name
		local action_lookup_data = self.action_lookup_data
		local item_template_name = action_lookup_data.item_template_name
		local action_name = action_lookup_data.action_name
		local sub_action_name = projectile_data.sub_action_name
		local bounce_dir = hit_direction - Vector3.dot(hit_direction, hit_normal)*2*hit_normal
		local spread = Math.random()*math.pi*2
		local angle = math.pi/16

		for i = 1, 2, 1 do
			local spread_angle = (i*2 - 3)*spread
			local pitch = Quaternion(Vector3.right(), spread_angle)
			local roll = Quaternion(Vector3.forward(), spread)
			local spread_rot = Quaternion.multiply(roll, pitch)
			local new_dir = Quaternion.rotate(spread_rot, bounce_dir)
			local rotation = Quaternion.look(new_dir, Vector3.up())
			local scale = self.scale
			local angle = math.asin(new_dir.z)
			local target_vector = new_dir
			local speed = ScriptUnit.extension(self.unit, "projectile_locomotion_system").speed*0.5
			local position = hit_position + new_dir*0.5

			Managers.state.entity:system("projectile_system"):spawn_player_projectile(owner_unit, position, rotation, scale, angle, target_vector, speed, item_name, item_template_name, action_name, sub_action_name)
		end

		return 
	end
}
PlayerProjectileUnitExtension._check_projectile_spawn = function (self, impact_data, ...)
	local projectile_data = impact_data.projectile_spawn

	if projectile_data then
		local spawner_function = ProjectileSpawners[projectile_data.spawner_function]

		spawner_function(self, projectile_data, ...)
	end

	return 
end
PlayerProjectileUnitExtension.hit_player_damage = function (self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
	local network_manager = Managers.state.network
	local owner_unit = self.owner_unit
	local attacker_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
	local hit_unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
	local hit_targets = self.hit_targets + 1
	self.hit_targets = hit_targets
	local enemy_impact_data = damage_data.enemy_unit_hit
	local target_settings = (enemy_impact_data.targets and enemy_impact_data.targets[hit_targets]) or enemy_impact_data.default_target
	local attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(target_settings, false)
	local attack_template = AttackTemplates[attack_template_name]
	local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
	local attack_template_damage_type_id = NetworkLookup.attack_damage_values[attack_template_damage_type_name or "n/a"]
	local hit_zone_name = "torso"
	local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
	local hit_ragdoll_actor = NetworkLookup.hit_ragdoll_actors["n/a"]
	local backstab_multiplier = 1

	self.weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, hit_direction, attack_template_damage_type_id, hit_ragdoll_actor, backstab_multiplier)

	local action = self.action
	local hit_effect = action.hit_effect
	local owner = self.owner_player
	local is_husk = not owner.local_player
	local damage_sound = attack_template.sound_type
	local hit_rotation = Quaternion.look(hit_direction, Vector3.up())
	local predicted_damage = 0

	if attack_template.attack_type then
		local attack_damage_value = (attack_template_damage_type_name and AttackDamageValues[attack_template_damage_type_name]) or nil
		local attack = Attacks[attack_template.attack_type]
		predicted_damage = attack.get_damage_amount(self.item_name, attack_template, owner_unit, hit_unit, hit_zone_name, hit_direction, attack_damage_value, nil, backstab_multiplier)
	end

	no_damage = predicted_damage <= 0

	if no_damage then
		self.did_damage = false

		self.mark_for_deletion(self)

		self.stop_impacts = true
	else
		self.did_damage = predicted_damage
	end

	if hit_effect then
		EffectHelper.play_skinned_surface_material_effects(hit_effect, self.world, hit_position, hit_rotation, hit_normal, is_husk)
	end

	return 
end
PlayerProjectileUnitExtension.hit_level_unit = function (self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, level_index)
	local has_damage_extension = ScriptUnit.has_extension(hit_unit, "damage_system")
	local damage_data = impact_data.damage

	if (GameSettingsDevelopment.allow_ranged_attacks_to_damage_props or Unit.get_data(hit_unit, "allow_ranged_damage")) and damage_data then
		if has_damage_extension then
			self.hit_damagable_prop(self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, level_index)
		else
			local unit_set_flow_variable = Unit.set_flow_variable

			unit_set_flow_variable(hit_unit, "hit_actor", hit_actor)
			unit_set_flow_variable(hit_unit, "hit_direction", hit_direction)
			unit_set_flow_variable(hit_unit, "hit_position", hit_position)
			Unit.flow_event(hit_unit, "lua_simple_damage")
		end
	end

	if script_data.debug_arrow_impacts then
		QuickDrawerStay:cylinder(hit_position + hit_direction*0.3, hit_position - hit_direction*0.3, 0.02, Color(0, 0, 255))
	end

	local action = self.action
	local hit_effect = action.hit_effect

	if hit_effect then
		local world = self.world
		local hit_rotation = Quaternion.look(hit_direction)
		local owner_unit = self.owner_unit
		local owner = self.owner_player
		local is_husk = not owner.local_player

		EffectHelper.play_surface_material_effects(hit_effect, world, hit_unit, hit_position, hit_rotation, hit_normal, nil, is_husk)
	end

	local aoe_data = impact_data.aoe

	if aoe_data then
		self.do_aoe(self, aoe_data, hit_position)
	end

	if impact_data.link then
		self.link_projectile(self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
	end

	self.mark_for_deletion(self)

	self.stop_impacts = true

	self._check_projectile_spawn(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)

	return 
end
PlayerProjectileUnitExtension.hit_damagable_prop = function (self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, level_index)
	local network_manager = Managers.state.network
	local level_impact_data = damage_data.damagable_prop_hit
	local attack_template_name = level_impact_data.attack_template
	local attack_template_damage_type_name = level_impact_data.attack_template_damage_type
	local damage_source = self.item_name

	DamageUtils.damage_level_unit(hit_unit, hit_normal, level_index, attack_template_name, attack_template_damage_type_name, damage_source, self.owner_unit, hit_direction, self.is_server)

	return 
end
PlayerProjectileUnitExtension.hit_non_level_unit = function (self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
	local stop_impacts = false
	local damage_data = impact_data.damage

	if damage_data and ScriptUnit.has_extension(hit_unit, "damage_system") then
		self.hit_non_level_damagable_unit(self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)

		stop_impacts = true
	end

	local aoe_data = impact_data.aoe

	if aoe_data then
		self.do_aoe(self, aoe_data, hit_position)

		stop_impacts = true
	end

	if impact_data.link then
		self.link_projectile(self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)

		stop_impacts = true
	end

	if stop_impacts then
		self.mark_for_deletion(self)

		self.stop_impacts = true
	end

	self._check_projectile_spawn(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)

	return 
end
PlayerProjectileUnitExtension.hit_non_level_damagable_unit = function (self, damage_data, hit_unit, hit_position, hit_direction, hit_normal, hit_actor)
	local network_manager = Managers.state.network
	local level_impact_data = damage_data.damagable_prop_hit
	local hit_zone_name = "full"
	local attack_template_name = level_impact_data.attack_template
	local attack_template = AttackTemplates[attack_template_name]
	local attack_damage_value_type = level_impact_data.attack_template_damage_type
	local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
	local attack_template_damage_type_id = NetworkLookup.attack_damage_values[attack_damage_value_type or "n/a"]
	local attacker_unit_id = network_manager.unit_game_object_id(network_manager, self.owner_unit)
	local hit_unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
	local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
	local backstab_multiplier = 1

	self.weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, hit_normal, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)

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
PlayerProjectileUnitExtension.link_projectile = function (self, hit_unit, hit_position, hit_direction, hit_normal, hit_actor, damage)
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
	local node_index = Actor.node(hit_actor)

	if ScriptUnit.has_extension(hit_unit, "projectile_linker_system") then
		local projectile_dummy = unit_spawner.spawn_local_unit(unit_spawner, dummy_linker_unit_name, link_position, new_link_rotation)
		local hit_node_rot = Unit.world_rotation(hit_unit, node_index)
		local hit_node_pos = Unit.world_position(hit_unit, node_index)
		local rel_pos = link_position - hit_node_pos
		local offset_position = Vector3(Vector3.dot(Quaternion.right(hit_node_rot), rel_pos), Vector3.dot(Quaternion.forward(hit_node_rot), rel_pos), Vector3.dot(Quaternion.up(hit_node_rot), rel_pos))
		local linker_extension = ScriptUnit.extension(hit_unit, "projectile_linker_system")

		linker_extension.link_projectile(linker_extension, projectile_dummy, offset_position, new_link_rotation, node_index)
		projectile_linker_system.add_linked_projectile_reference(projectile_linker_system, owner_unit, projectile_dummy)
	else
		local projectile_dummy = unit_spawner.spawn_local_unit(unit_spawner, dummy_linker_unit_name, link_position, new_link_rotation)

		projectile_linker_system.add_linked_projectile_reference(projectile_linker_system, owner_unit, projectile_dummy)
	end

	return 
end
PlayerProjectileUnitExtension.do_aoe = function (self, aoe_data, position)
	local world = self.world
	local owner_unit = self.owner_unit

	if aoe_data.explosion then
		local is_husk = false

		DamageUtils.create_explosion(world, owner_unit, position, Unit.local_rotation(self.unit, 0), aoe_data.explosion, self.scale, self.item_name, self.is_server, is_husk, self.unit)
	end

	if aoe_data.aoe and self.is_server then
		DamageUtils.create_aoe(world, owner_unit, position, self.item_name, aoe_data)
	end

	return 
end
PlayerProjectileUnitExtension.add_kill = function (self)
	self._kills = self._kills + 1

	return 
end

return 
