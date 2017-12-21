AiHeroicEnemyExtension = class(AiHeroicEnemyExtension)
AiHeroicEnemyExtension.init = function (self, context, unit, extension_init_data)
	self._unit = unit
	local archetype_index = extension_init_data and extension_init_data.archetype_index

	if archetype_index then
		self._archetype_index = archetype_index
		local archetype = extension_init_data.breed.heroic_archetypes[archetype_index]
		local archetype_name = archetype.name
		self._archetype_name = archetype_name
		self._archetype = archetype

		self[archetype_name](self, unit, archetype)
	else
		self._archetype_index = 0
	end

	self._is_server = Managers.player.is_server

	return 
end
AiHeroicEnemyExtension.extensions_ready = function (self)
	local archetype = self._archetype

	if archetype and self._is_server then
		local blackboard = Unit.get_data(self._unit, "blackboard")

		table.merge_recursive(blackboard, archetype.blackboard)
	end

	return 
end
AiHeroicEnemyExtension.archetype_index = function (self)
	return self._archetype_index
end
AiHeroicEnemyExtension.archetype_name = function (self)
	return self._archetype_name
end
AiHeroicEnemyExtension.archetype_data = function (self)
	return self._archetype
end
AiHeroicEnemyExtension.destroy = function (self, unit)
	local archetype_name = self._archetype_name

	if archetype_name then
		self[archetype_name .. "_destroyed"](self, unit)
	end

	return 
end
AiHeroicEnemyExtension.decoy = function (self, unit)
	if Managers.player.is_server then
		self._num_decoys = 3
		self._decoys = {}

		self._spawn_decoys(self, unit)
	end

	return 
end
AiHeroicEnemyExtension._spawn_decoys = function (self, unit)
	local breed = Breeds[self._archetype.breed_name]

	for i = 1, self._num_decoys, 1 do
		local unit = Managers.state.conflict:spawn_unit(breed, Unit.local_position(unit, 0), Quaternion(Vector3.up(), 0), "specials_pacing", nil, nil, nil, nil, nil)
		self._decoys[i] = unit
	end

	return 
end
AiHeroicEnemyExtension._kill_decoys = function (self, unit)
	for i = 1, self._num_decoys, 1 do
		local decoy_unit = self._decoys[i]

		if AiUtils.unit_alive(decoy_unit) then
			AiUtils.kill_unit(decoy_unit, unit)
		end
	end

	return 
end
AiHeroicEnemyExtension.respawn_decoys = function (self)
	local unit = self._unit

	self._kill_decoys(self, unit)
	self._spawn_decoys(self, unit)

	return 
end
AiHeroicEnemyExtension.decoy_destroyed = function (self, unit)
	if Managers.player.is_server then
		self._kill_decoys(self, unit)
	end

	return 
end
AiHeroicEnemyExtension.smoke = function (self, unit)
	return 
end
AiHeroicEnemyExtension.smoke_destroyed = function (self, unit)
	return 
end
AiHeroicEnemyExtension.poison = function (self, unit)
	return 
end
AiHeroicEnemyExtension.poison_destroyed = function (self, unit)
	return 
end
AiHeroicEnemyExtension.bomb = function (self, unit)
	return 
end
AiHeroicEnemyExtension.bomb_destroyed = function (self, unit)
	return 
end

return 
