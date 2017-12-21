require("scripts/settings/player_unit_damage_settings")

StatBuffs = {
	"HEALING_DONE_BY_POTION",
	"HEALING_DONE_BY_BANDAGE_TO_SELF",
	"HEALING_DONE_BY_BANDAGE_TO_OTHERS",
	"HEALING_POTION_AOE",
	"HEALING_BANDAGE_AOE",
	"PUSH",
	"CRITICAL_STRIKE",
	"ATTACK_SPEED",
	"ATTACK_SPEED_FROM_PROC",
	"ARMOR",
	"FATIGUE_REGEN",
	"FATIGUE_REGEN_FROM_PROC",
	"NOT_DROPPING_POTION",
	"OFFENSIVE_CHARGE",
	"DEFENSIVE_CHARGE",
	"NOT_SLOW_DOWN_ON_HIT_TAKEN",
	"NO_BLOCK_FATIGUE_COST",
	"NO_PUSH_FATIGUE_COST",
	"SLOW_DOWN_ON_HIT_LOW_HEALTH_RECOVER_BONUS",
	"FATIGUE_LOW_HEALTH_DEGEN_DELAY",
	"SHIELD_ON_SPAWN",
	"SHIELD_ON_REVIVE",
	"HEAL_PROC",
	"SHIELD_PROC",
	"HEAL_ON_KILL",
	"SHIELD_ON_KILL",
	"ATTACK_SPEED_ON_KILL",
	"CRITICAL_CHANCE_ON_KILLING_BLOW",
	"CHANCE_TO_BONUS_FATIGUE_REG_DAMAGE_TAKEN",
	"CHANCE_TO_BONUS_FATIGUE_REG_USE",
	"MAX_HEALTH",
	"MAX_FATIGUE",
	"CLIP_SIZE",
	"TOTAL_AMMO",
	"RELOAD_SPEED",
	"ATTACK_SPEED_PROC",
	"FATIGUE_REGEN_PROC",
	"ACCURACY",
	"AMMO_PROC",
	"LIGHT_AMMO_PROC",
	"HEAVY_AMMO_PROC",
	"DAMAGE_ON_TIMED_BLOCK",
	"POISON_PROC",
	"FULL_FATIGUE_ON_BLOCK_BROKEN",
	"KILLING_BLOW_PROC",
	"LIGHT_KILLING_BLOW_PROC",
	"HEAVY_KILLING_BLOW_PROC",
	"LIGHT_HEAL_PROC",
	"HEAVY_HEAL_PROC",
	"LIGHT_ATTACK_SPEED_PROC",
	"HEAVY_ATTACK_SPEED_PROC",
	"OVERCHARGE_PROC",
	"LIGHT_OVERCHARGE_PROC",
	"HEAVY_OVERCHARGE_PROC",
	"REDUCED_OVERCHARGE",
	"AUTOMATIC_HEAD_SHOT",
	"EXTRA_SHOT",
	"REDUCED_VENT_DAMAGE",
	"PENETRATING_SHOT_PROC",
	"OVERCHARGE_EXPLOSION_IMMUNITY",
	"INCREASED_MOVE_SPEED_WHILE_AIMING",
	"ADDED_PUSH",
	"AMMO_ON_KILL",
	"NOT_CONSUME_MEDPACK",
	"NOT_CONSUME_POTION",
	"NOT_CONSUME_GRENADE",
	"HEAL_SELF_ON_HEAL_OTHER",
	"PROTECTION_POISON_WIND",
	"PROTECTION_RATLING_GUNNER",
	"PROTECTION_GUTTER_RUNNER",
	"PROTECTION_PACK_MASTER",
	"MEDPACK_SPREAD_AREA",
	"FASTER_REVIVE",
	"INCREASE_LUCK",
	"DAMAGE_TAKEN_KD",
	"DAMAGE_TAKEN",
	"CURSE_PROTECTION",
	"GRENADE_RADIUS",
	"FASTER_RESPAWN",
	"NOT_CONSUME_PICKUP",
	"INCREASE_DAMAGE_TO_ENEMY_PUSH",
	"INCREASE_DAMAGE_TO_ENEMY_BLOCK",
	"COOP_STAMINA",
	"HEALING_KNOCKED_DOWN_PLAYER_BY_ASSIST",
	"SHIELDING_PLAYER_BY_ASSIST",
	"BACKSTAB_MULTIPLIER",
	"HAWKEYE",
	"DAMAGE_REDUCTION_FROM_PROC",
	"INFINITE_AMMO_FROM_PROC"
}
StatBuffIndex = {}

for i = 1, #StatBuffs, 1 do
	StatBuffIndex[StatBuffs[i]] = i
end

BuffTypes = {
	MELEE = 2,
	PLAYER = 1,
	RANGED = 3
}
StatBuffApplicationMethods = {
	[StatBuffIndex.HEAL_ON_KILL] = "proc",
	[StatBuffIndex.HEAL_PROC] = "proc",
	[StatBuffIndex.SHIELD_ON_KILL] = "proc",
	[StatBuffIndex.SHIELD_PROC] = "proc",
	[StatBuffIndex.ATTACK_SPEED_ON_KILL] = "proc",
	[StatBuffIndex.ATTACK_SPEED_PROC] = "proc",
	[StatBuffIndex.FATIGUE_REGEN_PROC] = "proc",
	[StatBuffIndex.NO_PUSH_FATIGUE_COST] = "proc",
	[StatBuffIndex.NO_BLOCK_FATIGUE_COST] = "proc",
	[StatBuffIndex.MAX_FATIGUE] = "stacking_bonus",
	[StatBuffIndex.ATTACK_SPEED] = "stacking_multiplier",
	[StatBuffIndex.ATTACK_SPEED_FROM_PROC] = "exclusive_multiplier",
	[StatBuffIndex.FATIGUE_REGEN_FROM_PROC] = "exclusive_multiplier",
	[StatBuffIndex.DAMAGE_REDUCTION_FROM_PROC] = "exclusive_multiplier",
	[StatBuffIndex.INFINITE_AMMO_FROM_PROC] = "exclusive_multiplier",
	[StatBuffIndex.RELOAD_SPEED] = "stacking_multiplier",
	[StatBuffIndex.CLIP_SIZE] = "stacking_multiplier",
	[StatBuffIndex.TOTAL_AMMO] = "stacking_multiplier",
	[StatBuffIndex.ACCURACY] = "stacking_multiplier",
	[StatBuffIndex.AMMO_PROC] = "proc",
	[StatBuffIndex.LIGHT_AMMO_PROC] = "proc",
	[StatBuffIndex.HEAVY_AMMO_PROC] = "proc",
	[StatBuffIndex.DAMAGE_ON_TIMED_BLOCK] = "proc",
	[StatBuffIndex.POISON_PROC] = "proc",
	[StatBuffIndex.FULL_FATIGUE_ON_BLOCK_BROKEN] = "proc",
	[StatBuffIndex.KILLING_BLOW_PROC] = "proc",
	[StatBuffIndex.LIGHT_KILLING_BLOW_PROC] = "proc",
	[StatBuffIndex.HEAVY_KILLING_BLOW_PROC] = "proc",
	[StatBuffIndex.LIGHT_HEAL_PROC] = "proc",
	[StatBuffIndex.HEAVY_HEAL_PROC] = "proc",
	[StatBuffIndex.LIGHT_ATTACK_SPEED_PROC] = "proc",
	[StatBuffIndex.HEAVY_ATTACK_SPEED_PROC] = "proc",
	[StatBuffIndex.OVERCHARGE_PROC] = "proc",
	[StatBuffIndex.LIGHT_OVERCHARGE_PROC] = "proc",
	[StatBuffIndex.HEAVY_OVERCHARGE_PROC] = "proc",
	[StatBuffIndex.REDUCED_OVERCHARGE] = "stacking_multiplier",
	[StatBuffIndex.AUTOMATIC_HEAD_SHOT] = "proc",
	[StatBuffIndex.EXTRA_SHOT] = "proc",
	[StatBuffIndex.REDUCED_VENT_DAMAGE] = "stacking_multiplier",
	[StatBuffIndex.PENETRATING_SHOT_PROC] = "proc",
	[StatBuffIndex.OVERCHARGE_EXPLOSION_IMMUNITY] = "proc",
	[StatBuffIndex.INCREASED_MOVE_SPEED_WHILE_AIMING] = "stacking_multiplier",
	[StatBuffIndex.ADDED_PUSH] = "proc",
	[StatBuffIndex.AMMO_ON_KILL] = "proc",
	[StatBuffIndex.NOT_CONSUME_MEDPACK] = "proc",
	[StatBuffIndex.NOT_CONSUME_POTION] = "proc",
	[StatBuffIndex.NOT_CONSUME_GRENADE] = "proc",
	[StatBuffIndex.HEAL_SELF_ON_HEAL_OTHER] = "proc",
	[StatBuffIndex.PROTECTION_POISON_WIND] = "stacking_multiplier",
	[StatBuffIndex.PROTECTION_RATLING_GUNNER] = "stacking_multiplier",
	[StatBuffIndex.PROTECTION_GUTTER_RUNNER] = "stacking_multiplier",
	[StatBuffIndex.PROTECTION_PACK_MASTER] = "stacking_multiplier",
	[StatBuffIndex.MEDPACK_SPREAD_AREA] = "stacking_multiplier",
	[StatBuffIndex.FASTER_REVIVE] = "stacking_multiplier",
	[StatBuffIndex.INCREASE_LUCK] = "stacking_multiplier",
	[StatBuffIndex.DAMAGE_TAKEN_KD] = "stacking_multiplier",
	[StatBuffIndex.DAMAGE_TAKEN] = "stacking_multiplier",
	[StatBuffIndex.CURSE_PROTECTION] = "stacking_multiplier",
	[StatBuffIndex.GRENADE_RADIUS] = "stacking_multiplier",
	[StatBuffIndex.FASTER_RESPAWN] = "stacking_multiplier",
	[StatBuffIndex.NOT_CONSUME_PICKUP] = "proc",
	[StatBuffIndex.INCREASE_DAMAGE_TO_ENEMY_PUSH] = "proc",
	[StatBuffIndex.INCREASE_DAMAGE_TO_ENEMY_BLOCK] = "proc",
	[StatBuffIndex.COOP_STAMINA] = "proc",
	[StatBuffIndex.HEALING_KNOCKED_DOWN_PLAYER_BY_ASSIST] = "proc",
	[StatBuffIndex.SHIELDING_PLAYER_BY_ASSIST] = "proc",
	[StatBuffIndex.BACKSTAB_MULTIPLIER] = "proc",
	[StatBuffIndex.HAWKEYE] = "stacking_bonus"
}
PotionSpreadTrinketTemplates = {
	damage_boost_potion = {
		tier1 = "damage_boost_potion_weak",
		tier3 = "damage_boost_potion",
		tier2 = "damage_boost_potion_medium"
	},
	speed_boost_potion = {
		tier1 = "speed_boost_potion_weak",
		tier3 = "speed_boost_potion",
		tier2 = "speed_boost_potion_medium"
	},
	invulnerability_potion = {
		tier1 = "invulnerability_potion_weak",
		tier3 = "invulnerability_potion",
		tier2 = "invulnerability_potion_medium"
	}
}
TrinketSpreadDistance = 15
BuffTemplates = {
	knockdown_bleed = {
		buffs = {
			{
				attack_damage_template = "knockdown_bleed",
				name = "knockdown bleed",
				damage_type = "knockdown_bleed",
				update_func = "knock_down_bleed_update",
				apply_buff_func = "knock_down_bleed_start",
				time_between_damage = 3
			}
		}
	},
	tank_stance = {
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_tank_activate",
		buffs = {
			{
				duration = 10,
				name = "stance"
			},
			{
				duration = 10,
				name = "lower speed",
				multiplier = 0.6,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				duration = 10,
				name = "armor buff",
				bonus = 2,
				stat_buff = StatBuffIndex.ARMOR
			},
			{
				duration = 10,
				name = "push increase",
				multiplier = 10,
				stat_buff = StatBuffIndex.PUSH
			},
			{
				duration = 10,
				name = "pounce immune"
			},
			{
				duration = 10,
				name = "catapult immune"
			}
		}
	},
	ninja_fencer_stance = {
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_ninjafencer_activate",
		buffs = {
			{
				duration = 10,
				name = "stance"
			},
			{
				duration = 10,
				name = "speed buff",
				multiplier = 1.25,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				duration = 10,
				name = "jump buff",
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				bonus = 0.5,
				path_to_movement_setting_to_modify = {
					"jump",
					"stationary_jump",
					"initial_vertical_velocity"
				}
			},
			{
				duration = 10,
				name = "armor penetration"
			},
			{
				duration = 10,
				name = "crit buff",
				bonus = 1,
				stat_buff = StatBuffIndex.CRITICAL_STRIKE
			},
			{
				duration = 10,
				name = "attack speed buff",
				multiplier = 0.25,
				stat_buff = StatBuffIndex.ATTACK_SPEED
			}
		}
	},
	smiter_stance = {
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_smiter_activate",
		buffs = {
			{
				duration = 10,
				name = "stance"
			},
			{
				duration = 10,
				name = "speed buff",
				multiplier = 0.9,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				name = "crit buff",
				duration = 10,
				bonus = 1,
				stat_buff = StatBuffIndex.CRITICAL_STRIKE,
				buff_type = BuffTypes.MELEE
			},
			{
				duration = 10,
				name = "attack speed buff",
				multiplier = 0.5,
				stat_buff = StatBuffIndex.ATTACK_SPEED
			}
		}
	},
	lines_man_stance = {
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_linesman_activate",
		buffs = {
			{
				duration = 10,
				name = "stance"
			},
			{
				duration = 10,
				name = "attack speed buff",
				multiplier = 0.25,
				stat_buff = StatBuffIndex.ATTACK_SPEED
			},
			{
				name = "crit buff",
				duration = 10,
				bonus = 1,
				stat_buff = StatBuffIndex.CRITICAL_STRIKE,
				buff_type = BuffTypes.MELEE
			},
			{
				duration = 10,
				name = "armor buff",
				bonus = 2,
				stat_buff = StatBuffIndex.ARMOR
			}
		}
	},
	damage_boost_potion = {
		activation_effect = "fx/screenspace_potion_01",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_smiter_activate",
		buffs = {
			{
				duration = 10,
				name = "armor penetration"
			}
		}
	},
	speed_boost_potion = {
		activation_effect = "fx/screenspace_potion_02",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_ninjafencer_activate",
		buffs = {
			{
				name = "movement",
				multiplier = 1.5,
				duration = 10,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				multiplier = 0.5,
				name = "attack speed buff",
				duration = 10,
				stat_buff = StatBuffIndex.ATTACK_SPEED
			}
		}
	},
	invulnerability_potion = {
		activation_effect = "fx/screenspace_potion_03",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_tank_activate",
		buffs = {
			{
				duration = 10,
				name = "invulnerable"
			}
		}
	},
	brawl_knocked_down = {
		buffs = {
			{
				remove_buff_func = "remove_brawl_defeated_buff",
				name = "brawl_defeated",
				apply_buff_func = "apply_brawl_defeated_buff",
				duration = 6
			}
		}
	},
	brawl_beer = {
		trait_name = "brawl_beer",
		apply_on = "wield",
		deactivation_sound = "Stop_pub_brawl_drunk_loop",
		activation_sound = "Play_pub_brawl_drunk_loop",
		buffs = {
			{
				remove_buff_func = "remove_brawl_drunk_buff",
				name = "brawl_drunk",
				apply_buff_func = "apply_brawl_drunk_buff"
			},
			{
				remove_buff_name = "planted_return_to_normal_movement",
				name = "decrease_speed",
				lerp_time = 0.2,
				multiplier = 0.8,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_crouch_movement",
				name = "decrease_crouch_speed",
				lerp_time = 0.2,
				multiplier = 0.8,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"crouch_move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_walk_movement",
				name = "decrease_walk_speed",
				lerp_time = 0.2,
				multiplier = 0.8,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"walk_move_speed"
				}
			}
		}
	},
	damage_boost_potion_weak = {
		activation_effect = "fx/screenspace_potion_01",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_smiter_activate",
		buffs = {
			{
				duration = 3.3,
				name = "armor penetration"
			}
		}
	},
	speed_boost_potion_weak = {
		activation_effect = "fx/screenspace_potion_02",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_ninjafencer_activate",
		buffs = {
			{
				name = "movement",
				multiplier = 1.5,
				duration = 3.3,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				multiplier = 0.5,
				name = "attack speed buff",
				duration = 3.3,
				stat_buff = StatBuffIndex.ATTACK_SPEED
			}
		}
	},
	invulnerability_potion_weak = {
		activation_effect = "fx/screenspace_potion_03",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_tank_activate",
		buffs = {
			{
				duration = 3.3,
				name = "invulnerable"
			}
		}
	},
	damage_boost_potion_medium = {
		activation_effect = "fx/screenspace_potion_01",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_smiter_activate",
		buffs = {
			{
				duration = 6.6,
				name = "armor penetration"
			}
		}
	},
	speed_boost_potion_medium = {
		activation_effect = "fx/screenspace_potion_02",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_ninjafencer_activate",
		buffs = {
			{
				name = "movement",
				multiplier = 1.5,
				duration = 6.6,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				multiplier = 0.5,
				name = "attack speed buff",
				duration = 6.6,
				stat_buff = StatBuffIndex.ATTACK_SPEED
			}
		}
	},
	invulnerability_potion_medium = {
		activation_effect = "fx/screenspace_potion_03",
		deactivation_sound = "hud_gameplay_stance_deactivate",
		activation_sound = "hud_gameplay_stance_tank_activate",
		buffs = {
			{
				duration = 6.6,
				name = "invulnerable"
			}
		}
	},
	grimoire_health_debuff = {
		activation_sound = "hud_info_state_grimoire_pickup",
		buffs = {
			{
				update_func = "update_max_health_debuff",
				name = "grimoire_health_debuff",
				remove_buff_func = "remove_max_health_debuff",
				apply_buff_func = "apply_max_health_debuff",
				multiplier = PlayerUnitDamageSettings.GRIMOIRE_HEALTH_DEBUFF
			}
		}
	},
	overcharged = {
		buffs = {
			{
				multiplier = -0.15,
				name = "attack speed buff",
				stat_buff = StatBuffIndex.ATTACK_SPEED
			}
		}
	},
	overcharged_critical = {
		buffs = {
			{
				remove_buff_name = "planted_return_to_normal_movement",
				name = "increase speed",
				lerp_time = 0.2,
				multiplier = 0.85,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				name = "change dodge speed",
				multiplier = 0.85,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"dodging",
					"speed_modifier"
				}
			},
			{
				multiplier = -0.25,
				name = "attack speed buff",
				stat_buff = StatBuffIndex.ATTACK_SPEED,
				buff_type = BuffTypes.RANGED
			}
		}
	},
	change_dodge_speed = {
		buffs = {
			{
				name = "change dodge speed",
				multiplier = 1,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"dodging",
					"speed_modifier"
				}
			}
		}
	},
	change_dodge_distance = {
		buffs = {
			{
				name = "change dodge distance",
				multiplier = 1,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"dodging",
					"distance_modifier"
				}
			}
		}
	},
	statue_decrease_movement = {
		description = "description_melee_weapon_ammo_on_killing_blow_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_ammo_on_killing_blow_tier1",
		icon = "trait_icons_scavenger",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				remove_buff_name = "planted_return_to_normal_movement",
				name = "decrease_speed",
				lerp_time = 0.2,
				multiplier = 0.7,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_crouch_movement",
				name = "decrease_crouch_speed",
				lerp_time = 0.2,
				multiplier = 0.7,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"crouch_move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_walk_movement",
				name = "decrease_walk_speed",
				lerp_time = 0.2,
				multiplier = 0.7,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"walk_move_speed"
				}
			}
		}
	},
	sack_decrease_movement = {
		description = "description_melee_weapon_ammo_on_killing_blow_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_ammo_on_killing_blow_tier1",
		icon = "trait_icons_scavenger",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				remove_buff_name = "planted_return_to_normal_movement",
				name = "decrease_speed",
				lerp_time = 0.2,
				multiplier = 0.7,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_crouch_movement",
				name = "decrease_crouch_speed",
				lerp_time = 0.2,
				multiplier = 0.7,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"crouch_move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_walk_movement",
				name = "decrease_walk_speed",
				lerp_time = 0.2,
				multiplier = 0.7,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"walk_move_speed"
				}
			}
		}
	},
	planted_decrease_movement = {
		buffs = {
			{
				remove_buff_name = "planted_return_to_normal_movement",
				name = "decrease_speed",
				lerp_time = 0.2,
				multiplier = 0.75,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_crouch_movement",
				name = "decrease_crouch_speed",
				lerp_time = 1,
				multiplier = 0.75,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"crouch_move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_walk_movement",
				name = "decrease_walk_speed",
				lerp_time = 1,
				multiplier = 0.75,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"walk_move_speed"
				}
			}
		}
	},
	planted_charging_decrease_movement = {
		buffs = {
			{
				remove_buff_name = "planted_return_to_normal_movement",
				name = "decrease_speed",
				lerp_time = 1,
				multiplier = 0.75,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_crouch_movement",
				name = "decrease_crouch_speed",
				lerp_time = 1,
				multiplier = 0.75,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"crouch_move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_walk_movement",
				name = "decrease_walk_speed",
				lerp_time = 1,
				multiplier = 0.75,
				update_func = "update_charging_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"walk_move_speed"
				}
			}
		}
	},
	planted_casting_long_decrease_movement = {
		buffs = {
			{
				remove_buff_name = "planted_return_to_normal_movement",
				name = "decrease_speed",
				lerp_time = 2,
				multiplier = 0.75,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_crouch_movement",
				name = "decrease_crouch_speed",
				lerp_time = 2,
				multiplier = 0.75,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"crouch_move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_walk_movement",
				name = "decrease_walk_speed",
				lerp_time = 2,
				multiplier = 0.75,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"walk_move_speed"
				}
			}
		}
	},
	planted_fast_decrease_movement = {
		buffs = {
			{
				remove_buff_name = "planted_return_to_normal_movement",
				name = "decrease_speed",
				lerp_time = 0.01,
				multiplier = 1,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_crouch_movement",
				name = "decrease_crouch_speed",
				lerp_time = 0.01,
				multiplier = 1,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"crouch_move_speed"
				}
			},
			{
				remove_buff_name = "planted_return_to_normal_walk_movement",
				name = "decrease_walk_speed",
				lerp_time = 0.01,
				multiplier = 1,
				update_func = "update_action_lerp_movement_buff",
				remove_buff_func = "remove_action_lerp_movement_buff",
				apply_buff_func = "apply_action_lerp_movement_buff",
				path_to_movement_setting_to_modify = {
					"walk_move_speed"
				}
			}
		}
	},
	planted_return_to_normal_movement = {
		buffs = {
			{
				update_func = "update_action_lerp_remove_movement_buff",
				name = "increase speed return",
				lerp_time = 0.2,
				duration = 1,
				apply_buff_func = "apply_action_lerp_remove_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			}
		}
	},
	planted_return_to_normal_crouch_movement = {
		buffs = {
			{
				update_func = "update_action_lerp_remove_movement_buff",
				name = "increase speed return",
				lerp_time = 0.2,
				duration = 1,
				apply_buff_func = "apply_action_lerp_remove_movement_buff",
				path_to_movement_setting_to_modify = {
					"crouch_move_speed"
				}
			}
		}
	},
	planted_return_to_normal_walk_movement = {
		buffs = {
			{
				update_func = "update_action_lerp_remove_movement_buff",
				name = "increase speed return",
				lerp_time = 0.2,
				duration = 1,
				apply_buff_func = "apply_action_lerp_remove_movement_buff",
				path_to_movement_setting_to_modify = {
					"walk_move_speed"
				}
			}
		}
	},
	arrow_poison_dot = {
		buffs = {
			{
				duration = 3,
				name = "arrow poison dot",
				time_between_dot_damages = 0.6,
				damage_type = "arrow_poison_dot",
				attack_damage_template = "poison",
				update_func = "apply_dot_damage",
				apply_buff_func = "start_dot_damage"
			}
		}
	},
	arrow_poison_dot_t2 = {
		buffs = {
			{
				duration = 3,
				name = "arrow poison dot",
				time_between_dot_damages = 0.6,
				damage_type = "arrow_poison_dot",
				attack_damage_template = "poison_t2",
				update_func = "apply_dot_damage",
				apply_buff_func = "start_dot_damage"
			}
		}
	},
	arrow_poison_dot_t3 = {
		buffs = {
			{
				duration = 3,
				name = "arrow poison dot",
				time_between_dot_damages = 0.6,
				damage_type = "arrow_poison_dot",
				attack_damage_template = "poison_t3",
				update_func = "apply_dot_damage",
				apply_buff_func = "start_dot_damage"
			}
		}
	},
	aoe_poison_dot = {
		buffs = {
			{
				duration = 3,
				name = "arrow poison dot",
				time_between_dot_damages = 1,
				damage_type = "aoe_poison_dot",
				attack_damage_template = "poison_aoe",
				update_func = "apply_dot_damage",
				apply_buff_func = "start_dot_damage"
			}
		}
	},
	aoe_poison_dot_t2 = {
		buffs = {
			{
				duration = 3,
				name = "arrow poison dot",
				time_between_dot_damages = 0.75,
				damage_type = "aoe_poison_dot",
				attack_damage_template = "poison_aoe_t2",
				update_func = "apply_dot_damage",
				apply_buff_func = "start_dot_damage"
			}
		}
	},
	aoe_poison_dot_t3 = {
		buffs = {
			{
				duration = 3,
				name = "arrow poison dot",
				time_between_dot_damages = 0.6,
				damage_type = "aoe_poison_dot",
				attack_damage_template = "poison_aoe_t3",
				update_func = "apply_dot_damage",
				apply_buff_func = "start_dot_damage"
			}
		}
	},
	weapon_bleed_dot_test = {
		buffs = {
			{
				duration = 5,
				name = "weapon bleed dot test",
				time_between_dot_damages = 1,
				damage_type = "weapon_bleed_dot_test",
				attack_damage_template = "poison",
				update_func = "apply_dot_damage",
				apply_buff_func = "start_dot_damage"
			}
		}
	},
	burning_dot = {
		buffs = {
			{
				attack_damage_template = "burning_dot",
				name = "burning dot",
				duration = 3,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 1,
				damage_type = "burninating",
				non_stacking = true,
				update_func = "apply_dot_damage"
			}
		}
	},
	beam_burning_dot = {
		buffs = {
			{
				attack_damage_template = "beam_burning_dot",
				name = "burning dot",
				duration = 3,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 1,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	beam_burning_dot_t2 = {
		buffs = {
			{
				attack_damage_template = "beam_burning_dot_t2",
				name = "burning dot",
				duration = 3,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 0.75,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	beam_burning_dot_t3 = {
		buffs = {
			{
				attack_damage_template = "beam_burning_dot_t3",
				name = "burning dot",
				duration = 3,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 0.6,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	burning_1W_dot = {
		buffs = {
			{
				attack_damage_template = "burning_dot",
				name = "burning dot",
				duration = 2,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 1.5,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	burning_1W_dot_t2 = {
		buffs = {
			{
				attack_damage_template = "burning_dot_t2",
				name = "burning dot",
				duration = 2,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 1.25,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	burning_1W_dot_t3 = {
		buffs = {
			{
				attack_damage_template = "burning_dot_t3",
				name = "burning dot",
				duration = 2,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 1,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	burning_3W_dot = {
		buffs = {
			{
				attack_damage_template = "burning_dot",
				name = "burning dot",
				duration = 3,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 1.25,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	burning_3W_dot_t2 = {
		buffs = {
			{
				attack_damage_template = "burning_dot_t2",
				name = "burning dot",
				duration = 3.5,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 1,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	burning_3W_dot_t3 = {
		buffs = {
			{
				attack_damage_template = "burning_dot_t3",
				name = "burning dot",
				duration = 4,
				end_flow_event = "smoke",
				start_flow_event = "burn",
				remove_buff_func = "remove_dot_damage",
				apply_buff_func = "start_dot_damage",
				time_between_dot_damages = 0.8,
				damage_type = "burninating",
				update_func = "apply_dot_damage"
			}
		}
	},
	globadier_gas_dot = {
		buffs = {
			{
				damage_scale = 0.1,
				name = "globadier_gas_dot",
				duration = 5,
				player_screen_effect_name = "fx/screenspace_poison_globe_impact",
				remove_buff_func = "remove_dot_damage_globadier_gas",
				apply_buff_func = "start_dot_damage_globadier_gas",
				time_between_dot_damages = 1,
				damage_type = "globadier_gas_dot",
				update_func = "apply_dot_damage_globadier_gas",
				bonus = 1
			}
		}
	},
	increase_incoming_damage = {
		buffs = {
			{
				remove_buff_func = "remove_increase_incoming_damage",
				name = "increase_incoming_damage",
				reapply_buff_func = "reapply_increase_incoming_damage",
				non_stacking = true,
				duration = 4,
				apply_buff_func = "start_increase_incoming_damage"
			}
		}
	},
	imba_super_test_buff = {
		buffs = {
			{
				duration = 30,
				name = "increase speed",
				multiplier = 2,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				duration = 30,
				name = "jump buff",
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				bonus = 3,
				path_to_movement_setting_to_modify = {
					"jump",
					"stationary_jump",
					"initial_vertical_velocity"
				}
			},
			{
				duration = 30,
				name = "armor buff",
				bonus = 2,
				stat_buff = StatBuffIndex.ARMOR
			},
			{
				duration = 30,
				name = "push increase",
				multiplier = 10,
				stat_buff = StatBuffIndex.PUSH
			},
			{
				duration = 30,
				name = "pounce immune"
			},
			{
				duration = 30,
				name = "catapult immune"
			},
			{
				duration = 30,
				name = "armor penetration"
			},
			{
				name = "crit buff",
				duration = 30,
				bonus = 0.5,
				stat_buff = StatBuffIndex.CRITICAL_STRIKE,
				buff_type = BuffTypes.MELEE
			},
			{
				duration = 30,
				name = "attack speed buff",
				multiplier = 1,
				stat_buff = StatBuffIndex.ATTACK_SPEED
			},
			{
				duration = 30,
				name = "healing taken by others buff",
				multiplier = 2,
				stat_buff = StatBuffIndex.HEALING_DONE_TO_OTHERS
			}
		}
	},
	super_jump = {
		buffs = {
			{
				duration = 20,
				name = "speed buff",
				multiplier = 1.7,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			},
			{
				duration = 10,
				name = "jump buff",
				multiplier = 1.2,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				bonus = 5,
				path_to_movement_setting_to_modify = {
					"jump",
					"stationary_jump",
					"initial_vertical_velocity"
				}
			}
		}
	},
	damage_volume_generic_dot = {
		buffs = {
			{
				update_func = "update_volume_dot_damage",
				name = "damage_volume_generic_dot",
				apply_buff_func = "apply_volume_dot_damage",
				damage_type = "volume_generic_dot"
			}
		}
	},
	movement_volume_generic_slowdown = {
		buffs = {
			{
				remove_buff_func = "remove_volume_movement_buff",
				name = "movement_volume_generic_slowdown",
				apply_buff_func = "apply_volume_movement_buff"
			}
		}
	},
	ranged_weapon_heal_on_killing_blow_tier1 = {
		description = "description_ranged_weapon_heal_on_killing_blow_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_heal_on_killing_blow_tier1",
		icon = "trait_icon_bloodlust",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "heal_on_kill",
				bonus = 10,
				stat_buff = StatBuffIndex.HEAL_ON_KILL,
				proc_chance = {
					0.03,
					0.08
				}
			}
		}
	},
	ranged_weapon_heal_proc_tier1 = {
		description = "description_ranged_weapon_heal_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_heal_proc_tier1",
		icon = "trait_icons_regrowth",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "heal_proc",
				bonus = 5,
				stat_buff = StatBuffIndex.HEAL_PROC,
				proc_chance = {
					0.03,
					0.07
				}
			}
		}
	},
	ranged_weapon_heal_proc_fast_tier1 = {
		description = "description_ranged_weapon_heal_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_heal_proc_tier1",
		icon = "trait_icons_regrowth",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "heal_proc",
				bonus = 5,
				stat_buff = StatBuffIndex.HEAL_PROC,
				proc_chance = {
					0.02,
					0.05
				}
			}
		}
	},
	ranged_weapon_heal_proc_slow_tier1 = {
		description = "description_ranged_weapon_heal_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_heal_proc_tier1",
		icon = "trait_icons_regrowth",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "heal_proc",
				bonus = 5,
				stat_buff = StatBuffIndex.HEAL_PROC,
				proc_chance = {
					0.05,
					0.12
				}
			}
		}
	},
	ranged_weapon_attack_speed_on_killing_blow_tier1 = {
		description = "description_ranged_weapon_attack_speed_on_killing_blow_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_attack_speed_on_killing_blow_tier1",
		icon = "trait_icons_berserking",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "attack_speed_on_kill",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.ATTACK_SPEED_ON_KILL,
				proc_chance = {
					0.03,
					0.1
				}
			}
		}
	},
	ranged_weapon_attack_speed_proc_tier1 = {
		description = "description_ranged_weapon_attack_speed_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_attack_speed_proc_tier1",
		icon = "trait_icon_haste",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "attack_speed_proc",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.ATTACK_SPEED_PROC,
				proc_chance = {
					0.03,
					0.07
				}
			}
		}
	},
	ranged_weapon_attack_speed_proc_fast_tier1 = {
		description = "description_ranged_weapon_attack_speed_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_attack_speed_proc_tier1",
		icon = "trait_icon_haste",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "attack_speed_proc",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.ATTACK_SPEED_PROC,
				proc_chance = {
					0.02,
					0.05
				}
			}
		}
	},
	ranged_weapon_attack_speed_proc_slow_tier1 = {
		description = "description_ranged_weapon_attack_speed_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_attack_speed_proc_tier1",
		icon = "trait_icon_haste",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.5,
				name = "attack_speed_proc",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.ATTACK_SPEED_PROC,
				proc_chance = {
					0.05,
					0.12
				}
			}
		}
	},
	ranged_weapon_clip_size_tier1 = {
		description = "description_ranged_weapon_clip_size_tier1",
		apply_on = "equip",
		display_name = "ranged_weapon_clip_size_tier1",
		icon = "trait_icons_extracapacity",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.5,
				name = "clip_size",
				stat_buff = StatBuffIndex.CLIP_SIZE
			}
		}
	},
	ranged_weapon_clip_size_small_clip_tier1 = {
		description = "description_ranged_weapon_clip_size_tier1",
		apply_on = "equip",
		display_name = "ranged_weapon_clip_size_tier1",
		icon = "trait_icons_extracapacity",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 1,
				name = "clip_size",
				stat_buff = StatBuffIndex.CLIP_SIZE
			}
		}
	},
	ranged_weapon_clip_size_repeating_crossbow_clip_tier1 = {
		description = "description_ranged_weapon_clip_size_tier1",
		apply_on = "equip",
		display_name = "ranged_weapon_clip_size_tier1",
		icon = "trait_icons_extracapacity",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "clip_size",
				stat_buff = StatBuffIndex.CLIP_SIZE
			}
		}
	},
	ranged_weapon_total_ammo_tier1 = {
		description = "description_ranged_weapon_total_ammo_tier1",
		apply_on = "equip",
		display_name = "ranged_weapon_total_ammo_tier1",
		icon = "trait_icons_ammunitionholder",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.3,
				name = "total_ammo",
				stat_buff = StatBuffIndex.TOTAL_AMMO
			}
		}
	},
	ranged_weapon_reload_speed_tier1 = {
		description = "description_ranged_weapon_reload_speed_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_reload_speed_tier1",
		icon = "trait_icon_mastercrafted",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.25,
				name = "reload_speed",
				stat_buff = StatBuffIndex.RELOAD_SPEED
			}
		}
	},
	ranged_weapon_reload_speed_slow = {
		description = "description_ranged_weapon_reload_speed_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_reload_speed_tier1",
		icon = "trait_icon_mastercrafted",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.2,
				name = "reload_speed",
				stat_buff = StatBuffIndex.RELOAD_SPEED
			}
		}
	},
	ranged_weapon_increased_zoom = {
		description = "description_ranged_weapon_increased_zoom",
		apply_on = "wield",
		display_name = "ranged_weapon_increased_zoom",
		icon = "trait_icon_hawkeye",
		buffs = {
			{
				name = "increased_zoom",
				bonus = 2,
				stat_buff = StatBuffIndex.HAWKEYE
			}
		}
	},
	ranged_weapon_accuracy_tier1 = {
		description = "description_ranged_weapon_accuracy_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_accuracy_tier1",
		icon = "trait_icon_targeteer",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.5,
				name = "accuracy",
				stat_buff = StatBuffIndex.ACCURACY
			}
		}
	},
	ranged_weapon_return_ammo_tier1 = {
		description = "description_ranged_weapon_return_ammo_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_return_ammo_tier1",
		icon = "trait_icons_scavenger",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "ammo_proc",
				bonus = 0.05,
				stat_buff = StatBuffIndex.AMMO_ON_KILL,
				proc_chance = {
					0.1,
					0.24
				}
			}
		}
	},
	ranged_weapon_return_ammo_slow_tier1 = {
		description = "description_ranged_weapon_return_ammo_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_return_ammo_tier1",
		icon = "trait_icons_scavenger",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "ammo_proc",
				bonus = 0.05,
				stat_buff = StatBuffIndex.AMMO_ON_KILL,
				proc_chance = {
					0.1,
					0.2
				}
			}
		}
	},
	ranged_weapon_killing_blow_tier1 = {
		description = "description_ranged_weapon_killing_blow_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_killing_blow_tier1",
		icon = "trait_icon_killingblow",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "killing_blow_proc",
				stat_buff = StatBuffIndex.KILLING_BLOW_PROC,
				proc_chance = {
					0.02,
					0.1
				}
			}
		}
	},
	ranged_weapon_killing_blow_slow_tier1 = {
		description = "description_ranged_weapon_killing_blow_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_killing_blow_tier1",
		icon = "trait_icon_killingblow",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "killing_blow_proc",
				stat_buff = StatBuffIndex.KILLING_BLOW_PROC,
				proc_chance = {
					0.05,
					0.15
				}
			}
		}
	},
	ranged_weapon_heroic_killing_blow_tier1 = {
		description = "description_ranged_weapon_heroic_killing_blow_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_heroic_killing_blow_tier1",
		icon = "trait_icon_heroic_killingblow",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "killing_blow_proc",
				stat_buff = StatBuffIndex.KILLING_BLOW_PROC,
				proc_chance = {
					0.02,
					0.06
				}
			}
		}
	},
	ranged_weapon_reduced_overcharge_tier1 = {
		description = "description_ranged_weapon_reduced_overcharge_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_reduced_overcharge_tier1",
		icon = "trait_icons_stability",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.1,
				name = "reduced_overcharge",
				stat_buff = StatBuffIndex.REDUCED_OVERCHARGE
			}
		}
	},
	ranged_weapon_automatic_headshot_tier1 = {
		description = "description_ranged_weapon_automatic_headshot_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_automatic_headshot_tier1",
		icon = "trait_icon_skullcracker",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "automatic_head_shot",
				stat_buff = StatBuffIndex.AUTOMATIC_HEAD_SHOT,
				proc_chance = {
					0.05,
					0.15
				}
			}
		}
	},
	ranged_weapon_extra_shot_tier1 = {
		description = "description_ranged_weapon_extra_shot_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_extra_shot_tier1",
		icon = "trait_icon_hailofdoom",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "extra_shot",
				stat_buff = StatBuffIndex.EXTRA_SHOT,
				proc_chance = {
					0.05,
					0.15
				}
			}
		}
	},
	ranged_weapon_reduced_discharge_tier1 = {
		description = "description_ranged_weapon_reduced_discharge_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_reduced_discharge_tier1",
		icon = "trait_icons_channelingrune",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.5,
				name = "reduced_vent_damage",
				stat_buff = StatBuffIndex.REDUCED_VENT_DAMAGE
			}
		}
	},
	ranged_weapon_increased_penetration_tier1 = {
		description = "description_ranged_weapon_increased_penetration_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_increased_penetration_tier1",
		icon = "trait_icon_Rupture",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "penetrating_shot_proc",
				bonus = 2,
				stat_buff = StatBuffIndex.PENETRATING_SHOT_PROC,
				proc_chance = {
					0.8,
					1
				}
			}
		}
	},
	ranged_weapon_overcharge_explosion_immunity = {
		description = "description_ranged_weapon_overcharge_explosion_immunity",
		apply_on = "wield",
		display_name = "ranged_weapon_overcharge_explosion_immunity",
		icon = "icons_placeholder",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "overcharge_explosion_immunity",
				stat_buff = StatBuffIndex.OVERCHARGE_EXPLOSION_IMMUNITY,
				proc_chance = {
					0.05,
					0.15
				}
			}
		}
	},
	ranged_weapon_increased_speed_while_aiming_tier1 = {
		description = "description_ranged_weapon_increased_move_speed_while_aiming_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_increased_speed_while_aiming_tier1",
		icon = "trait_icons_skirmisher",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.5,
				name = "increased_move_speed_while_aiming",
				stat_buff = StatBuffIndex.INCREASED_MOVE_SPEED_WHILE_AIMING
			}
		}
	},
	ranged_weapon_added_push_proc_tier1 = {
		description = "description_ranged_weapon_added_push_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_added_push_proc_tier1",
		icon = "trait_icon_knockback",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "added_push",
				stat_buff = StatBuffIndex.ADDED_PUSH,
				proc_chance = {
					0.1,
					0.2
				}
			}
		}
	},
	ranged_weapon_added_push_proc_fast_tier1 = {
		description = "description_ranged_weapon_added_push_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_added_push_proc_tier1",
		icon = "trait_icon_knockback",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "added_push",
				stat_buff = StatBuffIndex.ADDED_PUSH,
				proc_chance = {
					0.05,
					0.1
				}
			}
		}
	},
	ranged_weapon_added_push_proc_slow_tier1 = {
		description = "description_ranged_weapon_added_push_proc_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_added_push_proc_tier1",
		icon = "trait_icon_knockback",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "added_push",
				stat_buff = StatBuffIndex.ADDED_PUSH,
				proc_chance = {
					0.3,
					0.4
				}
			}
		}
	},
	ranged_weapon_attack_speed_tier1 = {
		description = "description_ranged_weapon_attack_speed_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_attack_speed_tier1",
		icon = "trait_icon_mastercrafted",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.25,
				name = "attack_speed",
				stat_buff = StatBuffIndex.ATTACK_SPEED
			}
		}
	},
	ranged_weapon_coop_stamina = {
		description = "dlc1_1_description_ranged_weapon_coop_stamina",
		apply_on = "wield",
		display_name = "dlc1_1_ranged_weapon_coop_stamina",
		icon = "trait_icon_inspirational_shot",
		description_values = {},
		buffs = {
			{
				name = "coop_stamina",
				stat_buff = StatBuffIndex.COOP_STAMINA
			}
		}
	},
	ranged_weapon_heal_knocked_down_proc_on_assist_tier1 = {
		description = "dlc1_1_description_ranged_weapon_heal_knocked_down_proc_on_assist_tier1",
		apply_on = "wield",
		display_name = "dlc1_1_ranged_weapon_heal_knocked_down_proc_on_assist_tier1",
		icon = "trait_icon_distraction",
		description_values = {
			"bonus"
		},
		buffs = {
			{
				name = "heal_other_on_assist",
				bonus = 40,
				stat_buff = StatBuffIndex.HEALING_KNOCKED_DOWN_PLAYER_BY_ASSIST
			}
		}
	},
	ranged_weapon_shield_proc_on_on_assist_tier1 = {
		description = "description_ranged_weapon_shield_proc_on_on_assist_tier1",
		apply_on = "wield",
		display_name = "ranged_weapon_shield_proc_on_on_assist_tier1",
		icon = "trait_icon_safety_in_numbers",
		description_values = {
			"bonus"
		},
		buffs = {
			{
				name = "one_hit_shield_on_assist",
				bonus = 30,
				stat_buff = StatBuffIndex.SHIELDING_PLAYER_BY_ASSIST
			}
		}
	},
	melee_weapon_heal_on_killing_blow_tier1 = {
		description = "description_melee_weapon_heal_on_killing_blow_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_heal_on_killing_blow_tier1",
		icon = "trait_icon_bloodlust",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "heal_on_kill",
				bonus = 10,
				stat_buff = StatBuffIndex.HEAL_ON_KILL,
				proc_chance = {
					0.03,
					0.1
				}
			}
		}
	},
	melee_weapon_heal_proc_light_tier1 = {
		description = "description_melee_weapon_heal_proc_light_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_heal_proc_light_tier1",
		icon = "trait_icons_regrowth",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "light_heal_proc",
				bonus = 5,
				stat_buff = StatBuffIndex.LIGHT_HEAL_PROC,
				proc_chance = {
					0.03,
					0.1
				}
			}
		}
	},
	melee_weapon_heal_proc_light_fast_tier1 = {
		description = "description_melee_weapon_heal_proc_light_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_heal_proc_light_tier1",
		icon = "trait_icons_regrowth",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "light_heal_proc",
				bonus = 5,
				stat_buff = StatBuffIndex.LIGHT_HEAL_PROC,
				proc_chance = {
					0.01,
					0.05
				}
			}
		}
	},
	melee_weapon_heal_proc_heavy_single_tier1 = {
		description = "description_melee_weapon_heal_proc_heavy_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_heal_proc_heavy_tier1",
		icon = "trait_icons_regrowth_charged",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "heavy_heal_proc",
				bonus = 10,
				stat_buff = StatBuffIndex.HEAVY_HEAL_PROC,
				proc_chance = {
					0.03,
					0.1
				}
			}
		}
	},
	melee_weapon_heal_proc_heavy_multiple_tier1 = {
		description = "description_melee_weapon_heal_proc_heavy_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_heal_proc_heavy_tier1",
		icon = "trait_icons_regrowth_charged",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "heavy_heal_proc",
				bonus = 10,
				stat_buff = StatBuffIndex.HEAVY_HEAL_PROC,
				proc_chance = {
					0.01,
					0.03
				}
			}
		}
	},
	melee_weapon_attack_speed_on_killing_blow_tier1 = {
		description = "description_melee_weapon_attack_speed_on_killing_blow_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_attack_speed_on_killing_blow_tier1",
		icon = "trait_icons_berserking",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "attack_speed_on_kill",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.ATTACK_SPEED_ON_KILL,
				proc_chance = {
					0.05,
					0.12
				}
			}
		}
	},
	melee_weapon_attack_speed_proc_light_tier1 = {
		description = "description_melee_weapon_attack_speed_proc_light_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_attack_speed_proc_light_tier1",
		icon = "trait_icon_swiftslaying",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "light_attack_speed_proc",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.LIGHT_ATTACK_SPEED_PROC,
				proc_chance = {
					0.02,
					0.07
				}
			}
		}
	},
	melee_weapon_attack_speed_proc_light_fast_tier1 = {
		description = "description_melee_weapon_attack_speed_proc_light_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_attack_speed_proc_light_tier1",
		icon = "trait_icon_swiftslaying",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "light_attack_speed_proc",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.LIGHT_ATTACK_SPEED_PROC,
				proc_chance = {
					0.01,
					0.04
				}
			}
		}
	},
	melee_weapon_attack_speed_proc_heavy_single_tier1 = {
		description = "description_melee_weapon_attack_speed_proc_heavy_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_attack_speed_proc_heavy_tier1",
		icon = "trait_icon_swiftslaying_charged",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "heavy_attack_speed_proc",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.HEAVY_ATTACK_SPEED_PROC,
				proc_chance = {
					0.02,
					0.07
				}
			}
		}
	},
	melee_weapon_attack_speed_proc_heavy_multiple_tier1 = {
		description = "description_melee_weapon_attack_speed_proc_heavy_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_attack_speed_proc_heavy_tier1",
		icon = "trait_icon_swiftslaying_charged",
		description_values = {
			"proc_chance",
			"multiplier",
			"duration"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "heavy_attack_speed_proc",
				proc = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.HEAVY_ATTACK_SPEED_PROC,
				proc_chance = {
					0.01,
					0.04
				}
			}
		}
	},
	melee_weapon_fatigue_regen_proc_tier1 = {
		description = "description_melee_weapon_fatigue_regen_proc_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_fatigue_regen_proc_tier1",
		icon = "trait_icons_endurance",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				multiplier = 1,
				name = "fatigue_regen_proc",
				proc = "fatigue_regen_from_proc",
				stat_buff = StatBuffIndex.FATIGUE_REGEN_PROC,
				proc_chance = {
					0.1,
					0.2
				}
			}
		}
	},
	melee_weapon_no_push_fatigue_cost_tier1 = {
		description = "description_melee_weapon_no_push_fatigue_cost_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_no_push_fatigue_cost_tier1",
		icon = "trait_icons_improvedpommel",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "no_push_fatigue_cost",
				stat_buff = StatBuffIndex.NO_PUSH_FATIGUE_COST,
				proc_chance = {
					0.2,
					0.4
				}
			}
		}
	},
	melee_weapon_no_block_fatigue_cost_tier1 = {
		description = "description_melee_weapon_no_block_fatigue_cost_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_no_block_fatigue_cost_tier1",
		icon = "trait_icons_improvedguard",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "no_block_fatigue_cost",
				stat_buff = StatBuffIndex.NO_BLOCK_FATIGUE_COST,
				proc_chance = {
					0.1,
					0.3
				}
			}
		}
	},
	melee_weapon_max_fatigue_tier1 = {
		description = "description_melee_weapon_max_fatigue_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_max_fatigue_tier1",
		icon = "trait_icons_perfectbalance",
		description_values = {
			"bonus_description"
		},
		buffs = {
			{
				bonus_description = 1,
				name = "max_fatigue",
				bonus = 2,
				stat_buff = StatBuffIndex.MAX_FATIGUE
			}
		}
	},
	melee_weapon_push_increase = {
		description = "description_melee_weapon_push_increase",
		apply_on = "wield",
		display_name = "melee_weapon_push_increase",
		icon = "trait_icons_devastatingblow",
		buffs = {
			{
				name = "push_increase"
			}
		}
	},
	melee_weapon_damage_on_timed_block = {
		description = "description_melee_weapon_damage_on_timed_block",
		apply_on = "wield",
		display_name = "melee_weapon_damage_on_timed_block",
		icon = "icons_placeholder",
		buffs = {
			{
				name = "damage_on_timed_block",
				stat_buff = StatBuffIndex.DAMAGE_ON_TIMED_BLOCK
			}
		}
	},
	melee_weapon_full_fatigue_on_block_broken_tier1 = {
		description = "description_melee_weapon_full_fatigue_on_block_broken_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_full_fatigue_on_block_broken_tier1",
		icon = "trait_icon_secondwind",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "full_fatigue_on_block_broken",
				stat_buff = StatBuffIndex.FULL_FATIGUE_ON_BLOCK_BROKEN,
				proc_chance = {
					0.3,
					0.5
				}
			}
		}
	},
	melee_weapon_killing_blow_proc_tier1 = {
		description = "description_melee_weapon_killing_blow_proc_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_killing_blow_proc_tier1",
		icon = "trait_icon_killingblow",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "light_killing_blow_proc",
				stat_buff = StatBuffIndex.LIGHT_KILLING_BLOW_PROC,
				proc_chance = {
					0.05,
					0.15
				}
			}
		}
	},
	melee_weapon_heroic_killing_blow_proc_tier1 = {
		description = "description_melee_weapon_heroic_killing_blow_proc_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_heroic_killing_blow_proc_tier1",
		icon = "trait_icon_heroic_killingblow",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "heavy_killing_blow_proc",
				stat_buff = StatBuffIndex.HEAVY_KILLING_BLOW_PROC,
				proc_chance = {
					0.01,
					0.03
				}
			}
		}
	},
	melee_weapon_overcharge_proc_light_tier1 = {
		description = "description_melee_weapon_overcharge_proc_light_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_overcharge_proc_light_tier1",
		icon = "trait_icons_earthingrune",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "light_overcharge_proc",
				bonus = 5,
				stat_buff = StatBuffIndex.LIGHT_OVERCHARGE_PROC,
				proc_chance = {
					0.1,
					0.2
				}
			}
		}
	},
	melee_weapon_overcharge_proc_heavy_tier1 = {
		description = "description_melee_weapon_overcharge_proc_heavy_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_overcharge_proc_heavy_tier1",
		icon = "trait_icons_earthingrune_charged",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				name = "heavy_overcharge_proc",
				bonus = 5,
				stat_buff = StatBuffIndex.HEAVY_OVERCHARGE_PROC,
				proc_chance = {
					0.1,
					0.2
				}
			}
		}
	},
	melee_weapon_ammo_on_killing_blow_tier1 = {
		description = "description_melee_weapon_ammo_on_killing_blow_tier1",
		apply_on = "wield",
		display_name = "melee_weapon_ammo_on_killing_blow_tier1",
		icon = "trait_icons_scavenger",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				name = "ammo_on_kill",
				bonus = 0.05,
				stat_buff = StatBuffIndex.AMMO_ON_KILL,
				proc_chance = {
					0.15,
					0.2
				}
			}
		}
	},
	melee_weapon_increase_damage_to_enemy_push = {
		description = "dlc1_1_description_melee_weapon_increase_damage_to_enemy_push",
		apply_on = "wield",
		display_name = "dlc1_1_melee_weapon_increase_damage_to_enemy_push",
		icon = "trait_icons_scavenger",
		buffs = {
			{
				name = "increase_damage_to_enemy",
				stat_buff = StatBuffIndex.INCREASE_DAMAGE_TO_ENEMY_PUSH
			}
		}
	},
	melee_weapon_increase_damage_to_enemy_block = {
		description = "dlc1_1_description_melee_weapon_increase_damage_to_enemy_block",
		apply_on = "wield",
		display_name = "dlc1_1_melee_weapon_increase_damage_to_enemy_block",
		icon = "trait_icon_off_balance",
		buffs = {
			{
				name = "increase_damage_to_enemy",
				stat_buff = StatBuffIndex.INCREASE_DAMAGE_TO_ENEMY_BLOCK
			}
		}
	},
	melee_weapon_heal_knocked_down_proc_on_assist_tier1 = {
		description = "dlc1_1_description_melee_weapon_heal_knocked_down_proc_on_assist_tier1",
		apply_on = "wield",
		display_name = "dlc1_1_melee_weapon_heal_knocked_down_proc_on_assist_tier1",
		icon = "trait_icon_distraction",
		description_values = {
			"bonus"
		},
		buffs = {
			{
				name = "heal_other_on_assist",
				bonus = 40,
				stat_buff = StatBuffIndex.HEALING_KNOCKED_DOWN_PLAYER_BY_ASSIST
			}
		}
	},
	melee_weapon_shield_proc_on_on_assist_tier1 = {
		description = "dlc1_1_description_melee_weapon_shield_proc_on_on_assist_tier1",
		apply_on = "wield",
		display_name = "dlc1_1_melee_weapon_shield_proc_on_on_assist_tier1",
		icon = "trait_icon_safety_in_numbers",
		description_values = {
			"bonus"
		},
		buffs = {
			{
				name = "one_hit_shield_on_assist",
				bonus = 30,
				stat_buff = StatBuffIndex.SHIELDING_PLAYER_BY_ASSIST
			}
		}
	},
	melee_weapon_backstab_tier1 = {
		description = "dlc1_1_description_melee_weapon_backstab_tier1",
		apply_on = "wield",
		display_name = "dlc1_1_melee_weapon_backstab_tier1",
		icon = "trait_icon_backstabbery",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 1,
				name = "melee_backstab_tier1",
				stat_buff = StatBuffIndex.BACKSTAB_MULTIPLIER
			}
		}
	},
	attack_speed_from_proc = {
		buffs = {
			{
				duration = 5,
				name = "attack_speed_from_proc",
				stat_buff = StatBuffIndex.ATTACK_SPEED_FROM_PROC
			}
		}
	},
	move_speed_from_proc = {
		buffs = {
			{
				name = "movement",
				multiplier = 1.5,
				duration = 5,
				non_stacking = true,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			}
		}
	},
	fatigue_regen_from_proc = {
		buffs = {
			{
				duration = 5,
				name = "fatigue_regen_from_proc",
				stat_buff = StatBuffIndex.FATIGUE_REGEN_FROM_PROC
			}
		}
	},
	damage_reduction_from_proc = {
		buffs = {
			{
				multiplier = -0.5,
				name = "damage_reduction_from_proc",
				duration = 5,
				stat_buff = StatBuffIndex.DAMAGE_REDUCTION_FROM_PROC
			}
		}
	},
	infinite_ammo_from_proc = {
		buffs = {
			{
				duration = 3,
				name = "infinite_ammo_from_proc",
				stat_buff = StatBuffIndex.INFINITE_AMMO_FROM_PROC
			}
		}
	},
	trinket_not_consume_medpack_tier1 = {
		description = "trinket_not_consume_medpack_tier1_description",
		display_name = "trinket_not_consume_medpack_tier1",
		unique_id = "trinket_not_consume_medpack",
		icon = "trinket_not_consume_medpack_tier1",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.1,
				name = "not_consume_medpack",
				stat_buff = StatBuffIndex.NOT_CONSUME_MEDPACK
			}
		}
	},
	trinket_not_consume_medpack_tier2 = {
		description = "trinket_not_consume_medpack_tier2_description",
		display_name = "trinket_not_consume_medpack_tier2",
		unique_id = "trinket_not_consume_medpack",
		icon = "trinket_not_consume_medpack_tier2",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.15,
				name = "not_consume_medpack",
				stat_buff = StatBuffIndex.NOT_CONSUME_MEDPACK
			}
		}
	},
	trinket_not_consume_medpack_tier3 = {
		description = "trinket_not_consume_medpack_tier3_description",
		display_name = "trinket_not_consume_medpack_tier3",
		unique_id = "trinket_not_consume_medpack",
		icon = "trinket_not_consume_medpack_tier3",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.2,
				name = "not_consume_medpack",
				stat_buff = StatBuffIndex.NOT_CONSUME_MEDPACK
			}
		}
	},
	trinket_not_consume_potion_tier1 = {
		description = "trinket_not_consume_potion_tier1_description",
		display_name = "trinket_not_consume_potion_tier1",
		unique_id = "trinket_not_consume_potion",
		icon = "trinket_not_consume_potion_tier1",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.15,
				name = "not_consume_potion",
				stat_buff = StatBuffIndex.NOT_CONSUME_POTION
			}
		}
	},
	trinket_not_consume_potion_tier2 = {
		description = "trinket_not_consume_potion_tier2_description",
		display_name = "trinket_not_consume_potion_tier2",
		unique_id = "trinket_not_consume_potion",
		icon = "trinket_not_consume_potion_tier2",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.2,
				name = "not_consume_potion",
				stat_buff = StatBuffIndex.NOT_CONSUME_POTION
			}
		}
	},
	trinket_not_consume_potion_tier3 = {
		description = "trinket_not_consume_potion_tier3_description",
		display_name = "trinket_not_consume_potion_tier3",
		unique_id = "trinket_not_consume_potion",
		icon = "trinket_not_consume_potion_tier3",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.25,
				name = "not_consume_potion",
				stat_buff = StatBuffIndex.NOT_CONSUME_POTION
			}
		}
	},
	trinket_not_consume_grenade_tier1 = {
		description = "trinket_not_consume_grenade_tier1_description",
		display_name = "trinket_not_consume_grenade_tier1",
		unique_id = "trinket_not_consume_grenade",
		icon = "trinket_not_consume_grenade_tier1",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.2,
				name = "not_consume_grenade",
				stat_buff = StatBuffIndex.NOT_CONSUME_GRENADE
			}
		}
	},
	trinket_not_consume_grenade_tier2 = {
		description = "trinket_not_consume_grenade_tier2_description",
		display_name = "trinket_not_consume_grenade_tier2",
		unique_id = "trinket_not_consume_grenade",
		icon = "trinket_not_consume_grenade_tier2",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.3,
				name = "not_consume_grenade",
				stat_buff = StatBuffIndex.NOT_CONSUME_GRENADE
			}
		}
	},
	trinket_not_consume_grenade_tier3 = {
		description = "trinket_not_consume_grenade_tier3_description",
		display_name = "trinket_not_consume_grenade_tier3",
		unique_id = "trinket_not_consume_grenade",
		icon = "trinket_not_consume_grenade_tier3",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.4,
				name = "not_consume_grenade",
				stat_buff = StatBuffIndex.NOT_CONSUME_GRENADE
			}
		}
	},
	trinket_heal_self_on_heal_other_tier1 = {
		description = "trinket_heal_self_on_heal_other_tier1_description",
		display_name = "trinket_heal_self_on_heal_other_tier1",
		unique_id = "trinket_heal_self_on_heal_other",
		icon = "trinket_heal_self_on_heal_other_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "heal_self_on_heal_other",
				stat_buff = StatBuffIndex.HEAL_SELF_ON_HEAL_OTHER
			}
		}
	},
	trinket_heal_self_on_heal_other_tier2 = {
		description = "trinket_heal_self_on_heal_other_tier2_description",
		display_name = "trinket_heal_self_on_heal_other_tier2",
		unique_id = "trinket_heal_self_on_heal_other",
		icon = "trinket_heal_self_on_heal_other_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.6,
				name = "heal_self_on_heal_other",
				stat_buff = StatBuffIndex.HEAL_SELF_ON_HEAL_OTHER
			}
		}
	},
	trinket_heal_self_on_heal_other_tier3 = {
		description = "trinket_heal_self_on_heal_other_tier3_description",
		display_name = "trinket_heal_self_on_heal_other_tier3",
		unique_id = "trinket_heal_self_on_heal_other",
		icon = "trinket_heal_self_on_heal_other_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.8,
				name = "heal_self_on_heal_other",
				stat_buff = StatBuffIndex.HEAL_SELF_ON_HEAL_OTHER
			}
		}
	},
	trinket_no_interruption_revive = {
		description = "trinket_no_interruption_revive_description",
		display_name = "trinket_no_interruption_revive",
		unique_id = "trinket_no_interruption_revive",
		icon = "trinket_no_interruption_revive_tier1",
		buffs = {
			{
				name = "no_interruption_revive"
			}
		}
	},
	trinket_no_interruption_bandage = {
		description = "trinket_no_interruption_bandage_description",
		display_name = "trinket_no_interruption_bandage",
		unique_id = "trinket_no_interruption_bandage",
		icon = "trinket_no_interruption_bandage_tier1",
		buffs = {
			{
				name = "no_interruption_bandage"
			}
		}
	},
	trinket_protection_poison_wind_tier1 = {
		description = "trinket_protection_poison_wind_tier1_description",
		display_name = "trinket_protection_poison_wind_tier1",
		unique_id = "trinket_protection_poison_wind",
		icon = "trinket_protection_poison_wind_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.2,
				name = "protection_poison_wind",
				stat_buff = StatBuffIndex.PROTECTION_POISON_WIND
			}
		}
	},
	trinket_protection_poison_wind_tier2 = {
		description = "trinket_protection_poison_wind_tier2_description",
		display_name = "trinket_protection_poison_wind_tier2",
		unique_id = "trinket_protection_poison_wind",
		icon = "trinket_protection_poison_wind_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.4,
				name = "protection_poison_wind",
				stat_buff = StatBuffIndex.PROTECTION_POISON_WIND
			}
		}
	},
	trinket_protection_poison_wind_tier3 = {
		description = "trinket_protection_poison_wind_tier3_description",
		display_name = "trinket_protection_poison_wind_tier3",
		unique_id = "trinket_protection_poison_wind",
		icon = "trinket_protection_poison_wind_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.6,
				name = "protection_poison_wind",
				stat_buff = StatBuffIndex.PROTECTION_POISON_WIND
			}
		}
	},
	trinket_protection_gutter_runner_tier1 = {
		description = "trinket_protection_gutter_runner_tier1_description",
		display_name = "trinket_protection_gutter_runner_tier1",
		unique_id = "trinket_protection_gutter_runner",
		icon = "trinket_protection_gutter_runner_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.4,
				name = "protection_gutter_runner",
				stat_buff = StatBuffIndex.PROTECTION_GUTTER_RUNNER
			}
		}
	},
	trinket_protection_gutter_runner_tier2 = {
		description = "trinket_protection_gutter_runner_tier2_description",
		display_name = "trinket_protection_gutter_runner_tier2",
		unique_id = "trinket_protection_gutter_runner",
		icon = "trinket_protection_gutter_runner_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.6,
				name = "protection_gutter_runner",
				stat_buff = StatBuffIndex.PROTECTION_GUTTER_RUNNER
			}
		}
	},
	trinket_protection_gutter_runner_tier3 = {
		description = "trinket_protection_gutter_runner_tier3_description",
		display_name = "trinket_protection_gutter_runner_tier3",
		unique_id = "trinket_protection_gutter_runner",
		icon = "trinket_protection_gutter_runner_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.8,
				name = "protection_gutter_runner",
				stat_buff = StatBuffIndex.PROTECTION_GUTTER_RUNNER
			}
		}
	},
	trinket_protection_ratling_gunner_tier1 = {
		description = "trinket_protection_ratling_gunner_tier1_description",
		display_name = "trinket_protection_ratling_gunner_tier1",
		unique_id = "trinket_protection_ratling_gunner",
		icon = "trinket_protection_ratling_gunner_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.4,
				name = "protection_ratling_gunner",
				stat_buff = StatBuffIndex.PROTECTION_RATLING_GUNNER
			}
		}
	},
	trinket_protection_ratling_gunner_tier2 = {
		description = "trinket_protection_ratling_gunner_tier2_description",
		display_name = "trinket_protection_ratling_gunner_tier2",
		unique_id = "trinket_protection_ratling_gunner",
		icon = "trinket_protection_ratling_gunner_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.6,
				name = "protection_ratling_gunner",
				stat_buff = StatBuffIndex.PROTECTION_RATLING_GUNNER
			}
		}
	},
	trinket_protection_ratling_gunner_tier3 = {
		description = "trinket_protection_ratling_gunner_tier3_description",
		display_name = "trinket_protection_ratling_gunner_tier3",
		unique_id = "trinket_protection_ratling_gunner",
		icon = "trinket_protection_ratling_gunner_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.8,
				name = "protection_ratling_gunner",
				stat_buff = StatBuffIndex.PROTECTION_RATLING_GUNNER
			}
		}
	},
	trinket_protection_pack_master_tier1 = {
		description = "trinket_protection_pack_master_tier1_description",
		display_name = "trinket_protection_pack_master_tier1",
		unique_id = "trinket_protection_pack_master",
		icon = "trinket_protection_pack_master_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.4,
				name = "protection_pack_master",
				stat_buff = StatBuffIndex.PROTECTION_PACK_MASTER
			}
		}
	},
	trinket_protection_pack_master_tier2 = {
		description = "trinket_protection_pack_master_tier2_description",
		display_name = "trinket_protection_pack_master_tier2",
		unique_id = "trinket_protection_pack_master",
		icon = "trinket_protection_pack_master_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.6,
				name = "protection_pack_master",
				stat_buff = StatBuffIndex.PROTECTION_PACK_MASTER
			}
		}
	},
	trinket_protection_pack_master_tier3 = {
		description = "trinket_protection_pack_master_tier3_description",
		display_name = "trinket_protection_pack_master_tier3",
		unique_id = "trinket_protection_pack_master",
		icon = "trinket_protection_pack_master_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.8,
				name = "protection_pack_master",
				stat_buff = StatBuffIndex.PROTECTION_PACK_MASTER
			}
		}
	},
	trinket_potion_spread_area_tier1 = {
		description = "trinket_potion_spread_area_tier1_description",
		display_name = "trinket_potion_spread_area_tier1",
		unique_id = "trinket_potion_spread_area",
		icon = "trinket_potion_spread_area_tier1",
		description_values = {
			"distance"
		},
		buffs = {
			{
				name = "potion_spread_area_tier1",
				distance = TrinketSpreadDistance
			}
		}
	},
	trinket_potion_spread_area_tier2 = {
		description = "trinket_potion_spread_area_tier2_description",
		display_name = "trinket_potion_spread_area_tier2",
		unique_id = "trinket_potion_spread_area",
		icon = "trinket_potion_spread_area_tier2",
		description_values = {
			"distance"
		},
		buffs = {
			{
				name = "potion_spread_area_tier2",
				distance = TrinketSpreadDistance
			}
		}
	},
	trinket_potion_spread_area_tier3 = {
		description = "trinket_potion_spread_area_tier3_description",
		display_name = "trinket_potion_spread_area_tier3",
		unique_id = "trinket_potion_spread_area",
		icon = "trinket_potion_spread_area_tier3",
		description_values = {
			"distance"
		},
		buffs = {
			{
				name = "potion_spread_area_tier3",
				distance = TrinketSpreadDistance
			}
		}
	},
	trinket_medpack_spread_area_tier1 = {
		description = "trinket_medpack_spread_area_tier1_description",
		display_name = "trinket_medpack_spread_area_tier1",
		unique_id = "trinket_medpack_spread_area",
		icon = "trinket_medpack_spread_area_tier1",
		description_values = {
			"distance",
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.1,
				name = "medpack_spread_area",
				stat_buff = StatBuffIndex.MEDPACK_SPREAD_AREA,
				distance = TrinketSpreadDistance
			}
		}
	},
	trinket_medpack_spread_area_tier2 = {
		description = "trinket_medpack_spread_area_tier2_description",
		display_name = "trinket_medpack_spread_area_tier2",
		unique_id = "trinket_medpack_spread_area",
		icon = "trinket_medpack_spread_area_tier2",
		description_values = {
			"distance",
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.15,
				name = "medpack_spread_area",
				stat_buff = StatBuffIndex.MEDPACK_SPREAD_AREA,
				distance = TrinketSpreadDistance
			}
		}
	},
	trinket_medpack_spread_area_tier3 = {
		description = "trinket_medpack_spread_area_tier3_description",
		display_name = "trinket_medpack_spread_area_tier3",
		unique_id = "trinket_medpack_spread_area",
		icon = "trinket_medpack_spread_area_tier3",
		description_values = {
			"distance",
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.2,
				name = "medpack_spread_area",
				stat_buff = StatBuffIndex.MEDPACK_SPREAD_AREA,
				distance = TrinketSpreadDistance
			}
		}
	},
	trinket_faster_revive_promo = {
		description = "trinket_faster_revive_tier1_description",
		display_name = "trinket_faster_revive_tier1",
		unique_id = "trinket_faster_revive",
		icon = "trinket_faster_revive_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.15,
				name = "faster_revive",
				stat_buff = StatBuffIndex.FASTER_REVIVE
			}
		}
	},
	trinket_faster_revive_tier1 = {
		description = "trinket_faster_revive_tier1_description",
		display_name = "trinket_faster_revive_tier1",
		unique_id = "trinket_faster_revive",
		icon = "trinket_faster_revive_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.3,
				name = "faster_revive",
				stat_buff = StatBuffIndex.FASTER_REVIVE
			}
		}
	},
	trinket_faster_revive_tier2 = {
		description = "trinket_faster_revive_tier2_description",
		display_name = "trinket_faster_revive_tier2",
		unique_id = "trinket_faster_revive",
		icon = "trinket_faster_revive_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.4,
				name = "faster_revive",
				stat_buff = StatBuffIndex.FASTER_REVIVE
			}
		}
	},
	trinket_faster_revive_tier3 = {
		description = "trinket_faster_revive_tier3_description",
		display_name = "trinket_faster_revive_tier3",
		unique_id = "trinket_faster_revive",
		icon = "trinket_faster_revive_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.5,
				name = "faster_revive",
				stat_buff = StatBuffIndex.FASTER_REVIVE
			}
		}
	},
	trinket_increase_luck_promo = {
		description = "trinket_increase_luck_tier1_description",
		display_name = "trinket_increase_luck_tier1",
		unique_id = "trinket_increase_luck",
		icon = "trinket_increase_luck_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.1,
				name = "increase_luck",
				stat_buff = StatBuffIndex.INCREASE_LUCK
			}
		}
	},
	trinket_increase_luck_tier1 = {
		description = "trinket_increase_luck_tier1_description",
		display_name = "trinket_increase_luck_tier1",
		unique_id = "trinket_increase_luck",
		icon = "trinket_increase_luck_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.25,
				name = "increase_luck",
				stat_buff = StatBuffIndex.INCREASE_LUCK
			}
		}
	},
	trinket_increase_luck_tier2 = {
		description = "trinket_increase_luck_tier2_description",
		display_name = "trinket_increase_luck_tier2",
		unique_id = "trinket_increase_luck",
		icon = "trinket_increase_luck_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.5,
				name = "increase_luck",
				stat_buff = StatBuffIndex.INCREASE_LUCK
			}
		}
	},
	trinket_increase_luck_tier3 = {
		description = "trinket_increase_luck_tier3_description",
		display_name = "trinket_increase_luck_tier3",
		unique_id = "trinket_increase_luck",
		icon = "trinket_increase_luck_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 1,
				name = "increase_luck",
				stat_buff = StatBuffIndex.INCREASE_LUCK
			}
		}
	},
	trinket_hp_increase_kd_tier1 = {
		description = "trinket_hp_increase_kd_tier1_description",
		display_name = "trinket_hp_increase_kd_tier1",
		unique_id = "trinket_hp_increase_kd",
		icon = "trinket_hp_increase_kd_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.25,
				name = "hp_increase_kd",
				stat_buff = StatBuffIndex.DAMAGE_TAKEN_KD
			}
		}
	},
	trinket_hp_increase_kd_tier2 = {
		description = "trinket_hp_increase_kd_tier2_description",
		display_name = "trinket_hp_increase_kd_tier2",
		unique_id = "trinket_hp_increase_kd",
		icon = "trinket_hp_increase_kd_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.5,
				name = "hp_increase_kd",
				stat_buff = StatBuffIndex.DAMAGE_TAKEN_KD
			}
		}
	},
	trinket_hp_increase_kd_tier3 = {
		description = "trinket_hp_increase_kd_tier3_description",
		display_name = "trinket_hp_increase_kd_tier3",
		unique_id = "trinket_hp_increase_kd",
		icon = "trinket_hp_increase_kd_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.75,
				name = "hp_increase_kd",
				stat_buff = StatBuffIndex.DAMAGE_TAKEN_KD
			}
		}
	},
	trinket_poison_attack_promo = {
		description = "trinket_poison_attack_tier1_description",
		display_name = "trinket_poison_attack_tier1",
		unique_id = "trinket_poison_attack",
		icon = "trinket_poison_attack_tier1",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.01,
				name = "poison_attack",
				stat_buff = StatBuffIndex.POISON_PROC
			}
		}
	},
	trinket_poison_attack_tier1 = {
		description = "trinket_poison_attack_tier1_description",
		display_name = "trinket_poison_attack_tier1",
		unique_id = "trinket_poison_attack",
		icon = "trinket_poison_attack_tier1",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.04,
				name = "poison_attack",
				stat_buff = StatBuffIndex.POISON_PROC
			}
		}
	},
	trinket_poison_attack_tier2 = {
		description = "trinket_poison_attack_tier2_description",
		display_name = "trinket_poison_attack_tier2",
		unique_id = "trinket_poison_attack",
		icon = "trinket_poison_attack_tier2",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.08,
				name = "poison_attack",
				stat_buff = StatBuffIndex.POISON_PROC
			}
		}
	},
	trinket_poison_attack_tier3 = {
		description = "trinket_poison_attack_tier3_description",
		display_name = "trinket_poison_attack_tier3",
		unique_id = "trinket_poison_attack",
		icon = "trinket_poison_attack_tier3",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.12,
				name = "poison_attack",
				stat_buff = StatBuffIndex.POISON_PROC
			}
		}
	},
	trinket_increased_movement_speed_tier1 = {
		description = "trinket_increased_movement_speed_tier1_description",
		display_name = "trinket_increased_movement_speed_tier1",
		unique_id = "trinket_increased_movement_speed",
		icon = "trinket_increased_movement_speed_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				name = "movement_speed",
				multiplier = 1.04,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			}
		}
	},
	trinket_increased_movement_speed_tier2 = {
		description = "trinket_increased_movement_speed_tier2_description",
		display_name = "trinket_increased_movement_speed_tier2",
		unique_id = "trinket_increased_movement_speed",
		icon = "trinket_increased_movement_speed_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				name = "movement_speed",
				multiplier = 1.08,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			}
		}
	},
	trinket_increased_movement_speed_tier3 = {
		description = "trinket_increased_movement_speed_tier3_description",
		display_name = "trinket_increased_movement_speed_tier3",
		unique_id = "trinket_increased_movement_speed",
		icon = "trinket_increased_movement_speed_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				name = "movement_speed",
				multiplier = 1.12,
				remove_buff_func = "remove_movement_buff",
				apply_buff_func = "apply_movement_buff",
				path_to_movement_setting_to_modify = {
					"move_speed"
				}
			}
		}
	},
	trinket_reduce_grimoire_penalty = {
		description = "trinket_reduce_grimoire_penalty_description",
		display_name = "trinket_reduce_grimoire_penalty",
		unique_id = "trinket_reduce_grimoire_penalty",
		icon = "trinket_reduce_grimoire_penalty_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.33,
				name = "curse_protection",
				remove_buff_func = "remove_curse_protection",
				apply_buff_func = "apply_curse_protection",
				stat_buff = StatBuffIndex.CURSE_PROTECTION
			}
		}
	},
	trinket_reduce_grimoire_penalty_spring = {
		description = "trinket_reduce_grimoire_penalty_description",
		display_name = "trinket_reduce_grimoire_penalty",
		unique_id = "trinket_reduce_grimoire_penalty",
		icon = "trinket_reduce_grimoire_penalty_spring_01",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.25,
				name = "curse_protection",
				remove_buff_func = "remove_curse_protection",
				apply_buff_func = "apply_curse_protection",
				stat_buff = StatBuffIndex.CURSE_PROTECTION
			}
		}
	},
	trinket_grenade_radius_tier1 = {
		description = "trinket_grenade_radius_tier1_description",
		display_name = "trinket_grenade_radius_tier1",
		unique_id = "trinket_grenade_radius",
		icon = "trinket_grenade_radius_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.4,
				name = "grenade_radius",
				stat_buff = StatBuffIndex.GRENADE_RADIUS
			}
		}
	},
	trinket_grenade_radius_tier2 = {
		description = "trinket_grenade_radius_tier2_description",
		display_name = "trinket_grenade_radius_tier2",
		unique_id = "trinket_grenade_radius",
		icon = "trinket_grenade_radius_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.5,
				name = "grenade_radius",
				stat_buff = StatBuffIndex.GRENADE_RADIUS
			}
		}
	},
	trinket_grenade_radius_tier3 = {
		description = "trinket_grenade_radius_tier3_description",
		display_name = "trinket_grenade_radius_tier3",
		unique_id = "trinket_grenade_radius",
		icon = "trinket_grenade_radius_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.6,
				name = "grenade_radius",
				stat_buff = StatBuffIndex.GRENADE_RADIUS
			}
		}
	},
	trinket_faster_respawn_tier1 = {
		description = "trinket_faster_respawn_tier1_description",
		display_name = "trinket_faster_respawn_tier1",
		unique_id = "trinket_faster_respawn",
		icon = "trinket_faster_respawn_tier1",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.25,
				name = "faster_respawn",
				stat_buff = StatBuffIndex.FASTER_RESPAWN
			}
		}
	},
	trinket_faster_respawn_tier2 = {
		description = "trinket_faster_respawn_tier2_description",
		display_name = "trinket_faster_respawn_tier2",
		unique_id = "trinket_faster_respawn",
		icon = "trinket_faster_respawn_tier2",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.5,
				name = "faster_respawn",
				stat_buff = StatBuffIndex.FASTER_RESPAWN
			}
		}
	},
	trinket_not_consume_pickup_tier1 = {
		description = "trinket_not_consume_pickup_tier1_description",
		display_name = "trinket_not_consume_pickup_tier1",
		unique_id = "trinket_not_consume_pickup",
		icon = "trinket_not_consume_pickup_tier1",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.04,
				name = "not_consume_pickup",
				stat_buff = StatBuffIndex.NOT_CONSUME_PICKUP
			}
		}
	},
	trinket_not_consume_pickup_tier2 = {
		description = "trinket_not_consume_pickup_tier2_description",
		display_name = "trinket_not_consume_pickup_tier2",
		unique_id = "trinket_not_consume_pickup",
		icon = "trinket_not_consume_pickup_tier2",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.08,
				name = "not_consume_pickup",
				stat_buff = StatBuffIndex.NOT_CONSUME_PICKUP
			}
		}
	},
	trinket_not_consume_pickup_tier3 = {
		description = "trinket_not_consume_pickup_tier3_description",
		display_name = "trinket_not_consume_pickup_tier3",
		unique_id = "trinket_not_consume_pickup",
		icon = "trinket_not_consume_pickup_tier3",
		description_values = {
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.12,
				name = "not_consume_pickup",
				stat_buff = StatBuffIndex.NOT_CONSUME_PICKUP
			}
		}
	},
	trinket_shared_damage = {
		description = "trinket_shared_damage_description",
		display_name = "trinket_shared_damage",
		unique_id = "trinket_shared_damage",
		icon = "trinket_shared_damage_tier3",
		buffs = {
			{
				name = "shared_health_pool"
			}
		}
	},
	trinket_roll_dice_as_witch_hunter = {
		description = "dlc1_1_trinket_roll_dice_as_witch_hunter_description",
		display_name = "dlc1_1_trinket_roll_dice_as_witch_hunter",
		unique_id = "trinket_roll_dice_as_hero",
		icon = "trait_icon_loot_trinket_witch_hunter",
		roll_dice_as_hero = "witch_hunter",
		buffs = {}
	},
	trinket_roll_dice_as_bright_wizard = {
		description = "dlc1_1_trinket_roll_dice_as_bright_wizard_description",
		display_name = "dlc1_1_trinket_roll_dice_as_bright_wizard",
		unique_id = "trinket_roll_dice_as_hero",
		icon = "trait_icon_loot_trinket_bright_wizard",
		roll_dice_as_hero = "bright_wizard",
		buffs = {}
	},
	trinket_roll_dice_as_dwarf_ranger = {
		description = "dlc1_1_trinket_roll_dice_as_dwarf_ranger_description",
		display_name = "dlc1_1_trinket_roll_dice_as_dwarf_ranger",
		unique_id = "trinket_roll_dice_as_hero",
		icon = "trait_icon_loot_trinket_dwarf_ranger",
		roll_dice_as_hero = "dwarf_ranger",
		buffs = {}
	},
	trinket_roll_dice_as_wood_elf = {
		description = "dlc1_1_trinket_roll_dice_as_wood_elf_description",
		display_name = "dlc1_1_trinket_roll_dice_as_wood_elf",
		unique_id = "trinket_roll_dice_as_hero",
		icon = "trait_icon_loot_trinket_waywatcher",
		roll_dice_as_hero = "wood_elf",
		buffs = {}
	},
	trinket_roll_dice_as_empire_soldier = {
		description = "dlc1_1_trinket_roll_dice_as_empire_soldier_description",
		display_name = "dlc1_1_trinket_roll_dice_as_empire_soldier",
		unique_id = "trinket_roll_dice_as_hero",
		icon = "trait_icon_loot_trinket_empire_soldier",
		roll_dice_as_hero = "empire_soldier",
		buffs = {}
	},
	trinket_increase_luck_halloween = {
		description = "trinket_increase_luck_tier1_description",
		display_name = "trinket_increase_luck_tier1",
		unique_id = "trinket_increase_luck",
		icon = "trinket_increase_luck_halloween",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.91,
				name = "increase_luck",
				stat_buff = StatBuffIndex.INCREASE_LUCK
			}
		}
	},
	trinket_medpack_spread_halloween = {
		description = "trinket_medpack_spread_area_tier2_description",
		display_name = "trinket_medpack_spread_area_tier2",
		unique_id = "trinket_medpack_spread_area",
		icon = "trinket_garlic_tier1",
		description_values = {
			"distance",
			"multiplier"
		},
		buffs = {
			{
				multiplier = 0.13,
				name = "medpack_spread_area",
				stat_buff = StatBuffIndex.MEDPACK_SPREAD_AREA,
				distance = TrinketSpreadDistance
			}
		}
	},
	trinket_heal_on_kill_skulls = {
		description = "trinket_heal_on_kill_skulls_description",
		display_name = "trinket_heal_on_kill_skulls",
		unique_id = "trinket_heal_on_kill",
		icon = "trait_icon_bloodlust",
		description_values = {
			"proc_chance",
			"bonus"
		},
		buffs = {
			{
				proc_chance = 0.13,
				name = "heal_on_kill",
				bonus = 3,
				stat_buff = StatBuffIndex.HEAL_ON_KILL
			}
		}
	},
	trinket_faster_respawn_skulls = {
		description = "trinket_faster_respawn_tier1_description",
		display_name = "trinket_faster_respawn_tier1",
		unique_id = "trinket_faster_respawn",
		icon = "trinket_faster_respawn_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.75,
				name = "faster_respawn",
				stat_buff = StatBuffIndex.FASTER_RESPAWN
			}
		}
	},
	trinket_scavenger_skulls = {
		description = "trinket_scavenger_skulls_description",
		display_name = "trinket_scavenger_skulls",
		unique_id = "trinket_scavenger",
		icon = "trait_icon_trinket_scavenger_skulls",
		description_values = {
			"proc_chance",
			"proc_chance"
		},
		buffs = {
			{
				proc_chance = 0.13,
				name = "ammo_on_kill",
				bonus = 0.05,
				stat_buff = StatBuffIndex.AMMO_ON_KILL
			},
			{
				multiplier = -0.13,
				name = "reduced_overcharge",
				stat_buff = StatBuffIndex.REDUCED_OVERCHARGE
			}
		}
	},
	trinket_protection_poison_wind_skulls = {
		description = "trinket_protection_poison_wind_tier3_description",
		display_name = "trinket_protection_poison_wind_tier3",
		unique_id = "trinket_protection_poison_wind",
		icon = "trinket_protection_poison_wind_tier3",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = -0.6,
				name = "protection_poison_wind",
				stat_buff = StatBuffIndex.PROTECTION_POISON_WIND
			}
		}
	},
	trinket_increased_damage_hard_mode_achievements = {
		description = "trinket_increased_damage_hard_mode_achievements_description",
		display_name = "trinket_increased_damage_hard_mode_achievements",
		unique_id = "trinket_increased_damage_taken",
		icon = "trait_icon_trinket_increased_damage_hard_mode_achievements",
		description_values = {
			"multiplier"
		},
		buffs = {
			{
				multiplier = 1,
				name = "damage_taken",
				stat_buff = StatBuffIndex.DAMAGE_TAKEN
			}
		}
	},
	trinket_potion_spread_area_skulls = {
		description = "trinket_potion_spread_area_tier3_description",
		display_name = "trinket_potion_spread_area_tier3",
		unique_id = "trinket_potion_spread_area",
		icon = "trinket_potion_spread_area_tier3",
		description_values = {
			"distance"
		},
		buffs = {
			{
				name = "potion_spread_area_tier3",
				distance = TrinketSpreadDistance
			}
		}
	}
}
local override_descriptions = {
	proc_chance = true
}

for buff_name, buff_template in pairs(BuffTemplates) do
	if buff_template then
		local description_values = buff_template.description_values

		if description_values then
			for i = 1, #description_values, 1 do
				local buff = buff_template.buffs[1]
				local key = description_values[i]
				local value = buff[key]
				local melee_weapon = string.find(buff_name, "melee_weapon_")
				local ranged_weapon = string.find(buff_name, "ranged_weapon_")

				if override_descriptions[key] and (melee_weapon or ranged_weapon) then
					description_values[i] = key
				elseif value then
					if key == "multiplier" or key == "proc_chance" then
						if key == "multiplier" and not buff.stat_buff then
							value = value - 1
						end

						value = math.abs(value*100)
					elseif key == "bonus" and value < 0 then
						value = value*-1
					end

					description_values[i] = value
				else
					local proc_key = buff.proc

					assert(proc_key, "There is no buff value by name: %s on buff: %s", key, buff_name)

					local proc_value = BuffTemplates[proc_key].buffs[1][key]

					assert(proc_value, "There is no buff value by name: %s on buff %s for proc buff: %s.", key, buff_name, proc_key)

					description_values[i] = proc_value
				end
			end
		end
	end
end

return 
