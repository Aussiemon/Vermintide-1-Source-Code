require("scripts/ui/views/friends_view")
require("scripts/settings/experience_settings")
require("scripts/settings/area_settings")
require("scripts/ui/views/menu_input_description_ui")
require("scripts/ui/views/map_view_helper")
require("scripts/ui/views/map_view_area_handler")
require("scripts/ui/views/level_filter_ui")
require("scripts/ui/views/map_view_states/state_map_view_idle")
require("scripts/ui/views/map_view_states/state_map_view_start")
require("scripts/ui/views/map_view_states/state_map_view_overview")
require("scripts/ui/views/map_view_states/state_map_view_game_mode")
require("scripts/ui/views/map_view_states/state_map_view_select_area")
require("scripts/ui/views/map_view_states/state_map_view_select_level")
require("scripts/ui/views/map_view_states/state_map_view_select_difficulty")
require("scripts/ui/views/map_view_states/state_map_view_start")
require("scripts/ui/views/map_view_states/state_map_view_summary")

local definitions = local_require("scripts/ui/views/console_map_view_definitions")
local scenegraph_definition = definitions.scenegraph_definition
local widgets = definitions.widgets
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
local game_mode_changed_wwise_events = {
	adventure = {},
	survival = {
		"nik_survival_mode_01",
		"nik_survival_mode_02"
	}
}
local dialogue_speakers = {
	nik = "inn_keeper",
	nfl = "ferry_lady"
}
local telemetry_data = {}
ConsoleMapView = class(ConsoleMapView)

local function _add_map_press_play_telemetry(player, privacy_setting, level, difficulty, nr_level_switches)
	local telemetry_id = player.telemetry_id(player)
	local hero = player.profile_display_name(player)

	table.clear(telemetry_data)

	telemetry_data.player_id = telemetry_id
	telemetry_data.hero = hero
	telemetry_data.privacy_setting = privacy_setting
	telemetry_data.level = level
	telemetry_data.difficulty = difficulty
	telemetry_data.nr_level_switches = nr_level_switches

	Managers.telemetry:register_event("matchmaking_map_done", telemetry_data)

	return 
end

ConsoleMapView.init = function (self, ingame_ui_context)
	self.dialogue_system = ingame_ui_context.dialogue_system
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.camera_manager = ingame_ui_context.camera_manager
	self.level_transition_handler = ingame_ui_context.level_transition_handler
	self.is_in_inn = ingame_ui_context.is_in_inn
	self.wwise_world = ingame_ui_context.dialogue_system.wwise_world
	self.statistics_db = ingame_ui_context.statistics_db
	self.network_server = ingame_ui_context.network_server
	self.player_manager = ingame_ui_context.player_manager
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.popup_handler = self.ingame_ui.popup_handler
	self.is_server = ingame_ui_context.is_server
	self.network_lobby = ingame_ui_context.network_lobby
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.platform = Application.platform()
	local player = Managers.player:local_player()
	local player_stats_id = player.stats_id(player)
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager.create_input_service(input_manager, "map_menu", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "map_menu", "keyboard")
	input_manager.map_device_to_service(input_manager, "map_menu", "mouse")
	input_manager.map_device_to_service(input_manager, "map_menu", "gamepad")

	local network_manager = Managers.state.network
	local network_transmit = network_manager.network_transmit
	local server_peer_id = network_transmit.server_peer_id
	self.host_peer_id = server_peer_id or network_transmit.peer_id

	if not PlayerData.map_view_data then
		local map_save_data = {
			previous_info = {},
			viewed_levels = {}
		}
	end

	if not map_save_data.previous_info then
		map_save_data.previous_info = {}
	end

	if not map_save_data.viewed_levels then
		map_save_data.viewed_levels = {}
	end

	self.map_save_data = map_save_data
	self.map_view_helper = MapViewHelper:new(self.statistics_db, player_stats_id)
	self.map_view_area_handler = MapViewAreaHandler:new(ingame_ui_context, map_save_data, player_stats_id)

	self.map_view_area_handler:set_active_area("ubersreik")

	self.level_filter = LevelFilterUI:new(ingame_ui_context, map_save_data)
	local state_machine_params = {
		game_info = self.map_save_data,
		ingame_ui_context = ingame_ui_context,
		map_view_area_handler = self.map_view_area_handler,
		map_view_helper = self.map_view_helper,
		map_view = self,
		level_filter = self.level_filter
	}
	self._state_machine_params = state_machine_params

	self.create_ui_elements(self)

	return 
end
ConsoleMapView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._mask_widgets = {
		UIWidget.init(widgets.mask_layer),
		UIWidget.init(widgets.mask_layer_top),
		UIWidget.init(widgets.mask_layer_bottom)
	}
	self._time_line_bg_widget = UIWidget.init(widgets.time_line_bg)
	self._time_line_marker_widget = UIWidget.init(widgets.time_line_marker)
	self._time_line_marker_widget.style.texture_id.offset[3] = 1
	self.time_line_slot_widgets = {
		UIWidget.init(widgets.time_line_slot_1),
		UIWidget.init(widgets.time_line_slot_2),
		UIWidget.init(widgets.time_line_slot_3),
		UIWidget.init(widgets.time_line_slot_4)
	}

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
ConsoleMapView.set_friends_view = function (self, friends_view)
	self.friends = friends_view

	return 
end
ConsoleMapView._setup_state_machine = function (self, state_machine_params)
	if self._machine then
		self._machine:destroy()

		self._machine = nil
	end

	local start_state = StateMapViewStart
	local profiling_debugging_enabled = false
	self._machine = StateMachine:new(self, start_state, state_machine_params, profiling_debugging_enabled)
	self._state_machine_params = state_machine_params

	return 
end
ConsoleMapView.update = function (self, dt, t)
	if not self.menu_active or self.suspended then
		return 
	end

	local map_view_area_handler = self.map_view_area_handler
	local draw_intro_description = self.draw_intro_description
	local transitioning = self.transitioning(self)
	local friends = self.friends
	local friends_menu_active = friends.is_active(friends)
	local input_manager = self.input_manager
	local input_service = ((transitioning or friends_menu_active) and fake_input_service) or input_manager.get_service(input_manager, "map_menu")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local is_sub_menu = true

	friends.update(friends, dt, t, is_sub_menu)

	if self._xbox_trying_to_open_invite_friends then
		self._update_invite_friends(self)
	end

	if self.popup_id then
		local popup_result = Managers.popup:query_result(self.popup_id)

		if popup_result then
			self.handle_popup_result(self, popup_result)
		end
	end

	if not transitioning then
		map_view_area_handler.update(map_view_area_handler, nil, dt)
	end

	if self.wwise_playing_id and not WwiseWorld.is_playing(self.wwise_world, self.wwise_playing_id) then
		local subtitle_gui = self.ingame_ui.ingame_hud.subtitle_gui

		subtitle_gui.stop_subtitle(subtitle_gui, self.dialogue_speaker)

		self.wwise_playing_id = nil
		self.dialogue_speaker = nil
		self.playing_wwise_event = nil
	end

	if self.active then
		self.draw(self, dt)
		self._machine:update(dt, t)
	end

	return 
end
ConsoleMapView.animate_title_text = function (self, widget, out)
	local target = widget.style.text.text_color
	local target_index = 1
	local from = (out and 255) or 0
	local to = (not out or 0) and 255
	local anim_time = 0.5

	table.clear(widget.animations)

	local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, math.easeCubic)

	UIWidget.animate(widget, animation)

	return 
end

local function animate_widget(widget)
	local target = widget.style.texture_id.color
	local target_index = 1
	local from = 0
	local to = 255
	local anim_time = 0.3

	table.clear(widget.animations)

	local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, math.easeCubic)

	UIWidget.animate(widget, animation)

	return 
end

ConsoleMapView.set_mask_enabled = function (self, enabled)
	self._draw_mask = enabled

	return 
end
ConsoleMapView.set_time_line_index = function (self, index)
	if index then
		if not self.draw_time_line_index then
			for index, widget in ipairs(self.time_line_slot_widgets) do
				animate_widget(widget)
			end

			animate_widget(self._time_line_bg_widget)
			animate_widget(self._time_line_marker_widget)
		end

		self._time_line_marker_widget.scenegraph_id = "time_line_slot_" .. index
	end

	self.draw_time_line_index = index

	return 
end
ConsoleMapView.draw = function (self, dt)
	local draw_time_line_index = self.draw_time_line_index
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	if self._draw_mask then
		for index, widget in ipairs(self._mask_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	if draw_time_line_index then
		UIRenderer.draw_widget(ui_renderer, self._time_line_bg_widget)
		UIRenderer.draw_widget(ui_renderer, self._time_line_marker_widget)

		for index, widget in ipairs(self.time_line_slot_widgets) do
			if index < draw_time_line_index then
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
ConsoleMapView.save_map_settings = function (self)
	PlayerData.map_view_data = self.map_save_data

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "on_save_ended_callback"))

	return 
end
ConsoleMapView.on_save_ended_callback = function (self)
	print("[ConsoleMapView] - settings saved")

	return 
end
ConsoleMapView.event_enable_level_select = function (self)
	self.observer_only = not Managers.player.is_server
	local player = Managers.player:local_player()

	if player then
		self.ingame_ui:set_map_active_state(true)
	end

	return 
end
ConsoleMapView.on_exit = function (self)
	self.save_map_settings(self)
	self.play_sound(self, "Play_hud_map_close")

	self.active = nil
	self.exiting = nil
	self.menu_active = nil

	if self._machine then
		self._machine:destroy()

		self._machine = nil
	end

	return 
end
ConsoleMapView.suspend = function (self)
	self.suspended = true

	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)

	return 
end
ConsoleMapView.unsuspend = function (self)
	self.suspended = nil

	self.input_manager:block_device_except_service("map_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("map_menu", "mouse", 1)
	self.input_manager:block_device_except_service("map_menu", "gamepad", 1)

	return 
end
ConsoleMapView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	return 
end
ConsoleMapView.input_service = function (self)
	local friends = self.friends
	local friends_menu_active = friends.is_active(friends)

	return (friends_menu_active and friends.input_service(friends)) or self.input_manager:get_service("map_menu")
end
ConsoleMapView.destroy = function (self)
	self.ui_animator = nil
	self.friends = nil

	if self.popup_id then
		Managers.popup:cancel_popup(self.popup_id)
	end

	GarbageLeakDetector.register_object(self, "ConsoleMapView")

	self.interaction_map_unit = nil

	if self._machine then
		self._machine:destroy()

		self._machine = nil
	end

	return 
end
ConsoleMapView.exit = function (self, return_to_game)
	local friends_menu_active = self.friends:is_active()

	if friends_menu_active then
		self.deactivate_friends_menu(self)
	end

	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)

	self.exiting = true

	return 
end
ConsoleMapView.on_enter = function (self)
	local input_manager = self.input_manager

	input_manager.block_device_except_service(input_manager, "map_menu", "keyboard", 1)
	input_manager.block_device_except_service(input_manager, "map_menu", "mouse", 1)
	input_manager.block_device_except_service(input_manager, "map_menu", "gamepad", 1)
	self.play_sound(self, "Play_hud_map_open")

	self.menu_active = true
	self.active = true
	local params = self._state_machine_params
	params.initial_state = true

	self._setup_state_machine(self, self._state_machine_params)

	return 
end
ConsoleMapView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
ConsoleMapView.set_map_interaction_state = function (self, enabled)
	if not self.interaction_map_unit then
		self.interaction_map_unit = self.get_map_unit(self)
	end

	local map_unit = self.interaction_map_unit

	if map_unit then
		Unit.set_data(map_unit, "interaction_data", "active", enabled)

		self.map_interaction_enabled = enabled

		if not enabled and self.menu_active then
			local return_to_game = true

			self.exit(self, return_to_game)
		end
	end

	return 
end
ConsoleMapView.get_map_unit = function (self)
	local world_manager = Managers.world

	if world_manager.has_world(world_manager, "level_world") then
		local map_unit = nil
		local world = world_manager.world(world_manager, "level_world")
		local level_name = "levels/inn/world"
		local level = ScriptWorld.level(world, level_name)

		if level then
			local units = Level.units(level)

			for i, level_unit in ipairs(units) do
				if Unit.has_data(level_unit, "interaction_map") then
					return level_unit
				end
			end
		end
	end

	return 
end
ConsoleMapView.wanted_gamepad_state = function (self)
	return self._new_gamepad_state
end
ConsoleMapView.clear_wanted_gamepad_state = function (self)
	self._new_gamepad_state = nil

	return 
end
ConsoleMapView.show_selected_player_gamercard = function (self, peer_id)
	if peer_id then
		local platform = self.platform

		if platform == "win32" and rawget(_G, "Steam") then
			local id = Steam.id_hex_to_dec(peer_id)
			local url = "http://steamcommunity.com/profiles/" .. id

			Steam.open_url(url)
		elseif platform == "xb1" then
			local xuid = self.network_lobby.lobby:xuid(peer_id)

			if xuid then
				XboxLive.show_gamercard(Managers.account:user_id(), xuid)
			end
		elseif platform == "ps4" then
			local np_id = self.network_lobby.lobby:np_id_from_peer_id(peer_id)

			Managers.account:show_player_profile_with_np_id(np_id)
		end
	end

	return 
end
ConsoleMapView.request_kick_player = function (self, peer_id, cb)
	if not self.popup_id then
		self.kick_player_peer_id = peer_id
		self.kick_player_callback = cb
		local text = Localize("kick_player_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("popup_kick_player_topic"), "kick_player", Localize("popup_choice_yes"), "cancel_popup", Localize("popup_choice_no"))
	end

	return 
end
ConsoleMapView.kick_player = function (self, peer_id)
	local network_server = self.network_server

	network_server.kick_peer(network_server, peer_id)

	return 
end
ConsoleMapView.handle_popup_result = function (self, popup_result)
	if popup_result == "kick_player" then
		self.popup_id = nil

		self.kick_player(self, self.kick_player_peer_id)
		self.kick_player_callback()

		self.kick_player_callback = nil
		self.kick_player_peer_id = nil
	elseif popup_result == "cancel_popup" then
		self.popup_id = nil
		self.kick_player_peer_id = nil
		self.kick_player_callback = nil
		local input_manager = self.input_manager

		input_manager.block_device_except_service(input_manager, "map_menu", "keyboard")
		input_manager.block_device_except_service(input_manager, "map_menu", "mouse")
		input_manager.block_device_except_service(input_manager, "map_menu", "gamepad")
	end

	return 
end
ConsoleMapView._update_invite_friends = function (self)
	local session_id = Managers.matchmaking.lobby:session_id()
	local status = MultiplayerSession.status(session_id)

	if status ~= MultiplayerSession.READY then
		return 
	end

	self._xbox_trying_to_open_invite_friends = nil

	MultiplayerSession.invite_friends(Managers.account:user_id(), self.lobby:session_id(), 0, 3)

	return 
end
ConsoleMapView.on_friends_pressed = function (self)
	self.friends:set_active(true)

	return 
end
ConsoleMapView.deactivate_friends_menu = function (self)
	self.friends:set_active(false)
	self.input_manager:block_device_except_service("map_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("map_menu", "mouse", 1)
	self.input_manager:block_device_except_service("map_menu", "gamepad", 1)

	return 
end
ConsoleMapView.friends_list_active = function (self)
	return self.friends:is_active()
end

return 
