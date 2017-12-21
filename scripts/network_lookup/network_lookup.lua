require("scripts/settings/environmental_hazards")
require("scripts/settings/level_settings")
require("scripts/settings/level_unlock_settings")
require("scripts/settings/level_settings_campaign")
require("scripts/settings/game_mode_settings")
require("scripts/settings/player_data")
require("scripts/settings/equipment/attachments")
require("scripts/settings/equipment/weapons")
require("scripts/settings/equipment/pickups")
require("scripts/settings/material_effect_mappings")
require("scripts/settings/player_unit_status_settings")
require("scripts/managers/voting/vote_templates")
require("scripts/settings/difficulty_settings")
require("scripts/settings/player_movement_settings")
require("scripts/managers/backend/statistics_database")
require("scripts/settings/terror_event_blueprints")
require("scripts/unit_extensions/generic/interactions")
require("scripts/settings/survival_settings")

DialogueLookup = DialogueLookup or {}

setmetatable(DialogueLookup, nil)
table.clear(DialogueLookup)

DialogueLookup_n = 0

dofile("dialogues/generated/lookup_witch_hunter")
dofile("dialogues/generated/lookup_bright_wizard")
dofile("dialogues/generated/lookup_dwarf_ranger")
dofile("dialogues/generated/lookup_wood_elf")
dofile("dialogues/generated/lookup_empire_soldier")
dofile("dialogues/generated/lookup_player_conversations")
dofile("dialogues/generated/lookup_npcs")
dofile("dialogues/generated/lookup_special_occasions")
dofile("dialogues/generated/lookup_enemies")
dofile("dialogues/generated/lookup_dlc_01")
dofile("dialogues/generated/lookup_tutorial")
dofile("dialogues/generated/lookup_drachenfels")
dofile("dialogues/generated/lookup_dlc_enemies_01")
dofile("dialogues/generated/lookup_dwarf_dlc")

NetworkLookup = {
	matchmaking_messages = {
		"rpc_matchmaking_handshake_reply",
		"rpc_matchmaking_handshake_complete",
		"rpc_matchmaking_request_profiles_data",
		"rpc_matchmaking_join_game",
		"rpc_matchmaking_request_ready_data",
		"rpc_matchmaking_request_selected_level",
		"rpc_matchmaking_request_selected_difficulty",
		"rpc_matchmaking_request_status_message"
	}
}

for _, message_name in ipairs(NetworkLookup.matchmaking_messages) do
	RPC[message_name] = function (recipient, ...)
		RPC.rpc_matchmaking_generic_message(recipient, NetworkLookup.matchmaking_messages[message_name], ...)

		return 
	end
end

local attachments_table = {}

for attachment_name, attachment_data in pairs(Attachments) do
	attachments_table[#attachments_table + 1] = attachment_name
end

local item_template_table = {}
NetworkLookup.actions = {}
NetworkLookup.sub_actions = {}

for item_template_name, item_template in pairs(Weapons) do
	item_template_table[#item_template_table + 1] = item_template_name

	for action_name, sub_actions in pairs(item_template.actions) do
		if not table.contains(NetworkLookup.actions, action_name) then
			NetworkLookup.actions[#NetworkLookup.actions + 1] = action_name
		end

		for sub_action_name, sub_action_data in pairs(sub_actions) do
			if not table.contains(NetworkLookup.sub_actions, sub_action_name) then
				NetworkLookup.sub_actions[#NetworkLookup.sub_actions + 1] = sub_action_name
			end
		end
	end
end

NetworkLookup.item_names = {
	"n/a"
}

for item_name, item_data in pairs(ItemMasterList) do
	NetworkLookup.item_names[#NetworkLookup.item_names + 1] = item_name
end

NetworkLookup.item_template_names = {
	"n/a"
}

table.append(NetworkLookup.item_template_names, item_template_table)
table.append(NetworkLookup.item_template_names, attachments_table)

NetworkLookup.equipment_slots = {}

for index, slot_settings in ipairs(InventorySettings.slots) do
	NetworkLookup.equipment_slots[#NetworkLookup.equipment_slots + 1] = slot_settings.name
end

NetworkLookup.breeds = {
	"skaven_clan_rat",
	"skaven_slave",
	"skaven_loot_rat",
	"skaven_storm_vermin",
	"skaven_storm_vermin_commander",
	"skaven_poison_wind_globadier",
	"skaven_gutter_runner",
	"skaven_pack_master",
	"skaven_ratling_gunner",
	"skaven_rat_ogre",
	"skaven_stormfiend",
	"critter_pig",
	"critter_rat",
	"debug_ai_profile",
	"skaven_ai_profile"
}
local temp = {}

for breed_name, breed in pairs(Breeds) do
	local translation = breed.hitbox_ragdoll_translation

	if translation then
		for hitbox_actor, ragdoll_actor in pairs(translation) do
			temp[ragdoll_actor] = true
		end
	end
end

local hit_ragdoll_actors = {
	"n/a"
}

for ragdoll_actor, _ in pairs(temp) do
	hit_ragdoll_actors[#hit_ragdoll_actors + 1] = ragdoll_actor
end

NetworkLookup.hit_ragdoll_actors = hit_ragdoll_actors
local damage_sources = {
	"debug",
	"ground_impact",
	"suicide",
	"wounded_degen",
	"heal_on_killing_blow",
	"dot_debuff",
	"overcharge",
	"knockdown_bleed"
}

for hazard, _ in pairs(EnvironmentalHazards) do
	damage_sources[#damage_sources + 1] = hazard
end

table.append(damage_sources, NetworkLookup.item_names)
table.append(damage_sources, NetworkLookup.breeds)

NetworkLookup.damage_sources = damage_sources
NetworkLookup.husks = {
	"units/beings/player/witch_hunter/third_person_base/chr_third_person_husk_base",
	"units/beings/player/bright_wizard/third_person_base/chr_third_person_husk_base",
	"units/beings/player/dwarf_ranger/third_person_base/chr_third_person_husk_base",
	"units/beings/player/way_watcher/third_person_base/chr_third_person_husk_base",
	"units/beings/player/empire_soldier/third_person_base/chr_third_person_husk_base",
	"units/beings/enemies/skaven_clan_rat/chr_skaven_clan_rat",
	"units/beings/enemies/skaven_clan_rat/chr_skaven_clan_rat_baked_var1",
	"units/beings/enemies/skaven_clan_rat/chr_skaven_clan_rat_baked_var2",
	"units/beings/enemies/skaven_clan_rat/chr_skaven_clan_rat_baked_var3",
	"units/beings/enemies/skaven_clan_rat/chr_skaven_clan_rat_baked_var4",
	"units/beings/enemies/skaven_clan_rat/chr_skaven_slave",
	"units/beings/enemies/skaven_clan_rat/chr_skaven_slave_baked",
	"units/beings/enemies/skaven_loot_rat/chr_skaven_loot_rat",
	"units/beings/enemies/skaven_pack_master/chr_skaven_pack_master",
	"units/beings/enemies/skaven_ratlinggunner/chr_skaven_ratlinggunner",
	"units/beings/enemies/skaven_stormvermin/chr_skaven_stormvermin",
	"units/beings/enemies/skaven_wind_globadier/chr_skaven_wind_globadier",
	"units/beings/enemies/skaven_gutter_runner/chr_skaven_gutter_runner",
	"units/beings/enemies/skaven_rat_ogre/chr_skaven_rat_ogre",
	"units/beings/enemies/skaven_stormfiend/chr_skaven_stormfiend",
	"units/beings/critters/chr_critter_pig/chr_critter_pig",
	"units/beings/critters/chr_critter_common_rat/chr_critter_common_rat",
	"units/weapons/player/wpn_crossbow_quiver/wpn_crossbow_bolt_3ps",
	"units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3ps",
	"units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3ps",
	"units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3ps",
	"units/weapons/player/wpn_we_quiver_t1/wpn_we_poison_arrow_t1_3ps",
	"units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps",
	"units/weapons/player/wpn_emp_grenade_01_t1/wpn_emp_grenade_01_t1_3p",
	"units/weapons/player/wpn_emp_grenade_01_t2/wpn_emp_grenade_01_t2_3p",
	"units/weapons/player/wpn_emp_grenade_02_t1/wpn_emp_grenade_02_t1_3p",
	"units/weapons/player/wpn_emp_grenade_02_t2/wpn_emp_grenade_02_t2_3p",
	"units/weapons/player/wpn_emp_grenade_03_t1/wpn_emp_grenade_03_t1_3p",
	"units/weapons/player/wpn_emp_grenade_03_t2/wpn_emp_grenade_03_t2_3p",
	"units/weapons/player/fireball_projectile/fireball_projectile_3ps",
	"units/weapons/player/fireball_projectile/charged_fireball_projectile_3ps",
	"units/weapons/player/flame_wave_projectile/flame_wave_projectile_3ps",
	"units/weapons/player/pup_potion/pup_potion_t1",
	"units/weapons/player/pup_potion/pup_potion_buff",
	"units/weapons/player/pup_first_aid_kit/pup_first_aid_kit",
	"units/weapons/player/pup_first_aid/pup_first_aid",
	"units/props/dice_bowl/pup_loot_die",
	"units/weapons/player/pup_lore_page/pup_lore_page_01",
	"units/weapons/player/pup_sacks/pup_sacks_01",
	"units/weapons/player/pup_drachenfels_statue/pup_drachenfels_statue",
	"units/weapons/player/pup_explosive_barrel/pup_explosive_barrel_01",
	"units/weapons/player/pup_dwarf_barrel_01/pup_dwarf_barrel_01",
	"units/weapons/player/pup_explosive_barrel/pup_gun_powder_barrel_01",
	"units/weapons/player/pup_grenades/pup_grenade_01_t1",
	"units/weapons/player/pup_grenades/pup_grenade_01_t2",
	"units/weapons/player/pup_grenades/pup_grenade_02_t1",
	"units/weapons/player/pup_grenades/pup_grenade_02_t2",
	"units/weapons/player/pup_grenades/pup_grenade_03_t1",
	"units/weapons/player/pup_grenades/pup_grenade_03_t2",
	"units/weapons/player/pup_scrolls/pup_scroll_t1",
	"units/weapons/player/pup_ammo_box/pup_ammo_box",
	"units/weapons/player/pup_ammo_box/pup_ammo_box_limited",
	"units/weapons/player/pup_torch/pup_torch",
	"units/weapons/player/pup_grimoire_01/pup_grimoire_01",
	"units/weapons/player/pup_side_objective_tome/pup_side_objective_tome_01",
	"units/weapons/projectile/poison_wind_globe/poison_wind_globe",
	"units/weapons/player/pup_sacks/pup_sacks_01_test",
	"units/weapons/player/drakegun_projectile/drakegun_projectile_3ps",
	"units/weapons/player/drakegun_projectile_charged/drakegun_projectile_charged_3ps",
	"units/weapons/player/drake_pistol_projectile/drake_pistol_projectile_3ps",
	"units/weapons/player/spear_projectile/spear_3ps",
	"units/weapons/player/spear_projectile/spark_3ps",
	"units/gameplay/gameplay_respawn_cage_01",
	"units/hub_elements/interest_points/pack_spawning/ai_interest_point_1pack",
	"units/hub_elements/interest_points/pack_spawning/ai_interest_point_2pack",
	"units/hub_elements/interest_points/pack_spawning/ai_interest_point_3pack",
	"units/hub_elements/interest_points/pack_spawning/ai_interest_point_4pack",
	"units/hub_elements/interest_points/pack_spawning/ai_interest_point_4pack_02",
	"units/hub_elements/interest_points/pack_spawning/ai_interest_point_6pack_01",
	"units/hub_elements/interest_points/pack_spawning/ai_interest_point_6pack_02",
	"units/hub_elements/interest_points/pack_spawning/ai_interest_point_8pack",
	"units/props/endurance_badges/prop_endurance_badge_01",
	"units/props/endurance_badges/prop_endurance_badge_02",
	"units/props/endurance_badges/prop_endurance_badge_03",
	"units/props/endurance_badges/prop_endurance_badge_04",
	"units/props/endurance_badges/prop_endurance_badge_05"
}
NetworkLookup.go_types = {
	"player",
	"ai_player",
	"team",
	"player_unit",
	"player_bot_unit",
	"ai_unit",
	"ai_unit_with_inventory",
	"ai_unit_pack_master",
	"ai_unit_ratling_gunner",
	"ai_inventory_item",
	"player_projectile_unit",
	"flame_wave_projectile_unit",
	"aoe_projectile_unit",
	"projectile_unit",
	"pickup_torch_unit",
	"pickup_torch_unit_init",
	"pickup_projectile_unit",
	"pickup_projectile_unit_limited",
	"explosive_pickup_projectile_unit",
	"explosive_pickup_projectile_unit_limited",
	"true_flight_projectile_unit",
	"prop_unit",
	"aoe_unit",
	"pickup_unit",
	"objective_pickup_unit",
	"player_profile",
	"music_states",
	"interest_point_unit",
	"interest_point_level_unit",
	"sync_unit"
}
NetworkLookup.spawn_health_state = {
	"alive",
	"bleeding",
	"knocked_down",
	"disabled",
	"dead"
}
NetworkLookup.die_types = {
	"wood",
	"metal",
	"gold",
	"warpstone"
}
NetworkLookup.voice = {
	"husk_vce_charge_swing",
	"husk_vce_swing",
	"chr_vce_finish_off"
}
NetworkLookup.stamina_state = {
	"normal",
	"tired"
}
NetworkLookup.door_states = {
	"closed",
	"open_forward",
	"open_backward"
}
NetworkLookup.movement_states = {
	"climbing",
	"dead",
	"executing",
	"falling_attack",
	"jumping",
	"inair",
	"knocked_down",
	"pounced_down",
	"catapulted",
	"looting",
	"onground",
	"onground/idle",
	"onground/moving",
	"reviving_teammate",
	"bandaging_teammate",
	"bandaging_self",
	"stunned",
	"using_transport",
	"triggering",
	"special_attack",
	"pushing",
	"charging",
	"dodging",
	"waiting_for_assisted_respawn"
}
NetworkLookup.heal_types = {
	"bandage_trinket",
	"healing_draught",
	"proc",
	"potion",
	"bandage",
	"buff",
	"heal_on_killing_blow",
	"shield_by_assist"
}
NetworkLookup.difficulties = {}

for difficulty, _ in pairs(DifficultySettings) do
	NetworkLookup.difficulties[#NetworkLookup.difficulties + 1] = difficulty
end

NetworkLookup.linked_particle_policies = {
	"destroy",
	"stop",
	"unlink"
}
NetworkLookup.collision_filters = {
	"filter_player_and_enemy_hit_box_check",
	"filter_enemy_ray_projectile",
	"filter_player_ray_projectile",
	"filter_player_ray_projectile_no_player",
	"filter_enemy_unit",
	"n/a"
}
NetworkLookup.hit_zones = {
	"head",
	"body",
	"torso",
	"left_arm",
	"right_arm",
	"left_leg",
	"right_leg",
	"tail",
	"neck",
	"n/a",
	"full"
}
NetworkLookup.anims = {
	"attack_charge",
	"attack_charge_fireball",
	"attack_charge_fireball_loop",
	"attack_charge_loop",
	"attack_charge_spear",
	"attack_charge_spear_loop",
	"attack_geiser_end",
	"attack_geiser_loop",
	"attack_geiser_placed",
	"attack_geiser_start",
	"attack_shoot",
	"attack_shoot_beam_end",
	"attack_shoot_beam_finish",
	"attack_shoot_beam_loop",
	"attack_shoot_beam_spark",
	"attack_shoot_beam_start",
	"attack_shoot_charged",
	"attack_shoot_fast",
	"attack_shoot_fast_last",
	"attack_shoot_fireball",
	"attack_shoot_fireball_charged",
	"attack_shoot_last",
	"attack_shoot_rapid_left",
	"attack_shoot_rapid_right",
	"attack_shoot_sparks",
	"attack_shoot_spear_charged",
	"attack_shoot_twin_barrel",
	"attack_shoot_last_twin_barrel",
	"attack_shoot_double_barrel",
	"attack_staff_melee",
	"attack_swing_left",
	"attack_swing_left_diagonal",
	"attack_swing_left_diagonal_last",
	"attack_swing_right",
	"attack_swing_right_diagonal",
	"attack_swing_stab",
	"attack_swing_stab_lh",
	"attack_swing_stab_charge",
	"attack_swing_charge",
	"attack_swing_charge_diagonal_left",
	"attack_swing_charge_diagonal_right",
	"attack_swing_charge_left",
	"attack_swing_charge_right",
	"attack_swing_heavy",
	"attack_swing_heavy_right",
	"attack_swing_heavy_left",
	"attack_swing_heavy_left_diagonal",
	"attack_swing_heavy_right_diagonal",
	"attack_swing_charge_diagonal",
	"attack_swing_charge_left_diagonal",
	"attack_swing_charge_right_diagonal",
	"attack_swing_charge_down",
	"attack_swing_heavy_down",
	"attack_swing_down",
	"attack_swing_down_left",
	"attack_swing_down_right",
	"cooldown_start",
	"cooldown_loop",
	"cooldown_end",
	"dodge_time",
	"foff_self",
	"front_idle_left",
	"front_idle_right",
	"front_idle_exit",
	"dodge_end",
	"interrupt_finished",
	"interrupt",
	"reload",
	"reload_last",
	"stance_charge",
	"lock_target",
	"lower_weapon",
	"parry_pose",
	"parry_finished",
	"parry_break",
	"inspect_start",
	"inspect_end",
	"inspect_start_2",
	"inspect_end_2",
	"shake_hit",
	"shake_get_hit",
	"overheat_indicator",
	"shake_heavy",
	"shake_light",
	"shake_medium",
	"to_passive",
	"to_combat",
	"to_upright",
	"move_start_fwd",
	"move_start_bwd",
	"move_start_left",
	"move_start_right",
	"change_target_fwd",
	"change_target_bwd",
	"change_target_left",
	"change_target_right",
	"roar",
	"roar_2",
	"talk_body_end",
	"stop",
	"attack_run",
	"attack_move",
	"attack_loop",
	"move_fwd_upright",
	"attack_cleave",
	"attack_hit",
	"attack_hit_alt_effect",
	"attack_push",
	"attack_heal",
	"to_zoom",
	"to_unzoom",
	"attack_slam",
	"attack_slam_2",
	"attack_slam_3",
	"attack_slam_4",
	"attack_slam_back",
	"attack_slam_left",
	"attack_slam_right",
	"attack_shove_left",
	"attack_shove_left_run",
	"attack_shove_right",
	"attack_shove_right_run",
	"attack_jump",
	"attack_jump_land",
	"attack_throw",
	"attack_throw_heavy",
	"draw_bow",
	"draw_cancel",
	"draw_bow_loop",
	"dodge_bwd",
	"dodge_left",
	"dodge_right",
	"grenade_charge",
	"grenade_charge_cancel",
	"poison_well",
	"push_backward",
	"push_backward_02",
	"push_backward_03",
	"push_backward_04",
	"push_stab",
	"respawn_floor_loop",
	"respawn_revive",
	"stagger_scale",
	"stagger_finished",
	"stunned",
	"attack_overwhelm",
	"attack_overwhelm_pose",
	"attack_slam_charge",
	"attack_slam_charge_hold",
	"attack_special",
	"falling_fwd",
	"falling_bwd",
	"jump_start",
	"jump_land",
	"jump_attack",
	"jump_fail",
	"jump_attack_stand_up",
	"spawn_pipe_run",
	"spawn_pipe_run_shield",
	"spawn_floor",
	"spawn_floor_2",
	"spawn_floor_3",
	"spawn_window",
	"spawn_window_2",
	"spawn_well",
	"spawn_well_2",
	"spawn_chimney",
	"spawn_chimney_2",
	"spawn_climb_down_10m",
	"spawn_climb_down_10m_2",
	"spawn_climb_down_20m",
	"spawn_climb_down_20m_2",
	"spawn_climb_down_5m",
	"spawn_climb_down_5m_2",
	"spawn_climb_up_10m",
	"spawn_climb_up_10m_2",
	"spawn_climb_up_20m",
	"spawn_climb_up_20m_2",
	"spawn_climb_up_2_5m",
	"spawn_climb_up_2_5m_2",
	"spawn_climb_over_10m",
	"spawn_climb_over_20m",
	"spawn_climb_over_2_5m",
	"attack_foff_self",
	"attack_throw_look",
	"attack_throw_score",
	"attack_pounce",
	"attack_pounce_down",
	"attack_pounce_down_2",
	"attack_pounce_down_3",
	"attack_pounce_up",
	"attack_reach_down",
	"attack_reach_down_2",
	"attack_reach_down_3",
	"attack_reach_up",
	"attack_reach_up_2",
	"attack_reach_up_3",
	"attack_reach_up_4",
	"combat_idle",
	"death",
	"idle",
	"idle_looking_around",
	"shout",
	"dig_door",
	"dig_ground",
	"order",
	"alerted",
	"alerted_fwd",
	"alerted_bwd",
	"alerted_right",
	"alerted_left",
	"dodge_run_fwd",
	"explode_loop",
	"explode_start",
	"hesitate_wall",
	"idle_passive_sleep",
	"idle_passive_sit",
	"idle_passive_sit_2",
	"idle_passive_sit_talk",
	"idle_passive_sit_talk_2",
	"idle_passive_play_dice",
	"idle_passive_play_dice_2",
	"idle_passive_play_dice_3",
	"idle_passive_eat",
	"idle_passive_talk",
	"idle_passive_talk_2",
	"idle_passive_listen",
	"idle_passive_talk_crowd",
	"idle_passive_look_down",
	"idle_passive_look_down_2",
	"idle_passive_look_down_3",
	"idle_passive_look_up",
	"idle_passive_look_up_2",
	"idle_passive_look_up_3",
	"idle_passive_loot",
	"idle_passive_sit_loot",
	"idle_passive_sit_loot_2",
	"idle_passive_bang_door",
	"idle_passive_bang_door_2",
	"idle_passive_guard",
	"no_anim",
	"ragdoll",
	"reload_start",
	"reload_loop",
	"reset",
	"run",
	"attack_shoot_align",
	"attack_shoot_start",
	"screenshot_inn_00",
	"screenshot_inn_01",
	"screenshot_inn_02",
	"screenshot_inn_03",
	"screenshot_inn_04",
	"screenshot_magnus_01",
	"screenshot_sewers_01",
	"screenshot_farm_01",
	"screenshot_wizard_01",
	"screenshot_tunnels_01",
	"screenshot_bridge_01",
	"screenshot_1",
	"screenshot_2",
	"screenshot_3",
	"screenshot_4",
	"screenshot_5",
	"screenshot_6",
	"screenshot_7",
	"screenshot_8",
	"screenshot_9",
	"sprint",
	"suicide_run_start",
	"surprised_fwd",
	"smash_door",
	"walk",
	"wind_up_start",
	"wind_up_loop",
	"attack_finished",
	"death_instakill",
	"death_decap",
	"interaction_end",
	"interaction_exit",
	"interaction_generic",
	"interaction_bandage_self",
	"interaction_bandage_team",
	"interaction_start",
	"jump_fwd",
	"jump_idle",
	"knockdown_fall_front",
	"knockdown",
	"land_knocked_down",
	"land_heavy_moving_bwd",
	"land_heavy_moving_fwd",
	"land_heavy_moving_still",
	"land_heavy_still",
	"land_moving_bwd",
	"land_moving_fwd",
	"land_moving_still",
	"land_still",
	"move_bwd",
	"move_fwd",
	"move_fwd_walk",
	"move_bwd_walk",
	"move_right_walk",
	"move_left_walk",
	"move_fwd_run",
	"climb_enter_ladder",
	"climb_top_enter_ladder",
	"climb_move_ladder",
	"climb_idle_mid_ladder",
	"climb_idle_right_ladder",
	"climb_idle_left_ladder",
	"climb_top_exit_ladder",
	"climb_end_ladder",
	"hit_reaction",
	"hit_reaction_back",
	"hit_reaction_left",
	"hit_reaction_right",
	"to_1h_sword",
	"to_1h_sword_shield",
	"to_2h_hammer",
	"to_2h_sword",
	"to_2h_sword_we",
	"to_2h_axe_we",
	"to_blunderbuss",
	"to_blunderbuss_noammo",
	"to_bow",
	"to_bow_noammo",
	"to_repeating_crossbow",
	"to_repeating_crossbow_noammo",
	"to_crossbow",
	"to_crossbow_noammo",
	"to_crossbow_loaded",
	"to_crouch",
	"to_drakegun",
	"to_drakegun_noammo",
	"to_fencing_sword",
	"to_first_aid",
	"to_grudge_raker",
	"to_grudge_raker_noammo",
	"to_handgun",
	"to_handgun_noammo",
	"to_longbow",
	"to_potion",
	"to_inair",
	"to_onground",
	"to_dual_pistol",
	"to_dual_repeater_pistols",
	"to_drakefire_pistols",
	"to_repeater_pistol",
	"to_repeating_handgun",
	"to_repeating_handgun_noammo",
	"to_packmaster_claw",
	"to_sack",
	"to_barrel",
	"to_shield",
	"to_staff",
	"to_unarmed",
	"to_uncrouch",
	"to_unshield",
	"unwield_left_arm_back",
	"unwield_right_arm_right_hip",
	"unwield_right_arm_left_hip",
	"wield_finished",
	"wield_left_arm_back",
	"wield_right_arm_left_hip",
	"wield_right_arm_right_hip",
	"attack_time",
	"wield_time",
	"attack_speed",
	"climb_enter_exit_speed",
	"jump_down_land",
	"jump_over_gap_4m",
	"push_init",
	"climb_time",
	"drag_walk",
	"attack_grab",
	"packmaster_hooked",
	"packmaster_release",
	"packmaster_release_death",
	"packmaster_release_ko",
	"packmaster_hang_release",
	"packmaster_hang_release_death",
	"packmaster_hang_release_ko",
	"hanging",
	"hanging_loop",
	"hanging_exit"
}
NetworkLookup.bt_action_names = {
	"n/a"
}
NetworkLookup.lobby_data = {
	"level_key",
	"selected_level_key",
	"num_players",
	"matchmaking",
	"player_slot_1",
	"player_slot_2",
	"player_slot_3",
	"player_slot_4",
	"player_slot_5",
	"host",
	"network_hash",
	"unique_server_name",
	"difficulty",
	"game_started",
	"room_id",
	"session_id",
	"is_private",
	"time_of_search",
	"required_progression"
}
NetworkLookup.lobby_data_matchmaking_values = {
	"false",
	"true",
	"searching"
}
NetworkLookup.buff_proc_attack_types = {
	"aoe",
	"projectile",
	"heavy_attack",
	"light_attack",
	"instant_projectile"
}
local anims_temp = {}
local actions_temp = {}

for _, breed_data in pairs(BreedActions) do
	for action_name, action_data in pairs(breed_data) do
		actions_temp[action_name] = true

		if action_name == "stagger" then
			local anims_table = action_data.stagger_anims

			for _, dir_table in ipairs(anims_table) do
				for _, anims in pairs(dir_table) do
					for _, anim in ipairs(anims) do
						anims_temp[anim] = anim
					end
				end
			end
		elseif action_name == "blocked" then
			local anims_table = action_data.blocked_anims

			for _, anim in ipairs(anims_table) do
				anims_temp[anim] = anim
			end
		end
	end
end

local smart_object_animation_types = {
	"animation_edge",
	"animation_fence"
}

for _, template in pairs(SmartObjectSettings.templates) do
	for _, threshold_table_types in pairs(template) do
		for _, threshold_table in ipairs(threshold_table_types) do
			for _, animation_type in ipairs(smart_object_animation_types) do
				local anim_config = threshold_table[animation_type]

				if type(anim_config) == "table" then
					for _, anim in ipairs(anim_config) do
						anims_temp[anim] = anim
					end
				else
					anims_temp[anim_config] = anim_config
				end
			end
		end
	end
end

for _, direction in pairs(PlayerUnitMovementSettings.catapulted.directions) do
	for _, anim in pairs(direction) do
		anims_temp[anim] = anim
	end
end

local actions_table = NetworkLookup.bt_action_names
local new_action_index = #actions_table + 1

for action_name, _ in pairs(actions_temp) do
	actions_table[new_action_index] = action_name
	new_action_index = new_action_index + 1
end

for _, variation_table in pairs(BTHesitationVariations) do
	for _, variation_name in pairs(variation_table) do
		anims_temp[variation_name] = variation_name
	end
end

local anims_table = NetworkLookup.anims
local new_index = #anims_table + 1

for anim, _ in pairs(anims_temp) do
	anims_table[new_index] = anim
	new_index = new_index + 1
end

table.clear(anims_temp)
table.clear(actions_temp)

NetworkLookup.damage_types = {
	"buff",
	"arrow",
	"yield",
	"kinetic",
	"cutting",
	"player_stunned_damage",
	"piercing",
	"slashing_buffed",
	"slashing",
	"blunt",
	"projectile",
	"player_overcharge_explosion_brw",
	"player_overcharge_explosion_dwarf",
	"knockdown_bleed",
	"light_slashing_linesman",
	"light_slashing_linesman_hs",
	"slashing_linesman",
	"heavy_slashing_linesman",
	"light_slashing_smiter",
	"slashing_smiter",
	"heavy_slashing_smiter",
	"light_slashing_fencer",
	"slashing_fencer",
	"heavy_slashing_fencer",
	"light_slashing_tank",
	"slashing_tank",
	"heavy_slashing_tank",
	"light_blunt_linesman",
	"blunt_linesman",
	"heavy_blunt_linesman",
	"light_blunt_smiter",
	"blunt_smiter",
	"heavy_blunt_smiter",
	"light_blunt_fencer",
	"blunt_fencer",
	"heavy_blunt_fencer",
	"light_blunt_tank",
	"blunt_tank",
	"blunt_tank_uppercut",
	"heavy_blunt_tank",
	"light_stab_linesman",
	"stab_linesman",
	"heavy_stab_linesman",
	"light_stab_smiter",
	"stab_smiter",
	"heavy_stab_smiter",
	"light_stab_fencer",
	"stab_fencer",
	"burning_stab_fencer",
	"heavy_stab_fencer",
	"light_stab_tank",
	"stab_tank",
	"heavy_stab_tank",
	"shot_sniper",
	"shot_carbine",
	"shot_machinegun",
	"shot_shotgun",
	"shot_repeating_handgun",
	"drakegun",
	"drakegun_shot",
	"drakegun_glance",
	"arrow_sniper",
	"arrow_carbine",
	"arrow_machinegun",
	"arrow_poison",
	"bolt_sniper",
	"bolt_carbine",
	"bolt_machinegun",
	"burn",
	"burn_sniper",
	"burn_shotgun",
	"burn_carbine",
	"burn_machinegun",
	"burninating",
	"burning_tank",
	"heavy_burning_tank",
	"light_burning_linesman",
	"burning_linesman",
	"damage_over_time",
	"wounded_dot",
	"arrow_poison_dot",
	"aoe_poison_dot",
	"death_zone",
	"crush",
	"poison",
	"forced",
	"grenade",
	"grenade_glance",
	"fire_grenade",
	"fire_grenade_glance",
	"destructible_level_object_hit",
	"push",
	"pack_master_grab",
	"overcharge",
	"weapon_bleed_dot_test",
	"sync_health",
	"killing_blow",
	"volume_generic_dot",
	"volume_insta_kill",
	"globadier_gas_dot",
	"inside_forbidden_tag_volume",
	"undefined"
}
NetworkLookup.buff_templates = {
	"damage_boost_potion_weak",
	"speed_boost_potion_weak",
	"invulnerability_potion_weak",
	"damage_boost_potion_medium",
	"speed_boost_potion_medium",
	"invulnerability_potion_medium",
	"damage_boost_potion",
	"speed_boost_potion",
	"invulnerability_potion",
	"damage_reduction_boost",
	"super_jump",
	"increase_all_healing",
	"tank_stance",
	"ninja_fencer_stance",
	"smiter_stance",
	"lines_man_stance",
	"imba_super_test_buff",
	"arrow_poison_dot",
	"movement_volume_generic_slowdown",
	"globadier_gas_dot",
	"grimoire_health_debuff",
	"increase_incoming_damage"
}
NetworkLookup.group_buff_templates = {
	"grimoire"
}
NetworkLookup.coop_feedback = {
	"give_item",
	"aid",
	"save",
	"heal",
	"assisted_respawn",
	"revive",
	"discarded_grimoire"
}
NetworkLookup.projectile_templates = {
	"throw_trajectory",
	"grenade_impact",
	"explosion_impact",
	"arrow_impact",
	"pickup_impact",
	"explosion",
	"spawn_pickup",
	"skull_staff"
}
NetworkLookup.explosion_templates = {
	"n/a"
}

for name, template in pairs(ExplosionTemplates) do
	NetworkLookup.explosion_templates[#NetworkLookup.explosion_templates + 1] = name
end

NetworkLookup.area_damage_templates = {}

for name, template in pairs(AreaDamageTemplates.templates) do
	NetworkLookup.area_damage_templates[#NetworkLookup.area_damage_templates + 1] = name
end

NetworkLookup.game_end_reasons = {
	"won",
	"lost",
	"start_game"
}
NetworkLookup.set_wounded_reasons = {
	"healed",
	"knocked_down",
	"revived",
	"reached_min_health"
}
NetworkLookup.level_keys = {
	"next_level"
}

for name, _ in pairs(LevelSettings) do
	NetworkLookup.level_keys[#NetworkLookup.level_keys + 1] = name
end

NetworkLookup.game_mode_keys = {}

for name, _ in pairs(GameModeSettings) do
	NetworkLookup.game_mode_keys[#NetworkLookup.game_mode_keys + 1] = name
end

NetworkLookup.fatigue_types = {}

for fatigue_type, _ in pairs(PlayerUnitStatusSettings.fatigue_point_costs) do
	NetworkLookup.fatigue_types[#NetworkLookup.fatigue_types + 1] = fatigue_type
end

NetworkLookup.pickup_names = {}

for pickup_name, _ in pairs(AllPickups) do
	NetworkLookup.pickup_names[#NetworkLookup.pickup_names + 1] = pickup_name
end

NetworkLookup.pickup_spawn_types = {
	"spawner",
	"guaranteed",
	"triggered",
	"dropped",
	"thrown",
	"limited",
	"loot",
	"rare",
	"debug"
}
NetworkLookup.effects = {
	"n/a",
	"fx/handgonne_muzzle_flash",
	"fx/impact_blood",
	"fx/bullet_sand",
	"fx/wpnfx_pistol_bullet_trail",
	"fx/wpnfx_barrel_explosion",
	"fx/wpnfx_grenade_impact",
	"fx/wpnfx_frag_grenade_impact",
	"fx/wpnfx_smoke_grenade_impact",
	"fx/wpnfx_fire_grenade_impact",
	"fx/wpnfx_warplock_pistol_impact_flesh",
	"fx/chr_player_fak_healed",
	"fx/wpnfx_poison_wind_globe_impact",
	"fx/chr_gutter_death",
	"fx/scroll_push_back",
	"fx/scroll_magic_darts",
	"fx/screenspace_poison_globe_impact",
	"fx/wpnfx_fire_grenade_impact_remains",
	"fx/wpnfx_poison_arrow_impact",
	"fx/wpnfx_poison_arrow_impact_sniper",
	"fx/wpnfx_poison_arrow_impact_machinegun",
	"fx/wpnfx_poison_arrow_impact_carbine",
	"fx/wpnfx_staff_beam_trail",
	"fx/wpnfx_staff_beam_trail_3p",
	"fx/wpnfx_staff_beam_target",
	"fx/wpnfx_staff_geiser_charge",
	"fx/wpnfx_staff_geiser_fire_small",
	"fx/wpnfx_staff_geiser_fire_medium",
	"fx/wpnfx_staff_geiser_fire_large",
	"fx/chr_gutter_foff",
	"spawn_cylinder"
}
local lwp_particle_effects = {}

for name, _ in pairs(LightWeightProjectileParticleEffects) do
	lwp_particle_effects[#lwp_particle_effects + 1] = name
end

NetworkLookup.light_weight_projectile_particle_effects = lwp_particle_effects
NetworkLookup.grenades = {
	"impact_grenade",
	"dot_grenade"
}
NetworkLookup.localized_strings = {
	"level_completed",
	"attackers_win",
	"flag_captured",
	"flag_lost_fallback",
	"defenders_win",
	"attackers_zone",
	"defenders_zone",
	"neutral_zone"
}
NetworkLookup.surface_material_effects = {}

for name, _ in pairs(MaterialEffectMappings) do
	NetworkLookup.surface_material_effects[#NetworkLookup.surface_material_effects + 1] = name
end

NetworkLookup.local_player_id = {
	"local_player_1",
	"local_player_2",
	"local_player_3",
	"local_player_4",
	"player_bot_1",
	"player_bot_2",
	"player_bot_3",
	"player_bot_4",
	"enemy_main"
}
NetworkLookup.interactions = {}
local i = 1

for name, _ in pairs(InteractionDefinitions) do
	NetworkLookup.interactions[i] = name
	i = i + 1
end

NetworkLookup.interaction_states = {
	"starting_interaction",
	"doing_interaction",
	"waiting_to_interact",
	"stopping_interaction"
}
NetworkLookup.statuses = {
	"knocked_down",
	"pounced_down",
	"dead",
	"blocking",
	"wounded",
	"revived",
	"pushed",
	"pack_master_pulling",
	"pack_master_dragging",
	"pack_master_hoisting",
	"pack_master_hanging",
	"pack_master_dropping",
	"pack_master_released",
	"pack_master_unhooked",
	"crouching",
	"pulled_up",
	"ready_for_assisted_respawn",
	"assisted_respawning",
	"respawned",
	"ladder_climbing",
	"ledge_hanging",
	"overcharge_exploding",
	"dodging"
}
NetworkLookup.sound_events = {
	"bullet_pass_by",
	"enemy_horde_stinger",
	"enemy_terror_event_stinger",
	"horde_stinger_skaven_gutter_runner",
	"chr_vce_enemy_idle",
	"player_combat_weapon_grenade_explosion",
	"player_combat_weapon_drakegun_fire",
	"Play_enemy_globadier_suicide_start",
	"Play_enemy_combat_globadier_suicide_explosion",
	"Stop_enemy_foley_globadier_boiling_loop",
	"Play_loot_rat_near_sound",
	"Play_storm_vermin_patrol_loop",
	"Stop_storm_vermin_patrol_loop",
	"player_combat_weapon_staff_fireball_fire",
	"player_combat_weapon_drakepistol_fire",
	"weapon_staff_spark_spear_charged",
	"weapon_staff_spark_spear",
	"player_combat_weapon_staff_geiser_fire",
	"player_combat_weapon_bow_fire_light_poison",
	"player_combat_weapon_bow_fire_heavy_poison",
	"player_combat_weapon_bow_fire_light_homing",
	"player_combat_weapon_bow_fire_heavy_homing",
	"player_combat_weapon_bow_fire_heavy",
	"player_combat_weapon_bow_fire_light",
	"player_combat_weapon_shortbow_fire_light_poison",
	"player_combat_weapon_shortbow_fire_heavy_poison",
	"player_combat_weapon_shortbow_fire_light_homing",
	"player_combat_weapon_shortbow_fire_heavy_homing",
	"player_combat_weapon_shortbow_fire_heavy",
	"player_combat_weapon_shortbow_fire_light",
	"storm_vermin_patrol_formate",
	"Play_stormvermin_patrol_foley",
	"storm_vermin_patrol_player_spotted",
	"storm_vermin_patrol_charge",
	"Play_stormvemin_patrol_formated",
	"Play_stormvermin_patrol_forming",
	"weapon_staff_fire_cone",
	"Play_clan_rat_attack_player_back_vce",
	"Play_clan_rat_attack_player_vce",
	"Play_clan_rat_attack_vce",
	"Play_hud_enemy_attack_back_hit",
	"player_combat_weapon_staff_charge_husk",
	"stop_player_combat_weapon_staff_charge_husk",
	"player_combat_weapon_staff_fire_beam_husk",
	"stop_player_combat_weapon_staff_fire_beam_husk"
}
NetworkLookup.global_parameter_names = {
	"occupied_slots_percentage"
}
local weapon_sound_events = {}

for _, weapon_table in pairs(Weapons) do
	for _, action_table in pairs(weapon_table.actions) do
		for _, sub_action_table in pairs(action_table) do
			if sub_action_table.impact_sound_event then
				weapon_sound_events[sub_action_table.impact_sound_event] = true
			end

			if sub_action_table.no_damage_impact_sound_event then
				weapon_sound_events[sub_action_table.no_damage_impact_sound_event] = true
			end
		end
	end
end

for sound_event_name, _ in pairs(weapon_sound_events) do
	NetworkLookup.sound_events[#NetworkLookup.sound_events + 1] = sound_event_name
end

NetworkLookup.melee_impact_sound_types = {}
local attack_template_sound_types = {}

for _, attack_template in pairs(AttackTemplates) do
	local sound_type = attack_template.sound_type

	if sound_type then
		attack_template_sound_types[sound_type] = true
	end
end

for sound_type, _ in pairs(attack_template_sound_types) do
	NetworkLookup.melee_impact_sound_types[#NetworkLookup.melee_impact_sound_types + 1] = sound_type
end

NetworkLookup.sound_event_param_names = {
	"drakegun_charge_fire",
	"enemy_vo"
}
NetworkLookup.sound_event_param_string_values = {
	"skaven_slave"
}
NetworkLookup.gate_states = {
	"open",
	"closed"
}
NetworkLookup.movement_funcs = {
	"none",
	"update_local_animation_driven_movement"
}
NetworkLookup.ai_inventory = {
	"empty",
	"sword",
	"spear",
	"halberd",
	"sword_and_shield",
	"pack_master",
	"loot_rat_sack",
	"ratlinggun",
	"rat_ogre",
	"gutter_runner"
}
NetworkLookup.connection_fails = {
	"no_peer_data_on_join",
	"no_peer_data_on_enter_game",
	"no_peer_data_on_drop_in",
	"no_peer_data_on_connection_state",
	"no_peer_data_on_game_object_sync_done",
	"unable_to_acquire_profile",
	"host_left_game",
	"unknown_error"
}
NetworkLookup.health_statuses = {
	"alive",
	"respawn",
	"disabled",
	"knocked_down",
	"dead"
}
NetworkLookup.dialogue_events = {
	"startled",
	"backstab",
	"pwg_projectile_hit",
	"enemy_attack",
	"surrounded",
	"knocked_down",
	"throwing_item",
	"running",
	"commanding",
	"shouting",
	"command_change_target",
	"command_globadier",
	"command_gutter_runner",
	"command_rat_ogre",
	"stance_triggered",
	"on_healing_draught",
	"falling",
	"landing"
}
NetworkLookup.dialogue_event_data_names = {
	"num_units",
	"distance",
	"height_distance",
	"attack_tag",
	"rat_ogre_change_target",
	"pwg_projectile",
	"pwg_suicide_run",
	"current_amount",
	"thrower_name",
	"bomb_miss",
	"target_name",
	"has_shield",
	"witch_hunter",
	"empire_soldier",
	"dwarf_ranger",
	"bright_wizard",
	"wood_elf",
	"item_type",
	"grenade",
	"grimoire",
	"torch",
	"grain_sack",
	"beer_barrel",
	"explosive_barrel",
	"explosive_barrel_objective",
	"drachenfels_statue",
	"dwarf_explosive_barrel",
	"stance_type",
	"offensive",
	"defensive",
	"horde",
	"horde_type",
	"ambush",
	"vector"
}
NetworkLookup.music_states = {
	"in_combat"
}
NetworkLookup.music_group_states = {
	"high_battle",
	"med_battle",
	"low_battle",
	"normal",
	"need_help",
	"knocked_down",
	"dead",
	"explore",
	"lost",
	"survival_lost",
	"won",
	"pre_horde",
	"pre_ambush",
	"horde",
	"no_boss",
	"rat_ogre",
	"storm_vermin_patrol"
}
NetworkLookup.locations = {
	"test",
	"test2"
}
NetworkLookup.statistics = {
	"killed_patrols",
	"best_projectile_multikill"
}
local music_group_states = {}
local music_lookups = NetworkLookup.music_group_states

for _, state in ipairs(music_lookups) do
	music_group_states[state] = true
end

for level, settings in pairs(LevelSettings) do
	if type(settings) == "table" then
		for i, location in ipairs(settings.locations) do
			NetworkLookup.locations[#NetworkLookup.locations + 1] = location
		end

		local won_state = settings.music_won_state

		if won_state and not music_group_states[won_state] then
			music_lookups[#music_lookups + 1] = won_state
			music_group_states[won_state] = true
		end
	end
end

NetworkLookup.tutorials = {
	"elite_enemies",
	"skaven_loot_rat",
	"skaven_storm_vermin",
	"skaven_storm_vermin_commander",
	"skaven_poison_wind_globadier",
	"skaven_gutter_runner",
	"skaven_pack_master",
	"skaven_ratling_gunner",
	"skaven_rat_ogre",
	"skaven_stormfiend"
}
NetworkLookup.pacing = {
	"pacing_build_up",
	"pacing_sustain_peak",
	"pacing_peak_fade",
	"pacing_relax"
}
NetworkLookup.game_ping_reply = {
	"lobby_ok",
	"lobby_id_mismatch",
	"game_mode_ended",
	"not_searching_for_players",
	"obsolete_request"
}
NetworkLookup.sync_names = {
	"ferry_lady",
	"ferry_lady2"
}
NetworkLookup.boons = {
	"n/a"
}

for name, data in pairs(BoonTemplates) do
	NetworkLookup.boons[#NetworkLookup.boons + 1] = name
end

local function statistics_path_names(path_names, stat)
	if not stat.value then
		for stat_name, stat_definition in pairs(stat) do
			path_names[stat_name] = true

			statistics_path_names(path_names, stat_definition)
		end
	end

	return 
end

NetworkLookup.statistics_path_names = {}
local path_names = {}

for category, stat_definitions in pairs(StatisticsDefinitions) do
	statistics_path_names(path_names, stat_definitions)
end

for path_name, _ in pairs(path_names) do
	NetworkLookup.statistics_path_names[#NetworkLookup.statistics_path_names + 1] = path_name
end

NetworkLookup.mission_names = {}

for name, data in pairs(Missions) do
	NetworkLookup.mission_names[#NetworkLookup.mission_names + 1] = name
end

NetworkLookup.inventory_packages = dofile("scripts/network_lookup/inventory_package_list")
NetworkLookup.projectile_gravity_settings = {}

for name, settings in pairs(ProjectileGravitySettings) do
	NetworkLookup.projectile_gravity_settings[#NetworkLookup.projectile_gravity_settings + 1] = name
end

NetworkLookup.voting_types = {}

for voting_type_name, data in pairs(VoteTemplates) do
	NetworkLookup.voting_types[#NetworkLookup.voting_types + 1] = voting_type_name
end

local lookup_table = {}
local flow_events = {}

for _, blueprint in pairs(TerrorEventBlueprints) do
	for _, event in ipairs(blueprint) do
		local name = event.flow_event_name

		if name and not event.disable_network_send then
			flow_events[name] = true
		end
	end
end

local i = 0

for name, _ in pairs(flow_events) do
	i = i + 1
	lookup_table[i] = name
end

NetworkLookup.terror_flow_events = lookup_table

local function init(self, name)
	for index, str in ipairs(self) do
		fassert(not self[str], "[NetworkLookup.lua] Duplicate entry %q in %q.", str, name)

		self[str] = index
	end

	local index_error_print = "[NetworkLookup.lua] Table " .. name .. " does not contain key: "
	local meta = {
		__index = function (_, key)
			error(index_error_print .. tostring(key))

			return 
		end
	}

	setmetatable(self, meta)

	return 
end

local DialogueLookup = DialogueLookup
NetworkLookup.dialogues = DialogueLookup

for key, lookup_table in pairs(NetworkLookup) do
	init(lookup_table, key)
end

return 
