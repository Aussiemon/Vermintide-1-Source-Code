local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		geiser_launch = {
			damage_window_start = 0.1,
			fire_time = 0.1,
			anim_end_event = "attack_finished",
			kind = "geiser",
			particle_radius_variable = "spawn_cylinder",
			damage_window_end = 0,
			attack_template = "wizard_staff_geiser",
			fire_sound_event_parameter = "drakegun_charge_fire",
			critical_attack_template = "wizard_staff_geiser_crit",
			particle_effect = "fx/wpnfx_staff_geiser_fire",
			overcharge_type = "geiser_charged",
			fire_sound_event = "player_combat_weapon_staff_geiser_fire",
			anim_event = "attack_geiser_placed",
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.5,
					action = "default",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_wield",
					input = "action_wield"
				}
			},
			attack_template_list = {
				"wizard_staff_geiser",
				"wizard_staff_geiser_fryem",
				"wizard_staff_geiser_crit"
			}
		},
		default = {
			damage_window_end = 0,
			overcharge_type = "beam_staff_shotgun",
			charge_value = "light_attack",
			fire_time = 0.3,
			hit_effect = "fireball_impact",
			damage_window_start = 0.1,
			attack_template = "flame_blast",
			alert_sound_range_fire = 12,
			alert_sound_range_hit = 2,
			kind = "bullet_spray",
			fire_sound_event = "weapon_staff_spark_spear_charged",
			anim_event = "attack_shoot_sparks",
			anim_event_last_ammo = "attack_shoot_last",
			area_damage = true,
			total_time = 2,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_one",
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
				}
			}
		}
	},
	action_two = {
		default = {
			charge_sound_stop_event = "player_combat_weapon_staff_charge_down",
			height = 6,
			charge_ready_sound_event = "weapon_staff_charge_ready",
			min_radius = 1,
			kind = "geiser_targeting",
			debug_draw = false,
			angle = 0,
			attack_template = "wizard_staff",
			charge_sound_switch = "projectile_charge_sound",
			overcharge_interval = 0.3,
			particle_effect = "fx/wpnfx_staff_geiser_charge",
			charge_sound_husk_stop_event = "stop_player_combat_weapon_staff_charge_husk",
			charge_sound_husk_name = "player_combat_weapon_staff_charge_husk",
			minimum_hold_time = 0.2,
			gravity = -9.82,
			overcharge_type = "charging",
			anim_end_event = "attack_geiser_end",
			fire_time = 0.1,
			charge_time = 2,
			speed = 15,
			hold_input = "action_two_hold",
			anim_event = "attack_geiser_start",
			max_radius = 4,
			charge_sound_name = "player_combat_weapon_staff_charge",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0,
					buff_name = "planted_casting_long_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "geiser_launch",
					start_time = 0.2,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				}
			}
		}
	},
	action_three = {
		default = {
			charge_sound_stop_event = "stop_player_combat_weapon_staff_cooldown",
			anim_end_event = "attack_finished",
			uninterruptible = true,
			charge_effect_material_variable_name = "intensity",
			kind = "charge",
			charge_sound_parameter_name = "drakegun_charge_fire",
			charge_effect_material_name = "Fire",
			minimum_hold_time = 0.5,
			vent_overcharge = true,
			charge_sound_switch = "projectile_charge_sound",
			charge_time = 3,
			hold_input = "action_three_hold",
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
	overcharge_value_decrease_rate = 1
}
weapon_template.show_reticule = false
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
			speed = 0.5,
			range = 0.25,
			damage = 0.4,
			targets = 0.8,
			stagger = 0.6
		},
		heavy_attack = {
			speed = 0.4,
			range = 0.4,
			damage = 0.4,
			targets = 1,
			stagger = 0.9
		}
	},
	perks = {
		light_attack = {
			"burn"
		},
		heavy_attack = {
			"armor_penetration",
			"burn"
		}
	}
}
Weapons = Weapons or {}
Weapons.staff_slam_geiser_template_1 = table.clone(weapon_template)
Weapons.staff_slam_geiser_template_1_t2 = table.clone(weapon_template)
Weapons.staff_slam_geiser_template_1_t2.actions.action_one.geiser_launch.attack_template = "wizard_staff_geiser_t2"
Weapons.staff_slam_geiser_template_1_t2.actions.action_one.geiser_launch.attack_template_list = {
	"wizard_staff_geiser_t2",
	"wizard_staff_geiser_fryem_t2",
	"wizard_staff_geiser_crit_t2"
}
Weapons.staff_slam_geiser_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.375
Weapons.staff_slam_geiser_template_1_t3 = table.clone(weapon_template)
Weapons.staff_slam_geiser_template_1_t2.actions.action_one.geiser_launch.attack_template = "wizard_staff_geiser_t3"
Weapons.staff_slam_geiser_template_1_t2.actions.action_one.geiser_launch.attack_template_list = {
	"wizard_staff_geiser_t3",
	"wizard_staff_geiser_fryem_t3",
	"wizard_staff_geiser_crit_t3"
}
Weapons.staff_slam_geiser_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.5

return
