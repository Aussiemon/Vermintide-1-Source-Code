require("scripts/managers/account/presence/script_presence_xb1")
require("scripts/managers/account/leaderboards/script_leaderboards_xb1")
require("scripts/managers/leaderboards/leaderboard_settings")
require("scripts/managers/account/script_connected_storage_token")
require("scripts/managers/account/script_user_profile_token")
require("scripts/managers/account/smartmatch_cleaner")
require("scripts/network/xbox_user_privileges")
require("scripts/managers/account/qos/script_qos_token")
require("scripts/managers/account/privacy/script_privacy_token")

AccountManager = class(AccountManager)
AccountManager.VERSION = "xb1"
AccountManager.SIGNED_OUT = 4294967295.0
AccountManager.QUERY_BANDWIDTH_TIMER = 60
AccountManager.QUERY_BANDWIDTH_FAIL_TIMER = 10
AccountManager.QUERY_FAIL_AMOUNT = 5

local function dprint(...)
	print("[AccountManager] ", ...)
end

AccountManager.init = function (self)
	self._user_id = nil
	self._controller_id = nil
	self._achievements = nil
	self._initiated = false
	self._lobbies_to_free = {}
	self._gamertags = {}
	self._smartmatch_cleaner = SmartMatchCleaner:new()
	self._xbox_privileges = XboxUserPrivileges:new()
	self._presence = ScriptPresence:new()
	self._leaderboards = ScriptLeaderboards:new()
	self._query_bandwidth_timer = AccountManager.QUERY_BANDWIDTH_TIMER
	self._bandwidth_query_fails = 0
	self._unlocked_achievements = {}
	self._block_list = {}
	self._block_list_updated = false
end

AccountManager.block_list = function (self)
	return self._block_list
end

AccountManager.update_block_list = function (self)
	if Privacy.get_avoid_list(self._user_id) then
		self._block_list_updated = false
		local script_privacy_token = ScriptPrivacyToken:new()

		Managers.token:register_token(script_privacy_token, callback(self, "cb_block_list_updated"))
	else
		Application.error("[AccountManager] Couldn't get block list")
	end
end

AccountManager.cb_block_list_updated = function (self, block_list)
	self._block_list_updated = true
	self._block_list = block_list
end

AccountManager.set_achievement_unlocked = function (self, name)
	self._unlocked_achievements[name] = true
end

AccountManager.get_unlocked_achievement_list = function (self)
	return self._unlocked_achievements
end

AccountManager.set_level_transition_handler = function (self, level_transition_handler)
	self._level_transition_handler = level_transition_handler
end

AccountManager._set_user_id = function (self, id, controller)
	self._user_id = id
	self._user_info = XboxLive.user_info(id)
	self._player_session_id = Application.guid()
	self._active_controller = controller
	self._controller_id = controller.controller_id()
	self._backend_user_id = Application.make_hash(self:xbox_user_id())

	Application.warning(string.format("[AccountManager] Console Backend User id: %s", self._backend_user_id))
	XboxCallbacks.register_suspending_callback(callback(self, "cb_is_suspending"))
end

AccountManager.cb_is_suspending = function (self, ...)
	self._has_suspended = true

	if Managers.state.event then
		Managers.state.event:trigger("trigger_xbox_round_end")
	end

	Managers.xbox_events:flush()
end

AccountManager.set_presence = function (self, presence)
	self._presence:set_presence(presence)
end

AccountManager.set_leaderboard = function (self, leaderboard_stat_name, score, score_data)
	if self._user_id then
		self._leaderboards:set_leaderboard(self._user_info.xbox_user_id, self._player_session_id, leaderboard_stat_name, score, score_data)
	else
		callback({
			error = "No user ID"
		})
	end
end

AccountManager.test_write = function (self)
	self._leaderboards:test_write()
end

AccountManager.test_get = function (self)
	self._leaderboards:test_get()
end

AccountManager.get_leaderboard = function (self, leaderboard_name, leaderboard_type, in_callback, max_items, skip_to_rank, template)
	if self._user_id then
		self._leaderboards:get_leaderboard(self._user_id, leaderboard_name, leaderboard_type, in_callback, max_items, skip_to_rank, template)
	end
end

AccountManager.set_round_id = function (self, round_id)
	self._current_round_id = round_id or Application.guid()
end

AccountManager.round_id = function (self)
	return self._current_round_id
end

AccountManager.my_gamertag = function (self)
	local xuid = self._user_info.xbox_user_id

	return self._gamertags[xuid]
end

AccountManager.gamertag_from_xuid = function (self, xuid)
	return self._gamertags[xuid]
end

AccountManager.has_privilege = function (self, privilege)
	if self._user_id then
		return self._xbox_privileges:has_privilege(self._user_id, privilege)
	else
		return false
	end
end

AccountManager.is_privileges_initialized = function (self)
	return self._xbox_privileges:is_initialized()
end

AccountManager.has_privilege_error = function (self)
	self._xbox_privileges:has_error()
end

AccountManager.active_controller = function (self, user_id)
	return self._active_controller
end

AccountManager.user_detached = function (self)
	return self._user_detached
end

AccountManager.xbox_user_id = function (self)
	return self._user_info.xbox_user_id
end

AccountManager.backend_user_id = function (self)
	return self._backend_user_id
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

AccountManager.is_guest = function (self)
	return self._user_info and self._user_info.guest
end

AccountManager.update = function (self, dt)
	if self._initiated then
		local user_id = self._user_id

		if self._storage_token then
			self:_handle_storage_token()
		elseif user_id and not self:leaving_game() then
			self:_check_session()
			self:_verify_user_profile(dt)
			self:_verify_privileges()
			self:_verify_user_in_cache()
			self:_update_bandwidth_query(dt)
			self:_verify_user_detached_popup()
			Profiler.start("Presence")
			self._presence:update(dt)
			Profiler.stop("Presence")
		end
	end

	self:_process_popup_handle("_user_detached_popup_id")
	self:_process_popup_handle("_privilege_popup_id")
	self:_process_popup_handle("_xbox_live_connection_lost_popup_id")
	self:_process_popup_handle("_not_connected_to_xbox_live_popup_id")
	self:_update_sessions(dt)

	self._user_cache_changed = XboxLive.user_cache_changed()
end

AccountManager.reset_popups = function (self)
	self._user_detached_popup_id = nil
	self._privilege_popup_id = nil
	self._xbox_live_connection_lost_popup_id = nil
	self._not_connected_to_xbox_live_popup_id = nil
	self._fatal_error = nil
end

AccountManager._process_popup_handle = function (self, popup_id_handle)
	local popup_id = self[popup_id_handle]

	if not popup_id then
		return
	end

	local result = Managers.popup:query_result(popup_id)

	if result then
		self[popup_id_handle] = nil

		self:_handle_popup_result(result)
	end
end

AccountManager.setup_friendslist = function (self)
	if rawget(_G, "LobbyInternal") and LobbyInternal.client then
		local events = {
			Social.last_social_events()
		}

		if (table.contains(events, SocialEventType.RTA_DISCONNECT_ERR) or not self._added_local_user_to_graph) and not self._user_detached then
			Profiler.start("FRIENDS")

			local user_id = self._user_id

			if Social.add_local_user_to_graph(user_id) then
				self.title_online_friends_group_id = Social.create_filtered_social_group(user_id, SocialPresenceFilter.TITLE_ONLINE, SocialRelationshipFilter.FRIENDS)
				self.online_friends_group_id = Social.create_filtered_social_group(user_id, SocialPresenceFilter.ALL_ONLINE, SocialRelationshipFilter.FRIENDS)
				self.offline_friends_group_id = Social.create_filtered_social_group(user_id, SocialPresenceFilter.ALL_OFFLINE, SocialRelationshipFilter.FRIENDS)
				self._added_local_user_to_graph = true
			end

			Profiler.stop("FRIENDS")

			return true
		end
	end
end

AccountManager.user_cache_changed = function (self)
	return self._user_cache_changed
end

AccountManager._update_sessions = function (self, dt)
	if Network.xboxlive_client_exists() then
		if #self._lobbies_to_free > 0 then
			self:_update_lobbies_to_free()
		end

		self._smartmatch_cleaner:update(dt)
	else
		self._smartmatch_cleaner:reset()
	end

	if #self._lobbies_to_free == 0 and self._teardown_xboxlive then
		Application.warning("SHUTTING DOWN XBOX LIVE CLIENT")

		if Network.xboxlive_client_exists() then
			LobbyInternal.shutdown_xboxlive_client()
		end

		self._smartmatch_cleaner:reset()
		self:reset()

		self._added_local_user_to_graph = nil
	end
end

LOBBIES_TO_REMOVE = LOBBIES_TO_REMOVE or {}

AccountManager._update_lobbies_to_free = function (self)
	for i = #self._lobbies_to_free, 1, -1 do
		local lobby = self._lobbies_to_free[i]
		local state = lobby:state()

		if state == MultiplayerSession.SHUTDOWN then
			print("Freed a lobby")
			lobby:free()

			LOBBIES_TO_REMOVE[#LOBBIES_TO_REMOVE + 1] = i
		end
	end

	if #LOBBIES_TO_REMOVE > 0 then
		for _, index in ipairs(LOBBIES_TO_REMOVE) do
			print("Removed a lobby")
			table.remove(self._lobbies_to_free, index)
		end

		LOBBIES_TO_REMOVE = {}
	end
end

AccountManager._verify_user_profile = function (self)
	if self._user_detached_popup_id then
		return
	end

	local controller_changed = false

	if self._active_controller then
		local controller_id = self._active_controller.controller_id()
		controller_changed = controller_id ~= self._controller_id
	end

	local user_id = self._active_controller and self._active_controller.user_id()
	local user_info = user_id and XboxLive.user_info(user_id)

	if not self._active_controller or not self._active_controller.user_id() or self._active_controller.disconnected() or not user_info or self._user_info.xbox_user_id ~= user_info.xbox_user_id or not user_info.signed_in or controller_changed then
		local wanted_profile_id = self._user_info.xbox_user_id
		local wanted_profile = self._gamertags[wanted_profile_id]
		local cropped_profile = (wanted_profile and Managers.popup:fit_text_width_to_popup(wanted_profile)) or "?"
		local wrong_profile_str = string.format(Localize("controller_pairing"), cropped_profile)

		if Managers.matchmaking and Managers.matchmaking.is_server then
			Managers.matchmaking:cancel_matchmaking()
		end

		self:_verify_user_in_cache()
		self:_create_popup(wrong_profile_str, "controller_pairing_header", "verify_profile", "menu_retry", "restart", "menu_return_to_title_screen", "show_profile_picker", "menu_select_profile", true)
	end
end

AccountManager._verify_privileges = function (self)
	if not XboxLive.user_info_changed() then
		return
	end

	self._xbox_privileges:update_privilege("MULTIPLAYER_SESSIONS", callback(self, "cb_privileges_updated"))
end

AccountManager._verify_user_in_cache = function (self)
	if self._user_detached_popup_id then
		self._user_detached = true

		return
	end

	local users = {
		XboxLive.users()
	}

	for _, user in pairs(users) do
		if user.id == self._user_id then
			self._user_detached = false

			return
		end
	end

	self._user_detached = true
end

AccountManager._verify_user_detached_popup = function (self)
	if self._user_detached_popup_id or not Managers.account:user_detached() then
		return
	end

	local wanted_profile_id = self._user_info.xbox_user_id
	local wanted_profile = self._gamertags[wanted_profile_id]
	local cropped_profile = (wanted_profile and Managers.popup:fit_text_width_to_popup(wanted_profile)) or "?"
	local wrong_profile_str = string.format(Localize("controller_pairing"), cropped_profile)

	self:_create_popup(wrong_profile_str, "controller_pairing_header", "verify_profile", "menu_retry", "restart", "menu_return_to_title_screen", "show_profile_picker", "menu_select_profile", true)
end

AccountManager.user_exists = function (self, user_id)
	local users = {
		XboxLive.users()
	}

	for _, user in pairs(users) do
		if user.id == user_id then
			return true
		end
	end

	return false
end

AccountManager._update_bandwidth_query = function (self, dt)
	if GameSettingsDevelopment.bandwidth_queries_enabled then
		if self._query_bandwidth_timer <= 0 then
			self:query_bandwidth()
		end

		self._query_bandwidth_timer = self._query_bandwidth_timer - dt
	end
end

AccountManager.cb_privileges_updated = function (self, privilege)
	if not self:has_privilege(UserPrivilege.MULTIPLAYER_SESSIONS) then
		self._privilege_popup_id = Managers.popup:queue_popup(Localize("popup_xbox_live_gold_error"), Localize("popup_xbox_live_gold_error_header"), "restart_network", Localize("menu_ok"))
	end
end

AccountManager._check_session = function (self)
	if Network.fatal_error() and not self._fatal_error then
		self._xbox_live_connection_lost_popup_id = Managers.popup:queue_popup(Localize("xboxlive_connection_lost"), Localize("xboxlive_connection_lost_header"), "restart_network", Localize("menu_restart"))
		self._fatal_error = true
	end
end

AccountManager._create_popup = function (self, error, header, right_action, right_button, left_action, left_button, extra_action, extra_button, disable_localize_error)
	Managers.input:set_all_gamepads_available()
	assert(error, "[AccountManager] No error was passed to popup handler")

	local header = header or "popup_error_topic"
	local right_action = right_action
	local left_action = left_action
	local extra_action = extra_action
	local right_button = right_button and Localize(right_button)
	local left_button = left_button and Localize(left_button)
	local extra_button = extra_button and Localize(extra_button)
	local localized_error = (disable_localize_error and error) or Localize(error)

	assert(self._user_detached_popup_id == nil, "Tried to show popup even though we already had one.")
	print(error, header, right_action, right_button, left_action, left_button, extra_action, extra_button, disable_localize_error)

	if extra_action and extra_button then
		self._user_detached_popup_id = Managers.popup:queue_popup(localized_error, Localize(header), right_action, right_button, left_action, left_button, extra_action, extra_button)
	elseif left_action and left_button then
		self._user_detached_popup_id = Managers.popup:queue_popup(localized_error, Localize(header), right_action, right_button, left_action, left_button)
	else
		self._user_detached_popup_id = Managers.popup:queue_popup(localized_error, Localize(header), right_action, right_button)
	end
end

local function show_wrong_profile_popup(account_manager)
	local wanted_profile_id = account_manager._user_info.xbox_user_id
	local wanted_profile = account_manager._gamertags[wanted_profile_id]
	local cropped_profile = Managers.popup:fit_text_width_to_popup(wanted_profile or "???")
	local wrong_profile_str = string.format(Localize("wrong_profile"), cropped_profile)

	account_manager:_create_popup(wrong_profile_str, "wrong_profile_header", "verify_profile", "menu_retry", "restart", "menu_return_to_title_screen", "show_profile_picker", "menu_select_profile", true)
end

AccountManager._handle_popup_result = function (self, result)
	if result == "verify_profile" then
		self:verify_profile()
	elseif result == "restart" then
		self:initiate_leave_game()
	elseif result == "acknowledged" then
	elseif result == "restart_network" then
		self._should_teardown_xboxlive = true

		self:initiate_leave_game()
	elseif result == "show_profile_picker" then
		local controller = Managers.input:get_most_recent_device()
		local index = tonumber(string.gsub(controller._name, "Pad", ""), 10)

		XboxLive.show_account_picker(index)

		local error, device_id, user_id_old, user_id_new = XboxLive.show_account_picker_result()
		local invalid_profile_id = 4294967295.0

		if error or user_id_new == invalid_profile_id then
			show_wrong_profile_popup(self)

			return
		end

		self._active_controller = controller
		self._controller_id = self._active_controller.controller_id()

		Managers.input:set_exclusive_gamepad(self._active_controller)
		self:_verify_user_in_cache()
	else
		fassert(false, "[AccountManager] The popup result doesn't exist (%s)", result)
	end
end

AccountManager.restarting = function (self)
	return self._restarting
end

AccountManager.should_teardown_xboxlive = function (self)
	return self._should_teardown_xboxlive
end

AccountManager.teardown_xboxlive = function (self)
	self._teardown_xboxlive = true
end

AccountManager.update_popup_status = function (self)
	if not self._user_detached_popup_id then
		return
	end

	if not Managers.popup:has_popup_with_id(self._user_detached_popup_id) then
		self._user_detached_popup_id = nil
	end
end

AccountManager.verify_profile = function (self)
	if not self._initiated then
		return
	end

	local most_recent_device = Managers.input:get_most_recent_device()
	local user_id = most_recent_device.user_id()

	if not user_id then
		show_wrong_profile_popup(self)

		return
	end

	local user_info = XboxLive.user_info(most_recent_device.user_id())

	if user_info.xbox_user_id == self._user_info.xbox_user_id then
		self._active_controller = most_recent_device
		self._controller_id = self._active_controller.controller_id()

		Managers.input:set_exclusive_gamepad(self._active_controller)
		self:_verify_user_in_cache()

		if Managers.matchmaking and Managers.matchmaking.is_server then
			Managers.matchmaking:cancel_countdown()
		end
	else
		show_wrong_profile_popup(self)
	end
end

AccountManager.cb_profile_signed_out = function (self)
	local most_recent_device = Managers.input:get_most_recent_device()
	local user_info = XboxLive.user_info(most_recent_device.user_id())

	if user_info.xbox_user_id == self._user_info.xbox_user_id then
		self._active_controller = most_recent_device
		self._controller_id = self._active_controller.controller_id()

		Managers.input:set_exclusive_gamepad(self._active_controller)
	else
		print(string.format("Wrong profile: Had user_id %s - wanted user_id %s", user_info.xbox_user_id, self._user_info.xbox_user_id))
	end
end

AccountManager.sign_in = function (self, user_id, controller)
	if not user_id then
		local controller_index = self:_controller_index(controller)

		if controller_index then
			XboxLive.show_account_picker(controller_index)

			return false
		end
	elseif XboxLive.online_state() == XboxOne.ONLINE then
		self:_hard_sign_in(user_id, controller)
	else
		if not self._not_connected_to_xbox_live_popup_id then
			self._not_connected_to_xbox_live_popup_id = Managers.popup:queue_popup(Localize("failure_start_xbox_lobby_create"), Localize("xboxlive_connection_lost_header"), "acknowledged", Localize("menu_ok"))
		end

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
end

AccountManager._hard_sign_in = function (self, user_id, controller)
	dprint("Hard-sign in", user_id)
	self:_set_user_id(user_id, controller)
	self:_unmap_other_controllers()
	self:_on_user_signed_in()
end

AccountManager._unmap_other_controllers = function (self)
	Managers.input:set_exclusive_gamepad(self._active_controller)
end

AccountManager._on_user_signed_in = function (self)
	local user_id = self._user_id

	self._xbox_privileges:reset()
	self._xbox_privileges:add_user(user_id)

	self._initiated = true
end

AccountManager.get_user_profiles = function (self, user_id, xbox_user_ids, cb)
	local token = Xbone.get_user_profiles(user_id, xbox_user_ids, #xbox_user_ids)
	local user_profile_token = ScriptUserProfileToken:new(token)

	Managers.token:register_token(user_profile_token, callback(self, "cb_user_profiles"))

	self._my_user_profile_cb = cb
end

AccountManager.cb_user_profiles = function (self, data)
	if not data.error then
		for xuid, gamertag in pairs(data.user_profiles) do
			self._gamertags[xuid] = gamertag
		end
	end

	self._my_user_profile_cb(data)

	self._my_user_profile_cb = nil
end

AccountManager._handle_storage_token = function (self)
	self._storage_token:update()

	if self._storage_token:done() then
		local info = self._storage_token:info()

		self:_storage_acquired(info)

		self._storage_token = nil
	end
end

AccountManager.get_storage_space = function (self, done_callback)
	if not self._storage_id then
		local token = XboxConnectedStorage.get_storage_space(self._user_id)
		self._storage_token = ScriptConnectedStorageToken:new(XboxConnectedStorage, token)
		self._get_storage_done_callback = done_callback
	else
		done_callback({})
	end
end

AccountManager._storage_acquired = function (self, data)
	if data.error then
		Application.error("[AccountManager] There was an error in the get_storage_space operation: " .. data.error)
		self:close_storage()
	else
		self._storage_id = data.storage_id
	end

	self._get_storage_done_callback(data)

	self._get_storage_done_callback = nil
end

AccountManager.add_session_to_cleanup = function (self, session_data)
	self._smartmatch_cleaner:add_session(session_data)
end

AccountManager.add_lobby_to_free = function (self, lobby)
	self._lobbies_to_free[#self._lobbies_to_free + 1] = lobby
end

AccountManager.all_lobbies_freed = function (self)
	return #self._lobbies_to_free == 0 and self._smartmatch_cleaner:ready()
end

AccountManager.initiate_leave_game = function (self)
	self._leave_game = true

	if self._user_id then
		Presence.set(self._user_id, "")
	end
end

AccountManager.leaving_game = function (self)
	return self._leave_game
end

AccountManager.reset = function (self)
	if Network.xboxlive_client_exists() and self._user_id and self._added_local_user_to_graph then
		Social.remove_local_user_from_graph(self._user_id)

		self._added_local_user_to_graph = nil
	end

	self._user_id = nil
	self._presence = ScriptPresence:new()
	self._user_info = nil
	self._player_session_id = nil
	self._active_controller = nil
	self._leave_game = nil
	self._initiated = false
	self._storage_id = nil
	self._fatal_error = nil
	self._teardown_xboxlive = nil
	self._should_teardown_xboxlive = nil
	self._backend_user_id = nil
	self._user_detached = nil
	self._user_detached_popup_id = nil
	self._xbox_live_connection_lost_popup_id = nil
	self._not_connected_to_xbox_live_popup_id = nil
	self._privilege_popup_id = nil
	self._controller_id = nil
	self._bandwidth_query_fails = 0
	self._query_bandwidth_timer = AccountManager.QUERY_BANDWIDTH_TIMER
	self._unlocked_achievements = {}
end

AccountManager.lost_connection_to_xbox_live = function (self)
	return self._fatal_error or Network.fatal_error()
end

AccountManager.is_signed_in = function (self)
	return self._initiated
end

AccountManager.destroy = function (self)
	self:close_storage()
	self._presence:destroy()

	if Network.xboxlive_client_exists() then
		Network.clean_sessions()
	end
end

AccountManager.close_storage = function (self)
	print("closing storage")

	if self._storage_id then
		XboxConnectedStorage.finish(self._storage_id)
		print("Storage Closed")
	else
		print("Storage Not Open")
	end

	self._storage_id = nil
	self._storage_token = nil
end

AccountManager.set_controller_disconnected = function (self, disconnected)
	self._controller_disconnected = disconnected
end

AccountManager.controller_disconnected = function (self)
	return self._controller_disconnected
end

local friend_data = {}

AccountManager.get_friends = function (self, friends_list_limit, callback)
	table.clear(friend_data)

	if self._added_local_user_to_graph then
		local title_online_friends = {
			Social.social_group(self.title_online_friends_group_id)
		}
		local num_title_online_friends = #title_online_friends
		local online_friends = {
			Social.social_group(self.online_friends_group_id)
		}
		local num_online_friends = #online_friends
		local offline_friends = {
			Social.social_group(self.offline_friends_group_id)
		}
		local num_offline_friends = #offline_friends

		for i = 1, num_title_online_friends, 1 do
			local data = title_online_friends[i]
			local id = data.xbox_user_id
			data.name = data.display_name
			data.status = "online"
			data.playing_this_game = true
			friend_data[id] = data
		end

		for i = 1, num_online_friends, 1 do
			local data = online_friends[i]
			local id = data.xbox_user_id

			if not friend_data[id] then
				data.name = data.display_name
				data.status = "online"
				data.playing_this_game = false
				friend_data[id] = data
			end
		end

		for i = 1, num_offline_friends, 1 do
			local data = offline_friends[i]
			local id = data.xbox_user_id
			data.name = data.display_name
			data.status = "offline"
			data.playing_this_game = false
			friend_data[id] = data
		end
	end

	callback(friend_data)
end

AccountManager.send_session_invitation = function (self, id, lobby)
	local friends_to_invite = {
		id
	}

	lobby:invite_friends_list(friends_to_invite)
end

AccountManager.set_current_lobby = function (self, lobby)
	return
end

AccountManager.reset_bandwidth_query = function (self)
	self._bandwidth_query_fails = 0
	self._query_bandwidth_timer = AccountManager.QUERY_BANDWIDTH_TIMER
end

AccountManager.query_bandwidth = function (self, down_kbps, up_kbps, timeout_in_ms)
	if self._querying_bandwidth or not Network.xboxlive_client_exists() or (Managers.voice_chat and Managers.voice_chat:bandwidth_disabled()) then
		return
	end

	local token = QoS.query_bandwidth(down_kbps or 192, up_kbps or 192, timeout_in_ms or 5000)

	if token then
		local script_token = ScriptQoSToken:new(token)

		Managers.token:register_token(script_token, callback(self, "cb_bandwidth_query"))

		self._querying_bandwidth = true
	else
		Application.warning("[AccountManager:query_bandwidth] QUERY FAILED TO INITIALIZE")

		self._querying_bandwidth = nil
		self._bandwidth_query_fails = 0
		self._query_bandwidth_timer = AccountManager.QUERY_BANDWIDTH_TIMER
	end
end

AccountManager.cb_bandwidth_query = function (self, data)
	if data.error then
		Application.warning("[AccountManager:query_bandwidth] FAILED! reason: " .. data.error)

		self._bandwidth_query_fails = self._bandwidth_query_fails + 1
		self._query_bandwidth_timer = AccountManager.QUERY_BANDWIDTH_FAIL_TIMER

		if AccountManager.QUERY_FAIL_AMOUNT <= self._bandwidth_query_fails then
			if Managers.voice_chat and not Managers.voice_chat:bandwidth_disabled() then
				Managers.voice_chat:bandwitdth_disable_voip()
			end

			self._bandwidth_query_fails = 0
			self._query_bandwidth_timer = AccountManager.QUERY_BANDWIDTH_TIMER
		end
	else
		Application.warning("[AccountManager:query_bandwidth] : SUCCESS!")

		self._bandwidth_query_fails = 0
		self._query_bandwidth_timer = AccountManager.QUERY_BANDWIDTH_TIMER
	end

	self._querying_bandwidth = nil
end

return
