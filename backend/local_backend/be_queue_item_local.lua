BEQueueItemLocal = class(BEQueueItemLocal)

BEQueueItemLocal.init = function (self, parameters, items)
	self._complete_time = Application.time_since_launch() + Math.random() * 1
	self._parameters = parameters
	self._items = items
end

BEQueueItemLocal.items = function (self)
	fassert(self._is_done, "Request hasn't completed yet")

	return self._items
end

BEQueueItemLocal.parameters = function (self)
	fassert(self._is_done, "Request hasn't completed yet")

	return self._parameters
end

BEQueueItemLocal.error_message = function (self)
	fassert(self._is_done, "Request hasn't completed yet")

	return self._error_message
end

BEQueueItemLocal.is_done = function (self)
	local t = Application.time_since_launch()

	if t < self._complete_time then
		self._is_done = true
	end

	return self._is_done
end

return
