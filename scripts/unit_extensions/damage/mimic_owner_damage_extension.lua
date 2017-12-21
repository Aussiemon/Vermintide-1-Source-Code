MimicOwnerDamageExtension = class(MimicOwnerDamageExtension, GenericUnitDamageExtension)
MimicOwnerDamageExtension.init = function (self, extension_init_context, unit, extension_init_data)
	MimicOwnerDamageExtension.super.init(self, extension_init_context, unit, extension_init_data)

	local owner_unit = extension_init_data.owner_unit
	self.owner_unit = owner_unit
	self.owner_unit_damage_extension = ScriptUnit.extension(owner_unit, "damage_system")
	self.ignore_heals = extension_init_data.ignore_heals
	self.ignored_damage_types = extension_init_data.ignored_damage_types

	return 
end
MimicOwnerDamageExtension.update = function (self, unit, input, dt, context, t)
	local owner_unit_damage_extension = self.owner_unit_damage_extension
	local recent_damages, num_damages = owner_unit_damage_extension.recent_damages(owner_unit_damage_extension)

	if num_damages == 0 then
		return 
	end

	local ignore_heals = self.ignore_heals

	for i = 1, num_damages/DamageDataIndex.STRIDE, 1 do
		local j = (i - 1)*DamageDataIndex.STRIDE
		local attacker_unit = recent_damages[j + DamageDataIndex.ATTACKER]
		local damage_amount = recent_damages[j + DamageDataIndex.DAMAGE_AMOUNT]
		local damage_type = recent_damages[j + DamageDataIndex.DAMAGE_TYPE]
		local ignore_damage_type = self.ignored_damage_types[damage_type]

		if not ignore_damage_type then
			if damage_type == "heal" then
				self.heal(self, attacker_unit, -damage_amount)
			else
				local hit_zone_name = recent_damages[j + DamageDataIndex.HIT_ZONE]
				local damage_direction = Vector3Aux.unbox(recent_damages[j + DamageDataIndex.DIRECTION])
				local damage_source_name = recent_damages[j + DamageDataIndex.DAMAGE_SOURCE_NAME]

				self.add_damage(self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name)
			end
		end
	end

	return 
end

return 
