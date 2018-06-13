ProjectileSphereSweepImpactUnitExtension = class(ProjectileSphereSweepImpactUnitExtension, ProjectileBaseImpactUnitExtension)

ProjectileSphereSweepImpactUnitExtension.init = function (self, extension_init_context, unit, extension_init_data)
	ProjectileSphereSweepImpactUnitExtension.super.init(self, extension_init_context, unit, extension_init_data)

	local collision_filter = "filter_player_ray_projectile"
	self.collision_filter = extension_init_data.collision_filter or collision_filter
	self.network_manager = Managers.state.network
	self.owner_unit = extension_init_data.owner_unit
	local owner_player = Managers.player:owner(self.owner_unit)
	self.owner_is_local = (owner_player and owner_player.local_player) or false
	self.server_side_raycast = extension_init_data.server_side_raycast
	self.is_server = Managers.player.is_server
	self.radius = extension_init_data.radius
end

ProjectileSphereSweepImpactUnitExtension.extensions_ready = function (self, world, unit)
	self.locomotion_extension = ScriptUnit.extension(unit, "projectile_locomotion_system")
end

ProjectileSphereSweepImpactUnitExtension.update = function (self, unit, input, dt, context, t)
	ProjectileSphereSweepImpactUnitExtension.super.update(self, unit, input, dt, context, t)

	if self.server_side_raycast and not self.is_server then
		return
	end

	if not self.server_side_raycast and not self.owner_is_local then
		return
	end

	local locomotion_extension = self.locomotion_extension

	if not locomotion_extension:moved_this_frame() then
		return
	end

	local velocity = locomotion_extension:current_velocity()
	local cached_position = POSITION_LOOKUP[unit]
	local moved_position = cached_position + velocity
	local physics_world = self.physics_world
	local radius = self.radius
	local result = PhysicsWorld.linear_sphere_sweep(physics_world, cached_position, moved_position, radius, 100, "collision_filter", self.collision_filter, "report_initial_overlap")
	local unit = self.unit

	if result then
		local direction = Vector3.normalize(moved_position - cached_position)
		local num_hits = #result

		for i = 1, num_hits, 1 do
			local hit = result[i]
			local hit_actor = hit.actor
			local hit_position = hit.position
			local hit_normal = hit.normal
			local hit_distance = hit.distance
			local hit_unit = Actor.unit(hit_actor)
			local hit_self = hit_unit == unit

			if not hit_self then
				local num_actors = Unit.num_actors(hit_unit)
				local actor_index = nil

				for j = 0, num_actors - 1, 1 do
					local actor = Unit.actor(hit_unit, j)

					if hit_actor == actor then
						actor_index = j

						break
					end
				end

				assert(actor_index)
				self:impact(hit_unit, hit_position, direction, hit_normal, actor_index)

				local network_manager = self.network_manager
				local unit_id = network_manager:unit_game_object_id(self.unit)

				if ScriptUnit.has_extension(hit_unit, "locomotion_system") then
					local hit_unit_id = network_manager:unit_game_object_id(hit_unit)

					if self.is_server then
						network_manager.network_transmit:send_rpc_clients("rpc_projectile_impact_character", unit_id, hit_unit_id, hit_position, direction, hit_normal, actor_index)
					else
						network_manager.network_transmit:send_rpc_server("rpc_projectile_impact_character", unit_id, hit_unit_id, hit_position, direction, hit_normal, actor_index)
					end
				else
					local level = LevelHelper:current_level(self.world)
					local hit_unit_id = Level.unit_index(level, hit_unit)

					if hit_unit_id then
						if self.is_server then
							network_manager.network_transmit:send_rpc_clients("rpc_projectile_impact_level", unit_id, hit_unit_id, hit_position, direction, hit_normal, actor_index)
						else
							network_manager.network_transmit:send_rpc_server("rpc_projectile_impact_level", unit_id, hit_unit_id, hit_position, direction, hit_normal, actor_index)
						end
					end
				end
			end
		end
	end

	if script_data.debug_projectiles then
		QuickDrawerStay:sphere(cached_position, radius, Color(255, 255, 0, 0))
		QuickDrawerStay:sphere(moved_position, radius, Color(255, 0, 255, 0))
		QuickDrawerStay:line(moved_position, cached_position, Color(255, 0, 255, 255))
	end
end

return
