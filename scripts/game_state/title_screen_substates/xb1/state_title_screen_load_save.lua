StateTitleScreenLoadSave = class(StateTitleScreenLoadSave)
StateTitleScreenLoadSave.NAME = "StateTitleScreenLoadSave"
StateTitleScreenLoadSave.on_enter = function (self, params)
	print("[Gamestate] Enter Substate StateTitleScreenLoadSave")

	self._params = params
	self._world = self._params.world
	self._viewport = self._params.viewport
	self._gui = self._params.gui

	if not Managers.account:user_id() then
		self._new_state = StateTitleScreenMain
	end

	self._state = "acquire_storage"

	self._setup_view(self)
	Managers.transition:show_loading_icon(false)

	return 
end
StateTitleScreenLoadSave._setup_view = function (self)
	self._information_view = InformationView:new(self._world)

	return 
end
StateTitleScreenLoadSave.update = function (self, dt, t)
	if Managers.account:user_id() then
		if self._state == "acquire_storage" then
			self._get_storage_space(self)
			self._information_view:set_information_text("Acquiring Storage")
		elseif self._state == "query_storage_spaces" then
			self._query_storage_spaces(self)
			self._information_view:set_information_text("Checking Save Data")
		elseif self._state == "load_save" then
			self._load_save(self)
			self._information_view:set_information_text("Loading Data")
		elseif self._state == "create_save" then
			self._create_save(self)
		elseif self._state == "signin_to_backend" then
			self._signin(self)
			self._information_view:set_information_text("Signing in...")
		elseif self._state == "delete_save" then
			self._delete_save(self)
			self._information_view:set_information_text("Deleting Save")
		elseif self._state == "complete" then
			self._new_state = StateTitleScreenMain

			Managers.account:close_storage()
			self._information_view:set_information_text("Returning to Title...")

			self._state = "none"
		end

		self._information_view:update(dt, t)
	end

	if Managers.backend and not Managers.backend:is_disconnected() then
		Managers.backend:update(dt)
	end

	return self._next_state(self)
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
StateTitleScreenLoadSave._get_storage_space = function (self)
	self._state = "waiting_for_storage"

	Managers.account:get_storage_space(callback(self, "cb_storage_acquired"))

	return 
end
StateTitleScreenLoadSave.cb_storage_acquired = function (self, data)
	if data.error then
		self._new_state = StateTitleScreenMain
		self._state = "none"
	else
		self._state = "query_storage_spaces"
	end

	return 
end
StateTitleScreenLoadSave._query_storage_spaces = function (self)
	self._state = "waiting_for_query"

	Managers.save:query_storage_spaces(callback(self, "cb_query_done"))

	return 
end
StateTitleScreenLoadSave.cb_query_done = function (self, data)
	print("######################## QUERY ########################")

	if data.error then
		print("[StateTitleScreenLoadSave:cb_query_done] There was a problem querying your save")

		self._new_state = StateTitleScreenMain
		self._state = "none"

		Managers.account:close_storage()
	elseif self._save_data_contains(self, data, "save_container") then
		if StateTitleScreenLoadSave.DELETE_SAVE then
			self._state = "delete_save"
			StateTitleScreenLoadSave.DELETE_SAVE = false
		else
			self._state = "load_save"
		end
	else
		self._state = "create_save"
	end

	if not GameSettingsDevelopment.disable_intro_trailer then
		self.parent.parent.loading_context.first_time = true
	end

	return 
end
StateTitleScreenLoadSave._save_data_contains = function (self, containers, name)
	for _, container in ipairs(containers) do
		if container.name == name and 0 < container.total_size then
			return true
		end
	end

	return 
end
StateTitleScreenLoadSave._load_save = function (self)
	Managers.save:auto_load(SaveFileName, callback(self, "cb_load_done"))

	self._state = "waiting_for_load"

	return 
end
StateTitleScreenLoadSave.cb_load_done = function (self, data)
	print("######################## DATA LOADED ########################")

	if data.error then
		self._new_state = StateTitleScreenMain
		self._state = "none"

		Managers.account:close_storage()
	else
		populate_save_data(data)

		self._state = "signin_to_backend"
	end

	return 
end
StateTitleScreenLoadSave._create_save = function (self)
	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_save_done"))

	self._state = "waiting_for_save"

	return 
end
StateTitleScreenLoadSave.cb_save_done = function (self, data)
	print("######################## DATA SAVED ########################")
	table.dump(data, nil, 2)

	if data.error then
		self._new_state = StateTitleScreenMain
		self._state = "none"

		Managers.account:close_storage()
	else
		self._state = "signin_to_backend"
	end

	return 
end
StateTitleScreenLoadSave._delete_save = function (self)
	Managers.save:delete_save(SaveFileName, callback(self, "cb_delete_done"))

	self._state = "waiting_for_delete"

	return 
end
StateTitleScreenLoadSave.cb_delete_done = function (self, data)
	print("######################## SAVE DELETED ########################")

	if data.error then
		self._new_state = StateTitleScreenMain
		self._state = "none"

		Managers.account:close_storage()
	else
		self._state = "create_save"
	end

	return 
end
StateTitleScreenLoadSave._next_state = function (self)
	return self._new_state
end
StateTitleScreenLoadSave.on_exit = function (self)
	self._information_view:destroy()

	return 
end

return 
