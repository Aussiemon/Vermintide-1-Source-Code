require("scripts/managers/backend/script_backend")
require("scripts/managers/backend/script_backend_common")
require("scripts/managers/backend/script_backend_item")
require("scripts/managers/backend/script_backend_profile_attribute")
require("scripts/managers/backend/script_backend_session")
require("scripts/managers/backend/backend_boons")
require("scripts/managers/backend/backend_quests")
require("scripts/managers/backend/backend_profile_hash")

cjson = cjson.stingray_init()
local DEBUG_QUESTS_AND_CONTRACTS = false

if GameSettingsDevelopment.backend_settings.allow_local then
	require("backend/local_backend/local_backend")
end

if GameSettingsDevelopment.backend_settings.allow_tutorial then
	require("scripts/managers/backend/tutorial_backend/tutorial_backend")
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

	self._interfaces.profile_hash = BackendProfileHash:new()
	self._button_retry = "button_ok"
	self._button_quit = "button_quit"
	self._button_local_backend = "button_local_backend"
	self._button_disconnected = "button_disconnected"

	self.reset(self)

	return 
end
BackendManager.reset = function (self)
	self._errors = {}
	self._is_disconnected = false

	self._destroy_backend(self)

	return 
end
BackendManager.signin = function (self, authentication_token)
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

	self._backend = ScriptBackend:new(authentication_token)

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
BackendManager.item_script_type = function (self)
	return ScriptBackendItem.type()
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
BackendManager.start_tutorial = function (self)
	fassert(self._script_backend_items_backup == nil, "Tutorial already started")

	self._script_backend_items_backup = ScriptBackendItem

	make_script_backend_item_tutorial()

	return 
end
BackendManager.stop_tutorial = function (self)
	fassert(self._script_backend_items_backup ~= nil, "Stopping tutorial without starting it")

	ScriptBackendItem = self._script_backend_items_backup
	self._script_backend_items_backup = nil

	return 
end
BackendManager._update_state = function (self)
	Profiler.start("BackendManager update_state")

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

			self._interfaces.profile_hash:on_authenticated()
		end
	else
		local result_data = self._backend:update_state()

		if result_data then
			self._post_error(self, result_data)
		end
	end

	Profiler.stop()

	return 
end
BackendManager._update_error_handling = function (self, dt)
	Profiler.start("BackendManager update_error_handling")

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
			elseif result == self._button_restart then
				self._is_disconnected = true
			elseif result == self._button_local_backend then
				self._should_disable = true
			end
		end
	end

	Profiler.stop()

	return 
end
BackendManager.update = function (self, dt)
	if self._should_disable then
		self.disable(self)

		return 
	end

	if self._backend then
		local settings = GameSettingsDevelopment.backend_settings

		Profiler.start("ScriptBackend update")

		local error_data = self._backend:update()

		Profiler.stop()

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
BackendManager.authenticated = function (self)
	return self._backend and self._backend:authenticated()
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
BackendManager._format_error_message_console = function (self, reason, details_message)
	local button = {
		id = self._button_retry,
		text = Localize("button_ok")
	}

	if not self.profiles_loaded(self) then
		if reason == Backend.ERR_AUTH then
			if Application.platform() == "xb1" then
				return "backend_err_auth_xb1", button
			else
				return "backend_err_auth_ps4", button
			end
		else
			return "backend_err_connecting", button
		end
	else
		return "backend_err_network", button
	end

	return 
end
BackendManager._format_error_message_windows = function (self, reason, details_message)
	local error_text, button_1, button_2 = nil

	if not self.profiles_loaded(self) then
		button_1 = {
			id = self._button_quit,
			text = Localize("menu_quit")
		}

		if GameSettingsDevelopment.backend_settings.allow_local then
			button_2 = {
				id = self._button_local_backend,
				text = Localize("backend_button_local")
			}
		end

		print("backend error", reason, ERROR_CODES[reason])

		if reason == Backend.ERR_AUTH then
			error_text = "backend_err_auth_steam"
		else
			error_text = "backend_err_connecting"
		end
	else
		button_1 = {
			id = self._button_disconnected,
			text = Localize("button_ok")
		}
		error_text = "backend_err_network"
	end

	return error_text, button_1, button_2
end
BackendManager._show_error_dialog = function (self, reason, details_message)
	print(string.format("[BackendManager] Showing error dialog: %q, %q", reason or "nil", details_message or "nil"))

	local error_topic = Localize("backend_error_topic")
	local error_text, button_1, button_2 = nil

	if Application.platform() == "xb1" or Application.platform() == "ps4" then
		error_text, button_1 = self._format_error_message_console(self, reason, details_message)
	else
		error_text, button_1, button_2 = self._format_error_message_windows(self, reason, details_message)
	end

	local localzed_error_text = Localize(error_text)

	if button_2 then
		self._error_dialog = Managers.popup:queue_popup(localzed_error_text, error_topic, button_1.id, button_1.text, button_2.id, button_2.text)
	else
		self._error_dialog = Managers.popup:queue_popup(localzed_error_text, error_topic, button_1.id, button_1.text)
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

	if Application.platform() == "win32" then
		if settings.quests_enabled then
			return rawget(_G, "Backend") ~= nil and rawget(_G, "Steam") ~= nil and self._interfaces.quests:initiated()
		else
			return rawget(_G, "Backend") ~= nil and rawget(_G, "Steam") ~= nil
		end
	elseif settings.quests_enabled then
		return rawget(_G, "Backend") ~= nil and self._interfaces.quests:initiated()
	else
		return rawget(_G, "Backend") ~= nil
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
