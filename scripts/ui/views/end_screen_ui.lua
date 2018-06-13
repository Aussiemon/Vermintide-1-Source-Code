local definitions = local_require("scripts/ui/views/end_screen_ui_definitions")
local DO_RELOAD = true
EndScreenUI = class(EndScreenUI)

EndScreenUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.world_manager = ingame_ui_context.world_manager
	self.camera_manager = ingame_ui_context.camera_manager
	self.voting_manager = Managers.state.voting
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.timers = {}
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager:create_input_service("end_screen_ui", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager:map_device_to_service("end_screen_ui", "keyboard")
	input_manager:map_device_to_service("end_screen_ui", "mouse")
	input_manager:map_device_to_service("end_screen_ui", "gamepad")

	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.gdc_build = Development.parameter("gdc")

	rawset(_G, "EndScreenUI_pointer", self)
	self:create_ui_elements()

	DO_RELOAD = false
end

EndScreenUI.destroy = function (self)
	if self.voting_data then
		self.voting_data = nil

		ShowCursorStack.pop()
	end

	self.ui_animator = nil

	rawset(_G, "EndScreenUI_pointer", nil)
	GarbageLeakDetector.register_object(self, "EndScreenUI")
end

EndScreenUI.create_ui_elements = function (self)
	self.draw_flags = {
		draw_text = false,
		draw_continue = false,
		draw_background = false
	}
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph)
	self.scenegraph_definition = definitions.scenegraph
	self.level_completed_defeat_screen_widget = UIWidget.init(definitions.widgets.defeat_screen)
	self.defeat_button_1 = UIWidget.init(definitions.widgets.defeat_button_1)
	self.defeat_button_2 = UIWidget.init(definitions.widgets.defeat_button_2)
	self.defeat_button_3 = UIWidget.init(definitions.widgets.defeat_button_3)
	self.background_rect_widget = UIWidget.init(definitions.widgets.background_rect)
	self.level_completed_widget = UIWidget.init(definitions.widgets.level_completed_widget)

	if self.gdc_build then
		self.level_completed_widget_gdc = UIWidget.init(definitions.widgets.level_completed_widget_gdc)
	end

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, definitions.animations)
end

EndScreenUI.input_service = function (self)
	return self.input_manager:get_service("end_screen_ui")
end

EndScreenUI.on_enter = function (self, you_win, checkpoint_available)
	self.is_active = true
	local input_manager = self.input_manager

	if not Managers.chat:chat_is_focused() then
		input_manager:block_device_except_service("end_screen_ui", "mouse")
		input_manager:block_device_except_service("end_screen_ui", "keyboard")
		input_manager:block_device_except_service("end_screen_ui", "gamepad", 1)
	end

	self.is_victory = you_win
	self.checkpoint_available = checkpoint_available

	self:show_text_screen(you_win)
	self:play_sound("mute_all_world_sounds")
	self:play_sound("hud_gameplay_stance_deactivate")
	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_on")
end

EndScreenUI.on_exit = function (self)
	local draw_flags = self.draw_flags

	if draw_flags.draw_background then
		self:fade_out_background()
	end

	if draw_flags.draw_continue then
		self:fade_out_continue_vote()
	end

	self.is_active = false

	if not Managers.chat:chat_is_focused() then
		local input_manager = self.input_manager

		input_manager:device_unblock_all_services("mouse", 1)
		input_manager:device_unblock_all_services("keyboard", 1)
		input_manager:device_unblock_all_services("gamepad", 1)
	end

	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_off")
end

EndScreenUI.on_complete = function (self)
	self.active_end_screen = nil
	self.ingame_ui.end_screen_active = nil
	self.is_complete = true
end

EndScreenUI.fade_in_background = function (self)
	self.background_anim_id = self.ui_animator:start_animation("fade_in_background", {
		self.background_rect_widget
	}, self.scenegraph_definition, self.draw_flags)
end

EndScreenUI.fade_out_background = function (self)
	self.background_anim_id = self.ui_animator:start_animation("fade_out_background", {
		self.background_rect_widget
	}, self.scenegraph_definition, self.draw_flags)
end

EndScreenUI.fade_in_continue_vote = function (self)
	local widgets = {
		window = self.level_completed_defeat_screen_widget,
		button_1 = self.defeat_button_1,
		button_2 = self.defeat_button_2,
		button_3 = self.defeat_button_3
	}
	self.continue_anim_id = self.ui_animator:start_animation("fade_in_continue", widgets, self.scenegraph_definition, self.draw_flags)
end

EndScreenUI.fade_out_continue_vote = function (self)
	if self.draw_flags.draw_continue then
		local widgets = {
			window = self.level_completed_defeat_screen_widget,
			button_1 = self.defeat_button_1,
			button_2 = self.defeat_button_2,
			button_3 = self.defeat_button_3
		}
		self.continue_anim_id = self.ui_animator:start_animation("fade_out_continue", widgets, self.scenegraph_definition, self.draw_flags)
	end
end

local fake_mission_data = {
	wave_completed_time = 0,
	wave_completed = 0,
	starting_wave = 0,
	start_time = 0
}

EndScreenUI.show_text_screen = function (self, is_victory)
	local game_mode_manager = Managers.state.game_mode
	local game_mode_key = game_mode_manager:game_mode_key()
	local level_key = game_mode_manager:level_key()
	local level_settings = LevelSettings[level_key]
	local use_end_screen_overlay = level_settings.use_end_screen_overlay
	local is_survival = game_mode_key == "survival"
	local banner_texture = (is_survival and "end_screen_banner_survival") or (is_victory and "end_screen_banner_victory") or "end_screen_banner_defeat"
	local banner_effect_color = (is_survival and {
		255,
		255,
		168,
		0
	}) or (is_victory and {
		255,
		60,
		161,
		220
	}) or {
		255,
		220,
		24,
		23
	}
	local use_overlay = is_victory and use_end_screen_overlay
	local widget = self.level_completed_widget
	widget.content.banner_texture = banner_texture
	widget.style.banner_effect_texture.color = banner_effect_color
	widget.content.is_survival = is_survival
	widget.content.use_overlay = use_overlay

	if use_overlay then
		widget.style.banner_effect_texture.color = {
			255,
			0,
			255,
			0
		}
	end

	if is_survival then
		local current_difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
		local difficulty_display_name = current_difficulty_settings.display_name
		widget.content.difficulty_title = Localize(difficulty_display_name)
		local mission_system = Managers.state.entity:system("mission_system")
		local active_missions, completed_missions = mission_system:get_missions()
		local mission_data = active_missions.survival_wave or fake_mission_data
		local completed_waves = mission_data.wave_completed
		local starting_wave = mission_data.starting_wave
		local presentation_wave = math.max(completed_waves - starting_wave, 0)
		widget.content.waves = tostring(presentation_wave)
		local completed_waves_time = mission_data.wave_completed_time
		local start_time = mission_data.start_time
		local time = completed_waves_time - start_time
		widget.content.time = string.format("%.2d:%.2d:%.2d", time / 3600, (time / 60) % 60, time % 60)
		widget.style.banner_effect_texture.offset[2] = 50
	else
		widget.style.banner_effect_texture.offset[2] = 0
	end

	self:fade_in_background()

	local params = {
		draw_flags = self.draw_flags,
		wwise_world = self.wwise_world
	}
	self.text_anim_id = self.ui_animator:start_animation("auto_display_text", {
		self.level_completed_widget
	}, self.scenegraph_definition, params)
end

EndScreenUI.show_continue_screen = function (self)
	self:fade_in_continue_vote()

	local voting_manager = self.voting_manager

	if voting_manager and voting_manager:vote_in_progress() then
		local active_vote_template = voting_manager:active_vote_template()
		self.voting_data = {
			title_text = Localize(active_vote_template.text),
			option_texts = {
				Localize(active_vote_template.vote_options[1].text),
				Localize(active_vote_template.vote_options[2].text)
			}
		}

		if active_vote_template.vote_options[3] then
			self.voting_data.option_texts[3] = Localize(active_vote_template.vote_options[3].text)
		end

		ShowCursorStack.push()
	end
end

EndScreenUI.update = function (self, dt)
	if DO_RELOAD then
		DO_RELOAD = false

		self:create_ui_elements()
	end

	local ui_animator = self.ui_animator

	ui_animator:update(dt)

	if self.text_anim_id and ui_animator:is_animation_completed(self.text_anim_id) then
		self.text_anim_id = nil

		if self.checkpoint_available then
			self:show_continue_screen()
		else
			self:on_complete()
		end
	end

	if self.continue_anim_id and ui_animator:is_animation_completed(self.continue_anim_id) and self.vote_completed then
		self.continue_anim_id = nil
		self.vote_completed = nil

		self:on_complete()
	end

	if self.draw_flags.draw_continue then
		self:update_continue_screen(dt)
	end

	self:draw(dt)
end

EndScreenUI.update_continue_screen = function (self, dt)
	local ui_scenegraph = self.ui_scenegraph
	local widget = self.level_completed_defeat_screen_widget
	local widget_content = widget.content
	local widget_style = widget.style
	local voting_data = self.voting_data

	if voting_data then
		local voting_manager = self.voting_manager

		if voting_manager:vote_in_progress() then
			local vote_time_left = voting_manager:vote_time_left()
			local title_text = voting_data.title_text
			local option_texts = voting_data.option_texts
			widget_content.title_text = title_text .. " " .. ((vote_time_left and tostring(math.round(vote_time_left, 0))) or "")

			if not self.voted then
				if self.defeat_button_1.content.button_hotspot.on_release then
					self:on_defeat_button_pressed(1)
				elseif self.defeat_button_2.content.button_hotspot.on_release then
					self:on_defeat_button_pressed(2)
				elseif self.defeat_button_3.content.button_hotspot.on_release then
					self:on_defeat_button_pressed(3)
				end
			end

			if self.voted then
				local number_of_votes, current_vote_results = voting_manager:number_of_votes()
				local number_of_button_1_votes = current_vote_results[1] or 0
				local number_of_button_2_votes = current_vote_results[2] or 0
				local number_of_button_3_votes = current_vote_results[3] or 0
				self.defeat_button_1.content.text_field = option_texts[1] .. " (" .. number_of_button_1_votes .. ")"
				self.defeat_button_2.content.text_field = option_texts[2] .. " (" .. number_of_button_2_votes .. ")"
				self.defeat_button_3.content.text_field = option_texts[2] .. " (" .. number_of_button_3_votes .. ")"
			else
				self.defeat_button_1.content.text_field = option_texts[1]
				self.defeat_button_2.content.text_field = option_texts[2]
				self.defeat_button_3.content.text_field = option_texts[3]
			end
		elseif not self.vote_completed then
			self.vote_completed = true
		end
	end
end

EndScreenUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("end_screen_ui")
	local draw_flags = self.draw_flags

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	if draw_flags.draw_background then
		UIRenderer.draw_widget(ui_renderer, self.background_rect_widget)
	end

	if draw_flags.draw_text then
		UIRenderer.draw_widget(ui_renderer, self.level_completed_widget)
	end

	if draw_flags.draw_continue then
		UIRenderer.draw_widget(ui_renderer, self.level_completed_defeat_screen_widget)
		UIRenderer.draw_widget(ui_renderer, self.defeat_button_1)
		UIRenderer.draw_widget(ui_renderer, self.defeat_button_2)

		local voting_manager = self.voting_manager

		if voting_manager:vote_in_progress() then
			local active_vote_template = voting_manager:active_vote_template()

			if active_vote_template.vote_options[3] then
				UIRenderer.draw_widget(ui_renderer, self.defeat_button_3)
			end
		end
	end

	UIRenderer.end_pass(ui_renderer)
end

EndScreenUI.on_defeat_button_pressed = function (self, index)
	local voting_manager = self.voting_manager

	if voting_manager:vote_in_progress() then
		Managers.state.voting:vote(index)

		self.voted = true
		self.defeat_button_1.content.disabled = true
		self.defeat_button_2.content.disabled = true
		self.defeat_button_3.content.disabled = true
		self.defeat_button_1.style.text.text_color = Colors.get_color_table_with_alpha("dark_gray", 255)
		self.defeat_button_2.style.text.text_color = Colors.get_color_table_with_alpha("dark_gray", 255)
		self.defeat_button_3.style.text.text_color = Colors.get_color_table_with_alpha("dark_gray", 255)
	end
end

EndScreenUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

return
