AIGroupTemplates = {
	mini_patrol = {
		pre_unit_init = function (unit, group)
			local blackboard = Unit.get_data(unit, "blackboard")
			blackboard.sneaky = true
		end,
		init = function (world, nav_world, group, t, unit)
			return
		end,
		update = function (world, nav_world, group, t)
			return
		end,
		destroy = function (world, nav_world, group)
			Managers.state.conflict:mini_patrol_killed(group.id)
		end
	},
	horde = {
		pre_unit_init = function (unit, group)
			if group.sneaky then
				local blackboard = Unit.get_data(unit, "blackboard")
				blackboard.sneaky = true
			end
		end,
		init = function (world, nav_world, group, t, unit)
			return
		end,
		update = function (world, nav_world, group, t)
			return
		end,
		destroy = function (world, nav_world, group)
			return
		end
	}
}

return
