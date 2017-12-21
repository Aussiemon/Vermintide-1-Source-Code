require("scripts/game_state/state_loading")

StateTitleScreenInitNetwork = class(StateTitleScreenInitNetwork)
StateTitleScreenInitNetwork.NAME = "StateTitleScreenInitNetwork"
StateTitleScreenInitNetwork.on_enter = function (self, params)
	print("[Gamestate] Enter Substate StateTitleScreenInitNetwork")

	self._params = params
	local loading_context = self.parent.parent.loading_context
	local loading_view = loading_context.loading_view

	if loading_view then
		loading_view.destroy(loading_view)

		loading_context.loading_view = nil
	end

	Managers.transition:show_loading_icon(true)

	return 
end
StateTitleScreenInitNetwork.update = function (self, dt, t)
	if not Managers.backend:is_disconnected() then
		Managers.backend:update(dt)
	end

	if self._popup_id then
		self._handle_popup(self)

		return 
	end

	local connected_to_steam = self._connected_to_steam(self)

	if not connected_to_steam then
		self.create_popup(self, "failure_start_no_steam")

		return 
	end

	local backend_signin_initated = self.backend_signin_initated

	if not backend_signin_initated then
		self._backend_signin(self)
	end

	return self._next_state(self)
end
StateTitleScreenInitNetwork._connected_to_steam = function (self)
	if Development.parameter("use_lan_backend") then
		return true
	end

	local connected_to_network = true

	if Application.platform() == "win32" and rawget(_G, "Steam") then
		connected_to_network = Steam.connected()
	end

	return connected_to_network
end
StateTitleScreenInitNetwork._backend_signin = function (self)
	Managers.backend:signin()

	self.backend_signin_initated = true

	return 
end
StateTitleScreenInitNetwork._next_state = function (self)
	if Managers.backend:profiles_loaded() and not Managers.backend:is_waiting_for_user_input() then
		return StateTitleScreenLoadSave
	end

	return 
end
StateTitleScreenInitNetwork.on_exit = function (self, application_shutdown)
	return 
end
StateTitleScreenInitNetwork.create_popup = function (self, error)
	assert(error, "[StateTitleScreenInitNetwork] No error was passed to popup handler")
	assert(self._popup_id == nil, "Tried to show popup even though we already had one.")

	local header = Localize("popup_steam_error_header")
	local localized_error = Localize(error)
	self._popup_id = Managers.popup:queue_popup(localized_error, header, "retry", Localize("button_retry"), "quit", Localize("menu_quit"))

	return 
end
StateTitleScreenInitNetwork._handle_popup = function (self)
	local result = Managers.popup:query_result(self._popup_id)

	if result == "retry" then
		self._popup_id = nil
	elseif result == "quit" then
		Boot.quit_game = true
		self._popup_id = nil
	elseif result then
		print(string.format("[StateTitleScreenInitNetwork] No such result handled (%s)", result))
	end

	return 
end

return 
