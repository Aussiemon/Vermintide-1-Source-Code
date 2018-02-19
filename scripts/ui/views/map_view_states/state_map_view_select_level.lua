-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
local definitions = local_require("scripts/ui/views/map_view_states/definitions/state_map_view_select_level_definitions")
local widgets = definitions.widgets
local element_size = definitions.element_size
local create_element = definitions.create_element
local dialogue_speakers = definitions.dialogue_speakers
local scenegraph_definition = definitions.scenegraph_definition
local generic_input_actions = definitions.generic_input_actions
local description_text_colors = definitions.description_text_colors
local difficulty_progression_textures = definitions.difficulty_progression_textures
local DO_RELOAD = false
StateMapViewSelectLevel = class(StateMapViewSelectLevel)
StateMapViewSelectLevel.NAME = "StateMapViewSelectLevel"
StateMapViewSelectLevel.on_enter = function (self, params)
	print("[MapViewState] Enter Substate StateMapViewSelectLevel")

	self.game_info = params.game_info
	local ingame_ui_context = params.ingame_ui_context
	self.map_view_area_handler = params.map_view_area_handler
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	self._map_view = params.map_view
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.level_filter = params.level_filter
	self.wwise_world = ingame_ui_context.dialogue_system.wwise_world
	self.platform = PLATFORM
	self.open = true
	self._filter_unplayable_path = "filter_unplayable"

	if self.game_info.game_mode == "adventure" then
		self._filter_enabled = true
		self.input_actions = generic_input_actions.filter
	else
		self._filter_enabled = false
		self.input_actions = generic_input_actions

		if GameSettingsDevelopment.use_leaderboards or Development.parameter("use_leaderboards") then
			self._leaderboards_ui = LeaderboardsUI:new(ingame_ui_context, "map_menu")
			self.input_actions = table.clone(generic_input_actions)
			self.input_actions.default.default[#self.input_actions.default.default + 1] = {
				input_action = "refresh",
				priority = 5,
				description_text = "input_descriptions_leaderboards"
			}
		end
	end

	local input_service = self.input_manager:get_service("map_menu")
	local gui_layer = UILayer.default + 30
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 4, gui_layer, self.input_actions.default.default)

	self.menu_input_description:set_input_description(nil)

	self.input_descriptions_path = "default"
	self._number_of_levels_in_filter = 0
	self.ui_animations = {}

	self.create_ui_elements(self)
	self._map_view:set_time_line_index(2)
	self._map_view:animate_title_text(self._title_text_widget)
	self._map_view:set_mask_enabled(true)

	return 
end
StateMapViewSelectLevel.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._dead_space_filler_widget = UIWidget.init(widgets.dead_space_filler)
	self._overlay_widget = UIWidget.init(widgets.overlay)
	self._title_text_widget = UIWidget.init(widgets.title_text)
	self._act_frame_widget = UIWidget.init(widgets.act_frame)
	self._act_title_text_widget = UIWidget.init(widgets.act_title_text)
	self._subtitle_text_widget = UIWidget.init(widgets.subtitle_text)
	self._difficulty_icons_widget = UIWidget.init(widgets.difficulty_icons)
	self._difficulty_slots_widget = UIWidget.init(widgets.difficulty_slots)
	self._background_widget = UIWidget.init(widgets.background)
	self._level_count_text_widget = UIWidget.init(widgets.level_count_text)
	self._selection_text_widget = UIWidget.init(widgets.selection_text)
	self._selection_text_widget.style.text.localize = false
	self._level_count_text_widget.style.text.localize = false
	self._selection_fade_widget = UIWidget.init(widgets.selection_fade)
	self._selection_bg_widget = UIWidget.init(widgets.selection_bg)
	self._difficulty_bg_widget = UIWidget.init(widgets.difficulty_bg)
	self._frame_left_widget = UIWidget.init(widgets.frame_left)
	self._frame_right_widget = UIWidget.init(widgets.frame_right)
	self._edge_left_widget = UIWidget.init(widgets.edge_left)
	self._edge_right_widget = UIWidget.init(widgets.edge_right)
	self._subtitle_text_widget.style.text.localize = false
	self._subtitle_text_widget.style.text.vertical_alignment = "top"
	self._subtitle_text_widget.style.text.horizontal_alignment = "center"
	self._performance_frame_widget = UIWidget.init(widgets.performance_frame)
	self._performance_title_text_widget = UIWidget.init(widgets.performance_title_text)
	local score_widgets = {}
	local score_value_widgets_by_key = {}
	self.score_widgets = score_widgets
	self.score_value_widgets_by_key = score_value_widgets_by_key
	score_widgets[#score_widgets + 1] = self._performance_frame_widget
	score_widgets[#score_widgets + 1] = self._performance_title_text_widget

	for i = 1, 3, 1 do
		local sufix = "_" .. i

		if 1 < i then
			local divider = UIWidget.init(widgets["performance_divider" .. sufix])
			score_widgets[#score_widgets + 1] = divider
		end

		local difficulty_prefix = UIWidget.init(widgets["difficulty_prefix" .. sufix])
		score_widgets[#score_widgets + 1] = difficulty_prefix
		local difficulty_value = UIWidget.init(widgets["difficulty_value" .. sufix])
		score_widgets[#score_widgets + 1] = difficulty_value
		local wave_prefix = UIWidget.init(widgets["wave_prefix" .. sufix])
		score_widgets[#score_widgets + 1] = wave_prefix
		local time_prefix = UIWidget.init(widgets["time_prefix" .. sufix])
		score_widgets[#score_widgets + 1] = time_prefix
		local wave_value = UIWidget.init(widgets["wave_value" .. sufix])
		score_widgets[#score_widgets + 1] = wave_value
		local time_value = UIWidget.init(widgets["time_value" .. sufix])
		score_widgets[#score_widgets + 1] = time_value
		local widgets_by_key = {
			waves = wave_value,
			time = time_value
		}
		score_value_widgets_by_key[i] = widgets_by_key
	end

	self.static_widgets = {
		self._act_frame_widget,
		self._act_title_text_widget,
		self._subtitle_text_widget,
		self._difficulty_icons_widget,
		self._difficulty_slots_widget,
		self._selection_text_widget,
		self._selection_fade_widget,
		self._selection_bg_widget,
		self._difficulty_bg_widget
	}

	for index, widget in ipairs(self.score_widgets) do
		self.static_widgets[#self.static_widgets + 1] = widget
	end

	local elements = {}

	for i = 1, 5, 1 do
		elements[i] = UIWidget.init(create_element("element_pivot"))
	end

	self._elements = elements

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self._setup_elements_level_data(self)

	local ignore_sound = false
	local selected_read_index = self.game_info.level_index or 1

	self._assign_element_data(self, selected_read_index)
	self._set_selected_widget_by_index(self, self._selection_index, ignore_sound)
	self.start_open_animation(self)

	return 
end
StateMapViewSelectLevel._assign_element_data = function (self, specific_read_index)

	-- decompilation error in this vicinity
	local active_level_list = self._active_level_list
	local num_levels = #self._active_level_list
	self._num_levels = num_levels
	local num_elements = #self._elements
	local level_list_read_index = nil
	self._selection_index = 3

	self._align_elements(self)

	return 
end
StateMapViewSelectLevel._set_element_data_by_index = function (self, widget, read_index)
	local active_level_list = self._active_level_list
	local level_information = active_level_list[read_index]

	if level_information then
		local level_key = level_information.level_key
		local level_image = level_information.level_image
		local visibility = level_information.visibility
		local dlc_name = nil
		local dlc_unlocked = visibility ~= "dlc"
		local locked = visibility == "locked"
		local new_level = false

		if level_key ~= "any" then
			local level_settings = LevelSettings[level_key]
			dlc_name = level_settings.dlc_name
			new_level = not self._area_already_viewed(self, level_key)
		end

		widget.content.dlc_name = (not dlc_unlocked and dlc_name) or nil
		widget.content.locked = locked or not dlc_unlocked
		widget.content.locked_text = level_information.visibility_tooltip
		widget.content.new = new_level
		widget.content.level_image = level_image
		widget.content.read_index = read_index

		if self._filter_enabled and level_key ~= "any" then
			local marked = self.level_filter:level_marked(level_key)
			widget.content.use_marker = marked
		else
			widget.content.use_marker = false
		end

		return true
	end

	return 
end
StateMapViewSelectLevel._set_level_score = function (self, level_key, difficulty_data)
	local score_value_widgets_by_key = self.score_value_widgets_by_key
	local wave_key = "waves"
	local time_key = "time"
	local kills_key = "kills"
	local no_data_text = "-"
	local widget_read_index = 1

	for index, data in ipairs(difficulty_data) do
		local scores = data.scores

		if scores then
			local widgets = score_value_widgets_by_key[widget_read_index]
			local score_wave = scores[wave_key]
			local score_time = scores[time_key]
			local score_kills = scores[kills_key]
			local no_data = score_wave == 0
			widgets[wave_key].content.text = (no_data and no_data_text) or tostring(score_wave)
			widgets[time_key].content.text = (no_data and no_data_text) or string.format("%.2d:%.2d:%.2d", math.floor(score_time/3600), math.floor(score_time/60)%60, math.floor(score_time)%60)
			widget_read_index = widget_read_index + 1
		end
	end

	return 
end
StateMapViewSelectLevel._is_level_difficulty_unlocked = function (self, level_key, difficulty_data)
	local current_difficulty_index = self.game_info.difficulty_index

	for i = 1, #difficulty_data, 1 do
		local data = difficulty_data[i]
		local rank = data.rank
		local unlocked = data.unlocked
		slot11 = data.available
	end

	return 
end
StateMapViewSelectLevel._setup_elements_level_data = function (self)
	local game_mode = self.game_info.game_mode or "adventure"
	local include_random_level = game_mode == "survival"
	local level_list = self.map_view_area_handler:get_levels_by_game_mode(game_mode, include_random_level)
	self._active_level_list = level_list
	self._active_total_level_count = self.map_view_area_handler:active_level_count()

	if self._filter_enabled then
		self.level_filter:setup_level_list(level_list, game_mode)
	end

	return 
end
StateMapViewSelectLevel.on_exit = function (self, params)
	if self.last_dialogue_reason then
		self.stop_dialogue(self, self.last_dialogue_reason)

		self.last_dialogue_reason = nil
	end

	self.menu_input_description:destroy()

	self.menu_input_description = nil

	return 
end
StateMapViewSelectLevel.animate_window = function (self, open, level_key)
	if not self._draw_score then
		return 
	end

	if not self.close_window_animation and not self.open_window_animation then
		local ui_scenegraph = self.ui_scenegraph
		local target = ui_scenegraph.overlay.local_position
		local target_index = 2

		if open then
			local from = (UISettings.ui_scale*1200)/100
			local to = 0
			local time = UISettings.scoreboard.open_duration
			self.opening_leaderboards = false
			self.open_window_animation = self.animate_element_by_time(self, target, target_index, from, to, time)

			self._play_sound(self, "Play_hud_button_close")
			self._leaderboards_ui:close()
			self.parent:animate_mask(to, time)
		else
			if not level_key then
				return 
			end

			self._map_view:enable_timeline(false)

			self.open = false
			local from = 0
			local to = (UISettings.ui_scale*1200)/100
			local time = UISettings.scoreboard.close_duration
			self.opening_leaderboards = true
			self.close_window_animation = self.animate_element_by_time(self, target, target_index, from, to, time)

			self._play_sound(self, "Play_hud_button_open")
			self._leaderboards_ui:open(level_key)
			self.parent:animate_mask(to, time)
		end
	end

	return 
end
StateMapViewSelectLevel.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.ease_out_quad)

	return new_animation
end
StateMapViewSelectLevel._update_transition_timer = function (self, dt)
	if not self._transition_timer then
		return 
	end

	if self._transition_timer == 0 then
		self._transition_timer = nil

		if self._filter_enabled then
			self.level_filter:animation_done()
		end
	else
		self._transition_timer = math.max(self._transition_timer - dt, 0)
	end

	return 
end
StateMapViewSelectLevel.on_open_complete = function (self)
	self.open = true

	self._map_view:enable_timeline(true)

	return 
end
StateMapViewSelectLevel.on_close_complete = function (self)
	self.open = false

	return 
end
StateMapViewSelectLevel.update = function (self, dt, t)
	script_data.mapview = self

	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if not self._transition_timer then
		self._handle_input(self, dt)
	end

	self._update_elements_position(self, dt)

	local open_animation = self.open_window_animation

	if open_animation then
		UIAnimation.update(open_animation, dt)

		if UIAnimation.completed(open_animation) then
			self.open_window_animation = nil

			self.on_open_complete(self)
		end
	else
		local close_animation = self.close_window_animation

		if close_animation then
			UIAnimation.update(close_animation, dt)

			if UIAnimation.completed(close_animation) then
				self.close_window_animation = nil

				if not self.opening_leaderboards then
					self.on_close_complete(self)
				end
			end
		end
	end

	if self._leaderboards_ui then
		local input_service = self.input_manager:get_service("map_menu")

		if self.open and input_service.get(input_service, "refresh") then
			local level_data = self._active_level_list[self._selected_read_index]
			local level_key = level_data and level_data.level_key

			self.animate_window(self, not self.open, level_key)
		elseif not self.open and (input_service.get(input_service, "back") or input_service.get(input_service, "refresh")) then
			local level_data = self._active_level_list[self._selected_read_index]
			local level_key = level_data and level_data.level_key

			self.animate_window(self, not self.open, level_key)
		end

		self._leaderboards_ui:update(dt)
	end

	if self._filter_enabled then
		local level_filter = self.level_filter

		level_filter.update(level_filter, dt, t)
		self._update_filter_animation(self, dt)

		if self.filter_active(self) then
			local progress = level_filter.visibility_fraction(level_filter)

			self._update_markers_visibility(self, progress)
		end

		local filter_active = self.filter_active(self)
		local number_of_levels_in_filter = level_filter.get_number_of_playable_levels(level_filter)
		local num_filter_levels_changed = number_of_levels_in_filter ~= self._number_of_levels_in_filter
		local filter_active_changed = filter_active ~= self._filter_active_last_frame

		if filter_active_changed then
			if num_filter_levels_changed then
				self._number_of_levels_in_filter = number_of_levels_in_filter
			end

			self._update_input_description(self)

			self._filter_active_last_frame = filter_active

			self._set_marker_visible_state(self, filter_active)
		elseif num_filter_levels_changed then
			self._number_of_levels_in_filter = number_of_levels_in_filter

			self._update_input_description(self)
		end
	end

	if self._leaderboards_ui and self._leaderboards_ui:enabled() then
		self._leaderboards_ui:draw(dt)
	end

	self.draw(self, dt)
	self._update_transition_timer(self, dt)

	if self._update_dialogue_play_timer(self, dt) == 1 then
		local wwise_events = self._next_wwise_events

		self.play_dialogue(self, wwise_events, "level")
	end

	if not self._transition_timer then
		return self._new_state
	end

	return 
end
StateMapViewSelectLevel.post_update = function (self, dt, t)
	return 
end
StateMapViewSelectLevel._set_marker_visible_state = function (self, visible)
	for index, widget in ipairs(self._elements) do
		widget.content.filter_active = visible
	end

	return 
end
StateMapViewSelectLevel._update_markers_visibility = function (self, fraction)
	local animate = self.move_timer == nil
	local anim_fraction = math.easeCubic(fraction)
	local anim_time = 3

	for index, widget in ipairs(self._elements) do
		if animate then
			local distance_progress = widget.content.distance_progress or 1
			local is_selected = index == self._selection_index
			local target = widget.style.marker.color
			local target_index = 1
			local from = target[target_index]
			local alpha = (0.5 < distance_progress and 255) or distance_progress/0.5*255
			local alpha_value = anim_fraction*alpha
			target[target_index] = alpha_value
		end
	end

	return 
end

local function anim_func(t)
	t = math.smoothstep(t, 0, 1)
	local b = 0
	local c = 1
	local d = 1
	local ts = t/d*t
	local tc = ts*t

	return b + c*(tc*2.7*ts + ts*-14.2975*ts + tc*26.095 + ts*-21.195 + t*7.6975)
end

StateMapViewSelectLevel.start_open_animation = function (self)
	self._transition_timer = 0.65

	for index, widget in ipairs(self._elements) do
		local target = widget.offset
		local target_index = 2
		local from = -1000
		local to = target[target_index]
		local is_selected = 20 < math.abs(target[1])
		local anim_time = (is_selected and 0.75) or 0.85

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, anim_func)

		UIWidget.animate(widget, animation)
	end

	for _, widget in ipairs(self.static_widgets) do
		local style = widget.style
		local target_style = style.texture_id or style.text

		if target_style then
			local anim_time = 0.15
			local target = (style.text and target_style.text_color) or target_style.color
			local target_index = 1
			local from = 0
			local to = 255
			target[target_index] = from

			table.clear(widget.animations)

			local animation = UIAnimation.init(UIAnimation.wait, 0.5, UIAnimation.function_by_time, target, target_index, from, to, anim_time, math.easeCubic)

			UIWidget.animate(widget, animation)
		end
	end

	if self._filter_enabled then
		self.level_filter:animate_button_fade(0.15, 0.5, "in")
	end

	self._play_sound(self, "Play_hud_map_console_change_state_vertical")

	return 
end
StateMapViewSelectLevel.start_close_animation = function (self)
	self._transition_timer = 0.65

	for index, widget in ipairs(self._elements) do
		local target = widget.offset
		local target_index = 2
		local from = target[target_index]
		local to = 1000
		local is_selected = 20 < math.abs(target[1])
		local anim_time = 0.75
		local anim_wait_time = (is_selected and 0.25) or 0.15

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.wait, anim_wait_time, UIAnimation.function_by_time, target, target_index, from, to, anim_time, anim_func)

		UIWidget.animate(widget, animation)
	end

	for _, widget in ipairs(self.static_widgets) do
		local style = widget.style
		local target_style = style.texture_id or style.text

		if target_style then
			local anim_time = 0.15
			local target = (style.text and target_style.text_color) or target_style.color
			local target_index = 1
			local from = 255
			local to = 0

			if target[target_index] ~= to then
				table.clear(widget.animations)

				local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, math.easeCubic)

				UIWidget.animate(widget, animation)
			end
		end
	end

	if self._filter_enabled then
		self.level_filter:animate_button_fade(0.15, 0, "out")
	end

	self._map_view:animate_title_text(self._title_text_widget, true)
	self._play_sound(self, "Play_hud_map_console_change_state_vertical")

	return 
end
StateMapViewSelectLevel.update_marker_for_selected_level = function (self)
	local selected_read_index = self._selected_read_index
	local active_level_list = self._active_level_list

	if not selected_read_index or not active_level_list then
		return 
	end

	local level_information = active_level_list[selected_read_index]
	local level_key = level_information.level_key

	if level_key ~= "any" then
		local level_filter = self.level_filter
		local return_value = level_filter.set_level_marked(level_filter, level_key)
		local selected_index = self._selected_index

		if selected_index then
			local selected_widget = self._elements[selected_index]
			selected_widget.content.use_marker = return_value
		end
	end

	return 
end
StateMapViewSelectLevel._update_filter_animation = function (self, dt)
	local level_filter = self.level_filter
	local fraction = (self._filter_enabled and level_filter.visibility_fraction(level_filter)) or 1
	local ui_scenegraph = self.ui_scenegraph
	local value = fraction*250
	ui_scenegraph.overlay.local_position[1] = value
	self.menu_input_description.ui_scenegraph.screen.local_position[1] = value
	self._map_view.ui_scenegraph.time_line.local_position[1] = value

	return 
end
StateMapViewSelectLevel._handle_input = function (self, dt)
	if self._new_state or (self._leaderboards_ui and self._leaderboards_ui:enabled()) then
		return 
	end

	local level_filter = self.level_filter
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	elseif input_service.get(input_service, "move_left") or input_service.get(input_service, "move_left_hold") then
		self.controller_cooldown = GamepadSettings.menu_cooldown

		self._cycle(self, 1)
	elseif input_service.get(input_service, "move_right") or input_service.get(input_service, "move_right_hold") then
		self.controller_cooldown = GamepadSettings.menu_cooldown

		self._cycle(self, -1)
	elseif input_service.get(input_service, "cycle_previous") and self._filter_enabled then
		self.controller_cooldown = GamepadSettings.menu_cooldown

		if self._filter_enabled then
			level_filter.toggle_visibility(level_filter)
			self._play_sound(self, "Play_hud_next_tab")
		end
	elseif input_service.get(input_service, "special_1") and self.filter_active(self) then
		self.controller_cooldown = GamepadSettings.menu_cooldown

		if self._filter_enabled then
			self.update_marker_for_selected_level(self)
		end
	elseif (input_service.get(input_service, "confirm") or (self._filter_enabled and input_service.get(input_service, "refresh") and 0 < self._number_of_levels_in_filter)) and self._selected_read_index then
		if self._selected_level_dlc_name then
			local dlc_name = self._selected_level_dlc_name

			self._play_sound(self, "Play_hud_select")
			self._show_store_page(self, dlc_name)
		elseif not self.filter_active(self) and not self._is_selected_level_locked then
			local map_view_area_handler = self.map_view_area_handler
			local game_info = self.game_info

			if input_service.get(input_service, "refresh") then
				game_info.use_level_filter = true
			else
				game_info.use_level_filter = false
			end

			local selected_difficulty_rank = game_info.difficulty_rank
			local active_level_list = self._active_level_list
			local level_information = active_level_list[self._selected_read_index]
			local difficulty_data = level_information.difficulty_data
			local difficulty_locked = true

			for i = 1, #difficulty_data, 1 do
				local data = difficulty_data[i]
				local rank = data.rank

				if rank == selected_difficulty_rank then
					difficulty_locked = not data.unlocked

					break
				end
			end

			local level_key = level_information.level_key
			game_info.previous_info.area = game_info.area
			game_info.previous_info.level_key = game_info.level_key
			game_info.previous_info.level_index = game_info.level_index
			local level_settings = level_key ~= "any" and LevelSettings[level_key]
			game_info.area = (level_settings and level_settings.map_settings.area) or "world"
			game_info.level_key = level_key
			game_info.level_index = self._selected_read_index
			game_info.area = level_information.area

			if self._filter_enabled then
				game_info.level_filter_list = self.level_filter:get_unmarked_levels()
			end

			self._new_state = StateMapViewSelectDifficulty

			self._save_viewed_levels(self)
			self._play_sound(self, "Play_hud_main_menu_open")
		end
	elseif input_service.get(input_service, "back") then
		if self.filter_active(self) then
			level_filter.close(level_filter)
			self._play_sound(self, "Play_hud_next_tab")
		else
			self._save_viewed_levels(self)

			local game_info = self.game_info
			self._new_state = StateMapViewGameMode

			self._play_sound(self, "Play_hud_select")
		end
	elseif input_service.get(input_service, "toggle_menu") then
		local return_to_game = not self.parent.ingame_ui.menu_active

		self._map_view:exit(return_to_game)
	end

	if self._new_state then
		self.start_close_animation(self)
	end

	return 
end
StateMapViewSelectLevel.filter_active = function (self)
	return self._filter_enabled and self.level_filter:visibility_fraction() ~= 0
end
StateMapViewSelectLevel.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self._title_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._subtitle_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._selection_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_icons_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_slots_widget)
	UIRenderer.draw_widget(ui_renderer, self._background_widget)
	UIRenderer.draw_widget(ui_renderer, self._dead_space_filler_widget)
	UIRenderer.draw_widget(ui_renderer, self._selection_fade_widget)
	UIRenderer.draw_widget(ui_renderer, self._selection_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_left_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_right_widget)

	if self._draw_score then
		for _, widget in ipairs(self.score_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	if not self._filter_enabled then
		UIRenderer.draw_widget(ui_renderer, self._edge_left_widget)
	end

	UIRenderer.draw_widget(ui_renderer, self._edge_right_widget)

	if self._draw_act_title then
		UIRenderer.draw_widget(ui_renderer, self._act_frame_widget)
		UIRenderer.draw_widget(ui_renderer, self._act_title_text_widget)
	end

	for _, widget in ipairs(self._elements) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	if not self._transition_timer then
		local leaderboards_enabled = self._leaderboards_ui and self._leaderboards_ui:enabled()

		if not leaderboards_enabled then
			self.menu_input_description:draw(ui_renderer, dt)
		end
	end

	return 
end
StateMapViewSelectLevel._align_elements = function (self)
	local num_elements = #self._elements
	local selected_index = self._selected_index
	local spacing = 80
	local element_width = element_size[1]
	local distance = element_width + spacing
	local start_offset = -(distance*math.floor(num_elements/2))
	local max_offset = math.abs(start_offset)

	for index, widget in ipairs(self._elements) do
		local position = start_offset + distance*(index - 1)
		widget.offset[1] = position
		widget.content.position_offset = position
		local is_selection_widget = index == selected_index
		local position_progress = math.clamp(math.abs(position)/max_offset, 0, 1) - 1

		self._animate_element(self, widget, is_selection_widget, position_progress)
	end

	return 
end
StateMapViewSelectLevel._cycle = function (self, direction, ignore_sound)
	if self.move_timer then
		return 
	end

	self._direction = direction
	self.move_timer = 0
	local num_elements = #self._elements
	local selected_index = self._selected_index
	selected_index = selected_index - direction

	if num_elements < selected_index then
		selected_index = 1
	elseif selected_index <= 0 then
		selected_index = num_elements
	end

	if not ignore_sound then
		self._play_sound(self, "Play_hud_shift")
	end

	self._set_selected_widget_by_index(self, selected_index, ignore_sound)

	return 
end
StateMapViewSelectLevel._set_selected_widget_by_index = function (self, index, ignore_sound)
	self._selected_index = index
	local new_selection_widget = self._elements[index]
	local level_read_index = new_selection_widget.content.read_index
	self._selected_read_index = level_read_index
	local level_information = self._active_level_list[level_read_index]
	local level_key = level_information.level_key
	local level_settings = level_key ~= "any" and LevelSettings[level_key]
	local console_area = level_settings and level_settings.console_area
	local act_key = level_settings and level_settings.act
	local area_key = level_settings and level_settings.map_settings.area
	local game_mode = level_settings and level_settings.game_mode
	local draw_act_title = false

	if console_area then
		self._act_title_text_widget.content.text = console_area
		draw_act_title = true
	elseif act_key then
		local act_title_text = act_key .. "_ls"
		self._act_title_text_widget.content.text = act_title_text
		draw_act_title = true
	elseif area_key and area_key ~= "world" then
		local area_settings = AreaSettings[area_key]
		self._act_title_text_widget.content.text = area_settings.display_name
		draw_act_title = true
	else
		draw_act_title = false
	end

	self._draw_act_title = draw_act_title

	self._mark_level_as_viewed(self, level_key)

	if self._filter_enabled then
		self.level_filter:set_selected_level(level_key)
	end

	local display_name = Localize(level_information.display_name)
	self._selection_text_widget.content.text = display_name
	local visibility = level_information.visibility
	local difficulty_data = level_information.difficulty_data
	local difficulty_icons_widget = self._difficulty_icons_widget
	local difficulty_textures = difficulty_icons_widget.content.texture_id
	local dlc_name = new_selection_widget.content.dlc_name
	local level_locked = new_selection_widget.content.locked
	local locked_text = new_selection_widget.content.locked_text
	local difficulty_mount = 0

	for index, data in ipairs(difficulty_data) do
		local completed = data.completed
		local unlocked = data.unlocked
		local available = data.available

		if available then
			difficulty_mount = difficulty_mount + 1
			difficulty_textures[difficulty_mount] = (not unlocked and difficulty_progression_textures.locked) or (completed and difficulty_progression_textures.completed) or difficulty_progression_textures.unlocked
		end
	end

	self._difficulty_icons_widget.style.texture_id.texture_amount = difficulty_mount
	self._difficulty_slots_widget.style.texture_id.texture_amount = difficulty_mount
	local input_descriptions_path = nil

	if dlc_name then
		input_descriptions_path = "dlc"
	elseif level_locked then
		input_descriptions_path = "locked"
	else
		input_descriptions_path = "default"
	end

	if input_descriptions_path and input_descriptions_path ~= self.input_descriptions_path then
		self._update_input_description(self, input_descriptions_path)
	end

	self.dialogue_timer = nil

	self.stop_dialogue(self, "level")

	if not ignore_sound and not level_locked then
		local wwise_events = level_information.wwise_events

		if wwise_events then
			self.dialogue_timer = 0
			self._next_wwise_events = wwise_events
		end
	elseif level_locked then
		self.set_description_text(self, locked_text, nil, true)
	end

	self._is_selected_level_locked = level_locked
	self._selected_level_dlc_name = dlc_name
	self._level_count_text_widget.content.text = level_read_index .. "/" .. self._active_total_level_count

	if game_mode and game_mode == "survival" then
		self._set_level_score(self, level_key, difficulty_data)

		self._draw_score = true

		if self.game_info.game_mode == "survival" then
			self.menu_input_description:enable_button(3, true)
		end
	else
		self._draw_score = false

		if self.game_info.game_mode == "survival" then
			self.menu_input_description:enable_button(3, false)
		end
	end

	return 
end
StateMapViewSelectLevel._update_input_description = function (self, optional_path)
	local filter_active = self.filter_active(self)
	local end_path = optional_path or self.input_descriptions_path
	local source_table_path = nil

	if self._filter_enabled then
		if filter_active then
			source_table_path = "filter_active"
		elseif self._number_of_levels_in_filter <= 0 then
			source_table_path = "filter_unplayable"
		else
			source_table_path = "default"
		end
	else
		source_table_path = "default"
	end

	local input_descriptions = self.input_actions[source_table_path][end_path]

	self.menu_input_description:change_generic_actions(input_descriptions)

	self.input_descriptions_path = end_path

	return 
end
StateMapViewSelectLevel.update_move_timer = function (self, dt)
	local timer = self.move_timer

	if timer then
		local total_time = 0.25

		if timer == total_time then
			self.move_timer = nil

			return 
		else
			timer = math.min(timer + dt, total_time)
			self.move_timer = timer

			return timer/total_time
		end
	end

	return 
end
StateMapViewSelectLevel._update_elements_position = function (self, dt, instant)
	local time_progress = (instant and 1) or self.update_move_timer(self, dt)

	if not time_progress then
		return 
	end

	if self._filter_enabled then
		self.level_filter:set_background_animation_fraction(time_progress, self._direction)
	end

	local elements = self._elements
	local num_elements = #elements
	local selected_index = self._selected_index or 3
	local spacing = 80
	local element_width = element_size[1]
	local distance = element_width + spacing
	local start_offset = -(distance*math.floor(num_elements/2))
	local max_offset = math.abs(start_offset)
	local center_index = math.floor(num_elements/2)
	local anim_progress = math.easeCubic(time_progress)
	local input_offset = self._direction*distance*anim_progress

	for index, widget in ipairs(elements) do
		local widget_read_index = index - 1
		local change_read_index = false
		local current_position = widget.content.position_offset
		local element_position = current_position + input_offset
		local position = element_position

		if max_offset + distance*0.5 < element_position then
			position = start_offset - distance + element_position%max_offset
			change_read_index = true
		elseif element_position < -(max_offset + distance*0.5) then
			position = max_offset
			change_read_index = true
		end

		widget.offset[1] = position

		if 1 <= time_progress then
			widget.content.position_offset = position

			if change_read_index then
				self._change_element_read_index(self, widget, self._direction)
			end
		end

		local position_progress = math.clamp(math.abs(position)/max_offset, 0, 1) - 1
		local is_selection_widget = index == selected_index

		self._animate_element(self, widget, is_selection_widget, position_progress)
	end

	return 
end
StateMapViewSelectLevel._change_element_read_index = function (self, widget, direction)
	local num_levels = self._num_levels

	if 0 < direction then
		local new_index = (widget.content.read_index - 6)%num_levels + 1

		if new_index <= 0 then
			new_index = num_levels
		end

		self._set_element_data_by_index(self, widget, new_index)
	elseif direction < 0 then
		local new_index = (widget.content.read_index + 4)%num_levels + 1

		self._set_element_data_by_index(self, widget, new_index)
	end

	return 
end
StateMapViewSelectLevel._animate_element = function (self, widget, is_selection_widget, distance_progress)
	widget.content.distance_progress = distance_progress
	local widget_style = widget.style
	local locked_texture_style = widget_style.locked_texture
	local dlc_texture_style = widget_style.dlc_texture
	local new_texture_style = widget_style.new_texture
	local image_style = widget_style.level_image
	local bg_rect_style = widget_style.bg_rect
	local frame_style = widget_style.frame
	local marker_style = widget_style.marker
	local alpha = (0.5 < distance_progress and 255) or distance_progress/0.5*255
	local color_value = distance_progress*155 + 100
	local image_color = image_style.color
	local frame_color = frame_style.color
	local marker_color = marker_style.color
	local lock_color = locked_texture_style.color
	local dlc_lock_color = dlc_texture_style.color
	local new_color = new_texture_style.color
	image_color[1] = alpha
	image_color[2] = color_value
	image_color[3] = color_value
	image_color[4] = color_value
	frame_color[1] = alpha
	frame_color[2] = color_value
	frame_color[3] = color_value
	frame_color[4] = color_value
	marker_color[1] = alpha
	marker_color[2] = color_value
	marker_color[3] = color_value
	marker_color[4] = color_value
	lock_color[1] = alpha
	lock_color[2] = color_value
	lock_color[3] = color_value
	lock_color[4] = color_value
	dlc_lock_color[1] = alpha
	dlc_lock_color[2] = color_value
	dlc_lock_color[3] = color_value
	dlc_lock_color[4] = color_value
	new_color[1] = alpha
	local image_default_width = 560
	local image_default_height = 310
	local image_size = image_style.size
	local image_offset = image_style.offset
	image_size[1] = image_default_width*distance_progress
	image_size[2] = image_default_height*distance_progress
	image_offset[1] = -image_size[1]*0.5
	image_offset[2] = -image_size[2]*0.5
	bg_rect_style.size[1] = image_size[1]
	bg_rect_style.size[2] = image_size[2]
	bg_rect_style.offset[1] = image_offset[1]
	bg_rect_style.offset[2] = image_offset[2]
	local frame_default_width = 573
	local frame_default_height = 326
	local frame_size = frame_style.size
	local frame_offset = frame_style.offset
	frame_size[1] = frame_default_width*distance_progress
	frame_size[2] = frame_default_height*distance_progress
	frame_offset[1] = -frame_size[1]*0.5
	frame_offset[2] = -frame_size[2]*0.5
	local marker_default_width = 560
	local marker_default_height = 310
	local marker_size = marker_style.size
	local marker_offset = marker_style.offset
	marker_size[1] = marker_default_width*distance_progress
	marker_size[2] = marker_default_height*distance_progress
	marker_offset[1] = -marker_size[1]*0.5
	marker_offset[2] = -marker_size[2]*0.5
	local default_new_texture_height_offset = distance_progress*25
	local default_new_texture_width_offset = distance_progress*8
	local new_texture_default_width = 360
	local new_texture_default_height = 32
	local new_texture_size = new_texture_style.size
	local new_texture_offset = new_texture_style.offset
	new_texture_size[1] = new_texture_default_width*distance_progress
	new_texture_size[2] = new_texture_default_height*distance_progress
	new_texture_offset[1] = frame_size[1]*0.5 - new_texture_size[1] - default_new_texture_width_offset
	new_texture_offset[2] = frame_size[2]*0.5 - new_texture_size[2] - default_new_texture_height_offset
	local default_lock_offset = frame_size[2]*0.14
	local lock_default_width = 233
	local lock_default_height = 232
	local lock_size = locked_texture_style.size
	local lock_offset = locked_texture_style.offset
	lock_size[1] = lock_default_width*distance_progress
	lock_size[2] = lock_default_height*distance_progress
	lock_offset[1] = -lock_size[1]*0.5
	lock_offset[2] = default_lock_offset - lock_size[2]*0.5
	local dlc_default_width = 95
	local dlc_default_height = 77
	local dlc_size = dlc_texture_style.size
	local dlc_offset = dlc_texture_style.offset
	dlc_size[1] = dlc_default_width*distance_progress
	dlc_size[2] = dlc_default_height*distance_progress
	dlc_offset[1] = -dlc_size[1]*0.5
	dlc_offset[2] = -dlc_size[2]*1.7

	return 
end
StateMapViewSelectLevel._update_dialogue_play_timer = function (self, dt)
	local timer = self.dialogue_timer

	if timer then
		local total_time = 0.5

		if timer == total_time then
			self.dialogue_timer = nil

			return 
		else
			timer = math.min(timer + dt, total_time)
			self.dialogue_timer = timer

			return timer/total_time
		end
	end

	return 
end
StateMapViewSelectLevel.play_dialogue = function (self, wwise_events, reason)
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
	self.set_description_text(self, Localize(wwise_event), Localize(self.dialogue_speaker))

	return 
end
StateMapViewSelectLevel.stop_dialogue = function (self, reason)
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

	self.set_description_text(self, "", nil)

	return 
end
StateMapViewSelectLevel.set_description_text = function (self, text, prefix, locked)
	if prefix then
		text = prefix .. ": " .. text .. "\n"
	else
		text = text .. "\n"
	end

	self._subtitle_text_widget.content.text = text
	local text_color = self._subtitle_text_widget.style.text.text_color

	if locked then
		local target_color = description_text_colors.locked
		text_color[2] = target_color[2]
		text_color[3] = target_color[3]
		text_color[4] = target_color[4]
	else
		local target_color = description_text_colors.default
		text_color[2] = target_color[2]
		text_color[3] = target_color[3]
		text_color[4] = target_color[4]
	end

	return 
end
StateMapViewSelectLevel._show_store_page = function (self, dlc_name)
	if self.platform == "win32" then
		local dlc_id = Managers.unlock:dlc_id(dlc_name)

		if rawget(_G, "Steam") then
			Steam.open_overlay_store(dlc_id)
		end
	elseif self.platform == "xb1" then
		local user_id = Managers.account:user_id()
		local product_id = Managers.unlock:dlc_id(dlc_name)

		XboxLive.show_product_details(user_id, product_id)
	elseif self.platform == "ps4" then
		local user_id = Managers.account:user_id()
		local product_label = Managers.unlock:ps4_dlc_product_label(dlc_name)

		Managers.system_dialog:open_commerce_dialog(NpCommerceDialog.MODE_PRODUCT, user_id, {
			product_label
		})
	end

	return 
end
StateMapViewSelectLevel._play_sound = function (self, event)
	self._map_view:play_sound(event)

	return 
end
StateMapViewSelectLevel._area_already_viewed = function (self, level_key)
	local viewed_levels = self.game_info.viewed_levels

	if viewed_levels then
		return ((level_key == GameActs.prologue[1] or level_key == "any" or viewed_levels[level_key]) and true) or false
	end

	return false
end
StateMapViewSelectLevel._mark_level_as_viewed = function (self, level_key)
	if not self._temp_viewed_levels then
		self._temp_viewed_levels = {}
	end

	local viewed_levels = self._temp_viewed_levels

	if viewed_levels then
		viewed_levels[level_key] = true
	end

	return 
end
StateMapViewSelectLevel._save_viewed_levels = function (self)
	local viewed_levels = self._temp_viewed_levels

	if viewed_levels then
		local game_info_viewed_levels = self.game_info.viewed_levels

		for level_key, _ in pairs(viewed_levels) do
			game_info_viewed_levels[level_key] = true
		end
	end

	return 
end

return 
