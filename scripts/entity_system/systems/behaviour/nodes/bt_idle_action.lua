require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTIdleAction = class(BTIdleAction, BTNode)
BTIdleAction.name = "BTIdleAction"
local PLAYER_POSITIONS = PLAYER_POSITIONS
local PLAYER_UNITS = PLAYER_UNITS
BTIdleAction.init = function (self, ...)
	BTIdleAction.super.init(self, ...)

	return 
end
BTIdleAction.enter = function (self, unit, blackboard, t)
	local network_manager = Managers.state.network
	local animation = blackboard.idle_animation or "idle"
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.spawn_to_running = nil

	AiAnimUtils.set_idle_animation_merge(unit, blackboard)

	if blackboard.is_passive then
		network_manager.anim_event(network_manager, unit, "to_passive")
	end

	if blackboard.move_state ~= "idle" then
		network_manager.anim_event(network_manager, unit, animation)

		blackboard.move_state = "idle"
	end

	blackboard.navigation_extension:set_enabled(false)
	blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())

	return 
end
BTIdleAction.leave = function (self, unit, blackboard, t)
	AiAnimUtils.reset_animation_merge(unit)
	blackboard.navigation_extension:set_enabled(true)

	return 
end

local function player_within_distance(unit, sqr_near_dist)
	local pos = POSITION_LOOKUP[unit]
	local player_positions = PLAYER_POSITIONS

	for i = 1, #player_positions, 1 do
		local player_pos = player_positions[i]
		local sqr_dist = Vector3.distance_squared(pos, player_pos)

		if sqr_dist < sqr_near_dist then
			print("lootrat jingle")

			return PLAYER_UNITS[i]
		end
	end

	return 
end

BTIdleAction._discovery_sound_when_close = function (self, unit, blackboard)
	local near_distance_sqr = blackboard.action and blackboard.action.sound_when_near_distance_sqr

	if near_distance_sqr and not blackboard.sound_when_near_played then
		local player_unit = player_within_distance(unit, near_distance_sqr)

		if player_unit then
			local player = Managers.player:unit_owner(player_unit)
			local peer_id = player.network_id(player)
			local network_manager = Managers.state.network
			local sound_event = blackboard.action.sound_when_near_event
			local sound_id = NetworkLookup.sound_events[sound_event]
			local unit_id = network_manager.unit_game_object_id(network_manager, unit)

			network_manager.network_transmit:send_rpc("rpc_server_audio_unit_event", peer_id, sound_id, unit_id, 0)

			blackboard.sound_when_near_played = true
		end
	end

	return 
end
local Unit_alive = Unit.alive
BTIdleAction.run = function (self, unit, blackboard, t, dt)
	local target_unit = blackboard.target_unit

	if Unit_alive(target_unit) then
		local rot = LocomotionUtils.rotation_towards_unit_flat(unit, target_unit)

		blackboard.locomotion_extension:set_wanted_rotation(rot)
	end

	self._discovery_sound_when_close(self, unit, blackboard)

	return "running"
end

return 
