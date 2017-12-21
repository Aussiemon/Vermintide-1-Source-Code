require("scripts/unit_extensions/generic/generic_state_machine")

script_data.debug_csm = script_data.debug_csm or Development.parameter("debug_csm")
PlayerBotInput = class(PlayerBotInput)
local POSITION_LOOKUP = POSITION_LOOKUP
PlayerBotInput.init = function (self, extension_init_context, unit, extension_init_data)
	math.asin(1)
	math.atan2(1, 1)

	self.unit = unit
	self.move = {
		x = 0,
		y = 0
	}
	self.look = {
		x = 0,
		y = 0
	}
	self._aim_target = Vector3Box(0, 0, 0)
	self._aim_rotation = QuaternionBox(0, 0, 0)
	self._aiming = false
	self._soft_aiming = false
	self._charge_shot = false
	self._charge_shot_held = false
	self._fire = false
	self._defend = false
	self._defend_held = false
	self._melee_push = false
	self._hold_attack = false
	self._tap_attack = false
	self._tap_attack_released = true
	self._interact = false
	self._interact_held = false
	self.dodge_on_jump_key = DefaultUserSettings.get("user_settings", "dodge_on_jump_key")
	self.dodge_on_forward_diagonal = DefaultUserSettings.get("user_settings", "dodge_on_forward_diagonal")
	self.double_tap_dodge = DefaultUserSettings.get("user_settings", "double_tap_dodge")
	self._input = {}
	self._world = extension_init_context.world
	self._nav_world = Managers.state.entity:system("ai_system"):nav_world()

	return 
end
PlayerBotInput.extensions_ready = function (self, world, unit)
	local ext = ScriptUnit.extension
	self._navigation_extension = ext(unit, "ai_navigation_system")
	self._status_extension = ext(unit, "status_system")
	self._first_person_extension = ext(unit, "first_person_system")

	return 
end
PlayerBotInput.destroy = function (self)
	return 
end
PlayerBotInput.reset = function (self)
	return 
end
PlayerBotInput.pre_update = function (self, unit, input, dt, context, t)
	local position = POSITION_LOOKUP[unit]
	local success, altitude = GwNavQueries.triangle_from_position(self._nav_world, position, 1.1, 0.5)
	self._position_on_navmesh = (success and Vector3(position.x, position.y, altitude)) or position

	return 
end
PlayerBotInput.update = function (self, unit, input, dt, context, t)
	table.clear(self._input)

	local move_x = self.move.x
	local move_y = self.move.y
	local look_x = self.look.x
	local look_y = self.look.y

	if move_x ~= 0 then
		move_x = self.lerp_toward_zero(self, move_x)
	end

	if move_y ~= 0 then
		move_y = self.lerp_toward_zero(self, move_y)
	end

	self.move.x = move_x
	self.move.y = move_y

	self._update_movement(self, dt, t)
	self._update_actions(self)

	return 
end
PlayerBotInput._update_actions = function (self)
	local input = self._input

	if self._fire then
		self._fire = false
		input.action_one = true
	end

	if self._melee_push then
		self._melee_push = false
		self._defend = false

		if not self._defend_held then
			self._defend_held = true
			input.action_two = true
		end

		input.action_two_hold = true
		input.action_one = true
	elseif self._defend then
		self._defend = false

		if not self._defend_held then
			self._defend_held = true
			input.action_two = true
		end

		input.action_two_hold = true
	elseif self._defend_held then
		self._defend_held = false
		input.action_two_release = true
	end

	if self._hold_attack then
		input.action_one = true
		input.action_one_hold = true
		self._hold_attack = false
		self._attack_held = true
	elseif self._attack_held then
		self._attack_held = false
		input.action_one_release = true
	elseif not self._tap_attack_released then
		self._tap_attack_released = true
		input.action_one_release = true
	elseif self._tap_attack then
		self._tap_attack_released = false
		self._tap_attack = false
		input.action_one = true
	end

	if self._charge_shot then
		self._charge_shot = false
		input.action_two_hold = true

		if not self._charge_shot_held then
			input.action_two = true
			self._charge_shot_held = true
		end
	elseif self._charge_shot_held then
		self._charge_shot_held = false
		input.action_two_release = true
	end

	if self._interact then
		self._interact = false

		if not self._interact_held then
			self._interact_held = true
			input.interact = true
		end

		input.interacting = true
	elseif self._interact_held then
		self._interact_held = false
	end

	local slot_to_wield = self._slot_to_wield

	if slot_to_wield then
		self._slot_to_wield = nil
		local slots = InventorySettings.slots
		local num_slots = #slots
		local wield_input = nil

		for i = 1, num_slots, 1 do
			local slot_data = slots[i]

			if slot_data.name == slot_to_wield then
				wield_input = slot_data.wield_input
			end
		end

		input[wield_input] = true
	end

	return 
end
PlayerBotInput._debug_aim_target_sine_curve = function (self, dt, t)
	local pos = Vector3(-70.1625, -90.9497, -7.42347)
	local z = math.sin(t)*3 - 6
	local x = math.sin(t*0.3)*5 - 10
	local y = math.sin(t*2)*5 - 10
	pos = pos + Vector3(x, y, z)

	self._aim_target:store(pos)

	local drawer = Managers.state.debug:drawer({
		mode = "immediate",
		name = "playerbotinput"
	})

	drawer.sphere(drawer, pos, 0.5, Color(255, 0, 0))

	return 
end
PlayerBotInput.set_aim_position = function (self, position)
	self._aim_target:store(position)

	return 
end
PlayerBotInput.set_aim_rotation = function (self, rotation)
	self._aim_rotation:store(rotation)

	return 
end
PlayerBotInput.set_aiming = function (self, aiming, soft, use_rotation)
	self._aiming = aiming
	self._aim_with_rotation = (use_rotation and aiming) or false

	if aiming and soft then
		self._soft_aiming = true
	else
		self._soft_aiming = false
	end

	return 
end
PlayerBotInput.defend = function (self)
	self._defend = true

	return 
end
PlayerBotInput.melee_push = function (self)
	self._melee_push = true

	return 
end
PlayerBotInput.hold_attack = function (self)
	self._hold_attack = true

	return 
end
PlayerBotInput.tap_attack = function (self)
	self._tap_attack = true

	return 
end
PlayerBotInput.charge_shot = function (self)
	self._charge_shot = true

	return 
end
PlayerBotInput.fire = function (self)
	self._fire = true

	return 
end
PlayerBotInput.interact = function (self)
	self._interact = true

	return 
end
PlayerBotInput.wield = function (self, slot)
	self._slot_to_wield = slot

	return 
end
local Quaternion_look = Quaternion.look
local Quaternion_multiply = Quaternion.multiply
PlayerBotInput._update_movement = function (self, dt, t)
	local player_bot_navigation = self._navigation_extension
	local current_goal = player_bot_navigation.current_goal(player_bot_navigation)
	local position = self._position_on_navmesh
	local first_person_extension = self._first_person_extension
	local rotation = first_person_extension.current_rotation(first_person_extension)
	local camera_position = first_person_extension.current_camera_position(first_person_extension)
	local wanted_rotation = nil
	local status_ext = self._status_extension
	local on_ladder, ladder_unit = status_ext.get_is_on_ladder(status_ext)
	local transition_jump = nil
	local up = Vector3.up()

	if self._aiming and self._aim_with_rotation then
		wanted_rotation = self._aim_rotation:unbox()
	elseif self._aiming then
		wanted_rotation = Quaternion_look(self._aim_target:unbox() - camera_position, up)
	elseif self._aiming and self._soft_aiming then
		local direction = self._aim_target:unbox() - camera_position
		wanted_rotation = Quaternion.lerp(rotation, Quaternion_look(direction, up), math.min(dt*5, 1))
	elseif current_goal and on_ladder then
		local dir = current_goal - position
		local ladder_up = Quaternion.up(Unit.local_rotation(ladder_unit, 0))

		if dir.z < 0 then
			wanted_rotation = Quaternion_look(-ladder_up, up)
		else
			wanted_rotation = Quaternion_look(ladder_up, up)
		end
	elseif current_goal then
		local dir = current_goal - position

		if player_bot_navigation.is_in_transition(player_bot_navigation) then
			transition_jump = player_bot_navigation.transition_requires_jump(player_bot_navigation, position, Vector3.normalize(dir))
			wanted_rotation = Quaternion_look(dir, up)
		else
			wanted_rotation = Quaternion.lerp(rotation, Quaternion_look(dir, up), math.min(dt*2, 1))
		end
	else
		wanted_rotation = Quaternion.lerp(rotation, Unit.local_rotation(self.unit, 0), math.min(dt*2, 1))
	end

	local needed_delta_rotation = Quaternion.multiply(Quaternion.inverse(rotation), wanted_rotation)
	local needed_delta_rotation_forward = Quaternion.forward(needed_delta_rotation)
	local look = self.look
	look.x = math.pi*0.5 - math.atan2(needed_delta_rotation_forward.y, needed_delta_rotation_forward.x)
	look.y = math.asin(math.clamp(needed_delta_rotation_forward.z, -1, 1))

	if script_data.ai_bots_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "immediate",
			name = "playerbotinput"
		})

		drawer.quaternion(drawer, camera_position, rotation)
	end

	if not current_goal then
		if on_ladder then
			self._input.jump = true
		end

		self.move.x = 0
		self.move.y = 0

		return 
	end

	local goal_vector = current_goal - position
	local goal_direction = Vector3.normalize(Vector3.flat(goal_vector))

	if 0.0001 < Vector3.length(goal_direction) and not on_ladder then
		local physics_world = World.get_data(self._world, "physics_world")
		local collision_filter = "filter_ai_line_of_sight_check"
		local forward_offset = 0.25
		local jump_range_check_epsilon = 0.05
		local width = 0.4
		local depth = math.min(0.5, Vector3.length(goal_vector) - jump_range_check_epsilon)
		local height = 0.8
		local half_width = width*0.5
		local half_depth = depth*0.5
		local half_height = height*0.5
		local half_upper_height = 0.25
		local half_upper_depth = half_depth + 0.1
		local lower_check_pos = position + goal_direction*(half_depth + forward_offset) + Vector3(0, 0, half_height + 0.4)
		local upper_check_pos = lower_check_pos + goal_direction*(half_upper_depth - half_depth) + Vector3(0, 0, half_upper_height + half_height)
		local lower_extents = Vector3(half_width, half_depth, half_height)
		local upper_extents = Vector3(half_width, half_upper_depth, half_upper_height)
		local rotation = Quaternion_look(goal_direction, up)
		local lower_hit = false
		local upper_hit = false
		local actors, num_actors = PhysicsWorld.immediate_overlap(physics_world, "shape", "oobb", "position", lower_check_pos, "rotation", rotation, "size", lower_extents, "types", "statics", "collision_filter", collision_filter, "use_global_table")

		if 0 < num_actors then
			lower_hit = true
			local actors, num_actors = PhysicsWorld.immediate_overlap(physics_world, "shape", "oobb", "position", upper_check_pos, "rotation", rotation, "size", upper_extents, "types", "statics", "collision_filter", collision_filter, "use_global_table")

			if num_actors == 0 then
				upper_hit = true
				self._input.jump = true
			end
		end

		if not self._input.jump and transition_jump then
			self._input.jump = true
		end

		if script_data.ai_bots_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "immediate",
				name = "playerbotinput"
			})
			local lower_pose = Matrix4x4.from_quaternion_position(rotation, lower_check_pos)
			local lower_color = (lower_hit and Color(125, 255, 125)) or Color(0, 255, 0)

			drawer.box(drawer, lower_pose, lower_extents, lower_color)

			local upper_pose = Matrix4x4.from_quaternion_position(rotation, upper_check_pos)
			local upper_color = (upper_hit and Color(255, 125, 125)) or Color(255, 0, 0)

			drawer.box(drawer, upper_pose, upper_extents, upper_color)
		end
	end

	local move = self.move

	if on_ladder then
		move.x = 0
		move.y = 1
	else
		move.x = Vector3.dot(Quaternion.right(wanted_rotation), goal_direction)
		move.y = Vector3.dot(Quaternion.forward(wanted_rotation), goal_direction)
	end

	return 
end
PlayerBotInput.lerp_toward_zero = function (self, value)
	value = math.lerp(value, 0, 0.1)
	value = math.clamp(value, -1, 1)

	if value < 0.1 and -0.1 < value then
		value = 0
	end

	return value
end
PlayerBotInput.get = function (self, input_key)
	if input_key == "look" then
		return Vector3(self.look.x, self.look.y, 0)
	elseif input_key == "move" then
		return Vector3(self.move.x, self.move.y, 0)
	elseif self._input[input_key] ~= nil then
		return self._input[input_key]
	end

	return 
end
PlayerBotInput.set_enabled = function (self, enabled)
	return 
end
PlayerBotInput.get_buffer = function (self, input_key)
	return 
end
PlayerBotInput.add_buffer = function (self, input_key)
	return 
end
PlayerBotInput.reset_input_buffer = function (self, input_key)
	return 
end
PlayerBotInput.clear_input_buffer = function (self, input_key)
	return 
end
PlayerBotInput.reset_wield_switch_buffer = function (self)
	return 
end
PlayerBotInput.move = function (self, vector)
	self.move.x = vector.x
	self.move.y = vector.y

	return 
end
PlayerBotInput.look = function (self, vector)
	self.look.x = vector.x
	self.look.y = vector.y

	return 
end
PlayerBotInput.move_forward = function (self)
	self.move.x = 0
	self.move.y = 1

	return 
end
PlayerBotInput.rotate_right = function (self)
	self.look.x = 0.1
	self.look.y = 0

	return 
end
PlayerBotInput.not_moving = function (self)
	return self.move.x == 0 and self.move.y == 0
end
PlayerBotInput.move_towards = function (self, target_position)
	self.target_position = (target_position and Vector3Box(target_position)) or nil

	return 
end
PlayerBotInput.get_wield_cooldown = function (self)
	return false
end
PlayerBotInput.add_wield_cooldown = function (self, cooldown_time)
	return 
end
PlayerBotInput.released_input = function (self, input)
	return true
end
PlayerBotInput.add_stun_buffer = function (self, input_key)
	return 
end
PlayerBotInput.reset_release_input = function (self)
	return true
end

return 