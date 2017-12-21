local extensions = {
	"PlayGoTutorialExtension"
}
PlayGoTutorialSystem = class(PlayGoTutorialSystem, ExtensionSystemBase)
PlayGoTutorialSystem.init = function (self, entity_system_creation_context, system_name)
	PlayGoTutorialSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	self._profile_synchronizer = entity_system_creation_context.profile_synchronizer
	self._tutorial_started = false
	self._tutorial_unit = nil
	self._last_slot_name = nil
	self._last_known_attack = nil

	return 
end
PlayGoTutorialSystem.destroy = function (self)
	return 
end
local dummy_input = {}
PlayGoTutorialSystem.on_add_extension = function (self, world, unit, extension_name, ...)
	fassert(self._tutorial_unit == nil, "Multiple tutorial units spawned on level!")

	local extension = {}
	self._tutorial_started = true
	self._tutorial_unit = unit
	script_data.cap_num_bots = 1
	script_data.ai_bots_disabled = true
	local extension_alias = self.NAME

	ScriptUnit.set_extension(unit, extension_alias, extension, dummy_input)

	return extension
end
PlayGoTutorialSystem.on_remove_extension = function (self, unit, extension_name)
	ScriptUnit.remove_extension(unit, self.NAME)

	self._tutorial_started = false
	self._tutorial_unit = nil

	return 
end
PlayGoTutorialSystem.spawn_bot = function (self, profile_index)
	Managers.state.spawn:set_forced_bot_profile_index(profile_index)

	script_data.ai_bots_disabled = false

	return 
end
PlayGoTutorialSystem.update = function (self, context, t)
	if not self._tutorial_started then
		return 
	end

	local player = Managers.player:local_player()

	if not Unit.alive(player.player_unit) then
		return 
	end

	self._update_player_health(self, player)
	self._update_player_ammo(self, player)
	self._capture_wield_switch(self, player)
	self._capture_attacks(self, player)

	return 
end
PlayGoTutorialSystem._update_player_health = function (self, player)
	local player_unit = player.player_unit
	local health_extension = ScriptUnit.extension(player_unit, "health_system")
	local hp_percent = health_extension.current_health_percent(health_extension)

	if hp_percent < 0.2 then
		health_extension.reset(health_extension)
	end

	local local_bots = Managers.player:bots()

	if local_bots[1] then
		local bot_unit = local_bots[1].player_unit

		if Unit.alive(bot_unit) then
			local health_extension = ScriptUnit.extension(bot_unit, "health_system")
			local status_extension = ScriptUnit.extension(bot_unit, "status_system")
			local hp_percent = health_extension.current_health_percent(health_extension)

			if status_extension.is_knocked_down(status_extension) and hp_percent < 1 then
				health_extension.set_current_damage(health_extension, 0)
			end
		end
	end

	return 
end
PlayGoTutorialSystem._capture_wield_switch = function (self, player)
	local player_unit = player.player_unit
	local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")

	if inventory_extension.get_wielded_slot_name(inventory_extension) ~= self._last_slot_name then
		self._last_slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)

		Unit.flow_event(self._tutorial_unit, "lua_wield_switch")
	end

	return 
end
PlayGoTutorialSystem._capture_attacks = function (self, player)
	local player_unit = player.player_unit
	local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
	local equipment = inventory_extension.equipment(inventory_extension)
	local weapon_unit = equipment.right_hand_wielded_unit or equipment.left_hand_wielded_unit

	if weapon_unit then
		local weapon_extension = ScriptUnit.extension(weapon_unit, "weapon_system")

		if weapon_extension.has_current_action(weapon_extension) then
			local action_settings = weapon_extension.get_current_action_settings(weapon_extension)
			self._last_known_attack = action_settings.charge_value
		end
	end

	return 
end
PlayGoTutorialSystem._update_player_ammo = function (self, player)
	local inventory_extension = ScriptUnit.extension(player.player_unit, "inventory_system")
	local current, max = inventory_extension.current_ammo_status(inventory_extension, "slot_ranged")

	if current == 0 then
		local slot_data = inventory_extension.get_slot_data(inventory_extension, "slot_ranged")
		local left_unit_1p = slot_data.left_unit_1p
		local ammo_extension = ScriptUnit.has_extension(left_unit_1p, "ammo_system") and ScriptUnit.extension(left_unit_1p, "ammo_system")

		if ammo_extension then
			ammo_extension.add_ammo(ammo_extension, max)

			if inventory_extension.get_wielded_slot_name(inventory_extension) == "slot_ranged" and ammo_extension.can_reload(ammo_extension) then
				ammo_extension.start_reload(ammo_extension, true)
			end
		end
	end

	return 
end
PlayGoTutorialSystem.register_dodge = function (self, dodge_direction)
	if self._tutorial_started then
		local tutorial_unit = self._tutorial_unit
		local x_value = Vector3.x(dodge_direction)
		local y_value = Vector3.y(dodge_direction)

		if math.abs(x_value) < math.abs(y_value) then
			Unit.flow_event(tutorial_unit, "lua_dodge_backward")
		elseif 0 < x_value then
			Unit.flow_event(tutorial_unit, "lua_dodge_right")
		else
			Unit.flow_event(tutorial_unit, "lua_dodge_left")
		end
	end

	return 
end
PlayGoTutorialSystem.register_push = function (self, hit_unit)
	if self._tutorial_started and Unit.alive(hit_unit) and ScriptUnit.extension(hit_unit, "health_system"):is_alive() then
		Unit.flow_event(self._tutorial_unit, "lua_pushed_enemy")
	end

	return 
end
PlayGoTutorialSystem.register_block = function (self)
	if self._tutorial_started then
		Unit.flow_event(self._tutorial_unit, "lua_blocked_attack")
	end

	return 
end
PlayGoTutorialSystem.register_killing_blow = function (self, damage_type, attacker)
	if self._tutorial_started then
		local local_player = Managers.player:local_player()

		if attacker == local_player.player_unit then
			local tutorial_unit = self._tutorial_unit
			local last_known_attack = self._last_known_attack

			if damage_type == "grenade" or damage_type == "grenade_glance" then
				Unit.flow_event(tutorial_unit, "lua_grenade_attack")
			elseif last_known_attack == "light_attack" then
				Unit.flow_event(tutorial_unit, "lua_light_attack")
			elseif last_known_attack == "heavy_attack" then
				Unit.flow_event(tutorial_unit, "lua_heavy_attack")
			elseif last_known_attack == "arrow_hit" then
				Unit.flow_event(tutorial_unit, "lua_normal_ranged_attack")
			elseif last_known_attack == "zoomed_arrow_hit" then
				Unit.flow_event(tutorial_unit, "lua_alternative_ranged_attack")
			end
		end
	end

	return 
end

return 
