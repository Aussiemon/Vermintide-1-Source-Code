ActionShotgun = class(ActionShotgun)
ActionShotgun.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.weapon_system = weapon_system
	self.owner_unit = owner_unit
	self.first_person_unit = first_person_unit
	self.weapon_unit = weapon_unit
	self.world = world
	self.item_name = item_name
	self.wwise_world = Managers.world:wwise_world(world)

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
ActionShotgun.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + new_action.fire_time
	local spread_template_override = new_action.spread_template_override

	if spread_template_override then
		self.spread_extension:override_spread_template(spread_template_override)
	end

	self.extra_buff_shot = false

	return 
end
ActionShotgun.client_owner_post_update = function (self, dt, t, world, can_damage)
	local owner_unit = self.owner_unit
	local current_action = self.current_action
	local is_server = self.is_server

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		local world = self.world
		local spread_extension = self.spread_extension
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local current_position = first_person_extension.current_position(first_person_extension)
		local current_rotation = first_person_extension.current_rotation(first_person_extension)
		local num_shots = current_action.shot_count or 1
		local ammo_usage = current_action.ammo_usage

		if current_action.special_ammo_thing and not self.extra_buff_shot then
			ammo_usage = self.ammo_extension.current_ammo
			num_shots = ammo_usage
		end

		local physics_world = World.get_data(world, "physics_world")
		local pitch, yaw = spread_extension.get_current_pitch_and_yaw(spread_extension)
		local angle = math.degrees_to_radians(math.max(pitch, yaw))

		PhysicsWorld.prepare_actors_for_raycast(physics_world, current_position, Quaternion.forward(current_rotation), angle, 9, current_action.range*current_action.range)

		local check_buffs = true

		for i = 1, num_shots, 1 do
			local rotation = current_rotation

			if spread_extension then
				rotation = spread_extension.get_target_style_spread(spread_extension, i, num_shots, current_rotation)
			end

			local direction = Quaternion.forward(rotation)
			local collision_filter = "filter_player_ray_projectile"
			local result = PhysicsWorld.immediate_raycast(physics_world, current_position, direction, current_action.range or nil, "all", "collision_filter", collision_filter)

			if result then
				local data = DamageUtils.process_projectile_hit(world, self.item_name, owner_unit, is_server, result, current_action, direction, check_buffs)

				if data.buffs_checked then
					check_buffs = check_buffs and false
				end
			end
		end

		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
		local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.EXTRA_SHOT)
		local add_spread = true

		if procced and not self.extra_buff_shot then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.2
			self.extra_buff_shot = true
			add_spread = false
		else
			self.state = "shot"
		end

		if spread_extension and add_spread then
			spread_extension.set_shooting(spread_extension)
		end

		if current_action.alert_sound_range_fire then
			Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, POSITION_LOOKUP[owner_unit], current_action.alert_sound_range_fire)
		end

		if self.overcharge_extension then
			self.overcharge_extension:add_charge(current_action.overcharge_type)
		end

		if self.ammo_extension and not self.extra_buff_shot then
			self.ammo_extension:use_ammo(ammo_usage)
		end

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

			first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event)
		end
	end

	return 
end
ActionShotgun.finish = function (self, reason)
	local ammo_extension = self.ammo_extension
	local current_action = self.current_action

	if self.spread_extension then
		self.spread_extension:reset_spread_template()
	end

	if ammo_extension and current_action.reload_when_out_of_ammo and ammo_extension.ammo_count(ammo_extension) == 0 and ammo_extension.can_reload(ammo_extension) then
		local play_reload_animation = true

		ammo_extension.start_reload(ammo_extension, play_reload_animation)
	end

	return 
end

return 