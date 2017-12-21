require("scripts/network/lobby_aux")
require("scripts/network/lobby_host")
require("scripts/network/lobby_client")
require("scripts/network/lobby_finder")
require("scripts/network/lobby_members")
require("scripts/network_lookup/network_lookup")

LobbyInternal = LobbyInternal or {}
LobbyInternal.state_map = {
	[PsnRoom.WAITING_TO_CREATE] = LobbyState.WAITING_TO_CREATE,
	[PsnRoom.CREATING] = LobbyState.CREATING,
	[PsnRoom.JOINING] = LobbyState.JOINING,
	[PsnRoom.JOINED] = LobbyState.JOINED,
	[PsnRoom.FAILED] = LobbyState.FAILED
}
LobbyInternal.comparison_map = {
	[LobbyComparison.EQUAL] = PsnRoomBrowser.EQUAL,
	[LobbyComparison.NOT_EQUAL] = PsnRoomBrowser.NOT_EQUAL,
	[LobbyComparison.LESS] = PsnRoomBrowser.LESS,
	[LobbyComparison.LESS_OR_EQUAL] = PsnRoomBrowser.LESS_OR_EQUAL,
	[LobbyComparison.GREATER] = PsnRoomBrowser.GREATER,
	[LobbyComparison.GREATER_OR_EQUAL] = PsnRoomBrowser.GREATER_OR_EQUAL
}
LobbyInternal.matchmaking_lobby_data = {
	required_progression = {
		data_type = "integer",
		id = PsnRoom.SEARCHABLE_INTEGER_ID_1
	},
	matchmaking = {
		conversion_lookup = "lobby_data_matchmaking_values",
		data_type = "integer",
		id = PsnRoom.SEARCHABLE_INTEGER_ID_2
	},
	difficulty = {
		conversion_lookup = "difficulties",
		data_type = "integer",
		id = PsnRoom.SEARCHABLE_INTEGER_ID_3
	},
	selected_level_key = {
		conversion_lookup = "level_keys",
		data_type = "integer",
		id = PsnRoom.SEARCHABLE_INTEGER_ID_4
	}
}
LobbyInternal.init_client = function (network_options)
	Network.set_explicit_connections()

	LobbyInternal.psn_client = Network.init_psn_client(network_options.config_file_name)
	LobbyInternal.psn_room_browser = PSNRoomBrowser:new(LobbyInternal.psn_client)
	LobbyInternal.psn_room_data_external = PsnClient.room_data_external(LobbyInternal.psn_client)

	GameSettingsDevelopment.set_ignored_rpc_logs()

	return 
end
LobbyInternal.network_initialized = function ()
	return not not LobbyInternal.psn_client
end
LobbyInternal.client_ready = function ()
	return PsnClient.ready(LobbyInternal.psn_client)
end
LobbyInternal.shutdown_client = function ()
	Network.shutdown_psn_client(LobbyInternal.psn_client)

	LobbyInternal.psn_client = nil
	LobbyInternal.psn_room_browser = nil
	LobbyInternal.psn_room_data_external = nil

	return 
end
LobbyInternal.create_lobby = function (network_options)
	local room_id = Network.create_psn_room("UNKNOWN", network_options.max_members)

	return PSNRoom:new(room_id)
end
LobbyInternal.join_lobby = function (lobby_data)
	local id = lobby_data.id
	local room_id = Network.join_psn_room(id)

	return PSNRoom:new(room_id)
end
LobbyInternal.leave_lobby = function (psn_room)
	Network.leave_psn_room(psn_room.room_id)

	return 
end
LobbyInternal.get_lobby = function (room_browser, index)
	local network_psn_room_info = room_browser.lobby(room_browser, index)
	local data_string = network_psn_room_info.data
	local data_table = LobbyInternal.unserialize_psn_data(data_string)
	data_table.id = network_psn_room_info.id
	data_table.name = network_psn_room_info.name

	return data_table
end
LobbyInternal.lobby_browser = function ()
	return LobbyInternal.psn_room_browser
end
LobbyInternal.client_lost_context = function ()
	return PsnClient.lost_context(LobbyInternal.psn_client)
end
LobbyInternal.get_lobby_data_from_id = function (id)
	local entry = LobbyInternal.room_data_entry(id)

	if entry then
		return entry.data
	end

	return 
end
LobbyInternal.room_data_refresh = function (ids)
	if script_data.debug_psn then
		printf("[LobbyInternal] Refreshing PsnRoomDataExternal for %s number of rooms:", #ids)

		for i, id in ipairs(ids) do
			printf("\tRoomId #%d: %s", i, id)
		end
	end

	PsnRoomDataExternal.refresh(LobbyInternal.psn_room_data_external, ids)

	return 
end
LobbyInternal.room_data_is_refreshing = function ()
	return PsnRoomDataExternal.is_refreshing(LobbyInternal.psn_room_data_external)
end
LobbyInternal.room_data_all_entries = function ()
	local entries = PsnRoomDataExternal.all_entries(LobbyInternal.psn_room_data_external)

	for _, entry in ipairs(entries) do
		entry.data = LobbyInternal.unserialize_psn_data(entry.data)
	end

	return entries
end
LobbyInternal.room_data_entry = function (id)
	local entry = PsnRoomDataExternal.entry(LobbyInternal.psn_room_data_external, id)

	if entry then
		entry.data = LobbyInternal.unserialize_psn_data(entry.data)
	end

	return entry
end
LobbyInternal.room_data_num_entries = function ()
	return PsnRoomDataExternal.num_entries(LobbyInternal.psn_room_data_external)
end
LobbyInternal.psn_data_delimiter = "|"
LobbyInternal.serialize_psn_data = function (data_table)
	local delimiter = LobbyInternal.psn_data_delimiter
	local s = ""

	for k, v in pairs(data_table) do
		local found_delimiter = string.find(v, delimiter)

		fassert(not found_delimiter, "[PSNRoom] PSN Room Data cannot contain %q", delimiter)

		s = string.format("%s%s%s%s%s", s, NetworkLookup.lobby_data[k], delimiter, v, delimiter)
	end

	local size = string.len(s) - string.len(delimiter)
	s = string.sub(s, 1, size)

	return s, size
end
LobbyInternal.unserialize_psn_data = function (data_string)
	local delimiter = LobbyInternal.psn_data_delimiter
	local t = {}
	local i = 1
	local k = nil

	for s in string.gmatch(data_string, "([^" .. delimiter .. "]+)") do
		if i%2 == 1 then
			k = NetworkLookup.lobby_data[tonumber(s)]
		else
			t[k] = s
		end

		i = i + 1
	end

	return t
end
LobbyInternal.clear_filter_requirements = function ()
	local room_browser = LobbyInternal.psn_room_browser

	room_browser.clear_filters(room_browser)

	return 
end
LobbyInternal.add_filter_requirements = function (requirements)
	local room_browser = LobbyInternal.psn_room_browser

	room_browser.clear_filters(room_browser, room_browser)

	for key, filter in pairs(requirements.filters) do
		local mm_lobby_data = LobbyInternal.matchmaking_lobby_data[key]

		if mm_lobby_data then
			local id = mm_lobby_data.id
			local value = filter.value
			local comparison = filter.comparison
			local psn_comparison = LobbyInternal.comparison_map[comparison]

			if mm_lobby_data.conversion_lookup then
				value = NetworkLookup[mm_lobby_data.conversion_lookup][value]
			end

			room_browser.add_filter(room_browser, id, value, psn_comparison)
			mm_printf("Filter: %s, comparison(%s), id=%s, value(untouched)=%s, value=%s", tostring(key), tostring(comparison), tostring(id), tostring(filter.value), tostring(value))
		else
			mm_printf("Skipping filter %q matchmaking_lobby_data not setup. Probably redundant on ps4", key)
		end
	end

	return 
end
LobbyInternal._set_matchmaking_data = function (room_id, key, value)
	local mm_lobby_data = LobbyInternal.matchmaking_lobby_data[key]

	fassert(mm_lobby_data, "Lobby data key %q is not set up for matchmaking", key)

	local data_type = mm_lobby_data.data_type

	if data_type == "integer" then
		if mm_lobby_data.conversion_lookup then
			value = NetworkLookup[mm_lobby_data.conversion_lookup][value]
		end

		PsnRoom.set_searchable_attribute(room_id, mm_lobby_data.id, value)
	else
		ferror("unsupported data type %q", data_type)
	end

	return 
end
LobbyInternal.user_name = function (user)
	return nil
end
LobbyInternal.lobby_id = function (psn_room)
	return PsnRoom.sce_np_room_id(psn_room.room_id)
end
PSNRoom = class(PSNRoom)
PSNRoom.room_data_max_size = 256
PSNRoom.init = function (self, room_id)
	self.room_id = room_id
	self.room_data = {}

	return 
end
PSNRoom.state = function (self)
	return PsnRoom.state(self.room_id)
end
PSNRoom.set_data = function (self, key, value)
	local room_data = self.room_data
	room_data[key] = tostring(value)

	if LobbyInternal.matchmaking_lobby_data[key] then
		LobbyInternal._set_matchmaking_data(self.room_id, key, value)
	end

	local data_string, data_size = LobbyInternal.serialize_psn_data(room_data)

	fassert(data_size < PSNRoom.room_data_max_size, "[PSNRoom] Tried to store %d characters in the PSN Room Data, maximum is 255 bytes", data_size)
	PsnRoom.set_data(self.room_id, data_string)

	if script_data.debug_psn then
		printf("[PSNRoom] Setting Room Data: %q, Size: %d/%d", data_string, data_size, PSNRoom.room_data_max_size)
	end

	return 
end
PSNRoom.set_data_table = function (self, data_table)
	local room_data = self.room_data

	for key, value in pairs(data_table) do
		room_data[key] = tostring(value)

		if LobbyInternal.matchmaking_lobby_data[key] then
			LobbyInternal._set_matchmaking_data(self.room_id, key, value)
		end
	end

	local data_string, data_size = LobbyInternal.serialize_psn_data(room_data)

	fassert(data_size < PSNRoom.room_data_max_size, "[PSNRoom] Tried to store %d characters in the PSN Room Data, maximum is 255 bytes", data_size)
	PsnRoom.set_data(self.room_id, data_string)

	if script_data.debug_psn then
		printf("[PSNRoom] Setting Room Data: %q, Size: %d/%d", data_string, data_size, PSNRoom.room_data_max_size)
	end

	return 
end
PSNRoom.data = function (self, key)
	return self.room_data[key]
end
PSNRoom.members = function (self)
	local room_id = self.room_id
	local num_members = PsnRoom.num_members(room_id)
	local t = {}

	for i = 0, num_members - 1, 1 do
		local member = PsnRoom.member(room_id, i)
		t[i + 1] = member.peer_id
	end

	return t
end
PSNRoom.members_np_id = function (self, t)
	local room_id = self.room_id
	local num_members = PsnRoom.num_members(room_id)

	for i = 0, num_members - 1, 1 do
		local member = PsnRoom.member(room_id, i)
		t[i + 1] = member.np_id
	end

	return 
end
PSNRoom.lobby_host = function (self)
	return PsnRoom.owner(self.room_id)
end
PSNRoom.sce_np_room_id = function (self)
	return PsnRoom.sce_np_room_id(self.room_id)
end
PSNRoom.user_name = function (self)
	return nil
end
PSNRoomBrowser = class(PSNRoomBrowser)
PSNRoomBrowser.init = function (self, psn_client)
	self.browser = PsnClient.room_browser(psn_client)

	return 
end
PSNRoomBrowser.is_refreshing = function (self)
	PsnRoomBrowser.is_refreshing(self.browser)

	return 
end
PSNRoomBrowser.num_lobbies = function (self)
	return PsnRoomBrowser.num_rooms(self.browser)
end
PSNRoomBrowser.refresh = function (self)
	PsnRoomBrowser.refresh(self.browser)

	return 
end
PSNRoomBrowser.lobby = function (self, index)
	return PsnRoomBrowser.room(self.browser, index)
end
PSNRoomBrowser.add_filter = function (self, id, value, psn_comparison)
	PsnRoomBrowser.add_filter(self.browser, id, value, psn_comparison)

	return 
end
PSNRoomBrowser.clear_filters = function (self)
	PsnRoomBrowser.clear_filters(self.browser)

	return 
end

return 
