local USE_PRECOMPILED_ROOT_TABLES = true
BreedBehaviors = {
	ogre = {
		"BTSelector",
		{
			"BTSpawningAction",
			condition = "spawn",
			name = "spawn"
		},
		{
			"BTSelector",
			{
				"BTTeleportAction",
				condition = "at_teleport_smartobject",
				name = "teleport"
			},
			{
				"BTClimbAction",
				name = "climb",
				condition = "at_climb_smartobject",
				action_data = BreedActions.skaven_rat_ogre.climb
			},
			{
				"BTJumpAcrossAction",
				condition = "at_jump_smartobject",
				name = "jump_across"
			},
			{
				"BTSmashDoorAction",
				name = "smash_door",
				condition = "at_door_smartobject",
				action_data = BreedActions.skaven_rat_ogre.smash_door
			},
			condition = "ratogre_at_smartobject",
			name = "smartobject"
		},
		{
			"BTStaggerAction",
			name = "stagger",
			condition = "stagger",
			action_data = BreedActions.skaven_rat_ogre.stagger
		},
		{
			"BTSelector",
			{
				"BTMeleeShoveAction",
				name = "fling_skaven",
				condition = "fling_skaven",
				action_data = BreedActions.skaven_rat_ogre.fling_skaven
			},
			{
				"BTTargetRageAction",
				name = "target_rage",
				condition = "target_changed",
				action_data = BreedActions.skaven_rat_ogre.target_rage
			},
			{
				"BTUtilityNode",
				{
					"BTFollowAction",
					name = "follow",
					action_data = BreedActions.skaven_rat_ogre.follow
				},
				{
					"BTMeleeSlamAction",
					name = "melee_slam",
					action_data = BreedActions.skaven_rat_ogre.melee_slam
				},
				{
					"BTMeleeSlamAction",
					name = "anti_ladder_melee_slam",
					action_data = BreedActions.skaven_rat_ogre.anti_ladder_melee_slam
				},
				{
					"BTMeleeShoveAction",
					name = "melee_shove",
					action_data = BreedActions.skaven_rat_ogre.melee_shove
				},
				{
					"BTSequence",
					{
						"BTPrepareJumpSlamAction",
						name = "prepare_jump_slam"
					},
					{
						"BTJumpSlamAction",
						name = "attack_jump"
					},
					{
						"BTJumpSlamImpactAction",
						name = "jump_slam_impact",
						action_data = BreedActions.skaven_rat_ogre.jump_slam_impact
					},
					name = "jump_slam",
					action_data = BreedActions.skaven_rat_ogre.jump_slam
				},
				condition = "ratogre_target_reachable",
				name = "in_combat"
			},
			{
				"BTTargetUnreachableAction",
				name = "target_unreachable",
				action_data = BreedActions.skaven_rat_ogre.target_unreachable
			},
			condition = "can_see_player",
			name = "has_target"
		},
		{
			"BTIdleAction",
			name = "idle"
		},
		name = "rat_ogre"
	},
	pack_rat = {
		"BTSelector",
		{
			"BTSpawningAction",
			condition = "spawn",
			name = "spawn"
		},
		{
			"BTFallAction",
			condition = "is_falling",
			name = "falling"
		},
		{
			"BTStaggerAction",
			name = "stagger",
			condition = "stagger",
			action_data = BreedActions.skaven_clan_rat.stagger
		},
		{
			"BTBlockedAction",
			name = "blocked",
			condition = "blocked",
			action_data = BreedActions.skaven_clan_rat.blocked
		},
		{
			"BTSelector",
			{
				"BTTeleportAction",
				condition = "at_teleport_smartobject",
				name = "teleport"
			},
			{
				"BTClimbAction",
				condition = "at_climb_smartobject",
				name = "climb"
			},
			{
				"BTJumpAcrossAction",
				condition = "at_jump_smartobject",
				name = "jump_across"
			},
			{
				"BTSmashDoorAction",
				name = "smash_door",
				condition = "at_door_smartobject",
				action_data = BreedActions.skaven_clan_rat.smash_door
			},
			condition = "at_smartobject",
			name = "smartobject"
		},
		{
			"BTHesitateAction",
			condition = "is_alerted",
			name = "hesitate"
		},
		{
			"BTUtilityNode",
			{
				"BTClanRatFollowAction",
				name = "follow",
				action_data = BreedActions.skaven_clan_rat.follow
			},
			{
				"BTAttackAction",
				name = "running_attack",
				action_data = BreedActions.skaven_clan_rat.running_attack
			},
			{
				"BTAttackAction",
				name = "normal_attack",
				action_data = BreedActions.skaven_clan_rat.normal_attack
			},
			{
				"BTCombatShoutAction",
				name = "combat_shout",
				action_data = BreedActions.skaven_clan_rat.combat_shout
			},
			name = "in_combat",
			condition = "confirmed_player_sighting",
			action_data = BreedActions.skaven_clan_rat.utility_action
		},
		{
			"BTAlertedAction",
			name = "alerted",
			condition = "player_spotted",
			action_data = BreedActions.skaven_clan_rat.alerted
		},
		{
			"BTMoveToGoalAction",
			name = "move_to_goal",
			condition = "has_goal_destination",
			action_data = BreedActions.skaven_clan_rat.follow
		},
		{
			"BTSequence",
			{
				"BTInterestPointChooseAction",
				name = "interest_point_choose",
				action_data = BreedActions.skaven_clan_rat.interest_point_choose
			},
			{
				"BTInterestPointApproachAction",
				name = "interest_point_approach"
			},
			{
				"BTInterestPointUseAction",
				name = "interest_point_use",
				action_data = BreedActions.skaven_clan_rat.interest_point_choose
			},
			condition = "should_use_interest_point",
			name = "interest_point"
		},
		{
			"BTIdleAction",
			name = "idle"
		},
		name = "pack"
	},
	horde_rat = {
		"BTSelector",
		{
			"BTSpawningAction",
			condition = "spawn",
			name = "spawn"
		},
		{
			"BTFallAction",
			condition = "is_falling",
			name = "falling"
		},
		{
			"BTStaggerAction",
			name = "stagger",
			condition = "stagger",
			action_data = BreedActions.skaven_clan_rat.stagger
		},
		{
			"BTBlockedAction",
			name = "blocked",
			condition = "blocked",
			action_data = BreedActions.skaven_clan_rat.blocked
		},
		{
			"BTSelector",
			{
				"BTTeleportAction",
				condition = "at_teleport_smartobject",
				name = "teleport"
			},
			{
				"BTClimbAction",
				condition = "at_climb_smartobject",
				name = "climb"
			},
			{
				"BTJumpAcrossAction",
				condition = "at_jump_smartobject",
				name = "jump_across"
			},
			{
				"BTSmashDoorAction",
				name = "smash_door",
				condition = "at_door_smartobject",
				action_data = BreedActions.skaven_clan_rat.smash_door
			},
			condition = "at_smartobject",
			name = "smartobject"
		},
		{
			"BTUtilityNode",
			{
				"BTClanRatFollowAction",
				name = "follow",
				action_data = BreedActions.skaven_clan_rat.follow
			},
			{
				"BTAttackAction",
				name = "running_attack",
				condition = "ask_target_before_attacking",
				action_data = BreedActions.skaven_clan_rat.running_attack
			},
			{
				"BTAttackAction",
				name = "normal_attack",
				condition = "ask_target_before_attacking",
				action_data = BreedActions.skaven_clan_rat.normal_attack
			},
			{
				"BTCombatShoutAction",
				name = "combat_shout",
				action_data = BreedActions.skaven_clan_rat.combat_shout
			},
			condition = "can_see_player",
			name = "in_combat"
		},
		{
			"BTMoveToGoalAction",
			name = "move_to_goal",
			condition = "has_goal_destination",
			action_data = BreedActions.skaven_clan_rat.follow
		},
		{
			"BTIdleAction",
			name = "idle"
		},
		name = "horde"
	}
}
local STORM_VERMIN_COMBAT_DESTRUCTIBLE_STATIC = {
	"BTSelector",
	{
		"BTClanRatFollowAction",
		name = "move_to_destructible",
		action_data = BreedActions.skaven_storm_vermin.follow
	},
	{
		"BTStormVerminAttackAction",
		name = "cleave_destructible",
		action_data = BreedActions.skaven_storm_vermin.special_attack_cleave
	},
	condition = "has_destructible_as_target",
	name = "combat_destructible"
}
local STORM_VERMIN_COMBAT = {
	"BTUtilityNode",
	{
		"BTClanRatFollowAction",
		name = "follow",
		action_data = BreedActions.skaven_storm_vermin.follow
	},
	{
		"BTRandom",
		{
			"BTStormVerminAttackAction",
			name = "running_special_attack_cleave",
			weight = 1,
			action_data = BreedActions.skaven_storm_vermin.special_attack_cleave
		},
		{
			"BTStormVerminPushAction",
			name = "running_push_attack",
			weight = 2,
			action_data = BreedActions.skaven_storm_vermin.push_attack
		},
		name = "running_attack",
		action_data = BreedActions.skaven_storm_vermin.running_attack
	},
	{
		"BTRandom",
		{
			"BTStormVerminAttackAction",
			name = "special_attack_cleave",
			weight = 1,
			action_data = BreedActions.skaven_storm_vermin.special_attack_cleave
		},
		{
			"BTStormVerminAttackAction",
			name = "special_attack_sweep",
			weight = 1,
			action_data = BreedActions.skaven_storm_vermin.special_attack_sweep
		},
		name = "special_attack",
		action_data = BreedActions.skaven_storm_vermin.special_attack
	},
	{
		"BTStormVerminPushAction",
		name = "push_attack",
		action_data = BreedActions.skaven_storm_vermin.push_attack
	},
	{
		"BTCombatShoutAction",
		name = "combat_shout",
		action_data = BreedActions.skaven_storm_vermin.combat_shout
	},
	condition = "confirmed_player_sighting",
	name = "in_combat"
}
local STORM_VERMIN_SMART_OBJECT = {
	"BTSelector",
	{
		"BTTeleportAction",
		condition = "at_teleport_smartobject",
		name = "teleport"
	},
	{
		"BTClimbAction",
		condition = "at_climb_smartobject",
		name = "climb"
	},
	{
		"BTJumpAcrossAction",
		condition = "at_jump_smartobject",
		name = "jump_across"
	},
	{
		"BTSmashDoorAction",
		name = "smash_door",
		condition = "at_door_smartobject",
		action_data = BreedActions.skaven_storm_vermin.smash_door
	},
	condition = "at_smartobject",
	name = "smartobject"
}
BreedBehaviors.storm_vermin = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTFallAction",
		condition = "is_falling",
		name = "falling"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = BreedActions.skaven_storm_vermin.stagger
	},
	{
		"BTBlockedAction",
		name = "blocked",
		condition = "blocked",
		action_data = BreedActions.skaven_storm_vermin.blocked
	},
	STORM_VERMIN_SMART_OBJECT,
	STORM_VERMIN_COMBAT,
	{
		"BTMoveToGoalAction",
		name = "move_to_goal",
		condition = "has_goal_destination",
		action_data = BreedActions.skaven_storm_vermin.follow
	},
	{
		"BTAlertedAction",
		name = "alerted",
		condition = "player_spotted",
		action_data = BreedActions.skaven_storm_vermin.alerted
	},
	{
		"BTIdleAction",
		name = "idle"
	},
	name = "horde"
}
BreedBehaviors.horde_vermin = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTFallAction",
		condition = "is_falling",
		name = "falling"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = BreedActions.skaven_storm_vermin.stagger
	},
	{
		"BTBlockedAction",
		name = "blocked",
		condition = "blocked",
		action_data = BreedActions.skaven_storm_vermin.blocked
	},
	STORM_VERMIN_COMBAT_DESTRUCTIBLE_STATIC,
	STORM_VERMIN_SMART_OBJECT,
	STORM_VERMIN_COMBAT,
	{
		"BTMoveToGoalAction",
		name = "move_to_goal",
		condition = "has_goal_destination",
		action_data = BreedActions.skaven_storm_vermin.follow
	},
	{
		"BTIdleAction",
		name = "idle"
	},
	name = "horde"
}
BreedBehaviors.storm_vermin_commander = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTFallAction",
		condition = "is_falling",
		name = "falling"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = BreedActions.skaven_storm_vermin.stagger
	},
	{
		"BTBlockedAction",
		name = "blocked",
		condition = "blocked",
		action_data = BreedActions.skaven_storm_vermin.blocked
	},
	{
		"BTBlockedAction",
		condition = "blocked",
		name = "blocked"
	},
	STORM_VERMIN_COMBAT_DESTRUCTIBLE_STATIC,
	STORM_VERMIN_SMART_OBJECT,
	STORM_VERMIN_COMBAT,
	{
		"BTMoveToGoalAction",
		name = "move_to_goal",
		condition = "has_goal_destination",
		action_data = BreedActions.skaven_storm_vermin.follow
	},
	{
		"BTAlertedAction",
		name = "alerted",
		condition = "can_see_player",
		action_data = BreedActions.skaven_storm_vermin.alerted
	},
	{
		"BTIdleAction",
		name = "idle"
	},
	name = "horde"
}
BreedBehaviors.loot_rat = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTFallAction",
		condition = "is_falling",
		name = "falling"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "loot_rat_stagger",
		action_data = BreedActions.skaven_loot_rat.stagger
	},
	{
		"BTSelector",
		{
			"BTTeleportAction",
			condition = "at_teleport_smartobject",
			name = "teleport"
		},
		{
			"BTClimbAction",
			condition = "at_climb_smartobject",
			name = "climb"
		},
		{
			"BTJumpAcrossAction",
			condition = "at_jump_smartobject",
			name = "jump_across"
		},
		{
			"BTSmashDoorAction",
			name = "smash_door",
			condition = "at_door_smartobject",
			action_data = BreedActions.skaven_loot_rat.smash_door
		},
		condition = "at_smartobject",
		name = "smartobject"
	},
	{
		"BTLootRatDodgeAction",
		name = "dodge",
		condition = "loot_rat_dodge",
		action_data = BreedActions.skaven_loot_rat.dodge
	},
	{
		"BTLootRatFleeAction",
		name = "flee",
		condition = "loot_rat_flee",
		action_data = BreedActions.skaven_loot_rat.flee
	},
	{
		"BTLootRatAlertedAction",
		name = "alerted",
		condition = "can_see_player",
		action_data = BreedActions.skaven_loot_rat.alerted
	},
	{
		"BTIdleAction",
		name = "idle",
		action_data = BreedActions.skaven_loot_rat.idle
	},
	name = "horde"
}
BreedBehaviors.skaven_poison_wind_globadier = {
	"BTSelector",
	{
		"BTGlobadierSuicideStaggerAction",
		condition = "suiciding_whilst_staggering",
		name = "suicide_stagger"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = BreedActions.skaven_poison_wind_globadier.stagger
	},
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTSelector",
		{
			"BTTeleportAction",
			condition = "at_teleport_smartobject",
			name = "teleport"
		},
		{
			"BTClimbAction",
			condition = "at_climb_smartobject",
			name = "climb"
		},
		{
			"BTJumpAcrossAction",
			condition = "at_jump_smartobject",
			name = "jump_across"
		},
		{
			"BTSmashDoorAction",
			name = "smash_door",
			condition = "at_door_smartobject",
			action_data = BreedActions.skaven_poison_wind_globadier.smash_door
		},
		condition = "at_smartobject",
		name = "smartobject"
	},
	{
		"BTSelector",
		{
			"BTSuicideRunAction",
			name = "suicide_run",
			condition = "suicide_run",
			action_data = BreedActions.skaven_poison_wind_globadier.suicide_run
		},
		{
			"BTSequence",
			{
				"BTSelector",
				{
					"BTMoveToPlayersAction",
					name = "move_to_players",
					condition = "globadier_skulked_for_too_long",
					action_data = BreedActions.skaven_poison_wind_globadier.move_to_players
				},
				{
					"BTSequence",
					{
						"BTSkulkApproachAction",
						name = "skulk_approach",
						action_data = BreedActions.skaven_poison_wind_globadier.skulk_approach
					},
					{
						"BTAdvanceTowardsPlayersAction",
						name = "advance_towards_players",
						action_data = BreedActions.skaven_poison_wind_globadier.advance_towards_players
					},
					condition = "always_true",
					name = "skulk_movement"
				},
				name = "movement_method"
			},
			{
				"BTThrowPoisonGlobeAction",
				name = "throw_poison_globe",
				action_data = BreedActions.skaven_poison_wind_globadier.throw_poison_globe
			},
			{
				"BTObservePoisonWind",
				name = "observe_poison_wind",
				action_data = BreedActions.skaven_poison_wind_globadier.observe_poison_wind
			},
			name = "attack_pattern"
		},
		condition = "can_see_player",
		name = "in_combat"
	},
	{
		"BTIdleAction",
		name = "idle"
	},
	name = "skaven_poison_wind_globadier"
}
BreedBehaviors.gutter_runner = {
	"BTSelector",
	{
		"BTFallAction",
		condition = "is_gutter_runner_falling",
		name = "falling"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = BreedActions.skaven_gutter_runner.stagger
	},
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTSelector",
		{
			"BTTeleportAction",
			condition = "at_teleport_smartobject",
			name = "teleport"
		},
		{
			"BTJumpAcrossAction",
			condition = "at_jump_smartobject",
			name = "jump_across"
		},
		{
			"BTSmashDoorAction",
			name = "smash_door",
			condition = "at_door_smartobject",
			action_data = BreedActions.skaven_gutter_runner.smash_door
		},
		{
			"BTNinjaHighGroundAction",
			condition = "at_climb_smartobject",
			name = "climb"
		},
		condition = "gutter_runner_at_smartobject",
		name = "smartobject"
	},
	{
		"BTNinjaVanishAction",
		name = "ninja_vanish",
		condition = "ninja_vanish",
		action_data = BreedActions.skaven_gutter_runner.ninja_vanish
	},
	{
		"BTSequence",
		{
			"BTCrazyJumpAction",
			name = "crazy_jump_x"
		},
		{
			"BTTargetPouncedAction",
			name = "target_pounced-x",
			action_data = BreedActions.skaven_gutter_runner.target_pounced
		},
		condition = "quick_jump",
		name = "quick_jump"
	},
	{
		"BTSequence",
		{
			"BTNinjaApproachAction",
			name = "approaching",
			action_data = BreedActions.skaven_gutter_runner.approaching
		},
		{
			"BTPrepareForCrazyJumpAction",
			name = "prepare_crazy_jump"
		},
		{
			"BTCrazyJumpAction",
			name = "crazy_jump"
		},
		{
			"BTTargetPouncedAction",
			name = "target_pounced",
			action_data = BreedActions.skaven_gutter_runner.target_pounced
		},
		condition = "comitted_to_target",
		name = "approach_target"
	},
	{
		"BTCirclePreyAction",
		condition = "secondary_target",
		name = "abide"
	},
	{
		"BTIdleAction",
		name = "idle"
	},
	name = "gutter_runner"
}
BreedBehaviors.pack_master = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTFallAction",
		condition = "is_falling",
		name = "falling"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = BreedActions.skaven_pack_master.stagger
	},
	{
		"BTSelector",
		{
			"BTTeleportAction",
			condition = "at_teleport_smartobject",
			name = "teleport"
		},
		{
			"BTClimbAction",
			condition = "at_climb_smartobject",
			name = "climb"
		},
		{
			"BTJumpAcrossAction",
			condition = "at_jump_smartobject",
			name = "jump_across"
		},
		{
			"BTSmashDoorAction",
			name = "smash_door",
			condition = "at_door_smartobject",
			action_data = BreedActions.skaven_pack_master.smash_door
		},
		condition = "at_smartobject",
		name = "smartobject"
	},
	{
		"BTPackMasterGetHookAction",
		condition = "pack_master_needs_hook",
		name = "get_new_hook"
	},
	{
		"BTSequence",
		{
			"BTPackMasterSkulkAroundAction",
			name = "skulking",
			condition = "path_found",
			action_data = BreedActions.skaven_pack_master.skulk
		},
		{
			"BTPackMasterFollowAction",
			name = "follow",
			condition = "path_found",
			action_data = BreedActions.skaven_pack_master.follow
		},
		{
			"BTPackMasterAttackAction",
			name = "attack",
			action_data = BreedActions.skaven_pack_master.grab_attack
		},
		{
			"BTPackMasterInitialPullAction",
			name = "pull",
			action_data = BreedActions.skaven_pack_master.initial_pull
		},
		{
			"BTPackMasterDragAction",
			name = "drag",
			action_data = BreedActions.skaven_pack_master.drag
		},
		{
			"BTPackMasterHoistAction",
			name = "hoist",
			action_data = BreedActions.skaven_pack_master.hoist
		},
		condition = "can_see_player",
		name = "enemy_spotted"
	},
	{
		"BTTriggerMoveToAction",
		condition = "can_trigger_move_to",
		name = "trigger_move_to"
	},
	{
		"BTIdleAction",
		name = "idle"
	},
	name = "pack_master"
}
BreedBehaviors.skaven_ratling_gunner = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTFallAction",
		condition = "is_falling",
		name = "falling"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = BreedActions.skaven_ratling_gunner.stagger
	},
	{
		"BTSelector",
		{
			"BTTeleportAction",
			condition = "at_teleport_smartobject",
			name = "teleport"
		},
		{
			"BTClimbAction",
			condition = "at_climb_smartobject",
			name = "climb"
		},
		{
			"BTJumpAcrossAction",
			condition = "at_jump_smartobject",
			name = "jump_across"
		},
		{
			"BTSmashDoorAction",
			name = "smash_door",
			condition = "at_door_smartobject",
			action_data = BreedActions.skaven_ratling_gunner.smash_door
		},
		condition = "at_smartobject",
		name = "smartobject"
	},
	{
		"BTSequence",
		{
			"BTSelector",
			{
				"BTMoveToPlayersAction",
				name = "move_to_players",
				condition = "ratling_gunner_skulked_for_too_long",
				action_data = BreedActions.skaven_ratling_gunner.move_to_players
			},
			{
				"BTSequence",
				{
					"BTRatlingGunnerApproachAction",
					name = "lurk",
					action_data = BreedActions.skaven_ratling_gunner.lurk
				},
				{
					"BTRatlingGunnerApproachAction",
					name = "engage",
					action_data = BreedActions.skaven_ratling_gunner.engage
				},
				condition = "always_true",
				name = "skulk_movement"
			},
			name = "movement_method"
		},
		{
			"BTRatlingGunnerWindUpAction",
			name = "wind_up_ratling_gun",
			action_data = BreedActions.skaven_ratling_gunner.wind_up_ratling_gun
		},
		{
			"BTRatlingGunnerShootAction",
			name = "shoot_ratling_gun",
			action_data = BreedActions.skaven_ratling_gunner.shoot_ratling_gun
		},
		{
			"BTRatlingGunnerMoveToShootAction",
			name = "move_to_shoot_position",
			action_data = BreedActions.skaven_ratling_gunner.move_to_shoot_position
		},
		name = "attack_pattern"
	},
	{
		"BTIdleAction",
		name = "idle"
	},
	name = "skaven_ratling_gunner"
}
BreedBehaviors.critter_pig = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTIdleAction",
		name = "idle",
		action_data = BreedActions.critter_pig.idle
	},
	name = "critter_pig"
}
BreedBehaviors.critter_rat = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTCritterRatScurryUnderDoorAction",
		name = "under_door",
		condition = "at_smart_object_and_door",
		action_data = BreedActions.critter_rat.scurry_under_door
	},
	{
		"BTSequence",
		{
			"BTCritterRatFleeAction",
			name = "flee",
			action_data = BreedActions.critter_rat.flee
		},
		{
			"BTCritterRatDigAction",
			name = "dig"
		},
		condition = "is_fleeing",
		name = "flee_sequence"
	},
	{
		"BTIdleAction",
		name = "idle",
		action_data = BreedActions.critter_rat.idle
	},
	name = "critter_rat"
}

if USE_PRECOMPILED_ROOT_TABLES then
	for bt_name, bt_node in pairs(BreedBehaviors) do
		bt_node[1] = "BTSelector_" .. bt_name
		bt_node.name = bt_name .. "_GENERATED"
	end
else
	for bt_name, bt_node in pairs(BreedBehaviors) do
		bt_node[1] = "BTSelector"
		bt_node.name = bt_name
	end
end

return 
