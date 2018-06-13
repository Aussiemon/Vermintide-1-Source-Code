require("scripts/unit_extensions/human/ai_player_unit/ai_navigation_extension")
require("scripts/unit_extensions/human/ai_player_unit/ai_brain")
require("scripts/unit_extensions/human/ai_player_unit/perception_utils")

local alive = Unit.alive
local PROXIMITY_CHECK_RANGE = 5
local PROXIMITY_CHECK_RANGE_ALLY_NEEDS_AID = 4.5
local PROXIMITY_CHECK_RANGE_ALLY_NEEDS_AID_REVIVING = 1.5
local PROXIMITY_CHECK_RANGE_ALLY_NEEDS_AID_SUPPORT = 15
local STICKYNESS_DISTANCE_MODIFIER = -0.2
local FOLLOW_TIMER_LOWER_BOUND = 1
local FOLLOW_TIMER_UPPER_BOUND = 1.5
local ENEMY_PATH_FAILED_REPATH_THRESHOLD = 9
local ENEMY_PATH_FAILED_REPATH_VERTICAL_THRESHOLD = 0.8
local ALLY_PATH_FAILED_REPATH_THRESHOLD = 0.25
local FLAT_MOVE_TO_EPSILON = 0.05
local Z_MOVE_TO_EPSILON = 0.3
local WANTS_TO_HEAL_THRESHOLD = 0.25
local WANTS_TO_GIVE_HEAL_TO_OTHER = 0.5
local SELF_UNIT = nil

function dprint(...)
	if SELF_UNIT == script_data.debug_unit and script_data.ai_bots_debug then
		print(...)
	end
end

PlayerBotBase = class(PlayerBotBase)

PlayerBotBase.init = function (self, extension_init_context, unit, extension_init_data)
	local world = extension_init_context.world
	self._world = world
	self._unit = unit
	self._nav_world = extension_init_data.nav_world
	self._enemy_broadphase = Managers.state.entity:system("ai_system").broadphase
	local override_box = Vector3Box(Vector3(0, 0, 0))
	override_box.value_stored = false
	self.is_bot = true
	self._blackboard = {
		target_ally_needs_aid = false,
		using_navigation_destination_override = false,
		is_passive = true,
		re_evaluate_detection = Math.random() * 0.5,
		world = world,
		unit = unit,
		level = LevelHelper:current_level(extension_init_context.world),
		move_orders = {},
		nav_world = self._nav_world,
		node_data = {},
		running_nodes = {},
		proximite_enemies = {},
		follow = {
			needs_target_position_refresh = true,
			follow_timer = math.lerp(FOLLOW_TIMER_LOWER_BOUND, FOLLOW_TIMER_UPPER_BOUND, Math.random()),
			target_position = Vector3Box(POSITION_LOOKUP[unit])
		},
		navigation_destination_override = override_box,
		proximity_target_distance = math.huge,
		urgent_target_distance = math.huge,
		opportunity_target_distance = math.huge,
		taking_cover = {
			fails = 0,
			threats = {},
			active_threats = {},
			cover_position = Vector3Box(Vector3.invalid_vector()),
			failed_cover_points = {}
		}
	}
	self._bot_profile = extension_init_data.bot_profile
	self._player = extension_init_data.player

	Unit.set_data(unit, "bot", self._bot_profile)
	Managers.player:assign_unit_ownership(unit, self._player, true)
	Unit.set_flow_variable(unit, "is_bot", true)
	Unit.flow_event(unit, "character_vo_set")
	self:_init_brain()

	self._proximity_target_update_timer = -math.huge
	self._pickup_search_timer = -math.huge
	self._search_for_pickups_near_ally = false
	self._interactable_timer = -math.huge
	self._update_broadphase = -math.huge
	self._attempted_enemy_paths = {}
	self._attempted_ally_paths = {}
	self._last_health_pickup_attempt = {
		blacklist = false,
		distance = 0,
		index = 1,
		path_failed = false,
		rotation = QuaternionBox(),
		path_position = Vector3Box()
	}
	self._last_mule_pickup_attempt = {
		blacklist = false,
		distance = 0,
		index = 1,
		path_failed = false,
		rotation = QuaternionBox(),
		path_position = Vector3Box()
	}
end

PlayerBotBase.ranged_attack_started = function (self, attacking_unit, victim_unit, attack_type)
	local blackboard = self._blackboard

	if attack_type == "ratling_gun_fire" then
		local targets = blackboard.taking_cover.threats
		targets[attacking_unit] = victim_unit
	end
end

PlayerBotBase.ranged_attack_ended = function (self, attacking_unit, victim_unit, attack_type)
	local blackboard = self._blackboard

	if attack_type == "ratling_gun_fire" then
		local targets = blackboard.taking_cover.threats
		targets[attacking_unit] = nil
	end
end

PlayerBotBase.extensions_ready = function (self, world, unit)
	local blackboard = self._blackboard
	local input_ext = ScriptUnit.extension(unit, "input_system")
	local inventory_ext = ScriptUnit.extension(unit, "inventory_system")
	local nav_ext = ScriptUnit.extension(unit, "ai_navigation_system")
	local first_person_ext = ScriptUnit.extension(unit, "first_person_system")
	local status_ext = ScriptUnit.extension(unit, "status_system")
	local interaction_ext = ScriptUnit.extension(unit, "interactor_system")
	local health_ext = ScriptUnit.extension(unit, "health_system")
	local ai_bot_group_ext = ScriptUnit.extension(unit, "ai_bot_group_system")
	local ai_system_ext = ScriptUnit.extension(unit, "ai_system")
	local locomotion_ext = ScriptUnit.extension(unit, "locomotion_system")
	self._health_extension = health_ext
	self._status_extension = status_ext
	self._locomotion_extension = locomotion_ext
	self._navigation_extension = nav_ext
	blackboard.input_extension = input_ext
	blackboard.inventory_extension = inventory_ext
	blackboard.navigation_extension = nav_ext
	blackboard.locomotion_extension = locomotion_ext
	blackboard.first_person_extension = first_person_ext
	blackboard.status_extension = status_ext
	blackboard.interaction_extension = interaction_ext
	blackboard.health_extension = health_ext
	blackboard.ai_bot_group_extension = ai_bot_group_ext
	blackboard.ai_system_extension = ai_system_ext
end

function bot_printf(unit, num, str, ...)
	local player = Managers.player:owner(unit)

	if player:name() == "player_bot_" .. num then
		printf(str, ...)
	end
end

PlayerBotBase._init_brain = function (self)
	self._brain = AIBrain:new(self._world, self._unit, self._blackboard, self._bot_profile, self._bot_profile.behavior)
end

PlayerBotBase.brain = function (self)
	return self._brain
end

PlayerBotBase.profile = function (self)
	return self._bot_profile
end

PlayerBotBase.blackboard = function (self)
	return self._blackboard
end

PlayerBotBase.update = function (self, unit, input, dt, context, t)
	Profiler.start("PlayerBotBase")

	local health_extension = self._health_extension
	local status_extension = self._status_extension
	local is_alive = health_extension:is_alive()
	local is_ready_for_assisted_respawn = status_extension:is_ready_for_assisted_respawn()

	if is_alive and not is_ready_for_assisted_respawn and not self._locomotion_extension:get_moving_platform() then
		SELF_UNIT = unit

		Profiler.start("update blackboard")
		self:_update_blackboard(dt, t)
		Profiler.stop("update blackboard")
		Profiler.start("update target enemy")
		self:_update_target_enemy(dt, t)
		Profiler.stop("update target enemy")
		Profiler.start("update target ally")
		self:_update_target_ally(dt, t)
		Profiler.stop("update target ally")
		Profiler.start("_update_rat_ogre_cover")
		self:_update_rat_ogre_cover(dt, t)
		Profiler.stop("_update_rat_ogre_cover")
		Profiler.start("update pickups")
		self:_update_pickups(dt, t)
		Profiler.stop("update pickups")
		Profiler.start("update interactables")
		self:_update_interactables(dt, t)
		Profiler.stop("update interactables")
		Profiler.start("update brain")
		self._brain:update(unit, t, dt)
		Profiler.stop("update brain")

		local is_disabled = status_extension:is_disabled()

		if is_disabled then
			self._navigation_extension:teleport(POSITION_LOOKUP[unit])
		else
			Profiler.start("update movement target")
			self:_update_movement_target(dt, t)
			Profiler.stop("update movement target")
		end
	end

	if script_data.ai_bots_debug then
		Profiler.start("update debug draw")
		self:_debug_draw_update(dt)
		Profiler.stop("update debug draw")
	end

	Profiler.stop("PlayerBotBase")
end

PlayerBotBase._update_blackboard = function (self, dt, t)
	local bb = self._blackboard
	local status_ext = self._status_extension
	bb.is_knocked_down = status_ext:is_knocked_down()
	bb.is_grabbed_by_pack_master = status_ext:is_grabbed_by_pack_master()
	bb.is_pounced_down = status_ext:is_pounced_down()
	bb.is_hanging_from_hook = status_ext:is_hanging_from_hook()
	bb.is_ledge_hanging = status_ext:get_is_ledge_hanging()
	bb.is_transported = status_ext:is_using_transport()

	if alive(bb.target_unit) then
		bb.target_dist = Vector3.distance(POSITION_LOOKUP[bb.target_unit], POSITION_LOOKUP[self._unit])
	else
		bb.target_dist = math.huge
	end

	if self._update_broadphase < t then
		local ai_bot_group_system = Managers.state.entity:system("ai_bot_group_system")
		local breakable_object = ai_bot_group_system:bot_breakable(self._unit)

		if breakable_object or bb.breakable_object then
			bb.breakable_object = breakable_object
		end

		self._update_broadphase = t + Math.random()
	end

	for _, action_data in pairs(bb.utility_actions) do
		action_data.time_since_last = t - action_data.last_time
	end
end

PlayerBotBase._update_target_enemy = function (self, dt, t)
	Profiler.start("update target enemy")

	local pos = POSITION_LOOKUP[self._unit]

	Profiler.start("update_slot_target")
	self:_update_slot_target(dt, t, pos)
	Profiler.stop("update_slot_target")
	Profiler.start("update_proximity_target")
	self:_update_proximity_target(dt, t, pos)
	Profiler.stop("update_proximity_target")

	local bb = self._blackboard
	local old_target = bb.target_unit
	local slot_enemy = bb.slot_target_enemy
	local prox_enemy = bb.proximity_target_enemy
	local priority_enemy = bb.priority_target_enemy
	local urgent_enemy = bb.urgent_target_enemy
	local opportunity_enemy = bb.opportunity_target_enemy
	local prox_enemy_dist = bb.proximity_target_distance + ((prox_enemy == old_target and STICKYNESS_DISTANCE_MODIFIER) or 0)
	local prio_enemy_dist = bb.priority_target_distance + ((priority_enemy == old_target and STICKYNESS_DISTANCE_MODIFIER) or 0)
	local urgent_enemy_dist = bb.urgent_target_distance + ((urgent_enemy == old_target and STICKYNESS_DISTANCE_MODIFIER) or 0)
	local opp_enemy_dist = bb.opportunity_target_distance + ((opportunity_enemy == old_target and STICKYNESS_DISTANCE_MODIFIER) or 0)

	if slot_enemy then
		local slot_enemy_dist = Vector3.length(POSITION_LOOKUP[slot_enemy] - pos) + ((slot_enemy == old_target and STICKYNESS_DISTANCE_MODIFIER) or 0)
	end

	if priority_enemy and prio_enemy_dist < 3 then
		bb.target_unit = priority_enemy
	elseif urgent_enemy and urgent_enemy_dist < 3 then
		bb.target_unit = urgent_enemy
	elseif opportunity_enemy and opp_enemy_dist < 3 then
		bb.target_unit = opportunity_enemy
	elseif slot_enemy and slot_enemy_dist < 3 then
		bb.target_unit = slot_enemy
	elseif prox_enemy and prox_enemy_dist < 2 then
		bb.target_unit = prox_enemy
	elseif priority_enemy then
		bb.target_unit = priority_enemy
	elseif urgent_enemy then
		bb.target_unit = urgent_enemy
	elseif opportunity_enemy then
		bb.target_unit = opportunity_enemy
	elseif slot_enemy then
		bb.target_unit = slot_enemy
	elseif bb.target_unit then
		bb.target_unit = nil
	end

	Profiler.stop("update target enemy")
end

local BROADPHASE_QUERY_TEMP = {}

PlayerBotBase._update_proximity_target = function (self, dt, t, self_position)
	if self._proximity_target_update_timer < t then
		local blackboard = self._blackboard
		local self_unit = self._unit
		self._proximity_target_update_timer = t + 0.25 + Math.random() * 0.15
		local prox_enemies = self._blackboard.proximite_enemies

		table.clear(prox_enemies)

		local check_range = PROXIMITY_CHECK_RANGE
		blackboard.aggressive_mode = false
		blackboard.force_aid = false
		local search_position = nil

		if alive(blackboard.target_ally_unit) and blackboard.target_ally_needs_aid and self:_within_aid_range(blackboard) then
			search_position = POSITION_LOOKUP[blackboard.target_ally_unit]
			local ai_bot_group_system = Managers.state.entity:system("ai_bot_group_system")
			local is_prioritized = ai_bot_group_system:is_prioritized_ally(self_unit, blackboard.target_ally_unit)
			local is_reviving = blackboard.current_interaction_unit == blackboard.target_ally_unit

			if is_prioritized and is_reviving then
				check_range = PROXIMITY_CHECK_RANGE_ALLY_NEEDS_AID_REVIVING
				blackboard.force_aid = true
			elseif is_prioritized then
				check_range = PROXIMITY_CHECK_RANGE_ALLY_NEEDS_AID
				blackboard.force_aid = true
			else
				blackboard.aggressive_mode = true
				check_range = PROXIMITY_CHECK_RANGE_ALLY_NEEDS_AID_SUPPORT
			end
		else
			search_position = self_position
		end

		local num_hits = Broadphase.query(self._enemy_broadphase, search_position, check_range, BROADPHASE_QUERY_TEMP)
		local closest_dist = math.huge
		local closest_enemy = nil
		local closest_real_dist = math.huge
		local index = 1

		for i = 1, num_hits, 1 do
			local unit = BROADPHASE_QUERY_TEMP[i]
			local health_ext = ScriptUnit.extension(unit, "health_system")

			if health_ext:is_alive() then
				local enemy_pos = POSITION_LOOKUP[unit]
				local enemy_offset = enemy_pos - search_position

				if self:_target_valid(unit, enemy_offset) then
					prox_enemies[index] = unit
					index = index + 1
					local enemy_real_dist = Vector3.length(enemy_offset)
					local enemy_dist = enemy_real_dist + ((unit == blackboard.target_unit and STICKYNESS_DISTANCE_MODIFIER) or 0)

					if closest_dist > enemy_dist then
						closest_enemy = unit
						closest_dist = enemy_dist
						closest_real_dist = enemy_real_dist
					end
				end
			end
		end

		table.clear(BROADPHASE_QUERY_TEMP)

		if blackboard.proximity_target_enemy or closest_enemy then
			blackboard.proximity_target_enemy = closest_enemy
		end

		blackboard.proximity_target_distance = closest_real_dist
	end
end

local PROXIMITY_UP_DOWN_THRESHOLD = math.sin(math.pi * 0.25)

PlayerBotBase._target_valid = function (self, unit, enemy_offset)
	local blackboard = Unit.get_data(unit, "blackboard")

	if not blackboard or blackboard.breed.not_bot_target then
		return false
	end

	if ScriptUnit.has_extension(unit, "ai_group_system") and not blackboard.target_unit then
		return false
	end

	local up_dot_product = Vector3.dot(Vector3.up(), Vector3.normalize(enemy_offset))

	if PROXIMITY_UP_DOWN_THRESHOLD < up_dot_product or up_dot_product < -PROXIMITY_UP_DOWN_THRESHOLD then
		return false
	end

	return true
end

PlayerBotBase._update_slot_target = function (self, dt, t, self_position)
	local bb = self._blackboard
	local unit = self._unit
	local current_target = bb.target_unit
	local pos = self_position
	local enemy_targetting_self = self:_get_closest_target_in_slot(pos, unit, current_target, true)

	if enemy_targetting_self then
		bb.slot_target_enemy = enemy_targetting_self

		return
	end

	local ally_unit = bb.target_ally_unit

	if alive(ally_unit) then
		local enemy_targetting_ally = self:_get_closest_target_in_slot(pos, ally_unit, current_target)

		if enemy_targetting_ally then
			bb.slot_target_enemy = enemy_targetting_ally

			return
		end
	end

	local players = Managers.player:human_and_bot_players()
	local best_target = nil
	local best_dist = math.huge

	for _, player in pairs(players) do
		local player_unit = player.player_unit

		if alive(player_unit) and player_unit ~= ally_unit and player_unit ~= unit then
			local target, dist = self:_get_closest_target_in_slot(pos, player_unit, current_target)

			if dist < best_dist then
				best_target = target
				best_dist = dist
			end
		end
	end

	if best_target then
		bb.slot_target_enemy = best_target

		return
	end

	if bb.slot_target_enemy then
		bb.slot_target_enemy = nil
	end
end

local BOT_THREAT_MODIFIER = -1

PlayerBotBase._get_closest_target_in_slot = function (self, position, unit, current_enemy_unit, is_self)
	local ai_slot_system = Managers.state.entity:system("ai_slot_system")
	local slot_data = ai_slot_system:get_target_unit_slot_data(unit)
	local best_target = nil
	local target_dist = math.huge

	for slot_index, slot in pairs(slot_data) do
		local enemy_unit = slot.ai_unit

		if alive(enemy_unit) and ScriptUnit.extension(enemy_unit, "health_system"):is_alive() then
			local dist = Vector3.length(POSITION_LOOKUP[enemy_unit] - position)

			if enemy_unit == current_enemy_unit then
				dist = dist + STICKYNESS_DISTANCE_MODIFIER
			end

			if is_self then
				local breed = Unit.get_data(enemy_unit, "breed")

				if breed.is_bot_threat then
					dist = dist + BOT_THREAT_MODIFIER
				end
			end

			if target_dist > dist then
				best_target = enemy_unit
				target_dist = dist
			end
		end
	end

	return best_target, target_dist
end

PlayerBotBase._alter_target_position = function (self, nav_world, self_position, unit, target_position, reason)
	local wanted_position = nil

	if reason == "ledge" then
		local rotation = Unit.local_rotation(unit, 0)
		local forward_vector_flat = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
		wanted_position = target_position - forward_vector_flat * 0.5
	elseif reason == "in_need_of_heal" or reason == "can_accept_grenade" or reason == "can_accept_potion" then
		wanted_position = target_position + Vector3.normalize(self_position - target_position)
	elseif reason == "knocked_down" and self._blackboard.aggressive_mode then
		wanted_position = target_position + Vector3.normalize(self_position - target_position)
	else
		wanted_position = Vector3(target_position.x, target_position.y, target_position.z)
	end

	local above = 0.5
	local below = 0.5
	local success, z = GwNavQueries.triangle_from_position(nav_world, wanted_position, above, below)

	if success then
		wanted_position.z = z

		return wanted_position
	else
		local horizontal = 1.25
		local pos = GwNavQueries.inside_position_from_outside_position(nav_world, target_position, above, below, horizontal, 0.1)

		if pos then
			return pos
		else
			return target_position
		end
	end
end

PlayerBotBase._find_target_position_on_nav_mesh = function (self, nav_world, wanted_position)
	local above = 0.5
	local below = 0.5
	local success, z = GwNavQueries.triangle_from_position(nav_world, wanted_position, above, below)

	if success then
		return Vector3(wanted_position.x, wanted_position.y, z)
	else
		local horizontal = 2.5
		local pos = GwNavQueries.inside_position_from_outside_position(nav_world, wanted_position, above, below, horizontal, 0.1)

		if pos then
			return pos
		else
			return wanted_position
		end
	end
end

PlayerBotBase._update_target_ally = function (self, dt, t)
	Profiler.start("update target ally")

	local unit = self._unit
	local blackboard = self._blackboard
	local breed = self._bot_profile
	local best_ally, ally_dist, in_need_type = nil

	if blackboard.target_unit and blackboard.target_unit == blackboard.priority_target_enemy then
		best_ally = blackboard.priority_target_disabled_ally
		ally_dist = Vector3.distance(POSITION_LOOKUP[unit], POSITION_LOOKUP[best_ally])
	else
		best_ally, ally_dist, in_need_type = self:_select_ally_by_utility(unit, blackboard, breed, t)
	end

	blackboard.target_ally_unit = best_ally or nil
	blackboard.ally_distance = ally_dist

	if blackboard.target_ally_unit and in_need_type then
		blackboard.target_ally_needs_aid = true
		blackboard.target_ally_need_type = in_need_type
	elseif blackboard.target_ally_needs_aid then
		blackboard.target_ally_needs_aid = false
		blackboard.target_ally_need_type = nil
	end

	local is_priority_aid_type = blackboard.target_ally_need_type == "knocked_down" or blackboard.target_ally_need_type == "ledge" or blackboard.target_ally_need_type == "hook"

	if blackboard.target_ally_needs_aid and is_priority_aid_type then
		local ai_bot_group_system = Managers.state.entity:system("ai_bot_group_system")

		ai_bot_group_system:register_ally_needs_aid_priority(unit, blackboard.target_ally_unit)
	end

	Profiler.stop("update target ally")
end

PlayerBotBase._select_ally_by_utility = function (self, unit, blackboard, breed, t)
	local self_pos = POSITION_LOOKUP[unit]
	local closest_ally = nil
	local closest_dist = math.huge
	local closest_real_dist = math.huge
	local closest_in_need_type = nil
	local inventory_ext = blackboard.inventory_extension
	local health_slot_data = inventory_ext:get_slot_data("slot_healthkit")
	local can_heal_other = false
	local can_give_healing_to_other = false

	if health_slot_data then
		local template = inventory_ext:get_item_template(health_slot_data)
		can_heal_other = template.can_heal_other
		can_give_healing_to_other = template.can_give_other
	end

	local can_give_grenade_to_other = false
	local grenade_slot_data = inventory_ext:get_slot_data("slot_grenade")

	if grenade_slot_data then
		local template = inventory_ext:get_item_template(grenade_slot_data)
		can_give_grenade_to_other = template.can_give_other
	end

	local can_give_potion_to_other = false
	local potion_slot_data = inventory_ext:get_slot_data("slot_potion")

	if potion_slot_data then
		local template = inventory_ext:get_item_template(potion_slot_data)
		can_give_potion_to_other = template.can_give_other
	end

	local players = Managers.player:players()

	for k, player in pairs(players) do
		local player_unit = player.player_unit
		local is_bot = player.bot_player

		if AiUtils.unit_alive(player_unit) and player_unit ~= unit then
			local status_ext = ScriptUnit.extension(player_unit, "status_system")
			local utility = 0

			if not status_ext:is_ready_for_assisted_respawn() then
				local in_need_type = nil

				if status_ext:is_knocked_down() then
					in_need_type = "knocked_down"
					utility = 40
				elseif status_ext:get_is_ledge_hanging() and not status_ext:is_pulled_up() then
					in_need_type = "ledge"
					utility = 40
				elseif status_ext:is_hanging_from_hook() then
					in_need_type = "hook"
					utility = 40
				else
					local health_percent = ScriptUnit.extension(player_unit, "health_system"):current_health_percent()
					local inventory_ext = ScriptUnit.extension(player_unit, "inventory_system")
					local is_wounded = status_ext:is_wounded()

					if can_heal_other and (health_percent < WANTS_TO_HEAL_THRESHOLD or is_wounded) then
						in_need_type = "in_need_of_heal"
						local health_utility = 1 - ((is_wounded and health_percent * 0.33) or health_percent)
						utility = 10 + health_utility * 15
					elseif can_give_healing_to_other and (health_percent < WANTS_TO_GIVE_HEAL_TO_OTHER or is_wounded) and not inventory_ext:get_slot_data("slot_healthkit") then
						in_need_type = "can_accept_heal_item"
						local health_utility = 1 - ((is_wounded and health_percent - 0.5) or health_percent)
						utility = 10 + health_utility * 10
					elseif can_give_grenade_to_other and not inventory_ext:get_slot_data("slot_grenade") and not is_bot then
						in_need_type = "can_accept_grenade"
						utility = 10
					elseif can_give_potion_to_other and not inventory_ext:get_slot_data("slot_potion") and not is_bot then
						in_need_type = "can_accept_potion"
						utility = 10
					end
				end

				if in_need_type or not is_bot then
					local target_pos = POSITION_LOOKUP[player_unit]
					local allowed_follow_path, allowed_aid_path = self:_ally_path_allowed(player_unit, t)

					if allowed_follow_path then
						if not allowed_aid_path then
							in_need_type = nil
						elseif in_need_type then
							local rat_ogres = Managers.state.conflict:spawned_units_by_breed("skaven_rat_ogre")

							for _, rat_ogre_unit in pairs(rat_ogres) do
								local dist_sq = Vector3.distance_squared(target_pos, POSITION_LOOKUP[rat_ogre_unit])
								local range = (blackboard.target_ally_unit == player_unit and blackboard.target_ally_needs_aid and 16) or 25

								if dist_sq < range then
									in_need_type = nil

									break
								end
							end
						end

						if in_need_type or not is_bot then
							local real_dist = Vector3.distance(self_pos, target_pos)
							local dist = real_dist - utility

							if closest_dist > dist then
								closest_dist = dist
								closest_real_dist = real_dist
								closest_ally = player_unit
								closest_in_need_type = in_need_type
							end
						end
					end
				end
			end
		end
	end

	return closest_ally, closest_real_dist, closest_in_need_type
end

PlayerBotBase._within_aid_range = function (self, blackboard)
	if blackboard.target_ally_needs_aid then
		local self_pos = POSITION_LOOKUP[self._unit]
		local target_pos = POSITION_LOOKUP[blackboard.target_ally_unit]
		local distance_squared = Vector3.distance_squared(self_pos, target_pos)

		if distance_squared <= PROXIMITY_CHECK_RANGE * PROXIMITY_CHECK_RANGE then
			return true
		end
	end

	return false
end

PlayerBotBase._update_rat_ogre_cover = function (self)
	local spawned_rat_ogres = Managers.state.conflict:spawned_units_by_breed("skaven_rat_ogre")

	for _, target_unit in pairs(spawned_rat_ogres) do
		if alive(target_unit) then
			local blackboard = Unit.get_data(target_unit, "blackboard")
			local rat_ogre_target_unit = blackboard.target_unit

			if rat_ogre_target_unit then
				local player = Managers.player:unit_owner(rat_ogre_target_unit)

				if player == self._player then
					local rat_ogre_pos = POSITION_LOOKUP[target_unit]
					local bot_pos = POSITION_LOOKUP[rat_ogre_target_unit]
					local distance_squared = Vector3.distance_squared(rat_ogre_pos, bot_pos)

					if distance_squared < 144 then
						local find_cover = not self._blackboard.navigation_flee_destination_override

						if not find_cover and self._blackboard.navigation_flee_destination_override then
							local self_pos = POSITION_LOOKUP[self._unit]
							local destination = self._blackboard.navigation_flee_destination_override:unbox()
							local distance_squared = Vector3.distance_squared(self_pos, destination)

							if distance_squared < 0.5 then
								find_cover = true
							end
						end

						if not find_cover then
							return
						end

						local cover_point = self:_find_rat_ogre_cover_point(spawned_rat_ogres, target_unit)

						if cover_point then
							self._blackboard.navigation_flee_destination_override = Vector3Box(cover_point)
						end

						return
					end
				end
			end
		end
	end

	self._blackboard.navigation_flee_destination_override = nil
end

local RAT_OGRE_AVOID_POINTS = {}

PlayerBotBase._find_rat_ogre_cover_point = function (self, avoid_targets, rat_ogre_unit)
	local found_cover_point = nil
	local min_radius = 0
	local max_radius = 15
	local best_cover_angle = math.huge
	local target_pos = POSITION_LOOKUP[rat_ogre_unit]
	local self_pos = POSITION_LOOKUP[self._unit]
	local flee_dir = Vector3.flat(Vector3.normalize(self_pos - target_pos))
	local offset_vector = flee_dir * 20

	for _, unit in pairs(avoid_targets) do
		if alive(unit) then
			RAT_OGRE_AVOID_POINTS[#RAT_OGRE_AVOID_POINTS + 1] = POSITION_LOOKUP[unit]
		end
	end

	local num_found, hidden_cover_units = ConflictUtils.hidden_cover_points(self_pos + offset_vector, RAT_OGRE_AVOID_POINTS, min_radius, max_radius)

	table.clear(RAT_OGRE_AVOID_POINTS)

	local cover_bb = self._blackboard.taking_cover

	for _, cover_unit in pairs(hidden_cover_units) do
		if alive(cover_unit) then
			local cover_pos = Unit.world_position(cover_unit, 0)

			if not cover_bb.failed_cover_points[to_hash(cover_pos)] then
				local cover_dir = Vector3.flat(Vector3.normalize(cover_pos - self_pos))
				local angle = math.acos(Vector3.dot(cover_dir, flee_dir))

				if angle < best_cover_angle then
					found_cover_point = cover_pos
					best_cover_angle = angle
				end
			end
		end
	end

	return found_cover_point
end

PlayerBotBase._update_pickups = function (self, dt, t)
	local unit = self._unit
	local blackboard = self._blackboard
	blackboard.needs_ammo = false
	local target_unit = blackboard.priority_target_enemy or blackboard.target_unit
	local has_target = alive(target_unit)
	local ammo_percentage = (has_target and 0.1) or 0.9
	local inventory_ext = blackboard.inventory_extension
	local current, num_max = inventory_ext:current_ammo_status("slot_ranged")

	if current then
		blackboard.needs_ammo = ammo_percentage > current / num_max
	end
end

local INTERACTABLES_BROADPHASE_QUERY_RESULTS = {}

PlayerBotBase._update_interactables = function (self, dt, t)
	local blackboard = self._blackboard

	if self._interactable_timer < t then
		self._interactable_timer = t + 0.2 + Math.random() * 0.15

		if blackboard.interaction_unit and blackboard.interaction_unit ~= blackboard.target_ally_unit then
			blackboard.interaction_unit = nil
			blackboard.interaction_type = nil
		end

		local self_pos = POSITION_LOOKUP[self._unit]
		local num_doors = Managers.state.entity:system("door_system"):get_doors(self_pos, 1.5, INTERACTABLES_BROADPHASE_QUERY_RESULTS)
		local best_unit = nil
		local best_dist = math.huge
		local best_interaction_type = nil

		for i = 1, num_doors, 1 do
			local hit_unit = INTERACTABLES_BROADPHASE_QUERY_RESULTS[i]

			if ScriptUnit.has_extension(hit_unit, "interactable_system") and not ScriptUnit.extension(hit_unit, "door_system"):is_open() then
				local pos = POSITION_LOOKUP[hit_unit] or Unit.world_position(hit_unit, 0)
				local dist = Vector3.distance_squared(self_pos, pos)

				if dist < best_dist then
					best_dist = dist
					best_unit = hit_unit
					best_interaction_type = "door"
				end
			end
		end

		table.clear(INTERACTABLES_BROADPHASE_QUERY_RESULTS)

		if best_unit then
			blackboard.interaction_unit = best_unit
			blackboard.interaction_type = best_interaction_type
		end
	elseif alive(blackboard.interaction_unit) then
		local door_ext = ScriptUnit.has_extension(blackboard.interaction_unit, "door_system")

		if door_ext and door_ext:is_open() then
			blackboard.interaction_unit = nil
			blackboard.interaction_type = nil
		end
	end
end

local AVOID_POINTS_TEMP_TABLE = {}

PlayerBotBase._find_cover = function (self, take_cover_targets, self_pos, max_radius, allow_forward_distance)
	local offset_vector = Vector3.zero()

	for unit, _ in pairs(take_cover_targets) do
		local unit_pos = POSITION_LOOKUP[unit]
		AVOID_POINTS_TEMP_TABLE[#AVOID_POINTS_TEMP_TABLE + 1] = unit_pos
		local offset = Vector3.flat(self_pos - unit_pos)
		local normalized_offset = Vector3.normalize(offset)
		offset_vector = offset_vector + normalized_offset
		allow_forward_distance = math.min(allow_forward_distance, 0.5 * Vector3.length(offset))
	end

	local search_pos = self_pos + (max_radius - allow_forward_distance) * offset_vector
	local num_found, hidden_cover_units = ConflictUtils.hidden_cover_points(search_pos, AVOID_POINTS_TEMP_TABLE, 0, max_radius, -0.9)

	table.clear(AVOID_POINTS_TEMP_TABLE)

	return num_found, hidden_cover_units
end

local TAKE_COVER_TEMP_TABLE = {}

function line_of_fire_check(from, to, p, width, length)
	local diff = p - from
	local dir = Vector3.normalize(to - from)
	local lateral_dist = Vector3.dot(diff, dir)

	if lateral_dist <= 0 or length < lateral_dist then
		return false
	end

	local direct_dist = Vector3.length(diff - lateral_dist * dir)

	if math.min(lateral_dist, width) < direct_dist then
		return false
	else
		return true
	end
end

PlayerBotBase._in_line_of_fire = function (self, self_unit, self_pos, take_cover_targets, taking_cover_from)
	local changed = false
	local in_line_of_fire = false
	local width = 2.5
	local sticky_width = 6
	local length = 40

	for attacker, victim in pairs(take_cover_targets) do
		local already_in_cover_from = taking_cover_from[attacker]

		if alive(victim) and (victim == self_unit or line_of_fire_check(POSITION_LOOKUP[attacker], POSITION_LOOKUP[victim], self_pos, (already_in_cover_from and sticky_width) or width, length)) then
			TAKE_COVER_TEMP_TABLE[attacker] = victim
			changed = changed or not already_in_cover_from
			in_line_of_fire = true
		end
	end

	for attacker, victim in pairs(taking_cover_from) do
		if not TAKE_COVER_TEMP_TABLE[attacker] then
			changed = true

			break
		end
	end

	table.clear(taking_cover_from)

	for attacker, victim in pairs(TAKE_COVER_TEMP_TABLE) do
		taking_cover_from[attacker] = victim
	end

	table.clear(TAKE_COVER_TEMP_TABLE)

	return in_line_of_fire, changed
end

function to_hash(vector3)
	return vector3.x + vector3.y * 10000 + vector3.z * 0.0001
end

PlayerBotBase.cb_cover_point_path_result = function (self, hash, success, destination)
	if not success then
		local cover_bb = self._blackboard.taking_cover
		cover_bb.failed_cover_points[hash] = true

		table.clear(cover_bb.active_threats)
		dprint("failed cover point", destination)
	end
end

PlayerBotBase._update_movement_target = function (self, dt, t)
	local blackboard = self._blackboard
	local unit = self._unit
	local self_pos = POSITION_LOOKUP[unit]
	local nav_world = self._nav_world
	local navigation_ext = blackboard.navigation_extension
	local override_box = blackboard.navigation_destination_override
	local override_melee = blackboard.melee and blackboard.melee.engage_position_set and override_box:unbox()
	local override_rat_ogre_flee = blackboard.navigation_flee_destination_override and blackboard.navigation_flee_destination_override:unbox()
	local moving_towards_follow_position = false
	local follow_bb = blackboard.follow
	local cover_bb = blackboard.taking_cover
	local in_line_of_fire, changed = self:_in_line_of_fire(unit, self_pos, cover_bb.threats, cover_bb.active_threats)
	local cover_position = nil
	local bot_group_system = Managers.state.entity:system("ai_bot_group_system")

	if in_line_of_fire and changed then
		local fails = cover_bb.fails
		local radius = math.min(5 + fails * 5, 40)
		local allowed_forward_dist = radius * 0.4
		local num_found, hidden_cover_units = self:_find_cover(cover_bb.active_threats, self_pos, radius, allowed_forward_dist)
		local found_point, found_unit, occupied_cover_unit, occupied_cover_point = nil

		for i = 1, num_found, 1 do
			local cover_unit = hidden_cover_units[i]
			local pos = Unit.local_position(cover_unit, 0)

			if not cover_bb.failed_cover_points[to_hash(pos)] then
				if bot_group_system:in_cover(cover_unit) then
					occupied_cover_point = occupied_cover_point or pos
					occupied_cover_unit = occupied_cover_unit or cover_unit
				else
					found_point = pos
					found_unit = cover_unit

					break
				end
			end
		end

		found_point = found_point or occupied_cover_point
		found_unit = found_unit or occupied_cover_unit

		if found_point then
			cover_position = found_point

			cover_bb.cover_position:store(cover_position)

			cover_bb.cover_unit = found_unit
			cover_bb.fails = 0

			dprint("found point", cover_position)
			bot_group_system:set_in_cover(unit, found_unit)
		else
			cover_bb.fails = cover_bb.fails + 1

			table.clear(cover_bb.active_threats)
			dprint("failed to find point, forcing re-evaluation")
		end
	elseif not in_line_of_fire and changed then
		cover_bb.cover_position:store(Vector3.invalid_vector())

		cover_bb.cover_unit = nil
		cover_bb.fails = 0
		follow_bb.needs_target_position_refresh = true

		bot_group_system:set_in_cover(unit, nil)
	elseif in_line_of_fire then
		cover_position = cover_bb.cover_position:unbox()
	end

	local obstruction_bb = blackboard.ranged_obstruction_by_static
	local obstruction_unit = obstruction_bb and obstruction_bb.unit

	if cover_bb.active_threats[obstruction_unit] then
		blackboard.ranged_obstruction_by_static = nil
	end

	local target_ally_unit = blackboard.target_ally_unit
	local transport_unit_override = nil

	if alive(target_ally_unit) then
		local ally_status_extension = ScriptUnit.extension(target_ally_unit, "status_system")
		local transport_unit = ally_status_extension:get_inside_transport_unit()

		if alive(transport_unit) and not blackboard.target_ally_needs_aid then
			blackboard.ally_inside_transport_unit = transport_unit
			local transportation_ext = ScriptUnit.extension(blackboard.ally_inside_transport_unit, "transportation_system")
			local has_valid_transportation_unit = transportation_ext.story_state == "stopped_beginning"

			if has_valid_transportation_unit then
				transport_unit_override = LocomotionUtils.new_goal_in_transport(nav_world, unit, target_ally_unit)
			end
		elseif blackboard.ally_inside_transport_unit then
			blackboard.ally_inside_transport_unit = nil
		end
	else
		blackboard.ally_inside_transport_unit = nil
	end

	if override_melee then
		local rat_ogres = Managers.state.conflict:spawned_units_by_breed("skaven_rat_ogre")

		if table.find(rat_ogres, blackboard.target_unit) and blackboard.target_ally_needs_aid then
			override_melee = nil
		end
	end

	if override_rat_ogre_flee or cover_position or override_melee then
		local override = transport_unit_override or override_rat_ogre_flee or cover_position or override_melee
		local offset = override - navigation_ext:destination()

		if Z_MOVE_TO_EPSILON < math.abs(offset.z) or FLAT_MOVE_TO_EPSILON < Vector3.length(Vector3.flat(offset)) then
			local path_callback = (not transport_unit_override and (override_rat_ogre_flee or cover_position) and callback(self, "cb_cover_point_path_result", to_hash(override))) or nil

			navigation_ext:move_to(override, path_callback)

			blackboard.using_navigation_destination_override = true
		end
	else
		follow_bb.follow_timer = follow_bb.follow_timer - dt

		if not follow_bb.needs_target_position_refresh and (follow_bb.follow_timer < 0 or (blackboard.target_ally_needs_aid and navigation_ext:destination_reached())) then
			follow_bb.needs_target_position_refresh = true
		end

		if follow_bb.needs_target_position_refresh then
			local target_position = nil
			local goal_selection_func_name = blackboard.follow.goal_selection_func
			local path_callback = nil
			local enemy_unit = blackboard.target_unit

			if blackboard.revive_with_urgent_target and blackboard.target_ally_needs_aid then
				target_position = self:_alter_target_position(nav_world, self_pos, target_ally_unit, POSITION_LOOKUP[target_ally_unit], blackboard.target_ally_need_type)
				blackboard.interaction_unit = target_ally_unit
				path_callback = callback(self, "cb_ally_path_result", target_ally_unit)

				dprint("path to ally")
			elseif enemy_unit and (enemy_unit == blackboard.priority_target_enemy or enemy_unit == blackboard.urgent_target_enemy) and self:_enemy_path_allowed(enemy_unit) then
				target_position = self:_find_target_position_on_nav_mesh(nav_world, POSITION_LOOKUP[enemy_unit])
				path_callback = callback(self, "cb_enemy_path_result", enemy_unit)

				dprint("path to enemy", enemy_unit, target_position)
			elseif blackboard.target_ally_needs_aid then
				target_position = self:_alter_target_position(nav_world, self_pos, target_ally_unit, POSITION_LOOKUP[target_ally_unit], blackboard.target_ally_need_type)
				blackboard.interaction_unit = target_ally_unit
				path_callback = callback(self, "cb_ally_path_result", target_ally_unit)

				dprint("path to ally")
			elseif goal_selection_func_name and alive(target_ally_unit) then
				local func = LocomotionUtils[goal_selection_func_name]
				target_position = func(nav_world, unit, target_ally_unit)

				dprint("path to goal")
			elseif alive(blackboard.health_pickup) and blackboard.allowed_to_take_health_pickup and t < blackboard.health_pickup_valid_until and (self._last_health_pickup_attempt.unit ~= blackboard.health_pickup or not self._last_health_pickup_attempt.blacklist) then
				local pickup_unit = blackboard.health_pickup
				target_position = self:_find_pickup_position_on_navmesh(nav_world, self_pos, pickup_unit, self._last_health_pickup_attempt)

				if target_position then
					path_callback = callback(self, "cb_health_pickup_path_result", pickup_unit)
					blackboard.interaction_unit = pickup_unit
				end

				dprint("path to health pickup")
			elseif alive(blackboard.mule_pickup) and (self._last_mule_pickup_attempt.unit ~= blackboard.mule_pickup or not self._last_mule_pickup_attempt.blacklist) then
				local pickup_unit = blackboard.mule_pickup
				target_position = self:_find_pickup_position_on_navmesh(nav_world, self_pos, pickup_unit, self._last_mule_pickup_attempt)

				if target_position then
					path_callback = callback(self, "cb_mule_pickup_path_result", pickup_unit)
					blackboard.interaction_unit = pickup_unit
				end

				dprint("path to mule pickup")
			end

			if not target_position and alive(blackboard.ammo_pickup) and blackboard.needs_ammo and t < blackboard.ammo_pickup_valid_until then
				local ammo_position = POSITION_LOOKUP[blackboard.ammo_pickup]
				local dir = Vector3.normalize(self_pos - ammo_position)
				local above = 0.5
				local below = 1.5
				local lateral = 1
				local distance = 0
				target_position = self:_find_position_on_navmesh(nav_world, ammo_position, ammo_position + dir, above, below, INTERACT_RAY_DISTANCE - 0.3, distance)

				if target_position then
					blackboard.interaction_unit = blackboard.ammo_pickup
				end

				dprint("path to ammo pickup")
			end

			if not target_position then
				local ai_bot_group_ext = blackboard.ai_bot_group_extension
				target_position = ai_bot_group_ext.data.follow_position
				moving_towards_follow_position = true
			end

			if target_position then
				blackboard.moving_toward_follow_position = moving_towards_follow_position
				follow_bb.needs_target_position_refresh = false
				follow_bb.follow_timer = math.lerp(FOLLOW_TIMER_LOWER_BOUND, FOLLOW_TIMER_UPPER_BOUND, Math.random())

				follow_bb.target_position:store(target_position)

				local current_destination = nil

				if navigation_ext:destination_reached() then
					current_destination = self_pos
				else
					current_destination = navigation_ext:destination()
				end

				local offset = target_position - current_destination

				if Z_MOVE_TO_EPSILON < math.abs(offset.z) or FLAT_MOVE_TO_EPSILON < Vector3.length(Vector3.flat(offset)) then
					dprint("move to ", target_position)
					navigation_ext:move_to(target_position, path_callback)
				end

				blackboard.using_navigation_destination_override = false
			end
		end

		if blackboard.using_navigation_destination_override then
			navigation_ext:move_to(follow_bb.target_position:unbox())

			blackboard.using_navigation_destination_override = false
		end
	end
end

local PICKUP_ROTATIONS = {
	QuaternionBox(Quaternion(Vector3.up(), 0)),
	QuaternionBox(Quaternion(Vector3.up(), math.pi * 0.25)),
	QuaternionBox(Quaternion(Vector3.up(), -math.pi * 0.25)),
	QuaternionBox(Quaternion(Vector3.up(), math.pi * 0.5)),
	QuaternionBox(Quaternion(Vector3.up(), -math.pi * 0.5)),
	QuaternionBox(Quaternion(Vector3.up(), math.pi * 0.75)),
	QuaternionBox(Quaternion(Vector3.up(), -math.pi * 0.75)),
	QuaternionBox(Quaternion(Vector3.up(), math.pi))
}

PlayerBotBase._find_pickup_position_on_navmesh = function (self, nav_world, self_pos, pickup_unit, pickup_attempt)
	local above = 1.5
	local below = 2.2
	local STEP = 0.1
	local range = INTERACT_RAY_DISTANCE - 0.3
	local max_index = #PICKUP_ROTATIONS
	local pickup_pos = POSITION_LOOKUP[pickup_unit]

	if pickup_attempt.unit ~= pickup_unit then
		pickup_attempt.unit = pickup_unit
		pickup_attempt.index = 1
		pickup_attempt.distance = 0
		pickup_attempt.path_failed = true

		pickup_attempt.rotation:store(Quaternion.look(Vector3.flat(self_pos - pickup_pos), Vector3.up()))

		pickup_attempt.blacklist = false
	end

	if pickup_attempt.path_failed then
		local index = pickup_attempt.index
		local attempt_rotation = pickup_attempt.rotation:unbox()
		local dist = pickup_attempt.distance
		local found_position = nil

		while index <= max_index and not found_position do
			local rot = Quaternion.multiply(PICKUP_ROTATIONS[index]:unbox(), attempt_rotation)
			local dir = Quaternion.forward(rot)
			dist = math.min(dist + STEP, 1)
			local pos = pickup_pos + dir * dist * range
			local success, z = GwNavQueries.triangle_from_position(nav_world, pos, above, below)

			if success then
				pos.z = z

				if dist >= 0.8 then
					found_position = pos
				else
					local ray_end_pos = pos + (1 - dist) * dir * range
					local success, ray_hit_pos = GwNavQueries.raycast(nav_world, pos, ray_end_pos)

					if success then
						found_position = ray_end_pos
						dist = 1
					else
						found_position = 0.1 * pos + ray_hit_pos * 0.9
						dist = Vector3.dot(Vector3.flat(found_position - pickup_pos), dir)
					end
				end
			end

			if dist >= 1 then
				index = index + 1
				dist = 0
			end
		end

		pickup_attempt.distance = dist
		pickup_attempt.index = index

		if found_position then
			pickup_attempt.path_failed = false

			pickup_attempt.path_position:store(found_position)

			return found_position
		else
			pickup_attempt.blacklist = true

			return
		end
	else
		return pickup_attempt.path_position:unbox()
	end
end

PlayerBotBase._find_position_on_navmesh = function (self, nav_world, original_position, offset_position, above, below, lateral, distance)
	local success, z = GwNavQueries.triangle_from_position(nav_world, offset_position, above, below)

	if success then
		return Vector3(offset_position.x, offset_position.y, z)
	else
		local success, z = GwNavQueries.triangle_from_position(nav_world, original_position, above, below)

		if success then
			return Vector3(offset_position.x, offset_position.y, z)
		else
			return GwNavQueries.inside_position_from_outside_position(nav_world, original_position, above, below, lateral, distance)
		end
	end
end

PlayerBotBase.destroy = function (self)
	self._brain:destroy()

	if self._blackboard.taking_cover.cover_unit then
		Managers.state.entity:system("ai_bot_group_system"):set_in_cover(self._unit, nil)
	end
end

PlayerBotBase._debug_draw_update = function (self, dt)
	if script_data.debug_behaviour_trees then
		self._brain:debug_draw_behaviours()
	end

	local drawer_name = "bot_debug" .. self._player.player_name
	local drawer = Managers.state.debug:drawer({
		mode = "immediate",
		name = drawer_name
	})
	local debug_sphere_position = Unit.local_position(self._unit, 0) + Vector3.up() * 2
	local color = self._player.color:unbox()

	drawer:sphere(debug_sphere_position, 0.25, color)

	local blackboard = self._blackboard
	local enemy = blackboard.target_unit
	local ally = blackboard.target_ally_unit
	local radius_offset = self._player:local_player_id() * 0.05

	if alive(enemy) then
		drawer:line(debug_sphere_position, Unit.world_position(enemy, 0) + Vector3(0, 0, 1.5), Color(125, 255, 0, 0))
		drawer:box(Unit.world_pose(enemy, 0), Vector3(0.5 + radius_offset, 0.5 + radius_offset, 1.5 + radius_offset), color)
	end

	if alive(ally) then
		drawer:circle(POSITION_LOOKUP[ally] + Vector3(0, 0, 0.2), 0.6 + radius_offset, Vector3.up(), color, 16)
	end

	self._brain:debug_draw_current_behavior()
end

PlayerBotBase.clear_failed_paths = function (self)
	table.clear(self._attempted_ally_paths)
	table.clear(self._attempted_enemy_paths)
end

PlayerBotBase.cb_enemy_path_result = function (self, enemy_unit, success, destination)
	local paths = self._attempted_enemy_paths
	local path_status = paths[enemy_unit]

	if not path_status then
		path_status = {
			last_path_destination = Vector3Box()
		}
		paths[enemy_unit] = path_status
	end

	local fail = not success

	if fail then
		self._blackboard.follow.needs_target_position_refresh = true
	end

	path_status.failed = fail

	path_status.last_path_destination:store(destination)
	dprint("path to enemy result " .. ((success and "success") or "failed"))

	for unit, path in pairs(paths) do
		if not alive(unit) then
			paths[unit] = nil
		end
	end
end

PlayerBotBase._enemy_path_allowed = function (self, enemy_unit)
	local path_status = self._attempted_enemy_paths[enemy_unit]
	local enemy_pos = POSITION_LOOKUP[enemy_unit]

	if path_status and path_status.failed and Vector3.distance_squared(enemy_pos, path_status.last_path_destination:unbox()) < ENEMY_PATH_FAILED_REPATH_THRESHOLD and math.abs(enemy_pos.z - path_status.last_path_destination:unbox().z) < ENEMY_PATH_FAILED_REPATH_VERTICAL_THRESHOLD then
		return false
	end

	return true
end

PlayerBotBase.cb_health_pickup_path_result = function (self, pickup_unit, success, destination)
	if pickup_unit == self._last_health_pickup_attempt.unit then
		self._last_health_pickup_attempt.path_failed = not success
	end
end

PlayerBotBase.cb_mule_pickup_path_result = function (self, pickup_unit, success, destination)
	if pickup_unit == self._last_mule_pickup_attempt.unit then
		self._last_mule_pickup_attempt.path_failed = not success
	end
end

PlayerBotBase.cb_ally_path_result = function (self, ally_unit, success, destination)
	local paths = self._attempted_ally_paths
	local path_status = paths[ally_unit]

	if not path_status then
		path_status = {
			last_path_destination = Vector3Box()
		}
		paths[ally_unit] = path_status
	end

	local fail = not success
	path_status.failed = fail

	path_status.last_path_destination:store(destination)

	if fail then
		path_status.ignore_ally_from = Managers.time:time("game")
	else
		path_status.ignore_ally_from = -math.huge
	end

	for unit, path in pairs(paths) do
		if not alive(unit) then
			paths[unit] = nil
		end
	end
end

PlayerBotBase._ally_path_allowed = function (self, ally_unit, t)
	local path_status = self._attempted_ally_paths[ally_unit]

	if path_status and path_status.failed then
		local conflict_director = Managers.state.conflict
		local self_segment = conflict_director:get_player_unit_segment(self._unit) or -1
		local target_segment = conflict_director:get_player_unit_segment(ally_unit) or -1
		local ignore_for = nil

		if self_segment < target_segment then
			ignore_for = 1
		elseif target_segment < self_segment then
			ignore_for = 10
		else
			ignore_for = 5
		end

		local no_longer_ignored = t > path_status.ignore_ally_from + ignore_for

		if no_longer_ignored then
			local ally_position = POSITION_LOOKUP[ally_unit]
			local last_path_destination = path_status.last_path_destination:unbox()
			local has_moved = ALLY_PATH_FAILED_REPATH_THRESHOLD < Vector3.distance_squared(ally_position, last_path_destination)

			return true, has_moved
		else
			return false, false
		end
	else
		return true, true
	end
end

return
