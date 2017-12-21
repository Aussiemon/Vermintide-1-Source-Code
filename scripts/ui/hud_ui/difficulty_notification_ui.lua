local definitions = local_require("scripts/ui/hud_ui/difficulty_notification_ui_definitions")
local scenegraph_definition = definitions.scenegraph_definition
local animation_definitions = definitions.animations
local survival_start_wave_by_difficulty = SurvivalStartWaveByDifficulty
DifficultyNotificationUI = class(DifficultyNotificationUI)
local DO_RELOAD = false
DifficultyNotificationUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.world = ingame_ui_context.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(self.world)
	self.difficulty_manager = Managers.state.difficulty
	self.ui_animations = {}

	self.create_ui_elements(self)
	self.difficulty_set(self)
	Managers.state.event:register(self, "difficulty_synced", "difficulty_set")
	rawset(_G, "difficulty_notification_ui", self)

	return 
end
DifficultyNotificationUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	local widget_definitions = definitions.widget_definitions
	self.background_top_widget = UIWidget.init(widget_definitions.background_top)
	self.background_center_widget = UIWidget.init(widget_definitions.background_center)
	self.background_bottom_widget = UIWidget.init(widget_definitions.background_bottom)
	self.difficulty_text_widget = UIWidget.init(widget_definitions.difficulty_text)
	self.difficulty_title_text_widget = UIWidget.init(widget_definitions.difficulty_title_text)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, animation_definitions)
	self.is_visible = true

	return 
end
DifficultyNotificationUI.difficulty_set = function (self)
	local level_key = Managers.state.game_mode:level_key()
	local level_settings = LevelSettings[level_key]
	local level_difficulties = self.difficulty_manager:get_level_difficulties(level_key)
	local current_difficulty = self.difficulty_manager:get_difficulty()
	local mirrored_level_difficulties = table.mirror_table(level_difficulties)
	local start_index = table.find(mirrored_level_difficulties, current_difficulty)

	if start_index then
		local original_start_wave = survival_start_wave_by_difficulty[current_difficulty]
		local persentation_wave_list = {}

		for i = start_index, #level_difficulties, 1 do
			local difficulty = level_difficulties[i]

			if difficulty ~= current_difficulty then
				local wave_by_difficulty = survival_start_wave_by_difficulty[difficulty]
				persentation_wave_list[#persentation_wave_list + 1] = wave_by_difficulty - original_start_wave
			end
		end

		self.next_presentation_wave = persentation_wave_list[1]
		self.persentation_wave_list = persentation_wave_list
	end

	return 
end
DifficultyNotificationUI.destroy = function (self)
	self.ui_animator = nil

	self.set_visible(self, false)
	rawset(_G, "difficulty_notification_ui", nil)

	return 
end
DifficultyNotificationUI.set_visible = function (self, visible)
	self.is_visible = visible

	return 
end
DifficultyNotificationUI._check_for_presentation_start = function (self, mission_data)
	local previous_wave_completed = self.previous_wave_completed or 0
	local wave_completed = mission_data.wave_completed - mission_data.starting_wave

	if wave_completed <= previous_wave_completed then
		return 
	end

	local next_presentation_wave = self.next_presentation_wave

	if next_presentation_wave == wave_completed then
		table.remove(self.persentation_wave_list, 1)

		self.next_presentation_wave = self.persentation_wave_list[1]

		self.display_presentation(self)
	end

	self.previous_wave_completed = wave_completed

	return 
end
DifficultyNotificationUI.update = function (self, dt, mission_data)
	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if self.next_presentation_wave then
		self._check_for_presentation_start(self, mission_data)
	end

	if not self.is_visible or not self.draw_widgets then
		return 
	end

	local is_dirty = nil
	local ui_animations = self.ui_animations

	if ui_animations then
		for name, animation in pairs(ui_animations) do
			is_dirty = true

			UIAnimation.update(animation, dt)

			if UIAnimation.completed(animation) then
				self.ui_animations[name] = nil
			end
		end
	end

	local ui_animator = self.ui_animator

	ui_animator.update(ui_animator, dt)

	local presentation_anim_id = self.presentation_anim_id

	if presentation_anim_id then
		if ui_animator.is_animation_completed(ui_animator, presentation_anim_id) then
			ui_animator.stop_animation(ui_animator, presentation_anim_id)

			self.presentation_anim_id = nil

			self.on_presentation_complete(self)
		end

		is_dirty = true
	end

	if not is_dirty then
		local resolution_modified = RESOLUTION_LOOKUP.modified

		if resolution_modified then
			is_dirty = true
		end
	end

	if is_dirty then
	end

	self.draw(self, dt)

	return 
end
DifficultyNotificationUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.background_top_widget)
	UIRenderer.draw_widget(ui_renderer, self.background_center_widget)
	UIRenderer.draw_widget(ui_renderer, self.background_bottom_widget)
	UIRenderer.draw_widget(ui_renderer, self.difficulty_text_widget)
	UIRenderer.draw_widget(ui_renderer, self.difficulty_title_text_widget)
	UIRenderer.end_pass(ui_renderer)

	return 
end
DifficultyNotificationUI.display_presentation = function (self)
	print("----display_presentation----")
	self.start_presentation_animation(self)

	self.draw_widgets = true

	return 
end
DifficultyNotificationUI.on_presentation_complete = function (self)
	self.draw_widgets = false

	return 
end
DifficultyNotificationUI.start_presentation_animation = function (self)
	local params = {
		wwise_world = self.wwise_world
	}
	local widgets = {
		background_top = self.background_top_widget,
		background_center = self.background_center_widget,
		background_bottom = self.background_bottom_widget,
		difficulty_text = self.difficulty_text_widget,
		difficulty_title_text = self.difficulty_title_text_widget
	}
	self.presentation_anim_id = self.ui_animator:start_animation("presentation", widgets, scenegraph_definition, params)

	return 
end

return 
