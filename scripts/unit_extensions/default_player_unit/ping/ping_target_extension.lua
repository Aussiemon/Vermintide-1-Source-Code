PingTargetExtension = class(PingTargetExtension)

PingTargetExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._world = extension_init_context.world
	self._unit = unit
	self._pinged = false
end

PingTargetExtension.extensions_ready = function (self, world, unit)
	if ScriptUnit.has_extension(unit, "outline_system") then
		self.outline_extension = ScriptUnit.extension(unit, "outline_system")
	end
end

PingTargetExtension.set_pinged = function (self, pinged)
	self._pinged = pinged

	if self.outline_extension then
		self.outline_extension.set_pinged(pinged)
	end
end

PingTargetExtension.pinged = function (self)
	return self._pinged
end

PingTargetExtension.update = function (self, unit, input, dt, context, t)
	if self._pinged and self.outline_extension then
	end
end

PingTargetExtension.destroy = function (self)
	return
end

return
