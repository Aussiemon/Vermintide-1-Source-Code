ActionAoEDamage = class(ActionAoEDamage)
ActionAoEDamage.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.world = world
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.weapon_system = weapon_system
	self.is_server = is_server
	self.item_name = item_name

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	self._overlap_callback = callback(self, "overlap_callback")

	return 
end
ActionAoEDamage.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action

	return 
end
ActionAoEDamage.client_owner_post_update = function (self, dt, t, world, can_damage)
	return 
end
ActionAoEDamage.finish = function (self, reason)
	local current_action = self.current_action

	if reason ~= "action_complete" then
		return 
	end

	local owner_unit = self.owner_unit
	local position = Unit.local_position(owner_unit, 0)
	local network_manager = Managers.state.network
	local effect_name = current_action.effect_name
	local effect_name_id = NetworkLookup.effects[effect_name]
	local owner_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
	local node_id = 0
	local effect_offset = Vector3(0, 0, 0)
	local rotation_offset = Quaternion.identity()

	if self.is_server then
		network_manager.rpc_play_particle_effect(network_manager, nil, effect_name_id, owner_unit_id, node_id, effect_offset, rotation_offset, false)
	else
		network_manager.network_transmit:send_rpc_server("rpc_play_particle_effect", effect_name_id, owner_unit_id, node_id, effect_offset, rotation_offset, false)
	end

	local physics_world = World.get_data(self.world, "physics_world")

	PhysicsWorld.overlap(physics_world, self._overlap_callback, "position", position, "size", current_action.size, "types", "dynamics", "collision_filter", "filter_enemy_unit")

	if self.ammo_extension then
		self.ammo_extension:use_ammo(current_action.ammo_usage)
	end

	return 
end
ActionAoEDamage.overlap_callback = function (self, actors)
	local current_action = self.current_action
	local network_manager = Managers.state.network
	local owner_unit = self.owner_unit
	local attacker_position = Unit.local_position(owner_unit, 0)
	local attacker_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
	local attack_template_name = current_action.attack_template
	local attack_template = AttackTemplates[attack_template_name]
	local attack_template_id = attack_template.lookup_id
	local hit_zone_id = NetworkLookup.hit_zones.full
	local damage_source_id = NetworkLookup.damage_sources[self.item_name]
	local units = {}
	local num_actors = #actors

	for i = 1, num_actors, 1 do
		local actor = actors[i]
		local unit = Actor.unit(actor)

		if unit and Unit.alive(unit) then
			local unit_go_id = network_manager.unit_game_object_id(network_manager, unit)
			units[#units + 1] = unit_go_id
		end
	end

	local num_units = #units

	if 0 < num_units then
		if self.is_server or LEVEL_EDITOR_TEST then
			self.weapon_system:rpc_attack_hit_multiple(nil, damage_source_id, attacker_unit_id, units, attack_template_id, hit_zone_id)
		else
			network_manager.network_transmit:send_rpc_server("rpc_attack_hit_multiple", damage_source_id, attacker_unit_id, units, attack_template_id, hit_zone_id)
		end
	end

	return 
end

return 
