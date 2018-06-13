local definitions = local_require("scripts/ui/views/mission_objective_ui_definitions")
MissionObjectiveUI = class(MissionObjectiveUI)

MissionObjectiveUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	local world = ingame_ui_context.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.saved_mission_objectives = {}
	self.completed_mission_objectives = {}
	self.current_mission_objective = nil
	self.index_count = 0

	self:create_ui_elements()
	rawset(_G, "mission_objective_ui", self)
end

local DO_RELOAD = true

MissionObjectiveUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.area_text_box = UIWidget.init(definitions.widget_definitions.area_text_box)
	self.current_mission_objective = nil

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	DO_RELOAD = false
end

MissionObjectiveUI.destroy = function (self)
	rawset(_G, "mission_objective_ui", nil)
end

MissionObjectiveUI.update = function (self, dt)
	if DO_RELOAD then
		self:create_ui_elements()
	end

	self:update_animations(dt)
	self:update_icon_position(dt)
	self:next_mission_objective(dt)
	self:draw(dt)
end

MissionObjectiveUI.add_mission_objective = function (self, mission_name, text)
	local saved_mission_objectives = self.saved_mission_objectives

	for _, mission_data in pairs(saved_mission_objectives) do
		if mission_data.mission_name == mission_name then
			return
		end
	end

	self.saved_mission_objectives[#self.saved_mission_objectives + 1] = {
		mission_name = mission_name,
		text = text
	}
end

MissionObjectiveUI.complete_mission = function (self, mission_name, remove_immediately)
	local index = nil

	for idx, mission_data in ipairs(self.saved_mission_objectives) do
		if mission_data.mission_name == mission_name then
			index = idx

			break
		end
	end

	if index then
		local mission_data = self.saved_mission_objectives[index]

		if mission_data then
			table.remove(self.saved_mission_objectives, index)

			self.completed_mission_objectives[mission_data.mission_name] = mission_data.text
			self.current_mission_objective = nil
		end
	end

	if remove_immediately then
		self.area_text_box_animation = nil
		self.mission_icon_left_animation = nil
		self.mission_icon_right_animation = nil
	end
end

MissionObjectiveUI.update_mission = function (self, mission_name, text)
	local index = nil

	for idx, mission_data in ipairs(self.saved_mission_objectives) do
		if mission_data.mission_name == mission_name then
			index = idx

			break
		end
	end

	if index then
		local mission_data = self.saved_mission_objectives[index]
		self.saved_mission_objectives[index].text = text

		if mission_data.mission_name == self.current_mission_objective then
			self.area_text_box_animation = nil
			local ui_settings = UISettings.mission_objective
			local widget = self.area_text_box
			widget.content.area_text_content = text
			self.area_text_box_animation = UIAnimation.init(UIAnimation.function_by_time, widget.style.area_text_style.text_color, 1, 0, 255, ui_settings.fade_time, math.easeInCubic, UIAnimation.wait, ui_settings.wait_time, UIAnimation.function_by_time, widget.style.area_text_style.text_color, 1, 255, 0, ui_settings.fade_time, math.easeInCubic)
			self.mission_icon_left_animation = UIAnimation.init(UIAnimation.function_by_time, widget.style.mission_icon_left.color, 1, 0, 255, ui_settings.fade_time, math.easeInCubic, UIAnimation.wait, ui_settings.wait_time, UIAnimation.function_by_time, widget.style.mission_icon_left.color, 1, 255, 0, ui_settings.fade_time, math.easeInCubic)
			self.mission_icon_right_animation = UIAnimation.init(UIAnimation.function_by_time, widget.style.mission_icon_right.color, 1, 0, 255, ui_settings.fade_time, math.easeInCubic, UIAnimation.wait, ui_settings.wait_time, UIAnimation.function_by_time, widget.style.mission_icon_right.color, 1, 255, 0, ui_settings.fade_time, math.easeInCubic)
		end
	end
end

MissionObjectiveUI.next_mission_objective = function (self, dt)
	if not self.current_mission_objective and #self.saved_mission_objectives > 0 then
		local current_mission_data = self.saved_mission_objectives[1]
		self.area_text_box_animation = nil
		local ui_settings = UISettings.mission_objective
		local widget = self.area_text_box
		widget.content.area_text_content = current_mission_data.text
		self.area_text_box_animation = UIAnimation.init(UIAnimation.function_by_time, widget.style.area_text_style.text_color, 1, 0, 255, ui_settings.fade_time, math.easeInCubic, UIAnimation.wait, ui_settings.wait_time, UIAnimation.function_by_time, widget.style.area_text_style.text_color, 1, 255, 0, ui_settings.fade_time, math.easeInCubic)
		self.mission_icon_left_animation = UIAnimation.init(UIAnimation.function_by_time, widget.style.mission_icon_left.color, 1, 0, 255, ui_settings.fade_time, math.easeInCubic, UIAnimation.wait, ui_settings.wait_time, UIAnimation.function_by_time, widget.style.mission_icon_left.color, 1, 255, 0, ui_settings.fade_time, math.easeInCubic)
		self.mission_icon_right_animation = UIAnimation.init(UIAnimation.function_by_time, widget.style.mission_icon_right.color, 1, 0, 255, ui_settings.fade_time, math.easeInCubic, UIAnimation.wait, ui_settings.wait_time, UIAnimation.function_by_time, widget.style.mission_icon_right.color, 1, 255, 0, ui_settings.fade_time, math.easeInCubic)
		self.current_mission_objective = current_mission_data.mission_name
	end
end

MissionObjectiveUI.update_animations = function (self, dt)
	local area_text_box_animation = self.area_text_box_animation

	if area_text_box_animation then
		UIAnimation.update(area_text_box_animation, dt)

		if UIAnimation.completed(area_text_box_animation) then
			self.area_text_box_animation = nil
		end
	end

	local mission_icon_left_animation = self.mission_icon_left_animation

	if mission_icon_left_animation then
		UIAnimation.update(mission_icon_left_animation, dt)

		if UIAnimation.completed(mission_icon_left_animation) then
			self.mission_icon_left_animation = nil
		end
	end

	local mission_icon_right_animation = self.mission_icon_right_animation

	if mission_icon_right_animation then
		UIAnimation.update(mission_icon_right_animation, dt)

		if UIAnimation.completed(mission_icon_right_animation) then
			self.mission_icon_right_animation = nil
		end
	end
end

MissionObjectiveUI.update_icon_position = function (self, dt)
	local content = self.area_text_box.content
	local style = self.area_text_box.style
	local ui_renderer = self.ui_renderer
	local font, scaled_font_size = UIFontByResolution(style.area_text_style)
	local font, font_size, font_material = unpack(font)
	local width, height = UIRenderer.text_size(ui_renderer, content.area_text_content, font, scaled_font_size)
	local ui_scenegraph = self.ui_scenegraph
	ui_scenegraph.mission_icon_left.position[1] = -width * 0.5 - ui_scenegraph.mission_icon_left.size[1] * 0.5
	ui_scenegraph.mission_icon_right.position[1] = width * 0.5 + ui_scenegraph.mission_icon_right.size[1] * 0.5
end

MissionObjectiveUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.area_text_box)
	UIRenderer.end_pass(ui_renderer)
end

return
