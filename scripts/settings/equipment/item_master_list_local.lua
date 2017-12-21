ItemMasterList = ItemMasterList or {}
ItemMasterList.dwarf_explosive_barrel = {
	slot_type = "healthkit",
	temporary_template = "dwarf_explosive_barrel",
	inventory_icon = "menu_inventory_screen_icons_default",
	item_type = "explosive_inventory_item",
	left_hand_unit = "units/weapons/player/wpn_dwarf_barrel_01/wpn_dwarf_barrel_01",
	hud_icon = "consumables_icon_defence",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}

return 
