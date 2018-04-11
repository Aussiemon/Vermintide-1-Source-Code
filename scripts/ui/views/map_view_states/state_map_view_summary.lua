local definitions = local_require("scripts/ui/views/map_view_states/definitions/state_map_view_summary_definitions")
local widgets = definitions.widgets
local scenegraph_definition = definitions.scenegraph_definition
local generic_input_actions = definitions.generic_input_actions
StateMapViewSummary = class(StateMapViewSummary)
StateMapViewSummary.NAME = "StateMapViewSummary"
StateMapViewSummary.on_enter = function (self, params)
	print("[MapViewState] Enter Substate StateMapViewSummary")

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
	self.platform = PLATFORM
	local input_service = self.input_manager:get_service("map_menu")
	local gui_layer = UILayer.default + 30
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 2, gui_layer, generic_input_actions.default)

	self.menu_input_description:set_input_description(nil)

	self.ui_animations = {}

	self.create_ui_elements(self)
	self.setup_game_info(self)
	self._map_view:set_time_line_index(4)
	self._map_view:animate_title_text(self._title_text_widget)
	self._map_view:set_mask_enabled(true)
	self.start_open_animation(self)

	return 
end
StateMapViewSummary.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._dead_space_filler_widget = UIWidget.init(widgets.dead_space_filler)
	self._overlay_widget = UIWidget.init(widgets.overlay)
	self._title_text_widget = UIWidget.init(widgets.title_text)
	self._background_widget = UIWidget.init(widgets.background)
	self._frame_left_widget = UIWidget.init(widgets.frame_left)
	self._frame_right_widget = UIWidget.init(widgets.frame_right)
	self._edge_left_widget = UIWidget.init(widgets.edge_left)
	self._edge_right_widget = UIWidget.init(widgets.edge_right)
	self._level_image_widget = UIWidget.init(widgets.level_image)
	self._level_image_masked_widget = UIWidget.init(widgets.level_image_masked)
	self._level_image_frame_widget = UIWidget.init(widgets.level_image_frame)
	self._level_image_frame_masked_widget = UIWidget.init(widgets.level_image_frame_masked)
	self._level_name_widget = UIWidget.init(widgets.level_name)
	self._game_mode_title_widget = UIWidget.init(widgets.game_mode_title)
	self._game_mode_name_widget = UIWidget.init(widgets.game_mode_name)
	self._difficulty_title_widget = UIWidget.init(widgets.difficulty_title)
	self._difficulty_name_widget = UIWidget.init(widgets.difficulty_name)
	self._difficulty_banner_widget = UIWidget.init(widgets.difficulty_banner)
	self._difficulty_banner_masked_widget = UIWidget.init(widgets.difficulty_banner_masked)
	self._setting_glow_mask_widget = UIWidget.init(widgets.setting_glow_mask)
	self._divider_widget = UIWidget.init(widgets.divider)
	self._setting_text_widget = UIWidget.init(widgets.setting_text)
	self._setting_text_bg_widget = UIWidget.init(widgets.setting_text_bg)
	self._setting_arrow_up_widget = UIWidget.init(widgets.setting_arrow_up)
	self._setting_arrow_down_widget = UIWidget.init(widgets.setting_arrow_down)
	self._setting_glow_widget = UIWidget.init(widgets.setting_glow)
	self.open_animation_widgets = {
		self._level_image_masked_widget,
		self._level_image_frame_masked_widget
	}
	self.close_animation_widgets = {
		self._level_image_masked_widget,
		self._level_image_frame_masked_widget
	}
	self.static_widgets = {
		self._level_name_widget,
		self._game_mode_title_widget,
		self._game_mode_name_widget,
		self._difficulty_title_widget,
		self._difficulty_name_widget,
		self._setting_glow_mask_widget,
		self._divider_widget,
		self._setting_text_widget,
		self._setting_text_bg_widget,
		self._setting_arrow_up_widget,
		self._setting_arrow_down_widget,
		self._setting_glow_widget
	}

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
StateMapViewSummary.setup_game_info = function (self)
	self._change_privacy_setting(self, 1, true)

	local game_info = self.game_info
	local use_level_filter = game_info.use_level_filter
	local level_filter_list = game_info.level_filter_list
	local game_mode = game_info.game_mode
	local level_key = (use_level_filter and level_filter_list[1]) or game_info.level_key
	local level_information = self.map_view_area_handler:get_level_information_by_game_mode(level_key, game_mode)
	local difficulty_data = level_information.difficulty_data
	local level_image = (use_level_filter and "level_image_level_list") or level_information.level_image
	local level_display_name = (use_level_filter and "title_mission_list") or level_information.display_name
	self._level_image_widget.content.texture_id = level_image
	self._level_image_masked_widget.content.texture_id = level_image
	self._level_name_widget.content.text = level_display_name
	local game_mode_settings = GameModeSettings[game_mode]
	local game_mode_display_name = game_mode_settings.display_name
	self._game_mode_name_widget.content.text = game_mode_display_name
	local difficulty_rank = game_info.difficulty_rank
	local difficulty_manager = Managers.state.difficulty
	local difficulty_settings = DifficultySettings
	local difficulty_display_name, difficulty_banner_texture = nil

	for index, data in ipairs(difficulty_data) do
		if data.rank == difficulty_rank then
			local difficulty_key = data.key
			local settings = difficulty_settings[difficulty_key]
			difficulty_display_name = settings.display_name
			difficulty_banner_texture = settings.map_screen_textures.banner
			self._difficulty_key = difficulty_key

			break
		end
	end

	self._difficulty_name_widget.content.text = difficulty_display_name
	self._difficulty_banner_widget.content.texture_id = difficulty_banner_texture
	self._difficulty_banner_masked_widget.content.texture_id = difficulty_banner_texture .. "_masked"
	local gui = self.ui_renderer.gui
	local gui_material = Gui.material(gui, difficulty_banner_texture)

	Material.set_scalar(gui_material, "distortion_offset_top", 0.5)

	return 
end
StateMapViewSummary._start_game = function (self, t)
	local game_info = self.game_info
	local game_mode = game_info.game_mode
	local area = game_info.area

	if area == "world" then
		area = nil
	end

	local level_key = nil
	local difficulty_key = self._difficulty_key
	local use_level_filter = game_info.use_level_filter
	local level_filter_list = game_info.level_filter_list

	if not use_level_filter then
		level_key = game_info.level_key
	end

	Managers.state.difficulty:set_difficulty(difficulty_key)

	local random_level = level_key == "any"
	local private_game = game_info.private

	print("------------------------------------------")
	print("----------------START GAME----------------")
	print("------------------------------------------")
	print("Game Mode:", game_mode)
	print("Area:", area)
	print("Level:", level_key)
	print("Use Level Filter:", use_level_filter)

	if use_level_filter then
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
	Managers.matchmaking:find_game(level_key, difficulty_key, private_game, random_level, game_mode, area, t, use_level_filter and level_filter_list)
	self._play_sound(self, "hud_menu_press_start")

	return 
end
StateMapViewSummary.on_exit = function (self, params)
	self.menu_input_description:destroy()

	self.menu_input_description = nil

	return 
end
StateMapViewSummary.update = function (self, dt, t)
	if not self._transition_timer then
		self._handle_input(self, dt, t)
	end

	self.draw(self, dt)
	self._update_transition_timer(self, dt)

	if not self._transition_timer then
		return self._new_state
	end

	return 
end
StateMapViewSummary.post_update = function (self, dt, t)
	return 
end
StateMapViewSummary._handle_input = function (self, dt, t)
	if self._new_state then
		return 
	end

	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	elseif input_service.get(input_service, "move_up") or input_service.get(input_service, "move_up_hold") then
		self.controller_cooldown = GamepadSettings.menu_cooldown

		if self._change_privacy_setting(self, 1) then
			self._play_sound(self, "Play_hud_select")
		end
	elseif input_service.get(input_service, "move_down") or input_service.get(input_service, "move_down_hold") then
		self.controller_cooldown = GamepadSettings.menu_cooldown

		if self._change_privacy_setting(self, -1) then
			self._play_sound(self, "Play_hud_select")
		end
	elseif input_service.get(input_service, "confirm") then
		self._start_game(self, t)
	elseif input_service.get(input_service, "back") then
		self._new_state = StateMapViewSelectDifficulty

		self._play_sound(self, "Play_hud_select")
	elseif input_service.get(input_service, "toggle_menu") then
		local return_to_game = not self.parent.ingame_ui.menu_active

		self._map_view:exit(return_to_game)
	end

	if self._new_state then
		self.start_close_animation(self)
	end

	return 
end
StateMapViewSummary.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	if self._draw_masked_widgets then
		UIRenderer.draw_widget(ui_renderer, self._difficulty_banner_masked_widget)
		UIRenderer.draw_widget(ui_renderer, self._level_image_masked_widget)
		UIRenderer.draw_widget(ui_renderer, self._level_image_frame_masked_widget)
	else
		UIRenderer.draw_widget(ui_renderer, self._difficulty_banner_widget)
		UIRenderer.draw_widget(ui_renderer, self._level_image_widget)
		UIRenderer.draw_widget(ui_renderer, self._level_image_frame_widget)
	end

	UIRenderer.draw_widget(ui_renderer, self._title_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._background_widget)
	UIRenderer.draw_widget(ui_renderer, self._dead_space_filler_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_left_widget)
	UIRenderer.draw_widget(ui_renderer, self._frame_right_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_left_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_right_widget)
	UIRenderer.draw_widget(ui_renderer, self._level_name_widget)
	UIRenderer.draw_widget(ui_renderer, self._game_mode_title_widget)
	UIRenderer.draw_widget(ui_renderer, self._game_mode_name_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_title_widget)
	UIRenderer.draw_widget(ui_renderer, self._difficulty_name_widget)
	UIRenderer.draw_widget(ui_renderer, self._divider_widget)
	UIRenderer.draw_widget(ui_renderer, self._setting_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._setting_text_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self._setting_arrow_up_widget)
	UIRenderer.draw_widget(ui_renderer, self._setting_arrow_down_widget)
	UIRenderer.draw_widget(ui_renderer, self._setting_glow_widget)
	UIRenderer.draw_widget(ui_renderer, self._setting_glow_mask_widget)
	UIRenderer.end_pass(ui_renderer)

	if not self._transition_timer then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
StateMapViewSummary._play_sound = function (self, event)
	self._map_view:play_sound(event)

	return 
end
local privacy_settings = {
	{
		display_name = "map_public_setting",
		private = false
	},
	{
		display_name = "map_screen_private_button",
		private = true
	}
}
StateMapViewSummary._change_privacy_setting = function (self, value, ignore_animations)
	local num_privacy_settings = #privacy_settings

	if not self._current_privacy_index then
		self._current_privacy_index = 0
	end

	if value < 0 then
		self._current_privacy_index = (self._current_privacy_index == 1 and num_privacy_settings) or self._current_privacy_index + value
	else
		self._current_privacy_index = self._current_privacy_index % num_privacy_settings + value
	end

	if not ignore_animations then
		if 0 < value then
			local up_arrow_scenegraph = self.ui_scenegraph.setting_arrow_up
			local up_arrow_scenegraph_position = up_arrow_scenegraph.position
			local animation_height_offset = UIAnimation.init(UIAnimation.function_by_time, up_arrow_scenegraph_position, 2, 40, 45, 0.2, math.ease_pulse)
			self._setting_arrow_up_widget.animations[animation_height_offset] = true
		else
			local down_arrow_scenegraph = self.ui_scenegraph.setting_arrow_down
			local down_arrow_scenegraph_position = down_arrow_scenegraph.position
			local animation_height_offset = UIAnimation.init(UIAnimation.function_by_time, down_arrow_scenegraph_position, 2, -44, -49, 0.2, math.ease_pulse)
			self._setting_arrow_down_widget.animations[animation_height_offset] = true
		end
	end

	for index, setting in ipairs(privacy_settings) do
		if index == self._current_privacy_index then
			local display_name = setting.display_name
			self._setting_text_widget.content.text = display_name
			self.game_info.private = setting.private
			local text_style = self._setting_text_widget.style.text

			if not ignore_animations then
				local text_animation = UIAnimation.init(UIAnimation.function_by_time, text_style, "font_size", 24, 34, 0.25, math.ease_pulse)
				self._setting_text_widget.animations[text_animation] = true
			end

			break
		end
	end

	return true
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

StateMapViewSummary.start_open_animation = function (self)
	self._draw_masked_widgets = true
	self._transition_timer = 0.75
	self._transition_cb = function ()
		self._transition_timer = 0.15

		self._map_view:set_mask_enabled(false)

		self._draw_masked_widgets = false

		return 
	end

	for index, widget in ipairs(self.open_animation_widgets) do
		local target = widget.offset
		local target_index = 2
		local from = -1000
		local to = target[target_index]
		local anim_time = 0.75

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

			local animation = UIAnimation.init(UIAnimation.wait, 0.75, UIAnimation.function_by_time, target, target_index, from, to, anim_time, math.easeCubic)

			UIWidget.animate(widget, animation)
		end
	end

	self._play_sound(self, "Play_hud_map_console_change_state_vertical")

	return 
end
StateMapViewSummary.start_close_animation = function (self)
	self._transition_timer = 0.15
	self._transition_cb = function ()
		self._draw_masked_widgets = true
		self._transition_timer = 0.75

		self._map_view:set_mask_enabled(true)

		return 
	end

	local function animate(widget, time, delay)
		local target = widget.offset
		local target_index = 2
		local from = target[target_index]
		local to = 1000
		local anim_time = time

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.wait, delay, UIAnimation.function_by_time, target, target_index, from, to, anim_time, anim_func)

		UIWidget.animate(widget, animation)

		return 
	end

	animate(self._difficulty_banner_masked_widget, 0.75, 0.15)

	for index, widget in ipairs(self.close_animation_widgets) do
		animate(widget, 0.75, 0.25)
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

	self._map_view:animate_title_text(self._title_text_widget, true)
	self._play_sound(self, "Play_hud_map_console_change_state_vertical")

	return 
end
StateMapViewSummary._update_transition_timer = function (self, dt)
	if not self._transition_timer then
		return 
	end

	if self._transition_timer == 0 then
		self._transition_timer = nil

		if self._transition_cb then
			self._transition_cb()

			self._transition_cb = nil
		end
	else
		self._transition_timer = math.max(self._transition_timer - dt, 0)
	end

	return 
end

return 
