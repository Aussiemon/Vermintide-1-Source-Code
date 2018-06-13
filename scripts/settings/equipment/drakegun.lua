local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			alert_sound_range_hit = 10,
			fire_time = 0,
			charge_value = "light_attack",
			overcharge_type = "drakegun_basic",
			kind = "charged_projectile",
			fire_sound_event_parameter = "drakegun_charge_fire",
			hit_effect = "drakefire_pistol",
			throw_up_this_much_in_target_direction = 0.075,
			alert_sound_range_fire = 10,
			fire_sound_event = "player_combat_weapon_drakegun_fire",
			speed = 3000,
			anim_event = "attack_shoot",
			reload_time = 2.5,
			total_time = 0.75,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.7,
					end_time = 0.5,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {},
			projectile_info = Projectiles.drakegun_projectile
		},
		shoot_charged = {
			scale_overcharge = true,
			overcharge_type = "drakegun_charged",
			charge_value = "light_attack",
			kind = "charged_projectile",
			fire_time = 0,
			speed = 2000,
			throw_up_this_much_in_target_direction = 0.15,
			alert_sound_range_hit = 15,
			fire_sound_event = "player_combat_weapon_drakegun_fire",
			anim_event = "attack_shoot_charged",
			fire_sound_event_parameter = "drakegun_charge_fire",
			alert_sound_range_fire = 10,
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.2,
					end_time = 0.75,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 1.5,
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
			projectile_info = Projectiles.drakegun_projectile_charged
		}
	},
	action_two = {
		default = {
			charge_sound_stop_event = "player_combat_weapon_drakegun_charge_down",
			anim_end_event = "attack_finished",
			charge_ready_sound_event = "weapon_drakegun_charge_ready",
			charge_effect_name = "fx/wpnfx_drake_gun_charge",
			kind = "charge",
			charge_effect_material_variable_name = "intensity",
			overcharge_interval = 0.3,
			charge_effect_material_name = "Fire",
			minimum_hold_time = 0.2,
			overcharge_type = "drakegun_charging",
			charge_sound_switch = "projectile_charge_sound",
			charge_time = 2,
			hold_input = "action_two_hold",
			anim_event = "attack_charge",
			charge_sound_name = "player_combat_weapon_drakegun_charge",
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
			charge_sound_stop_event = "stop_weapon_drakegun_cooldown_loop",
			vent_overcharge = true,
			anim_end_event = "attack_finished",
			kind = "charge",
			charge_time = 3,
			uninterruptible = true,
			do_not_validate_with_hold = true,
			charge_sound_name = "weapon_drakegun_cooldown_loop",
			hold_input = "weapon_reload_hold",
			anim_event = "cooldown_start",
			minimum_hold_time = 0.5,
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
	overcharge_threshold = 10,
	overcharge_warning_critical_sound_event = "drakegun_overcharge_warning_critical",
	time_until_overcharge_decreases = 0.5,
	overcharge_warning_low_sound_event = "drakegun_overcharge_warning_low",
	overcharge_value_decrease_rate = 1,
	overcharge_warning_high_sound_event = "drakegun_overcharge_warning_high",
	explosion_template = "overcharge_explosion_dwarf",
	overcharge_warning_med_sound_event = "drakegun_overcharge_warning_med",
	hit_overcharge_threshold_sound = "ui_special_attack_ready"
}
weapon_template.attack_meta_data = {
	max_range = 50,
	obstruction_fuzzyness_range_charged = 1,
	always_charge_before_firing = false,
	charged_attack_action_name = "shoot_charged",
	aim_at_node = "j_spine",
	can_charge_shot = true,
	minimum_charge_time = 0.1,
	charge_when_obstructed = false,
	charge_when_outside_max_range = false,
	obstruction_fuzzyness_range = 1
}
local action = weapon_template.actions.action_one.default
weapon_template.default_loaded_projectile_settings = {
	drop_multiplier = 0.05,
	speed = action.speed,
	gravity = ProjectileGravitySettings[action.projectile_info.gravity_settings]
}
weapon_template.default_spread_template = "drakegun"
weapon_template.right_hand_unit = ""
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.drakegun
weapon_template.display_unit = "units/weapons/weapon_display/display_drakegun"
weapon_template.wield_anim = "to_drakegun"
weapon_template.crosshair_style = "default"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.dodge_distance = 0.85
weapon_template.dodge_speed = 0.85
weapon_template.dodge_count = 1
weapon_template.wwise_dep_right_hand = {
	"wwise/drakegun"
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
			"armor_penetration"
		},
		heavy_attack = {
			"armor_penetration",
			"burn"
		}
	}
}
Weapons = Weapons or {}
Weapons.drakegun_template_1 = table.clone(weapon_template)
Weapons.drakegun_template_1_co = table.clone(weapon_template)
Weapons.drakegun_template_1_co.compare_statistics.attacks.light_attack.damage = 0.55
Weapons.drakegun_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.6875
Weapons.drakegun_template_1_t2 = table.clone(weapon_template)
Weapons.drakegun_template_1_t2.actions.action_one.default.projectile_info = Projectiles.drakegun_projectile_t2
Weapons.drakegun_template_1_t2.actions.action_one.shoot_charged.projectile_info = Projectiles.drakegun_projectile_charged_t2
Weapons.drakegun_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.625
Weapons.drakegun_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.75
Weapons.drakegun_template_1_t3 = table.clone(weapon_template)
Weapons.drakegun_template_1_t3.actions.action_one.default.projectile_info = Projectiles.drakegun_projectile_t3
Weapons.drakegun_template_1_t3.actions.action_one.shoot_charged.projectile_info = Projectiles.drakegun_projectile_charged_t3
Weapons.drakegun_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.75
Weapons.drakegun_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.875

return
