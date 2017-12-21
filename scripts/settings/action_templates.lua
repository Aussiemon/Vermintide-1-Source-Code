ActionTemplates = ActionTemplates or {}
ActionTemplates.wield = {
	default = {
		wield_cooldown = 0.35,
		kind = "wield",
		keep_buffer = true,
		total_time = 0,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")

			return inventory_extension.can_wield(inventory_extension)
		end,
		chain_condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")

			return inventory_extension.can_wield(inventory_extension)
		end,
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_equip_and_heal_self = {
	default = {
		slot_to_wield = "slot_healthkit",
		weapon_action_hand = "either",
		kind = "instant_wield",
		total_time = 1,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")
			local equipment = inventory_extension._equipment
			local heal_item_equipped = equipment.slots.slot_healthkit
			local health_extension = ScriptUnit.extension(action_user, "health_system")
			local status_extension = ScriptUnit.extension(action_user, "status_system")
			local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)
			local has_max_health = health_extension.current_health_percent(health_extension) == 1
			local can_use_heal_item = is_alive and not has_max_health

			return heal_item_equipped and can_use_heal_item
		end,
		action_on_wield = {
			action = "action_instant_heal_self",
			sub_action = "default"
		},
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_equip_and_drink_potion = {
	default = {
		slot_to_wield = "slot_potion",
		weapon_action_hand = "either",
		kind = "instant_wield",
		total_time = 1,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")
			local equipment = inventory_extension._equipment
			local potion_equipped = equipment.slots.slot_potion

			if potion_equipped and potion_equipped.item_data.name == "wpn_grimoire_01" then
				return false
			end

			local health_extension = ScriptUnit.extension(action_user, "health_system")
			local status_extension = ScriptUnit.extension(action_user, "status_system")
			local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)
			local can_use_heal_item = is_alive

			return potion_equipped and can_use_heal_item
		end,
		action_on_wield = {
			action = "action_instant_drink_potion",
			sub_action = "instant_drink"
		},
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_equip_and_heal_other = {
	default = {
		slot_to_wield = "slot_healthkit",
		weapon_action_hand = "either",
		kind = "instant_wield",
		total_time = 1,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")
			local equipment = inventory_extension._equipment
			local heal_item_equipped = equipment.slots.slot_healthkit
			local interactor_extension = ScriptUnit.extension(action_user, "interactor_system")
			local can_heal = interactor_extension and interactor_extension.can_interact(interactor_extension, nil, "heal")
			local health_extension = ScriptUnit.extension(action_user, "health_system")
			local status_extension = ScriptUnit.extension(action_user, "status_system")
			local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)

			return heal_item_equipped and can_heal and is_alive
		end,
		action_on_wield = {
			action = "action_instant_heal_other",
			sub_action = "default"
		},
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_equip_grenade = {
	default = {
		slot_to_wield = "slot_grenade",
		weapon_action_hand = "either",
		kind = "instant_wield",
		total_time = 0,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")
			local equipment = inventory_extension._equipment
			local grenade_equipped = equipment.slots.slot_grenade
			local health_extension = ScriptUnit.extension(action_user, "health_system")
			local status_extension = ScriptUnit.extension(action_user, "status_system")
			local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)

			return grenade_equipped and is_alive
		end,
		action_on_wield = {
			action = "action_instant_grenade_throw",
			sub_action = "default"
		},
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_equip_grenade_only = {
	default = {
		slot_to_wield = "slot_grenade",
		weapon_action_hand = "either",
		kind = "instant_wield",
		total_time = 0,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")
			local equipment = inventory_extension._equipment
			local grenade_equipped = equipment.slots.slot_grenade
			local health_extension = ScriptUnit.extension(action_user, "health_system")
			local status_extension = ScriptUnit.extension(action_user, "status_system")
			local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)

			return grenade_equipped and is_alive
		end,
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_equip_and_drink_healing_draught = {
	default = {
		slot_to_wield = "slot_healthkit",
		weapon_action_hand = "either",
		kind = "instant_wield",
		total_time = 0,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")
			local equipment = inventory_extension._equipment
			local slot_healthkit_data = equipment.slots.slot_healthkit
			local has_healing_draught = false

			if slot_healthkit_data and slot_healthkit_data.item_data.name == "potion_healing_draught_01" then
				has_healing_draught = true
			end

			local health_extension = ScriptUnit.extension(action_user, "health_system")
			local status_extension = ScriptUnit.extension(action_user, "status_system")
			local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)
			local has_max_health = health_extension.current_health_percent(health_extension) == 1
			local can_use_heal_item = is_alive and not has_max_health

			return has_healing_draught and can_use_heal_item
		end,
		action_on_wield = {
			action = "action_instant_drink_healing_draught",
			sub_action = "instant_drink"
		},
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_equip_tome = {
	default = {
		slot_to_wield = "slot_healthkit",
		weapon_action_hand = "either",
		kind = "instant_wield",
		total_time = 0,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")
			local wielded_slot = inventory_extension.get_wielded_slot_name(inventory_extension)

			if wielded_slot == "slot_healthkit" then
				return 
			end

			local has_tome = false
			local equipment = inventory_extension.equipment(inventory_extension)
			local slot_healthkit_data = equipment.slots.slot_healthkit

			if slot_healthkit_data and slot_healthkit_data.item_data.name == "wpn_side_objective_tome_01" then
				has_tome = true
			end

			local health_extension = ScriptUnit.extension(action_user, "health_system")
			local status_extension = ScriptUnit.extension(action_user, "status_system")
			local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)

			return has_tome and is_alive
		end,
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_equip_grimoire = {
	default = {
		slot_to_wield = "slot_potion",
		weapon_action_hand = "either",
		kind = "instant_wield",
		total_time = 0,
		condition_func = function (action_user, input_extension)
			local inventory_extension = ScriptUnit.extension(action_user, "inventory_system")
			local wielded_slot = inventory_extension.get_wielded_slot_name(inventory_extension)

			if wielded_slot == "slot_potion" then
				return 
			end

			local has_grimoire = false
			local equipment = inventory_extension.equipment(inventory_extension)
			local slot_potion_data = equipment.slots.slot_potion

			if slot_potion_data and slot_potion_data.item_data.name == "wpn_grimoire_01" then
				has_grimoire = true
			end

			local health_extension = ScriptUnit.extension(action_user, "health_system")
			local status_extension = ScriptUnit.extension(action_user, "status_system")
			local is_alive = health_extension.is_alive(health_extension) and not status_extension.is_disabled(status_extension)

			return has_grimoire and is_alive
		end,
		allowed_chain_actions = {}
	}
}
ActionTemplates.instant_grenade_throw = {
	default = {
		weapon_action_hand = "right",
		hold_input = "action_instant_grenade_throw_hold",
		kind = "dummy",
		total_time = 0,
		allowed_chain_actions = {
			{
				sub_action = "grenade_charge",
				start_time = 0,
				action = "action_instant_grenade_throw",
				auto_chain = true
			}
		},
		condition_func = function ()
			return true
		end
	},
	grenade_charge = {
		charge_sound_stop_event = "stop_player_combat_weapon_grenade_ignite_loop",
		explode_time = 3.5,
		ammo_usage = 1,
		anim_end_event = "attack_finished",
		kind = "charge",
		charge_sound_name = "player_combat_weapon_grenade_ignite_loop",
		charge_time = 1,
		minimum_hold_time = 1.1,
		block_pickup = true,
		anim_event = "grenade_charge",
		anim_end_event_condition_func = function (unit, end_reason)
			return end_reason ~= "new_interupting_action" and end_reason ~= "action_complete"
		end,
		total_time = math.huge,
		allowed_chain_actions = {
			{
				sub_action = "throw",
				start_time = 1,
				action = "action_one",
				input = "action_instant_grenade_throw_released"
			},
			{
				sub_action = "cancel",
				start_time = 0.55,
				action = "action_one",
				input = "action_two"
			},
			{
				start_time = 0,
				input = "action_instant_grenade_throw_hold"
			},
			{
				sub_action = "throw",
				start_time = 1.1,
				action = "action_one",
				auto_chain = true
			}
		}
	}
}
ActionTemplates.action_inspect = {
	default = {
		minimum_hold_time = 0.3,
		kind = "dummy",
		anim_end_event = "inspect_end",
		cooldown = 0.15,
		can_abort_reload = false,
		hold_input = "action_inspect_hold",
		anim_event = "inspect_start",
		anim_end_event_condition_func = function (unit, end_reason)
			return end_reason ~= "new_interupting_action"
		end,
		condition_func = function (action_user, input_extension)
			if Managers.input:is_device_active("gamepad") then
				if Managers.state.game_mode:level_key() == "inn_level" then
					return true
				else
					return false
				end
			else
				return true
			end

			return 
		end,
		total_time = math.huge,
		allowed_chain_actions = {}
	}
}
ActionTemplates.wield_left = table.clone(ActionTemplates.wield)
ActionTemplates.wield_left.default.weapon_action_hand = "left"
ActionTemplates.action_inspect_left = table.clone(ActionTemplates.action_inspect)
ActionTemplates.action_inspect_left.default.weapon_action_hand = "left"

return 
