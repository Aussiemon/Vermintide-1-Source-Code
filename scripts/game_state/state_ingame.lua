require("scripts/flow/flow_callbacks")
require("scripts/managers/backend/statistics_database")
require("scripts/managers/bot_nav_transition/bot_nav_transition_manager")
require("scripts/managers/camera/camera_manager")
require("scripts/managers/debug/debug_text_manager")
require("scripts/managers/debug/debug_event_manager_rpc")
require("scripts/managers/network/game_network_manager")
require("scripts/managers/networked_flow_state/networked_flow_state_manager")
require("scripts/managers/spawn/spawn_manager")
require("scripts/managers/game_mode/game_mode_manager")
require("scripts/managers/debug/debug_manager")
require("scripts/managers/conflict_director/conflict_director")
require("scripts/managers/entity/entity_manager2")
require("scripts/managers/room/room_manager_server")
require("scripts/managers/room/room_manager_client")
require("scripts/managers/difficulty/difficulty_manager")
require("scripts/managers/matchmaking/matchmaking_manager")
require("scripts/managers/achievements/achievement_manager")
require("scripts/helpers/locomotion_utils")
require("scripts/helpers/damage_utils")
require("scripts/helpers/action_utils")
require("scripts/helpers/status_utils")
require("scripts/helpers/graph_drawer")
require("scripts/utils/debug_screen")
require("scripts/utils/debug_key_handler")
require("scripts/utils/function_call_profiler")
require("scripts/utils/pool_table_visualizer")
require("scripts/utils/visual_assert_log")
require("scripts/helpers/graph_helper")
require("scripts/network/network_event_delegate")
require("scripts/managers/input/input_manager")
require("scripts/utils/debug_keymap")
require("scripts/utils/vault")
require("scripts/settings/render_settings_templates")
require("scripts/settings/game_settings")
require("scripts/network/network_clock_server")
require("scripts/network/network_clock_client")
require("scripts/network/network_timer_handler")
require("scripts/game_state/state_ingame_running")
require("scripts/game_state/state_loading")
require("scripts/entity_system/entity_system_bag")
require("scripts/level/environment/environment_blender")
require("scripts/managers/voting/vote_manager")
require("scripts/managers/voting/vote_templates")
require("scripts/game_state/components/dice_keeper")
require("foundation/scripts/util/datacounter")
require("scripts/managers/blood/blood_manager")
require("scripts/managers/quest/quest_manager")
require("scripts/managers/performance/performance_manager")
require("scripts/managers/leaderboards/leaderboard_manager")

StateIngame = class(StateIngame)
StateIngame.NAME = "StateIngame"

StateIngame.on_enter = function (self)
	if PLATFORM == "xb1" then
		Application.set_kinect_enabled(false)
	end

	local loading_context = self.parent.loading_context
	self._lobby_host = loading_context.lobby_host
	self._lobby_client = loading_context.lobby_client
	local is_server = not not self._lobby_host
	self.is_server = is_server

	print("[Gamestate] Enter StateIngame", (is_server and "HOST") or "CLIENT")

	local assert_on_leak = true

	GarbageLeakDetector.run_leak_detection(assert_on_leak)
	GarbageLeakDetector.register_object(self, "StateIngame")
	NetworkUnit.reset_unit_data()
	Managers.time:register_timer("game", "main")

	self.last_connected_to_network_at = Managers.time:time("game")

	CLEAR_POSITION_LOOKUP()
	Profiler.start("input")

	local input_manager = InputManager:new()
	self.input_manager = input_manager
	Managers.input = self.input_manager

	input_manager:initialize_device("keyboard")
	input_manager:initialize_device("mouse")
	input_manager:initialize_device("gamepad")

	if script_data.debug_enabled then
		input_manager:create_input_service("Debug", "DebugKeymap", "DebugInputFilters")
		input_manager:map_device_to_service("Debug", "keyboard")
		input_manager:map_device_to_service("Debug", "mouse")
		input_manager:map_device_to_service("Debug", "gamepad")
		input_manager:create_input_service("DebugMenu", "DebugKeymap", "DebugInputFilters")
		input_manager:map_device_to_service("DebugMenu", "keyboard")
		input_manager:map_device_to_service("DebugMenu", "mouse")
		input_manager:map_device_to_service("DebugMenu", "gamepad")

		if PLATFORM == "win32" and (BUILD == "dev" or BUILD == "debug") then
			input_manager:initialize_device("synergy_keyboard")
			input_manager:initialize_device("synergy_mouse")
			input_manager:map_device_to_service("Debug", "synergy_keyboard")
			input_manager:map_device_to_service("Debug", "synergy_mouse")
			input_manager:map_device_to_service("DebugMenu", "synergy_keyboard")
			input_manager:map_device_to_service("DebugMenu", "synergy_mouse")
		end
	end

	Profiler.stop("input")
	Managers.popup:set_input_manager(input_manager)

	self.level_transition_handler = loading_context.level_transition_handler
	local level_key = self.level_transition_handler:get_current_level_keys()
	self.level_key = level_key
	self.is_in_inn = level_key == "inn_level"
	self.is_in_tutorial = level_key == "tutorial"

	Managers.light_fx:set_lightfx_color_scheme((self.is_in_inn and "inn_level") or "ingame")

	if loading_context.statistics_db then
		self.statistics_db = loading_context.statistics_db

		if not self.is_in_inn then
			self.statistics_db:reset_session_stats()
		end
	else
		local db = StatisticsDatabase:new()

		db:register("session", "session", nil)

		loading_context.statistics_db = db
		self.statistics_db = db
	end

	Managers.player:set_statistics_db(self.statistics_db)

	self._max_local_players = PlayerManager.MAX_PLAYERS

	if self.is_server then
		local lobby_data = self._lobby_host:get_stored_lobby_data()
		lobby_data.selected_level_key = self.level_key

		self._lobby_host:set_lobby_data(lobby_data)
	end

	self.world_name = "level_world"

	self:_setup_world()

	local world = self.world
	self.peer_id = Network.peer_id()

	Profiler.start("network_stuff")

	local network_event_delegate = NetworkEventDelegate:new()
	self.network_event_delegate = network_event_delegate
	self.network_server = loading_context.network_server
	self.network_client = loading_context.network_client

	if self.network_server then
		self.network_transmit = loading_context.network_transmit or NetworkTransmit:new(is_server, self.network_server.connection_handler)

		self.network_server:register_rpcs(network_event_delegate, self.network_transmit)

		self.profile_synchronizer = self.network_server.profile_synchronizer

		self.network_server.voip:set_input_manager(self.input_manager)
		print("[StateIngame] Server ingame")
	elseif self.network_client then
		print("[StateIngame] Client ingame")

		if loading_context.network_transmit then
			print("Using old NetworkTransmit")
		end

		self.network_transmit = loading_context.network_transmit or NetworkTransmit:new(is_server, self.network_client.connection_handler)

		self.network_client:register_rpcs(network_event_delegate, self.network_transmit)

		self.profile_synchronizer = self.network_client.profile_synchronizer

		self.network_client.voip:set_input_manager(self.input_manager)
	end

	self.network_transmit:set_network_event_delegate(network_event_delegate)
	network_event_delegate:register(self, "rpc_kick_peer")
	self.statistics_db:register_network_event_delegate(network_event_delegate)

	loading_context.network_transmit = self.network_transmit

	Profiler.stop("network_stuff")
	Profiler.start("debug_stuff")
	Debug.setup(world, self.world_name)

	local debug_screen_data = require("scripts/utils/debug_screen_config")

	DebugScreen.setup(world, debug_screen_data.settings, debug_screen_data.callbacks)
	VisualAssertLog.setup(world)
	DebugKeyHandler.setup(world, self.input_manager)
	FunctionCallProfiler.setup(world)
	PoolTableVisualizer.setup(world)

	if not script_data.debug_enabled then
		DebugKeyHandler.set_enabled(false)
	end

	Profiler.stop("debug_stuff")

	local difficulty = nil

	if not loading_context.difficulty then
		difficulty = script_data.current_difficulty_setting or "normal"
	else
		difficulty = loading_context.difficulty
	end

	Managers.state.difficulty = DifficultyManager:new(world, is_server, network_event_delegate, self._lobby_host)

	Managers.state.difficulty:set_difficulty(difficulty)

	loading_context.difficulty = difficulty
	local num_players = 1
	self.num_local_human_players = num_players

	if Managers.matchmaking then
		Managers.matchmaking:reset_ping()
		Managers.matchmaking:reset_lobby_filters()
	else
		local matchmaking_params = {
			level_transition_handler = self.level_transition_handler,
			network_transmit = self.network_transmit,
			network_server = self.network_server,
			lobby = self._lobby_host or self._lobby_client,
			peer_id = self.peer_id,
			is_server = is_server,
			profile_synchronizer = self.profile_synchronizer,
			statistics_db = self.statistics_db,
			network_server = self.network_server
		}
		Managers.matchmaking = MatchmakingManager:new(matchmaking_params)
	end

	Managers.matchmaking:register_rpcs(network_event_delegate)
	Managers.matchmaking:set_statistics_db(self.statistics_db)
	self:_setup_state_context(world, is_server, network_event_delegate)
	self.level_transition_handler:register_rpcs(network_event_delegate)

	Managers.state.quest = QuestManager:new(self.statistics_db, level_key)

	if rawget(_G, "ControllerFeaturesManager") then
		Managers.state.controller_features = ControllerFeaturesManager:new(self.is_in_inn)
	end

	Managers.telemetry.rpc_listener:register(self.network_event_delegate)
	Managers.telemetry:reset()

	local engine_revision = script_data.build_identifier
	local content_revision = script_data.settings.content_revision

	Managers.telemetry.events:header(engine_revision, content_revision)

	local difficulty = Managers.state.difficulty:get_difficulty()

	Managers.telemetry.events:game_started(is_server, level_key, difficulty)

	if TelemetrySettings.collect_memory then
		local memory_tree = Profiler.memory_tree()
		local memory_resources = Profiler.memory_resources("all")

		Managers.telemetry.events:memory_statistics(memory_tree, memory_resources)
	end

	if is_server then
		local session_id = Managers.state.network:session_id()

		Managers.telemetry.events:session_id(session_id)
	end

	local event_manager = Managers.state.event

	event_manager:register(self, "event_play_particle_effect", "event_play_particle_effect", "event_start_network_timer", "event_start_network_timer", "xbox_one_hack_start_game", "event_xbox_one_hack_start_game")

	local level = self:_create_level()
	self.level = level

	Managers.state.entity:system("darkness_system"):set_level(level)

	local checkpoint_data = loading_context.checkpoint_data

	if self.is_server then
		Managers.state.entity:system("pickup_system"):setup_taken_pickups(checkpoint_data)

		if checkpoint_data then
			local state_managers = Managers.state

			state_managers.spawn:load_checkpoint_data(checkpoint_data)
			state_managers.conflict.level_analysis:set_random_seed(checkpoint_data.level_analysis)

			loading_context.checkpoint_data = nil
		else
			Managers.state.conflict.level_analysis:set_random_seed()
		end
	end

	if Managers.state.room then
		Managers.state.room:setup_level_anchor_points(self.level)
	end

	Profiler.start("Optimizing Level Units")

	local level_units = Level.units(level)

	for _, unit in ipairs(level_units) do
		ScriptUnit.optimize(unit)
	end

	Profiler.stop("Optimizing Level Units")
	InputDebugger:setup(world, self.input_manager)
	Profiler.start("sub_states")

	self.machines = {}

	for i = 1, num_players, 1 do
		local viewport_name = "player_" .. i
		self.viewport_name = viewport_name
		local network_options = {
			project_hash = "bulldozer",
			config_file_name = "global",
			lobby_port = GameSettingsDevelopment.network_port
		}
		local params = {
			local_player_id = i,
			viewport_name = viewport_name,
			is_in_inn = self.is_in_inn,
			is_in_tutorial = self.is_in_tutorial,
			is_server = is_server,
			network_options = network_options,
			input_manager = self.input_manager,
			world_name = self.world_name,
			free_flight_manager = self.free_flight_manager,
			lobby_host = loading_context.lobby_host,
			lobby_client = loading_context.lobby_client,
			level_transition_handler = loading_context.level_transition_handler,
			profile_synchronizer = self.profile_synchronizer,
			network_event_delegate = self.network_event_delegate,
			statistics_db = self.statistics_db,
			dice_keeper = self.dice_keeper,
			level_key = level_key,
			network_server = self.network_server,
			network_client = self.network_client,
			network_transmit = self.network_transmit,
			voip = (self.network_server and self.network_server.voip) or self.network_client.voip
		}

		Managers.player:add_player(nil, viewport_name, self.world_name, i)

		self.machines[i] = GameStateMachine:new(self, StateInGameRunning, params, true)
	end

	Profiler.stop("sub_states")

	if checkpoint_data then
		Managers.state.entity:system("mission_system"):load_checkpoint_data(checkpoint_data.mission)
	end

	local wwise_world = Managers.world:wwise_world(world)
	local post_init_data = {
		hero_spawner_handler = Managers.state.spawn.hero_spawner_handler,
		difficulty = Managers.state.difficulty,
		wwise_world = wwise_world,
		reset_matchmaking = self.is_in_inn
	}

	Managers.matchmaking:setup_post_init_data(post_init_data)
	Profiler.start("level_stuff")
	Level.trigger_level_loaded(level)
	World.set_data(self.world, "level_seed", nil)

	if checkpoint_data then
		Managers.state.networked_flow_state:load_checkpoint_data(checkpoint_data.networked_flow_state)
	end

	if self.is_in_inn and not SaveData.first_time_in_inn then
		Level.trigger_event(level, "first_time_started_game")

		SaveData.first_time_in_inn = true

		Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_save_data"))
	end

	local nested_levels = Level.nested_levels(level)

	for _, level in ipairs(nested_levels) do
		Level.trigger_level_loaded(level)
	end

	Profiler.stop("level_stuff")

	local platform = PLATFORM

	if platform == "win32" then
		Window.set_mouse_focus(true)
	end

	Network.write_dump_tag("start of game")

	local network_manager = Managers.state.network
	local network_game = network_manager:game()
	local is_spawn_owner = self._lobby_host and network_game

	if is_spawn_owner or LEVEL_EDITOR_TEST then
		Managers.state.conflict:ai_ready()

		local volume_system = Managers.state.entity:system("volume_system")

		volume_system:ai_ready()
	end

	Profiler.start("populate pickups")

	if self.is_server and checkpoint_data then
		Managers.state.entity:system("pickup_system"):populate_pickups(checkpoint_data.pickup)
	elseif self.is_server then
		Managers.state.entity:system("pickup_system"):populate_pickups()
	end

	Profiler.stop("populate pickups")

	local dynamic_range_sound = Application.user_setting("dynamic_range_sound")

	if dynamic_range_sound ~= nil then
		local value = nil

		if dynamic_range_sound == "low" then
			value = 1
		elseif dynamic_range_sound == "high" then
			value = 0
		else
			local default = DefaultUserSettings.get("user_settings", "dynamic_range_sound")

			if default == "low" then
				value = 1
			elseif default == "high" then
				value = 0
			end
		end

		WwiseWorld.set_global_parameter(wwise_world, "dynamic_range_sound", value)
	end

	if PLATFORM == "win32" then
		local sound_quality = Application.user_setting("sound_quality")

		SoundQualitySettings.set_sound_quality(wwise_world, sound_quality)

		local sfx_bus_volume = Application.user_setting("sfx_bus_volume")

		if sfx_bus_volume ~= nil then
			local wwise_world = Managers.world:wwise_world(world)

			WwiseWorld.set_global_parameter(wwise_world, "sfx_bus_volume", sfx_bus_volume)
		end

		local voice_bus_volume = Application.user_setting("voice_bus_volume")

		if voice_bus_volume ~= nil then
			local wwise_world = Managers.world:wwise_world(world)

			WwiseWorld.set_global_parameter(wwise_world, "voice_bus_volume", voice_bus_volume)
		end

		local master_bus_volume = Application.user_setting("master_bus_volume")

		if master_bus_volume ~= nil then
			local wwise_world = Managers.world:wwise_world(world)

			WwiseWorld.set_global_parameter(wwise_world, "master_bus_volume", master_bus_volume)
		end
	end

	Managers.music:on_enter_level(network_event_delegate, is_server)

	local disable_backend_sessions = Managers.state.game_mode:game_mode_key() == "inn"

	ScriptBackendSession.init(network_event_delegate, disable_backend_sessions)
	Managers.chat:register_network_event_delegate(network_event_delegate)

	if self.network_server then
		ScriptBackendSession.start()
		self.network_server:on_game_entered(network_manager)
	elseif self.network_client then
		self.network_client:on_game_entered()
	end

	local fullscreen = Application.user_setting("fullscreen")
	local borderless_fullscreen = Application.user_setting("borderless_fullscreen")
	local windowed = not fullscreen and not borderless_fullscreen
	local screen_mode = (fullscreen and "fullscreen") or (borderless_fullscreen and "borderless_fullscreen") or (windowed and "windowed")
	local res_x, res_y = Application.resolution()
	local resolution_string = string.format("%dx%d", res_x, res_y)
	local graphics_quality = Application.user_setting("graphics_quality")

	Managers.telemetry.events:tech_settings(resolution_string, graphics_quality, screen_mode)

	local system_info = Application.sysinfo()
	local adapter_index = Application.user_setting("adapter_index")

	Managers.telemetry.events:tech_system(system_info, adapter_index)

	if PLATFORM == "xb1" then
		Managers.account:set_presence("playing")
	elseif platform == "ps4" then
		if self.is_in_inn then
			Managers.account:set_presence("inn")
			Managers.account:set_realtime_multiplay_state("inn", true)
		else
			if self.is_in_tutorial then
				Managers.account:set_realtime_multiplay_state("tutorial", true)
			end

			local level_display_name = LevelSettings[self.level_key].display_name

			Managers.account:set_presence("playing", level_display_name)
		end
	end

	local in_game_session = Managers.state.network:in_game_session()

	print("In gamesession", in_game_session)
	self:_check_mutators()
end

StateIngame._check_mutators = function (self)
	if Managers.state.quest:is_mutator_active("fog") then
		local darkness_system = Managers.state.entity:system("darkness_system")

		darkness_system:set_global_darkness(true)
		darkness_system:set_local_players_light_intensity(3)
		Managers.state.camera:set_fog_depth_override(0, 5)
	end
end

StateIngame.event_xbox_one_hack_start_game = function (self, level_key, difficulty)
	Managers.state.difficulty:set_difficulty(difficulty)
	self.level_transition_handler:set_next_level(level_key)
	Managers.state.game_mode:complete_level()
end

StateIngame.cb_save_data = function (self)
	print("saved data")
end

StateIngame._setup_world = function (self)
	local shading_callback = callback(self, "shading_callback")
	local layer = 1

	if Application.user_setting("disable_apex_cloth") then
		self.world = Managers.world:create_world(self.world_name, nil, shading_callback, layer, Application.ENABLE_UMBRA, Application.DISABLE_APEX_CLOTH)
	else
		self.world = Managers.world:create_world(self.world_name, nil, shading_callback, layer, Application.ENABLE_UMBRA, Application.APEX_LOD_RESOURCE_BUDGET, Application.user_setting("apex_lod_resource_budget") or ApexClothQuality.high.apex_lod_resource_budget)
	end

	Managers.world:set_anim_update_callback(self.world, function ()
		self.machines[1]:state():update_ui()
	end)
	Managers.world:set_scene_update_callback(self.world, function ()
		Profiler.start("Scene update Callback")
		self:physics_async_update(self.dt)
		Profiler.stop("Scene update Callback")
	end)

	if Managers.splitscreen then
		Managers.splitscreen:add_splitscreen_viewport(self.world)
	end
end

StateIngame._safe_to_do_entity_update = function (self)
	local network_manager = Managers.state.network

	if network_manager:has_left_game() or not network_manager:in_game_session() then
		return false
	end

	local t = Managers.time:time("game")
	local game_mode_ended = Managers.state.game_mode:is_game_mode_ended()
	local left_game_mode = game_mode_ended and self.game_mode_end_timer and self.game_mode_end_timer <= t

	return not left_game_mode
end

StateIngame.physics_async_update = function (self, dt)
	local t = Managers.time:time("game")

	Profiler.start("Music manager")
	Managers.music:update(self.dt, t)
	Profiler.stop("Music manager")

	if self:_safe_to_do_entity_update() then
		self.entity_system:physics_async_update()
	end
end

StateIngame.shading_callback = function (self, world, shading_env, viewport)
	Managers.state.camera:shading_callback(world, shading_env, viewport)
end

StateIngame._teardown_level = function (self)
	World.destroy_level(self.world, self.level)
end

StateIngame._teardown_world = function (self)
	if Managers.splitscreen then
		Managers.splitscreen:remove_splitscreen_viewport()
	end

	if Debug.active then
		Debug.teardown()
	end

	World.destroy_gui(self.world, self._debug_gui)
	World.destroy_gui(self.world, self._debug_gui_immediate)
	Managers.world:destroy_world(self.world_name)
end

StateIngame.spawn_unit = function (self, unit, ...)
	if not Managers.state.entity then
		printf("Unit %s is spawned after level destroy?", tostring(unit))

		return
	end

	Managers.state.entity:register_unit(self.world, unit, ...)
end

StateIngame.unspawn_unit = function (self, unit)
	if not Managers.state.entity then
		printf("Unit %s has not been destroyed by entity manager or level destroy", tostring(unit))

		return
	end

	Unit.flow_event(unit, "unit_despawned")
	Managers.state.entity:unregister_unit(unit)
end

StateIngame._create_level = function (self)
	Profiler.start("create_level")

	local level_key = self.level_transition_handler:get_current_level_keys()
	local level_name = LevelSettings[level_key].level_name
	local game_mode_manager = Managers.state.game_mode
	local game_mode_object_sets = game_mode_manager:object_sets()
	local spawned_object_sets = {}
	local object_sets = {}
	local available_level_sets = LevelResource.object_set_names(level_name)

	for key, set in ipairs(available_level_sets) do
		local object_set_table = {
			type = "",
			key = key,
			units = LevelResource.unit_indices_in_object_set(level_name, set)
		}

		if game_mode_object_sets[set] or set == "shadow_lights" then
			spawned_object_sets[#spawned_object_sets + 1] = set
		elseif string.sub(set, 1, 5) == "flow_" then
			spawned_object_sets[#spawned_object_sets + 1] = set
			object_set_table.type = "flow"
		elseif string.sub(set, 1, 5) == "team_" then
			spawned_object_sets[#spawned_object_sets + 1] = set
			object_set_table.type = "team"
		end

		object_sets[set] = object_set_table
	end

	local level_seed = Managers.state.game_mode.level_transition_handler.level_seed

	print("[StateIngame] Level seed:", level_seed)
	World.set_data(self.world, "level_seed", level_seed)
	World.set_data(self.world, "debug_level_seed", {})

	local level = ScriptWorld.load_level(self.world, level_name, spawned_object_sets, nil, nil, callback(self, "shading_callback"))

	Managers.state.networked_flow_state:set_level(level)
	World.set_flow_callback_object(self.world, self)
	Managers.state.entity:add_and_register_units(self.world, World.units(self.world))
	game_mode_manager:register_object_sets(object_sets)
	Level.spawn_background(level)
	Profiler.stop("create_level")

	return level
end

script_data.disable_ui = script_data.disable_ui or Development.parameter("disable_ui")

StateIngame.pre_update = function (self, dt)
	local t = Managers.time:time("game")
	local network_manager = Managers.state.network

	UPDATE_POSITION_LOOKUP()
	UPDATE_PLAYER_LISTS()
	network_manager:update_receive(dt)
	Profiler.start("Network Client/Server update")

	if self.network_server then
		self.network_server:update(dt)
	end

	if self.network_client then
		self.network_client:update(dt)
	end

	Profiler.stop("Network Client/Server update")
	Profiler.start("spawn")
	Managers.state.spawn:update(dt, t)
	Profiler.stop("spawn")
	self.entity_system:commit_and_remove_pending_units()

	if self:_safe_to_do_entity_update() then
		self.entity_system:pre_update(dt, t)
	end
end

local knoywloke = nil

StateIngame.update = function (self, dt, main_t)
	Vault.reseed()

	self.dt = dt

	if not self.network_client or self.network_client.state == "game_started" then
		self.network_clock:update(dt)
		self.network_timer_handler:update(dt, main_t)
	end

	local is_server = self.is_server
	local Managers = Managers

	Managers.state.network:update(dt)
	Profiler.start("BackendManager update")
	Managers.backend:update(dt)
	Profiler.stop("backend")
	Profiler.start("input_manager")
	self.input_manager:update(dt, main_t)
	Profiler.stop("input_manager")
	Profiler.start("free flight")

	local debug_input_service = self.input_manager:get_service("DebugMenu")

	self.free_flight_manager:update(dt)
	Profiler.stop("free flight")
	Profiler.start("level_transition_handler")
	self.level_transition_handler:update()
	Profiler.stop("level_transition_handler")

	local t = Managers.time:time("game")

	Profiler.start("Ducking handler")
	self._ducking_handler:update(dt)
	Profiler.stop("Ducking handler")
	Profiler.start("Lobby Update")

	if self._lobby_host then
		self._lobby_host:update(dt)
	end

	if self._lobby_client then
		self._lobby_client:update(dt)
	end

	Profiler.stop("Lobby Update")
	Profiler.start("voting")
	Managers.state.voting:update(dt, t)
	Profiler.stop("voting")
	Profiler.start("matchmaking")
	Managers.matchmaking:update(dt, main_t)
	Profiler.stop("matchmaking")
	Profiler.start("achievement")
	Managers.state.achievement:update(dt, t)
	Profiler.stop("achievement")

	if GameSettingsDevelopment.backend_settings.quests_enabled then
		Profiler.start("quest")
		Managers.state.quest:update(self.statistics_db, dt, t)
		Profiler.stop("quest")
	end

	Managers.state.blood:update(dt, t)

	if Managers.state.controller_features then
		Managers.state.controller_features:update(dt, t)
	end

	if is_server then
		Managers.state.conflict:reset_data()

		if self._lobby_host:is_joined() then
			local lobby_members = self._lobby_host:members()
			local members_joined = lobby_members:get_members_joined()
			local members_joined_n = #members_joined
			local members_left = lobby_members:get_members_left()
			local members_left_n = #members_left

			if members_joined_n ~= 0 or members_left_n ~= 0 then
				local lobby_data = self._lobby_host:get_stored_lobby_data()
				local members = lobby_members:get_members()
				local members_n = #members
				lobby_data.num_players = members_n

				self._lobby_host:set_lobby_data(lobby_data)
			end

			Profiler.start("Conflict Update")

			if Managers.state.network:game() then
				Managers.state.conflict:update(dt, t)
			end

			Profiler.stop("Conflict Update")
		end
	end

	for _, machine in pairs(self.machines) do
		machine:update(dt, t)
	end

	local game_mode_ended = Managers.state.game_mode:is_game_mode_ended()

	if not game_mode_ended and self.game_mode_end_timer then
		self.game_mode_end_timer = nil
	end

	if game_mode_ended and not self.game_mode_end_timer then
		self.game_mode_end_timer = t + 0.2
	end

	if self:_safe_to_do_entity_update() then
		self.entity_system:update(dt, t)
	end

	if is_server then
		if script_data.debug_enabled and not self.is_in_inn then
			local ai_system = Managers.state.entity:system("ai_system")
			local ai_debugger = ai_system.ai_debugger

			ai_debugger:update(t, dt)
		end

		Profiler.start("Game Mode Server")
		Managers.state.game_mode:server_update(dt, t)
		Profiler.stop("Game Mode Server")
	end

	if not self._new_state then
		self._new_state = self:_check_exit(t)
	end

	if self.exit_type then
		for _, machine in pairs(self.machines) do
			machine._state:disable_ui()
		end
	end

	if self._new_state then
		if self.parent.loading_context.restart_network then
			self.leave_lobby = true
		end

		if not Managers.popup:has_popup() then
			return self._new_state
		end
	end

	Managers.state.bot_nav_transition:update(dt, t)
	Managers.state.performance:update(dt, t)

	if script_data.debug_enabled then
		Profiler.start("DebugUpdate")
		Managers.state.debug:update(dt, t)
		Debug.update(t, dt)
		VisualAssertLog.update(dt)
		DebugScreen.update(dt, t, debug_input_service, self.input_manager)
		DebugKeyHandler.render()
		DebugKeyHandler.frame_clear()
		FunctionCallProfiler.render()
		PoolTableVisualizer.render(t)
		Profiler.stop("DebugUpdate")
	end

	VALIDATE_POSITION_LOOKUP()
end

local CONNECTION_TIMEOUT = 1

StateIngame.connected_to_network = function (self, t)
	if Development.parameter("use_lan_backend") then
		return true
	end

	local connected_to_network = true

	if PLATFORM == "win32" and rawget(_G, "Steam") then
		connected_to_network = Steam.connected()
	end

	if connected_to_network then
		self.last_connected_to_network_at = t
	end

	if not connected_to_network and t > self.last_connected_to_network_at + CONNECTION_TIMEOUT then
		return false
	end

	return true
end

StateIngame.cb_transition_fade_in_done = function (self, new_state)
	self._new_state = new_state
end

StateIngame.event_start_network_timer = function (self, time)
	self.network_timer_handler:start_timer_server(time)
end

StateIngame._check_exit = function (self, t)
	local network_manager = Managers.state.network
	local lobby = self._lobby_host or self._lobby_client
	local platform = PLATFORM
	local backend_manager = Managers.backend
	local waiting_user_input = backend_manager:is_waiting_for_user_input()
	local rerolling = ScriptBackendItem.get_rerolling_trait_state() and not backend_manager:is_disconnected()
	local waiting_for_item_poll = (ScriptBackendItem.num_current_item_server_requests() ~= 0 or UISettings.waiting_for_response) and not backend_manager:is_disconnected()
	local connected_to_network = self:connected_to_network(t)

	if not self.exit_type and not waiting_user_input and not waiting_for_item_poll and not rerolling then
		local transition, join_lobby_data = nil

		for _, machine in pairs(self.machines) do
			transition, join_lobby_data = machine:state():wanted_transition()
		end

		if script_data.hammer_join and Managers.time:time("game") > 5 then
			transition = "restart_game"

			Development.set_parameter("auto_join", true)
		elseif PLATFORM == "xb1" and Managers.account:leaving_game() then
			transition = "return_to_title_screen"
		end

		local level_transition_type = self.level_transition_handler.transition_type

		if Managers.backend:is_disconnected() then
			self.exit_type = "backend_disconnected"

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			self.leave_lobby = true

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif transition == "return_to_title_screen" then
			self.exit_type = "return_to_title_screen"

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			self.leave_lobby = true

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif self.network_client and self.network_client.state == "denied_enter_game" then
			if self.network_client.host_to_migrate_to == nil or platform == "xb1" then
				self.exit_type = "join_lobby_failed"

				if self.network_client.host_to_migrate_to ~= nil and platform == "xb1" then
					Application.error("[StateIngame] XBOXONE doesn't support host migration yet")
				end
			else
				self.exit_type = "perform_host_migration"
			end

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif (lobby and lobby.state == LobbyState.FAILED) or (self.network_client and self.network_client.state == "lost_connection_to_host") then
			if self.network_client == nil or self.network_client.host_to_migrate_to == nil or platform == "xb1" then
				self.exit_type = "lobby_state_failed"

				if self.network_client ~= nil and self.network_client.host_to_migrate_to ~= nil and platform == "xb1" then
					Application.error("[StateIngame] XBOXONE doesn't support host migration yet")
				end
			else
				self.exit_type = "perform_host_migration"
			end

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif not connected_to_network then
			self.exit_type = "lobby_state_failed"

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif self.kicked_by_server then
			self.kicked_by_server = nil
			self.exit_type = "kicked_by_server"

			if self._lobby_client and self._lobby_client.state == LobbyState.JOINED then
				local lobby_id = self._lobby_client:id()

				Managers.matchmaking:add_broken_lobby(lobby_id, t, true)
			end

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif transition == "finish_tutorial" then
			self.exit_type = "finished_tutorial"

			self.network_server:disconnect_all_peers("host_left_game")

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
			Managers.transition:show_loading_icon()
		elseif level_transition_type == "reload_level" then
			self.exit_type = "reload_level"

			if self.is_server then
				network_manager.network_transmit:send_rpc_clients("rpc_reload_level")
				network_manager:leave_game()
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif level_transition_type then
			self.exit_type = "load_next_level"

			printf("Transition type %q, is server: %s", tostring(level_transition_type), tostring(self.is_server))

			if self.is_server then
				local level_to_transition_to = self.level_transition_handler:get_current_transition_level()

				self.network_server:set_current_level(level_to_transition_to)
				network_manager.network_transmit:send_rpc_clients("rpc_load_level", NetworkLookup.level_keys[level_to_transition_to], self.level_transition_handler.level_seed)
				network_manager:leave_game()
			else
				self.network_client:set_wait_for_state_loading(true)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif transition == "leave_game" then
			self.exit_type = "left_game"

			if self.network_server then
				self.network_server:disconnect_all_peers("host_left_game")
			elseif self._lobby_client and self._lobby_client.state == LobbyState.JOINED then
				print("Leaving lobby, noting it as one I don't want to matchmake back into soon")

				local lobby_id = self._lobby_client:id()

				Managers.matchmaking:add_broken_lobby(lobby_id, t, true)
			end

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
			Managers.transition:show_loading_icon()
		elseif transition == "afk_kick" then
			self.exit_type = "afk_kick"

			if network_manager:in_game_session() then
				local force_diconnect = true

				network_manager:leave_game(force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
			Managers.transition:show_loading_icon()
		elseif transition == "join_lobby" then
			self.exit_type = "join_game"

			if network_manager:in_game_session() then
				network_manager:leave_game()
			end

			self.parent.loading_context.join_lobby_data = join_lobby_data

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
			Managers.transition:show_loading_icon()
		elseif transition == "start_lobby" then
			self.exit_type = "join_game"

			if network_manager:in_game_session() then
				network_manager:leave_game()
			end

			self.parent.loading_context.start_lobby_data = join_lobby_data

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
			Managers.transition:show_loading_icon()
		elseif transition == "restart_game" then
			self.exit_type = "restart_game"

			if network_manager:in_game_session() then
				network_manager:leave_game()
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
			Managers.transition:show_loading_icon()
		end

		if self.exit_type then
			self.exit_time = t + 2

			printf("StateIngame: Got transition %s, set exit type to %s. Will exit at t=%.2f", tostring(transition), self.exit_type, self.exit_time)

			local input_manager = self.input_manager

			input_manager:block_device_except_service(nil, "keyboard", 1)
			input_manager:block_device_except_service(nil, "mouse", 1)
			input_manager:block_device_except_service(nil, "gamepad", 1)
			Managers.popup:cancel_all_popups()
			self.level_transition_handler:set_transition_exit_type(self.exit_type)

			if platform == "xb1" then
				self.machines[1]:state():trigger_xbox_multiplayer_round_end_events()
			end
		end
	end

	local SESSION_LEAVE_TIMEOUT = 4

	if self.exit_time and self.exit_time <= t then
		local exit_type = self.exit_type
		local has_left = network_manager:has_left_game()
		local game_session_is_closed = has_left or not network_manager:in_game_session()

		if not game_session_is_closed and t >= self.exit_time + SESSION_LEAVE_TIMEOUT then
			print("Session leave timeout reached, force disconnecting")
			network_manager:force_disconnect_from_session()

			return
		elseif not game_session_is_closed then
			return
		end

		if exit_type == "join_lobby_failed" or exit_type == "left_game" or exit_type == "lobby_state_failed" or exit_type == "kicked_by_server" or exit_type == "afk_kick" then
			printf("[StateIngame] Transition to StateLoadingRestartNetwork on %q", self.exit_type)
			self.level_transition_handler:set_next_level(self.level_transition_handler:default_level_key())

			if exit_type == "lobby_state_failed" then
				if self.is_server then
					self.parent.loading_context.previous_session_error = "broken_connection"
				else
					self.parent.loading_context.previous_session_error = "lobby_disconnected"
				end
			elseif exit_type == "kicked_by_server" then
				self.parent.loading_context.previous_session_error = "kicked_by_server"
			elseif exit_type == "join_lobby_failed" and self.network_client then
				self.parent.loading_context.previous_session_error = self.network_client.fail_reason
			elseif exit_type == "afk_kick" then
				self.parent.loading_context.previous_session_error = "afk_kick"
			end

			self.parent.loading_context.restart_network = true

			if exit_type == "lobby_state_failed" then
				if PLATFORM == "xb1" then
					return StateLoading
				else
					return StateTitleScreen
				end
			else
				return StateLoading
			end
		elseif exit_type == "finished_tutorial" then
			Managers.backend:stop_tutorial()

			local loading_context = self.parent.loading_context
			loading_context.play_trailer = true
			loading_context.finished_tutorial = true

			if Managers.play_go:installed() then
				loading_context.restart_network = true

				self.level_transition_handler:set_next_level(self.level_transition_handler:default_level_key())
				printf("[StateIngame] Transition to StateLoadingRestartNetwork on %q", exit_type)
			else
				loading_context.restart_network = nil

				printf("[StateIngame] Transition to StateLoadingRunning on %q", exit_type)
			end

			return StateLoading
		elseif exit_type == "perform_host_migration" then
			local host_migration_info = {
				host_to_migrate_to = self.network_client.host_to_migrate_to
			}

			if Managers.state.game_mode:is_game_mode_ended() then
				local level_key = self.level_transition_handler:default_level_key()
				host_migration_info.level_to_load = level_key
			end

			local is_private = self._lobby_client:lobby_data("is_private")
			local difficulty = Managers.state.difficulty:get_difficulty()
			host_migration_info.lobby_data = {
				is_private = is_private,
				difficulty = difficulty
			}
			self.parent.loading_context.host_migration_info = host_migration_info
			self.parent.loading_context.wanted_profile_index = self:wanted_profile_index()
			self.leave_lobby = true

			return StateLoading
		elseif exit_type == "backend_disconnected" then
			printf("[StateIngame] Transition to StateTitleScreen on %q", self.exit_type)

			self.release_level_resources = true
			self.parent.loading_context = {}

			return StateTitleScreen
		elseif exit_type == "return_to_title_screen" then
			printf("[StateIngame] Transition to StateTitleScreen on %q", self.exit_type)

			self.release_level_resources = true
			self.parent.loading_context = {}

			return StateTitleScreen
		elseif exit_type == "load_next_level" or exit_type == "reload_level" then
			self.parent.loading_context.checkpoint_data = self.level_transition_handler.checkpoint_data
			self.parent.loading_context.lobby_host = self._lobby_host
			self.parent.loading_context.lobby_client = self._lobby_client
			self.parent.loading_context.matchmaking_loading_context = Managers.matchmaking:loading_context()
			self.parent.loading_context.wanted_profile_index = self:wanted_profile_index()

			return StateLoading
		elseif exit_type == "join_game" then
			self.leave_lobby = true
			self.parent.loading_context.matchmaking_loading_context = Managers.matchmaking:loading_context()
			self.parent.loading_context.wanted_profile_index = self:wanted_profile_index()

			return StateLoading
		elseif exit_type == "restart_game" then
			printf("[StateIngame] Transition to StateSplashScreen on %q", self.exit_type)

			self.leave_lobby = true
			self.release_level_resources = true
			self.parent.loading_context.restart_network = true
			self.parent.loading_context.reload_packages = true

			return StateSplashScreen
		end
	end
end

StateIngame.wanted_profile_index = function (self)
	local peer_id = Network.peer_id()
	local player = Managers.player:player_from_peer_id(peer_id)
	local current_profile_index = player.profile_index
	local selected_profile_index = Managers.matchmaking.selected_profile_index
	local saved_profile_index = SaveData.wanted_profile_index
	local wanted_profile_index = selected_profile_index or current_profile_index or saved_profile_index or 0

	return wanted_profile_index
end

StateIngame.post_update = function (self, dt)
	local t = Managers.time:time("game")

	self.entity_system:post_update(dt, t)

	for _, machine in pairs(self.machines) do
		if machine.post_update then
			machine:post_update(dt, t)
		end
	end

	Managers.state.game_mode:update_flow_object_set_enable(dt)

	local network_manager = Managers.state.network

	network_manager.network_transmit:transmit_local_rpcs()
	Managers.state.unit_spawner:update_death_watch_list(dt, t)
	self.entity_system:commit_and_remove_pending_units()
	Managers.state.spawn:post_unit_destroy_update()
	network_manager:update_transmit(dt)

	if Managers.voice_chat then
		Managers.voice_chat:update(dt, t)
	end
end

StateIngame.on_exit = function (self, application_shutdown)
	UPDATE_POSITION_LOOKUP()
	UPDATE_PLAYER_LISTS()

	if PLATFORM ~= "win32" then
		local game_mode_key = Managers.state.game_mode:game_mode_key()

		if game_mode_key ~= "inn" then
			StatisticsUtil.register_console_specific_stats(self.statistics_db)
		end
	end

	self:_check_and_add_end_game_telemetry(application_shutdown)

	if TelemetrySettings.collect_memory then
		local memory_tree = Profiler.memory_tree()
		local memory_resources = Profiler.memory_resources("all")

		Managers.telemetry.events:memory_statistics(memory_tree, memory_resources)
	end

	if TelemetrySettings.send then
		local game_mode_key = Managers.state.game_mode:game_mode_key()

		if game_mode_key == "inn" then
			print("[StateIngame] Skipped uploading telemetry data for the inn level")
		else
			local token = Managers.telemetry:send()

			Managers.token:register_token(token)
		end
	else
		printf("[StateIngame] Skipped uploading telemetry data")
	end

	Managers.telemetry.rpc_listener:unregister(self.network_event_delegate)
	DebugKeyHandler.set_enabled(false)
	DebugScreen.destroy()
	self.network_timer_handler:unregister_rpcs()
	self.network_timer_handler:destroy()

	self.network_timer_handler = nil

	self.network_clock:unregister_rpcs()
	self.network_clock:destroy()

	self.network_clock = nil

	for local_player_id, machine in pairs(self.machines) do
		Managers.player:remove_player(Network.peer_id(), local_player_id)
		machine:destroy()
	end

	self.machines = nil

	Network.write_dump_tag("end of game")
	Managers.music:on_exit_level()

	local current_difficulty = Managers.state.difficulty:get_difficulty()
	self.parent.loading_context.difficulty = current_difficulty

	self.level_transition_handler:unregister_rpcs()
	self.level_transition_handler:unregister_events(Managers.state.event)
	self.level_transition_handler:clear_transition_exit_type()
	self._ducking_handler:destroy()
	Profiler.start("destroy units")

	local unit_spawner = Managers.state.unit_spawner
	unit_spawner.locked = false

	unit_spawner:commit_and_remove_pending_units()

	local world = self.world
	local unit_storage = Managers.state.unit_storage
	local units = unit_storage:units()

	for id, unit_to_destroy in pairs(units) do
		Managers.state.entity:unregister_unit(unit_to_destroy)
		World.destroy_unit(world, unit_to_destroy)
	end

	self.entity_system:destroy()
	self.entity_system_bag:destroy()
	Profiler.stop("destroy units")
	ScriptBackendSession.leave()
	Managers.player:exit_ingame()
	self:_teardown_level()
	Managers.state:destroy()
	VisualAssertLog.cleanup()
	self:_teardown_world()
	ScriptUnit.check_all_units_deleted()
	self.statistics_db:unregister_network_event_delegate()
	Managers.time:unregister_timer("game")

	local matchmaking_loading_context = self.parent.loading_context.matchmaking_loading_context

	if matchmaking_loading_context and matchmaking_loading_context.network_client then
		matchmaking_loading_context.network_client:unregister_rpcs()
	end

	if self.network_client then
		self.network_client:unregister_rpcs()
	end

	if self.network_server and not application_shutdown then
		self.network_server:on_level_exit()
	end

	if self.network_client then
		self.network_client.voip:set_input_manager(nil)
	end

	if self.network_server then
		self.network_server.voip:set_input_manager(nil)
	end

	Managers.matchmaking:unregister_rpcs()

	if application_shutdown or self.leave_lobby then
		if Managers.matchmaking then
			Managers.matchmaking:destroy()

			Managers.matchmaking = nil
		end

		Managers.chat:unregister_channel(1)

		local network_event_meta_table = {
			__index = function (event_table, event_key)
				return function ()
					Application.warning("Got RPC %s during forced network update when exiting StateIngame", event_key)
				end
			end
		}

		if self._lobby_host then
			self._lobby_host:destroy()

			self._lobby_host = nil

			Network.update(0, setmetatable({}, network_event_meta_table))
			Managers.account:set_current_lobby(nil)

			if self.network_server then
				self.network_server:destroy()

				self.network_server = nil
			end

			self.parent.loading_context.lobby_host = nil
		end

		if self._lobby_client then
			self._lobby_client:destroy()

			self._lobby_client = nil

			Network.update(0, setmetatable({}, network_event_meta_table))
			Managers.account:set_current_lobby(nil)

			if self.network_client then
				self.network_client:destroy()

				self.network_client = nil
			end

			self.parent.loading_context.lobby_client = nil
		end

		if application_shutdown then
			LobbyInternal.shutdown_client()
		end

		self.profile_synchronizer = nil
		self.parent.loading_context.network_client = nil
		self.parent.loading_context.network_server = nil
		self.parent.loading_context.network_transmit = nil

		self.network_transmit:destroy()

		self.network_transmit = nil

		print("Cleaned up NetworkTransmit", self.network_transmit, self.parent.loading_context.network_transmit)
	else
		self.profile_synchronizer:unregister_network_events()

		if self.is_server and not self.is_in_inn and not self.is_in_tutorial and PLATFORM == "xb1" then
			local level_key = self.level_transition_handler:get_next_level_key()
			local difficulty = current_difficulty

			if level_key == "inn_level" or level_key == "tutorial" then
				Application.warning("Cancelling matchmaking")
				self._lobby_host:enable_matchmaking(false)
			else
				Application.warning(string.format("Reissuing Ticket for %s and difficulty %s", level_key, difficulty))
				Managers.matchmaking:reissue_smartmatch_ticket(level_key, difficulty, self.game_mode_key)
			end
		end
	end

	self.free_flight_manager:unregister_input_manager()

	self.free_flight_manager = nil
	self.parent = nil

	if self._debug_event_manager_rpc then
		self._debug_event_manager_rpc:delete()

		self._debug_event_manager_rpc = nil
	end

	Managers.chat:unregister_network_event_delegate()
	self.dice_keeper:unregister_rpc()

	self.dice_keeper = nil

	Managers.popup:remove_input_manager(application_shutdown)
	InputDebugger:clear()
	self.input_manager:destroy()

	self.input_manager = nil
	Managers.input = nil

	self.network_event_delegate:unregister(self)
	self.network_event_delegate:destroy()

	self.network_event_delegate = nil

	if application_shutdown or self.release_level_resources then
		self.level_transition_handler:release_level_resources(self.level_key)
	end

	if Managers.backend and Managers.backend:item_script_type() == "tutorial" then
		Managers.backend:stop_tutorial()
	end

	Managers.transition:show_loading_icon()

	if PLATFORM == "ps4" then
		if self.is_in_tutorial then
			Managers.account:set_realtime_multiplay_state("tutorial", false)
		end

		if self.is_in_inn then
			Managers.account:set_realtime_multiplay_state("inn", false)
		end
	end
end

StateIngame._check_and_add_end_game_telemetry = function (self, application_shutdown)
	local player = Managers.player:player_from_peer_id(self.peer_id)
	local level_key = self.level_key
	local difficulty = Managers.state.difficulty:get_difficulty()
	local reason = self.exit_type

	if application_shutdown then
		local controlled_exit = Boot:is_controlled_exit()

		if controlled_exit then
			reason = "controlled_exit"
		else
			reason = "forced_exit"
		end
	else
		local level_related_reason = self.exit_type == "load_next_level" or self.exit_type == "reload_level"

		if level_related_reason then
			if Managers.state.game_mode:game_won() then
				reason = "won"
			elseif Managers.state.game_mode:game_lost() then
				reason = "lost"
			end
		end
	end

	Managers.telemetry.events:game_ended(player, self.is_server, level_key, difficulty, reason)
end

StateIngame._setup_state_context = function (self, world, is_server, network_event_delegate)
	local network_clock = nil

	if self.is_server then
		network_clock = NetworkClockServer:new()
	else
		network_clock = NetworkClockClient:new()
	end

	self.network_clock = network_clock

	network_clock:register_rpcs(network_event_delegate)

	local network_manager = GameNetworkManager:new(world, self._lobby_host or self._lobby_client, is_server)
	Managers.state.network = network_manager

	network_manager:register_event_delegate(network_event_delegate)

	local build = BUILD

	if build == "debug" or build == "dev" then
		self._debug_event_manager_rpc = DebugEventManagerRPC:new(network_event_delegate)
	end

	self._ducking_handler = DuckingHandler:new()
	Managers.state.event = EventManager:new()

	self.level_transition_handler:register_events(Managers.state.event)

	local level_key = self.level_transition_handler:get_current_level_keys()
	Managers.state.conflict = ConflictDirector:new(world, level_key, network_event_delegate)
	local game_mode_key = nil

	if self.is_in_inn then
		game_mode_key = "inn"
	else
		local level_settings = LevelSettings[level_key]
		local level_game_mode = level_settings.game_mode
		game_mode_key = level_game_mode
	end

	self.game_mode_key = game_mode_key
	Managers.state.game_mode = GameModeManager:new(world, self._lobby_host, self._lobby_client, self.level_transition_handler, network_event_delegate, self.statistics_db, game_mode_key, self.network_server)
	Managers.state.networked_flow_state = NetworkedFlowStateManager:new(world, is_server, network_event_delegate)

	GarbageLeakDetector.register_object(Managers.state.game_mode, "GameModeManager")
	GarbageLeakDetector.register_object(Managers.state.conflict, "ConflictDirector")

	local is_server = (self._lobby_host and true) or false
	local is_client = (self._lobby_client and true) or false
	Managers.state.camera = CameraManager:new(world)

	GarbageLeakDetector.register_object(Managers.state.camera, "CameraManager")

	local entity_manager = EntityManager2:new()
	Managers.state.entity = entity_manager
	local unit_templates = require("scripts/network/unit_extension_templates")

	local function extension_extractor_function(unit, unit_template_name)
		if not unit_template_name then
			local extensions = ScriptUnit.extension_definitions(unit)
			local num_extensions = #extensions

			return extensions, num_extensions
		end

		local is_network_unit = NetworkUnit.is_network_unit(unit)
		local is_husk = is_network_unit and NetworkUnit.is_husk_unit(unit)

		assert(is_server or is_client)

		local extensions, num_extensions = unit_templates.get_extensions(unit, unit_template_name, is_husk, is_server)

		return extensions, num_extensions
	end

	Managers.state.entity:set_extension_extractor_function(extension_extractor_function)

	self._debug_gui = World.create_screen_gui(world, "material", "materials/fonts/gw_fonts")
	self._debug_gui_immediate = World.create_screen_gui(world, "material", "materials/fonts/gw_fonts", "immediate")
	Managers.state.debug_text = DebugTextManager:new(world, self._debug_gui, is_server, network_event_delegate)
	Managers.state.performance = PerformanceManager:new(self._debug_gui_immediate, is_server, level_key)
	local voting_params = {
		level_transition_handler = self.level_transition_handler,
		network_event_delegate = network_event_delegate,
		is_server = self.is_server,
		input_manager = self.input_manager,
		network_server = self.network_server
	}
	Managers.state.voting = VoteManager:new(voting_params)
	self.dice_keeper = DiceKeeper:new(7)

	self.dice_keeper:register_rpcs(network_event_delegate)

	local unit_spawner = UnitSpawner:new(world, entity_manager, is_server)
	Managers.state.unit_spawner = unit_spawner

	unit_spawner:set_unit_template_lookup_table(unit_templates)

	local unit_storage = NetworkUnitStorage:new()
	Managers.state.unit_storage = unit_storage

	unit_spawner:set_unit_storage(unit_storage)

	local go_context = {
		world = world
	}
	local unit_go_sync_functions = require("scripts/network/game_object_initializers_extractors")

	unit_spawner:set_gameobject_initializer_data(unit_go_sync_functions.initializers, unit_go_sync_functions.extractors, go_context)
	unit_spawner:set_gameobject_to_unit_creator_function(unit_go_sync_functions.unit_from_gameobject_creator_func)

	self.free_flight_manager = Managers.free_flight

	self.free_flight_manager:register_input_manager(self.input_manager)

	self.network_timer_handler = NetworkTimerHandler:new(self.world, self.network_clock, self.is_server)

	self.network_timer_handler:register_rpcs(network_event_delegate)

	Managers.state.debug = DebugManager:new(world, self.free_flight_manager, self.input_manager, network_event_delegate, is_server)
	Managers.state.spawn = SpawnManager:new(world, is_server, network_event_delegate, unit_spawner, self.profile_synchronizer, self.network_server)
	local level_key = self.level_transition_handler:get_current_level_keys()

	if level_key == "inn_level" then
		local room_manager = nil

		if self.is_server then
			room_manager = RoomManagerServer:new(self.world)
		else
			room_manager = RoomManagerClient:new(self.world, network_event_delegate)
		end

		Managers.state.room = room_manager
	end

	local network_manager_post_init_data = {
		profile_synchronizer = self.profile_synchronizer,
		game_mode = Managers.state.game_mode,
		networked_flow_state = Managers.state.networked_flow_state,
		room_manager = Managers.state.room,
		spawn_manager = Managers.state.spawn,
		network_clock = self.network_clock,
		player_manager = Managers.player,
		network_transmit = self.network_transmit,
		network_server = self.network_server,
		statistics_db = self.statistics_db,
		difficulty_manager = Managers.state.difficulty,
		matchmaking_manager = Managers.matchmaking,
		voting_manager = Managers.state.voting
	}

	network_manager:post_init(network_manager_post_init_data)

	self.entity_system_bag = EntitySystemBag:new()
	local entity_systems_init_context = {
		entity_manager = entity_manager,
		input_manager = self.input_manager,
		unit_spawner = unit_spawner,
		world = self.world,
		startup_data = {
			level_key = level_key
		},
		is_server = is_server,
		free_flight_manager = self.free_flight_manager,
		network_event_delegate = network_event_delegate,
		unit_storage = unit_storage,
		entity_system_bag = self.entity_system_bag,
		network_clock = self.network_clock,
		network_manager = Managers.state.network,
		network_lobby = self._lobby_host or self._lobby_client,
		network_transmit = self.network_transmit,
		network_server = self.network_server,
		profile_synchronizer = self.profile_synchronizer,
		dice_keeper = self.dice_keeper,
		system_api = {},
		statistics_db = self.statistics_db,
		num_local_human_players = self.num_local_human_players
	}
	local entity_system = EntitySystem:new(entity_systems_init_context)

	GarbageLeakDetector.register_object(entity_system, "EntitySystem")
	GarbageLeakDetector.register_object(entity_systems_init_context, "entity_systems_init_context")
	GarbageLeakDetector.register_object(entity_systems_init_context.system_api, "system_api")

	self.entity_system = entity_system

	Managers.player:set_is_server(is_server, network_event_delegate, Managers.state.network)
	Managers.state.network:set_entity_system(entity_system)
	Managers.state.network:set_unit_storage(unit_storage)
	Managers.state.network:set_unit_spawner(unit_spawner)

	Managers.state.bot_nav_transition = BotNavTransitionManager:new(self.world, is_server, network_event_delegate)
	Managers.state.achievement = AchievementManager:new(self.world, self.statistics_db)
	Managers.state.blood = BloodManager:new(self.world)
end

StateIngame.rpc_kick_peer = function (self)
	if not self.is_server then
		self.kicked_by_server = true
	end
end

StateIngame.event_play_particle_effect = function (self, effect_name, unit, node, offset, rotation_offset, linked)
	if linked then
		ScriptWorld.create_particles_linked(self.world, effect_name, unit, node, "destroy", Matrix4x4.from_quaternion_position(rotation_offset, offset))
	else
		local pos, rot = nil

		if unit then
			pos = Unit.world_position(unit, node)
			rot = Unit.world_rotation(unit, node)
		else
			pos = Vector3(0, 0, 0)
			rot = Quaternion.identity()
		end

		local global_transform = Matrix4x4.from_quaternion_position(rot, pos)
		local local_transform = Matrix4x4.from_quaternion_position(rotation_offset, offset)
		local transform = Matrix4x4.multiply(local_transform, global_transform)

		World.create_particles(self.world, effect_name, Matrix4x4.translation(transform), Matrix4x4.rotation(transform))
	end
end

return
