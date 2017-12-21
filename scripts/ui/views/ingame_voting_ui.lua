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
local RELOAD_UI = false
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
	self.voting_manager:allow_vote_input(false)

	self.voting_manager = nil

	rawset(_G, "ingame_voting_ui", nil)

	return 
end
IngameVotingUI.setup_option_input = function (self, option_widget, option)
	local text = option.text
	local button_texture_data, input_text = self.button_texture_data_by_input_action(self, option.input)
	option_widget.content.input_text = (button_texture_data and "") or sprintf("(%s)", input_text)
	option_widget.content.input_icon = (button_texture_data and button_texture_data.texture) or nil

	if button_texture_data then
		local input_icon_scenegraph_id = option_widget.style.input_icon.scenegraph_id
		local input_icon_size = self.ui_scenegraph[input_icon_scenegraph_id].size
		input_icon_size[1] = button_texture_data.size[1]
		input_icon_size[2] = button_texture_data.size[2]
	end

	return 
end
IngameVotingUI.start_vote = function (self, active_voting)
	self.clear_input_progress(self)

	local vote_template = active_voting.template

	if vote_template.can_start_vote then
		local can_start_vote = vote_template.can_start_vote(active_voting.data)

		if not can_start_vote then
			local text = vote_template.text or "Unknown vote"

			print(string.format("[IngameVotingUI] - Terminating vote request (%s) due to the requirements to start was not fulfilled.", text))

			return 
		end
	end

	local title_text = vote_template.text

	if vote_template.modify_title_text then
		title_text = vote_template.modify_title_text(Localize(title_text), active_voting.data)
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

	local vote_options = vote_template.vote_options

	self.setup_option_input(self, self.option_yes, vote_options[1])
	self.setup_option_input(self, self.option_no, vote_options[2])

	self.voters = {}
	self.vote_results = {
		[1.0] = 0,
		[2.0] = 0
	}
	self.vote_started = true
	self.has_voted = false
	self.option_yes.content.has_voted = false
	self.option_no.content.has_voted = false
	self.background.content.has_voted = false
	self.option_yes.content.result_text = tostring(0)
	self.option_no.content.result_text = tostring(0)
	self.gamepad_active = self.input_manager:is_device_active("gamepad")

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
				self.background.content.has_voted = true

				self.voting_manager:allow_vote_input(false)
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
			option.content.option_text = sprintf("(%s)", tostring(self.vote_results[vote]))

			if self.has_voted then
				self.animate_option_get_vote(self, option)
			end
		end
	end

	local voting_manager = self.voting_manager
	local vote_time_left = voting_manager.vote_time_left(voting_manager)
	local time_text = (vote_time_left and string.format(" %02d:%02d", math.floor(vote_time_left/60), vote_time_left%60)) or "00:00"
	self.background.content.title_text = time_text

	return 
end
IngameVotingUI.start_finish = function (self, previous_voting_info, t)
	self.clear_input_progress(self)

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
	self.update_can_vote(self, false)

	self.menu_active = nil

	return 
end
IngameVotingUI.stop_finish = function (self)
	self.option_no.style.option_texture.color[1] = 255
	self.option_yes.style.option_texture.color[1] = 255
	self.option_no.style.result_text.text_color[1] = 255
	self.option_yes.style.result_text.text_color[1] = 255
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
			self.finish_option.style.option_texture.color[1] = 255
			self.finish_option.style.result_text.text_color[1] = 255
		else
			self.finish_option.style.option_texture.color[1] = 180
			self.finish_option.style.result_text.text_color[1] = 180
		end
	end

	return 
end
IngameVotingUI.update = function (self, menu_active, dt, t)
	if RELOAD_UI then
		self.create_ui_elements(self)

		self.vote_started = false
	end

	local voting_manager = self.voting_manager
	local hold_input_pressed = false

	if voting_manager.vote_in_progress(voting_manager) and voting_manager.is_ingame_vote(voting_manager) then
		if menu_active ~= self.menu_active then
			self.menu_active = menu_active

			self.update_can_vote(self, menu_active)
		end

		if not self.vote_started then
			if self.on_finish then
				self.stop_finish(self)
			end

			self.start_vote(self, voting_manager.active_voting)
		end

		hold_input_pressed = self.update_input_progress(self, voting_manager.active_voting)

		self.update_vote(self, voting_manager.active_voting.votes)

		if not self.has_voted then
			local gamepad_active = self.input_manager:is_device_active("gamepad")

			if self.gamepad_active ~= gamepad_active then
				local active_voting = voting_manager.active_voting
				local vote_template = active_voting and active_voting.template

				if vote_template then
					local vote_options = vote_template.vote_options

					self.setup_option_input(self, self.option_yes, vote_options[1])
					self.setup_option_input(self, self.option_no, vote_options[2])

					self.gamepad_active = gamepad_active
				end
			end
		end

		self.draw(self, dt, hold_input_pressed)
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
IngameVotingUI.draw = function (self, dt, hold_input_pressed)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")

	self.update_pulse_animations(self, dt, hold_input_pressed)
	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.background)
	UIRenderer.draw_widget(ui_renderer, self.option_yes)
	UIRenderer.draw_widget(ui_renderer, self.option_no)
	UIRenderer.end_pass(ui_renderer)

	return 
end
IngameVotingUI.update_pulse_animations = function (self, dt, hold_input_pressed)
	if self.has_voted then
		return 
	end

	local menu_active = self.menu_active
	local speed_multiplier = (menu_active and 5) or 8
	local time_since_launch = Application.time_since_launch()
	local progress = (not menu_active or not hold_input_pressed or 0) and math.sin(time_since_launch*speed_multiplier)*0.5 + 0.5

	if menu_active then
		local alpha = progress*50 + 50
		self.option_no.style.bar_bg.color[1] = alpha
		self.option_yes.style.bar_bg.color[1] = alpha
	else
		local alpha = progress*155 + 100
		self.background.style.input_text.text_color[1] = alpha
	end

	return 
end
IngameVotingUI.update_can_vote = function (self, enabled)
	self.background.content.can_vote = enabled
	self.option_yes.content.can_vote = enabled
	self.option_no.content.can_vote = enabled

	self.voting_manager:allow_vote_input(enabled)

	return 
end
IngameVotingUI.button_texture_data_by_input_action = function (self, input_action)
	local input_manager = self.input_manager
	local input_service = self.input_manager:get_service("ingame_menu")
	local keymap_bindings = input_service.get_keymapping(input_service, input_action)
	local input_mappings = keymap_bindings.input_mappings
	local platform = Application.platform()

	for i = 1, #input_mappings, 1 do
		local input_mapping = input_mappings[i]

		for j = 1, input_mapping.n, 3 do
			local device_type = input_mapping[j]
			local key_index = input_mapping[j + 1]
			local key_action_type = input_mapping[j + 2]
			local button_name = nil

			if input_manager.is_device_active(input_manager, "keyboard") or input_manager.is_device_active(input_manager, "mouse") then
				if device_type == "keyboard" then
					button_name = Keyboard.button_locale_name(key_index)

					return nil, button_name
				elseif device_type == "mouse" then
					button_name = Mouse.button_name(key_index)

					return nil, button_name
				end
			elseif input_manager.is_device_active(input_manager, "gamepad") and device_type == "gamepad" then
				local button_texture_data = nil
				button_name = Pad1.button_name(key_index)

				if platform == "xb1" or platform == "win32" then
					button_texture_data = ButtonTextureByName(button_name, "xb1")
				else
					button_texture_data = ButtonTextureByName(button_name, "ps4")
				end

				return button_texture_data, button_name
			end
		end
	end

	return nil, ""
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
IngameVotingUI.update_input_progress = function (self, active_voting)
	local hold_input_pressed = false
	local current_hold_input = active_voting.current_hold_input
	local direction, input_widget, widget_to_clear = nil

	if current_hold_input == "ingame_vote_yes" then
		input_widget = self.option_yes
		widget_to_clear = self.option_no
		direction = "left"
	elseif current_hold_input == "ingame_vote_no" then
		input_widget = self.option_no
		widget_to_clear = self.option_yes
		direction = "right"
	end

	local input_hold_progress = active_voting.input_hold_progress or 0
	local anim_progress = math.smoothstep(input_hold_progress, 0, 1)

	if input_widget then
		local style = input_widget.style.bar
		local content = input_widget.content.bar
		local default_width = style.default_width
		local offset = style.offset
		local default_offset = style.default_offset
		local size = style.size
		local uvs = content.uvs

		if direction == "left" then
			size[1] = anim_progress*default_width
			uvs[1][1] = anim_progress - 1
			offset[1] = default_offset[1] + default_width - size[1]
		else
			size[1] = anim_progress*default_width
			uvs[2][1] = anim_progress
		end

		hold_input_pressed = true
	end

	if widget_to_clear then
		local style = widget_to_clear.style.bar
		local content = widget_to_clear.content.bar
		local default_width = style.default_width
		local offset = style.offset
		local default_offset = style.default_offset
		local size = style.size
		local uvs = content.uvs

		if direction == "left" then
			size[1] = 0
			uvs[2][1] = 0
		else
			size[1] = 0
			uvs[1][1] = 0
			offset[1] = default_offset[1]
		end

		hold_input_pressed = true
	end

	if not current_hold_input then
		self.option_no.style.bar.size[1] = 0
		self.option_yes.style.bar.size[1] = 0
		self.option_no.content.bar.uvs[2][1] = 1
		self.option_yes.content.bar.uvs[1][1] = 0
		self.option_yes.style.bar.offset[1] = self.option_yes.style.bar.default_offset[1]
	end

	return hold_input_pressed
end
IngameVotingUI.clear_input_progress = function (self)
	if self.option_yes then
		local style = self.option_yes.style.bar
		local content = self.option_yes.content.bar
		local default_width = style.default_width
		local offset = style.offset
		local default_offset = style.default_offset
		local size = style.size
		local uvs = content.uvs
		size[1] = 0
		uvs[1][1] = 0
		offset[1] = default_offset[1]
	end

	if self.option_no then
		local style = self.option_no.style.bar
		local content = self.option_no.content.bar
		local default_width = style.default_width
		local size = style.size
		local uvs = content.uvs
		size[1] = 0
		uvs[2][1] = 1
	end

	return 
end

return 
