local definitions = local_require("scripts/ui/views/map_view_states/definitions/state_map_view_start_definitions")
local widgets = definitions.widgets
local element_size = definitions.element_size
local create_element = definitions.create_element
local options = definitions.options
local generic_input_actions = definitions.generic_input_actions
local scenegraph_definition = definitions.scenegraph_definition
local DO_RELOAD = false
local quick_play_data = {
	random_level = true,
	private_game = false,
	game_mode = "adventure",
	level_key = "any"
}
StateMapViewStart = class(StateMapViewStart)
StateMapViewStart.NAME = "StateMapViewStart"
StateMapViewStart.on_enter = function (self, params)
	print("[MapViewState] Enter Substate StateMapViewStart")

	self.game_info = params.game_info
	local ingame_ui_context = params.ingame_ui_context
	self.map_view_area_handler = params.map_view_area_handler
	self.map_view_helper = params.map_view_helper
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.statistics_db = ingame_ui_context.statistics_db
	self.render_settings = {
		snap_pixel_positions = true
	}
	self._map_view = params.map_view
	self.difficulty_manager = Managers.state.difficulty
	self.platform = Application.platform()
	self.ui_animations = {}
	local player_manager = Managers.player
	local local_player = player_manager.local_player(player_manager)
	self._stats_id = local_player.stats_id(local_player)
	local input_service = self.input_manager:get_service("map_menu")
	local gui_layer = UILayer.default + 30
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 4, gui_layer, generic_input_actions.default)

	self.menu_input_description:set_input_description(nil)

	if self.game_info.quick_play_difficulty_rank then
		local saved_difficulty_rank = math.min(self.game_info.quick_play_difficulty_rank, DifficultySettings[DefaultStartingDifficulty].rank)
		local closest_difficulty_rank_total, highest_difficulty_rank_total = self._get_start_difficulty_rank(self, saved_difficulty_rank, quick_play_data.game_mode, quick_play_data.area)
		self._current_choosen_difficulty_rank = closest_difficulty_rank_total
		self._highest_difficulty_rank_total = highest_difficulty_rank_total or DifficultySettings[DefaultStartingDifficulty].rank
	else
		self._current_choosen_difficulty_rank = DifficultySettings[DefaultQuickPlayStartingDifficulty].rank or 1
		self._highest_difficulty_rank_total = DifficultySettings[DefaultStartingDifficulty].rank
	end

	self.create_ui_elements(self, params)
	self._map_view:set_time_line_index(nil)
	self._map_view:animate_title_text(self._title_text_widget)
	self._map_view:set_mask_enabled(true)

	if Application.platform() == "ps4" then
		local region = Managers.account:region()
		local matchmaking_region = Application.user_setting("matchmaking_region")
		local matchmaking_region_not_set = matchmaking_region == nil or matchmaking_region == "auto"

		if region == nil and matchmaking_region_not_set then
			self.matchmaking_popup_id = Managers.popup:queue_popup(Localize("popup_matchmaking_region_not_fetched"), Localize("popup_discard_changes_topic"), "ok", Localize("button_ok"))
		end
	end

	return 
end
StateMapViewStart._get_start_difficulty_rank = function (self, saved_rank, game_mode_name, area_name)
	local level_list = self.map_view_area_handler:get_level_list_by_game_mode_and_area(game_mode_name, area_name)
	local closest_difficulty_rank_total, highest_difficulty_rank_total = nil

	for area, area_level_list in pairs(level_list) do
		if area ~= "world" then
			local difficulty_data = self.map_view_helper:get_difficulty_data_summary(area_level_list)
			local closest_difficulty_rank = self._get_closest_unlocked_rank(self, saved_rank, difficulty_data)
			local highest_difficulty_rank = self._get_highest_unlocked_rank(self, difficulty_data)

			if not highest_difficulty_rank_total or highest_difficulty_rank_total < highest_difficulty_rank then
				highest_difficulty_rank_total = highest_difficulty_rank
			end

			if not closest_difficulty_rank_total or math.abs(closest_difficulty_rank - saved_rank) < math.abs(closest_difficulty_rank_total - saved_rank) then
				closest_difficulty_rank_total = closest_difficulty_rank
			end
		end
	end

	return closest_difficulty_rank_total, math.min(highest_difficulty_rank_total, DifficultySettings[DefaultStartingDifficulty].rank)
end
StateMapViewStart._get_highest_unlocked_rank = function (self, difficulty_data)
	local return_rank = nil

	for i, data in ipairs(difficulty_data) do
		if data.unlocked and (not return_rank or return_rank < data.rank) then
			return_rank = data.rank
		end
	end

	return return_rank
end
StateMapViewStart._get_closest_unlocked_rank = function (self, rank, difficulty_data)
	local return_rank = nil

	for i, data in ipairs(difficulty_data) do
		if data.unlocked and (not return_rank or math.abs(data.rank - rank) < math.abs(return_rank - rank)) then
			return_rank = data.rank
		end
	end

	return return_rank
end
StateMapViewStart.create_ui_elements = function (self, params)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._title_text_widget = UIWidget.init(widgets.title_text)
	self._background_widget = UIWidget.init(widgets.background)
	self._dead_space_filler_widget = UIWidget.init(widgets.dead_space_filler)
	self._difficulty_icons_widget = UIWidget.init(widgets.difficulty_icons)
	self._difficulty_lock_icons_widget = UIWidget.init(widgets.difficulty_lock_icons)
	self._difficulty_slots_widget = UIWidget.init(widgets.difficulty_slots)
	self._difficulty_bg_widget = UIWidget.init(widgets.difficulty_bg)
	self._difficulty_arrow_up_widget = UIWidget.init(widgets.difficulty_arrow_up)
	self._difficulty_arrow_down_widget = UIWidget.init(widgets.difficulty_arrow_down)
	self._difficulty_text_widget = UIWidget.init(widgets.difficulty_text)
	self._difficulty_text_bg_widget = UIWidget.init(widgets.difficulty_text_bg)
	self._frame_left_widget = UIWidget.init(widgets.frame_left)
	self._frame_right_widget = UIWidget.init(widgets.frame_right)
	local start_selection_index = (params.initial_state and 1) or self.game_info.game_type_index

	if start_selection_index == 1 then
		self.open_animation_widgets = {
			self._difficulty_icons_widget,
			self._difficulty_lock_icons_widget,
			self._difficulty_slots_widget,
			self._difficulty_bg_widget,
			self._difficulty_arrow_up_widget,
			self._difficulty_arrow_down_widget,
			self._difficulty_text_bg_widget,
			self._difficulty_text_widget
		}
		self.close_animation_widgets = self.open_animation_widgets
	else
		self.open_animation_widgets = {
			self._difficulty_icons_widget,
			self._difficulty_lock_icons_widget,
			self._difficulty_slots_widget,
			self._difficulty_bg_widget
		}
		self.close_animation_widgets = {
			self._difficulty_icons_widget,
			self._difficulty_lock_icons_widget,
			self._difficulty_slots_widget,
			self._difficulty_bg_widget,
			self._difficulty_arrow_up_widget,
			self._difficulty_arrow_down_widget,
			self._difficulty_text_bg_widget,
			self._difficulty_text_widget
		}
	end

	local elements = {}

	for index, data in ipairs(options) do
		local name = data.name
		local textures = data.textures
		local display_name = data.display_name
		local description_text = data.description_text or ""
		elements[index] = UIWidget.init(create_element("element_pivot", display_name, textures, description_text))
	end

	self._elements = elements

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	local up_arrow_scenegraph = self.ui_scenegraph.difficulty_arrow_up
	local down_arrow_scenegraph = self.ui_scenegraph.difficulty_arrow_down
	local up_offset = self._difficulty_arrow_up_widget.offset
	local down_offset = self._difficulty_arrow_down_widget.offset
	local up_animation = UIAnimation.init(UIAnimation.pulse_animation, up_offset, 2, 0, 5, 1.5)
	local down_animation = UIAnimation.init(UIAnimation.pulse_animation, down_offset, 2, 0, -5, 1.5)
	self._difficulty_arrow_up_widget.animations[up_animation] = true
	self._difficulty_arrow_down_widget.animations[down_animation] = true

	self._align_elements(self)

	if params.initial_state then
		params.initial_state = nil

		self._set_selection(self, 1, true)
	else
		local selection_index = self.game_info.game_type_index

		self._set_selection(self, selection_index, true)
	end

	self._update_elements(self, 0, true)
	self._change_difficulty(self, 0, true)

	self._selection_timer = nil

	self.start_open_animation(self)

	return 
end
StateMapViewStart._wanted_state = function (self)
	local new_state = self.parent:wanted_gamepad_state()

	if new_state then
		self.parent:clear_wanted_gamepad_state()
	end

	return new_state
end
StateMapViewStart.on_exit = function (self, params)
	if self.matchmaking_popup_id then
		Managers.popup:cancel_popup(self.matchmaking_popup_id)

		self.matchmaking_popup_id = nil
	end

	self.menu_input_description:destroy()

	self.menu_input_description = nil

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

StateMapViewStart.start_open_animation = function (self)
	self._transition_timer = 0.65

	for index, widget in ipairs(self._elements) do
		local target = widget.offset
		local target_index = 2
		local from = -800
		local to = target[target_index]
		local anim_time = 0.5

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, anim_time, anim_func)

		UIWidget.animate(widget, animation)
	end

	for _, widget in ipairs(self.open_animation_widgets) do
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

	self._play_sound(self, "Play_hud_map_console_change_state_vertical")

	return 
end
StateMapViewStart.start_close_animation = function (self)
	self._transition_timer = 0.65

	for index, widget in ipairs(self._elements) do
		local target = widget.offset
		local target_index = 2
		local from = target[target_index]
		local to = 800
		local anim_time = 0.5

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.wait, 0.15, UIAnimation.function_by_time, target, target_index, from, to, anim_time, anim_func)

		UIWidget.animate(widget, animation)
	end

	for _, widget in ipairs(self.close_animation_widgets) do
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

	self._map_view:animate_title_text(self._title_text_widget, true)
	self._play_sound(self, "Play_hud_map_console_change_state_vertical")

	return 
end
StateMapViewStart._update_transition_timer = function (self, dt)
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
StateMapViewStart.update = function (self, dt, t)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if self.matchmaking_popup_id then
		local result = Managers.popup:query_result(self.matchmaking_popup_id)

		if result then
			Managers.popup:cancel_popup(self.matchmaking_popup_id)

			self.matchmaking_popup_id = nil
		end
	end

	local transitioning = self._map_view:transitioning()

	if not transitioning and not self._transition_timer then
		self._handle_input(self, dt, t)
	end

	self._update_elements(self, dt)
	self.draw(self, dt)
	self._update_transition_timer(self, dt)

	local wanted_state = self._wanted_state(self)

	if not self._transition_timer then
		return wanted_state or self._new_state
	end

	return 
end
StateMapViewStart.post_update = function (self, dt, t)
	return 
end
StateMapViewStart._handle_input = function (self, dt, t)
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
		elseif input_service.get(input_service, "toggle_menu") or input_service.get(input_service, "back", true) then
			local return_to_game = not self.parent.ingame_ui.menu_active

			self.parent:exit(return_to_game)
		elseif input_service.get(input_service, "refresh") then
			self.parent:exit(nil, "lobby_browser_view")
		elseif self._selection_index and self._selection_index == 1 then
			if input_service.get(input_service, "confirm") then
				self._play_sound(self, "hud_menu_press_start")
				self._start_quick_game(self, t)
			elseif input_service.get(input_service, "move_up") or input_service.get(input_service, "move_up_hold") then
				self.controller_cooldown = GamepadSettings.menu_cooldown

				if self._change_difficulty(self, 1) then
					self._play_sound(self, "Play_hud_select")
				end
			elseif input_service.get(input_service, "move_down") or input_service.get(input_service, "move_down_hold") then
				self.controller_cooldown = GamepadSettings.menu_cooldown

				if self._change_difficulty(self, -1) then
					self._play_sound(self, "Play_hud_select")
				end
			end
		elseif self._selection_index and self._selection_index == 2 and input_service.get(input_service, "confirm") then
			self._play_sound(self, "Play_hud_main_menu_open")

			self._new_state = StateMapViewGameMode
		end
	end

	if self._new_state then
		self.start_close_animation(self)
	end

	return 
end
StateMapViewStart.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self._title_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._background_widget)
	UIRenderer.draw_widget(ui_renderer, self._dead_space_filler_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_icons_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_lock_icons_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_slots_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_arrow_up_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_arrow_down_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_text_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_left_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_right_widget)

	for _, widget in ipairs(self._elements) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	if not self._transition_timer and not self.matchmaking_popup_id then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
StateMapViewStart._change_difficulty = function (self, value, ignore_animations)
	local highest_available = self._highest_difficulty_rank_total

	if highest_available < self._current_choosen_difficulty_rank + value or self._current_choosen_difficulty_rank + value < 1 then
		return 
	end

	self._current_choosen_difficulty_rank = self._current_choosen_difficulty_rank + value
	self._current_choosen_difficulty_rank = math.max(1, math.min(highest_available, self._current_choosen_difficulty_rank))
	self._difficulty_icons_widget.style.texture_id.draw_count = self._current_choosen_difficulty_rank
	self._difficulty_lock_icons_widget.style.texture_id.draw_count = DifficultySettings[DefaultStartingDifficulty].rank - highest_available
	self.game_info.quick_play_difficulty_rank = self._current_choosen_difficulty_rank
	local difficulty_rank = self._current_choosen_difficulty_rank
	self._difficulty_arrow_up_widget.content.visible = difficulty_rank < DifficultySettings[DefaultStartingDifficulty].rank
	self._difficulty_arrow_down_widget.content.visible = 1 < difficulty_rank

	if not ignore_animations then
		if 0 < value then
			local up_arrow_scenegraph = self.ui_scenegraph.difficulty_arrow_up
			local up_arrow_scenegraph_position = up_arrow_scenegraph.position
			local animation_height_offset = UIAnimation.init(UIAnimation.function_by_time, up_arrow_scenegraph_position, 2, 40, 45, 0.2, math.ease_pulse)
			self._difficulty_arrow_up_widget.animations[animation_height_offset] = true
		else
			local down_arrow_scenegraph = self.ui_scenegraph.difficulty_arrow_down
			local down_arrow_scenegraph_position = down_arrow_scenegraph.position
			local animation_height_offset = UIAnimation.init(UIAnimation.function_by_time, down_arrow_scenegraph_position, 2, -44, -49, 0.2, math.ease_pulse)
			self._difficulty_arrow_down_widget.animations[animation_height_offset] = true
		end
	end

	for index, name in ipairs(DefaultDifficulties) do
		local settings = DifficultySettings[name]

		if settings.rank == difficulty_rank then
			local display_name = settings.display_name
			self._difficulty_text_widget.content.text = display_name
			local text_style = self._difficulty_text_widget.style.text

			if not ignore_animations then
				local text_animation = UIAnimation.init(UIAnimation.function_by_time, text_style, "font_size", 24, 34, 0.25, math.ease_pulse)
				self._difficulty_text_widget.animations[text_animation] = true
			end

			break
		end
	end

	return true
end
StateMapViewStart._align_elements = function (self)
	local num_elements = #self._elements
	local spacing = 100
	local element_width = element_size[1]
	local distance = element_width + spacing
	local start_offset = -distance*0.5

	for index, widget in ipairs(self._elements) do
		widget.offset[1] = start_offset + distance*(index - 1)
		widget.content.position_offset = widget.offset[1]
	end

	return 
end
StateMapViewStart._set_selection = function (self, index, ignore_sound)
	self.game_info.game_type_index = index

	if self._selection_timer then
		local instant = true

		self._update_elements(self, 0, instant)
	end

	self._selection_timer = 0
	self._selection_index = index
	local input_descriptions = (index == 1 and generic_input_actions.quick_play) or generic_input_actions.default

	self.menu_input_description:change_generic_actions(input_descriptions)

	local widget = self._elements[index]
	local text_style = widget.style.description_text
	local font = UIFontByResolution(text_style)
	local width = widget.style.description_text.size[1]
	local lines = UIRenderer.word_wrap(self.ui_renderer, widget.content.description_text, font[1], text_style.font_size, width)
	local _, text_height = UIRenderer.text_size(self.ui_renderer, widget.content.description_text, font[1], text_style.font_size)
	widget.style.description_rect.size[2] = text_height*#lines + text_style.font_size

	if not ignore_sound then
		self._play_sound(self, "Play_hud_hover")
	end

	return 
end
StateMapViewStart.update_selection_timer = function (self, dt)
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
StateMapViewStart._update_elements = function (self, dt, instant)
	local selection_progress = (instant and 1) or self.update_selection_timer(self, dt)

	if not selection_progress then
		return 
	end

	for index, widget in ipairs(self._elements) do
		self._animate_element(self, widget, index, selection_progress)
	end

	return 
end
StateMapViewStart._animate_element = function (self, widget, index, progress)
	local is_selection_widget = self._selection_index == index
	local anim_progress = (is_selection_widget and math.easeCubic(progress)) or math.easeCubic(progress - 1)
	local widget_style = widget.style
	local rect_style = widget_style.rect
	local background_texture_selected_style = widget_style.background_texture_selected
	local description_rect_style = widget_style.description_rect
	local description_text_style = widget_style.description_text
	local locked_texture_style = widget_style.locked_texture
	local overlay_style = widget_style.overlay
	local glow_left_texture_style = widget_style.glow_left_texture
	local glow_right_texture_style = widget_style.glow_right_texture
	local alpha = anim_progress*255
	local rect_alpha = anim_progress*120
	overlay_style.color[1] = (anim_progress - 1)*170
	background_texture_selected_style.color[1] = alpha
	description_rect_style.color[1] = rect_alpha
	description_text_style.text_color[1] = alpha
	glow_left_texture_style.color[1] = alpha
	glow_right_texture_style.color[1] = alpha
	local normal_text_color = widget.content.text_color
	local selected_text_color = widget.content.text_color_selected
	widget.style.text.text_color[2] = math.lerp(normal_text_color[2], selected_text_color[2], math.smoothstep(anim_progress, 0, 1))
	widget.style.text.text_color[3] = math.lerp(normal_text_color[3], selected_text_color[3], math.smoothstep(anim_progress, 0, 1))
	widget.style.text.text_color[4] = math.lerp(normal_text_color[4], selected_text_color[4], math.smoothstep(anim_progress, 0, 1))

	if index == 1 then
		self._animate_difficulty_selection(self, anim_progress)
	end

	return 
end
StateMapViewStart._animate_difficulty_selection = function (self, progress)
	local alpha = progress*255
	self._difficulty_text_widget.style.text.text_color[1] = alpha
	self._difficulty_arrow_up_widget.style.texture_id.color[1] = alpha
	self._difficulty_arrow_down_widget.style.texture_id.color[1] = alpha
	self._difficulty_text_bg_widget.style.texture_id.color[1] = alpha

	return 
end
StateMapViewStart._show_store_page = function (self, dlc_name)
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
StateMapViewStart._play_sound = function (self, event)
	self._map_view:play_sound(event)

	return 
end
StateMapViewStart._start_quick_game = function (self, t)
	local game_info = self.game_info
	local difficulty_rank = game_info.quick_play_difficulty_rank
	local difficulty_key = nil

	for index, name in ipairs(DefaultDifficulties) do
		local settings = DifficultySettings[name]

		if settings.rank == difficulty_rank then
			difficulty_key = name

			break
		end
	end

	if difficulty_key then
		Managers.state.difficulty:set_difficulty(difficulty_key)
	end

	Managers.matchmaking:find_game(quick_play_data.level_key, difficulty_key, quick_play_data.private_game, quick_play_data.random_level, quick_play_data.game_mode, quick_play_data.area, t)

	return 
end

return 
