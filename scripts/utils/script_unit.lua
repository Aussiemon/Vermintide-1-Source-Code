ScriptUnit = ScriptUnit or {}
ScriptUnit.destroy_extension = function (unit, system_name)
	local extension = ScriptUnit.extension(unit, system_name)

	if extension.destroy then
		extension.destroy(extension)
	end

	return 
end
ScriptUnit.optimize = function (unit)
	if Unit.alive(unit) then
		local disable_shadows = Unit.get_data(unit, "disable_shadows")

		if disable_shadows then
			local num_meshes = Unit.num_meshes(unit)

			for i = 0, num_meshes - 1, 1 do
				Unit.set_mesh_visibility(unit, i, false, "shadow_caster")
			end
		end

		local disable_physics = Unit.get_data(unit, "disable_physics")

		if disable_physics then
			local num_actors = Unit.num_actors(unit)

			for i = 0, num_actors - 1, 1 do
				Unit.destroy_actor(unit, i)
			end
		end
	end

	return 
end

return 
