ActionChargedProjectile = class(ActionChargedProjectile)
ActionChargedProjectile.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.world = world
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.item_name = item_name
	self.first_person_unit = first_person_unit
	self.wwise_world = Managers.world:wwise_world(world)
	self.is_server = is_server
	self.network_manager = Managers.state.network

	if ScriptUnit.has_extension(weapon_unit, "spread_system") then
		self.spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")
	end

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	self.buff_extension = ScriptUnit.extension(owner_unit, "buff_system")

	return 
end
ActionChargedProjectile.client_owner_start_action = function (self, new_action, t, chain_action_data)
	self.current_action = new_action
	self.state = "waiting_to_shoot"

	if chain_action_data then
		self.charge_level = chain_action_data.charge_level
	else
		self.charge_level = 0
	end

	self.time_to_shoot = t + new_action.fire_time
	self.extra_buff_shot = false
	local spread_template_override = new_action.spread_template_override

	if spread_template_override then
		self.spread_extension:override_spread_template(spread_template_override)
	end

	local loaded_projectile_settings = new_action.loaded_projectile_settings

	if loaded_projectile_settings then
		local inventory_extension = ScriptUnit.extension(self.owner_unit, "inventory_system")

		inventory_extension.set_loaded_projectile_override(inventory_extension, loaded_projectile_settings)
	end

	return 
end
ActionChargedProjectile.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action
	local owner_unit = self.owner_unit

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		if self.overcharge_extension and not self.extra_buff_shot then
			if current_action.scale_overcharge then
				self.overcharge_extension:add_charge(current_action.overcharge_type, self.charge_level)
			else
				self.overcharge_extension:add_charge(current_action.overcharge_type)
			end
		end

		if self.ammo_extension then
			local ammo_usage = self.current_action.ammo_usage
			local _, procced = self.buff_extension:apply_buffs_to_value(0, StatBuffIndex.NOT_CONSUME_GRENADE)

			if not procced then
				self.ammo_extension:use_ammo(ammo_usage)
			else
				local inventory_extension = ScriptUnit.extension(owner_unit, "inventory_system")

				inventory_extension.wield_previous_weapon(inventory_extension)
			end
		end

		if not Managers.player:owner(self.owner_unit).bot_player then
			Managers.state.controller_features:add_effect("rumble", {
				rumble_effect = "handgun_fire"
			})
		end

		local _, procced = self.buff_extension:apply_buffs_to_value(0, StatBuffIndex.EXTRA_SHOT)
		local add_spread = not self.extra_buff_shot

		if procced and not self.extra_buff_shot then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.1
			self.extra_buff_shot = true
		else
			self.state = "shot"
		end

		local network_manager = self.network_manager
		local owner_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
		local first_person_unit = self.first_person_unit
		local position = Unit.world_position(first_person_unit, 0)
		local rotation = Unit.local_rotation(first_person_unit, 0)
		local spread_extension = self.spread_extension

		if spread_extension then
			rotation = spread_extension.get_randomised_spread(spread_extension, rotation)

			if add_spread then
				spread_extension.set_shooting(spread_extension)
			end
		end

		local angle = DamageUtils.pitch_from_rotation(rotation)
		local speed = current_action.speed
		local target_vector = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
		local projectile_info = current_action.projectile_info

		if projectile_info.fire_from_muzzle then
			local unit = self.weapon_unit
			local muzzle_name = projectile_info.muzzle_name or "fx_muzzle"
			local node = Unit.node(unit, muzzle_name)
			local muzzle_pos = Unit.world_position(unit, node)
			local life_time = 1

			if projectile_info.timed_data then
				life_time = projectile_info.timed_data.life_time
			end

			local radians = math.degrees_to_radians(angle)
			local gravity = ProjectileGravitySettings[projectile_info.gravity_settings]
			local position_on_trajectory = WeaponHelper:position_on_trajectory(position, target_vector, speed/100, radians, gravity, life_time)
			target_vector = Vector3.normalize(Vector3.flat(position_on_trajectory - muzzle_pos))
			position = muzzle_pos
		end

		local owner_player = Managers.player:owner(owner_unit)
		local is_bot = owner_player and owner_player.bot_player
		local throw_up_factor = current_action.throw_up_this_much_in_target_direction

		if throw_up_factor and not is_bot then
			target_vector = Vector3.normalize(target_vector + Vector3(0, 0, current_action.throw_up_this_much_in_target_direction))
		end

		local lookup_data = current_action.lookup_data
		local item_name = self.item_name
		local item_template_name = lookup_data.item_template_name
		local action_name = lookup_data.action_name
		local sub_action_name = lookup_data.sub_action_name
		local charge_level = math.round(self.charge_level*100)
		local scale = charge_level

		ActionUtils.spawn_player_projectile(owner_unit, position, rotation, scale, angle, target_vector, speed, item_name, item_template_name, action_name, sub_action_name)

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			local play_on_husk = self.current_action.fire_sound_on_husk
			local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

			first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event, nil, play_on_husk)
		end

		if current_action.alert_sound_range_fire then
			Managers.state.entity:system("ai_system"):alert_enemies_within_range(owner_unit, POSITION_LOOKUP[owner_unit], current_action.alert_sound_range_fire)
		end

		if current_action.hide_weapon_after_fire then
			Unit.set_unit_visibility(self.weapon_unit, false)
		end

		if projectile_info.pickup_name then
			local dialogue_input = ScriptUnit.extension_input(self.owner_unit, "dialogue_system")
			local event_data = FrameTable.alloc_table()
			event_data.item_type = projectile_info.pickup_name

			dialogue_input.trigger_networked_dialogue_event(dialogue_input, "throwing_item", event_data)
		end
	end

	return 
end
ActionChargedProjectile.finish = function (self, reason)
	local owner_unit = self.owner_unit
	local inventory_extension = ScriptUnit.extension(owner_unit, "inventory_system")

	inventory_extension.set_loaded_projectile_override(inventory_extension, nil)

	if self.spread_extension then
		self.spread_extension:reset_spread_template()
	end

	return 
end

return 
