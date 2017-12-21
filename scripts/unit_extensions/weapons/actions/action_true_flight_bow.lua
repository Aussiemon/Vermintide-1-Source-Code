require("scripts/unit_extensions/weapons/projectiles/true_flight_templates")

ActionTrueFlightBow = class(ActionTrueFlightBow)
ActionTrueFlightBow.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.item_name = item_name
	self.is_server = is_server
	self.world = world
	self.targets_fired_on = {}

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	self.spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	return 
end
ActionTrueFlightBow.client_owner_start_action = function (self, new_action, t, chain_action_data)
	self.current_action = new_action
	self.true_flight_template_id = TrueFlightTemplates[new_action.true_flight_template].lookup_id

	assert(self.true_flight_template_id)

	if chain_action_data then
		self.target = chain_action_data.target
	end

	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + (new_action.fire_time or 0)
	self.extra_buff_shot = false

	return 
end
ActionTrueFlightBow.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action
	local owner_unit = self.owner_unit

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")
		local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.EXTRA_SHOT)
		local add_spread = not self.extra_buff_shot

		self.fire(self, current_action, add_spread)

		if procced and not self.extra_buff_shot then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.1
			self.extra_buff_shot = true
		else
			self.state = "shot"
		end

		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

		if self.current_action.reset_aim_on_attack then
			first_person_extension.reset_aim_assist_multiplier(first_person_extension)
		end

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			local play_on_husk = self.current_action.fire_sound_on_husk
			local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

			first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event, nil, play_on_husk)
		end
	end

	return 
end
ActionTrueFlightBow.finish = function (self, reason, data)
	local owner_unit_status = ScriptUnit.extension(self.owner_unit, "status_system")
	local current_action = self.current_action

	if not data or data.new_action ~= "action_two" or data.new_sub_action ~= "default" then
		owner_unit_status.set_zooming(owner_unit_status, false)
	end

	return 
end
ActionTrueFlightBow.fire = function (self, current_action, add_spread)
	local owner_unit = self.owner_unit
	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
	local speed = current_action.speed
	local rotation = first_person_extension.current_rotation(first_person_extension)
	local spread_extension = self.spread_extension

	if spread_extension then
		rotation = spread_extension.get_randomised_spread(spread_extension, rotation)

		if add_spread then
			spread_extension.set_shooting(spread_extension)
		end
	end

	local position = first_person_extension.current_position(first_person_extension)
	local target_vector = Vector3.normalize(Quaternion.forward(rotation))
	local angle = DamageUtils.pitch_from_rotation(rotation)
	local target_unit = self.target
	local lookup_data = current_action.lookup_data

	ActionUtils.spawn_true_flight_projectile(owner_unit, target_unit, self.true_flight_template_id, position, rotation, angle, target_vector, speed, self.item_name, lookup_data.item_template_name, lookup_data.action_name, lookup_data.sub_action_name)

	if self.ammo_extension and not self.extra_buff_shot then
		local ammo_usage = self.current_action.ammo_usage

		self.ammo_extension:use_ammo(ammo_usage)

		if self.ammo_extension:can_reload() then
			local play_reload_animation = false

			self.ammo_extension:start_reload(play_reload_animation)
		end
	end

	if self.overcharge_extension and not self.extra_buff_shot then
		if current_action.scale_overcharge then
			self.overcharge_extension:add_charge(current_action.overcharge_type, self.charge_level)
		else
			self.overcharge_extension:add_charge(current_action.overcharge_type)
		end
	end

	if current_action.alert_sound_range_fire then
		Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, POSITION_LOOKUP[owner_unit], current_action.alert_sound_range_fire)
	end

	return 
end

return 
