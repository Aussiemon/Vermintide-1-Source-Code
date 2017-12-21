PlayerUnitHealthExtension = class(PlayerUnitHealthExtension, GenericHealthExtension)
PlayerUnitHealthExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	local is_server = Managers.player.is_server
	self.is_server = is_server
	self.player = extension_init_data.player
	self.is_bot = not self.player:is_player_controlled()
	local max_health = extension_init_data.health
	local game_object_id = extension_init_data.game_object_id

	if (not max_health or max_health < 1) and not game_object_id then
		ScriptApplication.send_to_crashify("PlayerUnitHealthExtension", "Initialized local extension with invalid max health value %q, is bot: %s", tostring(max_health), tostring(self.is_bot))

		local difficulty_manager = Managers.state.difficulty
		local difficulty_settings = difficulty_manager.get_difficulty_settings(difficulty_manager)
		max_health = difficulty_settings.max_hp
	end

	self._initial_max_health = max_health

	self.set_max_health(self, max_health, true)

	self.unmodified_max_health_changed = false
	self.damage = extension_init_data.damage or 0
	self.state = "alive"
	self.game_object_id = game_object_id

	return 
end
PlayerUnitHealthExtension.initial_max_health = function (self)
	return self._initial_max_health
end
PlayerUnitHealthExtension.sync_health_state = function (self, game_object_id)
	local player = self.player
	local health_state, damage, ammo = Managers.state.spawn:get_status(player)

	if script_data.network_debug then
		printf("PlayerUnitHealthExtension:sync_health_state() health_state (%s) damage (%s), ammo (%s)", health_state, tostring(damage), tostring(ammo))
	end

	if health_state == nil then
		print("[PlayerUnitHealthExtension] Spawn manager returned nil value for spawn state, killing character. player:", player)
		table.dump(player)

		self.damage = 1000
	else
		if health_state == "knocked_down" then
			self._knock_down(self, self.unit)
		end

		if health_state ~= "dead" then
			damage = NetworkUtils.get_network_safe_damage_hotjoin_sync(damage)
			self.damage = damage
			local state = NetworkLookup.health_statuses[self.state]
			local is_level_unit = false

			Managers.state.network.network_transmit:send_rpc_clients("rpc_sync_damage_taken", game_object_id, is_level_unit, damage, state)
		end
	end

	return 
end
PlayerUnitHealthExtension.extensions_ready = function (self, world, unit)
	self.status_extension = ScriptUnit.extension(unit, "status_system")
	local game_object_id = self.game_object_id

	if self.is_server and game_object_id then
		self.sync_health_state(self, game_object_id)
	end

	return 
end
PlayerUnitHealthExtension._knock_down = function (self, unit)
	self.state = "knocked_down"

	StatusUtils.set_knocked_down_network(unit, true)
	StatusUtils.set_wounded_network(unit, false, "knocked_down")

	return 
end
PlayerUnitHealthExtension.update = function (self, dt, context, t)
	local status_extension = self.status_extension
	local state = self.state
	local unit = self.unit

	if self.is_server then
		if state == "alive" then
			if self._should_die(self) then
				if not status_extension.has_wounds_remaining(status_extension) then
					self.die(self)

					return 
				elseif not status_extension.is_knocked_down(status_extension) then
					self._knock_down(self, unit)

					return 
				end
			end
		elseif state == "knocked_down" then
			if self._should_die(self) then
				self.die(self, "knockdown_death")

				return 
			elseif status_extension.is_revived(status_extension) then
				self.state = "alive"

				StatusUtils.set_knocked_down_network(unit, false)
				StatusUtils.set_wounded_network(unit, true, "revived", t)
				StatusUtils.set_revived_network(unit, false)

				return 
			end
		end
	end

	self.unmodified_max_health_changed = false

	return 
end
PlayerUnitHealthExtension.set_max_health = function (self, health, update_unmodfied)
	if update_unmodfied then
		self.unmodified_max_health = health
		self.unmodified_max_health_changed = true
	end

	self.health = health

	if health == 0 then
		print(Script.callstack())
		fassert(false, "[GenericHealthExtension] - Trying to set health to zero")
	end

	return 
end
PlayerUnitHealthExtension.add_damage = function (self, damage)
	if not script_data.player_invincible then
		self.damage = math.clamp(self.damage + damage, 0, self.health)
	end

	return 
end
PlayerUnitHealthExtension._should_die = function (self)
	return self.health <= self.damage
end
PlayerUnitHealthExtension.is_alive = function (self)
	return not self.status_extension:is_dead()
end
PlayerUnitHealthExtension.die = function (self, damage_type)
	damage_type = damage_type or "undefined"
	local unit = self.unit

	if self.is_server and self.is_bot and damage_type == "volume_insta_kill" then
		local blackboard = Unit.get_data(unit, "blackboard")

		for _, player_pos in ipairs(PLAYER_POSITIONS) do
			local pos = LocomotionUtils.new_random_goal_uniformly_distributed(blackboard.nav_world, nil, player_pos, 2, 5, 5)

			if pos then
				local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

				locomotion_extension.teleport_to(locomotion_extension, pos)
				ScriptUnit.extension(unit, "ai_navigation_system"):teleport(pos)
				ScriptUnit.extension(unit, "ai_system"):clear_failed_paths()

				return 
			end
		end
	end

	if self.is_server and damage_type == "volume_insta_kill" then
		self._update_missions(self)
	end

	if self.is_server then
		self.state = "dead"

		StatusUtils.set_dead_network(unit, true)
		SurroundingAwareSystem.add_event(unit, "player_death", DialogueSettings.death_discover_distance, "target", unit, "target_name", ScriptUnit.extension(unit, "dialogue_system").context.player_profile)
	end

	return 
end
PlayerUnitHealthExtension._update_missions = function (self)
	local unit = self.unit
	local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
	local equipment = inventory_extension.equipment(inventory_extension)
	local mission_system = Managers.state.entity:system("mission_system")
	local has_grimoire, has_tome = nil
	local slot_potion_data = equipment.slots.slot_potion

	if slot_potion_data and slot_potion_data.item_data.name == "wpn_grimoire_01" then
		has_grimoire = true
	end

	local slot_healthkit_data = equipment.slots.slot_healthkit

	if slot_healthkit_data and slot_healthkit_data.item_data.name == "wpn_side_objective_tome_01" then
		has_tome = true
	end

	if has_grimoire then
		mission_system.increment_goal_mission_counter(mission_system, "cemetery_tome_and_grim_bury", 1, true)
	end

	if has_tome then
		mission_system.increment_goal_mission_counter(mission_system, "cemetery_tome_and_grim_bury", 1, true)
	end

	return 
end

return 
