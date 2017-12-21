require("scripts/hub_elements/ai_spawner")

SpawnerSystem = class(SpawnerSystem, ExtensionSystemBase)
local extensions = {
	"AISpawner"
}
local player_positions = PLAYER_POSITIONS
local script_data = script_data
SpawnerSystem.init = function (self, context, system_name)
	SpawnerSystem.super.init(self, context, system_name, extensions)

	self._spawn_list = {}
	self._active_spawners = {}
	self._enabled_spawners = {}
	self._disabled_spawners = {}
	self._num_hidden_spawners = 0
	self._id_lookup = {}
	self._raw_id_lookup = {}
	self._waiting_to_spawn = 0
	local event_manager = Managers.state.event

	event_manager.register(event_manager, self, "spawn_horde", "spawn_horde")

	self.hidden_spawners_broadphase = Broadphase(40, 512)

	return 
end
SpawnerSystem.running_spawners = function (self)
	return self._active_spawners
end
SpawnerSystem.enabled_spawners = function (self)
	return self._enabled_spawners
end
SpawnerSystem.register_enabled_spawner = function (self, spawner, terror_event_id, hidden)
	self._enabled_spawners[#self._enabled_spawners + 1] = spawner

	if terror_event_id then
		local lookup = self._id_lookup[terror_event_id]

		if not lookup then
			lookup = {}
			self._id_lookup[terror_event_id] = lookup
		end

		lookup[#lookup + 1] = spawner
	end

	if hidden then
		local pos = Unit.local_position(spawner, 0)

		Broadphase.add(self.hidden_spawners_broadphase, spawner, pos, 1)

		self._num_hidden_spawners = self._num_hidden_spawners + 1
	end

	return 
end
SpawnerSystem.hibernate_spawner = function (self, spawner, hibernate)
	local enabled_spawners = self._enabled_spawners
	local num_enabled_spawners = #enabled_spawners
	local disabled_spawners = self._disabled_spawners
	local spawner_was_hibernating = disabled_spawners[spawner]

	print("hibernate_spawner:", hibernate)

	if hibernate then
		if not spawner_was_hibernating then
			for i = 1, num_enabled_spawners, 1 do
				if enabled_spawners[i] == spawner then
					enabled_spawners[i] = enabled_spawners[num_enabled_spawners]
					enabled_spawners[num_enabled_spawners] = nil
					disabled_spawners[spawner] = true
				end
			end
		else
			print("Can't hibernate spawner, it was already hibernating!")
		end
	elseif spawner_was_hibernating then
		disabled_spawners[spawner] = nil
		enabled_spawners[#enabled_spawners + 1] = spawner
	else
		print("Can't wake up spawner, it wasn't hibernating")
	end

	return 
end
SpawnerSystem.register_raw_spawner = function (self, spawner, terror_event_id)
	if terror_event_id then
		local lookup = self._raw_id_lookup[terror_event_id]

		if not lookup then
			lookup = {}
			self._raw_id_lookup[terror_event_id] = lookup
		end

		lookup[#lookup + 1] = spawner
	end

	return 
end
local spawn_list = {}
local copy_list = {}
SpawnerSystem.spawn_horde = function (self, spawner, amount, breeds, breed_list, group_template)
	local extension = ScriptUnit.extension(spawner, "spawner_system")
	self._active_spawners[spawner] = extension

	if breed_list then
		if group_template then
			table.clear(spawn_list)

			local num_to_spawn = #breed_list

			for i = 1, num_to_spawn, 1 do
				local breed_name = breed_list[i]
				breed_data = {
					breed_name,
					group_template
				}
				spawn_list[i] = breed_data
			end

			extension.on_activate(extension, amount, breeds, spawn_list)
		else
			extension.on_activate(extension, amount, breeds, breed_list)
		end
	else
		extension.on_activate(extension, amount, breeds)
	end

	self._waiting_to_spawn = self._waiting_to_spawn + amount
	local spawn_rate = extension.spawn_rate(extension)

	return spawn_rate
end

local function copy_array(source, index_a, index_b, dest)
	local j = 1

	for i = index_a, index_b, 1 do
		dest[j] = source[i]
		j = j + 1
	end

	return 
end

SpawnerSystem.spawn_horde_from_terror_event_id = function (self, event_id, composition_type, limit_spawners, group_template)
	local ConflictUtils = ConflictUtils
	local spawners = nil
	local dont_remove_this = math.random()

	if event_id and event_id ~= "" then
		local source_spawners = self._id_lookup[event_id]

		if not source_spawners then
			assert("No horde spawners found with terror_id ", event_id)

			return 
		end

		spawners = {}

		copy_array(source_spawners, 1, #source_spawners, spawners)
	else
		spawners = ConflictUtils.filter_horde_spawners(player_positions, self._enabled_spawners, 10, 35)

		if not spawners then
			print("No horde spawners found within range for terror event ", event_id)

			return 
		end
	end

	local num_spawners = #spawners

	if num_spawners == 0 then
		return false
	end

	local composition = CurrentHordeSettings.compositions[composition_type]
	local index = LoadedDice.roll_easy(composition.loaded_probs)
	local variant = composition[index]
	local breed_list = variant.breeds
	local spawn_list = spawn_list

	table.clear_array(spawn_list, #spawn_list)

	if script_data.debug_hordes then
		print("Spawning horde from terror event id: '" .. tostring(event_id) .. "', composition_type: " .. tostring(composition_type) .. ", limit_spawners: " .. tostring(limit_spawners))
	end

	for i = 1, #breed_list, 2 do
		local breed_name = breed_list[i]
		local amount = breed_list[i + 1]
		local num_to_spawn = ConflictUtils.random_interval(amount)

		if script_data.debug_hordes then
			print("\t ...will spawn " .. num_to_spawn .. " of " .. breed_name .. "( " .. amount[1] .. "->" .. amount[2] .. " )")
		end

		local start = #spawn_list

		if group_template then
			group_template.size = group_template.size + num_to_spawn
			breed_data = {
				breed_name,
				group_template
			}

			for j = start + 1, start + num_to_spawn, 1 do
				spawn_list[j] = breed_data
			end
		else
			for j = start + 1, start + num_to_spawn, 1 do
				spawn_list[j] = breed_name
			end
		end
	end

	table.shuffle(spawners)

	if limit_spawners then
		for i = limit_spawners + 1, num_spawners, 1 do
			spawners[i] = nil
		end

		num_spawners = #spawners
	end

	table.shuffle(spawn_list)

	local total_amount = #spawn_list
	local count = total_amount
	local start_index = 1

	for i = 1, num_spawners, 1 do
		local to_spawn = math.floor(total_amount/(num_spawners - i + 1))

		if script_data.debug_hordes then
			print("\t spawner " .. i .. " gets " .. to_spawn .. " rats.")
		end

		total_amount = total_amount - to_spawn
		local spawner = spawners[i]
		local extension = ScriptUnit.extension(spawner, "spawner_system")
		self._active_spawners[spawner] = extension

		table.clear_array(copy_list, #copy_list)
		copy_array(spawn_list, start_index, (start_index + to_spawn) - 1, copy_list)
		extension.on_activate(extension, to_spawn, nil, copy_list)

		start_index = start_index + to_spawn
	end

	if 0 < count then
		return true, count
	end

	return 
end
SpawnerSystem.change_spawner_id = function (self, unit, spawner_id, new_spawner_id)
	if unit then
		local old_id = Unit.get_data(unit, "terror_event_id")

		if old_id ~= "" and old_id == new_spawner_id then
			return 
		end

		local old_spawners = self._id_lookup[old_id]

		if old_spawners then
			local num_spawners = #old_spawners

			for i = 1, num_spawners, 1 do
				if old_spawners[i] == unit then
					old_spawners[i] = old_spawners[num_spawners]
					old_spawners[num_spawners] = nil

					break
				end
			end
		end

		local new_spawners = self._id_lookup[new_spawner_id]

		if not new_spawners then
			new_spawners = {}
			self._id_lookup[new_spawners] = new_spawners
		end

		new_spawners[#new_spawners + 1] = unit

		Unit.set_data(unit, "terror_event_id", new_spawner_id)

		return 
	end

	local spawners = self._id_lookup[spawner_id]
	local new_spawners = self._id_lookup[new_spawner_id]

	if not new_spawners then
		new_spawners = {}
		self._id_lookup[new_spawners] = new_spawners
	end

	if spawners then
		local old_start_index = #spawners
		local new_start_index = #new_spawners

		for i = 1, old_start_index, 1 do
			new_spawners[new_start_index + i] = spawners[i]

			Unit.set_data(spawners[i], "terror_event_id", new_spawner_id)

			spawners[i] = nil
		end
	else
		print("Can't find spawners called: ", spawner_id, " so cannot rename any")
	end

	return 
end
SpawnerSystem.get_raw_spawner_unit = function (self, terror_id)
	local spawners = self._raw_id_lookup[terror_id]

	if spawners then
		local spawner_unit = spawners[math.random(1, #spawners)]

		return spawner_unit
	end

	return 
end
SpawnerSystem.deactivate_spawner = function (self, spawner)
	self._active_spawners[spawner] = nil

	return 
end
SpawnerSystem.debug_show_spawners = function (self, t, spawners)
	local h = 70
	local add_height = Vector3(0, 0, h)
	local color = Color(255, 0, 200, 0)

	for unit, _ in pairs(spawners) do
		local pos = Unit.local_position(unit, 0)

		QuickDrawer:line(pos, pos + add_height, color)

		local d = t%10*7

		QuickDrawer:sphere(pos + Vector3(0, 0, d), 0.5, color)
		QuickDrawer:sphere(pos + Vector3(0, 0, (d + 10)%h), 0.5, color)
		QuickDrawer:sphere(pos + Vector3(0, 0, (d + 20)%h), 0.5, color)
	end

	return 
end
SpawnerSystem.set_spawn_list = function (self, list)
	self._spawn_list = list

	return 
end
SpawnerSystem.pop_pawn_list = function (self)
	local spawn_list = self._spawn_list
	local size = #spawn_list

	if size <= 0 then
		return 
	end

	local breed = spawn_list[size]
	spawn_list[size] = nil

	return breed
end
SpawnerSystem.add_waiting_to_spawn = function (self, amount)
	self._waiting_to_spawn = self._waiting_to_spawn + amount

	return 
end
SpawnerSystem.waiting_to_spawn = function (self)
	return self._waiting_to_spawn
end
local dummy_input = {}
local found_hidden_spawners = {}
SpawnerSystem.update = function (self, context, t, dt)
	for unit, extension in pairs(self._active_spawners) do
		extension.update(extension, unit, dummy_input, dt, context, t)
	end

	if script_data.show_hidden_spawners then
		self.show_hidden_spawners(self, t)
	end

	return 
end
SpawnerSystem.show_hidden_spawners = function (self, t)
	local unit_local_position = Unit.local_position
	local center_pos = PLAYER_POSITIONS[1]
	local free_flight_manager = Managers.free_flight
	local in_free_flight = free_flight_manager.active(free_flight_manager, "global")

	if in_free_flight then
		center_pos = free_flight_manager.camera_position_rotation(free_flight_manager)
	end

	local s = math.sin(t*10)
	local color = Color(s*64 + 192, s*64 + 192, 0)
	local fail_color = Color(s*64 + 192, 0, 0)
	local amount = 0
	local bad = 0
	local radius = 40

	if center_pos then
		local nav_world = Managers.state.entity:system("ai_system"):nav_world()
		amount = Broadphase.query(self.hidden_spawners_broadphase, center_pos, radius, found_hidden_spawners)
		local spinn = math.sin(t*5)*0.33
		local spinn_vec = Vector3(spinn, spinn, 0)
		local h_pos = Vector3(spinn, spinn, 30)

		for i = 1, amount, 1 do
			local spawner_unit = found_hidden_spawners[i]
			local pos = unit_local_position(spawner_unit, 0)
			local is_position_on_navmesh = GwNavQueries.triangle_from_position(nav_world, pos, 0.5, 0.5)

			if is_position_on_navmesh then
				QuickDrawer:line(pos + spinn_vec, pos + h_pos, color)
				QuickDrawer:sphere(pos, 0.15, color)
			else
				QuickDrawer:line(pos + spinn_vec, pos + h_pos, fail_color)
				QuickDrawer:sphere(pos, 0.15, color)

				bad = bad + 1
			end
		end
	end

	if bad == 0 then
		Debug.text("This level has %d hidden spawners. (%d within %d meters)", self._num_hidden_spawners, amount, radius)

		if center_pos then
			QuickDrawer:circle(center_pos + Vector3(0, 0, 20), radius, Vector3.up(), color)
		end
	else
		Debug.text("This level has %d hidden spawners. (%d within %d meters, %d are not on nav-mesh)", self._num_hidden_spawners, amount, radius, bad)

		if center_pos then
			QuickDrawer:circle(center_pos + Vector3(0, 0, 20), radius, Vector3.up(), fail_color)
		end
	end

	return 
end

return 
