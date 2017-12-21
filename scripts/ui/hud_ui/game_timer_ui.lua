local definitions = local_require("scripts/ui/hud_ui/game_timer_ui_definitions")
GameTimerUI = class(GameTimerUI)
GameTimerUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.cleanui = ingame_ui_context.cleanui
	self.render_settings = {
		alpha_multiplier = 1
	}

	self.create_ui_elements(self)

	local position = {
		810,
		1005
	}
	local size = {
		300,
		150
	}
	self.cleanui_data = {}

	UICleanUI.register_area(self.cleanui, "game_timer_ui", self.cleanui_data, position, size)
	rawset(_G, "game_timer_ui", self)

	return 
end
GameTimerUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.timer_text_box = UIWidget.init(definitions.widget_definitions.timer_text_box)
	self.timer_background = UIWidget.init(definitions.widget_definitions.timer_background)
	self.timer_widget_content = self.timer_text_box.content

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
GameTimerUI.destroy = function (self)
	self.set_visible(self, false)
	rawset(_G, "game_timer_ui", nil)

	return 
end
GameTimerUI.set_visible = function (self, visible)
	UIRenderer.set_element_visible(self.ui_renderer, self.timer_background.element, visible)

	return 
end
GameTimerUI.update = function (self, dt, survival_mission_data)
	local resolution_modified = RESOLUTION_LOOKUP.modified
	local is_dirty = false

	if resolution_modified or self.cleanui_data.is_dirty then
		is_dirty = true
		self.timer_background.element.dirty = true
	end

	local start_time = survival_mission_data.start_time
	local current_network_time = Managers.state.network:network_time()
	local time = current_network_time - start_time

	self.set_time(self, time)
	self.draw(self, dt)

	return 
end
GameTimerUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")
	local render_settings = self.render_settings

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, render_settings)

	local alpha = UICleanUI.get_alpha(self.cleanui, self.cleanui_data)
	render_settings.alpha_multiplier = alpha

	UIRenderer.draw_widget(ui_renderer, self.timer_text_box)
	UIRenderer.draw_widget(ui_renderer, self.timer_background)

	render_settings.alpha_multiplier = 1

	UIRenderer.end_pass(ui_renderer)

	return 
end
GameTimerUI.set_time = function (self, time)
	local floor = math.floor
	local timer_text = string.format("%.2d:%.2d:%.2d", floor(time/3600), floor(time/60)%60, floor(time)%60)
	self.timer_widget_content.timer_text = timer_text

	return 
end

return 
