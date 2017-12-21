require("scripts/managers/backend/script_backend")
require("scripts/managers/backend/script_backend_common")
require("scripts/managers/backend/script_backend_item")
require("scripts/managers/backend/script_backend_profile_attribute")
require("scripts/managers/backend/script_backend_session")
require("scripts/managers/backend/backend_boons")
require("scripts/managers/backend/backend_quests")

cjson = cjson.stingray_init()
local DEBUG_QUESTS_AND_CONTRACTS = false

if GameSettingsDevelopment.backend_settings.allow_local then
	require("backend/local_backend/local_backend")
end

if GameSettingsDevelopment.backend_settings.allow_tutorial then
	require("backend/tutorial_backend/tutorial_backend")
end

local ERROR_CODES = {}
BACKEND_LUA_ERRORS = {}

if rawget(_G, "Backend") then
	ERROR_CODES[Backend.ERR_OK] = "backend_err_ok"
	ERROR_CODES[Backend.ERR_UNKNOWN] = "backend_err_unknown"
	ERROR_CODES[Backend.ERR_AUTH] = "backend_err_auth"
	ERROR_CODES[Backend.ERR_LOADING_PROFILE] = "backend_err_loading_profile"
	ERROR_CODES[Backend.ERR_TITLE_ID_DISABLED] = "backend_err_title_id_disabled"
	ERROR_CODES[Backend.ERR_COMMIT] = "backend_err_commit"
	ERROR_CODES[Backend.ERR_LOAD_ENTITIES] = "backend_err_load_entities"
	ERROR_CODES[Backend.ERR_SESSION_GENERIC] = "backend_err_session_generic"
	ERROR_CODES[Backend.ERR_SESSION_JOIN] = "backend_err_session_join"
	ERROR_CODES[Backend.ERR_SESSION_LEAVE] = "backend_err_session_leave"
	BACKEND_LUA_ERRORS.ERR_DICE_TIMEOUT1 = #ERROR_CODES + 1
	ERROR_CODES[BACKEND_LUA_ERRORS.ERR_DICE_TIMEOUT1] = "backend_err_dice_timeout_1"
	BACKEND_LUA_ERRORS.ERR_UPGRADES_TIMEOUT = #ERROR_CODES + 1
	ERROR_CODES[BACKEND_LUA_ERRORS.ERR_UPGRADES_TIMEOUT] = "backend_err_upgrades_timeout"
	BACKEND_LUA_ERRORS.ERR_DICE_TIMEOUT2 = #ERROR_CODES + 1
	ERROR_CODES[BACKEND_LUA_ERRORS.ERR_DICE_TIMEOUT2] = "backend_err_dice_timeout_2"
	BACKEND_LUA_ERRORS.ERR_DICE_TIMEOUT3 = #ERROR_CODES + 1
	ERROR_CODES[BACKEND_LUA_ERRORS.ERR_DICE_TIMEOUT3] = "backend_err_dice_timeout_3"
	BACKEND_LUA_ERRORS.ERR_DISCONNECTED = #ERROR_CODES + 1
	ERROR_CODES[BACKEND_LUA_ERRORS.ERR_DISCONNECTED] = "backend_err_disconnected"
end

BACKEND_LUA_ERRORS.ERR_LOADING_PLUGIN = 255
ERROR_CODES[BACKEND_LUA_ERRORS.ERR_LOADING_PLUGIN] = "backend_err_loading_plugin"
BACKEND_LUA_ERRORS.ERR_USE_LOCAL_BACKEND_NOT_ALLOWED = 256
ERROR_CODES[BACKEND_LUA_ERRORS.ERR_USE_LOCAL_BACKEND_NOT_ALLOWED] = "backend_err_use_local_backend_not_allowed"
BackendManager = class(BackendManager)
BackendManager.TIMEOUT_SIGNIN = 10
BackendManager.init = function (self)
	local settings = GameSettingsDevelopment.backend_settings

	if not settings.enable_sessions then
		make_script_backend_session_local()
	end

	if DEBUG_QUESTS_AND_CONTRACTS then
		make_script_backend_item_local()
	end

	self._interfaces = {}

	if settings.quests_enabled then
		local boons = BackendBoons:new()
		self._interfaces.boons = boons

		if GameSettingsDevelopment.backend_settings.real_quests then
			if self._interfaces.quests then
				self._interfaces.quests:delete()
			end

			self._interfaces.quests = BackendQuests:new(boons)
		else
			self._interfaces.quests = BackendQuestsLocal:new()
		end
	end

	self.reset(self)

	return 
end
BackendManager.reset = function (self)
	self._errors = {}
	self._is_disconnected = false

	self._destroy_backend(self)

	return 
end
BackendManager.signin = function (self)
	local plugin_loaded = rawget(_G, "Backend") ~= nil
	local allow_local = GameSettingsDevelopment.backend_settings.allow_local
	local use_backend = GameSettingsDevelopment.use_backend

	if not plugin_loaded or not use_backend then
		if allow_local then
			self._should_disable = true
		elseif not plugin_loaded then
			local error_data = {
				reason = BACKEND_LUA_ERRORS.ERR_LOADING_PLUGIN
			}

			self._post_error(self, error_data)

			return 
		elseif not use_backend then
			local error_data = {
				reason = BACKEND_LUA_ERRORS.ERR_USE_LOCAL_BACKEND_NOT_ALLOWED
			}

			self._post_error(self, error_data)

			return 
		else
			error("Bad backend combination")
		end
	end

	if self._should_disable then
		self.disable(self)

		return 
	end

	if self._backend then
		self.reset(self)
	end

	print("[BackendManager] Backend Enabled")

	self._backend = ScriptBackend:new()

	if not self._backend:authenticated() then
		print("[BackendManager] BackendManager self._need_signin = true")

		self._data_server_queue = DataServerQueue:new()

		ScriptBackendItem.set_data_server_queue(self._data_server_queue)

		self._need_signin = true
	end

	return 
end
BackendManager._destroy_backend = function (self)
	if self._backend then
		self._backend:destroy()

		self._backend = nil
	end

	return 
end
BackendManager.get_interface = function (self, interface_name, player_id)
	fassert(self._interfaces[interface_name], "Requesting unknown interface %q", interface_name)

	return self._interfaces[interface_name]
end
BackendManager.get_data_server_queue = function (self)
	return self._data_server_queue
end
BackendManager.is_disconnected = function (self)
	return self._is_disconnected
end
BackendManager.is_waiting_for_user_input = function (self)
	return not not self._error_dialog
end
BackendManager.disable = function (self)
	print("[BackendManager] Backend Disabled")

	self._disable_backend = true

	self._destroy_backend(self)

	Managers.backend = BackendManagerLocal:new()
	self._should_disable = false

	return 
end
BackendManager.make_tutorial = function (self)
	print("[BackendManager] Backend Disabled Tutorial")

	self._disable_backend = true

	self._destroy_backend(self)

	Managers.backend = BackendManagerTutorial:new()
	self._should_disable = false

	return 
end
BackendManager._update_state = function (self)
	local settings = GameSettingsDevelopment.backend_settings

	if self._need_signin then
		local result_data = self._backend:update_signin()

		if result_data then
			self._need_signin = false

			self._post_error(self, result_data)
		elseif self._backend:authenticated() then
			self._need_signin = false

			if settings.quests_enabled then
				self._interfaces.quests:setup(self._data_server_queue)
			end
		end
	else
		local result_data = self._backend:update_state()

		if result_data then
			self._post_error(self, result_data)
		end
	end

	return 
end
BackendManager._update_error_handling = function (self, dt)
	if 0 < #self._errors and not self._error_dialog and not self._is_disconnected then
		local error_data = table.remove(self._errors, 1)

		self._show_error_dialog(self, error_data.reason, error_data.details)
	end

	if self._error_dialog then
		local result = Managers.popup:query_result(self._error_dialog)

		if result then
			Managers.popup:cancel_popup(self._error_dialog)

			self._error_dialog = nil

			if result == self._button_disconnected then
				self._is_disconnected = true
			elseif result == self._button_retry then
				self._is_disconnected = true
			elseif result == self._button_quit then
				Application.quit()
			elseif result == self._button_local_backend then
				self._should_disable = true
			end
		end
	end

	return 
end
BackendManager.update = function (self, dt)
	if self._should_disable then
		self.disable(self)

		return 
	end

	if self._backend then
		local settings = GameSettingsDevelopment.backend_settings
		local error_data = self._backend:update()

		if error_data then
			self._post_error(self, error_data)
		end

		self._data_server_queue:update()
		ScriptBackendSession.update()

		if not DEBUG_QUESTS_AND_CONTRACTS then
			ScriptBackendItem.update()
		end

		if settings.quests_enabled then
			self._interfaces.boons:update()
		end

		self._update_state(self)

		local error_data = nil

		if settings.enable_sessions then
			error_data = self._backend:check_for_errors() or ScriptBackendItem.check_for_errors() or ScriptBackendSession.check_for_errors() or self._data_server_queue:check_for_errors()
		else
			error_data = self._backend:check_for_errors() or self._data_server_queue:check_for_errors()
		end

		if error_data then
			self._post_error(self, error_data)
		end

		if self._should_disable then
			self._destroy_backend(self)
		end
	end

	self._update_error_handling(self, dt)

	return 
end
BackendManager._post_error = function (self, error_data)
	ScriptApplication.send_to_crashify("Backend_Error", "ERROR: %s", error_data.details)
	fassert(error_data.reason, "Posting error without reason, %q: %q", error_data.reason or "nil")
	print("[BackendManager] adding error:", error_data.reason, error_data.details)

	if not self._error_dialog and not self._is_disconnected then
		self._show_error_dialog(self, error_data.reason, error_data.details)
	else
		self._errors[#self._errors + 1] = error_data
	end

	return 
end
BackendManager._show_signin_error_dialog = function (self, error_text)
	local error_topic = Localize("backend_error_topic")
	self._button_retry = "button_ok"
	self._button_quit = "button_quit"

	if GameSettingsDevelopment.backend_settings.allow_local then
		self._button_local_backend = "button_local_backend"
		self._error_dialog = Managers.popup:queue_popup(error_text, error_topic, self._button_quit, Localize("menu_quit"), self._button_local_backend, Localize("backend_button_local"))
	else
		self._error_dialog = Managers.popup:queue_popup(error_text, error_topic, self._button_quit, Localize("menu_quit"))
	end

	return 
end
BackendManager._show_ingame_error_dialog = function (self, error_text)
	local error_topic = Localize("backend_error_topic")
	self._button_disconnected = "button_ok"
	self._error_dialog = Managers.popup:queue_popup(error_text, error_topic, self._button_disconnected, Localize("button_ok"))

	return 
end
BackendManager._show_error_dialog = function (self, reason, details_message)
	print(string.format("[BackendManager] Showing error dialog: %q, %q", reason or "nil", details_message or "nil"))

	local localization_string = ERROR_CODES[reason]
	local error_text = Localize(localization_string)

	if details_message and details_message ~= "" then
		error_text = error_text .. ". '" .. details_message .. "'"
	end

	ScriptApplication.send_to_crashify("Backend", error_text)

	if not self.profiles_loaded(self) then
		self._show_signin_error_dialog(self, error_text)
	else
		self._show_ingame_error_dialog(self, error_text)
	end

	return 
end
BackendManager.get_stats = function (self)
	return self._backend:get_stats()
end
BackendManager.set_stats = function (self, stats)
	return self._backend:set_stats(stats)
end
BackendManager.available = function (self)
	local settings = GameSettingsDevelopment.backend_settings

	if settings.quests_enabled then
		return rawget(_G, "Backend") ~= nil and rawget(_G, "Steam") ~= nil and self._interfaces.quests:initiated()
	else
		return rawget(_G, "Backend") ~= nil and rawget(_G, "Steam") ~= nil
	end

	return 
end
BackendManager.commit = function (self)
	return self._backend:commit()
end
BackendManager.commit_status = function (self, commit_id)
	return self._backend:commit_status(commit_id)
end
BackendManager.profiles_loaded = function (self)
	local settings = GameSettingsDevelopment.backend_settings
	local ready = nil

	if settings.quests_enabled then
		ready = self._disable_backend or (self._backend and self._backend:authenticated() and self._interfaces.quests:initiated())
	else
		ready = self._disable_backend or (self._backend and self._backend:authenticated())
	end

	return ready
end
BackendManager.refresh_log_level = function (self)
	if self._backend then
		self._backend:refresh_log_level()
	else
		print("[BackendManager] No backend to set log level on!")
	end

	return 
end
BackendManager.logout = function (self)
	error("[BackendManager] Not implemented yet")

	return 
end
BackendManager.disconnect = function (self)
	error("[BackendManager] Not implemented yet")

	return 
end
BackendManager.destroy = function (self)
	if self._interfaces.quests then
		self._interfaces.quests:delete()
	end

	local backend = self._backend

	if backend then
		backend.wait_for_shutdown(backend, 1)
	end

	return 
end

return 
