-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
LocomotionSystem = class(LocomotionSystem, ExtensionSystemBase)

require("scripts/unit_extensions/default_player_unit/player_unit_locomotion_extension")
require("scripts/unit_extensions/default_player_unit/player_husk_locomotion_extension")
require("scripts/entity_system/systems/locomotion/locomotion_templates_ai")
require("scripts/entity_system/systems/locomotion/locomotion_templates_ai_c")
require("scripts/entity_system/systems/locomotion/locomotion_templates_ai_husk")
require("scripts/entity_system/systems/locomotion/locomotion_templates_player")

local LocomotionTemplates = LocomotionTemplates
local RPCS = {
	"rpc_set_animation_driven_script_movement",
	"rpc_set_script_driven",
	"rpc_set_animation_driven",
	"rpc_set_animation_translation_scale",
	"rpc_set_animation_rotation_scale",
	"rpc_disable_locomotion",
	"rpc_teleport_unit_to",
	"rpc_enable_linked_movement",
	"rpc_disable_linked_movement",
	"rpc_add_external_velocity",
	"rpc_add_external_velocity_with_upper_limit",
	"rpc_constrain_ai",
	"rpc_set_on_moving_platform",
	"rpc_hot_join_nail_to_wall_fix"
}
local extensions = {
	"AiHuskLocomotionExtension",
	"AILocomotionExtension",
	"AILocomotionExtensionC",
	"PlayerHuskLocomotionExtension",
	"PlayerUnitLocomotionExtension"
}
LocomotionSystem.init = function (self, entity_system_creation_context, system_name)
	LocomotionSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))

	self.world = entity_system_creation_context.world
	self.animation_lod_units = {}
	self.animation_lod_unit_current = nil
	self.lod0 = 0
	self.lod1 = 0
	self.current_physics_test_unit = nil
	self.player_units = {}
	self.template_data = {}

	for template_name, template in pairs(LocomotionTemplates) do
		if template_name ~= "AILocomotionExtensionC" then
			local data = {}

			template.init(data, GLOBAL_AI_NAVWORLD)

			self.template_data[template_name] = data
		elseif template_name == "PlayerUnitLocomotionExtension" then
			local data = {}

			template.init(data, GLOBAL_AI_NAVWORLD)

			self.template_data[template_name] = data
		end
	end

	if EngineOptimizedExtensions.init_husk_extensions then
		EngineOptimizedExtensions.init_husk_extensions()

		if GameSettingsDevelopment.use_engine_optimized_ai_locomotion then
			local physics_world = World.get_data(self.world, "physics_world")
			local game_session = Managers.state.network:game()

			EngineOptimizedExtensions.init_extensions(physics_world, GLOBAL_AI_NAVWORLD, game_session)
		end
	else
		EngineOptimizedExtensions.init_extensions()
	end

	if not GameSettingsDevelopment.use_engine_optimized_ai_locomotion then
		extensions.AILocomotionExtensionC = nil
	end

	EngineOptimized.bone_lod_init(GameSettingsDevelopment.bone_lod_husks.lod_out_range_sq, GameSettingsDevelopment.bone_lod_husks.lod_in_range_sq, GameSettingsDevelopment.bone_lod_husks.lod_multiplier)

	return 
end
LocomotionSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)
	EngineOptimized.bone_lod_destroy()

	if EngineOptimizedExtensions.destroy_husk_extensions then
		EngineOptimizedExtensions.destroy_husk_extensions()

		if GameSettingsDevelopment.use_engine_optimized_ai_locomotion then
			EngineOptimizedExtensions.destroy_extensions()
		end
	else
		EngineOptimizedExtensions.destroy_extensions()
	end

	return 
end
LocomotionSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	extension_init_data.system_data = self.template_data[extension_name]
	local extension = LocomotionSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data)

	return extension
end
LocomotionSystem.extensions_ready = function (self, world, unit, extension_name)
	local extension = ScriptUnit.extension(unit, "locomotion_system")

	if extension_name == "AILocomotionExtensionC" or extension_name == "AILocomotionExtension" or extension_name == "AiHuskLocomotionExtension" then
		local breed = ScriptUnit.extension(unit, "ai_system")._breed
		local bone_lod_level = breed.bone_lod_level

		if 0 < bone_lod_level and not script_data.bone_lod_disable then
			extension.bone_lod_extension_id = EngineOptimized.bone_lod_register_extension(unit)
			self.animation_lod_units[unit] = extension
			extension.bone_lod_level = bone_lod_level

			Unit.set_bones_lod(unit, 1)

			self.lod1 = self.lod1 + 1
		end

		extension.time_to_check = 0
	else
		self.player_units[unit] = extension
	end

	return 
end
LocomotionSystem.on_remove_extension = function (self, unit, extension_name)
	self.on_freeze_extension(self, unit, extension_name)
	LocomotionSystem.super.on_remove_extension(self, unit, extension_name)

	return 
end
LocomotionSystem.on_freeze_extension = function (self, unit, extension_name)
	if extension_name == "AILocomotionExtensionC" or extension_name == "AILocomotionExtension" or extension_name == "AiHuskLocomotionExtension" then
		local extension = self.animation_lod_units[unit]

		if extension then
			EngineOptimized.bone_lod_unregister_extension(extension.bone_lod_extension_id)

			self.animation_lod_units[unit] = nil
		end
	end

	return 
end
LocomotionSystem.update = function (self, context, t)
	self.update_extensions(self, context, t)
	self.update_animation_lods(self)
	self.update_actor_proximity_shapes(self)
	self.debug_draw(self)

	return 
end
LocomotionSystem.update_extensions = function (self, context, t)
	local dt = context.dt

	Profiler.start("PlayerHuskLocomotionExtension")
	self.update_extension(self, "PlayerHuskLocomotionExtension", dt, context, t)
	Profiler.stop("PlayerHuskLocomotionExtension")
	Profiler.start("PlayerUnitLocomotionExtension")
	self.update_extension(self, "PlayerUnitLocomotionExtension", dt, context, t)
	Profiler.stop("PlayerUnitLocomotionExtension")
	Profiler.start("extension templates")

	if GameSettingsDevelopment.use_engine_optimized_ai_locomotion then
		LocomotionTemplates.AILocomotionExtensionC.update(nil, t, dt)

		local data = self.template_data.AiHuskLocomotionExtension

		LocomotionTemplates.AiHuskLocomotionExtension.update(data, t, dt)

		local data = self.template_data.PlayerUnitLocomotionExtension

		LocomotionTemplates.PlayerUnitLocomotionExtension.update(data, t, dt)
	else
		for template_name, data in pairs(self.template_data) do
			Profiler.start(template_name)

			local template = LocomotionTemplates[template_name]

			template.update(data, t, dt)
			Profiler.stop(template_name)
		end
	end

	Profiler.stop("extension templates")

	return 
end
LocomotionSystem.update_animation_lods = function (self)
	local player = Managers.player:local_player()
	local viewport_name = player.viewport_name
	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	EngineOptimized.bone_lod_update(self.world, camera)

	return 
end
LocomotionSystem.update_actor_proximity_shapes = function (self)
	Profiler.start("update_actor_proximity_shapes")

	local POSITION_LOOKUP = POSITION_LOOKUP
	local player_manager = Managers.player
	local physics_world = World.get_data(self.world, "physics_world")
	local default_insta_hit_cone_angle = math.degrees_to_radians(17)
	local Quaternion_forward = Quaternion.forward
	local human_and_bot_players = player_manager.human_and_bot_players(player_manager)

	for id, player in pairs(human_and_bot_players) do
		local unit = player.player_unit

		if unit and not player.remote then
			local first_persion_system = ScriptUnit.extension(unit, "first_person_system")
			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local position = first_persion_system.current_position(first_persion_system)
			local direction = Quaternion_forward(first_persion_system.current_rotation(first_persion_system))
			local angle = nil
			local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)

			if slot_name == "slot_ranged" then
				local equipment = inventory_extension.equipment(inventory_extension)
				local weapon_unit = equipment.right_hand_wielded_unit or equipment.left_hand_wielded_unit

				if weapon_unit and ScriptUnit.has_extension(weapon_unit, "spread_system") then
					local spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")
					local pitch, yaw = spread_extension.get_current_pitch_and_yaw(spread_extension)
					angle = math.degrees_to_radians(math.max(pitch, yaw))
				end
			end

			Profiler.start("commit_actor_proximity_shape")
			PhysicsWorld.commit_actor_proximity_shape(physics_world, position, direction, 36, angle, true)
			Profiler.stop("commit_actor_proximity_shape")
		end
	end

	Profiler.stop("update_actor_proximity_shapes")

	return 
end
LocomotionSystem.debug_draw = function (self)

	-- decompilation error in this vicinity
	local unit = script_data.debug_unit

	if not Unit.alive(unit) or not script_data.debug_ai_movement then
		return 
	end

	Profiler.start("Debug Draw")

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	Debug.text("AI LOCOMOTION DEBUG")
	Debug.text("  movement_type = %s", locomotion_extension.movement_type)
	Debug.text("  affected_by_gravity = %s", tostring(locomotion_extension._affected_by_gravity))
	Debug.text("  is_falling = %s", tostring(locomotion_extension._is_falling))
	Debug.text("  wanted_velocity = %s", tostring(locomotion_extension._wanted_velocity))
	Debug.text("  velocity = %s", tostring(locomotion_extension._velocity))
	Debug.text("  animation_translation_scale = %s", tostring(locomotion_extension._animation_translation_scale))
	Debug.text("  gravity = %s", tostring(locomotion_extension._gravity))
	Profiler.stop("Debug Draw")

	return 
end
LocomotionSystem.rpc_set_affected_by_gravity = function (self, sender, game_object_id, affected)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_affected_by_gravity(locomotion_extension, affected)

	return 
end
LocomotionSystem.rpc_set_animation_driven_movement = function (self, sender, game_object_id, animation_driven, script_driven_rotation, is_affected_by_gravity, position, rotation)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_animation_driven(locomotion_extension, animation_driven, is_affected_by_gravity, script_driven_rotation)

	if animation_driven then
		locomotion_extension.teleport_to(locomotion_extension, position, rotation, locomotion_extension.get_velocity(locomotion_extension))
	end

	return 
end
LocomotionSystem.rpc_set_animation_driven_script_movement = function (self, sender, game_object_id, position, rotation, is_affected_by_gravity)
	self.rpc_set_animation_driven_movement(self, sender, game_object_id, true, true, is_affected_by_gravity, position, rotation)

	return 
end
LocomotionSystem.rpc_set_animation_driven = function (self, sender, game_object_id, position, rotation, is_affected_by_gravity)
	self.rpc_set_animation_driven_movement(self, sender, game_object_id, true, false, is_affected_by_gravity, position, rotation)

	return 
end
LocomotionSystem.rpc_set_script_driven = function (self, sender, game_object_id, position, rotation, is_affected_by_gravity)
	self.rpc_set_animation_driven_movement(self, sender, game_object_id, false, true, is_affected_by_gravity)

	return 
end
LocomotionSystem.rpc_set_animation_translation_scale = function (self, sender, game_object_id, animation_translation_scale)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_animation_translation_scale(locomotion_extension, animation_translation_scale)

	return 
end
LocomotionSystem.rpc_set_animation_rotation_scale = function (self, sender, game_object_id, animation_rotation_scale)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_animation_rotation_scale(locomotion_extension, animation_rotation_scale)

	return 
end
LocomotionSystem.rpc_disable_locomotion = function (self, sender, game_object_id, disabled, update_func_id)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local func = LocomotionUtils[NetworkLookup.movement_funcs[update_func_id]]

	locomotion_extension.set_disabled(locomotion_extension, disabled, func)

	if self.is_server then
		self.network_transmit:send_rpc_clients_except("rpc_disable_locomotion", sender, game_object_id, disabled, update_func_id)
	end

	return 
end
LocomotionSystem.rpc_teleport_unit_to = function (self, sender, game_object_id, position, rotation)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.teleport_to(locomotion_extension, position, rotation)

	return 
end
LocomotionSystem.rpc_enable_linked_movement = function (self, sender, game_object_id, parent_level_unit_index, parent_node_index, offset)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local level = LevelHelper:current_level(self.world)
	local parent_unit = Level.unit_by_index(level, parent_level_unit_index)

	locomotion_extension.enable_linked_movement(locomotion_extension, parent_unit, parent_node_index, offset)

	return 
end
LocomotionSystem.rpc_disable_linked_movement = function (self, sender, game_object_id)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.disable_linked_movement(locomotion_extension)

	return 
end
LocomotionSystem.rpc_add_external_velocity = function (self, sender, game_object_id, velocity)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.add_external_velocity(locomotion_extension, velocity)

	return 
end
LocomotionSystem.rpc_add_external_velocity_with_upper_limit = function (self, sender, game_object_id, velocity, upper_limit)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.add_external_velocity(locomotion_extension, velocity, upper_limit)

	return 
end
LocomotionSystem.rpc_constrain_ai = function (self, sender, game_object_id, constrain, min, max)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_constrained(locomotion_extension, constrain, min, max)

	return 
end
LocomotionSystem.rpc_set_on_moving_platform = function (self, sender, game_object_id, unit_index)
	local unit = self.unit_storage:unit(game_object_id)

	if not unit then
		printf("unit from game_object_id %d is nil", game_object_id)

		return 
	end

	local level = LevelHelper:current_level(self.world)
	local platform_unit = Level.unit_by_index(level, unit_index)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_on_moving_platform(locomotion_extension, platform_unit)

	return 
end
LocomotionSystem.rpc_hot_join_nail_to_wall_fix = function (self, sender, game_object_id)
	local unit = self.unit_storage:unit(game_object_id)

	if Unit.has_animation_state_machine(unit) then
		Unit.animation_event(unit, "ragdoll")
	end

	return 
end

return 
