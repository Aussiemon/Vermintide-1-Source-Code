require("scripts/entity_system/systems/animation/animation_callback_templates")
require("scripts/unit_extensions/animation/level_unit_animation_extension")

AnimationSystem = class(AnimationSystem, ExtensionSystemBase)
local position_lookup = POSITION_LOOKUP
local RPCS = {
	"rpc_sync_anim_state_1",
	"rpc_sync_anim_state_3",
	"rpc_sync_anim_state_4",
	"rpc_sync_anim_state_5",
	"rpc_sync_anim_state_7",
	"rpc_sync_level_unit_anim_state_1",
	"rpc_anim_event",
	"rpc_anim_event_variable_float",
	"rpc_level_unit_anim_event",
	"rpc_link_unit",
	"rpc_set_ragdoll_start_parameters",
	"rpc_add_ragdoll_to_update_list",
	"rpc_ragdoll_update_done",
	"rpc_anim_set_variable_by_distance",
	"rpc_anim_set_variable_by_time",
	"rpc_update_anim_variable_done"
}
local extensions = {
	"LevelUnitAnimationExtension"
}
AnimationSystem.init = function (self, entity_system_creation_context, system_name)
	AnimationSystem.super.init(self, entity_system_creation_context, system_name, extensions)
	Managers.state.event:register(self, "animation_callback", "animation_callback")

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))

	self.nav_world = Managers.state.entity:system("ai_system"):nav_world()
	self.ragdoll_update_list = {}
	self.ragdoll_start_parameter_list = {}
	self.anim_variable_update_list = {}

	return 
end
AnimationSystem.destroy = function (self)
	table.clear(self.ragdoll_update_list)
	table.clear(self.ragdoll_start_parameter_list)
	self.network_event_delegate:unregister(self)

	return 
end
AnimationSystem.animation_callback = function (self, unit, callback, param)
	local cb = nil

	if self.is_server then
		cb = AnimationCallbackTemplates.server[callback]

		if cb then
			cb(unit, param)
		end
	end

	cb = AnimationCallbackTemplates.client[callback]

	if cb then
		cb(unit, param)
	end

	return 
end
AnimationSystem.set_ragdoll_start_parameters = function (self, unit, position, rotation, velocity, mass)
	if self.ragdoll_start_parameter_list[unit] ~= nil then
		self.ragdoll_start_parameter_list[unit].position:store(position)
		self.ragdoll_start_parameter_list[unit].rotation:store(rotation)

		self.ragdoll_start_parameter_list[unit].pos_rot_synched = nil

		self.ragdoll_start_parameter_list[unit].velocity:store(velocity)

		self.ragdoll_start_parameter_list[unit].mass = mass
	else
		self.ragdoll_start_parameter_list[unit] = {
			position = Vector3Box(position),
			rotation = QuaternionBox(rotation),
			velocity = Vector3Box(velocity),
			mass = mass
		}
	end

	return 
end
AnimationSystem.add_ragdoll_to_update_list = function (self, unit, breed)
	if self.ragdoll_update_list[unit] ~= nil then
		local prev_pos_box = self.ragdoll_update_list[unit].prev_pos
		local push_start_t = self.ragdoll_update_list[unit].push_started_at_t
		local push_has_ended = self.ragdoll_update_list[unit].push_has_ended
		local pos_sample_t = self.ragdoll_update_list[unit].pos_sample_taken_at_t
		self.ragdoll_update_list[unit].prev_pos = prev_pos_box
		self.ragdoll_update_list[unit].push_started_at_t = push_start_t
		self.ragdoll_update_list[unit].push_has_ended = push_has_ended
		self.ragdoll_update_list[unit].pos_sample_taken_at_t = pos_sample_t
		self.ragdoll_update_list[unit].breed = breed
	else
		self.ragdoll_update_list[unit] = {
			breed = breed
		}
	end

	return 
end
AnimationSystem.update = function (self, context, t)
	self.update_ragdolls(self, context, t)
	self.update_anim_variables(self, t)

	return 
end
AnimationSystem.update_anim_variables = function (self, t)
	local position_lookup = position_lookup
	local vector3_length = Vector3.length
	local unit_alive = Unit.alive
	local s = 0

	for unit, data in pairs(self.anim_variable_update_list) do
		local pos = position_lookup[unit]

		if pos then
			local anim_value = nil

			if data.goal_pos then
				local pos = position_lookup[unit]
				local to_target = data.goal_pos:unbox() - pos

				if data.flat_distance then
					to_target = Vector3.flat(to_target)
				end

				local distance = vector3_length(to_target)
				local scale = data.scale
				anim_value = math.clamp(scale - (scale*distance)/data.initial_distance, 0, scale)
			else
				local jump_time = t - data.start_time
				local scale = data.scale
				anim_value = math.clamp((scale*jump_time)/data.duration, 0, scale)
			end

			Unit.animation_set_variable(unit, data.anim_variable_index, anim_value)

			s = s + 1
		else
			self.anim_variable_update_list[unit] = nil
		end
	end

	return 
end
AnimationSystem.update_ragdolls = function (self, context, t)
	for unit, data in pairs(self.ragdoll_update_list) do
		local is_alive = Unit.alive(unit) and ScriptUnit.extension(unit, "health_system"):is_alive()
		local push_has_ended = data.push_has_ended

		if is_alive and not push_has_ended then
			local start_parameter_list = self.ragdoll_start_parameter_list[unit]

			if start_parameter_list then
				if not start_parameter_list.pos_rot_synched then
					self._synch_pos_rot(self, unit, start_parameter_list)
				else
					self._start_ragdoll_push(self, unit, start_parameter_list, data, t)
				end
			elseif self.is_server then
				self._update_ragdoll(self, unit, data, t)
			end
		elseif push_has_ended then
			if self.is_server then
				local blackboard = Unit.get_data(unit, "blackboard")
				blackboard.ragdoll = nil

				Managers.state.network:anim_event(unit, "reset")
			end

			ScriptUnit.extension(unit, "locomotion_system"):set_movement_type("script_driven")
			self._create_hit_actors(self, unit, data.breed)

			self.ragdoll_update_list[unit] = nil
		else
			self.ragdoll_update_list[unit] = nil
		end
	end

	return 
end
AnimationSystem._synch_pos_rot = function (self, unit, parameter_list)
	local position = parameter_list.position:unbox()
	local rotation = parameter_list.rotation:unbox()

	Unit.teleport_local_position(unit, 0, position)
	Unit.teleport_local_rotation(unit, 0, rotation)

	parameter_list.pos_rot_synched = true

	if self.is_server then
		Managers.state.network:anim_event(unit, "ragdoll")
	end

	return 
end
AnimationSystem._start_ragdoll_push = function (self, unit, parameter_list, ragdoll_data, t)
	local actor = Unit.actor(unit, "j_spine")

	if actor ~= nil then
		local breed = ragdoll_data.breed

		self._destroy_hit_actors(self, unit, breed)

		local velocity = parameter_list.velocity:unbox()
		local mass = parameter_list.mass

		if not breed.physics_actors_lookup then
			self._get_physics_actors(self, unit, breed)
		end

		local zero_vector = Vector3(0, 0, 0)

		for index, ragdoll_actor_name in pairs(breed.physics_actors_lookup) do
			local ragdoll_actor = Unit.actor(unit, ragdoll_actor_name)

			Actor.set_velocity(ragdoll_actor, zero_vector)
		end

		Actor.push(actor, velocity, mass)
		ScriptUnit.extension(unit, "locomotion_system"):set_movement_type("script_driven")

		local position = Unit.local_position(unit, 0)

		if ragdoll_data.prev_pos ~= nil then
			ragdoll_data.prev_pos:store(position)
		else
			ragdoll_data.prev_pos = Vector3Box(position)
		end

		ragdoll_data.push_started_at_t = t
		ragdoll_data.pos_sample_taken_at_t = t
		self.ragdoll_start_parameter_list[unit] = nil
	end

	return 
end
local POS_CHECK_INTERVAL = 1
local MIN_POS_DIFF_THRESHOLD = 0.05
local MAX_POS_DIFF_THRESHOLD = 1
AnimationSystem._update_ragdoll = function (self, unit, ragdoll_data, t)
	local spine_actor = Unit.actor(unit, "j_spine")
	local spine_actor_pos = Actor.position(spine_actor)

	Unit.teleport_local_position(unit, 0, spine_actor_pos)

	if POS_CHECK_INTERVAL < t - ragdoll_data.pos_sample_taken_at_t then
		local prev_pos = ragdoll_data.prev_pos:unbox()
		local pos_diff = Vector3.length(prev_pos - spine_actor_pos)
		local pos_diff_threshold = self.get_pos_diff_threshold(self, ragdoll_data.push_started_at_t, t, MIN_POS_DIFF_THRESHOLD, MAX_POS_DIFF_THRESHOLD)
		local not_moving = pos_diff < pos_diff_threshold

		if not_moving then
			local hips_actor = Unit.actor(unit, "j_hips")
			local hips_actor_pos = Actor.position(hips_actor)
			local nav_world = self.nav_world
			local success, altitude = GwNavQueries.triangle_from_position(nav_world, hips_actor_pos, 1, 1)
			local pos_on_mesh = (success and Vector3(hips_actor_pos.x, hips_actor_pos.y, altitude)) or nil

			if pos_on_mesh == nil then
				local damage_extension = ScriptUnit.extension(unit, "damage_system")

				assert(damage_extension)

				local damage_amount = 255
				local hit_zone_name = "torso"
				local damage_type = "cutting"
				local damage_direction = Vector3(0, 0, -1)

				DamageUtils.add_damage_network(unit, unit, damage_amount, hit_zone_name, damage_type, damage_direction)

				self.ragdoll_update_list[unit] = nil
			else
				Unit.teleport_local_position(unit, 0, pos_on_mesh)

				ragdoll_data.push_has_ended = true
				local network_manager = Managers.state.network
				local unit_id = network_manager.unit_game_object_id(network_manager, unit)

				self.network_transmit:send_rpc_clients("rpc_ragdoll_update_done", unit_id)
			end
		else
			ragdoll_data.prev_pos:store(spine_actor_pos)

			ragdoll_data.pos_sample_taken_at_t = t
		end
	end

	return 
end
local POS_DIFF_RAMP_START_TIME = 5
local POS_DIFF_DENOMINATOR = -0.0009775171065493646
AnimationSystem.get_pos_diff_threshold = function (self, start_t, t, min_threshold, max_threshold)
	local diff_t = t - start_t

	if POS_DIFF_RAMP_START_TIME < diff_t then
		local x = diff_t - POS_DIFF_RAMP_START_TIME
		local c = (max_threshold - min_threshold*1024)*POS_DIFF_DENOMINATOR
		local b = min_threshold - c
		local pos_diff_threshold = math.clamp(b*math.pow(2, x) + c, min_threshold, max_threshold)

		return pos_diff_threshold
	else
		return min_threshold
	end

	return 
end
AnimationSystem._destroy_hit_actors = function (self, unit, breed)
	if not breed.hit_zones_actor_lookup then
		self._get_hit_zone_actors(self, unit, breed)
	end

	for index, actor_name in pairs(breed.hit_zones_actor_lookup) do
		Unit.destroy_actor(unit, actor_name)
	end

	return 
end
AnimationSystem._create_hit_actors = function (self, unit, breed)
	if not breed.hit_zones_actor_lookup then
		self._get_hit_zone_actors(self, unit, breed)
	end

	for index, actor_name in pairs(breed.hit_zones_actor_lookup) do
		Unit.create_actor(unit, actor_name)
	end

	return 
end
AnimationSystem._get_hit_zone_actors = function (self, unit, breed)
	local hit_zones = breed.hit_zones
	local hit_zones_actor_lookup = {}

	for zone_name, zone in pairs(hit_zones) do
		for k, actor_name in ipairs(zone.actors) do
			local actor = Unit.actor(unit, actor_name)

			if not actor then
				print("Actor ", actor_name .. " not found in ", breed.name)
			end

			hit_zones_actor_lookup[#hit_zones_actor_lookup + 1] = actor_name
		end
	end

	breed.hit_zones_actor_lookup = hit_zones_actor_lookup

	return 
end
AnimationSystem._get_physics_actors = function (self, unit, breed)
	local physics_actors = breed.physics_actors
	local physics_actors_lookup = {}

	for zone_name, zone in pairs(physics_actors) do
		for k, actor_name in ipairs(zone.actors) do
			local actor = Unit.actor(unit, actor_name)

			if not actor then
				print("Actor ", actor_name .. " not found in ", breed.name)
			end

			physics_actors_lookup[#physics_actors_lookup + 1] = actor_name
		end
	end

	breed.physics_actors_lookup = physics_actors_lookup

	return 
end
AnimationSystem.rpc_sync_anim_state = function (self, sender, go_id, ...)
	local unit = self.unit_storage:unit(go_id)

	Unit.animation_set_state(unit, ...)

	return 
end
AnimationSystem.rpc_sync_level_unit_anim_state = function (self, sender, level_unit_index, ...)
	local world = self.world
	local unit = LevelHelper:unit_by_index(world, level_unit_index)

	Unit.animation_set_state(unit, ...)

	return 
end
AnimationSystem.rpc_sync_anim_state_1 = AnimationSystem.rpc_sync_anim_state
AnimationSystem.rpc_sync_anim_state_3 = AnimationSystem.rpc_sync_anim_state
AnimationSystem.rpc_sync_anim_state_4 = AnimationSystem.rpc_sync_anim_state
AnimationSystem.rpc_sync_anim_state_5 = AnimationSystem.rpc_sync_anim_state
AnimationSystem.rpc_sync_anim_state_7 = AnimationSystem.rpc_sync_anim_state
AnimationSystem.rpc_sync_level_unit_anim_state_1 = AnimationSystem.rpc_sync_level_unit_anim_state
AnimationSystem.rpc_anim_event_variable_float = function (self, sender, anim_id, go_id, variable_id, variable_value)
	local unit = self.unit_storage:unit(go_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	if self.is_server then
		self.network_transmit:send_rpc_clients_except("rpc_anim_event_variable_float", sender, anim_id, go_id, variable_id, variable_value)
	end

	if Unit.has_animation_state_machine(unit) then
		local event = NetworkLookup.anims[anim_id]

		assert(event, "[GameNetworkManager] Lookup missing for event_id", anim_id)

		local variable_name = NetworkLookup.anims[variable_id]
		local variable_index = Unit.animation_find_variable(unit, variable_name)

		Unit.animation_set_variable(unit, variable_index, variable_value)
		Unit.animation_event(unit, event)
	end

	return 
end
AnimationSystem.rpc_anim_event = function (self, sender, anim_id, go_id)
	local unit = self.unit_storage:unit(go_id)

	if not unit or not Unit.alive(unit) then
		return 
	end

	if self.is_server then
		self.network_transmit:send_rpc_clients_except("rpc_anim_event", sender, anim_id, go_id)
	end

	if Unit.has_animation_state_machine(unit) then
		local event = NetworkLookup.anims[anim_id]

		assert(event, "[GameNetworkManager] Lookup missing for event_id", anim_id)
		Unit.animation_event(unit, event)
	end

	return 
end
AnimationSystem.rpc_level_unit_anim_event = function (self, sender, anim_id, level_unit_index)
	local world = self.world
	local unit = LevelHelper:unit_by_index(world, level_unit_index)

	if not unit or not Unit.alive(unit) then
		return 
	end

	if self.is_server then
		self.network_transmit:send_rpc_clients_except("rpc_level_unit_anim_event", sender, anim_id, level_unit_index)
	end

	if Unit.has_animation_state_machine(unit) then
		local event = NetworkLookup.anims[anim_id]

		assert(event, "[GameNetworkManager] Lookup missing for event_id", anim_id)
		Unit.animation_event(unit, event)
	end

	return 
end
AnimationSystem.rpc_link_unit = function (self, sender, child_unit_id, child_node, parent_unit_id, parent_node)
	local child_unit = self.unit_storage:unit(child_unit_id)
	local parent_unit = self.unit_storage:unit(parent_unit_id)
	local world = Unit.world(parent_unit)

	World.link_unit(world, child_unit, child_node, parent_unit, parent_node)

	return 
end
AnimationSystem.rpc_set_ragdoll_start_parameters = function (self, sender, unit_id, int_position, int_rotation, int_velocity, mass)
	local unit = self.unit_storage:unit(unit_id)
	local truncated_velocity = AiAnimUtils.velocity_network_scale(int_velocity, false)
	local truncated_position = AiAnimUtils.position_network_scale(int_position, false)
	local truncated_rotation = AiAnimUtils.rotation_network_scale(int_rotation, false)

	self.set_ragdoll_start_parameters(self, unit, truncated_position, truncated_rotation, truncated_velocity, mass)

	return 
end
AnimationSystem.rpc_add_ragdoll_to_update_list = function (self, sender, unit_id)
	local unit = self.unit_storage:unit(unit_id)
	local breed = Unit.get_data(unit, "breed")

	self.add_ragdoll_to_update_list(self, unit, breed)

	return 
end
AnimationSystem.rpc_ragdoll_update_done = function (self, sender, unit_id)
	local unit = self.unit_storage:unit(unit_id)
	self.ragdoll_update_list[unit].push_has_ended = true

	return 
end
AnimationSystem.rpc_anim_set_variable_by_distance = function (self, sender, unit_id, anim_variable_index, goal_pos, scale, flat_distance)
	local unit = self.unit_storage:unit(unit_id)

	self._set_variable_by_distance(self, unit, anim_variable_index, goal_pos, scale, flat_distance)

	return 
end
AnimationSystem._set_variable_by_distance = function (self, unit, anim_variable_index, goal_pos, scale, flat_distance)
	local data = self.anim_variable_update_list[unit]
	local pos = position_lookup[unit]
	local to_target = goal_pos - pos

	if flat_distance then
		to_target = Vector3.flat(to_target)
	end

	local initial_distance = Vector3.length(to_target)

	fassert(0 < initial_distance, "Setting initial distance to 0, this will cause div by 0 later.")

	local data = self.anim_variable_update_list[unit]

	if data then
		data.goal_pos = Vector3Box(goal_pos)
		data.initial_distance = initial_distance
		data.scale = scale
		data.anim_variable_index = anim_variable_index
	else
		self.anim_variable_update_list[unit] = {
			unit = unit,
			goal_pos = Vector3Box(goal_pos),
			anim_variable_index = anim_variable_index,
			initial_distance = initial_distance,
			scale = scale,
			flat_distance = flat_distance
		}
	end

	return 
end
AnimationSystem.rpc_anim_set_variable_by_time = function (self, sender, unit_id, anim_variable_index, int_16bit_duration, scale)
	local unit = self.unit_storage:unit(unit_id)
	local duration = int_16bit_duration*0.00390625

	self._set_variable_by_time(self, unit, anim_variable_index, duration, scale)

	return 
end
AnimationSystem._set_variable_by_time = function (self, unit, anim_variable_index, duration, scale)
	local data = self.anim_variable_update_list[unit]
	local t = Managers.time:time("game")

	if data then
		data.start_time = t
		data.duration = duration
		data.scale = scale
		data.anim_variable_index = anim_variable_index
	else
		self.anim_variable_update_list[unit] = {
			unit = unit,
			start_time = t,
			duration = duration,
			anim_variable_index = anim_variable_index,
			scale = scale
		}
	end

	return 
end
AnimationSystem.rpc_update_anim_variable_done = function (self, sender, unit_id)
	local unit = self.unit_storage:unit(unit_id)

	if self.anim_variable_update_list[unit] then
		self.anim_variable_update_list[unit] = nil
	end

	return 
end
AnimationSystem.set_update_anim_variable_done = function (self, unit)
	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	self.network_transmit:send_rpc_clients("rpc_update_anim_variable_done", unit_id)

	self.anim_variable_update_list[unit] = nil

	return 
end
AnimationSystem.start_anim_variable_update_by_distance = function (self, unit, anim_variable_index, goal_pos, scale, flat_distance)
	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	self.network_transmit:send_rpc_clients("rpc_anim_set_variable_by_distance", unit_id, anim_variable_index, goal_pos, scale, flat_distance)
	self._set_variable_by_distance(self, unit, anim_variable_index, goal_pos, scale, flat_distance)

	return 
end
AnimationSystem.start_anim_variable_update_by_time = function (self, unit, anim_variable_index, duration, scale)
	local int_16bit_duration = math.clamp(duration*256, 0, 65535)
	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	self.network_transmit:send_rpc_clients("rpc_anim_set_variable_by_time", unit_id, anim_variable_index, int_16bit_duration, scale)
	self._set_variable_by_time(self, unit, anim_variable_index, duration, scale)

	return 
end

return 
