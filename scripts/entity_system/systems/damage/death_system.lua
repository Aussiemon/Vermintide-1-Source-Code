require("scripts/unit_extensions/generic/generic_health_extension")
require("scripts/unit_extensions/generic/rat_ogre_health_extension")
require("scripts/unit_extensions/default_player_unit/player_unit_health_extension")

DeathSystem = class(DeathSystem, ExtensionSystemBase)
local script_data = script_data
local RPCS = {}
local extensions = {
	"GenericDeathExtension",
	"ExplosiveBarrelDeathExtension"
}
DeathReactions_profiler_names = DeathReactions_profiler_names or {
	unit = {},
	husk = {}
}
local profiler_names = DeathReactions_profiler_names
DeathSystem.init = function (self, entity_system_creation_context, system_name)
	DeathSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate.register(network_event_delegate, self, unpack(RPCS))

	self.unit_extensions = {}
	self.waiting_units = {}
	self.active_reactions = {
		unit = {},
		husk = {}
	}

	return 
end
DeathSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)

	return 
end
DeathSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local extension = ScriptUnit.add_extension(self.extension_init_context, unit, extension_name, self.NAME, extension_init_data)
	self.unit_extensions[unit] = extension
	local template = extension.death_reaction_template
	local network_type = extension.network_type
	local active_reactions = self.active_reactions[network_type]
	active_reactions[template] = active_reactions[template] or {}
	profiler_names[network_type][template] = profiler_names[network_type][template] or {
		"start_" .. template,
		"update_" .. template
	}

	if extension.is_alive then
		self.waiting_units[unit] = extension
	elseif not extension.death_is_done then
		self.active_reactions[extension.network_type][extension.death_reaction_template][unit] = extension
	end

	return extension
end
DeathSystem.extensions_ready = function (self, world, unit)
	local extension = self.unit_extensions[unit]
	extension.damage_extension = ScriptUnit.extension(unit, "damage_system")

	assert(extension.damage_extension)

	return 
end
DeathSystem.on_remove_extension = function (self, unit, extension_name)
	assert(ScriptUnit.has_extension(unit, self.NAME), "Trying to remove non-existing extension %q from unit %s", extension_name, unit)
	ScriptUnit.remove_extension(unit, self.NAME)

	local extension = self.unit_extensions[unit]
	self.unit_extensions[unit] = nil
	self.waiting_units[unit] = nil
	self.active_reactions[extension.network_type][extension.death_reaction_template][unit] = nil

	return 
end
DeathSystem.hot_join_sync = function (self, sender)
	return 
end
local dummy_input = {}
DeathSystem.update = function (self, context, t)
	local dt = context.dt
	local DeathReactions = DeathReactions
	local IS_DONE = DeathReactions.IS_DONE
	local profiler_names = profiler_names
	local active_reactions = self.active_reactions
	local waiting_units = self.waiting_units

	Profiler.start("active_reactions")

	for network_type, templates in pairs(active_reactions) do
		for template, units in pairs(templates) do
			local death_reaction = DeathReactions.templates[template][network_type]

			for unit, extension in pairs(units) do
				Profiler.start(profiler_names[network_type][template][2])

				local death_is_done = death_reaction.update(unit, dt, context, t, extension.death_reaction_data)

				Profiler.stop(profiler_names[network_type][template][2])

				if death_is_done == IS_DONE then
					Unit.flow_event(unit, "lua_dead")

					extension.death_is_done = true
					active_reactions[network_type][template][unit] = nil
				end
			end
		end
	end

	Profiler.stop()
	Profiler.start("waiting_units")

	for unit, extension in pairs(waiting_units) do
		local health_extension = extension.health_extension

		if health_extension.health <= health_extension.damage then
			waiting_units[unit] = nil
			local damage_extension = extension.damage_extension
			local kill_damages, num_kill_damages = damage_extension.recent_damages(damage_extension)
			local i = 1

			while kill_damages[(i - 1)*DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_TYPE] == "heal" do
				i = i + 1
			end

			assert(i*DamageDataIndex.STRIDE <= num_kill_damages, "Could not find any killing blow that killed unit %s. It seems like all damages was heal-type. Amount of damages taken this frame was %d", unit, i/DamageDataIndex.STRIDE)

			local killing_blow = FrameTable.alloc_table()

			pack_index[DamageDataIndex.STRIDE](killing_blow, 1, unpack_index[DamageDataIndex.STRIDE](kill_damages, (i - 1)*DamageDataIndex.STRIDE + 1))

			local death_reaction = DeathReactions.templates[extension.death_reaction_template][extension.network_type]

			Profiler.start(profiler_names[extension.network_type][extension.death_reaction_template][1])

			local death_reaction_data, death_is_done = death_reaction.start(unit, dt, context, t, killing_blow, self.is_server, extension.cached_wall_nail_data)

			Profiler.stop()

			if death_is_done == IS_DONE then
				Unit.flow_event(unit, "lua_dead")
			else
				self.active_reactions[extension.network_type][extension.death_reaction_template][unit] = extension
			end

			if self.is_server then
				local blackboard = Unit.get_data(unit, "blackboard")

				if blackboard then
					local breed = blackboard.breed

					if breed.run_on_death then
						Profiler.start("run_on_death")
						breed.run_on_death(unit, blackboard)
						Profiler.stop()
					end
				end
			end

			extension.death_reaction = death_reaction
			extension.death_reaction_data = death_reaction_data
			extension.death_is_done = death_is_done == DeathReactions.IS_DONE
		end
	end

	Profiler.stop()

	return 
end

return 
