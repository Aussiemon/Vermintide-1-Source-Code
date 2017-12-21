StateTitleScreenMainMenu = class(StateTitleScreenMainMenu)
StateTitleScreenMainMenu.NAME = "StateTitleScreen"
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.default + 10
		},
		size = {
			1920,
			1080
		}
	},
	simple_rect = {
		vertical_alignment = "top",
		parent = "root",
		horizontal_alignment = "left",
		size = {
			1920,
			0
		},
		position = {
			50,
			0,
			1
		}
	},
	anchor_point = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			100,
			0,
			0
		}
	},
	start_game_button = {
		vertical_alignment = "top",
		parent = "anchor_point",
		horizontal_alignment = "left",
		position = {
			0,
			-250,
			1
		},
		size = {
			1000,
			84
		}
	},
	tutorial = {
		vertical_alignment = "top",
		parent = "anchor_point",
		horizontal_alignment = "left",
		position = {
			0,
			-310,
			1
		},
		size = {
			1000,
			84
		}
	},
	split_screen = {
		vertical_alignment = "top",
		parent = "anchor_point",
		horizontal_alignment = "left",
		position = {
			0,
			-370,
			1
		},
		size = {
			1000,
			84
		}
	},
	options = {
		vertical_alignment = "top",
		parent = "anchor_point",
		horizontal_alignment = "left",
		position = {
			0,
			-370,
			1
		},
		size = {
			1000,
			84
		}
	},
	credits = {
		vertical_alignment = "top",
		parent = "anchor_point",
		horizontal_alignment = "left",
		position = {
			0,
			-430,
			1
		},
		size = {
			1000,
			84
		}
	}
}
local simple_rect_widget = {
	scenegraph_id = "simple_rect",
	element = {
		passes = {
			{
				pass_type = "rect",
				style_id = "simple_rect"
			}
		}
	},
	content = {},
	style = {
		simple_rect = {
			color = {
				255,
				60,
				60,
				60
			},
			offset = {
				0,
				-70,
				0
			},
			size = {
				0,
				60
			}
		}
	}
}
local menu_button_definitions = {
	UIWidgets.create_text_button("start_game_button", "start_game_menu_button_name", {
		42,
		0,
		0
	}),
	UIWidgets.create_text_button("tutorial", "tutorial_menu_button_name", {
		42,
		0,
		0
	}),
	UIWidgets.create_text_button("options", "options_menu_button_name", {
		42,
		0,
		0
	}),
	UIWidgets.create_text_button("credits", "credits_menu_button_name", {
		42,
		0,
		0
	})
}
local menu_functions = {
	function (this)
		this._input_disabled = true

		Managers.transition:show_loading_icon(false)
		Managers.transition:fade_in(GameSettings.transition_fade_out_speed, callback(this, "cb_fade_in_done"))

		return 
	end,
	function (this)
		this._input_disabled = true

		Managers.transition:show_loading_icon(false)
		Managers.transition:fade_in(GameSettings.transition_fade_out_speed, callback(this, "cb_fade_in_done", "tutorial"))

		return 
	end,
	function ()
		return 
	end,
	function ()
		return 
	end
}
local DO_RELOAD = true
StateTitleScreenMainMenu.on_enter = function (self, params)
	self._params = params
	self._world = self._params.world
	self._viewport = self._params.viewport
	self._gui = self._params.gui
	self._auto_start = params.auto_start
	self._animations = {}

	self._setup_input(self)
	self._setup_ui(self)
	self._init_elements(self)
	self.parent:show_menu(true)
	Managers.transition:hide_loading_icon()

	return 
end
StateTitleScreenMainMenu._setup_input = function (self)
	local input_manager = Managers.input

	input_manager.create_input_service(input_manager, "main_menu", TitleScreenKeyMaps)
	input_manager.map_device_to_service(input_manager, "main_menu", "gamepad")

	return 
end
StateTitleScreenMainMenu._setup_ui = function (self)
	self._ui_renderer = UIRenderer.create(self._world, "material", "materials/fonts/hell_shark_font", "material", "materials/fonts/gw_fonts")
	self._ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)

	return 
end
StateTitleScreenMainMenu._init_elements = function (self)
	self._menu_items = {}
	self._selection_items = {}

	for _, definition in ipairs(menu_button_definitions) do
		self._menu_items[#self._menu_items + 1] = UIWidget.init(definition)
		self._selection_items[#self._selection_items + 1] = UIWidget.init(simple_rect_widget)
		local selection_item = self._selection_items[#self._selection_items]
		local menu_item = self._menu_items[#self._menu_items]
		local scenegraph_id = menu_item.scenegraph_id
		selection_item.style.simple_rect.offset[2] = scenegraph_definition[scenegraph_id].position[2] - 75
	end

	DO_RELOAD = false

	return 
end
StateTitleScreenMainMenu.update = function (self, dt, t)
	if DO_RELOAD then
		self._setup_ui(self)
		self._init_elements(self)
	end

	self._update_input(self, dt, t)

	if Pad1.pressed(Pad1.button_index("circle")) then
		self.parent:show_menu(false)

		self._new_state = StateTitleScreenMain
	end

	self._update_animations(self, dt, t)
	self._render(self, dt, t)

	return self._new_state
end
StateTitleScreenMainMenu._update_input = function (self, dt, t)
	if self._input_disabled then
		return 
	end

	if self._auto_start then
		menu_functions[1](self)

		return 
	end

	local current_index = self._current_menu_index or 1
	local input_service = Managers.input:get_service("main_menu")

	if input_service.get(input_service, "down") then
		current_index = current_index%#self._menu_items + 1
	elseif input_service.get(input_service, "up") then
		current_index = (current_index - 1 < 1 and #self._menu_items) or current_index - 1
	end

	if current_index ~= self._current_menu_index then
		if self._current_menu_index then
			self._add_animation(self, self._current_menu_index, "anim_deselect_button")
		end

		self._add_animation(self, current_index, "anim_select_button")
	end

	self._current_menu_index = current_index

	if input_service.get(input_service, "start") then
		menu_functions[self._current_menu_index](self)
	end

	return 
end
StateTitleScreenMainMenu._add_animation = function (self, index, func)
	self._animations[index] = {
		progress = (self._animations[index] and self._animations[index].progress) or 0,
		func = func
	}

	return 
end
StateTitleScreenMainMenu._update_animations = function (self, dt, t)
	for index, animation in pairs(self._animations) do
		self[animation.func](self, animation, index, dt)
	end

	return 
end
local FADE_IN = 0.25
local FADE_OUT = 0.2
StateTitleScreenMainMenu.anim_select_button = function (self, animation_data, index, dt)
	if animation_data.progress == 1 then
		return 
	end

	animation_data.timer = animation_data.timer or animation_data.progress*FADE_IN
	animation_data.timer = animation_data.timer + dt
	animation_data.progress = math.clamp(animation_data.timer/FADE_IN, 0, 1)
	local menu_item = self._menu_items[index]
	local rect = self._selection_items[index]
	menu_item.style.text.text_color[2] = math.lerp(Colors.color_definitions.cheeseburger[2], 255, math.smoothstep(animation_data.progress, 0, 1))
	menu_item.style.text.text_color[3] = math.lerp(Colors.color_definitions.cheeseburger[3], 255, math.smoothstep(animation_data.progress, 0, 1))
	menu_item.style.text.text_color[4] = math.lerp(Colors.color_definitions.cheeseburger[4], 255, math.smoothstep(animation_data.progress, 0, 1))
	rect.style.simple_rect.size[1] = math.lerp(0, 400, math.smoothstep(animation_data.progress, 0, 1))

	return 
end
StateTitleScreenMainMenu.anim_deselect_button = function (self, animation_data, index, dt)
	if animation_data.progress == 0 then
		return 
	end

	animation_data.timer = animation_data.timer or animation_data.progress*FADE_IN
	animation_data.timer = animation_data.timer - dt
	animation_data.progress = math.clamp(animation_data.timer/FADE_IN, 0, 1)
	local menu_item = self._menu_items[index]
	local rect = self._selection_items[index]
	menu_item.style.text.text_color[2] = math.lerp(Colors.color_definitions.cheeseburger[2], 255, math.smoothstep(animation_data.progress, 0, 1))
	menu_item.style.text.text_color[3] = math.lerp(Colors.color_definitions.cheeseburger[3], 255, math.smoothstep(animation_data.progress, 0, 1))
	menu_item.style.text.text_color[4] = math.lerp(Colors.color_definitions.cheeseburger[4], 255, math.smoothstep(animation_data.progress, 0, 1))
	rect.style.simple_rect.size[1] = math.lerp(0, 400, math.smoothstep(animation_data.progress, 0, 1))

	return 
end
StateTitleScreenMainMenu._render = function (self, dt, t)
	UIRenderer.begin_pass(self._ui_renderer, self._ui_scenegraph, nil, dt)

	for _, menu_item in ipairs(self._menu_items) do
		UIRenderer.draw_widget(self._ui_renderer, menu_item)
	end

	for _, selection_item in ipairs(self._selection_items) do
		UIRenderer.draw_widget(self._ui_renderer, selection_item)
	end

	UIRenderer.end_pass(self._ui_renderer)

	return 
end
StateTitleScreenMainMenu.on_exit = function (self)
	return 
end
StateTitleScreenMainMenu.cb_fade_in_done = function (self, level_key)
	self.parent.state = StateLoading
	self.parent.parent.loading_context.restart_network = true
	self.parent.parent.loading_context.level_key = level_key

	if level_key == "tutorial" then
		Managers.backend:make_tutorial()

		self.parent.parent.loading_context.wanted_profile_index = 4
	end

	return 
end

return 
