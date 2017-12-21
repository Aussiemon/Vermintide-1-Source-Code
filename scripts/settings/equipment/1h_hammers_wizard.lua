local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.25,
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
					sub_action = "heavy_attack",
					start_time = 0.5,
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
					end_time = 1.2,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.8,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_right = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.25,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_upper",
					start_time = 0,
					action = "action_one",
					end_time = 0.3,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.5,
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
					end_time = 1.2,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.8,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_left = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.25,
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
					sub_action = "heavy_attack",
					start_time = 0.5,
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
					end_time = 1.2,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.8,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_last = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.25,
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
					start_time = 0.5,
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
					end_time = 1.2,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.8,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		heavy_attack = {
			damage_window_start = 0.15,
			anim_time_scale = 1.1,
			range_mod = 1.2,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "blunt_hit_armour",
			width_mod = 25,
			use_target = true,
			max_targets = 1,
			hit_effect = "melee_hit_hammers_1h",
			aim_assist_ramp_multiplier = 0.4,
			aim_assist_max_ramp_multiplier = 0.6,
			damage_window_end = 0.3,
			impact_sound_event = "blunt_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			aim_assist_ramp_decay_delay = 0.1,
			reset_aim_on_attack = true,
			dedicated_target_range = 3,
			uninterruptible = true,
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
					start_time = 0.6,
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
					start_time = 0.4,
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
				attack_template = "blunt_smiter"
			},
			targets = {}
		},
		light_attack_left = {
			damage_window_start = 0.38,
			anim_end_event = "attack_finished",
			anim_time_scale = 1,
			no_damage_impact_sound_event = "blunt_hit_armour",
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			charge_value = "light_attack",
			use_target = false,
			width_mod = 25,
			max_targets = 3,
			hit_effect = "melee_hit_hammers_1h",
			damage_window_end = 0.47,
			impact_sound_event = "blunt_hit",
			range_mode = 1.2,
			dedicated_target_range = 2,
			anim_event = "attack_swing_left_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.6,
					end_time = 0.5,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.85,
					action = "action_one",
					end_time = 1.25,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1.25,
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
				attack_template = "light_blunt_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_tank_L_1",
					attack_template = "blunt_linesman"
				}
			}
		},
		light_attack_right = {
			damage_window_start = 0.34,
			anim_end_event = "attack_finished",
			anim_time_scale = 1.2,
			no_damage_impact_sound_event = "blunt_hit_armour",
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			charge_value = "light_attack",
			use_target = false,
			width_mod = 25,
			max_targets = 3,
			hit_effect = "melee_hit_hammers_1h",
			damage_window_end = 0.47,
			impact_sound_event = "blunt_hit",
			range_mode = 1.2,
			dedicated_target_range = 2,
			anim_event = "attack_swing_right_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.6,
					end_time = 0.5,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_last",
					start_time = 0.65,
					action = "action_one",
					end_time = 1.25,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1.25,
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
				attack_template_damage_type = "one_h_tank_L",
				attack_template = "light_blunt_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_tank_L_1",
					attack_template = "blunt_linesman"
				}
			}
		},
		light_attack_last = {
			damage_window_start = 0.35,
			anim_time_scale = 1.25,
			no_damage_impact_sound_event = "blunt_hit_armour",
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			charge_value = "light_attack",
			sweep_z_offset = 0.05,
			width_mod = 25,
			use_target = true,
			max_targets = 1,
			hit_effect = "melee_hit_hammers_1h",
			aim_assist_max_ramp_multiplier = 0.8,
			aim_assist_ramp_decay_delay = 0.1,
			damage_window_end = 0.5,
			impact_sound_event = "blunt_hit",
			range_mode = 1.2,
			anim_end_event = "attack_finished",
			dedicated_target_range = 2,
			aim_assist_ramp_multiplier = 0.6,
			anim_event = "attack_swing_down",
			hit_stop_anim = "attack_hit",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.6,
					end_time = 0.25,
					buff_name = "planted_decrease_movement"
				},
				{
					start_time = 0.25,
					external_multiplier = 1.1,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.5,
					action = "action_one",
					end_time = 1.25,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1.25,
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
				attack_template_damage_type = "one_h_tank_L",
				attack_template = "blunt_smiter"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_tank_H_1",
					attack_template = "blunt_smiter"
				}
			}
		},
		light_attack_upper = {
			damage_window_start = 0.38,
			anim_time_scale = 1,
			range_mod = 1.2,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "blunt_hit_armour",
			sweep_z_offset = 0.05,
			width_mod = 30,
			use_target = false,
			max_targets = 4,
			hit_effect = "melee_hit_hammers_1h",
			aim_assist_max_ramp_multiplier = 0.8,
			aim_assist_ramp_decay_delay = 0.1,
			damage_window_end = 0.52,
			impact_sound_event = "blunt_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			reset_aim_on_attack = true,
			dedicated_target_range = 2,
			aim_assist_ramp_multiplier = 0.4,
			anim_event = "attack_swing_left_diagonal_last",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.6,
					end_time = 0.5,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.75,
					action = "action_one",
					end_time = 1.25,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1.25,
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
				attack_template_damage_type = "no_damage",
				attack_template = "blunt_tank_uppercut"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_smiter_L",
					attack_template = "blunt_tank_uppercut"
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
			hit_effect = "melee_hit_slashing",
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
					sub_action = "default_right",
					start_time = 0.4,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
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
					external_multiplier = 0.8,
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
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.6,
			stagger = 0.5,
			damage = 0.28125,
			targets = 0.4
		},
		heavy_attack = {
			speed = 0.4,
			stagger = 0.4,
			damage = 0.625,
			targets = 0.2
		}
	},
	perks = {
		light_attack = {},
		heavy_attack = {
			"head_shot",
			"armor_penetration"
		}
	}
}
weapon_template.attack_meta_data = {
	tap_attack = {
		penetrating = false,
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
	vertical_only = true,
	base_multiplier = 0,
	effective_max_range = 4,
	breed_scalars = {
		skaven_storm_vermin = 1,
		skaven_clan_rat = 1,
		skaven_slave = 1
	}
}
weapon_template.right_hand_unit = "units/weapons/player/wpn_empire_short_sword/wpn_empire_short_sword"
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.right
weapon_template.display_unit = "units/weapons/weapon_display/display_1h_weapon"
weapon_template.wield_anim = "to_1h_hammer"
weapon_template.buff_type = BuffTypes.MELEE
weapon_template.max_fatigue_points = 6
weapon_template.dodge_distance = 1.2
weapon_template.dodge_speed = 1.2
weapon_template.dodge_count = 3
weapon_template.wwise_dep_right_hand = {
	"wwise/one_handed_hammers"
}
Weapons = Weapons or {}
Weapons.one_handed_hammer_wizard_template_1 = table.clone(weapon_template)
Weapons.one_handed_hammer_wizard_template_1_co = table.clone(weapon_template)
Weapons.one_handed_hammer_wizard_template_1_co.compare_statistics.attacks.light_attack.damage = 0.309375
Weapons.one_handed_hammer_wizard_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.6875
Weapons.one_handed_hammer_wizard_template_1_t2 = table.clone(weapon_template)
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.heavy_attack.default_target.attack_template_damage_type = "one_h_smiter_H_t2"
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_tank_L_t2"
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "one_h_tank_L_1_t2"
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_tank_L_t2"
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "one_h_tank_L_1_t2"
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.light_attack_upper.default_target.attack_template_damage_type = "no_damage"
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.light_attack_upper.targets[1].attack_template_damage_type = "one_h_smiter_L_t2"
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.light_attack_last.default_target.attack_template_damage_type = "two_h_tank_H_1_t2"
Weapons.one_handed_hammer_wizard_template_1_t2.actions.action_one.light_attack_last.targets[1].attack_template_damage_type = "two_h_tank_H_1_t2"
Weapons.one_handed_hammer_wizard_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.3515625
Weapons.one_handed_hammer_wizard_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.75
Weapons.one_handed_hammer_wizard_template_1_t3 = table.clone(weapon_template)
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.heavy_attack.default_target.attack_template_damage_type = "one_h_smiter_H_t3"
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_tank_L_t3"
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "one_h_tank_L_1_t3"
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_tank_L_t3"
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "one_h_tank_L_1_t3"
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.light_attack_upper.default_target.attack_template_damage_type = "no_damage"
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.light_attack_upper.targets[1].attack_template_damage_type = "one_h_smiter_L_t3"
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.light_attack_last.default_target.attack_template_damage_type = "two_h_tank_H_1_t3"
Weapons.one_handed_hammer_wizard_template_1_t3.actions.action_one.light_attack_last.targets[1].attack_template_damage_type = "two_h_tank_H_1_t3"
Weapons.one_handed_hammer_wizard_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.421875
Weapons.one_handed_hammer_wizard_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.875
Weapons.one_handed_hammer_wizard_template_1_t3_un = table.clone(Weapons.one_handed_hammer_wizard_template_1_t3)
Weapons.one_handed_hammer_wizard_template_1_t3_un.actions.action_inspect.default.anim_event = "inspect_start_2"
Weapons.one_handed_hammer_wizard_template_1_t3_un.actions.action_inspect.default.anim_end_event = "inspect_end_2"

return 
