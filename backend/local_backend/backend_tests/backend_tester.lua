BackendTester = class(BackendTester)
BackendTester.init = function (self)
	self._state = "done"

	return 
end
BackendTester.start = function (self, max_iterations, sleep_duration)
	self._setup(self)

	self._state = "do"
	self._max_iterations = max_iterations or 1
	self._num_iterations = 0
	self._errors = {}
	self._sleep_duration = sleep_duration or 0
	self._start_time = os.time()
	local update = callback(self, "update")

	Managers.debug_updator:remove_updator_by_name(self._name)
	Managers.debug_updator:add_updator(update, self._name)
	print(string.format("Base time %ss", self._duration(self, sleep_duration * max_iterations)))

	return 
end
BackendTester.stop = function (self)
	self._state = "done"

	Managers.debug_updator:remove_updator_by_name(self._name)
	print("Done with " .. self._name)

	if next(self._errors) then
		print("")

		for _, value in pairs(self._errors) do
			print(value)
		end
	end

	return 
end
BackendTester._duration = function (self, seconds)
	return string.format("%d", seconds)
end
BackendTester._progress_bar = function (self, percent_done)
	local length = 50
	local bar = "["
	local char = "*"

	for ii = 0, length, 1 do
		local percent = ii / length

		if percent_done <= percent then
			if char == "*" then
				char = "|"
			elseif char == "|" then
				char = "-"
			end
		end

		bar = bar .. char
	end

	bar = bar .. "]"

	return bar
end
BackendTester._time_left = function (self, percent)
	local time_spent = os.time() - self._start_time

	return time_spent / percent * (1 - percent)
end
BackendTester.update = function (self, dt)
	local rarity = self._rarity

	if self._state == "do" then
		self._execute(self)

		self._state = "poll"
	elseif self._state == "poll" then
		local result = self.poll_answer(self)

		if result then
			local num_iter = self._num_iterations
			local max_iter = self._max_iterations
			local percent = (num_iter + 1) / max_iter
			local time_left = self._time_left(self, percent)
			local bar = self._progress_bar(self, percent)
			local progress = string.format("Iteration %d/%d %.1f%% %s %ds left", num_iter + 1, max_iter, (num_iter + 1) / max_iter * 100, bar, time_left)

			print(progress)

			self._num_iterations = num_iter + 1

			if max_iter <= self._num_iterations then
				self.stop(self)
			else
				self._state = "sleep"
				self._sleep_end = os.time() + self._sleep_duration
			end
		end
	elseif self._state == "sleep" and self._sleep_end < os.time() then
		self._state = "do"
		self._sleep_end = nil
	end

	return 
end
BackendTester._report_error = function (self, ...)
	local formatted = string.format(...)

	Application.error(formatted)
	table.insert(self._errors, formatted)

	return 
end

return 
