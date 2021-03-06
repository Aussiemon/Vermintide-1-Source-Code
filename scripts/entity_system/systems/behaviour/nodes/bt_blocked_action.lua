require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBlockedAction = class(BTBlockedAction, BTNode)

BTBlockedAction.init = function (self, ...)
	BTBlockedAction.super.init(self, ...)
end

BTBlockedAction.name = "BTBlockedAction"

BTBlockedAction.enter = function (self, unit, blackboard, t)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension:set_enabled(false)

	local action = self._tree_node.action_data
	local anim_table = action.blocked_anims
	local block_anim = anim_table[Math.random(1, #anim_table)]
	local network_manager = Managers.state.network

	network_manager:anim_event(unit, "to_combat")
	network_manager:anim_event(unit, block_anim)
	LocomotionUtils.set_animation_driven_movement(unit, true, true, false)

	local locomotion_extension = blackboard.locomotion_extension

	locomotion_extension:set_rotation_speed(100)
	locomotion_extension:set_wanted_velocity(Vector3.zero())

	blackboard.spawn_to_running = nil
end

BTBlockedAction.leave = function (self, unit, blackboard, t, reason)
	blackboard.blocked = nil
	blackboard.stagger_hit_wall = nil

	LocomotionUtils.set_animation_driven_movement(unit, false, false)

	local locomotion_extension = blackboard.locomotion_extension

	locomotion_extension:set_rotation_speed(10)
	locomotion_extension:set_wanted_rotation(nil)
	locomotion_extension:set_movement_type("snap_to_navmesh")
	locomotion_extension:set_wanted_velocity(Vector3.zero())

	local navigation_extension = blackboard.navigation_extension

	navigation_extension:set_enabled(true)
end

BTBlockedAction.run = function (self, unit, blackboard, t, dt)
	local locomotion_extension = blackboard.locomotion_extension

	if locomotion_extension.movement_type ~= "constrained_by_mover" and not blackboard.stagger_hit_wall then
		Profiler.start("checking navmesh")

		local position = POSITION_LOOKUP[unit]
		local velocity = locomotion_extension:current_velocity()
		local nav_world = blackboard.nav_world
		local world = blackboard.world
		local physics_world = World.physics_world(world)
		local navigation_extension = blackboard.navigation_extension
		local traverse_logic = navigation_extension:traverse_logic()
		local result = LocomotionUtils.navmesh_movement_check(position, velocity, nav_world, physics_world, traverse_logic)

		if result == "navmesh_hit_wall" then
			blackboard.stagger_hit_wall = true
		elseif result == "navmesh_use_mover" then
			local breed = blackboard.breed
			local override_mover_move_distance = breed.override_mover_move_distance
			local ignore_forced_mover_kill = true
			local successful = locomotion_extension:set_movement_type("constrained_by_mover", override_mover_move_distance, ignore_forced_mover_kill)

			if not successful then
				local mover = Unit.mover(unit)
				local radius = Mover.radius(mover)

				QuickDrawerStay:sphere(position, radius, Colors.get("red"))
				QuickDrawerStay:line(position, position + Vector3(0, 0, 5), Colors.get("red"))

				local debug_text = string.format("LD should check the Navmesh here, Mover separation failed for %s!", breed.name)

				Debug.world_sticky_text(position + Vector3(0, 0, 5), debug_text, "red")
				locomotion_extension:set_movement_type("snap_to_navmesh")

				blackboard.stagger_hit_wall = true
			end
		end

		Profiler.stop("checking navmesh")
	end

	return "running"
end

return
