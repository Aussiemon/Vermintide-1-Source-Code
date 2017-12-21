local definitions = local_require("scripts/ui/views/level_filter_ui_definitions")
local widgets = definitions.widgets
local create_element = definitions.create_element
local scenegraph_definition = definitions.scenegraph_definition
local generic_input_actions = definitions.generic_input_actions
LevelFilterUI = class(LevelFilterUI)
LevelFilterUI.init = function (self, ingame_ui_context, map_save_data)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.ui_animations = {}
	local marked_levels_by_game_mode = map_save_data.marked_levels_by_game_mode

	if marked_levels_by_game_mode then
		self._marked_levels = marked_levels_by_game_mode
	else
		local marked_levels = {}

		for game_mode, settings in pairs(GameModeSettings) do
			if settings.playable then
				marked_levels[game_mode] = {}
			end
		end

		map_save_data.marked_levels_by_game_mode = marked_levels
		self._marked_levels = marked_levels
	end

	return 
end
LevelFilterUI.setup_level_list = function (self, levels, game_mode)
	self._levels = levels
	self._active_game_mode = game_mode

	self.create_ui_elements(self, levels)

	return 
end
LevelFilterUI.get_level_information = function (self, level_key)
	for index, level_information in ipairs(self._levels) do
		if level_information.level_key == level_key then
			return level_information
		end
	end

	return 
end
LevelFilterUI.create_ui_elements = function (self, levels)
	if not levels then
		return 
	end

	self._draw = true
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._bg_rect_widget = UIWidget.init(widgets.bg_rect)
	self._edge_widget = UIWidget.init(widgets.edge)
	self._title_text_widget = UIWidget.init(widgets.title_text)
	self._background_widget = UIWidget.init(widgets.background)
	self._background_2_widget = UIWidget.init(widgets.background_2)
	self._rect_frame_top_widget = UIWidget.init(widgets.rect_frame_top)
	self._rect_frame_bottom_widget = UIWidget.init(widgets.rect_frame_bottom)
	self._info_box_widget = UIWidget.init(widgets.info_box)
	self._info_box_text_widget = UIWidget.init(widgets.info_box_text)
	self._edge_button_bg_widget = UIWidget.init(widgets.edge_button_bg)
	self._edge_button_mg_widget = UIWidget.init(widgets.edge_button_mg)
	self._edge_button_fg_widget = UIWidget.init(widgets.edge_button_fg)
	self._edge_button_glow_widget = UIWidget.init(widgets.edge_button_glow)
	self._edge_button_bg_widget.style.texture_id.color[1] = 0
	self._edge_button_mg_widget.style.texture_id.color[1] = 0
	self._edge_button_fg_widget.style.texture_id.color[1] = 0
	self._edge_button_glow_widget.style.texture_id.color[1] = 0
	local elements_by_key = {}
	local elements = {}
	local level_list = {}
	local marked_levels = self._marked_levels[self._active_game_mode]

	for index, level_information in ipairs(levels) do
		local level_key = level_information.level_key
		local visibility = level_information.visibility
		local level_locked = visibility == "locked" or visibility == "dlc"
		local level_settings = LevelSettings[level_key]
		local map_settings = level_settings.map_settings
		local level_image = level_settings.level_image
		local act = level_settings.act
		local area = map_settings.area
		local key = act or area
		local marked = marked_levels[level_key]
		local display_name = nil

		if not act then
			local area_settings = AreaSettings[area]
			display_name = area_settings.display_name
		else
			display_name = act .. "_ls"
		end

		if not elements_by_key[key] then
			local element = UIWidget.init(create_element("element_pivot"))
			elements[#elements + 1] = element
			elements_by_key[key] = element
			level_list[key] = {}
		end

		local element = elements_by_key[key]
		local content = element.content
		content.title = (display_name and Localize(display_name)) or "n/a"

		if not act then
			content.use_divider = true
		end

		for i = 1, 4, 1 do
			local slot_key = "slot_" .. i

			if not content[slot_key] then
				content.locked[i] = level_locked
				content[slot_key] = level_image
				level_list[key][i] = level_key
				content.markers[i] = marked

				break
			end
		end
	end

	self._elements = elements
	self._elements_by_key = elements_by_key
	self._level_list = level_list

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self._align_elements(self)
	self.set_position_fraction(self, 0)

	self._animation_state = "closed"
	self._animate_button_pulse = false

	return 
end
LevelFilterUI.get_unmarked_levels = function (self)
	local return_list = {}
	local elements_by_key = self._elements_by_key
	local level_list = self._level_list

	for key, levels in pairs(level_list) do
		local element = elements_by_key[key]
		local content = element.content
		local markers = content.markers
		local locked = content.locked

		for level_index, level in ipairs(levels) do
			if not markers[level_index] and not locked[level_index] then
				return_list[#return_list + 1] = level
			end
		end
	end

	return return_list
end
LevelFilterUI.get_marked_levels = function (self)
	local return_list = {}
	local elements_by_key = self._elements_by_key
	local level_list = self._level_list

	for key, levels in pairs(level_list) do
		local element = elements_by_key[key]
		local content = element.content
		local markers = content.markers

		for level_index, level in ipairs(levels) do
			if markers[level_index] then
				return_list[#return_list + 1] = level
			end
		end
	end

	return return_list
end
LevelFilterUI.get_number_of_playable_levels = function (self)
	local elements_by_key = self._elements_by_key
	local level_list = self._level_list
	local counter = 0

	for key, levels in pairs(level_list) do
		local element = elements_by_key[key]
		local content = element.content
		local markers = content.markers
		local locked = content.locked

		for level_index, level in ipairs(levels) do
			if not markers[level_index] and not locked[level_index] then
				counter = counter + 1
			end
		end
	end

	return counter
end
LevelFilterUI._align_elements = function (self)
	local elements = self._elements
	local total_height = 0
	local height_spacing = 10
	local entry_height = 90

	for i = 1, #elements, 1 do
		local position_index = i - 1
		local element = elements[i]
		local content = element.content
		local use_divider = content.use_divider
		local height_offset = (use_divider and 40) or 0
		element.offset[2] = -(total_height + height_offset)
		total_height = total_height + entry_height + height_offset + height_spacing
	end

	self.ui_scenegraph.element_pivot.local_position[2] = total_height*0.5 - 50
	self.ui_scenegraph.bg_rect.size[2] = total_height + 10

	return 
end
LevelFilterUI.set_level_marked = function (self, level_key, marked)
	local elements_by_key = self._elements_by_key
	local level_list = self._level_list

	for key, levels in pairs(level_list) do
		local element = elements_by_key[key]
		local content = element.content
		local markers = content.markers
		local locked = content.locked

		for level_index, level in ipairs(levels) do
			if level == level_key then
				if locked[level_index] then
					return 
				end

				markers[level_index] = (marked ~= nil and marked) or not markers[level_index]
				self._marked_levels[self._active_game_mode][level_key] = markers[level_index]

				return markers[level_index]
			end
		end
	end

	return 
end
LevelFilterUI.level_marked = function (self, level_key)
	return self._marked_levels[self._active_game_mode][level_key]
end
LevelFilterUI.set_selected_level = function (self, level_key)
	local level_settings = level_key and LevelSettings[level_key]
	local level_image = level_settings and level_settings.level_image
	local elements_by_key = self._elements_by_key
	local level_list = self._level_list
	local selected = false

	for key, levels in pairs(level_list) do
		local element = elements_by_key[key]
		local content = element.content
		local markers = content.markers
		local locked = content.locked
		content.slot_selected = nil

		for level_index, level in ipairs(levels) do
			if level == level_key then
				content.slot_selected = level_image
				selected = true
			end
		end
	end

	if selected then
		local map_settings = level_settings and level_settings.map_settings

		if map_settings then
			local area = map_settings.area

			if area ~= self.selected_area then
				local area_settings = AreaSettings[area]
				local console_map_textures = area_settings.console_map_textures
				local texture = console_map_textures.selected

				self._set_background_texture(self, texture)
			end

			self.previous_area = self.selected_area
			self.selected_area = area
		end
	end

	return 
end
LevelFilterUI._set_background_texture = function (self, texture)
	local current_texture = self._background_2_widget.content.texture_id.texture_id
	self._background_2_widget.content.texture_id.texture_id = texture
	self._background_widget.content.texture_id.texture_id = current_texture

	return 
end
LevelFilterUI._update_button_pulse = function (self, dt, t)
	local fraction = (self._position_fraction or 0) - 1
	local time = t*5
	local anim_progress = math.sin(time)*0.5 + 0.5
	local widget = self._edge_button_glow_widget
	widget.style.texture_id.color[1] = fraction*(anim_progress*155 + 100)

	return 
end

local function animate(widget, time, delay_time, fade_state)
	local style = widget.style
	local target_style = style.texture_id or style.text

	if target_style then
		local target = (style.text and target_style.text_color) or target_style.color
		local target_index = 1
		local from = (fade_state ~= "in" or 0) and target[target_index]
		local to = (fade_state == "in" and 255) or 0

		table.clear(widget.animations)

		local animation = UIAnimation.init(UIAnimation.wait, delay_time, UIAnimation.function_by_time, target, target_index, from, to, time, math.easeCubic)

		UIWidget.animate(widget, animation)
	end

	return 
end

LevelFilterUI.animate_button_fade = function (self, time, delay_time, fade_state)
	animate(self._edge_button_bg_widget, time, delay_time, fade_state)
	animate(self._edge_button_fg_widget, time, delay_time, fade_state)

	if fade_state == "out" then
		animate(self._edge_button_glow_widget, time, delay_time, fade_state)
	end

	self._animate_button_pulse = false

	return 
end
LevelFilterUI.animation_done = function (self)
	self._animate_button_pulse = true

	return 
end
LevelFilterUI.set_background_animation_fraction = function (self, fraction, direction)
	if not self.previous_area or self.previous_area == self.selected_area then
		return 
	end

	if direction < 0 then
		self.set_widget_horizontal_fraction(self, self._background_2_widget, fraction, 2)
		self.set_widget_horizontal_fraction(self, self._background_widget, fraction - 1, 1)
	else
		self.set_widget_horizontal_fraction(self, self._background_2_widget, fraction, 1)
		self.set_widget_horizontal_fraction(self, self._background_widget, fraction - 1, 2)
	end

	return 
end
LevelFilterUI.set_widget_horizontal_fraction = function (self, widget, fraction, direction)
	local scenegraph_id = widget.scenegraph_id
	local content = widget.content
	local style = widget.style
	local uvs = content.texture_id.uvs
	local offset = style.texture_id.offset
	local default_width = scenegraph_definition[scenegraph_id].size[1]
	local new_width = default_width*fraction
	self.ui_scenegraph[scenegraph_id].size[1] = new_width

	if direction == 1 then
		uvs[1][1] = fraction - 1
		uvs[2][1] = 1
		offset[1] = 0
	else
		uvs[2][1] = fraction
		uvs[1][1] = 0
		offset[1] = default_width - new_width
	end

	return 
end
LevelFilterUI._update_animation = function (self, dt, t)
	if not self._animation_speed then
		return 
	end

	local state = self._animation_state

	if state == "opened" then
		return 
	end

	if state == "closed" then
		return 
	end

	local fraction = math.clamp(self._position_fraction + self._animation_speed*math.min(dt, 0.03333333333333333), 0, 1)

	self.set_position_fraction(self, fraction)

	if state == "open" and 1 <= self._position_fraction then
		self._animation_state = "opened"
	elseif state == "close" and self._position_fraction <= 0 then
		self._animation_state = "closed"
	end

	return 
end
LevelFilterUI.set_position_fraction = function (self, fraction)
	self._position_fraction = fraction
	local anim_fraction = math.easeCubic(fraction)
	local value = anim_fraction*500 + -500
	self.ui_scenegraph.background.local_position[1] = value
	self._edge_button_mg_widget.style.texture_id.color[1] = fraction*255

	return 
end
LevelFilterUI.visibility_fraction = function (self)
	return math.easeCubic(self._position_fraction)
end
LevelFilterUI.toggle_visibility = function (self)
	local state = self._animation_state

	if state == "open" or state == "opened" then
		self.close(self)
	else
		self.open(self)
	end

	return 
end
LevelFilterUI.open = function (self, speed)
	if self._animation_state ~= "opened" then
		self._animation_speed = speed or 5
		self._animation_state = "open"
	end

	return 
end
LevelFilterUI.close = function (self, speed)
	if self._animation_state ~= "closed" then
		self._animation_speed = -(speed or 5)
		self._animation_state = "close"
	end

	return 
end
LevelFilterUI.update = function (self, dt, t)
	if self._draw then
		self._update_animation(self, dt, t)

		if self._animate_button_pulse then
			self._update_button_pulse(self, dt, t)
		end

		self.draw(self, dt)
	end

	return 
end
LevelFilterUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "map_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self._bg_rect_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_widget)
	UIRenderer.draw_widget(ui_renderer, self._title_text_widget)
	UIRenderer.draw_widget(ui_renderer, self._background_widget)
	UIRenderer.draw_widget(ui_renderer, self._background_2_widget)
	UIRenderer.draw_widget(ui_renderer, self._rect_frame_top_widget)
	UIRenderer.draw_widget(ui_renderer, self._rect_frame_bottom_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_button_bg_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_button_mg_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_button_fg_widget)
	UIRenderer.draw_widget(ui_renderer, self._edge_button_glow_widget)

	for _, widget in ipairs(self._elements) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
LevelFilterUI.destroy = function (self)
	return 
end

return 
