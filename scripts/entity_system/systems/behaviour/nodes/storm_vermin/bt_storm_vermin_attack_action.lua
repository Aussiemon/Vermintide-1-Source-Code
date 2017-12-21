require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTStormVerminAttackAction = class(BTStormVerminAttackAction, BTNode)
BTStormVerminAttackAction.init = function (self, ...)
	BTStormVerminAttackAction.super.init(self, ...)

	return 
end
BTStormVerminAttackAction.name = "BTStormVerminAttackAction"
BTStormVerminAttackAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.active_node = BTStormVerminAttackAction
	blackboard.attack_range = action.range
	blackboard.attack_finished = false
	blackboard.attack_aborted = false
	local target_unit = blackboard.target_unit
	blackboard.target_unit_status_extension = (ScriptUnit.has_extension(target_unit, "status_system") and ScriptUnit.extension(target_unit, "status_system")) or nil
	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_combat")

	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	network_manager.network_transmit:send_rpc_all("rpc_enemy_has_target", unit_id, true)

	local navigation_extension = blackboard.navigation_extension

	blackboard.navigation_extension:set_enabled(false)
	blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())

	blackboard.special_attacking_target = blackboard.target_unit

	self._init_attack(self, unit, blackboard, t)

	blackboard.spawn_to_running = nil

	return 
end
BTStormVerminAttackAction._init_attack = function (self, unit, blackboard, t)
	local action = blackboard.action
	blackboard.move_state = "attacking"

	Managers.state.network:anim_event(unit, action.attack_anim)

	local rotation = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.special_attacking_target)
	blackboard.attack_rotation = QuaternionBox(rotation)
	blackboard.attack_rotation_update_timer = t + action.rotation_time

	return 
end
BTStormVerminAttackAction.leave = function (self, unit, blackboard, t)
	blackboard.move_state = nil

	blackboard.navigation_extension:set_enabled(true)

	blackboard.target_unit_status_extension = nil
	blackboard.update_timer = 0
	blackboard.active_node = nil
	blackboard.attack_aborted = nil
	blackboard.attack_rotation = nil
	blackboard.attack_rotation_update_timer = nil
	blackboard.special_attacking_target = nil

	return 
end
BTStormVerminAttackAction.run = function (self, unit, blackboard, t, dt)
	if Unit.alive(blackboard.special_attacking_target) then
		self.attack(self, unit, t, dt, blackboard)
	end

	if blackboard.attack_finished then
		return "done"
	end

	return "running"
end
BTStormVerminAttackAction.attack = function (self, unit, t, dt, blackboard)
	if t < blackboard.attack_rotation_update_timer and blackboard and blackboard.target_unit_status_extension and not blackboard.target_unit_status_extension:get_is_dodging() then
		local rotation = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.special_attacking_target)
		blackboard.attack_rotation = QuaternionBox(rotation)
	end

	local locomotion_extension = blackboard.locomotion_extension

	locomotion_extension.set_wanted_rotation(locomotion_extension, blackboard.attack_rotation:unbox())

	return 
end
local debug_drawer_info = {
	mode = "retained",
	name = "BTStormVerminAttackAction"
}
BTStormVerminAttackAction.anim_cb_damage = function (self, unit, blackboard)
	local action = blackboard.action
	local world = Unit.world(unit)
	local pw = World.get_data(world, "physics_world")
	local range = action.range
	local height = action.height
	local width = action.width
	local offset_up = action.offset_up
	local offset_forward = action.offset_forward
	local half_range = range*0.5
	local half_height = height*0.5
	local hit_size = Vector3(width*0.5, half_range, half_height)
	local rat_pos = Unit.local_position(unit, 0)
	local rat_rot = Unit.local_rotation(unit, 0)
	local forward = Quaternion.rotate(rat_rot, Vector3.forward())*(offset_forward + half_range)
	local up = Vector3.up()*(half_height + offset_up)
	local oobb_pos = rat_pos + forward + up
	local hit_actors, actor_count = PhysicsWorld.immediate_overlap(pw, "position", oobb_pos, "rotation", rat_rot, "size", hit_size, "shape", "oobb", "types", "dynamics", "collision_filter", "filter_player_hit_box_check", "use_global_table")

	if Development.parameter("debug_weapons") then
		local drawer = Managers.state.debug:drawer(debug_drawer_info)

		drawer.reset(drawer)

		local pose = Matrix4x4.from_quaternion_position(rat_rot, oobb_pos)

		drawer.box(drawer, pose, hit_size)
	end

	local hit_units = FrameTable.alloc_table()

	for _, actor in ipairs(hit_actors) do
		local target_unit = Actor.unit(actor)
		hit_units[target_unit] = true
	end

	for target_unit, _ in pairs(hit_units) do
		if not Unit.alive(target_unit) then
			return 
		end

		if DamageUtils.check_block(unit, target_unit, action.fatigue_type) then
			return 
		end

		AiUtils.damage_target(target_unit, unit, action, action.damage)
	end

	return 
end

return 
