require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTMeleeShoveAction = class(BTMeleeShoveAction, BTNode)
BTMeleeShoveAction.init = function (self, ...)
	BTMeleeShoveAction.super.init(self, ...)

	return 
end
BTMeleeShoveAction.name = "BTMeleeShoveAction"
local POSITION_LOOKUP = POSITION_LOOKUP

local function randomize(event)
	if type(event) == "table" then
		return event[Math.random(1, #event)]
	else
		return event
	end

	return 
end

BTMeleeShoveAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.active_node = BTMeleeShoveAction
	local target_unit = blackboard.target_unit
	local target_pos = POSITION_LOOKUP[target_unit]
	local target_velocity = ScriptUnit.extension(target_unit, "locomotion_system"):current_velocity()
	local velocity_threshold = action.target_running_velocity_threshold
	local dir = Vector3.normalize(target_pos - POSITION_LOOKUP[unit])
	local target_running = velocity_threshold < Vector3.dot(target_velocity, dir)
	local right = 0.5 < Math.random()
	local attack_anim = nil
	local anim_driven = false

	if target_running or blackboard.fling_skaven then
		attack_anim = (right and action.attack_anim_right_running) or action.attack_anim_left_running

		LocomotionUtils.set_animation_driven_movement(unit, true, false, true)

		anim_driven = true
	else
		attack_anim = (right and action.attack_anim_right) or action.attack_anim_left
		blackboard.move_state = "attacking"
	end

	Managers.state.network:anim_event(unit, randomize(attack_anim))

	blackboard.attack_cooldown = t + action.cooldown
	blackboard.anim_locked = t + action.attack_time
	blackboard.keep_target = true
	local hand_node = (right and Unit.node(unit, "j_righthand")) or Unit.node(unit, "j_lefthand")
	local elbow_node = (right and Unit.node(unit, "j_rightforearm")) or Unit.node(unit, "j_leftforearm")
	local ai_extension = ScriptUnit.extension(unit, "ai_system")
	blackboard.shove_data = {
		shove_everybody = true,
		start_time = t + 0.4,
		overlap_context = ai_extension.get_overlap_context(ai_extension),
		physics_world = World.get_data(blackboard.world, "physics_world"),
		hand_node = hand_node,
		elbow_node = elbow_node,
		hand_pos = Vector3Box(Unit.world_position(unit, hand_node)),
		hit_units = {},
		animation_driven = anim_driven
	}
	blackboard.attacking_target = blackboard.target_unit

	if not blackboard.fling_skaven then
		Managers.state.conflict:freeze_intensity_decay(15)
	end

	return 
end
BTMeleeShoveAction.leave = function (self, unit, blackboard, t)
	if blackboard.shove_data.animation_driven then
		LocomotionUtils.set_animation_driven_movement(unit, false)
	end

	blackboard.shove_data = nil
	blackboard.action = nil
	blackboard.active_node = nil
	blackboard.fling_skaven = false
	blackboard.attacking_target = nil
	blackboard.keep_target = nil

	return 
end
local MAX_SHOVE_ANGLE = math.pi/6
local MAX_SHOVE_X = math.cos(MAX_SHOVE_ANGLE)
local MAX_SHOVE_Y = math.sin(MAX_SHOVE_ANGLE)
BTMeleeShoveAction.run = function (self, unit, blackboard, t, dt)
	if t < blackboard.anim_locked then
		local data = blackboard.shove_data

		if data.start_time < t and data.shove_everybody then
			local action = self._tree_node.action_data
			local hit_units = data.hit_units
			local self_rot = Unit.local_rotation(unit, 0)
			local fwd_dir = Quaternion.forward(self_rot)
			hit_units[unit] = true
			local hand_pos = Unit.world_position(unit, data.hand_node)
			local elbow_pos = Unit.world_position(unit, data.elbow_node)
			local old_hand_pos = data.hand_pos:unbox()
			local to_old_frame_hand_pos = old_hand_pos - hand_pos
			local frame_dist = Vector3.length(to_old_frame_hand_pos)
			local arm_vec = hand_pos - elbow_pos
			local mid_pos = elbow_pos + arm_vec*0.5
			local arm_rot = Quaternion.look(arm_vec, Vector3.up())
			local oobb_pos = mid_pos + to_old_frame_hand_pos*0.5
			local half_length = 1
			local half_height = 1
			local half_width = frame_dist*0.5 + 0.2
			local box_size = Vector3(half_width, half_length, half_height)

			PhysicsWorld.prepare_actors_for_overlap(data.physics_world, oobb_pos, 1.2)

			local hit_actors, num_hit_actors = PhysicsWorld.immediate_overlap(data.physics_world, "position", oobb_pos, "rotation", arm_rot, "size", box_size, "shape", "oobb", "types", "dynamics", "collision_filter", "filter_player_and_enemy_hit_box_check", "use_global_table")

			if 0 < num_hit_actors then
				self.overlap_checks(self, unit, blackboard, t, hit_actors, num_hit_actors, hit_units, fwd_dir, action)
			end

			data.hand_pos:store(hand_pos)
		end

		local rot = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.target_unit)

		blackboard.locomotion_extension:set_wanted_rotation(rot)

		return "running"
	end

	return "done"
end
BTMeleeShoveAction.overlap_checks = function (self, unit, blackboard, t, hit_actors, num_hit_actors, hit_units, fwd_dir, action)
	local self_pos = POSITION_LOOKUP[unit]
	local player_owner = Managers.player.owner

	for i = 1, num_hit_actors, 1 do
		local hit_actor = hit_actors[i]
		local hit_unit = Actor.unit(hit_actor)

		if not hit_units[hit_unit] then
			hit_units[hit_unit] = true
			local enemy_pos = POSITION_LOOKUP[hit_unit]

			if enemy_pos then
				local shove_dir = Vector3.normalize(enemy_pos - self_pos)

				if 0 < Vector3.dot(shove_dir, fwd_dir) then
					if Managers.player:owner(hit_unit) then
						local shove_speed = action.shove_speed
						local blocked = false

						if DamageUtils.check_block(unit, blackboard.target_unit, action.fatigue_type) and action.shove_blocked_speed_mul then
							shove_speed = shove_speed*action.shove_blocked_speed_mul
							blocked = true
						end

						local push_velocity = shove_dir*shove_speed

						Vector3.set_z(push_velocity, action.shove_z_speed)
						self.hit_player(self, unit, blackboard, hit_unit, push_velocity, shove_dir, blocked)
					else
						local target_ai_blackboard = Unit.get_data(hit_unit, "blackboard")

						if target_ai_blackboard then
							local stagger_type, stagger_duration = DamageUtils.calculate_stagger(action.stagger_impact, action.stagger_duration, hit_unit, unit)

							if 0 < stagger_type then
								AiUtils.stagger(hit_unit, target_ai_blackboard, unit, shove_dir, action.stagger_distance, stagger_type, stagger_duration, nil, t)
							end
						end
					end
				end
			else
				print("HIT GREY SEER!", hit_unit)
			end
		end
	end

	return 
end
BTMeleeShoveAction.hit_player = function (self, unit, blackboard, target_unit, velocity, blocked_velocity, blocked)
	local action = blackboard.action
	local target_status_extension = ScriptUnit.extension(target_unit, "status_system")

	if not blocked then
		AiUtils.damage_target(target_unit, unit, action, action.damage)
	else
		local has_inventory_extension = ScriptUnit.has_extension(unit, "ai_inventory_system")

		if has_inventory_extension then
			local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")

			inventory_extension.play_hit_sound(inventory_extension, target_unit, action.damage_type)
		end
	end

	blackboard.attacks_done = blackboard.attacks_done + 5
	local status_extension = ScriptUnit.extension(target_unit, "status_system")

	if not target_status_extension.knocked_down then
		target_status_extension.set_catapulted(target_status_extension, true, velocity)
	end

	return 
end
BTMeleeShoveAction.anim_cb_shove_done = function (self, unit, blackboard)
	blackboard.shove_data.shove_everybody = nil

	return 
end

return 
