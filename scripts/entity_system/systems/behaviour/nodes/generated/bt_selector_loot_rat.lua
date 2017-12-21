require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local unit_alive = Unit.alive
local Profiler = Profiler

local function nop()
	return 
end

BTSelector_loot_rat = class(BTSelector_loot_rat, BTNode)
BTSelector_loot_rat.name = "BTSelector_loot_rat"
BTSelector_loot_rat.init = function (self, ...)
	BTSelector_loot_rat.super.init(self, ...)

	self._children = {}

	return 
end
BTSelector_loot_rat.leave = function (self, unit, blackboard, t, reason)
	self.set_running_child(self, unit, blackboard, t, nil, reason)

	return 
end
BTSelector_loot_rat.run = function (self, unit, blackboard, t, dt)
	local Profiler_start = Profiler.start
	local Profiler_stop = Profiler.stop
	local child_running = self.current_running_child(self, blackboard)
	local children = self._children
	local node_spawn = children[1]
	local condition_result = blackboard.spawn

	if condition_result then
		self.set_running_child(self, unit, blackboard, t, node_spawn, "aborted")
		Profiler_start("spawn")

		local result, evaluate = node_spawn.run(node_spawn, unit, blackboard, t, dt)

		Profiler_stop()

		if result ~= "running" then
			self.set_running_child(self, unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_spawn == child_running then
		self.set_running_child(self, unit, blackboard, t, nil, "failed")
	end

	local node_falling = children[2]
	local condition_result = blackboard.is_falling or blackboard.fall_state ~= nil

	if condition_result then
		self.set_running_child(self, unit, blackboard, t, node_falling, "aborted")
		Profiler_start("falling")

		local result, evaluate = node_falling.run(node_falling, unit, blackboard, t, dt)

		Profiler_stop()

		if result ~= "running" then
			self.set_running_child(self, unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_falling == child_running then
		self.set_running_child(self, unit, blackboard, t, nil, "failed")
	end

	local node_stagger = children[3]
	local condition_result = BTConditions.stagger(blackboard) and not blackboard.dodge_damage_success

	if condition_result then
		self.set_running_child(self, unit, blackboard, t, node_stagger, "aborted")
		Profiler_start("stagger")

		local result, evaluate = node_stagger.run(node_stagger, unit, blackboard, t, dt)

		Profiler_stop()

		if result ~= "running" then
			self.set_running_child(self, unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_stagger == child_running then
		self.set_running_child(self, unit, blackboard, t, nil, "failed")
	end

	local node_smartobject = children[4]
	local smartobject_is_next = blackboard.next_smart_object_data.next_smart_object_id ~= nil
	local is_in_smartobject_range = blackboard.is_in_smartobject_range
	local is_smart_objecting = blackboard.is_smart_objecting
	local condition_result = (smartobject_is_next and is_in_smartobject_range) or is_smart_objecting

	if condition_result then
		self.set_running_child(self, unit, blackboard, t, node_smartobject, "aborted")
		Profiler_start("smartobject")

		local result, evaluate = node_smartobject.run(node_smartobject, unit, blackboard, t, dt)

		Profiler_stop()

		if result ~= "running" then
			self.set_running_child(self, unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_smartobject == child_running then
		self.set_running_child(self, unit, blackboard, t, nil, "failed")
	end

	local node_dodge = children[5]
	local condition_result = blackboard.dodge_vector or blackboard.is_dodging

	if condition_result then
		self.set_running_child(self, unit, blackboard, t, node_dodge, "aborted")
		Profiler_start("dodge")

		local result, evaluate = node_dodge.run(node_dodge, unit, blackboard, t, dt)

		Profiler_stop()

		if result ~= "running" then
			self.set_running_child(self, unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_dodge == child_running then
		self.set_running_child(self, unit, blackboard, t, nil, "failed")
	end

	local node_look_players = children[6]
	local condition_result = blackboard.look_for_players

	if condition_result then
		self.set_running_child(self, unit, blackboard, t, node_look_players, "aborted")
		Profiler_start("look_players")

		local result, evaluate = node_look_players.run(node_look_players, unit, blackboard, t, dt)

		Profiler_stop()

		if result ~= "running" then
			self.set_running_child(self, unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_look_players == child_running then
		self.set_running_child(self, unit, blackboard, t, nil, "failed")
	end

	local node_flee = children[7]
	local condition_result = BTConditions.confirmed_player_sighting(blackboard) or blackboard.is_fleeing

	if condition_result then
		self.set_running_child(self, unit, blackboard, t, node_flee, "aborted")
		Profiler_start("flee")

		local result, evaluate = node_flee.run(node_flee, unit, blackboard, t, dt)

		Profiler_stop()

		if result ~= "running" then
			self.set_running_child(self, unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_flee == child_running then
		self.set_running_child(self, unit, blackboard, t, nil, "failed")
	end

	local node_alerted = children[8]
	local condition_result = unit_alive(blackboard.target_unit)

	if condition_result then
		self.set_running_child(self, unit, blackboard, t, node_alerted, "aborted")
		Profiler_start("alerted")

		local result, evaluate = node_alerted.run(node_alerted, unit, blackboard, t, dt)

		Profiler_stop()

		if result ~= "running" then
			self.set_running_child(self, unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_alerted == child_running then
		self.set_running_child(self, unit, blackboard, t, nil, "failed")
	end

	local node_idle = children[9]

	self.set_running_child(self, unit, blackboard, t, node_idle, "aborted")
	Profiler_start("idle")

	local result, evaluate = node_idle.run(node_idle, unit, blackboard, t, dt)

	Profiler_stop()

	if result ~= "running" then
		self.set_running_child(self, unit, blackboard, t, nil, result)
	end

	if result ~= "failed" then
		return result, evaluate
	end

	return 
end
BTSelector_loot_rat.add_child = function (self, node)
	self._children[#self._children + 1] = node

	return 
end

return 