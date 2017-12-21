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
	blackboard.hit_players = blackboard.hit_players or {}

	if action.animation_driven then
		LocomotionUtils.set_animation_driven_movement(unit, true)
	end

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
BTStormVerminAttackAction.leave = function (self, unit, blackboard, t, reason, destroy)
	local action = blackboard.action
	local catapulted_players = blackboard.catapulted_players

	if catapulted_players then
		blackboard.catapulted_players = nil

		if not destroy and catapulted_players[1] then
			self._catapult_players(self, unit, blackboard, action, catapulted_players)
		end
	end

	if not destroy and action.animation_driven then
		LocomotionUtils.set_animation_driven_movement(unit, false)
	end

	blackboard.navigation_extension:set_enabled(true)
	table.clear(blackboard.hit_players)

	blackboard.move_state = nil
	blackboard.target_unit_status_extension = nil
	blackboard.update_timer = 0
	blackboard.active_node = nil
	blackboard.attack_aborted = nil
	blackboard.attack_rotation = nil
	blackboard.attack_rotation_update_timer = nil
	blackboard.special_attacking_target = nil
	blackboard.action = nil

	return 
end
BTStormVerminAttackAction.run = function (self, unit, blackboard, t, dt)
	if Unit.alive(blackboard.special_attacking_target) then
		self.attack(self, unit, t, dt, blackboard)
	end

	local action = blackboard.action
	local catapulted_players = blackboard.catapulted_players

	if catapulted_players and catapulted_players[1] then
		self._catapult_players(self, unit, blackboard, action, catapulted_players)
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
	local self_pos = Unit.local_position(unit, 0)
	local self_rot = Unit.local_rotation(unit, 0)
	local forward = Quaternion.rotate(self_rot, Vector3.forward())*(offset_forward + half_range)
	local up = Vector3.up()*(half_height + offset_up)
	local oobb_pos = self_pos + forward + up
	local hit_actors, actor_count = PhysicsWorld.immediate_overlap(pw, "position", oobb_pos, "rotation", self_rot, "size", hit_size, "shape", "oobb", "types", "dynamics", "collision_filter", "filter_player_hit_box_check", "use_global_table")

	if Development.parameter("debug_weapons") then
		local drawer = Managers.state.debug:drawer(debug_drawer_info)

		drawer.reset(drawer)

		local pose = Matrix4x4.from_quaternion_position(self_rot, oobb_pos)

		drawer.box(drawer, pose, hit_size)
	end

	self._deal_damage(self, unit, blackboard, action, self_pos, hit_actors, true)

	return 
end
BTStormVerminAttackAction._deal_damage = function (self, unit, blackboard, action, self_pos, hit_actors, is_animation_callback)
	local hit_players = blackboard.hit_players
	local Unit_alive = Unit.alive
	local Actor_unit = Actor.unit
	local AiUtils_damage_target = AiUtils.damage_target
	local catapult = action.catapult
	local shove_speed = action.shove_speed
	local shove_z_speed = action.shove_z_speed

	assert(not shove_speed == not shove_z_speed, "Shove speed and shove_z_speed both or neither need to be set")

	for _, actor in pairs(hit_actors) do
		local target_unit = Actor_unit(actor)

		if Unit_alive(target_unit) and not hit_players[target_unit] then
			hit_players[target_unit] = true
			local blocked = DamageUtils.check_block(unit, target_unit, action.fatigue_type)
			local target_pos = POSITION_LOOKUP[target_unit]

			if shove_speed then
				local direction = Vector3.normalize(target_pos - self_pos)

				if is_animation_callback then
					local catapulted = blackboard.catapulted_players

					if not catapulted then
						catapulted = {}
						blackboard.catapulted_players = catapulted
					end

					catapulted[#catapulted + 1] = {
						target_unit = target_unit,
						blocked = blocked,
						direction = Vector3Box(direction)
					}
				else
					self._catapult_enemy(self, unit, blackboard, shove_speed, shove_z_speed, target_unit, blocked, direction)
				end
			end

			if blocked then
				local push_speed = action.player_push_speed_blocked

				if push_speed then
					local blocked_velocity = push_speed*Vector3.normalize(target_pos - self_pos)
					local locomotion_extension = ScriptUnit.extension(target_unit, "locomotion_system")

					locomotion_extension.add_external_velocity(locomotion_extension, blocked_velocity)
				end

				local blocked_damage = action.blocked_damage

				if blocked_damage then
					AiUtils_damage_target(target_unit, unit, action, blocked_damage)
				end

				return 
			else
				AiUtils_damage_target(target_unit, unit, action, action.damage)
			end
		end
	end

	return 
end
BTStormVerminAttackAction._catapult_players = function (self, unit, blackboard, action, catapulted_players)
	local shove_speed = action.shove_speed
	local shove_z_speed = action.shove_z_speed

	for _, data in ipairs(catapulted_players) do
		self._catapult_player(self, unit, shove_speed, shove_z_speed, data.target_unit, data.blocked, data.direction:unbox())
	end

	table.clear(catapulted_players)

	return 
end
BTStormVerminAttackAction._catapult_player = function (self, unit, shove_speed, shove_z_speed, target_unit, blocked, direction)
	local target_status_extension = ScriptUnit.extension(target_unit, "status_system")

	if not target_status_extension.is_knocked_down(target_status_extension) and not target_status_extension.is_dead(target_status_extension) then
		local push_velocity = direction*shove_speed

		Vector3.set_z(push_velocity, shove_z_speed)

		local target_locomotion_extension = ScriptUnit.extension(target_unit, "locomotion_system")

		target_status_extension.set_catapulted(target_status_extension, true, push_velocity)
	end

	return 
end

return 
