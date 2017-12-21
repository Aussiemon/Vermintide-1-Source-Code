local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			damage_window_start = 0.1,
			ammo_usage = 1,
			fire_at_gaze_setting = "tobii_fire_at_gaze_blunderbuss",
			charge_value = "light_attack",
			kind = "shotgun",
			total_time_secondary = 1,
			alert_sound_range_hit = 5,
			attack_template = "shot_blunderbuss",
			reload_when_out_of_ammo = true,
			shot_count = 12,
			max_penetrations = 3,
			apply_recoil = true,
			hit_effect = "shotgun_bullet_impact",
			anim_event_last_ammo = "attack_shoot_last",
			damage_window_end = 0,
			range = 100,
			alert_sound_range_fire = 20,
			fire_time = 0.1,
			anim_event_secondary = "reload",
			active_reload_time = 0.35,
			anim_event = "attack_shoot",
			total_time = 0.66,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.75,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.5,
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
			}
		}
	},
	action_two = {
		default = {
			damage_window_start = 0.2,
			push_radius = 1.5,
			anim_end_event = "attack_finished",
			kind = "shield_slam",
			anim_time_scale = 1.25,
			reload_when_out_of_ammo = true,
			attack_template = "blunt_fencer",
			push_attack_template = "basic_sweep_push",
			attack_template_damage_type = "one_h_tank_L_1",
			hit_time = 0.2,
			hit_effect = "melee_hit_slashing",
			damage_window_end = 0.3,
			impact_sound_event = "blunt_hit",
			no_damage_impact_sound_event = "blunt_hit_armour",
			dedicated_target_range = 2,
			anim_event = "attack_push",
			total_time = 1,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.3,
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
	ammo_per_reload = 1,
	max_ammo = 25,
	ammo_per_clip = 1,
	play_reload_anim_on_wield_reload = true,
	reload_time = 1.5,
	reload_on_ammo_pickup = true
}
weapon_template.default_spread_template = "blunderbuss"
weapon_template.right_hand_unit = ""
weapon_template.right_hand_attachment_node_linking = AttachmentNodeLinking.rifles
weapon_template.display_unit = "units/weapons/weapon_display/display_rifle"
weapon_template.wield_anim = "to_blunderbuss"
weapon_template.wield_anim_no_ammo = "to_blunderbuss_noammo"
weapon_template.crosshair_style = "default"
weapon_template.fire_at_gaze_setting = "tobii_fire_at_gaze_blunderbuss"
weapon_template.reload_event = "reload"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.dodge_distance = 1
weapon_template.dodge_speed = 1
weapon_template.dodge_count = 3
weapon_template.attack_meta_data = {
	max_range = 30,
	aim_at_node = "j_spine",
	ignore_enemies_for_obstruction = true
}
weapon_template.wwise_dep_right_hand = {
	"wwise/blunderbuss"
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.2,
			range = 0.3,
			damage = 0.75,
			targets = 1,
			stagger = 0.6
		},
		heavy_attack = {
			speed = 0.5,
			range = 0.05,
			damage = 0.25,
			targets = 1,
			stagger = 0.8
		}
	},
	perks = {
		light_attack = {
			"armor_penetration"
		},
		heavy_attack = {}
	}
}
Weapons = Weapons or {}
Weapons.blunderbuss_template_1 = table.create_copy(Weapons.blunderbuss_template_1, weapon_template)
Weapons.blunderbuss_template_1_co = table.create_copy(Weapons.blunderbuss_template_1_co, weapon_template)
Weapons.blunderbuss_template_1_co.compare_statistics.attacks.light_attack.damage = 0.825
Weapons.blunderbuss_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.275
Weapons.blunderbuss_template_1_t2 = table.create_copy(Weapons.blunderbuss_template_1_t2, weapon_template)
Weapons.blunderbuss_template_1_t2.actions.action_one.default.attack_template = "shot_blunderbuss_t2"
Weapons.blunderbuss_template_1_t2.actions.action_two.default.attack_template_damage_type = "one_h_tank_L_1_t2"
Weapons.blunderbuss_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.875
Weapons.blunderbuss_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.3125
Weapons.blunderbuss_template_1_t3 = table.create_copy(Weapons.blunderbuss_template_1_t3, weapon_template)
Weapons.blunderbuss_template_1_t3.actions.action_one.default.attack_template = "shot_blunderbuss_t3"
Weapons.blunderbuss_template_1_t3.actions.action_two.default.attack_template_damage_type = "one_h_tank_L_1_t3"
Weapons.blunderbuss_template_1_t3.compare_statistics.attacks.light_attack.damage = 1
Weapons.blunderbuss_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.375

return 
