local definitions = local_require("scripts/ui/views/map_view_states/definitions/state_map_view_select_area_definitions")
local widgets = definitions.widgets
local element_size = definitions.element_size
local create_element = definitions.create_element
local textures_by_area = definitions.textures_by_area
local scenegraph_definition = definitions.scenegraph_definition
local generic_input_actions = definitions.generic_input_actions
local DO_RELOAD = false
StateMapViewSelectArea = class(StateMapViewSelectArea)
StateMapViewSelectArea.NAME = "StateMapViewSelectArea"

StateMapViewSelectArea.on_enter = function (self, params)
	print("[MapViewState] Enter Substate StateMapViewSelectArea")

	self.game_info = params.game_info
	local ingame_ui_context = params.ingame_ui_context
	self.map_view_area_handler = params.map_view_area_handler
	self.map_view_helper = params.map_view_helper
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.level_filter = params.level_filter
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
	self:create_ui_elements()
end

StateMapViewSelectArea.create_ui_elements = function (self)
	self:_setup_elements_level_data()

	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._overlay_widget = UIWidget.init(widgets.overlay)
	self._title_text_widget = UIWidget.init(widgets.title_text)
	self._background_widget = UIWidget.init(widgets.background)
	self._dead_space_filler_widget = UIWidget.init(widgets.dead_space_filler)
	self._frame_left_widget = UIWidget.init(widgets.frame_left)
	self._frame_right_widget = UIWidget.init(widgets.frame_right)
	self._frame_center_widget = UIWidget.init(widgets.frame_center)
	local elements = {}
	local area_list_by_index = {}
	local area_list_index_by_name = {}

	for index, level_data in ipairs(self._active_level_list) do
		local level_information = level_data.level_information
		local level_image = level_information.level_image
		local area = level_information.area
		local area_settings = AreaSettings[area]
		local area_textures = textures_by_area[area]
		local display_name = area_settings.display_name
		local dlc_name = area_settings.dlc_name
		local difficulty_data = level_information.difficulty_data
		local locked = false
		local locked_dlc_name = nil
		local description_text = ""

		if dlc_name and not Managers.unlock:is_dlc_unlocked(dlc_name) then
			locked = true
			locked_dlc_name = dlc_name
			description_text = Localize("dlc1_2_dlc_level_locked_tooltip")
		end

		elements[index] = UIWidget.init(create_element("element_pivot", {
			255,
			255,
			255,
			0
		}, Localize(display_name), area_textures, locked, locked_dlc_name, description_text))
		area_list_by_index[index] = area
		area_list_index_by_name[area] = index
	end

	self._elements = elements
	self._area_list_by_index = area_list_by_index
	self._area_list_index_by_name = area_list_index_by_name
	local borders = {}

	for i = 1, #elements + 1, 1 do
		borders[i] = UIWidget.init(widgets.frame_center)
	end

	self._borders = borders

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self:_align_elements()
	self:_gather_area_statistics()

	local area = self.game_info.area or "ubersreik"
	local area_index = area_list_index_by_name[area]

	self:_set_selection(area_index, true)
	self:_update_elements(0, true)

	self._selection_timer = nil
end

StateMapViewSelectArea._gather_area_statistics = function (self)
	local map_view_area_handler = self.map_view_area_handler
	local map_view_helper = self.map_view_helper
	local game_mode = self.game_info.game_mode
	local difficulty_manager = Managers.state.difficulty
	local level_settings = LevelSettings
	local num_unlocked_levels_by_area = self._num_unlocked_levels_by_area

	for area, index in pairs(self._area_list_index_by_name) do
		local num_levels = 0
		local total_progress = 0
		local unlocked_levels = num_unlocked_levels_by_area[area]

		for _, level_key in ipairs(UnlockableLevels) do
			local settings = level_settings[level_key]
			local map_settings = settings.map_settings

			if map_settings and map_settings.area == area then
				num_levels = num_levels + 1
				local difficulties, _ = difficulty_manager:get_level_difficulties(level_key)
				local highest_available_difficulty_rank = 1

				for _, difficulty_name in ipairs(difficulties) do
					local difficulty_settings = DifficultySettings[difficulty_name]

					if highest_available_difficulty_rank < difficulty_settings.rank then
						highest_available_difficulty_rank = difficulty_settings.rank
					end
				end

				local highest_completed_difficulty_rank = map_view_helper:get_completed_level_difficulty(level_key)
				local level_progress = highest_completed_difficulty_rank / highest_available_difficulty_rank
				total_progress = total_progress + level_progress
			end
		end

		local progression_fraction = total_progress / num_levels
		local area_index = self._area_list_index_by_name[area]
		local widget = self._elements[area_index]
		widget.content.progress_text = math.floor(progression_fraction * 100) .. "% " .. Localize("dlc1_2_survival_mission_wave_completed")
		widget.content.levels_count_text = string.format(Localize("map_screen_level_count"), unlocked_levels, num_levels)
	end
end

StateMapViewSelectArea._setup_elements_level_data = function (self)
	local map_view_area_handler = self.map_view_area_handler

	map_view_area_handler:set_active_area("world")

	self._active_level_list = map_view_area_handler:active_level_list()
	local num_unlocked_levels_by_area = {}
	local game_mode = self.game_info.game_mode

	for _, area_data in pairs(self._active_level_list) do
		local level_information = area_data.level_information
		local area = level_information.area
		num_unlocked_levels_by_area[area] = 0
		local level_list = map_view_area_handler:get_level_list_by_game_mode_and_area(game_mode, area)

		for level_key, level_information in pairs(level_list) do
			local visibility = level_information.visibility

			if visibility == "visible" and level_key ~= "any" then
				num_unlocked_levels_by_area[area] = num_unlocked_levels_by_area[area] + 1
			end
		end
	end

	self._num_unlocked_levels_by_area = num_unlocked_levels_by_area
	self._num_levels = #self._active_level_list
end

StateMapViewSelectArea.on_exit = function (self, params)
	self.menu_input_description:destroy()

	self.menu_input_description = nil
end

StateMapViewSelectArea._update_filter_animation = function (self, dt)
	local level_filter = self.level_filter
	local fraction = level_filter:visibility_fraction()
	local ui_scenegraph = self.ui_scenegraph
	ui_scenegraph.overlay.local_position[1] = 250 * fraction
end

StateMapViewSelectArea.update = function (self, dt, t)
	if DO_RELOAD then
		DO_RELOAD = false

		self:create_ui_elements()
	end

	self:_handle_input(dt)
	self:_update_elements(dt)
	self.level_filter:update(dt, t)
	self:_update_filter_animation(dt)
	self:draw(dt)

	return self._new_state
end

StateMapViewSelectArea.post_update = function (self, dt, t)
	return
end

StateMapViewSelectArea._handle_input = function (self, dt)
	if self._new_state then
		return
	end

	local input_manager = self.input_manager
	local input_service = input_manager:get_service("map_menu")
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and controller_cooldown > 0 then
		self.controller_cooldown = controller_cooldown - dt
	else
		local new_selection_index = nil

		if input_service:get("move_left") or input_service:get("move_left_hold") then
			new_selection_index = 1
		elseif input_service:get("move_right") or input_service:get("move_right_hold") then
			new_selection_index = 2
		end

		if new_selection_index and new_selection_index ~= self._selection_index then
			self.controller_cooldown = GamepadSettings.menu_cooldown

			self:_set_selection(new_selection_index)
		elseif input_service:get("confirm", true) then
			if self._selection_index and not self._is_selected_area_locked then
				local area_name = self._area_list_by_index[self._selection_index]
				local map_view_area_handler = self.map_view_area_handler
				local play_sound = false
				local instant_change = true

				map_view_area_handler:set_selected_level(self._selection_index, play_sound, instant_change)
				map_view_area_handler:open_selected_area()

				self._new_state = StateMapViewSelectLevel

				self:_play_sound("Play_hud_select")
			elseif self._is_selected_area_locked and self._selected_area_dlc_name then
				local dlc_name = self._selected_area_dlc_name

				self:_play_sound("Play_hud_select")
				self:_show_store_page(dlc_name)
			end
		elseif input_service:get("back", true) then
			self.map_view_area_handler:set_active_area(self.game_info.area)

			self._new_state = StateMapViewOverview

			self:_play_sound("Play_hud_select")
		elseif input_service:get("cycle_previous") then
			self.controller_cooldown = GamepadSettings.menu_cooldown
			local level_filter = self.level_filter

			level_filter:toggle_visibility()
		end
	end
end

StateMapViewSelectArea.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("map_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self._title_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._dead_space_filler_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_right_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_left_widget)

	for _, widget in ipairs(self._elements) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	for _, widget in ipairs(self._borders) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)
	self.menu_input_description:draw(ui_renderer, dt)
end

StateMapViewSelectArea._align_elements = function (self)
	local num_elements = #self._elements
	local spacing = 0
	local element_width = element_size[1]
	local distance = element_width + spacing
	local start_offset = -distance * 0.5

	for index, widget in ipairs(self._elements) do
		widget.offset[1] = start_offset + distance * (index - 1)
		widget.content.position_offset = widget.offset[1]
	end

	start_offset = -distance

	for index, widget in ipairs(self._borders) do
		widget.offset[1] = start_offset + distance * (index - 1)
	end
end

StateMapViewSelectArea._set_selection = function (self, index, ignore_sound)
	if self._selection_timer then
		local instant = true

		self:_update_elements(0, instant)
	end

	self._selection_timer = 0
	self._selection_index = index
	local widget = self._elements[index]
	local selection_locked = widget.content.locked
	local selected_dlc_name = widget.content.dlc_name
	self._is_selected_area_locked = selection_locked
	self._selected_area_dlc_name = selected_dlc_name
	local input_descriptions = nil

	if selected_dlc_name then
		input_descriptions = generic_input_actions.dlc
	elseif selection_locked then
		input_descriptions = generic_input_actions.locked
	else
		input_descriptions = generic_input_actions.default
	end

	if input_descriptions then
		self.menu_input_description:change_generic_actions(input_descriptions)
	end

	if not ignore_sound then
		self:_play_sound("Play_hud_hover")
	end
end

StateMapViewSelectArea.update_selection_timer = function (self, dt)
	local timer = self._selection_timer

	if timer then
		local total_time = 0.2

		if timer == total_time then
			self._selection_timer = nil

			return
		else
			timer = math.min(timer + dt, total_time)
			self._selection_timer = timer

			return timer / total_time
		end
	end
end

StateMapViewSelectArea._update_elements = function (self, dt, instant)
	local selection_progress = (instant and 1) or self:update_selection_timer(dt)

	if not selection_progress then
		return
	end

	for index, widget in ipairs(self._elements) do
		self:_animate_element(widget, index, selection_progress)
	end
end

StateMapViewSelectArea._animate_element = function (self, widget, index, progress)
	local is_selection_widget = self._selection_index == index
	local anim_progress = (is_selection_widget and math.easeCubic(progress)) or math.easeCubic(1 - progress)
	local widget_style = widget.style
	local rect_style = widget_style.rect
	local background_texture_selected_style = widget_style.background_texture_selected
	local description_rect_style = widget_style.description_rect
	local description_text_style = widget_style.description_text
	local levels_count_text_style = widget_style.levels_count_text
	local locked_texture_style = widget_style.locked_texture
	local dlc_texture_style = widget_style.dlc_texture
	local overlay_style = widget_style.overlay
	local glow_left_texture_style = widget_style.glow_left_texture
	local glow_right_texture_style = widget_style.glow_right_texture
	local alpha = anim_progress * 255
	local rect_alpha = anim_progress * 80
	overlay_style.color[1] = (1 - anim_progress) * 170
	background_texture_selected_style.color[1] = alpha
	description_rect_style.color[1] = rect_alpha
	description_text_style.text_color[1] = alpha
	glow_left_texture_style.color[1] = alpha
	glow_right_texture_style.color[1] = alpha
	local lock_color = locked_texture_style.color
	local dlc_lock_color = dlc_texture_style.color
	local lock_color_value = 180 + 75 * anim_progress
	lock_color[2] = lock_color_value
	lock_color[3] = lock_color_value
	lock_color[4] = lock_color_value
	dlc_lock_color[2] = lock_color_value
	dlc_lock_color[3] = lock_color_value
	dlc_lock_color[4] = lock_color_value
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
end

StateMapViewSelectArea._show_store_page = function (self, dlc_name)
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
end

StateMapViewSelectArea._play_sound = function (self, event)
	self._map_view:play_sound(event)
end

return
