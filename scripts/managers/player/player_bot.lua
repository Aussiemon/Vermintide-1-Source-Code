require("scripts/managers/player/bulldozer_player")

PlayerBot = class(PlayerBot, BulldozerPlayer)
local BOT_COLORS = {
	bright_wizard = QuaternionBox(255, 255, 127, 0),
	witch_hunter = QuaternionBox(255, 255, 215, 0),
	dwarf_ranger = QuaternionBox(255, 125, 125, 200),
	wood_elf = QuaternionBox(255, 50, 205, 50),
	empire_soldier = QuaternionBox(255, 220, 20, 60)
}

PlayerBot.init = function (self, player_name, bot_profile_name, is_server, profile_index, local_player_id, unique_id)
	self.player_name = player_name
	self.bot_profile = PlayerBots[bot_profile_name]
	self.profile_index = profile_index
	self.game_object_id = nil
	self.owned_units = {}
	self.bot_player = true
	self.is_server = is_server
	self.peer_id = Network.peer_id()
	self.color = BOT_COLORS[player_name]
	self.viewport_name = player_name
	local profile = SPProfiles[self.profile_index]
	self.character_name = Localize(profile.character_name)
	self.bot_telemetry_id = "Bot_" .. profile.display_name
	self._local_player_id = local_player_id
	self._unique_id = unique_id
end

PlayerBot.stats_id = function (self)
	return self._unique_id
end

PlayerBot.ui_id = function (self)
	return self._unique_id
end

PlayerBot.local_player_id = function (self)
	return self._local_player_id
end

PlayerBot.platform_id = function (self)
	assert(false)
end

PlayerBot.type = function (self)
	return "PlayerBot"
end

PlayerBot.is_player_controlled = function (self)
	return false
end

PlayerBot.profile_display_name = function (self)
	local profile = SPProfiles[self.profile_index]
	local display_name = profile and profile.display_name

	return display_name
end

PlayerBot.name = function (self)
	return self.character_name
end

PlayerBot.telemetry_id = function (self)
	return self.bot_telemetry_id
end

PlayerBot.spawn = function (self, position, rotation, is_initial_spawn, ammo_melee, ammo_ranged, healthkit, potion, grenade)
	local profile_index = self.profile_index
	local profile = SPProfiles[profile_index]

	fassert(profile, "[SpawnManager] Trying to spawn with profile %q that doesn't exist in %q.", profile_index, "SPProfiles")

	local nav_world = Managers.state.entity:system("ai_system"):nav_world()
	local difficulty_manager = Managers.state.difficulty
	local difficulty_settings = difficulty_manager:get_difficulty_settings()
	local player_health = difficulty_settings.max_hp
	local player_wounds = difficulty_settings.wounds
	local character_state_class_list = {
		PlayerCharacterStateDead,
		PlayerCharacterStateInteracting,
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
	local initial_inventory = self:_get_initial_inventory(healthkit, potion, grenade)
	local extension_init_data = {
		ai_system = {
			player = self,
			bot_profile = self.bot_profile,
			nav_world = nav_world
		},
		input_system = {
			player = self
		},
		character_state_machine_system = {
			start_state = "standing",
			nav_world = nav_world,
			character_state_class_list = character_state_class_list,
			player = self
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
		locomotion_system = {
			player = self
		},
		camera_system = {
			player = self
		},
		dialogue_context_system = {
			profile = profile
		},
		dialogue_system = {
			faction = "player",
			wwise_voice_switch_group = "character",
			profile = profile,
			wwise_voice_switch_value = profile.character_vo
		},
		first_person_system = {
			profile = profile
		},
		ai_navigation_system = {
			nav_world = nav_world
		},
		aim_system = {
			is_husk = false,
			template = "player"
		},
		attachment_system = {
			profile = profile,
			player = self
		},
		buff_system = {
			is_husk = false
		},
		statistics_system = {
			template = "player",
			statistics_id = self.peer_id
		},
		ai_slot_system = {
			profile_index = profile_index
		}
	}
	local unit_template_name = "player_bot_unit"
	local skin_settings = Managers.unlock:get_skin_settings(profile.display_name)
	local unit_name = skin_settings.units.third_person.third_person_bot
	local spawn_data = {
		unit_template_name = unit_template_name,
		unit_name = unit_name,
		extension_init_data = extension_init_data
	}
	local unit = Managers.state.spawn:spawn_unit(spawn_data, position, rotation)

	ScriptUnit.extension(unit, "attachment_system"):show_attachments(true)
	Unit.set_data(unit, "sound_character", profile.sound_character)
	Unit.create_actor(unit, "bot_collision", false)

	if self.is_server then
		Managers.telemetry.events:player_spawn(self, "host")
	end

	local level_settings = LevelHelper:current_level_settings()

	if level_settings.climate_type then
		Unit.set_flow_variable(unit, "climate_type", level_settings.climate_type)
		Unit.flow_event(unit, "climate_type_set")
	end

	return unit
end

PlayerBot.create_game_object = function (self)
	local game_object_data_table = {
		ping = 0,
		player_controlled = false,
		go_type = NetworkLookup.go_types.player,
		network_id = self:network_id(),
		local_player_id = self:local_player_id()
	}
	local callback = callback(self, "cb_game_session_disconnect")
	local game_object_id = Managers.state.network:create_player_game_object("bot_player", game_object_data_table, callback)
	self.game_object_id = game_object_id
end

PlayerBot.destroy = function (self)
	if self.is_server and self.game_object_id then
		Managers.state.network:destroy_game_object(self.game_object_id)
	end

	self.game_object_id = nil
end

return
