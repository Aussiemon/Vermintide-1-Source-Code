WizardWardHealthExtension = class(WizardWardHealthExtension, GenericHealthExtension)
WizardWardHealthExtension.init = function (self, extension_init_context, unit, extension_init_data)
	WizardWardHealthExtension.super.init(self, extension_init_context, unit, extension_init_data)

	self._mission_updated = false

	return 
end
WizardWardHealthExtension.update = function (self, dt, context, t)
	WizardWardHealthExtension.super.update(self, dt, context, t)

	if self.is_server then
		local health_percent = self.current_health_percent(self)

		if health_percent < 0.5 and not self._mission_updated then
			local mission_system = Managers.state.entity:system("mission_system")

			mission_system.increment_goal_mission_counter(mission_system, "wizards_tower_protect_wards", 1, true)

			self._mission_updated = true
		end
	end

	return 
end

return 
