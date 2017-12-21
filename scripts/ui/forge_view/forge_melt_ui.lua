require("scripts/settings/forge_settings")

local definitions = dofile("scripts/ui/forge_view/forge_melt_ui_definitions")
local num_item_buttons = definitions.settings.num_item_buttons
ForgeMeltUI = class(ForgeMeltUI)
local drag_colors = {
	normal = Colors.get_color_table_with_alpha("drag_same_slot", 255),
	hover = Colors.get_color_table_with_alpha("drag_same_slot_hover", 255)
}
ForgeMeltUI.init = function (self, parent, position, animation_definitions, ingame_ui_context)
	self.world = ingame_ui_context.world
	self.player_manager = ingame_ui_context.player_manager
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.item_list = {}
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.widget_definitions = definitions.widget_definitions
	self.scenegraph_definition = definitions.scenegraph_definition
	self.scenegraph_definition.page_root.position = position

	self.create_ui_elements(self)

	self.animations = {}
	self.ui_animator = UIAnimator:new(self.ui_scenegraph, animation_definitions)

	return 
end
ForgeMeltUI.on_enter = function (self)
	return 
end
ForgeMeltUI.set_gamepad_focus = function (self, enabled)
	self.use_gamepad = enabled

	return 
end
ForgeMeltUI.handle_gamepad_input = function (self, dt)
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "forge_view")
	local use_gamepad = self.use_gamepad
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	elseif use_gamepad and self.melting and input_service.get(input_service, "special_1") then
		self.controller_cooldown = GamepadSettings.menu_cooldown

		self.abort_melt(self)
	end

	return 
end
ForgeMeltUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.widgets = {}
	self.widgets_by_name = {}

	for widget_name, widget_definition in pairs(definitions.widgets_definitions) do
		self.widgets_by_name[widget_name] = UIWidget.init(widget_definition)
		self.widgets[#self.widgets + 1] = self.widgets_by_name[widget_name]
	end

	local eye_glow_left_widget = self.widgets_by_name.eye_glow_left_widget
	local eye_glow_right_widget = self.widgets_by_name.eye_glow_right_widget
	local progress_bar_glow_widget = self.widgets_by_name.progress_bar_glow
	eye_glow_left_widget.style.texture_id.color[1] = 0
	eye_glow_right_widget.style.texture_id.color[1] = 0
	progress_bar_glow_widget.style.texture_id.color[1] = 0

	UIRenderer.clear_scenegraph_queue(self.ui_top_renderer)

	return 
end
ForgeMeltUI.update = function (self, dt)
	self.item_to_melt = nil
	self.melted_item_id = nil

	for name, animation in pairs(self.animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self.animations[name] = nil

			if name == "melt_progress" then
				self.on_melt_complete(self)
			end
		end
	end

	self.handle_gamepad_input(self, dt)

	local melt_button_widget = self.widgets_by_name.melt_button_widget

	if melt_button_widget.content.button_hotspot.on_hover_enter then
		self.play_sound(self, "Play_hud_hover")
	end

	self.ui_animator:update(dt)

	self.specific_slot_index = nil

	return 
end
ForgeMeltUI.is_slot_hovered = function (self, is_dragging_item)
	local melt_button_widget = self.widgets_by_name.melt_button_widget
	local internal_is_hover = melt_button_widget.content.button_hotspot.internal_is_hover

	return internal_is_hover
end
ForgeMeltUI.on_melt_button_pressed = function (self)
	local melt_button_widget = self.widgets_by_name.melt_button_widget

	return melt_button_widget.content.button_hotspot.on_release
end
ForgeMeltUI.toggle_melt_mode = function (self, enabled, force_shutdown)
	local widgets_by_name = self.widgets_by_name
	local description_widget = widgets_by_name.description_text_1
	local melt_button_widget = widgets_by_name.melt_button_widget
	melt_button_widget.content.is_selected = enabled

	if enabled then
		description_widget.content.text = "melt_description_2"
	else
		description_widget.content.text = "melt_description_1"
	end

	local eye_glow_left_widget = self.widgets_by_name.eye_glow_left_widget
	local eye_glow_right_widget = self.widgets_by_name.eye_glow_right_widget

	if enabled then
		if not self.animations.eye_glow_left then
			self.animations.eye_glow_left = UIAnimation.init(UIAnimation.pulse_animation, eye_glow_left_widget.style.texture_id.color, 1, 150, 255, 2)
		end

		if not self.animations.eye_glow_right then
			self.animations.eye_glow_right = UIAnimation.init(UIAnimation.pulse_animation, eye_glow_right_widget.style.texture_id.color, 1, 150, 255, 2)
		end
	else
		self.animations.eye_glow_left = nil
		self.animations.eye_glow_right = nil
		eye_glow_left_widget.style.texture_id.color[1] = 0
		eye_glow_right_widget.style.texture_id.color[1] = 0

		if self.melting then
			self.abort_melt(self, force_shutdown)
		end
	end

	return 
end
ForgeMeltUI.draw = function (self, dt)
	local ui_top_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("forge_view")
	local gamepad_active = Managers.input:get_device("gamepad").active()

	UIRenderer.begin_pass(ui_top_renderer, ui_scenegraph, input_service, dt)

	local num_widgets = #self.widgets

	for i = 1, num_widgets, 1 do
		local widget = self.widgets[i]

		UIRenderer.draw_widget(ui_top_renderer, widget)
	end

	UIRenderer.end_pass(ui_top_renderer)

	return 
end
ForgeMeltUI.melt = function (self, item_name, number_of_tokens)
	local item_data = ItemMasterList[item_name]
	local rarity = item_data.rarity
	local rarity_color = Colors.get_table(rarity)
	local melt_reward_settings = ForgeSettings.melt_reward[rarity]
	local token_type = melt_reward_settings.token_type
	local token_texture = melt_reward_settings.token_texture
	local widgets_by_name = self.widgets_by_name
	local item_name_widget = widgets_by_name.text_frame_item_name
	local item_icon_widget = widgets_by_name.text_frame_reward_icon
	local frame_title_widget = widgets_by_name.text_frame_title
	local reward_title_widget = widgets_by_name.text_frame_reward_title
	local reward_divider_widget = widgets_by_name.text_frame_reward_divider
	local name_style = item_name_widget.style
	local name_content = item_name_widget.content
	name_content.text = item_data.display_name
	name_style.text.text_color = rarity_color
	local icon_style = item_icon_widget.style
	local icon_content = item_icon_widget.content
	icon_content.texture_id = token_texture .. "_large"
	icon_content.text = number_of_tokens .. "x"
	local target_table_index = 1
	local from = 0
	local to = 255
	local animation_time = 0.5
	local animation_name = "melting_reward"
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, name_style.text.text_color, target_table_index, from, to, animation_time, math.easeInCubic)
	self.animations[animation_name .. "_1"] = UIAnimation.init(UIAnimation.function_by_time, icon_style.texture_id.color, target_table_index, from, to, animation_time, math.easeInCubic)
	self.animations[animation_name .. "_2"] = UIAnimation.init(UIAnimation.function_by_time, reward_divider_widget.style.texture_id.color, target_table_index, from, to, animation_time, math.easeInCubic)
	self.animations[animation_name .. "_3"] = UIAnimation.init(UIAnimation.function_by_time, icon_style.text.text_color, target_table_index, from, to, animation_time, math.easeInCubic)
	self.animations[animation_name .. "_4"] = UIAnimation.init(UIAnimation.function_by_time, frame_title_widget.style.text.text_color, target_table_index, from, to, animation_time, math.easeInCubic)
	self.animations[animation_name .. "_5"] = UIAnimation.init(UIAnimation.function_by_time, reward_title_widget.style.text.text_color, target_table_index, from, to, animation_time, math.easeInCubic)
	local progress_bar_glow_widget = widgets_by_name.progress_bar_glow
	self.animations[animation_name .. "_6"] = UIAnimation.init(UIAnimation.function_by_time, progress_bar_glow_widget.style.texture_id.color, target_table_index, from, to, 0.2, math.easeCubic, UIAnimation.function_by_time, self.ui_scenegraph.progress_bar.size, target_table_index, 0, 0, 0.01, math.easeCubic, UIAnimation.function_by_time, progress_bar_glow_widget.style.texture_id.color, target_table_index, to, from, 0.2, math.easeOutCubic)

	self.set_reward_description_visibility(self, true)

	return 
end
ForgeMeltUI.start_melt_progress = function (self, item_backend_id)
	self.play_sound(self, "Play_hud_forge_melt_process")

	self.item_id_to_melt = item_backend_id
	local animation_name = "melt_progress"
	local animation_time = 1.5
	local from = 0
	local to = 231
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, self.ui_scenegraph.progress_bar.size, 1, from, to, animation_time, math.easeOutCubic)
	self.melting = true

	self.cancel_abort_animation(self)

	return 
end
ForgeMeltUI.abort_melt = function (self, force_shutdown)
	local animation_name = "melt_progress"
	self.animations[animation_name] = nil
	self.melting = nil
	self.ui_scenegraph.progress_bar.size[1] = 0

	if force_shutdown then
		self.cancel_abort_animation(self)
	else
		self.start_abort_animation(self)
	end

	return 
end
ForgeMeltUI.start_abort_animation = function (self)
	local animation_name = "melt_abort"
	local from = 0
	local to = 255
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.progress_bar_abort_text
	self.animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, widget.style.text.text_color, 1, from, to, 0.2, math.easeInCubic, UIAnimation.wait, 0.3, UIAnimation.function_by_time, widget.style.text.text_color, 1, to, from, 0.3, math.easeInCubic)

	return 
end
ForgeMeltUI.cancel_abort_animation = function (self)
	local animation_name = "melt_abort"
	local widgets_by_name = self.widgets_by_name
	local widget = widgets_by_name.progress_bar_abort_text
	widget.style.text.text_color[1] = 0
	self.animations[animation_name] = nil

	return 
end
ForgeMeltUI.on_melt_complete = function (self)
	self.melted_item_id = self.item_id_to_melt
	self.melting = nil

	return 
end
ForgeMeltUI.clear = function (self)
	self.toggle_melt_mode(self, false)
	self.set_reward_description_visibility(self, false)

	return 
end
ForgeMeltUI.set_reward_description_visibility = function (self, visible)
	local widgets_by_name = self.widgets_by_name
	local item_name_widget = widgets_by_name.text_frame_item_name
	local item_icon_widget = widgets_by_name.text_frame_reward_icon
	local frame_title_widget = widgets_by_name.text_frame_title
	local reward_title_widget = widgets_by_name.text_frame_reward_title
	local reward_divider_widget = widgets_by_name.text_frame_reward_divider
	item_name_widget.content.visible = visible
	item_icon_widget.content.visible = visible
	frame_title_widget.content.visible = visible
	reward_title_widget.content.visible = visible
	reward_divider_widget.content.visible = visible

	return 
end
ForgeMeltUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
ForgeMeltUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end
ForgeMeltUI.destroy = function (self)
	self.ui_animator = nil

	return 
end

return 
