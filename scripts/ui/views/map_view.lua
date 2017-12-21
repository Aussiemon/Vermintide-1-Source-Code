-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
require("scripts/ui/views/friends_view")
require("scripts/settings/experience_settings")
require("scripts/settings/area_settings")
require("scripts/ui/views/menu_input_description_ui")
require("scripts/ui/views/map_view_helper")
require("scripts/ui/views/map_view_area_handler")

local definitions = local_require("scripts/ui/views/map_view_definitions")
local MapWidgetsGamepadController = MapWidgetsGamepadController
local generic_input_actions = definitions.generic_input_actions
local player_name_max_length = 22
local DO_RELOAD = false
local MAX_NUMBER_OF_PLAYERS = 4
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
local host_game_options = {
	"auto",
	"always",
	"never"
}
local host_game_options_order_by_name = {
	auto = 1,
	never = 3,
	always = 2
}
local host_game_settings_display_names = {
	auto = "map_host_option_1",
	never = "map_host_option_3",
	always = "map_host_option_2"
}
local privacy_settings = {
	"online",
	"private"
}
local privacy_settings_display_names = {
	online = "privacy_setting_online",
	private = "privacy_setting_private"
}
local hero_search_options = {
	"witch_hunter",
	"wood_elf",
	"dwarf_ranger",
	"bright_wizard",
	"empire_soldier"
}
local search_zone_options = {
	"auto",
	"close",
	"medium",
	"far",
	"world"
}
local search_zone_options_order_by_name = {
	auto = 1,
	world = 5,
	far = 4,
	medium = 3,
	close = 2
}
local search_zone_settings_display_names = {
	auto = "map_zone_options_1",
	world = "map_zone_options_5",
	far = "map_zone_options_4",
	medium = "map_zone_options_3",
	close = "map_zone_options_2"
}
local ready_settings_display_names = {
	"menu_settings_off",
	"menu_settings_on"
}
local ready_options = {
	false,
	true
}
local game_mode_options = {
	"adventure",
	"survival"
}
local game_mode_display_names = {
	adventure = "dlc1_2_map_game_mode_mission",
	survival = "dlc1_2_map_game_mode_survival"
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
local bar_entry_text_colors = {
	normal = Colors.get_color_table_with_alpha("cheeseburger", 255),
	selected = Colors.get_color_table_with_alpha("white", 255)
}
local start_game_disable_tooltips = {
	players_joining = "map_confirm_button_disabled_tooltip_players_joining",
	wrong_level = "map_confirm_button_disabled_tooltip_level",
	difficulty = "map_confirm_button_disabled_tooltip"
}
MapView = class(MapView)
MapView.init = function (self, ingame_ui_context)
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
	self.lobby = ingame_ui_context.network_lobby
	self.render_settings = {
		snap_pixel_positions = true
	}
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
	self.ui_animations = {}
	self.bar_animations = {}

	if not PlayerData.map_view_data then
		local map_save_data = {
			private_game = false,
			viewed_levels = {}
		}
	end

	self.map_save_data = map_save_data
	self.map_view_helper = MapViewHelper:new(self.statistics_db, player_stats_id)
	self.map_view_area_handler = MapViewAreaHandler:new(ingame_ui_context, map_save_data, player_stats_id)

	self.map_view_area_handler:set_active_area("ubersreik")
	self.create_ui_elements(self)

	self.ui_animator = UIAnimator:new(definitions.scenegraph_definition, definitions.animations)
	self.peer_id = ingame_ui_context.peer_id
	local input_service = input_manager.get_service(input_manager, "map_menu")
	local gui_layer = definitions.scenegraph_definition.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 9, gui_layer, generic_input_actions.default)
	self.map_interaction_enabled = true
	DO_RELOAD = false
	self.nr_level_switches = 0

	self.apply_saved_settings(self)

	local ignore_sound = true
	local saved_game_mode_option = map_save_data.game_mode_option

	if not saved_game_mode_option then
		map_save_data.difficulty_option = nil
		map_save_data.last_selected_level_key = nil
	end

	local game_mode_index = (saved_game_mode_option and table.find(game_mode_options, saved_game_mode_option)) or 1

	self.set_selected_game_mode(self, game_mode_index, ignore_sound)
	self.set_privacy_enabled(self, map_save_data.private_enabled or false)

	local selected_level_key, selected_level_information, selected_level_index = self.map_view_area_handler:selected_level()

	if selected_level_index and self.selected_level_index ~= selected_level_index then
		self.on_level_index_changed(self, nil, selected_level_index)
	end

	return 
end
MapView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	local selected_game_mode = game_mode_options[self.selected_game_mode_index]
	local widgets = definitions.widgets
	self.gamepad_button_selection_widget = UIWidget.init(widgets.gamepad_button_selection)
	self.play_button_console_widget = UIWidget.init(widgets.play_button_console)
	self.lobby_button_widget = UIWidget.init(widgets.lobby_button)
	self.cancel_button_widget = UIWidget.init(widgets.cancel_button)
	self.confirm_button_widget = UIWidget.init(widgets.confirm_button)
	self.friends_button_widget = UIWidget.init(widgets.friends_button)
	self.settings_button_widget = UIWidget.init(widgets.settings_button)
	self.game_mode_selection_bar_widget = UIWidget.init(widgets.game_mode_selection_bar)
	self.game_mode_selection_bar_bg_widget = UIWidget.init(widgets.game_mode_selection_bar_bg)
	self.title_text_widget = UIWidget.init(widgets.title_text)
	self.level_preview_widget = UIWidget.init(widgets.level_preview)
	self.description_field_widget = UIWidget.init(widgets.description_field)
	self.private_checkbox_widget = UIWidget.init(widgets.private_checkbox)
	self.hero_search_filter_widget = UIWidget.init(widgets.wanted_hero_list)
	self.difficulty_unlock_icon_widget = UIWidget.init(UIWidgets.create_lock_icon("difficulty_stepper_unlock_icon", ""))
	self.player_list_conuter_text_widget = UIWidget.init(widgets.player_list_conuter_text)
	self.button_eye_glow_widget = UIWidget.init(widgets.button_eye_glow_widget)
	self.confirm_button_disabled_tooltip_widget = UIWidget.init(widgets.confirm_button_disabled_tooltip)
	self.level_preview_text_widget = UIWidget.init(widgets.level_preview_text)
	self.steppers = self.setup_steppers(self)
	self.description_text_widgets = {
		description_background = UIWidget.init(widgets.description_background),
		title = UIWidget.init(widgets.description_title),
		description = UIWidget.init(widgets.description_text),
		input_description_text = UIWidget.init(widgets.input_description_text)
	}
	self.player_list_widgets = {
		UIWidget.init(widgets.player_list_slot_1),
		UIWidget.init(widgets.player_list_slot_2),
		UIWidget.init(widgets.player_list_slot_3),
		UIWidget.init(widgets.player_list_slot_4)
	}
	self.normal_settings_widget_types = {
		adventure = {
			stepper_level = self.steppers.level.widget,
			stepper_difficulty = self.steppers.difficulty.widget,
			level_preview = self.level_preview_widget,
			level_preview_text = self.level_preview_text_widget,
			difficulty_lock = self.difficulty_unlock_icon_widget,
			banner_difficulty = UIWidget.init(widgets.banner_difficulty_widget),
			banner_level = UIWidget.init(widgets.banner_level_widget)
		},
		survival = {
			stepper_level = self.steppers.level.widget,
			stepper_difficulty = self.steppers.difficulty.widget,
			level_preview = self.level_preview_widget,
			level_preview_text = self.level_preview_text_widget,
			difficulty_lock = self.difficulty_unlock_icon_widget,
			banner_difficulty = UIWidget.init(widgets.banner_difficulty_widget),
			banner_level = UIWidget.init(widgets.banner_level_widget),
			banner_performance = UIWidget.init(widgets.banner_performance),
			best_performance_1 = UIWidget.init(widgets.best_performance_1),
			best_performance_2 = UIWidget.init(widgets.best_performance_2),
			best_performance_3 = UIWidget.init(widgets.best_performance_3),
			performance_window = UIWidget.init(widgets.performance_window),
			performance_window_icon = UIWidget.init(widgets.performance_window_icon)
		}
	}
	self.normal_settings_widgets = self.normal_settings_widget_types[game_mode_options[1]]
	self.advanced_settings_widgets = {
		banner_search_zone = UIWidget.init(widgets.banner_search_zone),
		banner_hero_list = UIWidget.init(widgets.banner_hero_list),
		banner_host_setting = UIWidget.init(widgets.banner_host_setting),
		hero_search_filter = self.hero_search_filter_widget,
		stepper_host_setting = self.steppers.host.widget,
		stepper_search_zone = self.steppers.zone.widget
	}
	self.gamepad_settings_widgets = {
		normal = {
			{
				widget = self.normal_settings_widgets.stepper_level,
				data = MapWidgetsGamepadController.level_stepper
			},
			{
				widget = self.normal_settings_widgets.stepper_difficulty,
				data = MapWidgetsGamepadController.stepper
			}
		},
		advanced = {
			{
				widget = self.advanced_settings_widgets.stepper_search_zone,
				data = MapWidgetsGamepadController.stepper
			},
			{
				widget = self.advanced_settings_widgets.hero_search_filter,
				data = MapWidgetsGamepadController.hero_filter
			},
			{
				widget = self.advanced_settings_widgets.stepper_host_setting,
				data = MapWidgetsGamepadController.stepper
			}
		}
	}
	self.gamepad_player_list_widgets = {
		player_list = {
			{
				widget = self.player_list_widgets[1],
				data = MapWidgetsGamepadController.player_entry
			},
			{
				widget = self.player_list_widgets[2],
				data = MapWidgetsGamepadController.player_entry
			},
			{
				widget = self.player_list_widgets[3],
				data = MapWidgetsGamepadController.player_entry
			},
			{
				widget = self.player_list_widgets[4],
				data = MapWidgetsGamepadController.player_entry
			}
		}
	}
	self.background_widgets = {
		definitions.create_simple_texture_widget("map_screen_bg", "frame"),
		UIWidget.init(widgets.dead_space_filler),
		UIWidget.init(widgets.banner_party_widget)
	}
	self.background_overlay_console_widget = definitions.create_simple_texture_widget("console_input_field_overlay", "frame_console_overlay")
	self.confirm_button_widget.content.text_field = Localize("map_screen_confirm_button")

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_animations.eye_glow = UIAnimation.init(UIAnimation.pulse_animation, self.button_eye_glow_widget.style.texture_id.color, 1, 150, 255, 2)

	return 
end
MapView.set_friends_view = function (self, friends_view)
	self.friends = friends_view

	return 
end
MapView.update = function (self, dt, t)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if self.suspended then
		return 
	end

	self.calculate_ui_spawn_time(self, dt)

	if not self.menu_active then
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

	if draw_intro_description then
		local description_text_widgets = self.description_text_widgets
		description_text_widgets.input_description_text.content.text = (gamepad_active and "press_any_button_to_continue") or "press_any_key_to_continue"
		input_service = fake_input_service

		if input_manager.any_input_pressed(input_manager) then
			self.draw_intro_description = false
			self.survival_info_shown = true
		end
	end

	if self._xbox_trying_to_open_invite_friends then
		self._update_invite_friends(self)
	end

	if self.popup_id then
		local popup_result = Managers.popup:query_result(self.popup_id)

		if popup_result then
			self.handle_popup_result(self, popup_result)
		end
	end

	for name, animation in pairs(self.ui_animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.ui_animations[name] = nil
		end
	end

	if not friends_menu_active and not transitioning then
		if map_view_area_handler.area_changed(map_view_area_handler) then
			self.clear_level_selection(self)
		end

		map_view_area_handler.update(map_view_area_handler, input_service, dt)
		self.ui_animator:update(dt)

		local selected_game_mode_index = self.selected_game_mode_index

		if selected_game_mode_index then
			local game_mode_selection_bar_widget = self.game_mode_selection_bar_widget
			local game_mode_bar_content = game_mode_selection_bar_widget.content
			self.character_profile_changed = nil

			for i = 1, #game_mode_options, 1 do
				if game_mode_bar_content[i].on_pressed and i ~= selected_game_mode_index then
					self.play_sound(self, "Play_hud_next_tab")
					self.set_selected_game_mode(self, i)

					break
				end
			end

			self.update_button_bar_animation(self, game_mode_selection_bar_widget, "game_mode", dt)
		end

		local selected_level_key, selected_level_information, selected_level_index = map_view_area_handler.selected_level(map_view_area_handler)

		if selected_level_index and self.selected_level_index ~= selected_level_index then
			self.on_level_index_changed(self, nil, selected_level_index)

			self._preview_level_index = nil
		end

		local level_hover_index = map_view_area_handler.level_hover_index(map_view_area_handler)

		if level_hover_index and self._preview_level_index ~= level_hover_index then
			local selected_level_index = self.selected_level_index

			self.on_level_index_changed(self, nil, level_hover_index, true, true)

			self._preview_level_index = level_hover_index
			self.selected_level_index = selected_level_index
		elseif not level_hover_index and self._preview_level_index and self.selected_level_index then
			self._preview_level_index = nil

			self.on_level_index_changed(self, nil, self.selected_level_index, nil, true)
		end

		if gamepad_active then
			if not self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = true

				self.on_gamepad_activated(self)
			end

			if not draw_intro_description then
				self.handle_gamepad_navigation_input(self, dt)
			end
		elseif self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = false

			self.on_gamepad_deactivated(self)
		end

		self.update_player_list(self)
	end

	if self.wwise_playing_id and not WwiseWorld.is_playing(self.wwise_world, self.wwise_playing_id) then
		local subtitle_gui = self.ingame_ui.ingame_hud.subtitle_gui

		subtitle_gui.stop_subtitle(subtitle_gui, self.dialogue_speaker)

		self.wwise_playing_id = nil
		self.dialogue_speaker = nil
		self.playing_wwise_event = nil
	end

	if not transitioning then
		if not friends_menu_active then
			local confirm_button_widget = self.confirm_button_widget
			local confirm_button_hotspot = confirm_button_widget.content.button_hotspot
			local cancel_button_widget = self.cancel_button_widget
			local cancel_button_hotspot = cancel_button_widget.content.button_hotspot
			local settings_button_widget = self.settings_button_widget
			local settings_button_hotspot = settings_button_widget.content.button_hotspot
			local friends_button_widget = self.friends_button_widget
			local friends_button_hotspot = friends_button_widget.content.button_hotspot
			local lobby_button_widget = self.lobby_button_widget
			local lobby_button_hotspot = lobby_button_widget.content.button_hotspot

			if confirm_button_hotspot.on_hover_enter or cancel_button_hotspot.on_hover_enter or friends_button_hotspot.on_hover_enter or settings_button_hotspot.on_hover_enter or lobby_button_hotspot.on_hover_enter then
				self.play_sound(self, "Play_hud_hover")
			end

			local play_button_disabled = confirm_button_hotspot.disabled

			if confirm_button_hotspot.on_release or (gamepad_active and input_service.get(input_service, "refresh") and self.selected_level_index) then
				if self.dlc_level_selected then
					self.map_view_area_handler:show_level_store_page(self.selected_level_index)
				elseif not play_button_disabled then
					self.on_play_pressed(self, t)
				end
			elseif input_service.get(input_service, "toggle_menu") or cancel_button_hotspot.on_release then
				local return_to_game = not self.ingame_ui.menu_active

				self.exit(self, return_to_game)
			elseif gamepad_active and input_service.get(input_service, "back") then
				local can_back = self.active_area(self) ~= "world"

				if can_back then
					self.map_view_area_handler:zoom_out()
				else
					local return_to_game = not self.ingame_ui.menu_active

					self.exit(self, return_to_game)
				end
			elseif friends_button_hotspot.on_release or (gamepad_active and input_service.get(input_service, "right_stick_press")) then
				self.play_sound(self, "Play_hud_select")
				self.on_friends_pressed(self)
			elseif settings_button_hotspot.on_release then
				self.play_sound(self, "Play_hud_select")

				settings_button_widget.content.toggled = not settings_button_widget.content.toggled
			elseif lobby_button_hotspot.on_release then
				self.open_lobby_browser(self)
			elseif input_service.get(input_service, "show_gamercard") then
				self._show_selected_player_gamercard(self)
			end

			for stepper_name, stepper_data in pairs(self.steppers) do
				self.handle_stepper_input(self, stepper_name, stepper_data)

				if stepper_name == "difficulty" and self.selected_level_index then
					self.handle_difficulty_hover(self, stepper_data)
				end
			end

			local private_checkbox_widget = self.private_checkbox_widget
			local private_checkbox_hotspot = private_checkbox_widget.content.button_hotspot

			if private_checkbox_hotspot.on_hover_enter then
				self.play_sound(self, "Play_hud_hover")
			end

			if private_checkbox_hotspot.on_release or (gamepad_active and input_service.get(input_service, "special_1")) then
				self.play_sound(self, "Play_hud_select")
				self.set_privacy_enabled(self, not self.privacy_setting_enabled)
			end

			self.update_hero_search_filter_input(self)
		else
			local friends_input_service = input_manager.get_service(input_manager, "friends_view")

			if friends.on_close_button_clicked(friends) or friends_input_service.get(friends_input_service, "toggle_menu") or (gamepad_active and friends_input_service.get(friends_input_service, "back")) then
				self.deactivate_friends_menu(self)
			end
		end
	end

	if self.active then
		self.draw(self, input_service, gamepad_active, dt)
		map_view_area_handler.draw(map_view_area_handler, input_service, gamepad_active, dt)
	end

	self._update_play_button_description(self)

	return 
end
MapView._show_selected_player_gamercard = function (self)
	local number_of_player = self.number_of_player or 0

	for i = 1, number_of_player, 1 do
		local widget = self.player_list_widgets[i]

		if widget.content.button_hotspot.is_selected then
			local peer_id = widget.content.peer_id

			if peer_id then
				local xuid = self.lobby.lobby:xuid(peer_id)

				if xuid then
					XboxLive.show_gamercard(Managers.account:user_id(), xuid)
				end
			end
		end
	end

	return 
end
MapView._update_play_button_description = function (self)
	local players_joined = self.network_server:are_all_peers_ingame()
	local is_difficulty_unlocked = self.difficulty_unlocked
	local is_level_selected = self.selected_level_index ~= nil
	local is_playable_level = self.playable_level
	local tooltip_text = nil

	if not players_joined then
		tooltip_text = start_game_disable_tooltips.players_joining
	elseif not is_playable_level or not is_level_selected then
		tooltip_text = start_game_disable_tooltips.wrong_level
	elseif not is_difficulty_unlocked then
		tooltip_text = start_game_disable_tooltips.difficulty
	end

	local can_play = players_joined and is_playable_level and is_difficulty_unlocked and is_level_selected
	self.confirm_button_widget.content.button_hotspot.disabled = not can_play

	if tooltip_text then
		self.confirm_button_disabled_tooltip_widget.content.tooltip_text = tooltip_text
	end

	return 
end
MapView.draw = function (self, input_service, gamepad_active, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	for _, widget in ipairs(self.background_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	local number_of_player = self.number_of_player or 0

	for i = 1, number_of_player, 1 do
		local widget = self.player_list_widgets[i]

		UIRenderer.draw_widget(ui_renderer, widget)
	end

	if self.settings_button_widget.content.toggled then
		for widget_name, widget in pairs(self.advanced_settings_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	else
		for widget_name, widget in pairs(self.normal_settings_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	UIRenderer.draw_widget(ui_renderer, self.player_list_conuter_text_widget)
	UIRenderer.draw_widget(ui_renderer, self.description_field_widget)
	UIRenderer.draw_widget(ui_renderer, self.title_text_widget)
	UIRenderer.draw_widget(ui_renderer, self.game_mode_selection_bar_widget)
	UIRenderer.draw_widget(ui_renderer, self.game_mode_selection_bar_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self.private_checkbox_widget)

	if not gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.friends_button_widget)
		UIRenderer.draw_widget(ui_renderer, self.settings_button_widget)
		UIRenderer.draw_widget(ui_renderer, self.confirm_button_widget)
		UIRenderer.draw_widget(ui_renderer, self.cancel_button_widget)
		UIRenderer.draw_widget(ui_renderer, self.lobby_button_widget)

		if not self.confirm_button_widget.content.button_hotspot.disabled then
			UIRenderer.draw_widget(ui_renderer, self.button_eye_glow_widget)
		else
			UIRenderer.draw_widget(ui_renderer, self.confirm_button_disabled_tooltip_widget)
		end
	else
		UIRenderer.draw_widget(ui_renderer, self.background_overlay_console_widget)
		UIRenderer.draw_widget(ui_renderer, self.gamepad_button_selection_widget)
	end

	local draw_intro_description = self.draw_intro_description

	if draw_intro_description then
		for key, text_widget in pairs(self.description_text_widgets) do
			UIRenderer.draw_widget(ui_renderer, text_widget)
		end
	end

	UIRenderer.end_pass(ui_renderer)

	local friends_menu_active = self.friends:is_active()

	if gamepad_active and not friends_menu_active and not self.popup_id and not draw_intro_description then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
MapView.save_map_settings = function (self)
	local map_save_data = self.map_save_data
	local selected_index = self.selected_level_index

	if not selected_index then
		return 
	end

	local game_mode = self.active_game_mode(self)
	local level_list = self.active_level_list(self)

	if level_list then
		local level_data = level_list[selected_index]
		local selected_level_key = level_data.level_key
		map_save_data.last_selected_level_key = selected_level_key
		local difficulty_index = self.selected_difficulty_stepper_index

		if difficulty_index then
			local difficulty_data = self.get_difficulty_data(self, selected_index)
			local difficulty_order_name = difficulty_data[difficulty_index].key
			map_save_data.difficulty_option = difficulty_order_name
		end
	end

	local selected_game_mode_index = self.selected_game_mode_index
	local selected_game_mode = game_mode_options[selected_game_mode_index]
	map_save_data.game_mode_option = selected_game_mode
	local selected_zone_option = search_zone_options[self.selected_zone_index]
	map_save_data.zone_option = selected_zone_option
	local selected_host_option = host_game_options[self.selected_host_index]
	map_save_data.host_option = selected_host_option
	local selected_ready_option = ready_options[self.selected_ready_index]
	map_save_data.ready_option = selected_ready_option
	map_save_data.private_enabled = self.privacy_setting_enabled
	map_save_data.hero_search_filter = self.hero_search_filter
	local survival_info_shown = self.survival_info_shown

	if survival_info_shown then
		map_save_data.survival_info_shown = true
	end

	PlayerData.map_view_data = map_save_data

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "on_save_ended_callback"))

	return 
end
MapView.clear_level_selection = function (self)
	local level_stepper_widget = self.steppers.level.widget
	level_stepper_widget.content.setting_text = Localize("dlc1_2_map_no_level")
	level_stepper_widget.content.disabled = true
	level_stepper_widget.content.location_selected = nil
	local banner_level_widget = self.normal_settings_widgets.banner_level
	banner_level_widget.content.text = "map_level_setting"
	banner_level_widget.content.tooltip_text = "map_level_setting_tooltip"
	banner_level_widget.style.text.text_color = Colors.get_table("gray")
	banner_level_widget.content.tooltip_hotspot.disabled = true
	local level_preview_widget = self.level_preview_widget
	level_preview_widget.content.texture = "level_image_any"
	level_preview_widget.content.locked = false
	level_preview_widget.content.frame_texture = "map_level_preview_frame"
	self.level_preview_text_widget.content.text = ""
	local playable_level = false

	self.update_difficulty_availability(self, nil, playable_level)
	self.set_difficulty_stepper_index(self, self.selected_difficulty_stepper_index, nil, not playable_level)

	self.playable_level = playable_level
	self.dlc_level_selected = false
	self.selected_level_index = nil
	self._preview_level_index = nil
	local game_mode = self.active_game_mode(self)

	if game_mode == "survival" then
		self.on_survival_level_selected(self, nil)
	end

	self.update_gamepad_widget_description(self)

	return 
end
MapView.on_level_index_changed = function (self, index_change, specific_index, is_preview, ignore_sound)
	if index_change and not self.selected_level_index then
		return 
	end

	if not is_preview and not ignore_sound then
		self.stop_dialogue(self, "level")
	end

	local stepper_data = self.steppers.level
	local widget = stepper_data.widget
	local new_index = nil
	local level_list = self.active_level_list(self)
	local number_of_levels = #level_list

	if specific_index and number_of_levels < specific_index then
		ScriptApplication.send_to_crashify("MapView", "Tried to select level with specific_index: %s, current level list has a maximum of %s levels.", specific_index, number_of_levels)

		return 
	end

	if number_of_levels <= 0 then
		return 
	end

	if not specific_index and index_change then
		local current_index = self.selected_level_index or 0
		new_index = current_index + index_change

		if new_index < 1 then
			new_index = number_of_levels
		elseif number_of_levels < new_index then
			new_index = 1
		end

		while level_list[new_index].level_information.visibility == "hidden" do

			-- decompilation error in this vicinity
			new_index = new_index + index_change
		end
	elseif specific_index then
		new_index = specific_index
	else
		new_index = nil
	end

	local level_key, level_information = nil
	local playable_level = true

	if new_index then
		local level_data = level_list[new_index]
		level_key = level_data.level_key
		level_information = level_data.level_information
		playable_level = not level_information.is_area
	end

	if new_index then
		self.nr_level_switches = self.nr_level_switches + 1
	end

	local display_name, display_image = nil

	if new_index then
		display_name = level_information.display_name
		display_image = level_information.level_image
	else
		display_name = "dlc1_2_map_no_level"
		display_image = "level_image_any"
	end

	local level_visibility = level_information and level_information.visibility
	local level_unlocked = level_visibility and level_visibility == "visible"
	local dlc_level_selected = level_visibility and level_visibility == "dlc"

	if not level_unlocked then
		self.clear_level_selection(self)

		local locked_text = (level_information and level_information.visibility_tooltip) or ""
		self.level_preview_text_widget.content.text = locked_text
	else
		widget.content.setting_text = Localize(display_name)
		self.level_preview_text_widget.content.text = ""
	end

	widget.content.disabled = false
	widget.content.location_selected = level_unlocked and not playable_level
	local level_preview_widget = self.level_preview_widget
	level_preview_widget.content.locked = not level_unlocked
	level_preview_widget.content.texture = display_image
	level_preview_widget.content.frame_texture = (playable_level and "map_level_preview_frame") or "map_level_preview_frame_02"
	local banner_level_widget = self.normal_settings_widgets.banner_level
	banner_level_widget.content.text = (playable_level and "map_level_setting") or "dlc1_4_map_area_setting"
	banner_level_widget.content.tooltip_text = (playable_level and "map_level_setting_tooltip") or "dlc1_4_map_area_setting_tooltip"
	banner_level_widget.style.text.text_color = Colors.get_table("cheeseburger")
	banner_level_widget.content.tooltip_hotspot.disabled = false

	if new_index and not is_preview then
		if not specific_index then
			self.map_view_area_handler:set_selected_level(new_index, false)
		end

		self.set_level_index(self, new_index)
	end

	if level_unlocked then
		local game_mode = self.active_game_mode(self)

		if game_mode == "survival" then
			self.on_survival_level_selected(self, level_information)
		end

		local difficulty_data = level_information and level_information.difficulty_data

		self.update_difficulty_availability(self, difficulty_data, playable_level)

		local saved_difficulty_option = self.map_save_data.difficulty_option
		local difficulty_index = self.selected_difficulty_stepper_index

		if not difficulty_index then
			if saved_difficulty_option then
				difficulty_index = 1

				for index, data in ipairs(difficulty_data) do
					if data.key == saved_difficulty_option then
						difficulty_index = index

						break
					end
				end
			else
				difficulty_index = 1
			end
		end

		self.set_difficulty_stepper_index(self, difficulty_index, new_index, not playable_level)

		if not is_preview and not ignore_sound then
			local wwise_events = level_information.wwise_events

			if wwise_events then
				self.play_dialogue(self, wwise_events, "level")
			end
		end
	end

	self.dlc_level_selected = dlc_level_selected
	self.playable_level = playable_level

	self.update_gamepad_widget_description(self)

	return 
end
MapView.on_survival_level_selected = function (self, level_information)
	local visibility = (level_information and true) or false
	local normal_settings_widgets = self.normal_settings_widgets

	for i = 1, 3, 1 do
		local widget_name = "best_performance_" .. i
		local widget = normal_settings_widgets[widget_name]
		widget.content.visible = false
	end

	if level_information then
		local difficulty_data = level_information.difficulty_data

		if difficulty_data then
			local widget_index = 1
			local floor = math.floor
			local any_score_added = false

			for rank, layout in ipairs(difficulty_data) do
				local scores = layout.scores

				if scores then
					local widget_name = "best_performance_" .. widget_index
					local widget = normal_settings_widgets[widget_name]
					local widget_content = widget.content
					widget.content.visible = true
					local setting_text = layout.setting_text
					widget_content.difficulty_title = setting_text
					widget_content.waves = tostring(scores.waves)
					local time = scores.time
					widget_content.time = string.format("%.2d:%.2d:%.2d", floor(time/3600), floor(time/60)%60, floor(time)%60)
					widget_index = widget_index + 1
					any_score_added = true
				end
			end

			if not any_score_added then
				visibility = false
			end
		end

		local area_icon = level_information.map_icon

		if area_icon then
			self.normal_settings_widgets.performance_window_icon.content.texture_id = area_icon
		end
	end

	normal_settings_widgets.banner_performance.content.visible = visibility
	normal_settings_widgets.performance_window.content.visible = visibility
	normal_settings_widgets.performance_window_icon.content.visible = visibility

	return 
end
MapView.on_difficulty_index_changed = function (self, index_change)
	local current_index = self.selected_difficulty_stepper_index or 0
	local new_index = current_index + index_change
	local is_value_increasing = current_index < new_index

	if new_index < 1 then
		new_index = 5
	elseif 5 < new_index then
		new_index = 1
	end

	self.set_difficulty_stepper_index(self, new_index, self.selected_level_index)

	return 
end
MapView.set_difficulty_locked_info = function (self, index, specific_level_index, stop_draw_lock_icon, widget, stepper_text)
	local difficulty_data = (specific_level_index and self.get_difficulty_data(self, specific_level_index)) or self.get_difficulty_data(self, self.selected_level_index)
	local is_unlocked = difficulty_data[index].unlocked
	local icon_visible = not is_unlocked

	if stop_draw_lock_icon then
		icon_visible = false
	end

	self.difficulty_unlock_icon_widget.content.visible = icon_visible
	self.difficulty_unlocked = is_unlocked

	self._adjust_difficulty_lock_icons_position(self, widget, stepper_text)

	return not is_unlocked
end
MapView.set_difficulty_stepper_index = function (self, index, level_index, stop_draw_lock_icon)
	local stepper_data = self.steppers.difficulty
	local widget = stepper_data.widget

	if level_index then
		local difficulty_data = self.get_difficulty_data(self, level_index)
		local data = difficulty_data[index]
		local difficulty_name = data.key
		widget.content.difficulty_level = index
		widget.content.setting_text = data.setting_text
		self.selected_difficulty_stepper_index = index

		self.set_difficulty_locked_info(self, index, level_index, stop_draw_lock_icon, widget, data.setting_text)
	else
		widget.content.difficulty_level = 0
		local settings_text = Localize("dlc1_2_difficulty_unavailable")
		widget.content.setting_text = settings_text
		widget.content.setting_text_hover = settings_text
		self.selected_difficulty_stepper_index = index
		local draw_lock_icon = not stop_draw_lock_icon
		self.difficulty_unlock_icon_widget.content.visible = draw_lock_icon
		self.difficulty_unlocked = false

		self._adjust_difficulty_lock_icons_position(self, widget, settings_text)
	end

	return 
end
MapView._adjust_difficulty_lock_icons_position = function (self, widget, text)
	local widget_style = widget.style
	local text_style = widget_style.setting_text
	local font, scaled_font_size = UIFontByResolution(text_style)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, text, font[1], scaled_font_size)
	self.difficulty_unlock_icon_widget.style.unlock_texture.offset[1] = text_width*0.5 + 15

	return 
end
MapView.update_difficulty_availability = function (self, difficulty_data, playable_level)
	local stepper_widget = self.steppers.difficulty.widget
	local widget_content = stepper_widget.content
	widget_content.disabled = not playable_level
	widget_content.left_button_hotspot.disabled = not playable_level
	widget_content.right_button_hotspot.disabled = not playable_level
	widget_content.difficulty_icon_hotspot_global.disable_button = not playable_level
	widget_content.inactive = not playable_level
	local banner_color = (playable_level and "cheeseburger") or "gray"
	local banner_difficulty = self.normal_settings_widgets.banner_difficulty
	banner_difficulty.style.text.text_color = Colors.get_table(banner_color)
	banner_difficulty.content.tooltip_hotspot.disabled = not playable_level

	for i = 1, 5, 1 do
		local texture_name_empty = "difficulty_icon_" .. i .. "_empty"
		local texture_name_filled = "difficulty_icon_" .. i .. "_filled"
		local tooltip_id = "difficulty_tooltip_" .. i
		widget_content["difficulty_icon_hotspot_" .. i].disable_button = not playable_level

		if playable_level then
			if difficulty_data then
				local data = difficulty_data[i]

				if data.available then
					if data.unlocked then
						widget_content[texture_name_empty] = "difficulty_icon_large_01"
						widget_content[texture_name_filled] = "difficulty_icon_large_02"
					else
						widget_content[texture_name_empty] = "difficulty_icon_large_03"
						widget_content[texture_name_filled] = "difficulty_icon_large_04"
					end
				else
					widget_content[texture_name_empty] = "difficulty_icon_disabled"
					widget_content[texture_name_filled] = "difficulty_icon_disabled_selected"
				end

				widget_content[tooltip_id] = data.tooltip
			else
				widget_content[texture_name_empty] = "difficulty_icon_disabled"
				widget_content[texture_name_filled] = "difficulty_icon_disabled_selected"
				widget_content[tooltip_id] = Localize("map_confirm_button_disabled_tooltip")
			end
		else
			widget_content[texture_name_empty] = "difficulty_icon_disabled_selected"
			widget_content[texture_name_filled] = "difficulty_icon_disabled_selected"
			widget_content[tooltip_id] = Localize("map_confirm_button_disabled_tooltip")
		end
	end

	return 
end
MapView.handle_difficulty_hover = function (self, stepper)
	local ui_animations = self.ui_animations
	local stepper_widget = stepper.widget
	local widget_content = stepper_widget.content

	if widget_content.disabled then
		return 
	end

	local difficulty_icon_hotspot_global = widget_content.difficulty_icon_hotspot_global
	local new_internal_index = nil
	local current_difficulty_level = widget_content.difficulty_level

	for i = 5, 1, -1 do
		local difficulty_icon_hotspot_name = "difficulty_icon_hotspot_" .. i
		local difficulty_icon_hotspot = widget_content[difficulty_icon_hotspot_name]

		if difficulty_icon_hotspot.on_release then
			self.set_difficulty_stepper_index(self, i, self.selected_level_index)
			self.play_sound(self, "Play_hud_select")
		end

		if difficulty_icon_hotspot.on_hover_enter then
			local difficulty_data = self.get_difficulty_data(self, self.selected_level_index)
			local data = difficulty_data[i]
			widget_content.setting_text_hover = data.setting_text

			self.set_difficulty_locked_info(self, i, nil, nil, stepper_widget, data.setting_text)

			widget_content.internal_difficulty_level = i

			self.play_sound(self, "Play_hud_hover")

			new_internal_index = i

			break
		end
	end

	if not new_internal_index and not difficulty_icon_hotspot_global.is_hover then
		local selected_difficulty_stepper_index = self.selected_difficulty_stepper_index

		if selected_difficulty_stepper_index and widget_content.internal_difficulty_level ~= selected_difficulty_stepper_index then
			local difficulty_data = self.get_difficulty_data(self, self.selected_level_index)

			if difficulty_data then
				local stepper_text = difficulty_data[selected_difficulty_stepper_index].setting_text
				widget_content.setting_text_hover = stepper_text

				self.set_difficulty_locked_info(self, selected_difficulty_stepper_index, nil, nil, stepper_widget, stepper_text)
			end

			widget_content.internal_difficulty_level = selected_difficulty_stepper_index
		end
	end

	return 
end
MapView.active_game_mode = function (self)
	local map_view_area_handler = self.map_view_area_handler

	return map_view_area_handler.active_game_mode(map_view_area_handler)
end
MapView.active_area = function (self)
	local map_view_area_handler = self.map_view_area_handler

	return map_view_area_handler.active_area(map_view_area_handler)
end
MapView.set_level_index = function (self, index)
	self.selected_level_index = index

	return 
end
MapView.get_difficulty_data = function (self, level_index)
	local map_view_area_handler = self.map_view_area_handler

	return map_view_area_handler.get_difficulty_data_by_level_index(map_view_area_handler, level_index)
end
MapView.active_level_list = function (self)
	local map_view_area_handler = self.map_view_area_handler

	return map_view_area_handler.active_level_list(map_view_area_handler)
end
MapView.visible_level_count = function (self)
	local map_view_area_handler = self.map_view_area_handler

	return map_view_area_handler.visible_level_count(map_view_area_handler)
end
MapView.set_selected_game_mode = function (self, new_index, ignore_sound)
	local map_view_area_handler = self.map_view_area_handler
	local game_mode_selection_bar_widget = self.game_mode_selection_bar_widget
	local game_mode_bar_content = game_mode_selection_bar_widget.content
	local game_mode_bar_style = game_mode_selection_bar_widget.style

	for i = 1, #game_mode_options, 1 do
		local title_text = "title_text_" .. i
		local is_selected = i == new_index
		game_mode_bar_content[i].is_selected = is_selected
		game_mode_bar_style[title_text].text_color = (is_selected and bar_entry_text_colors.selected) or bar_entry_text_colors.normal
	end

	local ignore_animation = ((not self.selected_game_mode_index or self.selected_game_mode_index == new_index) and true) or false

	if not ignore_animation and self.selected_game_mode_index then
		local game_mode_bar_select_anim_id = self.game_mode_bar_select_anim_id

		if game_mode_bar_select_anim_id then
			self.ui_animator:stop_animation(game_mode_bar_select_anim_id)
		end

		self.ui_animator:start_animation("bar_item_deselect", game_mode_selection_bar_widget, definitions.scenegraph_definition, {
			scenegraph_base = "game_mode_selection_bar",
			selected_index = self.selected_game_mode_index
		})
	end

	self.selected_game_mode_index = new_index
	local game_mode = game_mode_options[new_index]

	map_view_area_handler.set_active_game_mode(map_view_area_handler, game_mode, ignore_sound)

	self.normal_settings_widgets = self.normal_settings_widget_types[game_mode]

	if not ignore_animation then
		self.game_mode_bar_select_anim_id = self.ui_animator:start_animation("bar_item_select", game_mode_selection_bar_widget, definitions.scenegraph_definition, {
			scenegraph_base = "game_mode_selection_bar",
			selected_index = new_index
		})
	end

	local play_game_mode_sound = map_view_area_handler.select_level_after_level_list_change(map_view_area_handler, ignore_sound)

	if not ignore_sound then
		local wwise_events = game_mode_changed_wwise_events[game_mode]

		if 0 < #wwise_events then
			self.play_dialogue(self, wwise_events, "game_mode")
		end
	end

	if game_mode == "survival" then
		local survival_info_shown = self.map_save_data.survival_info_shown

		if not survival_info_shown and self.draw_intro_description == nil then
			self.draw_intro_description = true
		end
	end

	self.update_level_stepper(self)

	return 
end
MapView.on_play_pressed = function (self, t)
	self.confirm_button_widget.content.button_hotspot.on_release = false
	local private_game = self.privacy_setting_enabled
	local new_privacy_setting = (private_game and privacy_settings[2]) or privacy_settings[1]
	local game_mode = self.active_game_mode(self)
	local area = self.active_area(self)

	if area == "world" then
		area = nil
	end

	local selected_index = self.selected_level_index
	local level_list = self.active_level_list(self)
	local level_data = level_list[selected_index]
	local next_level_key = level_data.level_key
	local difficulty_data = self.get_difficulty_data(self, selected_index)
	local selected_difficulty_stepper_index = self.selected_difficulty_stepper_index
	local difficulty_layout = difficulty_data[selected_difficulty_stepper_index]
	local difficulty_key = difficulty_layout.key

	if difficulty_key then
		Managers.state.difficulty:set_difficulty(difficulty_key)
	end

	local selected_zone_option = search_zone_options[self.selected_zone_index]
	local selected_host_option = host_game_options[self.selected_host_index]
	local selected_ready_option = false
	local hero_search_filter = self.hero_search_filter
	local random_level = next_level_key == "any"
	local matchmaking_manager = Managers.matchmaking

	matchmaking_manager.set_option_max_distance_filter(matchmaking_manager, selected_zone_option)
	matchmaking_manager.set_option_host_game(matchmaking_manager, selected_host_option)
	matchmaking_manager.set_option_ready(matchmaking_manager, selected_ready_option)
	matchmaking_manager.set_option_hero_filter(matchmaking_manager, hero_search_filter)
	Managers.matchmaking:find_game(next_level_key, difficulty_key, private_game, random_level, game_mode, area, t)
	self.play_sound(self, "Play_hud_map_mission_accept")

	local player = Managers.player:local_player(1)
	local nr_level_switches = self.nr_level_switches
	local selected_level_option = next_level_key

	Managers.telemetry.events:matchmaking_map_done(player, selected_level_option, difficulty_key, new_privacy_setting, nr_level_switches)

	self.nr_level_switches = 0

	return 
end
MapView.handle_stepper_input = function (self, stepper_name, stepper)
	local stepper_widget = stepper.widget
	local stepper_content = stepper_widget.content
	local stepper_hotspot = stepper_content.button_hotspot
	local stepper_left_hotspot = stepper_content.left_button_hotspot
	local stepper_right_hotspot = stepper_content.right_button_hotspot

	if stepper_content.disabled then
		return 
	end

	if stepper_left_hotspot.on_hover_enter then
		self.on_stepper_arrow_hover(self, stepper_widget, stepper_name, "left_button_texture_clicked")
	elseif stepper_right_hotspot.on_hover_enter then
		self.on_stepper_arrow_hover(self, stepper_widget, stepper_name, "right_button_texture_clicked")
	end

	if stepper_left_hotspot.on_hover_exit then
		self.on_stepper_arrow_dehover(self, stepper_widget, stepper_name, "left_button_texture_clicked")
	elseif stepper_right_hotspot.on_hover_exit then
		self.on_stepper_arrow_dehover(self, stepper_widget, stepper_name, "right_button_texture_clicked")
	end

	if stepper_left_hotspot.on_release then
		stepper_left_hotspot.on_release = nil

		stepper.callback(-1)
		self.play_sound(self, "Play_hud_select")

		if stepper_left_hotspot.is_hover then
			self.on_stepper_arrow_pressed(self, stepper_widget, stepper_name, "left_button_texture")
			self.on_stepper_arrow_pressed(self, stepper_widget, stepper_name, "left_button_texture_clicked")
		end
	elseif stepper_right_hotspot.on_release then
		stepper_right_hotspot.on_release = nil

		stepper.callback(1)
		self.play_sound(self, "Play_hud_select")

		if stepper_right_hotspot.is_hover then
			self.on_stepper_arrow_pressed(self, stepper_widget, stepper_name, "right_button_texture")
			self.on_stepper_arrow_pressed(self, stepper_widget, stepper_name, "right_button_texture_clicked")
		end
	elseif stepper_content.location_selected and stepper_content.confirm_pressed then
		self.map_view_area_handler:open_selected_area()

		stepper_content.confirm_pressed = nil
	end

	return 
end
MapView.update_button_bar_animation = function (self, widget, widget_name, dt)
	local content = widget.content
	local style = widget.style
	local bar_settings = UISettings.inventory.button_bars
	local bar_animations = self.bar_animations

	if not bar_animations[widget_name] then
		bar_animations[widget_name] = {}
	end

	for i = 1, #content, 1 do
		local button_normal_id = string.format("button_style_%d", i)
		local button_style = style[button_normal_id]
		local active_animations = bar_animations[widget_name][i] or {}
		local button_hotspot = content[i]
		local is_selected = content[i].is_selected

		if button_hotspot.on_hover_enter then
			if not is_selected then
				self.play_sound(self, "Play_hud_hover")

				local background_fade_in_time = bar_settings.background.fade_in_time
				local background_alpha_hover = bar_settings.background.alpha_hover
				active_animations[button_normal_id] = self.animate_element_by_time(self, button_style.color, 1, button_style.color[1], background_alpha_hover, background_fade_in_time)
			end
		elseif button_hotspot.on_hover_exit then
			local background_fade_out_time = bar_settings.background.fade_out_time
			local background_alpha_normal = (widget_name ~= "equipment_selection" or 0) and bar_settings.background.alpha_normal
			active_animations[button_normal_id] = self.animate_element_by_time(self, button_style.color, 1, button_style.color[1], background_alpha_normal, background_fade_out_time)
		end

		if active_animations then
			for name, animation in pairs(active_animations) do
				UIAnimation.update(animation, dt)

				if UIAnimation.completed(animation) then
					animation = nil
					self.bar_animations[widget_name][i] = nil
				end
			end
		end

		self.bar_animations[widget_name][i] = active_animations
	end

	return 
end
MapView.update_level_stepper = function (self)
	local num_visible_levels = self.visible_level_count(self)

	if 1 < num_visible_levels then
		local level_stepper_widget = self.steppers.level.widget
		level_stepper_widget.content.left_button_hotspot.disable_button = false
		level_stepper_widget.content.right_button_hotspot.disable_button = false
	else
		local level_stepper_widget = self.steppers.level.widget
		level_stepper_widget.content.left_button_hotspot.disable_button = true
		level_stepper_widget.content.right_button_hotspot.disable_button = true
	end

	return 
end
MapView.on_gamepad_activated = function (self)
	local advanced_settings_active = self.settings_button_widget.content.toggled
	local settings_list_name = nil

	if not advanced_settings_active then
		settings_list_name = "normal"
	else
		settings_list_name = "advanced"
	end

	if self.gamepad_selected_settings_index and self.active_gamepad_menu_list_name then
		self.deselect_gamepad_widget_by_index(self, self.gamepad_selected_settings_index, self.active_gamepad_menu_list_name)
	end

	self.select_gamepad_widget_by_index(self, 1, settings_list_name)
	self.update_input_description(self)

	self.controller_cooldown = GamepadSettings.menu_cooldown
	local ui_scenegraph = self.ui_scenegraph
	local private_checkbox_position = ui_scenegraph.private_checkbox.local_position
	local gamepad_private_checkbox_position = ui_scenegraph.gamepad_private_checkbox.local_position
	private_checkbox_position[1] = gamepad_private_checkbox_position[1]
	private_checkbox_position[2] = gamepad_private_checkbox_position[2]
	private_checkbox_position[3] = gamepad_private_checkbox_position[3]

	return 
end
MapView.on_gamepad_deactivated = function (self)
	if self.gamepad_selected_settings_index and self.active_gamepad_menu_list_name then
		self.deselect_gamepad_widget_by_index(self, self.gamepad_selected_settings_index, self.active_gamepad_menu_list_name)
	end

	self.gamepad_selected_settings_index = nil
	self.active_gamepad_menu_list_name = nil
	self.gamepad_active_generic_actions_name = nil
	local ui_scenegraph = self.ui_scenegraph
	local private_checkbox_position = ui_scenegraph.private_checkbox.local_position
	local pc_private_checkbox_position = ui_scenegraph.pc_private_checkbox.local_position
	private_checkbox_position[1] = pc_private_checkbox_position[1]
	private_checkbox_position[2] = pc_private_checkbox_position[2]
	private_checkbox_position[3] = pc_private_checkbox_position[3]

	return 
end
MapView.on_save_ended_callback = function (self)
	print("[MapView] - settings saved")

	return 
end
MapView.set_privacy_enabled = function (self, enabled)
	local widget = self.private_checkbox_widget
	widget.content.selected = enabled
	self.privacy_setting_enabled = enabled

	Managers.matchmaking:set_game_privacy(enabled)

	return 
end
MapView.on_zone_index_changed = function (self, index_change, specific_index)
	local stepper_data = self.steppers.zone
	local widget = stepper_data.widget
	local new_index = 0
	local number_of_host_settings = #search_zone_options

	if not specific_index then
		local current_index = self.selected_zone_index or 0
		new_index = current_index + index_change

		if new_index < 1 then
			new_index = number_of_host_settings
		elseif number_of_host_settings < new_index then
			new_index = 1
		end
	else
		new_index = specific_index
	end

	local new_setting_name = search_zone_options[new_index]
	local display_name = search_zone_settings_display_names[new_setting_name]
	widget.content.setting_text = Localize(display_name)
	self.selected_zone_index = new_index

	return 
end
MapView.on_host_index_changed = function (self, index_change, specific_index)
	local stepper_data = self.steppers.host
	local widget = stepper_data.widget
	local new_index = 0
	local number_of_host_settings = #host_game_options

	if not specific_index then
		local current_index = self.selected_host_index or 0
		new_index = current_index + index_change

		if new_index < 1 then
			new_index = number_of_host_settings
		elseif number_of_host_settings < new_index then
			new_index = 1
		end
	else
		new_index = specific_index
	end

	local new_setting_name = host_game_options[new_index]
	local display_name = host_game_settings_display_names[new_setting_name]
	widget.content.setting_text = Localize(display_name)
	self.selected_host_index = new_index

	return 
end
MapView.on_ready_index_changed = function (self, index_change, specific_index)
	local stepper_data = self.steppers.ready
	local widget = stepper_data.widget
	local new_index = 0
	local number_of_host_settings = #ready_settings_display_names

	if not specific_index then
		local current_index = self.selected_ready_index or 0
		new_index = current_index + index_change

		if new_index < 1 then
			new_index = number_of_host_settings
		elseif number_of_host_settings < new_index then
			new_index = 1
		end
	else
		new_index = specific_index
	end

	local display_name = ready_settings_display_names[new_index]
	widget.content.setting_text = Localize(display_name)
	self.selected_ready_index = new_index

	return 
end
MapView.kick_player = function (self, peer_id)
	local network_server = self.network_server

	network_server.kick_peer(network_server, peer_id)

	return 
end
MapView.handle_popup_result = function (self, popup_result)
	if popup_result == "kick_player" then
		self.popup_id = nil

		self.kick_player(self, self.kick_player_peer_id)

		self.kick_player_peer_id = nil
	elseif popup_result == "cancel_popup" then
		self.popup_id = nil
		self.kick_player_peer_id = nil
		local input_manager = self.input_manager

		input_manager.block_device_except_service(input_manager, "map_menu", "keyboard")
		input_manager.block_device_except_service(input_manager, "map_menu", "mouse")
		input_manager.block_device_except_service(input_manager, "map_menu", "gamepad")
	end

	return 
end
MapView.request_kick_player = function (self, peer_id)
	if not self.popup_id then
		self.kick_player_peer_id = peer_id
		local text = Localize("kick_player_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("popup_kick_player_topic"), "kick_player", Localize("popup_choice_yes"), "cancel_popup", Localize("popup_choice_no"))
	end

	return 
end
MapView.event_enable_level_select = function (self)
	self.observer_only = not Managers.player.is_server
	local player = Managers.player:local_player()

	if player then
		self.ingame_ui:set_map_active_state(true)
	end

	return 
end

local function sort_players(a, b)
	local my_peer_id = self.peer_id

	if a.network_id(a) == my_peer_id then
		return true
	elseif b.network_id(b) == my_peer_id then
		return false
	else
		return a.name(a) < b.name(b)
	end

	return 
end

MapView.setup_own_player_in_player_list = function (self)
	local widgets = self.player_list_widgets
	local player_manager = self.player_manager
	local profile_synchronizer = self.profile_synchronizer
	local my_peer_id = self.peer_id
	local my_player = player_manager.player_from_peer_id(player_manager, my_peer_id)
	local player_unit = my_player.player_unit
	local widget_index_counter = 1
	local widget = widgets[widget_index_counter]
	local display_name = UIRenderer.crop_text(my_player.name(my_player), player_name_max_length)
	widget.content.text = display_name
	widget.content.is_host = self.is_server
	local kick_enabled = false
	widget.content.kick_enabled = kick_enabled
	widget.content.kick_button_hotspot.disable_button = not kick_enabled
	local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, my_peer_id, my_player.local_player_id(my_player))

	if profile_index then
		local profile_data = SPProfiles[profile_index]
		local hero_name = profile_data.display_name
		local hero_icon_texture = UISettings.hero_icons.small[hero_name]
		widget.content.hero_icon_texture = hero_icon_texture
		widget.content.hero_icon_tooltip_text = hero_name
	end

	self.number_of_player = widget_index_counter or 0
	self.player_list_conuter_text_widget.content.text = widget_index_counter .. "/" .. 4

	return 
end
MapView.update_player_list = function (self)
	local widgets = self.player_list_widgets
	local player_manager = self.player_manager
	local profile_synchronizer = self.profile_synchronizer
	local my_peer_id = self.peer_id
	local my_player = player_manager.player_from_peer_id(player_manager, my_peer_id)
	local player_unit = my_player.player_unit
	local human_players = player_manager.human_players(player_manager)
	local widget_index_counter = 1

	for _, player in pairs(human_players) do
		local player_peer_id = player.network_id(player)

		if player_peer_id ~= my_peer_id then
			widget_index_counter = widget_index_counter + 1
			local widget = widgets[widget_index_counter]

			if widget.content.peer_id ~= player_peer_id then
				widget.content.is_host = self.host_peer_id == player_peer_id
				widget.content.peer_id = player_peer_id
				local display_name = UIRenderer.crop_text(player.name(player), player_name_max_length)
				widget.content.text = display_name
				local kick_enabled = true
				widget.content.kick_enabled = kick_enabled
				widget.content.kick_button_hotspot.disable_button = not kick_enabled
				local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, player_peer_id, player.local_player_id(player))

				if profile_index then
					local profile_data = SPProfiles[profile_index]
					local hero_name = profile_data.display_name
					local hero_icon_texture = UISettings.hero_icons.small[hero_name]
					widget.content.hero_icon_texture = hero_icon_texture
					widget.content.hero_icon_tooltip_text = hero_name
				end
			end

			if widget.content.kick_button_hotspot.on_release then
				widget.content.kick_button_hotspot.on_release = nil

				self.request_kick_player(self, player_peer_id)
			end
		end
	end

	self.number_of_player = widget_index_counter or 0
	self.player_list_conuter_text_widget.content.text = widget_index_counter .. "/" .. 4

	return 
end
MapView.suspend = function (self)
	self.suspended = true

	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)

	return 
end
MapView.unsuspend = function (self)
	self.suspended = nil

	self.input_manager:block_device_except_service("map_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("map_menu", "mouse", 1)
	self.input_manager:block_device_except_service("map_menu", "gamepad", 1)

	return 
end
MapView.set_description_text = function (self, text, prefix)
	if prefix then
		local localized_prefix = Localize(prefix)
		text = localized_prefix .. ": " .. Localize(text) .. "\n"
	else
		text = Localize(text) .. "\n"
	end

	self.description_field_widget.content.text = text

	return 
end
MapView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	return 
end
MapView._update_invite_friends = function (self)
	local session_id = Managers.matchmaking.lobby:session_id()
	local status = MultiplayerSession.status(session_id)

	if status ~= MultiplayerSession.READY then
		return 
	end

	self._xbox_trying_to_open_invite_friends = nil

	MultiplayerSession.invite_friends(Managers.account:user_id(), self.lobby:session_id(), 0, 3)

	return 
end
MapView.on_friends_pressed = function (self)
	if Application.platform() == "xb1" then
		self._xbox_trying_to_open_invite_friends = true
	else
		self.friends:set_active(true)
	end

	return 
end
MapView.deactivate_friends_menu = function (self)
	self.friends:set_active(false)
	self.input_manager:block_device_except_service("map_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("map_menu", "mouse", 1)
	self.input_manager:block_device_except_service("map_menu", "gamepad", 1)

	return 
end
MapView.input_service = function (self)
	local friends = self.friends
	local friends_menu_active = friends.is_active(friends)

	return (friends_menu_active and friends.input_service(friends)) or self.input_manager:get_service("map_menu")
end
MapView.destroy = function (self)
	self.ui_animator = nil
	self.friends = nil

	self.menu_input_description:destroy()

	self.menu_input_description = nil

	if self.popup_id then
		Managers.popup:cancel_popup(self.popup_id)
	end

	GarbageLeakDetector.register_object(self, "MapView")

	self.interaction_map_unit = nil

	return 
end
MapView.setup_steppers = function (self)
	local steppers = {
		difficulty = {
			widget = UIWidget.init(definitions.widgets.difficulty_stepper),
			callback = callback(self, "on_difficulty_index_changed")
		},
		level = {
			widget = UIWidget.init(definitions.widgets.level_stepper),
			callback = callback(self, "on_level_index_changed")
		},
		zone = {
			widget = UIWidget.init(definitions.widgets.stepper_search_zone),
			callback = callback(self, "on_zone_index_changed")
		},
		host = {
			widget = UIWidget.init(definitions.widgets.stepper_host_setting),
			callback = callback(self, "on_host_index_changed")
		}
	}

	return steppers
end
MapView.on_enter = function (self)
	self.setup_own_player_in_player_list(self)

	self.gamepad_selected_settings_index = nil
	self.active_gamepad_menu_list_name = nil
	self.gamepad_active_generic_actions_name = nil
	local input_manager = self.input_manager

	input_manager.block_device_except_service(input_manager, "map_menu", "keyboard", 1)
	input_manager.block_device_except_service(input_manager, "map_menu", "mouse", 1)
	input_manager.block_device_except_service(input_manager, "map_menu", "gamepad", 1)

	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	if gamepad_active then
		self.gamepad_active_last_frame = true

		self.on_gamepad_activated(self)
	end

	self.nr_level_switches = 0

	self.play_sound(self, "Play_hud_map_open")

	self.menu_active = true
	self.active = true

	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_on")

	return 
end
MapView.on_exit = function (self)
	self.save_map_settings(self)

	if self.gamepad_selected_settings_index and self.active_gamepad_menu_list_name then
		self.deselect_gamepad_widget_by_index(self, self.gamepad_selected_settings_index, self.active_gamepad_menu_list_name)
	end

	self.gamepad_selected_settings_index = nil
	self.active_gamepad_menu_list_name = nil
	self.gamepad_active_generic_actions_name = nil

	if self.last_dialogue_reason then
		self.stop_dialogue(self, self.last_dialogue_reason)

		self.last_dialogue_reason = nil
	end

	self.play_sound(self, "Play_hud_map_close")

	self.active = nil
	self.exiting = nil
	self.menu_active = nil

	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_off")

	return 
end
MapView.exit = function (self, return_to_game)
	local friends_menu_active = self.friends:is_active()

	if friends_menu_active then
		self.deactivate_friends_menu(self)
	end

	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)

	self.exiting = true

	return 
end
MapView.open_lobby_browser = function (self)
	local friends_menu_active = self.friends:is_active()

	if friends_menu_active then
		self.deactivate_friends_menu(self)
	end

	local exit_transition = "lobby_browser_view"

	self.ingame_ui:transition_with_fade(exit_transition)

	self.exiting = true

	return 
end
MapView.apply_saved_settings = function (self)
	local map_save_data = self.map_save_data
	local private_enabled = map_save_data.private_enabled

	if private_enabled ~= nil then
		self.set_privacy_enabled(self, private_enabled)
	else
		self.set_privacy_enabled(self, false)
	end

	local zone_option = map_save_data.zone_option

	if zone_option ~= nil then
		local zone_option_index = search_zone_options_order_by_name[zone_option]

		self.on_zone_index_changed(self, nil, zone_option_index or 1)
	else
		self.on_zone_index_changed(self, nil, 1)
	end

	local host_option = map_save_data.host_option

	if host_option ~= nil then
		local host_option_index = host_game_options_order_by_name[host_option]

		self.on_host_index_changed(self, nil, host_option_index or 1)
	else
		self.on_host_index_changed(self, nil, 1)
	end

	local hero_search_filter = map_save_data.hero_search_filter

	if hero_search_filter ~= nil then
		self.hero_search_filter = hero_search_filter
		local widget = self.hero_search_filter_widget
		local widget_content = widget.content

		for index, hero in ipairs(hero_search_options) do
			local hotspot_name = "hotspot_" .. index
			local icon_hotspot = widget_content[hotspot_name]
			icon_hotspot.selected = not hero_search_filter[hero]
		end
	else
		self.hero_search_filter = {
			witch_hunter = true,
			empire_soldier = true,
			dwarf_ranger = true,
			wood_elf = true,
			bright_wizard = true
		}
	end

	return 
end
MapView.update_hero_search_filter_input = function (self)
	local hero_search_filter = self.hero_search_filter
	local widget = self.hero_search_filter_widget
	local widget_content = widget.content

	for i = 1, 5, 1 do
		local hotspot_name = "hotspot_" .. i
		local icon_hotspot = widget_content[hotspot_name]

		if icon_hotspot.on_hover_enter then
			self.play_sound(self, "Play_hud_hover")
		end

		if icon_hotspot.on_release then
			local number_of_search_heroes = 0

			for hero_name, value in pairs(hero_search_filter) do
				if value then
					number_of_search_heroes = number_of_search_heroes + 1
				end
			end

			if icon_hotspot.selected or (not icon_hotspot.selected and 1 < number_of_search_heroes) then
				local hero_option = hero_search_options[i]
				icon_hotspot.selected = not icon_hotspot.selected
				hero_search_filter[hero_option] = not icon_hotspot.selected

				self.play_sound(self, "Play_hud_select")
			end
		end
	end

	return 
end
MapView.on_stepper_arrow_pressed = function (self, widget, name, style_id)
	local ui_animations = self.ui_animations
	local animation_name = "stepper_widget_arrow_" .. name .. style_id
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local default_size = {
		28,
		34
	}
	local current_alpha = pass_style.color[1]
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_hover"] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
		ui_animations[animation_name .. "_selected_size_width"] = self.animate_element_by_catmullrom(self, pass_style.size, 1, default_size[1], 0.7, 1, 1, 0.7, animation_duration)
		ui_animations[animation_name .. "_selected_size_height"] = self.animate_element_by_catmullrom(self, pass_style.size, 2, default_size[2], 0.7, 1, 1, 0.7, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	return 
end
MapView.on_stepper_arrow_hover = function (self, widget, name, style_id)
	local ui_animations = self.ui_animations
	local animation_name = "stepper_widget_arrow_" .. name .. style_id
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local current_alpha = pass_style.color[1]
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = (current_alpha/target_alpha - 1)*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_hover"] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	self.play_sound(self, "Play_hud_hover")

	return 
end
MapView.on_stepper_arrow_dehover = function (self, widget, name, style_id)
	local ui_animations = self.ui_animations
	local animation_name = "stepper_widget_arrow_" .. name .. style_id
	local widget_style = widget.style
	local pass_style = widget_style[style_id]
	local current_alpha = pass_style.color[1]
	local target_alpha = 0
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = current_alpha/255*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_hover"] = self.animate_element_by_time(self, pass_style.color, 1, current_alpha, target_alpha, animation_duration)
	else
		pass_style.color[1] = target_alpha
	end

	return 
end
MapView.update_input_description = function (self)
	local confirm_button_hotspot = self.confirm_button_widget.content.button_hotspot
	local play_button_disabled = confirm_button_hotspot.disabled
	local can_back = self.active_area(self) ~= "world"
	local actions_name_to_use = nil

	if self.dlc_level_selected then
		if can_back then
			actions_name_to_use = "dlc_selected_step_back"
		else
			actions_name_to_use = "dlc_selected"
		end
	elseif play_button_disabled then
		if can_back then
			actions_name_to_use = "play_disabled_step_back"
		else
			actions_name_to_use = "play_disabled"
		end
	elseif can_back then
		actions_name_to_use = "default_step_back"
	else
		actions_name_to_use = "default"
	end

	if not self.gamepad_active_generic_actions_name or self.gamepad_active_generic_actions_name ~= actions_name_to_use then
		self.gamepad_active_generic_actions_name = actions_name_to_use
		local generic_actions = generic_input_actions[actions_name_to_use]

		self.menu_input_description:change_generic_actions(generic_actions)
	end

	return 
end
MapView.select_gamepad_widget_by_index = function (self, index, optional_menu_name)
	local menu_name = optional_menu_name or self.active_gamepad_menu_list_name
	local is_player_list = menu_name == "player_list"
	local menu_widgets = (is_player_list and self.gamepad_player_list_widgets[menu_name]) or self.gamepad_settings_widgets[menu_name]
	local widget_data = menu_widgets[index]
	local widget = widget_data.widget
	widget.content.button_hotspot.is_selected = true
	self.gamepad_selected_settings_index = index

	if optional_menu_name then
		self.active_gamepad_menu_list_name = optional_menu_name
	end

	local gamepad_selection_style = widget.style.gamepad_selection

	if gamepad_selection_style then
		local scenegraph_id = gamepad_selection_style.scenegraph_id
		local offset = gamepad_selection_style.offset
		local texture_size = gamepad_selection_style.texture_size
		local widget_gamepad_selection_scenegraph = self.ui_scenegraph[scenegraph_id]
		local scenegraph_world_position = widget_gamepad_selection_scenegraph.world_position
		local gamepad_selection_scenegraph = self.ui_scenegraph.gamepad_selection_pivot
		local gamepad_selection_position = gamepad_selection_scenegraph.local_position
		local gamepad_selection_size = gamepad_selection_scenegraph.size
		self.gamepad_button_selection_widget.scenegraph_id = scenegraph_id
		local gamepad_widget_style = self.gamepad_button_selection_widget.style
		gamepad_widget_style.texture_top_left.texture_size = texture_size
		gamepad_widget_style.texture_top_right.texture_size = texture_size
		gamepad_widget_style.texture_bottom_left.texture_size = texture_size
		gamepad_widget_style.texture_bottom_right.texture_size = texture_size
	end

	self.update_gamepad_widget_description(self)

	return 
end
MapView.update_gamepad_widget_description = function (self)
	local menu_name = self.active_gamepad_menu_list_name

	if not menu_name then
		return 
	end

	local is_player_list = menu_name == "player_list"
	local menu_widgets = (is_player_list and self.gamepad_player_list_widgets[menu_name]) or self.gamepad_settings_widgets[menu_name]
	local index = self.gamepad_selected_settings_index
	local widget_data = menu_widgets[index]
	local widget = widget_data.widget
	local data = widget_data.data
	local input_description = nil

	if is_player_list then
		input_description = (widget.content.kick_enabled and data.input_description) or {}
	elseif widget.content.disabled and data.disabled_input_description then
		input_description = data.disabled_input_description
	elseif widget.content.location_selected then
		input_description = data.location_input_description
	else
		input_description = data.input_description
	end

	self.menu_input_description:set_input_description(input_description)

	return 
end
MapView.deselect_gamepad_widget_by_index = function (self, index, optional_menu_name)
	local menu_name = optional_menu_name or self.active_gamepad_menu_list_name
	local menu_widgets = (menu_name == "player_list" and self.gamepad_player_list_widgets[menu_name]) or self.gamepad_settings_widgets[menu_name]
	local widget_data = menu_widgets[index]
	local widget = widget_data.widget
	widget.content.button_hotspot.is_selected = nil

	return 
end
MapView.handle_gamepad_navigation_input = function (self, dt)
	self.update_input_description(self)

	local input_service = self.input_manager:get_service("map_menu")
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	else
		local active_gamepad_menu_list_name = self.active_gamepad_menu_list_name

		if active_gamepad_menu_list_name then
			if input_service.get(input_service, "cycle_previous") then
				local current_game_mode_index = self.selected_game_mode_index or 1

				if 1 < current_game_mode_index then
					self.set_selected_game_mode(self, current_game_mode_index - 1)

					self.controller_cooldown = GamepadSettings.menu_cooldown
				end

				return 
			elseif input_service.get(input_service, "cycle_next") then
				local num_game_mode_options = #game_mode_options
				local current_game_mode_index = self.selected_game_mode_index or 1

				if current_game_mode_index < num_game_mode_options then
					self.set_selected_game_mode(self, current_game_mode_index + 1)

					self.controller_cooldown = GamepadSettings.menu_cooldown
				end

				return 
			end

			if Application.platform() ~= "xb1" then
				if input_service.get(input_service, "left_stick_press") then
					self.play_sound(self, "Play_hud_select")

					self.settings_button_widget.content.toggled = not self.settings_button_widget.content.toggled

					self.on_gamepad_activated(self)

					return 
				end
			elseif not self._warning_shown then
				Application.warning("[MapView] Turned of switch settings for light optional cert")

				self._warning_shown = true
			end

			local player_list_active = active_gamepad_menu_list_name == "player_list"
			local menu_widgets = (player_list_active and self.gamepad_player_list_widgets[active_gamepad_menu_list_name]) or self.gamepad_settings_widgets[active_gamepad_menu_list_name]
			local gamepad_selected_settings_index = self.gamepad_selected_settings_index
			local selection_data = menu_widgets[gamepad_selected_settings_index]
			local selected_widget_data = selection_data.data
			local selected_widget = selection_data.widget

			if selected_widget_data then
				local input_handled = selected_widget_data.input_function(selected_widget, input_service)

				if input_handled then
					self.controller_cooldown = GamepadSettings.menu_cooldown

					return 
				end
			end

			num_settings_widgets = (player_list_active and self.number_of_player) or #menu_widgets
			local new_selection_index = gamepad_selected_settings_index

			if input_service.get(input_service, "move_down") then
				if not player_list_active and new_selection_index == num_settings_widgets then
					self.deselect_gamepad_widget_by_index(self, gamepad_selected_settings_index, active_gamepad_menu_list_name)
					self.select_gamepad_widget_by_index(self, 1, "player_list")
					self.play_sound(self, "Play_hud_select")
				else
					new_selection_index = math.min(new_selection_index + 1, num_settings_widgets)
				end
			elseif input_service.get(input_service, "move_up") then
				if player_list_active and new_selection_index == 1 then
					self.deselect_gamepad_widget_by_index(self, gamepad_selected_settings_index, active_gamepad_menu_list_name)

					local advanced_settings_active = self.settings_button_widget.content.toggled
					local new_menu_name = (advanced_settings_active and "advanced") or "normal"
					local settings_widget_list = self.gamepad_settings_widgets[new_menu_name]

					self.select_gamepad_widget_by_index(self, #settings_widget_list, new_menu_name)
					self.play_sound(self, "Play_hud_select")
				else
					new_selection_index = math.max(new_selection_index - 1, 1)
				end
			end

			if new_selection_index ~= gamepad_selected_settings_index then
				self.play_sound(self, "Play_hud_select")
				self.deselect_gamepad_widget_by_index(self, gamepad_selected_settings_index, active_gamepad_menu_list_name)
				self.select_gamepad_widget_by_index(self, new_selection_index, active_gamepad_menu_list_name)

				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		end
	end

	return 
end
MapView.play_dialogue = function (self, wwise_events, reason)
	local wwise_event = wwise_events[math.random(1, #wwise_events)]

	if self.wwise_playing_id and WwiseWorld.is_playing(self.wwise_world, self.wwise_playing_id) then
		WwiseWorld.stop_event(self.wwise_world, self.wwise_playing_id)
	end

	local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(self.wwise_world, wwise_event)
	self.wwise_playing_id = wwise_playing_id
	self.playing_wwise_event = wwise_event
	self.last_dialogue_reason = reason
	local wwise_event_prefix_key = string.sub(wwise_event, 1, 3)
	self.dialogue_speaker = dialogue_speakers[wwise_event_prefix_key]
	local subtitle_gui = self.ingame_ui.ingame_hud.subtitle_gui

	subtitle_gui.start_subtitle(subtitle_gui, self.dialogue_speaker, wwise_event)
	self.set_description_text(self, wwise_event, self.dialogue_speaker)

	return 
end
MapView.stop_dialogue = function (self, reason)
	if self.last_dialogue_reason ~= reason then
		return 
	end

	if self.wwise_playing_id and WwiseWorld.is_playing(self.wwise_world, self.wwise_playing_id) then
		local subtitle_gui = self.ingame_ui.ingame_hud.subtitle_gui

		subtitle_gui.stop_subtitle(subtitle_gui, self.dialogue_speaker)
		WwiseWorld.stop_event(self.wwise_world, self.wwise_playing_id)

		self.wwise_playing_id = nil
		self.dialogue_speaker = nil
		self.playing_wwise_event = nil
	end

	local description_field_widget = self.description_field_widget

	if description_field_widget then
		description_field_widget.content.text = ""
	end

	return 
end
MapView.animate_element_by_time = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, time, math.ease_out_quad)

	return new_animation
end
MapView.animate_element_by_catmullrom = function (self, target, target_index, target_value, p0, p1, p2, p3, time)
	local new_animation = UIAnimation.init(UIAnimation.catmullrom, target, target_index, target_value, p0, p1, p2, p3, time)

	return new_animation
end
MapView.animate_element_pulse = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.pulse_animation, target, target_index, from, to, time)

	return new_animation
end
MapView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
MapView.set_map_interaction_state = function (self, enabled)
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
MapView.get_map_unit = function (self)
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
MapView.calculate_ui_spawn_time = function (self, dt)
	local time = self.ui_spawn_timer

	if time then
		time = time - dt

		if time <= 0 then
			self.ui_spawn_timer = nil
			self.menu_active = true
		else
			self.ui_spawn_timer = time
		end
	end

	return 
end

return 
