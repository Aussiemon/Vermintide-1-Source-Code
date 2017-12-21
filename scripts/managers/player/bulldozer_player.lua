require("scripts/managers/player/player_boon_handler")
require("scripts/managers/player/boon_templates")

BulldozerPlayer = class(BulldozerPlayer, Player)
BulldozerPlayer.init = function (self, network_manager, input_source, viewport_name, viewport_world_name, is_server, local_player_id, unique_id)
	BulldozerPlayer.super.init(self, network_manager, input_source, viewport_name, viewport_world_name, is_server, local_player_id)

	self.profile_index = 0
	self.local_player = true
	self.game_object_id = nil
	self.camera_follow_unit = nil
	self.player_unit = nil
	local peer_id = Network.peer_id()
	self.peer_id = peer_id
	self._debug_name = "Local #" .. peer_id.sub(peer_id, 1, 3)
	self._local_player_id = local_player_id
	self._unique_id = unique_id
	self.is_server = is_server

	Managers.music:register_active_player(local_player_id)
	Managers.free_flight:register_player(local_player_id)

	self._cached_name = nil

	return 
end
BulldozerPlayer.type = function (self)
	return "BulldozerPlayer"
end
BulldozerPlayer.profile_display_name = function (self)
	local profile = SPProfiles[self.profile_index]
	local display_name = profile and profile.display_name

	return display_name
end
BulldozerPlayer.despawn = function (self)
	local player_unit = self.player_unit

	if Unit.alive(player_unit) then
		REMOVE_PLAYER_UNIT_FROM_LISTS(player_unit)
		Managers.state.unit_spawner:mark_for_deletion(player_unit)
	end

	return 
end
BulldozerPlayer.set_spawn_position_rotation = function (self, position, rotation)
	self.spawn_position = Vector3Box(position)
	self.spawn_rotation = QuaternionBox(rotation)

	return 
end
BulldozerPlayer.spawn = function (self, optional_position, optional_rotation, is_initial_spawn, ammo_melee, ammo_ranged, healthkit, potion, grenade)
	local profile_index = self.profile_index
	local profile = SPProfiles[profile_index]

	fassert(profile, "[SpawnManager] Trying to spawn with profile %q that doesn't exist in %q.", profile_index, "SPProfiles")

	local nav_world = Managers.state.entity:system("ai_system"):nav_world()
	local difficulty_manager = Managers.state.difficulty
	local difficulty_settings = difficulty_manager.get_difficulty_settings(difficulty_manager)
	local player_health = difficulty_settings.max_hp
	local player_wounds = difficulty_settings.wounds

	if self.spawn_position then
		optional_position = self.spawn_position:unbox()
		self.spawn_position = nil
	end

	if self.spawn_rotation then
		optional_rotation = self.spawn_rotation:unbox()
		self.spawn_rotation = nil
	end

	local character_state_class_list = {
		PlayerCharacterStateDead,
		PlayerCharacterStateInteracting,
		PlayerCharacterStateInspecting,
		PlayerCharacterStateJumping,
		PlayerCharacterStateClimbingLadder,
		PlayerCharacterStateLeavingLadderTop,
		PlayerCharacterStateEnterLadderTop,
		PlayerCharacterStateFalling,
		PlayerCharacterStateKnockedDown,
		PlayerCharacterStatePouncedDown,
		PlayerCharacterStateStanding,
		PlayerCharacterStateWalking,
		PlayerCharacterStateDodging,
		PlayerCharacterStateLedgeHanging,
		PlayerCharacterStateLeaveLedgeHangingPullUp,
		PlayerCharacterStateLeaveLedgeHangingFalling,
		PlayerCharacterStateCatapulted,
		PlayerCharacterStateStunned,
		PlayerCharacterStateUsingTransport,
		PlayerCharacterStateGrabbedByPackMaster,
		PlayerCharacterStateWaitingForAssistedRespawn,
		PLayerCharacterStateOverchargeExploding
	}
	local initial_inventory = self._get_initial_inventory(self, healthkit, potion, grenade)
	local extension_init_data = {
		input_system = {
			player = self
		},
		character_state_machine_system = {
			start_state = "standing",
			character_state_class_list = character_state_class_list,
			player = self,
			nav_world = nav_world
		},
		health_system = {
			health = player_health,
			player = self
		},
		status_system = {
			wounds = player_wounds,
			profile_id = profile_index,
			player = self
		},
		hit_reaction_system = {
			is_husk = false,
			hit_reaction_template = "player"
		},
		death_system = {
			death_reaction_template = "player",
			is_husk = false
		},
		inventory_system = {
			profile = profile,
			initial_inventory = initial_inventory,
			player = self,
			ammo_percent = {
				slot_melee = ammo_melee,
				slot_ranged = ammo_ranged
			}
		},
		attachment_system = {
			profile = profile,
			player = self
		},
		locomotion_system = {
			player = self
		},
		camera_system = {
			player = self
		},
		first_person_system = {
			profile = profile
		},
		dialogue_context_system = {
			profile = profile
		},
		dialogue_system = {
			local_player = true,
			faction = "player",
			wwise_voice_switch_group = "character",
			profile = profile,
			wwise_voice_switch_value = profile.character_vo
		},
		whereabouts_system = {
			nav_world = nav_world
		},
		aim_system = {
			is_husk = false,
			template = "player"
		},
		buff_system = {
			is_husk = false
		},
		statistics_system = {
			template = "player",
			statistics_id = self.telemetry_id(self)
		},
		ai_slot_system = {
			profile_index = profile_index
		}
	}
	local unit_template_name = nil
	local skin_settings = Managers.unlock:get_skin_settings(profile.display_name)
	local unit_name = skin_settings.units.third_person.third_person
	local spawn_data = {
		unit_template_name = unit_template_name,
		unit_name = unit_name,
		extension_init_data = extension_init_data
	}
	local spawn_manager = Managers.state.spawn
	local unit = spawn_manager.spawn_unit(spawn_manager, spawn_data, optional_position, optional_rotation)
	local player_manager = Managers.player

	Unit.set_data(unit, "unit_name", profile.unit_name)

	local world = spawn_manager.world

	LevelHelper:set_flow_parameter(world, "local_player_profile_name", profile.display_name)
	Unit.set_data(unit, "sound_character", profile.sound_character)
	Unit.create_actor(unit, "human_collision", false)

	local is_player_unit = true

	player_manager.assign_unit_ownership(player_manager, unit, self, is_player_unit)
	Managers.state.event:trigger("level_start_local_player_spawned", is_initial_spawn)

	local peer_type = (self.is_server and "host") or "client"

	Managers.telemetry.events:player_spawn(self, peer_type)
	Managers.state.event:trigger("camera_teleported")

	return unit
end
BulldozerPlayer.create_boon_handler = function (self, world)
	local backend_settings = GameSettingsDevelopment.backend_settings

	if backend_settings.quests_enabled then
		self.boon_handler = PlayerBoonHandler:new(self, world, self.is_server)
	end

	return 
end
BulldozerPlayer._get_initial_inventory = function (self, healthkit, potion, grenade)
	local initial_inventory = {
		slot_packmaster_claw = "packmaster_claw",
		slot_healthkit = healthkit,
		slot_potion = potion,
		slot_grenade = grenade
	}

	return initial_inventory
end
BulldozerPlayer.create_game_object = function (self)
	local empty_boon_id = NetworkLookup.boons["n/a"]
	local game_object_data_table = {
		boon_poll_time = 0,
		boon_8_remaining_duration = 0,
		boon_9_remaining_duration = 0,
		ping = 0,
		boon_1_remaining_duration = 0,
		boon_2_remaining_duration = 0,
		boon_3_remaining_duration = 0,
		boon_4_remaining_duration = 0,
		boon_5_remaining_duration = 0,
		boon_6_remaining_duration = 0,
		boon_7_remaining_duration = 0,
		boon_10_remaining_duration = 0,
		player_controlled = true,
		go_type = NetworkLookup.go_types.player,
		network_id = self.network_id(self),
		local_player_id = self.local_player_id(self),
		clan_tag = Application.user_setting("clan_tag") or "0",
		boon_1_id = empty_boon_id,
		boon_2_id = empty_boon_id,
		boon_3_id = empty_boon_id,
		boon_4_id = empty_boon_id,
		boon_5_id = empty_boon_id,
		boon_6_id = empty_boon_id,
		boon_7_id = empty_boon_id,
		boon_8_id = empty_boon_id,
		boon_9_id = empty_boon_id,
		boon_10_id = empty_boon_id
	}
	local callback = callback(self, "cb_game_session_disconnect")
	local game_object_id = self.network_manager:create_player_game_object("player", game_object_data_table, callback)
	self.game_object_id = game_object_id

	return 
end
BulldozerPlayer.cb_game_session_disconnect = function (self)
	self.game_object_id = nil

	if self.boon_handler then
		self.boon_handler = nil
	end

	return 
end
BulldozerPlayer.network_id = function (self)
	return self.peer_id
end
BulldozerPlayer.local_player_id = function (self)
	return self._local_player_id
end
BulldozerPlayer.platform_id = function (self)
	return self.peer_id
end
BulldozerPlayer.profile_id = function (self)
	return self._unique_id
end
BulldozerPlayer.ui_id = function (self)
	return self._unique_id
end
BulldozerPlayer.stats_id = function (self)
	return self._unique_id
end
BulldozerPlayer.telemetry_id = function (self)
	return self._unique_id
end
BulldozerPlayer.is_player_controlled = function (self)
	return true
end
BulldozerPlayer.set_game_object_id = function (self, id)
	self.game_object_id = id

	return 
end
BulldozerPlayer.name = function (self)
	if rawget(_G, "Steam") then
		if self._cached_name then
			return self._cached_name
		else
			local clan_tag = ""
			local clan_tag_id = Application.user_setting("clan_tag")

			if clan_tag_id and clan_tag_id ~= "0" then
				clan_tag = tostring(Clans.clan_tag(clan_tag_id)) .. "|"
			end

			local name = clan_tag .. Steam.user_name(self.network_id(self))
			self._cached_name = name

			return name
		end
	elseif Application.platform() == "xb1" or Application.platform() == "ps4" then
		if self._cached_name then
			return self._cached_name
		end

		local name = Managers.state.network:lobby():user_name(self.network_id(self)) or "Remote #" .. tostring(self.peer_id:sub(1, 3))
		self._cached_name = name

		return name
	else
		return self._debug_name
	end

	return 
end
BulldozerPlayer.destroy = function (self)
	if self.is_server and self.game_object_id then
		self.network_manager:destroy_game_object(self.game_object_id)
	end

	Managers.free_flight:unregister_player(self.local_player_id(self))
	Managers.music:unregister_active_player(self._local_player_id)

	self.game_object_id = nil

	return 
end

return 
