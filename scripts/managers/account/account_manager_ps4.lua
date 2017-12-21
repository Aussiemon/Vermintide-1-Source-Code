require("scripts/managers/account/script_web_api_psn")
require("scripts/utils/base64")

local PresenceSet = require("scripts/settings/presence_set")
AccountManager = class(AccountManager)
AccountManager.VERSION = "ps4"

local function dprint(...)
	print("[AccountManager] ", ...)

	return 
end

AccountManager.init = function (self)
	self._np_id = PS4.np_id()
	self._web_api = ScriptWebApiPsn:new()
	self._initial_user_id = PS4.initial_user_id()

	Trophies.create_context(self._initial_user_id)

	self._room_state = nil
	self._current_room = nil
	self._session = {}
	self._has_presence_game_data = false
	self._np_title_id = nil
	self._requesting_np_title_id = false

	return 
end
AccountManager.np_title_id = function (self)
	return self._np_title_id
end
AccountManager.initial_user_id = function (self)
	return self._initial_user_id
end
AccountManager.np_id = function (self)
	return self._np_id
end
AccountManager.set_current_lobby = function (self, lobby)
	self._current_room = lobby

	return 
end
AccountManager.leaving_game = function (self)
	return 
end
AccountManager.reset = function (self)
	return 
end
AccountManager.destroy = function (self)
	self._web_api:destroy()

	self._web_api = nil

	if self._has_presence_game_data then
		self.delete_presence_game_data(self)
	end

	local session = self._session

	if session then
		if session.is_owner then
			self.delete_session(self)
		else
			self.leave_session(self)
		end
	end

	return 
end
AccountManager.update = function (self, dt)
	self._aquire_np_title_id(self, dt)
	self._update_psn(self)
	self._web_api:update(dt)

	return 
end
AccountManager._aquire_np_title_id = function (self, dt)
	if self._np_title_id then
		return 
	end

	if self._requesting_np_title_id then
		return 
	else
		self._request_np_title_timer = (self._request_np_title_timer and self._request_np_title_timer + dt) or 10

		if 10 <= self._request_np_title_timer then
			self.get_user_presence(self, self._np_id, callback(self, "_cb_presence_aquired"))

			self._requesting_np_title_id = true
			self._request_np_title_timer = 0
		end
	end

	return 
end
AccountManager._update_psn = function (self)
	local room = self._current_room
	local room_state_current = room and room.state(room)
	local room_state_previous = self._room_state
	local room_joined = room_state_previous ~= PsnRoom.JOINED and room_state_current == PsnRoom.JOINED
	local room_left = room_state_previous == PsnRoom.JOINED and room_state_current ~= PsnRoom.JOINED

	self._update_psn_presence(self, room_joined, room_left)
	self._update_psn_session(self, room_joined, room_left)

	self._room_state = room_state_current

	return 
end
AccountManager._update_psn_presence = function (self, room_joined, room_left)
	if room_joined then
		local room = self._current_room
		local room_id = room.sce_np_room_id(room)

		self.set_presence_game_data(self, room_id)
	elseif room_left then
		self._current_room = nil
	end

	return 
end
AccountManager._update_psn_session = function (self, room_joined, room_left)
	local session = self._session
	local room = self._current_room

	if room_joined then
		local room_id = room.sce_np_room_id(room)

		if room.lobby_host(room) == Network.peer_id() then
			self.create_session(self, room_id)
		else
			local room_data = LobbyInternal.get_lobby_data_from_id(room_id)
			local session_id = room_data.session_id

			if session_id then
				self.join_session(self, session_id)
			end
		end
	elseif room_left and session then
		if session.is_owner then
			self.delete_session(self)
		else
			self.leave_session(self)
		end
	end

	return 
end
AccountManager.current_psn_session = function (self)
	local session = self._session

	return session and session.id
end
AccountManager.all_lobbies_freed = function (self)
	return true
end
AccountManager.get_friends = function (self, friends_list_limit, response_callback)
	local np_id = self._np_id
	local api_group = "userProfile"
	local path = string.format("/v1/users/%s/friendList?friendStatus=friend&presenceType=primary&presenceDetail=true&fields=onlineId,personalDetail&limit=%s", tostring(np_id), tostring(friends_list_limit))
	local method = WebApi.GET
	local content = nil

	self._web_api:send_request(np_id, api_group, path, method, content, response_callback)

	return 
end
AccountManager.get_user_presence = function (self, np_id, response_callback)
	local own_np_id = self._np_id
	local api_group = "userProfile"
	local path = string.format("/v1/users/%s/presence?type=platform&platform=PS4", tostring(np_id))
	local method = WebApi.GET
	local content = nil

	self._web_api:send_request(own_np_id, api_group, path, method, content, response_callback)

	return 
end
AccountManager.set_presence = function (self, presence, append_string)
	local np_id = self._np_id
	local api_group = "userProfile"
	local path = string.format("/v1/users/%s/presence/gameStatus", tostring(np_id))
	local method = WebApi.PUT
	local content = self._set_presence_status_content(self, presence, append_string)

	self._web_api:send_request(np_id, api_group, path, method, content)

	return 
end
AccountManager.set_presence_game_data = function (self, room_id)
	local np_id = self._np_id
	local api_group = "userProfile"
	local path = string.format("/v1/users/%s/presence/gameData", tostring(np_id))
	local method = WebApi.PUT
	local game_data = to_base64(room_id)
	local content = {
		gameData = game_data
	}

	self._web_api:send_request(np_id, api_group, path, method, content)

	self._has_presence_game_data = true

	return 
end
AccountManager.delete_presence_game_data = function (self)
	local np_id = self._np_id
	local api_group = "userProfile"
	local path = string.format("/v1/users/%s/presence/gameData", tostring(np_id))
	local method = WebApi.DELETE

	self._web_api:send_request(np_id, api_group, path, method)

	self._has_presence_game_data = false

	return 
end
AccountManager.create_session = function (self, room_id)
	assert(room_id, "[AccountManager] Tried to create psn session but parameter \"room_id\" is missing")

	local np_id = self._np_id
	local session_parameters_table = {
		status = "[Session Status should be here]",
		name = "[Session Name should be here]",
		lock_flag = false,
		type = "owner-bind",
		privacy = "public",
		max_user = 4,
		platforms = "[\"PS4\"]"
	}
	local session_parameters = self._format_session_parameters(self, session_parameters_table)
	local session_image = "/app0/content/session_images/session_image_default.jpg"
	local session_data = room_id
	local changable_session_data = nil

	self._web_api:send_request_create_session(np_id, session_parameters, session_image, session_data, changable_session_data, callback(self, "_cb_session_created"))

	return 
end
AccountManager._cb_session_created = function (self, result)
	if result then
		local session_id = result.sessionId
		self._session = {
			is_owner = true,
			id = session_id
		}
		local room = self._current_room

		if room then
			room.set_data(room, "session_id", session_id)
		end
	else
		self._session = nil
	end

	return 
end
AccountManager._cb_presence_aquired = function (self, result)
	if result then
		local presence = result.presence
		local platform_info_list = presence.platformInfoList
		local game_title_info = platform_info_list[1].gameTitleInfo
		self._np_title_id = game_title_info.npTitleId
	else
		self._requesting_np_title_id = false
	end

	return 
end
AccountManager.delete_session = function (self)
	local np_id = self._np_id
	local session_id = self._session.id
	local api_group = "sessionInvitation"
	local path = string.format("/v1/sessions/%s", session_id)
	local method = WebApi.DELETE

	self._web_api:send_request(np_id, api_group, path, method)

	self._session = nil

	return 
end
AccountManager.join_session = function (self, session_id)
	local np_id = self._np_id
	local api_group = "sessionInvitation"
	local path = string.format("/v1/sessions/%s/members", tostring(session_id))
	local method = WebApi.POST

	self._web_api:send_request(np_id, api_group, path, method)

	self._session = {
		is_owner = false,
		id = session_id
	}

	return 
end
AccountManager.leave_session = function (self)
	local session_id = self._session.id
	local np_id = self._np_id
	local api_group = "sessionInvitation"
	local path = string.format("/v1/sessions/%s/members/%s", tostring(session_id), tostring(np_id))
	local method = WebApi.DELETE

	self._web_api:send_request(np_id, api_group, path, method)

	self._session = nil

	return 
end
AccountManager.get_session_data = function (self, session_id, response_callback)
	local np_id = self._np_id
	local api_group = "sessionInvitation"
	local path = string.format("/v1/sessions/%s/sessionData", tostring(session_id))
	local method = WebApi.GET
	local content = nil
	local response_format = WebApi.STRING

	self._web_api:send_request(np_id, api_group, path, method, content, response_callback, response_format)

	return 
end
AccountManager.send_session_invitation = function (self, to_np_id)
	local np_id = self._np_id
	local session_id = self._session.id
	local message = "[Invitation Message should be here]"
	local params = ""
	params = params .. "{\r\n"
	params = params .. "  \"to\":[\r\n"
	params = params .. string.format("    \"%s\"\r\n", to_np_id)
	params = params .. "  ],\r\n"
	params = params .. string.format("  \"message\":\"%s\"\r\n", message)
	params = params .. "}"

	self._web_api:send_request_session_invitation(np_id, params, session_id)

	return 
end
AccountManager._format_session_parameters = function (self, params)
	local str = ""
	str = str .. "{\r\n"
	str = str .. string.format("  \"sessionType\":%q,\r\n", params.type)
	str = str .. string.format("  \"sessionPrivacy\":%q,\r\n", params.privacy)
	str = str .. string.format("  \"sessionMaxUser\":%s,\r\n", tostring(params.max_user))

	if params.name then
		str = str .. string.format("  \"sessionName\":%q,\r\n", params.name)
	end

	if params.status then
		str = str .. string.format("  \"sessionStatus\":%q,\r\n", params.status)
	end

	str = str .. string.format("  \"availablePlatforms\":%s,\r\n", params.platforms)
	str = str .. string.format("  \"sessionLockFlag\":%s\r\n", (params.lock_flag and "true") or "false")
	str = str .. "}"

	return str
end
AccountManager._set_presence_status_content = function (self, presence, append)
	local append = append
	local presence_data = PresenceSet[presence] or {
		"en"
	}

	if not PresenceSet[presence] then
		Application.error(string.format("[AccountManager:set_presence] \"%s\" could not be found in PresenceSet - defaulting to english", presence))
	end

	local str = ""
	str = str .. "{\r\n"
	str = str .. string.format("  \"gameStatus\":%q,\r\n", Localize(presence .. "_en") .. ((append and " " .. Localize(append)) or ""))
	str = str .. "  \"localizedGameStatus\":[\r\n"

	if presence_data then
		for idx, language in ipairs(presence_data) do
			str = str .. "    {\r\n"
			str = str .. string.format("      \"npLanguage\":%q,\r\n", language)
			str = str .. string.format("      \"gameStatus\":%q\r\n", Localize(presence .. "_" .. language) .. ((append and " " .. Localize(append .. "_" .. language)) or ""))
			str = str .. ((idx < #presence_data and "    },\r\n") or "    }\r\n")
		end
	end

	str = str .. "  ]\r\n"
	str = str .. "}"

	return str
end

return 
