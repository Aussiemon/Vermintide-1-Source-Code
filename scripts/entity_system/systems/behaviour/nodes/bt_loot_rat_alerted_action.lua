require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTLootRatAlertedAction = class(BTLootRatAlertedAction, BTNode)
BTLootRatAlertedAction.init = function (self, ...)
	BTLootRatAlertedAction.super.init(self, ...)

	return 
end
BTLootRatAlertedAction.name = "BTLootRatAlertedAction"
BTLootRatAlertedAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.alerted_action = blackboard.alerted_action or {}
	blackboard.move_animation_name = nil
	blackboard.anim_cb_rotation_start = false
	blackboard.anim_cb_move = false

	blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())

	if blackboard.confirmed_player_sighting == nil then
		self.decide_deadline(self, unit, blackboard, t)
		self.init_alerted(self, unit, blackboard)

		if script_data.enable_alert_icon then
			local category_name = "detect"
			local head_node = Unit.node(unit, "c_head")
			local viewport_name = "player_1"
			local color_vector = Vector3(255, 0, 0)
			local offset_vector = Vector3(0, 0, 1)
			local text_size = 0.5
			local debug_start_string = "!"

			Managers.state.debug_text:output_unit_text(debug_start_string, text_size, unit, head_node, offset_vector, nil, category_name, color_vector, viewport_name)
		end
	end

	ScriptUnit.extension(unit, "ai_navigation_system"):set_enabled(false)

	return 
end
BTLootRatAlertedAction.init_alerted = function (self, unit, blackboard)
	local world = blackboard.world
	local wwise_world = Managers.world:wwise_world(world)
	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	network_manager.network_transmit:send_rpc_clients("rpc_enemy_is_alerted", unit_id, true)
	network_manager.anim_event(network_manager, unit, "alerted")

	blackboard.move_animation_name = "alerted"

	if ScriptUnit.has_extension(unit, "ai_inventory_system") then
		network_manager.network_transmit:send_rpc_all("rpc_ai_inventory_wield", unit_id)
	end

	return 
end
BTLootRatAlertedAction.decide_deadline = function (self, unit, blackboard, t)
	local current_pos = POSITION_LOOKUP[unit]
	local target_pos = POSITION_LOOKUP[blackboard.target_unit]
	local target_vector_flat = Vector3.normalize(Vector3.flat(target_pos - current_pos))
	local rotation = Unit.local_rotation(unit, 0)
	local forward_vector_flat = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
	local dot_product = Vector3.dot(forward_vector_flat, target_vector_flat)
	local min_deadline = (0.25 >= dot_product or 0) and 1
	local max_deadline = math.max(min_deadline, dot_product*2 - 2)
	blackboard.alerted_action.deadline = Math.random(min_deadline, max_deadline) + t

	return 
end
BTLootRatAlertedAction.leave = function (self, unit, blackboard, t)
	local category_name = "detect"

	if script_data.enable_alert_icon then
		Managers.state.debug_text:clear_unit_text(unit, category_name)
	end

	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	Managers.state.network.network_transmit:send_rpc_clients("rpc_enemy_is_alerted", unit_id, false)

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.use_lerp_rotation(locomotion_extension, true)
	LocomotionUtils.set_animation_driven_movement(unit, false)
	LocomotionUtils.set_animation_rotation_scale(unit, 1)
	ScriptUnit.extension(unit, "ai_navigation_system"):set_enabled(true)

	blackboard.confirmed_player_sighting = true
	blackboard.detection_radius = math.huge
	blackboard.spawn_to_running = true
	blackboard.update_timer = 0

	return 
end
BTLootRatAlertedAction.run = function (self, unit, blackboard, t, dt)
	local action = blackboard.action
	local current_pos = POSITION_LOOKUP[unit]
	local target_pos = POSITION_LOOKUP[blackboard.target_unit]
	local target_dist_sq = Vector3.distance_squared(target_pos, current_pos)

	if blackboard.confirmed_player_sighting or blackboard.spawn_type == "horde" or blackboard.spawn_type == "horde_hidden" then
		return "done"
	end

	if blackboard.anim_cb_move then
		print("blackboard.anim_cb_move")

		blackboard.anim_cb_move = false
		blackboard.move_state = "moving"
		blackboard.anim_locked = 0

		return "done"
	else
		return "running"
	end

	return 
end

return 
