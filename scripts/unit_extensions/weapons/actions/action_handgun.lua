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

	if not Managers.player:owner(self.owner_unit).bot_player then
		Managers.state.controller_features:add_effect("rumble", {
			rumble_effect = "light_swing"
		})
	end

	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + new_action.fire_time
	self.extra_buff_shot = false
	self.ammo_usage = new_action.ammo_usage
	self.overcharge_type = new_action.overcharge_type
	self.used_ammo = false
	self.active_reload_time = new_action.active_reload_time and t + new_action.active_reload_time

	if new_action.block then
		local status_extension = ScriptUnit.extension(self.owner_unit, "status_system")

		status_extension.set_blocking(status_extension, true)
	end

	return 
end
ActionHandgun.client_owner_post_update = function (self, dt, t, world, can_damage)
	local owner_unit = self.owner_unit
	local current_action = self.current_action

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"

		if self.ammo_extension and not self.extra_buff_shot then
			local ammo_usage = self.ammo_usage

			self.ammo_extension:use_ammo(ammo_usage)
		end

		if self.overcharge_extension then
			self.overcharge_extension:add_charge(self.overcharge_type)
		end
	end

	if self.state == "shooting" then
		local world = self.world
		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
		local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.EXTRA_SHOT)
		local add_spread = not self.extra_buff_shot

		if not self.extra_buff_shot and procced then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.1
			self.extra_buff_shot = true
		else
			self.state = "shot"
		end

		if not Managers.player:owner(self.owner_unit).bot_player then
			Managers.state.controller_features:add_effect("rumble", {
				rumble_effect = "handgun_fire"
			})
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
		local auto_hit_chance = current_action.aim_assist_auto_hit_chance or 0
		local direction = nil

		if math.random() <= auto_hit_chance and Managers.input:is_device_active("gamepad") and ScriptUnit.has_extension(owner_unit, "smart_targeting_system") then
			local targeting_extension = ScriptUnit.extension(owner_unit, "smart_targeting_system")
			local targeting_data = targeting_extension.get_targeting_data(targeting_extension)
			local target_position = targeting_data.target_position

			if target_position then
				direction = Vector3.normalize(target_position - position)
			end
		end

		direction = direction or Quaternion.forward(rotation)
		local result = PhysicsWorld.immediate_raycast_actors(physics_world, position, direction, "static_collision_filter", "filter_player_ray_projectile_static_only", "dynamic_collision_filter", "filter_player_ray_projectile_ai_only", "dynamic_collision_filter", "filter_player_ray_projectile_hitbox_only")
		local is_server = self.is_server

		if result then
			DamageUtils.process_projectile_hit(world, self.item_name, owner_unit, is_server, result, current_action, direction, true)
		end

		if self.current_action.reset_aim_on_attack then
			first_person_extension.reset_aim_assist_multiplier(first_person_extension)
		end

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event)
		end

		if current_action.alert_sound_range_fire then
			Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, POSITION_LOOKUP[owner_unit], current_action.alert_sound_range_fire)
		end
	end

	if self.state == "shot" and self.active_reload_time then
		local input_extension = ScriptUnit.extension(owner_unit, "input_system")

		if self.active_reload_time < t then
			local ammo_extension = self.ammo_extension

			if (input_extension.get(input_extension, "weapon_reload") or input_extension.get_buffer(input_extension, "weapon_reload")) and ammo_extension.can_reload(ammo_extension) then
				local status_extension = ScriptUnit.extension(self.owner_unit, "status_system")

				status_extension.set_zooming(status_extension, false)

				local weapon_extension = ScriptUnit.extension(self.weapon_unit, "weapon_system")

				weapon_extension.stop_action(weapon_extension, "reload")
			end
		elseif input_extension.get(input_extension, "weapon_reload") then
			input_extension.add_buffer(input_extension, "weapon_reload", 0)
		end
	end

	return 
end
ActionHandgun.finish = function (self, reason)
	local ammo_extension = self.ammo_extension
	local current_action = self.current_action

	if reason ~= "new_interupting_action" then
		local status_extension = ScriptUnit.extension(self.owner_unit, "status_system")

		status_extension.set_zooming(status_extension, false)

		if ammo_extension and current_action.reload_when_out_of_ammo and ammo_extension.ammo_count(ammo_extension) == 0 and ammo_extension.can_reload(ammo_extension) then
			ammo_extension.start_reload(ammo_extension, true)
		end
	end

	if current_action.block then
		local status_extension = ScriptUnit.extension(self.owner_unit, "status_system")

		status_extension.set_blocking(status_extension, false)
	end

	return 
end

return 
