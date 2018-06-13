local definitions = local_require("scripts/ui/quest_view/quest_boon_reward_ui_definitions")
local scenegraph_definition = definitions.scenegraph_definition
local animation_definitions = definitions.animation_definitions
local DO_RELOAD = false
QuestBoonRewardUI = class(QuestBoonRewardUI)

QuestBoonRewardUI.init = function (self, ingame_ui_context, input_service_name, world, viewport)
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
	rawset(_G, "quest_boon_reward_ui", self)
end

QuestBoonRewardUI._create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	local widget_definitions = definitions.widget_definitions
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

QuestBoonRewardUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

QuestBoonRewardUI.start = function (self, reward)
	local boon_key = nil

	if reward then
		local data_type = type(reward.data)

		if data_type == "string" then
			boon_key = reward.data
		elseif data_type == "table" and #reward > 0 then
			boon_key = reward.data[1]
		end
	end

	local boon_template = BoonTemplates[boon_key]
	local texture = boon_template.quest_ui_icon
	local duration_text = self:_get_readable_boon_duration(boon_template.duration)
	local boon_name = boon_template.ui_name
	local widget_boon_icon = self._widgets.boon_icon
	local widget_name_text = self._widgets.name_text
	local widget_type_text = self._widgets.type_text
	widget_boon_icon.content.texture_id = boon_template.ui_icon
	widget_name_text.content.text = Localize(boon_name)
	widget_type_text.content.text = duration_text

	self:play_sound("Play_hud_quest_menu_finish_quest_turn_in_reward_boon_transform")

	self._presentation_anim_id = self:_start_reward_animation("boon")
end

QuestBoonRewardUI.stop = function (self)
	self.presentation_done = nil

	if self._presentation_anim_id then
		self.ui_animator:stop_animation(self._presentation_anim_id)

		self._presentation_anim_id = nil
	end
end

QuestBoonRewardUI.done = function (self)
	return self.presentation_done
end

QuestBoonRewardUI.destroy = function (self)
	self.ui_animator = nil
	self.presentation_done = nil

	rawset(_G, "quest_boon_reward_ui", nil)
end

QuestBoonRewardUI.update = function (self, dt, t)
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

QuestBoonRewardUI._draw = function (self, dt)
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

QuestBoonRewardUI._start_reward_animation = function (self, animation_name)
	local params = {
		wwise_world = self.wwise_world
	}

	return self.ui_animator:start_animation(animation_name, self._widgets, scenegraph_definition, params)
end

QuestBoonRewardUI._get_readable_boon_duration = function (self, duration)
	local text = ""

	if duration and duration > 0 then
		local days = math.floor(duration / 86400)
		local hours = math.floor(duration / 3600)
		local minutes = math.floor(duration / 60)
		local seconds = math.floor(duration)

		if days > 0 then
			text = tostring(days) .. "d"
		elseif hours > 0 then
			text = tostring(hours) .. "h"
		elseif minutes > 0 then
			text = tostring(minutes) .. "m"
		elseif seconds >= 0 then
			text = tostring(seconds) .. "s"
		end
	end

	return text
end

return
