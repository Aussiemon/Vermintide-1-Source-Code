require("scripts/settings/level_settings")

DarknessSystem = class(DarknessSystem, ExtensionSystemBase)
local extensions = {
	"LightSourceExtension",
	"PlayerUnitDarknessExtension"
}
DarknessSystem.DARKNESS_THRESHOLD = 0.025
DarknessSystem.TOTAL_DARKNESS_TRESHOLD = 0.0125

DarknessSystem.init = function (self, entity_system_creation_context, system_name)
	DarknessSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	self._light_source_data = {}
	self._player_unit_darkness_data = {}
	local level_settings = LevelHelper:current_level_settings()
	local darkness_settings = level_settings.darkness_settings

	if darkness_settings then
		local volumes = darkness_settings.volumes

		assert(volumes, "Missing volumes table in darkness settings.")

		self._darkness_volumes = volumes
		self._num_volumes = #volumes
		local local_player_light_intensity = darkness_settings.local_player_light_intensity

		if local_player_light_intensity then
			self:set_local_players_light_intensity(local_player_light_intensity)
		end
	else
		self._num_volumes = 0
	end

	self._in_darkness = false
	self._screen_fx_name = "fx/screenspace_darkness_flash"
	self._global_darkness = false
end

DarknessSystem.set_global_darkness = function (self, set)
	self._global_darkness = set
end

DarknessSystem.set_local_players_light_intensity = function (self, intensity)
	self._local_players_light_intensity = intensity
end

DarknessSystem.set_level = function (self, level)
	self._level = level
end

DarknessSystem.destroy = function (self)
	self._environment_handler = nil
end

DarknessSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local extension = {
		intensity = (extension_init_data and extension_init_data.intensity) or 1
	}

	ScriptUnit.set_extension(unit, self.name, extension)

	if extension_name == "LightSourceExtension" then
		self._light_source_data[unit] = extension
		POSITION_LOOKUP[unit] = Unit.world_position(unit, 0)
	elseif extension_name == "PlayerUnitDarknessExtension" then
		self._player_unit_darkness_data[unit] = extension
	end

	return extension
end

DarknessSystem.on_remove_extension = function (self, unit, extension_name)
	DarknessSystem.super.on_remove_extension(self, unit, extension_name)

	if extension_name == "LightSourceExtension" then
		self._light_source_data[unit] = nil
		POSITION_LOOKUP[unit] = nil
	elseif extension_name == "PlayerUnitDarknessExtension" then
		self._player_unit_darkness_data[unit] = nil
	end
end

DarknessSystem.update = function (self, context, t)
	local dt = context.dt

	if self._darkness_volumes or self._global_darkness then
		self:_update_light_sources(dt, t)
		self:_update_player_unit_darkness(dt, t)
		self:_update_darkness_fx(dt, t)
	end
end

DarknessSystem._update_light_sources = function (self, dt, t)
	if script_data.debug_darkness then
		for unit, data in pairs(self._light_source_data) do
			local source_pos = POSITION_LOOKUP[unit]
			local intensity = data.intensity

			for i = 1, 10, 1 do
				local dist = math.max(i * 0.5, 1)
				local brightness = math.min(255, (255 * intensity) / (dist * dist))
				local color = Color(brightness, brightness, brightness)

				QuickDrawer:circle(source_pos + Vector3(0, 0, 0.05), dist, Vector3.up(), color, 16)
			end

			QuickDrawer:circle(source_pos + Vector3(0, 0, 0.05), math.sqrt(intensity / DarknessSystem.DARKNESS_THRESHOLD), Vector3.up(), Color(255, 0, 0), 16)
		end
	end
end

local IN = nil
LIGHT_LIGHT_VALUE = 0.05
local IN_TWILIGHT_LIGHT_VALUE = 0.015
local TWILIGHT_MAX_INTENSITY = 0.15

local function LIGHT_TO_DARKNESS_INTENSITY_CONVERSION_FUNCTION(light_value)
	local darkness = (1 - light_value / IN_TWILIGHT_LIGHT_VALUE)^2

	return darkness / 15
end

DarknessSystem._update_player_unit_darkness = function (self, dt, t)
	for unit, data in pairs(self._player_unit_darkness_data) do
		local pos = POSITION_LOOKUP[unit] + Vector3(0, 0, 1)
		local in_darkness = self:is_in_darkness_volume(pos)
		local light_value = nil

		if in_darkness then
			light_value = self:calculate_light_value(pos)

			if LIGHT_LIGHT_VALUE < light_value then
				data.intensity = 0
				data.in_darkness = false
			elseif IN_TWILIGHT_LIGHT_VALUE < light_value then
				data.intensity = math.auto_lerp(LIGHT_LIGHT_VALUE, IN_TWILIGHT_LIGHT_VALUE, 0, TWILIGHT_MAX_INTENSITY, light_value)
				data.in_darkness = true
			else
				data.intensity = math.min(math.max(data.intensity, TWILIGHT_MAX_INTENSITY) + dt * LIGHT_TO_DARKNESS_INTENSITY_CONVERSION_FUNCTION(light_value), 1)
				data.in_darkness = true
			end
		else
			data.in_darkness = false
			data.intensity = 0
		end

		if script_data.debug_darkness then
			Debug.text("dark: %s intensity: %f light: %f", tostring(data.in_darkness), data.intensity, light_value or 0)
		end
	end
end

local SOURCE_ID = 0

DarknessSystem._update_darkness_fx = function (self, dt, t)
	local player_manager = Managers.player
	local player = player_manager:local_player(1)

	if player then
		local world = self.world
		local camera_unit = player.camera_follow_unit
		local camera_extension = ScriptUnit.extension(camera_unit, "camera_system")
		local observed_player_id = camera_extension:get_observed_player_id()
		local unit = nil
		local observed_player = observed_player_id and player_manager:players()[observed_player_id]

		if observed_player and Unit.alive(observed_player.player_unit) then
			unit = observed_player.player_unit
		else
			unit = player.player_unit
		end

		local data = self._player_unit_darkness_data[unit]
		local in_darkness = data and data.in_darkness
		local intensity = (data and data.intensity) or 0
		local wwise_world = Managers.world:wwise_world(world)

		if not in_darkness and self._in_darkness then
			WwiseWorld.trigger_event(wwise_world, "Stop_music_darkness_will_take_you", SOURCE_ID)

			self._in_darkness = false

			WwiseWorld.set_source_parameter(wwise_world, SOURCE_ID, "darkness_intensity", 0)

			local id = self._screen_fx_id

			if id then
				World.destroy_particles(world, id)
			end
		elseif in_darkness and not self._in_darkness then
			WwiseWorld.trigger_event(wwise_world, "Play_music_darkness_will_take_you", SOURCE_ID)

			self._in_darkness = true

			WwiseWorld.set_source_parameter(wwise_world, SOURCE_ID, "darkness_intensity", intensity * 100)

			local fx = self._screen_fx_name

			if fx then
				local id = World.create_particles(world, fx, Vector3.zero())
				local material_name = "overlay"
				local variable_name = "intensity"

				World.set_particles_material_scalar(world, id, material_name, variable_name, intensity)

				self._screen_fx_id = id
			end
		elseif in_darkness then
			WwiseWorld.set_source_parameter(wwise_world, SOURCE_ID, "darkness_intensity", intensity * 100)

			local id = self._screen_fx_id

			if id then
				local material_name = "overlay"
				local variable_name = "intensity"

				World.set_particles_material_scalar(world, id, material_name, variable_name, intensity)
			end
		end
	end
end

DarknessSystem.is_in_darkness_volume = function (self, position)
	if self._global_darkness then
		return true
	end

	local volumes = self._darkness_volumes

	if volumes then
		local is_inside_func = Level.is_point_inside_volume
		local level = self._level

		for i = 1, self._num_volumes, 1 do
			local vol_name = volumes[i]

			if is_inside_func(level, vol_name, position) then
				return true
			end
		end
	end

	return false
end

DarknessSystem.calculate_light_value = function (self, position)
	local light_value = 0

	for unit, data in pairs(self._light_source_data) do
		local pos = POSITION_LOOKUP[unit]
		local dist_sq = math.max(Vector3.distance_squared(position, pos), 1)
		local intensity = data.intensity
		light_value = light_value + intensity * 1 / dist_sq
	end

	local local_player_intensity = self._local_players_light_intensity

	if local_player_intensity then
		local player_manager = Managers.player
		local player = player_manager:local_player(1)
		local player_unit = player and player.player_unit

		if Unit.alive(player_unit) then
			local pos = POSITION_LOOKUP[player_unit]
			local dist_sq = math.max(Vector3.distance_squared(position, pos), 1)
			light_value = light_value + local_player_intensity * 1 / dist_sq
		end
	end

	return light_value
end

DarknessSystem.is_in_darkness = function (self, position, darkness_treshold)
	if not self:is_in_darkness_volume(position) then
		return false
	end

	local light_value = self:calculate_light_value(position)

	return light_value < (darkness_treshold or DarknessSystem.DARKNESS_THRESHOLD)
end

return
