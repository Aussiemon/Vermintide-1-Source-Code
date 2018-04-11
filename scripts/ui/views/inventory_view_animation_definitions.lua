local temp_pos = {
	0,
	0,
	0
}

local function animate_style_on_select(style, size, progress, catmullrom_value, default_style, ignore_color)
	local offset_fraction = (progress < 1 and 1 - catmullrom_value) or 0
	local original_size = (default_style and default_style.size) or size
	local original_position = (default_style and default_style.position) or temp_pos
	local x_offset = (offset_fraction * original_size[1]) / 2
	local y_offset = offset_fraction * original_size[2] / 2
	style.size[1] = catmullrom_value * original_size[1]
	style.size[2] = catmullrom_value * original_size[2]
	style.offset[1] = original_position[1] + x_offset
	style.offset[2] = original_position[2] + y_offset

	if not ignore_color then
		style.color[1] = math.min(progress * 4, 1) * 255
	end

	return 
end

local bar_item_select = {
	{
		name = "bar_item_select",
		start_progress = 0,
		end_progress = UISettings.inventory.button_bars.selected_fade_in,
		init = function (ui_scenegraph, scenegraph_definition, widget, params)
			return 
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, params)
			local catmullrom_value = (progress == 1 and 1) or math.catmullrom(progress, 1, 0.95, 1, 0.7)
			local widget_style = widget.style
			local selected_index = params.selected_index
			local scenegraph_base = params.scenegraph_base
			local scenegraph_id = string.format("%s_%d", scenegraph_base, selected_index)
			local icon_scenegraph_id = string.format("%s_icon_%d", scenegraph_base, selected_index)
			local button_click_style = widget_style[string.format("button_click_style_%d", selected_index)]
			local icon_click_style = widget_style[string.format("icon_click_%d", selected_index)]
			local button_size = scenegraph_definition[scenegraph_id].size
			local icon_size = scenegraph_definition[icon_scenegraph_id].size

			animate_style_on_select(button_click_style, button_size, progress, catmullrom_value)
			animate_style_on_select(icon_click_style, icon_size, progress, catmullrom_value)

			return 
		end,
		on_complete = function (ui_scenegraph, scenegraph_definition, widget, params)
			return 
		end
	}
}
local bar_item_deselect = {
	{
		name = "bar_item_deselect",
		start_progress = 0,
		end_progress = UISettings.inventory.button_bars.selected_fade_out,
		init = function (ui_scenegraph, scenegraph_definition, widget, params)
			return 
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, params)
			local catmullrom_value = (progress == 1 and 1) or math.catmullrom(progress, 1, 0.95, 1, 0.7)
			local widget_style = widget.style
			local selected_index = params.selected_index
			local scenegraph_base = params.scenegraph_base
			local scenegraph_id = string.format("%s_%d", scenegraph_base, selected_index)
			local icon_scenegraph_id = string.format("%s_icon_%d", scenegraph_base, selected_index)
			local button_click_style = widget_style[string.format("button_click_style_%d", selected_index)]
			local icon_click_style = widget_style[string.format("icon_click_%d", selected_index)]
			icon_click_style.color[1] = math.max(icon_click_style.color[1] - progress * 255, 0)
			button_click_style.color[1] = math.max(button_click_style.color[1] - progress * 255, 0)

			return 
		end,
		on_complete = function (ui_scenegraph, scenegraph_definition, widget, params)
			return 
		end
	}
}
local item_select = {
	{
		name = "item_select",
		start_progress = 0,
		end_progress = UISettings.inventory.button_bars.selected_fade_in,
		init = function (ui_scenegraph, scenegraph_definition, widget, params)
			return 
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, params)
			local catmullrom_value = (progress == 1 and 1) or math.catmullrom(progress, 1, 0.95, 1, 0.7)
			local widget_style = widget.style
			local selected_index = params.selected_index
			local button_click_style = widget_style[string.format("button_click_style_%d", selected_index)]
			local icon_click_style = widget_style[string.format("icon_click_%d", selected_index)]
			icon_click_style.color[1] = math.max(progress * 255, 0)
			button_click_style.color[1] = math.max(progress * 255, 0)

			return 
		end,
		on_complete = function (ui_scenegraph, scenegraph_definition, widget, params)
			return 
		end
	}
}
local item_deselect = {
	{
		name = "item_deselect",
		start_progress = 0,
		end_progress = UISettings.inventory.button_bars.selected_fade_out,
		init = function (ui_scenegraph, scenegraph_definition, widget, params)
			return 
		end,
		update = function (ui_scenegraph, scenegraph_definition, widget, progress, params)
			local catmullrom_value = (progress == 1 and 1) or math.catmullrom(progress, 1, 0.95, 1, 0.7)
			local widget_style = widget.style
			local selected_index = params.selected_index
			local button_click_style = widget_style[string.format("button_click_style_%d", selected_index)]
			local icon_click_style = widget_style[string.format("icon_click_%d", selected_index)]
			icon_click_style.color[1] = math.max((1 - progress) * 255, 0)
			button_click_style.color[1] = math.max((1 - progress) * 255, 0)

			return 
		end,
		on_complete = function (ui_scenegraph, scenegraph_definition, widget, params)
			return 
		end
	}
}

return {
	item_select = item_select,
	item_deselect = item_deselect,
	bar_item_select = bar_item_select,
	bar_item_deselect = bar_item_deselect,
	animate_style_on_select = animate_style_on_select
}
