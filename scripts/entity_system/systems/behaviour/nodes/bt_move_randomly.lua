require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTMoveRandomly = class(BTMoveRandomly, BTNode)

BTMoveRandomly.init = function (self, ...)
	BTMoveRandomly.super.init(self, ...)
end

local RUMBEL_RADIUS = 10

BTMoveRandomly.setup = function (self, unit, blackboard, profile)
	self:new_goal(unit, blackboard, profile)
end

BTMoveRandomly.new_goal = function (self, unit, blackboard)
	local tries = 0

	while tries < 20 do
		local pos = POSITION_LOOKUP[unit]
		local add_vec = Vector3(RUMBEL_RADIUS, 0, 0)
		pos = pos + Quaternion.rotate(Quaternion(Vector3.up(), math.degrees_to_radians(Math.random(1, 360))), add_vec)
		local level = LevelHelper:current_level(blackboard.world)
		local mesh = Level.navigation_mesh(level)
		local poly = NavigationMesh.find_polygon(mesh, pos)

		if poly then
			local p1, p2, p3 = NavigationMesh.polygon_vertices(mesh, poly)
			p1 = NavigationMesh.vertex(mesh, p1)
			p2 = NavigationMesh.vertex(mesh, p2)
			p3 = NavigationMesh.vertex(mesh, p3)
			local new_pos = (p1 + p2 + p3) / 3
			local goal_pos = Unit.get_data(unit, "goal_pos") or Vector3Box()

			Unit.set_data(unit, "goal_pos", goal_pos)
			goal_pos:store(new_pos)

			break
		end

		tries = tries + 1
	end
end

BTMoveRandomly.run = function (self, unit, blackboard, t)
	local goal_pos = Unit.get_data(unit, "goal_pos")

	if goal_pos then
		local dist = Vector3.distance(goal_pos:unbox(), POSITION_LOOKUP[unit])
		local ai_navigation = ScriptUnit.extension(unit, "ai_navigation_system")

		ai_navigation:move_to(goal_pos:unbox())

		if ai_navigation:reached_last_point() or dist < 5 then
			self:new_goal(unit, blackboard)
		end
	end

	return "success"
end

return
