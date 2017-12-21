local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			charge_value = "light_attack",
			overcharge_type = "fireball_basic",
			alert_sound_range_fire = 12,
			kind = "charged_projectile",
			fire_sound_event_parameter = "drakegun_charge_fire",
			fire_time = 0.27,
			speed = 4000,
			fire_sound_event = "player_combat_weapon_staff_fireball_fire",
			anim_event = "attack_shoot_fireball",
			hit_effect = "drakefire_pistol",
			alert_sound_range_hit = 2,
			total_time = 0.6,
			allowed_chain_actions = {},
			projectile_info = Projectiles.bouncing_fireball
		},
		bouncing_fireball_2 = {
			projectile_info = Projectiles.bouncing_fireball_2
		},
		bouncing_fireball_3 = {
			projectile_info = Projectiles.bouncing_fireball_3
		},
		shoot_charged = {
			scale_overcharge = true,
			reload_when_out_of_ammo = true,
			alert_sound_range_hit = 2,
			charge_value = "light_attack",
			kind = "charged_projectile",
			fire_sound_event_parameter = "drakegun_charge_fire",
			overcharge_type = "fireball_charged",
			attack_template = "shot_carbine",
			attack_template_damage_type = "boomer",
			fire_sound_event = "player_combat_weapon_staff_fireball_fire",
			ammo_usage = 1,
			throw_up_this_much_in_target_direction = 0.15,
			alert_sound_range_fire = 12,
			fire_time = 0.3,
			speed = 1000,
			anim_event = "attack_shoot_fireball_charged",
			reload_time = 2.5,
			total_time = 1,
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
			projectile_info = Projectiles.flame_wave_fireball
		},
		flame_wave = {
			projectile_info = Projectiles.flame_wave
		}
	},
	action_two = {
		default = {
			charge_sound_stop_event = "player_combat_weapon_staff_charge_down",
			charge_ready_sound_event = "weapon_staff_charge_ready",
			kind = "charge",
			charge_sound_parameter_name = "drakegun_charge_fire",
			attack_template = "shot_carbine",
			overcharge_interval = 0.3,
			minimum_hold_time = 0.2,
			overcharge_type = "drakegun_charging",
			anim_end_event = "attack_finished",
			charge_sound_switch = "projectile_charge_sound",
			charge_time = 2,
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
weapon_template.dodge_distance = 0.6
weapon_template.dodge_speed = 0.6
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.3,
			range = 0.6,
			damage = 0.8,
			targets = 0.2,
			stagger = 0.6
		},
		heavy_attack = {
			speed = 0.2,
			range = 0.5,
			damage = 0.9,
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
Weapons.staff_firefly_flamewave_template_1 = table.create_copy(Weapons.staff_firefly_flamewave, weapon_template)

return 
