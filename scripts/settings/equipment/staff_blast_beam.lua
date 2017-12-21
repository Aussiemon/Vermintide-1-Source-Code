local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			damage_window_start = 0.1,
			attack_template = "flame_blast",
			charge_value = "light_attack",
			alert_sound_range_hit = 2,
			kind = "bullet_spray",
			fire_sound_event = "weapon_staff_fire_cone",
			fire_sound_on_husk = true,
			area_damage = true,
			hit_effect = "fireball_impact",
			anim_event_last_ammo = "attack_shoot_last",
			damage_window_end = 0,
			overcharge_type = "beam_staff_shotgun",
			alert_sound_range_fire = 12,
			fire_time = 0.3,
			anim_event = "attack_shoot_sparks",
			total_time = 2,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					end_time = 0.3,
					buff_name = "planted_fast_decrease_movement"
				},
				{
					start_time = 0.3,
					external_multiplier = 1,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.5,
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
					start_time = 0.3,
					action = "weapon_reload",
					input = "weapon_reload"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension.clear_input_buffer(input_extension)

				return input_extension.reset_release_input(input_extension)
			end
		},
		charged_beam = {
			damage_window_start = 0.1,
			kind = "handgun",
			attack_template_damage_type = "sniper_AP",
			attack_template = "wizard_staff_beam_sniper",
			max_penetrations = 1,
			fire_time = 0,
			reset_aim_on_attack = true,
			spread_template_override = "handgun",
			hit_effect = "fireball_impact",
			damage_window_end = 0,
			overcharge_type = "beam_staff_sniper",
			charge_value = "light_attack",
			fire_sound_event = "weapon_staff_fire_beam_end_shot",
			anim_event = "attack_shoot_beam_spark",
			total_time = 0.66,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.65,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.65,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.2,
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
			end
		}
	},
	action_two = {
		default = {
			charge_sound_stop_event = "stop_player_combat_weapon_staff_fire_beam",
			max_penetrations = 1,
			range = 50,
			kind = "beam",
			hit_effect = "staff_spark",
			charge_sound_switch = "projectile_charge_sound",
			attack_template = "wizard_staff_beam",
			charge_sound_husk_name = "player_combat_weapon_staff_fire_beam_husk",
			overcharge_interval = 0.45,
			charge_sound_husk_stop_event = "stop_player_combat_weapon_staff_fire_beam_husk",
			aim_assist_ramp_multiplier = 0.4,
			damage_interval = 0.45,
			particle_effect_trail = "fx/wpnfx_staff_beam_trail",
			minimum_hold_time = 0.5,
			aim_assist_ramp_decay_delay = 0.3,
			overcharge_type = "beam_staff_alternate",
			anim_end_event = "attack_shoot_beam_end",
			fire_time = 0.3,
			aim_assist_max_ramp_multiplier = 0.8,
			particle_effect_target = "fx/wpnfx_staff_beam_target",
			hold_input = "action_two_hold",
			anim_event = "attack_shoot_beam_start",
			particle_effect_trail_3p = "fx/wpnfx_staff_beam_trail_3p",
			charge_sound_name = "player_combat_weapon_staff_fire_beam",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.25,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "charged_beam",
					start_time = 0.4,
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
weapon_template.default_spread_template = "blunderbuss"
weapon_template.overcharge_data = {
	explosion_template = "overcharge_explosion_brw",
	overcharge_threshold = 10,
	hit_overcharge_threshold_sound = "ui_special_attack_ready",
	time_until_overcharge_decreases = 0.5,
	overcharge_value_decrease_rate = 1
}
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
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.5,
			range = 0.25,
			damage = 0.25,
			targets = 0.8,
			stagger = 0.6
		},
		heavy_attack = {
			speed = 0.9,
			range = 0.8,
			damage = 0.125,
			targets = 0.1,
			stagger = 0.2
		}
	},
	perks = {
		light_attack = {
			"armor_penetration",
			"burn"
		},
		heavy_attack = {
			"head_shot",
			"armor_penetration",
			"burn"
		}
	}
}
Weapons = Weapons or {}
Weapons.staff_blast_beam_template_1 = table.clone(weapon_template)
Weapons.staff_blast_beam_template_1_co = table.clone(weapon_template)
Weapons.staff_blast_beam_template_1_co.compare_statistics.attacks.light_attack.damage = 0.275
Weapons.staff_blast_beam_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.1375
Weapons.staff_blast_beam_template_1_t2 = table.clone(weapon_template)
Weapons.staff_blast_beam_template_1_t2.actions.action_one.default.attack_template = "flame_blast_t2"
Weapons.staff_blast_beam_template_1_t2.actions.action_one.charged_beam.attack_template_damage_type = "sniper_AP_t2"
Weapons.staff_blast_beam_template_1_t2.actions.action_two.default.attack_template = "wizard_staff_beam_t2"
Weapons.staff_blast_beam_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.375
Weapons.staff_blast_beam_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.1875
Weapons.staff_blast_beam_template_1_t3 = table.clone(weapon_template)
Weapons.staff_blast_beam_template_1_t3.actions.action_one.default.attack_template = "flame_blast_t3"
Weapons.staff_blast_beam_template_1_t3.actions.action_one.charged_beam.attack_template_damage_type = "sniper_AP_t3"
Weapons.staff_blast_beam_template_1_t3.actions.action_two.default.attack_template = "wizard_staff_beam_t3"
Weapons.staff_blast_beam_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.5
Weapons.staff_blast_beam_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.25

return 
