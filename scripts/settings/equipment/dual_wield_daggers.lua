local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			anim_end_event = "attack_finished",
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_ramp_decay_delay = 0.1,
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
			anim_end_event = "attack_finished",
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_ramp_decay_delay = 0.1,
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
					start_time = 0.3,
					end_time = 1,
					input = "action_one_hold"
				},
				{
					sub_action = "heavy_attack",
					start_time = 1,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_left = {
			anim_end_event = "attack_finished",
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_ramp_decay_delay = 0.1,
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
					sub_action = "light_attack_quick_left",
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
					start_time = 0.3,
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
		default_left_last = {
			anim_end_event = "attack_finished",
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_ramp_decay_delay = 0.1,
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
					start_time = 0.15,
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
					start_time = 0.7,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		default_stab = {
			anim_end_event = "attack_finished",
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_ramp_decay_delay = 0.1,
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
					sub_action = "light_attack_stab",
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
					start_time = 0.15,
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
					start_time = 0.7,
					action = "action_one",
					auto_chain = true
				}
			}
		},
		heavy_attack = {
			damage_window_start = 0.15,
			range_mod = 1,
			anim_end_event = "attack_finished",
			no_damage_impact_sound_event = "slashing_hit_armour",
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			max_targets = 1,
			use_target = true,
			attack_direction = "up",
			aim_assist_ramp_multiplier = 0.2,
			hit_effect = "melee_hit_dagger",
			aim_assist_max_ramp_multiplier = 0.6,
			aim_assist_ramp_decay_delay = 0.1,
			damage_window_end = 0.27,
			impact_sound_event = "slashing_hit",
			charge_value = "heavy_attack",
			reset_aim_on_attack = true,
			dedicated_target_range = 2.5,
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
					external_multiplier = 1.25,
					end_time = 0.25,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.25,
					external_multiplier = 0.75,
					end_time = 0.4,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.5,
					action = "action_one",
					release_required = "action_one_hold",
					end_time = 0.75,
					input = "action_one"
				},
				{
					sub_action = "default_left",
					start_time = 0.5,
					action = "action_one",
					release_required = "action_one_hold",
					end_time = 0.75,
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.25,
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
				attack_template = "stab_smiter"
			},
			targets = {}
		},
		light_attack_left = {
			damage_window_start = 0.2,
			anim_time_scale = 1.5,
			range_mod = 0.85,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "stab_hit_armour",
			sweep_z_offset = 0,
			use_target = true,
			weapon_action_hand = "right",
			max_targets = 1,
			hit_effect = "melee_hit_dagger",
			aim_assist_ramp_multiplier = 0.2,
			damage_window_end = 0.32,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			aim_assist_max_ramp_multiplier = 0.6,
			aim_assist_ramp_decay_delay = 0.1,
			dedicated_target_range = 2.5,
			reset_aim_on_attack = true,
			uninterruptible = true,
			anim_event = "attack_swing_left",
			hit_stop_anim = "attack_hit",
			total_time = 2.1,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.25,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 0.85,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_right",
					start_time = 0.37,
					action = "action_one",
					end_time = 1,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1,
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
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			impact_axis = Vector3Box(0, 0, 1),
			default_target = {
				attack_template_damage_type = "one_h_ninja_L",
				attack_template = "light_slashing_fencer_hs"
			},
			targets = {}
		},
		light_attack_right = {
			damage_window_start = 0.27,
			range_mod = 0.85,
			anim_time_scale = 1.4,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "stab_hit_armour",
			sweep_z_offset = 0,
			use_target = true,
			weapon_action_hand = "left",
			max_targets = 1,
			hit_effect = "melee_hit_dagger",
			invert_attack_direction = true,
			damage_window_end = 0.42,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			aim_assist_max_ramp_multiplier = 0.6,
			aim_assist_ramp_decay_delay = 0.1,
			dedicated_target_range = 2.5,
			reset_aim_on_attack = true,
			aim_assist_ramp_multiplier = 0.2,
			anim_event = "attack_swing_right",
			hit_stop_anim = "attack_hit",
			total_time = 2.1,
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
					external_multiplier = 0.85,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left",
					start_time = 0.32,
					action = "action_one",
					end_time = 1,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1,
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
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			impact_axis = Vector3Box(0, 0, 1),
			default_target = {
				attack_template_damage_type = "one_h_ninja_L",
				attack_template = "light_slashing_fencer_hs"
			},
			targets = {}
		},
		light_attack_quick_left = {
			damage_window_start = 0.2,
			anim_time_scale = 1.5,
			range_mod = 0.85,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "stab_hit_armour",
			sweep_z_offset = 0,
			use_target = true,
			weapon_action_hand = "right",
			max_targets = 1,
			hit_effect = "melee_hit_dagger",
			aim_assist_ramp_multiplier = 0.2,
			damage_window_end = 0.32,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			aim_assist_max_ramp_multiplier = 0.6,
			aim_assist_ramp_decay_delay = 0.1,
			dedicated_target_range = 2.5,
			reset_aim_on_attack = true,
			uninterruptible = true,
			anim_event = "attack_swing_left",
			hit_stop_anim = "attack_hit",
			total_time = 2.1,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.25,
					end_time = 0.2,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.2,
					external_multiplier = 0.85,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default_left_last",
					start_time = 0.32,
					action = "action_one",
					end_time = 1,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1,
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
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			impact_axis = Vector3Box(0, 0, 1),
			default_target = {
				attack_template_damage_type = "one_h_ninja_L",
				attack_template = "light_slashing_fencer_hs"
			},
			targets = {}
		},
		light_attack_last = {
			damage_window_start = 0.27,
			range_mod = 0.85,
			anim_time_scale = 1.55,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "stab_hit_armour",
			sweep_z_offset = 0,
			use_target = true,
			weapon_action_hand = "left",
			max_targets = 1,
			hit_effect = "melee_hit_dagger",
			invert_attack_direction = true,
			damage_window_end = 0.42,
			impact_sound_event = "slashing_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			aim_assist_max_ramp_multiplier = 0.6,
			aim_assist_ramp_decay_delay = 0.1,
			dedicated_target_range = 2.5,
			reset_aim_on_attack = true,
			aim_assist_ramp_multiplier = 0.2,
			anim_event = "attack_swing_right",
			hit_stop_anim = "attack_hit",
			total_time = 2.1,
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
					external_multiplier = 0.85,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.45,
					action = "action_one",
					end_time = 1,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1,
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
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			impact_axis = Vector3Box(0, 0, 1),
			default_target = {
				attack_template_damage_type = "one_h_ninja_L",
				attack_template = "light_slashing_fencer_hs"
			},
			targets = {}
		},
		light_attack_stab = {
			damage_window_start = 0.26,
			range_mod = 1.15,
			anim_time_scale = 1.7,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			no_damage_impact_sound_event = "stab_hit_armour",
			max_targets = 1,
			use_target = true,
			attack_direction = "up",
			aim_assist_ramp_multiplier = 0.2,
			hit_effect = "melee_hit_dagger",
			aim_assist_max_ramp_multiplier = 0.8,
			damage_window_end = 0.38,
			impact_sound_event = "stab_hit",
			charge_value = "light_attack",
			anim_end_event = "attack_finished",
			aim_assist_ramp_decay_delay = 0.1,
			reset_aim_on_attack = true,
			dedicated_target_range = 2.5,
			uninterruptible = true,
			anim_event = "attack_swing_stab_lh",
			hit_stop_anim = "attack_hit",
			total_time = 2.1,
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
					external_multiplier = 0.75,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.45,
					action = "action_one",
					end_time = 1,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 1,
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
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			impact_axis = Vector3Box(0, 0, 1),
			default_target = {
				attack_template_damage_type = "one_h_smiter_L",
				attack_template = "light_stab_fencer"
			},
			targets = {}
		},
		push = {
			damage_window_start = 0.05,
			charge_value = "action_push",
			anim_end_event = "attack_finished",
			kind = "push_stagger",
			attack_template = "dagger_sweep_push",
			hit_effect = "melee_hit_dagger",
			damage_window_end = 0.2,
			fatigue_cost = "action_stun_push",
			anim_event = "attack_push",
			range_mod = 1.15,
			total_time = 1,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.15,
					end_time = 0.3,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
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
					start_time = 0.2,
					action = "action_one",
					release_required = "action_two_hold",
					doubleclick_window = 0,
					input = "action_one_hold"
				},
				{
					sub_action = "push_stab",
					start_time = 0.2,
					action = "action_one",
					doubleclick_window = 0,
					end_time = 0.8,
					input = "action_one_hold",
					hold_required = {
						"action_two_hold",
						"action_one_hold"
					}
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
		},
		push_stab = {
			damage_window_start = 0.26,
			anim_end_event = "attack_finished",
			max_targets = 1,
			kind = "sweep",
			first_person_hit_anim = "shake_hit",
			attack_direction = "up",
			aim_assist_max_ramp_multiplier = 0.8,
			use_target = true,
			aim_assist_ramp_decay_delay = 0.1,
			reset_aim_on_attack = true,
			hit_effect = "melee_hit_dagger",
			damage_window_end = 0.35,
			impact_sound_event = "stab_hit",
			charge_value = "light_attack",
			no_damage_impact_sound_event = "stab_hit_armour",
			dedicated_target_range = 3,
			aim_assist_ramp_multiplier = 0.2,
			anim_event = "push_stab",
			hit_stop_anim = "attack_hit",
			total_time = 2.1,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 1.25,
					end_time = 0.1,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "light_attack_quick_left",
					start_time = 0.5,
					action = "action_one",
					doubleclick_window = 0,
					release_required = "action_two_hold",
					end_time = 1.05,
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
					start_time = 1,
					action = "action_wield",
					input = "action_wield"
				}
			},
			default_target = {
				attack_template_damage_type = "one_h_smiter_L",
				attack_template = "stab_fencer"
			},
			targets = {}
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
					external_multiplier = 0.85,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "push",
					start_time = 0.25,
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
weapon_template.left_hand_unit = "units/weapons/player/wpn_empire_short_sword/wpn_empire_short_sword"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.left
weapon_template.display_unit = "units/weapons/weapon_display/display_1h_weapon"
weapon_template.buff_type = BuffTypes.MELEE
weapon_template.max_fatigue_points = 4
weapon_template.dodge_distance = 1.25
weapon_template.dodge_speed = 1.25
weapon_template.dodge_count = 100
weapon_template.wield_anim = "to_dual_sword_dagger"
weapon_template.attack_meta_data = {
	tap_attack = {
		penetrating = false,
		arc = 0
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
		skaven_clan_rat = 0.5,
		skaven_slave = 0.5
	}
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.9,
			stagger = 0.1,
			damage = 0.25,
			targets = 0.1
		},
		heavy_attack = {
			speed = 0.5,
			stagger = 0.4,
			damage = 0.625,
			targets = 0.1
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
	"wwise/one_handed_daggers"
}
weapon_template.wwise_dep_left_hand = {
	"wwise/one_handed_daggers"
}
Weapons = Weapons or {}
Weapons.dual_wield_daggers_template_1 = table.create_copy(Weapons.dual_wield_daggers_template_1, weapon_template)
Weapons.dual_wield_daggers_template_1_co = table.create_copy(Weapons.dual_wield_daggers_template_1_co, weapon_template)
Weapons.dual_wield_daggers_template_1_co.compare_statistics.attacks.light_attack.damage = 0.28125
Weapons.dual_wield_daggers_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.6875
Weapons.dual_wield_daggers_template_1_t2 = table.create_copy(Weapons.dual_wield_daggers_template_1_t2, weapon_template)
Weapons.dual_wield_daggers_template_1_t2.actions.action_one.heavy_attack.default_target.attack_template_damage_type = "one_h_smiter_H_t2"
Weapons.dual_wield_daggers_template_1_t2.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_ninja_L_t2"
Weapons.dual_wield_daggers_template_1_t2.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_ninja_L_t2"
Weapons.dual_wield_daggers_template_1_t2.actions.action_one.light_attack_quick_left.default_target.attack_template_damage_type = "one_h_ninja_L_1_t2"
Weapons.dual_wield_daggers_template_1_t2.actions.action_one.light_attack_last.default_target.attack_template_damage_type = "one_h_ninja_L_1_t2"
Weapons.dual_wield_daggers_template_1_t2.actions.action_one.light_attack_stab.default_target.attack_template_damage_type = "one_h_smiter_L_t2"
Weapons.dual_wield_daggers_template_1_t2.actions.action_one.push_stab.default_target.attack_template_damage_type = "one_h_smiter_L_t2"
Weapons.dual_wield_daggers_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.3125
Weapons.dual_wield_daggers_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.75
Weapons.dual_wield_daggers_template_1_t3 = table.create_copy(Weapons.dual_wield_daggers_template_1_t3, weapon_template)
Weapons.dual_wield_daggers_template_1_t3.actions.action_one.heavy_attack.default_target.attack_template_damage_type = "one_h_smiter_H_t3"
Weapons.dual_wield_daggers_template_1_t3.actions.action_one.light_attack_left.default_target.attack_template_damage_type = "one_h_ninja_L_t3"
Weapons.dual_wield_daggers_template_1_t3.actions.action_one.light_attack_right.default_target.attack_template_damage_type = "one_h_ninja_L_t3"
Weapons.dual_wield_daggers_template_1_t3.actions.action_one.light_attack_quick_left.default_target.attack_template_damage_type = "one_h_ninja_L_1_t3"
Weapons.dual_wield_daggers_template_1_t3.actions.action_one.light_attack_last.default_target.attack_template_damage_type = "one_h_ninja_L_1_t3"
Weapons.dual_wield_daggers_template_1_t3.actions.action_one.light_attack_stab.default_target.attack_template_damage_type = "one_h_smiter_L_t3"
Weapons.dual_wield_daggers_template_1_t3.actions.action_one.push_stab.default_target.attack_template_damage_type = "one_h_smiter_L_t3"
Weapons.dual_wield_daggers_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.375
Weapons.dual_wield_daggers_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.875
Weapons.dual_wield_daggers_template_1_t3_un = table.create_copy(Weapons.dual_wield_daggers_template_1_t3_un, Weapons.dual_wield_daggers_template_1_t3)
Weapons.dual_wield_daggers_template_1_t3_un.actions.action_inspect.default.anim_event = "inspect_start_2"
Weapons.dual_wield_daggers_template_1_t3_un.actions.action_inspect.default.anim_end_event = "inspect_end_2"

return 
