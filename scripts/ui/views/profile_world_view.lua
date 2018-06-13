require("scripts/utils/function_command_queue")

local attachments = {
	witch_hunter = {
		{
			unit_name = "units/beings/player/witch_hunter/headpiece/wh_hat_03",
			linking = AttachmentNodeLinking.hat.slot_hat
		}
	},
	bright_wizard = {
		{
			unit_name = "units/weapons/player/wpn_brw_skullstaff/wpn_brw_skullstaff_3p",
			linking = AttachmentNodeLinking.staff.third_person.wielded
		},
		{
			unit_name = "units/beings/player/bright_wizard/headpiece/bw_clothgate_01",
			linking = AttachmentNodeLinking.bw_gate.slot_hat
		}
	},
	dwarf_ranger = {
		{
			unit_name = "units/weapons/player/wpn_dw_hammer_02_t1/wpn_dw_hammer_02_t1_3p",
			linking = AttachmentNodeLinking.one_handed_melee_weapon.right.third_person.wielded
		},
		{
			unit_name = "units/weapons/player/wpn_dw_shield_04_t1/wpn_dw_shield_04_3p",
			linking = AttachmentNodeLinking.one_handed_melee_weapon.left.third_person.wielded
		},
		{
			unit_name = "units/beings/player/dwarf_ranger/headpiece/dr_helmet_01",
			linking = AttachmentNodeLinking.hat.slot_hat
		}
	},
	wood_elf = {
		{
			unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3p",
			linking = AttachmentNodeLinking.arrow.third_person.wielded
		},
		{
			unit_name = "units/weapons/player/wpn_we_bow_01_t2/wpn_we_bow_01_t2_3p",
			linking = AttachmentNodeLinking.bow.third_person.wielded
		},
		{
			unit_name = "units/beings/player/way_watcher/headpiece/ww_hood_01",
			linking = AttachmentNodeLinking.hat_skinned.slot_hat
		}
	},
	empire_soldier = {
		{
			unit_name = "units/beings/player/empire_soldier/headpiece/es_hat_01",
			linking = AttachmentNodeLinking.hat.slot_hat
		},
		{
			unit_name = "units/weapons/player/wpn_empire_2h_sword_01_t2/wpn_2h_sword_01_t2_3p",
			linking = AttachmentNodeLinking.one_handed_melee_weapon.right.third_person.wielded
		}
	}
}

local function outline_unit(unit, flag, channel, do_outline)
	if Unit.has_data(unit, "outlined_meshes") then
		local i = 0

		while Unit.has_data(unit, "outlined_meshes", i) do
			local mesh_name = Unit.get_data(unit, "outlined_meshes", i)
			local mesh = Unit.mesh(unit, mesh_name)

			Mesh.set_shader_pass_flag(mesh, flag, do_outline)

			if do_outline then
				local num_materials = Mesh.num_materials(mesh)

				for j = 0, num_materials - 1, 1 do
					local material = Mesh.material(mesh, j)

					Material.set_color(material, "outline_color", channel)
				end
			end

			i = i + 1
		end
	else
		local num_meshes = Unit.num_meshes(unit)

		for i = 0, num_meshes - 1, 1 do
			local mesh = Unit.mesh(unit, i)

			Mesh.set_shader_pass_flag(mesh, flag, do_outline)

			if do_outline then
				local num_materials = Mesh.num_materials(mesh)

				for j = 0, num_materials - 1, 1 do
					local material = Mesh.material(mesh, j)

					Material.set_color(material, "outline_color", channel)
				end
			end
		end
	end
end

local flow_events = {
	witch_hunter = {
		hovered = "witch_hunter_hovered",
		available = "witch_hunter_available",
		unavailable = "witch_hunter_unavailable",
		selected = "witch_hunter_selected",
		unselected = "witch_hunter_unselected",
		unhovered = "witch_hunter_unhovered"
	},
	bright_wizard = {
		hovered = "bright_wizard_hovered",
		available = "bright_wizard_available",
		unavailable = "bright_wizard_unavailable",
		selected = "bright_wizard_selected",
		unselected = "bright_wizard_unselected",
		unhovered = "bright_wizard_unhovered"
	},
	dwarf_ranger = {
		hovered = "dwarf_ranger_hovered",
		available = "dwarf_ranger_available",
		unavailable = "dwarf_ranger_unavailable",
		selected = "dwarf_ranger_selected",
		unselected = "dwarf_ranger_unselected",
		unhovered = "dwarf_ranger_unhovered"
	},
	wood_elf = {
		hovered = "wood_elf_hovered",
		available = "wood_elf_available",
		unavailable = "wood_elf_unavailable",
		selected = "wood_elf_selected",
		unselected = "wood_elf_unselected",
		unhovered = "wood_elf_unhovered"
	},
	empire_soldier = {
		hovered = "empire_soldier_hovered",
		available = "empire_soldier_available",
		unavailable = "empire_soldier_unavailable",
		selected = "empire_soldier_selected",
		unselected = "empire_soldier_unselected",
		unhovered = "empire_soldier_unhovered"
	}
}
local generic_map_actions = {
	default = {
		select_character = {
			{
				priority = 2,
				input_action = "confirm",
				description_text = "input_description_select_character"
			},
			{
				priority = 3,
				input_action = "back",
				description_text = "input_description_close"
			}
		},
		confirm_character = {
			{
				priority = 2,
				input_action = "confirm",
				description_text = "input_description_confirm"
			},
			{
				priority = 3,
				input_action = "back",
				description_text = "input_description_close"
			}
		},
		unavailable = {
			{
				priority = 3,
				input_action = "back",
				description_text = "input_description_close"
			}
		}
	},
	close_disabled = {
		select_character = {
			{
				priority = 2,
				input_action = "confirm",
				description_text = "input_description_select_character"
			}
		},
		confirm_character = {
			{
				priority = 2,
				input_action = "confirm",
				description_text = "input_description_confirm"
			}
		},
		unavailable = {}
	}
}
local text_colors = {
	available = Colors.get_table("white"),
	unavailable = Colors.get_table("red")
}
local wait_before_return_times = {
	witch_hunter = 1,
	empire_soldier = 1,
	dwarf_ranger = 1,
	wood_elf = 1,
	bright_wizard = 1
}
local definitions = local_require("scripts/ui/views/profile_view_definitions")
local profile_world_view_definitions = definitions.profile_world_view
local DO_RELOAD_PROFILE_VIEW = true
ProfileWorldView = class(ProfileWorldView)

ProfileWorldView.init = function (self, ingame_ui_context)
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.input_manager = ingame_ui_context.input_manager
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.units = {}
	self.attachment_units = {}
	self.available_units = {}
	self.selected_unit = {}
	self.blocked_accept = false
	self.sorted_units = {}
	self.unit_states = {}
	self.title_text_anim_t = 0
	self._gamepad_select_delay = 0
	local max_num_args = 3
	self.function_command_queue = FunctionCommandQueue:new(max_num_args)
	self.description_texts = {}

	for i = 1, #SPProfiles, 1 do
		local profile = SPProfiles[i]
		self.description_texts[i] = profile.display_name
	end

	local input_service = self.input_manager:get_service("profile_menu")
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.top_renderer, input_service, 3, UILayer.default, generic_map_actions.default.select_character)

	self.menu_input_description:set_input_description(nil)
end

ProfileWorldView.destroy = function (self)
	self.menu_input_description:destroy()

	self.menu_input_description = nil
end

ProfileWorldView.post_update = function (self, dt, t)
	self.function_command_queue:run_commands()
end

ProfileWorldView.on_enter = function (self, viewport_widget, input_service, character_info_widget, button_widgets, cancel_input_disabled)
	self.gamepad_active_generic_actions_name = nil
	self.input_service = input_service
	self.viewport_widget = viewport_widget
	local viewport_widget_pass_data = viewport_widget.element.pass_data[1]
	self.level = viewport_widget_pass_data.level
	self.world = viewport_widget_pass_data.world
	self.viewport = viewport_widget_pass_data.viewport
	self.camera = ScriptViewport.camera(self.viewport)

	Application.set_render_setting("max_shadow_casting_lights", 16)
	Application.set_render_setting("shadow_fade_in_speed", 100)
	Application.set_render_setting("shadow_fade_out_speed", 100)

	self.unit_states = {}
	local world = self.world
	local scene_graph_links = {}
	local SPProfiles = SPProfiles
	local level = self.level
	local level_units = Level.units(level)
	local level_units_n = #level_units

	for i = 0, level_units_n - 1, 1 do
		local level_unit = Level.unit_by_index(level, i)

		if Unit.has_camera(level_unit, "camera") then
			self.camera_root_unit = level_unit
		else
			for j = 1, #SPProfiles, 1 do
				local profile = SPProfiles[j]
				local display_name = profile.display_name

				if Unit.get_data(level_unit, display_name) == true then
					local pos = Unit.local_position(level_unit, 0)
					local rot = Unit.local_rotation(level_unit, 0)
					local skin_settings = Managers.unlock:get_skin_settings(display_name)
					local units = skin_settings.units
					local unit_name = units.third_person.third_person
					local spawned_unit = World.spawn_unit(world, unit_name, pos, rot)

					if Unit.has_lod_object(spawned_unit, "lod") then
						local lod_object = Unit.lod_object(spawned_unit, "lod")

						LODObject.set_static_select(lod_object, 0)
					end

					self.units[j] = spawned_unit
					self.units[spawned_unit] = j
					self.sorted_units[j] = spawned_unit
					self.available_units[j] = true
					self.unit_states[j] = {
						wait_time = 0,
						wanted_state = "unselected",
						state = "unselected"
					}

					Unit.animation_event(spawned_unit, "select_hover_loop")

					local lookat = Vector3(0, 6, 1)
					local aim_constraint_anim_var = Unit.animation_find_constraint_target(spawned_unit, "aim_constraint_target")

					Unit.animation_set_constraint_target(spawned_unit, aim_constraint_anim_var, lookat)

					local profile_attachments = attachments[display_name]

					for attachment_i = 1, #profile_attachments, 1 do
						local attachment_data = profile_attachments[attachment_i]
						local attached_unit_name = attachment_data.unit_name
						local linking = attachment_data.linking
						local attached_unit = World.spawn_unit(world, attached_unit_name)

						if Unit.has_lod_object(attached_unit, "lod") then
							local lod_object = Unit.lod_object(attached_unit, "lod")

							LODObject.set_static_select(lod_object, 0)
						end

						GearUtils.link(world, linking, scene_graph_links, spawned_unit, attached_unit)

						self.attachment_units[#self.attachment_units + 1] = attached_unit

						Unit.flow_event(attached_unit, "lua_wield")
					end

					if profile_attachments.anim then
						Unit.animation_event(spawned_unit, profile_attachments.anim)
					end

					Level.trigger_event(level, flow_events[display_name].unhovered)
					Level.trigger_event(level, flow_events[display_name].available)
					Level.trigger_event(level, "start_story")
				end
			end
		end
	end

	table.sort(self.sorted_units, function (a, b)
		return Unit.local_position(b, 0).x < Unit.local_position(a, 0).x
	end)

	self.ui_scenegraph = UISceneGraph.init_scenegraph(profile_world_view_definitions.scenegraph)
	self.button_widgets = button_widgets
	self.character_info_widget = character_info_widget
	DO_RELOAD_PROFILE_VIEW = false
	self.hovered_unit = nil
	self.selected_unit = nil
	self.state = "selecting_profile"
	self.controller_index = nil
	self.wait_times = {}
	self.profile_selection_widgets = {}
	local profile_selection_widget_definitions = profile_world_view_definitions.profile_selection_widgets

	for i = 1, #profile_selection_widget_definitions, 1 do
		self.profile_selection_widgets[i] = UIWidget.init(profile_selection_widget_definitions[i])
	end

	self.button_widgets.cancel_button.content.button_hotspot.disabled = cancel_input_disabled
	local saved_profile_index = SaveData.wanted_profile_index or 3
	local starting_selection_unit = self.units[saved_profile_index]

	self:hover_unit(starting_selection_unit)
	self:select_unit(starting_selection_unit, true)

	for index, unit in ipairs(self.sorted_units) do
		if starting_selection_unit == unit then
			self.controller_index = index

			break
		end
	end

	self:update_input_description()
end

ProfileWorldView.on_exit = function (self)
	local max_shadow_casting_lights = Application.user_setting("render_settings", "max_shadow_casting_lights")

	Application.set_render_setting("max_shadow_casting_lights", max_shadow_casting_lights)
	Application.set_render_setting("shadow_fade_in_speed", 4)
	Application.set_render_setting("shadow_fade_out_speed", 2)

	for i = 1, 5, 1 do
		local unit = self.units[i]

		self.function_command_queue:cleanup_destroyed_unit(unit)
		World.destroy_unit(self.world, unit)
	end

	table.clear(self.units)

	for ii = 1, #self.attachment_units, 1 do
		local unit = self.attachment_units[ii]

		Unit.flow_event(unit, "lua_attachment_hidden")
		self.function_command_queue:cleanup_destroyed_unit(unit)
		World.destroy_unit(self.world, unit)
	end

	table.clear(self.attachment_units)
	GarbageLeakDetector.register_object(self, "ProfileWorldView")
end

ProfileWorldView.handle_mouse_input = function (self, input_service)
	local mouse = input_service:get("cursor")
	local hover_unit, hover_index = nil
	local profile_selection_widgets = self.profile_selection_widgets
	local num_profile_selection_widgets = #profile_selection_widgets

	for i = 1, num_profile_selection_widgets, 1 do
		if profile_selection_widgets[i].content.is_hover then
			hover_index = i

			break
		end
	end

	if hover_index then
		hover_unit = self.sorted_units[hover_index]
	end

	local is_hovering_button = self.button_widgets.accept_button.content.button_hotspot.is_hover or self.button_widgets.cancel_button.content.button_hotspot.is_hover

	if is_hovering_button then
		hover_unit = nil
	end

	self:hover_unit(hover_unit)

	if input_service:get("left_release") and not is_hovering_button and hover_unit and self.state == "selecting_profile" then
		local profile_index = self.units[hover_unit]
		local available = self.available_units[profile_index]

		if available then
			self:select_unit(hover_unit)
		end
	end

	if self.state == "selecting_profile" then
		if self.selected_unit ~= nil and self.button_widgets.accept_button.content.button_hotspot.on_release and not self.blocked_accept then
			self.button_widgets.accept_button.content.button_hotspot.on_release = false
			self.done = true
			local profile_index = self.units[self.selected_unit]
			local player = Managers.player:local_player()

			if player == nil or player.profile_index ~= profile_index then
				self.state = "waiting_for_profile_switch"
			end
		elseif self.button_widgets.cancel_button.content.button_hotspot.on_release then
			self.done = true
			self.state = "selecting_profile"
		end
	end
end

ProfileWorldView.handle_controller_input = function (self, input_service, dt)
	local new_controller_index = nil

	if self.hovered_unit == nil or self.controller_index == nil then
		new_controller_index = 1
	else
		if input_service:get("move_left") then
			new_controller_index = math.max(1, self.controller_index - 1)
		end

		if input_service:get("move_right") then
			new_controller_index = math.min(5, self.controller_index + 1)
		end
	end

	if new_controller_index and new_controller_index ~= self.controller_index then
		self.controller_index = new_controller_index
		local hover_unit = self.sorted_units[self.controller_index]

		self:hover_unit(hover_unit)
		self:select_unit_gamepad(hover_unit, 0.5, true)
	end

	if self.state == "selecting_profile" and self.selected_unit == self.sorted_units[self.controller_index] and input_service:get("confirm") and not self.blocked_accept then
		self.done = true
		local profile_index = self.units[self.selected_unit]
		local player = Managers.player:local_player()

		if player == nil or player.profile_index ~= profile_index then
			self.state = "waiting_for_profile_switch"
			local wwise_world = Managers.world:wwise_world(self.world)
			slot7, slot8 = WwiseWorld.trigger_event(wwise_world, "Play_hud_character_select")
		end
	end

	self:update_select_unit_gamepad(dt)
	self:update_input_description()
end

ProfileWorldView.update_input_description = function (self)
	local actions_name_to_use = "default"
	local hover_unit = self.sorted_units[self.controller_index]

	if self.selected_unit == hover_unit then
		actions_name_to_use = "confirm_character"
	else
		actions_name_to_use = "unavailable"
	end

	if not self.gamepad_active_generic_actions_name or self.gamepad_active_generic_actions_name ~= actions_name_to_use then
		self.gamepad_active_generic_actions_name = actions_name_to_use
		local generic_input_actions = (self.ingame_ui.initial_profile_view and generic_map_actions.close_disabled) or generic_map_actions.default
		local generic_actions = generic_input_actions[actions_name_to_use]

		self.menu_input_description:change_generic_actions(generic_actions)
	end
end

ProfileWorldView.update = function (self, dt)
	if DO_RELOAD_PROFILE_VIEW then
		DO_RELOAD_PROFILE_VIEW = false
		self.ui_scenegraph = UISceneGraph.init_scenegraph(profile_world_view_definitions.scenegraph)

		table.clear(self.button_widgets)

		for widget_name, widget_definition in pairs(profile_world_view_definitions.button_widgets) do
			self.button_widgets[widget_name] = UIWidget.init(widget_definition)
		end

		self.character_info_widget = UIWidget.init(profile_world_view_definitions.character_info_widget)
	end

	Camera.set_vertical_fov(self.camera, Camera.vertical_fov(Unit.camera(self.camera_root_unit, "camera")))
	ScriptCamera.set_local_position(self.camera, Unit.local_position(self.camera_root_unit, 0))
	ScriptCamera.set_local_rotation(self.camera, Unit.local_rotation(self.camera_root_unit, 0))

	for i = 1, 5, 1 do
		local unit_state = self.unit_states[i]
		unit_state.wait_time = unit_state.wait_time - dt

		if unit_state.wait_time < 0 then
			local unit = self.units[i]

			if unit_state.state == "selected" and unit_state.wanted_state == "unselected" then
				self.function_command_queue:queue_function_command(Unit.animation_event, unit, "select_accept_end")

				unit_state.wait_time = 2
			elseif unit_state.state == "unselected" and unit_state.wanted_state == "selected" then
				self.function_command_queue:queue_function_command(Unit.animation_event, unit, "select_accept_start")

				unit_state.wait_time = 2
			end

			unit_state.state = unit_state.wanted_state
		end
	end

	if self.state == "waiting_for_profile_switch" then
		return
	end

	local player = Managers.player:local_player()
	local profile_synchronizer = self.profile_synchronizer

	for i = 1, 5, 1 do
		local lol = math.random()
		local unit = self.units[i]
		local profile_index = self.units[unit]
		local is_available = not profile_synchronizer:owner(i)

		if player ~= nil and player.profile_index == profile_index then
			is_available = true
		end

		local was_available = self.available_units[i]

		if is_available and not was_available then
			self.function_command_queue:queue_function_command(Unit.animation_event, unit, "select_accept_end")

			local profile_name = SPProfiles[profile_index].display_name

			self.function_command_queue:queue_function_command(Level.trigger_event, self.level, flow_events[profile_name].available)

			self.available_units[i] = true
		elseif not is_available and was_available then
			if unit == self.selected_unit then
			end

			self.function_command_queue:queue_function_command(Unit.animation_event, unit, "select_hover_loop")

			local profile_name = SPProfiles[profile_index].display_name

			self.function_command_queue:queue_function_command(Level.trigger_event, self.level, flow_events[profile_name].unavailable)

			self.available_units[i] = false
		end
	end

	if self.hovered_unit then
		local profile_index = self.units[self.hovered_unit]

		if self.available_units[profile_index] then
			local profile_name = SPProfiles[profile_index].character_name
			self.character_info_widget.content.title_text = Localize(profile_name)
			self.character_info_widget.style.title_text.text_color = text_colors.available
			self.character_info_widget.content.description_text = Localize(self.description_texts[profile_index])
		else
			self.character_info_widget.content.title_text = Localize("profile_not_available")
			self.character_info_widget.style.title_text.text_color = text_colors.unavailable
			self.character_info_widget.content.description_text = Localize(self.description_texts[profile_index])
		end
	elseif self.selected_unit then
		local profile_index = self.units[self.selected_unit]
		local profile_name = SPProfiles[profile_index].character_name
		self.character_info_widget.content.title_text = Localize(profile_name)
		self.character_info_widget.style.title_text.text_color = text_colors.available
		self.character_info_widget.content.description_text = Localize(self.description_texts[profile_index])
	else
		self.character_info_widget.content.title_text = Localize("profile_choose")
		self.character_info_widget.style.title_text.text_color = text_colors.available
		self.character_info_widget.content.description_text = ""
	end

	local accept_button = self.button_widgets.accept_button

	if self.selected_unit == nil or self.state ~= "selecting_profile" or self.blocked_accept then
		if not accept_button.content.button_hotspot.disabled then
			table.clear(accept_button.content.button_hotspot)

			accept_button.content.button_hotspot.disabled = true
		end
	elseif accept_button.content.button_hotspot.disabled then
		accept_button.content.button_hotspot.disabled = false
	end

	self.title_text_anim_t = self.title_text_anim_t + dt

	if self.title_text_anim_t > 0.5 then
		local title_text_color = self.character_info_widget.style.title_text.text_color
		title_text_color[1] = math.min(255, title_text_color[1] + dt * 400)
	end
end

ProfileWorldView.draw_widgets = function (self, dt, input_service)
	local ui_renderer = self.ui_renderer
	local top_renderer = self.top_renderer
	local ui_scenegraph = self.ui_scenegraph

	UIRenderer.begin_pass(top_renderer, ui_scenegraph, input_service, dt)

	local profile_selection_widgets = self.profile_selection_widgets
	local num_profile_selection_widgets = #profile_selection_widgets

	for i = 1, num_profile_selection_widgets, 1 do
		UIRenderer.draw_widget(top_renderer, profile_selection_widgets[i])
	end

	UIRenderer.end_pass(top_renderer)

	if self.input_manager:is_device_active("gamepad") then
		self.menu_input_description:draw(top_renderer, dt)
	end
end

ProfileWorldView.hover_unit = function (self, unit)
	local level = self.level

	if self.hovered_unit and unit ~= self.hovered_unit then
		local profile_index = self.units[self.hovered_unit]
		local profile_name = SPProfiles[profile_index].display_name
		local available_event = (self.available_units[profile_index] and "available") or "unavailable"

		if self.available_units[profile_index] then
			self.function_command_queue:queue_function_command(Level.trigger_event, self.level, flow_events[profile_name].available)
		end

		self.function_command_queue:queue_function_command(Level.trigger_event, level, flow_events[profile_name].unhovered)
	end

	if unit ~= self.hovered_unit then
		if unit then
			local profile_index = self.units[unit]
			local profile_name = SPProfiles[profile_index].display_name

			if self.available_units[profile_index] then
				self.function_command_queue:queue_function_command(Level.trigger_event, self.level, flow_events[profile_name].unavailable)
			end

			self.function_command_queue:queue_function_command(Level.trigger_event, level, flow_events[profile_name].hovered)

			local wwise_world = Managers.world:wwise_world(self.world)
			local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, "Play_hud_character_hover")
			self.character_info_widget.content.title_text = Localize(profile_name)
			self.character_info_widget.content.description_text = Localize(self.description_texts[self.units[unit]])
			self.character_info_widget.style.title_text.text_color[1] = 255
		elseif self.selected_unit == nil then
			self.character_info_widget.content.title_text = Localize("profile_choose")
			self.character_info_widget.content.description_text = ""
			self.character_info_widget.style.title_text.text_color[1] = 0
			self.title_text_anim_t = 0
		end
	end

	self.hovered_unit = unit
end

ProfileWorldView.select_unit_gamepad = function (self, unit, delay, ignore_sound)
	self._unit_to_select = unit
	self._gamepad_select_delay = delay
	self._ignore_sound = ignore_sound
end

ProfileWorldView.update_select_unit_gamepad = function (self, dt)
	self._gamepad_select_delay = self._gamepad_select_delay - dt

	if self._gamepad_select_delay <= 0 and self._unit_to_select then
		self:select_unit(self._unit_to_select, self._ignore_sound)
	end
end

ProfileWorldView.select_unit = function (self, unit, ignore_sound)
	local level = self.level

	if self.selected_unit and unit ~= self.selected_unit then
		local profile_index = self.units[self.selected_unit]
		local profile_name = SPProfiles[profile_index].display_name

		self.function_command_queue:queue_function_command(Level.trigger_event, level, flow_events[profile_name].unselected)

		self.selected_unit = nil
		self.unit_states[profile_index].wanted_state = "unselected"
	end

	if unit == nil then
		return
	end

	if unit == self.selected_unit then
		return
	end

	if not self.available_units[self.units[unit]] then
		return
	end

	local profile_index = self.units[unit]
	local profile_name = SPProfiles[profile_index].display_name

	self.function_command_queue:queue_function_command(Level.trigger_event, level, flow_events[profile_name].selected)

	if not ignore_sound then
		local wwise_world = Managers.world:wwise_world(self.world)
		slot7, slot8 = WwiseWorld.trigger_event(wwise_world, "Play_hud_character_select")
	end

	self.selected_unit = unit
	self.unit_states[profile_index].wanted_state = "selected"
end

return
