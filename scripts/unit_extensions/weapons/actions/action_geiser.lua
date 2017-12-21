ActionGeiser = class(ActionGeiser)
ActionGeiser.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.world = world
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.item_name = item_name
	self.first_person_unit = first_person_unit
	self.wwise_world = Managers.world:wwise_world(world)

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	self.network_transmit = Managers.state.network.network_transmit

	return 
end
ActionGeiser.client_owner_start_action = function (self, new_action, t, chain_action_data)
	self.current_action = new_action
	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + (new_action.fire_time or 0)
	self.radius = chain_action_data.radius
	self.height = chain_action_data.height
	self.charge_value = chain_action_data.charge_value
	self.position = chain_action_data.position
	self.targeting_effect_id = chain_action_data.targeting_effect_id

	return 
end
ActionGeiser.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		self.fire(self)

		self.state = "shot"
	end

	return 
end
ActionGeiser.finish = function (self, reason)
	if self.targeting_effect_id then
		World.destroy_particles(self.world, self.targeting_effect_id)
	end

	return 
end
ActionGeiser.fire = function (self, reason)
	local current_action = self.current_action
	local world = self.world
	local is_server = self.is_server
	local owner_unit = self.owner_unit
	local radius = self.radius
	local half_height = self.height*0.5
	local position = self.position:unbox()
	local physics_world = World.get_data(self.world, "physics_world")
	local start_pos = position + Vector3(0, 0, half_height)
	local source_pos = position
	local hit_actors, num_actors = PhysicsWorld.immediate_overlap(physics_world, "shape", "capsule", "position", start_pos, "size", Vector3(radius, half_height + radius, radius), "rotation", Quaternion.look(Vector3.up(), Vector3.up()), "collision_filter", "filter_enemy_unit", "use_global_table")
	local charge_value = self.charge_value
	local effect_name = current_action.particle_effect
	local size = "_large"

	if charge_value < 0.33 then
		size = "_small"
	elseif charge_value < 0.66 then
		size = "_medium"
	end

	effect_name = effect_name .. size
	local variable_name = current_action.particle_radius_variable
	local effect_id = NetworkLookup.effects[effect_name]
	local variable_id = NetworkLookup.effects[variable_name]
	local radius_variable = Vector3(radius, 1, 1)

	self.network_transmit:send_rpc_server("rpc_play_simple_particle_with_vector_variable", effect_id, position, variable_id, radius_variable)

	if self.overcharge_extension then
		self.overcharge_extension:add_charge(current_action.overcharge_type, charge_value)
	end

	local fire_sound_event = self.current_action.fire_sound_event

	if fire_sound_event then
		local play_on_husk = self.current_action.fire_sound_on_husk
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

		first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event, nil, play_on_husk)
	end

	if 0 < num_actors then
		for i = 1, num_actors, 1 do
			local hit_actor = hit_actors[i]
			local hit_unit = Actor.unit(hit_actor)
			local hit_position = POSITION_LOOKUP[hit_unit]
			local breed = Unit.get_data(hit_unit, "breed")

			if breed then
				DamageUtils.buff_on_attack(owner_unit, hit_unit, "aoe")

				local network_manager = Managers.state.network
				local attacker_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
				local hit_unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
				local hit_zone_id = NetworkLookup.hit_zones.torso
				local attack_vector = hit_position - source_pos
				local attack_distance = Vector3.length(attack_vector)
				local attack_direction = Vector3.normalize(attack_vector)
				local attack_template = AttackTemplates[current_action.attack_template]

				if current_action.attack_template_list then
					local proximity_factor = attack_distance/radius
					local pick_this_one = 3

					if 0.75 < proximity_factor then
						pick_this_one = 1
					elseif 0.25 < proximity_factor then
						pick_this_one = 2
					end

					attack_template = AttackTemplates[current_action.attack_template_list[pick_this_one]]
				end

				local attack_template_id = attack_template.lookup_id
				local attack_template_damage_type_name = current_action.attack_template_damage_type
				local attack_template_damage_type_id = 0

				if attack_template_damage_type_name then
					local attack_template_damage_type = AttackDamageValues[attack_template_damage_type_name]
					attack_template_damage_type_id = attack_template_damage_type.lookup_id
				end

				local backstab_multiplier = 1

				if is_server or LEVEL_EDITOR_TEST then
					local weapon_system = Managers.state.entity:system("weapon_system")

					weapon_system.rpc_attack_hit(weapon_system, nil, NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
				else
					network_manager.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
				end
			end
		end
	end

	if current_action.alert_enemies then
		Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, source_pos, current_action.alert_sound_range_fire)
	end

	return 
end

return 