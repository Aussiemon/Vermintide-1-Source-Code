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
require("scripts/ui/atlas_settings/gui_telemetry_survey_atlas")
require("scripts/ui/atlas_settings/gui_unlock_key_atlas")
require("scripts/ui/atlas_settings/gui_matchmaking_atlas")
require("scripts/ui/atlas_settings/gui_start_screen_atlas")

local platform = PLATFORM

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
	arrogance_lost_logo = true,
	loading_screen_dlc_stromdorf_hills = true,
	loot_pop_up_bg = true,
	craft_arrow_button_glow = true,
	boon_icon_bg = true,
	unit_frame_portrait_dwarf_ranger = true,
	boon_frame_path_9 = true,
	boon_frame_path_1 = true,
	ubersreik_area_icon_banner = true,
	survival_ruins_dlc_logo = true,
	gradient_map_screen = true,
	craft_wheel_slot_glow = true,
	quest_boon_glow_05 = true,
	level_list_selection_frame = true,
	game_mode_selection_glow_01 = true,
	charge_bar_flames_mask = true,
	loading_screen_dlc_stromdorf_town = true,
	boon_frame_path_6 = true,
	loading_screen_dlc_castle = true,
	boon_frame_path_7 = true,
	loading_screen_bridge = true,
	contract_masked_overlay = true,
	forge_progress_bar_fill = true,
	summary_screen_experience_bar = true,
	boon_frame_path_4 = true,
	charge_bar_flames = true,
	loading_screen_dlc_dwarf_interior = true,
	arrogance_lost_bg = true,
	dwarf_ranger_skin_01_dlc_image = true,
	loading_screen_default = true,
	end_screen_banner_effect = true,
	forge_merge_trail_03_path = true,
	vermintide_logo_title = true,
	forge_merge_trail_01_path = true,
	map_area_banner_difficulty_icon = true,
	end_screen_banner_victory = true,
	loading_screen_survival_01_level = true,
	unit_frame_portrait_witch_hunter = true,
	loading_screen_survival_02_level = true,
	teammate_hp_bar_color_tint_3 = true,
	mask_rect_edge_fade = true,
	overchargecircle_sidefade = true,
	loading_screen_magnus = true,
	boon_icon_bg_mask = true,
	start_game_detail_glow = true,
	quest_contract_checkmark_1_2 = true,
	forge_merge_trail_05 = true,
	journal_gradient_01 = true,
	lvl_box_bg_02_lit = true,
	vermintide_logo_transparent = true,
	dwarfs_bg = true,
	forge_merge_trail_04 = true,
	quest_boon_glow_06 = true,
	quest_boon_glow_07 = true,
	start_screen_selection_left = true,
	quest_contract_checkmark_3_1 = true,
	quest_gamepad_frame_glow_02 = true,
	loading_screen_dlc_reikwald_forest = true,
	forge_button_gamepad_fill_02 = true,
	loading_screen_docks_short_level = true,
	quest_reward_boon_glow_bg = true,
	gamepad_difficulty_banner_4 = true,
	loading_screen_courtyard_level = true,
	drachenfels_area_icon_banner = true,
	forge_merge_trail_05_path = true,
	hud_difficulty_unlocked_glow = true,
	quest_contract_checkmark_1_1 = true,
	loading_screen_dlc_dwarf_beacons = true,
	forge_merge_trail_06 = true,
	gradient_dice_game_reward = true,
	gamepad_difficulty_banner_1 = true,
	gamepad_difficulty_banner_2 = true,
	quest_contract_checkmark_2_1 = true,
	gamepad_difficulty_banner_3 = true,
	drachenfels_area_icon_glass = true,
	reroll_glow_large = true,
	start_screen_selection_right = true,
	gamepad_difficulty_banner_5 = true,
	loading_screen_wizard = true,
	gamepad_difficulty_banner_2_masked = true,
	gamepad_difficulty_banner_3_masked = true,
	gamepad_difficulty_banner_4_masked = true,
	unit_frame_portrait_way_watcher = true,
	gamepad_difficulty_banner_5_masked = true,
	boon_frame_path_8 = true,
	reroll_glow_corner = true,
	reroll_glow_button = true,
	game_mode_selection_glow_01_masked = true,
	loading_screen_inn_level = true,
	loading_screen_end_boss = true,
	reikwald_bg = true,
	console_charge_bar_fill = true,
	journal_gradient_04 = true,
	forge_merge_trail_04_path = true,
	start_game_detail_glow_masked = true,
	lvl_box_bg_02 = true,
	drachenfels_dlc_image = true,
	trait_proc_box_fail_glow = true,
	reikwald_dlc_image = true,
	trait_proc_box_glow = true,
	drachenfels_dlc_logo = true,
	quest_contract_checkmark_1_3 = true,
	options_menu_divider_glow_01 = true,
	console_player_hp_bar = true,
	quest_event_contract_holder_glow = true,
	mask_rect_linear_vertical_fade = true,
	dlc_frame_corner = true,
	dlc_frame_side = true,
	new_dlc = true,
	console_player_hp_bar_color_tint = true,
	survival_ruins_bg = true,
	dice_game_curtain = true,
	drachenfels_bg = true,
	quest_boon_glow_04 = true,
	dwarfs_dlc_image = true,
	stromdorf_bg = true,
	controller_hold_bar = true,
	game_mode_selection_glow_02_masked = true,
	loading_screen_dlc_portals = true,
	gradient_main_menu = true,
	rect_masked = true,
	witch_hunter_skin_01_dlc_image = true,
	unit_frame_portrait_empire_soldier = true,
	forge_merge_trail_06_path = true,
	gradient_credits_menu = true,
	loading_screen_city_wall = true,
	loading_screen_merchant = true,
	wood_elf_skin_01_dlc_image = true,
	empire_soldier_skin_01_dlc_image = true,
	gamepad_difficulty_banner_1_masked = true,
	boon_frame_path_10 = true,
	quest_reward_banner = true,
	gamma_settings_image_02 = true,
	loading_screen_dlc_reikwald_river = true,
	gamma_settings_image_01 = true,
	journal_gradient_02 = true,
	forge_button_gamepad_fill = true,
	fatigue_icon_glow = true,
	forge_merge_trail_02 = true,
	reikwald_location_icon_banner = true,
	teammate_hp_bar_color_tint_2 = true,
	loading_screen_tutorial_level = true,
	reroll_glow_skull = true,
	forge_merge_trail_01 = true,
	unit_frame_portrait_bright_wizard = true,
	teammate_hp_bar_color_tint_1 = true,
	quest_endscreen_glow = true,
	stromdorf_dlc_image = true,
	teammate_hp_bar = true,
	game_mode_selection_glow_02 = true,
	loading_screen_dlc_challenge_wizard = true,
	craft_wheel_glow_normal = true,
	options_menu_divider_glow_02 = true,
	dlc_checkmark = true,
	quest_contract_checkmark_3_2 = true,
	stromdorf_location_icon_banner = true,
	loading_screen_farm = true,
	journal_gradient_03 = true,
	quest_contract_checkmark_3_3 = true,
	forge_merge_trail_02_path = true,
	dwarfs_dlc_logo = true,
	loading_screen_forest_ambush = true,
	boon_frame_path_2 = true,
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
	stromdorf_dlc_logo = true,
	quest_gamepad_frame_glow_01 = true,
	loading_screen_cemetery = true,
	overchargecircle_fill = true,
	selected_window_glow = true,
	boon_frame_path_5 = true,
	quest_gamepad_frame_glow_03 = true,
	mask_rect = true,
	quest_boon_glow_01 = true,
	trait_proc_bar_glow = true,
	end_screen_banner_survival = true,
	dlc_frame_edge = true,
	survival_ruins_dlc_image = true,
	quest_boon_glow_08 = true,
	craft_wheel_glow_large = true,
	reikwald_dlc_logo = true,
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
	player_hp_bar_color_tint = true,
	bright_wizard_skin_01_dlc_image = true
}

if platform == "win32" then
	none_atlas_textures.controller_image_ps4 = true
	none_atlas_textures.controller_image_xb1 = true
elseif platform == "ps4" then
	none_atlas_textures.controller_image_ps4 = true
elseif platform == "xb1" then
	none_atlas_textures.controller_image_xb1 = true
end

local ui_atlas_setting_tables = {
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
	gui_telemetry_survey_atlas = "gui_telemetry_survey_atlas_masked",
	gui_journal_atlas = "gui_journal_atlas_masked",
	gui_hud_atlas = "gui_hud_atlas_masked",
	gui_hud_console_atlas = "gui_hud_console_atlas_masked",
	gui_forge_atlas = "gui_forge_atlas_masked",
	gui_item_icons_atlas = "gui_item_icons_atlas_masked",
	gui_start_screen_atlas = "gui_start_screen_atlas_masked",
	gui_unlock_key_atlas = "gui_unlock_key_atlas_masked",
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
	gui_telemetry_survey_atlas = "gui_telemetry_survey_atlas_point_sample_masked",
	gui_journal_atlas = "gui_journal_atlas_point_sample_masked",
	gui_hud_atlas = "gui_hud_atlas_point_sample_masked",
	gui_hud_console_atlas = "gui_hud_console_atlas_point_sample_masked",
	gui_forge_atlas = "gui_forge_atlas_point_sample_masked",
	gui_item_icons_atlas = "gui_item_icons_atlas_point_sample_masked",
	gui_start_screen_atlas = "gui_start_screen_atlas_point_sample_masked",
	gui_unlock_key_atlas = "gui_unlock_key_atlas_point_sample_masked",
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
	gui_chat_atlas = "gui_chat_atlas_point_sample",
	gui_voice_chat_atlas = "gui_voice_chat_atlas_point_sample",
	gui_hud_console_atlas = "gui_hud_console_atlas_point_sample",
	unit_frame_portrait_dwarf_ranger = "unit_frame_portrait_dwarf_ranger_point_sample",
	loading_screen_tunnels = "loading_screen_tunnels_point_sample",
	gui_forge_atlas = "gui_forge_atlas_point_sample",
	gui_common_atlas = "gui_common_atlas_point_sample",
	gui_game_logos_atlas = "gui_game_logos_atlas_point_sample",
	gui_unlock_key_atlas = "gui_unlock_key_atlas_point_sample",
	loading_screen_merchant = "loading_screen_merchant_point_sample",
	loading_screen_cemetery = "loading_screen_cemetery_point_sample",
	loading_screen_survival_01_level = "loading_screen_survival_01_level_point_sample",
	loading_screen_courtyard_level = "loading_screen_courtyard_level_point_sample",
	loading_screen_docks_short_level = "loading_screen_docks_short_level_point_sample",
	loading_screen_city_wall = "loading_screen_city_wall_point_sample",
	loading_screen_wizard = "loading_screen_wizard_point_sample",
	gui_quest_atlas = "gui_quest_atlas_point_sample",
	gui_friends_list_atlas = "gui_friends_list_atlas_point_sample",
	gui_loading_icons_atlas = "gui_loading_icons_atlas_point_sample",
	gui_hud_atlas = "gui_hud_atlas_point_sample",
	gui_altar_atlas = "gui_altar_atlas_point_sample",
	loading_screen_bridge = "loading_screen_bridge_point_sample",
	gui_frames_atlas = "gui_frames_atlas_point_sample",
	gui_playerlist_atlas = "gui_playerlist_atlas_point_sample",
	loading_screen_survival_02_level = "loading_screen_survival_02_level_point_sample",
	loading_screen_inn_level = "loading_screen_inn_level_point_sample",
	loading_screen_end_boss = "loading_screen_end_boss_point_sample",
	end_screen_banner_victory = "end_screen_banner_victory_point_sample",
	end_screen_banner_effect = "end_screen_banner_effect_point_sample",
	unit_frame_portrait_bright_wizard = "unit_frame_portrait_bright_wizard_point_sample",
	gui_gamma_settings_atlas = "gui_gamma_settings_atlas_point_sample",
	gui_end_of_level_atlas = "gui_end_of_level_atlas_point_sample",
	unit_frame_portrait_witch_hunter = "unit_frame_portrait_witch_hunter_point_sample",
	gui_telemetry_survey_atlas = "gui_telemetry_survey_atlas_point_sample",
	gui_journal_atlas = "gui_journal_atlas_point_sample",
	unit_frame_portrait_way_watcher = "unit_frame_portrait_way_watcher_point_sample",
	gui_start_screen_atlas = "gui_start_screen_atlas_point_sample",
	overchargecircle_fill = "overchargecircle_fill_point_sample",
	loading_screen_dlc_challenge_wizard = "loading_screen_dlc_challenge_wizard_point_sample",
	end_screen_banner_survival = "end_screen_banner_survival_point_sample",
	loading_screen_magnus = "loading_screen_magnus_point_sample",
	overchargecircle_sidefade = "overchargecircle_fill_point_sample",
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

if platform == "win32" then
	point_sample_materials.controller_image_ps4 = "controller_image_ps4_point_sample"
	point_sample_materials.controller_image_xb1 = "controller_image_xb1_point_sample"
elseif platform == "ps4" then
	point_sample_materials.controller_image_ps4 = "controller_image_ps4_point_sample"
elseif platform == "xb1" then
	point_sample_materials.controller_image_xb1 = "controller_image_xb1_point_sample"
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

UIAtlasHelper.has_atlas_settings_by_texture_name = function (texture_name)
	return (ui_atlas_settings[texture_name] and true) or false
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
