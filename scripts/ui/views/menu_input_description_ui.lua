local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.controller_description
		},
		size = {
			1920,
			1080
		}
	},
	screen = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			0
		}
	},
	input_description_field = {
		vertical_alignment = "bottom",
		parent = "screen",
		horizontal_alignment = "center",
		position = {
			0,
			30,
			1
		},
		size = {
			1800,
			80
		}
	}
}

local function sort_input_actions(a, b)
	return a.priority < b.priority
end

local function create_input_description_widgets(amount)
	local input_description_widgets = {}

	for i = 1, amount, 1 do
		local scenegraph_root_id = "input_description_root_" .. i
		local scenegraph_id = "input_description_" .. i
		local scenegraph_icon_id = "input_description_icon_" .. i
		local scenegraph_text_id = "input_description_text_" .. i
		scenegraph_definition[scenegraph_root_id] = {
			vertical_alignment = "center",
			parent = "input_description_field",
			horizontal_alignment = "left",
			size = {
				1,
				1
			},
			position = {
				0,
				0,
				1
			}
		}
		scenegraph_definition[scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = scenegraph_root_id,
			size = {
				200,
				40
			},
			position = {
				0,
				0,
				1
			}
		}
		scenegraph_definition[scenegraph_icon_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = scenegraph_id,
			size = {
				40,
				40
			},
			position = {
				0,
				0,
				1
			}
		}
		scenegraph_definition[scenegraph_text_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = scenegraph_icon_id,
			size = {
				400,
				40
			},
			position = {
				40,
				1,
				1
			}
		}
		local widget_definition = {
			element = {
				passes = {
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text"
					},
					{
						pass_type = "texture",
						style_id = "icon",
						texture_id = "icon"
					}
				}
			},
			content = {
				text = "",
				icon = "xbone_button_icon_a"
			},
			style = {
				text = {
					font_size = 24,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "left",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						0,
						1
					},
					scenegraph_id = scenegraph_text_id
				},
				icon = {
					scenegraph_id = scenegraph_icon_id
				}
			},
			scenegraph_id = scenegraph_id
		}
		input_description_widgets[#input_description_widgets + 1] = UIWidget.init(widget_definition)
	end

	return input_description_widgets
end

MenuInputDescriptionUI = class(MenuInputDescriptionUI)
MenuInputDescriptionUI.init = function (self, ingame_ui_context, ui_renderer, input_service, number_of_elements, layer, generic_actions)
	self.clear_input_descriptions(self)

	self.input_service = input_service
	self.ui_renderer = ui_renderer
	self.generic_actions = generic_actions
	scenegraph_definition.root.position[3] = layer + 10 or UILayer.controller_description

	self.create_ui_elements(self, ui_renderer, number_of_elements)

	return 
end
MenuInputDescriptionUI.create_ui_elements = function (self, ui_renderer, number_of_elements)
	self.console_input_description_widgets = create_input_description_widgets(number_of_elements or 4)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)

	UIRenderer.clear_scenegraph_queue(ui_renderer)

	return 
end
MenuInputDescriptionUI.draw = function (self, dt)
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_service
	local ui_renderer = self.ui_renderer

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	local number_of_descriptions_in_use = self.number_of_descriptions_in_use
	local console_description_widgets = self.console_input_description_widgets

	if number_of_descriptions_in_use then
		for i = 1, number_of_descriptions_in_use, 1 do
			UIRenderer.draw_widget(ui_renderer, console_description_widgets[i])
		end
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
MenuInputDescriptionUI.destroy = function (self)
	return 
end
MenuInputDescriptionUI.change_generic_actions = function (self, new_generic_actions)
	self.generic_actions = new_generic_actions

	self.set_input_description(self, self.current_console_selection_data)

	return 
end
MenuInputDescriptionUI.setup_console_widget_selections = function (self)
	local steppers = self.steppers
	local console_widget_selections = {
		{
			name = "difficulty",
			gamepad_support = true,
			widget = steppers.difficulty.widget,
			actions = {
				{
					hotspot_id = "left_button_hotspot",
					input_action = "move_left",
					description_text = "input_description_previous"
				},
				{
					hotspot_id = "right_button_hotspot",
					input_action = "move_right",
					description_text = "input_description_next"
				}
			}
		},
		{
			name = "privacy",
			gamepad_support = true,
			widget = steppers.privacy.widget,
			actions = {
				{
					hotspot_id = "left_button_hotspot",
					input_action = "move_left",
					description_text = "input_description_previous"
				},
				{
					hotspot_id = "right_button_hotspot",
					input_action = "move_right",
					description_text = "input_description_next"
				}
			}
		},
		{
			name = "level",
			gamepad_support = true,
			widget = steppers.level.widget,
			actions = {
				{
					hotspot_id = "left_button_hotspot",
					input_action = "move_left",
					description_text = "input_description_previous"
				},
				{
					hotspot_id = "right_button_hotspot",
					input_action = "move_right",
					description_text = "input_description_next"
				}
			}
		},
		{
			name = "play_button",
			gamepad_support = false,
			widget = self.play_button_console_widget,
			actions = {
				{
					hotspot_id = "button_hotspot",
					input_action = "confirm",
					description_text = "input_description_confirm"
				}
			}
		},
		{
			name = "quickmatch_button",
			gamepad_support = false,
			widget = self.quickmatch_button_console_widget,
			actions = {
				{
					hotspot_id = "button_hotspot",
					input_action = "confirm",
					description_text = "input_description_confirm"
				}
			}
		}
	}

	return console_widget_selections
end
MenuInputDescriptionUI.set_input_description = function (self, console_selection_data)
	self.clear_input_descriptions(self)

	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local console_input_description_widgets = self.console_input_description_widgets
	local number_of_descriptions = #console_input_description_widgets
	local spacing = 80
	local widgets_width_list = {}
	local total_width = 0
	local widget_use_index = 0
	self.current_console_selection_data = console_selection_data
	local actions = (console_selection_data and console_selection_data.actions and table.clone(console_selection_data.actions)) or {}
	local ignore_generic_actions = console_selection_data and console_selection_data.ignore_generic_actions

	if not ignore_generic_actions then
		local generic_actions = self.generic_actions

		if generic_actions then
			for _, action_data in ipairs(generic_actions) do
				actions[#actions + 1] = action_data
			end
		end
	end

	table.sort(actions, sort_input_actions)

	for _, action_data in pairs(actions) do
		local input_action = action_data.input_action
		local description_text = action_data.description_text
		local ignore_keybinding = action_data.ignore_keybinding

		if description_text then
			widget_use_index = widget_use_index + 1
			description_text = Localize(description_text)
			local action_texture_data = self.get_gamepad_input_texture_data(self, input_action, ignore_keybinding)
			local description_widget = console_input_description_widgets[widget_use_index]
			local widget_content = description_widget.content
			local widget_style = description_widget.style
			local scenegraph_id = "input_description_" .. widget_use_index
			local scenegraph_icon_id = "input_description_icon_" .. widget_use_index
			local scenegraph_text_id = "input_description_text_" .. widget_use_index
			local action_texture_size = action_texture_data.size
			ui_scenegraph[scenegraph_icon_id].size = action_texture_size
			ui_scenegraph[scenegraph_text_id].local_position[1] = action_texture_size[1]
			widget_content.icon = action_texture_data.texture
			description_text = " " .. description_text
			widget_content.text = description_text
			local text_style = widget_style.text
			local font, scaled_font_size = UIFontByResolution(text_style)
			local text_width, text_height, min = UIRenderer.text_size(ui_renderer, description_text, font[1], scaled_font_size)
			local widget_length = action_texture_size[1] + text_width
			ui_scenegraph[scenegraph_id].local_position[1] = -widget_length/2
			total_width = total_width + widget_length + spacing
			widgets_width_list[widget_use_index] = widget_length
		end
	end

	total_width = total_width - spacing
	local parent_width = ui_scenegraph.input_description_field.size[1]
	local widget_start_position = parent_width/2 - total_width/2

	for i = 1, widget_use_index, 1 do
		local widget_width = widgets_width_list[i]
		local new_x = widget_start_position + widget_width/2
		local scenegraph_root_id = "input_description_root_" .. i
		ui_scenegraph[scenegraph_root_id].local_position[1] = new_x
		widget_start_position = new_x + widget_width/2 + spacing
	end

	self.number_of_descriptions_in_use = (widget_use_index ~= 0 and widget_use_index) or nil

	return 
end
MenuInputDescriptionUI.clear_input_descriptions = function (self)
	self.number_of_descriptions_in_use = nil

	return 
end
MenuInputDescriptionUI.get_gamepad_input_texture_data = function (self, input_action, ignore_keybinding)
	local platform = Application.platform()

	if ignore_keybinding then
		if platform == "win32" then
			platform = "xb1"
		end

		return ButtonTextureByName(input_action, platform)
	else
		local input_service = self.input_service
		local keymap_bindings = input_service.get_keymapping(input_service, input_action)
		local input_mappings = keymap_bindings.input_mappings

		for i = 1, #input_mappings, 1 do
			local input_mapping = input_mappings[i]

			for j = 1, input_mapping.n, 3 do
				local device_type = input_mapping[j]
				local key_index = input_mapping[j + 1]
				local key_action_type = input_mapping[j + 2]

				if device_type == "gamepad" then
					local button_name = Pad1.button_name(key_index)
					local button_texture_data = nil

					if platform == "xb1" or platform == "win32" then
						button_texture_data = ButtonTextureByName(button_name, "xb1")
					else
						button_texture_data = ButtonTextureByName(button_name, "ps4")
					end

					return button_texture_data, button_name
				end
			end
		end
	end

	return 
end

return 