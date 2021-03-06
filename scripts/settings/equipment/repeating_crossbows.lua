local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			anim_event = "attack_shoot",
			kind = "crossbow",
			ammo_usage = 1,
			max_penetrations = 1,
			anim_event_no_ammo_left = "attack_shoot_last",
			weapon_action_hand = "left",
			speed = 8000,
			alert_sound_range_fire = 4,
			alert_sound_range_hit = 2,
			charge_value = "arrow_hit",
			hit_effect = "arrow_impact",
			anim_event_last_ammo = "attack_shoot_last",
			reload_when_out_of_ammo = true,
			total_time = 0.75,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_one",
					input = "action_one_hold"
				},
				{
					sub_action = "default",
					start_time = 0.6,
					action = "action_two",
					input = "action_two_hold"
				},
				{
					sub_action = "default",
					start_time = 0.2,
					action = "action_wield",
					input = "action_wield"
				}
			},
			projectile_info = Projectiles.repeating_crossbow_bolt
		},
		zoomed_shot = {
			kind = "crossbow",
			weapon_action_hand = "left",
			alert_sound_range_fire = 4,
			multi_projectile_spread = 0.045,
			anim_event_no_ammo_left = "attack_shoot",
			alert_sound_range_hit = 2,
			spread_template_override = "repeating_crossbow_3bolt",
			charge_value = "zoomed_arrow_hit",
			reload_when_out_of_ammo = true,
			hit_effect = "arrow_impact",
			anim_event_last_ammo = "attack_shoot",
			minimum_hold_time = 0.5,
			ammo_usage = 1,
			anim_end_event = "to_unzoom",
			num_projectiles = 3,
			speed = 8000,
			hold_input = "action_two_hold",
			anim_event = "attack_shoot",
			total_time = 1.25,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			allowed_chain_actions = {
				{
					sub_action = "zoomed_shot",
					start_time = 0.5,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.5,
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
			projectile_info = Projectiles.repeating_crossbow_bolt
		},
		zoom_cancel = {
			kind = "dummy",
			weapon_action_hand = "left",
			total_time = 0,
			allowed_chain_actions = {}
		}
	},
	action_two = {
		default = {
			weapon_action_hand = "left",
			default_zoom = "first_person_node",
			anim_end_event = "to_unzoom",
			kind = "aim",
			can_abort_reload = false,
			cooldown = 0.3,
			spread_template_override = "repeating_crossbow_3bolt",
			aim_sound_delay = 0.2,
			ammo_requirement = 1,
			minimum_hold_time = 0.15,
			hold_input = "action_two_hold",
			anim_event = "to_zoom",
			allow_hold_toggle = true,
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
					sub_action = "zoomed_shot",
					start_time = 0.3,
					action = "action_one",
					input = "action_one"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			zoom_condition_function = function ()
				return true
			end,
			unzoom_condition_function = function (end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			condition_func = function (unit, input_extension, ammo_extension)
				if ammo_extension and ammo_extension:total_remaining_ammo() <= 0 then
					return false
				end

				return true
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
	max_ammo = 45,
	ammo_per_reload = 15,
	ammo_unit = "units/weapons/player/wpn_crossbow_quiver_pile/wpn_crossbow_bolt_pile",
	ammo_per_clip = 15,
	ammo_hand = "left",
	play_reload_anim_on_wield_reload = true,
	destroy_when_out_of_ammo = false,
	reload_on_ammo_pickup = false,
	reload_time = 5,
	ammo_unit_attachment_node_linking = AttachmentNodeLinking.repeating_bolt
}
weapon_template.attack_meta_data = {
	aim_at_node = "j_spine",
	charged_attack_action_name = "zoomed_shot",
	ignore_enemies_for_obstruction_charged = true,
	can_charge_shot = true,
	aim_at_node_charged = "j_head",
	minimum_charge_time = 0.45,
	charge_above_range = 10,
	charge_when_obstructed = false,
	ignore_enemies_for_obstruction = false
}
local action = weapon_template.actions.action_one.default
weapon_template.default_loaded_projectile_settings = {
	drop_multiplier = 0.03,
	speed = action.speed,
	gravity = ProjectileGravitySettings[action.projectile_info.gravity_settings]
}
weapon_template.default_spread_template = "crossbow"
weapon_template.spread_lerp_speed = 2
weapon_template.left_hand_unit = ""
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.repeating_crossbow
weapon_template.display_unit = "units/weapons/weapon_display/display_rifle"
weapon_template.wield_anim = "to_repeating_crossbow"
weapon_template.wield_anim_no_ammo = "to_repeating_crossbow_noammo"
weapon_template.wield_anim_not_loaded = "to_repeating_crossbow"
weapon_template.crosshair_style = "default"
weapon_template.reload_event = "reload"
weapon_template.buff_type = BuffTypes.RANGED
weapon_template.dodge_distance = 1
weapon_template.dodge_speed = 1
weapon_template.dodge_count = 1
weapon_template.wwise_dep_left_hand = {
	"wwise/repeating_crossbow"
}
weapon_template.compare_statistics = {
	attacks = {
		light_attack = {
			speed = 0.2,
			range = 0.8,
			damage = 0.75,
			targets = 0.4,
			stagger = 0.6
		},
		heavy_attack = {
			speed = 0.2,
			range = 0.9,
			damage = 0.75,
			targets = 0.4,
			stagger = 0.6
		}
	},
	perks = {
		light_attack = {
			"head_shot",
			"armor_penetration"
		},
		heavy_attack = {
			"head_shot",
			"armor_penetration"
		}
	}
}
Weapons = Weapons or {}
Weapons.repeating_crossbow_template_1 = table.create_copy(Weapons.repeating_crossbow_template_1, weapon_template)
Weapons.repeating_crossbow_template_1_co = table.create_copy(Weapons.repeating_crossbow_template_1_co, weapon_template)
Weapons.repeating_crossbow_template_1_co.compare_statistics.attacks.light_attack.damage = 0.825
Weapons.repeating_crossbow_template_1_co.compare_statistics.attacks.heavy_attack.damage = 0.825
Weapons.repeating_crossbow_template_1_t2 = table.create_copy(Weapons.repeating_crossbow_template_1_t2, weapon_template)
Weapons.repeating_crossbow_template_1_t2.actions.action_one.default.projectile_info = Projectiles.repeating_crossbow_bolt_t2
Weapons.repeating_crossbow_template_1_t2.actions.action_one.zoomed_shot.projectile_info = Projectiles.repeating_crossbow_bolt_t2
Weapons.repeating_crossbow_template_1_t2.compare_statistics.attacks.light_attack.damage = 0.875
Weapons.repeating_crossbow_template_1_t2.compare_statistics.attacks.heavy_attack.damage = 0.875
Weapons.repeating_crossbow_template_1_t3 = table.create_copy(Weapons.repeating_crossbow_template_1_t3, weapon_template)
Weapons.repeating_crossbow_template_1_t3.actions.action_one.default.projectile_info = Projectiles.repeating_crossbow_bolt_t3
Weapons.repeating_crossbow_template_1_t3.actions.action_one.zoomed_shot.projectile_info = Projectiles.repeating_crossbow_bolt_t3
Weapons.repeating_crossbow_template_1_t3.compare_statistics.attacks.light_attack.damage = 1
Weapons.repeating_crossbow_template_1_t3.compare_statistics.attacks.heavy_attack.damage = 1

return
