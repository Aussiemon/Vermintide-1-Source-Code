TimedProjectileExtension = class(TimedProjectileExtension)

TimedProjectileExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.unit = unit
	self.stop_time = extension_init_data.stop_time
	self.projectile_template_name = extension_init_data.projectile_template_name
	self.is_server = Managers.player.is_server
	self.item_name = extension_init_data.item_name
	self.has_executed = false
end

TimedProjectileExtension.destroy = function (self)
	return
end

TimedProjectileExtension.update = function (self, unit, input, dt, context, t)
	if not self.has_executed and self.stop_time <= t then
		self:execute()
	end
end

TimedProjectileExtension.execute = function (self)
	self.has_executed = true
	local projectile_template_name = self.projectile_template_name
	local template = ProjectileTemplates.get_timed_template(self.projectile_template_name)

	if self.is_server then
		template.server.execute(self.world, self.unit)
	end

	template.client.execute(self.world, self.unit)
end

return
