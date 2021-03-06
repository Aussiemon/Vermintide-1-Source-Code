require("scripts/managers/conflict_director/conflict_director")

EasterShark = class(EasterShark)
local TIMEOUT_WINDOW = 1

EasterShark.init = function (self, world)
	self._combo = {
		"w",
		"w",
		"s",
		"s",
		"a",
		"d",
		"a",
		"d"
	}
	self._index = 0
	self.world = world
	self._fatshark = nil
	self._player_units = nil
	self._timeout = 0
end

EasterShark.check_combo = function (self, button_index)
	local button = Keyboard.button_name(button_index)

	if button ~= self._combo[self._index] then
		return false
	end

	return true
end

EasterShark.update = function (self, dt, t)
	Profiler.start("EasterShark")

	local conflict_director = Managers.state.conflict
	local button_index = Keyboard.any_pressed()
	local correct = false
	self._player_units = conflict_director._player_units

	if button_index and self._fatshark == nil then
		self._timeout = t + TIMEOUT_WINDOW
		self._index = self._index + 1
		correct = self:check_combo(button_index)

		if not correct then
			self._index = 0
		elseif self._index == #self._combo then
			self._fatshark = self:spawn_shark()
			self._index = 0
		end
	end

	if self._timeout <= t then
		self._index = 0
	end

	self:update_unit(dt)
	Profiler.stop("EasterShark")
end

EasterShark.update_unit = function (self, dt)
	local shark = self._fatshark

	if shark == nil then
		return
	end

	local player = self._player_units[1]
	local player_position = POSITION_LOOKUP[player]
	local shark_position = Unit.local_position(shark, 0)
	local shark_rotation = Vector3.normalize(player_position - shark_position)
	local rot = shark_rotation
	shark_position = shark_position + 14 * dt * (shark_rotation + Vector3(0, 0, 0.15))
	shark_rotation = Quaternion.look(-shark_rotation)

	Unit.set_local_position(shark, 0, shark_position)
	Unit.set_local_rotation(shark, 0, shark_rotation)

	if Vector3.distance(shark_position, player_position) <= 3 and not self._clouds_spawned then
		self._clouds_spawned = true

		World.create_particles(self.world, "fx/easter_shark", shark_position + 1.8 * rot + Vector3(0, 0, 1.2))
	end

	if Vector3.distance(shark_position, player_position) <= 2.6 then
		self:despawn_shark(shark, shark_position)
	end
end

EasterShark.spawn_shark = function (self)
	local player = self._player_units[1]

	print(player)

	local first_person_extension = ScriptUnit.extension(player, "first_person_system")
	local first_person_unit = first_person_extension:get_first_person_unit()
	local player_position = POSITION_LOOKUP[first_person_unit]
	local player_rotation = Quaternion.forward(Unit.local_rotation(first_person_unit, 0))
	player_rotation.z = -0.09
	local rotation = Quaternion.look(player_rotation)
	local position = player_position + 20 * player_rotation
	local shark = World.spawn_unit(self.world, "units/trophies/fatshark/fatshark", position, rotation)
	self._clouds_spawned = false

	return shark
end

EasterShark.despawn_shark = function (self, shark, shark_position)
	World.destroy_unit(self.world, shark)

	self._fatshark = nil
end

return
