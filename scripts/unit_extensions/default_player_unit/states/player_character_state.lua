PlayerCharacterState = class(PlayerCharacterState)
PlayerCharacterState.init = function (self, character_state_init_context, name)
	self.name = name
	self.world = character_state_init_context.world
	self.unit = character_state_init_context.unit
	self.csm = character_state_init_context.csm
	self.player = character_state_init_context.player
	self.network_transmit = character_state_init_context.network_transmit
	self.unit_storage = character_state_init_context.unit_storage
	self.nav_world = character_state_init_context.nav_world
	self.is_server = Managers.player.is_server
	self.temp_params = {}
	self.input_extension = ScriptUnit.extension(self.unit, "input_system")
	self.interactor_extension = ScriptUnit.extension(self.unit, "interactor_system")
	self.damage_extension = ScriptUnit.extension(self.unit, "damage_system")
	self.inventory_extension = ScriptUnit.extension(self.unit, "inventory_system")
	self.locomotion_extension = ScriptUnit.extension(self.unit, "locomotion_system")
	self.first_person_extension = ScriptUnit.extension(self.unit, "first_person_system")
	self.status_extension = ScriptUnit.extension(self.unit, "status_system")
	self.ai_extension = ScriptUnit.has_extension(self.unit, "ai_system") and ScriptUnit.extension(self.unit, "ai_system")

	return 
end

return 
