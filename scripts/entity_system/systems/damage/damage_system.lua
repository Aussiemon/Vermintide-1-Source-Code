require("scripts/unit_extensions/generic/generic_unit_damage_extension")
require("scripts/unit_extensions/damage/mimic_owner_damage_extension")
require("scripts/unit_extensions/damage/loot_rat_damage_extension")
require("scripts/unit_extensions/damage/player_damage_extension")
require("scripts/settings/explosion_templates")

DamageSystem = class(DamageSystem, ExtensionSystemBase)
local RPCS = {
	"rpc_add_damage",
	"rpc_request_heal",
	"rpc_heal",
	"rpc_area_damage",
	"rpc_add_damage_multiple",
	"rpc_take_falling_damage",
	"rpc_suicide",
	"rpc_level_object_damage",
	"rpc_level_object_heal",
	"rpc_add_damage_network",
	"rpc_create_explosion",
	"rpc_remove_assist_shield"
}
local extensions = {
	"GenericUnitDamageExtension",
	"PlayerDamageExtension",
	"MimicOwnerDamageExtension",
	"LootRatDamageExtension"
}
DamageSystem.init = function (self, entity_system_creation_context, system_name)
	DamageSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))

	self.extension_unit_data = {}
	self.inherited_extension_unit_data = {}
	self.active_damage_buffer_index = 1
	self.extension_init_context.system_data = self

	return 
end
DamageSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)

	return 
end
local dummy_input = {}
DamageSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local extension = DamageSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data)

	if extension_name == "GenericUnitDamageExtension" or extension_name == "LootRatDamageExtension" then
		self.extension_unit_data[unit] = extension
	end

	if extension_name == "PlayerDamageExtension" or extension_name == "MimicOwnerDamageExtension" then
		self.extension_unit_data[unit] = extension
		self.inherited_extension_unit_data[unit] = extension
	end

	return extension
end
DamageSystem.on_remove_extension = function (self, unit, extension_name)
	DamageSystem.super.on_remove_extension(self, unit, extension_name)

	self.extension_unit_data[unit] = nil

	return 
end
local debug_found_units = {}
DamageSystem.update = function (self, context, t)
	local pdArray_set_empty = pdArray.set_empty
	self.active_damage_buffer_index = self.active_damage_buffer_index - 3
	local active_damage_buffer_index = self.active_damage_buffer_index

	for unit, extension in pairs(self.extension_unit_data) do
		local damage_queue = extension.damage_buffers[active_damage_buffer_index]

		pdArray_set_empty(damage_queue)

		extension._recent_damage_type = nil
	end

	local dt = context.dt
	local dummy_input = dummy_input

	for unit, extension in pairs(self.inherited_extension_unit_data) do
		extension.update(extension, unit, dummy_input, dt, context, t)
	end

	if self.is_server and DebugKeyHandler.key_pressed("q", "Deal damage to enemies", "DamageSystem", "left ctrl") then
		local local_player = Managers.player:local_player()
		local player_unit = local_player.player_unit
		local ai_system = Managers.state.entity:system("ai_system")
		local num_units = Broadphase.query(ai_system.broadphase, POSITION_LOOKUP[player_unit], 10, debug_found_units)

		table.dump(debug_found_units, "debug_found_units", 5)

		local damage_system = Managers.state.entity:system("damage_system")
		local network_manager = Managers.state.network
		local player_unit_id = network_manager.unit_game_object_id(network_manager, player_unit)
		local player_unit_pos = Unit.world_position(player_unit, 0)
		local hit_zone_id = NetworkLookup.hit_zones.full
		local damage_type_id = NetworkLookup.damage_types.undefined
		local damage_source_id = NetworkLookup.damage_sources.debug

		for i = 1, num_units, 1 do
			local unit = debug_found_units[i]
			local unit_pos = Unit.world_position(unit, 0)
			local damage_direction = Vector3.normalize(unit_pos - player_unit_pos)
			local unit_id = network_manager.unit_game_object_id(network_manager, unit)

			damage_system.rpc_add_damage_network(damage_system, nil, unit_id, player_unit_id, false, 255, hit_zone_id, damage_type_id, damage_direction, damage_source_id)
		end
	end

	return 
end
DamageSystem.rpc_add_damage_network = function (self, sender, victim_unit_go_id, attacker_unit_go_id, attacker_is_level_unit, damage_amount, hit_zone_id, damage_type_id, damage_direction, damage_source_id)
	assert(self.is_server, "Tried sending rpc_add_damage_network to something other than the server")

	local unit_storage = self.unit_storage
	local victim_unit = unit_storage.unit(unit_storage, victim_unit_go_id)
	local attacker_unit = nil

	if attacker_is_level_unit then
		attacker_unit = LevelHelper:unit_by_index(self.world, attacker_unit_go_id)
	else
		attacker_unit = self.unit_storage:unit(attacker_unit_go_id)
	end

	local hit_zone_name = NetworkLookup.hit_zones[hit_zone_id]
	local damage_type = NetworkLookup.damage_types[damage_type_id]
	local damage_source = NetworkLookup.damage_sources[damage_source_id]

	if not Unit.alive(victim_unit) then
		return 
	end

	DamageUtils.add_damage_network(victim_unit, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source)

	return 
end
DamageSystem.rpc_add_damage = function (self, sender, victim_unit_go_id, attacker_unit_go_id, attacker_is_level_unit, damage_amount, hit_zone_id, damage_type_id, damage_direction, damage_source_id, hit_ragdoll_actor_id)
	local victim_unit = self.unit_storage:unit(victim_unit_go_id)
	local attacker_unit = nil

	if attacker_is_level_unit then
		attacker_unit = LevelHelper:unit_by_index(self.world, attacker_unit_go_id)
	else
		attacker_unit = self.unit_storage:unit(attacker_unit_go_id)
	end

	local hit_zone_name = NetworkLookup.hit_zones[hit_zone_id]
	local damage_type = NetworkLookup.damage_types[damage_type_id]
	local damage_source = NetworkLookup.damage_sources[damage_source_id]
	local hit_ragdoll_actor = NetworkLookup.hit_ragdoll_actors[hit_ragdoll_actor_id]

	if not Unit.alive(victim_unit) then
		return 
	end

	local attacker_unit_alive = Unit.alive(attacker_unit)

	if attacker_unit_alive then
		local attacker_breed = Unit.get_data(attacker_unit, "breed")
		local victim_owner = Managers.player:owner(victim_unit)

		if attacker_breed and victim_owner then
			local has_inventory_extension = ScriptUnit.has_extension(attacker_unit, "ai_inventory_system")

			if has_inventory_extension then
				local inventory_extension = ScriptUnit.extension(attacker_unit, "ai_inventory_system")

				inventory_extension.play_hit_sound(inventory_extension, victim_unit, damage_type)
			end
		end

		if ScriptUnit.has_extension(attacker_unit, "hud_system") then
			local health_extension = ScriptUnit.extension(victim_unit, "health_system")
			local damage_source = NetworkLookup.damage_sources[damage_source_id]
			local should_indicate_hit = health_extension.is_alive(health_extension) and attacker_unit ~= victim_unit and damage_source ~= "wounded_degen"

			if should_indicate_hit then
				local hud_extension = ScriptUnit.extension(attacker_unit, "hud_system")
				hud_extension.hit_enemy = true
			end
		end
	end

	ScriptUnit.extension(victim_unit, "damage_system"):add_damage((attacker_unit_alive and attacker_unit) or victim_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source, hit_ragdoll_actor)

	return 
end
DamageSystem.rpc_add_damage_multiple = function (self, sender, victim_units, attacker_unit_go_id, damage_amount, hit_zone_id, damage_type_id, damage_source_id)
	local unit_storage = self.unit_storage
	local attacker_unit = unit_storage.unit(unit_storage, attacker_unit_go_id)
	local attacker_position = Unit.local_position(attacker_unit, 0)
	local buff_extension = nil

	if ScriptUnit.has_extension(attacker_unit, "buff_system") then
		buff_extension = ScriptUnit.extension(attacker_unit, "buff_system")
	end

	local hit_zone_name = NetworkLookup.hit_zones[hit_zone_id]
	local damage_type = NetworkLookup.damage_types[damage_type_id]
	local damage_source = NetworkLookup.damage_sources[damage_source_id]
	local num_victims = #victim_units

	for i = 1, num_victims, 1 do
		local victim_unit_go_id = victim_units[i]
		local victim_unit = unit_storage.unit(unit_storage, victim_unit_go_id)

		if victim_unit then
			if not Unit.alive(victim_unit) then
			else
				local victim_position = Unit.local_position(victim_unit, 0)
				local damage_direction = Vector3.normalize(victim_position - attacker_position)

				ScriptUnit.extension(victim_unit, "damage_system"):add_damage(attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source)
			end
		end
	end

	return 
end
DamageSystem.rpc_remove_assist_shield = function (self, sender, unit_go_id)
	local unit = self.unit_storage:unit(unit_go_id)
	local damage_extension = ScriptUnit.extension(unit, "damage_system")

	damage_extension.remove_assist_shield(damage_extension, "blocked_damage")

	return 
end
DamageSystem._assist_shield = function (self, target_unit, shield_amount)
	local damage_extension = ScriptUnit.extension(target_unit, "damage_system")
	local status_extension = ScriptUnit.extension(target_unit, "status_system")

	damage_extension.shield(damage_extension, shield_amount)
	status_extension.set_shielded(status_extension, true)

	return 
end
DamageSystem.rpc_request_heal = function (self, sender, unit_go_id, heal_amount, heal_type_id)
	fassert(Managers.player.is_server or LEVEL_EDITOR_TEST, "trying to request a heal from a client")

	local heal_type = NetworkLookup.heal_types[heal_type_id]
	local unit = self.unit_storage:unit(unit_go_id)

	if not Unit.alive(unit) then
		return 
	end

	if heal_type == "shield_by_assist" then
		DamageUtils.assist_shield_network(unit, unit, heal_amount)
	else
		DamageUtils.heal_network(unit, unit, heal_amount, heal_type)
	end

	return 
end
DamageSystem.rpc_heal = function (self, sender, target_unit_go_id, healer_unit_go_id, damage_amount, heal_type_id)
	local target_unit = self.unit_storage:unit(target_unit_go_id)

	if not target_unit then
		return 
	end

	if heal_type_id == NetworkLookup.heal_types.shield_by_assist then
		self._assist_shield(self, target_unit, damage_amount)
	else
		local damage_extension = ScriptUnit.extension(target_unit, "damage_system")
		local status_extension = ScriptUnit.extension(target_unit, "status_system")

		damage_extension.heal(damage_extension, target_unit, damage_amount)
		status_extension.healed(status_extension, NetworkLookup.heal_types[heal_type_id])
	end

	return 
end
DamageSystem.rpc_area_damage = function (self, sender, go_id, position)
	local unit = self.unit_storage:unit(go_id)
	local area_damage_system = ScriptUnit.extension(unit, "area_damage_system")

	if area_damage_system then
		area_damage_system.start(area_damage_system)
	end

	return 
end
DamageSystem.rpc_take_falling_damage = function (self, sender, go_id, fall_height)
	local unit = self.unit_storage:unit(go_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	fall_height = fall_height*0.25
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local FALL_DAMAGE_MULTIPLIER = movement_settings_table.fall.heights.FALL_DAMAGE_MULTIPLIER
	local MIN_FALL_DAMAGE_HEIGHT = movement_settings_table.fall.heights.MIN_FALL_DAMAGE_HEIGHT
	local MIN_FALL_DAMAGE = movement_settings_table.fall.heights.MIN_FALL_DAMAGE
	local MAX_FALL_DAMAGE = movement_settings_table.fall.heights.MAX_FALL_DAMAGE
	local HARD_LANDING_FALL_HEIGHT = movement_settings_table.fall.heights.HARD_LANDING_FALL_HEIGHT

	if MIN_FALL_DAMAGE_HEIGHT < fall_height then
		local delta = fall_height - MIN_FALL_DAMAGE_HEIGHT
		local fall_damage = math.clamp(delta*FALL_DAMAGE_MULTIPLIER, MIN_FALL_DAMAGE, MAX_FALL_DAMAGE)
		local damage_direction = Vector3(0, 0, 1)
		local hit_zone_name = "full"
		local damage_type = "kinetic"

		DamageUtils.add_damage_network(unit, unit, fall_damage, hit_zone_name, damage_type, damage_direction, "ground_impact")
	end

	return 
end
DamageSystem.suicide = function (self, unit)
	if not unit or not Unit.alive(unit) then
		print("got suicide from deleted player unit")

		return 
	end

	if not Unit.alive(unit) then
		print("trying suicide but already dead")

		return 
	end

	local health_extension = ScriptUnit.extension(unit, "health_system")

	health_extension.set_max_health(health_extension, 100)
	health_extension.set_current_damage(health_extension, 90)

	health_extension.state = "knocked_down"

	DamageUtils.add_damage_network(unit, unit, 255, "torso", "cutting", Vector3(1, 0, 0), "suicide")

	self.already_dead = true

	return 
end
DamageSystem.rpc_suicide = function (self, sender, go_id)
	local unit = self.unit_storage:unit(go_id)

	self.suicide(self, unit)

	return 
end
DamageSystem.rpc_level_object_damage = function (self, sender, level_object_id, damage_amount, attack_direction, damage_source_id)
	if self.is_server then
		Managers.state.network.network_transmit:send_rpc_clients_except("rpc_level_object_damage", sender, level_object_id, damage_amount, attack_direction, damage_source_id)
	end

	local level = LevelHelper:current_level(self.world)
	local hit_unit = Level.unit_by_index(level, level_object_id)

	if hit_unit and Unit.alive(hit_unit) then
		local hit_zone_name = "full"
		local damage_extension = ScriptUnit.extension(hit_unit, "damage_system")

		damage_extension.add_damage(damage_extension, hit_unit, damage_amount, hit_zone_name, "destructible_level_object_hit", attack_direction, NetworkLookup.damage_sources[damage_source_id])
	end

	return 
end
DamageSystem.rpc_level_object_heal = function (self, sender, level_object_id, heal_amount)
	if self.is_server then
		Managers.state.network.network_transmit:send_rpc_clients_except("rpc_level_object_heal", sender, level_object_id, heal_amount)
	end

	local level = LevelHelper:current_level(self.world)
	local hit_unit = Level.unit_by_index(level, level_object_id)

	if hit_unit and Unit.alive(hit_unit) then
		local damage_extension = ScriptUnit.extension(hit_unit, "damage_system")

		damage_extension.heal(damage_extension, hit_unit, heal_amount)
	end

	return 
end
DamageSystem.rpc_create_explosion = function (self, sender, attacker_unit_id, attacker_is_level_unit, position, rotation, explosion_template_name_id, scale, damage_source_id)
	if self.is_server then
		Managers.state.network.network_transmit:send_rpc_clients_except("rpc_create_explosion", sender, attacker_unit_id, attacker_is_level_unit, position, rotation, explosion_template_name_id, scale, damage_source_id)
	end

	local attacker_unit = nil

	if attacker_is_level_unit then
		attacker_unit = LevelHelper:unit_by_index(self.world, attacker_unit_id)
	else
		attacker_unit = self.unit_storage:unit(attacker_unit_id)
	end

	local explosion_template_name = NetworkLookup.explosion_templates[explosion_template_name_id]
	local explosion_template = ExplosionTemplates[explosion_template_name]
	scale = scale/100
	local damage_source = NetworkLookup.damage_sources[damage_source_id]
	local is_husk = true

	DamageUtils.create_explosion(self.world, attacker_unit, position, rotation, explosion_template.explosion, scale, damage_source, self.is_server, is_husk)

	return 
end
DamageSystem.create_explosion = function (self, attacker_unit, position, rotation, explosion_template_name, scale, damage_source)
	if not NetworkUtils.network_safe_position(position) then
		return false
	end

	local explosion_template = ExplosionTemplates[explosion_template_name]
	local is_husk = false

	DamageUtils.create_explosion(self.world, attacker_unit, position, rotation, explosion_template.explosion, scale, damage_source, self.is_server, is_husk)

	local network_manager = Managers.state.network
	local attacker_unit_id, attacker_is_level_unit = network_manager.game_object_or_level_id(network_manager, attacker_unit)
	local explosion_template_id = NetworkLookup.explosion_templates[explosion_template_name]
	local damage_source_id = NetworkLookup.damage_sources[damage_source]
	scale = scale*100

	if self.is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_create_explosion", attacker_unit_id, attacker_is_level_unit, position, rotation, explosion_template_id, 1, damage_source_id)
	else
		network_manager.network_transmit:send_rpc_server("rpc_create_explosion", attacker_unit_id, attacker_is_level_unit, position, rotation, explosion_template_id, 1, damage_source_id)
	end

	return 
end

return 
