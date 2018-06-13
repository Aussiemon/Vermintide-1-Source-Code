require("scripts/unit_extensions/generic/aim_templates")

GenericUnitAimExtension = class(GenericUnitAimExtension)

GenericUnitAimExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.template = extension_init_data.template or Unit.get_data(unit, "aim_template")
	self.network_type = (extension_init_data.is_husk and "husk") or "owner"
	self.data = {}
end

GenericUnitAimExtension.extensions_ready = function (self)
	local template = AimTemplates[self.template]

	template[self.network_type].init(self.unit, self.data)
end

GenericUnitAimExtension.destroy = function (self)
	return
end

GenericUnitAimExtension.reset = function (self)
	return
end

GenericUnitAimExtension.update = function (self, unit, input, dt, context, t)
	local template = AimTemplates[self.template]

	template[self.network_type].update(unit, t, dt, self.data)
end

return
