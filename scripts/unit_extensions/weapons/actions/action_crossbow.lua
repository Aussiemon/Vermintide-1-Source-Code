ActionCrossbow = class(ActionCrossbow)
ActionCrossbow.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.first_person_unit = first_person_unit
	self.is_server = is_server
	self.item_name = item_name
	self.wwise_world = Managers.world:wwise_world(world)

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	self.spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")

	return 
end
ActionCrossbow.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	self.num_projectiles = new_action.num_projectiles
	self.multi_projectile_spread = new_action.multi_projectile_spread or 0.075

	if self.ammo_extension and self.num_projectiles then
		self.num_projectiles = math.min(self.num_projectiles, self.ammo_extension.current_ammo)
	end

	self.num_projectiles_shot = 1
	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + (new_action.fire_time or 0)
	self.extra_buff_shot = false
	self.active_reload_time = new_action.active_reload_time and t + new_action.active_reload_time

	return 
end
ActionCrossbow.client_owner_post_update = function (self, dt, t, world, can_damage)
	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		local owner_unit = self.owner_unit
		local add_spread = not self.extra_buff_shot

		if not Managers.player:owner(self.owner_unit).bot_player then
			Managers.state.controller_features:add_effect("rumble", {
				rumble_effect = "crossbow_fire"
			})
		end

		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local rotation = first_person_extension.current_rotation(first_person_extension)
		local spread_extension = self.spread_extension

		if self.num_projectiles then
			for i = 1, self.num_projectiles, 1 do
				local fire_rotation = rotation

				if spread_extension then
					if 1 < self.num_projectiles_shot then
						local spread_horizontal_angle = math.pi*(math.mod(self.num_projectiles_shot, 2) + 0.5)
						local shot_count_offset = (self.num_projectiles_shot ~= 1 or 0) and math.round((self.num_projectiles_shot - 1)/2, 0)
						local angle_offset = self.multi_projectile_spread*shot_count_offset
						fire_rotation = spread_extension.combine_spread_rotations(spread_extension, spread_horizontal_angle, angle_offset, fire_rotation)
					end

					if add_spread then
						spread_extension.set_shooting(spread_extension)
					end
				end

				local angle = DamageUtils.pitch_from_rotation(fire_rotation)
				local current_action = self.current_action
				local speed = current_action.speed
				local position = first_person_extension.current_position(first_person_extension)
				local target_vector = Vector3.normalize(Vector3.flat(Quaternion.forward(fire_rotation)))
				local projectile_info = current_action.projectile_info
				local lookup_data = current_action.lookup_data

				ActionUtils.spawn_player_projectile(owner_unit, position, fire_rotation, 0, angle, target_vector, speed, self.item_name, lookup_data.item_template_name, lookup_data.action_name, lookup_data.sub_action_name, nil)

				local fire_sound_event = self.current_action.fire_sound_event

				if fire_sound_event then
					local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

					first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event)
				end

				if self.ammo_extension and not self.extra_buff_shot then
					local ammo_usage = current_action.ammo_usage

					self.ammo_extension:use_ammo(ammo_usage)
				end

				self.num_projectiles_shot = self.num_projectiles_shot + 1
			end
		else
			if spread_extension then
				rotation = spread_extension.get_randomised_spread(spread_extension, rotation)

				if add_spread then
					spread_extension.set_shooting(spread_extension)
				end
			end

			local angle = DamageUtils.pitch_from_rotation(rotation)
			local current_action = self.current_action
			local speed = current_action.speed
			local position = first_person_extension.current_position(first_person_extension)
			local target_vector = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
			local projectile_info = current_action.projectile_info
			local lookup_data = current_action.lookup_data

			ActionUtils.spawn_player_projectile(owner_unit, position, rotation, 0, angle, target_vector, speed, self.item_name, lookup_data.item_template_name, lookup_data.action_name, lookup_data.sub_action_name, nil)

			local fire_sound_event = self.current_action.fire_sound_event

			if fire_sound_event then
				local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

				first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event)
			end

			if self.ammo_extension and not self.extra_buff_shot then
				local ammo_usage = current_action.ammo_usage

				self.ammo_extension:use_ammo(ammo_usage)
			end
		end

		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
		local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.EXTRA_SHOT)

		if procced and not self.extra_buff_shot then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.1
			self.extra_buff_shot = true
		else
			self.state = "shot"
		end

		first_person_extension.reset_aim_assist_multiplier(first_person_extension)
	end

	if self.state == "shot" and self.active_reload_time then
		local owner_unit = self.owner_unit
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
ActionCrossbow.finish = function (self, reason)
	local ammo_extension = self.ammo_extension
	local current_action = self.current_action

	if reason ~= "new_interupting_action" then
		local status_extension = ScriptUnit.extension(self.owner_unit, "status_system")

		status_extension.set_zooming(status_extension, false)

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
