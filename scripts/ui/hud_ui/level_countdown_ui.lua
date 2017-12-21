local definitions = local_require("scripts/ui/hud_ui/level_countdown_ui_definitions")
LevelCountdownUI = class(LevelCountdownUI)
LevelCountdownUI.init = function (self, ingame_ui_context)
	self.level_transition_handler = ingame_ui_context.level_transition_handler
	self.network_event_delegate = ingame_ui_context.network_event_delegate
	self.camera_manager = ingame_ui_context.camera_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.is_in_inn = ingame_ui_context.is_in_inn
	self.is_server = ingame_ui_context.is_server
	self.world_manager = ingame_ui_context.world_manager
	self.input_manager = ingame_ui_context.input_manager
	self.matchmaking_manager = Managers.matchmaking
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)

	self.create_ui_elements(self)
	self.network_event_delegate:register(self, "rpc_start_game_countdown", "rpc_stop_enter_game_countdown")

	self.colors = {
		white = Colors.get_table("white"),
		cheeseburger = Colors.get_table("cheeseburger")
	}

	return 
end
LevelCountdownUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.countdown_widget = UIWidget.init(definitions.widgets.fullscreen_countdown)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
LevelCountdownUI.update = function (self, dt)
	local enter_game = self.enter_game
	local ui_suspended = self.ingame_ui.menu_suspended

	if ui_suspended and not enter_game then
		return 
	end

	if enter_game then
		if self.enter_game_started then
			self.enter_game_started = nil
		end

		self.update_enter_game_counter(self, dt)
		self.draw(self, dt)
	end

	return 
end
LevelCountdownUI.is_enter_game = function (self)
	return self.enter_game
end
LevelCountdownUI.draw = function (self, dt)
	self.anim_t = math.max(self.anim_t + dt)
	local bg_color = self.countdown_widget.style.background_rect.color
	bg_color[0] = math.lerp(bg_color[1], 180, self.anim_t)
	local input_service = self.input_manager:get_service("ingame_menu")
	local ui_renderer = self.ui_renderer

	UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.countdown_widget)

	local w = RESOLUTION_LOOKUP.res_w
	local h = RESOLUTION_LOOKUP.res_h
	local inverse_scale = RESOLUTION_LOOKUP.inv_scale

	UIRenderer.draw_texture(ui_renderer, "gradient_dice_game_reward", Vector3(0, 0, UILayer.controller_description), Vector2(w*inverse_scale, h*inverse_scale))
	UIRenderer.end_pass(ui_renderer)

	return 
end
LevelCountdownUI.rpc_start_game_countdown = function (self, sender)
	self.ingame_ui:handle_transition("close_active")
	self.start_enter_game_counter(self)

	return 
end
LevelCountdownUI.rpc_stop_enter_game_countdown = function (self, sender)
	self.ingame_ui:unsuspend_active_view()
	self.stop_enter_game_countdown(self)

	return 
end
LevelCountdownUI.start_enter_game_counter = function (self)
	self.enter_game_started = true
	self.enter_game = true
	self.enter_game_timer = 0
	self.anim_t = 0
	self.total_start_game_time = MatchmakingSettings.START_GAME_TIME
	self.last_timer_value = self.total_start_game_time
	local widget = self.countdown_widget
	local widget_content = widget.content
	widget_content.timer_text = self.total_start_game_time
	local input_manager = self.input_manager

	input_manager.block_device_except_service(input_manager, nil, "keyboard", 1)
	input_manager.block_device_except_service(input_manager, nil, "mouse", 1)
	input_manager.block_device_except_service(input_manager, nil, "gamepad", 1)
	self.play_sound(self, "Play_hud_matchmaking_countdown_enter")

	return 
end
LevelCountdownUI.stop_enter_game_countdown = function (self)
	self.enter_game = nil
	self.enter_game_timer = nil
	self.last_timer_value = nil
	local input_manager = self.input_manager

	if not Managers.chat:chat_is_focused() then
		input_manager.device_unblock_all_services(input_manager, "keyboard", 1)
		input_manager.device_unblock_all_services(input_manager, "mouse", 1)
		input_manager.device_unblock_all_services(input_manager, "gamepad", 1)
	end

	return 
end
LevelCountdownUI.update_enter_game_counter = function (self, dt)
	local time = self.enter_game_timer

	if not time then
		return 
	end

	local total_time = self.total_start_game_time
	local widget = self.countdown_widget
	local widget_content = widget.content
	local widget_style = widget.style
	local colors = self.colors
	time = time + dt

	if time <= total_time then
		local new_timer_value = math.round(total_time - time)

		if new_timer_value ~= self.last_timer_value then
			if new_timer_value ~= 0 then
				self.play_sound(self, "Play_hud_matchmaking_countdown")

				widget_content.timer_text = new_timer_value
				self.color_timer = 0
			else
				self.play_sound(self, "Play_hud_matchmaking_countdown_final")

				widget_content.info_text = ""
				widget_content.timer_text = Localize("game_starts_prepare")
			end

			self.last_timer_value = new_timer_value

			Colors.lerp_color_tables(colors.white, colors.cheeseburger, 0, widget_style.timer_text.text_color)
		else
			local color_timer = self.color_timer

			if color_timer then
				local total_color_time = 0.5
				color_timer = math.min(color_timer + dt, total_color_time)
				local color_progress = color_timer/total_color_time
				self.color_timer = color_timer

				Colors.lerp_color_tables(colors.white, colors.cheeseburger, color_progress, widget_style.timer_text.text_color)
			end
		end
	end

	if total_time <= time then
		self.matchmaking_manager:countdown_completed()

		time = nil
	end

	self.enter_game_timer = time

	return 
end
LevelCountdownUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
LevelCountdownUI.destroy = function (self)
	self.network_event_delegate:unregister(self)
	self.stop_enter_game_countdown(self)

	return 
end

return 
