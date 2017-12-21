local_require("scripts/ui/ui_widgets")
require("scripts/settings/quest_settings")

local PAGE_SPACING = 25
local scenegraph_definition = {
	root = {
		is_root = true,
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.default
		}
	},
	dead_space_filler = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			0
		}
	},
	menu_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			0
		}
	},
	menu_hover_overlay = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			20
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			420,
			28
		},
		position = {
			0,
			-10,
			1
		}
	},
	exit_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "right",
		size = {
			220,
			62
		},
		position = {
			-50,
			40,
			12
		}
	},
	board_title_bg = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			476,
			70
		},
		position = {
			520,
			-250,
			18
		}
	},
	log_title_bg = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			350,
			70
		},
		position = {
			1510,
			-250,
			18
		}
	},
	board_title = {
		vertical_alignment = "center",
		parent = "board_title_bg",
		horizontal_alignment = "center",
		size = {
			420,
			28
		},
		position = {
			0,
			9,
			1
		}
	},
	log_title = {
		vertical_alignment = "center",
		parent = "log_title_bg",
		horizontal_alignment = "center",
		size = {
			420,
			28
		},
		position = {
			0,
			9,
			1
		}
	},
	previous_page_button = {
		vertical_alignment = "center",
		parent = "board_title_bg",
		horizontal_alignment = "left",
		size = {
			42,
			64
		},
		position = {
			-37,
			3,
			12
		}
	},
	next_page_button = {
		vertical_alignment = "center",
		parent = "board_title_bg",
		horizontal_alignment = "right",
		size = {
			42,
			64
		},
		position = {
			37,
			3,
			12
		}
	},
	log_parent = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "right",
		size = {
			355,
			890
		},
		position = {
			-37,
			-55,
			1
		}
	},
	log_quest = {
		vertical_alignment = "top",
		parent = "log_parent",
		horizontal_alignment = "center",
		size = {
			352,
			223
		},
		position = {
			-26,
			30,
			1
		}
	},
	log_contract = {
		vertical_alignment = "bottom",
		parent = "log_parent",
		horizontal_alignment = "center",
		size = {
			355,
			670
		},
		position = {
			-35,
			-25,
			1
		}
	},
	log_contract_1 = {
		vertical_alignment = "center",
		parent = "log_contract",
		horizontal_alignment = "center",
		size = {
			390,
			215
		},
		position = {
			20,
			215,
			1
		}
	},
	log_contract_2 = {
		vertical_alignment = "center",
		parent = "log_contract",
		horizontal_alignment = "center",
		size = {
			390,
			215
		},
		position = {
			20,
			0,
			1
		}
	},
	log_contract_3 = {
		vertical_alignment = "center",
		parent = "log_contract",
		horizontal_alignment = "center",
		size = {
			390,
			215
		},
		position = {
			20,
			-215,
			1
		}
	},
	board_parent = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "left",
		size = {
			1450,
			890
		},
		position = {
			37,
			-55,
			1
		}
	},
	board_quest_parent = {
		vertical_alignment = "top",
		parent = "board_parent",
		horizontal_alignment = "center",
		size = {
			1450,
			180
		},
		position = {
			0,
			0,
			1
		}
	},
	board_quest_slot_1 = {
		vertical_alignment = "center",
		parent = "board_quest_parent",
		horizontal_alignment = "left",
		size = {
			352,
			223
		},
		position = {
			76,
			10,
			1
		}
	},
	board_quest_slot_2 = {
		vertical_alignment = "center",
		parent = "board_quest_parent",
		horizontal_alignment = "center",
		size = {
			352,
			223
		},
		position = {
			-16,
			10,
			1
		}
	},
	board_quest_slot_3 = {
		vertical_alignment = "center",
		parent = "board_quest_parent",
		horizontal_alignment = "right",
		size = {
			352,
			223
		},
		position = {
			-116,
			10,
			1
		}
	},
	board_contract_parent = {
		vertical_alignment = "top",
		parent = "board_quest_parent",
		horizontal_alignment = "center",
		size = {
			1450,
			660
		},
		position = {
			0,
			-230,
			1
		}
	},
	board_contract_slot_1 = {
		vertical_alignment = "top",
		parent = "board_contract_parent",
		horizontal_alignment = "center",
		size = {
			300,
			335
		},
		position = {
			-570,
			0,
			1
		}
	},
	board_contract_slot_2 = {
		vertical_alignment = "top",
		parent = "board_contract_parent",
		horizontal_alignment = "center",
		size = {
			300,
			335
		},
		position = {
			-210,
			0,
			1
		}
	},
	board_contract_slot_3 = {
		vertical_alignment = "top",
		parent = "board_contract_parent",
		horizontal_alignment = "center",
		size = {
			300,
			335
		},
		position = {
			160,
			0,
			1
		}
	},
	board_contract_slot_4 = {
		vertical_alignment = "top",
		parent = "board_contract_parent",
		horizontal_alignment = "center",
		size = {
			300,
			335
		},
		position = {
			520,
			0,
			1
		}
	},
	board_contract_slot_5 = {
		vertical_alignment = "bottom",
		parent = "board_contract_parent",
		horizontal_alignment = "center",
		size = {
			300,
			335
		},
		position = {
			-570,
			0,
			1
		}
	},
	board_contract_slot_6 = {
		vertical_alignment = "bottom",
		parent = "board_contract_parent",
		horizontal_alignment = "center",
		size = {
			300,
			335
		},
		position = {
			-210,
			0,
			1
		}
	},
	board_contract_slot_7 = {
		vertical_alignment = "bottom",
		parent = "board_contract_parent",
		horizontal_alignment = "center",
		size = {
			300,
			335
		},
		position = {
			160,
			0,
			1
		}
	},
	board_contract_slot_8 = {
		vertical_alignment = "bottom",
		parent = "board_contract_parent",
		horizontal_alignment = "center",
		size = {
			300,
			335
		},
		position = {
			520,
			0,
			1
		}
	},
	detail_popup_bg_fade = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			30
		}
	},
	detail_popup_accept_button = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			220,
			62
		},
		position = {
			-120,
			36,
			10
		}
	},
	detail_popup_close_button = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			220,
			62
		},
		position = {
			120,
			36,
			10
		}
	},
	contract_reward_continue_button = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			220,
			62
		},
		position = {
			0,
			40,
			12
		}
	},
	reward_popup_dummy_bg_fade = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			30
		}
	},
	reward_popup_bg_fade = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			30
		}
	},
	reward_continue_button = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			220,
			62
		},
		position = {
			0,
			40,
			12
		}
	},
	trait_button_1 = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-275,
			615,
			6
		}
	},
	trait_button_2 = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-275,
			565,
			6
		}
	},
	trait_button_3 = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-275,
			515,
			6
		}
	},
	trait_button_4 = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-275,
			465,
			6
		}
	},
	trait_tooltip_1 = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-275,
			615,
			16
		}
	},
	trait_tooltip_2 = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-275,
			565,
			16
		}
	},
	trait_tooltip_3 = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-275,
			515,
			16
		}
	},
	trait_tooltip_4 = {
		vertical_alignment = "bottom",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-275,
			465,
			16
		}
	},
	hero_icon_tooltip = {
		vertical_alignment = "center",
		parent = "detail_popup_bg_fade",
		horizontal_alignment = "center",
		size = {
			46,
			46
		},
		position = {
			0,
			210,
			5
		}
	},
	description_background = {
		scale = "fit",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.end_screen + 60
		}
	},
	description_title = {
		vertical_alignment = "top",
		parent = "description_background",
		horizontal_alignment = "center",
		size = {
			300,
			60
		},
		position = {
			0,
			-200,
			60
		}
	},
	description_text = {
		vertical_alignment = "top",
		parent = "description_title",
		horizontal_alignment = "center",
		size = {
			850,
			800
		},
		position = {
			0,
			-60,
			1
		}
	},
	input_description_text = {
		vertical_alignment = "bottom",
		parent = "description_background",
		horizontal_alignment = "center",
		size = {
			800,
			50
		},
		position = {
			0,
			110,
			1
		}
	},
	completion_header = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1400,
			80
		},
		position = {
			0,
			150,
			30
		}
	},
	completion_title = {
		vertical_alignment = "top",
		parent = "completion_header",
		horizontal_alignment = "center",
		size = {
			1400,
			80
		},
		position = {
			0,
			-80,
			30
		}
	}
}
local title_bar_text_style = {
	vertical_alignment = "center",
	font_type = "hell_shark",
	font_size = 32,
	horizontal_alignment = "center",
	text_color = Colors.get_color_table_with_alpha("black", 255)
}
local title_bar_long_quest_style = table.clone(title_bar_text_style)
title_bar_long_quest_style.scenegraph_id = "board_quest_title_bar_txt"
local title_bar_short_quest_style = table.clone(title_bar_text_style)
title_bar_short_quest_style.scenegraph_id = "board_contract_title_bar_txt"
local log_title_bar_style = table.clone(title_bar_text_style)
log_title_bar_style.scenegraph_id = "log_title_bar_txt"
local detail_popup_title_style = table.clone(title_bar_text_style)
detail_popup_title_style.scenegraph_id = "detail_popup_title"
local detail_popup_requirement_title_style = table.clone(title_bar_text_style)
detail_popup_requirement_title_style.scenegraph_id = "detail_popup_requirement_title"
detail_popup_requirement_title_style.horizontal_alignment = "right"
detail_popup_requirement_title_style.vertical_alignment = "bottom"
local detail_popup_reward_title_style = table.clone(title_bar_text_style)
detail_popup_reward_title_style.scenegraph_id = "detail_popup_reward_title"
detail_popup_reward_title_style.horizontal_alignment = "left"
detail_popup_reward_title_style.vertical_alignment = "bottom"
local get_atlas_settings_by_texture_name = UIAtlasHelper.get_atlas_settings_by_texture_name

local function create_popup_quest(parent_scenegraph_id)
	local size = {
		781,
		904
	}
	local canvas_size = {
		695,
		835
	}
	local pass_offset = {
		0,
		0,
		1
	}
	local canvas_offset = {
		0,
		0,
		1
	}
	local parent_size = scenegraph_definition[parent_scenegraph_id].size
	local width_diff = parent_size[1] - size[1]
	local height_diff = parent_size[2] - size[2]
	local width_offset = width_diff*0.5
	local height_offset = height_diff*0.5 + 50
	pass_offset[1] = width_offset
	pass_offset[2] = height_offset
	canvas_offset[1] = pass_offset[1] + (size[1] - canvas_size[1])*0.5
	canvas_offset[2] = pass_offset[2] + (size[2] - canvas_size[2])*0.5
	canvas_offset[3] = pass_offset[3]
	local block_height = canvas_size[2]/5.7
	local text_icon_spacing = 5
	local quest_link_spacing = 10
	local reward_icon_spacing = 35
	local trait_icon_spacing = 10
	local row_divider_height = 25
	local divider_texture_name = "quest_screen_divider"
	local divider_texture_settings = get_atlas_settings_by_texture_name(divider_texture_name)
	local divider_texture_size = divider_texture_settings.size
	local quest_link_bg_texture = get_atlas_settings_by_texture_name("quest_link_marker_bg_01")
	local quest_link_bg_texture_size = {
		quest_link_bg_texture.size[1]*0.75,
		quest_link_bg_texture.size[2]*0.75
	}
	local quest_link_fg_texture = get_atlas_settings_by_texture_name("quest_link_marker_fg_main_01")
	local quest_link_fg_texture_size = {
		quest_link_fg_texture.size[1]*0.75,
		quest_link_fg_texture.size[2]*0.75
	}
	local hero_icon_texture_settings = get_atlas_settings_by_texture_name("hero_icon_medium_bright_wizard_yellow")
	local hero_icon_texture_size = hero_icon_texture_settings.size
	local reward_item_texture_settings = get_atlas_settings_by_texture_name("icon_dw_shield_04_axe_05")
	local reward_item_texture_size = reward_item_texture_settings.size
	local reward_item_frame_texture_settings = get_atlas_settings_by_texture_name("frame_01")
	local reward_item_frame_texture_size = reward_item_frame_texture_settings.size
	local item_trait_texture_settings = get_atlas_settings_by_texture_name("trait_icon_backstabbery")
	local item_trait_texture_size = item_trait_texture_settings.size
	local reward_token_texture_settings = get_atlas_settings_by_texture_name("token_icon_01_large")
	local reward_token_texture_size = {
		reward_token_texture_settings.size[1],
		reward_token_texture_settings.size[2]
	}
	local item_reward_bg_texture_settings = get_atlas_settings_by_texture_name("leather_bg")
	local item_reward_bg_texture_size = item_reward_bg_texture_settings.size
	local boon_reward_bg_texture_settings = get_atlas_settings_by_texture_name("leather_bg_01")
	local boon_reward_bg_texture_size = boon_reward_bg_texture_settings.size
	local token_reward_bg_texture_settings = get_atlas_settings_by_texture_name("leather_bg_02")
	local token_reward_bg_texture_size = token_reward_bg_texture_settings.size
	local complete_texture_settings = get_atlas_settings_by_texture_name("quest_completed")
	local complete_texture_size = {
		complete_texture_settings.size[1]*1.25,
		complete_texture_settings.size[2]*1.25
	}
	local title_font_size = 32
	local description_font_size = 18
	local large_title_font_size = 28
	local medium_title_font_size = 24
	local small_title_font_size = 20
	local small_text_font_size = 16
	local title_text_size = {
		canvas_size[1] - title_font_size*2,
		title_font_size*2
	}
	local description_text_size = {
		canvas_size[1] - title_font_size*2,
		description_font_size*5
	}
	local reward_title_text_size = {
		canvas_size[1],
		large_title_font_size
	}
	local item_name_text_size = {
		canvas_size[1],
		medium_title_font_size
	}
	local item_type_text_size = {
		canvas_size[1],
		small_text_font_size
	}
	local item_trait_text_size = {
		canvas_size[1],
		item_trait_texture_size[2]
	}
	local requirements_title_text_size = {
		canvas_size[1],
		large_title_font_size
	}
	local token_amount_text_size = {
		reward_token_texture_size[1],
		title_font_size
	}
	local boon_name_text_size = {
		canvas_size[1],
		title_font_size
	}

	return {
		element = {
			passes = {
				{
					style_id = "button_hotspot",
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					texture_id = "background_texture",
					style_id = "texture_id",
					pass_type = "texture"
				},
				{
					texture_id = "complete_texture",
					style_id = "complete_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.requirements_met
					end
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "description_text",
					pass_type = "text",
					text_id = "description_text"
				},
				{
					style_id = "reward_title_text",
					pass_type = "text",
					text_id = "reward_title_text",
					content_check_function = function (content)
						return content.has_item_reward or content.has_token_reward or content.has_boon_reward
					end
				},
				{
					texture_id = "item_bg_texture",
					style_id = "item_bg_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.has_item_reward
					end
				},
				{
					texture_id = "texture_item_reward_hero_icon",
					style_id = "texture_item_reward_hero_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return content.has_item_reward
					end
				},
				{
					texture_id = "texture_item_reward_icon",
					style_id = "texture_item_reward_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return content.has_item_reward
					end
				},
				{
					texture_id = "texture_item_reward_frame",
					style_id = "texture_item_reward_frame",
					pass_type = "texture",
					content_check_function = function (content)
						return content.has_item_reward
					end
				},
				{
					style_id = "item_name",
					pass_type = "text",
					text_id = "item_name",
					content_check_function = function (content)
						return content.has_item_reward
					end
				},
				{
					style_id = "item_type_text",
					pass_type = "text",
					text_id = "item_type_text",
					content_check_function = function (content)
						return content.has_item_reward
					end
				},
				{
					texture_id = "texture_item_trait_icons",
					style_id = "texture_item_trait_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_item_trait_icons = content.texture_item_trait_icons

						return texture_item_trait_icons and 0 < #texture_item_trait_icons
					end
				},
				{
					texts_id = "item_trait_texts",
					style_id = "item_trait_texts",
					pass_type = "multiple_texts",
					content_check_function = function (content)
						local item_trait_texts = content.item_trait_texts
						local texts = item_trait_texts and item_trait_texts.texts

						return texts and 0 < #texts
					end
				},
				{
					texture_id = "token_bg_texture",
					style_id = "token_bg_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.has_token_reward
					end
				},
				{
					texture_id = "texture_token_reward_icon",
					style_id = "texture_token_reward_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return content.has_token_reward
					end
				},
				{
					style_id = "token_amount_text",
					pass_type = "text",
					text_id = "token_amount_text",
					content_check_function = function (content)
						return content.has_token_reward
					end
				},
				{
					texture_id = "boon_bg_texture",
					style_id = "boon_bg_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.has_boon_reward
					end
				},
				{
					texture_id = "texture_boon_reward_icon",
					style_id = "texture_boon_reward_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return content.has_boon_reward
					end
				},
				{
					style_id = "boon_name_text",
					pass_type = "text",
					text_id = "boon_name_text",
					content_check_function = function (content)
						return content.has_boon_reward
					end
				},
				{
					style_id = "boon_duration_text",
					pass_type = "text",
					text_id = "boon_duration_text",
					content_check_function = function (content)
						return content.has_boon_reward
					end
				},
				{
					texture_id = "texture_reward_divider",
					style_id = "texture_reward_divider",
					pass_type = "texture"
				},
				{
					style_id = "requirements_title_text",
					pass_type = "text",
					text_id = "requirements_title_text",
					content_check_function = function (content)
						return not content.requirements_met
					end
				},
				{
					texture_id = "texture_quest_link_marker_bg_icons_row_1",
					style_id = "texture_quest_link_marker_bg_icons_row_1",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_quest_link_marker_bg_icons_row_1 = content.texture_quest_link_marker_bg_icons_row_1

						return texture_quest_link_marker_bg_icons_row_1 and 0 < #texture_quest_link_marker_bg_icons_row_1 and not content.requirements_met
					end
				},
				{
					texture_id = "texture_quest_link_marker_bg_icons_row_2",
					style_id = "texture_quest_link_marker_bg_icons_row_2",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_quest_link_marker_bg_icons_row_2 = content.texture_quest_link_marker_bg_icons_row_2

						return texture_quest_link_marker_bg_icons_row_2 and 0 < #texture_quest_link_marker_bg_icons_row_2 and not content.requirements_met
					end
				},
				{
					texture_id = "texture_quest_link_marker_fg_icons_row_1",
					style_id = "texture_quest_link_marker_fg_icons_row_1",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_quest_link_marker_fg_icons_row_1 = content.texture_quest_link_marker_fg_icons_row_1

						return texture_quest_link_marker_fg_icons_row_1 and 0 < #texture_quest_link_marker_fg_icons_row_1 and not content.requirements_met
					end
				},
				{
					texture_id = "texture_quest_link_marker_fg_icons_row_2",
					style_id = "texture_quest_link_marker_fg_icons_row_2",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_quest_link_marker_fg_icons_row_2 = content.texture_quest_link_marker_fg_icons_row_2

						return texture_quest_link_marker_fg_icons_row_2 and 0 < #texture_quest_link_marker_fg_icons_row_2 and not content.requirements_met
					end
				}
			}
		},
		content = {
			texture_item_reward_frame = "frame_01",
			token_amount_text = "n/a",
			item_bg_texture = "leather_bg",
			title_text = "n/a",
			boon_duration_text = "n/a",
			texture_item_reward_icon = "icon_dw_shield_04_axe_05",
			reward_title_text = "dlc1_3_1_rewards",
			boon_bg_texture = "leather_bg_01",
			texture_boon_reward_icon = "token_icon_01_large",
			token_bg_texture = "leather_bg_02",
			requirements_title_text = "dlc1_3_1_required_contract_seals",
			description_text = "n/a",
			texture_item_reward_hero_icon = "hero_icon_medium_bright_wizard_yellow",
			boon_name_text = "n/a",
			item_type_text = "n/a",
			complete_texture = "quest_completed",
			item_name = "n/a",
			texture_token_reward_icon = "token_icon_01_large",
			background_texture = "quest_screen_bg_contract_01",
			button_hotspot = {},
			texture_description_divider = divider_texture_name,
			texture_item_trait_icons = {},
			item_trait_texts = {
				texts = {}
			},
			texture_reward_divider = divider_texture_name,
			texture_quest_link_marker_bg_icons_row_1 = {},
			texture_quest_link_marker_bg_icons_row_2 = {},
			texture_quest_link_marker_fg_icons_row_1 = {},
			texture_quest_link_marker_fg_icons_row_2 = {}
		},
		style = {
			background_size = size,
			background_offset = pass_offset,
			canvas_size = canvas_size,
			canvas_offset = canvas_offset,
			quest_link_texture_size = quest_link_bg_texture_size,
			quest_link_spacing = quest_link_spacing,
			reward_token_texture_size = reward_token_texture_size,
			reward_icon_spacing = reward_icon_spacing,
			button_hotspot = {
				size = size,
				offset = {
					0,
					0,
					1
				}
			},
			texture_id = {
				size = size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = pass_offset
			},
			complete_texture = {
				size = complete_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - complete_texture_size[1])*0.5),
					math.floor(canvas_offset[2] + (canvas_size[2]*0.3 - complete_texture_size[2])*0.5),
					canvas_offset[3] + 1
				}
			},
			title_text = {
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "bottom",
				font_type = "hell_shark",
				size = title_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - title_text_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.3),
					canvas_offset[3] + 2
				},
				font_size = title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			description_text = {
				localize = false,
				word_wrap = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = description_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - description_text_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height - description_text_size[2]),
					canvas_offset[3] + 2
				},
				font_size = description_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			reward_title_text = {
				localize = true,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = reward_title_text_size,
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*3.2 - description_text_size[2]),
					canvas_offset[3] + 2
				},
				font_size = large_title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			item_bg_texture = {
				size = item_reward_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - item_reward_bg_texture_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*2 - description_text_size[2] - item_reward_bg_texture_size[2] - 15),
					canvas_offset[3] + 1
				}
			},
			texture_item_reward_hero_icon = {
				size = hero_icon_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]*0.5) - hero_icon_texture_size[1]*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.7 - row_divider_height*3.2 - description_text_size[2]),
					canvas_offset[3] + 3
				}
			},
			texture_item_reward_icon = {
				size = reward_item_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + 40),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.4 - row_divider_height*2 - description_text_size[2] - reward_item_texture_size[2]*1.5),
					canvas_offset[3] + 3
				}
			},
			texture_item_reward_frame = {
				size = reward_item_frame_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + 40),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.4 - row_divider_height*2 - description_text_size[2] - reward_item_frame_texture_size[2]*1.5),
					canvas_offset[3] + 3
				}
			},
			item_name = {
				localize = true,
				word_wrap = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = item_name_text_size,
				offset = {
					math.floor(canvas_offset[1] + 40 + reward_item_frame_texture_size[1] + 10),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.4 - row_divider_height*2 - description_text_size[2] - reward_item_frame_texture_size[2]),
					canvas_offset[3] + 2
				},
				font_size = medium_title_font_size,
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			item_type_text = {
				localize = true,
				word_wrap = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = item_type_text_size,
				offset = {
					math.floor(canvas_offset[1] + 40 + reward_item_frame_texture_size[1] + 10),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.4 - row_divider_height*2 - description_text_size[2] - reward_item_frame_texture_size[2] - item_name_text_size[2]),
					canvas_offset[3] + 2
				},
				font_size = small_text_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			texture_item_trait_icons = {
				direction = 2,
				axis = 2,
				spacing = {
					0,
					trait_icon_spacing
				},
				texture_size = item_trait_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + 40 + reward_item_texture_size[1]*0.5) - item_trait_texture_size[1]*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.3 - row_divider_height*2 - description_text_size[2] - reward_item_texture_size[2]*2),
					canvas_offset[3] + 3
				}
			},
			item_trait_texts = {
				word_wrap = false,
				localize = true,
				axis = 2,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				direction = 1,
				font_type = "hell_shark",
				spacing = trait_icon_spacing,
				size = item_trait_text_size,
				offset = {
					math.floor(canvas_offset[1] + 40 + reward_item_texture_size[1]*0.5 + item_trait_texture_size[1]*0.5 + 10),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.3 - row_divider_height*2 - description_text_size[2] - reward_item_texture_size[2]*2 - item_trait_texture_size[2] + 5),
					canvas_offset[3] + 3
				},
				font_size = small_title_font_size,
				text_color = Colors.get_color_table_with_alpha("white", 255)
			},
			token_bg_texture = {
				size = token_reward_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - token_reward_bg_texture_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*2 - description_text_size[2] - token_reward_bg_texture_size[2] - 15),
					canvas_offset[3] + 1
				}
			},
			texture_token_reward_icon = {
				size = reward_token_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + (canvas_size[1] - reward_token_texture_size[1])*0.5) - reward_token_texture_size[1]*0.45),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*2 - description_text_size[2] - token_reward_bg_texture_size[2] - 15 + (token_reward_bg_texture_size[2] - reward_token_texture_size[2])*0.25),
					canvas_offset[3] + 3
				}
			},
			token_amount_text = {
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = token_amount_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - reward_token_texture_size[1])*0.5 + reward_token_texture_size[1]*0.45),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*2 - description_text_size[2] - token_reward_bg_texture_size[2] - 15 + (token_reward_bg_texture_size[2] - reward_token_texture_size[2])*0.25 + reward_token_texture_size[2]*0.25),
					canvas_offset[3] + 2
				},
				font_size = title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			boon_bg_texture = {
				size = boon_reward_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - boon_reward_bg_texture_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*2 - description_text_size[2] - boon_reward_bg_texture_size[2] - 15),
					canvas_offset[3] + 1
				}
			},
			texture_boon_reward_icon = {
				size = reward_token_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + (canvas_size[1] - reward_token_texture_size[1])*0.5) - reward_token_texture_size[1]*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*2 - description_text_size[2] - token_reward_bg_texture_size[2] - 15 + (token_reward_bg_texture_size[2] - reward_token_texture_size[2])*0.25),
					canvas_offset[3] + 3
				}
			},
			boon_name_text = {
				localize = true,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = boon_name_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - boon_name_text_size[1])*0.5),
					math.floor(((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*2 - description_text_size[2] - token_reward_bg_texture_size[2] - 15 + (token_reward_bg_texture_size[2] - reward_token_texture_size[2])*0.25) - reward_token_texture_size[2]*0.7),
					canvas_offset[3] + 2
				},
				font_size = title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			boon_duration_text = {
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = token_amount_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - reward_token_texture_size[1])*0.5 + reward_token_texture_size[1]*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*2 - description_text_size[2] - token_reward_bg_texture_size[2] - 15 + (token_reward_bg_texture_size[2] - reward_token_texture_size[2])*0.25 + reward_token_texture_size[2]*0.25),
					canvas_offset[3] + 2
				},
				font_size = title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			texture_reward_divider = {
				size = divider_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]*0.5) - divider_texture_size[1]*0.5),
					math.floor(canvas_offset[2] + block_height*1.5 + divider_texture_size[2]*1.2),
					canvas_offset[3] + 2
				}
			},
			requirements_title_text = {
				localize = true,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = requirements_title_text_size,
				offset = {
					canvas_offset[1],
					math.floor(canvas_offset[2] + block_height*1.5 + large_title_font_size*0.25),
					canvas_offset[3] + 1
				},
				font_size = large_title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_quest_link_marker_bg_icons_row_1 = {
				direction = 1,
				axis = 1,
				spacing = {
					quest_link_spacing,
					0
				},
				texture_sizes = {
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size
				},
				texture_colors = {
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					}
				},
				texture_saturation = {
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false
				},
				offset = {
					0,
					math.floor((canvas_offset[2] + block_height*1.5) - quest_link_bg_texture_size[2]*1.5 + 10),
					canvas_offset[3] + 5
				}
			},
			texture_quest_link_marker_bg_icons_row_2 = {
				direction = 1,
				axis = 1,
				spacing = {
					quest_link_spacing,
					0
				},
				texture_sizes = {
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size,
					quest_link_bg_texture_size
				},
				texture_colors = {
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					}
				},
				texture_saturation = {
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false
				},
				offset = {
					0,
					math.floor((canvas_offset[2] + block_height*1.5) - quest_link_bg_texture_size[2]*1.5 - 115),
					canvas_offset[3] + 3
				}
			},
			texture_quest_link_marker_fg_icons_row_1 = {
				direction = 1,
				axis = 1,
				spacing = {
					quest_link_spacing,
					0
				},
				texture_sizes = {
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size
				},
				texture_colors = {
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					}
				},
				texture_saturation = {
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false
				},
				offset = {
					0,
					math.floor((canvas_offset[2] + block_height*1.5) - quest_link_fg_texture_size[2]*1.5 + 25),
					canvas_offset[3] + 6
				}
			},
			texture_quest_link_marker_fg_icons_row_2 = {
				direction = 1,
				axis = 1,
				spacing = {
					quest_link_spacing,
					0
				},
				texture_sizes = {
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size,
					quest_link_fg_texture_size
				},
				texture_colors = {
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					},
					{
						255,
						255,
						255,
						255
					}
				},
				texture_saturation = {
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false,
					false
				},
				offset = {
					0,
					math.floor((canvas_offset[2] + block_height*1.5) - quest_link_fg_texture_size[2]*1.5 - 100),
					canvas_offset[3] + 4
				}
			}
		},
		offset = {
			0,
			0,
			3
		},
		scenegraph_id = parent_scenegraph_id
	}
end

local function create_log_quest()
	local parent_scenegraph_id = "log_quest"
	local quest_link_spacing = 2
	local background_texture = "quest_screen_bg_log_quest"
	local background_texture_settings = get_atlas_settings_by_texture_name(background_texture)
	local background_texture_size = {
		background_texture_settings.size[1],
		background_texture_settings.size[2]
	}
	local highlight_texture = "quest_glow"
	local highlight_texture_size = {
		background_texture_size[1]*0.9,
		37
	}
	local highlight_texture_offset_top = {
		background_texture_size[1]*0.05,
		12,
		2
	}
	local highlight_texture_offset_bottom = {
		background_texture_size[1]*0.05,
		background_texture_size[2] - highlight_texture_size[2] - 14,
		2
	}
	local flashing_texture = "quest_glow"
	local flashing_texture_size = {
		background_texture_size[1]*0.9,
		37
	}
	local flashing_texture_offset_top = {
		background_texture_size[1]*0.05,
		12,
		2
	}
	local flashing_texture_offset_bottom = {
		background_texture_size[1]*0.05,
		background_texture_size[2] - flashing_texture_size[2] - 14,
		2
	}
	local token_reward_texture_size_settings = get_atlas_settings_by_texture_name("icon_dw_shield_04_axe_05")
	local reward_icon_size = {
		token_reward_texture_size_settings.size[1]*0.75,
		token_reward_texture_size_settings.size[2]*0.75
	}
	local token_reward_bg_texture_settings = get_atlas_settings_by_texture_name("leather_bg_04")
	local reward_bg_size = {
		token_reward_bg_texture_settings.size[1],
		token_reward_bg_texture_settings.size[2]
	}
	local quest_link_bg_texture = get_atlas_settings_by_texture_name("quest_link_marker_bg_01")
	local quest_link_bg_texture_size = {
		quest_link_bg_texture.size[1],
		quest_link_bg_texture.size[2]
	}
	local quest_link_fg_texture = get_atlas_settings_by_texture_name("quest_link_marker_fg_main_01")
	local quest_link_fg_texture_size = {
		quest_link_fg_texture.size[1],
		quest_link_fg_texture.size[2]
	}

	return {
		element = {
			passes = {
				{
					style_id = "button_hotspot",
					pass_type = "hotspot",
					content_id = "button_hotspot",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					texture_id = "background_texture",
					style_id = "texture_id",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_hover_id_top",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled and (content.highlighted or (button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)))
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_selected_id_top",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_flashing_id_top",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_hover_id_bottom",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled and (content.highlighted or (button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)))
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_selected_id_bottom",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_flashing_id_bottom",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled
					end
				},
				{
					texture_id = "background_complete_texture",
					style_id = "background_complete_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active and content.complete
					end
				},
				{
					texture_id = "reward_bg",
					style_id = "reward_bg",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					texture_id = "reward_icon",
					style_id = "reward_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					texture_id = "item_reward_frame",
					style_id = "item_reward_frame",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active and content.has_item_reward
					end
				},
				{
					style_id = "quest_link_text",
					pass_type = "text",
					text_id = "quest_link_text",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					texture_id = "texture_quest_link_marker_bg",
					style_id = "texture_quest_link_marker_bg",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active and not content.complete
					end
				},
				{
					texture_id = "texture_quest_link_marker_fg",
					style_id = "texture_quest_link_marker_fg",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active and not content.complete
					end
				}
			}
		},
		content = {
			title_text = "n/a",
			item_reward_frame = "frame_01",
			texture_quest_link_marker_bg = "quest_link_marker_no_text_bg_01",
			reward_icon = "icon_dw_shield_01_axe_01",
			quest_link_text = "n/a",
			texture_quest_link_marker_fg = "quest_link_marker_fg_main_01",
			background_complete_texture = "quest_screen_log_contract_01_completed",
			reward_bg = "leather_bg_04",
			button_hotspot = {},
			highlight_texture = highlight_texture,
			background_texture = background_texture
		},
		style = {
			quest_link_spacing = quest_link_spacing,
			canvas_size = background_texture_size,
			quest_link_texture_size = quest_link_bg_texture_size,
			reward_bg_size = reward_bg_size,
			title_text = {
				font_size = 20,
				localize = false,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = {
					background_texture_size[1] - 40,
					20,
					2
				},
				offset = {
					20,
					background_texture_size[2] - 60,
					2
				},
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			reward_bg = {
				size = reward_bg_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					25,
					background_texture_size[2] - reward_bg_size[2],
					5
				}
			},
			reward_icon = {
				size = reward_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					42,
					90,
					6
				}
			},
			item_reward_frame = {
				size = reward_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					42,
					90,
					7
				}
			},
			texture_quest_link_marker_bg = {
				size = quest_link_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					(background_texture_size[1] - quest_link_bg_texture_size[1])*0.5,
					background_texture_size[2]*0.5 - quest_link_bg_texture_size[2] + 20,
					2
				}
			},
			texture_quest_link_marker_fg = {
				size = quest_link_fg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					(background_texture_size[1] - quest_link_fg_texture_size[1])*0.5,
					background_texture_size[2]*0.5 - quest_link_fg_texture_size[2] + 70,
					3
				}
			},
			quest_link_text = {
				font_size = 20,
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = {
					quest_link_bg_texture_size[1],
					20
				},
				offset = {
					(background_texture_size[1] - quest_link_bg_texture_size[1])*0.5,
					background_texture_size[2]*0.5 - quest_link_fg_texture_size[2] + 27,
					3
				},
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_id = {
				size = background_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					1
				}
			},
			background_complete_texture = {
				size = background_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					4
				}
			},
			texture_hover_id_top = {
				angle = 0,
				size = highlight_texture_size,
				color = {
					190,
					255,
					255,
					255
				},
				offset = highlight_texture_offset_top,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_selected_id_top = {
				angle = 0,
				size = highlight_texture_size,
				color = {
					255,
					255,
					190,
					190
				},
				offset = highlight_texture_offset_top,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_flashing_id_top = {
				angle = 0,
				size = highlight_texture_size,
				color = {
					0,
					255,
					100,
					100
				},
				offset = highlight_texture_offset_top,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_hover_id_bottom = {
				size = highlight_texture_size,
				color = {
					190,
					255,
					255,
					255
				},
				offset = highlight_texture_offset_bottom,
				angle = math.pi,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_selected_id_bottom = {
				size = highlight_texture_size,
				color = {
					255,
					255,
					190,
					190
				},
				offset = highlight_texture_offset_bottom,
				angle = math.pi,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_flashing_id_bottom = {
				size = highlight_texture_size,
				color = {
					0,
					255,
					100,
					100
				},
				offset = highlight_texture_offset_bottom,
				angle = math.pi,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			button_hotspot = {
				size = background_texture_size,
				offset = {
					0,
					0,
					1
				}
			}
		},
		offset = {
			0,
			0,
			0
		},
		scenegraph_id = parent_scenegraph_id
	}
end

local function create_board_quest(parent_scenegraph_id)
	local background_texture_size = {
		369,
		191
	}
	local highlight_texture = "quest_glow"
	local highlight_texture_size = {
		background_texture_size[1]*0.9,
		37
	}
	local highlight_texture_offset_top = {
		background_texture_size[1]*0.05,
		14,
		2
	}
	local highlight_texture_offset_bottom = {
		background_texture_size[1]*0.05,
		background_texture_size[2] - highlight_texture_size[2] - 14,
		2
	}
	local flashing_texture = "quest_glow"
	local flashing_texture_size = {
		background_texture_size[1]*0.9,
		37
	}
	local flashing_texture_offset_top = {
		background_texture_size[1]*0.05,
		14,
		2
	}
	local flashing_texture_offset_bottom = {
		background_texture_size[1]*0.05,
		background_texture_size[2] - flashing_texture_size[2] - 14,
		2
	}
	local token_reward_texture_size_settings = get_atlas_settings_by_texture_name("icon_dw_shield_04_axe_05")
	local reward_icon_size = {
		token_reward_texture_size_settings.size[1]*0.75,
		token_reward_texture_size_settings.size[2]*0.75
	}
	local token_reward_bg_texture_settings = get_atlas_settings_by_texture_name("leather_bg_04")
	local reward_bg_size = {
		token_reward_bg_texture_settings.size[1],
		token_reward_bg_texture_settings.size[2]
	}
	local quest_link_bg_texture = get_atlas_settings_by_texture_name("quest_link_marker_no_text_bg_01")
	local quest_link_bg_texture_size = {
		quest_link_bg_texture.size[1]*0.8,
		quest_link_bg_texture.size[2]*0.8
	}
	local quest_link_fg_texture = get_atlas_settings_by_texture_name("quest_link_marker_fg_main_01")
	local quest_link_fg_texture_size = {
		quest_link_fg_texture.size[1]*0.8,
		quest_link_fg_texture.size[2]*0.8
	}

	return {
		element = {
			passes = {
				{
					style_id = "button_hotspot",
					pass_type = "hotspot",
					content_id = "button_hotspot",
					content_check_function = function (content)
						return not content.active
					end
				},
				{
					texture_id = "background_texture",
					style_id = "texture_id",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_hover_id_top",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not button_hotspot.disabled and (content.highlighted or (button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)))
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_selected_id_top",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_flashing_id_top",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not button_hotspot.disabled
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_hover_id_bottom",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not button_hotspot.disabled and (content.highlighted or (button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)))
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_selected_id_bottom",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_flashing_id_bottom",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not button_hotspot.disabled
					end
				},
				{
					texture_id = "quest_link_marker_bg_texture",
					style_id = "quest_link_marker_bg_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active
					end
				},
				{
					texture_id = "quest_link_marker_fg_texture",
					style_id = "quest_link_marker_fg_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active
					end
				},
				{
					style_id = "quest_link_text",
					pass_type = "text",
					text_id = "quest_link_text",
					content_check_function = function (content)
						return not content.active
					end
				},
				{
					texture_id = "reward_bg",
					style_id = "reward_bg",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active
					end
				},
				{
					texture_id = "reward_icon",
					style_id = "reward_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active
					end
				},
				{
					texture_id = "item_reward_frame",
					style_id = "item_reward_frame",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and content.has_item_reward
					end
				}
			}
		},
		content = {
			quest_link_marker_fg_texture = "quest_link_marker_fg_main_01",
			item_reward_frame = "frame_01",
			reward_icon = "icon_dw_shield_01_axe_01",
			quest_link_text = "n/a",
			quest_link_marker_bg_texture = "quest_link_marker_no_text_bg_01",
			reward_bg = "leather_bg_04",
			background_texture = "quest_screen_bg_board_quest_01",
			button_hotspot = {},
			highlight_texture = highlight_texture
		},
		style = {
			quest_link_marker_bg_texture = {
				size = quest_link_bg_texture_size,
				offset = {
					background_texture_size[1]*0.5 - quest_link_bg_texture_size[1]*0.5,
					background_texture_size[2]*0.5 - quest_link_bg_texture_size[2] - 15,
					23
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			quest_link_marker_fg_texture = {
				size = quest_link_fg_texture_size,
				offset = {
					background_texture_size[1]*0.5 - quest_link_fg_texture_size[1]*0.5,
					background_texture_size[2]*0.5 - quest_link_fg_texture_size[2] + 30,
					24
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			quest_link_text = {
				vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = 22,
				horizontal_alignment = "center",
				word_wrap = true,
				size = {
					quest_link_bg_texture_size[1],
					22
				},
				offset = {
					background_texture_size[1]*0.5 - quest_link_bg_texture_size[1]*0.5,
					background_texture_size[2]*0.5 - 60 - 15,
					24
				},
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			reward_bg = {
				size = reward_bg_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					25,
					background_texture_size[2] - reward_bg_size[2],
					2
				}
			},
			reward_icon = {
				size = reward_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					42,
					90,
					3
				}
			},
			item_reward_frame = {
				size = reward_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					42,
					90,
					4
				}
			},
			texture_id = {
				size = background_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					1
				}
			},
			texture_hover_id_top = {
				angle = 0,
				size = highlight_texture_size,
				color = {
					190,
					255,
					255,
					255
				},
				offset = highlight_texture_offset_top,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_selected_id_top = {
				angle = 0,
				size = highlight_texture_size,
				color = {
					255,
					255,
					190,
					190
				},
				offset = highlight_texture_offset_top,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_flashing_id_top = {
				angle = 0,
				size = highlight_texture_size,
				color = {
					0,
					255,
					100,
					100
				},
				offset = highlight_texture_offset_top,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_hover_id_bottom = {
				size = highlight_texture_size,
				color = {
					190,
					255,
					255,
					255
				},
				offset = highlight_texture_offset_bottom,
				angle = math.pi,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_selected_id_bottom = {
				size = highlight_texture_size,
				color = {
					255,
					255,
					190,
					190
				},
				offset = highlight_texture_offset_bottom,
				angle = math.pi,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_flashing_id_bottom = {
				size = highlight_texture_size,
				color = {
					0,
					255,
					100,
					100
				},
				offset = highlight_texture_offset_bottom,
				angle = math.pi,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			button_hotspot = {
				size = background_texture_size,
				offset = {
					0,
					0,
					1
				}
			}
		},
		offset = {
			0,
			0,
			0
		},
		scenegraph_id = parent_scenegraph_id
	}
end

local function create_log_contract(size, parent_scenegraph_id)
	local level_icon_spacing = 5
	local level_icon_size = {
		83,
		70
	}
	local divider_size = {
		200,
		2
	}
	local task_icon_spacing = 25
	local task_icon_size = {
		45,
		45
	}
	local reward_icon_spacing = 5
	local reward_icon_size = {
		25,
		25
	}
	local highlight_texture = "quest_glow"
	local highlight_texture_size = {
		size[2]*0.75,
		37
	}
	local highlight_texture_offset_left = {
		-highlight_texture_size[1]*0.5,
		size[2]*0.45,
		0
	}
	local highlight_texture_offset_right = {
		size[1] - highlight_texture_size[1]*0.5,
		size[2]*0.45,
		0
	}
	local flash_texture = "quest_glow"
	local flash_texture_size = {
		size[2]*0.75,
		37
	}
	local flash_texture_offset_left = {
		-flash_texture_size[1]*0.5,
		size[2]*0.45,
		0
	}
	local flash_texture_offset_right = {
		size[1] - flash_texture_size[1]*0.5,
		size[2]*0.45,
		0
	}

	return {
		element = {
			passes = {
				{
					style_id = "button_hotspot",
					pass_type = "hotspot",
					content_id = "button_hotspot",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					texture_id = "background_complete_texture",
					style_id = "background_complete_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active and content.requirements_met
					end
				},
				{
					texture_id = "background_texture",
					style_id = "texture_id",
					pass_type = "texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_hover_id_left",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return (content.active and not button_hotspot.disabled and content.highlighted) or (button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0))
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_selected_id_left",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_flashing_id_left",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_hover_id_right",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return (content.active and not button_hotspot.disabled and content.highlighted) or (button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0))
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_selected_id_right",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_flashing_id_right",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return content.active and not button_hotspot.disabled
					end
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					texture_id = "quest_link_marker_bg_texture",
					style_id = "quest_link_marker_bg_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active and content.has_quest_link
					end
				},
				{
					texture_id = "quest_link_marker_fg_texture",
					style_id = "quest_link_marker_fg_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active and content.has_quest_link
					end
				},
				{
					style_id = "quest_link_text",
					pass_type = "text",
					text_id = "quest_link_text",
					content_check_function = function (content)
						return content.active and content.has_quest_link
					end
				},
				{
					texture_id = "texture_title_divider",
					style_id = "texture_title_divider",
					pass_type = "texture",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					style_id = "difficulty_text",
					pass_type = "text",
					text_id = "difficulty_text",
					content_check_function = function (content)
						return content.active
					end
				},
				{
					texture_id = "texture_level_icons",
					style_id = "texture_level_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_level_icons = content.texture_level_icons

						return content.active and texture_level_icons and 0 < #texture_level_icons
					end
				},
				{
					texture_id = "texture_level_checkmark_icons",
					style_id = "texture_level_checkmark_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_level_icons = content.texture_level_icons

						return content.active and texture_level_icons and 0 < #texture_level_icons
					end
				},
				{
					texture_id = "texture_level_divider",
					style_id = "texture_level_divider",
					pass_type = "texture",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return content.active and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texture_id = "texture_task_icons",
					style_id = "texture_task_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return content.active and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texture_id = "texture_task_checkmark_icons",
					style_id = "texture_task_checkmark_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return content.active and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texts_id = "task_amount_texts",
					style_id = "task_amount_texts",
					pass_type = "multiple_texts",
					content_check_function = function (content)
						local task_amount_texts = content.task_amount_texts
						local texts = task_amount_texts and task_amount_texts.texts

						return content.active and texts and 0 < #texts
					end
				}
			}
		},
		content = {
			title_text = "n/a",
			quest_link_text = "n/a",
			quest_link_marker_fg_texture = "quest_link_marker_fg_main_01",
			background_complete_texture = "quest_screen_log_contract_01_completed",
			quest_link_marker_bg_texture = "quest_link_marker_no_text_bg_01",
			difficulty_text = "n/a",
			complete = false,
			has_quest_link = false,
			texture_level_divider = "quest_screen_divider_3",
			texture_title_divider = "quest_screen_divider_3",
			background_texture = "quest_screen_log_contract_01",
			button_hotspot = {},
			highlight_texture = highlight_texture,
			texture_level_icons = {},
			texture_level_checkmark_icons = {
				"checkmark_large",
				"checkmark_large",
				"checkmark_large"
			},
			completed_levels = {
				false,
				false,
				false
			},
			texture_task_icons = {},
			texture_task_checkmark_icons = {
				"checkmark_large",
				"checkmark_large",
				"checkmark_large"
			},
			completed_tasks = {
				false,
				false,
				false
			},
			task_amount_texts = {
				texts = {}
			}
		},
		style = {
			size = size,
			level_icon_spacing = level_icon_spacing,
			level_icon_size = level_icon_size,
			divider_size = divider_size,
			task_icon_spacing = task_icon_spacing,
			task_icon_size = task_icon_size,
			title_text = {
				font_size = 24,
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = {
					size[1] - 40,
					24
				},
				offset = {
					20,
					size[2] - 35,
					2
				},
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_title_divider = {
				size = divider_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					(size[1] - divider_size[1])*0.5,
					size[2] - 45,
					2
				}
			},
			quest_link_marker_bg_texture = {
				size = {
					60,
					95
				},
				offset = {
					size[1] - 70,
					size[2] - 170,
					5
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			quest_link_marker_fg_texture = {
				size = {
					60,
					60
				},
				offset = {
					size[1] - 70,
					size[2] - 95,
					5
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			quest_link_text = {
				vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = 24,
				horizontal_alignment = "center",
				word_wrap = true,
				size = {
					40,
					40
				},
				offset = {
					size[1] - 56,
					size[2] - 140,
					6
				},
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			difficulty_text = {
				font_size = 20,
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = {
					size[1],
					20
				},
				offset = {
					0,
					size[2] - 70,
					2
				},
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_level_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					level_icon_spacing,
					0
				},
				texture_size = level_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					size[2] - 64 - 10 - level_icon_size[2],
					2
				}
			},
			texture_level_checkmark_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					level_icon_spacing,
					0
				},
				texture_size = level_icon_size,
				texture_colors = {
					{
						255,
						0,
						255,
						0
					},
					{
						255,
						0,
						255,
						0
					},
					{
						255,
						0,
						255,
						0
					}
				},
				color = {
					255,
					0,
					255,
					0
				},
				offset = {
					0,
					size[2] - 64 - 10 - level_icon_size[2],
					2
				}
			},
			texture_level_divider = {
				size = divider_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					(size[1] - divider_size[1])*0.5,
					size[2] - 64 - 15 - level_icon_size[2],
					2
				}
			},
			texture_requirements_tasks_vertical_divider = {
				size = {
					2,
					40
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					size[1]*0.5,
					20,
					2
				}
			},
			texture_task_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					task_icon_spacing,
					0
				},
				texture_size = task_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					task_icon_size[2]*0.5 - 45,
					2
				}
			},
			texture_task_checkmark_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					task_icon_spacing,
					0
				},
				texture_size = task_icon_size,
				texture_colors = {
					{
						255,
						0,
						255,
						0
					},
					{
						255,
						0,
						255,
						0
					},
					{
						255,
						0,
						255,
						0
					}
				},
				color = {
					255,
					0,
					255,
					0
				},
				offset = {
					0,
					task_icon_size[2]*0.5 - 45,
					3
				}
			},
			task_amount_texts = {
				spacing = 0,
				word_wrap = false,
				localize = false,
				axis = 1,
				font_size = 20,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				direction = 1,
				font_type = "hell_shark",
				size = {
					task_icon_size[1] + task_icon_spacing,
					20
				},
				offset = {
					0,
					task_icon_size[2]*0.5 - 60,
					3
				},
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_id = {
				size = size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					1
				}
			},
			button_hotspot = {
				size = size,
				offset = {
					0,
					0,
					1
				}
			},
			background_complete_texture = {
				size = size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					5
				}
			},
			texture_hover_id_left = {
				size = highlight_texture_size,
				color = {
					190,
					255,
					255,
					255
				},
				offset = highlight_texture_offset_left,
				angle = -math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_selected_id_left = {
				size = highlight_texture_size,
				color = {
					255,
					255,
					190,
					190
				},
				offset = highlight_texture_offset_left,
				angle = -math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_flashing_id_left = {
				size = highlight_texture_size,
				color = {
					0,
					255,
					100,
					100
				},
				offset = highlight_texture_offset_left,
				angle = -math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_hover_id_right = {
				size = highlight_texture_size,
				color = {
					190,
					255,
					255,
					255
				},
				offset = highlight_texture_offset_right,
				angle = math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_selected_id_right = {
				size = highlight_texture_size,
				color = {
					255,
					255,
					190,
					190
				},
				offset = highlight_texture_offset_right,
				angle = math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_flashing_id_right = {
				size = highlight_texture_size,
				color = {
					0,
					255,
					100,
					100
				},
				offset = highlight_texture_offset_right,
				angle = math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			}
		},
		offset = {
			0,
			0,
			3
		},
		scenegraph_id = parent_scenegraph_id
	}
end

local function create_board_contract(parent_scenegraph_id)
	local size = {
		272.4,
		300
	}
	local canvas_size = {
		232,
		265
	}
	local pass_offset = {
		0,
		0,
		1
	}
	local canvas_offset = {
		0,
		0,
		1
	}
	local parent_size = scenegraph_definition[parent_scenegraph_id].size
	local width_diff = parent_size[1] - size[1]
	local height_diff = parent_size[2] - size[2]
	local width_offset = width_diff*0.5*Math.random_range(0, 1.5)
	local height_offset = height_diff*0.5*Math.random_range(0, 1.5)
	pass_offset[1] = width_offset
	pass_offset[2] = height_offset
	canvas_offset[1] = pass_offset[1] + (size[1] - canvas_size[1])*0.5
	canvas_offset[2] = pass_offset[2] + (size[2] - canvas_size[2])*0.5
	canvas_offset[3] = pass_offset[3]
	local background_texture_default_size = {
		781,
		904
	}
	local background_texture_width_fraction = size[1]/background_texture_default_size[1]
	local background_texture_height_fraction = size[2]/background_texture_default_size[2]
	local corner_size = {
		126,
		193
	}
	local corner_style_top_left = {}
	local corner_style_top_right = {}
	local corner_style_bottom_left = {}
	local corner_style_bottom_right = {}
	local corner_size_top_left = {
		background_texture_width_fraction*corner_size[1],
		background_texture_height_fraction*corner_size[2]
	}
	local corner_offset_top_left = {
		pass_offset[1],
		pass_offset[2] + size[2] - corner_size_top_left[2],
		pass_offset[3] + 1
	}
	corner_style_top_left.size = corner_size_top_left
	corner_style_top_left.offset = corner_offset_top_left
	local corner_size_top_right = {
		background_texture_width_fraction*corner_size[1],
		background_texture_height_fraction*corner_size[2]
	}
	local corner_offset_rop_right = {
		pass_offset[1] + size[1] - corner_size_top_right[1],
		pass_offset[2] + size[2] - corner_size_top_right[2],
		pass_offset[3] + 1
	}
	corner_style_top_right.size = corner_size_top_right
	corner_style_top_right.offset = corner_offset_rop_right
	local corner_size_bottom_left = {
		background_texture_width_fraction*corner_size[1],
		background_texture_height_fraction*corner_size[2]
	}
	local corner_offset_bottom_left = {
		pass_offset[1],
		pass_offset[2],
		pass_offset[3] + 1
	}
	corner_style_bottom_left.size = corner_size_bottom_left
	corner_style_bottom_left.offset = corner_offset_bottom_left
	local corner_size_bottom_right = {
		background_texture_width_fraction*corner_size[1],
		background_texture_height_fraction*corner_size[2]
	}
	local corner_offset_bottom_right = {
		pass_offset[1] + size[1] - corner_size_bottom_right[1],
		pass_offset[2],
		pass_offset[3] + 1
	}
	corner_style_bottom_right.size = corner_size_bottom_right
	corner_style_bottom_right.offset = corner_offset_bottom_right
	local block_height = canvas_size[2]/9
	local task_icon_spacing = background_texture_height_fraction*60
	local character_icon_spacing = background_texture_height_fraction*10
	local difficulty_icon_spacing = background_texture_height_fraction*35
	local loadout_icon_spacing = background_texture_height_fraction*10
	local text_icon_spacing = background_texture_height_fraction*5
	local level_icon_spacing = background_texture_height_fraction*25
	local reward_icon_spacing = background_texture_height_fraction*35
	local row_divider_height = 25
	local highlight_texture = "quest_glow"
	local highlight_texture_size = {
		canvas_size[2]*0.9,
		37
	}
	local highlight_texture_offset_left = {
		canvas_offset[1] - highlight_texture_size[1]*0.5 - highlight_texture_size[2] + 10,
		canvas_offset[2] + canvas_size[2]*0.45,
		canvas_offset[3] - 1
	}
	local highlight_texture_offset_right = {
		((canvas_offset[1] + canvas_size[1]) - highlight_texture_size[1]*0.5 + highlight_texture_size[2]) - 10,
		canvas_offset[2] + canvas_size[2]*0.45,
		canvas_offset[3] - 1
	}
	local flashing_texture = "quest_glow"
	local flashing_texture_size = {
		canvas_size[2]*0.9,
		37
	}
	local flashing_texture_offset_left = {
		canvas_offset[1] - flashing_texture_size[1]*0.5 - flashing_texture_size[2] + 10,
		canvas_offset[2] + canvas_size[2]*0.45,
		canvas_offset[3] - 1
	}
	local flashing_texture_offset_right = {
		((canvas_offset[1] + canvas_size[1]) - flashing_texture_size[1]*0.5 + flashing_texture_size[2]) - 10,
		canvas_offset[2] + canvas_size[2]*0.45,
		canvas_offset[3] - 1
	}
	local texture_level_image_settings = get_atlas_settings_by_texture_name("quest_screen_level_image_magnus")
	local texture_level_image_size = {
		background_texture_height_fraction*texture_level_image_settings.size[1],
		background_texture_height_fraction*texture_level_image_settings.size[2]
	}
	local texture_task_icon_name = "quest_icon_grimoire"
	local texture_task_icon_settings = get_atlas_settings_by_texture_name(texture_task_icon_name)
	local texture_task_icon_size = {
		texture_task_icon_settings.size[1]*0.5,
		texture_task_icon_settings.size[2]*0.5
	}
	local reward_icon_settings = get_atlas_settings_by_texture_name("quest_screen_token_icon_01")
	local reward_icon_size = {
		reward_icon_settings.size[1]*0.8,
		reward_icon_settings.size[2]*0.8
	}
	local quest_link_bg_texture = get_atlas_settings_by_texture_name("quest_link_marker_bg_01")
	local quest_link_bg_texture_size = {
		quest_link_bg_texture.size[1]*0.6,
		quest_link_bg_texture.size[2]*0.6
	}
	local quest_link_fg_texture = get_atlas_settings_by_texture_name("quest_link_marker_fg_main_01")
	local quest_link_fg_texture_size = {
		quest_link_fg_texture.size[1]*0.6,
		quest_link_fg_texture.size[2]*0.6
	}
	local contract_title_bg_texture = get_atlas_settings_by_texture_name("quest_screen_title_bg_01")
	local contract_title_bg_texture_size = {
		background_texture_height_fraction*contract_title_bg_texture.size[1],
		background_texture_height_fraction*contract_title_bg_texture.size[2]
	}
	local level_title_bg_texture = get_atlas_settings_by_texture_name("quest_screen_title_bg_01")
	local level_title_bg_texture_size = {
		background_texture_height_fraction*level_title_bg_texture.size[1],
		background_texture_height_fraction*level_title_bg_texture.size[2]
	}
	local tasks_title_bg_texture = get_atlas_settings_by_texture_name("quest_screen_title_bg_01")
	local tasks_title_bg_texture_size = {
		background_texture_height_fraction*tasks_title_bg_texture.size[1],
		background_texture_height_fraction*tasks_title_bg_texture.size[2]
	}
	local contract_reward_bg_texture = get_atlas_settings_by_texture_name("quest_screen_title_bg_01")
	local contract_reward_bg_texture_size = {
		background_texture_height_fraction*contract_reward_bg_texture.size[1],
		background_texture_height_fraction*contract_reward_bg_texture.size[2]
	}
	local divider_texture = get_atlas_settings_by_texture_name("quest_screen_divider")
	local divider_texture_size = {
		background_texture_height_fraction*divider_texture.size[1],
		background_texture_height_fraction*divider_texture.size[2]
	}
	local divider_3_texture = get_atlas_settings_by_texture_name("quest_screen_divider_3")
	local divider_3_texture_size = {
		divider_3_texture.size[1],
		divider_3_texture.size[2]
	}
	local title_font_size = math.ceil(background_texture_height_fraction*32)
	local medium_title_font_size = math.ceil(background_texture_height_fraction*24)
	local small_title_font_size = math.ceil(background_texture_height_fraction*20)
	local small_text_font_size = math.ceil(background_texture_height_fraction*22)
	local unscaled_title_font_size = 32
	local unscaled_medium_title_font_size = 24
	local unscaled_small_title_font_size = 18
	local title_text_size = {
		canvas_size[1] - title_font_size*2,
		unscaled_small_title_font_size*2
	}
	local task_text_size = {
		texture_task_icon_size[1] + task_icon_spacing,
		title_font_size
	}
	local reward_amount_text_size = reward_icon_size
	local quest_link_text_size = {
		quest_link_bg_texture_size[1],
		unscaled_medium_title_font_size
	}

	return {
		element = {
			passes = {
				{
					style_id = "button_hotspot",
					pass_type = "hotspot",
					content_id = "button_hotspot",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "background_corner_texture_top_left",
					style_id = "background_corner_texture_top_left",
					pass_type = "texture",
					content_check_function = function (content)
						return content.background_corner_texture_top_left and not content.disabled
					end
				},
				{
					texture_id = "background_corner_texture_top_right",
					style_id = "background_corner_texture_top_right",
					pass_type = "texture",
					content_check_function = function (content)
						return content.background_corner_texture_top_right and not content.disabled
					end
				},
				{
					texture_id = "background_corner_texture_bottom_left",
					style_id = "background_corner_texture_bottom_left",
					pass_type = "texture",
					content_check_function = function (content)
						return content.background_corner_texture_bottom_left and not content.disabled
					end
				},
				{
					texture_id = "background_corner_texture_bottom_right",
					style_id = "background_corner_texture_bottom_right",
					pass_type = "texture",
					content_check_function = function (content)
						return content.background_corner_texture_bottom_right and not content.disabled
					end
				},
				{
					texture_id = "background_texture",
					style_id = "texture_id",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_hover_id_left",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return (not content.active and not content.disabled and not button_hotspot.disabled and content.highlighted) or (button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0))
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_selected_id_left",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not content.disabled and not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_flashing_id_left",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not content.disabled and not button_hotspot.disabled
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_hover_id_right",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return (not content.active and not content.disabled and not button_hotspot.disabled and content.highlighted) or (button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0))
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_selected_id_right",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not content.disabled and not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				},
				{
					texture_id = "highlight_texture",
					style_id = "texture_flashing_id_right",
					pass_type = "rotated_texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not content.active and not content.disabled and not button_hotspot.disabled
					end
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_title_divider",
					style_id = "texture_title_divider",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_level_icons",
					style_id = "texture_level_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_level_icons = content.texture_level_icons

						return not content.active and not content.disabled and texture_level_icons and 0 < #texture_level_icons
					end
				},
				{
					texture_id = "texture_level_divider",
					style_id = "texture_level_divider",
					pass_type = "texture",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return not content.active and not content.disabled and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texture_id = "texture_task_icons",
					style_id = "texture_task_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return not content.active and not content.disabled and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texts_id = "task_amount_texts",
					style_id = "task_amount_texts",
					pass_type = "multiple_texts",
					content_check_function = function (content)
						local task_amount_texts = content.task_amount_texts
						local texts = task_amount_texts and task_amount_texts.texts

						return not content.active and not content.disabled and texts and 0 < #texts
					end
				},
				{
					texture_id = "texture_tasks_divider",
					style_id = "texture_tasks_divider",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_token_reward_icon",
					style_id = "texture_token_reward_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					style_id = "reward_amount_text",
					pass_type = "text",
					text_id = "reward_amount_text",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_reward_bg",
					style_id = "texture_reward_bg",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_quest_link_bg",
					style_id = "texture_quest_link_bg",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_quest_link
					end
				},
				{
					texture_id = "texture_quest_link_fg",
					style_id = "texture_quest_link_fg",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_quest_link
					end
				},
				{
					style_id = "quest_link_text",
					pass_type = "text",
					text_id = "quest_link_text",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_quest_link
					end
				}
			}
		},
		content = {
			title_text = "n/a",
			texture_token_reward_icon = "token_icon_01_large",
			background_corner_texture_top_left = "quest_screen_bg_contract_01_corner_01",
			quest_link_text = "n/a",
			texture_reward_bg = "leather_bg_03",
			reward_amount_text = "n/a",
			texture_tasks_divider = "quest_screen_divider_3",
			background_corner_texture_bottom_left = "quest_screen_bg_contract_01_corner_03",
			texture_quest_link_fg = "quest_link_marker_fg_main_01",
			has_quest_link = false,
			texture_level_divider = "quest_screen_divider_3",
			texture_quest_link_bg = "quest_link_marker_no_text_bg_01",
			background_corner_texture_top_right = "quest_screen_bg_contract_01_corner_02",
			texture_title_divider = "quest_screen_divider_3",
			background_corner_texture_bottom_right = "quest_screen_bg_contract_01_corner_04",
			background_texture = "quest_screen_bg_contract_01",
			button_hotspot = {},
			highlight_texture = highlight_texture,
			texture_level_icons = {},
			texture_task_icons = {},
			task_amount_texts = {
				texts = {}
			}
		},
		style = {
			scale = background_texture_height_fraction,
			canvas_size = canvas_size,
			canvas_offset = canvas_offset,
			text_icon_spacing = text_icon_spacing,
			level_icon_spacing = level_icon_spacing,
			task_icon_spacing = task_icon_spacing,
			task_icon_size = texture_task_icon_size,
			tasks_level_y_offset = math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - texture_level_image_size[2] - row_divider_height),
			no_task_level_y_offset = math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - texture_level_image_size[2]*1.5 - row_divider_height),
			background_corner_texture_top_left = corner_style_top_left,
			background_corner_texture_top_right = corner_style_top_right,
			background_corner_texture_bottom_left = corner_style_bottom_left,
			background_corner_texture_bottom_right = corner_style_bottom_right,
			title_text = {
				localize = false,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "bottom",
				font_type = "hell_shark",
				size = title_text_size,
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]*0.5) - title_text_size[1]*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.3),
					canvas_offset[3] + 2
				},
				font_size = unscaled_small_title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_title_divider = {
				size = divider_3_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]*0.5) - divider_3_texture_size[1]*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*0.5 - divider_3_texture_size[2]),
					canvas_offset[3] + 2
				}
			},
			texture_level_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					level_icon_spacing,
					0
				},
				texture_size = texture_level_image_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - texture_level_image_size[2] - row_divider_height),
					canvas_offset[3] + 1
				}
			},
			texture_level_divider = {
				size = divider_3_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]*0.5) - divider_3_texture_size[1]*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - texture_level_image_size[2] - row_divider_height - row_divider_height*0.5 - divider_3_texture_size[2]),
					canvas_offset[3] + 2
				}
			},
			texture_task_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					task_icon_spacing,
					0
				},
				texture_size = texture_task_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - texture_level_image_size[2] - texture_task_icon_size[2] - row_divider_height*2),
					canvas_offset[3] + 1
				}
			},
			task_amount_texts = {
				spacing = 0,
				word_wrap = false,
				localize = false,
				axis = 1,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				direction = 1,
				font_type = "hell_shark",
				size = task_text_size,
				offset = {
					canvas_offset[1],
					math.floor(((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - texture_level_image_size[2] - texture_task_icon_size[2] + texture_task_icon_size[2]*0.5) - row_divider_height*2 - 3),
					canvas_offset[3] + 3
				},
				font_size = unscaled_small_title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_tasks_divider = {
				size = divider_3_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]*0.5) - divider_3_texture_size[1]*0.5),
					math.floor(((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - texture_level_image_size[2] - texture_task_icon_size[2] + texture_task_icon_size[2]*0.5) - row_divider_height*3 - row_divider_height*0.5 - divider_3_texture_size[2]),
					canvas_offset[3] + 2
				}
			},
			texture_token_reward_icon = {
				size = reward_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + reward_icon_size[1]*0.1 + 60),
					canvas_offset[2],
					canvas_offset[3] + 1
				}
			},
			reward_amount_text = {
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = reward_amount_text_size,
				offset = {
					math.floor(canvas_offset[1] + reward_icon_size[1]*1.05 + 60),
					canvas_offset[2],
					canvas_offset[3] + 2
				},
				font_size = unscaled_medium_title_font_size - 2,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			texture_reward_bg = {
				size = {
					reward_icon_size[1]*2.5,
					reward_icon_size[2]*1.4
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + 55),
					canvas_offset[2] - 10,
					canvas_offset[3]
				}
			},
			texture_quest_link_bg = {
				size = quest_link_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]) - quest_link_bg_texture_size[1]*1.1),
					math.floor(canvas_offset[2] - quest_link_bg_texture_size[2]*0.7),
					canvas_offset[3] + 22
				}
			},
			texture_quest_link_fg = {
				size = quest_link_fg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]) - quest_link_fg_texture_size[1]*1.1),
					math.floor(canvas_offset[2] + quest_link_bg_texture_size[2]*0.1),
					canvas_offset[3] + 22
				}
			},
			quest_link_text = {
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = quest_link_text_size,
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]) - quest_link_bg_texture_size[1]*1.1),
					math.floor(canvas_offset[2] - quest_link_bg_texture_size[2]*0.3),
					canvas_offset[3] + 23
				},
				font_size = unscaled_medium_title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_id = {
				size = size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = pass_offset
			},
			button_hotspot = {
				size = size,
				offset = pass_offset
			},
			texture_hover_id_left = {
				size = highlight_texture_size,
				color = {
					190,
					255,
					255,
					255
				},
				offset = highlight_texture_offset_left,
				angle = -math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_selected_id_left = {
				size = highlight_texture_size,
				color = {
					255,
					255,
					190,
					190
				},
				offset = highlight_texture_offset_left,
				angle = -math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_flashing_id_left = {
				size = highlight_texture_size,
				color = {
					0,
					255,
					100,
					100
				},
				offset = highlight_texture_offset_left,
				angle = -math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_hover_id_right = {
				size = highlight_texture_size,
				color = {
					190,
					255,
					255,
					255
				},
				offset = highlight_texture_offset_right,
				angle = math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_selected_id_right = {
				size = highlight_texture_size,
				color = {
					255,
					255,
					190,
					190
				},
				offset = highlight_texture_offset_right,
				angle = math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			},
			texture_flashing_id_right = {
				size = highlight_texture_size,
				color = {
					0,
					255,
					100,
					100
				},
				offset = highlight_texture_offset_right,
				angle = math.pi*0.5,
				pivot = {
					highlight_texture_size[1]*0.5,
					highlight_texture_size[2]*0.5
				}
			}
		},
		offset = {
			0,
			0,
			0
		},
		scenegraph_id = parent_scenegraph_id
	}
end

local function create_popup_contract(parent_scenegraph_id)
	local size = {
		781,
		904
	}
	local canvas_size = {
		695,
		835
	}
	local pass_offset = {
		0,
		0,
		1
	}
	local canvas_offset = {
		0,
		0,
		1
	}
	local parent_size = scenegraph_definition[parent_scenegraph_id].size
	local width_diff = parent_size[1] - size[1]
	local height_diff = parent_size[2] - size[2]
	local width_offset = width_diff*0.5
	local height_offset = height_diff*0.5 + 50
	pass_offset[1] = width_offset
	pass_offset[2] = height_offset
	canvas_offset[1] = pass_offset[1] + (size[1] - canvas_size[1])*0.5
	canvas_offset[2] = pass_offset[2] + (size[2] - canvas_size[2])*0.5
	canvas_offset[3] = pass_offset[3]
	local background_texture_default_size = {
		781,
		904
	}
	local background_texture_width_fraction = size[1]/background_texture_default_size[1]
	local background_texture_height_fraction = size[2]/background_texture_default_size[2]
	local corner_size = {
		126,
		193
	}
	local corner_style_top_left = {}
	local corner_style_top_right = {}
	local corner_style_bottom_left = {}
	local corner_style_bottom_right = {}
	local corner_size_top_left = {
		background_texture_width_fraction*corner_size[1],
		background_texture_height_fraction*corner_size[2]
	}
	local corner_offset_top_left = {
		pass_offset[1],
		pass_offset[2] + size[2] - corner_size_top_left[2],
		pass_offset[3] + 1
	}
	corner_style_top_left.size = corner_size_top_left
	corner_style_top_left.offset = corner_offset_top_left
	local corner_size_top_right = {
		background_texture_width_fraction*corner_size[1],
		background_texture_height_fraction*corner_size[2]
	}
	local corner_offset_rop_right = {
		pass_offset[1] + size[1] - corner_size_top_right[1],
		pass_offset[2] + size[2] - corner_size_top_right[2],
		pass_offset[3] + 1
	}
	corner_style_top_right.size = corner_size_top_right
	corner_style_top_right.offset = corner_offset_rop_right
	local corner_size_bottom_left = {
		background_texture_width_fraction*corner_size[1],
		background_texture_height_fraction*corner_size[2]
	}
	local corner_offset_bottom_left = {
		pass_offset[1],
		pass_offset[2],
		pass_offset[3] + 1
	}
	corner_style_bottom_left.size = corner_size_bottom_left
	corner_style_bottom_left.offset = corner_offset_bottom_left
	local corner_size_bottom_right = {
		background_texture_width_fraction*corner_size[1],
		background_texture_height_fraction*corner_size[2]
	}
	local corner_offset_bottom_right = {
		pass_offset[1] + size[1] - corner_size_bottom_right[1],
		pass_offset[2],
		pass_offset[3] + 1
	}
	corner_style_bottom_right.size = corner_size_bottom_right
	corner_style_bottom_right.offset = corner_offset_bottom_right
	local block_height = canvas_size[2]/9
	local task_icon_spacing = background_texture_height_fraction*60
	local character_icon_spacing = background_texture_height_fraction*10
	local difficulty_icon_spacing = background_texture_height_fraction*35
	local loadout_icon_spacing = background_texture_height_fraction*10
	local text_icon_spacing = background_texture_height_fraction*5
	local level_icon_spacing = background_texture_height_fraction*25
	local reward_icon_spacing = background_texture_height_fraction*35
	local row_divider_height = background_texture_height_fraction*25
	local texture_level_image_settings = get_atlas_settings_by_texture_name("quest_screen_level_image_magnus")
	local texture_level_image_size = {
		background_texture_height_fraction*texture_level_image_settings.size[1],
		background_texture_height_fraction*texture_level_image_settings.size[2]
	}
	local texture_task_icon_name = "quest_icon_grimoire"
	local texture_task_icon_settings = get_atlas_settings_by_texture_name(texture_task_icon_name)
	local texture_task_icon_size = {
		background_texture_height_fraction*texture_task_icon_settings.size[1]*0.85,
		background_texture_height_fraction*texture_task_icon_settings.size[2]*0.85
	}
	local reward_icon_settings = get_atlas_settings_by_texture_name("token_icon_01_large")
	local reward_icon_size = {
		background_texture_height_fraction*reward_icon_settings.size[1],
		background_texture_height_fraction*reward_icon_settings.size[2]
	}
	local boon_reward_icon_settings = get_atlas_settings_by_texture_name("token_icon_01_large")
	local boon_reward_icon_size = {
		background_texture_height_fraction*boon_reward_icon_settings.size[1]*0.75,
		background_texture_height_fraction*boon_reward_icon_settings.size[2]*0.75
	}
	local quest_link_bg_texture = get_atlas_settings_by_texture_name("quest_link_marker_bg_01")
	local quest_link_bg_texture_size = {
		background_texture_height_fraction*quest_link_bg_texture.size[1],
		background_texture_height_fraction*quest_link_bg_texture.size[2]
	}
	local quest_link_fg_texture = get_atlas_settings_by_texture_name("quest_link_marker_fg_main_01")
	local quest_link_fg_texture_size = {
		background_texture_height_fraction*quest_link_fg_texture.size[1],
		background_texture_height_fraction*quest_link_fg_texture.size[2]
	}
	local contract_title_bg_texture = get_atlas_settings_by_texture_name("quest_screen_title_bg_01")
	local contract_title_bg_texture_size = {
		background_texture_height_fraction*contract_title_bg_texture.size[1],
		background_texture_height_fraction*contract_title_bg_texture.size[2]
	}
	local level_title_bg_texture = get_atlas_settings_by_texture_name("quest_screen_title_bg_01")
	local level_title_bg_texture_size = {
		background_texture_height_fraction*level_title_bg_texture.size[1],
		background_texture_height_fraction*level_title_bg_texture.size[2]
	}
	local tasks_title_bg_texture = get_atlas_settings_by_texture_name("quest_screen_title_bg_01")
	local tasks_title_bg_texture_size = {
		background_texture_height_fraction*tasks_title_bg_texture.size[1],
		background_texture_height_fraction*tasks_title_bg_texture.size[2]
	}
	local contract_reward_bg_texture = get_atlas_settings_by_texture_name("leather_bg_03")
	local contract_reward_bg_texture_size = {
		background_texture_height_fraction*contract_reward_bg_texture.size[1],
		background_texture_height_fraction*contract_reward_bg_texture.size[2]
	}
	local complete_texture_settings = get_atlas_settings_by_texture_name("quest_completed")
	local complete_texture_size = {
		background_texture_height_fraction*complete_texture_settings.size[1]*1.25,
		background_texture_height_fraction*complete_texture_settings.size[2]*1.25
	}
	local title_font_size = math.ceil(background_texture_height_fraction*32)
	local description_font_size = math.ceil(background_texture_height_fraction*18)
	local medium_title_font_size = math.ceil(background_texture_height_fraction*24)
	local small_title_font_size = math.ceil(background_texture_height_fraction*20)
	local small_text_font_size = math.ceil(background_texture_height_fraction*22)
	local title_text_size = {
		canvas_size[1] - title_font_size*2,
		title_font_size*2
	}
	local description_text_size = {
		canvas_size[1] - title_font_size*2,
		description_font_size*5
	}
	local level_title_text_size = {
		canvas_size[1],
		medium_title_font_size
	}
	local difficulty_text_size = {
		canvas_size[1],
		medium_title_font_size
	}
	local level_name_text_size = {
		texture_level_image_size[1],
		small_title_font_size
	}
	local task_text_size = {
		texture_task_icon_size[1] + task_icon_spacing,
		title_font_size
	}
	local task_progress_text_size = {
		texture_task_icon_size[1] + task_icon_spacing,
		small_text_font_size
	}
	local task_title_text_size = {
		canvas_size[1]*0.5,
		medium_title_font_size
	}
	local reward_title_text_size = {
		canvas_size[1]*0.5,
		medium_title_font_size
	}
	local reward_amount_text_size = reward_icon_size
	local boon_name_text_size = {
		contract_reward_bg_texture_size[1],
		medium_title_font_size
	}
	local quest_link_text_size = {
		quest_link_bg_texture_size[1],
		medium_title_font_size
	}

	return {
		element = {
			passes = {
				{
					style_id = "button_hotspot",
					pass_type = "hotspot",
					content_id = "button_hotspot",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "background_texture",
					style_id = "texture_id",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "complete_texture",
					style_id = "complete_texture",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.requirements_met
					end
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					style_id = "description_text",
					pass_type = "text",
					text_id = "description_text",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					style_id = "level_title_text",
					pass_type = "text",
					text_id = "level_title_text",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_level_title_bg",
					style_id = "texture_level_title_bg",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					style_id = "difficulty_text",
					pass_type = "text",
					text_id = "difficulty_text",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_level_icons",
					style_id = "texture_level_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_level_icons = content.texture_level_icons

						return not content.active and not content.disabled and texture_level_icons and 0 < #texture_level_icons
					end
				},
				{
					texts_id = "level_name_texts",
					style_id = "level_name_texts",
					pass_type = "multiple_texts",
					content_check_function = function (content)
						local level_name_texts = content.level_name_texts
						local texts = level_name_texts and level_name_texts.texts

						return not content.active and not content.disabled and texts and 0 < #texts
					end
				},
				{
					texture_id = "texture_level_checkmark_icons",
					style_id = "texture_level_checkmark_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_level_icons = content.texture_level_icons

						return not content.active and not content.disabled and texture_level_icons and 0 < #texture_level_icons
					end
				},
				{
					style_id = "task_title_text",
					pass_type = "text",
					text_id = "task_title_text",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return not content.active and not content.disabled and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texture_id = "texture_tasks_title_bg",
					style_id = "texture_tasks_title_bg",
					pass_type = "texture",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return not content.active and not content.disabled and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texture_id = "texture_task_icons",
					style_id = "texture_task_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return not content.active and not content.disabled and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texture_id = "texture_task_checkmark_icons",
					style_id = "texture_task_checkmark_icons",
					pass_type = "multi_texture",
					content_check_function = function (content)
						local texture_task_icons = content.texture_task_icons

						return not content.active and not content.disabled and texture_task_icons and 0 < #texture_task_icons
					end
				},
				{
					texts_id = "task_amount_texts",
					style_id = "task_amount_texts",
					pass_type = "multiple_texts",
					content_check_function = function (content)
						local task_amount_texts = content.task_amount_texts
						local texts = task_amount_texts and task_amount_texts.texts

						return not content.active and not content.disabled and texts and 0 < #texts
					end
				},
				{
					texts_id = "task_progress_texts",
					style_id = "task_progress_texts",
					pass_type = "multiple_texts",
					content_check_function = function (content)
						local task_progress_texts = content.task_progress_texts
						local texts = task_progress_texts and task_progress_texts.texts

						return not content.active and not content.disabled and texts and 0 < #texts
					end
				},
				{
					texts_id = "task_name_texts",
					style_id = "task_name_texts",
					pass_type = "multiple_texts",
					content_check_function = function (content)
						local task_name_texts = content.task_name_texts
						local texts = task_name_texts and task_name_texts.texts

						return not content.active and not content.disabled and texts and 0 < #texts
					end
				},
				{
					style_id = "reward_title_text",
					pass_type = "text",
					text_id = "reward_title_text",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_reward_bg",
					style_id = "texture_reward_bg",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled
					end
				},
				{
					texture_id = "texture_token_reward_icon",
					style_id = "texture_token_reward_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_token_reward
					end
				},
				{
					style_id = "reward_amount_text",
					pass_type = "text",
					text_id = "reward_amount_text",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_token_reward
					end
				},
				{
					texture_id = "texture_boon_reward_icon",
					style_id = "texture_boon_reward_icon",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_boon_reward
					end
				},
				{
					style_id = "boon_duration_text",
					pass_type = "text",
					text_id = "boon_duration_text",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_boon_reward
					end
				},
				{
					style_id = "boon_name_text",
					pass_type = "text",
					text_id = "boon_name_text",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_boon_reward
					end
				},
				{
					texture_id = "texture_quest_link_bg",
					style_id = "texture_quest_link_bg",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_quest_link
					end
				},
				{
					texture_id = "texture_quest_link_fg",
					style_id = "texture_quest_link_fg",
					pass_type = "texture",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_quest_link
					end
				},
				{
					style_id = "quest_link_text",
					pass_type = "text",
					text_id = "quest_link_text",
					content_check_function = function (content)
						return not content.active and not content.disabled and content.has_quest_link
					end
				}
			}
		},
		content = {
			background_corner_texture_top_left = "quest_screen_bg_contract_01_corner_01",
			title_text = "n/a",
			texture_tasks_title_bg = "quest_screen_title_bg_02",
			texture_token_reward_icon = "token_icon_01_large",
			boon_duration_text = "n/a",
			reward_title_text = "dlc1_3_1_rewards",
			task_title_text = "dlc1_3_1_tasks",
			texture_quest_link_fg = "quest_link_marker_fg_main_01",
			quest_link_text = "n/a",
			level_title_text = "dlc1_3_1_mission_difficulty",
			reward_amount_text = "n/a",
			boon_name_text = "n/a",
			complete_texture = "quest_completed",
			has_quest_link = false,
			texture_quest_link_bg = "quest_link_marker_no_text_bg_01",
			background_corner_texture_bottom_right = "quest_screen_bg_contract_01_corner_04",
			texture_boon_reward_icon = "token_icon_01_large",
			background_texture = "quest_screen_bg_contract_01",
			texture_level_title_bg = "quest_screen_title_bg_01",
			texture_reward_bg = "leather_bg_03",
			description_text = "n/a",
			difficulty_text = "n/a",
			background_corner_texture_bottom_left = "quest_screen_bg_contract_01_corner_03",
			background_corner_texture_top_right = "quest_screen_bg_contract_01_corner_02",
			button_hotspot = {},
			texture_level_icons = {},
			level_name_texts = {
				texts = {}
			},
			texture_level_checkmark_icons = {
				"checkmark_large",
				"checkmark_large",
				"checkmark_large"
			},
			completed_levels = {
				false,
				false,
				false
			},
			texture_task_icons = {},
			texture_task_checkmark_icons = {
				"checkmark_large",
				"checkmark_large",
				"checkmark_large"
			},
			completed_tasks = {
				false,
				false,
				false
			},
			task_amount_texts = {
				texts = {}
			},
			task_progress_texts = {
				texts = {}
			},
			task_name_texts = {
				texts = {
					"KILL!",
					"MAIM!",
					"BURN!"
				}
			}
		},
		style = {
			background_size = size,
			background_offset = pass_offset,
			scale = background_texture_height_fraction,
			canvas_size = canvas_size,
			canvas_offset = canvas_offset,
			text_icon_spacing = text_icon_spacing,
			level_icon_spacing = level_icon_spacing,
			task_icon_spacing = task_icon_spacing,
			task_icon_size = texture_task_icon_size,
			background_corner_texture_top_left = corner_style_top_left,
			background_corner_texture_top_right = corner_style_top_right,
			background_corner_texture_bottom_left = corner_style_bottom_left,
			background_corner_texture_bottom_right = corner_style_bottom_right,
			title_text = {
				localize = false,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "bottom",
				font_type = "hell_shark",
				size = title_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - title_text_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2]*1.3),
					canvas_offset[3] + 2
				},
				font_size = title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			description_text = {
				localize = false,
				word_wrap = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = description_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - description_text_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height - description_text_size[2]),
					canvas_offset[3] + 2
				},
				font_size = description_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			level_title_text = {
				localize = true,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = level_title_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - level_title_text_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*3 - description_text_size[2] + (level_title_bg_texture_size[2] - level_title_text_size[2])*0.5),
					canvas_offset[3] + 3
				},
				font_size = medium_title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			texture_level_title_bg = {
				size = level_title_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - level_title_bg_texture_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*3 - description_text_size[2]),
					canvas_offset[3] + 2
				}
			},
			difficulty_text = {
				localize = false,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = difficulty_text_size,
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*4 - description_text_size[2] - difficulty_text_size[2]*0.5),
					canvas_offset[3] + 1
				},
				font_size = medium_title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_level_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					level_icon_spacing,
					0
				},
				texture_size = texture_level_image_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*5 - description_text_size[2] - texture_level_image_size[2]),
					canvas_offset[3] + 1
				}
			},
			level_name_texts = {
				word_wrap = false,
				localize = true,
				axis = 1,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				direction = 1,
				font_type = "hell_shark",
				spacing = level_icon_spacing,
				size = level_name_text_size,
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*6 - description_text_size[2] - texture_level_image_size[2]),
					canvas_offset[3] + 3
				},
				font_size = small_title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_level_checkmark_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					level_icon_spacing,
					0
				},
				texture_size = texture_level_image_size,
				texture_colors = {
					{
						255,
						0,
						255,
						0
					},
					{
						255,
						0,
						255,
						0
					},
					{
						255,
						0,
						255,
						0
					}
				},
				color = {
					255,
					0,
					255,
					0
				},
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*5 - description_text_size[2] - texture_level_image_size[2]),
					canvas_offset[3] + 1
				}
			},
			task_title_text = {
				localize = true,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = task_title_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - task_title_text_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*8 - description_text_size[2] - texture_level_image_size[2] - level_name_text_size[2] + (tasks_title_bg_texture_size[2] - task_title_text_size[2])*0.5),
					canvas_offset[3] + 3
				},
				font_size = medium_title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			texture_tasks_title_bg = {
				size = tasks_title_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - tasks_title_bg_texture_size[1])*0.5),
					math.floor((canvas_offset[2] + canvas_size[2]) - title_text_size[2] - row_divider_height*8 - description_text_size[2] - texture_level_image_size[2] - level_name_text_size[2]),
					canvas_offset[3] + 2
				}
			},
			texture_task_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					task_icon_spacing,
					0
				},
				texture_size = texture_task_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - block_height*6.7 - texture_task_icon_size[2]*0.5 + small_text_font_size*0.5),
					canvas_offset[3] + 1
				}
			},
			texture_task_checkmark_icons = {
				direction = 1,
				axis = 1,
				spacing = {
					task_icon_spacing,
					0
				},
				texture_size = texture_task_icon_size,
				texture_colors = {
					{
						255,
						0,
						255,
						0
					},
					{
						255,
						0,
						255,
						0
					},
					{
						255,
						0,
						255,
						0
					}
				},
				color = {
					255,
					0,
					255,
					0
				},
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - block_height*6.7 - texture_task_icon_size[2]*0.5),
					canvas_offset[3] + 2
				}
			},
			task_amount_texts = {
				spacing = 0,
				word_wrap = false,
				localize = false,
				axis = 1,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				direction = 1,
				font_type = "hell_shark",
				size = task_text_size,
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - block_height*6.85 + small_text_font_size*0.5),
					canvas_offset[3] + 3
				},
				font_size = title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			task_progress_texts = {
				spacing = 0,
				word_wrap = false,
				localize = false,
				axis = 1,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				direction = 1,
				font_type = "hell_shark",
				size = task_progress_text_size,
				offset = {
					canvas_offset[1],
					math.floor((canvas_offset[2] + canvas_size[2]) - block_height*6.9 - texture_task_icon_size[2]*0.5 + small_text_font_size*0.5 + 8),
					canvas_offset[3] + 3
				},
				font_size = small_text_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			task_name_texts = {
				spacing = 0,
				word_wrap = false,
				localize = true,
				axis = 1,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				direction = 1,
				font_type = "hell_shark",
				size = task_progress_text_size,
				offset = {
					canvas_offset[1],
					math.floor(((canvas_offset[2] + canvas_size[2]) - block_height*6.6 + texture_task_icon_size[2]*0.5 + small_text_font_size*0.5) - 10),
					canvas_offset[3] + 3
				},
				font_size = small_text_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			reward_title_text = {
				localize = true,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = reward_title_text_size,
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]*0.5) - reward_title_text_size[1]*0.5),
					math.floor((canvas_offset[2] + contract_reward_bg_texture_size[2]*0.91) - reward_title_text_size[2]),
					canvas_offset[3] + 2
				},
				font_size = medium_title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			texture_reward_bg = {
				size = contract_reward_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - contract_reward_bg_texture_size[1])*0.5),
					canvas_offset[2],
					canvas_offset[3] + 1
				}
			},
			texture_token_reward_icon = {
				size = reward_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + (canvas_size[1] - reward_icon_size[1])*0.5) - reward_icon_size[1]*0.45),
					math.floor((canvas_offset[2] + (contract_reward_bg_texture_size[2] - reward_icon_size[2])*0.5) - reward_title_text_size[2]*0.5),
					canvas_offset[3] + 1
				}
			},
			reward_amount_text = {
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = reward_amount_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - reward_icon_size[1])*0.5 + reward_icon_size[1]*0.45),
					math.floor((canvas_offset[2] + (contract_reward_bg_texture_size[2] - reward_icon_size[2])*0.5) - reward_title_text_size[2]*0.5),
					canvas_offset[3] + 2
				},
				font_size = title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			texture_boon_reward_icon = {
				size = boon_reward_icon_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + (canvas_size[1] - boon_reward_icon_size[1])*0.5) - boon_reward_icon_size[1]*0.45),
					math.floor(canvas_offset[2] + (contract_reward_bg_texture_size[2] - boon_reward_icon_size[2])*0.5),
					canvas_offset[3] + 1
				}
			},
			boon_duration_text = {
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = reward_amount_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - boon_reward_icon_size[1])*0.5 + boon_reward_icon_size[1]*0.45),
					math.floor((canvas_offset[2] + (contract_reward_bg_texture_size[2] - boon_reward_icon_size[2])*0.5) - reward_title_text_size[2]*0.5),
					canvas_offset[3] + 2
				},
				font_size = medium_title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			boon_name_text = {
				localize = true,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				size = boon_name_text_size,
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - boon_name_text_size[1])*0.5),
					math.floor((canvas_offset[2] + boon_name_text_size[2]) - 5),
					canvas_offset[3] + 2
				},
				font_size = small_title_font_size,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
			},
			texture_quest_link_bg = {
				size = quest_link_bg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]) - quest_link_bg_texture_size[1]*1.1),
					math.floor(canvas_offset[2] - quest_link_bg_texture_size[2]*0.4),
					canvas_offset[3] + 2
				}
			},
			texture_quest_link_fg = {
				size = quest_link_fg_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]) - quest_link_fg_texture_size[1]*1.1),
					math.floor(canvas_offset[2] + quest_link_bg_texture_size[2]*0.4),
					canvas_offset[3] + 2
				}
			},
			quest_link_text = {
				localize = false,
				word_wrap = false,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				font_type = "hell_shark",
				size = quest_link_text_size,
				offset = {
					math.floor((canvas_offset[1] + canvas_size[1]) - quest_link_bg_texture_size[1]*1.1),
					math.floor(canvas_offset[2] + quest_link_bg_texture_size[2]*0.06 + 2),
					canvas_offset[3] + 3
				},
				font_size = title_font_size,
				text_color = Colors.get_color_table_with_alpha("black", 255)
			},
			texture_id = {
				size = size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = pass_offset
			},
			button_hotspot = {
				size = size,
				offset = pass_offset
			},
			complete_texture = {
				size = complete_texture_size,
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					math.floor(canvas_offset[1] + (canvas_size[1] - complete_texture_size[1])*0.5),
					math.floor(canvas_offset[2] + (canvas_size[2] - complete_texture_size[2])*0.5),
					canvas_offset[3] + 10
				}
			}
		},
		offset = {
			0,
			0,
			0
		},
		scenegraph_id = parent_scenegraph_id
	}
end

local function create_gamepad_selection_widget(background_texture, optional_size)
	local texture_settings = background_texture and get_atlas_settings_by_texture_name(background_texture)
	local size = optional_size or texture_settings.size

	return {
		scenegraph_id = "root",
		element = {
			passes = {
				{
					texture_id = "gamepad_glow_1",
					style_id = "gamepad_glow_1",
					pass_type = "texture"
				},
				{
					texture_id = "gamepad_glow_2",
					style_id = "gamepad_glow_2",
					pass_type = "texture"
				},
				{
					texture_id = "gamepad_glow_3",
					style_id = "gamepad_glow_3",
					pass_type = "texture"
				},
				{
					texture_id = "gamepad_glow_4",
					style_id = "gamepad_glow_4",
					pass_type = "texture"
				}
			}
		},
		content = {
			gamepad_glow_3 = "quest_gamepad_frame_glow_03",
			gamepad_glow_1 = "quest_gamepad_frame_glow_01",
			gamepad_glow_4 = "quest_gamepad_frame_glow_04",
			gamepad_glow_2 = "quest_gamepad_frame_glow_02"
		},
		style = {
			rect = {
				size = size,
				color = {
					100,
					255,
					255,
					255
				}
			},
			gamepad_glow_1 = {
				size = {
					140,
					140
				},
				offset = {
					-45,
					size[2] - 140 + 37,
					10
				},
				base_offset = {
					-45,
					size[2] - 140 + 37,
					10
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			gamepad_glow_2 = {
				size = {
					140,
					140
				},
				offset = {
					size[1] - 140 + 45,
					size[2] - 140 + 37,
					10
				},
				base_offset = {
					size[1] - 140 + 45,
					size[2] - 140 + 37,
					10
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			gamepad_glow_3 = {
				size = {
					140,
					140
				},
				offset = {
					-45,
					-37,
					10
				},
				base_offset = {
					-45,
					-37,
					10
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			gamepad_glow_4 = {
				size = {
					140,
					140
				},
				offset = {
					size[1] - 140 + 45,
					-37,
					10
				},
				base_offset = {
					size[1] - 140 + 45,
					-37,
					10
				},
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	}
end

local widgets_definitions = {
	title_widget = UIWidgets.create_title_text("dlc1_3_1_quest_title", "title_text"),
	background_widget = UIWidgets.create_simple_texture("quest_screen_bg", "menu_root"),
	exit_button_widget = UIWidgets.create_menu_button_medium("close", "exit_button"),
	previous_page_button_widget = UIWidgets.create_quest_navigation_button("previous_page_button", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "dlc1_3_1_previous_board"),
	next_page_button_widget = UIWidgets.create_quest_navigation_button("next_page_button", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "dlc1_3_1_next_board"),
	menu_hover_overlay = UIWidgets.create_simple_rect("menu_hover_overlay", {
		0,
		0,
		0,
		0
	}),
	board_title_bg_widget = UIWidgets.create_simple_texture("quest_board_title_bar_01", "board_title_bg"),
	log_title_bg_widget = UIWidgets.create_simple_texture("quest_board_title_bar_02", "log_title_bg"),
	board_title_widget = UIWidgets.create_simple_text("dlc1_3_1_board_title_ubersreik", "board_title", 32, Colors.get_table("cheeseburger")),
	log_title_widget = UIWidgets.create_simple_text("dlc1_3_1_log_title", "log_title", 32, Colors.get_table("cheeseburger"))
}
local gamepad_widget_definitions = {
	gamepad_quest_selection = create_gamepad_selection_widget(nil, QuestSettings.QUEST_LOG_WIDGET_SIZE),
	gamepad_board_contract_selection = create_gamepad_selection_widget(nil, QuestSettings.BOARD_CONTRACT_SIZE),
	gamepad_log_contract_selection = create_gamepad_selection_widget(nil, scenegraph_definition.log_contract_1.size)
}
local detail_popup_widgets_definitions = {
	detail_popup_accept_button = UIWidgets.create_menu_button_medium("dlc1_3_1_accept", "detail_popup_accept_button"),
	detail_popup_decline_button = UIWidgets.create_menu_button_medium("dlc1_3_1_decline", "detail_popup_accept_button"),
	detail_popup_turn_in_button = UIWidgets.create_menu_button_medium("dlc1_3_1_turn_in", "detail_popup_accept_button"),
	detail_popup_close_button = UIWidgets.create_menu_button_medium("close", "detail_popup_close_button"),
	detail_popup_accept_tooltip = UIWidgets.create_simple_tooltip("dlc1_3_1_contract_log_full", "detail_popup_accept_button", 500)
}
local default_tooltip_style = {
	font_size = 24,
	max_width = 500,
	localize = false,
	horizontal_alignment = "left",
	vertical_alignment = "top",
	font_type = "hell_shark",
	text_color = Colors.get_color_table_with_alpha("white", 255),
	line_colors = {},
	offset = {
		0,
		0,
		3
	}
}
local trait_tooltip_style = table.clone(default_tooltip_style)
trait_tooltip_style.line_colors = {
	Colors.get_color_table_with_alpha("cheeseburger", 255),
	Colors.get_color_table_with_alpha("white", 255)
}
trait_tooltip_style.last_line_color = Colors.get_color_table_with_alpha("red", 255)
local item_reward_button_definitions = {
	trait_button_1 = UIWidgets.create_small_trait_button("trait_button_1", "trait_button_1"),
	trait_button_2 = UIWidgets.create_small_trait_button("trait_button_2", "trait_button_2"),
	trait_button_3 = UIWidgets.create_small_trait_button("trait_button_3", "trait_button_3"),
	trait_button_4 = UIWidgets.create_small_trait_button("trait_button_4", "trait_button_4"),
	trait_tooltip_1 = UIWidgets.create_simple_tooltip("", "trait_tooltip_1", nil, trait_tooltip_style),
	trait_tooltip_2 = UIWidgets.create_simple_tooltip("", "trait_tooltip_2", nil, trait_tooltip_style),
	trait_tooltip_3 = UIWidgets.create_simple_tooltip("", "trait_tooltip_3", nil, trait_tooltip_style),
	trait_tooltip_4 = UIWidgets.create_simple_tooltip("", "trait_tooltip_4", nil, trait_tooltip_style),
	hero_icon_tooltip = UIWidgets.create_simple_tooltip("", "hero_icon_tooltip", nil, default_tooltip_style)
}
local reward_popup_widgets_definitions = {
	reward_popup_dummy_bg_fade = UIWidgets.create_simple_rect("reward_popup_dummy_bg_fade", {
		0,
		0,
		0,
		0
	}),
	reward_popup_bg_fade = UIWidgets.create_simple_rect("reward_popup_bg_fade", {
		200,
		0,
		0,
		0
	}),
	reward_continue_button = UIWidgets.create_menu_button_medium("dlc1_3_1_continue", "reward_continue_button")
}
local header_text_style = {
	vertical_alignment = "center",
	font_size = 100,
	localize = true,
	horizontal_alignment = "center",
	word_wrap = false,
	font_type = "hell_shark",
	text_color = Colors.get_color_table_with_alpha("white", 0),
	offset = {
		0,
		0,
		2
	}
}
local title_text_style = table.clone(header_text_style)
title_text_style.font_size = 40
local completion_text_widget_definitions = {
	completion_header_widget = UIWidgets.create_simple_text("dlc1_3_1_quest_completed", "completion_header", nil, nil, header_text_style),
	completion_title_widget = UIWidgets.create_simple_text("dlc1_3_1_quest_completed", "completion_title", nil, nil, title_text_style)
}
local description_text_widgets = {
	description_background = UIWidgets.create_simple_texture("gradient_credits_menu", "description_background"),
	description_title = UIWidgets.create_simple_text("dlc1_3_1_quest_info_title", "description_title", nil, nil, {
		vertical_alignment = "center",
		font_size = 36,
		localize = true,
		horizontal_alignment = "center",
		word_wrap = true,
		font_type = "hell_shark_header",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			2
		}
	}),
	input_description_text = UIWidgets.create_simple_text("press_any_key_to_continue", "input_description_text", 18, Colors.get_color_table_with_alpha("white", 255)),
	description_text = UIWidgets.create_simple_text("dlc1_3_1_quest_info_text", "description_text", nil, nil, {
		vertical_alignment = "top",
		font_size = 24,
		localize = true,
		horizontal_alignment = "left",
		word_wrap = true,
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("white", 255),
		offset = {
			0,
			0,
			2
		}
	})
}
widgets_definitions.dead_space_filler = {
	scenegraph_id = "dead_space_filler",
	element = {
		passes = {
			{
				pass_type = "rect"
			}
		}
	},
	content = {},
	style = {
		color = {
			255,
			0,
			0,
			0
		}
	}
}
local background_settings = {
	quest_screen_bg_contract_01 = {
		background = "quest_screen_bg_contract_01",
		corners = {
			"quest_screen_bg_contract_01_corner_01",
			"quest_screen_bg_contract_01_corner_02",
			"quest_screen_bg_contract_01_corner_03",
			"quest_screen_bg_contract_01_corner_04"
		}
	},
	quest_screen_bg_contract_02 = {
		background = "quest_screen_bg_contract_02",
		corners = {
			"quest_screen_bg_contract_02_corner_01",
			"quest_screen_bg_contract_02_corner_02",
			"quest_screen_bg_contract_02_corner_03",
			"quest_screen_bg_contract_02_corner_04"
		}
	},
	quest_screen_bg_contract_03 = {
		background = "quest_screen_bg_contract_03",
		corners = {
			"quest_screen_bg_contract_03_corner_01",
			"quest_screen_bg_contract_03_corner_02",
			"quest_screen_bg_contract_03_corner_03",
			"quest_screen_bg_contract_03_corner_04"
		}
	},
	quest_screen_bg_contract_04 = {
		background = "quest_screen_bg_contract_04",
		corners = {
			"quest_screen_bg_contract_04_corner_01",
			"quest_screen_bg_contract_04_corner_02",
			"quest_screen_bg_contract_04_corner_03",
			"quest_screen_bg_contract_04_corner_04"
		}
	},
	quest_screen_bg_contract_05 = {
		background = "quest_screen_bg_contract_05",
		corners = {
			"quest_screen_bg_contract_05_corner_01",
			"quest_screen_bg_contract_05_corner_02",
			"quest_screen_bg_contract_05_corner_03",
			"quest_screen_bg_contract_05_corner_04"
		}
	}
}
local animations = {
	board_widget_to_center = {
		{
			name = "fade_in",
			start_progress = 0,
			end_progress = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local widget = widgets[1]
				local scenegraph_id = widget.scenegraph_id
				local widget_scengraph_definition = scenegraph_definition[scenegraph_id]
				local widget_scengraph = ui_scenegraph[scenegraph_id]
				local definition_size = widget_scengraph_definition.size
				local world_position = widget_scengraph.world_position
				local destination_x = definition_size[1]*0.5 - 960
				local destination_y = definition_size[2]*0.5 - 540
				local x_diff = destination_x - world_position[1]
				local y_diff = destination_y - world_position[2]
				local current_position = widget_scengraph.local_position
				params.position_start_x = current_position[1]
				params.position_start_y = current_position[2]
				params.position_diff_x = x_diff
				params.position_diff_y = y_diff
				local background_size = widget.style.texture_id.size
				params.background_start_size_x = background_size[1]
				params.background_start_size_y = background_size[2]

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local scenegraph_id = widget.scenegraph_id
				local widget_scengraph_definition = scenegraph_definition[scenegraph_id]
				local widget_scengraph = ui_scenegraph[scenegraph_id]
				local current_position = widget_scengraph.local_position
				current_position[1] = params.position_start_x + params.position_diff_x*local_progress
				current_position[2] = params.position_start_y + params.position_diff_y*local_progress
				local background_size = widget.style.texture_id.size
				local scale_add_multiplier = UIResolutionScale() - 1
				background_size[1] = params.background_start_size_x + scale_add_multiplier*params.background_start_size_x*local_progress
				background_size[2] = params.background_start_size_y + scale_add_multiplier*params.background_start_size_y*local_progress

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets_definitions = widgets_definitions,
	gamepad_widget_definitions = gamepad_widget_definitions,
	detail_popup_widgets_definitions = detail_popup_widgets_definitions,
	item_reward_button_definitions = item_reward_button_definitions,
	reward_popup_widgets_definitions = reward_popup_widgets_definitions,
	description_text_widgets = description_text_widgets,
	completion_text_widget_definitions = completion_text_widget_definitions,
	create_popup_quest = create_popup_quest,
	create_log_quest = create_log_quest,
	create_board_quest = create_board_quest,
	create_popup_contract = create_popup_contract,
	create_board_contract = create_board_contract,
	create_log_contract = create_log_contract,
	background_settings = background_settings,
	animations = animations
}
