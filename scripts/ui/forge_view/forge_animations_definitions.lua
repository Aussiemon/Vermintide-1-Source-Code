local function animate_widget_scenegraph_on_select(widget_scenegraph, default_scenegraph_definition, progress, catmullrom_value, color)
	local default_size = default_scenegraph_definition.size
	local default_position = default_scenegraph_definition.position
	local scenegraph_size = widget_scenegraph.size
	local scenegraph_position = widget_scenegraph.local_position
	scenegraph_size[1] = catmullrom_value * default_size[1]
	scenegraph_size[2] = catmullrom_value * default_size[2]
	local position_offset_fraction = (progress < 1 and 1 - catmullrom_value) or 0
	local x_offset = (position_offset_fraction * default_size[1]) / 2
	local y_offset = position_offset_fraction * default_size[2] / 2
	scenegraph_position[1] = default_position[1] + x_offset
	scenegraph_position[2] = default_position[2] - y_offset

	if color then
		color[1] = math.min(progress * 4, 1) * 255
	end
end

local tab_widget_select = {
	{
		name = "tab_widget_select",
		start_progress = 0,
		end_progress = UISettings.inventory.button_bars.selected_fade_in,
		init = function (ui_scenegraph, scenegraph_definition, widget, params)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, params)
			local catmullrom_value = (progress == 1 and 1) or math.catmullrom(progress, 1, 0.95, 1, 0.7)
			local scenegraph_id = widget.scenegraph_id
			local button_scenegraph_definition = ui_scenegraph[scenegraph_id]
			local button_default_scenegraph_definition = scenegraph_definition[scenegraph_id]

			animate_widget_scenegraph_on_select(button_scenegraph_definition, button_default_scenegraph_definition, progress, catmullrom_value)
		end,
		on_complete = function (ui_scenegraph, scenegraph_definition, widget, params)
			return
		end
	}
}
local tab_widget_deselect = {
	{
		name = "tab_widget_deselect",
		start_progress = 0,
		end_progress = UISettings.inventory.button_bars.selected_fade_out,
		init = function (ui_scenegraph, scenegraph_definition, widget, params)
			return
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, params)
			return
		end,
		on_complete = function (ui_scenegraph, scenegraph_definition, widget, params)
			return
		end
	}
}

return {
	tab_widget_select = tab_widget_select,
	tab_widget_deselect = tab_widget_deselect,
	animate_widget_scenegraph_on_select = animate_widget_scenegraph_on_select
}
