local font_size = 26
local font_size_blackboard = 16
local font = "gw_arial_32"
local font_mtrl = "materials/fonts/" .. font
local NUM_OF_SECTORS = 4
local RPCS = {
	"rpc_enemy_has_target"
}
local extensions = {
	"SoundSectorExtension"
}
SoundSectorSystem = class(SoundSectorSystem, ExtensionSystemBase)
SoundSectorSystem.init = function (self, context, system_name)
	self.unit_storage = context.unit_storage
	local entity_manager = context.entity_manager

	entity_manager.register_system(entity_manager, self, system_name, extensions)

	self.world = context.world
	self.wwise_world = Managers.world:wwise_world(self.world)
	local network_event_delegate = context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))

	self.unit_input_data = {}
	self.unit_extension_data = {}
	self.entities = {}
	self._sectors = {}
	self._sector_sound_source_ids = {}
	self._sector_sound_source_units = {}
	self._sector_process_index = 0

	for i = 1, NUM_OF_SECTORS, 1 do
		self._sectors[i] = {}
		local sound_source_unit = World.spawn_unit(self.world, "units/testunits/camera")
		self._sector_sound_source_units[i] = sound_source_unit
	end

	self.debug_gui_screen = World.create_screen_gui(self.world, "material", "materials/fonts/gw_fonts", "immediate")
	script_data.sound_sector_system_debug = script_data.sound_sector_system_debug or Development.parameter("sound_sector_system_debug")

	return 
end
SoundSectorSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)

	return 
end
SoundSectorSystem.on_add_extension = function (self, world, unit, extension_name)
	local extension = {}
	local input = {}

	ScriptUnit.set_extension(unit, "sound_sector_system", extension, input)

	self.unit_input_data[unit] = input
	self.unit_extension_data[unit] = extension

	if extension_name == "SoundSectorExtension" then
		self.entities[unit] = extension
		local camera_position = Unit.local_position(self.camera_unit, 0)
		local _, sector_index = self.calc_unit_sector(self, camera_position, unit)

		if sector_index then
			self._sectors[sector_index][unit] = unit
		end

		extension.sector_index = sector_index
	end

	return extension
end
SoundSectorSystem.extensions_ready = function (self, world, unit, extension_name)
	if extension_name == "SoundSectorExtension" then
		local extension = self.unit_extension_data[unit]
		local sector_index = extension.sector_index

		if sector_index then
			local death_extension = ScriptUnit.extension(unit, "death_system")
			self._sectors[sector_index][unit] = death_extension
		end
	end

	return 
end
SoundSectorSystem.on_remove_extension = function (self, unit, extension_name)
	self.on_freeze_extension(self, unit, extension_name)
	ScriptUnit.remove_extension(unit, self.NAME)

	return 
end
SoundSectorSystem.on_freeze_extension = function (self, unit, extension_name)
	local extension = self.entities[unit]

	if extension == nil then
		return 
	end

	local unit_sector_index = extension.sector_index

	if unit_sector_index then
		self._sectors[unit_sector_index][unit] = nil
	end

	self.entities[unit] = nil
	self.unit_input_data[unit] = nil
	self.unit_extension_data[unit] = nil

	return 
end
local MIN_NUM_OF_UNITS = 7
SoundSectorSystem.update = function (self, context, t, dt)
	local world = self.world
	local camera_position = Unit.local_position(self.camera_unit, 0)
	local sector_sound_source_ids = self._sector_sound_source_ids

	self.update_sectors(self, camera_position)

	local entities = self.entities
	local sector_sound_source_units = self._sector_sound_source_units
	local wwise_world = self.wwise_world
	local Vector3_zero = Vector3.zero
	local Unit_set_local_position = Unit.set_local_position
	local WwiseWorld_set_source_parameter = WwiseWorld.set_source_parameter
	local number_of_sectors_to_process = (script_data.sound_sector_system_debug and #self._sectors) or 1

	for i = 1, number_of_sectors_to_process, 1 do
		self._sector_process_index = self._sector_process_index % #self._sectors + 1
		local sector_index = self._sector_process_index
		local sector = self._sectors[sector_index]
		local units_center = Vector3_zero()
		local num_of_units_in_sector = 0

		for unit, death_extension in pairs(sector) do
			if not death_extension.has_death_started(death_extension) then
				if not entities[unit].has_target then
				else
					local position = POSITION_LOOKUP[unit]
					units_center = units_center + position
					num_of_units_in_sector = num_of_units_in_sector + 1
				end
			end
		end

		local has_enough_units = MIN_NUM_OF_UNITS <= num_of_units_in_sector
		local wwise_source_id = sector_sound_source_ids[sector_index]
		local is_playing_sound = wwise_source_id ~= nil
		local horde_is_active = Managers.state.conflict:has_horde(t)

		if has_enough_units and horde_is_active then
			units_center = units_center / num_of_units_in_sector
			local sound_source_unit = sector_sound_source_units[sector_index]

			Unit_set_local_position(sound_source_unit, 0, units_center)
			WwiseWorld_set_source_parameter(wwise_world, wwise_source_id, "enemy_count", num_of_units_in_sector)

			if not is_playing_sound then
				self.play_sector_sound_event(self, sector_index, num_of_units_in_sector, units_center)
			end
		elseif is_playing_sound then
			self.stop_sector_sound_event(self, sector_index)
		end

		if script_data.sound_sector_system_debug and has_enough_units then
			self.debug_draw(self, units_center, sector_index, camera_position)
		end
	end

	if script_data.sound_sector_system_debug then
		self.debug_draw_hud(self, camera_position)
	end

	return 
end
SoundSectorSystem.update_sectors = function (self, camera_position)
	for unit, extension in pairs(self.entities) do
		local _, sector_index = self.calc_unit_sector(self, camera_position, unit)
		local unit_sector_index = extension.sector_index

		if unit_sector_index ~= sector_index then
			if unit_sector_index then
				self._sectors[unit_sector_index][unit] = nil
			end

			if sector_index then
				local death_extension = ScriptUnit.extension(unit, "death_system")
				self._sectors[sector_index][unit] = death_extension
			end

			extension.sector_index = sector_index
		end
	end

	return 
end
SoundSectorSystem.play_sector_sound_event = function (self, sector_index, num_of_units_in_sector, units_center)
	local level_settings = LevelHelper:current_level_settings()
	local terrain = level_settings.terrain or "city"
	local sound_source_unit = self._sector_sound_source_units[sector_index]
	local wwise_source_id, wwise_world = WwiseUtils.make_unit_auto_source(self.world, sound_source_unit)

	WwiseWorld.set_switch(self.wwise_world, "area", terrain, wwise_source_id)

	local wwise_playing_id = WwiseWorld.trigger_event(wwise_world, "distant_horde", wwise_source_id)

	Managers.state.entity:system("sound_environment_system"):register_source_environment_update(wwise_source_id, sound_source_unit)

	self._sector_sound_source_ids[sector_index] = wwise_source_id

	return 
end
SoundSectorSystem.stop_sector_sound_event = function (self, sector_index)
	local wwise_source_id = self._sector_sound_source_ids[sector_index]

	Managers.state.entity:system("sound_environment_system"):unregister_source_environment_update(wwise_source_id)
	WwiseWorld.trigger_event(self.wwise_world, "stop_distant_horde", wwise_source_id)

	self._sector_sound_source_ids[sector_index] = nil

	return 
end
local MIN_DISTANCE_THRESHOLD = 5
local MAX_DISTANCE_THRESHOLD = 50
SoundSectorSystem.calc_unit_sector = function (self, camera_position, unit)
	local unit_position = POSITION_LOOKUP[unit]
	local distance = Vector3.distance(camera_position, unit_position)

	if distance < MIN_DISTANCE_THRESHOLD or MAX_DISTANCE_THRESHOLD < distance then
		return false, false
	end

	local pi = math.pi
	local direction_camera_to_unit = Vector3.normalize(unit_position - camera_position)
	local angle = math.atan2(direction_camera_to_unit.y, direction_camera_to_unit.x)
	local num_of_sectors = NUM_OF_SECTORS
	local sector_index = math.max(1, math.ceil((angle + pi) / (2 * pi) * num_of_sectors))

	return angle, sector_index
end
SoundSectorSystem.hot_join_sync = function (self, sender)
	return 
end
SoundSectorSystem.local_player_created = function (self, player)
	self.camera_unit = player.camera_follow_unit

	return 
end
SoundSectorSystem.rpc_enemy_has_target = function (self, sender, unit_id, has_target)
	local unit = self.unit_storage:unit(unit_id)

	if unit == nil then
		return 
	end

	local sound_sector_extension = ScriptUnit.has_extension(unit, "sound_sector_system")

	if sound_sector_extension then
		sound_sector_extension.has_target = has_target
	end

	return 
end
SoundSectorSystem.debug_draw_hud = function (self, camera_position)
	local debug_center = Vector3(200, 200, 2)
	local camera_rotation = Unit.local_rotation(self.camera_unit, 0)
	local camera_fwd_vec = Quaternion.forward(camera_rotation)

	Gui.rect(self.debug_gui_screen, debug_center - Vector3(150, 150, 1), Vector2(300, 300), Color(100, 100, 100, 100))
	Gui.rect(self.debug_gui_screen, debug_center, Vector2(10, 10), Color(100, 100, 255, 100))
	ScriptGUI.hud_line(self.debug_gui_screen, debug_center, debug_center + Vector3.flat(camera_fwd_vec) * 150, 3, 2, Color(255, 0, 255, 0))
	ScriptGUI.hud_line(self.debug_gui_screen, debug_center, debug_center + Vector3(150, 0, 0), 3, 2, Color(255, 0, 100, 0))
	ScriptGUI.hud_line(self.debug_gui_screen, debug_center, debug_center + Vector3(-150, 0, 0), 3, 2, Color(255, 0, 100, 0))
	ScriptGUI.hud_line(self.debug_gui_screen, debug_center, debug_center + Vector3(0, 150, 0), 3, 2, Color(255, 0, 100, 0))
	ScriptGUI.hud_line(self.debug_gui_screen, debug_center, debug_center + Vector3(-0, -150, 0), 3, 2, Color(255, 0, 100, 0))

	return 
end
SoundSectorSystem.debug_draw = function (self, sector_center, sector_index, camera_position)
	if sector_center == false then
		return 
	end

	local debug_center = Vector3(200, 200, 2)
	local distance = Vector3.distance(camera_position, sector_center)
	local direction_camera_to_center = Vector3.normalize(sector_center - camera_position)
	local debug_pos_center = debug_center + Vector3.flat(direction_camera_to_center * distance * 5)

	Gui.text(self.debug_gui_screen, tostring(sector_index), font_mtrl, font_size + 30, font, debug_pos_center, Color(255, 255, 255, 0))

	for unit, _ in pairs(self._sectors[sector_index]) do
		local pose, radius = Unit.box(unit)
		local unit_center = Matrix4x4.translation(pose)
		local distance = Vector3.distance(camera_position, unit_center)
		local direction_camera_to_unit = Vector3.normalize(unit_center - camera_position)
		local debug_pos = debug_center + Vector3.flat(direction_camera_to_unit * distance * 5)

		Gui.text(self.debug_gui_screen, tostring(sector_index), font_mtrl, font_size, font, debug_pos, Color(255, 255, 0, 0))
	end

	return 
end

return 
