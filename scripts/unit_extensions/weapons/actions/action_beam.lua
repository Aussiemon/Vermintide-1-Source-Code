ActionBeam = class(ActionBeam)

ActionBeam.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.weapon_system = weapon_system
	self.owner_unit = owner_unit
	self.first_person_unit = first_person_unit
	self.weapon_unit = weapon_unit
	self.world = world
	self.item_name = item_name
	self.wwise_world = Managers.world:wwise_world(world)
	self._rumble_effect_id = false
	self.owner_player = Managers.player:owner(owner_unit)
	self.inventory_extension = ScriptUnit.extension(owner_unit, "inventory_system")

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	self.is_server = is_server
	self.network_transmit = Managers.state.network.network_transmit
	self.unit_id = Managers.state.network.unit_storage:go_id(owner_unit)
end

ActionBeam.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	local current_action = self.current_action
	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + new_action.fire_time
	self.current_target = nil
	self.damage_timer = 0
	self.overcharge_timer = 0
	self.ramping_interval = 1
	local world = self.world
	local beam_effect = new_action.particle_effect_trail
	local beam_effect_3p = new_action.particle_effect_trail_3p
	local beam_end_effect = new_action.particle_effect_target
	local beam_effect_id = NetworkLookup.effects[beam_effect_3p]
	local beam_end_effect_id = NetworkLookup.effects[beam_end_effect]
	self.beam_effect = World.create_particles(world, beam_effect, Vector3.zero())
	self.beam_end_effect = World.create_particles(world, beam_end_effect, Vector3.zero())
	self.beam_effect_length_id = World.find_particles_variable(world, beam_effect, "trail_length")
	local go_id = self.unit_id

	if self.is_server or LEVEL_EDITOR_TEST then
		self.network_transmit:send_rpc_clients("rpc_start_beam", go_id, beam_effect_id, beam_end_effect_id, new_action.range)
	else
		self.network_transmit:send_rpc_server("rpc_start_beam", go_id, beam_effect_id, beam_end_effect_id, new_action.range)
	end

	local status_extension = ScriptUnit.extension(self.owner_unit, "status_system")

	if not status_extension:is_zooming() then
		status_extension:set_zooming(true)
	end

	local overcharge_extension = self.overcharge_extension

	if self.overcharge_extension then
		self.overcharge_extension:add_charge(current_action.overcharge_type)
	end

	self.overcharge_target_hit = false
	local charge_sound_name = new_action.charge_sound_name

	if charge_sound_name then
		local wwise_playing_id, wwise_source_id = ActionUtils.start_charge_sound(self.wwise_world, self.weapon_unit, new_action)
		self.charging_sound_id = wwise_playing_id
		self.wwise_source_id = wwise_source_id
	end

	local charge_sound_husk_name = current_action.charge_sound_husk_name

	if charge_sound_husk_name then
		ActionUtils.play_husk_sound_event(charge_sound_husk_name, self.owner_unit)
	end
end

local INDEX_POSITION = 1
local INDEX_DISTANCE = 2
local INDEX_NORMAL = 3
local INDEX_ACTOR = 4

ActionBeam.client_owner_post_update = function (self, dt, t, world, can_damage)
	local owner_unit = self.owner_unit
	local current_action = self.current_action
	local is_server = self.is_server
	local input_extension = ScriptUnit.extension(self.owner_unit, "input_system")
	local buff_extension = ScriptUnit.extension(self.owner_unit, "buff_system")
	local status_extension = ScriptUnit.extension(self.owner_unit, "status_system")

	if buff_extension:has_buff_type("increased_zoom") and status_extension:is_zooming() and input_extension:get("action_three") then
		status_extension:switch_variable_zoom(current_action.buffed_zoom_thresholds)
	elseif current_action.zoom_thresholds and status_extension:is_zooming() and input_extension:get("action_three") then
		status_extension:switch_variable_zoom(current_action.zoom_thresholds)
	end

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	self.overcharge_timer = self.overcharge_timer + dt

	if current_action.overcharge_interval <= self.overcharge_timer then
		if self.overcharge_extension then
			local overcharge_amount = "charging"

			self.overcharge_extension:add_charge(overcharge_amount)
		end

		self.overcharge_timer = 0
		self.overcharge_target_hit = false
	end

	if self.state == "shooting" then
		if not Managers.player:owner(self.owner_unit).bot_player and not self._rumble_effect_id then
			self._rumble_effect_id = Managers.state.controller_features:add_effect("persistent_rumble", {
				rumble_effect = "reload_start"
			})
		end

		local world = self.world
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local current_position = first_person_extension:current_position()
		local current_rotation = first_person_extension:current_rotation()
		local direction = Quaternion.forward(current_rotation)
		local physics_world = World.get_data(world, "physics_world")
		local range = current_action.range or 30
		local collision_filter = "filter_player_ray_projectile"
		local result = PhysicsWorld.immediate_raycast_actors(physics_world, current_position, direction, range, "static_collision_filter", "filter_player_ray_projectile_static_only", "dynamic_collision_filter", "filter_player_ray_projectile_ai_only", "dynamic_collision_filter", "filter_player_ray_projectile_hitbox_only")
		local beam_end_position = current_position + direction * range
		local hit_unit, hit_position = nil

		if result then
			local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
			local owner_player = self.owner_player
			local friendly_fire = DamageUtils.allow_friendly_fire_ranged(difficulty_settings, owner_player)

			for index, hit in pairs(result) do
				local potential_hit_position = hit[INDEX_POSITION]
				local hit_actor = hit[INDEX_ACTOR]
				local potential_hit_unit = Actor.unit(hit_actor)

				if potential_hit_unit ~= owner_unit then
					local breed = Unit.get_data(potential_hit_unit, "breed")
					local is_player = DamageUtils.is_player_unit(potential_hit_unit)
					local hit = false

					if breed then
						local node = Actor.node(hit_actor)
						local hit_zone = breed.hit_zones_lookup[node]
						local hit_zone_name = hit_zone.name
						hit = hit_zone_name ~= "afro"
					elseif is_player then
						hit = friendly_fire and hit_actor ~= Unit.actor(potential_hit_unit, "c_afro")
					else
						hit = true
					end

					if hit then
						hit_position = potential_hit_position - direction * 0.15
						hit_unit = potential_hit_unit

						break
					end
				end
			end

			if hit_position then
				beam_end_position = hit_position
			end

			if hit_unit then
				if hit_unit ~= self.current_target then
					self.ramping_interval = 1.5
				end

				if self.damage_timer >= current_action.damage_interval * self.ramping_interval and ScriptUnit.has_extension(hit_unit, "damage_system") then
					Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, POSITION_LOOKUP[owner_unit], 5)

					self.damage_timer = 0
					self.ramping_interval = math.clamp(self.ramping_interval * 0.8, 0.45, 1.5)
				end

				if self.damage_timer == 0 and ScriptUnit.has_extension(hit_unit, "damage_system") then
					first_person_extension:play_hud_sound_event("staff_beam_hit_enemy", nil, false)
					DamageUtils.process_projectile_hit(world, self.item_name, owner_unit, is_server, result, current_action, direction, true)

					if not Managers.player:owner(self.owner_unit).bot_player then
						Managers.state.controller_features:add_effect("rumble", {
							rumble_effect = "hit_character_light"
						})
					end

					local health_extension = ScriptUnit.has_extension(hit_unit, "health_system")

					if health_extension:is_alive() then
						local overcharge_amount = current_action.overcharge_type

						self.overcharge_extension:add_charge(overcharge_amount)
					end
				end

				self.damage_timer = self.damage_timer + dt
			end
		end

		local weapon_unit = self.weapon_unit
		local end_of_staff_position = Unit.world_position(weapon_unit, Unit.node(weapon_unit, "fx_01"))
		local distance = Vector3.distance(end_of_staff_position, beam_end_position)
		local direction = Vector3.normalize(end_of_staff_position - beam_end_position)
		local rotation = Quaternion.look(direction)

		World.move_particles(world, self.beam_end_effect, beam_end_position, rotation)
		World.move_particles(world, self.beam_effect, beam_end_position, rotation)
		World.set_particles_variable(world, self.beam_effect, self.beam_effect_length_id, Vector3(0.3, distance, 0))

		self.current_target = hit_unit
	end
end

ActionBeam.finish = function (self, reason)
	local owner_unit = self.owner_unit
	local go_id = self.unit_id
	local current_action = self.current_action
	local status_extension = ScriptUnit.extension(owner_unit, "status_system")
	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

	status_extension:set_zooming(false)
	World.destroy_particles(self.world, self.beam_end_effect)

	self.beam_end_effect = nil
	local charging_sound_id = self.charging_sound_id

	if charging_sound_id then
		ActionUtils.stop_charge_sound(self.wwise_world, charging_sound_id, self.wwise_source_id, current_action)

		self.wwise_source_id = nil
		self.charging_sound_id = nil
	end

	local charge_sound_husk_stop_event = current_action.charge_sound_husk_stop_event

	if charge_sound_husk_stop_event then
		ActionUtils.play_husk_sound_event(charge_sound_husk_stop_event, owner_unit)
	end

	if self._rumble_effect_id then
		Managers.state.controller_features:stop_effect(self._rumble_effect_id)

		self._rumble_effect_id = nil
	end

	World.destroy_particles(self.world, self.beam_effect)

	self.beam_effect = nil

	if self.is_server or LEVEL_EDITOR_TEST then
		self.network_transmit:send_rpc_clients("rpc_end_beam", go_id)
	else
		self.network_transmit:send_rpc_server("rpc_end_beam", go_id)
	end
end

ActionBeam.destroy = function (self)
	if self.beam_end_effect then
		World.destroy_particles(self.world, self.beam_end_effect)

		self.beam_end_effect = nil
	end

	if self.beam_effect then
		World.destroy_particles(self.world, self.beam_effect)

		self.beam_effect = nil
	end

	if self._rumble_effect_id then
		Managers.state.controller_features:stop_effect(self._rumble_effect_id)

		self._rumble_effect_id = nil
	end

	local charging_sound_id = self.charging_sound_id

	if charging_sound_id then
		ActionUtils.stop_charge_sound(self.wwise_world, charging_sound_id, self.wwise_source_id, self.current_action)

		self.wwise_source_id = nil
		self.charging_sound_id = nil
	end
end

return
