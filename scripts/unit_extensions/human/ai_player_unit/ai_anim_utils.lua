AiAnimUtils = AiAnimUtils or {}
local POSITION_LOOKUP = POSITION_LOOKUP

AiAnimUtils.get_animation_rotation_scale = function (unit, blackboard, action)
	local unit_pos = POSITION_LOOKUP[unit]
	local target_pos = POSITION_LOOKUP[blackboard.target_unit]
	local forward_dir = Quaternion.forward(Unit.local_rotation(unit, 0), 0)
	local target_dir = Vector3.normalize(target_pos - unit_pos)
	local unit_rot_radians = math.atan2(forward_dir.y, forward_dir.x)
	local target_rot_radians = math.atan2(target_dir.y, target_dir.x)
	local unit_to_target_rot_radians = target_rot_radians - unit_rot_radians
	local move_animation_name = blackboard.move_animation_name
	local rotation_sign = action.start_anims_data[move_animation_name].dir
	unit_to_target_rot_radians = unit_to_target_rot_radians * rotation_sign

	if unit_to_target_rot_radians < 0 then
		unit_to_target_rot_radians = unit_to_target_rot_radians + 2 * math.pi
	end

	local animation_rot_radians = action.start_anims_data[blackboard.move_animation_name].rad
	local rotation_scale = unit_to_target_rot_radians / animation_rot_radians

	return rotation_scale
end

AiAnimUtils.get_start_move_animation = function (unit, blackboard, action)
	local animation_name = nil
	local current_pos = POSITION_LOOKUP[unit]
	local target_pos = POSITION_LOOKUP[blackboard.target_unit]
	local target_vector_flat = Vector3.normalize(Vector3.flat(target_pos - current_pos))
	local rotation = Unit.local_rotation(unit, 0)
	local forward_vector_flat = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
	local dot_product = Vector3.dot(forward_vector_flat, target_vector_flat)
	local inv_sqrt_2 = 0.707

	if dot_product >= inv_sqrt_2 then
		animation_name = action.start_anims_name.fwd
	elseif dot_product > -inv_sqrt_2 then
		local is_to_the_left = Vector3.cross(forward_vector_flat, target_vector_flat).z > 0
		animation_name = (is_to_the_left and action.start_anims_name.left) or action.start_anims_name.right
	else
		animation_name = action.start_anims_name.bwd
	end

	return animation_name
end

AiAnimUtils.set_idle_animation_merge = function (unit, blackboard)
	local breed = blackboard.breed
	local animation_merge_options = breed.animation_merge_options
	local idle_animation_merge_options = animation_merge_options and animation_merge_options.idle_animation_merge_options

	if idle_animation_merge_options then
		Unit.set_animation_merge_options(unit, unpack(idle_animation_merge_options))

		if script_data.animation_merge_debug then
			AiAnimUtils._animation_merge_debug(unit, "idle")
		end
	end
end

AiAnimUtils.set_move_animation_merge = function (unit, blackboard)
	local breed = blackboard.breed
	local animation_merge_options = breed.animation_merge_options
	local move_animation_merge_options = animation_merge_options and animation_merge_options.move_animation_merge_options

	if move_animation_merge_options then
		Unit.set_animation_merge_options(unit, unpack(move_animation_merge_options))

		if script_data.animation_merge_debug then
			AiAnimUtils._animation_merge_debug(unit, "move")
		end
	end
end

AiAnimUtils.set_walk_animation_merge = function (unit, blackboard)
	local breed = blackboard.breed
	local animation_merge_options = breed.animation_merge_options
	local walk_animation_merge_options = animation_merge_options and animation_merge_options.walk_animation_merge_options

	if walk_animation_merge_options then
		Unit.set_animation_merge_options(unit, unpack(walk_animation_merge_options))

		if script_data.animation_merge_debug then
			AiAnimUtils._animation_merge_debug(unit, "walk")
		end
	end
end

AiAnimUtils.set_interest_point_animation_merge = function (unit, blackboard)
	local breed = blackboard.breed
	local animation_merge_options = breed.animation_merge_options
	local interest_point_animation_merge_options = animation_merge_options and animation_merge_options.interest_point_animation_merge_options

	if interest_point_animation_merge_options then
		Unit.set_animation_merge_options(unit, unpack(interest_point_animation_merge_options))

		if script_data.animation_merge_debug then
			AiAnimUtils._animation_merge_debug(unit, "interest_point")
		end
	end
end

AiAnimUtils.reset_animation_merge = function (unit)
	Unit.set_animation_merge_options(unit)

	if script_data.animation_merge_debug then
		AiAnimUtils._animation_merge_debug(unit, nil)
	end
end

AiAnimUtils._animation_merge_debug = function (unit, text)
	local category_name = "animation_merge"

	Managers.state.debug_text:clear_unit_text(unit, category_name)

	if text then
		local head_node = Unit.node(unit, "c_head")
		local viewport_name = "player_1"
		local color_vector = Vector3(25, 255, 25)
		local offset_vector = Vector3(0, 0, 1)
		local text_size = 0.5

		Managers.state.debug_text:output_unit_text(text, text_size, unit, head_node, offset_vector, nil, category_name, color_vector, viewport_name)
	end
end

local VEL_TO_NETWORK_SCALE = 10
local VEL_FROM_NETWORK_SCALE = 0.1

AiAnimUtils.velocity_network_scale = function (velocity, is_sending)
	if is_sending then
		velocity = velocity * VEL_TO_NETWORK_SCALE
		local result = {
			math.round(velocity.x),
			math.round(velocity.y),
			math.round(velocity.z)
		}

		return result
	else
		local result = Vector3(velocity[1] * VEL_FROM_NETWORK_SCALE, velocity[2] * VEL_FROM_NETWORK_SCALE, velocity[3] * VEL_FROM_NETWORK_SCALE)

		return result
	end
end

local POS_TO_NETWORK_SCALE = 100
local POS_FROM_NETWORK_SCALE = 0.01

AiAnimUtils.position_network_scale = function (position, is_sending)
	if is_sending then
		position = position * POS_TO_NETWORK_SCALE
		local result = {
			math.round(position.x),
			math.round(position.y),
			math.round(position.z)
		}

		return result
	else
		local result = Vector3(position[1] * POS_FROM_NETWORK_SCALE, position[2] * POS_FROM_NETWORK_SCALE, position[3] * POS_FROM_NETWORK_SCALE)

		return result
	end
end

local ROT_TO_NETWORK_SCALE = 100
local ROT_FROM_NETWORK_SCALE = 0.01

AiAnimUtils.rotation_network_scale = function (rotation, is_sending)
	if is_sending then
		local x, y, z, w = Quaternion.to_elements(rotation)
		local result = {
			math.round(x * ROT_TO_NETWORK_SCALE),
			math.round(y * ROT_TO_NETWORK_SCALE),
			math.round(z * ROT_TO_NETWORK_SCALE),
			math.round(w * ROT_TO_NETWORK_SCALE)
		}

		return result
	else
		local result = Quaternion.from_elements(rotation[1] * ROT_FROM_NETWORK_SCALE, rotation[2] * ROT_FROM_NETWORK_SCALE, rotation[3] * ROT_FROM_NETWORK_SCALE, rotation[4] * ROT_FROM_NETWORK_SCALE)

		return result
	end
end

AiAnimUtils.cycle_anims = function (blackboard, anims, blackboard_index_name)
	local i = blackboard[blackboard_index_name]
	i = i + 1
	local anim_name = anims[(i - 1) % #anims + 1]
	blackboard[blackboard_index_name] = i

	return anim_name
end

return
