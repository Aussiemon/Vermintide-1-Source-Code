require("scripts/managers/telemetry/iso_country_names")
require("scripts/managers/telemetry/curl_token")

local json = require("scripts/managers/telemetry/json_parser")
TelemetryManager = class(TelemetryManager)
local RPCS = {
	"rpc_to_client_session_synch"
}
local DEFAULT_TECH_TELEMETRY_INTERVAL = 1
local TelemetryFileName = "telemetry_data"

local function debug_print(...)
	if Development.parameter("debug_telemetry") then
		print(...)
	end

	return 
end

local function parse_whitelist(whitelist_string)
	local whitelist = {}

	for event in string.gmatch(whitelist_string, "([^,]+)") do
		whitelist[event] = true
	end

	return whitelist
end

local function timestamp()
	return os.time(os.date("!*t"))
end

TelemetryManager.init = function (self)
	self.use_telemetry = GameSettingsDevelopment.use_telemetry
	self.local_telemetry_test = GameSettingsDevelopment.local_telemetry_test
	self.use_tech_telemetry = GameSettingsDevelopment.use_tech_telemetry
	self.tech_telemetry_interval = tonumber(GameSettingsDevelopment.telemetry_log_interval) or DEFAULT_TECH_TELEMETRY_INTERVAL

	if GameSettingsDevelopment.telemetry_whitelist then
		local whitelist_string = tostring(GameSettingsDevelopment.telemetry_whitelist)
		self.whitelist = parse_whitelist(whitelist_string)
	end

	self.send_table = {
		tick = 0,
		type = "unknown",
		params = {}
	}
	self.unregistered_events = {}
	self.types_of_authorization = {
		ssh_key = 2,
		password = 1,
		none = 0
	}
	self.session_id = nil
	self.use_stress_test = false
	self.tick_offset = 0
	self.prev_telemetry_data_sent = false
	self.save_interval = 120
	self.next_save_tick = 0
	self.string_table = {}
	self.send_string = ""
	self.session_start_timestamp = 0
	self.version = 2
	self.is_server = nil
	self.tech_telemetry_timer = 0
	self.dispatch_callbacks = {}
	self.base_url = GameSettingsDevelopment.telemetry_base_url
	self.do_gzip = GameSettingsDevelopment.telemetry_compress_data or false
	self.auth_type = self.types_of_authorization[GameSettingsDevelopment.telemetry_auth_type] or 0

	debug_print("Using telemetry")

	return 
end
TelemetryManager.register_network_event_delegate = function (self, network_event_delegate)
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))

	return 
end
TelemetryManager.generate_stress_test = function (self)
	self.send_table.type = "test"
	self.send_table.tick = 12345
	self.send_table.params = {
		pos_x = 10,
		name = "Test",
		pos_z = 12,
		pos_y = 16
	}

	for i = 1, 55000, 1 do
		self.send_table.type = "test" .. i
		self.send_table.tick = i
		self.send_table.params.pos_x = self.send_table.params.pos_x + i
		self.send_table.params.pos_y = self.send_table.params.pos_y - i
		self.send_table.params.pos_z = self.send_table.params.pos_z + i*2

		table.insert(self.string_table, json.encode(self.send_table))
	end

	debug_print("TelemetryManager: STRESS SETUP COMPLETE")

	return 
end
TelemetryManager.unregister_network_event_delegate = function (self)
	self.network_event_delegate:unregister(self)

	self.network_event_delegate = nil

	return 
end
TelemetryManager.update = function (self, dt)
	self.current_tick = self.tick_offset + math.floor(Application.time_since_launch() - self.session_start_timestamp)
	local debug_manager = Managers.state.debug
	local is_paused = debug_manager and debug_manager.time_paused

	if self.use_tech_telemetry and self.tech_telemetry_timer <= self.current_tick and not is_paused then
		self._add_tech_telemetry(self, dt)
	end

	return 
end
TelemetryManager.get_session_id = function (self)
	return self.session_id
end
TelemetryManager.get_current_tick = function (self)
	return self.current_tick
end
TelemetryManager.register_event = function (self, event_type, event_data)
	local not_in_whitelist = self.whitelist and not self.whitelist[event_type]

	if not self.use_telemetry or not_in_whitelist then
		return 
	end

	debug_print("TelemetryManager: REGISTER EVENT!!")
	Profiler.start("TelemetryManager:register_event()")
	fassert(type(event_type) == "string", "event_type must be a string, is %s", type(event_type))
	fassert(type(event_data) == "table", "event_data must be a table, is %s", type(event_type))
	debug_print("TelemetryManager:register_event(", event_type, ") at tick", self.current_tick)

	self.send_table.type = event_type
	self.send_table.tick = self.current_tick
	self.send_table.params = event_data

	if not self.is_server and not self.session_id then
		debug_print("TelemetryManager: Unsynched session - Event was not registered")

		self.unregistered_events[#self.unregistered_events + 1] = table.clone(self.send_table)

		Profiler.stop("TelemetryManager:register_event()")

		return 
	end

	table.insert(self.string_table, json.encode(self.send_table))

	if Development.parameter("debug_telemetry") then
		table.dump(event_data, nil, 2)
	end

	debug_print("")
	Profiler.stop("TelemetryManager:register_event()")

	if self.next_save_tick <= self.current_tick then
		Profiler.start("table concat")

		self.send_string = table.concat(self.string_table, "\n")

		table.clear(self.string_table)
		table.insert(self.string_table, self.send_string)
		Profiler.stop("table concat")
		self._save_telemetry_to_file(self, self.session_id, self.send_string)
	end

	return 
end
TelemetryManager.session_start = function (self, session_data, is_server)
	self.is_server = is_server

	fassert(type(session_data) == "table", "session_data must be a table, is %s", type(session_data))

	self.session_start_timestamp = Application.time_since_launch()
	self.current_tick = 0
	self.tech_telemetry_timer = 0
	self.next_save_tick = 0
	local header_event = {
		type = "header",
		title_id = GameSettingsDevelopment.backend_settings.title_id,
		created_at = timestamp(),
		params = {
			version = self.version,
			content_revision = script_data.settings.content_revision,
			engine_revision = script_data.build_identifier,
			platform = Application.platform(),
			level_key = session_data.level_key,
			difficulty = session_data.difficulty
		}
	}

	debug_print("TelemetryManager: SESSION START %d", header_event.timestamp)

	if not self.prev_telemetry_data_sent then
		self._load_telemetry_data(self)
	end

	table.clear(self.unregistered_events)
	table.clear(self.string_table)
	table.insert(self.string_table, json.encode(header_event))

	if self.local_telemetry_test and self.use_stress_test then
		self.generate_stress_test(self)
	end

	if is_server then
		self.session_id = self.generate_uuid(self)

		self.register_event(self, "session_start", session_data)
	else
		debug_print("TelemetryManager: Not registering session start event since is client")
	end

	return 
end
TelemetryManager._load_telemetry_data = function (self)
	local use_local_save = true

	return Managers.save:auto_load(TelemetryFileName, callback(self, "_cb_telemetry_data_loaded"), use_local_save)
end
TelemetryManager._cb_telemetry_data_loaded = function (self, info)
	local is_empty = info.data and table.is_empty(info.data)

	if info.error then
		Application.warning("Load error %q", info.error)

		self.prev_telemetry_data_sent = true
	elseif is_empty then
		self.prev_telemetry_data_sent = true
	else
		self._dispatch_saved_events(self, info.data.session, info.data.sql)
		debug_print("TelemetryManager: Previous Telemetry Data Loaded")
	end

	return 
end
TelemetryManager._clear_telemetry_file = function (self)
	local use_local_save = true

	Managers.save:auto_save(TelemetryFileName, {}, nil, use_local_save)

	return 
end
local save_data = {}
TelemetryManager._save_telemetry_to_file = function (self, session, save_string)
	if self.prev_telemetry_data_sent then
		if self.local_telemetry_test then
			debug_print("TelemetryManager: Local test - data was not saved.")
		elseif session ~= nil then
			local use_local_save = true

			table.clear(save_data)

			save_data.session = session
			save_data.sql = save_string

			Managers.save:auto_save(TelemetryFileName, save_data, nil, use_local_save)
		else
			Application.warning("Trying to save data without a session!")
		end

		self.next_save_tick = self.current_tick + self.save_interval
	end

	return 
end
TelemetryManager._dispatch_saved_events = function (self, session, telemetry_data_string)
	table.clear(self.dispatch_callbacks)

	self.dispatch_callbacks[#self.dispatch_callbacks + 1] = callback(self, "_clear_telemetry_file")
	self.dispatch_callbacks[#self.dispatch_callbacks + 1] = callback(self, "_cb_prev_telemetry_data_sent")
	local dispatchCallback = callback(self, "_cb_telemetry_dispatched")
	local curl_token = self.send_telemetry_to_database(self, dispatchCallback, telemetry_data_string, session)

	return curl_token
end
TelemetryManager._cb_prev_telemetry_data_sent = function (self)
	debug_print("TelemetryManager: Previous Telemetry data - sent")

	self.prev_telemetry_data_sent = true

	return 
end
TelemetryManager.dispatch_events = function (self, callback_func)
	table.clear(self.dispatch_callbacks)

	self.dispatch_callbacks[#self.dispatch_callbacks + 1] = callback(self, "_clear_telemetry_file")
	self.dispatch_callbacks[#self.dispatch_callbacks + 1] = callback_func
	local dispatchCallback = callback(self, "_cb_telemetry_dispatched")
	self.send_string = table.concat(self.string_table, "\n")

	table.clear(self.string_table)
	self._save_telemetry_to_file(self, self.session_id, self.send_string)

	local curl_token = self.send_telemetry_to_database(self, dispatchCallback, self.send_string, self.session_id)
	self.session_id = nil
	self.tick_offset = 0
	self.send_string = ""

	return curl_token
end
TelemetryManager._cb_telemetry_dispatched = function (self, info)
	for _, callback in pairs(self.dispatch_callbacks) do
		callback(info)
	end

	return 
end
TelemetryManager.send_telemetry_to_database = function (self, callback_func, data_to_send, session)
	if not self.use_telemetry or not data_to_send then
		return 
	end

	if session == nil then
		Application.warning("Trying to send data without a session!")

		return 
	end

	debug_print("TelemetryManager.send_telemetry_to_database(", tostring(callback_func), ") data_to_send length: ", string.len(data_to_send))

	if self.local_telemetry_test then
		debug_print("TelemetryManager: Local test - data was not sent (session = ", session, ")")

		return 
	end

	local game_mode_key = Managers.state.game_mode:game_mode_key()

	if game_mode_key == "inn" then
		self._clear_telemetry_file(self)

		self.prev_telemetry_data_sent = true

		debug_print("TelemetryManager: Skipped uploading telemetry for game mode key '%s'", game_mode_key)

		return 
	end

	local peer_id = Network.peer_id() or self.generate_uuid(self)
	local uuid = session .. "_" .. peer_id
	local url = sprintf("%s%s", self.base_url, uuid)

	debug_print("TelemetryManager.send_telemetry_to_database: uuid = %s", uuid)

	local token = Curl.add_send_request(url, data_to_send, self.do_gzip, self.auth_type)
	local curl_token = CurlToken:new(token)

	Managers.token:register_token(curl_token, callback_func)

	return curl_token
end

local function substitute_x(char)
	if char == "x" then
		return string.format("%x", Math.random(0, 15))
	else
		return string.format("%x", Math.random(8, 11))
	end

	return 
end

TelemetryManager.generate_uuid = function (self)
	local pattern = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
	local result = pattern.gsub(pattern, "[xy]", substitute_x)

	return result
end
TelemetryManager._register_unregistered_events = function (self)
	debug_print("TelemetryManager: TIME TO REGISTER UNREGISTERED EVENT(S)!!")

	for _, event in pairs(self.unregistered_events) do
		local corrected_tick = event.tick + self.tick_offset

		if corrected_tick < 0 then
			corrected_tick = 0
		end

		debug_print("TelemetryManager:_register_unregistered_events(", event.type, ") at tick (old:", event.tick, "; synched:", corrected_tick, ")")

		event.tick = corrected_tick

		table.insert(self.string_table, json.encode(event))
		table.dump(event.params, nil, 2, debug_print)
		debug_print("")
	end

	table.clear(self.unregistered_events)

	return 
end
TelemetryManager.rpc_to_client_session_synch = function (self, sender, session, server_tick)
	if self.session_id == nil then
		self.session_id = session
		local old_current_tick = self.current_tick
		local old_tick_offset = self.tick_offset
		self.tick_offset = server_tick - self.current_tick
		self.current_tick = self.current_tick + self.tick_offset

		debug_print("TelemetryManager:rpc_to_client_session_synch - Session:", session, "server_tick:", server_tick, "client_tick:", old_current_tick, "(old/new) tick_offset:", old_tick_offset, "->", self.tick_offset)
		self._register_unregistered_events(self)
	end

	return 
end
TelemetryManager.country_name_from_2char_code = function (self, iso_country_code)
	return iso_countries[iso_country_code]
end
local telemetry_data = {}
TelemetryManager._add_tech_telemetry = function (self, dt)
	local network_manager = Managers.state.network

	if network_manager then
		local fps = nil

		if dt < 1e-07 then
			fps = 0
		else
			fps = dt/1
		end

		local network_transmit = network_manager.network_transmit
		local server_peer_id = network_transmit.server_peer_id
		local my_peer_id = network_transmit.peer_id
		local player_manager = Managers.player
		local player = player_manager.player_from_peer_id(player_manager, my_peer_id)
		local telemetry_id = player.telemetry_id(player)
		local hero = player.profile_display_name(player)
		local player_unit = player.player_unit
		local position, look_yaw = nil

		if player_unit then
			local first_person_extension = ScriptUnit.extension(player_unit, "first_person_system")
			local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)
			local camera_rotation = first_person_extension.current_rotation(first_person_extension)
			look_yaw = Quaternion.yaw(camera_rotation)
			position = POSITION_LOOKUP[player_unit]
		end

		ping = (server_peer_id and Network.ping(server_peer_id)*1000) or nil

		table.clear(telemetry_data)

		telemetry_data.fps = fps
		telemetry_data.ping = ping
		telemetry_data.player_id = telemetry_id
		telemetry_data.hero = hero
		telemetry_data.position = position
		telemetry_data.look_yaw = look_yaw

		self.register_event(self, "tech_performance", telemetry_data)

		self.tech_telemetry_timer = self.current_tick + self.tech_telemetry_interval
	end

	return 
end
TelemetryManager.add_item_use_telemetry = function (self, player_id, hero, item_name, position)
	table.clear(telemetry_data)

	telemetry_data.player_id = player_id
	telemetry_data.hero = hero
	telemetry_data.item_name = item_name
	telemetry_data.position = position

	self.register_event(self, "player_use_item", telemetry_data)

	return 
end
TelemetryManager.add_matchmaking_connection_telemetry = function (self, player, connection_state, time_taken)
	local telemetry_id = player.telemetry_id(player)
	local hero = player.profile_display_name(player)

	table.clear(telemetry_data)

	telemetry_data.player_id = telemetry_id
	telemetry_data.hero = hero
	telemetry_data.connection_state = connection_state
	telemetry_data.time_taken = time_taken

	self.register_event(self, "matchmaking_connection", telemetry_data)

	return 
end
TelemetryManager.add_matchmaking_select_player_telemetry = function (self, player_id, current_hero, reason, selected_hero, time_taken)
	table.clear(telemetry_data)

	telemetry_data.player_id = player_id
	telemetry_data.current_hero = current_hero
	telemetry_data.reason = reason
	telemetry_data.selected_hero = selected_hero
	telemetry_data.time_taken = time_taken

	self.register_event(self, "ui_matchmaking_select_player", telemetry_data)

	return 
end

return 
