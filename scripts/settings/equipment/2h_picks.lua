local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_left_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.2,
					end_time = 0.7,
					buff_name = "planted_charging_decrease_movement"
				},
				{
					start_time = 0.7,
					external_multiplier = 0.4,
					end_time = 1,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 1,
					external_multiplier = 1.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_left",
					start_time = 0,
					action = "action_one",
					end_time = 0.4,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_left",
					start_time = 0.4,
					action = "action_one",
					end_time = 1.4,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_left_charged",
					start_time = 1.4,
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
					start_time = 0.75,
					end_time = 2.25,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_left_charged",
					start_time = 1.8,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_left = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_right_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.2,
					end_time = 0.7,
					buff_name = "planted_charging_decrease_movement"
				},
				{
					start_time = 0.7,
					external_multiplier = 0.4,
					end_time = 1,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 1,
					external_multiplier = 1.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_right",
					start_time = 0,
					action = "action_one",
					end_time = 0.4,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_right",
					start_time = 0.4,
					action = "action_one",
					end_time = 1.4,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_right_charged",
					start_time = 1.4,
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
					start_time = 0.75,
					end_time = 2.25,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_right_charged",
					start_time = 1.8,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_right = {
			kind = "dummy",
			anim_end_event = "attack_finished",
			anim_event = "attack_swing_charge_left_down",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.2,
					end_time = 0.7,
					buff_name = "planted_charging_decrease_movement"
				},
				{
					start_time = 0.7,
					external_multiplier = 0.4,
					end_time = 1,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 1,
					external_multiplier = 1.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_left",
					start_time = 0,
					action = "action_one",
					end_time = 0.4,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_left",
					start_time = 0.4,
					action = "action_one",
					end_time = 1.4,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_left_charged",
					start_time = 1.4,
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
					start_time = 0.75,
					end_time = 2.25,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_left_charged",
					start_time = 1.8,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		light_attack_right = {
			damage_window_start = 0.3,
			anim_time_scale = 0.95,
			range_mod = 1.4,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "slashing_hit_armour",
			max_targets = 4,
			use_target = false,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_hammers_2h",
			damage_window_end = 0.5,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_right_diagonal_axe",
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
					start_time = 0.95,
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
			default_target = {
				attack_template_damage_type = "no_damage",
				attack_template = "heavy_blunt_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_linesman_L_3",
					attack_template = "heavy_blunt_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L_1",
					attack_template = "heavy_blunt_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L",
					attack_template = "heavy_blunt_linesman"
				}
			}
		},
		light_attack_left = {
			damage_window_start = 0.3,
			anim_time_scale = 0.95,
			range_mod = 1.4,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "blunt_hit_armour",
			use_target = false,
			max_targets = 4,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_hammers_2h",
			damage_window_end = 0.5,
			impact_sound_event = "blunt_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_left_diagonal_axe",
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
					start_time = 0.95,
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
				return input_extension.reset_release_input(input_extension)
			end,
			default_target = {
				attack_template_damage_type = "no_damage",
				attack_template = "heavy_blunt_linesman"
			},
			targets = {
				{
					attack_template_damage_type = "two_h_linesman_L_3",
					attack_template = "heavy_blunt_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L_1",
					attack_template = "heavy_blunt_linesman"
				},
				{
					attack_template_damage_type = "two_h_linesman_L",
					attack_template = "heavy_blunt_linesman"
				}
			}
		},
		heavy_attack_left_charged = {
			damage_window_start = 0.3,
			range_mod = 1.35,
			anim_time_scale = 1,
			kind = "sweep",
			first_person_hit_anim = "attack_hit_alt_effect",
			no_damage_impact_sound_event = "slashing_hit_armour",
			max_targets = 1,
			use_target = true,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_axes_2h",
			damage_window_end = 0.45,
			impact_sound_event = "pick_axe_heavy_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_down_left_axe",
			total_time = 2.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.4,
					end_time = 0.2,
					buff_name = "planted_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 1.4,
					end_time = 0.35,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.35,
					external_multiplier = 0.4,
					end_time = 0.8,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 1,
					action = "action_one",
					end_time = 1.8,
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 1,
					action = "action_one",
					end_time = 1.8,
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 1.5,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_two",
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
				attack_template_damage_type = "two_h_smiter_H_2",
				attack_template = "heavy_stab_smiter_2"
			},
			targets = {}
		},
		heavy_attack_left = {
			damage_window_start = 0.3,
			range_mod = 1.35,
			anim_end_event = "attack_finished",
			kind = "sweep",
			first_person_hit_anim = "attack_hit_alt_effect",
			anim_time_scale = 1,
			max_targets = 1,
			use_target = true,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_axes_2h",
			damage_window_end = 0.45,
			impact_sound_event = "slashing_hit",
			charge_value = "heavy_attack",
			no_damage_impact_sound_event = "slashing_hit_armour",
			dedicated_target_range = 3,
			anim_event = "attack_swing_down_left",
			total_time = 2.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.4,
					end_time = 0.2,
					buff_name = "planted_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 1.4,
					end_time = 0.35,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.35,
					external_multiplier = 0.4,
					end_time = 0.8,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 1,
					action = "action_one",
					end_time = 1.8,
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 1,
					action = "action_one",
					end_time = 1.8,
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 1.5,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_two",
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
				attack_template_damage_type = "two_h_smiter_H",
				attack_template = "heavy_stab_smiter_2"
			},
			targets = {}
		},
		heavy_attack_right_charged = {
			damage_window_start = 0.35,
			range_mod = 1.35,
			anim_time_scale = 1,
			kind = "sweep",
			first_person_hit_anim = "attack_hit_alt_effect",
			no_damage_impact_sound_event = "slashing_hit_armour",
			max_targets = 1,
			use_target = true,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_axes_2h",
			damage_window_end = 0.53,
			impact_sound_event = "pick_axe_heavy_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_down_right_axe",
			total_time = 2.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.4,
					end_time = 0.2,
					buff_name = "planted_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 1.4,
					end_time = 0.35,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.5,
					external_multiplier = 0.4,
					end_time = 0.8,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 1,
					action = "action_one",
					end_time = 1.8,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1.5,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_two",
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
				attack_template_damage_type = "two_h_smiter_H_2",
				attack_template = "heavy_stab_smiter_2"
			},
			targets = {}
		},
		heavy_attack_right = {
			damage_window_start = 0.35,
			range_mod = 1.35,
			anim_end_event = "attack_finished",
			kind = "sweep",
			first_person_hit_anim = "attack_hit_alt_effect",
			anim_time_scale = 1,
			max_targets = 1,
			use_target = true,
			hit_shield_stop_anim = "attack_hit_shield",
			hit_effect = "melee_hit_axes_2h",
			damage_window_end = 0.53,
			impact_sound_event = "slashing_hit",
			charge_value = "heavy_attack",
			no_damage_impact_sound_event = "slashing_hit_armour",
			dedicated_target_range = 3,
			anim_event = "attack_swing_down_right",
			total_time = 2.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.4,
					end_time = 0.2,
					buff_name = "planted_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 1.4,
					end_time = 0.35,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.5,
					external_multiplier = 0.4,
					end_time = 0.8,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 1,
					action = "action_one",
					end_time = 1.8,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1.5,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_two",
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
				attack_template_damage_type = "two_h_smiter_H",
				attack_template = "heavy_stab_smiter_2"
			},
			targets = {}
		},
		push = {
			damage_window_start = 0.05,
			charge_value = "action_push",
			anim_end_event = "attack_finished",
			kind = "push_stagger",
			damage_window_end = 0.2,
			attack_template = "basic_sweep_push",
			hit_effect = "melee_hit_axes_2h",
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
					start_time = 0.4,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.5,
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
					external_multiplier = 0.6,
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
weapon_template.right_hand_unit = "units/weapons/player/wpn_empire_short_sword/wpn_empire_short_sword"
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.right
weapon_template.display_unit = "units/weapons/weapon_display/display_2h_weapon"
weapon_template.wield_anim = "to_2h_hammer"
weapon_template.buff_type = BuffTypes.MELEE
weapon_template.max_fatigue_points = 6
weapon_template.dodge_distance = 0.9
weapon_template.dodge_speed = 0.9
weapon_template.dodge_count = 1
weapon_template.attack_meta_data = {
	tap_attack = {
		penetrating = false,
		arc = 2
	},
	hold_attack = {
		penetrating = true,
		arc = 0
	}
}
weapon_template.wwise_dep_right_hand = {
	"wwise/two_handed_axes"
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.5,
			stagger = 0.2,
			damage = 0.625,
			targets = 0.2
		},
		heavy_attack = {
			speed = 0.4,
			stagger = 0.3,
			damage = 0.546875,
			targets = 0.7
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
Weapons = Weapons or {}
Weapons.two_handed_picks_template_1 = table.clone(weapon_template)
Weapons.two_handed_picks_template_1_co = table.clone(weapon_template)
Weapons.two_handed_picks_template_1_co.compare_statistics.attacks.light_attack.damage = 0.6875
Weapons.two_handed_picks_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.6015625
Weapons.two_handed_picks_template_1_t2 = table.clone(weapon_template)
Weapons.two_handed_picks_template_1_t2.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "no_damage"
Weapons.two_handed_picks_template_1_t2.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "two_h_linesman_L_3_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.light_attack_left.targets[2].attack_template_damage_type = "two_h_linesman_L_1_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.light_attack_left.targets[3].attack_template_damage_type = "two_h_linesman_L_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "no_damage"
Weapons.two_handed_picks_template_1_t2.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "two_h_linesman_L_3_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.light_attack_right.targets[2].attack_template_damage_type = "two_h_linesman_L_1_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.light_attack_right.targets[3].attack_template_damage_type = "two_h_linesman_L_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.heavy_attack_left.default_target.attack_template_damage_type = "two_h_smiter_H_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.heavy_attack_left_charged.default_target.attack_template_damage_type = "two_h_smiter_H_2_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.heavy_attack_right.default_target.attack_template_damage_type = "two_h_smiter_H_t2"
Weapons.two_handed_picks_template_1_t2.actions.action_one.heavy_attack_right_charged.default_target.attack_template_damage_type = "two_h_smiter_H_2_t2"
Weapons.two_handed_picks_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.75
Weapons.two_handed_picks_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.6328125
Weapons.two_handed_picks_template_1_t3 = table.clone(weapon_template)
Weapons.two_handed_picks_template_1_t3.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "no_damage"
Weapons.two_handed_picks_template_1_t3.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "two_h_linesman_L_3_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.light_attack_left.targets[2].attack_template_damage_type = "two_h_linesman_L_1_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.light_attack_left.targets[3].attack_template_damage_type = "two_h_linesman_L_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "no_damage"
Weapons.two_handed_picks_template_1_t3.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "two_h_linesman_L_3_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.light_attack_right.targets[2].attack_template_damage_type = "two_h_linesman_L_1_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.light_attack_right.targets[3].attack_template_damage_type = "two_h_linesman_L_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.heavy_attack_left.default_target.attack_template_damage_type = "two_h_smiter_H_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.heavy_attack_left_charged.default_target.attack_template_damage_type = "two_h_smiter_H_2_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.heavy_attack_right.default_target.attack_template_damage_type = "two_h_smiter_H_t3"
Weapons.two_handed_picks_template_1_t3.actions.action_one.heavy_attack_right_charged.default_target.attack_template_damage_type = "two_h_smiter_H_2_t3"
Weapons.two_handed_picks_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.875
Weapons.two_handed_picks_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.796875
Weapons.two_handed_picks_template_1_t3_un = table.clone(Weapons.two_handed_picks_template_1_t3)
Weapons.two_handed_picks_template_1_t3_un.actions.action_inspect.default.anim_event = "inspect_start_2"
Weapons.two_handed_picks_template_1_t3_un.actions.action_inspect.default.anim_end_event = "inspect_end_2"

return 
