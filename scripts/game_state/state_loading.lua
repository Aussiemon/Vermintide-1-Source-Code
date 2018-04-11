-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
require("scripts/game_state/loading_sub_states/win32/state_loading_running")
require("scripts/game_state/loading_sub_states/win32/state_loading_restart_network")
require("scripts/game_state/loading_sub_states/win32/state_loading_migrate_host")
require("scripts/settings/level_settings")

StateLoading = class(StateLoading)
StateLoading.NAME = "StateLoading"
local CHAT_INPUT_DEFAULT_COMMAND = "say"
local MAX_CHAT_INPUT_CHARS = 150
local DO_RELOAD = true
local ALWAYS_LOAD_ALL_VIEWS = script_data.always_load_all_views or Development.parameter("always_load_all_views")
StateLoading.round_start_auto_join = 10
StateLoading.round_start_join_allowed = 20
StateLoading.join_lobby_timeout = 120
LOBBY_PORT_INCREMENT = LOBBY_PORT_INCREMENT or 0

local function check_bool_string(text)
	if text == "false" then
		return false
	else
		return text
	end

	return 
end

StateLoading.on_enter = function (self, param_block)
	print("[Gamestate] Enter state StateLoading")

	if not Managers.play_go:installed() then
		Managers.play_go:set_install_speed("suspended")
	end

	if PLATFORM == "xb1" then
		Application.set_kinect_enabled(true)
	end

	if PLATFORM == "win32" then
		Application.set_time_step_policy("throttle", 60)
	end

	self._registered_rpcs = false

	self._setup_garbage_collection(self)
	self._setup_world(self)
	self._setup_input(self)
	self._parse_loading_context(self)
	self._create_loading_view(self)
	self._setup_first_time_ui(self)
	self._setup_init_network_view(self)
	Managers.popup:set_input_manager(self._input_manager)
	Managers.chat:set_input_manager(self._input_manager)
	Managers.account:reset_popups()
	self._setup_level_transition(self)
	self._setup_state_machine(self)
	self._unmute_all_world_sounds(self)
	Managers.transition:hide_icon_background()
	Managers.transition:fade_out(GameSettings.transition_fade_out_speed)
	Managers.light_fx:set_lightfx_color_scheme("loading")

	self._loading_view_setup_done = false
	self._menu_setup_done = false

	if PLATFORM == "xb1" and self._lobby_host then
		Managers.account:set_round_id()
		Managers.account:update_popup_status()
	end

	if PLATFORM == "ps4" then
		Managers.account:set_realtime_multiplay_state("loading", true)
	end

	if self._network_client then
		self._network_client.voip:set_input_manager(self._input_manager)
	end

	if self._network_server then
		self._network_server.voip:set_input_manager(self._input_manager)
	end

	if self.parent.loading_context.finished_tutorial then
		self.parent.loading_context.finished_tutorial = nil
		self.parent.loading_context.show_profile_on_startup = true

		if not Managers.play_go:installed() then
			self._wanted_state = StateTitleScreen
			self.parent.loading_context.skip_signin = true
			self._teardown_network = true
		end
	end

	return 
end
StateLoading._setup_input = function (self)
	self._input_manager = InputManager:new()
	Managers.input = self._input_manager

	self._input_manager:initialize_device("keyboard", 1)
	self._input_manager:initialize_device("mouse", 1)
	self._input_manager:initialize_device("gamepad", 1)

	local platform = PLATFORM
	local loaded_player_controls = PlayerData.controls and PlayerData.controls.Player
	local player_control_keymap = table.clone(PlayerControllerKeymaps)

	if loaded_player_controls and loaded_player_controls.keymap then
		table.merge_recursive(player_control_keymap[platform], loaded_player_controls.keymap)
	end

	local player_control_filters = table.clone(PlayerControllerFilters)

	if loaded_player_controls and loaded_player_controls.filters then
		table.merge_recursive(player_control_filters[platform], loaded_player_controls.filters)
	end

	self._input_manager:create_input_service("Player", "PlayerControllerKeymaps", "PlayerControllerFilters")
	self._input_manager:map_device_to_service("Player", "keyboard")
	self._input_manager:map_device_to_service("Player", "mouse")
	self._input_manager:map_device_to_service("Player", "gamepad")

	return 
end
StateLoading._parse_loading_context = function (self)
	local loading_context = self.parent.loading_context

	if loading_context then
		self._network_server = loading_context.network_server
		self._network_client = loading_context.network_client
		self._lobby_host = loading_context.lobby_host
		self._lobby_client = loading_context.lobby_client
		self._checkpoint_data = loading_context.checkpoint_data
	end

	return 
end
StateLoading._setup_garbage_collection = function (self)
	local assert_on_leak = true

	GarbageLeakDetector.run_leak_detection(assert_on_leak)
	GarbageLeakDetector.register_object(self, "StateLoadingRunning")

	return 
end
StateLoading._setup_world = function (self)
	self._world_name = "loading_world"
	self._viewport_name = "loading_viewport"
	self._world = Managers.world:create_world(self._world_name, GameSettingsDevelopment.default_environment, nil, nil, Application.DISABLE_PHYSICS, Application.DISABLE_APEX_CLOTH)
	self._viewport = ScriptWorld.create_viewport(self._world, self._viewport_name, "overlay", 1)

	return 
end
StateLoading._setup_init_network_view = function (self)

	-- decompilation error in this vicinity
	require("scripts/game_state/state_ingame")

	self._wanted_state = StateIngame

	return 
end
StateLoading._setup_first_time_ui = function (self)
	local loading_context = self.parent.loading_context

	if (loading_context.first_time or loading_context.gamma_correct or loading_context.play_trailer) and not GameSettingsDevelopment.disable_intro_trailer then
		local auto_skip = nil
		local params = {}
		local platform = PLATFORM

		if platform == "win32" then
			local level_name = (Boot.loading_context and Boot.loading_context.level_key) or LevelSettings.default_start_level
		elseif platform == "ps4" or platform == "xb1" then
			local level_name = (Boot.loading_context and Boot.loading_context.level_key) or LevelSettings.default_start_level

			if not check_bool_string(Development.parameter("auto_host_level")) then
			end

			auto_skip = level_name ~= LevelSettings.default_start_level
			auto_skip = loading_context.join_lobby_data or Development.parameter("auto_join") or auto_skip or Development.parameter("skip_splash")
			params.gamma = loading_context.gamma_correct
			params.trailer = loading_context.play_trailer

			if params.gamma or params.trailer then
				auto_skip = false
			end
		end

		if loading_context.gamma_correct then
			local package_name = "resource_packages/title_screen_gamma"
			local reference_name = "state_splash_screen"
			local package_manager = Managers.package

			if not package_manager.has_loaded(package_manager, package_name, reference_name) then
				package_manager.load(package_manager, package_name, reference_name)
			end
		end

		print("[StateLoading] Auto Skip: ", auto_skip)

		loading_context.gamma_correct = nil
		loading_context.play_trailer = nil
		self._first_time_view = TitleLoadingUI:new(self._world, params, auto_skip)

		Managers.transition:hide_loading_icon()
		Managers.chat:enable_gui(false)
		self._loading_view:deactivate()
	end

	loading_context.first_time = nil

	return 
end
StateLoading._unmute_all_world_sounds = function (self)
	Managers.music:trigger_event("unmute_all_world_sounds")

	return 
end
StateLoading._get_game_difficulty = function (self)
	local stored_lobby_data = (self._lobby_host and self._lobby_host:get_stored_lobby_data()) or (self._lobby_client and self._lobby_client:get_stored_lobby_data()) or nil

	return (stored_lobby_data and stored_lobby_data.difficulty) or nil
end
StateLoading._create_loading_view = function (self, level_key, act_progression_index)
	local game_difficulty = self._get_game_difficulty(self)
	local ui_context = {
		world = self._world,
		input_manager = self._input_manager,
		level_key = level_key,
		game_difficulty = game_difficulty,
		world_manager = Managers.world,
		chat_manager = Managers.chat,
		profile_synchronizer = self._profile_synchronizer,
		act_progression_index = act_progression_index
	}
	self._loading_view = LoadingView:new(ui_context)

	return 
end
StateLoading._trigger_loading_view = function (self, level_key, act_progression_index)
	level_key = level_key or self._level_transition_handler:default_level_key()

	if not Development.parameter("gdc") then
		self._wwise_event = self._trigger_sound_events(self, level_key)

		self._loading_view:trigger_subtitles(self._wwise_event, Managers.time:time("main"))
	end

	local event_name = "Play_loading_screen_music"

	if act_progression_index and 1 <= act_progression_index and act_progression_index < 4 then
		event_name = event_name .. "_act" .. act_progression_index
	elseif act_progression_index and 4 <= act_progression_index then
		event_name = event_name .. "_finished"
	end

	Managers.music:trigger_event(event_name)

	self._activate_loading_view = true

	Managers.transition:hide_icon_background()
	Managers.transition:force_fade_in()

	return 
end
StateLoading.setup_loading_view = function (self, level_key)
	self._level_key = level_key or self._level_transition_handler:default_level_key()
	local package_manager = Managers.package
	local old_ui_package_name = self._ui_package_name
	local new_ui_package_name = LevelSettings[self._level_key].loading_ui_package_name
	local same_package = old_ui_package_name == new_ui_package_name
	local has_loaded_old = old_ui_package_name and package_manager.has_loaded(package_manager, old_ui_package_name, "global_loading_screens")
	local is_loading_old = old_ui_package_name and package_manager.is_loading(package_manager, old_ui_package_name)
	local unload = (not same_package and has_loaded_old) or is_loading_old

	if unload then
		package_manager.unload(package_manager, old_ui_package_name, "global_loading_screens")
	end

	local act_progression_index = nil

	if self._level_key == "inn_level" then
		act_progression_index = LevelUnlockUtils.current_act_progression_raw()
		local has_multiple_loading_images = LevelSettings[self._level_key].has_multiple_loading_images

		if has_multiple_loading_images and act_progression_index and 1 <= act_progression_index then
			new_ui_package_name = new_ui_package_name .. "_" .. act_progression_index
		end
	end

	has_loaded_new = new_ui_package_name and package_manager.has_loaded(package_manager, new_ui_package_name, "global_loading_screens")
	local is_loading_new = new_ui_package_name and package_manager.is_loading(package_manager, new_ui_package_name)

	if not has_loaded_new and not is_loading_new then
		package_manager.load(package_manager, new_ui_package_name, "global_loading_screens", callback(self, "cb_loading_screen_loaded", self._level_key, act_progression_index), true, true)
	elseif has_loaded_new then
		self.cb_loading_screen_loaded(self, self._level_key, act_progression_index, true)
	end

	self._ui_package_name = new_ui_package_name
	self._loading_view_setup_done = true

	return 
end
StateLoading.loading_view_setup_done = function (self)
	return self._loading_view_setup_done
end
StateLoading.setup_menu_assets = function (self)
	local reference_name = "menu_assets"
	local package_name_ingame = "resource_packages/menu_assets"
	local package_name_inn = (PLATFORM == "win32" and "resource_packages/menu_assets_inn") or "resource_packages/menu_assets_inn_console"
	local package_manager = Managers.package
	local ingame_package_loaded = package_manager.has_loaded(package_manager, package_name_ingame, reference_name) or package_manager.is_loading(package_manager, package_name_ingame, reference_name)
	local inn_package_loaded = package_manager.has_loaded(package_manager, package_name_inn, reference_name) or package_manager.is_loading(package_manager, package_name_inn, reference_name)
	local load_package_path = nil

	if ALWAYS_LOAD_ALL_VIEWS then
		local package_manager = Managers.package

		if not ingame_package_loaded then
			load_package_path = package_name_ingame
		end

		if not inn_package_loaded then
			load_package_path = package_name_inn
		end

		package_manager.load(package_manager, package_name_ingame, reference_name, nil, true, true)
		package_manager.load(package_manager, package_name_inn, reference_name, nil, true, true)
	else
		should_load_inn_package = self._level_key == "inn_level"

		if should_load_inn_package then
			if ingame_package_loaded then
				package_manager.unload(package_manager, package_name_ingame, reference_name)
			end

			if not inn_package_loaded then
				load_package_path = package_name_inn
			end
		else
			if inn_package_loaded then
				package_manager.unload(package_manager, package_name_inn, reference_name)
			end

			if not ingame_package_loaded then
				load_package_path = package_name_ingame
			end
		end

		self._menu_setup_done = true

		if load_package_path then
			package_manager.load(package_manager, load_package_path, reference_name, nil, true, true)

			self._ui_loading_package_reference_name = reference_name
			self._ui_loading_package_path = load_package_path
		end
	end

	return 
end
StateLoading.menu_assets_setup_done = function (self)
	return self._menu_setup_done
end
StateLoading.unload_first_time_view_packages = function (self)
	local package_manager = Managers.package
	local package_name = "resource_packages/title_screen_gamma"
	local reference_name = "state_splash_screen"

	if package_manager.has_loaded(package_manager, package_name, reference_name) then
		package_manager.unload(package_manager, package_name, reference_name)
	end

	return 
end
StateLoading.cb_loading_screen_loaded = function (self, level_key, act_progression_index, skip_fade)
	if self._first_time_view then
		local game_difficulty = self._get_game_difficulty(self)

		self._loading_view:texture_resource_loaded(level_key, act_progression_index, game_difficulty)
	elseif skip_fade then
		self.cb_loading_screen_change_fade(self, level_key, act_progression_index, skip_fade)
	else
		Managers.transition:fade_in(3, callback(self, "cb_loading_screen_change_fade", level_key, act_progression_index))
	end

	return 
end
StateLoading.cb_loading_screen_change_fade = function (self, level_key, act_progression_index, skip_fade)
	if self._loading_view then
		local game_difficulty = self._get_game_difficulty(self)

		self._loading_view:texture_resource_loaded(level_key, act_progression_index, game_difficulty)
		self._trigger_loading_view(self, level_key, act_progression_index)

		if not skip_fade then
			Managers.transition:fade_out(3)
		end
	end

	return 
end
StateLoading._trigger_sound_events = function (self, level_key)
	local level_settings = LevelSettings[level_key]
	local wwise_events = level_settings.loading_screen_wwise_events

	if wwise_events ~= nil then
		local wwise_event = wwise_events[math.random(1, #wwise_events)]
		local wwise_playing_id, wwise_source_id = Managers.music:trigger_event(wwise_event)
		self.wwise_playing_id = wwise_playing_id

		return wwise_event
	end

	return 
end
StateLoading._setup_state_machine = function (self)
	local params = {
		world = self._world,
		viewport = self._viewport,
		loading_view = self._loading_view,
		level_transition_handler = self._level_transition_handler
	}

	if self.parent.loading_context.restart_network then
		self._machine = GameStateMachine:new(self, StateLoadingRestartNetwork, params, true)
	elseif self.parent.loading_context.host_migration_info then
		self._machine = GameStateMachine:new(self, StateLoadingMigrateHost, params, true)
	else
		self._machine = GameStateMachine:new(self, StateLoadingRunning, params, true)
	end

	return 
end
StateLoading._handle_do_reload = function (self)
	if DO_RELOAD and self._wwise_event then
		Managers.music:trigger_event(self._wwise_event)

		DO_RELOAD = false
	end

	return 
end
StateLoading.update = function (self, dt, t)
	if script_data.subtitle_debug then
		self._handle_do_reload(self)
	end

	Network.update_receive(dt, self._network_event_delegate.event_table)
	self._update_network(self, dt)

	if PLATFORM == "ps4" and not self._popup_id and not self._handled_psn_client_error and self._level_transition_handler:all_packages_loaded() and Managers.backend:profiles_loaded() and self.global_packages_loaded(self) then
		local psn_client_error = Managers.account:psn_client_error()

		if psn_client_error then
			printf("[StateLoading] PSN CLIENT ERROR %s", psn_client_error)
			self.create_popup(self, "failure_psn_client_error", "popup_error_topic", "restart_as_server", "menu_accept")

			self._handled_psn_client_error = true
			self._wanted_state = StateTitleScreen
		end
	end

	Managers.backend:update(dt)
	Managers.input:update(dt)
	self._level_transition_handler:update(dt)
	Managers.music:update(dt)

	if Managers.voice_chat then
		Managers.voice_chat:update(dt, t)
	end

	if self._first_time_view then
		self._first_time_view:update(dt)
	elseif self._loading_view then
		if self._activate_loading_view then
			self._loading_view:activate()
			Managers.transition:fade_out(GameSettings.transition_fade_out_speed)

			self._activate_loading_view = nil
		end

		self._loading_view:update(dt)
	end

	self._update_loading_screen(self, dt, t)
	self._machine:update(dt, t)
	self._update_lobbies(self, dt, t)

	if Managers.matchmaking then
		Managers.matchmaking:update(dt, t)
	end

	Managers.chat:update(dt, t, false, nil)
	Network.update_transmit(dt)

	return self._try_next_state(self)
end
StateLoading._update_network = function (self, dt)
	if self._network_server then
		self._network_server:update(dt)
	elseif self._network_client then
		self._network_client:update(dt)

		if self._network_client:is_in_post_game() and not self._in_post_game_popup_id and not self._in_post_game_popup_shown then
			self._in_post_game_popup_id = Managers.popup:queue_popup(Localize("popup_is_in_post_game"), Localize("matchmaking_status_waiting_for_host"), "return_to_inn", Localize("return_to_inn"))
			self._in_post_game_popup_shown = true

			Managers.popup:activate_timer(self._in_post_game_popup_id, 200, "timeout", "center", false, function (timer)
				return string.format(Localize("timer_max_time") .. ": %.2d:%.2d", (timer / 60) % 60, timer % 60)
			end, 28)
		elseif not self._network_client:is_in_post_game() and self._in_post_game_popup_id then
			Managers.popup:cancel_popup(self._in_post_game_popup_id)

			self._in_post_game_popup_id = nil
		end

		local bad_state = self._network_client.state == "denied_enter_game" or self._network_client.state == "lost_connection_to_host"

		if bad_state and not self._popup_id and not self._permission_to_go_to_next_state then
			self._wanted_state = StateTitleScreen

			self.create_popup(self, self._network_client.fail_reason or "fail reason is nil", "popup_error_topic", "restart_as_server", "menu_accept")

			if PLATFORM == "ps4" then
				self._network_client:destroy()

				self._network_client = nil

				self._destroy_lobby_client(self)

				if self._in_post_game_popup_id then
					Managers.popup:cancel_popup(self._in_post_game_popup_id)

					self._in_post_game_popup_id = nil
				end
			end
		end
	end

	return 
end
StateLoading._update_lobbies = function (self, dt, t)
	if not self.global_packages_loaded(self) then
		return 
	end

	if self._network_transmit then
		self._network_transmit:transmit_local_rpcs()
	end

	if self._lobby_host then
		local lobby_host = self._lobby_host
		local old_state = lobby_host.state

		lobby_host.update(lobby_host, dt)

		if old_state ~= lobby_host.state and lobby_host.state == LobbyState.JOINED then
			local lobby_host = self._lobby_host

			self.setup_chat_manager(self, lobby_host, lobby_host.lobby_host(lobby_host), Network.peer_id(), true)

			if not self._network_server then
				self.host_joined(self)
			end
		elseif self._lobby_host.state == LobbyState.FAILED and not self._popup_id then
			local text_id = nil

			if PLATFORM == "win32" then
				if rawget(_G, "Steam") then
					if Steam.connected() then
						text_id = "failure_start_steam_lobby_create"
					else
						text_id = "failure_start_no_steam"
					end
				else
					text_id = "failure_start_no_lan"
				end
			elseif PLATFORM == "xb1" then
				if not Network.xboxlive_client_exists() then
					text_id = "failure_start_xbox_live_client"
				else
					text_id = "failure_start_xbox_lobby_create"
				end
			elseif PLATFORM == "ps4" then
				text_id = "failure_start_psn_lobby_create"
			else
				text_id = "failure_start"
			end

			self._destroy_lobby_host(self)

			if self._network_server then
				self._network_server:disconnect_all_peers("unknown_error")
				self._network_server:destroy()

				self._network_server = nil
			end

			self.create_popup(self, text_id, "popup_error_topic", "restart_as_server", "menu_accept")
		end
	elseif self._lobby_finder then
		self._update_lobby_join(self, dt, t)
	elseif self._lobby_client then
		self._lobby_client:update(dt)

		local new_lobby_state = self._lobby_client.state

		if self._handle_new_lobby_connection and new_lobby_state == LobbyState.JOINED then
			local host = self._lobby_client:lobby_host()
			local lobby_data = self._lobby_client.stored_lobby_data
			local lobby_id = lobby_data.id
			local lobby_network_hash = lobby_data.network_hash or self._lobby_client.lobby:data("network_hash") or LobbyInternal.get_lobby_data_from_id_by_key(lobby_id, "network_hash")
			local ready_to_compare_hashes = host ~= "0" and lobby_network_hash and self._popup_id == nil

			if ready_to_compare_hashes then
				local client_network_hash = self._lobby_client.network_hash

				if client_network_hash == lobby_network_hash then
					self.setup_network_client(self, self._joined_matchmaking_lobby)
					self.setup_chat_manager(self, self._lobby_client, host, Network.peer_id(), false)
				else
					self._destroy_lobby_client(self)
					self.create_popup(self, "failure_start_join_server_incorrect_hash", "popup_error_topic", "restart_as_server", "menu_accept", client_network_hash, lobby_network_hash)
				end
			end
		elseif new_lobby_state == LobbyState.FAILED and not self._popup_id then
			self._destroy_lobby_client(self)
			self.create_popup(self, "failure_start_join_server", "popup_error_topic", "restart_as_server", "menu_accept")
			Managers.transition:fade_out(GameSettings.transition_fade_out_speed)
		end
	end

	if PLATFORM == "xb1" and self._waiting_for_cleanup and Managers.account:all_lobbies_freed() then
		self.setup_join_lobby(self, true)

		self._waiting_for_cleanup = nil
	end

	return 
end
StateLoading._destroy_lobby_client = function (self)
	self._lobby_client:destroy()

	self._lobby_client = nil
	self.parent.loading_context.lobby_client = nil

	Managers.account:set_current_lobby(nil)

	self._wanted_state = StateTitleScreen

	return 
end
StateLoading._destroy_lobby_host = function (self)
	self._lobby_host:destroy()

	self._lobby_host = nil
	self.parent.loading_context.lobby_host = nil

	Managers.account:set_current_lobby(nil)

	if Managers.matchmaking then
		if self._registered_rpcs then
			Managers.matchmaking:unregister_rpcs()
		end

		Managers.matchmaking:destroy()

		Managers.matchmaking = nil
	end

	self._wanted_state = StateTitleScreen

	return 
end
StateLoading._update_lobby_join = function (self, dt, t)
	local unique_server_name = Development.parameter("unique_server_name")
	local found = false
	local lobby_finder = self._lobby_finder

	lobby_finder.update(lobby_finder, dt)

	local lobbies = lobby_finder.lobbies(lobby_finder)

	for i, lobby in ipairs(lobbies) do
		local auto_join_this_lobby = false

		if not self._lobby_to_join and not self._host_to_join and unique_server_name and lobby.unique_server_name == unique_server_name then
			auto_join_this_lobby = true
		elseif self._lobby_to_join and self._lobby_to_join == lobby.id then
			auto_join_this_lobby = true
		elseif self._host_to_join and (self._host_to_join == lobby.host or self._host_to_join == lobby.Host) then
			auto_join_this_lobby = true
		end

		if lobby.valid and auto_join_this_lobby then
			self._load_level(self, lobby.level_key)

			self._lobby_client = LobbyClient:new(self._network_options, lobby)
			self._lobby_finder = nil
			self._handle_new_lobby_connection = true
			found = true

			Managers.account:set_current_lobby(self._lobby_client.lobby)

			if self._lobby_joined_callback then
				self._lobby_joined_callback()

				self._lobby_joined_callback = nil
			end

			break
		end
	end

	if not found and self._lobby_finder_timeout < t and not self._popup_id then
		self._lobby_finder = nil
		local name = self._host_to_join_name or Development.parameter("unique_server_name")

		self.create_popup(self, "failure_start_join_server_timeout", "failure_find_host", "restart_as_server", "menu_accept", name)

		self._wanted_state = StateTitleScreen
	end

	return 
end
StateLoading._update_loading_screen = function (self, dt, t)
	local permission_to_go_to_next_state = nil

	if self._network_server then
		local lobby_host = self._lobby_host

		if lobby_host and lobby_host.state == LobbyState.JOINED then
			permission_to_go_to_next_state = true
		end
	elseif self._network_client and self._network_client.state == "waiting_enter_game" then
		permission_to_go_to_next_state = true
	end

	if self._network_server then
		local peer_id = Network.peer_id()
		local local_player_id = 1
		local profile_synchronizer = self._network_server.profile_synchronizer
		local profile_index = (profile_synchronizer and profile_synchronizer.profile_by_peer(profile_synchronizer, peer_id, local_player_id)) or nil

		if not profile_index then
			permission_to_go_to_next_state = false
		end
	end

	local waiting_for_vo = false

	if script_data.subtitle_debug then
		local skip = Mouse.button(Mouse.button_index("left")) == 1 and Mouse.button(Mouse.button_index("right")) == 1
		waiting_for_vo = not skip

		if permission_to_go_to_next_state and waiting_for_vo then
			Debug.text("[SubtitleDebug] Waiting for both mouse buttons to progress...")
		end
	end

	if permission_to_go_to_next_state and not self._permission_to_go_to_next_state and not waiting_for_vo then
		local level_name = self._level_transition_handler:get_current_level_keys()
		local level_index = NetworkLookup.level_keys[level_name]

		if self._network_server then
			self._network_server:rpc_level_loaded(Network.peer_id(), level_index)
		end

		self._permission_to_go_to_next_state = permission_to_go_to_next_state
	end

	return 
end
StateLoading._try_next_state = function (self)
	if self._popup_id then
		self._handle_popup(self)
	end

	if self._join_popup_id then
		self._handle_join_popup(self)
	end

	if self._in_post_game_popup_id and not Managers.account:leaving_game() then
		self._handle_in_post_game_popup(self)
	elseif self._in_post_game_popup_id then
		Managers.popup:cancel_popup(self._in_post_game_popup_id)
	end

	if Managers.account:leaving_game() then
		if not self._ui_package_name or (self._ui_package_name and Managers.package:has_loaded(self._ui_package_name)) then
			if self._first_time_view then
				self._first_time_view:destroy()

				self._first_time_view = nil

				self.unload_first_time_view_packages(self)
			end

			Managers.transition:show_loading_icon()

			Managers.transition._callback = nil

			Managers.transition:force_fade_in()

			self._teardown_network = true
			self._new_state = StateTitleScreen
		end
	elseif not self._transitioning then
		local ui_done = true

		if self._first_time_view then
			ui_done = self._first_time_view:is_done()

			if ui_done and not self._popup_id and not self._packages_loaded(self) and self._level_key then
				self._trigger_loading_view(self)
				Managers.transition:show_loading_icon()
				self._first_time_view:destroy()

				self._first_time_view = nil

				self.unload_first_time_view_packages(self)
				Managers.chat:enable_gui(true)
			end
		elseif self._loading_view then
			ui_done = self._loading_view:is_done()
		end

		if Managers.backend:is_disconnected() and not self._popup_id then
			self._backend_broken(self)
		end

		if Managers.backend:is_waiting_for_user_input() then
			return 
		end

		local packages_loaded = self._packages_loaded(self)
		local can_go_to_next_state = self._wanted_state and ui_done and not self._popup_id

		if can_go_to_next_state then
			local ready_to_go_to_next_state = self._permission_to_go_to_next_state and packages_loaded and Managers.unlock:done()
			local backend_is_disconnected = Managers.backend:is_disconnected()

			if ready_to_go_to_next_state or backend_is_disconnected then
				if Managers.transition:fade_state() == "out" then
					Managers.transition:fade_in(GameSettings.transition_fade_out_speed)
					printf("[StateLoading] started fadeing in, want to go to state:%s", self._wanted_state.NAME)
				elseif Managers.transition:fade_in_completed() then
					self._new_state = self._wanted_state

					if self._join_popup_id then
						Managers.popup:cancel_popup(self._join_popup_id)

						self._join_popup_id = nil
					end
				end
			end
		end
	end

	if (Managers.popup:has_popup() or Managers.account:user_detached()) and not Managers.account:leaving_game() then
		return 
	end

	Managers.popup:cancel_all_popups()

	return self._new_state
end
StateLoading._handle_popup = function (self)
	local result = Managers.popup:query_result(self._popup_id)

	if result == "continue" then
		self._popup_id = nil
	elseif result == "restart_as_server" then
		self._teardown_network = true
		self._popup_id = nil
		self._permission_to_go_to_next_state = true

		if self._first_time_view then
			self._first_time_view:force_done()
		end
	elseif result == "quit" then
		Boot.quit_game = true
		self._teardown_network = true
		self._popup_id = nil
		self._permission_to_go_to_next_state = true

		if self._first_time_view then
			self._first_time_view:force_done()
		end
	elseif result then
		print(string.format("[StateLoading:_handle_popup] No such result handled (%s)", result))
	end

	return 
end
StateLoading._handle_join_popup = function (self)
	local result = Managers.popup:query_result(self._join_popup_id)

	if result == "cancel" then
		Managers.popup:cancel_popup(self._join_popup_id)

		self._teardown_network = true
		self._join_popup_id = nil
		self._permission_to_go_to_next_state = true

		if self._first_time_view then
			self._first_time_view:force_done()
		end

		self._new_state = StateTitleScreen
	elseif result == "timeout" then
		Managers.popup:cancel_popup(self._join_popup_id)

		self._join_popup_id = nil
	elseif result then
		print(string.format("[StateLoading:_handle_join_popup] No such result handled (%s)", result))
	end

	return 
end
StateLoading._handle_in_post_game_popup = function (self)
	local result = Managers.popup:query_result(self._in_post_game_popup_id)

	if result then
		if result == "return_to_inn" then
			self._teardown_network = true
			self._restart_network = true
			self._permission_to_go_to_next_state = true

			if self._first_time_view then
				self._first_time_view:force_done()
			end

			self._wanted_state = StateLoading
		end

		self._in_post_game_popup_id = nil
	end

	return 
end
StateLoading._backend_broken = function (self)
	print("[StateLoading] Backend_broken, returning to StateTitleScreen")

	self._wanted_state = StateTitleScreen
	self._teardown_network = true
	self._permission_to_go_to_next_state = true

	if self._first_time_view then
		self._first_time_view:force_done()
	end

	if PLATFORM == "xb1" then
		Managers.account:initiate_leave_game()
	end

	return 
end
StateLoading._set_packages_loaded = function (self)
	self._packages_loaded = true

	return 
end
StateLoading.on_exit = function (self, application_shutdown)
	if PLATFORM == "win32" then
		local max_fps = Application.user_setting("max_fps")

		if max_fps == nil or max_fps == 0 then
			Application.set_time_step_policy("no_throttle")
		else
			Application.set_time_step_policy("throttle", max_fps)
		end
	end

	if self._registered_rpcs then
		self._unregister_rpcs(self)
	end

	local skip_signin = self.parent.loading_context.skip_signin

	if application_shutdown then
		self._destroy_network(self)
	elseif self._teardown_network then
		self._destroy_network(self)
	else
		local loading_context = {
			level_transition_handler = self._level_transition_handler,
			network_transmit = self._network_transmit,
			checkpoint_data = self._checkpoint_data
		}

		if self._lobby_host then
			loading_context.lobby_host = self._lobby_host
			local level_key = self._level_transition_handler:get_current_level_keys()
			local stored_lobby_host_data = self._lobby_host:get_stored_lobby_data() or {}
			stored_lobby_host_data.level_key = level_key
			stored_lobby_host_data.unique_server_name = stored_lobby_host_data.unique_server_name or LobbyAux.get_unique_server_name()
			stored_lobby_host_data.host = stored_lobby_host_data.host or Network.peer_id()
			stored_lobby_host_data.num_players = stored_lobby_host_data.num_players or 1
			stored_lobby_host_data.country_code = rawget(_G, "Steam") and Steam.user_country_code()

			self._lobby_host:set_lobby_data(stored_lobby_host_data)

			loading_context.network_server = self._network_server

			self._network_server:unregister_rpcs()
			self._network_server.voip:set_input_manager(nil)
		else
			loading_context.lobby_client = self._lobby_client
			loading_context.network_client = self._network_client

			self._network_client:unregister_rpcs()
			self._network_client.voip:set_input_manager(nil)
		end

		loading_context.show_profile_on_startup = self.parent.loading_context.show_profile_on_startup
		local difficulty = self._get_game_difficulty(self)
		loading_context.difficulty = difficulty
		self.parent.loading_context = loading_context
	end

	self._profile_synchronizer = nil

	if self._network_event_delegate then
		self._network_event_delegate:destroy()

		self._network_event_delegate = nil
	end

	Managers.state:destroy()

	if self._first_time_view then
		self._first_time_view:destroy()

		self._first_time_view = nil

		self.unload_first_time_view_packages(self)
	end

	if self._loading_view then
		self._loading_view:destroy()

		self._loading_view = nil
	end

	self._machine:destroy(application_shutdown)

	if self.parent.loading_context then
		self.parent.loading_context.host_to_migrate_to = nil
		self.parent.loading_context.restart_network = nil
		self.parent.loading_context.players = nil
		self.parent.loading_context.local_player_index = nil
		self.parent.loading_context.skip_signin = skip_signin

		if self._restart_network then
			self.parent.loading_context.restart_network = true
		end
	end

	local package_manager = Managers.package

	if self._ui_package_name and (package_manager.has_loaded(package_manager, self._ui_package_name, "global_loading_screens") or package_manager.is_loading(package_manager, self._ui_package_name)) then
		package_manager.unload(package_manager, self._ui_package_name, "global_loading_screens")
	end

	ScriptWorld.destroy_viewport(self._world, self._viewport_name)
	Managers.world:destroy_world(self._world)
	Managers.music:trigger_event("Stop_loading_screen_music")

	if application_shutdown or self._popup_id == nil then
		print("StateLoading added a popup right before exiting")
	end

	Managers.popup:cancel_all_popups()
	Managers.popup:remove_input_manager(application_shutdown)
	Managers.chat:set_input_manager(nil)
	Managers.chat:enable_gui(true)

	if not Managers.play_go:installed() then
		Managers.play_go:set_install_speed("slow")
	end

	if PLATFORM == "ps4" then
		Managers.account:set_realtime_multiplay_state("loading", false)
	end

	return 
end
StateLoading._load_global_packages = function (self)
	if not GlobalResources.loaded then
		local package_manager = Managers.package

		for i, name in ipairs(GlobalResources) do
			if not package_manager.has_loaded(package_manager, name) then
				package_manager.load(package_manager, name, "global", nil, true)
			end
		end

		GlobalResources.loaded = true
	end

	return 
end
StateLoading.global_packages_loaded = function (self)
	if not GlobalResources.loaded then
		self._load_global_packages(self)
	end

	local package_manager = Managers.package

	for i, name in ipairs(GlobalResources) do
		if not package_manager.has_loaded(package_manager, name) then
			return false
		end
	end

	return true
end
StateLoading._packages_loaded = function (self)
	if self._level_transition_handler:all_packages_loaded() and Managers.backend:profiles_loaded() then
		if self._network_server and not self._has_sent_level_loaded then
			self._has_sent_level_loaded = true
			local level_name = self._level_transition_handler:get_current_level_keys()
			local level_index = NetworkLookup.level_keys[level_name]

			self._network_server:rpc_level_loaded(Network.peer_id(), level_index)
		end

		local package_manager = Managers.package

		for i, name in ipairs(GlobalResources) do
			if not package_manager.has_loaded(package_manager, name) then
				return false
			end
		end

		if ALWAYS_LOAD_ALL_VIEWS then
			if not package_manager.has_loaded(package_manager, "resource_packages/menu_assets", "menu_assets") then
				return false
			end

			if not package_manager.has_loaded(package_manager, "resource_packages/menu_assets_inn", "menu_assets") then
				return false
			end
		elseif self._ui_loading_package_path and self._ui_loading_package_reference_name and not package_manager.has_loaded(package_manager, self._ui_loading_package_path, self._ui_loading_package_reference_name) then
			return false
		end

		return true
	end

	return 
end
StateLoading._destroy_network = function (self)
	if Managers.matchmaking then
		Managers.matchmaking:destroy()

		Managers.matchmaking = nil
	end

	if self._lobby_finder then
		self._lobby_finder:destroy()

		self._lobby_finder = nil
	end

	if self._lobby_client then
		self._lobby_client:destroy()

		self._lobby_client = nil

		Managers.account:set_current_lobby(nil)
	end

	if self._lobby_host then
		self._lobby_host:destroy()

		self._lobby_host = nil

		Managers.account:set_current_lobby(nil)
	end

	if self._network_server then
		self._network_server:destroy()

		self._network_server = nil
	elseif self._network_client then
		self._network_client:destroy()

		self._network_client = nil
	end

	if rawget(_G, "LobbyInternal") then
		LobbyInternal.shutdown_client()
	end

	Managers.chat:unregister_channel(1)

	self.parent.loading_context = {}

	self._level_transition_handler:release_level_resources(self.get_current_level_keys(self))

	self._level_transition_handler = nil

	if self._network_transmit then
		self._network_transmit:destroy()

		self._network_transmit = nil
	end

	return 
end
StateLoading._load_level = function (self, level_key)
	self._load_global_packages(self)

	local level_key = level_key or self._level_transition_handler:get_next_level_key()

	assert(level_key, "No level key was set")

	local loaded_level_key = self._level_transition_handler:get_current_level_keys()

	if level_key ~= loaded_level_key then
		printf("[StateLoading] Need to unload %s and start load %s", tostring(loaded_level_key), level_key)
		self._level_transition_handler:release_level_resources(loaded_level_key)
		self._level_transition_handler:load_level(level_key)
	end

	return 
end
StateLoading.set_matchmaking = function (self, matchmaking)
	self._joined_matchmaking_lobby = matchmaking

	return 
end
StateLoading.setup_network_options = function (self)
	if not self._network_options then
		self._unique_server_name = Development.parameter("unique_server_name")
		local development_port = Development.parameter("server_port") or GameSettingsDevelopment.network_port
		development_port = development_port + LOBBY_PORT_INCREMENT
		local lobby_port = (LEVEL_EDITOR_TEST and GameSettingsDevelopment.editor_lobby_port) or development_port
		local network_options = {
			project_hash = "bulldozer",
			max_members = 4,
			config_file_name = "global",
			lobby_port = lobby_port
		}
		self._network_options = network_options
	end

	return 
end
StateLoading.network_options = function (self)
	return self._network_options
end
StateLoading._setup_level_transition = function (self)
	local loading_context = self.parent.loading_context

	if loading_context.level_transition_handler then
		self._level_transition_handler = loading_context.level_transition_handler
	else
		self._level_transition_handler = LevelTransitionHandler:new()

		self._level_transition_handler:set_next_level(self._level_transition_handler:default_level_key())
		Managers.account:set_level_transition_handler(self._level_transition_handler)
	end

	return 
end
StateLoading.has_registered_rpcs = function (self)
	return self._registered_rpcs
end
StateLoading.register_rpcs = function (self)
	self._network_event_delegate = NetworkEventDelegate:new()

	self._level_transition_handler:register_rpcs(self._network_event_delegate)

	if Managers.matchmaking then
		Managers.matchmaking:register_rpcs(self._network_event_delegate)
		Managers.matchmaking:setup_post_init_data({})
	end

	Managers.chat:register_network_event_delegate(self._network_event_delegate)

	self._registered_rpcs = true

	return 
end
StateLoading._unregister_rpcs = function (self)
	self._level_transition_handler:unregister_rpcs()

	if Managers.matchmaking then
		Managers.matchmaking:unregister_rpcs()
	end

	Managers.chat:unregister_network_event_delegate(self._network_event_delegate)

	self._registered_rpcs = false

	return 
end
StateLoading.waiting_for_cleanup = function (self)
	return self._waiting_for_cleanup
end
StateLoading.setup_join_lobby = function (self)
	if PLATFORM == "xb1" and not Managers.account:all_lobbies_freed() then
		self._waiting_for_cleanup = true

		return 
	end

	if not self._lobby_client then
		self._lobby_client = LobbyClient:new(self._network_options, self.parent.loading_context.join_lobby_data)
		self.parent.loading_context.join_lobby_data = nil
		self._handle_new_lobby_connection = true

		Managers.account:set_current_lobby(self._lobby_client.lobby)
	end

	return 
end
StateLoading.setup_lobby_finder = function (self, lobby_joined_callback, lobby_to_join, host_to_join)
	if Managers.package:is_loading("resource_packages/inventory", "global") then
		Managers.package:load("resource_packages/inventory", "global")
	end

	self._lobby_finder = LobbyFinder:new(self._network_options, nil, true)
	self._lobby_joined_callback = lobby_joined_callback
	self._lobby_finder_timeout = Managers.time:time("main") + StateLoading.join_lobby_timeout
	self._lobby_to_join = lobby_to_join
	self._host_to_join = host_to_join and host_to_join.peer_id
	self._host_to_join_name = host_to_join and host_to_join.name

	printf("[StateLoading] StateLoading will try to find a lobby with id=%s or host=%s or unique_server_name=%s", tostring(lobby_to_join), tostring(host_to_join), tostring(script_data.unique_server_name))

	if host_to_join then
		self.create_join_popup(self, self._host_to_join_name)
	end

	return 
end
StateLoading.setup_lobby_host = function (self, wait_for_joined_callback)
	local loading_context = self.parent.loading_context

	assert(not loading_context.profile_synchronizer)
	assert(not loading_context.network_server)

	self._lobby_host = LobbyHost:new(self._network_options)
	local level_key = self.get_next_level_key(self)

	if not self.loading_view_setup_done(self) then
		print(debug.traceback())
		self.setup_loading_view(self, level_key)
	end

	if not self.menu_assets_setup_done(self) then
		self.setup_menu_assets(self)
	end

	self._load_level(self, level_key)

	if not wait_for_joined_callback then
		local initial_level = self._level_transition_handler:get_current_level_keys()
		local wanted_profile_index = self.parent.loading_context.wanted_profile_index
		self._network_server = NetworkServer:new(Managers.player, self._lobby_host, initial_level, wanted_profile_index, self._level_transition_handler)
		self._network_transmit = loading_context.network_transmit or NetworkTransmit:new(true, self._network_server.connection_handler)

		self._network_transmit:set_network_event_delegate(self._network_event_delegate)
		self._network_server:register_rpcs(self._network_event_delegate, self._network_transmit)
		self._network_server:server_join()

		self._profile_synchronizer = self._network_server.profile_synchronizer

		self._network_server.voip:set_input_manager(self._input_manager)

		loading_context.network_transmit = self._network_transmit
	end

	Managers.account:set_current_lobby(self._lobby_host.lobby)

	self._waiting_for_joined_callback = wait_for_joined_callback

	return 
end
StateLoading.host_joined = function (self)
	local loading_context = self.parent.loading_context
	local initial_level = self._level_transition_handler:get_current_level_keys()
	local wanted_profile_index = self.parent.loading_context.wanted_profile_index
	self._network_server = NetworkServer:new(Managers.player, self._lobby_host, initial_level, wanted_profile_index, self._level_transition_handler)
	self._network_transmit = loading_context.network_transmit or NetworkTransmit:new(true, self._network_server.connection_handler)

	self._network_transmit:set_network_event_delegate(self._network_event_delegate)
	self._network_server:register_rpcs(self._network_event_delegate, self._network_transmit)
	self._network_server:server_join()

	self._profile_synchronizer = self._network_server.profile_synchronizer

	self._network_server.voip:set_input_manager(self._input_manager)

	loading_context.network_transmit = self._network_transmit

	if self._waiting_for_joined_callback then
		self._waiting_for_joined_callback()

		self._waiting_for_joined_callback = nil
	end

	return 
end
StateLoading.setup_chat_manager = function (self, lobby, host_peer_id, my_peer_id, is_server)
	local network_context = {
		is_server = is_server,
		host_peer_id = host_peer_id,
		my_peer_id = my_peer_id
	}

	Managers.chat:setup_network_context(network_context)

	local function member_func()
		return lobby:members():get_members()
	end

	Managers.chat:register_channel(1, member_func)

	return 
end
StateLoading.setup_network_transmit = function (self, network_handler)
	self._network_transmit = self.parent.loading_context.network_transmit or NetworkTransmit:new(true, network_handler.connection_handler)

	self._network_transmit:set_network_event_delegate(self._network_event_delegate)
	network_handler.register_rpcs(network_handler, self._network_event_delegate, self._network_transmit)

	self.parent.loading_context.network_transmit = self._network_transmit

	return 
end
StateLoading.create_popup = function (self, error, header, action, right_button, ...)
	if Managers.account:leaving_game() then
		return 
	end

	print("StateLoading:create_popup", Script.callstack())

	if self._join_popup_id then
		Managers.popup:cancel_popup(self._join_popup_id)

		self._join_popup_id = nil
	end

	assert(error, "[StateLoading] No error was passed to popup handler")

	local header = header or "popup_error_topic"
	local action = action or "restart_as_server"
	local right_button = right_button or "menu_ok"
	local localized_error = Localize(error)
	localized_error = string.format(localized_error, ...)

	assert(self._popup_id == nil, "Tried to show popup even though we already had one.")

	self._popup_id = Managers.popup:queue_popup(localized_error, Localize(header), action, Localize(right_button))

	return 
end
StateLoading.create_join_popup = function (self, host_name)
	if Managers.account:leaving_game() then
		return 
	end

	local header = Localize("popup_migrating_to_host_header")
	local message = Localize("popup_migrating_to_host_message") .. "\n" .. host_name
	local time = StateLoading.join_lobby_timeout

	assert(self._join_popup_id == nil, "Tried to show popup even though we already had one.")

	self._join_popup_id = Managers.popup:queue_popup(message, header, "cancel", Localize("popup_choice_cancel"))
	local default_result = "timeout"
	local timer_alignment = "center"
	local blink = false

	Managers.popup:activate_timer(self._join_popup_id, time, default_result, timer_alignment, blink)

	return 
end
StateLoading.clear_network_loading_context = function (self)
	local loading_context = self.parent.loading_context

	if loading_context.network_client then
		loading_context.network_client:destroy()

		loading_context.network_client = nil
	end

	if loading_context.network_server then
		loading_context.network_server:destroy()

		loading_context.network_server = nil
	end

	if self._lobby_host then
		self._lobby_host:destroy()

		self._lobby_host = nil
		self.parent.loading_context.lobby_host = nil

		Managers.account:set_current_lobby(nil)
	end

	return 
end
StateLoading.setup_network_client = function (self, clear_peer_state, lobby_client)
	self._lobby_client = lobby_client or self._lobby_client

	if self._lobby_client.lobby == nil then
		self._wanted_state = StateTitleScreen
		self._lobby_client = nil
		self.parent.loading_context.lobby_client = nil

		self.create_popup(self, "failure_start_join_server", "popup_error_topic", "restart_as_server", "menu_accept")

		return false
	end

	Application.warning("Setting up network client")

	local host = self._lobby_client:lobby_host()
	local level_key = self._level_transition_handler:get_current_level_keys()
	local level_index = (level_key and NetworkLookup.level_keys[level_key]) or nil
	local wanted_profile_index = self.parent.loading_context.wanted_profile_index
	self._network_client = NetworkClient:new(self._level_transition_handler, host, level_index, wanted_profile_index, clear_peer_state, self._lobby_client)
	self._network_transmit = NetworkTransmit:new(false, self._network_client.connection_handler)

	self._network_transmit:set_network_event_delegate(self._network_event_delegate)
	self._network_client:register_rpcs(self._network_event_delegate, self._network_transmit)

	self._profile_synchronizer = self._network_client.profile_synchronizer
	self._handle_new_lobby_connection = nil

	self._network_client.voip:set_input_manager(self._input_manager)

	local loading_context = self.parent.loading_context
	loading_context.network_client = self._network_client
	loading_context.network_transmit = self._network_transmit
	loading_context.lobby_client = self._lobby_client
	local lobby = self._lobby_client.lobby

	Managers.account:set_current_lobby(lobby)

	return true
end
StateLoading.get_current_level_keys = function (self)
	return self._level_transition_handler:get_current_level_keys()
end
StateLoading.get_next_level_key = function (self)
	return self._level_transition_handler:get_next_level_key()
end
StateLoading.set_lobby_host_data = function (self, level_key)
	if self._lobby_host then
		local lobby_host = self._lobby_host
		local stored_lobby_host_data = lobby_host.get_stored_lobby_data(lobby_host) or {}
		stored_lobby_host_data.level_key = level_key
		stored_lobby_host_data.matchmaking = (level_key ~= "inn_level" and stored_lobby_host_data.matchmaking) or "false"
		local game_mode = LevelSettings[level_key].game_mode
		stored_lobby_host_data.game_mode = game_mode

		if PLATFORM == "ps4" then
			local region = Managers.account:region()
			local primary, secondary = MatchmakingRegionsHelper.get_matchmaking_regions(region)
			stored_lobby_host_data.primary_region = primary
			stored_lobby_host_data.secondary_region = secondary
		end

		lobby_host.set_lobby_data(lobby_host, stored_lobby_host_data)
	end

	return 
end
StateLoading.start_matchmaking = function (self)
	assert(self._lobby_host)

	local lobby_host = self._lobby_host
	local stored_lobby_host_data = lobby_host.get_stored_lobby_data(lobby_host) or {}
	stored_lobby_host_data.matchmaking = "true"

	lobby_host.set_lobby_data(lobby_host, stored_lobby_host_data)

	return 
end
StateLoading.get_lobby = function (self)
	local lobby = self._lobby_host or self._lobby_client

	return lobby
end

return 
