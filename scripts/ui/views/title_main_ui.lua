local scenegraph = {
	root = {
		is_root = true,
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
	input_root = {
		parent = "root",
		position = {
			960,
			225,
			0
		},
		size = {
			1,
			1
		}
	},
	background = {
		parent = "root",
		horizontal_alignment = "left",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			99
		}
	},
	splash_video = {
		parent = "background",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			700
		}
	},
	input = {
		vertical_alignment = "bottom",
		parent = "input_root",
		position = {
			0,
			0,
			1
		},
		size = {
			200,
			40
		}
	},
	input_text = {
		vertical_alignment = "center",
		parent = "input",
		size = {
			600,
			62
		},
		position = {
			0,
			0,
			2
		}
	},
	input_prefix_text = {
		vertical_alignment = "center",
		parent = "input_icon",
		horizontal_alignment = "left",
		size = {
			300,
			62
		},
		position = {
			-300,
			0,
			2
		}
	},
	input_icon = {
		vertical_alignment = "center",
		parent = "input",
		horizontal_alignment = "left",
		size = {
			62,
			62
		},
		position = {
			0,
			0,
			1
		}
	}
}
local attract_mode_video = {
	video_name = "video/trailer",
	sound_start = "Play_intro",
	scenegraph_id = "splash_video",
	loop = false,
	material_name = "trailer",
	sound_stop = "Stop_intro"
}
local widget_definitions = {
	input = {
		scenegraph_id = "input",
		element = {
			passes = {
				{
					texture_id = "icon_textures",
					style_id = "icon_styles",
					pass_type = "multi_texture"
				},
				{
					style_id = "button_text",
					pass_type = "text",
					text_id = "button_text",
					content_check_function = function (content)
						return content.text ~= ""
					end
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text",
					content_check_function = function (content)
						return content.text
					end
				},
				{
					style_id = "prefix_text",
					pass_type = "text",
					text_id = "prefix_text",
					content_check_function = function (content)
						return content.text
					end
				}
			}
		},
		content = {
			text = "input_text",
			prefix_text = "",
			button_text = "",
			icon_textures = {
				"button_win32_left"
			}
		},
		style = {
			prefix_text = {
				scenegraph_id = "input_prefix_text",
				font_size = 36,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "right",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					3,
					1
				}
			},
			text = {
				scenegraph_id = "input_text",
				font_size = 36,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					3,
					1
				}
			},
			button_text = {
				font_size = 24,
				scenegraph_id = "input_icon",
				horizontal_alignment = "center",
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					2,
					2
				}
			},
			icon_styles = {
				scenegraph_id = "input_icon",
				texture_sizes = {
					{
						20,
						36
					}
				},
				offset = {
					0,
					0,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	}
}
TitleMainUI = class(TitleMainUI)
TitleMainUI.init = function (self, world)
	self._world = world
	self.ui_renderer = UIRenderer.create(self._world, "material", "materials/fonts/arial", "material", "materials/fonts/hell_shark_font", "material", "materials/fonts/gw_fonts", "material", "materials/ui/ui_1080p_title_screen", "material", attract_mode_video.video_name)

	UISetupFontHeights(self.ui_renderer.gui)

	self.input_manager = Managers.input

	self.input_manager:create_input_service("title_screen", TitleScreenKeyMaps)
	self.input_manager:map_device_to_service("title_screen", "keyboard")
	self.input_manager:map_device_to_service("title_screen", "gamepad")

	self.ui_animations = {}

	self._create_ui_elements(self)

	return 
end
TitleMainUI._create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph)
	self.input_widget = UIWidget.init(widget_definitions.input)
	self.attract_video = UIWidget.init(UIWidgets.create_splash_video(attract_mode_video))

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self.set_input_text(self)

	local input_widget_style = self.input_widget.style
	self.ui_animations.button_text_pulse = UIAnimation.init(UIAnimation.pulse_animation, input_widget_style.button_text.text_color, 1, 100, 255, 2)
	self.ui_animations.button_texture_pulse = UIAnimation.init(UIAnimation.pulse_animation, input_widget_style.icon_styles.color, 1, 100, 255, 2)
	self.ui_animations.text_pulse = UIAnimation.init(UIAnimation.pulse_animation, input_widget_style.text.text_color, 1, 100, 255, 2)
	self.ui_animations.prefix_text_pulse = UIAnimation.init(UIAnimation.pulse_animation, input_widget_style.prefix_text.text_color, 1, 100, 255, 2)

	return 
end
TitleMainUI.update = function (self, dt)
	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil
		end
	end

	local input_service = self.input_manager:get_service("title_screen")

	if input_service.get(input_service, "start") then
		self._start_pressed = true
	else
		self._start_pressed = false
	end

	if input_service.has(input_service, "delete_save") and input_service.get(input_service, "delete_save") then
		StateTitleScreenLoadSave.DELETE_SAVE = true
	end

	self.draw(self, dt)

	return 
end
TitleMainUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("title_screen")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.input_widget)

	if self._destroy_video_player then
		UIRenderer.destroy_video_player(self.ui_renderer)

		self._destroy_video_player = nil
	elseif self._attract_mode_enabled then
		if not self.attract_video.content.video_completed then
			if not ui_renderer.video_player then
				UIRenderer.create_video_player(self.ui_renderer, self._world, attract_mode_video.video_name, attract_mode_video.loop)
			else
				if not self._sound_started then
					if attract_mode_video.sound_start then
						Managers.music:trigger_event(attract_mode_video.sound_start)
					end

					self._sound_started = true
				end

				UIRenderer.draw_widget(ui_renderer, self.attract_video)
			end
		elseif ui_renderer.video_player then
			UIRenderer.destroy_video_player(self.ui_renderer)

			self._sound_started = false

			if attract_mode_video.sound_stop then
				Managers.music:trigger_event(attract_mode_video.sound_stop)
			end
		end
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
TitleMainUI.destroy = function (self)
	GarbageLeakDetector.register_object(self, "TitleMainUI")
	UIRenderer.destroy(self.ui_renderer, self._world)

	return 
end
TitleMainUI.set_input_text = function (self, optinal_text)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local widget = self.input_widget
	local widget_content = widget.content
	local widget_style = widget.style
	local text = ""
	local prefix_text = ""
	local button_text = ""
	local button_texture_data = nil

	if not optinal_text then
		local interact_action = "start"
		button_texture_data, button_text = self.button_texture_data_by_input_action(self, interact_action)

		assert(button_texture_data, "Could not find button texture(s) for action: start")

		text = Localize("to_start_game")
		prefix_text = Localize("interaction_prefix_press")
	else
		text = optinal_text
		prefix_text = ""
	end

	local texture_size_x = 0
	local texture_size_y = 0

	if button_texture_data then
		if button_texture_data.texture then
			widget_content.button_text = ""
			widget_content.icon_textures = {
				button_texture_data.texture
			}
			widget_style.icon_styles.texture_sizes = {
				button_texture_data.size
			}
			texture_size_x = button_texture_data.size[1]
			texture_size_y = button_texture_data.size[2]
		else
			local textures = {}
			local sizes = {}
			local tile_sizes = {}
			local button_text_style = widget_style.button_text
			local font, scaled_font_size = UIFontByResolution(button_text_style)
			local text_width, text_height, min = UIRenderer.text_size(ui_renderer, button_text, font[1], scaled_font_size)

			for i = 1, #button_texture_data, 1 do
				textures[i] = button_texture_data[i].texture
				sizes[i] = button_texture_data[i].size

				if button_texture_data[i].tileable then
					tile_sizes[i] = {
						text_width,
						sizes[i][2]
					}
					texture_size_x = texture_size_x + text_width

					if texture_size_y < sizes[i][2] then
						if not sizes[i][2] then
						end
					end
				else
					texture_size_x = texture_size_x + sizes[i][1]

					if texture_size_y < sizes[i][2] and not sizes[i][2] then
					end
				end
			end

			widget_content.icon_textures = textures
			widget_content.button_text = button_text
			widget_style.icon_styles.texture_sizes = sizes
			widget_style.icon_styles.tile_sizes = tile_sizes
		end

		ui_scenegraph.input_text.local_position[1] = texture_size_x
		ui_scenegraph.input_icon.size[1] = texture_size_x
		ui_scenegraph.input_icon.size[2] = texture_size_y
	else
		widget_content.icon_textures = {}
		widget_content.button_text = ""
		widget_content.prefix_text = ""
		ui_scenegraph.input_text.local_position[1] = 0
	end

	local text_style = widget_style.text
	local text_width, scaled_font_size = self.get_text_width(self, text_style, text)
	local prefix_text_width = self.get_text_width(self, widget_style.prefix_text, prefix_text)
	widget_content.text = text
	widget_content.prefix_text = prefix_text
	ui_scenegraph.input_text.position[2] = (scaled_font_size == text_style.font_size and 3) or 0
	ui_scenegraph.input_prefix_text.position[2] = ui_scenegraph.input_text.position[2]
	ui_scenegraph.input.position[1] = -((text_width + texture_size_x)*0.5) + prefix_text_width

	return 
end
TitleMainUI.get_text_width = function (self, text_style, text)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local width, height, min = UIRenderer.text_size(self.ui_renderer, text, font[1], scaled_font_size)

	return width, scaled_font_size
end
TitleMainUI.button_texture_data_by_input_action = function (self, input_action)
	local platform = Application.platform()
	local active_devices, active_platform = nil
	local input_manager = self.input_manager
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	if platform == "ps4" or platform == "xb1" then
		active_devices = {
			"gamepad"
		}
		active_platform = platform
	elseif platform == "win32" then
		if gamepad_active then
			active_devices = {
				"gamepad"
			}
			active_platform = "xb1"
		else
			active_devices = {
				"keyboard",
				"mouse"
			}
			active_platform = platform
		end
	end

	local input_service = input_manager.get_service(input_manager, "title_screen")
	local keymap_bindings = input_service.get_keymapping(input_service, input_action)
	local input_mappings = keymap_bindings.input_mappings
	local button_texture_data, button_text = nil

	for i = 1, #input_mappings, 1 do
		local input_mapping = input_mappings[i]

		for j = 1, input_mapping.n, 3 do
			local device_type = input_mapping[j]
			local key_index = input_mapping[j + 1]
			local key_action_type = input_mapping[j + 2]

			for k = 1, #active_devices, 1 do
				local active_device = active_devices[k]

				if device_type == active_device then
					if active_device == "keyboard" then
						button_texture_data = ButtonTextureByName(nil, active_platform)
						button_text = Keyboard.button_name(key_index)
					elseif active_device == "mouse" then
						button_texture_data = ButtonTextureByName(nil, active_platform)
						button_text = Mouse.button_name(key_index)
					else
						local button_name = Pad1.button_name(key_index)
						button_texture_data = ButtonTextureByName(button_name, active_platform)
					end

					return button_texture_data, button_text
				end
			end
		end
	end

	return 
end
TitleMainUI.should_start = function (self)
	return self._start_pressed
end
TitleMainUI.enter_attract_mode = function (self)
	self._attract_mode_enabled = true
	self.attract_video.content.video_content.video_completed = false

	return 
end
TitleMainUI.exit_attract_mode = function (self)
	self._attract_mode_enabled = false
	self._destroy_video_player = true

	return 
end
TitleMainUI.video_completed = function (self)
	return self.attract_video.content.video_content.video_completed
end
TitleMainUI.attract_mode = function (self)
	return self._attract_mode_enabled
end

return 
