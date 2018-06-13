local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			alert_sound_range_hit = 40,
			alert_sound_range_fire = 20,
			fire_at_gaze_setting = "tobii_fire_at_gaze_drake_pistols",
			fire_time = 0,
			kind = "charged_projectile",
			fire_sound_event_parameter = "drakegun_charge_fire",
			apply_recoil = true,
			hit_effect = "drakefire_pistol",
			overcharge_type = "brace_of_drake_pistols_basic",
			charge_value = "light_attack",
			fire_sound_event = "player_combat_weapon_drakepistol_fire",
			speed = 6000,
			anim_event = "attack_shoot",
			reload_time = 1.25,
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.9,
					end_time = 0.75,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_one",
					sound_time_offset = -0.05,
					chain_ready_sound = "weapon_gun_ready",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.7,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_two",
					input = "action_two"
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
				input_extension:clear_input_buffer()

				return input_extension:reset_release_input()
			end,
			projectile_info = Projectiles.brace_of_drake_pistols_shot
		},
		shoot_charged = {
			damage_window_start = 0.1,
			alert_sound_range_hit = 40,
			fire_at_gaze_setting = false,
			attack_template = "drake_pistol_charged",
			kind = "bullet_spray",
			fire_sound_event_parameter = "drakegun_charge_fire",
			charge_value = "light_attack",
			spread_template_override = "drake_pistol_charged",
			fire_time = 0,
			area_damage = true,
			hit_effect = "fireball_impact",
			damage_window_end = 0,
			overcharge_type = "brace_of_drake_pistols_charged",
			alert_sound_range_fire = 20,
			fire_sound_event = "player_combat_weapon_drakepistol_fire",
			anim_event = "attack_shoot_charged",
			total_time = 1,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.7,
					action = "action_one",
					release_required = "action_two_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_two",
					input = "action_two"
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
				input_extension:clear_input_buffer()

				return input_extension:reset_release_input()
			end
		}
	},
	action_two = {
		default = {
			charge_sound_stop_event = "player_combat_weapon_drakepistol_charge_down",
			anim_end_event = "attack_finished",
			fire_at_gaze_setting = false,
			charge_effect_material_variable_name = "intensity",
			kind = "charge",
			charge_time = 3,
			spread_template_override = "drake_pistol_charged",
			overcharge_interval = 0.3,
			charge_effect_material_name = "Fire",
			minimum_hold_time = 0.2,
			overcharge_type = "drakegun_charging",
			charge_sound_switch = "projectile_charge_sound",
			charge_effect_name = "fx/wpnfx_drake_pistol_charge",
			hold_input = "action_two_hold",
			anim_event = "attack_charge",
			charge_sound_name = "player_combat_weapon_drakepistol_charge",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					end_time = 0.75,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_wield",
					input = "action_wield"
				},
				{
					sub_action = "shoot_charged",
					start_time = 0.2,
					action = "action_one",
					input = "action_one"
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
			fire_at_gaze_setting = false,
			kind = "charge",
			anim_end_event = "attack_finished",
			charge_time = 3,
			uninterruptible = true,
			do_not_validate_with_hold = true,
			hold_input = "weapon_reload_hold",
			anim_event = "cooldown_start",
			charge_sound_name = "weapon_drakegun_cooldown_loop",
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
	time_until_overcharge_decreases = 0.25,
	overcharge_warning_low_sound_event = "drakegun_overcharge_warning_low",
	overcharge_value_decrease_rate = 1.3,
	overcharge_warning_high_sound_event = "drakegun_overcharge_warning_high",
	explosion_template = "overcharge_explosion_dwarf",
	overcharge_warning_med_sound_event = "drakegun_overcharge_warning_med",
	hit_overcharge_threshold_sound = "ui_special_attack_ready"
}
local action = weapon_template.actions.action_one.default
weapon_template.default_loaded_projectile_settings = {
	drop_multiplier = 0.04,
	speed = action.speed,
	gravity = ProjectileGravitySettings[action.projectile_info.gravity_settings]
}
local charge_action = weapon_template.actions.action_two.default
charge_action.loaded_projectile_settings = "none"
weapon_template.default_spread_template = "brace_of_drake_pistols"
weapon_template.right_hand_unit = ""
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.drake_pistol.right
weapon_template.left_hand_unit = ""
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.drake_pistol.left
weapon_template.display_unit = "units/weapons/weapon_display/display_pistols"
weapon_template.wield_anim = "to_drakefire_pistols"
weapon_template.crosshair_style = "default"
weapon_template.fire_at_gaze_setting = "tobii_fire_at_gaze_drake_pistols"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.dodge_distance = 0.85
weapon_template.dodge_speed = 0.85
weapon_template.dodge_count = 1
weapon_template.wwise_dep_right_hand = {
	"wwise/drakegun"
}
weapon_template.wwise_dep_left_hand = {
	"wwise/drakegun"
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.4,
			range = 0.4,
			damage = 0.5,
			targets = 0.2,
			stagger = 0.6
		},
		heavy_attack = {
			speed = 0.2,
			range = 0.25,
			damage = 0.525,
			targets = 0.9,
			stagger = 0.4
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
Weapons.brace_of_drakefirepistols_template_1 = table.clone(weapon_template)
Weapons.brace_of_drakefirepistols_template_1_co = table.clone(weapon_template)
Weapons.brace_of_drakefirepistols_template_1_co.compare_statistics.attacks.light_attack.damage = 0.55
Weapons.brace_of_drakefirepistols_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.5774999999999999
Weapons.brace_of_drakefirepistols_template_1_t2 = table.clone(weapon_template)
Weapons.brace_of_drakefirepistols_template_1_t2.actions.action_one.default.projectile_info = Projectiles.brace_of_drake_pistols_shot_t2
Weapons.brace_of_drakefirepistols_template_1_t2.actions.action_one.shoot_charged.attack_template = "drake_pistol_charged_t2"
Weapons.brace_of_drakefirepistols_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.625
Weapons.brace_of_drakefirepistols_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.7
Weapons.brace_of_drakefirepistols_template_1_t3 = table.clone(weapon_template)
Weapons.brace_of_drakefirepistols_template_1_t3.actions.action_one.default.projectile_info = Projectiles.brace_of_drake_pistols_shot_t3
Weapons.brace_of_drakefirepistols_template_1_t3.actions.action_one.shoot_charged.attack_template = "drake_pistol_charged_t3"
Weapons.brace_of_drakefirepistols_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.75
Weapons.brace_of_drakefirepistols_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.875

return
