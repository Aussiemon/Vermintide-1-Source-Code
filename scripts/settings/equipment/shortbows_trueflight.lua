local push_radius = 2
local weapon_template = weapon_template or {}
local ARROW_HIT_EFFECT = "arrow_impact"
local ALERT_SOUND_RANGE_FIRE = 4
local ALERT_SOUND_RANGE_HIT = 2
weapon_template.actions = {
	action_one = {
		default = {
			max_penetrations = 1,
			ammo_usage = 1,
			kind = "bow",
			apply_recoil = true,
			anim_event_last_ammo = "attack_shoot_fast_last",
			charge_value = "arrow_hit",
			weapon_action_hand = "left",
			fire_sound_event = "player_combat_weapon_shortbow_fire_light_homing",
			fire_reason = "action_complete",
			speed = 5000,
			anim_event = "attack_shoot_fast",
			total_time = 0.83,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.15,
					action = "action_one",
					release_required = "action_one_hold",
					input = "action_one",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_two",
					input = "action_two",
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
				input_extension:clear_input_buffer()

				return input_extension:reset_release_input()
			end,
			hit_effect = ARROW_HIT_EFFECT,
			projectile_info = Projectiles.machinegun_arrow,
			alert_sound_range_fire = ALERT_SOUND_RANGE_FIRE,
			alert_sound_range_hit = ALERT_SOUND_RANGE_HIT
		},
		shoot_charged = {
			anim_event_last_ammo = "attack_shoot_last",
			kind = "true_flight_bow",
			sphere_sweep_dot_threshold = 0.75,
			true_flight_template = "carbine",
			max_penetrations = 1,
			sphere_sweep_length = 50,
			ammo_usage = 1,
			sphere_sweep_radius = 2,
			charge_value = "zoomed_arrow_hit",
			weapon_action_hand = "left",
			fire_sound_event = "player_combat_weapon_shortbow_fire_heavy_homing",
			speed = 6000,
			sphere_sweep_max_nr_of_results = 100,
			anim_event = "attack_shoot",
			total_time = 1.66,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.66,
					action = "action_two",
					input = "action_two_hold",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0.66,
					action = "action_wield",
					input = "action_wield"
				}
			},
			hit_effect = ARROW_HIT_EFFECT,
			projectile_info = Projectiles.true_flight_carbine,
			alert_sound_range_fire = ALERT_SOUND_RANGE_FIRE,
			alert_sound_range_hit = ALERT_SOUND_RANGE_HIT
		}
	},
	action_two = {
		default = {
			allow_hold_toggle = true,
			ammo_usage = 1,
			anim_end_event = "draw_cancel",
			kind = "charge",
			reload_when_out_of_ammo = true,
			charge_time = 2,
			weapon_action_hand = "left",
			hold_input = "action_two_hold",
			anim_event = "draw_bow",
			minimum_hold_time = 0.2,
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
					sub_action = "aim",
					start_time = 0.5,
					action = "action_two",
					auto_chain = true
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					input = "action_wield",
					end_time = math.huge
				}
			},
			condition_func = function (unit, input_extension, ammo_extension)
				if ammo_extension and ammo_extension:total_remaining_ammo() <= 0 then
					return false
				end

				return true
			end
		},
		aim = {
			allow_hold_toggle = true,
			anim_end_event = "draw_cancel",
			kind = "true_flight_bow_aim",
			sphere_sweep_dot_threshold = 0.7,
			sphere_sweep_length = 50,
			sphere_sweep_max_nr_of_results = 100,
			weapon_action_hand = "left",
			hold_input = "action_two_hold",
			max_targets = 1,
			sphere_sweep_radius = 1.5,
			minimum_hold_time = 0.2,
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
					sub_action = "shoot_charged",
					start_time = 0.25,
					action = "action_one",
					input = "action_one",
					end_time = math.huge
				},
				{
					sub_action = "default",
					start_time = 0,
					action = "action_wield",
					end_time = 0.75,
					input = "action_wield"
				}
			}
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
	max_ammo = 42,
	reload_on_ammo_pickup = true,
	reload_time = 0.25,
	ammo_unit_attachment_node_linking = AttachmentNodeLinking.arrow
}
local action = weapon_template.actions.action_one.default
weapon_template.default_loaded_projectile_settings = {
	drop_multiplier = 0.03,
	speed = action.speed,
	gravity = ProjectileGravitySettings[action.projectile_info.gravity_settings]
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
weapon_template.default_projectile_action = weapon_template.actions.action_one.default
weapon_template.dodge_distance = 1.3
weapon_template.dodge_speed = 1.3
weapon_template.dodge_count = 100
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
Weapons.shortbows_trueflight_template_1 = table.clone(weapon_template)
Weapons.shortbows_trueflight_template_1_co = table.clone(weapon_template)
Weapons.shortbows_trueflight_template_1_co.compare_statistics.attacks.light_attack.damage = 0.275
Weapons.shortbows_trueflight_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.55
Weapons.shortbows_trueflight_template_1_t2 = table.clone(weapon_template)
Weapons.shortbows_trueflight_template_1_t2.actions.action_one.default.projectile_info = Projectiles.true_flight_machinegun_t2
Weapons.shortbows_trueflight_template_1_t2.actions.action_one.shoot_charged.projectile_info = Projectiles.true_flight_carbine_t2
Weapons.shortbows_trueflight_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.3125
Weapons.shortbows_trueflight_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.625
Weapons.shortbows_trueflight_template_1_t3 = table.clone(weapon_template)
Weapons.shortbows_trueflight_template_1_t3.actions.action_one.default.projectile_info = Projectiles.true_flight_machinegun_t3
Weapons.shortbows_trueflight_template_1_t3.actions.action_one.shoot_charged.projectile_info = Projectiles.true_flight_carbine_t3
Weapons.shortbows_trueflight_template_1_t3.compare_statistics.attacks.light_attack.damage = 0.375
Weapons.shortbows_trueflight_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 0.75

return
