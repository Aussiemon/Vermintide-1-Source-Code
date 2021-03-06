ActionStaff = class(ActionStaff)

ActionStaff.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.item_name = item_name
	self.wwise_world = Managers.world:wwise_world(world)
	self.world = world

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	if ScriptUnit.has_extension(weapon_unit, "spread_system") then
		self.spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")
	end

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end
end

ActionStaff.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + (new_action.fire_time or 0)
end

ActionStaff.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		self:fire()

		self.state = "shot"
	end
end

ActionStaff.finish = function (self, reason)
	return
end

ActionStaff.fire = function (self, reason)
	local current_action = self.current_action
	local owner_unit = self.owner_unit
	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
	local rotation = first_person_extension:current_rotation()
	local spread_extension = self.spread_extension

	if spread_extension then
		rotation = spread_extension:get_randomised_spread(rotation)

		spread_extension:set_shooting()
	end

	local angle = DamageUtils.pitch_from_rotation(rotation)
	local speed = current_action.speed
	local position = first_person_extension:current_position()
	local target_vector = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
	local projectile_info = current_action.projectile_info
	local lookup_data = current_action.lookup_data

	ActionUtils.spawn_player_projectile(owner_unit, position, rotation, 0, angle, target_vector, speed, self.item_name, lookup_data.item_template_name, lookup_data.action_name, lookup_data.sub_action_name, nil)

	if self.ammo_extension then
		local ammo_usage = current_action.ammo_usage

		self.ammo_extension:use_ammo(ammo_usage)
	end

	if self.overcharge_extension then
		self.overcharge_extension:add_charge(current_action.overcharge_type)
	end

	if self.ammo_extension and self.ammo_extension:can_reload() then
		local play_reload_animation = true

		self.ammo_extension:start_reload(play_reload_animation)
	end

	local fire_sound_event = current_action.fire_sound_event

	if fire_sound_event then
		WwiseUtils.trigger_unit_event(self.world, fire_sound_event, self.weapon_unit)
	end
end

return
