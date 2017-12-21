require("scripts/ui/views/title_main_ui")

StateTitleScreenMain = class(StateTitleScreenMain)
StateTitleScreenMain.NAME = "StateTitleScreenMain"
ATTRACT_MODE_TIMER = 45
StateTitleScreenMain.on_enter = function (self, params)
	print("[Gamestate] Enter Substate StateTitleScreenMain")

	self._params = params
	self._world = self._params.world
	self._viewport = self._params.viewport
	self._attract_mode_timer = ATTRACT_MODE_TIMER
	self._attract_mode_active = false
	self._auto_start = params.auto_start

	self._setup_gui(self)
	self._setup_account_manager(self)
	Managers.music:trigger_event("Play_menu_screen_music")

	return 
end
StateTitleScreenMain._setup_gui = function (self)
	self._title_start_ui = TitleMainUI:new(self._world)

	return 
end
StateTitleScreenMain._setup_account_manager = function (self)
	Managers.account = Managers.account or AccountManager:new()

	return 
end
StateTitleScreenMain.update = function (self, dt, t)
	self._update_network(self, dt, t)
	self._title_start_ui:update(dt, t)
	self._update_input(self, dt, t)
	self._update_attract_mode(self, dt, t)

	return self._next_state(self)
end
StateTitleScreenMain._update_network = function (self, dt, t)
	if rawget(_G, "LobbyInternal") and LobbyInternal.network_initialized() then
		Network.update(dt, {})
	end

	return 
end
StateTitleScreenMain._update_attract_mode = function (self, dt, t)
	if self._title_start_ui:attract_mode() then
		if self._title_start_ui:video_completed() then
			self._exit_attract_mode(self)
		end
	else
		self._attract_mode_timer = self._attract_mode_timer - dt

		if self._attract_mode_timer <= 0 then
			self._enter_attract_mode(self)
		end
	end

	return 
end
StateTitleScreenMain._enter_attract_mode = function (self)
	Managers.music:stop_all_sounds()
	self._title_start_ui:enter_attract_mode()
	self.parent:enter_attract_mode(true)

	return 
end
StateTitleScreenMain._exit_attract_mode = function (self)
	Managers.music:stop_all_sounds()
	Managers.music:trigger_event("Play_menu_screen_music")

	self._attract_mode_timer = ATTRACT_MODE_TIMER
	self._attract_mode_active = false

	Managers.transition:force_fade_in()
	Managers.transition:fade_out(1)
	self._title_start_ui:exit_attract_mode()
	self.parent:enter_attract_mode(false)

	return 
end
StateTitleScreenMain._update_input = function (self, dt, t)
	local platform = Application.platform()

	if platform == "ps4" and Managers.invite:has_invitation() and not self._state then
		Managers.music:trigger_event("hud_menu_start_game")

		if PS4.signed_in() then
			self._state = StateTitleScreenLoadSave
		else
			assert(false, "[StateTitleScreenMain] Not signed in to PSN.")
		end
	end

	if (self._title_start_ui:should_start() or LEVEL_EDITOR_TEST or self._auto_start or GameSettingsDevelopment.skip_start_screen) and not self._state then
		if self._title_start_ui:attract_mode() then
			self._exit_attract_mode(self)
		elseif platform == "win32" then
			if not GameSettingsDevelopment.skip_start_screen then
				Managers.music:trigger_event("hud_menu_start_game")
			end

			self._state = StateTitleScreenInitNetwork
		elseif platform == "xb1" then
			Managers.music:trigger_event("hud_menu_start_game")

			local controller = Managers.input:get_most_recent_device()
			local user_id = controller and controller.user_id()

			if user_id and Managers.account:sign_in(user_id, controller) then
				self._state = StateTitleScreenLoadSave
			elseif controller and string.match(controller._name, "Pad") then
				local index = tonumber(string.gsub(controller._name, "Pad", ""), 10)

				XboxLive.show_account_picker(index)
			end
		elseif platform == "ps4" then
			Managers.music:trigger_event("hud_menu_start_game")

			if PS4.signed_in() then
				self._state = StateTitleScreenLoadSave
			else
				assert(false, "[StateTitleScreenMain] Not signed in to PSN.")
			end
		end
	end

	return 
end
StateTitleScreenMain._next_state = function (self)
	if self._state then
		return self._state
	end

	return 
end
StateTitleScreenMain.on_exit = function (self)
	self._title_start_ui:destroy()
	Managers.music:trigger_event("Stop_menu_screen_music")

	return 
end

return 
