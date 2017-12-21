ExplosiveBarrelDeathExtension = class(ExplosiveBarrelDeathExtension, GenericDeathExtension)
ExplosiveBarrelDeathExtension.init = function (self, extension_init_context, unit, extension_init_data)
	ExplosiveBarrelDeathExtension.super.init(self, extension_init_context, unit, extension_init_data)

	self.item_name = extension_init_data.item_name
	self.in_hand = extension_init_data.in_hand
	self.notified_bots = false
	local death_data = extension_init_data.death_data

	if death_data then
		self.is_alive = false
		self.death_reaction = DeathReactions.get_reaction(self.death_reaction_template, self.is_husk)
		self.death_reaction_data = death_data

		Unit.flow_event(unit, "exploding_barrel_fuse_init")

		self.death_reaction_data.played_fuse_out = nil
		self.death_is_done = false
	end

	return 
end
ExplosiveBarrelDeathExtension.destroy = function (self)
	ExplosiveBarrelDeathExtension.super.destroy(self)

	if self.death_reaction_data and self.death_reaction_data.nav_tag_volume_id then
		local volume_system = Managers.state.entity:system("volume_system")

		volume_system.destroy_nav_tag_volume(volume_system, self.death_reaction_data.nav_tag_volume_id)

		self.death_reaction_data.nav_tag_volume_id = nil
	end

	return 
end

return 
