local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			kind = "charged_projectile",
			fire_time = 0.1,
			max_penetrations = 1,
			fire_sound_event_parameter = "drakegun_charge_fire",
			hit_effect = "staff_spark",
			anim_time_scale = 1.5,
			overcharge_type = "spark",
			fire_sound_event = "weapon_staff_spark_spear",
			fire_sound_on_husk = true,
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
					start_time = 0.2,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension.clear_input_buffer(input_extension)

				return 
			end,
			projectile_info = Projectiles.spark
		},
		rapid_left = {
			fire_time = 0.1,
			max_penetrations = 1,
			kind = "charged_projectile",
			fire_sound_event_parameter = "drakegun_charge_fire",
			attack_template = "wizard_staff_spark",
			hit_effect = "staff_spark",
			overcharge_type = "spark",
			fire_sound_event = "weapon_staff_spark_spear",
			fire_sound_on_husk = true,
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
					start_time = 0.2,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension.clear_input_buffer(input_extension)

				return 
			end,
			projectile_info = Projectiles.spark
		},
		shoot_charged = {
			damage_window_start = 0.1,
			max_speed = 6000,
			kind = "true_flight_bow",
			ammo_usage = 1,
			max_penetrations = 2,
			fire_sound_event_parameter = "drakegun_charge_fire",
			sphere_sweep_dot_threshold = 0.5,
			spread_template_override = "spear",
			fire_sound_event = "weapon_staff_spark_spear_charged",
			alert_sound_range_hit = 20,
			fire_sound_on_husk = true,
			hit_effect = "staff_spear",
			sphere_sweep_radius = 2,
			anim_time_scale = 1.5,
			charge_value = "light_attack",
			damage_window_end = 0,
			overcharge_type = "spear",
			alert_sound_range_fire = 12,
			fire_time = 0.15,
			true_flight_template = "sniper",
			min_speed = 5000,
			sphere_sweep_length = 50,
			reload_when_out_of_ammo = true,
			sphere_sweep_max_nr_of_results = 100,
			anim_event = "attack_shoot_spear_charged",
			reload_time = 2.5,
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
					start_time = 0.5,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			},
			projectile_info = Projectiles.spear
		},
		shoot_charged_2 = {
			damage_window_start = 0.1,
			max_speed = 6000,
			kind = "true_flight_bow",
			ammo_usage = 1,
			max_penetrations = 2,
			fire_sound_event_parameter = "drakegun_charge_fire",
			sphere_sweep_dot_threshold = 0.5,
			spread_template_override = "spear",
			fire_sound_event = "weapon_staff_spark_spear_charged",
			alert_sound_range_hit = 20,
			fire_sound_on_husk = true,
			hit_effect = "staff_spear",
			sphere_sweep_radius = 2,
			anim_time_scale = 1.5,
			charge_value = "light_attack",
			damage_window_end = 0,
			overcharge_type = "spear_2",
			alert_sound_range_fire = 12,
			fire_time = 0.15,
			true_flight_template = "sniper",
			min_speed = 5000,
			sphere_sweep_length = 50,
			reload_when_out_of_ammo = true,
			sphere_sweep_max_nr_of_results = 100,
			anim_event = "attack_shoot_spear_charged",
			reload_time = 2.5,
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
					start_time = 0.5,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			},
			projectile_info = Projectiles.spear_2
		},
		shoot_charged_3 = {
			damage_window_start = 0.1,
			max_speed = 6000,
			kind = "true_flight_bow",
			ammo_usage = 1,
			max_penetrations = 2,
			fire_sound_event_parameter = "drakegun_charge_fire",
			sphere_sweep_dot_threshold = 0.5,
			spread_template_override = "spear",
			fire_sound_event = "weapon_staff_spark_spear_charged",
			alert_sound_range_hit = 20,
			fire_sound_on_husk = true,
			hit_effect = "staff_spear",
			sphere_sweep_radius = 2,
			anim_time_scale = 1.5,
			charge_value = "light_attack",
			damage_window_end = 0,
			overcharge_type = "spear_3",
			alert_sound_range_fire = 12,
			fire_time = 0.15,
			true_flight_template = "sniper",
			min_speed = 5000,
			sphere_sweep_length = 50,
			reload_when_out_of_ammo = true,
			sphere_sweep_max_nr_of_results = 100,
			anim_event = "attack_shoot_spear_charged",
			reload_time = 2.5,
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
					start_time = 0.5,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			},
			projectile_info = Projectiles.spear_3
		}
	},
	action_two = {
		default = {
			charge_sound_stop_event = "player_combat_weapon_staff_charge_down",
			charge_ready_sound_event = "weapon_staff_charge_ready",
			sphere_sweep_length = 100,
			max_targets = 1,
			sphere_sweep_dot_threshold = 0.7,
			sphere_sweep_max_nr_of_results = 100,
			kind = "true_flight_bow_aim",
			overcharge_interval = 0.3,
			sphere_sweep_radius = 1.5,
			minimum_hold_time = 0.2,
			overcharge_type = "drakegun_charging",
			anim_end_event = "attack_finished",
			charge_sound_switch = "projectile_charge_sound",
			charge_time = 2,
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
					start_time = 1,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "shoot_charged_2",
					start_time = 0.65,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "shoot_charged",
					start_time = 0.3,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield"
				}
			}
		}
	},
	weapon_reload = {
		default = {
			charge_sound_stop_event = "stop_player_combat_weapon_staff_cooldown",
			charge_effect_material_variable_name = "intensity",
			uninterruptible = true,
			kind = "charge",
			charge_sound_parameter_name = "drakegun_charge_fire",
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
	overcharge_value_decrease_rate = 1,
	buff_data = {
		{
			start_time = 0,
			buff_name = "overcharged",
			end_time = math.huge
		}
	}
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
weapon_template.default_spread_template = "sparks"
weapon_template.right_hand_unit = "units/weapons/player/wpn_brw_skullstaff/wpn_brw_skullstaff"
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.staff
weapon_template.left_hand_unit = "units/weapons/player/wpn_fireball/wpn_fireball"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.left
weapon_template.display_unit = "units/weapons/weapon_display/display_staff"
weapon_template.wield_anim = "to_staff"
weapon_template.crosshair_style = "default"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.wwise_dep_right_hand = {
	"wwise/staff"
}
weapon_template.dodge_distance = 0.6
weapon_template.dodge_speed = 0.6
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
