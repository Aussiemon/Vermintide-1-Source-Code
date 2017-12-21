local definitions = local_require("scripts/ui/views/ingame_voting_ui_definitions")
IngameVotingUI = class(IngameVotingUI)
IngameVotingUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.voting_manager = ingame_ui_context.voting_manager
	self.platform = Application.platform()

	self.create_ui_elements(self)
	rawset(_G, "ingame_voting_ui", self)

	return 
end
local RELOAD_UI = true
IngameVotingUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	local widget_definitions = definitions.widget_definitions
	self.background = UIWidget.init(widget_definitions.background)
	self.option_yes = UIWidget.init(widget_definitions.option_yes)
	self.option_no = UIWidget.init(widget_definitions.option_no)
	RELOAD_UI = false

	return 
end
IngameVotingUI.destroy = function (self)
	rawset(_G, "ingame_voting_ui", nil)

	return 
end
IngameVotingUI.setup_option = function (self, option_widget, option)
	local text = option.text
	local input_text = self.button_data_by_input_action(self, option.input)
	local option_text = sprintf("(%s) %s", input_text, Localize(text))
	option_widget.content.option_text = option_text

	return 
end
IngameVotingUI.start_vote = function (self, active_voting)
	local vote_template = active_voting.template
	local title_text = vote_template.text

	if vote_template.modify_title_text then
		title_text = vote_template.modify_title_text(title_text, active_voting.data)
	end

	self.background.content.info_text = title_text
	local info_text_style = self.background.style.info_text
	local font = UIFontByResolution(info_text_style)
	local width = self.ui_scenegraph.info_text.size[1]*RESOLUTION_LOOKUP.inv_scale
	local lines = UIRenderer.word_wrap(self.ui_renderer, title_text, font[1], info_text_style.font_size, width)
	local text_width, text_height = UIRenderer.text_size(self.ui_renderer, title_text, font[1], info_text_style.font_size)
	text_height = text_height*RESOLUTION_LOOKUP.scale
	local size_y = text_height*#lines

	if size_y < 53 then
		size_y = 53
	end

	self.ui_scenegraph.info_text.size[2] = size_y
	self.ui_scenegraph.info_box.size[2] = size_y
	local vote_options = vote_template.vote_options

	self.setup_option(self, self.option_yes, vote_options[1])
	self.setup_option(self, self.option_no, vote_options[2])

	self.voters = {}
	self.vote_results = {
		[1.0] = 0,
		[2.0] = 0
	}
	self.vote_started = true
	self.has_voted = false
	self.option_yes.content.has_voted = false
	self.option_no.content.has_voted = false
	self.option_yes.content.result_text = tostring(0)
	self.option_no.content.result_text = tostring(0)

	return 
end
IngameVotingUI.update_vote = function (self, votes)
	local result_boxes = self.result_boxes
	local voters = self.voters

	for peer_id, vote in pairs(votes) do
		if not voters[peer_id] then
			voters[peer_id] = peer_id
			self.vote_results[vote] = self.vote_results[vote] + 1

			if peer_id == Network.peer_id() then
				self.has_voted = true
				self.option_yes.content.has_voted = true
				self.option_no.content.has_voted = true
			end

			local option = nil

			if vote == 1 then
				option = self.option_yes
			elseif vote == 2 then
				option = self.option_no
			else
				error("You done wrong.")
			end

			option.content.result_text = tostring(self.vote_results[vote])

			if self.has_voted then
				self.animate_option_get_vote(self, option)
			end
		end
	end

	return 
end
IngameVotingUI.start_finish = function (self, previous_voting_info, t)
	self.on_finish = true
	self.finish_time = t + 2
	self.finish_anim_t = 0
	local option = nil

	if previous_voting_info.vote_result == 1 then
		option = self.option_yes
	elseif previous_voting_info.vote_result == 2 or previous_voting_info.vote_result == 0 then
		option = self.option_no
	else
		error("Sillybillywilly")
	end

	self.finish_option = option

	self.update_vote(self, previous_voting_info.votes)

	return 
end
IngameVotingUI.stop_finish = function (self)
	self.finish_option.style.glow_effect_texture.color[1] = 0
	self.finish_option = nil
	self.on_finish = nil

	return 
end
IngameVotingUI.update_finish = function (self, dt, t)
	if self.finish_time <= t then
		self.stop_finish(self)
	else
		self.finish_anim_t = self.finish_anim_t + dt*8
		local value = math.sirp(0, 1, self.finish_anim_t)

		if 0.5 < value then
			self.finish_option.style.glow_effect_texture.color[1] = 255
		else
			self.finish_option.style.glow_effect_texture.color[1] = 0
		end
	end

	return 
end
IngameVotingUI.update = function (self, dt, t)
	if RELOAD_UI then
		self.create_ui_elements(self)

		self.vote_started = false
	end

	local voting_manager = self.voting_manager

	if voting_manager.vote_in_progress(voting_manager) and voting_manager.is_ingame_vote(voting_manager) then
		if not self.vote_started then
			if self.on_finish then
				self.stop_finish(self)
			end

			self.start_vote(self, voting_manager.active_voting)
		end

		self.update_vote(self, voting_manager.active_voting.votes)
		self.draw(self, dt)
	elseif self.vote_started then
		local previous_voting_info = voting_manager.previous_vote_info(voting_manager)

		self.start_finish(self, previous_voting_info, t)

		self.vote_started = nil
	end

	if self.on_finish then
		self.update_finish(self, dt, t)
		self.draw(self, dt)
	end

	return 
end
IngameVotingUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.background)
	UIRenderer.draw_widget(ui_renderer, self.option_yes)
	UIRenderer.draw_widget(ui_renderer, self.option_no)
	UIRenderer.end_pass(ui_renderer)

	return 
end
IngameVotingUI.button_data_by_input_action = function (self, input_action)
	local platform = self.platform
	local active_devices, active_platform = nil

	if platform == "ps4" or platform == "xb1" then
		active_devices = {
			"gamepad"
		}
		active_platform = platform
	elseif platform == "win32" then
		if self.input_manager:is_device_active("gamepad") then
			active_devices = {
				"gamepad"
			}
			active_platform = "xb1"
		else
			active_devices = {
				"keyboard",
				"mouse"
			}
			active_platform = platform
		end
	end

	local input_service = self.input_manager:get_service("Player")
	local keymap_bindings = input_service.get_keymapping(input_service, input_action)
	local input_mappings = keymap_bindings.input_mappings
	local button_text = nil

	for i = 1, #input_mappings, 1 do
		local input_mapping = input_mappings[i]

		for j = 1, input_mapping.n, 3 do
			local device_type = input_mapping[j]
			local key_index = input_mapping[j + 1]
			local key_action_type = input_mapping[j + 2]

			for k = 1, #active_devices, 1 do
				local active_device = active_devices[k]

				if device_type == active_device then
					if active_device == "keyboard" then
						button_text = Keyboard.button_locale_name(key_index)
					elseif active_device == "mouse" then
						button_text = Mouse.button_name(key_index)
					else
						button_text = Pad1.button_name(key_index)
					end

					return button_text
				end
			end
		end
	end

	return 
end
local math_ease_cubic = math.easeCubic
IngameVotingUI.animate_option_get_vote = function (self, option)
	local fade_in_time = 0.1
	local fade_out_time = 0.1
	local anim_time = fade_in_time + fade_out_time
	fade_in_time = fade_in_time/anim_time
	fade_out_time = fade_out_time/anim_time

	local function anim_func(t)
		if t < fade_in_time then
			return math_ease_cubic(t/fade_in_time)
		elseif 0 < fade_out_time then
			return math_ease_cubic((t - 1)/fade_out_time)
		else
			return 0
		end

		return 
	end

	local start_size = 24
	local target_size = 28
	local target = option.style.result_text
	local target_index = "font_size"
	local nudge_animation = UIAnimation.init(UIAnimation.function_by_time, target, target_index, start_size, target_size, anim_time, anim_func)

	UIWidget.animate(option, nudge_animation)

	return 
end

return 
