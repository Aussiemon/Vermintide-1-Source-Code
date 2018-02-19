AnimationCallbackTemplates = {
	client = {}
}
AnimationCallbackTemplates.client.anim_cb_enable_second_hit_ragdoll = function (unit, param)
	local death_ext = ScriptUnit.extension(unit, "death_system")

	death_ext.enable_second_hit_ragdoll(death_ext)

	return 
end
AnimationCallbackTemplates.server = {
	anim_cb_spawn_finished = function (unit, param)
		local blackboard = Unit.get_data(unit, "blackboard")
		blackboard.spawning_finished = true

		return 
	end,
	anim_cb_push_finished = function (unit, param)
		local blackboard = Unit.get_data(unit, "blackboard")
		blackboard.stagger_anim_done = true

		return 
	end,
	anim_cb_stunned_finished = function (unit, param)
		local blackboard = Unit.get_data(unit, "blackboard")
		blackboard.blocked = nil

		return 
	end,
	anim_cb_hesitate_finished = function (unit, param)
		local blackboard = Unit.get_data(unit, "blackboard")

		if blackboard.active_node and blackboard.active_node.anim_cb_hesitate_finished then
			blackboard.active_node:anim_cb_hesitate_finished(unit, blackboard)
		end

		return 
	end,
	anim_cb_direct_damage = function (unit, param)
		local blackboard = Unit.get_data(unit, "blackboard")

		if not Unit.alive(blackboard.target_unit) then
			return 
		end

		local action = blackboard.action

		if not action then
			print("Missing blackboard.action in anim_cb_direct_damage() callback")

			return 
		end

		local active_behavior_node = blackboard.active_node

		if active_behavior_node and active_behavior_node.direct_damage then
			active_behavior_node.direct_damage(unit, blackboard)
		end

		blackboard.attacks_done = blackboard.attacks_done + 1

		return 
	end
}
local DEFAULT_SPEED_MODIFIER_ON_TARGET_DODGE_DAMAGE_DONE = 0
local DEFAULT_ROTATION_STUN_TIME_ON_DODGE_DAMAGE_DONE = 0.6
local DEFAULT_SPEED_LERP_TIME_ON_TARGET_DODGE_DAMAGE_DONE = 0.3
AnimationCallbackTemplates.server.anim_cb_damage = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	local target_unit = (blackboard.smash_door and blackboard.smash_door.target_unit) or blackboard.attacking_target or blackboard.drag_target_unit
	local action = blackboard.action

	if not action then
		print("Missing blackboard.action in anim_cb_damage() callback")

		return 
	end

	local damage = action.damage

	if not damage then
		print("Missing damage in action %s in anim_cb_damage() callback", action.name)

		return 
	end

	if blackboard.attack_aborted then
		return 
	end

	if blackboard.active_node and blackboard.active_node.anim_cb_damage then
		blackboard.active_node:anim_cb_damage(unit, blackboard)

		return 
	end

	blackboard.anim_cb_damage = true

	if not Unit.alive(target_unit) or not Unit.alive(unit) then
		return 
	end

	if blackboard.has_line_of_sight == false or not DamageUtils.check_distance(action, blackboard, unit, target_unit) or not DamageUtils.check_infront(unit, target_unit) then
		if blackboard.target_dodged_during_attack then
			blackboard.dodge_rotation_stun_during_attack = true
			local locomotion = ScriptUnit.extension(unit, "locomotion_system")

			locomotion.set_rotation_speed_modifier(locomotion, blackboard.breed.speed_modifier_on_target_dodge_damage_done or DEFAULT_SPEED_MODIFIER_ON_TARGET_DODGE_DAMAGE_DONE, blackboard.breed.speed_lerp_time_on_target_dodge_damage_done or DEFAULT_SPEED_LERP_TIME_ON_TARGET_DODGE_DAMAGE_DONE, blackboard.current_time_for_dodge + (blackboard.breed.rotation_stun_time_on_dodge_damage_done or DEFAULT_ROTATION_STUN_TIME_ON_DODGE_DAMAGE_DONE))
		end

		return 
	end

	if not action.unblockable and DamageUtils.check_block(unit, target_unit, action.fatigue_type) then
		return 
	end

	AiUtils.damage_target(target_unit, unit, action, action.damage)

	if blackboard.active_node and blackboard.active_node.attack_success then
		blackboard.active_node:attack_success(unit, blackboard)
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_special_damage = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	local action = blackboard.action

	if not action or not action.damage then
		return 
	end

	if blackboard.attack_aborted then
		return 
	end

	if blackboard.active_node and blackboard.active_node.anim_cb_damage then
		blackboard.active_node:anim_cb_damage(unit, blackboard)
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_rotation_start = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_rotation_start = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_move = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_move = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_throw = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_throw = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_spawn_projectile = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_spawn_projectile = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_jump_start_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.jump_start_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_jump_climb_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.jump_climb_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_start_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.start_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_attack_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.attacks_done = blackboard.attacks_done + 1
	blackboard.attack_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_shout_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_shout_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_order_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_order_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_scurry_under_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_scurry_under_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_dig_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_dig_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_push_ragdoll_finished = function (unit, param)
	local breed = Unit.get_data(unit, "breed")
	local animation_system = Managers.state.entity:system("animation_system")

	animation_system.add_ragdoll_to_update_list(animation_system, unit, breed)

	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)

	network_manager.network_transmit:send_rpc_clients("rpc_add_ragdoll_to_update_list", unit_id)

	return 
end
AnimationCallbackTemplates.server.anim_cb_attack_throw_score_finished = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.anim_cb_attack_throw_score_finished = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_attack_jump_start_finished = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.anim_cb_attack_jump_start_finished = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_attack_shoot_start_finished = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.anim_cb_attack_shoot_start_finished = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_reload_start_finished = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.anim_cb_reload_start_finished = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_attack_windup_start_finished = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.anim_cb_attack_windup_start_finished = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_attack_shoot_random_shot = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.anim_cb_attack_shoot_random_shot = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_stormvermin_voice = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.anim_cb_stormvermin_voice = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_stormvermin_patrol_sound = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.anim_cb_stormvermin_patrol_sound = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_exit_shooting_hit_react = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.in_hit_reaction = nil
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_enter_shooting_hit_react = function (unit, param)
	local ai_base_extension = ScriptUnit.has_extension(unit, "ai_system")

	if ai_base_extension then
		local blackboard = ai_base_extension.blackboard(ai_base_extension)
		blackboard.in_hit_reaction = true
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_stormvermin_push = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	local target_unit = blackboard.attacking_target
	local active_node = blackboard.active_node

	if not active_node or blackboard.attack_aborted or not AiUtils.unit_alive(target_unit) then
		return 
	end

	local anim_cb = active_node.anim_cb_stormvermin_push

	if anim_cb then
		anim_cb(active_node, unit, blackboard, target_unit)
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_stormvermin_push_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.attack_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_ratogre_slam = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	local active_node = blackboard.active_node

	if not active_node or blackboard.attack_aborted then
		return 
	end

	local anim_cb = active_node.anim_cb_ratogre_slam

	if anim_cb then
		anim_cb(active_node, unit, blackboard)
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_shove_done = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	local active_node = blackboard.active_node

	if not active_node or blackboard.attack_aborted then
		return 
	end

	local anim_cb = active_node.anim_cb_shove_done

	if anim_cb then
		anim_cb(active_node, unit, blackboard)
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_change_target_finished = function (unit, param)
	local ai_system = Managers.state.entity:system("ai_system")
	local blackboard = ai_system.blackboards[unit]
	local active_node = blackboard.active_node

	if not active_node then
		return 
	end

	local anim_cb = active_node.anim_cb_change_target_finished

	if anim_cb then
		anim_cb(active_node, unit, blackboard)
	end

	return 
end
AnimationCallbackTemplates.server.anim_cb_dodge_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_dodge_finished = true

	return 
end
AnimationCallbackTemplates.server.anim_cb_teleport_finished = function (unit, param)
	local blackboard = Unit.get_data(unit, "blackboard")
	blackboard.anim_cb_teleport_finished = true

	return 
end

return 
