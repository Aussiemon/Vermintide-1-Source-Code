require("foundation/scripts/managers/time/timer")

TimeManager = class(TimeManager)
TimeManager.init = function (self)
	self._timers = {
		main = Timer:new("main", nil)
	}
	self._dt_stack = {}
	self._dt_stack_max_size = 10
	self._dt_stack_index = 0
	self._mean_dt = 0

	return 
end
TimeManager.register_timer = function (self, name, parent_name, start_time)
	local timers = self._timers

	fassert(timers[name] == nil, "[TimeManager] Tried to add already registered timer %q", name)
	fassert(timers[parent_name], "[TimeManager] Not allowed to add timer with unregistered parent %q", parent_name)

	local parent_timer = timers[parent_name]
	local new_timer = Timer:new(name, parent_timer, start_time)

	parent_timer.add_child(parent_timer, new_timer)

	timers[name] = new_timer

	return 
end
TimeManager.unregister_timer = function (self, name)
	local timer = self._timers[name]

	fassert(timer, "[TimeManager] Tried to remove unregistered timer %q", name)
	fassert(table.size(timer.children(timer)) == 0, "[TimeManager] Not allowed to remove timer %q with children", name)

	local parent = timer.parent(timer)

	if parent then
		parent.remove_child(parent, timer)
	end

	timer.destroy(timer)

	self._timers[name] = nil

	return 
end
TimeManager.has_timer = function (self, name)
	return (self._timers[name] and true) or false
end
TimeManager.update = function (self, dt)
	local main_timer = self._timers.main

	if main_timer.active(main_timer) then
		main_timer.update(main_timer, dt, 1)
	end

	self._update_mean_dt(self, dt)

	return 
end
TimeManager._update_mean_dt = function (self, dt)
	local dt_stack = self._dt_stack
	self._dt_stack_index = self._dt_stack_index % self._dt_stack_max_size + 1
	dt_stack[self._dt_stack_index] = dt
	local dt_sum = 0

	for i, dt in ipairs(dt_stack) do
		dt_sum = dt_sum + dt
	end

	self._mean_dt = dt_sum / #dt_stack

	return 
end
TimeManager.mean_dt = function (self)
	return self._mean_dt
end
TimeManager.set_time = function (self, name, time)
	self._timers[name]:set_time(time)

	return 
end
TimeManager.time = function (self, name)
	if self._timers[name] then
		return self._timers[name]:time()
	end

	return 
end
TimeManager.active = function (self, name)
	return self._timers[name]:active()
end
TimeManager.set_active = function (self, name, active)
	self._timers[name]:set_active(active)

	return 
end
TimeManager.set_local_scale = function (self, name, scale)
	fassert(name ~= "main", "[TimeManager] Not allowed to set scale in main timer")
	self._timers[name]:set_local_scale(scale)

	return 
end
TimeManager.local_scale = function (self, name)
	return self._timers[name]:local_scale()
end
TimeManager.global_scale = function (self, name)
	return self._timers[name]:global_scale()
end
TimeManager.destroy = function (self)
	for name, timer in pairs(self._timers) do
		timer.destroy(timer)
	end

	self._timers = nil

	return 
end

return 
