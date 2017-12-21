OverChargeExtension = class(OverChargeExtension)
script_data.overcharge_debug = script_data.overcharge_debug or Development.parameter("overcharge_debug")
script_data.disable_overcharge = script_data.disable_overcharge or Development.parameter("disable_overcharge")
OverChargeExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.unit = unit
	self.owner_unit = extension_init_data.owner_unit
	self.item_name = extension_init_data.item_name
	self.buff_extension = ScriptUnit.extension(self.owner_unit, "buff_system")
	local overcharge_data = extension_init_data.overcharge_data
	local ammo_percent = extension_init_data.ammo_percent
	self.max_value = overcharge_data.max_value or 40
	self.overcharge_value = (ammo_percent and (ammo_percent - 1)*self.max_value) or 0
	self.time_when_overcharge_start_decreasing = 0
	self.above_threshold = false
	self.overcharge_crit_time = 0
	self.overcharge_crit_interval = 1
	self.venting_overcharge = false
	self.vent_damage_pool = 0
	self.no_damage = global_is_inside_inn
	self.overcharge_limit = self.max_value*0.65
	self.overcharge_critical_limit = self.max_value*0.8
	self.overcharge_threshold = overcharge_data.overcharge_threshold or 0
	self.overcharge_value_decrease_rate = overcharge_data.overcharge_value_decrease_rate or 0
	self.time_until_overcharge_decreases = overcharge_data.time_until_overcharge_decreases or 0
	self.hit_overcharge_threshold_sound = overcharge_data.hit_overcharge_threshold_sound or "ui_special_attack_ready"
	self.overcharge_warning_critical_sound_event = overcharge_data.overcharge_warning_critical_sound_event
	self.overcharge_warning_high_sound_event = overcharge_data.overcharge_warning_high_sound_event
	self.overcharge_warning_med_sound_event = overcharge_data.overcharge_warning_med_sound_event
	self.overcharge_warning_low_sound_event = overcharge_data.overcharge_warning_low_sound_event
	self.explosion_template = overcharge_data.explosion_template or "overcharge_explosion"
	self.has_overcharge = false
	self.network_manager = Managers.state.network
	self.venting_anim = nil
	local first_person_extension = ScriptUnit.extension(self.owner_unit, "first_person_system")
	self.first_person_extension = first_person_extension
	self.first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)
	self.first_person_mesh_unit = first_person_extension.get_first_person_mesh_unit(first_person_extension)
	self.overcharge_blend_id = Unit.animation_find_variable(self.first_person_unit, "overcharge")
	self.inventory_extension = ScriptUnit.extension(self.owner_unit, "inventory_system")
	self.update_overcharge_flow_timer = 0
	self.is_exploding = false

	self.set_screen_particle_opacity_modifier(self, Application.user_setting("overcharge_opacity"))

	return 
end
OverChargeExtension.set_screen_particle_opacity_modifier = function (self, value)
	self._screen_particle_opacity_modifier = value/100

	return 
end
OverChargeExtension.reset = function (self)
	self.overcharge_value = 0
	self.played_hit_overcharge_threshold = false
	self.is_exploding = false

	self.set_flow_values(self, self.overcharge_value, self.overcharge_threshold, self.max_value)

	return 
end
OverChargeExtension.destroy = function (self)
	if self.onscreen_particles_id then
		World.destroy_particles(self.world, self.onscreen_particles_id)
		World.destroy_particles(self.world, self.critical_onscreen_particles_id)
	end

	return 
end
OverChargeExtension.set_flow_values = function (self, overcharge_value, overcharge_threshold, max_value)
	local anim_blend_overcharge = self.get_anim_blend_overcharge(self)
	local unit = self.unit
	local first_person_unit = self.first_person_unit
	local first_person_mesh_unit = self.first_person_mesh_unit

	Unit.animation_set_variable(first_person_unit, self.overcharge_blend_id, anim_blend_overcharge)
	Unit.set_flow_variable(first_person_mesh_unit, "current_overcharge", anim_blend_overcharge)
	Unit.set_flow_variable(first_person_unit, "current_overcharge", anim_blend_overcharge)
	Unit.set_flow_variable(unit, "current_overcharge", anim_blend_overcharge)
	Unit.flow_event(unit, "lua_update_overcharge")
	Unit.flow_event(first_person_unit, "lua_update_overcharge")
	Unit.flow_event(first_person_mesh_unit, "lua_update_overcharge")

	local left_unit = self.left_unit

	if left_unit then
		Unit.set_flow_variable(left_unit, "current_overcharge", anim_blend_overcharge)
		Unit.flow_event(left_unit, "lua_update_overcharge")
	end

	if self.above_threshold and overcharge_value < overcharge_threshold then
		self.above_threshold = false

		Unit.flow_event(unit, "below_overcharge_threshold")
		Unit.flow_event(first_person_mesh_unit, "below_overcharge_threshold")
		Unit.flow_event(first_person_unit, "below_overcharge_threshold")

		if left_unit then
			Unit.flow_event(left_unit, "below_overcharge_threshold")
		end
	end

	return 
end
OverChargeExtension.update = function (self, unit, input, dt, context, t)
	local world = self.world

	if not self.initialized then
		self.initialized = true
		local equipment = self.inventory_extension:equipment()

		for slot_name, slot in pairs(equipment.slots) do
			if self.unit == slot.left_unit_1p or self.unit == slot.right_unit_1p then
				self.right_unit = slot.right_unit_1p
				self.left_unit = slot.left_unit_1p
			end
		end
	end

	if self.unit == self.right_unit then
		if not self.is_exploding and self.venting_overcharge and 0 <= self.overcharge_value then
			local wielder = self.owner_unit
			local vent_amount = self.overcharge_value*self.max_value/80*dt
			self.vent_damage_pool = self.vent_damage_pool + vent_amount*2
			self.overcharge_value = self.overcharge_value - vent_amount

			if 20 <= self.vent_damage_pool and not self.no_damage and self.overcharge_threshold < self.overcharge_value then
				local damage_amount = self.overcharge_value/8 + 2
				local buff_extension = self.buff_extension
				damage_amount = buff_extension.apply_buffs_to_value(buff_extension, damage_amount, StatBuffIndex.REDUCED_VENT_DAMAGE)

				DamageUtils.add_damage_network(wielder, wielder, damage_amount, "torso", "overcharge", Vector3(0, 1, 0), "overcharge")

				self.vent_damage_pool = 0
			end

			self.set_flow_values(self, self.overcharge_value, self.overcharge_threshold, self.max_value)
		else
			self.venting_overcharge = false
		end

		if self.venting_anim then
			Unit.animation_event(self.first_person_unit, self.venting_anim)

			self.venting_anim = nil
		end

		if script_data.overcharge_debug then
			if DebugKeyHandler.key_pressed("v", "fill overcharge", "player", "left shift") then
				self.add_charge(self, "overcharge_debug_value")
			end

			Debug.text("overCharge level: " .. tostring(self.overcharge_value))
		end

		if 0 < self.overcharge_value then
			if self.update_overcharge_flow_timer < t and not self.venting_overcharge then
				self.set_flow_values(self, self.overcharge_value, self.overcharge_threshold, self.max_value)

				self.update_overcharge_flow_timer = t + 0.3
			end

			local buff_extension = self.buff_extension
			self.has_overcharge = true

			if not self.is_exploding and self.time_when_overcharge_start_decreasing < t then
				local decay = 1

				if self.above_threshold then
					decay = decay*0.6
				end

				self.overcharge_value = math.max(0, self.overcharge_value - decay*self.overcharge_value_decrease_rate*dt)
				local overcharged_critical_buff_id = self.overcharged_critical_buff_id
				local overcharged_buff_id = self.overcharged_buff_id

				if overcharged_critical_buff_id and self.overcharge_value < self.overcharge_critical_limit then
					buff_extension.remove_buff(buff_extension, overcharged_critical_buff_id)

					self.overcharged_critical_buff_id = nil
				elseif overcharged_buff_id and self.overcharge_value < self.overcharge_limit then
					buff_extension.remove_buff(buff_extension, overcharged_buff_id)

					self.overcharged_buff_id = nil
				end
			end
		elseif self.has_overcharge then
			self.has_overcharge = false

			Unit.animation_set_variable(self.first_person_unit, self.overcharge_blend_id, 0)
			Unit.set_flow_variable(self.first_person_mesh_unit, "current_overcharge", 0)
			Unit.set_flow_variable(self.first_person_unit, "current_overcharge", 0)
			Unit.set_flow_variable(unit, "current_overcharge", 0)

			if self.left_unit then
				Unit.set_flow_variable(self.left_unit, "current_overcharge", 0)
			end
		end

		local owner_player = Managers.player:owner(self.owner_unit)
		local is_bot = owner_player and owner_player.bot_player
		local overcharge_scalar = self.overcharge_value/self.max_value

		if not is_bot then
			local wwise_world = Managers.world:wwise_world(world)

			WwiseWorld.set_global_parameter(wwise_world, "overcharge_status", overcharge_scalar)
		end

		if script_data.overcharge_debug then
			print(overcharge_scalar)
		end

		if not self.onscreen_particles_id and not is_bot then
			local first_person_extension = self.first_person_extension
			self.onscreen_particles_id = first_person_extension.create_screen_particles(first_person_extension, "fx/screenspace_overheat_indicator")
			self.critical_onscreen_particles_id = first_person_extension.create_screen_particles(first_person_extension, "fx/screenspace_overheat_critical")
		end

		local onscreen_particles_id = self.onscreen_particles_id

		if onscreen_particles_id then
			local charge_effect_material_name = "overlay"
			local charge_effect_material_variable_name = "intensity"

			World.set_particles_material_scalar(world, onscreen_particles_id, charge_effect_material_name, charge_effect_material_variable_name, overcharge_scalar*self._screen_particle_opacity_modifier)

			local critical_onscreen_particles_id = self.critical_onscreen_particles_id

			if self.is_above_critical_limit(self) then
				local critical_scalar = math.min(1, (self.overcharge_value - self.overcharge_critical_limit)/(self.max_value - self.overcharge_critical_limit)*2)

				World.set_particles_material_scalar(world, critical_onscreen_particles_id, charge_effect_material_name, charge_effect_material_variable_name, critical_scalar*self._screen_particle_opacity_modifier)
			else
				World.set_particles_material_scalar(world, critical_onscreen_particles_id, charge_effect_material_name, charge_effect_material_variable_name, 0)
			end
		end
	end

	return 
end
OverChargeExtension.add_charge = function (self, overcharge_type, charge_level)
	if script_data.disable_overcharge then
		return 
	end

	fassert(PlayerUnitStatusSettings.overcharge_values[overcharge_type], "Invalid overcharge type %q.", overcharge_type)

	local network_manager = self.network_manager
	local threshold = self.overcharge_threshold
	local current_overcharge_value = self.overcharge_value
	local buff_extension = self.buff_extension
	local overcharge_amount = PlayerUnitStatusSettings.overcharge_values[overcharge_type]

	if charge_level then
		overcharge_amount = overcharge_amount*0.4 + overcharge_amount*0.6*charge_level
	end

	overcharge_amount = self.buff_extension:apply_buffs_to_value(overcharge_amount, StatBuffIndex.REDUCED_OVERCHARGE)

	if current_overcharge_value <= self.max_value*0.97 and self.max_value < current_overcharge_value + overcharge_amount then
		OverChargeExtension:hud_sound(self.overcharge_warning_critical_sound_event or "staff_overcharge_warning_critical", self.first_person_extension)

		current_overcharge_value = self.max_value - 0.1
	else
		current_overcharge_value = math.min(current_overcharge_value + overcharge_amount, self.max_value)
	end

	if self.max_value <= current_overcharge_value then
		local unit = self.owner_unit

		StatusUtils.set_overcharge_exploding(unit, true)

		self.is_exploding = true
		local overcharged_critical_buff_id = self.overcharged_critical_buff_id
		local overcharged_buff_id = self.overcharged_buff_id

		if overcharged_critical_buff_id then
			buff_extension.remove_buff(buff_extension, overcharged_critical_buff_id)

			self.overcharged_critical_buff_id = nil
		end

		if overcharged_buff_id and self.overcharge_value < self.overcharge_limit then
			buff_extension.remove_buff(buff_extension, overcharged_buff_id)

			self.overcharged_buff_id = nil
		end
	elseif threshold <= current_overcharge_value then
		local unit = self.owner_unit

		if not self.above_threshold then
			self.above_threshold = true
			local wwise_world = Managers.world:wwise_world(self.world)

			WwiseWorld.trigger_event(wwise_world, self.hit_overcharge_threshold_sound)
			OverChargeExtension:hud_sound(self.overcharge_warning_low_sound_event or "staff_overcharge_warning_low", self.first_person_extension)
			Unit.flow_event(self.unit, "above_overcharge_threshold")
			Unit.flow_event(self.first_person_mesh_unit, "above_overcharge_threshold")
			Unit.flow_event(self.first_person_unit, "above_overcharge_threshold")

			if self.left_unit then
				Unit.flow_event(self.left_unit, "above_overcharge_threshold")
			end
		end

		if self.overcharge_critical_limit <= current_overcharge_value and not self.overcharged_critical_buff_id then
			local overcharged_buff_id = self.overcharged_buff_id

			if overcharged_buff_id then
				buff_extension.remove_buff(buff_extension, overcharged_buff_id)

				self.overcharged_buff_id = false

				OverChargeExtension:hud_sound(self.overcharge_warning_high_sound_event or "staff_overcharge_warning_high", self.first_person_extension)
			end

			self.overcharged_critical_buff_id = buff_extension.add_buff(buff_extension, "overcharged_critical")
		elseif self.overcharge_limit <= current_overcharge_value then
			local dialogue_input = ScriptUnit.extension_input(self.owner_unit, "dialogue_system")
			local event_data = FrameTable.alloc_table()
			local event_name = "overcharge"

			dialogue_input.trigger_dialogue_event(dialogue_input, event_name, event_data)

			if not self.overcharged_buff_id and not self.overcharged_critical_buff_id then
				OverChargeExtension:hud_sound(self.overcharge_warning_med_sound_event or "staff_overcharge_warning_med", self.first_person_extension)

				self.overcharged_buff_id = buff_extension.add_buff(buff_extension, "overcharged")
			end
		end
	end

	self.time_when_overcharge_start_decreasing = Managers.time:time("game") + self.time_until_overcharge_decreases
	self.overcharge_value = current_overcharge_value

	return 
end
OverChargeExtension.remove_charge = function (self, amount)
	self.overcharge_value = math.max(self.overcharge_value - amount, 0)

	return 
end
OverChargeExtension.hud_sound = function (self, event, fp_extension)
	fp_extension.play_hud_sound_event(fp_extension, event)

	return 
end
OverChargeExtension.get_overcharge_value = function (self)
	return self.overcharge_value
end
OverChargeExtension.is_above_critical_limit = function (self)
	return self.overcharge_critical_limit <= self.overcharge_value
end
OverChargeExtension.get_max_value = function (self)
	return self.max_value
end
OverChargeExtension.get_overcharge_threshold = function (self)
	return self.overcharge_threshold
end
OverChargeExtension.above_overcharge_threshold = function (self)
	return self.overcharge_threshold <= self.overcharge_value
end
OverChargeExtension.are_you_exploding = function (self)
	return self.is_exploding
end
OverChargeExtension.overcharge_fraction = function (self)
	return self.overcharge_value/self.max_value
end
OverChargeExtension.threshold_fraction = function (self)
	return self.overcharge_threshold/self.max_value
end
OverChargeExtension.vent_overcharge = function (self)
	self.venting_overcharge = true

	if 0 < self.overcharge_value then
		self.vent_damage_pool = 20
	else
		self.vent_damage_pool = 0
	end

	self.venting_anim = "cooldown_start"

	return 
end
OverChargeExtension.vent_overcharge_done = function (self)
	self.venting_overcharge = false
	self.venting_anim = "cooldown_end"

	return 
end
OverChargeExtension.get_anim_blend_overcharge = function (self)
	return math.clamp((self.overcharge_value - self.overcharge_threshold)/(self.max_value - self.overcharge_threshold), 0, 1)
end

return 
