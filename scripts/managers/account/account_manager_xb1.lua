require("scripts/managers/account/presence/script_presence_xb1")
require("scripts/managers/account/script_connected_storage_token")
require("scripts/managers/account/smartmatch_cleaner")

AccountManager = class(AccountManager)
AccountManager.VERSION = "xb1"

local function dprint(...)
	print("[AccountManager] ", ...)

	return 
end

AccountManager.init = function (self)
	self._user_id = nil
	self._achievements = nil
	self._presence = ScriptPresence:new()
	self._initiated = false
	self._lobbies_to_free = {}
	self._smartmatch_cleaner = SmartMatchCleaner:new()

	return 
end
AccountManager._set_user_id = function (self, id, controller)
	self._user_id = id

	self._presence:set_user_id(id)

	self._user_info = XboxLive.user_info(id)
	self._player_session_id = Application.guid()
	self._active_controller = controller

	return 
end
AccountManager.xbox_user_id = function (self)
	return self._user_info.xbox_user_id
end
AccountManager.player_session_id = function (self)
	return self._player_session_id
end
AccountManager.user_id = function (self)
	return self._user_id
end
AccountManager.storage_id = function (self)
	return self._storage_id
end
AccountManager.update = function (self, dt)
	if self._initiated then
		if self._storage_token then
			self._handle_storage_token(self)
		else
			self._update_sessions(self, dt)

			if self._user_id then
				self._check_for_disconnect(self, dt)
				self._verify_user_profile(self, dt)
			end

			if self._popup_id then
				local result = Managers.popup:query_result(self._popup_id)

				if result then
					self._handle_popup_result(self, result)
				end
			end
		end
	end

	return 
end
AccountManager._update_sessions = function (self, dt)
	if Network.xboxlive_client_exists() then
		if 0 < #self._lobbies_to_free then
			self._update_lobbies_to_free(self)
		end

		self._smartmatch_cleaner:update(dt)
	else
		self._smartmatch_cleaner:reset()
	end

	return 
end
LOBBIES_TO_REMOVE = LOBBIES_TO_REMOVE or {}
AccountManager._update_lobbies_to_free = function (self)
	for i = #self._lobbies_to_free, 1, -1 do
		local lobby = self._lobbies_to_free[i]
		local state = lobby.state(lobby)

		if state == MultiplayerSession.SHUTDOWN then
			print("Freed a lobby")
			lobby.free(lobby)

			LOBBIES_TO_REMOVE[#LOBBIES_TO_REMOVE + 1] = i
		end
	end

	if 0 < #LOBBIES_TO_REMOVE then
		for _, index in ipairs(LOBBIES_TO_REMOVE) do
			print("Removed a lobby")
			table.remove(self._lobbies_to_free, index)
		end

		LOBBIES_TO_REMOVE = {}
	end

	return 
end
AccountManager._verify_user_profile = function (self)
	if self._popup_id then
		return 
	end

	local user_id = self._active_controller and self._active_controller.user_id()
	local user_info = user_id and XboxLive.user_info(user_id)

	if not user_id or self._user_info.xbox_user_id ~= user_info.xbox_user_id or not user_info.signed_in then
		self._create_popup(self, "profile_signed_out", "profile_signed_out_header", "verify_profile", "menu_ok", "restart", "menu_restart")
	end

	return 
end
AccountManager._check_for_disconnect = function (self, dt)
	if self._popup_id then
		return 
	end

	if not self._active_controller or (self._active_controller.disconnected() and self._active_controller.user_id() == self._user_id) then
		self._create_popup(self, "controller_disconnected", "controller_disconnected_header", "verify_profile", "menu_ok", "restart", "menu_restart")
	end

	return 
end
AccountManager._create_popup = function (self, error, header, right_action, right_button, left_action, left_button)
	Managers.input:set_all_gamepads_available("gamepad")
	assert(error, "[AccountManager] No error was passed to popup handler")

	local header = header or "popup_error_topic"
	local right_action = right_action or "verify_profile"
	local left_action = left_action or "restart"
	local right_button = right_button or "menu_ok"
	local left_button = left_button or "menu_restart"
	local localized_error = Localize(error)

	assert(self._popup_id == nil, "Tried to show popup even though we already had one.")

	self._popup_id = Managers.popup:queue_popup(localized_error, Localize(header), right_action, Localize(right_button), left_action, Localize(left_button))

	return 
end
AccountManager._handle_popup_result = function (self, result)
	self._popup_id = nil

	if result == "verify_profile" then
		self.verify_profile(self)
	elseif result == "restart" then
		self.initiate_leave_game(self)
	else
		fassert(false, "[AccountManager] The popup result doesn't exist (%s)", result)
	end

	return 
end
AccountManager.restarting = function (self)
	return self._restarting
end
AccountManager.verify_profile = function (self)
	local most_recent_device = Managers.input:get_most_recent_device()
	local user_info = XboxLive.user_info(most_recent_device.user_id())

	if user_info.xbox_user_id == self._user_info.xbox_user_id then
		self._active_controller = most_recent_device

		Managers.input:device_unblock_all_services("gamepad")
		Managers.input:set_exclusive_gamepad(self._active_controller)
	else
		self._create_popup(self, "wrong_profile", "wrong_profile_header", "verify_profile", "menu_ok", "restart", "menu_restart")
	end

	return 
end
AccountManager.cb_profile_signed_out = function (self)
	local most_recent_device = Managers.input:get_most_recent_device()
	local user_info = XboxLive.user_info(most_recent_device.user_id())

	if user_info.xbox_user_id == self._user_info.xbox_user_id then
		self._active_controller = most_recent_device

		Managers.input:device_unblock_all_services("gamepad")
		Managers.input:set_exclusive_gamepad(self._active_controller)
	else
		print(string.format("Wrong profile: Had user_id %s - wanted user_id %s", user_info.xbox_user_id, self._user_info.xbox_user_id))
	end

	return 
end
AccountManager._check_sign_in_status = function (self)
	local user_id = self._user_id
	local user_state = SignIn.state(user_id)

	if user_state ~= self._last_user_state then
		local update_state = true

		if self._wanted_user_signed_in(self) and self._name == SignIn.name(user_id) and self._last_user_state == SignIn.NOT_SIGNED_IN then
			dprint("service user signed in")
			Managers.save:service_user_signed_in(user_id)
			Managers.state.event:trigger("account_service_user_signed_in", user_id)
		elseif not self._wanted_user_signed_in(self) and self._last_user_state ~= SignIn.NOT_SIGNED_IN then
			dprint("service user signed out")
			Managers.save:service_user_signed_out(user_id)
			Managers.state.event:trigger("account_service_user_signed_out", user_id)
		else
			update_state = false
		end

		if update_state then
			self._last_user_state = user_state
		end
	end

	return 
end
AccountManager._check_signed_in_to_live = function (self)
	local user_id = self._user_id
	local sign_in_state = SignIn.state(user_id)

	if sign_in_state == SignIn.SIGNED_IN_TO_LIVE and self._wanted_user_signed_in(self) and self._name == SignIn.name(user_id) then
		self._has_been_signed_in_to_live = true
		self._xuid = SignIn.xuid(user_id)
	end

	return 
end
AccountManager._check_signed_in_locally = function (self)
	local user_id = self._user_id
	local sign_in_state = SignIn.state(user_id)

	if sign_in_state == SignIn.SIGNED_IN_LOCALLY and self._wanted_user_signed_in(self) and self._name == SignIn.name(user_id) then
		self._xuid = SignIn.xuid(user_id)
	end

	return 
end
AccountManager._not_signed_in_to_live = function (self)
	local user_id = self._user_id

	if user_id == nil or SignIn.state(user_id) == SignIn.NOT_SIGNED_IN then
		return nil
	end

	return self._has_been_signed_in_to_live and SignIn.state(user_id) ~= SignIn.SIGNED_IN_TO_LIVE and self._name == SignIn.name(user_id)
end
AccountManager.signed_in_to_live = function (self)
	local user_id = self._user_id

	if user_id == nil or SignIn.state(user_id) == SignIn.NOT_SIGNED_IN then
		return nil
	end

	return self._has_been_signed_in_to_live and SignIn.state(user_id) == SignIn.SIGNED_IN_TO_LIVE and self._name == SignIn.name(user_id)
end
AccountManager.user_handle_input = function (self)
	return self.valid_user_signed_in(self)
end
AccountManager.valid_user_signed_in = function (self)
	return not self.wrong_user_signed_in(self)
end
AccountManager.wrong_user_signed_in = function (self)
	local user_id = self._user_id

	if user_id == nil then
		return true
	end

	if self._wanted_user_signed_in(self) then
		local xuid = SignIn.xuid(user_id)

		if xuid ~= self._xuid then
			return true
		end
	end

	return not self._is_user_signed_in(self, user_id)
end
AccountManager.cb_sign_in_with_alternative = function (self, answer)
	if answer == 1 then
		Managers.platform_ui:signin(callback(self, "cb_signin_closed"), 1, SignIn.LOCALSIGNINONLY)
	else
		local header = L("system_leave_game")
		local text = L("system_user_ask_leave_game")
		local button_no = L("system_menu_no_lower")
		local button_yes = L("system_menu_yes_lower")
		self._showing_signin_message = true

		Managers.platform_ui:show_message_box(callback(self, "cb_leave_game"), self._user_id, header, text, button_no, button_yes)
	end

	return 
end
AccountManager.cb_leave_game = function (self, answer)
	if answer == 1 then
		self._trigger_leave_game(self)
	else
		self._showing_signin_message = false
	end

	return 
end
AccountManager.cb_xbox_live_dialog_closed = function (self)
	self._showing_signin_message = false
	self._has_been_signed_in_to_live = nil
	self._xuid = SignIn.xuid(self._user_id)

	return 
end
AccountManager.cb_signin_closed = function (self)
	self._showing_signin_message = false

	return 
end
AccountManager.num_signed_in_users = function (self)
	local users = 0
	local not_signed_in = SignIn.NOT_SIGNED_IN

	for user_id = 0, 3, 1 do
		if SignIn.state(user_id) ~= not_signed_in then
			users = users + 1
		end
	end

	return users
end
AccountManager._wanted_user_signed_in = function (self)
	return self._is_user_signed_in(self, self._user_id)
end
AccountManager._is_user_signed_in = function (self, user_id)
	return user_id and SignIn.state(user_id) ~= SignIn.NOT_SIGNED_IN
end
AccountManager._any_signed_in_user = function (self)
	local not_signed_in = SignIn.NOT_SIGNED_IN

	for user_id = 0, 3, 1 do
		if SignIn.state(user_id) ~= not_signed_in then
			return user_id
		end
	end

	return 
end
AccountManager._current_user_states = function (self)
	local user_states = {}

	for user_index = 0, 3, 1 do
		user_states[user_index + 1] = SignIn.state(user_index)
	end

	return user_states
end
AccountManager._compare_user_states = function (self, states, other_states)
	for user_index, state in ipairs(other_states) do
		if states[user_index] ~= state then
			return false
		end
	end

	return true
end
AccountManager.any_user_state_changed = function (self)
	local current_states = self._current_user_states(self)
	local last_states = self._last_user_states

	return not self._compare_user_states(self, current_states, last_states)
end
AccountManager.sign_in = function (self, user_id, controller)
	if not user_id then
		local controller_index = self._controller_index(self, controller)

		if controller_index then
			XboxLive.show_account_picker(controller_index)

			return false
		end
	elseif XboxLive.online_state() == XboxOne.ONLINE then
		self._hard_sign_in(self, user_id, controller)
	else
		Application.error("User not connected to XBOX Live")

		return false
	end

	return true
end
AccountManager._controller_index = function (self, controller)
	if controller then
		local name = controller.name()

		if string.find(name, "Xbox Controller ") then
			return tonumber(string.gsub(controller.name(), "Xbox Controller ", ""), 10) + 1
		end
	end

	return 
end
AccountManager._hard_sign_in = function (self, user_id, controller)
	dprint("Hard-sign in", user_id)
	self._set_user_id(self, user_id, controller)
	self._unmap_other_controllers(self)
	self._on_user_signed_in(self)

	return 
end
AccountManager._unmap_other_controllers = function (self)
	Managers.input:set_exclusive_gamepad(self._active_controller)

	return 
end
AccountManager._on_user_signed_in = function (self)
	local user_id = self._user_id
	self._initiated = true

	return 
end
AccountManager._handle_storage_token = function (self)
	self._storage_token:update()

	if self._storage_token:done() then
		local info = self._storage_token:info()

		self._storage_acquired(self, info)

		self._storage_token = nil
	end

	return 
end
AccountManager.get_storage_space = function (self, done_callback)
	if not self._storage_id then
		local token = XboxConnectedStorage.get_storage_space(self._user_id)
		self._storage_token = ScriptConnectedStorageToken:new(XboxConnectedStorage, token)
		self._get_storage_done_callback = done_callback
	else
		done_callback({})
	end

	return 
end
AccountManager._storage_acquired = function (self, data)
	if data.error then
		Application.error("[AccountManager] There was an error in the get_storage_space operation: " .. data.error)
		self.close_storage(self)
	else
		self._storage_id = data.storage_id
	end

	self._get_storage_done_callback(data)

	self._get_storage_done_callback = nil

	return 
end
AccountManager.add_session_to_cleanup = function (self, session_data)
	self._smartmatch_cleaner:add_session(session_data)

	return 
end
AccountManager.add_lobby_to_free = function (self, lobby)
	self._lobbies_to_free[#self._lobbies_to_free + 1] = lobby

	return 
end
AccountManager.all_lobbies_freed = function (self)
	return #self._lobbies_to_free == 0 and self._smartmatch_cleaner:ready()
end
AccountManager.initiate_leave_game = function (self)
	self._leave_game = true

	return 
end
AccountManager.leaving_game = function (self)
	return self._leave_game
end
AccountManager._trigger_leave_game = function (self)
	self.reset(self)
	Managers.state.event:trigger("account_user_wants_to_leave_game")

	return 
end
AccountManager.reset = function (self)
	self._user_id = nil
	self._presence = ScriptPresence:new()
	self._user_info = nil
	self._player_session_id = nil
	self._active_controller = nil
	self._leave_game = nil

	return 
end
AccountManager._init_achievements = function (self, user_id)
	self._destroy_achievements(self)

	if rawget(_G, "Achievements") then
		self._achievements = Achievements(user_id)
	end

	return 
end
AccountManager._destroy_achievements = function (self)
	if self._achievements then
		Achievements.destroy(self._achievements)

		self._achievements = nil
	end

	return 
end
AccountManager.achievements = function (self)
	return self._achievements
end
AccountManager.set_presence_menu = function (self)
	self._presence:set_presence_menu()

	return 
end
AccountManager.set_presence_idle = function (self)
	self._presence:set_presence_idle()

	return 
end
AccountManager.set_presence_credits = function (self)
	self._presence:set_presence_credits()

	return 
end
AccountManager.set_presence_ingame = function (self, level_key)
	self._presence:set_presence_ingame(level_key)

	return 
end
AccountManager.destroy = function (self)
	self._destroy_achievements(self)
	self.close_storage(self)

	return 
end
AccountManager.close_storage = function (self)
	print("closing storage")

	local token = self._storage_id or self._storage_token

	if token then
		XboxConnectedStorage.finish(token)

		self._storage_id = nil
		self._storage_token = nil

		print("Storage Closed")
	end

	return 
end
AccountManager.set_controller_disconnected = function (self, disconnected)
	self._controller_disconnected = disconnected

	return 
end
AccountManager.controller_disconnected = function (self)
	return self._controller_disconnected
end
AccountManager.get_friends = function (self, friends_list_limit, callback)
	callback(nil)

	return 
end
AccountManager._update_controller_disconnect = function (self)
	if Application.platform() == "x360" then
		if Managers.account:user_id() then
			local controller = self.get_type_input_mapping(self, "pad")

			self._check_disconnect(self, controller)
		end
	else
		local controller = self.get_type_input_mapping(self, "pad")

		self._check_disconnect(self, controller)
	end

	return 
end
AccountManager._check_disconnect = function (self, controller)
	if controller.disconnected() then
		local platform = Application.platform()

		if platform == "x360" and not self._disconnected_controller then
			self._show_disconnect_message(self, controller)
			Managers.account:set_controller_disconnected(true)
		elseif platform == "ps3" and (not self._delayed_disconnect_controller or (self._delayed_disconnect_controller and controller ~= self._delayed_disconnect_controller)) then
			self._delayed_disconnect_controller = controller
			self._delayed_disconnect_timer = 3
		end
	end

	return 
end
AccountManager.cb_controller_connected = function (self)
	if self._disconnected_controller then
		if self._disconnected_controller.active() or self._disconnected_controller.connected() then
			Managers.account:set_controller_disconnected(false)

			self._disconnected_controller = nil
		else
			self._show_disconnect_message(self, self._disconnected_controller)
		end
	end

	return 
end
AccountManager._show_disconnect_message = function (self, controller)
	local controller_index = string.match(controller._name, "%d+")
	self._disconnected_controller = controller
	local str = nil

	if Application.platform() == "ps3" then
		str = string.format(L("system_controller_disconnected_text_ps3"), controller_index)

		Managers.platform_ui:show_message_box(callback(self, "cb_controller_connected"), str, "button_type", "ok")
	else
		str = string.format(L("system_controller_disconnected_text"), controller_index)

		Managers.platform_ui:show_message_box(callback(self, "cb_controller_connected"), Managers.account:user_id() or controller_index - 1, L("system_controller_disconnected"), str, L("system_menu_ok"))
	end

	return 
end
AccountManager._update_delayed_disconnect_message = function (self, dt)
	if self._delayed_disconnect_controller then
		if self._delayed_disconnect_timer <= 0 then
			if not self._disconnected_controller then
				self._show_disconnect_message(self, self._delayed_disconnect_controller)
				Managers.account:set_controller_disconnected(true)
			end

			self._delayed_disconnect_controller = nil
			self._delayed_disconnect_timer = nil
		else
			self._delayed_disconnect_timer = self._delayed_disconnect_timer - dt
		end
	end

	return 
end
AccountManager._update_new_active_controller = function (self)
	local disconnected_controller = self._delayed_disconnect_controller or self._disconnected_controller

	if disconnected_controller then
		local controller = self.get_type_input_mapping(self, "pad")

		if controller.active() or controller.connected() then
			self._disconnected_controller = nil
			self._delayed_disconnect_controller = nil

			Managers.account:set_controller_disconnected(false)
		end
	end

	return 
end
AccountManager.set_current_lobby = function (self, lobby)
	return 
end

return 
