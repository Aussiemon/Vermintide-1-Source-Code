require("scripts/settings/terror_event_blueprints")

TerrorEventMixer = TerrorEventMixer or {}
local TerrorEventMixer = TerrorEventMixer
local amount = {
	0,
	0
}
TerrorEventMixer.active_events = TerrorEventMixer.active_events or {}
TerrorEventMixer.start_event_list = TerrorEventMixer.start_event_list or {}
TerrorEventMixer.init_functions = {
	text = function (event, element, t)
		event.ends_at = t + ConflictUtils.random_interval(element.duration)
	end,
	delay = function (event, element, t)
		event.ends_at = t + ConflictUtils.random_interval(element.duration)
	end,
	spawn = function (event, element, t)
		return
	end,
	spawn_at_raw = function (event, element, t)
		if Managers.player.is_server then
			local breed = Breeds[element.breed_name]
			local archetype_index = nil
			local heroic_archetype = element.heroic_archetype_name

			if heroic_archetype then
				archetype_index = breed.heroic_archetype_lookup[heroic_archetype]
			end

			local conflict_director = Managers.state.conflict

			conflict_director:spawn_at_raw_spawner(breed, archetype_index, element.spawner_id)
		end
	end,
	spawn_patrol = function (event, element, t)
		return
	end,
	continue_when = function (event, element, t)
		if element.duration then
			event.ends_at = t + ConflictUtils.random_interval(element.duration)
		end
	end,
	control_pacing = function (event, element, t)
		local conflict_director = Managers.state.conflict

		if element.enable then
			conflict_director.pacing:enable()
		else
			conflict_director.pacing:disable()
		end
	end,
	control_specials = function (event, element, t)
		local conflict_director = Managers.state.conflict
		local specials_pacing = conflict_director.specials_pacing

		if specials_pacing then
			specials_pacing:enable(element.enable)
		end
	end,
	horde = function (event, element, t)
		event.ends_at = t + ((element.duration and ConflictUtils.random_interval(element.duration)) or 0)
		event.num_hordes = 0
		event.spawn_check = 0
		event.spawned = 0
	end,
	debug_horde = function (event, element, t)
		event.ends_at = t + ((element.duration and ConflictUtils.random_interval(element.duration)) or 0)
	end,
	event_horde = function (event, element, t)
		event.ends_at = t + ((element.duration and ConflictUtils.random_interval(element.duration)) or 0)
		local conflict_director = Managers.state.conflict
		local horde_data = conflict_director:event_horde(t, element.spawner_id, element.composition_type, element.limit_spawners, element.horde_silent)
		element.horde_data = horde_data
	end,
	reset_event_horde = function (event, element, t)
		Managers.state.entity:system("spawner_system"):reset_spawners_with_event_id(element.event_id)
	end,
	force_horde = function (event, element, t)
		event.ends_at = t + ((element.duration and ConflictUtils.random_interval(element.duration)) or 0)
		local horde_type = element.horde_type
		local valid_horde_type = horde_type == "vector" or horde_type == "ambush" or horde_type == "" or horde_type == "random" or not horde_type

		assert(valid_horde_type, "Bad terror event element 'horde_type' was set to %s", horde_type)

		if horde_type == "" or horde_type == "random" then
			horde_type = nil
		end

		Managers.state.conflict.horde_spawner:horde(horde_type)
	end,
	start_event = function (event, element, t)
		print("starting terror event: ", element.start_event_name)

		local start_events = TerrorEventMixer.start_event_list
		start_events[#start_events + 1] = element.start_event_name
	end,
	stop_event = function (event, element, t)
		print("stopping terror event: ", element.stop_event_name)

		local event = TerrorEventMixer.find_event(element.stop_event_name)

		if event then
			event.destroy = true
		end
	end,
	set_master_event_running = function (event, element, t)
		Managers.state.conflict:set_master_event_running(element.name)
	end,
	stop_master_event = function (event, element, t)
		Managers.state.conflict:set_master_event_running()
	end,
	flow_event = function (event, element, t)
		local conflict_director = Managers.state.conflict
		local flow_event = element.flow_event_name

		conflict_director:level_flow_event(flow_event)

		local network_manager = Managers.state.network

		if not element.disable_network_send and network_manager:game() then
			local event_id = NetworkLookup.terror_flow_events[flow_event]

			network_manager.network_transmit:send_rpc_clients("rpc_terror_event_trigger_flow", event_id)
		end
	end,
	play_stinger = function (event, element, t)
		local stinger_name = element.stinger_name or "enemy_terror_event_stinger"
		local optional_pos = element.optional_pos
		local wwise_world = Managers.world:wwise_world(Managers.state.conflict._world)

		if optional_pos then
			local pos = Vector3(optional_pos[1], optional_pos[2], optional_pos[3])
			local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, stinger_name)

			Managers.state.network.network_transmit:send_rpc_clients("rpc_server_audio_event", NetworkLookup.sound_events[stinger_name], pos)
		else
			local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, stinger_name)

			Managers.state.network.network_transmit:send_rpc_clients("rpc_server_audio_event", NetworkLookup.sound_events[stinger_name])
		end
	end,
	enable_bots_in_carry_event = function (event, element, t)
		Managers.state.entity:system("ai_bot_group_system"):set_in_carry_event(true)
	end,
	disable_bots_in_carry_event = function (event, element, t)
		Managers.state.entity:system("ai_bot_group_system"):set_in_carry_event(false)
	end,
	enable_kick = function (event, element, t)
		Managers.state.voting:set_vote_kick_enabled(true)
	end,
	disable_kick = function (event, element, t)
		Managers.state.voting:set_vote_kick_enabled(false)
	end,
	set_freeze_condition = function (event, element, t)
		event.max_active_enemies = element.max_active_enemies or math.huge
	end,
	set_breed_event_horde_spawn_limit = function (event, element, t)
		Managers.state.entity:system("spawner_system"):set_breed_event_horde_spawn_limit(element.breed_name, element.limit)
	end
}
TerrorEventMixer.run_functions = {
	spawn = function (event, element, t, dt)
		local conflict_director = Managers.state.conflict
		local breed = Breeds[element.breed_name]
		local archetype_index = nil
		local heroic_archetype = element.heroic_archetype_name

		if heroic_archetype then
			archetype_index = breed.heroic_archetype_lookup[heroic_archetype]
		end

		local unit = conflict_director:spawn_one(breed, (event.optional_pos and event.optional_pos:unbox()) or nil, archetype_index)

		if unit then
			return true
		end
	end,
	spawn_at_raw = function (event, element, t, dt)
		return true
	end,
	spawn_patrol = function (event, element, t, dt)
		local conflict_director = Managers.state.conflict

		conflict_director:spawn_group(Breeds[element.breed_name], "on mesh", element.patrol_template, event.optional_pos and event.optional_pos:unbox())

		return true
	end,
	continue_when = function (event, element, t, dt)
		if element.duration and event.ends_at < t then
			return true
		end

		return element.condition(t)
	end,
	control_pacing = function (event, element, t, dt)
		return true
	end,
	control_specials = function (event, element, t, dt)
		return true
	end,
	event_horde = function (event, element, t, dt)
		if event.ends_at < t then
			return true
		end
	end,
	reset_event_horde = function (event, element, t, dt)
		return true
	end,
	force_horde = function (event, element, t, dt)
		if event.ends_at < t then
			return true
		end
	end,
	horde = function (event, element, t, dt)
		local conflict_director = Managers.state.conflict

		if event.ends_at < t then
			return true
		end

		if t < event.spawn_check then
			return
		end

		local living_horde = conflict_director:horde_size_total()

		if element.peak_amount < living_horde then
			event.spawn_check = t + 1
		elseif living_horde < element.min_amount then
			local missing = element.peak_amount - living_horde
			local minimum = math.clamp(missing - 5, 1, missing)
			amount[1] = minimum
			amount[2] = missing

			conflict_director:insert_horde(t, amount, 0)
			print("horde spawning:", minimum, missing)

			event.num_hordes = event.num_hordes + 1
			event.spawn_check = t + math.random(5, 7)
		else
			event.spawn_check = t + 1
		end
	end,
	debug_horde = function (event, element, t, dt)
		if event.ends_at < t then
			return true
		end

		local conflict_director = Managers.state.conflict
		local spawned_units = conflict_director:spawned_units()
		local amount = #spawned_units

		if amount < element.amount then
			local center_pos = PLAYER_AND_BOT_POSITIONS[1]
			local pos = ConflictUtils.get_spawn_pos_on_circle(conflict_director.nav_world, center_pos, 25, 15, 5)

			if pos then
				local dir = center_pos - pos
				local spawn_rot = Quaternion.look(Vector3(dir.x, dir.y, 1))
				local breed = Breeds[conflict_director._debug_breed]

				conflict_director:spawn_queued_unit(breed, Vector3Box(pos), QuaternionBox(spawn_rot), "constant_70", nil, "horde_hidden")
			end
		end
	end,
	delay = function (event, element, t, dt)
		if event.ends_at < t then
			return true
		end
	end,
	text = function (event, element, t, dt)
		local time_left = event.ends_at - t

		if time_left >= 0 then
			Debug.text(tostring(element.text))
		else
			return true
		end
	end,
	start_event = function (event, element, t, dt)
		return true
	end,
	stop_event = function (event, element, t, dt)
		return true
	end,
	flow_event = function (event, element, t, dt)
		return true
	end,
	play_stinger = function (event, element, t)
		return true
	end,
	set_master_event_running = function (event, element, t, dt)
		return true
	end,
	stop_master_event = function (event, element, t, dt)
		return true
	end,
	enable_bots_in_carry_event = function (event, element, t)
		return true
	end,
	disable_bots_in_carry_event = function (event, element, t)
		return true
	end,
	enable_kick = function (event, element, t)
		return true
	end,
	disable_kick = function (event, element, t)
		return true
	end,
	set_freeze_condition = function (event, element, t)
		return true
	end,
	set_breed_event_horde_spawn_limit = function (event, element, t)
		return true
	end
}
TerrorEventMixer.debug_functions = {
	control_pacing = function (event, element, t, dt)
		return (element.enable and "enable") or "disable"
	end,
	control_specials = function (event, element, t, dt)
		return (element.enable and "enable") or "disable"
	end,
	delay = function (event, element, t, dt)
		return
	end,
	horde = function (event, element, t, dt)
		local size = Managers.state.conflict:horde_size()

		return string.format(" alive: %d, min-amount: %d, peak-amount: %d", size, element.min_amount, element.peak_amount)
	end,
	debug_horde = function (event, element, t, dt)
		local spawned_units = Managers.state.conflict:spawned_units()
		local amount = #spawned_units

		return string.format(" alive: %d, max-amount: %d", amount, element.amount)
	end,
	event_horde = function (event, element, t, dt)
		local horde_data = element.horde_data

		if horde_data then
			if horde_data.started then
				if horde_data.failed then
					return string.format(" horde failed!")
				else
					return string.format(" amount: %d ", horde_data.amount)
				end
			else
				return "waiting to start..."
			end
		else
			return string.format("waiting to start...")
		end
	end,
	reset_event_horde = function (event, element, t, dt)
		return string.format(element.event_id)
	end,
	force_horde = function (event, element, t, dt)
		return string.format(element.horde_type)
	end,
	spawn = function (event, element, t, dt)
		return element.breed_name
	end,
	spawn_at_raw = function (event, element, t, dt)
		return element.spawner_id .. " -> " .. element.breed_name
	end,
	spawn_patrol = function (event, element, t, dt)
		return element.breed_name
	end,
	start_event = function (event, element, t, dt)
		return "event_name: " .. element.start_event_name
	end,
	stop_event = function (event, element, t, dt)
		return "event_name: " .. element.stop_event_name
	end,
	flow_event = function (event, element, t, dt)
		return "event_name: " .. tostring(element.flow_event_name)
	end,
	set_master_event_running = function (event, element, t, dt)
		return "name: " .. element.name
	end,
	play_stinger = function (event, element, t)
		local p = element.optional_pos

		if p then
			return string.format(" stinger-name: %s, pos: (%.1f,%.1f,%.1f) ", element.stinger_name, p[1], p[2], p[3])
		else
			return " stinger-name:" .. element.stinger_name
		end
	end,
	stop_master_event = function (event, element, t, dt)
		return ""
	end
}

TerrorEventMixer.reset = function ()
	table.clear(TerrorEventMixer.active_events)
	table.clear(TerrorEventMixer.start_event_list)
end

TerrorEventMixer.add_to_start_event_list = function (event_name)
	local start_events = TerrorEventMixer.start_event_list
	start_events[#start_events + 1] = event_name
end

TerrorEventMixer.start_random_event = function (event_chunk_name)
	local event_chunk = WeightedRandomTerrorEvents[event_chunk_name]

	assert(event_chunk, "Cannot find a WeightedRandomTerrorEvent called %s", tostring(event_chunk_name))

	local index = LoadedDice.roll_easy(event_chunk.loaded_probability_table)
	local index = index * 2 - 1
	local event_name = event_chunk[index]

	TerrorEventMixer.add_to_start_event_list(event_name)
	print("TerrorEventMixer.start_random_event:", event_chunk_name, "->", event_name)
end

TerrorEventMixer.start_event = function (event_name, optional_pos)
	local active_events = TerrorEventMixer.active_events
	local elements = TerrorEventBlueprints[event_name]

	fassert(elements, "No terror event called '%s', exists", event_name)
	print("TerrorEventMixer.start_event:", event_name)

	if script_data.debug_terror then
		elements = table.clone(elements)
	end

	local new_event = {
		index = 1,
		ends_at = 0,
		name = event_name,
		elements = elements,
		optional_pos = optional_pos,
		max_active_enemies = math.huge
	}
	active_events[#active_events + 1] = new_event
	local t = Managers.time:time("game")
	local element = elements[1]
	local func_name = element[1]

	TerrorEventMixer.init_functions[func_name](new_event, element, t)
end

TerrorEventMixer.stop_event = function (event_name)
	print("TerrorEventMixer.stop_event:", event_name)

	local active_events = TerrorEventMixer.active_events
	local num_events = #active_events

	for i = 1, num_events, 1 do
		local event = active_events[i]

		if event.name == event_name then
			active_events[i] = active_events[num_events]
			active_events[num_events] = nil

			break
		end
	end
end

TerrorEventMixer.find_event = function (event_name)
	local active_events = TerrorEventMixer.active_events
	local num_events = #active_events

	for i = 1, num_events, 1 do
		local event = active_events[i]

		if event.name == event_name then
			return event
		end
	end
end

TerrorEventMixer.update = function (t, dt, gui)
	local active_events = TerrorEventMixer.active_events
	local num_events = #active_events
	local num_events_at_start_of_update = num_events
	local i = 1

	while num_events >= i do
		local event = active_events[i]

		if not event then
			printf("TerrorEventMixer.update -> nil event, num_events: %d num_events_at_start_of_update: %d i:%d", num_events, num_events_at_start_of_update, i)
			table.dump(active_events, "active_events")
		end

		local event_completed = TerrorEventMixer.run_event(event, t, dt)

		if event_completed then
			active_events[i] = active_events[num_events]
			active_events[num_events] = nil
			num_events = num_events - 1
		else
			i = i + 1
		end
	end

	local start_events = TerrorEventMixer.start_event_list

	for i = 1, #start_events, 1 do
		TerrorEventMixer.start_event(start_events[i])

		start_events[i] = nil
	end

	if script_data.debug_terror and gui then
		TerrorEventMixer.debug(gui, active_events, t, dt)
	end
end

TerrorEventMixer.run_event = function (event, t, dt)
	local elements = event.elements
	local index = event.index
	local element = elements[index]
	local active_enemies = Managers.state.performance:num_active_enemies()

	if event.max_active_enemies < active_enemies then
		element.ends_at = (element.ends_at or 0) + dt
	else
		local func_name = element[1]
		local continue = TerrorEventMixer.run_functions[func_name](event, element, t, dt)

		if continue then
			if event.destroy then
				return true
			end

			index = index + 1

			if index > #elements then
				return true
			end

			event.index = index
			local element = elements[index]
			local func_name = element[1]

			TerrorEventMixer.init_functions[func_name](event, element, t)
		end
	end
end

local tiny_font_size = 16
local tiny_font = "gw_arial_16"
local tiny_font_mtrl = "materials/fonts/" .. tiny_font
local resx, resy = Application.resolution()
local debug_win_width = 330
local debug_x = 0

TerrorEventMixer.debug = function (gui, active_events, t, dt)
	if DebugKeyHandler.key_pressed("mouse_middle_held", "pan terror event mixer", "ai debugger") then
		local input_service = Managers.free_flight.input_manager:get_service("Debug")
		local look = input_service:get("look")
		debug_x = debug_x - look.x * 0.001
	end

	local x = 0
	local y = 0

	for i = 1, #active_events, 1 do
		local event = active_events[i]

		if event then
			TerrorEventMixer.debug_event(gui, event, t, dt, x, y, debug_x * resx, i == 1)

			x = x + debug_win_width + 15
		end
	end
end

TerrorEventMixer.debug_event = function (gui, event, t, dt, x1, y1, panning_x, render_master)
	local elements = event.elements
	local index = event.index
	local element = elements[index]
	local func_name = element[1]
	local borderx = 20 + panning_x
	local bordery = 280
	x1 = x1 + borderx + 20
	y1 = y1 + bordery + 20
	local y2 = y1
	local layer = 200
	local completed_color = Colors.get_color_with_alpha("gray", 255)
	local running_color = Colors.get_color_with_alpha("lavender", 255)
	local unrun_color = Colors.get_color_with_alpha("cadet_blue", 255)
	local header_color = Colors.get_color_with_alpha("orange", 255)

	ScriptGUI.ictext(gui, resx, resy, "Event: " .. event.name, tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 10, y2, layer, header_color)

	y2 = y2 + 20
	local start_index = 1

	if index > 9 then
		start_index = index - 9
	end

	local end_index = #elements

	if end_index - start_index > 18 then
		end_index = start_index + 18
	end

	for i = start_index, index - 1, 1 do
		local element = elements[i]
		local func_name = element[1]
		local debug_text = (TerrorEventMixer.debug_functions[func_name] and TerrorEventMixer.debug_functions[func_name](event, element, t, dt)) or ""
		local text = string.format(" %d] %s %s", i, func_name, debug_text)

		ScriptGUI.ictext(gui, resx, resy, text, tiny_font_mtrl, tiny_font_size, tiny_font, x1, y2, layer, completed_color)

		y2 = y2 + 20
	end

	local element = elements[index]
	local func_name = element[1]
	local debug_text = (TerrorEventMixer.debug_functions[func_name] and TerrorEventMixer.debug_functions[func_name](event, element, t, dt)) or ""
	local ends_at = (element.duration and string.format("time: %.1f", event.ends_at - t)) or ""
	local text = string.format(" %d] %s %s %s", index, func_name, debug_text, ends_at)

	ScriptGUI.ictext(gui, resx, resy, "==>", tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 20, y2, layer, running_color)
	ScriptGUI.ictext(gui, resx, resy, text, tiny_font_mtrl, tiny_font_size, tiny_font, x1, y2, layer, running_color)

	y2 = y2 + 20

	for i = index + 1, end_index, 1 do
		local element = elements[i]
		local func_name = element[1]
		local duration = ""
		local text = string.format(" %d] %s %s", i, func_name, duration)

		ScriptGUI.ictext(gui, resx, resy, text, tiny_font_mtrl, tiny_font_size, tiny_font, x1, y2, layer, unrun_color)

		y2 = y2 + 20
	end

	ScriptGUI.icrect(gui, resx, resy, borderx, bordery, x1 + debug_win_width, y2, layer - 1, Color(200, 20, 20, 20))

	if render_master then
		local disabled_color = Colors.get_color_with_alpha("red", 255)
		local master_color = Colors.get_color_with_alpha("lawn_green", 255)
		local running_master_event = Managers.state.conflict.running_master_event

		if running_master_event then
			ScriptGUI.ictext(gui, resx, resy, "Master Event: ", tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 10, bordery - 6, layer, header_color)
			ScriptGUI.ictext(gui, resx, resy, running_master_event, tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 10 + 75, bordery - 6, layer, master_color)
		else
			ScriptGUI.ictext(gui, resx, resy, "Master Event: ", tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 10, bordery - 6, layer, header_color)
			ScriptGUI.ictext(gui, resx, resy, "disabled", tiny_font_mtrl, tiny_font_size, tiny_font, x1 - 10 + 75, bordery - 6, layer, disabled_color)
		end

		ScriptGUI.icrect(gui, resx, resy, borderx, bordery - 22, x1 + debug_win_width * 0.66, bordery - 2, layer - 1, Color(200, 20, 20, 20))
	end
end

local fail = nil
local s = "\n"

for event_name, elements in pairs(TerrorEventBlueprints) do
	for i = 1, #elements, 1 do
		local element_name = elements[i][1]

		if not TerrorEventMixer.init_functions[element_name] then
			s = s .. string.format("Bad terror event: '%s', there is no element called '%s'. \n", tostring(event_name), tostring(element_name))
			fail = true
		end
	end
end

if fail then
	assert(false, s)
end

return
