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
			self._mission_updated = true
		end
	end

	return 
end

return 
