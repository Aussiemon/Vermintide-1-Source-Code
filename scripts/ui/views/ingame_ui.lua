require("scripts/ui/ui_layer")
require("scripts/ui/ui_fonts")
require("scripts/ui/ui_renderer")
require("scripts/ui/ui_elements")
require("scripts/ui/ui_element")
require("scripts/ui/ui_widgets")
require("scripts/ui/views/widget_definitions")
require("scripts/ui/views/ingame_view")
require("scripts/ui/views/lobby_browse_view")
require("scripts/ui/views/profile_view")
require("scripts/ui/views/ingame_hud")
require("scripts/ui/views/popup_handler")
require("scripts/ui/views/popup_join_lobby_handler")
require("scripts/ui/views/credits_view")
require("scripts/ui/views/show_cursor_stack")
require("scripts/ui/views/inventory_view")
require("scripts/ui/views/lorebook_view")
require("scripts/ui/views/options_view")
require("scripts/ui/views/map_view")
require("scripts/ui/views/end_screen_ui")
require("scripts/ui/views/cutscene_ui")
require("scripts/ui/views/matchmaking_ui")
require("scripts/settings/ui_settings")
require("scripts/ui/forge_view/forge_view")
require("scripts/ui/altar_view/altar_view")
require("scripts/ui/views/unlock_key_view")
require("scripts/ui/views/telemetry_survey_view")
require("scripts/ui/hud_ui/level_countdown_ui")
require("scripts/ui/views/item_display_popup")
require("scripts/ui/views/item_display_popup_definitions")
require("scripts/ui/views/friends_view")
require("scripts/ui/quest_view/quest_view")
require("scripts/ui/quest_view/quest_view_definitions")

local rpcs = {}
local transitions = {
	leave_group = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local text = Localize("leave_game_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("popup_leave_game_topic"), "leave_game", Localize("popup_choice_yes"), "cancel_popup", Localize("popup_choice_no"))

		return 
	end,
	quit_game = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local text = Localize("exit_game_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("popup_exit_game_topic"), "end_game", Localize("popup_choice_yes"), "cancel_popup", Localize("popup_choice_no"))

		return 
	end,
	prestige = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local text = Localize("prestige_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("prestige_game_topic"), "prestige_confirmation", Localize("popup_choice_yes"), "cancel_prestige_popup", Localize("popup_choice_no"))

		return 
	end,
	prestige_confirmation = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local text = Localize("prestige_confirmation_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("prestige_game_topic"), "accept_prestige_confirmation", Localize("popup_choice_yes"), "cancel_prestige_popup", Localize("popup_choice_no"))

		return 
	end,
	accept_prestige_confirmation = function (self)
		print("Prestige Level Up!")
		ProgressionUnlocks.upgrade_prestige()

		local prestige_level = ProgressionUnlocks.get_prestige_level()
		local game = Managers.state.network:game()
		local local_player = Managers.player:local_player()
		local player_unit = local_player.player_unit

		if Unit.alive(player_unit) then
			local go_id = Managers.state.unit_storage:go_id(player_unit)
			local current_prestige_level = GameSession.game_object_field(game, go_id, "prestige_level")
			local debug_prestige_level = (current_prestige_level == 6 and current_prestige_level) or current_prestige_level + 1

			GameSession.set_game_object_field(game, go_id, "prestige_level", prestige_level or debug_prestige_level)
		end

		return 
	end,
	end_game = function (self)
		self.input_manager:block_device_except_service(nil, "keyboard", 1)
		self.input_manager:block_device_except_service(nil, "mouse", 1)
		self.input_manager:block_device_except_service(nil, "gamepad", 1)

		local telemetry_survey_view = self.views.telemetry_survey
		local level_key = Managers.state.game_mode:level_key()
		local use_survey = GameSettingsDevelopment.use_session_survey
		local is_answered = telemetry_survey_view.is_survey_answered(telemetry_survey_view)
		local is_timed_out = telemetry_survey_view.is_survey_timed_out(telemetry_survey_view)

		if (use_survey and (is_answered or is_timed_out)) or not use_survey or level_key == "inn_level" then
			Boot.quit_game = true
			self.current_view = nil
		else
			self.current_view = "telemetry_survey"

			telemetry_survey_view.set_transition(telemetry_survey_view, "end_game")
		end

		return 
	end,
	leave_game = function (self)
		self.input_manager:block_device_except_service(nil, "keyboard", 1)
		self.input_manager:block_device_except_service(nil, "mouse", 1)
		self.input_manager:block_device_except_service(nil, "gamepad", 1)

		self.leave_game = true

		return 
	end,
	lobby_browser_view = function (self)
		self.current_view = "lobby_browser_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	lobby_browser_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "lobby_browser_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	profile_view = function (self)
		self.current_view = "profile_view"

		return 
	end,
	ingame_menu = function (self)
		if not self.menu_active then
			self.ingame_menu:on_enter()

			self.menu_active = true

			ShowCursorStack.push()
			self.play_sound(self, "Play_hud_button_open")
		end

		self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
		self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)

		self.current_view = nil

		return 
	end,
	inventory_view = function (self)
		self.current_view = "inventory_view"

		return 
	end,
	lorebook_view = function (self)
		self.current_view = "lorebook_view"

		return 
	end,
	lorebook_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "lorebook_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	map_menu = function (self)
		self.current_view = "map_view"

		return 
	end,
	map_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "map_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	inventory_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "inventory_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	forge_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "forge_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	forge_view = function (self)
		self.current_view = "forge_view"

		return 
	end,
	friends_view = function (self)
		self.current_view = "friends_view"

		return 
	end,
	altar_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "altar_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	altar_view = function (self)
		self.current_view = "altar_view"

		return 
	end,
	quest_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "quest_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	quest_view = function (self)
		self.current_view = "quest_view"

		return 
	end,
	friends_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "friends_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	initial_profile_view_force = function (self)
		self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
		self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)
		ShowCursorStack.push()

		self.current_view = "profile_view"
		self.initial_profile_view = true
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	profile_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "profile_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	unlock_key_force = function (self)
		ShowCursorStack.push()

		self.current_view = "unlock_key_view"
		self.views[self.current_view].exit_to_game = true

		return 
	end,
	join_lobby = function (self, lobby_client)
		self.input_manager:block_device_except_service(nil, "keyboard", 1)
		self.input_manager:block_device_except_service(nil, "mouse", 1)
		self.input_manager:block_device_except_service(nil, "gamepad", 1)

		self.join_lobby = lobby_client

		ShowCursorStack.pop()

		self.menu_active = false
		self.current_view = nil

		return 
	end,
	exit_menu = function (self)
		if self.current_view or self.menu_active then
			ShowCursorStack.pop()
		end

		if self.menu_active then
			self.play_sound(self, "Play_hud_button_close")
		end

		if not self.countdown_ui:is_enter_game() and not Managers.chat:chat_is_focused() and not Managers.matchmaking:is_join_popup_visible() then
			self.input_manager:device_unblock_all_services("keyboard", 1)
			self.input_manager:device_unblock_all_services("mouse", 1)
			self.input_manager:device_unblock_all_services("gamepad", 1)
		end

		self.menu_active = false
		self.current_view = nil
		MOOD_BLACKBOARD.menu = false

		return 
	end,
	exit_initial_profile_view = function (self)
		ShowCursorStack.pop()
		self.input_manager:device_unblock_all_services("keyboard", 1)
		self.input_manager:device_unblock_all_services("mouse", 1)
		self.input_manager:device_unblock_all_services("gamepad", 1)

		self.menu_active = false
		self.current_view = nil
		self.initial_profile_view = nil
		MOOD_BLACKBOARD.menu = false

		return 
	end,
	cancel_popup = function (self)
		self.popup_id = nil

		self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
		self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)

		return 
	end,
	cancel_prestige_popup = function (self)
		self.popup_id = nil

		return 
	end,
	credits_menu = function (self)
		self.current_view = "credits_view"

		return 
	end,
	options_menu = function (self)
		self.input_manager:block_device_except_service("options_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("options_menu", "mouse", 1)
		self.input_manager:block_device_except_service("options_menu", "gamepad", 1)

		self.current_view = "options_view"

		return 
	end,
	restart_game = function (self)
		self.input_manager:device_unblock_all_services("keyboard", 1)
		self.input_manager:device_unblock_all_services("mouse", 1)
		self.input_manager:device_unblock_all_services("gamepad", 1)

		self.restart_game = true

		return 
	end,
	close_active = function (self)
		local close_menu = false
		local menu_active = self.menu_active
		local view = self.views[self.current_view]

		if view then
			if view.exit then
				view.exit(view, true)
			elseif menu_active then
				close_menu = true
			end
		elseif self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)

			self.popup_id = nil

			if menu_active then
				close_menu = true
			end
		elseif menu_active then
			close_menu = true
		end

		if close_menu then
			self.current_view = nil
			self.menu_active = nil

			ShowCursorStack.pop()
			self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
			self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
			self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)

			MOOD_BLACKBOARD.menu = false
		end

		return 
	end
}
IngameUI = class(IngameUI)
IngameUI.init = function (self, ingame_ui_context)
	self.world_manager = ingame_ui_context.world_manager
	self.camera_manager = ingame_ui_context.camera_manager
	local world = ingame_ui_context.world_manager:create_world("ingame_view", GameSettingsDevelopment.default_environment, nil, 980, Application.DISABLE_PHYSICS, Application.DISABLE_APEX_CLOTH)

	ScriptWorld.deactivate(world)

	local top_world = Managers.world:world("top_ingame_view")

	ScriptWorld.create_viewport(world, "ingame_view_viewport", "overlay", 1)

	self.wwise_world = Managers.world:wwise_world(world)
	self.world = world
	self.top_world = top_world
	local language_id = Managers.localizer.language_id
	local helper_screen_material = "materials/ui/helper_screens/helper_screens"
	local end_screen_banner_material = "materials/ui/end_screen_banners/end_screen_banners"

	if Development.parameter("gdc") then
		self.ui_renderer = UIRenderer.create(world, "material", helper_screen_material, "material", end_screen_banner_material, "material", "materials/fonts/arial", "material", "materials/fonts/hell_shark_font", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/gdc_material", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
		self.ui_top_renderer = UIRenderer.create(top_world, "material", helper_screen_material, "material", end_screen_banner_material, "material", "materials/fonts/arial", "material", "materials/fonts/hell_shark_font", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/gdc_material", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
	else
		self.ui_renderer = UIRenderer.create(world, "material", helper_screen_material, "material", end_screen_banner_material, "material", "materials/fonts/arial", "material", "materials/fonts/hell_shark_font", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
		self.ui_top_renderer = UIRenderer.create(top_world, "material", helper_screen_material, "material", end_screen_banner_material, "material", "materials/fonts/arial", "material", "materials/fonts/hell_shark_font", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
	end

	if GameSettingsDevelopment.beta then
		self.blocked_transitions = {
			lorebook_view_force = true,
			lorebook_view = true
		}

		if Development.parameter("gdc") then
			self.blocked_transitions = {
				inventory_view_force = true,
				forge_view = true,
				forge_view_force = true,
				inventory_view = true,
				lorebook_view = true,
				lorebook_view_force = true
			}
		end
	end

	UISetupFontHeights(self.ui_renderer.gui)

	local loaded_menu_controls = PlayerData.controls and PlayerData.controls.ingame_menu
	local ingame_menu_keymap = table.clone(IngameMenuKeymaps)

	if loaded_menu_controls and loaded_menu_controls.keymap then
		table.merge_recursive(ingame_menu_keymap, loaded_menu_controls.keymap)
	end

	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager.create_input_service(input_manager, "ingame_menu", ingame_menu_keymap)
	input_manager.map_device_to_service(input_manager, "ingame_menu", "keyboard")
	input_manager.map_device_to_service(input_manager, "ingame_menu", "mouse")
	input_manager.map_device_to_service(input_manager, "ingame_menu", "gamepad")

	ingame_ui_context.ui_renderer = self.ui_renderer
	ingame_ui_context.ui_top_renderer = self.ui_top_renderer
	ingame_ui_context.ingame_ui = self
	self.peer_id = ingame_ui_context.peer_id
	self.ingame_hud = IngameHud:new(ingame_ui_context)
	self.countdown_ui = LevelCountdownUI:new(ingame_ui_context)
	self.popup_join_lobby_handler = PopupJoinLobbyHandler:new(ingame_ui_context)
	self.is_in_inn = ingame_ui_context.is_in_inn
	self.is_server = ingame_ui_context.is_server
	self.last_resolution_x, self.last_resolution_y = Application.resolution()

	InitVideo()

	self.ingame_menu = IngameView:new(ingame_ui_context)
	self.views = {
		profile_view = ProfileView:new(ingame_ui_context),
		lobby_browser_view = LobbyBrowseView:new(ingame_ui_context),
		credits_view = CreditsView:new(ingame_ui_context),
		inventory_view = InventoryView:new(ingame_ui_context),
		lorebook_view = LorebookView:new(ingame_ui_context),
		unlock_key_view = UnlockKeyView:new(ingame_ui_context),
		forge_view = ForgeView:new(ingame_ui_context),
		telemetry_survey = TelemetrySurveyView:new(ingame_ui_context),
		options_view = (Application.platform() == "win32" and OptionsView:new(ingame_ui_context)) or nil,
		map_view = MapView:new(ingame_ui_context),
		friends_view = FriendsView:new(ingame_ui_context),
		altar_view = AltarView:new(ingame_ui_context)
	}
	local backend_settings = GameSettingsDevelopment.backend_settings

	if backend_settings.quests_enabled then
		self.views.quest_view = QuestView:new(ingame_ui_context)
	end

	self._quests_enabled = backend_settings.quests_enabled
	self.hotkey_mapping = {
		hotkey_map = {
			view = "map_view",
			can_interact_flag = "map_interaction_enabled",
			in_transition = "map_view_force",
			in_transition_menu = "map_menu"
		},
		hotkey_forge = {
			can_interact_func = "is_forge_unlocked",
			in_transition = "forge_view_force",
			error_message = "matchmaking_ready_interaction_message_forge",
			view = "forge_view",
			in_transition_menu = "forge_view"
		},
		hotkey_altar = {
			can_interact_func = "is_altar_unlocked",
			in_transition = "altar_view_force",
			error_message = "dlc1_1_matchmaking_ready_interaction_message_altar",
			view = "altar_view",
			in_transition_menu = "altar_view"
		},
		hotkey_journal = {
			view = "lorebook_view",
			can_interact_func = "is_lorebook_enabled",
			in_transition = "lorebook_view_force",
			in_transition_menu = "lorebook_view"
		},
		hotkey_inventory = {
			view = "inventory_view",
			error_message = "matchmaking_ready_interaction_message_inventory",
			in_transition = "inventory_view_force",
			in_transition_menu = "inventory_view"
		},
		hotkey_lobby_browser = {
			view = "lobby_browser_view",
			in_transition = "lobby_browser_view_force",
			in_transition_menu = "lobby_browser_view"
		},
		hotkey_quests = {
			can_interact_func = "is_quests_unlocked",
			in_transition = "quest_view_force",
			error_message = "dlc1_3_1_matchmaking_ready_interaction_message_quests",
			view = "quest_view",
			in_transition_menu = "quest_view"
		}
	}
	self.end_screen = EndScreenUI:new(ingame_ui_context)
	self.voting_manager = ingame_ui_context.voting_manager
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

	self.telemetry_time_view_enter = 0

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
	if not self._quests_enabled then
		return false
	end

	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local can_use = ProgressionUnlocks.is_unlocked("altar", level, prestige)

	return can_use
end
script_data.lorebook_enabled = script_data.lorebook_enabled or Development.parameter("lorebook_enabled")
IngameUI.is_lorebook_enabled = function (self)
	if not script_data.lorebook_enabled then
		return false
	end

	return true
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

	if self.menu_active or self.current_view then
		ShowCursorStack.pop()
	end

	if self.current_view then
		self.views[self.current_view]:on_exit()

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

	self.popup_join_lobby_handler:destroy()

	self.popup_join_lobby_handler = nil

	UIRenderer.destroy(self.ui_renderer, self.world)
	UIRenderer.destroy(self.ui_top_renderer, self.top_world)

	self.ui_renderer = nil
	self.ui_top_renderer = nil

	self.world_manager:destroy_world(self.world)

	if self.popup_id then
		Managers.popup:cancel_popup(self.popup_id)
	end

	return 
end
IngameUI.handle_menu_hotkeys = function (self, dt, input_service, hotkeys_enabled, menu_active)
	if not hotkeys_enabled then
		return 
	end

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
					local return_to_game = not menu_active

					views[current_view]:exit(return_to_game)

					break
				end
			else
				local new_view = views[mapping_data.view]
				local can_interact_flag = mapping_data.can_interact_flag
				local can_interact_func = mapping_data.can_interact_func
				local can_interact = true

				if can_interact_flag and not new_view[can_interact_flag] then
					can_interact = false
				end

				if can_interact and can_interact_func and not self[can_interact_func](self) then
					can_interact = false
				end

				if can_interact and input_service.get(input_service, input) then
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

	return 
end
IngameUI.update = function (self, dt, t, disable_ingame_ui, end_of_level_ui)
	Profiler.start("IngameUI")

	local views = self.views
	local is_in_inn = self.is_in_inn
	local menu_suspended = self.menu_suspended
	local input_service = self.input_manager:get_service("ingame_menu")
	local end_screen_active = self.end_screen_active(self)
	local ingame_hud = self.ingame_hud
	local input_helper_ui = ingame_hud.input_helper_ui
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

	Profiler.stop()

	if self.survey_active then
		self._survey_update(self, dt)
	end

	local hud_should_be_visible = not self.menu_active and not self.current_view and not countdown_ui.is_enter_game(countdown_ui) and not disable_ingame_ui and not end_of_level_ui and not end_screen.is_active
	local hud_is_visible = self.hud_is_visible

	if hud_should_be_visible ~= hud_is_visible then
		self.hud_is_visible = hud_should_be_visible

		ingame_hud.set_visible(ingame_hud, hud_should_be_visible)
	end

	if not disable_ingame_ui then
		if self.current_view then
			local current_view = self.current_view

			Profiler.start(current_view)
			views[current_view]:update(dt, t)
			Profiler.stop()
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
				Profiler.stop()
			end

			local gdc_build = Development.parameter("gdc")

			if not self.pending_transition(self) and not end_screen_active and not self.menu_active and not self.leave_game and not gdc_build and not self.popup_join_lobby_handler.visible and not input_helper_ui.active and input_service.get(input_service, "toggle_menu", true) then
				self.handle_transition(self, "ingame_menu")

				MOOD_BLACKBOARD.menu = true
			end
		end

		if not self.pending_transition(self) then
			Profiler.start("hotkeys")

			local local_player = Managers.player:local_player()
			local player_unit = local_player and local_player.player_unit

			if player_unit and Unit.alive(player_unit) then
				local enable_hotkeys = is_in_inn and not end_screen_active and not disable_ingame_ui and not end_of_level_ui and not input_helper_ui.active

				self.handle_menu_hotkeys(self, dt, input_service, enable_hotkeys, self.menu_active)
			end

			Profiler.stop()
		end

		Profiler.start("Countdown UI")
		countdown_ui.update(countdown_ui, dt)
		Profiler.stop()
		Profiler.start("matchmaking")
		self.matchmaking_ui:update(dt, t)
		Profiler.stop()
		Profiler.start("popup_handler")
		self.popup_join_lobby_handler:update(dt)
		Profiler.stop()
		Profiler.start("endscreen")
		end_screen.update(end_screen, dt)
		Profiler.stop()

		if not end_of_level_ui and not end_screen.is_active then
			Profiler.start("cutscene_ui")
			self.cutscene_ui:update(dt)
			Profiler.stop()

			if hud_should_be_visible then
				self._update_ingame_hud(self, dt, t)
			end
		end
	end

	Profiler.stop()
	self._update_chat_ui(self, dt, t, input_service, end_of_level_ui)
	self._render_debug_ui(self, dt, t)
	self._update_fade_transition(self)

	return 
end
IngameUI.post_update = function (self, dt, t, disable_ingame_ui)
	self._post_handle_transition(self)

	local current_view = self.current_view

	if current_view then
		local views = self.views

		if views[current_view].post_update then
			views[current_view]:post_update(dt, t)
		end
	end

	local cutscene_system = self.cutscene_system
	local active_cutscene = (cutscene_system.active_camera or self.popup_join_lobby_handler.visible) and not cutscene_system.ingame_hud_enabled
	local is_enter_game = self.countdown_ui:is_enter_game()
	local end_screen = self.end_screen
	local menu_active = self.menu_active

	if not disable_ingame_ui and not menu_active and not current_view and not is_enter_game and not end_screen.active then
		self.ingame_hud:post_update(dt, t, active_cutscene)
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
IngameUI._update_ingame_hud = function (self, dt, t)
	local cutscene_system = self.cutscene_system
	local active_cutscene = (cutscene_system.active_camera or self.popup_join_lobby_handler.visible) and not cutscene_system.ingame_hud_enabled

	self.ingame_hud:update(dt, t, active_cutscene)

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

	Profiler.stop()

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
local telemetry_data = {}

local function _add_view_enter_telemetry(player_id, hero, view_name)
	table.clear(telemetry_data)

	telemetry_data.player_id = player_id
	telemetry_data.hero = hero
	telemetry_data.view_name = view_name

	Managers.telemetry:register_event("ui_view_enter", telemetry_data)

	return 
end

local function _add_view_exit_telemetry(player_id, hero, view_name, duration)
	table.clear(telemetry_data)

	telemetry_data.player_id = player_id
	telemetry_data.hero = hero
	telemetry_data.view_name = view_name
	telemetry_data.shown_duration = duration

	Managers.telemetry:register_event("ui_view_exit", telemetry_data)

	return 
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

		Managers.chat:add_local_system_message(channel_id, localized_message, pop_chat)

		self.last_sent_system_message = message
		self.system_message_delay = 1.5
	end

	return 
end
IngameUI.is_transition_allowed = function (self, transition)
	local error_message = nil
	local transition_allowed = true
	local player_ready_for_game = self.is_local_player_ready_for_game(self)

	if player_ready_for_game then
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
		old_view.post_update_on_exit(old_view, unpack(transition_params))
	end

	local new_view = self.views[self.current_view]

	if new_view and new_view.post_update_on_enter then
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
	local old_view = self.current_view

	transitions[new_transition](self, unpack(transition_params))

	local new_view = self.current_view

	if old_view ~= new_view then
		if self.views[old_view] and self.views[old_view].on_exit then
			self.views[old_view]:on_exit(unpack(transition_params))
		end

		if GameSettingsDevelopment.use_telemetry then
			local player_manager = Managers.player
			local time_manager = Managers.time
			local player = player_manager.local_player(player_manager)
			local player_id = player.telemetry_id(player)
			local curr_t = time_manager.time(time_manager, "game")

			if self.views[old_view] then
				local duration = curr_t - self.telemetry_view_enter_time
				local old_hero = self.telemetry_view_enter_hero

				_add_view_exit_telemetry(player_id, old_hero, old_view, duration)
			end

			if new_view and self.views[new_view] and self.views[new_view].on_enter then
				local hero = player.profile_display_name(player)
				self.telemetry_view_enter_time = curr_t
				self.telemetry_view_enter_hero = hero

				_add_view_enter_telemetry(player_id, hero, new_view)
			end
		end

		if new_view and self.views[new_view] and self.views[new_view].on_enter then
			self.views[new_view]:on_enter(unpack(transition_params))
		end
	end

	self.new_transition = new_transition
	self.new_transition_old_view = old_view
	self.transition_params = transition_params
	self._previous_transition = new_transition

	return 
end
IngameUI.transition_with_fade = function (self, new_transition, ...)
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
	return self._transition_fade_data ~= nil
end
IngameUI.get_transition = function (self)
	if self.leave_game then
		return "leave_game"
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
	local use_survey = GameSettingsDevelopment.use_session_survey

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
IngameUI.show_input_helper = function (self)
	local input_helper_ui = self.ingame_hud.input_helper_ui

	if input_helper_ui.show_at_startup then
		input_helper_ui.display_first_time(input_helper_ui)
	end

	return 
end
local debug_font = "arial_18"
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
	local platform = Application.platform()

	if platform == "ps4" or platform == "xb1" then
		red_cap = 20
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
