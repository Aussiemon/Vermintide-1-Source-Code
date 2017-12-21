require("scripts/entity_system/systems/tutorial/tutorial_templates")

local TIME_TO_WAIT_BETWEEN_SHOWS = 30
local TOOLTIP_MINIMUM_SHOW_TIME = 0.1
local INFOSLATE_COOLDOWN = 100
local DO_TUT_RELOAD = true

function tutprintf(...)
	if script_data.tutorial_debug then
		printf(...)
	end

	return 
end

local function on_save_ended_callback()
	print("Tutorial - save done")

	return 
end

local function save(extension)
	local save_data = SaveData
	save_data.tutorial_points = extension.points
	save_data.completed_tutorials = extension.completed_tutorials

	Managers.save:auto_save(SaveFileName, SaveData, on_save_ended_callback)

	return 
end

local extensions = {
	"PlayerTutorialExtension",
	"ObjectiveHealthTutorialExtension",
	"ObjectivePickupTutorialExtension",
	"ObjectiveSocketTutorialExtension",
	"ObjectiveUnitExtension"
}
TutorialSystem = class(TutorialSystem, ExtensionSystemBase)
TutorialSystem.init = function (self, entity_system_creation_context, system_name)
	TutorialSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	self.player_units = {}
	self.pacing = "pacing_relax"
	self.dice_keeper = entity_system_creation_context.dice_keeper
	self.health_extensions = {}
	self.raycast_units = {}
	self.gui = World.create_screen_gui(self.world, "material", "materials/fonts/arial", "immediate")
	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, "rpc_tutorial_message", "rpc_pacing_changed", "rpc_objective_unit_set_active")

	DO_TUT_RELOAD = false

	return 
end
TutorialSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)
	table.clear(self)

	return 
end
local dummy_input = {}
TutorialSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local extension = {}

	if extension_name == "PlayerTutorialExtension" then
		self.player_units[unit] = extension
		extension.completed_tutorials = SaveData.completed_tutorials or {}
		extension.points = #extension.completed_tutorials
		extension.tooltip_tutorial = {
			active = false
		}
		extension.objective_tooltips = {
			units_n = 0,
			active = false,
			units = {}
		}
		extension.shown_times = {}
		extension.data = {
			player_id = Network.peer_id(),
			statistics_db = self.statistics_db,
			dice_keeper = self.dice_keeper
		}
		local tutorial_templates = TutorialTemplates

		for name, template in pairs(tutorial_templates) do
			extension.shown_times[name] = -1000

			template.init_data(extension.data)
		end
	end

	if extension_name == "ObjectiveHealthTutorialExtension" then
		if self.tutorial_ui ~= nil then
			tutorial_ui:add_health_bar(unit)
		end

		self.health_extensions[unit] = extension
	end

	if extension_name == "ObjectivePickupTutorialExtension" then
		extension.approach_text = Unit.get_data(unit, "approach_text") or "<approach_text not set>"
	end

	if extension_name == "ObjectiveSocketTutorialExtension" then
		extension.approach_text = Unit.get_data(unit, "approach_text") or "<approach_text not set>"
		extension.pickup_text = Unit.get_data(unit, "pickup_text") or "<pickup_text not set>"
	end

	if extension_name == "ObjectiveUnitExtension" then
		local server_only = Unit.get_data(unit, "objective_server_only")
		local activate_func = nil

		if Managers.player.is_server and not server_only then
			function activate_func(extension, active)
				if extension.active == active then
					Application.warning("[ObjectiveUnitExtension] Trying to set active on unit %q to %q when it's already %q", tostring(unit), active, extension.active)
				else
					extension.active = active
					local network_manager = Managers.state.network
					local level_object_id = network_manager.level_object_id(network_manager, extension.unit)

					network_manager.network_transmit:send_rpc_clients("rpc_objective_unit_set_active", level_object_id, active)
				end

				return 
			end
		elseif Managers.player.is_server or not server_only then
			function activate_func(extension, active)
				extension.active = active

				return 
			end
		else
			function activate_func(extension, active)
				local lol = math.random()

				return 
			end
		end

		extension.unit = unit
		extension.active = false
		extension.set_active = activate_func
		extension.server_only = server_only
	end

	POSITION_LOOKUP[unit] = Unit.world_position(unit, 0)

	ScriptUnit.set_extension(unit, "tutorial_system", extension, dummy_input)

	return extension
end
TutorialSystem.on_remove_extension = function (self, unit, extension_name)
	if self.health_extensions[unit] then
		self.health_extensions[unit] = nil

		self.tutorial_ui:remove_health_bar(unit)
	end

	self.player_units[unit] = nil

	ScriptUnit.remove_extension(unit, "tutorial_system")

	POSITION_LOOKUP[unit] = nil

	return 
end
TutorialSystem.physics_async_update = function (self, context, t)
	if script_data.tutorial_disabled then
		return 
	end

	local world = self.world
	local raycast_units = self.raycast_units

	for unit, extension in pairs(self.player_units) do
		local raycast_unit = raycast_units[unit]
		raycast_units[unit] = nil

		Profiler.start("is_looking_at_interactable")

		local interactor_extension = ScriptUnit.extension(unit, "interactor_system")
		local is_looking_at_interactable = interactor_extension.is_looking_at_interactable(interactor_extension)

		if is_looking_at_interactable then
			extension.tooltip_tutorial.active = false
		end

		Profiler.stop()

		local status_extension = ScriptUnit.extension(unit, "status_system")

		if not is_looking_at_interactable and not status_extension.is_disabled(status_extension) then
			Profiler.start("iterate_tooltips")
			self.iterate_tooltips(self, t, unit, extension, raycast_unit, world)
			Profiler.stop()
		end

		Profiler.start("iterate_objective_tooltips")
		self.iterate_objective_tooltips(self, t, unit, extension, raycast_unit, world)
		Profiler.stop()

		if self.pacing == "pacing_peak_fade" or self.pacing == "pacing_relax" then
			Profiler.start("iterate_info_slates")
			self.iterate_info_slates(self, t, unit, extension, raycast_unit, world)
			Profiler.stop()
		end

		if extension.tooltip_tutorial.active then
			local shown_time = extension.shown_times[extension.tooltip_tutorial.name]

			if shown_time + TOOLTIP_MINIMUM_SHOW_TIME < t then
				extension.tooltip_tutorial.active = false
			end
		end

		if script_data.tutorial_debug then
			if DebugKeyHandler.key_pressed("f10", "add debug info slate", "tutorials") then
				local duration = math.random()*5

				self.tutorial_ui:queue_info_slate_entry("tutorial", "DEBUG INFO SLATE, LOOK AT IT GOOOO", duration + 5)
			end

			local res_x = RESOLUTION_LOOKUP.res_w
			local res_y = RESOLUTION_LOOKUP.res_h

			Gui.rect(self.gui, Vector3(0, 0, 100), Vector2(350, res_y), Color(100, 25, 25, 25))
			Debug.text("Tutorial points : %d", extension.points)
			Debug.text("Completed tutorials:")
			Debug.text("Shelved tutorials:")

			for name, template in pairs(TutorialTemplates) do
				local last_shown_time = extension.shown_times[name]

				if t < last_shown_time + TIME_TO_WAIT_BETWEEN_SHOWS then
					Debug.text(" * %s, %.1fs", name, (last_shown_time + TIME_TO_WAIT_BETWEEN_SHOWS) - t)
				end
			end

			if extension.tooltip_tutorial.active then
				Debug.text("Tooltip tutorial: " .. extension.tooltip_tutorial.name)

				if extension.tooltip_tutorial.world_position then
					QuickDrawer:sphere(extension.tooltip_tutorial.world_position:unbox(), 1, Colors.get("brown"))
				end
			else
				Debug.text("Tooltip tutorial: inactive")
			end

			if raycast_unit == nil then
				Debug.text("Raycast unit: none")
			else
				Debug.text("Raycast unit: %s", Unit.debug_name(raycast_unit))
			end

			Debug.text("Extension data:")

			for k, v in pairs(extension.data) do
				Debug.text(" * %s = %s", k, tostring(v))
			end
		end
	end

	DO_TUT_RELOAD = false

	return 
end
TutorialSystem.iterate_tooltips = function (self, t, unit, extension, raycast_unit, world)
	local tooltip_templates = TutorialTooltipTemplates
	local tooltip_templates_n = TutorialTooltipTemplates_n

	for i = 1, tooltip_templates_n, 1 do
		local template = tooltip_templates[i]
		local name = template.name

		template.update_data(t, unit, extension.data)

		local ok, world_position = template.can_show(t, unit, extension.data, raycast_unit, world)

		if not ok then
		else
			if template.get_text then
				template.text = template.get_text(extension.data)
			end

			if template.get_action then
				template.action = template.get_action(extension.data)
			end

			extension.tooltip_tutorial.active = true
			extension.tooltip_tutorial.name = name

			if world_position then
				extension.tooltip_tutorial.world_position = Vector3Box(world_position)
			else
				extension.tooltip_tutorial.world_position = nil
			end

			extension.shown_times[name] = t

			return 
		end
	end

	return 
end
local unit_local_position = Unit.local_position
local vector3_distance_sq = Vector3.distance_squared
local sort_unit_position_upvalue = nil

local function do_sort_objective_units(a, b)
	local a_pos = unit_local_position(a, 0)
	local b_pos = unit_local_position(b, 0)
	local a_dist_sq = vector3_distance_sq(sort_unit_position_upvalue, a_pos)
	local b_dist_sq = vector3_distance_sq(sort_unit_position_upvalue, b_pos)

	return a_dist_sq < b_dist_sq
end

TutorialSystem.iterate_objective_tooltips = function (self, t, unit, extension, raycast_unit, world)
	local objective_tooltip_templates = TutorialObjectiveTooltipTemplates
	local objective_tooltip_templates_n = TutorialObjectiveTooltipTemplates_n
	local objective_tooltips = extension.objective_tooltips
	objective_tooltips.units_n = 0

	for i = 1, objective_tooltip_templates_n, 1 do
		local template = objective_tooltip_templates[i]
		local name = template.name

		template.update_data(t, unit, extension.data)
		Profiler.start(template.name)

		local ok, objective_units, objective_units_n = template.can_show(t, unit, extension.data, raycast_unit, world)

		Profiler.stop()

		if not ok then
		else
			if template.get_text then
				template.text = template.get_text(extension.data)
			end

			if template.get_action then
				template.action = template.get_action(extension.data)
			end

			if template.get_icon then
				template.icon = template.get_icon(extension.data)
			end

			if template.get_alert then
				template.alerts_horde = template.get_alert(extension.data)
			end

			if template.get_wave then
				template.wave = template.get_wave(extension.data)
			end

			objective_tooltips.active = true
			objective_tooltips.name = name
			objective_tooltips.units_n = objective_units_n
			local saved_units = objective_tooltips.units

			for i = 1, objective_units_n, 1 do
				saved_units[i] = objective_units[i]
			end

			local i = objective_units_n + 1

			while saved_units[i] do
				saved_units[i] = nil
				i = i + 1
			end

			if 1 < objective_units_n then
				local vector3_distance_sq = Vector3.distance_squared
				local unit_position = POSITION_LOOKUP[unit]
				sort_unit_position_upvalue = unit_position
				local sort_func = do_sort_objective_units

				table.sort(saved_units, sort_func)

				sort_unit_position_upvalue = nil
			end

			return 
		end
	end

	return 
end
TutorialSystem.verify_info_slate = function (self, t, unit, raycast_unit, template)
	local extension = self.player_units[unit]
	local world = self.world

	if template.do_not_verify then
		return true
	end

	return template.can_show(t, unit, extension.data, raycast_unit, world)
end
TutorialSystem.iterate_info_slates = function (self, t, unit, extension, raycast_unit, world)
	if Application.user_setting("tutorials_enabled") then
		local info_slate_templates = TutorialInfoSlateTemplates
		local info_slate_templates_n = TutorialInfoSlateTemplates_n

		for i = 1, info_slate_templates_n, 1 do
			local template = info_slate_templates[i]
			local name = template.name
			local cooldown = (template.cooldown and template.cooldown) or INFOSLATE_COOLDOWN

			if t < extension.shown_times[name] + cooldown then
			elseif template.can_show(t, unit, extension.data, raycast_unit, world) then
				extension.shown_times[name] = t
				local text = (template.get_text and template.get_text(extension.data, template)) or template.text
				text = Localize(text)

				self.tutorial_ui:queue_info_slate_entry("tutorial", text, nil, nil, template, unit, raycast_unit)
			end
		end
	else
		self.tutorial_ui:clear_tutorials()
	end

	return 
end
TutorialSystem.rpc_tutorial_message = function (self, sender, template_id, message_id)
	local template_name = NetworkLookup.tutorials[template_id]
	local message = NetworkLookup.tutorials[message_id]
	local template = TutorialTemplates[template_name]

	for unit, extension in pairs(self.player_units) do
		local data = extension.data

		template.on_message(data, message)
	end

	return 
end
TutorialSystem.rpc_pacing_changed = function (self, sender, pacing_id)
	local pacing = NetworkLookup.pacing[pacing_id]
	self.pacing = pacing

	tutprintf("Changing pacing state to %s", pacing)

	return 
end
TutorialSystem.rpc_objective_unit_set_active = function (self, sender, level_object_id, activate)
	local unit = Managers.state.network:game_object_or_level_unit(level_object_id, true)
	local extension = ScriptUnit.extension(unit, "tutorial_system")

	extension.set_active(extension, activate)

	return 
end
TutorialSystem.set_tutorial_ui = function (self, tutorial_ui)
	self.tutorial_ui = tutorial_ui

	for unit, extension in pairs(self.health_extensions) do
		tutorial_ui.add_health_bar(tutorial_ui, unit)
	end

	return 
end
TutorialSystem.flow_callback_show_health_bar = function (self, unit, show)
	if show then
		self.tutorial_ui:add_health_bar(unit)
	else
		self.tutorial_ui:remove_health_bar(unit)
	end

	return 
end
TutorialSystem.flow_callback_tutorial_message = function (self, template_name, message)
	if Managers.player.is_server then
		local template_id = NetworkLookup.tutorials[template_name]
		local message_id = NetworkLookup.tutorials[message]
		local network_manager = Managers.state.network

		network_manager.network_transmit:send_rpc_all("rpc_tutorial_message", template_id, message_id)
	end

	return 
end
TutorialSystem.hot_join_sync = function (self, peer_id)
	local network_manager = Managers.state.network
	local units = Managers.state.entity:get_entities("ObjectiveUnitExtension")

	for objective_unit, extension in pairs(units) do
		if extension.active and not extension.server_only then
			local level_object_id = network_manager.level_object_id(network_manager, objective_unit)

			network_manager.network_transmit:send_rpc("rpc_objective_unit_set_active", peer_id, level_object_id, true)
		end
	end

	return 
end
TutorialSystem.update = function (self, context, t)
	if script_data.tutorial_disabled then
		return 
	end

	local world = self.world
	local physics_world = World.get_data(self.world, "physics_world")
	local raycast_units = self.raycast_units

	Profiler.start("raycast")

	for unit, extension in pairs(self.player_units) do
		if DO_TUT_RELOAD or DebugKeyHandler.key_pressed("f3", "reset tutorials", "tutorials") then
			extension.completed_tutorials = {}
			extension.points = 0
			extension.tooltip_tutorial.active = false
			extension.data = {
				player_id = Network.peer_id(),
				statistics_db = self.statistics_db,
				dice_keeper = self.dice_keeper
			}

			for name, template in pairs(TutorialTemplates) do
				extension.shown_times[name] = -1000

				template.init_data(extension.data)
			end
		end

		local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
		local camera_position = first_person_extension.current_position(first_person_extension)
		local camera_rotation = first_person_extension.current_rotation(first_person_extension)
		local camera_forward = Quaternion.forward(camera_rotation)
		local result, hit_position, hit_distance, normal, actor = PhysicsWorld.immediate_raycast(physics_world, camera_position + camera_forward, camera_forward, 30, "closest", "collision_filter", "filter_tutorial")
		local raycast_unit = nil

		if result and actor then
			raycast_unit = Actor.unit(actor)

			if raycast_unit and Unit.alive(raycast_unit) and ScriptUnit.has_extension(raycast_unit, "health_system") then
				local health_extension = ScriptUnit.extension(raycast_unit, "health_system")

				if not health_extension.is_alive(health_extension) then
					raycast_unit = nil
				end
			end
		end

		raycast_units[unit] = raycast_unit
	end

	Profiler.stop()

	return 
end

return 