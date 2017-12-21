local definitions = local_require("scripts/ui/views/scoreboard_ui_definitions")
local leave_party_text = (Application.platform() == "xb1" and "input_description_leave_party_xb1") or "input_description_leave_party"
local generic_input_actions = {
	default = {
		{
			input_action = "l1_r1",
			priority = 1,
			description_text = "input_description_change_score",
			ignore_keybinding = true
		},
		{
			input_action = "confirm",
			priority = 3,
			description_text = "input_description_vote"
		},
		{
			input_action = "back",
			priority = 4,
			description_text = leave_party_text
		}
	},
	already_voted = {
		{
			input_action = "l1_r1",
			priority = 1,
			description_text = "input_description_change_score",
			ignore_keybinding = true
		},
		{
			input_action = "back",
			priority = 3,
			description_text = leave_party_text
		}
	},
	player_list = {
		{
			input_action = "l1_r1",
			priority = 1,
			description_text = "input_description_change_score",
			ignore_keybinding = true
		},
		{
			input_action = "back",
			priority = 3,
			description_text = leave_party_text
		}
	},
	player_list_profile = {
		{
			input_action = "l1_r1",
			priority = 1,
			description_text = "input_description_change_score",
			ignore_keybinding = true
		},
		{
			input_action = "confirm",
			priority = 2,
			description_text = (Application.platform() == "xb1" and "input_description_show_profile_xb1") or "input_description_show_profile"
		},
		{
			input_action = "back",
			priority = 3,
			description_text = leave_party_text
		}
	}
}
ScoreboardUI = class(ScoreboardUI)
local TOPICS_PER_PAGE = 3
local PLAYER_NAME_MAX_LENGTH = 16
ScoreboardUI.init = function (self, end_of_level_ui_context)
	self.game_won = end_of_level_ui_context.game_won

	if self.game_won then
		self.level_prefixes = {
			"level_prefix_next_long",
			"level_prefix_next_short"
		}
	else
		self.level_prefixes = {
			"level_prefix_next_retry",
			"level_prefix_next_short"
		}
	end

	self.render_settings = {
		snap_pixel_positions = true
	}
	self.ingame_ui = end_of_level_ui_context.ingame_ui
	self.popup_handler = self.ingame_ui.popup_handler
	self.ui_renderer = end_of_level_ui_context.ui_renderer
	self.stats_id = end_of_level_ui_context.stats_id
	local input_manager = end_of_level_ui_context.input_manager
	self.input_manager = input_manager
	self.world_manager = end_of_level_ui_context.world_manager
	self.network_lobby = end_of_level_ui_context.network_lobby
	self.voting_manager = Managers.state.voting

	input_manager.create_input_service(input_manager, "scoreboard_ui", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "scoreboard_ui", "keyboard")
	input_manager.map_device_to_service(input_manager, "scoreboard_ui", "mouse")
	input_manager.map_device_to_service(input_manager, "scoreboard_ui", "gamepad")

	self.platform = Application.platform()
	self.vote_manager = Managers.state.voting

	print("ScoreboardUI INIT:", self.vote_manager:vote_in_progress())
	rawset(_G, "ScoreboardUI_pointer", self)

	self.timers = {}
	self.ui_animations = {}

	self.create_ui_elements(self)

	self.topic_widgets_draw_count = 0
	local scoreboard_session_data = end_of_level_ui_context.scoreboard_session_data
	self.topic_score_data = scoreboard_session_data[1]
	self.player_list = scoreboard_session_data[2]
	local num_players = 0

	for stats_id, data in pairs(self.player_list) do
		num_players = num_players + 1
	end

	self._num_players = num_players
	self.number_of_topics = #self.topic_score_data
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.network_event_delegate = end_of_level_ui_context.network_event_delegate

	self.network_event_delegate:register(self, "rpc_start_specific_level")
	self.setup_level_voting(self)

	local input_service = input_manager.get_service(input_manager, "scoreboard_ui")
	local gui_layer = definitions.scenegraph.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(end_of_level_ui_context, self.ui_renderer, input_service, 5, gui_layer, generic_input_actions.default)

	return 
end
ScoreboardUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph)
	self.voting_widget_1 = UIWidget.init(definitions.widgets.voting_widget_1)
	self.voting_widget_2 = UIWidget.init(definitions.widgets.voting_widget_2)
	self.voting_widget_3 = UIWidget.init(definitions.widgets.voting_widget_3)
	self.window_widget = UIWidget.init(definitions.widgets.window)
	self.topic_index_counter_widget = UIWidget.init(definitions.widgets.topic_index_counter)
	self.level_vote_texts = UIWidget.init(definitions.widgets.level_vote_texts)
	self.topic_mask_widget = UIWidget.init(definitions.widgets.topic_mask)
	self.controller_info_widget = UIWidget.init(definitions.widgets.controller_info)
	self.topic_arrow_widget_left = UIWidget.init(definitions.widgets.topic_arrow_button_left)
	self.topic_arrow_widget_right = UIWidget.init(definitions.widgets.topic_arrow_button_right)
	self.gamepad_slot_selection_widget = UIWidget.init(definitions.widgets.gamepad_slot_selection)
	local topic_widgets = {}
	local topic_widgets_definitions = definitions.topic_widgets

	for i = 1, #topic_widgets_definitions, 1 do
		topic_widgets[i] = UIWidget.init(topic_widgets_definitions[i])
	end

	self.topic_widgets = topic_widgets
	local player_entry_definitions = definitions.player_entries
	local player_entry_widgets = {}

	for index, entry in ipairs(player_entry_definitions) do
		player_entry_widgets[#player_entry_widgets + 1] = UIWidget.init(entry)
	end

	self.player_entry_widgets = player_entry_widgets

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end

local function create_index_counter_widget_template()
	local style = {
		background_texture_id = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				30,
				30
			},
			offset = {
				0,
				0,
				1
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		background_click_texture_id = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				12,
				12
			},
			offset = {
				9,
				9,
				2
			},
			color = {
				255,
				255,
				255,
				255
			}
		}
	}
	local content = {
		background_texture_id = "index_marker_bg",
		background_click_texture_id = "index_marker_fill",
		visible = true,
		button_hotspot = {}
	}

	return content, style
end

ScoreboardUI.init_topic_index_counter = function (self, number_of_entries)
	local topic_index_counter_widget = self.topic_index_counter_widget
	local member_x_offset = 45
	local member_width = 30
	local offset_diff = (number_of_entries - 1)*math.max(member_x_offset - member_width, 0)
	local list_width = member_width*number_of_entries + offset_diff
	local list_content = {}
	local list_style = {
		vertical_alignment = "center",
		scenegraph_id = "topic_index_counter",
		num_draws = 4,
		start_index = 1,
		horizontal_alignment = "center",
		size = {
			30,
			30
		},
		list_member_offset = {
			member_x_offset,
			0,
			0
		},
		item_styles = {}
	}

	for i = 1, number_of_entries, 1 do
		local content, style = create_index_counter_widget_template()
		list_content[i] = content
		list_style.item_styles[i] = style
	end

	topic_index_counter_widget.content.list_content = list_content
	topic_index_counter_widget.style.list_style = list_style
	topic_index_counter_widget.style.list_style.start_index = 1
	topic_index_counter_widget.style.list_style.num_draws = number_of_entries
	topic_index_counter_widget.element.pass_data[1].num_list_elements = nil

	return 
end
ScoreboardUI.input_service = function (self)
	return self.input_manager:get_service("scoreboard_ui")
end
ScoreboardUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
ScoreboardUI.is_active = function (self)
	return self.active
end
ScoreboardUI.is_completed = function (self)
	return self.is_complete
end
ScoreboardUI.on_enter = function (self, ignore_input_blocking)
	self.active = true
	self.is_complete = nil
	local chat_focused = Managers.chat:chat_is_focused()
	local input_manager = self.input_manager

	if not ignore_input_blocking and not chat_focused then
		input_manager.block_device_except_service(input_manager, "scoreboard_ui", "keyboard")
		input_manager.block_device_except_service(input_manager, "scoreboard_ui", "mouse")
		input_manager.block_device_except_service(input_manager, "scoreboard_ui", "gamepad")
	end

	local ui_scenegraph = self.ui_scenegraph
	local target = ui_scenegraph.root.local_position
	local target_index = 2
	local from = 1200
	local to = 0
	local time = UISettings.scoreboard.open_duration
	self.open_window_animation = self.animate_element_by_time(self, target, target_index, from, to, time)
	self.number_of_topic_pages = math.ceil(self.number_of_topics/TOPICS_PER_PAGE)

	self.init_topic_index_counter(self, self.number_of_topic_pages)
	self.move_topic_list(self, 1, true)
	self.on_topic_widget_select(self, self.topic_widgets[1], 1, true)

	return 
end
ScoreboardUI.on_open_complete = function (self)
	self.open = true

	return 
end
ScoreboardUI.on_exit = function (self)
	self.open = nil
	local ui_scenegraph = self.ui_scenegraph
	local target = ui_scenegraph.root.local_position
	local target_index = 2
	local from = 0
	local to = 1200
	local time = UISettings.scoreboard.close_duration
	self.close_window_animation = self.animate_element_by_time(self, target, target_index, from, to, time)

	self.play_sound(self, "Play_hud_button_close")

	return 
end
ScoreboardUI.on_close_complete = function (self)
	local input_manager = self.input_manager

	input_manager.device_unblock_all_services(input_manager, "keyboard")
	input_manager.device_unblock_all_services(input_manager, "mouse")
	input_manager.device_unblock_all_services(input_manager, "gamepad")

	self.active = nil
	self.is_complete = true

	return 
end
ScoreboardUI.player_data_by_stats_id = function (self, stats_id)
	return self.player_list[stats_id]
end
ScoreboardUI.update = function (self, dt)
	local gamepad_active = self.input_manager:is_device_active("gamepad")

	if not self.active then
		return 
	end

	if self.popup_id then
		local popup_result = Managers.popup:query_result(self.popup_id)

		if popup_result then
			self.handle_popup_result(self, popup_result)
		end
	end

	local open_animation = self.open_window_animation

	if open_animation then
		UIAnimation.update(open_animation, dt)

		if UIAnimation.completed(open_animation) then
			self.open_window_animation = nil

			self.on_open_complete(self)
		end
	else
		local close_animation = self.close_window_animation

		if close_animation then
			UIAnimation.update(close_animation, dt)

			if UIAnimation.completed(close_animation) then
				self.close_window_animation = nil

				self.on_close_complete(self)
			end
		end
	end

	for name, animation in pairs(self.ui_animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			animation = nil
		end
	end

	if self.open then
		self.update_vote_counts(self)
		self.update_start_level_timer(self, dt)
		self.update_vote_options_fade_out(self, dt)

		if gamepad_active then
			if not self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = true

				self.on_gamepad_activated(self)
			end

			self.update_input_description(self)
		elseif self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = false

			self.on_gamepad_deactivated(self)
		end

		self.handle_interaction(self, dt)
	end

	self.update_arrow_widget_mouse_input(self, self.topic_arrow_widget_left, "left")
	self.update_arrow_widget_mouse_input(self, self.topic_arrow_widget_right, "right")
	self.update_topic_widgets_mouse_input(self)
	self.update_topic_scroll_animation(self, dt)
	self.update_player_widgets_animations(self, dt)
	self.draw(self, dt)

	return 
end
ScoreboardUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "scoreboard_ui")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
	UIRenderer.draw_widget(ui_renderer, self.window_widget)
	UIRenderer.draw_widget(ui_renderer, self.topic_index_counter_widget)
	UIRenderer.draw_widget(ui_renderer, self.level_vote_texts)

	local active_vote_list = self.active_vote_list

	if active_vote_list then
		for i = 1, #active_vote_list, 1 do
			local vote_option_data = active_vote_list[i]

			if vote_option_data.active then
				UIRenderer.draw_widget(ui_renderer, vote_option_data.widget)
			end
		end
	end

	local current_scroll_index = self.topic_scroll_index
	local number_of_topic_pages = self.number_of_topic_pages

	if self.draw_right_arrow then
		UIRenderer.draw_widget(ui_renderer, self.topic_arrow_widget_right)
	end

	if self.draw_left_arrow then
		UIRenderer.draw_widget(ui_renderer, self.topic_arrow_widget_left)
	end

	local draw_controller_info = self.draw_controller_info

	if draw_controller_info then
		UIRenderer.draw_widget(ui_renderer, self.controller_info_widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.topic_mask_widget)

	local topic_widgets = self.topic_widgets
	local widget_start_draw_index = self.widget_start_draw_index
	local topic_widgets_draw_count = self.topic_widgets_draw_count

	if self.topic_animation_time then
		for i = 1, topic_widgets_draw_count, 1 do
			UIRenderer.draw_widget(ui_renderer, topic_widgets[i])
		end
	elseif widget_start_draw_index then
		local num_draws = math.min(widget_start_draw_index + 2, topic_widgets_draw_count)

		for i = widget_start_draw_index, num_draws, 1 do
			UIRenderer.draw_widget(ui_renderer, topic_widgets[i])
		end
	end

	local player_entry_widgets = self.player_entry_widgets

	for i = 1, #player_entry_widgets, 1 do
		UIRenderer.draw_widget(ui_renderer, player_entry_widgets[i])
	end

	if not self._selected_player_index and not self.voting_disabled and active_vote_list and gamepad_active and not self.popup_id then
		UIRenderer.draw_widget(ui_renderer, self.gamepad_slot_selection_widget)
	end

	UIRenderer.end_pass(ui_renderer)

	if gamepad_active and not self.popup_id then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
ScoreboardUI.destroy = function (self)
	rawset(_G, "ScoreboardUI_pointer", nil)
	self.menu_input_description:destroy()

	self.menu_input_description = nil

	if self.popup_id then
		Managers.popup:cancel_popup(self.popup_id)
	end

	self.popup_handler = nil

	self.network_event_delegate:unregister(self)
	GarbageLeakDetector.register_object(self, "ScoreboardUI")

	return 
end
ScoreboardUI.on_gamepad_activated = function (self)
	self.on_vote_selection_index_changed(self, 1)
	self.update_input_description(self)

	return 
end
ScoreboardUI.on_gamepad_deactivated = function (self)
	self.on_vote_selection_index_changed(self, nil)

	return 
end
ScoreboardUI.update_input_description = function (self)
	local actions_name_to_use = "default"

	if self._selected_player_index then
		if self.get_player_widget_peer_id_by_index(self, self._selected_player_index) then
			actions_name_to_use = "player_list_profile"
		else
			actions_name_to_use = "player_list"
		end
	elseif self.voting_disabled then
		actions_name_to_use = "already_voted"
	end

	if not self.gamepad_active_generic_actions_name or self.gamepad_active_generic_actions_name ~= actions_name_to_use then
		self.gamepad_active_generic_actions_name = actions_name_to_use
		local generic_actions = generic_input_actions[actions_name_to_use]

		self.menu_input_description:change_generic_actions(generic_actions)
	end

	return 
end
ScoreboardUI.handle_interaction = function (self, dt)
	local wait_time = self.handle_input_wait_time

	if wait_time then
		wait_time = wait_time - dt
		self.handle_input_wait_time = (0 < wait_time and wait_time) or nil
	elseif not self.topic_animation_time then
		local delay_auto_pilot = nil
		local input_service = self.input_manager:get_service("scoreboard_ui")

		if not self.open_window_animation and not self.close_window_animation then
			local can_vote = self.is_voting_possible(self)

			if can_vote then
				local active_vote_list = self.active_vote_list

				if active_vote_list then
					for index, vote_option_data in ipairs(active_vote_list) do
						if vote_option_data.active then
							local widget = vote_option_data.widget
							local widget_content = widget.content

							if widget_content.button_hotspot.on_release then
								self.on_vote_level_pressed(self, index)

								break
							end
						end
					end
				end
			end

			local selected_topic_counter_index = self.selected_topic_counter_index

			for i = 1, self.number_of_topic_pages, 1 do
				local widget_element_content = self.topic_index_counter_widget.content.list_content[i]

				if widget_element_content.button_hotspot.is_selected and i ~= selected_topic_counter_index then
					delay_auto_pilot = true

					self.move_topic_list(self, i)

					break
				end
			end

			if not self.topic_animation_time then
				if self.topic_arrow_widget_left.content.button_hotspot.on_release then
					self.topic_arrow_widget_left.content.button_hotspot.on_release = nil

					self.move_topic_list(self, self.topic_scroll_index - 1)
				elseif self.topic_arrow_widget_right.content.button_hotspot.on_release then
					self.topic_arrow_widget_right.content.button_hotspot.on_release = nil

					self.move_topic_list(self, self.topic_scroll_index + 1)
				end
			end

			local controller_cooldown = self.controller_cooldown

			if controller_cooldown and 0 < controller_cooldown then
				self.controller_cooldown = controller_cooldown - dt
			elseif not self.topic_animation_time then
				local selected_player_index = self._selected_player_index
				local can_vote = self.is_voting_possible(self)

				if not selected_player_index and input_service.get(input_service, "move_left") then
					self.set_player_widget_highlight_by_index(self, 1, true)

					self.controller_cooldown = GamepadSettings.menu_cooldown

					self.play_sound(self, "Play_hud_select")
				elseif selected_player_index and can_vote and input_service.get(input_service, "move_right") then
					self.set_player_widget_highlight_by_index(self, nil, true)

					self.controller_cooldown = GamepadSettings.menu_cooldown

					self.play_sound(self, "Play_hud_select")
				elseif input_service.get(input_service, "move_up") then
					if selected_player_index then
						local new_player_index = math.max(selected_player_index - 1, 1)

						if new_player_index ~= selected_player_index then
							self.set_player_widget_highlight_by_index(self, new_player_index, true)

							self.controller_cooldown = GamepadSettings.menu_cooldown

							self.play_sound(self, "Play_hud_select")
						end
					elseif can_vote and self.vote_selection_index then
						local current_vote_selection_index = self.vote_selection_index
						local new_vote_selection_index = math.max(current_vote_selection_index - 1, 1)

						if new_vote_selection_index ~= current_vote_selection_index then
							self.on_vote_selection_index_changed(self, new_vote_selection_index)

							self.controller_cooldown = GamepadSettings.menu_cooldown

							self.play_sound(self, "Play_hud_select")
						end
					end
				elseif input_service.get(input_service, "move_down") then
					if selected_player_index then
						local num_players = self._num_players
						local new_player_index = math.min(selected_player_index + 1, num_players)

						if new_player_index ~= selected_player_index then
							self.set_player_widget_highlight_by_index(self, new_player_index, true)

							self.controller_cooldown = GamepadSettings.menu_cooldown

							self.play_sound(self, "Play_hud_select")
						end
					elseif can_vote and self.vote_selection_index then
						local current_vote_selection_index = self.vote_selection_index
						local active_vote_list = self.active_vote_list
						local new_vote_selection_index = math.min(current_vote_selection_index + 1, #active_vote_list)

						if new_vote_selection_index ~= current_vote_selection_index then
							self.on_vote_selection_index_changed(self, new_vote_selection_index)

							self.controller_cooldown = GamepadSettings.menu_cooldown

							self.play_sound(self, "Play_hud_select")
						end
					end
				elseif input_service.get(input_service, "confirm") and not self._selected_player_index then
					local current_vote_selection_index = self.vote_selection_index

					if can_vote and current_vote_selection_index then
						self.on_vote_level_pressed(self, current_vote_selection_index)

						self.controller_cooldown = GamepadSettings.menu_cooldown

						self.set_player_widget_highlight_by_index(self, 1, true)
					end
				elseif input_service.get(input_service, "confirm") and self._selected_player_index then
					local player_peer_id = self.get_player_widget_peer_id_by_index(self, self._selected_player_index)

					if player_peer_id then
						self.show_selected_player_gamercard(self, player_peer_id)

						self.controller_cooldown = GamepadSettings.menu_cooldown
					end
				elseif input_service.get(input_service, "cycle_previous") then
					delay_auto_pilot = true
					local number_of_topics = self.number_of_topics
					local topic_selected_index = self.topic_selected_index
					local can_go_previous = 1 < self.topic_selected_data_index

					if topic_selected_index then
						local new_topic_selected_index = nil
						local play_sound = true

						if can_go_previous then
							if topic_selected_index == 1 then
								new_topic_selected_index = 3
							else
								new_topic_selected_index = topic_selected_index - 1
							end

							local widget_start_draw_index = self.widget_start_draw_index
							local topic_widgets_draw_count = self.topic_widgets_draw_count
							local visible_widget_count = math.min(self.topic_widgets_draw_count - self.widget_start_draw_index + 1, 3)

							if topic_selected_index == widget_start_draw_index then
								self.move_topic_list(self, self.topic_scroll_index - 1)

								play_sound = false
							end
						else
							self.move_topic_list(self, self.number_of_topic_pages)

							new_topic_selected_index = self.topic_widgets_draw_count
							play_sound = false
						end

						if new_topic_selected_index then
							local topic_widgets = self.topic_widgets

							self.on_topic_widget_deselect(self, topic_widgets[topic_selected_index], topic_selected_index, true)
							self.on_topic_widget_select(self, topic_widgets[new_topic_selected_index], new_topic_selected_index, true)

							self.controller_cooldown = GamepadSettings.menu_cooldown

							if play_sound then
								self.play_sound(self, "Play_hud_select")
							end
						end
					end
				elseif input_service.get(input_service, "cycle_next") then
					delay_auto_pilot = true
					local number_of_topics = self.number_of_topics
					local can_go_next = self.topic_selected_data_index < number_of_topics
					local topic_selected_index = self.topic_selected_index

					if topic_selected_index then
						local new_topic_selected_index = nil
						local play_sound = true

						if can_go_next then
							if topic_selected_index == 6 then
								new_topic_selected_index = 4
							else
								new_topic_selected_index = topic_selected_index + 1
							end

							local widget_start_draw_index = self.widget_start_draw_index
							local topic_widgets_draw_count = self.topic_widgets_draw_count
							local visible_widget_count = math.min(self.topic_widgets_draw_count - self.widget_start_draw_index + 1, 3)
							local current_end_index = (self.widget_start_draw_index + visible_widget_count) - 1

							if topic_selected_index == current_end_index then
								self.move_topic_list(self, self.topic_scroll_index + 1)

								play_sound = false
							end
						else
							self.move_topic_list(self, 1)

							new_topic_selected_index = self.widget_start_draw_index
							play_sound = false
						end

						if new_topic_selected_index then
							local topic_widgets = self.topic_widgets

							self.on_topic_widget_deselect(self, topic_widgets[topic_selected_index], topic_selected_index, true)
							self.on_topic_widget_select(self, topic_widgets[new_topic_selected_index], new_topic_selected_index, true)

							self.controller_cooldown = GamepadSettings.menu_cooldown

							if play_sound then
								self.play_sound(self, "Play_hud_select")
							end
						end
					end
				end
			end

			if input_service.get(input_service, "toggle_menu", true) or input_service.get(input_service, "back", true) then
				self.request_leave_game(self)
			end
		end

		if delay_auto_pilot then
			self.auto_pilot_wait_time = UISettings.scoreboard.auto_pilot_wait_time
		end
	end

	return 
end
ScoreboardUI.update_arrow_widget_mouse_input = function (self, widget, name)
	local widget_content = widget.content
	local button_hotspot = widget_content.button_hotspot
	local delay_auto_pilot = nil

	if button_hotspot.is_hover then
		if not widget_content.animate_in then
			self.on_arrow_widget_hover(self, widget, name)
		end
	elseif widget_content.animate_in then
		self.on_arrow_widget_dehover(self, widget, name)
	end

	if button_hotspot.is_clicked == 0 then
		if not widget.content.animate_select then
			delay_auto_pilot = true

			self.on_arrow_widget_select(self, widget, name)
		end
	elseif widget.content.animate_select then
		self.on_arrow_widget_deselect(self, widget, name)
	end

	if delay_auto_pilot then
		self.auto_pilot_wait_time = UISettings.scoreboard.auto_pilot_wait_time
	end

	return 
end
ScoreboardUI.on_topic_index_selected = function (self, index)
	self.selected_topic_counter_index = index
	local topic_index_counter_widget = self.topic_index_counter_widget
	local list_content = topic_index_counter_widget.content.list_content

	for i = 1, #list_content, 1 do
		list_content[i].button_hotspot.is_selected = i == index
	end

	return 
end
ScoreboardUI.select_topic_index_by_data_index = function (self, index)
	local topic_widgets = self.topic_widgets

	for widget_index, widget in ipairs(topic_widgets) do
		local widget_data_index = widget.content.topic_data_index

		if widget_data_index == index then
			self.on_topic_widget_select(self, widget, widget_index)

			break
		end
	end

	return 
end
ScoreboardUI.on_topic_widget_select = function (self, widget, widget_index, update_player_list)
	widget.content.button_hotspot.is_selected = true
	self.topic_selected_index = widget_index
	local widget_start_draw_index = self.widget_start_draw_index or 1
	local widget_draw_index = widget_index - self.widget_start_draw_index + 1
	local previous_topic_selected_data_index = self.topic_selected_data_index
	self.topic_selected_data_index = (self.selected_topic_counter_index - 1)*TOPICS_PER_PAGE + widget_draw_index
	local ui_animations = self.ui_animations
	local animation_name = "topic_widget_select_" .. widget_index
	local hover_animation_name = "topic_widget_hover_" .. widget_index
	local current_alpha = widget.style.background_select.color[1]
	local target_alpha = UISettings.scoreboard.topic_hover_alpha
	local background_target_alpha = UISettings.scoreboard.topic_hover_alpha
	local total_time = UISettings.scoreboard.topic_select_duration
	local animation_duration = (target_alpha - current_alpha)/target_alpha*total_time

	if 0 < animation_duration then
		ui_animations[animation_name] = self.animate_element_by_time(self, widget.style.background_select.color, 1, current_alpha, target_alpha, animation_duration)
		ui_animations[animation_name .. "_background_hover"] = self.animate_element_by_time(self, widget.style.background_hover.color, 1, widget.style.background_hover.color[1], 0, animation_duration)
		ui_animations[hover_animation_name .. "_score_text"] = self.animate_element_by_time(self, widget.style.score_text.text_color, 1, widget.style.score_text.text_color[1], background_target_alpha, animation_duration)
		ui_animations[hover_animation_name .. "_title_text"] = self.animate_element_by_time(self, widget.style.title_text.text_color, 1, widget.style.title_text.text_color[1], background_target_alpha, animation_duration)
		ui_animations[hover_animation_name .. "_player_name"] = self.animate_element_by_time(self, widget.style.player_name.text_color, 1, widget.style.player_name.text_color[1], background_target_alpha, animation_duration)
	else
		widget.style.background_select.color[1] = target_alpha
		widget.style.score_text.text_color[1] = background_target_alpha
		widget.style.title_text.text_color[1] = background_target_alpha
		widget.style.player_name.text_color[1] = background_target_alpha
		widget.style.background_hover.color[1] = 0
	end

	if update_player_list then
		self.set_player_list_data_by_index(self, self.topic_selected_data_index)
	end

	return 
end
ScoreboardUI.on_topic_widget_deselect = function (self, widget, widget_index, instant_update)
	self.topic_selected_index = nil
	local ui_animations = self.ui_animations
	widget.content.button_hotspot.is_selected = nil
	local animation_name = "topic_widget_select_" .. widget_index
	local hover_animation_name = "topic_widget_hover_" .. widget_index
	local widget_style = widget.style
	local hover_alpha = UISettings.scoreboard.topic_hover_alpha
	local current_alpha = widget_style.background_select.color[1]
	local target_alpha = 0
	local background_target_alpha = UISettings.scoreboard.topic_normal_alpha
	local total_time = UISettings.scoreboard.topic_deselect_duration
	local animation_duration = ((hover_alpha - current_alpha)/hover_alpha - 1)*total_time

	if not instant_update and 0 < animation_duration then
		ui_animations[animation_name] = self.animate_element_by_time(self, widget_style.background_select.color, 1, current_alpha, target_alpha, animation_duration)
		ui_animations[hover_animation_name .. "_score_text"] = self.animate_element_by_time(self, widget_style.score_text.text_color, 1, widget_style.score_text.text_color[1], background_target_alpha, animation_duration)
		ui_animations[hover_animation_name .. "_title_text"] = self.animate_element_by_time(self, widget_style.title_text.text_color, 1, widget_style.title_text.text_color[1], background_target_alpha, animation_duration)
		ui_animations[hover_animation_name .. "_player_name"] = self.animate_element_by_time(self, widget_style.player_name.text_color, 1, widget_style.player_name.text_color[1], background_target_alpha, animation_duration)
	else
		widget_style.background_select.color[1] = target_alpha
		widget_style.score_text.text_color[1] = background_target_alpha
		widget_style.title_text.text_color[1] = background_target_alpha
		widget_style.player_name.text_color[1] = background_target_alpha
	end

	return 
end
ScoreboardUI.on_topic_widget_hover = function (self, widget, widget_index)
	local ui_animations = self.ui_animations
	local animation_name = "topic_widget_hover_" .. widget_index
	local widget_style = widget.style
	widget.content.tweened_in = true
	local current_alpha = widget_style.background_hover.color[1]
	local target_alpha = UISettings.scoreboard.topic_hover_alpha
	local background_target_alpha = target_alpha
	local total_time = UISettings.scoreboard.topic_hover_duration
	local animation_duration = (target_alpha - current_alpha)/target_alpha*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_background_hover"] = self.animate_element_by_time(self, widget_style.background_hover.color, 1, current_alpha, target_alpha, animation_duration)
		ui_animations[animation_name .. "_score_text"] = self.animate_element_by_time(self, widget_style.score_text.text_color, 1, widget_style.score_text.text_color[1], background_target_alpha, animation_duration)
		ui_animations[animation_name .. "_title_text"] = self.animate_element_by_time(self, widget_style.title_text.text_color, 1, widget_style.title_text.text_color[1], background_target_alpha, animation_duration)
		ui_animations[animation_name .. "_player_name"] = self.animate_element_by_time(self, widget_style.player_name.text_color, 1, widget_style.player_name.text_color[1], background_target_alpha, animation_duration)
	else
		widget_style.background_hover.color[1] = target_alpha
		widget_style.score_text.text_color[1] = background_target_alpha
		widget_style.title_text.text_color[1] = background_target_alpha
		widget_style.player_name.text_color[1] = background_target_alpha
	end

	self.play_sound(self, "Play_hud_hover")

	return 
end
ScoreboardUI.on_topic_widget_dehover = function (self, widget, widget_index)
	local ui_animations = self.ui_animations
	local animation_name = "topic_widget_hover_" .. widget_index
	local widget_style = widget.style
	widget.content.tweened_in = nil
	local hover_alpha = UISettings.scoreboard.topic_hover_alpha
	local current_alpha = widget_style.background_hover.color[1]
	local target_alpha = 0
	local background_target_alpha = UISettings.scoreboard.topic_normal_alpha
	local total_time = UISettings.scoreboard.topic_dehover_duration
	local animation_duration = ((hover_alpha - current_alpha)/hover_alpha - 1)*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_background_hover"] = self.animate_element_by_time(self, widget_style.background_hover.color, 1, current_alpha, target_alpha, animation_duration)
		ui_animations[animation_name .. "_score_text"] = self.animate_element_by_time(self, widget_style.score_text.text_color, 1, widget_style.score_text.text_color[1], background_target_alpha, animation_duration)
		ui_animations[animation_name .. "_title_text"] = self.animate_element_by_time(self, widget_style.title_text.text_color, 1, widget_style.title_text.text_color[1], background_target_alpha, animation_duration)
		ui_animations[animation_name .. "_player_name"] = self.animate_element_by_time(self, widget_style.player_name.text_color, 1, widget_style.player_name.text_color[1], background_target_alpha, animation_duration)
	else
		widget_style.background_hover.color[1] = target_alpha
		widget_style.score_text.text_color[1] = background_target_alpha
		widget_style.title_text.text_color[1] = background_target_alpha
		widget_style.player_name.text_color[1] = background_target_alpha
	end

	return 
end
ScoreboardUI.clear_topic_widget_animations = function (self, widget, widget_index)
	local ui_animations = self.ui_animations
	local hover_animation_name = "topic_widget_hover_" .. widget_index
	local select_animation_name = "topic_widget_select_" .. widget_index
	ui_animations[select_animation_name] = nil
	ui_animations[hover_animation_name .. "_background_hover"] = nil
	ui_animations[hover_animation_name .. "_background"] = nil
	ui_animations[hover_animation_name .. "_score_text"] = nil
	ui_animations[hover_animation_name .. "_title_text"] = nil
	ui_animations[hover_animation_name .. "_player_name"] = nil
	local background_target_alpha = UISettings.scoreboard.topic_normal_alpha
	local widget_style = widget.style
	widget_style.background_hover.color[1] = 0
	widget_style.score_text.text_color[1] = background_target_alpha
	widget_style.title_text.text_color[1] = background_target_alpha
	widget_style.player_name.text_color[1] = background_target_alpha

	return 
end
ScoreboardUI.on_arrow_widget_hover = function (self, widget, name)
	widget.content.animate_in = true
	local ui_animations = self.ui_animations
	local animation_name = "arrow_widget_hover_" .. name
	local current_alpha = widget.style.normal.color[1]
	local target_alpha = UISettings.scoreboard.topic_hover_alpha
	local glow_alpha = 125
	local total_time = UISettings.scoreboard.arrow_hover_duration
	local animation_duration = (target_alpha - current_alpha)/target_alpha*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_background"] = self.animate_element_by_time(self, widget.style.normal.color, 1, current_alpha, target_alpha, animation_duration)
		ui_animations[animation_name .. "_glow"] = self.animate_element_by_time(self, widget.style.glow.color, 1, widget.style.glow.color[1], glow_alpha, animation_duration)
	else
		widget.style.normal.color[1] = target_alpha
		widget.style.glow.color[1] = glow_alpha
	end

	return 
end
ScoreboardUI.on_arrow_widget_dehover = function (self, widget, name)
	widget.content.animate_in = nil
	local ui_animations = self.ui_animations
	local animation_name = "arrow_widget_hover_" .. name
	local hover_alpha = UISettings.scoreboard.topic_hover_alpha
	local current_alpha = widget.style.normal.color[1]
	local target_alpha = UISettings.scoreboard.topic_normal_alpha
	local total_time = UISettings.scoreboard.arrow_dehover_duration
	local animation_duration = ((hover_alpha - current_alpha)/hover_alpha - 1)*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_background"] = self.animate_element_by_time(self, widget.style.normal.color, 1, current_alpha, target_alpha, animation_duration)
		ui_animations[animation_name .. "_glow"] = self.animate_element_by_time(self, widget.style.glow.color, 1, widget.style.glow.color[1], 0, animation_duration)
	else
		widget.style.normal.color[1] = target_alpha
		widget.style.glow.color[1] = 0
	end

	return 
end
ScoreboardUI.on_arrow_widget_select = function (self, widget, name)
	widget.content.animate_select = true
	local ui_animations = self.ui_animations
	local animation_name = "arrow_widget_select_" .. name
	local hover_animation_name = "arrow_widget_hover_" .. name
	local current_alpha = widget.style.selected.color[1]
	local target_alpha = UISettings.scoreboard.topic_hover_alpha
	local total_time = UISettings.scoreboard.arrow_select_duration
	local animation_duration = (target_alpha - current_alpha)/target_alpha*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_selected"] = self.animate_element_by_time(self, widget.style.selected.color, 1, current_alpha, target_alpha, animation_duration)
	else
		widget.style.selected.color[1] = target_alpha
	end

	return 
end
ScoreboardUI.on_arrow_widget_deselect = function (self, widget, name)
	widget.content.animate_select = nil
	local ui_animations = self.ui_animations
	local animation_name = "arrow_widget_select_" .. name
	local hover_animation_name = "arrow_widget_hover_" .. name
	local hover_alpha = UISettings.scoreboard.topic_hover_alpha
	local current_alpha = widget.style.selected.color[1]
	local target_alpha = 0
	local total_time = UISettings.scoreboard.arrow_deselect_duration
	local animation_duration = ((hover_alpha - current_alpha)/hover_alpha - 1)*total_time

	if 0 < animation_duration then
		ui_animations[animation_name .. "_selected"] = self.animate_element_by_time(self, widget.style.selected.color, 1, current_alpha, target_alpha, animation_duration)
	else
		widget.style.selected.color[1] = target_alpha
	end

	return 
end
ScoreboardUI.set_detailed_entry_default_data = function (self, index, player_hero_type, player_name, score)
	local widget = self.player_entry_widgets[index]
	local widget_content = widget.content
	widget_content.icon = "end_screen_reward_hero_icon_witch_hunter"
	widget_content.title_text = player_name
	widget_content.score_text = score

	return 
end
ScoreboardUI.set_detailed_entry_score = function (self, index, score)
	local widget = self.player_entry_widgets[index]
	widget.content.score_text = score

	return 
end
ScoreboardUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.ease_out_quad)

	return new_animation
end
ScoreboardUI.set_player_list_data_by_index = function (self, index)
	self.current_player_list_data_index = index
	local number_of_topics = self.number_of_topics
	local topic_score_data = self.topic_score_data[index]
	local topic_scores = topic_score_data.scores
	local topic_title_text = topic_score_data.display_text
	local hero_icons = definitions.hero_icons
	local my_index = nil

	for i, score_data in ipairs(topic_scores) do
		local score = math.floor(score_data.score)

		self.set_player_widget_score_by_index(self, i, score)

		local player_data = self.player_data_by_stats_id(self, score_data.stats_id)
		local player_name = player_data.name
		local player_peer_id = player_data.peer_id
		local is_player_controlled = player_data.is_player_controlled

		self.set_player_widget_name_by_index(self, i, player_name)

		if is_player_controlled then
			self.set_player_widget_peer_id_by_index(self, i, player_peer_id)
		end

		local is_own_player = self.stats_id == score_data.stats_id

		if is_own_player then
			my_index = i
		end

		local icon_mapping = (is_own_player and hero_icons.white) or hero_icons.yellow
		local icon_texture = self.hero_icon_by_profile_index(self, player_data.profile_index, icon_mapping)

		self.set_player_widget_icon_by_index(self, i, icon_texture)
	end

	self.update_player_list = nil
	self.window_widget.content.player_list_topic = topic_title_text

	return 
end
ScoreboardUI.set_player_widget_score_by_index = function (self, index, score)
	local player_entry_widgets = self.player_entry_widgets
	player_entry_widgets[index].content.score_text = score

	return 
end
ScoreboardUI.set_player_widget_name_by_index = function (self, index, name)
	local player_entry_widgets = self.player_entry_widgets
	local widget = player_entry_widgets[index]
	local player_name = ""

	if name then
		player_name = (PLAYER_NAME_MAX_LENGTH < UTF8Utils.string_length(name) and UIRenderer.crop_text_width(self.ui_renderer, name, 500, widget.style.title_text)) or name
	end

	widget.content.title_text = player_name

	return 
end
ScoreboardUI.set_player_widget_peer_id_by_index = function (self, index, peer_id)
	local player_entry_widgets = self.player_entry_widgets
	player_entry_widgets[index].content.peer_id = peer_id

	return 
end
ScoreboardUI.get_player_widget_peer_id_by_index = function (self, index)
	local player_entry_widgets = self.player_entry_widgets

	return player_entry_widgets[index].content.peer_id
end
ScoreboardUI.set_player_widget_icon_by_index = function (self, index, icon_texture)
	local player_entry_widgets = self.player_entry_widgets
	player_entry_widgets[index].content.icon = icon_texture

	return 
end
ScoreboardUI.set_player_widget_highlight_by_index = function (self, index, reset_others)
	local player_entry_widgets = self.player_entry_widgets

	if reset_others then
		for i = 1, #player_entry_widgets, 1 do
			player_entry_widgets[i].content.highlight_enabled = nil
		end
	end

	if index then
		player_entry_widgets[index].content.highlight_enabled = true
	end

	self._selected_player_index = index

	return 
end
ScoreboardUI.update_player_widgets_animations = function (self, dt)
	local time = self.player_list_animation_time

	if time then
		time = time + dt
		local total_time = UISettings.scoreboard.player_list_pluse_duration
		local progress = math.min(time/total_time, 1)
		local pulse_progress = math.ease_pulse(progress)
		local color_channel = 1
		local color_value = math.max((pulse_progress - 1)*255, 0)
		local player_entry_widgets = self.player_entry_widgets

		for i = 1, #player_entry_widgets, 1 do
			local widget = player_entry_widgets[i]
			local widget_style = widget.style
			widget_style.icon.color[color_channel] = color_value
			widget_style.highlight.color[color_channel] = color_value
			widget_style.title_text.text_color[color_channel] = color_value
			widget_style.score_text.text_color[color_channel] = color_value
		end

		if 0.5 <= progress and self.update_player_list then
			self.set_player_list_data_by_index(self, self.topic_selected_data_index)
		end

		self.player_list_animation_time = (progress ~= 1 and time) or nil
	end

	return 
end
ScoreboardUI.hero_icon_by_profile_index = function (self, profile_index, icon_mapping)
	local profile_data = SPProfiles[profile_index]
	local display_name = profile_data.display_name
	local hero_icon = icon_mapping[display_name]

	return hero_icon
end
ScoreboardUI.setup_level_voting = function (self)
	local voting_manager = self.voting_manager

	if voting_manager and voting_manager.vote_in_progress(voting_manager) then
		local active_vote_data = voting_manager.active_vote_data(voting_manager)
		self.active_vote_list = {}
		local last_vote_widget_name = "voting_widget_3"

		for index = 1, 2, 1 do
			local level_key = active_vote_data[index]
			local level_difficulty = active_vote_data[index + 2]
			local active_vote_option = true

			if index == 2 and level_key == active_vote_data[index - 1] then
				active_vote_option = false
				last_vote_widget_name = "voting_widget_2"
			end

			local widget = self["voting_widget_" .. index]
			local entry_content = widget.content
			local entry_style = widget.style
			local level_settings = LevelSettings[level_key]
			local display_name = level_settings.display_name
			local display_image = level_settings.level_image
			local difficulty_setting = DifficultySettings[level_difficulty]
			local difficulty_display_name = difficulty_setting.display_name
			local difficulty_text = Localize("map_difficulty_setting") .. ": " .. Localize(difficulty_display_name)
			entry_content.background_texture_id = display_image
			local text_prefix = self.level_prefixes[index]
			entry_content.text = Localize(text_prefix) .. ": " .. Localize(display_name) .. "\n" .. difficulty_text
			self.active_vote_list[index] = {
				widget = widget,
				active = active_vote_option
			}
		end

		self.active_vote_list[#self.active_vote_list + 1] = {
			active = true,
			widget = self.voting_widget_3
		}
		local vote_text_widget = self.level_vote_texts
		local prefix_text = Localize("timer_prefix_time_left")
		vote_text_widget.content.timer_prefix = prefix_text .. ":"
		local timer_prefix_style = vote_text_widget.style.timer_prefix
		local font, scaled_font_size = UIFontByResolution(timer_prefix_style)
		local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, prefix_text, font[1], scaled_font_size)
		local ui_scenegraph = self.ui_scenegraph
		ui_scenegraph.level_vote_timer.local_position[1] = text_width
		local last_vote_widget_position = ui_scenegraph[last_vote_widget_name].local_position
		ui_scenegraph.level_vote_timer_prefix.local_position[2] = last_vote_widget_position[2] - 205
		local inn_vote_option_position = ui_scenegraph.voting_widget_3.local_position
		inn_vote_option_position[1] = last_vote_widget_position[1]
		inn_vote_option_position[2] = last_vote_widget_position[2]
	end

	return 
end
ScoreboardUI.is_voting_possible = function (self)
	if self.voting_disabled then
		return false
	else
		return self.vote_manager:vote_in_progress()
	end

	return 
end
local telemetry_data = {}

local function _add_next_level_vote_telemetry(player_id, hero, vote_option_text)
	table.clear(telemetry_data)

	telemetry_data.player_id = player_id
	telemetry_data.hero = hero
	telemetry_data.vote = vote_option_text

	Managers.telemetry:register_event("next_level_vote", telemetry_data)

	return 
end

ScoreboardUI.on_vote_level_pressed = function (self, index)
	local active_vote_data = self.active_vote_list[index]

	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local player = player_manager.local_player(player_manager)
		local player_id = player.telemetry_id(player)
		local hero = player.profile_display_name(player)
		local widget_content = active_vote_data.widget.content
		local list_text = widget_content.text
		local vote_option_text = self.level_prefixes[index] or list_text

		_add_next_level_vote_telemetry(player_id, hero, vote_option_text)
	end

	for i = 1, 3, 1 do
		local widget = self["voting_widget_" .. i]
		local widget_content = widget.content
		local button_hotspot = widget_content.button_hotspot
		widget_content.selected = false
		button_hotspot.disable_button = true
		button_hotspot.disabled = true
		button_hotspot.is_selected = i == index
	end

	local vote_manager = self.vote_manager

	vote_manager.vote(vote_manager, index)

	self.voting_disabled = true

	self.play_sound(self, "Play_hud_select")

	return 
end
ScoreboardUI.on_vote_selection_index_changed = function (self, new_index)
	local active_vote_list = self.active_vote_list

	if active_vote_list then
		if new_index then
			local new_vote_option_data = active_vote_list[new_index]

			if not new_vote_option_data.active then
				local vote_selection_index = self.vote_selection_index

				if vote_selection_index then
					if vote_selection_index < new_index then
						new_index = new_index + 1
					else
						new_index = new_index - 1
					end
				end
			end
		end

		for index, vote_option_data in ipairs(active_vote_list) do
			local is_active = vote_option_data.active

			if is_active then
				local widget = vote_option_data.widget
				local widget_content = widget.content
				local selected = new_index and index == new_index
				widget_content.selected = selected
				widget.style.gamepad_texture_selected_id.offset = {
					-35.5,
					-5.5,
					-1
				}

				if selected then
					local gamepad_selection_style = widget.style.gamepad_selection

					if gamepad_selection_style then
						local scenegraph_id = gamepad_selection_style.scenegraph_id
						local texture_size = gamepad_selection_style.texture_size
						self.gamepad_slot_selection_widget.scenegraph_id = scenegraph_id
						local gamepad_widget_style = self.gamepad_slot_selection_widget.style
						gamepad_widget_style.texture_top_left.texture_size = texture_size
						gamepad_widget_style.texture_top_right.texture_size = texture_size
						gamepad_widget_style.texture_bottom_left.texture_size = texture_size
						gamepad_widget_style.texture_bottom_right.texture_size = texture_size
					end
				end
			end
		end
	end

	self.vote_selection_index = new_index

	return 
end
ScoreboardUI.update_vote_counts = function (self)
	if self.level_voting_completed then
		return 
	end

	local vote_manager = self.vote_manager
	local vote_complete = false
	local number_of_votes = 0
	local current_vote_results = 0
	local vote_in_progress = vote_manager.vote_in_progress(vote_manager)

	if vote_in_progress then
		number_of_votes, current_vote_results = vote_manager.number_of_votes(vote_manager)
	else
		local previous_voting_info = vote_manager.previous_vote_info(vote_manager)
		number_of_votes = previous_voting_info.number_of_votes
		current_vote_results = previous_voting_info.vote_results
		vote_complete = true
	end

	local vote_marker_texture = "matchmaking_checkbox"
	local highest_vote_count = 0
	local highest_vote_option_index = 0
	local active_vote_list = self.active_vote_list

	for index, option_vote_count in ipairs(current_vote_results) do
		local active_vote_data = active_vote_list[index]
		local widget = active_vote_data.widget
		local widget_content = widget.content
		local widget_style = widget.style

		if highest_vote_count < option_vote_count then
			highest_vote_count = option_vote_count
			highest_vote_option_index = index
		end

		for i = 1, option_vote_count, 1 do
			local vote_markers = widget_content.vote_marker

			if not vote_markers[i] then
				vote_markers[i] = vote_marker_texture
			end
		end
	end

	if not vote_complete then
		self.update_vote_timer_text(self)
	else
		self.level_voting_completed = true

		self.fade_out_failed_vote_options(self, highest_vote_option_index)
	end

	return 
end
ScoreboardUI.update_vote_timer_text = function (self, time_left)
	local vote_manager = self.vote_manager
	local vote_time_left = (time_left and time_left) or vote_manager.vote_time_left(vote_manager) or 0
	local widget = self.level_vote_texts
	local time_text = string.format(" %02d:%02d", math.floor(vote_time_left/60), vote_time_left%60)
	widget.content.timer_text = time_text

	return 
end
ScoreboardUI.update_start_level_timer = function (self, dt)
	local time = self.level_start_timer

	if time then
		time = time - dt

		if time <= 0 then
			self.update_vote_timer_text(self, 0)

			self.level_start_timer = nil
		else
			self.update_vote_timer_text(self, time)

			self.level_start_timer = time
		end
	end

	return 
end
ScoreboardUI.rpc_start_specific_level = function (self, sender, level_key, time_until_start)
	local widget = self.level_vote_texts
	widget.content.title_text = "vote_completed"
	local prefix_text = Localize("vote_timer_game_start")
	widget.content.timer_prefix = prefix_text .. ":"
	local timer_prefix_style = widget.style.timer_prefix
	local font, scaled_font_size = UIFontByResolution(timer_prefix_style)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, prefix_text, font[1], scaled_font_size)
	self.ui_scenegraph.level_vote_timer.local_position[1] = text_width
	self.level_start_timer = time_until_start or 5

	return 
end
ScoreboardUI.fade_out_failed_vote_options = function (self, successful_vote_index)
	self.failed_vote_fade_timer = 0.5
	self.successful_vote_index = successful_vote_index

	return 
end
ScoreboardUI.update_vote_options_fade_out = function (self, dt)
	local time = self.failed_vote_fade_timer

	if time then
		local successful_vote_index = self.successful_vote_index
		time = time - dt
		local total_time = 0.5
		local progress = (0 < time and time/total_time) or 0
		self.failed_vote_fade_timer = (0 < time and time) or nil
		local fade_alpha = math.min(progress*75 + 180, 255)
		local active_vote_list = self.active_vote_list

		for i = 1, 3, 1 do
			if i ~= successful_vote_index then
				local active_vote_data = active_vote_list[i]
				local widget = active_vote_data.widget
				local widget_style = widget.style
				widget_style.background_texture_id.color[1] = fade_alpha
				widget_style.vote_marker.color[1] = fade_alpha
				widget_style.text.text_color[1] = fade_alpha
			end
		end
	end

	return 
end
ScoreboardUI.request_leave_game = function (self)
	if not self.popup_id then
		local text = Localize("leave_game_popup_text")
		self.popup_id = Managers.popup:queue_popup(text, Localize("popup_leave_game_topic"), "leave_game", Localize("popup_choice_yes"), "cancel_popup", Localize("popup_choice_no"))
	end

	return 
end
ScoreboardUI.leave_party = function (self)
	self.ingame_ui.leave_game = true

	return 
end
ScoreboardUI.handle_popup_result = function (self, popup_result)
	if popup_result == "leave_game" then
		self.popup_id = nil

		self.leave_party(self)
	elseif popup_result == "cancel_popup" then
		self.popup_id = nil
		local input_manager = self.input_manager

		input_manager.block_device_except_service(input_manager, "scoreboard_ui", "keyboard")
		input_manager.block_device_except_service(input_manager, "scoreboard_ui", "mouse")
		input_manager.block_device_except_service(input_manager, "scoreboard_ui", "gamepad")
	end

	return 
end
ScoreboardUI.move_topic_list = function (self, new_topic_index, instant_update)
	if not instant_update and self.topic_animation_time then
		return 
	end

	local topic_scroll_index = self.topic_scroll_index
	local number_of_topic_pages = self.number_of_topic_pages

	if new_topic_index < 1 or number_of_topic_pages < new_topic_index or new_topic_index == topic_scroll_index then
		return 
	end

	local ui_scenegraph = self.ui_scenegraph
	local topic_widgets = self.topic_widgets
	local number_of_topics = self.number_of_topics
	local direction = nil

	if not topic_scroll_index or new_topic_index < topic_scroll_index then
		direction = "right"
	else
		direction = "left"
	end

	self.on_topic_index_selected(self, new_topic_index)

	local selected_topic_index = self.topic_selected_index

	if selected_topic_index then
		self.on_topic_widget_deselect(self, topic_widgets[selected_topic_index], selected_topic_index, true)
	end

	local topic_spacing = definitions.COMPACT_PREVIEW_SPACING
	local topic_position_index_offset = nil

	for i = 1, #topic_widgets, 1 do
		if direction == "left" then
			topic_position_index_offset = i - 5
		elseif direction == "right" then
			topic_position_index_offset = i - 2
		end

		if i == 1 then
			self.widget_start_draw_index = math.abs(topic_position_index_offset)
		end

		local scenegraph_id = "compact_preview_" .. i
		local topic_scenegraph = ui_scenegraph[scenegraph_id]
		local topic_scenegraph_width = topic_scenegraph.size[1]
		topic_scenegraph.position[1] = topic_position_index_offset*topic_scenegraph_width + topic_spacing[1]

		self.clear_compact_topic_data(self, i)
		self.clear_topic_widget_animations(self, topic_widgets[i], i)
	end

	for i = 1, number_of_topic_pages, 1 do
		local widget_element_content = self.topic_index_counter_widget.content.list_content[i]
		widget_element_content.disabled = true
	end

	self.draw_left_arrow = 1 < new_topic_index
	self.draw_right_arrow = new_topic_index < number_of_topic_pages
	self.topic_arrow_widget_left.content.button_hotspot.disabled = self.draw_left_arrow
	self.topic_arrow_widget_right.content.button_hotspot.disabled = self.draw_right_arrow
	self.topic_scroll_index = new_topic_index
	self.topic_animation_direction = direction

	self.update_topic_data(self, direction)

	if instant_update then
		self.topic_animation_time = nil

		self.animate_scenegraph_to_position(self, "topic_widget_root", self.topic_widgets, 1, true)
		self.on_topic_scroll_complete(self)
	else
		self.topic_animation_time = 0

		self.play_sound(self, "Play_hud_shift")
	end

	return 
end
ScoreboardUI.update_topic_data = function (self, direction)
	local number_of_topics = self.number_of_topics
	local topic_score_data = self.topic_score_data
	local scroll_index = math.max(self.topic_scroll_index, 1)
	local start_read_index = 1

	if direction == "left" then
		start_read_index = (scroll_index - 2)*3 + 1
	elseif direction == "right" then
		start_read_index = (scroll_index - 1)*3 + 1
	end

	local end_read_index = (number_of_topics <= start_read_index + 3 and start_read_index + 4) or number_of_topics
	local current_read_index = start_read_index
	local topic_widgets_draw_count = 0
	local topic_widgets = self.topic_widgets

	for i = 1, #topic_widgets, 1 do
		local topic_stat_data = topic_score_data[current_read_index]

		if topic_stat_data then
			local topic_scores = topic_stat_data.scores
			local topic_title_text = topic_stat_data.display_text
			local best_score_data = topic_scores[1]
			local player_data = self.player_data_by_stats_id(self, best_score_data.stats_id)
			local player_name = player_data.name
			local score = math.floor(best_score_data.score)

			self.set_compact_topic_data(self, i, current_read_index, topic_title_text, score, player_name)

			topic_widgets_draw_count = topic_widgets_draw_count + 1
		else
			self.set_compact_topic_data(self, i)
		end

		current_read_index = current_read_index + 1
	end

	self.topic_widgets_draw_count = topic_widgets_draw_count

	return 
end
ScoreboardUI.clear_compact_topic_data = function (self, topic_index)
	local widget = self.topic_widgets[topic_index]
	local widget_content = widget.content
	local widget_style = widget.style
	local animation_name = "topic_widget_" .. topic_index

	if self.ui_animations[animation_name .. "_title"] then
		self.ui_animations[animation_name .. "_title"] = nil
	end

	if self.ui_animations[animation_name .. "_score"] then
		self.ui_animations[animation_name .. "_score"] = nil
	end

	if self.ui_animations[animation_name .. "_player_name"] then
		self.ui_animations[animation_name .. "_player_name"] = nil
	end

	widget_content.title_text = ""
	widget_content.score_text = ""
	widget_content.player_name = ""
	widget_content.button_hotspot.disabled = true

	return 
end
ScoreboardUI.set_compact_topic_data = function (self, topic_index, topic_data_index, title, score, player_name)
	local widget = self.topic_widgets[topic_index]
	local widget_content = widget.content
	local widget_style = widget.style
	local ui_animations = self.ui_animations
	local animation_name = "topic_widget_" .. topic_index
	local hover_animation_name = "topic_widget_hover_" .. topic_index
	local animation_duration = UISettings.scoreboard.topic_data_fade_in_duration
	local name = ""

	if player_name then
		name = (PLAYER_NAME_MAX_LENGTH < UTF8Utils.string_length(player_name) and UIRenderer.crop_text_width(self.ui_renderer, player_name, 250, widget_style.player_name)) or player_name
	end

	widget_content.topic_data_index = topic_data_index
	local localized_title = (title and Localize(title)) or ""
	local title_style = widget_style.title_text
	local font, scaled_font_size = UIFontByResolution(title_style)
	local text_width, _, _ = UIRenderer.text_size(self.ui_renderer, localized_title, font[1], scaled_font_size)

	if 235 <= text_width then
		title_style.word_wrap = true
		title_style.font_size = 22
		title_style.offset[1] = 52
		title_style.offset[2] = -25
		title_style.size[1] = 220
	else
		title_style.word_wrap = false
		title_style.font_size = 28
		title_style.offset[1] = 12
		title_style.offset[2] = -30
		title_style.size[1] = 280
	end

	widget_content.title_text = localized_title
	widget_content.score_text = (score and score) or ""
	widget_content.player_name = name
	self.handle_input_wait_time = animation_duration

	return 
end
ScoreboardUI.update_topic_scroll_animation = function (self, dt)
	local time = self.topic_animation_time

	if time then
		local total_time = UISettings.scoreboard.topic_scroll_duration
		time = time + dt
		local progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, -6, 0, 1, 0)

		self.animate_scenegraph_to_position(self, "topic_widget_root", self.topic_widgets, catmullrom_value, true)

		if progress == 1 then
			self.on_topic_scroll_complete(self)

			self.topic_animation_time = nil
		else
			self.topic_animation_time = time
		end
	end

	return 
end
ScoreboardUI.on_topic_scroll_complete = function (self)
	local number_of_topic_pages = self.number_of_topic_pages
	local current_scroll_index = self.topic_scroll_index
	local topic_widgets = self.topic_widgets

	for i = 1, number_of_topic_pages, 1 do
		local widget_element_content = self.topic_index_counter_widget.content.list_content[i]
		widget_element_content.disabled = nil
	end

	for i = 1, #topic_widgets, 1 do
		local widget = self.topic_widgets[i]
		local widget_content = widget.content
		widget_content.button_hotspot.disabled = nil
	end

	local topic_selected_data_index = self.topic_selected_data_index

	if topic_selected_data_index then
		self.select_topic_index_by_data_index(self, topic_selected_data_index)
	end

	return 
end
ScoreboardUI.animate_scenegraph_to_position = function (self, scenegraph_id, widget_list, progress, animate_in)
	local topic_width = definitions.scenegraph.compact_preview_1.size[1]
	local direction = self.topic_animation_direction
	local ui_scenegraph = self.ui_scenegraph
	local topic_spacing = definitions.COMPACT_PREVIEW_SPACING
	local root_width_size = definitions.scenegraph.topic_dummy_root.size[1] + topic_spacing[1]
	local from_position = (animate_in and ((direction == "right" and -root_width_size) or root_width_size)) or 0
	local to_position = (not animate_in or 0) and ((direction == "right" and root_width_size) or -root_width_size)
	local lerp_position = math.lerp(from_position, to_position, progress)
	local root_position = ui_scenegraph[scenegraph_id].local_position
	root_position[1] = lerp_position

	return 
end
ScoreboardUI.update_topic_widgets_mouse_input = function (self)
	local delay_auto_pilot = nil
	local topic_widgets = self.topic_widgets
	local new_selection_index, hover_enter_topic_index, hover_exit_topic_index = nil

	for i = 1, #topic_widgets, 1 do
		local widget = topic_widgets[i]
		local widget_content = widget.content
		local hotspot = widget_content.button_hotspot

		if not hotspot.disabled then
			if hotspot.on_release then
				new_selection_index = i
			end

			local selected_index = self.topic_selected_index
			hotspot.is_selected = (new_selection_index and new_selection_index == i) or selected_index == i
			local is_selected = hotspot.is_selected
			local is_hover = hotspot.is_hover
			local on_hover_enter = hotspot.on_hover_enter
			local on_hover_exit = hotspot.on_hover_exit
			local tweened_in = widget_content.tweened_in

			if on_hover_enter and not is_selected then
				self.on_topic_widget_hover(self, widget, i)

				hover_enter_topic_index = i
			elseif on_hover_exit then
				self.on_topic_widget_dehover(self, widget, i)

				hover_exit_topic_index = i
			end
		end
	end

	if hover_enter_topic_index then
		local widget_start_draw_index = self.widget_start_draw_index or 1
		local widget_hover_index = hover_enter_topic_index - widget_start_draw_index + 1
		local topic_hover_data_index = (self.selected_topic_counter_index - 1)*TOPICS_PER_PAGE + widget_hover_index

		self.set_player_list_data_by_index(self, topic_hover_data_index)
	elseif hover_exit_topic_index then
		local index = self.topic_selected_data_index or 1

		self.set_player_list_data_by_index(self, index)
	end

	local selected_index = self.topic_selected_index

	if new_selection_index and new_selection_index ~= selected_index then
		if selected_index then
			self.on_topic_widget_deselect(self, topic_widgets[selected_index], selected_index)
		end

		self.on_topic_widget_select(self, topic_widgets[new_selection_index], new_selection_index, true)
		self.play_sound(self, "Play_hud_select")

		delay_auto_pilot = true
	end

	if delay_auto_pilot then
		self.auto_pilot_wait_time = UISettings.scoreboard.auto_pilot_wait_time
	end

	return 
end
ScoreboardUI.show_selected_player_gamercard = function (self, peer_id)
	if peer_id then
		local platform = self.platform

		if platform == "win32" and rawget(_G, "Steam") then
			local id = Steam.id_hex_to_dec(peer_id)
			local url = "http://steamcommunity.com/profiles/" .. id

			Steam.open_url(url)
		elseif platform == "xb1" then
			local xuid = self.network_lobby.lobby:xuid(peer_id)

			if xuid then
				XboxLive.show_gamercard(Managers.account:user_id(), xuid)
			end
		elseif platform == "ps4" then
			local np_id = self.network_lobby.lobby:np_id_from_peer_id(peer_id)

			Managers.account:show_player_profile_with_np_id(np_id)
		end
	end

	return 
end

return 
