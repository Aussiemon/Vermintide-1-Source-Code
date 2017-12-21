require("scripts/helpers/mover_helper")

AiHuskLocomotionExtension = class(AiHuskLocomotionExtension)
AiHuskLocomotionExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._unit = unit
	self._system_data = extension_init_data.system_data
	self._game = extension_init_data.game
	self._go_id = extension_init_data.go_id

	Unit.set_animation_merge_options(unit)

	self._velocity = Vector3Box(0, 0, 0)
	self._breed = extension_init_data.breed

	if not self._breed.hit_zones_lookup then
		DamageUtils.create_hit_zone_lookup(unit, self._breed)
	end

	self._move_speed_anim_var = Unit.animation_find_variable(unit, "move_speed")
	self._animation_translation_scale = Vector3Box(1, 1, 1)
	self._animation_rotation_scale = 1
	self.is_affected_by_gravity = false
	local level_settings = LevelHelper:current_level_settings()
	local flow_event = level_settings.on_spawn_flow_event

	if flow_event then
		Unit.flow_event(unit, flow_event)
	end

	self.constrain_min = {
		0,
		0,
		0
	}
	self.constrain_max = {
		0,
		0,
		0
	}
	self.last_lerp_position = Vector3Box(Unit.local_position(unit, 0))
	self.last_lerp_position_offset = Vector3Box()
	self.accumulated_movement = Vector3Box()
	local has_teleported = GameSession.game_object_field(self._game, self._go_id, "has_teleported")
	self.has_teleported = has_teleported
	self._pos_lerp_time = 0
	self._update_function_name = "update_network_driven"
	self._mover_state = MoverHelper.create_mover_state()
	local collision_actor_name = "c_mover_collision"
	local has_collision_actor = Unit.actor(unit, collision_actor_name)

	if has_collision_actor then
		self._collision_state = MoverHelper.create_collision_state(unit, "c_mover_collision")
	end

	MoverHelper.set_active_mover(unit, self._mover_state, "mover")
	self.set_mover_disable_reason(self, "network_driven", true)

	self._system_data.all_update_units[unit] = self
	self._system_data.pure_network_update_units[unit] = self
	self._engine_extension_id = EngineOptimizedExtensions.ai_husk_locomotion_register_extension(unit, self._go_id, has_teleported)

	EngineOptimizedExtensions.ai_husk_locomotion_set_is_network_driven(self._engine_extension_id, true)

	return 
end
AiHuskLocomotionExtension.destroy = function (self)
	local unit = self._unit
	self._system_data.all_update_units[unit] = nil
	self._system_data.pure_network_update_units[unit] = nil
	self._system_data.other_update_units[unit] = nil

	if self._engine_extension_id then
		EngineOptimizedExtensions.ai_husk_locomotion_unregister_extension(self._engine_extension_id)

		self._engine_extension_id = nil
	end

	return 
end
AiHuskLocomotionExtension.set_animation_translation_scale = function (self, animation_translation_scale)
	self._animation_translation_scale = Vector3Box(animation_translation_scale)

	if self._engine_extension_id then
		EngineOptimizedExtensions.ai_husk_locomotion_set_animation_translation_scale(self._engine_extension_id, animation_translation_scale)
	end

	return 
end
AiHuskLocomotionExtension.set_animation_rotation_scale = function (self, animation_rotation_scale)
	self._animation_rotation_scale = animation_rotation_scale

	if self._engine_extension_id then
		EngineOptimizedExtensions.ai_husk_locomotion_set_animation_rotation_scale(self._engine_extension_id, animation_rotation_scale)
	end

	return 
end
AiHuskLocomotionExtension.set_affected_by_gravity = function (self, affected)
	self.is_affected_by_gravity = affected

	if self._engine_extension_id then
		EngineOptimizedExtensions.ai_husk_locomotion_set_is_affected_by_gravity(self._engine_extension_id, affected)
	end

	return 
end
AiHuskLocomotionExtension.set_animation_driven = function (self, is_animation_driven, is_affected_by_gravity, has_script_driven_rotation)
	if not self._engine_extension_id then
		return 
	end

	is_affected_by_gravity = not not is_affected_by_gravity
	self.is_animation_driven = is_animation_driven
	self.has_network_driven_rotation = has_script_driven_rotation
	self.is_affected_by_gravity = is_affected_by_gravity
	local network_driven = not is_animation_driven or not is_affected_by_gravity

	self.set_mover_disable_reason(self, "network_driven", network_driven)

	local system_data = self._system_data

	if network_driven then
		system_data.other_update_units[self._unit] = nil
		system_data.pure_network_update_units[self._unit] = self
	else
		system_data.pure_network_update_units[self._unit] = nil
		system_data.other_update_units[self._unit] = self
	end

	EngineOptimizedExtensions.ai_husk_locomotion_set_has_network_driven_rotation(self._engine_extension_id, has_script_driven_rotation)
	EngineOptimizedExtensions.ai_husk_locomotion_set_is_network_driven(self._engine_extension_id, network_driven)
	EngineOptimizedExtensions.ai_husk_locomotion_set_is_affected_by_gravity(self._engine_extension_id, is_affected_by_gravity)

	return 
end
AiHuskLocomotionExtension.set_mover_disable_reason = function (self, reason, state)
	MoverHelper.set_disable_reason(self._unit, self._mover_state, reason, state)

	return 
end
AiHuskLocomotionExtension.set_constrained = function (self, constrain, min, max)
	if not self._engine_extension_id then
		return 
	end

	self.is_constrained = constrain

	if constrain then
		Vector3Aux.box(self.constrain_min, min)
		Vector3Aux.box(self.constrain_max, max)
	end

	EngineOptimizedExtensions.ai_husk_locomotion_set_is_constrained(self._engine_extension_id, constrain, min, max)

	return 
end
AiHuskLocomotionExtension.teleport_to = function (self, position, rotation, velocity, dontseparate)
	if not self._engine_extension_id then
		return 
	end

	local unit = self._unit
	local mover = Unit.mover(unit)

	if mover and not dontseparate then
		Mover.set_position(mover, position)
		LocomotionUtils.separate_mover_fallbacks(mover, 1)

		position = Mover.position(mover)
	end

	velocity = velocity or Vector3(0, 0, 0)

	Unit.set_local_position(unit, 0, position)
	Unit.set_local_rotation(unit, 0, rotation)
	self._velocity:store(velocity)

	self._pos_lerp_time = 0

	EngineOptimizedExtensions.ai_husk_locomotion_teleport_to(self._engine_extension_id, position, rotation, velocity)

	return 
end
AiHuskLocomotionExtension.set_collision_disabled = function (self, reason, state)
	if self._collision_state then
		MoverHelper.set_collision_disable_reason(self._unit, self._collision_state, reason, state)
	end

	return 
end
AiHuskLocomotionExtension.get_velocity = function (self)
	return self._velocity:unbox()
end
AiHuskLocomotionExtension.hot_join_sync = function (self, sender)
	assert(false, "ai is never husk on server")

	return 
end

return 
