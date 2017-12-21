require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTLootRatLookPlayersAction = class(BTLootRatLookPlayersAction, BTNode)
BTLootRatLookPlayersAction.init = function (self, ...)
	BTLootRatLookPlayersAction.super.init(self, ...)

	return 
end
BTLootRatLookPlayersAction.name = "BTLootRatLookPlayersAction"
BTLootRatLookPlayersAction.enter = function (self, unit, blackboard, t)
	blackboard.action = self._tree_node.action_data
	local action_data = self._tree_node.action_data
	local pos = POSITION_LOOKUP[unit]

	blackboard.navigation_extension:move_to(pos)

	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, blackboard.action.anim_event)

	blackboard.time_to_check_for_players = t + action_data.look_time
	blackboard.time_to_play_animation = t + action_data.anim_length

	return 
end

local function min_player_distance(unit, blackboard)
	local pos = POSITION_LOOKUP[unit]
	local players = Managers.player:human_players()
	local distance = math.huge

	for _, player in pairs(players) do
		local player_unit = player.player_unit

		if Unit.alive(player_unit) then
			local player_pos = POSITION_LOOKUP[player_unit]
			local dist = Vector3.length(pos - player_pos)

			if dist < distance then
				distance = dist
			end
		end
	end

	return distance
end

BTLootRatLookPlayersAction._player_close = function (self, unit, blackboard)
	if blackboard.action.despawn_radius < min_player_distance(unit, blackboard) then
		local ai_system = Managers.state.entity:system("ai_system")

		ai_system.register_unit_for_destruction(ai_system, unit)

		return false
	end

	return true
end
BTLootRatLookPlayersAction.leave = function (self, unit, blackboard, t)
	blackboard.move_state = nil

	self.toggle_start_move_animation_lock(self, unit, false)

	blackboard.start_anim_locked = nil
	blackboard.anim_cb_rotation_start = nil
	blackboard.anim_cb_move = nil
	blackboard.start_anim_done = nil
	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_max_speed(navigation_extension, default_move_speed)

	return 
end
BTLootRatLookPlayersAction.run = function (self, unit, blackboard, t, dt)
	local check_time = blackboard.time_to_check_for_players

	if check_time and check_time < t then
		blackboard.time_to_check_for_players = nil

		if not self._player_close(self, unit, blackboard) then
			return "done"
		end
	end

	if blackboard.time_to_play_animation < t then
		blackboard.look_for_players = nil

		return "done"
	end

	return "running"
end
BTLootRatLookPlayersAction.follow = function (self, unit, blackboard, t, dt)
	local navigation_extension = blackboard.navigation_extension
	local destination = navigation_extension.destination(navigation_extension)
	local current_position = POSITION_LOOKUP[unit]
	local breed = blackboard.breed
	local distance_sq = Vector3.distance_squared(current_position, destination)

	if distance_sq < 1 then
		navigation_extension.set_max_speed(navigation_extension, breed.walk_speed)
	elseif 4 < distance_sq then
		navigation_extension.set_max_speed(navigation_extension, breed.run_speed)
	end

	return 
end
BTLootRatLookPlayersAction.start_move_animation = function (self, unit, blackboard)
	self.toggle_start_move_animation_lock(self, unit, true)

	local animation_name = AiAnimUtils.get_start_move_animation(unit, blackboard, blackboard.action)

	Managers.state.network:anim_event(unit, animation_name)

	blackboard.move_animation_name = animation_name
	blackboard.start_anim_locked = true

	return 
end
BTLootRatLookPlayersAction.start_move_rotation = function (self, unit, blackboard, t, dt)
	if blackboard.move_animation_name == "move_start_fwd" then
		self.toggle_start_move_animation_lock(self, unit, false)

		local locomotion_extension = blackboard.locomotion_extension
		local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)

		locomotion_extension.set_wanted_rotation(locomotion_extension, rot)
	else
		blackboard.anim_cb_rotation_start = false
		local rot_scale = AiAnimUtils.get_animation_rotation_scale(unit, blackboard, blackboard.action)

		LocomotionUtils.set_animation_rotation_scale(unit, rot_scale)
	end

	return 
end
BTLootRatLookPlayersAction.toggle_start_move_animation_lock = function (self, unit, should_lock_ani)
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
