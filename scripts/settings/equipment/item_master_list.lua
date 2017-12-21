dofile("scripts/unit_extensions/default_player_unit/buffs/buff_templates")
dofile("scripts/settings/equipment/weapons")
dofile("scripts/settings/equipment/attachments")
dofile("scripts/settings/equipment/item_master_list_local")
dofile("scripts/settings/equipment/item_master_list_exported")

ItemMasterList.drachenfels_statue = {
	slot_type = "healthkit",
	temporary_template = "drachenfels_statue",
	inventory_icon = "menu_inventory_screen_icons_default",
	item_type = "inventory_item",
	left_hand_unit = "units/weapons/player/pup_drachenfels_statue/wpn_drachenfels_statue",
	hud_icon = "consumables_icon_defence",
	can_wield = {
		"bright_wizard",
		"dwarf_ranger",
		"empire_soldier",
		"witch_hunter",
		"wood_elf"
	}
}
all_item_types = {}
local all_loot = {}

local function aggregate(list)
	for _, item in pairs(list) do
		if type(item) == "table" then
			aggregate(item)
		elseif type(item) == "string" then
			local data = rawget(ItemMasterList, item)

			if not data then
				print("item", item)
			end
		else
			error("unknown type " .. type(item))
		end
	end

	return 
end

function parse_item_master_list()
	Profiler.start("Parse Item Master List")

	for key, item in pairs(ItemMasterList) do
		item.key = key
		item.name = key
		item.display_name = item.display_name or string.format("No display_name for item %q", tostring(key))
		item.localized_name = Localize(item.display_name)

		if item.item_type then
			all_item_types[item.item_type] = true
		end
	end

	Profiler.stop()

	return 
end

if Managers.localizer then
	parse_item_master_list()
end

ItemMasterListMeta = ItemMasterListMeta or {}
ItemMasterListMeta.__index = function (table, key)
	error(string.format("ItemMasterList has no item %q", tostring(key)))
	error(string.format("IMPORTANT: This error might be caused by old data in local save files. Clear local data by deleting backend_local.sav"))

	return 
end

setmetatable(ItemMasterList, ItemMasterListMeta)

return 
