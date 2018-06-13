local transitions = {
	leave_group = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local network_server = Managers.state.network.network_server

		if network_server and not network_server:are_all_peers_ingame() then
			local text = Localize("player_join_block_exit_game")
			self.popup_id = Managers.popup:queue_popup(text, Localize("popup_error_topic"), "cancel_popup", Localize("menu_ok"))
		else
			local text = Localize("leave_game_popup_text")
			self.popup_id = Managers.popup:queue_popup(text, Localize("popup_leave_game_topic"), "leave_game", Localize("popup_choice_yes"), "cancel_popup", Localize("popup_choice_no"))
		end
	end,
	quit_game = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local text = Localize("exit_game_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("popup_exit_game_topic"), "end_game", Localize("popup_choice_yes"), "cancel_popup", Localize("popup_choice_no"))
	end,
	return_to_title_screen = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local network_server = Managers.state.network.network_server

		if network_server and not network_server:are_all_peers_ingame() then
			local text = Localize("player_join_block_exit_game")
			self.popup_id = Managers.popup:queue_popup(text, Localize("popup_error_topic"), "cancel_popup", Localize("menu_ok"))
		else
			local text = Localize("exit_game_popup_text_xb1")
			self.popup_id = Managers.popup:queue_popup(text, Localize("popup_exit_game_topic_xb1"), "do_return_to_title_screen", Localize("popup_choice_yes"), "cancel_popup", Localize("popup_choice_no"))
		end
	end,
	prestige = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local text = Localize("prestige_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("prestige_game_topic"), "prestige_confirmation", Localize("popup_choice_yes"), "cancel_prestige_popup", Localize("popup_choice_no"))
	end,
	prestige_confirmation = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local text = Localize("prestige_confirmation_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("prestige_game_topic"), "accept_prestige_confirmation", Localize("popup_choice_yes"), "cancel_prestige_popup", Localize("popup_choice_no"))
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
	end,
	end_game = function (self)
		self.input_manager:block_device_except_service(nil, "keyboard", 1)
		self.input_manager:block_device_except_service(nil, "mouse", 1)
		self.input_manager:block_device_except_service(nil, "gamepad", 1)

		local telemetry_survey_view = self.views.telemetry_survey
		local level_key = Managers.state.game_mode:level_key()
		local use_survey = TelemetrySettings.send and TelemetrySettings.use_session_survey
		local is_answered = telemetry_survey_view:is_survey_answered()
		local is_timed_out = telemetry_survey_view:is_survey_timed_out()

		if (use_survey and (is_answered or is_timed_out)) or not use_survey or level_key == "inn_level" then
			Boot.quit_game = true
			self.current_view = nil
		else
			self.current_view = "telemetry_survey"

			telemetry_survey_view:set_transition("end_game")
		end
	end,
	do_return_to_title_screen = function (self)
		self.return_to_title_screen = true
	end,
	leave_game = function (self)
		if self.popup_id then
			Managers.popup:cancel_popup(self.popup_id)
		end

		local network_server = Managers.state.network.network_server

		if network_server and not network_server:are_all_peers_ingame() then
			local text = Localize("player_join_block_exit_game")
			self.popup_id = Managers.popup:queue_popup(text, Localize("popup_error_topic"), "cancel_popup", Localize("menu_ok"))
		else
			self.input_manager:block_device_except_service(nil, "keyboard", 1)
			self.input_manager:block_device_except_service(nil, "mouse", 1)
			self.input_manager:block_device_except_service(nil, "gamepad", 1)

			self.leave_game = true
		end
	end,
	lobby_browser_view = function (self)
		self.current_view = "lobby_browser_view"
		self.views[self.current_view].exit_to_game = true
	end,
	lobby_browser_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "lobby_browser_view"
		self.views[self.current_view].exit_to_game = true
	end,
	profile_view = function (self)
		self.current_view = "profile_view"
	end,
	ingame_menu = function (self)
		if not self.menu_active then
			self.ingame_menu:on_enter()

			self.menu_active = true

			ShowCursorStack.push()
			self:play_sound("Play_hud_button_open")
		end

		self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
		self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)

		self.current_view = nil
	end,
	inventory_view = function (self)
		self.current_view = "inventory_view"
	end,
	lorebook_view = function (self)
		self.current_view = "lorebook_view"
	end,
	lorebook_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "lorebook_view"
		self.views[self.current_view].exit_to_game = true
	end,
	map_menu = function (self)
		self.current_view = "map_view"
	end,
	map_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "map_view"
		self.views[self.current_view].exit_to_game = true
	end,
	inventory_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "inventory_view"
		self.views[self.current_view].exit_to_game = true
	end,
	forge_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "forge_view"
		self.views[self.current_view].exit_to_game = true
	end,
	forge_view = function (self)
		self.current_view = "forge_view"
	end,
	friends_view = function (self)
		self.current_view = "friends_view"
	end,
	altar_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "altar_view"
		self.views[self.current_view].exit_to_game = true
	end,
	altar_view = function (self)
		self.current_view = "altar_view"
	end,
	quest_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "quest_view"
		self.views[self.current_view].exit_to_game = true
	end,
	quest_view = function (self)
		self.current_view = "quest_view"
	end,
	friends_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "friends_view"
		self.views[self.current_view].exit_to_game = true
	end,
	initial_profile_view_force = function (self)
		self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
		self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)
		ShowCursorStack.push()

		self.current_view = "profile_view"
		self.initial_profile_view = true
		self.views[self.current_view].exit_to_game = true
	end,
	profile_view_force = function (self)
		ShowCursorStack.push()

		self.current_view = "profile_view"
		self.views[self.current_view].exit_to_game = true
	end,
	unlock_key_force = function (self)
		ShowCursorStack.push()

		self.current_view = "unlock_key_view"
		self.views[self.current_view].exit_to_game = true
	end,
	join_lobby = function (self, lobby_client)
		self.input_manager:block_device_except_service(nil, "keyboard", 1)
		self.input_manager:block_device_except_service(nil, "mouse", 1)
		self.input_manager:block_device_except_service(nil, "gamepad", 1)

		self.join_lobby = lobby_client

		ShowCursorStack.pop()

		self.menu_active = false
		self.current_view = nil
	end,
	exit_menu = function (self)
		if self.current_view or self.menu_active then
			ShowCursorStack.pop()
		end

		if self.menu_active then
			self:play_sound("Play_hud_button_close")
		end

		if not self.countdown_ui:is_enter_game() and not Managers.chat:chat_is_focused() and not Managers.matchmaking:is_join_popup_visible() then
			self.input_manager:device_unblock_all_services("keyboard", 1)
			self.input_manager:device_unblock_all_services("mouse", 1)
			self.input_manager:device_unblock_all_services("gamepad", 1)
		end

		self.menu_active = false
		self.current_view = nil
		MOOD_BLACKBOARD.menu = false
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
	end,
	cancel_popup = function (self)
		self.popup_id = nil

		self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
		self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)
	end,
	cancel_prestige_popup = function (self)
		self.popup_id = nil
	end,
	credits_menu = function (self)
		self.current_view = "credits_view"
	end,
	options_menu = function (self)
		self.input_manager:block_device_except_service("options_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("options_menu", "mouse", 1)
		self.input_manager:block_device_except_service("options_menu", "gamepad", 1)

		self.current_view = "options_view"
	end,
	lorebook_menu = function (self)
		self.input_manager:block_device_except_service("lorebook_menu", "keyboard", 1)
		self.input_manager:block_device_except_service("lorebook_menu", "mouse", 1)
		self.input_manager:block_device_except_service("lorebook_menu", "gamepad", 1)

		self.current_view = "lorebook_view"
	end,
	restart_game = function (self)
		self.input_manager:device_unblock_all_services("keyboard", 1)
		self.input_manager:device_unblock_all_services("mouse", 1)
		self.input_manager:device_unblock_all_services("gamepad", 1)

		self.restart_game = true
	end,
	close_active = function (self)
		local close_menu = false
		local menu_active = self.menu_active
		local view = self.views[self.current_view]

		if view then
			if view.exit then
				view:exit(true)
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
	end
}
view_settings = {
	ingame = {
		ui_renderer_function = function (world)
			if PLATFORM == "win32" then
				return UIRenderer.create(world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_level_images", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			else
				return UIRenderer.create(world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_level_images_console", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			end
		end,
		ui_top_renderer_function = function (top_world)
			if PLATFORM == "win32" then
				return UIRenderer.create(top_world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_level_images", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			else
				return UIRenderer.create(top_world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_level_images_console", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			end
		end,
		views_function = function (ingame_ui_context)
			return {
				credits_view = CreditsView:new(ingame_ui_context),
				inventory_view = InventoryView:new(ingame_ui_context),
				telemetry_survey = TelemetrySurveyView:new(ingame_ui_context),
				options_view = OptionsView:new(ingame_ui_context),
				friends_view = FriendsView:new(ingame_ui_context)
			}
		end,
		hotkey_mapping = {},
		blocked_transitions = {
			altar_view = true,
			profile_view = true,
			forge_view_force = true,
			altar_view_force = true,
			lorebook_view = true,
			initial_profile_view_force = true,
			forge_view = true,
			quest_view = true,
			profile_view_force = true,
			quest_view_force = true,
			lorebook_view_force = true
		}
	},
	inn = {
		ui_renderer_function = function (world)
			if PLATFORM == "win32" then
				return UIRenderer.create(world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn", "material", "materials/ui/ui_1080p_level_images", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			else
				return UIRenderer.create(world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn_console", "material", "materials/ui/ui_1080p_level_images_console", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts", "material", "video/dwarfs_trailer", "material", "video/stromdorf_trailer", "material", "video/survival_ruins_trailer", "material", "video/reikwald_trailer", "material", "video/drachenfels_trailer")
			end
		end,
		ui_top_renderer_function = function (top_world)
			if PLATFORM == "win32" then
				return UIRenderer.create(top_world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn", "material", "materials/ui/ui_1080p_level_images", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			else
				return UIRenderer.create(top_world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn_console", "material", "materials/ui/ui_1080p_level_images_console", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			end
		end,
		views_function = function (ingame_ui_context)
			return {
				profile_view = ProfileView:new(ingame_ui_context),
				lobby_browser_view = (GameSettingsDevelopment.lobby_browser_enabled and LobbyBrowseView:new(ingame_ui_context)) or nil,
				credits_view = CreditsView:new(ingame_ui_context),
				inventory_view = InventoryView:new(ingame_ui_context),
				lorebook_view = (GameSettingsDevelopment.lorebook_enabled and LorebookView:new(ingame_ui_context)) or nil,
				unlock_key_view = UnlockKeyView:new(ingame_ui_context),
				forge_view = ForgeView:new(ingame_ui_context),
				telemetry_survey = TelemetrySurveyView:new(ingame_ui_context),
				options_view = OptionsView:new(ingame_ui_context),
				map_view = (PLATFORM == "win32" and MapView:new(ingame_ui_context)) or ConsoleMapView:new(ingame_ui_context),
				friends_view = FriendsView:new(ingame_ui_context),
				altar_view = AltarView:new(ingame_ui_context),
				quest_view = (GameSettingsDevelopment.backend_settings.quests_enabled and QuestView:new(ingame_ui_context)) or nil
			}
		end,
		hotkey_mapping = {
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
				can_interact_func = "is_lorebook_enabled",
				in_transition = "lorebook_view_force",
				error_message = "dlc1_3_matchmaking_ready_interaction_message_lorebook",
				view = "lorebook_view",
				in_transition_menu = "lorebook_view"
			},
			hotkey_inventory = {
				view = "inventory_view",
				error_message = "matchmaking_ready_interaction_message_inventory",
				in_transition = "inventory_view_force",
				in_transition_menu = "inventory_view"
			},
			hotkey_lobby_browser = (GameSettingsDevelopment.lobby_browser_enabled and {
				view = "lobby_browser_view",
				can_interact_func = "can_view_lobby_browser",
				in_transition = "lobby_browser_view_force",
				in_transition_menu = "lobby_browser_view"
			}) or nil,
			hotkey_quests = (GameSettingsDevelopment.backend_settings.quests_enabled and {
				can_interact_func = "is_quests_unlocked",
				in_transition = "quest_view_force",
				error_message = "dlc1_3_1_matchmaking_ready_interaction_message_quests",
				view = "quest_view",
				in_transition_menu = "quest_view"
			}) or nil
		},
		blocked_transitions = {}
	},
	development = {
		ui_renderer_function = function (world)
			if PLATFORM == "win32" then
				return UIRenderer.create(world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn", "material", "materials/ui/ui_1080p_level_images", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			else
				return UIRenderer.create(world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn_console", "material", "materials/ui/ui_1080p_level_images_console", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			end
		end,
		ui_top_renderer_function = function (top_world)
			if PLATFORM == "win32" then
				return UIRenderer.create(top_world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn", "material", "materials/ui/ui_1080p_level_images", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			else
				return UIRenderer.create(top_world, "material", "materials/ui/end_screen_banners/end_screen_banners", "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame_inn_console", "material", "materials/ui/ui_1080p_level_images_console", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_chat", "material", "materials/fonts/gw_fonts")
			end
		end,
		views_function = function (ingame_ui_context)
			return {
				profile_view = ProfileView:new(ingame_ui_context),
				lobby_browser_view = LobbyBrowseView:new(ingame_ui_context),
				credits_view = CreditsView:new(ingame_ui_context),
				inventory_view = InventoryView:new(ingame_ui_context),
				lorebook_view = LorebookView:new(ingame_ui_context),
				unlock_key_view = UnlockKeyView:new(ingame_ui_context),
				forge_view = ForgeView:new(ingame_ui_context),
				telemetry_survey = TelemetrySurveyView:new(ingame_ui_context),
				options_view = OptionsView:new(ingame_ui_context),
				map_view = (PLATFORM == "win32" and MapView:new(ingame_ui_context)) or ConsoleMapView:new(ingame_ui_context),
				friends_view = FriendsView:new(ingame_ui_context),
				altar_view = AltarView:new(ingame_ui_context),
				quest_view = (GameSettingsDevelopment.backend_settings.quests_enabled and QuestView:new(ingame_ui_context)) or nil
			}
		end,
		hotkey_mapping = {
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
				can_interact_func = "is_lorebook_enabled",
				in_transition = "lorebook_view_force",
				error_message = "dlc1_3_matchmaking_ready_interaction_message_lorebook",
				view = "lorebook_view",
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
				can_interact_func = "can_view_lobby_browser",
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
		},
		blocked_transitions = {}
	}
}

return {
	transitions = transitions,
	view_settings = view_settings
}
