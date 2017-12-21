function MATCHMAKING_GENERIC_MESSAGE_RECEIVER(self, sender, message_id, ...)
	local func = self[NetworkLookup.matchmaking_messages[message_id]]

	if func then
		func(self, sender, ...)
	end

	return 
end

require("scripts/managers/matchmaking/matchmaking_state_search_players")
require("scripts/managers/matchmaking/matchmaking_state_search_game")
require("scripts/managers/matchmaking/matchmaking_state_request_join_game")
require("scripts/managers/matchmaking/matchmaking_state_request_profiles")
require("scripts/managers/matchmaking/matchmaking_state_start_game")
require("scripts/managers/matchmaking/matchmaking_state_host_game")
require("scripts/managers/matchmaking/matchmaking_state_join_game")
require("scripts/managers/matchmaking/matchmaking_state_idle")
require("scripts/managers/matchmaking/matchmaking_state_ingame")
require("scripts/managers/matchmaking/matchmaking_state_friend_client")
require("scripts/managers/matchmaking/matchmaking_handshaker")

if Application.platform() == "xb1" then
	require("scripts/managers/matchmaking/matchmaking_state_start_host_game")
end

MatchmakingManager = class(MatchmakingManager)
script_data.matchmaking_debug = script_data.matchmaking_debug or Development.parameter("matchmaking_debug")

function mm_printf(format_text, ...)
	if script_data.matchmaking_debug then
		format_text = "[Matchmaking] " .. format_text

		printf(format_text, ...)
	end

	return 
end

function mm_printf_force(format_text, ...)
	format_text = "[Matchmaking] " .. format_text

	printf(format_text, ...)

	return 
end

local player_slots = {}

for i = 1, 5, 1 do
	player_slots[i] = "player_slot_" .. tostring(i)
end

local ALWAYS_HOST_GAME = false
MatchmakingSettings = {
	TIME_BETWEEN_EACH_SEARCH = 3.4,
	MAX_NUM_LOBBIES = 100,
	START_GAME_TIME = 5,
	REQUEST_JOIN_LOBBY_REPLY_TIME = 30,
	MIN_STATUS_MESSAGE_TIME = 2,
	TOTAL_GAME_SEARCH_TIME = 90,
	afk_force_stop_mm_timer = 180,
	afk_warn_timer = 150,
	MAX_NUMBER_OF_PLAYERS = 4,
	host_games = "auto",
	restart_search_after_host_cancel = true,
	auto_ready = false,
	REQUEST_PROFILES_REPLY_TIME = 10,
	JOIN_LOBBY_TIME_UNTIL_AUTO_CANCEL = 20,
	LOBBY_FINDER_UPDATE_INTERVAL = 1,
	max_distance_filter = (GameSettingsDevelopment.network_mode == "lan" and LobbyDistanceFilter.MEDIUM) or LobbyDistanceFilter.MEDIUM,
	allowed_profiles = {
		true,
		true,
		true,
		true,
		true
	},
	hero_search_filter = {
		true,
		true,
		true,
		true,
		true
	}
}
local network_options = {
	project_hash = "bulldozer",
	config_file_name = "global",
	lobby_port = GameSettingsDevelopment.network_port,
	max_members = MAX_NUMBER_OF_PLAYERS
}
local RPCS = {
	"rpc_matchmaking_generic_message",
	"rpc_matchmaking_request_join_lobby",
	"rpc_matchmaking_request_profile",
	"rpc_set_matchmaking",
	"rpc_matchmaking_request_join_lobby_reply",
	"rpc_notify_connected",
	"rpc_matchmaking_update_profiles_data",
	"rpc_matchmaking_request_profile_reply",
	"rpc_matchmaking_request_profiles_data_reply",
	"rpc_matchmaking_set_ready",
	"rpc_matchmaking_request_selected_level_reply",
	"rpc_matchmaking_request_selected_difficulty_reply",
	"rpc_matchmaking_status_message",
	"rpc_set_client_game_privacy"
}
MatchmakingBrokenLobbies = MatchmakingBrokenLobbies or {}
MatchmakingManager.rpc_matchmaking_generic_message = MATCHMAKING_GENERIC_MESSAGE_RECEIVER
MatchmakingManager.init = function (self, params)
	self.network_transmit = params.network_transmit
	self.lobby = params.lobby
	self.peer_id = params.peer_id
	self.is_server = params.is_server
	self.level_transition_handler = params.level_transition_handler
	self.profile_synchronizer = params.profile_synchronizer
	self.statistics_db = params.statistics_db
	self.handshaker_host = MatchmakingHandshakerHost:new(self.network_transmit)
	self.handshaker_client = MatchmakingHandshakerClient:new()
	self.peers_to_sync = {}
	local lobby_finder = LobbyFinder:new(network_options, MatchmakingSettings.MAX_NUM_LOBBIES, true)
	self.lobby_finder = lobby_finder
	params.lobby_finder = lobby_finder
	params.network_options = network_options
	params.matchmaking_manager = self
	params.network_hash = self.network_hash
	params.handshaker_host = self.handshaker_host
	params.handshaker_client = self.handshaker_client
	self.params = params
	self.state_context = {}
	self.debug = {
		text = "",
		progression = "",
		lobby_timer = 0,
		state = "",
		hero = "",
		difficulty = "",
		level = ""
	}
	self.ready_peers = {}
	self.started_matchmaking_t = nil

	if not self.is_server then
		self.handshaker_client:start_handshake(self.lobby:lobby_host())
		self._change_state(self, MatchmakingStateIdle, self.params, {})
	end

	self.portrait_index_table = {}

	self.reset_lobby_filters(self)
	mm_printf("initializing")
	mm_printf("my_peer_id: %s, I am %s", Network:peer_id(), (self.is_server and "server") or "client")
	self.add_default_filter_requirements(self)

	self.lobby_finder_timer = 0
	self.profile_update_time = 0

	return 
end
MatchmakingManager.reset_ping = function (self)
	self.handshaker_host:reset_ping()

	return 
end
MatchmakingManager.reset_lobby_filters = function (self)
	LobbyInternal.clear_filter_requirements()
	self.add_default_filter_requirements(self)

	return 
end
MatchmakingManager.get_players_ping = function (self)
	if self.is_server then
		return self.handshaker_host.pings_by_peer_id
	else
		return self.handshaker_client.pings_by_peer_id
	end

	return 
end
MatchmakingManager.set_statistics_db = function (self, statistics_db)
	self.statistics_db = statistics_db
	self.params.statistics_db = statistics_db

	return 
end
MatchmakingManager.set_matchmaking_ui = function (self, matchmaking_ui, ingame_ui)
	self.matchmaking_ui = matchmaking_ui
	self.params.matchmaking_ui = matchmaking_ui
	self.ingame_ui = ingame_ui
	self.lobby_browser_view_ui = ingame_ui.views.lobby_browser_view

	return 
end
MatchmakingManager.setup_post_init_data = function (self, post_init_data)
	self.difficulty_manager = post_init_data.difficulty
	self.params.hero_spawner_handler = post_init_data.hero_spawner_handler
	self.params.difficulty = post_init_data.difficulty
	self.params.wwise_world = post_init_data.wwise_world

	if post_init_data.reset_matchmaking and self.is_server then
		self.cancel_matchmaking(self)
	end

	if self.is_server then
		local is_matchmaking = self.lobby:lobby_data("matchmaking")

		if is_matchmaking == "true" then
			self._change_state(self, MatchmakingStateIngame, self.params, {})
		else
			self._change_state(self, MatchmakingStateIdle, self.params, {})
		end
	end

	local map_save_data = SaveData.map_save_data

	if map_save_data then
		MatchmakingSettings.host_games = map_save_data.host_option
		MatchmakingSettings.auto_ready = map_save_data.selected_ready_option
	end

	self.profile_update_time = 0

	return 
end
MatchmakingManager.destroy = function (self)
	mm_printf("destroying")

	if self._state and self._state.on_exit then
		self._state:on_exit()
	end

	self.lobby_finder:destroy()
	self.handshaker_host:destroy()
	self.handshaker_client:destroy()

	self.matchmaking_ui = nil
	self.params.matchmaking_ui = nil

	if self.afk_popup_id then
		Managers.popup:cancel_popup(self.afk_popup_id)

		self.afk_popup_id = nil
	end

	return 
end
MatchmakingManager.register_rpcs = function (self, network_event_delegate)
	mm_printf("register rpcs")
	fassert(self.network_event_delegate == nil, "trying to register rpcs without a network_event_delegate..")

	self.network_event_delegate = network_event_delegate
	self.params.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))
	self.handshaker_host:register_rpcs(network_event_delegate)
	self.handshaker_client:register_rpcs(network_event_delegate)

	return 
end
MatchmakingManager.unregister_rpcs = function (self)
	mm_printf("unregister rpcs")
	fassert(self.network_event_delegate ~= nil, "trying to unregister rpcs without a network_event_delegate..")
	self.handshaker_client:unregister_rpcs()
	self.handshaker_host:unregister_rpcs()
	self.network_event_delegate:unregister(self)

	self.params.network_event_delegate = nil
	self.network_event_delegate = nil

	return 
end
MatchmakingManager._change_state = function (self, new_state, params, state_context)
	if self._state and self._state.NAME == new_state.NAME then
		return 
	end

	if self._state then
		if self._state.on_exit then
			mm_printf("Exiting state %s with on_exit()", self._state.NAME)
			self._state:on_exit()
		else
			mm_printf("Exiting %s", self._state.NAME)
		end
	end

	self._state = new_state.new(new_state, params)
	self._state.parent = self._parent

	if self._state.on_enter then
		mm_printf("Entering %s on_enter() ", new_state.NAME)
		self._state:on_enter(state_context)
	else
		mm_printf("Entering %s", new_state.NAME)
	end

	return 
end
MatchmakingManager.get_portrait_index = function (self, peer_id)
	local portrait_index_table = self.portrait_index_table

	for i = 1, MatchmakingSettings.MAX_NUMBER_OF_PLAYERS, 1 do
		local player_peer_id = portrait_index_table[i]

		if player_peer_id == peer_id then
			return i
		end
	end

	return 
end
MatchmakingManager._get_first_free_portrait_index = function (self)
	local portrait_index_table = self.portrait_index_table

	for i = 1, MatchmakingSettings.MAX_NUMBER_OF_PLAYERS, 1 do
		local player_peer_id = portrait_index_table[i]

		if player_peer_id == nil then
			return i
		end
	end

	return 
end
MatchmakingManager.update = function (self, dt, t)
	if self.ingame_ui.current_view then
		self.matchmaking_ui:set_minimize(true)
	else
		self.matchmaking_ui:set_minimize(false)
	end

	if self._state then
		self.debug.statename = self._state.NAME

		self.update_cancel_input(self, dt)

		local state_name = self._state.NAME

		Profiler.start(state_name)

		local new_state, state_context = self._state:update(dt, t)

		Profiler.stop(state_name)

		if new_state then
			local new_state_name = new_state.NAME

			self._change_state(self, new_state, self.params, state_context)
		end
	end

	local lobby = self.lobby

	if self.is_server and lobby.is_joined(lobby) then
		if self.profile_update_time < t or self.matchmaking_ui.is_in_inn then
			Profiler.start("Update profile slots")

			self.profile_update_time = t + 1
			local members_map = lobby.members(lobby):members_map()
			local stored_lobby_data = lobby.get_stored_lobby_data(lobby)
			local num_profiles = #SPProfiles
			local change_found = false
			local player_manager = Managers.player
			local profile_synchronizer = self.profile_synchronizer
			local players = player_manager.human_players(player_manager)

			for i = 1, num_profiles, 1 do
				local index_name = player_slots[i]
				local player_slot = lobby.lobby_data(lobby, index_name)
				local profile_owner = profile_synchronizer.owner(profile_synchronizer, i)

				if player_slot == "available" and profile_owner ~= nil and members_map[profile_owner.peer_id] ~= nil and profile_owner.local_player_id == 1 then
					change_found = true

					mm_printf("Assigning profile slot %s to peer_id", index_name, profile_owner.peer_id)

					stored_lobby_data[index_name] = profile_owner.peer_id .. ":1"
				elseif player_slot ~= "available" and profile_owner == nil then
					mm_printf("Unassigning profile slot %s (was assigned to %s)", index_name, player_slot)

					stored_lobby_data[index_name] = "available"
					change_found = true
				end
			end

			if change_found then
				lobby.set_lobby_data(lobby, stored_lobby_data)
			end

			Profiler.stop("Update profile slots")
		end

		state_name = self._state and self._state.NAME
		local is_matchmaking = state_name == "MatchmakingStateSearchPlayers" or state_name == "MatchmakingStateSearchGame"

		if is_matchmaking and self.matchmaking_ui.is_in_inn then
			local time_since_input_active = t - Managers.input.last_active_time
			local host_afk_warn = MatchmakingSettings.afk_warn_timer < time_since_input_active
			local host_afk_cancel_mm = MatchmakingSettings.afk_force_stop_mm_timer < time_since_input_active
			local can_flash_window = _G.Window ~= nil and Window.flash_window ~= nil and not Window.has_focus()

			if host_afk_warn and self.afk_popup_id == nil then
				self.afk_popup_id = Managers.popup:queue_popup(Localize("popup_afk_warning"), Localize("popup_error_topic"), "ok", Localize("button_ok"))

				if can_flash_window then
					Window.flash_window(nil, "start", 5)
				end

				self.send_system_chat_message(self, "popup_afk_warning")
			elseif host_afk_cancel_mm then
				if self.afk_popup_id then
					Managers.popup:cancel_popup(self.afk_popup_id)
				end

				self.afk_popup_id = Managers.popup:queue_popup(Localize("popup_afk_mm_cancelled"), Localize("popup_error_topic"), "ok", Localize("button_ok"))

				if can_flash_window then
					Window.flash_window(nil, "start", 1)
				end

				self.send_system_chat_message(self, "popup_afk_mm_cancelled")
				self.cancel_matchmaking(self)
			end
		end

		if self.afk_popup_id then
			local popup_result = Managers.popup:query_result(self.afk_popup_id)

			if popup_result then
				self.afk_popup_id = nil
			end
		end
	end

	local MatchmakingBrokenLobbies = MatchmakingBrokenLobbies

	for lobby_id, time_to_clear in pairs(MatchmakingBrokenLobbies) do
		if time_to_clear < t then
			mm_printf("Removing broken lobby %s, perhaps it will now work again?!", tostring(lobby_id))

			MatchmakingBrokenLobbies[lobby_id] = nil
		end
	end

	if self.is_server then
		local is_matchmaking, private_game = self.is_game_matchmaking(self)

		for peer_id, _ in pairs(self.peers_to_sync) do
			if self.handshaker_host:handshake_done(peer_id) then
				self.peers_to_sync[peer_id] = nil

				self.handshaker_host:send_rpc_to_client("rpc_set_matchmaking", peer_id, is_matchmaking, private_game)
			end
		end

		self.handshaker_host:update(t)
	end

	if self.handshaker_client.host_peer_id and self.network_transmit.connection_handler.current_connections[self.handshaker_client.host_peer_id] == nil then
		mm_printf_force("No connection to host, cancelling matchmaking")
		self.cancel_matchmaking(self)
		self.network_transmit:queue_local_rpc("rpc_stop_enter_game_countdown")
	end

	local profile_synchronizer = self.profile_synchronizer
	local player_manager = Managers.player
	local portrait_index = 0
	local lobby = self.lobby
	local lobby_members = lobby.members(lobby)
	local members = lobby_members and lobby_members.members_map(lobby_members)

	if members then
		Profiler.start("update_portraits")

		local portrait_index_table = self.portrait_index_table

		for i = 1, MatchmakingSettings.MAX_NUMBER_OF_PLAYERS, 1 do
			local peer_id = portrait_index_table[i]

			if peer_id and not members[peer_id] then
				portrait_index_table[i] = nil

				self.matchmaking_ui:large_window_set_player_portrait(i, nil)
				self.matchmaking_ui:large_window_set_player_connecting(i, false)
				self.matchmaking_ui:large_window_set_player_ready_state(i, false)

				self.ready_peers[peer_id] = nil
			end
		end

		for peer_id, _ in pairs(members) do
			local portrait_index = self.get_portrait_index(self, peer_id)

			if not portrait_index then
				portrait_index = self._get_first_free_portrait_index(self)
				portrait_index_table[portrait_index] = peer_id
			end

			local profile = profile_synchronizer.profile_by_peer(profile_synchronizer, peer_id, 1)

			if profile then
				local display_name = SPProfiles[profile].unit_name

				self.matchmaking_ui:large_window_set_player_portrait(portrait_index, display_name)

				if player_manager.player_from_peer_id(player_manager, peer_id) then
					self.matchmaking_ui:large_window_set_player_connecting(portrait_index, false)
				end
			else
				self.matchmaking_ui:large_window_set_player_connecting(portrait_index, true)
				self.matchmaking_ui:large_window_set_player_ready_state(portrait_index, false)

				self.ready_peers[peer_id] = nil
			end
		end

		Profiler.stop("update_portraits")
	end

	if self.started_matchmaking_t then
		local matchmaking_time = t - self.started_matchmaking_t

		self.matchmaking_ui:large_window_set_time(matchmaking_time)
	end

	local level_key = self.level_transition_handler:get_current_level_keys()
	local is_in_inn = level_key and level_key == "inn_level"
	local lobby_browser_active = self.lobby_browser_view_ui and self.lobby_browser_view_ui.active
	local searching_for_games = self._state.NAME == "MatchmakingStateSearchGame"
	local update_lobby_finder = (is_in_inn and lobby_browser_active) or searching_for_games

	if update_lobby_finder and Application.platform() ~= "xb1" then
		self.lobby_finder_timer = self.lobby_finder_timer - dt

		if self.lobby_finder_timer < 0 then
			Profiler.start("lobby_finder")
			self.lobby_finder:update(dt)

			self.lobby_finder_timer = MatchmakingSettings.LOBBY_FINDER_UPDATE_INTERVAL

			Profiler.stop("lobby_finder")
		end
	end

	if DebugKeyHandler.key_pressed("f6", "start quick search", "network", "left shift") then
		self.find_game(self, "whitebox_tutorial", "normal", false, false, t)
	end

	if script_data.debug_lobbies then
		if self._state == MatchmakingStateSearchGame then
			return 
		end

		self.debug.lobby_timer = self.debug.lobby_timer - dt

		if self.debug.lobby_timer < 0 then
			self.debug.lobbies = self.lobby_finder:lobbies()
			self.debug.lobby_timer = MatchmakingSettings.TIME_BETWEEN_EACH_SEARCH
		end

		if DebugKeyHandler.key_pressed("f7", "join your other client", "network", "left shift") then
			local lobbies = self.lobby_finder:lobbies()

			for i = 1, #lobbies, 1 do
				local lobby_data = lobbies[i]

				if lobby_data.host ~= self.peer_id and lobby_data.unique_server_name == Development.parameter("unique_server_name") then
					mm_printf("Joining 'friend' lobby using F7")

					self.lobby_to_join = lobby_data

					break
				end
			end
		end

		if 1 < #self.lobby_finder:lobbies() and self._state.NAME == "MatchmakingStateIdle" then
			local start_matchmaking_timer = Development.parameter("start_matchmaking_timer")

			if start_matchmaking_timer and self.start_matchmaking_time == nil then
				self.start_matchmaking_time = t + start_matchmaking_timer
			end

			if self.start_matchmaking_time and self.start_matchmaking_time < t then
				self.start_matchmaking_time = t + 1000000

				self.find_game(self, "whitebox_tutorial", "normal", false, true, t)
			end
		end
	end

	if DebugKeyHandler.key_pressed("l", "show lobbies", "network", "left shift") then
		if not script_data.debug_lobbies then
			script_data.debug_lobbies = true
		else
			script_data.debug_lobbies = not script_data.debug_lobbies
		end
	end

	return 
end
MatchmakingManager.update_cancel_input = function (self, dt)
	local is_matchmaking = self.is_game_matchmaking(self) and self.matchmaking_ui.is_in_inn
	local enter_game = self.matchmaking_ui:is_enter_game()

	if is_matchmaking then
		if self.controller_cooldown and 0 < self.controller_cooldown then
			self.controller_cooldown = self.controller_cooldown - dt
		else
			local input_service = Managers.input:get_service("ingame_menu")

			if self.is_server and not enter_game and input_service and input_service.get(input_service, "cancel_matchmaking", true) then
				if Managers.input:is_device_active("gamepad") then
					local total_time = 1
					local cancel_timer = self.cancel_timer
					cancel_timer = (cancel_timer and cancel_timer + dt) or dt
					local progress = math.min(cancel_timer/total_time, 1)

					if progress == 1 then
						self.cancel_matchmaking(self)

						self.cancel_timer = nil

						self.matchmaking_ui:set_cancel_progress(0)

						self.controller_cooldown = GamepadSettings.menu_cooldown
					else
						self.cancel_timer = cancel_timer

						self.matchmaking_ui:set_cancel_progress(progress)
					end
				else
					self.cancel_matchmaking(self)
				end
			elseif self.cancel_timer then
				self.cancel_timer = nil

				self.matchmaking_ui:set_cancel_progress(0)

				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		end
	end

	return 
end
MatchmakingManager.state = function (self)
	return self._state
end
MatchmakingManager.set_popup_join_lobby_handler = function (self, popup_join_lobby_handler)
	self.params.popup_join_lobby_handler = popup_join_lobby_handler

	return 
end
MatchmakingManager.set_popup_handler = function (self, popup_handler)
	self.params.popup_handler = popup_handler

	return 
end
MatchmakingManager.is_join_popup_visible = function (self)
	return self.params.popup_join_lobby_handler and self.params.popup_join_lobby_handler.visible
end
MatchmakingManager.get_random_level = function (self, level_area, game_mode, difficulty_rank, statistics_db, player_stats_id, optional_level_filter)
	if game_mode == "adventure" then
		return self.get_random_adventure_level(self, level_area, difficulty_rank, statistics_db, player_stats_id, optional_level_filter)
	elseif game_mode == "survival" then
		return self.get_random_survival_level(self, level_area, difficulty_rank, statistics_db, player_stats_id, optional_level_filter)
	end

	return 
end
MatchmakingManager.get_random_adventure_level = function (self, level_area, difficulty_rank, statistics_db, player_stats_id, optional_level_list)
	local random_level_list = {}
	local levels = optional_level_list or UnlockableLevels

	for i = 1, #levels, 1 do
		local random_level_key = levels[i]
		local random_level_settings = LevelSettings[random_level_key]
		local game_mode = random_level_settings.game_mode

		if game_mode == "adventure" then
			local random_map_settings = random_level_settings.map_settings
			local approved_location = (level_area and level_area == random_map_settings.area) or level_area == nil

			if approved_location and self.level_unlocked_at_difficulty(self, random_level_key, difficulty_rank, statistics_db, player_stats_id) then
				random_level_list[#random_level_list + 1] = random_level_key
			end
		end
	end

	local level_key = random_level_list[math.random(1, #random_level_list)]

	return level_key
end
MatchmakingManager.get_random_survival_level = function (self, level_area, difficulty_rank, statistics_db, player_stats_id, optional_level_list)
	local random_level_list = {}
	local playable_levels = optional_level_list or SurvivalLevels

	for i = 1, #playable_levels, 1 do
		local random_level_key = playable_levels[i]
		local random_level_settings = LevelSettings[random_level_key]
		local random_map_settings = random_level_settings.map_settings
		local approved_location = (level_area and level_area == random_map_settings.area) or level_area == nil

		if approved_location and self.level_unlocked_at_difficulty(self, random_level_key, difficulty_rank, statistics_db, player_stats_id) then
			random_level_list[#random_level_list + 1] = random_level_key
		end
	end

	local level_key = random_level_list[math.random(1, #random_level_list)]

	return level_key
end
MatchmakingManager.level_unlocked_at_difficulty = function (self, level_key, difficulty_rank, statistics_db, player_stats_id)
	local unlocked = LevelUnlockUtils.level_unlocked(statistics_db, player_stats_id, level_key)

	if not unlocked then
		return false
	end

	local level_unlocked_difficulty_index = LevelUnlockUtils.unlocked_level_difficulty_index(statistics_db, player_stats_id, level_key)
	local difficulties, starting_difficulty = Managers.state.difficulty:get_level_difficulties(level_key)
	local starting_difficulty_index = table.find(difficulties, starting_difficulty)
	level_unlocked_difficulty_index = math.max(level_unlocked_difficulty_index, starting_difficulty_index)
	local selected_difficulty_index = nil

	for _, difficulty_name in ipairs(difficulties) do
		local settings = DifficultySettings[difficulty_name]

		if settings.rank == difficulty_rank then
			selected_difficulty_index = table.find(difficulties, difficulty_name)

			break
		end
	end

	if selected_difficulty_index <= level_unlocked_difficulty_index then
		return true
	end

	return false
end
MatchmakingManager.find_game = function (self, level_key, difficulty, private_game, quick_game, game_mode, area, t, level_filter)
	if self.is_server then
		table.clear(self.ready_peers)
		mm_printf("Starting to search for a game with settings: level_key=%s, difficulty=%s, private_game=%s, quick_game=%s, level_filter=%s", level_key, difficulty, tostring(private_game), tostring(quick_game), (level_filter and "yes") or "no")
		self.profile_synchronizer:update_lobby_profile_data()

		local player_manager = Managers.player
		local number_of_players = player_manager.num_human_players(player_manager)
		local player = player_manager.local_player(player_manager)
		local player_stats_id = player.stats_id(player)
		local statistics_db = self.statistics_db
		local difficulty_settings = DifficultySettings
		local difficulty_rank = difficulty_settings[difficulty].rank

		assert(difficulty_rank, "Could not get the difficulty rank from difficulty: ", difficulty)

		if quick_game or level_filter then
			if level_filter then
				area = nil

				table.shuffle(level_filter)
			end

			level_key = self.get_random_level(self, area, game_mode, difficulty_rank, statistics_db, player_stats_id, level_filter)
			local levels_settings = LevelSettings[level_key]
			local map_settings = levels_settings.map_settings
			game_mode = levels_settings.game_mode
			area = map_settings.area
		end

		self.state_context.game_search_data = {
			player_peer_id = self.peer_id,
			difficulty = difficulty,
			level_key = level_key,
			level_filter = level_filter,
			game_mode = game_mode,
			area = area,
			quick_game = quick_game,
			private_game = private_game,
			number_of_players = number_of_players,
			player_progression = (script_data.unlock_all_levels and #GameActsOrder - 1) or LevelUnlockUtils.current_act_progression_index(statistics_db, player_stats_id),
			required_progression = LevelUnlockUtils.progression_required_for_level(level_key)
		}
		local num_connections = table.size(self.network_transmit.connection_handler.current_connections)
		local start_directly = 0 < num_connections or MatchmakingSettings.host_games == "always"
		local next_state = nil

		if start_directly or private_game or 1 < number_of_players or ALWAYS_HOST_GAME then
			next_state = MatchmakingStateHostGame
		else
			next_state = MatchmakingStateSearchGame
		end

		self.handshaker_host:send_rpc_to_clients("rpc_set_matchmaking", true, private_game)
		self._change_state(self, next_state, self.params, self.state_context)

		self.start_matchmaking_time = 1000000
		self.started_matchmaking_t = t
	end

	return 
end
MatchmakingManager.cancel_matchmaking = function (self)
	mm_printf("Cancelling matchmaking")

	if self.started_matchmaking_t == nil then
		self.handshaker_client:reset()
		mm_printf("Wasn't really matchmaking to begin with...")

		return 
	end

	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local player = player_manager.local_player(player_manager, 1)
		local started_matchmaking_t = self.started_matchmaking_t
		local time_manager = Managers.time
		local t = time_manager.time(time_manager, "game") or started_matchmaking_t
		local time_taken = t - started_matchmaking_t
		local connection_state = "cancelled"
		local telemetry_manager = Managers.telemetry

		telemetry_manager.add_matchmaking_connection_telemetry(telemetry_manager, player, connection_state, time_taken)
	end

	if self._state then
		if self._state.lobby_client then
			self._state.lobby_client:destroy()

			self._state.lobby_client = nil
		end

		self._change_state(self, MatchmakingStateIdle, self.params, {})
	end

	table.clear(self.ready_peers)

	for i = 1, MatchmakingSettings.MAX_NUMBER_OF_PLAYERS, 1 do
		self.matchmaking_ui:large_window_set_player_ready_state(i, false)
	end

	if self.is_server then
		local stored_lobby_data = self.lobby:get_stored_lobby_data()
		stored_lobby_data.matchmaking = "false"

		self.lobby:set_lobby_data(stored_lobby_data)
		self.handshaker_host:send_rpc_to_clients("rpc_set_matchmaking", false, false)
		LobbyInternal.clear_filter_requirements()
		self.add_default_filter_requirements(self)
	end

	self.started_matchmaking_t = nil

	self.handshaker_client:reset()
	self.level_transition_handler:set_next_level(nil)

	return 
end
MatchmakingManager.is_game_matchmaking = function (self)
	local name = self._state.NAME
	local is_matchmaking = name ~= "MatchmakingStateIdle"
	local game_search_data = self.state_context.game_search_data
	local private_game = (game_search_data and game_search_data.private_game) or false

	return is_matchmaking, private_game
end
MatchmakingManager.rpc_set_matchmaking = function (self, sender, client_cookie, host_cookie, is_matchmaking, private_game)
	if not self.handshaker_client:validate_cookies(client_cookie, host_cookie) then
		return 
	end

	mm_printf("Set matchmaking=%s, private_game=%s", tostring(is_matchmaking), tostring(private_game))

	if is_matchmaking then
		if self.is_server then
			local game_search_data = self.state_context.game_search_data

			if MatchmakingSettings.restart_search_after_host_cancel and game_search_data then
				local t = Managers.time:time("main")

				self.find_game(self, game_search_data.level_key, game_search_data.difficulty, false, game_search_data.quick_game, game_search_data.game_mode, game_search_data.area, t)
			else
				self._change_state(self, MatchmakingStateIdle, self.params, self.state_context)
			end
		else
			local state_context = {
				private_game = private_game
			}

			self._change_state(self, MatchmakingStateFriendClient, self.params, state_context)
		end
	else
		local current_state = self._state

		if current_state.lobby_client then
			current_state.lobby_client:destroy()

			current_state.lobby_client = nil
		end

		table.clear(self.ready_peers)
		self._change_state(self, MatchmakingStateIdle, self.params, {})
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_profiles_data = function (self, sender, client_cookie, host_cookie)
	if not self.handshaker_host:validate_cookies(sender, client_cookie, host_cookie) then
		return 
	end

	local profiles_data = self.profiles_data(self)

	mm_printf("PROFILES REQUESTED BY %s REPLY wh:%s | we:%s | dr:%s | bw:%s | es:%s", sender, profiles_data[1], profiles_data[4], profiles_data[3], profiles_data[2], profiles_data[5])
	self.network_transmit:send_rpc("rpc_matchmaking_request_profiles_data_reply", sender, client_cookie, host_cookie, profiles_data)

	return 
end
MatchmakingManager.update_profiles_data_on_clients = function (self)
	local profiles_data = self.profiles_data(self)

	mm_printf("PROFILES UPDATED ON ALL CLIENTS wh:%s | we:%s | dr:%s | bw:%s | es:%s", profiles_data[1], profiles_data[4], profiles_data[3], profiles_data[2], profiles_data[5])
	self.handshaker_host:send_rpc_to_clients("rpc_matchmaking_update_profiles_data", profiles_data)

	return 
end
MatchmakingManager.profiles_data = function (self)
	local lobby = self.lobby
	local profiles_data = {}
	local num_profiles = #SPProfiles

	for i = 1, num_profiles, 1 do
		local index_name = player_slots[i]
		local lobby_profile_data = lobby.lobby_data(lobby, index_name) or "available"
		local profile_data = (lobby_profile_data == "available" and "0") or lobby_profile_data
		profiles_data[i] = profile_data
	end

	return profiles_data
end
MatchmakingManager.rpc_matchmaking_request_join_lobby = function (self, sender, client_cookie, host_cookie, lobby_id)
	local id = self.lobby:id()
	id = tostring(id)
	lobby_id = tostring(lobby_id)
	local reply = "lobby_ok"
	local lobby_id_match = (LobbyInternal.lobby_id_match and LobbyInternal.lobby_id_match(id, lobby_id)) or id == lobby_id
	local is_game_mode_ended = (Managers.state.game_mode and Managers.state.game_mode:is_game_mode_ended()) or false
	local is_searching_for_players = self._state.NAME == "MatchmakingStateSearchPlayers" or self._state.NAME == "MatchmakingStateIngame"
	local handshaker_host = self.handshaker_host
	local valid_cookies = (handshaker_host and handshaker_host.validate_cookies(handshaker_host, sender, client_cookie, host_cookie)) or false

	if not lobby_id_match then
		reply = "lobby_id_mismatch"
	elseif is_game_mode_ended then
		reply = "game_mode_ended"
	elseif not is_searching_for_players then
		reply = "not_searching_for_players"
	elseif not valid_cookies then
		reply = "obsolete_request"
	end

	mm_printf_force("Got request to join matchmaking lobby %s from %s, replying %s", lobby_id, sender, reply)

	local reply_id = NetworkLookup.game_ping_reply[reply]

	self.network_transmit:send_rpc("rpc_matchmaking_request_join_lobby_reply", sender, client_cookie, host_cookie, reply_id)

	return 
end
MatchmakingManager.rpc_matchmaking_request_profile = function (self, sender, client_cookie, host_cookie, profile)
	if not self.handshaker_host:validate_cookies(sender, client_cookie, host_cookie) then
		return 
	end

	if self._state and self._state.NAME == "MatchmakingStateSearchPlayers" then
		self._state:rpc_matchmaking_request_profile(sender, client_cookie, host_cookie, profile)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_profile, got this in wrong state current_state:%s", state_name)
	end

	local lobby = self.lobby
	local player_slot = player_slots[profile]
	local player_slot_available = lobby.lobby_data(lobby, player_slot) == "available"
	local reply = player_slot_available

	if player_slot_available then
		mm_printf("Assigning profile slot %s to %s", player_slot, sender)

		local lobby_data = lobby.get_stored_lobby_data(lobby)
		lobby_data[player_slot] = sender

		lobby.set_lobby_data(lobby, lobby_data)
		self.update_profiles_data_on_clients(self)
	end

	self.network_transmit:send_rpc("rpc_matchmaking_request_profile_reply", sender, client_cookie, host_cookie, profile, reply)

	return 
end
MatchmakingManager.get_transition = function (self)
	if self._state and self._state.get_transition then
		return self._state:get_transition()
	end

	if self.lobby_to_join then
		return "join_lobby", self.lobby_to_join
	end

	return 
end
MatchmakingManager.loading_context = function (self)
	if self._state and self._state.loading_context then
		return self._state:loading_context()
	end

	return 
end
MatchmakingManager.active_lobby = function (self)
	if self._state and self._state.active_lobby then
		return self._state:active_lobby()
	end

	return self.lobby
end
MatchmakingManager.hero_available_in_lobby_data = function (self, hero_index, lobby_data)
	local player_slot_name = player_slots[hero_index]
	local player_id = lobby_data[player_slot_name]
	local local_player = Managers.player:local_player()
	local local_player_id = local_player.profile_id(local_player)

	if not player_id then
		return true
	end

	if player_id == "available" then
		return true
	end

	if player_id == local_player_id then
		return true
	end

	return false
end
MatchmakingManager.lobby_match = function (self, lobby_data, level_key, difficulty, game_mode, wanted_profile_id, player_peer_id)
	local lobby_id = lobby_data.id
	local broken_lobby = self.lobby_listed_as_broken(self, lobby_id)

	if broken_lobby then
		return false
	end

	if lobby_data.Host == player_peer_id then
		return false
	end

	local valid_lobby = lobby_data.matchmaking ~= "false" and lobby_data.valid and lobby_data.host ~= player_peer_id

	if not valid_lobby then
		return false
	end

	if level_key then
		local correct_level = lobby_data.level_key == level_key or (lobby_data.selected_level_key and lobby_data.selected_level_key == level_key)

		if not correct_level then
			return false
		end
	end

	if game_mode ~= lobby_data.game_mode then
		return false
	end

	local correct_difficulty = lobby_data.difficulty == difficulty

	if not correct_difficulty then
		return false
	end

	local num_players = lobby_data.num_players and tonumber(lobby_data.num_players)
	local has_empty_slot = num_players and num_players < MatchmakingSettings.MAX_NUMBER_OF_PLAYERS

	if not has_empty_slot then
		return false
	end

	if wanted_profile_id then
		local hero_available = self.hero_available_in_lobby_data(self, wanted_profile_id, lobby_data)

		if not hero_available then
			return false
		end

		if lobby_data.host_afk == "true" then
			return false
		end
	else
		local any_allowed_hero_available = false

		for i = 1, 5, 1 do
			if MatchmakingSettings.hero_search_filter[i] == true then
				local hero_available = self.hero_available_in_lobby_data(self, wanted_profile_id, lobby_data)

				if hero_available then
					any_allowed_hero_available = true

					break
				end
			end
		end

		if not any_allowed_hero_available then
			return false
		end
	end

	if script_data.unique_server_name and lobby_data.unique_server_name ~= script_data.unique_server_name then
		Debug.text("Ignoring lobby due to mismatching unique_server_name")

		return false
	end

	return true
end
MatchmakingManager.add_broken_lobby = function (self, lobby_id, t, is_bad_connection_or_otherwise_not_nice)
	local time_to_ignore = (is_bad_connection_or_otherwise_not_nice and 120) or 20

	mm_printf("Adding broken lobby: %s Due to bad connection or something: %s, ignoring it for %d seconds", tostring(lobby_id), tostring(is_bad_connection_or_otherwise_not_nice), time_to_ignore)

	MatchmakingBrokenLobbies[lobby_id] = t + time_to_ignore

	return 
end
MatchmakingManager.lobby_listed_as_broken = function (self, lobby_id)
	return MatchmakingBrokenLobbies[lobby_id]
end
MatchmakingManager.rpc_matchmaking_request_join_lobby_reply = function (self, sender, client_cookie, host_cookie, reply_id)
	if self._state and self._state.NAME == "MatchmakingStateRequestJoinGame" then
		self._state:rpc_matchmaking_request_join_lobby_reply(sender, client_cookie, host_cookie, reply_id)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_join_lobby_reply, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_notify_connected = function (self, sender)
	if self._state and self._state.NAME == "MatchmakingStateRequestJoinGame" then
		self._state:rpc_notify_connected(sender)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_notify_connected, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_join_game = function (self, sender, client_cookie, host_cookie)
	if self._state and self._state.NAME == "MatchmakingStateJoinGame" then
		self._state:rpc_matchmaking_join_game(sender, client_cookie, host_cookie)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_join_game, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_update_profiles_data = function (self, sender, client_cookie, host_cookie, profiles_data)
	if self._state and (self._state.NAME == "MatchmakingStateJoinGame" or self._state.NAME == "MatchmakingStateRequestProfiles") then
		self._state:rpc_matchmaking_update_profiles_data(sender, client_cookie, host_cookie, profiles_data)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_update_profiles_data, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_profile_reply = function (self, sender, client_cookie, host_cookie, profile, reply)
	if self._state and self._state.NAME == "MatchmakingStateJoinGame" then
		self._state:rpc_matchmaking_request_profile_reply(sender, client_cookie, host_cookie, profile, reply)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_profile_reply, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_profiles_data_reply = function (self, sender, client_cookie, host_cookie, profiles_data)
	if self._state and self._state.NAME == "MatchmakingStateRequestProfiles" then
		self._state:rpc_matchmaking_request_profiles_data_reply(sender, client_cookie, host_cookie, profiles_data)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_profiles_data_reply, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_set_ready = function (self, sender, client_cookie, host_cookie, peer_id, ready)
	local state_name = (self._state and self._state.NAME) or nil

	if state_name == "MatchmakingStateHostGame" or state_name == "MatchmakingStateSearchPlayers" or state_name == "MatchmakingStateFriendClient" then
		self._state:rpc_matchmaking_set_ready(sender, client_cookie, host_cookie, peer_id, ready)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_set_ready, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_ready_data = function (self, sender, client_cookie, host_cookie)
	local state_name = (self._state and self._state.NAME) or nil

	if state_name == "MatchmakingStateHostGame" or state_name == "MatchmakingStateSearchPlayers" then
		self._state:rpc_matchmaking_request_ready_data(sender, client_cookie, host_cookie)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_ready_data, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_selected_level = function (self, sender, client_cookie, host_cookie)
	if self._state and (self._state.NAME == "MatchmakingStateSearchPlayers" or self._state.NAME == "MatchmakingStateHostGame") then
		if not self.handshaker_host:validate_cookies(sender, client_cookie, host_cookie) then
			return 
		end

		local lobby_data = self.lobby:get_stored_lobby_data()
		local selected_level = lobby_data.selected_level_key
		local selected_level_id = NetworkLookup.level_keys[selected_level]

		self.handshaker_host:send_rpc_to_client("rpc_matchmaking_request_selected_level_reply", sender, selected_level_id)
	else
		state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_selected_level, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_selected_level_reply = function (self, sender, client_cookie, host_cookie, selected_level_id)
	if self._state and self._state.NAME == "MatchmakingStateFriendClient" then
		self._state:rpc_matchmaking_request_selected_level_reply(sender, client_cookie, host_cookie, selected_level_id)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_selected_level_reply, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_selected_difficulty = function (self, sender, client_cookie, host_cookie)
	if self._state and (self._state.NAME == "MatchmakingStateSearchPlayers" or self._state.NAME == "MatchmakingStateHostGame") then
		if not self.handshaker_host:validate_cookies(sender, client_cookie, host_cookie) then
			return 
		end

		local lobby_data = self.lobby:get_stored_lobby_data()
		local difficulty = lobby_data.difficulty
		local difficulty_id = NetworkLookup.difficulties[difficulty]

		self.handshaker_host:send_rpc_to_client("rpc_matchmaking_request_selected_difficulty_reply", sender, difficulty_id)
	else
		state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_selected_difficulty, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_selected_difficulty_reply = function (self, sender, client_cookie, host_cookie, difficulty_id)
	if self._state and self._state.NAME == "MatchmakingStateFriendClient" then
		self._state:rpc_matchmaking_request_selected_difficulty_reply(sender, client_cookie, host_cookie, difficulty_id)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_selected_difficulty_reply, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_request_status_message = function (self, sender, client_cookie, host_cookie)
	if self._state and (self._state.NAME == "MatchmakingStateSearchPlayers" or self._state.NAME == "MatchmakingStateHostGame") then
		if not self.handshaker_host:validate_cookies(sender, client_cookie, host_cookie) then
			return 
		end

		local status_message = self.current_status_message

		if not status_message then
			return 
		end

		self.handshaker_host:send_rpc_to_client("rpc_matchmaking_status_message", sender, status_message)
	else
		state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_request_status_message, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.rpc_matchmaking_status_message = function (self, sender, client_cookie, host_cookie, status_message)
	if self._state and self._state.NAME == "MatchmakingStateFriendClient" then
		self._state:rpc_matchmaking_status_message(sender, client_cookie, host_cookie, status_message)
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf_force("rpc_matchmaking_status_message, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.hot_join_sync = function (self, peer_id)
	self.peers_to_sync[peer_id] = true
	local player_slot_index = self.profile_synchronizer:profile_by_peer(peer_id, 1)

	if player_slot_index then
		local player_slot_name = player_slots[player_slot_index]
		local profile_owner = self.profile_synchronizer:owner(player_slot_index)
		local lobby = self.lobby
		local stored_lobby_data = lobby.get_stored_lobby_data(lobby)
		local peer_name = profile_owner.peer_id .. ":1"
		stored_lobby_data[player_slot_name] = peer_name

		lobby.set_lobby_data(lobby, stored_lobby_data)
		mm_printf("Assigned player %s to slot %s when hot join syncing", peer_name, player_slot_name)
	end

	RPC.rpc_set_client_game_privacy(peer_id, self.is_game_private(self))

	return 
end
MatchmakingManager.countdown_completed = function (self)
	if self._state and self._state.NAME == "MatchmakingStateJoinGame" then
		self._state:countdown_completed()
	else
		local state_name = (self._state and self._state.NAME) or "none"

		mm_printf("countdown_completed, got this in wrong state current_state:%s", state_name)
	end

	return 
end
MatchmakingManager.everyone_has_profile = function (self)
	local num_peers = self.handshaker_host.num_clients + 1
	local lobby = self.lobby
	local num_profiles_taken = 0

	for i = 1, #player_slots, 1 do
		local player_slot = player_slots[i]
		local player_slot_available = lobby.lobby_data(lobby, player_slot) == "available"

		if not player_slot_available then
			num_profiles_taken = num_profiles_taken + 1
		end
	end

	return num_peers == num_profiles_taken
end
MatchmakingManager.all_peers_ready = function (self, ignore_self)
	if not ignore_self and not self.ready_peers[Network.peer_id()] then
		return false
	end

	local current_connections = self.network_transmit.connection_handler.current_connections

	for peer_id, _ in pairs(current_connections) do
		if not self.ready_peers[peer_id] then
			return false
		end
	end

	return true
end
MatchmakingManager.set_status_message = function (self, status_message)
	if status_message == self.current_status_message then
		return 
	end

	self.current_status_message = status_message

	self.matchmaking_ui:large_window_set_status_message(status_message)

	if self.is_server then
		self.handshaker_host:send_rpc_to_clients("rpc_matchmaking_status_message", status_message)
	end

	if self.ingame_ui.current_view == "lobby_browser_view" then
		self.lobby_browser_view_ui:set_status_message(status_message)
	end

	return 
end
MatchmakingManager.set_option_max_distance_filter = function (self, max_distance_filter)
	if max_distance_filter == "auto" then
		max_distance_filter = (GameSettingsDevelopment.network_mode == "lan" and LobbyDistanceFilter.CLOSE) or LobbyDistanceFilter.MEDIUM
	end

	MatchmakingSettings.max_distance_filter = max_distance_filter

	return 
end
MatchmakingManager.set_option_host_game = function (self, selected_host_option)
	MatchmakingSettings.host_games = selected_host_option

	return 
end
MatchmakingManager.set_option_ready = function (self, selected_ready_option)
	MatchmakingSettings.auto_ready = selected_ready_option

	return 
end
MatchmakingManager.set_option_hero_filter = function (self, hero_search_filter)
	local hero_search_filter_option = MatchmakingSettings.hero_search_filter

	for hero_name, allow in pairs(hero_search_filter) do
		local profile_index = FindProfileIndex(hero_name)
		hero_search_filter_option[profile_index] = allow
	end

	return 
end
MatchmakingManager.add_filter_requirements = function (self, distance_filter)
	local game_search_data = self.state_context.game_search_data

	assert(game_search_data)

	local distance_filter = distance_filter or LobbyDistanceFilter.CLOSE
	game_search_data.distance_filter = distance_filter
	local requirements = {
		free_slots = game_search_data.number_of_players,
		distance_filter = distance_filter,
		filters = {
			network_hash = {
				value = self.lobby_finder.network_hash,
				comparison = LobbyComparison.EQUAL
			},
			required_progression = {
				value = game_search_data.player_progression,
				comparison = LobbyComparison.LESS_OR_EQUAL
			},
			matchmaking = {
				value = "false",
				comparison = LobbyComparison.NOT_EQUAL
			},
			difficulty = {
				value = game_search_data.difficulty,
				comparison = LobbyComparison.EQUAL
			},
			game_mode = {
				value = game_search_data.game_mode,
				comparison = LobbyComparison.EQUAL
			}
		}
	}

	if not game_search_data.quick_game and not game_search_data.level_filter then
		requirements.filters.selected_level_key = {
			value = game_search_data.level_key,
			comparison = LobbyComparison.EQUAL
		}
	end

	self.lobby_finder:add_filter_requirements(requirements)

	return 
end
MatchmakingManager.add_default_filter_requirements = function (self)
	local requirements = {
		free_slots = 1,
		distance_filter = LobbyDistanceFilter.MEDIUM,
		filters = {
			network_hash = {
				value = self.lobby_finder.network_hash,
				comparison = LobbyComparison.EQUAL
			},
			matchmaking = {
				value = "false",
				comparison = LobbyComparison.NOT_EQUAL
			}
		}
	}

	self.lobby_finder:add_filter_requirements(requirements)

	return 
end
MatchmakingManager.request_join_lobby = function (self, lobby)
	if self._state.NAME ~= "MatchmakingStateIdle" then
		mm_printf("trying to join lobby from lobby browswer in wrong state %s", self._state.NAME)

		return 
	end

	mm_printf("Joining lobby %s from lobby browswer.", tostring(lobby))

	local state_context = {
		join_by_lobby_browser = true,
		join_lobby_data = lobby
	}
	local t = Managers.time:time("main")
	self.started_matchmaking_t = t
	local matchmaking_ui = self.matchmaking_ui

	matchmaking_ui.set_search_zone_host_title(matchmaking_ui, "matchmaking_status_client")
	matchmaking_ui.large_window_set_title(matchmaking_ui, "status_matchmaking")
	matchmaking_ui.large_window_set_level(matchmaking_ui, lobby.selected_level_key)
	matchmaking_ui.large_window_set_difficulty(matchmaking_ui, lobby.difficulty)

	self.state_context = state_context

	self._change_state(self, MatchmakingStateRequestJoinGame, self.params, state_context)

	return 
end
MatchmakingManager.cancel_join_lobby = function (self, reason)
	self.state_context.join_by_lobby_browser = nil

	if self.lobby_browser_view_ui then
		self.lobby_browser_view_ui:cancel_join_lobby(reason)
	end

	return 
end
MatchmakingManager.send_system_chat_message = function (self, message)
	local channel_id = 1
	local localization_param = ""
	local pop_chat = true

	Managers.chat:send_system_chat_message(channel_id, message, localization_param, pop_chat)

	return 
end

function DEBUG_LOBBIES()
	local lobby = Managers.matchmaking.lobby
	local lobby_data = lobby.get_stored_lobby_data(lobby)

	table.dump(lobby_data, "lobby_data")

	local active_lobby = Managers.matchmaking._state and Managers.matchmaking._state.active_lobby and Managers.matchmaking._state:active_lobby()
	local active_lobby_data = active_lobby and active_lobby.get_stored_lobby_data(active_lobby)

	if active_lobby_data then
		table.dump(active_lobby_data, "active_lobby_data")
	else
		print("no active_lobby")
	end

	return 
end

MatchmakingManager.rpc_set_client_game_privacy = function (self, peer_id, is_private)
	local lobby = self.lobby

	if not self.is_server then
		local stored_lobby_data = lobby.get_stored_lobby_data(lobby)
		stored_lobby_data.is_private = (is_private and "true") or "false"
	end

	return 
end
MatchmakingManager.set_game_privacy = function (self, is_private)
	local lobby = self.lobby

	if self.is_server and lobby.is_joined(lobby) then
		local value = (is_private and "true") or "false"

		self._set_lobby_data(self, lobby, "is_private", value)
		Managers.state.network.network_transmit:send_rpc_clients("rpc_set_client_game_privacy", is_private)
	end

	return 
end
MatchmakingManager.set_in_progress_game_privacy = function (self, is_private)
	local lobby = self.lobby

	if self.is_server and lobby.is_joined(lobby) then
		self.set_game_privacy(self, is_private)

		local value = (is_private and "false") or "true"

		self._set_lobby_data(self, lobby, "matchmaking", value)

		if not is_private then
			self._change_state(self, MatchmakingStateIngame, self.params, {})
		else
			self._change_state(self, MatchmakingStateIdle, self.params, {})
		end
	end

	return 
end
MatchmakingManager._set_lobby_data = function (self, lobby, field, value)
	local stored_lobby_data = lobby.get_stored_lobby_data(lobby)
	stored_lobby_data[field] = value

	lobby.set_lobby_data(lobby, stored_lobby_data)

	return 
end
MatchmakingManager.is_game_private = function (self)
	local lobby = self.lobby
	local stored_lobby_data = lobby.get_stored_lobby_data(lobby)
	local is_private = (stored_lobby_data.is_private == "true" and true) or false

	return is_private
end

return 
