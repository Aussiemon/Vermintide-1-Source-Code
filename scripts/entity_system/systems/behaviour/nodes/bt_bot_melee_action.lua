require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBotMeleeAction = class(BTBotMeleeAction, BTNode)

BTBotMeleeAction.init = function (self, ...)
	BTBotMeleeAction.super.init(self, ...)
end

BTBotMeleeAction.name = "BTBotMeleeAction"
local OPTIMAL_MELEE_RANGE = 1.4
local MAXIMAL_MELEE_RANGE = 3
local PATROL_PASSIVE_RANGE = 50

local function check_angle(nav_world, target_position, start_direction, angle, distance)
	local direction = Quaternion.rotate(Quaternion(Vector3.up(), angle), start_direction)
	local check_pos = target_position - direction * distance
	local success, altitude = GwNavQueries.triangle_from_position(nav_world, check_pos, 0.5, 0.5)

	if success then
		check_pos.z = altitude

		return true, check_pos
	else
		return false
	end
end

local function get_engage_pos(nav_world, target_unit_pos, engage_from, melee_distance)
	local subdivisions_per_side = 3
	local angle_inc = math.pi / (subdivisions_per_side + 1)
	local start_direction = Vector3.normalize(Vector3.flat(engage_from))
	local success, pos = check_angle(nav_world, target_unit_pos, start_direction, 0, melee_distance)

	if success then
		return pos
	end

	for i = 1, subdivisions_per_side, 1 do
		local angle = angle_inc * i
		success, pos = check_angle(nav_world, target_unit_pos, start_direction, angle, melee_distance)

		if success then
			return pos
		end

		success, pos = check_angle(nav_world, target_unit_pos, start_direction, -angle, melee_distance)

		if success then
			return pos
		end
	end

	success, pos = check_angle(nav_world, target_unit_pos, start_direction, math.pi, melee_distance)

	if success then
		return pos
	end

	return nil
end

BTBotMeleeAction.enter = function (self, unit, blackboard, t)
	blackboard.node_timer = t
	blackboard.melee = {
		engage_update_time = 0,
		engage_position_set = false,
		engage_change_time = 0,
		engaging = false,
		engage_position = Vector3Box(0, 0, 0)
	}
	local inventory_ext = blackboard.inventory_extension
	local wielded_slot_name = inventory_ext:get_wielded_slot_name()
	local slot_data = inventory_ext:get_slot_data(wielded_slot_name)
	local item_data = slot_data.item_data
	local item_template = BackendUtils.get_item_template(item_data)
	blackboard.wielded_item_template = item_template
	local input_ext = blackboard.input_extension
	local soft_aiming = true

	input_ext:set_aiming(true, soft_aiming)
end

BTBotMeleeAction.leave = function (self, unit, blackboard, t)
	blackboard.wielded_item_template = nil
	local input_ext = blackboard.input_extension

	input_ext:set_aiming(false)

	if blackboard.melee.engaging then
		self:_disengage(unit, t, blackboard)
	end
end

BTBotMeleeAction.run = function (self, unit, blackboard, t, dt)
	local done, evaluate = self:_update_melee(unit, blackboard, dt, t)

	if done then
		return "done", "evaluate"
	else
		return "running", (evaluate and "evaluate") or nil
	end
end

BTBotMeleeAction._update_engage_position = function (self, unit, blackboard, dt, t)
	local self_position = POSITION_LOOKUP[unit]
	local target_unit = blackboard.target_unit
	local target_unit_pos = POSITION_LOOKUP[target_unit]

	if self._tree_node.action_data.destroy_object then
		target_unit_pos = Unit.local_position(blackboard.breakable_object, 0)
	end

	local engage_position, engage_from = nil
	local attacking_me, breed = self:_is_attacking_me(unit, target_unit)
	local enemy_offset = target_unit_pos - self_position
	local melee_distance = (breed and breed.bot_optimal_melee_distance) or OPTIMAL_MELEE_RANGE

	if breed and (not attacking_me or breed.bots_flank_while_targeted) and breed.bots_should_flank then
		local enemy_rot = Unit.local_rotation(target_unit, 0)
		local enemy_dir = Quaternion.forward(enemy_rot)

		if Vector3.dot(enemy_dir, enemy_offset) > -0.25 then
			engage_from = enemy_offset
		else
			local normalized_enemy_dir = Vector3.normalize(Vector3.flat(enemy_dir))
			local normalized_enemy_offset = Vector3.normalize(Vector3.flat(enemy_offset))
			local offset_angle = Vector3.flat_angle(-normalized_enemy_offset, normalized_enemy_dir)
			local new_angle = nil

			if offset_angle > 0 then
				new_angle = offset_angle + math.pi / 8
			else
				new_angle = offset_angle - math.pi / 8
			end

			local new_rot = Quaternion.multiply(Quaternion(Vector3.up(), -new_angle), enemy_rot)
			engage_from = -Quaternion.forward(new_rot)
		end

		engage_position = get_engage_pos(blackboard.nav_world, target_unit_pos, engage_from, melee_distance)
	elseif Vector3.length(self_position - target_unit_pos) <= melee_distance then
		engage_position = self_position
	else
		engage_position = get_engage_pos(blackboard.nav_world, target_unit_pos, enemy_offset, melee_distance)
	end

	if engage_position then
		local melee_bb = blackboard.melee
		local override_box = blackboard.navigation_destination_override
		local override_destination = override_box:unbox()
		local engage_pos_set = melee_bb.engage_position_set

		assert(not engage_pos_set or Vector3.is_valid(override_destination))

		if not engage_pos_set or Vector3.length(engage_position - override_destination) > 0.1 then
			override_box:store(engage_position)

			melee_bb.engage_position_set = true
		end

		local distance = Vector3.distance(self_position, engage_position)
		local min_dist = 3
		local max_dist = 7
		local interval = math.auto_lerp(min_dist, max_dist, 0.2, 2, math.clamp(distance, min_dist, max_dist))
		melee_bb.engage_update_time = t + interval
	end
end

BTBotMeleeAction._is_in_melee_range = function (self, self_unit, blackboard, current_position, aim_position)
	return Vector3.distance(aim_position, current_position) < MAXIMAL_MELEE_RANGE
end

BTBotMeleeAction._is_in_engage_range = function (self, self_unit, blackboard, action_data, current_position, aim_position, follow_pos)
	local engage_range = nil

	if Vector3.distance(follow_pos, current_position) < 5 then
		engage_range = action_data.engage_range_near_follow_pos
	else
		engage_range = action_data.engage_range
	end

	return Vector3.length(aim_position - current_position) < engage_range
end

BTBotMeleeAction._aim_position = function (self, target_unit, blackboard)
	local node = 0
	local target_breed = Unit.get_data(target_unit, "breed")
	local aim_node = (target_breed and target_breed.bot_melee_aim_node) or "j_spine"

	if Unit.has_node(target_unit, aim_node) then
		node = Unit.node(target_unit, aim_node)
	end

	return Unit.world_position(target_unit, node)
end

BTBotMeleeAction._is_attacking_me = function (self, self_unit, enemy_unit)
	if not ScriptUnit.has_extension(enemy_unit, "ai_system") then
		return false
	end

	local ai_extension = ScriptUnit.extension(enemy_unit, "ai_system")
	local bb = ai_extension:blackboard()

	return (bb.attacking_target == self_unit and not bb.attack_success and "attack") or (bb.special_attacking_target == self_unit and not bb.attack_success and "special_attack"), bb.breed
end

BTBotMeleeAction._allow_engage = function (self, self_unit, target_unit, blackboard, action_data, already_engaged, aim_position, follow_pos)
	local num_enemies = Managers.state.entity:system("ai_system").number_ordinary_aggroed_enemies
	local override_range_default = action_data.override_engage_range_to_follow_pos
	local horde_override_range = action_data.override_engage_range_to_follow_pos_horde
	local START_HORDE = 10
	local MAX_HORDE = 30
	local lerp_t = (num_enemies - START_HORDE) / (MAX_HORDE - START_HORDE)
	local override_range = nil

	if lerp_t <= 0 then
		override_range = override_range_default
	elseif lerp_t >= 1 then
		override_range = horde_override_range
	else
		override_range = math.lerp(override_range_default, horde_override_range, lerp_t * lerp_t)
	end

	local distance_to_follow_pos = Vector3.distance(aim_position, follow_pos)
	local fuzziness = (already_engaged and 3) or 0

	if (override_range or math.huge) < distance_to_follow_pos + fuzziness then
		return false
	end

	local follow_unit = blackboard.ai_bot_group_extension.data.follow_unit

	if follow_unit then
		local conflict_director = Managers.state.conflict
		local self_segment = conflict_director:get_player_unit_segment(self_unit)
		local target_segment = conflict_director:get_player_unit_segment(follow_unit)

		if self_segment and target_segment and self_segment < target_segment then
			return false
		end
	end

	if blackboard.target_ally_needs_aid then
		local ai_bot_group_system = Managers.state.entity:system("ai_bot_group_system")
		local is_prioritized_ally = ai_bot_group_system:is_prioritized_ally(self_unit, blackboard.target_ally_unit)

		if is_prioritized_ally then
			return false
		end
	end

	local priority_target = blackboard.priority_target_enemy

	if target_unit ~= priority_target then
		local ai_groups = Managers.state.entity:system("ai_group_system").groups
		local self_travel_dist = Managers.state.conflict:get_player_unit_travel_distance(self_unit) or -math.huge

		for _, group in pairs(ai_groups) do
			if group.template == "storm_vermin_formation_patrol" and group.state ~= "in_combat" then
				local patrol_travel_dist = group.main_path_travel_dist

				if not patrol_travel_dist or self_travel_dist < patrol_travel_dist + PATROL_PASSIVE_RANGE then
					return false
				end
			end
		end
	end

	local in_total_darkness = Managers.state.entity:system("darkness_system"):is_in_darkness(POSITION_LOOKUP[target_unit] or Unit.world_position(target_unit, 0), DarknessSystem.TOTAL_DARKNESS_THRESHOLD)

	if in_total_darkness and target_unit ~= blackboard.breakable_object and target_unit ~= priority_target and target_unit ~= blackboard.urgent_target_enemy and target_unit ~= blackboard.opportunity_target_enemy and not blackboard.aggressive_mode and not blackboard.target_ally_needs_aid then
		return false
	end

	return true
end

BTBotMeleeAction._update_melee = function (self, unit, blackboard, dt, t)
	local action_data = self._tree_node.action_data
	local target_unit = (action_data.destroy_object and blackboard.breakable_object) or blackboard.target_unit
	local melee_bb = blackboard.melee
	local already_engaged = melee_bb.engaging

	if not AiUtils.unit_alive(target_unit) then
		return true
	end

	local aim_position = self:_aim_position(target_unit, blackboard)
	local input_ext = blackboard.input_extension

	input_ext:set_aim_position(aim_position)

	local wants_engage, eval_timer = nil
	local current_position = blackboard.first_person_extension:current_position()
	local follow_pos = (blackboard.follow and blackboard.follow.target_position:unbox()) or current_position

	if self:_is_in_melee_range(unit, blackboard, current_position, aim_position) then
		if not self:_defend(unit, blackboard, target_unit, input_ext, t, true) then
			self:_attack(unit, blackboard, input_ext, target_unit)
		end

		wants_engage = blackboard.aggressive_mode or (melee_bb.engaging and t - melee_bb.engage_change_time < 5)
		eval_timer = 2
	elseif self:_is_in_engage_range(unit, blackboard, action_data, current_position, aim_position, follow_pos) then
		self:_defend(unit, blackboard, target_unit, input_ext, t, false)

		wants_engage = true
		eval_timer = 1
	else
		self:_defend(unit, blackboard, target_unit, input_ext, t, false)

		wants_engage = melee_bb.engaging and t - melee_bb.engage_change_time <= 0
		eval_timer = 3
	end

	local engage = wants_engage and self:_allow_engage(unit, target_unit, blackboard, action_data, already_engaged, aim_position, follow_pos)

	if engage and not already_engaged then
		self:_engage(t, blackboard)

		already_engaged = true
	elseif not engage and already_engaged then
		self:_disengage(unit, t, blackboard)

		already_engaged = false
	end

	if already_engaged and (not melee_bb.engage_update_time or melee_bb.engage_update_time < t) then
		self:_update_engage_position(unit, blackboard, dt, t)
	end

	return false, self:_evaluation_timer(blackboard, t, eval_timer)
end

local DEFAULT_DEFENSE_META_DATA = {
	push = "medium"
}

BTBotMeleeAction._defend = function (self, unit, blackboard, target_unit, input_ext, t, in_melee_range)
	if self:_is_attacking_me(unit, target_unit) then
		local defense_meta_data = blackboard.wielded_item_template.defense_meta_data or DEFAULT_DEFENSE_META_DATA
		local num_enemies = #blackboard.proximite_enemies
		local current_fatigue, max_fatigue = ScriptUnit.extension(unit, "status_system"):current_fatigue_points()
		local stamina_left = max_fatigue - current_fatigue
		local push_type = defense_meta_data.push
		local low_stamina = (push_type == "light" and stamina_left <= 2) or stamina_left <= 3
		local breed = Unit.get_data(target_unit, "breed")

		if not in_melee_range or not breed or breed.boss or (breed.armor_category == 2 and push_type ~= "heavy") or (push_type == "light" and num_enemies > 2) or low_stamina then
			input_ext:defend()
		else
			input_ext:melee_push()
		end

		return true
	else
		return false
	end
end

local DEFAULT_ATTACK_META_DATA = {
	tap_attack = {
		penetrating = false,
		arc = 0
	},
	hold_attack = {
		penetrating = true,
		arc = 2
	}
}

BTBotMeleeAction._attack = function (self, unit, blackboard, input_ext, target_unit)
	local num_enemies = #blackboard.proximite_enemies
	local outnumbered = num_enemies > 1
	local massively_outnumbered = num_enemies > 3
	local target_breed = Unit.get_data(target_unit, "breed")
	local target_armor = (target_breed and target_breed.armor_category) or 1
	local item_template = blackboard.wielded_item_template
	local weapon_meta_data = item_template.attack_meta_data or DEFAULT_ATTACK_META_DATA
	local best_utility = -1
	local best_attack_input = nil

	for attack_input, attack_meta_data in pairs(weapon_meta_data) do
		local utility = 0

		if outnumbered and attack_meta_data.arc == 1 then
			utility = utility + 1
		elseif attack_meta_data.no_damage and massively_outnumbered and attack_meta_data.arc > 1 then
			utility = utility + 2
		elseif not attack_meta_data.no_damage and ((outnumbered and attack_meta_data.arc > 1) or (not outnumbered and attack_meta_data.arc == 0)) then
			utility = utility + 4
		end

		if target_armor ~= 2 or attack_meta_data.penetrating then
			utility = utility + 8
		end

		if best_utility < utility then
			best_utility = utility
			best_attack_input = attack_input
		end
	end

	input_ext[best_attack_input](input_ext)
end

BTBotMeleeAction._evaluation_timer = function (self, blackboard, t, timer_value)
	local evaluate = timer_value < t - blackboard.node_timer

	if evaluate then
		blackboard.node_timer = t

		return true
	else
		return false
	end
end

BTBotMeleeAction._disengage = function (self, unit, t, blackboard, position)
	local bb = blackboard.melee
	bb.engaging = false
	bb.engage_change_time = t

	if blackboard.follow then
		bb.engage_position_set = false
	end
end

BTBotMeleeAction._engage = function (self, t, blackboard)
	local bb = blackboard.melee
	bb.engaging = true
	bb.engage_change_time = t
end

return
