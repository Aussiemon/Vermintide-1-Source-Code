InventorySettings = {
	slots = {
		{
			type = "trinket",
			name = "slot_trinket_3",
			loadout_slot = true,
			category = "attachment",
			inventory_button_index = 1
		},
		{
			type = "trinket",
			name = "slot_trinket_2",
			loadout_slot = true,
			category = "attachment",
			inventory_button_index = 2
		},
		{
			type = "trinket",
			name = "slot_trinket_1",
			loadout_slot = true,
			category = "attachment",
			inventory_button_index = 3
		},
		{
			type = "hat",
			name = "slot_hat",
			loadout_slot = true,
			category = "attachment",
			inventory_button_index = 6
		},
		{
			type = "melee",
			name = "slot_melee",
			wield_input = "wield_1",
			category = "weapon",
			loadout_slot = true,
			inventory_button_index = 5
		},
		{
			type = "ranged",
			name = "slot_ranged",
			wield_input = "wield_2",
			category = "weapon",
			loadout_slot = true,
			inventory_button_index = 4
		},
		{
			name = "slot_healthkit",
			wield_input = "wield_3",
			category = "weapon",
			drop_reasons = {
				death = true
			}
		},
		{
			name = "slot_potion",
			wield_input = "wield_4",
			category = "weapon",
			drop_reasons = {
				death = true
			}
		},
		{
			name = "slot_grenade",
			wield_input = "wield_5",
			category = "weapon",
			drop_reasons = {
				death = true
			}
		},
		{
			name = "slot_packmaster_claw",
			category = "enemy_weapon",
			drop_reasons = {
				death = true
			}
		},
		{
			name = "slot_level_event",
			category = "level_event",
			drop_reasons = {
				grabbed_by_pack_master = true,
				pounced_down = true,
				death = true,
				knocked_down = true,
				forced_drop = true
			}
		}
	},
	weapon_slots = {}
}

for index, slot in ipairs(InventorySettings.slots) do
	if slot.category == "weapon" then
		InventorySettings.weapon_slots[#InventorySettings.weapon_slots + 1] = slot
	end
end

InventorySettings.enemy_weapon_slots = {}

for index, slot in ipairs(InventorySettings.slots) do
	if slot.category == "enemy_weapon" then
		InventorySettings.enemy_weapon_slots[#InventorySettings.enemy_weapon_slots + 1] = slot
	end
end

InventorySettings.attachment_slots = {}

for index, slot in ipairs(InventorySettings.slots) do
	if slot.category == "attachment" then
		InventorySettings.attachment_slots[#InventorySettings.attachment_slots + 1] = slot
	end
end

InventorySettings.slots_by_name = {}

for index, slot in ipairs(InventorySettings.slots) do
	InventorySettings.slots_by_name[slot.name] = slot
end

InventorySettings.slot_names_by_type = {}

for index, slot in ipairs(InventorySettings.slots) do
	if slot.type then
		if not InventorySettings.slot_names_by_type[slot.type] then
			InventorySettings.slot_names_by_type[slot.type] = {}
		end

		local slot_names_table = InventorySettings.slot_names_by_type[slot.type]
		slot_names_table[#slot_names_table + 1] = slot.name
	end
end

InventorySettings.slots_by_wield_input = {}

for index, slot in ipairs(InventorySettings.slots) do
	if slot.wield_input then
		local index_string = string.sub(slot.wield_input, 7)
		local index = tonumber(index_string)
		slot.wield_index = index
		InventorySettings.slots_by_wield_input[index] = slot
	end
end

InventorySettings.slots_by_inventory_button_index = {}

for index, slot in ipairs(InventorySettings.slots) do
	if slot.inventory_button_index then
		InventorySettings.slots_by_inventory_button_index[slot.inventory_button_index] = slot
	end
end

InventorySettings.inventory_slot_types_button_index = {
	"melee",
	"ranged",
	"trinket",
	"hat"
}
InventorySettings.inventory_slot_button_index_by_type = {
	ranged = 2,
	melee = 1,
	hat = 4,
	trinket = 3
}
InventorySettings.item_types = {
	"bw_1h_sword",
	"bw_flame_sword",
	"bw_morningstar",
	"bw_staff_beam",
	"bw_staff_firball",
	"bw_staff_geiser",
	"bw_staff_spear",
	"dr_1h_axe_shield",
	"dr_1h_axes",
	"dr_1h_hammer ",
	"dr_1h_hammer_shield",
	"dr_2h_axes",
	"dr_2h_picks",
	"dr_2h_hammer",
	"dr_crossbow",
	"dr_drakefire_pistols",
	"dr_drakegun",
	"dr_grudgeraker",
	"dr_handgun",
	"es_1h_mace",
	"es_1h_mace_shield",
	"es_1h_sword",
	"es_1h_sword_shield",
	"es_2h_sword",
	"es_2h_war_hammer",
	"es_blunderbuss",
	"es_handgun",
	"es_repeating_handgun",
	"wh_1h_axes",
	"wh_1h_falchions",
	"wh_2h_sword",
	"wh_brace_of_pisols",
	"wh_crossbow",
	"wh_fencing_sword",
	"wh_repeating_pistol",
	"ww_1h_sword ",
	"ww_2h_axe",
	"ww_dual_daggers",
	"ww_dual_swords",
	"ww_hagbane",
	"ww_longbow",
	"ww_shortbow",
	"ww_sword_and_dagger",
	"ww_trueflight"
}

return
