InputHelperUI = class(InputHelperUI)
local scenegraph_definition = {
	root = {
		is_root = true,
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.cutscene
		}
	},
	background_overlay = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.cutscene
		}
	},
	helper_screen = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1365,
			800
		},
		position = {
			0,
			0,
			1
		}
	},
	helper_screen_gamepad = {
		vertical_alignment = "center",
		parent = "helper_screen",
		horizontal_alignment = "center",
		size = {
			808,
			544
		},
		position = {
			0,
			0,
			1
		}
	},
	input_description_text = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			800,
			50
		},
		position = {
			0,
			-460,
			1
		}
	}
}
local widget_definitions = {
	helper_screen = UIWidgets.create_simple_texture("pc_input_overlay", "helper_screen"),
	helper_screen_gamepad = UIWidgets.create_simple_texture("controller_input_overlay", "helper_screen_gamepad"),
	background_overlay = UIWidgets.create_simple_rect("background_overlay", Colors.get_color_table_with_alpha("black", 200)),
	input_description_text = UIWidgets.create_simple_text("press_any_key_to_continue", "input_description_text", 18, Colors.get_color_table_with_alpha("white", 255))
}

InputHelperUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.platform = Application.platform()
	self.ui_animations = {}

	self:create_ui_elements()

	if not SaveData.input_helper_displayed and Application.platform() ~= "ps4" then
		self.show_at_startup = true
	end
end

InputHelperUI.display_first_time = function (self)
	self.active = true
	self.close_cooldown = 3
	self.show_at_startup = nil
end

InputHelperUI.create_ui_elements = function (self)
	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self.helper_screen_widget = UIWidget.init(widget_definitions.helper_screen)
	self.helper_screen_gamepad_widget = UIWidget.init(widget_definitions.helper_screen_gamepad)
	self.background_overlay_widget = UIWidget.init(widget_definitions.background_overlay)
	self.input_description_text_widget = UIWidget.init(widget_definitions.input_description_text)
end

InputHelperUI.destroy = function (self)
	GarbageLeakDetector.register_object(self, "input_helper_ui")
end

InputHelperUI.update_close_cooldown = function (self, dt)
	local close_cooldown = self.close_cooldown

	if close_cooldown then
		close_cooldown = close_cooldown - dt

		if close_cooldown > 0 then
			self.close_cooldown = close_cooldown
		else
			self.close_cooldown = nil

			self:save_game_info_read()
		end
	end
end

InputHelperUI.update = function (self, dt, t)
	self:update_close_cooldown(dt)

	if not self.close_cooldown then
		local input_manager = self.input_manager

		if not self.active then
			local in_fade_active = Managers.transition:in_fade_active()

			if not in_fade_active then
				local input_service = input_manager:get_service("Player")

				if input_service:get("toggle_input_helper") then
					self.active = true
				end
			end
		elseif input_manager:any_input_pressed() then
			self.active = nil
		end
	end

	if self.active then
		self:draw(dt, t)
	end
end

InputHelperUI.draw = function (self, dt, t)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("ingame_menu")
	local gamepad_active = input_manager:is_device_active("gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self.background_overlay_widget)

	if gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.helper_screen_gamepad_widget)
	else
		UIRenderer.draw_widget(ui_renderer, self.helper_screen_widget)
	end

	if not self.close_cooldown then
		local input_description_text_widget = self.input_description_text_widget
		input_description_text_widget.content.text = (gamepad_active and "press_any_button_to_continue") or "press_any_key_to_continue"

		UIRenderer.draw_widget(ui_renderer, input_description_text_widget)
	end

	UIRenderer.end_pass(ui_renderer)
end

InputHelperUI.save_game_info_read = function (self)
	local save_manager = Managers.save
	SaveData.input_helper_displayed = true

	save_manager:auto_save(SaveFileName, SaveData, callback(self, "on_save_ended_callback"))
end

InputHelperUI.on_save_ended_callback = function (self)
	print("[InputHelperUI] - Input helper screen shown saved")
end

return
