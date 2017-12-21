local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			kind = "throw_grimoire",
			ammo_usage = 1,
			anim_end_event = "attack_finished",
			anim_event = "attack_throw",
			weapon_action_hand = "left",
			total_time = 0.7,
			anim_end_event_condition_func = function (unit, end_reason)
				return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
			end,
			allowed_chain_actions = {}
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
	reload_time = 0
}
weapon_template.left_hand_unit = "units/weapons/player/wpn_grimoire_01/wpn_grimoire_01"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.one_handed_melee_weapon.left
weapon_template.wield_anim = "to_first_aid"
weapon_template.gui_texture = "icons_placeholder_melee_01"
weapon_template.is_grimoire = true
Weapons = Weapons or {}
Weapons.wpn_grimoire_01 = weapon_template
Weapons.wpn_side_objective_tome_01 = table.clone(weapon_template)
Weapons.wpn_side_objective_tome_01.left_hand_unit = "units/weapons/player/wpn_side_objective_tome/wpn_side_objective_tome_01"
Weapons.wpn_side_objective_tome_01.actions = {
	action_one = {
		default = {
			kind = "dummy",
			weapon_action_hand = "left",
			total_time = 0,
			allowed_chain_actions = {}
		},
		push = {
			damage_window_end = 0.2,
			push_radius = 2,
			charge_value = "action_push",
			kind = "push_stagger",
			damage_window_start = 0.05,
			attack_template = "basic_sweep_push",
			anim_event = "attack_push",
			weapon_action_hand = "left",
			hit_effect = "melee_hit_slashing",
			total_time = 0.8,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.4,
					action = "action_two",
					end_time = 0.7,
					input = "action_two"
				}
			},
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
			allowed_chain_actions = {
				{
					sub_action = "push",
					start_time = 0.1,
					action = "action_one",
					input = "action_one"
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
Weapons.wpn_side_objective_tome_01.pickup_data = {
	pickup_name = "tome"
}

return 
