require("scripts/settings/controller_settings")

local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			0
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
		position = {
			0,
			0,
			0
		},
		size = {
			1920,
			1080
		}
	},
	dead_space_filler = {
		scale = "fit",
		position = {
			0,
			0,
			0
		},
		size = {
			1920,
			1080
		}
	},
	loading_background = {
		parent = "root",
		horizontal_alignment = "left",
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
	skip_input = {
		vertical_alignment = "bottom",
		parent = "root",
		horizontal_alignment = "left",
		position = {
			0,
			15,
			500
		}
	},
	skip_input_text_1 = {
		vertical_alignment = "bottom",
		parent = "skip_input",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			30,
			2,
			5
		}
	},
	skip_input_text_2 = {
		vertical_alignment = "bottom",
		parent = "skip_input",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			2,
			5
		}
	},
	skip_input_text_3 = {
		vertical_alignment = "bottom",
		parent = "skip_input",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			110,
			0,
			5
		}
	},
	skip_input_icon = {
		vertical_alignment = "bottom",
		parent = "skip_input",
		horizontal_alignment = "left",
		size = {
			30,
			30
		},
		position = {
			0,
			10,
			5
		}
	},
	skip_input_icon_bar = {
		vertical_alignment = "center",
		parent = "skip_input_icon",
		horizontal_alignment = "center",
		size = {
			36,
			36
		},
		position = {
			0,
			0,
			-1
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
			501
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
			1
		}
	},
	gamma_background = {
		vertical_alignment = "center",
		parent = "screen",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			501
		},
		size = {
			1920,
			1080
		}
	},
	gamma_slider = {
		vertical_alignment = "bottom",
		parent = "gamma_background",
		horizontal_alignment = "right",
		position = {
			-147,
			305,
			10
		},
		size = {
			255,
			30
		}
	},
	gamma_image = {
		vertical_alignment = "top",
		parent = "gamma_background",
		horizontal_alignment = "left",
		position = {
			0,
			0,
			-10
		},
		size = {
			1398,
			891
		}
	},
	gamma_correction_image = {
		vertical_alignment = "top",
		parent = "gamma_background",
		horizontal_alignment = "right",
		position = {
			-44,
			-171,
			10
		},
		size = {
			428,
			528
		}
	},
	gamma_header_text = {
		vertical_alignment = "top",
		parent = "gamma_background",
		horizontal_alignment = "right",
		position = {
			-30,
			-35,
			10
		},
		size = {
			450,
			40
		}
	},
	gamma_info_text = {
		vertical_alignment = "bottom",
		parent = "gamma_background",
		horizontal_alignment = "left",
		position = {
			55,
			35,
			10
		},
		size = {
			1300,
			105
		}
	},
	apply_button = {
		vertical_alignment = "bottom",
		parent = "gamma_background",
		horizontal_alignment = "right",
		position = {
			-95,
			45,
			10
		},
		size = {
			318,
			84
		}
	},
	console_input_text_1 = {
		vertical_alignment = "bottom",
		parent = "gamma_background",
		horizontal_alignment = "right",
		position = {
			-110,
			85,
			10
		},
		size = {
			300,
			40
		}
	},
	console_input_icon_root_1 = {
		vertical_alignment = "center",
		parent = "console_input_text_1",
		horizontal_alignment = "left",
		position = {
			-25,
			0,
			1
		},
		size = {
			0,
			0
		}
	},
	console_input_icon_1 = {
		vertical_alignment = "center",
		parent = "console_input_icon_root_1",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			40,
			40
		}
	},
	console_input_text_2 = {
		vertical_alignment = "center",
		parent = "console_input_text_1",
		horizontal_alignment = "left",
		position = {
			0,
			-50,
			1
		},
		size = {
			300,
			40
		}
	},
	console_input_icon_root_2 = {
		vertical_alignment = "center",
		parent = "console_input_text_2",
		horizontal_alignment = "left",
		position = {
			-25,
			0,
			1
		},
		size = {
			0,
			0
		}
	},
	console_input_icon_2 = {
		vertical_alignment = "center",
		parent = "console_input_icon_root_2",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			40,
			40
		}
	}
}

local function create_button_textures()
	local button_texture_data = ButtonTextureByName(nil, "win32")
	local textures = {}

	for i = 1, #button_texture_data, 1 do
		textures[i] = button_texture_data[i].texture
	end

	return textures
end

skip_widget = {
	scenegraph_id = "skip_input",
	element = {
		passes = {
			{
				texture_id = "icon_textures",
				style_id = "keyboard_input_icon",
				pass_type = "multi_texture",
				content_check_function = function (content)
					return not content.input_icon
				end
			},
			{
				style_id = "input_text_1",
				pass_type = "text",
				text_id = "input_text_1"
			},
			{
				style_id = "input_text_2",
				pass_type = "text",
				text_id = "input_text_2"
			},
			{
				style_id = "input_text_3",
				pass_type = "text",
				text_id = "input_text_3",
				content_check_function = function (content)
					return not content.input_icon
				end
			},
			{
				pass_type = "texture",
				style_id = "input_icon",
				texture_id = "input_icon",
				content_check_function = function (content)
					return content.input_icon
				end
			},
			{
				pass_type = "gradient_mask_texture",
				style_id = "input_icon_bar",
				texture_id = "input_icon_bar",
				content_check_function = function (content)
					return not content.using_keyboard
				end
			},
			{
				style_id = "hold_bar",
				pass_type = "rect",
				content_check_function = function (content)
					return content.using_keyboard
				end
			}
		}
	},
	content = {
		input_icon_bar = "controller_hold_bar",
		input_text_3 = "",
		using_keyboard = true,
		input_text_1 = "",
		icon_textures = create_button_textures(),
		input_text_2 = Localize("to_skip")
	},
	style = {
		hold_bar = {
			scenegraph_id = "skip_input_icon",
			color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				3,
				-12,
				0
			},
			size = {
				0,
				8
			}
		},
		keyboard_input_icon = {
			scenegraph_id = "skip_input_icon",
			horizontal_alignment = "right",
			vertical_alignment = "bottom",
			tile_sizes = {
				[2] = {
					8,
					36
				}
			},
			texture_sizes = {
				{
					20,
					36
				},
				{
					8,
					36
				},
				{
					20,
					36
				}
			},
			offset = {
				0,
				-5,
				0
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		input_icon = {
			scenegraph_id = "skip_input_icon",
			color = {
				255,
				255,
				255,
				255
			}
		},
		input_icon_bar = {
			scenegraph_id = "skip_input_icon_bar",
			gradient_threshold = 0,
			color = {
				255,
				255,
				255,
				255
			}
		},
		input_text_1 = {
			scenegraph_id = "skip_input_text_1",
			font_size = 36,
			word_wrap = false,
			pixel_perfect = true,
			horizontal_alignment = "right",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255)
		},
		input_text_2 = {
			scenegraph_id = "skip_input_text_2",
			font_size = 36,
			word_wrap = false,
			pixel_perfect = true,
			horizontal_alignment = "left",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255)
		},
		input_text_3 = {
			scenegraph_id = "skip_input_text_3",
			word_wrap = false,
			font_size = 24,
			pixel_perfect = true,
			horizontal_alignment = "right",
			vertical_alignment = "bottom",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255),
			offset = {
				0,
				5,
				0
			}
		}
	}
}
local dead_space_filler_widget = {
	scenegraph_id = "dead_space_filler",
	element = {
		passes = {
			{
				pass_type = "rect"
			}
		}
	},
	content = {},
	style = {
		color = {
			255,
			0,
			0,
			0
		}
	}
}
local gamma_adjuster_definition = {
	scenegraph_id = "gamma_slider",
	element = {
		passes = {
			{
				pass_type = "texture",
				style_id = "background_texture",
				texture_id = "background_texture"
			},
			{
				pass_type = "texture",
				style_id = "frame",
				texture_id = "frame"
			},
			{
				pass_type = "texture",
				style_id = "frame_bg",
				texture_id = "frame_bg"
			},
			{
				style_id = "slider_box",
				pass_type = "hotspot",
				content_id = "hotspot"
			},
			{
				style_id = "slider_box",
				content_check_hover = "hotspot",
				pass_type = "held",
				held_function = function (ui_scenegraph, ui_style, ui_content, input_service)
					local cursor = UIInverseScaleVectorToResolution(input_service.get(input_service, "cursor"))
					local scenegraph_id = ui_content.scenegraph_id
					local world_position = UISceneGraph.get_world_position(ui_scenegraph, scenegraph_id)
					local size_x = ui_style.size[1]
					local cursor_x = cursor[1]
					local pos_start = world_position[1] + ui_style.offset[1]
					local old_value = ui_content.internal_value
					local cursor_x_norm = cursor_x - pos_start
					local value = math.clamp(cursor_x_norm/size_x, 0, 1)
					ui_content.internal_value = value

					if old_value ~= value then
						ui_content.changed = true
					end

					return 
				end
			},
			{
				pass_type = "local_offset",
				offset_function = function (ui_scenegraph, ui_style, ui_content)
					local internal_value = ui_content.internal_value
					local min = ui_content.min
					local max = ui_content.max
					local real_value = math.round_with_precision(min + (max - min)*internal_value, ui_content.num_decimals or 0)
					ui_content.value = real_value
					ui_content.value_text = real_value
					local slider_box_style = ui_style.slider_box
					local slider_style = ui_style.slider
					local size_x = slider_box_style.size[1]*internal_value
					slider_style.size[1] = size_x
					local slider_content = ui_content.slider
					slider_content.uvs[2][1] = internal_value
					local base_offset_x = slider_style.offset[1]
					local slider_icon_style = ui_style.slider_icon
					slider_icon_style.offset[1] = (base_offset_x + size_x) - slider_icon_style.size[1]/2

					if ui_content.hotspot.is_hover or ui_content.altering_value then
						ui_style.value_text.text_color = ui_style.value_text.hover_color
					else
						ui_style.value_text.text_color = ui_style.value_text.default_color
					end

					return 
				end
			},
			{
				style_id = "value_text",
				pass_type = "text",
				text_id = "value_text"
			},
			{
				pass_type = "texture_uv",
				style_id = "slider",
				texture_id = "texture",
				content_id = "slider"
			},
			{
				pass_type = "texture",
				style_id = "slider_icon",
				texture_id = "slider_icon"
			},
			{
				pass_type = "texture",
				style_id = "gamma_image",
				texture_id = "gamma_image"
			},
			{
				pass_type = "texture",
				style_id = "gamma_correction_image",
				texture_id = "gamma_correction_image"
			},
			{
				style_id = "gamma_header_text",
				pass_type = "text",
				text_id = "gamma_header_text"
			},
			{
				style_id = "gamma_info_text",
				pass_type = "text",
				text_id = "gamma_info_text"
			},
			{
				pass_type = "texture",
				style_id = "gamepad_navigation_icon",
				texture_id = "gamepad_navigation_icon",
				content_check_function = function (content)
					return content.gamepad_active
				end
			},
			{
				pass_type = "texture",
				style_id = "gamepad_accept_icon",
				texture_id = "gamepad_accept_icon",
				content_check_function = function (content)
					return content.gamepad_active
				end
			},
			{
				style_id = "gamepad_navigation_text",
				pass_type = "text",
				text_id = "gamepad_navigation_text",
				content_check_function = function (content)
					return content.gamepad_active
				end
			},
			{
				style_id = "gamepad_accept_text",
				pass_type = "text",
				text_id = "gamepad_accept_text",
				content_check_function = function (content)
					return content.gamepad_active
				end
			}
		}
	},
	content = {
		mask_texture = "mask_rect",
		scenegraph_id = "gamma_slider",
		num_decimals = 1,
		internal_value = 0.5,
		frame = "gamma_slider_frame",
		frame_bg = "gamma_slider_frame_bg",
		min = 1.5,
		slider_icon = "gamma_slider_skull_icon",
		max = 5,
		gamma_header_text = "menu_gamma_settings",
		gamepad_navigation_icon = "xbone_button_icon_a",
		gamma_image = "gamma_settings_image_01",
		value = 0.5,
		gamma_correction_image = "gamma_settings_image_02",
		gamma_info_text = "menu_gamma_settings_info",
		gamepad_accept_icon = "xbone_button_icon_a",
		background_texture = "gamma_settings_frame",
		gamepad_accept_text = "- " .. Localize("input_description_confirm"),
		gamepad_navigation_text = "- " .. Localize("input_description_change"),
		hotspot = {},
		slider = {
			texture = "gamma_slider_frame_fill",
			uvs = {
				{
					0,
					0
				},
				{
					1,
					1
				}
			}
		}
	},
	style = {
		gamepad_accept_icon = {
			scenegraph_id = "console_input_icon_2"
		},
		gamepad_navigation_icon = {
			scenegraph_id = "console_input_icon_1"
		},
		gamepad_navigation_text = {
			vertical_alignment = "center",
			scenegraph_id = "console_input_text_1",
			localize = false,
			font_size = 22,
			horizontal_alignment = "left",
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255)
		},
		gamepad_accept_text = {
			vertical_alignment = "center",
			scenegraph_id = "console_input_text_2",
			localize = false,
			font_size = 22,
			horizontal_alignment = "left",
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 255)
		},
		background_texture = {
			scenegraph_id = "gamma_background"
		},
		frame = {
			offset = {
				0,
				10,
				11
			},
			size = {
				210,
				20
			}
		},
		frame_bg = {
			offset = {
				0,
				10,
				1
			},
			size = {
				210,
				20
			}
		},
		slider_box = {
			offset = {
				5,
				5,
				10
			},
			size = {
				200,
				30
			},
			color = {
				50,
				255,
				255,
				255
			}
		},
		value_text = {
			horizontal_alignment = "right",
			localize = false,
			font_size = 24,
			dynamic_font = true,
			font_type = "hell_shark",
			offset = {
				24,
				3,
				0
			},
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			default_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			hover_color = Colors.get_color_table_with_alpha("white", 255)
		},
		slider = {
			offset = {
				5,
				16,
				10
			},
			size = {
				200,
				8
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		slider_icon = {
			offset = {
				0,
				5,
				15
			},
			size = {
				30,
				30
			}
		},
		gamma_image = {
			scenegraph_id = "gamma_image",
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				0,
				0
			}
		},
		gamma_correction_image = {
			scenegraph_id = "gamma_correction_image",
			color = {
				255,
				255,
				255,
				255
			}
		},
		gamma_header_text = {
			vertical_alignment = "center",
			dynamic_font = true,
			localize = true,
			horizontal_alignment = "center",
			font_size = 35,
			font_type = "hell_shark",
			scenegraph_id = "gamma_header_text",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
		},
		gamma_info_text = {
			font_size = 24,
			scenegraph_id = "gamma_info_text",
			localize = true,
			word_wrap = true,
			horizontal_alignment = "center",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
		}
	}
}
local done_button = UIWidgets.create_menu_button("menu_settings_done", "apply_button")
first_time_video = {
	video_name = "video/trailer",
	sound_start = "Play_trailer_sfx",
	scenegraph_id = "splash_video",
	material_name = "trailer",
	sound_stop = "Stop_trailer_sfx"
}

local function get_slider_value(min, max, value)
	local range = max - min
	local norm_value = math.clamp(value, min, max) - min

	return norm_value/range
end

TitleLoadingUI = class(TitleLoadingUI)
TitleLoadingUI.init = function (self, world, params, force_done)
	if Application.platform() == "win32" then
		Application.set_time_step_policy("no_smoothing", "clear_history", "throttle", 60)
	end

	self.render_settings = {
		snap_pixel_positions = true
	}
	self._world = world
	self._done = false
	self._force_done = force_done
	self._gamma_done = false
	self._needs_cursor_pop = false
	self._current_inputs = {}
	self._gamma = params.gamma
	self._trailer = params.trailer

	if not self._trailer then
		self._done = true
	end

	Managers.input:create_input_service("title_loading_ui", "TitleLoadingKeyMaps", "TitleLoadingFilters")
	Managers.input:map_device_to_service("title_loading_ui", "keyboard")
	Managers.input:map_device_to_service("title_loading_ui", "mouse")
	Managers.input:map_device_to_service("title_loading_ui", "gamepad")
	self._setup_gui(self)

	return 
end
TitleLoadingUI._setup_gui = function (self)
	self._ui_renderer = UIRenderer.create(self._world, "material", "materials/ui/ui_1080p_splash_screen", "material", "materials/ui/ui_1080p_title_screen", "material", "video/trailer", "material", "materials/fonts/gw_fonts")

	self._create_elements(self)

	return 
end
TitleLoadingUI._create_elements = function (self)
	self._ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._video_widget = UIWidget.init(UIWidgets.create_splash_video(first_time_video))
	self._skip_widget = UIWidget.init(skip_widget)
	self._dead_space_filler_widget = UIWidget.init(dead_space_filler_widget)
	self._done_button = UIWidget.init(done_button)

	if self._gamma then
		ShowCursorStack.push()

		self._needs_cursor_pop = true
		local gamma_adjuster = UIWidget.init(gamma_adjuster_definition)
		self._gamma_adjuster = gamma_adjuster

		self.setup_gamma_menu(self)
	else
		self._gamma_done = true
	end

	DO_RELOAD = false

	return 
end
DO_RELOAD = true
TitleLoadingUI.setup_gamma_menu = function (self)
	local gamma_adjuster = self._gamma_adjuster
	local min = gamma_adjuster.content.min
	local max = gamma_adjuster.content.max
	local gamma = Application.user_setting("render_settings", "gamma") or 2.2
	local value = get_slider_value(min, max, gamma)
	gamma_adjuster.content.internal_value = value
	local texture_data, input_text = self._get_input_gamepad_texture_data(self, "confirm")
	gamma_adjuster.content.gamepad_accept_icon = texture_data.texture
	self._ui_scenegraph.console_input_icon_2.size[1] = texture_data.size[1]
	self._ui_scenegraph.console_input_icon_2.size[2] = texture_data.size[2]
	local platform = Application.platform()
	local texture_data, input_text = ButtonTextureByName("d_horizontal", (platform == "win32" and "xb1") or platform)
	gamma_adjuster.content.gamepad_navigation_icon = texture_data.texture
	self._ui_scenegraph.console_input_icon_1.size[1] = texture_data.size[1]
	self._ui_scenegraph.console_input_icon_1.size[2] = texture_data.size[2]

	return 
end
TitleLoadingUI.update = function (self, dt)
	if DO_RELOAD then
		self._create_elements(self)
	end

	if not self._gamma_done then
		self._update_gamma_adjuster(self, dt)
	else
		self._update_input_text(self, dt)
		self._update_input(self, dt)
	end

	self._render(self, dt)

	return 
end
TitleLoadingUI._update_gamma_adjuster = function (self, dt)
	local gamma_adjuster = self._gamma_adjuster
	local gamma_adjuster_content = gamma_adjuster.content
	local gamepad_active = Managers.input:is_device_active("gamepad")
	gamma_adjuster_content.gamepad_active = gamepad_active

	if gamepad_active then
		self._handle_gamma_gamepad_input(self, dt)
	end

	if gamma_adjuster_content.changed then
		Application.set_render_setting("gamma", gamma_adjuster_content.value)
	end

	if self._done_button.content.button_hotspot.on_release then
		self._done_button.content.button_hotspot.on_release = nil
		local gamma = gamma_adjuster_content.value

		if Application.platform() == "win32" then
			Application.set_user_setting("render_settings", "gamma", gamma)
			Application.save_user_settings()

			SaveData.gamma_corrected = true

			Managers.save:auto_save(SaveFileName, SaveData)
		elseif Application.platform() == "xb1" then
			Application.set_user_setting("render_settings", "gamma", gamma)

			SaveData.gamma_corrected = true

			Managers.save:auto_save(SaveFileName, SaveData)
		elseif Application.platform() == "ps4" then
			Application.set_user_setting("render_settings", "gamma", gamma)

			SaveData.gamma_corrected = true

			Managers.save:auto_save(SaveFileName, SaveData)
		end

		self._gamma_done = true
		self._needs_cursor_pop = false

		ShowCursorStack.pop()
	end

	return 
end
TitleLoadingUI._handle_gamma_gamepad_input = function (self, dt)
	local input_service = Managers.input:get_service("title_loading_ui")

	if input_service.get(input_service, "confirm") then
		self._done_button.content.button_hotspot.on_release = true
	else
		local gamma_adjuster = self._gamma_adjuster
		local gamma_adjuster_content = gamma_adjuster.content
		local input_cooldown = gamma_adjuster_content.input_cooldown
		local input_cooldown_multiplier = gamma_adjuster_content.input_cooldown_multiplier
		local on_cooldown_last_frame = false

		if input_cooldown then
			on_cooldown_last_frame = true
			local new_cooldown = math.max(input_cooldown - dt, 0)
			input_cooldown = (0 < new_cooldown and new_cooldown) or nil
			gamma_adjuster_content.input_cooldown = input_cooldown
		end

		local internal_value = gamma_adjuster_content.internal_value
		local num_decimals = gamma_adjuster_content.num_decimals
		local min = gamma_adjuster_content.min
		local max = gamma_adjuster_content.max
		local diff = max - min
		local total_step = diff*10^num_decimals
		local step = total_step/1
		local move = input_service.get(input_service, "analog_input")
		local analog_speed = 0.01
		local current_time = Managers.time:time("main")
		local input_been_made = false

		if input_service.get(input_service, "move_left_hold") then
			if not input_cooldown then
				gamma_adjuster_content.internal_value = math.clamp(internal_value - step, 0, 1)
				gamma_adjuster_content.last_update = current_time
				input_been_made = true
			end
		elseif input_service.get(input_service, "move_right_hold") then
			if not input_cooldown then
				gamma_adjuster_content.internal_value = math.clamp(internal_value + step, 0, 1)
				gamma_adjuster_content.last_update = current_time
				input_been_made = true
			end
		elseif 0 < math.abs(move.x) then
			gamma_adjuster_content.changed = true
			gamma_adjuster_content.internal_value = math.clamp(internal_value + math.sign(move.x)*math.pow(move.x, 2)*total_step*dt*analog_speed, 0, 1)
		end

		if input_been_made then
			gamma_adjuster_content.changed = true

			if on_cooldown_last_frame then
				input_cooldown_multiplier = math.max(input_cooldown_multiplier - 0.1, 0.1)
				gamma_adjuster_content.input_cooldown = math.ease_in_exp(input_cooldown_multiplier)*0.2
				gamma_adjuster_content.input_cooldown_multiplier = input_cooldown_multiplier
			else
				input_cooldown_multiplier = 1
				gamma_adjuster_content.input_cooldown = math.ease_in_exp(input_cooldown_multiplier)*0.2
				gamma_adjuster_content.input_cooldown_multiplier = input_cooldown_multiplier
			end

			return true
		end
	end

	return 
end
TitleLoadingUI._get_input_texture_data = function (self, input_action)
	local input_service = Managers.input:get_service("title_loading_ui")

	if Managers.input:is_device_active("keyboard") or Managers.input:is_device_active("mouse") then
		local platform = Application.platform()
		local keymap_binding = input_service.get_keymapping(input_service, input_action, platform)
		local device_type = keymap_binding[1]
		local key_index = keymap_binding[2]
		local key_action_type = keymap_binding[3]

		return nil, Keyboard.button_locale_name(key_index)
	elseif Managers.input:is_device_active("gamepad") then
		return UISettings.get_gamepad_input_texture_data(input_service, input_action, true)
	end

	return 
end
TitleLoadingUI._get_input_gamepad_texture_data = function (self, input_action)
	local input_service = Managers.input:get_service("title_loading_ui")

	return UISettings.get_gamepad_input_texture_data(input_service, input_action, true)
end
TitleLoadingUI._update_input_text = function (self, dt)
	local widget_content = self._skip_widget.content
	local widget_style = self._skip_widget.style
	local ui_scenegraph = self._ui_scenegraph
	local texture_data, input_text = self._get_input_texture_data(self, "cancel_video_1")

	if not texture_data then
		if widget_content.input_text ~= input_text then
			widget_content.input_text_1 = Localize("input_hold")
			widget_content.input_text_3 = Localize("any_key")
			widget_content.input_icon = nil
		end
	elseif texture_data.texture ~= widget_content.input_icon then
		widget_content.input_text_1 = Localize("input_hold")
		ui_scenegraph.skip_input_icon.size = texture_data.size
		widget_content.input_icon = texture_data.texture
		widget_content.input_text_3 = ""
	end

	local font, scaled_font_size = UIFontByResolution(widget_style.input_text_1)
	local text_width, text_height, min = UIRenderer.text_size(self._ui_renderer, widget_content.input_text_1, font[1], scaled_font_size)
	ui_scenegraph.skip_input_text_1.size[1] = text_width
	ui_scenegraph.skip_input_icon.position[1] = ui_scenegraph.skip_input_text_1.position[1] + text_width + ui_scenegraph.skip_input_icon.size[1]*0.25

	if texture_data then
		ui_scenegraph.skip_input.position[1] = 0
	end

	widget_content.using_keyboard = (not texture_data and true) or false

	if texture_data then
		ui_scenegraph.skip_input_text_2.position[1] = ui_scenegraph.skip_input_text_1.position[1] + text_width + ui_scenegraph.skip_input_icon.size[1]*1.75
	else
		local offset = 30
		local font, scaled_font_size = UIFontByResolution(widget_style.input_text_3)
		local text_width, text_height, min = UIRenderer.text_size(self._ui_renderer, widget_content.input_text_3, font[1], scaled_font_size)
		ui_scenegraph.skip_input_text_3.size[1] = text_width
		widget_style.keyboard_input_icon.tile_sizes[2][1] = text_width
		ui_scenegraph.skip_input_text_3.position[1] = ui_scenegraph.skip_input_text_1.position[1] + ui_scenegraph.skip_input_text_1.size[1] + offset
		ui_scenegraph.skip_input_text_2.position[1] = ui_scenegraph.skip_input_text_3.position[1] + ui_scenegraph.skip_input_text_3.size[1] + offset
		self.hold_bar_max_length = text_width + 34
	end

	self._can_draw_input_widget = true

	return 
end
INPUTS_TO_REMOVE = {}
TitleLoadingUI._update_any_held = function (self)
	local held = false

	for input, device in pairs(self._current_inputs) do
		if device.button(input) < 1 then
			INPUTS_TO_REMOVE[#INPUTS_TO_REMOVE + 1] = input
		else
			held = true
		end
	end

	for _, input in ipairs(INPUTS_TO_REMOVE) do
		self._current_inputs[input] = nil
	end

	table.clear(INPUTS_TO_REMOVE)

	local input = Keyboard.any_pressed()

	if input then
		self._current_inputs[input] = Keyboard
	end

	local input = Mouse.any_pressed()

	if input then
		self._current_inputs[input] = Mouse
	end

	local input = Pad1.any_pressed()

	if input then
		self._current_inputs[input] = Pad1
	end

	return held
end
TitleLoadingUI._update_input = function (self, dt)
	if self._force_done then
		self._handle_skip_fade(self, 0)

		return 
	end

	local total_hold_time = 1
	local total_fade_time = 1
	self._fade_timer = math.clamp((self._fade_timer or 0) - dt, 0, total_fade_time)
	local input_service = Managers.input:get_service("title_loading_ui")
	local cancel_video = input_service.get(input_service, "cancel_video")

	if self._update_any_held(self) then
		self._fade_timer = total_fade_time
		self._cancel_timer = (self._cancel_timer or 0) + dt
	else
		self._cancel_timer = (self._cancel_timer or 0) - dt*3
	end

	self._handle_skip_fade(self, self._fade_timer/total_fade_time*255)

	self._cancel_timer = math.clamp(self._cancel_timer, 0, total_hold_time)
	local progress = self._cancel_timer/total_hold_time

	if 1 <= progress or (cancel_video and self._cancel_video) then
		self._cancel_timer = nil
		self._force_done = true

		if not Managers.transition:loading_icon_active() then
			Managers.transition:show_loading_icon()
		end

		self._skip_widget.style.input_icon_bar.gradient_threshold = 0
		self._skip_widget.style.hold_bar.size[1] = 0
	else
		local fraction = math.clamp(progress, 0, 1)
		self._skip_widget.style.input_icon_bar.gradient_threshold = fraction
		local hold_bar_max_length = self.hold_bar_max_length

		if hold_bar_max_length then
			self._skip_widget.style.hold_bar.size[1] = hold_bar_max_length*fraction
		end
	end

	self._cancel_video = self._cancel_video or cancel_video

	return 
end
TitleLoadingUI._handle_skip_fade = function (self, alpha)
	local skip_input_style = self._skip_widget.style
	skip_input_style.input_text_1.text_color[1] = alpha
	skip_input_style.input_text_2.text_color[1] = alpha
	skip_input_style.input_text_3.text_color[1] = alpha
	skip_input_style.input_icon.color[1] = alpha
	skip_input_style.input_icon_bar.color[1] = alpha
	skip_input_style.keyboard_input_icon.color[1] = alpha

	return 
end
TitleLoadingUI._render = function (self, dt)
	local input_manager = Managers.input
	local input_service = input_manager.get_service(input_manager, "title_loading_ui")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	UIRenderer.begin_pass(self._ui_renderer, self._ui_scenegraph, input_service, dt, nil, self.render_settings)

	if not self._gamma_done then
		UIRenderer.draw_widget(self._ui_renderer, self._gamma_adjuster)

		if not gamepad_active then
			UIRenderer.draw_widget(self._ui_renderer, self._done_button)
		end
	else
		self._render_video(self, dt)

		if self._can_draw_input_widget then
			UIRenderer.draw_widget(self._ui_renderer, self._skip_widget)
		end
	end

	UIRenderer.draw_widget(self._ui_renderer, self._dead_space_filler_widget)
	UIRenderer.end_pass(self._ui_renderer)

	return 
end
TitleLoadingUI._render_video = function (self, dt)
	if not self._trailer then
		return 
	end

	if self._done then
		return 
	end

	if not self._ui_renderer.video_player then
		UIRenderer.create_video_player(self._ui_renderer, self._world, first_time_video.video_name, false)
	else
		local video_complete = self._video_widget.content.video_content.video_completed

		if video_complete then
			UIRenderer.destroy_video_player(self._ui_renderer)

			self._sound_started = false

			if first_time_video.sound_stop then
				Managers.music:trigger_event(first_time_video.sound_stop)
			end

			self._done = true

			if not Managers.transition:loading_icon_active() then
				Managers.transition:show_loading_icon()
			end
		else
			if not self._sound_started then
				if first_time_video.sound_start then
					Managers.music:trigger_event(first_time_video.sound_start)
				end

				self._sound_started = true
			end

			UIRenderer.draw_widget(self._ui_renderer, self._video_widget)
		end
	end

	return 
end
TitleLoadingUI.destroy = function (self)
	Managers.music:stop_all_sounds()
	UIRenderer.destroy(self._ui_renderer, self._world)

	if Application.platform() == "win32" then
		local max_fps = Application.user_setting("max_fps")

		if max_fps == nil or max_fps == 0 then
			Application.set_time_step_policy("no_throttle", "smoothing", 11, 2, 0.1)
		else
			Application.set_time_step_policy("throttle", max_fps, "smoothing", 11, 2, 0.1)
		end
	end

	if self._needs_cursor_pop then
		ShowCursorStack.pop()

		self._needs_cursor_pop = false
	end

	return 
end
TitleLoadingUI.is_done = function (self)
	return self._gamma_done and (self._force_done or self._done)
end
TitleLoadingUI.force_done = function (self)
	self._force_done = true
	self._cancel_timer = nil

	if not Managers.transition:loading_icon_active() then
		Managers.transition:show_loading_icon()
	end

	self._skip_widget.style.input_icon_bar.gradient_threshold = 0

	return 
end

return 
