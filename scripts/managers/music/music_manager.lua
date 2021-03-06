require("scripts/settings/sound_ducking_settings")
require("scripts/settings/music_settings")
require("scripts/managers/music/music_player")
require("foundation/scripts/util/sound_ducking/ducking_handler")

local function dprint(...)
	if script_data.debug_music then
		print("[MusicManager] ", ...)
	end
end

MusicManager = class(MusicManager)
MusicManager.bus_transition_functions = {
	linear = function (transition, t)
		return math.lerp(transition.start_value, transition.target_value, t)
	end,
	sine = function (transition, t)
		return math.lerp(transition.start_value, transition.target_value, math.sin(t * math.pi * 0.5))
	end,
	smoothstep = function (transition, t)
		return math.lerp(transition.start_value, transition.target_value, math.smoothstep(t, 0, 1))
	end
}
MusicManager.panning_rules = {
	PANNING_RULE_SPEAKERS = 0,
	PANNING_RULE_HEADPHONES = 1
}

MusicManager.init = function (self)
	self._world = Managers.world:create_world("music_world", nil, nil, nil, Application.DISABLE_PHYSICS, Application.DISABLE_RENDERING)
	self._wwise_world = Managers.world:wwise_world(self._world)

	ScriptWorld.deactivate(self._world)

	self._music_players = {}
	self._bus_transitions = {}
	self._flags = {}
	self._game_state = nil
	self._game_object_id = nil
	local master_bus_volume = Application.user_setting("master_bus_volume")

	if master_bus_volume ~= nil then
		self:set_master_volume(master_bus_volume)
	end

	local music_bus_volume = Application.user_setting("music_bus_volume")

	if music_bus_volume ~= nil then
		self:set_music_volume(music_bus_volume)
	end

	local sound_panning_rule = Application.user_setting("sound_panning_rule")

	if sound_panning_rule ~= nil then
		local rule = (sound_panning_rule == "headphones" and "PANNING_RULE_HEADPHONES") or "PANNING_RULE_SPEAKERS"

		self:set_panning_rule(rule)
	end
end

MusicManager.stop_all_sounds = function (self)
	dprint("stop_all_sounds")
	self._wwise_world:stop_all()
end

MusicManager.trigger_event = function (self, event_name)
	dprint("trigger_event", event_name)

	local wwise_world = self._wwise_world
	local wwise_playing_id, wwise_source_id = WwiseWorld.trigger_event(wwise_world, event_name)

	return wwise_playing_id, wwise_source_id
end

MusicManager.update = function (self, dt, t)
	self:_update_flag_in_combat()
	self:_update_combat_intensity()
	self:_update_boss_state(dt, t)
	self:_update_game_state(dt, t)
	self:_update_player_state(dt, t)
	self:_update_flags()

	local flags = self._flags

	for _, player in pairs(self._music_players) do
		player:update(flags, self._game_object_id)
	end
end

MusicManager.on_enter_level = function (self, network_event_delegate, is_server)
	self:set_flag("in_level", true)
	self:_setup_level_music_players()

	self._network_event_delegate = network_event_delegate

	network_event_delegate:register(self, "rpc_change_music_state")

	if is_server then
		local go_type = NetworkLookup.go_types.music_states
		local intensity_state_id = NetworkLookup.music_group_states.low_battle
		local game_state_id = NetworkLookup.music_group_states.explore
		local boss_state_id = NetworkLookup.music_group_states.no_boss
		local init_data = {
			go_type = go_type,
			combat_intensity = intensity_state_id,
			game_state = game_state_id,
			boss_state = boss_state_id
		}
		local session = Managers.state.network.game_session

		fassert(not self._game_object_id, "Creating game object when already exists")

		self._game_object_id = Managers.state.network:create_game_object("music_states", init_data, function (game_object_id)
			self:server_game_session_disconnect_music_states(game_object_id)
		end)
	end

	self._is_server = is_server
end

MusicManager.on_exit_level = function (self)
	dprint("on_exit_level")
	self:_reset_level_music_players()
	self._network_event_delegate:unregister(self)

	self._network_event_delegate = nil

	self:set_flag("in_level", false)

	self._is_server = false
end

MusicManager.client_game_session_disconnect_music_states = function (self, game_object_id)
	return
end

MusicManager.server_game_session_disconnect_music_states = function (self, game_object_id)
	self:game_object_destroyed(game_object_id, self._owner_id, self._go_template)
end

MusicManager.game_object_created = function (self, game_object_id, owner_id, go_template)
	self._game_object_id = game_object_id
	self._owner_id = owner_id
	self._go_template = go_template
end

MusicManager.game_object_destroyed = function (self, game_object_id, owner_id, go_template)
	local platform = PLATFORM

	if platform ~= "win32" then
		if self._game_object_id ~= game_object_id or self._owner_id ~= owner_id then
			Application.warning("[MusicManager:game_object_destroyed()] Tearing down music sync game object broken.")
		end
	else
		fassert(self._game_object_id == game_object_id and self._owner_id == owner_id, "Tearing down music sync game object broken.")
	end

	self._game_object_id = nil
	self._owner_id = nil
	self._go_template = nil
end

MusicManager._update_flags = function (self)
	self:set_flag("combat_music_enabled", not script_data.debug_disable_combat_music)

	local game_object_id = self._game_object_id

	if self._is_server or not game_object_id then
		return
	end

	local session = Managers.state.network:game()

	for flag, _ in pairs(SyncedMusicFlags) do
		local value = GameSession.game_object_field(session, game_object_id, flag)

		self:set_flag(flag, value)
	end
end

MusicManager.rpc_change_music_state = function (self, peer, music_state, enabled)
	local flag = NetworkLookup.music_states[music_state]

	self:set_flag(flag, enabled)
end

MusicManager.set_flag = function (self, flag, value)
	if self._flags[flag] == value then
		return
	end

	dprint("set_flag", flag, value)

	self._flags[flag] = value

	if self._is_server and SyncedMusicGroupFlags[flag] then
		local session = Managers.state.network:game()

		GameSession.set_game_object_field(session, self._game_object_id, flag, value)
	end
end

MusicManager._setup_level_music_players = function (self)
	local music_configs = MusicSettings

	for config_name, config in pairs(music_configs) do
		if config.ingame_only then
			local start = config.start_event
			local stop = config.stop
			local set_flags = config.set_flags
			local unset_flags = config.unset_flags
			local parameters = config.parameters
			local groups = config.default_group_states
			local game_state_voice_thresholds = config.game_state_voice_thresholds
			local player = MusicPlayer:new(self._wwise_world, start, stop, config_name, set_flags, unset_flags, parameters, groups, game_state_voice_thresholds)
			self._music_players[config_name] = player
		end
	end
end

MusicManager._reset_level_music_players = function (self)
	local music_configs = MusicSettings

	for config_name, config in pairs(music_configs) do
		if config.ingame_only then
			local player = self._music_players[config_name]

			if player then
				player:destroy()

				self._music_players[config_name] = nil
			end
		end
	end
end

MusicManager._number_of_aggroed_enemies = function (self)
	local ai_slot_system = Managers.state.entity:system("ai_slot_system")
	local total_slots_count = ai_slot_system.total_slots_count

	return total_slots_count
end

MusicManager._update_flag_in_combat = function (self)
	local conflict = Managers.state.conflict

	if not conflict then
		return
	end

	local num_aggroed_enemies = self:_number_of_aggroed_enemies()
	local pacing = conflict.pacing
	local intensity = pacing.total_intensity
	local in_combat = CombatMusic.minimum_enemies < num_aggroed_enemies and CombatMusic.minimum_intensity < intensity

	self:set_flag("in_combat", in_combat)
end

MusicManager._update_combat_intensity = function (self)
	local conflict = Managers.state.conflict

	if not conflict then
		return
	end

	if not self._flags.in_combat then
		return
	end

	local pacing = conflict.pacing
	local intensity = pacing.total_intensity
	local highest_state = nil

	for _, data in ipairs(IntensityThresholds) do
		if data.threshold < intensity then
			highest_state = data.state
		end
	end

	if highest_state then
		self:set_music_group_state("combat_music", "combat_intensity", highest_state)
	end
end

MusicManager._update_boss_state = function (self, dt, t)
	local music_player = self._music_players.combat_music

	if music_player and self._is_server then
		local conflict_director = Managers.state.conflict
		local rat_ogre = conflict_director:count_units_by_breed("skaven_rat_ogre") > 0
		local storm_vermin_patrol = false
		local ai_groups = Managers.state.entity:system("ai_group_system").groups

		for _, group in pairs(ai_groups) do
			if group.template == "storm_vermin_formation_patrol" and group.state == "in_combat" then
				storm_vermin_patrol = true
			end
		end

		local state = nil

		if rat_ogre then
			state = "rat_ogre"
		elseif storm_vermin_patrol then
			state = "storm_vermin_patrol"
		else
			state = "no_boss"
		end

		self:set_music_group_state("combat_music", "boss_state", state)
	end
end

MusicManager._update_game_state = function (self, dt, t)
	local music_player = self._music_players.combat_music

	if music_player and self._is_server then
		local state = nil
		local conflict_director = Managers.state.conflict
		local horde_type = conflict_director:has_horde(t)
		local lost = (Managers.state.game_mode:game_mode().about_to_lose and true) or false
		local won = Managers.state.game_mode:game_won()
		local old_state = self._game_state
		local current_level_settings = LevelHelper:current_level_settings()
		local is_survival = current_level_settings.level_type == "survival"
		local horde_size = conflict_director:horde_size()
		local is_pre_horde = old_state == "pre_horde" or old_state == "pre_ambush"
		local is_horde_alive = (is_survival and horde_size >= 1) or horde_size >= 7 or horde_type

		if lost then
			if is_survival then
				state = "survival_lost"
			else
				state = "lost"
			end
		elseif won then
			local level_settings = LevelHelper:current_level_settings()
			state = (level_settings and level_settings.music_won_state) or "won"
		elseif is_pre_horde and self._scream_delay and self._scream_delay < t then
			self._scream_delay = nil
			state = "horde"
		elseif is_pre_horde and not self._scream_delay and self:_horde_has_engaged(horde_type) then
			if horde_type == "ambush" then
				self:delay_trigger_horde_dialogue(t, t + DialogueSettings.ambush_delay, "ambush")

				self._scream_delay = t + 1.5
				state = old_state
			else
				state = "horde"
			end
		elseif is_pre_horde and is_horde_alive then
			state = old_state
		elseif old_state == "horde" and is_horde_alive then
			state = "horde"
		elseif horde_type == "vector" or horde_type == "event" then
			state = "pre_horde"

			self:delay_trigger_horde_dialogue(t, t + DialogueSettings.vector_delay, "vector")
		elseif horde_type == "ambush" then
			state = "pre_ambush"
		else
			state = "explore"
		end

		self._game_state = state

		self:set_music_group_state("combat_music", "game_state", state)
		self:delay_trigger_horde_dialogue(t)
	end
end

local ai_units = {}

MusicManager._horde_has_engaged = function (self, horde)
	local engage_distance = (horde == "ambush" and 15) or 2
	local pos = nil
	local players = Managers.player:players()

	for _, player in pairs(players) do
		local player_unit = player.player_unit

		if Unit.alive(player_unit) then
			pos = POSITION_LOOKUP[player_unit]
			local num_units = AiUtils.broadphase_query(pos, engage_distance, ai_units)

			for i = 1, num_units, 1 do
				local unit = ai_units[i]
				local ai_extension = ScriptUnit.extension(unit, "ai_system")
				local blackboard = ai_extension:blackboard()
				local spawn_type = blackboard.spawn_type

				if (spawn_type == "horde_hidden" or spawn_type == "horde") and AiUtils.unit_alive(unit) then
					return true
				end
			end
		end
	end

	return false
end

MusicManager._update_player_state = function (self, dt, t)
	local music_player = self._music_players.combat_music
	local local_player_id = self._active_local_player_id

	if music_player and local_player_id then
		local player = Managers.player:local_player(local_player_id)
		local player_unit = player.player_unit

		if Unit.alive(player_unit) then
			local status_ext = ScriptUnit.extension(player_unit, "status_system")
			local state = nil

			if Managers.state.game_mode:game_mode().about_to_lose then
				state = "normal"
			elseif status_ext:is_ready_for_assisted_respawn() then
				state = "normal"
			elseif status_ext:is_dead() then
				state = "dead"
			elseif status_ext:is_knocked_down() then
				state = "knocked_down"
			elseif status_ext:is_disabled() then
				state = "need_help"
			else
				state = "normal"
			end

			music_player:set_group_state("player_state", state)
		else
			music_player:set_group_state("player_state", "normal")
		end
	elseif music_player then
		music_player:set_group_state("player_state", "normal")
	end
end

MusicManager.register_active_player = function (self, player_id)
	fassert(not self._active_local_player_id, "Active player %q already registered!", player_id)

	self._active_local_player_id = player_id
end

MusicManager.unregister_active_player = function (self, player_id)
	fassert(self._active_local_player_id == player_id, "Trying to unregister player %q when player %q is active player", player_id, self._player_id)

	self._active_local_player_id = nil
end

MusicManager.set_music_group_state = function (self, music_player, group, state)
	local game_object_id = self._game_object_id

	if self._is_server and game_object_id then
		local state_id = NetworkLookup.music_group_states[state]
		local session = Managers.state.network:game()

		GameSession.set_game_object_field(session, game_object_id, group, state_id)
	end
end

MusicManager.music_trigger = function (self, music_player, event)
	local player = self._music_players[music_player]

	player:post_trigger(event)
end

MusicManager.set_music_volume = function (self, value)
	WwiseWorld.set_global_parameter(self._wwise_world, "music_bus_volume", value)
end

MusicManager.set_master_volume = function (self, value)
	WwiseWorld.set_global_parameter(self._wwise_world, "master_bus_volume", value)
end

MusicManager.set_panning_rule = function (self, rule)
	fassert(MusicManager.panning_rules[rule] ~= nil, "[MusicManager] Panning rule does not exist: %q", rule)
	Wwise.set_panning_rule(MusicManager.panning_rules[rule])
end

MusicManager.is_playing = function (self, wwise_playing_id)
	return WwiseWorld.is_playing(self._wwise_world, wwise_playing_id)
end

MusicManager.delay_trigger_horde_dialogue = function (self, t, delay, horde_name)
	if delay ~= nil then
		self._horde_delay = delay
		self._horde_type = horde_name
	end

	if self._horde_delay ~= nil and self._horde_delay < t then
		MusicManager:trigger_horde_dialogue(self._horde_type)

		self._horde_delay = nil
		self._horde_type = nil
	end
end

MusicManager.trigger_horde_dialogue = function (self, horde_name)
	local dummy_unit = DialogueSystem:GetRandomPlayer()

	if dummy_unit then
		SurroundingAwareSystem.add_event(dummy_unit, "horde", DialogueSettings.discover_enemy_attack_distance, "horde_type", horde_name)
	end
end

return
