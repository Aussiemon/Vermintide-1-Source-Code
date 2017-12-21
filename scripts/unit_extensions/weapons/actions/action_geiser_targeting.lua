ActionGeiserTargeting = class(ActionGeiserTargeting)
ActionGeiserTargeting.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.world = world
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.is_server = is_server
	self.item_name = item_name
	self.first_person_unit = first_person_unit
	self.wwise_world = Managers.world:wwise_world(world)
	self.position = Vector3Box()
	self.first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	self.network_transmit = Managers.state.network.network_transmit
	self.unit_id = Managers.state.network.unit_storage:go_id(owner_unit)

	return 
end
ActionGeiserTargeting.client_owner_start_action = function (self, new_action, t)
	local world = self.world
	self.overcharge_timer = 0
	self.current_action = new_action
	local effect_name = new_action.particle_effect
	local effect_id = NetworkLookup.effects[effect_name]
	self.targeting_effect_id = World.create_particles(world, effect_name, Vector3.zero())
	self.targeting_variable_id = World.find_particles_variable(world, effect_name, "charge_radius")
	self.angle = math.degrees_to_radians(new_action.angle)
	self.time_to_shoot = t
	local go_id = self.unit_id

	if self.is_server or LEVEL_EDITOR_TEST then
		self.network_transmit:send_rpc_clients("rpc_start_geiser", go_id, effect_id, new_action.min_radius, new_action.max_radius, new_action.charge_time, self.angle)
	else
		self.network_transmit:send_rpc_server("rpc_start_geiser", go_id, effect_id, new_action.min_radius, new_action.max_radius, new_action.charge_time, self.angle)
	end

	self.min_radius = new_action.min_radius
	self.max_radius = new_action.max_radius
	self.charge_time = new_action.charge_time
	self.radius = self.min_radius
	self.charge_ready_sound_event = self.current_action.charge_ready_sound_event
	self.speed = new_action.speed
	self.gravity = new_action.gravity
	self.height = new_action.height or 1
	self.debug_draw = new_action.debug_draw
	local owner_unit = self.owner_unit
	local owner_player = Managers.player:owner(owner_unit)
	local is_bot = owner_player and owner_player.bot_player

	if not is_bot then
		local charge_sound_name = new_action.charge_sound_name

		if charge_sound_name then
			local wwise_playing_id, wwise_source_id = ActionUtils.start_charge_sound(self.wwise_world, self.weapon_unit, new_action)
			self.charging_sound_id = wwise_playing_id
			self.wwise_source_id = wwise_source_id
		end
	end

	self.charge_value = 0

	return 
end
ActionGeiserTargeting.client_owner_post_update = function (self, dt, t, world, can_damage)
	local time_to_shoot = self.time_to_shoot
	local current_action = self.current_action

	if current_action.overcharge_interval then
		self.overcharge_timer = self.overcharge_timer + dt

		if current_action.overcharge_interval <= self.overcharge_timer then
			if self.overcharge_extension then
				self.overcharge_extension:add_charge(current_action.overcharge_type)
			end

			self.overcharge_timer = 0
		end
	end

	local player_position = POSITION_LOOKUP[self.owner_unit]
	local first_person_position = POSITION_LOOKUP[self.first_person_unit]
	local first_person_rotation = Unit.world_rotation(self.first_person_unit, 0)
	local position = nil
	local physics_world = World.get_data(world, "physics_world")
	local max_steps = 10
	local max_time = 1.5
	local speed = self.speed
	local angle = self.angle
	local velocity = Quaternion.forward(Quaternion.multiply(first_person_rotation, Quaternion(Vector3.right(), angle)))*speed
	local gravity = Vector3(0, 0, self.gravity)
	local collision_filter = "filter_geiser_check"
	local overcharge_extension = self.overcharge_extension

	local function ballistic_raycast(max_steps, max_time, position, velocity, gravity, collision_filter, visualize)
		local time_step = max_time/max_steps

		for i = 1, max_steps, 1 do
			local new_position = position + velocity*time_step
			local delta = new_position - position
			local direction = Vector3.normalize(delta)
			local distance = Vector3.length(delta)
			local result, hit_position, hit_distance, normal, actor = PhysicsWorld.immediate_raycast(physics_world, position, direction, distance, "closest", "collision_filter", collision_filter)

			if visualize then
				QuickDrawer:line(position, new_position, Color(100, 200, 200, 200))
			end

			if hit_position then
				return result, hit_position, hit_distance, normal, actor
			end

			velocity = velocity + gravity*time_step
			position = new_position
		end

		return false, position
	end

	local result, hit_position, hit_distance, normal = ballistic_raycast(max_steps, max_time, first_person_position, velocity, gravity, collision_filter, self.debug_draw)
	position = hit_position

	if result then
		local up = Vector3(0, 0, 1)

		if Vector3.dot(normal, up) < 0.75 then
			local half_step_back = Vector3.normalize(position - player_position)*1
			local new_position = position - half_step_back
			local result, hit_position, hit_distance, normal = PhysicsWorld.immediate_raycast(physics_world, new_position, Vector3(0, 0, -1), 5, "closest", "collision_filter", collision_filter)

			if hit_position then
				position = hit_position
			end
		end
	end

	local targeting_decal = self.targeting_decal

	self.position:store(position)

	self.charge_value = math.min(math.max(t - time_to_shoot, 0)/self.charge_time, 1)
	local min_radius = self.min_radius
	local max_radius = self.max_radius
	local radius = math.min(max_radius, (max_radius - min_radius)*self.charge_value + min_radius)
	self.radius = radius
	local scale = radius*2

	World.move_particles(world, self.targeting_effect_id, position)
	World.set_particles_variable(world, self.targeting_effect_id, self.targeting_variable_id, Vector3(scale, scale, 1))

	local owner_unit = self.owner_unit
	local owner_player = Managers.player:owner(owner_unit)
	local is_bot = owner_player and owner_player.bot_player

	if not is_bot then
		local charge_sound_parameter_name = current_action.charge_sound_parameter_name

		if charge_sound_parameter_name then
			local wwise_world = self.wwise_world
			local wwise_source_id = self.wwise_source_id

			WwiseWorld.set_source_parameter(wwise_world, wwise_source_id, charge_sound_parameter_name, self.charge_value)
		end

		if self.charge_ready_sound_event and 1 <= self.charge_value then
			self.first_person_extension:play_hud_sound_event(self.charge_ready_sound_event)

			self.charge_ready_sound_event = nil
		end
	end

	return 
end
ActionGeiserTargeting.finish = function (self, reason, data)
	local world = self.world
	self.targeting_decal = nil
	local go_id = self.unit_id

	if self.is_server or LEVEL_EDITOR_TEST then
		self.network_transmit:send_rpc_clients("rpc_end_geiser", go_id)
	else
		self.network_transmit:send_rpc_server("rpc_end_geiser", go_id)
	end

	local charging_sound_id = self.charging_sound_id

	if charging_sound_id then
		ActionUtils.stop_charge_sound(self.wwise_world, charging_sound_id, self.wwise_source_id, self.current_action)

		self.wwise_source_id = nil
		self.charging_sound_id = nil
	end

	local chain_action_data = {
		radius = self.radius,
		range = self.range,
		height = self.height,
		charge_value = self.charge_value,
		position = self.position
	}

	if data and data.new_sub_action == "geiser_launch" then
		World.stop_spawning_particles(world, self.targeting_effect_id)

		chain_action_data.targeting_effect_id = self.targeting_effect_id
	else
		World.destroy_particles(world, self.targeting_effect_id)

		self.targeting_effect_id = nil
	end

	return chain_action_data
end
ActionGeiserTargeting.destroy = function (self)
	if self.targeting_effect_id then
		World.destroy_particles(self.world, self.targeting_effect_id)

		self.targeting_effect_id = nil
	end

	local charging_sound_id = self.charging_sound_id

	if charging_sound_id then
		ActionUtils.stop_charge_sound(self.wwise_world, charging_sound_id, self.wwise_source_id, self.current_action)

		self.wwise_source_id = nil
		self.charging_sound_id = nil
	end

	return 
end

return 