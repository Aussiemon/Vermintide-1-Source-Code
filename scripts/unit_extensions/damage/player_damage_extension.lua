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

	return 
end
PlayerDamageExtension.update = function (self, unit, input, dt, context, t)
	if 0 < self._shield_duration_left then
		self._shield_duration_left = self._shield_duration_left - dt
	elseif not self._end_reason then
		self.remove_assist_shield(self, "timed_out")
	end

	return 
end
local my_temp_table = {}
PlayerDamageExtension.add_damage = function (self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name, hit_ragdoll_actor, damaging_unit)
	PlayerDamageExtension.super.add_damage(self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name, hit_ragdoll_actor, damaging_unit)

	if GameSettingsDevelopment.use_telemetry then
		self._add_player_damage_telemetry(self, damage_type, damage_source_name or "n/a")
	end

	return 
end
PlayerDamageExtension._add_player_damage_telemetry = function (self, damage_type, damage_source)
	local player_manager = Managers.player
	local unit = self.unit
	local owner = player_manager.owner(player_manager, unit)
	local network_manager = Managers.state.network
	local is_server = network_manager.is_server

	if owner then
		local local_player = owner.local_player
		local is_bot = owner.bot_player

		if (is_bot and is_server) or local_player then
			local telemetry_id = owner.telemetry_id(owner)
			local position = POSITION_LOOKUP[unit]
			local hero = owner.profile_display_name(owner)
			local player_damage_telemetry = self.player_damage_telemetry
			player_damage_telemetry.damage_type = damage_type
			player_damage_telemetry.position = position
			player_damage_telemetry.player_id = telemetry_id
			player_damage_telemetry.hero = hero
			player_damage_telemetry.damage_source = damage_source

			Managers.telemetry:register_event("player_damage", player_damage_telemetry)
		end
	end

	return 
end
PlayerDamageExtension.shield = function (self, shield_amount)
	self._shield_amount = shield_amount
	self._shield_duration_left = 10
	self._end_reason = nil

	if script_data.damage_debug then
		printf("[PlayerDamageExtension] shield %.1f to %s", shield_amount, tostring(self.unit))
	end

	return 
end
PlayerDamageExtension.get_damage_after_shield = function (self, damage)
	if self.has_assist_shield(self) then
		damage = damage - self._shield_amount

		if script_data.damage_debug then
			printf("[PlayerDamageExtension] reduced incoming damage to %s by %.1f", tostring(self.unit), self._shield_amount)
		end

		self.remove_assist_shield(self, "blocked_damage")
	end

	return damage
end
PlayerDamageExtension.has_assist_shield = function (self)
	return 0 < self._shield_duration_left and 0 < self._shield_amount, self._shield_amount
end
PlayerDamageExtension.remove_assist_shield = function (self, end_reason)
	self._shield_duration_left = 0
	self._shield_amount = 0
	self._end_reason = end_reason

	return 
end
PlayerDamageExtension.previous_shield_end_reason = function (self)
	return self._end_reason
end

return 
