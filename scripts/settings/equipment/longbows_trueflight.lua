local push_radius = 2
local ARROW_HIT_EFFECT = "arrow_impact"
local ALERT_SOUND_RANGE_FIRE = 4
local ALERT_SOUND_RANGE_HIT = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			attack_template_damage_type = "machinegun",
			max_speed = 8000,
			max_penetrations = 1,
			fire_reason = "action_complete",
			min_speed = 5000,
			kind = "bow",
			sphere_sweep_dot_threshold = 0.75,
			attack_template = "arrow_machinegun",
			charge_value = "arrow_hit",
			anim_event_last_ammo = "attack_shoot_fast_last",
			weapon_action_hand = "left",
			true_flight_template = "machinegun",
			sphere_sweep_radius = 2,
			sphere_sweep_length = 50,
			ammo_usage = 1,
			fire_sound_event = "player_combat_weapon_bow_fire_light_homing",
			apply_recoil = true,
			sphere_sweep_max_nr_of_results = 100,
			anim_event = "attack_shoot_fast",
			total_time = 0.83,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.5,
					end_time = 0.3,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two_hold",
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
			projectile_info = Projectiles.carbine_arrow,
			alert_sound_range_fire = ALERT_SOUND_RANGE_FIRE,
			alert_sound_range_hit = ALERT_SOUND_RANGE_HIT
		},
		shoot_charged = {
			attack_template_damage_type = "carbine",
			max_speed = 8000,
			attack_template = "arrow_carbine",
			kind = "true_flight_bow",
			min_speed = 5000,
			max_penetrations = 1,
			sphere_sweep_dot_threshold = 0.5,
			charge_value = "zoomed_arrow_hit",
			weapon_action_hand = "left",
			anim_event_last_ammo = "attack_shoot_last",
			true_flight_template = "sniper",
			minimum_hold_time = 0.5,
			sphere_sweep_radius = 2,
			sphere_sweep_length = 50,
			ammo_usage = 1,
			fire_time = 0.15,
			sphere_sweep_max_nr_of_results = 100,
			fire_sound_event = "player_combat_weapon_bow_fire_heavy_homing",
			hold_input = "action_two_hold",
			anim_event = "attack_shoot",
			allow_hold_toggle = true,
			total_time = 1.66,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_one",
					release_required = "action_two_hold",
					end_time = 0.66,
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.66,
					action = "action_two",
					input = "action_two_hold",
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
			projectile_info = Projectiles.true_flight_sniper,
			alert_sound_range_fire = ALERT_SOUND_RANGE_FIRE,
			alert_sound_range_hit = ALERT_SOUND_RANGE_HIT
		}
	},
	action_two = {
		default = {
			anim_event = "draw_bow",
			default_zoom = "zoom_in_trueflight",
			anim_end_event = "draw_cancel",
			kind = "true_flight_bow_aim",
			sphere_sweep_dot_threshold = 0.7,
			sphere_sweep_length = 100,
			sphere_sweep_max_nr_of_results = 100,
			aim_sound_delay = 0.5,
			aim_sound_event = "player_combat_weapon_bow_tighten_grip_loop",
			weapon_action_hand = "left",
			sphere_sweep_radius = 1.5,
			minimum_hold_time = 0.2,
			aim_zoom_delay = 0.25,
			ammo_usage = 1,
			unaim_sound_event = "stop_player_combat_weapon_bow_tighten_grip_loop",
			hold_input = "action_two_hold",
			max_targets = 1,
			allow_hold_toggle = true,
			reload_when_out_of_ammo = true,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			buffed_zoom_thresholds = {
				"zoom_in_trueflight",
				"zoom_in",
				"increased_zoom_in"
			},
			zoom_thresholds = {
				"zoom_in_trueflight",
				"zoom_in"
			},
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.25,
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
					start_time = 0.5,
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
	ammo_unit = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1",
	ammo_hand = "left",
	ammo_per_clip = 1,
	ammo_unit_3p = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p",
	max_ammo = 30,
	reload_on_ammo_pickup = true,
	reload_time = 0.4,
	ammo_unit_attachment_node_linking = AttachmentNodeLinking.arrow
}
weapon_template.default_spread_template = "longbow"
weapon_template.left_hand_unit = "units/weapons/player/wpn_we_bow_01_t1/wpn_we_bow_01_t1"
weapon_template.display_unit = "units/weapons/weapon_display/display_bow"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.bow
weapon_template.wield_anim = "to_longbow"
weapon_template.wield_anim_no_ammo = "to_bow_noammo"
weapon_template.crosshair_style = "default"
weapon_template.no_ammo_reload_event = "reload"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.wwise_dep_left_hand = {
	"wwise/bow"
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.6,
			range = 0.6,
			damage = 0.5,
			targets = 0.2,
			stagger = 0.4
		},
		heavy_attack = {
			speed = 0.4,
			range = 0.8,
			damage = 0.75,
			targets = 0.4,
			stagger = 0.6
		}
	},
	perks = {
		light_attack = {
			"head_shot"
		},
		heavy_attack = {
			"head_shot",
			"armor_penetration"
		}
	}
}
Weapons = Weapons or {}
Weapons.longbow_trueflight_template_1 = table.clone(weapon_template)
Weapons.longbow_trueflight_template_1_co = table.clone(weapon_template)
Weapons.longbow_trueflight_template_1_co.compare_statistics.attacks.light_attack.damage = 0.55
Weapons.longbow_trueflight_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.825
Weapons.longbow_trueflight_template_1_t2 = table.clone(weapon_template)
Weapons.longbow_trueflight_template_1_t2.actions.action_one.default.projectile_info = Projectiles.true_flight_carbine_t2
Weapons.longbow_trueflight_template_1_t2.actions.action_one.shoot_charged.projectile_info = Projectiles.true_flight_sniper_t2
Weapons.longbow_trueflight_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.625
Weapons.longbow_trueflight_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.875
Weapons.longbow_trueflight_template_1_t3 = table.clone(weapon_template)
Weapons.longbow_trueflight_template_1_t3.actions.action_one.default.projectile_info = Projectiles.true_flight_carbine_t3
Weapons.longbow_trueflight_template_1_t3.actions.action_one.shoot_charged.projectile_info = Projectiles.true_flight_sniper_t3
Weapons.longbow_trueflight_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.75
Weapons.longbow_trueflight_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 1

return 
