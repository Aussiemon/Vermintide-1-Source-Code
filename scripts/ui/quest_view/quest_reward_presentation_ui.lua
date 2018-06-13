require("scripts/ui/quest_view/quest_boon_reward_ui")
require("scripts/ui/quest_view/quest_item_reward_ui")
require("scripts/ui/quest_view/quest_token_reward_ui")

local definitions = local_require("scripts/ui/quest_view/quest_reward_presentation_ui_definitions")
local animation_definitions = definitions.animation_definitions
local scenegraph_definition = definitions.scenegraph_definition
QuestRewardPresentationUI = class(QuestRewardPresentationUI)
local DO_RELOAD = false

QuestRewardPresentationUI.init = function (self, ingame_ui_context)
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)

	self:_create_world()

	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.peer_id = ingame_ui_context.peer_id
	self.player_manager = ingame_ui_context.player_manager
	local input_manager = self.input_manager
	local input_service_name = "quest_view"

	input_manager:create_input_service(input_service_name, "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager:map_device_to_service(input_service_name, "keyboard")
	input_manager:map_device_to_service(input_service_name, "mouse")
	input_manager:map_device_to_service(input_service_name, "gamepad")
	self:_create_ui_elements()

	self.presentations = {
		item = QuestItemRewardUI:new(ingame_ui_context, input_service_name, self.reward_world, self.reward_viewport),
		boon = QuestBoonRewardUI:new(ingame_ui_context, input_service_name, self.reward_world, self.reward_viewport),
		token = QuestTokenRewardUI:new(ingame_ui_context, input_service_name, self.reward_world, self.reward_viewport)
	}

	rawset(_G, "quest_reward_presentation_ui", self)
end

QuestRewardPresentationUI._create_world = function (self)
	local reward_world = self.world_manager:create_world("quest_menu_world", "environment/blank_offscreen", nil, 990)
	local reward_viewport = ScriptWorld.create_viewport(reward_world, "quest_menu_viewport_default", "default", 0)

	ScriptWorld.deactivate_viewport(reward_world, reward_viewport)

	self.reward_world = reward_world
	self.reward_viewport = reward_viewport
end

QuestRewardPresentationUI._create_ui_elements = function (self)
	self._num_active_reward_widgets = 0
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self.input_description_text = UIWidget.init(definitions.widget_definitions.input_description_text)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_animator = UIAnimator:new(self.ui_scenegraph, animation_definitions)
end

QuestRewardPresentationUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

QuestRewardPresentationUI.on_enter = function (self)
	ScriptWorld.activate(self.reward_world)
end

QuestRewardPresentationUI.exit = function (self)
	ScriptWorld.deactivate(self.reward_world)
end

QuestRewardPresentationUI.start_reward_presentation = function (self, rewards)
	self.presentation_started = true
	local reward_type = rewards.type

	if reward_type == "item" then
		self.presentation = self.presentations.item

		self.presentation:start(rewards)
	elseif reward_type == "token" then
		self.presentation = self.presentations.token

		self.presentation:start(rewards)
	elseif reward_type == "boon" then
		self.presentation = self.presentations.boon

		self.presentation:start(rewards)
	end

	ScriptWorld.activate_viewport(self.reward_world, self.reward_viewport)
end

QuestRewardPresentationUI.stop_reward_presentation = function (self)
	self.presentation_started = nil

	self.presentation:stop()

	self.presentation = nil
	local reward_world = self.reward_world

	ScriptWorld.deactivate_viewport(reward_world, self.reward_viewport)
end

QuestRewardPresentationUI.active = function (self)
	return self.presentation_started
end

QuestRewardPresentationUI.presentation_done = function (self)
	return self.presentation and self.presentation:done()
end

QuestRewardPresentationUI.input_service = function (self)
	return self.input_manager:get_service("quest_reward_presentation_screen_ui")
end

QuestRewardPresentationUI.destroy = function (self)
	for _, presentation in pairs(self.presentations) do
		presentation:destroy()
	end

	self.presentations = nil
	self.presentation = nil
	local reward_world = self.reward_world

	self.world_manager:destroy_world(reward_world)

	self.reward_world = nil
	self.ui_animator = nil

	rawset(_G, "quest_reward_presentation_ui", nil)
end

QuestRewardPresentationUI.update = function (self, dt, t)
	if DO_RELOAD then
		self:_create_ui_elements()

		DO_RELOAD = false
	end

	if self.presentation then
		self.presentation:update(dt, t)
	end

	local ui_animator = self.ui_animator

	ui_animator:update(dt)

	if self:presentation_done() and self.input_manager:any_input_pressed() then
		self:stop_reward_presentation()
	end

	self:_draw(dt)
end

QuestRewardPresentationUI._draw = function (self, dt)
	local ui_renderer = self.ui_top_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("quest_reward_presentation_screen_ui")
	local gamepad_active = input_manager:is_device_active("gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	if self:presentation_done() then
		local input_widgets = self._input_widgets
		self.input_description_text.content.text = (gamepad_active and "press_any_button_to_continue") or "press_any_key_to_continue"

		UIRenderer.draw_widget(ui_renderer, self.input_description_text)
	end

	UIRenderer.end_pass(ui_renderer)
end

QuestRewardPresentationUI._start_reward_animation = function (self, name, animation_name)
	local entry = name and self._reward_entries[name]
	local widget_index = entry and entry.widget_index
	local params = {
		wwise_world = self.wwise_world,
		widget_index = widget_index,
		num_widgets = self._num_active_reward_widgets
	}

	return self.ui_animator:start_animation(animation_name, self._widgets, scenegraph_definition, params)
end

return
