local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			damage_window_end = 0.35,
			anim_event = "interaction_bandage_self",
			ammo_usage = 1,
			kind = "self_interaction",
			interaction_type = "heal",
			damage_window_start = 0.1,
			weapon_action_hand = "left",
			uninterruptible = true,
			hold_input = "action_one_hold",
			interaction_priority = 4,
			total_time = InteractionDefinitions.heal.config.duration,
			allowed_chain_actions = {},
			condition_func = function (attacker_unit)
				local interactor_extension = ScriptUnit.extension(attacker_unit, "interactor_system")

				return interactor_extension and interactor_extension.can_interact(interactor_extension, attacker_unit, "heal")
			end
		},
		push = {
			damage_window_start = 0.05,
			charge_value = "action_push",
			anim_end_event = "attack_finished",
			kind = "push_stagger",
			damage_window_end = 0.2,
			hit_effect = "melee_hit_slashing",
			attack_template = "basic_sweep_push",
			weapon_action_hand = "left",
			anim_event = "attack_push",
			total_time = 0.8,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					input = "action_two"
				},
				{
					sub_action = "default",
					start_time = 0.3,
					action = "action_wield",
					input = "action_wield"
				}
			},
			push_radius = push_radius,
			chain_condition_func = function (attacker_unit, input_extension)
				local status_extension = ScriptUnit.extension(attacker_unit, "status_system")

				return not status_extension.fatigued(status_extension)
			end
		}
	},
	action_two = {
		default = {
			cooldown = 0.15,
			minimum_hold_time = 0.3,
			anim_end_event = "parry_finished",
			kind = "block",
			weapon_action_hand = "left",
			hold_input = "action_two_hold",
			anim_event = "parry_pose",
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action"
			end,
			total_time = math.huge,
			enter_function = function (attacker_unit, input_extension)
				return input_extension.reset_release_input(input_extension)
			end,
			buff_data = {
				{
					start_time = 0,
					external_multiplier = 0.75,
					buff_name = "planted_decrease_movement"
				}
			},
			allowed_chain_actions = {
				{
					sub_action = "push",
					start_time = 0.1,
					action = "action_one",
					doubleclick_window = 0,
					input = "action_one",
					hold_required = {
						"action_two_hold"
					}
				},
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_wield",
					input = "action_wield"
				}
			}
		},
		bandage_team = {
			damage_window_end = 0.35,
			anim_event = "interaction_bandage_team",
			ammo_usage = 1,
			kind = "interaction",
			interaction_type = "heal",
			damage_window_start = 0.1,
			weapon_action_hand = "left",
			uninterruptible = true,
			hold_input = "action_two_hold",
			interaction_priority = 5,
			total_time = InteractionDefinitions.heal.config.duration,
			allowed_chain_actions = {},
			condition_func = function (attacker_unit)
				local interactor_extension = ScriptUnit.extension(attacker_unit, "interactor_system")

				return interactor_extension and interactor_extension.can_interact(interactor_extension, nil, "heal")
			end
		}
	},
	action_instant_heal_self = {
		default = {
			kind = "dummy",
			weapon_action_hand = "left",
			total_time = 0,
			allowed_chain_actions = {}
		},
		instant_heal = {
			damage_window_end = 0.35,
			anim_event = "interaction_bandage_self",
			ammo_usage = 1,
			kind = "self_interaction",
			interaction_type = "heal",
			damage_window_start = 0.1,
			weapon_action_hand = "left",
			hold_input = "action_instant_heal_self_hold",
			interaction_priority = 2,
			total_time = InteractionDefinitions.heal.config.duration,
			allowed_chain_actions = {},
			condition_func = function (attacker_unit)
				local interactor_extension = ScriptUnit.extension(attacker_unit, "interactor_system")

				return interactor_extension and interactor_extension.can_interact(interactor_extension, attacker_unit, "heal")
			end
		}
	},
	action_instant_heal_other = {
		default = {
			kind = "dummy",
			weapon_action_hand = "left",
			total_time = 0,
			allowed_chain_actions = {}
		},
		instant_heal = {
			damage_window_end = 0.35,
			anim_event = "interaction_bandage_team",
			ammo_usage = 1,
			kind = "interaction",
			interaction_type = "heal",
			damage_window_start = 0.1,
			weapon_action_hand = "left",
			hold_input = "action_instant_heal_other_hold",
			interaction_priority = 3,
			total_time = InteractionDefinitions.heal.config.duration,
			allowed_chain_actions = {},
			condition_func = function (attacker_unit)
				local interactor_extension = ScriptUnit.extension(attacker_unit, "interactor_system")

				return interactor_extension and interactor_extension.can_interact(interactor_extension, nil, "heal")
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
	ammo_hand = "left",
	destroy_when_out_of_ammo = true,
	max_ammo = 1,
	ammo_per_clip = 1,
	reload_time = 0,
	ignore_ammo_pickup = true
}
weapon_template.pickup_data = {
	pickup_name = "first_aid_kit"
}
weapon_template.left_hand_unit = "units/weapons/player/wpn_first_aid_kit/wpn_first_aid_kit"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.left
weapon_template.wield_anim = "to_first_aid"
weapon_template.gui_texture = "hud_teammate_consumable_icon_medkit"
weapon_template.max_fatigue_points = 4
weapon_template.can_heal_other = true
weapon_template.can_heal_self = true
weapon_template.bot_heal_threshold = 0.2
weapon_template.fast_heal = false
weapon_template.max_fatigue_points = 1
weapon_template.dodge_distance = 1.2
weapon_template.dodge_speed = 1.2
weapon_template.dodge_count = 3
Weapons = Weapons or {}
Weapons.first_aid_kit = Weapons.first_aid_kit or table.clone(weapon_template)
Weapons.first_aid_kit.left_hand_unit = "units/weapons/player/wpn_first_aid_kit/wpn_first_aid_kit"
Weapons.first_aid_kit.gui_texture = "hud_teammate_consumable_icon_medkit"
Weapons.first_aid_kit_02 = Weapons.first_aid_kit_02 or table.clone(weapon_template)
Weapons.first_aid_kit_02.left_hand_unit = "units/weapons/player/wpn_first_aid_kit_02/wpn_first_aid_kit_02"
Weapons.first_aid_kit_02.gui_texture = "hud_teammate_consumable_icon_medkit"
Weapons.healthkit = weapon_template

return 
