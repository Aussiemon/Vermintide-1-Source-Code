require("scripts/settings/equipment/item_master_list")

DefaultLocalBackendData = {
	items = {
		{
			traits = "",
			key = "wh_fencing_sword_0001",
			xp = 0
		},
		{
			traits = "",
			key = "wh_brace_of_pistols_0001",
			xp = 0
		},
		{
			traits = "",
			key = "wh_hat_0001",
			xp = 0
		},
		{
			traits = "",
			key = "bw_sword_0001",
			xp = 0
		},
		{
			traits = "",
			key = "bw_skullstaff_fireball_0001",
			xp = 0
		},
		{
			traits = "",
			key = "bw_gate_0001",
			xp = 0
		},
		{
			traits = "",
			key = "dr_shield_axe_0001",
			xp = 0
		},
		{
			traits = "",
			key = "dr_crossbow_0001",
			xp = 0
		},
		{
			traits = "",
			key = "dr_helmet_0001",
			xp = 0
		},
		{
			traits = "",
			key = "we_dual_wield_daggers_0001",
			xp = 0
		},
		{
			traits = "",
			key = "we_shortbow_0001",
			xp = 0
		},
		{
			traits = "",
			key = "ww_hood_0001",
			xp = 0
		},
		{
			traits = "",
			key = "es_2h_hammer_0001",
			xp = 0
		},
		{
			traits = "",
			key = "es_blunderbuss_0001",
			xp = 0
		},
		{
			traits = "",
			key = "es_hat_0001",
			xp = 0
		},
		{
			traits = "",
			key = "wh_2h_sword_0001",
			xp = 0
		},
		{
			traits = "",
			key = "bw_skullstaff_geiser_0001",
			xp = 0
		},
		{
			traits = "",
			key = "dr_2h_axe_0001",
			xp = 0
		},
		{
			traits = "",
			key = "we_1h_sword_0001",
			xp = 0
		},
		{
			traits = "",
			key = "es_sword_shield_0001",
			xp = 0
		}
	},
	loadout = {
		witch_hunter = {
			slot_hat = 3,
			slot_melee = 1,
			slot_ranged = 2
		},
		bright_wizard = {
			slot_hat = 6,
			slot_melee = 4,
			slot_ranged = 5
		},
		dwarf_ranger = {
			slot_hat = 9,
			slot_melee = 7,
			slot_ranged = 8
		},
		wood_elf = {
			slot_hat = 12,
			slot_melee = 10,
			slot_ranged = 11
		},
		empire_soldier = {
			slot_hat = 15,
			slot_melee = 13,
			slot_ranged = 14
		}
	},
	profile_attributes = {
		prestige = 0,
		experience = 0
	},
	stats = {},
	save_data_version = BackendSaveDataVersion
}

local function add_items()
	if script_data.dont_give_all_lan_backend_items then
		return
	end

	local default_items = {}

	for i = 1, #DefaultLocalBackendData.items, 1 do
		local item = DefaultLocalBackendData.items[i]
		default_items[item.key] = true
	end

	local items = DefaultLocalBackendData.items

	for item_name, item in pairs(ItemMasterList) do
		repeat
			if default_items[item_name] then
				break
			end

			items[#items + 1] = {
				traits = "",
				xp = 0,
				key = item_name
			}
		until true
	end

	print(string.format("Adding %d items to profile", #items))

	DefaultLocalBackendData.items = items
end

if Application.platform() ~= "xb1" and Application.platform() ~= "ps4" then
	add_items()
else
	local function add_xbox_rarity_items()
		if script_data.dont_give_all_lan_backend_items then
			return
		end

		local default_items = {}

		for i = 1, #DefaultLocalBackendData.items, 1 do
			local item = DefaultLocalBackendData.items[i]
			default_items[item.key] = true
		end

		local items = DefaultLocalBackendData.items

		for item_name, item in pairs(ItemMasterList) do
			repeat
				if default_items[item_name] then
					break
				end

				if item.rarity then
					XBoxItemsByRarity[item.rarity] = XBoxItemsByRarity[item.rarity] or {}
					XBoxItemsByRarity[item.rarity][#XBoxItemsByRarity[item.rarity] + 1] = {
						traits = "",
						xp = 0,
						key = item_name
					}
				end
			until true
		end
	end

	XB1DefaultLocalBackendData = {}
	XBoxItemsByRarity = {}

	add_xbox_rarity_items()

	XB1DefaultLocalBackendData.add_items = function ()
		add_items()
	end
end

return
