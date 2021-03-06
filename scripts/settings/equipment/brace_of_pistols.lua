local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			attack_template_damage_type = "carbine_AP",
			fire_at_gaze_setting = "tobii_fire_at_gaze_brace_of_pistols",
			kind = "handgun",
			max_penetrations = 1,
			damage_window_start = 0.1,
			total_time_secondary = 2,
			attack_template = "shot_carbine",
			charge_value = "bullet_hit",
			alert_sound_range_fire = 12,
			alert_sound_range_hit = 2,
			apply_recoil = true,
			hit_effect = "bullet_impact",
			aim_assist_max_ramp_multiplier = 0.3,
			aim_assist_auto_hit_chance = 0.5,
			aim_assist_ramp_decay_delay = 0.2,
			damage_window_end = 0,
			ammo_usage = 1,
			fire_time = 0,
			anim_event_secondary = "reload",
			aim_assist_ramp_multiplier = 0.1,
			anim_event = "attack_shoot",
			reload_time = 1.25,
			total_time = 1,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_one",
					sound_time_offset = -0.05,
					chain_ready_sound = "weapon_gun_ready",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_wield",
					input = "action_wield"
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension:clear_input_buffer()

				return input_extension:reset_release_input()
			end
		},
		fast_shot = {
			damage_window_start = 0.1,
			total_time_secondary = 2,
			fire_at_gaze_setting = "tobii_fire_at_gaze_brace_of_pistols",
			attack_template = "shot_carbine",
			kind = "handgun",
			attack_template_damage_type = "carbine_AP",
			max_penetrations = 1,
			spread_template_override = "pistol_special",
			alert_sound_range_fire = 12,
			alert_sound_range_hit = 2,
			charge_value = "bullet_hit",
			hit_effect = "bullet_impact",
			apply_recoil = true,
			aim_assist_ramp_multiplier = 0.05,
			minimum_hold_time = 0.25,
			damage_window_end = 0,
			aim_assist_max_ramp_multiplier = 0.3,
			ammo_usage = 1,
			fire_time = 0,
			aim_assist_auto_hit_chance = 0.75,
			aim_assist_ramp_decay_delay = 0.1,
			anim_event_secondary = "reload",
			hold_input = "action_two_hold",
			anim_event = "attack_shoot_fast",
			reload_time = 1.25,
			total_time = 1,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.1,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "fast_shot",
					start_time = 0.25,
					action = "action_one",
					sound_time_offset = -0.05,
					chain_ready_sound = "weapon_gun_ready",
					release_required = "action_one_hold",
					input = "action_one"
				},
				{
					sub_action = "fast_shot",
					start_time = 0.25,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_wield",
					input = "action_wield"
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
			minimum_hold_time = 0.5,
			ammo_requirement = 1,
			can_abort_reload = true,
			anim_end_event = "attack_finished",
			kind = "dummy",
			max_targets = 6,
			spread_template_override = "pistol_special",
			hold_input = "action_two_hold",
			anim_event = "lock_target",
			allow_hold_toggle = true,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.1,
					buff_name = "planted_fast_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "fast_shot",
					start_time = 0.3,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "fast_shot",
					start_time = 0.3,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
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
	ammo_immediately_available = true,
	max_ammo = 56,
	reload_time = 1.25,
	single_clip = true
}
weapon_template.attack_meta_data = {
	aim_at_node = "j_head",
	can_charge_shot = false
}
weapon_template.default_spread_template = "brace_of_pistols"
weapon_template.right_hand_unit = ""
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.pistol.right
weapon_template.left_hand_unit = ""
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.pistol.left
weapon_template.display_unit = "units/weapons/weapon_display/display_pistols"
weapon_template.wield_anim = "to_dual_pistol"
weapon_template.crosshair_style = "default"
weapon_template.fire_at_gaze_setting = "tobii_fire_at_gaze_brace_of_pistols"
weapon_template.gui_texture = "hud_weapon_icon_repeating_handgun"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.dodge_distance = 1.1
weapon_template.dodge_speed = 1.1
weapon_template.dodge_count = 3
weapon_template.aim_assist_settings = {
	max_range = 22,
	no_aim_input_multiplier = 0,
	aim_at_node = "j_spine",
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
	"wwise/handgun_rifle"
}
weapon_template.third_person_attached_units = {
	{
		unit = "units/weapons/player/wpn_empire_pistol_brace/wpn_empire_pistol_brace_3p",
		attachment_node_linking = AttachmentNodeLinking.pistol_brace
	},
	{
		unit = "units/weapons/player/wpn_empire_pistol_brace/wpn_empire_pistol_brace_3p",
		attachment_node_linking = AttachmentNodeLinking.pistol_brace
	}
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.4,
			range = 0.4,
			damage = 0.5,
			targets = 0.2,
			stagger = 0.4
		},
		heavy_attack = {
			speed = 0.8,
			range = 0.4,
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
Weapons.brace_of_pistols_template_1 = table.clone(weapon_template)
Weapons.brace_of_pistols_template_1_co = table.clone(weapon_template)
Weapons.brace_of_pistols_template_1_co.compare_statistics.attacks.light_attack.damage = 0.55
Weapons.brace_of_pistols_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.55
Weapons.brace_of_pistols_template_1_t2 = table.clone(weapon_template)
Weapons.brace_of_pistols_template_1_t2.actions.action_one.default.attack_template_damage_type = "carbine_AP_t2"
Weapons.brace_of_pistols_template_1_t2.actions.action_one.fast_shot.attack_template_damage_type = "carbine_AP_t2"
Weapons.brace_of_pistols_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.625
Weapons.brace_of_pistols_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.625
Weapons.brace_of_pistols_template_1_t3 = table.clone(weapon_template)
Weapons.brace_of_pistols_template_1_t3.actions.action_one.default.attack_template_damage_type = "carbine_AP_t3"
Weapons.brace_of_pistols_template_1_t3.actions.action_one.fast_shot.attack_template_damage_type = "carbine_AP_t3"
Weapons.brace_of_pistols_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.75
Weapons.brace_of_pistols_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.75

return
