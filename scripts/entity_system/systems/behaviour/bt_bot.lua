BotBehaviors = {
	witch_hunter = {
		"BTSelector",
		{
			"BTNilAction",
			condition = "is_disabled",
			name = "disabled"
		},
		{
			"BTSelector",
			{
				"BTBotTransportedIdleAction",
				name = "transported_idle"
			},
			condition = "is_transported",
			name = "transported"
		},
		{
			"BTBotInteractAction",
			name = "revive",
			condition = "can_revive",
			action_data = BotActions.default.revive
		},
		{
			"BTBotInteractAction",
			name = "rescue_hanging_from_hook",
			condition = "can_rescue_hanging_from_hook",
			action_data = BotActions.default.rescue_from_hook
		},
		{
			"BTBotInteractAction",
			name = "rescue_leadge_hanging",
			condition = "can_rescue_ledge_hanging",
			action_data = BotActions.default.rescue_ledge_hanging
		},
		{
			"BTSequence",
			{
				"BTBotInventorySwitchAction",
				name = "switch_healing_kit",
				action_data = BotActions.default.switch_heal
			},
			{
				"BTBotHealOtherAction",
				name = "use_other_heal",
				action_data = BotActions.default.use_heal_on_player
			},
			name = "heal_other_sequence",
			condition = "can_heal_player",
			condition_args = {
				heal_percentage = 0.25,
				wounded_percentage = 0.5
			}
		},
		{
			"BTBotInteractAction",
			condition = "can_loot_ammo",
			name = "loot_ammo"
		},
		{
			"BTSequence",
			{
				"BTBotInventorySwitchAction",
				name = "switch_healing_kit",
				action_data = BotActions.default.switch_heal
			},
			{
				"BTBotHealAction",
				name = "use_heal"
			},
			condition = "bot_should_heal",
			name = "heal_sequence"
		},
		{
			"BTBotInteractAction",
			condition = "can_loot_med",
			name = "loot_med"
		},
		{
			"BTSelector",
			{
				"BTSelector",
				{
					"BTBotInventorySwitchAction",
					name = "switch_melee_priority_target",
					condition = "is_slot_1_not_wielded",
					action_data = BotActions.default.switch_melee
				},
				{
					"BTBotMeleeAction",
					name = "fight_melee_priority_target",
					action_data = BotActions.default.fight_melee_priority_target
				},
				condition = "bot_in_melee_range",
				name = "melee_priority_target"
			},
			{
				"BTSelector",
				{
					"BTBotInventorySwitchAction",
					name = "switch_ranged_priority_target",
					condition = "is_slot_2_not_wielded",
					action_data = BotActions.default.switch_ranged
				},
				{
					"BTBotShootAction",
					name = "shoot_priority_target",
					action_data = BotActions.default.shoot
				},
				name = "ranged_priority_target",
				condition = "has_target_and_ammo_greater_than",
				condition_args = {
					overcharge_limit = 0.4,
					ammo_percentage = 0
				}
			},
			condition = "has_priority_or_opportunity_target",
			name = "attack_priority_target"
		},
		{
			"BTUtilityNode",
			{
				"BTSelector",
				{
					"BTSelector",
					{
						"BTBotInventorySwitchAction",
						name = "switch_melee",
						condition = "is_slot_1_not_wielded",
						action_data = BotActions.default.switch_melee
					},
					{
						"BTBotMeleeAction",
						name = "fight_melee",
						action_data = BotActions.default.fight_melee
					},
					condition = "bot_in_melee_range",
					name = "melee"
				},
				{
					"BTSelector",
					{
						"BTBotInventorySwitchAction",
						name = "switch_ranged",
						condition = "is_slot_2_not_wielded",
						action_data = BotActions.default.switch_ranged
					},
					{
						"BTBotShootAction",
						name = "shoot",
						action_data = BotActions.default.shoot
					},
					name = "ranged",
					condition = "has_target_and_ammo_greater_than",
					condition_args = {
						overcharge_limit = 0.4,
						ammo_percentage = 0.5
					}
				},
				name = "combat",
				action_data = BotActions.default.combat
			},
			{
				"BTSelector",
				{
					"BTBotInteractAction",
					condition = "can_open_door",
					name = "open_door"
				},
				{
					"BTSelector",
					{
						"BTBotInventorySwitchAction",
						name = "switch_melee_breakable",
						condition = "is_slot_1_not_wielded",
						action_data = BotActions.default.switch_melee
					},
					{
						"BTBotMeleeAction",
						name = "destroying_object",
						action_data = BotActions.default.destroy_object_melee
					},
					condition = "bot_at_breakable",
					name = "melee_break_object"
				},
				{
					"BTBotTeleportToAllyAction",
					condition = "cant_reach_ally",
					name = "teleport_no_path"
				},
				{
					"BTBotFollowAction",
					name = "successful_follow",
					action_data = BotActions.default.successful_follow
				},
				name = "follow",
				action_data = BotActions.default.follow
			},
			condition = "can_see_ally",
			name = "in_combat"
		},
		{
			"BTBotTeleportToAllyAction",
			condition = "can_teleport",
			name = "teleport_out_of_range"
		},
		{
			"BTNilAction",
			name = "idle"
		},
		version = 3,
		name = "witch_hunter"
	},
	dead = {
		"BTNilAction",
		version = 2,
		name = "dead"
	}
}

return 
