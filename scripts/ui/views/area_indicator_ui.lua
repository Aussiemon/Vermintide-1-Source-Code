local definitions = local_require("scripts/ui/views/area_indicator_ui_definitions")
AreaIndicatorUI = class(AreaIndicatorUI)
AreaIndicatorUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	local world = ingame_ui_context.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)

	self.create_ui_elements(self)
	rawset(_G, "area_indicator_ui", self)

	return 
end
AreaIndicatorUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.area_text_box = UIWidget.init(definitions.widget_definitions.area_text_box)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
AreaIndicatorUI.destroy = function (self)
	rawset(_G, "area_indicator_ui", nil)

	return 
end
AreaIndicatorUI.update = function (self, dt)
	local player_manager = Managers.player
	local local_player = player_manager.local_player(player_manager)
	local player_unit = local_player and local_player.player_unit

	if Unit.alive(player_unit) then
		local player_hud_extension = ScriptUnit.extension(player_unit, "hud_system")
		local saved_location = self.saved_location
		local current_location = player_hud_extension.current_location

		if current_location ~= nil and current_location ~= saved_location then
			self.saved_location = current_location
			local ui_settings = UISettings.area_indicator
			local widget = self.area_text_box
			widget.content.area_text_content = current_location
			self.area_text_box_animation = UIAnimation.init(UIAnimation.function_by_time, widget.style.area_text_style.text_color, 1, 0, 255, ui_settings.fade_time, math.easeInCubic, UIAnimation.wait, ui_settings.wait_time, UIAnimation.function_by_time, widget.style.area_text_style.text_color, 1, 255, 0, ui_settings.fade_time, math.easeInCubic)

			WwiseWorld.trigger_event(self.wwise_world, "hud_area_indicator")
		end
	end

	if self.area_text_box_animation == nil then
		return 
	end

	self.update_animations(self, dt)
	self.draw(self, dt)

	return 
end
AreaIndicatorUI.update_animations = function (self, dt)
	local area_text_box_animation = self.area_text_box_animation

	if area_text_box_animation then
		UIAnimation.update(area_text_box_animation, dt)

		if UIAnimation.completed(area_text_box_animation) then
			self.area_text_box_animation = nil
		end
	end

	return 
end
AreaIndicatorUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.area_text_box)
	UIRenderer.end_pass(ui_renderer)

	return 
end

return 
