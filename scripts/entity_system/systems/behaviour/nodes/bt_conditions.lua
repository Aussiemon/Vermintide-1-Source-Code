BTConditions = BTConditions or {}
local unit_alive = Unit.alive
local ScriptUnit = ScriptUnit
BTConditions.always_true = function (blackboard)
	return true
end
BTConditions.always_false = function (blackboard)
	return false
end
BTConditions.spawn = function (blackboard)
	return blackboard.spawn
end
BTConditions.stunned = function (blackboard)
	return blackboard.stunned
end
BTConditions.blocked = function (blackboard)
	return blackboard.blocked
end
BTConditions.ask_target_before_attacking = function (blackboard)
	return blackboard.attack_token
end
BTConditions.stagger = function (blackboard)
	if blackboard.stagger then
		if blackboard.is_climbing then
			blackboard.stagger = false
		else
			return true
		end
	end

	return 
end
BTConditions.fling_skaven = function (blackboard)
	return blackboard.fling_skaven
end
BTConditions.secondary_target = function (blackboard)
	return blackboard.secondary_target
end
BTConditions.quick_jump = function (blackboard)
	return blackboard.high_ground_opportunity
end
BTConditions.ninja_vanish = function (blackboard)
	return blackboard.ninja_vanish
end
BTConditions.target_changed = function (blackboard)
	return blackboard.target_changed
end
BTConditions.target_reachable = function (blackboard)
	return not blackboard.target_outside_navmesh or (blackboard.target_dist and blackboard.target_dist <= blackboard.breed.reach_distance)
end
BTConditions.path_found = function (blackboard)
	return not blackboard.no_path_found
end
BTConditions.ratogre_jump_dist = function (blackboard)
	return not blackboard.target_outside_navmesh and blackboard.target_dist and blackboard.target_dist <= 15
end
BTConditions.at_smartobject = function (blackboard)
	local smartobject_is_next = blackboard.next_smart_object_data.next_smart_object_id ~= nil
	local is_in_smartobject_range = blackboard.is_in_smartobject_range
	local is_smart_objecting = blackboard.is_smart_objecting

	return (smartobject_is_next and is_in_smartobject_range) or is_smart_objecting
end
BTConditions.ratogre_at_smartobject = function (blackboard)
	if blackboard.keep_target then
		return false
	end

	local smartobject_is_next = blackboard.next_smart_object_data.next_smart_object_id ~= nil
	local is_in_smartobject_range = blackboard.is_in_smartobject_range
	local is_smart_objecting = blackboard.is_smart_objecting

	return (smartobject_is_next and is_in_smartobject_range) or is_smart_objecting
end
BTConditions.at_teleport_smartobject = function (blackboard)
	local smart_object_type = blackboard.next_smart_object_data.smart_object_type
	local is_smart_object_teleporter = smart_object_type == "teleporters"
	local is_teleporting = blackboard.is_teleporting

	return is_smart_object_teleporter or is_teleporting
end
BTConditions.at_climb_smartobject = function (blackboard)
	local smart_object_type = blackboard.next_smart_object_data.smart_object_type
	local is_smart_object_ledge = smart_object_type == "ledges" or smart_object_type == "ledges_with_fence"
	local is_climbing = blackboard.is_climbing

	return is_smart_object_ledge or is_climbing
end
BTConditions.at_jump_smartobject = function (blackboard)
	local is_smart_object_jump = blackboard.next_smart_object_data.smart_object_type == "jumps"
	local is_jumping = blackboard.is_jumping

	return is_smart_object_jump or is_jumping
end
BTConditions.at_door_smartobject = function (blackboard)
	local smart_object_type = blackboard.next_smart_object_data.smart_object_type
	local is_smart_object_door = smart_object_type == "doors" or smart_object_type == "planks"
	local is_smashing_door = blackboard.is_smashing_door
	local is_scurrying_under_door = blackboard.is_scurrying_under_door
	local door_is_open = blackboard.next_smart_object_data.disabled

	if door_is_open then
		return false
	end

	return is_smart_object_door or is_smashing_door or is_scurrying_under_door
end
BTConditions.at_smart_object_and_door = function (blackboard)
	return BTConditions.at_smartobject(blackboard) and BTConditions.at_door_smartobject(blackboard)
end
BTConditions.can_see_ally = function (blackboard)
	return unit_alive(blackboard.target_ally_unit) and blackboard.ally_distance < 40
end
BTConditions.is_disabled = function (blackboard)
	return blackboard.is_knocked_down or blackboard.is_grabbed_by_pack_master or blackboard.is_pounced_down or blackboard.is_hanging_from_hook or blackboard.is_ledge_hanging
end
BTConditions.can_teleport = function (blackboard)
	local self_unit = blackboard.unit
	local follow_unit = ScriptUnit.extension(self_unit, "ai_bot_group_system").data.follow_unit

	if not follow_unit then
		return false
	end

	local conflict_director = Managers.state.conflict
	local self_segment = conflict_director.get_player_unit_segment(conflict_director, self_unit) or 1
	local target_segment = conflict_director.get_player_unit_segment(conflict_director, follow_unit)

	if not target_segment or target_segment < self_segment then
		return false
	end

	return true
end
BTConditions.cant_reach_ally = function (blackboard)
	local self_unit = blackboard.unit
	local follow_unit = ScriptUnit.extension(self_unit, "ai_bot_group_system").data.follow_unit

	if not follow_unit then
		return false
	end

	local conflict_director = Managers.state.conflict
	local self_segment = conflict_director.get_player_unit_segment(conflict_director, self_unit)
	local target_segment = conflict_director.get_player_unit_segment(conflict_director, follow_unit)

	if not self_segment or not target_segment then
		return false
	end

	local nav_ext = ScriptUnit.extension(self_unit, "ai_navigation_system")
	local fails, last_success = nav_ext.successive_failed_paths(nav_ext)
	local t = Managers.time:time("game")
	local is_backwards = target_segment < self_segment
	local is_forwards = self_segment < target_segment

	if is_backwards then
		return false
	end

	return blackboard.moving_toward_follow_position and ((is_forwards and 1) or 5) < fails and 5 < t - last_success and not blackboard.has_teleported
end
BTConditions.bot_at_breakable = function (blackboard)
	if blackboard.breakable_object then
		local health_ext = ScriptUnit.extension(blackboard.breakable_object, "health_system")

		return health_ext.is_alive(health_ext)
	end

	return false
end
BTConditions.bot_in_melee_range = function (blackboard)
	local target_unit = blackboard.target_unit

	if not unit_alive(target_unit) then
		return false
	end

	local self_unit = blackboard.unit
	local wielded_slot = ScriptUnit.extension(self_unit, "inventory_system"):equipment().wielded_slot
	local melee_range = nil

	if blackboard.urgent_target_enemy == target_unit or blackboard.opportunity_target_enemy == target_unit or Vector3.is_valid(blackboard.taking_cover.cover_position:unbox()) then
		local breed = Unit.get_data(target_unit, "breed")
		melee_range = (breed and breed.bot_opportunity_target_melee_range) or 3

		if wielded_slot == "slot_ranged" then
			melee_range = (breed and breed.bot_opportunity_target_melee_range_while_ranged) or 2
		end
	else
		melee_range = 12

		if wielded_slot == "slot_ranged" then
			melee_range = 10
		end
	end

	local offset = POSITION_LOOKUP[target_unit] - POSITION_LOOKUP[self_unit]
	local dist = Vector3.length(offset)
	local in_range = dist < melee_range
	local z_offset = offset.z

	return in_range and -1.5 < z_offset and z_offset < 2
end
BTConditions.has_priority_or_opportunity_target = function (blackboard)
	local target = blackboard.target_unit

	if not Unit.alive(target) then
		return false
	end

	local dist = 25
	local result = (target == blackboard.priority_target_enemy and blackboard.priority_target_distance < dist) or (target == blackboard.urgent_target_enemy and blackboard.urgent_target_distance < dist)

	return result
end
BTConditions.is_slot_1_not_wielded = function (blackboard)
	local self_unit = blackboard.unit
	local wielded_slot = ScriptUnit.extension(self_unit, "inventory_system"):equipment().wielded_slot

	return wielded_slot ~= "slot_melee"
end
BTConditions.has_target_and_ammo_greater_than = function (blackboard, args)
	if not unit_alive(blackboard.target_unit) then
		return false
	end

	local self_unit = blackboard.unit
	local inventory_ext = ScriptUnit.extension(self_unit, "inventory_system")
	local current, max = inventory_ext.current_ammo_status(inventory_ext, "slot_ranged")
	local ammo_ok = not current or args.ammo_percentage < current/max
	local current_oc, max_oc = inventory_ext.current_overcharge_status(inventory_ext, "slot_ranged")
	local overcharge_ok = not current_oc or current_oc/max_oc < args.overcharge_limit
	local obstruction = blackboard.ranged_obstruction_by_static
	local t = Managers.time:time("game")
	local obstructed = obstruction and obstruction.unit == blackboard.target_unit and obstruction.timer + 3 < t

	return ammo_ok and overcharge_ok and not obstructed
end
BTConditions.can_loot_ammo = function (blackboard, args)
	return blackboard.ammo_pickup and blackboard.needs_ammo and blackboard.ammo_dist < 2.5 and blackboard.ammo_pickup == blackboard.interaction_unit
end
BTConditions.bot_should_heal = function (blackboard)
	local self_unit = blackboard.unit
	local inventory_ext = ScriptUnit.extension(self_unit, "inventory_system")
	local health_slot_data = inventory_ext.get_slot_data(inventory_ext, "slot_healthkit")
	local template = health_slot_data and inventory_ext.get_item_template(inventory_ext, health_slot_data)
	local can_heal_self = template and template.can_heal_self

	if not can_heal_self then
		return false
	end

	local current_health_percent = ScriptUnit.extension(self_unit, "health_system"):current_health_percent()
	local hurt = current_health_percent <= template.bot_heal_threshold
	local target_unit = blackboard.target_unit
	local is_safe = not target_unit or ((template.fast_heal or blackboard.is_healing_self) and #blackboard.proximite_enemies == 0) or (target_unit ~= blackboard.priority_target_enemy and target_unit ~= blackboard.urgent_target_enemy and target_unit ~= blackboard.proximity_target_enemy and target_unit ~= blackboard.slot_target_enemy)
	local wounded = ScriptUnit.extension(self_unit, "status_system").wounded

	return is_safe and (hurt or blackboard.force_use_health_pickup or wounded)
end
BTConditions.can_loot_med = function (blackboard, args)
	return blackboard.health_pickup and blackboard.allowed_to_take_health_pickup and blackboard.health_dist < 2.5 and blackboard.health_pickup == blackboard.interaction_unit
end
BTConditions.can_open_door = function (blackboard, args)
	local can_interact = false

	if blackboard.interaction_type == "door" then
		local door_ext = unit_alive(blackboard.interaction_unit) and ScriptUnit.has_extension(blackboard.interaction_unit, "door_system") and ScriptUnit.extension(blackboard.interaction_unit, "door_system")

		if door_ext then
			can_interact = door_ext.get_current_state(door_ext) == "closed"
		end
	end

	return can_interact
end
BTConditions.is_slot_2_not_wielded = function (blackboard)
	local self_unit = blackboard.unit
	local wielded_slot = ScriptUnit.extension(self_unit, "inventory_system"):equipment().wielded_slot

	return wielded_slot ~= "slot_ranged"
end
BTConditions.can_revive = function (blackboard)
	if blackboard.target_ally_need_type == "knocked_down" then
		local ally_distance = blackboard.ally_distance

		if 2.25 < ally_distance then
			return false
		end

		local self_unit = blackboard.unit
		local health = ScriptUnit.extension(blackboard.target_ally_unit, "health_system"):current_health_percent()

		if 0.2 < health then
			for _, enemy_unit in pairs(blackboard.proximite_enemies) do
				if unit_alive(enemy_unit) and Unit.get_data(enemy_unit, "blackboard").target_unit == self_unit then
					return false
				end
			end
		end

		local destination_reached = blackboard.navigation_extension:destination_reached()

		if destination_reached or ally_distance < 1 then
			return true
		end
	end

	return 
end
BTConditions.can_heal_player = function (blackboard)
	if blackboard.target_ally_need_type == "in_need_of_heal" then
		if blackboard.is_healing_other then
			return true
		end

		local ally_distance = blackboard.ally_distance

		if 2.5 < ally_distance then
			return false
		end

		if 0 < #blackboard.proximite_enemies then
			return false
		end

		local destination_reached = blackboard.navigation_extension:destination_reached()

		if destination_reached then
			return true
		end
	end

	return 
end
BTConditions.can_rescue_hanging_from_hook = function (blackboard)
	if blackboard.target_ally_need_type == "hook" then
		local ally_distance = blackboard.ally_distance

		if 2.25 < ally_distance then
			return false
		end

		local self_unit = blackboard.unit

		for _, enemy_unit in pairs(blackboard.proximite_enemies) do
			if unit_alive(enemy_unit) and Unit.get_data(enemy_unit, "blackboard").target_unit == self_unit then
				return false
			end
		end

		local destination_reached = blackboard.navigation_extension:destination_reached()

		if destination_reached then
			return true
		end
	end

	return 
end
BTConditions.can_rescue_ledge_hanging = function (blackboard)
	if blackboard.target_ally_need_type == "ledge" then
		local ally_distance = blackboard.ally_distance

		if 2.25 < ally_distance then
			return false
		end

		local self_unit = blackboard.unit

		for _, enemy_unit in pairs(blackboard.proximite_enemies) do
			if unit_alive(enemy_unit) and Unit.get_data(enemy_unit, "blackboard").target_unit == self_unit then
				return false
			end
		end

		local destination_reached = blackboard.navigation_extension:destination_reached()

		if destination_reached then
			return true
		end
	end

	return 
end
BTConditions.has_destructible_as_target = function (blackboard)
	local target = blackboard.target_unit
	local is_destructible_static = not ScriptUnit.has_extension(target, "locomotion_system")

	return unit_alive(target) and blackboard.confirmed_player_sighting and is_destructible_static
end
BTConditions.can_see_player = function (blackboard)
	return unit_alive(blackboard.target_unit)
end
BTConditions.player_spotted = function (blackboard)
	return unit_alive(blackboard.target_unit) and not blackboard.confirmed_player_sighting
end
BTConditions.in_melee_range = function (blackboard)
	return unit_alive(blackboard.target_unit) and blackboard.in_melee_range
end
BTConditions.approach_target = function (blackboard)
	return blackboard.approach_target
end
BTConditions.comitted_to_target = function (blackboard)
	return blackboard.target_unit or blackboard.comitted_to_target
end
BTConditions.in_sprint_dist = function (blackboard)
	return blackboard.closing or 7 < blackboard.target_dist
end
BTConditions.in_run_dist = function (blackboard)
	return blackboard.target_dist <= 7
end
BTConditions.reset_utility = function (blackboard)
	return not blackboard.reset_utility
end
BTConditions.is_alerted = function (blackboard)
	return unit_alive(blackboard.target_unit) and blackboard.is_alerted and (not blackboard.confirmed_player_sighting or blackboard.hesitating)
end
BTConditions.confirmed_player_sighting = function (blackboard)
	return unit_alive(blackboard.target_unit) and blackboard.confirmed_player_sighting
end
BTConditions.suiciding_whilst_staggering = function (blackboard)
	return blackboard.stagger and blackboard.suicide_run ~= nil and blackboard.suicide_run.explosion_started
end
BTConditions.ragdoll = function (blackboard)
	return blackboard.ragdoll
end
BTConditions.has_goal_destination = function (blackboard)
	return blackboard.goal_destination ~= nil
end
BTConditions.is_falling = function (blackboard)
	return blackboard.is_falling or blackboard.fall_state ~= nil
end
BTConditions.is_gutter_runner_falling = function (blackboard)
	return not blackboard.pouncing_target and (blackboard.is_falling or blackboard.fall_state ~= nil)
end
BTConditions.pack_master_needs_hook = function (blackboard)
	return blackboard.needs_hook
end
BTConditions.is_transported = function (blackboard)
	return blackboard.is_transported
end
BTConditions.look_for_players = function (blackboard)
	return blackboard.look_for_players
end
BTConditions.suicide_run = function (blackboard)
	return blackboard.current_health_percent < 0.7
end
BTConditions.should_use_interest_point = function (blackboard)
	return not blackboard.ignore_interest_points and not blackboard.confirmed_player_sighting
end
BTConditions.give_command = function (blackboard)
	return blackboard.give_command and unit_alive(blackboard.target_unit) and blackboard.confirmed_player_sighting
end
BTConditions.is_fleeing = function (blackboard)
	return unit_alive(blackboard.target_unit) or blackboard.is_fleeing
end
BTConditions.loot_rat_stagger = function (blackboard)
	return BTConditions.stagger(blackboard) and not blackboard.dodge_damage_success
end
BTConditions.loot_rat_dodge = function (blackboard)
	return blackboard.dodge_vector or blackboard.is_dodging
end
BTConditions.loot_rat_flee = function (blackboard)
	return BTConditions.confirmed_player_sighting(blackboard) or blackboard.is_fleeing
end
BTConditions.loot_rat_look_for_players = function (blackboard)
	return blackboard.look_for_players or blackboard.looking_for_players
end
BTConditions.can_trigger_move_to = function (blackboard)
	local t = Managers.time:time("game")
	local trigger_time = blackboard.trigger_time or 0

	return trigger_time < t
end
BTConditions.globadier_skulked_for_too_long = function (blackboard)
	local adv_data = blackboard.advance_towards_players
	local skulk_timeout = 15

	if adv_data then
		local t = Managers.time:time("game")
		local throw_globe_data = blackboard.throw_globe_data

		if throw_globe_data and throw_globe_data.next_throw_at then
			return throw_globe_data.next_throw_at + skulk_timeout < t
		else
			return adv_data.time_until_first_throw + skulk_timeout < adv_data.timer
		end
	end

	return false
end
BTConditions.ratling_gunner_skulked_for_too_long = function (blackboard)
	if unit_alive(blackboard.target_unit) then
		local skulk_timeout = 15
		local pattern_data = blackboard.attack_pattern_data
		local last_fired = pattern_data and pattern_data.last_fired
		local t = Managers.time:time("game")
		local lurk_start = blackboard.lurk_start

		if last_fired then
			return last_fired + skulk_timeout < t
		elseif lurk_start then
			return lurk_start + skulk_timeout < t
		end
	end

	return false
end

return 