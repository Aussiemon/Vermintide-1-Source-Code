local definitions = local_require("scripts/ui/views/map_view_states/definitions/state_map_view_select_difficulty_definitions")
local widgets = definitions.widgets
local element_size = definitions.element_size
local create_element = definitions.create_element
local scenegraph_definition = definitions.scenegraph_definition
local generic_input_actions = definitions.generic_input_actions
local DO_RELOAD = false
StateMapViewSelectDifficulty = class(StateMapViewSelectDifficulty)
StateMapViewSelectDifficulty.NAME = "StateMapViewSelectDifficulty"

StateMapViewSelectDifficulty.on_enter = function (self, params)
	print("[MapViewState] Enter Substate StateMapViewSelectDifficulty")

	self.game_info = params.game_info
	local ingame_ui_context = params.ingame_ui_context
	self.map_view_area_handler = params.map_view_area_handler
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	self._map_view = params.map_view
	self.level_filter = params.level_filter
	local level_key = nil
	local game_mode = self.game_info.game_mode

	if game_mode == "adventure" and self.game_info.use_level_filter then
		self._level_filter_active = true
		level_key = self.game_info.level_filter_list[1]
	else
		level_key = self.game_info.level_key
	end

	local level_information = self.map_view_area_handler:get_level_information_by_game_mode(level_key, game_mode)
	local difficulty_data = level_information.difficulty_data
	self._difficulty_data = difficulty_data
	self.platform = PLATFORM
	self.ui_animations = {}
	local input_service = self.input_manager:get_service("map_menu")
	local gui_layer = UILayer.default + 30
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 2, gui_layer, generic_input_actions.default)

	self.menu_input_description:set_input_description(nil)
	self:create_ui_elements()
	self._map_view:set_time_line_index(3)
	self._map_view:animate_title_text(self._title_text_widget)
	self._map_view:set_mask_enabled(true)
end

StateMapViewSelectDifficulty.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._frame_left_widget = UIWidget.init(widgets.frame_left)
	self._frame_right_widget = UIWidget.init(widgets.frame_right)
	self._mask_layer_widget = UIWidget.init(widgets.mask_layer)
	self._mask_layer_edge_widget = UIWidget.init(widgets.mask_layer_edge)
	self._edge_left_widget = UIWidget.init(widgets.edge_left)
	self._edge_right_widget = UIWidget.init(widgets.edge_right)
	self._start_game_detail_widget = UIWidget.init(widgets.start_game_detail)
	self._start_game_detail_glow_widget = UIWidget.init(widgets.start_game_detail_glow)
	self._dead_space_filler_widget = UIWidget.init(widgets.dead_space_filler)
	self._overlay_widget = UIWidget.init(widgets.overlay)
	self._title_text_widget = UIWidget.init(widgets.title_text)
	self._background_widget = UIWidget.init(widgets.background)
	self._selection_text_widget = UIWidget.init(widgets.selection_text)
	self._selection_text_widget.style.text.localize = false
	local gui = self.ui_renderer.gui
	local default_rank = nil
	local elements = {}
	local difficulty_index_table = {}
	local index_counter = 1

	for index, data in ipairs(self._difficulty_data) do
		if data.available then
			default_rank = default_rank or data.rank
			elements[index_counter] = UIWidget.init(create_element("element_pivot", {
				0,
				255,
				255,
				0
			}, index, data, gui))
			difficulty_index_table[index_counter] = index
			index_counter = index_counter + 1
		end
	end

	self._elements = elements
	self._difficulty_index_table = difficulty_index_table

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	local difficulty_rank = self.game_info.difficulty_rank or default_rank
	local widget_index = self:_get_widget_index_by_rank(difficulty_rank, true) or 1

	self:_align_elements(widget_index)
	self:_set_selection(widget_index)
	self:_update_elements(0, true)

	self._selection_timer = nil

	self:start_open_animation()
end

StateMapViewSelectDifficulty._get_widget_index_by_rank = function (self, rank, use_closest_unlocked_index)
	local elements = self._elements
	local difficulty_index_table = self._difficulty_index_table
	local closest_unlocked_index = nil

	for i, widget in ipairs(elements) do
		if use_closest_unlocked_index then
			if not widget.content.locked and widget.content.rank <= rank then
				closest_unlocked_index = i
			end
		elseif widget.content.rank == rank then
			return i
		end
	end

	if use_closest_unlocked_index then
		return closest_unlocked_index
	end
end

StateMapViewSelectDifficulty._get_widget_index_by_read_index = function (self, index)
	local difficulty_index_table = self._difficulty_index_table

	for i, value in pairs(difficulty_index_table) do
		if i == index then
			return value
		end
	end
end

StateMapViewSelectDifficulty.on_exit = function (self, params)
	self.menu_input_description:destroy()

	self.menu_input_description = nil
end

StateMapViewSelectDifficulty._update_transition_timer = function (self, dt)
	if not self._transition_timer then
		return
	end

	if self._transition_timer == 0 then
		self._transition_timer = nil
	else
		self._transition_timer = math.max(self._transition_timer - dt, 0)
	end
end

StateMapViewSelectDifficulty.update = function (self, dt, t)
	if DO_RELOAD then
		DO_RELOAD = false

		self:create_ui_elements()
	end

	if not self._transition_timer then
		self:_handle_input(dt)
	end

	self:_update_elements(dt)
	self:draw(dt)
	self:_update_transition_timer(dt)

	if not self._transition_timer then
		return self._new_state
	end
end

StateMapViewSelectDifficulty.post_update = function (self, dt, t)
	return
end

StateMapViewSelectDifficulty._handle_input = function (self, dt)
	if self._new_state then
		return
	end

	local input_manager = self.input_manager
	local input_service = input_manager:get_service("map_menu")
	local going_back = false
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and controller_cooldown > 0 then
		self.controller_cooldown = controller_cooldown - dt
	elseif not self._selection_timer then
		local new_selection_index = nil

		if input_service:get("move_left") or input_service:get("move_left_hold") then
			new_selection_index = math.max(self._selection_index - 1, 1)
		elseif input_service:get("move_right") or input_service:get("move_right_hold") then
			new_selection_index = math.min(self._selection_index + 1, #self._elements)
		end

		if new_selection_index and new_selection_index ~= self._selection_index then
			self.controller_cooldown = GamepadSettings.menu_cooldown

			self:_set_selection(new_selection_index)
			self:_play_sound("Play_hud_shift")
		elseif input_service:get("confirm", true) and self._selection_index then
			if not self._is_selected_difficulty_locked then
				self.game_info.difficulty_rank = self._selected_difficulty_rank
				self._new_state = StateMapViewSummary

				self:_play_sound("Play_hud_main_menu_open")
			end
		elseif input_service:get("back", true) then
			local game_info = self.game_info

			if game_info.change_difficulty then
				local current_area = game_info.area
				local current_level_key = game_info.level_key
				local current_level_index = game_info.level_index
				game_info.area = game_info.previous_info.area
				game_info.level_key = game_info.previous_info.level_key
				game_info.level_index = game_info.previous_info.level_index
				game_info.previous_info.area = current_area
				game_info.previous_info.level_key = current_level_key
				game_info.previous_info.level_index = current_level_index
				local same_area = current_area == game_info.area
				local index_to_select = (same_area and game_info.level_index) or 1

				self.map_view_area_handler:set_selected_level(index_to_select, false, true)

				game_info.change_difficulty = nil
				self._new_state = StateMapViewSelectLevel
			else
				self._new_state = StateMapViewSelectLevel
			end

			self:_play_sound("Play_hud_select")

			going_back = true
		elseif input_service:get("toggle_menu") then
			local return_to_game = not self.parent.ingame_ui.menu_active

			self._map_view:exit(return_to_game)
		end
	end

	if self._new_state then
		self:start_close_animation(going_back)
	end
end

StateMapViewSelectDifficulty.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("map_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self._start_game_detail_widget)
	UIRenderer.draw_widget(ui_renderer, self._start_game_detail_glow_widget)
	UIRenderer.draw_widget(ui_renderer, self._title_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._selection_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._background_widget)
	UIRenderer.draw_widget(ui_renderer, self._dead_space_filler_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_left_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_right_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_left_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_right_widget)

	for _, widget in ipairs(self._elements) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	if not self._transition_timer then
		self.menu_input_description:draw(ui_renderer, dt)
	end
end

local function anim_func(t)
	t = math.smoothstep(t, 0, 1)
	local b = 0
	local c = 1
	local d = 1
	local ts = t / d * t
	local tc = ts * t

	return b + c * (2.7 * tc * ts + -14.2975 * ts * ts + 26.095 * tc + -21.195 * ts + 7.6975 * t)
end

StateMapViewSelectDifficulty.start_open_animation = function (self)
	self._transition_timer = 1

	for index, widget in ipairs(self._elements) do
		local target = widget.offset
		local target_index = 2
		local from = -1000
		local to = target[target_index]
		local is_selected = index == self._selection_index
		local anim_time = (is_selected and 0.75) or 0.85

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, anim_func)

		UIWidget.animate(widget, animation)
	end

	local start_game_detail_widget = self._start_game_detail_widget
	start_game_detail_widget.style.texture_id.color[1] = 0
	local detail_background_animation = UIAnimation.init(UIAnimation.wait, 0.5, UIAnimation.function_by_time, start_game_detail_widget.style.texture_id.color, 1, 0, 255, 0.15, math.easeCubic)

	UIWidget.animate(start_game_detail_widget, detail_background_animation)

	local start_game_detail_glow_widget = self._start_game_detail_glow_widget
	start_game_detail_glow_widget.style.texture_id.color[1] = 0
	local detail_glow_animation = UIAnimation.init(UIAnimation.wait, 0.5, UIAnimation.function_by_time, start_game_detail_glow_widget.style.texture_id.color, 1, 0, 255, 0.15, math.easeCubic)

	UIWidget.animate(start_game_detail_glow_widget, detail_glow_animation)

	local selection_text_widget = self._selection_text_widget
	selection_text_widget.style.text.text_color[1] = 0
	local selection_text_animation = UIAnimation.init(UIAnimation.wait, 0.5, UIAnimation.function_by_time, selection_text_widget.style.text.text_color, 1, 0, 255, 0.15, math.easeCubic)

	UIWidget.animate(selection_text_widget, selection_text_animation)
	self:_play_sound("Play_hud_map_console_change_state_vertical")
end

StateMapViewSelectDifficulty.start_close_animation = function (self, going_back)
	self._transition_timer = (going_back and 0.9) or 0.75

	for index, widget in ipairs(self._elements) do
		local target = widget.offset
		local target_index = 2
		local from = target[target_index]
		local to = 1000
		local is_selected = index == self._selection_index
		local animate_up = not is_selected or going_back

		if animate_up then
			local anim_time = 0.75
			local anim_wait_time = (is_selected and 0.15) or 0

			table.clear(widget.animations)

			local animation = UIAnimation.init(UIAnimation.wait, anim_wait_time, UIAnimation.function_by_time, target, target_index, from, to, anim_time, anim_func)

			UIWidget.animate(widget, animation)
		else
			local style = widget.style
			local banner_style = style.banner_texture
			local banner_size = banner_style.size
			local banner_offset = banner_style.offset

			table.clear(widget.animations)

			local from = 1
			local to = 1.2
			local anim_time = 0.2
			local math_func = math.easeCubic
			local animation_in_width = UIAnimation.init(UIAnimation.function_by_time, banner_size, 1, banner_size[1] * from, banner_size[1] * to, anim_time, math_func)
			local animation_in_height = UIAnimation.init(UIAnimation.function_by_time, banner_size, 2, banner_size[2] * from, banner_size[2] * to, anim_time, math_func)
			local animation_in_offset_width = UIAnimation.init(UIAnimation.function_by_time, banner_offset, 1, banner_offset[1] * from, banner_offset[1] * to, anim_time, math_func)
			local animation_in_offset_height = UIAnimation.init(UIAnimation.function_by_time, banner_offset, 2, banner_offset[2] * from, banner_offset[2] - 150, anim_time, math_func)

			UIWidget.animate(widget, animation_in_width)
			UIWidget.animate(widget, animation_in_height)
			UIWidget.animate(widget, animation_in_offset_width)
			UIWidget.animate(widget, animation_in_offset_height)

			local wait_time = anim_time
			anim_time = 0.15
			math_func = math.ease_out_exp
			local animation_out_width = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, banner_size, 1, banner_size[1] * to, banner_size[1] * from, anim_time, math_func)
			local animation_out_height = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, banner_size, 2, banner_size[2] * to, banner_size[2] * from, anim_time, math_func)
			local animation_out_offset_width = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, banner_offset, 1, banner_offset[1] * to, banner_offset[1] * from, anim_time, math_func)
			local animation_out_offset_height = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, banner_offset, 2, banner_offset[2] - 150, banner_offset[2] + 25, anim_time, math_func)

			UIWidget.animate(widget, animation_out_width)
			UIWidget.animate(widget, animation_out_height)
			UIWidget.animate(widget, animation_out_offset_width)
			UIWidget.animate(widget, animation_out_offset_height)
		end
	end

	local start_game_detail_widget = self._start_game_detail_widget
	local detail_background_animation = UIAnimation.init(UIAnimation.function_by_time, start_game_detail_widget.style.texture_id.color, 1, start_game_detail_widget.style.texture_id.color[1], 0, 0.15, math.easeCubic)

	UIWidget.animate(start_game_detail_widget, detail_background_animation)

	local start_game_detail_glow_widget = self._start_game_detail_glow_widget
	local detail_glow_animation = UIAnimation.init(UIAnimation.function_by_time, start_game_detail_glow_widget.style.texture_id.color, 1, start_game_detail_glow_widget.style.texture_id.color[1], 0, 0.15, math.easeCubic)

	UIWidget.animate(start_game_detail_glow_widget, detail_glow_animation)

	local selection_text_widget = self._selection_text_widget
	local selection_text_animation = UIAnimation.init(UIAnimation.function_by_time, selection_text_widget.style.text.text_color, 1, selection_text_widget.style.text.text_color[1], 0, 0.15, math.easeCubic)

	UIWidget.animate(selection_text_widget, selection_text_animation)
	self._map_view:animate_title_text(self._title_text_widget, true)
	self:_play_sound("Play_hud_map_console_change_state_vertical")
end

StateMapViewSelectDifficulty._align_elements = function (self, selected_index)
	local num_elements = #self._elements
	local spacing = 15
	local element_width = element_size[1]
	local distance = element_width + spacing
	local start_offset = -(distance * math.max(selected_index - 2, 0))

	for index, widget in ipairs(self._elements) do
		widget.offset[1] = start_offset + distance * (index - 1)
		widget.content.position_offset = widget.offset[1]
	end
end

StateMapViewSelectDifficulty._set_selection = function (self, index)
	if self._selection_timer then
		return
	end

	self._selection_timer = 0
	self._previous_index = self._selection_index
	self._selection_index = index
	local actual_index = self._difficulty_index_table[index]
	local data = self._difficulty_data[actual_index]
	self._selection_text_widget.content.text = data.setting_text
	local widget = self._elements[index]
	local locked = widget.content.locked
	local rank = widget.content.rank
	self._selected_difficulty_rank = rank
	self._is_selected_difficulty_locked = locked
	local input_descriptions = (locked and generic_input_actions.locked) or generic_input_actions.default

	self.menu_input_description:change_generic_actions(input_descriptions)
end

StateMapViewSelectDifficulty.update_selection_timer = function (self, dt)
	local timer = self._selection_timer

	if timer then
		local total_time = 0.25

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

StateMapViewSelectDifficulty._update_elements = function (self, dt, instant)
	local selection_progress = (instant and 1) or self:update_selection_timer(dt)

	if not selection_progress then
		return
	end

	local num_elements = #self._elements
	local selected_index = self._selection_index or 1
	local previous_index = self._previous_index or 1
	local spacing = 15
	local element_width = element_size[1]
	local distance = element_width + spacing
	local direction = 0

	if selected_index < previous_index then
		direction = -1
	elseif previous_index < selected_index then
		direction = 1
	end

	local anim_progress = math.easeCubic(selection_progress)
	local input_offset = direction * distance * anim_progress

	for index, widget in ipairs(self._elements) do
		local current_position = widget.content.position_offset
		local position = current_position - input_offset
		widget.offset[1] = position

		if selection_progress >= 1 then
			widget.content.position_offset = position
		end

		local position_progress = 1 - math.clamp(math.abs(position) / (distance * 2), 0, 1)

		self:_animate_element(widget, index, selection_progress, position_progress)
	end
end

StateMapViewSelectDifficulty._animate_element = function (self, widget, index, progress, distance_progress)
	local is_selection_widget = self._selection_index == index
	local anim_progress = (is_selection_widget and math.easeCubic(progress)) or math.easeCubic(1 - progress)
	local widget_style = widget.style
	local widget_content = widget.content
	local locked_style = widget_style.locked_texture
	local banner_style = widget_style.banner_texture
	local locked_text_style = widget_style.locked_text
	local alpha = (distance_progress > 0.5 and 255) or distance_progress / 0.5 * 255
	local locked_text_color = locked_text_style.text_color
	local locked_text_rect_color = locked_text_style.rect_color
	locked_text_color[1] = (distance_progress > 0.5 and (distance_progress - 0.5) / 0.5 * 255) or 0
	locked_text_rect_color[1] = (distance_progress > 0.5 and (distance_progress - 0.5) / 0.5 * 150) or 0
	local banner_color = banner_style.color
	local lock_color = locked_style.color
	local color_value = 100 + distance_progress * 155
	banner_color[1] = alpha
	banner_color[2] = color_value
	banner_color[3] = color_value
	banner_color[4] = color_value
	lock_color[1] = alpha
	lock_color[2] = color_value
	lock_color[3] = color_value
	lock_color[4] = color_value
	local banner_texture = widget_content.banner_texture
	local gui = self.ui_renderer.gui
	local gui_material = Gui.material(gui, banner_texture)

	if is_selection_widget then
		if widget_content.internal_progress < anim_progress then
			Material.set_scalar(gui_material, "distortion_offset_top", anim_progress * 0.5)
		end
	elseif anim_progress < widget_content.internal_progress then
		Material.set_scalar(gui_material, "distortion_offset_top", anim_progress * 0.5)
	end

	local draw_locked_text = false

	if progress == 1 then
		widget_content.internal_progress = anim_progress

		if is_selection_widget then
			draw_locked_text = true
		end
	end

	widget.content.draw_locked_text = draw_locked_text
	local banner_default_width = 340
	local banner_default_height = 850
	local banner_size = banner_style.size
	local banner_offset = banner_style.offset
	banner_size[1] = banner_default_width * distance_progress
	banner_size[2] = banner_default_height * distance_progress
	banner_offset[1] = -banner_size[1] * 0.5
	banner_offset[2] = -banner_size[2] * 0.5
	local locked_default_width = 233
	local locked_default_height = 232
	local locked_default_offset_width = -116.5
	local locked_default_offset_height = 99
	local locked_size = locked_style.size
	local locked_offset = locked_style.offset
	locked_size[1] = locked_default_width * distance_progress
	locked_size[2] = locked_default_height * distance_progress
	locked_offset[1] = locked_default_offset_width * distance_progress
	locked_offset[2] = locked_default_offset_height * distance_progress
end

StateMapViewSelectDifficulty._play_sound = function (self, event)
	self._map_view:play_sound(event)
end

return
