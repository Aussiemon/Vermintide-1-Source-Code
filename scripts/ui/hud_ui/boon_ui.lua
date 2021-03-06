local definitions = local_require("scripts/ui/hud_ui/boon_ui_definitions")
local scenegraph_definition = definitions.scenegraph_definition
local BOON_WIDTH = 44
local BOON_HEIGHT = 84
local BOON_SPACING = 15
BoonUI = class(BoonUI)
local MAX_NUMBER_OF_BOONS = definitions.MAX_NUMBER_OF_BOONS
local DEBUG_BOONS_UI = false

BoonUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.peer_id = ingame_ui_context.peer_id
	self.player_manager = ingame_ui_context.player_manager
	self.cleanui = ingame_ui_context.cleanui
	self.ui_animations = {}
	self.render_settings = {
		alpha_multiplier = 1
	}
	self.is_in_inn = ingame_ui_context.is_in_inn

	self:_create_ui_elements()

	local boon_pivot_definition = scenegraph_definition.pivot
	local boon_pivot_position = boon_pivot_definition.position
	local size = {
		(BOON_WIDTH * MAX_NUMBER_OF_BOONS + BOON_SPACING * MAX_NUMBER_OF_BOONS) * 2,
		BOON_HEIGHT
	}
	local position = {
		(1920 + boon_pivot_position[1]) - (size[1] - BOON_WIDTH * 1.5),
		0
	}
	self.cleanui_data = {}

	UICleanUI.register_area(self.cleanui, "boon_ui", self.cleanui_data, position, size)
	rawset(_G, "boon_ui", self)
end

BoonUI._create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	local widgets = {}
	local unused_widgets = {}

	for i, definition in ipairs(definitions.widget_definitions) do
		widgets[i] = UIWidget.init(definition)
		unused_widgets[i] = widgets[i]
	end

	self._widgets = widgets
	self._unused_widgets = unused_widgets
	self._active_boons = {}

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self:set_visible(true)
	self:set_dirty()

	self._num_active_boons = 0

	self:_align_widgets()
end

BoonUI._align_widgets = function (self)
	local gamepad_active = self.input_manager:is_device_active("gamepad")
	local boon_width = 38
	local boon_spacing = BOON_SPACING
	local time_height = 14
	local horizontal_spacing = boon_width + boon_spacing
	local vertical_spacing = boon_width + boon_spacing + time_height
	local current_index = 0
	local start_x_offset = (gamepad_active and -250) or 0
	local widget_total_width = 0

	for _, data in ipairs(self._active_boons) do
		local widget = data.widget
		local widget_offset = widget.offset
		widget_offset[1] = start_x_offset + widget_total_width
		widget_offset[2] = math.floor(current_index / MAX_NUMBER_OF_BOONS) * vertical_spacing
		widget_total_width = widget_total_width - horizontal_spacing

		self:_set_widget_dirty(widget)

		current_index = current_index + 1

		if current_index % MAX_NUMBER_OF_BOONS == 0 then
			widget_total_width = 0
		end
	end

	self:set_dirty()
end

local sorted_boons = {}

local function boon_sort_func(a, b)
	local a_remaining_duration = a.remaining_duration
	local b_remaining_duration = b.remaining_duration
	local index_a = (a.own_boon ~= nil and ((a.own_boon and a_remaining_duration) or MaxBoonDuration + a_remaining_duration)) or math.huge
	local index_b = (b.own_boon ~= nil and ((b.own_boon and b_remaining_duration) or MaxBoonDuration + b_remaining_duration)) or math.huge

	return index_a < index_b
end

local widgets_to_remove = {}
local verified_widgets = {}

BoonUI._sync_boons = function (self)
	table.clear(sorted_boons)

	local player = Managers.player:local_player(1)
	local boon_handler = player.boon_handler
	local network_time = Managers.state.network:network_time()
	local active_boons = self._active_boons

	if boon_handler then
		table.clear(verified_widgets)

		local boons = boon_handler:get_active_boons()
		local align_widgets = false

		for i = 1, #boons, 1 do
			repeat
				local boon_data = boons[i]
				local boon_name = boon_data.name

				if not boon_name then
					break
				end

				local own_boon = boon_data.own_boon
				local end_time = network_time + boon_data.remaining_duration
				local verified = false

				for j = 1, #active_boons, 1 do
					local data = active_boons[j]

					if data.name == boon_name and data.end_time == end_time and data.infinite ~= own_boon then
						local index = j

						if not verified_widgets[j] then
							verified = true
							verified_widgets[j] = true

							break
						end
					end
				end

				if not verified and (boon_data.remaining_duration > 0 or not self.is_in_inn) then
					self:_add_boon(boon_name, own_boon, end_time)

					verified_widgets[#active_boons] = true
					align_widgets = true
				end
			until true
		end

		table.clear(widgets_to_remove)

		for i = 1, #active_boons, 1 do
			if not verified_widgets[i] then
				widgets_to_remove[#widgets_to_remove + 1] = i
			end
		end

		local index_mod = 0

		for i = 1, #widgets_to_remove, 1 do
			local index = widgets_to_remove[i] - index_mod

			self:_remove_boon(index)

			index_mod = index_mod + 1
			align_widgets = true
		end

		if align_widgets then
			self:_align_widgets()
		end
	end
end

BoonUI._add_boon = function (self, boon_name, own_boon, end_time)
	local num_active_boons = self._num_active_boons or 0

	if MAX_NUMBER_OF_BOONS <= num_active_boons then
		return
	end

	local unused_widgets = self._unused_widgets
	local widget = table.remove(unused_widgets, 1)

	UIRenderer.set_element_visible(self.ui_renderer, widget.element, true)

	local active_boons = self._active_boons
	local boon_template = BoonTemplates[boon_name]
	local duration = boon_template.duration
	local infinite = not own_boon
	local widget_content = widget.content
	local color = (infinite and widget_content.infinite_color) or widget_content.normal_color
	widget_content.texture_icon = boon_template.ui_icon

	self:_set_widget_colors(widget, color)

	local data = {
		name = boon_name,
		widget = widget,
		infinite = infinite,
		end_time = end_time,
		duration = duration
	}

	table.insert(active_boons, #active_boons + 1, data)

	self._num_active_boons = num_active_boons + 1

	self:_set_widget_time_progress(widget, 1)
end

BoonUI._remove_boon = function (self, index)
	local num_active_boons = self._num_active_boons or 0

	if num_active_boons <= 0 then
		return
	end

	local active_boons = self._active_boons
	local data = table.remove(active_boons, index)
	local widget = data.widget

	table.insert(self._unused_widgets, #self._unused_widgets + 1, widget)
	UIRenderer.set_element_visible(self.ui_renderer, widget.element, false)

	self._num_active_boons = num_active_boons - 1
end

BoonUI.set_position = function (self, x, y)
	local position = self.ui_scenegraph.pivot.local_position
	position[1] = x
	position[2] = y

	for _, widget in ipairs(self._widgets) do
		self:_set_widget_dirty(widget)
	end

	self:set_dirty()
end

BoonUI.destroy = function (self)
	self:set_visible(false)
	rawset(_G, "boon_ui", nil)
end

BoonUI.set_visible = function (self, visible)
	self._is_visible = visible
	local ui_renderer = self.ui_renderer

	for _, widget in ipairs(self._widgets) do
		UIRenderer.set_element_visible(ui_renderer, widget.element, visible)
	end

	self:set_dirty()
end

BoonUI.update = function (self, dt, t)
	local dirty = false
	local gamepad_active = self.input_manager:is_device_active("gamepad")

	if gamepad_active then
		if not self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = true

			self:on_gamepad_activated()

			dirty = true
		end
	elseif self.gamepad_active_last_frame then
		self.gamepad_active_last_frame = false

		self:on_gamepad_deactivated()

		dirty = true
	end

	if DEBUG_BOONS_UI then
		if Keyboard.button(Keyboard.button_index("1")) ~= 0 then
			dirty = true
		elseif Keyboard.button(Keyboard.button_index("2")) ~= 0 then
			dirty = true
		end
	end

	if dirty or DEBUG_BOONS_UI or self.cleanui_data.is_dirty then
		self:set_dirty()
	end

	self:_sync_boons()
	self:_handle_resolution_modified()
	self:_update_boon_timers(dt)
	self:draw(dt)
end

BoonUI._handle_resolution_modified = function (self)
	if RESOLUTION_LOOKUP.modified then
		self:_on_resolution_modified()
	end
end

BoonUI._on_resolution_modified = function (self)
	for _, widget in ipairs(self._widgets) do
		self:_set_widget_dirty(widget)
	end

	self:set_dirty()
end

BoonUI._set_widget_colors = function (self, widget, color)
	local style = widget.style
	local bg_color = style.texture_bg.color
	local text__color = style.timer_text.text_color
	local frame_color = style.texture_frame.color
	bg_color[2] = color[2]
	bg_color[3] = color[3]
	bg_color[4] = color[4]
	frame_color[2] = color[2]
	frame_color[3] = color[3]
	frame_color[4] = color[4]
	text__color[2] = color[2]
	text__color[3] = color[3]
	text__color[4] = color[4]
end

BoonUI.draw = function (self, dt)
	if not self._is_visible then
		return
	end

	if not self._dirty then
		return
	end

	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")
	local render_settings = self.render_settings

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, render_settings)

	local alpha = UICleanUI.get_alpha(self.cleanui, self.cleanui_data)
	render_settings.alpha_multiplier = alpha

	for _, data in ipairs(self._active_boons) do
		local widget = data.widget

		UIRenderer.draw_widget(ui_renderer, widget)
	end

	render_settings.alpha_multiplier = 1

	UIRenderer.end_pass(ui_renderer)

	self._dirty = false
end

BoonUI._update_boon_timers = function (self, dt)
	local dirty = false
	local network_time = Managers.state.network:network_time()

	for index, data in ipairs(self._active_boons) do
		local end_time = data.end_time

		if end_time then
			local widget = data.widget
			local duration = data.duration
			local infinite = data.infinite

			if not infinite then
				if network_time < end_time then
					local time_left = math.max(end_time - network_time, 0)
					local progress = 1 - math.min(time_left / duration, 1)

					self:_set_widget_time_progress(widget, progress, time_left)
				end

				dirty = true
			end
		end
	end

	if dirty or DEBUG_BOONS_UI then
		self:set_dirty()
	end
end

local floor = math.floor

BoonUI._set_widget_time_progress = function (self, widget, progress, time_left)
	if time_left and time_left > 0 then
		local days = floor(time_left / 86400)
		local hours = floor(time_left / 3600)
		local minutes = floor(time_left / 60)
		local seconds = floor(time_left)

		if days > 0 then
			widget.content.timer_text = tostring(days) .. "d"
		elseif hours > 2 then
			widget.content.timer_text = tostring(hours) .. "h"
		elseif minutes > 0 then
			widget.content.timer_text = tostring(minutes) .. "m"
		elseif seconds >= 0 then
			widget.content.timer_text = tostring(seconds) .. "s"
		end

		widget.content.is_expired = false
		widget.style.texture_frame.gradient_threshold = 1 - progress
		widget.style.texture_bg.color = {
			120,
			36,
			215,
			231
		}
		widget.style.texture_frame.color = {
			255,
			36,
			215,
			231
		}
		widget.style.texture_icon.color = {
			255,
			255,
			255,
			255
		}
	else
		widget.content.is_expired = true
		widget.style.texture_frame.gradient_threshold = 1
		widget.style.texture_bg.color = Colors.get_color_table_with_alpha("dim_gray", 60)
		widget.style.texture_frame.color = Colors.get_color_table_with_alpha("white", 120)
		widget.style.texture_icon.color = Colors.get_color_table_with_alpha("white", 120)
	end

	self:_set_widget_dirty(widget)
end

BoonUI.set_dirty = function (self)
	self._dirty = true
end

BoonUI._set_widget_dirty = function (self, widget)
	widget.element.dirty = true
end

BoonUI.on_gamepad_activated = function (self)
	self:_align_widgets()
end

BoonUI.on_gamepad_deactivated = function (self)
	self:_align_widgets()
end

return
