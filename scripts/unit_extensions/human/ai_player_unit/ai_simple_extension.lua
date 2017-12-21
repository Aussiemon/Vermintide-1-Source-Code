require("scripts/unit_extensions/human/ai_player_unit/ai_locomotion_extension")
require("scripts/unit_extensions/human/ai_player_unit/ai_locomotion_extension_c")
require("scripts/unit_extensions/human/ai_player_unit/ai_husk_locomotion_extension")
require("scripts/unit_extensions/human/ai_player_unit/ai_navigation_extension")
require("scripts/unit_extensions/human/ai_player_unit/ai_brain")
require("scripts/unit_extensions/human/ai_player_unit/ai_event_handler")
require("scripts/unit_extensions/human/ai_player_unit/perception_utils")
require("scripts/utils/pool_tables/pool_blackboard")
require("scripts/utils/pool_tables/pool_generic_extension")

local alive = Unit.alive
local PLAYER_AND_BOT_UNITS = PLAYER_AND_BOT_UNITS
AISimpleExtension = class(AISimpleExtension)
local LOLOLOL = true
AISimpleExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._world = extension_init_context.world
	self._unit = unit
	self._nav_world = extension_init_data.nav_world
	local ai_system = Managers.state.entity:system("ai_system")
	local spawn_type = extension_init_data.spawn_type
	local is_horde = spawn_type == "horde_hidden" or spawn_type == "horde"
	local breed = extension_init_data.breed

	Unit.set_data(unit, "breed", breed)

	self._breed = breed
	local is_passive = (breed.initial_is_passive == nil and true) or breed.initial_is_passive
	local blackboard = nil

	if LOLOLOL then
		blackboard = Script.new_map(breed.blackboard_allocation_size or 75)
		blackboard.world = extension_init_context.world
		blackboard.unit = unit
		blackboard.level = LevelHelper:current_level(extension_init_context.world)
		blackboard.move_orders = {}
		blackboard.nav_world = self._nav_world
		blackboard.node_data = {}
		blackboard.running_nodes = {}
		blackboard.is_passive = is_passive
		blackboard.system_api = extension_init_context.system_api
		blackboard.group_blackboard = ai_system.group_blackboard
		blackboard.target_dist = math.huge
		blackboard.spawn_type = spawn_type
		blackboard.stuck_check_time = Managers.time:time("game") + RecycleSettings.ai_stuck_check_start_time
		blackboard.is_in_attack_cooldown = false
		blackboard.attack_cooldown_at = 0
		blackboard.override_targets = {}
	else
		blackboard = POOL_blackboard_acquire()
		blackboard.world = extension_init_context.world
		blackboard.unit = unit
		blackboard.level = LevelHelper:current_level(extension_init_context.world)
		blackboard.move_orders = {}
		blackboard.nav_world = self._nav_world
		blackboard.node_data = {}
		blackboard.running_nodes = {}
		blackboard.is_passive = is_passive
		blackboard.system_api = extension_init_context.system_api
		blackboard.group_blackboard = ai_system.group_blackboard
		blackboard.target_dist = math.huge
		blackboard.spawn_type = spawn_type
		blackboard.stuck_check_time = Managers.time:time("game") + RecycleSettings.ai_stuck_check_start_time
		blackboard.is_in_attack_cooldown = false
		blackboard.attack_cooldown_at = 0
		blackboard.override_targets = {}
	end

	local blackboard_init_data = breed.blackboard_init_data

	if blackboard_init_data then
		table.merge(blackboard, blackboard_init_data)
	end

	self._blackboard = blackboard
	self.broadphase_id = Broadphase.add(self._blackboard.group_blackboard.broadphase, unit, Unit.local_position(unit, 0), 1)

	if not breed.hit_zones_lookup then
		DamageUtils.create_hit_zone_lookup(unit, breed)
	end

	if breed.combat_spawn_stinger then
		Managers.music:music_trigger("combat_music", breed.combat_spawn_stinger)
	end

	self._init_event_handler(self)
	self.init_perception(self, breed, is_horde)
	self._init_brain(self, breed, is_horde, extension_init_data.override_behaviour)
	self._init_size_variation(self, unit, breed)
	GarbageLeakDetector.register_object(blackboard, "ai_blackboard")

	return 
end
AISimpleExtension.destroy = function (self)
	local blackboard = self._blackboard

	if not LOLOLOL then
		POOL_blackboard_release(blackboard)
	end

	AiUtils.special_dead_cleanup(self._unit, self._blackboard)

	if self.broadphase_id then
		Broadphase.remove(blackboard.group_blackboard.broadphase, self.broadphase_id)

		self.broadphase_id = nil
	end

	self._brain:destroy()

	return 
end
AISimpleExtension.extensions_ready = function (self, world, unit)
	self._health_extension = ScriptUnit.extension(unit, "health_system")
	self._locomotion = ScriptUnit.extension(unit, "locomotion_system")
	self._navigation = ScriptUnit.extension(unit, "ai_navigation_system")
	self._health_extension = ScriptUnit.extension(unit, "health_system")
	self._blackboard.navigation_extension = ScriptUnit.extension(unit, "ai_navigation_system")
	self._blackboard.locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	if self._breed.run_on_spawn then
		self._breed.run_on_spawn(unit, self._blackboard)
	end

	return 
end
AISimpleExtension.get_overlap_context = function (self)
	if self._overlap_context then
		self._overlap_context.num_hits = 0
	else
		self._overlap_context = {
			has_gotten_callback = false,
			spine_node = false,
			num_hits = 0,
			overlap_units = {}
		}

		GarbageLeakDetector.register_object(self._overlap_context, "ai_overlap_context")
	end

	return self._overlap_context
end
AISimpleExtension.set_properties = function (self, params)
	for _, property in pairs(params) do
		local prop_name, prop_value = property.match(property, "(%S+) (%S+)")
		local prop_type = type(self._breed.properties[prop_name])

		if prop_type == "table" then
			prop_value = AIProperties
			local prop_iterator = property.gmatch(property, "(%S+)")

			prop_iterator()

			for i = 1, 10, 1 do
				local index = prop_iterator()

				if index == nil then
					break
				end

				fassert(prop_value[index], "Table index %q not found in AIProperties", index)

				prop_value = prop_value[index]
			end
		elseif prop_type == "number" then
			prop_value = tonumber(prop_value)
		elseif prop_type == "boolean" then
			prop_value = to_boolean(prop_value)
		end

		self._breed.properties[prop_name] = prop_value
	end

	return 
end
AISimpleExtension._parse_properties = function (self)
	for prop_name, prop_value in pairs(self._breed.properties) do
		if type(prop_value) == "table" then
			for key, value in pairs(prop_value) do
				self._breed.properties[key] = value
			end
		end
	end

	return 
end
AISimpleExtension.init_perception = function (self, breed, is_horde)
	if breed.perception then
		self._perception_func_name = (is_horde and breed.horde_perception) or breed.perception
	else
		self._perception_func_name = "perception_regular"
	end

	if breed.target_selection then
		self._target_selection_func_name = (is_horde and breed.horde_target_selection) or breed.target_selection
	else
		self._target_selection_func_name = "pick_closest_target_with_spillover"
	end

	return 
end
AISimpleExtension.set_perception = function (self, perception_func_name, target_selection_func_name)
	if perception_func_name then
		self._perception_func_name = perception_func_name
	else
		self._perception_func_name = "perception_regular"
	end

	if target_selection_func_name then
		self._target_selection_func_name = target_selection_func_name
	else
		self._target_selection_func_name = "pick_closest_target_with_spillover"
	end

	return 
end
AISimpleExtension._init_event_handler = function (self)
	if self._breed.event then
		local class_name = self._breed.event.class_name
		self._event_handler = _G[class_name]:new(self._unit)
	else
		self._event_handler = AIEventHandler:new(self._unit)
	end

	return 
end
AISimpleExtension._init_brain = function (self, breed, is_horde, override_behaviour)
	local behavior = override_behaviour or (is_horde and breed.horde_behavior) or breed.behavior
	self._brain = AIBrain:new(self._world, self._unit, self._blackboard, self._breed, behavior)

	return 
end
AISimpleExtension._init_size_variation = function (self, unit, breed)
	local size_variation_range = breed.size_variation_range

	if size_variation_range then
		local size_variation_normalized = math.random()
		local size_variation = math.lerp(size_variation_range[1], size_variation_range[2], size_variation_normalized)
		self._size_variation = size_variation
		self._size_variation_normalized = size_variation_normalized
		local root_node = Unit.node(unit, "root_point")

		Unit.set_local_scale(unit, root_node, Vector3(size_variation, size_variation, size_variation))
	else
		self._size_variation = 1
		self._size_variation_normalized = 1
	end

	return 
end
AISimpleExtension.locomotion = function (self)
	return self._locomotion
end
AISimpleExtension.navigation = function (self)
	return self._navigation
end
AISimpleExtension.brain = function (self)
	return self._brain
end
AISimpleExtension.breed = function (self)
	return self._breed
end
AISimpleExtension.blackboard = function (self)
	return self._blackboard
end
AISimpleExtension.size_variation = function (self)
	return self._size_variation, self._size_variation_normalized
end
AISimpleExtension.force_enemy_detection = function (self, t)
	local num_targets = #PLAYER_AND_BOT_UNITS

	if num_targets == 0 then
		return 
	end

	local target = Math.random(1, num_targets)
	local random_enemy = PLAYER_AND_BOT_UNITS[target]

	if random_enemy then
		self.enemy_aggro(self, self._unit, random_enemy)
	end

	return 
end
AISimpleExtension.current_action_name = function (self)
	local blackboard = self._blackboard

	return (blackboard.action and blackboard.action.name) or "n/a"
end
AISimpleExtension.die = function (self, killer_unit, killing_blow)
	local blackboard = self._blackboard
	local unit = self._unit

	self._brain:exit_last_action()

	if self._blackboard.group_blackboard then
		AiUtils.special_dead_cleanup(unit, blackboard)
	end

	local conflict_director = Managers.state.conflict

	conflict_director.register_unit_killed(conflict_director, unit, blackboard, killer_unit, killing_blow)

	return 
end
AISimpleExtension.attacked = function (self, attacker_unit, t, damage_hit)
	local unit = self._unit
	attacker_unit = AiUtils.get_actual_attacker_unit(attacker_unit)
	local attacker_is_player = table.find(PLAYER_AND_BOT_UNITS, attacker_unit)
	local blackboard = self._blackboard

	if attacker_is_player then
		local blackboard = self._blackboard

		if damage_hit and blackboard.confirmed_player_sighting and blackboard.target_unit == nil then
			blackboard.target_unit = attacker_unit

			AiUtils.alert_nearby_friends_of_enemy(unit, blackboard.group_blackboard.broadphase, attacker_unit)
		end

		blackboard.previous_attacker = attacker_unit
		blackboard.previous_attacker_hit_time = t
	end

	if not damage_hit and blackboard.stagger == 1 and AiUtils.unit_alive(unit) then
		StatisticsUtil.check_save(attacker_unit, unit)
	end

	return 
end
AISimpleExtension.enemy_aggro = function (self, alerting_unit, enemy_unit)
	local blackboard = self._blackboard

	if blackboard.confirmed_player_sighting or blackboard.only_trust_your_own_eyes then
		return 
	end

	local attacker_is_player = Managers.player:owner(enemy_unit)

	if not attacker_is_player then
		return 
	end

	blackboard.delayed_target_unit = enemy_unit

	AiUtils.activate_unit(blackboard)

	blackboard.no_hesitation = true
	local self_unit = self._unit

	if ScriptUnit.has_extension(self_unit, "ai_slot_system") then
		ScriptUnit.extension(self_unit, "ai_slot_system").do_search = true
	end

	if ScriptUnit.has_extension(self_unit, "ai_inventory_system") then
		local network_manager = Managers.state.network
		local self_unit_id = network_manager.unit_game_object_id(network_manager, self_unit)

		network_manager.network_transmit:send_rpc_all("rpc_ai_inventory_wield", self_unit_id)
	end

	return 
end
AISimpleExtension.enemy_alert = function (self, alerting_unit, enemy_unit)
	local blackboard = self._blackboard
	local run_on_alerted = self._breed.run_on_alerted

	if run_on_alerted then
		run_on_alerted(self._unit, self._blackboard, alerting_unit, enemy_unit)
	end

	if blackboard.confirmed_player_sighting or blackboard.only_trust_your_own_eyes then
		return 
	end

	if blackboard.hesitating or (blackboard.in_alerted_state and blackboard.alerted_deadline_reached) then
		self.enemy_aggro(self, alerting_unit, enemy_unit)
	end

	local attacker_is_player = Managers.player:owner(enemy_unit)

	if not attacker_is_player then
		return 
	end

	self._blackboard.delayed_target_unit = enemy_unit

	return 
end

return 
