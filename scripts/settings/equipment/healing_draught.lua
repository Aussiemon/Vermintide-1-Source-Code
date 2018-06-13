local push_radius = 2
local weapon_template = weapon_template or {}
weapon_template.actions = {
	action_one = {
		default = {
			damage_window_end = 0.2,
			ammo_usage = 1,
			anim_end_event = "attack_finished",
			kind = "healing_draught",
			damage_window_start = 0.05,
			weapon_action_hand = "left",
			block_pickup = true,
			dialogue_event = "on_healing_draught",
			anim_event = "attack_heal",
			total_time = 1.2,
			allowed_chain_actions = {},
			condition_func = function (user_unit)
				local heal_extension = ScriptUnit.extension(user_unit, "health_system")

				return heal_extension.damage > 0
			end,
			chain_condition_func = function (user_unit)
				local heal_extension = ScriptUnit.extension(user_unit, "health_system")

				return heal_extension.damage > 0
			end
		}
	},
	action_two = {
		default = {
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
					action = "action_one",
					end_time = 0.7,
					input = "action_one"
				}
			},
			push_radius = push_radius,
			condition_func = function (attacker_unit, input_extension)
				local status_extension = ScriptUnit.extension(attacker_unit, "status_system")

				return not status_extension:fatigued()
			end
		},
		give_item = ActionTemplates.give_item_on_defend
	},
	action_instant_drink_healing_draught = {
		default = {
			kind = "dummy",
			weapon_action_hand = "left",
			total_time = 0,
			allowed_chain_actions = {}
		},
		instant_drink = {
			damage_window_end = 0.2,
			ammo_usage = 1,
			anim_end_event = "attack_finished",
			kind = "healing_draught",
			damage_window_start = 0.05,
			weapon_action_hand = "left",
			block_pickup = true,
			uninterruptible = true,
			dialogue_event = "on_healing_draught",
			anim_event = "attack_heal",
			auto_validate_on_gamepad = true,
			total_time = 1.2,
			allowed_chain_actions = {},
			condition_func = function (user_unit)
				local heal_extension = ScriptUnit.extension(user_unit, "health_system")

				return heal_extension.damage > 0
			end,
			chain_condition_func = function (user_unit)
				local heal_extension = ScriptUnit.extension(user_unit, "health_system")

				return heal_extension.damage > 0
			end
		}
	},
	action_instant_give_item = ActionTemplates.instant_give_item,
	action_inspect = ActionTemplates.action_inspect_left,
	action_wield = ActionTemplates.wield_left,
	action_instant_grenade_throw = ActionTemplates.instant_equip_grenade,
	action_instant_heal_self = ActionTemplates.instant_equip_and_heal_self,
	action_instant_heal_other = ActionTemplates.instant_equip_and_heal_other,
	action_instant_drink_potion = ActionTemplates.instant_equip_and_drink_potion,
	action_instant_equip_tome = ActionTemplates.instant_equip_tome,
	action_instant_equip_grimoire = ActionTemplates.instant_equip_grimoire,
	action_instant_equip_grenade = ActionTemplates.instant_equip_grenade_only,
	action_instant_equip_healing_draught = ActionTemplates.instant_equip_and_drink_healing_draught,
	action_instant_heal_self = {
		default = {
			kind = "dummy",
			weapon_action_hand = "left",
			total_time = 1,
			allowed_chain_actions = {
				{
					sub_action = "default",
					start_time = 0.5,
					action = "action_one",
					auto_chain = true
				}
			}
		}
	}
}
weapon_template.ammo_data = {
	ammo_hand = "left",
	destroy_when_out_of_ammo = true,
	max_ammo = 1,
	ammo_per_clip = 1,
	reload_time = 0
}
weapon_template.pickup_data = {
	pickup_name = "healing_draught"
}
weapon_template.left_hand_unit = "units/weapons/player/wpn_potion/wpn_potion"
weapon_template.left_hand_attachment_node_linking = AttachmentNodeLinking.potion
weapon_template.wield_anim = "to_potion"
weapon_template.gui_texture = "hud_consumable_icon_potion"
weapon_template.max_fatigue_points = 1
weapon_template.can_heal_self = true
weapon_template.fast_heal = true
weapon_template.can_give_other = true
weapon_template.bot_heal_threshold = 0.5
Weapons.healing_draught = Weapons.healing_draught or table.clone(weapon_template)

return
