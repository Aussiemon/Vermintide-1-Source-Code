PickupUnitExtension = class(PickupUnitExtension)
local telemetry_data = {}

local function _add_pickup_spawn_telemetry(pickup_name, pickup_spawn_type, position)
	table.clear(telemetry_data)

	telemetry_data.pickup_name = pickup_name
	telemetry_data.pickup_spawn_type = pickup_spawn_type
	telemetry_data.position = position

	Managers.telemetry:register_event("pickup_spawn", telemetry_data)

	return 
end

local function _add_pickup_destroyed_telemetry(pickup_name, pickup_spawn_type, position)
	table.clear(telemetry_data)

	telemetry_data.pickup_name = pickup_name
	telemetry_data.pickup_spawn_type = pickup_spawn_type
	telemetry_data.position = position

	Managers.telemetry:register_event("pickup_destroyed", telemetry_data)

	return 
end

PickupUnitExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.unit = unit
	local pickup_name = extension_init_data.pickup_name
	local has_physics = extension_init_data.has_physics
	local spawn_type = extension_init_data.spawn_type
	local network_transmit = extension_init_context.network_transmit
	self.pickup_name = pickup_name
	self.has_physics = has_physics
	self.spawn_type = spawn_type
	self.is_server = network_transmit.is_server
	self.spawn_index = extension_init_data.spawn_index
	local pickup_settings = AllPickups[self.pickup_name]
	self.hide_func = pickup_settings.hide_func
	self.hidden = false

	Unit.set_data(unit, "interaction_data", "hud_description", pickup_settings.hud_description)
	Unit.set_data(unit, "interaction_data", "interaction_length", Unit.get_data(unit, "interaction_data", "interaction_length") or 0)
	Unit.set_data(unit, "interaction_data", "interaction_type", "pickup_object")
	Unit.set_data(unit, "interaction_data", "only_once", pickup_settings.only_once)

	self.can_interact_time = Managers.time:time("game") + 1

	if Unit.find_actor(unit, "pickup") then
		if has_physics then
			Unit.create_actor(unit, "pickup")
		else
			Unit.destroy_actor(unit, "pickup")
		end
	end

	if GameSettingsDevelopment.use_telemetry and self.is_server then
		local position = POSITION_LOOKUP[unit]

		_add_pickup_spawn_telemetry(pickup_name, spawn_type, position)
	end

	return 
end
PickupUnitExtension.extensions_ready = function (self)
	return 
end
PickupUnitExtension.update = function (self, unit, input, dt, context, t)
	return 
end
PickupUnitExtension.hide = function (self)
	local unit = self.unit
	self.hidden = true

	Unit.set_unit_visibility(unit, false)
	Unit.disable_physics(unit)

	return 
end
PickupUnitExtension.get_pickup_settings = function (self)
	return AllPickups[self.pickup_name]
end
PickupUnitExtension.destroy = function (self)
	local pickup_system = Managers.state.entity:system("pickup_system")

	if pickup_system and self.spawn_index then
		pickup_system.set_taken(pickup_system, self.spawn_index)
	end

	if GameSettingsDevelopment.use_telemetry and self.is_server then
		local position = POSITION_LOOKUP[self.unit]

		_add_pickup_destroyed_telemetry(self.pickup_name, self.spawn_type, position)
	end

	return 
end
PickupUnitExtension.can_interact = function (self)
	local t = Managers.time:time("game")
	local return_value = t <= self.can_interact_time

	return not return_value
end

return 
