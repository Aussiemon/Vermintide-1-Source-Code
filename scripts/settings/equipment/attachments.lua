require("scripts/settings/attachment_node_linking")

FirstPersonAttachments = {
	witch_hunter = {
		unit = "units/beings/player/witch_hunter/first_person_base/chr_first_person_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	witch_hunter_variation_1 = {
		unit = "units/beings/player/witch_hunter/first_person_base/chr_first_person_variation_1_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	bright_wizard = {
		unit = "units/beings/player/bright_wizard/first_person_base/chr_first_person_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	bright_wizard_variation_1 = {
		unit = "units/beings/player/bright_wizard/first_person_base/chr_first_person_variation_1_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	wood_elf = {
		unit = "units/beings/player/way_watcher/first_person_base/chr_first_person_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	wood_elf_variation_1 = {
		unit = "units/beings/player/way_watcher/first_person_base/chr_first_person_variation_1_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	dwarf_ranger = {
		unit = "units/beings/player/dwarf_ranger/first_person_base/chr_first_person_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	dwarf_ranger_variation_1 = {
		unit = "units/beings/player/dwarf_ranger/first_person_base/chr_first_person_variation_1_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	empire_soldier = {
		unit = "units/beings/player/empire_soldier/first_person_base/chr_first_person_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	},
	empire_soldier_variation_1 = {
		unit = "units/beings/player/empire_soldier/first_person_base/chr_first_person_variation_1_mesh",
		attachment_node_linking = AttachmentNodeLinking.first_person_attachment
	}
}
Attachments = {}
local hanging_trophy = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_trophy",
	attachment_node_linking = AttachmentNodeLinking.trophies.hanging,
	slots = {
		"slot_trinket_1",
		"slot_trinket_2",
		"slot_trinket_3"
	},
	buffs = {}
}
local flat_trophy = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_trophy",
	attachment_node_linking = AttachmentNodeLinking.trophies.flat,
	slots = {
		"slot_trinket_1",
		"slot_trinket_2",
		"slot_trinket_3"
	},
	buffs = {}
}
Attachments.hanging_trophy = table.clone(hanging_trophy)
Attachments.flat_trophy = table.clone(flat_trophy)
local wh_hats = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_show_ears",
	attachment_node_linking = AttachmentNodeLinking.hat,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.wh_hats = table.clone(wh_hats)
local wh_hats_skinned = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_show_ears",
	attachment_node_linking = AttachmentNodeLinking.hat_skinned,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.wh_hats_skinned = table.clone(wh_hats_skinned)
local ww_hoods = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	attachment_node_linking = AttachmentNodeLinking.hat_skinned,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.ww_hoods = table.clone(ww_hoods)
local es_hats = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_show_ears",
	attachment_node_linking = AttachmentNodeLinking.hat,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.es_hats = table.clone(es_hats)
local es_hats_no_ear = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_hide_ears",
	attachment_node_linking = AttachmentNodeLinking.hat,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.es_hats_no_ear = table.clone(es_hats_no_ear)
local es_hats_skinned = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet_es_hood",
	show_attachments_event = "lua_show_ears",
	attachment_node_linking = AttachmentNodeLinking.es_hat_skinned,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.es_hats_skinned = table.clone(es_hats_skinned)
local dr_helmets = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_show_ears",
	attachment_node_linking = AttachmentNodeLinking.hat,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.dr_helmets = table.clone(dr_helmets)
local dr_helmets_no_ear = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_hide_ears",
	attachment_node_linking = AttachmentNodeLinking.hat,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.dr_helmets_no_ear = table.clone(dr_helmets_no_ear)
local bw_gates = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_show_breastplate",
	attachment_node_linking = AttachmentNodeLinking.bw_gate,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.bw_gates = table.clone(bw_gates)
local bw_gates_small = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet_bw_gate_small",
	show_attachments_event = "lua_show_breastplate",
	attachment_node_linking = AttachmentNodeLinking.bw_gate,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.bw_gates_small = table.clone(bw_gates_small)
local bw_gates_facemask = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_show_breastplate",
	attachment_node_linking = AttachmentNodeLinking.bw_gate_facemask,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.bw_gates_facemask = table.clone(bw_gates_facemask)
local bw_gates_no_breastplate = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_hide_breastplate",
	attachment_node_linking = AttachmentNodeLinking.bw_gate,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.bw_gates_no_breastplate = table.clone(bw_gates_no_breastplate)
local bw_gates_facemask_no_breastplate = {
	unit = "",
	display_unit = "units/weapons/weapon_display/display_helmet",
	show_attachments_event = "lua_hide_breastplate",
	attachment_node_linking = AttachmentNodeLinking.bw_gate_facemask,
	slots = {
		"slot_hat"
	},
	buffs = {}
}
Attachments.bw_gates_facemask_no_breastplate = table.clone(bw_gates_facemask_no_breastplate)

for name, attachment_data in pairs(Attachments) do
	attachment_data.name = name

	assert(attachment_data.units ~= "", "Name is empty")
	assert(attachment_data.attachment_node_linking)
	assert(attachment_data.slots)
end

return
