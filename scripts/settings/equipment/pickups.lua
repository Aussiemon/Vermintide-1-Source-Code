Pickups = Pickups or {}
Pickups.healing = Pickups.healing or {}
Pickups.healing.first_aid_kit = {
	only_once = true,
	spawn_weighting = 0.5,
	slot_name = "slot_healthkit",
	type = "inventory_item",
	pickup_sound_event = "pickup_medkit",
	dupable = true,
	item_name = "healthkit_first_aid_kit_01",
	unit_name = "units/weapons/player/pup_first_aid/pup_first_aid",
	local_pickup_sound = true,
	hud_description = "pickup_first_aid_kit"
}
Pickups.healing.healing_draught = {
	only_once = true,
	spawn_weighting = 0.5,
	slot_name = "slot_healthkit",
	type = "inventory_item",
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
	spawn_weighting = 0.2,
	slot_name = "slot_potion",
	type = "inventory_item",
	pickup_sound_event = "pickup_potion",
	dupable = true,
	item_name = "potion_damage_boost_01",
	unit_name = "units/weapons/player/pup_potion/pup_potion_buff",
	local_pickup_sound = true,
	hud_description = "pickup_damage_boost_potion"
}
Pickups.potions.speed_boost_potion = {
	only_once = true,
	spawn_weighting = 0.2,
	slot_name = "slot_potion",
	type = "inventory_item",
	pickup_sound_event = "pickup_potion",
	dupable = true,
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
	spawn_weighting = 1,
	item_name = "explosive_barrel",
	unit_name = "units/weapons/player/pup_explosive_barrel/pup_explosive_barrel_01",
	additional_data_func = "explosive_barrel",
	unit_template_name = "explosive_pickup_projectile_unit",
	wield_on_pickup = true,
	hud_description = "pickup_explosive_barrel"
}
Pickups.level_events.explosive_barrel_objective = {
	only_once = true,
	slot_name = "slot_level_event",
	type = "explosive_inventory_item",
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
	spawn_weighting = 1,
	item_name = "beer_barrel",
	unit_name = "units/weapons/player/pup_explosive_barrel/pup_explosive_barrel_01",
	unit_template_name = "pickup_unit",
	wield_on_pickup = true,
	hud_description = "pickup_beer_barrel"
}
Pickups.level_events.grimoire = {
	only_once = true,
	spawn_weighting = 1,
	slot_name = "slot_potion",
	type = "inventory_item",
	pickup_sound_event = "pickup_medkit",
	item_name = "wpn_grimoire_01",
	unit_name = "units/weapons/player/pup_grimoire_01/pup_grimoire_01",
	local_pickup_sound = true,
	hud_description = "pickup_grimoire"
}
Pickups.level_events.tome = {
	only_once = true,
	spawn_weighting = 1,
	slot_name = "slot_healthkit",
	type = "inventory_item",
	pickup_sound_event = "pickup_medkit",
	item_name = "wpn_side_objective_tome_01",
	unit_name = "units/weapons/player/pup_side_objective_tome/pup_side_objective_tome_01",
	local_pickup_sound = true,
	hud_description = "pickup_tome"
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
	spawn_weighting = 0.8,
	slot_name = "slot_grenade",
	type = "inventory_item",
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	item_name = "grenade_frag_01",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_01_t1",
	local_pickup_sound = true,
	hud_description = "pickup_frag_grenade_t1"
}
Pickups.grenades.smoke_grenade_t1 = {
	only_once = true,
	spawn_weighting = 0,
	slot_name = "slot_grenade",
	type = "inventory_item",
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	item_name = "grenade_smoke_01",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_02_t1",
	local_pickup_sound = true,
	hud_description = "pickup_smoke_grenade_t1"
}
Pickups.grenades.fire_grenade_t1 = {
	only_once = true,
	spawn_weighting = 0.8,
	slot_name = "slot_grenade",
	type = "inventory_item",
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	item_name = "grenade_fire_01",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_03_t1",
	local_pickup_sound = true,
	hud_description = "pickup_fire_grenade_t1"
}
Pickups.improved_grenades = Pickups.improved_grenades or {}
Pickups.improved_grenades.frag_grenade_t2 = {
	only_once = true,
	spawn_weighting = 0.2,
	slot_name = "slot_grenade",
	type = "inventory_item",
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	item_name = "grenade_frag_02",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_01_t2",
	local_pickup_sound = true,
	hud_description = "pickup_frag_grenade_t2"
}
Pickups.improved_grenades.smoke_grenade_t2 = {
	only_once = true,
	spawn_weighting = 0,
	slot_name = "slot_grenade",
	type = "inventory_item",
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	item_name = "grenade_smoke_02",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_02_t2",
	local_pickup_sound = true,
	hud_description = "pickup_smoke_grenade_t2"
}
Pickups.improved_grenades.fire_grenade_t2 = {
	only_once = true,
	spawn_weighting = 0.2,
	slot_name = "slot_grenade",
	type = "inventory_item",
	pickup_sound_event = "pickup_grenade",
	dupable = true,
	item_name = "grenade_fire_02",
	unit_name = "units/weapons/player/pup_grenades/pup_grenade_03_t2",
	local_pickup_sound = true,
	hud_description = "pickup_fire_grenade_t2"
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
		can_spawn_func = function (params)
			local dice_keeper = params.dice_keeper

			return dice_keeper.num_bonus_dice_spawned(dice_keeper) < 2
		end
	},
	survival_metal_loot_die = {
		only_once = true,
		mission_name = "metal_dice_survival_mission",
		unit_name = "units/props/dice_bowl/pup_loot_die",
		type = "loot_die",
		spawn_weighting = 1,
		local_pickup_sound = false,
		hud_description = "pickup_loot_die",
		pickup_sound_event = "hud_pickup_loot_die"
	},
	survival_gold_loot_die = {
		only_once = true,
		mission_name = "gold_dice_survival_mission",
		unit_name = "units/props/dice_bowl/pup_loot_die",
		type = "loot_die",
		spawn_weighting = 1,
		local_pickup_sound = false,
		hud_description = "pickup_loot_die",
		pickup_sound_event = "hud_pickup_loot_die"
	},
	survival_warpstone_loot_die = {
		only_once = true,
		mission_name = "warpstone_dice_survival_mission",
		unit_name = "units/props/dice_bowl/pup_loot_die",
		type = "loot_die",
		spawn_weighting = 1,
		local_pickup_sound = false,
		hud_description = "pickup_loot_die",
		pickup_sound_event = "hud_pickup_loot_die"
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
script_data.lorebook_enabled = script_data.lorebook_enabled or Development.parameter("lorebook_enabled")
Pickups.lorebook_pages = {
	lorebook_page = {
		spawn_weighting = 1,
		hide_on_pickup = true,
		type = "lorebook_page",
		pickup_sound_event = "Play_hud_lorebook_unlock_page",
		only_once = false,
		unit_name = "units/weapons/player/pup_lore_page/pup_lore_page_01",
		hud_description = "pickup_lorebook_page",
		hide_func = function (statistics_db)
			local level_key = Managers.state.game_mode:level_key()
			local pages = LorebookCollectablePages[level_key]

			fassert(pages, "Trying to a pick up a lorebook page on a level where pages can not be unlocked")

			local num_pages = #pages
			local local_player = Managers.player:local_player()
			local stats_id = local_player.stats_id(local_player)
			local unlocked_all = true

			for i = 1, num_pages, 1 do
				local category_name = pages[i]
				local id = LorebookCategoryLookup[category_name]
				local unlocked = statistics_db.get_persistent_array_stat(statistics_db, stats_id, "lorebook_unlocks", id)

				if not unlocked then
					unlocked_all = false

					break
				end
			end

			return unlocked_all
		end,
		can_spawn_func = function ()
			if not script_data.lorebook_enabled then
				return false
			end

			local level_key = Managers.state.game_mode:level_key()

			if LorebookCollectablePages[level_key] then
				return true
			end

			return false
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
	LootRatPickups[pickup_name] = spawn_weighting/total_loot_rat_spawn_weighting
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
		settings.spawn_weighting = settings.spawn_weighting/total_spawn_weighting
		AllPickups[pickup_name] = settings
	end

	NearPickupSpawnChance[group] = NearPickupSpawnChance[group] or 0
end

return 
