BoonTemplates = {
	reduced_damage = {
		reduced_damage_amount = 0.1,
		affects_allies = false,
		quest_ui_icon = "boon_icon_01_damage_reduced",
		ui_icon = "boon_icon_01_damage_reduced",
		duration = 7200,
		ui_name = "dlc1_3_1_buff_name_reduced_damage"
	},
	increased_damage = {
		increased_damage_amount = 0.3,
		affects_allies = false,
		quest_ui_icon = "boon_icon_02_damage_increased",
		ui_icon = "boon_icon_02_damage_increased",
		duration = 7200,
		ui_name = "dlc1_3_1_buff_name_increased_damage"
	},
	bonus_starting_gear = {
		affects_allies = true,
		quest_ui_icon = "boon_icon_03_extra_starting_gear",
		ui_icon = "boon_icon_03_extra_starting_gear",
		duration = 3600,
		ui_name = "dlc1_3_1_buff_name_bonus_starting_gear"
	},
	bonus_fatigue = {
		ui_name = "dlc1_3_1_buff_name_bonus_fatigue",
		affects_allies = false,
		quest_ui_icon = "teammate_consumable_icon_potion",
		ui_icon = "teammate_consumable_icon_potion",
		duration = 3600,
		fatigue_increase = 2
	},
	increased_combat_movement = {
		affects_allies = false,
		multiplier = 0.8,
		quest_ui_icon = "boon_icon_04_reduced_slowing_effects",
		ui_icon = "boon_icon_04_reduced_slowing_effects",
		duration = 3600,
		ui_name = "dlc1_3_1_buff_name_increased_combat_movement"
	},
	increased_stagger_type = {
		affects_allies = false,
		quest_ui_icon = "boon_icon_05_stagger_more",
		ui_icon = "boon_icon_05_stagger_more",
		duration = 3600,
		ui_name = "buff_description_increased_stagger_type"
	}
}
MaxBoonDuration = 0

for _, data in pairs(BoonTemplates) do
	local duration = data.duration

	if MaxBoonDuration < duration then
		MaxBoonDuration = duration
	end
end

return 
