require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTMeleeSlamAction = class(BTMeleeSlamAction, BTNode)
BTMeleeSlamAction.init = function (self, ...)
	BTMeleeSlamAction.super.init(self, ...)

	return 
end
BTMeleeSlamAction.name = "BTMeleeSlamAction"
BTMeleeSlamAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.active_node = BTMeleeSlamAction

	self.init_attack(self, unit, blackboard, action, t)

	blackboard.attack_cooldown = t + action.cooldown
	blackboard.anim_locked = t + action.attack_time
	blackboard.move_state = "attacking"
	blackboard.attack_finished = false
	blackboard.attack_aborted = false
	blackboard.keep_target = true

	Managers.state.conflict:freeze_intensity_decay(15)

	return 
end

local function randomize(event)
	if type(event) == "table" then
		return event[Math.random(1, #event)]
	else
		return event
	end

	return 
end

BTMeleeSlamAction.init_attack = function (self, unit, blackboard, action, t)
	local attack_anim, anim_driven = LocomotionUtils.get_attack_anim(unit, blackboard, action.attack_anims)
	blackboard.attack_anim_driven = anim_driven

	LocomotionUtils.set_animation_driven_movement(unit, anim_driven, false, false)

	if anim_driven then
		local locomotion_extension = blackboard.locomotion_extension

		locomotion_extension.use_lerp_rotation(locomotion_extension, false)
	else
		blackboard.navigation_extension:stop()
	end

	Managers.state.network:anim_event(unit, randomize(attack_anim or action.attack_anim))

	local target = blackboard.target_unit
	blackboard.attacking_target = target
	local self_pos = POSITION_LOOKUP[unit]
	local fwd = Vector3.normalize(POSITION_LOOKUP[target] - self_pos)
	local pos, rotation, size = self._calculate_collision(self, action, self_pos, fwd)
	size.x = size.x * 1.2
	size.z = size.z * 1.2

	Managers.state.entity:system("ai_bot_group_system"):aoe_threat_created(pos, "cylinder", size, nil, action.bot_threat_duration)

	return 
end
BTMeleeSlamAction.leave = function (self, unit, blackboard, t)
	if blackboard.attack_anim_driven then
		local locomotion_extension = blackboard.locomotion_extension

		LocomotionUtils.set_animation_driven_movement(unit, false)
		locomotion_extension.use_lerp_rotation(locomotion_extension, true)
	end

	blackboard.attack_anim_driven = nil
	blackboard.action = nil
	blackboard.active_node = nil
	blackboard.attacking_target = nil
	blackboard.keep_target = nil
	blackboard.slams = blackboard.slams + 1
	blackboard.shove_opportunity = blackboard.breed.num_forced_slams_at_target_switch <= blackboard.slams

	return 
end
local temp_hit_units = {}
BTMeleeSlamAction._calculate_collision = function (self, action, self_pos, forward_direction)
	local height = action.height
	local pos = self_pos + forward_direction * action.forward_offset + Vector3(0, 0, height * 0.5)
	local radius = action.radius
	local size = Vector3(action.radius, height, action.radius)
	local rotation = Quaternion.look(Vector3.up(), Vector3.up())

	return pos, rotation, size
end
BTMeleeSlamAction.anim_cb_ratogre_slam = function (self, unit, blackboard)
	local world = blackboard.world
	local physics_world = World.get_data(world, "physics_world")
	local action = blackboard.action
	local unit_forward = Quaternion.forward(Unit.local_rotation(unit, 0))
	local self_pos = POSITION_LOOKUP[unit]
	local pos, rotation, size = self._calculate_collision(self, action, self_pos, unit_forward)

	table.clear(temp_hit_units)
	PhysicsWorld.prepare_actors_for_overlap(physics_world, pos, math.max(action.radius, action.height))

	local hit_actors, num_actors = PhysicsWorld.immediate_overlap(physics_world, "shape", "capsule", "position", pos, "rotation", rotation, "size", size, "types", "both", "collision_filter", "filter_rat_ogre_melee_slam", "use_global_table")

	for i = 1, num_actors, 1 do
		local hit_actor = hit_actors[i]
		local hit_unit = Actor.unit(hit_actor)

		if hit_unit ~= unit then
			temp_hit_units[hit_unit] = true
		end
	end

	local t = Managers.time:time("game")

	for hit_unit, _ in pairs(temp_hit_units) do
		local damage = nil
		local target_status_extension = ScriptUnit.has_extension(hit_unit, "status_system")

		if target_status_extension then
			local dodge = nil

			if target_status_extension.is_dodging then
				local to_target = Vector3.flat(POSITION_LOOKUP[hit_unit] - pos)

				if action.dodge_mitigation_radius_squared < Vector3.length_squared(to_target) then
					dodge = true
				end
			end

			if not dodge then
				if target_status_extension.is_disabled(target_status_extension) then
					damage = action.damage
				elseif DamageUtils.check_block(unit, hit_unit, action.fatigue_type) then
					local blocked_velocity = action.player_push_speed_blocked * Vector3.normalize(POSITION_LOOKUP[hit_unit] - self_pos)
					local locomotion_extension = ScriptUnit.extension(hit_unit, "locomotion_system")

					locomotion_extension.add_external_velocity(locomotion_extension, blocked_velocity)

					damage = action.blocked_damage
				else
					damage = action.damage
				end
			end
		elseif Unit.has_data(hit_unit, "breed") then
			local offset = Vector3.flat(POSITION_LOOKUP[hit_unit] - self_pos)
			local direction = nil

			if Vector3.length_squared(offset) < 0.0001 then
				direction = unit_forward
			else
				direction = Vector3.normalize(offset)
			end

			AiUtils.stagger_target(unit, hit_unit, action.stagger_distance, action.stagger_impact, direction, t)

			damage = action.damage
		elseif ScriptUnit.has_extension(hit_unit, "ladder_system") then
			local ladder_ext = ScriptUnit.extension(hit_unit, "ladder_system")

			ladder_ext.shake(ladder_ext)
		end

		if damage then
			AiUtils.damage_target(hit_unit, unit, action, action.damage)
		end
	end

	return 
end
BTMeleeSlamAction.run = function (self, unit, blackboard, t, dt)
	if t < blackboard.anim_locked then
		if not blackboard.attack_anim_driven then
			local locomotion_extension = blackboard.locomotion_extension
			local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)

			locomotion_extension.set_wanted_rotation(locomotion_extension, rot)
		end

		return "running"
	end

	return "done"
end

return 
