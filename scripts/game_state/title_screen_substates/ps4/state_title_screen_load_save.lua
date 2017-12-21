StateTitleScreenLoadSave = class(StateTitleScreenLoadSave)
StateTitleScreenLoadSave.NAME = "StateTitleScreenLoadSave"
StateTitleScreenLoadSave.on_enter = function (self, params)
	print("[Gamestate] Enter Substate StateTitleScreenLoadSave")

	self._params = params
	self._world = self._params.world
	self._viewport = self._params.viewport
	self._gui = self._params.gui
	self._information_view = InformationView:new(self._world)
	self._state = "load_save"

	self._load_save(self)
	Managers.transition:show_loading_icon(false)

	return 
end
StateTitleScreenLoadSave.update = function (self, dt, t)
	if self._state == "signin_to_backend" then
		self._signin(self)
		self._information_view:set_information_text("Signing in...")
	end

	self._information_view:update(dt, t)

	return self._new_state
end
StateTitleScreenLoadSave._load_save = function (self)
	self._information_view:set_information_text("Loading Save Data")
	Managers.save:auto_load(SaveFileName, callback(self, "cb_load_done"))

	self._state = "waiting_for_load"

	return 
end
StateTitleScreenLoadSave._signin = function (self)
	require("scripts/managers/backend/backend_manager")

	Managers.unlock = UnlockManager:new()
	Managers.backend = BackendManager:new()

	Managers.backend:signin()

	self._state = "none"
	self._new_state = StateTitleScreenMainMenu

	return 
end
StateTitleScreenLoadSave.cb_load_done = function (self, result)
	if result.error then
		printf("[StateTitleScreenLoadSave] Error when loading save data: %q", result.error)

		self._state = "signin_to_backend"
	else
		print("[StateTitleScreenLoadSave] Save data loaded")
		populate_save_data(result.data)

		self._state = "signin_to_backend"
	end

	return 
end
StateTitleScreenLoadSave.on_exit = function (self)
	self._information_view:destroy()

	return 
end

return 
