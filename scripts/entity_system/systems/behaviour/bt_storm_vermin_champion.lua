local ACTIONS = BreedActions.skaven_storm_vermin_champion
BreedBehaviors.storm_vermin_champion = {
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
			action_data = ACTIONS.smash_door
		},
		condition = "at_smartobject",
		name = "smartobject"
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = ACTIONS.stagger
	},
	{
		"BTIdleAction",
		name = "defensive_idle",
		condition = "should_defensive_idle",
		action_data = ACTIONS.defensive_idle
	},
	{
		"BTSelector",
		{
			"BTUtilityNode",
			{
				"BTTargetRageAction",
				name = "turn_to_face_target",
				condition = "target_changed",
				action_data = ACTIONS.turn_to_face_target
			},
			{
				"BTSequence",
				{
					"BTStormVerminAttackAction",
					name = "special_attack_spin_pre_spawn",
					action_data = ACTIONS.special_attack_spin
				},
				{
					"BTSpawnAllies",
					name = "spawn",
					action_data = ACTIONS.spawn_allies
				},
				name = "spawn_sequence",
				action_data = ACTIONS.spawn_sequence
			},
			{
				"BTFollowAction",
				name = "follow",
				action_data = ACTIONS.follow
			},
			{
				"BTStormVerminAttackAction",
				name = "special_running_attack",
				action_data = ACTIONS.special_running_attack
			},
			{
				"BTStormVerminAttackAction",
				name = "special_lunge_attack",
				action_data = ACTIONS.special_lunge_attack
			},
			{
				"BTRandom",
				{
					"BTStormVerminAttackAction",
					name = "special_attack_cleave",
					weight = 1,
					action_data = ACTIONS.special_attack_cleave
				},
				{
					"BTStormVerminAttackAction",
					name = "special_attack_sweep_left",
					weight = 0.5,
					action_data = ACTIONS.special_attack_sweep_left
				},
				{
					"BTStormVerminAttackAction",
					name = "special_attack_sweep_right",
					weight = 0.5,
					action_data = ACTIONS.special_attack_sweep_right
				},
				name = "special_attack_champion",
				action_data = ACTIONS.special_attack_champion
			},
			{
				"BTStormVerminAttackAction",
				name = "special_attack_spin",
				action_data = ACTIONS.special_attack_spin
			},
			{
				"BTStormVerminAttackAction",
				name = "defensive_mode_spin",
				action_data = ACTIONS.defensive_mode_spin
			},
			{
				"BTStormVerminAttackAction",
				name = "special_attack_shatter",
				action_data = ACTIONS.special_attack_shatter
			},
			{
				"BTStormVerminAttackAction",
				name = "defensive_attack_shatter",
				action_data = ACTIONS.defensive_attack_shatter
			},
			name = "combat"
		},
		condition = "can_see_player",
		name = "has_target"
	},
	{
		"BTIdleAction",
		name = "idle"
	},
	name = "horde"
}

return 
