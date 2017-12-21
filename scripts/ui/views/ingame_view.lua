require("scripts/ui/views/ingame_view_definitions")
require("scripts/ui/views/menu_input_description_ui")

local generic_input_actions = {
	{
		input_action = "d_vertical",
		priority = 1,
		description_text = "input_description_navigate",
		ignore_keybinding = true
	},
	{
		input_action = "confirm",
		priority = 2,
		description_text = "input_description_open"
	},
	{
		input_action = "back",
		priority = 3,
		description_text = "input_description_close"
	}
}
local menu_layouts = {}

if Application.platform() == "xb1" or Application.platform() == "ps4" then
	menu_layouts = {
		in_menu = {
			alone = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "profile_view",
					display_name = "profile_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			},
			host = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "profile_view",
					display_name = "profile_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "disband_party_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			},
			client = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "profile_view",
					display_name = "profile_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "leave_party_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			}
		},
		in_game = {
			alone = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "leave_game_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			},
			host = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "disband_party_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			},
			client = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "leave_party_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			}
		}
	}
else
	menu_layouts = {
		in_menu = {
			alone = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "profile_view",
					display_name = "profile_menu_button_name"
				},
				{
					fade = true,
					transition = "lobby_browser_view",
					display_name = "lobby_browser_button_name "
				},
				{
					fade = true,
					transition = "options_menu",
					display_name = "options_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			},
			host = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "profile_view",
					display_name = "profile_menu_button_name"
				},
				{
					fade = true,
					transition = "lobby_browser_view",
					display_name = "lobby_browser_button_name "
				},
				{
					fade = true,
					transition = "options_menu",
					display_name = "options_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "disband_party_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			},
			client = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "profile_view",
					display_name = "profile_menu_button_name"
				},
				{
					fade = true,
					transition = "lobby_browser_view",
					display_name = "lobby_browser_button_name "
				},
				{
					fade = true,
					transition = "options_menu",
					display_name = "options_menu_button_name"
				},
				{
					fade = true,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "leave_party_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			}
		},
		in_game = {
			alone = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "options_menu",
					display_name = "options_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "leave_game_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			},
			host = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "options_menu",
					display_name = "options_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "disband_party_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			},
			client = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "options_menu",
					display_name = "options_menu_button_name"
				},
				{
					fade = false,
					transition = "credits_menu",
					display_name = "credits_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "leave_party_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			}
		}
	}
end

IngameView = class(IngameView)
IngameView.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.menu_active = false
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.network_lobby = ingame_ui_context.network_lobby
	local is_in_inn = ingame_ui_context.is_in_inn
	self.is_server = ingame_ui_context.is_server
	self.layout_list = (is_in_inn and menu_layouts.in_menu) or menu_layouts.in_game
	self.menu_definition = IngameViewDefinitions

	self.create_ui_elements(self)

	self.ui_animations = {}
	self.controller_grid_index = {
		x = 1,
		y = 1
	}
	self.controller_cooldown = 0
	local input_service = self.input_manager:get_service("ingame_menu")
	local number_of_actvie_descriptions = 3
	local world = Managers.world:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	local gui_layer = self.menu_definition.scenegraph_definition.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, number_of_actvie_descriptions, gui_layer, generic_input_actions)

	self.menu_input_description:set_input_description(nil)

	return 
end
local MENU_ANIMATION_TIME = 0.3
IngameView.on_enter = function (self, menu_to_enter)
	assert(menu_to_enter ~= "MainMenu")

	local had_menu = self.active_menu
	self.active_menu = menu_to_enter
	self.controller_cooldown = 0.2

	self.update_menu_options(self)

	return 
end
IngameView.create_ui_elements = function (self)
	local widgets = self.menu_definition.widgets
	self.stored_buttons = {
		UIWidget.init(widgets.button_1),
		UIWidget.init(widgets.button_2),
		UIWidget.init(widgets.button_3),
		UIWidget.init(widgets.button_4),
		UIWidget.init(widgets.button_5),
		UIWidget.init(widgets.button_6),
		UIWidget.init(widgets.button_7),
		UIWidget.init(widgets.button_8),
		UIWidget.init(widgets.button_9)
	}
	self.background_top_widget = UIWidget.init(widgets.background_top_widget)
	self.background_bottom_widget = UIWidget.init(widgets.background_bottom_widget)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(self.menu_definition.scenegraph_definition)

	return 
end
IngameView.update_menu_options = function (self)
	if script_data.pause_menu_full_access then
		if not self.pause_menu_full_access then
			self.pause_menu_full_access = true
			local full_access_layout = {
				{
					fade = false,
					transition = "exit_menu",
					display_name = "return_to_game_button_name"
				},
				{
					fade = true,
					transition = "profile_view",
					display_name = "profile_menu_button_name"
				},
				{
					fade = true,
					transition = "inventory_view",
					display_name = "inventory_menu_button_name"
				},
				{
					fade = true,
					transition = "forge_view",
					display_name = "interact_open_forge"
				},
				{
					fade = false,
					transition = "friends_view",
					display_name = "friends_menu_button_name"
				},
				{
					fade = true,
					transition = "altar_view",
					display_name = "altar_view"
				},
				{
					fade = true,
					transition = "options_menu",
					display_name = "options_menu_button_name"
				},
				{
					fade = false,
					transition = "leave_group",
					display_name = "leave_game_menu_button_name"
				},
				{
					fade = false,
					transition = "quit_game",
					display_name = "quit_menu_button_name"
				}
			}
			local backend_settings = GameSettingsDevelopment.backend_settings

			if backend_settings.quests_enabled then
				full_access_layout[6] = {
					transition = "quest_view",
					display_name = "quest_view"
				}
			end

			self.setup_button_layout(self, full_access_layout)
		end
	else
		self.pause_menu_full_access = nil
		local num_human_players = Managers.player:num_human_players()

		if self.num_players ~= num_human_players then
			self.num_players = num_human_players
			local layout_list = self.layout_list
			local new_menu_layout = nil

			if num_human_players == 1 then
				new_menu_layout = layout_list.alone
			elseif self.is_server then
				new_menu_layout = layout_list.host
			else
				new_menu_layout = layout_list.client
			end

			self.setup_button_layout(self, new_menu_layout)
		end
	end

	return 
end
IngameView.update_menu_options_enabled_states = function (self)
	local active_button_data = self.active_button_data

	if active_button_data then
		local player_ready_for_game = self.ingame_ui:is_local_player_ready_for_game()

		for index, menu_option in ipairs(active_button_data) do
			local transition = menu_option.transition

			if transition == "profile_view" or transition == "forge_view" or transition == "inventory_view" then
				local widget = menu_option.widget
				local widget_button_hotspot = widget.content.button_hotspot

				if player_ready_for_game and not widget_button_hotspot.disabled then
					widget_button_hotspot.disabled = true
					widget_button_hotspot.on_release = nil
				elseif not player_ready_for_game and widget_button_hotspot.disabled then
					widget_button_hotspot.disabled = false
				end
			end
		end
	end

	return 
end
IngameView.setup_button_layout = function (self, layout_data)
	local active_button_data = self.active_button_data

	if active_button_data then
		table.clear(active_button_data)
	else
		self.active_button_data = {}
		active_button_data = self.active_button_data
	end

	local stored_buttons = self.stored_buttons

	for index, data in ipairs(layout_data) do
		local button_widget = stored_buttons[index]
		local display_name = data.display_name
		local transition = data.transition
		local fade = data.fade
		button_widget.content.text_field = display_name
		active_button_data[index] = {
			widget = button_widget,
			transition = transition,
			fade = fade
		}
	end

	self.set_background_height(self, #active_button_data)

	return 
end
IngameView.destroy = function (self)
	self.menu_input_description:destroy()

	self.menu_input_description = nil

	return 
end
IngameView.set_background_height = function (self, num_buttons)
	local background_bottom_definition = self.menu_definition.scenegraph_definition.background_bottom
	local background_bottom_default_size = background_bottom_definition.size
	local min = 250
	local max = min + 630
	local dead_area = 50
	local button_height = 84
	local total_button_height = num_buttons*button_height
	local background_height = math.max(math.min(total_button_height, max), min)
	local background_fraction = (dead_area + background_height)/background_bottom_default_size[2]
	self.ui_scenegraph.background_bottom.size[2] = background_bottom_default_size[2]*background_fraction
	self.background_bottom_widget.content.texture_id.uvs[1][2] = background_fraction - 1

	return 
end
IngameView.update = function (self, dt)
	self.update_menu_options(self)
	self.update_menu_options_enabled_states(self)

	if self._reinit_menu_input_description_next_update then
		self._reinit_menu_input_description_next_update = nil

		self.menu_input_description:set_input_description(generic_input_actions)
	end

	local ui_renderer = self.ui_renderer
	local input_manager = self.input_manager
	local input_service = input_manager.get_service(input_manager, "ingame_menu")
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
	local ui_animations = self.ui_animations

	for name, ui_animation in pairs(ui_animations) do
		UIAnimation.update(ui_animation, dt)
	end

	local ui_scenegraph = self.ui_scenegraph

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.background_top_widget)
	UIRenderer.draw_widget(ui_renderer, self.background_bottom_widget)

	local active_button_data = self.active_button_data
	local ingame_ui = self.ingame_ui

	if active_button_data then
		for index, data in ipairs(active_button_data) do
			local widget = data.widget

			UIRenderer.draw_widget(ui_renderer, widget)

			if widget.content.button_hotspot.on_hover_enter then
				self.play_sound(self, "Play_hud_hover")
			end

			if not ingame_ui.pending_transition(ingame_ui) then
				local mouse_input_approved = widget.content.button_hotspot.on_release
				local gamepad_input_approved = self.controller_cooldown < 0 and self.controller_selection_index == index and input_service.get(input_service, "confirm", true)

				if mouse_input_approved or gamepad_input_approved then
					widget.content.button_hotspot.on_release = nil
					local transition = data.transition
					local fade = data.fade

					self.play_sound(self, "Play_hud_select")

					if fade then
						ingame_ui.transition_with_fade(ingame_ui, transition)
					else
						ingame_ui.handle_transition(ingame_ui, transition)
					end

					self._reinit_menu_input_description_next_update = true
					self.controller_cooldown = GamepadSettings.menu_cooldown
				end
			end
		end
	end

	UIRenderer.end_pass(ui_renderer)

	if gamepad_active then
		self.update_controller_input(self, input_service, dt)

		if not ingame_ui.popup_id then
			self.menu_input_description:draw(ui_renderer, dt)
		end

		if not self.gamepad_active_last_frame then
			self.setup_controller_selection(self)
		end
	elseif self.gamepad_active_last_frame then
		self.clear_controller_selection(self)
	end

	self.gamepad_active_last_frame = gamepad_active

	if (input_service.get(input_service, "toggle_menu", true) or input_service.get(input_service, "back", true)) and not ingame_ui.pending_transition(ingame_ui) then
		ingame_ui.handle_transition(ingame_ui, "exit_menu")
	end

	return 
end
IngameView.setup_controller_selection = function (self)
	local selection_index = 1

	self.controller_select_button_index(self, selection_index, true)

	return 
end
IngameView.controller_select_button_index = function (self, index, ignore_sound)
	local selection_accepted = false
	local active_button_data = self.active_button_data
	local new_selection_data = active_button_data[index]

	if not new_selection_data or new_selection_data.widget.content.button_hotspot.disabled then
		return selection_accepted
	end

	for i, data in ipairs(active_button_data) do
		local widget = data.widget
		widget.content.button_hotspot.is_selected = i == index
	end

	if not ignore_sound and index ~= self.controller_selection_index then
		self.play_sound(self, "Play_hud_hover")
	end

	self.controller_selection_index = index
	selection_accepted = true

	return selection_accepted
end
IngameView.clear_controller_selection = function (self)
	local active_button_data = self.active_button_data

	for i, data in ipairs(active_button_data) do
		local widget = data.widget
		widget.content.button_hotspot.is_selected = false
	end

	return 
end
IngameView.update_controller_input = function (self, input_service, dt)
	local num_buttons = #self.active_button_data

	if 0 < self.controller_cooldown then
		self.controller_cooldown = self.controller_cooldown - dt
	else
		local move_up = input_service.get(input_service, "move_up")
		local move_up_hold = input_service.get(input_service, "move_up_hold")
		local controller_selection_index = self.controller_selection_index

		if move_up or move_up_hold then
			local new_index = math.max(controller_selection_index - 1, 1)
			local selection_accepted = self.controller_select_button_index(self, new_index)

			while not selection_accepted do
				new_index = math.max(new_index - 1, 1)
				selection_accepted = self.controller_select_button_index(self, new_index)
			end

			self.controller_cooldown = GamepadSettings.menu_cooldown
		else
			local move_down = input_service.get(input_service, "move_down")
			local move_down_hold = input_service.get(input_service, "move_down_hold")

			if move_down or move_down_hold then
				local new_index = math.min(controller_selection_index + 1, num_buttons)
				local selection_accepted = self.controller_select_button_index(self, new_index)

				while not selection_accepted do
					new_index = math.min(new_index + 1, num_buttons)
					selection_accepted = self.controller_select_button_index(self, new_index)
				end

				self.controller_cooldown = GamepadSettings.menu_cooldown
			end
		end
	end

	return 
end
IngameView.get_transition = function (self)
	if self.leave_game then
		return "leave_game"
	end

	return 
end
IngameView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end

return 