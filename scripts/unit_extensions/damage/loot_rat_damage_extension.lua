require("scripts/unit_extensions/generic/generic_unit_damage_extension")

LootRatDamageExtension = class(LootRatDamageExtension, GenericUnitDamageExtension)

LootRatDamageExtension.init = function (self, extension_init_context, unit, extension_init_data)
	LootRatDamageExtension.super.init(self, extension_init_context, unit, extension_init_data)

	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.dodge_damage_points = blackboard.breed.dodge_damage_points
	blackboard.dodge_damage_success = false
	self.blackboard = blackboard
end

LootRatDamageExtension.destroy = function (self)
	LootRatDamageExtension.super.destroy(self)

	self.blackboard = nil
end

LootRatDamageExtension.add_damage = function (self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name, hit_ragdoll_actor)
	local blackboard = self.blackboard
	local dodge_points = blackboard.dodge_damage_points
	local dodge_success = false

	if blackboard.is_dodging then
		dodge_points = math.max(dodge_points - damage_amount, 0)

		if dodge_points > 0 then
			dodge_success = true
		end

		blackboard.dodge_damage_points = dodge_points
	end

	if not dodge_success then
		LootRatDamageExtension.super.add_damage(self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name, hit_ragdoll_actor)
	end

	blackboard.dodge_damage_success = dodge_success
end

LootRatDamageExtension.regen_dodge_damage_points = function (self)
	local blackboard = self.blackboard
	blackboard.dodge_damage_points = blackboard.breed.dodge_damage_points
end

return
