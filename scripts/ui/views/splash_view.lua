require("scripts/ui/ui_renderer")
require("scripts/ui/ui_layer")
require("scripts/ui/ui_elements")
require("scripts/ui/ui_widgets")

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
	background = {
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
			99
		}
	},
	foreground = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			200
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
			100
		}
	},
	esrb = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		size = {
			1200,
			576
		}
	},
	gw_splash = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		size = {
			589,
			203
		}
	},
	autodesk_splash = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		size = {
			1200,
			195
		}
	},
	bld_splash_partners = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		}
	},
	partner_splash_dobly = {
		vertical_alignment = "top",
		parent = "partner_splash_dts",
		horizontal_alignment = "left",
		size = {
			314,
			80
		},
		position = {
			-450,
			0,
			0
		}
	},
	partner_splash_dts = {
		vertical_alignment = "center",
		parent = "bld_splash_partners",
		horizontal_alignment = "center",
		size = {
			234,
			88
		},
		position = {
			0,
			230,
			720
		}
	},
	partner_splash_umbra = {
		vertical_alignment = "top",
		parent = "partner_splash_dts",
		horizontal_alignment = "right",
		size = {
			313,
			128
		},
		position = {
			450,
			0,
			0
		}
	},
	partner_splash_pixeldiet = {
		vertical_alignment = "bottom",
		parent = "partner_splash_dts",
		horizontal_alignment = "left",
		size = {
			314,
			57
		},
		position = {
			-450,
			-230,
			0
		}
	},
	partner_splash_black = {
		vertical_alignment = "bottom",
		parent = "partner_splash_dts",
		horizontal_alignment = "center",
		size = {
			222,
			139
		},
		position = {
			0,
			-260,
			0
		}
	},
	partner_splash_wwise = {
		vertical_alignment = "bottom",
		parent = "partner_splash_dts",
		horizontal_alignment = "right",
		size = {
			315,
			93
		},
		position = {
			452,
			-232,
			0
		}
	},
	partner_splash_simplygon = {
		vertical_alignment = "center",
		parent = "bld_splash_partners",
		horizontal_alignment = "center",
		size = {
			150,
			107
		},
		position = {
			0,
			-230,
			720
		}
	},
	texts = {
		parent = "background"
	}
}
local dead_space_filler = {
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
local splash_content = {
	{
		video_name = "video/fatshark_splash",
		sound_start = "Play_fatshark_logo",
		scenegraph_id = "splash_video",
		type = "video",
		material_name = "fatshark_splash",
		sound_stop = "Stop_fatshark_logo"
	},
	{
		scenegraph_id = "gw_splash",
		time = 3,
		axis = 2,
		type = "texture",
		pixel_perfect = false,
		spacing = 5,
		text_horizontal_alignment = "center",
		texts_scenegraph_id = "texts",
		dynamic_font = false,
		direction = 1,
		font_type = "hell_shark",
		localize = true,
		font_size = 13,
		material_name = "gw_splash",
		texts = {
			"gw_legal_1",
			"gw_legal_2",
			"gw_legal_3",
			"gw_legal_4"
		},
		size = {
			1920,
			13
		},
		offset = {
			0,
			71,
			0
		}
	},
	{
		scenegraph_id = "autodesk_splash",
		time = 3,
		axis = 2,
		type = "texture",
		pixel_perfect = false,
		spacing = 5,
		text_horizontal_alignment = "center",
		texts_scenegraph_id = "texts",
		dynamic_font = false,
		direction = 1,
		font_type = "hell_shark",
		localize = true,
		font_size = 13,
		material_name = "autodesk_splash",
		texts = {
			"adsk_legal_1"
		},
		size = {
			1920,
			13
		},
		offset = {
			0,
			19,
			0
		}
	},
	{
		texts_scenegraph_id = "texts",
		scenegraph_id = "bld_splash_partners",
		time = 3,
		type = "texture",
		font_size = 13,
		pixel_perfect = false,
		partner_splash = true,
		text_horizontal_alignment = "center",
		dynamic_font = false,
		spacing = 5,
		localize = true,
		font_type = "hell_shark",
		texture_materials = {
			"dolby",
			"dts",
			"umbra",
			"pixeldiet",
			"black",
			"wwise",
			"simplygon"
		},
		texture_scenegraph_ids = {
			"partner_splash_dobly",
			"partner_splash_dts",
			"partner_splash_umbra",
			"partner_splash_pixeldiet",
			"partner_splash_black",
			"partner_splash_wwise",
			"partner_splash_simplygon"
		}
	}
}
SplashView = class(SplashView)
SplashView.init = function (self, input_manager, world)
	if Application.platform() == "ps4" then
		PS4.hide_splash_screen()
	end

	self._fram_skip_hack = 0
	self.gdc_build = Development.parameter("gdc")
	self.force_debug_enabled = Development.parameter("force_debug_enabled")
	self._world = world
	self._current_index = 1
	self.ui_renderer = UIRenderer.create(world, "material", "video/fatshark_splash", "material", "video/trailer", "material", "video/logo", "material", "video/physx_splash", "material", "materials/fonts/hell_shark_font", "material", "materials/fonts/gw_fonts", "material", "materials/ui/ui_1080p_splash_screen")
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self.dead_space_filler = UIWidget.init(dead_space_filler)
	self._splash_widgets = {}

	for _, splash in pairs(splash_content) do
		local widget = nil

		if splash.type == "video" then
			widget = UIWidgets.create_splash_video(splash)
		elseif splash.partner_splash then
			widget = UIWidgets.create_partner_splash_widget(splash)
		else
			widget = UIWidgets.create_splash_texture(splash)
		end

		self._splash_widgets[#self._splash_widgets + 1] = UIWidget.init(widget)
	end

	if input_manager then
		input_manager.create_input_service(input_manager, "splash_view", SplashScreenKeymaps)
		input_manager.map_device_to_service(input_manager, "splash_view", "keyboard")
		input_manager.map_device_to_service(input_manager, "splash_view", "gamepad")

		self.input_manager = input_manager
	end

	self._next_splash(self, true)

	return 
end
SplashView._next_splash = function (self, override_skip)
	if not override_skip and Application.platform() == "xb1" and not self._allow_xb1_skip then
		self._update_func = "_wait_for_allow_xb1_skip"

		return 
	end

	self._update_func = "do_nothing"
	self._current_splash_data = splash_content[self._current_index]
	self._current_widget = self._splash_widgets[self._current_index]

	if self._current_splash_data then
		self._update_func = "_update_" .. self._current_splash_data.type
		self._current_index = self._current_index + 1
		self._current_splash_data.timer = self._current_splash_data.time
	elseif not Managers.transition:loading_icon_active() then
		Managers.transition:show_loading_icon()
	end

	return 
end
SplashView._update_video = function (self, gui, dt)
	if not self.ui_renderer.video_player then
		UIRenderer.create_video_player(self.ui_renderer, self._world, self._current_splash_data.video_name, false)
		Managers.transition:fade_out(0.5, nil)
	else
		local video_complete = self._current_widget.content.video_content.video_completed

		if video_complete then
			UIRenderer.destroy_video_player(self.ui_renderer)

			self._sound_started = false

			if self._current_splash_data.sound_stop then
				Managers.music:trigger_event(self._current_splash_data.sound_stop)
			end

			self._next_splash(self)
		else
			if not self._sound_started then
				if self._current_splash_data.sound_start then
					Managers.music:trigger_event(self._current_splash_data.sound_start)
				end

				self._sound_started = true
			end

			UIRenderer.draw_widget(self.ui_renderer, self._current_widget)
		end
	end

	return 
end
SplashView._update_texture = function (self, gui, dt)
	local w, h = Gui.resolution()
	local timer = self._current_splash_data.timer
	local texts = self._current_splash_data.texts
	local total_time = self._current_splash_data.time

	if total_time - 0.5 < timer then
		local value = (timer - total_time - 0.5)/0.5*255
		self._current_widget.style.foreground.color[1] = value
	elseif timer <= 0.5 then
		local value = (timer/0.5 - 1)*255
		self._current_widget.style.foreground.color[1] = value
	else
		self._current_widget.style.foreground.color[1] = 0
	end

	UIRenderer.draw_widget(self.ui_renderer, self._current_widget)

	self._current_splash_data.timer = self._current_splash_data.timer - dt

	if self._current_splash_data.timer <= 0 then
		self._next_splash(self)
	end

	return 
end

if Application.platform() == "xb1" then
	SplashView._wait_for_allow_xb1_skip = function (self)
		if self._allow_xb1_skip then
			self._next_splash(self)
		end

		return 
	end
end

SplashView.set_index = function (self, index)
	self._current_index = index

	self._next_splash(self)

	return 
end
SplashView.update = function (self, dt)
	if Application.platform() ~= "xb1" and self._fram_skip_hack < 1 then
		self._fram_skip_hack = self._fram_skip_hack + 1

		return 
	end

	local w, h = Gui.resolution()
	local ui_renderer = self.ui_renderer
	local input_service = (Application.platform() ~= "xb1" and self.input_manager:get_service("splash_view")) or false

	UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.dead_space_filler)

	local skip = nil

	if Application.platform() == "xb1" then
		skip = self._get_xb1_input(self)
	else
		skip = input_service.get(input_service, "skip_splash")
	end

	if skip and (not self._current_splash_data or not self._current_splash_data.forced) then
		if self._current_splash_data and self._current_splash_data.type == "video" then
			if ui_renderer.video_player then
				UIRenderer.destroy_video_player(self.ui_renderer)
			end

			if self._current_splash_data.sound_stop then
				Managers.music:trigger_event(self._current_splash_data.sound_stop)
			end

			self._sound_started = false
		end

		self._next_splash(self)
	elseif self[self._update_func] then
		self[self._update_func](self, ui_renderer.gui, dt)
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end

if Application.platform() == "xb1" then
	SplashView.allow_xb1_skip = function (self)
		self._allow_xb1_skip = true

		return 
	end
	SplashView._get_xb1_input = function (self)
		if not self._allow_xb1_skip then
			return 
		end

		local pad = "Pad"

		for i = 1, 8, 1 do
			local pad_name = pad .. tostring(i)
			local pad_controller = rawget(_G, pad_name)

			if pad_controller and pad_controller.any_pressed() then
				return true
			end
		end

		return 
	end
end

SplashView.render = function (self)
	return 
end
SplashView.destroy = function (self)
	Managers.music:stop_all_sounds()
	UIRenderer.destroy(self.ui_renderer, self._world)

	return 
end
SplashView.is_completed = function (self)
	return self._current_splash_data == nil
end

return 
