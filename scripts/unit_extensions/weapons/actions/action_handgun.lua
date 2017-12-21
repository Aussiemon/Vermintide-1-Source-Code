ActionHandgun = class(ActionHandgun)
ActionHandgun.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.weapon_system = weapon_system
	self.owner_unit = owner_unit
	self.first_person_unit = first_person_unit
	self.weapon_unit = weapon_unit
	self.world = world
	self.item_name = item_name
	self.wwise_world = Managers.world:wwise_world(world)
	self.trail_end_position_variable = World.find_particles_variable(world, "fx/wpnfx_pistol_bullet_trail", "size")

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	self.spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	self.is_server = is_server

	return 
end
ActionHandgun.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action

	if self.ammo_extension then
		local ammo_usage = new_action.ammo_usage

		self.ammo_extension:use_ammo(ammo_usage)
	end

	if self.overcharge_extension then
		self.overcharge_extension:add_charge(new_action.overcharge_type)
	end

	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + new_action.fire_time
	self.extra_buff_shot = false

	return 
end
ActionHandgun.client_owner_post_update = function (self, dt, t, world, can_damage)
	local owner_unit = self.owner_unit
	local current_action = self.current_action

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		local world = self.world
		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
		local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.EXTRA_SHOT)
		local add_spread = true

		if not self.extra_buff_shot and procced then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.1
			self.extra_buff_shot = true
			add_spread = false
		else
			self.state = "shot"
		end

		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local position = first_person_extension.current_position(first_person_extension)
		local rotation = first_person_extension.current_rotation(first_person_extension)
		local spread_extension = self.spread_extension

		if spread_extension then
			rotation = spread_extension.get_randomised_spread(spread_extension, rotation)

			if add_spread then
				spread_extension.set_shooting(spread_extension)
			end
		end

		local physics_world = World.get_data(world, "physics_world")
		local direction = Quaternion.forward(rotation)

		PhysicsWorld.prepare_actors_for_raycast(physics_world, position, direction, 0.001, 9)

		local collision_filter = "filter_player_ray_projectile"
		local result = PhysicsWorld.immediate_raycast(physics_world, position, direction, "all", "collision_filter", collision_filter)
		local is_server = self.is_server

		if result then
			DamageUtils.process_projectile_hit(world, self.item_name, owner_unit, is_server, result, current_action, direction, true)
		end

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event)
		end

		if current_action.alert_sound_range_fire then
			Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, POSITION_LOOKUP[owner_unit], current_action.alert_sound_range_fire)
		end
	end

	return 
end
ActionHandgun.finish = function (self, reason)
	local ammo_extension = self.ammo_extension
	local current_action = self.current_action

	if reason ~= "new_interupting_action" then
		if ammo_extension and current_action.reload_when_out_of_ammo and ammo_extension.ammo_count(ammo_extension) == 0 and ammo_extension.can_reload(ammo_extension) then
			local play_reload_animation = true

			ammo_extension.start_reload(ammo_extension, play_reload_animation)
		end

		local status_extension = ScriptUnit.extension(self.owner_unit, "status_system")

		status_extension.set_zooming(status_extension, false)
	end

	return 
end

return 
