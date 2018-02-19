require("scripts/settings/controller_settings")
require("scripts/settings/profiles/sp_profiles")
require("scripts/settings/material_effect_mappings")
require("scripts/settings/player_data")
require("scripts/settings/unit_variation_settings")
require("scripts/helpers/level_helper")
require("scripts/utils/edit_ai_utility")
require("scripts/utils/keystroke_helper")
require("scripts/game_state/components/dice_keeper")
require("scripts/ui/views/loading_view")
require("scripts/entity_system/systems/mission/rewards")

StateInGameRunning = class(StateInGameRunning)
StateInGameRunning.NAME = "StateInGameRunning"
local dicegame_resource_path = "resource_packages/levels/dicegame"
local menu_assets_resource_path = (PLATFORM == "win32" and "resource_packages/menu_assets_postgame") or "resource_packages/menu_assets_postgame_console"
StateInGameRunning.on_enter = function (self, params)
	GarbageLeakDetector.register_object(self, "StateInGameRunning")

	self.world = self.parent.world
	local viewport_name = params.viewport_name
	self.viewport_name = viewport_name
	self.world_name = params.world_name
	self.is_server = params.is_server
	self._lobby_host = params.lobby_host
	self._lobby_client = params.lobby_client
	self._network_options = params.network_options
	self.statistics_db = params.statistics_db
	self.profile_synchronizer = params.profile_synchronizer
	self.level_transition_handler = params.level_transition_handler
	self.network_server = params.network_server
	self.network_client = params.network_client
	local input_manager = params.input_manager
	self.input_manager = input_manager
	self.is_in_inn = params.is_in_inn
	self.is_in_tutorial = params.is_in_tutorial
	self.end_conditions_met = false
	local loaded_player_controls = PlayerData.controls and PlayerData.controls.Player
	local platform = PLATFORM
	local player_control_keymap = table.clone(PlayerControllerKeymaps)
	local player_control_filters = table.clone(PlayerControllerFilters)

	if loaded_player_controls and loaded_player_controls.keymap then
		table.merge_recursive(player_control_keymap[platform], loaded_player_controls.keymap)
	end

	if loaded_player_controls and loaded_player_controls.filters then
		table.merge_recursive(player_control_filters[platform], loaded_player_controls.filters)
	end

	input_manager.create_input_service(input_manager, "Player", "PlayerControllerKeymaps", "PlayerControllerFilters")
	input_manager.map_device_to_service(input_manager, "Player", "keyboard")
	input_manager.map_device_to_service(input_manager, "Player", "mouse")
	input_manager.map_device_to_service(input_manager, "Player", "gamepad")

	self.player_index = params.player
	local input_source = self.input_manager:get_service("Player")
	local player_manager = Managers.player
	local peer_id = Network.peer_id()
	local local_player_id = params.local_player_id
	local player = Managers.player:player(peer_id, local_player_id)
	local stats_id = player.stats_id(player)
	player.input_source = input_source
	self.player = player

	if self.is_server then
		player.create_game_object(player)
		player.create_boon_handler(player, self.world)
	end

	if self.is_server and Managers.state.room and not Managers.state.room:has_room(peer_id) then
		Managers.state.room:create_room(peer_id, 1)
	end

	local entity_manager = Managers.state.entity
	local camera_system = entity_manager.system(entity_manager, "camera_system")
	local outline_system = entity_manager.system(entity_manager, "outline_system")
	local sound_sector_system = entity_manager.system(entity_manager, "sound_sector_system")

	camera_system.local_player_created(camera_system, player)
	outline_system.local_player_created(outline_system, player)
	sound_sector_system.local_player_created(sound_sector_system, player)

	self.network_event_delegate = params.network_event_delegate

	self.network_event_delegate:register(self, "rpc_client_next_level_vote_started", "rpc_register_online_leaderboards")

	local event_manager = Managers.state.event

	event_manager.register(event_manager, self, "game_started", "event_game_started")
	event_manager.register(event_manager, self, "gm_event_end_conditions_met", "gm_event_end_conditions_met")
	event_manager.register(event_manager, self, "level_start_local_player_spawned", "event_local_player_spawned")
	event_manager.register(event_manager, self, "checkpoint_vote_cancelled", "on_checkpoint_vote_cancelled")
	event_manager.register(event_manager, self, "conflict_director_setup_done", "event_conflict_director_setup_done")

	if PLATFORM == "xb1" then
		event_manager.register(event_manager, self, "trigger_xbox_round_end", "event_trigger_xbox_round_end")
	end

	if self.is_server then
		Managers.state.event:trigger("game_started")
		Managers.smoketest:report("enter_ingame")
	end

	local level_key = params.level_key
	self.parent.parent.loading_context.last_level_id = params.level_key
	self.free_flight_manager = params.free_flight_manager

	self.free_flight_manager:set_teleport_override(function (pos, rot)
		for unit, _ in pairs(self.player.owned_units) do
			if ScriptUnit.has_extension(unit, "input_system") then
				local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

				locomotion_extension.teleport_to(locomotion_extension, pos, rot)
			end
		end

		return 
	end)

	local ingame_ui_context = {
		input_manager = input_manager,
		world_manager = Managers.world,
		level_transition_handler = params.level_transition_handler,
		camera_manager = Managers.state.camera,
		profile_synchronizer = params.profile_synchronizer,
		spawn_manager = Managers.state.spawn,
		player_manager = Managers.player,
		room_manager = Managers.state.room,
		is_server = params.is_server,
		is_in_inn = params.is_in_inn,
		network_lobby = self._lobby_host or self._lobby_client,
		network_event_delegate = params.network_event_delegate,
		peer_id = peer_id,
		player = player,
		local_player_id = local_player_id,
		dialogue_system = entity_manager.system(entity_manager, "dialogue_system"),
		dice_keeper = params.dice_keeper,
		voting_manager = Managers.state.voting,
		time_manager = Managers.time,
		statistics_db = self.statistics_db,
		matchmaking_manager = Managers.matchmaking,
		network_server = params.network_server,
		chat_manager = Managers.chat,
		voip = params.voip
	}
	DamageUtils.is_in_inn = params.is_in_inn
	self.ingame_ui_context = ingame_ui_context

	self.create_ingame_ui(self, ingame_ui_context)

	local loading_context = self.parent.parent.loading_context
	loading_context.play_end_of_level_game = nil
	self.end_of_level_ui_context = {
		ingame_ui = self.ingame_ui,
		input_manager = input_manager,
		world_manager = Managers.world,
		is_server = params.is_server,
		network_lobby = self._lobby_host or self._lobby_client,
		network_event_delegate = params.network_event_delegate,
		peer_id = peer_id,
		stats_id = stats_id,
		level_dice_keeper = params.dice_keeper,
		statistics_db = self.statistics_db,
		last_level_key = level_key,
		rewards = Rewards:new(level_key),
		level_transition_handler = params.level_transition_handler
	}
	loading_context.scoreboard_session_data = nil
	params.dice_keeper = nil
	local gdc_build = Development.parameter("gdc")

	if gdc_build then
		LevelHelper:flow_event(self.world, "gdc_build")
	end

	self.mood_timers = {}

	self.setup_mood_blackboard(self)

	if loading_context.loading_view then
		self.loading_view = loading_context.loading_view
		loading_context.loading_view = nil
		self.show_loading_view = true
	end

	Managers.matchmaking:set_matchmaking_ui(self.ingame_ui.matchmaking_ui, self.ingame_ui)
	Managers.state.camera:apply_level_particle_effects(LevelSettings[level_key].level_particle_effects, viewport_name)
	Managers.state.camera:apply_level_screen_effects(LevelSettings[level_key].level_screen_effects, viewport_name)

	if PLATFORM == "ps4" then
		Managers.account:set_realtime_multiplay_state("pre_game", true)
	end

	if Managers.chat:chat_is_focused() then
		Managers.chat.chat_gui:block_input()
	end

	return 
end
StateInGameRunning.create_ingame_ui = function (self, ingame_ui_context)
	if self.ingame_ui then
		self.ingame_ui:destroy()
	end

	self.ingame_ui = IngameUI:new(ingame_ui_context)

	Managers.state.entity:system("tutorial_system"):set_ingame_ui(self.ingame_ui)

	Managers.state.entity:system("mission_system").tutorial_ui = self.ingame_ui.ingame_hud.tutorial_ui
	Managers.state.entity:system("mission_system").mission_objective_ui = self.ingame_ui.ingame_hud.mission_objective
	Managers.state.entity:system("interactor_system").extension_init_context.ingame_ui = self.ingame_ui

	Managers.state.entity:system("hud_system"):set_ingame_ui(self.ingame_ui)

	local matchmaking = Managers.matchmaking

	if not matchmaking.popup_handler then
		matchmaking.set_popup_join_lobby_handler(matchmaking, self.ingame_ui.popup_join_lobby_handler)
		matchmaking.set_popup_handler(matchmaking, self.ingame_ui.popup_handler)
	end

	return 
end
StateInGameRunning.setup_end_of_level_UI = function (self)
	if script_data.disable_end_screens then
		Managers.state.network.network_transmit:send_rpc_server("rpc_is_ready_for_transition")
	else
		local game_won = not self.game_lost

		print("StateInGameRunning:setup_end_of_level_UI() thinks we won:", game_won)

		if game_won then
			local viewport = ScriptWorld.viewport(self.world, self.viewport_name)

			ScriptWorld.deactivate_viewport(self.world, viewport)
		end

		local scoreboard_session_data = ScoreboardHelper.get_sorted_topic_statistics(self.statistics_db, self.profile_synchronizer)
		self.end_of_level_ui_context.scoreboard_session_data = scoreboard_session_data
		self.end_of_level_ui = EndOfLevelUI:new(self.end_of_level_ui_context, game_won)

		if PLATFORM == "ps4" then
			Managers.account:set_presence("dice_game")
			Managers.account:set_realtime_multiplay_state("end_screen", true)
		end

		if Managers.chat:chat_is_focused() then
			Managers.chat.chat_gui:block_input()
		end
	end

	self.end_of_level_ui_context = nil
	self.waiting_for_transition = true
	self.setup_end_of_level = nil

	return 
end
StateInGameRunning.handle_end_conditions = function (self)
	local game_mode_manager = Managers.state.game_mode

	if game_mode_manager and game_mode_manager.is_game_mode_ended(game_mode_manager) and game_mode_manager.is_game_mode_ended(game_mode_manager) then
	end

	return 
end
MOOD_BLACKBOARD = {}
StateInGameRunning.setup_mood_blackboard = function (self)
	for mood, _ in pairs(MoodSettings) do
		MOOD_BLACKBOARD[mood] = false
	end

	return 
end
StateInGameRunning.wanted_transition = function (self)
	if self.popup_id then
		return 
	end

	if self.network_client and not self.network_client:is_ingame() then
		return 
	end

	if self.network_server and not self.network_server:are_all_peers_ingame() then
		return 
	end

	local wanted_transition, data = self.ingame_ui:get_transition()

	if wanted_transition then
		mm_printf("Doing transition %s from UI", wanted_transition)
	elseif self._invite_lobby_data then
		mm_printf("Found an invite, joining that lobby.")

		wanted_transition = "join_lobby"
		data = self._invite_lobby_data
		self._invite_lobby_data = nil
	end

	if not wanted_transition then
		wanted_transition, data = Managers.matchmaking:get_transition()

		if wanted_transition then
			mm_printf("Matchmaking manager returned a wanted transition %s, doing it.", wanted_transition)
		end
	end

	if not wanted_transition and self.afk_kick then
		wanted_transition = "afk_kick"
	end

	wanted_transition = wanted_transition or Managers.state.game_mode:wanted_transition()

	if wanted_transition and PLATFORM == "xb1" and not self.is_in_inn and not self.is_in_tutorial then
		if Development.parameter("auto-host-level") ~= nil then
		elseif not self._xbox_event_end_triggered then
			Application.warning("MultiplyerRoundStart was triggered without end conditions met")
			self._xbone_end_of_round_events(self, self.statistics_db)
		end
	end

	return wanted_transition, data
end
StateInGameRunning.on_end_screen_ui_complete = function (self)
	self.end_screen_ui_complete = true

	Managers.state.conflict:destroy_all_units()

	local is_server = self.is_server
	local game_won = not self.game_lost

	if Development.parameter("gdc") then
		if is_server then
			Managers.state.game_mode:retry_level()
		end
	else
		self.ingame_ui:deactivate_end_screen_ui(game_won)

		self.setup_end_of_level = true

		if is_server then
			local vote_started = self.server_start_next_level_vote(self, game_won)

			assert(vote_started, "[StateInGameRunning] - Voting for next level could not be started.")

			self.next_level_vote_started = true

			Managers.state.network.network_transmit:send_rpc_clients("rpc_client_next_level_vote_started")
		end
	end

	return 
end
StateInGameRunning.rpc_client_next_level_vote_started = function (self)
	self.next_level_vote_started = true

	return 
end
StateInGameRunning.rpc_register_online_leaderboards = function (self, sender, score)
	StatisticsUtil.register_online_leaderboards_data(self.statistics_db, score)

	return 
end
StateInGameRunning.gm_event_end_conditions_met = function (self, reason, checkpoint_available)
	LevelHelper:flow_event(self.world, "gm_event_end_conditions_met")

	if not self._spawn_initialized then
		Managers.transition:hide_loading_icon()
		Managers.transition:fade_out(GameSettings.transition_fade_in_speed)
	end

	if self.is_server then
		Managers.state.voting:set_vote_kick_enabled(false)
	end

	self.end_conditions_met = true

	Managers.state.conflict:set_disabled(true)

	local game_mode_key = Managers.state.game_mode:game_mode_key()
	local game_won = reason and reason == "won"
	local game_lost = reason and reason == "lost"
	local ingame_ui = self.ingame_ui

	ingame_ui.suspend_active_view(ingame_ui)
	Managers.popup:cancel_all_popups()

	local function check_hard_mode_complete(player)
		local is_complete = Managers.state.achievement:has_unlocked("magnus_hard_mode_nightmare", "supply_and_demand_hard_mode_nightmare", "city_wall_hard_mode_nightmare", "engines_of_war_hard_mode_nightmare", "white_rat_hard_mode_nightmare", "well_watch_hard_mode_nightmare", "waterfront_hard_mode_nightmare", "garden_of_morr_hard_mode_nightmare", "enemy_below_hard_mode_nightmare", "black_powder_hard_mode_nightmare", "wheat_and_chaff_hard_mode_nightmare", "smugglers_run_hard_mode_nightmare", "wizards_tower_hard_mode_nightmare", "magnus_hard_mode_cataclysm", "supply_and_demand_hard_mode_cataclysm", "city_wall_hard_mode_cataclysm", "engines_of_war_hard_mode_cataclysm", "white_rat_hard_mode_cataclysm", "well_watch_hard_mode_cataclysm", "waterfront_hard_mode_cataclysm", "garden_of_morr_hard_mode_cataclysm", "enemy_below_hard_mode_cataclysm", "black_powder_hard_mode_cataclysm", "wheat_and_chaff_hard_mode_cataclysm", "smugglers_run_hard_mode_cataclysm", "wizards_tower_hard_mode_cataclysm")

		if is_complete then
			Managers.player:statistics_db():set_stat(player.stats_id(player), "hard_mode_complete", true)
		end

		return 
	end

	if game_mode_key == "survival" then
		if game_won then
			print("Game won")

			local mission_system = Managers.state.entity:system("mission_system")

			mission_system.evaluate_level_end_missions(mission_system)

			local leaderboard_system = Managers.state.entity:system("leaderboard_system")

			leaderboard_system.round_completed(leaderboard_system)
			StatisticsUtil.register_complete_survival_level(self.statistics_db)
			StatisticsUtil.register_unlocked_lorebook_pages(self.statistics_db)

			if (GameSettingsDevelopment.use_leaderboards or Development.parameter("use_leaderboards")) and self.is_server then
				StatisticsUtil.register_online_leaderboards_data(self.statistics_db)
			end

			local player = Managers.player:local_player()

			check_hard_mode_complete(player)
			Managers.player:set_stats_backend(player)
			Managers.package:load(dicegame_resource_path, "state_ingame_running", nil, true)
		end

		Managers.package:load(menu_assets_resource_path, "menu_assets_postgame", nil, true)
	elseif game_won then
		print("Game won")

		local mission_system = Managers.state.entity:system("mission_system")

		mission_system.start_mission(mission_system, "players_alive_mission")
		mission_system.evaluate_level_end_missions(mission_system)
		StatisticsUtil.register_complete_level(self.statistics_db)
		StatisticsUtil.register_unlocked_lorebook_pages(self.statistics_db)

		local player = Managers.player:local_player()

		check_hard_mode_complete(player)
		Managers.player:set_stats_backend(player)
		Managers.package:load(dicegame_resource_path, "state_ingame_running", nil, true)
		Managers.package:load(menu_assets_resource_path, "menu_assets_postgame", nil, true)

		if PLATFORM == "ps4" then
			local level_key = Managers.state.game_mode:level_key()
			local level_display_name = LevelSettings[level_key].display_name
			local difficulty_display_name = Managers.state.difficulty:get_difficulty_settings().display_name

			Managers.account:activity_feed_post_mission_completed(level_display_name, difficulty_display_name)
		end
	elseif game_lost then
		print("Game lost")

		if self.is_server and checkpoint_available then
			Managers.state.voting:request_vote("continue_level", nil, Network.peer_id())
		end

		self.checkpoint_available = checkpoint_available

		Managers.package:load(menu_assets_resource_path, "menu_assets_postgame", nil, true)
	end

	if game_won then
		local quest_manager = Managers.state.quest
		local completed_level_key = Managers.state.game_mode:level_key()

		quest_manager.evaluate_level_end(quest_manager, self.statistics_db, completed_level_key)
	end

	if game_mode_key ~= "inn" then
		ingame_ui.activate_end_screen_ui(ingame_ui, game_won, checkpoint_available)
	end

	self.game_lost = game_lost

	if self.is_in_inn or self.is_in_tutorial then
		return 
	end

	if PLATFORM == "xb1" then
		if not self._xbox_event_end_triggered then
			self._xbone_end_of_round_events(self, self.statistics_db)
		end

		Managers.state.achievement:write_hero_stats()
	end

	return 
end
StateInGameRunning.on_checkpoint_vote_cancelled = function (self)
	self.checkpoint_vote_cancelled = true

	return 
end
StateInGameRunning._debug_update_rooms = function (self, dt, t)
	self._debug_room_handler_settings = self._debug_room_handler_settings or {
		tapped_players = {}
	}
	local settings = self._debug_room_handler_settings
	local room_manager = Managers.state.room

	if room_manager and self.is_server then
		local button = "f"
		local category = "rooms"

		for i = 1, 4, 1 do
			local tapped_player = settings.tapped_players[i]

			if not tapped_player and DebugKeyHandler.key_pressed(button .. tostring(i), "create room", category) then
				room_manager.create_room(room_manager, i)

				settings.tapped_players[i] = {
					button = button .. tostring(i)
				}
			elseif tapped_player and DebugKeyHandler.key_pressed(tapped_player.button, "destroy room", category) then
				local move_out_other_players = true

				room_manager.destroy_room(room_manager, i, move_out_other_players)

				settings.tapped_players[i] = nil
			end
		end
	end

	self._debug_room_handler_settings = settings

	return 
end

if PLATFORM ~= "win32" and (BUILD == "dev" or BUILD == "debug") then
	function RELOAD_CONTROLS()
		Managers.input:create_input_service("Player", "PlayerControllerKeymaps", "PlayerControllerFilters")
		Managers.input:map_device_to_service("Player", "keyboard")
		Managers.input:map_device_to_service("Player", "mouse")
		Managers.input:map_device_to_service("Player", "gamepad")

		local input_source = Managers.input:get_service("Player")
		local player = Managers.player:local_player()
		player.input_source = input_source
		local unit = player.player_unit
		local input_extension = ScriptUnit.extension(unit, "input_system")
		input_extension.input_service = input_source

		return 
	end
end

StateInGameRunning.update = function (self, dt, t)
	Profiler.start("StateInGameRunning:update()")

	if script_data.debug_rooms then
		self._debug_update_rooms(self, dt, t)
	end

	local previous_boon_update_player_id = self._previous_boon_update_player_id
	local players = Managers.player:human_players()
	local player_id = nil

	if players[previous_boon_update_player_id] then
		player_id = next(players, previous_boon_update_player_id)
	end

	player_id = player_id or next(players)

	if player_id then
		local player = players[player_id]
		local player_boon_handler = player.boon_handler

		if player_boon_handler then
			player_boon_handler.update(player_boon_handler, dt, t)
		end
	end

	self._previous_boon_update_player_id = player_id

	self.update_mood(self, dt, t)
	Managers.state.debug_text:update(dt, self.viewport_name)

	if self.checkpoint_vote_cancelled then
		self.checkpoint_available = nil
		self.checkpoint_vote_cancelled = nil
	end

	local ingame_ui = self.ingame_ui
	local package_manager = Managers.package

	if self.next_level_vote_started and not ingame_ui.survey_active and self.setup_end_of_level and (package_manager.has_loaded(package_manager, dicegame_resource_path) or self.game_lost) and package_manager.has_loaded(package_manager, menu_assets_resource_path) then
		self.setup_end_of_level_UI(self)
	end

	if self.popup_id then
		local result = Managers.popup:query_result(self.popup_id)

		if result then
			if result == "not_installed" then
				Managers.invite:clear_invites()
			end

			self.popup_id = nil
		end
	end

	self._update_invites(self, dt, t)
	self.check_for_new_quests_or_contracts(self, dt)

	if DebugKeyHandler.key_pressed("f5", "reload_ui", "ui") then
		self.create_ingame_ui(self, self.ingame_ui_context)
	end

	Profiler.start("AFK Kick")

	local main_t = Managers.time:time("main")

	self.update_player_afk_check(self, dt, main_t)
	Profiler.stop("AFK Kick")
	Profiler.stop("StateInGameRunning:update()")

	return 
end
StateInGameRunning._update_invites = function (self, dt, t)
	local invite_data = Managers.invite:get_invited_lobby_data()

	if invite_data then
		local platform = PLATFORM
		local lobby_id = invite_data.id or invite_data.name
		local current_lobby_id = nil

		if platform == "xb1" then
			current_lobby_id = (self._lobby_host and self._lobby_host.lobby._data.session_name) or self._lobby_client.lobby._data.session_name
		else
			current_lobby_id = (self._lobby_host and self._lobby_host:id()) or self._lobby_client:id()
		end

		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)

			self.popup_id = nil
		end

		local current_level = self.level_transition_handler.level_key

		if Managers.matchmaking:is_game_matchmaking() and self.network_server and current_level == "inn_level" then
			mm_printf("Found an invite, but was matchmaking.")

			self.popup_id = Managers.popup:queue_popup(Localize("popup_join_while_matchmaking"), Localize("popup_error_topic"), "ok", Localize("button_ok"))
		elseif lobby_id == current_lobby_id then
			mm_printf("Found an invite, but was already in lobby.")

			self.popup_id = Managers.popup:queue_popup(Localize("popup_already_in_same_lobby"), Localize("popup_error_topic"), "ok", Localize("button_ok"))
		elseif not Managers.play_go:installed() then
			mm_printf("Found an invite, but game was not fully installed.")

			self.popup_id = Managers.popup:queue_popup(Localize("popup_invite_not_installed"), Localize("popup_invite_not_installed_header"), "not_installed", Localize("menu_ok"))
		elseif self.network_server and not self.network_server:are_all_peers_ingame() then
			mm_printf("Found an invite, but someone is trying to join the game.")

			self.popup_id = Managers.popup:queue_popup(Localize("popup_join_blocked_by_joining_player"), Localize("popup_invite_not_installed_header"), "not_installed", Localize("menu_ok"))
		end

		if not self.popup_id then
			if self._lobby_client or not self.is_in_inn or platform == "xb1" then
				self._invite_lobby_data = invite_data
			else
				Managers.matchmaking:request_join_lobby(invite_data, {
					friend_join = true
				})
			end
		end
	end

	return 
end
StateInGameRunning.check_for_new_quests_or_contracts = function (self, dt)
	self._quest_expire_check_cooldown = (self._quest_expire_check_cooldown and self._quest_expire_check_cooldown - dt) or 0

	if self._quest_expire_check_cooldown <= 0 then
		local quest_manager = Managers.state.quest

		if quest_manager.has_quests_expired(quest_manager) or quest_manager.has_contracts_expired(quest_manager) then
			Managers.chat:add_local_system_message(1, Localize("dlc1_3_1_new_quests_and_contracts_available_text"), true)

			self._quest_expire_check_cooldown = QuestSettings.EXPIRE_CHECK_COOLDOWN
		end
	end

	return 
end
StateInGameRunning.disable_ui = function (self)
	self._disable_ui = true

	return 
end
StateInGameRunning.update_ui = function (self)
	if self._disable_ui then
		return 
	end

	if not self._ui_update_initialized then
		self._ui_update_initialized = true

		return 
	end

	local time_manager = Managers.time
	local dt = time_manager.mean_dt(time_manager)
	local t = time_manager.time(time_manager, "game")
	local disable_ingame_ui = script_data.disable_ui or (self.waiting_for_transition and Managers.state.network:game_session_host())
	local ingame_ui = self.ingame_ui
	local end_of_level_ui = self.end_of_level_ui

	ingame_ui.update(ingame_ui, dt, t, disable_ingame_ui, end_of_level_ui)

	if ingame_ui.end_screen_active(ingame_ui) and ingame_ui.end_screen_completed(ingame_ui) and not self.checkpoint_available and not self.end_screen_ui_complete then
		if Managers.state.network.is_server then
			ScriptBackendSession.end_of_round()
		end

		self.on_end_screen_ui_complete(self)
	end

	return 
end
StateInGameRunning.cb_loading_view_fade_in_done = function (self)
	Managers.transition:fade_out(GameSettings.transition_fade_out_speed, nil)

	self.show_loading_view = false

	return 
end
StateInGameRunning.update_mood = function (self, dt, t)
	local mood_settings = MoodSettings
	local mood_priority = MoodPriority
	local mood_handler = Managers.state.camera.mood_handler
	local mood_timers = self.mood_timers
	local mood_blackboard = MOOD_BLACKBOARD
	local wanted_mood = nil

	for i = 1, #mood_priority, 1 do
		local mood = mood_priority[i]

		if mood_timers[mood] and mood_timers[mood] < t then
			mood_timers[mood] = nil
			mood_blackboard[mood] = false
		end

		if mood_blackboard[mood] == true then
			if not wanted_mood then
				wanted_mood = mood
			elseif mood_settings[mood].hold_time then
				mood_blackboard[mood] = false
			end
		end
	end

	wanted_mood = wanted_mood or "default"

	if wanted_mood ~= mood_handler.current_mood then
		mood_handler.set_mood(mood_handler, wanted_mood)

		if wanted_mood ~= "default" then
			local hold_time = mood_settings[wanted_mood].hold_time

			if hold_time then
				mood_timers[wanted_mood] = t + hold_time
			end
		end
	end

	return 
end
StateInGameRunning.post_update = function (self, dt, t)
	local end_of_level_ui = self.end_of_level_ui
	local disable_ingame_ui = script_data.disable_ui or end_of_level_ui ~= nil or (self.waiting_for_transition and Managers.state.network:game_session_host())

	self.ingame_ui:post_update(dt, t, disable_ingame_ui)

	if end_of_level_ui then
		end_of_level_ui.update(end_of_level_ui, dt)

		if end_of_level_ui.continue_to_game then
			end_of_level_ui.destroy(end_of_level_ui)

			self.end_of_level_ui = nil
			local game_won = not self.game_lost

			if game_won then
				local viewport = ScriptWorld.viewport(world, self.viewport_name)

				ScriptWorld.activate_viewport(world, viewport)
			end

			if PLATFORM == "ps4" then
				Managers.account:set_realtime_multiplay_state("end_screen", false)
			end

			Managers.state.network.network_transmit:send_rpc_server("rpc_is_ready_for_transition")
		end
	end

	return 
end
StateInGameRunning.trigger_xbox_multiplayer_round_end_events = function (self)
	if self.is_in_inn or self.is_in_tutorial or Development.parameter("auto-host-level") ~= nil or self._xbox_event_end_triggered then
		return 
	end

	self._xbone_end_of_round_events(self, self.statistics_db)

	return 
end
StateInGameRunning.on_exit = function (self)
	self.free_flight_manager:set_teleport_override(nil)

	self.parent = nil
	self.free_flight_manager = nil
	self.input_manager = nil

	if self.end_of_level_ui then
		self.end_of_level_ui:destroy()

		self.end_of_level_ui = nil

		if PLATFORM == "ps4" then
			Managers.account:set_realtime_multiplay_state("end_screen", false)
		end
	end

	self.ingame_ui:destroy()

	self.ingame_ui = nil

	if self.loading_view then
		self.loading_view:destroy()

		self.loading_view = nil
	end

	if self.network_event_delegate then
		self.network_event_delegate:unregister(self)

		self.network_event_delegate = nil
	end

	self.end_of_level_ui_context = nil

	if Managers.package:has_loaded(dicegame_resource_path) then
		Managers.package:unload(dicegame_resource_path, "state_ingame_running")
	end

	if Managers.package:has_loaded(menu_assets_resource_path) then
		Managers.package:unload(menu_assets_resource_path, "menu_assets_postgame")
	end

	self.player = nil

	self._cancel_afk_warning(self)

	return 
end
StateInGameRunning.event_game_started = function (self)
	local world = self.parent.world
	local level = LevelHelper:current_level(world)

	Level.trigger_event(level, "game_started")

	if self.is_server then
		Managers.state.voting:set_vote_kick_enabled(true)
	end

	self.end_conditions_met = false

	if self.is_in_inn or self.is_in_tutorial then
		return 
	end

	if PLATFORM == "xb1" then
		self._xbone_round_start_events(self)
	end

	return 
end

if PLATFORM == "xb1" then
	StateInGameRunning.event_trigger_xbox_round_end = function (self)
		self._xbone_end_of_round_events(self, self.statistics_db)

		return 
	end
	StateInGameRunning._xbone_round_start_events = function (self)
		if self.is_in_inn or self.is_in_tutorial or Development.parameter("auto-host-level") ~= nil then
			return 
		end

		if not self._xbox_event_init_triggered then
			self._xbox_event_init_triggered = true
			local session_id = Managers.state.network:lobby().lobby:session_id()
			local multiplayer_round_start_table = {
				Managers.account:xbox_user_id(),
				Managers.account:round_id() or Application.guid(),
				0,
				Managers.account:player_session_id(),
				MultiplayerSession.multiplayer_correlation_id(session_id),
				0,
				0,
				0
			}

			Managers.transition:set_multiplayer_values("start", {
				xuid = Managers.account:xbox_user_id(),
				round_id = Managers.account:round_id(),
				player_session_id = Managers.account:player_session_id(),
				correlation_id = MultiplayerSession.multiplayer_correlation_id(session_id)
			}, string.format("[StateInGameRunning] Writing MultiplayerRoundStart. CorrelationID: %s. RoundID: %s", tostring(MultiplayerSession.multiplayer_correlation_id(session_id)), tostring(Managers.account:round_id())))

			local debug_string = string.format("[StateInGameRunning] Writing MultiplayerRoundStart. CorrelationID: %s. RoundID: %s", tostring(MultiplayerSession.multiplayer_correlation_id(session_id)), tostring(Managers.account:round_id()))
			local debug_print_func = Application.warning

			Managers.xbox_events:write("MultiplayerRoundStart", multiplayer_round_start_table, debug_string, debug_print_func, true)
		end

		return 
	end
	StateInGameRunning._xbone_end_of_round_events = function (self, statistics_db)
		if self.is_in_inn or self.is_in_tutorial or Development.parameter("auto-host-level") ~= nil or not self._xbox_event_init_triggered then
			return 
		end

		if not self._xbox_event_end_triggered then
			self._xbox_event_end_triggered = true
			local session_id = Managers.state.network:lobby().lobby:session_id()
			local multiplayer_round_end_table = {
				Managers.account:xbox_user_id(),
				Managers.account:round_id() or Application.guid(),
				0,
				Managers.account:player_session_id(),
				MultiplayerSession.multiplayer_correlation_id(session_id),
				0,
				0,
				0,
				math.floor(Managers.time:time("game")),
				0
			}

			Managers.transition:set_multiplayer_values("end", {
				xuid = Managers.account:xbox_user_id(),
				round_id = Managers.account:round_id(),
				player_session_id = Managers.account:player_session_id(),
				correlation_id = MultiplayerSession.multiplayer_correlation_id(session_id),
				time = Managers.time:time("game")
			}, string.format("[StateInGameRunning] Writing MultiplayerRoundEnd. CorrelationID: %s. RoundID: %s", tostring(MultiplayerSession.multiplayer_correlation_id(session_id)), tostring(Managers.account:round_id())))

			local debug_string = string.format("[StateInGameRunning] Writing MultiplayerRoundEnd. CorrelationID: %s. RoundID: %s", tostring(MultiplayerSession.multiplayer_correlation_id(session_id)), tostring(Managers.account:round_id()))
			local debug_print_func = Application.warning

			Managers.xbox_events:write("MultiplayerRoundEnd", multiplayer_round_end_table, debug_string, debug_print_func, true)
			Managers.transition:dump_multiplayer_data()
		end

		if not self._gameprogress_event_triggered then
			self._gameprogress_event_triggered = true
			local game_progress_table = {
				Managers.account:xbox_user_id(),
				Managers.account:player_session_id(),
				StatisticsUtil.get_game_progress(statistics_db)
			}
			local debug_string = "[StateInGameRunning] Writing GameProgress"
			local debug_print_func = Application.warning

			Managers.xbox_events:write("GameProgress", game_progress_table, debug_string, debug_print_func, true)
		end

		return 
	end
end

StateInGameRunning.event_conflict_director_setup_done = function (self)
	self._conflict_directory_is_ready = true

	self.game_actually_starts(self)

	return 
end
StateInGameRunning.event_local_player_spawned = function (self, is_initial_spawn)
	self._player_has_spawned = true
	self._is_initial_spawn = is_initial_spawn

	self.game_actually_starts(self)

	return 
end
StateInGameRunning.game_actually_starts = function (self)
	if not self._spawn_initialized and self._player_has_spawned and (not self.is_server or self._conflict_directory_is_ready) then
		local platform = PLATFORM
		local loading_context = self.parent.parent.loading_context
		local first_hero_selection_made = SaveData.first_hero_selection_made
		local show_profile_on_startup = loading_context.show_profile_on_startup
		local backend_waiting_for_input = Managers.backend:is_waiting_for_user_input()
		local level_key = Managers.state.game_mode:level_key()
		local show_hero_selection = not backend_waiting_for_input and show_profile_on_startup and (platform == "ps4" or platform == "xb1" or not first_hero_selection_made) and level_key == "inn_level"

		if show_hero_selection and not LEVEL_EDITOR_TEST then
			self.ingame_ui:transition_with_fade("initial_profile_view_force")

			loading_context.show_profile_on_startup = nil
		else
			Managers.transition:fade_out(GameSettings.transition_fade_in_speed)
		end

		LevelHelper:flow_event(self.world, "local_player_spawned")

		if self._is_initial_spawn then
			LevelHelper:flow_event(self.world, "level_start_local_player_spawned")
		end

		self._spawn_initialized = true
		self._conflict_directory_is_ready = nil
		self._player_has_spawned = nil

		Managers.transition:hide_loading_icon()

		if PLATFORM == "ps4" then
			Managers.account:set_realtime_multiplay_state("pre_game", false)
		end

		if self.is_in_inn or self.is_in_tutorial then
			return 
		end

		if PLATFORM == "xb1" then
			Managers.state.achievement:initialize_hero_stats()
		end
	end

	return 
end
StateInGameRunning.server_start_next_level_vote = function (self, is_game_won)
	if not Development.parameter("gdc") then
		local statistics_db = self.statistics_db
		local player = Managers.player:local_player()
		local player_stats_id = player.stats_id(player)
		local level_transition_handler = self.level_transition_handler
		local current_level_key = level_transition_handler.get_current_level_keys(level_transition_handler)
		local current_level_settings = LevelSettings[current_level_key]
		local current_game_mode = current_level_settings.game_mode

		if current_game_mode == "survival" then
			local starting_wave = SurvivalSettings.initial_wave or 0
			local starting_difficulty = SurvivalDifficultyByStartWave[starting_wave]
			local level_vote_data = {
				current_level_key,
				current_level_key,
				starting_difficulty,
				starting_difficulty
			}

			return Managers.state.voting:request_vote("vote_for_level", level_vote_data, Network.peer_id())
		end

		next_level_key = (is_game_won and LevelUnlockUtils.get_next_level_in_order(statistics_db, player_stats_id, current_level_key)) or current_level_key
		local random_level_list = {}

		for i = 1, #LevelUnlockOrder, 1 do
			local level_group = LevelUnlockOrder[i]

			for k = 1, #level_group, 1 do
				local level_key = level_group[k]
				local allowed_random_level = nil

				if Development.parameter("beta_level_progression") then
					allowed_random_level = level_key ~= next_level_key
				else
					allowed_random_level = level_key ~= current_level_key and level_key ~= next_level_key
				end

				if allowed_random_level then
					random_level_list[#random_level_list + 1] = (LevelUnlockUtils.level_unlocked(statistics_db, player_stats_id, level_key) and level_key) or nil
				end
			end
		end

		local random_level_key = nil
		local current_level_is_valid_level = table.find(UnlockableLevels, current_level_key)
		local num_random_levels = #random_level_list

		if current_level_is_valid_level and 0 < num_random_levels then
			random_level_key = random_level_list[math.random(1, #random_level_list)]
		else
			random_level_key = next_level_key
		end

		random_level_key = random_level_key or next_level_key

		assert(random_level_key, "[StateInGameRunning] - Could not find a random level key for end screen voting.")

		local current_difficulty = Managers.state.difficulty:get_difficulty()
		local current_difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
		local next_level_difficulty = current_difficulty
		local random_level_difficulty = current_difficulty
		local difficulty_settings = DifficultySettings

		if current_level_is_valid_level then
			local current_difficulty_rank = current_difficulty_settings.rank
			local next_level_unlocked_difficulty_index = LevelUnlockUtils.unlocked_level_difficulty_index(statistics_db, player_stats_id, next_level_key)
			local next_level_difficulties = Managers.state.difficulty:get_level_difficulties(next_level_key)
			local difference = math.huge

			for i = 1, next_level_unlocked_difficulty_index, 1 do
				local difficulty_name = next_level_difficulties[i]
				local rank = difficulty_settings[difficulty_name].rank
				local new_difference = math.abs(current_difficulty_rank - rank)

				if new_difference < difference then
					next_level_difficulty = difficulty_name
					difference = new_difference
				end
			end

			local random_level_unlocked_difficulty_index = LevelUnlockUtils.unlocked_level_difficulty_index(statistics_db, player_stats_id, random_level_key)
			local random_level_difficulties = Managers.state.difficulty:get_level_difficulties(next_level_key)
			current_difficulty_rank = current_difficulty_settings.rank
			difference = math.huge

			for i = 1, random_level_unlocked_difficulty_index, 1 do
				local difficulty_name = random_level_difficulties[i]
				local rank = difficulty_settings[difficulty_name].rank
				local new_difference = math.abs(current_difficulty_rank - rank)

				if new_difference < difference then
					random_level_difficulty = difficulty_name
					difference = new_difference
				end
			end
		end

		local level_vote_data = {
			next_level_key,
			random_level_key,
			next_level_difficulty,
			random_level_difficulty
		}

		level_transition_handler.set_next_level(level_transition_handler, next_level_key)

		return Managers.state.voting:request_vote("vote_for_level", level_vote_data, Network.peer_id())
	end

	return 
end
local afk_warn_timer = 120
local afk_force_kick_timer = 180
StateInGameRunning.update_player_afk_check = function (self, dt, t)
	return 

	local cutscene_system = Managers.state.entity:system("cutscene_system")
	local active_cutscene = cutscene_system.active_camera
	local afk_kick_disabled = self.afk_kick or active_cutscene or self.is_server or self.is_in_inn or self.end_conditions_met or Development.parameter("debug_disable_afk_kick")

	if afk_kick_disabled then
		if self.afk_popup_id then
			self._cancel_afk_warning(self)
		end

		self.last_active_time = nil

		return 
	end

	local last_input_time = Managers.input.last_active_time

	if not self.last_active_time then
		self.last_active_time = last_input_time or t
	elseif last_input_time and last_input_time ~= self.last_active_time then
		self.last_active_time = nil
	elseif self.last_active_time then
		local player = Managers.player:local_player(1)
		local player_unit = player.player_unit

		if not Unit.alive(player_unit) or ScriptUnit.extension(player_unit, "status_system"):is_disabled() then
			self.last_active_time = self.last_active_time + dt
		else
			local time_since_active = t - self.last_active_time
			local should_warn = afk_warn_timer < time_since_active
			local should_kick = afk_force_kick_timer < time_since_active

			if should_warn and not self.afk_popup_id then
				self._show_afk_warning(self)
			elseif should_kick then
				self._kick_afk_player(self)
			end
		end
	end

	self._handle_afk_warning_result(self)

	return 
end
StateInGameRunning._show_afk_warning = function (self)
	self.afk_popup_id = Managers.popup:queue_popup(Localize("afk_kick_warning"), Localize("popup_notice_topic"), "ok", Localize("button_ok"))
	local can_flash_window = _G.Window ~= nil and Window.flash_window ~= nil and not Window.has_focus()

	if can_flash_window then
		Window.flash_window(nil, "start", 5)
	end

	local player = Managers.player:local_player(1)

	self._send_system_chat_message(self, "chat_afk_kick_warning", player.name(player))

	return 
end
StateInGameRunning._send_system_chat_message = function (self, message, localization_param)
	local channel_id = 1
	local pop_chat = true

	Managers.chat:send_system_chat_message(channel_id, message, localization_param, pop_chat)

	return 
end
StateInGameRunning._cancel_afk_warning = function (self)
	if self.afk_popup_id then
		Managers.popup:cancel_popup(self.afk_popup_id)

		self.afk_popup_id = nil
	end

	return 
end
StateInGameRunning._handle_afk_warning_result = function (self)
	if self.afk_popup_id then
		local popup_result = Managers.popup:query_result(self.afk_popup_id)

		if popup_result then
			self.afk_popup_id = nil
		end
	end

	return 
end
StateInGameRunning._kick_afk_player = function (self)
	self._cancel_afk_warning(self)

	local player = Managers.player:local_player(1)

	self._send_system_chat_message(self, "chat_afk_kick", player.name(player))

	self.afk_kick = true

	return 
end

return 
