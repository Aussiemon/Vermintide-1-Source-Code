local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			aim_assist_ramp_decay_delay = 0.2,
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.8,
			aim_assist_ramp_multiplier = 0.4,
			anim_event = "attack_swing_stab_charge",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_left",
					start_time = 0,
					action = "action_one",
					end_time = 0.25,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.35,
					action = "action_one",
					end_time = 0.7,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_charged",
					start_time = 0.7,
					action = "action_one",
					end_time = 1,
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
					sub_action = "default",
					start_time = 0.4,
					action = "action_three",
					input = "action_three"
				},
				{
					start_time = 0.35,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_charged",
					start_time = 1,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_right = {
			aim_assist_ramp_decay_delay = 2,
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.8,
			aim_assist_ramp_multiplier = 0.4,
			anim_event = "attack_swing_stab_charge",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_right",
					start_time = 0,
					action = "action_one",
					end_time = 0.25,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.35,
					action = "action_one",
					end_time = 0.7,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_charged",
					start_time = 0.7,
					action = "action_one",
					end_time = 1,
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
					sub_action = "default",
					start_time = 0.4,
					action = "action_three",
					input = "action_three"
				},
				{
					start_time = 0.35,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_charged",
					start_time = 1,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_left = {
			aim_assist_ramp_decay_delay = 0.2,
			anim_end_event = "attack_finished",
			kind = "dummy",
			aim_assist_max_ramp_multiplier = 0.8,
			aim_assist_ramp_multiplier = 0.4,
			anim_event = "attack_swing_stab_charge",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_left_last",
					start_time = 0,
					action = "action_one",
					end_time = 0.25,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack",
					start_time = 0.35,
					action = "action_one",
					end_time = 0.7,
					input = "action_one_release"
				},
				{
					sub_action = "heavy_attack_charged",
					start_time = 0.7,
					action = "action_one",
					end_time = 1,
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
					sub_action = "default",
					start_time = 0.4,
					action = "action_three",
					input = "action_three"
				},
				{
					start_time = 0.35,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack_charged",
					start_time = 1,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		heavy_attack = {
			damage_window_start = 0.03,
			anim_time_scale = 1.25,
			range_mod = 1.3,
			kind = "sweep",
			first_person_hit_anim = "attack_hit",
			no_damage_impact_sound_event = "stab_hit_armour",
			use_target = false,
			max_targets = 1,
			attack_direction = "up",
			hit_effect = "melee_hit_sword_1h",
			aim_assist_ramp_multiplier = 0.4,
			damage_window_end = 0.15,
			impact_sound_event = "stab_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			aim_assist_max_ramp_multiplier = 0.8,
			aim_assist_ramp_decay_delay = 0.1,
			dedicated_target_range = 3,
			reset_aim_on_attack = true,
			uninterruptible = true,
			anim_event = "attack_swing_stab",
			total_time = 2.25,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.75,
					end_time = 0.15,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 0.25,
					end_time = 0.25,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					doubleclick_window = 0.05,
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					doubleclick_window = 0.05,
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_one",
					release_required = "action_one_hold",
					doubleclick_window = 0.05,
					input = "action_one"
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
					action = "action_three",
					input = "action_three"
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
			impact_axis = Vector3Box(0, 0, 1),
			default_target = {
				attack_template_damage_type = "one_h_ninja_H",
				attack_template = "stab_fencer"
			},
			targets = {}
		},
		heavy_attack_charged = {
			damage_window_start = 0.03,
			anim_time_scale = 1.25,
			range_mod = 1.25,
			kind = "sweep",
			first_person_hit_anim = "attack_hit",
			no_damage_impact_sound_event = "stab_hit_armour",
			use_target = false,
			max_targets = 2,
			aim_assist_ramp_multiplier = 0.4,
			hit_effect = "melee_hit_sword_1h",
			aim_assist_max_ramp_multiplier = 0.8,
			damage_window_end = 0.15,
			impact_sound_event = "stab_hit",
			charge_value = "heavy_attack",
			anim_end_event = "attack_finished",
			aim_assist_ramp_decay_delay = 0.1,
			reset_aim_on_attack = true,
			dedicated_target_range = 3,
			uninterruptible = true,
			anim_event = "attack_swing_stab",
			total_time = 2.25,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.75,
					end_time = 0.15,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 0.25,
					end_time = 0.25,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					doubleclick_window = 0.05,
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					doubleclick_window = 0.05,
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_one",
					release_required = "action_one_hold",
					doubleclick_window = 0.05,
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
					start_time = 0.5,
					action = "action_three",
					input = "action_three"
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
			impact_axis = Vector3Box(0, 0, 1),
			default_target = {
				attack_template_damage_type = "one_h_ninja_H",
				attack_template = "heavy_stab_fencer"
			},
			targets = {}
		},
		light_attack_left = {
			damage_window_start = 0.2,
			anim_time_scale = 1.4,
			anim_end_event = "attack_finished",
			kind = "sweep",
			range_mod = 1.3,
			use_target = false,
			max_targets = 2,
			width_mod = 30,
			aim_assist_max_ramp_multiplier = 0.4,
			aim_assist_ramp_decay_delay = 0,
			hit_effect = "melee_hit_sword_1h",
			damage_window_end = 0.3,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			no_damage_impact_sound_event = "slashing_hit_armour",
			dedicated_target_range = 2.5,
			aim_assist_ramp_multiplier = 0.4,
			anim_event = "attack_swing_right",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.85,
					end_time = 0.3,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.4,
					action = "action_one",
					doubleclick_window = 0.15,
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
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_three",
					input = "action_three"
				},
				{
					sub_action = "default",
					start_time = 1.3,
					action = "idle",
					auto_chain = true
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_linesman_L",
				attack_template = "light_slashing_linesman_hs"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_linesman_L",
					attack_template = "light_slashing_linesman_hs"
				}
			}
		},
		light_attack_right = {
			damage_window_start = 0.2,
			anim_time_scale = 1.5,
			anim_end_event = "attack_finished",
			kind = "sweep",
			range_mod = 1.3,
			use_target = false,
			max_targets = 2,
			width_mod = 30,
			aim_assist_max_ramp_multiplier = 0.4,
			aim_assist_ramp_decay_delay = 0,
			hit_effect = "melee_hit_sword_1h",
			damage_window_end = 0.3,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			no_damage_impact_sound_event = "slashing_hit_armour",
			dedicated_target_range = 2.5,
			aim_assist_ramp_multiplier = 0.4,
			anim_event = "attack_swing_left",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.85,
					end_time = 0.3,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.4,
					action = "action_one",
					doubleclick_window = 0.15,
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
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_three",
					input = "action_three"
				},
				{
					sub_action = "default",
					start_time = 1.3,
					action = "idle",
					auto_chain = true
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_linesman_L",
				attack_template = "light_slashing_linesman_hs"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_linesman_L",
					attack_template = "light_slashing_linesman_hs"
				}
			}
		},
		light_attack_left_last = {
			damage_window_start = 0.3,
			anim_time_scale = 1.4,
			anim_end_event = "attack_finished",
			kind = "sweep",
			range_mod = 1.3,
			use_target = false,
			max_targets = 2,
			width_mod = 30,
			aim_assist_max_ramp_multiplier = 0.4,
			aim_assist_ramp_decay_delay = 0,
			hit_effect = "melee_hit_sword_1h",
			damage_window_end = 0.42,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			no_damage_impact_sound_event = "slashing_hit_armour",
			dedicated_target_range = 2.5,
			aim_assist_ramp_multiplier = 0.4,
			anim_event = "attack_swing_right_diagonal",
			total_time = 1.5,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.85,
					end_time = 0.3,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default_right",
					start_time = 0.6,
					action = "action_one",
					doubleclick_window = 0.15,
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
					start_time = 0.6,
					action = "action_three",
					input = "action_three"
				},
				{
					sub_action = "default",
					start_time = 1.3,
					action = "idle",
					auto_chain = true
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_linesman_L",
				attack_template = "light_slashing_linesman_hs"
			},
			targets = {
				{
					attack_template_damage_type = "one_h_linesman_L",
					attack_template = "light_slashing_linesman_hs"
				}
			}
		},
		push = {
			damage_window_start = 0.05,
			charge_value = "action_push",
			anim_end_event = "attack_finished",
			kind = "push_stagger",
			damage_window_end = 0.2,
			attack_template = "weak_sweep_push",
			hit_effect = "melee_hit_sword_1h",
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
					sub_action = "default",
					start_time = 0.25,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default_right",
					start_time = 0.25,
					action = "action_one",
					release_required = "action_two_hold",
					doubleclick_window = 0,
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
					sub_action = "block_shot",
					start_time = 0.4,
					action = "action_three",
					input = "action_three"
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
					external_multiplier = 0.9,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					doubleclick_window = 0,
					release_required = "action_two_hold",
					input = "action_one",
					end_time = math.huge
				},
				{
					sub_action = "push",
					start_time = 0.3,
					action = "action_one",
					doubleclick_window = 0,
					input = "action_one",
					end_time = math.huge,
					hold_required = {
						"action_two_hold"
					}
				},
				{
					sub_action = "block_shot",
					start_time = 0.3,
					action = "action_three",
					input = "action_three"
				}
			}
		}
	},
	action_three = {
		default = {
			attack_template_damage_type = "carbine_AP",
			kind = "handgun",
			cooldown = 0.25,
			total_time_secondary = 2,
			max_penetrations = 1,
			charge_value = "light_attack",
			weapon_action_hand = "left",
			attack_template = "shot_carbine",
			aim_assist_max_ramp_multiplier = 1,
			aim_assist_ramp_decay_delay = 0,
			hit_effect = "bullet_impact",
			anim_time_scale = 2,
			ammo_usage = 1,
			fire_time = 0.22,
			anim_event_secondary = "reload",
			aim_assist_ramp_multiplier = 1,
			anim_event = "attack_shoot",
			reload_time = 0.5,
			total_time = 0.8,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.85,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_one",
					end_time = 1.2,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_two",
					end_time = 1.2,
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.35,
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
	action_instant_equip_healing_draught = ActionTemplates.instant_equip_and_drink_healing_draught,
	idle = {
		default = {
			anim_event = "front_idle_exit",
			kind = "dummy",
			total_time = 0.5,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0,
					action = "action_one",
					end_time = 0.3,
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
					start_time = 0,
					action = "action_wield",
					input = "action_wield"
				}
			}
		}
	}
}
weapon_template.actions.action_three.block_shot = table.create_copy(weapon_template.actions.action_three.block_shot, weapon_template.actions.action_three.default)
weapon_template.actions.action_three.block_shot.block = true
weapon_template.ammo_data = {
	ammo_hand = "left",
	ammo_immediately_available = true,
	max_ammo = 16,
	reload_time = 1.25,
	single_clip = true
}
weapon_template.default_spread_template = "brace_of_pistols"
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
	base_multiplier = 0,
	target_node = "j_neck",
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
			speed = 0.8,
			stagger = 0.15,
			damage = 0.16666666666666666,
			targets = 0.4
		},
		heavy_attack = {
			speed = 0.6,
			stagger = 0.4,
			damage = 0.375,
			targets = 0.4
		}
	},
	perks = {
		light_attack = {
			"head_shot"
		},
		heavy_attack = {
			"head_shot",
			"armor_penetration"
		}
	}
}
weapon_template.right_hand_unit = "units/weapons/player/wpn_fencingsword_t1/wpn_fencingsword_t1"
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.right
weapon_template.left_hand_unit = "units/weapons/player/wpn_emp_pistol_01_t1/wpn_emp_pistol_01_t1"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.pistol.left
weapon_template.display_unit = "units/weapons/weapon_display/display_1h_weapon"
weapon_template.wield_anim = "to_fencing_sword"
weapon_template.reload_event = "reload"
weapon_template.buff_type = BuffTypes.MELEE
weapon_template.max_fatigue_points = 6
weapon_template.dodge_distance = 1.2
weapon_template.dodge_speed = 1.2
weapon_template.dodge_count = 100
weapon_template.wwise_dep_right_hand = {
	"wwise/one_handed_swords"
}
Weapons = Weapons or {}
Weapons.fencing_sword_template_1 = table.create_copy(Weapons.fencing_sword_template_1, weapon_template)
Weapons.fencing_sword_template_1_co = table.create_copy(Weapons.fencing_sword_template_1_co, weapon_template)
Weapons.fencing_sword_template_1_co.compare_statistics.attacks.light_attack.damage = 0.18333333333333335
Weapons.fencing_sword_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.4125
Weapons.fencing_sword_template_1_t2 = table.create_copy(Weapons.fencing_sword_template_1_t2, weapon_template)
Weapons.fencing_sword_template_1_t2.actions.action_one.heavy_attack.default_target.attack_template_damage_type = "one_h_ninja_H_t2"
Weapons.fencing_sword_template_1_t2.actions.action_one.heavy_attack_charged.default_target.attack_template_damage_type = "one_h_ninja_H_t2"
Weapons.fencing_sword_template_1_t2.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.fencing_sword_template_1_t2.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.fencing_sword_template_1_t2.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.fencing_sword_template_1_t2.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.fencing_sword_template_1_t2.actions.action_one.light_attack_left_last.default_target.attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.fencing_sword_template_1_t2.actions.action_one.light_attack_left_last.targets[1].attack_template_damage_type = "one_h_linesman_L_t2"
Weapons.fencing_sword_template_1_t2.actions.action_three.default.attack_template_damage_type = "carbine_AP_t2"
Weapons.fencing_sword_template_1_t2.actions.action_three.block_shot.attack_template_damage_type = "carbine_AP_t2"
Weapons.fencing_sword_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.25
Weapons.fencing_sword_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.5
Weapons.fencing_sword_template_1_t3 = table.create_copy(Weapons.fencing_sword_template_1_t3, weapon_template)
Weapons.fencing_sword_template_1_t3.actions.action_one.heavy_attack.default_target.attack_template_damage_type = "one_h_ninja_H_t3"
Weapons.fencing_sword_template_1_t3.actions.action_one.heavy_attack_charged.default_target.attack_template_damage_type = "one_h_ninja_H_t3"
Weapons.fencing_sword_template_1_t3.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.fencing_sword_template_1_t3.actions.action_one.light_attack_left.targets[1].attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.fencing_sword_template_1_t3.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.fencing_sword_template_1_t3.actions.action_one.light_attack_right.targets[1].attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.fencing_sword_template_1_t3.actions.action_one.light_attack_left_last.default_target.attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.fencing_sword_template_1_t3.actions.action_one.light_attack_left_last.targets[1].attack_template_damage_type = "one_h_linesman_L_t3"
Weapons.fencing_sword_template_1_t3.actions.action_three.default.attack_template_damage_type = "carbine_AP_t3"
Weapons.fencing_sword_template_1_t3.actions.action_three.block_shot.attack_template_damage_type = "carbine_AP_t3"
Weapons.fencing_sword_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.3333333333333333
Weapons.fencing_sword_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.625
Weapons.fencing_sword_template_1_t3_un = table.create_copy(Weapons.fencing_sword_template_1_t3_un, Weapons.fencing_sword_template_1_t3)
Weapons.fencing_sword_template_1_t3_un.actions.action_inspect.default.anim_event = "inspect_start_2"
Weapons.fencing_sword_template_1_t3_un.actions.action_inspect.default.anim_end_event = "inspect_end_2"

return
