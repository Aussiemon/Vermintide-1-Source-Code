local ai_locomotion_name = (_G.GameSettingsDevelopment and GameSettingsDevelopment.use_engine_optimized_ai_locomotion and "AILocomotionExtensionC") or "AILocomotionExtension"
local unit_templates = {
	player_unit_3rd = {
		go_type = "player_unit",
		self_owned_extensions = {
			"PlayerInputExtension",
			"GenericCharacterStateMachineExtension",
			"SimpleInventoryExtension",
			"GenericUnitInteractorExtension",
			"GenericUnitInteractableExtension",
			"PlayerDamageExtension",
			"BuffExtension",
			"PlayerUnitHealthExtension",
			"GenericStatusExtension",
			"GenericHitReactionExtension",
			"GenericDeathExtension",
			"PlayerUnitLocomotionExtension",
			"PlayerUnitFirstPerson",
			"PlayerEyeTrackingExtension",
			"GenericUnitAimExtension",
			"PlayerHud",
			"PlayerUnitAttachmentExtension",
			"DialogueActorExtension",
			"SurroundingObserverExtension",
			"PlayerWhereaboutsExtension",
			"PlayerProximityExtension",
			"HealthTriggerExtension",
			"GenericDialogueContextExtension",
			"PlayerOutlineExtension",
			"PlayerTutorialExtension",
			"StatisticsExtension",
			"ContextAwarePingExtension",
			"PlayerUnitFadeExtension",
			"PlayerUnitDarknessExtension",
			"PlayerUnitSmartTargetingExtension"
		},
		self_owned_extensions_server = {
			"PlayerInputExtension",
			"GenericCharacterStateMachineExtension",
			"SimpleInventoryExtension",
			"GenericUnitInteractorExtension",
			"GenericUnitInteractableExtension",
			"PlayerDamageExtension",
			"BuffExtension",
			"PlayerUnitHealthExtension",
			"GenericStatusExtension",
			"GenericHitReactionExtension",
			"GenericDeathExtension",
			"PlayerUnitLocomotionExtension",
			"PlayerUnitFirstPerson",
			"PlayerEyeTrackingExtension",
			"GenericUnitAimExtension",
			"PlayerHud",
			"PlayerUnitAttachmentExtension",
			"DialogueActorExtension",
			"SurroundingObserverExtension",
			"PlayerWhereaboutsExtension",
			"PlayerProximityExtension",
			"HealthTriggerExtension",
			"GenericDialogueContextExtension",
			"TargetOverrideExtension",
			"AIPlayerSlotExtension",
			"GenericAggroableExtension",
			"PlayerOutlineExtension",
			"PlayerVolumeExtension",
			"RoundStartedExtension",
			"PlayerTutorialExtension",
			"StatisticsExtension",
			"ContextAwarePingExtension",
			"PlayerUnitFadeExtension",
			"PlayerUnitDarknessExtension",
			"PlayerUnitSmartTargetingExtension"
		},
		husk_extensions = {
			"SimpleHuskInventoryExtension",
			"GenericHuskInteractorExtension",
			"GenericUnitInteractableExtension",
			"PlayerDamageExtension",
			"BuffExtension",
			"PlayerUnitHealthExtension",
			"GenericStatusExtension",
			"GenericHitReactionExtension",
			"GenericDeathExtension",
			"PlayerHuskLocomotionExtension",
			"GenericUnitAimExtension",
			"DialogueActorExtension",
			"SurroundingObserverHuskExtension",
			"PlayerHuskOutlineExtension",
			"PlayerProximityExtension",
			"HealthTriggerExtension",
			"GenericDialogueContextExtension",
			"PlayerHuskAttachmentExtension",
			"StatisticsExtension",
			"PingTargetExtension",
			"PlayerUnitFadeExtension",
			"PlayerUnitDarknessExtension"
		},
		husk_extensions_server = {
			"SimpleHuskInventoryExtension",
			"GenericHuskInteractorExtension",
			"GenericUnitInteractableExtension",
			"PlayerDamageExtension",
			"BuffExtension",
			"PlayerUnitHealthExtension",
			"GenericStatusExtension",
			"GenericHitReactionExtension",
			"GenericDeathExtension",
			"PlayerHuskLocomotionExtension",
			"GenericUnitAimExtension",
			"PlayerHuskAttachmentExtension",
			"DialogueActorExtension",
			"SurroundingObserverHuskExtension",
			"PlayerWhereaboutsExtension",
			"PlayerHuskOutlineExtension",
			"PlayerProximityExtension",
			"HealthTriggerExtension",
			"GenericDialogueContextExtension",
			"TargetOverrideExtension",
			"AIPlayerSlotExtension",
			"GenericAggroableExtension",
			"PlayerVolumeExtension",
			"RoundStartedExtension",
			"StatisticsExtension",
			"PingTargetExtension",
			"PlayerUnitFadeExtension",
			"PlayerUnitDarknessExtension"
		}
	},
	player_bot_unit = {
		go_type = "player_bot_unit",
		self_owned_extensions = {
			"PlayerBotBase",
			"AIBotGroupExtension",
			"PlayerBotInput",
			"PlayerBotNavigation",
			"GenericCharacterStateMachineExtension",
			"SimpleInventoryExtension",
			"GenericUnitInteractorExtension",
			"GenericUnitInteractableExtension",
			"PlayerDamageExtension",
			"BuffExtension",
			"PlayerUnitHealthExtension",
			"GenericStatusExtension",
			"GenericHitReactionExtension",
			"GenericDeathExtension",
			"PlayerUnitLocomotionExtension",
			"PlayerBotUnitFirstPerson",
			"GenericUnitAimExtension",
			"PlayerUnitAttachmentExtension",
			"DialogueActorExtension",
			"SurroundingObserverHuskExtension",
			"PlayerWhereaboutsExtension",
			"PlayerProximityExtension",
			"HealthTriggerExtension",
			"GenericDialogueContextExtension",
			"TargetOverrideExtension",
			"AIPlayerSlotExtension",
			"GenericAggroableExtension",
			"PlayerHuskOutlineExtension",
			"BotVolumeExtension",
			"StatisticsExtension",
			"PingTargetExtension",
			"PlayerUnitFadeExtension",
			"PlayerUnitDarknessExtension"
		},
		husk_extensions = {
			"SimpleHuskInventoryExtension",
			"GenericHuskInteractorExtension",
			"GenericUnitInteractableExtension",
			"PlayerDamageExtension",
			"BuffExtension",
			"PlayerUnitHealthExtension",
			"GenericStatusExtension",
			"GenericHitReactionExtension",
			"GenericDeathExtension",
			"PlayerHuskLocomotionExtension",
			"GenericUnitAimExtension",
			"DialogueActorExtension",
			"SurroundingObserverHuskExtension",
			"PlayerHuskOutlineExtension",
			"PlayerProximityExtension",
			"HealthTriggerExtension",
			"GenericDialogueContextExtension",
			"PlayerHuskAttachmentExtension",
			"StatisticsExtension",
			"PingTargetExtension",
			"PlayerUnitFadeExtension",
			"PlayerUnitDarknessExtension"
		}
	},
	ai_unit_base = {
		go_type = "ai_unit",
		self_owned_extensions = {
			"AISimpleExtension",
			ai_locomotion_name,
			"AINavigationExtension",
			"GenericUnitDamageExtension",
			"GenericHitReactionExtension",
			"GenericHealthExtension",
			"GenericDeathExtension",
			"AIProximityExtension",
			"BuffExtension",
			"SoundSectorExtension",
			"ProjectileLinkerExtension",
			"EnemyOutlineExtension",
			"AIGroupMember",
			"DialogueActorExtension",
			"AIVolumeExtension",
			"AIUnitFadeExtension"
		},
		husk_extensions = {
			"AiHuskBaseExtension",
			"AiHuskLocomotionExtension",
			"GenericUnitDamageExtension",
			"GenericHitReactionExtension",
			"GenericHealthExtension",
			"GenericDeathExtension",
			"AIProximityExtension",
			"BuffExtension",
			"SoundSectorExtension",
			"ProjectileLinkerExtension",
			"EnemyOutlineExtension",
			"DialogueActorExtension",
			"AIUnitFadeExtension"
		},
		remove_when_killed = {
			self_owned_extensions = {
				"AISimpleExtension",
				"AINavigationExtension",
				"AIProximityExtension",
				"BuffExtension",
				"SoundSectorExtension",
				"AIGroupMember",
				"DialogueActorExtension",
				"AIVolumeExtension"
			},
			husk_extensions = {
				"AiHuskBaseExtension",
				"AiHuskLocomotionExtension",
				"AIProximityExtension",
				"BuffExtension",
				"SoundSectorExtension",
				"DialogueActorExtension"
			}
		}
	},
	ai_unit_critter = {
		go_type = "ai_unit",
		self_owned_extensions = {
			"AISimpleExtension",
			ai_locomotion_name,
			"AINavigationExtension",
			"GenericUnitDamageExtension",
			"GenericHitReactionExtension",
			"GenericHealthExtension",
			"GenericDeathExtension",
			"AIProximityExtension",
			"BuffExtension",
			"ProjectileLinkerExtension",
			"DialogueActorExtension",
			"AIVolumeExtension"
		},
		husk_extensions = {
			"AiHuskBaseExtension",
			"AiHuskLocomotionExtension",
			"GenericUnitDamageExtension",
			"GenericHitReactionExtension",
			"GenericHealthExtension",
			"GenericDeathExtension",
			"AIProximityExtension",
			"BuffExtension",
			"ProjectileLinkerExtension",
			"DialogueActorExtension"
		},
		remove_when_killed = {
			self_owned_extensions = {
				"AISimpleExtension",
				"AINavigationExtension",
				"AIProximityExtension",
				"BuffExtension",
				"DialogueActorExtension",
				"AIVolumeExtension"
			},
			husk_extensions = {
				"AiHuskBaseExtension",
				"AiHuskLocomotionExtension",
				"AIProximityExtension",
				"BuffExtension",
				"DialogueActorExtension"
			}
		}
	},
	ai_unit = {
		base_template = "ai_unit_base",
		go_type = "ai_unit",
		self_owned_extensions = {},
		husk_extensions = {}
	},
	ai_unit_storm_vermin = {
		base_template = "ai_unit_base",
		go_type = "ai_unit_with_inventory",
		self_owned_extensions = {
			"AIMeleeLineOfSightExtension",
			"AIInventoryExtension",
			"AIEnemySlotExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"AIInventoryExtension",
			"PingTargetExtension"
		},
		remove_when_killed = {
			self_owned_extensions = {
				"AIMeleeLineOfSightExtension",
				"AIEnemySlotExtension"
			},
			husk_extensions = {}
		}
	},
	ai_unit_grey_seer = {
		base_template = "ai_unit_base",
		go_type = "ai_unit_with_inventory",
		self_owned_extensions = {
			"AIMeleeLineOfSightExtension",
			"AIInventoryExtension",
			"AIEnemySlotExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"AIInventoryExtension",
			"PingTargetExtension"
		},
		remove_when_killed = {
			self_owned_extensions = {
				"AIMeleeLineOfSightExtension",
				"AIEnemySlotExtension"
			},
			husk_extensions = {}
		}
	},
	ai_unit_clan_rat = {
		base_template = "ai_unit_base",
		go_type = "ai_unit_with_inventory",
		self_owned_extensions = {
			"AIMeleeLineOfSightExtension",
			"AIInventoryExtension",
			"AIEnemySlotExtension"
		},
		husk_extensions = {
			"AIInventoryExtension"
		},
		remove_when_killed = {
			self_owned_extensions = {
				"AIMeleeLineOfSightExtension",
				"AIEnemySlotExtension"
			},
			husk_extensions = {}
		}
	},
	ai_unit_loot_rat = {
		go_type = "ai_unit_with_inventory",
		self_owned_extensions = {
			"AISimpleExtension",
			ai_locomotion_name,
			"AINavigationExtension",
			"LootRatDamageExtension",
			"GenericHitReactionExtension",
			"GenericHealthExtension",
			"GenericDeathExtension",
			"AIProximityExtension",
			"BuffExtension",
			"SoundSectorExtension",
			"ProjectileLinkerExtension",
			"EnemyOutlineExtension",
			"AIGroupMember",
			"DialogueActorExtension",
			"AIVolumeExtension",
			"AIInventoryExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		},
		husk_extensions = {
			"AiHuskBaseExtension",
			"AiHuskLocomotionExtension",
			"GenericUnitDamageExtension",
			"GenericHitReactionExtension",
			"GenericHealthExtension",
			"GenericDeathExtension",
			"AIProximityExtension",
			"SoundSectorExtension",
			"ProjectileLinkerExtension",
			"EnemyOutlineExtension",
			"DialogueActorExtension",
			"AIInventoryExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		}
	},
	ai_unit_rat_ogre = {
		go_type = "ai_unit_with_inventory",
		self_owned_extensions = {
			"AISimpleExtension",
			ai_locomotion_name,
			"AINavigationExtension",
			"GenericUnitDamageExtension",
			"GenericHitReactionExtension",
			"AIInventoryExtension",
			"RatOgreHealthExtension",
			"GenericDeathExtension",
			"AIProximityExtension",
			"BuffExtension",
			"ProjectileLinkerExtension",
			"EnemyOutlineExtension",
			"AIGroupMember",
			"DialogueActorExtension",
			"AIVolumeExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		},
		husk_extensions = {
			"AiHuskBaseExtension",
			"AiHuskLocomotionExtension",
			"GenericUnitDamageExtension",
			"GenericHitReactionExtension",
			"AIInventoryExtension",
			"RatOgreHealthExtension",
			"GenericDeathExtension",
			"AIProximityExtension",
			"BuffExtension",
			"ProjectileLinkerExtension",
			"EnemyOutlineExtension",
			"DialogueActorExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		}
	},
	ai_unit_gutter_runner = {
		base_template = "ai_unit_base",
		go_type = "ai_unit_with_inventory",
		self_owned_extensions = {
			"AIInventoryExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		},
		husk_extensions = {
			"AIInventoryExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		}
	},
	ai_unit_poison_wind_globadier = {
		base_template = "ai_unit_base",
		go_type = "ai_unit",
		self_owned_extensions = {
			"PingTargetExtension",
			"EnemyOutlineExtension"
		},
		husk_extensions = {
			"PingTargetExtension",
			"EnemyOutlineExtension"
		}
	},
	ai_unit_pack_master = {
		base_template = "ai_unit_base",
		go_type = "ai_unit_pack_master",
		self_owned_extensions = {
			"AIInventoryExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		},
		husk_extensions = {
			"AIInventoryExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		}
	},
	ai_unit_ratling_gunner = {
		base_template = "ai_unit_base",
		go_type = "ai_unit_ratling_gunner",
		self_owned_extensions = {
			"AIInventoryExtension",
			"GenericUnitAimExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		},
		husk_extensions = {
			"AIInventoryExtension",
			"GenericUnitAimExtension",
			"PingTargetExtension",
			"EnemyOutlineExtension"
		}
	},
	ai_inventory_item = {
		go_type = "ai_inventory_item",
		self_owned_extensions = {
			"AIInventoryItemExtension"
		}
	},
	aoe_unit = {
		go_type = "aoe_unit",
		self_owned_extensions = {
			"AreaDamageExtension"
		},
		husk_extensions = {
			"AreaDamageExtension"
		}
	},
	aoe_projectile_unit = {
		go_type = "aoe_projectile_unit",
		self_owned_extensions = {
			"ProjectileScriptUnitLocomotionExtension",
			"ProjectileRaycastImpactUnitExtension",
			"GenericImpactProjectileUnitExtension",
			"AreaDamageExtension"
		},
		husk_extensions = {
			"ProjectileScriptUnitLocomotionExtension",
			"GenericImpactProjectileUnitExtension",
			"AreaDamageExtension"
		}
	},
	player_projectile_unit = {
		go_type = "player_projectile_unit",
		self_owned_extensions = {
			"ProjectileScriptUnitLocomotionExtension",
			"PlayerProjectileImpactUnitExtension",
			"PlayerProjectileUnitExtension"
		},
		husk_extensions = {
			"ProjectileScriptUnitLocomotionExtension",
			"PlayerProjectileHuskExtension"
		}
	},
	flame_wave_projectile_unit = {
		go_type = "flame_wave_projectile_unit",
		self_owned_extensions = {
			"ProjectileFlameWaveLocomotionExtension",
			"PlayerProjectileImpactUnitExtension",
			"PlayerProjectileUnitExtension"
		},
		husk_extensions = {
			"ProjectileFlameWaveLocomotionExtension",
			"PlayerProjectileHuskExtension"
		}
	},
	pickup_projectile_unit = {
		go_type = "pickup_projectile_unit",
		self_owned_extensions = {
			"ProjectilePhysicsUnitLocomotionExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"PickupProjectileVolumeExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"ProjectilePhysicsHuskLocomotionExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"PingTargetExtension"
		}
	},
	pickup_torch_unit_init = {
		go_type = "pickup_torch_unit_init",
		self_owned_extensions = {
			"ProjectilePhysicsUnitLocomotionExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"PickupProjectileVolumeExtension",
			"PingTargetExtension",
			"LightSourceExtension"
		},
		husk_extensions = {
			"ProjectilePhysicsHuskLocomotionExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"PingTargetExtension",
			"LightSourceExtension"
		}
	},
	pickup_torch_unit = {
		go_type = "pickup_torch_unit",
		self_owned_extensions = {
			"ObjectivePickupTutorialExtension",
			"ProjectilePhysicsUnitLocomotionExtension",
			"PlayerTeleportingPickupExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"PickupProjectileVolumeExtension",
			"PingTargetExtension",
			"LightSourceExtension"
		},
		husk_extensions = {
			"ObjectivePickupTutorialExtension",
			"ProjectilePhysicsHuskLocomotionExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"PingTargetExtension",
			"LightSourceExtension"
		}
	},
	pickup_projectile_unit_limited = {
		go_type = "pickup_projectile_unit_limited",
		self_owned_extensions = {
			"ObjectivePickupTutorialExtension",
			"ProjectilePhysicsUnitLocomotionExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"PickupProjectileVolumeExtension",
			"LimitedItemExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"ObjectivePickupTutorialExtension",
			"ProjectilePhysicsHuskLocomotionExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"LimitedItemExtension",
			"PingTargetExtension"
		}
	},
	explosive_pickup_projectile_unit = {
		go_type = "explosive_pickup_projectile_unit",
		self_owned_extensions = {
			"ProjectilePhysicsUnitLocomotionExtension",
			"GenericUnitDamageExtension",
			"GenericHealthExtension",
			"ExplosiveBarrelDeathExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"PickupOutlineExtension",
			"LookatTargetExtension",
			"ProjectileLinkerExtension",
			"PickupProjectileVolumeExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"ProjectilePhysicsHuskLocomotionExtension",
			"GenericUnitDamageExtension",
			"GenericHealthExtension",
			"ExplosiveBarrelDeathExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"PickupOutlineExtension",
			"LookatTargetExtension",
			"ProjectileLinkerExtension",
			"PingTargetExtension"
		}
	},
	explosive_pickup_projectile_unit_limited = {
		go_type = "explosive_pickup_projectile_unit_limited",
		self_owned_extensions = {
			"ObjectivePickupTutorialExtension",
			"ProjectilePhysicsUnitLocomotionExtension",
			"GenericUnitDamageExtension",
			"GenericHealthExtension",
			"ExplosiveBarrelDeathExtension",
			"LimitedItemExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"ProjectileLinkerExtension",
			"PickupProjectileVolumeExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"ObjectivePickupTutorialExtension",
			"ProjectilePhysicsHuskLocomotionExtension",
			"GenericUnitDamageExtension",
			"GenericHealthExtension",
			"ExplosiveBarrelDeathExtension",
			"LimitedItemExtension",
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ObjectiveOutlineExtension",
			"LookatTargetExtension",
			"ProjectileLinkerExtension",
			"PingTargetExtension"
		}
	},
	true_flight_projectile_unit = {
		go_type = "true_flight_projectile_unit",
		self_owned_extensions = {
			"ProjectileTrueFlightLocomotionExtension",
			"ProjectileRaycastImpactUnitExtension",
			"PlayerProjectileUnitExtension"
		},
		husk_extensions = {
			"ProjectileTrueFlightLocomotionExtension",
			"PlayerProjectileHuskExtension"
		}
	},
	prop_unit = {
		go_type = "prop_unit",
		self_owned_extensions = {},
		husk_extensions = {}
	},
	camera_unit = {
		self_owned_extensions = {
			"GenericCameraExtension",
			"GenericCameraStateMachineExtension"
		}
	},
	navgraphconnector = {
		self_owned_extensions = {
			"NavGraphConnectorExtension"
		},
		husk_extensions = {}
	},
	pickup_unit = {
		go_type = "pickup_unit",
		self_owned_extensions = {
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"PickupOutlineExtension",
			"LookatTargetExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"PickupOutlineExtension",
			"LookatTargetExtension",
			"PingTargetExtension"
		}
	},
	conditional_pickup_unit = {
		go_type = "pickup_unit",
		self_owned_extensions = {
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ConditionalPickupOutlineExtension",
			"LookatTargetExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"PickupUnitExtension",
			"GenericUnitInteractableExtension",
			"ConditionalPickupOutlineExtension",
			"LookatTargetExtension",
			"PingTargetExtension"
		}
	},
	battle_chatter_unit = {
		self_owned_extensions = {
			"LookatTargetExtension"
		},
		husk_extensions = {
			"LookatTargetExtension"
		}
	},
	weapon_unit_3p = {
		self_owned_extensions = {}
	},
	torch_unit_3p = {
		self_owned_extensions = {
			"LightSourceExtension"
		},
		husk_extensions = {
			"LightSourceExtension"
		}
	},
	weapon_unit = {
		self_owned_extensions = {
			"WeaponUnitExtension"
		}
	},
	weapon_unit_spread = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"WeaponSpreadExtension"
		}
	},
	weapon_unit_ammo = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"GenericAmmoUserExtension"
		}
	},
	weapon_unit_ammo_limited = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"GenericAmmoUserExtension",
			"HeldLimitedItemExtension"
		}
	},
	weapon_unit_ammo_spread = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"GenericAmmoUserExtension",
			"WeaponSpreadExtension"
		}
	},
	weapon_unit_overcharge = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"OverChargeExtension"
		}
	},
	weapon_unit_overcharge_spread = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"OverChargeExtension",
			"WeaponSpreadExtension"
		}
	},
	explosive_weapon_unit_ammo = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"GenericAmmoUserExtension",
			"MimicOwnerDamageExtension",
			"GenericHealthExtension",
			"ExplosiveBarrelDeathExtension"
		}
	},
	explosive_weapon_unit_ammo_limited = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"GenericAmmoUserExtension",
			"HeldLimitedItemExtension",
			"MimicOwnerDamageExtension",
			"GenericHealthExtension",
			"ExplosiveBarrelDeathExtension"
		}
	},
	weapon_unit_aim = {
		self_owned_extensions = {
			"WeaponUnitExtension",
			"GenericUnitAimExtension"
		},
		husk_extensions = {
			"GenericUnitAimExtension"
		}
	},
	ai_weapon_unit = {
		go_type = "ai_inventory_item",
		self_owned_extensions = {
			"AIInventoryItemExtension",
			"AiWeaponUnitExtension"
		}
	},
	limited_item_track_spawner = {
		self_owned_extensions = {},
		self_owned_extensions_server = {
			"LimitedItemTrackSpawner"
		},
		husk_extensions = {},
		husk_extension_server = {}
	},
	interest_point = {
		go_type = "interest_point_unit",
		self_owned_extensions = {
			"AIInterestPointHuskExtension"
		},
		self_owned_extensions_server = {
			"AIInterestPointExtension"
		},
		husk_extensions = {
			"AIInterestPointHuskExtension"
		},
		husk_extension_server = {}
	},
	interest_point_level = {
		base_template = "interest_point",
		go_type = "interest_point_level_unit",
		self_owned_extensions_server = {},
		self_owned_extensions = {},
		husk_extensions = {}
	},
	base_level_unit = {
		go_type = "base_level_unit"
	}
}

for _, dlc in pairs(DLCSettings) do
	local template_file_name = dlc.unit_extension_templates

	if template_file_name then
		local templates = dofile(template_file_name)

		for k, v in pairs(templates) do
			fassert(not unit_templates[k], "Unit template %s from dlc %s already exists.", k, dlc.name)

			unit_templates[k] = v
		end
	end
end

local extension_table_names = {
	"self_owned_extensions",
	"self_owned_extensions_server",
	"husk_extensions",
	"husk_extensions_server"
}
local extension_table_names_n = #extension_table_names

for unit_template_name, template_data in pairs(unit_templates) do
	template_data.NAME = unit_template_name

	for i = 1, extension_table_names_n, 1 do
		local extension_table_name = extension_table_names[i]
		local extension_list = template_data[extension_table_name] or {}
		local extension_list_n = #extension_list

		if template_data.base_template ~= nil then
			local inherited_template_name = template_data.base_template
			local inherited_template_data = unit_templates[inherited_template_name]

			assert(inherited_template_data.base_template == nil, "%s tried to inherit from template that had a base_template", unit_template_name)

			local inherited_extension_list = inherited_template_data[extension_table_name]

			if inherited_extension_list then
				inherited_extension_list_n = #inherited_extension_list

				for j = 1, inherited_extension_list_n, 1 do
					extension_list_n = extension_list_n + 1
					extension_list[extension_list_n] = inherited_extension_list[j]
				end
			end

			local inherited_remove_when_killed = inherited_template_data.remove_when_killed and inherited_template_data.remove_when_killed[extension_table_name]

			if inherited_remove_when_killed then
				if template_data.remove_when_killed == nil then
					template_data.remove_when_killed = {}
				end

				if template_data.remove_when_killed[extension_table_name] == nil then
					template_data.remove_when_killed[extension_table_name] = {}
				end

				for j = 1, #inherited_remove_when_killed, 1 do
					local remove_when_killed = template_data.remove_when_killed[extension_table_name]
					remove_when_killed[#remove_when_killed + 1] = inherited_remove_when_killed[j]
				end
			end
		end

		template_data["num_" .. extension_table_name] = extension_list_n
		local remove_when_killed = template_data.remove_when_killed

		if remove_when_killed then
			for i = 1, extension_table_names_n, 1 do
				local extension_table_name = extension_table_names[i]
				local extension_list = remove_when_killed[extension_table_name]

				if extension_list then
					remove_when_killed["num_" .. extension_table_name] = #extension_list
				end
			end
		end
	end
end

unit_templates.get_extensions = function (unit, unit_template_name, is_husk, is_server)
	local extensions, num_extensions = nil
	local template = unit_templates[unit_template_name]

	if is_husk then
		if is_server and template.husk_extensions_server then
			num_extensions = template.num_husk_extensions_server
			extensions = template.husk_extensions_server
		else
			num_extensions = template.num_husk_extensions
			extensions = template.husk_extensions
		end
	elseif is_server and template.self_owned_extensions_server then
		num_extensions = template.num_self_owned_extensions_server
		extensions = template.self_owned_extensions_server
	else
		num_extensions = template.num_self_owned_extensions
		extensions = template.self_owned_extensions
	end

	return extensions, num_extensions
end
unit_templates.extensions_to_remove_on_death = function (unit_template_name, is_husk, is_server)
	local extensions, num_extensions = nil
	local remove_when_killed = unit_templates[unit_template_name].remove_when_killed

	if remove_when_killed == nil then
		return nil
	end

	if is_husk then
		if is_server and remove_when_killed.husk_extensions_server then
			num_extensions = remove_when_killed.num_husk_extensions_server
			extensions = remove_when_killed.husk_extensions_server
		else
			num_extensions = remove_when_killed.num_husk_extensions
			extensions = remove_when_killed.husk_extensions
		end
	elseif is_server and remove_when_killed.self_owned_extensions_server then
		num_extensions = remove_when_killed.num_self_owned_extensions_server
		extensions = remove_when_killed.self_owned_extensions_server
	else
		num_extensions = remove_when_killed.num_self_owned_extensions
		extensions = remove_when_killed.self_owned_extensions
	end

	if type(extensions) ~= "table" or type(num_extensions) ~= "number" then
		slot6 = 1
	end

	return extensions, num_extensions
end

return unit_templates
