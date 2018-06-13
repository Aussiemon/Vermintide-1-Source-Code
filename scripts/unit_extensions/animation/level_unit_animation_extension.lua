LevelUnitAnimationExtension = class(LevelUnitAnimationExtension)

LevelUnitAnimationExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.world = extension_init_context.world
	self.is_server = Managers.player.is_server
	self.network_manager = Managers.state.network
	self.network_transmit = extension_init_context.network_transmit
	self.animation_sync_rpc = Unit.get_data(unit, "animation_sync_rpc")
end

LevelUnitAnimationExtension.hot_join_sync = function (self, sender)
	local unit = self.unit
	local world = self.world
	local level_unit_index = LevelHelper:unit_index(world, unit)
	local animation_sync_rpc = self.animation_sync_rpc
	local network_transmit = self.network_transmit

	network_transmit:send_rpc(animation_sync_rpc, sender, level_unit_index, Unit.animation_get_state(unit))
end

LevelUnitAnimationExtension.play_animation_event = function (self, event)
	local unit = self.unit
	local world = self.world
	local level_unit_index = LevelHelper:unit_index(world, unit)
	local event_id = NetworkLookup.anims[event]
	local network_manager = self.network_manager

	if network_manager:in_game_session() then
		local network_transmit = self.network_transmit

		if self.is_server then
			network_transmit:send_rpc_clients("rpc_level_unit_anim_event", event_id, level_unit_index)
		else
			network_transmit:send_rpc_server("rpc_level_unit_anim_event", event_id, level_unit_index)
		end
	end

	Unit.animation_event(unit, event)
end

return
