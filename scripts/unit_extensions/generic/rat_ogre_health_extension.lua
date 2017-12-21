RatOgreHealthExtension = class(RatOgreHealthExtension, GenericHealthExtension)
RatOgreHealthExtension.init = function (self, extension_init_context, unit, ...)
	RatOgreHealthExtension.super.init(self, extension_init_context, unit, ...)

	self._wounded_anim_variable = Unit.animation_find_variable(unit, "wounded")

	return 
end
RatOgreHealthExtension.update = function (self, dt, ...)
	local unit = self.unit
	local min_wounded = 0.5
	local max_wounded = 0.6
	local wounded_value = math.auto_lerp(min_wounded, max_wounded, 0, 1, math.clamp(self.damage/self.health, min_wounded, max_wounded))

	Unit.animation_set_variable(unit, self._wounded_anim_variable, wounded_value)

	return 
end

return 
