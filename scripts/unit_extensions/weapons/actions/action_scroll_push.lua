ActionScrollPush = class(ActionScrollPush)
ActionScrollPush.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.world = world
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.weapon_system = weapon_system
	self.item_name = item_name

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	return 
end
ActionScrollPush.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action

	return 
end
ActionScrollPush.client_owner_post_update = function (self, dt, t, world, can_damage)
	return 
end
ActionScrollPush.finish = function (self, reason)
	if reason ~= "action_complete" then
		return 
	end

	local current_action = self.current_action
	local owner_unit = self.owner_unit
	local unit_position = POSITION_LOOKUP[owner_unit]
	local radius = current_action.push_radius
	local network_manager = Managers.state.network
	local attacker_unit_id = network_manager.unit_game_object_id(network_manager, self.owner_unit)
	local attack_template = AttackTemplates[current_action.attack_template]
	local attack_template_id = attack_template.lookup_id
	local effect_name = current_action.effect_name
	local game_object_id = attacker_unit_id
	local unit_node = 0
	local offset = Vector3(0, 0, 0)
	local unit_rotation = Unit.local_rotation(owner_unit, 0)
	local linked = false

	assert(false, "this doesn't work, don't send messages to all unless you are server")
	network_manager.network_transmit:send_rpc_all("rpc_play_particle_effect", NetworkLookup.effects[effect_name], game_object_id, unit_node, offset, unit_rotation, linked)

	if self.ammo_extension then
		local ammo_usage = self.current_action.ammo_usage

		self.ammo_extension:use_ammo(ammo_usage)
	end

	return 
end

return 
