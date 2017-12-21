ActionPushStagger = class(ActionPushStagger)
local PUSH_UPGRADES = {
	basic_sweep_push = "heavy_sweep_push",
	dagger_sweep_push = "heavy_sweep_push",
	heavy_sweep_push = "super_heavy_sweep_push",
	weak_sweep_push = "heavy_sweep_push"
}
ActionPushStagger.init = function (self, world, item_name, is_server, owner_unit, weapon_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.weapon_system = weapon_system
	self.item_name = item_name
	self._status_extension = ScriptUnit.extension(owner_unit, "status_system")
	self.hit_units = {}
	self.waiting_for_callback = false

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	return 
end
ActionPushStagger.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action

	for k, v in pairs(self.hit_units) do
		self.hit_units[k] = nil
	end

	local status_extension = self._status_extension
	self.owner_buff_extension = ScriptUnit.extension(self.owner_unit, "buff_system")
	local _, procced = self.owner_buff_extension:apply_buffs_to_value(0, StatBuffIndex.NO_PUSH_FATIGUE_COST)

	if not procced then
		local cost = "action_push"

		if new_action.fatigue_cost then
			cost = new_action.fatigue_cost
		end

		status_extension.add_fatigue_points(status_extension, cost)
	end

	self.block_end_time = t + 0.5

	status_extension.set_blocking(status_extension, true)

	return 
end
local callback_context = {
	has_gotten_callback = false,
	overlap_units = {}
}

local function callback(actors)
	callback_context.has_gotten_callback = true
	local overlap_units = callback_context.overlap_units

	for k, actor in pairs(actors) do
		callback_context.num_hits = callback_context.num_hits + 1

		if overlap_units[callback_context.num_hits] == nil then
			overlap_units[callback_context.num_hits] = ActorBox()
		end

		overlap_units[callback_context.num_hits]:store(actor)
	end

	return 
end

ActionPushStagger.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action
	local owner_unit = self.owner_unit

	if self.block_end_time and self.block_end_time < t then
		local status_extension = self._status_extension

		status_extension.set_blocking(status_extension, false)
		status_extension.set_has_blocked(status_extension, false)
	end

	if not callback_context.has_gotten_callback and can_damage then
		self.waiting_for_callback = true
		callback_context.num_hits = 0
		local physics_world = World.get_data(world, "physics_world")
		local pos = POSITION_LOOKUP[owner_unit]
		local radius = current_action.push_radius
		local collision_filter = "filter_melee_sweep"

		PhysicsWorld.overlap(physics_world, callback, "shape", "sphere", "position", pos, "size", radius, "types", "dynamics", "collision_filter", collision_filter)
	elseif self.waiting_for_callback and callback_context.has_gotten_callback then
		self.waiting_for_callback = false
		callback_context.has_gotten_callback = false
		local network_manager = Managers.state.network
		local attacker_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
		local _, increase_damage_procc = self.owner_buff_extension:apply_buffs_to_value(0, StatBuffIndex.INCREASE_DAMAGE_TO_ENEMY_PUSH)
		local buff_system = Managers.state.entity:system("buff_system")
		local overlap_units = callback_context.overlap_units
		local hit_units = self.hit_units
		local unit_get_data = Unit.get_data
		local num_hits = callback_context.num_hits
		local hit_once = false

		for i = 1, num_hits, 1 do
			local hit_actor = overlap_units[i]:unbox()

			if hit_actor == nil then
			else
				local hit_unit = Actor.unit(hit_actor)
				local breed = unit_get_data(hit_unit, "breed")

				if breed and hit_units[hit_unit] == nil then
					hit_units[hit_unit] = true
					local node = Actor.node(hit_actor)
					local hit_zone = breed.hit_zones_lookup[node]
					local hit_zone_name = hit_zone.name
					local attack_direction = Vector3.normalize(POSITION_LOOKUP[hit_unit] - POSITION_LOOKUP[owner_unit])
					local hit_unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
					local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
					local attack_template_name = current_action.attack_template

					if self.owner_buff_extension:has_buff_type("push_increase") and not PUSH_UPGRADES[attack_template_name] then
					end

					local attack_template = AttackTemplates[attack_template_name]
					local attack_template_id = attack_template.lookup_id
					local attack_template_damage_type_id = 0
					local hit_position = Unit.world_position(hit_unit, node)
					local hit_effect = current_action.impact_particle_effect or "fx/impact_block_push"

					if hit_effect then
						EffectHelper.player_melee_hit_particles(world, hit_effect, hit_position, attack_direction, nil, hit_unit)
					end

					local sound_event = current_action.stagger_impact_sound_event or "blunt_hit"

					if sound_event then
						local sound_type = attack_template.sound_type or "stun_heavy"
						local husk = Managers.player:owner(owner_unit).bot_player
						local breed_name = breed.name

						EffectHelper.play_melee_hit_effects(sound_event, world, hit_position, sound_type, husk, breed_name)

						local sound_event_id = NetworkLookup.sound_events[sound_event]
						local sound_type_id = NetworkLookup.melee_impact_sound_types[sound_type]
						local breed_name_id = NetworkLookup.breeds[breed_name]

						if self.is_server then
							network_manager.network_transmit:send_rpc_clients("rpc_play_melee_hit_effects", sound_event_id, hit_position, sound_type_id, breed_name_id)
						else
							network_manager.network_transmit:send_rpc_server("rpc_play_melee_hit_effects", sound_event_id, hit_position, sound_type_id, breed_name_id)
						end
					else
						Application.warning("[ActionSweep] Missing sound event for push action in unit %q.", self.weapon_unit)
					end

					local backstab_multiplier = 1

					if self.is_server or LEVEL_EDITOR_TEST then
						self.weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
					else
						network_manager.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
					end

					if increase_damage_procc or script_data.debug_legendary_traits then
						buff_system.add_buff(buff_system, hit_unit, "increase_incoming_damage", owner_unit)
					end

					Managers.state.entity:system("play_go_tutorial_system"):register_push(hit_unit)

					hit_once = true
				end
			end
		end
	end

	return 
end
ActionPushStagger.finish = function (self, reason)
	self.waiting_for_callback = false
	callback_context.has_gotten_callback = false
	local ammo_extension = self.ammo_extension
	local current_action = self.current_action

	if reason ~= "new_interupting_action" and ammo_extension and current_action.reload_when_out_of_ammo and ammo_extension.ammo_count(ammo_extension) == 0 and ammo_extension.can_reload(ammo_extension) then
		local play_reload_animation = true

		ammo_extension.start_reload(ammo_extension, play_reload_animation)
	end

	local status_extension = self._status_extension

	status_extension.set_blocking(status_extension, false)
	status_extension.set_has_blocked(status_extension, false)

	return 
end

return 
