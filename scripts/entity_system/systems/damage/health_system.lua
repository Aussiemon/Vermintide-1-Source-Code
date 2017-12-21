require("scripts/unit_extensions/generic/generic_health_extension")
require("scripts/unit_extensions/generic/invincible_health_extension")
require("scripts/unit_extensions/generic/rat_ogre_health_extension")
require("scripts/unit_extensions/default_player_unit/player_unit_health_extension")

HealthSystem = class(HealthSystem, ExtensionSystemBase)
local script_data = script_data
local RPCS = {
	"rpc_sync_damage_taken"
}
local extensions = {
	"PlayerUnitHealthExtension",
	"GenericHealthExtension",
	"InvincibleHealthExtension",
	"RatOgreHealthExtension"
}
HealthSystem.init = function (self, entity_system_creation_context, system_name)
	HealthSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))

	self.unit_extensions = {}
	self.updateable_unit_extensions = {}

	return 
end
HealthSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)

	return 
end
HealthSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local extension = ScriptUnit.add_extension(self.extension_init_context, unit, extension_name, self.NAME, extension_init_data)
	self.unit_extensions[unit] = extension

	if extension_name == "PlayerUnitHealthExtension" or extension_name == "RatOgreHealthExtension" then
		self.updateable_unit_extensions[unit] = extension
	end

	return extension
end
HealthSystem.extensions_ready = function (self, world, unit)
	local extension = self.unit_extensions[unit]
	extension.damage_extension = ScriptUnit.extension(unit, "damage_system")

	assert(extension.damage_extension)

	return 
end
HealthSystem.on_remove_extension = function (self, unit, extension_name)
	assert(ScriptUnit.has_extension(unit, self.NAME), "Trying to remove non-existing extension %q from unit %s", extension_name, unit)
	ScriptUnit.remove_extension(unit, self.NAME)

	self.unit_extensions[unit] = nil
	self.updateable_unit_extensions[unit] = nil

	return 
end
HealthSystem.hot_join_sync = function (self, sender)
	local network_manager = Managers.state.network

	for unit, extension in pairs(self.unit_extensions) do
		local go_id, is_level_unit = network_manager.game_object_or_level_id(network_manager, unit)

		if go_id then
			local state = NetworkLookup.health_statuses[extension.state]
			local damage = NetworkUtils.get_network_safe_damage_hotjoin_sync(extension.damage)

			self.network_transmit:send_rpc("rpc_sync_damage_taken", sender, go_id, is_level_unit, damage, state)
		end
	end

	return 
end
local debug_units = {}
HealthSystem.update = function (self, context, t)
	for unit, extension in pairs(self.unit_extensions) do
		local damage_extension = extension.damage_extension
		local damage_datas, num_damages = damage_extension.recent_damages(damage_extension)

		for i = 1, num_damages/DamageDataIndex.STRIDE, 1 do
			local damage_index = (i - 1)*DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_AMOUNT
			local damage_amount = damage_datas[damage_index]
			local damage_type_index = (i - 1)*DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_TYPE
			local damage_type = damage_datas[damage_type_index]

			if damage_amount < 0 then
				extension.add_heal(extension, -damage_amount)
			else
				local status_extension = ScriptUnit.has_extension(unit, "status_system") and ScriptUnit.extension(unit, "status_system")

				if not status_extension or not status_extension.is_knocked_down(status_extension) or not damage_type or damage_type ~= "overcharge" then
					extension.add_damage(extension, damage_amount)

					if extension.instakill then
						StatisticsUtil.register_instakill(unit, damage_datas, i)
					end
				end
			end
		end
	end

	local dt = context.dt

	for unit, extension in pairs(self.updateable_unit_extensions) do
		extension.update(extension, dt, context, t)
	end

	if script_data.damage_debug then
		for unit, extension in pairs(self.unit_extensions) do
			local health = tostring(extension.health)

			if extension.health == math.huge then
				health = "inf"
			end

			if Managers.player:owner(unit) then
				if ScriptUnit.has_extension(unit, "dialogue_system") then
					Debug.text("Player: %s @ %d/%s", ScriptUnit.extension(unit, "dialogue_system").context.player_profile, extension.damage, health)
				else
					Debug.text("Player: @ %d/%s", extension.damage, health)
				end
			elseif Unit.get_data(unit, "breed") ~= nil then
				local breed = Unit.get_data(unit, "breed")

				Debug.text("Breed %s @ %d/%s", breed.name, extension.damage, health)
			else
				Debug.text("%s @ %d/%s", Unit.debug_name(unit), extension.damage, health)
			end
		end
	end

	if script_data.show_ai_health then
		local ai_system = Managers.state.entity:system("ai_system")
		local broadphase = ai_system.broadphase
		local center_pos = PLAYER_POSITIONS[1]

		if broadphase and center_pos then
			local num_units = Broadphase.query(broadphase, center_pos, 20, debug_units)
			local offset_vector = Vector3(0, 0, 0.5)
			local color1 = Vector3(0, 175, 75)
			local color2 = Vector3(175, 175, 0)
			local color3 = Vector3(175, 0, 0)
			local deadcolor = Vector3(100, 0, 0)
			local viewport_name = "player_1"

			for i = 1, num_units, 1 do
				local unit = debug_units[i]
				local head_node = Unit.node(unit, "c_head")
				local health_ext = ScriptUnit.extension(unit, "health_system")
				local current_health = health_ext.health - health_ext.damage
				local max_health = health_ext.health
				local p = current_health/max_health
				local color = (0.99 < p and color1) or (0.25 < p and color2) or color3

				if p <= 0 then
					local text = string.format("dead", current_health, health_ext.health)

					Managers.state.debug_text:clear_unit_text(unit, "health")
					Managers.state.debug_text:output_unit_text(text, 0.16, unit, head_node, offset_vector, nil, "health", deadcolor, viewport_name)
				else
					local text = string.format("%.1f / %.1f", current_health, health_ext.health)

					Managers.state.debug_text:clear_unit_text(unit, "health")
					Managers.state.debug_text:output_unit_text(text, 0.3, unit, head_node, offset_vector, nil, "health", color, viewport_name)
				end
			end
		end
	end

	return 
end
HealthSystem.rpc_sync_damage_taken = function (self, sender, go_id, is_level_unit, damage_amount, state_id)
	local unit = Managers.state.network:game_object_or_level_unit(go_id, is_level_unit)

	if not Unit.alive(unit) then
		return 
	end

	local health_ext = ScriptUnit.extension(unit, "health_system")
	health_ext.damage = damage_amount
	health_ext.state = NetworkLookup.health_statuses[state_id]

	if health_ext.current_health(health_ext) <= 0 then
		local damage_direction = Vector3(1, 0, 0)

		ScriptUnit.extension(unit, "damage_system"):add_damage(unit, 0, "full", "sync_health", damage_direction)
	end

	return 
end

return 
