PerformanceManager = class(PerformanceManager)

PerformanceManager.init = function (self, gui, is_server, level_key)
	self._gui = gui
	self._is_server = is_server
	self._tracked_ai_breeds = {
		skaven_storm_vermin_commander = true,
		skaven_storm_vermin = true,
		skaven_clan_rat = true,
		skaven_slave = true
	}
	self._num_ai_spawned = 0
	self._num_ai_active = 0
	self._num_event_ai_spawned = 0
	self._num_event_ai_active = 0
	self._num_ai_string = "SPAWNED: %3i   ACTIVE: %3i   EVENT SPAWNED: %3i   EVENT SPAWNED ACTIVE: %3i"
	self._settings = {
		critical = {
			font = "materials/fonts/gw_arial_32",
			distance_from_top = 60,
			size = 36,
			material = "gw_arial_32",
			color = ColorBox(255, 255, 0, 0),
			color_to = ColorBox(255, 255, 255, 0),
			position = Vector3Box()
		},
		normal = {
			font = "materials/fonts/gw_arial_16",
			distance_from_top = 30,
			size = 26,
			material = "gw_arial_16",
			color = ColorBox(255, 0, 255, 0),
			position = Vector3Box()
		}
	}
	local w, h = Gui.resolution()

	for _, setting in pairs(self._settings) do
		local min, max = Gui.text_extents(gui, self._num_ai_string, setting.font, setting.size, setting.material)
		local x = math.floor(((w + min.x) - max.x) * 0.5)
		local y = h - setting.distance_from_top
		local z = 999

		setting.position:store(x, y, z)
	end

	self._events = {
		ai_unit_activated = "event_ai_unit_activated",
		ai_unit_despawned = "event_ai_unit_despawned",
		ai_units_all_destroyed = "event_ai_units_all_destroyed",
		ai_unit_spawned = "event_ai_unit_spawned"
	}
	local event_manager = Managers.state.event

	for event_name, cb_name in pairs(self._events) do
		event_manager:register(self, event_name, cb_name)
	end

	local level_settings = LevelSettings[level_key]
	local perf = level_settings and level_settings.performance
	self._allowed_active = (perf and perf.allowed_active) or 40
	self._allowed_spawned = (perf and perf.allowed_spawned) or 75
end

PerformanceManager.update = function (self, dt, t)
	if script_data.performance_debug then
		local str = string.format(self._num_ai_string, self._num_ai_spawned, self._num_ai_active, self._num_event_ai_spawned, self._num_event_ai_active)
		local setting = nil

		if self._allowed_active < self._num_ai_active or self._allowed_spawned < self._num_ai_spawned then
			setting = self._settings.critical
		else
			setting = self._settings.normal
		end

		local color = nil

		if setting.color_to then
			local t_val = math.sin((1 - t % 1) * math.pi * 0.5)
			local from = setting.color:unbox()
			local to = setting.color_to:unbox()
			local from_a, from_r, from_g, from_b = Quaternion.to_elements(from)
			local to_a, to_r, to_g, to_b = Quaternion.to_elements(to)
			local a = math.lerp(from_a, to_a, t_val)
			local r = math.lerp(from_r, to_r, t_val)
			local g = math.lerp(from_g, to_g, t_val)
			local b = math.lerp(from_b, to_b, t_val)
			color = Color(a, r, g, b)
		else
			color = setting.color:unbox()
		end

		Gui.text(self._gui, str, setting.font, setting.size, setting.material, setting.position:unbox(), color)
	end
end

PerformanceManager.event_ai_unit_spawned = function (self, breed_name, active, event_spawned)
	if not self._tracked_ai_breeds[breed_name] then
		return
	end

	self._num_ai_spawned = self._num_ai_spawned + 1

	if active then
		self._num_ai_active = self._num_ai_active + 1
	end

	if event_spawned then
		self._num_event_ai_spawned = self._num_event_ai_spawned + 1

		if active then
			self._num_event_ai_active = self._num_event_ai_active + 1
		end
	end
end

PerformanceManager.event_ai_units_all_destroyed = function (self)
	self._num_ai_spawned = 0
	self._num_event_ai_spawned = 0
	self._num_ai_active = 0
	self._num_event_ai_active = 0
end

PerformanceManager.event_ai_unit_activated = function (self, breed_name, event_spawned)
	if not self._tracked_ai_breeds[breed_name] then
		return
	end

	self._num_ai_active = self._num_ai_active + 1

	if event_spawned then
		self._num_event_ai_active = self._num_event_ai_active + 1
	end
end

PerformanceManager.event_ai_unit_despawned = function (self, breed_name, active, event_spawned)
	if not self._tracked_ai_breeds[breed_name] then
		return
	end

	self._num_ai_spawned = self._num_ai_spawned - 1

	if active then
		self._num_ai_active = self._num_ai_active - 1
	end

	if event_spawned then
		self._num_event_ai_spawned = self._num_event_ai_spawned - 1

		if active then
			self._num_event_ai_active = self._num_event_ai_active - 1
		end
	end
end

PerformanceManager.num_active_enemies = function (self)
	return self._num_ai_active
end

PerformanceManager.destroy = function (self)
	local event_manager = Managers.state.event

	for event_name, cb_name in pairs(self._events) do
		event_manager:unregister(event_name, self)
	end
end

return
