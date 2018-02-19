BreedBehaviors.grey_seer = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTSelector",
		{
			"BTTeleportToPortalAction",
			name = "teleport_1",
			condition = "grey_seer_first_teleport",
			action_data = BreedActions.skaven_grey_seer.teleport_1
		},
		{
			"BTTeleportToPortalAction",
			name = "teleport_2",
			condition = "grey_seer_second_teleport",
			action_data = BreedActions.skaven_grey_seer.teleport_2
		},
		{
			"BTTeleportToPortalAction",
			name = "teleport_3",
			condition = "grey_seer_third_teleport",
			action_data = BreedActions.skaven_grey_seer.teleport_3
		},
		{
			"BTStaggerAction",
			name = "teleport_immune_stagger",
			condition = "teleport_immune_stagger",
			action_data = BreedActions.skaven_grey_seer.stagger
		},
		{
			"BTIdleAction",
			name = "idle",
			action_data = BreedActions.skaven_grey_seer.idle
		},
		condition = "can_see_player",
		name = "teleport"
	},
	{
		"BTIdleAction",
		name = "idle",
		action_data = BreedActions.skaven_grey_seer.idle
	},
	name = "horde"
}

return 
