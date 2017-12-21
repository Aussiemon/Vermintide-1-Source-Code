local push_radius = 2.5
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_ramp_decay_delay = 0.1,
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.4,
			uninterruptible = true,
			anim_event = "attack_swing_charge",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_left",
					start_time = 0,
					action = "action_one",
					end_time = 0.3,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.45,
					action = "action_one",
					input = "action_one_release"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield"
				},
				{
					start_time = 0.5,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.7,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_right = {
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_ramp_decay_delay = 0.1,
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.4,
			uninterruptible = true,
			anim_event = "attack_swing_charge_right",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_last",
					start_time = 0,
					action = "action_one",
					end_time = 0.3,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_right",
					start_time = 0.45,
					action = "action_one",
					input = "action_one_release"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield"
				},
				{
					start_time = 0.5,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_right",
					start_time = 0.7,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_left = {
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_ramp_decay_delay = 0.1,
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.4,
			uninterruptible = true,
			anim_event = "attack_swing_charge_left",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.3,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_right",
					start_time = 0,
					action = "action_one",
					end_time = 0.3,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_left",
					start_time = 0.45,
					action = "action_one",
					input = "action_one_release"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield"
				},
				{
					start_time = 0.5,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_left",
					start_time = 0.7,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		heavy_attack = {
			damage_window_start = 0.2,
			push_radius = 2,
			anim_time_scale = 1.1,
			kind = "shield_slam",
			no_damage_impact_sound_event = "shield_hit_armour",
			attack_template = "blunt_fencer",
			push_attack_template = "shield_slam",
			armor_impact_sound_event = "shield_hit_armour",
			attack_template_damage_type = "one_h_tank_H_1",
			hit_time = 0.2,
			hit_effect = "melee_hit_axes_1h",
			weapon_action_hand = "left",
			aim_assist_ramp_multiplier = 0.2,
			damage_window_end = 0.25,
			impact_sound_event = "shield_hit",
			charge_value = "action_push",
			anim_end_event = "attack_finished",
			aim_assist_max_ramp_multiplier = 0.4,
			aim_assist_ramp_decay_delay = 0.1,
			dedicated_target_range = 2,
			uninterruptible = true,
			anim_event = "attack_swing_heavy",
			total_time = 1,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.1,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				return input_extension.reset_release_input(input_extension)
			end
		},
		heavy_attack_left = {
			damage_window_start = 0.2,
			push_radius = 2,
			anim_time_scale = 1.1,
			kind = "shield_slam",
			no_damage_impact_sound_event = "shield_hit_armour",
			attack_template = "blunt_fencer",
			push_attack_template = "shield_slam",
			armor_impact_sound_event = "shield_hit_armour",
			attack_template_damage_type = "one_h_tank_H_1",
			hit_time = 0.2,
			hit_effect = "melee_hit_axes_1h",
			weapon_action_hand = "left",
			aim_assist_ramp_multiplier = 0.2,
			damage_window_end = 0.25,
			impact_sound_event = "shield_hit",
			charge_value = "action_push",
			anim_end_event = "attack_finished",
			aim_assist_max_ramp_multiplier = 0.4,
			aim_assist_ramp_decay_delay = 0.2,
			dedicated_target_range = 2,
			uninterruptible = true,
			anim_event = "attack_swing_heavy_left",
			total_time = 1,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.1,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default_right",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				return input_extension.reset_release_input(input_extension)
			end
		},
		heavy_attack_right = {
			damage_window_start = 0.2,
			push_radius = 2,
			anim_time_scale = 1.1,
			kind = "shield_slam",
			no_damage_impact_sound_event = "shield_hit_armour",
			attack_template = "blunt_fencer",
			push_attack_template = "shield_slam",
			armor_impact_sound_event = "shield_hit_armour",
			attack_template_damage_type = "one_h_tank_H_1",
			hit_time = 0.2,
			hit_effect = "melee_hit_axes_1h",
			weapon_action_hand = "left",
			aim_assist_ramp_multiplier = 0.2,
			damage_window_end = 0.25,
			impact_sound_event = "shield_hit",
			charge_value = "action_push",
			anim_end_event = "attack_finished",
			aim_assist_max_ramp_multiplier = 0.4,
			aim_assist_ramp_decay_delay = 0.2,
			dedicated_target_range = 2,
			uninterruptible = true,
			anim_event = "attack_swing_heavy_right",
			total_time = 1,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.1,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				return input_extension.reset_release_input(input_extension)
			end
		},
		light_attack_left = {
			damage_window_start = 0.38,
			range_mod = 1,
			anim_time_scale = 1.15,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			max_targets = 1,
			use_target = false,
			hit_effect = "melee_hit_axes_1h",
			damage_window_end = 0.5,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 2.5,
			anim_event = "attack_swing_left_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					end_time = 0.3,
					buff_name = "planted_decrease_movement"
				},
				{
					start_time = 0.3,
					external_multiplier = 0.75,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.7,
					action = "action_one",
					end_time = 1.2,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.7,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_smiter_L",
				attack_template = "slashing_linesman_AP"
			},
			targets = {}
		},
		light_attack_right = {
			damage_window_start = 0.38,
			range_mod = 1,
			anim_time_scale = 1.2,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			max_targets = 1,
			use_target = false,
			hit_effect = "melee_hit_axes_1h",
			damage_window_end = 0.5,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 2.5,
			anim_event = "attack_swing_right_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					end_time = 0.3,
					buff_name = "planted_decrease_movement"
				},
				{
					start_time = 0.3,
					external_multiplier = 0.75,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.7,
					action = "action_one",
					end_time = 1.2,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.7,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_smiter_L",
				attack_template = "slashing_linesman_AP"
			},
			targets = {}
		},
		light_attack_last = {
			damage_window_start = 0.38,
			range_mod = 1,
			anim_time_scale = 1.3,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			max_targets = 1,
			use_target = true,
			hit_effect = "melee_hit_axes_1h",
			damage_window_end = 0.5,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 2.5,
			anim_event = "attack_swing_down",
			hit_stop_anim = "attack_hit",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.85,
					end_time = 0.35,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.35,
					external_multiplier = 0.3,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.9,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_smiter_L",
				attack_template = "slashing_smiter"
			},
			targets = {}
		},
		push = {
			damage_window_start = 0.05,
			anim_end_event = "attack_finished",
			anim_time_scale = 0.85,
			kind = "push_stagger",
			no_damage_impact_sound_event = "blunt_hit_armour",
			attack_template = "heavy_sweep_push",
			weapon_action_hand = "left",
			hit_effect = "melee_hit_axes_1h",
			damage_window_end = 0.2,
			impact_sound_event = "blunt_hit",
			charge_value = "action_push",
			anim_event = "attack_push",
			total_time = 0.8,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.8,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_wield",
					input = "action_wield"
				}
			},
			push_radius = push_radius,
			chain_condition_func = function (attacker_unit, input_extension)
				local status_extension = ScriptUnit.extension(attacker_unit, "status_system")

				return not status_extension.fatigued(status_extension)
			end
		}
	},
	action_two = {
		default = {
			cooldown = 0.15,
			minimum_hold_time = 0.3,
			anim_end_event = "parry_finished",
			kind = "block",
			weapon_action_hand = "left",
			hold_input = "action_two_hold",
			anim_event = "parry_pose",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			enter_function = function (attacker_unit, input_extension)
				return input_extension.reset_release_input(input_extension)
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.6,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "push",
					start_time = 0.3,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_wield",
					input = "action_wield"
				}
			}
		}
	},
	action_inspect = ActionTemplates.action_inspect,
	action_wield = ActionTemplates.wield,
	action_instant_grenade_throw = ActionTemplates.instant_equip_grenade,
	action_instant_heal_self = ActionTemplates.instant_equip_and_heal_self,
	action_instant_heal_other = ActionTemplates.instant_equip_and_heal_other,
	action_instant_drink_potion = ActionTemplates.instant_equip_and_drink_potion,
	action_instant_equip_tome = ActionTemplates.instant_equip_tome,
	action_instant_equip_grimoire = ActionTemplates.instant_equip_grimoire,
	action_instant_equip_grenade = ActionTemplates.instant_equip_grenade_only,
	action_instant_equip_healing_draught = ActionTemplates.instant_equip_and_drink_healing_draught
}
weapon_template.right_hand_unit = "units/weapons/player/wpn_empire_short_sword/wpn_empire_short_sword"
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.right
weapon_template.left_hand_unit = "units/weapons/player/wpn_empire_shield_01_t1/wpn_emp_shield_01_t1"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.left
weapon_template.display_unit = "units/weapons/weapon_display/display_shield"
weapon_template.wield_anim = "to_1h_axe_shield"
weapon_template.buff_type = BuffTypes.MELEE
weapon_template.max_fatigue_points = 10
weapon_template.dodge_distance = 0.85
weapon_template.dodge_speed = 0.85
weapon_template.dodge_count = 1
weapon_template.can_block_ranged_attacks = true
weapon_template.attack_meta_data = {
	tap_attack = {
		penetrating = true,
		arc = 1
	},
	hold_attack = {
		penetrating = true,
		arc = 0
	}
}
weapon_template.aim_assist_settings = {
	max_range = 5,
	no_aim_input_multiplier = 0,
	base_multiplier = 0,
	effective_max_range = 4,
	breed_scalars = {
		skaven_storm_vermin = 1,
		skaven_clan_rat = 1,
		skaven_slave = 1
	}
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.6,
			stagger = 0.2,
			damage = 0.375,
			targets = 0.2
		},
		heavy_attack = {
			speed = 0.4,
			stagger = 0.8,
			damage = 0.3125,
			targets = 1
		}
	},
	perks = {
		light_attack = {
			"armor_penetration"
		},
		heavy_attack = {
			"armor_penetration"
		}
	}
}
weapon_template.wwise_dep = {
	"wwise/one_handed_swords"
}
Weapons = Weapons or {}
Weapons.one_hand_axe_shield_template_1 = table.clone(weapon_template)
Weapons.one_hand_axe_shield_template_1_co = table.clone(weapon_template)
Weapons.one_hand_axe_shield_template_1_co.compare_statistics.attacks.light_attack.damage = 0.4125
Weapons.one_hand_axe_shield_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.34375
Weapons.one_hand_axe_shield_template_1_t2 = table.clone(weapon_template)
Weapons.one_hand_axe_shield_template_1_t2.actions.action_one.heavy_attack.attack_template_damage_type = "one_h_tank_H_1_t2"
Weapons.one_hand_axe_shield_template_1_t2.actions.action_one.heavy_attack_left.attack_template_damage_type = "one_h_tank_H_1_t2"
Weapons.one_hand_axe_shield_template_1_t2.actions.action_one.heavy_attack_right.attack_template_damage_type = "one_h_tank_H_1_t2"
Weapons.one_hand_axe_shield_template_1_t2.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_smiter_L_t2"
Weapons.one_hand_axe_shield_template_1_t2.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_smiter_L_t2"
Weapons.one_hand_axe_shield_template_1_t2.actions.action_one.light_attack_last.default_target.attack_template_damage_type = "one_h_smiter_L_t2"
Weapons.one_hand_axe_shield_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.5
Weapons.one_hand_axe_shield_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.375
Weapons.one_hand_axe_shield_template_1_t3 = table.clone(weapon_template)
Weapons.one_hand_axe_shield_template_1_t3.actions.action_one.heavy_attack.attack_template_damage_type = "one_h_tank_H_1_t3"
Weapons.one_hand_axe_shield_template_1_t3.actions.action_one.heavy_attack_left.attack_template_damage_type = "one_h_tank_H_1_t3"
Weapons.one_hand_axe_shield_template_1_t3.actions.action_one.heavy_attack_right.attack_template_damage_type = "one_h_tank_H_1_t3"
Weapons.one_hand_axe_shield_template_1_t3.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_smiter_L_t3"
Weapons.one_hand_axe_shield_template_1_t3.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_smiter_L_t3"
Weapons.one_hand_axe_shield_template_1_t3.actions.action_one.light_attack_last.default_target.attack_template_damage_type = "one_h_smiter_L_t3"
Weapons.one_hand_axe_shield_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.625
Weapons.one_hand_axe_shield_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.4375

return 
