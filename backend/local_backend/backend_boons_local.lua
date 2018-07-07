BackendBoonsLocal = class(BackendBoonsLocal)

BackendBoonsLocal.init = function (self)
	self._boons = {}
end

BackendBoonsLocal.set_save = function (self, save_data)
	if save_data then
		save_data.boons = save_data.boons or {}
		self._boons = save_data.boons
		self._dirty = true
	end
end

BackendBoonsLocal.update = function (self)
	local current_time = os.time()
	local boons = self._boons

	for ii, boon in ipairs(boons) do
		local boon_name = boon.name
		local start_time = boon.start_time
		local boon_template = BoonTemplates[boon_name]
		local remaining_duration = boon_template.duration - (current_time - start_time)

		if remaining_duration < 0 then
			table.remove(boons, ii)

			self._dirty = true
		end
	end
end

BackendBoonsLocal.refresh_boons = function (self)
	return
end

BackendBoonsLocal.is_dirty = function (self)
	local dirty = self._dirty
	self._dirty = false

	return dirty
end

BackendBoonsLocal.get_boons = function (self)
	return self._boons
end

BackendBoonsLocal.add_boon_debug = function (self, boon_name)
	local boons = self._boons
	local boon_template = BoonTemplates[boon_name]
	boons[#boons + 1] = {
		name = boon_name,
		start_time = os.time(),
		remaining_duration = boon_template.duration
	}
	self._dirty = true
end

BackendBoonsLocal.clear_boons_debug = function (self)
	table.clear_array(self._boons, #self._boons)

	self._dirty = true
end

return
