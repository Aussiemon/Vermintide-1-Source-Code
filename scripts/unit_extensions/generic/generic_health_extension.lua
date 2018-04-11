require("scripts/unit_extensions/generic/hit_reactions")

GenericHealthExtension = class(GenericHealthExtension)
GenericHealthExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.is_server = Managers.player.is_server
	local health = extension_init_data.health or Unit.get_data(unit, "health")

	if health == -1 then
		self.is_invincible = true
		health = math.huge

		if script_data.damage_debug then
			printf("[GenericUnitDamageExtension] No health information for unit %s", tostring(unit))
		end
	else
		self.is_invincible = false
	end

	self.set_max_health(self, health, true)

	self.unmodified_max_health_changed = false
	self.damage = extension_init_data.damage or 0
	self.state = "alive"
	self.instakill = false

	return 
end
GenericHealthExtension.extensions_ready = function (self, world, unit)
	return 
end
GenericHealthExtension.destroy = function (self)
	return 
end
GenericHealthExtension.reset = function (self)
	self.damage = 0
	self.state = "alive"

	return 
end
GenericHealthExtension.update = function (self, dt, context, t)
	self.unmodified_max_health_changed = false

	return 
end
GenericHealthExtension.is_alive = function (self)
	return self.damage < self.health
end
GenericHealthExtension.current_health_percent = function (self)
	return 1 - self.damage / self.health
end
GenericHealthExtension.current_health = function (self)
	return self.health - self.damage
end
GenericHealthExtension.current_damage = function (self)
	return self.damage
end
GenericHealthExtension.get_max_health = function (self)
	if self.is_invincible then
		return 0
	else
		return self.health
	end

	return 
end
GenericHealthExtension.set_max_health = function (self, health, update_unmodfied)
	if update_unmodfied then
		self.unmodified_max_health = health
		self.unmodified_max_health_changed = true
	end

	self.health = health

	return 
end
GenericHealthExtension.add_heal = function (self, heal_amount)
	self.damage = math.max(0, self.damage - heal_amount)

	return 
end
GenericHealthExtension.add_damage = function (self, damage)
	if not self.is_invincible then
		self.instakill = self.health <= damage and self.damage == 0
		self.damage = self.damage + damage
	end

	return 
end
GenericHealthExtension.set_current_damage = function (self, damage)
	self.damage = damage

	return 
end
GenericHealthExtension.die = function (self, damage_type)
	if self.is_server then
		local unit = self.unit

		if ScriptUnit.has_extension(unit, "ai_system") then
			damage_type = damage_type or "undefined"

			AiUtils.kill_unit(unit, nil, nil, damage_type, nil)
		end
	end

	return 
end

return 
