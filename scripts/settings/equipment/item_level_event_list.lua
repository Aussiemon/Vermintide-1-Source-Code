ItemMasterList = ItemMasterList or {}
ItemMasterList.grain_sack = {
	item_type = "inventory_item",
	temporary_template = "sack",
	hud_icon = "consumables_icon_defence",
	inventory_icon = "menu_inventory_screen_icons_default",
	left_hand_unit = "units/weapons/player/wpn_sacks/wpn_sacks_01",
	slot_type = "healthkit",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}
ItemMasterList.explosive_barrel = {
	item_type = "explosive_inventory_item",
	temporary_template = "explosive_barrel",
	hud_icon = "consumables_icon_defence",
	inventory_icon = "menu_inventory_screen_icons_default",
	left_hand_unit = "units/weapons/player/wpn_explosive_barrel/wpn_explosive_barrel_01",
	slot_type = "healthkit",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}
ItemMasterList.explosive_barrel_objective = {
	item_type = "explosive_inventory_item",
	temporary_template = "explosive_barrel_objective",
	hud_icon = "consumables_icon_defence",
	inventory_icon = "menu_inventory_screen_icons_default",
	left_hand_unit = "units/weapons/player/wpn_explosive_barrel/wpn_gun_powder_barrel_01",
	slot_type = "healthkit",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}
ItemMasterList.beer_barrel = {
	hud_icon = "consumables_icon_defence",
	item_type = "inventory_item",
	slot_type = "healthkit",
	left_hand_unit = "units/weapons/player/wpn_explosive_barrel/wpn_explosive_barrel_01",
	inventory_icon = "menu_inventory_screen_icons_default",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}
ItemMasterList.torch = {
	inventory_icon = "menu_inventory_screen_icons_default",
	temporary_template = "torch",
	hud_icon = "consumables_icon_defence",
	item_type = "inventory_item",
	slot_type = "healthkit",
	right_hand_unit = "units/weapons/player/wpn_torch/wpn_torch",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}
ItemMasterList.packmaster_claw = {
	temporary_template = "packmaster_claw",
	right_hand_unit = "units/weapons/player/wpn_packmaster_claw/wpn_packmaster_claw",
	item_type = "inventory_item",
	slot_type = "slot_packmaster_claw",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}

return
