InteractionResult = {
	"ONGOING",
	"SUCCESS",
	"FAILURE",
	"USER_ENDED"
}

table.mirror_array_inplace(InteractionResult)

InteractionDefinitions = InteractionDefinitions or {}
InteractionDefinitions.player_generic = {
	default_config = {
		hud_verb = "player_interaction",
		duration = 2,
		hold = true,
		swap_to_3p = true
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			InteractionDefinitions.player_generic.current_data = InteractionHelper.choose_player_interaction(interactor_unit, interactable_unit)

			return InteractionDefinitions[InteractionDefinitions.player_generic.current_data].server.start(world, interactor_unit, interactable_unit, data, config, t)
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return InteractionDefinitions[InteractionDefinitions.player_generic.current_data].server.update(world, interactor_unit, interactable_unit, data, config, dt, t)
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			local result = InteractionDefinitions[InteractionDefinitions.player_generic.current_data].server.stop(world, interactor_unit, interactable_unit, data, config, t, result)
			InteractionDefinitions.player_generic.current_data = nil

			return result
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			InteractionDefinitions.player_generic.current_data = InteractionHelper.choose_player_interaction(interactor_unit, interactable_unit)

			return InteractionDefinitions[InteractionDefinitions.player_generic.current_data].client.start(world, interactor_unit, interactable_unit, data, config, t)
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return InteractionDefinitions[InteractionDefinitions.player_generic.current_data].client.update(world, interactor_unit, interactable_unit, data, config, dt, t)
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			local result = InteractionDefinitions[InteractionDefinitions.player_generic.current_data].client.stop(world, interactor_unit, interactable_unit, data, config, t, result)
			InteractionDefinitions.player_generic.current_data = nil

			return result
		end,
		get_progress = function (data, config, t)
			return InteractionDefinitions[InteractionDefinitions.player_generic.current_data].client.get_progress(data, config, t)
		end,
		hud_description = function (interactable_unit, __, __, interactor_unit)
			local result = InteractionHelper.choose_player_interaction(interactor_unit, interactable_unit)

			if result then
				return InteractionDefinitions[result].client.hud_description(interactable_unit, __, __, interactor_unit)
			else
				return InteractionDefinitions.player_generic.default_config.hud_verb
			end
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config)
			local result = InteractionHelper.choose_player_interaction(interactor_unit, interactable_unit)

			return result ~= nil, nil, result
		end
	},
	get_config = function ()
		if InteractionDefinitions.player_generic.current_data then
			return InteractionDefinitions[InteractionDefinitions.player_generic.current_data].config
		else
			return InteractionDefinitions.player_generic.default_config
		end
	end
}

local function _add_heal_telemetry(healer_player, target_player, position)
	if healer_player == target_player then
		Managers.telemetry.events:player_heal_self(healer_player, position)
	else
		Managers.telemetry.events:player_heal_ally(healer_player, target_player, position)
	end
end

local function _drop_pickup(interactor_unit, pickup_name)
	local first_person_extension = ScriptUnit.extension(interactor_unit, "first_person_system")
	local position = first_person_extension:current_position() + Vector3(math.random(-1, 1), math.random(-1, 1), 0) * 0.2
	local rotation = first_person_extension:current_rotation()
	local direction = Vector3.normalize(Quaternion.forward(rotation))
	local final_position = position + direction * 0.7
	local pickup_spawn_type = "dropped"
	local pickup_name_id = NetworkLookup.pickup_names[pickup_name]
	local pickup_spawn_type_id = NetworkLookup.pickup_spawn_types[pickup_spawn_type]
	local network_manager = Managers.state.network

	network_manager.network_transmit:send_rpc_server("rpc_spawn_pickup_with_physics", pickup_name_id, final_position, rotation, pickup_spawn_type_id)
end

InteractionDefinitions.revive = {
	config = {
		block_other_interactions = true,
		hud_verb = "revive",
		hold = true,
		swap_to_3p = true,
		duration = 2
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			local duration = config.duration
			local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
			duration = buff_extension:apply_buffs_to_value(duration, StatBuffIndex.FASTER_REVIVE)
			local revivee_status_extension = ScriptUnit.extension(interactable_unit, "status_system")

			revivee_status_extension:set_knocked_down_bleed_buff(true)

			data.done_time = t + duration
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			local health_extension = ScriptUnit.extension(interactor_unit, "health_system")
			local status_extension = ScriptUnit.extension(interactor_unit, "status_system")

			if status_extension:is_knocked_down() or not health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			local revivee_health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local revivee_status_extension = ScriptUnit.extension(interactable_unit, "status_system")

			if not revivee_status_extension:is_knocked_down() or not revivee_health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			if data.done_time < t then
				return InteractionResult.SUCCESS
			end

			return InteractionResult.ONGOING
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			if result == InteractionResult.SUCCESS then
				StatusUtils.set_revived_network(interactable_unit, true, interactor_unit)

				local player_manager = Managers.player
				local interactor_player = player_manager:unit_owner(interactor_unit)
				local interactable_player = player_manager:unit_owner(interactable_unit)

				if not interactor_player or not interactable_player then
					return
				end

				local interactable_pos = POSITION_LOOKUP[interactable_unit]

				Managers.telemetry.events:player_revive(interactor_player, interactable_player, interactable_pos)
			elseif Unit.alive(interactable_unit) then
				local health_extension = ScriptUnit.extension(interactable_unit, "health_system")

				if health_extension:is_alive() then
					local revivee_status_extension = ScriptUnit.extension(interactable_unit, "status_system")

					revivee_status_extension:set_knocked_down_bleed_buff(false)
				end
			end
		end,
		can_interact = function (interactor_unit, interactable_unit)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local knocked_down = status_extension:is_knocked_down()
			local pounced = status_extension:is_pounced_down()
			local alive = health_extension:is_alive()
			local grabbed = status_extension:is_grabbed_by_pack_master()
			local ledge_hanging = status_extension:get_is_ledge_hanging()
			local hanging_from_hook = status_extension:is_hanging_from_hook()
			local in_brawl_mode = Managers.state.game_mode:level_key() == "inn_level"
			local can_revive = knocked_down and alive and not pounced and not grabbed and not ledge_hanging and not hanging_from_hook and not in_brawl_mode

			return can_revive
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.start_time = t
			local revive_time_variable = Unit.animation_find_variable(interactable_unit, "revive_time")
			local duration = config.duration
			local event_data = FrameTable.alloc_table()
			local interactor_alive = Unit.alive(interactor_unit)

			if interactor_alive then
				local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
				duration = buff_extension:apply_buffs_to_value(duration, StatBuffIndex.FASTER_REVIVE)
				local interaction_duration_variable = Unit.animation_find_variable(interactor_unit, "interaction_duration")

				Unit.animation_set_variable(interactor_unit, interaction_duration_variable, duration)
				Unit.animation_event(interactor_unit, "interaction_revive")

				event_data.target = interactable_unit
			end

			local interactable_alive = Unit.alive(interactable_unit)

			if interactable_alive then
				Unit.animation_set_variable(interactable_unit, revive_time_variable, duration)
				Unit.animation_event(interactable_unit, "revive_start")

				if ScriptUnit.has_extension(interactable_unit, "first_person_system") then
					local first_person_extension = ScriptUnit.extension(interactable_unit, "first_person_system")

					first_person_extension:set_wanted_player_height("stand", t, duration)
				end

				event_data.target_name = ScriptUnit.extension(interactable_unit, "dialogue_system").context.player_profile
			end

			data.duration = duration

			if interactable_alive and interactor_alive then
				local dialogue_input = ScriptUnit.extension_input(interactor_unit, "dialogue_system")

				dialogue_input:trigger_dialogue_event("start_revive", event_data)
			end
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			data.start_time = nil
			local interactable_alive = Unit.alive(interactable_unit)
			local interactor_alive = Unit.alive(interactor_unit)

			if interactor_alive then
				Unit.animation_event(interactor_unit, "interaction_end")
			end

			if result == InteractionResult.SUCCESS then
				if interactable_alive then
					Unit.animation_event(interactable_unit, "revive_complete")
				end

				if interactor_alive and interactable_alive then
					StatisticsUtil.register_revive(interactor_unit, interactable_unit, data.statistics_db)
				end
			elseif interactable_alive then
				Unit.animation_event(interactable_unit, "revive_abort")

				if ScriptUnit.has_extension(interactable_unit, "first_person_system") then
					local first_person_extension = ScriptUnit.extension(interactable_unit, "first_person_system")

					first_person_extension:set_wanted_player_height("knocked_down", t)
				end
			end
		end,
		get_progress = function (data, config, t)
			local duration = data.duration

			if duration == 0 then
				return 0
			end

			return (data.start_time == nil and 0) or math.min(1, (t - data.start_time) / duration)
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local knocked_down = status_extension:is_knocked_down()
			local pounced = status_extension:is_pounced_down()
			local alive = health_extension:is_alive()
			local grabbed = status_extension:is_grabbed_by_pack_master()
			local ledge_hanging = status_extension:get_is_ledge_hanging()
			local hanging_from_hook = status_extension:is_hanging_from_hook()
			local in_brawl_mode = Managers.state.game_mode:level_key() == "inn_level"
			local can_revive = knocked_down and alive and not pounced and not grabbed and not ledge_hanging and not hanging_from_hook and not in_brawl_mode

			return can_revive
		end
	}
}
InteractionDefinitions.pull_up = {
	config = {
		block_other_interactions = true,
		hud_verb = "pull up",
		hold = true,
		swap_to_3p = true,
		duration = 2,
		does_not_require_line_of_sight = true
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.done_time = t + config.duration
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			local health_extension = ScriptUnit.extension(interactor_unit, "health_system")
			local status_extension = ScriptUnit.extension(interactor_unit, "status_system")

			if status_extension:get_is_ledge_hanging() or not health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			if data.done_time < t then
				return InteractionResult.SUCCESS
			end

			return InteractionResult.ONGOING
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			if result == InteractionResult.SUCCESS then
				StatusUtils.set_pulled_up_network(interactable_unit, true, (Unit.alive(interactor_unit) and interactor_unit) or nil)
			end
		end,
		can_interact = function (interactor_unit, interactable_unit)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local is_hanging = status_extension:get_is_ledge_hanging()
			local is_pulled_up = status_extension:is_pulled_up()

			return is_hanging and not is_pulled_up
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.start_time = t
			local interaction_duration_variable = Unit.animation_find_variable(interactor_unit, "interaction_duration")

			Unit.animation_set_variable(interactor_unit, interaction_duration_variable, config.duration)
			Unit.animation_event(interactor_unit, "interaction_revive")

			if Unit.alive(interactable_unit) then
				local revive_time_variable = Unit.animation_find_variable(interactable_unit, "revive_time")

				Unit.animation_set_variable(interactable_unit, revive_time_variable, config.duration)
				Unit.animation_event(interactable_unit, "revive_start")

				if ScriptUnit.has_extension(interactable_unit, "first_person_system") then
					local first_person_extension = ScriptUnit.extension(interactable_unit, "first_person_system")

					first_person_extension:set_wanted_player_height("stand", t, config.duration)
				end

				local dialogue_input = ScriptUnit.extension_input(interactor_unit, "dialogue_system")
				local event_data = FrameTable.alloc_table()
				event_data.target = interactable_unit
				event_data.target_name = ScriptUnit.extension(interactable_unit, "dialogue_system").context.player_profile

				dialogue_input:trigger_dialogue_event("start_revive", event_data)
			end
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			data.start_time = nil

			Unit.animation_event(interactor_unit, "interaction_end")

			if result == InteractionResult.SUCCESS then
				if Unit.alive(interactable_unit) then
					StatisticsUtil.register_pull_up(interactor_unit, interactable_unit, data.statistics_db)
					Unit.animation_event(interactable_unit, "revive_complete")
				end
			elseif Unit.alive(interactable_unit) then
				Unit.animation_event(interactable_unit, "revive_abort")

				if ScriptUnit.has_extension(interactable_unit, "first_person_system") then
					local first_person_extension = ScriptUnit.extension(interactable_unit, "first_person_system")

					first_person_extension:set_wanted_player_height("knocked_down", t)
				end
			end
		end,
		get_progress = function (data, config, t)
			if config.duration == 0 then
				return 0
			end

			return (data.start_time == nil and 0) or math.min(1, (t - data.start_time) / config.duration)
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local can_pull_up = status_extension:get_is_ledge_hanging() and not status_extension:is_pulled_up()

			return can_pull_up
		end
	}
}
InteractionDefinitions.release_from_hook = {
	config = {
		block_other_interactions = true,
		hud_verb = "player_interaction",
		hold = true,
		swap_to_3p = true,
		duration = 2
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.done_time = t + config.duration
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			if data.done_time < t then
				return InteractionResult.SUCCESS
			end

			return InteractionResult.ONGOING
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			if result == InteractionResult.SUCCESS then
				StatusUtils.set_grabbed_by_pack_master_network("pack_master_dropping", interactable_unit, true, nil)
			end
		end,
		can_interact = function (interactor_unit, interactable_unit)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local is_hooked = status_extension:is_hanging_from_hook()
			local alive = health_extension:is_alive()

			return is_hooked and alive
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.start_time = t
			local interaction_duration_variable = Unit.animation_find_variable(interactor_unit, "interaction_duration")

			Unit.animation_set_variable(interactor_unit, interaction_duration_variable, config.duration)
			Unit.animation_event(interactor_unit, "interaction_generic")

			local dialogue_input = ScriptUnit.extension_input(interactor_unit, "dialogue_system")
			local event_data = FrameTable.alloc_table()
			event_data.target = interactable_unit
			event_data.target_name = ScriptUnit.extension(interactable_unit, "dialogue_system").context.player_profile

			dialogue_input:trigger_dialogue_event("start_revive", event_data)
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			data.start_time = nil

			Unit.animation_event(interactor_unit, "interaction_end")
		end,
		get_progress = function (data, config, t)
			if config.duration == 0 then
				return 0
			end

			return (data.start_time == nil and 0) or math.min(1, (t - data.start_time) / config.duration)
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local is_hanging = status_extension:is_hanging_from_hook()
			local alive = ScriptUnit.extension(interactable_unit, "health_system"):is_alive()

			return is_hanging and alive
		end
	}
}
InteractionDefinitions.assisted_respawn = {
	config = {
		block_other_interactions = true,
		hud_verb = "assist respawn",
		hold = true,
		swap_to_3p = true,
		duration = 2
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.done_time = t + config.duration
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			if data.done_time < t then
				return InteractionResult.SUCCESS
			end

			return InteractionResult.ONGOING
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			if result == InteractionResult.SUCCESS then
				StatusUtils.set_respawned_network(interactable_unit, true, interactor_unit)
			end
		end,
		can_interact = function (interactor_unit, interactable_unit)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local can_be_assisted = status_extension:is_ready_for_assisted_respawn()

			return can_be_assisted
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.start_time = t
			local revive_time_variable = Unit.animation_find_variable(interactor_unit, "revive_time")

			Unit.animation_set_variable(interactable_unit, revive_time_variable, config.duration)
			Unit.animation_event(interactable_unit, "revive_start")

			local interaction_duration_variable = Unit.animation_find_variable(interactor_unit, "interaction_duration")

			Unit.animation_set_variable(interactor_unit, interaction_duration_variable, config.duration)
			Unit.animation_event(interactor_unit, "interaction_revive")
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			data.start_time = nil

			Unit.animation_event(interactor_unit, "interaction_end")

			if result == InteractionResult.SUCCESS then
				Unit.animation_event(interactable_unit, "revive_complete")
				StatisticsUtil.register_assisted_respawn(interactor_unit, interactable_unit, data.statistics_db)
			else
				Unit.animation_event(interactable_unit, "revive_abort")
			end
		end,
		get_progress = function (data, config, t)
			if config.duration == 0 then
				return 0
			end

			return (data.start_time == nil and 0) or math.min(1, (t - data.start_time) / config.duration)
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local is_ready = status_extension:is_ready_for_assisted_respawn()

			return is_ready
		end
	}
}
InteractionDefinitions.smartobject = {
	config = {
		show_weapons = true,
		duration = 0,
		hold = true,
		swap_to_3p = false
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			local duration = Unit.get_data(interactable_unit, "interaction_data", "interaction_length")

			fassert(duration, "Interacting with %q that has no interaction length", interactable_unit)

			data.done_time = t + duration
			data.duration = duration
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			local health_extension = ScriptUnit.extension(interactor_unit, "health_system")
			local status_extension = ScriptUnit.extension(interactor_unit, "status_system")

			if status_extension:is_knocked_down() or not health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			if data.done_time < t then
				return InteractionResult.SUCCESS
			end

			return InteractionResult.ONGOING
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			return
		end,
		can_interact = function (interactor_unit, interactable_unit)
			local used = Unit.get_data(interactable_unit, "interaction_data", "used")

			return not used
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.start_time = t
			local duration = Unit.get_data(interactable_unit, "interaction_data", "interaction_length")
			data.duration = duration
			local interactor_animation_name = Unit.get_data(interactable_unit, "interaction_data", "interactor_animation")
			local interactor_animation_time_variable = Unit.get_data(interactable_unit, "interaction_data", "interactor_animation_time_variable")
			local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")

			if interactor_animation_name then
				local interactor_animation_time_variable = Unit.animation_find_variable(interactor_unit, interactor_animation_time_variable)

				Unit.animation_set_variable(interactor_unit, interactor_animation_time_variable, duration)
				Unit.animation_event(interactor_unit, interactor_animation_name)
			end

			local interactable_animation_name = Unit.get_data(interactable_unit, "interaction_data", "interactable_animation")
			local interactable_animation_time_variable_name = Unit.get_data(interactable_unit, "interaction_data", "interactable_animation_time_variable")

			if interactable_animation_name then
				local interactable_animation_time_variable = Unit.animation_find_variable(interactable_unit, interactable_animation_time_variable_name)

				Unit.animation_set_variable(interactable_unit, interactable_animation_time_variable, duration)
				Unit.animation_event(interactable_unit, interactable_animation_name)
			end

			CharacterStateHelper.stop_weapon_actions(inventory_extension, "interacting")
			Unit.set_data(interactable_unit, "interaction_data", "being_used", true)
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			data.start_time = nil

			Unit.animation_event(interactor_unit, "interaction_end")

			local interactable_alive = Unit.alive(interactable_unit)

			if result == InteractionResult.SUCCESS and interactable_alive and Unit.get_data(interactable_unit, "interaction_data", "only_once") then
				Unit.set_data(interactable_unit, "interaction_data", "used", true)
			end

			if interactable_alive then
				Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
			end
		end,
		get_progress = function (data, config, t)
			if data.duration == 0 then
				return 0
			end

			return (data.start_time == nil and 0) or math.min(1, (t - data.start_time) / data.duration)
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config)
			local used = Unit.get_data(interactable_unit, "interaction_data", "used")
			local being_used = Unit.get_data(interactable_unit, "interaction_data", "being_used")

			return not used and not being_used
		end,
		hud_description = function (interactable_unit, config)
			return Unit.get_data(interactable_unit, "interaction_data", "hud_description")
		end
	}
}
InteractionDefinitions.pickup_object = {
	config = {
		allow_movement = true,
		duration = 0,
		hold = true,
		swap_to_3p = false
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			local duration = Unit.get_data(interactable_unit, "interaction_data", "interaction_length")
			data.done_time = t + duration
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			local health_extension = ScriptUnit.extension(interactor_unit, "health_system")
			local status_extension = ScriptUnit.extension(interactor_unit, "status_system")

			if status_extension:is_knocked_down() or not health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			if data.done_time < t then
				return InteractionResult.SUCCESS
			end

			return InteractionResult.ONGOING
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			if result == InteractionResult.SUCCESS and Unit.get_data(interactable_unit, "interaction_data", "only_once") then
				if ScriptUnit.has_extension(interactable_unit, "limited_item_track_system") then
					local limited_item_extension = ScriptUnit.extension(interactable_unit, "limited_item_track_system")

					limited_item_extension:mark_for_transformation()
				end

				Managers.state.unit_spawner:mark_for_deletion(interactable_unit)
			end
		end,
		can_interact = function (interactor_unit, interactable_unit)
			return true
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			local duration = Unit.get_data(interactable_unit, "interaction_data", "interaction_length")
			data.duration = duration

			fassert(duration, "Interacting with %q that has no interaction length", interactable_unit)
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			data.start_time = nil

			Unit.animation_event(interactor_unit, "interaction_end")

			local unique_mission_id = nil

			if result == InteractionResult.SUCCESS then
				local player_manager = Managers.player
				local player = player_manager:owner(interactor_unit)
				local local_human = player.local_player
				local local_bot_or_human = not player.remote
				local interactor_is_local_player = player.local_player
				local network_manager = Managers.state.network
				local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
				local pickup_extension = ScriptUnit.extension(interactable_unit, "pickup_system")
				local pickup_settings = pickup_extension:get_pickup_settings()

				if pickup_settings.type == "loot_die" then
					Managers.state.event:trigger("add_coop_feedback", player:stats_id(), local_human, "picked_up_loot_dice", player)

					if local_bot_or_human then
						Managers.chat:send_system_chat_message(1, "system_chat_player_picked_up_loot_die", player:name())
					end
				elseif pickup_settings.type == "endurance_badge" then
					Managers.state.event:trigger("add_coop_feedback", player:stats_id(), local_human, "picked_up_endurance_badge", player)

					if local_bot_or_human then
						Managers.chat:send_system_chat_message(1, "dlc1_2_system_chat_player_picked_up_endurance_badge", player:name())
					end
				elseif pickup_settings.type == "event_item" then
					for _, _player in pairs(player_manager:players()) do
						data.statistics_db:increment_stat(_player:stats_id(), "event_items_found")
					end

					Managers.state.event:trigger("add_coop_feedback", player:stats_id(), local_human, "picked_up_event_item", player)

					if local_bot_or_human then
						Managers.chat:send_system_chat_message(1, "system_chat_player_picked_up_event_item", player:name())
					end
				elseif pickup_settings.type == "inventory_item" then
					local slot_name = pickup_settings.slot_name
					local item_name = pickup_settings.item_name
					local slot_data = inventory_extension:get_slot_data(slot_name)
					local item_data = ItemMasterList[item_name]

					if not slot_data or (slot_data and slot_data.item_data.name ~= item_data.name) then
						if item_name == "wpn_side_objective_tome_01" then
							Managers.state.event:trigger("add_coop_feedback", player:stats_id(), local_human, "picked_up_tome", player)

							if local_bot_or_human then
								Managers.chat:send_system_chat_message(1, "system_chat_player_picked_up_tome", player:name())
							end
						elseif item_name == "wpn_grimoire_01" then
							Managers.state.event:trigger("add_coop_feedback", player:stats_id(), local_human, "picked_up_grimoire", player)

							if local_bot_or_human then
								Managers.chat:send_system_chat_message(1, "system_chat_player_picked_up_grimoire", player:name())
							end
						end
					end

					if slot_data then
						local item_data = slot_data.item_data
						local item_template = BackendUtils.get_item_template(item_data)

						if item_name ~= "wpn_side_objective_tome_01" and item_template.name == "wpn_side_objective_tome_01" then
							local local_human = not player.remote and not player.bot_player

							Managers.state.event:trigger("add_coop_feedback", player:stats_id(), local_human, "discarded_tome", player)

							if local_bot_or_human then
								Managers.chat:send_system_chat_message(1, "system_chat_player_discarded_tome", player:name())
							end
						elseif item_name ~= "wpn_grimoire_01" and item_template.name == "wpn_grimoire_01" then
							local local_human = not player.remote and not player.bot_player

							Managers.state.event:trigger("add_coop_feedback", player:stats_id(), local_human, "discarded_grimoire", player)

							if local_bot_or_human then
								Managers.chat:send_system_chat_message(1, "system_chat_player_discarded_grimoire", player:name())
							end
						end
					end
				elseif pickup_settings.type == "lorebook_page" and local_human then
					local level_key = Managers.state.game_mode:level_key()
					local pages = table.clone(LorebookCollectablePages[level_key])
					local any_level_pages = LorebookCollectablePages.any

					table.append(pages, any_level_pages)
					table.shuffle(pages)

					local num_pages = #pages
					local local_player = Managers.player:local_player()
					local stats_id = local_player:stats_id()
					local statistics_db = data.statistics_db

					for i = 1, num_pages, 1 do
						local category_name = pages[i]
						local page_id = LorebookCategoryLookup[category_name]
						local persistent_unlocked = statistics_db:get_persistent_lorebook_stat(stats_id, "lorebook_unlocks", page_id)
						local session_unlocked = false
						local mission_system = Managers.state.entity:system("mission_system")
						local active_missions, completed_missions = mission_system:get_missions()
						local mission_data = active_missions.lorebook_page_hidden_mission

						if mission_data then
							local unique_ids = mission_data:get_unique_ids()
							session_unlocked = unique_ids[page_id]
						end

						if not persistent_unlocked and not session_unlocked then
							unique_mission_id = page_id

							Managers.state.event:trigger("add_personal_feedback", player:stats_id() .. page_id, local_human, "picked_up_lorebook_page", category_name)

							break
						end
					end

					if not unique_mission_id then
						if pickup_settings.hide_on_pickup then
							pickup_extension:hide()
						end

						return
					end
				end

				local local_pickup_sound = pickup_settings.local_pickup_sound
				local play_sound = ((local_pickup_sound and local_bot_or_human) or not local_pickup_sound) and not player.bot_player

				if play_sound then
					local pickup_sound_event_func = pickup_settings.pickup_sound_event_func
					local sound_event = (pickup_sound_event_func and pickup_sound_event_func(interactor_unit, interactable_unit, data)) or pickup_settings.pickup_sound_event

					if sound_event then
						local wwise_world = Managers.world:wwise_world(world)

						WwiseWorld.trigger_event(wwise_world, sound_event)
					end
				end

				if local_bot_or_human then
					local dialogue_input = ScriptUnit.extension_input(interactor_unit, "dialogue_system")
					local event_data = FrameTable.alloc_table()
					event_data.pickup_name = Unit.get_data(interactable_unit, "interaction_data", "hud_description")

					dialogue_input:trigger_dialogue_event("on_pickup", event_data)

					local pickup_name = Unit.get_data(interactable_unit, "interaction_data", "hud_description")
					local target_name = ScriptUnit.extension(interactor_unit, "dialogue_system").context.player_profile

					SurroundingAwareSystem.add_event(interactor_unit, "on_other_pickup", DialogueSettings.default_view_distance, "pickup_name", pickup_name, "target_name", target_name)

					local pickup_name = pickup_extension.pickup_name
					local pickup_spawn_type = pickup_extension.spawn_type
					local pickup_position = POSITION_LOOKUP[interactable_unit]

					Managers.telemetry.events:player_pickup(player, pickup_name, pickup_spawn_type, pickup_position)

					if pickup_settings.hide_on_pickup then
						pickup_extension:hide()
					end

					if pickup_settings.type == "inventory_item" then
						local slot_name = pickup_settings.slot_name
						local item_name = pickup_settings.item_name
						local unit_template = nil
						local extra_extension_init_data = {}
						local is_limited_item = ScriptUnit.has_extension(interactable_unit, "limited_item_track_system")

						if is_limited_item then
							local limited_item_extension = ScriptUnit.extension(interactable_unit, "limited_item_track_system")
							local id = limited_item_extension.id
							local spawner_unit = limited_item_extension.spawner_unit
							unit_template = "weapon_unit_ammo_limited"
							extra_extension_init_data.limited_item_track_system = {
								spawner_unit = spawner_unit,
								id = id
							}
						end

						local wielded_slot_name = inventory_extension:get_wielded_slot_name()

						if pickup_settings.wield_on_pickup or wielded_slot_name == slot_name then
							CharacterStateHelper.stop_weapon_actions(inventory_extension, "picked_up_object")
						end

						local slot_data = inventory_extension:get_slot_data(slot_name)
						local item_data = ItemMasterList[item_name]

						inventory_extension:destroy_slot(slot_name)
						inventory_extension:add_equipment(slot_name, item_data, unit_template, extra_extension_init_data)

						if not LEVEL_EDITOR_TEST then
							local unit_object_id = Managers.state.unit_storage:go_id(interactor_unit)
							local slot_id = NetworkLookup.equipment_slots[slot_name]
							local item_id = NetworkLookup.item_names[item_name]

							if is_limited_item then
								local limited_item_extension = ScriptUnit.extension(interactable_unit, "limited_item_track_system")
								local id = limited_item_extension.id
								local spawner_unit = limited_item_extension.spawner_unit
								local spawner_unit_id = Managers.state.network:level_object_id(spawner_unit)

								if data.is_server then
									network_manager.network_transmit:send_rpc_clients("rpc_add_equipment_limited_item", unit_object_id, slot_id, item_id, spawner_unit_id, id)
								else
									network_manager.network_transmit:send_rpc_server("rpc_add_equipment_limited_item", unit_object_id, slot_id, item_id, spawner_unit_id, id)
								end
							elseif data.is_server then
								network_manager.network_transmit:send_rpc_clients("rpc_add_equipment", unit_object_id, slot_id, item_id)
							else
								network_manager.network_transmit:send_rpc_server("rpc_add_equipment", unit_object_id, slot_id, item_id)
							end

							if slot_data then
								local item_data = slot_data.item_data
								local item_template = BackendUtils.get_item_template(item_data)
								local pickup_data = item_template.pickup_data

								if pickup_data then
									local position = POSITION_LOOKUP[interactable_unit]
									local rotation = Unit.local_rotation(interactable_unit, 0)
									local pickup_spawn_type = "dropped"
									local pickup_name = pickup_data.pickup_name
									local pickup_name_id = NetworkLookup.pickup_names[pickup_name]
									local pickup_spawn_type_id = NetworkLookup.pickup_spawn_types[pickup_spawn_type]
									local network_manager = Managers.state.network

									network_manager.network_transmit:send_rpc_server("rpc_spawn_pickup", pickup_name_id, position, rotation, pickup_spawn_type_id)
								end
							end

							if pickup_settings.dupable and pickup_extension.spawn_type ~= "dropped" then
								local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
								local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.NOT_CONSUME_PICKUP)

								if procced then
									local pickup_name = pickup_extension.pickup_name

									_drop_pickup(interactor_unit, pickup_name)
								end
							end
						end

						if pickup_settings.wield_on_pickup or wielded_slot_name == slot_name then
							inventory_extension:wield(slot_name)
						end
					elseif pickup_settings.type == "explosive_inventory_item" then
						local slot_name = pickup_settings.slot_name
						local item_name = pickup_settings.item_name
						local time_of_explosion = nil

						if ScriptUnit.has_extension(interactable_unit, "projectile_system") then
							local projectile_extension = ScriptUnit.extension(interactable_unit, "projectile_system")
							time_of_explosion = projectile_extension.stop_time
						end

						local health_extension = ScriptUnit.extension(interactable_unit, "health_system")
						local death_extension = ScriptUnit.extension(interactable_unit, "death_system")
						local unit_template = "explosive_weapon_unit_ammo"
						local extra_extension_init_data = {
							damage_system = {
								owner_unit = interactor_unit,
								ignored_damage_types = {
									heal = true,
									kinetic = true,
									wounded_dot = true,
									buff = true
								}
							},
							health_system = {
								health = health_extension.health,
								damage = health_extension.damage
							},
							death_system = {
								in_hand = true,
								death_reaction_template = death_extension.death_reaction_template,
								item_name = item_name
							}
						}

						if death_extension:has_death_started() then
							extra_extension_init_data.death_system.death_data = death_extension.death_reaction_data
						end

						local is_limited_item = ScriptUnit.has_extension(interactable_unit, "limited_item_track_system")

						if is_limited_item then
							local limited_item_extension = ScriptUnit.extension(interactable_unit, "limited_item_track_system")
							local id = limited_item_extension.id
							local spawner_unit = limited_item_extension.spawner_unit
							unit_template = "explosive_weapon_unit_ammo_limited"
							extra_extension_init_data.limited_item_track_system = {
								spawner_unit = spawner_unit,
								id = id
							}
						end

						local item_data = ItemMasterList[item_name]

						inventory_extension:add_equipment(slot_name, item_data, unit_template, extra_extension_init_data)

						if not LEVEL_EDITOR_TEST then
							local unit_object_id = Managers.state.unit_storage:go_id(interactor_unit)
							local slot_id = NetworkLookup.equipment_slots[slot_name]
							local item_id = NetworkLookup.item_names[item_name]

							if data.is_server then
								if is_limited_item then
									local limited_item_extension = ScriptUnit.extension(interactable_unit, "limited_item_track_system")
									local id = limited_item_extension.id
									local spawner_unit = limited_item_extension.spawner_unit
									local spawner_unit_id = Managers.state.network:level_object_id(spawner_unit)

									network_manager.network_transmit:send_rpc_clients("rpc_add_equipment_limited_item", unit_object_id, slot_id, item_id, spawner_unit_id, id)
								else
									network_manager.network_transmit:send_rpc_clients("rpc_add_equipment", unit_object_id, slot_id, item_id)
								end
							elseif is_limited_item then
								local limited_item_extension = ScriptUnit.extension(interactable_unit, "limited_item_track_system")
								local id = limited_item_extension.id
								local spawner_unit = limited_item_extension.spawner_unit
								local spawner_unit_id = Managers.state.network:level_object_id(spawner_unit)

								network_manager.network_transmit:send_rpc_server("rpc_add_equipment_limited_item", unit_object_id, slot_id, item_id, spawner_unit_id, id)
							else
								network_manager.network_transmit:send_rpc_server("rpc_add_equipment", unit_object_id, slot_id, item_id)
							end
						end

						if pickup_settings.wield_on_pickup then
							CharacterStateHelper.stop_weapon_actions(inventory_extension, "picked_up_object")
							inventory_extension:wield(slot_name)
						end
					elseif pickup_settings.type == "ammo" then
						if local_human then
							local hud_extension = ScriptUnit.extension(interactor_unit, "hud_system")

							hud_extension:set_picked_up_ammo(true)
						end

						inventory_extension:add_ammo_from_pickup(pickup_settings)
					elseif pickup_settings.mission_name then
						local mission_name = pickup_settings.mission_name
						local mission_name_id = NetworkLookup.mission_names[mission_name]
						local network_transmit = network_manager.network_transmit

						network_transmit:send_rpc_server("rpc_request_mission", mission_name_id)

						if unique_mission_id then
							network_transmit:send_rpc_server("rpc_request_unique_mission_update", mission_name_id, unique_mission_id)
						else
							network_transmit:send_rpc_server("rpc_request_mission_update", mission_name_id, true)
						end
					end
				end
			end
		end,
		get_progress = function (data, config, t)
			if data.duration == 0 then
				return nil
			end

			return (data.start_time == nil and 0) or math.min(1, (t - data.start_time) / data.duration)
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config, world)
			local return_value = not Unit.get_data(interactable_unit, "interaction_data", "used")
			local pickup_extension = ScriptUnit.extension(interactable_unit, "pickup_system")
			local pickup_settings = pickup_extension:get_pickup_settings()
			local slot_name = pickup_settings.slot_name
			local fail_reason = nil

			if return_value and pickup_extension.can_interact then
				return_value = pickup_extension:can_interact()
			end

			if return_value and pickup_settings.can_interact_func then
				return_value = pickup_settings.can_interact_func(interactor_unit, interactable_unit, data)
			end

			local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
			local item_data, right_hand_weapon_extension, left_hand_weapon_extension = CharacterStateHelper._get_item_data_and_weapon_extensions(inventory_extension)

			if return_value and item_data then
				local current_action_settings, current_action_extension, current_action_hand = CharacterStateHelper._get_current_action_data(left_hand_weapon_extension, right_hand_weapon_extension)

				if current_action_settings and current_action_settings.block_pickup then
					return_value = false
				end
			end

			if return_value and slot_name == "slot_level_event" then
				local wielded_slot_name = inventory_extension:get_wielded_slot_name()

				if wielded_slot_name == "slot_level_event" then
					return_value = false
				end
			end

			local slot_data = slot_name and inventory_extension:get_slot_data(slot_name)
			local item_template = slot_data and inventory_extension:get_item_template(slot_data)

			if return_value and slot_name and item_template and slot_name == "slot_potion" and item_template.is_grimoire then
				fail_reason = "grimoire_equipped"
				return_value = false
			end

			local pickup_item_name = pickup_settings.item_name
			local slot_item_name = inventory_extension:get_item_name(slot_name)
			local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")

			if return_value and pickup_item_name and slot_item_name and pickup_item_name == slot_item_name and (not buff_extension:has_buff_type("not_consume_pickup") or not pickup_settings.dupable or pickup_extension.spawn_type == "dropped") then
				fail_reason = "already_equipped"
				return_value = false
			end

			if return_value and ScriptUnit.has_extension(interactable_unit, "death_system") then
				local death_extension = ScriptUnit.extension(interactable_unit, "death_system")
				local death_reaction_data = death_extension.death_reaction_data

				if death_reaction_data and death_reaction_data.exploded then
					return_value = false
				end
			end

			if return_value and pickup_settings.type == "ammo" and inventory_extension:has_full_ammo() then
				fail_reason = "ammo_full"
				return_value = false
			end

			return return_value, fail_reason
		end,
		hud_description = function (interactable_unit, config, fail_reason, interactor_unit)
			if not Managers.state.unit_spawner:is_marked_for_deletion(interactable_unit) then
				if fail_reason then
					if fail_reason == "already_equipped" then
						local pickup_extension = ScriptUnit.extension(interactable_unit, "pickup_system")
						local pickup_settings = pickup_extension:get_pickup_settings()

						if not pickup_settings.item_description then
							table.dump(pickup_settings)
						end

						return "already_equipped", pickup_settings.item_description
					elseif fail_reason == "ammo_full" then
						return "ammo_full"
					elseif fail_reason == "grimoire_equipped" then
						return "grimoire_equipped"
					end
				else
					local pickup_extension = ScriptUnit.extension(interactable_unit, "pickup_system")
					local pickup_settings = pickup_extension:get_pickup_settings()
					local pickup_item_name = pickup_settings.item_name
					local slot_name = pickup_settings.slot_name
					local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
					local slot_item_name = inventory_extension:get_item_name(slot_name)
					local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")

					if pickup_item_name and slot_item_name and pickup_item_name == slot_item_name and buff_extension:has_buff_type("not_consume_pickup") and pickup_settings.dupable and pickup_extension.spawn_type ~= "dropped" then
						return "trinket_not_consume_pickup_tier1"
					end
				end
			end

			return Unit.get_data(interactable_unit, "interaction_data", "hud_description")
		end
	}
}
InteractionDefinitions.give_item = {
	config = {
		allow_movement = true,
		duration = 0,
		hold = false,
		block_other_interactions = true
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.done_time = t + config.duration
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			local interactor_health_extension = ScriptUnit.extension(interactor_unit, "health_system")
			local interactor_status_extension = ScriptUnit.extension(interactor_unit, "status_system")

			if interactor_status_extension:is_knocked_down() or not interactor_health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			if interactor_status_extension:is_disabled() then
				return InteractionResult.FAILURE
			end

			local interactable_health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local interactable_status_extension = ScriptUnit.extension(interactor_unit, "status_system")

			if interactable_status_extension:is_knocked_down() or not interactable_health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			if data.done_time < t then
				local player_manager = Managers.player
				local interactor_player = player_manager:owner(interactor_unit)
				local interacted_player = player_manager:owner(interactable_unit)

				if interactor_player and interacted_player then
					local local_human = interactor_player.local_player
					local predicate = "give_item"

					Managers.state.event:trigger("add_coop_feedback", interactor_player:stats_id() .. interacted_player:stats_id(), local_human, predicate, interactor_player, interacted_player)
					Managers.state.network.network_transmit:send_rpc_clients("rpc_coop_feedback", interactor_player:network_id(), interactor_player:local_player_id(), NetworkLookup.coop_feedback[predicate], interacted_player:network_id(), interacted_player:local_player_id())
				end

				return InteractionResult.SUCCESS
			end

			return InteractionResult.ONGOING
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			return
		end,
		can_interact = function (interactor_unit, interactable_unit)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local can_receive_item = not status_extension:is_disabled()

			return can_receive_item
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			return
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			data.start_time = nil

			Unit.animation_event(interactor_unit, "interaction_end")

			if result == InteractionResult.SUCCESS then
				local player_manager = Managers.player
				local interactor_player = player_manager:owner(interactor_unit)

				if interactor_player and not interactor_player.remote then
					local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
					local interactor_data = data.interactor_data
					local item_slot_name = interactor_data.item_slot_name
					local slot_data = inventory_extension:get_slot_data(item_slot_name)

					if slot_data then
						local template = inventory_extension:get_item_template(slot_data)

						if template.can_give_other then
							local ammo_extension = inventory_extension:get_item_slot_extension(item_slot_name, "ammo_system")

							ammo_extension:use_ammo(1)

							if not LEVEL_EDITOR_TEST then
								local game_object_id = Managers.state.unit_storage:go_id(interactable_unit)
								local slot_id = NetworkLookup.equipment_slots[item_slot_name]
								local item_name_id = NetworkLookup.item_names[slot_data.item_data.name]
								local position = POSITION_LOOKUP[interactable_unit] + Vector3(0, 0, 1.5)

								Managers.state.network.network_transmit:send_rpc_server("rpc_give_equipment", game_object_id, slot_id, item_name_id, position)
							end
						end
					end
				end
			end
		end,
		get_progress = function (data, config, t)
			if config.duration == 0 then
				return 0
			end

			return (data.start_time == nil and 0) or math.min(1, (t - data.start_time) / config.duration)
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config)
			if not ScriptUnit.has_extension(interactable_unit, "damage_system") then
				return false
			end

			if not ScriptUnit.has_extension(interactable_unit, "status_system") then
				return false
			end

			local owner_player = Managers.player:unit_owner(interactor_unit)
			local is_bot = owner_player and owner_player.bot_player
			local health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local is_alive = health_extension:is_alive() and not status_extension:is_knocked_down()
			local interactor_inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
			local item_template = interactor_inventory_extension:get_wielded_slot_item_template()

			if not item_template then
				return false
			end

			local target_inventory_extension = ScriptUnit.extension(interactable_unit, "inventory_system")
			local slot_name = (Managers.input:is_device_active("gamepad") and interactor_inventory_extension:get_selected_consumable_slot_name()) or interactor_inventory_extension:get_wielded_slot_name()
			local slot_occupied = target_inventory_extension:get_slot_data(slot_name)

			return is_alive and item_template.can_give_other and not slot_occupied
		end,
		set_interactor_data = function (interactor_unit, interactable_unit, interactor_data)
			local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
			local wielded_slot_name = inventory_extension:get_wielded_slot_name()
			interactor_data.item_slot_name = wielded_slot_name
		end,
		hud_description = function (interactable_unit, config)
			if interactable_unit == nil then
				return "interact_heal_self"
			else
				return "interact_give_ally"
			end
		end
	}
}
InteractionDefinitions.heal = {
	config = {
		block_other_interactions = true,
		hold = true,
		swap_to_3p = true,
		duration = 2,
		attack_template = "heal_bandage"
	},
	server = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.done_time = t + config.duration
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			local interactor_health_extension = ScriptUnit.extension(interactor_unit, "health_system")
			local interactor_status_extension = ScriptUnit.extension(interactor_unit, "status_system")

			if interactor_status_extension:is_knocked_down() or not interactor_health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			if interactor_status_extension:is_disabled() then
				return InteractionResult.FAILURE
			end

			local interactable_health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local interactable_status_extension = ScriptUnit.extension(interactor_unit, "status_system")

			if interactable_status_extension:is_knocked_down() or not interactable_health_extension:is_alive() then
				return InteractionResult.FAILURE
			end

			if data.done_time < t then
				return InteractionResult.SUCCESS
			end

			return InteractionResult.ONGOING
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			if result == InteractionResult.SUCCESS then
				local attack_template = AttackTemplates[config.attack_template]
				local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")

				if attack_template.heal_type == "bandage" then
					local health_extension = ScriptUnit.extension(interactable_unit, "health_system")
					local damage_taken = health_extension.damage
					local heal_amount = damage_taken * attack_template.heal_percent

					DamageUtils.heal_network(interactable_unit, interactor_unit, heal_amount, attack_template.heal_type)
				else
					DamageUtils.heal_network(interactable_unit, interactor_unit, attack_template.heal_amount, attack_template.heal_type)
				end

				if interactor_unit ~= interactable_unit then
					local health_extension = ScriptUnit.extension(interactor_unit, "health_system")
					local damage_taken = health_extension.damage
					local heal_amount, procced = buff_extension:apply_buffs_to_value(damage_taken, StatBuffIndex.HEAL_SELF_ON_HEAL_OTHER)
					heal_amount = heal_amount - damage_taken

					if procced then
						DamageUtils.heal_network(interactor_unit, interactor_unit, heal_amount, "bandage_trinket")
					end
				end

				local mission_system = Managers.state.entity:system("mission_system")

				mission_system:increment_goal_mission_counter("merchant_no_healing", 1, true)

				local player_manager = Managers.player
				local interactor_player = player_manager:unit_owner(interactor_unit)
				local interactable_player = player_manager:unit_owner(interactable_unit)
				local interactable_pos = POSITION_LOOKUP[interactable_unit]

				_add_heal_telemetry(interactor_player, interactable_player, interactable_pos)
			end
		end,
		can_interact = function (interactor_unit, interactable_unit)
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local is_knocked_down = status_extension:is_knocked_down()
			local is_dead = status_extension:is_dead()
			local health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local has_max_health = health_extension:current_health_percent() == 1

			return not is_knocked_down and not is_dead and not has_max_health
		end
	},
	client = {
		start = function (world, interactor_unit, interactable_unit, data, config, t)
			data.start_time = t
			local interactor_dialogue_input = ScriptUnit.extension_input(interactor_unit, "dialogue_system")
			local event_data = FrameTable.alloc_table()
			event_data.target = interactable_unit
			event_data.target_name = ScriptUnit.extension(interactable_unit, "dialogue_system").context.player_profile

			interactor_dialogue_input:trigger_dialogue_event("heal_start", event_data)
		end,
		update = function (world, interactor_unit, interactable_unit, data, config, dt, t)
			return
		end,
		stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
			data.start_time = nil

			Unit.animation_event(interactor_unit, "interaction_end")

			local owner_player = Managers.player:unit_owner(interactor_unit)

			if result == InteractionResult.SUCCESS then
				if owner_player and not owner_player.remote then
					local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
					local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
					local _, procced = buff_extension:apply_buffs_to_value(0, StatBuffIndex.NOT_CONSUME_MEDPACK)

					if not procced then
						local interactor_data = data.interactor_data
						local item_slot_name = interactor_data.item_slot_name
						local slot_data = inventory_extension:get_slot_data(item_slot_name)

						if slot_data then
							local template = inventory_extension:get_item_template(slot_data)

							if (template.can_heal_self and interactor_unit == interactable_unit) or (template.can_heal_other and interactor_unit ~= interactable_unit) then
								local ammo_extension = inventory_extension:get_item_slot_extension(item_slot_name, "ammo_system")

								ammo_extension:use_ammo(1)
							end
						end
					else
						inventory_extension:wield_previous_weapon()
					end
				end

				local interactable_dialogue_input = ScriptUnit.extension_input(interactable_unit, "dialogue_system")
				local event_data = FrameTable.alloc_table()
				event_data.healer = interactor_unit
				event_data.healer_name = ScriptUnit.extension(interactor_unit, "dialogue_system").context.player_profile

				interactable_dialogue_input:trigger_dialogue_event("heal_completed", event_data)
				StatisticsUtil.register_heal(interactor_unit, interactable_unit, data.statistics_db)
			end
		end,
		get_progress = function (data, config, t)
			if config.duration == 0 then
				return 0
			end

			return (data.start_time == nil and 0) or math.min(1, (t - data.start_time) / config.duration)
		end,
		can_interact = function (interactor_unit, interactable_unit, data, config)
			if not ScriptUnit.has_extension(interactable_unit, "damage_system") then
				return false
			end

			if not ScriptUnit.has_extension(interactable_unit, "status_system") then
				return false
			end

			local owner_player = Managers.player:unit_owner(interactor_unit)
			local is_bot = owner_player and owner_player.bot_player
			local health_extension = ScriptUnit.extension(interactable_unit, "health_system")
			local status_extension = ScriptUnit.extension(interactable_unit, "status_system")
			local is_alive = health_extension:is_alive() and not status_extension:is_knocked_down()
			local has_max_health = health_extension:current_health_percent() == 1
			local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
			local item_template = inventory_extension:get_wielded_slot_item_template()

			if not item_template then
				return false
			end

			local interactor_has_medpack = item_template.can_heal_other

			return interactor_has_medpack and is_alive and not has_max_health
		end,
		set_interactor_data = function (interactor_unit, interactable_unit, interactor_data)
			local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
			local wielded_slot_name = inventory_extension:get_wielded_slot_name()
			interactor_data.item_slot_name = wielded_slot_name
		end,
		hud_description = function (interactable_unit, config)
			if interactable_unit == nil then
				return "interact_heal_self"
			else
				return "interact_heal_ally"
			end
		end,
		camera_node = function (interactor_unit, interactable_unit)
			if interactor_unit == interactable_unit then
				return "heal_self"
			else
				return "heal_other"
			end
		end
	}
}
InteractionDefinitions.linker_transportation_unit = InteractionDefinitions.linker_transportation_unit or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.linker_transportation_unit.config.swap_to_3p = false

InteractionDefinitions.linker_transportation_unit.client.hud_description = function (interactable_unit, config, key_tail)
	local key = "hud_description" .. ((key_tail and "_" .. key_tail) or "")

	return Unit.get_data(interactable_unit, "interaction_data", key)
end

InteractionDefinitions.linker_transportation_unit.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS then
		if Unit.get_data(interactable_unit, "interaction_data", "only_once") then
			Unit.set_data(interactable_unit, "interaction_data", "used", true)
		end

		local transportation_extension = ScriptUnit.extension(interactable_unit, "transportation_system")

		transportation_extension:interacted_with(interactor_unit)
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

local player_units = {}

InteractionDefinitions.linker_transportation_unit.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	local transport_extension = ScriptUnit.extension(interactable_unit, "transportation_system")
	local can_interact = transport_extension:can_interact(interactor_unit)
	local used = Unit.get_data(interactable_unit, "interaction_data", "used")

	if used or not can_interact then
		return false
	end

	local units_inside_oobb = transport_extension.units_inside_oobb

	if units_inside_oobb then
		if units_inside_oobb.ai.count > 0 then
			return false, "enemies_inside"
		end

		local humans_inside = units_inside_oobb.human.count
		local alive_players = 0
		local PLAYER_UNITS = PLAYER_UNITS
		local ScriptUnit_extension = ScriptUnit.extension
		local num_player_units = #PLAYER_UNITS

		for i = 1, num_player_units, 1 do
			local player_unit = PLAYER_UNITS[i]
			local health_extension = ScriptUnit_extension(player_unit, "health_system")
			local status_extension = ScriptUnit_extension(player_unit, "status_system")

			if health_extension:is_alive() and not status_extension:is_ready_for_assisted_respawn() then
				alive_players = alive_players + 1
			end
		end

		if humans_inside < alive_players then
			return false, "players_missing"
		end
	end

	return true
end

InteractionDefinitions.door = InteractionDefinitions.door or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.door.config.swap_to_3p = false
InteractionDefinitions.door.config.block_other_interactions = true
InteractionDefinitions.door.config.allow_movement = true

InteractionDefinitions.door.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS then
		local door_extension = ScriptUnit.extension(interactable_unit, "door_system")

		door_extension:interacted_with(interactor_unit)
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.door.client.hud_description = function (interactable_unit, config)
	local door_extension = ScriptUnit.extension(interactable_unit, "door_system")

	if door_extension:is_open() then
		return "close"
	end

	return "interact_open_door"
end

local pickup_params = {}
InteractionDefinitions.chest = InteractionDefinitions.chest or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.chest.config.swap_to_3p = false
InteractionDefinitions.chest.config.block_other_interactions = true
InteractionDefinitions.chest.config.allow_movement = true

InteractionDefinitions.chest.client.start = function (world, interactor_unit, interactable_unit, data, config, t)
	data.start_time = t
	local duration = Unit.get_data(interactable_unit, "interaction_data", "interaction_length")
	data.duration = duration
	local interactor_animation_name = Unit.get_data(interactable_unit, "interaction_data", "interactor_animation")
	local interactor_animation_time_variable = Unit.get_data(interactable_unit, "interaction_data", "interactor_animation_time_variable")
	local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")

	if interactor_animation_name then
		local interactor_animation_time_variable = Unit.animation_find_variable(interactor_unit, interactor_animation_time_variable)

		Unit.animation_set_variable(interactor_unit, interactor_animation_time_variable, duration)
		Unit.animation_event(interactor_unit, interactor_animation_name)
	end

	local interactable_animation_name = Unit.get_data(interactable_unit, "interaction_data", "interactable_animation")
	local interactable_animation_time_variable_name = Unit.get_data(interactable_unit, "interaction_data", "interactable_animation_time_variable")

	if interactable_animation_name then
		local interactable_animation_time_variable = Unit.animation_find_variable(interactable_unit, interactable_animation_time_variable_name)

		Unit.animation_set_variable(interactable_unit, interactable_animation_time_variable, duration)
		Unit.animation_event(interactable_unit, interactable_animation_name)
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", true)
end

InteractionDefinitions.chest.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	local success = result == InteractionResult.SUCCESS

	if success then
		Managers.player:statistics_db():increment_stat("session", "chests_opened")
	end

	InteractionDefinitions.smartobject.client.stop(world, interactor_unit, interactable_unit, data, config, t, result)
end

InteractionDefinitions.chest.server.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil
	local success = result == InteractionResult.SUCCESS
	local can_spawn_dice = Unit.get_data(interactable_unit, "can_spawn_dice")

	if can_spawn_dice then
		table.clear(pickup_params)

		local pickup_name = "loot_die"
		local dice_keeper = data.dice_keeper
		local pickup_settings = AllPickups[pickup_name]
		pickup_params.dice_keeper = dice_keeper

		if success and pickup_settings.can_spawn_func(pickup_params) then
			local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")
			local rand = math.random()
			local chance = dice_keeper:chest_loot_dice_chance()
			chance = buff_extension:apply_buffs_to_value(chance, StatBuffIndex.INCREASE_LUCK)

			if rand < chance then
				local extension_init_data = {
					pickup_system = {
						has_physics = true,
						spawn_type = "rare",
						pickup_name = pickup_name
					}
				}
				local unit_name = pickup_settings.unit_name
				local unit_template_name = pickup_settings.unit_template_name or "pickup_unit"
				local position = Unit.local_position(interactable_unit, 0) + Vector3(0, 0, 0.3)
				local rotation = Unit.local_rotation(interactable_unit, 0)

				Managers.state.unit_spawner:spawn_network_unit(unit_name, unit_template_name, extension_init_data, position, rotation)
				dice_keeper:bonus_dice_spawned()
			end
		end
	end

	local pickup_name = "event_item"
	local pickup_settings = AllPickups[pickup_name]

	if pickup_settings.can_spawn_func() then
		local extension_init_data = {
			pickup_system = {
				has_physics = true,
				spawn_type = "rare",
				pickup_name = pickup_name
			}
		}
		local unit_name = pickup_settings.unit_name
		local unit_template_name = pickup_settings.unit_template_name or "pickup_unit"
		local position = Unit.local_position(interactable_unit, 0) + Vector3(0, 0, 0.3)
		local rotation = Unit.local_rotation(interactable_unit, 0)

		Managers.state.unit_spawner:spawn_network_unit(unit_name, unit_template_name, extension_init_data, position, rotation)
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.inventory_access = InteractionDefinitions.inventory_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.inventory_access.config.swap_to_3p = false

InteractionDefinitions.inventory_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	return true
end

InteractionDefinitions.inventory_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS and Unit.get_data(interactable_unit, "interaction_data", "only_once") then
		Unit.set_data(interactable_unit, "interaction_data", "used", true)
	end

	if not data.is_husk then
		data.ingame_ui:transition_with_fade("inventory_view_force")
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.prestige_access = InteractionDefinitions.prestige_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.prestige_access.config.swap_to_3p = false

InteractionDefinitions.prestige_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	return true
end

InteractionDefinitions.prestige_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS and not data.is_husk then
		data.ingame_ui:transition_with_fade("prestige")
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.prestige_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	return ProgressionUnlocks.can_upgrade_prestige()
end

InteractionDefinitions.forge_access = InteractionDefinitions.forge_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.forge_access.config.swap_to_3p = false

InteractionDefinitions.forge_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS and not data.is_husk then
		data.ingame_ui:transition_with_fade("forge_view_force")
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.forge_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local can_use = ProgressionUnlocks.is_unlocked("forge", level, prestige)

	return can_use
end

InteractionDefinitions.altar_access = InteractionDefinitions.altar_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.altar_access.config.swap_to_3p = false

InteractionDefinitions.altar_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS and not data.is_husk then
		data.ingame_ui:transition_with_fade("altar_view_force")
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.altar_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local can_use = ProgressionUnlocks.is_unlocked("altar", level, prestige)

	return can_use
end

InteractionDefinitions.quest_access = InteractionDefinitions.quest_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.quest_access.config.swap_to_3p = false

InteractionDefinitions.quest_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS and not data.is_husk then
		data.ingame_ui:transition_with_fade("quest_view_force")
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.quest_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	local experience = ScriptBackendProfileAttribute.get("experience")
	local level = ExperienceSettings.get_level(experience)
	local prestige = ScriptBackendProfileAttribute.get("prestige")
	local can_use = ProgressionUnlocks.is_unlocked("quests", level, prestige)

	return can_use, not can_use and "quest_access_locked"
end

InteractionDefinitions.quest_access.client.hud_description = function (interactable_unit, config, fail_reason, interactor_unit)
	if fail_reason and fail_reason == "quest_access_locked" then
		return "dlc1_3_1_interact_open_quests_blocked"
	end

	return Unit.get_data(interactable_unit, "interaction_data", "hud_description")
end

InteractionDefinitions.journal_access = InteractionDefinitions.journal_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.journal_access.config.swap_to_3p = false

InteractionDefinitions.journal_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS and not data.is_husk then
		data.ingame_ui:transition_with_fade("lorebook_view_force")
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.journal_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	return GameSettingsDevelopment.lorebook_enabled
end

InteractionDefinitions.map_access = InteractionDefinitions.map_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.map_access.config.swap_to_3p = false

InteractionDefinitions.map_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	return true
end

InteractionDefinitions.map_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS and not data.is_husk then
		data.ingame_ui:transition_with_fade("map_view_force")
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.brawl_access = InteractionDefinitions.brawl_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.brawl_access.config.swap_to_3p = false

InteractionDefinitions.brawl_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS then
		if not data.is_husk then
			local pickup_settings = Pickups.level_events.brawl_unarmed
			local slot_name = pickup_settings.slot_name
			local item_name = pickup_settings.item_name
			local unit_template, extra_extension_init_data = nil
			local pickup_item_data = ItemMasterList[item_name]
			local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
			local slot_data = inventory_extension:get_slot_data(slot_name)

			inventory_extension:destroy_slot(slot_name)
			inventory_extension:add_equipment(slot_name, pickup_item_data, unit_template, extra_extension_init_data)

			if not LEVEL_EDITOR_TEST then
				local unit_object_id = Managers.state.unit_storage:go_id(interactor_unit)
				local slot_id = NetworkLookup.equipment_slots[slot_name]
				local item_id = NetworkLookup.item_names[item_name]
				local network_manager = Managers.state.network

				if data.is_server then
					network_manager.network_transmit:send_rpc_clients("rpc_add_equipment", unit_object_id, slot_id, item_id)
				else
					network_manager.network_transmit:send_rpc_server("rpc_add_equipment", unit_object_id, slot_id, item_id)
				end

				if slot_data then
					local drop_item_data = slot_data.item_data
					local item_template = BackendUtils.get_item_template(drop_item_data)
					local pickup_data = item_template.pickup_data

					if pickup_data then
						local position = POSITION_LOOKUP[interactable_unit]
						local rotation = Unit.local_rotation(interactable_unit, 0)
						local pickup_spawn_type = "dropped"
						local pickup_name = pickup_data.pickup_name
						local pickup_name_id = NetworkLookup.pickup_names[pickup_name]
						local pickup_spawn_type_id = NetworkLookup.pickup_spawn_types[pickup_spawn_type]

						network_manager.network_transmit:send_rpc_server("rpc_spawn_pickup", pickup_name_id, position, rotation, pickup_spawn_type_id)
					end
				end

				local wielded_slot_name = inventory_extension:get_wielded_slot_name()

				if pickup_settings.wield_on_pickup or wielded_slot_name == slot_name then
					CharacterStateHelper.stop_weapon_actions(inventory_extension, "picked_up_object")
					inventory_extension:wield(slot_name)
				end
			end
		end

		Unit.set_data(interactable_unit, "interaction_data", "being_used", true)
		LevelHelper:flow_event(world, "pub_brawl_fetch_new_beer")
	end
end

InteractionDefinitions.brawl_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	local used = Unit.get_data(interactable_unit, "interaction_data", "used")
	local being_used = Unit.get_data(interactable_unit, "interaction_data", "being_used")
	local buff_extension = ScriptUnit.extension(interactor_unit, "buff_system")

	return not being_used and not used and not buff_extension:has_buff_type("brawl_drunk")
end

InteractionDefinitions.unlock_key_access = InteractionDefinitions.unlock_key_access or table.clone(InteractionDefinitions.smartobject)
InteractionDefinitions.unlock_key_access.config.swap_to_3p = false

InteractionDefinitions.unlock_key_access.client.stop = function (world, interactor_unit, interactable_unit, data, config, t, result)
	data.start_time = nil

	if result == InteractionResult.SUCCESS and not data.is_husk then
		data.ingame_ui:transition_with_fade("unlock_key_force")
	end

	Unit.set_data(interactable_unit, "interaction_data", "being_used", false)
end

InteractionDefinitions.unlock_key_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	return true
end

InteractionDefinitions.map_access.client.can_interact = function (interactor_unit, interactable_unit, data, config)
	local active = Unit.get_data(interactable_unit, "interaction_data", "active")
	local used = Unit.get_data(interactable_unit, "interaction_data", "used")

	return not used and active
end

for k, v in pairs(InteractionDefinitions) do
	if v.client.camera_node == nil then
		v.client.camera_node = function ()
			return k
		end
	end

	if v.client.hud_description == nil then
		v.client.hud_description = function ()
			return "interact_" .. k
		end
	end
end

return
