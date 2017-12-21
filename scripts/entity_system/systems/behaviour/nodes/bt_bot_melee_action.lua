require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBotMeleeAction = class(BTBotMeleeAction, BTNode)
BTBotMeleeAction.init = function (self, ...)
	BTBotMeleeAction.super.init(self, ...)

	return 
end
BTBotMeleeAction.name = "BTBotMeleeAction"
local OPTIMAL_MELEE_RANGE = 1.4
local MAXIMAL_MELEE_RANGE = 3
local PATROL_PASSIVE_RANGE = 50

local function check_angle(nav_world, target_position, start_direction, angle, distance)
	local direction = Quaternion.rotate(Quaternion(Vector3.up(), angle), start_direction)
	local check_pos = target_position - direction*distance
	local success, altitude = GwNavQueries.triangle_from_position(nav_world, check_pos, 0.5, 0.5)

	if success then
		check_pos.z = altitude

		return true, check_pos
	else
		return false
	end

	return 
end

local function get_engage_pos(nav_world, target_unit_pos, engage_from, melee_distance)
	local subdivisions_per_side = 3
	local angle_inc = math.pi/(subdivisions_per_side + 1)
	local start_direction = Vector3.normalize(Vector3.flat(engage_from))
	local success, pos = check_angle(nav_world, target_unit_pos, start_direction, 0, melee_distance)

	if success then
		return pos
	end

	for i = 1, subdivisions_per_side, 1 do
		local angle = angle_inc*i
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
	local input_ext = blackboard.input_extension
	local soft_aiming = true

	input_ext.set_aiming(input_ext, true, soft_aiming)

	return 
end
BTBotMeleeAction.leave = function (self, unit, blackboard, t)
	local input_ext = blackboard.input_extension

	input_ext.set_aiming(input_ext, false)

	if blackboard.melee.engaging then
		self._disengage(self, unit, t, blackboard)
	end

	return 
end
BTBotMeleeAction.run = function (self, unit, blackboard, t, dt)
	local done, evaluate = self._update_melee(self, unit, blackboard, dt, t)
	local melee_bb = blackboard.melee

	if melee_bb.engaging and (not melee_bb.engage_update_time or melee_bb.engage_update_time < t) then
		self._update_engage_position(self, unit, blackboard, dt, t)
	end

	if done then
		return "done", "evaluate"
	else
		return "running", (evaluate and "evaluate") or nil
	end

	return 
end
BTBotMeleeAction._update_engage_position = function (self, unit, blackboard, dt, t)
	local self_position = POSITION_LOOKUP[unit]
	local target_unit = blackboard.target_unit
	local target_unit_pos = POSITION_LOOKUP[target_unit]

	if self._tree_node.action_data.destroy_object then
		target_unit_pos = Unit.local_position(blackboard.breakable_object, 0)
	end

	local engage_position, engage_from = nil
	local attacking_me, breed = self._is_attacking_me(self, unit, target_unit)
	local enemy_offset = target_unit_pos - self_position
	local melee_distance = (breed and breed.bot_optimal_melee_distance) or OPTIMAL_MELEE_RANGE

	if breed and (not attacking_me or breed.bots_flank_while_targeted) and breed.bots_should_flank then
		local enemy_rot = Unit.local_rotation(target_unit, 0)
		local enemy_dir = Quaternion.forward(enemy_rot)

		if -0.25 < Vector3.dot(enemy_dir, enemy_offset) then
			engage_from = enemy_offset
		else
			local normalized_enemy_dir = Vector3.normalize(Vector3.flat(enemy_dir))
			local normalized_enemy_offset = Vector3.normalize(Vector3.flat(enemy_offset))
			local offset_angle = Vector3.flat_angle(-normalized_enemy_offset, normalized_enemy_dir)
			local new_angle = nil

			if 0 < offset_angle then
				new_angle = offset_angle + math.pi/8
			else
				new_angle = offset_angle - math.pi/8
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
		local override_destination = override_box.unbox(override_box)
		local engage_pos_set = melee_bb.engage_position_set

		assert(not engage_pos_set or Vector3.is_valid(override_destination))

		if not engage_pos_set or 0.1 < Vector3.length(engage_position - override_destination) then
			override_box.store(override_box, engage_position)

			melee_bb.engage_position_set = true
		end

		local distance = Vector3.distance(self_position, engage_position)
		local min_dist = 3
		local max_dist = 7
		local interval = math.auto_lerp(min_dist, max_dist, 0.2, 2, math.clamp(distance, min_dist, max_dist))
		melee_bb.engage_update_time = t + interval
	end

	return 
end
BTBotMeleeAction._is_in_melee_range = function (self, self_unit, blackboard, aim_position)
	return Vector3.length(aim_position - blackboard.first_person_extension:current_position()) < MAXIMAL_MELEE_RANGE
end
BTBotMeleeAction._is_in_push_range = function (self, self_unit, blackboard, aim_position)
	return Vector3.length(aim_position - blackboard.first_person_extension:current_position()) < 1.75
end
BTBotMeleeAction._is_in_engage_range = function (self, self_unit, blackboard, aim_position, follow_position)
	local engage_range = nil
	local current_position = blackboard.first_person_extension:current_position()
	local action_data = self._tree_node.action_data

	if follow_position then
		local distance_to_follow_pos = Vector3.length(current_position - follow_position)
		local passive_patrol = false
		local ai_groups = Managers.state.entity:system("ai_group_system").groups
		local self_travel_dist = Managers.state.conflict:get_player_unit_travel_distance(self_unit) or -math.huge

		for _, group in pairs(ai_groups) do
			if group.template == "storm_vermin_formation_patrol" and group.state ~= "in_combat" then
				local patrol_travel_dist = group.main_path_travel_dist

				if not patrol_travel_dist or self_travel_dist < patrol_travel_dist + PATROL_PASSIVE_RANGE then
					passive_patrol = true
				end
			end
		end

		if distance_to_follow_pos < 5 then
			engage_range = action_data.engage_range_near_follow_pos
		elseif (action_data.override_engage_range_to_follow_pos or math.huge) < distance_to_follow_pos then
			return false
		elseif passive_patrol then
			engage_range = action_data.engage_range_passive_patrol
		else
			engage_range = action_data.engage_range
		end
	else
		engage_range = action_data.engage_range_near_follow_pos
	end

	return Vector3.length(aim_position - current_position) < engage_range
end
BTBotMeleeAction._aim_position = function (self, target_unit, blackboard)
	local node = 0

	if Unit.has_node(target_unit, "j_spine") then
		node = Unit.node(target_unit, "j_spine")
	end

	return Unit.world_position(target_unit, node)
end
BTBotMeleeAction._is_attacking_me = function (self, self_unit, enemy_unit)
	if not ScriptUnit.has_extension(enemy_unit, "ai_system") then
		return false
	end

	local ai_extension = ScriptUnit.extension(enemy_unit, "ai_system")
	local bb = ai_extension.blackboard(ai_extension)

	return (bb.attacking_target == self_unit and not bb.attack_success and "attack") or (bb.special_attacking_target == self_unit and not bb.attack_success and "special_attack"), bb.breed
end
BTBotMeleeAction._allow_engage = function (self, self_unit, target_unit, blackboard)
	local follow_unit = blackboard.ai_bot_group_extension.data.follow_unit

	if follow_unit then
		local conflict_director = Managers.state.conflict
		local self_segment = conflict_director.get_player_unit_segment(conflict_director, self_unit)
		local target_segment = conflict_director.get_player_unit_segment(conflict_director, follow_unit)

		if self_segment and target_segment and self_segment < target_segment then
			return false
		end
	end

	if blackboard.target_ally_needs_aid then
		local ai_bot_group_system = Managers.state.entity:system("ai_bot_group_system")
		local is_prioritized_ally = ai_bot_group_system.is_prioritized_ally(ai_bot_group_system, self_unit, blackboard.target_ally_unit)

		if is_prioritized_ally then
			return false
		end
	end

	local in_total_darkness = Managers.state.entity:system("darkness_system"):is_in_darkness(POSITION_LOOKUP[target_unit] or Unit.world_position(target_unit, 0), DarknessSystem.TOTAL_DARKNESS_THRESHOLD)

	if in_total_darkness and target_unit ~= blackboard.breakable_object and target_unit ~= blackboard.priority_target_enemy and target_unit ~= blackboard.urgent_target_enemy and target_unit ~= blackboard.opportunity_target_enemy and not blackboard.aggressive_mode and not blackboard.target_ally_needs_aid then
		return false
	end

	return true
end
BTBotMeleeAction._update_melee = function (self, unit, blackboard, dt, t)
	local target_unit = blackboard.target_unit

	if self._tree_node.action_data.destroy_object then
		target_unit = blackboard.breakable_object
	end

	if not AiUtils.unit_alive(target_unit) then
		if blackboard.melee.engaging then
			self._disengage(self, unit, t, blackboard)
		end

		return true
	end

	local aim_position = self._aim_position(self, target_unit, blackboard)
	local input_ext = blackboard.input_extension

	input_ext.set_aim_position(input_ext, aim_position)

	local melee_bb = blackboard.melee
	local wants_engage, eval_timer = nil

	if self._is_in_melee_range(self, unit, blackboard, aim_position) then
		if not self._defend(self, unit, target_unit, input_ext, t) then
			self._attack(self, unit, blackboard, input_ext, target_unit)
		end

		wants_engage = blackboard.aggressive_mode or (melee_bb.engaging and t - melee_bb.engage_change_time < 5)
		eval_timer = 2
	elseif self._is_in_engage_range(self, unit, blackboard, aim_position, blackboard.follow and blackboard.follow.target_position:unbox()) then
		self._defend(self, unit, target_unit, input_ext, t)

		wants_engage = true
		eval_timer = 1
	else
		self._defend(self, unit, target_unit, input_ext, t)

		wants_engage = melee_bb.engaging and t - melee_bb.engage_change_time <= 0
		eval_timer = 3
	end

	local engage = wants_engage and self._allow_engage(self, unit, target_unit, blackboard)

	if engage and not melee_bb.engaging then
		self._engage(self, t, blackboard)
	elseif not engage and melee_bb.engaging then
		self._disengage(self, unit, t, blackboard)
	end

	return false, self._evaluation_timer(self, blackboard, t, eval_timer)
end
BTBotMeleeAction._defend = function (self, unit, target_unit, input_ext, t)
	if self._is_attacking_me(self, unit, target_unit) then
		input_ext.defend(input_ext)

		return true
	else
		return false
	end

	return 
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
	local outnumbered = 1 < num_enemies
	local massively_outnumbered = 3 < num_enemies
	local target_breed = Unit.get_data(target_unit, "breed")
	local target_armor = (target_breed and target_breed.armor_category) or 1
	local inventory_ext = blackboard.inventory_extension
	local wielded_slot_name = inventory_ext.get_wielded_slot_name(inventory_ext)
	local slot_data = inventory_ext.get_slot_data(inventory_ext, wielded_slot_name)
	local item_data = slot_data.item_data
	local item_template = BackendUtils.get_item_template(item_data)
	local weapon_meta_data = item_template.attack_meta_data or DEFAULT_ATTACK_META_DATA
	local best_utility = -1
	local best_attack_input = nil

	for attack_input, attack_meta_data in pairs(weapon_meta_data) do
		local utility = 0

		if outnumbered and attack_meta_data.arc == 1 then
			utility = utility + 1
		elseif attack_meta_data.no_damage and massively_outnumbered and 1 < attack_meta_data.arc then
			utility = utility + 2
		elseif not attack_meta_data.no_damage and ((outnumbered and 1 < attack_meta_data.arc) or (not outnumbered and attack_meta_data.arc == 0)) then
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

	return 
end
BTBotMeleeAction._evaluation_timer = function (self, blackboard, t, timer_value)
	local evaluate = timer_value < t - blackboard.node_timer

	if evaluate then
		blackboard.node_timer = t

		return true
	else
		return false
	end

	return 
end
BTBotMeleeAction._disengage = function (self, unit, t, blackboard, position)
	local bb = blackboard.melee
	bb.engaging = false
	bb.engage_change_time = t

	if blackboard.follow then
		bb.engage_position_set = false
	end

	return 
end
BTBotMeleeAction._engage = function (self, t, blackboard)
	local bb = blackboard.melee
	bb.engaging = true
	bb.engage_change_time = t

	return 
end

return 
