local definitions = local_require("scripts/ui/views/map_view_states/definitions/state_map_view_game_mode_definitions")
local widgets = definitions.widgets
local element_size = definitions.element_size
local create_element = definitions.create_element
local game_mode_list = definitions.game_mode_list
local generic_input_actions = definitions.generic_input_actions
local textures_by_game_mode = definitions.textures_by_game_mode
local scenegraph_definition = definitions.scenegraph_definition
local game_mode_index_by_name = definitions.game_mode_index_by_name
local game_mode_display_names = definitions.game_mode_display_names
local condition_function_by_game_mode = definitions.condition_function_by_game_mode
local DO_RELOAD = false
StateMapViewGameMode = class(StateMapViewGameMode)
StateMapViewGameMode.NAME = "StateMapViewGameMode"
StateMapViewGameMode.on_enter = function (self, params)
	print("[MapViewState] Enter Substate StateMapViewGameMode")

	self.game_info = params.game_info
	local ingame_ui_context = params.ingame_ui_context
	self.map_view_area_handler = params.map_view_area_handler
	self.map_view_helper = params.map_view_helper
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	self._map_view = params.map_view
	self.platform = PLATFORM
	self.ui_animations = {}
	local input_service = self.input_manager:get_service("map_menu")
	local gui_layer = UILayer.default + 30
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 2, gui_layer, generic_input_actions.default)

	self.menu_input_description:set_input_description(nil)
	self.create_ui_elements(self, params)
	self._map_view:set_time_line_index(1)
	self._map_view:animate_title_text(self._title_text_widget)
	self._map_view:set_mask_enabled(true)

	return 
end
StateMapViewGameMode.create_ui_elements = function (self, params)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._overlay_widget = UIWidget.init(widgets.overlay)
	self._title_text_widget = UIWidget.init(widgets.title_text)
	self._background_widget = UIWidget.init(widgets.background)
	self._dead_space_filler_widget = UIWidget.init(widgets.dead_space_filler)
	self._frame_left_widget = UIWidget.init(widgets.frame_left)
	self._frame_right_widget = UIWidget.init(widgets.frame_right)
	self._fade_center_bottom_widget = UIWidget.init(widgets.fade_center_bottom)
	self._fade_center_top_widget = UIWidget.init(widgets.fade_center_top)
	self._edge_left_widget = UIWidget.init(widgets.edge_left)
	self._edge_right_widget = UIWidget.init(widgets.edge_right)
	local elements = {}

	for index, game_mode_name in ipairs(game_mode_list) do
		local game_mode_textures = textures_by_game_mode[game_mode_name]
		local display_name = game_mode_display_names[game_mode_name]
		local condition_function = condition_function_by_game_mode[game_mode_name]
		local is_game_mode_locked = false
		local description_text = ""

		if condition_function then
			is_game_mode_locked, description_text = condition_function(params)
		end

		if not is_game_mode_locked then
			description_text = Localize(GameModeSettings[game_mode_name].description_text)
		end

		elements[index] = UIWidget.init(create_element(index, "element_pivot", {
			255,
			255,
			255,
			0
		}, display_name, game_mode_textures, is_game_mode_locked, description_text))
	end

	self._elements = elements

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self._align_elements(self)
	self._gather_area_statistics(self)

	local game_mode = self.game_info.game_mode
	local game_mode_index = game_mode_index_by_name[game_mode] or 1

	self._set_selection(self, game_mode_index, true)
	self._update_elements(self, 0, true)

	self._selection_timer = nil

	self.start_open_animation(self)

	return 
end
StateMapViewGameMode._gather_area_statistics = function (self)
	local map_view_area_handler = self.map_view_area_handler
	local map_view_helper = self.map_view_helper
	local game_mode = self.game_info.game_mode
	local difficulty_manager = Managers.state.difficulty
	local level_settings = LevelSettings

	for _, game_mode in ipairs(game_mode_list) do
		local num_levels = 0
		local total_progress = 0
		local game_mode_area_list = map_view_area_handler.get_level_list_by_game_mode_and_area(map_view_area_handler, game_mode)

		for area, area_level_list in pairs(game_mode_area_list) do
			if game_mode == "adventure" and area == "world" then
			else
				for level_key, level_information in pairs(area_level_list) do
					if level_key ~= "any" then
						local visibility = level_information.visibility

						if visibility ~= "dlc" then
							num_levels = num_levels + 1
							local difficulties, _ = difficulty_manager.get_level_difficulties(difficulty_manager, level_key)
							local highest_available_difficulty_rank = 1

							for index, difficulty_name in ipairs(difficulties) do
								local difficulty_settings = DifficultySettings[difficulty_name]

								if highest_available_difficulty_rank < difficulty_settings.rank then
									highest_available_difficulty_rank = difficulty_settings.rank
								end
							end

							local highest_completed_difficulty_rank = map_view_helper.get_completed_level_difficulty(map_view_helper, level_key)
							local level_progress = highest_completed_difficulty_rank/highest_available_difficulty_rank
							total_progress = total_progress + level_progress
						end
					end
				end
			end
		end

		local progression_fraction = total_progress/num_levels
		local game_mode_index = game_mode_index_by_name[game_mode]
		local widget = self._elements[game_mode_index]
		widget.content.progress_text = math.floor(progression_fraction*100) .. "% " .. Localize("dlc1_2_survival_mission_wave_completed")
	end

	return 
end
StateMapViewGameMode.start_open_animation = function (self)
	self._transition_timer = 0.5

	for index, widget in ipairs(self._elements) do
		local target = widget.offset
		local target_index = 1
		local from = (index%2 == 0 and 1440) or -1440
		local to = target[target_index]
		local anim_time = 0.5

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, math.easeCubic)

		UIWidget.animate(widget, animation)
	end

	self._play_sound(self, "Play_hud_map_console_change_state_horizontal")

	return 
end
StateMapViewGameMode.start_close_animation = function (self)
	self._transition_timer = 0.5

	for index, widget in ipairs(self._elements) do
		local target = widget.offset
		local target_index = 1
		local from = target[target_index]
		local to = (index%2 == 0 and 1440) or -1440
		local anim_time = 0.5

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, math.easeCubic)

		UIWidget.animate(widget, animation)
	end

	self._map_view:animate_title_text(self._title_text_widget, true)
	self._play_sound(self, "Play_hud_map_console_change_state_horizontal")

	return 
end
StateMapViewGameMode.on_exit = function (self, params)
	self.menu_input_description:destroy()

	self.menu_input_description = nil

	return 
end
StateMapViewGameMode._update_transition_timer = function (self, dt)
	if not self._transition_timer then
		return 
	end

	if self._transition_timer == 0 then
		self._transition_timer = nil
	else
		self._transition_timer = math.max(self._transition_timer - dt, 0)
	end

	return 
end
StateMapViewGameMode.update = function (self, dt, t)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if not self._transition_timer then
		self._handle_input(self, dt)
	end

	self._update_elements(self, dt)
	self.draw(self, dt)
	self._update_transition_timer(self, dt)

	if not self._transition_timer then
		return self._new_state
	end

	return 
end
StateMapViewGameMode.post_update = function (self, dt, t)
	return 
end
StateMapViewGameMode._handle_input = function (self, dt)
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

		if input_service.get(input_service, "move_left") or input_service.get(input_service, "move_left_hold") then
			new_selection_index = 1
		elseif input_service.get(input_service, "move_right") or input_service.get(input_service, "move_right_hold") then
			new_selection_index = 2
		end

		if new_selection_index and new_selection_index ~= self._selection_index then
			self.controller_cooldown = GamepadSettings.menu_cooldown

			self._set_selection(self, new_selection_index)
		elseif input_service.get(input_service, "confirm", true) and self._selection_index and not self._is_selected_game_mode_locked then
			local game_info = self.game_info
			local game_mode = game_mode_list[self._selection_index]

			if game_mode ~= game_info.game_mode then
				game_info.game_mode = game_mode

				if game_mode == "survival" then
					game_info.area = "world"
					game_info.level_index = nil
				end
			end

			self._new_state = StateMapViewSelectLevel

			self._play_sound(self, "Play_hud_main_menu_open")
		elseif input_service.get(input_service, "back", true) then
			self._new_state = StateMapViewStart

			self._play_sound(self, "Play_hud_select")
		elseif input_service.get(input_service, "toggle_menu") then
			local return_to_game = not self.parent.ingame_ui.menu_active

			self._map_view:exit(return_to_game)
		end
	end

	if self._new_state then
		self.start_close_animation(self)
	end

	return 
end
StateMapViewGameMode.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self._background_widget)
	UIRenderer.draw_widget(ui_renderer, self._dead_space_filler_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_right_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_left_widget)
	UIRenderer.draw_widget(ui_renderer, self._fade_center_bottom_widget)
	UIRenderer.draw_widget(ui_renderer, self._fade_center_top_widget)
	UIRenderer.draw_widget(ui_renderer, self._title_text_widget)

	for _, widget in ipairs(self._elements) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	if not self._transition_timer then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
StateMapViewGameMode._align_elements = function (self)
	local num_elements = #self._elements
	local spacing = 0
	local element_width = element_size[1]
	local distance = element_width + spacing
	local start_offset = -distance*0.5

	for index, widget in ipairs(self._elements) do
		widget.offset[1] = start_offset + distance*(index - 1)
		widget.content.position_offset = widget.offset[1]
	end

	return 
end
StateMapViewGameMode._set_selection = function (self, index, ignore_sound)
	if self._selection_timer then
		local instant = true

		self._update_elements(self, 0, instant)
	end

	self._selection_timer = 0
	self._selection_index = index
	local widget = self._elements[index]
	local selection_locked = widget.content.locked
	self._is_selected_game_mode_locked = selection_locked
	local input_descriptions = (selection_locked and generic_input_actions.locked) or generic_input_actions.default

	self.menu_input_description:change_generic_actions(input_descriptions)

	if not ignore_sound then
		self._play_sound(self, "Play_hud_hover")
	end

	return 
end
StateMapViewGameMode.update_selection_timer = function (self, dt)
	local timer = self._selection_timer

	if timer then
		local total_time = 0.2

		if timer == total_time then
			self._selection_timer = nil

			return 
		else
			timer = math.min(timer + dt, total_time)
			self._selection_timer = timer

			return timer/total_time
		end
	end

	return 
end
StateMapViewGameMode._update_elements = function (self, dt, instant)
	local selection_progress = (instant and 1) or self.update_selection_timer(self, dt)

	if not selection_progress then
		return 
	end

	for index, widget in ipairs(self._elements) do
		self._animate_element(self, widget, index, selection_progress)
	end

	return 
end
StateMapViewGameMode._animate_element = function (self, widget, index, progress)
	local is_selection_widget = self._selection_index == index
	local anim_progress = (is_selection_widget and math.easeCubic(progress)) or math.easeCubic(progress - 1)
	local widget_style = widget.style
	local rect_style = widget_style.rect
	local background_texture_selected_style = widget_style.background_texture_selected
	local description_rect_style = widget_style.description_rect
	local description_text_style = widget_style.description_text
	local levels_count_text_style = widget_style.levels_count_text
	local locked_texture_style = widget_style.locked_texture
	local overlay_style = widget_style.overlay
	local glow_left_texture_style = widget_style.glow_left_texture
	local glow_right_texture_style = widget_style.glow_right_texture
	local alpha = anim_progress*255
	local rect_alpha = anim_progress*170
	overlay_style.color[1] = (anim_progress - 1)*170
	background_texture_selected_style.color[1] = alpha
	description_rect_style.color[1] = rect_alpha
	description_text_style.text_color[1] = alpha
	glow_left_texture_style.color[1] = alpha
	glow_right_texture_style.color[1] = alpha
	local lock_color = locked_texture_style.color
	local lock_color_value = anim_progress*75 + 180
	lock_color[2] = lock_color_value
	lock_color[3] = lock_color_value
	lock_color[4] = lock_color_value
	local normal_text_color = widget.content.text_color
	local selected_text_color = widget.content.text_color_selected
	widget.style.text.text_color[2] = math.lerp(normal_text_color[2], selected_text_color[2], math.smoothstep(anim_progress, 0, 1))
	widget.style.text.text_color[3] = math.lerp(normal_text_color[3], selected_text_color[3], math.smoothstep(anim_progress, 0, 1))
	widget.style.text.text_color[4] = math.lerp(normal_text_color[4], selected_text_color[4], math.smoothstep(anim_progress, 0, 1))
	widget.style.progress_text.text_color[2] = widget.style.text.text_color[2]
	widget.style.progress_text.text_color[3] = widget.style.text.text_color[3]
	widget.style.progress_text.text_color[4] = widget.style.text.text_color[4]
	levels_count_text_style.text_color[2] = widget.style.text.text_color[2]
	levels_count_text_style.text_color[3] = widget.style.text.text_color[3]
	levels_count_text_style.text_color[4] = widget.style.text.text_color[4]

	return 
end
StateMapViewGameMode._show_store_page = function (self, dlc_name)
	if self.platform == "win32" then
		local dlc_id = Managers.unlock:dlc_id(dlc_name)

		if rawget(_G, "Steam") then
			Steam.open_overlay_store(dlc_id)
		end
	elseif self.platform == "xb1" then
		local user_id = Managers.account:user_id()

		XboxLive.show_marketplace(user_id)
	elseif self.platform == "ps4" then
		local user_id = Managers.account:user_id()
		local product_label = Managers.unlock:ps4_dlc_product_label(dlc_name)

		Managers.system_dialog:open_commerce_dialog(NpCommerceDialog.MODE_PRODUCT, user_id, {
			product_label
		})
	end

	return 
end
StateMapViewGameMode._play_sound = function (self, event)
	self._map_view:play_sound(event)

	return 
end

return 
