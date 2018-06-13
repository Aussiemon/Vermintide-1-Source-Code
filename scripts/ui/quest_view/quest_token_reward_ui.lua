local definitions = local_require("scripts/ui/quest_view/quest_token_reward_ui_definitions")
local scenegraph_definition = definitions.scenegraph_definition
local animation_definitions = definitions.animation_definitions
local DO_RELOAD = false
QuestTokenRewardUI = class(QuestTokenRewardUI)

QuestTokenRewardUI.init = function (self, ingame_ui_context, input_service_name, world, viewport)
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.loaded_packages = {}
	self.ui_animations = {}
	self.reward_world = world
	self.reward_viewport = viewport
	self.input_service_name = input_service_name
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.peer_id = ingame_ui_context.peer_id
	self.player_manager = ingame_ui_context.player_manager

	self:_create_ui_elements()
	rawset(_G, "quest_token_reward_ui", self)
end

QuestTokenRewardUI._create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	local widget_definitions = definitions.widget_definitions
	local text_widget_definitions = definitions.text_widget_definitions
	local widgets = {}

	for name, definition in pairs(widget_definitions) do
		widgets[name] = UIWidget.init(definition)
	end

	self._widgets = widgets
	widgets.name_text.style.text.localize = false
	widgets.type_text.style.text.localize = false

	UIRenderer.clear_scenegraph_queue(self.ui_top_renderer)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, animation_definitions)
end

QuestTokenRewardUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

QuestTokenRewardUI.start = function (self, reward)
	local token_rarity = reward.token_type
	local token_amount = reward.amount
	local token_texture_types = QuestSettings.token_type_to_large_icon_lookup
	local token_name_types = QuestSettings.token_name_by_type_lookup
	local token_texture = token_texture_types[token_rarity]
	local token_color = Colors.get_table(token_rarity)
	local widgets = self._widgets
	widgets.icon.content.texture_id = token_texture
	widgets.token_glow.style.texture_id.color = token_color
	local widget_name_text = self._widgets.name_text
	local widget_type_text = self._widgets.type_text
	local display_key = token_name_types[token_rarity]
	widget_name_text.content.text = Localize(display_key)
	widget_type_text.content.text = "x" .. tostring(token_amount)
	self._presentation_anim_id = self:_start_reward_animation("token")
end

QuestTokenRewardUI.stop = function (self)
	self.presentation_done = nil

	if self._presentation_anim_id then
		self.ui_animator:stop_animation(self._presentation_anim_id)

		self._presentation_anim_id = nil
	end
end

QuestTokenRewardUI.done = function (self)
	return self.presentation_done
end

QuestTokenRewardUI.destroy = function (self)
	self.ui_animator = nil
	self.presentation_done = nil

	rawset(_G, "quest_token_reward_ui", nil)
end

QuestTokenRewardUI.update = function (self, dt, t)
	if DO_RELOAD then
		self:_create_ui_elements()

		DO_RELOAD = false
	end

	local ui_animator = self.ui_animator

	ui_animator:update(dt)

	if not self.presentation_done and self._presentation_anim_id and ui_animator:is_animation_completed(self._presentation_anim_id) then
		self.presentation_done = true
	end

	if self._presentation_anim_id then
		self:_draw(dt)
	end
end

QuestTokenRewardUI._draw = function (self, dt)
	local ui_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service(self.input_service_name)
	local gamepad_active = input_manager:is_device_active("gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	local widgets = self._widgets

	for key, widget in pairs(widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)
end

QuestTokenRewardUI._start_reward_animation = function (self, animation_name)
	local params = {
		wwise_world = self.wwise_world
	}

	return self.ui_animator:start_animation(animation_name, self._widgets, scenegraph_definition, params)
end

return
