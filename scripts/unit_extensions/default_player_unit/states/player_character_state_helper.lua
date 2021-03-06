CharacterStateHelper = CharacterStateHelper or {}
local CharacterStateHelper = CharacterStateHelper

CharacterStateHelper.get_movement_input = function (input_extension)
	local move_input = input_extension:get("move") or Vector3(0, 0, 0)
	local move_input_controller = input_extension:get("move_controller") or Vector3(0, 0, 0)
	local movement = nil

	if Vector3.length(move_input_controller) < Vector3.length(move_input) then
		movement = Vector3.normalize(move_input)
	else
		movement = move_input_controller
	end

	return movement
end

CharacterStateHelper.get_square_movement_input = function (input_extension)
	local move_input = input_extension:get("move") or Vector3(0, 0, 0)
	local move_input_controller = input_extension:get("move_controller") or Vector3(0, 0, 0)
	local movement = nil

	if Vector3.length(move_input_controller) < Vector3.length(move_input) then
		movement = move_input
	else
		movement = math.circular_to_square_coordinates(move_input_controller)
	end

	return movement
end

CharacterStateHelper.get_look_input = function (input_extension, status_extension, inventory_extension, is_3p)
	local hacky_unit = status_extension.unit
	local targeting_data = nil

	if ScriptUnit.has_extension(hacky_unit, "smart_targeting_system") then
		local targeting_extension = ScriptUnit.extension(hacky_unit, "smart_targeting_system")
		targeting_data = targeting_extension:get_targeting_data()
	end

	local look_input = input_extension:get("look")
	local look_input_gamepad = nil
	local is_zooming = status_extension:is_zooming()
	local gamepad_enabled = not Development.parameter("disable_gamepad")
	local wielded_slot_name = inventory_extension:get_wielded_slot_name()
	local weapon_template = inventory_extension:get_wielded_slot_item_template()

	if gamepad_enabled then
		if is_zooming then
			look_input_gamepad = input_extension:get("look_controller_zoom")
		elseif is_3p then
			look_input_gamepad = input_extension:get("look_controller_3p")
		elseif wielded_slot_name == "slot_ranged" then
			look_input_gamepad = input_extension:get("look_controller_ranged")
		elseif wielded_slot_name == "slot_melee" and targeting_data and targeting_data.targets_within_range then
			look_input_gamepad = input_extension:get("look_controller_melee")
		else
			look_input_gamepad = input_extension:get("look_controller")
		end
	end

	local look_delta = Vector3(0, 0, 0)

	if look_input then
		look_delta = look_delta + look_input
	end

	if look_input_gamepad then
		look_delta = look_delta + look_input_gamepad
	end

	return look_delta
end

CharacterStateHelper.update_dodge_lock = function (unit, input_extension, status_extension)
	if status_extension:dodge_locked() and not input_extension:get("dodge_hold") then
		status_extension:set_dodge_locked(false)
	end
end

local DOUBLE_TAP_DODGES = {
	move_left_pressed = Vector3Box(-Vector3.right()),
	move_right_pressed = Vector3Box(Vector3.right()),
	move_back_pressed = Vector3Box(-Vector3.forward())
}

CharacterStateHelper.check_to_start_dodge = function (unit, input_extension, status_extension, t)
	if status_extension:dodge_locked() or not status_extension:can_dodge(t) then
		return false
	end

	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local input = CharacterStateHelper.get_movement_input(input_extension)
	local dodge_on_jump_key = input_extension.dodge_on_jump_key
	local dodge_on_forward_diagonal = input_extension.dodge_on_forward_diagonal
	local double_tap_dodge = input_extension.double_tap_dodge
	local start_dodge = false
	local dodge_direction = Vector3(0, 0, 0)
	local dodge_hold = input_extension:get("dodge_hold")
	local dodge_input = input_extension:get("dodge") or (dodge_on_jump_key and dodge_hold)
	local input_length = Vector3.length(input)
	local using_keyboard = not Managers.input:is_device_active("gamepad")
	local stationary_dodge = Application.user_setting("toggle_stationary_dodge")

	if double_tap_dodge then
		for input, dir in pairs(DOUBLE_TAP_DODGES) do
			if input_extension:get(input) then
				local was_double_tap = input_extension:was_double_tap(input, t, Application.user_setting("double_tap_dodge_threshold"))

				for input, dir in pairs(DOUBLE_TAP_DODGES) do
					input_extension:clear_double_tap(input)
				end

				if was_double_tap then
					start_dodge = true
					dodge_direction = dir:unbox()

					break
				end

				input_extension:start_double_tap(input, t)

				break
			end
		end
	end

	if not start_dodge and dodge_input and input_extension.minimum_dodge_input < input_length then
		local normalized_input = input / input_length
		local x = normalized_input.x
		local y = normalized_input.y
		local abs_x = math.abs(x)
		local forward_ok = y <= 0 or (not using_keyboard and abs_x > 0.9239) or (dodge_on_forward_diagonal and abs_x > 0.707)

		if forward_ok then
			start_dodge = true

			if y > 0 then
				dodge_direction = Vector3(math.sign(x), 0, 0)
			else
				dodge_direction = normalized_input
			end
		end
	elseif dodge_input and stationary_dodge then
		start_dodge = true
		dodge_direction = -Vector3.forward()
	end

	if start_dodge then
		Managers.state.entity:system("play_go_tutorial_system"):register_dodge(dodge_direction)
		status_extension:add_fatigue_points("action_dodge")
		status_extension:set_dodge_locked(true)
		status_extension:add_dodge_cooldown()

		slot16 = ScriptUnit.extension(unit, "first_person_system")
	end

	return start_dodge, dodge_direction
end

CharacterStateHelper.move_on_ground = function (first_person_extension, input_extension, locomotion_extension, local_move_direction, speed, unit)
	local unit_rotation = first_person_extension:current_rotation()
	local flat_unit_rotation = Quaternion.look(Vector3.flat(Quaternion.forward(unit_rotation)), Vector3.up())
	local move_direction = Quaternion.rotate(flat_unit_rotation, local_move_direction)

	if local_move_direction.y < 0 then
		local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
		speed = speed * movement_settings_table.backward_move_scale
	end

	locomotion_extension:set_wanted_velocity(move_direction * speed)
end

CharacterStateHelper.update_soft_collision_movement = function (first_person_extension, status_extension, locomotion_extension, unit, world, current_animation)
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local final_velocity = Vector3(0, 0, 0)
	local own_position = POSITION_LOOKUP[unit]
	local rotation = Unit.local_rotation(unit, 0)

	for index, player_unit in pairs(PLAYER_UNITS) do
		if player_unit ~= unit and StatusUtils.use_soft_collision(player_unit) then
			local distance = own_position - POSITION_LOOKUP[player_unit]
			local height_diference = math.abs(Vector3.z(distance))

			Vector3.set_z(distance, 0)

			local length = Vector3.length(distance)

			if height_diference <= movement_settings_table.soft_collision.max_height_diference and length <= movement_settings_table.soft_collision.max_distance then
				local direction = Vector3.normalize(distance)
				local speed = 1 / (length + movement_settings_table.soft_collision.speed_modifier)
				speed = speed * speed
				final_velocity = final_velocity + direction * speed
			end
		end
	end

	local final_direction_length = Vector3.length(final_velocity)
	local final_direction = Vector3.normalize(final_velocity)
	local idle_speed_threshold = movement_settings_table.soft_collision.idle_speed_threshold

	if final_direction_length <= idle_speed_threshold then
		locomotion_extension:set_wanted_velocity(Vector3(0, 0, 0))
	else
		final_direction_length = math.clamp(final_direction_length, movement_settings_table.soft_collision.lowest_speed, movement_settings_table.soft_collision.highest_speed)

		locomotion_extension:set_wanted_velocity(final_direction * final_direction_length)
	end

	if final_direction_length <= idle_speed_threshold then
		if current_animation ~= "idle" then
			CharacterStateHelper.play_animation_event(unit, "idle")
			CharacterStateHelper.play_animation_event_first_person(first_person_extension, "idle")

			current_animation = "idle"
		end
	elseif Vector3.dot(final_direction, Quaternion.forward(rotation)) >= 0 then
		if current_animation ~= "move_fwd" then
			CharacterStateHelper.play_animation_event(unit, "move_fwd")
			CharacterStateHelper.play_animation_event_first_person(first_person_extension, "move_fwd")

			current_animation = "move_fwd"
		end
	elseif current_animation ~= "move_bwd" then
		CharacterStateHelper.play_animation_event(unit, "move_bwd")
		CharacterStateHelper.play_animation_event_first_person(first_person_extension, "move_bwd")

		current_animation = "move_bwd"
	end

	return current_animation
end

CharacterStateHelper.do_common_state_transitions = function (status_extension, csm)
	if CharacterStateHelper.is_dead(status_extension) then
		csm:change_state("dead")

		return true
	end

	if CharacterStateHelper.is_knocked_down(status_extension) then
		csm:change_state("knocked_down")

		return true
	end

	if CharacterStateHelper.is_pounced_down(status_extension) then
		csm:change_state("pounced_down")

		return true
	end

	local is_catapulted, direction = CharacterStateHelper.is_catapulted(status_extension)

	if is_catapulted then
		local params = {
			sound_event = "Play_hit_by_ratogre",
			direction = direction
		}

		csm:change_state("catapulted", params)

		return true
	end

	if CharacterStateHelper.is_grabbed_by_pack_master(status_extension) then
		csm:change_state("grabbed_by_pack_master")

		return true
	end

	return false
end

CharacterStateHelper.is_colliding_with_gameplay_collision_box = function (world, unit, collision_filter)
	local physics_world = World.get_data(world, "physics_world")
	local position = POSITION_LOOKUP[unit]
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local player_half_height = movement_settings_table.gameplay_collision_box.collision_check_player_half_height
	local player_height_offset = movement_settings_table.gameplay_collision_box.collision_check_player_height_offset
	local offset = Vector3(0, 0, player_height_offset)
	position = position + offset
	local rotation = Unit.local_rotation(unit, 0)
	local radius = movement_settings_table.gameplay_collision_box.collision_check_player_radius
	local size = Vector3(radius, player_half_height, radius)
	local actors, actor_count = PhysicsWorld.immediate_overlap(physics_world, "shape", "capsule", "position", position, "rotation", rotation, "size", size, "collision_filter", collision_filter, "use_global_table")
	local collided_actor = actors and actors[1]
	local colliding, collided_unit = nil

	if collided_actor then
		colliding = true
		collided_unit = Actor.unit(collided_actor)
	end

	return colliding, collided_unit
end

CharacterStateHelper.move_in_air = function (first_person_extension, input_extension, locomotion_extension, speed, unit, wait_timer_force_backwards_movement, wait_timer_force_forward_movement)
	local movement = CharacterStateHelper.get_movement_input(input_extension)
	local force_y_movement = 0

	if wait_timer_force_backwards_movement and wait_timer_force_backwards_movement > 0 then
		force_y_movement = force_y_movement - 1
	end

	if wait_timer_force_forward_movement and wait_timer_force_forward_movement > 0 then
		force_y_movement = force_y_movement + 1
	end

	if force_y_movement ~= 0 then
		Vector3.set_y(movement, force_y_movement)
	end

	local move_direction = Vector3.normalize(movement)
	local unit_rotation = first_person_extension:current_rotation()
	local move_velocity = Quaternion.rotate(unit_rotation, move_direction)
	move_velocity.z = 0
	move_velocity = move_velocity * 0.1
	move_velocity = Vector3.normalize(move_velocity)
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local move_cap = math.clamp(movement_settings_table.move_speed, 0, PlayerUnitMovementSettings.move_speed)

	if movement.y < 0 then
		speed = speed * movement_settings_table.backward_move_scale
		move_cap = move_cap * movement_settings_table.backward_move_scale * 0.9
	end

	local prev_move_velocity = locomotion_extension:current_velocity()
	prev_move_velocity.z = 0
	local new_move_velocity = prev_move_velocity + move_velocity * speed
	local new_move_speed = Vector3.length(new_move_velocity)
	new_move_speed = math.clamp(new_move_speed, 0, move_cap * movement_settings_table.player_speed_scale)
	new_move_velocity = Vector3.normalize(new_move_velocity)

	locomotion_extension:set_wanted_velocity(new_move_velocity * new_move_speed)
end

CharacterStateHelper.looking_up = function (first_person_extension, threshold)
	local first_person_unit = first_person_extension:get_first_person_unit()
	local rotation = Unit.world_rotation(first_person_unit, 0)
	local direction = Quaternion.forward(rotation)
	local normalised_direction = Vector3.normalize(direction)
	local dot = Vector3.dot(normalised_direction, Vector3.up())

	return (threshold < dot and true) or false
end

CharacterStateHelper.looking_down = function (first_person_extension, threshold)
	local first_person_unit = first_person_extension:get_first_person_unit()
	local rotation = Unit.world_rotation(first_person_unit, 0)
	local direction = Quaternion.forward(rotation)
	local normalised_direction = Vector3.normalize(direction)
	local dot = Vector3.dot(normalised_direction, Vector3.up())

	return (dot < threshold and true) or false
end

CharacterStateHelper.force_velocity = function (unit, locomotion_extension, velocity)
	locomotion_extension:set_forced_velocity(move_velocity * velocity)
end

CharacterStateHelper.look = function (input_extension, viewport_name, first_person_extension, status_extension, inventory_extension)
	Profiler.start("look")

	local camera_manager = Managers.state.camera
	local look_sensitivity = (camera_manager:has_viewport(viewport_name) and camera_manager:fov(viewport_name) / 0.785) or 1
	local is_3p = false
	local look_delta = CharacterStateHelper.get_look_input(input_extension, status_extension, inventory_extension, is_3p)
	look_delta = look_delta * look_sensitivity

	first_person_extension:set_look_delta(look_delta)
	Profiler.stop("look")
end

CharacterStateHelper.look_limited_rotation_freedom = function (input_extension, viewport_name, first_person_extension, ledge_unit, unit, max_radians_yaw, max_radians_pitch, status_extension, inventory_extension)
	local camera_manager = Managers.state.camera
	local look_sensitivity = (camera_manager:has_viewport(viewport_name) and Managers.state.camera:fov(viewport_name) / 0.785) or 1
	local is_3p = false
	local look_delta = CharacterStateHelper.get_look_input(input_extension, status_extension, inventory_extension, is_3p)
	look_delta = look_delta * look_sensitivity
	local new_look_delta = look_delta

	if max_radians_yaw then
		local ladder_yaw = Quaternion.yaw(Unit.local_rotation(ledge_unit, 0))
		local own_yaw = Quaternion.yaw(Unit.local_rotation(first_person_extension.first_person_unit, 0))
		local dif_yaw = ladder_yaw - own_yaw
		local look_delta_x = Vector3.x(new_look_delta)

		if look_delta_x > 0 and max_radians_yaw < dif_yaw then
			look_delta_x = 0
		end

		if look_delta_x < 0 and dif_yaw < -max_radians_yaw then
			look_delta_x = 0
		end

		Vector3.set_x(new_look_delta, look_delta_x)
	end

	if max_radians_pitch then
		local ladder_pitch = Quaternion.pitch(Unit.local_rotation(ledge_unit, 0))
		local own_pitch = Quaternion.pitch(Unit.local_rotation(first_person_extension.first_person_unit, 0))
		local dif_pitch = ladder_pitch - own_pitch
		local look_delta_y = Vector3.y(new_look_delta)
		local half_pi = math.pi / 2

		if look_delta_y < 0 and max_radians_pitch < dif_pitch then
			look_delta_y = 0
		end

		if look_delta_y > 0 and dif_pitch < -max_radians_pitch then
			look_delta_y = 0
		end

		Vector3.set_y(new_look_delta, look_delta_y)
	end

	first_person_extension:set_look_delta(new_look_delta)
end

CharacterStateHelper.lerp_player_rotation_radian = function (player_radian, target_radian, original_diference_radian, percentage_in_lerp)
	local final_radian_value = nil

	if (target_radian >= 0 and player_radian >= 0) or (target_radian <= 0 and player_radian <= 0) then
		final_radian_value = player_radian + (target_radian - player_radian) * percentage_in_lerp
	else
		local current_rotation = original_diference_radian * percentage_in_lerp

		if target_radian < 0 then
			local dif_radian = math.abs(target_radian) + player_radian

			if math.pi < dif_radian then
				final_radian_value = player_radian + current_rotation

				if math.pi <= final_radian_value then
					local below_pi = math.pi - math.abs(final_radian_value)
					final_radian_value = math.pi - below_pi
				end
			else
				final_radian_value = player_radian - current_rotation
			end
		else
			local dif_radian = target_radian + math.abs(player_radian)

			if math.pi < dif_radian then
				final_radian_value = player_radian - current_rotation

				if final_radian_value <= -math.pi then
					local above_pi = final_radian_value - math.pi
					final_radian_value = -math.pi + above_pi
				end
			else
				final_radian_value = player_radian + current_rotation
			end
		end
	end

	return final_radian_value
end

CharacterStateHelper.lerp_player_pitch_rotation = function (player_start_pitch, first_person_extension, percentage_in_lerp, unit)
	local player_rotation = Unit.local_rotation(unit, 0)
	local new_pitch = math.lerp(player_start_pitch, 0, percentage_in_lerp)
	local player_yaw = Quaternion.yaw(player_rotation)
	local player_roll = Quaternion.roll(player_rotation)
	local player_yaw_rotation = Quaternion(Vector3.up(), player_yaw)
	local player_pitch_rotation = Quaternion(Vector3.right(), new_pitch)
	local player_roll_rotation = Quaternion(Vector3.forward(), player_roll)
	local yaw_pitch_rotation = Quaternion.multiply(player_yaw_rotation, player_pitch_rotation)
	local final_roation = Quaternion.multiply(yaw_pitch_rotation, player_roll_rotation)

	first_person_extension:set_rotation(final_roation)
	Unit.set_local_rotation(unit, 0, final_roation)
end

CharacterStateHelper.lerp_player_yaw_rotation = function (player_yaw, target_yaw, original_diference_yaw, first_person_extension, percentage_in_lerp, unit)
	local first_person_unit = first_person_extension:get_first_person_unit()
	local player_rotation = Unit.local_rotation(first_person_unit, 0)
	local final_yaw = CharacterStateHelper.lerp_player_rotation_radian(player_yaw, target_yaw, original_diference_yaw, percentage_in_lerp)
	local player_pitch = Quaternion.pitch(player_rotation)
	local player_roll = Quaternion.roll(player_rotation)
	local player_yaw_rotation = Quaternion(Vector3.up(), final_yaw)
	local player_pitch_rotation = Quaternion(Vector3.right(), player_pitch)
	local player_roll_rotation = Quaternion(Vector3.forward(), player_roll)
	local yaw_pitch_rotation = Quaternion.multiply(player_yaw_rotation, player_pitch_rotation)
	local final_roation = Quaternion.multiply(yaw_pitch_rotation, player_roll_rotation)

	first_person_extension:set_rotation(final_roation)
	Unit.set_local_rotation(unit, 0, final_roation)
end

CharacterStateHelper.time_in_ladder_move_animation = function (unit, ladder_base_height)
	local unit_pos = Unit.world_position(unit, 0)
	local unit_position_height = Vector3.z(unit_pos)
	local above_ladder_position = unit_position_height - ladder_base_height
	local movement_settings_table = PlayerUnitMovementSettings.get_movement_settings_table(unit)
	local percentage_in_move_animation = above_ladder_position % movement_settings_table.ladder.whole_movement_animation_distance / movement_settings_table.ladder.whole_movement_animation_distance
	local time_in_move_animation = percentage_in_move_animation * movement_settings_table.ladder.movement_animation_length

	return time_in_move_animation
end

CharacterStateHelper.show_inventory_3p = function (unit, show_inventory_3p, include_local_player, is_server, inventory_extension)
	local network_manager = Managers.state.network
	local unit_id = network_manager:unit_game_object_id(unit)

	if not network_manager.game_session then
		return
	end

	if include_local_player then
		local inventory_extension = ScriptUnit.extension(unit, "inventory_system")

		inventory_extension:show_third_person_inventory(show_inventory_3p)
	end

	if is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_show_inventory", unit_id, show_inventory_3p)
	else
		network_manager.network_transmit:send_rpc_server("rpc_show_inventory", unit_id, show_inventory_3p)
	end
end

CharacterStateHelper.set_is_on_ladder = function (ladder_unit, unit, on_ladder, is_server, status_extension)
	local network_manager = Managers.state.network
	local unit_id = network_manager:unit_game_object_id(unit)
	local ladder_level_index, is_level_unit = network_manager:game_object_or_level_id(ladder_unit)

	assert(is_level_unit, "Ladder unit wasn't a level unit")

	if is_server or LEVEL_EDITOR_TEST then
		local status_system = Managers.state.entity:system("status_system")

		status_system:rpc_status_change_bool(nil, NetworkLookup.statuses.ladder_climbing, on_ladder, unit_id, ladder_level_index)
	else
		status_extension:set_is_on_ladder(on_ladder, ladder_unit)
		network_manager.network_transmit:send_rpc_server("rpc_status_change_bool", NetworkLookup.statuses.ladder_climbing, on_ladder, unit_id, ladder_level_index)
	end
end

CharacterStateHelper.set_is_on_ledge = function (ledge_unit, unit, on_ledge, is_server, status_extension)
	local network_manager = Managers.state.network
	local unit_id = network_manager:unit_game_object_id(unit)
	local ledge_level_index, is_level_unit = network_manager:game_object_or_level_id(ledge_unit)

	status_extension:set_crouching(false)

	if Managers.state.network:game() and not LEVEL_EDITOR_TEST then
		status_extension:set_is_ledge_hanging(on_ledge, ledge_unit)
		network_manager.network_transmit:send_rpc_server("rpc_status_change_bool", NetworkLookup.statuses.ledge_hanging, on_ledge, unit_id, ledge_level_index)
	end
end

CharacterStateHelper.get_buffered_input = function (input_id, input_extension, no_buffer, doubleclick_window, softbutton_threshold)
	local input = nil

	if input_id then
		input = input_extension:get(input_id)

		if input and softbutton_threshold and input < softbutton_threshold then
			return false
		end

		if not no_buffer then
			if input then
				input_extension:add_buffer(input_id, doubleclick_window)
			else
				input = input_extension:get_buffer(input_id)
			end
		end
	end

	return input
end

CharacterStateHelper.wield_input = function (input_extension, inventory_extension, action_name, verify)
	if action_name ~= "action_wield" then
		return nil
	end

	local slots_by_name = InventorySettings.slots_by_name
	local wieldable_slots = InventorySettings.slots_by_wield_input
	local equipment = inventory_extension:equipment()
	local wielded_slot_name = equipment.wielded_slot
	local current_slot = slots_by_name[wielded_slot_name]
	local current_slot_wield_input = current_slot.wield_input
	local slot_to_wield = nil

	for index, slot in ipairs(wieldable_slots) do
		if slot ~= current_slot then
			local wield_input = slot.wield_input
			local name = slot.name

			if equipment.slots[name] and CharacterStateHelper.get_buffered_input(wield_input, input_extension) then
				slot_to_wield = name

				break
			end
		end
	end

	if not slot_to_wield and CharacterStateHelper.get_buffered_input("wield_switch", input_extension) then
		if current_slot.name ~= "slot_melee" then
			slot_to_wield = "slot_melee"
		else
			slot_to_wield = "slot_ranged"
		end
	end

	local scroll_value = 0

	if input_extension:get("wield_prev") then
		scroll_value = -1
	elseif input_extension:get("wield_next") then
		scroll_value = 1
	end

	local changing_debug_speed = DebugKeyHandler.key_pressed("left shift") or DebugKeyHandler.key_pressed("left alt")
	local scroll_type = Application.user_setting("weapon_scroll_type") or "scroll_wrap"

	if scroll_type ~= "scroll_disabled" and not slot_to_wield and scroll_value ~= 0 and not changing_debug_speed then
		local current_index = current_slot.wield_index or 1
		local num_slots = #wieldable_slots
		local slot_to_wield_index = current_index + scroll_value
		local scroll_dir = math.sign(scroll_value)

		while not wieldable_slots[slot_to_wield_index] or not equipment.slots[wieldable_slots[slot_to_wield_index].name] do
			if num_slots < slot_to_wield_index then
				if scroll_type == "scroll_clamp" then
					slot_to_wield_index = num_slots
					scroll_dir = -1
				else
					slot_to_wield_index = 1
				end
			elseif slot_to_wield_index < 1 then
				if scroll_type == "scroll_clamp" then
					slot_to_wield_index = 1
					scroll_dir = 1
				else
					slot_to_wield_index = num_slots
				end
			else
				slot_to_wield_index = slot_to_wield_index + scroll_dir
			end
		end

		if current_slot.wield_index ~= slot_to_wield_index then
			slot_to_wield = wieldable_slots[slot_to_wield_index].name
		end
	end

	if slot_to_wield and (not equipment.slots[slot_to_wield] or slot_to_wield == current_slot.wield_index) then
		slot_to_wield = nil
	end

	return slot_to_wield
end

local empty_table = {}

CharacterStateHelper._get_item_data_and_weapon_extensions = function (inventory_extension)
	local equipment = inventory_extension:equipment()
	local item_data = equipment.wielded

	if item_data == nil then
		return
	end

	local right_hand_wielded_unit = equipment.right_hand_wielded_unit
	local left_hand_wielded_unit = equipment.left_hand_wielded_unit
	local right_hand_weapon_extension, left_hand_weapon_extension = nil

	if Unit.alive(right_hand_wielded_unit) then
		right_hand_weapon_extension = ScriptUnit.extension(right_hand_wielded_unit, "weapon_system")
	end

	if Unit.alive(left_hand_wielded_unit) then
		left_hand_weapon_extension = ScriptUnit.extension(left_hand_wielded_unit, "weapon_system")
	end

	if not right_hand_weapon_extension and not left_hand_weapon_extension then
		return
	end

	return item_data, right_hand_weapon_extension, left_hand_weapon_extension
end

CharacterStateHelper._get_current_action_data = function (left_hand_weapon_extension, right_hand_weapon_extension)
	local current_action_settings, current_action_extension, current_action_hand = nil

	if left_hand_weapon_extension then
		local left_current_action_settings = left_hand_weapon_extension.current_action_settings

		if left_current_action_settings then
			current_action_settings = left_current_action_settings
			current_action_extension = left_hand_weapon_extension
			current_action_hand = "left"
		end
	end

	if right_hand_weapon_extension then
		local right_current_action_settings = right_hand_weapon_extension.current_action_settings

		if right_current_action_settings then
			current_action_settings = right_current_action_settings
			current_action_extension = right_hand_weapon_extension
			current_action_hand = "right"
		end
	end

	return current_action_settings, current_action_extension, current_action_hand
end

CharacterStateHelper._get_current_action_data_chain_action_end = function (left_hand_weapon_extension, right_hand_weapon_extension, current_weapon_extension)
	local current_action_settings, current_action_extension, current_action_hand = nil

	if left_hand_weapon_extension then
		local left_current_action_settings = nil

		if left_hand_weapon_extension == current_weapon_extension then
			left_current_action_settings = left_hand_weapon_extension.temporary_action_settings
		else
			left_current_action_settings = left_hand_weapon_extension.current_action_settings
		end

		if left_current_action_settings then
			current_action_settings = left_current_action_settings
			current_action_extension = left_hand_weapon_extension
			current_action_hand = "left"
		end
	end

	if right_hand_weapon_extension then
		local right_current_action_settings = nil

		if right_hand_weapon_extension == current_weapon_extension then
			right_current_action_settings = right_hand_weapon_extension.temporary_action_settings
		else
			right_current_action_settings = right_hand_weapon_extension.current_action_settings
		end

		if right_current_action_settings then
			current_action_settings = right_current_action_settings
			current_action_extension = right_hand_weapon_extension
			current_action_hand = "right"
		end
	end

	return current_action_settings, current_action_extension, current_action_hand
end

CharacterStateHelper._get_streak_action_data = function (item_template, current_action_extension, current_action_settings, input_extension, inventory_extension, unit, t)
	local streak_actions = current_action_settings.allowed_streak_chain_actions or empty_table
	local new_action, new_sub_action, wield_input = nil

	for i = 1, #streak_actions, 1 do
		local action_data = streak_actions[i]
		local input_id = action_data.input
		local input = input_extension:get(input_id)

		if not input then
			wield_input = CharacterStateHelper.wield_input(input_extension, inventory_extension, action_data.action)
			input = wield_input
		end

		local streak_action_available = current_action_extension:is_streak_action_available(action_data, t)

		if input and streak_action_available then
			new_action = action_data.action
			new_sub_action = action_data.sub_action

			break
		end
	end

	if new_action then
		local action_settings = item_template.actions[new_action][new_sub_action]
		local condition_func = action_settings.chain_condition_func

		if condition_func and not condition_func(unit, input_extension) then
			new_action, new_sub_action = nil
		end
	end

	return new_action, new_sub_action, wield_input
end

CharacterStateHelper._get_chain_action_data = function (item_template, current_action_extension, current_action_settings, input_extension, inventory_extension, unit, t, is_bot_player)
	local chain_actions = current_action_settings.allowed_chain_actions or empty_table
	local new_action, new_sub_action, wield_input, send_buffer, clear_buffer = nil

	for i = 1, #chain_actions, 1 do
		local action_data = chain_actions[i]
		local release_required = action_data.release_required
		local input_extra_requirement = true

		if release_required then
			input_extra_requirement = input_extension:released_input(release_required)
		end

		local hold_required = action_data.hold_required

		if hold_required then
			for index, hold_require in pairs(hold_required) do
				if input_extension:released_input(hold_require) then
					input_extra_requirement = false

					break
				end
			end
		end

		local input_id = action_data.input
		local softbutton_threshold = action_data.softbutton_threshold
		local input = nil
		local no_buffer = action_data.no_buffer
		local doubleclick_window = action_data.doubleclick_window
		local blocking_input = action_data.blocking_input
		local blocked = false

		if blocking_input then
			blocked = input_extension:get(blocking_input)
		end

		if input_extra_requirement and not blocked then
			input = CharacterStateHelper.get_buffered_input(input_id, input_extension, no_buffer, doubleclick_window, softbutton_threshold)
		end

		if not input then
			wield_input = CharacterStateHelper.wield_input(input_extension, inventory_extension, action_data.action)
			input = wield_input
		end

		local select_chance = action_data.select_chance or 1
		local is_selected = math.random() <= select_chance
		local chain_action_available = current_action_extension:is_chain_action_available(action_data, t)

		if (input or action_data.auto_chain) and chain_action_available and is_selected then
			local sub_action = action_data.sub_action

			if not sub_action and action_data.first_possible_sub_action then
				local sub_actions = item_template.actions[action_data.action]

				for sub_action_name, data in pairs(sub_actions) do
					local condition_func = data.chain_condition_func

					if not condition_func or condition_func(unit) then
						sub_action = sub_action_name

						break
					end
				end
			end

			if sub_action then
				new_action = action_data.action
				new_sub_action = sub_action
				send_buffer = action_data.send_buffer
				clear_buffer = action_data.clear_buffer
			end

			break
		end
	end

	if new_action then
		local action_settings = item_template.actions[new_action] and item_template.actions[new_action][new_sub_action]
		local condition_func = action_settings and action_settings.chain_condition_func

		if not action_settings or (condition_func and not condition_func(unit, input_extension)) then
			new_action, new_sub_action = nil
		end

		if clear_buffer or new_sub_action == "push" then
			input_extension:clear_input_buffer()
		elseif action_settings and not wield_input and not action_settings.keep_buffer then
			input_extension:reset_input_buffer()
		end
	end

	return new_action, new_sub_action, wield_input
end

local function validate_action(unit, action_name, sub_action_name, action_settings, input_extension, inventory_extension, only_check_condition, ammo_extension)
	local skip_hold = action_settings.do_not_validate_with_hold
	local hold_input = not skip_hold and action_settings.hold_input
	local wield_input = CharacterStateHelper.wield_input(input_extension, inventory_extension, action_name)
	local buffered_input = input_extension:get_buffer(action_name)
	local action_input = input_extension:get(action_name)
	local action_hold_input = hold_input and input_extension:get(hold_input)
	local allow_toggle = action_settings.allow_hold_toggle and input_extension.toggle_alternate_attack
	local hold_or_toggle_input = (allow_toggle and action_input) or (not allow_toggle and (action_input or action_hold_input))

	if only_check_condition or wield_input or buffered_input or hold_or_toggle_input then
		local condition_func = action_settings.condition_func
		local condition_passed = nil

		if condition_func then
			condition_passed = condition_func(unit, input_extension, ammo_extension)
		else
			condition_passed = true
		end

		if condition_passed then
			if not wield_input and not action_settings.keep_buffer then
				input_extension:reset_input_buffer()
			end

			return action_name, sub_action_name
		end
	end
end

local weapon_action_interrupt_damage_types = {
	cutting = true
}
local interupting_action_data = {}

CharacterStateHelper.update_weapon_actions = function (t, unit, input_extension, inventory_extension, damage_extension)
	Profiler.start("weapon_action")

	local item_data, right_hand_weapon_extension, left_hand_weapon_extension = CharacterStateHelper._get_item_data_and_weapon_extensions(inventory_extension)

	table.clear(interupting_action_data)

	if not item_data then
		Profiler.stop("weapon_action")

		return
	end

	local new_action, new_sub_action, current_action_settings, current_action_extension, current_action_hand = nil
	local buff_extension = ScriptUnit.extension(unit, "buff_system")
	current_action_settings, current_action_extension, current_action_hand = CharacterStateHelper._get_current_action_data(left_hand_weapon_extension, right_hand_weapon_extension)
	local item_template = BackendUtils.get_item_template(item_data)
	local recent_damage_type = damage_extension:recently_damaged()
	local status_extension = ScriptUnit.extension(unit, "status_system")
	local can_interrupt, reloading = nil
	local player = Managers.player:owner(unit)
	local is_bot_player = player and player.bot_player

	if recent_damage_type and weapon_action_interrupt_damage_types[recent_damage_type] then
		local ammo_extension = (left_hand_weapon_extension and left_hand_weapon_extension.ammo_extension) or (right_hand_weapon_extension and right_hand_weapon_extension.ammo_extension)

		if ammo_extension then
			if left_hand_weapon_extension and left_hand_weapon_extension.ammo_extension then
				reloading = left_hand_weapon_extension.ammo_extension:is_reloading()
			end

			if right_hand_weapon_extension and right_hand_weapon_extension.ammo_extension then
				reloading = right_hand_weapon_extension.ammo_extension:is_reloading()
			end
		end

		if (buff_extension and buff_extension:has_buff_type("damage_reduction_from_proc")) or (current_action_settings and current_action_settings.uninterruptible) or script_data.uninterruptible or reloading or is_bot_player then
			can_interrupt = false
		else
			can_interrupt = status_extension:hitreact_interrupt()
		end

		if can_interrupt and not status_extension:is_disabled() then
			if current_action_settings then
				current_action_extension:stop_action("interrupted")
			end

			local first_person_extension = ScriptUnit.extension(unit, "first_person_system")

			CharacterStateHelper.play_animation_event(unit, "hit_reaction")
			status_extension:set_pushed(true)
			Profiler.stop("weapon_action")

			return
		end
	end

	if current_action_settings then
		new_action, new_sub_action = CharacterStateHelper._get_streak_action_data(item_template, current_action_extension, current_action_settings, input_extension, inventory_extension, unit, t)

		if not new_action then
			new_action, new_sub_action = CharacterStateHelper._get_chain_action_data(item_template, current_action_extension, current_action_settings, input_extension, inventory_extension, unit, t, is_bot_player)
		end

		if not new_action then
			if current_action_settings.allow_hold_toggle and input_extension.toggle_alternate_attack then
				local input_id = current_action_settings.lookup_data.action_name

				if input_id and input_extension:get(input_id, true) and current_action_extension:can_stop_hold_action(t) then
					current_action_extension:stop_action("hold_input_released")
				end
			else
				local input_id = current_action_settings.hold_input

				if input_id and not input_extension:get(input_id) and current_action_extension:can_stop_hold_action(t) then
					current_action_extension:stop_action("hold_input_released")
				end
			end
		end
	elseif item_template.next_action then
		local action_data = item_template.next_action
		local action_name = action_data.action
		local only_check_condition = true
		local sub_actions = item_template.actions[action_name]

		for sub_action_name, action_settings in pairs(sub_actions) do
			if sub_action_name ~= "default" and action_settings.condition_func then
				new_action, new_sub_action = validate_action(unit, action_name, sub_action_name, action_settings, input_extension, inventory_extension, only_check_condition)

				if new_action and new_sub_action then
					break
				end
			end
		end

		if not new_action then
			local action_settings = item_template.actions[action_name].default
			new_action, new_sub_action = validate_action(unit, action_name, "default", action_settings, input_extension, inventory_extension, only_check_condition)
		end

		item_template.next_action = nil
	else
		local ammo_extension = (left_hand_weapon_extension and left_hand_weapon_extension.ammo_extension) or (right_hand_weapon_extension and right_hand_weapon_extension.ammo_extension)

		for action_name, sub_actions in pairs(item_template.actions) do
			for sub_action_name, action_settings in pairs(sub_actions) do
				if sub_action_name ~= "default" and action_settings.condition_func then
					new_action, new_sub_action = validate_action(unit, action_name, sub_action_name, action_settings, input_extension, inventory_extension, false, ammo_extension)

					if new_action and new_sub_action then
						break
					end
				end
			end

			if not new_action then
				local action_settings = item_template.actions[action_name].default
				new_action, new_sub_action = validate_action(unit, action_name, "default", action_settings, input_extension, inventory_extension, false, ammo_extension)
			end

			if new_action then
				break
			end
		end
	end

	if new_action and new_sub_action then
		local actions = item_template.actions
		local new_action_settings = actions[new_action][new_sub_action]
		local weapon_action_hand = new_action_settings.weapon_action_hand or "right"

		if weapon_action_hand == "both" then
			Profiler.stop("weapon_action")

			return
		end

		if weapon_action_hand == "either" then
			if right_hand_weapon_extension then
				weapon_action_hand = "right"
			else
				weapon_action_hand = "left"
			end
		end

		interupting_action_data.new_action = new_action
		interupting_action_data.new_sub_action = new_sub_action

		if weapon_action_hand == "left" then
			assert(left_hand_weapon_extension, "tried to start a left hand weapon action without a left hand wielded unit")

			if current_action_hand == "right" then
				right_hand_weapon_extension:stop_action("new_interupting_action", interupting_action_data)
			end

			left_hand_weapon_extension:start_action(new_action, new_sub_action, item_template.actions, t)
			Profiler.stop("weapon_action")

			return
		end

		assert(right_hand_weapon_extension, "tried to start a right hand weapon action without a right hand wielded unit")

		if current_action_hand == "left" then
			left_hand_weapon_extension:stop_action("new_interupting_action", interupting_action_data)
		end

		right_hand_weapon_extension:start_action(new_action, new_sub_action, item_template.actions, t)
	end

	Profiler.stop("weapon_action")
end

CharacterStateHelper.stop_weapon_actions = function (inventory_extension, reason)
	local equipment = inventory_extension:equipment()
	local right_hand_wielded_unit = equipment.right_hand_wielded_unit
	local left_hand_wielded_unit = equipment.left_hand_wielded_unit
	local right_weapon_extension = Unit.alive(right_hand_wielded_unit) and ScriptUnit.extension(right_hand_wielded_unit, "weapon_system")
	local left_weapon_extension = Unit.alive(left_hand_wielded_unit) and ScriptUnit.extension(left_hand_wielded_unit, "weapon_system")

	if right_weapon_extension and right_weapon_extension.current_action_settings then
		right_weapon_extension:stop_action(reason)
	end

	if left_weapon_extension and left_weapon_extension.current_action_settings then
		left_weapon_extension:stop_action(reason)
	end
end

CharacterStateHelper.reload = function (input_extension, inventory_extension, status_extension)
	if not input_extension:get("weapon_reload") then
		return false
	end

	local equipment = inventory_extension:equipment()
	local zooming = status_extension:is_zooming()

	if zooming then
		return false
	end

	local item_data, right_hand_weapon_extension, left_hand_weapon_extension = CharacterStateHelper._get_item_data_and_weapon_extensions(inventory_extension)
	local current_action_settings, current_action_extension, current_action_hand = CharacterStateHelper._get_current_action_data(left_hand_weapon_extension, right_hand_weapon_extension)

	if current_action_settings and current_action_settings.active_reload_time then
		return false
	end

	local ammo_extension = nil

	if equipment.right_hand_wielded_unit ~= nil and ScriptUnit.has_extension(equipment.right_hand_wielded_unit, "ammo_system") then
		ammo_extension = ScriptUnit.extension(equipment.right_hand_wielded_unit, "ammo_system")
	elseif equipment.left_hand_wielded_unit ~= nil and ScriptUnit.has_extension(equipment.left_hand_wielded_unit, "ammo_system") then
		ammo_extension = ScriptUnit.extension(equipment.left_hand_wielded_unit, "ammo_system")
	end

	if not ammo_extension or not ammo_extension:can_reload() then
		return false
	end

	local play_reload_animation = true

	ammo_extension:start_reload(play_reload_animation)
end

CharacterStateHelper.crouch = function (unit, input_extension, status_extension, toggle_crouch, first_person_extension, t)
	Profiler.start("crouch")

	local is_crouching = status_extension:is_crouching()
	local crouch = is_crouching
	local toggle_input = input_extension:get("crouch")
	local hold_toggle_input = input_extension:get("crouching")

	if toggle_crouch and (toggle_input or ((input_extension:get("dodge") or input_extension:get("dodge_right")) and status_extension:is_crouching())) then
		crouch = status_extension:crouch_toggle()
	elseif not toggle_crouch and not hold_toggle_input then
		crouch = false
	elseif not toggle_crouch and hold_toggle_input then
		crouch = true

		status_extension:free_crouch_toggle_lock()
	end

	local crouch_toggle_locked = status_extension:get_crouch_toggle_locked()

	if is_crouching and not crouch then
		local mover = Unit.mover(unit)
		local position = Mover.position(mover)

		if not Unit.mover_fits_at(unit, "standing", position) then
			crouch = true
		end
	end

	if crouch ~= is_crouching then
		if crouch then
			CharacterStateHelper.play_animation_event(unit, "to_crouch")
			first_person_extension:set_wanted_player_height("crouch", t)
			ScriptUnit.extension(unit, "locomotion_system"):set_active_mover("crouch")
			status_extension:set_crouching(true)
		elseif not crouch_toggle_locked then
			CharacterStateHelper.play_animation_event(unit, "to_uncrouch")
			first_person_extension:set_wanted_player_height("stand", t)
			ScriptUnit.extension(unit, "locomotion_system"):set_active_mover("standing")
			status_extension:set_crouching(false)
		end

		Profiler.stop("crouch")

		return crouch
	end

	Profiler.stop("crouch")

	return is_crouching
end

local EPSILON_MOVEMENT_SPEED_TO_IDLE_ANIM = 0.05
local SLOW_MOVEMENT_SPEED = 2.1

CharacterStateHelper.get_move_animation = function (locomotion_extension, input_extension, status_extension)
	local move_direction = CharacterStateHelper.get_movement_input(input_extension)
	local slowed = Vector3.length(Vector3.flat(locomotion_extension:current_velocity())) < SLOW_MOVEMENT_SPEED

	if Vector3.length(locomotion_extension:current_velocity()) < EPSILON_MOVEMENT_SPEED_TO_IDLE_ANIM then
		return "idle", "idle"
	end

	if move_direction.y < 0 then
		return "move_bwd", (slowed and "walk_bwd") or "move_bwd"
	end

	return "move_fwd", (slowed and "walk_fwd") or "move_fwd"
end

CharacterStateHelper.is_colliding_down = function (unit)
	local mover = Unit.mover(unit)

	return Mover.collides_down(mover)
end

CharacterStateHelper.is_colliding_sides = function (unit)
	local mover = Unit.mover(unit)

	return Mover.collides_sides(mover)
end

CharacterStateHelper.is_moving = function (input_extension)
	local movement = CharacterStateHelper.get_movement_input(input_extension)

	return Vector3.length(movement) > 0
end

CharacterStateHelper.is_moving_backwards = function (locomotion_extension, first_person_extension)
	local rotation_current = first_person_extension:current_rotation()
	local velocity_current = Vector3.flat(locomotion_extension:current_velocity())
	local dot = Vector3.dot(velocity_current, rotation_current)

	return dot < -0.1
end

CharacterStateHelper.is_knocked_down = function (status_extension)
	return status_extension:is_knocked_down()
end

CharacterStateHelper.is_pounced_down = function (status_extension)
	return status_extension:is_pounced_down()
end

CharacterStateHelper.is_catapulted = function (status_extension)
	local is_catapulted, direction = status_extension:is_catapulted()

	return is_catapulted, direction
end

CharacterStateHelper.is_grabbed_by_pack_master = function (status_extension)
	return status_extension:is_grabbed_by_pack_master()
end

CharacterStateHelper.is_overcharge_exploding = function (status_extension)
	return status_extension:is_overcharge_exploding()
end

CharacterStateHelper.pack_master_status = function (status_extension)
	return status_extension.pack_master_status
end

CharacterStateHelper.is_waiting_for_assisted_respawn = function (status_extension)
	return status_extension:is_ready_for_assisted_respawn()
end

CharacterStateHelper.is_assisted_respawning = function (status_extension)
	return status_extension:is_assisted_respawning()
end

CharacterStateHelper.is_pushed = function (status_extension)
	return status_extension:is_pushed()
end

CharacterStateHelper.is_block_broken = function (status_extension)
	return status_extension:is_block_broken()
end

CharacterStateHelper.is_dead = function (status_extension)
	return status_extension:is_dead()
end

CharacterStateHelper.is_using_transport = function (status_extension)
	return status_extension:is_using_transport()
end

CharacterStateHelper.is_zooming = function (status_extension)
	return status_extension:is_zooming()
end

CharacterStateHelper.is_crouching = function (status_extension)
	return status_extension:is_crouching()
end

CharacterStateHelper.is_starting_interaction = function (input_extension, interactor_extension)
	local can_interact, fail_reason, interaction_type = interactor_extension:can_interact()

	if CONSOLE_DISABLED_INTERACTIONS[interaction_type] then
		return false
	end

	return can_interact and interaction_type ~= "heal" and interaction_type ~= "give_item" and input_extension:get("interact", true)
end

CharacterStateHelper.is_interacting = function (interactor_extension)
	return interactor_extension:is_interacting()
end

CharacterStateHelper.is_waiting_for_interaction_approval = function (interactor_extension)
	return interactor_extension:is_waiting_for_interaction_approval()
end

CharacterStateHelper.interact = function (input_extension, interactor_extension)
	local config = interactor_extension:interaction_config()

	if config.hold then
		local key_to_hold = interactor_extension:interaction_hold_input()
		local is_holding = input_extension:get(key_to_hold)

		if not is_holding then
			interactor_extension:abort_interaction()

			return false
		end
	end

	return true
end

CharacterStateHelper.is_ledge_hanging = function (world, unit, params)
	if not script_data.ledge_hanging_turned_off then
		local colliding, ledge_unit = CharacterStateHelper.is_colliding_with_gameplay_collision_box(world, unit, "filter_ledge_collision")

		if colliding then
			local own_z = Vector3.z(Unit.world_position(unit, 0))
			local trigger_box_node = Unit.node(ledge_unit, "g_gameplay_ledge_trigger_box")
			local ledge_z = Vector3.z(Unit.world_position(ledge_unit, trigger_box_node))
			local below_z = own_z <= ledge_z

			if below_z then
				params.ledge_unit = ledge_unit

				return true
			end
		end
	end

	return false
end

CharacterStateHelper.recently_left_ladder = function (status_extension, t)
	return status_extension:has_recently_left_ladder(t)
end

CharacterStateHelper.change_camera_state = function (player, state)
	if player.bot_player then
		return
	end

	local entity_manager = Managers.state.entity
	local camera_system = entity_manager:system("camera_system")

	camera_system:external_state_change(player, state)
end

CharacterStateHelper.play_animation_event = function (unit, anim_event)
	Managers.state.network:anim_event(unit, anim_event)
end

CharacterStateHelper.play_animation_event_first_person = function (first_person_extension, anim_event)
	first_person_extension:animation_event(anim_event)
end

CharacterStateHelper.play_animation_event_with_variable_float = function (unit, anim_event, variable_name, variable_value)
	Managers.state.network:anim_event_with_variable_float(unit, anim_event, variable_name, variable_value)
end

return
