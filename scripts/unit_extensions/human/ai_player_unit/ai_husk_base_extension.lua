AiHuskBaseExtension = class(AiHuskBaseExtension)
AiHuskBaseExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.is_husk = true
	self.unit = unit
	self.game = extension_init_data.game
	self.go_id = extension_init_data.go_id
	local ai_system = Managers.state.entity:system("ai_system")
	local broadphase = ai_system.broadphase
	self.broadphase = broadphase
	self.broadphase_id = Broadphase.add(broadphase, unit, Unit.local_position(unit, 0), 1)
	local breed = Unit.get_data(unit, "breed")
	self._breed = breed

	if breed.combat_spawn_stinger then
		Managers.music:music_trigger("combat_music", breed.combat_spawn_stinger)
	end

	return 
end
AiHuskBaseExtension.current_action_name = function (self)
	local game = self.game
	local game_object_id = self.go_id

	return NetworkLookup.bt_action_names[GameSession.game_object_field(game, game_object_id, "bt_action_name")]
end
AiHuskBaseExtension.update = function (self, unit, input, dt, context)
	local health_extension = ScriptUnit.extension(unit, "health_system")
	local is_alive = health_extension.is_alive(health_extension)

	if is_alive then
		Broadphase.move(self.broadphase, self.broadphase_id, POSITION_LOOKUP[unit])
	end

	return 
end
AiHuskBaseExtension.destroy = function (self, u, input)
	Broadphase.remove(self.broadphase, self.broadphase_id)

	return 
end

return 
