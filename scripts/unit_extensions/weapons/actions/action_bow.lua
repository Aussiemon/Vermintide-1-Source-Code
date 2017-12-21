ActionBow = class(ActionBow)
ActionBow.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.item_name = item_name
	self.wwise_world = Managers.world:wwise_world(world)

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	self.spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")

	return 
end
ActionBow.client_owner_start_action = function (self, new_action, t, chain_action_data)
	self.current_action = new_action

	if chain_action_data then
		self.charge_value = chain_action_data.charge_level or 0
	else
		self.charge_value = 1
	end

	local input_extension = ScriptUnit.extension(self.owner_unit, "input_system")

	input_extension.reset_input_buffer(input_extension)

	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + (new_action.fire_time or 0)
	self.extra_buff_shot = false

	return 
end
ActionBow.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		local buff_extension = ScriptUnit.extension(self.owner_unit, "buff_system")
		local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.EXTRA_SHOT)
		local add_spread = true

		if procced and not self.extra_buff_shot then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.1
			self.extra_buff_shot = true
			add_spread = false
		else
			self.state = "shot"
		end

		self.fire(self, current_action, add_spread)

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			local first_person_extension = ScriptUnit.extension(self.owner_unit, "first_person_system")

			first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event)
		end
	end

	return 
end
ActionBow.finish = function (self, reason, data)
	local current_action = self.current_action
	local owner_unit_status = ScriptUnit.extension(self.owner_unit, "status_system")

	if self.state == "waiting_to_shoot" then
		self.fire(self, current_action)

		self.state = "shot"
	end

	if not data or data.new_action ~= "action_two" or data.new_sub_action ~= "default" then
		owner_unit_status.set_zooming(owner_unit_status, false)
	end

	return 
end
ActionBow.fire = function (self, current_action, add_spread)
	local owner_unit = self.owner_unit
	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
	local charge_value = self.charge_value
	local speed = math.lerp(current_action.min_speed, current_action.max_speed or current_action.min_speed, charge_value)
	local rotation = first_person_extension.current_rotation(first_person_extension)
	local spread_extension = self.spread_extension

	if spread_extension then
		rotation = spread_extension.get_randomised_spread(spread_extension, rotation)

		if add_spread then
			spread_extension.set_shooting(spread_extension)
		end
	end

	local angle = DamageUtils.pitch_from_rotation(rotation)
	local position = first_person_extension.current_position(first_person_extension)
	local target_vector = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
	local projectile_info = current_action.projectile_info
	local lookup_data = current_action.lookup_data

	ActionUtils.spawn_player_projectile(owner_unit, position, rotation, 0, angle, target_vector, speed, self.item_name, lookup_data.item_template_name, lookup_data.action_name, lookup_data.sub_action_name)

	if self.ammo_extension and not self.extra_buff_shot then
		local ammo_usage = self.current_action.ammo_usage

		self.ammo_extension:use_ammo(ammo_usage)

		if self.ammo_extension:can_reload() then
			local play_reload_animation = false

			self.ammo_extension:start_reload(play_reload_animation)
		end
	end

	if current_action.alert_sound_range_fire then
		Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, POSITION_LOOKUP[owner_unit], current_action.alert_sound_range_fire)
	end

	return 
end

return 
