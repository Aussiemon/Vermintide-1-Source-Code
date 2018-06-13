ProjectileTrueFlightLocomotionExtension = class(ProjectileTrueFlightLocomotionExtension)

ProjectileTrueFlightLocomotionExtension.init = function (self, extension_init_context, unit, extension_init_data)
	local world = extension_init_context.world
	local gravity_settings = extension_init_data.gravity_settings or "default"
	local initial_position = extension_init_data.initial_position
	self.t = Managers.time:time("game") - (extension_init_data.fast_forward_time or 0)
	self.target_unit = extension_init_data.target_unit

	if self.target_unit then
		self.target_node = "c_head"
	end

	self.unit = unit
	self.world = world
	self.gravity_settings = gravity_settings
	self.gravity = ProjectileGravitySettings[gravity_settings]
	self.velocity = Vector3Box()
	self.speed = extension_init_data.speed
	self.initial_position_boxed = Vector3Box(initial_position)
	self.true_flight_template = extension_init_data.true_flight_template_name

	assert(self.true_flight_template, "no true_flight_template")

	self.trajectory_template_name = extension_init_data.trajectory_template_name

	assert(self.trajectory_template_name)

	self.raycast_timer = 0
	self.target_vector = extension_init_data.target_vector
	self.current_direction = Vector3Box(self.target_vector)
	self.target_vector = Vector3.normalize(Vector3.flat(self.target_vector))
	self.target_vector_boxed = Vector3Box(self.target_vector)
	self.owner_unit = extension_init_data.owner_unit
	self.is_husk = not not extension_init_data.is_husk
	local network_manager = Managers.state.network
	self.network_manager = network_manager
	self.angle = math.degrees_to_radians(extension_init_data.angle)
	self.stopped = false
	self.moved = false
	self.spawn_time = Managers.time:time("game")
	self.life_time = 0
	self.on_target_time = 0

	Unit.set_local_position(unit, 0, initial_position)

	self.hit_units = {}
end

ProjectileTrueFlightLocomotionExtension.update = function (self, unit, input, dt, context, t)
	self.dt = t - self.t
	self.moved = false
	self.on_target_time = self.on_target_time + dt

	if self.stopped then
		return
	end

	if self.is_husk then
		local game = Managers.state.network:game()
		local id = Managers.state.unit_storage:go_id(unit)

		if game and id then
			local position = GameSession.game_object_field(game, id, "position")
			local rotation = GameSession.game_object_field(game, id, "rotation")

			Unit.set_local_position(unit, 0, position)
			Unit.set_local_rotation(unit, 0, rotation)
		end

		return
	end

	local current_position = POSITION_LOOKUP[unit]
	local target = self.target_unit
	local has_good_target = false
	local can_see_target = false

	if target and Unit.alive(target) and ScriptUnit.has_extension(target, "health_system") then
		local health_extension = ScriptUnit.extension(target, "health_system")

		if health_extension:is_alive() and not self.hit_units[target] then
			has_good_target = true

			if self:legitimate_target(target, current_position) then
				can_see_target = true
			end
		end
	end

	local new_position = nil

	if can_see_target then
		new_position = self:update_towards_target(current_position, dt)
	elseif not has_good_target then
		if target and Unit.alive(target) and ScriptUnit.has_extension(target, "outline_system") then
			local target_outline_extension = ScriptUnit.extension(target, "outline_system")

			target_outline_extension.set_method("never")
		end

		local position, new_target = self:update_seeking_target(current_position, dt, t, self.on_target_time < 0.75)
		new_position = position
		self.target_unit = new_target
	else
		local position, new_target = self:update_seeking_target(current_position, dt, t, false)
		new_position = position
	end

	if not self:valid_position(new_position) then
		self:stop()
		Managers.state.unit_spawner:mark_for_deletion(self.unit)

		return
	end

	local direction = new_position - current_position
	local length = Vector3.length(direction)

	if length <= 0.001 then
		return
	end

	if script_data.debug_projectiles then
		QuickDrawerStay:line(current_position, new_position, Color(255, 255, 255, 0))
	end

	local direction_norm = Vector3.normalize(direction)
	local rotation = Quaternion.look(direction_norm)

	Unit.set_local_position(unit, 0, new_position)
	Unit.set_local_rotation(unit, 0, rotation)

	local game = Managers.state.network:game()
	local id = Managers.state.unit_storage:go_id(unit)

	if game and id then
		GameSession.set_game_object_field(game, id, "position", new_position)
		GameSession.set_game_object_field(game, id, "rotation", rotation)
	end

	self.velocity:store(direction)
	self.current_direction:store(direction_norm)

	self.t = t

	self.target_vector_boxed:store(Vector3.normalize(Vector3.flat(direction_norm)))
	self.initial_position_boxed:store(new_position)

	self.angle = math.degrees_to_radians(DamageUtils.pitch_from_rotation(rotation))
	self.moved = true
end

ProjectileTrueFlightLocomotionExtension.valid_position = function (self, position)
	local min = NetworkConstants.position.min
	local max = NetworkConstants.position.max

	for i = 1, 3, 1 do
		local coord = position[i]

		if coord < min or max < coord then
			print("[ProjectileTrueFlightLocomotionExtension] position is not valid, outside of NetworkConstants.position")

			return false
		end
	end

	return true
end

ProjectileTrueFlightLocomotionExtension.update_towards_target = function (self, position, dt)
	local unit = self.unit
	local target_unit = self.target_unit
	local current_direction = self.current_direction:unbox()
	local template = TrueFlightTemplates[self.true_flight_template]
	local dot_threshold = template.dot_threshold
	local lerp_squared_distance_threshold = template.lerp_squared_distance_threshold
	local lerp_constant = template.lerp_constant
	local speed_multiplier = template.speed_multiplier
	local target_position = Unit.world_position(target_unit, Unit.node(target_unit, self.target_node))
	local required_velocity = target_position - position
	local distance = Vector3.length(required_velocity)
	local wanted_direction = Vector3.normalize(required_velocity)
	local dot_value = Vector3.dot(current_direction, wanted_direction)
	local current_rotation = Quaternion.look(current_direction)
	local wanted_rotation = Quaternion.look(wanted_direction)
	local lerp_modifier = (distance < 5 and 1) or 5 / distance
	lerp_modifier = lerp_modifier * lerp_modifier * math.min(self.on_target_time, 0.25) / 0.25
	local lerp_value = math.min(dt * lerp_modifier * 100, 0.75)
	local new_rotation = Quaternion.lerp(current_rotation, wanted_rotation, lerp_value)
	local new_direction = Quaternion.forward(new_rotation)
	local speed = self.speed * speed_multiplier
	local new_position = position + new_direction * speed * dt

	return new_position
end

ProjectileTrueFlightLocomotionExtension.update_seeking_target = function (self, position, dt, t, seeking)
	local speed_multiplier = TrueFlightTemplates[self.true_flight_template].speed_multiplier
	local dt = self.dt
	local speed = self.speed * speed_multiplier
	local angle = self.angle
	local gravity = self.gravity
	local target_vector = Vector3Box.unbox(self.target_vector_boxed)
	local initial_position = Vector3Box.unbox(self.initial_position_boxed)
	local trajectory_template_name = self.trajectory_template_name
	local is_husk = self.is_husk
	local trajectory = ProjectileTemplates.get_trajectory_template(trajectory_template_name, is_husk)
	local new_position = trajectory.update(speed, angle, gravity, initial_position, target_vector, dt)
	local target = seeking and self:find_new_target(position, dt, t)

	return new_position, target
end

ProjectileTrueFlightLocomotionExtension.find_new_target = function (self, position, dt, t)
	if self.raycast_timer < t then
		local time_between_raycasts = TrueFlightTemplates[self.true_flight_template].time_between_raycasts
		self.raycast_timer = t + time_between_raycasts
		local target = self:find_broadphase_target(position)
		self.target_node = "c_spine"

		return target
	end
end

local ai_units = {}

ProjectileTrueFlightLocomotionExtension.find_broadphase_target = function (self, position)
	local broadphase_radius = TrueFlightTemplates[self.true_flight_template].broadphase_radius

	table.clear(ai_units)

	local ai_units_n = 0

	if self.target_position then
		ai_units_n = AiUtils.broadphase_query(self.target_position:unbox(), 5, ai_units)
	else
		local current_direction = self.current_direction:unbox()
		ai_units_n = AiUtils.broadphase_query(position + current_direction * 10, 4, ai_units)

		if ai_units_n <= 0 then
			ai_units_n = AiUtils.broadphase_query(position + current_direction * 20, 10, ai_units)
		end
	end

	if ai_units_n > 0 then
		table.shuffle(ai_units)

		for i = 1, ai_units_n, 1 do
			local unit = ai_units[i]

			if ScriptUnit.has_extension(unit, "health_system") then
				local health_extension = ScriptUnit.extension(unit, "health_system")

				if health_extension:is_alive() and not self.hit_units[unit] and self:legitimate_target(unit, position) then
					return unit
				end
			end
		end
	end

	return nil
end

ProjectileTrueFlightLocomotionExtension.legitimate_target = function (self, unit, position)
	local target_position = Unit.world_position(unit, Unit.node(unit, "c_head"))
	local current_direction = self.current_direction:unbox()
	local direction_to_target = target_position - position
	local wanted_direction = Vector3.normalize(direction_to_target)
	local dot_value = Vector3.dot(current_direction, wanted_direction)

	if dot_value > -0.75 then
		local physics_world = World.get_data(self.world, "physics_world")
		local result = PhysicsWorld.immediate_raycast_actors(physics_world, position, wanted_direction, 900, "static_collision_filter", "filter_player_ray_projectile_static_only", "dynamic_collision_filter", "filter_player_ray_projectile_ai_only", "dynamic_collision_filter", "filter_player_ray_projectile_hitbox_only")
		local INDEX_POSITION = 1
		local INDEX_DISTANCE = 2
		local INDEX_NORMAL = 3
		local INDEX_ACTOR = 4

		if result then
			for index, hit in pairs(result) do
				local hit_actor = hit[INDEX_ACTOR]
				local potential_hit_unit = Actor.unit(hit_actor)

				if potential_hit_unit ~= self.owner_unit then
					local breed = Unit.get_data(potential_hit_unit, "breed")

					if breed then
						if potential_hit_unit == unit then
							return true
						end
					else
						return false
					end
				end
			end
		end
	else
		local target = self.target_unit

		if target and Unit.alive(target) and ScriptUnit.has_extension(target, "outline_system") then
			local target_outline_extension = ScriptUnit.extension(target, "outline_system")

			target_outline_extension.set_method("never")
		end

		self.target_unit = nil
	end

	return false
end

ProjectileTrueFlightLocomotionExtension.use_this_later = function (self, unit, position, dt)
	local target_unit = self.target_unit
	local current_direction = self.current_direction:unbox()
	local template = TrueFlightTemplates[self.true_flight_template]
	local dot_threshold = template.dot_threshold
	local lerp_squared_distance_threshold = template.lerp_squared_distance_threshold
	local lerp_constant = template.lerp_constant
	local speed_multiplier = template.speed_multiplier
	local target_position = Unit.world_position(target_unit, Unit.node(target_unit, "c_head"))
	local required_velocity = target_position - position
	local distance = Vector3.length(required_velocity)
	local wanted_direction = Vector3.normalize(required_velocity)
	local dot_value = Vector3.dot(current_direction, wanted_direction)
	local new_direction = current_direction

	if dot_value > -0.75 then
		local up_vector = Vector3.up()
		local right_vector = Vector3.right()
		local current_rotation = Quaternion.look(current_direction)
		local wanted_rotation = Quaternion.look(wanted_direction)
		local lerp_modifier = math.max(lerp_squared_distance_threshold - distance * distance, 1) / lerp_squared_distance_threshold
		lerp_modifier = lerp_modifier * lerp_modifier
		local new_rotation = Quaternion.lerp(current_rotation, wanted_rotation, dt * lerp_modifier * lerp_constant)
		new_direction = Quaternion.forward(new_rotation)
	end

	local speed = self.speed * speed_multiplier
	local new_position = position + direction * speed * dt

	return new_position
end

ProjectileTrueFlightLocomotionExtension.moved_this_frame = function (self)
	return self.moved
end

ProjectileTrueFlightLocomotionExtension.current_velocity = function (self)
	return self.velocity:unbox()
end

ProjectileTrueFlightLocomotionExtension.destroy = function (self)
	local target = self.target_unit

	if target and Unit.alive(target) and ScriptUnit.has_extension(target, "outline_system") then
		local target_outline_extension = ScriptUnit.extension(target, "outline_system")

		target_outline_extension.set_method("never")
	end

	self.hit_units = nil
end

ProjectileTrueFlightLocomotionExtension.notify_hit_enemy = function (self, hit_unit)
	self.hit_units[hit_unit] = true
end

ProjectileTrueFlightLocomotionExtension.stop = function (self)
	self.stopped = true
	local target = self.target_unit

	if target and Unit.alive(target) and ScriptUnit.has_extension(target, "outline_system") then
		local target_outline_extension = ScriptUnit.extension(target, "outline_system")

		target_outline_extension.set_method("never")
	end
end

return
