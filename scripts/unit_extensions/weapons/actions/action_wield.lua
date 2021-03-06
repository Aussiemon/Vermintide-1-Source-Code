ActionWield = class(ActionWield)

ActionWield.init = function (self, world, item_name, is_server, owner_unit, weapon_unit)
	self.world = world
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.item_name = item_name
	self.input_extension = ScriptUnit.extension(owner_unit, "input_system")
	self.inventory_extension = ScriptUnit.extension(owner_unit, "inventory_system")
	self.status_extension = ScriptUnit.extension(owner_unit, "status_system")
end

ActionWield.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	self.action_time_started = t

	if self.current_action.reset_aim_on_attack then
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

		first_person_extension:reset_aim_assist_multiplier()
	end

	self.new_slot = CharacterStateHelper.wield_input(self.input_extension, self.inventory_extension, "action_wield", true)

	assert(self.new_slot, "went into wield action without input")
	self.input_extension:reset_input_buffer()
	self.input_extension:add_wield_cooldown(t + new_action.wield_cooldown)
end

ActionWield.client_owner_post_update = function (self, dt, t, world, can_damage)
	return
end

ActionWield.finish = function (self)
	self.inventory_extension:wield(self.new_slot)

	local status_extension = self.status_extension

	if status_extension:is_zooming() then
		status_extension:set_zooming(false)
	end
end

return
