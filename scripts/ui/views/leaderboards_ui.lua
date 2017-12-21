require("scripts/managers/leaderboards/leaderboard_settings")

local definitions = local_require("scripts/ui/views/leaderboards_ui_definitions")
local LEADERBOARD_DEBUG = false

local function debug_print(...)
	if LEADERBOARD_DEBUG then
		print("[LeaderboardsUI]", string.format(...))
	end

	return 
end

local generic_input_actions = {
	default = {
		{
			input_action = "l1_r1",
			priority = 1,
			description_text = "input_description_change_leaderboard",
			ignore_keybinding = true
		},
		{
			input_action = "special_1",
			priority = 2,
			description_text = "input_description_change_filter_leaderboard"
		},
		{
			input_action = "confirm",
			priority = 3,
			description_text = "input_description_show_profile_xb1"
		},
		{
			input_action = "back",
			priority = 4,
			description_text = "back_menu_button_name"
		}
	}
}
LeaderboardsUI = class(LeaderboardsUI)
LeaderboardsUI.init = function (self, context, input_service_name)
	self._world = Managers.world:world("level_world")
	self._wwise_world = Wwise.wwise_world(self._world)
	self._ui_renderer = context.ui_renderer
	self._stats_id = context.stats_id
	self._statistics_db = context.statistics_db
	self._platform = PLATFORM
	self._enabled = false
	self._entries = {}
	self._platform = PLATFORM
	self._input_service_name = input_service_name
	self._current_leaderboard_type = 1

	if self._platform == "xb1" then
		self._leaderboard_types = {
			Leaderboards.OVERALL,
			Leaderboards.MYSCORE,
			Leaderboards.FRIENDS
		}
	elseif self._platform == "win32" then
		self._leaderboard_types = {
			Leaderboard.RT_GLOBAL,
			Leaderboard.RT_AROUND_USER,
			Leaderboard.RT_FRIENDS
		}
	end

	self._leaderboard_strings = {
		"leaderboard_global",
		"leaderboard_my_score",
		"leaderboard_friends"
	}

	self._create_ui_elements(self)

	return 
end
LeaderboardsUI.open = function (self, level_key)
	if not self._open_window_animation and not self._close_window_animation then
		local level_key = level_key or Managers.state.game_mode:level_key()
		local display_name = LevelSettings[level_key].display_name
		self._window_widget.content.leaderboard_header = display_name
		self._enabled = true
		self._level_key = level_key
		self._profile_index = Managers.player:local_player().profile_index

		self.select_button_index(self, self._profile_index)

		local ui_scenegraph = self._ui_scenegraph
		local target = ui_scenegraph.root.local_position
		local target_index = 2
		self._open_window_animation = self.animate_element_by_time(self, target, target_index, -1200, 0, UISettings.scoreboard.open_duration)
	end

	return 
end
LeaderboardsUI.on_open_complete = function (self)
	self._open = true
	local profile_index = Managers.player:local_player().profile_index
	local display_name = SPProfiles[profile_index].display_name

	if not self._level_key then
		Application.error("[LeaderboardsUI] No level_key provided -> leaderboards won't be available")

		self._entries = {}
		self._base_offset = {
			0,
			0,
			1
		}
		self._current_leaderboard = nil

		self._create_entries(self, nil)

		return 
	end

	local leaderboard_name = self._level_key .. "_" .. display_name

	if self._current_leaderboard ~= leaderboard_name then
		self._entries = {}
		self._base_offset = {
			0,
			0,
			1
		}
		self._current_leaderboard = leaderboard_name

		if PLATFORM == "win32" then
			self._updating_leaderboard = true

			Managers.leaderboards:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 1, 20)
		elseif PLATFORM == "xb1" then
			self._updating_leaderboard = true

			Managers.account:get_leaderboard(leaderboard_name, Leaderboards.OVERALL, callback(self, "_create_entries"), 20, nil, LeaderboardSettings.template)
		end
	end

	return 
end
LeaderboardsUI.close = function (self)
	if not self._open_window_animation and not self._close_window_animation then
		local ui_scenegraph = self._ui_scenegraph
		local target = ui_scenegraph.root.local_position
		local target_index = 2
		self._close_window_animation = self.animate_element_by_time(self, target, target_index, 0, -1200, UISettings.scoreboard.close_duration)
		self._open = false
	end

	return 
end
LeaderboardsUI.on_close_complete = function (self)
	self._enabled = false

	return 
end
LeaderboardsUI.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.ease_out_quad)

	return new_animation
end
LeaderboardsUI._add_leaderboard_type_animation = function (self)
	self._window_widget.content.leaderboard_type = self._leaderboard_strings[self._current_leaderboard_type]
	self._leaderboard_type_animation = {
		timer = 0,
		duration = 0.35,
		pulse_font_size = 45,
		animation_func = math.ease_pulse,
		text_color = definitions.widgets.window.style.leaderboard_type.text_color,
		pulse_text_color = {
			255,
			255,
			255,
			255
		},
		font_size = definitions.widgets.window.style.leaderboard_type.font_size
	}

	return 
end
LeaderboardsUI._update_leaderboard_animation = function (self, dt)
	local leaderboard_type_animation = self._leaderboard_type_animation

	if not leaderboard_type_animation then
		return 
	end

	local progress = leaderboard_type_animation.animation_func(leaderboard_type_animation.timer/leaderboard_type_animation.duration)
	self._window_widget.style.leaderboard_type.text_color[1] = math.lerp(leaderboard_type_animation.text_color[1], leaderboard_type_animation.pulse_text_color[1], progress)
	self._window_widget.style.leaderboard_type.text_color[2] = math.lerp(leaderboard_type_animation.text_color[2], leaderboard_type_animation.pulse_text_color[2], progress)
	self._window_widget.style.leaderboard_type.text_color[3] = math.lerp(leaderboard_type_animation.text_color[3], leaderboard_type_animation.pulse_text_color[3], progress)
	self._window_widget.style.leaderboard_type.text_color[4] = math.lerp(leaderboard_type_animation.text_color[4], leaderboard_type_animation.pulse_text_color[4], progress)
	self._window_widget.style.leaderboard_type.font_size = math.lerp(leaderboard_type_animation.font_size, leaderboard_type_animation.pulse_font_size, progress)
	leaderboard_type_animation.timer = leaderboard_type_animation.timer + dt

	if leaderboard_type_animation.duration <= leaderboard_type_animation.timer then
		self._window_widget.style.leaderboard_type.text_color = table.clone(leaderboard_type_animation.text_color)
		self._window_widget.style.leaderboard_type.font_size = leaderboard_type_animation.font_size
		self._leaderboard_type_animation = nil
	end

	return 
end
LeaderboardsUI.enabled = function (self)
	return self._enabled
end
LeaderboardsUI._create_ui_elements = function (self)
	self._ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph)
	self._window_widget = UIWidget.init(definitions.widgets.window)
	self._character_selection_bar_widget = UIWidget.init(definitions.character_selection_bar_widget)
	local input_service = Managers.input:get_service(self._input_service_name)
	local gui_layer = definitions.scenegraph.root.position[3]
	self._menu_input_description = MenuInputDescriptionUI:new(nil, self._ui_renderer, input_service, 5, gui_layer, generic_input_actions.default)

	self._menu_input_description:change_generic_actions(generic_input_actions.default)

	self._loading_icon = UIWidget.init(UIWidgets.create_simple_rotated_texture("matchmaking_connecting_icon", 0, {
		25,
		25
	}, "loading_icon"))

	UIRenderer.clear_scenegraph_queue(self._ui_renderer)
	self.select_button_index(self, self._profile_index)

	local level_key = Managers.state.game_mode:level_key()
	local display_name = LevelSettings[level_key].display_name
	self._window_widget.content.leaderboard_header = display_name

	return 
end
LeaderboardsUI._create_entries = function (self, leaderboard_data)
	self._has_entries = nil
	self._current_index = 1
	self._base_offset = {
		0,
		0,
		1
	}
	self._entries = {}
	self._updating_leaderboard = false

	if PLATFORM == "win32" then
		if leaderboard_data and 0 < leaderboard_data.entry_count then
			for idx, entry in ipairs(leaderboard_data.scores) do
				local time_in_sec = entry.data[7] or math.random(86400)
				local time = string.format("%.2d:%.2d:%.2d", time_in_sec/3600, (time_in_sec/60)%60, time_in_sec%60)
				entry.data[7] = time
				self._entries[#self._entries + 1] = definitions.create_entry(entry.name, entry.global_rank, entry.score, entry.data, "entry_root", self._base_offset, idx)
			end

			self._entries[self._current_index].content.highlight_enabled = true
			self._has_entries = true
		else
			self._entries[#self._entries + 1] = definitions.create_empty_entry()
		end
	elseif PLATFORM == "xb1" then
		if leaderboard_data and leaderboard_data.error then
			self._entries[#self._entries + 1] = definitions.create_empty_entry()
		elseif leaderboard_data and 0 < leaderboard_data.num_rows then
			local my_xuid = Managers.account:xbox_user_id()

			for idx, entry in ipairs(leaderboard_data.leaderboard) do
				local xuid = entry.xuid
				local time_in_sec = tonumber(entry.scores[7]) or math.random(86400)
				local time = string.format("%.2d:%.2d:%.2d", time_in_sec/3600, (time_in_sec/60)%60, time_in_sec%60)
				local score_data = {
					entry.scores[6],
					entry.scores[1],
					entry.scores[2],
					entry.scores[3],
					entry.scores[4],
					entry.scores[5],
					time
				}
				self._entries[#self._entries + 1] = definitions.create_entry(entry.name, entry.rank, entry.total_score, score_data, "entry_root", self._base_offset, #self._entries + 1, xuid, my_xuid)
			end

			self._entries[self._current_index].content.highlight_enabled = true
			self._has_entries = true
		else
			self._entries[#self._entries + 1] = definitions.create_empty_entry()
		end
	end

	return 
end
LeaderboardsUI._rotate_loading_icon = function (self, dt)
	local loading_icon_style = self._loading_icon.style.texture_id
	local angle_fraction = loading_icon_style.fraction or 0
	angle_fraction = (angle_fraction + dt)%1
	local angle = angle_fraction*math.degrees_to_radians(360)
	loading_icon_style.angle = angle
	loading_icon_style.fraction = angle_fraction

	return 
end
local DO_RELOAD = true
LeaderboardsUI.update = function (self, dt)
	if DO_RELOAD then
		self._create_ui_elements(self)

		if self._current_leaderboard then
			if PLATFORM == "win32" then
				self._updating_leaderboard = true

				Managers.leaderboards:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 1, 20)
			elseif PLATFORM == "xb1" then
				self._updating_leaderboard = true

				Managers.account:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 20, nil, LeaderboardSettings.template)
			end
		end

		DO_RELOAD = false
	end

	if self._open then
		self._handle_input(self, dt)
		self._update_list_scroll(self, dt)
	end

	local open_animation = self._open_window_animation

	if open_animation then
		UIAnimation.update(open_animation, dt)

		if UIAnimation.completed(open_animation) then
			self._open_window_animation = nil

			self.on_open_complete(self)
		end
	else
		local close_animation = self._close_window_animation

		if close_animation then
			UIAnimation.update(close_animation, dt)

			if UIAnimation.completed(close_animation) then
				self._close_window_animation = nil

				self.on_close_complete(self)
			end
		end
	end

	self._update_leaderboard_animation(self, dt)

	if #self._entries == 0 then
		self._rotate_loading_icon(self, dt)
	end

	return 
end
LeaderboardsUI._update_list_scroll = function (self, dt)
	local num_entries = #self._entries

	if 15 < #self._entries then
		local length = num_entries*definitions.entry_size[2]
		local area_length = definitions.entry_area[2]
		local diff = length - area_length
		local step = diff/num_entries
		local target_pos = (1 < self._current_index and step*self._current_index) or 0
		local current_pos = self._ui_scenegraph.entry_root.local_position[2]
		self._ui_scenegraph.entry_root.local_position = {
			0,
			current_pos + (target_pos - current_pos)*dt*15,
			0
		}
	end

	return 
end
LeaderboardsUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self._wwise_world, event)

	return 
end
LeaderboardsUI._handle_input = function (self, dt)
	if self._updating_leaderboard then
		self._menu_input_description:enable_button(1, false)
		self._menu_input_description:enable_button(2, false)
	else
		self._menu_input_description:enable_button(1, true)
		self._menu_input_description:enable_button(2, true)
	end

	local gamepad_active = Managers.input:is_device_active("gamepad")
	local has_entries = self._has_entries
	local input_service = Managers.input:get_service(self._input_service_name)
	self._current_index = self._current_index or 1
	local controller_cooldown = (gamepad_active and self._controller_cooldown) or 0

	if controller_cooldown and 0 < controller_cooldown then
		self._controller_cooldown = controller_cooldown - dt
	elseif has_entries and input_service.get(input_service, "move_down_hold") then
		if self._entries[self._current_index] and self._entries[self._current_index].content then
			self._entries[self._current_index].content.highlight_enabled = nil
		end

		self._current_index = math.clamp(self._current_index + 1, 1, #self._entries)

		if self._entries[self._current_index] and self._entries[self._current_index].content then
			self._entries[self._current_index].content.highlight_enabled = true
		end

		self._controller_cooldown = GamepadSettings.menu_cooldown

		self.play_sound(self, "Play_hud_select")
	elseif has_entries and input_service.get(input_service, "move_up_hold") then
		if self._entries[self._current_index] and self._entries[self._current_index].content then
			self._entries[self._current_index].content.highlight_enabled = nil
		end

		self._current_index = math.clamp(self._current_index - 1, 1, #self._entries)

		if self._entries[self._current_index] and self._entries[self._current_index].content then
			self._entries[self._current_index].content.highlight_enabled = true
		end

		self._controller_cooldown = GamepadSettings.menu_cooldown

		self.play_sound(self, "Play_hud_select")
	end

	if has_entries and input_service.get(input_service, "confirm") then
		if PLATFORM == "xb1" and self._entries[self._current_index] and self._entries[self._current_index].content then
			local xuid = self._entries[self._current_index].content.id

			if xuid then
				self.play_sound(self, "Play_hud_select")
				XboxLive.show_gamercard(Managers.account:user_id(), xuid)
			end
		end
	elseif not self._updating_leaderboard and input_service.get(input_service, "cycle_next") then
		local num_characters = #LeaderboardSettings.characters
		self._profile_index = math.clamp(self._profile_index + 1, 1, num_characters)
		local profile_name = LeaderboardSettings.characters[self._profile_index]
		local current_leaderboard = self._level_key .. "_" .. profile_name

		if self._current_leaderboard ~= current_leaderboard then
			debug_print(current_leaderboard)

			self._entries = {}

			self.select_button_index(self, self._profile_index)

			self._current_leaderboard = current_leaderboard
			self._controller_cooldown = GamepadSettings.menu_cooldown

			self.play_sound(self, "Play_hud_select")

			if PLATFORM == "win32" then
				self._updating_leaderboard = true

				Managers.leaderboards:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 1, 20)
			elseif PLATFORM == "xb1" then
				self._updating_leaderboard = true

				Managers.account:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 20, nil, LeaderboardSettings.template)
			end
		end
	elseif not self._updating_leaderboard and input_service.get(input_service, "cycle_previous") then
		local num_characters = #LeaderboardSettings.characters
		self._profile_index = math.clamp(self._profile_index - 1, 1, num_characters)
		local profile_name = LeaderboardSettings.characters[self._profile_index]
		local current_leaderboard = self._level_key .. "_" .. profile_name

		if self._current_leaderboard ~= current_leaderboard then
			debug_print(current_leaderboard)

			self._entries = {}

			self.select_button_index(self, self._profile_index)

			self._current_leaderboard = current_leaderboard
			self._controller_cooldown = GamepadSettings.menu_cooldown

			self.play_sound(self, "Play_hud_select")

			self._updating_leaderboard = true

			if PLATFORM == "win32" then
				Managers.leaderboards:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 1, 20)
			elseif PLATFORM == "xb1" then
				Managers.account:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 20, nil, LeaderboardSettings.template)
			end
		end
	elseif not self._updating_leaderboard and input_service.get(input_service, "special_1") then
		self.play_sound(self, "Play_hud_select")

		self._entries = {}
		self._current_leaderboard_type = self._current_leaderboard_type%#self._leaderboard_types + 1

		self._add_leaderboard_type_animation(self)

		self._updating_leaderboard = true

		if PLATFORM == "win32" then
			Managers.leaderboards:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 1, 20)
		elseif PLATFORM == "xb1" then
			Managers.account:get_leaderboard(self._current_leaderboard, self._leaderboard_types[self._current_leaderboard_type], callback(self, "_create_entries"), 20, nil, LeaderboardSettings.template)
		end
	end

	return 
end
LeaderboardsUI.select_button_index = function (self, index)
	local widget_style = self._character_selection_bar_widget.style

	for i = 1, 5, 1 do
		local button_hotspot_name = i
		local tooltip_text = "tooltip_text_" .. i
		local button_style_name = string.format("button_style_%d", i)
		local button_disabled_style_name = string.format("button_disabled_style_%d", i)
		local button_click_style_name = string.format("button_click_style_%d", i)
		local icon_texture_id = string.format("icon_%d", i)
		local icon_click_texture_id = string.format("icon_click_%d", i)
		local button_click_style = widget_style[button_click_style_name]
		local icon_texture_id_style = widget_style[icon_texture_id]

		if i == index then
			button_click_style.color[1] = 255
			icon_texture_id_style.color[1] = 255
		else
			button_click_style.color[1] = 0
			icon_texture_id_style.color[1] = 178.5
		end
	end

	return 
end
LeaderboardsUI.draw = function (self, dt)
	local ui_renderer = self._ui_renderer
	local ui_scenegraph = self._ui_scenegraph
	local input_manager = Managers.input
	local input_service = input_manager.get_service(input_manager, self._input_service_name)
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self._window_widget)
	UIRenderer.draw_widget(ui_renderer, self._character_selection_bar_widget)

	if #self._entries == 0 then
		UIRenderer.draw_widget(ui_renderer, self._loading_icon)
	end

	for _, entry in pairs(self._entries) do
		UIRenderer.draw_widget(ui_renderer, entry)
	end

	UIRenderer.end_pass(ui_renderer)

	if self._open and Managers.input:is_device_active("gamepad") then
		self._menu_input_description:draw(self._ui_renderer, dt)
	end

	return 
end
LeaderboardsUI.destroy = function (self)
	return 
end

return 
