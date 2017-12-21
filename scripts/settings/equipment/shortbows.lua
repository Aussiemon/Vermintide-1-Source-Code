local push_radius = 2
local weapon_template = weapon_template or {}
local ARROW_HIT_EFFECT = "arrow_impact"
local ALERT_SOUND_RANGE_FIRE = 4
local ALERT_SOUND_RANGE_HIT = 2
weapon_template.actions = {
	action_one = {
		default = {
			kind = "bow",
			min_speed = 5000,
			ammo_usage = 1,
			max_penetrations = 1,
			anim_event = "attack_shoot_fast",
			apply_recoil = true,
			anim_event_last_ammo = "attack_shoot_fast_last",
			charge_value = "arrow_hit",
			weapon_action_hand = "left",
			fire_sound_event = "player_combat_weapon_shortbow_fire_light",
			total_time = 0.83,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					end_time = 0.3,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.25,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one",
					end_time = math.huge
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
			end,
			hit_effect = ARROW_HIT_EFFECT,
			projectile_info = Projectiles.machinegun_arrow,
			alert_sound_range_fire = ALERT_SOUND_RANGE_FIRE,
			alert_sound_range_hit = ALERT_SOUND_RANGE_HIT
		},
		shoot_charged = {
			max_speed = 8000,
			kind = "bow",
			anim_end_event = "to_unzoom",
			min_speed = 6500,
			max_penetrations = 1,
			charge_value = "zoomed_arrow_hit",
			weapon_action_hand = "left",
			anim_event_last_ammo = "attack_shoot_last",
			minimum_hold_time = 0.3,
			ammo_usage = 1,
			fire_sound_event = "player_combat_weapon_shortbow_fire_heavy",
			hold_input = "action_two_hold",
			anim_event = "attack_shoot",
			total_time = 1.66,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.25,
					action = "action_one",
					release_required = "action_two_hold",
					end_time = 0.5,
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
				}
			},
			enter_function = function (attacker_unit, input_extension)
				input_extension.clear_input_buffer(input_extension)

				return input_extension.reset_release_input(input_extension)
			end,
			hit_effect = ARROW_HIT_EFFECT,
			projectile_info = Projectiles.carbine_arrow,
			alert_sound_range_fire = ALERT_SOUND_RANGE_FIRE,
			alert_sound_range_hit = ALERT_SOUND_RANGE_HIT
		}
	},
	action_two = {
		default = {
			anim_time_scale = 1.5,
			kind = "aim",
			aim_zoom_delay = 0.15,
			anim_end_event = "draw_cancel",
			aim_sound_delay = 0.3,
			aim_sound_event = "player_combat_weapon_bow_tighten_grip_loop",
			minimum_hold_time = 0.2,
			ammo_usage = 1,
			weapon_action_hand = "left",
			unaim_sound_event = "stop_player_combat_weapon_bow_tighten_grip_loop",
			charge_time = 0.5,
			hold_input = "action_two_hold",
			anim_event = "draw_bow",
			reload_when_out_of_ammo = true,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.8,
					buff_name = "planted_charging_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "shoot_charged",
					start_time = 0.65,
					action = "action_one",
					input = "action_one_mouse",
					end_time = math.huge
				},
				{
					softbutton_threshold = 0.75,
					start_time = 0.3,
					action = "action_one",
					sub_action = "shoot_charged",
					input = "action_one_softbutton_gamepad",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield",
					end_time = math.huge
				}
			},
			zoom_condition_function = function ()
				return true
			end,
			unzoom_condition_function = function (end_reason)
				return end_reason ~= "new_interupting_action"
			end
		}
	},
	action_inspect = ActionTemplates.action_inspect_left,
	action_wield = ActionTemplates.wield_left,
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
	ammo_per_reload = 1,
	ammo_unit = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1",
	ammo_hand = "left",
	ammo_per_clip = 1,
	ammo_unit_3p = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3p",
	max_ammo = 70,
	reload_on_ammo_pickup = true,
	reload_time = 0.2,
	ammo_unit_attachment_node_linking = AttachmentNodeLinking.arrow
}
weapon_template.attack_meta_data = {
	aim_at_node = "j_head",
	minimum_charge_time = 0.35,
	charged_attack_action_name = "shoot_charged",
	can_charge_shot = true,
	charge_above_range = 30,
	charge_when_obstructed = false,
	ignore_enemies_for_obstruction = true,
	charge_against_armoured_enemy = true
}
weapon_template.default_spread_template = "bow"
weapon_template.left_hand_unit = "units/weapons/player/wpn_we_bow_01_t1/wpn_we_bow_01_t1"
weapon_template.display_unit = "units/weapons/weapon_display/display_bow"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.bow
weapon_template.wield_anim = "to_bow"
weapon_template.wield_anim_no_ammo = "to_bow_noammo"
weapon_template.crosshair_style = "default"
weapon_template.no_ammo_reload_event = "reload"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.dodge_distance = 1.25
weapon_template.dodge_speed = 1.25
weapon_template.dodge_count = 4
weapon_template.wwise_dep_left_hand = {
	"wwise/bow"
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
			speed = 0.4,
			range = 0.6,
			damage = 0.5,
			targets = 0.2,
			stagger = 0.4
		}
	},
	perks = {
		light_attack = {
			"head_shot"
		},
		heavy_attack = {
			"head_shot"
		}
	}
}
Weapons = Weapons or {}
Weapons.shortbow_template_1 = table.clone(weapon_template)
Weapons.shortbow_template_1_co = table.clone(weapon_template)
Weapons.shortbow_template_1_co.compare_statistics.attacks.light_attack.damage = 0.275
Weapons.shortbow_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.55
Weapons.shortbow_template_1_t2 = table.clone(weapon_template)
Weapons.shortbow_template_1_t2.ammo_data.ammo_unit = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2"
Weapons.shortbow_template_1_t2.ammo_data.ammo_unit_3p = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3p"
Weapons.shortbow_template_1_t2.actions.action_one.default.projectile_info = Projectiles.machinegun_arrow_t2
Weapons.shortbow_template_1_t2.actions.action_one.shoot_charged.projectile_info = Projectiles.carbine_arrow_t2
Weapons.shortbow_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.3125
Weapons.shortbow_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.625
Weapons.shortbow_template_1_t3 = table.clone(weapon_template)
Weapons.shortbow_template_1_t3.ammo_data.ammo_unit = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3"
Weapons.shortbow_template_1_t3.ammo_data.ammo_unit_3p = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3p"
Weapons.shortbow_template_1_t3.actions.action_one.default.projectile_info = Projectiles.machinegun_arrow_t3
Weapons.shortbow_template_1_t3.actions.action_one.shoot_charged.projectile_info = Projectiles.carbine_arrow_t3
Weapons.shortbow_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.375
Weapons.shortbow_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.75

return 