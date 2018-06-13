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
end

ActionBow.client_owner_start_action = function (self, new_action, t, chain_action_data)
	self.current_action = new_action
	local input_extension = ScriptUnit.extension(self.owner_unit, "input_system")

	input_extension:reset_input_buffer()

	self.state = "waiting_to_shoot"
	self.time_to_shoot = t + (new_action.fire_time or 0)
	self.extra_buff_shot = false
end

ActionBow.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action

	if self.state == "waiting_to_shoot" and self.time_to_shoot <= t then
		self.state = "shooting"
	end

	if self.state == "shooting" then
		local buff_extension = ScriptUnit.extension(self.owner_unit, "buff_system")
		local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.EXTRA_SHOT)
		local add_spread = not self.extra_buff_shot

		if not Managers.player:owner(self.owner_unit).bot_player then
			Managers.state.controller_features:add_effect("rumble", {
				rumble_effect = "bow_fire"
			})
		end

		self:fire(current_action, add_spread)

		if procced and not self.extra_buff_shot then
			self.state = "waiting_to_shoot"
			self.time_to_shoot = t + 0.1
			self.extra_buff_shot = true
		else
			self.state = "shot"
		end

		local first_person_extension = ScriptUnit.extension(self.owner_unit, "first_person_system")

		if self.current_action.reset_aim_on_attack then
			first_person_extension:reset_aim_assist_multiplier()
		end

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			first_person_extension:play_hud_sound_event(fire_sound_event)
		end
	end
end

ActionBow.finish = function (self, reason, data)
	local current_action = self.current_action
	local owner_unit_status = ScriptUnit.extension(self.owner_unit, "status_system")

	if self.state == "waiting_to_shoot" then
		self:fire(current_action)

		self.state = "shot"
	end

	if not data or data.new_action ~= "action_two" or data.new_sub_action ~= "default" then
		owner_unit_status:set_zooming(false)
	end
end

ActionBow.fire = function (self, current_action, add_spread)
	local owner_unit = self.owner_unit
	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
	local speed = current_action.speed
	local rotation = first_person_extension:current_rotation()
	local position = first_person_extension:current_position()
	local auto_hit_chance = current_action.aim_assist_auto_hit_chance or 0

	if current_action.fire_at_gaze_setting then
		local HAS_TOBII = rawget(_G, "Tobii") and Tobii.device_status() == Tobii.DEVICE_TRACKING and Application.user_setting("tobii_eyetracking")

		if Application.user_setting(current_action.fire_at_gaze_setting) and HAS_TOBII and ScriptUnit.has_extension(owner_unit, "eyetracking_system") then
			local eyetracking_extension = ScriptUnit.extension(owner_unit, "eyetracking_system")
			local forward = eyetracking_extension:get_smooth_gaze_forward()
			rotation = Quaternion.look(forward, Vector3.up())
		end
	end

	local spread_extension = self.spread_extension

	if spread_extension then
		rotation = spread_extension:get_randomised_spread(rotation)

		if add_spread then
			spread_extension:set_shooting()
		end
	end

	local angle = DamageUtils.pitch_from_rotation(rotation)
	local position = first_person_extension:current_position()
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
end

return
