PlayerUnitChargeExtension = class(PlayerUnitChargeExtension)
script_data.charge_debug = script_data.charge_debug or Development.parameter("charge_debug")

PlayerUnitChargeExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.unit = unit
	self.charge_level = 0
	self.played_fully_charged_sound = false
end

PlayerUnitChargeExtension.reset = function (self)
	self.charge_level = 0
	self.played_fully_charged_sound = false
end

PlayerUnitChargeExtension.extensions_ready = function (self, world, unit)
	self.buff_extension = ScriptUnit.extension(unit, "buff_system")
end

PlayerUnitChargeExtension.destroy = function (self)
	return
end

PlayerUnitChargeExtension.update = function (self, unit, input, dt, context, t)
	if script_data.charge_debug then
		if DebugKeyHandler.key_pressed("v", "fill charge") then
			self:add_charge("debug_full")
		end

		Debug.text("Charge level: " .. tostring(self.charge_level))
	end
end

PlayerUnitChargeExtension.add_charge = function (self, charge_type)
	assert(PlayerUnitStatusSettings.charge_values_offensive[charge_type] or PlayerUnitStatusSettings.charge_values_defensive[charge_type])

	local experience = ExperienceSettings.max_experience
	local prestige = 0
	local backend_manager = Managers.backend

	if backend_manager:profiles_loaded() then
		experience = ScriptBackendProfileAttribute.get("experience")
	end

	local level = ExperienceSettings.get_level(experience)
	local stance_unlocked = ProgressionUnlocks.is_unlocked("stance", level, prestige)

	if not stance_unlocked and not script_data.charge_debug then
		return
	end

	local buff_extension = self.buff_extension

	if buff_extension:has_buff_type("stance") then
		return
	end

	local charge = PlayerUnitStatusSettings.charge_values_offensive[charge_type]

	if charge then
		if buff_extension:has_buff_type("no_offensive_charge_increase") then
			return
		else
			charge = buff_extension:apply_buffs_to_value(charge, StatBuffIndex.OFFENSIVE_CHARGE)
		end
	elseif buff_extension:has_buff_type("no_defensive_charge_increase") then
		return
	else
		charge = PlayerUnitStatusSettings.charge_values_defensive[charge_type]
		charge = buff_extension:apply_buffs_to_value(charge, StatBuffIndex.DEFENSIVE_CHARGE)
	end

	self.charge_level = math.clamp(self.charge_level + charge, 0, 1)

	if self.charge_level == 1 and not self.played_fully_charged_sound then
		local wwise_world = Managers.world:wwise_world(self.world)

		WwiseWorld.trigger_event(wwise_world, "ui_special_attack_ready")

		self.played_fully_charged_sound = true
	end
end

PlayerUnitChargeExtension.get_charge_level = function (self)
	return self.charge_level
end

PlayerUnitChargeExtension.charge_is_full = function (self)
	return self.charge_level == 1
end

return
