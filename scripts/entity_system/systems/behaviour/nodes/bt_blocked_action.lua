require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBlockedAction = class(BTBlockedAction, BTNode)
BTBlockedAction.init = function (self, ...)
	BTBlockedAction.super.init(self, ...)

	return 
end
BTBlockedAction.name = "BTBlockedAction"
BTBlockedAction.enter = function (self, unit, blackboard, t)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_enabled(navigation_extension, false)

	local action = self._tree_node.action_data
	local anim_table = action.blocked_anims
	local block_anim = anim_table[Math.random(1, #anim_table)]
	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_combat")
	network_manager.anim_event(network_manager, unit, block_anim)
	LocomotionUtils.set_animation_driven_movement(unit, true, true, false)

	local locomotion_extension = blackboard.locomotion_extension

	locomotion_extension.set_rotation_speed(locomotion_extension, 100)
	locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3.zero())

	blackboard.spawn_to_running = nil

	return 
end
BTBlockedAction.leave = function (self, unit, blackboard, t, reason)
	blackboard.blocked = nil
	blackboard.stagger_hit_wall = nil

	LocomotionUtils.set_animation_driven_movement(unit, false, false)

	local locomotion_extension = blackboard.locomotion_extension

	locomotion_extension.set_rotation_speed(locomotion_extension, 10)
	locomotion_extension.set_wanted_rotation(locomotion_extension, nil)
	locomotion_extension.set_movement_type(locomotion_extension, "snap_to_navmesh")
	locomotion_extension.set_wanted_velocity(locomotion_extension, Vector3.zero())

	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_enabled(navigation_extension, true)

	return 
end
BTBlockedAction.run = function (self, unit, blackboard, t, dt)
	local locomotion_extension = blackboard.locomotion_extension

	if locomotion_extension.movement_type ~= "constrained_by_mover" and not blackboard.stagger_hit_wall then
		Profiler.start("checking navmesh")

		local position = POSITION_LOOKUP[unit]
		local velocity = locomotion_extension.current_velocity(locomotion_extension)
		local nav_world = blackboard.nav_world
		local world = blackboard.world
		local physics_world = World.physics_world(world)
		local navigation_extension = blackboard.navigation_extension
		local traverse_logic = navigation_extension.traverse_logic(navigation_extension)
		local result = LocomotionUtils.navmesh_movement_check(position, velocity, nav_world, physics_world, traverse_logic)

		if result == "navmesh_hit_wall" then
			blackboard.stagger_hit_wall = true
		elseif result == "navmesh_use_mover" then
			local breed = blackboard.breed
			local override_mover_move_distance = breed.override_mover_move_distance

			locomotion_extension.set_movement_type(locomotion_extension, "constrained_by_mover", override_mover_move_distance)
		end

		Profiler.stop("checking navmesh")
	end

	return "running"
end

return 
