local push_radius = 2.25
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.3,
			aim_assist_ramp_multiplier = 0.1,
			anim_event = "attack_swing_charge",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.2,
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
					sub_action = "heavy_attack_left",
					start_time = 0.65,
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
					start_time = 0.6,
					end_time = 1.2,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_left",
					start_time = 0.9,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_right = {
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.3,
			aim_assist_ramp_multiplier = 0.1,
			anim_event = "attack_swing_charge_diagonal_left",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.2,
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
					sub_action = "heavy_attack_right",
					start_time = 0.65,
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
					start_time = 0.6,
					end_time = 1.2,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_right",
					start_time = 0.9,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_left = {
			aim_assist_max_ramp_multiplier = 0.3,
			aim_assist_ramp_multiplier = 0.1,
			anim_event = "attack_swing_charge_diagonal_right",
			kind = "dummy",
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.2,
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
					sub_action = "heavy_attack_left",
					start_time = 0.65,
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
					start_time = 0.6,
					end_time = 1.2,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_left",
					start_time = 0.9,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		heavy_attack_left = {
			damage_window_start = 0.18,
			range_mod = 1.5,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			sweep_z_offset = 0.1,
			use_target = false,
			max_targets = 6,
			hit_effect = "melee_hit_sword_2h",
			damage_window_end = 0.3,
			impact_sound_event = "slashing_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 2.5,
			uninterruptible = true,
			anim_event = "attack_swing_heavy_left_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 2.33,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.2,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.65,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default_right",
					start_time = 0.6,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 1.05,
					action = "action_one",
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
					start_time = 0.65,
					action = "action_wield",
					input = "action_wield"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				return input_extension:reset_release_input()
			end,
			default_target = {
				attack_template_damage_type = "one_h_linesman_L",
				attack_template = "heavy_slashing_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_linesman_H_1",
					attack_template = "heavy_slashing_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_H",
					attack_template = "heavy_slashing_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L",
					attack_template = "heavy_slashing_linesman"
				}
			}
		},
		heavy_attack_right = {
			damage_window_start = 0.18,
			range_mod = 1.5,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			sweep_z_offset = 0.1,
			use_target = false,
			max_targets = 6,
			hit_effect = "melee_hit_sword_2h",
			damage_window_end = 0.3,
			impact_sound_event = "slashing_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 2.5,
			uninterruptible = true,
			anim_event = "attack_swing_heavy_right_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 2.33,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.2,
					end_time = 0.2,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.65,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 0.8,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 1.05,
					action = "action_one",
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
					start_time = 0.85,
					action = "action_wield",
					input = "action_wield"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				return input_extension:reset_release_input()
			end,
			default_target = {
				attack_template_damage_type = "one_h_linesman_L",
				attack_template = "heavy_slashing_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_linesman_H_1",
					attack_template = "heavy_slashing_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_H",
					attack_template = "heavy_slashing_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L",
					attack_template = "heavy_slashing_linesman"
				}
			}
		},
		light_attack_left = {
			damage_window_start = 0.5,
			anim_time_scale = 1.3,
			range_mod = 1.35,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			sweep_z_offset = 0.1,
			use_target = false,
			max_targets = 6,
			hit_effect = "melee_hit_sword_2h",
			damage_window_end = 0.875,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_left_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 1.8,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.6,
					end_time = 0.6,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.65,
					action = "action_one",
					end_time = 1.3,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1.3,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.7,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					end_time = 0.4,
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_wield",
					input = "action_wield"
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_linesman_L",
				attack_template = "slashing_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_linesman_L_1",
					attack_template = "slashing_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L",
					attack_template = "slashing_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L",
					attack_template = "slashing_linesman"
				}
			}
		},
		light_attack_right = {
			damage_window_start = 0.5,
			anim_time_scale = 1.3,
			range_mod = 1.35,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			sweep_z_offset = 0.1,
			use_target = false,
			max_targets = 6,
			hit_effect = "melee_hit_sword_2h",
			damage_window_end = 0.875,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_right_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 1.86,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.6,
					end_time = 0.6,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.65,
					action = "action_one",
					end_time = 1.15,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1.15,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.7,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					end_time = 0.4,
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.75,
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
					attack_template_damage_type = "two_h_linesman_L",
					attack_template = "slashing_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L",
					attack_template = "slashing_linesman"
				},
				{
					attack_template_damage_type = "one_h_linesman_L",
					attack_template = "light_slashing_linesman"
				}
			}
		},
		push = {
			damage_window_start = 0.05,
			charge_value = "action_push",
			anim_end_event = "attack_finished",
			kind = "push_stagger",
			damage_window_end = 0.2,
			attack_template = "basic_sweep_push",
			hit_effect = "melee_hit_sword_2h",
			anim_event = "attack_push",
			total_time = 0.8,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_two_hold",
					doubleclick_window = 0,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_two_hold",
					doubleclick_window = 0,
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.45,
					action = "action_two",
					send_buffer = true,
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

				return not status_extension:fatigued()
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
				return input_extension:reset_release_input()
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "push",
					start_time = 0.3,
					action = "action_one",
					doubleclick_window = 0,
					input = "action_one",
					hold_required = {
						"action_two_hold"
					}
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_two_hold",
					doubleclick_window = 0,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.3,
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
weapon_template.right_hand_unit = "units/weapons/player/wpn_greatsword/wpn_greatsword"
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.right
weapon_template.display_unit = "units/weapons/weapon_display/display_2h_weapon"
weapon_template.wield_anim = "to_2h_sword"
weapon_template.max_fatigue_points = 6
weapon_template.dodge_distance = 1
weapon_template.dodge_speed = 1
weapon_template.dodge_count = 2
weapon_template.attack_meta_data = {
	tap_attack = {
		penetrating = false,
		arc = 1
	},
	hold_attack = {
		penetrating = true,
		arc = 2
	}
}
weapon_template.aim_assist_settings = {
	max_range = 5,
	no_aim_input_multiplier = 0,
	vertical_only = true,
	base_multiplier = 0.025,
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
			speed = 0.5,
			stagger = 0.2,
			damage = 0.390625,
			targets = 0.6
		},
		heavy_attack = {
			speed = 0.3,
			stagger = 0.2,
			damage = 0.5875,
			targets = 0.9
		}
	},
	perks = {
		light_attack = {},
		heavy_attack = {
			"armor_penetration"
		}
	}
}
weapon_template.wwise_dep_right_hand = {
	"wwise/two_handed_swords"
}
Weapons = Weapons or {}
Weapons.two_handed_swords_template_1 = table.create_copy(Weapons.two_handed_swords_template_1, weapon_template)
Weapons.two_handed_swords_template_1_co = table.create_copy(Weapons.two_handed_swords_template_1_co, weapon_template)
Weapons.two_handed_swords_template_1_co.compare_statistics.attacks.light_attack.damage = 0.4296875
Weapons.two_handed_swords_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.64625
Weapons.two_handed_swords_template_1_t2 = table.create_copy(Weapons.two_handed_swords_template_1_t2, weapon_template)
Weapons.two_handed_swords_template_1_t2.actions.action_one.heavy_attack_left.default_target.attack_template_damage_type = "two_h_linesman_L_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.heavy_attack_left.targets[1].attack_template_damage_type = "two_h_linesman_H_1_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.heavy_attack_left.targets[2].attack_template_damage_type = "two_h_linesman_H_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.heavy_attack_left.targets[3].attack_template_damage_type = "two_h_linesman_H_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.heavy_attack_right.default_target.attack_template_damage_type = "two_h_linesman_L_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.heavy_attack_right.targets[1].attack_template_damage_type = "two_h_linesman_H_1_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.heavy_attack_right.targets[2].attack_template_damage_type = "two_h_linesman_H_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.heavy_attack_right.targets[3].attack_template_damage_type = "two_h_linesman_H_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "two_h_linesman_L_1_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.light_attack_left.targets[2].attack_template_damage_type = "two_h_linesman_L_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.light_attack_left.targets[3].attack_template_damage_type = "two_h_linesman_L_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "two_h_linesman_L_1_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.light_attack_right.targets[2].attack_template_damage_type = "two_h_linesman_L_t2"
Weapons.two_handed_swords_template_1_t2.actions.action_one.light_attack_right.targets[3].attack_template_damage_type = "two_h_linesman_L_t2"
Weapons.two_handed_swords_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.4765625
Weapons.two_handed_swords_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.73125
Weapons.two_handed_swords_template_1_t3 = table.create_copy(Weapons.two_handed_swords_template_1_t3, weapon_template)
Weapons.two_handed_swords_template_1_t3.actions.action_one.heavy_attack_left.default_target.attack_template_damage_type = "two_h_linesman_L_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.heavy_attack_left.targets[1].attack_template_damage_type = "two_h_linesman_H_1_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.heavy_attack_left.targets[2].attack_template_damage_type = "two_h_linesman_H_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.heavy_attack_left.targets[3].attack_template_damage_type = "two_h_linesman_H_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.heavy_attack_right.default_target.attack_template_damage_type = "two_h_linesman_L_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.heavy_attack_right.targets[1].attack_template_damage_type = "two_h_linesman_H_1_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.heavy_attack_right.targets[2].attack_template_damage_type = "two_h_linesman_H_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.heavy_attack_right.targets[3].attack_template_damage_type = "two_h_linesman_H_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "two_h_linesman_L_1_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.light_attack_left.targets[2].attack_template_damage_type = "two_h_linesman_L_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.light_attack_left.targets[3].attack_template_damage_type = "two_h_linesman_L_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "two_h_linesman_L_1_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.light_attack_right.targets[2].attack_template_damage_type = "two_h_linesman_L_t3"
Weapons.two_handed_swords_template_1_t3.actions.action_one.light_attack_right.targets[3].attack_template_damage_type = "two_h_linesman_L_t3"
Weapons.two_handed_swords_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.6328125
Weapons.two_handed_swords_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.8875
Weapons.two_handed_swords_template_1_t3_un = table.create_copy(Weapons.two_handed_swords_template_1_t3_un, Weapons.two_handed_swords_template_1_t3)
Weapons.two_handed_swords_template_1_t3_un.actions.action_inspect.default.anim_event = "inspect_start_2"
Weapons.two_handed_swords_template_1_t3_un.actions.action_inspect.default.anim_end_event = "inspect_end_2"

return
