local push_radius = 2.5
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_left",
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
					end_time = 0.35,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_left",
					start_time = 0.5,
					action = "action_one",
					input = "action_one_release"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_two",
					release_required = "action_two_hold",
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
					end_time = 1.5,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_left",
					start_time = 0.7,
					action = "action_one",
					auto_chain = true
				}
			},
			enter_function = function (attacker_unit, input_extension)
				return input_extension:reset_release_input()
			end
		},
		default_right = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_left",
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
					sub_action = "light_attack_last",
					start_time = 0,
					action = "action_one",
					end_time = 0.35,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_left",
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
					start_time = 0.3,
					end_time = 1.5,
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
					external_multiplier = 0.2,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_right",
					start_time = 0,
					action = "action_one",
					end_time = 0.35,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_right",
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
					start_time = 0.3,
					end_time = 1.5,
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
		heavy_attack_right = {
			damage_window_start = 0.35,
			push_radius = 3,
			anim_time_scale = 1.4,
			kind = "sweep",
			first_person_hit_anim = "hit_right_shake",
			sweep_z_offset = 0.05,
			width_mod = 35,
			hit_time = 0.29,
			range_mod = 1.5,
			hit_effect = "melee_hit_hammers_2h",
			max_targets = 1,
			use_target = false,
			damage_window_end = 0.5,
			impact_sound_event = "blunt_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			no_damage_impact_sound_event = "blunt_hit_armour",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_heavy_down",
			hit_stop_anim = "attack_hit",
			total_time = 2.25,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.4,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.65,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.65,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 1,
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
					end_time = 0.3,
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
				return input_extension:reset_release_input()
			end,
			critical_strike = {
				critical_damage_attack_template = "heavy_blunt_tank",
				critical_attack_template_damage_type = "crit_one_h_linesman_L"
			},
			default_target = {
				attack_template_damage_type = "two_h_smiter_H",
				attack_template = "heavy_blunt_burning_smiter"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_smiter_H",
					attack_template = "heavy_blunt_burning_smiter"
				},
				{
					attack_template_damage_type = "two_h_smiter_H",
					attack_template = "heavy_blunt_burning_smiter"
				}
			}
		},
		heavy_attack_left = {
			damage_window_start = 0.33,
			push_radius = 3,
			kind = "sweep",
			first_person_hit_anim = "hit_left_shake",
			anim_time_scale = 1.25,
			sweep_z_offset = 0.05,
			width_mod = 35,
			hit_time = 0.29,
			range_mod = 1.5,
			hit_effect = "melee_hit_hammers_2h",
			max_targets = 1,
			use_target = false,
			damage_window_end = 0.5,
			impact_sound_event = "blunt_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			no_damage_impact_sound_event = "blunt_hit_armour",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_heavy",
			hit_stop_anim = "attack_hit",
			total_time = 2.25,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.3,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 0.2,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.75,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 0.75,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 1,
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
					end_time = 0.3,
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
				return input_extension:reset_release_input()
			end,
			default_target = {
				attack_template_damage_type = "two_h_smiter_H",
				attack_template = "heavy_blunt_burning_tank"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_smiter_H",
					attack_template = "heavy_blunt_burning_tank"
				},
				{
					attack_template_damage_type = "two_h_smiter_H",
					attack_template = "heavy_blunt_burning_tank"
				}
			}
		},
		light_attack_left = {
			damage_window_start = 0.33,
			anim_time_scale = 1.1,
			range_mod = 1.5,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "blunt_hit_armour",
			width_mod = 35,
			use_target = false,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_hammers_2h",
			damage_window_end = 0.42,
			impact_sound_event = "blunt_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_left_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 2.25,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0.2,
					external_multiplier = 0.2,
					end_time = 1,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.75,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 0.95,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
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
					end_time = 0.3,
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
				return input_extension:reset_release_input()
			end,
			max_targets = math.huge,
			default_target = {
				attack_template_damage_type = "no_damage",
				attack_template = "light_blunt_tank"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_tank_L",
					attack_template = "blunt_tank"
				},
				{
					attack_template_damage_type = "two_h_tank_L",
					attack_template = "blunt_tank"
				},
				{
					attack_template_damage_type = "two_h_tank_L",
					attack_template = "light_blunt_tank"
				}
			}
		},
		light_attack_right = {
			damage_window_start = 0.35,
			anim_time_scale = 1.1,
			range_mod = 1.5,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			use_target = false,
			width_mod = 35,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_hammers_2h",
			damage_window_end = 0.5,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_charge_right_diagonal",
			hit_stop_anim = "attack_hit",
			total_time = 2.25,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0.2,
					external_multiplier = 0.2,
					end_time = 1,
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
					start_time = 0.95,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
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
					end_time = 0.3,
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				}
			},
			max_targets = math.huge,
			default_target = {
				attack_template_damage_type = "no_damage",
				attack_template = "light_blunt_tank"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_tank_L",
					attack_template = "blunt_tank"
				},
				{
					attack_template_damage_type = "two_h_tank_L",
					attack_template = "blunt_tank"
				},
				{
					attack_template_damage_type = "two_h_tank_L",
					attack_template = "light_blunt_tank"
				}
			}
		},
		light_attack_last = {
			damage_window_start = 0.35,
			anim_time_scale = 1.05,
			range_mod = 1.5,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			use_target = true,
			width_mod = 35,
			max_targets = 1,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_hammers_2h",
			damage_window_end = 0.43,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_down_left",
			hit_stop_anim = "attack_hit",
			total_time = 2.25,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0.2,
					external_multiplier = 0.6,
					end_time = 1,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.7,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.95,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one_hold"
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
					end_time = 0.3,
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
				attack_template = "light_blunt_smiter"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_smiter_L",
					attack_template = "blunt_smiter"
				},
				{
					attack_template_damage_type = "two_h_smiter_L",
					attack_template = "blunt_smiter"
				},
				{
					attack_template_damage_type = "two_h_smiter_L",
					attack_template = "blunt_smiter"
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
			hit_effect = "melee_hit_hammers_2h",
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
					start_time = 0.45,
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
					external_multiplier = 0.6,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "push",
					start_time = 0.2,
					action = "action_one",
					doubleclick_window = 0,
					input = "action_one",
					hold_required = {
						"action_two_hold"
					}
				},
				{
					sub_action = "default",
					start_time = 0.2,
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
weapon_template.display_unit = "units/weapons/weapon_display/display_2h_weapon"
weapon_template.wield_anim = "to_2h_hammer"
weapon_template.buff_type = BuffTypes.MELEE
weapon_template.max_fatigue_points = 6
weapon_template.dodge_distance = 0.85
weapon_template.dodge_speed = 0.85
weapon_template.dodge_count = 1
weapon_template.attack_meta_data = {
	tap_attack = {
		penetrating = true,
		arc = 0
	},
	hold_attack = {
		penetrating = true,
		arc = 2
	}
}
weapon_template.aim_assist_settings = {
	max_range = 5,
	no_aim_input_multiplier = 0,
	base_multiplier = 0,
	effective_max_range = 4,
	breed_scalars = {
		skaven_storm_vermin = 1,
		skaven_clan_rat = 0.5,
		skaven_slave = 0.5
	}
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.5,
			stagger = 0.3,
			damage = 0.625,
			targets = 0.2
		},
		heavy_attack = {
			speed = 0.3,
			stagger = 0.8,
			damage = 0.4,
			targets = 0.9
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
weapon_template.wwise_dep_right_hand = {
	"wwise/two_handed_hammers"
}
Weapons = Weapons or {}
Weapons.two_handed_hammers_wizard_template_1 = table.clone(weapon_template)
Weapons.two_handed_hammers_wizard_template_1_co = table.clone(weapon_template)
Weapons.two_handed_hammers_wizard_template_1_co.compare_statistics.attacks.light_attack.damage = 0.6875
Weapons.two_handed_hammers_wizard_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.44
Weapons.two_handed_hammers_wizard_template_1_t2 = table.clone(weapon_template)
Weapons.two_handed_hammers_wizard_template_1_t2.actions.action_one.heavy_attack_left.default_target.attack_template_damage_type = "no_damage"
Weapons.two_handed_hammers_wizard_template_1_t2.actions.action_one.heavy_attack_left.targets[1].attack_template_damage_type = "two_h_tank_H_1_t2"
Weapons.two_handed_hammers_wizard_template_1_t2.actions.action_one.heavy_attack_left.targets[2].attack_template_damage_type = "two_h_tank_H_t2"
Weapons.two_handed_hammers_wizard_template_1_t2.actions.action_one.heavy_attack_right.default_target.attack_template_damage_type = "no_damage"
Weapons.two_handed_hammers_wizard_template_1_t2.actions.action_one.heavy_attack_right.targets[1].attack_template_damage_type = "two_h_tank_H_1_t2"
Weapons.two_handed_hammers_wizard_template_1_t2.actions.action_one.heavy_attack_right.targets[2].attack_template_damage_type = "two_h_tank_H_t2"
Weapons.two_handed_hammers_wizard_template_1_t2.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "two_h_smiter_L_t2"
Weapons.two_handed_hammers_wizard_template_1_t2.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "two_h_smiter_L_t2"
Weapons.two_handed_hammers_wizard_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.75
Weapons.two_handed_hammers_wizard_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.53125
Weapons.two_handed_hammers_wizard_template_1_t3 = table.clone(weapon_template)
Weapons.two_handed_hammers_wizard_template_1_t3.actions.action_one.heavy_attack_left.default_target.attack_template_damage_type = "no_damage"
Weapons.two_handed_hammers_wizard_template_1_t3.actions.action_one.heavy_attack_left.targets[1].attack_template_damage_type = "two_h_tank_H_1_t3"
Weapons.two_handed_hammers_wizard_template_1_t3.actions.action_one.heavy_attack_left.targets[2].attack_template_damage_type = "two_h_tank_H_t3"
Weapons.two_handed_hammers_wizard_template_1_t3.actions.action_one.heavy_attack_right.default_target.attack_template_damage_type = "no_damage"
Weapons.two_handed_hammers_wizard_template_1_t3.actions.action_one.heavy_attack_right.targets[1].attack_template_damage_type = "two_h_tank_H_1_t3"
Weapons.two_handed_hammers_wizard_template_1_t3.actions.action_one.heavy_attack_right.targets[2].attack_template_damage_type = "two_h_tank_H_t3"
Weapons.two_handed_hammers_wizard_template_1_t3.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "two_h_smiter_L_t3"
Weapons.two_handed_hammers_wizard_template_1_t3.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "two_h_smiter_L_t3"
Weapons.two_handed_hammers_wizard_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.875
Weapons.two_handed_hammers_wizard_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.6625
Weapons.two_handed_hammers_wizard_template_1_t3_un = table.clone(Weapons.two_handed_hammers_wizard_template_1_t3)
Weapons.two_handed_hammers_wizard_template_1_t3_un.actions.action_inspect.default.anim_event = "inspect_start_2"
Weapons.two_handed_hammers_wizard_template_1_t3_un.actions.action_inspect.default.anim_end_event = "inspect_end_2"

return
