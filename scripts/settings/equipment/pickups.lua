Pickups = Pickups or {}
Pickups.healing = Pickups.healing or {}
Pickups.healing.first_aid_kit = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_healthkit",
	item_description = "healthkit_first_aid_kit_01",
	spawn_weighting = 0.5,
	pickup_sound_event = "pickup_medkit",
	dupable = true,
	item_name = "healthkit_first_aid_kit_01",
	unit_name = "units/weapons/player/pup_first_aid/pup_first_aid",
	local_pickup_sound = true,
	hud_description = "pickup_first_aid_kit"
}
Pickups.healing.healing_draught = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_healthkit",
	item_description = "healthkit_first_aid_kit_01",
	spawn_weighting = 0.5,
	pickup_sound_event = "pickup_medkit",
	dupable = true,
	item_name = "potion_healing_draught_01",
	unit_name = "units/weapons/player/pup_potion/pup_potion_t1",
	local_pickup_sound = true,
	hud_description = "pickup_healing_draught_potion"
}
Pickups.potions = Pickups.potions or {}
Pickups.potions.damage_boost_potion = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_potion",
	item_description = "potion_damage_boost_01",
	spawn_weighting = 0.2,
	pickup_sound_event = "pickup_potion",
	dupable = true,
	bots_mule_pickup = true,
	item_name = "potion_damage_boost_01",
	unit_name = "units/weapons/player/pup_potion/pup_potion_buff",
	local_pickup_sound = true,
	hud_description = "pickup_damage_boost_potion"
}
Pickups.potions.speed_boost_potion = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_potion",
	item_description = "potion_speed_boost_01",
	spawn_weighting = 0.2,
	pickup_sound_event = "pickup_potion",
	dupable = true,
	bots_mule_pickup = true,
	item_name = "potion_speed_boost_01",
	unit_name = "units/weapons/player/pup_potion/pup_potion_buff",
	local_pickup_sound = true,
	hud_description = "pickup_speed_boost_potion"
}
Pickups.level_events = Pickups.level_events or {}
Pickups.level_events.grain_sack = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "inventory_item",
	item_description = "grain_sack",
	spawn_weighting = 1,
	item_name = "grain_sack",
	unit_name = "units/weapons/player/pup_sacks/pup_sacks_01",
	unit_template_name = "pickup_projectile_unit_limited",
	wield_on_pickup = true,
	hud_description = "pickup_sack"
}
Pickups.level_events.drachenfels_statue = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "inventory_item",
	item_description = "statue",
	spawn_weighting = 1,
	item_name = "drachenfels_statue",
	unit_name = "units/weapons/player/pup_drachenfels_statue/pup_drachenfels_statue",
	unit_template_name = "pickup_projectile_unit_limited",
	wield_on_pickup = true,
	hud_description = "dlc1_4_pickup_statue"
}
Pickups.level_events.torch = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "inventory_item",
	item_description = "torch",
	spawn_weighting = 1,
	teleport_time = 40,
	item_name = "torch",
	unit_name = "units/weapons/player/pup_torch/pup_torch",
	unit_template_name = "pickup_torch_unit_init",
	wield_on_pickup = true,
	hud_description = "pickup_torch"
}
Pickups.level_events.explosive_barrel = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "explosive_inventory_item",
	item_description = "explosive_barrel",
	spawn_weighting = 1,
	item_name = "explosive_barrel",
	unit_name = "units/weapons/player/pup_explosive_barrel/pup_explosive_barrel_01",
	additional_data_func = "explosive_barrel",
	unit_template_name = "explosive_pickup_projectile_unit",
	wield_on_pickup = true,
	hud_description = "pickup_explosive_barrel"
}
Pickups.level_events.dwarf_explosive_barrel = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "explosive_inventory_item",
	item_description = "dwarf_explosive_barrel",
	spawn_weighting = 1,
	item_name = "dwarf_explosive_barrel",
	unit_name = "units/weapons/player/pup_dwarf_barrel_01/pup_dwarf_barrel_01",
	additional_data_func = "explosive_barrel",
	unit_template_name = "explosive_pickup_projectile_unit_limited",
	wield_on_pickup = true,
	hud_description = "pickup_explosive_barrel"
}
Pickups.level_events.explosive_barrel_objective = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "explosive_inventory_item",
	item_description = "explosive_barrel_objective",
	spawn_weighting = 1,
	item_name = "explosive_barrel_objective",
	unit_name = "units/weapons/player/pup_explosive_barrel/pup_gun_powder_barrel_01",
	additional_data_func = "explosive_barrel",
	unit_template_name = "explosive_pickup_projectile_unit_limited",
	wield_on_pickup = true,
	hud_description = "pickup_explosive_barrel_objective"
}
Pickups.level_events.beer_barrel = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "inventory_item",
	item_description = "beer_barrel",
	spawn_weighting = 1,
	item_name = "beer_barrel",
	unit_name = "units/weapons/player/pup_explosive_barrel/pup_explosive_barrel_01",
	unit_template_name = "pickup_unit",
	wield_on_pickup = true,
	hud_description = "pickup_beer_barrel"
}
Pickups.level_events.grimoire = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_potion",
	item_description = "grimoire",
	spawn_weighting = 1,
	pickup_sound_event = "pickup_medkit",
	item_name = "wpn_grimoire_01",
	unit_name = "units/weapons/player/pup_grimoire_01/pup_grimoire_01",
	local_pickup_sound = true,
	hud_description = "pickup_grimoire"
}
Pickups.level_events.tome = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_healthkit",
	item_description = "tome",
	spawn_weighting = 1,
	pickup_sound_event = "pickup_medkit",
	item_name = "wpn_side_objective_tome_01",
	unit_name = "units/weapons/player/pup_side_objective_tome/pup_side_objective_tome_01",
	local_pickup_sound = true,
	hud_description = "pickup_tome"
}
Pickups.level_events.cannon_ball = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "inventory_item",
	item_description = "cannon_ball",
	spawn_weighting = 1,
	item_name = "wpn_cannon_ball_01",
	unit_name = "units/weapons/player/pup_cannon_ball_01/pup_cannon_ball_01",
	unit_template_name = "pickup_projectile_unit_limited",
	wield_on_pickup = true,
	hud_description = "fort_cannon_ball_pickup"
}
Pickups.level_events.wooden_sword_01 = {
	only_once = false,
	slot_name = "slot_level_event",
	type = "inventory_item",
	spawn_weighting = 1,
	item_name = "wooden_sword_01",
	unit_name = "units/weapons/player/pup_wooden_sword_01/pup_wooden_sword_01",
	unit_template_name = "pickup_unit",
	wield_on_pickup = true,
	hud_description = "lol this is a sword"
}
Pickups.level_events.wooden_sword_02 = {
	only_once = false,
	slot_name = "slot_level_event",
	type = "inventory_item",
	spawn_weighting = 1,
	item_name = "wooden_sword_02",
	unit_name = "units/weapons/player/pup_wooden_sword_02/pup_wooden_sword_02",
	unit_template_name = "pickup_unit",
	wield_on_pickup = true,
	hud_description = "lol this is a sword too"
}
Pickups.level_events.brawl_unarmed = {
	only_once = false,
	slot_name = "slot_level_event",
	type = "inventory_item",
	spawn_weighting = 1,
	item_name = "brawl_unarmed",
	unit_name = "units/weapons/player/pup_explosive_barrel/pup_explosive_barrel_01",
	unit_template_name = "pickup_unit",
	wield_on_pickup = true,
	hud_description = "lol this is not a sword"
}
Pickups.ammo = Pickups.ammo or {}
Pickups.ammo.all_ammo = {
	only_once = false,
	type = "ammo",
	spawn_weighting = 1,
	unit_name = "units/weapons/player/pup_ammo_box/pup_ammo_box",
	unit_template_name = "pickup_unit",
	local_pickup_sound = true,
	hud_description = "pickup_all_ammo",
	pickup_sound_event_func = function (interactor_unit, interactable_unit, data)
		local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")
		local full_ammo = inventory_extension.has_full_ammo(inventory_extension)

		return (full_ammo and "pickup_ammo_full") or "pickup_ammo"
	end,
	can_interact_func = function (interactor_unit, interactable_unit, data)
		local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")

		return inventory_extension.has_ammo_consuming_weapon_equipped(inventory_extension)
	end
}
Pickups.ammo.all_ammo_small = {
	only_once = true,
	spawn_weighting = 2,
	type = "ammo",
	pickup_sound_event = "pickup_ammo",
	unit_name = "units/weapons/player/pup_ammo_box/pup_ammo_box_limited",
	unit_template_name = "pickup_unit",
	local_pickup_sound = true,
	hud_description = "pickup_all_ammo_once",
	can_interact_func = function (interactor_unit, interactable_unit, data)
		local inventory_extension = ScriptUnit.extension(interactor_unit, "inventory_system")

		return inventory_extension.has_ammo_consuming_weapon_equipped(inventory_extension)
	end
}
Pickups.grenades = Pickups.grenades or {}
Pickups.grenades.frag_grenade_t1 = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_grenade",
	item_description = "grenade_frag",
	spawn_weighting = 0.8,
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	bots_mule_pickup = true,
	item_name = "grenade_frag_01",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_01_t1",
	local_pickup_sound = true,
	hud_description = "pickup_frag_grenade_t1"
}
Pickups.grenades.fire_grenade_t1 = {
	only_once = true,
	item_description = "grenade_fire",
	slot_name = "slot_grenade",
	type = "inventory_item",
	spawn_weighting = 0.8,
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	bots_mule_pickup = true,
	item_name = "grenade_fire_01",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_03_t1",
	local_pickup_sound = true,
	hud_description = "pickup_fire_grenade_t1"
}
Pickups.improved_grenades = Pickups.improved_grenades or {}
Pickups.improved_grenades.frag_grenade_t2 = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_grenade",
	item_description = "grenade_frag",
	spawn_weighting = 0.2,
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	bots_mule_pickup = true,
	item_name = "grenade_frag_02",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_01_t2",
	local_pickup_sound = true,
	hud_description = "pickup_frag_grenade_t1"
}
Pickups.improved_grenades.fire_grenade_t2 = {
	only_once = true,
	type = "inventory_item",
	slot_name = "slot_grenade",
	item_description = "grenade_fire",
	spawn_weighting = 0.2,
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	bots_mule_pickup = true,
	item_name = "grenade_fire_02",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_03_t2",
	local_pickup_sound = true,
	hud_description = "pickup_fire_grenade_t1"
}
Pickups.special = {
	loot_die = {
		only_once = true,
		mission_name = "bonus_dice_hidden_mission",
		spawn_weighting = 1,
		type = "loot_die",
		pickup_sound_event = "hud_pickup_loot_die",
		unit_name = "units/props/dice_bowl/pup_loot_die",
		local_pickup_sound = false,
		hud_description = "pickup_loot_die",
		can_spawn_func = function (params, is_debug_spawn)
			if is_debug_spawn then
				return true
			end

			local dice_keeper = params.dice_keeper

			return dice_keeper.num_bonus_dice_spawned(dice_keeper) < 2
		end
	},
	event_item = {
		only_once = true,
		unit_name = "units/weapons/player/pup_event_item/pup_event_item_01",
		pickup_sound_event = "hud_pickup_loot_die",
		type = "event_item",
		spawn_weighting = 1,
		local_pickup_sound = false,
		hud_description = "pickup_event_item",
		can_spawn_func = function (params, is_debug_spawn)
			local can_spawn_event_items = Managers.state.quest:is_mutator_active("event_items")

			return can_spawn_event_items
		end
	},
	endurance_badge_01 = {
		only_once = true,
		mission_name = "endurance_badge_01_mission",
		unit_name = "units/props/endurance_badges/prop_endurance_badge_01",
		type = "endurance_badge",
		spawn_weighting = 1,
		local_pickup_sound = false,
		hud_description = "dlc1_2_pickup_endurance_badge",
		pickup_sound_event = "Play_hud_pickup_badge"
	}
}
Pickups.special.endurance_badge_02 = table.clone(Pickups.special.endurance_badge_01)
Pickups.special.endurance_badge_02.unit_name = "units/props/endurance_badges/prop_endurance_badge_02"
Pickups.special.endurance_badge_02.mission_name = "endurance_badge_02_mission"
Pickups.special.endurance_badge_03 = table.clone(Pickups.special.endurance_badge_01)
Pickups.special.endurance_badge_03.unit_name = "units/props/endurance_badges/prop_endurance_badge_03"
Pickups.special.endurance_badge_03.mission_name = "endurance_badge_03_mission"
Pickups.special.endurance_badge_04 = table.clone(Pickups.special.endurance_badge_01)
Pickups.special.endurance_badge_04.unit_name = "units/props/endurance_badges/prop_endurance_badge_04"
Pickups.special.endurance_badge_04.mission_name = "endurance_badge_04_mission"
Pickups.special.endurance_badge_05 = table.clone(Pickups.special.endurance_badge_01)
Pickups.special.endurance_badge_05.unit_name = "units/props/endurance_badges/prop_endurance_badge_05"
Pickups.special.endurance_badge_05.mission_name = "endurance_badge_05_mission"

local function lorebook_all_pages_unlocked(pages, statistics_db, stats_id)
	local num_pages = #pages

	for i = 1, num_pages, 1 do
		local category_name = pages[i]
		local id = LorebookCategoryLookup[category_name]
		local unlocked = statistics_db.get_persistent_lorebook_stat(statistics_db, stats_id, "lorebook_unlocks", id)

		if not unlocked then
			return false
		end
	end

	return true
end

local function num_lorebook_pages_collected_sesssion(level_key)
	local mission_system = Managers.state.entity:system("mission_system")
	local active_missions, completed_missions = mission_system.get_missions(mission_system)
	local mission_data = active_missions.lorebook_page_hidden_mission
	local difficulty_manager = Managers.state.difficulty
	local difficulty_rank = difficulty_manager.get_difficulty_rank(difficulty_manager)
	local n_collected_session = 0

	if mission_data then
		n_collected_session = mission_data.get_current_amount(mission_data)
	end

	return n_collected_session
end

local function lorebook_pages_in_level(level_key)
	local difficulty_manager = Managers.state.difficulty
	local difficulty_rank = difficulty_manager.get_difficulty_rank(difficulty_manager)
	local level_settings = LevelSettings[level_key]
	local pickup_settings = (level_settings.pickup_settings and level_settings.pickup_settings[difficulty_rank]) or nil
	local n_pages_in_level = (pickup_settings and pickup_settings.lorebook_pages) or math.huge

	return n_pages_in_level
end

local function lorebook_all_pages_unlocked_sesssion(level_key)
	local n_collected_session = num_lorebook_pages_collected_sesssion(level_key)
	local n_pages_in_level = lorebook_pages_in_level(level_key)

	return n_pages_in_level <= n_collected_session
end

local function lorebook_unlocked_pages(statistics_db)
	local level_key = Managers.state.game_mode:level_key()
	local level_pages = LorebookCollectablePages[level_key]
	local any_level_pages = LorebookCollectablePages.any
	local local_player = Managers.player:local_player()
	local stats_id = local_player.stats_id(local_player)
	local unlocked_all = true

	if 0 < #level_pages then
		unlocked_all = lorebook_all_pages_unlocked(level_pages, statistics_db, stats_id)
	end

	if unlocked_all and 0 < #any_level_pages then
		unlocked_all = lorebook_all_pages_unlocked(any_level_pages, statistics_db, stats_id)
	end

	local unlocked_all_session = lorebook_all_pages_unlocked_sesssion(level_key)

	return unlocked_all, unlocked_all_session
end

Pickups.lorebook_pages = {
	lorebook_page = {
		mission_name = "lorebook_page_hidden_mission",
		hide_on_pickup = true,
		type = "lorebook_page",
		spawn_weighting = 1,
		only_once = false,
		unit_name = "units/weapons/player/pup_lore_page/pup_lore_page_01",
		hud_description = "pickup_lorebook_page",
		hide_func = function (statistics_db)
			local unlocked_all, unlocked_all_session = lorebook_unlocked_pages(statistics_db)

			return unlocked_all or unlocked_all_session
		end,
		can_spawn_func = function (params, is_debug_spawn)
			if params and params.num_spawned_lorebook_pages and 1 <= params.num_spawned_lorebook_pages then
				return false
			end

			return GameSettingsDevelopment.lorebook_enabled or is_debug_spawn
		end
	}
}
LootRatPickups = {
	first_aid_kit = 3,
	healing_draught = 2,
	damage_boost_potion = 1,
	speed_boost_potion = 1,
	frag_grenade_t2 = 1,
	fire_grenade_t2 = 1,
	loot_die = 4,
	lorebook_page = 4
}
local total_loot_rat_spawn_weighting = 0

for pickup_name, spawn_weighting in pairs(LootRatPickups) do
	total_loot_rat_spawn_weighting = total_loot_rat_spawn_weighting + spawn_weighting
end

for pickup_name, spawn_weighting in pairs(LootRatPickups) do
	LootRatPickups[pickup_name] = spawn_weighting / total_loot_rat_spawn_weighting
end

NearPickupSpawnChance = NearPickupSpawnChance or {
	grenades = 0.5,
	healing = 0.7,
	potions = 0.3
}
AllPickups = {}

for group, pickups in pairs(Pickups) do
	local total_spawn_weighting = 0

	for pickup_name, settings in pairs(pickups) do
		total_spawn_weighting = total_spawn_weighting + settings.spawn_weighting
	end

	for pickup_name, settings in pairs(pickups) do
		settings.spawn_weighting = settings.spawn_weighting / total_spawn_weighting
		AllPickups[pickup_name] = settings
	end

	NearPickupSpawnChance[group] = NearPickupSpawnChance[group] or 0
end

return 
