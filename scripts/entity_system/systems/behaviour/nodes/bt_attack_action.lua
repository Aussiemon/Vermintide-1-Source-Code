require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTAttackAction = class(BTAttackAction, BTNode)
local DEFAULT_SPEED_MODIFIER_ON_TARGET_DODGE = 0.1
local DEFAULT_SPEED_LERP_TIME_ON_TARGET_DODGE = 0.5
local REEVAL_TIME = 0.5
BTAttackAction.init = function (self, ...)
	BTAttackAction.super.init(self, ...)

	return 
end
BTAttackAction.name = "BTAttackAction"

local function randomize(event)
	if type(event) == "table" then
		return event[Math.random(1, #event)]
	else
		return event
	end

	return 
end

BTAttackAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.active_node = BTAttackAction
	blackboard.attack_finished = false
	blackboard.attack_aborted = false
	local target_unit = blackboard.target_unit
	local target_unit_status_extension = (ScriptUnit.has_extension(target_unit, "status_system") and ScriptUnit.extension(target_unit, "status_system")) or nil
	local attack_anim = randomize(self._select_attack_anim(self, action, unit, target_unit, blackboard, target_unit_status_extension))
	blackboard.attack_anim = attack_anim
	local box_range = action.use_box_range

	if box_range then
		local range = box_range[attack_anim]
		blackboard.attack_range_up = range.up
		blackboard.attack_range_down = range.down
		blackboard.attack_range_flat = range.flat
	end

	blackboard.attack_token = (target_unit_status_extension and target_unit_status_extension.want_an_attack(target_unit_status_extension)) or nil

	if blackboard.attack_token then
		target_unit_status_extension.add_attack_intensity(target_unit_status_extension, math.random()*0.5 + 0.75)
	end

	blackboard.target_unit_status_extension = target_unit_status_extension
	local network_manager = Managers.state.network

	network_manager.anim_event(network_manager, unit, "to_combat")

	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	network_manager.network_transmit:send_rpc_all("rpc_enemy_has_target", unit_id, true)

	blackboard.attack_setup_delayed = true
	blackboard.attacking_target = blackboard.target_unit

	DialogueSystem:TriggerBackstab(target_unit, unit)

	return 
end
BTAttackAction._select_attack_anim = function (self, action, unit, target_unit, blackboard, target_unit_status_extension)
	local target_type = Unit.get_data(target_unit, "target_type")
	local exceptions = target_type and action.target_type_exceptions and action.target_type_exceptions[target_type]

	if exceptions and exceptions.attack_anim then
		return exceptions.attack_anim
	else
		local self_pos = POSITION_LOOKUP[unit]
		local target_pos = POSITION_LOOKUP[target_unit] or Unit.world_position(unit, 0)
		local z_offset = target_pos.z - self_pos.z

		if action.high_attack_anim and action.high_attack_threshold < z_offset then
			return action.high_attack_anim
		elseif action.low_attack_anim and z_offset < action.low_attack_threshold then
			return action.low_attack_anim
		elseif action.knocked_down_attack_anim and z_offset < action.knocked_down_attack_threshold and target_unit_status_extension and target_unit_status_extension.is_knocked_down(target_unit_status_extension) then
			return action.knocked_down_attack_anim
		else
			return action.attack_anim
		end
	end

	return 
end
BTAttackAction.leave = function (self, unit, blackboard, t)
	if blackboard.move_state ~= "idle" then
		local network_manager = Managers.state.network

		network_manager.anim_event(network_manager, unit, "idle")

		blackboard.move_state = "idle"
	end

	blackboard.attack_token = false
	local default_move_speed = AiUtils.get_default_breed_move_speed(unit, blackboard)
	local navigation_extension = blackboard.navigation_extension

	navigation_extension.set_enabled(navigation_extension, true)
	navigation_extension.set_max_speed(navigation_extension, default_move_speed)

	blackboard.target_unit_status_extension = nil
	blackboard.target_dodged_during_attack = nil
	blackboard.current_time_for_dodge = nil
	blackboard.dodge_rotation_stun_during_attack = nil
	blackboard.update_timer = 0
	blackboard.active_node = nil
	blackboard.attack_aborted = nil
	blackboard.attacking_target = nil
	blackboard.attack_success = nil
	blackboard.attack_anim = nil
	blackboard.anim_cb_damage = nil

	if blackboard.action.use_box_range then
		blackboard.attack_range_up = nil
		blackboard.attack_range_down = nil
		blackboard.attack_range_flat = nil
	end

	blackboard.action = nil

	return 
end
BTAttackAction.run = function (self, unit, blackboard, t, dt)
	if not Unit.alive(blackboard.attacking_target) then
		return "done"
	end

	if blackboard.attack_aborted then
		return "done"
	end

	if blackboard.attack_finished then
		blackboard.skulk_time = nil
		blackboard.skulk_time_force_attack = nil

		return "done"
	end

	if blackboard.anim_cb_damage then
		blackboard.anim_cb_damage = nil

		if blackboard.action.moving_attack then
			blackboard.navigation_extension:set_enabled(false)
			blackboard.locomotion_extension:set_wanted_velocity(Vector3(0, 0, 0))
		end
	end

	if blackboard.attack_setup_delayed then
		local action = self._tree_node.action_data

		if action.moving_attack then
			local breed = blackboard.breed
			local navigation_extension = blackboard.navigation_extension
			local attacking_target = blackboard.attacking_target

			navigation_extension.set_max_speed(navigation_extension, breed.run_speed)
			Unit.set_data(attacking_target, "last_first_attack_t", t)
		else
			blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())
			blackboard.navigation_extension:set_enabled(false)
		end

		blackboard.attack_setup_delayed = false
	end

	self.attack(self, unit, t, dt, blackboard)

	return "running"
end
BTAttackAction.attack_success = function (self, unit, blackboard)
	local t = Managers.time:time("game")
	local cooldown, cooldown_at = self.get_attack_cooldown_finished_at(self, unit, blackboard, t)
	blackboard.attack_cooldown_at = cooldown_at
	blackboard.is_in_attack_cooldown = cooldown
	blackboard.attack_success = true

	return 
end
BTAttackAction.attack = function (self, unit, t, dt, blackboard)
	local action = blackboard.action
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	if blackboard.move_state ~= "attacking" then
		blackboard.move_state = "attacking"

		Managers.state.network:anim_event(unit, blackboard.attack_anim)
	end

	local rotation = LocomotionUtils.rotation_towards_unit_flat(unit, blackboard.attacking_target)

	if not blackboard.dodge_rotation_stun_during_attack and blackboard.target_unit_status_extension and blackboard.target_unit_status_extension:get_is_dodging() then
		locomotion.set_rotation_speed_modifier(locomotion, blackboard.breed.speed_modifer_on_target_dodge or DEFAULT_SPEED_MODIFIER_ON_TARGET_DODGE, blackboard.breed.speed_lerp_time_on_target_dodge or DEFAULT_SPEED_LERP_TIME_ON_TARGET_DODGE, t)

		blackboard.target_dodged_during_attack = true
	end

	blackboard.current_time_for_dodge = t

	locomotion.set_wanted_rotation(locomotion, rotation)

	return 
end
BTAttackAction.get_attack_cooldown_finished_at = function (self, unit, blackboard, t)
	local attacking_target = blackboard.attacking_target

	if not Unit.alive(attacking_target) then
		return false, 0
	end

	local dimishing_damage_data = blackboard.action.dimishing_damage

	if not dimishing_damage_data then
		return false, 0
	end

	local has_ai_slot_extension = ScriptUnit.has_extension(attacking_target, "ai_slot_system")

	if not has_ai_slot_extension then
		return false, 0
	end

	local ai_slot_extension = ScriptUnit.extension(attacking_target, "ai_slot_system")
	local slots_n = ai_slot_extension.slots_count

	if slots_n == 0 then
		return false, 0
	end

	local dimishing_damage = dimishing_damage_data[math.min(slots_n, 9)]
	local cooldown_data = dimishing_damage.cooldown
	local cooldown = AiUtils.random(cooldown_data[1], cooldown_data[2])

	return true, cooldown + t
end

return 