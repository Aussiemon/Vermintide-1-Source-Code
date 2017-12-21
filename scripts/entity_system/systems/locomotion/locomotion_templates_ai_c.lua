LocomotionTemplates.AILocomotionExtensionC = {
	init = function (data, nav_world)
		return 
	end,
	update = function (data, t, dt)
		local units_to_kill = EngineOptimizedExtensions.ai_locomotion_update(t, dt)

		if units_to_kill then
			local ScriptUnit_extension = ScriptUnit.extension
			local conflict_director = Managers.state.conflict

			for i = 1, #units_to_kill, 1 do
				local unit = units_to_kill[i]
				local ai_extension = ScriptUnit_extension(unit, "ai_system")
				local blackboard = ai_extension._blackboard

				conflict_director.destroy_unit(conflict_director, unit, blackboard, "out_of_range")
			end
		end

		return 
	end
}

return 
