ItemMasterList = ItemMasterList or {}
ItemMasterList.potion_damage_boost_01 = {
	description = "description_potion_damage_boost_01",
	rarity = "common",
	hud_icon = "consumables_strength",
	temporary_template = "damage_boost_potion",
	inventory_icon = "menu_inventory_screen_icons_default",
	slot_type = "potion",
	left_hand_unit = "units/weapons/player/wpn_potion_buff/wpn_potion_buff",
	description_type = "potion",
	item_type = "potion",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}
ItemMasterList.potion_speed_boost_01 = {
	description = "description_potion_speed_boost_01",
	temporary_template = "speed_boost_potion",
	hud_icon = "consumables_speed",
	slot_type = "potion",
	inventory_icon = "menu_inventory_screen_icons_default",
	left_hand_unit = "units/weapons/player/wpn_potion_buff/wpn_potion_buff",
	description_type = "potion",
	item_type = "potion",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}

return
