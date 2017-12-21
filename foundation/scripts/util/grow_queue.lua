GrowQueue = class(GrowQueue)
GrowQueue.init = function (self)
	self.queue = {}
	self.first = 1
	self.last = 0

	return 
end
GrowQueue.push_back = function (self, item)
	self.last = self.last + 1
	self.queue[self.last] = item

	return 
end
GrowQueue.pop_first = function (self, item)
	if self.last < self.first then
		return 
	end

	local item = self.queue[self.first]
	self.queue[self.first] = nil

	if self.first == self.last then
		self.first = 0
		self.last = 0
	end

	self.first = self.first + 1

	return item
end
GrowQueue.print_items = function (self, s)
	local s = (s or "") .. " queue: [" .. self.first .. "->" .. self.last .. "] --> "

	for i = self.first, self.last, 1 do
		s = s .. tostring(self.queue[i]) .. ","
	end

	print(s)

	return 
end

return 
