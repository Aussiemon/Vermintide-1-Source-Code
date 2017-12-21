StateMapViewIdle = class(StateMapViewIdle)
StateMapViewIdle.NAME = "StateMapViewIdle"
StateMapViewIdle.on_enter = function (self, params)
	print("[MapViewState] Enter Substate StateMapViewIdle")

	local ingame_ui_context = params.ingame_ui_context
	self.input_manager = ingame_ui_context.input_manager
	self._map_view = params.map_view

	return 
end
StateMapViewIdle.on_exit = function (self, params)
	return 
end
StateMapViewIdle.update = function (self, dt, t)
	return self._wanted_state(self)
end
StateMapViewIdle.post_update = function (self, dt, t)
	return 
end
StateMapViewIdle._wanted_state = function (self)
	local new_state = self.parent:wanted_gamepad_state()

	if new_state then
		self.parent:clear_wanted_gamepad_state()
	end

	return new_state
end

return 
