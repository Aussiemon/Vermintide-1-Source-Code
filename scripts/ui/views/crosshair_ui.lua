local definitions = local_require("scripts/ui/views/crosshair_ui_definitions")
CrosshairUI = class(CrosshairUI)
local CROSSHAIR_STYLE_FUNC_LOOKUP = {
	default = "draw_default_style_crosshair",
	circle = "draw_circle_style_crosshair",
	dot = "draw_dot_style_crosshair"
}
local CROSSHAIR_ENABLED_STYLES_LOOKUP = {
	default = true,
	circle = true,
	dot = true
}
CrosshairUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.world_manager = ingame_ui_context.world_manager
	self.level_world = self.world_manager:world("level_world")
	self.local_player = Managers.player:local_player()

	self.create_ui_elements(self)
	self.set_enabled_crosshair_styles(self, Application.user_setting("enabled_crosshairs"))
	rawset(_G, "crosshair_ui", self)

	self.t = 0
	self.tobii_crosshair_position = {
		0,
		0
	}
	self.tobii_time_since_teleport = 0

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
	self.update_crosshair_position(self, player_unit, dt)
	self.update_hit_markers(self, dt)
	self.update_spread(self, dt, equipment)
	self.draw(self, dt)

	return 
end
CrosshairUI.set_enabled_crosshair_styles = function (self, enabled_style)
	if enabled_style == "melee" then
		CROSSHAIR_ENABLED_STYLES_LOOKUP.dot = true
		CROSSHAIR_ENABLED_STYLES_LOOKUP.default = false
		CROSSHAIR_ENABLED_STYLES_LOOKUP.circle = false
	elseif enabled_style == "ranged" then
		CROSSHAIR_ENABLED_STYLES_LOOKUP.dot = false
		CROSSHAIR_ENABLED_STYLES_LOOKUP.default = true
		CROSSHAIR_ENABLED_STYLES_LOOKUP.circle = true
	elseif enabled_style == "none" then
		CROSSHAIR_ENABLED_STYLES_LOOKUP.dot = false
		CROSSHAIR_ENABLED_STYLES_LOOKUP.default = false
		CROSSHAIR_ENABLED_STYLES_LOOKUP.circle = false
	else
		CROSSHAIR_ENABLED_STYLES_LOOKUP.dot = true
		CROSSHAIR_ENABLED_STYLES_LOOKUP.default = true
		CROSSHAIR_ENABLED_STYLES_LOOKUP.circle = true
	end

	return 
end
local TOBII_X_THRESHHOLD = 0.05
local TOBII_Y_THRESHHOLD = 0.08888888888888889
local DELTA_SMOOTH = 0.1
local HZ_SCALE = 0.03333333333333333
CrosshairUI.update_crosshair_position = function (self, player_unit, dt)
	Profiler.start("update_crosshair_position")

	local res_scale = RESOLUTION_LOOKUP.scale
	local inv_res_scale = RESOLUTION_LOOKUP.inv_scale
	local res_w = RESOLUTION_LOOKUP.res_w * inv_res_scale
	local res_h = RESOLUTION_LOOKUP.res_h * inv_res_scale
	local x_offset = (not UISettings.use_hud_screen_fit or 0) and (res_w - 1920) * 0.5
	local is_enabled = rawget(_G, "Tobii") and Application.user_setting("tobii_eyetracking")
	is_enabled = is_enabled and Tobii.device_status() == Tobii.DEVICE_TRACKING
	is_enabled = is_enabled and Tobii.user_presence() == Tobii.USER_PRESENT
	local extended_view_enabled = Application.user_setting("tobii_extended_view")
	local position_in_screen = nil

	if is_enabled then
		local crosshair_position = self.tobii_crosshair_position
		local gaze_point_x, gaze_point_y = Tobii.get_gaze_point()
		local dx = gaze_point_x - crosshair_position[1]
		local dy = gaze_point_y - crosshair_position[2]

		if TOBII_X_THRESHHOLD < dx or dx < -TOBII_X_THRESHHOLD or TOBII_Y_THRESHHOLD < dy or dy < -TOBII_Y_THRESHHOLD then
			crosshair_position[1] = gaze_point_x
			crosshair_position[2] = gaze_point_y
			self.tobii_time_since_teleport = 0
		else
			local time_factor = dt / HZ_SCALE
			crosshair_position[1] = crosshair_position[1] + dx * DELTA_SMOOTH * time_factor
			crosshair_position[2] = crosshair_position[2] + dy * DELTA_SMOOTH * time_factor

			if self.tobii_time_since_teleport < 0.1 then
				self.tobii_time_since_teleport = self.tobii_time_since_teleport + dt
				crosshair_position[1] = gaze_point_x
				crosshair_position[2] = gaze_point_y
			end
		end

		local eyetracking_extension = ScriptUnit.extension(player_unit, "eyetracking_system")

		eyetracking_extension.set_smoothed_gaze(eyetracking_extension, crosshair_position[1], crosshair_position[2])

		if extended_view_enabled then
			local player = Managers.player:owner(player_unit)
			local viewport_name = player.viewport_name
			local viewport = ScriptWorld.viewport(self.level_world, viewport_name)
			local camera = ScriptViewport.camera(viewport)
			local world_pos = eyetracking_extension.get_forward_rayhit(eyetracking_extension)

			if world_pos then
				local x_scale = res_w / RESOLUTION_LOOKUP.res_w
				local y_scale = res_h / RESOLUTION_LOOKUP.res_h
				local depth = nil
				position_in_screen, depth = Camera.world_to_screen(camera, world_pos)
				local x_offset_scale = 1

				if UISettings.use_hud_screen_fit then
					x_offset_scale = (res_w * UIResolutionWidthFragments()) / res_scale
				end

				position_in_screen[1] = position_in_screen[1] * x_scale - x_offset * x_offset_scale - definitions.max_spread_yaw * 0.5
				position_in_screen[2] = position_in_screen[2] * y_scale - definitions.max_spread_pitch * 0.5
				position_in_screen[3] = 50
			end
		end
	end

	position_in_screen = position_in_screen or Vector3(res_w / 2 - x_offset - definitions.max_spread_yaw * 0.5, res_h / 2 - definitions.max_spread_pitch * 0.5, 50)

	UISceneGraph.set_local_position(self.ui_scenegraph, "crosshair_root", position_in_screen)
	Profiler.stop()

	return 
end
local GAZE_FOLLOWING_CROSSHAIRS = {}
CrosshairUI.update_crosshair_style = function (self, equipment)
	Profiler.start("update_crosshair_style")

	local wielded_item_data = equipment.wielded
	local item_template = BackendUtils.get_item_template(wielded_item_data)
	local crosshair_style = item_template.crosshair_style
	local weapon_unit = equipment.right_hand_wielded_unit or equipment.left_hand_wielded_unit
	local fire_at_gaze_setting = item_template.fire_at_gaze_setting

	if Unit.alive(weapon_unit) then
		local weapon_extension = ScriptUnit.extension(weapon_unit, "weapon_system")

		if weapon_extension.has_current_action(weapon_extension) then
			local action_settings = weapon_extension.get_current_action_settings(weapon_extension)

			if action_settings.crosshair_style then
				crosshair_style = action_settings.crosshair_style
			end

			if action_settings.fire_at_gaze_setting ~= nil then
				fire_at_gaze_setting = action_settings.fire_at_gaze_setting
			end
		end
	end

	if fire_at_gaze_setting then
		local is_tobii_enabled = rawget(_G, "Tobii") and Application.user_setting("tobii_eyetracking")
		is_tobii_enabled = is_tobii_enabled and Tobii.device_status() == Tobii.DEVICE_TRACKING
		is_tobii_enabled = is_tobii_enabled and Tobii.user_presence() == Tobii.USER_PRESENT

		if is_tobii_enabled and Application.user_setting(fire_at_gaze_setting) then
			crosshair_style = "dot"
		end
	end

	self.crosshair_style = crosshair_style

	Profiler.stop("update_crosshair_style")

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

	Profiler.stop("update_hit_markers")

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
	local pitch_percentage = pitch / maximum_pitch
	local yaw_percentage = yaw / maximum_yaw
	local pitch_offset = math.lerp(0, definitions.max_spread_pitch, pitch_percentage)
	local yaw_offset = math.lerp(0, definitions.max_spread_yaw, yaw_percentage)
	self.crosshair_up.style.offset[2] = pitch_offset
	self.crosshair_down.style.offset[2] = -pitch_offset
	self.crosshair_left.style.offset[1] = -yaw_offset
	self.crosshair_right.style.offset[1] = yaw_offset

	Profiler.stop("update_spread")

	return 
end
CrosshairUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	local crosshair_style = self.crosshair_style

	if CROSSHAIR_ENABLED_STYLES_LOOKUP[crosshair_style] then
		local draw_func_name = CROSSHAIR_STYLE_FUNC_LOOKUP[crosshair_style]

		self[draw_func_name](self, ui_renderer)
	end

	Profiler.start("draw widgets")

	local hit_markers = self.hit_markers
	local hit_markers_n = self.hit_markers_n

	for i = 1, hit_markers_n, 1 do
		local hit_marker = hit_markers[i]

		UIRenderer.draw_widget(ui_renderer, hit_marker)
	end

	Profiler.stop("draw widgets")
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
