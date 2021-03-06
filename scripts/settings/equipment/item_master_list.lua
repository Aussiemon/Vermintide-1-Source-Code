dofile("scripts/unit_extensions/default_player_unit/buffs/buff_templates")
dofile("scripts/settings/equipment/weapons")
dofile("scripts/settings/equipment/attachments")
dofile("scripts/settings/equipment/item_master_list_local")
dofile("scripts/settings/equipment/item_master_list_exported")
dofile("scripts/settings/equipment/item_master_list_brawl")

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

	Profiler.stop("Parse Item Master List")
end

if Managers.localizer then
	parse_item_master_list()
end

ItemMasterListMeta = ItemMasterListMeta or {}

ItemMasterListMeta.__index = function (table, key)
	error(string.format("ItemMasterList has no item %q", tostring(key)))
	error(string.format("IMPORTANT: This error might be caused by old data in local save files. Clear local data by deleting backend_local.sav"))
end

setmetatable(ItemMasterList, ItemMasterListMeta)

return
