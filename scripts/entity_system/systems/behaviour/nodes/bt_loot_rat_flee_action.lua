require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTLootRatFleeAction = class(BTLootRatFleeAction, BTNode)
BTLootRatFleeAction.init = function (self, ...)
	BTLootRatFleeAction.super.init(self, ...)

	return 
end
BTLootRatFleeAction.name = "BTLootRatFleeAction"
local CHECK_ESCAPED_PLAYERS_INTERVAL = 2
local BREAK_NODE_MAX_DISTANCE = 20
local BREAK_NODE_ASTAR_BOX_EXTENTS = 14
BTLootRatFleeAction.enter = function (self, unit, blackboard, t)
	blackboard.action = self._tree_node.action_data
	blackboard.is_fleeing = true
	blackboard.check_escaped_players_time = t + CHECK_ESCAPED_PLAYERS_INTERVAL

	if not blackboard.flee_node_data then
		local conflict_manager = Managers.state.conflict
		local node_data = conflict_manager.main_path_info.merged_main_paths
		blackboard.flee_node_data = {
			direction = "fwd",
			nodes = {
				fwd = node_data.forward_list,
				bwd = node_data.reversed_list
			},
			break_nodes = {
				fwd = node_data.forward_break_list,
				bwd = node_data.reversed_break_list
			}
		}
	end

	if not blackboard.flee_astar_data then
		local astar = GwNavAStar.create()
		local navtag_layer_cost_table = GwNavTagLayerCostTable.create()
		local traverse_logic = GwNavTraverseLogic.create(blackboard.nav_world)
		blackboard.flee_astar_data = {
			doing_astar = false,
			astar = astar,
			navtag_layer_cost_table = navtag_layer_cost_table,
			traverse_logic = traverse_logic
		}

		AiUtils.initialize_cost_table(navtag_layer_cost_table, blackboard.breed.allowed_layers)
		GwNavTraverseLogic.set_navtag_layer_cost_table(traverse_logic, navtag_layer_cost_table)
	end

	self.enter_state_moving_to_level_end(self, unit, blackboard)

	return 
end
BTLootRatFleeAction.run = function (self, unit, blackboard, t, dt)
	if blackboard.spawn_to_running then
		blackboard.spawn_to_running = nil
		blackboard.start_anim_done = true
		blackboard.move_state = "moving"
		blackboard.start_anim_locked = nil

		self.toggle_start_move_animation_lock(self, unit, false)
	elseif not blackboard.movement_inited then
		blackboard.spawn_to_running = nil
		blackboard.start_anim_done = true
		blackboard.move_state = "moving"
		blackboard.start_anim_locked = nil
		blackboard.movement_inited = true
		local network_manager = Managers.state.network

		network_manager.anim_event(network_manager, unit, "move_fwd")
		self.toggle_start_move_animation_lock(self, unit, false)
	end

	if not blackboard.start_anim_done then
		if not blackboard.start_anim_locked then
			self.start_move_animation(self, unit, blackboard)
		end

		if blackboard.anim_cb_rotation_start then
			self.start_move_rotation(self, unit, blackboard, t, dt)
		end

		if blackboard.anim_cb_move then
			blackboard.anim_cb_move = false
			blackboard.move_state = "moving"

			self.toggle_start_move_animation_lock(self, unit, false)

			blackboard.start_anim_locked = nil
			blackboard.start_anim_done = true
		end
	else
		local state = blackboard.flee_state

		if state == "moving_to_level_end" then
			self.update_state_moving_to_level_end(self, unit, blackboard)
		end

		if blackboard.check_escaped_players_time < t then
			if self.has_escaped_players(self, unit, blackboard) then
				self.despawn(self, unit, blackboard, "escaped_players")
			end

			blackboard.check_escaped_players_time = t + CHECK_ESCAPED_PLAYERS_INTERVAL
		end
	end

	return "running"
end
BTLootRatFleeAction.leave = function (self, unit, blackboard, t)
	local astar_data = blackboard.flee_astar_data

	if not GwNavAStar.processing_finished(astar_data.astar) then
		GwNavAStar.cancel(astar_data.astar)
	end

	blackboard.action = nil
	blackboard.check_escaped_players_time = nil
	blackboard.flee_debug_drive_vector = nil

	self.toggle_start_move_animation_lock(self, unit, false)

	blackboard.move_state = nil
	blackboard.start_anim_locked = nil
	blackboard.anim_cb_rotation_start = nil
	blackboard.anim_cb_move = nil
	blackboard.start_anim_done = nil
	blackboard.movement_inited = nil

	return 
end
BTLootRatFleeAction.enter_state_moving_to_level_end = function (self, unit, blackboard)
	self.set_state(self, blackboard, "moving_to_level_end")

	local unit_position = POSITION_LOOKUP[unit]
	local node_data = blackboard.flee_node_data
	local nodes = node_data.nodes[node_data.direction]
	local node_index = nil

	if node_data.target_node_index then
		node_index = node_data.target_node_index
	else
		node_index = MainPathUtils.closest_node_in_node_list(nodes, unit_position)
	end

	self.move_to_main_path_node(self, unit, blackboard, node_index)

	return 
end
BTLootRatFleeAction.update_state_moving_to_level_end = function (self, unit, blackboard)
	local astar_data = blackboard.flee_astar_data

	if astar_data.doing_astar then
		local astar = astar_data.astar

		if GwNavAStar.processing_finished(astar) then
			astar_data.doing_astar = false
			local node_data = blackboard.flee_node_data
			local target_node_index = node_data.target_node_index
			local next_node_index = nil

			if GwNavAStar.path_found(astar) and 0 < GwNavAStar.node_count(astar) then
				next_node_index = target_node_index + 1
			else
				node_data.direction = (node_data.direction == "fwd" and "bwd") or "fwd"
				next_node_index = #node_data.nodes[node_data.direction] - target_node_index + 2
			end

			self.move_to_main_path_node(self, unit, blackboard, next_node_index)
		else
			return 
		end
	end

	local unit_position = POSITION_LOOKUP[unit]
	local node_data = blackboard.flee_node_data
	local target_node_index = node_data.target_node_index
	local nodes = node_data.nodes[node_data.direction]
	local target_node = nodes[target_node_index]
	local distance_to_target_node = Vector3.length(unit_position - target_node.unbox(target_node))

	if distance_to_target_node < 0.3 then
		local next_node_index = target_node_index + 1
		local next_node = nodes[next_node_index]

		if next_node then
			local break_nodes = node_data.break_nodes[node_data.direction]

			if break_nodes[target_node] then
				local next_node_position = next_node.unbox(next_node)
				local distance_to_next_node = Vector3.length(unit_position - next_node_position)

				if distance_to_next_node < BREAK_NODE_MAX_DISTANCE then
					self.do_astar_to_between_main_path_nodes(self, blackboard, target_node_index)

					return 
				else
					node_data.direction = (node_data.direction == "fwd" and "bwd") or "fwd"
					next_node_index = #node_data.nodes[node_data.direction] - target_node_index + 2
				end
			end
		else
			node_data.direction = (node_data.direction == "fwd" and "bwd") or "fwd"
			next_node_index = 2
		end

		self.move_to_main_path_node(self, unit, blackboard, next_node_index)
	end

	return 
end
BTLootRatFleeAction.move_to_main_path_node = function (self, unit, blackboard, node_index)
	local node_data = blackboard.flee_node_data
	local nodes = node_data.nodes[node_data.direction]
	local node = nodes[node_index]
	node_data.target_node_index = node_index

	blackboard.navigation_extension:move_to(node.unbox(node))

	return 
end
BTLootRatFleeAction.do_astar_to_between_main_path_nodes = function (self, blackboard, from_node_index)
	local node_data = blackboard.flee_node_data
	local nodes = node_data.nodes[node_data.direction]
	local from_position = nodes[from_node_index]:unbox()
	local to_position = nodes[from_node_index + 1]:unbox()
	local astar_data = blackboard.flee_astar_data
	astar_data.doing_astar = true

	GwNavAStar.start_with_propagation_box(astar_data.astar, blackboard.nav_world, from_position, to_position, BREAK_NODE_ASTAR_BOX_EXTENTS, astar_data.traverse_logic)

	return 
end
BTLootRatFleeAction.has_escaped_players = function (self, unit, blackboard)
	local escape_distance_sq = blackboard.breed.escaped_players_distance_sq
	local unit_position = POSITION_LOOKUP[unit]

	for i = 1, #PLAYER_UNITS, 1 do
		local player_unit = PLAYER_UNITS[i]
		local player_position = POSITION_LOOKUP[player_unit]
		local distance_to_player_sq = Vector3.distance_squared(unit_position, player_position)

		if distance_to_player_sq < escape_distance_sq then
			return false
		end
	end

	return true
end
BTLootRatFleeAction.despawn = function (self, unit, blackboard, reason)
	local conflict = Managers.state.conflict

	conflict.destroy_unit(conflict, unit, blackboard, reason)

	return 
end
BTLootRatFleeAction.set_state = function (self, blackboard, new_state)
	blackboard.flee_state = new_state

	return 
end
BTLootRatFleeAction.start_move_animation = function (self, unit, blackboard)
	self.toggle_start_move_animation_lock(self, unit, true)

	local animation_name = AiAnimUtils.get_start_move_animation(unit, blackboard, blackboard.action)

	Managers.state.network:anim_event(unit, animation_name)

	blackboard.move_animation_name = animation_name
	blackboard.start_anim_locked = true

	return 
end
BTLootRatFleeAction.toggle_start_move_animation_lock = function (self, unit, should_lock_ani)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	if should_lock_ani then
		locomotion_extension.use_lerp_rotation(locomotion_extension, false)
		LocomotionUtils.set_animation_driven_movement(unit, true)
	else
		locomotion_extension.use_lerp_rotation(locomotion_extension, true)
		LocomotionUtils.set_animation_driven_movement(unit, false)
		LocomotionUtils.set_animation_rotation_scale(unit, 1)
	end

	return 
end

return 
