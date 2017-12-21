require("scripts/ui/ui_renderer")
require("scripts/ui/ui_elements")
require("scripts/ui/ui_element")
require("scripts/ui/ui_widgets")

local definitions = require("scripts/ui/views/loading_icon_view_definitions")
local DO_RELOAD = true
local FADE_TIME = 0.5
local loading_icon_data = {
	column_count = 10,
	row_count = 10,
	frames_per_second = 30
}
LoadingIconView = class(LoadingIconView)
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
LoadingIconView.init = function (self, world)
	self.world = world
	self.ui_renderer = UIRenderer.create(world, "material", "materials/ui/ui_1080p_loading")
	self.render_settings = {
		snap_pixel_positions = true
	}

	self.create_ui_elements(self)

	self._icon_fade_timer = 0
	self._show_loading_icon = false
	DO_RELOAD = false

	return 
end
LoadingIconView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.loading_icon_widget = UIWidget.init(definitions.loading_icon)

	return 
end
LoadingIconView.show_loading_icon = function (self)
	self._show_loading_icon = true

	return 
end
LoadingIconView.hide_loading_icon = function (self)
	self._show_loading_icon = false

	return 
end
LoadingIconView.show_icon_background = function (self)
	local widget = self.loading_icon_widget
	widget.style.background_rect.color[1] = 255

	return 
end
LoadingIconView.hide_icon_background = function (self)
	local widget = self.loading_icon_widget
	widget.style.background_rect.color[1] = 0

	return 
end
LoadingIconView.active = function (self)
	return self._show_loading_icon or 0 < self._icon_fade_timer
end
LoadingIconView.update = function (self, dt)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if self.active(self) then
		self.update_loading_icon(self, dt)
		self.draw(self, dt)
	end

	return 
end
LoadingIconView.update_loading_icon = function (self, dt)
	local widget = self.loading_icon_widget
	local icon_style = widget.style.icon
	local uvs = icon_style.uvs
	local icon_data = loading_icon_data
	local speed = icon_data.frames_per_second/1

	if not self.icon_timer then
		self.icon_timer = speed
	else
		local timer = self.icon_timer - math.min(dt, 0.05)

		if timer <= 0 then
			if icon_style.column_index < icon_data.column_count then
				icon_style.column_index = icon_style.column_index + 1
			else
				icon_style.column_index = 1

				if icon_style.row_index < icon_data.row_count then
					icon_style.row_index = icon_style.row_index + 1
				else
					icon_style.row_index = 1
				end
			end

			self.icon_timer = timer + speed
		else
			self.icon_timer = timer
		end
	end

	if self._show_loading_icon then
		self._icon_fade_timer = math.clamp(self._icon_fade_timer + dt, 0, FADE_TIME)
	else
		self._icon_fade_timer = math.clamp(self._icon_fade_timer - dt, 0, FADE_TIME)
	end

	icon_style.color[1] = self._icon_fade_timer/FADE_TIME*255

	return 
end
LoadingIconView.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, fake_input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self.loading_icon_widget)
	UIRenderer.end_pass(ui_renderer)

	return 
end
LoadingIconView.destroy = function (self)
	UIRenderer.destroy(self.ui_renderer, self.world)

	return 
end

return 
