require("scripts/entity_system/systems/extension_system_base")
require("scripts/entity_system/systems/aggro/aggro_system")
require("scripts/entity_system/systems/ai/ai_system")
require("scripts/entity_system/systems/ai/ai_melee_line_of_sight_system")
require("scripts/entity_system/systems/ai/ai_bot_group_system")
require("scripts/entity_system/systems/ai/ai_group_system")
require("scripts/entity_system/systems/ai/ai_inventory_system")
require("scripts/entity_system/systems/ai/ai_inventory_item_system")
require("scripts/entity_system/systems/ai/ai_interest_point_system")
require("scripts/entity_system/systems/ai/ai_commander_system")
require("scripts/entity_system/systems/ai/ai_navigation_system")
require("scripts/entity_system/systems/ai/ai_slot_system")
require("scripts/entity_system/systems/ai/nav_graph_system")
require("scripts/entity_system/systems/animation/animation_system")
require("scripts/entity_system/systems/attachment/attachment_system")
require("scripts/entity_system/systems/area_damage/area_damage_system")
require("scripts/entity_system/systems/audio/audio_system")
require("scripts/entity_system/systems/buff/buff_system")
require("scripts/entity_system/systems/camera/camera_system")
require("scripts/entity_system/systems/cutscene/cutscene_system")
require("scripts/entity_system/systems/damage/damage_system")
require("scripts/entity_system/systems/darkness/darkness_system")
require("scripts/entity_system/systems/damage/death_system")
require("scripts/entity_system/systems/damage/health_system")
require("scripts/entity_system/systems/damage/health_trigger_system")
require("scripts/entity_system/systems/dialogues/dialogue_system")
require("scripts/entity_system/systems/dialogues/dialogue_context_system")
require("scripts/entity_system/systems/dialogues/surrounding_aware_system")
require("scripts/entity_system/systems/doors/door_system")
require("scripts/entity_system/systems/first_person/first_person_system")
require("scripts/entity_system/systems/interaction/interaction_system")
require("scripts/entity_system/systems/interaction/interactable_system")
require("scripts/entity_system/systems/inventory/inventory_system")
require("scripts/entity_system/systems/leaderboard/leaderboard_system")
require("scripts/entity_system/systems/limited_item_track/limited_item_track_system")
require("scripts/entity_system/systems/locomotion/locomotion_system")
require("scripts/entity_system/systems/network/game_object_system")
require("scripts/entity_system/systems/objective_socket/objective_socket_system")
require("scripts/entity_system/systems/outlines/outline_system")
require("scripts/entity_system/systems/pickups/pickup_system")
require("scripts/entity_system/systems/projectile_impact/projectile_impact_system")
require("scripts/entity_system/systems/projectile_locomotion/projectile_locomotion_system")
require("scripts/entity_system/systems/round_started/round_started_system")
require("scripts/entity_system/systems/sound/sound_sector_system")
require("scripts/entity_system/systems/sound_environment/sound_environment_system")
require("scripts/entity_system/systems/spawner/spawner_system")
require("scripts/entity_system/systems/statistics/statistics_system")
require("scripts/entity_system/systems/volumes/volume_system")
require("scripts/entity_system/systems/projectile/projectile_system")
require("scripts/entity_system/systems/projectile/projectile_linker_system")
require("scripts/entity_system/systems/proximity/proximity_system")
require("scripts/entity_system/systems/status/status_system")
require("scripts/entity_system/systems/transportation/transportation_system")
require("scripts/entity_system/systems/weapon/weapon_system")
require("scripts/entity_system/systems/hud/hud_system")
require("scripts/entity_system/systems/tutorial/tutorial_system")
require("scripts/entity_system/systems/play_go_tutorial/play_go_tutorial_system")
require("scripts/entity_system/systems/mission/mission_system")
require("scripts/entity_system/systems/ping/ping_system")
require("scripts/entity_system/systems/fade/fade_system")
require("scripts/unit_extensions/human/ai_player_unit/ai_anim_utils")
require("scripts/unit_extensions/human/ai_player_unit/ai_husk_base_extension")
require("scripts/unit_extensions/human/ai_player_unit/ai_simple_extension")
require("scripts/unit_extensions/human/ai_player_unit/ai_utils")
require("scripts/unit_extensions/human/ai_player_unit/ai_heroic_enemy_extension")
require("scripts/unit_extensions/generic/perlin_light_extension")
require("scripts/unit_extensions/generic/bot_nav_transition_extension")
require("scripts/unit_extensions/generic/generic_aggroable_extension")
require("scripts/unit_extensions/generic/generic_ammo_user_extension")
require("scripts/unit_extensions/generic/generic_character_state_machine_extension")
require("scripts/unit_extensions/generic/generic_camera_state_machine_extension")
require("scripts/unit_extensions/generic/generic_unit_damage_extension")
require("scripts/unit_extensions/generic/generic_death_extension")
require("scripts/unit_extensions/generic/generic_trail_extension")
require("scripts/unit_extensions/generic/generic_unit_aim_extension")
require("scripts/unit_extensions/generic/generic_hit_reaction_extension")
require("scripts/unit_extensions/generic/no_target_zone_extension")
require("scripts/unit_extensions/generic/ladder_extension")
require("scripts/unit_extensions/default_player_unit/player_eyetracking_extension")
require("scripts/unit_extensions/default_player_unit/player_input_extension")
require("scripts/unit_extensions/default_player_unit/player_whereabouts_extension")
require("scripts/unit_extensions/human/player_bot_unit/player_bot_base")
require("scripts/unit_extensions/human/player_bot_unit/player_bot_input")
require("scripts/unit_extensions/human/player_bot_unit/player_bot_navigation")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_helper")
require("scripts/unit_extensions/default_player_unit/states/player_character_state")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_dead")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_interacting")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_jumping")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_ledge_hanging")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_leave_ledge_hanging_falling")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_leave_ledge_hanging_pull_up")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_climbing_ladder")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_leaving_ladder_top")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_enter_ladder_top")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_falling")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_knocked_down")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_pounced_down")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_standing")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_inspecting")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_walking")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_dodging")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_waiting_for_assisted_respawn")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_catapulted")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_stunned")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_using_transport")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_grabbed_by_pack_master")
require("scripts/unit_extensions/default_player_unit/states/player_character_state_overcharge_exploding")
require("scripts/unit_extensions/weapons/area_damage/area_damage_extension")
require("scripts/unit_extensions/weapons/area_damage/area_damage_templates")
require("scripts/unit_extensions/weapons/projectiles/projectile_physics_husk_locomotion_extension")
require("scripts/unit_extensions/weapons/projectiles/projectile_physics_unit_locomotion_extension")
require("scripts/unit_extensions/weapons/projectiles/projectile_script_unit_locomotion_extension")
require("scripts/unit_extensions/weapons/projectiles/projectile_flame_wave_locomotion_extension")
require("scripts/unit_extensions/weapons/ammo/active_reload_ammo_user_extension")
require("scripts/unit_extensions/weapons/spread/weapon_spread_extension")
require("scripts/unit_extensions/default_player_unit/charge/player_unit_charge_extension")
require("scripts/unit_extensions/default_player_unit/charge/player_unit_overcharge_extension")
require("scripts/unit_extensions/default_player_unit/target_override_extension")
require("scripts/unit_extensions/death/explosive_barrel_death_extension")
require("scripts/unit_extensions/cutscene_camera/cutscene_camera")
require("scripts/unit_extensions/damage/loot_rat_damage_extension")
require("scripts/unit_extensions/smart_targeting/player_unit_smart_targeting_extension")

local projectile_locomotion_extensions = {
	"ProjectilePhysicsHuskLocomotionExtension",
	"ProjectilePhysicsUnitLocomotionExtension",
	"ProjectileScriptUnitLocomotionExtension",
	"ProjectileTrueFlightLocomotionExtension",
	"ProjectileFlameWaveLocomotionExtension"
}
EntitySystem = class(EntitySystem)

EntitySystem.init = function (self, entity_system_creation_context)
	assert(entity_system_creation_context.entity_manager)
	assert(entity_system_creation_context.world)
	assert(entity_system_creation_context.unit_spawner)

	self.entity_manager = entity_system_creation_context.entity_manager
	self.world = entity_system_creation_context.world
	self.unit_spawner = entity_system_creation_context.unit_spawner
	self.startup_data = entity_system_creation_context.startup_data
	self.is_server = entity_system_creation_context.is_server
	self.entity_system_bag = entity_system_creation_context.entity_system_bag
	self.network_clock = entity_system_creation_context.network_clock
	self.network_transmit = entity_system_creation_context.network_transmit
	self.statistics_db = entity_system_creation_context.statistics_db
	self.dice_keeper = entity_system_creation_context.dice_keeper
	self.system_update_context = {}

	self:_init_systems(entity_system_creation_context)
end

EntitySystem._init_systems = function (self, entity_system_creation_context)
	local no_pre_update = false
	local has_pre_update = true
	local has_post_update = true
	entity_system_creation_context.entity_system = self

	self:_add_system("ai_bot_group_system", AIBotGroupSystem, entity_system_creation_context)
	self:_add_system("target_override_system", ExtensionSystemBase, entity_system_creation_context, {
		"TargetOverrideExtension"
	})
	self:_add_system("ai_heroic_enemy_system", ExtensionSystemBase, entity_system_creation_context, {
		"AiHeroicEnemyExtension"
	})
	self:_add_system("ai_system", AISystem, entity_system_creation_context)
	self:_add_system("ai_melee_line_of_sight_system", AIMeleeLineOfSightSystem, entity_system_creation_context)
	self:_add_system("ai_interest_point_system", AIInterestPointSystem, entity_system_creation_context)
	self:_add_system("input_system", ExtensionSystemBase, entity_system_creation_context, {
		"PlayerInputExtension",
		"PlayerBotInput"
	}, has_pre_update)
	self:_add_system("darkness_system", DarknessSystem, entity_system_creation_context, {
		"LightSourceExtension"
	})
	self:_add_system("character_state_machine_system", ExtensionSystemBase, entity_system_creation_context, {
		"GenericCharacterStateMachineExtension"
	})
	self:_add_system("ladder_system", ExtensionSystemBase, entity_system_creation_context, {
		"LadderExtension"
	})
	self:_add_system("inventory_system", InventorySystem, entity_system_creation_context)
	self:_add_system("pickup_system", PickupSystem, entity_system_creation_context)
	self:_add_system("outline_system", OutlineSystem, entity_system_creation_context)
	self:_add_system("attachment_system", AttachmentSystem, entity_system_creation_context)
	self:_add_system("ai_inventory_system", AIInventorySystem, entity_system_creation_context)
	self:_add_system("ai_inventory_item_system", AIInventoryItemSystem, entity_system_creation_context)
	self:_add_system("ai_commander_system", AICommanderSystem, entity_system_creation_context)
	self:_add_system("limited_item_track_system", LimitedItemTrackSystem, entity_system_creation_context)
	self:_add_system("aggro_system", AggroSystem, entity_system_creation_context)
	self:_add_system("objective_socket_system", ObjectiveSocketSystem, entity_system_creation_context)
	self:_add_system("ping_system", PingSystem, entity_system_creation_context)
	self:_add_system("smart_targeting_system", ExtensionSystemBase, entity_system_creation_context, {
		"PlayerUnitSmartTargetingExtension"
	})
	self:_add_system("weapon_system", WeaponSystem, entity_system_creation_context)
	self:_add_system("projectile_locomotion_system", ProjectileLocomotionSystem, entity_system_creation_context, projectile_locomotion_extensions)
	self:_add_system("projectile_impact_system", ProjectileImpactSystem, entity_system_creation_context)
	self:_add_system("projectile_system", ProjectileSystem, entity_system_creation_context)
	self:_add_system("projectile_linker_system", ProjectileLinkerSystem, entity_system_creation_context)
	self:_add_system("area_damage_system", AreaDamageSystem, entity_system_creation_context)
	self:_add_system("ammo_system", ExtensionSystemBase, entity_system_creation_context, {
		"ActiveReloadAmmoUserExtension",
		"GenericAmmoUserExtension"
	})
	self:_add_system("spread_system", ExtensionSystemBase, entity_system_creation_context, {
		"WeaponSpreadExtension"
	})
	self:_add_system("damage_system", DamageSystem, entity_system_creation_context, nil, has_pre_update)
	self:_add_system("buff_system", BuffSystem, entity_system_creation_context)
	self:_add_system("health_system", HealthSystem, entity_system_creation_context)
	self:_add_system("status_system", StatusSystem, entity_system_creation_context)
	self:_add_system("hit_reaction_system", ExtensionSystemBase, entity_system_creation_context, {
		"GenericHitReactionExtension"
	})
	self:_add_system("charge_system", ExtensionSystemBase, entity_system_creation_context, {
		"PlayerUnitChargeExtension"
	})
	self:_add_system("overcharge_system", ExtensionSystemBase, entity_system_creation_context, {
		"OverChargeExtension"
	})
	self:_add_system("trail_system", ExtensionSystemBase, entity_system_creation_context, {
		"GenericTrailExtension"
	})
	self:_add_system("ai_slot_system", AISlotSystem, entity_system_creation_context)
	self:_add_system("death_system", DeathSystem, entity_system_creation_context)
	self:_add_system("interactor_system", InteractionSystem, entity_system_creation_context)
	self:_add_system("interactable_system", InteractableSystem, entity_system_creation_context)
	self:_add_system("ai_group_system", AIGroupSystem, entity_system_creation_context)
	self:_add_system("ai_navigation_system", AINavigationSystem, entity_system_creation_context, {
		"AINavigationExtension",
		"PlayerBotNavigation"
	}, no_pre_update, has_post_update)
	self:_add_system("whereabouts_system", ExtensionSystemBase, entity_system_creation_context, {
		"PlayerWhereaboutsExtension"
	}, no_pre_update, has_post_update)
	self:_add_system("door_system", DoorSystem, entity_system_creation_context)
	self:_add_system("aim_system", ExtensionSystemBase, entity_system_creation_context, {
		"GenericUnitAimExtension"
	})
	self:_add_system("transportation_system", TransportationSystem, entity_system_creation_context)
	self:_add_system("locomotion_system", LocomotionSystem, entity_system_creation_context, nil, no_pre_update, has_post_update)
	self:_add_system("animation_system", AnimationSystem, entity_system_creation_context)
	self:_add_system("eyetracking_system", ExtensionSystemBase, entity_system_creation_context, {
		"PlayerEyeTrackingExtension"
	})
	self:_add_system("first_person_system", FirstPersonSystem, entity_system_creation_context)
	self:_add_system("fade_system", FadeSystem, entity_system_creation_context)
	self:_add_system("camera_state_machine_system", ExtensionSystemBase, entity_system_creation_context, {
		"GenericCameraStateMachineExtension"
	})
	self:_add_system("camera_system", CameraSystem, entity_system_creation_context, nil, no_pre_update, has_post_update)
	self:_add_system("sound_sector_system", SoundSectorSystem, entity_system_creation_context)
	self:_add_system("volume_system", VolumeSystem, entity_system_creation_context)
	self:_add_system("cutscene_system", CutsceneSystem, entity_system_creation_context)
	self:_add_system("play_go_tutorial_system", PlayGoTutorialSystem, entity_system_creation_context)
	self:_add_system("tutorial_system", TutorialSystem, entity_system_creation_context)
	self:_add_system("mission_system", MissionSystem, entity_system_creation_context)
	self:_add_system("hud_system", HUDSystem, entity_system_creation_context)
	self:_add_system("round_started_system", RoundStartedSystem, entity_system_creation_context)
	self:_add_system("spawner_system", SpawnerSystem, entity_system_creation_context)
	self:_add_system("props_system", ExtensionSystemBase, entity_system_creation_context, {
		"PerlinLightExtension",
		"NoTargetZoneExtension",
		"BotNavTransitionExtension"
	})
	self:_add_system("nav_graph_system", NavGraphSystem, entity_system_creation_context)
	self:_add_system("audio_system", AudioSystem, entity_system_creation_context)
	self:_add_system("sound_environment_system", SoundEnvironmentSystem, entity_system_creation_context)
	self:_add_system("game_object_system", GameObjectSystem, entity_system_creation_context)
	self:_add_system("statistics_system", StatisticsSystem, entity_system_creation_context)
	self:_add_system("leaderboard_system", LeaderboardSystem, entity_system_creation_context)
	self:_add_system("dialogue_context_system", DialogueContextSystem, entity_system_creation_context)
	self:_add_system("health_trigger_system", HealthTriggerSystem, entity_system_creation_context)
	self:_add_system("surrounding_aware_system", SurroundingAwareSystem, entity_system_creation_context)
	self:_add_system("dialogue_system", DialogueSystem, entity_system_creation_context, nil, no_pre_update, has_post_update)
	self:_add_system("proximity_system", ProximitySystem, entity_system_creation_context, nil, no_pre_update, has_post_update)
end

EntitySystem.register_system = function (self, system_object, system_name, ...)
	return
end

EntitySystem._add_system = function (self, name, class, context, extension_list, has_pre_update, has_post_update)
	local system = class:new(context, name, extension_list)
	local block_pre_update = not has_pre_update
	local block_post_update = not has_post_update

	self.entity_system_bag:add_system(system, block_pre_update, block_post_update)
end

EntitySystem.pre_update = function (self, dt)
	Profiler.start("EntitySystem:pre_update")
	self:system_update("pre_update", dt)
	Profiler.stop("EntitySystem:pre_update")
end

EntitySystem.update = function (self, dt)
	Profiler.start("EntitySystem:update")
	self:system_update("update", dt)
	Profiler.stop("EntitySystem:update")
end

EntitySystem.post_update = function (self, dt)
	Profiler.start("EntitySystem:post_update")
	self:system_update("post_update", dt)
	Profiler.stop("EntitySystem:post_update")
end

EntitySystem.physics_async_update = function (self)
	Profiler.start("EntitySystem:physics_async_update")
	self:system_update("physics_async_update", self.system_update_context.dt)
	Profiler.stop("EntitySystem:physics_async_update")
end

EntitySystem.system_update = function (self, update_func, dt)
	local entity_system_update_context = self.system_update_context
	entity_system_update_context.world = self.world
	entity_system_update_context.dt = dt
	entity_system_update_context.entity_manager = self.entity_manager
	entity_system_update_context.t = Managers.time:time("game")
	entity_system_update_context.network_transmit = self.network_transmit
	entity_system_update_context.statistics_db = self.statistics_db
	entity_system_update_context.dice_keeper = self.dice_keeper

	if World.get_data(entity_system_update_context.world, "paused") then
		return
	end

	self.entity_system_bag:update(entity_system_update_context, update_func)
end

EntitySystem.commit_and_remove_pending_units = function (self)
	local unit_spawner = self.unit_spawner
	unit_spawner.locked = false

	unit_spawner:commit_and_remove_pending_units()

	unit_spawner.locked = true
end

EntitySystem.hot_join_sync = function (self, sender)
	self.entity_system_bag:hot_join_sync(sender)
end

EntitySystem.destroy = function (self)
	Profiler.start("EntitySystem:destroy")

	local units = World.units(self.world)

	self.entity_manager:unregister_units(units, #units)
	GarbageLeakDetector.register_object(self.system_update_context, "EntitySystemUpdateContext")

	self.system_update_context = nil

	GarbageLeakDetector.register_object(self, "EntitySystem")
	Profiler.stop("EntitySystem:destroy")
end

return
