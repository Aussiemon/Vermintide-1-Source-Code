GenericStatusExtension = class(GenericStatusExtension)
local DamageDataIndex = DamageDataIndex
local ATTACK_INTENSITY_RESET = 0.5
local ATTACK_INTENSITY_DECAY = 0.3
GenericStatusExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.profile_id = extension_init_data.profile_id

	assert(self.profile_id)

	self.unit = unit
	self.intensity = 0
	self.intensity_decay_delay = 0
	self.move_speed_multiplier = 1
	self.move_speed_multiplier_timer = 1
	self.crouching = false
	self.crouch_toggle_locked = false
	self.blocking = false
	self.wounded = false
	self.catapulted = false
	self.catapulted_direction = nil
	self.pounced_down = false
	self.on_ladder = false
	self.is_ledge_hanging = false
	self.left_ladder_timer = 0
	self.aim_unit = nil
	self.revived = false
	self.dead = false
	self.pulled_up = false
	self._has_blocked = false
	self.my_dodge_cd = 0
	self.my_dodge_jump_override_t = 0
	self.dodge_cooldown = 0
	self.dodge_cooldown_delay = 0
	self.wounded_timer = 0
	self.dodge_count = 2
	self.fatigue = 0
	self.last_fatigue_gain_time = 0
	self.max_fatigue_points = 100
	self.next_hanging_damage_time = 0
	self.block_broken = false
	self.pushed = false
	self.push_cooldown = false
	self.push_cooldown_timer = false
	self.interrupt_cooldown = false
	self.interrupt_cooldown_timer = nil
	self.attack_intensity = 0
	self.attack_allowed = true
	local difficulty_manager = Managers.state.difficulty
	local difficulty_settings = difficulty_manager.get_difficulty_settings(difficulty_manager)
	self.attack_intensity_threshold = difficulty_settings.attack_intensity_threshold or 3
	self.inside_transport_unit = nil
	self.using_transport = false
	self.dodge_position = Vector3Box(0, 0, 0)
	self.overcharge_exploding = false
	self.fall_height = nil
	self.under_ratling_gunner_attack = nil
	self.last_catapulted_time = 0
	self.fatigue_telemetry = {
		fatigue_type = "",
		block_breaking = false,
		hero = "",
		player_id = "",
		position = Vector3.zero()
	}
	self.knocked_down_telemetry = {
		hero = "",
		player_id = "",
		damage_type = "",
		position = Vector3.zero()
	}
	self.wounds = extension_init_data.wounds

	if self.wounds == -1 then
		self.wounds = math.huge
	end

	self.max_wounds = self.wounds
	self.poison_level = 0
	self.times_poisoned = 0
	self.is_server = Managers.player.is_server
	self.update_funcs = {}

	self.set_spawn_grace_time(self, 5)

	self.forbidden_target = false
	self.ready_for_assisted_respawn = false
	self.assisted_respawning = false
	self.player = extension_init_data.player

	return 
end
GenericStatusExtension.extensions_ready = function (self)
	local unit = self.unit
	self.damage_extension = ScriptUnit.extension(unit, "damage_system")
	self.health_extension = ScriptUnit.extension(unit, "health_system")
	self.buff_extension = ScriptUnit.extension(unit, "buff_system")
	self.inventory_extension = ScriptUnit.extension(unit, "inventory_system")
	self.locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	if ScriptUnit.has_extension(unit, "first_person_system") and not self.locomotion_extension.is_bot then
		self.first_person_extension = ScriptUnit.extension(unit, "first_person_system")
		self.low_health_playing_id, self.low_health_source_id = self.first_person_extension:play_hud_sound_event("hud_low_health")
	end

	return 
end
GenericStatusExtension.destroy = function (self)
	local first_person_extension = self.first_person_extension

	if first_person_extension then
		first_person_extension.play_hud_sound_event(first_person_extension, "stop_hud_low_health")
	end

	return 
end
GenericStatusExtension.add_damage_intensity = function (self, percent_health_lost, damage_type)
	self.intensity = math.clamp(self.intensity + percent_health_lost*CurrentIntensitySettings.intensity_add_per_percent_dmg_taken*100, 0, 100)
	self.intensity_decay_delay = CurrentIntensitySettings.decay_delay

	return 
end
GenericStatusExtension.add_intensity = function (self, value)
	self.intensity = math.clamp(self.intensity + value, 0, 100)
	self.intensity_decay_delay = CurrentIntensitySettings.decay_delay

	return 
end
local intensity_ignored_damage_types = {
	heal = true,
	overcharge = true,
	wounded_dot = true,
	knockdown_bleed = true
}
GenericStatusExtension.update = function (self, unit, input, dt, context, t)
	local damage_extension = self.damage_extension
	local damages, num_damages = damage_extension.recent_damages(damage_extension)

	if self.is_server then
		local health_extension = self.health_extension
		local stride = DamageDataIndex.STRIDE

		for i = 1, num_damages/stride, 1 do
			local index = (i - 1)*stride
			local damage_type = damages[index + DamageDataIndex.DAMAGE_TYPE]

			if not intensity_ignored_damage_types[damage_type] then
				local amount = damages[index + DamageDataIndex.DAMAGE_AMOUNT]

				self.add_damage_intensity(self, amount/health_extension.health, damage_type)
			end
		end

		if self.intensity_decay_delay <= 0 and not Managers.state.conflict:intensity_decay_frozen() then
			self.intensity = math.clamp(self.intensity - CurrentIntensitySettings.decay_per_second*dt, 0, CurrentIntensitySettings.max_intensity)
		end

		self.intensity_decay_delay = self.intensity_decay_delay - dt

		if self.wounded and self.wounded_timer <= t then
			local degen_amount = PlayerUnitStatusSettings.WOUNDED_DEGEN_AMOUNT
			local current_health = health_extension.current_health(health_extension)
			local new_health = math.max(current_health - PlayerUnitStatusSettings.WOUNDED_DEGEN_AMOUNT, 1)
			local damage = current_health - new_health

			DamageUtils.add_damage_network(unit, unit, damage, "torso", "wounded_dot", Vector3(1, 0, 0), "wounded_degen")

			if new_health == 1 then
				StatusUtils.set_wounded_network(unit, false, "reached_min_health")
			else
				self.wounded_timer = t + PlayerUnitStatusSettings.WOUNDED_DEGEN_DELAY
			end
		end
	end

	local current_player_health = self.health_extension:current_health_percent()

	if 0 < self.attack_intensity then
		if self.attack_intensity_threshold < self.attack_intensity then
			self.attack_allowed = false
		elseif self.attack_intensity < ATTACK_INTENSITY_RESET then
			self.attack_allowed = true
		end

		self.attack_intensity = self.attack_intensity - dt*ATTACK_INTENSITY_DECAY*self.attack_intensity_threshold
	end

	if self.move_speed_multiplier_timer < 1 then
		local move_speed_timer_added_bonus = dt

		if current_player_health <= PlayerUnitStatusSettings.move_speed_reduction_on_hit_low_health_threshold then
			move_speed_timer_added_bonus = self.buff_extension:apply_buffs_to_value(move_speed_timer_added_bonus, StatBuffIndex.SLOW_DOWN_ON_HIT_LOW_HEALTH_RECOVER_BONUS, BuffTypes.PLAYER)
		end

		move_speed_timer_added_bonus = move_speed_timer_added_bonus*PlayerUnitStatusSettings.move_speed_reduction_on_hit_recover_time
		self.move_speed_multiplier_timer = self.move_speed_multiplier_timer + move_speed_timer_added_bonus
	end

	if 0 < num_damages then
		local slow_movement = false

		for i = 1, num_damages/DamageDataIndex.STRIDE, 1 do
			local damage_type = damages[(i - 1)*DamageDataIndex.STRIDE + DamageDataIndex.DAMAGE_TYPE]

			if PlayerUnitMovementSettings.slowing_damage_types[damage_type] then
				slow_movement = true

				break
			end
		end

		if slow_movement then
			local buff_extension = self.buff_extension
			self.move_speed_multiplier = self.current_move_speed_multiplier(self)*0.5
			self.move_speed_multiplier = math.max(0.2, self.move_speed_multiplier)
			self.move_speed_multiplier_timer = 0
		end
	end

	local player = self.player

	if not player.remote then
		local previous_max_fatigue_points = self.max_fatigue_points
		local max_fatigue_points = self._get_current_max_fatigue_points(self) or previous_max_fatigue_points
		local degen_delay = self.block_broken_degen_delay or PlayerUnitStatusSettings.FATIGUE_DEGEN_DELAY
		degen_delay = degen_delay/self.buff_extension:apply_buffs_to_value(1, StatBuffIndex.FATIGUE_REGEN_FROM_PROC)

		if self.buff_extension:has_buff_type("max_fatigue") then
			degen_delay = degen_delay*0.5
		end

		if previous_max_fatigue_points ~= max_fatigue_points then
			self.fatigue = (max_fatigue_points ~= 0 or 0) and previous_max_fatigue_points/max_fatigue_points*self.fatigue
		end

		if 0 < num_damages and 50 <= self.fatigue then
			self.fatigue = self.fatigue - max_fatigue_points/100
		end

		if self.last_fatigue_gain_time + degen_delay <= t then
			local degen_amount = (max_fatigue_points ~= 0 or 0) and PlayerUnitStatusSettings.FATIGUE_POINTS_DEGEN_AMOUNT/max_fatigue_points*PlayerUnitStatusSettings.MAX_FATIGUE
			local new_degen_amount = self.buff_extension:apply_buffs_to_value(degen_amount, StatBuffIndex.FATIGUE_REGEN_FROM_PROC)

			if degen_amount < new_degen_amount then
				self.has_bonus_fatigue_active = true
			elseif not self.bonus_fatigue_active_timer then
				self.has_bonus_fatigue_active = false
			end

			self.fatigue = math.max(self.fatigue - new_degen_amount*dt, 0)
			self.block_broken_degen_delay = nil
		end

		if 0 < self.dodge_cooldown and self.dodge_cooldown_delay and self.dodge_cooldown_delay < t then
			self.dodge_cooldown = 0
		end

		self.max_fatigue_points = max_fatigue_points
		local bonus_fatigue_active_timer = self.bonus_fatigue_active_timer

		if bonus_fatigue_active_timer and bonus_fatigue_active_timer <= t then
			self.has_bonus_fatigue_active = false
			self.bonus_fatigue_active_timer = nil
		end

		if self.push_cooldown then
			if not self.push_cooldown_timer then
				self.push_cooldown_timer = t + 1.5
			elseif self.push_cooldown_timer < t then
				self.push_cooldown_timer = false
				self.pushed = false
				self.push_cooldown = false
			end
		end

		if self.interrupt_cooldown then
			if not self.interrupt_cooldown_timer then
				self.interrupt_cooldown_timer = t + 1.5
			elseif self.interrupt_cooldown_timer < t then
				self.interrupt_cooldown = false
				self.interrupt_cooldown_timer = nil
			end
		end

		local first_person_extension = self.first_person_extension

		if first_person_extension and self.low_health_playing_id then
			local health = current_player_health*100
			local wwise_world = Managers.world:wwise_world(self.world)

			WwiseWorld.set_source_parameter(wwise_world, self.low_health_source_id, "health_status", health)
		end

		local damage_extension = self.damage_extension

		if self.shielded and not damage_extension.has_assist_shield(damage_extension) and damage_extension.previous_shield_end_reason(damage_extension) then
			self.set_shielded(self, false)
		end
	end

	if self.pack_master_status then
		if self.pack_master_status == "pack_master_hanging" then
			if self.is_server then
				if self.next_hanging_damage_time < t then
					local h = PlayerUnitStatusSettings.hanging_by_pack_master

					DamageUtils.add_damage_network(unit, unit, h.damage_amount, h.hit_zone_name, h.damage_type, Vector3.up(), "skaven_pack_master")

					self.next_hanging_damage_time = t + 1
				end

				if self.dead then
					StatusUtils.set_grabbed_by_pack_master_network("pack_master_dropping", unit, true, nil)
				end
			end
		elseif self.pack_master_status == "pack_master_dropping" then
			if self.release_falling_time and self.release_falling_time < t then
				local locomotion = ScriptUnit.extension(unit, "locomotion_system")

				locomotion.set_disabled(locomotion, false, nil, nil, true)

				if self.is_server then
					StatusUtils.set_grabbed_by_pack_master_network("pack_master_released", unit, false, nil)
				end

				self.release_falling_time = nil
			end
		elseif self.pack_master_status == "pack_master_unhooked" then
			if self.release_unhook_time and self.release_unhook_time < t then
				local locomotion = ScriptUnit.extension(unit, "locomotion_system")

				locomotion.set_disabled(locomotion, false, nil, nil, true)

				if self.is_server then
					StatusUtils.set_grabbed_by_pack_master_network("pack_master_released", unit, false, nil)
				end

				self.release_unhook_time = nil
			end
		elseif self.pack_master_status == "pack_master_released" then
			self.pack_master_status = nil
		end
	end

	local poison_level = math.min(PlayerUnitStatusSettings.poison_level_max, self.poison_level)

	if self.is_server and 0 < poison_level and self.poison_next_t < t then
		self.poison_next_t = t + PlayerUnitStatusSettings.poison_dot_time

		if Unit.alive(self.poison_attacker) then
			local damage = PlayerUnitStatusSettings.poison_dot_function(poison_level)

			DamageUtils.add_damage_network(unit, self.poison_attacker, damage, "full", "globadier_gas_dot", Vector3(1, 0, 0), "skaven_poison_wind_globadier")
		end
	end

	if 0 < poison_level then
		local wwise_world = Managers.world:wwise_world(self.world)

		if self.poison_time_to_cough < t then
			local dialogue_input = ScriptUnit.extension_input(unit, "dialogue_system")
			local event_data = FrameTable.alloc_table()

			dialogue_input.trigger_dialogue_event(dialogue_input, "hit_by_goo", event_data)

			self.poison_time_to_cough = t + 2
		end
	elseif self.poison_t then
		self.poison_next_t = nil
		self.poison_time_to_cough = nil
	end

	for id, func in pairs(self.update_funcs) do
		func(self, t)
	end

	return 
end
GenericStatusExtension.set_spawn_grace_time = function (self, duration)
	local t = Managers.time:time("game")
	self.spawn_grace_time = t + duration
	self.spawn_grace = true
	self.update_funcs.spawn_grace_time = GenericStatusExtension.update_spawn_grace_time

	return 
end
GenericStatusExtension.update_spawn_grace_time = function (self, t)
	if self.spawn_grace_time < t then
		self.spawn_grace = false
		self.update_funcs.spawn_grace_time = nil
	end

	return 
end
GenericStatusExtension.update_falling = function (self, t)
	if self.locomotion_extension:is_colliding_down() and not self.on_ladder then
		local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(self.unit)
		local FALL_DAMAGE_MULTIPLIER = movement_settings_table.fall.heights.FALL_DAMAGE_MULTIPLIER
		local MIN_FALL_DAMAGE_HEIGHT = movement_settings_table.fall.heights.MIN_FALL_DAMAGE_HEIGHT
		local MIN_FALL_DAMAGE = movement_settings_table.fall.heights.MIN_FALL_DAMAGE
		local MAX_FALL_DAMAGE = movement_settings_table.fall.heights.MAX_FALL_DAMAGE
		local HARD_LANDING_FALL_HEIGHT = movement_settings_table.fall.heights.HARD_LANDING_FALL_HEIGHT
		local end_fall_height = POSITION_LOOKUP[self.unit].z
		local fall_distance = self.fall_height - end_fall_height

		if MIN_FALL_DAMAGE_HEIGHT < fall_distance then
			fall_distance = math.abs(fall_distance)
			local network_height = math.clamp(fall_distance*4, 0, 255)
			local network_manager = Managers.state.network
			local unit_storage = Managers.state.unit_storage
			local go_id = unit_storage.go_id(unit_storage, self.unit)

			network_manager.network_transmit:send_rpc_server("rpc_take_falling_damage", go_id, network_height)

			local fall_event = "landed_soft"

			if HARD_LANDING_FALL_HEIGHT <= fall_distance then
				fall_event = "landed_hard"
			end

			if self.first_person_extension then
				self.first_person_extension:play_camera_effect_sequence(fall_event, t)
			end
		end

		self.update_funcs.falling = nil
		self.fall_height = nil
	end

	return 
end
GenericStatusExtension._get_current_max_fatigue_points = function (self)
	local inventory_extension = self.inventory_extension
	local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
	local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)

	if slot_data then
		local item_data = slot_data.item_data
		local item_template = BackendUtils.get_item_template(item_data)
		local max_fatigue_points = item_template.max_fatigue_points

		if max_fatigue_points then
			max_fatigue_points = self.buff_extension:apply_buffs_to_value(max_fatigue_points, StatBuffIndex.MAX_FATIGUE)
			local player = self.player
			local boon_handler = player.boon_handler

			if boon_handler then
				local num_bonus_fatigue_boons = boon_handler.get_num_boons(boon_handler, "bonus_fatigue")
				local boon_template = BoonTemplates.bonus_fatigue
				max_fatigue_points = max_fatigue_points + num_bonus_fatigue_boons*boon_template.fatigue_increase
			end
		end

		if slot_name == "slot_healthkit" and self.buff_extension and self.buff_extension:has_buff_type("no_interruption_bandage") then
			max_fatigue_points = max_fatigue_points + 6
		end

		return max_fatigue_points
	end

	return 
end
GenericStatusExtension.blocked_attack = function (self, fatigue_type, attacking_unit)
	local unit = self.unit
	local inventory_extension = self.inventory_extension
	local equipment = inventory_extension.equipment(inventory_extension)
	local network_manager = Managers.state.network
	local blocking_unit = nil

	self.set_has_blocked(self, true)

	local player = self.player

	if player then
		if not player.remote then
			local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
			local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)
			local t = Managers.time:time("game")
			local time_blocking = t - self.raise_block_time
			local timed_block = time_blocking <= 0.3

			if Managers.state.controller_features and player.local_player then
				Managers.state.controller_features:add_effect("rumble", {
					rumble_effect = "block"
				})
			end

			Unit.animation_event(first_person_unit, "parry_hit_reaction")

			local buff_extension = self.buff_extension
			local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.NO_BLOCK_FATIGUE_COST)

			if not procced then
				self.add_fatigue_points(self, fatigue_type, "block")
			end

			blocking_unit = equipment.right_hand_wielded_unit or equipment.left_hand_wielded_unit
			local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.DAMAGE_ON_TIMED_BLOCK)

			if timed_block and procced and Unit.alive(attacking_unit) then
				local wielded_slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
				local slot_data = inventory_extension.get_slot_data(inventory_extension, wielded_slot_name)
				local item_data = slot_data.item_data
				local item_name = item_data.name
				local damage_source_id = NetworkLookup.damage_sources[item_name]
				local unit_id = network_manager.unit_game_object_id(network_manager, unit)
				local hit_unit_id = network_manager.unit_game_object_id(network_manager, attacking_unit)
				local attack_template_id = NetworkLookup.attack_templates.damage_on_timed_block
				local hit_zone_id = NetworkLookup.hit_zones.full
				local attack_direction = Vector3.normalize(POSITION_LOOKUP[attacking_unit] - POSITION_LOOKUP[unit])
				local backstab_multiplier = 1
				local hawkeye_multiplier = 0

				network_manager.network_transmit:send_rpc_server("rpc_attack_hit", damage_source_id, unit_id, hit_unit_id, attack_template_id, hit_zone_id, attack_direction, NetworkLookup.attack_damage_values["n/a"], NetworkLookup.hit_ragdoll_actors["n/a"], backstab_multiplier, hawkeye_multiplier)
			end

			_, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.INCREASE_DAMAGE_TO_ENEMY_BLOCK)

			if (procced or script_data.debug_legendary_traits) and Unit.alive(attacking_unit) and ScriptUnit.has_extension(attacking_unit, "buff_system") then
				local buff_system = Managers.state.entity:system("buff_system")

				buff_system.add_buff(buff_system, attacking_unit, "increase_incoming_damage", unit)
			end
		else
			Unit.animation_event(unit, "parry_hit_reaction")

			blocking_unit = equipment.right_hand_wielded_unit_3p or equipment.left_hand_wielded_unit_3p
		end

		Managers.state.entity:system("play_go_tutorial_system"):register_block()
	end

	if blocking_unit then
		local unit_pos = POSITION_LOOKUP[blocking_unit]
		local unit_rot = Unit.world_rotation(blocking_unit, 0)
		local particle_position = unit_pos + Quaternion.up(unit_rot)*Math.random()*0.5 + Quaternion.right(unit_rot)*0.1

		World.create_particles(self.world, "fx/wpnfx_sword_spark_parry", particle_position)
	end

	return 
end
GenericStatusExtension.set_shielded = function (self, shielded)
	local unit = self.unit
	local player = self.player
	local t = Managers.time:time("game")

	if player.local_player then
		local first_person_extension = ScriptUnit.extension(unit, "first_person_system")

		if shielded then
			first_person_extension.play_hud_sound_event(first_person_extension, "hud_player_buff_shield_activate")
			first_person_extension.create_screen_particles(first_person_extension, "fx/screenspace_shield_healed")
		else
			local damage_extension = self.damage_extension
			local shield_end_reason = damage_extension.previous_shield_end_reason(damage_extension)

			if shield_end_reason == "blocked_damage" then
				first_person_extension.play_hud_sound_event(first_person_extension, "hud_player_buff_shield_down")
			elseif shield_end_reason == "timed_out" then
				first_person_extension.play_hud_sound_event(first_person_extension, "hud_player_buff_shield_deactivate")
			end
		end
	end

	self.shielded = shielded

	return 
end
GenericStatusExtension.healed = function (self, reason)
	local unit = self.unit
	local player = self.player
	local t = Managers.time:time("game")

	if player.local_player then
		local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
		local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)

		Unit.flow_event(first_person_unit, "sfx_heal")

		local mood = HealingMoods[reason]

		if mood then
			MOOD_BLACKBOARD[mood] = true
		end
	else
		ScriptWorld.create_particles_linked(self.world, "fx/chr_player_fak_healed", unit, 0, "destroy")
	end

	return 
end
GenericStatusExtension.fatigued = function (self)
	local max_fatigue = PlayerUnitStatusSettings.MAX_FATIGUE
	local max_fatigue_points = self.max_fatigue_points

	return (max_fatigue_points == 0 and true) or max_fatigue - max_fatigue/max_fatigue_points < self.fatigue
end
GenericStatusExtension.add_fatigue_points = function (self, fatigue_type, action)
	if Development.parameter("disable_fatigue_system") then
		return 
	end

	local amount = PlayerUnitStatusSettings.fatigue_point_costs[fatigue_type]

	if (action and action == "block" and self.buff_extension:has_buff_type("no_block_fatigue_cost")) or (action == "push" and self.buff_extension:has_buff_type("no_push_fatigue_cost")) then
		amount = amount*0.5
	end

	local t = Managers.time:time("game")
	local max_fatigue = PlayerUnitStatusSettings.MAX_FATIGUE
	local max_fatigue_points = self.max_fatigue_points
	local fatigue_cost = amount*max_fatigue/max_fatigue_points
	self.fatigue = math.clamp(self.fatigue + fatigue_cost, 0, max_fatigue)
	local block_breaking = false

	if self._block_breaking_fatigue_gain(self, fatigue_type, max_fatigue) then
		local _, procced = self.buff_extension:apply_buffs_to_value(0, StatBuffIndex.FULL_FATIGUE_ON_BLOCK_BROKEN)

		if procced then
			self.fatigue = 0
		else
			self.set_block_broken(self, true)

			block_breaking = true
		end
	end

	if 0 <= fatigue_cost then
		self.last_fatigue_gain_time = t
	end

	if GameSettingsDevelopment.use_telemetry then
		local player_manager = Managers.player
		local player = self.player
		local telemetry_id = player.telemetry_id(player)
		local hero = player.profile_display_name(player)
		local telemetry_data = self.fatigue_telemetry
		telemetry_data.fatigue_type = fatigue_type
		telemetry_data.position = POSITION_LOOKUP[self.unit]
		telemetry_data.block_breaking = block_breaking
		telemetry_data.player_id = telemetry_id
		telemetry_data.hero = hero

		Managers.telemetry:register_event("fatigue_gain", telemetry_data)
	end

	return 
end
GenericStatusExtension.get_dodge_item_data = function (self)
	local inventory_extension = self.inventory_extension
	local slot_name = inventory_extension.get_wielded_slot_name(inventory_extension)
	local slot_data = inventory_extension.get_slot_data(inventory_extension, slot_name)
	local buff_extension = self.buff_extension
	local dodge_count = nil

	if slot_data then
		local item_data = slot_data.item_data
		local item_template = BackendUtils.get_item_template(item_data)
		dodge_count = item_template.dodge_count
	end

	if buff_extension and buff_extension.has_buff_type(buff_extension, "movement_speed") then
		dodge_count = 100
	end

	self.dodge_count = dodge_count or 2

	return 
end
GenericStatusExtension.add_dodge_cooldown = function (self)
	self.get_dodge_item_data(self)

	self.dodge_cooldown = math.min(self.dodge_cooldown + 1, self.dodge_count + 3)
	self.dodge_cooldown_delay = nil

	return 
end
GenericStatusExtension.start_dodge_cooldown = function (self, t)
	self.dodge_cooldown_delay = t + 0.5

	return 
end
GenericStatusExtension.get_dodge_cooldown = function (self)
	local cooldown = (math.max(self.dodge_cooldown - self.dodge_count, 0)/3 - 1)*0.6 + 0.4

	return cooldown
end
GenericStatusExtension._block_breaking_fatigue_gain = function (self, fatigue_type, max_fatigue)
	return max_fatigue <= self.fatigue and (fatigue_type == "blocked_attack" or fatigue_type == "sv_shove" or fatigue_type == "complete" or fatigue_type == "blocked_ranged" or fatigue_type == "blocked_running" or fatigue_type == "blocked_sv_cleave" or fatigue_type == "blocked_sv_sweep")
end
GenericStatusExtension.current_fatigue = function (self)
	return self.fatigue
end
GenericStatusExtension.current_fatigue_points = function (self)
	local max_fatigue = PlayerUnitStatusSettings.MAX_FATIGUE
	local max_fatigue_points = self.max_fatigue_points

	return (max_fatigue_points ~= 0 or 0) and math.ceil(self.fatigue/max_fatigue/max_fatigue_points), max_fatigue_points
end
GenericStatusExtension.set_pushed = function (self, pushed)
	if pushed and self.push_cooldown then
		return 
	elseif pushed then
		self.pushed = pushed
		self.push_cooldown = true
	else
		self.pushed = pushed
	end

	return 
end
GenericStatusExtension.hitreact_interrupt = function (self)
	if self.interrupt_cooldown then
		return false
	else
		self.interrupt_cooldown = true

		return true
	end

	return 
end
GenericStatusExtension.want_an_attack = function (self)
	return self.attack_allowed
end
GenericStatusExtension.add_attack_intensity = function (self, attack_intensity)
	self.attack_intensity = self.attack_intensity + attack_intensity

	if self.attack_intensity_threshold < self.attack_intensity then
		self.attack_allowed = false
	end

	return 
end
GenericStatusExtension.is_pushed = function (self)
	return self.pushed and not self.overcharge_exploding
end
GenericStatusExtension.set_block_broken = function (self, block_broken)
	self.block_broken = block_broken

	if block_broken then
		self.block_broken_degen_delay = 2.5
	end

	return 
end
GenericStatusExtension.set_has_blocked = function (self, has_blocked)
	self._has_blocked = has_blocked

	return 
end
GenericStatusExtension.set_pounced_down = function (self, pounced_down, pouncer_unit)
	local unit = self.unit
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	self.pounced_down = pounced_down

	if pounced_down then
		self.pouncer_unit = pouncer_unit
		local foe_rotation = Unit.local_rotation(pouncer_unit, 0)
		local foe_forward = Quaternion.forward(foe_rotation)
		local towards_foe_rotation = Quaternion.look(-foe_forward, Vector3.up())

		Unit.set_local_rotation(unit, 0, towards_foe_rotation)
		Unit.set_local_rotation(pouncer_unit, 0, towards_foe_rotation)

		if not NetworkUnit.is_husk_unit(unit) then
			locomotion.set_wanted_velocity(locomotion, Vector3.zero())
		end

		locomotion.set_disabled(locomotion, true, LocomotionUtils.update_local_animation_driven_movement_with_parent, pouncer_unit)
	else
		locomotion.set_disabled(locomotion, false, LocomotionUtils.update_local_animation_driven_movement_with_parent)

		self.pouncer_unit = nil
	end

	self.set_outline_incapacitated(self, pounced_down or self.is_disabled(self))

	if pounced_down then
		SurroundingAwareSystem.add_event(unit, "pounced_down", DialogueSettings.pounced_down_broadcast_range, "target", unit, "target_name", ScriptUnit.extension(unit, "dialogue_system").context.player_profile)

		local dialogue_input = ScriptUnit.extension_input(unit, "dialogue_system")
		local event_data = FrameTable.alloc_table()
		event_data.distance = DialogueSettings.pounced_down_broadcast_range
		event_data.target = unit
		event_data.target_name = ScriptUnit.extension(unit, "dialogue_system").context.player_profile

		dialogue_input.trigger_dialogue_event(dialogue_input, "pounced_down", event_data)
		Managers.music:trigger_event("enemy_gutter_runner_pounced_stinger")
	end

	if self.is_server then
		local go_id = Managers.state.unit_storage:go_id(self.unit)
		local enemy_go_id = Managers.state.unit_storage:go_id(pouncer_unit)

		Managers.state.network.network_transmit:send_rpc_clients("rpc_status_change_bool", NetworkLookup.statuses.pounced_down, pounced_down, go_id, enemy_go_id)
	end

	return 
end
GenericStatusExtension.set_crouching = function (self, crouching)
	self.crouching = crouching

	self.set_slowed(self, crouching)

	local player_manager = Managers.player
	local player = self.player

	if player and not player.remote then
		local go_id = Managers.state.unit_storage:go_id(self.unit)

		if self.is_server then
			Managers.state.network.network_transmit:send_rpc_clients("rpc_status_change_bool", NetworkLookup.statuses.crouching, crouching, go_id, 0)
		else
			Managers.state.network.network_transmit:send_rpc_server("rpc_status_change_bool", NetworkLookup.statuses.crouching, crouching, go_id, 0)
		end
	end

	return 
end
GenericStatusExtension.crouch_toggle = function (self)
	local crouching = not self.crouching
	self.crouch_toggle_locked = crouching

	return crouching
end
GenericStatusExtension.get_crouch_toggle_locked = function (self)
	return self.crouch_toggle_locked
end
GenericStatusExtension.free_crouch_toggle_lock = function (self)
	self.crouch_toggle_locked = false

	return 
end
local biggest_hit = {}
GenericStatusExtension.set_knocked_down = function (self, knocked_down)
	self.knocked_down = knocked_down
	local unit = self.unit
	local player = self.player
	local is_server = self.is_server
	local game = Managers.state.network:game()
	local player_unit_go_id = Managers.state.unit_storage:go_id(unit)
	local damage_extension = self.damage_extension or ScriptUnit.extension(unit, "damage_system")
	local health_extension = self.health_extension or ScriptUnit.extension(unit, "health_system")
	local buff_extension = self.buff_extension or ScriptUnit.extension(unit, "buff_system")

	self.set_outline_incapacitated(self, knocked_down)

	if knocked_down then
		SurroundingAwareSystem.add_event(unit, "knocked_down", DialogueSettings.knocked_down_broadcast_range, "target", unit, "target_name", ScriptUnit.extension(unit, "dialogue_system").context.player_profile)

		local dialogue_input = ScriptUnit.extension_input(unit, "dialogue_system")
		local event_data = FrameTable.alloc_table()
		event_data.distance = 0
		event_data.height_distance = 0
		event_data.target_name = ScriptUnit.extension(unit, "dialogue_system").context.player_profile

		dialogue_input.trigger_dialogue_event(dialogue_input, "knocked_down", event_data)

		local position = POSITION_LOOKUP[unit]
		local nearby_units = {}
		local num_nearby_units = AiUtils.broadphase_query(position, DialogueSettings.knocked_down_broadcast_range, nearby_units)

		for i = 1, num_nearby_units, 1 do
			local nearby_unit = nearby_units[i]
			local dialogue_input = ScriptUnit.extension_input(nearby_unit, "dialogue_system")

			dialogue_input.trigger_dialogue_event(dialogue_input, "knocked_down", event_data)
		end

		health_extension.set_current_damage(health_extension, 0)
		health_extension.set_max_health(health_extension, PlayerUnitDamageSettings.KNOCKEDDOWN_MAX_HP, true)

		if is_server then
			local in_brawl_mode = Managers.state.game_mode:level_key() == "inn_level"

			if in_brawl_mode then
				buff_extension.add_buff(buff_extension, "brawl_knocked_down")
			else
				self.knocked_down_bleed_id = buff_extension.add_buff(buff_extension, "knockdown_bleed")
			end
		end

		if player.local_player then
			MOOD_BLACKBOARD.knocked_down = true
		end
	else
		local difficulty_manager = Managers.state.difficulty
		local difficulty_settings = difficulty_manager.get_difficulty_settings(difficulty_manager)
		local player_health = difficulty_settings.max_hp

		damage_extension.reset(damage_extension)
		health_extension.set_current_damage(health_extension, player_health/2)
		health_extension.set_max_health(health_extension, player_health, true)

		if is_server and self.knocked_down_bleed_id then
			buff_extension.remove_buff(buff_extension, self.knocked_down_bleed_id)

			self.knocked_down_bleed_id = nil
		end

		if player.local_player then
			MOOD_BLACKBOARD.knocked_down = false
		end
	end

	if knocked_down then
		if is_server then
			if script_data.debug_player_intensity then
				Managers.state.conflict.pacing:annotate_graph("knockdown", "red")
			end

			self.add_intensity(self, CurrentIntensitySettings.intensity_add_knockdown)
		end

		if GameSettingsDevelopment.use_telemetry then
			local kill_damages, num_kill_damages = damage_extension.recent_damages(damage_extension)

			pack_index[DamageDataIndex.STRIDE](biggest_hit, 1, unpack_index[DamageDataIndex.STRIDE](kill_damages, 1))

			local damage_type = biggest_hit[DamageDataIndex.DAMAGE_TYPE]

			self._add_player_knocked_down_telemetry(self, unit, player, damage_type)
		end
	end

	return 
end
GenericStatusExtension._add_player_knocked_down_telemetry = function (self, player_unit, player, damage_type)
	if player then
		local local_player = player.local_player
		local is_bot = player.bot_player

		if (is_bot and self.is_server) or local_player then
			local telemetry_id = player.telemetry_id(player)
			local position = POSITION_LOOKUP[player_unit]
			local hero = player.profile_display_name(player)
			local knocked_down_telemetry = self.knocked_down_telemetry
			knocked_down_telemetry.damage_type = damage_type
			knocked_down_telemetry.position = position
			knocked_down_telemetry.player_id = telemetry_id
			knocked_down_telemetry.hero = hero

			Managers.telemetry:register_event("player_knocked_down", knocked_down_telemetry)
		end
	end

	return 
end
GenericStatusExtension.set_ready_for_assisted_respawn = function (self, ready, flavour_unit)
	local previously_ready = self.ready_for_assisted_respawn
	self.ready_for_assisted_respawn = ready
	self.assisted_respawn_flavour_unit = flavour_unit
	local unit = self.unit
	local player = self.player
	local outline_extension = ScriptUnit.extension(unit, "outline_system")
	local method_name, color_name = nil

	if ready then
		method_name = "always"
		color_name = "interactable"
	else
		if player and player.local_player then
			method_name = "never"
		else
			method_name = "outside_distance_or_not_visible"
		end

		color_name = "ally"
	end

	if player and player.local_player then
		outline_extension.set_method(method_name)
	else
		outline_extension.set_method_player_setting(method_name)
	end

	outline_extension.set_outline_color(color_name)

	local health_extension = ScriptUnit.extension(unit, "health_system")

	if ready then
		health_extension.set_max_health(health_extension, math.huge, true)
	elseif previously_ready and not ready then
		local difficulty_manager = Managers.state.difficulty
		local difficulty_settings = difficulty_manager.get_difficulty_settings(difficulty_manager)
		local player_health = difficulty_settings.max_hp

		health_extension.set_max_health(health_extension, player_health, true)
		health_extension.set_current_damage(health_extension, player_health/2)
	end

	return 
end
GenericStatusExtension.set_assisted_respawning = function (self, respawning, helper_unit)
	self.assisted_respawning = respawning
	self.assisted_respawn_helper_unit = helper_unit

	return 
end
GenericStatusExtension.is_assisted_respawning = function (self)
	return self.assisted_respawning
end
GenericStatusExtension.get_assisted_respawn_helper_unit = function (self)
	return self.assisted_respawn_helper_unit
end
GenericStatusExtension.set_respawned = function (self, respawned)
	local unit = self.unit

	if respawned then
		self.set_ready_for_assisted_respawn(self, false)
	end

	return 
end
GenericStatusExtension.set_dead = function (self, dead)
	local player = self.player
	local unit = self.unit

	if dead and ScriptUnit.has_extension(unit, "outline_system") then
		local outline_extension = ScriptUnit.extension(unit, "outline_system")

		if player and player.local_player then
			outline_extension.set_method("never")
		else
			outline_extension.set_method_player_setting("never")
		end
	end

	if dead and player and not player.remote then
		local inventory_extension = self.inventory_extension

		CharacterStateHelper.stop_weapon_actions(inventory_extension, "dead")
	end

	if dead then
		SurroundingAwareSystem.add_event(unit, "player_death", DialogueSettings.death_discover_distance, "target", unit, "target_name", ScriptUnit.extension(unit, "dialogue_system").context.player_profile)
		StatisticsUtil.register_player_death(unit, Managers.player:statistics_db())
	end

	self.dead = dead

	return 
end
GenericStatusExtension.set_blocking = function (self, blocking)
	self.blocking = blocking

	if blocking then
		local t = Managers.time:time("game")
		self.raise_block_time = t
	end

	return 
end
GenericStatusExtension.set_slowed = function (self, slowed)
	self.is_slowed = slowed

	return 
end
GenericStatusExtension.set_wounded = function (self, wounded, reason, t)
	self.wounded = wounded

	if wounded then
		if self.is_server then
			self.wounded_timer = t + PlayerUnitStatusSettings.WOUNDED_DEGEN_DELAY
		end

		self.wounds = self.wounds - 1
	elseif reason == "healed" then
		self.wounds = self.max_wounds
	end

	local unit = self.unit

	if self.player.local_player then
		MOOD_BLACKBOARD.wounded = self.wounds == 1

		if not MOOD_BLACKBOARD.wounded then
			MOOD_BLACKBOARD.bleeding_out = wounded
		else
			MOOD_BLACKBOARD.bleeding_out = false
		end
	end

	return 
end
GenericStatusExtension.set_pulled_up = function (self, pulled_up, helper)
	if self.is_ledge_hanging then
		self.pulled_up = pulled_up

		if pulled_up then
			local dialogue_input = ScriptUnit.extension_input(self.unit, "dialogue_system")
			local event_data = FrameTable.alloc_table()
			event_data.reviver = helper
			event_data.reviver_name = ScriptUnit.extension(helper, "dialogue_system").context.player_profile

			dialogue_input.trigger_dialogue_event(dialogue_input, "revive_completed", event_data)
		end
	elseif not pulled_up then
		self.pulled_up = pulled_up
	end

	return 
end
GenericStatusExtension.set_revived = function (self, revived, reviver)
	self.revived = revived

	if revived then
		local dialogue_input = ScriptUnit.extension_input(self.unit, "dialogue_system")
		local event_data = FrameTable.alloc_table()
		event_data.reviver = reviver
		event_data.reviver_name = ScriptUnit.extension(reviver, "dialogue_system").context.player_profile

		dialogue_input.trigger_dialogue_event(dialogue_input, "revive_completed", event_data)
	end

	return 
end
GenericStatusExtension.set_zooming = function (self, zooming, camera_name)
	self.zooming = zooming

	self.set_slowed(self, zooming)

	local unit = self.unit
	local player = self.player
	local camera_follow_unit = player.camera_follow_unit
	local buff_extension = ScriptUnit.extension(unit, "buff_system")

	if zooming then
		if Unit.alive(camera_follow_unit) then
			camera_name = camera_name or "zoom_in"

			Unit.set_data(camera_follow_unit, "camera", "settings_node", camera_name)

			self.zoom_mode = camera_name
		end
	else
		if Unit.alive(camera_follow_unit) then
			Unit.set_data(camera_follow_unit, "camera", "settings_node", "first_person_node")
		end

		self.zoom_mode = nil
	end

	return 
end
local DEFAULT_ZOOM_TABLE = {
	"zoom_in",
	"increased_zoom_in"
}
GenericStatusExtension.switch_variable_zoom = function (self, zoom_table)
	local player = self.player
	local camera_follow_unit = player.camera_follow_unit

	if Unit.alive(camera_follow_unit) then
		zoom_table = zoom_table or DEFAULT_ZOOM_TABLE
		local new_index = 1

		for i, camera_name in ipairs(zoom_table) do
			if camera_name == self.zoom_mode then
				new_index = i%#zoom_table + 1

				break
			end
		end

		local new_camera_name = zoom_table[new_index]

		Unit.set_data(camera_follow_unit, "camera", "settings_node", new_camera_name)

		self.zoom_mode = new_camera_name
	end

	return 
end
GenericStatusExtension.set_catapulted = function (self, catapulted, velocity)
	if catapulted then
		if not self.is_disabled(self) then
			local unit = self.unit
			self.catapulted = true
			self.last_catapulted_time = Managers.time:time("game")

			if not NetworkUnit.is_husk_unit(unit) then
				local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

				locomotion_extension.set_maximum_upwards_velocity(locomotion_extension, Vector3.z(velocity))
				locomotion_extension.set_forced_velocity(locomotion_extension, velocity)
				locomotion_extension.set_wanted_velocity(locomotion_extension, velocity)

				local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
				local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)
				local dir = Vector3.dot(Quaternion.forward(first_person_extension.current_rotation(first_person_extension)), velocity)
				local look_dir, catapulted_direction = nil

				if 0 < dir then
					look_dir = Vector3.normalize(velocity)
					catapulted_direction = "forward"
				else
					look_dir = Vector3.normalize(-velocity)
					catapulted_direction = "backward"
				end

				self.catapulted_direction = catapulted_direction
				local rot = Quaternion.look(look_dir, Vector3.up())

				first_person_extension.force_look_rotation(first_person_extension, rot)
			end

			if self.is_server then
				local unit_id = Managers.state.unit_storage:go_id(unit)

				Managers.state.network.network_transmit:send_rpc_clients("rpc_set_catapulted", unit_id, velocity)
			end
		end
	else
		self.catapulted = false
		self.catapulted_direction = nil
	end

	return 
end
GenericStatusExtension.set_inside_transport_unit = function (self, unit)
	self.inside_transport_unit = unit

	return 
end
GenericStatusExtension.set_using_transport = function (self, using_transport)
	self.using_transport = using_transport

	return 
end
GenericStatusExtension.set_overcharge_exploding = function (self, overcharge_exploding)
	self.overcharge_exploding = overcharge_exploding

	return 
end
GenericStatusExtension.set_left_ladder = function (self, t)
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(self.unit)
	self.left_ladder_timer = t + movement_settings_table.ladder.leave_ladder_reattach_time

	return 
end
GenericStatusExtension.set_is_on_ladder = function (self, is_on_ladder, ladder_unit)
	self.on_ladder = is_on_ladder
	self.current_ladder_unit = ladder_unit

	return 
end
GenericStatusExtension.set_is_ledge_hanging = function (self, is_ledge_hanging, ledge_unit)
	self.is_ledge_hanging = is_ledge_hanging
	self.current_ledge_hanging_unit = ledge_unit
	local unit = self.unit

	if not is_ledge_hanging then
		self.pulled_up = false
	end

	self.set_outline_incapacitated(self, is_ledge_hanging)

	if is_ledge_hanging then
		SurroundingAwareSystem.add_event(unit, "ledge_hanging", DialogueSettings.grabbed_broadcast_range, "target", unit, "target_name", ScriptUnit.extension(unit, "dialogue_system").context.player_profile)

		local dialogue_input = ScriptUnit.extension_input(unit, "dialogue_system")
		local event_data = FrameTable.alloc_table()
		event_data.target_name = ScriptUnit.extension(unit, "dialogue_system").context.player_profile

		dialogue_input.trigger_dialogue_event(dialogue_input, "ledge_hanging", event_data)
	end

	return 
end
GenericStatusExtension.set_outline_incapacitated = function (self, incapacitated)
	local unit = self.unit
	local player = self.player

	if not player then
		return 
	end

	if not player.local_player then
		local outline_extension = ScriptUnit.extension(unit, "outline_system")
		local color_name = (incapacitated and "knocked_down") or "ally"
		local method_name = (incapacitated and "always") or "outside_distance_or_not_visible"

		outline_extension.set_outline_color(color_name)
		outline_extension.set_method_player_setting(method_name)
	end

	return 
end
GenericStatusExtension._set_packmaster_unhooked = function (self, locomotion, grabbed_status)
	local unit = self.unit
	local t = Managers.time:time("game")

	if self.release_unhook_time then
	elseif self.dead then
		if grabbed_status == "pack_master_dragging" or grabbed_status == "pack_master_pulling" then
			self.release_unhook_time = t + PlayerUnitStatusSettings.hanging_by_pack_master.release_dragging_time_dead
		else
			self.release_unhook_time = t + PlayerUnitStatusSettings.hanging_by_pack_master.release_unhook_time_dead
		end
	elseif self.knocked_down then
		self.release_unhook_time = t + PlayerUnitStatusSettings.hanging_by_pack_master.release_unhook_time_ko
	else
		self.release_unhook_time = t + PlayerUnitStatusSettings.hanging_by_pack_master.release_unhook_time
	end

	if not NetworkUnit.is_husk_unit(unit) then
		locomotion.set_wanted_velocity(locomotion, Vector3.zero())
		locomotion.move_to_non_intersecting_position(locomotion)
	end

	self.pack_master_status = "pack_master_unhooked"

	return 
end
GenericStatusExtension.set_pack_master = function (self, grabbed_status, is_grabbed, grabber_unit)
	local unit = self.unit
	self.pack_master_grabber = (is_grabbed and grabber_unit) or nil
	local previous_status = self.pack_master_status
	self.pack_master_status = grabbed_status
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	if grabbed_status == "pack_master_pulling" then
		if not is_grabbed then
			self._set_packmaster_unhooked(self, locomotion, grabbed_status)

			return 
		end

		self.release_unhook_time = nil
		local foe_rotation = Unit.local_rotation(grabber_unit, 0)
		local foe_forward = Quaternion.forward(foe_rotation)
		local back_to_grabber_rotation = Quaternion.look(foe_forward, Vector3.up())

		Unit.set_local_rotation(unit, 0, back_to_grabber_rotation)

		if not NetworkUnit.is_husk_unit(unit) then
			locomotion.set_wanted_velocity(locomotion, Vector3.zero())
		end

		local target_player = self.player
		local unit_name = SPProfiles[self.profile_id].unit_name
		local pulled_anim_name = "attack_grab_" .. unit_name

		Unit.animation_event(grabber_unit, pulled_anim_name)
		SurroundingAwareSystem.add_event(unit, "grabbed", DialogueSettings.grabbed_broadcast_range, "target", unit, "target_name", ScriptUnit.extension(unit, "dialogue_system").context.player_profile)
		Managers.music:trigger_event("enemy_pack_master_grabbed_stinger")

		self.pack_master_hoisted = false
	elseif grabbed_status == "pack_master_dragging" then
		if not is_grabbed then
			self._set_packmaster_unhooked(self, locomotion, grabbed_status)

			return 
		end

		if previous_status == "pack_master_pulling" then
			locomotion.set_disabled(locomotion, false, nil, nil, true)
		else
			Unit.animation_event(grabber_unit, "drag_walk")
			Unit.animation_event(unit, "move_bwd")
		end
	elseif grabbed_status == "pack_master_unhooked" then
		if previous_status ~= "pack_master_unhooked" then
			self._set_packmaster_unhooked(self, locomotion, grabbed_status)
		end

		locomotion.set_disabled(locomotion, false, nil, nil, true)
	elseif grabbed_status == "pack_master_hoisting" then
		if not is_grabbed then
			self._set_packmaster_unhooked(self, locomotion, grabbed_status)

			return 
		end

		if not NetworkUnit.is_husk_unit(unit) then
			locomotion.set_wanted_velocity(locomotion, Vector3.zero())
		end

		local dir = Vector3.normalize(POSITION_LOOKUP[unit] - POSITION_LOOKUP[grabber_unit])

		Unit.set_local_rotation(unit, 0, Quaternion.look(dir, Vector3.up()))
		Unit.animation_event(unit, "packmaster_hang_start")
		locomotion.set_disabled(locomotion, true, LocomotionUtils.update_local_animation_driven_movement_plus_mover)
		Unit.animation_event(grabber_unit, "attack_grab_hang")

		self.pack_master_hoisted = true
	elseif grabbed_status == "pack_master_hanging" then
		locomotion.set_disabled(locomotion, true, LocomotionUtils.update_local_animation_driven_movement_plus_mover)
	elseif grabbed_status == "pack_master_dropping" then
		local t = Managers.time:time("game")

		locomotion.set_disabled(locomotion, false, nil, nil, true)

		if self.release_falling_time then
		elseif self.dead then
			self.release_falling_time = t + PlayerUnitStatusSettings.hanging_by_pack_master.release_falling_time_dead
		elseif self.knocked_down then
			self.release_falling_time = t + PlayerUnitStatusSettings.hanging_by_pack_master.release_falling_time_ko
		else
			locomotion.set_disabled(locomotion, false, nil, nil, true)

			self.release_falling_time = t + PlayerUnitStatusSettings.hanging_by_pack_master.release_falling_time
		end
	elseif grabbed_status == "pack_master_released" then
		SurroundingAwareSystem.add_event(unit, "un_grabbed", DialogueSettings.grabbed_broadcast_range, "target", unit, "target_name", ScriptUnit.extension(unit, "dialogue_system").context.player_profile)

		if not Managers.state.network.is_server then
			locomotion.set_disabled(locomotion, false, nil, nil, true)
		end
	end

	self.set_outline_incapacitated(self, is_grabbed or self.is_disabled(self))

	return 
end
GenericStatusExtension.get_intensity = function (self)
	return self.intensity
end
GenericStatusExtension.is_pounced_down = function (self)
	return self.pounced_down, self.pouncer_unit
end
GenericStatusExtension.get_pouncer_unit = function (self)
	return self.pouncer_unit
end
GenericStatusExtension.is_knocked_down = function (self)
	return self.knocked_down
end
GenericStatusExtension.set_knocked_down_bleed_buff = function (self, stop_bleed)
	local buff_extension = self.buff_extension or ScriptUnit.extension(self.unit, "buff_system")

	if self.knocked_down_bleed_id and stop_bleed then
		buff_extension.remove_buff(buff_extension, self.knocked_down_bleed_id)

		self.knocked_down_bleed_id = nil
	elseif self.knocked_down and not stop_bleed then
		self.knocked_down_bleed_id = buff_extension.add_buff(buff_extension, "knockdown_bleed")
	end

	return self.knocked_down_bleed_id
end
GenericStatusExtension.is_ready_for_assisted_respawn = function (self)
	return self.ready_for_assisted_respawn
end
GenericStatusExtension.disabled_vo_reason = function (self)
	local vo_reason = nil

	if self.is_dead(self) then
		vo_reason = "dead"
	elseif self.is_pounced_down(self) then
		vo_reason = "pounced_down"
	elseif self.is_grabbed_by_pack_master(self) or self.is_hanging_from_hook(self) then
		vo_reason = "grabbed"
	elseif self.get_is_ledge_hanging(self) then
		vo_reason = "ledge_hanging"
	elseif self.is_knocked_down(self) or self.is_ready_for_assisted_respawn(self) then
		vo_reason = "knocked_down"
	end

	return vo_reason
end
GenericStatusExtension.set_has_bonus_fatigue_active = function (self)
	self.has_bonus_fatigue_active = true
	local t = Managers.time:time("game")
	self.bonus_fatigue_active_timer = t + 1.5
	local first_person_extension = self.first_person_extension

	if first_person_extension then
		first_person_extension.play_hud_sound_event(first_person_extension, "hud_player_buff_regen_stamina")
	end

	return 
end
GenericStatusExtension.is_disabled = function (self)
	return self.is_dead(self) or self.is_pounced_down(self) or self.is_knocked_down(self) or self.is_grabbed_by_pack_master(self) or self.get_is_ledge_hanging(self) or self.is_hanging_from_hook(self) or self.is_ready_for_assisted_respawn(self)
end
GenericStatusExtension.is_ogre_target = function (self)
	return not self.dead and not self.pounced_down and not self.is_grabbed_by_pack_master(self) and not self.is_hanging_from_hook(self) and not self.using_transport
end
GenericStatusExtension.is_dead = function (self)
	return self.dead
end
GenericStatusExtension.is_crouching = function (self)
	return self.crouching
end
GenericStatusExtension.is_blocking = function (self)
	return self.blocking
end
GenericStatusExtension.is_wounded = function (self)
	return self.wounded
end
GenericStatusExtension.heal_can_remove_wounded = function (self, heal_type)
	return heal_type == "healing_draught" or heal_type == "bandage" or heal_type == "bandage_trinket" or heal_type == "buff_shared_medpack"
end
GenericStatusExtension.is_revived = function (self)
	return self.revived
end
GenericStatusExtension.is_pulled_up = function (self)
	return self.pulled_up
end
GenericStatusExtension.is_zooming = function (self)
	return self.zooming
end
GenericStatusExtension.has_wounds_remaining = function (self)
	return 1 < self.wounds
end
GenericStatusExtension.has_recently_left_ladder = function (self, t)
	return t < self.left_ladder_timer
end
GenericStatusExtension.get_is_on_ladder = function (self)
	return self.on_ladder, self.current_ladder_unit
end
GenericStatusExtension.get_is_ledge_hanging = function (self)
	return self.is_ledge_hanging, self.current_ledge_hanging_unit
end
GenericStatusExtension.is_catapulted = function (self)
	return self.catapulted, self.catapulted_direction
end
GenericStatusExtension.is_block_broken = function (self)
	return self.block_broken
end
GenericStatusExtension.get_inside_transport_unit = function (self)
	return self.inside_transport_unit
end
GenericStatusExtension.is_using_transport = function (self)
	return self.using_transport
end
GenericStatusExtension.is_overcharge_exploding = function (self)
	return self.overcharge_exploding
end
GenericStatusExtension.is_grabbed_by_pack_master = function (self)
	return self.pack_master_grabber ~= nil and Unit.alive(self.pack_master_grabber)
end
GenericStatusExtension.is_hanging_from_hook = function (self)
	return self.pack_master_status == "pack_master_hanging"
end
GenericStatusExtension.get_pack_master_grabber = function (self)
	return self.pack_master_grabber
end
GenericStatusExtension.has_blocked = function (self)
	return self._has_blocked
end
GenericStatusExtension.current_move_speed_multiplier = function (self)
	local lerp_t = math.smoothstep(self.move_speed_multiplier_timer, 0, 1)

	return math.lerp(self.move_speed_multiplier, 1, lerp_t)
end
GenericStatusExtension.set_inspecting = function (self, inspecting)
	self.inspecting = inspecting

	return 
end
GenericStatusExtension.is_inspecting = function (self)
	return self.inspecting
end
GenericStatusExtension.can_dodge = function (self, t)
	return self.my_dodge_cd < t
end
GenericStatusExtension.set_dodge_cd = function (self, t, dodge_cd)
	self.my_dodge_cd = t + dodge_cd

	return 
end
GenericStatusExtension.can_override_dodge_with_jump = function (self, t)
	return t < self.my_dodge_jump_override_t
end
GenericStatusExtension.set_dodge_jump_override_t = function (self, t, dodge_jump_override_t)
	self.my_dodge_jump_override_t = t + dodge_jump_override_t

	return 
end
GenericStatusExtension.dodge_locked = function (self)
	return self.dodge_is_locked
end
GenericStatusExtension.set_dodge_locked = function (self, dodge_locked)
	self.dodge_is_locked = dodge_locked

	return 
end
GenericStatusExtension.set_is_dodging = function (self, is_dodging)
	self.is_dodging = is_dodging

	if is_dodging then
		self.dodge_position:store(Unit.world_position(self.unit, 0))
	end

	return 
end
GenericStatusExtension.reset_fatigue = function (self)
	self.fatigue = 0

	return 
end
GenericStatusExtension.get_is_dodging = function (self)
	return self.is_dodging
end
GenericStatusExtension.get_dodge_position = function (self)
	return self.dodge_position:unbox()
end
GenericStatusExtension.get_is_slowed = function (self)
	return self.is_slowed
end
GenericStatusExtension.set_falling_height = function (self, override)
	self.fall_height = (self.fall_height and not override and POSITION_LOOKUP[self.unit].z < self.fall_height and self.fall_height) or POSITION_LOOKUP[self.unit].z
	self.update_funcs.falling = GenericStatusExtension.update_falling

	return 
end
GenericStatusExtension.reset_falling_height = function (self)
	self.fall_height = 0
	self.update_funcs.falling = GenericStatusExtension.update_falling

	return 
end
GenericStatusExtension.modify_poison = function (self, increase, attacker_unit)
	local poison_level_old = self.poison_level

	if increase then
		self.poison_attacker = attacker_unit
		self.poison_level = poison_level_old + 1

		if poison_level_old == 0 then
			self.poison_next_t = 0
			self.poison_time_to_cough = 0

			if self.first_person_extension then
				local buff_extension = ScriptUnit.extension(self.unit, "buff_system")

				if buff_extension.has_buff_type(buff_extension, "poison_screen_effect_immune") then
					return 
				end

				local particle_id = World.create_particles(self.world, "fx/screenspace_poison_globe_impact", Vector3(0, 0, 0))
				self.poison_particle_id = particle_id
			end
		end
	else
		self.poison_level = poison_level_old - 1

		assert(0 <= self.poison_level, "Poison level became negative")

		if poison_level_old == 1 and self.poison_particle_id then
			World.stop_spawning_particles(self.world, self.poison_particle_id)

			self.poison_particle_id = nil
			self.times_poisoned = self.times_poisoned + 1

			SurroundingAwareSystem.add_event(self.unit, "was_hit_by_goo", DialogueSettings.grabbed_broadcast_range, "target_name", ScriptUnit.extension(self.unit, "dialogue_system").context.player_profile, "times_poisoned", self.times_poisoned)
		end
	end

	return 
end
GenericStatusExtension.max_wounds_network_safe = function (self)
	local max_wounds = self.max_wounds

	if max_wounds == math.huge then
		max_wounds = -1
	end

	return max_wounds
end
GenericStatusExtension.hot_join_sync = function (self, sender)
	local lookup = NetworkLookup.statuses
	local network_manager = Managers.state.network
	local self_game_object_id = network_manager.unit_game_object_id(network_manager, self.unit)
	local flavour_unit_game_object_id = (self.ready_for_assisted_respawn and network_manager.unit_game_object_id(network_manager, self.assisted_respawn_flavour_unit)) or 0

	RPC.rpc_hot_join_sync_health_status(sender, self_game_object_id, self.wounded, self.max_wounds_network_safe(self), self.ready_for_assisted_respawn, flavour_unit_game_object_id)

	if self.pack_master_status then
		local t = Managers.time:time("game")
		local is_grabbed = Unit.alive(self.pack_master_grabber)
		local grabber_go_id = network_manager.unit_game_object_id(network_manager, self.pack_master_grabber) or NetworkConstants.invalid_game_object_id
		local pack_master_status_id = lookup[self.pack_master_status]

		if self.pack_master_status == "pack_master_dropping" then
			local time_left = math.clamp(t - self.release_falling_time, 0, 7)

			RPC.rpc_hooked_sync(sender, pack_master_status_id, self_game_object_id, time_left)
		elseif self.pack_master_status == "pack_master_unhooked" then
			local time_left = math.clamp(t - self.release_unhook_time, 0, 7)

			RPC.rpc_hooked_sync(sender, pack_master_status_id, self_game_object_id, time_left)
		end

		RPC.rpc_status_change_bool(sender, pack_master_status_id, is_grabbed, self_game_object_id, grabber_go_id)
	end

	ledge_hanging_unit_game_object_id = (self.is_ledge_hanging and network_manager.unit_game_object_id(network_manager, self.current_ledge_hanging_unit)) or 0
	local pouncer_unit_game_object_id = (self.pounced_down and network_manager.unit_game_object_id(network_manager, self.pouncer_unit)) or 0
	local current_ladder_unit_game_object_id = (self.on_ladder and network_manager.unit_game_object_id(network_manager, self.current_ladder_unit)) or 0

	RPC.rpc_status_change_bool(sender, lookup.pounced_down, self.pounced_down, self_game_object_id, pouncer_unit_game_object_id)
	RPC.rpc_status_change_bool(sender, lookup.pushed, self.pushed, self_game_object_id, 0)
	RPC.rpc_status_change_bool(sender, lookup.dead, self.dead, self_game_object_id, 0)

	if self.knocked_down then
		local knocked_down_status_id = lookup.knocked_down

		RPC.rpc_status_change_bool(sender, knocked_down_status_id, true, self_game_object_id, 0)
	end

	RPC.rpc_status_change_bool(sender, lookup.crouching, self.crouching, self_game_object_id, 0)
	RPC.rpc_status_change_bool(sender, lookup.pulled_up, self.pulled_up, self_game_object_id, 0)
	RPC.rpc_status_change_bool(sender, lookup.ladder_climbing, self.on_ladder, self_game_object_id, current_ladder_unit_game_object_id)
	RPC.rpc_status_change_bool(sender, lookup.ledge_hanging, self.is_ledge_hanging, self_game_object_id, ledge_hanging_unit_game_object_id)

	return 
end

return 
