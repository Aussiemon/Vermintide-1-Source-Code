local function apply_outline(unit)
	return 
end

local function has_melee_weapon_equipped(unit)
	local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
	local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
	local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)

	if slot_data == nil then
		return false
	end

	local right_unit_1p = slot_data.right_unit_1p

	if ScriptUnit.has_extension(right_unit_1p, "ammo_system") then
		return false
	end

	return true
end

local POSITION_LOOKUP = POSITION_LOOKUP
TutorialTemplates = {
	core_block = {
		incompatible_in_game = true,
		priority = 8,
		text = "tutorial_tooltip_core_block",
		do_not_verify = true,
		needed_points = 0,
		display_type = "tooltip",
		inputs = {
			{
				suffix = "",
				prefix = "input_hold",
				action = "action_two"
			}
		},
		init_data = function (data)
			data.core_block_count = data.core_block_count or 0

			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit)
			if raycast_unit == nil or not Unit.alive(raycast_unit) then
				return false
			end

			local breed = Unit.get_data(raycast_unit, "breed")

			if breed == nil then
				return false
			end

			local health_extension = ScriptUnit.extension(unit, "health_system")

			if 0.5 < health_extension.current_health_percent(health_extension) then
				return false
			end

			local max_dist_sq = 16
			local distance_sq = Vector3.distance_squared(POSITION_LOOKUP[unit], POSITION_LOOKUP[raycast_unit])

			if max_dist_sq < distance_sq then
				return false
			end

			return true
		end,
		is_completed = function (t, start_t, unit, data)
			if data.core_block_count < 3 then
				return false
			end

			if start_t + 3 < t then
				return true
			end

			return 
		end
	},
	core_knocked_down = {
		needed_points = 0,
		text = "tutorial_infoslate_core_knocked_down",
		display_type = "info_slate",
		icon = "hud_tutorial_icon_attention",
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit)
			local in_brawl_mode = Managers.state.game_mode:level_key() == "inn_level"

			if in_brawl_mode then
				return false
			end

			local status_extension = ScriptUnit.extension(unit, "status_system")

			if status_extension.is_knocked_down(status_extension) then
				return true
			end

			return 
		end,
		is_completed = function (t, start_t, unit, data)
			return 
		end
	},
	core_needs_help = {
		priority = 50,
		action = "interact",
		needed_points = 0,
		text = "player_in_need_of_help",
		display_type = "tooltip",
		icon = "hud_tutorial_icon_attention",
		is_mission_tutorial = true,
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit)
			local players = Managers.player:human_and_bot_players()
			local unit_position = POSITION_LOOKUP[unit]
			local best_distance_sq = math.huge
			local best_unit_position, has_raycast_unit, raycast_unit_pos, raycast_unit_dist = nil

			for k, player in pairs(players) do
				local player_unit = player.player_unit

				if Unit.alive(player_unit) and unit ~= player_unit then
					local status_extension = ScriptUnit.extension(player_unit, "status_system")

					if status_extension.is_pounced_down(status_extension) or status_extension.get_is_ledge_hanging(status_extension) or status_extension.is_grabbed_by_pack_master(status_extension) then
						local player_position = POSITION_LOOKUP[player_unit]
						local distance_sq = Vector3.distance_squared(unit_position, player_position)

						if player_unit == raycast_unit then
							has_raycast_unit = true
							raycast_unit_pos = player_position
							raycast_unit_dist = distance_sq
						end

						if distance_sq < best_distance_sq then
							best_distance_sq = distance_sq
							best_unit_position = player_position
						end
					end
				end
			end

			if has_raycast_unit and raycast_unit_dist < 400 then
				return true, raycast_unit_pos
			elseif best_unit_position then
				return true, best_unit_position
			end

			return false
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	core_ammo_low = {
		needed_points = 0,
		text = "tutorial_infoslate_core_ammo_low",
		display_type = "info_slate",
		icon = "hud_tutorial_icon_attention",
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)

			if slot_name ~= "slot_ranged" then
				return false
			end

			local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)

			if slot_data == nil then
				return false
			end

			local ammo_unit = nil
			local right_unit_1p = slot_data.right_unit_1p
			local left_unit_1p = slot_data.left_unit_1p
			local left_ammo_unit_1p = slot_data.left_ammo_unit_1p
			local right_ammo_unit_1p = slot_data.right_ammo_unit_1p

			if right_unit_1p and ScriptUnit.has_extension(right_unit_1p, "ammo_system") then
				ammo_unit = right_unit_1p
			elseif left_unit_1p and ScriptUnit.has_extension(left_unit_1p, "ammo_system") then
				ammo_unit = left_unit_1p
			elseif left_ammo_unit_1p and ScriptUnit.has_extension(left_ammo_unit_1p, "ammo_system") then
				ammo_unit = left_ammo_unit_1p
			elseif right_ammo_unit_1p and ScriptUnit.has_extension(right_ammo_unit_1p, "ammo_system") then
				ammo_unit = right_ammo_unit_1p
			end

			if ammo_unit then
				local ammo_extension = ScriptUnit.extension(ammo_unit, "ammo_system")
				local current_ammo_count = ammo_extension.ammo_count(ammo_extension)
				local remaining_ammo = ammo_extension.remaining_ammo(ammo_extension)
				local max_ammo = ammo_extension.max_ammo

				if current_ammo_count + remaining_ammo == 0 or max_ammo*0.25 < current_ammo_count + remaining_ammo then
					return false
				end

				return true
			end

			return false
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	core_ammo_depleted = {
		needed_points = 0,
		text = "tutorial_infoslate_core_out_of_ammo",
		display_type = "info_slate",
		icon = "hud_tutorial_icon_attention",
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)

			if slot_name ~= "slot_ranged" then
				return false
			end

			local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)

			if slot_data == nil then
				return false
			end

			local ammo_unit = nil
			local right_unit_1p = slot_data.right_unit_1p
			local left_unit_1p = slot_data.left_unit_1p
			local left_ammo_unit_1p = slot_data.left_ammo_unit_1p
			local right_ammo_unit_1p = slot_data.right_ammo_unit_1p

			if right_unit_1p and ScriptUnit.has_extension(right_unit_1p, "ammo_system") then
				ammo_unit = right_unit_1p
			elseif left_unit_1p and ScriptUnit.has_extension(left_unit_1p, "ammo_system") then
				ammo_unit = left_unit_1p
			elseif left_ammo_unit_1p and ScriptUnit.has_extension(left_ammo_unit_1p, "ammo_system") then
				ammo_unit = left_ammo_unit_1p
			elseif right_ammo_unit_1p and ScriptUnit.has_extension(right_ammo_unit_1p, "ammo_system") then
				ammo_unit = right_ammo_unit_1p
			end

			if ammo_unit then
				local ammo_extension = ScriptUnit.extension(ammo_unit, "ammo_system")
				local remaining_ammo = ammo_extension.remaining_ammo(ammo_extension)
				local current_ammo_count = ammo_extension.ammo_count(ammo_extension)

				if 0 < current_ammo_count + remaining_ammo then
					return false
				end

				return true
			end

			return false
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	core_revive = {
		priority = 45,
		action = "interact",
		do_not_verify = true,
		needed_points = 0,
		text = "tutorial_tooltip_core_revive",
		display_type = "tooltip",
		icon = "hud_tutorial_icon_attention",
		is_mission_tutorial = true,
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			local in_brawl_mode = Managers.state.game_mode:level_key() == "inn_level"

			if in_brawl_mode then
				return false
			end

			local players = Managers.player:human_and_bot_players()
			local unit_position = POSITION_LOOKUP[unit]
			local best_distance_sq = math.huge
			local best_unit_position, has_raycast_unit, raycast_unit_pos, raycast_unit_dist = nil

			for k, player in pairs(players) do
				local player_unit = player.player_unit

				if Unit.alive(player_unit) and unit ~= player_unit then
					local status_extension = ScriptUnit.extension(player_unit, "status_system")

					if status_extension.is_knocked_down(status_extension) then
						local player_position = POSITION_LOOKUP[player_unit]
						local distance_sq = Vector3.distance_squared(unit_position, player_position)

						if player_unit == raycast_unit then
							has_raycast_unit = true
							raycast_unit_pos = player_position
							raycast_unit_dist = distance_sq
						end

						if distance_sq < best_distance_sq then
							best_distance_sq = distance_sq
							best_unit_position = player_position
						end
					end
				end
			end

			if has_raycast_unit and raycast_unit_dist < 400 then
				return true, raycast_unit_pos
			elseif best_unit_position then
				return true, best_unit_position
			end

			return false
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	core_ranged = {
		incompatible_in_game = true,
		priority = 1,
		text = "tutorial_tooltip_core_ranged",
		do_not_verify = true,
		needed_points = 0,
		display_type = "tooltip",
		inputs = {
			{
				suffix = "",
				prefix = "",
				action = "action_one"
			}
		},
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			if raycast_unit == nil or not Unit.alive(raycast_unit) then
				return false
			end

			local breed = Unit.get_data(raycast_unit, "breed")

			if breed == nil then
				return false
			end

			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
			local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)

			if slot_data == nil then
				return false
			end

			local right_unit_1p = slot_data.right_unit_1p
			local is_weapon_slot = slot_name == "slot_melee" or slot_name == "slot_ranged"

			if is_weapon_slot and ScriptUnit.has_extension(right_unit_1p, "ammo_system") then
				local ammo_extension = ScriptUnit.extension(right_unit_1p, "ammo_system")
				local current_ammo_count = ammo_extension.ammo_count(ammo_extension)
				local clip_size = ammo_extension.clip_size(ammo_extension)

				if current_ammo_count == clip_size then
					apply_outline(raycast_unit)

					return true
				end
			end

			return false
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	advanced_heal = {
		needed_points = 3,
		text = "tutorial_infoslate_advanced_heal",
		display_type = "info_slate",
		icon = "hud_tutorial_icon_attention",
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			local health_extension = ScriptUnit.extension(unit, "health_system")
			local status_extension = ScriptUnit.extension(unit, "status_system")

			if 0.5 < health_extension.current_health_percent(health_extension) then
				return false
			end

			if status_extension.is_knocked_down(status_extension) then
				return false
			end

			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local medkit_slot_name = "slot_healthkit"
			local slot_data = inventory_extension.get_slot_data(inventory_extension, medkit_slot_name)

			if slot_data == nil then
				return false
			end

			return true
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	advanced_heal_find = {
		needed_points = 3,
		text = "tutorial_infoslate_advanced_heal_find",
		display_type = "info_slate",
		icon = "hud_tutorial_icon_attention",
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			local health_extension = ScriptUnit.extension(unit, "health_system")

			if 0.5 < health_extension.current_health_percent(health_extension) then
				return false
			end

			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local medkit_slot_name = "slot_healthkit"
			local slot_data = inventory_extension.get_slot_data(inventory_extension, medkit_slot_name)

			if slot_data ~= nil then
				return false
			end

			return true
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	advanced_enemy_armor = {
		incompatible_in_game = true,
		priority = 10,
		text = "tutorial_tooltip_advanced_enemy_armor",
		do_not_verify = true,
		needed_points = 3,
		display_type = "tooltip",
		icon = "hud_tutorial_icon_info",
		inputs = {
			{
				suffix = "",
				prefix = "",
				action = "action_one"
			}
		},
		get_inputs = function (data)
			return data.inputs
		end,
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			if raycast_unit == nil or not Unit.alive(raycast_unit) then
				return false
			end

			local breed = Unit.get_data(raycast_unit, "breed")

			if breed == nil then
				return false
			end

			if breed.armor_category ~= 2 then
				return false
			end

			local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
			local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
			local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)

			if slot_data == nil then
				return false
			end

			local right_unit_1p = slot_data.right_unit_1p
			local item_data = slot_data.item_data
			local item_template = BackendUtils.get_item_template(item_data)
			local attack_meta_data = item_template.attack_meta_data

			if attack_meta_data then
				if slot_name == "slot_melee" then
					if attack_meta_data.tap_attack.penetrating and attack_meta_data.hold_attack.penetrating then
						if attack_meta_data.tap_attack.arc < attack_meta_data.hold_attack.arc then
							data.inputs.prefix = ""
							data.inputs.action = "action_one"
							data.inputs.suffix = ""
						else
							data.inputs.prefix = "input_hold"
							data.inputs.action = "action_one_hold"
							data.inputs.suffix = ""
						end
					elseif attack_meta_data.tap_attack.penetrating then
						data.inputs.prefix = ""
						data.inputs.action = "action_one"
						data.inputs.suffix = ""
					elseif attack_meta_data.hold_attack.penetrating then
						data.inputs.prefix = "input_hold"
						data.inputs.action = "action_one_hold"
						data.inputs.suffix = ""
					else
						data.inputs.prefix = ""
						data.inputs.action = "action_one"
						data.inputs.suffix = ""
					end
				elseif attack_meta_data.charge_against_armoured_enemy then
					data.inputs.prefix = "input_hold"
					data.inputs.action = "action_two_hold"
					data.inputs.suffix = ""
				else
					data.inputs.prefix = ""
					data.inputs.action = "action_one"
					data.inputs.suffix = ""
				end
			else
				data.inputs.prefix = ""
				data.inputs.action = "action_one"
				data.inputs.suffix = ""
			end

			return true
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	advanced_enemy_armor_infoslate = {
		do_not_verify = true,
		needed_points = 3,
		display_type = "info_slate",
		icon = "hud_tutorial_icon_info",
		text = {
			"tutorial_infoslate_advanced_enemy_armor",
			"tutorial_infoslate_advanced_enemy_armor_02"
		},
		init_data = function (data)
			return 
		end,
		get_text = function (data, template)
			return template.text[math.floor(math.random(#template.text))]
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			if raycast_unit == nil or not Unit.alive(raycast_unit) then
				return false
			end

			local breed = Unit.get_data(raycast_unit, "breed")

			if breed == nil then
				return false
			end

			if breed.armor_category ~= 2 then
				return false
			end

			apply_outline(raycast_unit)

			return true
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	advanced_fatigue = {
		priority = 20,
		do_not_verify = true,
		needed_points = 3,
		display_type = "info_slate",
		icon = "hud_tutorial_icon_attention",
		text = {
			"tutorial_infoslate_advanced_fatigue",
			"tutorial_infoslate_advanced_fatigue_02"
		},
		init_data = function (data)
			return 
		end,
		get_text = function (data, template)
			return template.text[math.floor(math.random(#template.text))]
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			local status_extension = ScriptUnit.extension(unit, "status_system")

			if status_extension.fatigued(status_extension) then
				return true
			end

			return false
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	advanced_wounded = {
		needed_points = 3,
		priority = 20,
		text = "tutorial_infoslate_advanced_wounded",
		display_type = "info_slate",
		icon = "hud_tutorial_icon_attention",
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			local status_extension = ScriptUnit.extension(unit, "status_system")

			if status_extension.wounded and not status_extension.is_knocked_down(status_extension) then
				local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
				local medkit_slot_name = "slot_healthkit"
				local slot_data = inventory_extension.get_slot_data(inventory_extension, medkit_slot_name)

				if slot_data == nil then
					return false
				end

				return true
			end

			return false
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	},
	advanced_wounded_find = {
		needed_points = 3,
		priority = 20,
		text = "tutorial_infoslate_advanced_wounded_find",
		display_type = "info_slate",
		icon = "hud_tutorial_icon_attention",
		init_data = function (data)
			return 
		end,
		clear_data = function (data)
			return 
		end,
		update_data = function (t, unit, data)
			return 
		end,
		can_show = function (t, unit, data, raycast_unit, world)
			local status_extension = ScriptUnit.extension(unit, "status_system")

			if status_extension.wounded and not status_extension.is_knocked_down(status_extension) then
				local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
				local medkit_slot_name = "slot_healthkit"
				local slot_data = inventory_extension.get_slot_data(inventory_extension, medkit_slot_name)

				if slot_data ~= nil then
					return false
				end

				return true
			end

			return false
		end,
		is_completed = function (t, start_t, unit, data)
			return false
		end
	}
}
local found_units = {}
TutorialTemplates.advanced_sweep = {
	needed_points = 3,
	text = "tutorial_infoslate_advanced_sweep",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		if not has_melee_weapon_equipped(unit) then
			return false
		end

		local ai_system = Managers.state.entity:system("ai_system")
		local broadphase = ai_system.broadphase
		local num_hits = Broadphase.query(broadphase, POSITION_LOOKUP[unit], 5, found_units)

		if num_hits < 4 then
			return false
		end

		return true
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.advanced_push = {
	do_not_verify = true,
	needed_points = 3,
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	text = {
		"tutorial_infoslate_advanced_push",
		"tutorial_infoslate_advanced_push_02"
	},
	init_data = function (data)
		return 
	end,
	get_text = function (data, template)
		return template.text[math.floor(math.random(#template.text))]
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local health_extension = ScriptUnit.extension(unit, "health_system")

		if 0.5 < health_extension.current_health_percent(health_extension) then
			return false
		end

		local status_extension = ScriptUnit.extension(unit, "status_system")

		if not status_extension.is_blocking(status_extension) then
			return false
		end

		local ai_system = Managers.state.entity:system("ai_system")
		local broadphase = ai_system.broadphase
		local num_hits = Broadphase.query(broadphase, POSITION_LOOKUP[unit], 5, found_units)

		if num_hits < 1 then
			return false
		end

		return true
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.advanced_overcharge = {
	needed_points = 3,
	text = "tutorial_infoslate_advanced_overcharge",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local inventory_ext = ScriptUnit.extension(unit, "inventory_system")

		if not inventory_ext.get_slot_data(inventory_ext, "slot_ranged") then
			return false
		end

		local current_oc, threshold_oc, max_oc = inventory_ext.current_overcharge_status(inventory_ext, "slot_ranged")

		if not current_oc or current_oc < threshold_oc then
			return false
		end

		return true
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.advanced_heal_ally = {
	needed_points = 3,
	text = "tutorial_infoslate_advanced_heal_ally",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local inventory_ext = ScriptUnit.extension(unit, "inventory_system")
		local med_kit = inventory_ext.get_slot_data(inventory_ext, "slot_healthkit")
		local has_med_kit = false

		if med_kit then
			has_med_kit = med_kit.item_data.name ~= "potion_healing_draught_01"
		end

		if has_med_kit then
			local my_player = Managers.player:owner(unit)
			local players = Managers.player:human_and_bot_players()

			for _, player in pairs(players) do
				if player ~= my_player then
					local player_unit = player.player_unit

					if Unit.alive(unit) then
						local health_ext = ScriptUnit.extension(unit, "health_system")
						local status_ext = ScriptUnit.extension(unit, "status_system")
						local health_percent = health_ext.current_health_percent(health_ext)

						if health_ext.current_health_percent(health_ext) < 0.3 and not status_ext.is_disabled(status_ext) then
							return true
						end
					end
				end
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.advanced_avoid_friendly_fire = {
	needed_points = 3,
	do_not_verify = true,
	text = "tutorial_infoslate_advanced_friendly_fire",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local in_brawl_mode = Managers.state.game_mode:level_key() == "inn_level"

		if in_brawl_mode then
			return false
		end

		local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()

		if difficulty_settings.friendly_fire_ranged then
			local my_player = Managers.player:owner(unit)
			local players = Managers.player:human_and_bot_players()

			for _, player in pairs(players) do
				if player ~= my_player then
					local player_unit = player.player_unit

					if Unit.alive(player_unit) then
						local damage_ext = ScriptUnit.extension(player_unit, "damage_system")
						local recent_damages = damage_ext.recent_damages(damage_ext)
						local attacking_unit = recent_damages[DamageDataIndex.ATTACKER]

						if attacking_unit == unit then
							return true
						end
					end
				end
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.advanced_grenade = {
	needed_points = 3,
	priority = 60,
	display_type = "tooltip",
	icon = "grenade_icon",
	is_mission_tutorial = true,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local unit_position = POSITION_LOOKUP[unit]
		local best_unit, best_extension = nil
		local best_distance_sq = 400
		local units = nil

		if Managers.player.is_server then
			units = Managers.state.entity:get_entities("PlayerProjectileUnitExtension")
		else
			units = Managers.state.entity:get_entities("PlayerProjectileHuskExtension")
		end

		for projectile_unit, projectile_extension in pairs(units) do
			local is_grenade = projectile_extension.projectile_info.is_grenade

			if is_grenade then
				local owner_unit = projectile_extension.owner_unit

				if owner_unit ~= unit then
					local distance_sq = Vector3.distance_squared(unit_position, POSITION_LOOKUP[projectile_unit])

					if distance_sq < best_distance_sq then
						best_distance_sq = distance_sq
						best_unit = projectile_unit
						best_extension = projectile_extension
					end
				end
			end
		end

		if best_unit == nil then
			return false
		end

		return true, POSITION_LOOKUP[best_unit]
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.play_go_tutorial_tooltip = {
	do_not_verify = true,
	needed_points = 3,
	allowed_in_tutorial = true,
	text = "none",
	display_type = "tooltip",
	icon = "hud_tutorial_icon_info",
	alt_action_icons = {
		move_left = "left_stick",
		move_forward = "left_stick",
		action_instant_heal_other_hold = "d_up",
		move_back = "left_stick",
		move_right = "left_stick",
		action_instant_drink_potion = "d_right",
		action_instant_grenade_throw = "right_shoulder"
	},
	get_text = function (data, template)
		return data.text
	end,
	get_inputs = function (data)
		return data.inputs
	end,
	get_gamepad_inputs = function (data)
		return data.gamepad_inputs
	end,
	get_force_update = function (data)
		return data.force_update
	end,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		if data.force_update then
			data.force_update = false
		end

		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local mission_system = Managers.state.entity:system("mission_system")
		local active_missions, completed_missions = mission_system.get_missions(mission_system)

		for mission_name, mission_data in pairs(active_missions) do
			if active_missions[mission_name].mission_data.tooltip_text ~= nil then
				if data.text ~= nil and active_missions[mission_name].mission_data.tooltip_text ~= data.text then
					data.text = active_missions[mission_name].mission_data.tooltip_text
					local mission_data = active_missions[mission_name].mission_data
					data.inputs = mission_data.tooltip_inputs
					data.gamepad_inputs = mission_data.tooltip_gamepad_inputs
					data.force_update = true
				end

				data.text = active_missions[mission_name].mission_data.tooltip_text
				local mission_data = active_missions[mission_name].mission_data
				data.inputs = mission_data.tooltip_inputs
				data.gamepad_inputs = mission_data.tooltip_gamepad_inputs

				return true
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_cage_respawn = {
	priority = 30,
	needed_points = 3,
	text = "tutorial_tooltip_elite_cage_respawn",
	display_type = "tooltip",
	icon = "hud_tutorial_icon_rescue",
	is_mission_tutorial = true,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local players = Managers.player:human_and_bot_players()
		local unit_position = POSITION_LOOKUP[unit]
		local best_distance_sq = math.huge
		local best_unit_position = nil

		for k, player in pairs(players) do
			local player_unit = player.player_unit

			if Unit.alive(player_unit) and unit ~= player_unit then
				local status_extension = ScriptUnit.extension(player_unit, "status_system")

				if status_extension.is_ready_for_assisted_respawn(status_extension) then
					local player_position = POSITION_LOOKUP[player_unit]
					local distance_sq = Vector3.distance_squared(unit_position, player_position)

					if distance_sq < best_distance_sq then
						best_distance_sq = distance_sq
						best_unit_position = player_position
					end
				end
			end
		end

		if best_unit_position then
			return true, best_unit_position + Vector3.up()
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_tutorial_cage_respawn = {
	needed_points = 3,
	text = "tutorial_infoslate_elite_respawn",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	get_text = function (data)
		return data.text
	end,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local players = Managers.player:human_and_bot_players()
		local unit_position = POSITION_LOOKUP[unit]
		local best_distance_sq = math.huge
		local best_unit_position = nil

		for k, player in pairs(players) do
			local player_unit = player.player_unit

			if Unit.alive(player_unit) and unit ~= player_unit then
				local status_extension = ScriptUnit.extension(player_unit, "status_system")

				if status_extension.is_ready_for_assisted_respawn(status_extension) then
					return true
				end
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_player_dead = {
	needed_points = 3,
	text = "tutorial_infoslare_elite_death",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	get_text = function (data)
		return data.text
	end,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local players = Managers.player:human_and_bot_players()

		for k, player in pairs(players) do
			local player_unit = player.player_unit

			if Unit.alive(player_unit) and unit ~= player_unit then
				local status_extension = ScriptUnit.extension(player_unit, "status_system")

				if status_extension.is_dead(status_extension) then
					return true
				end
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_grimoire = {
	do_not_verify = true,
	text = "tutorial_infoslate_elite_grimoire",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	get_text = function (data)
		return data.text
	end,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local inventory_ext = ScriptUnit.extension(unit, "inventory_system")
		local slot_data = inventory_ext.recently_acquired(inventory_ext, "slot_potion")

		if slot_data and slot_data.item_data.name == "wpn_grimoire_01" then
			return true
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
local enemy_texts = {
	skaven_loot_rat = "tutorial_infoslate_elite_enemy_loot_rat",
	skaven_storm_vermin = "tutorial_infoslate_elite_enemy_storm_vermin",
	skaven_ratling_gunner = {
		"tutorial_infoslate_elite_enemy_ratling_gunner",
		"tutorial_infoslate_elite_enemy_ratling_gunner_02"
	},
	skaven_storm_vermin_commander = {
		"tutorial_infoslate_elite_enemy_storm_vermin_commander",
		"tutorial_infoslate_elite_enemy_storm_vermin_commander_02"
	},
	skaven_poison_wind_globadier = {
		"tutorial_infoslate_elite_enemy_poison_wind_globadier",
		"tutorial_infoslate_elite_enemy_poison_wind_globadier_02"
	},
	skaven_gutter_runner = {
		"tutorial_infoslate_elite_enemy_gutter_runner",
		"tutorial_infoslate_elite_enemy_gutter_runner_smoke_bomb"
	},
	skaven_rat_ogre = {
		"tutorial_infoslate_elite_enemy_rat_ogre",
		"tutorial_infoslate_elite_enemy_rat_ogre_02"
	},
	skaven_pack_master = {
		"tutorial_infoslate_elite_enemy_pack_master",
		"tutorial_infoslate_elite_enemy_pack_master_02"
	}
}
TutorialTemplates.elite_enemies = {
	do_not_verify = true,
	cooldown = 50,
	needed_points = 3,
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	get_text = function (data)
		return data.text
	end,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	on_message = function (data, message)
		data.elite_enemy_trigger = message

		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		if not data.elite_enemy_trigger then
			return false
		end

		local breed_name = data.elite_enemy_trigger
		local text = enemy_texts[breed_name]

		if text == nil then
			return false
		end

		if type(text) == "table" then
			text = text[math.floor(math.random(#text))]
		end

		data.text = text
		data.elite_enemy_trigger = nil

		return true
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_aggro = {
	needed_points = 3,
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	text = {
		"tutorial_infoslate_elite_aggro",
		"tutorial_infoslate_elite_aggro_02"
	},
	init_data = function (data)
		return 
	end,
	get_text = function (data, template)
		return template.text[math.floor(math.random(#template.text))]
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	on_message = function (data, message)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local proximity_extension = ScriptUnit.extension(unit, "proximity_system")
		local proximity_types = proximity_extension.proximity_types

		if 0 < proximity_types.enemies_close.num then
			return false
		end

		if proximity_types.enemies_distant.num == 0 then
			return false
		end

		return true
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_potions = {
	needed_points = 3,
	text = "tutorial_infoslate_elite_potions",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local potion_slot = "slot_potion"
		local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
		local slot_data = inventory_extension.get_slot_data(inventory_extension, potion_slot)

		if slot_data == nil then
			data.potion_equipped = nil
		elseif not data.potion_equipped and slot_data.item_data.name ~= "wpn_grimoire_01" then
			return true
		end

		return 
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_grenades = {
	needed_points = 3,
	do_not_verify = true,
	text = "tutorial_infoslate_elite_grenades",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local grenade_slot = "slot_grenade"
		local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
		local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
		local recently_acquired = inventory_extension.recently_acquired(inventory_extension, grenade_slot)

		if not recently_acquired then
			return false
		end

		local slot_data = inventory_extension.get_slot_data(inventory_extension, grenade_slot)

		if slot_data == nil then
			data.grenade_equipped = nil
		elseif not data.grenade_equipped then
			return true
		end

		return 
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_loot_dice = {
	do_not_verify = true,
	needed_points = 3,
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	text = {
		"tutorial_infoslate_elite_loot_dice",
		"tutroial_infoslate_elite_loot_dice_02"
	},
	init_data = function (data)
		return 
	end,
	get_text = function (data, template)
		return template.text[math.floor(math.random(#template.text))]
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local dice_keeper = data.dice_keeper
		local dice = dice_keeper.get_dice(dice_keeper)

		for k, v in pairs(NetworkLookup.die_types) do
			if dice[k] ~= nil and 0 < dice_keeper.num_new_dices(dice_keeper, k) then
				return true
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_mutators = {
	needed_points = 3,
	text = "tutorial_infoslate_elite_mutators",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		return 
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.elite_trinkets = {
	needed_points = 3,
	text = "tutorial_infoslate_elite_trinkets",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_info",
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local levels = World.get_data(world, "levels")
		local inn_level_name = LevelSettings.inn_level.level_name

		if not levels[inn_level_name] then
			return false
		end

		local new_items_ids = ItemHelper.get_new_backend_ids()

		if new_items_ids then
			for backend_id, _ in pairs(new_items_ids) do
				local item_key = ScriptBackendItem.get_key(backend_id)

				if item_key then
					local item_data = ItemMasterList[item_key]

					if item_data.slot_type == "trinket" then
						return true
					end
				end
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
local objective_units = {}
TutorialTemplates.objective_pickup = {
	priority = 4,
	action = "interact",
	needed_points = 4,
	display_type = "objective_tooltip",
	icon = "hud_tutorial_icon_mission",
	is_mission_tutorial = true,
	get_text = function (data)
		return data.objective_text
	end,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
		local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
		local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)

		if slot_name == "slot_level_event" and slot_data ~= nil then
			return false
		end

		local unit_position = POSITION_LOOKUP[unit]
		local best_distance_sq = 10000
		local objective_units_n = 0
		local units = Managers.state.entity:get_entities("ObjectivePickupTutorialExtension")

		for pickup_unit, pickup_extension in pairs(units) do
			if unit ~= pickup_unit then
				local disregard = false

				if ScriptUnit.has_extension(pickup_unit, "death_system") then
					local death_extension = ScriptUnit.extension(pickup_unit, "death_system")

					if death_extension.has_death_started(death_extension) then
						disregard = true
					end
				end

				local pickup_unit_position = POSITION_LOOKUP[pickup_unit]
				local distance_sq = Vector3.distance_squared(unit_position, pickup_unit_position)

				if not disregard and distance_sq < best_distance_sq then
					objective_units_n = objective_units_n + 1
					objective_units[objective_units_n] = pickup_unit
				end
			end
		end

		if 0 < objective_units_n then
			local unit = objective_units[1]
			data.objective_text = Unit.get_data(unit, "tutorial_text_id") or "tutorial_no_text"

			return true, objective_units, objective_units_n
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.objective_socket = {
	priority = 5,
	action = "interact",
	needed_points = 0,
	display_type = "objective_tooltip",
	icon = "hud_tutorial_icon_mission",
	is_mission_tutorial = true,
	get_text = function (data)
		return data.objective_text
	end,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local unit_position = POSITION_LOOKUP[unit]
		local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
		local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
		local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)

		if slot_name == "slot_level_event" and slot_data ~= nil then
			local best_distance_sq = 10000
			local units = Managers.state.entity:get_entities("ObjectiveSocketUnitExtension")
			local unit_get_data = Unit.get_data
			local objective_units_n = 0

			for socket_unit, socket_extension in pairs(units) do
				local sockets_enabled = unit_get_data(socket_unit, "sockets_enabled") ~= false

				if sockets_enabled then
					local distance_sq = Vector3.distance_squared(unit_position, POSITION_LOOKUP[socket_unit])

					if socket_extension.num_closed_sockets < socket_extension.num_sockets and distance_sq < best_distance_sq then
						objective_units_n = objective_units_n + 1
						objective_units[objective_units_n] = socket_unit
					end
				end
			end

			if objective_units_n == 0 then
				return false
			end

			local weapon_unit_1p = slot_data.right_unit_1p or slot_data.left_unit_1p

			if ScriptUnit.has_extension(weapon_unit_1p, "limited_item_track_system") then
				local first_socket_unit = objective_units[1]
				data.objective_text = Unit.get_data(first_socket_unit, "tutorial_text_id") or "tutorial_no_text"

				return true, objective_units, objective_units_n
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.objective_unit = {
	priority = 1,
	action = "interact",
	needed_points = 0,
	display_type = "objective_tooltip",
	icon = "hud_tutorial_icon_mission",
	is_mission_tutorial = true,
	get_text = function (data)
		return data.objective_text
	end,
	get_icon = function (data)
		return data.objective_icon
	end,
	get_alert = function (data)
		return data.alerts_horde
	end,
	get_wave = function (data)
		return data.objective_wave
	end,
	init_data = function (data)
		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit, world)
		local unit_position = POSITION_LOOKUP[unit]
		local units = Managers.state.entity:get_entities("ObjectiveUnitExtension")
		local vector3_distance_squared = Vector3.distance_squared
		local best_unit = nil
		local best_distance_sq = math.huge
		local objective_units_n = 0

		for objective_unit, extension in pairs(units) do
			if extension.active then
				local distance_sq = vector3_distance_squared(unit_position, POSITION_LOOKUP[objective_unit])

				if distance_sq < best_distance_sq then
					best_unit = objective_unit
					best_distance_sq = distance_sq
				end
			end
		end

		if best_unit then
			local unit_get_data = Unit.get_data
			data.objective_text = unit_get_data(best_unit, "tutorial_text_id") or "tutorial_no_text"
			data.alerts_horde = unit_get_data(best_unit, "alerts_horde") or false
			data.objective_icon = unit_get_data(best_unit, "icon") or "hud_tutorial_icon_mission"
			data.objective_wave = unit_get_data(best_unit, "tutorial_wave") or false
			objective_units[1] = best_unit

			return true, objective_units, 1
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTemplates.endurance_badge_pickup = {
	cooldown = 20,
	do_not_verify = true,
	needed_points = 0,
	text = "dlc1_2_survival_tutorial_slate_01",
	display_type = "info_slate",
	icon = "hud_tutorial_icon_attention",
	init_data = function (data)
		data.mission_names = {
			"endurance_badge_01_mission",
			"endurance_badge_02_mission",
			"endurance_badge_03_mission",
			"endurance_badge_04_mission",
			"endurance_badge_05_mission"
		}
		data.collect_amount = 0

		return 
	end,
	clear_data = function (data)
		return 
	end,
	update_data = function (t, unit, data)
		return 
	end,
	can_show = function (t, unit, data, raycast_unit)
		local mission_system = Managers.state.entity:system("mission_system")

		if mission_system then
			local total_collect_amount = 0
			local mission_names = data.mission_names

			for _, mission_name in ipairs(mission_names) do
				local mission_data = mission_system.get_level_end_mission_data(mission_system, mission_name)

				if mission_data then
					local current_amount = mission_data.current_amount
					total_collect_amount = total_collect_amount + current_amount
				end
			end

			if data.collect_amount < total_collect_amount then
				data.collect_amount = total_collect_amount

				return true
			end
		end

		return false
	end,
	is_completed = function (t, start_t, unit, data)
		return false
	end
}
TutorialTooltipTemplates = {}
TutorialTooltipTemplates_n = 0
TutorialInfoSlateTemplates = {}
TutorialInfoSlateTemplates_n = 0
TutorialObjectiveTooltipTemplates = {}
TutorialObjectiveTooltipTemplates_n = 0

for name, template in pairs(TutorialTemplates) do
	template.name = name

	if template.display_type == "tooltip" then
		template.priority = template.priority or 0
		TutorialTooltipTemplates_n = TutorialTooltipTemplates_n + 1
		TutorialTooltipTemplates[TutorialTooltipTemplates_n] = template
	elseif template.display_type == "info_slate" then
		TutorialInfoSlateTemplates_n = TutorialInfoSlateTemplates_n + 1
		TutorialInfoSlateTemplates[TutorialInfoSlateTemplates_n] = template
	elseif template.display_type == "objective_tooltip" then
		TutorialObjectiveTooltipTemplates_n = TutorialObjectiveTooltipTemplates_n + 1
		TutorialObjectiveTooltipTemplates[TutorialObjectiveTooltipTemplates_n] = template
	end
end

local function tooltip_sort_function(t1, t2)
	return t2.priority < t1.priority
end

table.sort(TutorialTooltipTemplates, tooltip_sort_function)
table.sort(TutorialObjectiveTooltipTemplates, tooltip_sort_function)

return 
