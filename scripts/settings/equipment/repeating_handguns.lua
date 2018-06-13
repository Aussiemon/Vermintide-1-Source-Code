local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			attack_template_damage_type = "sniper",
			fire_at_gaze_setting = "tobii_fire_at_gaze_repeating_handgun",
			damage_window_start = 0.1,
			kind = "handgun",
			total_time_secondary = 1.75,
			max_penetrations = 2,
			attack_template = "shot_repeating_handgun",
			charge_value = "bullet_hit",
			alert_sound_range_fire = 10,
			alert_sound_range_hit = 1.5,
			reload_when_out_of_ammo = true,
			hit_effect = "bullet_impact",
			anim_event_last_ammo = "attack_shoot_last",
			apply_recoil = true,
			aim_assist_max_ramp_multiplier = 0.3,
			damage_window_end = 0,
			aim_assist_auto_hit_chance = 0.5,
			ammo_usage = 1,
			fire_time = 0,
			aim_assist_ramp_decay_delay = 0.2,
			anim_event_secondary = "reload",
			aim_assist_ramp_multiplier = 0.1,
			anim_event = "attack_shoot",
			reload_time = 0.5,
			total_time = 0.65,
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
					start_time = 0.3,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_wield",
					input = "action_wield"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension:clear_input_buffer()

				return input_extension:reset_release_input()
			end
		},
		bullet_spray = {
			damage_window_start = 0.1,
			uninterruptible = true,
			fire_at_gaze_setting = "tobii_fire_at_gaze_repeating_handgun",
			total_time_secondary = 2,
			kind = "handgun",
			recoil_factor = 0.5,
			max_penetrations = 2,
			attack_template = "shot_repeating_handgun",
			charge_value = "bullet_hit",
			alert_sound_range_fire = 10,
			alert_sound_range_hit = 1.5,
			reload_when_out_of_ammo = true,
			hit_effect = "bullet_impact",
			anim_event_last_ammo = "attack_shoot_last",
			apply_recoil = true,
			damage_window_end = 0,
			aim_assist_ramp_multiplier = 0.1,
			ammo_usage = 1,
			fire_time = 0,
			aim_assist_max_ramp_multiplier = 0.3,
			aim_assist_auto_hit_chance = 0.5,
			anim_event_secondary = "reload",
			aim_assist_ramp_decay_delay = 0.2,
			attack_template_damage_type = "sniper",
			hold_input = "action_one_hold",
			anim_event = "attack_shoot",
			reload_time = 0.5,
			total_time = 0.66,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.4,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "bullet_spray",
					start_time = 0.15,
					action = "action_one",
					auto_chain = true
				},
				{
					sub_action = "bullet_spray",
					start_time = 0.15,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_wield",
					input = "action_wield"
				}
			}
		}
	},
	action_two = {
		default = {
			uninterruptible = true,
			fire_at_gaze_setting = "tobii_fire_at_gaze_repeating_handgun",
			can_abort_reload = true,
			kind = "aim",
			anim_end_event = "attack_finished",
			aim_sound_delay = 0.6,
			ammo_requirement = 1,
			aim_sound_event = "weapon_repeating_handgun_special_cylinder",
			minimum_hold_time = 1.5,
			unaim_sound_event = "stop_weapon_repeating_handgun_special_cylinder",
			hold_input = "action_two_hold",
			anim_event = "lock_target",
			total_time = 4,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.4,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "bullet_spray",
					start_time = 0.4,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield"
				}
			},
			zoom_condition_function = function ()
				return false
			end,
			condition_func = function (unit, input_extension, ammo_extension)
				if ammo_extension and ammo_extension:total_remaining_ammo() <= 0 then
					return false
				end

				return true
			end
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
weapon_template.ammo_data = {
	ammo_hand = "right",
	ammo_per_reload = 8,
	max_ammo = 64,
	ammo_per_clip = 8,
	play_reload_anim_on_wield_reload = true,
	reload_time = 1.3,
	reload_on_ammo_pickup = true
}
weapon_template.attack_meta_data = {
	aim_at_node = "j_spine",
	can_charge_shot = false
}
weapon_template.right_hand_unit = ""
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.repeating_handgun
weapon_template.display_unit = "units/weapons/weapon_display/display_rifle"
weapon_template.wield_anim = "to_repeating_handgun"
weapon_template.wield_anim_no_ammo = "to_repeating_handgun_noammo"
weapon_template.reload_event = "reload"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.crosshair_style = "default"
weapon_template.fire_at_gaze_setting = "tobii_fire_at_gaze_repeating_handgun"
weapon_template.default_spread_template = "repeating_handgun"
weapon_template.spread_lerp_speed = 12
weapon_template.dodge_distance = 1
weapon_template.dodge_speed = 1
weapon_template.dodge_count = 1
weapon_template.aim_assist_settings = {
	max_range = 22,
	no_aim_input_multiplier = 0,
	always_auto_aim = true,
	base_multiplier = 0.15,
	effective_max_range = 10,
	breed_scalars = {
		skaven_storm_vermin = 0.25,
		skaven_clan_rat = 1,
		skaven_slave = 1
	}
}
weapon_template.wwise_dep_right_hand = {
	"wwise/repeating_handgun_pistol"
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.4,
			range = 0.6,
			damage = 0.5,
			targets = 0.2,
			stagger = 0.4
		},
		heavy_attack = {
			speed = 0.8,
			range = 0.5,
			damage = 0.5,
			targets = 0.2,
			stagger = 0.4
		}
	},
	perks = {
		light_attack = {
			"armor_penetration"
		},
		heavy_attack = {
			"armor_penetration"
		}
	}
}
Weapons = Weapons or {}
Weapons.repeating_handgun_template_1 = table.clone(weapon_template)
Weapons.repeating_handgun_template_1_co = table.clone(weapon_template)
Weapons.repeating_handgun_template_1_co.compare_statistics.attacks.light_attack.damage = 0.55
Weapons.repeating_handgun_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.55
Weapons.repeating_handgun_template_1_t2 = table.clone(weapon_template)
Weapons.repeating_handgun_template_1_t2.actions.action_one.default.attack_template_damage_type = "sniper_t2"
Weapons.repeating_handgun_template_1_t2.actions.action_one.bullet_spray.attack_template_damage_type = "sniper_t2"
Weapons.repeating_handgun_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.625
Weapons.repeating_handgun_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.625
Weapons.repeating_handgun_template_1_t3 = table.clone(weapon_template)
Weapons.repeating_handgun_template_1_t3.actions.action_one.default.attack_template_damage_type = "sniper_t3"
Weapons.repeating_handgun_template_1_t3.actions.action_one.bullet_spray.attack_template_damage_type = "sniper_t3"
Weapons.repeating_handgun_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.75
Weapons.repeating_handgun_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.75

return
