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

	self._damage_buffer = {}
	self._damage_buffer_index = 1
	self.network_transmit = Managers.state.network.network_transmit
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

	table.clear(self._damage_buffer)

	self._damage_buffer_index = 1
end

ActionGeiser.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		self:fire()

		self.state = "doing_damage"
	end

	if self.state == "doing_damage" then
		local done = self:_update_damage()

		if done then
			self.state = "shot"
		end
	end
end

ActionGeiser.finish = function (self, reason)
	if self.targeting_effect_id then
		World.destroy_particles(self.world, self.targeting_effect_id)
	end

	self.position = nil
end

ActionGeiser.fire = function (self, reason)
	local current_action = self.current_action
	local world = self.world
	local is_server = self.is_server
	local owner_unit = self.owner_unit
	local weapon_system = Managers.state.entity:system("weapon_system")
	local radius = self.radius
	local half_height = self.height * 0.5
	local position = self.position:unbox()
	local physics_world = World.get_data(self.world, "physics_world")
	local network_manager = Managers.state.network
	local start_pos = position + Vector3(0, 0, half_height)
	local source_pos = position
	local hit_actors, num_actors = PhysicsWorld.immediate_overlap(physics_world, "shape", "capsule", "position", start_pos, "size", Vector3(radius, half_height + radius, radius), "rotation", Quaternion.look(Vector3.up(), Vector3.up()), "collision_filter", "filter_character_trigger", "use_global_table")
	local charge_value = self.charge_value
	local effect_name = current_action.particle_effect
	local size = "_large"
	local overcharge = current_action.overcharge_type
	local ignore_hitting_allies = not Managers.state.difficulty:get_difficulty_settings().friendly_fire_ranged
	local is_inside_inn = Managers.state.game_mode:level_key() == "inn_level"

	if charge_value < 0.33 then
		size = "_small"
	elseif charge_value < 0.66 then
		size = "_medium"
	elseif charge_value >= 1 and not is_inside_inn then
		local owner_unit_id = network_manager:unit_game_object_id(owner_unit)
		local damage_source_id = NetworkLookup.damage_sources[self.item_name]
		local explosion_template_name = current_action.aoe_name
		local explosion_template_id = NetworkLookup.explosion_templates[explosion_template_name]
		overcharge = current_action.overcharge_type_heavy

		self.network_transmit:send_rpc_server("rpc_client_create_aoe", owner_unit_id, source_pos, damage_source_id, explosion_template_id)
	end

	effect_name = effect_name .. size
	local variable_name = current_action.particle_radius_variable
	local effect_id = NetworkLookup.effects[effect_name]
	local variable_id = NetworkLookup.effects[variable_name]
	local radius_variable = Vector3(radius, 1, 1)

	self.network_transmit:send_rpc_server("rpc_play_simple_particle_with_vector_variable", effect_id, position, variable_id, radius_variable)

	if self.overcharge_extension then
		self.overcharge_extension:add_charge(overcharge, charge_value)
	end

	local fire_sound_event = self.current_action.fire_sound_event

	if fire_sound_event then
		local play_on_husk = self.current_action.fire_sound_on_husk
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

		first_person_extension:play_hud_sound_event(fire_sound_event, nil, play_on_husk)
	end

	local damage_buffer = self._damage_buffer
	local hit_units = {}
	local num_hit = 0

	if num_actors > 0 then
		for i = 1, num_actors, 1 do
			local hit_actor = hit_actors[i]
			local hit_unit = Actor.unit(hit_actor)
			local hit_position = POSITION_LOOKUP[hit_unit]
			local breed = Unit.get_data(hit_unit, "breed")

			if not hit_units[hit_unit] and (breed or (table.contains(PLAYER_AND_BOT_UNITS, hit_unit) and not ignore_hitting_allies)) then
				local attack_vector = hit_position - source_pos
				local attack_distance = Vector3.length(attack_vector)
				local attack_template_name = nil

				if current_action.attack_template_list then
					local proximity_factor = attack_distance / radius
					local pick_this_one = 3

					if proximity_factor > 0.75 then
						pick_this_one = 1
					elseif proximity_factor > 0.25 then
						pick_this_one = 2
					end

					attack_template_name = current_action.attack_template_list[pick_this_one]
				else
					attack_template_name = current_action.attack_template
				end

				local attack_template_damage_type_name = current_action.attack_template_damage_type
				local backstab_multiplier = 1
				hit_units[hit_unit] = true
				local damage_data = {
					hit_ragdoll_actor = "n/a",
					hit_zone_name = "torso",
					unit = hit_unit,
					attack_template_name = attack_template_name,
					attack_template_damage_type_name = attack_template_damage_type_name or "n/a",
					backstab_multiplier = backstab_multiplier
				}
				damage_buffer[#damage_buffer + 1] = damage_data
			end
		end
	end

	if current_action.alert_enemies then
		Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, source_pos, current_action.alert_sound_range_fire)
	end
end

local UNITS_PER_FRAME = 1

ActionGeiser._update_damage = function (self)
	local damage_buffer = self._damage_buffer
	local damage_buffer_index = self._damage_buffer_index
	local num_units = (damage_buffer_index + UNITS_PER_FRAME) - 1
	local network_manager = Managers.state.network
	local weapon_system = Managers.state.entity:system("weapon_system")
	local is_server = self.is_server
	local owner_unit = self.owner_unit
	local damage_source_id = NetworkLookup.damage_sources[self.item_name]
	local attacker_unit_id = network_manager:unit_game_object_id(owner_unit)
	local position = self.position:unbox()

	for i = damage_buffer_index, num_units, 1 do
		repeat
			local damage_data = damage_buffer[i]

			if not damage_data then
				return true
			end

			local unit = damage_data.unit

			if not Unit.alive(unit) then
				break
			end

			DamageUtils.buff_on_attack(owner_unit, unit, "aoe")

			local hit_unit_id = network_manager:unit_game_object_id(unit)
			local attack_template_id = NetworkLookup.attack_templates[damage_data.attack_template_name]
			local hit_zone_id = NetworkLookup.hit_zones[damage_data.hit_zone_name]
			local hit_position = POSITION_LOOKUP[unit]
			local attack_vector = hit_position - position
			local attack_direction = Vector3.normalize(attack_vector)
			local attack_template_damage_type_id = NetworkLookup.attack_damage_values[damage_data.attack_template_damage_type_name]
			local hit_ragdoll_actor_id = NetworkLookup.hit_ragdoll_actors[damage_data.hit_ragdoll_actor]
			local backstab_multiplier = damage_data.backstab_multiplier
			local hawkeye_multiplier = 0

			if is_server or LEVEL_EDITOR_TEST then
				weapon_system:rpc_attack_hit(nil, damage_source_id, attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, hit_ragdoll_actor_id, backstab_multiplier, hawkeye_multiplier)
			else
				network_manager.network_transmit:send_rpc_server("rpc_attack_hit", damage_source_id, attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, hit_ragdoll_actor_id, backstab_multiplier, hawkeye_multiplier)
			end
		until true
	end

	self._damage_buffer_index = num_units + 1
end

return
