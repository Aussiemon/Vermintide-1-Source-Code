require("scripts/unit_extensions/generic/death_reactions")

local DeathReactions = DeathReactions
GenericDeathExtension = class(GenericDeathExtension)
DeathReactions_profiler_names = DeathReactions_profiler_names or {}
local profiler_names = DeathReactions_profiler_names
GenericDeathExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.network_type = extension_init_data.is_husk
	local is_husk = extension_init_data.is_husk

	if is_husk == nil then
		is_husk = not Managers.player.is_server
	end

	self.is_husk = is_husk
	self.network_type = (is_husk and "husk") or "unit"
	self.is_alive = true
	self.unit = unit
	self.death_reaction_template = extension_init_data.death_reaction_template or Unit.get_data(unit, "death_reaction")
	self.second_hit_ragdoll = not extension_init_data.disable_second_hit_ragdoll

	assert(self.death_reaction_template)

	profiler_names[self.death_reaction_template] = profiler_names[self.death_reaction_template] or {
		"start_" .. self.death_reaction_template,
		"update_" .. self.death_reaction_template
	}

	return 
end
GenericDeathExtension.extensions_ready = function (self, world, unit)
	self.damage_extension = ScriptUnit.extension(unit, "damage_system")

	assert(self.damage_extension)

	self.health_extension = ScriptUnit.extension(unit, "health_system")

	assert(self.health_extension)

	return 
end
GenericDeathExtension.destroy = function (self)
	return 
end
GenericDeathExtension.force_end = function (self)
	if not self.death_is_done and Unit.alive(self.unit) and not self.is_alive then
		Managers.state.unit_spawner:mark_for_deletion(self.unit)

		self.death_is_done = true
	end

	return 
end
GenericDeathExtension.is_wall_nailed = function (self)
	return (self.cached_wall_nail_data and true) or false
end
GenericDeathExtension.nailing_hit = function (self, hit_ragdoll_actor, attack_direction, hit_speed)
	local reaction_data = self.death_reaction_data

	fassert(Vector3.is_valid(attack_direction), "Attack direction is not valid.")

	if reaction_data then
		local data = reaction_data.wall_nail_data
		data[hit_ragdoll_actor] = data[hit_ragdoll_actor] or {
			attack_direction = Vector3Box(attack_direction),
			hit_speed = hit_speed
		}
	else
		local wall_nail_data = {}
		local data = {
			attack_direction = Vector3Box(attack_direction),
			hit_speed = hit_speed
		}
		wall_nail_data[hit_ragdoll_actor] = data
		self.cached_wall_nail_data = wall_nail_data
	end

	return 
end
GenericDeathExtension.enable_second_hit_ragdoll = function (self)
	self.second_hit_ragdoll = true

	return 
end
GenericDeathExtension.second_hit_ragdoll_allowed = function (self)
	return self.second_hit_ragdoll
end
GenericDeathExtension.has_death_started = function (self)
	return self.death_reaction ~= nil
end

return 
