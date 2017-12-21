-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
require("scripts/settings/difficulty_settings")

local definitions = local_require("scripts/ui/views/matchmaking_ui_definitions")
local widgets = definitions.widgets
local scenegraph_definition = definitions.scenegraph_definition
MatchmakingUI = class(MatchmakingUI)
MatchmakingUI.init = function (self, ingame_ui_context)
	self.level_transition_handler = ingame_ui_context.level_transition_handler
	self.network_event_delegate = ingame_ui_context.network_event_delegate
	self.camera_manager = ingame_ui_context.camera_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.countdown_ui = self.ingame_ui.countdown_ui
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.is_in_inn = ingame_ui_context.is_in_inn
	self.is_server = ingame_ui_context.is_server
	self.matchmaking_manager = Managers.matchmaking
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	rawset(_G, "GLOBAL_MMUI", self)
	self.create_ui_elements(self)

	self.num_players_text = Localize("number_of_players")
	self.max_number_of_players = MatchmakingSettings.MAX_NUMBER_OF_PLAYERS

	self.set_ready_progress(self, 1)
	self.set_cancel_progress(self, 1)

	return 
end
MatchmakingUI.create_ui_elements = function (self)
	self.current_player_count = 0
	self.ui_animations = {}
	self.large_window_widgets = {}

	for name, widget_definition in pairs(widgets.large_window) do
		self.large_window_widgets[name] = UIWidget.init(widget_definition)
	end

	self.status_box_widget = UIWidget.init(widgets.status_box)
	self.debug_box_widget = UIWidget.init(widgets.debug_box)
	self.debug_lobbies_widget = UIWidget.init(widgets.debug_lobbies)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self.large_window_ready_enable(self, false)
	self.set_action_area_visible(self, false)

	self.large_window_widgets.timer.content.visible = false
	self._input_to_widget_mapping = {
		matchmaking_ready = {
			text_widget = self.large_window_widgets.ready_text,
			text_widget_prefix = self.large_window_widgets.ready_text_prefix,
			text_widget_suffix = self.large_window_widgets.ready_text_suffix,
			input_icon_widget = self.large_window_widgets.ready_input_icon,
			input_icon_widget_bar = self.large_window_widgets.ready_input_icon_bar,
			input_icon_bar_width = self.ui_scenegraph.window_ready_input_icon_bar.size[1]
		},
		matchmaking_start = {
			text_widget = self.large_window_widgets.action_text,
			text_widget_prefix = self.large_window_widgets.action_text_prefix,
			text_widget_suffix = self.large_window_widgets.action_text_suffix,
			input_icon_widget = self.large_window_widgets.action_input_icon,
			input_icon_widget_bar = self.large_window_widgets.action_input_icon_bar,
			input_icon_bar_width = self.ui_scenegraph.window_action_input_icon_bar.size[1]
		},
		cancel_matchmaking = {
			text_widget = self.large_window_widgets.cancel_text,
			text_widget_prefix = self.large_window_widgets.cancel_text_prefix,
			text_widget_suffix = self.large_window_widgets.cancel_text_suffix,
			input_icon_widget = self.large_window_widgets.cancel_input_icon,
			input_icon_widget_bar = self.large_window_widgets.cancel_input_icon_bar,
			input_icon_bar_width = self.ui_scenegraph.window_cancel_input_icon_bar.size[1]
		}
	}
	self.large_window_widgets.cancel_button_bg.content.texture_id.uvs[1][1] = 1
	self.ui_scenegraph.window_cancel_bg.size[1] = 0
	self.large_window_widgets.ready_button_bg.content.texture_id.uvs[1][1] = 1
	self.ui_scenegraph.window_ready_bg.size[1] = 0

	return 
end
MatchmakingUI.is_enter_game = function (self)
	return self.countdown_ui:is_enter_game()
end
MatchmakingUI.is_in_inn = function (self)
	return self.is_in_inn
end
MatchmakingUI.update = function (self, dt)
	local countdown_ui = self.countdown_ui
	local ui_renderer = self.ui_renderer
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "ingame_menu")
	local is_matchmaking = self.matchmaking_manager:is_game_matchmaking() and self.is_in_inn
	local enter_game = self.countdown_ui:is_enter_game()
	local ui_suspended = self.ingame_ui.menu_suspended

	if script_data.debug_lobbies then
		self.update_debug_lobbies(self)
		self.draw_debug_lobbies(self, ui_renderer, input_service, dt)
	end

	if ui_suspended and not enter_game then
		return 
	end

	for name, animation in pairs(self.ui_animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			animation = nil
		end
	end

	if is_matchmaking then
		self.update_status(self, dt)
		self.update_button_prompts(self)
	elseif self.current_player_count ~= 0 then
		for i = 1, self.current_player_count, 1 do
			self.on_player_left(self, i)
		end

		self.current_player_count = 0
	end

	if not enter_game and is_matchmaking then
		self.draw(self, ui_renderer, input_service, is_matchmaking, dt)
	end

	return 
end
MatchmakingUI.set_minimize = function (self, set)
	if self.minimize == set then
		return 
	end

	self.minimize = set

	self.animate_large_window(self, self.minimize)

	return 
end
MatchmakingUI.animate_large_window = function (self, minimize)
	local widgets = self.large_window_widgets
	widgets.action_button_bg.style.texture_id.masked = true
	widgets.action_button_fg.style.texture_id.masked = true
	local local_position = self.ui_scenegraph.large_window.local_position
	local default_position = scenegraph_definition.large_window.position
	local ui_animations = self.ui_animations
	local animation_name = "minimize"
	local to_position_y = (minimize and default_position[2] + 200) or default_position[2]
	local default_time = 0.5
	local anim_func = (minimize and math.easeOutCubic) or math.easeInCubic
	local time_to_animate = (default_time*math.abs(local_position[2] - to_position_y))/100

	if 0 < time_to_animate then
		ui_animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, local_position, 2, local_position[2], to_position_y, time_to_animate, math.easeCubic)
	end

	return 
end
MatchmakingUI.draw = function (self, ui_renderer, input_service, is_matchmaking, dt)
	UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt, nil, self.render_settings)

	if is_matchmaking then
		if not self.minimize and not self.matchmaking_manager:is_join_popup_visible() then
			for widget_name, widget in pairs(self.large_window_widgets) do
				if widget_name == "ready_button_glow" and not self.input_manager:is_device_active("gamepad") then
				else
					UIRenderer.draw_widget(ui_renderer, widget)
				end
			end
		else
			UIRenderer.draw_widget(ui_renderer, self.status_box_widget)
		end
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
MatchmakingUI.draw_debug_lobbies = function (self, ui_renderer, input_service, dt)
	UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.debug_lobbies_widget)
	UIRenderer.end_pass(ui_renderer)

	return 
end
MatchmakingUI.update_status = function (self, dt)
	local current_player_count = self.current_player_count
	local active_lobby = Managers.matchmaking:active_lobby()

	if not active_lobby then
		for i = 1, current_player_count, 1 do
			self.on_player_left(self, i)
		end

		self.current_player_count = 0

		return 
	end

	local num_players = active_lobby.lobby_data(active_lobby, "num_players")

	if not num_players then
		return 
	end

	local is_server = self.is_server
	local widget = self.status_box_widget
	local widget_content = widget.content
	local widget_style = widget.style
	local number_of_players = tonumber(num_players)

	if current_player_count ~= number_of_players then
		if current_player_count < number_of_players then
			for i = current_player_count + 1, number_of_players, 1 do
				self.on_player_joined(self, i)
			end
		else
			for i = number_of_players + 1, current_player_count, 1 do
				self.on_player_left(self, i)
			end
		end

		self.current_player_count = number_of_players
	end

	local rotation_speed = 80
	local rotation_angle = (dt*rotation_speed)%360
	local radians = math.degrees_to_radians(rotation_angle)
	widget_style.loader_part_2.angle = widget_style.loader_part_2.angle + radians
	widget_style.loader_part_1.angle = widget_style.loader_part_1.angle - radians
	local large_window_widgets = self.large_window_widgets
	local loader_icon = large_window_widgets.loader_icon
	loader_icon.style.loader_part_2.angle = loader_icon.style.loader_part_2.angle + radians
	loader_icon.style.loader_part_1.angle = loader_icon.style.loader_part_1.angle - radians
	local connecting_rotation_speed = 200
	local connecting_rotation_angle = (dt*connecting_rotation_speed)%360
	local connecting_radians = math.degrees_to_radians(connecting_rotation_angle)

	for i = 1, 4, 1 do
		local portrait_id = "player_portrait_" .. i
		local portrait_widget = large_window_widgets[portrait_id]
		local is_connecting = portrait_widget.content.is_connecting
		local connecting_icon_style = portrait_widget.style.connecting_icon
		connecting_icon_style.angle = (is_connecting and connecting_icon_style.angle + connecting_radians) or 0
	end

	return 
end
MatchmakingUI.update_button_prompts = function (self)
	local ui_scenegraph = self.ui_scenegraph

	for input_action, widgets in pairs(self._input_to_widget_mapping) do
		local text_widget = widgets.text_widget
		local text_widget_prefix = widgets.text_widget_prefix
		local text_widget_suffix = widgets.text_widget_suffix
		local input_icon_widget = widgets.input_icon_widget
		local input_icon_widget_bar = widgets.input_icon_widget_bar
		local input_icon_bar_width = widgets.input_icon_bar_width
		local texture_data, input_text, prefix_text = self.get_input_texture_data(self, input_action)
		text_widget_prefix.content.text = (prefix_text and Localize(prefix_text)) or ""

		if not texture_data then
			text_widget.content.text = input_text
			input_icon_widget.content.texture_id = nil
		elseif texture_data.texture then
			text_widget.content.text = ""
			input_icon_widget.content.texture_id = texture_data.texture
		end

		local text_input = text_widget.content.text
		local text_prefix = text_widget_prefix.content.text
		local text_suffix = Localize(text_widget_suffix.content.text)
		local font_input, scaled_font_input_size = UIFontByResolution(text_widget.style.text)
		local font_prefix, scaled_font_size_prefix = UIFontByResolution(text_widget_prefix.style.text)
		local font_suffix, scaled_font_size_suffix = UIFontByResolution(text_widget_suffix.style.text)
		local text_width_input = UIRenderer.text_size(self.ui_renderer, text_input, font_input[1], scaled_font_input_size)
		local text_width_prefix = UIRenderer.text_size(self.ui_renderer, text_prefix, font_prefix[1], scaled_font_size_prefix)
		local text_width_suffix = UIRenderer.text_size(self.ui_renderer, text_suffix, font_suffix[1], scaled_font_size_suffix)
		local offset = -text_width_suffix*0.5 + text_width_prefix*0.5

		if not texture_data then
			text_widget.style.text.offset[1] = offset
			text_widget_prefix.style.text.offset[1] = -text_width_prefix*0.5 - text_width_input*0.5 + offset
			text_widget_suffix.style.text.offset[1] = text_width_suffix*0.5 + text_width_input*0.5 + offset
		else
			input_icon_widget.style.texture_id.offset[1] = offset
			input_icon_widget_bar.style.texture_id.offset[1] = offset
			text_widget_prefix.style.text.offset[1] = -text_width_prefix*0.5 - input_icon_bar_width*0.5 + offset
			text_widget_suffix.style.text.offset[1] = text_width_suffix*0.5 + input_icon_bar_width*0.5 + offset
		end
	end

	return 
end
MatchmakingUI.update_debug = function (self)
	local lobby = Managers.matchmaking:active_lobby()

	if not lobby then
		return 
	end

	local debug_text = ""
	debug_text = debug_text .. "\nStatename: " .. (Managers.matchmaking.debug.statename or "-")
	debug_text = debug_text .. "\nState: " .. Managers.matchmaking.debug.state
	debug_text = debug_text .. "\nInfo: " .. Managers.matchmaking.debug.text or "matchmaking debug"
	debug_text = debug_text .. "\n"
	debug_text = debug_text .. "\nDistance: " .. (Managers.matchmaking.debug.distance or "?/" .. MatchmakingSettings.max_distance_filter)
	debug_text = debug_text .. "\nLevel: " .. Managers.matchmaking.debug.level
	debug_text = debug_text .. "\nDifficulty: " .. Managers.matchmaking.debug.difficulty
	debug_text = debug_text .. "\nHero: " .. Managers.matchmaking.debug.hero
	debug_text = debug_text .. "\nProgression: " .. Managers.matchmaking.debug.progression
	debug_text = debug_text .. "\n"
	local witch_hunter_player, wood_elf_player, dwarf_ranger_player, bright_wizard_player, empire_soldier_player = nil
	local profiles_data = self.matchmaking_manager.debug.profiles_data

	if profiles_data then
		witch_hunter_player = profiles_data.player_slot_1 or "available"
		bright_wizard_player = profiles_data.player_slot_2 or "available"
		dwarf_ranger_player = profiles_data.player_slot_3 or "available"
		wood_elf_player = profiles_data.player_slot_4 or "available"
		empire_soldier_player = profiles_data.player_slot_5 or "available"
	else
		witch_hunter_player = lobby.lobby_data(lobby, "player_slot_1") or "available"
		bright_wizard_player = lobby.lobby_data(lobby, "player_slot_2") or "available"
		dwarf_ranger_player = lobby.lobby_data(lobby, "player_slot_3") or "available"
		wood_elf_player = lobby.lobby_data(lobby, "player_slot_4") or "available"
		empire_soldier_player = lobby.lobby_data(lobby, "player_slot_5") or "available"
	end

	if rawget(_G, "Steam") and GameSettingsDevelopment.network_mode == "steam" then
		witch_hunter_player = (witch_hunter_player and witch_hunter_player ~= "available" and Steam.user_name(witch_hunter_player)) or "available"
		bright_wizard_player = (bright_wizard_player and bright_wizard_player ~= "available" and Steam.user_name(bright_wizard_player)) or "available"
		dwarf_ranger_player = (dwarf_ranger_player and dwarf_ranger_player ~= "available" and Steam.user_name(dwarf_ranger_player)) or "available"
		wood_elf_player = (wood_elf_player and wood_elf_player ~= "available" and Steam.user_name(wood_elf_player)) or "available"
		empire_soldier_player = (empire_soldier_player and empire_soldier_player ~= "available" and Steam.user_name(empire_soldier_player)) or "available"
	end

	debug_text = debug_text .. "\nWitch hunter: \t" .. witch_hunter_player
	debug_text = debug_text .. "\nBright wizard: \t" .. bright_wizard_player
	debug_text = debug_text .. "\nDwarf ranger: \t" .. dwarf_ranger_player
	debug_text = debug_text .. "\nWood elf: \t\t" .. wood_elf_player
	debug_text = debug_text .. "\nEmpire Soldier: \t" .. empire_soldier_player
	self.debug_box_widget.content.debug_text = debug_text

	return 
end
MatchmakingUI.update_debug_lobbies = function (self)

	-- decompilation error in this vicinity
	local matchmaking_manager = Managers.matchmaking
	local search_data = matchmaking_manager.state_context.game_search_data
	self.debug_lobbies_widget.content.debug_text = string.lower(debug_text)
	self.debug_lobbies_widget.content.debug_server_text = string.lower(debug_server_text)
	self.debug_lobbies_widget.content.debug_match_text = string.lower(debug_match_text)
	self.debug_lobbies_widget.content.debug_valid_text = string.lower(debug_valid_text)
	self.debug_lobbies_widget.content.debug_broken_text = string.lower(debug_broken_text)
	self.debug_lobbies_widget.content.debug_level_key_text = string.lower(debug_level_key_text)
	self.debug_lobbies_widget.content.debug_selected_level_key_text = string.lower(debug_selected_level_key_text)
	self.debug_lobbies_widget.content.debug_matchmaking_text = string.lower(debug_matchmaking_text)
	self.debug_lobbies_widget.content.debug_difficulty_text = string.lower(debug_difficulty_text)
	self.debug_lobbies_widget.content.debug_num_players_text = debug_num_players_text
	self.debug_lobbies_widget.content.debug_wh_text = debug_wh_text
	self.debug_lobbies_widget.content.debug_we_text = debug_we_text
	self.debug_lobbies_widget.content.debug_dr_text = debug_dr_text
	self.debug_lobbies_widget.content.debug_bw_text = debug_bw_text
	self.debug_lobbies_widget.content.debug_es_text = debug_es_text
	self.debug_lobbies_widget.content.debug_rp_text = debug_rp_text
	self.debug_lobbies_widget.content.debug_host_text = debug_host_text
	self.debug_lobbies_widget.content.debug_lobby_id_text = debug_lobby_id_text
	self.debug_lobbies_widget.content.debug_hash_text = debug_hash_text

	return 
end
MatchmakingUI.on_player_joined = function (self, index)
	local widget = self.status_box_widget
	local ui_animations = self.ui_animations
	local animation_name = "player_slot_" .. index
	local lit_animation_name = "player_slot_" .. index .. "_lit"
	local animation_duration = 0.5
	ui_animations[animation_name] = self.animate_element_by_catmullrom(self, widget.style[animation_name].color, 1, 255, 0.6, 0.6, 1, 1, animation_duration*0.5)
	ui_animations[lit_animation_name] = self.animate_element_by_catmullrom(self, widget.style[lit_animation_name].color, 1, 255, -10, 0, 0, -4, animation_duration)

	return 
end
MatchmakingUI.on_player_left = function (self, index)
	local widget = self.status_box_widget
	local ui_animations = self.ui_animations
	local animation_name = "player_slot_" .. index
	local animation_duration = 0.25
	ui_animations[animation_name] = self.animate_element_by_catmullrom(self, widget.style[animation_name].color, 1, 255, 1, 1, 0.6, 0.6, animation_duration)

	return 
end
MatchmakingUI.animate_element_by_catmullrom = function (self, target, target_index, target_value, p0, p1, p2, p3, time)
	local new_animation = UIAnimation.init(UIAnimation.catmullrom, target, target_index, target_value, p0, p1, p2, p3, time)

	return new_animation
end
MatchmakingUI.destroy = function (self)
	rawset(_G, "GLOBAL_MMUI", nil)

	return 
end
MatchmakingUI.get_input_texture_data = function (self, input_action)
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "ingame_menu")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local platform = PLATFORM

	if platform == "win32" and gamepad_active then
		platform = "xb1"
	end

	local keymap_binding = input_service.get_keymapping(input_service, input_action, platform)
	local device_type = keymap_binding[1]
	local key_index = keymap_binding[2]
	local key_action_type = keymap_binding[3]
	local prefix_text = nil

	if key_action_type == "held" then
		prefix_text = "matchmaking_prefix_hold"
	end

	if device_type == "keyboard" then
		return nil, Keyboard.button_locale_name(key_index), prefix_text
	elseif device_type == "mouse" then
		return nil, Mouse.button_name(key_index), prefix_text
	elseif device_type == "gamepad" then
		local button_name = Pad1.button_name(key_index)
		local button_texture_data = ButtonTextureByName(button_name, platform)

		return button_texture_data, button_name, prefix_text
	end

	return nil, ""
end
MatchmakingUI.large_window_set_countdown_timer = function (self, time)
	local loader_icon = self.large_window_widgets.loader_icon
	loader_icon.content.countdown_timer_ps4 = (time and string.format("%02i", math.floor(time))) or nil

	return 
end
MatchmakingUI.large_window_set_time = function (self, time)
	local widgets = self.large_window_widgets
	local time_text = string.format(" %02d:%02d", math.floor(time/60), time%60)
	widgets.timer.content.text = time_text

	return 
end
MatchmakingUI.large_window_set_title = function (self, title)
	local widgets = self.large_window_widgets
	widgets.title.content.text = title

	return 
end
MatchmakingUI.large_window_set_search_zone_title = function (self, title)
	local widgets = self.large_window_widgets
	widgets.search_zone_title.content.text = title
	local text = (widgets.search_zone_title.style.text.localize and Localize(title)) or title
	local font, scaled_font_size = UIFontByResolution(widgets.search_zone_title.style.text)
	local text_width, _, _ = UIRenderer.text_size(self.ui_renderer, text, font[1], scaled_font_size)
	local icon_width = self.ui_scenegraph.search_zone_icon.size[1]
	widgets.search_zone_title.style.text.offset[1] = icon_width/2
	widgets.search_zone_icon.style.texture_id.offset[1] = -text_width/2

	return 
end
MatchmakingUI.large_window_set_status_message = function (self, message)
	local widgets = self.large_window_widgets
	widgets.status_text.content.text = message

	return 
end
MatchmakingUI.large_window_set_player_portrait = function (self, index, profile_name)
	local portrait = (profile_name and "unit_frame_portrait_" .. profile_name) or nil
	self.large_window_widgets["player_portrait_" .. index].content.portrait = portrait

	return 
end
MatchmakingUI.large_window_set_player_ready_state = function (self, index, is_ready)
	self.large_window_widgets["player_portrait_" .. index].content.is_ready = is_ready

	return 
end
MatchmakingUI.large_window_set_player_connecting = function (self, index, is_connecting)
	self.large_window_widgets["player_portrait_" .. index].content.is_connecting = is_connecting

	return 
end
MatchmakingUI.large_window_set_cancel_button_text = function (self, suffix_text)
	local widgets = self.large_window_widgets
	widgets.cancel_text_suffix.content.text = suffix_text

	return 
end
MatchmakingUI.large_window_set_ready_button_text = function (self, suffix_text)
	local widgets = self.large_window_widgets
	widgets.ready_text_suffix.content.text = suffix_text
	widgets.ready_error_text.content.text = ""

	return 
end
MatchmakingUI.large_window_set_action_button_text = function (self, suffix_text)
	local widgets = self.large_window_widgets
	widgets.action_text_suffix.content.text = suffix_text

	return 
end
MatchmakingUI.set_ready_progress = function (self, progress)
	local widget = self.large_window_widgets.ready_button_bg
	local widget_default_size = scenegraph_definition.window_ready_bg.size
	local uvs = widget.content.texture_id.uvs
	local size = self.ui_scenegraph.window_ready_bg.size
	uvs[2][1] = progress - 1
	size[1] = widget_default_size[1]*progress

	if 0 < progress then
		local widgets = self.large_window_widgets
		local glow_widget = widgets.ready_button_glow
		glow_widget.style.texture_id.color[1] = 75
	else
		local widgets = self.large_window_widgets
		local glow_widget = widgets.ready_button_glow
		glow_widget.style.texture_id.color[1] = 0
	end

	return 
end
MatchmakingUI.set_start_progress = function (self, progress)
	local widget = self.large_window_widgets.action_input_icon_bar
	widget.style.texture_id.gradient_threshold = progress or 0

	return 
end
MatchmakingUI.set_cancel_progress = function (self, progress)
	local widget = self.large_window_widgets.cancel_button_bg
	local widget_default_size = scenegraph_definition.window_cancel_bg.size
	local uvs = widget.content.texture_id.uvs
	local size = self.ui_scenegraph.window_cancel_bg.size
	uvs[1][1] = progress - 1
	size[1] = widget_default_size[1]*progress

	return 
end
MatchmakingUI.large_window_start_ready_pulse = function (self)
	local ui_animations = self.ui_animations
	local animation_name = "ready_pulse"

	if not ui_animations[animation_name] then
		local widgets = self.large_window_widgets
		local widget = widgets.ready_button_bg
		local glow_widget = widgets.ready_button_glow
		local animation_speed = 3
		ui_animations[animation_name] = UIAnimation.init(UIAnimation.pulse_animation, widget.style.texture_id.color, 1, 150, 255, animation_speed)
		ui_animations[animation_name .. "_glow"] = UIAnimation.init(UIAnimation.pulse_animation, glow_widget.style.texture_id.color, 1, 25, 75, animation_speed)
	end

	return 
end
MatchmakingUI.large_window_stop_ready_pulse = function (self)
	local ui_animations = self.ui_animations
	local animation_name = "ready_pulse"
	ui_animations[animation_name] = nil
	ui_animations[animation_name .. "_glow"] = nil
	local widgets = self.large_window_widgets
	local widget = widgets.ready_button_glow
	local glow_widget = widgets.ready_button_glow
	widget.style.texture_id.color[1] = 150
	glow_widget.style.texture_id.color[1] = 0

	return 
end
MatchmakingUI.large_window_ready_enable = function (self, enable)
	local tint_color = (enable and {
		150,
		0,
		255,
		0
	}) or {
		255,
		255,
		255,
		255
	}
	local widgets = self.large_window_widgets
	local widget = widgets.ready_button_bg
	widget.style.texture_id.color = tint_color
	widgets.ready_text_prefix.content.visible = enable
	widgets.ready_text.content.visible = enable
	widgets.ready_text_suffix.content.visible = enable
	widgets.ready_input_icon.content.visible = enable
	widgets.ready_input_icon_bar.content.visible = enable

	return 
end
MatchmakingUI.large_window_cancel_enable = function (self, enable)
	local tint_color = (enable and {
		150,
		0,
		255,
		0
	}) or {
		255,
		255,
		255,
		255
	}
	local widgets = self.large_window_widgets
	local widget = widgets.cancel_button_bg
	widget.style.texture_id.color = tint_color
	widgets.cancel_text_prefix.content.visible = enable
	widgets.cancel_text.content.visible = enable
	widgets.cancel_text_suffix.content.visible = enable
	widgets.cancel_input_icon.content.visible = enable
	widgets.cancel_input_icon_bar.content.visible = enable

	return 
end
MatchmakingUI.large_window_set_level = function (self, level_key, optional_name, optional_image)

	-- decompilation error in this vicinity
	local widgets = self.large_window_widgets
	local display_name, display_image = nil
end
MatchmakingUI.large_window_set_difficulty = function (self, difficulty)
	local difficulty_setting = difficulty and DifficultySettings[difficulty]
	local difficulty_display_name = (difficulty_setting and difficulty_setting.display_name) or "dlc1_2_difficulty_unavailable"
	local widgets = self.large_window_widgets
	widgets.difficulty_description.content.text = difficulty_display_name

	return 
end
MatchmakingUI.set_zone_visible = function (self, visible)
	local widgets = self.large_window_widgets
	widgets.search_zone_icon.content.visible = visible
	widgets.search_zone_title.content.visible = visible
	widgets.search_zone_host_title.content.visible = not visible

	return 
end
MatchmakingUI.set_search_zone_host_title = function (self, text)
	local widgets = self.large_window_widgets
	widgets.search_zone_icon.content.visible = false
	widgets.search_zone_title.content.visible = false
	widgets.search_zone_host_title.content.visible = true
	widgets.search_zone_host_title.content.text = text

	return 
end
MatchmakingUI.set_ready_area_enabled = function (self, enabled, error_message)
	local widgets = self.large_window_widgets
	widgets.ready_text_prefix.content.visible = enabled
	widgets.ready_text.content.visible = enabled
	widgets.ready_text_suffix.content.visible = enabled
	widgets.ready_input_icon.content.visible = enabled
	widgets.ready_error_text.content.visible = not enabled
	widgets.ready_error_text.content.text = (error_message and Localize(error_message)) or ""

	return 
end
MatchmakingUI.set_action_area_visible = function (self, visible, instant_hide)
	local widgets = self.large_window_widgets
	widgets.action_button_bg.style.texture_id.masked = true
	widgets.action_button_fg.style.texture_id.masked = true
	widgets.action_input_icon.style.texture_id.masked = true
	widgets.action_input_icon_bar.style.texture_id.masked = true
	widgets.action_button_bg.content.visible = not instant_hide
	widgets.action_button_fg.content.visible = not instant_hide
	widgets.action_text_suffix.content.visible = not instant_hide
	widgets.action_text_prefix.content.visible = not instant_hide
	widgets.action_text.content.visible = not instant_hide
	widgets.action_input_icon.content.visible = not instant_hide
	widgets.action_input_icon_bar.content.visible = not instant_hide
	local bg_size = self.ui_scenegraph.window_action_area.size
	local fg_size = self.ui_scenegraph.window_action_area_fg.size
	local default_fg_size = scenegraph_definition.window_action_area_fg.size
	local default_bg_size = scenegraph_definition.window_action_area.size
	local local_position = self.ui_scenegraph.window_action_area.local_position
	local default_position = scenegraph_definition.window_action_area.position
	local ui_animations = self.ui_animations
	local animation_name = "action_move"
	local to_color = (visible and 255) or 0
	local to_uv = (not visible or 0) and 1
	local to_bg_size = (visible and default_bg_size[2]) or 0
	local to_fg_size = (visible and default_fg_size[2]) or 0
	local to_position_y = (visible and default_position[2]) or default_position[2] + 100
	local default_time = 0.5
	local anim_func = (visible and math.easeOutCubic) or math.easeInCubic
	local time_to_animate = (default_time*math.abs(local_position[2] - to_position_y))/100

	if 0 < time_to_animate then
		ui_animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, local_position, 2, local_position[2], to_position_y, time_to_animate, math.easeCubic)
	end

	local animation_name = "action_pulse"

	if visible then
		local widgets = self.large_window_widgets
		local widget = widgets.action_button_bg
		local animation_speed = 4
		ui_animations[animation_name] = UIAnimation.init(UIAnimation.pulse_animation, widget.style.texture_id.color, 1, 150, 255, animation_speed)
	else
		ui_animations[animation_name] = nil
	end

	return 
end

return 
