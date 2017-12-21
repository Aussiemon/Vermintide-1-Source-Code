local definitions = local_require("scripts/ui/views/positive_reinforcement_ui_definitions")
local event_settings = local_require("scripts/ui/views/positive_reinforcement_ui_event_settings")
local event_colors = {
	fade_to = Colors.get_table("white"),
	default = Colors.get_table("cheeseburger"),
	kill = Colors.get_table("red"),
	personal = Colors.get_table("dodger_blue")
}
PositiveReinforcementUI = class(PositiveReinforcementUI)
PositiveReinforcementUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.player_manager = ingame_ui_context.player_manager
	self.peer_id = ingame_ui_context.peer_id
	self.world = ingame_ui_context.world_manager:world("level_world")

	self.create_ui_elements(self)

	self._positive_enforcement_events = {}
	self._hash_order = {}
	self._hash_widget_lookup = {}
	self._animations = {}

	Managers.state.event:register(self, "add_coop_feedback", "event_add_positive_enforcement")
	Managers.state.event:register(self, "add_coop_feedback_kill", "event_add_positive_enforcement_kill")
	Managers.state.event:register(self, "add_personal_feedback", "event_add_lorebook_page_pickup")
	Managers.state.event:register(self, "add_personal_interaction_warning", "event_add_interaction_warning")

	return 
end
PositiveReinforcementUI.destroy = function (self)
	GarbageLeakDetector.register_object(self, "positive_reinforcement_ui")

	return 
end
PositiveReinforcementUI.create_ui_elements = function (self)
	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.message_widgets = {
		UIWidget.init(definitions.animated_message_widget)
	}

	for _, widget in pairs(definitions.message_widgets) do
		self.message_widgets[#self.message_widgets + 1] = UIWidget.init(widget)
	end

	self.pulsing_widget = self.message_widgets[1]

	return 
end
local buff_params = {}
script_data.debug_legendary_traits = script_data.debug_legendary_traits or Development.parameter("debug_legendary_traits")

local function trigger_assist_buffs(savior_unit, saved_unit)
	local status_ext = ScriptUnit.extension(saved_unit, "status_system")
	local is_knocked_down = status_ext.is_knocked_down(status_ext)

	if is_knocked_down then
		local buff_ext = ScriptUnit.extension(savior_unit, "buff_system")
		local heal_amount, procced = buff_ext.apply_buffs_to_value(buff_ext, 0, StatBuffIndex.HEALING_KNOCKED_DOWN_PLAYER_BY_ASSIST)
		local heal_type = "proc"

		if script_data.debug_legendary_traits then
			heal_amount = 10
			procced = true
		end

		if procced then
			if Managers.player.is_server or LEVEL_EDITOR_TEST then
				DamageUtils.heal_network(saved_unit, savior_unit, heal_amount, heal_type)
			else
				local network_manager = Managers.state.network
				local network_transmit = network_manager.network_transmit
				local owner_unit_id = network_manager.unit_game_object_id(network_manager, saved_unit)
				local heal_type_id = NetworkLookup.heal_types[heal_type]

				network_transmit.send_rpc_server(network_transmit, "rpc_request_heal", owner_unit_id, heal_amount, heal_type_id)
			end
		end
	end

	local buff_ext = ScriptUnit.extension(savior_unit, "buff_system")
	local saved_unit_damage_ext = ScriptUnit.extension(saved_unit, "damage_system")
	local shield_amount, procced = buff_ext.apply_buffs_to_value(buff_ext, 0, StatBuffIndex.SHIELDING_PLAYER_BY_ASSIST)

	if script_data.debug_legendary_traits then
		shield_amount = 30
		procced = true
	end

	if procced and not saved_unit_damage_ext.has_assist_shield(saved_unit_damage_ext) then
		if Managers.player.is_server then
			DamageUtils.assist_shield_network(saved_unit, savior_unit, shield_amount)
		else
			local network_manager = Managers.state.network
			local network_transmit = network_manager.network_transmit
			local owner_unit_id = network_manager.unit_game_object_id(network_manager, saved_unit)

			network_transmit.send_rpc_server(network_transmit, "rpc_request_heal", owner_unit_id, shield_amount, NetworkLookup.heal_types.shield_by_assist)
		end
	end

	return 
end

PositiveReinforcementUI.add_event = function (self, hash, local_player, color_from, event_type, ...)
	if not script_data.disable_reinforcement_ui then
		local events = self._positive_enforcement_events
		local full_hash = hash .. event_type
		local hash_order = self._hash_order
		local t = Managers.time:time("game")
		local increment_duration = UISettings.positive_reinforcement.increment_duration
		local existing_event = events[full_hash]

		if not existing_event then
			existing_event = {
				text = "",
				shown_amount = 0,
				amount = 0,
				event_type = event_type,
				next_increment = t - increment_duration,
				remove_time = math.huge,
				local_player = local_player,
				data = {
					...
				}
			}
			events[full_hash] = existing_event
		else
			local index = table.find(hash_order, full_hash)

			table.remove(hash_order, index)
			table.remove(self._hash_widget_lookup, index)
		end

		hash_order[#hash_order + 1] = full_hash
		existing_event.amount = existing_event.amount + 1
		existing_event.remove_time = math.huge

		if definitions.MAX_NUMBER_OF_MESSAGES < #hash_order then
			local first_hash = hash_order[1]
			events[first_hash] = nil

			table.remove(hash_order, 1)
			table.remove(self._hash_widget_lookup, 1)
		end

		local widget_index = 0

		table.clear(self._hash_widget_lookup)

		for i = #hash_order, 1, -1 do
			widget_index = widget_index + 1
			local hash = hash_order[i]
			self._hash_widget_lookup[hash] = self.message_widgets[widget_index]
		end

		local widget_text_style = self._hash_widget_lookup[full_hash].style.text
		local widget_icon_style = self._hash_widget_lookup[full_hash].style.icon
		widget_text_style.text_color[1] = 255
		widget_icon_style.color[1] = 255
		local color_to = event_colors.fade_to
		local debug_color_from_1 = color_from[1]
		local debug_color_from_2 = color_from[2]
		local debug_color_from_3 = color_from[3]
		local debug_color_from_4 = color_from[4]
		local debug_color_to_1 = color_to[1]
		local debug_color_to_2 = color_to[2]
		local debug_color_to_3 = color_to[3]
		local debug_color_to_4 = color_to[4]
		local debug_widget_text_color = widget_text_style.text_color
		local debug_widget_text_color_1 = debug_widget_text_color and debug_widget_text_color[1]
		local debug_widget_text_color_2 = debug_widget_text_color and debug_widget_text_color[2]
		local debug_widget_text_color_3 = debug_widget_text_color and debug_widget_text_color[3]
		local debug_widget_text_color_4 = debug_widget_text_color and debug_widget_text_color[4]

		if PLATFORM ~= "win32" then
			self._animations["text_color_fade_1_" .. full_hash] = UIAnimation.init_debug(UIAnimation.linear_scale, widget_text_style.text_color, 2, color_from[2], color_to[2], 0.8)
			self._animations["text_color_fade_2_" .. full_hash] = UIAnimation.init_debug(UIAnimation.linear_scale, widget_text_style.text_color, 3, color_from[3], color_to[3], 0.8)
			self._animations["text_color_fade_3_" .. full_hash] = UIAnimation.init_debug(UIAnimation.linear_scale, widget_text_style.text_color, 4, color_from[4], color_to[4], 0.8)
			self._animations["text_pulse_" .. full_hash] = UIAnimation.init_debug(UIAnimation.linear_scale, widget_text_style, "font_size", 18, 24, 0.2, UIAnimation.linear_scale, widget_text_style, "font_size", 24, 18, 0.3)
			self._animations["icon_pulse_" .. full_hash] = UIAnimation.init_debug(UIAnimation.linear_scale2, widget_icon_style.size, 20, 20, 26, 26, 0.2, UIAnimation.linear_scale2, widget_icon_style.size, 26, 26, 20, 20, 0.3)
			self._animations["icon_move_" .. full_hash] = UIAnimation.init_debug(UIAnimation.linear_scale2, widget_icon_style.offset, -20, -20, -26, -26, 0.2, UIAnimation.linear_scale2, widget_icon_style.offset, -26, -26, -20, -20, 0.3)
		else
			self._animations["text_color_fade_1_" .. full_hash] = UIAnimation.init(UIAnimation.linear_scale, widget_text_style.text_color, 2, color_from[2], color_to[2], 0.8)
			self._animations["text_color_fade_2_" .. full_hash] = UIAnimation.init(UIAnimation.linear_scale, widget_text_style.text_color, 3, color_from[3], color_to[3], 0.8)
			self._animations["text_color_fade_3_" .. full_hash] = UIAnimation.init(UIAnimation.linear_scale, widget_text_style.text_color, 4, color_from[4], color_to[4], 0.8)
			self._animations["text_pulse_" .. full_hash] = UIAnimation.init(UIAnimation.linear_scale, widget_text_style, "font_size", 18, 24, 0.2, UIAnimation.linear_scale, widget_text_style, "font_size", 24, 18, 0.3)
			self._animations["icon_pulse_" .. full_hash] = UIAnimation.init(UIAnimation.linear_scale2, widget_icon_style.size, 20, 20, 26, 26, 0.2, UIAnimation.linear_scale2, widget_icon_style.size, 26, 26, 20, 20, 0.3)
			self._animations["icon_move_" .. full_hash] = UIAnimation.init(UIAnimation.linear_scale2, widget_icon_style.offset, -20, -20, -26, -26, 0.2, UIAnimation.linear_scale2, widget_icon_style.offset, -26, -26, -20, -20, 0.3)
		end
	end

	return 
end
PositiveReinforcementUI.event_add_positive_enforcement = function (self, hash, local_player, event_type, player1, player2)
	local player_1_name = (player1 and player1.name(player1)) or nil
	local player_2_name = (player2 and player2.name(player2)) or nil

	self.add_event(self, hash, local_player, event_colors.default, event_type, player_1_name, player_2_name)

	if event_type == "aid" and local_player then
		local player_one_unit = player1 and player1.player_unit
		local player_two_unit = player2 and player2.player_unit

		if Unit.alive(player_one_unit) and Unit.alive(player_two_unit) then
			trigger_assist_buffs(player_one_unit, player_two_unit)
		end
	end

	return 
end
PositiveReinforcementUI.event_add_positive_enforcement_kill = function (self, hash, local_player, event_type, ...)
	self.add_event(self, hash, local_player, event_colors.kill, event_type, ...)

	return 
end
PositiveReinforcementUI.event_add_lorebook_page_pickup = function (self, hash, local_player, event_type, page_id)
	self.add_event(self, hash, local_player, event_colors.personal, event_type, page_id)

	return 
end
PositiveReinforcementUI.event_add_interaction_warning = function (self, hash, message)
	self.add_event(self, hash, true, event_colors.kill, "interaction_warning", Localize(message))

	return 
end
PositiveReinforcementUI.update = function (self, dt, t)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("Player")

	for name, animation in pairs(self._animations) do
		if self._animations[name] then
			if not UIAnimation.completed(animation) then
				UIAnimation.update(animation, dt)
			else
				self._animations[name] = nil
			end
		end
	end

	local hash_order = self._hash_order

	for i = #hash_order, 1, -1 do
		local full_hash = hash_order[i]
		local event = self._positive_enforcement_events[full_hash]
		local settings = event_settings[event.event_type]

		if event.remove_time < t then
			self._positive_enforcement_events[full_hash] = nil

			table.remove(hash_order, i)
		elseif event.shown_amount < event.amount and event.next_increment < t then
			event.shown_amount = event.shown_amount + 1
			event.next_increment = t + UISettings.positive_reinforcement.increment_duration

			if event.shown_amount == event.amount then
				event.remove_time = t + UISettings.positive_reinforcement.show_duration
			end

			local wwise_world = Managers.world:wwise_world(self.world)
			local sound_event = nil

			if event.local_player then
				sound_event = settings.sound_function()
			end

			if sound_event then
				WwiseWorld.trigger_event(wwise_world, sound_event)
			end

			event.text = settings.text_function(event.shown_amount, unpack(event.data))
			event.icon_texture = settings.icon_function()
		end

		local time_left = event.remove_time - t
		local fade_duration = UISettings.positive_reinforcement.fade_duration
		local alpha = math.clamp(time_left/fade_duration, 0, 1)*255
		self._hash_widget_lookup[full_hash].content.text = event.text
		self._hash_widget_lookup[full_hash].content.icon_texture = event.icon_texture
		self._hash_widget_lookup[full_hash].style.icon.color[1] = alpha
		self._hash_widget_lookup[full_hash].style.text.text_color[1] = alpha
	end

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	for _, widget in pairs(self._hash_widget_lookup) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end

return 
