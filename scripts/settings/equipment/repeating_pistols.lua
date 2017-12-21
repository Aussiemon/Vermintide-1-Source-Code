local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			attack_template_damage_type = "machinegun_AP",
			fire_at_gaze_setting = "tobii_fire_at_gaze_repeating_pistol",
			kind = "handgun",
			max_penetrations = 1,
			damage_window_start = 0.1,
			total_time_secondary = 2,
			attack_template = "shot_machinegun",
			charge_value = "bullet_hit",
			alert_sound_range_fire = 10,
			alert_sound_range_hit = 1.5,
			reload_when_out_of_ammo = true,
			hit_effect = "bullet_impact",
			apply_recoil = true,
			aim_assist_max_ramp_multiplier = 0.6,
			aim_assist_auto_hit_chance = 0.5,
			damage_window_end = 0,
			aim_assist_ramp_decay_delay = 0.1,
			ammo_usage = 1,
			fire_time = 0,
			anim_event_secondary = "reload",
			aim_assist_ramp_multiplier = 0.2,
			anim_event = "attack_shoot",
			reload_time = 1.25,
			total_time = 0.66,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.1,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension.clear_input_buffer(input_extension)

				return input_extension.reset_release_input(input_extension)
			end
		},
		bullet_spray = {
			damage_window_start = 0.1,
			ammo_requirement = 1,
			fire_at_gaze_setting = "tobii_fire_at_gaze_repeating_pistol",
			kind = "shotgun",
			max_penetrations = 2,
			charge_value = "light_attack",
			alert_sound_range_fire = 12,
			attack_template = "repeating_pistol_special",
			special_ammo_thing = true,
			alert_sound_range_hit = 2,
			use_ammo_at_time = 0.3,
			reload_when_out_of_ammo = true,
			hit_effect = "bullet_impact",
			spread_template_override = "repeating_handgun_special",
			shot_count = 8,
			apply_recoil = true,
			damage_window_end = 0,
			range = 50,
			ammo_usage = 1,
			fire_time = 0.1,
			anim_event = "attack_shoot",
			reload_time = 2.5,
			total_time = 1,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_wield",
					input = "action_wield"
				}
			}
		}
	},
	action_two = {
		default = {
			anim_end_event = "attack_finished",
			fire_at_gaze_setting = "tobii_fire_at_gaze_repeating_pistol",
			anim_event = "lock_target",
			kind = "aim",
			spread_template_override = "repeating_handgun_special",
			aim_sound_delay = 0.6,
			ammo_requirement = 1,
			aim_sound_event = "weapon_repeater_special_cylinder",
			minimum_hold_time = 0.5,
			unaim_sound_event = "stop_weapon_repeater_special_cylinder",
			hold_input = "action_two_hold",
			can_abort_reload = true,
			allow_hold_toggle = true,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
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
					start_time = 0.6,
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
				if ammo_extension and ammo_extension.total_remaining_ammo(ammo_extension) <= 0 then
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
	max_ammo = 100,
	ammo_per_clip = 8,
	play_reload_anim_on_wield_reload = true,
	reload_time = 1,
	reload_on_ammo_pickup = true
}
weapon_template.default_spread_template = "repeating_pistol"
weapon_template.right_hand_unit = "units/weapons/player/wpn_emp_pistol_01_t1/wpn_emp_pistol_01_t1"
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.repeater_pistol
weapon_template.display_unit = "units/weapons/weapon_display/display_pistols"
weapon_template.wield_anim = "to_repeater_pistol"
weapon_template.crosshair_style = "default"
weapon_template.fire_at_gaze_setting = "tobii_fire_at_gaze_repeating_pistol"
weapon_template.reload_event = "reload"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.dodge_distance = 1
weapon_template.dodge_speed = 1
weapon_template.dodge_count = 1
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
weapon_template.wwise_dep_right_hand = {
	"wwise/repeating_handgun_pistol"
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.9,
			range = 0.4,
			damage = 0.25,
			targets = 0.2,
			stagger = 0.2
		},
		heavy_attack = {
			speed = 0.2,
			range = 0.2,
			damage = 0.25,
			targets = 0.9,
			stagger = 0.2
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
Weapons.repeating_pistol_template_1 = table.clone(weapon_template)
Weapons.repeating_pistol_template_1_co = table.clone(weapon_template)
Weapons.repeating_pistol_template_1_co.compare_statistics.attacks.light_attack.damage = 0.275
Weapons.repeating_pistol_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.275
Weapons.repeating_pistol_template_1_t2 = table.clone(weapon_template)
Weapons.repeating_pistol_template_1_t2.actions.action_one.default.attack_template_damage_type = "machinegun_AP_t2"
Weapons.repeating_pistol_template_1_t2.actions.action_one.bullet_spray.attack_template = "repeating_pistol_special_t2"
Weapons.repeating_pistol_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.3125
Weapons.repeating_pistol_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.3125
Weapons.repeating_pistol_template_1_t3 = table.clone(weapon_template)
Weapons.repeating_pistol_template_1_t3.actions.action_one.default.attack_template_damage_type = "machinegun_AP_t3"
Weapons.repeating_pistol_template_1_t3.actions.action_one.bullet_spray.attack_template = "repeating_pistol_special_t3"
Weapons.repeating_pistol_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.375
Weapons.repeating_pistol_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.375

return 
