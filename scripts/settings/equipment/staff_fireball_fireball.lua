local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			alert_sound_range_hit = 2,
			fire_time = 0.27,
			alert_sound_range_fire = 12,
			kind = "charged_projectile",
			fire_sound_event_parameter = "drakegun_charge_fire",
			aim_assist_max_ramp_multiplier = 0.8,
			aim_assist_ramp_decay_delay = 0.3,
			hit_effect = "fireball_impact",
			overcharge_type = "fireball_basic",
			charge_value = "light_attack",
			fire_sound_event = "player_combat_weapon_staff_fireball_fire",
			fire_sound_on_husk = true,
			speed = 7000,
			aim_assist_ramp_multiplier = 0.4,
			anim_event = "attack_shoot_fireball",
			total_time = 1,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_two",
					input = "action_two"
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
					input = "weapon_reload"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension.clear_input_buffer(input_extension)

				return input_extension.reset_release_input(input_extension)
			end,
			projectile_info = Projectiles.fireball
		},
		shoot_charged = {
			scale_overcharge = true,
			fire_time = 0.3,
			alert_sound_range_fire = 12,
			overcharge_type = "fireball_charged",
			kind = "charged_projectile",
			fire_sound_event_parameter = "drakegun_charge_fire",
			anim_event = "attack_shoot_fireball_charged",
			hit_effect = "fireball_impact",
			throw_up_this_much_in_target_direction = 0.15,
			charge_value = "light_attack",
			fire_sound_event = "player_combat_weapon_staff_fireball_fire",
			fire_sound_on_husk = true,
			speed = 2000,
			alert_sound_range_hit = 2,
			total_time = 1,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.4,
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
			enter_function = function (attacker_unit, input_extension)
				input_extension.clear_input_buffer(input_extension)

				return input_extension.reset_release_input(input_extension)
			end,
			projectile_info = Projectiles.fireball_charged
		}
	},
	action_two = {
		default = {
			charge_sound_stop_event = "player_combat_weapon_staff_charge_down",
			charge_ready_sound_event = "weapon_staff_charge_ready",
			kind = "charge",
			charge_sound_parameter_name = "drakegun_charge_fire",
			charge_sound_husk_stop_event = "stop_player_combat_weapon_staff_charge_husk",
			overcharge_interval = 0.3,
			charge_sound_husk_name = "player_combat_weapon_staff_charge_husk",
			minimum_hold_time = 0.3,
			overcharge_type = "drakegun_charging",
			anim_end_event = "attack_finished",
			charge_sound_switch = "projectile_charge_sound",
			charge_time = 1.5,
			hold_input = "action_two_hold",
			anim_event = "attack_charge_fireball",
			charge_sound_name = "player_combat_weapon_staff_charge",
			reload_when_out_of_ammo = true,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			allowed_chain_actions = {
				{
					sub_action = "shoot_charged",
					start_time = 0.2,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "weapon_reload",
					input = "weapon_reload"
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
	overcharge_value_decrease_rate = 1,
	overcharge_critical_buff = {
		{
			start_time = 0,
			buff_name = "overcharged_critical",
			end_time = math.huge
		}
	},
	overcharge_buff = {
		{
			start_time = 0,
			buff_name = "overcharged",
			end_time = math.huge
		}
	}
}
local action = weapon_template.actions.action_one.default
weapon_template.default_loaded_projectile_settings = {
	drop_multiplier = 0.03,
	speed = action.speed,
	gravity = ProjectileGravitySettings[action.projectile_info.gravity_settings]
}
weapon_template.default_spread_template = "fireball"
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
weapon_template.dodge_distance = 1
weapon_template.dodge_speed = 1
weapon_template.aim_assist_settings = {
	max_range = 50,
	no_aim_input_multiplier = 0,
	always_auto_aim = true,
	base_multiplier = 0,
	target_node = "j_spine1",
	effective_max_range = 30,
	breed_scalars = {
		skaven_storm_vermin = 1,
		skaven_clan_rat = 1,
		skaven_slave = 1
	}
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.3,
			range = 0.6,
			damage = 0.5,
			targets = 0.2,
			stagger = 0.6
		},
		heavy_attack = {
			speed = 0.2,
			range = 0.5,
			damage = 0.625,
			targets = 0.8,
			stagger = 0.8
		}
	},
	perks = {
		light_attack = {
			"head_shot",
			"armor_penetration"
		},
		heavy_attack = {
			"armor_penetration",
			"burn"
		}
	}
}
Weapons = Weapons or {}
Weapons.staff_fireball_fireball_template_1 = table.clone(weapon_template)
Weapons.staff_fireball_fireball_template_1_co = table.clone(weapon_template)
Weapons.staff_fireball_fireball_template_1_co.compare_statistics.attacks.light_attack.damage = 0.55
Weapons.staff_fireball_fireball_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.6875
Weapons.staff_fireball_fireball_template_1_t2 = table.clone(weapon_template)
Weapons.staff_fireball_fireball_template_1_t2.actions.action_one.default.projectile_info = Projectiles.fireball_t2
Weapons.staff_fireball_fireball_template_1_t2.actions.action_one.shoot_charged.projectile_info = Projectiles.fireball_charged_t2
Weapons.staff_fireball_fireball_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.625
Weapons.staff_fireball_fireball_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.75
Weapons.staff_fireball_fireball_template_1_t3 = table.clone(weapon_template)
Weapons.staff_fireball_fireball_template_1_t3.actions.action_one.default.projectile_info = Projectiles.fireball_t3
Weapons.staff_fireball_fireball_template_1_t3.actions.action_one.shoot_charged.projectile_info = Projectiles.fireball_charged_t3
Weapons.staff_fireball_fireball_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.75
Weapons.staff_fireball_fireball_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.875

return 
