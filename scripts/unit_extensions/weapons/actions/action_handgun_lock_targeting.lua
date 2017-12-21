ActionHandgunLockTargeting = class(ActionHandgunLockTargeting)
ActionHandgunLockTargeting.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.owner_unit_first_person = first_person_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.world = world
	self.item_name = item_name
	self.targets = {}

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	return 
end
ActionHandgunLockTargeting.client_owner_start_action = function (self, new_action, t)
	table.clear(self.targets)

	self.current_action = new_action
	local ammo_extension = self.ammo_extension

	if ammo_extension then
		self.max_targets = math.min(ammo_extension.ammo_count(ammo_extension), new_action.max_targets)
	else
		self.max_targets = new_action.max_targets
	end

	return 
end
ActionHandgunLockTargeting.client_owner_post_update = function (self, dt, t, world, can_damage)
	local physics_world = World.get_data(world, "physics_world")
	local owner_unit_1p = self.owner_unit_first_person
	local player_position = POSITION_LOOKUP[owner_unit_1p]
	local player_rotation = Unit.world_rotation(owner_unit_1p, 0)
	local direction = Vector3.normalize(Quaternion.forward(player_rotation))

	if #self.targets == self.max_targets then
		return 
	end

	local collision_filter = "filter_player_ray_projectile_no_player"
	local result = PhysicsWorld.immediate_raycast(physics_world, player_position, direction, "all", "collision_filter", collision_filter)

	if result then
		local num_hits = #result

		for i = 1, num_hits, 1 do
			local hit = result[i]
			local hit_actor = hit[4]
			local hit_unit = Actor.unit(hit_actor)

			if ScriptUnit.has_extension(hit_unit, "locomotion_system") then
				local alive = true

				if ScriptUnit.has_extension(hit_unit, "health_system") then
					alive = ScriptUnit.extension(hit_unit, "health_system"):is_alive()
				end

				if not table.contains(self.targets, hit_unit) and owner_unit_1p ~= hit_unit and alive then
					self.targets[#self.targets + 1] = hit_unit
					local wwise_world = Managers.world:wwise_world(world)

					if #self.targets == self.max_targets then
						WwiseWorld.trigger_event(wwise_world, "ui_special_pistol_targets_last")
					else
						WwiseWorld.trigger_event(wwise_world, "ui_special_pistol_targets")
					end

					if ScriptUnit.has_extension(hit_unit, "outline_system") then
						local outline_extension = ScriptUnit.extension(hit_unit, "outline_system")

						outline_extension.set_method("always")
					end

					break
				end
			else
				break
			end
		end
	end

	return 
end
ActionHandgunLockTargeting.finish = function (self, reason)
	local current_action = self.current_action

	for i, unit in ipairs(self.targets) do
		if Unit.alive(unit) and ScriptUnit.has_extension(unit, "outline_system") then
			local outline_extension = ScriptUnit.extension(unit, "outline_system")

			outline_extension.set_method("never")
		end
	end

	local chain_action_data = {
		targets = self.targets
	}

	return chain_action_data
end

return 
