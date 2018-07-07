require("scripts/ui/views/map_view_helper")

local definitions = local_require("scripts/ui/views/map_view_area_handler_definitions")
local game_mode_level_area_textures = definitions.game_mode_level_area_textures
MapViewAreaHandler = class(MapViewAreaHandler)
local platform = PLATFORM

local function sort_level_information_list(a, b)
	local a_level_key = a.level_key
	local b_level_key = b.level_key

	if a_level_key == "any" then
		return true
	elseif b_level_key == "any" then
		return false
	end

	local a_area = a.area
	local b_area = b.area
	local a_is_area = a.is_area
	local b_is_area = b.is_area
	local level_settings = LevelSettings
	local area_settings = AreaSettings
	local a_settings = (a_is_area and area_settings[a_area]) or level_settings[a_level_key].map_settings
	local b_settings = (b_is_area and area_settings[b_area]) or level_settings[b_level_key].map_settings

	if platform == "win32" then
		local a_order = a_settings.sorting or 99
		local b_order = b_settings.sorting or 99

		return a_order < b_order
	else
		local a_order = a_settings.console_sorting or 99
		local b_order = b_settings.console_sorting or 99

		return a_order < b_order
	end
end

local function sort_level_list(a, b)
	local a_level_key = a.level_key
	local b_level_key = b.level_key

	if a_level_key == "any" then
		return true
	elseif b_level_key == "any" then
		return false
	end

	local a_area = a.level_information.area
	local b_area = b.level_information.area
	local a_is_area = a.level_information.is_area
	local b_is_area = b.level_information.is_area
	local level_settings = LevelSettings
	local area_settings = AreaSettings
	local a_settings = (a_is_area and area_settings[a_area]) or level_settings[a_level_key].map_settings
	local b_settings = (b_is_area and area_settings[b_area]) or level_settings[b_level_key].map_settings

	if platform == "win32" then
		local a_order = a_settings.sorting or 99
		local b_order = b_settings.sorting or 99

		return a_order < b_order
	else
		local a_order = a_settings.console_sorting or 99
		local b_order = b_settings.console_sorting or 99

		return a_order < b_order
	end
end

MapViewAreaHandler.init = function (self, ingame_ui_context, map_save_data, player_stats_id)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.statistics_db = ingame_ui_context.statistics_db
	self.player_stats_id = player_stats_id
	self.only_release = GameSettingsDevelopment.release_levels_only
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.world = ingame_ui_context.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(self.world)
	self.map_view_helper = MapViewHelper:new(self.statistics_db, player_stats_id)
	self._map_save_data = map_save_data

	self:_create_ui_elements()
	self:_setup_level_lists()
end

MapViewAreaHandler._create_ui_elements = function (self)
	self.ui_animations = {}
	local create_level_widget = definitions.create_level_widget
	local create_area_widget = definitions.create_area_widget
	local level_widgets = {}

	for i = 1, 20, 1 do
		level_widgets[i] = create_level_widget(i)
	end

	self._level_widgets = level_widgets
	self.map_area_widget = UIWidget.init(definitions.widgets.area_map)
	self.map_area_widget.offset = {
		0,
		0.5,
		-3
	}
	self.back_button_widget = UIWidget.init(definitions.widgets.back_button)
	self.map_overlay_widget = UIWidget.init(definitions.widgets.map_overlay)
	self.map_overlay_widget.style.texture_id.color = {
		0,
		0,
		0,
		0
	}
	local area_widgets = {}

	if PLATFORM == "win32" then
		for area_key, settings in pairs(AreaSettings) do
			if area_key ~= "world" then
				area_widgets[area_key] = create_area_widget(area_key)
			end
		end
	end

	self._area_widgets = area_widgets
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self._scenegraph_definition = definitions.scenegraph_definition
end

MapViewAreaHandler._validate_level_data = function (self, level_key, level_data)
	if type(level_data) == "table" then
		local debug_level = string.match(level_data.package_name, "resource_packages/levels/debug/")

		if (not self.only_release or not debug_level) and level_key ~= "inn_level" and table.find(UnlockableLevels, level_key) then
			return true
		end
	end
end

MapViewAreaHandler._setup_level_lists = function (self)
	local map_view_helper = self.map_view_helper
	local areas_level_list = {}
	local level_list_by_game_mode = {}

	for level_key, level_data in pairs(LevelSettings) do
		local valid_level = self:_validate_level_data(level_key, level_data)

		if valid_level then
			local map_settings = level_data.map_settings
			local area = map_settings.area
			local game_mode = level_data.game_mode

			if game_mode then
				if not areas_level_list[game_mode] then
					areas_level_list[game_mode] = {}
					level_list_by_game_mode[game_mode] = {}
				end

				local game_mode_level_list = areas_level_list[game_mode]

				if not game_mode_level_list[area] then
					game_mode_level_list[area] = {}
				end

				local level_information = {}
				local area_level_list = game_mode_level_list[area]
				area_level_list[level_key] = level_information
				level_information.level_key = level_key
				level_information.area = map_settings.area
				level_information.map_icon = map_settings.icon
				level_information.dlc_name = level_data.dlc_name
				level_information.level_image = level_data.level_image
				level_information.display_name = level_data.display_name
				level_information.wwise_events = map_settings.wwise_events
				level_information.position = map_settings.area_position
				local textures = table.clone(game_mode_level_area_textures[game_mode])
				level_information.textures = textures
				local map_icon = map_settings.icon
				local map_background_texture = map_settings.background_texture

				if map_icon then
					textures.icon = map_icon
				end

				if map_background_texture then
					textures.background = map_background_texture
					textures.hover = string.format("%s%s", map_background_texture, "_hover")
				end

				local visibility, visibility_tooltip = map_view_helper:get_level_visibility(level_key, level_data)
				level_information.visibility = visibility
				level_information.visibility_tooltip = visibility_tooltip

				if visibility ~= "hidden" then
					local difficulty_data = map_view_helper:get_difficulty_data(level_key, level_data)
					level_information.difficulty_data = difficulty_data
					level_list_by_game_mode[game_mode][#level_list_by_game_mode[game_mode] + 1] = level_information
				end
			end
		end
	end

	self._areas_level_list = areas_level_list

	for game_mode, level_list in pairs(level_list_by_game_mode) do
		table.sort(level_list, sort_level_information_list)
	end

	self._level_list_by_game_mode = level_list_by_game_mode

	self:setup_any_level_by_game_mode()
	self:setup_any_level_by_area()

	for game_mode, game_mode_area_list in pairs(areas_level_list) do
		local world_area_level_list = game_mode_area_list.world

		if not world_area_level_list then
			world_area_level_list = {}
			game_mode_area_list.world = world_area_level_list
		end

		for area, area_list in pairs(game_mode_area_list) do
			if area ~= "world" then
				local area_settings = AreaSettings[area]
				local display_name = area_settings.display_name
				local map_icon = area_settings.map_icon
				local level_image = area_settings.level_image
				local level_information = self:_create_summary_entry(area_list, area, display_name, map_icon, level_image)
				level_information.is_area = true

				if area_settings.dlc_url and not Managers.unlock:is_dlc_unlocked(area_settings.dlc_name) then
					local tooltip_text = Localize("dlc1_2_dlc_level_locked_tooltip")
					level_information.visibility = "dlc"
					level_information.visibility_tooltip = tooltip_text
					level_information.dlc_name = area_settings.dlc_name
					level_information.dlc_url = area_settings.dlc_url
				end

				level_information.position = area_settings.map_position
				world_area_level_list[area] = level_information
			end
		end
	end
end

MapViewAreaHandler.setup_any_level_by_area = function (self)
	local any_level_key = "any"
	local display_name = "any_level"
	local map_icon = "level_location_any_icon"
	local level_image = "level_image_any"

	for game_mode, game_mode_area_list in pairs(self._areas_level_list) do
		for area, area_level_list in pairs(game_mode_area_list) do
			local add_any_level = false

			for level_key, level_information in pairs(area_level_list) do
				local level_visibility = level_information.visibility

				if level_visibility == "visible" then
					add_any_level = true

					break
				end
			end

			if add_any_level then
				local level_information = self:_create_summary_entry(area_level_list, area, display_name, map_icon, level_image)
				level_information.position = {
					-560,
					290
				}
				local textures = game_mode_level_area_textures[game_mode]
				level_information.textures = table.clone(textures)
				level_information.level_key = any_level_key
				area_level_list[any_level_key] = level_information
			end
		end
	end
end

MapViewAreaHandler.setup_any_level_by_game_mode = function (self)
	local random_levels_by_game_mode = {}

	for game_mode, level_list in pairs(self._level_list_by_game_mode) do
		local add_any_level = false
		local area = nil

		for index, level_information in ipairs(level_list) do
			local level_visibility = level_information.visibility

			if level_visibility == "visible" then
				add_any_level = true
				area = level_information.area

				break
			end
		end

		if add_any_level then
			local any_level_key = "any"
			local display_name = "any_level"
			local map_icon = "level_location_any_icon"
			local level_image = "level_image_any"
			local level_information = self:_create_summary_entry(level_list, area, display_name, map_icon, level_image)
			level_information.position = {
				-560,
				290
			}
			local textures = game_mode_level_area_textures[game_mode]
			level_information.textures = table.clone(textures)
			level_information.level_key = any_level_key
			random_levels_by_game_mode[game_mode] = level_information
		end
	end

	self._random_levels_by_game_mode = random_levels_by_game_mode
end

MapViewAreaHandler.get_levels_by_game_mode = function (self, game_mode, include_random_level)
	if include_random_level then
		local stored_level_list = self._level_list_by_game_mode[game_mode]
		local random_level_information = self._random_levels_by_game_mode[game_mode]

		if random_level_information then
			local level_list = table.clone(stored_level_list)

			table.insert(level_list, 1, random_level_information)

			return level_list
		else
			return stored_level_list
		end
	else
		return self._level_list_by_game_mode[game_mode]
	end
end

MapViewAreaHandler.get_level_information_by_game_mode = function (self, level_key, game_mode)
	if level_key == "any" then
		return self._random_levels_by_game_mode[game_mode]
	else
		local level_list = self._level_list_by_game_mode[game_mode]

		for _, level_information in ipairs(level_list) do
			if level_information.level_key == level_key then
				return level_information
			end
		end
	end
end

MapViewAreaHandler.get_level_list_by_game_mode_and_area = function (self, game_mode_name, area_name)
	for game_mode, game_mode_area_list in pairs(self._areas_level_list) do
		if game_mode == game_mode_name then
			for area, area_level_list in pairs(game_mode_area_list) do
				if area_name and area_name == area then
					return area_level_list
				end
			end

			return game_mode_area_list
		end
	end
end

MapViewAreaHandler.get_difficulty_data_by_game_mode = function (self, game_mode_name)
	local map_view_helper = self.map_view_helper
	local data = {}

	for game_mode, game_mode_area_list in pairs(self._areas_level_list) do
		if game_mode == game_mode_name then
			for area, area_level_list in pairs(game_mode_area_list) do
				local difficulty_data = map_view_helper:get_difficulty_data_summary(area_level_list)
				data[area] = difficulty_data
			end
		end
	end

	return data
end

MapViewAreaHandler._create_summary_entry = function (self, level_list, area, display_name, map_icon, level_image)
	local map_view_helper = self.map_view_helper
	local difficulty_data = map_view_helper:get_difficulty_data_summary(level_list)
	local level_information = {
		area = area,
		map_icon = map_icon,
		level_image = level_image,
		display_name = display_name,
		visibility = "visible",
		difficulty_data = difficulty_data
	}

	return level_information
end

MapViewAreaHandler.open_selected_area = function (self)
	local selected_level_index = self._selected_level_index

	if selected_level_index then
		local level_list = self:active_level_list()
		local level_data = level_list[selected_level_index]
		local level_information = level_data.level_information
		local is_area = level_information.is_area
		local area = level_information.area

		if is_area then
			self:set_active_area(area)
			self:select_level_after_level_list_change(true)
		end
	end
end

MapViewAreaHandler.set_active_area = function (self, area)
	local game_mode = self._active_game_mode

	if not game_mode then
		return
	end

	self._area_changed = true
	local area_settings = AreaSettings[area]
	self.ui_animations = {}
	local widget_index = 0
	local level_widgets = self._level_widgets
	local area_widgets = self._area_widgets
	local areas_level_list = self._areas_level_list
	local area_level_list = areas_level_list[game_mode][area]
	local level_count = 0

	if area_level_list then
		local active_level_information_list = {}

		for level_key, level_information in pairs(area_level_list) do
			level_count = level_count + 1
			local visibility = level_information.visibility

			if visibility ~= "hidden" then
				local is_area = level_information.is_area
				local widget = nil

				if is_area then
					widget = area_widgets[level_key]
				else
					widget_index = widget_index + 1
					widget = level_widgets[widget_index]
				end

				local widget_textures = level_information.textures
				local map_position = level_information.position

				self:_reset_widget_for_level(widget, level_key, widget_textures, game_mode, map_position, is_area)

				local visibility_tooltip = level_information.visibility_tooltip

				self:_set_area_widget_visibility(widget, visibility, visibility_tooltip)

				if visibility == "visible" then
					local difficulty_data = level_information.difficulty_data

					self:_set_area_widget_difficulty_icons(widget, difficulty_data, game_mode, is_area)

					local display_name = level_information.display_name

					if not is_area then
						self:_set_area_widget_title_text(widget, display_name)
					end
				elseif visibility == "dlc" then
					local dlc_name = level_information.dlc_name
					widget.content.dlc_name = dlc_name
				end

				active_level_information_list[#active_level_information_list + 1] = {
					widget = widget,
					level_key = level_key,
					level_information = level_information
				}
			end
		end

		table.sort(active_level_information_list, sort_level_list)

		for index, data in ipairs(active_level_information_list) do
			local level_key = data.level_key
			local level_information = data.level_information
			local is_area = level_information.is_area

			if not is_area and not self:_area_already_viewed(level_key) then
				local widget = data.widget

				self:_on_level_widget_new(widget, index)
			end
		end

		local area_settings = AreaSettings[area]
		local map_texture = area_settings.map_texture

		if map_texture then
			self._draw_area_map = true
			self.map_area_widget.content.texture_id = area_settings.map_texture
		else
			local game_mode_settings = GameModeSettings[game_mode]
			local map_screen_texture = game_mode_settings and game_mode_settings.map_screen_texture

			if map_screen_texture then
				self._draw_area_map = true
				self.map_area_widget.content.texture_id = map_screen_texture
			else
				self._draw_area_map = nil
			end
		end

		self._selected_level_index = nil
		self._active_area = area_settings and area
		self._active_level_information_list = area_settings and active_level_information_list
	else
		self._selected_level_index = nil
		self._active_area = nil
		self._active_level_information_list = nil
	end

	self._active_level_count = level_count
end

MapViewAreaHandler.set_active_game_mode = function (self, game_mode, ignore_sound)
	if game_mode then
		self._active_game_mode = game_mode
		self._selected_level_index = nil
		self._active_level_information_list = nil

		self:set_active_area("world")

		if not ignore_sound then
			self:animate_map_overlay()
		end
	end
end

MapViewAreaHandler._reset_widget_for_level = function (self, widget, level_key, textures, game_mode, position, is_area)
	local widget_style = widget.style
	local widget_content = widget.content

	if textures then
		local background_texture = textures.background
		local selected_texture = textures.selected
		local locked_texture = textures.locked
		local hover_texture = textures.hover
		local icon_texture = textures.icon
		local new_texture = textures.new
		widget_content.background = background_texture
		widget_content.new_background = new_texture
		widget_content.selected = selected_texture
		widget_content.level_icon = icon_texture
		widget_content.hover = hover_texture
	end

	widget_content.is_new = false
	widget_content.locked_dlc = false
	widget_content.level_key = level_key

	if widget_content.preview_hotspot then
		table.clear(widget_content.preview_hotspot)
	end

	table.clear(widget_content.button_hotspot)

	local widget_scenegraph_id = widget.scenegraph_id
	local widget_position = self.ui_scenegraph[widget_scenegraph_id].local_position
	widget_position[1] = position[1]
	widget_position[2] = position[2]
	widget_position[3] = 5
	local preview_tooltip_style = widget_style.preview_tooltip

	if preview_tooltip_style then
		if position[1] > 0 then
			preview_tooltip_style.cursor_side = "left"
			preview_tooltip_style.cursor_offset[1] = -10
			preview_tooltip_style.cursor_offset[2] = -27
		else
			preview_tooltip_style.cursor_side = nil
			preview_tooltip_style.cursor_offset[1] = 25
			preview_tooltip_style.cursor_offset[2] = 15
		end
	end

	local alpha = 0
	widget_style.hover.color[1] = alpha

	if widget_style.selected then
		widget_style.selected.color[1] = alpha
	end

	if widget_style.title_text then
		widget_style.title_text.text_color[1] = alpha
		widget_style.text_background_left.color[1] = alpha
		widget_style.text_background_right.color[1] = alpha
		widget_style.text_background_center.color[1] = alpha
	end
end

MapViewAreaHandler._set_area_widget_difficulty_icons = function (self, widget, difficulty_data, game_mode, is_area)
	local difficulty_icons = game_mode_level_area_textures[game_mode].difficulty_icons
	local locked_difficulty_icon = difficulty_icons.locked
	local unlocked_difficulty_icon = difficulty_icons.unlocked
	local widget_content = widget.content
	local widget_style = widget.style
	local num_available_difficulties = 0
	local max_num_difficulties = #difficulty_data
	local difficulty_read_index = nil

	for i = 1, max_num_difficulties, 1 do
		local texture_id = "difficulty_icon_" .. i
		widget_style[texture_id].color[1] = 0
		local data = difficulty_data[i]

		if data.available then
			num_available_difficulties = num_available_difficulties + 1
			difficulty_read_index = difficulty_read_index or i
		end
	end

	difficulty_read_index = difficulty_read_index or 1
	local even_amount_of_difficulties = num_available_difficulties % 2 == 0
	local center_index = math.ceil(max_num_difficulties / 2)
	local index = center_index - math.floor(num_available_difficulties / 2)
	local num_difficulties_diff = max_num_difficulties - num_available_difficulties

	for i = 1, num_available_difficulties, 1 do
		local style_index = index

		if center_index <= index and even_amount_of_difficulties then
			style_index = index + 1
		end

		if difficulty_read_index <= max_num_difficulties then
			for k = difficulty_read_index, max_num_difficulties, 1 do
				local data = difficulty_data[difficulty_read_index]

				if data and data.available then
					local locked = not data.unlocked
					local completed = data.completed
					local texture_id = "difficulty_icon_" .. style_index
					local difficulty_icon = difficulty_icons[data.rank]
					widget_style[texture_id].color[1] = (is_area and not completed and 100) or 255

					if is_area then
						widget_content[texture_id] = "map_area_banner_difficulty_icon"
					else
						widget_content[texture_id] = (locked and locked_difficulty_icon) or (completed and difficulty_icon) or unlocked_difficulty_icon
					end

					difficulty_read_index = k + 1

					break
				end
			end
		end

		index = index + 1
	end
end

MapViewAreaHandler._set_area_widget_title_text = function (self, widget, display_name)
	local area_display_text = Localize(display_name)
	local widget_style = widget.style
	local font, scaled_font_size = UIFontByResolution(widget_style.title_text)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, area_display_text, font[1], scaled_font_size)
	text_width = math.ceil(text_width * 0.8)
	local text_background_center = widget_style.text_background_center
	local scenegraph_id = text_background_center.scenegraph_id
	self.ui_scenegraph[scenegraph_id].size[1] = text_width
	self._scenegraph_definition[scenegraph_id].size[1] = text_width
	widget.content.title_text = area_display_text
end

MapViewAreaHandler._set_area_widget_visibility = function (self, widget, visibility, tooltip)
	if visibility == "dlc" or visibility == "locked" then
		widget.content.button_hotspot.is_preview = true
		widget.content.preview_hotspot.is_preview = true
		widget.content.preview_tooltip = tooltip
		widget.content.preview_texture = (visibility == "dlc" and "level_location_icon_05") or "level_location_icon_03"

		if visibility == "dlc" then
			widget.content.locked_dlc = true
		end
	else
		widget.content.button_hotspot.is_preview = false
		widget.content.preview_hotspot.is_preview = false
	end
end

MapViewAreaHandler.update = function (self, input_service, dt)
	self._area_changed = nil

	for name, animation in pairs(self.ui_animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.ui_animations[name] = nil
		end
	end

	local back_button_widget = self.back_button_widget
	local back_button_content = back_button_widget.content

	if back_button_content.button_hotspot.on_pressed or (input_service and input_service:get("right_press")) then
		self:zoom_out()
	end

	self:_check_level_selection_mouse()
end

MapViewAreaHandler.zoom_out = function (self)
	local active_area = self:active_area()
	local destination_area = "world"

	if active_area ~= destination_area then
		self:set_active_area(destination_area)
		self:animate_map_overlay()

		local level_index = self:_get_widget_index_by_area_name(active_area)
		self.selected_level_index = nil

		if level_index then
			self:set_selected_level(level_index, nil, true)
		else
			self:select_level_after_level_list_change(true)
		end

		self:play_sound("Play_hud_next_tab")
		table.clear(self.back_button_widget.content.button_hotspot)
	end
end

MapViewAreaHandler._get_widget_index_by_area_name = function (self, area)
	local level_list = self:active_level_list()

	for i = 1, #level_list, 1 do
		local data = level_list[i]
		local level_information = data.level_information

		if level_information.is_area and level_information.area == area then
			return i
		end
	end
end

MapViewAreaHandler.draw = function (self, input_service, gamepad_active, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local active_area = self:active_area()

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	if active_area and self._draw_area_map then
		UIRenderer.draw_widget(ui_renderer, self.map_area_widget)
	end

	if active_area ~= "world" and not gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.back_button_widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.map_overlay_widget)

	local level_hover_index = nil
	local active_level_information_list = self._active_level_information_list

	if active_level_information_list then
		for index, data in ipairs(active_level_information_list) do
			local level_information = data.level_information
			local widget = data.widget
			local widget_hotspot = widget.content.button_hotspot

			if level_information.visibility == "visible" or level_information.is_area then
				if widget_hotspot.on_hover_enter then
					self:_on_level_widget_hover(widget, index)
				elseif widget_hotspot.on_hover_exit and not widget_hotspot.is_selected then
					self:_on_level_widget_dehover(widget, index)
				end

				if widget_hotspot.is_hover and not level_hover_index and self._selected_level_index ~= index then
					level_hover_index = index
				end

				UIRenderer.draw_widget(ui_renderer, widget)
			elseif widget_hotspot.is_preview and not level_information.is_area then
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end
	end

	self._level_hover_index = level_hover_index

	UIRenderer.end_pass(ui_renderer)
end

MapViewAreaHandler._check_level_selection_mouse = function (self)
	local selected_index = self._selected_level_index
	local active_level_information_list = self._active_level_information_list

	if active_level_information_list then
		for index, data in ipairs(active_level_information_list) do
			local show_store_page = false
			local level_information = data.level_information
			local widget = data.widget
			local widget_content = widget.content
			local button_hotspot = widget.content.button_hotspot

			if button_hotspot.is_selected then
				if button_hotspot.on_pressed then
					if level_information.is_area then
						if not level_information.dlc_url then
							local area = level_information.area

							self:set_active_area(area)
							self:animate_map_overlay()
							self:select_level_after_level_list_change(true)
							self:play_sound("Play_hud_select")
						end

						break
					end

					if not selected_index or selected_index ~= index then
						self:_on_level_selected(index, true)
					end

					break
				elseif button_hotspot.is_preview and widget_content.locked_dlc and (widget_content.dlc_name or level_information.dlc_url) then
					local preview_hotspot = widget_content.preview_hotspot

					if preview_hotspot.on_release then
						show_store_page = true
					end
				end
			elseif button_hotspot.is_preview and widget_content.locked_dlc and (widget_content.dlc_name or level_information.dlc_url) then
				local preview_hotspot = widget_content.preview_hotspot

				if preview_hotspot.on_release then
					show_store_page = true
				end
			end

			if show_store_page then
				self:show_level_store_page(index)
			end
		end
	end
end

MapViewAreaHandler.show_level_store_page = function (self, level_index)
	local active_level_information_list = self._active_level_information_list

	if active_level_information_list then
		local level_data = active_level_information_list[level_index]
		local level_information = level_data.level_information
		local dlc_name = level_information.dlc_name

		if dlc_name then
			local dlc_url = level_information.dlc_url

			if dlc_url then
				if rawget(_G, "Steam") then
					Steam.open_url(dlc_url)
				end
			else
				local dlc_id = Managers.unlock:dlc_id(dlc_name)

				if rawget(_G, "Steam") then
					Steam.open_overlay_store(dlc_id)
				end
			end
		end
	end
end

MapViewAreaHandler.select_level_after_level_list_change = function (self, ignore_sound)
	local play_game_mode_sound = false
	local first_level_key = nil
	local level_list = self:active_level_list()

	if level_list then
		local num_visible_levels = self:visible_level_count()

		if num_visible_levels > 0 and not first_level_key then
			for i = 1, #level_list, 1 do
				local level_data = level_list[i]
				local level_key = level_data.level_key
				local level_information = level_data.level_information

				if not first_level_key and level_information.visibility ~= "hidden" then
					first_level_key = level_key

					break
				end
			end
		end

		local new_selection_index = nil

		if first_level_key then
			for i = 1, #level_list, 1 do
				local level_data = level_list[i]
				local level_key = level_data.level_key

				if level_key == first_level_key then
					new_selection_index = i

					break
				end
			end
		else
			play_game_mode_sound = true
		end

		if new_selection_index then
			self:set_selected_level(new_selection_index, nil, true)
		end
	end

	if not ignore_sound then
		return play_game_mode_sound
	end
end

MapViewAreaHandler._area_already_viewed = function (self, level_key)
	local viewed_levels = self._map_save_data.viewed_levels

	if viewed_levels then
		local level_name = level_key

		return ((level_key == GameActs.prologue[1] or level_key == "any" or viewed_levels[level_name]) and true) or false
	end

	return false
end

MapViewAreaHandler.set_selected_level = function (self, index, play_sound, instant)
	return self:_on_level_selected(index, play_sound, instant)
end

MapViewAreaHandler._on_level_selected = function (self, index, play_sound, instant)
	local active_level_information_list = self._active_level_information_list
	local index = (active_level_information_list[index] and index) or 1
	local area_data = active_level_information_list[index]
	local level_information = area_data.level_information

	for i, data in ipairs(active_level_information_list) do
		local widget = data.widget
		local button_hotspot = widget.content.button_hotspot

		if i == index then
			button_hotspot.is_selected = true
		elseif button_hotspot.is_selected then
			button_hotspot.is_selected = nil

			self:_on_level_widget_deselect(widget, i)
		end
	end

	if index and index > 0 then
		local wwise_events = level_information.wwise_events
		local widget = area_data.widget

		self:_on_level_widget_select(widget, index, play_sound, instant)
	end

	self._selected_level_index = index
	self._level_hover_index = nil

	return level_information
end

MapViewAreaHandler._on_level_widget_select = function (self, widget, widget_index, play_sound, instant)
	local ui_animations = self.ui_animations
	local animation_name = "level_widget_select_" .. widget_index
	local hover_animation_name = "level_widget_hover_" .. widget_index
	local ui_scenegraph = self.ui_scenegraph
	local scenegraph_definition = self._scenegraph_definition
	local widget_style = widget.style
	local current_alpha = widget_style.selected.color[1]
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = (instant and 0) or (1 - current_alpha / target_alpha) * total_time
	local is_area_widget = (widget.content.area_name and true) or false
	local selected_scenegraph_id = widget_style.selected.scenegraph_id
	local selected_background_scenegraph = not is_area_widget and ui_scenegraph[selected_scenegraph_id]
	local selected_background_definition = not is_area_widget and scenegraph_definition[selected_scenegraph_id]

	self:_on_level_widget_new_cancel(widget, widget_index)

	if animation_duration > 0 then
		ui_animations[animation_name .. "_hover"] = self:_animate_element_by_time(widget_style.hover.color, 1, widget_style.hover.color[1], target_alpha, animation_duration)
		ui_animations[animation_name .. "_selected"] = self:_animate_element_by_time(widget_style.selected.color, 1, widget_style.selected.color[1], target_alpha, animation_duration)

		if not is_area_widget then
			ui_animations[animation_name .. "_selected_size_width"] = self:_animate_element_by_catmullrom(selected_background_scenegraph.size, 1, selected_background_definition.size[1], 0.7, 1, 1, 0.7, animation_duration)
			ui_animations[animation_name .. "_selected_size_height"] = self:_animate_element_by_catmullrom(selected_background_scenegraph.size, 2, selected_background_definition.size[2], 0.7, 1, 1, 0.7, animation_duration)
			ui_animations[animation_name .. "_preview"] = self:_animate_element_by_time(widget_style.preview_texture.color, 1, widget_style.preview_texture.color[1], target_alpha, animation_duration)
			ui_animations[animation_name .. "text_hover"] = self:_animate_element_by_time(widget_style.title_text.text_color, 1, widget_style.title_text.text_color[1], target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_1_hover"] = self:_animate_element_by_time(widget_style.text_background_left.color, 1, widget_style.text_background_left.color[1], target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_2_hover"] = self:_animate_element_by_time(widget_style.text_background_right.color, 1, widget_style.text_background_right.color[1], target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_3_hover"] = self:_animate_element_by_time(widget_style.text_background_center.color, 1, widget_style.text_background_center.color[1], target_alpha, animation_duration)
		end
	else
		if not is_area_widget then
			widget_style.title_text.text_color[1] = target_alpha
			widget_style.text_background_left.color[1] = target_alpha
			widget_style.text_background_right.color[1] = target_alpha
			widget_style.text_background_center.color[1] = target_alpha
			selected_background_scenegraph.size[1] = selected_background_definition.size[1]
			selected_background_scenegraph.size[2] = selected_background_definition.size[2]
		end

		widget_style.selected.color[1] = target_alpha
		widget_style.hover.color[1] = target_alpha
	end

	if play_sound then
		self:play_sound("Play_hud_select")
	end
end

MapViewAreaHandler._on_level_widget_deselect = function (self, widget, widget_index)
	local ui_animations = self.ui_animations
	local animation_name = "level_widget_select_" .. widget_index
	local hover_animation_name = "level_widget_hover_" .. widget_index
	local ui_scenegraph = self.ui_scenegraph
	local widget_style = widget.style
	local widget_content = widget.content
	local current_alpha = widget_style.selected.color[1]
	local target_alpha = 0
	local hover_alpha = 190
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = (1 - (255 - current_alpha) / 255) * total_time
	local is_area_widget = (widget.content.area_name and true) or false

	if animation_duration > 0 then
		ui_animations[animation_name .. "_hover"] = self:_animate_element_by_time(widget_style.hover.color, 1, widget_style.hover.color[1], target_alpha, animation_duration)
		ui_animations[animation_name .. "_selected"] = self:_animate_element_by_time(widget_style.selected.color, 1, widget_style.selected.color[1], target_alpha, animation_duration)

		if not is_area_widget then
			ui_animations[animation_name .. "_preview"] = self:_animate_element_by_time(widget_style.preview_texture.color, 1, widget_style.preview_texture.color[1], 150, animation_duration)
			ui_animations[animation_name .. "text_hover"] = self:_animate_element_by_time(widget_style.title_text.text_color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_1_hover"] = self:_animate_element_by_time(widget_style.text_background_left.color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_2_hover"] = self:_animate_element_by_time(widget_style.text_background_right.color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_3_hover"] = self:_animate_element_by_time(widget_style.text_background_center.color, 1, current_alpha, target_alpha, animation_duration)
		end
	else
		widget_style.selected.color[1] = target_alpha
		widget_style.hover.color[1] = target_alpha
	end
end

MapViewAreaHandler._on_level_widget_hover = function (self, widget, widget_index)
	local ui_animations = self.ui_animations
	local animation_name = "level_widget_hover_" .. widget_index
	local widget_style = widget.style
	local current_alpha = widget_style.hover.color[1]
	local target_alpha = 255
	local hover_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = (1 - current_alpha / target_alpha) * total_time
	local is_area_widget = (widget.content.area_name and true) or false

	self:_on_level_widget_new_cancel(widget, widget_index)

	if animation_duration > 0 then
		ui_animations[animation_name .. "_hover"] = self:_animate_element_by_time(widget_style.hover.color, 1, current_alpha, target_alpha, animation_duration)

		if not is_area_widget then
			ui_animations[animation_name .. "text_hover"] = self:_animate_element_by_time(widget_style.title_text.text_color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_1_hover"] = self:_animate_element_by_time(widget_style.text_background_left.color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_2_hover"] = self:_animate_element_by_time(widget_style.text_background_right.color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_3_hover"] = self:_animate_element_by_time(widget_style.text_background_center.color, 1, current_alpha, target_alpha, animation_duration)
		end
	else
		widget_style.hover.color[1] = target_alpha
	end

	self:play_sound("Play_hud_hover")
end

MapViewAreaHandler._on_level_widget_dehover = function (self, widget, widget_index)
	local ui_animations = self.ui_animations
	local animation_name = "level_widget_hover_" .. widget_index
	local widget_style = widget.style
	local current_alpha = widget_style.hover.color[1]
	local target_alpha = 0
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = current_alpha / 255 * total_time
	local is_area_widget = (widget.content.area_name and true) or false

	if animation_duration > 0 then
		ui_animations[animation_name .. "_hover"] = self:_animate_element_by_time(widget_style.hover.color, 1, current_alpha, target_alpha, animation_duration)

		if not is_area_widget then
			ui_animations[animation_name .. "text_hover"] = self:_animate_element_by_time(widget_style.title_text.text_color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_1_hover"] = self:_animate_element_by_time(widget_style.text_background_left.color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_2_hover"] = self:_animate_element_by_time(widget_style.text_background_right.color, 1, current_alpha, target_alpha, animation_duration)
			ui_animations[animation_name .. "text_bg_3_hover"] = self:_animate_element_by_time(widget_style.text_background_center.color, 1, current_alpha, target_alpha, animation_duration)
		end
	else
		widget_style.hover.color[1] = target_alpha
	end
end

MapViewAreaHandler._on_level_widget_new = function (self, widget, widget_index)
	if widget.content.area_name then
		return
	end

	local ui_animations = self.ui_animations
	local animation_name = "level_widget_new_" .. widget_index
	local ui_scenegraph = self.ui_scenegraph
	local scenegraph_definition = definitions.scenegraph_definition
	local widget_style = widget.style
	local current_alpha = 170
	local target_alpha = 255
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = current_alpha / target_alpha * total_time
	widget.content.is_new = true

	if animation_duration > 0 then
		ui_animations[animation_name] = self:_animate_element_pulse(widget_style.new_flag.color, 1, current_alpha, target_alpha, 2)
	end
end

MapViewAreaHandler._on_level_widget_new_cancel = function (self, widget, widget_index)
	if widget.content.area_name then
		return
	end

	local ui_animations = self.ui_animations
	local animation_name = "level_widget_new_" .. widget_index

	if ui_animations[animation_name] then
		ui_animations[animation_name] = nil
		local widget_style = widget.style
		widget_style.new_flag.color[1] = 0
		widget.content.is_new = false
		local level_key = widget.content.level_key
		local viewed_levels = self._map_save_data.viewed_levels

		if viewed_levels and not self:_area_already_viewed(level_key) then
			viewed_levels[level_key] = true
		end
	end
end

MapViewAreaHandler._animate_element_by_time = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, from, to, time, math.ease_out_quad)

	return new_animation
end

MapViewAreaHandler._animate_element_by_catmullrom = function (self, target, target_index, target_value, p0, p1, p2, p3, time)
	local new_animation = UIAnimation.init(UIAnimation.catmullrom, target, target_index, target_value, p0, p1, p2, p3, time)

	return new_animation
end

MapViewAreaHandler._animate_element_pulse = function (self, target, target_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.pulse_animation, target, target_index, from, to, time)

	return new_animation
end

MapViewAreaHandler.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

MapViewAreaHandler.active_game_mode = function (self)
	return self._active_game_mode
end

MapViewAreaHandler.active_area = function (self)
	return self._active_area
end

MapViewAreaHandler.selected_level_index = function (self)
	return self._selected_level_index
end

MapViewAreaHandler.area_changed = function (self)
	return self._area_changed
end

MapViewAreaHandler.level_hover_index = function (self)
	return self._level_hover_index
end

MapViewAreaHandler.active_level_count = function (self)
	return self._active_level_count or 0
end

MapViewAreaHandler.selected_level = function (self)
	local selected_level_index = self._selected_level_index

	if selected_level_index then
		local active_level_information_list = self._active_level_information_list

		if active_level_information_list then
			local level_data = active_level_information_list[selected_level_index]

			return level_data.level_key, level_data.level_information, selected_level_index
		end
	end
end

MapViewAreaHandler.get_difficulty_data_by_level_index = function (self, level_index)
	local active_level_information_list = self._active_level_information_list

	if active_level_information_list then
		local level_data = active_level_information_list[level_index]
		local level_information = level_data.level_information

		return level_information.difficulty_data
	end
end

MapViewAreaHandler.active_level_list = function (self)
	return self._active_level_information_list
end

MapViewAreaHandler.visible_level_count = function (self)
	local num_visible_levels = 0
	local level_list = self:active_level_list()

	if level_list then
		for index, data in ipairs(level_list) do
			local level_information = data.level_information

			if level_information.visibility ~= "hidden" then
				num_visible_levels = num_visible_levels + 1
			end
		end
	end

	return num_visible_levels
end

MapViewAreaHandler.animate_map_overlay = function (self)
	local color = self.map_overlay_widget.style.texture_id.color
	self.ui_animations.overlay_fade = self:_animate_element_by_time(color, 1, 255, 0, 0.3)
end

return
