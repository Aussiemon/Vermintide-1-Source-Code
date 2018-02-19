require("scripts/ui/ui_layer")
require("scripts/ui/ui_renderer")
require("scripts/ui/ui_elements")
require("scripts/ui/ui_element")
require("scripts/ui/ui_widgets")
require("scripts/ui/views/widget_definitions")
require("scripts/ui/views/ingame_view")
require("scripts/ui/views/ingame_hud")
require("scripts/ui/views/popup_handler")
require("scripts/ui/views/popup_join_lobby_handler")
require("scripts/ui/views/end_screen_ui")
require("scripts/ui/views/cutscene_ui")
require("scripts/ui/views/matchmaking_ui")
require("scripts/settings/ui_settings")
require("scripts/ui/hud_ui/level_countdown_ui")
require("scripts/ui/views/item_display_popup")
require("scripts/ui/views/item_display_popup_definitions")
require("scripts/ui/help_screen/help_screen_ui")
require("scripts/ui/views/lobby_browse_view")
require("scripts/ui/views/profile_view")
require("scripts/ui/views/credits_view")
require("scripts/ui/views/inventory_view")
require("scripts/ui/views/lorebook_view")
require("scripts/ui/views/options_view")
require("scripts/ui/views/map_view")
require("scripts/ui/views/console_map_view")
require("scripts/ui/forge_view/forge_view")
require("scripts/ui/altar_view/altar_view")
require("scripts/ui/views/unlock_key_view")
require("scripts/ui/views/telemetry_survey_view")
require("scripts/ui/views/friends_view")
require("scripts/ui/quest_view/quest_view")
require("scripts/ui/quest_view/quest_view_definitions")
require("scripts/ui/views/ingame_voting_ui")

local rpcs = {}
local settings = require("scripts/ui/views/ingame_ui_settings")
local view_settings = settings.view_settings
local transitions = settings.transitions
IngameUI = class(IngameUI)
local ALWAYS_LOAD_ALL_VIEWS = script_data.always_load_all_views or Development.parameter("always_load_all_views")
IngameUI.init = function (self, ingame_ui_context)
	printf("[IngameUI] init")

	self.unlock_manager = Managers.unlock
	self.world_manager = ingame_ui_context.world_manager
	self.camera_manager = ingame_ui_context.camera_manager
	self.is_in_inn = ingame_ui_context.is_in_inn
	local world = ingame_ui_context.world_manager:create_world("ingame_view", GameSettingsDevelopment.default_environment, nil, 980, Application.DISABLE_PHYSICS, Application.DISABLE_APEX_CLOTH)

	ScriptWorld.deactivate(world)

	local top_world = Managers.world:world("top_ingame_view")

	ScriptWorld.create_viewport(world, "ingame_view_viewport", "overlay", 1)

	self.wwise_world = Managers.world:wwise_world(world)
	self.world = world
	self.top_world = top_world

	if Development.parameter("gdc") then
		self.ui_renderer = UIRenderer.create(world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/gdc_material", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
		self.ui_top_renderer = UIRenderer.create(top_world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/gdc_material", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
	elseif ALWAYS_LOAD_ALL_VIEWS then
		self.ui_renderer = view_settings.development.ui_renderer_function(world)
		self.ui_top_renderer = view_settings.development.ui_renderer_function(top_world)
	elseif self.is_in_inn then
		self.ui_renderer = view_settings.inn.ui_renderer_function(world)
		self.ui_top_renderer = view_settings.inn.ui_renderer_function(top_world)
	else
		self.ui_renderer = view_settings.ingame.ui_renderer_function(world)
		self.ui_top_renderer = view_settings.ingame.ui_renderer_function(top_world)
	end

	if Development.parameter("gdc") then
		self.blocked_transitions = {
			inventory_view_force = true,
			forge_view = true,
			forge_view_force = true,
			inventory_view = true,
			lorebook_view = true,
			lorebook_view_force = true
		}
	elseif ALWAYS_LOAD_ALL_VIEWS then
		self.blocked_transitions = view_settings.development.blocked_transitions
	elseif self.is_in_inn then
		self.blocked_transitions = view_settings.inn.blocked_transitions
	else
		self.blocked_transitions = view_settings.ingame.blocked_transitions
	end

	UISetupFontHeights(self.ui_renderer.gui)

	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager.create_input_service(input_manager, "ingame_menu", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "ingame_menu", "keyboard")
	input_manager.map_device_to_service(input_manager, "ingame_menu", "mouse")
	input_manager.map_device_to_service(input_manager, "ingame_menu", "gamepad")

	ingame_ui_context.ui_renderer = self.ui_renderer
	ingame_ui_context.ui_top_renderer = self.ui_top_renderer
	ingame_ui_context.ingame_ui = self
	self.peer_id = ingame_ui_context.peer_id
	self.local_player_id = ingame_ui_context.local_player_id
	self.ingame_hud = IngameHud:new(ingame_ui_context)
	self.countdown_ui = LevelCountdownUI:new(ingame_ui_context)
	self.popup_join_lobby_handler = PopupJoinLobbyHandler:new(ingame_ui_context)
	self.is_server = ingame_ui_context.is_server
	self.last_resolution_x, self.last_resolution_y = Application.resolution()

	InitVideo()
	self.setup_views(self, ingame_ui_context)

	if self.views.map_view and self.views.map_view.set_friends_view then
		self.views.map_view:set_friends_view(self.views.friends_view)
	end

	self.ingame_menu = IngameView:new(ingame_ui_context)
	self.end_screen = EndScreenUI:new(ingame_ui_context)
	self.voting_manager = ingame_ui_context.voting_manager
	self.ingame_voting_ui = IngameVotingUI:new(ingame_ui_context)

	if GameSettingsDevelopment.help_screen_enabled then
		self.help_screen = HelpScreenUI:new(ingame_ui_context)
	end

	local cutscene_system = Managers.state.entity:system("cutscene_system")
	self.cutscene_ui = CutsceneUI:new(ingame_ui_context, cutscene_system)
	self.cutscene_system = cutscene_system

	self.register_rpcs(self, ingame_ui_context.network_event_delegate)
	GarbageLeakDetector.register_object(self, "IngameUI")

	self.matchmaking_ui = MatchmakingUI:new(ingame_ui_context)

	if not self.is_server and self.is_in_inn then
		self.views.map_view:set_map_interaction_state(false)
	end

	Managers.chat:set_profile_synchronizer(ingame_ui_context.profile_synchronizer)
	Managers.chat:set_wwise_world(self.world_manager:wwise_world(self.world))
	Managers.chat:set_input_manager(input_manager)
	Managers.state.event:register(self, "event_dlc_status_changed", "event_dlc_status_changed")

	self.telemetry_time_view_enter = 0
	self.ingame_ui_context = ingame_ui_context
	self.player_manager = Managers.player

	return 
end
IngameUI.get_ingame_menu_keymap = function (self)
	local loaded_menu_controls = PlayerData.controls and PlayerData.controls.ingame_menu
	local ingame_menu_keymap = table.clone(IngameMenuKeymaps)

	if loaded_menu_controls and loaded_menu_controls.keymap then
		local platform = PLATFORM

		table.merge_recursive(ingame_menu_keymap[platform], loaded_menu_controls.keymap)
	end

	return ingame_menu_keymap
end
IngameUI.setup_views = function (self, ingame_ui_context)
	if ALWAYS_LOAD_ALL_VIEWS then
		self.views = view_settings.development.views_function(ingame_ui_context)
	elseif self.is_in_inn then
		self.views = view_settings.inn.views_function(ingame_ui_context)
	else
		self.views = view_settings.ingame.views_function(ingame_ui_context)
	end

	if ALWAYS_LOAD_ALL_VIEWS then
		self.hotkey_mapping = view_settings.development.hotkey_mapping
	elseif self.is_in_inn then
		self.hotkey_mapping = view_settings.inn.hotkey_mapping
	else
		self.hotkey_mapping = view_settings.ingame.hotkey_mapping
	end

	return 
end
IngameUI.setup_specific_view = function (self, key, class_name)
	printf("[IngameUI] setup_specific_view %s", class_name)

	local class = rawget(_G, class_name)

	if self.views[key] and self.views[key].destroy then
		self.views[key]:destroy()
		printf("[IngameUI] setup_specific_view destroy %s", class_name)
	end

	self.views[key] = class.new(class, self.ingame_ui_context)

	return 
end
IngameUI.is_local_player_ready_for_game = function (self)
	if self.is_in_inn then
		local own_peer_id = self.peer_id
		local mm_ready_peers = Managers.matchmaking.ready_peers

		if mm_ready_peers then
			return mm_ready_peers[own_peer_id]
		end
	end

	return 
end
IngameUI.is_searching_for_game = function (self)
	local matchmaking = Managers.matchmaking

	if matchmaking == nil then
		return false
	end

	return matchmaking.is_searching_for_game(matchmaking)
end
IngameUI.can_view_lobby_browser = function (self)
	local is_server = self.is_server
	local is_game_matchmaking = Managers.matchmaking:is_game_matchmaking()

	return is_server and not is_game_matchmaking
end
IngameUI.is_forge_unlocked = function (self)
	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local can_use = ProgressionUnlocks.is_unlocked("forge", level, prestige)

	return can_use
end
IngameUI.is_altar_unlocked = function (self)
	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local can_use = ProgressionUnlocks.is_unlocked("altar", level, prestige)

	return can_use
end
IngameUI.is_quests_unlocked = function (self)
	if script_data.unlock_all_levels then
		return true
	end

	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local can_use = ProgressionUnlocks.is_unlocked("quests", level, prestige)

	return can_use
end
IngameUI.is_lorebook_enabled = function (self)
	if PLATFORM ~= "win32" then
		return GameSettingsDevelopment.lorebook_enabled
	else
		return true
	end

	return 
end
IngameUI.register_rpcs = function (self, network_event_delegate)
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(rpcs))

	return 
end
IngameUI.unregister_rpcs = function (self)
	self.network_event_delegate:unregister(self)

	self.network_event_delegate = nil

	return 
end
IngameUI.destroy = function (self)
	self.unregister_rpcs(self)
	Managers.chat:set_profile_synchronizer(nil)
	Managers.chat:set_wwise_world(nil)
	Managers.chat:set_input_manager(nil)

	local current_view = self.current_view
	local menu_active = self.menu_active

	if menu_active or current_view then
		ShowCursorStack.pop()
	end

	if current_view then
		self.views[current_view]:on_exit()

		self.current_view = nil
	end

	for k, view in pairs(self.views) do
		if view.destroy then
			view.destroy(view)
		end
	end

	self.matchmaking_ui:destroy()

	self.matchmaking_ui = nil

	self.end_screen:destroy()

	self.end_screen = nil

	self.ingame_hud:destroy()

	self.ingame_hud = nil

	self.cutscene_ui:destroy()

	self.cutscene_ui = nil
	self.cutscene_system = nil

	self.countdown_ui:destroy()

	self.countdown_ui = nil

	if self.help_screen then
		self.help_screen:destroy()

		self.help_screen = nil
	end

	self.popup_join_lobby_handler:destroy()

	self.popup_join_lobby_handler = nil

	self.ingame_voting_ui:destroy()

	self.ingame_voting_ui = nil

	UIRenderer.destroy(self.ui_renderer, self.world)
	UIRenderer.destroy(self.ui_top_renderer, self.top_world)

	self.ui_renderer = nil
	self.ui_top_renderer = nil

	self.world_manager:destroy_world(self.world)

	if self.popup_id then
		Managers.popup:cancel_popup(self.popup_id)
	end

	Managers.state.event:unregister("event_dlc_status_changed", self)
	printf("[IngameUI] destroy")

	return 
end
IngameUI.handle_menu_hotkeys = function (self, dt, input_service, menu_active)
	local views = self.views
	local current_view = self.current_view
	local hotkey_mapping = self.hotkey_mapping
	local player_ready_for_game = self.is_local_player_ready_for_game(self)

	for input, mapping_data in pairs(hotkey_mapping) do
		if not current_view or current_view == mapping_data.view then
			if current_view then
				local active_view = views[current_view]
				local active_input_service = active_view.input_service(active_view)

				if not active_view.transitioning(active_view) and active_input_service.get(active_input_service, input) then
					local local_player = self.player_manager:local_player()
					local player_unit = local_player and local_player.player_unit
					local player_alive = player_unit and Unit.alive(player_unit)

					if player_alive then
						local return_to_game = not menu_active

						views[current_view]:exit(return_to_game)

						break
					end
				end
			else
				local new_view = views[mapping_data.view]
				local can_interact_flag = mapping_data.can_interact_flag
				local can_interact_func = mapping_data.can_interact_func

				if input_service.get(input_service, input) then
					local can_interact = true

					if can_interact_flag and not new_view[can_interact_flag] then
						can_interact = false
					end

					if can_interact and can_interact_func and not self[can_interact_func](self) then
						can_interact = false
					end

					if can_interact then
						local local_player = self.player_manager:local_player()
						local player_unit = local_player and local_player.player_unit
						local player_alive = player_unit and Unit.alive(player_unit)

						if player_alive then
							if not player_ready_for_game then
								if menu_active then
									self.transition_with_fade(self, mapping_data.in_transition_menu)

									break
								end

								self.transition_with_fade(self, mapping_data.in_transition)

								break
							end

							local error_message = mapping_data.error_message

							if error_message then
								self.add_local_system_message(self, error_message)
							end

							break
						end
					end
				end
			end
		end
	end

	return 
end
IngameUI.event_dlc_status_changed = function (self)
	if self.current_view == "map_view" then
		self.handle_transition(self, "exit_menu")
	end

	self.setup_specific_view(self, "map_view", "ConsoleMapView")

	return 
end
IngameUI.update = function (self, dt, t, disable_ingame_ui, end_of_level_ui)
	Profiler.start("IngameUI")
	self._update_fade_transition(self)

	local views = self.views
	local is_in_inn = self.is_in_inn
	local menu_suspended = self.menu_suspended
	local input_service = self.input_manager:get_service("ingame_menu")
	local end_screen_active = self.end_screen_active(self)
	local ingame_hud = self.ingame_hud
	local transition_manager = Managers.transition
	local countdown_ui = self.countdown_ui
	local end_screen = self.end_screen

	self._update_system_message_cooldown(self, dt)
	self._handle_resolution_changes(self)

	if self.is_server then
		self.update_map_enable_state(self)
	end

	Profiler.start("popup_handler")

	if self.popup_id then
		local popup_result = Managers.popup:query_result(self.popup_id)

		if popup_result then
			self.handle_transition(self, popup_result)
		end
	end

	Profiler.stop("popup_handler")

	if self.survey_active then
		self._survey_update(self, dt)
	end

	local in_score_screen = end_of_level_ui ~= nil

	self._update_hud_visibility(self, disable_ingame_ui, in_score_screen)

	if not disable_ingame_ui then
		if self.current_view then
			local current_view = self.current_view

			Profiler.start(current_view)
			views[current_view]:update(dt, t)
			Profiler.stop(current_view)
		end

		if not menu_suspended then
			if self.menu_active and not self.current_view then
				Profiler.start("ingame menu")
				self.ingame_menu:update(dt)

				local ui_renderer = self.ui_renderer
				local w = RESOLUTION_LOOKUP.res_w
				local h = RESOLUTION_LOOKUP.res_h
				local inverse_scale = RESOLUTION_LOOKUP.inv_scale

				UIRenderer.draw_texture(ui_renderer, "gradient_main_menu", Vector3(0, 0, UILayer.menu_gradient), Vector2(w*inverse_scale, h*inverse_scale))
				Profiler.stop("ingame menu")
			end

			local gdc_build = Development.parameter("gdc")

			if not self.pending_transition(self) and not end_screen_active and not self.menu_active and not self.leave_game and not self.return_to_title_screen and not gdc_build and not self.popup_join_lobby_handler.visible and input_service.get(input_service, "toggle_menu", true) then
				self.handle_transition(self, "ingame_menu")

				MOOD_BLACKBOARD.menu = true
			end
		end

		if is_in_inn then
			Profiler.start("hotkeys")

			if not self.pending_transition(self) then
				self.handle_menu_hotkeys(self, dt, input_service, self.menu_active)
			end

			Profiler.stop("hotkeys")
		end

		if is_in_inn then
			Profiler.start("Countdown UI")
			countdown_ui.update(countdown_ui, dt)
			Profiler.stop("Countdown UI")
		end

		if is_in_inn then
			Profiler.start("matchmaking")
			self.matchmaking_ui:update(dt, t)
			Profiler.stop("matchmaking")
		end

		Profiler.start("popup_handler")
		self.popup_join_lobby_handler:update(dt)
		Profiler.stop("popup_handler")
		Profiler.start("endscreen")
		end_screen.update(end_screen, dt)
		Profiler.stop("endscreen")

		if self.help_screen then
			Profiler.start("help_screen")
			self.help_screen:update(dt)
			Profiler.stop("help_screen")
		end

		if not end_of_level_ui and not end_screen.is_active then
			Profiler.start("cutscene_ui")
			self.cutscene_ui:update(dt)
			Profiler.stop("cutscene_ui")
			self._update_ingame_hud(self, self.hud_visible, dt, t)
		end
	end

	self._update_chat_ui(self, dt, t, input_service, end_of_level_ui)
	self._render_debug_ui(self, dt, t)
	self._update_fade_transition(self)
	Profiler.stop("IngameUI")

	return 
end
IngameUI.post_update = function (self, dt, t)
	self._post_handle_transition(self)

	local current_view = self.current_view

	if current_view then
		local views = self.views

		if views[current_view].post_update then
			views[current_view]:post_update(dt, t)
		end
	end

	if self.hud_visible then
		local cutscene_system = self.cutscene_system
		local active_cutscene = (cutscene_system.active_camera or self.popup_join_lobby_handler.visible) and not cutscene_system.ingame_hud_enabled

		self.ingame_hud:post_update(dt, t, active_cutscene)
	end

	return 
end
IngameUI._update_hud_visibility = function (self, disable_ingame_ui, in_score_screen)
	local current_view = self.current_view
	local cutscene_system = self.cutscene_system
	local join_game_popup_active = self.popup_join_lobby_handler.visible
	local is_enter_game = self.countdown_ui:is_enter_game()
	local end_screen = self.end_screen
	local menu_active = self.menu_active
	local draw_hud = nil

	if not disable_ingame_ui and not menu_active and not current_view and not is_enter_game and not in_score_screen and not end_screen.active and not join_game_popup_active then
		draw_hud = true
	else
		draw_hud = false
	end

	local hud_visible = self.hud_visible

	if draw_hud ~= hud_visible then
		self.hud_visible = draw_hud

		self.ingame_hud:set_visible(draw_hud)
	end

	return 
end
IngameUI._survey_update = function (self, dt)
	local telemetry_survey_view = self.views.telemetry_survey

	telemetry_survey_view.update(telemetry_survey_view, dt)

	if telemetry_survey_view.is_survey_answered(telemetry_survey_view) or telemetry_survey_view.is_survey_timed_out(telemetry_survey_view) then
		self.survey_active = false

		telemetry_survey_view.on_exit(telemetry_survey_view)
		self.deactivate_end_screen_ui(self, nil, true)
	end

	return 
end
IngameUI._handle_resolution_changes = function (self)
	local res_x = RESOLUTION_LOOKUP.res_w
	local res_y = RESOLUTION_LOOKUP.res_h

	if res_x ~= self.last_resolution_x or res_y ~= self.last_resolution_y then
		InitVideo()

		self.last_resolution_y = res_y
		self.last_resolution_x = res_x
	end

	return 
end
IngameUI._update_ingame_hud = function (self, visible, dt, t)
	local cutscene_system = self.cutscene_system
	local active_cutscene = (cutscene_system.active_camera or self.popup_join_lobby_handler.visible) and not cutscene_system.ingame_hud_enabled

	if visible then
		self.ingame_hud:update(dt, t, active_cutscene)
	end

	if not active_cutscene then
		Profiler.start("Voting")
		self.ingame_voting_ui:update(self.menu_active, dt, t)
		Profiler.stop()
	end

	return 
end
IngameUI._update_chat_ui = function (self, dt, t, input_service, end_of_level_ui)
	local ingame_player_list_ui = self.ingame_hud.ingame_player_list_ui
	local player_list_focused = ingame_player_list_ui.is_focused(ingame_player_list_ui)
	local ingame_hud = self.ingame_hud
	local gift_popup_ui = ingame_hud.gift_popup_ui
	local gift_popup_active = gift_popup_ui.active(gift_popup_ui)
	local cutscene_system = self.cutscene_system
	local in_view = self.menu_active or (end_of_level_ui and end_of_level_ui.enable_chat(end_of_level_ui)) or self.current_view ~= nil
	local active_cutscene = (cutscene_system.active_camera or self.popup_join_lobby_handler.visible) and not cutscene_system.ingame_hud_enabled
	local join_popup_visible = self.popup_join_lobby_handler.visible

	if self.current_view then
		local active_view = self.views[self.current_view]
		local view_input_service = active_view.input_service(active_view)

		Managers.chat:update(dt, t, in_view, view_input_service)
	elseif end_of_level_ui then
		local end_of_level_input_service = end_of_level_ui.active_input_service(end_of_level_ui)

		Managers.chat:update(dt, t, in_view, end_of_level_input_service)
	elseif gift_popup_active then
		local gift_popup_input_service = gift_popup_ui.active_input_service(gift_popup_ui)

		Managers.chat:update(dt, t, in_view, gift_popup_input_service)
	elseif join_popup_visible then
		local join_popup_input_service = self.popup_join_lobby_handler:input_service()

		Managers.chat:update(dt, t, in_view, join_popup_input_service)
	elseif player_list_focused then
		local ingame_player_list_input_service = ingame_player_list_ui.input_service(ingame_player_list_ui)

		Managers.chat:update(dt, t, in_view, ingame_player_list_input_service)
	elseif self.menu_active then
		Managers.chat:update(dt, t, in_view, input_service)
	elseif active_cutscene then
		local cutscene_input_service = self.cutscene_ui:input_service()

		Managers.chat:update(dt, t, in_view, cutscene_input_service)
	elseif self.end_screen.is_active then
		local end_screen_input_service = self.end_screen:input_service()

		Managers.chat:update(dt, t, in_view, end_screen_input_service)
	else
		local no_unblock = self.countdown_ui:is_enter_game()

		Managers.chat:update(dt, t, in_view, nil, no_unblock)
	end

	return 
end
IngameUI._render_debug_ui = function (self, dt, t)
	Profiler.start("debug_stuff")

	if GameSettingsDevelopment.show_version_info and not Development.parameter("hide_version_info") then
		self._render_version_info(self)
	end

	if GameSettingsDevelopment.show_fps and not Development.parameter("hide_fps") then
		self._render_fps(self, dt)
	end

	Profiler.stop("debug_stuff")

	return 
end
IngameUI.show_info = function (self)
	local mission_system = Managers.state.entity:system("mission_system")
	local grimoire_mission_data = mission_system.get_level_end_mission_data(mission_system, "grimoire_hidden_mission")
	local tome_mission_data = mission_system.get_level_end_mission_data(mission_system, "tome_bonus_mission")
	local w, h = Application.resolution()
	local pos = Vector3(100, h - 100, 999)
	pos = self._show_text(self, (grimoire_mission_data and grimoire_mission_data.current_amount) or "", pos)
	pos = self._show_text(self, (tome_mission_data and tome_mission_data.current_amount) or "", pos)

	return 
end
IngameUI._show_text = function (self, text, pos)
	Gui.text(self.ui_renderer.gui, text, "materials/fonts/gw_head_32", 20, "gw_head_20", pos, Color(0, 255, 0))

	return Vector3(pos[1], pos[2] - 30, pos[3])
end
IngameUI._update_system_message_cooldown = function (self, dt)
	local system_message_delay = self.system_message_delay

	if system_message_delay then
		system_message_delay = system_message_delay - dt
		self.system_message_delay = (0 < system_message_delay and system_message_delay) or nil
	end

	return 
end
IngameUI.add_local_system_message = function (self, message)
	if not self.system_message_delay or self.last_sent_system_message ~= message then
		local channel_id = 1
		local pop_chat = true
		local localized_message = Localize(message)

		if PLATFORM == "win32" then
			Managers.chat:add_local_system_message(channel_id, localized_message, pop_chat)
		else
			local local_player = Managers.player:local_player()
			local stats_id = local_player.stats_id(local_player)

			Managers.state.event:trigger("add_personal_interaction_warning", stats_id .. message, message)
		end

		self.last_sent_system_message = message
		self.system_message_delay = 1.5
	end

	return 
end
IngameUI.is_transition_allowed = function (self, transition)
	local error_message = nil
	local transition_allowed = true
	local player_ready_for_game = self.is_local_player_ready_for_game(self)
	local is_searching_for_game = self.is_searching_for_game(self)

	if player_ready_for_game or is_searching_for_game then
		if transition == "forge_view_force" then
			error_message = "matchmaking_ready_interaction_message_forge"
			transition_allowed = false
		elseif transition == "profile_view" then
			error_message = "matchmaking_ready_interaction_message_profile_view"
			transition_allowed = false
		elseif transition == "inventory_view_force" then
			error_message = "matchmaking_ready_interaction_message_inventory"
			transition_allowed = false
		elseif transition == "altar_view_force" then
			error_message = "dlc1_1_matchmaking_ready_interaction_message_altar"
			transition_allowed = false
		elseif transition == "quest_view_force" then
			error_message = "dlc1_3_1_matchmaking_ready_interaction_message_quests"
			transition_allowed = false
		elseif transition == "lorebook_view_force" or transition == "lorebook_menu" then
			error_message = "dlc1_3_matchmaking_ready_interaction_message_lorebook"
			transition_allowed = false
		end
	end

	if error_message then
		self.add_local_system_message(self, error_message)
	end

	return transition_allowed
end
IngameUI._post_handle_transition = function (self)
	local new_transition = self.new_transition

	if not new_transition then
		return 
	end

	local transition_params = self.transition_params
	local old_view = self.views[self.new_transition_old_view]

	if old_view and old_view.post_update_on_exit then
		printf("[IngameUI] menu view post_update_on_exit %s", old_view)
		old_view.post_update_on_exit(old_view, unpack(transition_params))
	end

	local new_view = self.views[self.current_view]

	if new_view and new_view.post_update_on_enter then
		printf("[IngameUI] menu view post_update_on_enter %s", new_view)
		new_view.post_update_on_enter(new_view, unpack(transition_params))
	end

	self.transition_params = nil
	self.new_transition_old_view = nil
	self.new_transition = nil

	return 
end
IngameUI.handle_transition = function (self, new_transition, ...)
	assert(transitions[new_transition])

	local blocked_transitions = self.blocked_transitions

	if blocked_transitions and blocked_transitions[new_transition] then
		return 
	end

	local previous_transition = self._previous_transition

	if not self.is_transition_allowed(self, new_transition) or (previous_transition and previous_transition == new_transition) then
		return 
	end

	local transition_params = {
		...
	}

	if self.new_transition_old_view then
		return 
	end

	local old_view = self.current_view

	transitions[new_transition](self, unpack(transition_params))

	local new_view = self.current_view

	if old_view ~= new_view then
		if self.views[old_view] and self.views[old_view].on_exit then
			printf("[IngameUI] menu view on_exit %s", old_view)
			self.views[old_view]:on_exit(unpack(transition_params))
		end

		if new_view and self.views[new_view] and self.views[new_view].on_enter then
			printf("[IngameUI] menu view on_enter %s", new_view)
			self.views[new_view]:on_enter(unpack(transition_params))
			Managers.state.event:trigger("ingame_ui_view_on_enter", new_view)
		end
	end

	self.new_transition = new_transition
	self.new_transition_old_view = old_view
	self.transition_params = transition_params
	self._previous_transition = new_transition

	return 
end
IngameUI.transition_with_fade = function (self, new_transition, ...)
	local blocked_transitions = self.blocked_transitions

	if blocked_transitions and blocked_transitions[new_transition] then
		return 
	end

	local previous_transition = self._previous_transition

	if not self.is_transition_allowed(self, new_transition) or (previous_transition and previous_transition == new_transition) then
		return 
	end

	self._transition_fade_data = {
		new_transition = new_transition,
		transition_params = {
			...
		}
	}

	Managers.transition:fade_in(10)

	return 
end
IngameUI._update_fade_transition = function (self)
	local transition_fade_data = self._transition_fade_data

	if not transition_fade_data then
		return 
	end

	local transition_manager = Managers.transition

	if transition_manager.fade_in_completed(transition_manager) then
		local new_transition = transition_fade_data.new_transition
		local transition_params = transition_fade_data.transition_params

		self.handle_transition(self, new_transition, unpack(transition_params))

		self._transition_fade_data = nil

		Managers.transition:fade_out(10)
	end

	return 
end
IngameUI.pending_transition = function (self)
	return self._transition_fade_data ~= nil or self.new_transition_old_view ~= nil
end
IngameUI.get_transition = function (self)
	if self.leave_game then
		return "leave_game"
	elseif self.return_to_title_screen then
		return "return_to_title_screen"
	elseif self.join_lobby then
		return "join_lobby", self.join_lobby
	elseif self.restart_game then
		return "restart_game"
	end

	return 
end
IngameUI.suspend_active_view = function (self)
	local current_view = self.current_view

	if current_view then
		local view = self.views[current_view]

		if view.suspend then
			printf("[IngameUI] menu view suspend %s", current_view)
			view.suspend(view)
		end
	end

	self.menu_suspended = true

	return 
end
IngameUI.unsuspend_active_view = function (self)
	if self.menu_active then
		self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
		self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)
	end

	local current_view = self.current_view

	if current_view then
		local view = self.views[current_view]

		if view.unsuspend then
			printf("[IngameUI] menu view unsuspend %s", current_view)
			view.unsuspend(view)
		end
	end

	self.menu_suspended = nil

	return 
end
IngameUI.activate_end_screen_ui = function (self, you_win, checkpoint_available)
	self.end_screen:on_enter(you_win, checkpoint_available)

	return 
end
IngameUI.deactivate_end_screen_ui = function (self, you_win, ignore_survey)
	local telemetry_survey_view = self.views.telemetry_survey
	local use_survey = TelemetrySettings.send and TelemetrySettings.use_session_survey

	if use_survey and not ignore_survey then
		local end_screen = self.end_screen

		if end_screen.checkpoint_available then
			self.end_screen:fade_out_continue_vote()
		end

		local survey_context = (you_win and "win") or "lost"
		self.survey_active = true

		telemetry_survey_view.on_enter(telemetry_survey_view)
		telemetry_survey_view.set_survey_context(telemetry_survey_view, survey_context)
	else
		self.end_screen:on_exit()
	end

	return 
end
IngameUI.end_screen_active = function (self)
	return self.end_screen.is_active
end
IngameUI.end_screen_completed = function (self)
	return self.end_screen.is_complete
end
IngameUI.update_map_enable_state = function (self)
	if self.is_in_inn then
		local map_view = self.views.map_view
		local map_interaction_enabled = map_view.map_interaction_enabled
		local is_game_matchmaking = Managers.matchmaking:is_game_matchmaking()

		if map_interaction_enabled and is_game_matchmaking then
			map_view.set_map_interaction_state(map_view, false)
		elseif not map_interaction_enabled and not is_game_matchmaking then
			map_view.set_map_interaction_state(map_view, true)
		end
	end

	return 
end
IngameUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
local debug_font = "gw_arial_16"
local debug_font_mtrl = "materials/fonts/" .. debug_font
local position = {}
local white_color = Colors.color_definitions.white
local black_color = Colors.color_definitions.black
local red_color = Colors.color_definitions.red
IngameUI._render_version_info = function (self)
	local ui_renderer = self.ui_renderer
	local res_width = 1920
	local res_height = 1080
	local text_size = 18
	local build = script_data.build_identifier or "???"
	local revision = script_data.settings.content_revision or "???"
	local build_hash = tostring(Application.make_hash(build, revision)):sub(1, 4):upper()

	if build == "???" and revision == "???" then
		build_hash = "???"
	end

	local text = "GAME HASH: " .. build_hash .. " | Content revision: " .. revision .. " | Engine version: " .. build.sub(build, 1, 6) .. "..."

	if rawget(_G, "Steam") then
		local appid = Steam.app_id()
		text = text .. " Appid: " .. appid
	end

	local width, height = UIRenderer.text_size(ui_renderer, text, debug_font_mtrl, text_size)
	local x = res_width - width - 8
	local y = height
	position[1] = x
	position[2] = y
	position[3] = 899

	UIRenderer.draw_text(ui_renderer, text, debug_font_mtrl, text_size, debug_font, Vector3(unpack(position)), white_color)

	position[1] = x + 2
	position[2] = y - 2
	position[3] = 898

	UIRenderer.draw_text(ui_renderer, text, debug_font_mtrl, text_size, debug_font, Vector3(unpack(position)), black_color)

	return 
end
IngameUI._render_fps = function (self, dt)
	local ui_renderer = self.ui_renderer
	local fps = nil

	if dt < 1e-07 then
		fps = 0
	else
		fps = dt/1
	end

	local text = string.format("%i FPS", fps)
	local color = nil
	local red_cap = 30
	local platform = PLATFORM

	if platform == "ps4" or platform == "xb1" then
		red_cap = 28
	end

	if fps < red_cap then
		color = red_color
	else
		color = white_color
	end

	local res_width = 1920
	local res_height = 1080
	local text_size = 24
	local width, height = UIRenderer.text_size(ui_renderer, text, debug_font_mtrl, text_size)
	local x = res_width - width - 8
	local y = height + 16
	position[1] = x
	position[2] = y
	position[3] = 899

	UIRenderer.draw_text(ui_renderer, text, debug_font_mtrl, text_size, debug_font, Vector3(unpack(position)), color)

	position[1] = x + 2
	position[2] = y - 2
	position[3] = 898

	UIRenderer.draw_text(ui_renderer, text, debug_font_mtrl, text_size, debug_font, Vector3(unpack(position)), black_color)

	local cm = Managers.state.camera

	if cm then
		local player = Managers.player:local_player(1)
		local vp_name = player and player.viewport_name

		if vp_name then
			local pos = cm.camera_position(cm, vp_name)
			local rot = cm.camera_rotation(cm, vp_name)
			local text_size = 18
			local str = string.format("Position(%.2f, %.2f, %.2f) Rotation(%.4f, %.4f, %.4f, %.4f)", pos.x, pos.y, pos.z, Quaternion.to_elements(rot))

			UIRenderer.draw_text(ui_renderer, str, debug_font_mtrl, text_size, debug_font, Vector3(11, 11, 1), color)
			UIRenderer.draw_text(ui_renderer, str, debug_font_mtrl, text_size, debug_font, Vector3(10, 10, 0), black_color)
		end
	end

	if LobbyInternal.SESSION_NAME then
		UIRenderer.draw_text(ui_renderer, "My server name:", debug_font_mtrl, 20, debug_font, Vector3(20, 40, 999))
		UIRenderer.draw_text(ui_renderer, "My server name:", debug_font_mtrl, 20, debug_font, Vector3(22, 38, 998), black_color)
		UIRenderer.draw_text(ui_renderer, LobbyInternal.SESSION_NAME, debug_font_mtrl, 20, debug_font, Vector3(20, 20, 999))
		UIRenderer.draw_text(ui_renderer, LobbyInternal.SESSION_NAME, debug_font_mtrl, 20, debug_font, Vector3(22, 18, 998), black_color)
	end

	return 
end

return 
