LevelEffectsVolume = class(LevelEffectsVolume)

LevelEffectsVolume.init = function (self, world, parent, volume_name, prio, particles_action, screen_particles_action)
	self._world = world
	self._parent = parent
	self._volume_name = volume_name
	self._prio = prio
	self._particles_action = particles_action
	self._screen_particles_action = screen_particles_action
	self._level = LevelHelper:current_level(self._world)
	local level_settings = LevelHelper:current_level_settings()
	self._level_particles = level_settings.level_particle_effects or {}
	self._level_screen_partiles = level_settings.level_screen_effects or {}
	self._viewport_name = "player_1"
	self._is_inside = false

	fassert(Level.has_volume(self._level, self._volume_name), "[LevelEffectsVolume] No volume named %q exists in current level", self._volume_name)
end

LevelEffectsVolume.is_inside = function (self)
	return self._is_inside
end

LevelEffectsVolume.update = function (self, position)
	local was_inside = self._is_inside
	self._is_inside = Level.is_point_inside_volume(self._level, self._volume_name, position)

	return self._is_inside and not was_inside
end

LevelEffectsVolume.on_enter = function (self)
	if self._particles_action ~= "none" then
		local action_name = self._particles_action .. "_level_particles"

		self._parent[action_name](self._parent, self._level_particles, self._viewport_name)
	end

	if self._particles_action ~= "none" then
		local action_name = self._screen_particles_action .. "_level_screen_particles"

		self._parent[action_name](self._parent, self._level_screen_partiles, self._viewport_name)
	end
end

LevelEffectsVolume.on_exit = function (self)
	if self._particles_action ~= "none" then
		self._parent:reset_level_particles(self._level_particles, self._viewport_name)
	end

	if self._particles_action ~= "none" then
		self._parent:reset_level_screen_particles(self._level_screen_partiles, self._viewport_name)
	end

	self._is_inside = false
end

LevelEffectsVolume.volume_name = function (self)
	return self._volume_name
end

LevelEffectsVolume.prio = function (self)
	return self._prio
end

LevelEffectsVolume.destroy = function (self)
	if self._is_inside then
		self:on_exit()
	end
end

return
