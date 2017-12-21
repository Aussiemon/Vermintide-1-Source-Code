require("scripts/game_state/state_title_screen_main")
require("scripts/settings/platform_specific")
require("scripts/game_state/state_loading")
require("scripts/settings/game_settings")
require("scripts/ui/views/beta_overlay")
require("foundation/scripts/managers/chat/chat_manager")

StateTitleScreen = class(StateTitleScreen)
StateTitleScreen.NAME = "StateTitleScreen"
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
			0
		}
	},
	sidebar = {
		parent = "root",
		horizontal_alignment = "left",
		size = {
			400,
			1080
		},
		position = {
			50,
			0,
			2
		}
	},
	foreground = {
		parent = "root",
		horizontal_alignment = "left",
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
	loop_video = {
		parent = "root",
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
	title = {
		vertical_alignment = "center",
		parent = "foreground",
		horizontal_alignment = "center",
		size = {
			1496,
			673
		},
		position = {
			0,
			100,
			0
		}
	},
	texts = {
		parent = "foreground"
	}
}
title_content = {
	scenegraph_id = "title",
	localize = true,
	type = "texture",
	font_size = 13,
	pixel_perfect = false,
	spacing = 5,
	text_horizontal_alignment = "center",
	material_name = "vermintide_logo_title",
	dynamic_font = false,
	texts_scenegraph_id = "texts",
	disable_background = true,
	disable_foreground = true,
	font_type = "hell_shark",
	texts = {
		"fatshark_legal_1",
		"gw_legal_1",
		"gw_legal_2",
		"gw_legal_3",
		"gw_legal_4"
	},
	texture_size = {
		1496,
		673
	},
	texture_offset = {
		0,
		0,
		2
	}
}
local menu_loop = {
	video_name = "video/menu_loop",
	scenegraph_id = "loop_video",
	material_name = "menu_loop",
	loop = true
}
background_widget = {
	scenegraph_id = "background",
	element = {
		passes = {
			{
				style_id = "background",
				scenegraph_id = "background",
				pass_type = "rect"
			}
		}
	},
	content = {},
	style = {
		background = {
			color = Colors.color_definitions.black
		}
	}
}
sidebar_widget = {
	scenegraph_id = "sidebar",
	element = {
		passes = {
			{
				pass_type = "rect",
				style_id = "sidebar"
			}
		}
	},
	content = {},
	style = {
		sidebar = {
			color = {
				0,
				0,
				0,
				0
			}
		}
	}
}
local title_animations = {
	scale_and_position_in = {
		{
			name = "scale_and_position_in",
			start_progress = 0,
			end_progress = 0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local size = widget.style.texture_style.size
				local offset = widget.style.texture_style.offset
				local text_color = widget.style.texts_style.text_color
				local original_size = params.title_content.texture_size
				size[1] = math.lerp(original_size[1], original_size[1]*0.25, math.smoothstep(local_progress, 0, 1))
				size[2] = math.lerp(original_size[2], original_size[2]*0.25, math.smoothstep(local_progress, 0, 1))
				offset[1] = math.lerp(title_content.texture_offset[1], -150, math.smoothstep(local_progress, 0, 1))
				offset[2] = math.lerp(title_content.texture_offset[2], 550, math.smoothstep(local_progress, 0, 1))
				text_color[1] = math.lerp(Colors.color_definitions.white[1], 0, math.smoothstep(local_progress, 0, 1))

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	sidebar_fade_in = {
		{
			name = "sidebar_fade_in",
			start_progress = 0,
			end_progress = 0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local color = widget.style.sidebar.color
				color[1] = math.lerp(0, 255, math.smoothstep(local_progress, 0, 1))

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	scale_and_position_out = {
		{
			name = "scale_and_position_out",
			start_progress = 0,
			end_progress = 0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local size = widget.style.texture_style.size
				local offset = widget.style.texture_style.offset
				local text_color = widget.style.texts_style.text_color
				local original_size = params.title_content.texture_size
				size[1] = math.lerp(original_size[1], original_size[1]*0.25, math.smoothstep(local_progress, 1, 0))
				size[2] = math.lerp(original_size[2], original_size[2]*0.25, math.smoothstep(local_progress, 1, 0))
				offset[1] = math.lerp(title_content.texture_offset[1], -150, math.smoothstep(local_progress, 1, 0))
				offset[2] = math.lerp(title_content.texture_offset[2], 600, math.smoothstep(local_progress, 1, 0))
				text_color[1] = math.lerp(Colors.color_definitions.white[1], 0, math.smoothstep(local_progress, 1, 0))

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	sidebar_fade_out = {
		{
			name = "sidebar_fade_out",
			start_progress = 0,
			end_progress = 0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local color = widget.style.sidebar.color
				color[1] = math.lerp(0, 255, math.smoothstep(local_progress, 1, 0))

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	}
}
StateTitleScreen.on_enter = function (self, params)
	print("[Gamestate] Enter StateTitleScreen")

	if Application.platform() == "xb1" then
		Application.set_kinect_enabled(true)
	end

	local loading_context = self.parent.loading_context
	local args = {
		Application.argv()
	}

	for _, parameter in pairs(args) do
		if parameter == "-auto-host-level" or parameter == "-auto-join" or parameter == "-skip-splash" or loading_context.join_lobby_data then
			self._auto_start = true

			break
		end
	end

	if Application.platform() == "win32" then
		Application.set_time_step_policy("throttle", 60)
	end

	self._params = params

	self._setup_world(self)
	self._setup_leak_prevention(self)
	self._init_input(self)
	self._init_ui(self)
	self._setup_state_machine(self)
	self._init_popup_manager(self)
	self._init_chat_manager(self)
	self._init_animations(self)

	if Development.parameter("use_beta_overlay") then
		self._init_beta_overlay(self)
	end

	Managers.transition:hide_loading_icon()
	Managers.transition:fade_out(1)
	Managers.account:reset()

	local platform = Application.platform()

	if platform == "ps4" then
		Managers.account:set_presence("title_screen")
	end

	return 
end
StateTitleScreen._setup_leak_prevention = function (self)
	local assert_on_leak = true

	GarbageLeakDetector.run_leak_detection(assert_on_leak)
	GarbageLeakDetector.register_object(self, "StateTitleScreen")
	VisualAssertLog.setup(self._world)

	return 
end
StateTitleScreen._setup_world = function (self)
	if not Managers.package:has_loaded("resource_packages/start_menu_splash", "StateSplashScreen") and not GameSettingsDevelopment.skip_start_screen then
		Managers.package:load("resource_packages/start_menu_splash", "StateSplashScreen")
	end

	self._world_name = "title_screen_world"
	self._viewport_name = "title_screen_viewport"
	self._world = Managers.world:create_world(self._world_name, GameSettingsDevelopment.default_environment, nil, nil, Application.DISABLE_PHYSICS, Application.DISABLE_APEX_CLOTH)
	self._viewport = ScriptWorld.create_viewport(self._world, self._viewport_name, "overlay", 1)

	return 
end
StateTitleScreen._init_input = function (self)
	self._input_manager = InputManager2:new()
	Managers.input = self._input_manager

	self._input_manager:initialize_device("keyboard", 1)
	self._input_manager:initialize_device("mouse", 1)
	self._input_manager:initialize_device("gamepad")

	return 
end
local DO_RELOAD = true
StateTitleScreen._init_ui = function (self)
	if Application.platform() == "win32" then
		self._ui_renderer = UIRenderer.create(self._world, "material", "materials/ui/ui_1080p_title_screen", "material", "materials/fonts/hell_shark_font", "material", "materials/fonts/gw_fonts")
	else
		self._ui_renderer = UIRenderer.create(self._world, "material", "materials/ui/ui_1080p_title_screen", "material", "materials/fonts/hell_shark_font", "material", "materials/fonts/gw_fonts", "material", menu_loop.video_name)
	end

	self._ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self._start_screen = UIWidget.init(UIWidgets.create_splash_texture(title_content))

	if Application.platform() ~= "win32" then
		self._menu_loop = UIWidget.init(UIWidgets.create_splash_video(menu_loop))
	end

	self._basic_start_screen = UIWidget.init(background_widget)
	self._sidebar = UIWidget.init(sidebar_widget)
	self._attract_mode_active = false

	return 
end
StateTitleScreen._setup_state_machine = function (self)
	self._machine = StateMachine:new(self, StateTitleScreenMain, {
		world = self._world,
		viewport = self._viewport,
		auto_start = self._auto_start
	}, true)

	return 
end
StateTitleScreen._init_popup_manager = function (self)
	Managers.popup = PopupManager:new()

	Managers.popup:set_input_manager(self._input_manager)

	return 
end
StateTitleScreen._init_chat_manager = function (self)
	Managers.chat = Managers.chat or ChatManager:new()

	return 
end
StateTitleScreen._init_animations = function (self)
	self._ui_animator = UIAnimator:new(self._ui_scenegraph, title_animations)

	return 
end
StateTitleScreen._init_beta_overlay = function (self)
	Managers.beta_overlay = BetaOverlay:new()

	return 
end
StateTitleScreen.update = function (self, dt, t)
	if DO_RELOAD then
		self._ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
		self._ui_animator = UIAnimator:new(self._ui_scenegraph, title_animations)
		DO_RELOAD = false
	end

	Managers.input:update(dt, t)
	self._machine:update(dt, t)
	self._ui_animator:update(dt)

	local render_only_background = GameSettingsDevelopment.skip_start_screen

	self._render(self, dt, render_only_background)

	if script_data.debug_enabled then
		VisualAssertLog.update(dt)
	end

	return self.state
end
StateTitleScreen.enter_attract_mode = function (self, enter)
	self._attract_mode_active = enter

	return 
end
StateTitleScreen._test = function (self)
	local font = {
		scale_to_closest = true,
		dynamic_font = false,
		font_size = 14,
		pixel_perfect = false,
		font_type = "fatshark_test"
	}
	self._seed = self._seed or 0

	if Keyboard.pressed(Keyboard.button_index("k")) then
		self._seed = math.random(0, 1024)
	end

	math.randomseed(self._seed)

	local text = "!#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~¡¢£¤¥¦§¨©ª«¬®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ\u0140\u0141\u0142\u0143\u0144\u0145\u0146\u0147\u0148\u0149\u014a\u014b\u014c\u014d\u014e\u014f\u0150\u0151Œœ\u0154\u0155\u0156\u0157\u0158\u0159\u015a\u015b\u015c\u015d\u015e\u015fŠš\u0162\u0163\u0164\u0165\u0166\u0167\u0168\u0169\u016a\u016b\u016c\u016d\u016e\u016f\u0170\u0171\u0172\u0173\u0174\u0175\u0176\u0177Ÿ\u0179\u017a\u017b\u017cŽž\u017f\u0180\u0181\u0182\u0183\u0184\u0185\u0186\u0187\u0188\u0189\u018a\u018b\u018c\u018d\u018e\u018f\u0190\u0191ƒ\u0193\u0194\u0195\u0196\u0197\u0198\u0199\u019a\u019b\u019c\u019d\u019e\u019f\u01a0\u01a1\u01a2\u01a3\u01a4\u01a5\u01a6\u01a7\u01a8\u01a9\u01aa\u01ab\u01ac\u01ad\u01ae\u01af\u01b0\u01b1\u01b2\u01b3\u01b4\u01b5\u01b6\u01b7\u01b8\u01b9\u01ba\u01bb\u01bc\u01bd\u01be\u01bf\u01c0\u01c1\u01c2\u01c3\u01c4\u01c5\u01c6\u01c7\u01c8\u01c9\u01ca\u01cb\u01cc\u01cd\u01ce\u01cf\u01d0\u01d1\u01d2\u01d3\u01d4\u01d5\u01d6\u01d7\u01d8\u01d9\u01da\u01db\u01dc\u01dd\u01de\u01df\u01e0\u01e1\u01e2\u01e3\u01e4\u01e5\u01e6\u01e7\u01e8\u01e9\u01ea\u01eb\u01ec\u01ed\u01ee\u01ef\u01f0\u01f1\u01f2\u01f3\u01f4\u01f5\u01f6\u01f7\u01f8\u01f9\u01fa\u01fb\u01fc\u01fd\u01fe\u01ff\u0200\u0201\u0202\u0203\u0204\u0205\u0206\u0207\u0208\u0209\u020a\u020b\u020c\u020d\u020e\u020f\u0210\u0211\u0212\u0213\u0214\u0215\u0216\u0217\u0218\u0219\u021a\u021b\u021c\u021d\u021e\u021f\u0220\u0221\u0222\u0223\u0224\u0225\u0226\u0227\u0228\u0229\u022a\u022b\u022c\u022d\u022e\u022f\u0230\u0231\u0232\u0233\u0234\u0235\u0236\u0237\u0238\u0239\u023a\u023b\u023c\u023d\u023e\u023f\u0240\u0241\u0242\u0243\u0244\u0245\u0246\u0247\u0248\u0249\u024a\u024b\u024c\u024d\u024e\u024f\u0410\u0411\u0412\u0413\u0490\u0414\u0402\u0403\u0415\u0401\u0404\u0416\u0417\u0417\u0301\u0405\u0418\u0406\u0407\u0419\u0408\u041a\u041b\u0409\u041cEm\u041d\u040a\u041e\u041f\u0420\u0421\u0421\u0301\u0422\u040b\u040c\u0423\u040e\u0424\u0425\u0426\u0427\u040f\u0428\u0429\u042a\u042b\u042c\u042d\u042eYu\u042f\u04c0\u04d8\u0492\u0498\u04aa\u04a0\u0496\u049a\u04a2\u04a4\u04e8\u04ae\u04b0\u04ba\u04b2\u0500\u0501\u0502\u0503\u0504\u0505\u0506\u0507\u0508\u0509\u050a\u050b\u050c\u050d\u050e\u050f\u0510\u0511\u0512\u0513\u04a7"
	local padding = 5
	local pos = Vector3(20, 20, 999)

	for i = 14, 72, 2 do
		font.font_size = i
		local font_data, font_size = UIFontByResolution(font)
		local font, std_font_size, material = unpack(font_data)

		Gui.text(self._ui_renderer.gui, string.format(" (font_type: %s, font_size: %d) - ", material, font_size) .. text, font, font_size, material, pos, Color(math.random(0, 255), math.random(0, 255), math.random(0, 255)))

		local min, max = Gui.text_extents(self._ui_renderer.gui, text, font, font_size)
		local extents_y = max[3] - min[3]
		pos[2] = pos[2] + extents_y*0.7
		local extents_x = max[1] - min[1]
		pos[1] = extents_x*0.5 + math.sin(Application.time_since_launch()*0.1)*extents_x
	end

	local w, h = Gui.resolution()

	Gui.rect(self._ui_renderer.gui, Vector3(0, 0, 980), Vector2(w, h), Color(0, 0, 0))

	return 
end
StateTitleScreen._render = function (self, dt, render_only_background)
	UIRenderer.begin_pass(self._ui_renderer, self._ui_scenegraph, nil, dt)

	if render_only_background then
		UIRenderer.draw_widget(self._ui_renderer, self._basic_start_screen)
	elseif self._attract_mode_active then
		if self._ui_renderer.video_player then
			UIRenderer.destroy_video_player(self._ui_renderer)
		end
	else
		UIRenderer.draw_widget(self._ui_renderer, self._start_screen)

		if not self._ui_renderer.video_player then
			UIRenderer.create_video_player(self._ui_renderer, self._world, menu_loop.video_name, menu_loop.loop)
		end

		if self._menu_loop then
			UIRenderer.draw_widget(self._ui_renderer, self._menu_loop)
		end

		UIRenderer.draw_widget(self._ui_renderer, self._sidebar)
	end

	UIRenderer.end_pass(self._ui_renderer)

	return 
end
StateTitleScreen.show_menu = function (self, show)
	if show then
		self._ui_animator:start_animation("scale_and_position_in", {
			self._start_screen
		}, scenegraph_definition, {
			title_content = title_content
		})
		self._ui_animator:start_animation("sidebar_fade_in", {
			self._sidebar
		}, scenegraph_definition)
	else
		self._ui_animator:start_animation("scale_and_position_out", {
			self._start_screen
		}, scenegraph_definition, {
			title_content = title_content
		})
		self._ui_animator:start_animation("sidebar_fade_out", {
			self._sidebar
		}, scenegraph_definition)
	end

	return 
end
StateTitleScreen.on_exit = function (self, application_shutdown)
	if Application.platform() == "win32" then
		local max_fps = Application.user_setting("max_fps")

		if max_fps == nil or max_fps == 0 then
			Application.set_time_step_policy("no_throttle")
		else
			Application.set_time_step_policy("throttle", max_fps)
		end
	end

	self._machine:destroy()
	VisualAssertLog.cleanup()
	UIRenderer.destroy(self._ui_renderer, self._world)
	ScriptWorld.destroy_viewport(self._world, self._viewport_name)
	Managers.world:destroy_world(self._world)

	if Managers.package:has_loaded("resource_packages/start_menu_splash", "StateSplashScreen") then
		Managers.package:unload("resource_packages/start_menu_splash", "StateSplashScreen")
	end

	Managers.popup:remove_input_manager(application_shutdown)
	self._input_manager:destroy()

	self._input_manager = nil
	Managers.input = nil

	Managers.music:trigger_event("Stop_menu_screen_music")

	return 
end

return 
