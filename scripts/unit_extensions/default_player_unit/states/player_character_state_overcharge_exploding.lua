PLayerCharacterStateOverchargeExploding = class(PLayerCharacterStateOverchargeExploding, PlayerCharacterState)
PLayerCharacterStateOverchargeExploding.init = function (self, character_state_init_context)
	PlayerCharacterState.init(self, character_state_init_context, "overcharge_exploding")

	local context = character_state_init_context
	self.movement_speed = 0
	self.movement_speed_limit = 1
	self.last_input_direction = Vector3Box(0, 0, 0)
	self.inside_inn = global_is_inside_inn

	return 
end
PLayerCharacterStateOverchargeExploding.on_enter = function (self, unit, input, dt, context, t, previous_state, params)
	CharacterStateHelper.stop_weapon_actions(self.inventory_extension, "exploding")

	local unit = self.unit
	local input_extension = self.input_extension
	local first_person_extension = self.first_person_extension
	local status_extension = self.status_extension
	self.damage_timer = t + 0.5
	self.movement_speed = 0.2
	local move_anim_3p, move_anim_1p = CharacterStateHelper.get_move_animation(self.locomotion_extension, input_extension, status_extension)

	CharacterStateHelper.play_animation_event(unit, "explode_start")
	CharacterStateHelper.play_animation_event_first_person(first_person_extension, "explode_start")

	self.move_anim_3p = move_anim_3p
	self.move_anim_1p = move_anim_1p
	local inventory_extension = self.inventory_extension
	local damage_extension = self.damage_extension

	self.last_input_direction:store(Vector3(0, 0, 0))

	self.explosion_time = t + 3
	self.has_exploded = false
	local slot_data = self.inventory_extension:get_slot_data("slot_ranged")
	local weapon_unit = slot_data.right_unit_1p or slot_data.left_unit_1p
	local weapon_overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")
	self.exploding_weapon_unit = weapon_unit
	self.explosion_template = weapon_overcharge_extension.explosion_template
	self.item_name = weapon_overcharge_extension.item_name
	self.walking = false

	return 
end
PLayerCharacterStateOverchargeExploding.on_exit = function (self, unit, input, dt, context, t, next_state)
	if Managers.state.network:game() then
		CharacterStateHelper.play_animation_event(unit, "cooldown_end")
		CharacterStateHelper.play_animation_event_first_person(self.first_person_extension, "cooldown_end")

		if not self.has_exploded then
			self.explode(self)
		end
	end

	return 
end
PLayerCharacterStateOverchargeExploding.explode = function (self)
	self.has_exploded = true
	local unit = self.unit

	StatusUtils.set_overcharge_exploding(unit, false)

	local weapon_unit = self.exploding_weapon_unit

	if Unit.alive(weapon_unit) then
		local weapon_overcharge_extension = ScriptUnit.extension(weapon_unit, "overcharge_system")

		weapon_overcharge_extension.reset(weapon_overcharge_extension)
	end

	if not self.inside_inn then
		local health_extension = ScriptUnit.extension(unit, "health_system")
		local self_damage = health_extension.get_max_health(health_extension)
		local buff_extension = ScriptUnit.extension(unit, "buff_system")
		local _, procced = buff_extension.apply_buffs_to_value(buff_extension, 0, StatBuffIndex.OVERCHARGE_EXPLOSION_IMMUNITY)

		if not procced then
			DamageUtils.add_damage_network(unit, unit, self_damage, "torso", "overcharge", Vector3(0, 1, 0), "overcharge")
		end
	end

	local position = POSITION_LOOKUP[unit]
	local rotation = Unit.local_rotation(unit, 0)
	local explosion_template = self.explosion_template
	local scale = 1
	local item_name = self.item_name

	Managers.state.entity:system("damage_system"):create_explosion(unit, position, rotation, explosion_template, scale, item_name)

	return 
end
PLayerCharacterStateOverchargeExploding.update = function (self, unit, input, dt, context, t)
	local csm = self.csm
	local world = self.world
	local unit = self.unit
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local input_extension = self.input_extension
	local status_extension = self.status_extension
	local first_person_extension = self.first_person_extension

	if CharacterStateHelper.do_common_state_transitions(status_extension, csm) then
		return 
	end

	if CharacterStateHelper.is_ledge_hanging(world, unit, self.temp_params) then
		csm.change_state(csm, "ledge_hanging", self.temp_params)

		return 
	end

	if self.explosion_time <= t and not self.has_exploded then
		self.explode(self)

		local is_moving = CharacterStateHelper.is_moving(input_extension)

		if is_moving then
			local params = self.temp_params

			csm.change_state(csm, "walking", params)

			return 
		end

		local params = self.temp_params

		csm.change_state(csm, "standing", params)

		return 
	end

	if self.damage_timer < t then
		self.damage_timer = t + 0.5

		if not self.inside_inn then
			DamageUtils.add_damage_network(unit, unit, 10, "torso", "overcharge", Vector3(0, 0, 1), "overcharge")
		end

		local player_locomotion = ScriptUnit.extension(unit, "locomotion_system")
		local push_direction = Vector3.normalize(Vector3((math.random() - 0.5)*2, (math.random() - 0.5)*2, 0))

		player_locomotion.add_external_velocity(player_locomotion, push_direction, 10)

		self.movement_speed = math.random()*0.5 + 0.15
		self.movement_speed_limit = self.movement_speed

		first_person_extension.animation_event(first_person_extension, "overheat_indicator")
	end

	local is_moving = CharacterStateHelper.is_moving(input_extension)
	local inventory_extension = self.inventory_extension
	local player = Managers.player:owner(unit)

	if is_moving then
		self.movement_speed = math.min(1, self.movement_speed + movement_settings_table.move_acceleration_up*dt)
	elseif player and player.bot_player then
		self.movement_speed = 0
	else
		self.movement_speed = math.max(self.movement_speed_limit, self.movement_speed - movement_settings_table.move_acceleration_down*dt)
	end

	local walking = input_extension.get(input_extension, "walk")
	local move_speed = (status_extension.is_crouching(status_extension) and movement_settings_table.crouch_move_speed) or (walking and movement_settings_table.walk_move_speed) or movement_settings_table.move_speed
	local move_speed_multiplier = status_extension.current_move_speed_multiplier(status_extension)

	if walking ~= self.walking then
		status_extension.set_slowed(status_extension, walking)
	end

	move_speed = move_speed*move_speed_multiplier
	move_speed = move_speed*movement_settings_table.player_speed_scale
	move_speed = move_speed*self.movement_speed
	local movement = Vector3(0, 0.9, 0)
	local move_input = input_extension.get(input_extension, "move")

	if move_input then
		movement = movement + move_input
	end

	local move_input_controller = input_extension.get(input_extension, "move_controller")

	if move_input_controller then
		local controller_length = Vector3.length(move_input_controller)

		if 0 < controller_length then
			move_speed = move_speed*controller_length
		end

		movement = movement + move_input_controller
	end

	local move_input_direction = nil
	move_input_direction = Vector3.normalize(movement)

	if Vector3.length(move_input_direction) == 0 then
		move_input_direction = self.last_input_direction:unbox()
	else
		self.last_input_direction:store(move_input_direction)
	end

	CharacterStateHelper.move_on_ground(first_person_extension, input_extension, self.locomotion_extension, move_input_direction, move_speed, unit)
	CharacterStateHelper.look(input_extension, self.player.viewport_name, first_person_extension, status_extension)

	local move_anim_3p, move_anim_1p = CharacterStateHelper.get_move_animation(self.locomotion_extension, input_extension, status_extension)

	if move_anim_3p ~= self.move_anim_3p or move_anim_1p ~= self.move_anim_1p then
		CharacterStateHelper.play_animation_event(unit, move_anim_3p)

		self.move_anim_3p = move_anim_3p
	end

	self.walking = walking

	return 
end

return 
