ActionBulletSpray = class(ActionBulletSpray)
local POSITION_TWEAK = -1
local SPRAY_RANGE = math.abs(POSITION_TWEAK) + 5
local SPRAY_RADIUS = 3.5
local MAX_TARGETS = 10
local NODES = {
	"j_leftshoulder",
	"j_rightshoulder",
	"j_spine1"
}
ActionBulletSpray.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.owner_unit = owner_unit
	self.owner_unit_first_person = first_person_unit
	self.weapon_unit = weapon_unit
	self.item_name = item_name
	self.is_server = is_server
	self.world = world

	if ScriptUnit.has_extension(weapon_unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(weapon_unit, "ammo_system")
	end

	self.targets = {}

	if ScriptUnit.has_extension(weapon_unit, "overcharge_system") then
		self.overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	end

	return 
end
ActionBulletSpray.client_owner_start_action = function (self, new_action, t)
	self.current_action = new_action
	self._target_index = 1
	self.shot = false

	if new_action.use_ammo_at_time then
		self.use_ammo_time = t + new_action.use_ammo_at_time
		self.used_ammo = false
	end

	local cone_hypotenuse = math.sqrt(SPRAY_RANGE*SPRAY_RANGE + SPRAY_RADIUS*SPRAY_RADIUS)
	self.CONE_COS_ALPHA = SPRAY_RANGE/cone_hypotenuse

	self.overcharge_extension:add_charge(new_action.overcharge_type)

	return 
end
ActionBulletSpray.client_owner_post_update = function (self, dt, t, world, can_damage)
	local current_action = self.current_action
	local owner_unit_1p = self.owner_unit_first_person
	local player_position = POSITION_LOOKUP[owner_unit_1p]
	local player_rotation = Unit.world_rotation(owner_unit_1p, 0)
	local player_direction = Vector3.normalize(Quaternion.forward(player_rotation))
	local targets = self.targets
	local target_index = self._target_index

	if #targets == 0 and not self.shot then
		self._select_targets(self, world, true)

		local fire_sound_event = self.current_action.fire_sound_event

		if fire_sound_event then
			local first_person_extension = ScriptUnit.extension(self.owner_unit, "first_person_system")

			first_person_extension.play_hud_sound_event(first_person_extension, fire_sound_event)
		end
	end

	if self.use_ammo_time and not self.used_ammo and self.use_ammo_time <= t then
		self.used_ammo = true
		local ammo_extension = self.ammo_extension

		if ammo_extension then
			ammo_extension.use_ammo(ammo_extension, self.current_action.ammo_usage)
		end
	end

	local physics_world = World.get_data(world, "physics_world")
	local current_target = targets[target_index]

	if Unit.alive(current_target) then
		local node = nil
		local rand = math.random()
		local chance = #NODES/1
		local cumalative_value = 0

		for i = 1, #NODES, 1 do
			cumalative_value = cumalative_value + chance

			if rand <= cumalative_value then
				node = NODES[i]

				break
			end
		end

		local target_position = Unit.world_position(current_target, Unit.node(current_target, node))
		local direction = Vector3.normalize(target_position - player_position)
		local result = self.raycast_to_target(self, world, player_position, direction, current_target)
		local target = nil

		if current_action.area_damage then
			target = current_target
		end

		if result then
			DamageUtils.process_projectile_hit(world, self.item_name, self.owner_unit, self.is_server, result, current_action, direction, true, target)
		end
	end

	self._target_index = target_index + 1

	return 
end
ActionBulletSpray.finish = function (self, reason)
	self._clear_targets(self)

	local ammo_extension = self.ammo_extension

	if ammo_extension and self.current_action.reload_when_out_of_ammo and ammo_extension.ammo_count(ammo_extension) == 0 and ammo_extension.can_reload(ammo_extension) then
		local play_reload_animation = true

		ammo_extension.start_reload(ammo_extension, play_reload_animation)
	end

	return 
end
ActionBulletSpray._clear_targets = function (self)
	table.clear(self.targets)

	return 
end
ActionBulletSpray._select_targets = function (self, world, show_outline)
	local physics_world = World.get_data(world, "physics_world")
	local owner_unit_1p = self.owner_unit_first_person
	local player_position = POSITION_LOOKUP[owner_unit_1p]
	local player_rotation = Unit.world_rotation(owner_unit_1p, 0)
	local player_direction = Vector3.normalize(Quaternion.forward(player_rotation))
	local start_point = player_position + player_direction*POSITION_TWEAK + player_direction*SPRAY_RADIUS
	local end_point = player_position + player_direction*POSITION_TWEAK + player_direction*(SPRAY_RANGE - SPRAY_RADIUS)

	PhysicsWorld.prepare_actors_for_overlap(physics_world, start_point, SPRAY_RANGE*SPRAY_RANGE)

	local result = PhysicsWorld.linear_sphere_sweep(physics_world, start_point, end_point, SPRAY_RADIUS, 100, "collision_filter", "filter_enemy_unit", "report_initial_overlap")

	if result then
		local num_hits = #result
		local targets = self.targets
		local v, q, m = Script.temp_count()

		for i = 1, num_hits, 1 do
			local hit = result[i]
			local hit_actor = hit.actor
			local hit_unit = Actor.unit(hit_actor)
			local breed = Unit.get_data(hit_unit, "breed")

			if breed and self._is_infront_player(self, player_position, player_direction, hit_unit) and self._check_within_cone(self, player_position, player_direction, hit_unit) then
				targets[#targets + 1] = hit_unit

				if MAX_TARGETS <= #targets then
					break
				end
			end
		end

		Script.set_temp_count(v, q, m)
	end

	self.shot = true

	return 
end
ActionBulletSpray._check_within_cone = function (self, player_position, player_direction, target)
	local CONE_COS_ALPHA = self.CONE_COS_ALPHA
	local target_position = Unit.world_position(target, Unit.node(target, "j_neck"))
	local target_direction = Vector3.normalize(target_position - player_position)
	local target_cos_alpha = Vector3.dot(player_direction, target_direction)

	if CONE_COS_ALPHA <= target_cos_alpha then
		return true
	end

	return false
end
ActionBulletSpray._is_infront_player = function (self, player_position, player_direction, hit_unit)
	local hit_unit_position = Unit.world_position(hit_unit, 0)
	local player_to_hit_unit_dir = Vector3.normalize(hit_unit_position - player_position)
	local dot = Vector3.dot(player_to_hit_unit_dir, player_direction)

	if 0 < dot then
		return true
	end

	return 
end
ActionBulletSpray.raycast_to_target = function (self, world, from_position, direction, target)
	local physics_world = World.get_data(world, "physics_world")
	local collision_filter = "filter_player_ray_projectile"
	local result = PhysicsWorld.immediate_raycast(physics_world, from_position, direction, "all", "collision_filter", collision_filter)

	return result
end

return 
