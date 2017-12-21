script_data.damage_debug = script_data.damage_debug or Development.parameter("damage_debug")
local data_fields = {
	"DAMAGE_AMOUNT",
	"DAMAGE_TYPE",
	"ATTACKER",
	"HIT_ZONE",
	"DIRECTION",
	"DAMAGE_SOURCE_NAME",
	"HIT_RAGDOLL_ACTOR_NAME",
	"DAMAGING_UNIT"
}
DamageDataIndex = {}
local DamageDataIndex = DamageDataIndex

for index, field_name in ipairs(data_fields) do
	DamageDataIndex[field_name] = index
end

DamageDataIndex.STRIDE = #data_fields
data_fields = nil
GenericUnitDamageExtension = class(GenericUnitDamageExtension)
GenericUnitDamageExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.system_data = extension_init_context.system_data
	self.unit = unit
	self.damage_buffers = {
		pdArray.new(),
		pdArray.new()
	}
	self.statistics_db = extension_init_context.statistics_db
	self._recent_damage_type = nil

	return 
end
GenericUnitDamageExtension.destroy = function (self)
	return 
end
GenericUnitDamageExtension.reset = function (self)
	pdArray.set_empty(self.damage_buffers[1])
	pdArray.set_empty(self.damage_buffers[2])

	return 
end
GenericUnitDamageExtension.update = function (self, unit, input, dt, context, t)
	assert(false)

	return 
end
local my_temp_table = {}
GenericUnitDamageExtension.add_damage = function (self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name, hit_ragdoll_actor, damaging_unit)
	local damage_direction_table = {
		damage_direction.x,
		damage_direction.y,
		damage_direction.z
	}
	local damage_queue = self.damage_buffers[self.system_data.active_damage_buffer_index]
	local temp_table = my_temp_table
	temp_table[DamageDataIndex.DAMAGE_AMOUNT] = damage_amount
	temp_table[DamageDataIndex.DAMAGE_TYPE] = damage_type
	temp_table[DamageDataIndex.ATTACKER] = attacker_unit
	temp_table[DamageDataIndex.HIT_ZONE] = hit_zone_name
	temp_table[DamageDataIndex.DIRECTION] = damage_direction_table
	temp_table[DamageDataIndex.DAMAGE_SOURCE_NAME] = damage_source_name or "n/a"
	temp_table[DamageDataIndex.HIT_RAGDOLL_ACTOR_NAME] = hit_ragdoll_actor or "n/a"
	temp_table[DamageDataIndex.DAMAGING_UNIT] = damaging_unit or "n/a"

	pdArray.push_back8(damage_queue, unpack(temp_table))

	if script_data.damage_debug then
		printf("[GenericUnitDamageExtension] add_damage %.1f on zone '%s' to %s by %s", damage_amount, hit_zone_name, tostring(self.unit), tostring(attacker_unit))
	end

	StatisticsUtil.register_damage(self.unit, temp_table, self.statistics_db)
	assert(damage_type, "No damage_type!")

	self._recent_damage_type = damage_type

	return 
end
GenericUnitDamageExtension.heal = function (self, attacker_unit, heal_amount, heal_source_name)
	local damage_queue = self.damage_buffers[self.system_data.active_damage_buffer_index]
	local temp_table = my_temp_table
	temp_table[DamageDataIndex.DAMAGE_AMOUNT] = -heal_amount
	temp_table[DamageDataIndex.DAMAGE_TYPE] = "heal"
	temp_table[DamageDataIndex.ATTACKER] = attacker_unit
	temp_table[DamageDataIndex.HIT_ZONE] = nil
	temp_table[DamageDataIndex.DIRECTION] = nil
	temp_table[DamageDataIndex.DAMAGE_SOURCE_NAME] = heal_source_name or "n/a"
	temp_table[DamageDataIndex.HIT_RAGDOLL_ACTOR_NAME] = "n/a"
	temp_table[DamageDataIndex.DAMAGING_UNIT] = "n/a"

	pdArray.push_back8(damage_queue, unpack(temp_table))

	if script_data.damage_debug then
		printf("[GenericUnitDamageExtension] heal %.1f to %s by %s", heal_amount, tostring(self.unit), tostring(attacker_unit))
	end

	return 
end
GenericUnitDamageExtension.get_damage_after_shield = function (self, damage)
	return damage
end
GenericUnitDamageExtension.has_assist_shield = function (self)
	return false
end
GenericUnitDamageExtension.recent_damages = function (self)
	local previous_buffer_index = self.system_data.active_damage_buffer_index - 3
	local damage_queue = self.damage_buffers[previous_buffer_index]

	return pdArray.data(damage_queue)
end
GenericUnitDamageExtension.recently_damaged = function (self)
	return self._recent_damage_type
end

return 
