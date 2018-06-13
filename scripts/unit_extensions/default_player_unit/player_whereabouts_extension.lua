require("scripts/unit_extensions/generic/generic_state_machine")

PlayerWhereaboutsExtension = class(PlayerWhereaboutsExtension)
local position_lookup = POSITION_LOOKUP

PlayerWhereaboutsExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.nav_world = Managers.state.entity:system("ai_system"):nav_world()
	self.player = extension_init_data.player
	self.closest_positions = {}
	self.last_pos_on_nav_mesh = Vector3Box(position_lookup[unit])

	self:setup(self.nav_world, unit)

	self._last_onground_pos_on_nav_mesh = Vector3Box(Vector3.invalid_vector())
	self._jumping = false
	self._falling = false
	self._nav_traverse_logic = Managers.state.bot_nav_transition:traverse_logic()
	self._jump_position = Vector3Box(Vector3.invalid_vector())
	self._fall_position = Vector3Box(Vector3.invalid_vector())
	self._free_fall_position = Vector3Box(Vector3.invalid_vector())
end

PlayerWhereaboutsExtension.setup = function (self, nav_world, unit)
	local pos = position_lookup[unit]
	local success = GwNavQueries.triangle_from_position(self.nav_world, pos)

	self.last_pos_on_nav_mesh:store(pos)

	local height = 1.6
	local radius = 0.38
	local speed = 6
	local pos = position_lookup[self.unit]
	self._input = {}
end

PlayerWhereaboutsExtension.destroy = function (self)
	return
end

PlayerWhereaboutsExtension.reset = function (self)
	return
end

PlayerWhereaboutsExtension.set_is_onground = function (self)
	self._input.is_onground = true
end

PlayerWhereaboutsExtension.set_fell = function (self)
	self._input.fell = true
end

PlayerWhereaboutsExtension.set_jumped = function (self)
	self._input.jumped = true
end

PlayerWhereaboutsExtension.set_landed = function (self)
	self._input.landed = true
end

PlayerWhereaboutsExtension.set_no_landing = function (self)
	self._input.no_landing = true
end

PlayerWhereaboutsExtension.update = function (self, unit, input, dt, context, t)
	local pos = position_lookup[unit]
	local input = self._input

	self:_get_closest_positions(pos, input.is_onground, self.closest_positions, self.closest_distances)

	if script_data.debug_ai_movement then
		self:_debug_draw(self.closest_positions)
	end

	self:_check_bot_nav_transition(self.nav_world, input, pos)
	table.clear(input)
end

local EPSILON = 0.0001

PlayerWhereaboutsExtension.last_position_onground_on_navmesh = function (self)
	local pos = self._last_onground_pos_on_nav_mesh:unbox()

	return (Vector3.is_valid(pos) and pos) or nil
end

PlayerWhereaboutsExtension._find_start_position = function (self, current_position)
	local last_pos = self._last_onground_pos_on_nav_mesh:unbox()

	if Vector3.is_valid(last_pos) then
		local offset = current_position - last_pos

		if EPSILON < Vector3.length_squared(offset) then
			local new_last_pos = GwNavQueries.move_on_navmesh(self.nav_world, last_pos, offset, 1, self._nav_traverse_logic)

			if Vector3.distance(current_position, new_last_pos) < 2 then
				return new_last_pos
			end
		else
			return last_pos
		end
	end
end

PlayerWhereaboutsExtension._check_bot_nav_transition = function (self, nav_world, input, current_position)
	if input.jumped then
		fassert(not self._falling and not self._jumping, "Tried to jump or fall while falling without aborting landing")

		self._jumping = true
		local pos = self:_find_start_position(current_position)

		if pos then
			self._jump_position:store(pos)
			self._free_fall_position:store(current_position)
		end
	elseif input.fell then
		fassert(not self._jumping and not self._falling, "Tried to fall or jump while jumping without aborting landing")

		self._falling = true
		local pos = self:_find_start_position(current_position)

		if pos then
			self._fall_position:store(pos)
			self._free_fall_position:store(current_position)
		end
	elseif input.no_landing then
		fassert(self._jumping or self._falling, "Tried to not land without falling or jumping")

		self._jumping = false
		self._falling = false
		local invalid_vector = Vector3.invalid_vector()

		self._jump_position:store(invalid_vector)
		self._fall_position:store(invalid_vector)
		self._free_fall_position:store(invalid_vector)
	elseif input.landed then
		fassert(self._jumping or self._falling, "Tried to land without falling or jumping")

		if self._jumping then
			local jump_pos = self._jump_position:unbox()

			if Vector3.is_valid(jump_pos) then
				Managers.state.bot_nav_transition:create_transition(jump_pos, self._free_fall_position:unbox(), current_position, true)
			end

			local invalid_vector = Vector3.invalid_vector()

			self._jump_position:store(invalid_vector)
			self._free_fall_position:store(invalid_vector)

			self._jumping = false
		elseif self._falling then
			local fall_pos = self._fall_position:unbox()

			if Vector3.is_valid(fall_pos) then
				Managers.state.bot_nav_transition:create_transition(fall_pos, self._free_fall_position:unbox(), current_position, false)
			end

			local invalid_vector = Vector3.invalid_vector()

			self._fall_position:store(invalid_vector)
			self._free_fall_position:store(invalid_vector)

			self._falling = false
		end
	end
end

PlayerWhereaboutsExtension._get_closest_positions = function (self, pos, is_onground, point_list)
	self.player_on_nav_mesh = GwNavQueries.triangle_from_position(self.nav_world, pos, 0.2, 0.3, self._nav_traverse_logic)

	if self.player_on_nav_mesh then
		self.last_pos_on_nav_mesh:store(pos)

		if is_onground then
			self._last_onground_pos_on_nav_mesh:store(pos)
		end

		return
	end

	local p = GwNavQueries.inside_position_from_outside_position(self.nav_world, pos, 3, 3, 2.1, 0.5)

	if p then
		point_list[1] = Vector3Box(p)

		for i = 2, #point_list, 1 do
			point_list[i] = nil
		end

		return
	end

	local p = GwNavQueries.inside_position_from_outside_position(self.nav_world, pos, 5, 5, 10, 0.5)

	if p then
		point_list[1] = Vector3Box(p)

		for i = 2, #point_list, 1 do
			point_list[i] = nil
		end

		return
	end

	local list_size = #point_list

	for i = 1, list_size, 1 do
		point_list[i] = nil
	end

	LocomotionUtils.closest_mesh_positions_outward(self.nav_world, pos, 10, point_list)
end

PlayerWhereaboutsExtension.closest_positions_when_outside_navmesh = function (self)
	return self.closest_positions, self.player_on_nav_mesh
end

PlayerWhereaboutsExtension._debug_draw = function (self, point_list)
	for i = 1, #point_list, 1 do
		local pos = point_list[i]:unbox()

		QuickDrawer:sphere(pos + Vector3(0, 0, 0.25), 0.77, Color(255, 144, 23, 67))
	end
end

return
