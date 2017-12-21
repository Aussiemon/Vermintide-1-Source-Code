require("scripts/ui/ui_animations")
require("foundation/scripts/util/local_require")
require("scripts/ui/views/profile_world_view")

local definitions = local_require("scripts/ui/views/profile_view_definitions")
local profile_view_definitions = definitions.profile_view
ProfileView = class(ProfileView)
ProfileView.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.player_manager = ingame_ui_context.player_manager
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.ui_animations = {}
	self.is_server = ingame_ui_context.is_server
	self.peer_id = ingame_ui_context.peer_id
	self.local_player_id = ingame_ui_context.local_player_id
	self.parent_world = ingame_ui_context.world_manager:world("level_world")
	local input_manager = ingame_ui_context.input_manager
	self.input_manager = input_manager

	input_manager.create_input_service(input_manager, "profile_menu", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager.map_device_to_service(input_manager, "profile_menu", "keyboard")
	input_manager.map_device_to_service(input_manager, "profile_menu", "mouse")
	input_manager.map_device_to_service(input_manager, "profile_menu", "gamepad")
	rawset(_G, "global_profile_view", self)
	self.create_ui_elements(self)

	self.profile_world_view = ProfileWorldView:new(ingame_ui_context)

	return 
end
ProfileView.input_service = function (self)
	return self.input_manager:get_service("profile_menu")
end
ProfileView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(profile_view_definitions.scenegraph)

	return 
end
ProfileView.on_enter = function (self)
	self.cancel_input_disabled = self.ingame_ui.initial_profile_view
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.deactivate_viewport(world, viewport)
	self.input_manager:block_device_except_service("profile_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("profile_menu", "mouse", 1)
	self.input_manager:block_device_except_service("profile_menu", "gamepad", 1)

	self.t = 0
	local wwise_world = Managers.world:wwise_world(self.parent_world)
	local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, "hud_in_inventory_state_on")

	WwiseWorld.trigger_event(wwise_world, "Play_hud_button_open")

	self.waiting_for_post_update_enter = true
	self.active = true

	return 
end
ProfileView.post_update_on_enter = function (self)
	self.button_widgets = {}

	for widget_name, widget_definition in pairs(profile_view_definitions.widgets.button_widgets) do
		self.button_widgets[widget_name] = UIWidget.init(widget_definition)
	end

	self.character_info_widget = UIWidget.init(profile_view_definitions.widgets.character_info_widget)
	self.dead_space_filler_widget = UIWidget.init(profile_view_definitions.widgets.dead_space_filler_widget)

	assert(self.viewport_widget == nil)

	self.viewport_widget = UIWidget.init(profile_view_definitions.widgets.viewport)
	local input_service = self.input_manager:get_service("profile_menu")

	self.profile_world_view:on_enter(self.viewport_widget, input_service, self.character_info_widget, self.button_widgets, self.cancel_input_disabled)

	self.waiting_for_post_update_enter = nil

	return 
end
ProfileView.on_exit = function (self)
	self.exiting = nil
	self.active = nil
	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)

	if self.ingame_ui.initial_profile_view then
		self.ingame_ui:show_input_helper()
	end

	local wwise_world = Managers.world:wwise_world(self.parent_world)
	local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, "hud_in_inventory_state_off")

	if self.respawn_player_unit then
		if self.server then
			Managers.state.network.network_server:peer_respawn_player(self.peer_id)
		else
			Managers.state.network.network_transmit:send_rpc_server("rpc_client_respawn_player")
		end

		self.respawn_player_unit = nil
	end

	return 
end
ProfileView.post_update_on_exit = function (self)
	if self.viewport_widget ~= nil then
		self.profile_world_view:on_exit()
		UIWidget.destroy(self.ui_renderer, self.viewport_widget)

		self.viewport_widget = nil
	end

	return 
end
ProfileView.exit = function (self, return_to_game)
	local exit_transition = "exit_menu"

	if self.ingame_ui.initial_profile_view then
		exit_transition = "exit_initial_profile_view"

		if not SaveData.first_hero_selection_made then
			SaveData.first_hero_selection_made = true

			Managers.save:auto_save(SaveFileName, SaveData, nil)
		end
	end

	self.ingame_ui:transition_with_fade(exit_transition)

	local wwise_world = Managers.world:wwise_world(self.parent_world)

	WwiseWorld.trigger_event(wwise_world, "Play_hud_button_close")

	self.exiting = true

	return 
end
ProfileView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end

	return 
end
ProfileView.suspend = function (self)
	self.suspended = true

	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)

	local viewport_name = "player_1"
	local world = Managers.world:world("level_world")
	local viewport = ScriptWorld.viewport(world, viewport_name)

	ScriptWorld.activate_viewport(world, viewport)

	local previewer_pass_data = self.viewport_widget.element.pass_data[1]
	local viewport = previewer_pass_data.viewport
	local world = previewer_pass_data.world

	ScriptWorld.deactivate_viewport(world, viewport)

	return 
end
ProfileView.unsuspend = function (self)
	self.input_manager:block_device_except_service("profile_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("profile_menu", "mouse", 1)
	self.input_manager:block_device_except_service("profile_menu", "gamepad", 1)

	if self.viewport_widget then
		local viewport_name = "player_1"
		local world = Managers.world:world("level_world")
		local viewport = ScriptWorld.viewport(world, viewport_name)

		ScriptWorld.deactivate_viewport(world, viewport)

		local previewer_pass_data = self.viewport_widget.element.pass_data[1]
		local viewport = previewer_pass_data.viewport
		local world = previewer_pass_data.world

		ScriptWorld.activate_viewport(world, viewport)
	end

	self.suspended = nil

	return 
end
ProfileView.destroy = function (self)
	if self.viewport_widget ~= nil then
		self.profile_world_view:on_exit()
		UIWidget.destroy(self.ui_renderer, self.viewport_widget)

		self.viewport_widget = nil
	end

	self.profile_world_view:destroy()
	rawset(_G, "global_profile_view", nil)

	return 
end
ProfileView.change_profile = function (self, index)
	local peer_id = self.peer_id
	local player = self.player_manager:player_from_peer_id(peer_id)

	if player.player_unit then
		self.despawning_player_unit = player.player_unit

		player.despawn(player)
	else
		self.profile_synchronizer:request_select_profile(index, self.local_player_id)
	end

	self.pending_profile_request = true
	self.requested_profile_index = index

	return 
end
ProfileView.pending_profile_change = function (self)
	return self.pending_profile_request
end
ProfileView.save_selected_profile = function (self, profile_index)
	local save_manager = Managers.save
	local save_data = SaveData
	SaveData.wanted_profile_index = profile_index

	save_manager.auto_save(save_manager, SaveFileName, SaveData, nil)

	return 
end
ProfileView.update = function (self, dt)
	if self.suspended or self.waiting_for_post_update_enter then
		return 
	end

	if self.button_widgets then
		for name, widget in pairs(self.button_widgets) do
			if widget.content.button_hotspot.on_hover_enter then
				local wwise_world = Managers.world:wwise_world(self.parent_world)

				WwiseWorld.trigger_event(wwise_world, "Play_hud_hover")
			elseif widget.content.button_hotspot.on_release then
				local wwise_world = Managers.world:wwise_world(self.parent_world)

				WwiseWorld.trigger_event(wwise_world, "Play_hud_select")
			end
		end
	end

	Profiler.start("ProfileView")

	local input_service = self.input_manager:get_service("profile_menu")

	self.handle_input(self, input_service, dt)
	self.update_profile_request(self)

	if self.viewport_widget then
		self.profile_world_view:update(dt, input_service)
	end

	if self.active then
		self.draw_widgets(self, dt, input_service)
	end

	Profiler.stop("ProfileView")

	return 
end
ProfileView.post_update = function (self, dt, t)
	if self.viewport_widget then
		self.profile_world_view:post_update(dt, t)
	end

	self.update_animations(self, dt)

	return 
end
ProfileView.handle_input = function (self, input_service, dt)
	if next(self.ui_animations) ~= nil then
		return 
	end

	local transitioning = self.transitioning(self)

	if not self.cancel_input_disabled and not transitioning and not self.pending_profile_change(self) and (input_service.get(input_service, "toggle_menu") or input_service.get(input_service, "back")) then
		self.exit(self)
	end

	local input_manager = self.input_manager

	if not transitioning then
		if input_manager.is_device_active(input_manager, "gamepad") then
			self.profile_world_view:handle_controller_input(input_service, dt)
		elseif Application.platform() == "win32" then
			self.profile_world_view:handle_mouse_input(input_service, dt)
		end
	end

	if self.profile_world_view.done then
		self.profile_world_view.done = false

		if self.profile_world_view.state == "waiting_for_profile_switch" then
			local selected_unit = self.profile_world_view.selected_unit
			local profile_index = self.profile_world_view.units[selected_unit]

			self.change_profile(self, profile_index)
		elseif not self.pending_profile_change(self) then
			self.exit(self)
		end
	end

	return 
end
ProfileView.update_animations = function (self, dt)
	local ui_scenegraph = self.ui_scenegraph

	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil
		end
	end

	return 
end
ProfileView.update_profile_request = function (self)
	if self.pending_profile_request then
		local synchronizer = self.profile_synchronizer

		if self.despawning_player_unit then
			if not Unit.alive(self.despawning_player_unit) then
				synchronizer.request_select_profile(synchronizer, self.requested_profile_index, self.local_player_id)

				self.requested_profile_index = nil
				self.despawning_player_unit = nil

				if self.is_server then
					Managers.state.network.network_server:peer_despawned_player(self.peer_id)
				end
			end
		else
			local result, result_local_player_id = synchronizer.profile_request_result(synchronizer)
			local local_player_id = self.local_player_id

			assert(not result or local_player_id == result_local_player_id, "Local player id mismatch between ui and request.")

			if result == "success" then
				local peer_id = self.peer_id
				local profile_index = synchronizer.profile_by_peer(synchronizer, peer_id, local_player_id)
				local player = self.player_manager:player(peer_id, local_player_id)
				player.profile_index = profile_index
				self.respawn_player_unit = nil

				self.exit(self)
				synchronizer.clear_profile_request_result(synchronizer)

				self.pending_profile_request = nil

				self.save_selected_profile(self, profile_index)
			elseif result then
				local peer_id = self.peer_id
				local profile_index = synchronizer.profile_by_peer(synchronizer, peer_id, local_player_id)
				self.profile_world_view.state = "selecting_profile"

				synchronizer.clear_profile_request_result(synchronizer)

				self.pending_profile_request = nil
				self.respawn_player_unit = true
			end
		end
	end

	return 
end
ProfileView.draw_widgets = function (self, dt, input_service)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	if self.viewport_widget then
		UIRenderer.draw_widget(ui_renderer, self.viewport_widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.dead_space_filler_widget)
	UIRenderer.end_pass(ui_renderer)

	local top_renderer = self.top_renderer

	UIRenderer.begin_pass(top_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(top_renderer, self.character_info_widget)

	if not self.input_manager:is_device_active("gamepad") then
		for name, widget in pairs(self.button_widgets) do
			UIRenderer.draw_widget(top_renderer, widget)
		end
	end

	UIRenderer.end_pass(top_renderer)

	if self.viewport_widget then
		self.profile_world_view:draw_widgets(dt, input_service)
	end

	return 
end
ProfileView.block_accept_button = function (self, block_button)
	self.profile_world_view.blocked_accept = block_button

	return 
end

if rawget(_G, "global_profile_view") then
	global_profile_view:create_ui_elements()
end

return 
