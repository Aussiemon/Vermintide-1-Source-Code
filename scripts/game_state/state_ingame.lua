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
require("scripts/managers/input/input_manager2")
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

StateIngame = class(StateIngame)
StateIngame.NAME = "StateIngame"
StateIngame.on_enter = function (self)
	if Application.platform() == "xb1" then
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

	local input_manager = InputManager2:new()
	self.input_manager = input_manager
	Managers.input = self.input_manager

	input_manager.initialize_device(input_manager, "keyboard")
	input_manager.initialize_device(input_manager, "mouse")
	input_manager.initialize_device(input_manager, "gamepad")

	if script_data.debug_enabled then
		input_manager.create_input_service(input_manager, "Debug", DebugKeymap)
		input_manager.map_device_to_service(input_manager, "Debug", "keyboard")
		input_manager.map_device_to_service(input_manager, "Debug", "mouse")
		input_manager.map_device_to_service(input_manager, "Debug", "gamepad")
		input_manager.create_input_service(input_manager, "DebugMenu", DebugKeymap)
		input_manager.map_device_to_service(input_manager, "DebugMenu", "keyboard")
		input_manager.map_device_to_service(input_manager, "DebugMenu", "mouse")
		input_manager.map_device_to_service(input_manager, "DebugMenu", "gamepad")

		if Application.platform() == "win32" and (Application.build() == "dev" or Application.build() == "debug") then
			input_manager.initialize_device(input_manager, "synergy_keyboard")
			input_manager.initialize_device(input_manager, "synergy_mouse")
			input_manager.map_device_to_service(input_manager, "Debug", "synergy_keyboard")
			input_manager.map_device_to_service(input_manager, "Debug", "synergy_mouse")
			input_manager.map_device_to_service(input_manager, "DebugMenu", "synergy_keyboard")
			input_manager.map_device_to_service(input_manager, "DebugMenu", "synergy_mouse")
		end
	end

	Profiler.stop()
	Managers.popup:set_input_manager(input_manager)

	self.level_transition_handler = loading_context.level_transition_handler
	local level_key = self.level_transition_handler:get_current_level_keys()
	self.level_key = level_key
	self.is_in_inn = level_key == "inn_level"

	Managers.light_fx:set_lightfx_color_scheme((self.is_in_inn and "inn_level") or "ingame")

	if loading_context.statistics_db then
		self.statistics_db = loading_context.statistics_db

		if not self.is_in_inn then
			self.statistics_db:reset_session_stats()
		end
	else
		self.statistics_db = StatisticsDatabase:new()
		loading_context.statistics_db = self.statistics_db
	end

	Managers.player:set_statistics_db(self.statistics_db)

	self._max_local_players = PlayerManager.MAX_PLAYERS

	if self.is_server then
		local lobby_data = self._lobby_host:get_stored_lobby_data()
		lobby_data.selected_level_key = self.level_key

		self._lobby_host:set_lobby_data(lobby_data)
	end

	self.world_name = "level_world"

	self._setup_world(self)

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

		print("[StateIngame] Server ingame")
	elseif self.network_client then
		print("[StateIngame] Client ingame")

		self.network_transmit = loading_context.network_transmit or NetworkTransmit:new(is_server, self.network_client.connection_handler)

		self.network_client:register_rpcs(network_event_delegate, self.network_transmit)

		self.profile_synchronizer = self.network_client.profile_synchronizer
	end

	self.network_transmit:set_network_event_delegate(network_event_delegate)
	network_event_delegate.register(network_event_delegate, self, "rpc_kick_peer")
	self.statistics_db:register_network_event_delegate(network_event_delegate)

	loading_context.network_transmit = self.network_transmit

	Profiler.stop()
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

	Profiler.stop()

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
	self._setup_state_context(self, world, is_server, network_event_delegate)
	self.level_transition_handler:register_rpcs(network_event_delegate)

	Managers.state.quest = QuestManager:new(self.statistics_db, level_key)

	if GameSettingsDevelopment.use_telemetry then
		local level_name = LevelSettings[level_key].level_name
		local difficulty = Managers.state.difficulty:get_difficulty()
		local content_revision = script_data.settings.content_revision
		local engine_revision = script_data.build_identifier

		self._add_session_started_telemetry(self, level_key, level_name, difficulty, content_revision, engine_revision, is_server)
		Managers.telemetry:register_network_event_delegate(network_event_delegate)
	end

	local event_manager = Managers.state.event

	event_manager.register(event_manager, self, "event_play_particle_effect", "event_play_particle_effect", "event_start_network_timer", "event_start_network_timer", "xbox_one_hack_start_game", "event_xbox_one_hack_start_game")

	local level = self._create_level(self)
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
			Managers.state.conflict.level_analysis:set_random_seed(checkpoint_data)
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

	Profiler.stop()
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

		self.machines[i] = StateMachine:new(self, StateInGameRunning, params, true)
	end

	Profiler.stop()

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

	Profiler.stop()

	local platform = Application.platform()

	if platform == "ps4" then
		if self.is_in_inn then
			Managers.account:set_presence("inn")
		else
			local level_display_name = LevelSettings[self.level_key].display_name

			Managers.account:set_presence("playing", level_display_name)
		end
	end

	if platform == "win32" then
		Window.set_mouse_focus(true)
	end

	Network.write_dump_tag("start of game")

	local network_manager = Managers.state.network
	local network_game = network_manager.game(network_manager)
	local is_spawn_owner = self._lobby_host and network_game

	if is_spawn_owner or LEVEL_EDITOR_TEST then
		Managers.state.conflict:ai_ready()

		local volume_system = Managers.state.entity:system("volume_system")

		volume_system.ai_ready(volume_system)
	end

	if self.is_server and checkpoint_data then
		Managers.state.entity:system("pickup_system"):populate_pickups(checkpoint_data.pickup)
	elseif self.is_server then
		Managers.state.entity:system("pickup_system"):populate_pickups()
	end

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

	if Application.platform() == "win32" then
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

	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local my_peer_id = self.network_transmit.peer_id
		local player = player_manager.player_from_peer_id(player_manager, my_peer_id)
		local telemetry_id = player.telemetry_id(player)

		self._add_session_joined_telemetry(self, telemetry_id)

		local fullscreen = Application.user_setting("fullscreen")
		local borderless_fullscreen = Application.user_setting("borderless_fullscreen")
		local windowed = not fullscreen and not borderless_fullscreen
		local screen_mode = (fullscreen and "fullscreen") or (borderless_fullscreen and "borderless_fullscreen") or (windowed and "windowed")
		local res_x, res_y = Application.resolution()
		local resolution_string = string.format("%dx%d", res_x, res_y)
		local graphics_quality = Application.user_setting("graphics_quality")

		self._add_settings_telemetry(self, resolution_string, graphics_quality, screen_mode, telemetry_id)

		local system_info = Application.sysinfo()
		local adapter_index = Application.user_setting("adapter_index")

		self._add_system_info_telemetry(self, system_info, adapter_index, telemetry_id)
	end

	return 
end
StateIngame.event_xbox_one_hack_start_game = function (self, level_key, difficulty)
	print(level_key, difficulty)
	Managers.state.difficulty:set_difficulty(difficulty)
	self.level_transition_handler:set_next_level(level_key)
	Managers.state.game_mode:complete_level()

	return 
end
StateIngame.cb_save_data = function (self)
	print("saved data")

	return 
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

		return 
	end)
	Managers.world:set_scene_update_callback(self.world, function ()
		Profiler.start("Scene update Callback")
		self:physics_async_update(self.dt)
		Profiler.stop("Scene update Callback")

		return 
	end)

	if Managers.splitscreen then
		Managers.splitscreen:add_splitscreen_viewport(self.world)
	end

	return 
end
StateIngame.physics_async_update = function (self, dt)
	local game_mode_ended = Managers.state.game_mode:is_game_mode_ended()
	local network_manager = Managers.state.network
	local t = Managers.time:time("game")

	Profiler.start("Music manager")
	Managers.music:update(self.dt, t)
	Profiler.stop()

	if not network_manager.has_left_game(network_manager) then
		if game_mode_ended and self.game_mode_end_timer and self.game_mode_end_timer <= t then
		else
			self.entity_system:physics_async_update()
		end
	end

	return 
end
StateIngame.shading_callback = function (self, world, shading_env, viewport)
	Managers.state.camera:shading_callback(world, shading_env, viewport)

	return 
end
StateIngame._teardown_level = function (self)
	World.destroy_level(self.world, self.level)

	return 
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

	return 
end
StateIngame.spawn_unit = function (self, unit, ...)
	if not Managers.state.entity then
		printf("Unit %s is spawned after level destroy?", tostring(unit))

		return 
	end

	Managers.state.entity:register_unit(self.world, unit, ...)

	return 
end
StateIngame.unspawn_unit = function (self, unit)
	if not Managers.state.entity then
		printf("Unit %s has not been destroyed by entity manager or level destroy", tostring(unit))

		return 
	end

	Unit.flow_event(unit, "unit_despawned")
	Managers.state.entity:unregister_unit(unit)

	return 
end
StateIngame._create_level = function (self)
	Profiler.start("create_level")

	local level_key = self.level_transition_handler:get_current_level_keys()
	local level_name = LevelSettings[level_key].level_name
	local game_mode_manager = Managers.state.game_mode
	local game_mode_object_sets = game_mode_manager.object_sets(game_mode_manager)
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
	game_mode_manager.register_object_sets(game_mode_manager, object_sets)
	Level.spawn_background(level)
	Profiler.stop()

	return level
end
script_data.disable_ui = script_data.disable_ui or Development.parameter("disable_ui")
StateIngame.pre_update = function (self, dt)
	local t = Managers.time:time("game")
	local network_manager = Managers.state.network

	UPDATE_POSITION_LOOKUP()
	UPDATE_PLAYER_LISTS()
	network_manager.update_receive(network_manager, dt)
	Profiler.start("Network Client/Server update")

	if self.network_server then
		self.network_server:update(dt)
	end

	if self.network_client then
		self.network_client:update(dt)
	end

	Profiler.stop()
	Profiler.start("spawn")
	Managers.state.spawn:update(dt, t)
	Profiler.stop()
	self.entity_system:commit_and_remove_pending_units()

	local game_mode_ended = Managers.state.game_mode:is_game_mode_ended()

	if not network_manager.has_left_game(network_manager) then
		if game_mode_ended and self.game_mode_end_timer and self.game_mode_end_timer <= t then
		else
			self.entity_system:pre_update(dt, t)
		end
	end

	return 
end
local knoywloke = nil
StateIngame.update = function (self, dt, main_t)
	Vault.reseed()

	if Application.plocmova() and not knoywloke then
		local snlwpz = {
			steam_id = Steam.user_id()
		}

		Managers.telemetry:register_event("rat_monger", snlwpz)
		ScriptApplication.send_to_crashify("StateInGame", "rat_monger")

		knoywloke = true
	end

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
	Profiler.stop()
	Profiler.start("input_manager")
	self.input_manager:update(dt, main_t)
	Profiler.stop()
	Profiler.start("free flight")

	local debug_input_service = self.input_manager:get_service("DebugMenu")

	self.free_flight_manager:update(dt)
	Profiler.stop()
	Profiler.start("level_transition_handler")
	self.level_transition_handler:update()
	Profiler.stop()

	local t = Managers.time:time("game")

	Profiler.start("Ducking handler")
	self._ducking_handler:update(dt)
	Profiler.stop()
	Profiler.start("Lobby Update")

	if self._lobby_host then
		self._lobby_host:update(dt)
	end

	if self._lobby_client then
		self._lobby_client:update(dt)
	end

	Profiler.stop()
	Profiler.start("voting")
	Managers.state.voting:update(dt, t)
	Profiler.stop()
	Profiler.start("matchmaking")
	Managers.matchmaking:update(dt, main_t)
	Profiler.stop()
	Profiler.start("achievement")
	Managers.state.achievement:update(dt, t)
	Profiler.stop()

	if GameSettingsDevelopment.backend_settings.quests_enabled then
		Profiler.start("quest")
		Managers.state.quest:update(self.statistics_db, dt, t)
		Profiler.stop()
	end

	Managers.state.blood:update(dt, t)

	if is_server then
		Managers.state.conflict:reset_data()

		if self._lobby_host:is_joined() then
			local lobby_members = self._lobby_host:members()
			local members_joined = lobby_members.get_members_joined(lobby_members)
			local members_joined_n = #members_joined
			local members_left = lobby_members.get_members_left(lobby_members)
			local members_left_n = #members_left

			if members_joined_n ~= 0 or members_left_n ~= 0 then
				local lobby_data = self._lobby_host:get_stored_lobby_data()
				local members = lobby_members.get_members(lobby_members)
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
		machine.update(machine, dt, t)
	end

	local game_mode_ended = Managers.state.game_mode:is_game_mode_ended()

	if not game_mode_ended and self.game_mode_end_timer then
		self.game_mode_end_timer = nil
	end

	if game_mode_ended and not self.game_mode_end_timer then
		self.game_mode_end_timer = t + 0.2
	end

	local network_manager = Managers.state.network

	if not network_manager.has_left_game(network_manager) then
		if game_mode_ended and self.game_mode_end_timer <= t then
		else
			self.entity_system:update(dt, t)
		end
	end

	if is_server then
		Profiler.start("Game Mode Server")
		Managers.state.game_mode:server_update(dt, t)
		Profiler.stop()
	end

	local new_state = self._check_exit(self, t)

	if new_state then
		if self.parent.loading_context.restart_network then
			self.leave_lobby = true
		end

		return new_state
	end

	Managers.state.bot_nav_transition:update(dt, t)

	if script_data.debug_enabled then
		Profiler.start("DebugUpdate")
		Managers.state.debug:update(dt, t)
		Managers.state.performance:update(dt, t)
		Debug.update(t, dt)
		VisualAssertLog.update(dt)
		DebugScreen.update(dt, t, debug_input_service, self.input_manager)
		DebugKeyHandler.render()
		DebugKeyHandler.frame_clear()
		FunctionCallProfiler.render()
		PoolTableVisualizer.render(t)
		Profiler.stop()
	end

	VALIDATE_POSITION_LOOKUP()

	return 
end
local CONNECTION_TIMEOUT = 1
StateIngame.connected_to_network = function (self, t)
	if Development.parameter("use_lan_backend") then
		return true
	end

	local connected_to_network = true

	if Application.platform() == "win32" and rawget(_G, "Steam") then
		connected_to_network = Steam.connected()
	end

	if connected_to_network then
		self.last_connected_to_network_at = t
	end

	if not connected_to_network and self.last_connected_to_network_at + CONNECTION_TIMEOUT < t then
		return false
	end

	return true
end
StateIngame.cb_transition_fade_in_done = function (self, new_state)
	self._new_state = new_state

	return 
end
StateIngame.event_start_network_timer = function (self, time)
	self.network_timer_handler:start_timer_server(time)

	return 
end
StateIngame._check_exit = function (self, t)
	local network_manager = Managers.state.network
	local lobby = self._lobby_host or self._lobby_client
	local backend_manager = Managers.backend
	local waiting_user_input = backend_manager.is_waiting_for_user_input(backend_manager) or ScriptBackendItem.get_rerolling_trait_state()
	local waiting_for_item_poll = ScriptBackendItem.num_current_item_server_requests() ~= 0 or UISettings.waiting_for_response
	local connected_to_network = self.connected_to_network(self, t)

	if not self.exit_type and not waiting_user_input and not waiting_for_item_poll then
		local transition, join_lobby_data = nil

		for _, machine in pairs(self.machines) do
			transition, join_lobby_data = machine.state(machine):wanted_transition()
		end

		if script_data.hammer_join and 5 < Managers.time:time("game") then
			transition = "restart_game"

			Development.set_parameter("auto_join", true)
		end

		local level_transition_type = self.level_transition_handler.transition_type

		if Managers.backend:is_disconnected() then
			self.exit_type = "backend_disconnected"

			if network_manager.in_game_session(network_manager) then
				local force_diconnect = true

				network_manager.leave_game(network_manager, force_diconnect)
			end
		elseif Application.platform() == "xb1" and Managers.account:leaving_game() then
			self.exit_type = "profile_disconnected"

			if network_manager.in_game_session(network_manager) then
				local force_diconnect = true

				network_manager.leave_game(network_manager, force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
		elseif self.network_client and self.network_client.state == "denied_enter_game" then
			if self.network_client.host_to_migrate_to == nil then
				self.exit_type = "join_lobby_failed"
			else
				self.exit_type = "perform_host_migration"
			end

			if network_manager.in_game_session(network_manager) then
				local force_diconnect = true

				network_manager.leave_game(network_manager, force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
		elseif (lobby and lobby.state == LobbyState.FAILED) or (self.network_client and self.network_client.state == "lost_connection_to_host") then
			if self.network_client == nil or self.network_client.host_to_migrate_to == nil then
				self.exit_type = "lobby_state_failed"
			else
				self.exit_type = "perform_host_migration"
			end

			if network_manager.in_game_session(network_manager) then
				local force_diconnect = true

				network_manager.leave_game(network_manager, force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
		elseif not connected_to_network then
			self.exit_type = "lobby_state_failed"

			if network_manager.in_game_session(network_manager) then
				local force_diconnect = true

				network_manager.leave_game(network_manager, force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
		elseif self.kicked_by_server then
			self.kicked_by_server = nil
			self.exit_type = "kicked_by_server"

			if self._lobby_client and self._lobby_client.state == LobbyState.JOINED then
				local lobby_id = self._lobby_client:id()

				Managers.matchmaking:add_broken_lobby(lobby_id, t, true)
			end

			if network_manager.in_game_session(network_manager) then
				local force_diconnect = true

				network_manager.leave_game(network_manager, force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
		elseif level_transition_type == "reload_level" then
			self.exit_type = "reload_level"

			if self.is_server then
				network_manager.network_transmit:send_rpc_clients("rpc_reload_level")
				network_manager.leave_game(network_manager)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
		elseif level_transition_type then
			self.exit_type = "load_next_level"

			printf("Transition type %q, is server: %s", tostring(level_transition_type), tostring(self.is_server))

			if self.is_server then
				local level_to_transition_to = self.level_transition_handler:get_current_transition_level()

				self.network_server:set_current_level(level_to_transition_to)
				network_manager.network_transmit:send_rpc_clients("rpc_load_level", NetworkLookup.level_keys[level_to_transition_to], self.level_transition_handler.level_seed)
				network_manager.leave_game(network_manager)
			else
				self.network_client:set_wait_for_state_loading(true)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
		elseif transition == "leave_game" then
			self.exit_type = "left_game"

			if self.network_server then
				self.network_server:disconnect_all_peers("host_left_game")
			elseif self._lobby_client and self._lobby_client.state == LobbyState.JOINED then
				print("Leaving lobby, noting it as one I don't want to matchmake back into soon")

				local lobby_id = self._lobby_client:id()

				Managers.matchmaking:add_broken_lobby(lobby_id, t, true)
			end

			if network_manager.in_game_session(network_manager) then
				local force_diconnect = true

				network_manager.leave_game(network_manager, force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
		elseif transition == "afk_kick" then
			self.exit_type = "afk_kick"

			if network_manager.in_game_session(network_manager) then
				local force_diconnect = true

				network_manager.leave_game(network_manager, force_diconnect)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed, nil)
		elseif transition == "join_lobby" then
			self.exit_type = "join_game"

			if network_manager.in_game_session(network_manager) then
				network_manager.leave_game(network_manager)
			end

			self.parent.loading_context.join_lobby_data = join_lobby_data

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
		elseif transition == "start_lobby" then
			self.exit_type = "join_game"

			if network_manager.in_game_session(network_manager) then
				network_manager.leave_game(network_manager)
			end

			self.parent.loading_context.start_lobby_data = join_lobby_data

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
		elseif transition == "restart_game" then
			self.exit_type = "restart_game"

			if network_manager.in_game_session(network_manager) then
				network_manager.leave_game(network_manager)
			end

			Managers.transition:fade_in(GameSettings.transition_fade_in_speed)
		end

		if self.exit_type then
			self.exit_time = t + 2

			printf("StateIngame: Got transition %s, set exit type to %s. Will exit at t=%.2f", tostring(transition), self.exit_type, self.exit_time)

			local input_manager = self.input_manager

			input_manager.block_device_except_service(input_manager, nil, "keyboard", 1)
			input_manager.block_device_except_service(input_manager, nil, "mouse", 1)
			input_manager.block_device_except_service(input_manager, nil, "gamepad", 1)
			Managers.popup:cancel_all_popups()
			self.level_transition_handler:set_transition_exit_type(self.exit_type)
		end
	end

	local SESSION_LEAVE_TIMEOUT = 4

	if self.exit_time and self.exit_time <= t then
		local exit_type = self.exit_type

		if exit_type == "join_lobby_failed" or exit_type == "left_game" or exit_type == "lobby_state_failed" or exit_type == "kicked_by_server" or exit_type == "afk_kick" then
			local game = network_manager.game(network_manager)

			if game and self.exit_time + SESSION_LEAVE_TIMEOUT <= t then
				network_manager.force_disconnect_from_session(network_manager)
			elseif not game then
				printf("[StateIngame] Transition to StateLoadingRestartNetwork on %q", self.exit_type)
				self.level_transition_handler:set_next_level(self.level_transition_handler:default_level_key())

				if exit_type == "lobby_state_failed" and not self.is_server then
					self.parent.loading_context.previous_session_error = "lobby_disconnected"
				elseif exit_type == "kicked_by_server" then
					self.parent.loading_context.previous_session_error = "kicked_by_server"
				elseif exit_type == "join_lobby_failed" and self.network_client then
					self.parent.loading_context.previous_session_error = self.network_client.fail_reason
				elseif exit_type == "afk_kick" then
					self.parent.loading_context.previous_session_error = "afk_kick"
				end

				self.parent.loading_context.restart_network = true

				if exit_type == "lobby_state_failed" then
					return StateTitleScreen
				else
					return StateLoading
				end
			end
		elseif exit_type == "perform_host_migration" then
			local game = network_manager.game(network_manager)

			if game and self.exit_time + SESSION_LEAVE_TIMEOUT <= t then
				network_manager.force_disconnect_from_session(network_manager)
			elseif not game then
				self.parent.loading_context.host_to_migrate_to = self.network_client.host_to_migrate_to
				self.parent.loading_context.wanted_profile_index = self.wanted_profile_index(self)
				self.leave_lobby = true

				return StateLoading
			end
		elseif exit_type == "backend_disconnected" then
			local has_left = network_manager.has_left_game(network_manager)

			if not has_left and self.exit_time + SESSION_LEAVE_TIMEOUT <= t then
				network_manager.force_disconnect_from_session(network_manager)
			elseif has_left then
				printf("[StateIngame] Transition to StateTitleScreen on %q", self.exit_type)
				self.level_transition_handler:set_next_level(self.level_transition_handler:default_level_key())

				self.parent.loading_context.restart_network = true

				return StateTitleScreen
			end
		elseif exit_type == "profile_disconnected" then
			local has_left = network_manager.has_left_game(network_manager)

			if not has_left and self.exit_time + SESSION_LEAVE_TIMEOUT <= t then
				network_manager.force_disconnect_from_session(network_manager)
			elseif has_left then
				printf("[StateIngame] Transition to StateTitleScreen on %q", self.exit_type)
				self.level_transition_handler:set_next_level(self.level_transition_handler:default_level_key())

				self.parent.loading_context.restart_network = true

				return StateTitleScreen
			end
		elseif exit_type == "load_next_level" or exit_type == "reload_level" then
			local game = network_manager.game(network_manager)

			if game and self.exit_time + SESSION_LEAVE_TIMEOUT <= t then
				network_manager.force_disconnect_from_session(network_manager)
			elseif not game then
				self.parent.loading_context.checkpoint_data = self.level_transition_handler.checkpoint_data
				self.parent.loading_context.lobby_host = self._lobby_host
				self.parent.loading_context.lobby_client = self._lobby_client
				self.parent.loading_context.matchmaking_loading_context = Managers.matchmaking:loading_context()
				self.parent.loading_context.wanted_profile_index = self.wanted_profile_index(self)

				return StateLoading
			end
		elseif exit_type == "join_game" then
			local game = network_manager.game(network_manager)

			if game and self.exit_time + SESSION_LEAVE_TIMEOUT <= t then
				network_manager.force_disconnect_from_session(network_manager)
			elseif not game then
				self.leave_lobby = true
				self.parent.loading_context.matchmaking_loading_context = Managers.matchmaking:loading_context()
				self.parent.loading_context.wanted_profile_index = self.wanted_profile_index(self)

				return StateLoading
			end
		elseif exit_type == "restart_game" then
			local game = network_manager.game(network_manager)

			if game and self.exit_time + SESSION_LEAVE_TIMEOUT <= t then
				network_manager.force_disconnect_from_session(network_manager)
			elseif not game then
				printf("[StateIngame] Transition to StateSplashScreen on %q", self.exit_type)

				self.leave_lobby = true
				self.release_level_resources = true
				self.parent.loading_context.restart_network = true
				self.parent.loading_context.reload_packages = true

				return StateSplashScreen
			end
		end
	end

	return 
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
			machine.post_update(machine, dt, t)
		end
	end

	Managers.state.game_mode:update_flow_object_set_enable(dt)

	local network_manager = Managers.state.network

	network_manager.network_transmit:transmit_local_rpcs()
	Managers.state.unit_spawner:update_death_watch_list(dt, t)
	self.entity_system:commit_and_remove_pending_units()
	Managers.state.spawn:post_unit_destroy_update()
	network_manager.update_transmit(network_manager, dt)

	return 
end
StateIngame.on_exit = function (self, application_shutdown)
	UPDATE_POSITION_LOOKUP()
	UPDATE_PLAYER_LISTS()

	if GameSettingsDevelopment.use_telemetry then
		self._check_and_add_end_game_telemetry(self, application_shutdown)

		local fov = Application.user_setting("render_settings", "fov")

		self._add_fov_telemetry(self, fov)
		Managers.telemetry:dispatch_events()
		Managers.telemetry:unregister_network_event_delegate()
	end

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
		machine.destroy(machine)
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

	unit_spawner.commit_and_remove_pending_units(unit_spawner)

	local world = self.world
	local unit_storage = Managers.state.unit_storage
	local units = unit_storage.units(unit_storage)

	for id, unit_to_destroy in pairs(units) do
		Managers.state.entity:unregister_unit(unit_to_destroy)
		World.destroy_unit(world, unit_to_destroy)
	end

	self.entity_system:destroy()
	self.entity_system_bag:destroy()
	Profiler.stop()
	ScriptBackendSession.leave()
	Managers.player:exit_ingame()
	self._teardown_level(self)
	Managers.state:destroy()
	VisualAssertLog.cleanup()
	self._teardown_world(self)
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

	if self.network_server then
		self.network_server:on_level_exit()
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

					return 
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
	else
		self.profile_synchronizer:unregister_network_events()
	end

	self.free_flight_manager:unregister_input_manager()

	self.free_flight_manager = nil
	self.parent = nil

	if rawget(_G, "Steam") then
	end

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

	Managers.transition:show_loading_icon()

	return 
end
local telemetry_data = {}
StateIngame._add_session_started_telemetry = function (self, level_key, level_name, difficulty, content_revision, engine_revision, is_server)
	table.clear(telemetry_data)

	telemetry_data.level_key = level_key
	telemetry_data.level_name = level_name
	telemetry_data.difficulty = difficulty
	telemetry_data.content_revision = content_revision
	telemetry_data.engine_revision = engine_revision

	Managers.telemetry:session_start(telemetry_data, is_server)

	return 
end
StateIngame._add_session_joined_telemetry = function (self, player_id)
	table.clear(telemetry_data)

	telemetry_data.player_id = player_id
	local join_type = nil

	if rawget(_G, "Steam") and rawget(_G, "Friends") then
		local invite_type = Friends.boot_invite()

		if invite_type == Friends.INVITE_LOBBY then
			join_type = "invite_lobby"
		elseif invite_type == Friends.INVITE_SERVER then
			join_type = "invite_server"
		end
	end

	telemetry_data.join_type = join_type

	Managers.telemetry:register_event("session_joined", telemetry_data)

	return 
end
StateIngame._add_fov_telemetry = function (self, fov)
	local player_manager = Managers.player
	local player = player_manager.player_from_peer_id(player_manager, self.peer_id)
	local telemetry_id = player.telemetry_id(player)
	local hero = player.profile_display_name(player)

	table.clear(telemetry_data)

	telemetry_data.fov = fov
	telemetry_data.player_id = telemetry_id
	telemetry_data.hero = hero

	Managers.telemetry:register_event("tech_fov", telemetry_data)

	return 
end
StateIngame._add_settings_telemetry = function (self, resolution, graphics_quality, screen_mode, player_id)
	table.clear(telemetry_data)

	telemetry_data.resolution = resolution
	telemetry_data.graphics_quality = graphics_quality
	telemetry_data.screen_mode = screen_mode
	telemetry_data.player_id = player_id

	Managers.telemetry:register_event("tech_settings", telemetry_data)

	return 
end
local NEWLINE_PATTERN = "(.-)\n"
local FEATURE_BITS_PATTERN = "[^\n]+:\n"
local SUB_COMPONENT_PATTERN = "(.-)(,%s)"
local COMPONENT_PATTERN = "(.-)(:%s)"

local function string_splitter_cpu(text_string, data)
	text_string = string.gsub(text_string, FEATURE_BITS_PATTERN, "")
	local lines = {}

	for current_line in string.gmatch(text_string, NEWLINE_PATTERN) do
		if current_line ~= "" then
			lines[#lines + 1] = current_line
		end
	end

	local sub_components = {}
	local num_lines = #lines

	for line_index = 1, num_lines, 1 do
		local current_line = lines[line_index]
		current_line = string.format("%s, ", current_line)

		for sub_component in string.gmatch(current_line, SUB_COMPONENT_PATTERN) do
			sub_components[#sub_components + 1] = sub_component
		end
	end

	local components = {}
	local num_subcomponents = #sub_components

	for subcomponent_index = 1, num_subcomponents, 1 do
		local current_subcomponent = sub_components[subcomponent_index]
		current_subcomponent = string.format("%s: ", current_subcomponent)

		for current_component in string.gmatch(current_subcomponent, COMPONENT_PATTERN) do
			components[#components + 1] = current_component
		end
	end

	local num_components = #components

	if 1 < num_components then
		for component_index = 1, num_components - 1, 2 do
			local entry_name = string.format("CPU - %s", components[component_index])
			local entry_data = components[component_index + 1]
			data[entry_name] = entry_data
		end
	end

	return 
end

local OS_SYSTEM_INFO_VERSION_INDEX = 1
local OS_SYSTEM_INFO_BITS_INDEX = 2

local function string_splitter_os(text_string, data)
	local lines = {}

	for current_line in string.gmatch(text_string, NEWLINE_PATTERN) do
		if current_line ~= "" then
			lines[#lines + 1] = current_line
		end
	end

	local num_lines = #lines

	if 1 < num_lines then
		local os_info_line = lines[1]
		os_info_line = string.format("%s, ", os_info_line)
		local os_info_index = 1

		for sub_info in string.gmatch(os_info_line, SUB_COMPONENT_PATTERN) do
			if os_info_index == OS_SYSTEM_INFO_VERSION_INDEX then
				data["OS - Tech"] = sub_info
				os_info_index = os_info_index + 1
			elseif os_info_index == OS_SYSTEM_INFO_BITS_INDEX then
				data["OS - Bits"] = sub_info
				os_info_index = os_info_index + 1
			else
				break
			end
		end

		local os_version_line = lines[2]
		data["OS - Version"] = os_version_line
	end

	return 
end

local function string_splitter_gpu(text_string, data, adapter_index)
	if not adapter_index then
		return 
	end

	local lines = {}

	for current_line in string.gmatch(text_string, NEWLINE_PATTERN) do
		if current_line ~= "" then
			lines[#lines + 1] = current_line
		end
	end

	local num_lines = #lines

	if 0 < num_lines and 0 < adapter_index and adapter_index < num_lines then
		local used_gpu_line = lines[adapter_index]
		used_gpu_line = string.format("%s: ", used_gpu_line)
		local components = {}

		for current_component in string.gmatch(used_gpu_line, COMPONENT_PATTERN) do
			components[#components + 1] = current_component
		end

		local num_components = #components

		if 1 < num_components then
			local gpu_category_name = components[1]
			local gpu_model_name = components[2]
			data[gpu_category_name] = gpu_model_name
		end
	end

	return 
end

local CPU_SYSTEM_INFO_INDEX = 1
local OS_SYSTEM_INFO_INDEX = 2
local GPU_SYSTEM_INFO_INDEX = 3

function system_information_text_splitter(input_string, graphics_adapter_index, data)
	if not data then
		return 
	end

	local category_pattern = "(.-)(%-%-%-%s[%w]*)"
	local appended_string = string.format("%s%s", input_string, "--- END")
	local category_table = {}

	for category_string in string.gmatch(appended_string, category_pattern) do
		if category_string ~= "" then
			category_table[#category_table + 1] = category_string
		end
	end

	local num_categories = #category_table

	for i = 1, num_categories, 1 do
		local category_string = category_table[i]

		if category_string.sub(category_string, -1) ~= "\n" then
			category_string = string.format("%s\n", category_string)
		end

		if i == CPU_SYSTEM_INFO_INDEX then
			string_splitter_cpu(category_string, data)
		elseif i == OS_SYSTEM_INFO_INDEX then
			string_splitter_os(category_string, data)
		elseif i == GPU_SYSTEM_INFO_INDEX then
			string_splitter_gpu(category_string, data, graphics_adapter_index)
		else
			break
		end
	end

	return 
end

StateIngame._add_system_info_telemetry = function (self, system_info, adapter_index, player_id)
	if not adapter_index then
		return 
	end

	table.clear(telemetry_data)

	adapter_index = adapter_index + 1

	system_information_text_splitter(system_info, adapter_index, telemetry_data)

	telemetry_data.player_id = player_id

	Managers.telemetry:register_event("tech_system", telemetry_data)

	return 
end
StateIngame._check_and_add_end_game_telemetry = function (self, application_shutdown)
	local reason = self.exit_type

	if application_shutdown then
		local controlled_exit = Boot:is_controlled_exit()

		if controlled_exit then
			reason = "controlled_exit"
		else
			reason = "forced_exit"
		end
	else
		level_related_reason = self.exit_type == "load_next_level" or self.exit_type == "reload_level"

		if level_related_reason then
			if Managers.state.game_mode:game_won() then
				reason = "won"
			elseif Managers.state.game_mode:game_lost() then
				reason = "lost"
			end

			if self.is_server then
				self._add_game_ended_telemetry_bots(self, reason)
			end
		end
	end

	self._add_game_ended_telemetry(self, reason)

	return 
end
StateIngame._add_game_ended_telemetry_bots = function (self, reason)
	assert(self.is_server, "Trying to log bot telemetry when not being server!")

	local player_manager = Managers.player
	local players = player_manager.human_and_bot_players(player_manager)

	table.clear(telemetry_data)

	telemetry_data.end_reason = reason

	for _, player in pairs(players) do
		if player.bot_player then
			local telemetry_id = player.telemetry_id(player)
			local hero = player.profile_display_name(player)
			telemetry_data.player_id = telemetry_id
			telemetry_data.hero = hero

			Managers.telemetry:register_event("game_ended", telemetry_data)
		end
	end

	return 
end
StateIngame._add_game_ended_telemetry = function (self, reason)
	local player_manager = Managers.player
	local player = player_manager.player_from_peer_id(player_manager, self.peer_id)
	local telemetry_id = player.telemetry_id(player)
	local hero = player.profile_display_name(player)

	table.clear(telemetry_data)

	telemetry_data.end_reason = reason
	telemetry_data.player_id = telemetry_id
	telemetry_data.hero = hero
	local telemetry_manager = Managers.telemetry

	telemetry_manager.register_event(telemetry_manager, "animal", {
		hippo = MODE.hippo or false,
		wildebeest = MODE.wildebeest or false,
		gnu = MODE.gnu or false
	})
	telemetry_manager.register_event(telemetry_manager, "game_ended", telemetry_data)

	return 
end
StateIngame._setup_state_context = function (self, world, is_server, network_event_delegate)
	local network_clock = nil

	if self.is_server then
		network_clock = NetworkClockServer:new()
	else
		network_clock = NetworkClockClient:new()
	end

	self.network_clock = network_clock

	network_clock.register_rpcs(network_clock, network_event_delegate)

	local network_manager = GameNetworkManager:new(world, self._lobby_host or self._lobby_client, is_server)
	Managers.state.network = network_manager

	network_manager.register_event_delegate(network_manager, network_event_delegate)

	local build = Application.build()

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
		game_mode_key = (level_game_mode and level_game_mode) or "adventure"
	end

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

	self._debug_gui = World.create_screen_gui(world, "material", "materials/fonts/arial")
	self._debug_gui_immediate = World.create_screen_gui(world, "material", "materials/fonts/arial", "immediate")
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

	unit_spawner.set_unit_template_lookup_table(unit_spawner, unit_templates)

	local unit_storage = NetworkUnitStorage:new()
	Managers.state.unit_storage = unit_storage

	unit_spawner.set_unit_storage(unit_spawner, unit_storage)

	local go_context = {
		world = world
	}
	local unit_go_sync_functions = require("scripts/network/game_object_initializers_extractors")

	unit_spawner.set_gameobject_initializer_data(unit_spawner, unit_go_sync_functions.initializers, unit_go_sync_functions.extractors, go_context)
	unit_spawner.set_gameobject_to_unit_creator_function(unit_spawner, unit_go_sync_functions.unit_from_gameobject_creator_func)

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

	network_manager.post_init(network_manager, network_manager_post_init_data)

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

	return 
end
StateIngame.rpc_kick_peer = function (self)
	self.kicked_by_server = true

	return 
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

	return 
end

return 
