require("scripts/utils/ai_debugger")
require("scripts/helpers/level_helper")
require("scripts/helpers/network_utils")

VISUAL_DEBUGGING_ENABLED = VISUAL_DEBUGGING_ENABLED or false
GLOBAL_AI_NAVWORLD = GLOBAL_AI_NAVWORLD or {}
AISystem = class(AISystem, ExtensionSystemBase)
Horde = {}
local script_data = script_data
local POSITION_LOOKUP = POSITION_LOOKUP
local Vector3_flat = Vector3.flat
local Vector3_distance = Vector3.distance
local Vector3_dot = Vector3.dot
local Vector3_normalize = Vector3.normalize
local Vector3_length = Vector3.length
local sqrt = math.sqrt
local unit_alive = Unit.alive
script_data.disable_ai_perception = script_data.disable_ai_perception or Development.parameter("disable_ai_perception")
local ai_trees_created = false
local extensions = {
	"AISimpleExtension",
	"AiHuskBaseExtension",
	"PlayerBotBase"
}
AISystem.init = function (self, context, name)
	AISystem.super.init(self, context, name, extensions)

	self.broadphase = Broadphase(40, 128)
	self._behavior_trees = {}
	self.group_blackboard = {
		rats_currently_moving_to_ip = 0,
		special_targets = {},
		disabled_by_special = {},
		broadphase = self.broadphase,
		slots = {},
		slots_cleared = {}
	}

	self.create_all_trees(self)

	self._nav_world = GwNavWorld.create(Matrix4x4.identity())
	GLOBAL_AI_NAVWORLD = self._nav_world

	if not script_data.disable_crowd_dispersion then
		GwNavWorld.enable_crowd_dispersion(self._nav_world)
	end

	if script_data.debug_enabled and script_data.navigation_visual_debug_enabled and not VISUAL_DEBUGGING_ENABLED then
		VISUAL_DEBUGGING_ENABLED = true

		GwNavWorld.init_visual_debug_server(self._nav_world, 4888)
	end

	if not script_data.navigation_thread_disabled then
		GwNavWorld.init_async_update(self._nav_world)
	end

	local level_settings = LevelHelper:current_level_settings()
	local level_name = level_settings.level_name

	if LEVEL_EDITOR_TEST then
		level_name = Application.get_data("LevelEditor", "level_resource_name")
	end

	if not level_settings.no_bots_allowed then
		self._nav_data = GwNavWorld.add_navdata(self._nav_world, level_name)

		if script_data.debug_enabled then
			self.ai_debugger = AIDebugger:new(context.world, self._nav_world, self.group_blackboard, self.is_server, context.free_flight_manager)
		end
	end

	self.unit_extension_data = {}
	self.blackboards = {}
	self.ai_blackboard_updates = {}
	self.ai_blackboard_prioritized_updates = {}
	self.ai_update_index = 1
	self._units_to_destroy = {}
	self.ai_units_alive = {}
	self.ai_units_perception_continuous = {}
	self.ai_units_perception = {}
	self.ai_units_perception_prioritized = {}
	self.num_perception_units = 0
	self.number_ordinary_aggroed_enemies = 0
	self.number_special_aggored_enemies = 0
	local network_event_delegate = context.network_event_delegate

	network_event_delegate.register(network_event_delegate, self, "rpc_alert_enemies_within_range")

	self._network_event_delegate = network_event_delegate

	return 
end
AISystem.destroy = function (self)
	AISystem.super.destroy(self)

	if self.ai_debugger then
		self.ai_debugger:destroy()
	end

	self.broadphase = nil

	if self._nav_data then
		GwNavWorld.remove_navdata(nil, self._nav_data)
	end

	GwNavWorld.destroy(self._nav_world)
	self._network_event_delegate:unregister(self)

	self._network_event_delegate = nil

	return 
end
AISystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local extension = AISystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data)
	self.unit_extension_data[unit] = extension

	if not extension.is_husk then
		self.ai_blackboard_updates[#self.ai_blackboard_updates + 1] = unit
		self.blackboards[unit] = extension.blackboard(extension)

		self.set_default_blackboard_values(self, unit, extension.blackboard(extension))
	end

	if extension_name == "AISimpleExtension" then
		self.ai_units_alive[unit] = extension
		local breed = extension._breed

		if breed.perception_continuous then
			self.ai_units_perception_continuous[unit] = extension
		else
			self.ai_units_perception[unit] = extension
		end

		self.num_perception_units = self.num_perception_units + 1
	end

	return extension
end
AISystem.set_default_blackboard_values = function (self, unit, blackboard)
	blackboard.destination_dist = 0
	blackboard.current_health_percent = 1
	blackboard.have_slot = 0
	blackboard.wait_slot_distance = math.huge
	blackboard.target_dist = math.huge
	blackboard.target_dist_z = math.huge
	blackboard.target_dist_xy_sq = math.huge
	blackboard.ally_distance = math.huge
	blackboard.slot_dist_z = math.huge
	blackboard.move_speed = 0
	blackboard.total_slots_count = 0
	blackboard.target_speed_away = 0

	return 
end
AISystem.on_remove_extension = function (self, unit, extension_name)
	self.on_freeze_extension(self, unit, extension_name)
	AISystem.super.on_remove_extension(self, unit, extension_name)

	return 
end
AISystem.on_freeze_extension = function (self, unit, extension_name)
	if self.unit_extension_data[unit] == nil then
		return 
	end

	self.unit_extension_data[unit] = nil
	local ai_blackboard_updates = self.ai_blackboard_updates
	local ai_blackboard_updates_n = #ai_blackboard_updates
	local ai_blackboard_prioritized_updates = self.ai_blackboard_prioritized_updates
	local ai_blackboard_prioritized_updates_n = #ai_blackboard_prioritized_updates

	for i = 1, ai_blackboard_updates_n, 1 do
		if ai_blackboard_updates[i] == unit then
			ai_blackboard_updates[i] = ai_blackboard_updates[ai_blackboard_updates_n]
			ai_blackboard_updates[ai_blackboard_updates_n] = nil
		end
	end

	for i = 1, ai_blackboard_prioritized_updates_n, 1 do
		if ai_blackboard_prioritized_updates[i] == unit then
			ai_blackboard_prioritized_updates[i] = ai_blackboard_prioritized_updates[ai_blackboard_prioritized_updates_n]
			ai_blackboard_prioritized_updates[ai_blackboard_prioritized_updates_n] = nil
		end
	end

	self.blackboards[unit] = nil
	self.ai_units_alive[unit] = nil
	self.ai_units_perception[unit] = nil
	self.ai_units_perception_continuous[unit] = nil
	self.ai_units_perception_prioritized[unit] = nil

	if extension_name == "AISimpleExtension" then
		self.num_perception_units = self.num_perception_units - 1
	end

	return 
end
AISystem.register_prioritized_perception_unit_update = function (self, unit, ai_extension)
	self.ai_units_perception_prioritized[unit] = ai_extension

	return 
end
AISystem.update = function (self, context, t)
	local dt = context.dt

	if not ai_trees_created then
		self.create_all_trees(self)
	end

	Profiler.start("PlayerBotBase")
	self.update_extension(self, "PlayerBotBase", dt, context, t)
	Profiler.stop("PlayerBotBase")
	Profiler.start("AiHuskBaseExtension")
	self.update_extension(self, "AiHuskBaseExtension", dt, context, t)
	Profiler.stop("AiHuskBaseExtension")
	Profiler.start("AISimpleExtension")
	self.update_alive(self)
	self.update_perception(self, t, dt)
	self.update_brains(self, t, dt)
	self.update_game_objects(self)
	self.update_broadphase(self)

	if script_data.debug_enabled then
		Profiler.start("update_debug")
		self.update_debug_unit(self, t)
		self.update_debug_draw(self, t)
		Profiler.stop("update_debug")
	end

	Profiler.stop("AISimpleExtension")

	if self.ai_debugger then
		self.ai_debugger:update(t, dt)
	end

	for id, unit in pairs(self._units_to_destroy) do
		local extension = self.ai_units_alive[unit]

		Managers.state.conflict:destroy_unit(unit, extension._blackboard, "intentionally_destroyed")

		self._units_to_destroy[id] = nil
	end

	return 
end
AISystem.physics_async_update = function (self, context, t)
	local dt = context.dt

	Profiler.start("update blackboards")
	self.update_ai_blackboards_prioritized(self, t, dt)
	self.update_ai_blackboards(self, t, dt)
	Profiler.stop("update blackboards")

	return 
end
AISystem.update_alive = function (self)
	Profiler.start("update_alive")

	local broadphase = self.broadphase

	for unit, extension in pairs(self.ai_units_alive) do
		local is_alive = extension._health_extension:is_alive()

		if not is_alive then
			self.ai_units_alive[unit] = nil
			self.ai_units_perception[unit] = nil
			self.ai_units_perception_continuous[unit] = nil
			self.ai_units_perception_prioritized[unit] = nil
		end
	end

	Profiler.stop("update_alive")

	return 
end
AISystem.update_perception = function (self, t, dt)
	if script_data.disable_ai_perception then
		return 
	end

	Profiler.start("update_perception")

	local PerceptionUtils = PerceptionUtils
	local ai_units_perception = self.ai_units_perception

	Profiler.start("continuous")

	for unit, extension in pairs(self.ai_units_perception_continuous) do
		local blackboard = extension._blackboard
		local breed = extension._breed
		local perception_continuous_name = breed.perception_continuous
		local perception_function = PerceptionUtils[perception_continuous_name]

		Profiler.start(perception_continuous_name)

		local needs_perception = perception_function(unit, blackboard, breed, t, dt)
		ai_units_perception[unit] = (needs_perception and extension) or nil

		Profiler.stop(perception_continuous_name)
	end

	Profiler.stop("continuous")
	Profiler.start("prioritized perception")

	local ai_units_perception_prioritized = self.ai_units_perception_prioritized

	for unit, extension in pairs(ai_units_perception_prioritized) do
		local blackboard = extension._blackboard
		local breed = extension._breed
		local target_selection_func_name = extension._target_selection_func_name
		local perception_func_name = extension._perception_func_name
		local perception_function = PerceptionUtils[perception_func_name]
		local target_selection_function = PerceptionUtils[target_selection_func_name]

		Profiler.start(target_selection_func_name)
		perception_function(unit, blackboard, breed, target_selection_function, t, dt)
		Profiler.stop(target_selection_func_name)

		ai_units_perception_prioritized[unit] = nil
	end

	Profiler.stop("prioritized perception")
	Profiler.start("perception")

	local current_perception_unit = self.current_perception_unit
	current_perception_unit = (self.ai_units_perception[current_perception_unit] ~= nil and current_perception_unit) or nil
	local TIME_BETWEEN_UPDATE = 1
	local num_perception_units = self.num_perception_units
	local num_to_update = math.ceil((num_perception_units*dt)/TIME_BETWEEN_UPDATE)

	for i = 1, num_to_update, 1 do
		current_perception_unit = next(ai_units_perception, current_perception_unit)

		if current_perception_unit == nil then
			break
		end

		local extension = ai_units_perception[current_perception_unit]
		local blackboard = extension._blackboard
		local breed = extension._breed
		local target_selection_func_name = extension._target_selection_func_name
		local perception_func_name = extension._perception_func_name
		local perception_function = PerceptionUtils[perception_func_name]
		local target_selection_function = PerceptionUtils[target_selection_func_name]

		Profiler.start(target_selection_func_name)
		perception_function(current_perception_unit, blackboard, breed, target_selection_function, t, dt)
		Profiler.stop(target_selection_func_name)
	end

	Profiler.stop("perception")

	self.current_perception_unit = current_perception_unit

	Profiler.stop("update_perception")

	return 
end
AISystem.update_brains = function (self, t, dt)
	local number_ordinary_aggroed_enemies = 0
	local number_special_aggored_enemies = 0
	local Profiler_start = Profiler.start
	local Profiler_stop = Profiler.stop

	Profiler.start("update_brains")

	for unit, extension in pairs(self.ai_units_alive) do
		local bt = extension._brain._bt
		local blackboard = extension._blackboard
		local result = bt.root(bt):evaluate(unit, blackboard, t, dt)
		local breed = blackboard.breed

		if breed.special then
			if blackboard.target_unit then
				number_special_aggored_enemies = number_special_aggored_enemies + 1
			end
		elseif blackboard.target_unit and blackboard.confirmed_player_sighting then
			number_ordinary_aggroed_enemies = number_ordinary_aggroed_enemies + 1
		end
	end

	Profiler.stop("update_brains")

	self.number_ordinary_aggroed_enemies = number_ordinary_aggroed_enemies
	self.number_special_aggored_enemies = number_special_aggored_enemies

	return 
end
AISystem.update_game_objects = function (self)
	Profiler.start("update_game_objects")

	local game = Managers.state.network:game()
	local NetworkLookup_bt_action_names = NetworkLookup.bt_action_names
	local GameSession_set_game_object_field = GameSession.set_game_object_field
	local unit_storage = Managers.state.unit_storage

	for unit, extension in pairs(self.ai_units_alive) do
		local game_object_id = unit_storage.go_id(unit_storage, unit)
		local action_name = extension.current_action_name(extension)
		local action_id = NetworkLookup_bt_action_names[action_name]

		GameSession_set_game_object_field(game, game_object_id, "bt_action_name", action_id)
	end

	Profiler.stop("update_game_objects")

	return 
end
AISystem.update_broadphase = function (self)
	Profiler.start("update_broadphase")

	local POSITION_LOOKUP = POSITION_LOOKUP
	local broadphase = self.broadphase

	for unit, extension in pairs(self.ai_units_alive) do
		local broadphase_id = extension.broadphase_id

		if broadphase_id then
			local position = POSITION_LOOKUP[unit]

			Broadphase.move(broadphase, extension.broadphase_id, position)
		end
	end

	Profiler.stop("update_broadphase")

	return 
end
AISystem.update_debug_unit = function (self, t)
	local unit = script_data.debug_unit

	if not unit_alive(unit) then
		return 
	end

	local extension = self.ai_units_alive[unit]

	if extension == nil then
		return 
	end

	local blackboard = extension._blackboard
	local leaf_node = extension._brain._bt:root()

	while leaf_node and leaf_node.current_running_child(leaf_node, blackboard) do
		leaf_node = leaf_node.current_running_child(leaf_node, blackboard)
	end

	local btnode_name = (leaf_node and leaf_node.id(leaf_node)) or "unknown_node"
	blackboard.btnode_name = btnode_name
	local breed = extension._breed
	local debug_flag = breed.debug_flag

	if not script_data[debug_flag] then
		if debug_flag then
			Debug.text("Enable debug setting %q for additional debugging of ai unit", debug_flag)
		end

		return 
	end

	local debug_class = breed.debug_class

	debug_class.update(unit, blackboard, t)

	return 
end
AISystem.update_debug_draw = function (self)
	if script_data.debug_behaviour_trees then
		for unit, extension in pairs(self.ai_units_alive) do
			local brain = extension._brain

			brain.debug_draw_behaviours(brain)
		end
	end

	if script_data.debug_ai_targets then
		local debug_sphere_position = nil

		for unit, extension in pairs(self.ai_units_alive) do
			local blackboard = extension._blackboard
			local enemy = blackboard.target_unit

			if unit_alive(enemy) then
				local ai_pos = Unit.local_position(unit, 0) + Vector3.up()*2

				QuickDrawer:line(ai_pos, Unit.world_position(enemy, 0) + Vector3(0, 0, 1.5), Color(125, 255, 0, 0))
				QuickDrawer:box(Unit.world_pose(enemy, 0), Vector3(0.5, 0.5, 1.5), Color(125, 255, 0, 0))
			end
		end
	end

	return 
end
local PRIORITIZED_DISTANCE = 10

local function update_blackboard(unit, blackboard, t, dt)
	assert(blackboard)

	local POSITION_LOOKUP = POSITION_LOOKUP

	for _, action_data in pairs(blackboard.utility_actions) do
		if action_data.last_time then
			action_data.time_since_last = t - action_data.last_time
		else
			action_data.time_since_last = math.huge
		end
	end

	if blackboard.is_in_attack_cooldown then
		blackboard.is_in_attack_cooldown = t < blackboard.attack_cooldown_at
	end

	local health_extension = ScriptUnit.extension(unit, "health_system")
	blackboard.current_health_percent = health_extension.current_health_percent(health_extension)
	local navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")

	assert(navigation_extension)

	local destination = navigation_extension.destination(navigation_extension)
	local current_position = POSITION_LOOKUP[unit]
	blackboard.destination_dist = Vector3_distance(current_position, destination)
	local ai_slot_system = Managers.state.entity:system("ai_slot_system")
	blackboard.have_slot = (ai_slot_system.ai_unit_have_slot(ai_slot_system, unit) and 1) or 0
	blackboard.wait_slot_distance = ai_slot_system.ai_unit_wait_slot_distance(ai_slot_system, unit)
	blackboard.total_slots_count = ai_slot_system.total_slots_count
	local target_unit = blackboard.target_unit
	local target_alive = unit_alive(target_unit)
	local breed = blackboard.breed

	if breed.using_first_attack then
		if target_alive then
			local last_first_attack_t = Unit.get_data(target_unit, "last_first_attack_t")

			if last_first_attack_t then
				blackboard.time_since_last_first_attack = t - last_first_attack_t
			else
				blackboard.time_since_last_first_attack = math.huge
			end
		else
			blackboard.time_since_last_first_attack = math.huge
		end
	end

	if target_alive and breed.has_running_attack then
		local target_locomotion = ScriptUnit.has_extension(target_unit, "locomotion_system") and ScriptUnit.extension(target_unit, "locomotion_system")

		if target_locomotion and target_locomotion.average_velocity then
			blackboard.target_speed_away = Vector3_dot(target_locomotion.average_velocity(target_locomotion), Vector3_normalize(POSITION_LOOKUP[target_unit] - current_position))
		else
			blackboard.target_speed_away = 0
		end
	else
		blackboard.target_speed_away = 0
	end

	local locomotion_extension = blackboard.locomotion_extension
	blackboard.is_falling = locomotion_extension and locomotion_extension.is_falling(locomotion_extension)
	blackboard.move_speed = locomotion_extension and locomotion_extension.move_speed

	if ScriptUnit.has_extension(unit, "status_system") then
		local status_extension = ScriptUnit.extension(unit, "status_system")
		blackboard.is_transported = status_extension.is_using_transport(status_extension)
	end

	if blackboard.next_smart_object_data then
		local smart_object_type = blackboard.next_smart_object_data.smart_object_type

		if smart_object_type == "doors" or smart_object_type == "planks" then
			local door_system = blackboard.door_system or Managers.state.entity:system("door_system")
			local door_unit = blackboard.next_smart_object_data.smart_object_data.unit
			local door_is_open = door_system.unit_extension_data[door_unit].current_state ~= "closed"
			blackboard.next_smart_object_data.disabled = door_is_open
		end
	end

	if breed.run_on_update then
		breed.run_on_update(unit, blackboard, t)
	end

	local target = blackboard.target_unit

	if unit_alive(target) then
		local unit_position = POSITION_LOOKUP[unit]
		local target_position = POSITION_LOOKUP[target]
		local offset = target_position - unit_position
		local z = offset.z
		local x = offset.x
		local y = offset.y
		local flat_sq = x*x + y*y
		blackboard.target_dist_z = z
		blackboard.target_dist_xy_sq = flat_sq
		local target_dist = sqrt(flat_sq + z*z)
		local inside_priority_distance = target_dist < PRIORITIZED_DISTANCE
		blackboard.target_dist = target_dist
		local slot_pos = ai_slot_system.ai_unit_slot_position(ai_slot_system, unit) or current_position
		blackboard.slot_dist_z = slot_pos.z - current_position.z

		return inside_priority_distance
	else
		blackboard.target_unit = nil
		blackboard.target_dist = math.huge
		blackboard.target_dist_z = math.huge
		blackboard.target_dist_xy_sq = math.huge
		blackboard.slot_dist_z = math.huge
	end

	return false
end

AISystem.update_ai_blackboards_prioritized = function (self, t, dt)
	Profiler.start("prio")

	local ai_blackboard_updates = self.ai_blackboard_updates
	local ai_blackboard_updates_n = #ai_blackboard_updates
	local ai_blackboard_prioritized_updates = self.ai_blackboard_prioritized_updates
	local ai_blackboard_prioritized_updates_n = #ai_blackboard_prioritized_updates
	local blackboards = self.blackboards
	local index = 1

	while index <= ai_blackboard_prioritized_updates_n do
		local unit = ai_blackboard_prioritized_updates[index]
		local blackboard = blackboards[unit]
		local inside_priority_distance = update_blackboard(unit, blackboard, t, dt)

		if not inside_priority_distance then
			ai_blackboard_prioritized_updates[index] = ai_blackboard_prioritized_updates[ai_blackboard_prioritized_updates_n]
			ai_blackboard_prioritized_updates[ai_blackboard_prioritized_updates_n] = nil
			ai_blackboard_updates[ai_blackboard_updates_n + 1] = unit
			ai_blackboard_updates_n = #ai_blackboard_updates
			ai_blackboard_prioritized_updates_n = #ai_blackboard_prioritized_updates
		else
			index = index + 1
		end
	end

	Profiler.stop("prio")

	return 
end
local AI_UPDATES_PER_FRAME = 2
AISystem.update_ai_blackboards = function (self, t, dt)
	Profiler.start("nonprio")

	local ai_blackboard_updates = self.ai_blackboard_updates
	local ai_blackboard_updates_n = #ai_blackboard_updates
	local ai_blackboard_prioritized_updates = self.ai_blackboard_prioritized_updates
	local ai_blackboard_prioritized_updates_n = #ai_blackboard_prioritized_updates
	local blackboards = self.blackboards
	local ai_updates_this_frame = 0
	local index = self.ai_update_index

	if ai_blackboard_updates_n < index then
		index = 1
	end

	while index <= ai_blackboard_updates_n do
		local unit = ai_blackboard_updates[index]
		local blackboard = blackboards[unit]
		local inside_priority_distance = update_blackboard(unit, blackboard, t, dt)

		if inside_priority_distance then
			ai_blackboard_updates[index] = ai_blackboard_updates[ai_blackboard_updates_n]
			ai_blackboard_updates[ai_blackboard_updates_n] = nil
			ai_blackboard_prioritized_updates[ai_blackboard_prioritized_updates_n + 1] = unit
			ai_blackboard_updates_n = #ai_blackboard_updates
			ai_blackboard_prioritized_updates_n = #ai_blackboard_prioritized_updates
		else
			index = index + 1
		end

		ai_updates_this_frame = ai_updates_this_frame + 1

		if AI_UPDATES_PER_FRAME <= ai_updates_this_frame then
			break
		end
	end

	self.ai_update_index = index

	Profiler.stop("nonprio")

	return 
end
AISystem.nav_world = function (self)
	return self._nav_world
end
AISystem.get_tri_on_navmesh = function (self, pos)
	return GwNavQueries.triangle_from_position(self._nav_world, pos, 30, 30)
end
AISystem.alert_enemies_within_range = function (self, unit, position, radius)
	if not NetworkUtils.network_safe_position(position) then
		Application.warning("Trying to alert enemies outside of safe network position")

		return 
	end

	if self.is_server then
		PerceptionUtils.alert_enemies_within_range(self.world, unit, true, position, radius)
	else
		local unit_id = Managers.state.unit_storage:go_id(unit)

		self.network_transmit:send_rpc_server("rpc_alert_enemies_within_range", unit_id, position, radius)
	end

	return 
end
AISystem.rpc_alert_enemies_within_range = function (self, peer_id, unit_id, position, radius)
	local unit = Managers.state.unit_storage:unit(unit_id)

	self.alert_enemies_within_range(self, unit, position, radius)

	return 
end
AISystem.create_all_trees = function (self)
	ai_trees_created = true

	for tree_name, root in pairs(BreedBehaviors) do
		local tree = BehaviorTree:new(root, tree_name)
		self._behavior_trees[tree_name] = tree
	end

	for tree_name, root in pairs(BotBehaviors) do
		local tree = BehaviorTree:new(root, tree_name)
		self._behavior_trees[tree_name] = tree
	end

	return 
end
AISystem.behavior_tree = function (self, tree_name)
	return self._behavior_trees[tree_name]
end
AISystem.register_unit_for_destruction = function (self, unit)
	self._units_to_destroy[unit] = unit

	return 
end

return 
