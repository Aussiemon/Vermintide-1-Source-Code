local settings = {
	{
		description = [[
* Open and close menu using right and left keyboard arrows (no gamepad support yet).
		* Use the same keys to 'open' a category.
		* Use CTRL+up/down/left/right for quick-travel and quick-change.
		* Press "F" to add something as a favorite. Press "F" on a favorite to remove it.
		* Press a key on your numpad on a category to assign that key as a hotkey to flip through the options.]],
		bitmap = "hud_debug_screen_logo",
		setting_name = "Debug menu instructions (press right arrow key to open)",
		category = "Allround useful stuff!",
		bitmap_size = 128
	},
	{
		description = "Takes you straight to the menu. Great to combine with auto_host_level.",
		is_boolean = true,
		setting_name = "skip_splash",
		category = "Allround useful stuff!"
	},
	{
		description = "Shows which keys can be used for debug stuff.",
		is_boolean = true,
		setting_name = "debug_key_handler_visible",
		category = "Allround useful stuff!"
	},
	{
		description = "Caps the maximum frame time to 0.2 seconds. Really useful when you're debugging.",
		is_boolean = true,
		setting_name = "disable_long_timesteps",
		category = "Allround useful stuff!"
	},
	{
		setting_name = "teleport player",
		description = "Teleports the player to a portal hub element",
		category = "Allround useful stuff!",
		item_source = {},
		load_items_source_func = function (options)
			table.clear(options)

			local portals = ConflictUtils.get_teleporter_portals()

			for key, boxed_pos in pairs(portals) do
				options[#options + 1] = key
			end

			return 
		end,
		func = function (options, index)
			local local_player = Managers.player:local_player()

			if local_player then
				local player_unit = local_player.player_unit

				if Unit.alive(player_unit) then
					local portals = ConflictUtils.get_teleporter_portals()
					local portal_id = options[index]
					local pos = portals[portal_id]:unbox()
					local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")
					local world = Managers.world:world("level_world")

					LevelHelper:flow_event(world, "teleport_" .. options[index])
					locomotion.teleport_to(locomotion, pos)
				end
			end

			print("TELEPORT")

			return 
		end
	},
	{
		description = "Will change the network pong timeout from 15 seconds to 10000 seconds.",
		is_boolean = true,
		setting_name = "network_timeout_really_long",
		category = "Allround useful stuff!"
	},
	{
		description = "Will disable afk kick",
		is_boolean = true,
		setting_name = "debug_disable_afk_kick",
		category = "Allround useful stuff!"
	},
	{
		description = "Will enable gift popup debug (use F3 to spawn)",
		is_boolean = true,
		setting_name = "debug_gift_popup",
		category = "Allround useful stuff!"
	},
	{
		description = "Will enable buttons for reloading the content and give progress for selected contracts",
		is_boolean = true,
		setting_name = "debug_quest_view",
		category = "Allround useful stuff!"
	},
	{
		description = "Use LAN instead of Steam",
		is_boolean = true,
		setting_name = "use_lan_backend",
		category = "Allround useful stuff!"
	},
	{
		description = "When resetting saves, do not give all items, only items in DefaultLocalBackendData.",
		is_boolean = true,
		setting_name = "dont_give_all_lan_backend_items",
		category = "Allround useful stuff!"
	},
	{
		description = "hide version info hud",
		is_boolean = true,
		setting_name = "hide_version_info",
		category = "Allround useful stuff!"
	},
	{
		description = "hide fps counter hud",
		is_boolean = true,
		setting_name = "hide_fps",
		category = "Allround useful stuff!"
	},
	{
		description = "Will change all true booleans to false, and if there are no true ones, then all will be set to nil (cleared). Press right arrow to do it!",
		category = "Allround useful stuff!",
		setting_name = "reset_settings",
		func = function ()
			DebugScreen.reset_settings()

			return 
		end
	},
	{
		description = "shows the debug lobby broswer in the ingame menu (requires restart)",
		is_boolean = true,
		setting_name = "enable_debug_lobby_browser",
		category = "Allround useful stuff!"
	},
	{
		description = "Requires restart. Gives you all items of a certain rarity",
		setting_name = "all_items_of_rarity",
		category = "Allround useful stuff!",
		item_source = {
			common = true,
			plentiful = true,
			rare = true,
			exotic = true
		}
	},
	{
		description = "Enable leaderboards. Requires restart",
		is_boolean = true,
		setting_name = "use_leaderboards",
		category = "Allround useful stuff!"
	},
	{
		description = "",
		setting_name = "Default development settings",
		category = "Presets",
		preset = {
			skippable_cutscenes = true,
			disable_long_timesteps = true,
			use_lan_backend = true,
			network_timeout_really_long = true,
			skip_splash = true
		}
	},
	{
		description = "",
		setting_name = "Make player imba kthx",
		category = "Presets",
		preset = {
			disable_spread = true,
			player_mechanics_goodness_debug = true,
			infinite_ammo = true,
			disable_gamemode_end = true,
			disable_fatigue_system = true,
			player_invincible = true,
			ledge_hanging_turned_off = true,
			use_super_jumps = true
		}
	},
	{
		description = "",
		setting_name = "No bots or AI spawn",
		category = "Presets",
		preset = {
			ai_mini_patrol_disabled = true,
			ai_critter_spawning_disabled = true,
			ai_horde_spawning_disabled = true,
			ai_roaming_spawning_disabled = true,
			ai_boss_spawning_disabled = true,
			ai_rush_intervention_disabled = true,
			ai_bots_disabled = true,
			ai_specials_spawning_disabled = true,
			ai_pacing_disabled = true,
			ai_outside_navmesh_intervention_disabled = true
		}
	},
	{
		description = "",
		setting_name = "Bots or AI can spawn",
		category = "Presets",
		preset = {
			ai_mini_patrol_disabled = false,
			ai_critter_spawning_disabled = false,
			ai_horde_spawning_disabled = false,
			ai_roaming_spawning_disabled = false,
			ai_boss_spawning_disabled = false,
			ai_rush_intervention_disabled = false,
			ai_bots_disabled = false,
			ai_specials_spawning_disabled = false,
			ai_pacing_disabled = false,
			ai_outside_navmesh_intervention_disabled = false
		}
	},
	{
		description = "",
		setting_name = "QA - General stuff",
		category = "Presets",
		preset = {
			debug_player_position = true,
			paste_revision_to_clipboard = true,
			generate_svn_info = true
		}
	},
	{
		description = "",
		setting_name = "QA-Network/join/sync/matchmaking",
		category = "Presets",
		preset = {
			network_log_messages = true,
			network_debug = true,
			debug_interactions = true,
			package_debug = true,
			matchmaking_debug = true,
			network_debug_connections = true
		}
	},
	{
		description = "",
		setting_name = "QA - Player debug",
		category = "Presets",
		preset = {
			debug_interactions = true,
			debug_player_animations = true,
			debug_state_machines = true
		}
	},
	{
		description = "",
		setting_name = "Screenshot mode",
		category = "Presets",
		preset = {
			disable_info_slate_ui = true,
			disable_debug_draw = true,
			disable_tutorial_ui = true,
			bone_lod_disable = true,
			hide_version_info = true,
			hide_fps = true
		}
	},
	{
		description = "",
		setting_name = "Screenshot mode - no hud",
		category = "Presets",
		preset = {
			disable_info_slate_ui = true,
			disable_debug_draw = true,
			disable_tutorial_ui = true,
			disable_outlines = true,
			hide_version_info = true,
			disable_ui = true,
			bone_lod_disable = true,
			hide_fps = true
		}
	},
	{
		description = "ctrl+F to cycle between graphs, ctrl+G to use special function in graph. (respawn level atm)",
		setting_name = "Show Graphs",
		category = "Presets",
		preset = {
			debug_ai_pacing = true,
			debug_player_intensity = true
		}
	},
	{
		description = "Prints the players current movementspeed when moving.",
		setting_name = "Show player movementspeed",
		category = "Presets",
		preset = {
			debug_player_movementspeed = true
		}
	},
	{
		description = "Make the player unkillable.",
		is_boolean = true,
		setting_name = "player_invincible",
		category = "Player mechanics recommended"
	},
	{
		description = [[
Features that make player mechanics nicer to work with.
 * Enables incresing/decreasing the player run speed via ALT+MouseScroll.
 * Allows you to press 'B' to take debug damage.
 * Kill yourself on 'CTRL' + 'V'
 * Revive yourself on 'CTRL' + 'B'
 * (requests go here...)]],
		is_boolean = true,
		setting_name = "player_mechanics_goodness_debug",
		category = "Player mechanics recommended"
	},
	{
		description = "Increases jump height and allows you to jump multiple times whilst in the air.",
		is_boolean = true,
		setting_name = "use_super_jumps",
		category = "Player mechanics recommended"
	},
	{
		description = "Sets the profile you would like to start the game with.",
		setting_name = "wanted_profile",
		category = "Player mechanics recommended",
		item_source = {
			witch_hunter = true,
			empire_soldier = true,
			dwarf_ranger = true,
			wood_elf = true,
			bright_wizard = true
		}
	},
	{
		description = "Press i to start looping through all weapons of your current character and equipping them",
		is_boolean = true,
		setting_name = "debug_equip_all_weapons",
		category = "Player mechanics"
	},
	{
		description = "For enabling melee weapon debugging.",
		is_boolean = true,
		setting_name = "debug_weapons",
		category = "Player mechanics"
	},
	{
		description = "Disable targetting feature",
		is_boolean = true,
		setting_name = "debug_weapons_no_targetting",
		category = "Player mechanics"
	},
	{
		description = "The enemy that got target will always get hit",
		is_boolean = true,
		setting_name = "debug_weapons_always_hit_target",
		category = "Player mechanics"
	},
	{
		description = "Damage debugging.",
		is_boolean = true,
		setting_name = "damage_debug",
		category = "Player mechanics"
	},
	{
		description = "Logs a ton of stuff, and adds a debug arrow to the knee... err.. screen.",
		is_boolean = true,
		setting_name = "camera_debug",
		category = "Player mechanics"
	},
	{
		description = "Shows area of active AreaDamageExtensions",
		is_boolean = true,
		setting_name = "debug_area_damage",
		category = "Player mechanics"
	},
	{
		description = "Enable state logging for all state machines",
		is_boolean = true,
		setting_name = "debug_state_machines",
		category = "Player mechanics"
	},
	{
		description = "Enable interactor/interactable debugging.",
		is_boolean = true,
		setting_name = "debug_interactions",
		category = "Player mechanics"
	},
	{
		description = "When enabled you will no longer get fatigued.",
		is_boolean = true,
		setting_name = "disable_fatigue_system",
		category = "Player mechanics"
	},
	{
		description = "Can always reload.",
		is_boolean = true,
		setting_name = "infinite_ammo",
		category = "Player mechanics"
	},
	{
		description = "Enable Animation Logging In The Console For The First Person Local Player.",
		is_boolean = true,
		setting_name = "debug_player_animations",
		category = "Player mechanics"
	},
	{
		description = "Enable \"legendary\" traits for all weapons, and adds some debug prints/draws",
		is_boolean = true,
		setting_name = "debug_legendary_traits",
		category = "Player mechanics"
	},
	{
		description = "Enable Animation Logging In The Console For The Local Player.",
		is_boolean = true,
		setting_name = "debug_first_person_player_animations",
		category = "Player mechanics"
	},
	{
		description = "Visualize ledges",
		is_boolean = true,
		setting_name = "visualize_ledges",
		category = "Player mechanics"
	},
	{
		description = "Enable Buff Debug Information",
		is_boolean = true,
		setting_name = "buff_debug",
		category = "Player mechanics"
	},
	{
		description = "Enable Charge Debug Information",
		is_boolean = true,
		setting_name = "charge_debug",
		category = "Player mechanics"
	},
	{
		description = "Enable OverCharge Debug Information",
		is_boolean = true,
		setting_name = "overcharge_debug",
		category = "Player mechanics"
	},
	{
		description = "Enable OverCharge Debug Information",
		is_boolean = true,
		setting_name = "disable_overcharge",
		category = "Player mechanics"
	},
	{
		description = "Disable The Spread On Ranged Weapons",
		is_boolean = true,
		setting_name = "disable_spread",
		category = "Player mechanics"
	},
	{
		description = "disable player walking, useful when you want to control time using shift",
		is_boolean = true,
		setting_name = "disable_player_walking",
		category = "Player mechanics"
	},
	{
		description = "makes it so you cant fall and hang from ledges",
		is_boolean = true,
		setting_name = "ledge_hanging_turned_off",
		category = "Player mechanics"
	},
	{
		description = "makes it so you dont die when you hang from ledge and fall",
		is_boolean = true,
		setting_name = "ledge_hanging_fall_and_die_turned_off",
		category = "Player mechanics"
	},
	{
		description = "unlocks every weapon trait on all weapons",
		is_boolean = true,
		setting_name = "unlock_all_weapon_traits",
		category = "Player mechanics"
	},
	{
		description = "Tutorial stuffs",
		is_boolean = true,
		setting_name = "tutorial_disabled",
		category = "Player mechanics"
	},
	{
		description = "Tutorial stuffs",
		is_boolean = true,
		setting_name = "tutorial_debug",
		category = "Player mechanics"
	},
	{
		description = "Unlock all tutorials without having to complete them in order",
		is_boolean = true,
		setting_name = "tutorial_cheat",
		category = "Player mechanics"
	},
	{
		description = "Debug statistics stuff",
		is_boolean = true,
		setting_name = "statistics_debug",
		category = "Player mechanics"
	},
	{
		description = "Debug achievements/trophies",
		is_boolean = true,
		setting_name = "achievement_debug",
		category = "Player mechanics"
	},
	{
		description = "Use debug platform for achievements",
		is_boolean = true,
		setting_name = "achievement_debug_platform",
		category = "Player mechanics"
	},
	{
		description = "RESETS all achievements/trophies",
		category = "Player mechanics",
		setting_name = "achievement_reset",
		func = function ()
			Managers.state.achievement:reset()

			return 
		end
	},
	{
		description = "Debug info for missions",
		is_boolean = true,
		setting_name = "debug_mission_system",
		category = "Player mechanics"
	},
	{
		description = "Show the player's position on the screen",
		is_boolean = true,
		setting_name = "debug_player_position",
		category = "Player mechanics"
	},
	{
		description = "Shows players movementspeed",
		is_boolean = true,
		setting_name = "debug_player_movementspeed",
		category = "Player mechanics"
	},
	{
		description = "Enabled or disable Quests & Contracts. Requires restart",
		is_boolean = true,
		setting_name = "quests_enabled",
		category = "Quests"
	},
	{
		description = "Saves a Reduced Damage boon in your local backend data.",
		category = "Quests",
		setting_name = "add_reduced_damage_boon",
		func = function ()
			local boons_interface = Managers.backend:get_interface("boons")

			boons_interface.add_boon_debug(boons_interface, "reduced_damage")

			return 
		end
	},
	{
		description = "Saves an Increased Damage boon in your local backend data.",
		category = "Quests",
		setting_name = "add_increased_damage_boon",
		func = function ()
			local boons_interface = Managers.backend:get_interface("boons")

			boons_interface.add_boon_debug(boons_interface, "increased_damage")

			return 
		end
	},
	{
		description = "Saves a Bonus Starting Gear boon in your local backend data.",
		category = "Quests",
		setting_name = "add_bonus_starting_gear_boon",
		func = function ()
			local boons_interface = Managers.backend:get_interface("boons")

			boons_interface.add_boon_debug(boons_interface, "bonus_starting_gear")

			return 
		end
	},
	{
		description = "Saves a Bonus Fatigue boon in your local backend data.",
		category = "Quests",
		setting_name = "add_bonus_bonus_fatigue_boon",
		func = function ()
			local boons_interface = Managers.backend:get_interface("boons")

			boons_interface.add_boon_debug(boons_interface, "bonus_fatigue")

			return 
		end
	},
	{
		description = "Saves an Increased Combat Movement boon in your local backend data.",
		category = "Quests",
		setting_name = "add_increased_combat_movement_boon",
		func = function ()
			local boons_interface = Managers.backend:get_interface("boons")

			boons_interface.add_boon_debug(boons_interface, "increased_combat_movement")

			return 
		end
	},
	{
		description = "Saves an Increased Stagger Type boon in your local backend data.",
		category = "Quests",
		setting_name = "add_increased_stagger_type_boon",
		func = function ()
			local boons_interface = Managers.backend:get_interface("boons")

			boons_interface.add_boon_debug(boons_interface, "increased_stagger_type")

			return 
		end
	},
	{
		description = "Clears your boon local save data",
		category = "Quests",
		setting_name = "clear_boons",
		func = function ()
			local boons_interface = Managers.backend:get_interface("boons")

			boons_interface.clear_boons_debug(boons_interface)

			return 
		end
	},
	{
		description = "Turns on prints for each players active boons",
		is_boolean = true,
		setting_name = "debug_active_boons",
		category = "Quests"
	},
	{
		description = "Resets quests and contracts and generates a new batch",
		category = "Quests",
		setting_name = "reset_quests_and_contracts",
		func = function ()
			local quests_interface = Managers.backend:get_interface("quests")

			quests_interface.reset_quests_and_contracts(quests_interface, true, true)

			return 
		end
	},
	{
		description = "Resets contracts and generates a new batch",
		category = "Quests",
		setting_name = "reset_contracts",
		func = function ()
			local quests_interface = Managers.backend:get_interface("quests")

			quests_interface.reset_quests_and_contracts(quests_interface, false, true)

			return 
		end
	},
	{
		description = "Shows the reward animation/ui when accepting a contract, without giving the reward",
		is_boolean = true,
		setting_name = "show_contract_reward_on_accept",
		category = "Quests"
	},
	{
		description = "Will show debug lines for projectiles when true",
		is_boolean = true,
		setting_name = "debug_projectiles",
		category = "Weapons"
	},
	{
		description = "Add/remove test attachments",
		is_boolean = true,
		setting_name = "attachment_debug",
		category = "Attachments"
	},
	{
		description = "Turns on chieftain spawn debug",
		is_boolean = true,
		setting_name = "ai_champion_spawn_debug",
		category = "AI recommended"
	},
	{
		description = "Disables AI spawning due to pacing.",
		is_boolean = true,
		setting_name = "ai_pacing_disabled",
		category = "AI recommended"
	},
	{
		description = "Disables AI rush intervention (specials & hordes)",
		is_boolean = true,
		setting_name = "ai_rush_intervention_disabled",
		category = "AI recommended"
	},
	{
		description = "Disables AI outside navmesh intervention (specials)",
		is_boolean = true,
		setting_name = "ai_outside_navmesh_intervention_disabled",
		category = "AI recommended"
	},
	{
		description = "Disables AI roam spawning.",
		is_boolean = true,
		setting_name = "ai_roaming_spawning_disabled",
		category = "AI recommended"
	},
	{
		description = "Disables boss/rare event spawning.",
		is_boolean = true,
		setting_name = "ai_boss_spawning_disabled",
		category = "AI recommended"
	},
	{
		description = "Disables specials spawning",
		is_boolean = true,
		setting_name = "ai_specials_spawning_disabled",
		category = "AI recommended"
	},
	{
		description = "Disables critter spawning",
		is_boolean = true,
		setting_name = "ai_critter_spawning_disabled",
		category = "AI recommended"
	},
	{
		description = "Disables gutter runners from spawning (requires restart!!!)",
		is_boolean = true,
		setting_name = "disable_gutter_runner",
		category = "AI recommended"
	},
	{
		description = "Disables globadiers from spawning (requires restart!!!)",
		is_boolean = true,
		setting_name = "disable_globadier",
		category = "AI recommended"
	},
	{
		description = "Disables pack masters from spawning (requires restart!!!)",
		is_boolean = true,
		setting_name = "disable_pack_master",
		category = "AI recommended"
	},
	{
		description = "Disables ratling gunners from spawning (requires restart!!!)",
		is_boolean = true,
		setting_name = "disable_ratling_gunner",
		category = "AI recommended"
	},
	{
		description = "Disables hordes spawning",
		is_boolean = true,
		setting_name = "ai_horde_spawning_disabled",
		category = "AI recommended"
	},
	{
		description = "Disables mini patrols from spawning",
		is_boolean = true,
		setting_name = "ai_mini_patrol_disabled",
		category = "AI recommended"
	},
	{
		description = "Enables horde logging in console",
		is_boolean = true,
		setting_name = "ai_horde_logging",
		category = "AI recommended"
	},
	{
		description = "Presents current amount of alive breeds on screen.",
		is_boolean = true,
		setting_name = "show_alive_ai",
		category = "AI recommended"
	},
	{
		description = "Writes out max-health / current health above ai units",
		is_boolean = true,
		setting_name = "show_ai_health",
		category = "AI recommended"
	},
	{
		description = "Draws a spinning line abouve each pickup in game",
		is_boolean = true,
		setting_name = "show_spawned_pickups",
		category = "AI recommended"
	},
	{
		description = "Draws lines up in the sky where each ai is",
		is_boolean = true,
		setting_name = "show_where_ai_is",
		category = "AI recommended"
	},
	{
		description = "turns on animation debug on your current ai debug target.",
		is_boolean = true,
		setting_name = "anim_debug_ai_debug_target",
		category = "AI recommended"
	},
	{
		description = "Choose between different conflict director settings.",
		setting_name = "current_conflict_settings",
		category = "Conflict & Pacing",
		item_source = ConflictDirectors
	},
	{
		description = "Choose between different pacing settings.",
		setting_name = "current_pacing_setting",
		category = "Conflict & Pacing",
		item_source = PacingSettings
	},
	{
		description = "Show all hidden spawners with vertical lines.",
		is_boolean = true,
		setting_name = "show_hidden_spawners",
		category = "Conflict & Pacing"
	},
	{
		description = "Shows clustering, loneliness, crumbs...",
		is_boolean = true,
		setting_name = "debug_player_positioning",
		category = "Conflict & Pacing"
	},
	{
		description = "Shows rushing player...",
		is_boolean = true,
		setting_name = "debug_rush_intervention",
		category = "Conflict & Pacing"
	},
	{
		description = "Shows player that is outside navmesh...",
		is_boolean = true,
		setting_name = "debug_outside_navmesh_intervention",
		category = "Conflict & Pacing"
	},
	{
		description = "Show data for pacing of the game",
		is_boolean = true,
		setting_name = "debug_ai_pacing",
		category = "Conflict & Pacing"
	},
	{
		description = "Shows player intensity",
		is_boolean = true,
		setting_name = "debug_player_intensity",
		category = "Conflict & Pacing"
	},
	{
		description = "Show exclamation point icon above heads of alerted skaven",
		is_boolean = true,
		setting_name = "enable_alert_icon",
		category = "AI"
	},
	{
		description = "Make AI not perceive anyone",
		is_boolean = true,
		setting_name = "disable_ai_perception",
		category = "AI"
	},
	{
		description = "Shows perception for some units",
		is_boolean = true,
		setting_name = "debug_ai_perception",
		category = "AI"
	},
	{
		description = "Automagically destroys AI that are at a far enough distance from all the players.",
		is_boolean = true,
		setting_name = "ai_far_off_despawn_disabled",
		category = "AI"
	},
	{
		description = "Shows how many units are dead and not despawned.",
		is_boolean = true,
		setting_name = "debug_death_watch_list",
		category = "AI"
	},
	{
		description = "Shows the workings of the ai recycler and area sets",
		is_boolean = true,
		setting_name = "debug_ai_recycler",
		category = "AI"
	},
	{
		description = "Shows the active respawns as yellow spheres with distance from start. removed respawns due to crossroads are bluish spheres",
		is_boolean = true,
		setting_name = "debug_player_respawns",
		category = "AI"
	},
	{
		description = "Horde debugging, shows how it picks spawn points",
		is_boolean = true,
		setting_name = "debug_hordes",
		category = "AI"
	},
	{
		description = "Mini patrol debugging",
		is_boolean = true,
		setting_name = "debug_mini_patrols",
		category = "AI"
	},
	{
		description = "The old horde spawning system slams raycasts allover to find a place unseen for spawning hordes",
		is_boolean = true,
		setting_name = "use_old_horde_system",
		category = "AI"
	},
	{
		description = "Disables hordes spawning visual debugging",
		is_boolean = true,
		setting_name = "ai_horde_spawning_debugging_disabled",
		category = "AI"
	},
	{
		description = "AI behviour trees text over unit.",
		is_boolean = true,
		setting_name = "debug_behaviour_trees",
		category = "AI"
	},
	{
		description = "Show debug data for terror events.",
		is_boolean = true,
		setting_name = "debug_terror",
		category = "AI"
	},
	{
		description = "Draws a sphere and text at each respawner unit in the level",
		category = "AI",
		setting_name = "debug_spawn_ogre_from_closest_boss_spawner",
		func = function ()
			if script_data.debug_ai_recycler then
				local only_draw = false

				Managers.state.conflict.level_analysis:debug_spawn_boss_from_closest_spawner_to_player(only_draw)
			end

			return 
		end
	},
	{
		description = "Debug spawn ogre from closest boss spawner. NOTE: debug_ai_recycler must be true at level load.",
		category = "AI",
		setting_name = "debug_draw_respaners",
		func = function ()
			Managers.state.spawn.respawn_handler:debug_draw_respaners()

			return 
		end
	},
	{
		description = "Debug spawns one special through the specials spawning system.",
		category = "AI",
		setting_name = "debug_spawn_special",
		func = function ()
			Managers.state.conflict.specials_pacing:debug_spawn()

			return 
		end
	},
	{
		description = "Enable navigation group debugging.",
		is_boolean = true,
		setting_name = "debug_navigation_group_manager",
		category = "AI"
	},
	{
		description = "Enables debugging for spawning packs using perlin noise.",
		is_boolean = true,
		setting_name = "debug_perlin_noise_spawning",
		category = "AI"
	},
	{
		description = "Visual debugging for movement.",
		is_boolean = true,
		setting_name = "debug_ai_movement",
		category = "AI"
	},
	{
		description = "Visual debugging when enemy AI pathfinding fails.",
		is_boolean = true,
		setting_name = "ai_debug_failed_pathing",
		category = "AI"
	},
	{
		description = "Displays engine debug for EngineOptimizedExtensions",
		is_boolean = true,
		setting_name = "show_engine_locomotion_debug",
		category = "AI"
	},
	{
		description = "Visual debugging for ai attacks",
		is_boolean = true,
		setting_name = "debug_ai_attack",
		category = "AI"
	},
	{
		description = "Visual debugging for ai targeting.",
		is_boolean = true,
		setting_name = "debug_ai_targets",
		category = "AI"
	},
	{
		description = "Only enables AI debugger during freeflight",
		is_boolean = true,
		setting_name = "ai_debugger_freeflight_only",
		category = "AI"
	},
	{
		description = "Shows considerations and utility values in console",
		is_boolean = true,
		setting_name = "ai_debug_utility_considerations",
		category = "AI"
	},
	{
		description = "Shows the aoe targeting alternatives and which target position chosen",
		is_boolean = true,
		setting_name = "ai_debug_aoe_targeting",
		category = "AI"
	},
	{
		description = "Shows the raycasts when testing trajectories",
		is_boolean = true,
		setting_name = "ai_debug_trajectory_raycast",
		category = "AI"
	},
	{
		description = "Use the fake players for the aoe targeting",
		is_boolean = true,
		setting_name = "ai_debug_use_fake_players_for_aoe_targeting",
		category = "AI"
	},
	{
		description = "Visualize AI slots",
		is_boolean = true,
		setting_name = "ai_debug_slots",
		category = "AI"
	},
	{
		description = "Will log when stuff happens",
		is_boolean = true,
		setting_name = "ai_debug_inventory",
		category = "AI"
	},
	{
		description = "Will visualize ai sound detection and reactions",
		is_boolean = true,
		setting_name = "ai_debug_sound_detection",
		category = "AI"
	},
	{
		description = "Visual debugging and logging for groups/patrols",
		is_boolean = true,
		setting_name = "ai_debug_smartobject",
		category = "AI"
	},
	{
		description = "Pack master will attack regardless of if the player is already under attack or not.",
		is_boolean = true,
		setting_name = "ai_packmaster_ignore_dogpile",
		category = "AI"
	},
	{
		description = "If not true, when quick-spawning enemies the ai debugger will auto select them.",
		is_boolean = true,
		setting_name = "ai_disable_auto_ai_debugger_target",
		category = "AI"
	},
	{
		description = "show globadiers areas for decision making",
		is_boolean = true,
		setting_name = "ai_globadier_behavior",
		category = "AI"
	},
	{
		description = "show gutter runner debug",
		is_boolean = true,
		setting_name = "ai_gutter_runner_behavior",
		category = "AI"
	},
	{
		description = "show loot rat debug",
		is_boolean = true,
		setting_name = "ai_loot_rat_behavior",
		category = "AI"
	},
	{
		description = "show nav mesh",
		is_boolean = true,
		setting_name = "nav_mesh_debug",
		category = "AI"
	},
	{
		description = "Shows cover points as green spheres. Bad cover points as red capsules, only draws at level startup.",
		is_boolean = true,
		setting_name = "show_hidden_cover_points",
		category = "AI"
	},
	{
		description = "Shows all coverpoints within 35m from the player",
		is_boolean = true,
		setting_name = "debug_near_cover_points",
		category = "AI"
	},
	{
		description = "AI group/patrols",
		is_boolean = true,
		setting_name = "ai_group_debug",
		category = "AI"
	},
	{
		description = "Debug storm vermin patrol",
		is_boolean = true,
		setting_name = "debug_storm_vermin_patrol",
		category = "AI"
	},
	{
		description = "AI interest points",
		is_boolean = true,
		setting_name = "ai_interest_point_debug",
		category = "AI"
	},
	{
		description = "AI interest points gets randomly disabled without this",
		is_boolean = true,
		setting_name = "ai_dont_randomize_interest_points",
		category = "AI"
	},
	{
		description = "ratling gunner debug",
		is_boolean = true,
		setting_name = "ai_ratling_gunner_debug",
		category = "AI"
	},
	{
		description = "disable to debug crashes more clearly or to profile.",
		is_boolean = true,
		setting_name = "navigation_thread_disabled",
		category = "AI"
	},
	{
		description = "Disable rats spreading out more.",
		is_boolean = true,
		setting_name = "disable_crowd_dispersion",
		category = "AI"
	},
	{
		description = "Sets the time available for pathfinding",
		setting_name = "navigation_pathfinder_budget",
		category = "AI",
		item_source = {
			default = true,
			short = true,
			long = true
		},
		func = function (options, index)
			local option = options[index]
			local nav_world = Managers.state.entity:system("ai_system"):nav_world()

			if option == "off" then
				print("Not changing pathfinding budget")
			elseif option == "short" then
				local ms = 0.1

				printf("Changing pathfinding budget to %.1fms", ms)
				GwNavWorld.set_pathfinder_budget(nav_world, ms*0.001)
			else
				local ms = 100

				printf("Changing pathfinding budget to %.1fms", ms)
				GwNavWorld.set_pathfinder_budget(nav_world, ms*0.001)
			end

			return 
		end
	},
	{
		description = "Enables visual debugging.",
		category = "AI",
		setting_name = "navigation_visual_debug_enabled",
		callback = "enable_navigation_visual_debug",
		is_boolean = true
	},
	{
		description = "Find it annoying that the game ends every time you die? Well enable this setting then!",
		is_boolean = true,
		setting_name = "disable_gamemode_end",
		category = "Gamemode/level"
	},
	{
		description = "Unlock all levels in the map",
		is_boolean = true,
		setting_name = "unlock_all_levels",
		category = "Gamemode/level"
	},
	{
		description = "Various level debug stuff",
		is_boolean = true,
		setting_name = "debug_level",
		category = "Gamemode/level"
	},
	{
		description = "Save debug info for server seeded randoms, can be printed on server/client with debug_print_random_values() in console",
		is_boolean = true,
		setting_name = "debug_server_seeded_random",
		category = "Gamemode/level"
	},
	{
		description = "Enables room debuging using f1-f4",
		is_boolean = true,
		setting_name = "debug_rooms",
		category = "Gamemode/level"
	},
	{
		description = "Allows you to skip ingame cutscenes",
		is_boolean = true,
		setting_name = "skippable_cutscenes",
		category = "Gamemode/level"
	},
	{
		description = "Change which difficulty you play at. Restart required.",
		setting_name = "current_difficulty_setting",
		category = "Gamemode/level",
		item_source = DifficultySettings
	},
	{
		description = "Enables/disables spawning of chests that doesn't have any pickups in them. Level restart required",
		is_boolean = true,
		setting_name = "spawn_no_empty_chests",
		category = "Gamemode/level"
	},
	{
		description = "Debug for darkness in drachenfells castle dungeon level.",
		is_boolean = true,
		setting_name = "debug_darkness",
		category = "Gamemode/level"
	},
	{
		description = "Debug number of chests and their positions",
		is_boolean = true,
		setting_name = "debug_chests",
		category = "Gamemode/level"
	},
	{
		description = "Debug print Hit Effects Templates",
		is_boolean = true,
		setting_name = "debug_hit_effects_templates",
		category = "Visual/audio"
	},
	{
		description = "Disabled blood splatter on screen from other players' kills",
		is_boolean = true,
		setting_name = "disable_remote_blood_splatter",
		category = "Visual/audio"
	},
	{
		description = "Disabled blood splatter on screen from behind camera",
		is_boolean = true,
		setting_name = "disable_behind_blood_splatter",
		category = "Visual/audio"
	},
	{
		description = "Disable combat music",
		is_boolean = true,
		setting_name = "debug_disable_combat_music",
		category = "Visual/audio"
	},
	{
		description = "Show material effect visual debug info.",
		is_boolean = true,
		setting_name = "debug_material_effects",
		category = "Visual/audio"
	},
	{
		description = "Sound debugging",
		is_boolean = true,
		setting_name = "sound_debug",
		category = "Visual/audio"
	},
	{
		description = "Visual debug for the sound sector system",
		is_boolean = true,
		setting_name = "sound_sector_system_debug",
		category = "Visual/audio"
	},
	{
		description = "debug info for sound environments",
		is_boolean = true,
		setting_name = "debug_sound_environments",
		category = "Visual/audio"
	},
	{
		description = "music stuff",
		is_boolean = true,
		setting_name = "debug_music",
		category = "Visual/audio"
	},
	{
		description = "debug lua_elevation parameter sent to wwise",
		is_boolean = true,
		setting_name = "debug_wwise_elevation",
		category = "Visual/audio"
	},
	{
		description = "debug current environment blend",
		is_boolean = true,
		setting_name = "debug_environment_blend",
		category = "Visual/audio"
	},
	{
		description = "debug nav mesh pasted particle effects",
		is_boolean = true,
		setting_name = "debug_nav_mesh_vfx",
		category = "Visual/audio"
	},
	{
		description = "debug sorting for proximity dependent sfx and vfx",
		is_boolean = true,
		setting_name = "debug_proximity_fx",
		category = "Visual/audio"
	},
	{
		description = "maximum allowed skaven to play proximity dependent sfx and vfx settings: 5/10/12/15/20/25/30/40/60",
		setting_name = "max_allowed_proximity_fx",
		category = "Visual/audio",
		item_source = {
			nil,
			nil,
			nil,
			nil,
			true,
			nil,
			nil,
			nil,
			nil,
			true,
			nil,
			true,
			nil,
			nil,
			true,
			nil,
			nil,
			nil,
			nil,
			true,
			nil,
			nil,
			nil,
			nil,
			true,
			nil,
			nil,
			nil,
			nil,
			true,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			true,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			true,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			true
		}
	},
	{
		no_nil = true,
		description = "Stuffs",
		setting_name = "visual_debug",
		category = "Visual/audio",
		command_list = {
			{
				description = "off",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Albedo XYZ Luminance",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Albedo XYZ Luminance Clipping",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Albedo Lab Luminance",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Albedo Lab Luminance Clipping",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Albedo",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Normals",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Roughness",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Specular",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Metallic",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Ambient Diffuse",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Velocity",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Ambient Occlusion",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Sun Shadow",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"true"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Bloom",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Light Shafts",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Eye Adaptation",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Cascaded shadow map",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Atlased shadow mapping",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Atlased shadow mask",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"true"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"false"
					}
				}
			},
			{
				description = "Static Shadow Map",
				commands = {
					{
						"renderer",
						"settings",
						"debug_rendering",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_xyz_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_lab_luminance_clipping_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_albedo_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_normal_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_roughness_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_specular_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_metallic_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ambient_diffuse_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_velocity_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_ao_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"gbuffer_sun_shadow_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"bloom_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"light_shaft_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"eye_adaptation_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_cascade_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_atlas_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"shadow_mask_visualization",
						"false"
					},
					{
						"renderer",
						"settings",
						"static_shadow_visualization",
						"true"
					}
				}
			}
		}
	},
	{
		description = "Bind to a numpad key and do it.",
		category = "Visual/audio",
		setting_name = "take_screenshot",
		func = function ()
			FrameCapture.screen_shot("console_send", 2)

			return 
		end
	},
	{
		description = "Disbales all debug draws",
		is_boolean = true,
		setting_name = "disable_debug_draw",
		category = "Visual/audio"
	},
	{
		description = "Draw pretty lines for sound occlusion.",
		setting_name = "visualize_sound_occlusion",
		callback = "visualize_sound_occlusion",
		category = "Visual/audio",
		item_source = {
			["toggle sound occlusion"] = true
		}
	},
	{
		description = "Print out debugging for VoIP",
		is_boolean = true,
		setting_name = "debug_voip",
		category = "Visual/audio"
	},
	{
		description = "Disable VoIP",
		is_boolean = true,
		setting_name = "disable_voip",
		category = "Visual/audio"
	},
	{
		no_nil = true,
		description = "Enables chain constraints",
		setting_name = "enable_chain_constraints",
		callback = "enable_chain_constraints",
		category = "Constraints",
		is_boolean = true
	},
	{
		description = "Network debugging",
		is_boolean = true,
		setting_name = "network_debug",
		category = "Network"
	},
	{
		description = "Set network logging to Network.MESSAGES on startup",
		is_boolean = true,
		setting_name = "network_log_messages",
		category = "Network"
	},
	{
		description = "Set network logging to Network.SPEW on startup",
		is_boolean = true,
		setting_name = "network_log_spew",
		category = "Network"
	},
	{
		description = "hide extra matchmaking info window",
		is_boolean = true,
		setting_name = "hide_matchmaking_info",
		category = "Network"
	},
	{
		description = "matchmaking debug logging",
		is_boolean = true,
		setting_name = "matchmaking_debug",
		category = "Network"
	},
	{
		no_nil = true,
		description = "Sets latency",
		setting_name = "network_latency",
		category = "Network",
		command_list = {
			{
				description = "off",
				commands = {
					{
						"network",
						"latency",
						"0",
						"0"
					}
				}
			},
			{
				description = "0.05-0.2 seconds",
				commands = {
					{
						"network",
						"latency",
						"0.05",
						"0.2"
					}
				}
			},
			{
				description = "0.2-0.5 seconds",
				commands = {
					{
						"network",
						"latency",
						"0.2",
						"0.5"
					}
				}
			},
			{
				description = "1 seconds",
				commands = {
					{
						"network",
						"latency",
						"1",
						"1"
					}
				}
			},
			{
				description = "1-2 seconds",
				commands = {
					{
						"network",
						"latency",
						"1",
						"2"
					}
				}
			},
			{
				description = "5 seconds",
				commands = {
					{
						"network",
						"latency",
						"5",
						"5"
					}
				}
			},
			{
				description = "low latency",
				commands = {
					{
						"network",
						"latency",
						"0.010",
						"0.012"
					}
				}
			},
			{
				description = "medium latency",
				commands = {
					{
						"network",
						"latency",
						"0.035",
						"0.040"
					}
				}
			},
			{
				description = "high latency",
				commands = {
					{
						"network",
						"latency",
						"0.070",
						"0.080"
					}
				}
			},
			{
				description = "very high latency",
				commands = {
					{
						"network",
						"latency",
						"0.090",
						"0.100"
					}
				}
			}
		}
	},
	{
		no_nil = true,
		description = "Sets packet loss",
		setting_name = "packet_loss",
		category = "Network",
		command_list = {
			{
				description = "off",
				commands = {
					{
						"network",
						"packet_loss",
						"0",
						"0"
					}
				}
			},
			{
				description = "0.5%",
				commands = {
					{
						"network",
						"packet_loss",
						"0.005"
					}
				}
			},
			{
				description = "1%",
				commands = {
					{
						"network",
						"packet_loss",
						"0.01"
					}
				}
			},
			{
				description = "2%",
				commands = {
					{
						"network",
						"packet_loss",
						"0.02"
					}
				}
			}
		}
	},
	{
		no_nil = true,
		description = "Sets bandwidth limits",
		setting_name = "network connection",
		category = "Network",
		command_list = {
			{
				description = "off",
				commands = {
					{
						"network",
						"limit"
					}
				}
			},
			{
				description = "Crappy cable 192/192",
				commands = {
					{
						"network",
						"limit",
						"192",
						"192"
					}
				}
			},
			{
				description = "Crappy cable, 128/512",
				commands = {
					{
						"network",
						"limit",
						"128",
						"512"
					}
				}
			},
			{
				description = "Crappy ADSL, 512/2048",
				commands = {
					{
						"network",
						"limit",
						"512",
						"2048"
					}
				}
			},
			{
				description = "4mbit half duplex",
				commands = {
					{
						"network",
						"limit",
						"2048",
						"2048"
					}
				}
			},
			{
				description = "10mbit half duplex",
				commands = {
					{
						"network",
						"limit",
						"5000",
						"5000"
					}
				}
			}
		}
	},
	{
		description = "Shows the current clock time",
		is_boolean = true,
		setting_name = "network_clock_debug",
		category = "Network"
	},
	{
		description = "Debug Print Profile Package Loading",
		is_boolean = true,
		setting_name = "profile_package_loading_debug",
		category = "Network"
	},
	{
		description = "Debugs connections for the network",
		is_boolean = true,
		setting_name = "network_debug_connections",
		category = "Network"
	},
	{
		description = "Debugs lobbies and matchmaking",
		is_boolean = true,
		setting_name = "debug_lobbies",
		category = "Network"
	},
	{
		description = "Debug Player Context",
		is_boolean = true,
		setting_name = "dialogue_debug_local_player_context",
		category = "Dialogue"
	},
	{
		description = "Debug All Contexts",
		is_boolean = true,
		setting_name = "dialogue_debug_all_contexts",
		category = "Dialogue"
	},
	{
		description = "Debug Last Query",
		is_boolean = true,
		setting_name = "dialogue_debug_last_query",
		category = "Dialogue"
	},
	{
		description = "Debug Print Successful Queries",
		is_boolean = true,
		setting_name = "dialogue_debug_last_played_query",
		category = "Dialogue"
	},
	{
		description = "Debug Print Queries",
		is_boolean = true,
		setting_name = "dialogue_debug_queries",
		category = "Dialogue"
	},
	{
		description = "Debug Print Criteria fail/successes",
		is_boolean = true,
		setting_name = "dialogue_debug_criterias",
		category = "Dialogue"
	},
	{
		description = "Debug Print Rule failures",
		is_boolean = true,
		setting_name = "dialogue_debug_rule_fails",
		category = "Dialogue"
	},
	{
		description = "Debug show Proximities",
		is_boolean = true,
		setting_name = "dialogue_debug_proximity_system",
		category = "Dialogue"
	},
	{
		description = "Visualize lookat system",
		is_boolean = true,
		setting_name = "dialogue_debug_lookat",
		category = "Dialogue"
	},
	{
		description = "Debug subtitles",
		is_boolean = true,
		setting_name = "subtitle_debug",
		category = "Dialogue"
	},
	{
		setting_name = "debug_dialogue_files",
		description = "Used to debug dialog files, facial expressions and missing vo/subtitles. To skip use: DebugVo_jump_to('line_number/line_id')",
		category = "Dialogue",
		item_source = {},
		load_items_source_func = function (options)
			table.clear(options)

			local dialogue_files = DialogueSettings.auto_load_files

			for key, file in pairs(dialogue_files) do
				options[#options + 1] = string.match(file, "^.+/(.+)$")
			end

			local level_key = Managers.state.game_mode:level_key()
			local level_dialogue_files = DialogueSettings.level_specific_load_files[level_key]

			for key, file in pairs(level_dialogue_files) do
				options[#options + 1] = string.match(file, "^.+/(.+)$")
			end

			return 
		end,
		func = function (options, index)
			DebugVoByFile(options[index], false)

			return 
		end
	},
	{
		description = "Debug print input device statuses",
		is_boolean = true,
		setting_name = "input_debug_device_state",
		category = "Input"
	},
	{
		description = "Debug input filters output",
		is_boolean = true,
		setting_name = "input_debug_filters",
		category = "Input"
	},
	{
		description = "Start editing the current keymaps.",
		close_when_selected = true,
		category = "Input",
		setting_name = "input_debug_edit_keymap",
		clear_when_selected = true,
		item_source = {
			["toggle keymap editor"] = true
		}
	},
	{
		description = "Debug UI Hover elements",
		is_boolean = true,
		setting_name = "ui_debug_hover",
		category = "UI"
	},
	{
		description = "Enable/Disable the Lorebook (need to restart level to spawn page pickups)",
		is_boolean = true,
		setting_name = "lorebook_enabled",
		category = "UI"
	},
	{
		description = "Unlock All Lorebook Pages - Restart Required",
		is_boolean = true,
		setting_name = "unlock_all_lorebook",
		category = "UI"
	},
	{
		description = "Debug UI Scenegraph Areas and Sizes",
		is_boolean = true,
		setting_name = "ui_debug_scenegraph",
		category = "UI"
	},
	{
		description = "Debug UI Pixeldistance (by keybinding",
		is_boolean = true,
		setting_name = "ui_debug_pixeldistance",
		category = "UI"
	},
	{
		description = "Debug ui textures.",
		is_boolean = true,
		setting_name = "ui_debug_draw_texture",
		category = "UI"
	},
	{
		description = "Disable UI Rendering.",
		is_boolean = true,
		setting_name = "disable_ui",
		category = "UI"
	},
	{
		description = "Disable Outlines (will not disable ones that are already active).",
		is_boolean = true,
		setting_name = "disable_outlines",
		category = "UI"
	},
	{
		description = "Disables the screens at the end of the level, getting you directly back to the inn.",
		is_boolean = true,
		setting_name = "disable_end_screens",
		category = "UI"
	},
	{
		description = "Disable Tutorial UI Rendering.",
		is_boolean = true,
		setting_name = "disable_tutorial_ui",
		category = "UI"
	},
	{
		description = "Disable Info Slate UI Rendering.",
		is_boolean = true,
		setting_name = "disable_info_slate_ui",
		category = "UI"
	},
	{
		description = "Looks through all the localizations and selects the longest text for each item.",
		is_boolean = true,
		setting_name = "show_longest_localizations",
		category = "UI"
	},
	{
		description = "Cycles through available localizations",
		category = "UI",
		setting_name = "enable_localization_cycling",
		callback = "enable_locale_cycling",
		is_boolean = true
	},
	{
		description = "Enables friends view debug information",
		is_boolean = true,
		setting_name = "debug_friends_view",
		category = "UI"
	},
	{
		description = "Turns off positive reinforcement UI",
		is_boolean = true,
		setting_name = "disable_reinforcement_ui",
		category = "UI"
	},
	{
		description = "Switches reinforcement UI local sound",
		setting_name = "reinforcement_ui_local_sound",
		category = "UI",
		item_source = {
			hud_achievement_unlock_01 = true,
			hud_achievement_unlock_03 = true,
			hud_info = true,
			hud_achievement_unlock_02 = true
		}
	},
	{
		description = "Toggles reinforcement UI remote sound",
		is_boolean = true,
		setting_name = "enable_reinforcement_ui_remote_sound",
		category = "UI"
	},
	{
		description = "Enables friends view debug information",
		is_boolean = true,
		setting_name = "pause_menu_full_access",
		category = "UI"
	},
	{
		description = "Ignore level cap on trinket slots",
		is_boolean = true,
		setting_name = "unlock_all_trinket_slots",
		category = "UI"
	},
	{
		description = "Load all menu views and textures regardless of if you are in the inn or ingame. Not turning on this will make inn-menus (forge, altar, map, etc.) unavailable from inside a level. Needs restart.",
		is_boolean = true,
		setting_name = "always_load_all_views",
		category = "UI"
	},
	{
		description = "If inventory is open it will cycle select items automatically",
		is_boolean = true,
		setting_name = "debug_cycle_select_inventory_item",
		category = "UI"
	},
	{
		description = "Disables position lookup validation. Can turn this on for extra performance.",
		is_boolean = true,
		setting_name = "disable_debug_position_lookup",
		category = "Misc"
	},
	{
		description = "Will paste the content and engine revision to the user's clipboard.",
		is_boolean = true,
		setting_name = "paste_revision_to_clipboard",
		category = "Misc"
	},
	{
		description = "Will generate and read a file with the current svn revision on startup. Creates an annoying popup. Sorry about that. This is useful for lan builds.",
		is_boolean = true,
		setting_name = "generate_svn_info",
		category = "Misc"
	},
	{
		description = "Enable logging of telemetry debugging information.",
		is_boolean = true,
		setting_name = "debug_telemetry",
		category = "Misc"
	},
	{
		description = "Enable logging of leaderboard debugging information.",
		is_boolean = true,
		setting_name = "debug_leaderboard",
		category = "Misc"
	},
	{
		description = "Enable logging of the forge",
		is_boolean = true,
		setting_name = "forge_debug",
		category = "Misc"
	},
	{
		description = "Enables logging for the package manager",
		is_boolean = true,
		setting_name = "package_debug",
		category = "Misc"
	},
	{
		description = "Disable luajit ",
		category = "Misc",
		setting_name = "luajit_disabled",
		callback = "update_using_luajit",
		is_boolean = true
	},
	{
		description = "Restart the game to view dice chances",
		is_boolean = true,
		setting_name = "dice_chance_simulation",
		category = "Misc"
	},
	{
		description = "Shows a rect in topcenter of the current color of lightfx. Restart required",
		is_boolean = true,
		setting_name = "debug_lightfx",
		category = "Misc"
	},
	{
		description = "Throttles FPS to a value. Default means no throttle. Note that this doesn't automatically gets set at startup.",
		setting_name = "force_limit_fps",
		category = "Misc",
		item_source = {
			default = true,
			throttle_fps_5 = true,
			throttle_fps_15 = true,
			throttle_fps_1 = true,
			throttle_fps_10 = true,
			throttle_fps_60 = true,
			throttle_fps_30 = true
		},
		func = function (options, index)
			local option = options[index]
			local nav_world = Managers.state.entity:system("ai_system"):nav_world()
			local fps = 60

			if option == "default" then
				Application.set_time_step_policy("no_throttle")

				return 
			elseif option == "throttle_fps_1" then
				fps = 1
			elseif option == "throttle_fps_5" then
				fps = 5
			elseif option == "throttle_fps_10" then
				fps = 10
			elseif option == "throttle_fps_15" then
				fps = 15
			elseif option == "throttle_fps_30" then
				fps = 30
			elseif option == "throttle_fps_60" then
				fps = 60
			end

			Application.set_time_step_policy("throttle", fps)

			return 
		end
	},
	{
		description = "Don't show dark background behind debug texts.",
		is_boolean = true,
		setting_name = "hide_debug_text_background",
		category = "Misc"
	},
	{
		description = "Will log transitions fade in/fade out",
		is_boolean = true,
		setting_name = "debug_transition_manager",
		category = "Misc"
	},
	{
		no_nil = true,
		description = "Sets the time that a stall must take in order for it to be logged. Default is 0.1 seconds.",
		setting_name = "stall_time",
		category = "Performance",
		command_list = {
			{
				description = "default",
				commands = {
					{
						"profiler",
						"stall",
						0.1
					}
				}
			},
			{
				description = "0.05",
				commands = {
					{
						"profiler",
						"stall",
						0.05
					}
				}
			},
			{
				description = "0.2",
				commands = {
					{
						"profiler",
						"stall",
						0.2
					}
				}
			},
			{
				description = "0.5",
				commands = {
					{
						"profiler",
						"stall",
						0.5
					}
				}
			},
			{
				description = "1",
				commands = {
					{
						"profiler",
						"stall",
						1
					}
				}
			},
			{
				description = "10",
				commands = {
					{
						"profiler",
						"stall",
						10
					}
				}
			}
		}
	},
	{
		description = "Enable logging of mismatched profiling scopes.",
		is_boolean = true,
		setting_name = "debug_profiling_scopes",
		category = "Performance"
	},
	{
		description = "Enable visual 'profiling' of function calls.",
		is_boolean = true,
		setting_name = "profile_function_calls",
		category = "Performance"
	},
	{
		description = "Enable visual 'profiling' of pool tables.",
		is_boolean = true,
		setting_name = "profile_pool_tables",
		category = "Performance"
	},
	{
		description = "Enable asserts on mismatched profiling scopes.",
		is_boolean = true,
		setting_name = "validate_profiling_scopes",
		category = "Performance"
	},
	{
		description = "Enable debugging of bone lods.",
		is_boolean = true,
		setting_name = "bone_lod_debug",
		category = "Performance"
	},
	{
		description = "Disable lodding of animation bones.",
		is_boolean = true,
		setting_name = "bone_lod_disable",
		category = "Performance"
	},
	{
		description = "Enable floating text over AI head which states the animation that animation merge is currently enabled for.",
		is_boolean = true,
		setting_name = "animation_merge_debug",
		category = "Performance"
	},
	{
		no_nil = false,
		description = "Gamma (2.2 default)",
		setting_name = "Gamma",
		category = "Render Settings",
		bitmap = "settings_debug_gamma_correction",
		bitmap_size = 512,
		command_list = {
			{
				description = "1.0",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"1.0"
					}
				}
			},
			{
				description = "2.0",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"2.0"
					}
				}
			},
			{
				description = "2.1",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"2.1"
					}
				}
			},
			{
				description = "2.2",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"2.2"
					}
				}
			},
			{
				description = "2.3",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"2.3"
					}
				}
			},
			{
				description = "2.4",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"2.4"
					}
				}
			},
			{
				description = "3.0",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"3.0"
					}
				}
			},
			{
				description = "3.5",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"3.5"
					}
				}
			},
			{
				description = "4.0",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"4.0"
					}
				}
			},
			{
				description = "4.5",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"4.5"
					}
				}
			},
			{
				description = "5.0",
				commands = {
					{
						"renderer",
						"settings",
						"gamma",
						"5.0"
					}
				}
			}
		}
	},
	{
		no_nil = false,
		description = "Enabled is default",
		setting_name = "Global Shadows",
		category = "Render Settings",
		command_list = {
			{
				description = "Sun Shadow Enabled",
				commands = {
					{
						"renderer",
						"settings",
						"sun_shadows",
						"true"
					}
				}
			},
			{
				description = "Sun Shadow Disabled",
				commands = {
					{
						"renderer",
						"settings",
						"sun_shadows",
						"false"
					}
				}
			}
		}
	},
	{
		no_nil = false,
		description = "Enabled is default. You'll need to restart game/engine.",
		setting_name = "Local Light Shadows",
		category = "Render Settings",
		command_list = {
			{
				description = "Local Light Shadow Enabled",
				commands = {
					{
						"renderer",
						"settings",
						"deferred_local_lights_cast_shadows",
						"true"
					},
					{
						"renderer",
						"settings",
						"forward_local_lights_cast_shadows",
						"true"
					}
				}
			},
			{
				description = "Local Light Shadow Disabled",
				commands = {
					{
						"renderer",
						"settings",
						"deferred_local_lights_cast_shadows",
						"false"
					},
					{
						"renderer",
						"settings",
						"forward_local_lights_cast_shadows",
						"false"
					}
				}
			}
		}
	},
	{
		no_nil = false,
		description = "Enabled is default",
		setting_name = "AO Enable/Disable",
		category = "Render Settings",
		command_list = {
			{
				description = "Enabled",
				commands = {
					{
						"renderer",
						"settings",
						"ao_enabled",
						"true"
					}
				}
			},
			{
				description = "Disabled",
				commands = {
					{
						"renderer",
						"settings",
						"ao_enabled",
						"false"
					}
				}
			}
		}
	},
	{
		no_nil = false,
		description = "Full is default. You'll need to restart game/engine.",
		setting_name = "AO Resolution",
		category = "Render Settings",
		command_list = {
			{
				description = "Full Res",
				commands = {
					{
						"renderer",
						"settings",
						"ao_half_res",
						"false"
					}
				}
			},
			{
				description = "Half Res",
				commands = {
					{
						"renderer",
						"settings",
						"ao_half_res",
						"true"
					}
				}
			}
		}
	},
	{
		description = "You have to restart the game for the settings to take effect",
		category = "Render Settings",
		setting_name = "Set high texture quality",
		func = function ()
			DebugScreen.set_texture_quality(0)

			return 
		end
	},
	{
		description = "You have to restart the game for the settings to take effect",
		category = "Render Settings",
		setting_name = "Set low texture quality",
		func = function ()
			DebugScreen.set_texture_quality(3)

			return 
		end
	},
	{
		description = "Show bot debug visualizers",
		is_boolean = true,
		setting_name = "ai_bots_debug",
		category = "Bots"
	},
	{
		description = "Enable debug printing related to bot weapons.",
		is_boolean = true,
		setting_name = "ai_bots_weapon_debug",
		category = "Bots"
	},
	{
		description = "Bots will not follow player.",
		is_boolean = true,
		setting_name = "bots_dont_follow",
		category = "Bots"
	},
	{
		description = "Disables automatic spawning of bots",
		is_boolean = true,
		setting_name = "ai_bots_disabled",
		category = "Bots"
	},
	{
		description = "Will set the total number of players + bots in game",
		setting_name = "cap_num_bots",
		category = "Bots",
		item_source = {
			0,
			1,
			2,
			3
		}
	},
	{
		no_nil = false,
		description = "",
		setting_name = "Perfhud Artist",
		category = "Perfhud",
		command_list = {
			{
				description = "Default",
				commands = {
					{
						"perfhud",
						"artist"
					}
				}
			},
			{
				description = "Objects",
				commands = {
					{
						"perfhud",
						"artist",
						"objects"
					}
				}
			},
			{
				description = "Lighting",
				commands = {
					{
						"perfhud",
						"artist",
						"lighting"
					}
				}
			},
			{
				description = "Post Processing",
				commands = {
					{
						"perfhud",
						"artist",
						"post_processing"
					}
				}
			},
			{
				description = "GUI",
				commands = {
					{
						"perfhud",
						"artist",
						"gui"
					}
				}
			}
		}
	},
	{
		no_nil = false,
		description = "",
		setting_name = "Perfhud Memory",
		category = "Perfhud",
		command_list = {
			{
				description = "Memory",
				commands = {
					{
						"perfhud",
						"memory"
					}
				}
			}
		}
	},
	{
		description = "Performance Manager Debug",
		is_boolean = true,
		setting_name = "performance_debug",
		category = "Perfhud"
	},
	{
		description = "Requires restart. Disables the backend and emulates it with a local save.",
		is_boolean = true,
		setting_name = "use_local_backend",
		category = "Backend"
	},
	{
		description = "Sets the amount of logging on the backend",
		setting_name = "backend_logging_level",
		category = "Backend",
		item_source = {
			off = true,
			verbose = true,
			normal = true
		},
		func = function ()
			Managers.backend:refresh_log_level()

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Reset Progression",
		func = function ()
			LevelUnlockUtils.reset_progression()

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set act 0",
		func = function ()
			LevelUnlockUtils.debug_unlock_act(0)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set act 1",
		func = function ()
			LevelUnlockUtils.debug_unlock_act(1)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set act 2",
		func = function ()
			LevelUnlockUtils.debug_unlock_act(2)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set act 3",
		func = function ()
			LevelUnlockUtils.debug_unlock_act(3)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set act 4",
		func = function ()
			LevelUnlockUtils.debug_unlock_act(4)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set completed game difficulty none",
		func = function ()
			LevelUnlockUtils.debug_set_completed_game_difficulty(0)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set completed game difficulty easy",
		func = function ()
			LevelUnlockUtils.debug_set_completed_game_difficulty(1)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set completed game difficulty normal",
		func = function ()
			LevelUnlockUtils.debug_set_completed_game_difficulty(2)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set completed game difficulty hard",
		func = function ()
			LevelUnlockUtils.debug_set_completed_game_difficulty(3)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set completed game difficulty harder",
		func = function ()
			LevelUnlockUtils.debug_set_completed_game_difficulty(4)

			return 
		end
	},
	{
		description = "You have to reload the inn for the setting to take effect",
		category = "Progression",
		setting_name = "Set completed game difficulty hardest",
		func = function ()
			LevelUnlockUtils.debug_set_completed_game_difficulty(5)

			return 
		end
	},
	{
		description = "Adds 1000 Experience to your account.",
		category = "Progression",
		setting_name = "1000 Experience",
		func = function ()
			local experience = ScriptBackendProfileAttribute.get("experience")
			local end_experience = experience + 1000

			ScriptBackendProfileAttribute.set("experience", end_experience)

			return 
		end
	}
}
local platform = PLATFORM

if platform == "ps4" then
	local settings_ps4 = {
		{
			description = "Debug PSN Features",
			is_boolean = true,
			setting_name = "debug_psn",
			category = "PS4"
		}
	}

	table.append(settings, settings_ps4)
end

if platform == "ps4" or platform == "xb1" then
	local settings_console = {
		{
			setting_name = "Spawn/Unspawn",
			description = "",
			category = "Breed",
			item_source = {},
			load_items_source_func = function (options)
				table.clear(options)

				options[1] = "Switch Breed"
				options[2] = "Spawn Breed"
				options[3] = "Spawn Group"
				options[4] = "Spawn Horde"
				options[5] = "Unspawn All Breed"
				options[6] = "Unspawn Nearby Breed"
				options[7] = "Unspawn Specials"

				return 
			end,
			func = function (options, index)
				local conflict_director = Managers.state.conflict

				if conflict_director then
					local selected_value = options[index]

					if selected_value == "Switch Breed" then
						local t = Managers.time:time("main")

						conflict_director.debug_spawn_switch_breed(conflict_director, t)
					elseif selected_value == "Spawn Breed" then
						local t = Managers.time:time("main")

						conflict_director.debug_spawn_breed(conflict_director, t)
					elseif selected_value == "Spawn Group" then
						local t = Managers.time:time("main")

						conflict_director.debug_spawn_group(conflict_director, t)
					elseif selected_value == "Spawn Horde" then
						conflict_director.debug_spawn_horde(conflict_director)
					elseif selected_value == "Unspawn All Breed" then
						conflict_director.destroy_all_units(conflict_director)
					elseif selected_value == "Unspawn Nearby Breed" then
						conflict_director.destroy_close_units(conflict_director, nil, 144)
					elseif selected_value == "Unspawn Specials" then
						conflict_director.destroy_specials(conflict_director)
					end
				end

				return 
			end
		},
		{
			setting_name = "Set Time Scale (%)",
			description = "",
			category = "Time",
			item_source = {},
			load_items_source_func = function (options)
				table.clear(options)

				options[1] = 1
				options[2] = 50
				options[3] = 100
				options[4] = 200

				return 
			end,
			func = function (options, index)
				local debug_manager = Managers.state.debug

				if debug_manager then
					local time_scale_value = options[index]
					local time_scale_index = table.find(debug_manager.time_scale_list, time_scale_value)

					assert(time_scale_index, "[DebugScreen] Selected time scale not found in Managers.state.debug.time_scale_list")
					debug_manager.set_time_scale(debug_manager, time_scale_index)
				end

				return 
			end
		}
	}

	table.append(settings, settings_console)
end

for settings_key, settings_value in pairs(settings) do
	if settings_value.preset then
		for preset_key, preset_value in pairs(settings_value.preset) do
			settings_value.description = string.format("%s¤ %s = %s \n", settings_value.description, preset_key, tostring(preset_value))
		end
	end
end

local callbacks = {
	enable_locale_cycling = function (option)
		enable_locale_cycling(option)

		return 
	end,
	visualize_sound_occlusion = function (option)
		World.visualize_sound_occlusion()

		return 
	end,
	enable_chain_constraints = function (option)
		World.enable_chain_constraints(option)

		return 
	end,
	update_using_luajit = function (option)
		if script_data.luajit_disabled then
			jit.off()
			print("lua jit is disabled")
		else
			jit.on()
			print("lua jit is enabled")
		end

		return 
	end,
	enable_navigation_visual_debug = function (option)
		if option and not VISUAL_DEBUGGING_ENABLED and Managers.state.entity then
			VISUAL_DEBUGGING_ENABLED = true
			local nav_world = Managers.state.entity:system("ai_system"):nav_world()

			GwNavWorld.init_visual_debug_server(nav_world, 4888)
		end

		return 
	end
}
local data = {
	settings = settings,
	callbacks = callbacks
}

return data
