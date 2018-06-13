UICleanUI = {}
local UICleanUI = UICleanUI

UICleanUI.create = function ()
	return {
		was_enabled = false,
		areas = {},
		widget_area_map = {}
	}
end

TOBII_HAS_BEEN_INITIALIZED = TOBII_HAS_BEEN_INITIALIZED or false

if rawget(_G, "Tobii") and not TOBII_HAS_BEEN_INITIALIZED then
	TOBII_HAS_BEEN_INITIALIZED = true
	local get_gaze_point_orig = Tobii.get_gaze_point

	Tobii.get_gaze_point = function ()
		local gaze_x, gaze_y = get_gaze_point_orig()

		return gaze_x, gaze_y
	end
end

local min_alpha_value_name = "tobii_clean_ui_alpha"

UICleanUI.update = function (self, dt)
	local is_enabled = rawget(_G, "Tobii") and Application.user_setting("tobii_eyetracking") and Application.user_setting("tobii_clean_ui")
	is_enabled = is_enabled and Tobii.device_status() == Tobii.DEVICE_TRACKING
	is_enabled = is_enabled and Tobii.user_presence() == Tobii.USER_PRESENT
	local areas = self.areas
	local n_areas = #areas

	if not is_enabled and self.was_enabled then
		for i = 1, n_areas, 1 do
			local area = areas[i]
			area.timer = 0
			area.alpha_scale = 1
		end
	end

	self.was_enabled = is_enabled

	if not is_enabled then
		return
	end

	local min_alpha_value = Application.user_setting(min_alpha_value_name) or DefaultUserSettings[min_alpha_value_name]
	local gaze_x, gaze_y = Tobii.get_gaze_point()
	gaze_x = 1 - gaze_x

	if not UISettings.use_hud_screen_fit then
		local root_scale_x = RESOLUTION_LOOKUP.res_w / (UIResolutionWidthFragments() * RESOLUTION_LOOKUP.scale)
		gaze_x = gaze_x * 2 - 1
		gaze_x = gaze_x * root_scale_x
		gaze_x = (gaze_x + 1) / 2
	end

	local areas = self.areas
	local n_areas = #areas

	for i = 1, n_areas, 1 do
		local area = areas[i]
		local center = area.center
		local center_x = center[1]
		local center_y = center[2]
		local distance_x = math.abs(gaze_x - center_x)
		local distance_y = math.abs(gaze_y - center_y)
		local extents = area.extents

		if extents[1] < distance_x or extents[2] < distance_y then
			local timer = area.timer + dt
			area.timer = timer

			if timer > 0.5 then
				local alpha_scale = math.max(area.alpha_scale - dt * 2, min_alpha_value)

				if area.alpha_scale ~= alpha_scale then
					area.alpha_scale = alpha_scale
					area.widget.is_dirty = true
				else
					area.widget.is_dirty = false
				end
			end
		else
			area.widget.is_dirty = true
			area.timer = 0
			area.alpha_scale = 1
		end
	end
end

local SCREEN_MAX_X = 1920
local SCREEN_MAX_Y = 1080

UICleanUI.debug_draw = function (self, ui_renderer)
	local areas = self.areas
	local n_areas = #areas

	for i = 1, n_areas, 1 do
		local area = areas[i]
		local llc = {
			area.position[1] * SCREEN_MAX_X,
			area.position[2] * SCREEN_MAX_Y,
			100
		}
		local size = {
			area.size[1] * SCREEN_MAX_X,
			area.size[2] * SCREEN_MAX_Y,
			0
		}
		local color = {
			100,
			area.alpha_scale,
			255,
			0
		}

		UIRenderer.draw_rect(ui_renderer, llc, size, color)
	end
end

UICleanUI.has_registered_area = function (self, name)
	local areas = self.areas

	for i = 1, #areas, 1 do
		local area = areas[i]

		if area.name == name then
			return true, i
		end
	end
end

local SCREEN_MAX_X = 1920
local SCREEN_MAX_Y = 1080

UICleanUI.register_area = function (self, name, widget, position, size, aligns_x)
	local center = {
		center[1] / SCREEN_MAX_X,
		center[2] / SCREEN_MAX_Y
	}
	local extents = {
		size[1] / 2 / SCREEN_MAX_X,
		size[2] / 2 / SCREEN_MAX_Y
	}
	local has_area_by_name, area_list_index = UICleanUI.has_registered_area(self, name)
	local area_index = (has_area_by_name and area_list_index) or #self.areas + 1
	local area = (has_area_by_name and self.areas[area_list_index]) or {}

	if has_area_by_name then
		self.widget_area_map[area.widget] = nil
	end

	area.name = name
	area.widget = widget
	area.position = {
		position[1] / SCREEN_MAX_X,
		position[2] / SCREEN_MAX_Y
	}
	area.size = {
		size[1] / SCREEN_MAX_X,
		size[2] / SCREEN_MAX_Y
	}
	area.center = center
	area.extents = extents
	area.alpha_scale = 1
	area.timer = 0
	area.aligns_x = aligns_x
	self.areas[area_index] = area
	self.widget_area_map[widget] = area
end

UICleanUI.get_alpha = function (self, widget)
	return self.widget_area_map[widget].alpha_scale
end

UICleanUI.reset_area = function (self, widget)
	self.widget_area_map[widget].alpha_scale = 1
	self.widget_area_map[widget].timer = 0
end

return
