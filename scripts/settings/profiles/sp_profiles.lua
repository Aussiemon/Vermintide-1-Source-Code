require("scripts/settings/script_input_settings")
require("scripts/settings/equipment/weapons")
require("scripts/settings/profiles/room_profiles")
require("scripts/settings/equipment/attachments")
require("scripts/settings/skin_settings")

ProfilePriority = {
	3,
	5,
	4,
	1,
	2
}
SPProfilesAbbreviation = {
	"wh",
	"bw",
	"dr",
	"we",
	"es"
}
SPProfiles = {
	{
		character_vo = "witch_hunter",
		default_wielded_slot = "slot_melee",
		display_name = "witch_hunter",
		ingame_short_display_name = "witch_hunter_short",
		character_name = "lorebook_witch_hunter",
		ingame_display_name = "inventory_name_witch_hunter",
		unit_name = "witch_hunter",
		sound_character = "witch_hunter",
		equipment_slots = {
			slot_melee = ItemMasterList.wh_1h_axe_0001,
			slot_ranged = ItemMasterList.wh_brace_of_pistols_0001,
			slot_hat = ItemMasterList.wh_hat_0001,
			slot_healthkit = ItemMasterList.healthkit_first_aid_kit_01
		},
		room_profile = RoomProfiles.witch_hunter,
		first_person_heights = {
			knocked_down = 1,
			crouch = 1,
			stand = 1.7
		},
		mood_settings = {}
	},
	{
		character_vo = "bright_wizard",
		default_wielded_slot = "slot_melee",
		display_name = "bright_wizard",
		ingame_short_display_name = "bright_wizard_short",
		character_name = "lorebook_bright_wizard",
		ingame_display_name = "inventory_name_bright_wizard",
		unit_name = "bright_wizard",
		sound_character = "bright_wizard",
		equipment_slots = {
			slot_melee = ItemMasterList.bw_sword_0001,
			slot_ranged = ItemMasterList.bw_skullstaff_fireball_0001,
			slot_hat = ItemMasterList.bw_gate_0001,
			slot_healthkit = ItemMasterList.healthkit_first_aid_kit_01
		},
		room_profile = RoomProfiles.bright_wizard,
		first_person_heights = {
			knocked_down = 0.95,
			crouch = 0.95,
			stand = 1.55
		},
		mood_settings = {}
	},
	{
		character_vo = "dwarf_ranger",
		default_wielded_slot = "slot_melee",
		display_name = "dwarf_ranger",
		ingame_short_display_name = "dwarf_ranger_short",
		character_name = "lorebook_dwarf_ranger",
		ingame_display_name = "inventory_name_dwarf_ranger",
		unit_name = "dwarf_ranger",
		sound_character = "dwarf_ranger",
		equipment_slots = {
			slot_melee = ItemMasterList.dr_2h_hammer_0001,
			slot_ranged = ItemMasterList.dr_crossbow_0001,
			slot_hat = ItemMasterList.dr_helmet_0001,
			slot_healthkit = ItemMasterList.healthkit_first_aid_kit_01
		},
		room_profile = RoomProfiles.dwarf_ranger,
		first_person_heights = {
			knocked_down = 0.7,
			crouch = 0.7,
			stand = 1.3
		},
		mood_settings = {}
	},
	{
		character_vo = "wood_elf",
		default_wielded_slot = "slot_melee",
		display_name = "wood_elf",
		ingame_short_display_name = "wood_elf_short",
		character_name = "lorebook_wood_elf",
		ingame_display_name = "inventory_name_wood_elf",
		unit_name = "way_watcher",
		sound_character = "wood_elf",
		equipment_slots = {
			slot_melee = ItemMasterList.we_dual_wield_daggers_0001,
			slot_ranged = ItemMasterList.we_shortbow_0001,
			slot_hat = ItemMasterList.ww_hood_0001,
			slot_healthkit = ItemMasterList.healthkit_first_aid_kit_01
		},
		room_profile = RoomProfiles.wood_elf,
		first_person_heights = {
			knocked_down = 1,
			crouch = 1,
			stand = 1.5
		},
		mood_settings = {}
	},
	{
		character_vo = "empire_soldier",
		default_wielded_slot = "slot_melee",
		display_name = "empire_soldier",
		ingame_short_display_name = "empire_soldier_short",
		character_name = "lorebook_empire_soldier",
		ingame_display_name = "inventory_name_empire_soldier",
		unit_name = "empire_soldier",
		sound_character = "empire_soldier",
		equipment_slots = {
			slot_melee = ItemMasterList.es_sword_shield_0001,
			slot_ranged = ItemMasterList.es_blunderbuss_0001,
			slot_hat = ItemMasterList.es_hat_0001,
			slot_healthkit = ItemMasterList.healthkit_first_aid_kit_01
		},
		room_profile = RoomProfiles.empire_soldier,
		first_person_heights = {
			knocked_down = 1,
			crouch = 1,
			stand = 1.65
		},
		mood_settings = {}
	}
}
DefaultUnits = {
	standard = {
		backlit_camera = "units/generic/backlit_camera",
		camera = "core/units/camera"
	}
}

for index, profile in ipairs(SPProfiles) do
	fassert(profile.equipment_slots.slot_melee, "\"slot_melee\" in profile %s contains no or invalid weapon, please fix error in SPProfiles", profile.display_name)
	fassert(profile.equipment_slots.slot_ranged, "\"slot_ranged\" in profile %s contains no or invalid weapon, please fix error in SPProfiles", profile.display_name)

	for slot_id, slot_data in pairs(profile.equipment_slots) do
		for other_slot_id, other_slot_data in pairs(profile.equipment_slots) do
			if other_slot_id ~= slot_id then
				assert(slot_data ~= other_slot_data, "Equipped the same item in two slots for profile %q (%s and %s)", class_name, slot_id, other_slot_id)
			end
		end
	end
end

function FindProfileIndex(profile_name)
	for i, profile_data in pairs(SPProfiles) do
		if profile_data.display_name == profile_name then
			return i
		end
	end
end

return
