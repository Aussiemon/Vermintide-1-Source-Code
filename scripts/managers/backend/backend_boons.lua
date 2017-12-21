BackendBoons = class(BackendBoons)
BackendBoons.init = function (self)
	self._boons = {}
	self._dirty = false

	return 
end
BackendBoons.update = function (self)
	return 
end
BackendBoons.set_boons = function (self, boons)
	table.clear_array(self._boons, #self._boons)

	local current_time = os.time()

	for _, boon in pairs(boons) do
		boon.starting_time = current_time
		boon.remaining_duration = boon.ttl
		self._boons[#self._boons + 1] = boon
	end

	self._dirty = true

	return 
end
BackendBoons.add_boons = function (self, boons)
	local current_time = os.time()

	for _, boon in pairs(boons) do
		boon.starting_time = current_time
		boon.remaining_duration = boon.ttl
		self._boons[#self._boons + 1] = boon
	end

	self._dirty = true

	return 
end
BackendBoons.is_dirty = function (self)
	local dirty = self._dirty
	self._dirty = false

	return dirty
end
BackendBoons.get_boons = function (self)
	local current_time = os.time()

	for ii, boon in ipairs(self._boons) do
		local starting_time = boon.starting_time
		local expired = current_time - starting_time
		local remaining_duration = boon.ttl - expired

		if 0 < remaining_duration then
			boon.remaining_duration = remaining_duration
		else
			table.remove(self._boons, ii)
		end
	end

	return self._boons
end
BackendBoons.add_boon_debug = function (self)
	print("add_boon_debug() only works with local backend")

	return 
end
BackendBoons.clear_boons_debug = function (self)
	print("clear_boons_debug() only works with local backend")

	return 
end

return 
