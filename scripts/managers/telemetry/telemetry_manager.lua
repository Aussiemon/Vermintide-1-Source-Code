require("scripts/managers/telemetry/curl_token")
require("scripts/managers/telemetry/telemetry_events")
require("scripts/managers/telemetry/telemetry_rpc_listener")

local DEBUG = Development.parameter("debug-telemetry")
TelemetryManager = class(TelemetryManager)
TelemetryManager.init = function (self)
	self.reset(self)

	self.events = TelemetryEvents:new(self)
	self.rpc_listener = TelemetryRPCListener:new(self.events)

	return 
end
TelemetryManager.reset = function (self)
	self._events_json = {}
	self._current_tick = 0

	return 
end
TelemetryManager.update = function (self, dt)
	self._current_tick = self._current_tick + dt

	return 
end
local BLACKLIST = table.set(TelemetrySettings.blacklist or {})
local event_entry = {}
TelemetryManager.register_event = function (self, event_type, event_params)
	if BLACKLIST[event_type] then
		if DEBUG then
			printf("[TelemetryManager] Blacklisted event '%s'", event_type)
		end

		return 
	end

	for k, param in pairs(event_params) do
		if type(param) == "userdata" then
			event_params[k] = tostring(param)
		end
	end

	event_entry.tick = self._current_tick
	event_entry.type = event_type
	event_entry.params = event_params
	local encoded_event = cjson.encode(event_entry)

	table.insert(self._events_json, encoded_event)

	if DEBUG then
		printf("[TelemetryManager] Registering event '%s' %s", event_type, encoded_event)
	end

	return 
end
local TITLE_ID = TelemetrySettings.title_id
local COMPRESS = T(TelemetrySettings.compress, true)
local AUTH_TYPE = T(TelemetrySettings.auth_type, 0)
TelemetryManager.send = function (self)
	local events_as_string = table.concat(self._events_json, "\n")
	local file_name = sprintf("%s_%s", TITLE_ID, math.uuid())
	local url = string.format("%s%s", TelemetrySettings.ftp_address, file_name)
	local token = Curl.add_send_request(url, events_as_string, COMPRESS, AUTH_TYPE)

	return CurlToken:new(token)
end

return 
