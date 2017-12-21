local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			aim_assist_ramp_decay_delay = 0.1,
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.3,
			aim_assist_ramp_multiplier = 0.1,
			anim_event = "attack_swing_charge_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.65,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_left",
					start_time = 0,
					action = "action_one",
					end_time = 0.31,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.8,
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
					start_time = 0.3,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.6,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_right = {
			aim_assist_ramp_decay_delay = 0.1,
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.3,
			aim_assist_ramp_multiplier = 0.1,
			anim_event = "attack_swing_charge_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.65,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_right",
					start_time = 0,
					action = "action_one",
					end_time = 0.31,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.8,
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
					start_time = 0.3,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.6,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_left = {
			aim_assist_max_ramp_multiplier = 0.3,
			aim_assist_ramp_multiplier = 0.1,
			anim_event = "attack_swing_charge_down",
			kind = "dummy",
			aim_assist_ramp_decay_delay = 0.1,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.65,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_last",
					start_time = 0,
					action = "action_one",
					end_time = 0.31,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.8,
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
					start_time = 0.3,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.6,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		heavy_attack = {
			damage_window_start = 0.15,
			range_mod = 1.15,
			anim_time_scale = 1.1,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			use_target = true,
			max_targets = 1,
			aim_assist_max_ramp_multiplier = 0.6,
			hit_effect = "melee_hit_sword_1h",
			aim_assist_ramp_decay_delay = 0.1,
			reset_aim_on_attack = true,
			damage_window_end = 0.3,
			impact_sound_event = "slashing_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			aim_assist_ramp_multiplier = 0.5,
			anim_event = "attack_swing_heavy_down",
			hit_stop_anim = "attack_hit",
			total_time = 1.2,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1,
					end_time = 0.2,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.5,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default_right",
					start_time = 0.5,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.3,
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
			enter_function = function (attacker_unit, input_extension)
				return input_extension.reset_release_input(input_extension)
			end,
			default_target = {
				attack_template_damage_type = "one_h_smiter_H",
				attack_template = "slashing_smiter"
			},
			targets = {}
		},
		light_attack_left = {
			damage_window_start = 0.38,
			total_time = 1.6,
			anim_end_event = "attack_finished",
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			anim_time_scale = 1.25,
			max_targets = 4,
			hit_effect = "melee_hit_sword_1h",
			damage_window_end = 0.52,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			no_damage_impact_sound_event = "slashing_hit_armour",
			dedicated_target_range = 2.5,
			anim_event = "attack_swing_left_diagonal",
			range_mod = 1.15,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.7,
					end_time = 0.5,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.4,
					action = "action_one",
					end_time = 1.2,
					input = "action_one"
				},
				{
					sub_action = "default_right",
					start_time = 0.55,
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
					start_time = 0.4,
					action = "action_wield",
					input = "action_wield"
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_linesman_L",
				attack_template = "light_slashing_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_linesman_L_1",
					attack_template = "light_slashing_linesman"
				}
			}
		},
		light_attack_right = {
			damage_window_start = 0.38,
			total_time = 1.6,
			anim_end_event = "attack_finished",
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			anim_time_scale = 1.25,
			max_targets = 4,
			hit_effect = "melee_hit_sword_1h",
			damage_window_end = 0.52,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			no_damage_impact_sound_event = "slashing_hit_armour",
			dedicated_target_range = 2.5,
			anim_event = "attack_swing_right_diagonal",
			range_mod = 1.15,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.7,
					end_time = 0.5,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.5,
					action = "action_one",
					end_time = 1.2,
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 0.5,
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
				attack_template_damage_type = "one_h_linesman_L",
				attack_template = "light_slashing_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_linesman_L_1",
					attack_template = "light_slashing_linesman"
				}
			}
		},
		light_attack_last = {
			damage_window_start = 0.3,
			anim_time_scale = 1.35,
			no_damage_impact_sound_event = "stab_hit_armour",
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			max_targets = 1,
			aim_assist_max_ramp_multiplier = 0.8,
			width_mod = 25,
			aim_assist_ramp_decay_delay = 0.1,
			reset_aim_on_attack = true,
			hit_effect = "melee_hit_sword_1h",
			damage_window_end = 0.5,
			impact_sound_event = "stab_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 2.5,
			aim_assist_ramp_multiplier = 0.6,
			anim_event = "push_stab",
			range_mot = 1.15,
			total_time = 1.6,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.7,
					end_time = 0.1,
					buff_name = "planted_decrease_movement"
				},
				{
					start_time = 0.1,
					external_multiplier = 1.35,
					end_time = 0.4,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.65,
					action = "action_one",
					end_time = 1.2,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.65,
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
				attack_template = "stab_fencer"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_smiter_L",
					attack_template = "stab_fencer"
				}
			}
		},
		push = {
			damage_window_start = 0.05,
			anim_end_event = "attack_finished",
			kind = "push_stagger",
			no_damage_impact_sound_event = "slashing_hit_armour",
			attack_template_damage_type = "one_h_linesman_L",
			attack_template = "weak_sweep_push",
			hit_time = 0.1,
			weapon_action_hand = "right",
			hit_effect = "melee_hit_sword_1h",
			damage_window_end = 0.2,
			impact_sound_event = "slashing_hit",
			charge_value = "action_push",
			dedicated_target_range = 2,
			anim_event = "attack_push",
			total_time = 0.8,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.25,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.2,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
				},
				{
					sub_action = "default_right",
					start_time = 0.4,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					send_buffer = true,
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.3,
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
					external_multiplier = 0.9,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "push",
					start_time = 0.25,
					action = "action_one",
					doubleclick_window = 0,
					input = "action_one",
					hold_required = {
						"action_two_hold"
					}
				},
				{
					sub_action = "default",
					start_time = 0.25,
					action = "action_one",
					release_required = "action_two_hold",
					doubleclick_window = 0,
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
weapon_template.display_unit = "units/weapons/weapon_display/display_1h_weapon"
weapon_template.wield_anim = "to_1h_sword"
weapon_template.buff_type = BuffTypes.MELEE
weapon_template.max_fatigue_points = 6
weapon_template.dodge_distance = 1.25
weapon_template.dodge_speed = 1.25
weapon_template.dodge_count = 100
weapon_template.attack_meta_data = {
	tap_attack = {
		penetrating = false,
		arc = 0
	},
	hold_attack = {
		penetrating = true,
		arc = 1
	}
}
weapon_template.aim_assist_settings = {
	max_range = 5,
	no_aim_input_multiplier = 0,
	base_multiplier = 0.025,
	target_node = "j_neck",
	effective_max_range = 3,
	breed_scalars = {
		skaven_storm_vermin = 0.25,
		skaven_clan_rat = 1,
		skaven_slave = 1
	}
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.6,
			stagger = 0.2,
			damage = 0.2916666666666667,
			targets = 0.6
		},
		heavy_attack = {
			speed = 0.5,
			stagger = 0.4,
			damage = 0.625,
			targets = 0.2
		}
	},
	perks = {
		light_attack = {
			"head_shot"
		},
		heavy_attack = {
			"armor_penetration"
		}
	}
}
weapon_template.wwise_dep_right_hand = {
	"wwise/one_handed_swords"
}
Weapons = Weapons or {}
Weapons.we_one_hand_sword_template_1 = table.clone(weapon_template)
Weapons.we_one_hand_sword_template_1_co = table.clone(weapon_template)
Weapons.we_one_hand_sword_template_1_co.compare_statistics.attacks.light_attack.damage = 0.32083333333333336
Weapons.we_one_hand_sword_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.6875
Weapons.we_one_hand_sword_template_1_t2 = table.clone(weapon_template)
Weapons.we_one_hand_sword_template_1_t2.actions.action_one.heavy_attack.default_target.attack_template_damage_type = "one_h_smiter_H_t2"
Weapons.we_one_hand_sword_template_1_t2.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.we_one_hand_sword_template_1_t2.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "one_h_linesman_L_1_t2"
Weapons.we_one_hand_sword_template_1_t2.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.we_one_hand_sword_template_1_t2.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "one_h_linesman_L_1_t2"
Weapons.we_one_hand_sword_template_1_t2.actions.action_one.light_attack_last.default_target.attack_template_damage_type = "one_h_smiter_L_t2"
Weapons.we_one_hand_sword_template_1_t2.actions.action_one.light_attack_last.targets[1].attack_template_damage_type = "one_h_smiter_L_t2"
Weapons.we_one_hand_sword_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.375
Weapons.we_one_hand_sword_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.75
Weapons.we_one_hand_sword_template_1_t3 = table.clone(weapon_template)
Weapons.we_one_hand_sword_template_1_t3.actions.action_one.heavy_attack.default_target.attack_template_damage_type = "one_h_smiter_H_t3"
Weapons.we_one_hand_sword_template_1_t3.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.we_one_hand_sword_template_1_t3.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "one_h_linesman_L_1_t3"
Weapons.we_one_hand_sword_template_1_t3.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.we_one_hand_sword_template_1_t3.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "one_h_linesman_L_1_t3"
Weapons.we_one_hand_sword_template_1_t3.actions.action_one.light_attack_last.default_target.attack_template_damage_type = "one_h_smiter_L_t3"
Weapons.we_one_hand_sword_template_1_t3.actions.action_one.light_attack_last.targets[1].attack_template_damage_type = "one_h_smiter_L_t3"
Weapons.we_one_hand_sword_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.4583333333333333
Weapons.we_one_hand_sword_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.875
Weapons.we_one_hand_sword_template_1_t3_un = table.clone(Weapons.we_one_hand_sword_template_1_t3)
Weapons.we_one_hand_sword_template_1_t3_un.actions.action_inspect.default.anim_event = "inspect_start_2"
Weapons.we_one_hand_sword_template_1_t3_un.actions.action_inspect.default.anim_end_event = "inspect_end_2"

return 
