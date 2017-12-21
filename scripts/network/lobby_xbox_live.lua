require("scripts/network/lobby_aux")
require("scripts/network/lobby_host")
require("scripts/network/lobby_client")
require("scripts/network/lobby_finder")
require("scripts/network/lobby_members")
require("scripts/network/smartmatch_xb1")
require("scripts/network/lobby_unclaimed")

LobbyInternal = LobbyInternal or {}
LobbyInternal.HOPPER_NAME = "default_stage_hopper"
LobbyInternal.SESSION_TEMPLATE_NAME = "default_game"
LobbyInternal.SMARTMATCH_SESSION_TEMPLATE_NAME = "ticket_default"
LobbyInternal.state_map = {
	[MultiplayerSession.READY] = LobbyState.JOINED,
	[MultiplayerSession.WORKING] = LobbyState.WORKING,
	[MultiplayerSession.SHUTDOWN] = LobbyState.SHUTDOWN,
	[MultiplayerSession.BROKEN] = LobbyState.FAILED
}
LobbyInternal.init_client = function (network_options)
	if not LobbyInternal.client then
		Network.set_explicit_connections()

		if not Network.xboxlive_client_exists() then
			Network.init_xboxlive_client(network_options.config_file_name)
		end

		LobbyInternal.client = true
	end

	GameSettingsDevelopment.set_ignored_rpc_logs()

	return 
end
LobbyInternal.create_lobby = function (network_options)
	local name = Application.guid()
	local session_template_name = LobbyInternal.SESSION_TEMPLATE_NAME
	local session_id = Network.create_multiplayer_session_host(Managers.account:user_id(), name, session_template_name, {
		"server_name:" .. name
	})

	return XboxLiveLobby:new(session_id, name, session_template_name)
end
LobbyInternal.network_initialized = function ()
	return not not LobbyInternal.client
end
LobbyInternal.leave_lobby = function (xboxlive_lobby)
	xboxlive_lobby.leave(xboxlive_lobby)

	return 
end
LobbyInternal.join_lobby = function (lobby_data)
	print("############## JOINING LOBBY ##############")

	for name, value in pairs(lobby_data) do
		print(name, value)
	end

	print("###########################################")

	local create_as_host = false
	local name = lobby_data.name or Application.guid()
	local session_template_name = lobby_data.session_template_name or LobbyInternal.SESSION_TEMPLATE_NAME
	local session_id = Network.create_multiplayer_session_client(Managers.account:user_id(), name, session_template_name)

	return XboxLiveLobby:new(session_id, name, session_template_name)
end
LobbyInternal.create_keywords = function (data)
	local push_table = {}

	for key, value in pairs(data) do
		push_table[#push_table + 1] = tostring(key) .. ":" .. tostring(value)
	end

	return push_table
end
LobbyInternal.shutdown_client = function ()
	if LobbyInternal.xbox_live_lobby_browser then
		LobbyInternal.xbox_live_lobby_browser:destroy()

		LobbyInternal.xbox_live_lobby_browser = nil
	end

	return 
end
LobbyInternal.get_lobby = function (lobby_browser, index)
	local lobby_data = {}
	local xbox_lobby_data = table.clone(lobby_browser.lobby(lobby_browser, index))
	lobby_data.name = xbox_lobby_data.name
	lobby_data.template_name = xbox_lobby_data.template_name

	for i = 1, #xbox_lobby_data.keywords, 1 do
		local key_value = string.split(xbox_lobby_data.keywords[i], ":")
		local key = key_value[1]
		local value = tonumber(key_value[2]) or key_value[2]
		lobby_data[key] = value
	end

	return lobby_data
end
LobbyInternal.lobby_browser = function ()
	return LobbyInternal.xbox_live_lobby_browser
end
LobbyInternal.get_lobby_data_from_id = function (id)
	return nil
end
LobbyInternal.get_lobby_data_from_id_by_key = function (id, key)
	return nil
end
LobbyInternal.clear_filter_requirements = function ()
	return 
end
LobbyInternal.add_filter_requirements = function (requirements)
	return 
end
LobbyInternal.lobby_id = function (lobby)
	return lobby.id(lobby)
end
LobbyInternal.session_id = function (lobby)
	return lobby.id(lobby)
end
script_data.debug_xbox_lobby = true

local function dprintf()
	return 
end

if script_data.debug_xbox_lobby then
	function dprintf(...)
		print("[XboxLiveLobby]", string.format(...))

		return 
	end
end

local SMARTMATCH_STATUS_LUT = {
	[SmartMatchStatus.UNKNOWN] = "UNKNOWN",
	[SmartMatchStatus.SEARCHING] = "SEARCHING",
	[SmartMatchStatus.EXPIRED] = "EXPIRED",
	[SmartMatchStatus.FOUND] = "FOUND"
}
local SESSION_STATUS_LUT = {
	[MultiplayerSession.READY] = "READY",
	[MultiplayerSession.WORKING] = "WORKING",
	[MultiplayerSession.SHUTDOWN] = "SHUTDOWN",
	[MultiplayerSession.BROKEN] = "BROKEN"
}
local HOPPER_PARAMS_LUT = {
	default_stage_hopper = {
		"difficulty",
		"stage"
	}
}
local HOPPER_PARAM_TYPE_LUT = {
	difficulty = "number",
	stage = "number"
}
XboxLiveLobby = class(XboxLiveLobby)
XboxLiveLobby.init = function (self, session_id, unique_server_name, session_template_name)
	self._user_id = Managers.account:user_id()
	self._session_id = session_id
	self._data = {
		unique_server_name = unique_server_name or LobbyInternal.SESSION_NAME,
		session_name = unique_server_name,
		session_template_name = session_template_name
	}
	self._gamertags = {}
	self._hopper_name = LobbyInternal.HOPPER_NAME
	self._smartmatch_ticket_params = {}

	dprintf("Lobby created Session ID: %s - Name: %s - Template: %s", tostring(session_id), tostring(unique_server_name), tostring(session_template_name))

	return 
end
XboxLiveLobby.enable_smartmatch = function (self, enable, params, timeout)
	fassert((enable and params ~= nil) or not enable, "You need to supply ticket_params if you want to enable matchmaking")

	self._smartmatch_enabled = enable
	self._smartmatch_ticket_params = params
	self._timeout = timeout

	if not self._smartmatch_enabled then
		self._cancel_matchmaking(self)
	end

	return 
end
XboxLiveLobby._cancel_matchmaking = function (self)
	if self._smartmatch_in_progress then
		local session_data = {
			destroy_session = false,
			state = "_cleanup_ticket",
			user_id = Managers.account:user_id(),
			session_id = self._session_id,
			hopper_name = self._hopper_name,
			session_name = self._data.session_name
		}

		Managers.account:add_session_to_cleanup(session_data)
		dprintf("Smartmatch in progress - DESTROYING")
	else
		dprintf("No smartmatch ticket found - RESETTING")
	end

	self._smartmatch_state = nil
	self._prev_smartmatch_state = nil
	self._reissue_host_smartmatch_ticket = nil
	self._timeout = nil
	self._ticket_id = nil
	self._smartmatch_in_progress = false

	return 
end
XboxLiveLobby.state = function (self)
	local state = MultiplayerSession.status(self._session_id)

	if state == MultiplayerSession.READY and self._set_keywords then
		self.push_data_table(self)

		local state = MultiplayerSession.status(self._session_id)

		return state
	end

	if not self._session_group_id and state == MultiplayerSession.READY then
		self._session_group_id = MultiplayerSession.group_id(self._session_id)
	end

	return state
end
XboxLiveLobby.ready = function (self)
	if not self._smartmatch_enabled then
		return true
	end

	return self._smartmatch_state == MultiplayerSession.READY
end
XboxLiveLobby.update_host_matchmaking = function (self, dt)
	local state = MultiplayerSession.status(self._session_id)

	if state ~= MultiplayerSession.READY or not self._smartmatch_enabled then
		return 
	end

	self._update_smartmatching(self, dt)
	self._handle_smartmatching_tickets(self, dt)

	return 
end
XboxLiveLobby._update_smartmatching = function (self, dt)
	local smartmatch_state = MultiplayerSession.smartmatch_status(self._session_id)
	local ticket_name = MultiplayerSession.start_smartmatch_result(self._session_id)

	if (not self._ticket_id or self._ticket_id ~= ticket_name) and ticket_name ~= "" then
		dprintf("Started smartmatch with ticket_id: %s", ticket_name)

		self._ticket_id = ticket_name
	end

	if smartmatch_state == SmartMatchStatus.SEARCHING then
		if self._reissue_host_smartmatch_ticket and self._smartmatch_in_progress then
			if ticket_name ~= "" then
				dprintf("Deleting smartmatch ticket: %s due to reissue", ticket_name)
				MultiplayerSession.delete_smartmatch_ticket(self._session_id, self._hopper_name, ticket_name)
			end

			self._smartmatch_in_progress = false
			self._ticket_id = nil
		end

		return 
	elseif smartmatch_state == SmartMatchStatus.EXPIRED or smartmatch_state == SmartMatchStatus.FOUND then
		if smartmatch_state == SmartMatchStatus.EXPIRED then
			dprintf("Smartmatching EXPIRED - ticket name: %s", ticket_name)
		else
			dprintf("Smartmatching FOUND - ticket name: %s", ticket_name)
		end

		self._smartmatch_in_progress = false
		self._ticket_id = nil
		local session_data = {
			destroy_session = false,
			state = "_cleanup_ticket",
			user_id = Managers.account:user_id(),
			session_id = self._session_id,
			hopper_name = self._hopper_name,
			session_name = self._data.session_name
		}

		Managers.account:add_session_to_cleanup(session_data)
		dprintf("Smartmatch in progress - DESTROYING")
	end

	self._smartmatch_state = smartmatch_state

	return 
end
XboxLiveLobby._handle_smartmatching_tickets = function (self, dt)
	if self._smartmatch_in_progress then
		return 
	end

	if self._smartmatch_state ~= self._prev_smartmatch_state then
		dprintf("changed smartmatch status from %s -> %s", SMARTMATCH_STATUS_LUT[self._prev_smartmatch_state] or "None", SMARTMATCH_STATUS_LUT[self._smartmatch_state])

		self._prev_smartmatch_state = self._smartmatch_state
	end

	self._create_smartmatch_broadcast(self, 600)

	self._smartmatch_in_progress = true
	self._reissue_host_smartmatch_ticket = false

	dprintf("######### Created smartmatch session broadcast for lobby host #########")

	return 
end
XboxLiveLobby._convert_to_json = function (self, hopper_name, params)
	local lut_variables = HOPPER_PARAMS_LUT[hopper_name]

	fassert(lut_variables, "[SmartMatch::_convert_to_json] No such hopper_name:  %s", hopper_name)

	local str = ""

	for _, var in ipairs(lut_variables) do
		local var_type = HOPPER_PARAM_TYPE_LUT[var]
		local val = params[var]

		fassert(val, "[SmartMatch::_convert_to_json] Missing variable [%s] in params", var)

		if var_type == "number" then
			str = str .. string.format("%q:%i,", var, val)
		elseif var_type == "string" then
			str = str .. string.format("%q:%q,", var, val)
		end
	end

	if str == "" then
		return 
	else
		str = string.sub(str, 1, -2)

		return string.format("{%s}", str)
	end

	return 
end
XboxLiveLobby._create_smartmatch_broadcast = function (self, timeout)
	local timeout_in_seconds = timeout or 600
	local preserve_session_mode = PreserveSessionMode.ALWAYS

	dprintf("PreserveSessionMode %s. is host %s", "ALWAYS", "TRUE")

	local ticket_param_str = nil

	if self._smartmatch_ticket_params then
		ticket_param_str = self._convert_to_json(self, self._hopper_name, self._smartmatch_ticket_params)

		dprintf("Ticket Params: %s Hopper Name: %s", ticket_param_str, self._hopper_name)
	end

	dprintf("Starting SmartMatch with session_id: %s Hopper name: %s PreserveSessionMode: %s Ticket params: %s Timeout: %s", tostring(self._session_id), self._hopper_name, "ALWAYS", ticket_param_str, tostring(timeout_in_seconds))
	MultiplayerSession.start_smartmatch(self._session_id, self._hopper_name, timeout_in_seconds, preserve_session_mode, ticket_param_str)

	return 
end
XboxLiveLobby.session_id = function (self)
	return self._session_id
end
XboxLiveLobby.leave = function (self)
	dprintf("Destroying Lobby --> session_id: %s - session_name: %s", self._session_id, self._data.session_name)

	local session_data = {
		destroy_session = true,
		state = "_cleanup_ticket",
		user_id = Managers.account:user_id(),
		session_id = self._session_id,
		hopper_name = self._hopper_name,
		session_name = self._data.session_name
	}

	Managers.account:add_session_to_cleanup(session_data)

	return 
end
XboxLiveLobby.free = function (self)
	Network.free_multiplayer_session(self._session_id)

	return 
end
XboxLiveLobby.push_data_table = function (self)
	local push_table = LobbyInternal.create_keywords(self._data)

	Application.warning(string.format("[XboxLiveLobby] Setting keywords for session --> session_id: %s", self._session_id))
	MultiplayerSession.set_keywords(self._user_id, self._session_id, push_table)

	self._set_keywords = nil

	return 
end
XboxLiveLobby.set_data = function (self, key, value)
	self._data[key] = value
	self._set_keywords = true

	return 
end
XboxLiveLobby.set_data_table = function (self, data_table)
	for key, value in pairs(data_table) do
		self._data[key] = value
	end

	self._set_keywords = true

	return 
end
XboxLiveLobby.data = function (self, key)
	return self._data[key]
end
XboxLiveLobby.members = function (self)
	local peers = {}
	local members = MultiplayerSession.members(self._session_id)

	for _, member in pairs(members) do
		self._gamertags[member.peer] = member.gamertag
		peers[#peers + 1] = member.peer
	end

	return peers
end
XboxLiveLobby.user_name = function (self, peer_id)
	return self._gamertags[peer_id]
end
XboxLiveLobby.lobby_host = function (self)
	return MultiplayerSession.host_peer(self._session_id)
end
XboxLiveLobby.try_claim_host = function (self)
	MultiplayerSession.try_claim_session(self._session_id)

	return 
end
XboxLiveLobby.id = function (self)
	return 1000
end
XboxLiveLobbyBrowser = class(XboxLiveLobbyBrowser)
XboxLiveLobbyBrowser.init = function (self, user_id, network_options)
	self._network_hash = "network_hash:" .. LobbyAux.create_network_hash(network_options.config_file_name, network_options.project_hash)
	self._user_id = user_id
	self._session_browsing_id = Network.start_session_browsing(user_id, self._network_hash, LobbyInternal.SESSION_TEMPLATE_NAME)
	self._lobbies = {}

	return 
end
LOBBIES = LOBBIES or {}
XboxLiveLobbyBrowser.is_refreshing = function (self)
	if not self._session_browsing_id then
		return false
	end

	local status = MultiplayerSessionBrowser.status(self._session_browsing_id)

	if status ~= SessionJobStatus.COMPLETE then
		return true
	end

	self._lobbies = MultiplayerSessionBrowser.result(self._session_browsing_id) or {}
	LOBBIES = self._lobbies

	Network.free_session_browsing(self._session_browsing_id)

	self._session_browsing_id = nil

	return false
end
XboxLiveLobbyBrowser.num_lobbies = function (self)
	return #self._lobbies
end
XboxLiveLobbyBrowser.refresh = function (self)
	self._session_browsing_id = Network.start_session_browsing(self._user_id, self._network_hash, LobbyInternal.SESSION_TEMPLATE_NAME)

	return 
end
XboxLiveLobbyBrowser.lobby = function (self, index)
	return self._lobbies[index + 1]
end
XboxLiveLobbyBrowser.destroy = function (self)
	if self._session_browsing_id then
		Network.free_session_browsing(self._session_browsing_id)
	end

	return 
end

return 