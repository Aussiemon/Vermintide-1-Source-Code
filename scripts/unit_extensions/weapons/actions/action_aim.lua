ActionAim = class(ActionAim)

ActionAim.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.first_person_unit = first_person_unit
	self.is_server = is_server
	self.world = world
	self.item_name = item_name

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	if ScriptUnit.has_extension(weapon_unit, "spread_system") then
		self.spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")
	end
end

ActionAim.client_owner_start_action = function (self, new_action, t)
	local owner_unit = self.owner_unit
	self.current_action = new_action
	self.zoom_condition_function = new_action.zoom_condition_function
	self.played_aim_sound = false
	self.aim_sound_time = t + (new_action.aim_sound_delay or 0)
	self.aim_zoom_time = t + (new_action.aim_zoom_delay or 0)
	local spread_template_override = new_action.spread_template_override

	if spread_template_override then
		self.spread_extension:override_spread_template(spread_template_override)
	end

	local HAS_TOBII = rawget(_G, "Tobii") and Tobii.device_status() == Tobii.DEVICE_TRACKING and Application.user_setting("tobii_eyetracking")

	if new_action.aim_at_gaze_setting and Application.user_setting(new_action.aim_at_gaze_setting) and HAS_TOBII and ScriptUnit.has_extension(owner_unit, "eyetracking_system") then
		local eyetracking_extension = ScriptUnit.extension(owner_unit, "eyetracking_system")
		local gaze_rotation = eyetracking_extension:gaze_rotation()
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

		first_person_extension:force_look_rotation(gaze_rotation, 0)
	end

	local loaded_projectile_settings = new_action.loaded_projectile_settings

	if loaded_projectile_settings then
		local inventory_extension = ScriptUnit.extension(owner_unit, "inventory_system")

		inventory_extension:set_loaded_projectile_override(loaded_projectile_settings)
	end
end

ActionAim.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action
	local owner_unit = self.owner_unit

	if not self.zoom_condition_function or self.zoom_condition_function() then
		local status_extension = ScriptUnit.extension(owner_unit, "status_system")
		local input_extension = ScriptUnit.extension(owner_unit, "input_system")
		local buff_extension = ScriptUnit.extension(owner_unit, "buff_system")

		if not status_extension:is_zooming() and self.aim_zoom_time <= t then
			status_extension:set_zooming(true, current_action.default_zoom)
		end

		if buff_extension:has_buff_type("increased_zoom") and status_extension:is_zooming() and input_extension:get("action_three") then
			status_extension:switch_variable_zoom(current_action.buffed_zoom_thresholds)
		elseif current_action.zoom_thresholds and status_extension:is_zooming() and input_extension:get("action_three") then
			status_extension:switch_variable_zoom(current_action.zoom_thresholds)
		end
	end

	if not self.played_aim_sound and self.aim_sound_time <= t then
		local sound_event = current_action.aim_sound_event

		if not Managers.player:owner(self.owner_unit).bot_player then
			Managers.state.controller_features:add_effect("rumble", {
				rumble_effect = "aim_start"
			})
		end

		if sound_event then
			local wwise_world = Managers.world:wwise_world(self.world)

			WwiseWorld.trigger_event(wwise_world, sound_event)
		end

		self.played_aim_sound = true
	end
end

ActionAim.finish = function (self, reason)
	local current_action = self.current_action
	local ammo_extension = self.ammo_extension
	local owner_unit = self.owner_unit
	local unzoom_condition_function = current_action.unzoom_condition_function

	if not unzoom_condition_function or unzoom_condition_function(reason) then
		local status_extension = ScriptUnit.extension(owner_unit, "status_system")

		status_extension:set_zooming(false)
	end

	if ammo_extension and ammo_extension:can_reload() and ammo_extension:ammo_count() == 0 and current_action.reload_when_out_of_ammo then
		local play_reload_animation = true

		ammo_extension:start_reload(play_reload_animation)
	end

	if self.spread_extension then
		self.spread_extension:reset_spread_template()
	end

	local sound_event = current_action.unaim_sound_event

	if sound_event then
		local wwise_world = Managers.world:wwise_world(self.world)

		WwiseWorld.trigger_event(wwise_world, sound_event)
	end

	local owner = Managers.player:owner(self.owner_unit)

	if owner:is_player_controlled() then
	end

	if not Managers.player:owner(self.owner_unit).bot_player then
		Managers.state.controller_features:add_effect("rumble", {
			rumble_effect = "full_stop"
		})
	end

	if current_action.reset_aim_assist_on_exit then
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

		first_person_extension:reset_aim_assist_multiplier()
	end

	local inventory_extension = ScriptUnit.extension(self.owner_unit, "inventory_system")

	inventory_extension:set_loaded_projectile_override(nil)
end

return
