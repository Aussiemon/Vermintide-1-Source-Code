DeathReactions = {
	IS_NOT_DONE = "not_done",
	IS_DONE = "done"
}
local DeathReactions = DeathReactions
local SCREENSPACE_DEATH_EFFECTS = {
	heavy = "fx/screenspace_blood_drops_heavy",
	blunt = "fx/screenspace_blood_drops"
}

local function play_screen_space_blood(world, unit, attacker_unit, killing_blow, damage_type)
	local pos = POSITION_LOOKUP[unit] + Vector3(0, 0, 1)
	local player_manager = Managers.player
	local camera_manager = Managers.state.camera

	for _, player in pairs(player_manager.human_players(player_manager)) do
		if not player.remote and (not script_data.disable_remote_blood_splatter or (Unit.alive(attacker_unit) and player == player_manager.owner(player_manager, attacker_unit))) then
			local vp_name = player.viewport_name
			local cam_pos = camera_manager.camera_position(camera_manager, vp_name)

			if Vector3.distance_squared(cam_pos, pos) < 9 and (not script_data.disable_behind_blood_splatter or camera_manager.is_in_view(camera_manager, vp_name, pos)) then
				local particle_name = SCREENSPACE_DEATH_EFFECTS[damage_type] or "fx/screenspace_blood_drops"

				World.create_particles(world, particle_name, Vector3.zero())
			end
		end
	end

	return 
end

local telemetry_data = {}

local function ai_default_unit_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
	local killer_unit = killing_blow[DamageDataIndex.ATTACKER]
	local death_hit_zone = killing_blow[DamageDataIndex.HIT_ZONE]
	local damage_type = killing_blow[DamageDataIndex.DAMAGE_TYPE]
	local weapon_name = killing_blow[DamageDataIndex.DAMAGE_SOURCE_NAME]
	local hit_ragdoll_actor = killing_blow[DamageDataIndex.HIT_RAGDOLL_ACTOR_NAME]
	local damaged_by_other = unit ~= killer_unit

	if damaged_by_other then
		local ai_extension = ScriptUnit.extension(unit, "ai_system")

		AiUtils.alert_nearby_friends_of_enemy(unit, ai_extension.blackboard(ai_extension).group_blackboard.broadphase, killer_unit)
	end

	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	ScriptUnit.extension(unit, "ai_system"):die(killer_unit, killing_blow)
	locomotion.set_affected_by_gravity(locomotion, false)
	locomotion.set_movement_type(locomotion, "script_driven")
	locomotion.set_wanted_velocity(locomotion, Vector3.zero())
	ScriptUnit.extension(unit, "ai_navigation_system"):release_bot()

	if ScriptUnit.has_extension(unit, "ai_inventory_system") then
		local inventory_system = Managers.state.entity:system("ai_inventory_system")

		inventory_system.drop_item(inventory_system, unit)
	end

	locomotion.set_collision_disabled(locomotion, "death_reaction", true)

	local owner_unit = AiUtils.get_actual_attacker_unit(killer_unit)

	play_screen_space_blood(context.world, unit, owner_unit, killing_blow, damage_type)

	local breed = Unit.get_data(unit, "breed")

	if breed.death_sound_event then
		local wwise_source, wwise_world = WwiseUtils.make_unit_auto_source(context.world, unit, Unit.node(unit, "c_head"))
		local dialogue_extension = ScriptUnit.extension(unit, "dialogue_system")
		local switch_group = dialogue_extension.wwise_voice_switch_group

		if switch_group then
			local switch_value = dialogue_extension.wwise_voice_switch_value

			WwiseWorld.set_switch(wwise_world, switch_group, switch_value, wwise_source)
		end

		WwiseWorld.trigger_event(wwise_world, breed.death_sound_event, wwise_source)
	end

	if GameSettingsDevelopment.use_telemetry then
		local player = Managers.player:owner(owner_unit)

		if player then
			local breed_name = breed.name
			local player_id = player.telemetry_id(player)

			DeathReactions._add_ai_killed_by_player_telemetry(unit, breed_name, owner_unit, player, player_id, damage_type, weapon_name, death_hit_zone)
		end
	end

	local data = {
		breed = breed,
		finish_time = t + (breed.time_to_unspawn_after_death or 10),
		wall_nail_data = cached_wall_nail_data or {}
	}

	if not breed.force_despawn then
		data.push_to_death_watch_timer = t + 3 + math.random()*2
	end

	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension.set_movement_type(locomotion_extension, "disabled")

	return data, DeathReactions.IS_NOT_DONE
end

local function update_wall_nail(unit, dt, t, data)
	Profiler.start("update_wall_nail")

	for hit_ragdoll_actor, nail_data in pairs(data.wall_nail_data) do
		local actor = Unit.actor(unit, hit_ragdoll_actor)

		if actor and Actor.is_physical(actor) then
			local world = Unit.world(unit)
			local position = Actor.position(actor)

			fassert(Vector3.is_valid(position), "Position from actor is not valid.")

			nail_data.position = Vector3Box(position)
			local dir = nail_data.attack_direction:unbox()
			local fly_time = 0.3
			local ray_dist = nail_data.hit_speed*fly_time

			fassert(0 < ray_dist, "Ray distance is not greater than 0")

			local collision_filter = "filter_ai_line_of_sight_check"
			local hit, hit_position, hit_distance, hit_normal, hit_actor = PhysicsWorld.immediate_raycast(World.get_data(world, "physics_world"), position, dir, (data.nailed and math.min(ray_dist, 0.4)) or ray_dist, "closest", "collision_filter", collision_filter)

			if hit then
				Unit.disable_animation_state_machine(unit)
				Actor.set_kinematic(actor, true)
				Actor.set_collision_enabled(actor, false)

				local thickness = Unit.get_data(unit, "breed").ragdoll_actor_thickness[hit_ragdoll_actor]
				local node = Actor.node(actor)

				Unit.scene_graph_link(unit, node, nil)

				nail_data.node = node

				fassert(Vector3.is_valid(hit_position), "Position from raycast is valid")

				nail_data.target_position = Vector3Box(hit_position - dir*thickness)
				nail_data.start_t = t
				nail_data.end_t = t + math.max(hit_distance/ray_dist*fly_time, 0.01)
				data.finish_time = math.max(data.finish_time, t + 30)
				data.nailed = true
			else
				data.wall_nail_data[hit_ragdoll_actor] = nil
			end
		elseif actor and data.nailed then
			local node = nail_data.node
			local lerp_t = math.min(math.auto_lerp(nail_data.start_t, nail_data.end_t, 0, 1, t), 1)

			Unit.set_local_position(unit, node, Vector3.lerp(nail_data.position:unbox(), nail_data.target_position:unbox(), lerp_t))
		end
	end

	Profiler.stop()

	return 
end

local function ai_default_unit_update(unit, dt, context, t, data, is_server)
	if not data.remove then
		if data.push_to_death_watch_timer and data.push_to_death_watch_timer < t then
			Managers.state.unit_spawner:push_unit_to_death_watch_list(unit, t, data)

			data.push_to_death_watch_timer = nil
		end

		if next(data.wall_nail_data) then
			update_wall_nail(unit, dt, t, data)
		end

		return DeathReactions.IS_NOT_DONE
	end

	Managers.state.unit_spawner:mark_for_deletion(unit)

	return DeathReactions.IS_DONE
end

local function ai_default_husk_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
	local killer_unit = killing_blow[DamageDataIndex.ATTACKER]
	local death_hit_zone = killing_blow[DamageDataIndex.HIT_ZONE]
	local damage_type = killing_blow[DamageDataIndex.DAMAGE_TYPE]
	local weapon_name = killing_blow[DamageDataIndex.DAMAGE_SOURCE_NAME]

	if ScriptUnit.has_extension(unit, "locomotion_system") then
		local locomotion = ScriptUnit.extension(unit, "locomotion_system")

		locomotion.set_mover_disable_reason(locomotion, "husk_death_reaction", true)
		locomotion.set_collision_disabled(locomotion, "husk_death_reaction", true)
		locomotion.destroy(locomotion)
	end

	local owner_unit = AiUtils.get_actual_attacker_unit(killer_unit)

	play_screen_space_blood(context.world, unit, owner_unit, killing_blow, damage_type)

	if ScriptUnit.has_extension(unit, "ai_inventory_system") then
		local inventory_system = Managers.state.entity:system("ai_inventory_system")

		inventory_system.drop_item(inventory_system, unit)
	end

	local breed = Unit.get_data(unit, "breed")

	if breed.death_sound_event then
		local wwise_source, wwise_world = WwiseUtils.make_unit_auto_source(context.world, unit, Unit.node(unit, "c_head"))
		local dialogue_extension = ScriptUnit.extension(unit, "dialogue_system")
		local switch_group = dialogue_extension.wwise_voice_switch_group

		if switch_group then
			local switch_value = dialogue_extension.wwise_voice_switch_value

			WwiseWorld.set_switch(wwise_world, switch_group, switch_value, wwise_source)
		end

		WwiseWorld.trigger_event(wwise_world, breed.death_sound_event, wwise_source)
	end

	if GameSettingsDevelopment.use_telemetry then
		local player = Managers.player:owner(owner_unit)

		if player then
			local breed_name = breed.name
			local player_id = player.telemetry_id(player)

			DeathReactions._add_ai_killed_by_player_telemetry(unit, breed_name, owner_unit, player, player_id, damage_type, weapon_name, death_hit_zone)
		end
	end

	local data = {
		breed = breed,
		finish_time = t + 10,
		wall_nail_data = cached_wall_nail_data or {}
	}

	return data, DeathReactions.IS_NOT_DONE
end

local function ai_default_husk_update(unit, dt, context, t, data)
	if next(data.wall_nail_data) then
		update_wall_nail(unit, dt, t, data)

		return DeathReactions.IS_NOT_DONE
	elseif not data.player_collided and not data.nailed then
		return DeathReactions.IS_NOT_DONE
	end

	return DeathReactions.IS_DONE
end

local function play_unit_audio(unit, blackboard, sound_name)
	Managers.state.entity:system("audio_system"):play_audio_unit_event(sound_name, unit)

	return 
end

local function trigger_unit_dialogue_death_event(killed_unit, killer_unit, hit_zone, damage_type)
	if not Unit.alive(killed_unit) or not Unit.alive(killer_unit) then
		return 
	end

	if Unit.has_data(killed_unit, "enemy_dialogue_face_anim") and Unit.has_animation_state_machine(killed_unit) then
		Unit.animation_event(killed_unit, "talk_end")
	end

	if Unit.has_data(killed_unit, "enemy_dialogue_body_anim") and Unit.has_animation_state_machine(killed_unit) then
		Unit.animation_event(killed_unit, "talk_body_end")
	end

	if ScriptUnit.has_extension(killer_unit, "dialogue_system") then
		local dialogue_input = ScriptUnit.extension_input(killer_unit, "dialogue_system")
		local event_data = FrameTable.alloc_table()
		local killed_unit_name = "UNKNOWN"
		local breed_data = Unit.get_data(killed_unit, "breed")

		if breed_data then
			killed_unit_name = breed_data.name
		elseif ScriptUnit.has_extension(killed_unit, "dialogue_system") then
			killed_unit_name = ScriptUnit.extension(killed_unit, "dialogue_system").context.player_profile
		end

		local player = Managers.player:owner(killer_unit)

		if player ~= nil then
			local inventory_extension = ScriptUnit.extension(killer_unit, "inventory_system")
			local weapon_slot = inventory_extension.get_wielded_slot_name(inventory_extension)
			local weapon_data = inventory_extension.get_slot_data(inventory_extension, weapon_slot)
			local attack_template = AttackTemplates[damage_type]

			if weapon_slot == "slot_melee" or weapon_slot == "slot_ranged" then
				local dot_type = false
				event_data.killed_type = killed_unit_name
				event_data.hit_zone = hit_zone
				event_data.weapon_slot = weapon_slot

				if weapon_data then
					event_data.weapon_type = weapon_data.item_data.item_type

					if attack_template and attack_template.dot_type then
						dot_type = attack_template.dot_type
					end
				end

				if killed_unit_name == "skaven_rat_ogre" then
					local times_killed_rat_ogre = ScriptUnit.extension(killer_unit, "dialogue_system").user_memory.times_killed_rat_ogre

					if times_killed_rat_ogre then
						ScriptUnit.extension(killer_unit, "dialogue_system").user_memory.times_killed_rat_ogre = times_killed_rat_ogre + 1
					else
						ScriptUnit.extension(killer_unit, "dialogue_system").user_memory.times_killed_rat_ogre = 1
					end
				end

				local killer_name = ScriptUnit.extension(killer_unit, "dialogue_system").context.player_profile

				SurroundingAwareSystem.add_event(killer_unit, "killed_enemy", DialogueSettings.default_view_distance, "killer_name", killer_name, "hit_zone", hit_zone, "enemy_tag", killed_unit_name, "weapon_slot", weapon_slot, "dot_type", dot_type)

				local event_name = "enemy_kill"

				dialogue_input.trigger_dialogue_event(dialogue_input, event_name, event_data)
			end
		end
	end

	return 
end

local buff_params = {}

local function trigger_player_killing_blow_ai_buffs(ai_unit, player_unit, is_server)
	if Unit.alive(player_unit) then
		local player = Managers.player:owner(player_unit)

		if player and not player.remote then
			local buff_extension = ScriptUnit.extension(player_unit, "buff_system")
			local health_extension = ScriptUnit.extension(player_unit, "health_system")

			if health_extension.current_health_percent(health_extension) < 1 then
				local heal_amount, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.HEAL_ON_KILL)
				local heal_type = "proc"

				if procced then
					if is_server or LEVEL_EDITOR_TEST then
						DamageUtils.heal_network(player_unit, player_unit, heal_amount, heal_type)
					else
						local network_manager = Managers.state.network
						local network_transmit = network_manager.network_transmit
						local owner_unit_id = network_manager.unit_game_object_id(network_manager, player_unit)
						local heal_type_id = NetworkLookup.heal_types[heal_type]

						network_transmit.send_rpc_server(network_transmit, "rpc_request_heal", owner_unit_id, heal_amount, heal_type_id)
					end
				end
			end

			local attack_speed_multiplier, procced, parent_id = buff_extension.apply_buffs_to_value(buff_extension, 1, StatBuffIndex.ATTACK_SPEED_ON_KILL)

			if procced then
				table.clear(buff_params)

				buff_params.external_optional_multiplier = attack_speed_multiplier - 1
				buff_params.parent_id = parent_id

				buff_extension.add_buff(buff_extension, "attack_speed_from_proc", buff_params)
			end

			local amount, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.AMMO_ON_KILL)

			if procced then
				local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
				local slot_data = inventory_extension.get_slot_data(inventory_extension, "slot_ranged")
				local right_unit_1p = slot_data.right_unit_1p
				local left_unit_1p = slot_data.left_unit_1p
				local right_hand_ammo_extension = ScriptUnit.has_extension(right_unit_1p, "ammo_system") and ScriptUnit.extension(right_unit_1p, "ammo_system")
				local left_hand_ammo_extension = ScriptUnit.has_extension(left_unit_1p, "ammo_system") and ScriptUnit.extension(left_unit_1p, "ammo_system")
				local ammo_extension = right_hand_ammo_extension

				if not ammo_extension and left_hand_ammo_extension then
					ammo_extension = left_hand_ammo_extension
				end

				if ammo_extension then
					ammo_extension.add_ammo_to_reserve(ammo_extension, amount)
				end
			end
		end
	end

	return 
end

local function trigger_headshot_dialogue_event(unit, killing_blow)
	if killing_blow[DamageDataIndex.HIT_ZONE] == "head" then
		local source = killing_blow[DamageDataIndex.ATTACKER]

		if ScriptUnit.has_extension(source, "surrounding_aware_system") then
			local speaker_name = "UNKNOWN"
			local breed_data = Unit.get_data(source, "breed")

			if breed_data then
				speaker_name = breed_data.name
			elseif ScriptUnit.has_extension(source, "dialogue_system") then
				speaker_name = ScriptUnit.extension(source, "dialogue_system").context.player_profile
			end

			SurroundingAwareSystem.add_event(source, "heard_speak", last_query.validated_rule.sound_distance, "heard_event", last_query.result, "speaker", source, "speaker_name", speaker_name, "sound_event", extension.last_query_sound_event or "unknown")
		end
	end

	return 
end

local pickup_params = {}
DeathReactions.templates = {
	ai_default = {
		unit = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local data, result = ai_default_unit_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

				StatisticsUtil.register_kill(unit, killing_blow, context.statistics_db, true)
				trigger_unit_dialogue_death_event(unit, killing_blow[DamageDataIndex.ATTACKER], killing_blow[DamageDataIndex.HIT_ZONE], killing_blow[DamageDataIndex.DAMAGE_TYPE])
				trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], true)
				Managers.state.entity:system("play_go_tutorial_system"):register_killing_blow(killing_blow[DamageDataIndex.DAMAGE_TYPE], killing_blow[DamageDataIndex.ATTACKER])

				if unit ~= killing_blow[DamageDataIndex.ATTACKER] and ScriptUnit.has_extension(unit, "ai_system") then
					ScriptUnit.extension(unit, "ai_system"):attacked(killing_blow[DamageDataIndex.ATTACKER], t, killing_blow)
				end

				return data, result
			end,
			update = function (unit, dt, context, t, data)
				local result = ai_default_unit_update(unit, dt, context, t, data)

				return result
			end
		},
		husk = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local data, result = ai_default_husk_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

				StatisticsUtil.register_kill(unit, killing_blow, context.statistics_db)
				trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], false)

				return data, result
			end,
			update = function (unit, dt, context, t, data)
				local result = ai_default_husk_update(unit, dt, context, t, data)

				return result
			end
		}
	},
	gutter_runner = {
		unit = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local data, result = ai_default_unit_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

				StatisticsUtil.register_kill(unit, killing_blow, context.statistics_db, true)
				trigger_unit_dialogue_death_event(unit, killing_blow[DamageDataIndex.ATTACKER], killing_blow[DamageDataIndex.HIT_ZONE], killing_blow[DamageDataIndex.DAMAGE_TYPE])
				trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], true)
				Unit.set_unit_visibility(unit, false)

				return nil, DeathReactions.IS_DONE
			end
		},
		husk = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local data, result = ai_default_husk_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

				StatisticsUtil.register_kill(unit, killing_blow, context.statistics_db)
				trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], false)
				Unit.set_unit_visibility(unit, false)

				return nil, DeathReactions.IS_DONE
			end
		}
	},
	poison_globadier = {
		unit = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local blackboard = Unit.get_data(unit, "blackboard")

				play_unit_audio(unit, blackboard, "Stop_enemy_foley_globadier_boiling_loop")
				StatisticsUtil.register_kill(unit, killing_blow, context.statistics_db, true)

				if unit ~= killing_blow[DamageDataIndex.ATTACKER] and ScriptUnit.has_extension(unit, "ai_system") then
					ScriptUnit.extension(unit, "ai_system"):attacked(killing_blow[DamageDataIndex.ATTACKER], t, killing_blow)
				end

				if blackboard.suicide_run ~= nil and blackboard.suicide_run.explosion_started then
					ai_default_unit_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

					local sound_name = "Play_enemy_combat_globadier_suicide_explosion"

					play_unit_audio(unit, blackboard, sound_name)

					local action = blackboard.suicide_run.action

					assert(action)
					AiUtils.poison_explode_unit(unit, action, blackboard)
					trigger_unit_dialogue_death_event(unit, killing_blow[DamageDataIndex.ATTACKER], killing_blow[DamageDataIndex.HIT_ZONE], killing_blow[DamageDataIndex.DAMAGE_TYPE])
					trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], true)

					return nil, DeathReactions.IS_DONE
				else
					local data, result = ai_default_unit_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
					data.blackboard = blackboard

					trigger_unit_dialogue_death_event(unit, killing_blow[DamageDataIndex.ATTACKER], killing_blow[DamageDataIndex.HIT_ZONE], killing_blow[DamageDataIndex.DAMAGE_TYPE])
					trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], true)

					return data, result
				end

				return 
			end,
			update = function (unit, dt, context, t, data)
				local blackboard = data.blackboard
				local result = nil

				if blackboard.suicide_run ~= nil and blackboard.suicide_run.explosion_started then
					result = DeathReactions.IS_DONE
				else
					result = ai_default_unit_update(unit, dt, context, t, data)
				end

				return result
			end
		},
		husk = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local data, result = ai_default_husk_start(unit, dt, context, t, killing_blow)

				StatisticsUtil.register_kill(unit, killing_blow, context.statistics_db)
				trigger_unit_dialogue_death_event(unit, killing_blow[DamageDataIndex.ATTACKER], killing_blow[DamageDataIndex.HIT_ZONE], killing_blow[DamageDataIndex.DAMAGE_TYPE])
				trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], false)

				return data, result
			end,
			update = function (unit, dt, context, t, data)
				local result = ai_default_husk_update(unit, dt, context, t, data)

				return result
			end
		}
	},
	loot_rat = {
		unit = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local data, result = ai_default_unit_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

				StatisticsUtil.register_kill(unit, killing_blow, context.statistics_db, true)
				trigger_unit_dialogue_death_event(unit, killing_blow[DamageDataIndex.ATTACKER], killing_blow[DamageDataIndex.HIT_ZONE], killing_blow[DamageDataIndex.DAMAGE_TYPE])
				trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], true)

				local amount_of_loot_drops = math.random(2, 4)

				for i = 1, amount_of_loot_drops, 1 do
					local spawn_value = math.random()
					local pickups = LootRatPickups
					local spawn_weighting_total = 0

					for pickup_name, spawn_weighting in pairs(pickups) do
						table.clear(pickup_params)

						local dice_keeper = context.dice_keeper
						local can_spawn_pickup_type = true
						local pickup_settings = AllPickups[pickup_name]
						local can_spawn_func = pickup_settings.can_spawn_func
						pickup_params.dice_keeper = dice_keeper

						if can_spawn_func and not can_spawn_func(pickup_params) then
							can_spawn_pickup_type = false
						end

						spawn_weighting_total = spawn_weighting_total + spawn_weighting

						if spawn_value <= spawn_weighting_total and can_spawn_pickup_type then
							local extension_init_data = {
								pickup_system = {
									has_physics = true,
									spawn_type = "loot",
									pickup_name = pickup_name
								}
							}
							local unit_name = pickup_settings.unit_name
							local unit_template_name = pickup_settings.unit_template_name or "pickup_unit"
							local position = POSITION_LOOKUP[unit] + Vector3(math.random() - 0.5, math.random() - 0.5, 1)
							local rotation = Quaternion(Vector3.right(), math.random()*2*math.pi)

							Managers.state.unit_spawner:spawn_network_unit(unit_name, unit_template_name, extension_init_data, position, rotation)

							if pickup_name == "loot_die" then
								dice_keeper.bonus_dice_spawned(dice_keeper)
							end

							break
						end
					end
				end

				if unit ~= killing_blow[DamageDataIndex.ATTACKER] and ScriptUnit.has_extension(unit, "ai_system") then
					ScriptUnit.extension(unit, "ai_system"):attacked(killing_blow[DamageDataIndex.ATTACKER], t, killing_blow)
				end

				return data, result
			end,
			update = function (unit, dt, context, t, data)
				local result = ai_default_unit_update(unit, dt, context, t, data)

				return result
			end
		},
		husk = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local data, result = ai_default_husk_start(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

				StatisticsUtil.register_kill(unit, killing_blow, context.statistics_db)
				trigger_unit_dialogue_death_event(unit, killing_blow[DamageDataIndex.ATTACKER], killing_blow[DamageDataIndex.HIT_ZONE], killing_blow[DamageDataIndex.DAMAGE_TYPE])
				trigger_player_killing_blow_ai_buffs(unit, killing_blow[DamageDataIndex.ATTACKER], false)

				return data, result
			end,
			update = function (unit, dt, context, t, data)
				local result = ai_default_husk_update(unit, dt, context, t, data)

				return result
			end
		}
	},
	player = {
		unit = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				if GameSettingsDevelopment.use_telemetry then
					local position = Unit.local_position(unit, 0)
					local damage_type = killing_blow[DamageDataIndex.DAMAGE_TYPE]
					local damage_source = killing_blow[DamageDataIndex.DAMAGE_SOURCE_NAME]
					local player_manager = Managers.player
					local player = player_manager.owner(player_manager, unit)
					local telemetry_id = player.telemetry_id(player)
					local hero = player.profile_display_name(player)

					table.clear(telemetry_data)

					telemetry_data.damage_type = damage_type
					telemetry_data.position = position
					telemetry_data.player_id = telemetry_id
					telemetry_data.hero = hero
					telemetry_data.damage_source = damage_source

					Managers.telemetry:register_event("player_death", telemetry_data)
				end

				return nil, DeathReactions.IS_DONE
			end
		},
		husk = {
			start = function (unit, dt, context, t, killing_blow, is_server)
				SurroundingAwareSystem.add_event(unit, "player_death", DialogueSettings.death_discover_distance, "target", unit, "target_name", ScriptUnit.extension(unit, "dialogue_system").context.player_profile)

				return nil, DeathReactions.IS_DONE
			end
		}
	},
	level_object = {
		unit = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				Unit.set_flow_variable(unit, "current_health", 0)
				Unit.flow_event(unit, "lua_on_death")

				return 
			end,
			update = function (unit, dt, context, t, data)
				return 
			end
		},
		husk = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				Unit.flow_event(unit, "lua_on_death")

				return 
			end,
			update = function (unit, dt, context, t, data)
				return 
			end
		}
	},
	explosive_barrel = {
		unit = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local network_time = Managers.state.network:network_time()
				local explode_time = network_time + 6
				local data = {
					played_fuse_out = false,
					explode_time = explode_time,
					killer_unit = killing_blow[DamageDataIndex.ATTACKER]
				}

				Unit.flow_event(unit, "exploding_barrel_fuse_init")

				return data, DeathReactions.IS_NOT_DONE
			end,
			update = function (unit, dt, context, t, data)
				if not data.exploded then
					if data.starting_pos then
						local unit_pos = POSITION_LOOKUP[unit]
						local distance_squared = Vector3.distance_squared(data.starting_pos:unbox(), unit_pos)

						if 1 < distance_squared then
							if data.nav_tag_volume_id then
								local volume_system = Managers.state.entity:system("volume_system")

								volume_system.destroy_nav_tag_volume(volume_system, data.nav_tag_volume_id)

								data.nav_tag_volume_id = nil
							end

							local volume_system = Managers.state.entity:system("volume_system")
							data.nav_tag_volume_id = volume_system.create_nav_tag_volume_from_data(volume_system, unit_pos, 5, "barrel_explosion")

							data.starting_pos:store(unit_pos)
						end
					else
						local volume_system = Managers.state.entity:system("volume_system")
						local pos = POSITION_LOOKUP[unit]
						data.starting_pos = Vector3Box(pos)
						data.nav_tag_volume_id = volume_system.create_nav_tag_volume_from_data(volume_system, pos, 5, "barrel_explosion")
					end
				end

				local network_time = Managers.state.network:network_time()
				local explode_time = data.explode_time

				if explode_time <= network_time and not data.exploded then
					Unit.flow_event(unit, "exploding_barrel_detonate")
					Unit.set_unit_visibility(unit, false)

					local death_extension = ScriptUnit.extension(unit, "death_system")

					if death_extension.in_hand then
						if not death_extension.thrown then
							local position = POSITION_LOOKUP[unit]
							local rotation = Unit.local_rotation(unit, 0)
							local explosion_template = "explosive_barrel"
							local item_name = death_extension.item_name
							local damage_extension = ScriptUnit.extension(unit, "damage_system")
							local owner_unit = damage_extension.owner_unit

							Managers.state.entity:system("damage_system"):create_explosion(owner_unit, position, rotation, explosion_template, 1, item_name)

							local inventory_extension = ScriptUnit.extension(owner_unit, "inventory_system")
							local equipment = inventory_extension.equipment(inventory_extension)
							local slot_name = equipment.wielded_slot

							inventory_extension.destroy_slot(inventory_extension, slot_name)
							inventory_extension.wield(inventory_extension, "slot_melee")
						end
					else
						local position = POSITION_LOOKUP[unit]
						local rotation = Unit.local_rotation(unit, 0)
						local explosion_template = "explosive_barrel"
						local item_name = death_extension.item_name

						Managers.state.entity:system("damage_system"):create_explosion(unit, position, rotation, explosion_template, 1, item_name)
					end

					data.exploded = true
				elseif explode_time - 1.2 <= network_time and not data.played_fuse_out then
					Unit.flow_event(unit, "exploding_barrel_fuse_out")

					data.played_fuse_out = true
				elseif explode_time + 0.5 <= network_time then
					Managers.state.unit_spawner:mark_for_deletion(unit)

					return DeathReactions.IS_DONE
				end

				return 
			end
		},
		husk = {
			start = function (unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
				local network_time = Managers.state.network:network_time()
				local explode_time = network_time + 6
				local data = {
					played_fuse_out = false,
					explode_time = explode_time,
					killer_unit = killing_blow[DamageDataIndex.ATTACKER]
				}

				Unit.flow_event(unit, "exploding_barrel_fuse_init")

				return data, DeathReactions.IS_NOT_DONE
			end,
			update = function (unit, dt, context, t, data)
				local network_time = Managers.state.network:network_time()
				local explode_time = data.explode_time

				if explode_time <= network_time and not data.exploded then
					Unit.flow_event(unit, "exploding_barrel_detonate")
					Unit.set_unit_visibility(unit, false)

					local death_extension = ScriptUnit.extension(unit, "death_system")

					if death_extension.in_hand and not death_extension.thrown then
						local position = POSITION_LOOKUP[unit]
						local rotation = Unit.local_rotation(unit, 0)
						local explosion_template = "explosive_barrel"
						local item_name = death_extension.item_name
						local damage_extension = ScriptUnit.extension(unit, "damage_system")
						local owner_unit = damage_extension.owner_unit

						Managers.state.entity:system("damage_system"):create_explosion(owner_unit, position, rotation, explosion_template, 1, item_name)

						local inventory_extension = ScriptUnit.extension(owner_unit, "inventory_system")
						local equipment = inventory_extension.equipment(inventory_extension)
						local slot_name = equipment.wielded_slot

						inventory_extension.destroy_slot(inventory_extension, slot_name)
						inventory_extension.wield(inventory_extension, "slot_melee")
					end

					data.exploded = true
				elseif explode_time - 1.2 <= network_time and not data.played_fuse_out then
					Unit.flow_event(unit, "exploding_barrel_fuse_out")

					data.played_fuse_out = true
				elseif explode_time + 0.5 <= network_time then
					return DeathReactions.IS_DONE
				end

				return 
			end
		}
	}
}
DeathReactions.get_reaction = function (death_reaction_template, is_husk)
	local templates = DeathReactions.templates
	local husk_key = (is_husk and "husk") or "unit"
	local reaction = templates[death_reaction_template][husk_key]

	fassert(reaction, "Death reaction for template %q and husk key %q does not exist", death_reaction_template, husk_key)

	return reaction
end
DeathReactions._add_ai_killed_by_player_telemetry = function (victim_unit, breed_name, player_unit, player, player_id, damage_type, weapon_name, death_hit_zone)
	local victim_position = POSITION_LOOKUP[victim_unit]
	local player_position = POSITION_LOOKUP[player_unit]
	local network_manager = Managers.state.network
	local is_server = network_manager.is_server
	local local_player = player.local_player
	local is_bot = player.bot_player

	if (is_bot and is_server) or local_player then
		local hero = player.profile_display_name(player)

		table.clear(telemetry_data)

		telemetry_data.weapon_name = weapon_name
		telemetry_data.victim_position = victim_position
		telemetry_data.player_position = player_position
		telemetry_data.damage_type = damage_type
		telemetry_data.breed = breed_name
		telemetry_data.player_id = player_id
		telemetry_data.hero = hero
		telemetry_data.hit_zone = death_hit_zone

		Managers.telemetry:register_event("player_killed_ai", telemetry_data)
	end

	return 
end

return 
