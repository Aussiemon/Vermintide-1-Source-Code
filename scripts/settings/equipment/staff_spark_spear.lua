local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			fire_time = 0.1,
			kind = "charged_projectile",
			fire_at_gaze_setting = "tobii_fire_at_gaze_sparks",
			fire_sound_on_husk = true,
			max_penetrations = 1,
			fire_sound_event_parameter = "drakegun_charge_fire",
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_max_ramp_multiplier = 0.6,
			aim_assist_ramp_decay_delay = 0.1,
			hit_effect = "staff_spark",
			anim_time_scale = 1.5,
			overcharge_type = "spark",
			fire_sound_event = "weapon_staff_spark_spear",
			speed = 9000,
			uninterruptible = true,
			anim_event = "attack_shoot_rapid_right",
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					end_time = 0.2,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "rapid_left",
					start_time = 0.2,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "rapid_left",
					start_time = 0.2,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.1,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.1,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension:clear_input_buffer()
			end,
			projectile_info = Projectiles.spark
		},
		rapid_left = {
			fire_time = 0.1,
			kind = "charged_projectile",
			fire_at_gaze_setting = "tobii_fire_at_gaze_sparks",
			attack_template = "wizard_staff_spark",
			max_penetrations = 1,
			fire_sound_event_parameter = "drakegun_charge_fire",
			fire_sound_on_husk = true,
			aim_assist_ramp_multiplier = 0.2,
			aim_assist_max_ramp_multiplier = 0.6,
			aim_assist_ramp_decay_delay = 0.1,
			hit_effect = "staff_spark",
			overcharge_type = "spark",
			fire_sound_event = "weapon_staff_spark_spear",
			speed = 9000,
			uninterruptible = true,
			anim_event = "attack_shoot_rapid_left",
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					end_time = 0.2,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.1,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension:clear_input_buffer()
			end,
			projectile_info = Projectiles.spark
		},
		shoot_charged = {
			damage_window_start = 0.1,
			kind = "true_flight_bow",
			fire_at_gaze_setting = false,
			ammo_usage = 1,
			max_penetrations = 2,
			fire_sound_event_parameter = "drakegun_charge_fire",
			sphere_sweep_dot_threshold = 0.5,
			spread_template_override = "spear",
			fire_sound_event = "weapon_staff_spark_spear_charged",
			alert_sound_range_fire = 12,
			fire_sound_on_husk = true,
			hit_effect = "staff_spear",
			sphere_sweep_radius = 2,
			anim_time_scale = 1.5,
			reload_when_out_of_ammo = true,
			damage_window_end = 0,
			overcharge_type = "spear",
			charge_value = "light_attack",
			fire_time = 0.15,
			true_flight_template = "sniper",
			speed = 6000,
			sphere_sweep_length = 50,
			alert_sound_range_hit = 20,
			sphere_sweep_max_nr_of_results = 100,
			anim_event = "attack_shoot_spear_charged",
			reload_time = 2.5,
			reset_aim_on_attack = true,
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					end_time = 0.3,
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
					start_time = 0.3,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "weapon_reload",
					input = "weapon_reload_hold"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension:reset_release_input()
				input_extension:clear_input_buffer()
			end,
			projectile_info = Projectiles.spear
		},
		shoot_charged_2 = {
			damage_window_start = 0.1,
			kind = "true_flight_bow",
			fire_at_gaze_setting = false,
			ammo_usage = 1,
			max_penetrations = 2,
			fire_sound_event_parameter = "drakegun_charge_fire",
			sphere_sweep_dot_threshold = 0.5,
			spread_template_override = "spear",
			fire_sound_event = "weapon_staff_spark_spear_charged",
			alert_sound_range_fire = 12,
			fire_sound_on_husk = true,
			hit_effect = "staff_spear",
			sphere_sweep_radius = 2,
			anim_time_scale = 1.5,
			reload_when_out_of_ammo = true,
			damage_window_end = 0,
			overcharge_type = "spear_2",
			charge_value = "light_attack",
			fire_time = 0.15,
			true_flight_template = "sniper",
			speed = 8000,
			sphere_sweep_length = 50,
			alert_sound_range_hit = 20,
			sphere_sweep_max_nr_of_results = 100,
			anim_event = "attack_shoot_spear_charged",
			reload_time = 2.5,
			reset_aim_on_attack = true,
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					end_time = 0.3,
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
					start_time = 0.3,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "weapon_reload",
					input = "weapon_reload_hold"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension:reset_release_input()
				input_extension:clear_input_buffer()
			end,
			projectile_info = Projectiles.spear_2
		},
		shoot_charged_3 = {
			damage_window_start = 0.1,
			kind = "true_flight_bow",
			fire_at_gaze_setting = false,
			ammo_usage = 1,
			max_penetrations = 2,
			fire_sound_event_parameter = "drakegun_charge_fire",
			sphere_sweep_dot_threshold = 0.5,
			spread_template_override = "spear",
			fire_sound_event = "weapon_staff_spark_spear_charged",
			alert_sound_range_fire = 12,
			fire_sound_on_husk = true,
			hit_effect = "staff_spear",
			sphere_sweep_radius = 2,
			anim_time_scale = 1.5,
			reload_when_out_of_ammo = true,
			damage_window_end = 0,
			overcharge_type = "spear_3",
			charge_value = "light_attack",
			fire_time = 0.15,
			true_flight_template = "sniper",
			speed = 9000,
			sphere_sweep_length = 50,
			alert_sound_range_hit = 20,
			sphere_sweep_max_nr_of_results = 100,
			anim_event = "attack_shoot_spear_charged",
			reload_time = 2.5,
			reset_aim_on_attack = true,
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					end_time = 0.3,
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
					start_time = 0.3,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "weapon_reload",
					input = "weapon_reload_hold"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension:reset_release_input()
				input_extension:clear_input_buffer()
			end,
			projectile_info = Projectiles.spear_3
		}
	},
	action_two = {
		default = {
			charge_sound_stop_event = "player_combat_weapon_staff_charge_down",
			fire_at_gaze_setting = false,
			anim_end_event = "attack_finished",
			kind = "true_flight_bow_aim",
			anim_time_scale = 1.75,
			sphere_sweep_dot_threshold = 0.7,
			sphere_sweep_max_nr_of_results = 100,
			spread_template_override = "spear",
			overcharge_interval = 0.3,
			aim_assist_ramp_multiplier = 0.4,
			aim_assist_ramp_decay_delay = 0.3,
			sphere_sweep_length = 100,
			sphere_sweep_radius = 1.5,
			minimum_hold_time = 0.2,
			max_targets = 1,
			overcharge_type = "drakegun_charging",
			charge_sound_husk_name = "player_combat_weapon_staff_charge_husk",
			charge_sound_switch = "projectile_charge_sound",
			charge_sound_husk_stop_event = "stop_player_combat_weapon_staff_charge_husk",
			charge_time = 1.25,
			aim_assist_max_ramp_multiplier = 0.8,
			charge_ready_sound_event = "hud_gameplay_stance_deactivate",
			hold_input = "action_two_hold",
			anim_event = "attack_charge_spear",
			charge_sound_name = "player_combat_weapon_staff_charge",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			zoom_condition_function = function ()
				return false
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.25,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "shoot_charged_3",
					start_time = 1.25,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "shoot_charged_2",
					start_time = 0.8,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "shoot_charged",
					start_time = 0.5,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			}
		}
	},
	weapon_reload = {
		default = {
			charge_sound_stop_event = "stop_player_combat_weapon_staff_cooldown",
			fire_at_gaze_setting = false,
			uninterruptible = true,
			kind = "charge",
			charge_sound_parameter_name = "drakegun_charge_fire",
			charge_effect_material_variable_name = "intensity",
			do_not_validate_with_hold = true,
			charge_effect_material_name = "Fire",
			minimum_hold_time = 0.5,
			vent_overcharge = true,
			anim_end_event = "attack_finished",
			charge_sound_switch = "projectile_charge_sound",
			charge_time = 3,
			hold_input = "weapon_reload_hold",
			anim_event = "cooldown_start",
			charge_sound_name = "player_combat_weapon_staff_cooldown",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.2,
					buff_name = "planted_fast_decrease_movement",
					end_time = math.huge
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.2,
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
weapon_template.overcharge_data = {
	explosion_template = "overcharge_explosion_brw",
	overcharge_threshold = 10,
	hit_overcharge_threshold_sound = "ui_special_attack_ready",
	time_until_overcharge_decreases = 0.5,
	max_value = 40,
	overcharge_value_decrease_rate = 1
}
weapon_template.attack_meta_data = {
	aim_at_node = "j_spine",
	charged_attack_action_name = "shoot_charged",
	ignore_enemies_for_obstruction_charged = true,
	can_charge_shot = true,
	aim_at_node_charged = "j_head",
	minimum_charge_time = 0.55,
	charge_when_obstructed = true,
	ignore_enemies_for_obstruction = true,
	charge_against_armoured_enemy = true
}
weapon_template.aim_assist_settings = {
	max_range = 22,
	no_aim_input_multiplier = 0,
	aim_at_node = "j_neck",
	can_charge_shot = true,
	base_multiplier = 0.15,
	aim_at_node_charged = "j_spine",
	effective_max_range = 10,
	breed_scalars = {
		skaven_storm_vermin = 1,
		skaven_clan_rat = 1,
		skaven_slave = 1
	}
}
weapon_template.default_spread_template = "sparks"
weapon_template.right_hand_unit = "units/weapons/player/wpn_brw_skullstaff/wpn_brw_skullstaff"
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.staff
weapon_template.left_hand_unit = "units/weapons/player/wpn_fireball/wpn_fireball"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.left
weapon_template.display_unit = "units/weapons/weapon_display/display_staff"
weapon_template.wield_anim = "to_staff"
weapon_template.crosshair_style = "default"
weapon_template.fire_at_gaze_setting = "tobii_fire_at_gaze_sparks"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.wwise_dep_right_hand = {
	"wwise/staff"
}
weapon_template.dodge_distance = 1
weapon_template.dodge_speed = 1
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.85,
			range = 0.7,
			damage = 0.1875,
			targets = 0.2,
			stagger = 0.4
		},
		heavy_attack = {
			speed = 0.3,
			range = 0.9,
			damage = 0.75,
			targets = 0.8,
			stagger = 0.4
		}
	},
	perks = {
		light_attack = {
			"head_shot",
			"armor_penetration"
		},
		heavy_attack = {
			"head_shot",
			"armor_penetration"
		}
	}
}
Weapons = Weapons or {}
Weapons.staff_spark_spear_template_1 = table.clone(weapon_template)
Weapons.staff_spark_spear_template_1_co = table.clone(weapon_template)
Weapons.staff_spark_spear_template_1_co.compare_statistics.attacks.light_attack.damage = 0.20625
Weapons.staff_spark_spear_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.825
Weapons.staff_spark_spear_template_1_t2 = table.clone(weapon_template)
Weapons.staff_spark_spear_template_1_t2.actions.action_one.default.projectile_info = Projectiles.spark_t2
Weapons.staff_spark_spear_template_1_t2.actions.action_one.rapid_left.projectile_info = Projectiles.spark_t2
Weapons.staff_spark_spear_template_1_t2.actions.action_one.shoot_charged.projectile_info = Projectiles.spear_t2
Weapons.staff_spark_spear_template_1_t2.actions.action_one.shoot_charged_2.projectile_info = Projectiles.spear_2_t2
Weapons.staff_spark_spear_template_1_t2.actions.action_one.shoot_charged_3.projectile_info = Projectiles.spear_3_t2
Weapons.staff_spark_spear_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.25
Weapons.staff_spark_spear_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.875
Weapons.staff_spark_spear_template_1_t3 = table.clone(weapon_template)
Weapons.staff_spark_spear_template_1_t3.actions.action_one.default.projectile_info = Projectiles.spark_t3
Weapons.staff_spark_spear_template_1_t3.actions.action_one.rapid_left.projectile_info = Projectiles.spark_t3
Weapons.staff_spark_spear_template_1_t3.actions.action_one.shoot_charged.projectile_info = Projectiles.spear_t3
Weapons.staff_spark_spear_template_1_t3.actions.action_one.shoot_charged_2.projectile_info = Projectiles.spear_2_t3
Weapons.staff_spark_spear_template_1_t3.actions.action_one.shoot_charged_3.projectile_info = Projectiles.spear_3_t3
Weapons.staff_spark_spear_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.3125
Weapons.staff_spark_spear_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 1

return
