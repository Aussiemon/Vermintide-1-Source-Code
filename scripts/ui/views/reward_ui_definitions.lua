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
			UILayer.end_screen
		}
	},
	screen = {
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
	overlay = {
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
			10
		}
	},
	reward_screen_root = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			0,
			0,
			1
		}
	},
	reward_viewport = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			1146,
			1080
		},
		position = {
			0,
			0,
			1
		}
	},
	door_left = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			1080,
			1080
		},
		position = {
			0,
			0,
			-16
		}
	},
	door_right = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "right",
		size = {
			960,
			1080
		},
		position = {
			0,
			0,
			-15
		}
	},
	fl_left_root = {
		vertical_alignment = "center",
		parent = "door_left",
		horizontal_alignment = "right",
		size = {
			1,
			1
		},
		position = {
			-119.5,
			0,
			1
		}
	},
	fl_left_bg = {
		vertical_alignment = "center",
		parent = "fl_left_root",
		horizontal_alignment = "right",
		size = {
			170,
			342
		},
		position = {
			0,
			0,
			1
		}
	},
	fl_left_cover_top = {
		vertical_alignment = "top",
		parent = "fl_left_root",
		horizontal_alignment = "right",
		size = {
			142,
			151
		},
		position = {
			0,
			151,
			2
		}
	},
	fl_left_cover_bottom = {
		vertical_alignment = "top",
		parent = "fl_left_root",
		horizontal_alignment = "right",
		size = {
			141,
			150
		},
		position = {
			0,
			0,
			2
		}
	},
	fl_left_pillar_left = {
		vertical_alignment = "center",
		parent = "fl_left_root",
		horizontal_alignment = "right",
		size = {
			210,
			231
		},
		position = {
			1,
			0,
			0
		}
	},
	fl_left_pillar_top = {
		vertical_alignment = "top",
		parent = "fl_left_root",
		horizontal_alignment = "right",
		size = {
			115,
			212
		},
		position = {
			1,
			212,
			0
		}
	},
	fl_left_pillar_bottom = {
		vertical_alignment = "top",
		parent = "fl_left_root",
		horizontal_alignment = "right",
		size = {
			115,
			212
		},
		position = {
			0,
			0,
			0
		}
	},
	fl_right_root = {
		vertical_alignment = "center",
		parent = "door_right",
		horizontal_alignment = "left",
		size = {
			1,
			1
		},
		position = {
			-0.5,
			0,
			1
		}
	},
	fl_right_bg = {
		vertical_alignment = "center",
		parent = "fl_right_root",
		horizontal_alignment = "right",
		size = {
			172,
			342
		},
		position = {
			172,
			0,
			1
		}
	},
	fl_right_cover_top = {
		vertical_alignment = "top",
		parent = "fl_right_root",
		horizontal_alignment = "right",
		size = {
			146,
			152
		},
		position = {
			146,
			152,
			2
		}
	},
	fl_right_cover_bottom = {
		vertical_alignment = "top",
		parent = "fl_right_root",
		horizontal_alignment = "right",
		size = {
			146,
			149
		},
		position = {
			146,
			0,
			2
		}
	},
	fl_right_pillar_right = {
		vertical_alignment = "center",
		parent = "fl_right_root",
		horizontal_alignment = "right",
		size = {
			210,
			231
		},
		position = {
			210,
			0,
			0
		}
	},
	fl_right_pillar_top = {
		vertical_alignment = "top",
		parent = "fl_right_root",
		horizontal_alignment = "left",
		size = {
			116,
			211
		},
		position = {
			1,
			211,
			0
		}
	},
	fl_right_pillar_bottom = {
		vertical_alignment = "top",
		parent = "fl_right_root",
		horizontal_alignment = "left",
		size = {
			116,
			211
		},
		position = {
			0,
			0,
			0
		}
	},
	lock_root = {
		vertical_alignment = "center",
		parent = "reward_screen_root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			0,
			0,
			10
		}
	},
	lock_bg_left = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			167,
			333
		},
		position = {
			0,
			0,
			3
		}
	},
	lock_bg_right = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "left",
		size = {
			167,
			333
		},
		position = {
			167,
			0,
			3
		}
	},
	lock_pillar_left = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			210,
			231
		},
		position = {
			1,
			0,
			1
		}
	},
	lock_pillar_right = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			210,
			231
		},
		position = {
			210,
			0,
			1
		}
	},
	lock_pillar_top = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "center",
		size = {
			231,
			212
		},
		position = {
			1,
			212,
			1
		}
	},
	lock_pillar_bottom = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "center",
		size = {
			231,
			212
		},
		position = {
			0,
			0,
			1
		}
	},
	lock_cogwheel_bg_left = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			170,
			342
		},
		position = {
			0,
			0,
			7
		}
	},
	lock_cogwheel_bg_right = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			172,
			342
		},
		position = {
			172,
			0,
			7
		}
	},
	lock_cogwheel_left = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			158,
			316
		},
		position = {
			0,
			0,
			6
		}
	},
	lock_cogwheel_right = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			158,
			316
		},
		position = {
			158,
			0,
			6
		}
	},
	lock_stick_top_left = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			125,
			127
		},
		position = {
			0,
			127,
			2
		}
	},
	lock_stick_top_right = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			125,
			127
		},
		position = {
			125,
			127,
			2
		}
	},
	lock_stick_bottom_left = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			125,
			127
		},
		position = {
			0,
			0,
			2
		}
	},
	lock_stick_bottom_right = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			125,
			127
		},
		position = {
			125,
			0,
			2
		}
	},
	lock_block_left = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			153,
			149
		},
		position = {
			0,
			0,
			5
		}
	},
	lock_block_right = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "left",
		size = {
			153,
			149
		},
		position = {
			-153,
			0,
			5
		}
	},
	lock_slot_holder_left = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			52,
			303
		},
		position = {
			-1,
			0,
			4
		}
	},
	lock_slot_holder_right = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "left",
		size = {
			52,
			303
		},
		position = {
			0,
			0,
			4
		}
	},
	lock_cover_top_left = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			142,
			151
		},
		position = {
			0,
			151,
			9
		}
	},
	lock_cover_top_right = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			146,
			152
		},
		position = {
			146,
			152,
			9
		}
	},
	lock_cover_bottom_left = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			141,
			150
		},
		position = {
			0,
			0,
			9
		}
	},
	lock_cover_bottom_right = {
		vertical_alignment = "top",
		parent = "lock_root",
		horizontal_alignment = "right",
		size = {
			146,
			149
		},
		position = {
			146,
			0,
			9
		}
	},
	reward_box_final = {
		vertical_alignment = "center",
		parent = "lock_root",
		horizontal_alignment = "center",
		size = {
			85,
			85
		},
		position = {
			0,
			0,
			8
		}
	},
	gamepad_continue_text = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			1000,
			120
		},
		position = {
			0,
			70,
			-300
		}
	},
	roll_button = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			338,
			120
		},
		position = {
			0,
			70,
			-300
		}
	},
	roll_button_eye_glow = {
		vertical_alignment = "center",
		parent = "roll_button",
		horizontal_alignment = "center",
		size = {
			63,
			46
		},
		position = {
			-1,
			35,
			1
		}
	},
	box_holder_parent = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			61,
			99
		},
		position = {
			1569,
			55,
			12
		}
	},
	box_holder_bg = {
		vertical_alignment = "center",
		parent = "box_holder_parent",
		horizontal_alignment = "center",
		size = {
			117,
			73
		},
		position = {
			12,
			-5,
			-1
		}
	},
	box_holder_left = {
		vertical_alignment = "center",
		parent = "box_holder_parent",
		horizontal_alignment = "center",
		size = {
			61,
			99
		},
		position = {
			-48,
			-7,
			2
		}
	},
	box_holder_right = {
		vertical_alignment = "center",
		parent = "box_holder_parent",
		horizontal_alignment = "center",
		size = {
			61,
			99
		},
		position = {
			72,
			-8,
			2
		}
	},
	loot_table_holder = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			236,
			999
		},
		position = {
			1505,
			25,
			10
		}
	},
	reward_box_bg_1 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			106,
			106
		},
		position = {
			1558.5,
			44.5,
			12
		}
	},
	reward_box_bg_2 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			106,
			106
		},
		position = {
			1558.5,
			159.5,
			12
		}
	},
	reward_box_bg_3 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			106,
			106
		},
		position = {
			1558.5,
			274.5,
			12
		}
	},
	reward_box_bg_4 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			106,
			106
		},
		position = {
			1558.5,
			389.5,
			12
		}
	},
	reward_box_bg_5 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			106,
			106
		},
		position = {
			1558.5,
			504.5,
			12
		}
	},
	reward_box_bg_6 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			106,
			106
		},
		position = {
			1558.5,
			619.5,
			12
		}
	},
	reward_box_bg_7 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			106,
			106
		},
		position = {
			1558.5,
			734.5,
			12
		}
	},
	reward_box_bg_8 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			106,
			106
		},
		position = {
			1558.5,
			849.5,
			12
		}
	},
	reward_box_1 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			85,
			85
		},
		position = {
			1569,
			55,
			16
		}
	},
	reward_box_2 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			85,
			85
		},
		position = {
			1569,
			170,
			16
		}
	},
	reward_box_3 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			85,
			85
		},
		position = {
			1569,
			285,
			16
		}
	},
	reward_box_4 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			85,
			85
		},
		position = {
			1569,
			400,
			16
		}
	},
	reward_box_5 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			85,
			85
		},
		position = {
			1569,
			515,
			16
		}
	},
	reward_box_6 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			85,
			85
		},
		position = {
			1569,
			630,
			16
		}
	},
	reward_box_7 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			85,
			85
		},
		position = {
			1569,
			745,
			16
		}
	},
	reward_box_8 = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			85,
			85
		},
		position = {
			1569,
			860,
			16
		}
	},
	reward_title_text = {
		vertical_alignment = "top",
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			800,
			80
		},
		position = {
			0,
			-60,
			-30
		}
	},
	reward_name_text = {
		vertical_alignment = "top",
		parent = "reward_title_text",
		horizontal_alignment = "center",
		size = {
			800,
			80
		},
		position = {
			0,
			-65,
			-30
		}
	},
	reward_type_text = {
		vertical_alignment = "center",
		parent = "reward_name_text",
		horizontal_alignment = "center",
		size = {
			800,
			50
		},
		position = {
			0,
			-50,
			-1
		}
	},
	hero_icon = {
		vertical_alignment = "bottom",
		parent = "reward_type_text",
		horizontal_alignment = "center",
		size = {
			46,
			46
		},
		position = {
			0,
			-40,
			-300
		}
	},
	hero_icon_tooltip = {
		vertical_alignment = "bottom",
		parent = "reward_type_text",
		horizontal_alignment = "center",
		size = {
			46,
			46
		},
		position = {
			0,
			-40,
			5
		}
	},
	trait_button_1 = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			-285,
			-300
		}
	},
	trait_button_2 = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			-285,
			-300
		}
	},
	trait_button_3 = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			-285,
			-300
		}
	},
	trait_button_4 = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			-285,
			-300
		}
	},
	trait_tooltip_1 = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			-285,
			5
		}
	},
	trait_tooltip_2 = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			-285,
			5
		}
	},
	trait_tooltip_3 = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			-285,
			5
		}
	},
	trait_tooltip_4 = {
		vertical_alignment = "top",
		parent = "reward_viewport",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			0,
			-285,
			5
		}
	},
	banner = {
		vertical_alignment = "bottom",
		parent = "overlay",
		horizontal_alignment = "left",
		size = {
			400,
			682
		},
		position = {
			73,
			93,
			2
		}
	},
	banner_title = {
		vertical_alignment = "top",
		parent = "banner",
		horizontal_alignment = "left",
		size = {
			297,
			50
		},
		position = {
			45,
			-25,
			1
		}
	},
	banner_description = {
		vertical_alignment = "top",
		parent = "banner",
		horizontal_alignment = "left",
		size = {
			297,
			300
		},
		position = {
			45,
			-70,
			1
		}
	},
	banner_ratio_title = {
		vertical_alignment = "top",
		parent = "banner",
		horizontal_alignment = "left",
		size = {
			297,
			50
		},
		position = {
			45,
			-230,
			1
		}
	},
	dice_textures = {
		vertical_alignment = "bottom",
		parent = "banner",
		horizontal_alignment = "left",
		size = {
			360,
			100
		},
		position = {
			15,
			35,
			1
		}
	},
	rules_dice_1 = {
		vertical_alignment = "top",
		parent = "banner",
		horizontal_alignment = "left",
		size = {
			42,
			42
		},
		position = {
			45,
			-280,
			1
		}
	},
	rules_dice_2 = {
		vertical_alignment = "top",
		parent = "rules_dice_1",
		horizontal_alignment = "left",
		size = {
			42,
			42
		},
		position = {
			0,
			-62,
			1
		}
	},
	rules_dice_3 = {
		vertical_alignment = "top",
		parent = "rules_dice_2",
		horizontal_alignment = "left",
		size = {
			42,
			42
		},
		position = {
			0,
			-62,
			1
		}
	},
	rules_dice_4 = {
		vertical_alignment = "top",
		parent = "rules_dice_3",
		horizontal_alignment = "left",
		size = {
			42,
			42
		},
		position = {
			0,
			-62,
			1
		}
	},
	rules_dice_successes_1 = {
		vertical_alignment = "center",
		parent = "rules_dice_1",
		horizontal_alignment = "left",
		size = {
			280,
			35
		},
		position = {
			40,
			0,
			1
		}
	},
	rules_dice_successes_2 = {
		vertical_alignment = "center",
		parent = "rules_dice_2",
		horizontal_alignment = "left",
		size = {
			280,
			35
		},
		position = {
			40,
			0,
			1
		}
	},
	rules_dice_successes_3 = {
		vertical_alignment = "center",
		parent = "rules_dice_3",
		horizontal_alignment = "left",
		size = {
			280,
			35
		},
		position = {
			40,
			0,
			1
		}
	},
	rules_dice_successes_4 = {
		vertical_alignment = "center",
		parent = "rules_dice_4",
		horizontal_alignment = "left",
		size = {
			280,
			35
		},
		position = {
			40,
			0,
			1
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
		parent = "overlay",
		horizontal_alignment = "center",
		size = {
			400,
			60
		},
		position = {
			0,
			-260,
			60
		}
	},
	description_text = {
		vertical_alignment = "top",
		parent = "description_title",
		horizontal_alignment = "center",
		size = {
			600,
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
			150,
			1
		}
	},
	preview_frame = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			534,
			598
		},
		position = {
			0,
			-240,
			-6
		}
	},
	preview_frame_background = {
		vertical_alignment = "top",
		parent = "preview_frame",
		horizontal_alignment = "center",
		size = {
			534,
			598
		},
		position = {
			0,
			0,
			-4
		}
	},
	preview_window = {
		vertical_alignment = "top",
		parent = "preview_frame_background",
		horizontal_alignment = "center",
		size = {
			550,
			780
		},
		position = {
			0,
			0,
			0
		}
	},
	preview_trait_root = {
		vertical_alignment = "top",
		parent = "preview_window",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			40,
			-60,
			1
		}
	},
	trait_preview_1 = {
		vertical_alignment = "top",
		parent = "preview_trait_root",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	trait_preview_2 = {
		vertical_alignment = "top",
		parent = "preview_trait_root",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	trait_preview_3 = {
		vertical_alignment = "top",
		parent = "preview_trait_root",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	trait_preview_4 = {
		vertical_alignment = "top",
		parent = "preview_trait_root",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			1
		}
	},
	trait_description_1 = {
		vertical_alignment = "top",
		parent = "trait_preview_1",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			1
		}
	},
	trait_description_2 = {
		vertical_alignment = "top",
		parent = "trait_preview_2",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			1
		}
	},
	trait_description_3 = {
		vertical_alignment = "top",
		parent = "trait_preview_3",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			1
		}
	},
	trait_description_4 = {
		vertical_alignment = "top",
		parent = "trait_preview_4",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			1
		}
	}
}

local function create_dice_success_widget(scenegraph_id)
	return {
		element = {
			passes = {
				{
					pass_type = "centered_texture_amount",
					style_id = "texture",
					texture_id = "texture"
				}
			}
		},
		content = {
			texture = {
				"dice_game_fail_icon",
				"dice_game_fail_icon",
				"dice_game_fail_icon",
				"dice_game_fail_icon",
				"dice_game_fail_icon",
				"dice_game_fail_icon"
			}
		},
		style = {
			texture = {
				texture_axis = 1,
				texture_amount = 6,
				spacing = 0,
				texture_size = {
					35,
					35
				}
			}
		},
		scenegraph_id = scenegraph_id
	}
end

local function create_reward_box(scenegraph_id)
	local defaul_scenegraph = scenegraph_definition[scenegraph_id]
	local default_size = defaul_scenegraph.size
	local pivot = {
		default_size[1]/2,
		default_size[2]/2
	}
	local widget = {
		element = {
			passes = {
				{
					pass_type = "rotated_texture",
					style_id = "background",
					texture_id = "background"
				},
				{
					pass_type = "rotated_texture",
					style_id = "frame",
					texture_id = "frame"
				},
				{
					pass_type = "texture",
					style_id = "fg",
					texture_id = "fg"
				}
			}
		},
		content = {
			frame = "dice_game_icon_frame_01",
			fg = "dice_game_icon_backside",
			background = "dice_game_icon_03"
		},
		style = {
			background = {
				angle = (scenegraph_id == "reward_box_final" and -(math.pi/2)) or 0,
				pivot = pivot,
				size = default_size,
				offset = {
					0,
					0,
					0
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			frame = {
				angle = (scenegraph_id == "reward_box_final" and -(math.pi/2)) or 0,
				pivot = pivot,
				size = default_size,
				offset = {
					0,
					0,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			fg = {
				offset = {
					0,
					0,
					2
				},
				color = {
					255,
					255,
					255,
					255
				}
			}
		},
		scenegraph_id = scenegraph_id
	}

	return widget
end

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
local widgets = {
	gamepad_continue_text = UIWidgets.create_simple_text("", "gamepad_continue_text", 42, Colors.get_color_table_with_alpha("cheeseburger", 255)),
	lock_bg_left = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_11", 0, {
		167,
		166.5
	}, "lock_bg_left"),
	lock_bg_right = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_11", math.pi, {
		0,
		166.5
	}, "lock_bg_right"),
	lock_pillar_left = UIWidgets.create_simple_texture("dice_game_lock_part_13", "lock_pillar_left"),
	lock_pillar_right = UIWidgets.create_simple_uv_texture("dice_game_lock_part_13", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "lock_pillar_right"),
	lock_pillar_top = UIWidgets.create_simple_texture("dice_game_lock_part_12", "lock_pillar_top"),
	lock_pillar_bottom = UIWidgets.create_simple_uv_texture("dice_game_lock_part_12", {
		{
			0,
			1
		},
		{
			1,
			0
		}
	}, "lock_pillar_bottom"),
	lock_cogwheel_bg_left = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_05", 0, {
		170,
		171
	}, "lock_cogwheel_bg_left"),
	lock_cogwheel_bg_right = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_06", 0, {
		0,
		171
	}, "lock_cogwheel_bg_right"),
	lock_cogwheel_left = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_07", 0, {
		158,
		158
	}, "lock_cogwheel_left"),
	lock_cogwheel_right = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_08", 0, {
		0,
		158
	}, "lock_cogwheel_right"),
	lock_stick_top_left = UIWidgets.create_simple_texture("dice_game_lock_part_14", "lock_stick_top_left"),
	lock_stick_top_right = UIWidgets.create_simple_uv_texture("dice_game_lock_part_14", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "lock_stick_top_right"),
	lock_stick_bottom_left = UIWidgets.create_simple_texture("dice_game_lock_part_15", "lock_stick_bottom_left"),
	lock_stick_bottom_right = UIWidgets.create_simple_uv_texture("dice_game_lock_part_15", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "lock_stick_bottom_right"),
	lock_cover_top_left = UIWidgets.create_simple_texture("dice_game_lock_part_01", "lock_cover_top_left"),
	lock_cover_top_right = UIWidgets.create_simple_texture("dice_game_lock_part_03", "lock_cover_top_right"),
	lock_cover_bottom_left = UIWidgets.create_simple_texture("dice_game_lock_part_02", "lock_cover_bottom_left"),
	lock_cover_bottom_right = UIWidgets.create_simple_texture("dice_game_lock_part_04", "lock_cover_bottom_right"),
	lock_block_left = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_09", 0, {
		153,
		74.5
	}, "lock_block_left"),
	lock_block_right = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_09", math.pi, {
		153,
		74.5
	}, "lock_block_right"),
	lock_slot_holder_left = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_10", 0, {
		52,
		151
	}, "lock_slot_holder_left"),
	lock_slot_holder_right = UIWidgets.create_simple_rotated_texture("dice_game_lock_part_10_02", 0, {
		0,
		151.5
	}, "lock_slot_holder_right"),
	roll_button = UIWidgets.create_dice_game_button("roll_button"),
	roll_button_eye_glow = UIWidgets.create_simple_texture("forge_button_03_glow_effect", "roll_button_eye_glow"),
	loot_table_holder = UIWidgets.create_simple_texture("dice_game_loot_table_holder", "loot_table_holder"),
	reward_box_bg_1 = UIWidgets.create_simple_texture("dice_game_icon_slot_01", "reward_box_bg_1"),
	reward_box_bg_2 = UIWidgets.create_simple_texture("dice_game_icon_slot_01", "reward_box_bg_2"),
	reward_box_bg_3 = UIWidgets.create_simple_texture("dice_game_icon_slot_01", "reward_box_bg_3"),
	reward_box_bg_4 = UIWidgets.create_simple_texture("dice_game_icon_slot_01", "reward_box_bg_4"),
	reward_box_bg_5 = UIWidgets.create_simple_texture("dice_game_icon_slot_01", "reward_box_bg_5"),
	reward_box_bg_6 = UIWidgets.create_simple_texture("dice_game_icon_slot_01", "reward_box_bg_6"),
	reward_box_bg_7 = UIWidgets.create_simple_texture("dice_game_icon_slot_01", "reward_box_bg_7"),
	reward_box_bg_8 = UIWidgets.create_simple_texture("dice_game_icon_slot_01", "reward_box_bg_8"),
	reward_box_1 = create_reward_box("reward_box_1"),
	reward_box_2 = create_reward_box("reward_box_2"),
	reward_box_3 = create_reward_box("reward_box_3"),
	reward_box_4 = create_reward_box("reward_box_4"),
	reward_box_5 = create_reward_box("reward_box_5"),
	reward_box_6 = create_reward_box("reward_box_6"),
	reward_box_7 = create_reward_box("reward_box_7"),
	reward_box_8 = create_reward_box("reward_box_8"),
	reward_box_final = create_reward_box("reward_box_final"),
	box_holder_bg = UIWidgets.create_simple_texture("dice_game_holder", "box_holder_bg"),
	box_holder_left = UIWidgets.create_simple_texture("dice_game_icon_holder_03", "box_holder_left"),
	box_holder_right = UIWidgets.create_uv_texture_with_style("dice_game_icon_holder_03", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}, "box_holder_right", {
		offset = {
			0,
			1,
			0
		},
		color = {
			255,
			255,
			255,
			255
		}
	}),
	reward_viewport = {
		scenegraph_id = "reward_viewport",
		element = UIElements.Viewport,
		style = {
			viewport = {
				layer = 985,
				level_name = "levels/ui_loot_preview/world",
				viewport_name = "reward_preview_viewport",
				world_name = "reward_preview",
				camera_position = {
					0,
					3,
					1.4
				},
				camera_lookat = {
					0,
					0,
					1
				}
			}
		},
		content = {
			button_hotspot = {}
		}
	},
	hero_icon = UIWidgets.create_simple_texture("hero_icon_medium_dwarf_ranger_yellow", "hero_icon"),
	hero_icon_tooltip = UIWidgets.create_simple_tooltip("", "hero_icon_tooltip", nil, default_tooltip_style),
	trait_button_1 = UIWidgets.create_small_trait_button("trait_button_1", "trait_button_1"),
	trait_button_2 = UIWidgets.create_small_trait_button("trait_button_2", "trait_button_2"),
	trait_button_3 = UIWidgets.create_small_trait_button("trait_button_3", "trait_button_3"),
	trait_button_4 = UIWidgets.create_small_trait_button("trait_button_4", "trait_button_4"),
	trait_tooltip_1 = UIWidgets.create_simple_tooltip("", "trait_tooltip_1", nil, trait_tooltip_style),
	trait_tooltip_2 = UIWidgets.create_simple_tooltip("", "trait_tooltip_2", nil, trait_tooltip_style),
	trait_tooltip_3 = UIWidgets.create_simple_tooltip("", "trait_tooltip_3", nil, trait_tooltip_style),
	trait_tooltip_4 = UIWidgets.create_simple_tooltip("", "trait_tooltip_4", nil, trait_tooltip_style),
	reward_title_text = UIWidgets.create_simple_text("dice_game_reward_title", "reward_title_text", 52, Colors.get_color_table_with_alpha("cheeseburger", 0), nil, "hell_shark_header"),
	reward_name_text = UIWidgets.create_simple_text("", "reward_name_text", 56, Colors.get_color_table_with_alpha("white", 0), nil, "hell_shark_header"),
	reward_type_text = UIWidgets.create_simple_text("", "reward_type_text", 24, Colors.get_color_table_with_alpha("cheeseburger", 0)),
	banner = UIWidgets.create_simple_texture("dice_game_text_bg", "banner"),
	banner_title = UIWidgets.create_simple_text("dice_game_title", "banner_title", nil, nil, {
		vertical_alignment = "top",
		font_size = 32,
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
	banner_description = UIWidgets.create_simple_text("dice_game_text_rules", "banner_description", nil, nil, {
		vertical_alignment = "top",
		font_size = 18,
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
	}),
	banner_ratio_title = UIWidgets.create_simple_text("dice_game_dice_ratio_title", "banner_ratio_title", nil, nil, {
		vertical_alignment = "bottom",
		font_size = 28,
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
	rules_dice_1 = UIWidgets.create_simple_texture("dice_01", "rules_dice_1"),
	rules_dice_2 = UIWidgets.create_simple_texture("dice_02", "rules_dice_2"),
	rules_dice_3 = UIWidgets.create_simple_texture("dice_04", "rules_dice_3"),
	rules_dice_4 = UIWidgets.create_simple_texture("dice_05", "rules_dice_4"),
	rules_dice_successes_1 = create_dice_success_widget("rules_dice_successes_1"),
	rules_dice_successes_2 = create_dice_success_widget("rules_dice_successes_2"),
	rules_dice_successes_3 = create_dice_success_widget("rules_dice_successes_3"),
	rules_dice_successes_4 = create_dice_success_widget("rules_dice_successes_4"),
	description_background = UIWidgets.create_simple_texture("gradient_credits_menu", "description_background"),
	description_title = UIWidgets.create_simple_text("dice_game_title", "description_title", nil, nil, {
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
	description_text = UIWidgets.create_simple_text("dice_game_text", "description_text", nil, nil, {
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
	}),
	dices = {
		scenegraph_id = "dice_textures",
		element = {
			passes = {
				{
					pass_type = "centered_texture_amount",
					style_id = "dice_textures",
					texture_id = "dice_textures"
				},
				{
					texture_id = "background",
					style_id = "background",
					pass_type = "rounded_background"
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text"
				}
			}
		},
		content = {
			text = "dice_game_player_dice_title",
			dice_textures = {
				"dice_01",
				"dice_01",
				"dice_01",
				"dice_01",
				"dice_01",
				"dice_01",
				"dice_01"
			}
		},
		style = {
			dice_textures = {
				texture_axis = 1,
				texture_amount = 7,
				spacing = 8,
				texture_size = {
					42,
					42
				}
			},
			background = {
				corner_radius = 3,
				offset = {
					0,
					-5,
					-1
				},
				color = Colors.get_color_table_with_alpha("black", 0)
			},
			text = {
				vertical_alignment = "top",
				horizontal_alignment = "center",
				localize = true,
				font_size = 28,
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					-5,
					1
				}
			}
		}
	},
	door_left = {
		scenegraph_id = "door_left",
		element = {
			passes = {
				{
					style_id = "background",
					pass_type = "texture_uv",
					content_id = "background"
				}
			}
		},
		content = {
			background = {
				texture_id = "dice_game_gate_left",
				uvs = {
					{
						0,
						0
					},
					{
						1,
						1
					}
				}
			}
		},
		style = {
			background = {
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	door_right = {
		scenegraph_id = "door_right",
		element = {
			passes = {
				{
					style_id = "background",
					pass_type = "texture_uv",
					content_id = "background"
				}
			}
		},
		content = {
			background = {
				texture_id = "dice_game_gate_right",
				uvs = {
					{
						0,
						0
					},
					{
						1,
						1
					}
				}
			}
		},
		style = {
			background = {
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	fake_lock_left = {
		scenegraph_id = "fl_left_root",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "background",
					texture_id = "background"
				},
				{
					pass_type = "texture",
					style_id = "cover_top",
					texture_id = "cover_top"
				},
				{
					pass_type = "texture",
					style_id = "cover_bottom",
					texture_id = "cover_bottom"
				},
				{
					pass_type = "texture",
					style_id = "left_pillar",
					texture_id = "left_pillar"
				},
				{
					pass_type = "texture",
					style_id = "top_pillar",
					texture_id = "top_pillar"
				},
				{
					style_id = "bottom_pillar",
					pass_type = "texture_uv",
					content_id = "bottom_pillar"
				}
			}
		},
		content = {
			top_pillar = "dice_game_lock_part_12_left",
			background = "dice_game_lock_part_05",
			left_pillar = "dice_game_lock_part_13",
			cover_top = "dice_game_lock_part_01",
			cover_bottom = "dice_game_lock_part_02",
			bottom_pillar = {
				texture_id = "dice_game_lock_part_12_left",
				uvs = {
					{
						0,
						1
					},
					{
						1,
						0
					}
				}
			}
		},
		style = {
			background = {
				scenegraph_id = "fl_left_bg"
			},
			cover_top = {
				scenegraph_id = "fl_left_cover_top"
			},
			cover_bottom = {
				scenegraph_id = "fl_left_cover_bottom"
			},
			left_pillar = {
				scenegraph_id = "fl_left_pillar_left"
			},
			top_pillar = {
				scenegraph_id = "fl_left_pillar_top"
			},
			bottom_pillar = {
				scenegraph_id = "fl_left_pillar_bottom"
			}
		}
	},
	right_fake_lock = {
		scenegraph_id = "fl_right_root",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "background",
					texture_id = "background"
				},
				{
					pass_type = "texture",
					style_id = "cover_top",
					texture_id = "cover_top"
				},
				{
					pass_type = "texture",
					style_id = "cover_bottom",
					texture_id = "cover_bottom"
				},
				{
					style_id = "right_pillar",
					pass_type = "texture_uv",
					content_id = "right_pillar"
				},
				{
					pass_type = "texture",
					style_id = "top_pillar",
					texture_id = "top_pillar"
				},
				{
					style_id = "bottom_pillar",
					pass_type = "texture_uv",
					content_id = "bottom_pillar"
				}
			}
		},
		content = {
			top_pillar = "dice_game_lock_part_12_right",
			background = "dice_game_lock_part_06",
			cover_top = "dice_game_lock_part_03",
			cover_bottom = "dice_game_lock_part_04",
			bottom_pillar = {
				texture_id = "dice_game_lock_part_12_right",
				uvs = {
					{
						0,
						1
					},
					{
						1,
						0
					}
				}
			},
			right_pillar = {
				texture_id = "dice_game_lock_part_13",
				uvs = {
					{
						1,
						0
					},
					{
						0,
						1
					}
				}
			}
		},
		style = {
			background = {
				scenegraph_id = "fl_right_bg"
			},
			cover_top = {
				scenegraph_id = "fl_right_cover_top"
			},
			cover_bottom = {
				scenegraph_id = "fl_right_cover_bottom"
			},
			right_pillar = {
				scenegraph_id = "fl_right_pillar_right"
			},
			top_pillar = {
				scenegraph_id = "fl_right_pillar_top"
			},
			bottom_pillar = {
				scenegraph_id = "fl_right_pillar_bottom"
			}
		}
	},
	preview_frame = UIWidgets.create_simple_frame("gold_frame_01_complete", {
		198,
		199
	}, {
		66,
		66
	}, {
		12,
		66
	}, {
		66,
		12
	}, "preview_frame"),
	preview_frame_background = UIWidgets.create_simple_uv_texture("compare_window_bg_large", {
		{
			0,
			0.27
		},
		{
			1,
			0.73
		}
	}, "preview_frame_background"),
	trait_preview_1 = UIWidgets.create_compare_menu_trait_widget("trait_preview_1", "trait_description_1"),
	trait_preview_2 = UIWidgets.create_compare_menu_trait_widget("trait_preview_2", "trait_description_2"),
	trait_preview_3 = UIWidgets.create_compare_menu_trait_widget("trait_preview_3", "trait_description_3"),
	trait_preview_4 = UIWidgets.create_compare_menu_trait_widget("trait_preview_4", "trait_description_4")
}
local lock_open_time_multiplier = 0.5
local animations = {
	lock_open = {
		{
			name = "sticks_open",
			start_progress = lock_open_time_multiplier*0,
			end_progress = lock_open_time_multiplier*0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local lock_stick_top_left_position = ui_scenegraph.lock_stick_top_left.local_position
				lock_stick_top_left_position = scenegraph_definition.lock_stick_top_left.position
				local lock_stick_top_right_position = ui_scenegraph.lock_stick_top_right.local_position
				local lock_stick_top_right_default_position = scenegraph_definition.lock_stick_top_right.position
				lock_stick_top_right_position[1] = lock_stick_top_right_default_position[1]
				lock_stick_top_right_position[2] = lock_stick_top_right_default_position[2]
				local lock_stick_bottom_left_position = ui_scenegraph.lock_stick_bottom_left.local_position
				local lock_stick_bottom_left_default_position = scenegraph_definition.lock_stick_bottom_left.position
				lock_stick_bottom_left_position[1] = lock_stick_bottom_left_default_position[1]
				lock_stick_bottom_left_position[2] = lock_stick_bottom_left_default_position[2]
				local lock_stick_bottom_right_position = ui_scenegraph.lock_stick_bottom_right.local_position
				local lock_stick_bottom_right_default_position = scenegraph_definition.lock_stick_bottom_right.position
				lock_stick_bottom_right_position[1] = lock_stick_bottom_right_default_position[1]
				lock_stick_bottom_right_position[2] = lock_stick_bottom_right_default_position[2]
				local lock_cover_top_left_position = ui_scenegraph.lock_cover_top_left.local_position
				local lock_cover_top_left_default_position = scenegraph_definition.lock_cover_top_left.position
				lock_cover_top_left_position[1] = lock_cover_top_left_default_position[1]
				lock_cover_top_left_position[2] = lock_cover_top_left_default_position[2]
				local lock_cover_top_right_position = ui_scenegraph.lock_cover_top_right.local_position
				local lock_cover_top_right_default_position = scenegraph_definition.lock_cover_top_right.position
				lock_cover_top_right_position[1] = lock_cover_top_right_default_position[1]
				lock_cover_top_right_position[2] = lock_cover_top_right_default_position[2]
				local lock_cover_bottom_left_position = ui_scenegraph.lock_cover_bottom_left.local_position
				local lock_cover_bottom_left_default_position = scenegraph_definition.lock_cover_bottom_left.position
				lock_cover_bottom_left_position[1] = lock_cover_bottom_left_default_position[1]
				lock_cover_bottom_left_position[2] = lock_cover_bottom_left_default_position[2]
				local lock_cover_bottom_right_position = ui_scenegraph.lock_cover_bottom_right.local_position
				local lock_cover_bottom_right_default_position = scenegraph_definition.lock_cover_bottom_right.position
				lock_cover_bottom_right_position[1] = lock_cover_bottom_right_default_position[1]
				lock_cover_bottom_right_position[2] = lock_cover_bottom_right_default_position[2]
				local lock_pillar_left_position = ui_scenegraph.lock_pillar_left.local_position
				local lock_pillar_left_default_position = scenegraph_definition.lock_pillar_left.position
				lock_pillar_left_position[1] = lock_pillar_left_default_position[1]
				local lock_pillar_right_position = ui_scenegraph.lock_pillar_right.local_position
				local lock_pillar_right_default_position = scenegraph_definition.lock_pillar_right.position
				lock_pillar_right_position[1] = lock_pillar_right_default_position[1]
				local lock_pillar_top_position = ui_scenegraph.lock_pillar_top.local_position
				local lock_pillar_top_default_position = scenegraph_definition.lock_pillar_top.position
				lock_pillar_top_position[2] = lock_pillar_top_default_position[2]
				local lock_pillar_bottom_position = ui_scenegraph.lock_pillar_bottom.local_position
				local lock_pillar_bottom_default_position = scenegraph_definition.lock_pillar_bottom.position
				lock_pillar_bottom_position[2] = lock_pillar_bottom_default_position[2]
				widgets.lock_cogwheel_left.style.texture_id.angle = 0
				widgets.lock_cogwheel_right.style.texture_id.angle = 0
				widgets.lock_slot_holder_left.style.texture_id.angle = 0
				widgets.lock_slot_holder_right.style.texture_id.angle = 0
				widgets.lock_block_left.style.texture_id.angle = 0
				widgets.lock_block_right.style.texture_id.angle = math.pi
				widgets.lock_cogwheel_bg_left.style.texture_id.angle = 0
				widgets.lock_cogwheel_bg_right.style.texture_id.angle = 0

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local value = math.easeCubic(local_progress)
				local move_distance = 50
				local lock_stick_top_left_position = ui_scenegraph.lock_stick_top_left.local_position
				local lock_stick_top_left_default_position = scenegraph_definition.lock_stick_top_left.position
				local lock_stick_top_right_position = ui_scenegraph.lock_stick_top_right.local_position
				local lock_stick_top_right_default_position = scenegraph_definition.lock_stick_top_right.position
				local lock_stick_bottom_left_position = ui_scenegraph.lock_stick_bottom_left.local_position
				local lock_stick_bottom_left_default_position = scenegraph_definition.lock_stick_bottom_left.position
				local lock_stick_bottom_right_position = ui_scenegraph.lock_stick_bottom_right.local_position
				local lock_stick_bottom_right_default_position = scenegraph_definition.lock_stick_bottom_right.position
				lock_stick_top_left_position[1] = lock_stick_top_left_default_position[1] - move_distance*value
				lock_stick_top_left_position[2] = lock_stick_top_left_default_position[2] + move_distance*value
				lock_stick_top_right_position[1] = lock_stick_top_right_default_position[1] + move_distance*value
				lock_stick_top_right_position[2] = lock_stick_top_right_default_position[2] + move_distance*value
				lock_stick_bottom_left_position[1] = lock_stick_bottom_left_default_position[1] - move_distance*value
				lock_stick_bottom_left_position[2] = lock_stick_bottom_left_default_position[2] - move_distance*value
				lock_stick_bottom_right_position[1] = lock_stick_bottom_right_default_position[1] + move_distance*value
				lock_stick_bottom_right_position[2] = lock_stick_bottom_right_default_position[2] - move_distance*value

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "cover_open",
			start_progress = lock_open_time_multiplier*0.7,
			end_progress = lock_open_time_multiplier*1.3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local move_distance = 90
				local value = math.easeOutCubic(local_progress)
				local lock_cover_top_left_position = ui_scenegraph.lock_cover_top_left.local_position
				local lock_cover_top_left_default_position = scenegraph_definition.lock_cover_top_left.position
				local lock_cover_top_right_position = ui_scenegraph.lock_cover_top_right.local_position
				local lock_cover_top_right_default_position = scenegraph_definition.lock_cover_top_right.position
				local lock_cover_bottom_left_position = ui_scenegraph.lock_cover_bottom_left.local_position
				local lock_cover_bottom_left_default_position = scenegraph_definition.lock_cover_bottom_left.position
				local lock_cover_bottom_right_position = ui_scenegraph.lock_cover_bottom_right.local_position
				local lock_cover_bottom_right_default_position = scenegraph_definition.lock_cover_bottom_right.position
				lock_cover_top_left_position[1] = lock_cover_top_left_default_position[1] - move_distance*value
				lock_cover_top_left_position[2] = lock_cover_top_left_default_position[2] + move_distance*value
				lock_cover_top_right_position[1] = lock_cover_top_right_default_position[1] + move_distance*value
				lock_cover_top_right_position[2] = lock_cover_top_right_default_position[2] + move_distance*value
				lock_cover_bottom_left_position[1] = lock_cover_bottom_left_default_position[1] - move_distance*value
				lock_cover_bottom_left_position[2] = lock_cover_bottom_left_default_position[2] - move_distance*value
				lock_cover_bottom_right_position[1] = lock_cover_bottom_right_default_position[1] + move_distance*value
				lock_cover_bottom_right_position[2] = lock_cover_bottom_right_default_position[2] - move_distance*value
				local block_angle = math.pi*4*value
				local lock_block_left_widget = widgets.lock_block_left
				local lock_block_right_widget = widgets.lock_block_right
				lock_block_left_widget.style.texture_id.angle = block_angle
				lock_block_right_widget.style.texture_id.angle = block_angle + math.pi

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "top_and_bottom_pillar_lock",
			start_progress = lock_open_time_multiplier*1.3,
			end_progress = lock_open_time_multiplier*1.4,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local move_distance = 28
				local value = math.ease_in_exp(local_progress)
				local lock_pillar_top_position = ui_scenegraph.lock_pillar_top.local_position
				local lock_pillar_top_default_position = scenegraph_definition.lock_pillar_top.position
				local lock_pillar_bottom_position = ui_scenegraph.lock_pillar_bottom.local_position
				local lock_pillar_bottom_default_position = scenegraph_definition.lock_pillar_bottom.position
				lock_pillar_top_position[2] = lock_pillar_top_default_position[2] + move_distance*value
				lock_pillar_bottom_position[2] = lock_pillar_bottom_default_position[2] - move_distance*value

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "cogwheel_bg_spin",
			start_progress = lock_open_time_multiplier*1.5,
			end_progress = lock_open_time_multiplier*1.9,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local value = math.easeCubic(local_progress)
				local lock_cogwheel_bg_left_widget = widgets.lock_cogwheel_bg_left
				local lock_cogwheel_bg_right_widget = widgets.lock_cogwheel_bg_right
				local angle = math.pi*0.5*value
				lock_cogwheel_bg_left_widget.style.texture_id.angle = angle
				lock_cogwheel_bg_right_widget.style.texture_id.angle = angle

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "cogwheel_spin",
			start_progress = lock_open_time_multiplier*2,
			end_progress = lock_open_time_multiplier*3,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local cogwheel_value = math.ease_exp(local_progress)
				local center_value = math.easeInCubic(local_progress)
				local lock_slot_holder_left_widget = widgets.lock_slot_holder_left
				local lock_slot_holder_right_widget = widgets.lock_slot_holder_right
				local lock_cogwheel_left_widget = widgets.lock_cogwheel_left
				local lock_cogwheel_right_widget = widgets.lock_cogwheel_right
				local center_angle = math.pi/2*center_value
				local cogwheel_angle = math.pi*2*cogwheel_value
				lock_slot_holder_left_widget.style.texture_id.angle = -center_angle
				lock_slot_holder_right_widget.style.texture_id.angle = -center_angle
				lock_cogwheel_left_widget.style.texture_id.angle = cogwheel_angle
				lock_cogwheel_right_widget.style.texture_id.angle = cogwheel_angle

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "left_and_right_pillar_lock",
			start_progress = lock_open_time_multiplier*3,
			end_progress = lock_open_time_multiplier*3.1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local move_distance = 28
				local value = math.ease_in_exp(local_progress)
				local lock_pillar_left_position = ui_scenegraph.lock_pillar_left.local_position
				local lock_pillar_left_default_position = scenegraph_definition.lock_pillar_left.position
				local lock_pillar_right_position = ui_scenegraph.lock_pillar_right.local_position
				local lock_pillar_right_default_position = scenegraph_definition.lock_pillar_right.position
				lock_pillar_left_position[1] = lock_pillar_left_default_position[1] - move_distance*value
				lock_pillar_right_position[1] = lock_pillar_right_default_position[1] + move_distance*value

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	lock_close = {
		{
			name = "sticks_open",
			start_progress = 2.6,
			end_progress = 3.1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local value = math.easeCubic(local_progress - 1)
				local move_distance = 50
				local lock_stick_top_left_position = ui_scenegraph.lock_stick_top_left.local_position
				local lock_stick_top_left_default_position = scenegraph_definition.lock_stick_top_left.position
				local lock_stick_top_right_position = ui_scenegraph.lock_stick_top_right.local_position
				local lock_stick_top_right_default_position = scenegraph_definition.lock_stick_top_right.position
				local lock_stick_bottom_left_position = ui_scenegraph.lock_stick_bottom_left.local_position
				local lock_stick_bottom_left_default_position = scenegraph_definition.lock_stick_bottom_left.position
				local lock_stick_bottom_right_position = ui_scenegraph.lock_stick_bottom_right.local_position
				local lock_stick_bottom_right_default_position = scenegraph_definition.lock_stick_bottom_right.position
				lock_stick_top_left_position[1] = lock_stick_top_left_default_position[1] - move_distance*value
				lock_stick_top_left_position[2] = lock_stick_top_left_default_position[2] + move_distance*value
				lock_stick_top_right_position[1] = lock_stick_top_right_default_position[1] + move_distance*value
				lock_stick_top_right_position[2] = lock_stick_top_right_default_position[2] + move_distance*value
				lock_stick_bottom_left_position[1] = lock_stick_bottom_left_default_position[1] - move_distance*value
				lock_stick_bottom_left_position[2] = lock_stick_bottom_left_default_position[2] - move_distance*value
				lock_stick_bottom_right_position[1] = lock_stick_bottom_right_default_position[1] + move_distance*value
				lock_stick_bottom_right_position[2] = lock_stick_bottom_right_default_position[2] - move_distance*value

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "cover_open",
			start_progress = 1.8,
			end_progress = 2.4,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local move_distance = 90
				local value = math.easeOutCubic(local_progress - 1)
				local lock_cover_top_left_position = ui_scenegraph.lock_cover_top_left.local_position
				local lock_cover_top_left_default_position = scenegraph_definition.lock_cover_top_left.position
				local lock_cover_top_right_position = ui_scenegraph.lock_cover_top_right.local_position
				local lock_cover_top_right_default_position = scenegraph_definition.lock_cover_top_right.position
				local lock_cover_bottom_left_position = ui_scenegraph.lock_cover_bottom_left.local_position
				local lock_cover_bottom_left_default_position = scenegraph_definition.lock_cover_bottom_left.position
				local lock_cover_bottom_right_position = ui_scenegraph.lock_cover_bottom_right.local_position
				local lock_cover_bottom_right_default_position = scenegraph_definition.lock_cover_bottom_right.position
				lock_cover_top_left_position[1] = lock_cover_top_left_default_position[1] - move_distance*value
				lock_cover_top_left_position[2] = lock_cover_top_left_default_position[2] + move_distance*value
				lock_cover_top_right_position[1] = lock_cover_top_right_default_position[1] + move_distance*value
				lock_cover_top_right_position[2] = lock_cover_top_right_default_position[2] + move_distance*value
				lock_cover_bottom_left_position[1] = lock_cover_bottom_left_default_position[1] - move_distance*value
				lock_cover_bottom_left_position[2] = lock_cover_bottom_left_default_position[2] - move_distance*value
				lock_cover_bottom_right_position[1] = lock_cover_bottom_right_default_position[1] + move_distance*value
				lock_cover_bottom_right_position[2] = lock_cover_bottom_right_default_position[2] - move_distance*value
				local block_angle = math.pi*4*value
				local lock_block_left_widget = widgets.lock_block_left
				local lock_block_right_widget = widgets.lock_block_right
				lock_block_left_widget.style.texture_id.angle = block_angle
				lock_block_right_widget.style.texture_id.angle = block_angle + math.pi

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "top_and_bottom_pillar_lock",
			start_progress = 1.7,
			end_progress = 1.8,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local move_distance = 28
				local value = math.ease_in_exp(local_progress - 1)
				local lock_pillar_top_position = ui_scenegraph.lock_pillar_top.local_position
				local lock_pillar_top_default_position = scenegraph_definition.lock_pillar_top.position
				local lock_pillar_bottom_position = ui_scenegraph.lock_pillar_bottom.local_position
				local lock_pillar_bottom_default_position = scenegraph_definition.lock_pillar_bottom.position
				lock_pillar_top_position[2] = lock_pillar_top_default_position[2] + move_distance*value
				lock_pillar_bottom_position[2] = lock_pillar_bottom_default_position[2] - move_distance*value

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "cogwheel_bg_spin",
			start_progress = 1.2,
			end_progress = 1.6,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local value = math.easeCubic(local_progress - 1)
				local lock_cogwheel_bg_left_widget = widgets.lock_cogwheel_bg_left
				local lock_cogwheel_bg_right_widget = widgets.lock_cogwheel_bg_right
				local angle = math.pi*0.5*value
				lock_cogwheel_bg_left_widget.style.texture_id.angle = angle
				lock_cogwheel_bg_right_widget.style.texture_id.angle = angle

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "cogwheel_spin",
			start_progress = 0.1,
			end_progress = 1.1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local cogwheel_value = math.ease_exp(local_progress - 1)
				local center_value = math.easeInCubic(local_progress - 1)
				local lock_slot_holder_left_widget = widgets.lock_slot_holder_left
				local lock_slot_holder_right_widget = widgets.lock_slot_holder_right
				local reward_box_final_widget = widgets.reward_box_final_widget
				local lock_cogwheel_left_widget = widgets.lock_cogwheel_left
				local lock_cogwheel_right_widget = widgets.lock_cogwheel_right
				local center_angle = math.pi/2*center_value
				local cogwheel_angle = math.pi*2*cogwheel_value
				lock_slot_holder_left_widget.style.texture_id.angle = -center_angle
				lock_slot_holder_right_widget.style.texture_id.angle = -center_angle
				reward_box_final_widget.style.frame.angle = -center_angle
				reward_box_final_widget.style.background.angle = -center_angle
				lock_cogwheel_left_widget.style.texture_id.angle = cogwheel_angle
				lock_cogwheel_right_widget.style.texture_id.angle = cogwheel_angle

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local reward_box_final_widget = widgets.reward_box_final_widget
				reward_box_final_widget.style.frame.angle = 0
				reward_box_final_widget.style.background.angle = 0

				return 
			end
		},
		{
			name = "left_and_right_pillar_lock",
			start_progress = 0,
			end_progress = 0.1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local move_distance = 28
				local value = math.ease_in_exp(local_progress - 1)
				local lock_pillar_left_position = ui_scenegraph.lock_pillar_left.local_position
				local lock_pillar_left_default_position = scenegraph_definition.lock_pillar_left.position
				local lock_pillar_right_position = ui_scenegraph.lock_pillar_right.local_position
				local lock_pillar_right_default_position = scenegraph_definition.lock_pillar_right.position
				lock_pillar_left_position[1] = lock_pillar_left_default_position[1] - move_distance*value
				lock_pillar_right_position[1] = lock_pillar_right_default_position[1] + move_distance*value

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
	animations = animations,
	widgets = widgets
}
