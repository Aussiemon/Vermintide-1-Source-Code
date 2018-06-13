NoTargetZoneExtension = class(NoTargetZoneExtension)

NoTargetZoneExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._world = extension_init_context.world
	self._unit = unit
	self._is_server = Managers.state.network.is_server
	self._was_inside = {}
	local distance = Unit.get_data(self._unit, "no_target_zone_data", "distance") or 10
	self._distance_sq = distance * distance
	self._current_index = 0
end

NoTargetZoneExtension.update = function (self, unit, input, dt, context, t)
	if not self._is_server then
		return
	end

	local evaluate_players = false
	local zone_pos = Unit.world_position(self._unit, 0)
	local num_players = #PLAYER_AND_BOT_UNITS

	for i = 1, num_players, 1 do
		local unit = PLAYER_AND_BOT_UNITS[i]
		local unit_pos = POSITION_LOOKUP[unit]
		local distance_sq = Vector3.distance_squared(unit_pos, zone_pos)

		if distance_sq < self._distance_sq then
			evaluate_players = true

			break
		end
	end

	if evaluate_players then
		self:_evaluate_players()
	elseif self._cleanup_needed then
		self:_cleanup_data()
	end
end

NoTargetZoneExtension._evaluate_players = function (self)
	local num_players = #PLAYER_AND_BOT_UNITS
	local pose, extents = Unit.box(self._unit)
	self._current_index = 1 + self._current_index % num_players
	local unit = PLAYER_AND_BOT_UNITS[self._current_index]

	if unit then
		local unit_pos = POSITION_LOOKUP[unit]
		local is_inside = math.point_is_inside_oobb(unit_pos, pose, extents)
		local status_ext = ScriptUnit.extension(unit, "status_system")

		if is_inside and not status_ext.forbidden_target then
			status_ext.forbidden_target = true
			self._was_inside[unit] = true
		elseif not is_inside and self._was_inside[unit] then
			status_ext.forbidden_target = false
			self._was_inside[unit] = nil
		end
	else
		self._current_index = 0
	end

	self._cleanup_needed = true
end

NoTargetZoneExtension._cleanup_data = function (self)
	local num_players = #PLAYER_AND_BOT_UNITS

	for i = 1, num_players, 1 do
		local unit = PLAYER_AND_BOT_UNITS[i]
		local status_ext = ScriptUnit.extension(unit, "status_system")
		status_ext.forbidden_target = false
	end

	self._was_inside = {}
	self._cleanup_needed = false
end

return
