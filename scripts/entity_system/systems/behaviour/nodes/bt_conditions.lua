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
end

BTConditions.teleport_immune_stagger = function (blackboard)
	if blackboard.stagger then
		if blackboard.is_teleporting then
			blackboard.stagger = false

			return false
		else
			return true
		end
	end
end

BTConditions.fling_skaven = function (blackboard)
	return blackboard.fling_skaven
end

BTConditions.secondary_target = function (blackboard)
	return blackboard.target_unit or blackboard.secondary_target
end

BTConditions.quick_jump = function (blackboard)
	return blackboard.high_ground_opportunity
end

BTConditions.throw_throwing_stars = function (blackboard)
	return Unit.alive(blackboard.throw_projectile_at) or blackboard.throw_data
end

BTConditions.uninterruptable_ninja_vanish = function (blackboard)
	return blackboard.ninja_vanish_at_health_percent and ScriptUnit.extension(blackboard.unit, "health_system"):current_health_percent() < blackboard.ninja_vanish_at_health_percent
end

BTConditions.ninja_vanish = function (blackboard)
	return blackboard.ninja_vanish
end

BTConditions.target_changed = function (blackboard)
	return blackboard.target_changed
end

BTConditions.ratogre_target_reachable = function (blackboard)
	return blackboard.jump_slam_data or not blackboard.target_outside_navmesh or (blackboard.target_dist and blackboard.target_dist <= blackboard.breed.reach_distance)
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

BTConditions.gutter_runner_at_smartobject = function (blackboard)
	if blackboard.jump_data then
		return false
	end

	return BTConditions.at_smartobject(blackboard)
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
	local follow_unit = blackboard.ai_bot_group_extension.data.follow_unit

	if not follow_unit then
		return false
	end

	local level_settings = LevelHelper:current_level_settings()
	local disable_bot_main_path_teleport_check = level_settings.disable_bot_main_path_teleport_check

	if not disable_bot_main_path_teleport_check then
		local self_unit = blackboard.unit
		local conflict_director = Managers.state.conflict
		local self_segment = conflict_director:get_player_unit_segment(self_unit) or 1
		local target_segment = conflict_director:get_player_unit_segment(follow_unit)

		if not target_segment or target_segment < self_segment then
			return false
		end
	end

	return true
end

BTConditions.cant_reach_ally = function (blackboard)
	local follow_unit = blackboard.ai_bot_group_extension.data.follow_unit

	if not follow_unit then
		return false
	end

	local level_settings = LevelHelper:current_level_settings()
	local disable_bot_main_path_teleport_check = level_settings.disable_bot_main_path_teleport_check
	local is_forwards = nil

	if not disable_bot_main_path_teleport_check then
		local self_unit = blackboard.unit
		local conflict_director = Managers.state.conflict
		local self_segment = conflict_director:get_player_unit_segment(self_unit)
		local target_segment = conflict_director:get_player_unit_segment(follow_unit)

		if not self_segment or not target_segment then
			return false
		end

		local is_backwards = target_segment < self_segment

		if is_backwards then
			return false
		end

		is_forwards = self_segment < target_segment
	end

	local t = Managers.time:time("game")
	local navigation_extension = blackboard.navigation_extension
	local fails, last_success = navigation_extension:successive_failed_paths()

	return blackboard.moving_toward_follow_position and fails > (((disable_bot_main_path_teleport_check or is_forwards) and 1) or 5) and t - last_success > 5 and not blackboard.has_teleported
end

BTConditions.bot_at_breakable = function (blackboard)
	if blackboard.breakable_object then
		local health_ext = ScriptUnit.extension(blackboard.breakable_object, "health_system")

		return health_ext:is_alive()
	end

	return false
end

BTConditions.bot_in_melee_range = function (blackboard)
	local target_unit = blackboard.target_unit

	if not unit_alive(target_unit) then
		return false
	end

	local self_unit = blackboard.unit
	local wielded_slot = blackboard.inventory_extension:equipment().wielded_slot
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

	return in_range and z_offset > -1.5 and z_offset < 2
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

BTConditions.has_target_and_ammo_greater_than = function (blackboard, args)
	if not unit_alive(blackboard.target_unit) then
		return false
	end

	local inventory_ext = blackboard.inventory_extension
	local current, max = inventory_ext:current_ammo_status("slot_ranged")
	local ammo_ok = not current or args.ammo_percentage < current / max
	local overcharge_limit_type = args.overcharge_limit_type
	local current_oc, threshold_oc, max_oc = inventory_ext:current_overcharge_status("slot_ranged")
	local overcharge_ok = not current_oc or (overcharge_limit_type == "threshold" and current_oc / threshold_oc < args.overcharge_limit) or (overcharge_limit_type == "maximum" and current_oc / max_oc < args.overcharge_limit)
	local obstruction = blackboard.ranged_obstruction_by_static
	local t = Managers.time:time("game")
	local obstructed = obstruction and obstruction.unit == blackboard.target_unit and t > obstruction.timer + 3

	return ammo_ok and overcharge_ok and not obstructed
end

BTConditions.can_loot = function (blackboard)
	local max_dist = 3.2

	return (blackboard.health_pickup and blackboard.allowed_to_take_health_pickup and blackboard.health_dist < max_dist and blackboard.health_pickup == blackboard.interaction_unit) or (blackboard.ammo_pickup and blackboard.needs_ammo and blackboard.ammo_dist < max_dist and blackboard.ammo_pickup == blackboard.interaction_unit) or (blackboard.mule_pickup and blackboard.mule_pickup == blackboard.interaction_unit and blackboard.mule_pickup_dist_squared < max_dist * max_dist)
end

BTConditions.bot_should_heal = function (blackboard)
	local self_unit = blackboard.unit
	local inventory_ext = blackboard.inventory_extension
	local health_slot_data = inventory_ext:get_slot_data("slot_healthkit")
	local template = health_slot_data and inventory_ext:get_item_template(health_slot_data)
	local can_heal_self = template and template.can_heal_self

	if not can_heal_self then
		return false
	end

	local current_health_percent = blackboard.health_extension:current_health_percent()
	local hurt = current_health_percent <= template.bot_heal_threshold
	local target_unit = blackboard.target_unit
	local is_safe = not target_unit or ((template.fast_heal or blackboard.is_healing_self) and #blackboard.proximite_enemies == 0) or (target_unit ~= blackboard.priority_target_enemy and target_unit ~= blackboard.urgent_target_enemy and target_unit ~= blackboard.proximity_target_enemy and target_unit ~= blackboard.slot_target_enemy)
	local wounded = blackboard.status_extension.wounded

	return is_safe and (hurt or blackboard.force_use_health_pickup or wounded)
end

BTConditions.can_open_door = function (blackboard)
	local can_interact = false

	if blackboard.interaction_type == "door" then
		local door_ext = unit_alive(blackboard.interaction_unit) and ScriptUnit.has_extension(blackboard.interaction_unit, "door_system") and ScriptUnit.extension(blackboard.interaction_unit, "door_system")

		if door_ext then
			can_interact = door_ext:get_current_state() == "closed"
		end
	end

	return can_interact
end

BTConditions.is_slot_not_wielded = function (blackboard, args)
	local wielded_slot = blackboard.inventory_extension:equipment().wielded_slot
	local wanted_slot = args[1]

	return wielded_slot ~= wanted_slot
end

local function is_there_threat_to_aid(self_unit, proximite_enemies, force_aid)
	for _, enemy_unit in pairs(proximite_enemies) do
		if unit_alive(enemy_unit) then
			local enemy_blackboard = Unit.get_data(enemy_unit, "blackboard")
			local enemy_breed = enemy_blackboard.breed

			if enemy_blackboard.target_unit == self_unit and (not force_aid or enemy_breed.is_bot_aid_threat) then
				return true
			end
		end
	end

	return false
end

local function can_interact_with_ally(self_unit, target_ally_unit)
	local interactable_extension = ScriptUnit.extension(target_ally_unit, "interactable_system")
	local interactor_unit = interactable_extension:is_being_interacted_with()
	local can_interact_with_ally = interactor_unit == nil or interactor_unit == self_unit

	return can_interact_with_ally
end

BTConditions.can_revive = function (blackboard)
	if blackboard.target_ally_need_type == "knocked_down" then
		local ally_distance = blackboard.ally_distance

		if ally_distance > 2.25 then
			return false
		end

		local self_unit = blackboard.unit
		local target_ally_unit = blackboard.target_ally_unit
		local health = ScriptUnit.extension(target_ally_unit, "health_system"):current_health_percent()

		if health > 0.3 and is_there_threat_to_aid(self_unit, blackboard.proximite_enemies, blackboard.force_aid) then
			return false
		end

		local destination_reached = blackboard.navigation_extension:destination_reached()
		local can_interact_with_ally = can_interact_with_ally(self_unit, target_ally_unit)
		local bot_stuck_threshold = 1

		if can_interact_with_ally and (destination_reached or ally_distance < 1 or Vector3.length_squared(blackboard.locomotion_extension:current_velocity()) < bot_stuck_threshold * bot_stuck_threshold) then
			return true
		end
	end
end

BTConditions.can_heal_player = function (blackboard)
	if blackboard.target_ally_need_type == "in_need_of_heal" then
		if blackboard.is_healing_other then
			return true
		end

		local ally_distance = blackboard.ally_distance

		if ally_distance > 2.5 then
			return false
		end

		if #blackboard.proximite_enemies > 0 then
			return false
		end

		local self_unit = blackboard.unit
		local target_ally_unit = blackboard.target_ally_unit
		local destination_reached = blackboard.navigation_extension:destination_reached()
		local can_interact_with_ally = can_interact_with_ally(self_unit, target_ally_unit)

		if can_interact_with_ally and destination_reached then
			return true
		end
	end
end

BTConditions.can_help_in_need_player = function (blackboard, args)
	local need_type = args[1]

	if blackboard.target_ally_need_type == need_type then
		local ally_distance = blackboard.ally_distance

		if ally_distance > 2.5 then
			return false
		end

		local self_unit = blackboard.unit
		local target_ally_unit = blackboard.target_ally_unit
		local destination_reached = blackboard.navigation_extension:destination_reached()
		local can_interact_with_ally = can_interact_with_ally(self_unit, target_ally_unit)

		if can_interact_with_ally and destination_reached then
			return true
		end
	end
end

BTConditions.can_rescue_hanging_from_hook = function (blackboard)
	if blackboard.target_ally_need_type == "hook" then
		local ally_distance = blackboard.ally_distance

		if ally_distance > 2.25 then
			return false
		end

		local self_unit = blackboard.unit

		if is_there_threat_to_aid(self_unit, blackboard.proximite_enemies, blackboard.force_aid) then
			return false
		end

		local target_ally_unit = blackboard.target_ally_unit
		local destination_reached = blackboard.navigation_extension:destination_reached()
		local can_interact_with_ally = can_interact_with_ally(self_unit, target_ally_unit)

		if can_interact_with_ally and (destination_reached or blackboard.current_interaction_unit == target_ally_unit) then
			return true
		end
	end
end

BTConditions.can_rescue_ledge_hanging = function (blackboard)
	if blackboard.target_ally_need_type == "ledge" then
		local ally_distance = blackboard.ally_distance

		if ally_distance > 2.25 then
			return false
		end

		local self_unit = blackboard.unit

		if is_there_threat_to_aid(self_unit, blackboard.proximite_enemies, blackboard.force_aid) then
			return false
		end

		local target_ally_unit = blackboard.target_ally_unit
		local destination_reached = blackboard.navigation_extension:destination_reached()
		local can_interact_with_ally = can_interact_with_ally(self_unit, target_ally_unit)

		if can_interact_with_ally and destination_reached then
			return true
		end
	end
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
	return blackboard.closing or blackboard.target_dist > 7
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
	return not blackboard.high_ground_opportunity and not blackboard.pouncing_target and (blackboard.is_falling or blackboard.fall_state ~= nil)
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

BTConditions.can_trigger_move_to = function (blackboard)
	local t = Managers.time:time("game")
	local trigger_time = blackboard.trigger_time or 0

	return t > trigger_time and unit_alive(blackboard.target_unit)
end

BTConditions.globadier_skulked_for_too_long = function (blackboard)
	local adv_data = blackboard.advance_towards_players
	local skulk_timeout = 15

	if adv_data then
		local t = Managers.time:time("game")
		local throw_globe_data = blackboard.throw_globe_data

		if throw_globe_data and throw_globe_data.next_throw_at then
			return t > throw_globe_data.next_throw_at + skulk_timeout
		else
			return adv_data.timer > adv_data.time_until_first_throw + skulk_timeout
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
			return t > last_fired + skulk_timeout
		elseif lurk_start then
			return t > lurk_start + skulk_timeout
		end
	end

	return false
end

BTConditions.grey_seer_first_teleport = function (blackboard)
	return BTConditions.grey_seer_teleport(blackboard, 1)
end

BTConditions.grey_seer_second_teleport = function (blackboard)
	return BTConditions.grey_seer_teleport(blackboard, 2)
end

BTConditions.grey_seer_third_teleport = function (blackboard)
	return BTConditions.grey_seer_teleport(blackboard, 3)
end

BTConditions.grey_seer_teleport = function (blackboard, index)
	assert(index, "[BTConditions.grey_seer_teleport] Missing teleport index for grey_seer_teleport condition")

	local teleport_done = blackboard.teleports_done[index]

	if teleport_done then
		return false
	end

	if blackboard.is_teleporting then
		return true
	end

	local next_auto_teleport_at = blackboard.next_auto_teleport_at
	local time = Managers.time:time("main")

	if next_auto_teleport_at < time then
		blackboard.teleport_triggered_by = "time"

		return true
	end

	local self_unit = blackboard.unit
	local position = POSITION_LOOKUP[self_unit]
	local locomotion_system = Managers.state.entity:system("locomotion_system")
	local broadphase = locomotion_system.player_broadphase
	local teleport_index = "teleport_" .. index
	local action_data = BreedActions.skaven_grey_seer[teleport_index]
	local player_distance = action_data.player_distance

	if player_distance then
		local player_distance_sq = player_distance * player_distance

		for i = 1, #PLAYER_AND_BOT_POSITIONS, 1 do
			local player_position = PLAYER_AND_BOT_POSITIONS[i]
			local distance_squared = Vector3.distance_squared(player_position, position)

			if distance_squared < player_distance_sq then
				blackboard.teleport_triggered_by = "distance"

				return true
			end
		end
	end

	local damage_threshold = action_data.damage_threshold

	if damage_threshold then
		local health_extension = ScriptUnit.extension(self_unit, "health_system")
		local current_damage = health_extension:current_damage()

		if damage_threshold < current_damage then
			blackboard.teleport_triggered_by = "damage"

			return true
		end
	end

	return false
end

BTConditions.health_lost_percent = function (blackboard, args)
	local min = args[1]
	local max = args[2]
	local lost_percent = 1 - ScriptUnit.extension(blackboard.unit, "health_system"):current_health_percent()

	return min <= lost_percent and lost_percent <= max
end

BTConditions.less_than = function (blackboard, args)
	return blackboard[args[1]] < args[2]
end

BTConditions.should_defensive_idle = function (blackboard)
	local t = Managers.time:time("game")
	local time_since_surrounding_players = t - blackboard.surrounding_players_last

	return blackboard.defensive_mode_duration and time_since_surrounding_players >= 3
end

return
