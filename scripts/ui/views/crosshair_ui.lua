local definitions = local_require("scripts/ui/views/crosshair_ui_definitions")
CrosshairUI = class(CrosshairUI)
local CROSSHAIR_STYLE_FUNC_LOOKUP = {
	default = "draw_default_style_crosshair",
	circle = "draw_circle_style_crosshair",
	dot = "draw_dot_style_crosshair"
}
CrosshairUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.local_player = Managers.player:local_player()

	self.create_ui_elements(self)
	rawset(_G, "crosshair_ui", self)

	self.t = 0

	return 
end
CrosshairUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.crosshair_dot = UIWidget.init(definitions.widget_definitions.crosshair_dot)
	self.crosshair_up = UIWidget.init(definitions.widget_definitions.crosshair_up)
	self.crosshair_down = UIWidget.init(definitions.widget_definitions.crosshair_down)
	self.crosshair_left = UIWidget.init(definitions.widget_definitions.crosshair_left)
	self.crosshair_right = UIWidget.init(definitions.widget_definitions.crosshair_right)
	self.crosshair_circle = UIWidget.init(definitions.widget_definitions.crosshair_circle)
	local hit_markers = {}
	local hit_markers_n = 4

	for i = 1, hit_markers_n, 1 do
		local widget_definition_name = "crosshair_hit_" .. i
		hit_markers[i] = UIWidget.init(definitions.widget_definitions[widget_definition_name])
	end

	self.hit_markers = hit_markers
	self.hit_markers_n = hit_markers_n
	self.hit_marker_animations = {}

	return 
end
CrosshairUI.destroy = function (self)
	rawset(_G, "crosshair_ui", nil)

	return 
end
CrosshairUI.update = function (self, dt)
	local player_unit = self.local_player.player_unit
	local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
	local equipment = inventory_extension.equipment(inventory_extension)

	self.update_crosshair_style(self, equipment)
	self.update_hit_markers(self, dt)
	self.update_spread(self, dt, equipment)
	self.draw(self, dt)

	return 
end
CrosshairUI.update_crosshair_style = function (self, equipment)
	Profiler.start("update_crosshair_style")

	local wielded_item_data = equipment.wielded
	local item_template = BackendUtils.get_item_template(wielded_item_data)
	local crosshair_style = item_template.crosshair_style
	local weapon_unit = equipment.right_hand_wielded_unit or equipment.left_hand_wielded_unit

	if Unit.alive(weapon_unit) then
		local weapon_extension = ScriptUnit.extension(weapon_unit, "weapon_system")

		if weapon_extension.has_current_action(weapon_extension) then
			local action_settings = weapon_extension.get_current_action_settings(weapon_extension)

			if action_settings.crosshair_style then
				crosshair_style = action_settings.crosshair_style
			end
		end
	end

	self.crosshair_style = crosshair_style

	Profiler.stop()

	return 
end
CrosshairUI.update_hit_markers = function (self, dt)
	Profiler.start("update_hit_markers")

	local hit_markers = self.hit_markers
	local hit_markers_n = self.hit_markers_n
	local hit_marker_animations = self.hit_marker_animations
	local player_unit = self.local_player.player_unit
	local hud_extension = ScriptUnit.extension(player_unit, "hud_system")

	if hud_extension.hit_enemy then
		hud_extension.hit_enemy = nil

		for i = 1, hit_markers_n, 1 do
			local hit_marker = hit_markers[i]
			hit_marker_animations[i] = UIAnimation.init(UIAnimation.function_by_time, hit_marker.style.rotating_texture.color, 1, 255, 0, UISettings.crosshair.hit_marker_fade, math.easeInCubic)
		end
	end

	if hit_marker_animations[1] then
		for i = 1, hit_markers_n, 1 do
			local animation = hit_marker_animations[i]

			UIAnimation.update(animation, dt)
		end

		if UIAnimation.completed(hit_marker_animations[1]) then
			for i = 1, hit_markers_n, 1 do
				hit_marker_animations[i] = nil
			end
		end
	end

	Profiler.stop()

	return 
end
CrosshairUI.update_spread = function (self, dt, equipment)
	Profiler.start("update_spread")

	local wielded_item_data = equipment.wielded
	local item_template = BackendUtils.get_item_template(wielded_item_data)
	local pitch = 0
	local yaw = 0

	if item_template.default_spread_template then
		local weapon_unit = equipment.right_hand_wielded_unit or equipment.left_hand_wielded_unit

		if weapon_unit and ScriptUnit.has_extension(weapon_unit, "spread_system") then
			local spread_extension = ScriptUnit.extension(weapon_unit, "spread_system")
			pitch, yaw = spread_extension.get_current_pitch_and_yaw(spread_extension)
		end
	end

	local maximum_pitch = SpreadTemplates.maximum_pitch
	local maximum_yaw = SpreadTemplates.maximum_yaw
	local pitch_percentage = pitch/maximum_pitch
	local yaw_percentage = yaw/maximum_yaw
	local pitch_offset = math.lerp(0, definitions.max_spread_pitch, pitch_percentage)
	local yaw_offset = math.lerp(0, definitions.max_spread_yaw, yaw_percentage)
	self.crosshair_up.style.offset[2] = pitch_offset
	self.crosshair_down.style.offset[2] = -pitch_offset
	self.crosshair_left.style.offset[1] = -yaw_offset
	self.crosshair_right.style.offset[1] = yaw_offset

	Profiler.stop()

	return 
end
CrosshairUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	local crosshair_style = self.crosshair_style
	local draw_func_name = CROSSHAIR_STYLE_FUNC_LOOKUP[crosshair_style]

	self[draw_func_name](self, ui_renderer)
	Profiler.start("draw widgets")

	local hit_markers = self.hit_markers
	local hit_markers_n = self.hit_markers_n

	for i = 1, hit_markers_n, 1 do
		local hit_marker = hit_markers[i]

		UIRenderer.draw_widget(ui_renderer, hit_marker)
	end

	Profiler.stop()
	UIRenderer.end_pass(ui_renderer)

	return 
end
CrosshairUI.draw_default_style_crosshair = function (self, ui_renderer)
	UIRenderer.draw_widget(ui_renderer, self.crosshair_dot)
	UIRenderer.draw_widget(ui_renderer, self.crosshair_up)
	UIRenderer.draw_widget(ui_renderer, self.crosshair_down)
	UIRenderer.draw_widget(ui_renderer, self.crosshair_left)
	UIRenderer.draw_widget(ui_renderer, self.crosshair_right)

	return 
end
CrosshairUI.draw_dot_style_crosshair = function (self, ui_renderer)
	UIRenderer.draw_widget(ui_renderer, self.crosshair_dot)

	return 
end
CrosshairUI.draw_circle_style_crosshair = function (self, ui_renderer)
	UIRenderer.draw_widget(ui_renderer, self.crosshair_circle)

	return 
end

return 
