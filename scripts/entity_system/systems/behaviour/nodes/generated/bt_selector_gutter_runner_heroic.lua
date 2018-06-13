require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local unit_alive = Unit.alive
local Profiler = Profiler

local function nop()
	return
end

BTSelector_gutter_runner_heroic = class(BTSelector_gutter_runner_heroic, BTNode)
BTSelector_gutter_runner_heroic.name = "BTSelector_gutter_runner_heroic"

BTSelector_gutter_runner_heroic.init = function (self, ...)
	BTSelector_gutter_runner_heroic.super.init(self, ...)

	self._children = {}
end

BTSelector_gutter_runner_heroic.leave = function (self, unit, blackboard, t, reason)
	self:set_running_child(unit, blackboard, t, nil, reason)
end

BTSelector_gutter_runner_heroic.run = function (self, unit, blackboard, t, dt)
	local Profiler_start = Profiler.start
	local Profiler_stop = Profiler.stop
	local child_running = self:current_running_child(blackboard)
	local children = self._children
	local node_falling = children[1]
	local condition_result = not blackboard.high_ground_opportunity and not blackboard.pouncing_target and (blackboard.is_falling or blackboard.fall_state ~= nil)

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_falling, "aborted")
		Profiler_start("falling")

		local result, evaluate = node_falling:run(unit, blackboard, t, dt)

		Profiler_stop("falling")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_falling == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_uninterruptable_ninja_vanish = children[2]
	local condition_result = blackboard.ninja_vanish_at_health_percent and ScriptUnit.extension(blackboard.unit, "health_system"):current_health_percent() < blackboard.ninja_vanish_at_health_percent

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_uninterruptable_ninja_vanish, "aborted")
		Profiler_start("uninterruptable_ninja_vanish")

		local result, evaluate = node_uninterruptable_ninja_vanish:run(unit, blackboard, t, dt)

		Profiler_stop("uninterruptable_ninja_vanish")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_uninterruptable_ninja_vanish == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_stagger = children[3]
	local condition_result = nil

	if blackboard.stagger then
		condition_result = not blackboard.is_climbing
	end

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_stagger, "aborted")
		Profiler_start("stagger")

		local result, evaluate = node_stagger:run(unit, blackboard, t, dt)

		Profiler_stop("stagger")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_stagger == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_spawn = children[4]
	local condition_result = blackboard.spawn

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_spawn, "aborted")
		Profiler_start("spawn")

		local result, evaluate = node_spawn:run(unit, blackboard, t, dt)

		Profiler_stop("spawn")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_spawn == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_smartobject = children[5]
	local condition_result = nil

	if blackboard.jump_data then
		condition_result = false
	end

	if condition_result == nil then
		condition_result = BTConditions.at_smartobject(blackboard)
	end

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_smartobject, "aborted")
		Profiler_start("smartobject")

		local result, evaluate = node_smartobject:run(unit, blackboard, t, dt)

		Profiler_stop("smartobject")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_smartobject == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_ninja_vanish = children[6]
	local condition_result = blackboard.ninja_vanish

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_ninja_vanish, "aborted")
		Profiler_start("ninja_vanish")

		local result, evaluate = node_ninja_vanish:run(unit, blackboard, t, dt)

		Profiler_stop("ninja_vanish")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_ninja_vanish == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_throw_throwing_stars = children[7]
	local condition_result = Unit.alive(blackboard.throw_projectile_at) or blackboard.throw_data

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_throw_throwing_stars, "aborted")
		Profiler_start("throw_throwing_stars")

		local result, evaluate = node_throw_throwing_stars:run(unit, blackboard, t, dt)

		Profiler_stop("throw_throwing_stars")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_throw_throwing_stars == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_approach_target = children[8]
	local condition_result = blackboard.target_unit or blackboard.comitted_to_target

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_approach_target, "aborted")
		Profiler_start("approach_target")

		local result, evaluate = node_approach_target:run(unit, blackboard, t, dt)

		Profiler_stop("approach_target")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_approach_target == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_abide = children[9]
	local condition_result = blackboard.target_unit or blackboard.secondary_target

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_abide, "aborted")
		Profiler_start("abide")

		local result, evaluate = node_abide:run(unit, blackboard, t, dt)

		Profiler_stop("abide")

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_abide == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_idle = children[10]

	self:set_running_child(unit, blackboard, t, node_idle, "aborted")
	Profiler_start("idle")

	local result, evaluate = node_idle:run(unit, blackboard, t, dt)

	Profiler_stop("idle")

	if result ~= "running" then
		self:set_running_child(unit, blackboard, t, nil, result)
	end

	if result ~= "failed" then
		return result, evaluate
	end
end

BTSelector_gutter_runner_heroic.add_child = function (self, node)
	self._children[#self._children + 1] = node
end

return
