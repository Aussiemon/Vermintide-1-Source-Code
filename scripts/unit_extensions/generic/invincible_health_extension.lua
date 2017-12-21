InvincibleHealthExtension = class(InvincibleHealthExtension, GenericHealthExtension)
InvincibleHealthExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.is_server = Managers.player.is_server
	self.health = NetworkConstants.health.max
	self.damage = 0
	self.damage_extension = nil
	self.state = "alive"

	return 
end
InvincibleHealthExtension.destroy = function (self)
	return 
end
InvincibleHealthExtension.reset = function (self)
	return 
end
InvincibleHealthExtension.is_alive = function (self)
	return true
end
InvincibleHealthExtension.current_health_percent = function (self)
	return 1
end
InvincibleHealthExtension.current_health = function (self)
	return self.health
end
InvincibleHealthExtension.get_max_health = function (self)
	return self.health
end
InvincibleHealthExtension.add_heal = function (self, heal_amount)
	return 
end
InvincibleHealthExtension.add_damage = function (self, damage)
	return 
end
InvincibleHealthExtension.set_current_damage = function (self, damage)
	return 
end
InvincibleHealthExtension.die = function (self, damage_type)
	assert(false, "Tried to kill InvincibleHealthExtension")

	return 
end

return 
