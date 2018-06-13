PlayerDamageExtension = class(PlayerDamageExtension, GenericUnitDamageExtension)

PlayerDamageExtension.init = function (self, extension_init_context, unit, extension_init_data)
	PlayerDamageExtension.super.init(self, extension_init_context, unit, extension_init_data)

	self._shield_amount = 0
	self._shield_duration_left = 0
	self._end_reason = ""
	self.statistics_db = extension_init_context.statistics_db
	self.player_damage_telemetry = {
		hero = "",
		player_id = "",
		damage_type = "",
		position = Vector3.zero()
	}
	self._level_key = Managers.state.game_mode:level_key()
	self._mission_system = Managers.state.entity:system("mission_system")
end

PlayerDamageExtension.update = function (self, unit, input, dt, context, t)
	if self._shield_duration_left > 0 then
		self._shield_duration_left = self._shield_duration_left - dt
	elseif not self._end_reason then
		self:remove_assist_shield("timed_out")
	end
end

local my_temp_table = {}

PlayerDamageExtension.add_damage = function (self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name, hit_ragdoll_actor, damaging_unit)
	PlayerDamageExtension.super.add_damage(self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name, hit_ragdoll_actor, damaging_unit)

	local player_manager = Managers.player
	local unit = self.unit
	local owner = player_manager:owner(unit)

	if Managers.state.controller_features and owner.local_player and damage_amount > 0 then
		Managers.state.controller_features:add_effect("hit_rumble", {
			damage_amount = damage_amount,
			unit = unit
		})
	end

	if Managers.state.network.is_server and self._level_key == "dlc_dwarf_exterior" then
		self._mission_system:increment_goal_mission_counter("dwarf_exterior_survive", math.max(damage_amount, 0), true)
	end

	self:_add_player_damage_telemetry(damage_type, damage_source_name or "n/a")
end

PlayerDamageExtension._add_player_damage_telemetry = function (self, damage_type, damage_source)
	local unit = self.unit
	local owner = Managers.player:owner(unit)
	local is_server = Managers.state.network.is_server

	if owner then
		local local_player = owner.local_player
		local is_bot = owner.bot_player

		if (is_bot and is_server) or local_player then
			local position = POSITION_LOOKUP[unit]

			Managers.telemetry.events:player_damage(owner, damage_type, damage_source, position)
		end
	end
end

PlayerDamageExtension.shield = function (self, shield_amount)
	self._shield_amount = shield_amount
	self._shield_duration_left = 10
	self._end_reason = nil

	if script_data.damage_debug then
		printf("[PlayerDamageExtension] shield %.1f to %s", shield_amount, tostring(self.unit))
	end
end

PlayerDamageExtension.get_damage_after_shield = function (self, damage)
	if self:has_assist_shield() then
		damage = damage - self._shield_amount

		if script_data.damage_debug then
			printf("[PlayerDamageExtension] reduced incoming damage to %s by %.1f", tostring(self.unit), self._shield_amount)
		end

		self:remove_assist_shield("blocked_damage")
	end

	return damage
end

PlayerDamageExtension.has_assist_shield = function (self)
	return self._shield_duration_left > 0 and self._shield_amount > 0, self._shield_amount
end

PlayerDamageExtension.remove_assist_shield = function (self, end_reason)
	self._shield_duration_left = 0
	self._shield_amount = 0
	self._end_reason = end_reason
end

PlayerDamageExtension.previous_shield_end_reason = function (self)
	return self._end_reason
end

return
