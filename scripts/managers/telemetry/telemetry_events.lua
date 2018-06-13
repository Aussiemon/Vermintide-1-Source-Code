require("scripts/managers/telemetry/telemetry_settings")

local function timestamp()
	return os.time(os.date("!*t"))
end

TelemetryEvents = class(TelemetryEvents)

TelemetryEvents.init = function (self, manager)
	self.manager = manager
end

local params = {}

TelemetryEvents.header = function (self, engine_revision, content_revision)
	table.clear(params)

	params.version = TelemetrySettings.version
	params.created_at = timestamp()
	params.platform = PLATFORM
	params.engine_revision = engine_revision
	params.content_revision = content_revision

	self.manager:register_event("header", params)
end

TelemetryEvents.game_started = function (self, is_server, level_key, difficulty)
	table.clear(params)

	params.is_server = is_server == true
	params.level_key = level_key
	params.difficulty = difficulty

	self.manager:register_event("game_started", params)
end

TelemetryEvents.round_started = function (self)
	table.clear(params)
	self.manager:register_event("round_started", params)
end

TelemetryEvents.game_ended = function (self, player, is_server, level_key, difficulty, reason)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.is_server = is_server == true
	params.level_key = level_key
	params.difficulty = difficulty
	params.end_reason = reason

	self.manager:register_event("game_ended", params)
end

TelemetryEvents.session_id = function (self, session_id)
	table.clear(params)

	params.session_id = session_id

	self.manager:register_event("session_id", params)
end

TelemetryEvents.ai_death = function (self, breed, position)
	table.clear(params)

	params.breed = breed
	params.position = position

	self.manager:register_event("ai_death", params)
end

TelemetryEvents.ai_spawn = function (self, breed, position)
	table.clear(params)

	params.breed = breed
	params.position = position

	self.manager:register_event("ai_spawn", params)
end

TelemetryEvents.ai_despawn = function (self, breed, position, reason)
	table.clear(params)

	params.breed = breed
	params.position = position
	params.reason = reason or "unknown"

	self.manager:register_event("ai_despawn", params)
end

TelemetryEvents.contract_progress = function (self, player, contract, old_progress, new_progress, goal_progress, completed, level_key, requirement_difficulty, played_difficulty)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.contract = contract
	params.old_progress = old_progress
	params.new_progress = new_progress
	params.goal_progress = goal_progress
	params.completed = completed
	params.level_key = level_key
	params.requirement_difficulty = requirement_difficulty
	params.played_difficulty = played_difficulty

	self.manager:register_event("contract_progress", params)
end

TelemetryEvents.fatigue_gain = function (self, player, position, fatigue_type, block_breaking)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.position = position
	params.fatigue_type = fatigue_type
	params.block_breaking = block_breaking

	self.manager:register_event("fatigue_gain", params)
end

TelemetryEvents.matchmaking_connection = function (self, player, connection_state, time_taken)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.connection_state = connection_state
	params.time_taken = time_taken

	self.manager:register_event("matchmaking_connection", params)
end

TelemetryEvents.matchmaking_map_done = function (self, player, level_key, difficulty, privacy_setting, nr_level_switches)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.level_key = level_key
	params.difficulty = difficulty
	params.privacy_setting = privacy_setting
	params.nr_level_switches = nr_level_switches

	self.manager:register_event("matchmaking_map_done", params)
end

TelemetryEvents.matchmaking_starting_game = function (self, player, nr_friends)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.nr_friends = nr_friends

	self.manager:register_event("matchmaking_starting_game", params)
end

TelemetryEvents.next_level_vote = function (self, player, vote)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.vote = vote

	self.manager:register_event("next_level_vote", params)
end

TelemetryEvents.pickup_spawned = function (self, pickup_name, spawn_type, position)
	table.clear(params)

	params.pickup_name = pickup_name
	params.spawn_type = spawn_type
	params.position = position

	self.manager:register_event("pickup_spawned", params)
end

TelemetryEvents.pickup_destroyed = function (self, pickup_name, spawn_type, position)
	table.clear(params)

	params.pickup_name = pickup_name
	params.spawn_type = spawn_type
	params.position = position

	self.manager:register_event("pickup_destroyed", params)
end

TelemetryEvents.player_ammo_depleted = function (self, player, weapon_name, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.weapon_name = weapon_name
	params.position = position

	self.manager:register_event("player_ammo_depleted", params)
end

TelemetryEvents.player_ammo_refilled = function (self, player, weapon_name, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.weapon_name = weapon_name
	params.position = position

	self.manager:register_event("player_ammo_refilled", params)
end

TelemetryEvents.player_damage = function (self, player, damage_type, damage_source, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.damage_type = damage_type
	params.damage_source = damage_source
	params.position = position

	self.manager:register_event("player_damage", params)
end

TelemetryEvents.player_death = function (self, player, damage_type, damage_source, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.damage_type = damage_type
	params.damage_source = damage_source
	params.position = position

	self.manager:register_event("player_death", params)
end

TelemetryEvents.player_experience_gain = function (self, player, gained_experience)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.gained_experience = gained_experience

	self.manager:register_event("player_experience_gain", params)
end

TelemetryEvents.player_heal_ally = function (self, healer, target, position)
	table.clear(params)

	params.healer_player_id = healer:telemetry_id()
	params.healer_hero = healer:profile_display_name()
	params.target_player_id = target:telemetry_id()
	params.target_hero = target:profile_display_name()
	params.position = position

	self.manager:register_event("player_heal_ally", params)
end

TelemetryEvents.player_heal_self = function (self, player, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.position = position

	self.manager:register_event("player_heal_self", params)
end

TelemetryEvents.player_jump = function (self, player, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.position = position

	self.manager:register_event("player_jump", params)
end

TelemetryEvents.player_killed_ai = function (self, player, player_position, victim_position, breed, weapon_name, damage_type, hit_zone)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.is_bot = player.bot_player == true
	params.player_position = player_position
	params.victim_position = victim_position
	params.breed = breed
	params.weapon_name = weapon_name
	params.damage_type = damage_type
	params.hit_zone = hit_zone

	self.manager:register_event("player_killed_ai", params)
end

TelemetryEvents.player_knocked_down = function (self, player, damage_type, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.is_bot = player.bot_player == true
	params.damage_type = damage_type
	params.position = position

	self.manager:register_event("player_knocked_down", params)
end

TelemetryEvents.player_pickup = function (self, player, pickup_name, pickup_spawn_type, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.pickup_name = pickup_name
	params.pickup_spawn_type = pickup_spawn_type
	params.position = position

	self.manager:register_event("player_pickup", params)
end

TelemetryEvents.player_revive = function (self, reviver, revivee, position)
	table.clear(params)

	params.reviver_player_id = reviver:telemetry_id()
	params.reviver_hero = reviver:profile_display_name()
	params.revivee_player_id = revivee:telemetry_id()
	params.revivee_hero = revivee:profile_display_name()
	params.position = position

	self.manager:register_event("player_revive", params)
end

TelemetryEvents.player_spawn = function (self, player, peer_type)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.peer_type = peer_type

	self.manager:register_event("player_spawn", params)
end

TelemetryEvents.player_use_item = function (self, player, item_name, position)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.item_name = item_name
	params.position = position

	self.manager:register_event("player_use_item", params)
end

TelemetryEvents.session_rating = function (self, player, session_rating)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.session_rating = session_rating

	self.manager:register_event("session_rating", params)
end

TelemetryEvents.tech_performance = function (self, player, position, look_yaw, fps, ping)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()
	params.position = position
	params.look_yaw = look_yaw
	params.fps = fps
	params.ping = ping

	self.manager:register_event("tech_performance", params)
end

TelemetryEvents.tech_settings = function (self, resolution, graphics_quality, screen_mode)
	table.clear(params)

	params.resolution = resolution
	params.graphics_quality = graphics_quality
	params.screen_mode = screen_mode

	self.manager:register_event("tech_settings", params)
end

TelemetryEvents.tech_system = function (self, system_info, adapter_index)
	table.clear(params)

	params.system_info = system_info
	params.adapter_index = adapter_index

	self.manager:register_event("tech_system", params)
end

TelemetryEvents.ui_invite_sent = function (self, player)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()

	self.manager:register_event("ui_invite_sent", params)
end

TelemetryEvents.ui_join_game = function (self, player)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.hero = player:profile_display_name()

	self.manager:register_event("ui_join_game", params)
end

TelemetryEvents.ui_matchmaking_select_player = function (self, player, selected_hero, reason, time_taken)
	table.clear(params)

	params.player_id = player:telemetry_id()
	params.current_hero = player:profile_display_name()
	params.selected_hero = selected_hero
	params.reason = reason
	params.time_taken = time_taken

	self.manager:register_event("ui_matchmaking_select_player", params)
end

TelemetryEvents.vo_play_event = function (self, sound_event, dialogue, unit_name)
	table.clear(params)

	params.sound_event = sound_event
	params.dialogue = dialogue
	params.unit_name = unit_name

	self.manager:register_event("vo_play_event", params)
end

TelemetryEvents.level_progression = function (self, percent)
	table.clear(params)

	params.percent = percent

	self.manager:register_event("level_progression", params)
end

TelemetryEvents.memory_statistics = function (self, memory_tree, memory_resources)
	table.clear(params)

	params.memory_tree = memory_tree
	params.memory_resources = memory_resources

	self.manager:register_event("memory_statistics", params)
end

return
