local release_build = BUILD == "release"
local script_data = script_data
script_data.disable_debug_position_lookup = (release_build and true) or nil
local unit_alive = Unit.alive

local function ignore_ai_target(unit)
	if ScriptUnit.has_extension(unit, "status_system") then
		local status_extension = ScriptUnit.extension(unit, "status_system")

		return status_extension:is_ready_for_assisted_respawn()
	end

	return false
end

RESOLUTION_LOOKUP = RESOLUTION_LOOKUP or {}
POSITION_LOOKUP = POSITION_LOOKUP or Script.new_map(256)
BLACKBOARDS = BLACKBOARDS or {}
local position_lookup = POSITION_LOOKUP
local position_lookup_backup = {}
local resolution_lookup = RESOLUTION_LOOKUP

function CLEAR_POSITION_LOOKUP()
	table.clear(position_lookup)
	table.clear(position_lookup_backup)
end

local world_position = Unit.world_position

function UPDATE_POSITION_LOOKUP()
	Profiler.start("UPDATE_POSITION_LOOKUP")
	EngineOptimized.update_position_lookup(position_lookup)
	Profiler.stop("UPDATE_POSITION_LOOKUP")

	if script_data.debug_enabled and not script_data.disable_debug_position_lookup then
		for unit, _ in pairs(position_lookup) do
			position_lookup_backup[unit] = world_position(unit, 0)
		end
	end
end

function UPDATE_RESOLUTION_LOOKUP(force_update)
	Profiler.start("UPDATE_RESOLUTION_LOOKUP")

	local w, h = Application.resolution()
	local resolution_modified = w ~= resolution_lookup.res_w or h ~= resolution_lookup.res_h

	if resolution_modified or force_update then
		resolution_lookup.res_w = w
		resolution_lookup.res_h = h

		AccomodateViewport()

		resolution_lookup.scale = UIResolutionScale() * UISettings.ui_scale / 100
		resolution_lookup.inv_scale = 1 / resolution_lookup.scale
	end

	resolution_lookup.modified = resolution_modified

	Profiler.stop("UPDATE_RESOLUTION_LOOKUP")
end

local cleared = false

function VALIDATE_POSITION_LOOKUP()
	if not script_data.debug_enabled then
		return
	end

	if script_data.disable_debug_position_lookup then
		if not cleared then
			script_data.position_lookup_backup = {}
			cleared = true
		end

		return
	end

	Profiler.start("VALIDATE_POSITION_LOOKUP")

	cleared = false

	for unit, pos in pairs(position_lookup) do
		local alive, info = unit_alive(unit)

		assert(alive, "Unit was destroyed but not removed from POSITION_LOOKUP ", tostring(info))

		local other_pos = position_lookup_backup[unit]

		if other_pos and Vector3.distance_squared(pos, other_pos) > 0.0001 then
			assert(false, "Modified cached vector3, bad coder!! [%s ==> %s]", tostring(other_pos), tostring(pos))
		end
	end

	table.clear(position_lookup_backup)
	Profiler.stop("VALIDATE_POSITION_LOOKUP")
end

PLAYER_UNITS = {}
PLAYER_POSITIONS = {}
PLAYER_AND_BOT_UNITS = {}
PLAYER_AND_BOT_POSITIONS = {}
VALID_PLAYERS_AND_BOTS = {}
AI_TARGET_UNITS = {}

local function is_valid(unit)
	return unit_alive(unit) and not ScriptUnit.extension(unit, "status_system").ready_for_assisted_respawn
end

function UPDATE_PLAYER_LISTS()
	local human_units = PLAYER_UNITS
	local human_unit_positions = PLAYER_POSITIONS
	local human_and_bot_units = PLAYER_AND_BOT_UNITS
	local human_and_bot_unit_positions = PLAYER_AND_BOT_POSITIONS
	local valid_humans_and_bots = VALID_PLAYERS_AND_BOTS

	table.clear(valid_humans_and_bots)

	local players = Managers.player:human_and_bot_players()
	local num_human_units = 0
	local num_human_and_bot_units = 0

	for _, player in pairs(players) do
		local unit = player.player_unit

		if is_valid(unit) then
			local pos = position_lookup[unit]
			num_human_and_bot_units = num_human_and_bot_units + 1
			human_and_bot_units[num_human_and_bot_units] = unit
			human_and_bot_unit_positions[num_human_and_bot_units] = pos
			valid_humans_and_bots[unit] = true

			if player:is_player_controlled() then
				num_human_units = num_human_units + 1
				human_units[num_human_units] = unit
				human_unit_positions[num_human_units] = pos
			end
		end
	end

	local i = num_human_units + 1

	while human_units[i] do
		human_units[i] = nil
		human_unit_positions[i] = nil
		i = i + 1
	end

	local k = num_human_and_bot_units + 1

	while human_and_bot_units[k] do
		human_and_bot_units[k] = nil
		human_and_bot_unit_positions[k] = nil
		k = k + 1
	end

	local ai_target_units = AI_TARGET_UNITS
	local aggro_system = Managers.state.entity:system("aggro_system")
	local aggroable_units = aggro_system.aggroable_units
	local ai_unit_alive = AiUtils.unit_alive
	local j = 1

	for unit, _ in pairs(aggroable_units) do
		if ai_unit_alive(unit) and not ignore_ai_target(unit) then
			ai_target_units[j] = unit
			j = j + 1
		end
	end

	while ai_target_units[j] do
		ai_target_units[j] = nil
		j = j + 1
	end
end

function REMOVE_PLAYER_UNIT_FROM_LISTS(player_unit)
	local player_units = PLAYER_UNITS
	local player_positions = PLAYER_POSITIONS
	local size = #player_units

	for i = 1, size, 1 do
		if player_unit == player_units[i] then
			player_units[i] = player_units[size]
			player_units[size] = nil
			player_positions[i] = player_positions[size]
			player_positions[size] = nil

			break
		end
	end

	VALID_PLAYERS_AND_BOTS[player_unit] = nil
	local player_and_bot_units = PLAYER_AND_BOT_UNITS
	local player_and_bot_positions = PLAYER_AND_BOT_POSITIONS
	local ai_target_units = AI_TARGET_UNITS
	local ai_target_units_size = #ai_target_units
	size = #player_and_bot_units

	for i = 1, size, 1 do
		if player_unit == player_and_bot_units[i] then
			player_and_bot_units[i] = player_and_bot_units[size]
			player_and_bot_units[size] = nil
			player_and_bot_positions[i] = player_and_bot_positions[size]
			player_and_bot_positions[size] = nil
			ai_target_units[i] = ai_target_units[ai_target_units_size]
			ai_target_units[ai_target_units_size] = nil

			break
		end
	end
end

function REMOVE_AGGRO_UNITS(aggro_unit)
	local ai_target_units = AI_TARGET_UNITS
	local size = #ai_target_units

	for i = 1, size, 1 do
		if aggro_unit == ai_target_units[i] then
			ai_target_units[i] = ai_target_units[size]
			ai_target_units[size] = nil

			break
		end
	end
end

return
