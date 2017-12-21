require("scripts/ui/atlas_settings/gui_input_icons_atlas")
require("scripts/ui/atlas_settings/gui_hud_atlas")
require("scripts/ui/atlas_settings/gui_hud_console_atlas")
require("scripts/ui/atlas_settings/gui_game_logos_atlas")
require("scripts/ui/atlas_settings/gui_generic_icons_atlas")
require("scripts/ui/atlas_settings/gui_loading_icons_atlas")
require("scripts/ui/atlas_settings/gui_menu_buttons_atlas")
require("scripts/ui/atlas_settings/gui_popup_atlas")
require("scripts/ui/atlas_settings/gui_splash_atlas")
require("scripts/ui/atlas_settings/gui_item_icons_atlas")
require("scripts/ui/atlas_settings/gui_chat_atlas")
require("scripts/ui/atlas_settings/gui_voice_chat_atlas")
require("scripts/ui/atlas_settings/gui_gamma_settings_atlas")
require("scripts/ui/atlas_settings/gui_altar_atlas")
require("scripts/ui/atlas_settings/gui_common_atlas")
require("scripts/ui/atlas_settings/gui_end_of_level_atlas")
require("scripts/ui/atlas_settings/gui_forge_atlas")
require("scripts/ui/atlas_settings/gui_frames_atlas")
require("scripts/ui/atlas_settings/gui_friends_list_atlas")
require("scripts/ui/atlas_settings/gui_inventory_atlas")
require("scripts/ui/atlas_settings/gui_journal_atlas")
require("scripts/ui/atlas_settings/gui_playerlist_atlas")
require("scripts/ui/atlas_settings/gui_quest_atlas")
require("scripts/ui/atlas_settings/gui_settings_atlas")
require("scripts/ui/atlas_settings/gui_telemetry_survey_atlas")
require("scripts/ui/atlas_settings/gui_unlock_key_atlas")
require("scripts/ui/atlas_settings/gui_matchmaking_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_bridge_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_cemetery_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_city_wall_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_courtyard_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_docks_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_end_boss_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_farm_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_forest_ambush_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_inn_level_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_magnus_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_merchant_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_sewers_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_tunnels_atlas")
require("scripts/ui/atlas_settings/gui_loading_bg_wizard_atlas")
require("scripts/ui/atlas_settings/gui_start_screen_atlas")

local platform = Application.platform()

if platform == "win32" then
	require("scripts/ui/atlas_settings/gui_map_atlas")
	require("scripts/ui/atlas_settings/gui_level_images_atlas")
	require("scripts/ui/atlas_settings/gui_map_locations_atlas")
else
	require("scripts/ui/atlas_settings/gui_map_console_atlas")
	require("scripts/ui/atlas_settings/gui_level_images_console_atlas")
end

UIAtlasHelper = UIAtlasHelper or {}
local none_atlas_textures = {
	beta_text = true,
	boon_frame_path_8 = true,
	loading_screen_dlc_dwarf_interior = true,
	loot_pop_up_bg = true,
	craft_arrow_button_glow = true,
	boon_icon_bg_mask = true,
	boon_icon_bg = true,
	boon_frame_path_9 = true,
	boon_frame_path_1 = true,
	ubersreik_area_icon_banner = true,
	trait_proc_box_glow = true,
	quest_glow_highlight = true,
	gradient_map_screen = true,
	quest_boon_glow_05 = true,
	level_list_selection_frame = true,
	game_mode_selection_glow_01 = true,
	charge_bar_flames_mask = true,
	forge_merge_trail_04_path = true,
	boon_frame_path_6 = true,
	loading_screen_dlc_castle = true,
	boon_frame_path_7 = true,
	loading_screen_bridge = true,
	contract_masked_overlay = true,
	summary_screen_experience_bar = true,
	boon_frame_path_4 = true,
	teammate_hp_bar_color_tint_1 = true,
	charge_bar_flames = true,
	loading_screen_survival_02_level = true,
	controller_image_ps4 = true,
	controller_image_xb1 = true,
	forge_progress_bar_fill = true,
	end_screen_banner_effect = true,
	selected_window_glow_settings_02 = true,
	vermintide_logo_title = true,
	forge_merge_trail_01_path = true,
	map_area_banner_difficulty_icon = true,
	end_screen_banner_victory = true,
	reroll_glow_corner = true,
	forge_merge_trail_03_path = true,
	gradient_dice_game_reward = true,
	forge_merge_trail_05_path = true,
	mask_rect_edge_fade = true,
	overchargecircle_sidefade = true,
	loading_screen_survival_01_level = true,
	gamma_settings_image_01 = true,
	start_game_detail_glow = true,
	boon_frame_path_2 = true,
	forge_merge_trail_05 = true,
	journal_gradient_01 = true,
	loading_screen_courtyard_level = true,
	vermintide_logo_transparent = true,
	loading_screen_docks_short_level = true,
	quest_contract_checkmark_1_3 = true,
	quest_boon_glow_04 = true,
	craft_wheel_slot_glow = true,
	start_screen_selection_left = true,
	quest_contract_checkmark_3_1 = true,
	quest_boon_glow_07 = true,
	quest_reward_boon_glow_bg = true,
	forge_button_gamepad_fill_02 = true,
	loading_screen_default = true,
	lvl_box_bg_02_lit = true,
	selected_window_glow_settings_01 = true,
	teammate_hp_bar_color_tint_3 = true,
	quest_boon_glow_06 = true,
	start_screen_selection_right = true,
	options_menu_divider_glow_01 = true,
	quest_contract_checkmark_1_1 = true,
	loading_screen_dlc_dwarf_beacons = true,
	forge_merge_trail_06 = true,
	drachenfels_area_icon_banner = true,
	forge_merge_trail_02_path = true,
	unit_frame_portrait_dwarf_ranger = true,
	quest_contract_checkmark_2_1 = true,
	quest_gamepad_frame_glow_02 = true,
	drachenfels_area_icon_glass = true,
	reroll_glow_large = true,
	gamepad_difficulty_banner_1 = true,
	gamepad_difficulty_banner_2 = true,
	loading_screen_wizard = true,
	gamepad_difficulty_banner_3 = true,
	gamepad_difficulty_banner_4 = true,
	gamepad_difficulty_banner_5 = true,
	unit_frame_portrait_way_watcher = true,
	gamepad_difficulty_banner_2_masked = true,
	gamepad_difficulty_banner_3_masked = true,
	gamepad_difficulty_banner_4_masked = true,
	reroll_glow_button = true,
	gamepad_difficulty_banner_5_masked = true,
	loading_screen_inn_level = true,
	loading_screen_end_boss = true,
	hud_difficulty_unlocked_glow = true,
	unit_frame_portrait_witch_hunter = true,
	journal_gradient_04 = true,
	game_mode_selection_glow_01_masked = true,
	game_mode_selection_glow_02_masked = true,
	lvl_box_bg_02 = true,
	console_charge_bar_fill = true,
	trait_proc_box_fail_glow = true,
	forge_merge_trail_04 = true,
	start_game_detail_glow_masked = true,
	temp_controller = true,
	console_player_hp_bar = true,
	loading_screen_magnus = true,
	console_player_hp_bar_color_tint = true,
	dice_game_curtain = true,
	controller_hold_bar = true,
	gradient_main_menu = true,
	rect_masked = true,
	unit_frame_portrait_empire_soldier = true,
	gradient_credits_menu = true,
	loading_screen_city_wall = true,
	loading_screen_merchant = true,
	gamepad_difficulty_banner_1_masked = true,
	boon_frame_path_10 = true,
	quest_reward_banner = true,
	gamma_settings_image_02 = true,
	controller_input_overlay = true,
	journal_gradient_02 = true,
	forge_button_gamepad_fill = true,
	fatigue_icon_glow = true,
	forge_merge_trail_02 = true,
	teammate_hp_bar_color_tint_2 = true,
	loading_screen_tutorial_level = true,
	reroll_glow_skull = true,
	forge_merge_trail_01 = true,
	unit_frame_portrait_bright_wizard = true,
	loading_screen_dlc_portals = true,
	quest_endscreen_glow = true,
	teammate_hp_bar = true,
	game_mode_selection_glow_02 = true,
	craft_wheel_glow_normal = true,
	options_menu_divider_glow_02 = true,
	quest_contract_checkmark_3_2 = true,
	loading_screen_farm = true,
	journal_gradient_03 = true,
	quest_contract_checkmark_3_3 = true,
	forge_merge_trail_06_path = true,
	loading_screen_forest_ambush = true,
	quest_contract_checkmark_1_2 = true,
	loading_screen_dlc_castle_dungeon = true,
	boon_frame_path_3 = true,
	player_hp_bar = true,
	quest_contract_checkmark_2_2 = true,
	gradient_playerlist = true,
	forge_merge_trail_03 = true,
	loading_screen_tunnels = true,
	quest_contract_checkmark_2_3 = true,
	journal_gradient_05 = true,
	karak_azgaraz_location_icon_banner = true,
	esrb_logo = true,
	quest_boon_glow_02 = true,
	reroll_glow_small = true,
	settings_debug_gamma_correction = true,
	quest_boon_glow_03 = true,
	quest_gamepad_frame_glow_01 = true,
	loading_screen_cemetery = true,
	overchargecircle_fill = true,
	contract_glow_highlight = true,
	selected_window_glow = true,
	boon_frame_path_5 = true,
	quest_gamepad_frame_glow_03 = true,
	mask_rect = true,
	quest_boon_glow_01 = true,
	trait_proc_bar_glow = true,
	end_screen_banner_survival = true,
	quest_boon_glow_08 = true,
	craft_wheel_glow_large = true,
	end_screen_banner_defeat = true,
	interaction_bar = true,
	quest_gamepad_frame_glow_04 = true,
	quest_reward_boon_icon_frame = true,
	gradient_friend_list = true,
	reroll_glow_medium = true,
	gradient_enchantment_craft = true,
	level_location_selected = true,
	loading_screen_dlc_dwarf_exterior = true,
	loading_screen_sewers_short = true,
	pc_input_overlay = true,
	player_hp_bar_color_tint = true
}
local ui_atlas_setting_tables = {
	gui_loading_bg_bridge_atlas = loading_bg_bridge_atlas,
	gui_loading_bg_cemetery_atlas = loading_bg_cemetery_atlas,
	gui_loading_bg_city_wall_atlas = loading_bg_city_wall_atlas,
	gui_loading_bg_courtyard_atlas = loading_bg_courtyard_atlas,
	gui_loading_bg_docks_atlas = loading_bg_docks_atlas,
	gui_loading_bg_end_boss_atlas = loading_bg_end_boss_atlas,
	gui_loading_bg_farm_atlas = loading_bg_farm_atlas,
	gui_loading_bg_forest_ambush_atlas = loading_bg_forest_ambush_atlas,
	gui_loading_bg_inn_level_atlas = loading_bg_inn_level_atlas,
	gui_loading_bg_magnus_atlas = loading_bg_magnus_atlas,
	gui_loading_bg_merchant_atlas = loading_bg_merchant_atlas,
	gui_loading_bg_sewers_atlas = loading_bg_sewers_atlas,
	gui_loading_bg_tunnels_atlas = loading_bg_tunnels_atlas,
	gui_loading_bg_wizard_atlas = loading_bg_wizard_atlas,
	gui_item_icons_atlas = item_icons_atlas,
	gui_loading_icons_atlas = loading_icons_atlas,
	gui_input_icons_atlas = input_icons_atlas,
	gui_generic_icons_atlas = generic_icons_atlas,
	gui_popup_atlas = popup_atlas,
	gui_hud_atlas = hud_atlas,
	gui_hud_console_atlas = hud_console_atlas,
	gui_splash_atlas = splash_atlas,
	gui_game_logos_atlas = game_logos_atlas,
	gui_menu_buttons_atlas = menu_buttons_atlas,
	gui_chat_atlas = chat_atlas,
	gui_voice_chat_atlas = voice_chat_atlas,
	gui_gamma_settings_atlas = gamma_settings_atlas,
	gui_altar_atlas = altar_atlas,
	gui_common_atlas = common_atlas,
	gui_end_of_level_atlas = end_of_level_atlas,
	gui_forge_atlas = forge_atlas,
	gui_frames_atlas = frames_atlas,
	gui_friends_list_atlas = friends_list_atlas,
	gui_inventory_atlas = inventory_atlas,
	gui_journal_atlas = journal_atlas,
	gui_playerlist_atlas = playerlist_atlas,
	gui_quest_atlas = quest_atlas,
	gui_settings_atlas = settings_atlas,
	gui_telemetry_survey_atlas = telemetry_survey_atlas,
	gui_unlock_key_atlas = unlock_key_atlas,
	gui_matchmaking_atlas = matchmaking_atlas,
	gui_start_screen_atlas = start_screen_atlas
}

if platform == "win32" then
	ui_atlas_setting_tables.gui_map_atlas = map_atlas
	ui_atlas_setting_tables.gui_map_locations_atlas = map_locations_atlas
	ui_atlas_setting_tables.gui_level_images_atlas = level_images_atlas
else
	ui_atlas_setting_tables.gui_map_console_atlas = map_console_atlas
	ui_atlas_setting_tables.gui_level_images_console_atlas = level_images_console_atlas
end

local masked_materials = {
	gui_end_of_level_atlas = "gui_end_of_level_atlas_masked",
	gui_settings_atlas = "gui_settings_atlas_masked",
	gui_journal_atlas = "gui_journal_atlas_masked",
	gui_hud_atlas = "gui_hud_atlas_masked",
	gui_hud_console_atlas = "gui_hud_console_atlas_masked",
	gui_forge_atlas = "gui_forge_atlas_masked",
	gui_item_icons_atlas = "gui_item_icons_atlas_masked",
	gui_telemetry_survey_atlas = "gui_telemetry_survey_atlas_masked",
	gui_unlock_key_atlas = "gui_unlock_key_atlas_masked",
	gui_start_screen_atlas = "gui_start_screen_atlas_masked",
	gui_generic_icons_atlas = "gui_generic_icons_atlas_masked",
	gui_quest_atlas = "gui_quest_atlas_masked",
	gui_friends_list_atlas = "gui_friends_list_atlas_masked",
	gui_input_icons_atlas = "gui_input_icons_atlas_masked",
	gui_altar_atlas = "gui_altar_atlas_masked",
	gui_frames_atlas = "gui_frames_atlas_masked",
	gui_playerlist_atlas = "gui_playerlist_atlas_masked",
	gui_matchmaking_atlas = "gui_matchmaking_atlas_masked",
	gui_inventory_atlas = "gui_inventory_atlas_masked",
	gui_common_atlas = "gui_common_atlas_masked"
}

if platform == "win32" then
	masked_materials.gui_map_atlas = "gui_map_atlas_masked"
	masked_materials.gui_map_locations_atlas = "gui_map_locations_atlas_masked"
else
	masked_materials.gui_map_console_atlas = "gui_map_console_atlas_masked"
	masked_materials.gui_level_images_console_atlas = "gui_level_images_console_atlas_masked"
end

local saturated_materials = {
	gui_quest_atlas = "gui_quest_atlas_saturated"
}

if platform ~= "win32" then
	saturated_materials.gui_map_console_atlas = "gui_map_console_atlas_saturated"
end

local masked_point_sample_materials = {
	gui_end_of_level_atlas = "gui_end_of_level_atlas_point_sample_masked",
	gui_settings_atlas = "gui_settings_atlas_point_sample_masked",
	gui_journal_atlas = "gui_journal_atlas_point_sample_masked",
	gui_hud_atlas = "gui_hud_atlas_point_sample_masked",
	gui_hud_console_atlas = "gui_hud_console_atlas_point_sample_masked",
	gui_forge_atlas = "gui_forge_atlas_point_sample_masked",
	gui_item_icons_atlas = "gui_item_icons_atlas_point_sample_masked",
	gui_start_screen_atlas = "gui_start_screen_atlas_point_sample_masked",
	gui_unlock_key_atlas = "gui_unlock_key_atlas_point_sample_masked",
	gui_telemetry_survey_atlas = "gui_telemetry_survey_atlas_point_sample_masked",
	gui_generic_icons_atlas = "gui_generic_icons_atlas_point_sample_masked",
	gui_quest_atlas = "gui_quest_atlas_point_sample_masked",
	gui_friends_list_atlas = "gui_friends_list_atlas_point_sample_masked",
	gui_input_icons_atlas = "gui_input_icons_atlas_point_sample_masked",
	gui_altar_atlas = "gui_altar_atlas_point_sample_masked",
	gui_frames_atlas = "gui_frames_atlas_point_sample_masked",
	gui_playerlist_atlas = "gui_playerlist_atlas_point_sample_masked",
	gui_matchmaking_atlas = "gui_matchmaking_atlas_point_sample_masked",
	gui_inventory_atlas = "gui_inventory_atlas_point_sample_masked",
	gui_common_atlas = "gui_common_atlas_point_sample_masked"
}

if platform == "win32" then
	masked_point_sample_materials.gui_map_atlas = "gui_map_atlas_point_sample_masked"
	masked_point_sample_materials.gui_map_locations_atlas = "gui_map_locations_atlas_point_sample_masked"
else
	masked_point_sample_materials.gui_map_console_atlas = "gui_map_console_atlas_point_sample_masked"
	masked_point_sample_materials.gui_level_images_console_atlas = "gui_level_images_console_atlas_point_sample_masked"
end

local point_sample_materials = {
	gui_voice_chat_atlas = "gui_voice_chat_atlas_point_sample",
	gui_settings_atlas = "gui_settings_atlas_point_sample",
	gui_chat_atlas = "gui_chat_atlas_point_sample",
	unit_frame_portrait_dwarf_ranger = "unit_frame_portrait_dwarf_ranger_point_sample",
	loading_screen_tunnels = "loading_screen_tunnels_point_sample",
	gui_forge_atlas = "gui_forge_atlas_point_sample",
	gui_common_atlas = "gui_common_atlas_point_sample",
	gui_game_logos_atlas = "gui_game_logos_atlas_point_sample",
	gui_unlock_key_atlas = "gui_unlock_key_atlas_point_sample",
	gui_gamma_settings_atlas = "gui_gamma_settings_atlas_point_sample",
	loading_screen_merchant = "loading_screen_merchant_point_sample",
	loading_screen_survival_01_level = "loading_screen_survival_01_level_point_sample",
	loading_screen_city_wall = "loading_screen_city_wall_point_sample",
	loading_screen_courtyard_level = "loading_screen_courtyard_level_point_sample",
	loading_screen_docks_short_level = "loading_screen_docks_short_level_point_sample",
	loading_screen_wizard = "loading_screen_wizard_point_sample",
	gui_quest_atlas = "gui_quest_atlas_point_sample",
	gui_friends_list_atlas = "gui_friends_list_atlas_point_sample",
	gui_loading_icons_atlas = "gui_loading_icons_atlas_point_sample",
	gui_hud_atlas = "gui_hud_atlas_point_sample",
	gui_altar_atlas = "gui_altar_atlas_point_sample",
	loading_screen_bridge = "loading_screen_bridge_point_sample",
	gui_frames_atlas = "gui_frames_atlas_point_sample",
	gui_playerlist_atlas = "gui_playerlist_atlas_point_sample",
	loading_screen_cemetery = "loading_screen_cemetery_point_sample",
	loading_screen_inn_level = "loading_screen_inn_level_point_sample",
	loading_screen_end_boss = "loading_screen_end_boss_point_sample",
	loading_screen_survival_02_level = "loading_screen_survival_02_level_point_sample",
	controller_image_ps4 = "controller_image_ps4_point_sample",
	controller_image_xb1 = "controller_image_xb1_point_sample",
	controller_input_overlay = "controller_input_overlay_point_sample",
	gui_end_of_level_atlas = "gui_end_of_level_atlas_point_sample",
	unit_frame_portrait_witch_hunter = "unit_frame_portrait_witch_hunter_point_sample",
	gui_telemetry_survey_atlas = "gui_telemetry_survey_atlas_point_sample",
	gui_journal_atlas = "gui_journal_atlas_point_sample",
	end_screen_banner_effect = "end_screen_banner_effect_point_sample",
	gui_start_screen_atlas = "gui_start_screen_atlas_point_sample",
	unit_frame_portrait_bright_wizard = "unit_frame_portrait_bright_wizard_point_sample",
	gui_hud_console_atlas = "gui_hud_console_atlas_point_sample",
	temp_controller = "temp_controller_point_sample",
	end_screen_banner_survival = "end_screen_banner_survival_point_sample",
	loading_screen_magnus = "loading_screen_magnus_point_sample",
	overchargecircle_sidefade = "overchargecircle_fill_point_sample",
	end_screen_banner_victory = "end_screen_banner_victory_point_sample",
	overchargecircle_fill = "overchargecircle_fill_point_sample",
	unit_frame_portrait_way_watcher = "unit_frame_portrait_way_watcher_point_sample",
	gui_generic_icons_atlas = "gui_generic_icons_atlas_point_sample",
	loading_screen_farm = "loading_screen_farm_point_sample",
	end_screen_banner_defeat = "end_screen_banner_defeat_point_sample",
	vermintide_logo_transparent = "vermintide_logo_transparent_point_sample",
	gui_input_icons_atlas = "gui_input_icons_atlas_point_sample",
	gui_popup_atlas = "gui_popup_atlas_point_sample",
	controller_hold_bar = "controller_hold_bar_point_sample",
	gui_item_icons_atlas = "gui_item_icons_atlas_point_sample",
	gui_menu_buttons_atlas = "gui_menu_buttons_atlas_point_sample",
	loading_screen_forest_ambush = "loading_screen_forest_ambush_point_sample",
	gui_matchmaking_atlas = "gui_matchmaking_atlas_point_sample",
	unit_frame_portrait_empire_soldier = "unit_frame_portrait_empire_soldier_point_sample",
	loading_screen_sewers_short = "loading_screen_sewers_short_point_sample",
	pc_input_overlay = "pc_input_overlay_point_sample",
	gui_inventory_atlas = "gui_inventory_atlas_point_sample",
	gui_splash_atlas = "gui_splash_atlas_point_sample"
}

if platform == "win32" then
	point_sample_materials.gui_map_atlas = "gui_map_atlas_point_sample"
	point_sample_materials.gui_map_locations_atlas = "gui_map_locations_atlas_point_sample"
	point_sample_materials.gui_level_images_atlas = "gui_level_images_atlas_point_sample"
else
	point_sample_materials.gui_map_console_atlas = "gui_map_console_atlas_point_sample"
	point_sample_materials.gui_level_images_console_atlas = "gui_level_images_console_atlas_point_sample"
end

local ui_atlas_settings = {}

for material, material_settings in pairs(ui_atlas_setting_tables) do
	for texture_name, texture_settings in pairs(material_settings) do
		local settings = table.clone(texture_settings)
		settings.material_name = material
		settings.masked_material_name = masked_materials[material]
		settings.point_sample_material_name = point_sample_materials[material]
		settings.masked_point_sample_material_name = masked_point_sample_materials[material]
		settings.saturated_material_name = saturated_materials[material]
		local existing_material_name = ui_atlas_settings[texture_name] and ui_atlas_settings[texture_name].material_name

		fassert(ui_atlas_settings[texture_name] == nil, "[UIAtlasHelper] - Texture (%s) in material (%s) already exist in material (%s). Make sure to use unique texture names.", texture_name, material, existing_material_name)

		ui_atlas_settings[texture_name] = settings
	end
end

UIAtlasHelper.get_atlas_settings_by_texture_name = function (texture_name)
	assert(texture_name, "[UIAtlasHelper] - Trying to access atlas settings for a texture without a name")

	if none_atlas_textures[texture_name] then
		return 
	end

	local texture_settings = ui_atlas_settings[texture_name]

	assert(texture_settings, "[UIAtlasHelper] - Atlas texture settings for (%s) does not exist.", texture_name)

	return texture_settings
end

return 
