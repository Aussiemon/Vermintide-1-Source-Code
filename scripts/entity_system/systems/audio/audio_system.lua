AudioSystem = class(AudioSystem, ExtensionSystemBase)
local RPCS = {
	"rpc_server_audio_event",
	"rpc_server_audio_event_at_pos",
	"rpc_server_audio_unit_event",
	"rpc_server_audio_unit_param_string_event",
	"rpc_server_audio_unit_param_int_event",
	"rpc_server_audio_unit_param_float_event",
	"rpc_client_audio_set_global_parameter_with_lerp"
}

AudioSystem.init = function (self, entity_system_creation_context, system_name)
	AudioSystem.super.init(self, entity_system_creation_context, system_name, {})

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate:register(self, unpack(RPCS))

	self.is_server = entity_system_creation_context.is_server
	self.global_parameter_data = {}
end

AudioSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)
	table.for_each(self.global_parameter_data, table.clear)
end

AudioSystem.update = function (self, context, t)
	local dt = context.dt

	self:_update_global_parameters(dt)
end

local LERP_PROGRESS_PER_SECOND = 0.125

AudioSystem._update_global_parameters = function (self, dt)
	local wwise_world = Managers.world:wwise_world(self.world)

	for name, data in pairs(self.global_parameter_data) do
		if script_data.debug_music then
			Debug.text("GLOBAL PARAMETERS")

			local debug_string = string.format(" %s: %.2f", name, data.interpolation_current_value or 0)

			Debug.text(debug_string)
		end

		local progress = data.interpolation_progress_value

		if progress < 1 then
			local start_value = data.interpolation_start_value
			local end_value = data.interpolation_end_value
			progress = math.clamp(progress + dt * LERP_PROGRESS_PER_SECOND, 0, 1)
			local current_value = math.lerp(start_value, end_value, progress)

			if math.abs(end_value - current_value) < 0.005 then
				current_value = end_value
				progress = 1
			end

			data.interpolation_current_value = current_value
			data.interpolation_progress_value = progress

			WwiseWorld.set_global_parameter(wwise_world, name, current_value)
		end
	end
end

AudioSystem.rpc_server_audio_event = function (self, sender, sound_id)
	local wwise_world = Managers.world:wwise_world(self.world)
	local sound_event = NetworkLookup.sound_events[sound_id]
	local entity_manager = Managers.state.entity
	local surrounding_aware_system = entity_manager:system("surrounding_aware_system")
	local unit = nil
	local event_name = "heard_sound"
	local distance = math.huge

	surrounding_aware_system:add_system_event(unit, event_name, distance, "heard_event", sound_event)

	local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, sound_event)
end

AudioSystem.rpc_server_audio_event_at_pos = function (self, sender, sound_id, position)
	local wwise_world = Managers.world:wwise_world(self.world)
	local sound_event = NetworkLookup.sound_events[sound_id]
	local entity_manager = Managers.state.entity
	local surrounding_aware_system = entity_manager:system("surrounding_aware_system")
	local unit = nil
	local event_name = "heard_sound"
	local distance = math.huge

	surrounding_aware_system:add_system_event(unit, event_name, distance, "heard_event", sound_event)

	local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, sound_event, position)
end

AudioSystem.rpc_server_audio_unit_event = function (self, sender, sound_id, unit_id, object_id)
	if self.is_server then
		Managers.state.network.network_transmit:send_rpc_clients("rpc_server_audio_unit_event", sound_id, unit_id, object_id)
	end

	local wwise_world = Managers.world:wwise_world(self.world)
	local event = NetworkLookup.sound_events[sound_id]
	local unit = self.unit_storage:unit(unit_id)

	self:_play_event(event, unit, object_id)
end

AudioSystem.play_audio_unit_event = function (self, event, unit, object)
	local object_id = (object and Unit.node(unit, object)) or 0

	self:_play_event(event, unit, object_id)

	local network_manager = Managers.state.network
	local unit_id = network_manager:unit_game_object_id(unit)
	local sound_event_id = NetworkLookup.sound_events[event]

	if self.is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_server_audio_unit_event", sound_event_id, unit_id, object_id)
	else
		network_manager.network_transmit:send_rpc_server("rpc_server_audio_unit_event", sound_event_id, unit_id, object_id)
	end
end

AudioSystem._play_event = function (self, event, unit, object_id)
	WwiseUtils.trigger_unit_event(self.world, event, unit, object_id)
end

AudioSystem.rpc_server_audio_unit_param_string_event = function (self, sender, sound_event_id, unit_id, object_id, name_id, value_id)
	if self.is_server then
		Managers.state.network.network_transmit:send_rpc_clients("rpc_server_audio_unit_param_string_event", sound_event_id, unit_id, object_id, name_id, value_id)
	end

	local event = NetworkLookup.sound_events[sound_event_id]
	local unit = self.unit_storage:unit(unit_id)
	local param = NetworkLookup.sound_event_param_names[name_id]
	local value = NetworkLookup.sound_event_param_string_values[value_id]

	self:_play_param_event(event, param, value, unit, object_id)
end

AudioSystem.play_audio_unit_param_string_event = function (self, event, param, value, unit, object)
	local object_id = (object and Unit.node(unit, object)) or 0

	self:_play_param_event(event, param, value, unit, object_id)

	local network_manager = Managers.state.network
	local unit_id = network_manager:unit_game_object_id(unit)
	local sound_event_id = NetworkLookup.sound_events[event]
	local name_id = NetworkLookup.sound_event_param_names[param]
	local value_id = NetworkLookup.sound_event_param_string_values[value]

	if self.is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_server_audio_unit_param_string_event", sound_event_id, unit_id, object_id, name_id, value_id)
	else
		network_manager.network_transmit:send_rpc_server("rpc_server_audio_unit_param_string_event", sound_event_id, unit_id, object_id, name_id, value_id)
	end
end

AudioSystem.rpc_server_audio_unit_param_int_event = function (self, sender, sound_event_id, unit_id, object_id, name_id, value)
	if self.is_server then
		Managers.state.network.network_transmit:send_rpc_clients("rpc_server_audio_unit_param_int_event", sound_event_id, unit_id, object_id, name_id, value)
	end

	local wwise_world = Managers.world:wwise_world(self.world)
	local event = NetworkLookup.sound_events[sound_event_id]
	local unit = self.unit_storage:unit(unit_id)
	local param = NetworkLookup.sound_event_param_names[name_id]

	self:_play_param_event(event, param, value, unit, object_id)
end

AudioSystem.play_audio_unit_param_int_event = function (self, event, param, value, unit, object)
	local object_id = (object and Unit.node(unit, object)) or 0

	self:_play_param_event(event, param, value, unit, object_id)

	local network_manager = Managers.state.network
	local unit_id = network_manager:unit_game_object_id(unit)
	local sound_event_id = NetworkLookup.sound_events[event]
	local name_id = NetworkLookup.sound_event_param_names[param]

	network_manager.network_transmit:send_rpc_clients("rpc_server_audio_unit_param_int_event", sound_event_id, unit_id, object_id, name_id, value)
end

AudioSystem.rpc_server_audio_unit_param_float_event = function (self, sender, sound_event_id, unit_id, object_id, name_id, value)
	if self.is_server then
		Managers.state.network.network_transmit:send_rpc_clients("rpc_server_audio_unit_param_float_event", sound_event_id, unit_id, object_id, name_id, value)
	end

	local wwise_world = Managers.world:wwise_world(self.world)
	local event = NetworkLookup.sound_events[sound_event_id]
	local unit = self.unit_storage:unit(unit_id)
	local param = NetworkLookup.sound_event_param_names[name_id]

	self:_play_param_event(event, param, value, unit, object_id)
end

AudioSystem.rpc_client_audio_set_global_parameter_with_lerp = function (self, sender, parameter_id, value)
	local name = NetworkLookup.global_parameter_names[parameter_id]
	local percentage = value * 100

	self:set_global_parameter_with_lerp(name, percentage)
end

AudioSystem.set_global_parameter_with_lerp = function (self, name, value)
	local global_parameter_data = self.global_parameter_data[name] or {}
	local current_value = global_parameter_data.interpolation_current_value or 0
	global_parameter_data.interpolation_start_value = current_value
	global_parameter_data.interpolation_end_value = value
	global_parameter_data.interpolation_progress_value = 0
	self.global_parameter_data[name] = global_parameter_data
end

AudioSystem.play_audio_unit_param_float_event = function (self, event, param, value, unit, object)
	local object_id = (object and Unit.node(unit, object)) or 0

	self:_play_param_event(event, param, value, unit, object_id)

	local network_manager = Managers.state.network
	local unit_id = network_manager:unit_game_object_id(unit)
	local sound_event_id = NetworkLookup.sound_events[event]
	local name_id = NetworkLookup.sound_event_param_names[param]

	if self.is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_server_audio_unit_param_float_event", sound_event_id, unit_id, object_id, name_id, value)
	else
		network_manager.network_transmit:send_rpc_server("rpc_server_audio_unit_param_float_event", sound_event_id, unit_id, object_id, name_id, value)
	end
end

AudioSystem._play_param_event = function (self, event, param, value, unit, object_id)
	local source, wwise_world = WwiseUtils.make_unit_auto_source(self.world, unit, object_id)

	WwiseWorld.set_source_parameter(wwise_world, source, param, value)
	WwiseWorld.trigger_event(wwise_world, event, source)
end

return
