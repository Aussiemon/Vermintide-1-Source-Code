TargetOverrideExtension = class(TargetOverrideExtension)
local OVERRIDE_RADIUS = 0.75
local OVERRIDE_LIFETIME = 5

TargetOverrideExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.result_table = {}
	self.num_ai_units_in_result = 0
end

TargetOverrideExtension.destroy = function (self)
	return
end

TargetOverrideExtension.update = function (self, unit, input, dt, context, t)
	local position = POSITION_LOOKUP[unit]
	local radius = OVERRIDE_RADIUS
	local result_table = self.result_table
	local override_time = t + OVERRIDE_LIFETIME
	local status_extension = ScriptUnit.extension(unit, "status_system")
	local incapacitated = status_extension:is_disabled()

	if not incapacitated then
		local ai_system = Managers.state.entity:system("ai_system")
		local ai_slot_system = Managers.state.entity:system("ai_slot_system")
		local num_ai_units = AiUtils.broadphase_query(position, radius, result_table)
		self.num_ai_units_in_result = num_ai_units

		for i = 1, num_ai_units, 1 do
			local ai_unit = result_table[i]

			if ScriptUnit.has_extension(ai_unit, "ai_slot_system") then
				local ai_extension = ScriptUnit.extension(ai_unit, "ai_system")
				local ai_blackboard = ai_extension:blackboard()
				local previous_override_time = ai_blackboard.override_targets[unit]
				ai_blackboard.override_targets[unit] = override_time

				if previous_override_time == nil or previous_override_time < t then
					ai_system:register_prioritized_perception_unit_update(ai_unit, ai_extension)
					ai_slot_system:register_prioritized_ai_unit_update(ai_unit)
				end
			end
		end
	end
end

TargetOverrideExtension.add_to_override_targets = function (self, ai_unit, target_unit, ai_unit_blackboard, t)
	local override_time = t + OVERRIDE_LIFETIME
	local previous_override_time = ai_unit_blackboard.override_targets[target_unit]
	ai_unit_blackboard.override_targets[target_unit] = override_time

	if previous_override_time == nil or previous_override_time < t then
		local ai_system = Managers.state.entity:system("ai_system")
		local ai_slot_system = Managers.state.entity:system("ai_slot_system")
		local ai_extension = ScriptUnit.extension(ai_unit, "ai_system")

		ai_system:register_prioritized_perception_unit_update(ai_unit, ai_extension)
		ai_slot_system:register_prioritized_ai_unit_update(ai_unit)
	end
end

return
