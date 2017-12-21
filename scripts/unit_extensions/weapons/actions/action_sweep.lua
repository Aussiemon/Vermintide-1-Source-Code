local function calculate_attack_direction(action, weapon_rotation)
	local quaternion_axis = action.attack_direction or "forward"
	local attack_direction = Quaternion[quaternion_axis](weapon_rotation)

	return (action.invert_attack_direction and -attack_direction) or attack_direction
end

ActionSweep = class(ActionSweep)
ActionSweep.init = function (self, world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	self.world = world
	self.owner_unit = owner_unit
	self.weapon_unit = weapon_unit
	self.item_name = item_name
	self.weapon_system = weapon_system
	self.is_critical_strike = false
	self.has_played_rumble_effect = false
	self.owner = Managers.player:unit_owner(self.owner_unit)
	self.stored_half_extents = Vector3Box()
	self.stored_position = Vector3Box()
	self.stored_rotation = QuaternionBox()
	local weapon_pose, weapon_half_extents = Unit.box(damage_unit)

	self.stored_half_extents:store(weapon_half_extents)

	self.hit_units = {}
	self.could_damage_last_update = false
	self.status_extension = ScriptUnit.extension(owner_unit, "status_system")
	self.is_server = is_server
	self.action_buff_data = {}
	self._drawer = Managers.state.debug:drawer({
		mode = "retained",
		name = "weapon_system"
	})

	return 
end
ActionSweep.client_owner_start_action = function (self, new_action, t)
	self.has_played_rumble_effect = false
	self.current_action = new_action
	self.action_time_started = t
	self.has_hit_environment = false
	self.has_hit_target = false
	self.target_breed_unit = nil
	self.number_of_hit_enemies = 0
	self.down_offset = new_action.sweep_z_offset or 0.1
	self.auto_aim_reset = false

	if not Managers.player:owner(self.owner_unit).bot_player then
		Managers.state.controller_features:add_effect("rumble", {
			rumble_effect = "light_swing"
		})
	end

	local owner_unit = self.owner_unit
	local owner_player = Managers.player:owner(owner_unit)
	self.buff_extension = ScriptUnit.extension(owner_unit, "buff_system")

	if global_is_inside_inn then
		self.down_offset = 0
	end

	self.attack_aborted = false

	for k, v in pairs(self.hit_units) do
		self.hit_units[k] = nil
	end

	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
	local physics_world = World.get_data(self.world, "physics_world")
	local pos = first_person_extension.current_position(first_person_extension)
	local rot = first_person_extension.current_rotation(first_person_extension)
	local direction = Quaternion.forward(rot)
	local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
	local collision_filter = (DamageUtils.allow_friendly_fire_melee(difficulty_settings, owner_player) and "filter_melee_sweep") or "filter_melee_sweep_no_player"
	local results = PhysicsWorld.immediate_raycast(physics_world, pos, direction, new_action.dedicated_target_range, "all", "collision_filter", collision_filter)

	if results then
		local num_results = #results

		for i = 1, num_results, 1 do
			local result = results[i]
			local actor = result[4]
			local hit_unit = Actor.unit(actor)
			local breed = Unit.get_data(hit_unit, "breed")

			if breed then
				local node = Actor.node(actor)
				local hit_zone = breed.hit_zones_lookup[node]

				if hit_zone.name ~= "afro" then
					local health_extension = ScriptUnit.extension(hit_unit, "health_system")

					if health_extension.is_alive(health_extension) then
						self.target_breed_unit = hit_unit

						break
					end
				end
			end
		end
	end

	local weapon_unit = self.weapon_unit
	local actual_position_initial = POSITION_LOOKUP[weapon_unit]
	local position_initial = Vector3(actual_position_initial.x, actual_position_initial.y, actual_position_initial.z - self.down_offset)

	self.stored_position:store(position_initial)
	self.stored_rotation:store(Unit.world_rotation(weapon_unit, 0))

	self.could_damage_last_update = false

	self._drawer:reset()

	return 
end
local SWEEP_RESULTS = {}

if PhysicsWorld.stop_reusing_sweep_tables then
	PhysicsWorld.stop_reusing_sweep_tables()
end

ActionSweep.client_owner_post_update = function (self, dt, t, world, can_damage, current_time_in_action)
	local unit = self.weapon_unit
	local owner_unit = self.owner_unit
	local current_action = self.current_action
	local physics_world = World.get_data(world, "physics_world")
	local max_dt = 0.016666666666666666
	local current_dt = 0
	local aborted = false
	local start_position = self.stored_position:unbox()
	local start_rotation = self.stored_rotation:unbox()
	local end_position = POSITION_LOOKUP[unit]
	local end_rotation = Unit.world_rotation(unit, 0)
	local interpolate = true
	local i = 0

	if (aborted or self.attack_aborted) and current_action.reset_aim_on_attack and not self.auto_aim_reset then
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")

		first_person_extension.reset_aim_assist_multiplier(first_person_extension)

		self.auto_aim_reset = true
	end

	if interpolate then
		while not aborted and not self.attack_aborted and current_dt < dt do
			i = i + 1
			local interpolated_dt = math.min(max_dt, dt - current_dt)
			current_dt = math.min(current_dt + max_dt, dt)
			local lerp_t = current_dt/dt
			local current_position = Vector3.lerp(start_position, end_position, lerp_t)
			local current_rotation = Quaternion.lerp(start_rotation, end_rotation, lerp_t)
			local can_really_damage = self._is_within_damage_window(self, current_time_in_action - dt*2 + current_dt, current_action, owner_unit)
			aborted = self._do_overlap(self, interpolated_dt, t, unit, owner_unit, current_action, physics_world, can_really_damage, current_position, current_rotation)
		end
	else
		self._do_overlap(self, dt, t, unit, owner_unit, current_action, physics_world, can_damage, end_position, end_rotation)
	end

	return 
end
ActionSweep._is_within_damage_window = function (self, current_time_in_action, action, owner_unit)
	local damage_window_start = action.damage_window_start
	local damage_window_end = action.damage_window_end

	if not damage_window_start and not damage_window_end then
		return false
	end

	local anim_time_scale = action.anim_time_scale or 1
	anim_time_scale = ActionUtils.apply_attack_speed_buff(anim_time_scale, owner_unit)
	damage_window_start = damage_window_start/anim_time_scale
	damage_window_end = damage_window_end or action.total_time or math.huge
	damage_window_end = damage_window_end/anim_time_scale
	local after_start = damage_window_start < current_time_in_action
	local before_end = current_time_in_action < damage_window_end

	return after_start and before_end
end
ActionSweep._do_overlap = function (self, dt, t, unit, owner_unit, current_action, physics_world, can_damage, current_position, current_rotation)
	local drawer = self._drawer
	local current_time_in_action = t - self.action_time_started
	local current_rot_up = Quaternion.up(current_rotation)
	local hit_environment_rumble = false

	if self.attack_aborted then
		return 
	end

	if not can_damage and not self.could_damage_last_update then
		local actual_last_position_current = current_position
		local last_position_current = Vector3(actual_last_position_current.x, actual_last_position_current.y, actual_last_position_current.z - self.down_offset)

		self.stored_position:store(last_position_current)
		self.stored_rotation:store(current_rotation)

		return 
	end

	final_frame = not can_damage and self.could_damage_last_update
	self.could_damage_last_update = can_damage
	local position_previous = self.stored_position:unbox()
	local rotation_previous = self.stored_rotation:unbox()
	local weapon_up_dir_previous = Quaternion.up(rotation_previous)
	local actual_position_current = current_position
	local position_current = Vector3(actual_position_current.x, actual_position_current.y, actual_position_current.z - self.down_offset)
	local rotation_current = current_rotation

	self.stored_position:store(position_current)
	self.stored_rotation:store(rotation_current)

	local weapon_half_extents = self.stored_half_extents:unbox()
	local weapon_half_length = weapon_half_extents.z
	local range_mod = current_action.range_mod or 1
	local width_mod = (current_action.width_mod and current_action.width_mod*1.25) or 25

	if global_is_inside_inn then
		range_mod = range_mod*0.65
		width_mod = width_mod/4
	end

	weapon_half_length = weapon_half_length*range_mod
	weapon_half_extents.x = weapon_half_extents.x*width_mod

	if script_data.debug_weapons then
		drawer.capsule(drawer, position_previous, position_previous + weapon_up_dir_previous*weapon_half_length*2, 0.02)
		drawer.capsule(drawer, position_current, position_current + current_rot_up*weapon_half_length*2, 0.01, Color(0, 0, 255))
		Debug.text("Missed target count: %d", self.missed_targets or 0)
	end

	local weapon_rot = current_rotation
	local middle_rot = Quaternion.lerp(rotation_previous, weapon_rot, 0.5)
	local position_start = position_previous + weapon_up_dir_previous*weapon_half_length
	local position_end = (position_previous + current_rot_up*weapon_half_length*2) - Quaternion.up(rotation_previous)*weapon_half_length
	local max_num_hits = 5
	local attack_direction = calculate_attack_direction(current_action, weapon_rot)
	local owner_player = Managers.player:owner(owner_unit)
	local weapon_cross_section = Vector3(weapon_half_extents.x, weapon_half_extents.y, 0.0001)
	local difficulty_settings = Managers.state.difficulty:get_difficulty_settings()
	local collision_filter = (DamageUtils.allow_friendly_fire_melee(difficulty_settings, owner_player) and "filter_melee_sweep") or "filter_melee_sweep_no_player"

	if PhysicsWorld.start_reusing_sweep_tables then
		PhysicsWorld.start_reusing_sweep_tables()
	end

	local sweep_results1 = PhysicsWorld.linear_obb_sweep(physics_world, position_previous, position_previous + weapon_up_dir_previous*weapon_half_length*2, weapon_cross_section, rotation_previous, max_num_hits, "collision_filter", collision_filter, "report_initial_overlap")
	local sweep_results2 = PhysicsWorld.linear_obb_sweep(physics_world, position_start, position_end, weapon_half_extents, rotation_previous, max_num_hits, "collision_filter", collision_filter, "report_initial_overlap")
	local sweep_results3 = PhysicsWorld.linear_obb_sweep(physics_world, position_previous + current_rot_up*weapon_half_length, position_current + current_rot_up*weapon_half_length, weapon_half_extents, rotation_current, max_num_hits, "collision_filter", collision_filter, "report_initial_overlap")
	local num_results1 = 0
	local num_results2 = 0
	local num_results3 = 0

	if sweep_results1 then
		num_results1 = #sweep_results1

		for i = 1, num_results1, 1 do
			SWEEP_RESULTS[i] = sweep_results1[i]
		end
	end

	if sweep_results2 then
		for i = 1, #sweep_results2, 1 do
			local info = sweep_results2[i]
			local this_actor = info.actor
			local found = nil

			for j = 1, num_results1, 1 do
				if SWEEP_RESULTS[j].actor == this_actor then
					found = true
				end
			end

			if not found then
				num_results2 = num_results2 + 1
				SWEEP_RESULTS[num_results1 + num_results2] = info
			end
		end
	end

	if sweep_results3 then
		for i = 1, #sweep_results3, 1 do
			local info = sweep_results3[i]
			local this_actor = info.actor
			local found = nil

			for j = 1, num_results1 + num_results2, 1 do
				if SWEEP_RESULTS[j].actor == this_actor then
					found = true
				end
			end

			if not found then
				num_results3 = num_results3 + 1
				SWEEP_RESULTS[num_results1 + num_results2 + num_results3] = info
			end
		end
	end

	for i = num_results1 + num_results2 + num_results3 + 1, #SWEEP_RESULTS, 1 do
		SWEEP_RESULTS[i] = nil
	end

	local first_person_extension = ScriptUnit.extension(self.owner_unit, "first_person_system")
	local owner_unit_direction = Quaternion.forward(Unit.local_rotation(owner_unit, 0))
	local owner_unit_pos = Unit.world_position(owner_unit, 0)
	local hit_units = self.hit_units
	local environment_unit_hit = false
	local max_targets = current_action.max_targets or 1

	for i = 1, num_results1 + num_results2 + num_results3, 1 do
		local result = SWEEP_RESULTS[i]
		local hit_actor = result.actor
		local hit_unit = Actor.unit(hit_actor)
		local hit_position = result.position
		local hit_armor = false

		if Unit.alive(hit_unit) and Vector3.is_valid(hit_position) then
			fassert(Vector3.is_valid(hit_position), "The hit position is not valid! Actor: %s, Unit: %s", hit_actor, hit_unit)
			assert(hit_unit, "hit_unit is nil.")

			local breed = Unit.get_data(hit_unit, "breed")
			local in_view = first_person_extension.is_within_default_view(first_person_extension, hit_position)
			local is_player = table.contains(PLAYER_AND_BOT_UNITS, hit_unit)
			local is_character = breed or is_player
			local hit_self = hit_unit == owner_unit

			if is_character and hit_units[hit_unit] == nil and in_view and not hit_self then
				hit_units[hit_unit] = true
				local health_extension = ScriptUnit.extension(hit_unit, "health_system")
				local number_of_hit_enemies = self.number_of_hit_enemies
				local attack_template_name, attack_template_damage_type_name = nil

				if current_action.use_target and self.target_breed_unit ~= nil then
					if hit_unit == self.target_breed_unit then
						if health_extension.is_alive(health_extension) then
							self.number_of_hit_enemies = self.number_of_hit_enemies + 1
						end

						local attack_target_settings = current_action.default_target
						attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(attack_target_settings, self.is_critical_strike)
					end
				elseif self.number_of_hit_enemies < max_targets then
					if not is_player and health_extension.is_alive(health_extension) then
						self.number_of_hit_enemies = self.number_of_hit_enemies + 1
					end

					local targets = current_action.targets
					local actual_hit_enemy_index = math.max(self.number_of_hit_enemies, 1)
					local attack_target_settings = targets[actual_hit_enemy_index] or current_action.default_target
					attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(attack_target_settings, self.is_critical_strike)
				end

				if attack_template_name then
					local attack_template = AttackTemplates[attack_template_name]
					local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
					local attack_template_damage_type_id = NetworkLookup.attack_damage_values[attack_template_damage_type_name or "n/a"]
					local hit_zone_name = nil

					if breed then
						local node = Actor.node(hit_actor)
						local hit_zone = breed.hit_zones_lookup[node]
						hit_zone_name = hit_zone.name

						if hit_zone_name == "head" then
							local neck_position = Actor.position(hit_actor)
							local closest_sweep_point = Geometry.closest_point_on_line(neck_position, position_current, position_current + Quaternion.up(rotation_current)*weapon_half_length*2)

							if math.abs(closest_sweep_point.z - neck_position.z) <= 0.1 then
								hit_zone_name = "neck"
							end
						end

						hit_armor = (health_extension.is_alive(health_extension) and breed.armor_category == 2) or breed.armor_category == 3
					else
						hit_zone_name = "torso"
					end

					local armor_type = breed.armor_category
					local abort_attack = self.number_of_hit_enemies == max_targets or hit_armor

					self._play_hit_animations(self, owner_unit, current_action, abort_attack, hit_zone_name, armor_type)

					local network_manager = Managers.state.network
					local hit_unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
					local attacker_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
					local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
					local is_server = self.is_server
					local backstab_multiplier = 1

					if breed and AiUtils.unit_alive(hit_unit) then
						local hit_unit_pos = Unit.world_position(hit_unit, 0)
						local owner_to_hit_dir = Vector3.normalize(hit_unit_pos - owner_unit_pos)
						local hit_unit_direction = Quaternion.forward(Unit.local_rotation(hit_unit, 0))
						local hit_angle = Vector3.dot(hit_unit_direction, owner_to_hit_dir)

						if 0.55 <= hit_angle and hit_angle <= 1 then
							local procced = false
							backstab_multiplier, procced = self.buff_extension:apply_buffs_to_value(backstab_multiplier, StatBuffIndex.BACKSTAB_MULTIPLIER)

							if script_data.debug_legendary_traits then
								backstab_multiplier = 1.5
								procced = true
							end

							if procced then
								first_person_extension.play_hud_sound_event(first_person_extension, "hud_player_buff_backstab")
							end
						end
					end

					if breed then
						self._play_character_impact(self, is_server, owner_unit, current_action, attack_template, attack_template_damage_type_name, hit_unit, hit_position, breed, hit_zone_name, attack_direction, backstab_multiplier)
					end

					if Managers.state.controller_features and self.owner.local_player and not self.has_played_rumble_effect then
						if hit_armor then
							Managers.state.controller_features:add_effect("rumble", {
								rumble_effect = "hit_armor"
							})
						else
							local hit_rumble_effect = current_action.hit_rumble_effect or "hit_character"

							Managers.state.controller_features:add_effect("rumble", {
								rumble_effect = "hit_character"
							})
						end

						if abort_attack then
							self.has_played_rumble_effect = true
						end
					end

					local charge_value = current_action.charge_value
					local buff_result = DamageUtils.buff_on_attack(owner_unit, hit_unit, charge_value)
					local show_blood = not breed.no_blood_splatter_on_damage

					if show_blood then
						self.weapon_system:rpc_weapon_blood(nil, attacker_unit_id, attack_template_damage_type_id)

						local blood_position = Vector3(result.position.x, result.position.y, result.position.z + self.down_offset)

						Managers.state.blood:add_enemy_blood(blood_position, result.normal, result.actor)
					end

					if buff_result ~= "killing_blow" then
						if is_server or LEVEL_EDITOR_TEST then
							self.weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
						else
							network_manager.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)

							if show_blood then
								network_manager.network_transmit:send_rpc_server("rpc_weapon_blood", attacker_unit_id, attack_template_damage_type_id)
							end
						end
					else
						first_person_extension.play_hud_sound_event(first_person_extension, "Play_hud_matchmaking_countdown")
					end

					if abort_attack then
						break
					end
				end
			elseif not is_character and in_view then
				if ScriptUnit.has_extension(hit_unit, "ai_inventory_item_system") then
					if not self.hit_units[hit_unit] then
						Unit.flow_event(hit_unit, "break_shield")

						self.hit_units[hit_unit] = true
					end

					if Managers.state.controller_features and self.owner.local_player and not self.has_played_rumble_effect then
						Managers.state.controller_features:add_effect("rumble", {
							rumble_effect = "hit_shield"
						})

						self.has_played_rumble_effect = true
					end
				elseif hit_units[hit_unit] == nil and ScriptUnit.has_extension(hit_unit, "damage_system") then
					local level_index, is_level_unit = Managers.state.network:game_object_or_level_id(hit_unit)

					if is_level_unit then
						self.hit_level_object(self, hit_units, hit_unit, owner_unit, current_action, attack_direction, level_index)

						local hit_position = SWEEP_RESULTS[i].position
						local hit_normal = SWEEP_RESULTS[i].normal

						self._play_environmental_effect(self, current_rotation, current_action, hit_unit, hit_position, hit_normal)

						hit_environment_rumble = true
					else
						self.hit_units[hit_unit] = hit_unit
						local targets = current_action.targets
						local attack_target_settings = targets[math.max(self.number_of_hit_enemies, 1)] or current_action.default_target
						local attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(attack_target_settings, self.is_critical_strike)
						local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
						local attack_template_damage_type_id = NetworkLookup.attack_damage_values[attack_template_damage_type_name or "n/a"]
						local network_manager = Managers.state.network
						local attacker_unit_id = network_manager.unit_game_object_id(network_manager, owner_unit)
						local hit_unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
						local hit_zone_id = NetworkLookup.hit_zones.full
						local backstab_multiplier = 1

						if self.is_server or LEVEL_EDITOR_TEST then
							self.weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
						else
							network_manager.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
						end

						self._play_hit_animations(self, owner_unit, current_action, true)

						local hit_normal = SWEEP_RESULTS[i].normal

						self._play_environmental_effect(self, current_rotation, current_action, hit_unit, hit_position, hit_normal)

						hit_environment_rumble = true
					end
				elseif hit_units[hit_unit] == nil then
					if global_is_inside_inn then
						local abort_attack = true

						self._play_hit_animations(self, owner_unit, current_action, abort_attack)
					end

					environment_unit_hit = i
					hit_environment_rumble = true
				end
			end
		end
	end

	if environment_unit_hit and not self.has_hit_environment and 0 < num_results1 + num_results2 then
		self.has_hit_environment = true
		local result = SWEEP_RESULTS[environment_unit_hit]
		local hit_actor = result.actor
		local hit_unit = Actor.unit(hit_actor)

		assert(hit_unit, "hit unit is nil")

		if unit ~= hit_unit then
			local hit_position = result.position
			local hit_normal = result.normal
			local hit_direction = attack_direction
			local unit_set_flow_variable = Unit.set_flow_variable

			self._play_environmental_effect(self, current_rotation, current_action, hit_unit, hit_position, hit_normal)

			if Managers.state.controller_features and global_is_inside_inn and self.owner.local_player and not self.has_played_rumble_effect then
				Managers.state.controller_features:add_effect("rumble", {
					rumble_effect = "hit_environment"
				})

				self.has_played_rumble_effect = true
			end

			unit_set_flow_variable(hit_unit, "hit_actor", hit_actor)
			unit_set_flow_variable(hit_unit, "hit_direction", hit_direction)
			unit_set_flow_variable(hit_unit, "hit_position", hit_position)
			Unit.flow_event(hit_unit, "lua_simple_damage")
		end
	end

	if final_frame then
		self.attack_aborted = true
	end

	if Managers.state.controller_features and global_is_inside_inn and hit_environment_rumble and self.owner.local_player and not self.has_played_rumble_effect then
		Managers.state.controller_features:add_effect("rumble", {
			rumble_effect = "hit_environment"
		})

		self.has_played_rumble_effect = true
	end

	if script_data.debug_weapons then
		Debug.text("Has dedicated target: %s", self.target_breed_unit ~= nil)

		local pose = Matrix4x4.from_quaternion_position(rotation_previous, position_start)

		drawer.box_sweep(drawer, pose, weapon_half_extents, position_end - position_start, Color(0, 255, 0), Color(0, 100, 0))
		drawer.sphere(drawer, position_start, 0.1)
		drawer.sphere(drawer, position_end, 0.1, Color(255, 0, 255))
		drawer.vector(drawer, position_start, position_end - position_start)

		local pose = Matrix4x4.from_quaternion_position(rotation_current, position_previous + Quaternion.up(rotation_current)*weapon_half_length)

		drawer.box_sweep(drawer, pose, weapon_half_extents, position_current - position_previous)
	end

	if PhysicsWorld.stop_reusing_sweep_tables then
		PhysicsWorld.stop_reusing_sweep_tables()
	end

	return 
end
ActionSweep._play_environmental_effect = function (self, weapon_rotation, current_action, hit_unit, hit_position, hit_normal)
	local weapon_fwd = Quaternion.forward(weapon_rotation)
	local weapon_right = Quaternion.right(weapon_rotation)
	local weapon_up = Quaternion.up(weapon_rotation)
	local world = self.world
	local weapon_impact_direction = (current_action.impact_axis and current_action.impact_axis:unbox()) or Vector3.forward()
	local hit_effect = current_action.hit_effect
	local impact_direction = weapon_right*weapon_impact_direction.x + weapon_fwd*weapon_impact_direction.y + weapon_up*weapon_impact_direction.z
	local impact_rotation = Quaternion.look(impact_direction, -weapon_right)
	local owner_unit = self.owner_unit
	local owner_player = Managers.player:owner(owner_unit)
	local husk = owner_player.bot_player

	EffectHelper.play_surface_material_effects(hit_effect, world, hit_unit, hit_position, impact_rotation, hit_normal, nil, husk)

	if Managers.state.network:game() then
		EffectHelper.remote_play_surface_material_effects(hit_effect, world, hit_unit, hit_position, impact_rotation, hit_normal, self.is_server)
	end

	if script_data.debug_material_effects then
		local drawer = self._drawer

		drawer.vector(drawer, hit_position - impact_direction*0.1, impact_direction*0.1)
		drawer.vector(drawer, hit_position - impact_direction*0.1, weapon_fwd*0.1)
	end

	return 
end
ActionSweep._play_character_impact = function (self, is_server, owner_unit, current_action, attack_template, attack_template_damage_type_name, hit_unit, hit_position, breed, hit_zone_name, attack_direction, backstab_multiplier)
	local sound_type = attack_template.sound_type
	local owner_player = Managers.player:owner(owner_unit)
	local husk = owner_player.bot_player
	local breed_name = breed.name
	local world = self.world
	local predicted_damage = 0
	local attack_damage_value = (attack_template_damage_type_name and AttackDamageValues[attack_template_damage_type_name]) or nil

	if attack_template.attack_type then
		local attack = Attacks[attack_template.attack_type]
		predicted_damage = attack.get_damage_amount(self.item_name, attack_template, owner_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, nil, backstab_multiplier)
	end

	target_unit_armor = (breed and breed.armor_category) or 4
	local sound_event = (predicted_damage <= 0 and current_action.stagger_impact_sound_event) or current_action.impact_sound_event

	if target_unit_armor == 2 then
		sound_event = (predicted_damage <= 0 and current_action.no_damage_impact_sound_event) or current_action.armor_impact_sound_event or current_action.impact_sound_event
	end

	local hit_effect = nil

	if not attack_template_damage_type_name or attack_template_damage_type_name == "no_damage" then
		hit_effect = current_action.no_damage_impact_particle_effect
	elseif predicted_damage <= 0 and target_unit_armor == 2 then
		hit_effect = current_action.armour_impact_particle_effect or "fx/hit_armored"
	else
		hit_effect = (predicted_damage > 0 or current_action.no_damage_impact_particle_effect) and (current_action.impact_particle_effect or "fx/impact_blood")
	end

	if breed.no_blood_splatter_on_damage and hit_effect == "fx/impact_blood" then
		hit_effect = current_action.no_damage_impact_particle_effect
	end

	if hit_effect then
		EffectHelper.player_melee_hit_particles(world, hit_effect, hit_position, attack_direction, attack_template_damage_type_name, hit_unit)
	end

	if (hit_zone_name == "head" or hit_zone_name == "neck") and attack_template.headshot_sound then
		sound_event = attack_template.headshot_sound
	end

	if sound_event then
		EffectHelper.play_melee_hit_effects(sound_event, world, hit_position, sound_type, husk, breed_name)

		if not sound_type or not breed_name then
			return 
		end

		local sound_event_id = NetworkLookup.sound_events[sound_event]
		local sound_type_id = NetworkLookup.melee_impact_sound_types[sound_type]
		local breed_name_id = NetworkLookup.breeds[breed_name]
		local network_manager = Managers.state.network

		if is_server then
			network_manager.network_transmit:send_rpc_clients("rpc_play_melee_hit_effects", sound_event_id, hit_position, sound_type_id, breed_name_id)
		else
			network_manager.network_transmit:send_rpc_server("rpc_play_melee_hit_effects", sound_event_id, hit_position, sound_type_id, breed_name_id)
		end
	else
		Application.warning("[ActionSweep] Missing sound event for sweep action in unit %q.", self.weapon_unit)
	end

	local damage_extensions = ScriptUnit.extension(hit_unit, "health_system")
	local wounds_left = damage_extensions.current_health(damage_extensions)
	local target_presumed_dead = wounds_left <= predicted_damage

	if not target_presumed_dead and breed and not breed.disable_local_hit_reactions and Unit.has_animation_state_machine(hit_unit) then
		local hit_unit_dir = Quaternion.forward(Unit.local_rotation(hit_unit, 0))
		local angle_difference = Vector3.flat_angle(hit_unit_dir, attack_direction)
		local hit_anim = nil

		if angle_difference < -math.pi*0.75 or math.pi*0.75 < angle_difference then
			hit_anim = "hit_reaction_backward"
		elseif angle_difference < -math.pi*0.25 then
			hit_anim = "hit_reaction_left"
		elseif angle_difference < math.pi*0.25 then
			hit_anim = "hit_reaction_forward"
		else
			hit_anim = "hit_reaction_right"
		end

		Unit.animation_event(hit_unit, hit_anim)
	end

	return 
end
ActionSweep.hit_level_object = function (self, hit_units, hit_unit, owner_unit, current_action, attack_direction, level_index)
	hit_units[hit_unit] = true
	self.has_hit_environment = true

	if not Unit.get_data(hit_unit, "no_damage_from_players") then
		local hit_zone_name = "full"
		local targets = current_action.targets
		local attack_template_name, attack_template_damage_type_name = nil
		local max_targets = current_action.max_targets or 1

		if self.number_of_hit_enemies < max_targets then
			self.number_of_hit_enemies = self.number_of_hit_enemies + 1
			local attack_target_settings = targets[self.number_of_hit_enemies] or current_action.default_target
			attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(attack_target_settings, self.is_critical_strike)
			local damage_source = self.item_name

			DamageUtils.damage_level_unit(hit_unit, attack_direction, level_index, attack_template_name, attack_template_damage_type_name, damage_source, owner_unit, attack_direction, self.is_server)
		end
	end

	local first_person_hit_anim = current_action.first_person_hit_anim

	if first_person_hit_anim then
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)

		Unit.animation_event(first_person_unit, first_person_hit_anim)
	end

	return 
end
ActionSweep.finish = function (self)
	if not script_data.debug_weapons_always_hit_target then
		return 
	end

	local target_breed_unit = self.target_breed_unit

	if target_breed_unit == nil or self.has_hit_target then
		return 
	end

	weapon_printf("FINISHING OFF MISSED TARGET")

	local network_manager = Managers.state.network
	local breed = Unit.get_data(target_breed_unit, "breed")
	local hit_zone_name, _ = next(breed.hit_zones)
	local attack_direction = Vector3.normalize(POSITION_LOOKUP[target_breed_unit] - POSITION_LOOKUP[self.owner_unit])
	local hit_unit_id = network_manager.unit_game_object_id(network_manager, target_breed_unit)
	local attacker_unit_id = network_manager.unit_game_object_id(network_manager, self.owner_unit)
	local hit_zone_id = NetworkLookup.hit_zones[hit_zone_name]
	local attack_template_name, attack_template_damage_type_name = ActionUtils.select_attack_template(self.current_action, self.buff_extension, self.is_critical_strike)
	local attack_template = AttackTemplates[attack_template_name]
	local attack_template_id = NetworkLookup.attack_templates[attack_template_name]
	local attack_template_damage_type_id = NetworkLookup.attack_damage_values[attack_template_damage_type_name or "n/a"]

	DamageUtils.buff_on_attack(self.owner_unit, target_breed_unit, self.current_action.charge_value)

	local backstab_multiplier = 1

	if self.is_server or LEVEL_EDITOR_TEST then
		self.weapon_system:rpc_attack_hit(nil, NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
	else
		network_manager.network_transmit:send_rpc_server("rpc_attack_hit", NetworkLookup.damage_sources[self.item_name], attacker_unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, attack_template_damage_type_id, NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier)
	end

	if self.is_critical_strike and self.critical_strike_particle_id then
		World.destroy_particles(self.world, self.critical_strike_particle_id)

		self.critical_strike_particle_id = nil
	end

	return 
end
ActionSweep.streak_available = function (self)
	return 0 < self.number_of_hit_enemies or self.has_hit_target
end
ActionSweep.destroy = function (self)
	if self.critical_strike_particle_id then
		World.destroy_particles(self.world, self.critical_strike_particle_id)

		self.critical_strike_particle_id = nil
	end

	return 
end
ActionSweep._play_hit_animations = function (self, owner_unit, current_action, abort_attack, hit_zone_name, armor_type)
	local first_person_hit_anim = (hit_zone_name ~= "head" and armor_type == 2 and abort_attack and current_action.hit_armor_anim) or (abort_attack and current_action.hit_stop_anim) or current_action.first_person_hit_anim
	local third_person_hit_anim = abort_attack and current_action.hit_stop_anim
	self.attack_aborted = self.attack_aborted or abort_attack

	if first_person_hit_anim then
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)

		Unit.animation_event(first_person_unit, first_person_hit_anim)
	end

	if third_person_hit_anim then
		CharacterStateHelper.play_animation_event(owner_unit, third_person_hit_anim)
	end

	return 
end

return 
