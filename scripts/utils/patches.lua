if rawget(_G, "G_GAME_PATCHES_RUN") then
	return 
end

rawset(_G, "G_GAME_PATCHES_RUN", true)

if not rawget(_G, "G_IS_PROFILING") and Application.platform() == "win32" and Application.build() ~= "release" then
	local tostring = tostring

	rawset(_G, "G_unit_information", rawget(_G, "G_unit_information") or {})

	local wrapped_tostring = tostring
	local World_spawn_unit = World.spawn_unit
	local World_destroy_unit = World.destroy_unit
	World.spawn_unit = function (world, unit_name, pos, rot)
		local unit = World_spawn_unit(world, unit_name, pos, rot)
		G_unit_information[unit] = wrapped_tostring(unit)

		return unit
	end

	function unitaux_register_unit_info(unit)
		G_unit_information[unit] = tostring(unit)

		return 
	end

	local Unit_alive = Unit.alive

	function unit_alive_info(unit)
		return tostring(G_unit_information[unit])
	end

	local function to_map(t)
		local r = {}

		for _, v in ipairs(t) do
			r[v] = true
		end

		return r
	end

	local exclude_from_patching = to_map({
		"alive",
		"remove_decal",
		"material_id",
		"resource_name_hash"
	})

	for function_name, org_func in pairs(Unit) do
		if exclude_from_patching[function_name] then
		else
			Unit[function_name] = function (unit, ...)
				if unit == nil then
					local args = ""
					local num_args = select("#", ...)

					for i = 1, num_args, 1 do
						local arg_value = select(i, ...)
						local arg_value_str = tostring(arg_value)
						args = string.format("%s %s", args, arg_value_str)
					end

					assert(false, "Tried to access function '%s' for nil unit!", function_name)
				end

				local is_alive = Unit_alive(unit)

				if is_alive then
					return org_func(unit, ...)
				end

				local err_unit = unit_alive_info(unit)
				local args = ""
				local num_args = select("#", ...)

				for i = 1, num_args, 1 do
					local arg_value = select(i, ...)
					local arg_value_str = tostring(arg_value)
					args = string.format("%s %s", args, arg_value_str)
				end

				printf("ARGS: %s", args)
				assert(false, sprintf("[unit_deleted] tried to access function '%s' for deleted unit(%s)!", function_name, err_unit))

				return 
			end
		end
	end

	function tostring(...)
		return wrapped_tostring(...)
	end
end

__old_nav_raycast = __old_nav_raycast or GwNavQueries.raycast
local UNREALISTIC_VALUE = 10000
GwNavQueries.raycast = function (nav_world, from, to)
	local success, collision_point = __old_nav_raycast(nav_world, from, to)
	local abs = math.abs

	if success then
		return success, collision_point
	else
		local collision_x = abs(collision_point.x)
		local collision_y = abs(collision_point.y)
		local collision_z = abs(collision_point.z)

		if UNREALISTIC_VALUE < collision_x or UNREALISTIC_VALUE < collision_y or UNREALISTIC_VALUE < collision_z then
			Application.warning("GwNavQueries returned an unrealistic value, falling back to raycast origin")

			return false, from
		else
			return false, collision_point
		end
	end

	return 
end

return 
