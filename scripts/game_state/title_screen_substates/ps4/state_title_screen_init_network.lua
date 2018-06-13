require("scripts/network/lobby_host")
require("scripts/network/lobby_client")
require("scripts/network/lobby_finder")
require("scripts/network/lobby_host")
require("scripts/network/lobby_client")
require("scripts/network/lobby_finder")
require("scripts/game_state/components/level_transition_handler")
require("scripts/network/network_event_delegate")
require("scripts/network/network_server")
require("scripts/network/network_client")
require("scripts/network/network_transmit")
require("scripts/ui/views/information_view")
require("scripts/game_state/state_ingame")
require("scripts/network/lobby_psn")

StateTitleScreenInitNetwork = class(StateTitleScreenInitNetwork)
StateTitleScreenInitNetwork.NAME = "StateTitleScreenInitNetwork"
StateTitleScreenInitNetwork.lobby_port_increment = 0

StateTitleScreenInitNetwork.on_enter = function (self, params)
	print("- Enter Substate StateTitleScreenInitNetwork")

	self._params = params
	self._world = params.world
	self._viewport = params.viewport
	self._information_view = InformationView:new(self._world)
	self._network_state = "_state_setup_network"
end

StateTitleScreenInitNetwork.update = function (self, dt, t)
	self[self._network_state](self, dt, t)
	self._information_view:update(dt, t)
	self._level_transition_handler:update()
	Network.update(dt, self._network_event_delegate.event_table)
	Managers.backend:update(dt)
end

StateTitleScreenInitNetwork.on_exit = function (self, application_shutdown)
	if application_shutdown then
		if self._lobby_finder then
			self._lobby_finder:destroy()

			self._lobby_finder = nil
		end

		if self._lobby_client then
			self._lobby_client:destroy()

			self._lobby_client = nil
		end

		if self._lobby_host then
			self._lobby_host:destroy()

			self._lobby_host = nil
		end

		if self._network_server then
			self._network_server:destroy()

			self._network_server = nil
		end

		if self._network_client then
			self._network_client:destroy()

			self._network_client = nil
		end

		if rawget(_G, "LobbyInternal") then
			LobbyInternal.shutdown_client()
		end

		if self._network_transmit then
			self._network_transmit:destroy()

			self._network_transmit = nil
		end

		self.parent.parent.loading_context.network_transmit = nil
	else
		local loading_context = {
			level_transition_handler = self._level_transition_handler,
			network_transmit = self._network_transmit
		}

		if self._lobby_host then
			loading_context.lobby_host = self._lobby_host
			local level_key = self._level_transition_handler:get_current_level_keys()
			local stored_lobby_host_data = self._lobby_host:get_stored_lobby_data() or {}
			stored_lobby_host_data.level_key = level_key
			stored_lobby_host_data.unique_server_name = stored_lobby_host_data.unique_server_name or LobbyAux.get_unique_server_name()
			stored_lobby_host_data.host = stored_lobby_host_data.host or Network.peer_id()
			stored_lobby_host_data.num_players = stored_lobby_host_data.num_players or 1
			stored_lobby_host_data.matchmaking = "false"

			self._lobby_host:set_lobby_data(stored_lobby_host_data)

			loading_context.network_server = self._network_server

			self._network_server:unregister_rpcs()
		end

		if self._lobby_client then
			loading_context.lobby_client = self._lobby_client
			loading_context.network_client = self._network_client

			self._network_client:unregister_rpcs()
		end

		self.parent.parent.loading_context = loading_context
	end

	self._profile_synchronizer = nil

	self._information_view:destroy()

	self._information_view = nil

	self._level_transition_handler:unregister_rpcs()

	if self._network_event_delegate then
		self._network_event_delegate:destroy()

		self._network_event_delegate = nil
	end
end

StateTitleScreenInitNetwork._check_errors = function (self)
	local error_message = ""

	if LobbyInternal.client_lost_context() then
		error_message = error_message .. "- PSN Client lost the network context.\n"
	end

	if self._lobby_host and self._lobby_host.state == LobbyState.FAILED then
		error_message = error_message .. "- PSN Room State \"FAILED\".\n"
	end

	if self._lobby_client and self._lobby_client.state == LobbyState.FAILED then
		error_message = error_message .. "- PSN Room State \"FAILED\".\n"
	end

	if self._network_client and self._network_client.state == "denied_enter_game" then
		error_message = error_message .. "- Failed to join server. Network Client error: " .. (self._network_client.fail_reason or "UNKNOWN") .. "\n"
	end

	if error_message ~= "" then
		error_message = "Error(s) while in network state \"" .. self._network_state .. "\":\n" .. error_message
		self._error_popup = Managers.popup:queue_popup(error_message, Localize("popup_error_topic"), "restart_as_server", Localize("menu_accept"))
		self._network_state = "_state_error"
	end
end

StateTitleScreenInitNetwork._state_setup_network = function (self)
	local auto_join_setting = Development.parameter("auto_join")

	Development.set_parameter("auto_join", nil)

	local unique_server_name = Development.parameter("unique_server_name")
	local development_port = Development.parameter("server_port") or GameSettingsDevelopment.network_port
	development_port = development_port + StateTitleScreenInitNetwork.lobby_port_increment
	StateTitleScreenInitNetwork.lobby_port_increment = StateTitleScreenInitNetwork.lobby_port_increment + 1
	local lobby_port = (LEVEL_EDITOR_TEST and GameSettingsDevelopment.editor_lobby_port) or development_port
	local network_options = {
		project_hash = "bulldozer",
		max_members = 4,
		config_file_name = "global",
		lobby_port = lobby_port
	}
	self._network_options = network_options

	if not rawget(_G, "LobbyInternal") or not LobbyInternal.network_initialized() then
		LobbyInternal.init_client(network_options)

		for i = 1, #GameSettingsDevelopment.ignored_rpc_logs, 1 do
			Network.ignore_rpc_log(GameSettingsDevelopment.ignored_rpc_logs[i])
		end
	end

	local loading_context = self.parent.parent.loading_context

	if loading_context.level_transition_handler then
		self._level_transition_handler = loading_context.level_transition_handler
	else
		self._level_transition_handler = LevelTransitionHandler:new()
	end

	self._network_event_delegate = NetworkEventDelegate:new()

	self._level_transition_handler:register_rpcs(self._network_event_delegate)

	if Managers.invite:has_invitation() then
		self._information_view:set_information_text("Creating Lobby Client")

		self._network_state = "_state_create_lobby_client"
	elseif auto_join_setting then
		assert(unique_server_name, "No unique_server_name in %%appdata%%\\Roaming\\Fatshark\\Bulldozer\\user_settings.config")

		if Managers.package:is_loading("resource_packages/inventory", "global") then
			Managers.package:load("resource_packages/inventory", "global")
		end

		self._information_view:set_information_text("Creating Lobby Finder")

		self._network_state = "_state_create_lobby_finder"
	else
		assert(not loading_context.profile_synchronizer)
		assert(not loading_context.network_server)
		self._level_transition_handler:load_default_level()
		self._information_view:set_information_text("Creating Lobby Host")

		self._network_state = "_state_create_lobby_host"
	end
end

StateTitleScreenInitNetwork._state_create_lobby_host = function (self)
	if LobbyInternal.client_ready() then
		self._lobby_host = LobbyHost:new(self._network_options)

		self._information_view:set_information_text("Creating PSN Room")

		self._network_state = "_state_create_psn_room"
	end

	self:_check_errors()
end

StateTitleScreenInitNetwork._state_create_lobby_client = function (self)
	if LobbyInternal.client_ready() then
		local lobby_data = Managers.invite:get_invited_lobby_data()

		if lobby_data then
			self._lobby_client = LobbyClient:new(self._network_options, lobby_data)

			self._information_view:set_information_text("Joining PSN Room")

			self._network_state = "_state_join_psn_room"
		end
	end

	self:_check_errors()
end

StateTitleScreenInitNetwork._state_create_lobby_finder = function (self)
	if LobbyInternal.client_ready() then
		self._lobby_finder = LobbyFinder:new(self._network_options)

		self._information_view:set_information_text("Finding PSN Room")

		self._network_state = "_state_find_psn_room"
	end

	self:_check_errors()
end

StateTitleScreenInitNetwork._state_create_psn_room = function (self, dt)
	local lobby_host = self._lobby_host

	lobby_host:update(dt)

	local lobby_state = lobby_host.state

	if lobby_state == LobbyState.JOINED then
		local loading_context = self.parent.parent.loading_context
		local initial_level = self._level_transition_handler:get_current_level_keys()
		self._network_server = NetworkServer:new(Managers.player, lobby_host, initial_level)
		self._network_transmit = loading_context.network_transmit or NetworkTransmit:new(true, self._network_server.connection_handler)

		self._network_transmit:set_network_event_delegate(self._network_event_delegate)
		self._network_server:register_rpcs(self._network_event_delegate, self._network_transmit)
		self._network_server:server_join()

		loading_context.network_transmit = self._network_transmit
		self._network_state = "_state_enter_game"
	end

	self:_check_errors()
end

StateTitleScreenInitNetwork._state_join_psn_room = function (self, dt)
	local lobby_client = self._lobby_client

	lobby_client:update(dt)

	local lobby_state = lobby_client.state

	if lobby_state == LobbyState.JOINED then
		local host = lobby_client:lobby_host()

		if host ~= "0" then
			local level_key = self._level_transition_handler:get_current_level_keys()
			local level_index = (level_key and NetworkLookup.level_keys[level_key]) or nil
			self._network_client = NetworkClient:new(self._level_transition_handler, host, level_index)
			self._network_transmit = NetworkTransmit:new(false, self._network_client.connection_handler)

			self._network_transmit:set_network_event_delegate(self._network_event_delegate)
			self._network_client:register_rpcs(self._network_event_delegate, self._network_transmit)

			self._profile_synchronizer = self._network_client.profile_synchronizer
			self._network_state = "_state_enter_game"
		end
	end

	self:_check_errors()
end

StateTitleScreenInitNetwork._state_find_psn_room = function (self, dt)
	local lobby_finder = self._lobby_finder

	lobby_finder:update(dt)

	local lobbies = lobby_finder:lobbies()

	for i, lobby in ipairs(lobbies) do
		local auto_join = lobby.unique_server_name == Development.parameter("unique_server_name")

		if lobby.valid and auto_join then
			self._level_transition_handler:load_level(lobby.level_key)

			self._lobby_client = LobbyClient:new(self._network_options, lobby)
			self._lobby_finder = nil

			self._information_view:set_information_text("Joining PSN Room")

			self._network_state = "_state_join_psn_room"
		end
	end

	self:_check_errors()
end

StateTitleScreenInitNetwork._state_enter_game = function (self, dt)
	self._network_transmit:transmit_local_rpcs()

	if self._lobby_host then
		self._lobby_host:update(dt)
	elseif self._lobby_client then
		self._lobby_client:update(dt)
	end

	if self._network_server then
		self._network_server:update(dt)
	elseif self._network_client then
		self._network_client:update(dt)
	end

	self:_check_errors()

	local package_manager = Managers.package

	if not self._global_resources_loaded then
		for i, name in ipairs(GlobalResources) do
			if not package_manager:has_loaded(name) then
				self._information_view:set_information_text("Loading " .. name)

				return
			end
		end

		self._global_resources_loaded = true
	end

	if not self._level_resources_loaded then
		local level_name = self._level_transition_handler:get_current_level_keys()

		if self._level_transition_handler:all_packages_loaded() then
			if self._network_server then
				local level_index = NetworkLookup.level_keys[level_name]

				self._network_server:rpc_level_loaded(Network.peer_id(), level_index)
			end

			self._level_resources_loaded = true
		else
			self._information_view:set_information_text("Loading Level")

			return
		end
	end

	if not Managers.backend:profiles_loaded() then
		self._information_view:set_information_text("Loading Profiles")

		return
	end

	if self._network_server and not self._network_server:can_enter_game() then
		self._information_view:set_information_text("Entering Game")

		return
	end

	if self._network_client and not self._network_client:can_enter_game() then
		self._information_view:set_information_text("Entering Game")

		return
	end

	self.parent.state = StateIngame
end

StateTitleScreenInitNetwork._state_error = function (self)
	if self._error_popup then
		local result = Managers.popup:query_result(self._error_popup)

		if result == "restart_as_server" then
			self._error_popup = nil

			if self._lobby_finder then
				self._lobby_finder:destroy()

				self._lobby_finder = nil
			end

			if self._lobby_client then
				self._lobby_client:destroy()

				self._lobby_client = nil
			end

			if self._lobby_host then
				self._lobby_host:destroy()

				self._lobby_host = nil
			end

			if self._network_server then
				self._network_server:destroy()

				self._network_server = nil
			end

			if self._network_client then
				self._network_client:destroy()

				self._network_client = nil
			end

			if self._network_transmit then
				self._network_transmit:destroy()

				self._network_transmit = nil
			end

			self.parent.parent.loading_context.network_transmit = nil

			Managers.invite:reset()

			local level_transition_handler = self._level_transition_handler
			local default_level_key = level_transition_handler:default_level_key()
			local is_loading_level = level_transition_handler.loading_packages[default_level_key]
			local has_loaded_level = level_transition_handler.loaded_levels[default_level_key]

			if not is_loading_level and not has_loaded_level then
				self._level_transition_handler:load_level(default_level_key)
			end

			self._information_view:set_information_text("Creating Lobby Host")

			self._network_state = "_state_create_lobby_host"
		end
	end
end

return
