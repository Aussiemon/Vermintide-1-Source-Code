local definitions = local_require("scripts/ui/views/ingame_player_list_ui_definitions")
local generic_input_actions = definitions.generic_input_actions
local PLAYER_NAME_MAX_LENGTH = 16
IngamePlayerListUI = class(IngamePlayerListUI)
IngamePlayerListUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.wwise_world = ingame_ui_context.dialogue_system.wwise_world
	self.input_manager = ingame_ui_context.input_manager
	self.player_manager = ingame_ui_context.player_manager
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.level_transition_handler = ingame_ui_context.level_transition_handler
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.is_in_inn = ingame_ui_context.is_in_inn
	self.voip = ingame_ui_context.voip
	self.map_save_data = PlayerData.map_view_data or {}
	self.platform = PLATFORM
	self.is_server = ingame_ui_context.is_server
	self.network_server = ingame_ui_context.network_server
	local input_manager = self.input_manager

	input_manager.create_input_service(input_manager, "player_list_input", "IngamePlayerListKeymaps", "IngamePlayerListFilters")
	input_manager.map_device_to_service(input_manager, "player_list_input", "keyboard")
	input_manager.map_device_to_service(input_manager, "player_list_input", "mouse")
	input_manager.map_device_to_service(input_manager, "player_list_input", "gamepad")

	self.network_lobby = ingame_ui_context.network_lobby
	self.local_player = self.player_manager:local_player()
	self.num_players = 0
	self.players = {}
	self.active = false

	self.create_ui_elements(self)

	local level_key = self.level_transition_handler:get_current_level_keys()
	local level_settings = LevelSettings[level_key]

	self.set_level_name(self, level_settings.display_name)

	local input_service = input_manager.get_service(input_manager, "player_list_input")
	local gui_layer = definitions.scenegraph_definition.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, 6, gui_layer, generic_input_actions.default)
	local gamemode_settings = Managers.state.game_mode:settings()
	local private_only = gamemode_settings.private_only
	self.private_only = private_only
	self.private_setting_enabled = not private_only and not self.is_in_inn and self.local_player.is_server and self.platform ~= "xb1"

	if self.private_setting_enabled then
		self.menu_input_description:set_input_description(definitions.private_input_description)
	end

	local network_manager = Managers.state.network
	local network_transmit = network_manager.network_transmit
	local server_peer_id = network_transmit.server_peer_id
	self.host_peer_id = server_peer_id or network_transmit.peer_id

	rawset(_G, "ingame_player_list", self)

	return 
end
IngamePlayerListUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.input_description_text_widget = UIWidget.init(definitions.widget_definitions.input_description_text)
	self.background = UIWidget.init(definitions.widget_definitions.background)
	self.headers = UIWidget.init(definitions.widget_definitions.headers)
	local player_list_widgets = {}

	for i = 1, 4, 1 do
		player_list_widgets[i] = UIWidget.init(definitions.player_widget_definition(i))
	end

	self.player_list_widgets = player_list_widgets
	self.popup_list = UIWidget.init(definitions.popup_widget_definition)
	self.private_checkbox_widget = UIWidget.init(definitions.widget_definitions.private_checkbox)
	self.private_text_gamepad_widget = UIWidget.init(definitions.widget_definitions.private_text_gamepad)

	return 
end
IngamePlayerListUI.destroy = function (self)
	if self.cursor_active then
		ShowCursorStack.pop()

		local input_manager = self.input_manager

		input_manager.device_unblock_all_services(input_manager, "keyboard")
		input_manager.device_unblock_all_services(input_manager, "mouse")
		input_manager.device_unblock_all_services(input_manager, "gamepad")

		self.cursor_active = false
	end

	self.menu_input_description:destroy()

	self.menu_input_description = nil

	rawset(_G, "ingame_player_list", nil)

	return 
end
IngamePlayerListUI.set_level_name = function (self, name)
	local content = self.headers.content
	content.game_level = name

	return 
end
IngamePlayerListUI.set_difficulty_name = function (self, name)
	local content = self.headers.content
	content.game_difficulty = name

	return 
end
IngamePlayerListUI.add_player = function (self, player)
	local is_local_player = player.local_player
	local player_level = ExperienceSettings.get_player_level(player)
	local peer_id = player.network_id(player)
	local is_player_server = self.host_peer_id == peer_id
	local player_data = {
		is_local_player = is_local_player,
		peer_id = peer_id,
		local_player_id = player.local_player_id(player),
		player = player,
		player_name = player.name(player),
		level = player_level or "n/a",
		resync_player_level = not player_level,
		is_server = is_player_server
	}
	self.num_players = self.num_players + 1
	self.players[self.num_players] = player_data

	return 
end
IngamePlayerListUI.select_player = function (self, player_index)
	self.selected_player_index = player_index
	local players = self.players
	local num_players = self.num_players

	for i = 1, num_players, 1 do
		players[i].widget.content.button_hotspot.is_selected = i == player_index
	end

	return 
end
IngamePlayerListUI.deselect_player = function (self)
	self.selected_player_index = nil
	local players = self.players
	local num_players = self.num_players

	for i = 1, num_players, 1 do
		local button_hotspot = players[i].widget.content.button_hotspot
		button_hotspot.is_selected = nil
		button_hotspot.is_hover = nil
		button_hotspot.is_clicked = nil
	end

	return 
end
IngamePlayerListUI.update_widgets = function (self)
	local players = self.players
	local num_players = self.num_players
	local can_start_vote = Managers.state.voting:can_start_vote("kick_player")
	local vote_kick_enabled = Managers.state.voting:vote_kick_enabled()
	local private_game = Managers.matchmaking:is_game_private()
	local can_kick = can_start_vote and vote_kick_enabled
	local is_pc = self.platform == "win32"

	for i = 1, num_players, 1 do
		local player_data = players[i]
		local is_local_player = player_data.is_local_player
		local is_server = player_data.is_server
		local can_kick_player = not is_server and (can_kick or self.can_host_solo_kick(self))
		local widget = self.player_list_widgets[i]
		local widget_content = widget.content
		widget_content.show_host = is_server
		local resync_player_level = player_data.resync_player_level

		if resync_player_level then
			local player = player_data.player
			local player_level = ExperienceSettings.get_player_level(player)

			if player_level then
				player_data.level = player_level
				player_data.resync_player_level = nil
			end
		end

		if is_local_player then
			widget_content.show_chat_button = false
			widget_content.show_kick_button = false
			widget_content.show_voice_button = false
			widget_content.show_profile_button = false
			widget_content.show_ping = (not is_server and true) or false
			widget_content.chat_button_hotspot.disable_button = true
			widget_content.kick_button_hotspot.disable_button = true
			widget_content.voice_button_hotspot.disable_button = true
			widget_content.profile_button_hotspot.disable_button = true
		else
			if can_kick_player then
				widget_content.show_kick_button = true
				widget_content.kick_button_hotspot.disable_button = false
			else
				widget_content.show_kick_button = false
				widget_content.kick_button_hotspot.disable_button = true
			end

			widget_content.show_profile_button = true
			widget_content.show_chat_button = is_pc
			widget_content.show_voice_button = true
			widget_content.show_ping = true
			widget_content.profile_button_hotspot.disable_button = false
			widget_content.chat_button_hotspot.disable_button = not is_pc
			widget_content.voice_button_hotspot.disable_button = false
			widget_content.chat_button_hotspot.is_selected = self.ignoring_chat_peer_id(self, player_data.peer_id)
			widget_content.voice_button_hotspot.is_selected = self.muted_peer_id(self, player_data.peer_id)
		end

		local name = player_data.player_name
		player_data.player_name = (PLAYER_NAME_MAX_LENGTH < UTF8Utils.string_length(name) and UIRenderer.crop_text_width(self.ui_renderer, name, 370, widget.style.name)) or name

		self.align_player_buttons(self, widget)

		player_data.widget = widget
	end

	return 
end
IngamePlayerListUI.align_player_buttons = function (self, widget)
	local widget_content = widget.content
	local widget_style = widget.style
	local chat_button_offset = widget_style.chat_button_hotspot.offset
	local profile_button_offset = widget_style.profile_button_hotspot.offset

	if widget_content.show_chat_button then
		chat_button_offset[1] = 402
		profile_button_offset[1] = 352
	else
		chat_button_offset[1] = 352
		profile_button_offset[1] = 402
	end

	return 
end
IngamePlayerListUI.update_player_information = function (self)
	local profiles = SPProfiles
	local profile_synchronizer = self.profile_synchronizer
	local players = self.players
	local num_players = self.num_players

	for i = 1, num_players, 1 do
		local player = players[i]
		local widget = player.widget
		widget.content.name = player.player_name
		widget.content.level = player.level
		local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, player.peer_id, player.local_player_id)
		local display_name = (profiles[profile_index] and profiles[profile_index].display_name) or "unspawned"
		widget.content.hero = display_name
		widget.content.hero_texture = definitions.hero_textures[display_name]
	end

	return 
end
IngamePlayerListUI.update_player_ping_list = function (self, dt)
	local delay_time = self.time_to_next_ping_update

	if delay_time then
		local new_time = delay_time - dt

		if new_time <= 0 then
			new_time = nil
		end

		self.time_to_next_ping_update = new_time

		return 
	end

	local matchmaking_manager = Managers.matchmaking
	self.pings_by_peer_id = matchmaking_manager.get_players_ping(matchmaking_manager)
	self.time_to_next_ping_update = 2.5

	return 
end
IngamePlayerListUI.get_ping_by_peer_id = function (self, peer_id)
	local pings_by_peer_id = self.pings_by_peer_id

	if pings_by_peer_id then
		local ping_data = pings_by_peer_id[peer_id]

		if ping_data then
			local number_of_ping_values = #ping_data
			local total_value = 0

			for i = 1, number_of_ping_values, 1 do
				total_value = total_value + ping_data[i]
			end

			local avrage_value = (0 < total_value and total_value/number_of_ping_values) or 0

			return avrage_value*1000
		end
	end

	return 255
end
IngamePlayerListUI.get_ping_color_by_ping_value = function (self, ping_value)
	if ping_value <= 100 then
		return Colors.color_definitions.green
	elseif 100 < ping_value and ping_value <= 150 then
		return Colors.color_definitions.yellow
	elseif 150 < ping_value then
		return Colors.color_definitions.red
	end

	return 
end
IngamePlayerListUI.ignoring_chat_peer_id = function (self, peer_id)
	local chat_gui = Managers.chat.chat_gui

	return chat_gui.ignoring_peer_id(chat_gui, peer_id)
end
IngamePlayerListUI.ignore_chat_message_from_peer_id = function (self, peer_id)
	local chat_gui = Managers.chat.chat_gui

	chat_gui.ignore_peer_id(chat_gui, peer_id)

	return 
end
IngamePlayerListUI.remove_ignore_chat_message_from_peer_id = function (self, peer_id)
	local chat_gui = Managers.chat.chat_gui

	chat_gui.remove_ignore_peer_id(chat_gui, peer_id)

	return 
end
IngamePlayerListUI.muted_peer_id = function (self, peer_id)
	if PLATFORM == "xb1" then
		return Managers.voice_chat:is_peer_muted(peer_id)
	else
		return self.voip:peer_muted(peer_id)
	end

	return 
end
IngamePlayerListUI.ignore_voice_message_from_peer_id = function (self, peer_id)
	if PLATFORM == "xb1" then
		Managers.voice_chat:mute_peer(peer_id)
	else
		self.voip:mute_member(peer_id)
	end

	return 
end
IngamePlayerListUI.remove_ignore_voice_message_from_peer_id = function (self, peer_id)
	if PLATFORM == "xb1" then
		Managers.voice_chat:unmute_peer(peer_id)
	else
		self.voip:unmute_member(peer_id)
	end

	return 
end
IngamePlayerListUI.update = function (self, dt)
	local input_manager = self.input_manager
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local in_fade_active = Managers.transition:in_fade_active()
	local input_service = input_manager.get_service(input_manager, "player_list_input")

	if not in_fade_active and (input_service.get(input_service, "ingame_player_list_exit") or input_service.get(input_service, "ingame_player_list_toggle") or input_service.get(input_service, "back")) and self.active and self.cursor_active then
		self.set_active(self, false)
	elseif not self.cursor_active then
		if not in_fade_active and input_service.get(input_service, "ingame_player_list_toggle") then
			if not self.active then
				self.set_active(self, true)

				if not self.cursor_active then
					ShowCursorStack.push()
					input_manager.block_device_except_service(input_manager, "player_list_input", "keyboard")
					input_manager.block_device_except_service(input_manager, "player_list_input", "mouse")
					input_manager.block_device_except_service(input_manager, "player_list_input", "gamepad")

					self.cursor_active = true
				end
			end
		elseif input_service.get(input_service, "ingame_player_list_pressed") then
			if not self.active then
				self.set_active(self, true)
			end
		elseif self.active and not input_service.get(input_service, "ingame_player_list_held") then
			self.set_active(self, false)
		end
	end

	if self.active then
		if input_service.get(input_service, "activate_ingame_player_list") and not self.cursor_active then
			ShowCursorStack.push()
			input_manager.block_device_except_service(input_manager, "player_list_input", "keyboard")
			input_manager.block_device_except_service(input_manager, "player_list_input", "mouse")
			input_manager.block_device_except_service(input_manager, "player_list_input", "gamepad")

			self.cursor_active = true
		end

		self.update_player_ping_list(self, dt)
		self.update_player_list(self)
		self.update_difficulty(self)

		if self.local_player.is_server and not self.is_in_inn then
			local private_checkbox_hotspot = self.private_checkbox_widget.content.button_hotspot

			if private_checkbox_hotspot.on_hover_enter then
				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_hover")
			end

			if self.private_setting_enabled and (private_checkbox_hotspot.on_release or (gamepad_active and input_service.get(input_service, "toggle_private"))) then
				local is_private = Managers.matchmaking:is_game_private()
				local map_save_data = self.map_save_data
				map_save_data.private_enabled = not is_private

				WwiseWorld.trigger_event(self.wwise_world, "Play_hud_select")
				self.set_privacy_enabled(self, map_save_data.private_enabled, true)

				PlayerData.map_view_data = map_save_data

				Managers.save:auto_save(SaveFileName, SaveData, callback(self, "on_save_ended_callback"))

				local matchmaking_manager = Managers.matchmaking

				matchmaking_manager.set_in_progress_game_privacy(matchmaking_manager, map_save_data.private_enabled)
			end
		end

		if gamepad_active then
			if not self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = true

				self.on_gamepad_activated(self)
			end

			self.handle_gamepad_navigation_input(self, dt)
			self._update_gamepad_private_text_animation(self, dt)
		elseif self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = false

			self.on_gamepad_deactivated(self)
		end

		self.draw(self, dt)
	end

	return 
end
IngamePlayerListUI.set_privacy_enabled = function (self, enabled, animate)
	local widget = self.private_checkbox_widget
	widget.content.selected = enabled
	local text = (enabled and "map_screen_private_button") or "map_public_setting"
	self.private_text_gamepad_widget.content.text = Localize(text)

	if animate then
		self._private_timer = 0
	end

	return 
end
IngamePlayerListUI._update_gamepad_private_text_animation_timer = function (self, dt)
	local timer = self._private_timer

	if timer then
		local total_time = 0.15

		if timer == total_time then
			self._private_timer = nil

			return 
		else
			timer = math.min(timer + dt, total_time)
			self._private_timer = timer

			return timer/total_time
		end
	end

	return 
end
IngamePlayerListUI._update_gamepad_private_text_animation = function (self, dt, instant)
	local progress = self._update_gamepad_private_text_animation_timer(self, dt)

	if not progress then
		return 
	end

	local anim_progress = math.ease_pulse(progress)
	local text_style = self.private_text_gamepad_widget.style.text
	text_style.font_size = anim_progress*10 + 22

	return 
end
IngamePlayerListUI.on_save_ended_callback = function (self)
	print("[IngamePlayerWiew] - settings saved")

	return 
end
IngamePlayerListUI.on_gamepad_activated = function (self)
	self.select_player(self, 1)

	return 
end
IngamePlayerListUI.on_gamepad_deactivated = function (self)
	self.deselect_player(self)

	return 
end
IngamePlayerListUI.handle_gamepad_navigation_input = function (self, dt)
	self.update_input_description(self)

	local input_service = self.input_manager:get_service("player_list_input")
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
	else
		local selected_player_index = self.selected_player_index
		local players = self.players
		local selected_player = players[selected_player_index]

		if selected_player then
			local peer_id = selected_player.peer_id
			local selected_widget = selected_player.widget

			if input_service.get(input_service, "mute_chat", true) then
				local selected_widget_content = selected_widget.content

				if selected_widget_content.show_chat_button then
					local chat_button_hotspot = selected_widget_content.chat_button_hotspot

					if chat_button_hotspot.is_selected then
						self.remove_ignore_chat_message_from_peer_id(self, peer_id)

						chat_button_hotspot.is_selected = nil
					else
						self.ignore_chat_message_from_peer_id(self, peer_id)

						chat_button_hotspot.is_selected = true
					end
				end

				return 
			elseif input_service.get(input_service, "mute_voice", true) then
				local selected_widget_content = selected_widget.content

				if selected_widget_content.show_voice_button then
					local voice_button_hotspot = selected_widget_content.voice_button_hotspot

					if voice_button_hotspot.is_selected then
						self.remove_ignore_voice_message_from_peer_id(self, peer_id)

						voice_button_hotspot.is_selected = nil
					else
						self.ignore_voice_message_from_peer_id(self, peer_id)

						voice_button_hotspot.is_selected = true
					end
				end

				return 
			elseif input_service.get(input_service, "kick_player", true) then
				local selected_widget_content = selected_widget.content

				if selected_widget_content.show_kick_button then
					local can_start_vote = Managers.state.voting:can_start_vote("kick_player")
					local vote_kick_enabled = Managers.state.voting:vote_kick_enabled()
					local private_game = Managers.matchmaking:is_game_private()
					local can_kick = can_start_vote and vote_kick_enabled and not private_game

					if can_kick then
						self.kick_player(self, selected_player.player)
					end
				end

				return 
			elseif input_service.get(input_service, "show_profile", true) then
				local selected_widget_content = selected_widget.content

				if selected_widget_content.show_profile_button then
					self.show_profile_by_peer_id(self, peer_id)
				end

				return 
			end

			local new_selection_index = selected_player_index

			if input_service.get(input_service, "move_down", true) then
				new_selection_index = math.min(new_selection_index + 1, self.num_players)
			elseif input_service.get(input_service, "move_up", true) then
				new_selection_index = math.max(new_selection_index - 1, 1)
			end

			if new_selection_index ~= selected_player_index then
				self.select_player(self, new_selection_index)

				self.controller_cooldown = 0.15
			end
		end
	end

	return 
end
IngamePlayerListUI.update_input_description = function (self)
	local actions_name_to_use = "default"
	local selected_player_index = self.selected_player_index
	local players = self.players
	local selected_player = players[selected_player_index]

	if selected_player then
		local selected_widget = selected_player.widget
		local widget_content = selected_widget.content

		if selected_player.is_local_player then
			actions_name_to_use = "own_player"
		else
			local is_server = selected_player.is_server
			local chat_mute_enabled = widget_content.show_chat_button
			local voice_mute_enabled = widget_content.show_voice_button
			local chat_muted = widget_content.chat_button_hotspot.is_selected
			local voice_muted = widget_content.voice_button_hotspot.is_selected
			local can_start_vote = Managers.state.voting:can_start_vote("kick_player")
			local vote_kick_enabled = Managers.state.voting:vote_kick_enabled()
			local private_game = Managers.matchmaking:is_game_private()
			local can_kick = can_start_vote and vote_kick_enabled and not private_game

			if chat_muted and voice_muted then
				if is_server or not can_kick then
					actions_name_to_use = "server_voice_and_chat_muted"
				else
					actions_name_to_use = "voice_and_chat_muted"
				end
			elseif chat_muted then
				if is_server or not can_kick then
					actions_name_to_use = "server_chat_muted"
				else
					actions_name_to_use = "chat_muted"
				end
			elseif not can_kick and not voice_muted and not is_server then
				actions_name_to_use = "kick_unavailable"
			elseif not can_kick and voice_muted and not is_server then
				actions_name_to_use = "voice_and_kick_unavailable"
			elseif voice_muted then
				if is_server or not can_kick then
					actions_name_to_use = "server_voice_muted"
				else
					actions_name_to_use = "voice_muted"
				end
			elseif is_server then
				actions_name_to_use = "server_default"
			end
		end

		if not self.gamepad_active_generic_actions_name or self.gamepad_active_generic_actions_name ~= actions_name_to_use then
			self.gamepad_active_generic_actions_name = actions_name_to_use
			local generic_actions = generic_input_actions[actions_name_to_use]

			self.menu_input_description:change_generic_actions(generic_actions)
		end
	end

	return 
end
IngamePlayerListUI.is_active = function (self)
	return self.active
end
IngamePlayerListUI.is_focused = function (self)
	return self.active and self.cursor_active
end
IngamePlayerListUI.input_service = function (self)
	local input_manager = self.input_manager

	return input_manager.get_service(input_manager, "player_list_input")
end
IngamePlayerListUI.set_active = function (self, active)
	local gamepad_active = self.input_manager:is_device_active("gamepad")

	if gamepad_active then
		if active then
			self.on_gamepad_activated(self)
		else
			self.on_gamepad_deactivated(self)
		end
	end

	local chat_gui = Managers.chat.chat_gui

	if active then
		chat_gui.show_chat(chat_gui)

		if self.local_player.is_server and not self.is_in_inn then
			local is_private = Managers.matchmaking:is_game_private()

			self.set_privacy_enabled(self, is_private)
		end
	else
		chat_gui.hide_chat(chat_gui)
	end

	self.active = active
	local input_manager = self.input_manager

	if self.cursor_active then
		ShowCursorStack.pop()
		input_manager.device_unblock_all_services(input_manager, "keyboard")
		input_manager.device_unblock_all_services(input_manager, "mouse")
		input_manager.device_unblock_all_services(input_manager, "gamepad")

		self.cursor_active = false
	end

	return 
end
local debug_players = {
	[999] = {
		peer_id = 999,
		local_player_id = 1,
		name = function ()
			return "Playername_01"
		end
	},
	[91092] = {
		peer_id = 91092,
		local_player_id = 1,
		name = function ()
			return "Playername_02"
		end
	},
	[2109456] = {
		peer_id = 2109456,
		local_player_id = 1,
		name = function ()
			return "Playername_03"
		end
	},
	[588120] = {
		peer_id = 588120,
		local_player_id = 1,
		name = function ()
			return "Playername_04"
		end
	}
}
local temp_players = {}
IngamePlayerListUI.update_player_list = function (self)
	local player_manager = self.player_manager

	table.clear(temp_players)

	local update_widgets = false
	local players = self.players
	local num_players = self.num_players
	local removed_players = 0

	for i = num_players, 1, -1 do
		local data = players[i]
		local peer_id = data.peer_id
		local player = player_manager.player_from_peer_id(player_manager, peer_id, data.local_player_id)

		if not player then
			table.remove(players, i)

			update_widgets = true
			removed_players = removed_players + 1
		else
			temp_players[peer_id] = true

			if not data.is_local_player then
				local widget = data.widget
				local ping = self.get_ping_by_peer_id(self, peer_id)
				local ping_color = self.get_ping_color_by_ping_value(self, ping)
				widget.style.ping_texture.color = ping_color
				local chat_button_hotspot = widget.content.chat_button_hotspot

				if chat_button_hotspot.on_pressed then
					chat_button_hotspot.on_pressed = nil

					if chat_button_hotspot.is_selected then
						self.remove_ignore_chat_message_from_peer_id(self, peer_id)

						chat_button_hotspot.is_selected = nil
					else
						self.ignore_chat_message_from_peer_id(self, peer_id)

						chat_button_hotspot.is_selected = true
					end
				end

				local voice_button_hotspot = widget.content.voice_button_hotspot

				if voice_button_hotspot.on_pressed then
					voice_button_hotspot.on_pressed = nil

					if voice_button_hotspot.is_selected then
						self.remove_ignore_voice_message_from_peer_id(self, peer_id)

						voice_button_hotspot.is_selected = nil
					else
						self.ignore_voice_message_from_peer_id(self, peer_id)

						voice_button_hotspot.is_selected = true
					end
				end

				local profile_button_hotspot = widget.content.profile_button_hotspot

				if profile_button_hotspot.on_pressed then
					profile_button_hotspot.on_pressed = nil

					self.show_profile_by_peer_id(self, peer_id)
				end

				local is_server = data.is_server
				local kick_button_hotspot = widget.content.kick_button_hotspot

				if not is_server and kick_button_hotspot.on_pressed then
					kick_button_hotspot.on_pressed = nil

					self.kick_player(self, data.player)
				end
			end
		end
	end

	self.num_players = num_players - removed_players
	local players = Managers.player:human_players()

	for _, player in pairs(players) do
		if not temp_players[player.network_id(player)] then
			self.add_player(self, player)

			update_widgets = true
		end
	end

	if update_widgets then
		self.update_widgets(self)
	end

	self.update_player_information(self)

	return 
end
IngamePlayerListUI.update_difficulty = function (self)
	local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
	local difficulty_name = difficulty_settings.display_name

	if difficulty_name ~= self.current_difficulty_name then
		if self.is_in_inn then
			self.set_difficulty_name(self, "")
		else
			self.set_difficulty_name(self, Localize(difficulty_name))
		end

		self.current_difficulty_name = difficulty_name
	end

	return 
end
IngamePlayerListUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "player_list_input")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)

	if not gamepad_active and not self.cursor_active then
		UIRenderer.draw_widget(ui_renderer, self.input_description_text_widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.background)
	UIRenderer.draw_widget(ui_renderer, self.headers)

	if self.private_setting_enabled then
		if gamepad_active then
			UIRenderer.draw_widget(ui_renderer, self.private_text_gamepad_widget)
		else
			UIRenderer.draw_widget(ui_renderer, self.private_checkbox_widget)
		end
	end

	local players = self.players
	local num_players = self.num_players

	for i = 1, num_players, 1 do
		local player = players[i]
		local widget = player.widget

		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	if gamepad_active then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	return 
end
IngamePlayerListUI.can_host_solo_kick = function (self)
	return self.is_server and Managers.player:num_human_players() == 2
end
IngamePlayerListUI.kick_player = function (self, player)
	local kick_peer_id = player.peer_id

	if self.can_host_solo_kick(self) then
		self.network_server:kick_peer(kick_peer_id)
	else
		local vote_data = {
			kick_peer_id = kick_peer_id
		}

		Managers.state.voting:request_vote("kick_player", vote_data, Network.peer_id())
		self.set_active(self, false)
	end

	return 
end
IngamePlayerListUI.kick_player_available = function (self, player)
	local peer_id = player.peer_id

	if peer_id == Network.peer_id() then
		return false
	end

	if not Managers.state.voting:can_start_vote("kick_player") then
		return false
	end

	return true
end
IngamePlayerListUI.show_profile_by_peer_id = function (self, peer_id)
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

	return 
end

return 
