require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTPanicAction = class(BTPanicAction, BTNode)

BTPanicAction.init = function (self, ...)
	BTPanicAction.super.init(self, ...)
end

BTPanicAction.name = "BTPanicAction"

BTPanicAction.enter = function (self, unit, blackboard, t)
	self.length_weight = 5
	blackboard.is_panicking = true
	blackboard.panic = blackboard.panic or {}
	blackboard.panic.panic_timer = 2
	local escape_direction = self:get_shortest_panic_zone_escape_direction(unit, blackboard)

	if blackboard.panic.escape_direction == nil then
		blackboard.panic.escape_direction = Vector3Box(escape_direction)
	else
		blackboard.panic.escape_direction:store(escape_direction)
	end

	if blackboard.panic.escape_position == nil then
		blackboard.panic.escape_position = Vector3Box(0, 0, 0)
	end

	self:set_new_escape_position(unit, blackboard)

	local ai_navigation = blackboard.navigation_extension

	ai_navigation:set_max_speed(blackboard.breed.run_speed)
	Managers.state.network:anim_event(unit, "move_fwd")

	local dialogue_input = ScriptUnit.extension_input(unit, "dialogue_system")
	local event_data = FrameTable.alloc_table()

	dialogue_input:trigger_networked_dialogue_event("panic", event_data)
end

BTPanicAction.leave = function (self, unit, blackboard, t)
	local category_name = "panic"

	Managers.state.debug_text:clear_unit_text(unit, category_name)

	blackboard.is_panicking = false
	local current_position = POSITION_LOOKUP[unit]
	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local ai_navigation = blackboard.navigation_extension

	ai_navigation:set_max_speed(default_move_speed)
	ai_navigation:move_to(current_position)

	if Network.game_session() then
		Managers.state.network:anim_event(unit, "idle")
	end

	local locomotion = blackboard.locomotion_extension
	local current_rotation = Unit.local_rotation(unit, 0)

	locomotion:set_wanted_rotation(Quaternion.conjugate(current_rotation))
end

BTPanicAction.run = function (self, unit, blackboard, t, dt)
	local category_name = "panic"

	Managers.state.debug_text:clear_unit_text(unit, category_name)

	if blackboard.panic.panic_timer > 0 then
		blackboard.panic.panic_timer = blackboard.panic.panic_timer - dt

		if script_data.ai_debug_panic_zones then
			local head_node = Unit.node(unit, "c_head")
			local viewport_name = "player_1"
			local color_vector = Vector3(255, 25, 25)
			local offset_vector = Vector3(0, 0, 1)
			local text_size = 0.5
			local debug_start_string = "Panic left " .. math.floor(blackboard.panic.panic_timer + 0.5) .. "s."

			Managers.state.debug_text:output_unit_text(debug_start_string, text_size, unit, head_node, offset_vector, nil, category_name, color_vector, viewport_name)
		end

		local destination_distance = blackboard.destination_dist

		if destination_distance < 0.25 then
			self:set_new_escape_position(unit, blackboard)
		end

		local escape_position = blackboard.panic.escape_position:unbox()
		local ai_navigation = blackboard.navigation_extension

		ai_navigation:move_to(escape_position)

		return "running"
	else
		return "done"
	end
end

BTPanicAction.set_new_escape_position = function (self, unit, blackboard)
	local current_position = POSITION_LOOKUP[unit]
	local escape_direction = blackboard.panic.escape_direction:unbox()
	local new_escape_position = current_position + self.length_weight * escape_direction
	local nav_world = blackboard.nav_world
	local success, altitude = GwNavQueries.triangle_from_position(nav_world, new_escape_position, 30, 30)

	if success then
		new_escape_position.z = altitude

		blackboard.panic.escape_position:store(new_escape_position)
	elseif not self:find_new_escape_direction(unit, blackboard) then
		local damage_type = "forced"
		local damage_direction = Vector3(0, 0, -1)

		AiUtils.kill_unit(unit, nil, nil, damage_type, damage_direction)
		print("BTPanicAction: Could not find new escape direction! Killing unit!")
	end
end

local DEGREES_TO_ROTATE = 5
local RADIANS_TO_ROTATE = math.degrees_to_radians(DEGREES_TO_ROTATE)

BTPanicAction.find_new_escape_direction = function (self, unit, blackboard)
	local current_rotation = RADIANS_TO_ROTATE

	while current_rotation < math.pi do
		if self:_try_rotated_escape_direction(unit, current_rotation, blackboard) or self:_try_rotated_escape_direction(unit, -current_rotation, blackboard) then
			return true
		end

		current_rotation = current_rotation + RADIANS_TO_ROTATE
	end

	return false
end

BTPanicAction._try_rotated_escape_direction = function (self, unit, radians_to_rotate, blackboard)
	local current_position = POSITION_LOOKUP[unit]
	local escape_direction = blackboard.panic.escape_direction:unbox()
	local rotation_quaternion = Quaternion(Vector3.up(), radians_to_rotate)
	local new_escape_direction = Quaternion.rotate(rotation_quaternion, escape_direction)
	local test_escape_position = current_position + self.length_weight * new_escape_direction
	local nav_world = blackboard.nav_world
	local success, altitude = GwNavQueries.triangle_from_position(nav_world, test_escape_position, 30, 30)

	if success then
		test_escape_position.z = altitude

		blackboard.panic.escape_direction:store(new_escape_direction)
		blackboard.panic.escape_position:store(test_escape_position)

		return true
	else
		return false
	end
end

BTPanicAction.get_shortest_panic_zone_escape_direction = function (self, unit, blackboard)
	local panic_zone = blackboard.panic_zone
	local position = POSITION_LOOKUP[unit]
	local panic_zone_position = panic_zone.position:unbox()
	local zone_to_position = position - panic_zone_position
	local escape_direction = Vector3.normalize(zone_to_position)

	return escape_direction
end

return
