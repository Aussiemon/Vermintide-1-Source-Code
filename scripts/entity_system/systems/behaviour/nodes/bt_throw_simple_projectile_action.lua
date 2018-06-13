require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local function randomize(event)
	if type(event) == "table" then
		return event[Math.random(1, #event)]
	else
		return event
	end
end

BTThrowSimpleProjectileAction = class(BTThrowSimpleProjectileAction, BTNode)

BTThrowSimpleProjectileAction.init = function (self, ...)
	BTThrowSimpleProjectileAction.super.init(self, ...)
end

BTThrowSimpleProjectileAction.name = "BTThrowSimpleProjectileAction"
local THROW_PATTERNS = {
	ninja_star_cluster = {
		spread_function = function (data, i, aim_rotation)
			local spread = math.pi / 64
			local roll = Math.random() * math.pi * 2
			local sideways_projection = math.abs(math.sin(roll))
			local pitch = (i - Math.random()) * spread * (0.25 + sideways_projection * 0.75)

			return Quaternion.multiply(Quaternion.multiply(aim_rotation, Quaternion(Vector3.forward(), roll)), Quaternion(Vector3.right(), pitch))
		end
	},
	ninja_star_arc = {
		spread_function = function (data, i, aim_rotation)
			if i == 1 then
				data.roll = Math.random() * math.pi * 0.08333333333333333

				return Quaternion.multiply(aim_rotation, Quaternion(Vector3.forward(), data.roll))
			elseif i % 2 == 0 then
				local i_left = i / 2
				local yaw = i_left * math.pi * 0.016666666666666666

				return Quaternion.multiply(Quaternion.multiply(aim_rotation, Quaternion(Vector3.forward(), data.roll)), Quaternion(-Vector3.up(), yaw))
			else
				local i_right = (i + 1) / 2
				local yaw = i_right * math.pi * 0.016666666666666666

				return Quaternion.multiply(Quaternion.multiply(aim_rotation, Quaternion(Vector3.forward(), data.roll)), Quaternion(Vector3.up(), yaw))
			end
		end
	}
}

BTThrowSimpleProjectileAction.enter = function (self, unit, blackboard, t)
	local action = self._tree_node.action_data
	blackboard.action = action
	blackboard.active_node = BTThrowSimpleProjectileAction
	local throw_attack = randomize(action.attacks)
	local network_manager = Managers.state.network

	network_manager:anim_event(unit, "to_combat")
	network_manager:anim_event(unit, throw_attack.attack_anim)

	local navigation_extension = blackboard.navigation_extension

	blackboard.navigation_extension:set_enabled(false)
	blackboard.locomotion_extension:set_wanted_velocity(Vector3.zero())

	local target_unit = blackboard.throw_projectile_at
	blackboard.throw_projectile_at = nil
	local aim_pos = self:_aim_to_position(self:_aim_from_position(unit), target_unit, throw_attack.projectile_speed)
	blackboard.throw_data = {
		thrown = false,
		throw_time = t + 0.5,
		end_time = t + 1.5,
		attack = throw_attack,
		target_unit = target_unit,
		aim_position = Vector3Box(aim_pos)
	}
end

BTThrowSimpleProjectileAction.leave = function (self, unit, blackboard, t)
	blackboard.move_state = nil
	blackboard.active_node = nil

	blackboard.navigation_extension:set_enabled(true)

	blackboard.throw_data = nil
	blackboard.last_throw = t

	Managers.state.network:anim_event(unit, "idle")
end

BTThrowSimpleProjectileAction._throw = function (self, unit, blackboard, action, throw_data, from_position, aim_rotation)
	local projectile_system = Managers.state.entity:system("projectile_system")
	local damage_source = Unit.get_data(unit, "breed").name
	local throw_attack = blackboard.throw_data.attack
	local spread_function = THROW_PATTERNS[throw_attack.pattern_name].spread_function
	local data = {}
	local impact_data = table.clone(action.impact_data)
	local difficulty_rank = Managers.state.difficulty:get_difficulty_rank()
	impact_data.attack_template_damage_type = action.attack_template_damage_type[difficulty_rank]

	for i = 1, throw_attack.num_projectiles, 1 do
		local direction = Quaternion.forward(spread_function(data, i, aim_rotation))

		projectile_system:create_light_weight_projectile(damage_source, unit, from_position, direction, throw_attack.projectile_speed, throw_attack.projectile_max_range, action.collision_filter, impact_data, action.light_weight_projectile_particle_effect)
	end

	throw_data.thrown = true
end

BTThrowSimpleProjectileAction._aim_to_position = function (self, from_position, target_unit, projectile_speed, old_position)
	if Unit.alive(target_unit) then
		local target_position = Unit.local_position(target_unit, 0) + Vector3(0, 0, 1.5)
		local target_vector = target_position - from_position
		local distance = Vector3.length(target_vector)
		local target_velocity = ScriptUnit.extension(target_unit, "locomotion_system"):current_velocity()
		local predict_position = nil

		for i = 1, 3, 1 do
			predict_position = target_position + target_velocity * distance / projectile_speed
			distance = Vector3.length(predict_position - from_position)
		end

		return predict_position
	else
		return old_position
	end
end

BTThrowSimpleProjectileAction._aim_from_position = function (self, unit)
	return Unit.local_position(unit, 0) + Vector3(0, 0, 0.75)
end

BTThrowSimpleProjectileAction.run = function (self, unit, blackboard, t, dt)
	local data = blackboard.throw_data
	local action = blackboard.action
	local from_position = self:_aim_from_position(unit)
	local to_position = self:_aim_to_position(from_position, data.target_unit, data.attack.projectile_speed, data.aim_position:unbox())
	local aim_rotation = Quaternion.look(to_position - from_position, Vector3.up())
	local locomotion_extension = blackboard.locomotion_extension
	local flat_aim_rotation = Quaternion.look(Vector3.flat(Quaternion.forward(aim_rotation)), Vector3.up())

	locomotion_extension:set_wanted_rotation(flat_aim_rotation)

	if not data.thrown and data.throw_time < t then
		self:_throw(unit, blackboard, action, data, from_position, aim_rotation)
	end

	if data.end_time < t then
		return "done"
	else
		return "running"
	end
end

return
