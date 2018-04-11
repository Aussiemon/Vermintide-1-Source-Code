local definitions = local_require("scripts/ui/views/map_view_states/definitions/state_map_view_overview_definitions")
local player_list_navigation_helper = definitions.player_list_navigation_helper
local create_difficulty_banner = definitions.create_difficulty_banner
local menu_button_definitions = definitions.menu_button_definitions
local selection_font_increase = definitions.selection_font_increase
local player_name_max_length = definitions.player_name_max_length
local menu_button_font_size = definitions.menu_button_font_size
local generic_input_actions = definitions.generic_input_actions
local scenegraph_definition = definitions.scenegraph_definition
local text_colors = definitions.text_colors
local widgets = definitions.widgets
local DO_RELOAD = false
StateMapViewOverview = class(StateMapViewOverview)
StateMapViewOverview.NAME = "StateMapViewOverview"
StateMapViewOverview.on_enter = function (self, params)
	print("[MapViewState] Enter Substate StateMapViewOverview")

	self.params = params
	local ingame_ui_context = params.ingame_ui_context
	self.map_view_area_handler = params.map_view_area_handler
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.map_view_helper = params.map_view_helper
	self.level_filter = params.level_filter
	self.player_manager = ingame_ui_context.player_manager
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.popup_handler = self.ingame_ui.popup_handler
	self.is_server = ingame_ui_context.is_server
	local player = self.player_manager:local_player()
	local player_stats_id = player.stats_id(player)
	local network_manager = Managers.state.network
	local network_transmit = network_manager.network_transmit
	local server_peer_id = network_transmit.server_peer_id
	self.host_peer_id = server_peer_id or network_transmit.peer_id
	self.peer_id = ingame_ui_context.peer_id
	self._map_view = params.map_view
	self._menu_item_state_functions = {
		function (game_info)
			return StateMapViewGameMode
		end,
		function (game_info)
			if game_info.game_mode ~= "survival" then
				return StateMapViewSelectArea
			else
				return StateMapViewSelectLevel
			end

			return 
		end,
		function (game_info)
			return StateMapViewSelectDifficulty
		end,
		function (game_info)
			return StateMapViewSelectArea
		end,
		function (game_info)
			return StateMapViewSelectArea
		end
	}

	self._setup_game_information(self)

	self.platform = PLATFORM
	self.ui_animations = {}

	self.create_ui_elements(self)

	local input_service = self.input_manager:get_service("map_menu")
	local gui_layer = UILayer.default + 30
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 5, gui_layer, generic_input_actions.default)

	self.menu_input_description:set_input_description(nil)
	self._setup_own_player_in_player_list(self)
	self._apply_information(self)

	return 
end
StateMapViewOverview._setup_game_information = function (self)
	print("------------------------------------------")
	print("----------SETUP GAME INFORMATION----------")
	print("------------------------------------------")

	local map_view_area_handler = self.map_view_area_handler
	local map_view_helper = self.map_view_helper
	local game_info = self.params.game_info
	local active_game_mode = map_view_area_handler.active_game_mode(map_view_area_handler)
	local game_mode_changed = game_info.previous_info.game_mode and game_info.game_mode ~= game_info.previous_info.game_mode
	game_info.previous_info.game_mode = nil

	if ((active_game_mode and active_game_mode == "survival") or (game_info.game_mode and game_info.game_mode == "survival")) and not map_view_helper.is_survival_unlocked(map_view_helper) then
		active_game_mode = nil
		game_info.game_mode = nil
		game_mode_changed = true
	end

	if not active_game_mode then
		local default_game_mode = game_info.game_mode or "adventure"

		map_view_area_handler.set_active_game_mode(map_view_area_handler, default_game_mode)

		game_info.game_mode = default_game_mode
	else
		game_info.game_mode = active_game_mode
	end

	local active_area = map_view_area_handler.active_area(map_view_area_handler)

	if game_info.game_mode == "adventure" and (not active_area or active_area == "world") then
		local default_area = "ubersreik"

		map_view_area_handler.set_active_area(map_view_area_handler, default_area)

		game_info.area = default_area
	else
		game_info.area = active_area
	end

	local selected_level_index = game_info.level_index or map_view_area_handler.selected_level_index(map_view_area_handler)

	if not selected_level_index or game_mode_changed then
		local default_level_index = 1
		game_info.level_index = default_level_index
	else
		game_info.level_index = selected_level_index
	end

	local play_sound = false
	local instant_change = true
	local level_information = map_view_area_handler.set_selected_level(map_view_area_handler, game_info.level_index, play_sound, instant_change)
	local level_filter_list = game_info.level_filter_list or self.level_filter:get_unmarked_levels()
	game_info.level_filter_list = level_filter_list

	if game_info.game_mode == "adventure" and game_info.use_level_filter then
		self._level_filter_active = true
	end

	local default_difficulty_rank = 2
	local difficulty_data = level_information.difficulty_data
	local selected_difficulty_rank = game_info.difficulty_rank or default_difficulty_rank
	local unlocked_rank = self._get_closest_unlocked_rank(self, selected_difficulty_rank, difficulty_data)
	game_info.difficulty_rank = unlocked_rank
	game_info.private = game_info.private or false
	self.game_info = game_info
	self.params.game_info = game_info

	print("Game Mode:", game_info.game_mode)
	print("Area:", game_info.area)
	print("Level:", game_info.level_index, game_info.level_key)
	print("Difficulty:", game_info.difficulty_rank)
	print("------------------------------------------")

	return 
end
StateMapViewOverview._get_closest_unlocked_rank = function (self, rank, difficulty_data)
	local return_rank = nil

	for i, data in ipairs(difficulty_data) do
		if data.unlocked then
			return_rank = (data.rank > rank and return_rank) or i
		end
	end

	return return_rank
end
StateMapViewOverview._apply_information = function (self)
	local map_view = self._map_view
	local map_view_area_handler = self.map_view_area_handler
	local game_info = self.params.game_info
	local level_key, level_information, level_index = map_view_area_handler.selected_level(map_view_area_handler)
	local difficulty_data = level_information.difficulty_data
	local scores = nil
	local difficulty_display_name = ""
	local difficulty_index = 1
	local difficulty_key = nil

	for i = 1, #difficulty_data, 1 do
		local data = difficulty_data[i]

		if data.rank == game_info.difficulty_rank then
			difficulty_display_name = data.setting_text
			scores = data.scores
			difficulty_index = i
			difficulty_key = data.key

			break
		end
	end

	local game_mode = game_info.game_mode
	local game_mode_settings = GameModeSettings[game_mode]
	local game_mode_display_name = game_mode_settings.display_name
	local level_image = level_information.level_image
	local display_name = level_information.display_name
	self._draw_best_performance = level_key ~= "any" and game_mode == "survival"

	if self._draw_best_performance and scores then
		local waves = tostring(scores.waves)
		local time = scores.time
		time = string.format("%.2d:%.2d:%.2d", math.floor(time / 3600), math.floor(time / 60) % 60, math.floor(time) % 60)
		self._wave_value_widget.content.text = waves
		self._time_value_widget.content.text = time
	end

	self._level_image_widget.content.texture_id = level_image
	self._mission_value_widget.content.text = Localize(display_name)
	self._game_mode_value_widget.content.text = Localize(game_mode_display_name)
	self._difficulty_value_widget.content.text = difficulty_display_name
	local difficulty_settings = DifficultySettings[difficulty_key]
	local map_screen_textures = difficulty_settings.map_screen_textures
	local top_texture = map_screen_textures.top
	local banner_texture = map_screen_textures.banner
	self._difficulty_banner_widget.content.text = difficulty_display_name
	self._difficulty_banner_widget.content.banner_texture = banner_texture
	local gui = self.ui_renderer.gui
	local gui_material = Gui.material(gui, banner_texture)

	Material.set_scalar(gui_material, "distortion_offset_top", 0.5)

	self._title_text_widget.content.text = game_mode_display_name
	self._level_text_widget.content.text = display_name

	self._set_private_enabled(self, game_info.private)

	return 
end
StateMapViewOverview.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._frame_left_widget = UIWidget.init(widgets.frame_left)
	self._frame_right_widget = UIWidget.init(widgets.frame_right)
	self._overlay_widget = UIWidget.init(widgets.overlay)
	self._title_text_widget = UIWidget.init(widgets.title_text)
	self._title_holder_widget = UIWidget.init(widgets.title_holder)
	self._title_holder_glow_widget = UIWidget.init(widgets.title_holder_glow)
	self._level_text_widget = UIWidget.init(widgets.level_text)
	self._private_text_widget = UIWidget.init(widgets.private_text)
	self._menu_rect_widget = UIWidget.init(widgets.menu_rect)
	self._player_list_bg_widget = UIWidget.init(widgets.player_list_bg)
	self._player_list_rect_widget = UIWidget.init(widgets.player_list_rect)
	self._background_widget = UIWidget.init(widgets.background)
	self._level_image_widget = UIWidget.init(widgets.level_image)
	self._level_image_frame_widget = UIWidget.init(widgets.level_image_frame)
	self._dead_space_filler_widget = UIWidget.init(widgets.dead_space_filler)
	self._player_list_conuter_text_widget = UIWidget.init(widgets.player_list_conuter_text)
	self._game_mode_prefix_widget = UIWidget.init(widgets.game_mode_prefix)
	self._mission_prefix_widget = UIWidget.init(widgets.mission_prefix)
	self._difficulty_prefix_widget = UIWidget.init(widgets.difficulty_prefix)
	self._game_type_prefix_widget = UIWidget.init(widgets.game_type_prefix)
	self._score_prefix_widget = UIWidget.init(widgets.score_prefix)
	self._wave_prefix_widget = UIWidget.init(widgets.wave_prefix)
	self._time_prefix_widget = UIWidget.init(widgets.time_prefix)
	self._game_mode_value_widget = UIWidget.init(widgets.game_mode_value)
	self._mission_value_widget = UIWidget.init(widgets.mission_value)
	self._difficulty_value_widget = UIWidget.init(widgets.difficulty_value)
	self._game_type_value_widget = UIWidget.init(widgets.game_type_value)
	self._wave_value_widget = UIWidget.init(widgets.wave_value)
	self._time_value_widget = UIWidget.init(widgets.time_value)
	self._game_info_title_widget = UIWidget.init(widgets.game_info_title)
	self._game_info_bg_widget = UIWidget.init(widgets.game_info_bg)
	self._score_info_bg_widget = UIWidget.init(widgets.score_info_bg)
	self._start_game_detail_widget = UIWidget.init(widgets.start_game_detail)
	self._start_game_detail_glow_widget = UIWidget.init(widgets.start_game_detail_glow)
	self._menu_selection_left = UIWidget.init(widgets.start_screen_selection_left)
	self._menu_selection_right = UIWidget.init(widgets.start_screen_selection_right)
	local gui = self.ui_renderer.gui
	self._difficulty_banner_widget = UIWidget.init(create_difficulty_banner("banner_pivot", gui))
	local elements = {}

	for index, widget_definition in ipairs(menu_button_definitions) do
		local widget = UIWidget.init(widget_definition)
		widget.style.text.horizontal_alignment = "center"
		widget.style.text.font_type = "hell_shark_header"
		elements[index] = widget
	end

	self._elements = elements
	local player_list_widgets = {}

	for i = 1, 4, 1 do
		local definition_name = "player_list_slot_" .. i
		local widget = UIWidget.init(widgets[definition_name])
		widget.content.always_show_icons = true
		widget.content.on_console = true
		widget.style.text.offset[1] = 55
		widget.style.host_icon.offset[1] = 410
		widget.style.kick_button_texture.offset[1] = 403
		widget.style.kick_button_texture.offset[2] = 2
		player_list_widgets[i] = widget
	end

	self._player_list_widgets = player_list_widgets
	self._navigation_player_list_widgets = {
		{
			widget = player_list_widgets[1],
			data = player_list_navigation_helper
		},
		{
			widget = player_list_widgets[2],
			data = player_list_navigation_helper
		},
		{
			widget = player_list_widgets[3],
			data = player_list_navigation_helper
		},
		{
			widget = player_list_widgets[4],
			data = player_list_navigation_helper
		}
	}

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	local selection_index = self.game_info.overview_selection_index or 1

	self._set_selection(self, selection_index, true)

	return 
end
StateMapViewOverview.on_exit = function (self, params)
	self.menu_input_description:destroy()

	self.menu_input_description = nil

	return 
end
StateMapViewOverview.update = function (self, dt, t)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	local transitioning = self._map_view:transitioning()

	if not transitioning then
		self._handle_input(self, dt, t)
	end

	self._update_player_list(self)
	self._update_elements(self, dt)
	self._update_private_animation(self, dt)
	self.draw(self, dt)

	local wanted_state = self._wanted_state(self)

	return wanted_state or self._new_state
end
StateMapViewOverview.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")
	local friends_list_active = self._map_view:friends_list_active()

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self._overlay_widget)
	UIRenderer.draw_widget(ui_renderer, self._menu_rect_widget)
	UIRenderer.draw_widget(ui_renderer, self._player_list_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self._background_widget)
	UIRenderer.draw_widget(ui_renderer, self._dead_space_filler_widget)
	UIRenderer.draw_widget(ui_renderer, self._player_list_conuter_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._title_holder_widget)
	UIRenderer.draw_widget(ui_renderer, self._title_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._title_holder_widget)
	UIRenderer.draw_widget(ui_renderer, self._title_holder_glow_widget)
	UIRenderer.draw_widget(ui_renderer, self._level_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._private_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._level_image_widget)
	UIRenderer.draw_widget(ui_renderer, self._level_image_frame_widget)
	UIRenderer.draw_widget(ui_renderer, self._game_mode_prefix_widget)
	UIRenderer.draw_widget(ui_renderer, self._mission_prefix_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_prefix_widget)
	UIRenderer.draw_widget(ui_renderer, self._game_type_prefix_widget)
	UIRenderer.draw_widget(ui_renderer, self._game_mode_value_widget)
	UIRenderer.draw_widget(ui_renderer, self._mission_value_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_value_widget)
	UIRenderer.draw_widget(ui_renderer, self._game_type_value_widget)
	UIRenderer.draw_widget(ui_renderer, self._game_info_title_widget)
	UIRenderer.draw_widget(ui_renderer, self._game_info_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self._start_game_detail_widget)
	UIRenderer.draw_widget(ui_renderer, self._start_game_detail_glow_widget)

	if self._draw_best_performance then
		UIRenderer.draw_widget(ui_renderer, self._score_info_bg_widget)
		UIRenderer.draw_widget(ui_renderer, self._score_prefix_widget)
		UIRenderer.draw_widget(ui_renderer, self._wave_prefix_widget)
		UIRenderer.draw_widget(ui_renderer, self._time_prefix_widget)
		UIRenderer.draw_widget(ui_renderer, self._wave_value_widget)
		UIRenderer.draw_widget(ui_renderer, self._time_value_widget)
	end

	if self._selection_index then
		UIRenderer.draw_widget(ui_renderer, self._menu_selection_left)
		UIRenderer.draw_widget(ui_renderer, self._menu_selection_right)
	end

	UIRenderer.draw_widget(ui_renderer, self._difficulty_banner_widget)

	local number_of_player = self._number_of_player or 0

	for i = 1, number_of_player, 1 do
		local widget = self._player_list_widgets[i]

		UIRenderer.draw_widget(ui_renderer, widget)
	end

	for _, widget in ipairs(self._elements) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	if not friends_list_active then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
StateMapViewOverview.post_update = function (self, dt, t)
	return 
end
StateMapViewOverview._handle_input = function (self, dt, t)
	if self._new_state then
		return 
	end

	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	else
		local new_selection_index = nil
		local selection_index = self._selection_index or 0
		local num_elements = #self._elements
		local friends_list_active = self._map_view:friends_list_active()
		local friends_input_service = input_manager.get_service(input_manager, "friends_view")

		if friends_list_active then
			if friends_input_service.get(friends_input_service, "toggle_menu") or friends_input_service.get(friends_input_service, "back") then
				self._map_view:deactivate_friends_menu()

				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		elseif input_service.get(input_service, "refresh") then
			self._map_view:on_friends_pressed()

			self.controller_cooldown = GamepadSettings.menu_cooldown
		else
			if self._player_list_selection_index then
				local player_list_selection_index = self._player_list_selection_index
				local number_of_player = self._number_of_player

				if input_service.get(input_service, "toggle_menu") or input_service.get(input_service, "back", true) then
					local return_to_game = not self.parent.ingame_ui.menu_active

					self.parent:exit(return_to_game)
				elseif input_service.get(input_service, "move_left") then
					self._deselect_player_list_widget(self, self._player_list_selection_index)

					self._player_list_selection_index = nil

					self.menu_input_description:change_generic_actions(generic_input_actions.default)

					self.controller_cooldown = GamepadSettings.menu_cooldown
					local selection_index = self.game_info.overview_selection_index or 1

					self._set_selection(self, selection_index)
					self._play_sound(self, "Play_hud_hover")
				else
					local handeld = self._handle_player_list_input(self, input_service, dt)

					if not handeld then
						if input_service.get(input_service, "move_up") or input_service.get(input_service, "move_up_hold") then
							new_selection_index = (player_list_selection_index - 2) % number_of_player + 1
						elseif input_service.get(input_service, "move_down") or input_service.get(input_service, "move_down_hold") then
							new_selection_index = player_list_selection_index % number_of_player + 1
						end
					else
						self.controller_cooldown = GamepadSettings.menu_cooldown

						self._play_sound(self, "Play_hud_select")
					end

					if new_selection_index and new_selection_index ~= self._player_list_selection_index then
						self.controller_cooldown = GamepadSettings.menu_cooldown

						self._deselect_player_list_widget(self, self._player_list_selection_index)
						self._select_player_list_widget(self, new_selection_index)
						self._play_sound(self, "Play_hud_hover")
					end
				end
			else
				if input_service.get(input_service, "move_right") and self._selection_index then
					self._select_player_list_widget(self, 1)
					self._deselect_element_by_index(self, self._selection_index)

					self._selection_index = nil

					self.menu_input_description:change_generic_actions(generic_input_actions.player_list)

					self.controller_cooldown = GamepadSettings.menu_cooldown

					self._play_sound(self, "Play_hud_hover")
				elseif input_service.get(input_service, "move_up") or input_service.get(input_service, "move_up_hold") then
					new_selection_index = (selection_index - 2) % num_elements + 1
				elseif input_service.get(input_service, "move_down") or input_service.get(input_service, "move_down_hold") then
					new_selection_index = selection_index % num_elements + 1
				end

				if new_selection_index and new_selection_index ~= self._selection_index then
					self.controller_cooldown = GamepadSettings.menu_cooldown

					self._play_sound(self, "Play_hud_hover")
					self._set_selection(self, new_selection_index)
				elseif input_service.get(input_service, "confirm", true) and self._selection_index then
					if self._selection_index == 4 then
						self._start_game(self, t)
						self._play_sound(self, "Play_hud_main_menu_open")
					else
						local state_function = self._menu_item_state_functions[self._selection_index]

						if state_function then
							local new_state = state_function(self.game_info)

							print("Go to new state:", self._selection_index, new_state)

							if new_state then
								self._new_state = new_state

								self._play_sound(self, "Play_hud_select")
							end
						end
					end
				elseif input_service.get(input_service, "toggle_menu") or input_service.get(input_service, "back", true) then
					local return_to_game = not self.parent.ingame_ui.menu_active

					self.parent:exit(return_to_game)
				end
			end

			if input_service.get(input_service, "left_stick_press") then
				local private_enabled = self.game_info.private

				self._set_private_enabled(self, not private_enabled, true)

				self.controller_cooldown = GamepadSettings.menu_cooldown

				self._play_sound(self, "Play_hud_select")
			end
		end
	end

	return 
end
StateMapViewOverview._deselect_element_by_index = function (self, index)
	if self._selection_timer then
		local instant = true

		self._update_elements(self, 0, instant)
	end

	self._selection_timer = 0

	return 
end
StateMapViewOverview._set_selection = function (self, index, instant)
	if self._selection_timer then
		local instant = true

		self._update_elements(self, 0, instant)
	end

	self._selection_index = index
	self.game_info.overview_selection_index = index

	if instant then
		self._update_elements(self, 0, instant)

		self._selection_timer = nil
	else
		self._selection_timer = 0
	end

	local widget = self._elements[index]
	local scenegraph_id = widget.scenegraph_id
	local ui_scenegraph = self.ui_scenegraph
	ui_scenegraph.selection_anchor.local_position[2] = ui_scenegraph[scenegraph_id].local_position[2]
	local widget_style = widget.style
	local text = widget.content.text_field
	local current_font_size = widget_style.text.font_size
	local default_font_size = widget.content.default_font_size
	widget_style.text.font_size = default_font_size + selection_font_increase
	local text_width, text_height = self._get_word_wrap_size(self, Localize(text), widget_style.text, 1000)
	ui_scenegraph.selection_anchor.size[1] = text_width or 0
	widget_style.text.font_size = current_font_size

	return 
end
StateMapViewOverview.update_selection_timer = function (self, dt)
	local timer = self._selection_timer

	if timer then
		local total_time = 0.15

		if timer == total_time then
			self._selection_timer = nil

			return 
		else
			timer = math.min(timer + dt, total_time)
			self._selection_timer = timer

			return timer / total_time
		end
	end

	return 
end
StateMapViewOverview._update_elements = function (self, dt, instant)
	local selection_progress = (instant and 1) or self.update_selection_timer(self, dt)

	if not selection_progress then
		return 
	end

	for index, widget in ipairs(self._elements) do
		self._animate_element(self, widget, index, selection_progress)
	end

	return 
end
StateMapViewOverview._animate_element = function (self, widget, index, progress)
	local is_selection_widget = self._selection_index == index
	local anim_progress = (is_selection_widget and math.easeCubic(progress)) or math.easeCubic(1 - progress)
	local widget_style = widget.style
	local rect_style = widget_style.rect
	local text_style = widget_style.text
	local default_font_size = widget.content.default_font_size
	local font_size_increase = anim_progress * ((default_font_size + selection_font_increase) - default_font_size)
	local text_color = text_style.text_color
	local text_offset = text_style.offset
	local default_font_size = widget.content.default_font_size
	local new_font_size = default_font_size + font_size_increase
	local animate_font_size = (is_selection_widget and text_style.font_size < new_font_size) or (not is_selection_widget and new_font_size < text_style.font_size)
	local normal_text_color = text_colors.text_color
	local selected_text_color = text_colors.text_color_selected

	if is_selection_widget or widget.style.text.text_color[2] ~= normal_text_color[2] then
		widget.style.text.text_color[2] = math.lerp(normal_text_color[2], selected_text_color[2], math.smoothstep(anim_progress, 0, 1))
	end

	if is_selection_widget or widget.style.text.text_color[3] ~= normal_text_color[3] then
		widget.style.text.text_color[3] = math.lerp(normal_text_color[3], selected_text_color[3], math.smoothstep(anim_progress, 0, 1))
	end

	if is_selection_widget or widget.style.text.text_color[4] ~= normal_text_color[4] then
		widget.style.text.text_color[4] = math.lerp(normal_text_color[4], selected_text_color[4], math.smoothstep(anim_progress, 0, 1))
	end

	if animate_font_size then
		text_style.font_size = new_font_size
	end

	if is_selection_widget then
		self._menu_selection_left.offset[1] = math.lerp(-25, 0, anim_progress)
		self._menu_selection_right.offset[1] = math.lerp(25, 0, anim_progress)
	end

	return 
end
StateMapViewOverview._start_game = function (self, t)
	local game_info = self.game_info
	local map_view_area_handler = self.map_view_area_handler
	local game_mode = game_info.game_mode
	local area = game_info.area

	if area == "world" then
		area = nil
	end

	local level_key, difficulty_key = nil
	local difficulty_rank = game_info.difficulty_rank
	local level_filter_list = game_info.level_filter_list

	if level_filter_list and self._level_filter_active then
		local level_difficulties = Managers.state.difficulty:get_level_difficulties(level_filter_list[1])

		for _, difficulty_name in ipairs(level_difficulties) do
			local data = DifficultySettings[difficulty_name]
			local rank = data.rank

			if rank == difficulty_rank then
				difficulty_key = difficulty_name

				break
			end
		end
	else
		local level_index = game_info.level_index
		local level_list = map_view_area_handler.active_level_list(map_view_area_handler)
		local level_data = level_list[level_index]
		local difficulty_data = map_view_area_handler.get_difficulty_data_by_level_index(map_view_area_handler, level_index)
		local difficulty_index = 1

		for i = 1, #difficulty_data, 1 do
			local data = difficulty_data[i]

			if data.rank == difficulty_rank then
				difficulty_index = i

				break
			end
		end

		local difficulty_layout = difficulty_data[difficulty_index]
		difficulty_key = difficulty_layout.key
		level_key = level_data.level_key
	end

	if difficulty_key then
		Managers.state.difficulty:set_difficulty(difficulty_key)
	end

	local random_level = level_key == "any"
	local private_game = game_info.private

	print("------------------------------------------")
	print("----------------START GAME----------------")
	print("------------------------------------------")
	print("Game Mode:", game_mode)
	print("Area:", area)
	print("Level:", level_key)
	print("Use Level Filter:", self._level_filter_active)

	if self._level_filter_active then
		print("------------------------------------------")
		table.dump(level_filter_list)
		print("------------------------------------------")
	end

	print("Difficulty:", difficulty_key)
	print("+++++++")
	print("Private Game:", private_game)
	print("Random Level:", random_level)
	print("+++++++")
	print("------------------------------------------")
	Managers.matchmaking:find_game(level_key, difficulty_key, private_game, random_level, game_mode, area, t, self._level_filter_active and level_filter_list)

	return 
end
StateMapViewOverview._wanted_state = function (self)
	local new_state = self.parent:wanted_gamepad_state()

	if new_state then
		self.parent:clear_wanted_gamepad_state()
	end

	return new_state
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

StateMapViewOverview._setup_own_player_in_player_list = function (self)
	local widgets = self._player_list_widgets
	local player_manager = self.player_manager
	local profile_synchronizer = self.profile_synchronizer
	local my_peer_id = self.peer_id
	local my_player = player_manager.player_from_peer_id(player_manager, my_peer_id)
	local player_unit = my_player.player_unit
	local widget_index_counter = 1
	local widget = widgets[widget_index_counter]
	local name = my_player.name(my_player)
	local display_name = (player_name_max_length < UTF8Utils.string_length(name) and UIRenderer.crop_text_width(self.ui_renderer, name, 350, widget.style.text)) or name
	widget.content.text = display_name
	widget.content.is_host = self.is_server
	local kick_enabled = false
	widget.content.kick_enabled = kick_enabled
	widget.content.kick_button_hotspot.disable_button = not kick_enabled
	widget.content.peer_id = my_peer_id
	local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, my_peer_id, my_player.local_player_id(my_player))

	if profile_index then
		local profile_data = SPProfiles[profile_index]
		local hero_name = profile_data.display_name
		local hero_icon_texture = UISettings.hero_icons.small[hero_name]
		widget.content.hero_icon_texture = hero_icon_texture
		widget.content.hero_icon_tooltip_text = hero_name
	end

	self._number_of_player = widget_index_counter or 0
	self._player_list_conuter_text_widget.content.text = widget_index_counter .. "/" .. 4

	return 
end
StateMapViewOverview._update_player_list = function (self)
	local widgets = self._player_list_widgets
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
				local name = player.name(player)
				local display_name = (player_name_max_length < UTF8Utils.string_length(name) and UIRenderer.crop_text_width(self.ui_renderer, name, 350, style.name)) or name
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
		end
	end

	self._number_of_player = widget_index_counter or 0
	self._player_list_conuter_text_widget.content.text = widget_index_counter .. "/" .. 4

	return 
end
StateMapViewOverview._get_text_size = function (self, localized_text, text_style)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, localized_text, font[1], scaled_font_size)

	return text_width, text_height
end
StateMapViewOverview._get_word_wrap_size = function (self, localized_text, text_style, text_area_width)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local lines = UIRenderer.word_wrap(self.ui_renderer, localized_text, font[1], scaled_font_size, text_area_width)
	local text_width, text_height = self._get_text_size(self, localized_text, text_style)

	return text_width, text_height * #lines
end
StateMapViewOverview._select_player_list_widget = function (self, index)
	local player_list_widgets = self._navigation_player_list_widgets
	local widget_data = player_list_widgets[index]
	local widget = widget_data.widget
	widget.content.button_hotspot.is_selected = true
	self._player_list_selection_index = index

	self._update_player_list_description(self)

	return 
end
StateMapViewOverview._deselect_player_list_widget = function (self, index)
	local player_list_widgets = self._navigation_player_list_widgets
	local widget_data = player_list_widgets[index]

	if widget_data then
		local widget = widget_data.widget
		widget.content.button_hotspot.is_selected = nil

		self.menu_input_description:set_input_description({})
	end

	return 
end
StateMapViewOverview._handle_player_list_input = function (self, input_service, dt)
	local player_list_widgets = self._navigation_player_list_widgets
	local player_list_selection_index = self._player_list_selection_index
	local selection_data = player_list_widgets[player_list_selection_index]
	local selected_widget_data = selection_data.data
	local widget = selection_data.widget

	if selected_widget_data then
		local input_result = selected_widget_data.input_function(widget, input_service)

		if input_result then
			local peer_id = widget.content.peer_id

			if peer_id then
				if input_result == "kick" then
					if widget.content.kick_enabled then
						local cb = callback(self, "on_kicked_player_callback")

						self._map_view:request_kick_player(peer_id, cb)
					end
				elseif input_result == "gamercard" then
					self._map_view:show_selected_player_gamercard(peer_id)
				end
			end
		end

		return input_result
	end

	return 
end
StateMapViewOverview._update_player_list_description = function (self)
	local player_list_selection_index = self._player_list_selection_index
	local is_player_list = player_list_selection_index ~= nil

	if is_player_list then
		local player_list_widgets = self._navigation_player_list_widgets
		local index = player_list_selection_index
		local widget_data = player_list_widgets[index]
		local widget = widget_data.widget
		local data = widget_data.data
		local input_description = (widget.content.kick_enabled and data.input_description) or {}

		self.menu_input_description:set_input_description(input_description)
	end

	return 
end
StateMapViewOverview.on_kicked_player_callback = function (self)
	local player_list_selection_index = self._player_list_selection_index
	local number_of_player = self._number_of_player

	if player_list_selection_index == number_of_player then
		local new_index = math.max(player_list_selection_index - 1, 1)

		if new_index ~= player_list_selection_index then
			self._deselect_player_list_widget(self, player_list_selection_index)
			self._select_player_list_widget(self, new_index)
		end
	end

	return 
end
StateMapViewOverview.update_private_animation_timer = function (self, dt)
	local timer = self._private_timer

	if timer then
		local total_time = 0.15

		if timer == total_time then
			self._private_timer = nil

			return 
		else
			timer = math.min(timer + dt, total_time)
			self._private_timer = timer

			return timer / total_time
		end
	end

	return 
end
StateMapViewOverview._update_private_animation = function (self, dt, instant)
	local progress = self.update_private_animation_timer(self, dt)

	if not progress then
		return 
	end

	local anim_progress = math.ease_pulse(progress)
	local text_style = self._private_text_widget.style.text
	text_style.font_size = 28 + 10 * anim_progress

	return 
end
StateMapViewOverview._set_private_enabled = function (self, enabled, animate)
	self.game_info.private = enabled
	local text = (enabled and "map_screen_private_button") or "map_public_setting"
	self._private_text_widget.content.text = text
	self._game_type_value_widget.content.text = Localize(text)

	if animate then
		self._private_timer = 0
	end

	return 
end
StateMapViewOverview._play_sound = function (self, event)
	self._map_view:play_sound(event)

	return 
end

return 
